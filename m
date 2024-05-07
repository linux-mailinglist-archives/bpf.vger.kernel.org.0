Return-Path: <bpf+bounces-28799-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C15308BE0E3
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 13:21:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A6571F260B7
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 11:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F489153812;
	Tue,  7 May 2024 11:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kZzJes4i"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F44152191;
	Tue,  7 May 2024 11:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715080871; cv=none; b=lAinaR/N3lXBZ1WCJ01KBLyiPkA7FNJXI4q6f3ZxNk8x/EZZgzMAZ0BH9BkrP5XAvjEsZ1yuk/gmrQdKmvgl/NW7rKDIpDA89HzPhOBojWpSRmuM2mGDyngxfCmXPCJmz2bdEeRPj8n1UG9fo9HXqrB9OGXYZYnLHVRxgoxYAQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715080871; c=relaxed/simple;
	bh=yweqzDe5hTKxj6yfc0j/PwOzUMo+FV4q54VN1Y3+NCs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c/DOnPmHxTw48xnwodATK7jiW5XA32ALSMVCZLweiKVbehdJD0TUmpqDbOwohPI9ixtUzsyQmHDNde01HMxY/MGbADpnnW2jDcaTG6pzFrgJVlqnp+sewrlhrw9eg9rYEXUkbMdxTmvAjlFnkCxnmrJ3UQ8MEEyW09Sfi/ZU4uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kZzJes4i; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715080870; x=1746616870;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yweqzDe5hTKxj6yfc0j/PwOzUMo+FV4q54VN1Y3+NCs=;
  b=kZzJes4iN8fJr5KtXmJgnzmn2x2U5wvmGXPEYwbHziljLHz+BWqSElz2
   2HA4N6VAUR9nIiE5n0L03odCaJIVPqwHl833OnMx4LMb4oXGoa4NCdQvn
   YKOYh1/VAS7Y+VEIqvqamk3YRjIcGui8MltzcXfV55abrd2TfxqKj2bQ1
   aLZpXiUjDwKDC9eQJ1a9kA0ItMxWJbVj85Y8SWZAyiTKoShxsTgPZvsnr
   ly9Hbi9c2jlIoc49PSbdFce0VqeC+Q7L+M9QHpC9ag5HUNKJSJSII+idJ
   kyJe0KlPOyPNcFSG7xvb3BasWjXr7dZkHxsVhYNT+j4M9k4zWOzldVcI6
   g==;
X-CSE-ConnectionGUID: QFEQr6vYTNqOujrO8rGdEQ==
X-CSE-MsgGUID: Ey7yvQDAQLO7MFQPnbqxBg==
X-IronPort-AV: E=McAfee;i="6600,9927,11065"; a="21472556"
X-IronPort-AV: E=Sophos;i="6.08,261,1712646000"; 
   d="scan'208";a="21472556"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2024 04:21:09 -0700
X-CSE-ConnectionGUID: TVD5PKI3QYGb++T05SMQjQ==
X-CSE-MsgGUID: MN4Jxe4FQDubNyM/L2WILQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,261,1712646000"; 
   d="scan'208";a="33316307"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa004.jf.intel.com with ESMTP; 07 May 2024 04:21:06 -0700
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
Subject: [PATCH v6 1/7] dma: compile-out DMA sync op calls when not used
Date: Tue,  7 May 2024 13:20:20 +0200
Message-ID: <20240507112026.1803778-2-aleksander.lobakin@intel.com>
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


