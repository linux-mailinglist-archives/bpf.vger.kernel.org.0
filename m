Return-Path: <bpf+bounces-28800-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C2848BE0E7
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 13:22:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE2A11F21AF8
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 11:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC24F15749D;
	Tue,  7 May 2024 11:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n2Zt6Q3f"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A6D7156C6D;
	Tue,  7 May 2024 11:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715080875; cv=none; b=hu4lo7PnH8UFt8qGpPwmERmWnmrLyEhuQsBIsX4bekkEiXEvFwDe4JpLfyextfTkhOTxviQNFQRyAlvHeq2IzC4hDcx9jIzc4juYCxSq6wrxjlmSbQAMOpIw3xRY9mi0mANztBjw28mYLym+2R1Go1UKmhXWpLwMO7N7hvGOML8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715080875; c=relaxed/simple;
	bh=n/q/1Bb7xBI38CUloVyKtVkM3ja0WzNGN0WfG6mxkTg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LC4qVtjDMmNQe4rOwfW1ODvPSZ3okSuRSbudNOfGfzyMAUXWMAiHOnMX54zAUn3QzauU+kUv+67EMwpVUZRRHfSUbgzWLZyWdrV2PdHiy2sBIjZBFvbJAyd1ralif3zri6lyP7SmsrkYsY/SVYp3PFR4cwAx7WNYW0qP0hortXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n2Zt6Q3f; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715080873; x=1746616873;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=n/q/1Bb7xBI38CUloVyKtVkM3ja0WzNGN0WfG6mxkTg=;
  b=n2Zt6Q3fudgTTOt/6Qna6dqfFGS6LIKgMT2xC5KxBwhdXGT1iP3cmvyX
   Kp3DboFpNmKEiFUr8ohnes1BUIQEg3vXvtGRVACXszvHn8Di5hz/Z/HFL
   8Gk7Pgz6xk1wqISiiF5im6GR4Sfbr5p/PtlaqfpFAznVW/LPyqrixHMSt
   4qVuQ5Bw6X/OXeosT48k0yaPbqV4FOd1oZ3aQgzkccRhvX2GWbE2+MzbJ
   6I+zQfgs5hMyIGM2tyhUIIqA3apIR9fdJ20EXfDJYVD/aJTJM408YjArp
   1tdews81teIii+aRXf1zRFxI5rd69JqiRykScobhXw+0jMsjrQPUNmUic
   A==;
X-CSE-ConnectionGUID: QPkthceeSy6C7NCpijFvQg==
X-CSE-MsgGUID: svCqQwPXTUyt7P7JMTYMFg==
X-IronPort-AV: E=McAfee;i="6600,9927,11065"; a="21472590"
X-IronPort-AV: E=Sophos;i="6.08,261,1712646000"; 
   d="scan'208";a="21472590"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2024 04:21:12 -0700
X-CSE-ConnectionGUID: 0b7CD6fIRLikFye2IhELLg==
X-CSE-MsgGUID: UjhQfjmsSlmbjt9bR+r7CA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,261,1712646000"; 
   d="scan'208";a="33316311"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa004.jf.intel.com with ESMTP; 07 May 2024 04:21:09 -0700
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
Subject: [PATCH v6 2/7] dma: avoid redundant calls for sync operations
Date: Tue,  7 May 2024 13:20:21 +0200
Message-ID: <20240507112026.1803778-3-aleksander.lobakin@intel.com>
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

Quite often, devices do not need dma_sync operations on x86_64 at least.
Indeed, when dev_is_dma_coherent(dev) is true and
dev_use_swiotlb(dev) is false, iommu_dma_sync_single_for_cpu()
and friends do nothing.

However, indirectly calling them when CONFIG_RETPOLINE=y consumes about
10% of cycles on a cpu receiving packets from softirq at ~100Gbit rate.
Even if/when CONFIG_RETPOLINE is not set, there is a cost of about 3%.

Add dev->need_dma_sync boolean and turn it off during the device
initialization (dma_set_mask()) depending on the setup:
dev_is_dma_coherent() for the direct DMA, !(sync_single_for_device ||
sync_single_for_cpu) or the new dma_map_ops flag, %DMA_F_CAN_SKIP_SYNC,
advertised for non-NULL DMA ops.
Then later, if/when swiotlb is used for the first time, the flag
is reset back to on, from swiotlb_tbl_map_single().

