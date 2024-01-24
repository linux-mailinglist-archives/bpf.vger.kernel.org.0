Return-Path: <bpf+bounces-20263-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00E7F83B209
	for <lists+bpf@lfdr.de>; Wed, 24 Jan 2024 20:17:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A47DB286A46
	for <lists+bpf@lfdr.de>; Wed, 24 Jan 2024 19:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51D9313342F;
	Wed, 24 Jan 2024 19:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Id6VPX9B"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31793132C3B;
	Wed, 24 Jan 2024 19:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706123779; cv=none; b=DXv8Hy+sEFkWY4WkUIB4P/VmUV/RcLzb0lir2pDKRstozBwkK/F0bYxA0ijvPKwCBtabkbf1GwvO50LkSGemOKPADzkhX+VfL0L55L+bWi2OA6mtnWHbvG0eccQ+jQOR1dfnWowUGQEri5mF/yu6NJMLlwcHcMpd7NOC6b/G+5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706123779; c=relaxed/simple;
	bh=KCcMc3bpUCUn6F+2DzBPuPDfsi98js3RATrKzV7LfLo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KfNnnQxGVhz03a7hY4J+0mMgqZIwi1lhPdi8eg5JScQOgbZ+dgZfhzJ5841IQRf/CH0EU/miwxhYYXfHZlfeyN7K3qNVCdXofydcBmM30HqV8bTXk2sXhjXHH+aDcVzQUt7ezeGz7YK6fylpMgWkBV5TCaR47febm7a704BNhsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Id6VPX9B; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706123778; x=1737659778;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KCcMc3bpUCUn6F+2DzBPuPDfsi98js3RATrKzV7LfLo=;
  b=Id6VPX9BiDOdEJuZTFCaQBcqUDJ1oFUOzrfGJBhZS99CWFfMhUeonh5F
   gAn/Ypap1xTcXYhMxb1y5v9xpU3UUUv0uNCVxffLcgk4DAoz+x02F5uT4
   D9yDzdofsYlH8LY2QlHn7xeFwK0BkoyFMCmi9tuQ0bLm3KXq2f/V4oqzw
   00Exc3mS69AKj7+bbnHAgp+8endCvLzGDTVu5PQ6KMHH7GThjRxhHYuhm
   hArVLFBOt2eUujOP7CMDx1OpQY9JE0W6Bwad/3ePwtmBOl87+mbRt0HLg
   UG+UsHvV2OUQB/onYUaFfuAcTaIvusy+X5TrXpjXlXe78BXQCT5D3R3RA
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="1822961"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="1822961"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2024 11:16:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="820553448"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="820553448"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by orsmga001.jf.intel.com with ESMTP; 24 Jan 2024 11:16:14 -0800
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org
Cc: netdev@vger.kernel.org,
	magnus.karlsson@intel.com,
	bjorn@kernel.org,
	maciej.fijalkowski@intel.com,
	echaudro@redhat.com,
	lorenzo@kernel.org,
	martin.lau@linux.dev,
	tirthendu.sarkar@intel.com,
	john.fastabend@gmail.com,
	horms@kernel.org,
	kuba@kernel.org
Subject: [PATCH v6 bpf 02/11] xsk: make xsk_buff_pool responsible for clearing xdp_buff::flags
Date: Wed, 24 Jan 2024 20:15:53 +0100
Message-Id: <20240124191602.566724-3-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240124191602.566724-1-maciej.fijalkowski@intel.com>
References: <20240124191602.566724-1-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

XDP multi-buffer support introduced XDP_FLAGS_HAS_FRAGS flag that is
used by drivers to notify data path whether xdp_buff contains fragments
or not. Data path looks up mentioned flag on first buffer that occupies
the linear part of xdp_buff, so drivers only modify it there. This is
sufficient for SKB and XDP_DRV modes as usually xdp_buff is allocated on
stack or it resides within struct representing driver's queue and
fragments are carried via skb_frag_t structs. IOW, we are dealing with
only one xdp_buff.

