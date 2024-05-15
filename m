Return-Path: <bpf+bounces-29780-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D1E28C6A3D
	for <lists+bpf@lfdr.de>; Wed, 15 May 2024 18:10:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 802A11F234C0
	for <lists+bpf@lfdr.de>; Wed, 15 May 2024 16:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8875F156993;
	Wed, 15 May 2024 16:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ppt+KjmK"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B51156679;
	Wed, 15 May 2024 16:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715789367; cv=none; b=YagKsbILihuuwiNXzzzOIVc2APl+3Kf8+SvKQ03Os7R5APkFaJfwTucaS+rWptFX0zH4YvF9Wf+oUSoijCXMhhs0pYgVHjkPA8+AxYzetQZwX8o2lcUYipA0oj+uj3B6WCrSc7x96mDEKoo2ZalPIJTbmskbXFJs6aJ3SALSDMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715789367; c=relaxed/simple;
	bh=qnev+muridwm44bGaSO0aPsN1QaY80zct7zOfv7nlXY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DC6Jf8NZxw8np+dFcyJ4kElVt4QwNbNjOeUWy4hdIPHZvh6mHcRdkW0fdtb65IAY2yqrwk2NF88spJMswFCB4giaQC0CwNUtf6+7H8uACaOfc/p6FZNkqKLKN+tM86oqRHdE5tDzOocglF+2ykyP3QCMXNOMGSQjkknhmRY0JrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ppt+KjmK; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715789365; x=1747325365;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qnev+muridwm44bGaSO0aPsN1QaY80zct7zOfv7nlXY=;
  b=Ppt+KjmK6oRrRo4qV4gkLDV0+vtzh6uYsBvbi4o5/T50PfLfCkWjoPks
   JU3Xl4GEN/Hb6n+/gFKCnli8sUz5Rj/dH8UjXAS7+MtYtJrckRFKDdG7n
   fF3YYktT+8RCeJLsuKwjZ1eydlxATNOW27SeI7oERxWu/bxndbmG1BjJb
   nODy0LpKewI3eo0IZIuvFXe88WBJJZYvb86s8qKrYIpa+qoN0pbk083kQ
   bEk8k9CVHJleg0T8Xcxooi+/DEC/32kd7gMfoKo+7G29/gwvJJd3tU8yY
   HjsCzzFkvXbs3/zq7/b5vUbY7ys+ACcASjBdhIdWha7jDZfUMhJJ0e7Ec
   Q==;
X-CSE-ConnectionGUID: dk0Sg3EIQ8StpK3SJcEnHw==
X-CSE-MsgGUID: 9EPsXQvITiW9+i1vwYNR0w==
X-IronPort-AV: E=McAfee;i="6600,9927,11074"; a="11666393"
X-IronPort-AV: E=Sophos;i="6.08,162,1712646000"; 
   d="scan'208";a="11666393"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2024 09:09:24 -0700
X-CSE-ConnectionGUID: m636+dHaQci/wJcHENMupw==
X-CSE-MsgGUID: i8oMmVWMS3yBHE27eGL30Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,162,1712646000"; 
   d="scan'208";a="62297353"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa001.fm.intel.com with ESMTP; 15 May 2024 09:09:19 -0700
Received: from lincoln.igk.intel.com (lincoln.igk.intel.com [10.102.21.235])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 03A752878A;
	Wed, 15 May 2024 17:09:17 +0100 (IST)
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	Jacob Keller <jacob.e.keller@intel.com>
Cc: Larysa Zaremba <larysa.zaremba@intel.com>,
	maciej.fijalkowski@intel.com,
	Magnus Karlsson <magnus.karlsson@gmail.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	igor.bagnucki@intel.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH iwl-net 2/3] ice: add flag to distinguish reset from .ndo_bpf in XDP rings config
Date: Wed, 15 May 2024 18:02:15 +0200
Message-ID: <20240515160246.5181-3-larysa.zaremba@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240515160246.5181-1-larysa.zaremba@intel.com>
References: <20240515160246.5181-1-larysa.zaremba@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 6624e780a577 ("ice: split ice_vsi_setup into smaller functions")
has placed ice_vsi_free_q_vectors() after ice_destroy_xdp_rings() in
the rebuild process. The behaviour of the XDP rings config functions is
context-dependent, so the change of order has led to
ice_destroy_xdp_rings() doing additional work and removing XDP prog, when
it was supposed to be preserved.

