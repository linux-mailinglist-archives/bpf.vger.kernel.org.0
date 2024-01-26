Return-Path: <bpf+bounces-20392-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDC1D83DB3F
	for <lists+bpf@lfdr.de>; Fri, 26 Jan 2024 14:56:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1DA50B2540F
	for <lists+bpf@lfdr.de>; Fri, 26 Jan 2024 13:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CF331C289;
	Fri, 26 Jan 2024 13:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FgSrHqR8"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE31C1BF23;
	Fri, 26 Jan 2024 13:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706277364; cv=none; b=tY+15MWHVrH1KCYiuRpOiCKTDa5mnT+GTrbeHebmM0AdiBpB9wtN0ZcGBK9hwb5QHTNheMplDNlkfMMLaxVGiZiLJd5Y0/Z6hKJs+lB/FlSWHVQsigfUqYmvX6QL10QaE/QnBrvwr27RoQtHHDDGCWwdUvcONcazsjqOnEqXsKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706277364; c=relaxed/simple;
	bh=rj6QSj9HzbDNRiMTVMnvu/T/0Cnfdx/NaV3uspkUg9Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L8KrHE0nhQOT1olxzwe2nPsf20231cn9f284XcjEjq5zeN5jodYC2N/kd7jiKiliuQwvSPcMACd9XG0yZ3MPIpsKSCkTggnpgOK+/ssmBpgdC1NNJGN8yFAQzXKvGdZln+sxZOYXMBNa88/s29pm/Ju1Z9xfCYEIf8Dam2iyqPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FgSrHqR8; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706277363; x=1737813363;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rj6QSj9HzbDNRiMTVMnvu/T/0Cnfdx/NaV3uspkUg9Q=;
  b=FgSrHqR8LSLctbjx2Z6Ztm4d3uXgNKyz9qPdmtPngenKlPgbdaCFJdL/
   UKcqSkpgmk7cOCzWALfCDXl6KKC+HRPE0hjRxFJwjDCtqXve7clsgLTLj
   b0g+dIBERudZFLmxlak09TwQmaexfPUh1O1qV3IsKfr8Ln8Dg5OUXQ8JE
   I0GCa1nNe0f50E12n7sEJybnRlSL78aTeRwUIq6YI5Lwe2jT9z5vK3Ymc
   49/VEgVKLg6tJoNkTbfSFFE2qcBbaVFjVxi2P0keB3RXYNQL10jayxkDs
   2TPsbqepn3cIHgQIgi6H9UnPCRBYpmfUG0jHDmpHPx7IzIoj6d1M0pB19
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="15998437"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="15998437"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2024 05:56:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="821142866"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="821142866"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orsmga001.jf.intel.com with ESMTP; 26 Jan 2024 05:55:57 -0800
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
Subject: [PATCH net-next 2/7] dma: avoid expensive redundant calls for sync operations
Date: Fri, 26 Jan 2024 14:54:51 +0100
Message-ID: <20240126135456.704351-3-aleksander.lobakin@intel.com>
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

From: Eric Dumazet <edumazet@google.com>

Quite often, NIC devices do not need dma_sync operations on x86_64
at least.
Indeed, when dev_is_dma_coherent(dev) is true and
dev_use_swiotlb(dev) is false, iommu_dma_sync_single_for_cpu()
and friends do nothing.

However, indirectly calling them when CONFIG_RETPOLINE=y consumes about
10% of cycles on a cpu receiving packets from softirq at ~100Gbit rate.
Even if/when CONFIG_RETPOLINE is not set, there is a cost of about 3%.

Add dev->skip_dma_sync boolean which is set during the device
initialization depending on the setup: dev_is_dma_coherent() for direct
DMA, !(sync_single_for_device || sync_single_for_cpu) or positive result
from the new callback, dma_map_ops::can_skip_sync for non-NULL DMA ops.
Then later, if/when swiotlb is used for the first time, the flag
is turned off, from swiotlb_tbl_map_single().

