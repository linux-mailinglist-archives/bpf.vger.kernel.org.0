Return-Path: <bpf+bounces-31725-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74FD39025F0
	for <lists+bpf@lfdr.de>; Mon, 10 Jun 2024 17:46:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 018511F224BC
	for <lists+bpf@lfdr.de>; Mon, 10 Jun 2024 15:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99C4714389B;
	Mon, 10 Jun 2024 15:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VKAB8jIh"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822D11422D5;
	Mon, 10 Jun 2024 15:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718034312; cv=none; b=CAzh0576/cTK/XrqX82InxtXzuH/Pvo2XMOMx6kMAd0W83cmI5eE4YGMH8fveERZgBHb35MAqPySAdEAUV+j/BkToHW1YG8esOJ0Vw+ZlTEf6eA1oX5wwCs2h0EozyfamkT/jM5F726QOddpHntCvyOwdIeGWggqd/tifM241tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718034312; c=relaxed/simple;
	bh=1CJQhgdeQheVVIX/aqzTWo34167G3W6siXPTBXQpy9A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GSz1Z8NIJJAyZtuyHRTrCmk+VI2u1gSqyUfLVEwiKbfP/qkdSQNQJJIa4oC/tZWM9kxGn+kj/xsmlJnhFd9yKEIihwg2Fdvim5zWDtBBITZxbOCzXp8iAl8hTPeQv6HXcRaVUZ6PAv3fXnB1lzNkcxXfM/tOTByMn+1F6M5hyFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VKAB8jIh; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718034310; x=1749570310;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1CJQhgdeQheVVIX/aqzTWo34167G3W6siXPTBXQpy9A=;
  b=VKAB8jIh8ycwOMgVFjKzHRRV7WPkLYAXdeFIlGsCd0TTi+Sb3UbKQbF3
   tGFku7G+kVwTVjrP+jI74P3Z4ajiSzyLiHGuWEnDg507JsFF3bpAo144h
   gy0hSStBeq30jEKfzgQYet0XCrRC55sn9uwLPshrc09plBpcPRFzCr6jQ
   izXXsRmTEcvsI2gSEgLTerwwuPLmaODge17rzvUEH2s1D7CCdnQpK17so
   cTQU10zvatgwklqKo2RlLuuU4rxmc65hdZy8kPr6v/wQLlq2JXU3oAAPh
   5TEy224sTvfIFXO7TWTF5a9O6GwO1phk/SiyEC4yn1NaGXbTB86RIeNJB
   Q==;
X-CSE-ConnectionGUID: oRuzBhYmTBaCxQXchtgREQ==
X-CSE-MsgGUID: fNFSYBdHS5yzjjTJ1RZH9w==
X-IronPort-AV: E=McAfee;i="6600,9927,11099"; a="26119868"
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; 
   d="scan'208";a="26119868"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2024 08:45:10 -0700
X-CSE-ConnectionGUID: 6R3brtywTb2VXCSyRA/AmA==
X-CSE-MsgGUID: JvFWDt5rTDmrEJjMGy02Uw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; 
   d="scan'208";a="43679776"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa004.fm.intel.com with ESMTP; 10 Jun 2024 08:45:05 -0700
Received: from lincoln.igk.intel.com (lincoln.igk.intel.com [10.102.21.235])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id BB4B1312D7;
	Mon, 10 Jun 2024 16:44:50 +0100 (IST)
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: Larysa Zaremba <larysa.zaremba@intel.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	magnus.karlsson@intel.com,
	Michal Kubiak <michal.kubiak@intel.com>,
	Igor Bagnucki <igor.bagnucki@intel.com>
Subject: [PATCH iwl-net 2/3] ice: fix locking in ice_xsk_pool_setup()
Date: Mon, 10 Jun 2024 17:37:14 +0200
Message-ID: <20240610153716.31493-3-larysa.zaremba@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240610153716.31493-1-larysa.zaremba@intel.com>
References: <20240610153716.31493-1-larysa.zaremba@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With ICE_CFG_BUSY PF state flag locking used in ice_xdp(), there is no need
to lock with VSI state inside ice_xsk_pool_setup(). For robust
synchronization the state between reset preparation and PF VSI rebuild has
to be handled, in the same way as in ice_xdp_setup_prog().