Also, dependency on the PF state reset flags creates an additional,
fortunately less common problem:

* PFR is requested e.g. by tx_timeout handler
* .ndo_bpf() is asked to delete the program, calls ice_destroy_xdp_rings(),
  but reset flag is set, so rings are destroyed without deleting the
  program
* ice_vsi_rebuild tries to delete non-existent XDP rings, because the
  program is still on the VSI
* system crashes

With a similar race, when requested to attach a program,
ice_prepare_xdp_rings() can actually skip setting the program in the VSI
and nevertheless report success.

Instead of reverting to the old order of function calls, add an enum
argument to both ice_prepare_xdp_rings() and ice_destroy_xdp_rings() in
order to distinguish between calls from rebuild and .ndo_bpf().

Fixes: efc2214b6047 ("ice: Add support for XDP")
Reviewed-by: Igor Bagnucki <igor.bagnucki@intel.com>
Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
---
 drivers/net/ethernet/intel/ice/ice.h      | 11 +++++++++--
 drivers/net/ethernet/intel/ice/ice_lib.c  |  5 +++--
 drivers/net/ethernet/intel/ice/ice_main.c | 22 ++++++++++++----------
 3 files changed, 24 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index d4d840729bda..b91b2594b29d 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -930,9 +930,16 @@ int ice_down(struct ice_vsi *vsi);
 int ice_down_up(struct ice_vsi *vsi);
 int ice_vsi_cfg_lan(struct ice_vsi *vsi);
 struct ice_vsi *ice_lb_vsi_setup(struct ice_pf *pf, struct ice_port_info *pi);
+
+enum ice_xdp_cfg {
+	ICE_XDP_CFG_FULL,	/* Fully apply new config in .ndo_bpf() */
+	ICE_XDP_CFG_PART,	/* Save/use part of config in VSI rebuild */
+};
+
 int ice_vsi_determine_xdp_res(struct ice_vsi *vsi);
-int ice_prepare_xdp_rings(struct ice_vsi *vsi, struct bpf_prog *prog);
-int ice_destroy_xdp_rings(struct ice_vsi *vsi);
+int ice_prepare_xdp_rings(struct ice_vsi *vsi, struct bpf_prog *prog,
+			  enum ice_xdp_cfg cfg_type);
+int ice_destroy_xdp_rings(struct ice_vsi *vsi, enum ice_xdp_cfg cfg_type);
 int
 ice_xdp_xmit(struct net_device *dev, int n, struct xdp_frame **frames,
 	     u32 flags);
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index c0a7ff6c7e87..dd8b374823ee 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -2285,7 +2285,8 @@ static int ice_vsi_cfg_def(struct ice_vsi *vsi)
 			ret = ice_vsi_determine_xdp_res(vsi);
 			if (ret)
 				goto unroll_vector_base;
-			ret = ice_prepare_xdp_rings(vsi, vsi->xdp_prog);
+			ret = ice_prepare_xdp_rings(vsi, vsi->xdp_prog,
+						    ICE_XDP_CFG_PART);
 			if (ret)
 				goto unroll_vector_base;
 		}
@@ -2429,7 +2430,7 @@ void ice_vsi_decfg(struct ice_vsi *vsi)
 		/* return value check can be skipped here, it always returns
 		 * 0 if reset is in progress
 		 */
-		ice_destroy_xdp_rings(vsi);
+		ice_destroy_xdp_rings(vsi, ICE_XDP_CFG_PART);
 
 	ice_vsi_clear_rings(vsi);
 	ice_vsi_free_q_vectors(vsi);
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index f60c022f7960..2a270aacd24a 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -2711,10 +2711,12 @@ static void ice_vsi_assign_bpf_prog(struct ice_vsi *vsi, struct bpf_prog *prog)
  * ice_prepare_xdp_rings - Allocate, configure and setup Tx rings for XDP
  * @vsi: VSI to bring up Tx rings used by XDP
  * @prog: bpf program that will be assigned to VSI
+ * @cfg_type: create from scratch or restore the existing configuration
  *
  * Return 0 on success and negative value on error
  */
