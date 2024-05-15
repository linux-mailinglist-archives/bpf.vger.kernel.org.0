Return-Path: <bpf+bounces-29781-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D05018C6A40
	for <lists+bpf@lfdr.de>; Wed, 15 May 2024 18:10:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 659A21F233BD
	for <lists+bpf@lfdr.de>; Wed, 15 May 2024 16:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2F6A156F3F;
	Wed, 15 May 2024 16:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GT9jGeFl"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9015D156649;
	Wed, 15 May 2024 16:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715789373; cv=none; b=OfRXHxdHzX7fVlgLzKfJk36s5UoVUB//3PvBuKRB7KtthG6+hAywsZ/jbOzkAC3rZVTWUBo0Aji//jXl27XXE2WGlx75Cxt2Hhdu4LScHjnlZXBAeRlXbLBgaMP/EBhn8vk5ombI0yRWhrGkMN7Y3gkfRU50VQkv592kEGZGO74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715789373; c=relaxed/simple;
	bh=6Gxh05ckxxnfeE930PbMRic5ZCzGMuBXl35TtGgHFPU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XsZ7Qya2l0M5BwlGBHO+vt0CY1ymus8GUvJI2tRzI0Le8f1BNEy7+Qo0U01LqjGWad6BCwi2We3atsPfp0BSIG+1szz1LybDjHEuIjwyk11MkEdhO21mciMorJczIqkcolL91qA8MdCWaRso4NSlWGruNhg/50k5JU89dWjjBXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GT9jGeFl; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715789371; x=1747325371;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6Gxh05ckxxnfeE930PbMRic5ZCzGMuBXl35TtGgHFPU=;
  b=GT9jGeFlsHfyu4R7mlPZCYrqWJwghYA5vCZzKz45kham0CXI1s8PzV12
   XpAsgreOlx4ba6shHMx+i6PXm87zjqdEpd+rteB7C92wK66vgVmDaal86
   blcMff5OCHvupHG1PQJhBViyg/whP3iYLQV6UWeHrCfLeObZDoXXuVCv4
   nbo/ujlfJN6SaqBhoc0MXxbw8nS1Pn2r2rfjT7tEFV9AlM7DFspvizfWL
   fdQdawL/AxFeMDUgi3X7CRpt9z6UwZQAHQv91uRvwcQA6ArcTYHdNDGu5
   OSl4+e9Uk5og/54Ti/n0Os0rIEnGhd9wA69XZ/mEpVGvoeXokx2Fo6ly0
   Q==;
X-CSE-ConnectionGUID: OB2Y2BhLT0GMjarG/VrOcw==
X-CSE-MsgGUID: sQKhu2lKSlCzF2+6ieMh8g==
X-IronPort-AV: E=McAfee;i="6600,9927,11074"; a="11666431"
X-IronPort-AV: E=Sophos;i="6.08,162,1712646000"; 
   d="scan'208";a="11666431"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2024 09:09:29 -0700
X-CSE-ConnectionGUID: bSWvqI+dTiKMut9rTiuTkQ==
X-CSE-MsgGUID: e4Dcc9b9QvKflhi2hAP4VQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,162,1712646000"; 
   d="scan'208";a="62297407"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa001.fm.intel.com with ESMTP; 15 May 2024 09:09:23 -0700
Received: from lincoln.igk.intel.com (lincoln.igk.intel.com [10.102.21.235])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 379272878C;
	Wed, 15 May 2024 17:09:21 +0100 (IST)
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
Subject: [PATCH iwl-net 3/3] ice: map XDP queues to vectors in ice_vsi_map_rings_to_vectors()
Date: Wed, 15 May 2024 18:02:16 +0200
Message-ID: <20240515160246.5181-4-larysa.zaremba@intel.com>
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

ice_pf_dcb_recfg() re-maps queues to vectors with
ice_vsi_map_rings_to_vectors(), which does not restore the previous
state for XDP queues. This leads to no AF_XDP traffic after rebuild.

Map XDP queues to vectors in ice_vsi_map_rings_to_vectors().
Also, move the code around, so XDP queues are mapped independently only
through .ndo_bpf().

