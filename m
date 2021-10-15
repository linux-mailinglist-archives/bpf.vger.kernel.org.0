Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9745142F834
	for <lists+bpf@lfdr.de>; Fri, 15 Oct 2021 18:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241375AbhJOQdz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 15 Oct 2021 12:33:55 -0400
Received: from mga12.intel.com ([192.55.52.136]:37918 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241374AbhJOQdu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 15 Oct 2021 12:33:50 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10138"; a="208059649"
X-IronPort-AV: E=Sophos;i="5.85,376,1624345200"; 
   d="scan'208";a="208059649"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2021 09:31:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,376,1624345200"; 
   d="scan'208";a="528205596"
Received: from anguy11-desk2.jf.intel.com ([10.166.244.147])
  by fmsmga008.fm.intel.com with ESMTP; 15 Oct 2021 09:31:09 -0700
From:   Tony Nguyen <anthony.l.nguyen@intel.com>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        netdev@vger.kernel.org, anthony.l.nguyen@intel.com,
        magnus.karlsson@intel.com, ast@kernel.org, daniel@iogearbox.net,
        hawk@kernel.org, john.fastabend@gmail.com, andrii@kernel.org,
        kpsingh@kernel.org, kafai@fb.com, yhs@fb.com,
        songliubraving@fb.com, bpf@vger.kernel.org,
        George Kuruvinakunnel <george.kuruvinakunnel@intel.com>
Subject: [PATCH net-next 8/9] ice: introduce XDP_TX fallback path
Date:   Fri, 15 Oct 2021 09:29:07 -0700
Message-Id: <20211015162908.145341-9-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211015162908.145341-1-anthony.l.nguyen@intel.com>
References: <20211015162908.145341-1-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

Under rare circumstances there might be a situation where a requirement
of having XDP Tx queue per CPU could not be fulfilled and some of the Tx
resources have to be shared between CPUs. This yields a need for placing
accesses to xdp_ring inside a critical section protected by spinlock.
These accesses happen to be in the hot path, so let's introduce the
static branch that will be triggered from the control plane when driver
could not provide Tx queue dedicated for XDP on each CPU.

Currently, the design that has been picked is to allow any number of XDP
Tx queues that is at least half of a count of CPUs that platform has.
For lower number driver will bail out with a response to user that there
were not enough Tx resources that would allow configuring XDP. The
sharing of rings is signalled via static branch enablement which in turn
indicates that lock for xdp_ring accesses needs to be taken in hot path.

Approach based on static branch has no impact on performance of a
non-fallback path. One thing that is needed to be mentioned is a fact
that the static branch will act as a global driver switch, meaning that
if one PF got out of Tx resources, then other PFs that ice driver is
servicing will suffer. However, given the fact that HW that ice driver
is handling has 1024 Tx queues per each PF, this is currently an
unlikely scenario.

Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Tested-by: George Kuruvinakunnel <george.kuruvinakunnel@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice.h          |  3 ++
 drivers/net/ethernet/intel/ice/ice_lib.c      |  4 +-
 drivers/net/ethernet/intel/ice/ice_main.c     | 53 ++++++++++++++++---
 drivers/net/ethernet/intel/ice/ice_txrx.c     | 16 +++++-
 drivers/net/ethernet/intel/ice/ice_txrx.h     |  1 +
 drivers/net/ethernet/intel/ice/ice_txrx_lib.c |  7 ++-
 6 files changed, 75 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index 35cf1865beb4..aeac6cd0e74f 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -167,6 +167,8 @@ enum ice_feature {
 	ICE_F_MAX
 };
 
+DECLARE_STATIC_KEY_FALSE(ice_xdp_locking_key);
+
 struct ice_txq_meta {
 	u32 q_teid;	/* Tx-scheduler element identifier */
 	u16 q_id;	/* Entry in VSI's txq_map bitmap */
@@ -716,6 +718,7 @@ int ice_up(struct ice_vsi *vsi);
 int ice_down(struct ice_vsi *vsi);
 int ice_vsi_cfg(struct ice_vsi *vsi);
 struct ice_vsi *ice_lb_vsi_setup(struct ice_pf *pf, struct ice_port_info *pi);
+int ice_vsi_determine_xdp_res(struct ice_vsi *vsi);
 int ice_prepare_xdp_rings(struct ice_vsi *vsi, struct bpf_prog *prog);
 int ice_destroy_xdp_rings(struct ice_vsi *vsi);
 int
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 58fad5f82076..e4dc4435c8f5 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -3215,7 +3215,9 @@ int ice_vsi_rebuild(struct ice_vsi *vsi, bool init_vsi)
 
 		ice_vsi_map_rings_to_vectors(vsi);
 		if (ice_is_xdp_ena_vsi(vsi)) {
-			vsi->num_xdp_txq = num_possible_cpus();
+			ret = ice_vsi_determine_xdp_res(vsi);
+			if (ret)
+				goto err_vectors;
 			ret = ice_prepare_xdp_rings(vsi, vsi->xdp_prog);
 			if (ret)
 				goto err_vectors;
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 214eebb7bbd8..ccd9b9514001 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -44,6 +44,8 @@ MODULE_PARM_DESC(debug, "netif level (0=none,...,16=all)");
 #endif /* !CONFIG_DYNAMIC_DEBUG */
 
 static DEFINE_IDA(ice_aux_ida);
+DEFINE_STATIC_KEY_FALSE(ice_xdp_locking_key);
+EXPORT_SYMBOL(ice_xdp_locking_key);
 
 static struct workqueue_struct *ice_wq;
 static const struct net_device_ops ice_netdev_safe_mode_ops;
@@ -2397,14 +2399,19 @@ static int ice_xdp_alloc_setup_rings(struct ice_vsi *vsi)
 			goto free_xdp_rings;
 		ice_set_ring_xdp(xdp_ring);
 		xdp_ring->xsk_pool = ice_tx_xsk_pool(xdp_ring);
+		spin_lock_init(&xdp_ring->tx_lock);
 		for (j = 0; j < xdp_ring->count; j++) {
 			tx_desc = ICE_TX_DESC(xdp_ring, j);
 			tx_desc->cmd_type_offset_bsz = cpu_to_le64(ICE_TX_DESC_DTYPE_DESC_DONE);
 		}
 	}
 
-	ice_for_each_rxq(vsi, i)
-		vsi->rx_rings[i]->xdp_ring = vsi->xdp_rings[i];
+	ice_for_each_rxq(vsi, i) {
+		if (static_key_enabled(&ice_xdp_locking_key))
+			vsi->rx_rings[i]->xdp_ring = vsi->xdp_rings[i % vsi->num_xdp_txq];
+		else
+			vsi->rx_rings[i]->xdp_ring = vsi->xdp_rings[i];
+	}
 
 	return 0;
 
@@ -2469,6 +2476,10 @@ int ice_prepare_xdp_rings(struct ice_vsi *vsi, struct bpf_prog *prog)
 	if (__ice_vsi_get_qs(&xdp_qs_cfg))
 		goto err_map_xdp;
 
+	if (static_key_enabled(&ice_xdp_locking_key))
+		netdev_warn(vsi->netdev,
+			    "Could not allocate one XDP Tx ring per CPU, XDP_TX/XDP_REDIRECT actions will be slower\n");
+
 	if (ice_xdp_alloc_setup_rings(vsi))
 		goto clear_xdp_rings;
 
@@ -2585,6 +2596,9 @@ int ice_destroy_xdp_rings(struct ice_vsi *vsi)
 	devm_kfree(ice_pf_to_dev(pf), vsi->xdp_rings);
 	vsi->xdp_rings = NULL;
 
+	if (static_key_enabled(&ice_xdp_locking_key))
+		static_branch_dec(&ice_xdp_locking_key);
+
 	if (ice_is_reset_in_progress(pf->state) || !vsi->q_vectors[0])
 		return 0;
 
@@ -2619,6 +2633,29 @@ static void ice_vsi_rx_napi_schedule(struct ice_vsi *vsi)
 	}
 }
 
