Return-Path: <bpf+bounces-38820-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 307D096A68D
	for <lists+bpf@lfdr.de>; Tue,  3 Sep 2024 20:31:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD514282948
	for <lists+bpf@lfdr.de>; Tue,  3 Sep 2024 18:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51551192B6E;
	Tue,  3 Sep 2024 18:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KOmWGhi0"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41CF61917E9;
	Tue,  3 Sep 2024 18:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725388254; cv=none; b=lS4sY0Ap8lLVuYttyUyALVC+CdSVQPk+ITer/HcD/Rk95XYWlXRp7xXU4vme4fxNJdWPiO2elKUFc3kf6B01LcMiE6uzqWwQ1gx9BpYSNREyVeQQFxIlyZKHiLS9oErlXNiZ6GAXIAFrd5Lnw8EHBtSdngewPb5ISWBBWRFzwoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725388254; c=relaxed/simple;
	bh=RMl/2tSkzEFMDLFYEEtH4j/TR5cHFrHAvTbNOtLO0vA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cWRBWu7/wwMMjfUeHRB/PvpLUGNbhL53HgA60XxZR9pu4vojRMAk6X9JrnKnqUPMiJ+mzHlcY4RkoJBsu9MHwkod6vhZ+viDRokGlYYhlZ0ZCMur6YeILcggFpDJHyZhLgKUqbA3SqQANKVgxU6HXGFDakUvVaJt+ZeFhCUJAVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KOmWGhi0; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725388252; x=1756924252;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RMl/2tSkzEFMDLFYEEtH4j/TR5cHFrHAvTbNOtLO0vA=;
  b=KOmWGhi02BiIdJ++pmcxxvkh/l435eowTQEZYHie9i/RcRXWTURHBFO6
   cf/zZVDJYlQE7mFxNTCoiFhzzACqu0S/ZNusTql5ue59qS0Ehrh2mZpNW
   xCIp65kWPRxnjuwdmk0mLRMqxNU366EoVaXM6AqzuKiiXY4m7EOkfrJSP
   siL3hlnlqWJlSLVsC8QS4fZha5duHq0yRwNKeRNZnrRRebIOI+sBANuRQ
   7kqwvHM/p5WY+la5GKPl6iDLQ1kHmbwZjBHNdUO5D1s7gEfE41ZmW+/y9
   uAb6GEifZdKgZHlIL6V9i/M5Yvzc3lAsX89NZEeBx1ro9VZK8+fKFAlK6
   Q==;
X-CSE-ConnectionGUID: FdR+3jQVRLeDmzAjRhUQ9A==
X-CSE-MsgGUID: B0VOutaERUOOQPKHui93Cg==
X-IronPort-AV: E=McAfee;i="6700,10204,11184"; a="24147007"
X-IronPort-AV: E=Sophos;i="6.10,199,1719903600"; 
   d="scan'208";a="24147007"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2024 11:30:51 -0700
X-CSE-ConnectionGUID: LKLSjR9IT7SPVzLVlP2rNw==
X-CSE-MsgGUID: n14Cb9X+QT2bK819bliw6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,199,1719903600"; 
   d="scan'208";a="88250232"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa002.fm.intel.com with ESMTP; 03 Sep 2024 11:30:50 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Larysa Zaremba <larysa.zaremba@intel.com>,
	anthony.l.nguyen@intel.com,
	wojciech.drewek@intel.com,
	michal.kubiak@intel.com,
	jacob.e.keller@intel.com,
	amritha.nambiar@intel.com,
	przemyslaw.kitszel@intel.com,
	sridhar.samudrala@intel.com,
	maciej.fijalkowski@intel.com,
	magnus.karlsson@intel.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	bpf@vger.kernel.org,
	Chandan Kumar Rout <chandanx.rout@intel.com>
Subject: [PATCH net 3/6] ice: check for XDP rings instead of bpf program when unconfiguring
Date: Tue,  3 Sep 2024 11:30:29 -0700
Message-ID: <20240903183034.3530411-4-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240903183034.3530411-1-anthony.l.nguyen@intel.com>
References: <20240903183034.3530411-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Larysa Zaremba <larysa.zaremba@intel.com>

If VSI rebuild is pending, .ndo_bpf() can attach/detach the XDP program on
VSI without applying new ring configuration. When unconfiguring the VSI, we
can encounter the state in which there is an XDP program but no XDP rings
to destroy or there will be XDP rings that need to be destroyed, but no XDP
program to indicate their presence.

