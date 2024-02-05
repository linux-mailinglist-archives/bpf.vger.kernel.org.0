Return-Path: <bpf+bounces-21206-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EF2C84985D
	for <lists+bpf@lfdr.de>; Mon,  5 Feb 2024 12:06:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9EB19B27895
	for <lists+bpf@lfdr.de>; Mon,  5 Feb 2024 11:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6C3219474;
	Mon,  5 Feb 2024 11:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="isyPU9kM"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE5718E3F;
	Mon,  5 Feb 2024 11:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707131118; cv=none; b=RqplZx86FbQxssFhm/f4PDfFjFNzHsFdWwJ0PPX1cuceG4qryMuntZi/Kd2XILT39H6CbbP5TN/QUyqKX2qbVodXcrDBYyRLp5Ltg11wlcMtWbnZhuhgpmyS7yyWIa7tlo9VWyJWUcb+79vmbzqdQN3tSFOYdgbi+qgGwXqJDv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707131118; c=relaxed/simple;
	bh=ZBi16G6nTGV1woqfWZjvwuEuRwW/kOjMRUhMHdPBUnI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ek2TqCSSNXh/PdsvT7O7A4pAQAbdrGmOI8HOJBkZumHxkofURpJ9ZcX8UV+ApCb6rzZh/WhNscye7roSJBjjnvwqwEaeMFKnVtVGJooGIJkkj3DdT0YTZ8b7MzQQ+ZGI60e35LSihs9Rkc7JGvSOj9OoAqkTPVOoB7oWCbkKbFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=isyPU9kM; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707131116; x=1738667116;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZBi16G6nTGV1woqfWZjvwuEuRwW/kOjMRUhMHdPBUnI=;
  b=isyPU9kMIlsqXC5nVw40wkKpZrkkr7LE7a30PbuzS6IMQ/GHX9bKMSLz
   /E9s1RvQ+46YBHW0q3gKUsKUcpVVDQVitEHOOc0ROjbShyVSX7rDcxSjM
   gMberNiDxGDL3Spw1+QyEKMwfJnG1Hxkoz7c8AN+4Ew3lyZivO4oSSyHl
   kLMHOvc8Dzlg+EjkiQ4ClreOzNVpldTNF6PzMvkZyWjor2zKNiUc+FAT0
   YiG2G0Wvaf4ZvKz20QZM63jfBmMdAL6sLqreHJPMzEFg9VydDpVuatRFw
   OR1ONmn29zj/nHcUWx1ovcUwpUv3eMpGv734shYLItiiKCijpsiSf7Dqb
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10974"; a="25945285"
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="25945285"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 03:05:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="5327858"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by fmviesa004.fm.intel.com with ESMTP; 05 Feb 2024 03:05:11 -0800
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
Subject: [PATCH net-next v2 2/7] dma: avoid redundant calls for sync operations
Date: Mon,  5 Feb 2024 12:04:21 +0100
Message-ID: <20240205110426.764393-3-aleksander.lobakin@intel.com>
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

Quite often, NIC devices do not need dma_sync operations on x86_64
at least.
Indeed, when dev_is_dma_coherent(dev) is true and
dev_use_swiotlb(dev) is false, iommu_dma_sync_single_for_cpu()
and friends do nothing.

However, indirectly calling them when CONFIG_RETPOLINE=y consumes about
10% of cycles on a cpu receiving packets from softirq at ~100Gbit rate.
Even if/when CONFIG_RETPOLINE is not set, there is a cost of about 3%.

Add dev->skip_dma_sync boolean which is set during the device
initialization depending on the setup: dev_is_dma_coherent() for the
direct DMA, !(sync_single_for_device || sync_single_for_cpu) or the new
dma_map_ops flag, %DMA_F_CAN_SKIP_SYNC, advertised for non-NULL DMA ops.
Then later, if/when swiotlb is used for the first time, the flag
is turned off, from swiotlb_tbl_map_single().