-int ice_prepare_xdp_rings(struct ice_vsi *vsi, struct bpf_prog *prog)
+int ice_prepare_xdp_rings(struct ice_vsi *vsi, struct bpf_prog *prog,
+			  enum ice_xdp_cfg cfg_type)
 {
 	u16 max_txqs[ICE_MAX_TRAFFIC_CLASS] = { 0 };
 	int xdp_rings_rem = vsi->num_xdp_txq;
@@ -2790,7 +2792,7 @@ int ice_prepare_xdp_rings(struct ice_vsi *vsi, struct bpf_prog *prog)
 	 * taken into account at the end of ice_vsi_rebuild, where
 	 * ice_cfg_vsi_lan is being called
 	 */
-	if (ice_is_reset_in_progress(pf->state))
+	if (cfg_type == ICE_XDP_CFG_PART)
 		return 0;
 
 	/* tell the Tx scheduler that right now we have
@@ -2842,22 +2844,21 @@ int ice_prepare_xdp_rings(struct ice_vsi *vsi, struct bpf_prog *prog)
 /**
  * ice_destroy_xdp_rings - undo the configuration made by ice_prepare_xdp_rings
  * @vsi: VSI to remove XDP rings
+ * @cfg_type: disable XDP permanently or allow it to be restored later
  *
  * Detach XDP rings from irq vectors, clean up the PF bitmap and free
  * resources
  */
-int ice_destroy_xdp_rings(struct ice_vsi *vsi)
+int ice_destroy_xdp_rings(struct ice_vsi *vsi, enum ice_xdp_cfg cfg_type)
 {
 	u16 max_txqs[ICE_MAX_TRAFFIC_CLASS] = { 0 };
 	struct ice_pf *pf = vsi->back;
 	int i, v_idx;
 
 	/* q_vectors are freed in reset path so there's no point in detaching
-	 * rings; in case of rebuild being triggered not from reset bits
-	 * in pf->state won't be set, so additionally check first q_vector
-	 * against NULL
+	 * rings
 	 */
-	if (ice_is_reset_in_progress(pf->state) || !vsi->q_vectors[0])
+	if (cfg_type == ICE_XDP_CFG_PART)
 		goto free_qmap;
 
 	ice_for_each_q_vector(vsi, v_idx) {
@@ -2898,7 +2899,7 @@ int ice_destroy_xdp_rings(struct ice_vsi *vsi)
 	if (static_key_enabled(&ice_xdp_locking_key))
 		static_branch_dec(&ice_xdp_locking_key);
 
-	if (ice_is_reset_in_progress(pf->state) || !vsi->q_vectors[0])
+	if (cfg_type == ICE_XDP_CFG_PART)
 		return 0;
 
 	ice_vsi_assign_bpf_prog(vsi, NULL);
@@ -3009,7 +3010,8 @@ ice_xdp_setup_prog(struct ice_vsi *vsi, struct bpf_prog *prog,
 		if (xdp_ring_err) {
 			NL_SET_ERR_MSG_MOD(extack, "Not enough Tx resources for XDP");
 		} else {
-			xdp_ring_err = ice_prepare_xdp_rings(vsi, prog);
+			xdp_ring_err = ice_prepare_xdp_rings(vsi, prog,
+							     ICE_XDP_CFG_FULL);
 			if (xdp_ring_err)
 				NL_SET_ERR_MSG_MOD(extack, "Setting up XDP Tx resources failed");
 		}
@@ -3020,7 +3022,7 @@ ice_xdp_setup_prog(struct ice_vsi *vsi, struct bpf_prog *prog,
 			NL_SET_ERR_MSG_MOD(extack, "Setting up XDP Rx resources failed");
 	} else if (ice_is_xdp_ena_vsi(vsi) && !prog) {
 		xdp_features_clear_redirect_target(vsi->netdev);
-		xdp_ring_err = ice_destroy_xdp_rings(vsi);
+		xdp_ring_err = ice_destroy_xdp_rings(vsi, ICE_XDP_CFG_FULL);
 		if (xdp_ring_err)
 			NL_SET_ERR_MSG_MOD(extack, "Freeing XDP Tx resources failed");
 		/* reallocate Rx queues that were used for zero-copy */
-- 
2.43.0


