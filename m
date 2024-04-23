Return-Path: <bpf+bounces-27550-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BE738AE8EB
	for <lists+bpf@lfdr.de>; Tue, 23 Apr 2024 16:01:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EA6C1C21D81
	for <lists+bpf@lfdr.de>; Tue, 23 Apr 2024 14:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDA261386DC;
	Tue, 23 Apr 2024 13:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M2MUQ+3l"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D035F13C9A4;
	Tue, 23 Apr 2024 13:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713880763; cv=none; b=NWs2m6WFf90RwbllA+jAnFtFNAFHbriidglZp6dXHYXV+7WFTs3LkeWmyczKrvAfiVX5pOx4mggr3xk8iaMh7zsxrGC5sFXT172C42srjvR5+cN7A/iX5aPq/4RCFBNiPWsEGAx6dqBXNFvU7IPdftH4Nsn6Ux/EDXtiQ8GYnrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713880763; c=relaxed/simple;
	bh=/kkHgP++5WmB+SKjIXakdZj5fr6XaWKzHwhooynuFYM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UgpxhBSof9+UCl/7v8H/N+IrIWQQ/mGH4dcp5C0FvD2oZWPDxmZK3DxY3icr0fi0vl/UaVYc316p5NRlvJyzxCVKV9atIFStKuwdZqSDWuA/02F74cwiKoOJkn+vTjY/m524cx0iIPdHR8AW96RdrxOgH7IbLYO0ZY3oAGy+VwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M2MUQ+3l; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713880762; x=1745416762;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/kkHgP++5WmB+SKjIXakdZj5fr6XaWKzHwhooynuFYM=;
  b=M2MUQ+3lkkCflPOwWCUJ+jmD4Q7gnPTHkysc48KhbdIAVPjXx6zP6Ouy
   m6kQm0wLbSNJnilqC580dDyWoSthGCh8Wpo0wSaP9SvPLYgMzHKXO5neU
   1jy4q1UYRv/l+zWXTtDjAmGR9D477XvVhxnc6DRcmyH/PWsrOB3a4m8g5
   Zr2GjREzhYgX6mQLBOXhMfLyuhYxwFw1Qzg5bNBd3xEfLQIlYhNzJ/jyh
   CuPgDj338ZR+s5j2X4is8Q40h8tQk3x4MBHw0ASaafqnwFAAmpKWytTc3
   3uBoFhKNIHJ7SA5ghzgvd11BG6myYFfR4vsE2MqN3r3pjizKBPO2MK7gn
   A==;
X-CSE-ConnectionGUID: JtLSyKymRqWn6a3HaZKHyw==
X-CSE-MsgGUID: JKuLJ21TQVu1WQN2SWtDRA==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="26921563"
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="26921563"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 06:59:14 -0700
X-CSE-ConnectionGUID: lkVA5DDYRPGD/ekFDj17gw==
X-CSE-MsgGUID: BzZEYJTbQ0qBakydqpjSGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="24431890"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by fmviesa008.fm.intel.com with ESMTP; 23 Apr 2024 06:59:10 -0700
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
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v4 6/7] page_pool: check for DMA sync shortcut earlier
Date: Tue, 23 Apr 2024 15:58:31 +0200
Message-ID: <20240423135832.2271696-7-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240423135832.2271696-1-aleksander.lobakin@intel.com>
References: <20240423135832.2271696-1-aleksander.lobakin@intel.com>
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
 net/core/page_pool.c | 31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 6cf26a68fa91..87319c6365e0 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -398,16 +398,24 @@ static struct page *__page_pool_get_cached(struct page_pool *pool)
 	return page;
 }
 
-static void page_pool_dma_sync_for_device(const struct page_pool *pool,
-					  const struct page *page,
-					  unsigned int dma_sync_size)
+static void __page_pool_dma_sync_for_device(const struct page_pool *pool,
+					    const struct page *page,
+					    u32 dma_sync_size)
 {
 	dma_addr_t dma_addr = page_pool_get_dma_addr(page);
 
 	dma_sync_size = min(dma_sync_size, pool->p.max_len);
-	dma_sync_single_range_for_device(pool->p.dev, dma_addr,
-					 pool->p.offset, dma_sync_size,
-					 pool->p.dma_dir);
+	__dma_sync_single_for_device(pool->p.dev, dma_addr + pool->p.offset,
+				     dma_sync_size, pool->p.dma_dir);
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
@@ -429,8 +437,7 @@ static bool page_pool_dma_map(struct page_pool *pool, struct page *page)
 	if (page_pool_set_dma_addr(page, dma))
 		goto unmap_failed;
 
-	if (pool->dma_sync)
-		page_pool_dma_sync_for_device(pool, page, pool->p.max_len);
+	page_pool_dma_sync_for_device(pool, page, pool->p.max_len);
 
 	return true;
 
@@ -699,9 +706,7 @@ __page_pool_put_page(struct page_pool *pool, struct page *page,
 	if (likely(__page_pool_page_can_be_recycled(page))) {
 		/* Read barrier done in page_ref_count / READ_ONCE */
 
-		if (pool->dma_sync)
-			page_pool_dma_sync_for_device(pool, page,
-						      dma_sync_size);
+		page_pool_dma_sync_for_device(pool, page, dma_sync_size);
 
 		if (allow_direct && page_pool_recycle_in_cache(page, pool))
 			return NULL;
@@ -840,9 +845,7 @@ static struct page *page_pool_drain_frag(struct page_pool *pool,
 		return NULL;
 
 	if (__page_pool_page_can_be_recycled(page)) {
-		if (pool->dma_sync)
-			page_pool_dma_sync_for_device(pool, page, -1);
-
+		page_pool_dma_sync_for_device(pool, page, -1);
 		return page;
 	}
 
-- 
2.44.0


