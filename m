Return-Path: <bpf+bounces-21075-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D178B8476CB
	for <lists+bpf@lfdr.de>; Fri,  2 Feb 2024 18:57:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56D141F235A4
	for <lists+bpf@lfdr.de>; Fri,  2 Feb 2024 17:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDDF2151445;
	Fri,  2 Feb 2024 17:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ALFHTr7J"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A4914C5AF;
	Fri,  2 Feb 2024 17:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706896583; cv=none; b=uR0mfNVcidPdgrJJov1W6ZruVZHwP/twLntT0eJCaepNntKrs1PRW/MceC5rPUR/Eo+UuZTwu2s4JDhX0ft46+TQxx6dfZOrU6cbNY5392edTx1KzKTWIRICe/o5A5Mzd5PfQK5H5aqOFs3x5AXtndR79xxiI4v9mGiZT9b+Onk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706896583; c=relaxed/simple;
	bh=kj5OPaWFq22CCr07mX+sdEeRdYmH1g9IgPOV8CCnniU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t5vjHQa0w2l6FZxeQRZB2vllX2nK0bH2QvjzK9StsHC2fwHG4LAB/wVYEE7fJ6SKRRI68H9kDHFx4CHXealDxqu12f27W+molE4+3uCJ6XNeHQOhn+EOnHbB2jKhlc0EI8VouwJoB4bYPSEHe6ODRkQ2OboL9vSFj98qsYdK3pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ALFHTr7J; arc=none smtp.client-ip=192.55.52.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706896581; x=1738432581;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kj5OPaWFq22CCr07mX+sdEeRdYmH1g9IgPOV8CCnniU=;
  b=ALFHTr7JhuWs+gVOiLMMh+OVCM4p8TQ8i2C3/tskAndPVDJG5uYIErix
   fro5Rr6zkoUAEctc1wnp1P5CWNfWIiO29jorVJqR9pO1ygQaqN7yMh3zo
   fyMPmDVy+1NhyCwU3/lzb3/mjjK81EIgRzsnufK/ypZNaAeIZzp51/zjD
   lX0sI/Ws6AHusYdDGNm/4+g0Iy3FipBOfY/YwhxNZ+81VdPomTsj4KXSq
   fh0wi11leVajytk7AanoJFVQ4OymWnbEw93KVsk2Y8V2OQ+iLdjVoB5uX
   NdXn2Tn/dGlgifEQbEwsor/k4VYvH4Vuk385+wjGeNHm3O3SupWlEfMKP
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="435347610"
X-IronPort-AV: E=Sophos;i="6.05,238,1701158400"; 
   d="scan'208";a="435347610"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2024 09:56:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,238,1701158400"; 
   d="scan'208";a="137832"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa010.jf.intel.com with ESMTP; 02 Feb 2024 09:56:18 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	anthony.l.nguyen@intel.com,
	magnus.karlsson@intel.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	bpf@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	Chandan Kumar Rout <chandanx.rout@intel.com>
Subject: [PATCH net-next 1/4] ice: make ice_vsi_cfg_rxq() static
Date: Fri,  2 Feb 2024 09:56:09 -0800
Message-ID: <20240202175613.3470818-2-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240202175613.3470818-1-anthony.l.nguyen@intel.com>
References: <20240202175613.3470818-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

Currently, XSK control path in ice driver calls directly
ice_vsi_cfg_rxq() whereas we have ice_vsi_cfg_single_rxq() for that
purpose. Use the latter from XSK side and make ice_vsi_cfg_rxq() static.

