Return-Path: <bpf+bounces-27545-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EE378AE8D6
	for <lists+bpf@lfdr.de>; Tue, 23 Apr 2024 15:59:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9274E1C21C1B
	for <lists+bpf@lfdr.de>; Tue, 23 Apr 2024 13:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D654139CEA;
	Tue, 23 Apr 2024 13:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ewITrsgr"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544A413790B;
	Tue, 23 Apr 2024 13:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713880735; cv=none; b=tQszpSdyQ3DBmo8q+M5dDLsPoq2SOy61rFvqibttxOo4x8+kTsMdcRdv6m9nndZM4BEby4YA+/5m8W8QZnneVr76DyjMRIe3yzmasVeqJNMAk0xIbpYIixqMU2kRBHDBwcSUZH/5+fdf4lXJZHGkVVrH45uolO4nJXRvEx/p8N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713880735; c=relaxed/simple;
	bh=NmhuzlmNypIrcR1nFCJLZ0OUcLV2LaL6YNQcG9vQrhg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pcq55QAAkC30LKgW4CfI2GKYnDPvTDO0Pk48/6uWYVJjlBHOy3dVglwLGPliHSPNeQAzvpa3s/mxSXxwSTGVoZ8WuyivFdroY+JCFyzNHqDP4DUEkRWueD3BAwFCKUv6Pw3OlFE8WL1Vjw7HECQri+sLoVLn98IkcSgOaZ+pmf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ewITrsgr; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713880733; x=1745416733;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NmhuzlmNypIrcR1nFCJLZ0OUcLV2LaL6YNQcG9vQrhg=;
  b=ewITrsgrJIJn7o3fOqoffIfJt3HyHoupuU5hyO2o5OArd46DDQe2CM/A
   pxTkWrLySC6nhN9G7mkWjTrVGatNp2jW4F6iIPUHsuKY7IFtQvDFfLGKY
   VorFRC5EzxMDEI/yRWKnuAJW2AXFixRDo+dQ/YMhmOBqsOOGOCBE7ddCJ
   p0ygzLVtdY7NT821SqHWkNy4egXPVdb7NvAp+JEJWlTNzvjPxCQviLGC0
   iccfCXKvXurEGMSO0QtXJN7Ap45k5k9JIi+OQuG3BbobkBRpmmJfGax/3
   SzMeZq9aXziryf8NUVv7lpL1s2x/J7ekMA49n10PHZFoY9cCwfIK20Js5
   A==;
X-CSE-ConnectionGUID: rHL7CEcaSruKTlLC7kemdQ==
X-CSE-MsgGUID: 9JG7IvdrS1uYj9zztXUNqA==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="26921441"
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="26921441"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 06:58:53 -0700
X-CSE-ConnectionGUID: ooD2TtQ0QciCoTh6svn2Mg==
X-CSE-MsgGUID: 9sUECdpLQpCaA2IjaAe3vA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="24431803"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by fmviesa008.fm.intel.com with ESMTP; 23 Apr 2024 06:58:49 -0700
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
Subject: [PATCH net-next v4 1/7] dma: compile-out DMA sync op calls when not used
Date: Tue, 23 Apr 2024 15:58:26 +0200
Message-ID: <20240423135832.2271696-2-aleksander.lobakin@intel.com>
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
2.44.0


