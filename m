Return-Path: <bpf+bounces-21986-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CF81854E0F
	for <lists+bpf@lfdr.de>; Wed, 14 Feb 2024 17:24:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7528B2315B
	for <lists+bpf@lfdr.de>; Wed, 14 Feb 2024 16:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA61B60ED0;
	Wed, 14 Feb 2024 16:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XZCI7xAs"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B02060DE2;
	Wed, 14 Feb 2024 16:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707927776; cv=none; b=GUF7SGDak/LU/bzMD+eNKQbrfaJYwNATPoGM++kbZnMtw3ASLP3ivd+rCKk4oHyiPFo0rlAGaL+l7Uh64blyOvwEINb2BuCdUUXM5al+Zw4HYrZZROcLqP+Anf5vE4062F/KBoLGpqRSys0W0KR30F9ZT1I+uZ7CAs81Kj3x+gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707927776; c=relaxed/simple;
	bh=LVf5BgWT9OSmbGH+Qwko5u5SJBVWf1jKCf7S7n+8WTs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cr8JNv9ggdVKV2zUaXJAn2ZOTqdpbQtJpKPIdmTuMq87EM8A2RCzNwxq4DVtKReDZzN+MCWSnTYrWIuNTD3iFhpsQTM/7BQ7M9oBsE9SbbOfK/ch4Qa3bIG5tmiFuN/hBk37iDk3lsIijl7BIXWBPnEEuzOMzHXjIJNiSdNlk3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XZCI7xAs; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707927774; x=1739463774;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LVf5BgWT9OSmbGH+Qwko5u5SJBVWf1jKCf7S7n+8WTs=;
  b=XZCI7xAseoMQmku7hs3afH1TFpoM5LdApzAmTc9FxyvFOvpVfcVFlySy
   fA7YruRI1xUBsp0VjL8TKuIQM0Ugv2jElBxsc3ZcpsOcGvPpml76qLiaF
   ResO5SLLX2Lwp9ml0w4oddszgZEqI72oy6VGdFHgnfjti/3hitP4C2Pqj
   WIwLVTJrrUvrIno3L9+AGhdJWYy08N3DUgzE7LJ5zdCohBxjqoOn3/XV2
   pLzLrNguAv/ND9DnPPoX0D9Do9I7d9BEppJpZ8RBWHm+m/LHyBEl8c5jF
   JQ/EKpsRL/hayVc+P/foNiGzaR3nJTWxYSoe69r0mYgzVF1m1EPVg5Sof
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="5755570"
X-IronPort-AV: E=Sophos;i="6.06,159,1705392000"; 
   d="scan'208";a="5755570"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 08:22:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,159,1705392000"; 
   d="scan'208";a="26400001"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by fmviesa002.fm.intel.com with ESMTP; 14 Feb 2024 08:22:50 -0800
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
Subject: [PATCH net-next v3 3/7] iommu/dma: avoid expensive indirect calls for sync operations
Date: Wed, 14 Feb 2024 17:21:57 +0100
Message-ID: <20240214162201.4168778-4-aleksander.lobakin@intel.com>
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
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 drivers/iommu/dma-iommu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 50ccc4f1ef81..4ab9ac13d362 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -1707,7 +1707,8 @@ static size_t iommu_dma_opt_mapping_size(void)
 }
 
 static const struct dma_map_ops iommu_dma_ops = {
-	.flags			= DMA_F_PCI_P2PDMA_SUPPORTED,
+	.flags			= DMA_F_PCI_P2PDMA_SUPPORTED |
+				  DMA_F_CAN_SKIP_SYNC,
 	.alloc			= iommu_dma_alloc,
 	.free			= iommu_dma_free,
 	.alloc_pages		= dma_common_alloc_pages,
-- 
2.43.0


