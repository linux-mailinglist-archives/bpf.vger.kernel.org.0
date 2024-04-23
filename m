Return-Path: <bpf+bounces-27547-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF9948AE8DD
	for <lists+bpf@lfdr.de>; Tue, 23 Apr 2024 16:00:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 864331F21244
	for <lists+bpf@lfdr.de>; Tue, 23 Apr 2024 14:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 128EB13B5B1;
	Tue, 23 Apr 2024 13:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lg4Kv1R7"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C83B13774F;
	Tue, 23 Apr 2024 13:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713880743; cv=none; b=ogrdclHOIg8gy6OtA7SgcPCwBcef7ysrkr40UCNSdRSuNDRnGSRd9/lKVrdC6TJGqrwAxMkq+tFOqpt6DtLxA/WHQjpCh7ImSATSvYtfkUz1kKDhy7ZlyGGb6aH9YAISTYY+kmtsNHtPgxmfWPotmO9V5SeC0wmPWvLOHPsrPd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713880743; c=relaxed/simple;
	bh=6lH3EXvd+Ai0KPhrBTY+XB53NDNa+PvM4xruiocc8MM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tA0FiIO4xpt44xG2W4PXDSx5vljrH3RgXBEkC6JgLFSl/vcYWRoQfI5LjdY2BYugQnB4ZE4R3iKnCFb1HfI5n4S5vfN7PkQL4XOT4Y491O0ItfkZV9MQqeQNErqbw1GeMF3/nUamA5HsCKuMK8oRJIs3pyzX0obO1NqEqccEbvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lg4Kv1R7; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713880742; x=1745416742;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6lH3EXvd+Ai0KPhrBTY+XB53NDNa+PvM4xruiocc8MM=;
  b=lg4Kv1R73xD9pbuJEoe0MGLfEpdyL4WXkE27xPJoo1uqnhLDRbC0TBb4
   7K+WK2el+mI4Ei/iqfnz4ExeDMVkkWUbYY2VgcuM2YyjoPBlgrcaEcb2y
   p/5DMcf8J/lUVm5RWCE3csR7qX3GFgsXHOBuhOePe1xLZtfEVYFc9co8L
   MGlcUlM5maUWS8c58hedldtvDeAK4nTNVTXosYyNxTjJTkhl7GqD9e+GV
   wX/DbES+aUsaBLI9PId0T8KdAhyTp5DRTusZgblgiNnatkY6wZDDaRlXh
   cvGvx+IDqlHe3PNSCANLY0+ICli1L1IKq4pt1Qd0+ErD4XMqem2nnivqW
   A==;
X-CSE-ConnectionGUID: Rwk0MlJCQA+rgU0vjlY8cw==
X-CSE-MsgGUID: 88kdf+4qSjCpnBhYmGY7Bg==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="26921470"
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="26921470"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 06:59:02 -0700
X-CSE-ConnectionGUID: viYKlHnsSBeUmPEBGa3v/g==
X-CSE-MsgGUID: zRT4Sj/FTdSVn6ZKchSxiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="24431825"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by fmviesa008.fm.intel.com with ESMTP; 23 Apr 2024 06:58:58 -0700
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
Subject: [PATCH net-next v4 3/7] iommu/dma: avoid expensive indirect calls for sync operations
Date: Tue, 23 Apr 2024 15:58:28 +0200
Message-ID: <20240423135832.2271696-4-aleksander.lobakin@intel.com>
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
index e4cb26f6a943..0516e3e859b5 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -1720,7 +1720,8 @@ static size_t iommu_dma_max_mapping_size(struct device *dev)
 }
 
 static const struct dma_map_ops iommu_dma_ops = {
-	.flags			= DMA_F_PCI_P2PDMA_SUPPORTED,
+	.flags			= DMA_F_PCI_P2PDMA_SUPPORTED |
+				  DMA_F_CAN_SKIP_SYNC,
 	.alloc			= iommu_dma_alloc,
 	.free			= iommu_dma_free,
 	.alloc_pages		= dma_common_alloc_pages,
-- 
2.44.0


