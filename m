Return-Path: <bpf+bounces-28801-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B03998BE0EA
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 13:22:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AFF6288AFA
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 11:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFA6915B120;
	Tue,  7 May 2024 11:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XyrsD2pn"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A1D158D64;
	Tue,  7 May 2024 11:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715080878; cv=none; b=Q+UO3MmkppepL+dg5m3sYnq3oLl/gwoOpW1iTdJLS8hwnOKUkbjlMmqxrdelHST4j0dGgjkyEnu7UjLDT4zAjPaNPyjaxTOd+XkHO0/yLRrLn8UHS0p2wvpFwV2tUGvMyQ6K7C8V9caF89Jf+2iEnyNxDINUOBCLYNNrTVfkK60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715080878; c=relaxed/simple;
	bh=OePRKKaLvX5t2WpJwy78xR51eqYohOxFjfCK1TF1x60=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FHrdLyzRNYZclZJH+Jr1DWvyQARlbhemwg01oErWFhgFEEfq+wM5QYt8heG0ish/rkB350J6VlYqX3wBShdr/zDkxJVml1XU39CwP0iP+ndboJkgVGlnm0tOiQyrTZ9DsZc2v72MTT78IAChrsF5J8F/y/ytTWkYt+F/z+KGajo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XyrsD2pn; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715080877; x=1746616877;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OePRKKaLvX5t2WpJwy78xR51eqYohOxFjfCK1TF1x60=;
  b=XyrsD2pn1BHNwY3aPJN3POHMYaa11TwTnkgLmaQd7yGFAtHjtfuwHa2c
   jBRuN+0W3V8iI0HQj17McmsXYPBQLmRbMTQwm31+I8hIIvbfvApv5xj/i
   vVK7+/ps4zVPOSQXXSVPJj+JpeO/g/JgZqWt7AHSbDsODTChEFvl+0frZ
   me6/Y8rgLOnNPDrAVRIoj5LZ7HCSsrOafuZZW3rlr5j7Tj1+kPQKdshTH
   fBsQYuFVmHoYPYR8FCVPKLcKbCLulrTyvgazYaGJ+Ms0cNKPId/Yt1u3C
   wJvBFm8whTsVYIqIqNKIiODszvfhZsASDiHMVjcVKnlStCRrb2M9XHbBu
   A==;
X-CSE-ConnectionGUID: z48oAFXsQTit4aKI7t3dRg==
X-CSE-MsgGUID: kRCmPqOMR/61iJ+XacYqdQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11065"; a="21472624"
X-IronPort-AV: E=Sophos;i="6.08,261,1712646000"; 
   d="scan'208";a="21472624"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2024 04:21:16 -0700
X-CSE-ConnectionGUID: hBHgRQWqRVeWx8rmmW56lA==
X-CSE-MsgGUID: saT51NsYQPWQo6QzBJd+MA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,261,1712646000"; 
   d="scan'208";a="33316318"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa004.jf.intel.com with ESMTP; 07 May 2024 04:21:13 -0700
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
Subject: [PATCH v6 3/7] iommu/dma: avoid expensive indirect calls for sync operations
Date: Tue,  7 May 2024 13:20:22 +0200
Message-ID: <20240507112026.1803778-4-aleksander.lobakin@intel.com>
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

When IOMMU is on, the actual synchronization happens in the same cases
as with the direct DMA. Advertise %DMA_F_CAN_SKIP_SYNC in IOMMU DMA to
skip sync ops calls (indirect) for non-SWIOTLB buffers.

perf profile before the patch:

    18.53%  [kernel]       [k] gq_rx_skb
    14.77%  [kernel]       [k] napi_reuse_skb
     8.95%  [kernel]       [k] skb_release_data
     5.42%  [kernel]       [k] dev_gro_receive
     5.37%  [kernel]       [k] memcpy
<*>  5.26%  [kernel]       [k] iommu_dma_sync_sg_for_cpu
     4.78%  [kernel]       [k] tcp_gro_receive
<*>  4.42%  [kernel]       [k] iommu_dma_sync_sg_for_device
     4.12%  [kernel]       [k] ipv6_gro_receive
     3.65%  [kernel]       [k] gq_pool_get
     3.25%  [kernel]       [k] skb_gro_receive
     2.07%  [kernel]       [k] napi_gro_frags
     1.98%  [kernel]       [k] tcp6_gro_receive
     1.27%  [kernel]       [k] gq_rx_prep_buffers
     1.18%  [kernel]       [k] gq_rx_napi_handler
     0.99%  [kernel]       [k] csum_partial
     0.74%  [kernel]       [k] csum_ipv6_magic
     0.72%  [kernel]       [k] free_pcp_prepare
     0.60%  [kernel]       [k] __napi_poll
     0.58%  [kernel]       [k] net_rx_action
     0.56%  [kernel]       [k] read_tsc
<*>  0.50%  [kernel]       [k] __x86_indirect_thunk_r11
     0.45%  [kernel]       [k] memset

After patch, lines with <*> no longer show up, and overall
cpu usage looks much better (~60% instead of ~72%):

    25.56%  [kernel]       [k] gq_rx_skb
     9.90%  [kernel]       [k] napi_reuse_skb
     7.39%  [kernel]       [k] dev_gro_receive
     6.78%  [kernel]       [k] memcpy
     6.53%  [kernel]       [k] skb_release_data
     6.39%  [kernel]       [k] tcp_gro_receive
     5.71%  [kernel]       [k] ipv6_gro_receive
     4.35%  [kernel]       [k] napi_gro_frags
     4.34%  [kernel]       [k] skb_gro_receive
     3.50%  [kernel]       [k] gq_pool_get
     3.08%  [kernel]       [k] gq_rx_napi_handler
     2.35%  [kernel]       [k] tcp6_gro_receive
     2.06%  [kernel]       [k] gq_rx_prep_buffers
     1.32%  [kernel]       [k] csum_partial
     0.93%  [kernel]       [k] csum_ipv6_magic
     0.65%  [kernel]       [k] net_rx_action

iavf yields +10% of Mpps on Rx. This also unblocks batched allocations
of XSk buffers when IOMMU is active.

Co-developed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Acked-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 drivers/iommu/dma-iommu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index c745196bc150..2a1dbe5867c4 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -1723,7 +1723,8 @@ static size_t iommu_dma_max_mapping_size(struct device *dev)
 }
 
 static const struct dma_map_ops iommu_dma_ops = {
-	.flags			= DMA_F_PCI_P2PDMA_SUPPORTED,
+	.flags			= DMA_F_PCI_P2PDMA_SUPPORTED |
+				  DMA_F_CAN_SKIP_SYNC,
 	.alloc			= iommu_dma_alloc,
 	.free			= iommu_dma_free,
 	.alloc_pages		= dma_common_alloc_pages,
-- 
2.45.0