ice_vsi_cfg_rxq() resides in ice_base.c and is rather big, so to reduce
the code churn let us move two callers of it from ice_lib.c to
ice_base.c.

Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Acked-by: Magnus Karlsson <magnus.karlsson@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Chandan Kumar Rout <chandanx.rout@intel.com> (A Contingent Worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_base.c | 58 ++++++++++++++++++++++-
 drivers/net/ethernet/intel/ice/ice_base.h |  3 +-
 drivers/net/ethernet/intel/ice/ice_lib.c  | 56 ----------------------
 drivers/net/ethernet/intel/ice/ice_lib.h  |  4 --
 drivers/net/ethernet/intel/ice/ice_xsk.c  |  2 +-
 5 files changed, 60 insertions(+), 63 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_base.c b/drivers/net/ethernet/intel/ice/ice_base.c
index 7ac847718882..f49cf6a26753 100644
--- a/drivers/net/ethernet/intel/ice/ice_base.c
+++ b/drivers/net/ethernet/intel/ice/ice_base.c
@@ -538,7 +538,7 @@ static void ice_xsk_pool_fill_cb(struct ice_rx_ring *ring)
  *
  * Return 0 on success and a negative value on error.
  */
-int ice_vsi_cfg_rxq(struct ice_rx_ring *ring)
+static int ice_vsi_cfg_rxq(struct ice_rx_ring *ring)
 {
 	struct device *dev = ice_pf_to_dev(ring->vsi->back);
 	u32 num_bufs = ICE_RX_DESC_UNUSED(ring);
@@ -633,6 +633,62 @@ int ice_vsi_cfg_rxq(struct ice_rx_ring *ring)
 	return 0;
 }
 
+int ice_vsi_cfg_single_rxq(struct ice_vsi *vsi, u16 q_idx)
+{
+	if (q_idx >= vsi->num_rxq)
+		return -EINVAL;
+
+	return ice_vsi_cfg_rxq(vsi->rx_rings[q_idx]);
+}
+
+/**
+ * ice_vsi_cfg_frame_size - setup max frame size and Rx buffer length
+ * @vsi: VSI
+ */
+static void ice_vsi_cfg_frame_size(struct ice_vsi *vsi)
+{
+	if (!vsi->netdev || test_bit(ICE_FLAG_LEGACY_RX, vsi->back->flags)) {
+		vsi->max_frame = ICE_MAX_FRAME_LEGACY_RX;
+		vsi->rx_buf_len = ICE_RXBUF_1664;
+#if (PAGE_SIZE < 8192)
+	} else if (!ICE_2K_TOO_SMALL_WITH_PADDING &&
+		   (vsi->netdev->mtu <= ETH_DATA_LEN)) {
+		vsi->max_frame = ICE_RXBUF_1536 - NET_IP_ALIGN;
+		vsi->rx_buf_len = ICE_RXBUF_1536 - NET_IP_ALIGN;
+#endif
+	} else {
+		vsi->max_frame = ICE_AQ_SET_MAC_FRAME_SIZE_MAX;
+		vsi->rx_buf_len = ICE_RXBUF_3072;
+	}
+}
+
+/**
+ * ice_vsi_cfg_rxqs - Configure the VSI for Rx
+ * @vsi: the VSI being configured
+ *
+ * Return 0 on success and a negative value on error
+ * Configure the Rx VSI for operation.
+ */
+int ice_vsi_cfg_rxqs(struct ice_vsi *vsi)
+{
+	u16 i;
+
+	if (vsi->type == ICE_VSI_VF)
+		goto setup_rings;
+
+	ice_vsi_cfg_frame_size(vsi);
+setup_rings:
+	/* set up individual rings */
+	ice_for_each_rxq(vsi, i) {
+		int err = ice_vsi_cfg_rxq(vsi->rx_rings[i]);
+
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
 /**
  * __ice_vsi_get_qs - helper function for assigning queues from PF to VSI
  * @qs_cfg: gathered variables needed for pf->vsi queues assignment
diff --git a/drivers/net/ethernet/intel/ice/ice_base.h b/drivers/net/ethernet/intel/ice/ice_base.h
index 17321ba75602..85e607644560 100644
--- a/drivers/net/ethernet/intel/ice/ice_base.h
+++ b/drivers/net/ethernet/intel/ice/ice_base.h
@@ -6,7 +6,8 @@
 
 #include "ice.h"
 
-int ice_vsi_cfg_rxq(struct ice_rx_ring *ring);
+int ice_vsi_cfg_single_rxq(struct ice_vsi *vsi, u16 q_idx);
+int ice_vsi_cfg_rxqs(struct ice_vsi *vsi);
 int __ice_vsi_get_qs(struct ice_qs_cfg *qs_cfg);
 int
 ice_vsi_ctrl_one_rx_ring(struct ice_vsi *vsi, bool ena, u16 rxq_idx, bool wait);
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 9be724291ef8..a2d3e5e9fed8 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -1671,27 +1671,6 @@ static void ice_vsi_set_rss_flow_fld(struct ice_vsi *vsi)
 	}
 }
 
-/**
- * ice_vsi_cfg_frame_size - setup max frame size and Rx buffer length
- * @vsi: VSI
- */
-static void ice_vsi_cfg_frame_size(struct ice_vsi *vsi)
-{
-	if (!vsi->netdev || test_bit(ICE_FLAG_LEGACY_RX, vsi->back->flags)) {
-		vsi->max_frame = ICE_MAX_FRAME_LEGACY_RX;
-		vsi->rx_buf_len = ICE_RXBUF_1664;
-#if (PAGE_SIZE < 8192)
-	} else if (!ICE_2K_TOO_SMALL_WITH_PADDING &&
-		   (vsi->netdev->mtu <= ETH_DATA_LEN)) {
-		vsi->max_frame = ICE_RXBUF_1536 - NET_IP_ALIGN;
-		vsi->rx_buf_len = ICE_RXBUF_1536 - NET_IP_ALIGN;
-#endif
-	} else {
-		vsi->max_frame = ICE_AQ_SET_MAC_FRAME_SIZE_MAX;
-		vsi->rx_buf_len = ICE_RXBUF_3072;
-	}
-}
-
 /**
  * ice_pf_state_is_nominal - checks the PF for nominal state
  * @pf: pointer to PF to check
@@ -1795,14 +1774,6 @@ ice_write_qrxflxp_cntxt(struct ice_hw *hw, u16 pf_q, u32 rxdid, u32 prio,
 	wr32(hw, QRXFLXP_CNTXT(pf_q), regval);
 }
 
-int ice_vsi_cfg_single_rxq(struct ice_vsi *vsi, u16 q_idx)
-{
-	if (q_idx >= vsi->num_rxq)
-		return -EINVAL;
-
-	return ice_vsi_cfg_rxq(vsi->rx_rings[q_idx]);
-}
-
 int ice_vsi_cfg_single_txq(struct ice_vsi *vsi, struct ice_tx_ring **tx_rings, u16 q_idx)
 {
 	DEFINE_FLEX(struct ice_aqc_add_tx_qgrp, qg_buf, txqs, 1);
@@ -1815,33 +1786,6 @@ int ice_vsi_cfg_single_txq(struct ice_vsi *vsi, struct ice_tx_ring **tx_rings, u
 	return ice_vsi_cfg_txq(vsi, tx_rings[q_idx], qg_buf);
 }
 
-/**
- * ice_vsi_cfg_rxqs - Configure the VSI for Rx
- * @vsi: the VSI being configured
- *
- * Return 0 on success and a negative value on error
- * Configure the Rx VSI for operation.
- */
-int ice_vsi_cfg_rxqs(struct ice_vsi *vsi)
-{
-	u16 i;
-
-	if (vsi->type == ICE_VSI_VF)
-		goto setup_rings;
-
-	ice_vsi_cfg_frame_size(vsi);
-setup_rings:
-	/* set up individual rings */
-	ice_for_each_rxq(vsi, i) {
-		int err = ice_vsi_cfg_rxq(vsi->rx_rings[i]);
-
-		if (err)
-			return err;
-	}
-
-	return 0;
-}
-
 /**
  * ice_vsi_cfg_txqs - Configure the VSI for Tx
  * @vsi: the VSI being configured
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.h b/drivers/net/ethernet/intel/ice/ice_lib.h
index 71bd27244941..6ffe4b0603bd 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.h
+++ b/drivers/net/ethernet/intel/ice/ice_lib.h
@@ -54,12 +54,8 @@ bool ice_pf_state_is_nominal(struct ice_pf *pf);
 
 void ice_update_eth_stats(struct ice_vsi *vsi);
 
-int ice_vsi_cfg_single_rxq(struct ice_vsi *vsi, u16 q_idx);
-
 int ice_vsi_cfg_single_txq(struct ice_vsi *vsi, struct ice_tx_ring **tx_rings, u16 q_idx);
 
-int ice_vsi_cfg_rxqs(struct ice_vsi *vsi);
-
 int ice_vsi_cfg_lan_txqs(struct ice_vsi *vsi);
 
 void ice_vsi_cfg_msix(struct ice_vsi *vsi);
diff --git a/drivers/net/ethernet/intel/ice/ice_xsk.c b/drivers/net/ethernet/intel/ice/ice_xsk.c
index 8b81a1677045..617e4d14d46e 100644
--- a/drivers/net/ethernet/intel/ice/ice_xsk.c
+++ b/drivers/net/ethernet/intel/ice/ice_xsk.c
@@ -249,7 +249,7 @@ static int ice_qp_ena(struct ice_vsi *vsi, u16 q_idx)
 		ice_tx_xsk_pool(vsi, q_idx);
 	}
 
-	err = ice_vsi_cfg_rxq(rx_ring);
+	err = ice_vsi_cfg_single_rxq(vsi, q_idx);
 	if (err)
 		return err;
 
-- 
2.41.0


