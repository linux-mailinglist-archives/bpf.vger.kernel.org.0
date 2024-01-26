Return-Path: <bpf+bounces-20393-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D54BF83DB42
	for <lists+bpf@lfdr.de>; Fri, 26 Jan 2024 14:57:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B0921F2460B
	for <lists+bpf@lfdr.de>; Fri, 26 Jan 2024 13:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 424301C695;
	Fri, 26 Jan 2024 13:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YRUyy89n"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198B91C2AD;
	Fri, 26 Jan 2024 13:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706277368; cv=none; b=gPS6OFdDu/jS7gh44sBEjqIUM+K47zQmd0VgosHSe88gsCMYj7Gd12GGKrsVykkfqNZi2rk7cXKCcB0b7pm1yhzIWUMhEVCBFlUK2ADqghBE46BdferLsTK+W9XPczupKuVuUkY2ewOUY4b4I9+lLGGeynTqODe/UFlv7Y1wAFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706277368; c=relaxed/simple;
	bh=BFe+2/b+8r0zXOXtDJDjBJWS1BOIPOK8VSmGKtnTIZ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TZm6beWc0efBmfnlhdJNkXNRD/n3x4wQPU6r1f8O8cgxd3nBjFGO7i1hhlZ13QFk6fyiDC9Nh62yzQVHmUn1T0ntNV2Tfxk7ZjHuO7jIjQccZILbC+U9RHrLuN9s2rybytiQOq6b6CkVeTyQRlZEvw1+iAhQCtoG4Ucc4qy3UTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YRUyy89n; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706277367; x=1737813367;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BFe+2/b+8r0zXOXtDJDjBJWS1BOIPOK8VSmGKtnTIZ4=;
  b=YRUyy89nQu3NCLXnTVx6feNVZ7MKZ3NLgXz7q5Vv5on4SWsTyi+zkdVY
   3aZqFCz47wsXPhO8G2ks4Aw9CcfTGCeoo6V7p3Xki/0OJYF39ijhtHHZH
   ZwCD61G23OK1INNKu0NbhJ1DqxqxGx33QwsuwNC84ZU4G24nnTtt7gLfj
   ExSzvDQ6FfZSFLfDOlnk6odvGROpLhfbCyWmL/qV/QpTrkVvyEVDOdHSq
   +YHcRF5vFHqkkZ0UxFcc4tQW0VbHSB9rdyAob+XxQiHfvivueZ5je3hSR
   nC5O35mzmw43HXivOJXqiBjjCFt02tiAT4/aR33neN7339Divt4/Lxty4
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="15998455"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="15998455"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2024 05:56:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="821142910"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="821142910"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orsmga001.jf.intel.com with ESMTP; 26 Jan 2024 05:56:01 -0800
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
Subject: [PATCH net-next 3/7] iommu/dma: avoid expensive indirect calls for sync operations
Date: Fri, 26 Jan 2024 14:54:52 +0100
Message-ID: <20240126135456.704351-4-aleksander.lobakin@intel.com>
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

From: Eric Dumazet <edumazet@google.com>

Use the new dma_map_ops::can_skip_sync() callback in IOMMU DMA. It is
enough to check only for the DMA coherence, as SWIOTLB is checked
dynamically later.

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
cpu usage looks much better (~60% instead of ~72%)

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

iavf yields +10% of Mpps on Rx. This also unblocks batch allocations
of XSk buffers when IOMMU is active.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Co-developed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 drivers/iommu/dma-iommu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 50ccc4f1ef81..86290562eda5 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -1720,6 +1720,7 @@ static const struct dma_map_ops iommu_dma_ops = {
 	.unmap_page		= iommu_dma_unmap_page,
 	.map_sg			= iommu_dma_map_sg,
 	.unmap_sg		= iommu_dma_unmap_sg,
+	.can_skip_sync		= dev_is_dma_coherent,
 	.sync_single_for_cpu	= iommu_dma_sync_single_for_cpu,
 	.sync_single_for_device	= iommu_dma_sync_single_for_device,
 	.sync_sg_for_cpu	= iommu_dma_sync_sg_for_cpu,
-- 
2.43.0