On iavf, the UDP trafficgen with XDP_DROP in skb mode test shows
+3-5% increase for direct DMA.

Suggested-by: Christoph Hellwig <hch@lst.de> # direct DMA shortcut
Co-developed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 include/linux/device.h      |  4 +++
 include/linux/dma-map-ops.h | 12 ++++++++
 include/linux/dma-mapping.h | 53 +++++++++++++++++++++++++++++++----
 kernel/dma/mapping.c        | 55 +++++++++++++++++++++++++++++--------
 kernel/dma/swiotlb.c        |  6 ++++
 5 files changed, 113 insertions(+), 17 deletions(-)

diff --git a/include/linux/device.h b/include/linux/device.h
index b9f5464f44ed..ed95b829f05b 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -691,6 +691,7 @@ struct device_physical_location {
  *		and optionall (if the coherent mask is large enough) also
  *		for dma allocations.  This flag is managed by the dma ops
  *		instance from ->dma_supported.
+ * @dma_need_sync: The device needs performing DMA sync operations.
  *
  * At the lowest level, every device in a Linux system is represented by an
  * instance of struct device. The device structure contains the information
@@ -803,6 +804,9 @@ struct device {
 #ifdef CONFIG_DMA_OPS_BYPASS
 	bool			dma_ops_bypass : 1;
 #endif
+#ifdef CONFIG_DMA_NEED_SYNC
+	bool			dma_need_sync:1;
+#endif
 };
 
 /**
diff --git a/include/linux/dma-map-ops.h b/include/linux/dma-map-ops.h
index 4abc60f04209..4893cb89cb52 100644
--- a/include/linux/dma-map-ops.h
+++ b/include/linux/dma-map-ops.h
@@ -18,8 +18,11 @@ struct iommu_ops;
  *
  * DMA_F_PCI_P2PDMA_SUPPORTED: Indicates the dma_map_ops implementation can
  * handle PCI P2PDMA pages in the map_sg/unmap_sg operation.
+ * DMA_F_CAN_SKIP_SYNC: DMA sync operations can be skipped if the device is
+ * coherent and it's not an SWIOTLB buffer.
  */
 #define DMA_F_PCI_P2PDMA_SUPPORTED     (1 << 0)
+#define DMA_F_CAN_SKIP_SYNC            (1 << 1)
 
 struct dma_map_ops {
 	unsigned int flags;
@@ -273,6 +276,15 @@ static inline bool dev_is_dma_coherent(struct device *dev)
 }
 #endif /* CONFIG_ARCH_HAS_DMA_COHERENCE_H */
 
+static inline void dma_reset_need_sync(struct device *dev)
+{
+#ifdef CONFIG_DMA_NEED_SYNC
+	/* Reset it only once so that the function can be called on hotpath */
+	if (unlikely(!dev->dma_need_sync))
+		dev->dma_need_sync = true;
+#endif
+}
+
 /*
  * Check whether potential kmalloc() buffers are safe for non-coherent DMA.
  */
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index a569b56b25e2..eb4e15893b6c 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -282,16 +282,59 @@ static inline int dma_mmap_noncontiguous(struct device *dev,
 #endif /* CONFIG_HAS_DMA */
 
 #if defined(CONFIG_HAS_DMA) && defined(CONFIG_DMA_NEED_SYNC)
-void dma_sync_single_for_cpu(struct device *dev, dma_addr_t addr, size_t size,
+void __dma_sync_single_for_cpu(struct device *dev, dma_addr_t addr, size_t size,
 		enum dma_data_direction dir);
-void dma_sync_single_for_device(struct device *dev, dma_addr_t addr,
+void __dma_sync_single_for_device(struct device *dev, dma_addr_t addr,
 		size_t size, enum dma_data_direction dir);
-void dma_sync_sg_for_cpu(struct device *dev, struct scatterlist *sg,
+void __dma_sync_sg_for_cpu(struct device *dev, struct scatterlist *sg,
 		int nelems, enum dma_data_direction dir);
-void dma_sync_sg_for_device(struct device *dev, struct scatterlist *sg,
+void __dma_sync_sg_for_device(struct device *dev, struct scatterlist *sg,
 		int nelems, enum dma_data_direction dir);
-bool dma_need_sync(struct device *dev, dma_addr_t dma_addr);
+bool __dma_need_sync(struct device *dev, dma_addr_t dma_addr);
+
+static inline bool dma_dev_need_sync(const struct device *dev)
+{
+	/* Always call DMA sync operations when debugging is enabled */
+	return dev->dma_need_sync || IS_ENABLED(CONFIG_DMA_API_DEBUG);
+}
+
+static inline void dma_sync_single_for_cpu(struct device *dev, dma_addr_t addr,
+		size_t size, enum dma_data_direction dir)
+{
+	if (dma_dev_need_sync(dev))
+		__dma_sync_single_for_cpu(dev, addr, size, dir);
+}
+
+static inline void dma_sync_single_for_device(struct device *dev,
+		dma_addr_t addr, size_t size, enum dma_data_direction dir)
+{
+	if (dma_dev_need_sync(dev))
+		__dma_sync_single_for_device(dev, addr, size, dir);
+}
+
+static inline void dma_sync_sg_for_cpu(struct device *dev,
+		struct scatterlist *sg, int nelems, enum dma_data_direction dir)
+{
+	if (dma_dev_need_sync(dev))
+		__dma_sync_sg_for_cpu(dev, sg, nelems, dir);
+}
+
+static inline void dma_sync_sg_for_device(struct device *dev,
+		struct scatterlist *sg, int nelems, enum dma_data_direction dir)
+{
+	if (dma_dev_need_sync(dev))
+		__dma_sync_sg_for_device(dev, sg, nelems, dir);
+}
+
+static inline bool dma_need_sync(struct device *dev, dma_addr_t dma_addr)
+{
+	return dma_dev_need_sync(dev) ? __dma_need_sync(dev, dma_addr) : false;
+}
 #else /* !CONFIG_HAS_DMA || !CONFIG_DMA_NEED_SYNC */
+static inline bool dma_dev_need_sync(const struct device *dev)
+{
+	return false;
+}
 static inline void dma_sync_single_for_cpu(struct device *dev, dma_addr_t addr,
 		size_t size, enum dma_data_direction dir)
 {
diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index c78b78e95a26..3524bc92c37f 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -330,7 +330,7 @@ void dma_unmap_resource(struct device *dev, dma_addr_t addr, size_t size,
 EXPORT_SYMBOL(dma_unmap_resource);
 
 #ifdef CONFIG_DMA_NEED_SYNC
-void dma_sync_single_for_cpu(struct device *dev, dma_addr_t addr, size_t size,
+void __dma_sync_single_for_cpu(struct device *dev, dma_addr_t addr, size_t size,
 		enum dma_data_direction dir)
 {
 	const struct dma_map_ops *ops = get_dma_ops(dev);
@@ -342,9 +342,9 @@ void dma_sync_single_for_cpu(struct device *dev, dma_addr_t addr, size_t size,
 		ops->sync_single_for_cpu(dev, addr, size, dir);
 	debug_dma_sync_single_for_cpu(dev, addr, size, dir);
 }
-EXPORT_SYMBOL(dma_sync_single_for_cpu);
+EXPORT_SYMBOL(__dma_sync_single_for_cpu);
 
-void dma_sync_single_for_device(struct device *dev, dma_addr_t addr,
+void __dma_sync_single_for_device(struct device *dev, dma_addr_t addr,
 		size_t size, enum dma_data_direction dir)
 {
 	const struct dma_map_ops *ops = get_dma_ops(dev);
@@ -356,9 +356,9 @@ void dma_sync_single_for_device(struct device *dev, dma_addr_t addr,
 		ops->sync_single_for_device(dev, addr, size, dir);
 	debug_dma_sync_single_for_device(dev, addr, size, dir);
 }
-EXPORT_SYMBOL(dma_sync_single_for_device);
+EXPORT_SYMBOL(__dma_sync_single_for_device);
 
-void dma_sync_sg_for_cpu(struct device *dev, struct scatterlist *sg,
+void __dma_sync_sg_for_cpu(struct device *dev, struct scatterlist *sg,
 		    int nelems, enum dma_data_direction dir)
 {
 	const struct dma_map_ops *ops = get_dma_ops(dev);
@@ -370,9 +370,9 @@ void dma_sync_sg_for_cpu(struct device *dev, struct scatterlist *sg,
 		ops->sync_sg_for_cpu(dev, sg, nelems, dir);
 	debug_dma_sync_sg_for_cpu(dev, sg, nelems, dir);
 }
-EXPORT_SYMBOL(dma_sync_sg_for_cpu);
+EXPORT_SYMBOL(__dma_sync_sg_for_cpu);
 
-void dma_sync_sg_for_device(struct device *dev, struct scatterlist *sg,
+void __dma_sync_sg_for_device(struct device *dev, struct scatterlist *sg,
 		       int nelems, enum dma_data_direction dir)
 {
 	const struct dma_map_ops *ops = get_dma_ops(dev);
@@ -384,18 +384,47 @@ void dma_sync_sg_for_device(struct device *dev, struct scatterlist *sg,
 		ops->sync_sg_for_device(dev, sg, nelems, dir);
 	debug_dma_sync_sg_for_device(dev, sg, nelems, dir);
 }
-EXPORT_SYMBOL(dma_sync_sg_for_device);
+EXPORT_SYMBOL(__dma_sync_sg_for_device);
 
-bool dma_need_sync(struct device *dev, dma_addr_t dma_addr)
+bool __dma_need_sync(struct device *dev, dma_addr_t dma_addr)
 {
 	const struct dma_map_ops *ops = get_dma_ops(dev);
 
 	if (dma_map_direct(dev, ops))
+		/*
+		 * dma_need_sync could've been reset on first SWIOTLB buffer
+		 * mapping, but @dma_addr is not necessary an SWIOTLB buffer.
+		 * In this case, fall back to more granular check.
+		 */
 		return dma_direct_need_sync(dev, dma_addr);
-	return ops->sync_single_for_cpu || ops->sync_single_for_device;
+	return true;
 }
-EXPORT_SYMBOL_GPL(dma_need_sync);
-#endif /* CONFIG_DMA_NEED_SYNC */
+EXPORT_SYMBOL_GPL(__dma_need_sync);
+
+static void dma_setup_need_sync(struct device *dev)
+{
+	const struct dma_map_ops *ops = get_dma_ops(dev);
+
+	if (dma_map_direct(dev, ops) || (ops->flags & DMA_F_CAN_SKIP_SYNC))
+		/*
+		 * dma_need_sync will be reset to %true on first SWIOTLB buffer
+		 * mapping, if any. During the device initialization, it's
+		 * enough to check only for the DMA coherence.
+		 */
+		dev->dma_need_sync = !dev_is_dma_coherent(dev);
+	else if (!ops->sync_single_for_device && !ops->sync_single_for_cpu &&
+		 !ops->sync_sg_for_device && !ops->sync_sg_for_cpu)
+		/*
+		 * Synchronization is not possible when none of DMA sync ops
+		 * is set.
+		 */
+		dev->dma_need_sync = false;
+	else
+		dev->dma_need_sync = true;
+}
+#else /* !CONFIG_DMA_NEED_SYNC */
+static inline void dma_setup_need_sync(struct device *dev) { }
+#endif /* !CONFIG_DMA_NEED_SYNC */
 
 /*
  * The whole dma_get_sgtable() idea is fundamentally unsafe - it seems
@@ -785,6 +814,8 @@ int dma_set_mask(struct device *dev, u64 mask)
 
 	arch_dma_set_mask(dev, mask);
 	*dev->dma_mask = mask;
+	dma_setup_need_sync(dev);
+
 	return 0;
 }
 EXPORT_SYMBOL(dma_set_mask);
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 046da973a7e2..ae3e593eaadb 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -1408,6 +1408,12 @@ phys_addr_t swiotlb_tbl_map_single(struct device *dev, phys_addr_t orig_addr,
 		return (phys_addr_t)DMA_MAPPING_ERROR;
 	}
 
+	/*
+	 * If dma_need_sync wasn't set, reset it on first SWIOTLB buffer
+	 * mapping to always sync SWIOTLB buffers.
+	 */
+	dma_reset_need_sync(dev);
+
 	/*
 	 * Save away the mapping from the original address to the DMA address.
 	 * This is needed when we sync the memory.  Then we sync the buffer if
-- 
2.45.0


