Return-Path: <bpf+bounces-21210-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CD5384986C
	for <lists+bpf@lfdr.de>; Mon,  5 Feb 2024 12:07:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3764E1F21E68
	for <lists+bpf@lfdr.de>; Mon,  5 Feb 2024 11:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8124A1BC2D;
	Mon,  5 Feb 2024 11:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SkWhEaVb"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3931B964;
	Mon,  5 Feb 2024 11:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707131134; cv=none; b=pmkpeQq7Juq41QBOsGWI3lysJAB7eGhWmAbdVYWrtaH97PC/seyEJ1wB2i4THVN+QMDSHiiMhSXWnBq38lOxR1dhF0Jp8wtYr+SxRIposH23la+OKzF6rKjKNh7uveFFDO0J38OebDZJseBzcTDeSUz0u+TwUKXaX6LzCITwiBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707131134; c=relaxed/simple;
	bh=j5bCxYGboU2nsbzGInCNZJ3ihY7kPTLpx8cHouNYyPI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SRyCQQwbQmnMgTFW+xxh4FZVKTht6/AO26MlNqK1JkD9Me/0x8B731uuHhObE+T0H07D/cm4AgNPRi+5WOkwfO6rU1b1ldujSbh4kO0cQ6YPMrEGkswOb3kbUBjTQPHMtBgOhQ1w1SviHnh66fKelX+3lXE/HgOfQHO+HZ2dcT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SkWhEaVb; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707131132; x=1738667132;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=j5bCxYGboU2nsbzGInCNZJ3ihY7kPTLpx8cHouNYyPI=;
  b=SkWhEaVbVUJyrNvLim5AORJbEsuJnWCH3c1X+xCOwSHdIKQRc0v4kykV
   ZxIAOES6AnOJKygByB26fiSNJecg4NQN9NXeGhb2ZttJ7xgTMmAjAYpIs
   kOGxXjYnOYTh0J3k8j0v7qL5JnvPfHPYOBqgT2EwvU9ZnO+giCN1lRroM
   GcMV5dFBXwxnCo8jGiq6C9oYB6HnMhKz6ZFfoBgfcL4fxT2Cz/cvGq/Th
   A5KC65CWGhuuuHku1+4QONXGS5jkNaauyGaKErNCq8pwn6Y9aZWsirey/
   FRXEFsXJHvieYhtF99qGLd2LrMGTP86sTiv5rVVJOo/7JjcW5Mtaaq1bh
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10974"; a="25945508"
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="25945508"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 03:05:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="5328262"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by fmviesa004.fm.intel.com with ESMTP; 05 Feb 2024 03:05:28 -0800
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
Subject: [PATCH net-next v2 6/7] page_pool: check for DMA sync shortcut earlier
Date: Mon,  5 Feb 2024 12:04:25 +0100
Message-ID: <20240205110426.764393-7-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240205110426.764393-1-aleksander.lobakin@intel.com>
References: <20240205110426.764393-1-aleksander.lobakin@intel.com>
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
index 2c353906407c..d2b411095131 100644
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


