Return-Path: <bpf+bounces-21205-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25C8E84985A
	for <lists+bpf@lfdr.de>; Mon,  5 Feb 2024 12:05:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B299B27763
	for <lists+bpf@lfdr.de>; Mon,  5 Feb 2024 11:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD10618AE0;
	Mon,  5 Feb 2024 11:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lOUsi0Jo"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83ED618027;
	Mon,  5 Feb 2024 11:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707131114; cv=none; b=l+CVwjYNSuXhF3dQAC9fY+brr9HlRYvCKWmv8uVX6kRj68ArKW5NXx5pca7bZAhSAd3L/nEDqHZOpISZVeBOaJ90yM5XUhYR+h+iYZOB0ule92bqjasDKmBa9Tvuz1h7N/9TDgKx+nIo41UvodbVOgcWGyp+i7t1c1DliMvXKOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707131114; c=relaxed/simple;
	bh=qZtBthYGqwmEme9KNh+V0p9VPVK4TqaRNwdPkzk3SD4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CwIyqn2RwAKYseMCvu4gqravDCfZRmuAaKylAsSiqkuyrSsNSVemRzVGfnEbBh6foWonKyumlxobrCEvR3ReBfCIlFboPmXEbnJ1MX/Gdu0cWNBxmjbBUaaubYnVWMhHZ0BZyggVZbFzylq5sp1fihg45TXj17lAtpllPNg8vYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lOUsi0Jo; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707131112; x=1738667112;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qZtBthYGqwmEme9KNh+V0p9VPVK4TqaRNwdPkzk3SD4=;
  b=lOUsi0Jo+leegoCPtovMvT2o4LjbbN9LEAXw0HVyIZKJK/EEDcv35nXP
   OQOnm4pB1xo7Yszp3RB1pvts6iwHRodIi6fbpNoLop2f/5QQymOHIo0i5
   QqHxTawVwZUD/m+FxrmU/D2MylF2Hc8DM8YFNuQN9Rn+95zcFj6l1go0T
   z9VoCHW6iDRtJfhKLl0P2AxQ28JSqztoRlXiuW2+Nvfs+YS/x3EWNGY+D
   NJXmMA5S3y2mTt36plg6vsJWFKvbN9GXXxDg8xEUUVed2Kt0nQoyTwsT3
   aSvJxar5qzSYBOgyQFi3wfpjbE++RP6uJ/EFYNnTCpATNxSTmLPzcEEMk
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10974"; a="25945232"
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="25945232"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 03:05:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="5327677"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by fmviesa004.fm.intel.com with ESMTP; 05 Feb 2024 03:05:07 -0800
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
Subject: [PATCH net-next v2 1/7] dma: compile-out DMA sync op calls when not used
Date: Mon,  5 Feb 2024 12:04:20 +0100
Message-ID: <20240205110426.764393-2-aleksander.lobakin@intel.com>
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
 kernel/dma/Kconfig          |   4 ++
 include/linux/dma-mapping.h | 118 ++++++++++++++++++++++++++++--------
 kernel/dma/mapping.c        |  28 ++++-----
 3 files changed, 110 insertions(+), 40 deletions(-)

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
index 4a658de44ee9..569a4da68f56 100644
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
@@ -147,7 +147,7 @@ u64 dma_get_required_mask(struct device *dev);
 bool dma_addressing_limited(struct device *dev);
 size_t dma_max_mapping_size(struct device *dev);
 size_t dma_opt_mapping_size(struct device *dev);
-bool dma_need_sync(struct device *dev, dma_addr_t dma_addr);
+bool __dma_need_sync(struct device *dev, dma_addr_t dma_addr);
 unsigned long dma_get_merge_boundary(struct device *dev);
 struct sg_table *dma_alloc_noncontiguous(struct device *dev, size_t size,
 		enum dma_data_direction dir, gfp_t gfp, unsigned long attrs);
@@ -195,20 +195,24 @@ static inline void dma_unmap_resource(struct device *dev, dma_addr_t addr,
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
@@ -277,7 +281,7 @@ static inline size_t dma_opt_mapping_size(struct device *dev)
 {
 	return 0;
 }
-static inline bool dma_need_sync(struct device *dev, dma_addr_t dma_addr)
+static inline bool __dma_need_sync(struct device *dev, dma_addr_t dma_addr)
 {
 	return false;
 }
@@ -348,18 +352,80 @@ static inline void dma_unmap_single_attrs(struct device *dev, dma_addr_t addr,
 	return dma_unmap_page_attrs(dev, addr, size, dir, attrs);
 }
 
-static inline void dma_sync_single_range_for_cpu(struct device *dev,
-		dma_addr_t addr, unsigned long offset, size_t size,
-		enum dma_data_direction dir)
+static inline void
+__dma_sync_single_range_for_cpu(struct device *dev, dma_addr_t addr,
+				unsigned long offset, size_t size,
+				enum dma_data_direction dir)
+{
+	__dma_sync_single_for_cpu(dev, addr + offset, size, dir);
+}
+
+static inline void
+__dma_sync_single_range_for_device(struct device *dev, dma_addr_t addr,
+				   unsigned long offset, size_t size,
+				   enum dma_data_direction dir)
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
+static inline void dma_sync_single_for_cpu(struct device *dev,
+					   dma_addr_t addr, size_t size,
+					   enum dma_data_direction dir)
+{
+	if (!dma_skip_sync(dev))
+		__dma_sync_single_for_cpu(dev, addr, size, dir);
+}
+
+static inline void dma_sync_single_for_device(struct device *dev,
+					      dma_addr_t addr, size_t size,
+					      enum dma_data_direction dir)
+{
+	if (!dma_skip_sync(dev))
+		__dma_sync_single_for_device(dev, addr, size, dir);
+}
+
+static inline void dma_sync_sg_for_cpu(struct device *dev,
+				       struct scatterlist *sg, int nelems,
+				       enum dma_data_direction dir)
+{
+	if (!dma_skip_sync(dev))
+		__dma_sync_sg_for_cpu(dev, sg, nelems, dir);
+}
+
+static inline void dma_sync_sg_for_device(struct device *dev,
+					  struct scatterlist *sg, int nelems,
+					  enum dma_data_direction dir)
+{
+	if (!dma_skip_sync(dev))
+		__dma_sync_sg_for_device(dev, sg, nelems, dir);
+}
+
+static inline void
+dma_sync_single_range_for_cpu(struct device *dev, dma_addr_t addr,
+			      unsigned long offset, size_t size,
+			      enum dma_data_direction dir)
 {
-	return dma_sync_single_for_cpu(dev, addr + offset, size, dir);
+	if (!dma_skip_sync(dev))
+		__dma_sync_single_for_cpu(dev, addr + offset, size, dir);
 }
 
-static inline void dma_sync_single_range_for_device(struct device *dev,
-		dma_addr_t addr, unsigned long offset, size_t size,
-		enum dma_data_direction dir)
+static inline void
+dma_sync_single_range_for_device(struct device *dev, dma_addr_t addr,
+				 unsigned long offset, size_t size,
+				 enum dma_data_direction dir)
 {
-	return dma_sync_single_for_device(dev, addr + offset, size, dir);
+	if (!dma_skip_sync(dev))
+		__dma_sync_single_for_device(dev, addr + offset, size, dir);
 }
 
 /**
diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index 58db8fd70471..8716e5e8281c 100644
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


