Return-Path: <bpf+bounces-28803-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 096F58BE0F1
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 13:23:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88BED1F21C6A
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 11:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94B8415E1E5;
	Tue,  7 May 2024 11:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AdLnRzLs"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8987115DBB9;
	Tue,  7 May 2024 11:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715080885; cv=none; b=dnRkmqhU0vDdiWgmHaNXmm4S1s+1b1ufA2FBVCJAjNgI2s1qpdAgKd7StWiIVP8+4z/EcXdHT8j4UbxhpZ72Iqf23z1vvOQxhcUh5tMwFqNeVHSxSZDBnKeUhRm2ZAfqI9/nxA4lrx81ka1vQREnPiCp22HpUglQhsjXqFlzTV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715080885; c=relaxed/simple;
	bh=D/H0YaHTmRJ3piTq2TdkLXovd27s1K/XWT4pyGOK2pA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MNvdk5YmeO2JkkoTrGg9DQ9DKpLuIVpWKYCV2xxG/SW+hJFwIMpPqtDxWHuyDN8qiwP3iQx7nYhTEcSInt+o2G5C/96Bvg1TYxkkkLjmx2E4qMzymbHo/NUepaAVtfRibByuaxY3ekynQoU2OhwX4eWDnF5HUrKAsBraXUYpu50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AdLnRzLs; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715080883; x=1746616883;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=D/H0YaHTmRJ3piTq2TdkLXovd27s1K/XWT4pyGOK2pA=;
  b=AdLnRzLsDTsf3wVnVZ5eQHpcNWdoec04BEcg5zcZEsdUlCFpOCTpNg2E
   pmIowuC78fwiBWRhTlCbhvNspeMtygx4ocji9mRlfANfi39sWBV7yZoy0
   WurEI6HRUTPYpM6jtt/U0rwdzFVL3MVP3IjxFmMSyff7QIA5uugs96aaD
   Sc+tsE/ZNHl841Wp0p28zYZTNCLmIdcPRXGI+SUn80+XBR09s09damzBE
   iWN0Z8B0NP+xmeUoBZxLMoU6Yu/KQko1TAVsA6rC3O0SxQ/qeEBy+IcKj
   aRGtBk4qVLvhx40VhOHTleeLSJ944EucB31SQ+Ob6mbmn52Unu/yCU+Qx
   Q==;
X-CSE-ConnectionGUID: ycPfzf9MR127oaWbJltLkQ==
X-CSE-MsgGUID: w5xz4MVoSj+d+yW9dW4svA==
X-IronPort-AV: E=McAfee;i="6600,9927,11065"; a="21472684"
X-IronPort-AV: E=Sophos;i="6.08,261,1712646000"; 
   d="scan'208";a="21472684"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2024 04:21:23 -0700
X-CSE-ConnectionGUID: usvI007XQUiFkztd+ubZUw==
X-CSE-MsgGUID: mGz7TwpqQVutyBbRi4sH8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,261,1712646000"; 
   d="scan'208";a="33316329"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa004.jf.intel.com with ESMTP; 07 May 2024 04:21:20 -0700
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Alexander Duyck <alexanderduyck@fb.com>
Subject: [PATCH v6 5/7] page_pool: don't use driver-set flags field directly
Date: Tue,  7 May 2024 13:20:24 +0200
Message-ID: <20240507112026.1803778-6-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240507112026.1803778-1-aleksander.lobakin@intel.com>
References: <20240507112026.1803778-1-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

page_pool::p is driver-defined params, copied directly from the
structure passed to page_pool_create(). The structure isn't meant
to be modified by the Page Pool core code and this even might look
confusing[0][1].
In order to be able to alter some flags, let's define our own, internal
fields the same way as the already existing one (::has_init_callback).
They are defined as bits in the driver-set params, leave them so here
as well, to not waste byte-per-bit or so. Almost 30 bits are still free
for future extensions.
We could've defined only new flags here or only the ones we may need
to alter, but checking some flags in one place while others in another
doesn't sound convenient or intuitive. ::flags passed by the driver can
now go to the "slow" PP params.

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Link[0]: https://lore.kernel.org/netdev/20230703133207.4f0c54ce@kernel.org
Suggested-by: Alexander Duyck <alexanderduyck@fb.com>
Link[1]: https://lore.kernel.org/netdev/CAKgT0UfZCGnWgOH96E4GV3ZP6LLbROHM7SHE8NKwq+exX+Gk_Q@mail.gmail.com
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 include/net/page_pool/types.h | 13 ++++++++---
 net/core/page_pool.c          | 41 +++++++++++++++++++----------------
 2 files changed, 32 insertions(+), 22 deletions(-)

diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.h
index 5460cbab5de0..8c6d9f16bf65 100644
--- a/include/net/page_pool/types.h
+++ b/include/net/page_pool/types.h
@@ -45,7 +45,6 @@ struct pp_alloc_cache {
 
 /**
  * struct page_pool_params - page pool parameters
- * @flags:	PP_FLAG_DMA_MAP, PP_FLAG_DMA_SYNC_DEV
  * @order:	2^order pages on allocation
  * @pool_size:	size of the ptr_ring
  * @nid:	NUMA node id to allocate from pages from
@@ -55,10 +54,11 @@ struct pp_alloc_cache {
  * @dma_dir:	DMA mapping direction
  * @max_len:	max DMA sync memory size for PP_FLAG_DMA_SYNC_DEV
  * @offset:	DMA sync address offset for PP_FLAG_DMA_SYNC_DEV
+ * @netdev:	corresponding &net_device for Netlink introspection
+ * @flags:	PP_FLAG_DMA_MAP, PP_FLAG_DMA_SYNC_DEV, PP_FLAG_SYSTEM_POOL
  */
 struct page_pool_params {
 	struct_group_tagged(page_pool_params_fast, fast,
-		unsigned int	flags;
 		unsigned int	order;
 		unsigned int	pool_size;
 		int		nid;
@@ -70,6 +70,7 @@ struct page_pool_params {
 	);
 	struct_group_tagged(page_pool_params_slow, slow,
 		struct net_device *netdev;
+		unsigned int	flags;
 /* private: used by test code only */
 		void (*init_callback)(struct page *page, void *arg);
 		void *init_arg;
@@ -131,7 +132,13 @@ struct page_pool {
 
 	int cpuid;
 	u32 pages_state_hold_cnt;
-	bool has_init_callback;
+
+	bool has_init_callback:1;	/* slow::init_callback is set */
+	bool dma_map:1;			/* Perform DMA mapping */
+	bool dma_sync:1;		/* Perform DMA sync */
+#ifdef CONFIG_PAGE_POOL_STATS
+	bool system:1;			/* This is a global percpu pool */
+#endif
 
 	/* The following block must stay within one cacheline. On 32-bit
 	 * systems, sizeof(long) == sizeof(int), so that the block size is
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 95eac12e8790..c2819ff03dd2 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -194,7 +194,7 @@ static int page_pool_init(struct page_pool *pool,
 	pool->cpuid = cpuid;
 
 	/* Validate only known flags were used */
-	if (pool->p.flags & ~(PP_FLAG_ALL))
+	if (pool->slow.flags & ~PP_FLAG_ALL)
 		return -EINVAL;
 
 	if (pool->p.pool_size)
@@ -208,22 +208,26 @@ static int page_pool_init(struct page_pool *pool,
 	 * DMA_BIDIRECTIONAL is for allowing page used for DMA sending,
 	 * which is the XDP_TX use-case.
 	 */
-	if (pool->p.flags & PP_FLAG_DMA_MAP) {
+	if (pool->slow.flags & PP_FLAG_DMA_MAP) {
 		if ((pool->p.dma_dir != DMA_FROM_DEVICE) &&
 		    (pool->p.dma_dir != DMA_BIDIRECTIONAL))
 			return -EINVAL;
+
+		pool->dma_map = true;
 	}
 
-	if (pool->p.flags & PP_FLAG_DMA_SYNC_DEV) {
+	if (pool->slow.flags & PP_FLAG_DMA_SYNC_DEV) {
 		/* In order to request DMA-sync-for-device the page
 		 * needs to be mapped
 		 */
-		if (!(pool->p.flags & PP_FLAG_DMA_MAP))
+		if (!(pool->slow.flags & PP_FLAG_DMA_MAP))
 			return -EINVAL;
 
 		if (!pool->p.max_len)
 			return -EINVAL;
 
+		pool->dma_sync = true;
+
 		/* pool->p.offset has to be set according to the address
 		 * offset used by the DMA engine to start copying rx data
 		 */
@@ -232,7 +236,7 @@ static int page_pool_init(struct page_pool *pool,
 	pool->has_init_callback = !!pool->slow.init_callback;
 
 #ifdef CONFIG_PAGE_POOL_STATS
-	if (!(pool->p.flags & PP_FLAG_SYSTEM_POOL)) {
+	if (!(pool->slow.flags & PP_FLAG_SYSTEM_POOL)) {
 		pool->recycle_stats = alloc_percpu(struct page_pool_recycle_stats);
 		if (!pool->recycle_stats)
 			return -ENOMEM;
@@ -242,12 +246,13 @@ static int page_pool_init(struct page_pool *pool,
 		 * (also percpu) page pool instance.
 		 */
 		pool->recycle_stats = &pp_system_recycle_stats;
+		pool->system = true;
 	}
 #endif
 
 	if (ptr_ring_init(&pool->ring, ring_qsize, GFP_KERNEL) < 0) {
 #ifdef CONFIG_PAGE_POOL_STATS
-		if (!(pool->p.flags & PP_FLAG_SYSTEM_POOL))
+		if (!pool->system)
 			free_percpu(pool->recycle_stats);
 #endif
 		return -ENOMEM;
@@ -258,7 +263,7 @@ static int page_pool_init(struct page_pool *pool,
 	/* Driver calling page_pool_create() also call page_pool_destroy() */
 	refcount_set(&pool->user_cnt, 1);
 
-	if (pool->p.flags & PP_FLAG_DMA_MAP)
+	if (pool->dma_map)
 		get_device(pool->p.dev);
 
 	return 0;
@@ -268,11 +273,11 @@ static void page_pool_uninit(struct page_pool *pool)
 {
 	ptr_ring_cleanup(&pool->ring, NULL);
 
-	if (pool->p.flags & PP_FLAG_DMA_MAP)
+	if (pool->dma_map)
 		put_device(pool->p.dev);
 
 #ifdef CONFIG_PAGE_POOL_STATS
-	if (!(pool->p.flags & PP_FLAG_SYSTEM_POOL))
+	if (!pool->system)
 		free_percpu(pool->recycle_stats);
 #endif
 }
@@ -424,7 +429,7 @@ static bool page_pool_dma_map(struct page_pool *pool, struct page *page)
 	if (page_pool_set_dma_addr(page, dma))
 		goto unmap_failed;
 
-	if (pool->p.flags & PP_FLAG_DMA_SYNC_DEV)
+	if (pool->dma_sync)
 		page_pool_dma_sync_for_device(pool, page, pool->p.max_len);
 
 	return true;
@@ -470,8 +475,7 @@ static struct page *__page_pool_alloc_page_order(struct page_pool *pool,
 	if (unlikely(!page))
 		return NULL;
 
-	if ((pool->p.flags & PP_FLAG_DMA_MAP) &&
-	    unlikely(!page_pool_dma_map(pool, page))) {
+	if (pool->dma_map && unlikely(!page_pool_dma_map(pool, page))) {
 		put_page(page);
 		return NULL;
 	}
@@ -491,8 +495,8 @@ static struct page *__page_pool_alloc_pages_slow(struct page_pool *pool,
 						 gfp_t gfp)
 {
 	const int bulk = PP_ALLOC_CACHE_REFILL;
-	unsigned int pp_flags = pool->p.flags;
 	unsigned int pp_order = pool->p.order;
+	bool dma_map = pool->dma_map;
 	struct page *page;
 	int i, nr_pages;
 
@@ -517,8 +521,7 @@ static struct page *__page_pool_alloc_pages_slow(struct page_pool *pool,
 	 */
 	for (i = 0; i < nr_pages; i++) {
 		page = pool->alloc.cache[i];
-		if ((pp_flags & PP_FLAG_DMA_MAP) &&
-		    unlikely(!page_pool_dma_map(pool, page))) {
+		if (dma_map && unlikely(!page_pool_dma_map(pool, page))) {
 			put_page(page);
 			continue;
 		}
@@ -590,7 +593,7 @@ void __page_pool_release_page_dma(struct page_pool *pool, struct page *page)
 {
 	dma_addr_t dma;
 
-	if (!(pool->p.flags & PP_FLAG_DMA_MAP))
+	if (!pool->dma_map)
 		/* Always account for inflight pages, even if we didn't
 		 * map them
 		 */
@@ -673,7 +676,7 @@ static bool __page_pool_page_can_be_recycled(const struct page *page)
 }
 
 /* If the page refcnt == 1, this will try to recycle the page.
- * if PP_FLAG_DMA_SYNC_DEV is set, we'll try to sync the DMA area for
+ * If pool->dma_sync is set, we'll try to sync the DMA area for
  * the configured size min(dma_sync_size, pool->max_len).
  * If the page refcnt != 1, then the page will be returned to memory
  * subsystem.
@@ -696,7 +699,7 @@ __page_pool_put_page(struct page_pool *pool, struct page *page,
 	if (likely(__page_pool_page_can_be_recycled(page))) {
 		/* Read barrier done in page_ref_count / READ_ONCE */
 
-		if (pool->p.flags & PP_FLAG_DMA_SYNC_DEV)
+		if (pool->dma_sync)
 			page_pool_dma_sync_for_device(pool, page,
 						      dma_sync_size);
 
@@ -809,7 +812,7 @@ static struct page *page_pool_drain_frag(struct page_pool *pool,
 		return NULL;
 
 	if (__page_pool_page_can_be_recycled(page)) {
-		if (pool->p.flags & PP_FLAG_DMA_SYNC_DEV)
+		if (pool->dma_sync)
 			page_pool_dma_sync_for_device(pool, page, -1);
 
 		return page;
-- 
2.45.0


