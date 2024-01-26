Return-Path: <bpf+bounces-20396-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E7C283DB4F
	for <lists+bpf@lfdr.de>; Fri, 26 Jan 2024 14:58:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29365292754
	for <lists+bpf@lfdr.de>; Fri, 26 Jan 2024 13:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C9291D548;
	Fri, 26 Jan 2024 13:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EdPPIw7x"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880FF1D534;
	Fri, 26 Jan 2024 13:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706277383; cv=none; b=dJA1fqXEy1YVDA0mSwKbcgsoW4xu99ouRLZxaaPF08mEORjyVtinrv5iujS5JY3LRXOoYcz59ncsrf2DeQUTFv8W3mRF7B7aRZD6CZJexSPRAay/CJZ91vcGPO4z/pq3P/3ncKSWD0fd7QSEr+Cz+j4kjB7E30DNdOdJ6CluX7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706277383; c=relaxed/simple;
	bh=lJcKcZaJ9bUxKWPK3JYyftpUHwdTXmx8xUUsBlV5Am8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WQPuo6ssqc7PQyQZWOh03N/c0MW24ZTn5OwRSKRsZBzw9Xgq8j9qU2oltQuC05CTL0+Z/ztc6zzTvQXdhRzJpWDRDqkk+rW8Fwx8fxQZ0EVSvIGn3TV4F3wLG913om0/V+/f8bbokhLxtbfd2aX7bu61MP3TLvQGY9nTUqApdMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EdPPIw7x; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706277381; x=1737813381;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lJcKcZaJ9bUxKWPK3JYyftpUHwdTXmx8xUUsBlV5Am8=;
  b=EdPPIw7xUVHBu/XwnCn5UWHSzD68cWLtu9ohROCpFzLvKv+dwx7HhQ6N
   +LUzDPEPiFfrKKeaOCvl8Ig7trt5cYN8B1gnE4wdtnwsGJ7oZ2uQPLb7o
   dN+AMB/5NI5NBDbBr55owHyKHCS+63aCbFrqz4HLEQQIRocs71cmRf9y/
   wmP42oCJL4xARiSg/0qq0g6A8YrQuZBvtHRCJAcEw5kD042GibtekLly3
   2tMqjFe4bWoNNBY/t1LIPPhGmdh8c+noYXVFaxTjh0xiruy0ibJZfjVdN
   oMUo5pbnqBjFZdf3jdAolwMRaiz1u7/YwVe61bQmUZvCRcvNxCR4tsVPR
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="15998540"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="15998540"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2024 05:56:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="821143040"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="821143040"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orsmga001.jf.intel.com with ESMTP; 26 Jan 2024 05:56:15 -0800
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
Subject: [PATCH net-next 6/7] page_pool: check for DMA sync shortcut earlier
Date: Fri, 26 Jan 2024 14:54:55 +0100
Message-ID: <20240126135456.704351-7-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240126135456.704351-1-aleksander.lobakin@intel.com>
References: <20240126135456.704351-1-aleksander.lobakin@intel.com>
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
index 2c353906407c..cefdd9822fb7 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -369,16 +369,24 @@ static struct page *__page_pool_get_cached(struct page_pool *pool)
 	return page;
 }
 
-static void page_pool_dma_sync_for_device(struct page_pool *pool,
-					  struct page *page,
-					  unsigned int dma_sync_size)
+static void __page_pool_dma_sync_for_device(struct page_pool *pool,
+					    struct page *page,
+					    unsigned int dma_sync_size)
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
+			      unsigned int dma_sync_size)
+{
+	if (pool->dma_sync && !dma_skip_sync(pool->p.dev))
+		__page_pool_dma_sync_for_device(pool, page, dma_sync_size);
 }
 
 static bool page_pool_dma_map(struct page_pool *pool, struct page *page)
@@ -400,8 +408,7 @@ static bool page_pool_dma_map(struct page_pool *pool, struct page *page)
 	if (page_pool_set_dma_addr(page, dma))
 		goto unmap_failed;
 
-	if (pool->dma_sync)
-		page_pool_dma_sync_for_device(pool, page, pool->p.max_len);
+	page_pool_dma_sync_for_device(pool, page, pool->p.max_len);
 
 	return true;
 
@@ -665,9 +672,7 @@ __page_pool_put_page(struct page_pool *pool, struct page *page,
 	if (likely(page_ref_count(page) == 1 && !page_is_pfmemalloc(page))) {
 		/* Read barrier done in page_ref_count / READ_ONCE */
 
-		if (pool->dma_sync)
-			page_pool_dma_sync_for_device(pool, page,
-						      dma_sync_size);
+		page_pool_dma_sync_for_device(pool, page, dma_sync_size);
 
 		if (allow_direct && in_softirq() &&
 		    page_pool_recycle_in_cache(page, pool))
@@ -778,8 +783,7 @@ static struct page *page_pool_drain_frag(struct page_pool *pool,
 		return NULL;
 
 	if (page_ref_count(page) == 1 && !page_is_pfmemalloc(page)) {
-		if (pool->dma_sync)
-			page_pool_dma_sync_for_device(pool, page, -1);
+		page_pool_dma_sync_for_device(pool, page, -1);
 
 		return page;
 	}
-- 
2.43.0


