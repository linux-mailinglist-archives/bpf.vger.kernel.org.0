Return-Path: <bpf+bounces-28665-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EBB28BCB21
	for <lists+bpf@lfdr.de>; Mon,  6 May 2024 11:51:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59D2A1C21699
	for <lists+bpf@lfdr.de>; Mon,  6 May 2024 09:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86BB21448C5;
	Mon,  6 May 2024 09:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ligb693h"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F12C143873;
	Mon,  6 May 2024 09:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714988983; cv=none; b=dJayyhfbo+n7Ps0xix6ieT98J3h7OCxdoqgHiMq9RhYSvcuqpPThIYm1OEMKC/03OkhnejLTfay4TiY/yDBh7/jBhl/0TGULGQGzsoNY/OlY3zKAH78Z5jnRMOB8X00Sz+iwJcGg19UAd9GjMny7+JNGEx2D3FdXdsbJBBiLojE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714988983; c=relaxed/simple;
	bh=zNMrnqdTnU4juvK6TJKM+ormOVy/r4fkCnoEfvM7eVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DpH+eO3xuYiYZ9pG3OQ7/11aK0C0O3M2uOzsT7YtNpd6ZhHuqycIZkHVOBesfB/m+bafhLyDBRa92fIf3hwNuNCM2QUvQJSmMjQY+GWBcZ1+r+jJwcvttrNkamEphrUbr1KSILgIOV8xePbEnzGrvkkg9KefLCdcIUb/I6zQFc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ligb693h; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714988981; x=1746524981;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zNMrnqdTnU4juvK6TJKM+ormOVy/r4fkCnoEfvM7eVQ=;
  b=ligb693hP4UpXuxCg3bHdh67HW9HJMfG7Tn7ycSrzJxm1I/HSRjQcZKU
   LRCawka2R4btzSzGICCY74C8Whndvor0g2ik5CN0tlRIoTIpWXnCcIFIF
   gw5H3JXVRpaGglcekoQ0rJJXc/4RJvJBkJGc/SzDdEMzK2SUnUqAc8J4L
   FY+WB3HiC+pmcX6zX/1BQbupBXI9D/Ahnqc+qRGmu9vfM+57OUPfA0TpG
   ZhaRK6P1FNLWzaDMVQqWR2n4FCzZ7EWCyds2z6mnHBKh2QADPHEldr6Hq
   KLe4aF6dH7bRXFha+k4RejawvdcoE46B9tpbstlwvIbYj0SFi5dihdGb6
   Q==;
X-CSE-ConnectionGUID: rs0zloBdSLKhENU2NKiCxg==
X-CSE-MsgGUID: SlXtbRLqTRe86ujp10oTtw==
X-IronPort-AV: E=McAfee;i="6600,9927,11064"; a="28201058"
X-IronPort-AV: E=Sophos;i="6.07,258,1708416000"; 
   d="scan'208";a="28201058"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2024 02:49:41 -0700
X-CSE-ConnectionGUID: MIuyeYVmSyygRWA7+cSyPw==
X-CSE-MsgGUID: HxPNJw+KS/6gcQDDh5C/1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,258,1708416000"; 
   d="scan'208";a="58995754"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa002.jf.intel.com with ESMTP; 06 May 2024 02:49:38 -0700
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
Subject: [PATCH net-next v5 6/7] page_pool: check for DMA sync shortcut earlier
Date: Mon,  6 May 2024 11:48:54 +0200
Message-ID: <20240506094855.12944-7-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240506094855.12944-1-aleksander.lobakin@intel.com>
References: <20240506094855.12944-1-aleksander.lobakin@intel.com>
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
index e680c4af2745..84132c978773 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -399,16 +399,26 @@ static struct page *__page_pool_get_cached(struct page_pool *pool)
 	return page;
 }
 
-static void page_pool_dma_sync_for_device(const struct page_pool *pool,
-					  const struct page *page,
-					  unsigned int dma_sync_size)
+static void __page_pool_dma_sync_for_device(const struct page_pool *pool,
+					    const struct page *page,
+					    u32 dma_sync_size)
 {
+#ifdef CONFIG_DMA_NEED_SYNC
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
@@ -430,8 +440,7 @@ static bool page_pool_dma_map(struct page_pool *pool, struct page *page)
 	if (page_pool_set_dma_addr(page, dma))
 		goto unmap_failed;
 
-	if (pool->dma_sync)
-		page_pool_dma_sync_for_device(pool, page, pool->p.max_len);
+	page_pool_dma_sync_for_device(pool, page, pool->p.max_len);
 
 	return true;
 
@@ -701,9 +710,7 @@ __page_pool_put_page(struct page_pool *pool, struct page *page,
 	if (likely(__page_pool_page_can_be_recycled(page))) {
 		/* Read barrier done in page_ref_count / READ_ONCE */
 
-		if (pool->dma_sync)
-			page_pool_dma_sync_for_device(pool, page,
-						      dma_sync_size);
+		page_pool_dma_sync_for_device(pool, page, dma_sync_size);
 
 		if (allow_direct && page_pool_recycle_in_cache(page, pool))
 			return NULL;
@@ -842,9 +849,7 @@ static struct page *page_pool_drain_frag(struct page_pool *pool,
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