When unconfiguring, rely on the presence of XDP rings rather then XDP
program, as they better represent the current state that has to be
destroyed.

Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Tested-by: Chandan Kumar Rout <chandanx.rout@intel.com>
Acked-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_lib.c  | 4 ++--
 drivers/net/ethernet/intel/ice/ice_main.c | 4 ++--
 drivers/net/ethernet/intel/ice/ice_xsk.c  | 6 +++---
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index c1c1b63d9701..3dccfaba024c 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -2426,7 +2426,7 @@ void ice_vsi_decfg(struct ice_vsi *vsi)
 		dev_err(ice_pf_to_dev(pf), "Failed to remove RDMA scheduler config for VSI %u, err %d\n",
 			vsi->vsi_num, err);
 
-	if (ice_is_xdp_ena_vsi(vsi))
+	if (vsi->xdp_rings)
 		/* return value check can be skipped here, it always returns
 		 * 0 if reset is in progress
 		 */
@@ -2528,7 +2528,7 @@ static void ice_vsi_release_msix(struct ice_vsi *vsi)
 		for (q = 0; q < q_vector->num_ring_tx; q++) {
 			ice_write_itr(&q_vector->tx, 0);
 			wr32(hw, QINT_TQCTL(vsi->txq_map[txq]), 0);
-			if (ice_is_xdp_ena_vsi(vsi)) {
+			if (vsi->xdp_rings) {
 				u32 xdp_txq = txq + vsi->num_xdp_txq;
 
 				wr32(hw, QINT_TQCTL(vsi->txq_map[xdp_txq]), 0);
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 4edaddcba3b4..22b8ef5faf8d 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -7249,7 +7249,7 @@ int ice_down(struct ice_vsi *vsi)
 	if (tx_err)
 		netdev_err(vsi->netdev, "Failed stop Tx rings, VSI %d error %d\n",
 			   vsi->vsi_num, tx_err);
-	if (!tx_err && ice_is_xdp_ena_vsi(vsi)) {
+	if (!tx_err && vsi->xdp_rings) {
 		tx_err = ice_vsi_stop_xdp_tx_rings(vsi);
 		if (tx_err)
 			netdev_err(vsi->netdev, "Failed stop XDP rings, VSI %d error %d\n",
@@ -7266,7 +7266,7 @@ int ice_down(struct ice_vsi *vsi)
 	ice_for_each_txq(vsi, i)
 		ice_clean_tx_ring(vsi->tx_rings[i]);
 
-	if (ice_is_xdp_ena_vsi(vsi))
+	if (vsi->xdp_rings)
 		ice_for_each_xdp_txq(vsi, i)
 			ice_clean_tx_ring(vsi->xdp_rings[i]);
 
diff --git a/drivers/net/ethernet/intel/ice/ice_xsk.c b/drivers/net/ethernet/intel/ice/ice_xsk.c
index a659951fa987..8693509efbe7 100644
--- a/drivers/net/ethernet/intel/ice/ice_xsk.c
+++ b/drivers/net/ethernet/intel/ice/ice_xsk.c
@@ -39,7 +39,7 @@ static void ice_qp_reset_stats(struct ice_vsi *vsi, u16 q_idx)
 	       sizeof(vsi_stat->rx_ring_stats[q_idx]->rx_stats));
 	memset(&vsi_stat->tx_ring_stats[q_idx]->stats, 0,
 	       sizeof(vsi_stat->tx_ring_stats[q_idx]->stats));
-	if (ice_is_xdp_ena_vsi(vsi))
+	if (vsi->xdp_rings)
 		memset(&vsi->xdp_rings[q_idx]->ring_stats->stats, 0,
 		       sizeof(vsi->xdp_rings[q_idx]->ring_stats->stats));
 }
@@ -52,7 +52,7 @@ static void ice_qp_reset_stats(struct ice_vsi *vsi, u16 q_idx)
 static void ice_qp_clean_rings(struct ice_vsi *vsi, u16 q_idx)
 {
 	ice_clean_tx_ring(vsi->tx_rings[q_idx]);
-	if (ice_is_xdp_ena_vsi(vsi))
+	if (vsi->xdp_rings)
 		ice_clean_tx_ring(vsi->xdp_rings[q_idx]);
 	ice_clean_rx_ring(vsi->rx_rings[q_idx]);
 }
@@ -194,7 +194,7 @@ static int ice_qp_dis(struct ice_vsi *vsi, u16 q_idx)
 	err = ice_vsi_stop_tx_ring(vsi, ICE_NO_RESET, 0, tx_ring, &txq_meta);
 	if (!fail)
 		fail = err;
-	if (ice_is_xdp_ena_vsi(vsi)) {
+	if (vsi->xdp_rings) {
 		struct ice_tx_ring *xdp_ring = vsi->xdp_rings[q_idx];
 
 		memset(&txq_meta, 0, sizeof(txq_meta));
-- 
2.42.0