Fixes: 6624e780a577 ("ice: split ice_vsi_setup into smaller functions")
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
---
 drivers/net/ethernet/intel/ice/ice.h      |  1 +
 drivers/net/ethernet/intel/ice/ice_base.c |  3 +
 drivers/net/ethernet/intel/ice/ice_lib.c  | 14 ++--
 drivers/net/ethernet/intel/ice/ice_main.c | 96 ++++++++++++++---------
 4 files changed, 68 insertions(+), 46 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index b91b2594b29d..da8c8afebc93 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -940,6 +940,7 @@ int ice_vsi_determine_xdp_res(struct ice_vsi *vsi);
 int ice_prepare_xdp_rings(struct ice_vsi *vsi, struct bpf_prog *prog,
 			  enum ice_xdp_cfg cfg_type);
 int ice_destroy_xdp_rings(struct ice_vsi *vsi, enum ice_xdp_cfg cfg_type);
+void ice_map_xdp_rings(struct ice_vsi *vsi);
 int
 ice_xdp_xmit(struct net_device *dev, int n, struct xdp_frame **frames,
 	     u32 flags);
diff --git a/drivers/net/ethernet/intel/ice/ice_base.c b/drivers/net/ethernet/intel/ice/ice_base.c
index 687f6cb2b917..5d396c1a7731 100644
--- a/drivers/net/ethernet/intel/ice/ice_base.c
+++ b/drivers/net/ethernet/intel/ice/ice_base.c
@@ -842,6 +842,9 @@ void ice_vsi_map_rings_to_vectors(struct ice_vsi *vsi)
 		}
 		rx_rings_rem -= rx_rings_per_v;
 	}
+
+	if (ice_is_xdp_ena_vsi(vsi))
+		ice_map_xdp_rings(vsi);
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index dd8b374823ee..7629b0190578 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -2274,13 +2274,6 @@ static int ice_vsi_cfg_def(struct ice_vsi *vsi)
 		if (ret)
 			goto unroll_vector_base;
 
-		ice_vsi_map_rings_to_vectors(vsi);
-
-		/* Associate q_vector rings to napi */
-		ice_vsi_set_napi_queues(vsi);
-
-		vsi->stat_offsets_loaded = false;
-
 		if (ice_is_xdp_ena_vsi(vsi)) {
 			ret = ice_vsi_determine_xdp_res(vsi);
 			if (ret)
@@ -2291,6 +2284,13 @@ static int ice_vsi_cfg_def(struct ice_vsi *vsi)
 				goto unroll_vector_base;
 		}
 
