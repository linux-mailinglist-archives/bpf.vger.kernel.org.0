Return-Path: <bpf+bounces-59375-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AD95AC96E7
	for <lists+bpf@lfdr.de>; Fri, 30 May 2025 23:12:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88A061C05459
	for <lists+bpf@lfdr.de>; Fri, 30 May 2025 21:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1E8C283159;
	Fri, 30 May 2025 21:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jmumj2mc"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC79238166;
	Fri, 30 May 2025 21:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748639549; cv=none; b=Oj+03T1g9Sd5MXsKGtYM8J6nsVRv73vQDcgiK5NUY5c377GYrJ4Q4fz01f7ijarWTRD57I9oChAjjSwnggLKFqaKSpiuoMc55ekluUS9RUbQFJscJqMyfnZnhIgHMeGePXP7Tbt7l6ANjmMngP24WBDgBn39vPVGSfBHjoZunNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748639549; c=relaxed/simple;
	bh=1RDbQof3hcUoVEnNR567nz5IImp8cq1fU0bWH7YJTec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rH93DZMLPD9qkk3FLZZ/MAO31Mga6mTWSbOhDKcWKvixPgWVGgmiILz/z/d+KsQtRgx1ESEP3fpUGf7/b+bPJMQFKzEF5cJepVhqD+z04sJ0+4ul+9HVe7uIxtGXLB0KFOJBqiC6HXAfRv8Y9RdKLPHvLHkGXlIdCovGyKeqUII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jmumj2mc; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748639548; x=1780175548;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1RDbQof3hcUoVEnNR567nz5IImp8cq1fU0bWH7YJTec=;
  b=jmumj2mcnKlv5fNVhWhzNx+7HA2ggsZBl87ACui+eWljDD0/Nm8yv7i7
   i6Sl2UxgR/58decuFp85Kudyfot4zt0AQmuUVtSw5LD3hLA+sYy4YMGkv
   v/azKot7vMV6FyDHcy8xnb7Fev7wDWKvR4yZl3eMmjvyS+OQUw4dlTUQz
   tSFNJQQyUb/VjgaHyQqhIkU0R9L8j5vQsxAN6nygcZPM+Zmcs0xn+KU/j
   oA9WJ8RagrH+UWzwyRgzTohobPXAy5RrUR+pgu8Jxge8srdVhNWMw9/jH
   YMpqIxUWi2fh6jh7vlrjbpzvFjiCz2WXeL+ynq6V+fBHBI09Hl9kADr+b
   Q==;
X-CSE-ConnectionGUID: enqmVmWhScezj0PXyAoAbQ==
X-CSE-MsgGUID: eEW6fesEQ/aAeqzz0nvQ+w==
X-IronPort-AV: E=McAfee;i="6700,10204,11449"; a="49862594"
X-IronPort-AV: E=Sophos;i="6.16,196,1744095600"; 
   d="scan'208";a="49862594"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2025 14:12:25 -0700
X-CSE-ConnectionGUID: 735D8l67QmO4PZkhyRtv7Q==
X-CSE-MsgGUID: 5cKEsaghRBOjA7gaaH4oVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,196,1744095600"; 
   d="scan'208";a="144621672"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa007.jf.intel.com with ESMTP; 30 May 2025 14:12:25 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Michal Kubiak <michal.kubiak@intel.com>,
	anthony.l.nguyen@intel.com,
	aleksander.lobakin@intel.com,
	maciej.fijalkowski@intel.com,
	magnus.karlsson@intel.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	bpf@vger.kernel.org,
	Dawid Osuchowski <dawid.osuchowski@linux.intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Simon Horman <horms@kernel.org>,
	Jesse Brandeburg <jbrandeburg@cloudflare.com>,
	Saritha Sanigani <sarithax.sanigani@intel.com>
Subject: [PATCH net 1/5] ice: fix Tx scheduler error handling in XDP callback
Date: Fri, 30 May 2025 14:12:15 -0700
Message-ID: <20250530211221.2170484-2-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250530211221.2170484-1-anthony.l.nguyen@intel.com>
References: <20250530211221.2170484-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michal Kubiak <michal.kubiak@intel.com>

