Return-Path: <bpf+bounces-28804-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB5308BE0F4
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 13:23:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87A43288C41
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 11:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1980215E216;
	Tue,  7 May 2024 11:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lV6yX2Iv"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A3715E202;
	Tue,  7 May 2024 11:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715080888; cv=none; b=oGz3lclSlFcu1vGnxJrHa5AHLT6ToD6RwgGQDOkVoUCu3k7m1JGe1ZQL+1L1gL4R3Ak08sVY9mDhsB1zHI8nFbJyLVtqZGxuGVVzkXYlHG10PloadnK0v6I5R87SYcEX5FEyXdwoAKRatq8n+H39vws+POg1Tt4q/VoPqsfLNwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715080888; c=relaxed/simple;
	bh=XBceQ51XZFAPBpfdvnLwnxeSqyFWiJXTfKo8c27B21s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tCX7GjKzfgXpTZ7RSVcqQTP5N5+Ef8hClxdhgeOGr+hicaP+ebDZcv1/E52QkIfruQN3DPgrnItmtL6+mDzkFrO/Jtqyi79UkRfCmPLxCoa1dutIFodB7CkCv+iXFfX9rS8GfSqJx0m0nHnUK5Q/rcuX+9tn0VodBsdGDG9K1rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lV6yX2Iv; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715080887; x=1746616887;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XBceQ51XZFAPBpfdvnLwnxeSqyFWiJXTfKo8c27B21s=;
  b=lV6yX2IvZI8vtk8cvP1Bb3Qdl9Z/OWCITNaNeGiXyDJWRBkt1roNpOTN
   qdtVoS/knvwECY3UTdEt1r2SX90bj2dJ9xm2iFmfa3639QZGqrCSzIcFF
   0fIUQF4GeA1VSV5tf7YuYmX0QXAC24F2klAxuEL4NHJ3C1ZtEBTRRi46Y
   yAS4vk6yro5FSuZ/AXgwx5g1Q1x2M5eS/OoWLP7Dnr49RroRdA6LFTmX4
   JlJxb582GTvnCKO7QAYglLY0jcsSeS2KTZOZqtdVAMGl11NQ6+W4bpR5r
   m1MjEd86pZKlwE6KJN/4/NTYci48zpG/3bX8TqtHerDM++LS9J0F3AyH8
   Q==;
X-CSE-ConnectionGUID: ghOhkAP/RbiI0CB/5IaTrw==
X-CSE-MsgGUID: rhb25FzYRge+r9E7AoL0TA==
X-IronPort-AV: E=McAfee;i="6600,9927,11065"; a="21472695"
X-IronPort-AV: E=Sophos;i="6.08,261,1712646000"; 
   d="scan'208";a="21472695"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2024 04:21:27 -0700
X-CSE-ConnectionGUID: 4SAK3PWdSoGF9EUtoWFXNQ==
X-CSE-MsgGUID: 3//5AGigTuGQhuxdxVkbhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,261,1712646000"; 
   d="scan'208";a="33316332"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa004.jf.intel.com with ESMTP; 07 May 2024 04:21:24 -0700
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
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 6/7] page_pool: check for DMA sync shortcut earlier
Date: Tue,  7 May 2024 13:20:25 +0200
Message-ID: <20240507112026.1803778-7-aleksander.lobakin@intel.com>
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

We can save a couple more function calls in the Page Pool code if we
check for dma_need_sync() earlier, just when we test pp->p.dma_sync.
Move both these checks into an inline wrapper and call the PP wrapper
over the generic DMA sync function only when both are true.
You can't cache the result of dma_need_sync() in &page_pool, as it may
change anytime if an SWIOTLB buffer is allocated or mapped.

Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 net/core/page_pool.c | 33 +++++++++++++++++++--------------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index c2819ff03dd2..8836aaaf2385 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -398,16 +398,26 @@ static struct page *__page_pool_get_cached(struct page_pool *pool)
 	return page;
 }
 
-static void page_pool_dma_sync_for_device(struct page_pool *pool,
-					  struct page *page,
-					  unsigned int dma_sync_size)
+static void __page_pool_dma_sync_for_device(const struct page_pool *pool,
+					    const struct page *page,
+					    u32 dma_sync_size)
 {
+#if defined(CONFIG_HAS_DMA) && defined(CONFIG_DMA_NEED_SYNC)
 	dma_addr_t dma_addr = page_pool_get_dma_addr(page);
 
 	dma_sync_size = min(dma_sync_size, pool->p.max_len);
-	dma_sync_single_range_for_device(pool->p.dev, dma_addr,
-					 pool->p.offset, dma_sync_size,
-					 pool->p.dma_dir);
+	__dma_sync_single_for_device(pool->p.dev, dma_addr + pool->p.offset,
+				     dma_sync_size, pool->p.dma_dir);
+#endif
+}
+
+static __always_inline void
+page_pool_dma_sync_for_device(const struct page_pool *pool,
+			      const struct page *page,
+			      u32 dma_sync_size)
+{
+	if (pool->dma_sync && dma_dev_need_sync(pool->p.dev))
+		__page_pool_dma_sync_for_device(pool, page, dma_sync_size);
 }
 
 static bool page_pool_dma_map(struct page_pool *pool, struct page *page)
@@ -429,8 +439,7 @@ static bool page_pool_dma_map(struct page_pool *pool, struct page *page)
 	if (page_pool_set_dma_addr(page, dma))
 		goto unmap_failed;
 
-	if (pool->dma_sync)
-		page_pool_dma_sync_for_device(pool, page, pool->p.max_len);
+	page_pool_dma_sync_for_device(pool, page, pool->p.max_len);
 
 	return true;
 
@@ -699,9 +708,7 @@ __page_pool_put_page(struct page_pool *pool, struct page *page,
 	if (likely(__page_pool_page_can_be_recycled(page))) {
 		/* Read barrier done in page_ref_count / READ_ONCE */
 
-		if (pool->dma_sync)
-			page_pool_dma_sync_for_device(pool, page,
-						      dma_sync_size);
+		page_pool_dma_sync_for_device(pool, page, dma_sync_size);
 
 		if (allow_direct && in_softirq() &&
 		    page_pool_recycle_in_cache(page, pool))
@@ -812,9 +819,7 @@ static struct page *page_pool_drain_frag(struct page_pool *pool,
 		return NULL;
 
 	if (__page_pool_page_can_be_recycled(page)) {
-		if (pool->dma_sync)
-			page_pool_dma_sync_for_device(pool, page, -1);
-
+		page_pool_dma_sync_for_device(pool, page, -1);
 		return page;
 	}
 
-- 
2.45.0


