Return-Path: <bpf+bounces-21076-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 642428476CE
	for <lists+bpf@lfdr.de>; Fri,  2 Feb 2024 18:58:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64B6B1C25C51
	for <lists+bpf@lfdr.de>; Fri,  2 Feb 2024 17:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FABF14C5BA;
	Fri,  2 Feb 2024 17:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jCWw29YS"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369A71509AF;
	Fri,  2 Feb 2024 17:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706896584; cv=none; b=tQSq5G5vDiUYt4JLuTQTJfjSazvnufHXs3SCNuntdMx+D++tum4uw72pAwljAM/yUzgySwDC/EKFKxqcD+p2Uc8SVUj1j+8QeRGSU7bbnaOjgHQzeRwTVlzulGCVQWsyvArNOskDg06jXzzj/qxJgO+myJC4H1OVqBEAyYkUTuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706896584; c=relaxed/simple;
	bh=NsXxokl/vQR4r6JF4L/WEZodHBGta13WP5nk1U7r/Vc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z1vktoJGiBinG1sEa4iDoX+kbFNPjhQsGc2/De6Wa8tb6PGs6mNUhtK+/QcOiChdMW8BxC7fQCFwy8LJhEV2XBiW6RGcEP0mv3jV9LNT90c77xt2D42FBUr/sXuc39T4E0xjS9Yf3wZdcpEL6UXsyrXCPMFQhBhThl1bdAvBCgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jCWw29YS; arc=none smtp.client-ip=192.55.52.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706896582; x=1738432582;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NsXxokl/vQR4r6JF4L/WEZodHBGta13WP5nk1U7r/Vc=;
  b=jCWw29YSApE8ihsRlZSSNemoxdB8RFEMFfz48Br7RzTB0rATp22f9K7Z
   8dZAOXomx2LEcR7smGizc+5iT04fCyyYv5FnDoVPd8kQNMAtTCT9l2oyD
   /U+Oxn541MUHHL/eigcggAxsZYXwHUvRpfwjWo1eCUjJZKe4aT5gXSSdQ
   UU9PWteWEKSBlAywq8x3V60YJOF1FLOAXOVoiJO6mXL45wcNqgCkyQXXC
   L705Rt7WsdV/Jx4LjkpxyFK/j5HKYHZtcGkNcR5LfMbS79UtsRWnsDCQj
   x7KVn5KMzOs3gMtht/S9VlcQm5OHYFUSkOpbJoadoND3nRxW5BxzVGJD8
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="435347618"
X-IronPort-AV: E=Sophos;i="6.05,238,1701158400"; 
   d="scan'208";a="435347618"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2024 09:56:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,238,1701158400"; 
   d="scan'208";a="137836"
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
Subject: [PATCH net-next 2/4] ice: make ice_vsi_cfg_txq() static
Date: Fri,  2 Feb 2024 09:56:10 -0800
Message-ID: <20240202175613.3470818-3-anthony.l.nguyen@intel.com>
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
ice_vsi_cfg_txq() whereas we have ice_vsi_cfg_single_txq() for that
purpose. Use the latter from XSK side and make ice_vsi_cfg_txq() static.

ice_vsi_cfg_txq() resides in ice_base.c and is rather big, so to reduce
the code churn let us move the callers of it from ice_lib.c to
ice_base.c.

This change puts ice_qp_ena() on nice diet due to the checks and
operations that ice_vsi_cfg_single_{r,t}xq() do internally.