When the XDP program is loaded, the XDP callback adds new Tx queues.
This means that the callback must update the Tx scheduler with the new
queue number. In the event of a Tx scheduler failure, the XDP callback
should also fail and roll back any changes previously made for XDP
preparation.

The previous implementation had a bug that not all changes made by the
XDP callback were rolled back. This caused the crash with the following
call trace:

[  +9.549584] ice 0000:ca:00.0: Failed VSI LAN queue config for XDP, error: -5
[  +0.382335] Oops: general protection fault, probably for non-canonical address 0x50a2250a90495525: 0000 [#1] SMP NOPTI
[  +0.010710] CPU: 103 UID: 0 PID: 0 Comm: swapper/103 Not tainted 6.14.0-net-next-mar-31+ #14 PREEMPT(voluntary)
[  +0.010175] Hardware name: Intel Corporation M50CYP2SBSTD/M50CYP2SBSTD, BIOS SE5C620.86B.01.01.0005.2202160810 02/16/2022
[  +0.010946] RIP: 0010:__ice_update_sample+0x39/0xe0 [ice]

[...]

[  +0.002715] Call Trace:
[  +0.002452]  <IRQ>
[  +0.002021]  ? __die_body.cold+0x19/0x29
[  +0.003922]  ? die_addr+0x3c/0x60
[  +0.003319]  ? exc_general_protection+0x17c/0x400
[  +0.004707]  ? asm_exc_general_protection+0x26/0x30
[  +0.004879]  ? __ice_update_sample+0x39/0xe0 [ice]
[  +0.004835]  ice_napi_poll+0x665/0x680 [ice]
[  +0.004320]  __napi_poll+0x28/0x190
[  +0.003500]  net_rx_action+0x198/0x360
[  +0.003752]  ? update_rq_clock+0x39/0x220
[  +0.004013]  handle_softirqs+0xf1/0x340
[  +0.003840]  ? sched_clock_cpu+0xf/0x1f0
[  +0.003925]  __irq_exit_rcu+0xc2/0xe0
[  +0.003665]  common_interrupt+0x85/0xa0
[  +0.003839]  </IRQ>
[  +0.002098]  <TASK>
[  +0.002106]  asm_common_interrupt+0x26/0x40
[  +0.004184] RIP: 0010:cpuidle_enter_state+0xd3/0x690

Fix this by performing the missing unmapping of XDP queues from
q_vectors and setting the XDP rings pointer back to NULL after all those
queues are released.
Also, add an immediate exit from the XDP callback in case of ring
preparation failure.

Fixes: efc2214b6047 ("ice: Add support for XDP")
Reviewed-by: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Michal Kubiak <michal.kubiak@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Jesse Brandeburg <jbrandeburg@cloudflare.com>
Tested-by: Saritha Sanigani <sarithax.sanigani@intel.com> (A Contingent Worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 47 ++++++++++++++++-------
 1 file changed, 33 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 20d3baf955e3..d97d4b25b30d 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -2740,6 +2740,27 @@ void ice_map_xdp_rings(struct ice_vsi *vsi)
 	}
 }
 
