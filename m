Return-Path: <bpf+bounces-28662-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AE8B8BCB18
	for <lists+bpf@lfdr.de>; Mon,  6 May 2024 11:50:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5A051F236FB
	for <lists+bpf@lfdr.de>; Mon,  6 May 2024 09:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13F31143883;
	Mon,  6 May 2024 09:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kXEEd7OK"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 477B8143868;
	Mon,  6 May 2024 09:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714988971; cv=none; b=apeKb/+B+DLYVVS4GamUyyt1xwwK2ba4/Nm5K/O16LY00t/IRE2I3nYTdi26Im3UwQAhBN0ZMSj9mWV2gC0mjGmEo8Z6bA7+y4BGKfQ5c7VlWiv4YzUPZeQ4GurmM1vFWujM7+vJAo0WzlNbm+9UxwavXYpXVfSvyXV/VQNKsvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714988971; c=relaxed/simple;
	bh=3SgiWVroz4YClWohZTqvdSQuz6xJr9Rgf0K+w7Mn7ZE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ywwrr+LBkLIMdoHiNYZis3MUrXr/ulXJrQEUzgYTLc2I7nSTPIdXFdbGDjKi2Dcq1dl0T7z1V2JWPspJSH82SyzpwzN5gFs8oESQEo0CpaIrG1o10B67yJWqdXmMSd90hwXb7nJK+m3PV5L0PXMYUciBzludyWI5yTHS0rt3y/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kXEEd7OK; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714988969; x=1746524969;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3SgiWVroz4YClWohZTqvdSQuz6xJr9Rgf0K+w7Mn7ZE=;
  b=kXEEd7OKRhLKvMJuxRfRm0Qed1xLZl00yjm9kWItOhiFMGWYJCunAahf
   QwFKMSPYv7AN2+Rl9nKw/0icSXDb5y+LihuF257Tkl7nMRw5Kevsn297W
   fz+kFCFjxCoDr1hZmhPI7gtiNZ2mqfuX+pwCT7g87z6JC4ZPGVQhCN9Ln
   TJnLhUIzURy5lUihN4e+HwR7viesufU7uOU7koojkJqCkmcNjCFkoyt11
   DDNZ2imvMPuvlA7TcHqPlsInlshNcTDqQDA/ek7P9imvk/yfqgKVXBcCV
   Oz5/tWEVkApwsj94kmglLb4sLRDahYQjeX+PR3L6F16WwYzMRcOUpXswz
   Q==;
X-CSE-ConnectionGUID: MsB/4bfkSYuuRtVwD3LR/w==
X-CSE-MsgGUID: pGQ2QA3LRLqAvmWAWQM3YA==
X-IronPort-AV: E=McAfee;i="6600,9927,11064"; a="28200991"
X-IronPort-AV: E=Sophos;i="6.07,258,1708416000"; 
   d="scan'208";a="28200991"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2024 02:49:29 -0700
X-CSE-ConnectionGUID: ZTRtr7BBRfaWt5suCIJygw==
X-CSE-MsgGUID: b5c56w65T9GGcO0TMm1YGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,258,1708416000"; 
   d="scan'208";a="58995722"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa002.jf.intel.com with ESMTP; 06 May 2024 02:49:25 -0700
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
Subject: [PATCH net-next v5 3/7] iommu/dma: avoid expensive indirect calls for sync operations
Date: Mon,  6 May 2024 11:48:51 +0200
Message-ID: <20240506094855.12944-4-aleksander.lobakin@intel.com>
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
2.45.0