+		ice_vsi_map_rings_to_vectors(vsi);
+
+		/* Associate q_vector rings to napi */
+		ice_vsi_set_napi_queues(vsi);
+
+		vsi->stat_offsets_loaded = false;
+
 		/* ICE_VSI_CTRL does not need RSS so skip RSS processing */
 		if (vsi->type != ICE_VSI_CTRL)
 			/* Do not exit if configuring RSS had an issue, at
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 2a270aacd24a..1b61ca3a6eb6 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -2707,6 +2707,60 @@ static void ice_vsi_assign_bpf_prog(struct ice_vsi *vsi, struct bpf_prog *prog)
 		bpf_prog_put(old_prog);
 }
 
+static struct ice_tx_ring *ice_xdp_ring_from_qid(struct ice_vsi *vsi, int qid)
+{
+	struct ice_q_vector *q_vector;
+	struct ice_tx_ring *ring;
+
+	if (static_key_enabled(&ice_xdp_locking_key))
+		return vsi->xdp_rings[qid % vsi->num_xdp_txq];
+
+	q_vector = vsi->rx_rings[qid]->q_vector;
+	ice_for_each_tx_ring(ring, q_vector->tx)
+		if (ice_ring_is_xdp(ring))
+			return ring;
+
+	return NULL;
+}
+
+/**
+ * ice_map_xdp_rings - Map XDP rings to interrupt vectors
+ * @vsi: the VSI with XDP rings being configured
+ *
+ * Map XDP rings to interrupt vectors and perform the configuration steps
+ * dependent on the mapping.
+ */
+void ice_map_xdp_rings(struct ice_vsi *vsi)
+{
+	int xdp_rings_rem = vsi->num_xdp_txq;
+	int v_idx, q_idx;
+
+	/* follow the logic from ice_vsi_map_rings_to_vectors */
+	ice_for_each_q_vector(vsi, v_idx) {
+		struct ice_q_vector *q_vector = vsi->q_vectors[v_idx];
+		int xdp_rings_per_v, q_id, q_base;
+
+		xdp_rings_per_v = DIV_ROUND_UP(xdp_rings_rem,
+					       vsi->num_q_vectors - v_idx);
+		q_base = vsi->num_xdp_txq - xdp_rings_rem;
+
+		for (q_id = q_base; q_id < (q_base + xdp_rings_per_v); q_id++) {
+			struct ice_tx_ring *xdp_ring = vsi->xdp_rings[q_id];
+
+			xdp_ring->q_vector = q_vector;
+			xdp_ring->next = q_vector->tx.tx_ring;
+			q_vector->tx.tx_ring = xdp_ring;
+		}
+		xdp_rings_rem -= xdp_rings_per_v;
+	}
+
+	ice_for_each_rxq(vsi, q_idx) {
+		vsi->rx_rings[q_idx]->xdp_ring = ice_xdp_ring_from_qid(vsi,
+								       q_idx);
+		ice_tx_xsk_pool(vsi, q_idx);
+	}
+}
+
 /**
  * ice_prepare_xdp_rings - Allocate, configure and setup Tx rings for XDP
  * @vsi: VSI to bring up Tx rings used by XDP
@@ -2719,7 +2773,6 @@ int ice_prepare_xdp_rings(struct ice_vsi *vsi, struct bpf_prog *prog,
 			  enum ice_xdp_cfg cfg_type)
 {
 	u16 max_txqs[ICE_MAX_TRAFFIC_CLASS] = { 0 };
-	int xdp_rings_rem = vsi->num_xdp_txq;
 	struct ice_pf *pf = vsi->back;
 	struct ice_qs_cfg xdp_qs_cfg = {
 		.qs_mutex = &pf->avail_q_mutex,
@@ -2732,8 +2785,7 @@ int ice_prepare_xdp_rings(struct ice_vsi *vsi, struct bpf_prog *prog,
 		.mapping_mode = ICE_VSI_MAP_CONTIG
 	};
 	struct device *dev;
-	int i, v_idx;
-	int status;
+	int status, i;
 
 	dev = ice_pf_to_dev(pf);
 	vsi->xdp_rings = devm_kcalloc(dev, vsi->num_xdp_txq,
@@ -2752,42 +2804,6 @@ int ice_prepare_xdp_rings(struct ice_vsi *vsi, struct bpf_prog *prog,
 	if (ice_xdp_alloc_setup_rings(vsi))
 		goto clear_xdp_rings;
 
-	/* follow the logic from ice_vsi_map_rings_to_vectors */
-	ice_for_each_q_vector(vsi, v_idx) {
-		struct ice_q_vector *q_vector = vsi->q_vectors[v_idx];
-		int xdp_rings_per_v, q_id, q_base;
-
-		xdp_rings_per_v = DIV_ROUND_UP(xdp_rings_rem,
-					       vsi->num_q_vectors - v_idx);
-		q_base = vsi->num_xdp_txq - xdp_rings_rem;
-
-		for (q_id = q_base; q_id < (q_base + xdp_rings_per_v); q_id++) {
-			struct ice_tx_ring *xdp_ring = vsi->xdp_rings[q_id];
-
-			xdp_ring->q_vector = q_vector;
-			xdp_ring->next = q_vector->tx.tx_ring;
-			q_vector->tx.tx_ring = xdp_ring;
-		}
-		xdp_rings_rem -= xdp_rings_per_v;
-	}
-
-	ice_for_each_rxq(vsi, i) {
-		if (static_key_enabled(&ice_xdp_locking_key)) {
-			vsi->rx_rings[i]->xdp_ring = vsi->xdp_rings[i % vsi->num_xdp_txq];
-		} else {
-			struct ice_q_vector *q_vector = vsi->rx_rings[i]->q_vector;
-			struct ice_tx_ring *ring;
-
-			ice_for_each_tx_ring(ring, q_vector->tx) {
-				if (ice_ring_is_xdp(ring)) {
-					vsi->rx_rings[i]->xdp_ring = ring;
-					break;
-				}
-			}
-		}
-		ice_tx_xsk_pool(vsi, i);
-	}
-
 	/* omit the scheduler update if in reset path; XDP queues will be
 	 * taken into account at the end of ice_vsi_rebuild, where
 	 * ice_cfg_vsi_lan is being called
@@ -2795,6 +2811,8 @@ int ice_prepare_xdp_rings(struct ice_vsi *vsi, struct bpf_prog *prog,
 	if (cfg_type == ICE_XDP_CFG_PART)
 		return 0;
 
+	ice_map_xdp_rings(vsi);
+
 	/* tell the Tx scheduler that right now we have
 	 * additional queues
 	 */
-- 
2.43.0


