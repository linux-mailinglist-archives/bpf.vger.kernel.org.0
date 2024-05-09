Return-Path: <bpf+bounces-29187-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD5068C117D
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 16:47:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22A471F23493
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 14:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 060A013A40B;
	Thu,  9 May 2024 14:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P0lEfVc/"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3641A291;
	Thu,  9 May 2024 14:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715266022; cv=none; b=gQlvuQGf4MtndP7j5d7v+ELT4B/d8YGxv8uK2by/avkkqGG0+G8YD1l9fL149kFAu/PAx3pBJVcAJbbRrtpzs0q+1PIxYrrsPh+FTh1KnYwRilYPX7SX74IpBYxZuKBO5tx68uVVlIoyCSsYrUwJ0vFwey7ktMGCkKGJJitdJ3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715266022; c=relaxed/simple;
	bh=44nu8TQxim7F3121JfCwQxg3SRkVOTAgI+q5yLgxXI8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rcAzPGLKLtB3ogsUbKpT/Ow82wHgtF2urIXwNbv/hSrbZ+xxOOuQA4xcwMsrH0ch3yI2fvvjfW2Es9Wwip9Pgj8wKjWaq4HX0mSfdjGY9NexIbGrMaSJvTAa9KJgGnOCp8NTvv4PdThOw+0RmsX7T/vvEXTfu15+w1N7/fLs/QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P0lEfVc/; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715266021; x=1746802021;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=44nu8TQxim7F3121JfCwQxg3SRkVOTAgI+q5yLgxXI8=;
  b=P0lEfVc/s//qXkMO627xZy+p0BBx7WJJJ0g4j6v0EFv3W2VbF6eHhIqx
   xqf4bVWpl2+dQGB9kzC8of36SZ3ocUOcgrkqs78j/q0d8euETfOJYKBh0
   1XiVEgnxyoKmM5BB/x+37ZQh+PqRGPrWie5WGK//2hq6PrRNYLr18HZ0d
   AyCCEcYG8NxqyChLZrNMQal3svf63oZ04gYHfo6F4XafrJ5yobh+RLf5f
   A7DMdf3NzJmKlJaAOqWkO64qC8SCEXs/RalcWxjvUrTwEJfyO4qum/3zC
   cxqi3Zr/WIY/QyAKiaLwHlCIX+CXgHLv3MSO4QuuI3AplMmU4aUzMDpb2
   A==;
X-CSE-ConnectionGUID: CbB/oyKlTlq2wMwVOZKbKQ==
X-CSE-MsgGUID: js4hFtT2R7um2Kt/2su+7A==
X-IronPort-AV: E=McAfee;i="6600,9927,11067"; a="11052035"
X-IronPort-AV: E=Sophos;i="6.08,148,1712646000"; 
   d="scan'208";a="11052035"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2024 07:47:00 -0700
X-CSE-ConnectionGUID: tiVKl2c0RcGZ8zyTSJAfAw==
X-CSE-MsgGUID: WSHUraYDR+CfMCbB9uynSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,148,1712646000"; 
   d="scan'208";a="34119686"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa004.jf.intel.com with ESMTP; 09 May 2024 07:46:56 -0700
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Steven Price <steven.price@arm.com>,
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
Subject: [PATCH] dma: fix DMA sync for drivers not calling dma_set_mask*()
Date: Thu,  9 May 2024 16:46:16 +0200
Message-ID: <20240509144616.938519-1-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are several reports that the DMA sync shortcut broke non-coherent
devices.
dev->dma_need_sync is false after the &device allocation and if a driver
didn't call dma_set_mask*(), it will still be false even if the device
is not DMA-coherent and thus needs synchronizing. Due to historical
reasons, there's still a lot of drivers not calling it.
Invert the boolean, so that the sync will be performed by default and
the shortcut will be enabled only when calling dma_set_mask*().

Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
Closes: https://lore.kernel.org/lkml/46160534-5003-4809-a408-6b3a3f4921e9@samsung.com
Reported-by: Steven Price <steven.price@arm.com>
Closes: https://lore.kernel.org/lkml/010686f5-3049-46a1-8230-7752a1b433ff@arm.com
Fixes: 32ba8b823252 ("dma: avoid redundant calls for sync operations")
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 include/linux/device.h      |  4 ++--
 include/linux/dma-map-ops.h |  4 ++--
 include/linux/dma-mapping.h |  2 +-
 kernel/dma/mapping.c        | 10 +++++-----
 kernel/dma/swiotlb.c        |  2 +-
 5 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/include/linux/device.h b/include/linux/device.h
