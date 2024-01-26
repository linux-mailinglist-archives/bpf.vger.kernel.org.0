Return-Path: <bpf+bounces-20391-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B07A83DB3C
	for <lists+bpf@lfdr.de>; Fri, 26 Jan 2024 14:56:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3AF1291779
	for <lists+bpf@lfdr.de>; Fri, 26 Jan 2024 13:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7DF61BF42;
	Fri, 26 Jan 2024 13:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c4CaJMz0"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA531BDD7;
	Fri, 26 Jan 2024 13:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706277360; cv=none; b=HNA6NyqHqSn26Zn1W7O/9fXHaVjv+lsQCM2TJIlIbPENHrh2n/4kEdmLa+v0EMNW1ZWqGjxyxzQ3O18M3LLq3uMOYNHI4vduM+Tf7YbPEfNqxxsui3RASheDg58UegVHysKId+r1cOl1myWaPi4VxYWRAttbSeW86iVxJTrSqAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706277360; c=relaxed/simple;
	bh=0Fwr/dcYEqlykVNBuyY0nc0tFWCDTHupBFPwfuK4dXU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MpS5uJg4F5M8oMdrwYiZEjuE5xJr7Ui5ydxucBIGhsUXI09xDCdkTgOcah8vQD+kCzRpD6gxlF88fOFZNVLhOUE4KY0o8R3nSeEt4/niJkuK+1uxJNraHD1GOUbxEF3ZD8xjHmAkZbpA1ZLoHc5AGqMdgqluizAxvlojhVimHZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c4CaJMz0; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706277358; x=1737813358;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0Fwr/dcYEqlykVNBuyY0nc0tFWCDTHupBFPwfuK4dXU=;
  b=c4CaJMz0m7b/wgi08Z5caxLDwhHVwBmZXxGW51SyAqUOHTiZp1bQa2X6
   6RMiizBjOI2c+RDFUSrYN/hJpKD7fY37Pbxmptc0/FQ5ihhFdP2dofCMC
   +9dnQW79fNSk82B1j/lfG5xIR6ohkV7fqrDEsfnN1cLsxV9PUxOyYyznQ
   ohFdnoQ2PV58rs9Y1FSAAhrzTY/nXGKpkpJ93kQVIJzgq9ckrxCOwK2wu
   d3U+GXpH5e0zVAxWUBVH/q+GjusGVH0ONYp/zPjjrK8f/RH2LdblVQIWZ
   joQFEjs5CazGREXHIfjinN7WWSv7Kat1TBazmEvjOHtme+G9Oev7fjkAl
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="15998414"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="15998414"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2024 05:55:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="821142842"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="821142842"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orsmga001.jf.intel.com with ESMTP; 26 Jan 2024 05:55:52 -0800
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
Subject: [PATCH net-next 1/7] dma: compile-out DMA sync op calls when not used
Date: Fri, 26 Jan 2024 14:54:50 +0100
Message-ID: <20240126135456.704351-2-aleksander.lobakin@intel.com>
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

