Return-Path: <bpf+bounces-21984-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95B0D854E04
	for <lists+bpf@lfdr.de>; Wed, 14 Feb 2024 17:23:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1223C1F267A5
	for <lists+bpf@lfdr.de>; Wed, 14 Feb 2024 16:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F167760861;
	Wed, 14 Feb 2024 16:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="afDpTSMW"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941D06024D;
	Wed, 14 Feb 2024 16:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707927768; cv=none; b=dk+jIYamffrEOE8a9Hbc4tFe/0eZw4OpdSWnbM0GM6L2k05289+ayuY2TTgD/e/KhO6NaoSVm45N3YKsxncN9D/e80Tl+MA12m+98/V+XWm+44UFUXpTHyFwjz947UCC3JiT/6qPyA8eadH5XL/lwKtAsWXQTdl+n3y+aVVkR44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707927768; c=relaxed/simple;
	bh=XjQnDnhe7CydUIm6so/zShzYAWo2nbePKGaBcANZkSc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N8oEuemFelGj2ZInsLXyoQTerWjl/MwqQ3smTVoVGCe1mzM/QW5kbg3+a7pGHTM3lrlEGUTS//YCR7D1R2Irmp6xbB+YnVGe/GbIbBHbsf9l8Ylt+VNsWo93QEQP0SlqOHphuIgaXBCjXzLsn8jD/fasRIaPdPcNkNASRA/IxNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=afDpTSMW; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707927766; x=1739463766;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XjQnDnhe7CydUIm6so/zShzYAWo2nbePKGaBcANZkSc=;
  b=afDpTSMWf8rsPpJ2L7tE/eRGlSEBqg0t5rBne79yfPbR8z6nC2/XtcxG
   0173RMUiejIJ8S/E7t/d77X9WMIySJiBTQKLMED2ZRGxPCZ8Nypm6tVO7
   prypJ37G+79vFNT27R0m453BRmepjnY5Jmko6F4AwvIwct9pLR3NYGeoM
   0AnHIvaRnZLTMn8Dn8VtiEBeRForzW+HnSGwK2Zg451Xanq6x/WXpyTmz
   Z520PxiL8wCnsOn+aefgU3dFGlRfIqCSqzTgk9/jelpVKB1QM1Bldl8s9
   tkstuhAOx1HkCZnORNj+WMGfXpMaXmbrzTtpvs+YcPFN6iiAikpcMdOko
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="5755532"
X-IronPort-AV: E=Sophos;i="6.06,159,1705392000"; 
   d="scan'208";a="5755532"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 08:22:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,159,1705392000"; 
   d="scan'208";a="26399959"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by fmviesa002.fm.intel.com with ESMTP; 14 Feb 2024 08:22:42 -0800
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
Subject: [PATCH net-next v3 1/7] dma: compile-out DMA sync op calls when not used
Date: Wed, 14 Feb 2024 17:21:55 +0100
Message-ID: <20240214162201.4168778-2-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240214162201.4168778-1-aleksander.lobakin@intel.com>
References: <20240214162201.4168778-1-aleksander.lobakin@intel.com>
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
enabled. Set dma_need_sync() and dma_skip_sync() depending on this
symbol state and don't call sync ops when dma_skip_sync() is true.
The change allows for future optimizations of DMA sync calls depending
on compile-time or runtime conditions.

Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 kernel/dma/Kconfig          |  4 ++
 include/linux/dma-mapping.h | 80 +++++++++++++++++++++++++++++++------
 kernel/dma/mapping.c        | 20 +++++-----
 3 files changed, 81 insertions(+), 23 deletions(-)

diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig
index d62f5957f36b..1c9ff05b1ecb 100644
--- a/kernel/dma/Kconfig
+++ b/kernel/dma/Kconfig
@@ -107,6 +107,10 @@ config DMA_BOUNCE_UNALIGNED_KMALLOC
 	bool
 	depends on SWIOTLB
 
