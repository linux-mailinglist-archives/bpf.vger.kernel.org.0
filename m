Return-Path: <bpf+bounces-35922-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75BE693FEC1
	for <lists+bpf@lfdr.de>; Mon, 29 Jul 2024 22:08:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D33E1F22220
	for <lists+bpf@lfdr.de>; Mon, 29 Jul 2024 20:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A9F018C33B;
	Mon, 29 Jul 2024 20:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bAJxJBlA"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B64189F5D;
	Mon, 29 Jul 2024 20:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722283648; cv=none; b=Zo/ZBsy/eW/qvxzSNduw8E3ko1dMsEuQ1mWa0qJUoddg7Dsmsstcn7Dah3T6YHf3LQFrydLyr794u4YRjX3qGdW58nj+Nv9ZXpOxKRJfCQ3NAYmThdzsV0wgsCOTVgXOawqNNltcdC4cDGaHXTUGAL+OpIuBbgoQBkpVWwHkJX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722283648; c=relaxed/simple;
	bh=9dUjVJsUsqt4zdcPCra0Y/NV7Xb3BVuDzQc8YgBcTcs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TQiVbuSAAEsMB8rbDIT2M5ah59n7oVBKq8tp5tCg1zDcKiPiHptaIlW/CsX1VVXQbSJfVeJiZu6yZq/xPArnk+5zODR//NWmLfmcVNfA8+4cKzBsLbI1L/Z82qn8me4DQjVJyBYX91RBA52OrEF7j3YmzS93JbZQEaUmXEYOsQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bAJxJBlA; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722283647; x=1753819647;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9dUjVJsUsqt4zdcPCra0Y/NV7Xb3BVuDzQc8YgBcTcs=;
  b=bAJxJBlAZQWknzfN3vxZyY3UWGUoA7ilmj9AYD3B9eHkwOjSingsiqK6
   VRVFCkx3uk+TPvZ2cEhObyjvoaFtfpd9f4M0BLjpeWQJ4bsQbnyhHi+Vw
   BA4g/syzAJUVk2dZl/bcSrDuFVvBiZX5DFe1Ic9iWQshfd27djVo+o/tj
   A+sBP8paAQmaToDwEDvP1EU7oEXMq4Lzr9LZmYO2f5DkVyXIYtMDepZ2R
   G+JiuhuTkMrBqJjw2Qpg4uKhnJ8tuo/U07lkipVQRv56NMkCXFNSsap8x
   o8/b4iPSawjCBoiHHni5Mw+TOzZtvKt44lsiToeAe5IR1ayfLz4Gs8THu
   g==;
X-CSE-ConnectionGUID: yf7PqTy7SQSB2lolksiIrg==
X-CSE-MsgGUID: DVj+yepVQXm5xercBrL6Hw==
X-IronPort-AV: E=McAfee;i="6700,10204,11148"; a="23818531"
X-IronPort-AV: E=Sophos;i="6.09,246,1716274800"; 
   d="scan'208";a="23818531"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2024 13:07:23 -0700
X-CSE-ConnectionGUID: GFpHnCIETZSQ0Z1GtQclAw==
X-CSE-MsgGUID: gxHrVV/tSwuuyW8iA8x1bQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,246,1716274800"; 
   d="scan'208";a="54681290"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa007.jf.intel.com with ESMTP; 29 Jul 2024 13:07:24 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	anthony.l.nguyen@intel.com,
	magnus.karlsson@intel.com,
	aleksander.lobakin@intel.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	bpf@vger.kernel.org,
	Shannon Nelson <shannon.nelson@amd.com>,
	Chandan Kumar Rout <chandanx.rout@intel.com>
Subject: [PATCH net v2 5/8] ice: toggle netif_carrier when setting up XSK pool
Date: Mon, 29 Jul 2024 13:07:11 -0700
Message-ID: <20240729200716.681496-6-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240729200716.681496-1-anthony.l.nguyen@intel.com>
References: <20240729200716.681496-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

This so we prevent Tx timeout issues. One of conditions checked on
running in the background dev_watchdog() is netif_carrier_ok(), so let
us turn it off when we disable the queues that belong to a q_vector
where XSK pool is being configured. Turn carrier on in ice_qp_ena()
only when ice_get_link_status() tells us that physical link is up.

Fixes: 2d4238f55697 ("ice: Add support for AF_XDP")
Reviewed-by: Shannon Nelson <shannon.nelson@amd.com>
Tested-by: Chandan Kumar Rout <chandanx.rout@intel.com> (A Contingent Worker at Intel)
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_xsk.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_xsk.c b/drivers/net/ethernet/intel/ice/ice_xsk.c
index 902096b000f5..3fbe4cfadfbf 100644
--- a/drivers/net/ethernet/intel/ice/ice_xsk.c
+++ b/drivers/net/ethernet/intel/ice/ice_xsk.c
@@ -180,6 +180,7 @@ static int ice_qp_dis(struct ice_vsi *vsi, u16 q_idx)
 	}
 
 	synchronize_net();
+	netif_carrier_off(vsi->netdev);
 	netif_tx_stop_queue(netdev_get_tx_queue(vsi->netdev, q_idx));
 
 	ice_qvec_dis_irq(vsi, rx_ring, q_vector);
@@ -218,6 +219,7 @@ static int ice_qp_ena(struct ice_vsi *vsi, u16 q_idx)
 {
 	struct ice_q_vector *q_vector;
 	int fail = 0;
+	bool link_up;
 	int err;
 
 	err = ice_vsi_cfg_single_txq(vsi, vsi->tx_rings, q_idx);
@@ -248,7 +250,11 @@ static int ice_qp_ena(struct ice_vsi *vsi, u16 q_idx)
 	ice_qvec_toggle_napi(vsi, q_vector, true);
 	ice_qvec_ena_irq(vsi, q_vector);
 
-	netif_tx_start_queue(netdev_get_tx_queue(vsi->netdev, q_idx));
+	ice_get_link_status(vsi->port_info, &link_up);
+	if (link_up) {
+		netif_tx_start_queue(netdev_get_tx_queue(vsi->netdev, q_idx));
+		netif_carrier_on(vsi->netdev);
+	}
 	clear_bit(ICE_CFG_BUSY, vsi->state);
 
 	return fail;
-- 
2.42.0


