Return-Path: <bpf+bounces-20043-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 218718375EC
	for <lists+bpf@lfdr.de>; Mon, 22 Jan 2024 23:16:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 939731F26E26
	for <lists+bpf@lfdr.de>; Mon, 22 Jan 2024 22:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D94748CE9;
	Mon, 22 Jan 2024 22:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hSv8zQKO"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2EF48791;
	Mon, 22 Jan 2024 22:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705961786; cv=none; b=BU5wGFnvP5T3ZprTQCjYQKgycQiGiUUnlcW/0piW37bE7/4uAy090aO3NUtCmDsqEKKCnRJQJ2JGzZJB2YmjXMWhuKB2bYfebj/2Dp8EXsw3/dLCNuqFYWEPuP/EQuzsknwa9+S8z5lh/09cBiwdM7ZFWMgLClHVb0XRpGlSs9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705961786; c=relaxed/simple;
	bh=sFRt8KwQFCEFgzCFSZp45DrePK9GSK3ZSmSR2nTm1Cw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JU/XUMH/oHu2LmzmG8eNHzaIPN4PqwHNHO9d2gsqxa8YilIKaCy0WLkC6yBtKondS76xW62W9QfCnKzlGHc8TAMpDYG1gMoZxa80m1fnqId6i2haLUGqj+SRKNg6N4h863Hspf9S423izGWu93BQoJ/PLqFn+I2t5GmpDWMQmok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hSv8zQKO; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705961785; x=1737497785;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sFRt8KwQFCEFgzCFSZp45DrePK9GSK3ZSmSR2nTm1Cw=;
  b=hSv8zQKOKACU67rON/NjiVtqVKhPZgaqMESFNTG1j4IIKT1SkpOEKlUH
   bCPRui6qM4IvNpJMPciN2LWOeRYGP66GjiKEYRcj2Is8OVSHuwz502Ewf
   6yYqYpnsOsAIsYO+CmnVN2CDgIk3FFT6CtY+6w6A/9dhX2YrbvryCFzIS
   AjVm0KAaJjk2JrwQyyOBU4l9lvzZ+/FYpwkoJiv1EA0p1jpYyRKNTQtZ5
   MLy2vejSWdzixcA0U39h7cP1gFJkaXNs5FPV6+tVXmTIV62Je6tGdShUf
   XkvNJ/nxqD3vcxNyDjs8/7EmOTlYgiwOp014lR2LrU58etnJixE5oLwJa
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10961"; a="7995527"
X-IronPort-AV: E=Sophos;i="6.05,212,1701158400"; 
   d="scan'208";a="7995527"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2024 14:16:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,212,1701158400"; 
   d="scan'208";a="1360516"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by fmviesa003.fm.intel.com with ESMTP; 22 Jan 2024 14:16:21 -0800
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
	horms@kernel.org
Subject: [PATCH v5 bpf 02/11] xsk: make xsk_buff_pool responsible for clearing xdp_buff::flags
Date: Mon, 22 Jan 2024 23:16:01 +0100
Message-Id: <20240122221610.556746-3-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240122221610.556746-1-maciej.fijalkowski@intel.com>
References: <20240122221610.556746-1-maciej.fijalkowski@intel.com>
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

To fix this, let us clear the mentioned flag on xsk_buff_pool side at
allocation time, which is what should have been done right from the
start of XSK multi-buffer support.

Fixes: 1bbc04de607b ("ice: xsk: add RX multi-buffer support")
Fixes: 1c9ba9c14658 ("i40e: xsk: add RX multi-buffer support")
Fixes: 24ea50127ecf ("xsk: support mbuf on ZC RX")
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_xsk.c | 1 -
 drivers/net/ethernet/intel/ice/ice_xsk.c   | 1 -
 net/xdp/xsk_buff_pool.c                    | 3 +++
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_xsk.c b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
index e99fa854d17f..fede0bb3e047 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_xsk.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
@@ -499,7 +499,6 @@ int i40e_clean_rx_irq_zc(struct i40e_ring *rx_ring, int budget)
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
diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
index 28711cc44ced..dc5659da6728 100644
--- a/net/xdp/xsk_buff_pool.c
+++ b/net/xdp/xsk_buff_pool.c
@@ -555,6 +555,7 @@ struct xdp_buff *xp_alloc(struct xsk_buff_pool *pool)
 
 	xskb->xdp.data = xskb->xdp.data_hard_start + XDP_PACKET_HEADROOM;
 	xskb->xdp.data_meta = xskb->xdp.data;
+	xskb->xdp.flags = 0;
 
 	if (pool->dma_need_sync) {
 		dma_sync_single_range_for_device(pool->dev, xskb->dma, 0,
@@ -601,6 +602,7 @@ static u32 xp_alloc_new_from_fq(struct xsk_buff_pool *pool, struct xdp_buff **xd
 		}
 
 		*xdp = &xskb->xdp;
+		xskb->xdp.flags = 0;
 		xdp++;
 	}
 
@@ -621,6 +623,7 @@ static u32 xp_alloc_reused(struct xsk_buff_pool *pool, struct xdp_buff **xdp, u3
 		list_del_init(&xskb->free_list_node);
 
 		*xdp = &xskb->xdp;
+		xskb->xdp.flags = 0;
 		xdp++;
 	}
 	pool->free_list_cnt -= nb_entries;
-- 
2.34.1