Remove locking logic from ice_qp_dis() and ice_qp_ena() and skip those
functions, if rebuild is pending.

Fixes: 2d4238f55697 ("ice: Add support for AF_XDP")
Reviewed-by: Igor Bagnucki <igor.bagnucki@intel.com>
Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
---
 drivers/net/ethernet/intel/ice/ice.h      |  1 +
 drivers/net/ethernet/intel/ice/ice_main.c |  2 +-
 drivers/net/ethernet/intel/ice/ice_xsk.c  | 12 ++----------
 3 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index 701a61d791dd..76590cfcaf68 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -941,6 +941,7 @@ int ice_prepare_xdp_rings(struct ice_vsi *vsi, struct bpf_prog *prog,
 			  enum ice_xdp_cfg cfg_type);
 int ice_destroy_xdp_rings(struct ice_vsi *vsi, enum ice_xdp_cfg cfg_type);
 void ice_map_xdp_rings(struct ice_vsi *vsi);
+bool ice_rebuild_pending(struct ice_vsi *vsi);
 int
 ice_xdp_xmit(struct net_device *dev, int n, struct xdp_frame **frames,
 	     u32 flags);
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index dc60d816a345..cd8be3c3b956 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -2994,7 +2994,7 @@ static int ice_max_xdp_frame_size(struct ice_vsi *vsi)
  * so it happens strictly before or after .ndo_bpf().
  * In case it has happened before, we do not have anything attached to rings
  */
-static bool ice_rebuild_pending(struct ice_vsi *vsi)
+bool ice_rebuild_pending(struct ice_vsi *vsi)
 {
 	return ice_is_reset_in_progress(vsi->back->state) &&
 	       !vsi->rx_rings[0]->desc;
diff --git a/drivers/net/ethernet/intel/ice/ice_xsk.c b/drivers/net/ethernet/intel/ice/ice_xsk.c
index 4e2020ab0825..6c95bebd7777 100644
--- a/drivers/net/ethernet/intel/ice/ice_xsk.c
+++ b/drivers/net/ethernet/intel/ice/ice_xsk.c
@@ -163,7 +163,6 @@ static int ice_qp_dis(struct ice_vsi *vsi, u16 q_idx)
 	struct ice_tx_ring *xdp_ring;
 	struct ice_tx_ring *tx_ring;
 	struct ice_rx_ring *rx_ring;
-	int timeout = 50;
 	int fail = 0;
 	int err;
 
@@ -175,13 +174,6 @@ static int ice_qp_dis(struct ice_vsi *vsi, u16 q_idx)
 	xdp_ring = vsi->xdp_rings[q_idx];
 	q_vector = rx_ring->q_vector;
 
-	while (test_and_set_bit(ICE_CFG_BUSY, vsi->state)) {
-		timeout--;
-		if (!timeout)
-			return -EBUSY;
-		usleep_range(1000, 2000);
-	}
-
 	synchronize_net();
 	netif_trans_update(vsi->netdev);
 	netif_carrier_off(vsi->netdev);
@@ -251,7 +243,6 @@ static int ice_qp_ena(struct ice_vsi *vsi, u16 q_idx)
 	synchronize_net();
 	netif_tx_start_queue(netdev_get_tx_queue(vsi->netdev, q_idx));
 	netif_carrier_on(vsi->netdev);
-	clear_bit(ICE_CFG_BUSY, vsi->state);
 
 	return fail;
 }
@@ -379,7 +370,8 @@ int ice_xsk_pool_setup(struct ice_vsi *vsi, struct xsk_buff_pool *pool, u16 qid)
 		return -EINVAL;
 	}
 
-	if_running = netif_running(vsi->netdev) && ice_is_xdp_ena_vsi(vsi);
+	if_running = !ice_rebuild_pending(vsi) &&
+		     netif_running(vsi->netdev) && ice_is_xdp_ena_vsi(vsi);
 
 	if (if_running) {
 		struct ice_rx_ring *rx_ring = vsi->rx_rings[qid];
-- 
2.43.0


