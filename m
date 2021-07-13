Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF7F83C6D48
	for <lists+bpf@lfdr.de>; Tue, 13 Jul 2021 11:25:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235126AbhGMJ2G (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 13 Jul 2021 05:28:06 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:10474 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234947AbhGMJ2F (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 13 Jul 2021 05:28:05 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4GPFWm4klhzccwf;
        Tue, 13 Jul 2021 17:21:56 +0800 (CST)
Received: from dggpemm500005.china.huawei.com (7.185.36.74) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 13 Jul 2021 17:25:13 +0800
Received: from localhost.localdomain (10.69.192.56) by
 dggpemm500005.china.huawei.com (7.185.36.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 13 Jul 2021 17:25:12 +0800
From:   Yunsheng Lin <linyunsheng@huawei.com>
To:     <davem@davemloft.net>, <kuba@kernel.org>
CC:     <alexander.duyck@gmail.com>, <linux@armlinux.org.uk>,
        <mw@semihalf.com>, <linuxarm@openeuler.org>,
        <yisen.zhuang@huawei.com>, <salil.mehta@huawei.com>,
        <thomas.petazzoni@bootlin.com>, <hawk@kernel.org>,
        <ilias.apalodimas@linaro.org>, <ast@kernel.org>,
        <daniel@iogearbox.net>, <john.fastabend@gmail.com>,
        <akpm@linux-foundation.org>, <peterz@infradead.org>,
        <will@kernel.org>, <willy@infradead.org>, <vbabka@suse.cz>,
        <fenghua.yu@intel.com>, <guro@fb.com>, <peterx@redhat.com>,
        <feng.tang@intel.com>, <jgg@ziepe.ca>, <mcroce@microsoft.com>,
        <hughd@google.com>, <jonathan.lemon@gmail.com>, <alobakin@pm.me>,
        <willemb@google.com>, <wenxu@ucloud.cn>, <cong.wang@bytedance.com>,
        <haokexin@gmail.com>, <nogikh@google.com>, <elver@google.com>,
        <yhs@fb.com>, <kpsingh@kernel.org>, <andrii@kernel.org>,
        <kafai@fb.com>, <songliubraving@fb.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>
Subject: [PATCH rfc v4 3/4] page_pool: add frag page recycling support in page pool
Date:   Tue, 13 Jul 2021 17:24:31 +0800
Message-ID: <1626168272-25622-4-git-send-email-linyunsheng@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1626168272-25622-1-git-send-email-linyunsheng@huawei.com>
References: <1626168272-25622-1-git-send-email-linyunsheng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500005.china.huawei.com (7.185.36.74)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Currently page pool only support page recycling only when
there is only one user of the page, and the split page
reusing implemented in the most driver can not use the
page pool as bing-pong way of reusing requires the multi
user support in page pool.

Those reusing or recycling has below limitations:
1. page from page pool can only be used be one user in order
   for the page recycling to happen.
2. Bing-pong way of reusing in most driver does not support
   multi desc using different part of the same page in order
   to save memory.

So add multi-users support and frag page recycling in page pool
to overcome the above limitation.

Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
---
 include/net/page_pool.h |  22 +++++++++-
 net/core/page_pool.c    | 104 ++++++++++++++++++++++++++++++++++++++++++------
 2 files changed, 112 insertions(+), 14 deletions(-)

diff --git a/include/net/page_pool.h b/include/net/page_pool.h
index 315b9f2..dd4bb90 100644
--- a/include/net/page_pool.h
+++ b/include/net/page_pool.h
@@ -45,7 +45,10 @@
 					* Please note DMA-sync-for-CPU is still
 					* device driver responsibility
 					*/
-#define PP_FLAG_ALL		(PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV)
+#define PP_FLAG_PAGE_FRAG	BIT(2)	/* for page frag feature */
+#define PP_FLAG_ALL		(PP_FLAG_DMA_MAP |\
+				 PP_FLAG_DMA_SYNC_DEV |\
+				 PP_FLAG_PAGE_FRAG)
 
 /*
  * Fast allocation side cache array/stack
@@ -88,6 +91,9 @@ struct page_pool {
 	unsigned long defer_warn;
 
 	u32 pages_state_hold_cnt;
+	unsigned int frag_offset;
+	int frag_bias;
+	struct page *frag_page;
 
 	/*
 	 * Data structure for allocation side
@@ -137,6 +143,20 @@ static inline struct page *page_pool_dev_alloc_pages(struct page_pool *pool)
 	return page_pool_alloc_pages(pool, gfp);
 }
 
+struct page *page_pool_alloc_frag(struct page_pool *pool,
+				  unsigned int *offset,
+				  unsigned int size,
+				  gfp_t gfp);
+
+static inline struct page *page_pool_dev_alloc_frag(struct page_pool *pool,
+						    unsigned int *offset,
+						    unsigned int size)
+{
+	gfp_t gfp = (GFP_ATOMIC | __GFP_NOWARN);
+
+	return page_pool_alloc_frag(pool, offset, size, gfp);
+}
+
 /* get the stored dma direction. A driver might decide to treat this locally and
  * avoid the extra cache line from page_pool to determine the direction
  */
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 6ac5b00..d172777 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -24,6 +24,8 @@
 #define DEFER_TIME (msecs_to_jiffies(1000))
 #define DEFER_WARN_INTERVAL (60 * HZ)
 
+#define BIAS_MAX	(PAGE_SIZE - 1)
+
 static int page_pool_init(struct page_pool *pool,
 			  const struct page_pool_params *params)
 {
@@ -67,6 +69,14 @@ static int page_pool_init(struct page_pool *pool,
 		 */
 	}
 
+	/* Make sure there is at least one bias left as we depend on that
+	 * to ensure the frag page is reserved to serve more users.
+	 */
+	if (pool->p.flags & PP_FLAG_PAGE_FRAG &&
+	    (PAGE_SIZE << pool->p.order >
+	     dma_get_cache_alignment() * (BIAS_MAX - 1)))
+		return -EINVAL;
+
 	if (ptr_ring_init(&pool->ring, ring_qsize, GFP_KERNEL) < 0)
 		return -ENOMEM;
 
@@ -429,6 +439,11 @@ static __always_inline struct page *
 __page_pool_put_page(struct page_pool *pool, struct page *page,
 		     unsigned int dma_sync_size, bool allow_direct)
 {
+	/* It is not the last user for the page frag case */
+	if (pool->p.flags & PP_FLAG_PAGE_FRAG &&
+	    page_pool_atomic_sub_bias_return(page, 1))
+		return NULL;
+
 	/* This allocator is optimized for the XDP mode that uses
 	 * one-frame-per-page, but have fallbacks that act like the
 	 * regular page allocator APIs.
@@ -452,19 +467,7 @@ __page_pool_put_page(struct page_pool *pool, struct page *page,
 		/* Page found as candidate for recycling */
 		return page;
 	}
-	/* Fallback/non-XDP mode: API user have elevated refcnt.
-	 *
-	 * Many drivers split up the page into fragments, and some
-	 * want to keep doing this to save memory and do refcnt based
-	 * recycling. Support this use case too, to ease drivers
-	 * switching between XDP/non-XDP.
-	 *
-	 * In-case page_pool maintains the DMA mapping, API user must
-	 * call page_pool_put_page once.  In this elevated refcnt
-	 * case, the DMA is unmapped/released, as driver is likely
-	 * doing refcnt based recycle tricks, meaning another process
-	 * will be invoking put_page.
-	 */
+
 	/* Do not replace this with page_pool_return_page() */
 	page_pool_release_page(pool, page);
 	put_page(page);
@@ -521,6 +524,79 @@ void page_pool_put_page_bulk(struct page_pool *pool, void **data,
 }
 EXPORT_SYMBOL(page_pool_put_page_bulk);
 
+static struct page *page_pool_drain_frag(struct page_pool *pool,
+					 struct page *page)
+{
+	/* page pool is not the last user */
+	if (page_pool_atomic_sub_bias_return(page,
+					     BIAS_MAX - pool->frag_bias))
+		return NULL;
+
+	if (likely(page_ref_count(page) == 1 &&
+		   !page_is_pfmemalloc(page)))
+		return page;
+
+	page_pool_return_page(pool, page);
+	return NULL;
+}
+
+static void page_pool_free_frag(struct page_pool *pool)
+{
+	struct page *page = pool->frag_page;
+
+	if (!page ||
+	    page_pool_atomic_sub_bias_return(page,
+					     BIAS_MAX - pool->frag_bias))
+		return;
+
+	page_pool_return_page(pool, page);
+	pool->frag_page = NULL;
+}
+
+struct page *page_pool_alloc_frag(struct page_pool *pool,
+				  unsigned int *offset,
+				  unsigned int size,
+				  gfp_t gfp)
+{
+	unsigned int max_size = PAGE_SIZE << pool->p.order;
+	unsigned int frag_offset = pool->frag_offset;
+	struct page *frag_page = pool->frag_page;
+
+	if (WARN_ON(!(pool->p.flags & PP_FLAG_PAGE_FRAG) ||
+		    size > max_size))
+		return NULL;
+
+	size = ALIGN(size, dma_get_cache_alignment());
+
+	if (frag_page && frag_offset + size > max_size) {
+		frag_page = page_pool_drain_frag(pool, frag_page);
+		if (frag_page)
+			goto frag_reset;
+	}
+
+	if (!frag_page) {
+		frag_page = page_pool_alloc_pages(pool, gfp);
+		if (unlikely(!frag_page)) {
+			pool->frag_page = NULL;
+			return NULL;
+		}
+
+		pool->frag_page = frag_page;
+
+frag_reset:
+		pool->frag_bias = 0;
+		frag_offset = 0;
+		page_pool_set_bias(frag_page, BIAS_MAX);
+	}
+
+	pool->frag_bias++;
+	*offset = frag_offset;
+	pool->frag_offset = frag_offset + size;
+
+	return frag_page;
+}
+EXPORT_SYMBOL(page_pool_alloc_frag);
+
 static void page_pool_empty_ring(struct page_pool *pool)
 {
 	struct page *page;
@@ -626,6 +702,8 @@ void page_pool_destroy(struct page_pool *pool)
 	if (!page_pool_put(pool))
 		return;
 
+	page_pool_free_frag(pool);
+
 	if (!page_pool_release(pool))
 		return;
 
-- 
2.7.4

