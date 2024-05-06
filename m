Return-Path: <bpf+bounces-28660-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25E518BCB12
	for <lists+bpf@lfdr.de>; Mon,  6 May 2024 11:49:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D73A1C217E1
	for <lists+bpf@lfdr.de>; Mon,  6 May 2024 09:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E290B14264C;
	Mon,  6 May 2024 09:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XsDQnh/o"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 232E5142915;
	Mon,  6 May 2024 09:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714988964; cv=none; b=Qc93LXsV1zhgDMdyg3GOkpl6c7tASEszzxPPj3DKF9OTBv+TSQY+rkRbOdAQon4k0IMNJbxJrqfEd5SPxJ/BNd4mfT+l7B0J6TgaTn1N/HI72501lV1OGCgJeNgsJ4+hh/NKiXWViUHir7mekH14u5vX2Dqn0tqmWVjY2UWKKxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714988964; c=relaxed/simple;
	bh=yweqzDe5hTKxj6yfc0j/PwOzUMo+FV4q54VN1Y3+NCs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FTrEYdJ83mZ2+AIDDcv6iXbEYAX9QJCxj6wpxpzAvEfOFCs2ugMdT4JzsxBTZ5YMPHkPIrGpjqLSEpCrk593/xv2LOrO7BOFF2jbJfhWaeo0/GVuIRD5GMWpvLTI6aI+lS3VcgcT3qWFmDe6g5+JY1To9s97bNAnHBsHW6WjgH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XsDQnh/o; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714988961; x=1746524961;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yweqzDe5hTKxj6yfc0j/PwOzUMo+FV4q54VN1Y3+NCs=;
  b=XsDQnh/o1JwPTQ1Q1hEA4lB+Vtkf9vZN80fw3T+6+GYnov4pAjSNoaGz
   N/4PrWw0dFVvMluKiQOEKiPHs9zxoy5xnlkJZtZ8d8JWWiUmSFkT9yCbj
   R/gZCQEgnAYgwERBxRYTsBJNwSogfj0paRTBcCKCtrfWt8/EYXMJ7G8m1
   0OEB5+B9lMRFVMDYTeFlXfxvsmMWBRfZCf9eI2mhyIyDhfY0k66aiDwC1
   H5ebukdc19ntHfnGhNuo7bP33YNw29mTVORPvU1uOl7jUQKs+Jy9i3ZGu
   vipylcL7+Ppt6NcyP0F8N3vsfLO7tpPPARvFQFcU6CGlShvL/tqBKyD2q
   Q==;
X-CSE-ConnectionGUID: 9+1lZ4KpSKafr8MadYmiEA==
X-CSE-MsgGUID: wY+kxy0JT+OUO2frUWRfoA==
X-IronPort-AV: E=McAfee;i="6600,9927,11064"; a="28200950"
X-IronPort-AV: E=Sophos;i="6.07,258,1708416000"; 
   d="scan'208";a="28200950"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2024 02:49:21 -0700
X-CSE-ConnectionGUID: clcfe+2YTUitkRIobQ9qUA==
X-CSE-MsgGUID: fuy5GYqqRw6cyeqMSiyijQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,258,1708416000"; 
   d="scan'208";a="58995710"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa002.jf.intel.com with ESMTP; 06 May 2024 02:49:17 -0700
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
Subject: [PATCH net-next v5 1/7] dma: compile-out DMA sync op calls when not used
Date: Mon,  6 May 2024 11:48:49 +0200
Message-ID: <20240506094855.12944-2-aleksander.lobakin@intel.com>
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

Some platforms do have DMA, but DMA there is always direct and coherent.
Currently, even on such platforms DMA sync operations are compiled and
called.
Add a new hidden Kconfig symbol, DMA_NEED_SYNC, and set it only when
either sync operations are needed or there is DMA ops or swiotlb
or DMA debug is enabled. Compile global dma_sync_*() and dma_need_sync()
only when it's set, otherwise provide empty inline stubs.
The change allows for future optimizations of DMA sync calls depending
on runtime conditions.

Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 kernel/dma/Kconfig          |  5 +++
 include/linux/dma-mapping.h | 62 ++++++++++++++++++++-----------------
 kernel/dma/mapping.c        | 22 +++++++------
 3 files changed, 50 insertions(+), 39 deletions(-)

diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig
index d62f5957f36b..c06e56be0ca1 100644
--- a/kernel/dma/Kconfig
+++ b/kernel/dma/Kconfig
@@ -107,6 +107,11 @@ config DMA_BOUNCE_UNALIGNED_KMALLOC
 	bool
 	depends on SWIOTLB
 
+config DMA_NEED_SYNC
+	def_bool ARCH_HAS_SYNC_DMA_FOR_DEVICE || ARCH_HAS_SYNC_DMA_FOR_CPU || \
+		 ARCH_HAS_SYNC_DMA_FOR_CPU_ALL || DMA_API_DEBUG || DMA_OPS || \
+		 SWIOTLB
+
 config DMA_RESTRICTED_POOL
 	bool "DMA Restricted Pool"
 	depends on OF && OF_RESERVED_MEM && SWIOTLB
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 4a658de44ee9..a569b56b25e2 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -117,14 +117,6 @@ dma_addr_t dma_map_resource(struct device *dev, phys_addr_t phys_addr,
 		size_t size, enum dma_data_direction dir, unsigned long attrs);
 void dma_unmap_resource(struct device *dev, dma_addr_t addr, size_t size,
 		enum dma_data_direction dir, unsigned long attrs);
-void dma_sync_single_for_cpu(struct device *dev, dma_addr_t addr, size_t size,
-		enum dma_data_direction dir);
-void dma_sync_single_for_device(struct device *dev, dma_addr_t addr,
-		size_t size, enum dma_data_direction dir);
-void dma_sync_sg_for_cpu(struct device *dev, struct scatterlist *sg,
-		    int nelems, enum dma_data_direction dir);
-void dma_sync_sg_for_device(struct device *dev, struct scatterlist *sg,
-		       int nelems, enum dma_data_direction dir);
 void *dma_alloc_attrs(struct device *dev, size_t size, dma_addr_t *dma_handle,
 		gfp_t flag, unsigned long attrs);
 void dma_free_attrs(struct device *dev, size_t size, void *cpu_addr,
@@ -147,7 +139,6 @@ u64 dma_get_required_mask(struct device *dev);
 bool dma_addressing_limited(struct device *dev);
 size_t dma_max_mapping_size(struct device *dev);
 size_t dma_opt_mapping_size(struct device *dev);
-bool dma_need_sync(struct device *dev, dma_addr_t dma_addr);
 unsigned long dma_get_merge_boundary(struct device *dev);
 struct sg_table *dma_alloc_noncontiguous(struct device *dev, size_t size,
 		enum dma_data_direction dir, gfp_t gfp, unsigned long attrs);
@@ -195,22 +186,6 @@ static inline void dma_unmap_resource(struct device *dev, dma_addr_t addr,
 		size_t size, enum dma_data_direction dir, unsigned long attrs)
 {
 }
-static inline void dma_sync_single_for_cpu(struct device *dev, dma_addr_t addr,
-		size_t size, enum dma_data_direction dir)
-{
-}
-static inline void dma_sync_single_for_device(struct device *dev,
-		dma_addr_t addr, size_t size, enum dma_data_direction dir)
-{
-}
-static inline void dma_sync_sg_for_cpu(struct device *dev,
-		struct scatterlist *sg, int nelems, enum dma_data_direction dir)
-{
-}
-static inline void dma_sync_sg_for_device(struct device *dev,
-		struct scatterlist *sg, int nelems, enum dma_data_direction dir)
-{
-}
 static inline int dma_mapping_error(struct device *dev, dma_addr_t dma_addr)
 {
 	return -ENOMEM;
@@ -277,10 +252,6 @@ static inline size_t dma_opt_mapping_size(struct device *dev)
 {
 	return 0;
 }
-static inline bool dma_need_sync(struct device *dev, dma_addr_t dma_addr)
-{
-	return false;
-}
 static inline unsigned long dma_get_merge_boundary(struct device *dev)
 {
 	return 0;
@@ -310,6 +281,39 @@ static inline int dma_mmap_noncontiguous(struct device *dev,
 }
 #endif /* CONFIG_HAS_DMA */
 
+#if defined(CONFIG_HAS_DMA) && defined(CONFIG_DMA_NEED_SYNC)
+void dma_sync_single_for_cpu(struct device *dev, dma_addr_t addr, size_t size,
+		enum dma_data_direction dir);
+void dma_sync_single_for_device(struct device *dev, dma_addr_t addr,
+		size_t size, enum dma_data_direction dir);
+void dma_sync_sg_for_cpu(struct device *dev, struct scatterlist *sg,
+		int nelems, enum dma_data_direction dir);
+void dma_sync_sg_for_device(struct device *dev, struct scatterlist *sg,
+		int nelems, enum dma_data_direction dir);
+bool dma_need_sync(struct device *dev, dma_addr_t dma_addr);
+#else /* !CONFIG_HAS_DMA || !CONFIG_DMA_NEED_SYNC */
+static inline void dma_sync_single_for_cpu(struct device *dev, dma_addr_t addr,
+		size_t size, enum dma_data_direction dir)
+{
+}
+static inline void dma_sync_single_for_device(struct device *dev,
+		dma_addr_t addr, size_t size, enum dma_data_direction dir)
+{
+}
+static inline void dma_sync_sg_for_cpu(struct device *dev,
+		struct scatterlist *sg, int nelems, enum dma_data_direction dir)
+{
+}
+static inline void dma_sync_sg_for_device(struct device *dev,
+		struct scatterlist *sg, int nelems, enum dma_data_direction dir)
+{
+}
+static inline bool dma_need_sync(struct device *dev, dma_addr_t dma_addr)
+{
+	return false;
+}
+#endif /* !CONFIG_HAS_DMA || !CONFIG_DMA_NEED_SYNC */
+
 struct page *dma_alloc_pages(struct device *dev, size_t size,
 		dma_addr_t *dma_handle, enum dma_data_direction dir, gfp_t gfp);
 void dma_free_pages(struct device *dev, size_t size, struct page *page,
diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index 58db8fd70471..c78b78e95a26 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -329,6 +329,7 @@ void dma_unmap_resource(struct device *dev, dma_addr_t addr, size_t size,
 }
 EXPORT_SYMBOL(dma_unmap_resource);
 
+#ifdef CONFIG_DMA_NEED_SYNC
 void dma_sync_single_for_cpu(struct device *dev, dma_addr_t addr, size_t size,
 		enum dma_data_direction dir)
 {
@@ -385,6 +386,17 @@ void dma_sync_sg_for_device(struct device *dev, struct scatterlist *sg,
 }
 EXPORT_SYMBOL(dma_sync_sg_for_device);
 
+bool dma_need_sync(struct device *dev, dma_addr_t dma_addr)
+{
+	const struct dma_map_ops *ops = get_dma_ops(dev);
+
+	if (dma_map_direct(dev, ops))
+		return dma_direct_need_sync(dev, dma_addr);
+	return ops->sync_single_for_cpu || ops->sync_single_for_device;
+}
+EXPORT_SYMBOL_GPL(dma_need_sync);
+#endif /* CONFIG_DMA_NEED_SYNC */
+
 /*
  * The whole dma_get_sgtable() idea is fundamentally unsafe - it seems
  * that the intention is to allow exporting memory allocated via the
@@ -841,16 +853,6 @@ size_t dma_opt_mapping_size(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(dma_opt_mapping_size);
 
-bool dma_need_sync(struct device *dev, dma_addr_t dma_addr)
-{
-	const struct dma_map_ops *ops = get_dma_ops(dev);
-
-	if (dma_map_direct(dev, ops))
-		return dma_direct_need_sync(dev, dma_addr);
-	return ops->sync_single_for_cpu || ops->sync_single_for_device;
-}
-EXPORT_SYMBOL_GPL(dma_need_sync);
-
 unsigned long dma_get_merge_boundary(struct device *dev)
 {
 	const struct dma_map_ops *ops = get_dma_ops(dev);
-- 
2.45.0


