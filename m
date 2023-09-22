Return-Path: <bpf+bounces-10618-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98C557AAD92
	for <lists+bpf@lfdr.de>; Fri, 22 Sep 2023 11:15:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id 95F8CB20B9E
	for <lists+bpf@lfdr.de>; Fri, 22 Sep 2023 09:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E8D61DA51;
	Fri, 22 Sep 2023 09:15:15 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1351817756;
	Fri, 22 Sep 2023 09:15:13 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0454E196;
	Fri, 22 Sep 2023 02:15:11 -0700 (PDT)
Received: from dggpemm500005.china.huawei.com (unknown [172.30.72.57])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RsRPn0Hpbz15NRP;
	Fri, 22 Sep 2023 17:13:01 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 dggpemm500005.china.huawei.com (7.185.36.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Fri, 22 Sep 2023 17:15:09 +0800
From: Yunsheng Lin <linyunsheng@huawei.com>
To: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Yunsheng Lin
	<linyunsheng@huawei.com>, Lorenzo Bianconi <lorenzo@kernel.org>, Alexander
 Duyck <alexander.duyck@gmail.com>, Liang Chen <liangchen.linux@gmail.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>, Dima Tisnek
	<dimaqq@gmail.com>, Jesper Dangaard Brouer <hawk@kernel.org>, Ilias
 Apalodimas <ilias.apalodimas@linaro.org>, Eric Dumazet <edumazet@google.com>,
	Jonathan Corbet <corbet@lwn.net>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>,
	<linux-doc@vger.kernel.org>, <bpf@vger.kernel.org>
Subject: [PATCH net-next v10 5/6] page_pool: update document about fragment API
Date: Fri, 22 Sep 2023 17:11:37 +0800
Message-ID: <20230922091138.18014-6-linyunsheng@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20230922091138.18014-1-linyunsheng@huawei.com>
References: <20230922091138.18014-1-linyunsheng@huawei.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500005.china.huawei.com (7.185.36.74)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

As more drivers begin to use the fragment API, update the
document about how to decide which API to use for the
driver author.

Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
CC: Lorenzo Bianconi <lorenzo@kernel.org>
CC: Alexander Duyck <alexander.duyck@gmail.com>
CC: Liang Chen <liangchen.linux@gmail.com>
CC: Alexander Lobakin <aleksander.lobakin@intel.com>
CC: Dima Tisnek <dimaqq@gmail.com>
---
 Documentation/networking/page_pool.rst |  4 +-
 include/net/page_pool/helpers.h        | 91 ++++++++++++++++++++++----
 2 files changed, 81 insertions(+), 14 deletions(-)

diff --git a/Documentation/networking/page_pool.rst b/Documentation/networking/page_pool.rst
index 215ebc92752c..0c0705994f51 100644
--- a/Documentation/networking/page_pool.rst
+++ b/Documentation/networking/page_pool.rst
@@ -58,7 +58,9 @@ a page will cause no race conditions is enough.
 
 .. kernel-doc:: include/net/page_pool/helpers.h
    :identifiers: page_pool_put_page page_pool_put_full_page
-		 page_pool_recycle_direct page_pool_dev_alloc_pages
+		 page_pool_recycle_direct page_pool_cache_free
+		 page_pool_dev_alloc_pages page_pool_dev_alloc_frag
+		 page_pool_dev_alloc page_pool_dev_cache_alloc
 		 page_pool_get_dma_addr page_pool_get_dma_dir
 
 .. kernel-doc:: net/core/page_pool.c
diff --git a/include/net/page_pool/helpers.h b/include/net/page_pool/helpers.h
index 251c075084b8..017d1568af77 100644
--- a/include/net/page_pool/helpers.h
+++ b/include/net/page_pool/helpers.h
@@ -8,23 +8,46 @@
 /**
  * DOC: page_pool allocator
  *
- * The page_pool allocator is optimized for the XDP mode that
- * uses one frame per-page, but it can fallback on the
- * regular page allocator APIs.
+ * The page_pool allocator is optimized for recycling page or page fragment used
+ * by skb packet and xdp frame.
  *
- * Basic use involves replacing alloc_pages() calls with the
- * page_pool_alloc_pages() call.  Drivers should use
- * page_pool_dev_alloc_pages() replacing dev_alloc_pages().
+ * Basic use involves replacing napi_alloc_frag() and alloc_pages() calls with
+ * page_pool_cache_alloc() and page_pool_alloc(), which allocate memory with or
+ * without page splitting depending on the requested memory size.
  *
- * API keeps track of in-flight pages, in order to let API user know
- * when it is safe to free a page_pool object.  Thus, API users
- * must call page_pool_put_page() to free the page, or attach
- * the page to a page_pool-aware objects like skbs marked with
+ * If the driver knows that it always requires full pages or its allocations are
+ * always smaller than half a page, it can use one of the more specific API
+ * calls:
+ *
+ * 1. page_pool_alloc_pages(): allocate memory without page splitting when
+ * driver knows that the memory it need is always bigger than half of the page
+ * allocated from page pool. There is no cache line dirtying for 'struct page'
+ * when a page is recycled back to the page pool.
+ *
+ * 2. page_pool_alloc_frag(): allocate memory with page splitting when driver
+ * knows that the memory it need is always smaller than or equal to half of the
+ * page allocated from page pool. Page splitting enables memory saving and thus
+ * avoids TLB/cache miss for data access, but there also is some cost to
+ * implement page splitting, mainly some cache line dirtying/bouncing for
+ * 'struct page' and atomic operation for page->pp_frag_count.
+ *
+ * API keeps track of in-flight pages, in order to let API user know when it is
+ * safe to free a page_pool object, the API users must call page_pool_put_page()
+ * or page_pool_cache_free() to free the pp page or the pp buffer, or attach the
+ * pp page or the pp buffer to a page_pool-aware objects like skbs marked with
  * skb_mark_for_recycle().
  *
- * API user must call page_pool_put_page() once on a page, as it
- * will either recycle the page, or in case of refcnt > 1, it will
- * release the DMA mapping and in-flight state accounting.
+ * page_pool_put_page() may be called multi times on the same page if a page is
+ * split into multi fragments. For the last fragment, it will either recycle the
+ * page, or in case of page->_refcount > 1, it will release the DMA mapping and
+ * in-flight state accounting.
+ *
+ * dma_sync_single_range_for_device() is only called for the last fragment when
+ * page_pool is created with PP_FLAG_DMA_SYNC_DEV flag, so it depends on the
+ * last freed fragment to do the sync_for_device operation for all fragments in
+ * the same page when a page is split, the API user must setup pool->p.max_len
+ * and pool->p.offset correctly and ensure that page_pool_put_page() is called
+ * with dma_sync_size being -1 for fragment API.
  */
 #ifndef _NET_PAGE_POOL_HELPERS_H
 #define _NET_PAGE_POOL_HELPERS_H
@@ -73,6 +96,17 @@ static inline struct page *page_pool_dev_alloc_pages(struct page_pool *pool)
 	return page_pool_alloc_pages(pool, gfp);
 }
 
