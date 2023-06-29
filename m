Return-Path: <bpf+bounces-3728-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EBD3742554
	for <lists+bpf@lfdr.de>; Thu, 29 Jun 2023 14:06:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F7D21C20997
	for <lists+bpf@lfdr.de>; Thu, 29 Jun 2023 12:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED013154A8;
	Thu, 29 Jun 2023 12:04:58 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07E315495;
	Thu, 29 Jun 2023 12:04:58 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAD1430E5;
	Thu, 29 Jun 2023 05:04:56 -0700 (PDT)
Received: from dggpemm500005.china.huawei.com (unknown [172.30.72.55])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4QsHBw62q1zLnNr;
	Thu, 29 Jun 2023 20:02:48 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 dggpemm500005.china.huawei.com (7.185.36.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 29 Jun 2023 20:04:55 +0800
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
Subject: [PATCH v5 RFC 5/6] page_pool: update document about frag API
Date: Thu, 29 Jun 2023 20:02:25 +0800
Message-ID: <20230629120226.14854-6-linyunsheng@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20230629120226.14854-1-linyunsheng@huawei.com>
References: <20230629120226.14854-1-linyunsheng@huawei.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500005.china.huawei.com (7.185.36.74)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

As more drivers begin to use the frag API, update the
document about how to decide which API to use for the
driver author.

Also it seems there is a similar document in page_pool.h,
so remove it to avoid the duplication.

Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
CC: Lorenzo Bianconi <lorenzo@kernel.org>
CC: Alexander Duyck <alexander.duyck@gmail.com>
CC: Liang Chen <liangchen.linux@gmail.com>
CC: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 Documentation/networking/page_pool.rst | 34 ++++++++++++++++++++++----
 include/net/page_pool.h                | 22 -----------------
 2 files changed, 29 insertions(+), 27 deletions(-)

diff --git a/Documentation/networking/page_pool.rst b/Documentation/networking/page_pool.rst
index 873efd97f822..18b13d659c98 100644
--- a/Documentation/networking/page_pool.rst
+++ b/Documentation/networking/page_pool.rst
@@ -4,12 +4,27 @@
 Page Pool API
 =============
 
-The page_pool allocator is optimized for the XDP mode that uses one frame
-per-page, but it can fallback on the regular page allocator APIs.
+The page_pool allocator is optimized for recycling page or page frag used by skb
+packet and xdp frame.
 
-Basic use involves replacing alloc_pages() calls with the
-page_pool_alloc_pages() call.  Drivers should use page_pool_dev_alloc_pages()
-replacing dev_alloc_pages().
+Basic use involves replacing napi_alloc_frag() and alloc_pages() calls with
+page_pool_cache_alloc() and page_pool_alloc(), which allocate memory with or
+without page splitting depending on the requested memory size.
+
+If the driver knows that it always requires full pages or its allocates are
+always smaller than half a page, it can use one of the more specific API calls:
+
+1. page_pool_alloc_pages(): allocate memory without page splitting when driver
+   knows that the memory it need is always bigger than half of the page
+   allocated from page pool. There is no cache line dirtying for 'struct page'
+   when a page is recycled back to the page pool.
+
+2. page_pool_alloc_frag(): allocate memory with page splitting when driver knows
+   that the memory it need is always smaller than or equal to half of the page
+   allocated from page pool. Page splitting enables memory saving and thus avoid
+   TLB/cache miss for data access, but there also is some cost to implement page
+   splitting, mainly some cache line dirtying/bouncing for 'struct page' and
+   atomic operation for page->pp_frag_count.
 
 API keeps track of in-flight pages, in order to let API user know
 when it is safe to free a page_pool object.  Thus, API users
@@ -93,6 +108,15 @@ a page will cause no race conditions is enough.
 * page_pool_dev_alloc_pages(): Get a page from the page allocator or page_pool
   caches.
 
+* page_pool_dev_alloc_frag(): Get a page frag from the page allocator or
+  page_pool caches.
+
+* page_pool_dev_alloc(): Get a page or page frag from the page allocator or
+  page_pool caches.
+
+* page_pool_dev_cache_alloc(): Get a cache from the page allocator or page_pool
+  caches.
+
 * page_pool_get_dma_addr(): Retrieve the stored DMA address.
 
 * page_pool_get_dma_dir(): Retrieve the stored DMA direction.
diff --git a/include/net/page_pool.h b/include/net/page_pool.h
index e9fb95d62ed5..2b7db9992fc0 100644
--- a/include/net/page_pool.h
+++ b/include/net/page_pool.h
@@ -5,28 +5,6 @@
  *	Copyright (C) 2016 Red Hat, Inc.
  */
 
-/**
- * DOC: page_pool allocator
- *
- * This page_pool allocator is optimized for the XDP mode that
- * uses one-frame-per-page, but have fallbacks that act like the
- * regular page allocator APIs.
- *
- * Basic use involve replacing alloc_pages() calls with the
- * page_pool_alloc_pages() call.  Drivers should likely use
- * page_pool_dev_alloc_pages() replacing dev_alloc_pages().
- *
- * API keeps track of in-flight pages, in-order to let API user know
- * when it is safe to dealloactor page_pool object.  Thus, API users
- * must make sure to call page_pool_release_page() when a page is
- * "leaving" the page_pool.  Or call page_pool_put_page() where
- * appropiate.  For maintaining correct accounting.
- *
- * API user must only call page_pool_put_page() once on a page, as it
- * will either recycle the page, or in case of elevated refcnt, it
- * will release the DMA mapping and in-flight state accounting.  We
- * hope to lift this requirement in the future.
- */
 #ifndef _NET_PAGE_POOL_H
 #define _NET_PAGE_POOL_H
 
-- 
2.33.0


