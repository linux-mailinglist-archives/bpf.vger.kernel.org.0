Return-Path: <bpf+bounces-27546-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59C3E8AE8D9
	for <lists+bpf@lfdr.de>; Tue, 23 Apr 2024 15:59:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11911285E8E
	for <lists+bpf@lfdr.de>; Tue, 23 Apr 2024 13:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC57813B2A0;
	Tue, 23 Apr 2024 13:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WAdHJ1li"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E51C136E2F;
	Tue, 23 Apr 2024 13:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713880740; cv=none; b=fEgCrox8lph2CYDLVG0BZUKVw6MjTOBlNTQrXSEbA0wicIYQadJPZsp2l1aIBpDmGu8FH82GUI/vpkhsNIRA9by0ky2qmdOmTJAHNx8kxx7rz92VWUMAB2rURoatFdJuLRfg9eiBoNFf5/gdSLHqGPYCLHg+6iLXO6oG+MGDfB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713880740; c=relaxed/simple;
	bh=KhP+84ramHDPXR/BxIZq2xkJs/o5zXz6CG8eXTcgnrM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b4b9l5r2ZZqA2zyfvVYCzQ66citegokkneuxobVd0LajU0s7iY/LJZS8T3Ero4u0A1+anrlYVi+BOOjNSHZu1rqTO7k6lQz5pFD8B59b0UenDXEQBje6tH+UFbuMwSKp2pbt9pPDkz3JwQTbKtGQoUX3YeePU74Jneono4zlIjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WAdHJ1li; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713880738; x=1745416738;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KhP+84ramHDPXR/BxIZq2xkJs/o5zXz6CG8eXTcgnrM=;
  b=WAdHJ1liEGhVQQaXzZYyLaqVaCUI3TlAWhymdLYsAMs9sQdmr0OS0VeH
   C2wrrq0VDNd/dMRCVm1r0p6zaxu0dpD+/wDvdPxp37VtuTqGXVVHndg9G
   t2HzVmKgaTPR44XlMJsv4Eyk4VrKPbIHClrOnq0rsovrwlD+A47I3PoRk
   Dd1An3Cfq6FNhu1vjev1Yk7Y3XRdb8+EJvYVEd6Uc/gddMHNUTBEQhlh1
   ThjWQBDXB98aROWNetOBadCDIYpl7JxG/UsH3miB0pMBQ9SKcorv1OK1Q
   INfS2TPJP5sTj97tecOi+xvGBe6UF5YiNDMhQzf2/NZT+SS14NR2eLMO4
   g==;
X-CSE-ConnectionGUID: imGOK7aVR+mPHqEYKAFPuQ==
X-CSE-MsgGUID: K3zJLsgZRACtHR4u29KpYw==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="26921454"
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="26921454"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 06:58:58 -0700
X-CSE-ConnectionGUID: SGjbaVWISTe+W3u/d5IK/w==
X-CSE-MsgGUID: SV0DFZiFQqu6IvTagsQCIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="24431816"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by fmviesa008.fm.intel.com with ESMTP; 23 Apr 2024 06:58:53 -0700
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
Subject: [PATCH net-next v4 2/7] dma: avoid redundant calls for sync operations
Date: Tue, 23 Apr 2024 15:58:27 +0200
Message-ID: <20240423135832.2271696-3-aleksander.lobakin@intel.com>
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
index a5e0dfc44d24..3b9dddbcdda7 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -1379,6 +1379,12 @@ phys_addr_t swiotlb_tbl_map_single(struct device *dev, phys_addr_t orig_addr,
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
2.44.0