add/remove: 0/0 grow/shrink: 0/1 up/down: 0/-182 (-182)
Function                                     old     new   delta
ice_xsk_pool_setup                          2165    1983    -182
Total: Before=472597, After=472415, chg -0.04%

Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Acked-by: Magnus Karlsson <magnus.karlsson@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Chandan Kumar Rout <chandanx.rout@intel.com> (A Contingent Worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_base.c | 76 ++++++++++++++++++++++-
 drivers/net/ethernet/intel/ice/ice_base.h |  7 ++-
 drivers/net/ethernet/intel/ice/ice_lib.c  | 73 ----------------------
 drivers/net/ethernet/intel/ice/ice_lib.h  |  6 --
 drivers/net/ethernet/intel/ice/ice_xsk.c  | 20 +-----
 5 files changed, 82 insertions(+), 100 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_base.c b/drivers/net/ethernet/intel/ice/ice_base.c
index f49cf6a26753..ad953208f582 100644
--- a/drivers/net/ethernet/intel/ice/ice_base.c
+++ b/drivers/net/ethernet/intel/ice/ice_base.c
@@ -884,7 +884,7 @@ void ice_vsi_free_q_vectors(struct ice_vsi *vsi)
  * @ring: Tx ring to be configured
  * @qg_buf: queue group buffer
  */
-int
+static int
 ice_vsi_cfg_txq(struct ice_vsi *vsi, struct ice_tx_ring *ring,
 		struct ice_aqc_add_tx_qgrp *qg_buf)
 {
@@ -955,6 +955,80 @@ ice_vsi_cfg_txq(struct ice_vsi *vsi, struct ice_tx_ring *ring,
 	return 0;
 }
 
+int ice_vsi_cfg_single_txq(struct ice_vsi *vsi, struct ice_tx_ring **tx_rings,
+			   u16 q_idx)
+{
+	DEFINE_FLEX(struct ice_aqc_add_tx_qgrp, qg_buf, txqs, 1);
+
+	if (q_idx >= vsi->alloc_txq || !tx_rings || !tx_rings[q_idx])
+		return -EINVAL;
+
+	qg_buf->num_txqs = 1;
+
+	return ice_vsi_cfg_txq(vsi, tx_rings[q_idx], qg_buf);
+}
+
+/**
+ * ice_vsi_cfg_txqs - Configure the VSI for Tx
+ * @vsi: the VSI being configured
+ * @rings: Tx ring array to be configured
+ * @count: number of Tx ring array elements
+ *
+ * Return 0 on success and a negative value on error
+ * Configure the Tx VSI for operation.
+ */
+static int
+ice_vsi_cfg_txqs(struct ice_vsi *vsi, struct ice_tx_ring **rings, u16 count)
+{
+	DEFINE_FLEX(struct ice_aqc_add_tx_qgrp, qg_buf, txqs, 1);
+	int err = 0;
+	u16 q_idx;
+
+	qg_buf->num_txqs = 1;
+
+	for (q_idx = 0; q_idx < count; q_idx++) {
+		err = ice_vsi_cfg_txq(vsi, rings[q_idx], qg_buf);
+		if (err)
+			break;
+	}
+
+	return err;
+}
+
+/**
+ * ice_vsi_cfg_lan_txqs - Configure the VSI for Tx
+ * @vsi: the VSI being configured
+ *
+ * Return 0 on success and a negative value on error
+ * Configure the Tx VSI for operation.
+ */
+int ice_vsi_cfg_lan_txqs(struct ice_vsi *vsi)
+{
+	return ice_vsi_cfg_txqs(vsi, vsi->tx_rings, vsi->num_txq);
+}
+
+/**
+ * ice_vsi_cfg_xdp_txqs - Configure Tx queues dedicated for XDP in given VSI
+ * @vsi: the VSI being configured
+ *
+ * Return 0 on success and a negative value on error
+ * Configure the Tx queues dedicated for XDP in given VSI for operation.
+ */
+int ice_vsi_cfg_xdp_txqs(struct ice_vsi *vsi)
+{
+	int ret;
+	int i;
+
+	ret = ice_vsi_cfg_txqs(vsi, vsi->xdp_rings, vsi->num_xdp_txq);
+	if (ret)
+		return ret;
+
+	ice_for_each_rxq(vsi, i)
+		ice_tx_xsk_pool(vsi, i);
+
+	return 0;
+}
+
 /**
  * ice_cfg_itr - configure the initial interrupt throttle values
  * @hw: pointer to the HW structure
diff --git a/drivers/net/ethernet/intel/ice/ice_base.h b/drivers/net/ethernet/intel/ice/ice_base.h
index 85e607644560..b711bc921928 100644
--- a/drivers/net/ethernet/intel/ice/ice_base.h
+++ b/drivers/net/ethernet/intel/ice/ice_base.h
@@ -15,9 +15,10 @@ int ice_vsi_wait_one_rx_ring(struct ice_vsi *vsi, bool ena, u16 rxq_idx);
 int ice_vsi_alloc_q_vectors(struct ice_vsi *vsi);
 void ice_vsi_map_rings_to_vectors(struct ice_vsi *vsi);
 void ice_vsi_free_q_vectors(struct ice_vsi *vsi);
-int
-ice_vsi_cfg_txq(struct ice_vsi *vsi, struct ice_tx_ring *ring,
-		struct ice_aqc_add_tx_qgrp *qg_buf);
+int ice_vsi_cfg_single_txq(struct ice_vsi *vsi, struct ice_tx_ring **tx_rings,
+			   u16 q_idx);
+int ice_vsi_cfg_lan_txqs(struct ice_vsi *vsi);
+int ice_vsi_cfg_xdp_txqs(struct ice_vsi *vsi);
 void ice_cfg_itr(struct ice_hw *hw, struct ice_q_vector *q_vector);
 void
 ice_cfg_txq_interrupt(struct ice_vsi *vsi, u16 txq, u16 msix_idx, u16 itr_idx);
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index a2d3e5e9fed8..60e0d824195e 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -1774,79 +1774,6 @@ ice_write_qrxflxp_cntxt(struct ice_hw *hw, u16 pf_q, u32 rxdid, u32 prio,
 	wr32(hw, QRXFLXP_CNTXT(pf_q), regval);
 }
 
-int ice_vsi_cfg_single_txq(struct ice_vsi *vsi, struct ice_tx_ring **tx_rings, u16 q_idx)
-{
-	DEFINE_FLEX(struct ice_aqc_add_tx_qgrp, qg_buf, txqs, 1);
-
-	if (q_idx >= vsi->alloc_txq || !tx_rings || !tx_rings[q_idx])
-		return -EINVAL;
-
-	qg_buf->num_txqs = 1;
-
-	return ice_vsi_cfg_txq(vsi, tx_rings[q_idx], qg_buf);
-}
-
-/**
- * ice_vsi_cfg_txqs - Configure the VSI for Tx
- * @vsi: the VSI being configured
- * @rings: Tx ring array to be configured
- * @count: number of Tx ring array elements
- *
- * Return 0 on success and a negative value on error
- * Configure the Tx VSI for operation.
- */
-static int
-ice_vsi_cfg_txqs(struct ice_vsi *vsi, struct ice_tx_ring **rings, u16 count)
-{
-	DEFINE_FLEX(struct ice_aqc_add_tx_qgrp, qg_buf, txqs, 1);
-	int err = 0;
-	u16 q_idx;
-
-	qg_buf->num_txqs = 1;
-
-	for (q_idx = 0; q_idx < count; q_idx++) {
-		err = ice_vsi_cfg_txq(vsi, rings[q_idx], qg_buf);
-		if (err)
-			break;
-	}
-
-	return err;
-}
-
-/**
- * ice_vsi_cfg_lan_txqs - Configure the VSI for Tx
- * @vsi: the VSI being configured
- *
- * Return 0 on success and a negative value on error
- * Configure the Tx VSI for operation.
- */
-int ice_vsi_cfg_lan_txqs(struct ice_vsi *vsi)
-{
-	return ice_vsi_cfg_txqs(vsi, vsi->tx_rings, vsi->num_txq);
-}
-
-/**
- * ice_vsi_cfg_xdp_txqs - Configure Tx queues dedicated for XDP in given VSI
- * @vsi: the VSI being configured
- *
- * Return 0 on success and a negative value on error
- * Configure the Tx queues dedicated for XDP in given VSI for operation.
- */
-int ice_vsi_cfg_xdp_txqs(struct ice_vsi *vsi)
-{
-	int ret;
-	int i;
-
-	ret = ice_vsi_cfg_txqs(vsi, vsi->xdp_rings, vsi->num_xdp_txq);
-	if (ret)
-		return ret;
-
-	ice_for_each_rxq(vsi, i)
-		ice_tx_xsk_pool(vsi, i);
-
-	return 0;
-}
-
 /**
  * ice_intrl_usec_to_reg - convert interrupt rate limit to register value
  * @intrl: interrupt rate limit in usecs
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.h b/drivers/net/ethernet/intel/ice/ice_lib.h
index 6ffe4b0603bd..0c77d581416a 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.h
+++ b/drivers/net/ethernet/intel/ice/ice_lib.h
@@ -54,10 +54,6 @@ bool ice_pf_state_is_nominal(struct ice_pf *pf);
 
 void ice_update_eth_stats(struct ice_vsi *vsi);
 
-int ice_vsi_cfg_single_txq(struct ice_vsi *vsi, struct ice_tx_ring **tx_rings, u16 q_idx);
-
-int ice_vsi_cfg_lan_txqs(struct ice_vsi *vsi);
-
 void ice_vsi_cfg_msix(struct ice_vsi *vsi);
 
 int ice_vsi_start_all_rx_rings(struct ice_vsi *vsi);
@@ -68,8 +64,6 @@ int
 ice_vsi_stop_lan_tx_rings(struct ice_vsi *vsi, enum ice_disq_rst_src rst_src,
 			  u16 rel_vmvf_num);
 
-int ice_vsi_cfg_xdp_txqs(struct ice_vsi *vsi);
-
 int ice_vsi_stop_xdp_tx_rings(struct ice_vsi *vsi);
 
 void ice_cfg_sw_lldp(struct ice_vsi *vsi, bool tx, bool create);
diff --git a/drivers/net/ethernet/intel/ice/ice_xsk.c b/drivers/net/ethernet/intel/ice/ice_xsk.c
index 617e4d14d46e..8a051420fa19 100644
--- a/drivers/net/ethernet/intel/ice/ice_xsk.c
+++ b/drivers/net/ethernet/intel/ice/ice_xsk.c
@@ -217,32 +217,17 @@ static int ice_qp_dis(struct ice_vsi *vsi, u16 q_idx)
  */
 static int ice_qp_ena(struct ice_vsi *vsi, u16 q_idx)
 {
-	DEFINE_FLEX(struct ice_aqc_add_tx_qgrp, qg_buf, txqs, 1);
-	u16 size = __struct_size(qg_buf);
 	struct ice_q_vector *q_vector;
-	struct ice_tx_ring *tx_ring;
-	struct ice_rx_ring *rx_ring;
 	int err;
 
-	if (q_idx >= vsi->num_rxq || q_idx >= vsi->num_txq)
-		return -EINVAL;
-
-	qg_buf->num_txqs = 1;
-
-	tx_ring = vsi->tx_rings[q_idx];
-	rx_ring = vsi->rx_rings[q_idx];
-	q_vector = rx_ring->q_vector;
-
-	err = ice_vsi_cfg_txq(vsi, tx_ring, qg_buf);
+	err = ice_vsi_cfg_single_txq(vsi, vsi->tx_rings, q_idx);
 	if (err)
 		return err;
 
 	if (ice_is_xdp_ena_vsi(vsi)) {
 		struct ice_tx_ring *xdp_ring = vsi->xdp_rings[q_idx];
 
-		memset(qg_buf, 0, size);
-		qg_buf->num_txqs = 1;
-		err = ice_vsi_cfg_txq(vsi, xdp_ring, qg_buf);
+		err = ice_vsi_cfg_single_txq(vsi, vsi->xdp_rings, q_idx);
 		if (err)
 			return err;
 		ice_set_ring_xdp(xdp_ring);
@@ -253,6 +238,7 @@ static int ice_qp_ena(struct ice_vsi *vsi, u16 q_idx)
 	if (err)
 		return err;
 
+	q_vector = vsi->rx_rings[q_idx]->q_vector;
 	ice_qvec_cfg_msix(vsi, q_vector);
 
 	err = ice_vsi_ctrl_one_rx_ring(vsi, true, q_idx, true);
-- 
2.41.0


