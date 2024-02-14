Return-Path: <bpf+bounces-21989-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 67C1A854E19
	for <lists+bpf@lfdr.de>; Wed, 14 Feb 2024 17:25:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C9F31C2183D
	for <lists+bpf@lfdr.de>; Wed, 14 Feb 2024 16:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D06F604B9;
	Wed, 14 Feb 2024 16:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a0yjvQGq"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 897DF626A3;
	Wed, 14 Feb 2024 16:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707927788; cv=none; b=NC4tlOr/z6EttneRhU8CzoKOIycr5pOP+BnLFxkoJVgsWr9IkM9DwdahoR7P160CocNYOLeiiNVJyKTBWWbe8Kv41AwOsORAiR0RMPh0USF65CCtutxN/3K94wGi3QJykWpAtWbG+KB867+Kj99a2mCCVD4+KyRKAgrBBvj6B48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707927788; c=relaxed/simple;
	bh=8/xfsN2JJ5K0biHSMOPQftsQpWMqQOkJvAI5f9o0N8U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mPKXK4/vVQmUm7QRTwAm8wo0a7/kVg8Y2pMEdYHT8XZbcRjDK0itITmFdW1jWRizoByXgowUA83Nt8cmzbevYF7qlAfpI3kIp8qtd4VCZ+QIdHEzzXtF0thrlEK7SPf/cOnLhW3d5dXKEiz0FV08n32P4yiaaAkm14MKrmDjRFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a0yjvQGq; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707927786; x=1739463786;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8/xfsN2JJ5K0biHSMOPQftsQpWMqQOkJvAI5f9o0N8U=;
  b=a0yjvQGqwXDQLecMnmxWH2ZVhfquECBYNfjMEI2sIhd0WCz3YaLR5Op2
   MvGtgcO8nbXmjRqZhwNVPzRIuapU9QfOZGTD9ZUfX9wmk5EoaOJTWH1t7
   UI3iwBkBkT9x8RciFVNx7FfYxkmDouXKGoN+47zACHjt0Va0Q4k58f+zB
   OnXQI7GBdKbubbnqFLFlOd0/C5CXBkkcY6ZNlUxp6vkrY/1Lpx7LUQy49
   fzyA/KBP5P8hyZL7fgr2/rltZb6KFI/hfosZuMbdhgNxQf/2nvA8m2aqx
   s8szjHOGygNZNvvgg5JLFZQXJxRh67afva4c7QjF+cqAIfxAmkBDKYiHX
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="5755633"
X-IronPort-AV: E=Sophos;i="6.06,159,1705392000"; 
   d="scan'208";a="5755633"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 08:23:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,159,1705392000"; 
   d="scan'208";a="26400053"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by fmviesa002.fm.intel.com with ESMTP; 14 Feb 2024 08:23:02 -0800
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Alexander Duyck <alexanderduyck@fb.com>,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 6/7] page_pool: check for DMA sync shortcut earlier
Date: Wed, 14 Feb 2024 17:22:00 +0100
Message-ID: <20240214162201.4168778-7-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240214162201.4168778-1-aleksander.lobakin@intel.com>
References: <20240214162201.4168778-1-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We can save a couple more function calls in the Page Pool code if we
check for dma_skip_sync() earlier, just when we test pp->p.dma_sync.
Move both these checks into an inline wrapper and call the PP wrapper
over the generic DMA sync function only when both are true.
You can't cache the result of dma_skip_sync() in &page_pool, as it may
change anytime if an SWIOTLB buffer is allocated or mapped.

Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 net/core/page_pool.c | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index a9f3c032c45f..a48895d824e2 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -384,16 +384,24 @@ static struct page *__page_pool_get_cached(struct page_pool *pool)
 	return page;
 }
 
-static void page_pool_dma_sync_for_device(struct page_pool *pool,
-					  struct page *page,
-					  unsigned int dma_sync_size)
+static void __page_pool_dma_sync_for_device(struct page_pool *pool,
+					    struct page *page,
+					    u32 dma_sync_size)
 {
 	dma_addr_t dma_addr = page_pool_get_dma_addr(page);
 
 	dma_sync_size = min(dma_sync_size, pool->p.max_len);
-	dma_sync_single_range_for_device(pool->p.dev, dma_addr,
-					 pool->p.offset, dma_sync_size,
-					 pool->p.dma_dir);
+	__dma_sync_single_range_for_device(pool->p.dev, dma_addr,
+					   pool->p.offset, dma_sync_size,
+					   pool->p.dma_dir);
+}
+
+static __always_inline void
+page_pool_dma_sync_for_device(struct page_pool *pool, struct page *page,
+			      u32 dma_sync_size)
+{
+	if (pool->dma_sync && !dma_skip_sync(pool->p.dev))
+		__page_pool_dma_sync_for_device(pool, page, dma_sync_size);
 }
 
 static bool page_pool_dma_map(struct page_pool *pool, struct page *page)
@@ -415,8 +423,7 @@ static bool page_pool_dma_map(struct page_pool *pool, struct page *page)
 	if (page_pool_set_dma_addr(page, dma))
 		goto unmap_failed;
 
-	if (pool->dma_sync)
-		page_pool_dma_sync_for_device(pool, page, pool->p.max_len);
+	page_pool_dma_sync_for_device(pool, page, pool->p.max_len);
 
 	return true;
 
@@ -680,9 +687,7 @@ __page_pool_put_page(struct page_pool *pool, struct page *page,
 	if (likely(page_ref_count(page) == 1 && !page_is_pfmemalloc(page))) {
 		/* Read barrier done in page_ref_count / READ_ONCE */
 
-		if (pool->dma_sync)
-			page_pool_dma_sync_for_device(pool, page,
-						      dma_sync_size);
+		page_pool_dma_sync_for_device(pool, page, dma_sync_size);
 
 		if (allow_direct && in_softirq() &&
 		    page_pool_recycle_in_cache(page, pool))
@@ -793,8 +798,7 @@ static struct page *page_pool_drain_frag(struct page_pool *pool,
 		return NULL;
 
 	if (page_ref_count(page) == 1 && !page_is_pfmemalloc(page)) {
-		if (pool->dma_sync)
-			page_pool_dma_sync_for_device(pool, page, -1);
+		page_pool_dma_sync_for_device(pool, page, -1);
 
 		return page;
 	}
-- 
2.43.0