+/**
+ * page_pool_dev_alloc_frag() - allocate a page fragment.
+ * @pool: pool from which to allocate
+ * @offset: offset to the allocated page
+ * @size: requested size
+ *
+ * Get a page fragment from the page allocator or page_pool caches.
+ *
+ * Return:
+ * Return allocated page fragment, otherwise return NULL.
+ */
 static inline struct page *page_pool_dev_alloc_frag(struct page_pool *pool,
 						    unsigned int *offset,
 						    unsigned int size)
@@ -111,6 +145,19 @@ static inline struct page *page_pool_alloc(struct page_pool *pool,
 	return page;
 }
 
+/**
+ * page_pool_dev_alloc() - allocate a page or a page fragment.
+ * @pool: pool from which to allocate
+ * @offset: offset to the allocated page
+ * @size: in as the requested size, out as the allocated size
+ *
+ * Get a page or a page fragment from the page allocator or page_pool caches
+ * depending on the requested size in order to allocate memory with least memory
+ * utilization and performance penalty.
+ *
+ * Return:
+ * Return allocated page or page fragment, otherwise return NULL.
+ */
 static inline struct page *page_pool_dev_alloc(struct page_pool *pool,
 					       unsigned int *offset,
 					       unsigned int *size)
@@ -133,6 +180,16 @@ static inline void *page_pool_cache_alloc(struct page_pool *pool,
 	return page_address(page) + offset;
 }
 
+/**
+ * page_pool_dev_cache_alloc() - allocate a cache.
+ * @pool: pool from which to allocate
+ * @size: in as the requested size, out as the allocated size
+ *
+ * Get a cache from the page allocator or page_pool caches.
+ *
+ * Return:
+ * Return the addr for the allocated cache, otherwise return NULL.
+ */
 static inline void *page_pool_dev_cache_alloc(struct page_pool *pool,
 					      unsigned int *size)
 {
@@ -280,6 +337,14 @@ static inline void page_pool_recycle_direct(struct page_pool *pool,
 #define PAGE_POOL_32BIT_ARCH_WITH_64BIT_DMA	\
 		(sizeof(dma_addr_t) > sizeof(unsigned long))
 
+/**
+ * page_pool_cache_free() - free a cache into the page_pool
+ * @pool: pool from which cache was allocated
+ * @data: addr of cache to be free
+ * @allow_direct: freed by the consumer, allow lockless caching
+ *
+ * Free a cache allocated from page_pool_dev_cache_alloc().
+ */
 static inline void page_pool_cache_free(struct page_pool *pool, void *data,
 					bool allow_direct)
 {
-- 
2.33.0