+/**
+ * ice_vsi_determine_xdp_res - figure out how many Tx qs can XDP have
+ * @vsi: VSI to determine the count of XDP Tx qs
+ *
+ * returns 0 if Tx qs count is higher than at least half of CPU count,
+ * -ENOMEM otherwise
+ */
+int ice_vsi_determine_xdp_res(struct ice_vsi *vsi)
+{
+	u16 avail = ice_get_avail_txq_count(vsi->back);
+	u16 cpus = num_possible_cpus();
+
+	if (avail < cpus / 2)
+		return -ENOMEM;
+
+	vsi->num_xdp_txq = min_t(u16, avail, cpus);
+
+	if (vsi->num_xdp_txq < cpus)
+		static_branch_inc(&ice_xdp_locking_key);
+
+	return 0;
+}
+
 /**
  * ice_xdp_setup_prog - Add or remove XDP eBPF program
  * @vsi: VSI to setup XDP for
@@ -2648,10 +2685,14 @@ ice_xdp_setup_prog(struct ice_vsi *vsi, struct bpf_prog *prog,
 	}
 
 	if (!ice_is_xdp_ena_vsi(vsi) && prog) {
-		vsi->num_xdp_txq = num_possible_cpus();
-		xdp_ring_err = ice_prepare_xdp_rings(vsi, prog);
-		if (xdp_ring_err)
-			NL_SET_ERR_MSG_MOD(extack, "Setting up XDP Tx resources failed");
+		xdp_ring_err = ice_vsi_determine_xdp_res(vsi);
+		if (xdp_ring_err) {
+			NL_SET_ERR_MSG_MOD(extack, "Not enough Tx resources for XDP");
+		} else {
+			xdp_ring_err = ice_prepare_xdp_rings(vsi, prog);
+			if (xdp_ring_err)
+				NL_SET_ERR_MSG_MOD(extack, "Setting up XDP Tx resources failed");
+		}
 	} else if (ice_is_xdp_ena_vsi(vsi) && !prog) {
 		xdp_ring_err = ice_destroy_xdp_rings(vsi);
 		if (xdp_ring_err)
diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
index 927517e18ce3..01ae331927bd 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
@@ -547,7 +547,11 @@ ice_run_xdp(struct ice_rx_ring *rx_ring, struct xdp_buff *xdp,
 	case XDP_PASS:
 		return ICE_XDP_PASS;
 	case XDP_TX:
+		if (static_branch_unlikely(&ice_xdp_locking_key))
+			spin_lock(&xdp_ring->tx_lock);
 		err = ice_xmit_xdp_ring(xdp->data, xdp->data_end - xdp->data, xdp_ring);
+		if (static_branch_unlikely(&ice_xdp_locking_key))
+			spin_unlock(&xdp_ring->tx_lock);
 		if (err == ICE_XDP_CONSUMED)
 			goto out_failure;
 		return err;
@@ -599,7 +603,14 @@ ice_xdp_xmit(struct net_device *dev, int n, struct xdp_frame **frames,
 	if (unlikely(flags & ~XDP_XMIT_FLAGS_MASK))
 		return -EINVAL;
 
-	xdp_ring = vsi->xdp_rings[queue_index];
+	if (static_branch_unlikely(&ice_xdp_locking_key)) {
+		queue_index %= vsi->num_xdp_txq;
+		xdp_ring = vsi->xdp_rings[queue_index];
+		spin_lock(&xdp_ring->tx_lock);
+	} else {
+		xdp_ring = vsi->xdp_rings[queue_index];
+	}
+
 	for (i = 0; i < n; i++) {
 		struct xdp_frame *xdpf = frames[i];
 		int err;
@@ -613,6 +624,9 @@ ice_xdp_xmit(struct net_device *dev, int n, struct xdp_frame **frames,
 	if (unlikely(flags & XDP_XMIT_FLUSH))
 		ice_xdp_ring_update_tail(xdp_ring);
 
+	if (static_branch_unlikely(&ice_xdp_locking_key))
+		spin_unlock(&xdp_ring->tx_lock);
+
 	return nxmit;
 }
 
diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.h b/drivers/net/ethernet/intel/ice/ice_txrx.h
index 22de016adbca..c759a02bfce4 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.h
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.h
@@ -329,6 +329,7 @@ struct ice_tx_ring {
 	struct rcu_head rcu;		/* to avoid race on free */
 	DECLARE_BITMAP(xps_state, ICE_TX_NBITS);	/* XPS Config State */
 	struct ice_ptp_tx *tx_tstamps;
+	spinlock_t tx_lock;
 	u32 txq_teid;			/* Added Tx queue TEID */
 #define ICE_TX_FLAGS_RING_XDP		BIT(0)
 	u8 flags;
diff --git a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
index d55db9cedc9b..1dd7e84f41f8 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
@@ -350,6 +350,11 @@ void ice_finalize_xdp_rx(struct ice_tx_ring *xdp_ring, unsigned int xdp_res)
 	if (xdp_res & ICE_XDP_REDIR)
 		xdp_do_flush_map();
 
-	if (xdp_res & ICE_XDP_TX)
+	if (xdp_res & ICE_XDP_TX) {
+		if (static_branch_unlikely(&ice_xdp_locking_key))
+			spin_lock(&xdp_ring->tx_lock);
 		ice_xdp_ring_update_tail(xdp_ring);
+		if (static_branch_unlikely(&ice_xdp_locking_key))
+			spin_unlock(&xdp_ring->tx_lock);
+	}
 }
-- 
2.31.1