index ed95b829f05b..d4b50accff26 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -691,7 +691,7 @@ struct device_physical_location {
  *		and optionall (if the coherent mask is large enough) also
  *		for dma allocations.  This flag is managed by the dma ops
  *		instance from ->dma_supported.
- * @dma_need_sync: The device needs performing DMA sync operations.
+ * @dma_skip_sync: DMA sync operations can be skipped for coherent buffers.
  *
  * At the lowest level, every device in a Linux system is represented by an
  * instance of struct device. The device structure contains the information
@@ -805,7 +805,7 @@ struct device {
 	bool			dma_ops_bypass : 1;
 #endif
 #ifdef CONFIG_DMA_NEED_SYNC
-	bool			dma_need_sync:1;
+	bool			dma_skip_sync:1;
 #endif
 };
 
diff --git a/include/linux/dma-map-ops.h b/include/linux/dma-map-ops.h
index 4893cb89cb52..5217b922d29f 100644
--- a/include/linux/dma-map-ops.h
+++ b/include/linux/dma-map-ops.h
@@ -280,8 +280,8 @@ static inline void dma_reset_need_sync(struct device *dev)
 {
 #ifdef CONFIG_DMA_NEED_SYNC
 	/* Reset it only once so that the function can be called on hotpath */
-	if (unlikely(!dev->dma_need_sync))
-		dev->dma_need_sync = true;
+	if (unlikely(dev->dma_skip_sync))
+		dev->dma_skip_sync = false;
 #endif
 }
 
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index eb4e15893b6c..f693aafe221f 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -295,7 +295,7 @@ bool __dma_need_sync(struct device *dev, dma_addr_t dma_addr);
 static inline bool dma_dev_need_sync(const struct device *dev)
 {
 	/* Always call DMA sync operations when debugging is enabled */
-	return dev->dma_need_sync || IS_ENABLED(CONFIG_DMA_API_DEBUG);
+	return !dev->dma_skip_sync || IS_ENABLED(CONFIG_DMA_API_DEBUG);
 }
 
 static inline void dma_sync_single_for_cpu(struct device *dev, dma_addr_t addr,
diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index 3524bc92c37f..3f77c3f8d16d 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -392,7 +392,7 @@ bool __dma_need_sync(struct device *dev, dma_addr_t dma_addr)
 
 	if (dma_map_direct(dev, ops))
 		/*
-		 * dma_need_sync could've been reset on first SWIOTLB buffer
+		 * dma_skip_sync could've been reset on first SWIOTLB buffer
 		 * mapping, but @dma_addr is not necessary an SWIOTLB buffer.
 		 * In this case, fall back to more granular check.
 		 */
@@ -407,20 +407,20 @@ static void dma_setup_need_sync(struct device *dev)
 
 	if (dma_map_direct(dev, ops) || (ops->flags & DMA_F_CAN_SKIP_SYNC))
 		/*
-		 * dma_need_sync will be reset to %true on first SWIOTLB buffer
+		 * dma_skip_sync will be reset to %false on first SWIOTLB buffer
 		 * mapping, if any. During the device initialization, it's
 		 * enough to check only for the DMA coherence.
 		 */
-		dev->dma_need_sync = !dev_is_dma_coherent(dev);
+		dev->dma_skip_sync = dev_is_dma_coherent(dev);
 	else if (!ops->sync_single_for_device && !ops->sync_single_for_cpu &&
 		 !ops->sync_sg_for_device && !ops->sync_sg_for_cpu)
 		/*
 		 * Synchronization is not possible when none of DMA sync ops
 		 * is set.
 		 */
-		dev->dma_need_sync = false;
+		dev->dma_skip_sync = true;
 	else
-		dev->dma_need_sync = true;
+		dev->dma_skip_sync = false;
 }
 #else /* !CONFIG_DMA_NEED_SYNC */
 static inline void dma_setup_need_sync(struct device *dev) { }
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index ae3e593eaadb..068134697cf1 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -1409,7 +1409,7 @@ phys_addr_t swiotlb_tbl_map_single(struct device *dev, phys_addr_t orig_addr,
 	}
 
 	/*
-	 * If dma_need_sync wasn't set, reset it on first SWIOTLB buffer
+	 * If dma_skip_sync was set, reset it on first SWIOTLB buffer
 	 * mapping to always sync SWIOTLB buffers.
 	 */
 	dma_reset_need_sync(dev);
-- 
2.45.0