+config DMA_NEED_SYNC
+	def_bool ARCH_HAS_SYNC_DMA_FOR_DEVICE || ARCH_HAS_SYNC_DMA_FOR_CPU || \
+		 ARCH_HAS_SYNC_DMA_FOR_CPU_ALL || DMA_OPS || SWIOTLB
+
 config DMA_RESTRICTED_POOL
 	bool "DMA Restricted Pool"
 	depends on OF && OF_RESERVED_MEM && SWIOTLB
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 4a658de44ee9..6c7640441214 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -117,13 +117,13 @@ dma_addr_t dma_map_resource(struct device *dev, phys_addr_t phys_addr,
 		size_t size, enum dma_data_direction dir, unsigned long attrs);
 void dma_unmap_resource(struct device *dev, dma_addr_t addr, size_t size,
 		enum dma_data_direction dir, unsigned long attrs);
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
 void *dma_alloc_attrs(struct device *dev, size_t size, dma_addr_t *dma_handle,
 		gfp_t flag, unsigned long attrs);
@@ -147,7 +147,7 @@ u64 dma_get_required_mask(struct device *dev);
 bool dma_addressing_limited(struct device *dev);
 size_t dma_max_mapping_size(struct device *dev);
 size_t dma_opt_mapping_size(struct device *dev);
-bool dma_need_sync(struct device *dev, dma_addr_t dma_addr);
+bool __dma_need_sync(struct device *dev, dma_addr_t dma_addr);
 unsigned long dma_get_merge_boundary(struct device *dev);
 struct sg_table *dma_alloc_noncontiguous(struct device *dev, size_t size,
 		enum dma_data_direction dir, gfp_t gfp, unsigned long attrs);
@@ -195,19 +195,19 @@ static inline void dma_unmap_resource(struct device *dev, dma_addr_t addr,
 		size_t size, enum dma_data_direction dir, unsigned long attrs)
 {
 }
-static inline void dma_sync_single_for_cpu(struct device *dev, dma_addr_t addr,
-		size_t size, enum dma_data_direction dir)
+static inline void __dma_sync_single_for_cpu(struct device *dev,
+		dma_addr_t addr, size_t size, enum dma_data_direction dir)
 {
 }