Some platforms do have DMA, but DMA there is always direct and coherent.
Currently, even on such platforms DMA sync operations are compiled and
called.
Add a new hidden Kconfig symbol, DMA_NEED_SYNC, and set it only when
either sync operations are needed or there is DMA ops or swiotlb
enabled. Set dma_need_sync() and dma_skip_sync() (stub for now)
depending on this symbol state and don't call sync ops when
dma_skip_sync() is true.
The change allows for future optimizations of DMA sync calls depending
on compile-time or runtime conditions.

Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 kernel/dma/Kconfig          |  4 ++
 include/linux/dma-mapping.h | 92 +++++++++++++++++++++++++------------
 kernel/dma/mapping.c        | 26 ++++++-----
 3 files changed, 81 insertions(+), 41 deletions(-)

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
index 4a658de44ee9..9dd7e1578bf6 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -117,14 +117,14 @@ dma_addr_t dma_map_resource(struct device *dev, phys_addr_t phys_addr,
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
+void __dma_sync_single_for_cpu(struct device *dev, dma_addr_t addr,
+			       size_t size, enum dma_data_direction dir);
+void __dma_sync_single_for_device(struct device *dev, dma_addr_t addr,
+				  size_t size, enum dma_data_direction dir);
+void __dma_sync_sg_for_cpu(struct device *dev, struct scatterlist *sg,
+			   int nelems, enum dma_data_direction dir);
+void __dma_sync_sg_for_device(struct device *dev, struct scatterlist *sg,
+			      int nelems, enum dma_data_direction dir);
 void *dma_alloc_attrs(struct device *dev, size_t size, dma_addr_t *dma_handle,
 		gfp_t flag, unsigned long attrs);
 void dma_free_attrs(struct device *dev, size_t size, void *cpu_addr,
@@ -147,7 +147,6 @@ u64 dma_get_required_mask(struct device *dev);
 bool dma_addressing_limited(struct device *dev);
 size_t dma_max_mapping_size(struct device *dev);
 size_t dma_opt_mapping_size(struct device *dev);
-bool dma_need_sync(struct device *dev, dma_addr_t dma_addr);
 unsigned long dma_get_merge_boundary(struct device *dev);
 struct sg_table *dma_alloc_noncontiguous(struct device *dev, size_t size,
 		enum dma_data_direction dir, gfp_t gfp, unsigned long attrs);
@@ -195,20 +194,24 @@ static inline void dma_unmap_resource(struct device *dev, dma_addr_t addr,
 		size_t size, enum dma_data_direction dir, unsigned long attrs)
 {
 }
-static inline void dma_sync_single_for_cpu(struct device *dev, dma_addr_t addr,
-		size_t size, enum dma_data_direction dir)
+static inline void __dma_sync_single_for_cpu(struct device *dev,
+					     dma_addr_t addr, size_t size,
+					     enum dma_data_direction dir)
 {
 }
-static inline void dma_sync_single_for_device(struct device *dev,
-		dma_addr_t addr, size_t size, enum dma_data_direction dir)
+static inline void __dma_sync_single_for_device(struct device *dev,
+						dma_addr_t addr, size_t size,
+						enum dma_data_direction dir)
 {
 }
-static inline void dma_sync_sg_for_cpu(struct device *dev,
-		struct scatterlist *sg, int nelems, enum dma_data_direction dir)
+static inline void __dma_sync_sg_for_cpu(struct device *dev,
+					 struct scatterlist *sg, int nelems,
+					 enum dma_data_direction dir)
 {
 }
-static inline void dma_sync_sg_for_device(struct device *dev,
-		struct scatterlist *sg, int nelems, enum dma_data_direction dir)
+static inline void __dma_sync_sg_for_device(struct device *dev,
+					    struct scatterlist *sg, int nelems,
+					    enum dma_data_direction dir)
 {
 }
 static inline int dma_mapping_error(struct device *dev, dma_addr_t dma_addr)
@@ -277,10 +280,6 @@ static inline size_t dma_opt_mapping_size(struct device *dev)
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
@@ -348,20 +347,55 @@ static inline void dma_unmap_single_attrs(struct device *dev, dma_addr_t addr,
 	return dma_unmap_page_attrs(dev, addr, size, dir, attrs);
 }
 
-static inline void dma_sync_single_range_for_cpu(struct device *dev,
-		dma_addr_t addr, unsigned long offset, size_t size,
-		enum dma_data_direction dir)
+static inline void
+__dma_sync_single_range_for_cpu(struct device *dev, dma_addr_t addr,
+				unsigned long offset, size_t size,
+				enum dma_data_direction dir)
 {
-	return dma_sync_single_for_cpu(dev, addr + offset, size, dir);
+	__dma_sync_single_for_cpu(dev, addr + offset, size, dir);
 }
 
-static inline void dma_sync_single_range_for_device(struct device *dev,
-		dma_addr_t addr, unsigned long offset, size_t size,
-		enum dma_data_direction dir)
+static inline void
+__dma_sync_single_range_for_device(struct device *dev, dma_addr_t addr,
+				   unsigned long offset, size_t size,
+				   enum dma_data_direction dir)
 {
-	return dma_sync_single_for_device(dev, addr + offset, size, dir);
+	__dma_sync_single_for_device(dev, addr + offset, size, dir);
 }
 
+#ifdef CONFIG_DMA_NEED_SYNC
+
+#define dma_skip_sync(dev)			false
+
+bool dma_need_sync(struct device *dev, dma_addr_t dma_addr);
+
+#else /* !CONFIG_DMA_NEED_SYNC */
+
+#define dma_skip_sync(dev)			true
+#define dma_need_sync(dev, dma_addr)		false
+
+#endif /* !CONFIG_DMA_NEED_SYNC */
+
+#define dma_check_sync(op, dev, ...)					  \
+	do {								  \
+		if (!dma_skip_sync(dev))				  \
+			op(dev, __VA_ARGS__);				  \
+	} while (0)
+
+#define dma_sync_single_for_cpu(d, a, s, r)				  \
+	dma_check_sync(__dma_sync_single_for_cpu, d, a, s, r)
+#define dma_sync_single_for_device(d, a, s, r)				  \
+	dma_check_sync(__dma_sync_single_for_device, d, a, s, r)
+#define dma_sync_sg_for_cpu(d, s, n, r)					  \
+	dma_check_sync(__dma_sync_sg_for_cpu, d, s, n, r)
+#define dma_sync_sg_for_device(d, s, n, r)				  \
+	dma_check_sync(__dma_sync_sg_for_device, d, s, n, r)
+
+#define dma_sync_single_range_for_cpu(d, a, o, s, r)			  \
+	dma_check_sync(__dma_sync_single_range_for_cpu, d, a, o, s, r)
+#define dma_sync_single_range_for_device(d, a, o, s, r)			  \
+	dma_check_sync(__dma_sync_single_range_for_device, d, a, o, s, r)
+
 /**
  * dma_unmap_sgtable - Unmap the given buffer for DMA
  * @dev:	The device for which to perform the DMA operation
diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index 58db8fd70471..a30f37f9d4db 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -329,8 +329,8 @@ void dma_unmap_resource(struct device *dev, dma_addr_t addr, size_t size,
 }
 EXPORT_SYMBOL(dma_unmap_resource);
 
-void dma_sync_single_for_cpu(struct device *dev, dma_addr_t addr, size_t size,
-		enum dma_data_direction dir)
+void __dma_sync_single_for_cpu(struct device *dev, dma_addr_t addr,
+			       size_t size, enum dma_data_direction dir)
 {
 	const struct dma_map_ops *ops = get_dma_ops(dev);
 
@@ -341,10 +341,10 @@ void dma_sync_single_for_cpu(struct device *dev, dma_addr_t addr, size_t size,
 		ops->sync_single_for_cpu(dev, addr, size, dir);
 	debug_dma_sync_single_for_cpu(dev, addr, size, dir);
 }
-EXPORT_SYMBOL(dma_sync_single_for_cpu);
+EXPORT_SYMBOL(__dma_sync_single_for_cpu);
 
-void dma_sync_single_for_device(struct device *dev, dma_addr_t addr,
-		size_t size, enum dma_data_direction dir)
+void __dma_sync_single_for_device(struct device *dev, dma_addr_t addr,
+				  size_t size, enum dma_data_direction dir)
 {
 	const struct dma_map_ops *ops = get_dma_ops(dev);
 
@@ -355,10 +355,10 @@ void dma_sync_single_for_device(struct device *dev, dma_addr_t addr,
 		ops->sync_single_for_device(dev, addr, size, dir);
 	debug_dma_sync_single_for_device(dev, addr, size, dir);
 }
-EXPORT_SYMBOL(dma_sync_single_for_device);
+EXPORT_SYMBOL(__dma_sync_single_for_device);
 
-void dma_sync_sg_for_cpu(struct device *dev, struct scatterlist *sg,
-		    int nelems, enum dma_data_direction dir)
+void __dma_sync_sg_for_cpu(struct device *dev, struct scatterlist *sg,
+			   int nelems, enum dma_data_direction dir)
 {
 	const struct dma_map_ops *ops = get_dma_ops(dev);
 
@@ -369,10 +369,10 @@ void dma_sync_sg_for_cpu(struct device *dev, struct scatterlist *sg,
 		ops->sync_sg_for_cpu(dev, sg, nelems, dir);
 	debug_dma_sync_sg_for_cpu(dev, sg, nelems, dir);
 }
-EXPORT_SYMBOL(dma_sync_sg_for_cpu);
+EXPORT_SYMBOL(__dma_sync_sg_for_cpu);
 
-void dma_sync_sg_for_device(struct device *dev, struct scatterlist *sg,
-		       int nelems, enum dma_data_direction dir)
+void __dma_sync_sg_for_device(struct device *dev, struct scatterlist *sg,
+			      int nelems, enum dma_data_direction dir)
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
@@ -841,6 +841,7 @@ size_t dma_opt_mapping_size(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(dma_opt_mapping_size);
 
+#ifdef CONFIG_DMA_NEED_SYNC
 bool dma_need_sync(struct device *dev, dma_addr_t dma_addr)
 {
 	const struct dma_map_ops *ops = get_dma_ops(dev);
@@ -850,6 +851,7 @@ bool dma_need_sync(struct device *dev, dma_addr_t dma_addr)
 	return ops->sync_single_for_cpu || ops->sync_single_for_device;
 }
 EXPORT_SYMBOL_GPL(dma_need_sync);
+#endif /* CONFIG_DMA_NEED_SYNC */
 
 unsigned long dma_get_merge_boundary(struct device *dev)
 {
-- 
2.43.0


