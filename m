Return-Path: <bpf+bounces-7712-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F262777B945
	for <lists+bpf@lfdr.de>; Mon, 14 Aug 2023 15:01:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2ED3E1C20A81
	for <lists+bpf@lfdr.de>; Mon, 14 Aug 2023 13:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0890C148;
	Mon, 14 Aug 2023 12:59:51 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB09DC136;
	Mon, 14 Aug 2023 12:59:51 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61202E5E;
	Mon, 14 Aug 2023 05:59:47 -0700 (PDT)
Received: from dggpemm500005.china.huawei.com (unknown [172.30.72.55])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RPZFt43mpzrSLj;
	Mon, 14 Aug 2023 20:58:26 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 dggpemm500005.china.huawei.com (7.185.36.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 14 Aug 2023 20:59:44 +0800
From: Yunsheng Lin <linyunsheng@huawei.com>
To: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Yunsheng Lin
	<linyunsheng@huawei.com>, Lorenzo Bianconi <lorenzo@kernel.org>, Alexander
 Duyck <alexander.duyck@gmail.com>, Liang Chen <liangchen.linux@gmail.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>, Jesper Dangaard Brouer
	<hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, Eric
 Dumazet <edumazet@google.com>, Jonathan Corbet <corbet@lwn.net>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, John
 Fastabend <john.fastabend@gmail.com>, <linux-doc@vger.kernel.org>,
	<bpf@vger.kernel.org>
Subject: [PATCH net-next v6 5/6] page_pool: update document about frag API
Date: Mon, 14 Aug 2023 20:56:42 +0800
Message-ID: <20230814125643.59334-6-linyunsheng@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20230814125643.59334-1-linyunsheng@huawei.com>
References: <20230814125643.59334-1-linyunsheng@huawei.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500005.china.huawei.com (7.185.36.74)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

As more drivers begin to use the frag API, update the
document about how to decide which API to use for the
driver author.

Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
CC: Lorenzo Bianconi <lorenzo@kernel.org>
CC: Alexander Duyck <alexander.duyck@gmail.com>
CC: Liang Chen <liangchen.linux@gmail.com>
CC: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 Documentation/networking/page_pool.rst |  4 +-
 include/net/page_pool/helpers.h        | 58 +++++++++++++++++++++++---
 2 files changed, 55 insertions(+), 7 deletions(-)

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
index b920224f6584..0f1eaa2986f9 100644
--- a/include/net/page_pool/helpers.h
+++ b/include/net/page_pool/helpers.h
@@ -8,13 +8,28 @@
 /**
  * DOC: page_pool allocator
  *
- * The page_pool allocator is optimized for the XDP mode that
- * uses one frame per-page, but it can fallback on the
- * regular page allocator APIs.
+ * The page_pool allocator is optimized for recycling page or page frag used by
+ * skb packet and xdp frame.
  *
- * Basic use involves replacing alloc_pages() calls with the
- * page_pool_alloc_pages() call.  Drivers should use
- * page_pool_dev_alloc_pages() replacing dev_alloc_pages().
+ * Basic use involves replacing napi_alloc_frag() and alloc_pages() calls with
+ * page_pool_cache_alloc() and page_pool_alloc(), which allocate memory with or
+ * without page splitting depending on the requested memory size.
+ *
+ * If the driver knows that it always requires full pages or its allocates are
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
+ * avoid TLB/cache miss for data access, but there also is some cost to
+ * implement page splitting, mainly some cache line dirtying/bouncing for
+ * 'struct page' and atomic operation for page->pp_frag_count.
  *
  * API keeps track of in-flight pages, in order to let API user know
  * when it is safe to free a page_pool object.  Thus, API users
@@ -100,6 +115,14 @@ static inline struct page *page_pool_alloc_frag(struct page_pool *pool,
 	return __page_pool_alloc_frag(pool, offset, size, gfp);
 }
 
+/**
+ * page_pool_dev_alloc_frag() - allocate a page frag.
+ * @pool[in]	pool from which to allocate
+ * @offset[out]	offset to the allocated page
+ * @size[in]	requested size
+ *
+ * Get a page frag from the page allocator or page_pool caches.
+ */
 static inline struct page *page_pool_dev_alloc_frag(struct page_pool *pool,
 						    unsigned int *offset,
 						    unsigned int size)
@@ -143,6 +166,14 @@ static inline struct page *page_pool_alloc(struct page_pool *pool,
 	return page;
 }
 
+/**
+ * page_pool_dev_alloc() - allocate a page or a page frag.
+ * @pool[in]:		pool from which to allocate
+ * @offset[out]:	offset to the allocated page
+ * @size[in, out]:	in as the requested size, out as the allocated size
+ *
+ * Get a page or a page frag from the page allocator or page_pool caches.
+ */
 static inline struct page *page_pool_dev_alloc(struct page_pool *pool,
 					       unsigned int *offset,
 					       unsigned int *size)
@@ -165,6 +196,13 @@ static inline void *page_pool_cache_alloc(struct page_pool *pool,
 	return page_address(page) + offset;
 }
 
+/**
+ * page_pool_dev_cache_alloc() - allocate a cache.
+ * @pool[in]:		pool from which to allocate
+ * @size[in, out]:	in as the requested size, out as the allocated size
+ *
+ * Get a cache from the page allocator or page_pool caches.
+ */
 static inline void *page_pool_dev_cache_alloc(struct page_pool *pool,
 					      unsigned int *size)
 {
@@ -316,6 +354,14 @@ static inline void page_pool_recycle_direct(struct page_pool *pool,
 	page_pool_put_full_page(pool, page, true);
 }
 
+/**
+ * page_pool_cache_free() - free a cache into the page_pool
+ * @pool[in]:		pool from which cache was allocated
+ * @data[in]:		cache to free
+ * @allow_direct[in]:	freed by the consumer, allow lockless caching
+ *
+ * Free a cache allocated from page_pool_dev_cache_alloc().
+ */
 static inline void page_pool_cache_free(struct page_pool *pool, void *data,
 					bool allow_direct)
 {
-- 
2.33.0