On iavf, the UDP trafficgen with XDP_DROP in skb mode test shows
+3-5% increase for direct DMA.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Co-developed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 include/linux/device.h      |  5 +++++
 include/linux/dma-map-ops.h | 17 +++++++++++++++++
 include/linux/dma-mapping.h | 12 ++++++++++--
 drivers/base/dd.c           |  2 ++
 kernel/dma/mapping.c        | 34 +++++++++++++++++++++++++++++++---
 kernel/dma/swiotlb.c        | 14 ++++++++++++++
 6 files changed, 79 insertions(+), 5 deletions(-)

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
index 4abc60f04209..937c295e9da8 100644
--- a/include/linux/dma-map-ops.h
+++ b/include/linux/dma-map-ops.h
@@ -78,6 +78,7 @@ struct dma_map_ops {
 			int nents, enum dma_data_direction dir);
 	void (*cache_sync)(struct device *dev, void *vaddr, size_t size,
 			enum dma_data_direction direction);
+	bool (*can_skip_sync)(struct device *dev);
 	int (*dma_supported)(struct device *dev, u64 mask);
 	u64 (*get_required_mask)(struct device *dev);
 	size_t (*max_mapping_size)(struct device *dev);
@@ -111,6 +112,22 @@ static inline void set_dma_ops(struct device *dev,
 }
 #endif /* CONFIG_DMA_OPS */
 
+#ifdef CONFIG_DMA_NEED_SYNC
+
+static inline void dma_set_skip_sync(struct device *dev, bool skip)
+{
+	dev->dma_skip_sync = skip;
+}
+
+void dma_setup_skip_sync(struct device *dev);
+
+#else /* !CONFIG_DMA_NEED_SYNC */
+
+#define dma_set_skip_sync(dev, skip)		do { } while (0)
+#define dma_setup_skip_sync(dev)		do { } while (0)
+
+#endif /* !CONFIG_DMA_NEED_SYNC */
+
 #ifdef CONFIG_DMA_CMA
 extern struct cma *dma_contiguous_default_area;
 
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 9dd7e1578bf6..bc9f67e0c139 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -365,9 +365,17 @@ __dma_sync_single_range_for_device(struct device *dev, dma_addr_t addr,
 
 #ifdef CONFIG_DMA_NEED_SYNC
 
-#define dma_skip_sync(dev)			false
+static inline bool dma_skip_sync(const struct device *dev)
+{
+	return dev->dma_skip_sync;
+}
+
+bool __dma_need_sync(struct device *dev, dma_addr_t dma_addr);
 
-bool dma_need_sync(struct device *dev, dma_addr_t dma_addr);
+static inline bool dma_need_sync(struct device *dev, dma_addr_t dma_addr)
+{
+	return dma_skip_sync(dev) ? false : __dma_need_sync(dev, dma_addr);
+}
 
 #else /* !CONFIG_DMA_NEED_SYNC */
 
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
index a30f37f9d4db..8fa464b3954e 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -842,15 +842,43 @@ size_t dma_opt_mapping_size(struct device *dev)
 EXPORT_SYMBOL_GPL(dma_opt_mapping_size);
 
 #ifdef CONFIG_DMA_NEED_SYNC
-bool dma_need_sync(struct device *dev, dma_addr_t dma_addr)
+bool __dma_need_sync(struct device *dev, dma_addr_t dma_addr)
 {
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
+}
+EXPORT_SYMBOL_GPL(__dma_need_sync);
+
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
+		skip = true;
+	else if (ops->can_skip_sync)
+		skip = ops->can_skip_sync(dev);
+	else
+		skip = false;
+
+	dma_set_skip_sync(dev, skip);
 }
-EXPORT_SYMBOL_GPL(dma_need_sync);
 #endif /* CONFIG_DMA_NEED_SYNC */
 
 unsigned long dma_get_merge_boundary(struct device *dev)
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