ZC mode though relies on list of xdp_buff structs that is carried via
xsk_buff_pool::xskb_list, so ZC data path has to make sure that
fragments do *not* have XDP_FLAGS_HAS_FRAGS set. Otherwise,
xsk_buff_free() could misbehave if it would be executed against xdp_buff
that carries a frag with XDP_FLAGS_HAS_FRAGS flag set. Such scenario can
take place when within supplied XDP program bpf_xdp_adjust_tail() is
used with negative offset that would in turn release the tail fragment
from multi-buffer frame.

Calling xsk_buff_free() on tail fragment with XDP_FLAGS_HAS_FRAGS would
result in releasing all the nodes from xskb_list that were produced by
driver before XDP program execution, which is not what is intended -
only tail fragment should be deleted from xskb_list and then it should
be put onto xsk_buff_pool::free_list. Such multi-buffer frame will never
make it up to user space, so from AF_XDP application POV there would be
no traffic running, however due to free_list getting constantly new
nodes, driver will be able to feed HW Rx queue with recycled buffers.
Bottom line is that instead of traffic being redirected to user space,
it would be continuously dropped.

To fix this, let us clear the mentioned flag on xsk_buff_pool side
during xdp_buff initialization, which is what should have been done
right from the start of XSK multi-buffer support.

Fixes: 1bbc04de607b ("ice: xsk: add RX multi-buffer support")
Fixes: 1c9ba9c14658 ("i40e: xsk: add RX multi-buffer support")
Fixes: 24ea50127ecf ("xsk: support mbuf on ZC RX")
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_xsk.c | 1 -
 drivers/net/ethernet/intel/ice/ice_xsk.c   | 1 -
 include/net/xdp_sock_drv.h                 | 1 +
 net/xdp/xsk_buff_pool.c                    | 1 +
 4 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_xsk.c b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
index af7d5fa6cdc1..82aca0d16a3e 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_xsk.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
@@ -498,7 +498,6 @@ int i40e_clean_rx_irq_zc(struct i40e_ring *rx_ring, int budget)
 		xdp_res = i40e_run_xdp_zc(rx_ring, first, xdp_prog);
 		i40e_handle_xdp_result_zc(rx_ring, first, rx_desc, &rx_packets,
 					  &rx_bytes, xdp_res, &failure);
-		first->flags = 0;
 		next_to_clean = next_to_process;
 		if (failure)
 			break;
diff --git a/drivers/net/ethernet/intel/ice/ice_xsk.c b/drivers/net/ethernet/intel/ice/ice_xsk.c
index 5d1ae8e4058a..d9073a618ad6 100644
--- a/drivers/net/ethernet/intel/ice/ice_xsk.c
+++ b/drivers/net/ethernet/intel/ice/ice_xsk.c
@@ -895,7 +895,6 @@ int ice_clean_rx_irq_zc(struct ice_rx_ring *rx_ring, int budget)
 
 		if (!first) {
 			first = xdp;
-			xdp_buff_clear_frags_flag(first);
 		} else if (ice_add_xsk_frag(rx_ring, first, xdp, size)) {
 			break;
 		}
diff --git a/include/net/xdp_sock_drv.h b/include/net/xdp_sock_drv.h
index 526c1e7f505e..9819e2af0378 100644
--- a/include/net/xdp_sock_drv.h
+++ b/include/net/xdp_sock_drv.h
@@ -164,6 +164,7 @@ static inline void xsk_buff_set_size(struct xdp_buff *xdp, u32 size)
 	xdp->data = xdp->data_hard_start + XDP_PACKET_HEADROOM;
 	xdp->data_meta = xdp->data;
 	xdp->data_end = xdp->data + size;
+	xdp->flags = 0;
 }
 
 static inline dma_addr_t xsk_buff_raw_get_dma(struct xsk_buff_pool *pool,
diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
index 28711cc44ced..ce60ecd48a4d 100644
--- a/net/xdp/xsk_buff_pool.c
+++ b/net/xdp/xsk_buff_pool.c
@@ -555,6 +555,7 @@ struct xdp_buff *xp_alloc(struct xsk_buff_pool *pool)
 
 	xskb->xdp.data = xskb->xdp.data_hard_start + XDP_PACKET_HEADROOM;
 	xskb->xdp.data_meta = xskb->xdp.data;
+	xskb->xdp.flags = 0;
 
 	if (pool->dma_need_sync) {
 		dma_sync_single_range_for_device(pool->dev, xskb->dma, 0,
-- 
2.34.1