+/**
+ * ice_unmap_xdp_rings - Unmap XDP rings from interrupt vectors
+ * @vsi: the VSI with XDP rings being unmapped
+ */
+static void ice_unmap_xdp_rings(struct ice_vsi *vsi)
+{
+	int v_idx;
+
+	ice_for_each_q_vector(vsi, v_idx) {
+		struct ice_q_vector *q_vector = vsi->q_vectors[v_idx];
+		struct ice_tx_ring *ring;
+
+		ice_for_each_tx_ring(ring, q_vector->tx)
+			if (!ring->tx_buf || !ice_ring_is_xdp(ring))
+				break;
+
+		/* restore the value of last node prior to XDP setup */
+		q_vector->tx.tx_ring = ring;
+	}
+}
+
 /**
  * ice_prepare_xdp_rings - Allocate, configure and setup Tx rings for XDP
  * @vsi: VSI to bring up Tx rings used by XDP
@@ -2803,7 +2824,7 @@ int ice_prepare_xdp_rings(struct ice_vsi *vsi, struct bpf_prog *prog,
 	if (status) {
 		dev_err(dev, "Failed VSI LAN queue config for XDP, error: %d\n",
 			status);
-		goto clear_xdp_rings;
+		goto unmap_xdp_rings;
 	}
 
 	/* assign the prog only when it's not already present on VSI;
@@ -2819,6 +2840,8 @@ int ice_prepare_xdp_rings(struct ice_vsi *vsi, struct bpf_prog *prog,
 		ice_vsi_assign_bpf_prog(vsi, prog);
 
 	return 0;
+unmap_xdp_rings:
+	ice_unmap_xdp_rings(vsi);
 clear_xdp_rings:
 	ice_for_each_xdp_txq(vsi, i)
 		if (vsi->xdp_rings[i]) {
@@ -2835,6 +2858,8 @@ int ice_prepare_xdp_rings(struct ice_vsi *vsi, struct bpf_prog *prog,
 	mutex_unlock(&pf->avail_q_mutex);
 
 	devm_kfree(dev, vsi->xdp_rings);
+	vsi->xdp_rings = NULL;
+
 	return -ENOMEM;
 }
 
@@ -2850,7 +2875,7 @@ int ice_destroy_xdp_rings(struct ice_vsi *vsi, enum ice_xdp_cfg cfg_type)
 {
 	u16 max_txqs[ICE_MAX_TRAFFIC_CLASS] = { 0 };
 	struct ice_pf *pf = vsi->back;
-	int i, v_idx;
+	int i;
 
 	/* q_vectors are freed in reset path so there's no point in detaching
 	 * rings
@@ -2858,17 +2883,7 @@ int ice_destroy_xdp_rings(struct ice_vsi *vsi, enum ice_xdp_cfg cfg_type)
 	if (cfg_type == ICE_XDP_CFG_PART)
 		goto free_qmap;
 
-	ice_for_each_q_vector(vsi, v_idx) {
-		struct ice_q_vector *q_vector = vsi->q_vectors[v_idx];
-		struct ice_tx_ring *ring;
-
-		ice_for_each_tx_ring(ring, q_vector->tx)
-			if (!ring->tx_buf || !ice_ring_is_xdp(ring))
-				break;
-
-		/* restore the value of last node prior to XDP setup */
-		q_vector->tx.tx_ring = ring;
-	}
+	ice_unmap_xdp_rings(vsi);
 
 free_qmap:
 	mutex_lock(&pf->avail_q_mutex);
@@ -3013,11 +3028,14 @@ ice_xdp_setup_prog(struct ice_vsi *vsi, struct bpf_prog *prog,
 		xdp_ring_err = ice_vsi_determine_xdp_res(vsi);
 		if (xdp_ring_err) {
 			NL_SET_ERR_MSG_MOD(extack, "Not enough Tx resources for XDP");
+			goto resume_if;
 		} else {
 			xdp_ring_err = ice_prepare_xdp_rings(vsi, prog,
 							     ICE_XDP_CFG_FULL);
-			if (xdp_ring_err)
+			if (xdp_ring_err) {
 				NL_SET_ERR_MSG_MOD(extack, "Setting up XDP Tx resources failed");
+				goto resume_if;
+			}
 		}
 		xdp_features_set_redirect_target(vsi->netdev, true);
 		/* reallocate Rx queues that are used for zero-copy */
@@ -3035,6 +3053,7 @@ ice_xdp_setup_prog(struct ice_vsi *vsi, struct bpf_prog *prog,
 			NL_SET_ERR_MSG_MOD(extack, "Freeing XDP Rx resources failed");
 	}
 
+resume_if:
 	if (if_running)
 		ret = ice_up(vsi);
 
-- 
2.47.1