On iavf, the UDP trafficgen with XDP_DROP in skb mode test shows
+3-5% increase for direct DMA.

In case some device doesn't work with the shortcut:
* include <linux/dma-map-ops.h> to the driver source;
* call dma_set_skip_sync(dev, false) at the beginning of the probe
  callback. This will disable the shortcut and force DMA syncs.

Suggested-by: Christoph Hellwig <hch@lst.de> # direct DMA shortcut
Co-developed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 include/linux/device.h      |  5 +++++
 include/linux/dma-map-ops.h | 20 ++++++++++++++++++
 include/linux/dma-mapping.h |  6 +++++-
 drivers/base/dd.c           |  2 ++
 kernel/dma/mapping.c        | 42 ++++++++++++++++++++++++++++++++++++-
 kernel/dma/swiotlb.c        | 14 +++++++++++++
 6 files changed, 87 insertions(+), 2 deletions(-)

diff --git a/include/linux/device.h b/include/linux/device.h
index 97c4b046c09d..f23e6a32bea0 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -686,6 +686,8 @@ struct device_physical_location {
  *		other devices probe successfully.
  * @dma_coherent: this particular device is dma coherent, even if the
  *		architecture supports non-coherent devices.
+ * @dma_skip_sync: DMA sync operations can be skipped for coherent non-SWIOTLB
+ *		buffers.
  * @dma_ops_bypass: If set to %true then the dma_ops are bypassed for the
  *		streaming DMA operations (->map_* / ->unmap_* / ->sync_*),
  *		and optionall (if the coherent mask is large enough) also
@@ -800,6 +802,9 @@ struct device {
     defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU_ALL)
 	bool			dma_coherent:1;
 #endif
+#ifdef CONFIG_DMA_NEED_SYNC
+	bool			dma_skip_sync:1;
+#endif
 #ifdef CONFIG_DMA_OPS_BYPASS
 	bool			dma_ops_bypass : 1;
 #endif
diff --git a/include/linux/dma-map-ops.h b/include/linux/dma-map-ops.h
index 4abc60f04209..3406fb950980 100644
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
+#define DMA_F_CAN_SKIP_SYNC		BIT(1)
 
 struct dma_map_ops {
 	unsigned int flags;
@@ -111,6 +114,23 @@ static inline void set_dma_ops(struct device *dev,
 }
 #endif /* CONFIG_DMA_OPS */
 
+#ifdef CONFIG_DMA_NEED_SYNC
+void dma_setup_skip_sync(struct device *dev);
+
+static inline void dma_set_skip_sync(struct device *dev, bool skip)
+{
+	dev->dma_skip_sync = skip;
+}
+#else /* !CONFIG_DMA_NEED_SYNC */
+static inline void dma_setup_skip_sync(struct device *dev)
+{
+}
+
+static inline void dma_set_skip_sync(struct device *dev, bool skip)
+{
+}
+#endif /* !CONFIG_DMA_NEED_SYNC */
+
 #ifdef CONFIG_DMA_CMA
 extern struct cma *dma_contiguous_default_area;
 
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 569a4da68f56..03711ae6c4db 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -370,7 +370,11 @@ __dma_sync_single_range_for_device(struct device *dev, dma_addr_t addr,
 
 static inline bool dma_skip_sync(const struct device *dev)
 {
-	return !IS_ENABLED(CONFIG_DMA_NEED_SYNC);
+#ifdef CONFIG_DMA_NEED_SYNC
+	return dev->dma_skip_sync;
+#else
+	return true;
+#endif
 }
 
 static inline bool dma_need_sync(struct device *dev, dma_addr_t dma_addr)
diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 85152537dbf1..67ad3e1d51f6 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -642,6 +642,8 @@ static int really_probe(struct device *dev, struct device_driver *drv)
 			goto pinctrl_bind_failed;
 	}
 
+	dma_setup_skip_sync(dev);
+
 	ret = driver_sysfs_add(dev);
 	if (ret) {
 		pr_err("%s: driver_sysfs_add(%s) failed\n",
diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index 8716e5e8281c..b815e1bbc2d0 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -846,8 +846,14 @@ bool __dma_need_sync(struct device *dev, dma_addr_t dma_addr)
 	const struct dma_map_ops *ops = get_dma_ops(dev);
 
 	if (dma_map_direct(dev, ops))
+		/*
+		 * dma_skip_sync could've been set to false on first SWIOTLB
+		 * buffer mapping, but @dma_addr is not necessary an SWIOTLB
+		 * buffer. In this case, fall back to more granular check.
+		 */
 		return dma_direct_need_sync(dev, dma_addr);
-	return ops->sync_single_for_cpu || ops->sync_single_for_device;
+
+	return true;
 }
 EXPORT_SYMBOL_GPL(__dma_need_sync);
 
@@ -861,3 +867,37 @@ unsigned long dma_get_merge_boundary(struct device *dev)
 	return ops->get_merge_boundary(dev);
 }
 EXPORT_SYMBOL_GPL(dma_get_merge_boundary);
+
+#ifdef CONFIG_DMA_NEED_SYNC
+void dma_setup_skip_sync(struct device *dev)
+{
+	const struct dma_map_ops *ops = get_dma_ops(dev);
+	bool skip;
+
+	if (dma_map_direct(dev, ops))
+		/*
+		 * dma_skip_sync will be set to false on first SWIOTLB buffer
+		 * mapping, if any. During the device initialization, it's
+		 * enough to check only for DMA coherence.
+		 */
+		skip = dev_is_dma_coherent(dev);
+	else if (!ops->sync_single_for_device && !ops->sync_single_for_cpu)
+		/*
+		 * Synchronization is not possible when none of DMA sync ops
+		 * is set. This check precedes the below one as it disables
+		 * the synchronization unconditionally.
+		 */
+		skip = true;
+	else if (ops->flags & DMA_F_CAN_SKIP_SYNC)
+		/*
+		 * Assume that when ``DMA_F_CAN_SKIP_SYNC`` is advertised,
+		 * the conditions for synchronizing are the same as with
+		 * the direct DMA.
+		 */
+		skip = dev_is_dma_coherent(dev);
+	else
+		skip = false;
+
+	dma_set_skip_sync(dev, skip);
+}
+#endif /* CONFIG_DMA_NEED_SYNC */
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index b079a9a8e087..b62ea0a4f106 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -1286,6 +1286,16 @@ static unsigned long mem_used(struct io_tlb_mem *mem)
 
 #endif /* CONFIG_DEBUG_FS */
 
+static inline void swiotlb_disable_dma_skip_sync(struct device *dev)
+{
+	/*
+	 * If dma_skip_sync was set, reset it to false on first SWIOTLB buffer
+	 * mapping/allocation to always sync SWIOTLB buffers.
+	 */
+	if (unlikely(dma_skip_sync(dev)))
+		dma_set_skip_sync(dev, false);
+}
+
 phys_addr_t swiotlb_tbl_map_single(struct device *dev, phys_addr_t orig_addr,
 		size_t mapping_size, size_t alloc_size,
 		unsigned int alloc_align_mask, enum dma_data_direction dir,
@@ -1323,6 +1333,8 @@ phys_addr_t swiotlb_tbl_map_single(struct device *dev, phys_addr_t orig_addr,
 		return (phys_addr_t)DMA_MAPPING_ERROR;
 	}
 
+	swiotlb_disable_dma_skip_sync(dev);
+
 	/*
 	 * Save away the mapping from the original address to the DMA address.
 	 * This is needed when we sync the memory.  Then we sync the buffer if
@@ -1640,6 +1652,8 @@ struct page *swiotlb_alloc(struct device *dev, size_t size)
 	if (index == -1)
 		return NULL;
 
+	swiotlb_disable_dma_skip_sync(dev);
+
 	tlb_addr = slot_addr(pool->start, index);
 
 	return pfn_to_page(PFN_DOWN(tlb_addr));
-- 
2.43.0