-static inline void dma_sync_single_for_device(struct device *dev,
+static inline void __dma_sync_single_for_device(struct device *dev,
 		dma_addr_t addr, size_t size, enum dma_data_direction dir)
 {
 }
-static inline void dma_sync_sg_for_cpu(struct device *dev,
+static inline void __dma_sync_sg_for_cpu(struct device *dev,
 		struct scatterlist *sg, int nelems, enum dma_data_direction dir)
 {
 }
-static inline void dma_sync_sg_for_device(struct device *dev,
+static inline void __dma_sync_sg_for_device(struct device *dev,
 		struct scatterlist *sg, int nelems, enum dma_data_direction dir)
 {
 }
@@ -277,7 +277,7 @@ static inline size_t dma_opt_mapping_size(struct device *dev)
 {
 	return 0;
 }
-static inline bool dma_need_sync(struct device *dev, dma_addr_t dma_addr)
+static inline bool __dma_need_sync(struct device *dev, dma_addr_t dma_addr)
 {
 	return false;
 }
@@ -348,18 +348,72 @@ static inline void dma_unmap_single_attrs(struct device *dev, dma_addr_t addr,
 	return dma_unmap_page_attrs(dev, addr, size, dir, attrs);
 }
 
+static inline void __dma_sync_single_range_for_cpu(struct device *dev,
+		dma_addr_t addr, unsigned long offset, size_t size,
+		enum dma_data_direction dir)
+{
+	__dma_sync_single_for_cpu(dev, addr + offset, size, dir);
+}
+
+static inline void __dma_sync_single_range_for_device(struct device *dev,
+		dma_addr_t addr, unsigned long offset, size_t size,
+		enum dma_data_direction dir)
+{
+	__dma_sync_single_for_device(dev, addr + offset, size, dir);
+}
+
+static inline bool dma_skip_sync(const struct device *dev)
+{
+	return !IS_ENABLED(CONFIG_DMA_NEED_SYNC);
+}
+
+static inline bool dma_need_sync(struct device *dev, dma_addr_t dma_addr)
+{
+	return !dma_skip_sync(dev) ? __dma_need_sync(dev, dma_addr) : false;
+}
+
+static inline void dma_sync_single_for_cpu(struct device *dev, dma_addr_t addr,
+		size_t size, enum dma_data_direction dir)
+{
+	if (!dma_skip_sync(dev))
+		__dma_sync_single_for_cpu(dev, addr, size, dir);
+}
+
+static inline void dma_sync_single_for_device(struct device *dev,
+		dma_addr_t addr, size_t size, enum dma_data_direction dir)
+{
+	if (!dma_skip_sync(dev))
+		__dma_sync_single_for_device(dev, addr, size, dir);
+}
+
+static inline void dma_sync_sg_for_cpu(struct device *dev,
+		struct scatterlist *sg, int nelems, enum dma_data_direction dir)
+{
+	if (!dma_skip_sync(dev))
+		__dma_sync_sg_for_cpu(dev, sg, nelems, dir);
+}
+
+static inline void dma_sync_sg_for_device(struct device *dev,
+		struct scatterlist *sg, int nelems, enum dma_data_direction dir)
+{
+	if (!dma_skip_sync(dev))
+		__dma_sync_sg_for_device(dev, sg, nelems, dir);
+}
+
 static inline void dma_sync_single_range_for_cpu(struct device *dev,
 		dma_addr_t addr, unsigned long offset, size_t size,
 		enum dma_data_direction dir)
 {
-	return dma_sync_single_for_cpu(dev, addr + offset, size, dir);
+	if (!dma_skip_sync(dev))
+		__dma_sync_single_for_cpu(dev, addr + offset, size, dir);
 }
 
 static inline void dma_sync_single_range_for_device(struct device *dev,
 		dma_addr_t addr, unsigned long offset, size_t size,
 		enum dma_data_direction dir)
 {
-	return dma_sync_single_for_device(dev, addr + offset, size, dir);
+	if (!dma_skip_sync(dev))
+		__dma_sync_single_for_device(dev, addr + offset, size, dir);
 }
 
 /**
diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index 58db8fd70471..85feaa0e008c 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -329,7 +329,7 @@ void dma_unmap_resource(struct device *dev, dma_addr_t addr, size_t size,
 }
 EXPORT_SYMBOL(dma_unmap_resource);
 
-void dma_sync_single_for_cpu(struct device *dev, dma_addr_t addr, size_t size,
+void __dma_sync_single_for_cpu(struct device *dev, dma_addr_t addr, size_t size,
 		enum dma_data_direction dir)
 {
 	const struct dma_map_ops *ops = get_dma_ops(dev);
@@ -341,9 +341,9 @@ void dma_sync_single_for_cpu(struct device *dev, dma_addr_t addr, size_t size,
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
@@ -355,9 +355,9 @@ void dma_sync_single_for_device(struct device *dev, dma_addr_t addr,
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
@@ -369,9 +369,9 @@ void dma_sync_sg_for_cpu(struct device *dev, struct scatterlist *sg,
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
@@ -383,7 +383,7 @@ void dma_sync_sg_for_device(struct device *dev, struct scatterlist *sg,
 		ops->sync_sg_for_device(dev, sg, nelems, dir);
 	debug_dma_sync_sg_for_device(dev, sg, nelems, dir);
 }
-EXPORT_SYMBOL(dma_sync_sg_for_device);
+EXPORT_SYMBOL(__dma_sync_sg_for_device);
 
 /*
  * The whole dma_get_sgtable() idea is fundamentally unsafe - it seems
@@ -841,7 +841,7 @@ size_t dma_opt_mapping_size(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(dma_opt_mapping_size);
 
-bool dma_need_sync(struct device *dev, dma_addr_t dma_addr)
+bool __dma_need_sync(struct device *dev, dma_addr_t dma_addr)
 {
 	const struct dma_map_ops *ops = get_dma_ops(dev);
 
@@ -849,7 +849,7 @@ bool dma_need_sync(struct device *dev, dma_addr_t dma_addr)
 		return dma_direct_need_sync(dev, dma_addr);
 	return ops->sync_single_for_cpu || ops->sync_single_for_device;
 }
-EXPORT_SYMBOL_GPL(dma_need_sync);
+EXPORT_SYMBOL_GPL(__dma_need_sync);
 
 unsigned long dma_get_merge_boundary(struct device *dev)
 {
-- 
2.43.0


