Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 478863E21D2
	for <lists+bpf@lfdr.de>; Fri,  6 Aug 2021 04:47:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240559AbhHFCrj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 5 Aug 2021 22:47:39 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:13240 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240060AbhHFCrh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 5 Aug 2021 22:47:37 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4GgqdD0K66z1CR9h;
        Fri,  6 Aug 2021 10:47:12 +0800 (CST)
Received: from dggpemm500005.china.huawei.com (7.185.36.74) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 6 Aug 2021 10:47:20 +0800
Received: from localhost.localdomain (10.69.192.56) by
 dggpemm500005.china.huawei.com (7.185.36.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 6 Aug 2021 10:47:19 +0800
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
        <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
        <chenhao288@hisilicon.com>
Subject: [PATCH net-next v2 3/4] page_pool: add frag page recycling support in page pool
Date:   Fri, 6 Aug 2021 10:46:21 +0800
Message-ID: <1628217982-53533-4-git-send-email-linyunsheng@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1628217982-53533-1-git-send-email-linyunsheng@huawei.com>
References: <1628217982-53533-1-git-send-email-linyunsheng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500005.china.huawei.com (7.185.36.74)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Currently page pool only support page recycling when there
is only one user of the page, and the split page reusing
implemented in the most driver can not use the page pool as
bing-pong way of reusing requires the multi user support in
page pool.

Those reusing or recycling has below limitations:
1. page from page pool can only be used be one user in order
   for the page recycling to happen.
2. Bing-pong way of reusing in most driver does not support
   multi desc using different part of the same page in order
   to save memory.

So add multi-users support and frag page recycling in page
pool to overcome the above limitation.

Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
---
 include/net/page_pool.h | 15 +++++++++
 net/core/page_pool.c    | 87 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 102 insertions(+)

diff --git a/include/net/page_pool.h b/include/net/page_pool.h
index 42e6997..a408240 100644
--- a/include/net/page_pool.h
+++ b/include/net/page_pool.h
@@ -91,6 +91,9 @@ struct page_pool {
 	unsigned long defer_warn;
 
 	u32 pages_state_hold_cnt;
+	unsigned int frag_offset;
+	struct page *frag_page;
+	long frag_users;
 
 	/*
 	 * Data structure for allocation side
@@ -140,6 +143,18 @@ static inline struct page *page_pool_dev_alloc_pages(struct page_pool *pool)
 	return page_pool_alloc_pages(pool, gfp);
 }
 
+struct page *page_pool_alloc_frag(struct page_pool *pool, unsigned int *offset,
+				  unsigned int size, gfp_t gfp);
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
index 68fab94..ac11604 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -24,6 +24,8 @@
 #define DEFER_TIME (msecs_to_jiffies(1000))
 #define DEFER_WARN_INTERVAL (60 * HZ)
 
+#define BIAS_MAX	LONG_MAX
+
 static int page_pool_init(struct page_pool *pool,
 			  const struct page_pool_params *params)
 {
@@ -423,6 +425,11 @@ static __always_inline struct page *
 __page_pool_put_page(struct page_pool *pool, struct page *page,
 		     unsigned int dma_sync_size, bool allow_direct)
 {
+	/* It is not the last user for the page frag case */
+	if (pool->p.flags & PP_FLAG_PAGE_FRAG &&
+	    page_pool_atomic_sub_frag_count_return(page, 1))
+		return NULL;
+
 	/* This allocator is optimized for the XDP mode that uses
 	 * one-frame-per-page, but have fallbacks that act like the
 	 * regular page allocator APIs.
@@ -515,6 +522,84 @@ void page_pool_put_page_bulk(struct page_pool *pool, void **data,
 }
 EXPORT_SYMBOL(page_pool_put_page_bulk);
 
+static struct page *page_pool_drain_frag(struct page_pool *pool,
+					 struct page *page)
+{
+	long drain_count = BIAS_MAX - pool->frag_users;
+
+	/* Some user is still using the page frag */
+	if (likely(page_pool_atomic_sub_frag_count_return(page,
+							  drain_count)))
+		return NULL;
+
+	if (page_ref_count(page) == 1 && !page_is_pfmemalloc(page)) {
+		if (pool->p.flags & PP_FLAG_DMA_SYNC_DEV)
+			page_pool_dma_sync_for_device(pool, page, -1);
+
+		return page;
+	}
+
+	page_pool_return_page(pool, page);
+	return NULL;
+}
+
+static void page_pool_free_frag(struct page_pool *pool)
+{
+	long drain_count = BIAS_MAX - pool->frag_users;
+	struct page *page = pool->frag_page;
+
+	pool->frag_page = NULL;
+
+	if (!page ||
+	    page_pool_atomic_sub_frag_count_return(page, drain_count))
+		return;
+
+	page_pool_return_page(pool, page);
+}
+
+struct page *page_pool_alloc_frag(struct page_pool *pool,
+				  unsigned int *offset,
+				  unsigned int size, gfp_t gfp)
+{
+	unsigned int max_size = PAGE_SIZE << pool->p.order;
+	struct page *page = pool->frag_page;
+
+	if (WARN_ON(!(pool->p.flags & PP_FLAG_PAGE_FRAG) ||
+		    size > max_size))
+		return NULL;
+
+	size = ALIGN(size, dma_get_cache_alignment());
+	*offset = pool->frag_offset;
+
+	if (page && *offset + size > max_size) {
+		page = page_pool_drain_frag(pool, page);
+		if (page)
+			goto frag_reset;
+	}
+
+	if (!page) {
+		page = page_pool_alloc_pages(pool, gfp);
+		if (unlikely(!page)) {
+			pool->frag_page = NULL;
+			return NULL;
+		}
+
+		pool->frag_page = page;
+
+frag_reset:
+		pool->frag_users = 1;
+		*offset = 0;
+		pool->frag_offset = size;
+		page_pool_set_frag_count(page, BIAS_MAX);
+		return page;
+	}
+
+	pool->frag_users++;
+	pool->frag_offset = *offset + size;
+	return page;
+}
+EXPORT_SYMBOL(page_pool_alloc_frag);
+
 static void page_pool_empty_ring(struct page_pool *pool)
 {
 	struct page *page;
@@ -620,6 +705,8 @@ void page_pool_destroy(struct page_pool *pool)
 	if (!page_pool_put(pool))
 		return;
 
+	page_pool_free_frag(pool);
+
 	if (!page_pool_release(pool))
 		return;
 
-- 
2.7.4

