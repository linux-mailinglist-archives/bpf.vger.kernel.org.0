Return-Path: <bpf+bounces-37491-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 45705956800
	for <lists+bpf@lfdr.de>; Mon, 19 Aug 2024 12:15:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98061B20CC9
	for <lists+bpf@lfdr.de>; Mon, 19 Aug 2024 10:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F01B1662FD;
	Mon, 19 Aug 2024 10:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fk8QuzAQ"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEAAB165EEF;
	Mon, 19 Aug 2024 10:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724062486; cv=none; b=nEGnvWVFYTGZoGy+kvqDBx6HQBvl/jMjXmoG5lq9l150O7CMlciaRjEB8XJeqk13aXdRGzZaAdCz6fjjojyD0Xv8Zz4qD+bgOO70zz9WGqD9q81kermyIQDndNU4f3m5N7xHBAmNwUV1ZMa5lRF1xpgP7uy4mY/cxAJFj3gCxns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724062486; c=relaxed/simple;
	bh=JMG2mcqbsOqtjjbEBCKkQlzzZIGNjiZzxwJ7aizjUHo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A3Mzf6iwjbzzp8a8hav3NVYcN3foAdTFQQJ2kIUj9K9p9eNvo9fSUo2G765PtSJiCIdK58E1COCTxC+EF3OHdbcT4q97ttgXKga6UBtQrDgr0QYpRwGYvYNg4SXubOYCKQbhi/+k1PhelPB/Wp/kTNgsYFJ6Lhd/BgOsuodLQrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Fk8QuzAQ; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724062484; x=1755598484;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JMG2mcqbsOqtjjbEBCKkQlzzZIGNjiZzxwJ7aizjUHo=;
  b=Fk8QuzAQmfCu9iohAb/IUFKeNOldkslsy+R5stVJUiK9Fx6vbVyrMqS7
   WPKDrKb9cepSqkDv+TSrvx9aamu3gBDJ18Lt0wFt7xBrPTyNCHid7LOXz
   yani8rrvNWrLQyoz0JKzq9EJMxVSGBjCOdXOoom+FPbVRJA5UbXiw3Za5
   A++prZCDL2kUgRBHgAxHJn6+9OgReZbi9njBXPm36nCcp5Kh0hS6BlZOB
   hBBkGl0fkfdeC7zh88AFKLWluL3ikVS6v8juRWywYO7j8rcto9ImwBGXT
   ovp4qMcYw6fNWqFH8YBLKU8zBIPjhKUKDaApms6Ls/gmxM7YmnpXCeClT
   A==;
X-CSE-ConnectionGUID: w//IHL20RA6kvkiajAX1Qg==
X-CSE-MsgGUID: YTpQRBTrTA6bAKv2sB8EgQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11168"; a="13090150"
X-IronPort-AV: E=Sophos;i="6.10,158,1719903600"; 
   d="scan'208";a="13090150"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 03:14:38 -0700
X-CSE-ConnectionGUID: zDiztZLcSKi+brDdcMiU+w==
X-CSE-MsgGUID: hi5tgMOMRRKxt5p0deeR1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,158,1719903600"; 
   d="scan'208";a="91097091"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa001.fm.intel.com with ESMTP; 19 Aug 2024 03:14:33 -0700
Received: from lincoln.igk.intel.com (lincoln.igk.intel.com [10.102.21.235])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 4DBE628188;
	Mon, 19 Aug 2024 11:14:31 +0100 (IST)
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: Larysa Zaremba <larysa.zaremba@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jacob Keller <jacob.e.keller@intel.com>,
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
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Amritha Nambiar <amritha.nambiar@intel.com>,
	Chandan Kumar Rout <chandanx.rout@intel.com>
Subject: [PATCH iwl-net v3 2/6] ice: protect XDP configuration with a mutex
Date: Mon, 19 Aug 2024 12:05:39 +0200
Message-ID: <20240819100606.15383-3-larysa.zaremba@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240819100606.15383-1-larysa.zaremba@intel.com>
References: <20240819100606.15383-1-larysa.zaremba@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The main threat to data consistency in ice_xdp() is a possible asynchronous
PF reset. It can be triggered by a user or by TX timeout handler.

XDP setup and PF reset code access the same resources in the following
sections:
* ice_vsi_close() in ice_prepare_for_reset() - already rtnl-locked
* ice_vsi_rebuild() for the PF VSI - not protected
* ice_vsi_open() - already rtnl-locked

With an unfortunate timing, such accesses can result in a crash such as the
one below:

[ +1.999878] ice 0000:b1:00.0: Registered XDP mem model MEM_TYPE_XSK_BUFF_POOL on Rx ring 14
[ +2.002992] ice 0000:b1:00.0: Registered XDP mem model MEM_TYPE_XSK_BUFF_POOL on Rx ring 18
[Mar15 18:17] ice 0000:b1:00.0 ens801f0np0: NETDEV WATCHDOG: CPU: 38: transmit queue 14 timed out 80692736 ms
[ +0.000093] ice 0000:b1:00.0 ens801f0np0: tx_timeout: VSI_num: 6, Q 14, NTC: 0x0, HW_HEAD: 0x0, NTU: 0x0, INT: 0x4000001
[ +0.000012] ice 0000:b1:00.0 ens801f0np0: tx_timeout recovery level 1, txqueue 14
[ +0.394718] ice 0000:b1:00.0: PTP reset successful
[ +0.006184] BUG: kernel NULL pointer dereference, address: 0000000000000098
[ +0.000045] #PF: supervisor read access in kernel mode
[ +0.000023] #PF: error_code(0x0000) - not-present page
[ +0.000023] PGD 0 P4D 0
[ +0.000018] Oops: 0000 [#1] PREEMPT SMP NOPTI
[ +0.000023] CPU: 38 PID: 7540 Comm: kworker/38:1 Not tainted 6.8.0-rc7 #1
[ +0.000031] Hardware name: Intel Corporation S2600WFT/S2600WFT, BIOS SE5C620.86B.02.01.0014.082620210524 08/26/2021
[ +0.000036] Workqueue: ice ice_service_task [ice]
[ +0.000183] RIP: 0010:ice_clean_tx_ring+0xa/0xd0 [ice]
[...]
[ +0.000013] Call Trace:
[ +0.000016] <TASK>
[ +0.000014] ? __die+0x1f/0x70
[ +0.000029] ? page_fault_oops+0x171/0x4f0
[ +0.000029] ? schedule+0x3b/0xd0
[ +0.000027] ? exc_page_fault+0x7b/0x180
[ +0.000022] ? asm_exc_page_fault+0x22/0x30
[ +0.000031] ? ice_clean_tx_ring+0xa/0xd0 [ice]
[ +0.000194] ice_free_tx_ring+0xe/0x60 [ice]
[ +0.000186] ice_destroy_xdp_rings+0x157/0x310 [ice]
[ +0.000151] ice_vsi_decfg+0x53/0xe0 [ice]
[ +0.000180] ice_vsi_rebuild+0x239/0x540 [ice]
[ +0.000186] ice_vsi_rebuild_by_type+0x76/0x180 [ice]
[ +0.000145] ice_rebuild+0x18c/0x840 [ice]
[ +0.000145] ? delay_tsc+0x4a/0xc0
[ +0.000022] ? delay_tsc+0x92/0xc0
[ +0.000020] ice_do_reset+0x140/0x180 [ice]
[ +0.000886] ice_service_task+0x404/0x1030 [ice]
[ +0.000824] process_one_work+0x171/0x340
[ +0.000685] worker_thread+0x277/0x3a0
[ +0.000675] ? preempt_count_add+0x6a/0xa0
[ +0.000677] ? _raw_spin_lock_irqsave+0x23/0x50
[ +0.000679] ? __pfx_worker_thread+0x10/0x10
[ +0.000653] kthread+0xf0/0x120
[ +0.000635] ? __pfx_kthread+0x10/0x10
[ +0.000616] ret_from_fork+0x2d/0x50
[ +0.000612] ? __pfx_kthread+0x10/0x10
[ +0.000604] ret_from_fork_asm+0x1b/0x30
[ +0.000604] </TASK>

The previous way of handling this through returning -EBUSY is not viable,
particularly when destroying AF_XDP socket, because the kernel proceeds
with removal anyway.

There is plenty of code between those calls and there is no need to create
a large critical section that covers all of them, same as there is no need
to protect ice_vsi_rebuild() with rtnl_lock().

Add xdp_state_lock mutex to protect ice_vsi_rebuild() and ice_xdp().

Leaving unprotected sections in between would result in two states that
have to be considered:
1. when the VSI is closed, but not yet rebuild
2. when VSI is already rebuild, but not yet open

The latter case is actually already handled through !netif_running() case,
we just need to adjust flag checking a little. The former one is not as
trivial, because between ice_vsi_close() and ice_vsi_rebuild(), a lot of
hardware interaction happens, this can make adding/deleting rings exit
with an error. Luckily, VSI rebuild is pending and can apply new
configuration for us in a managed fashion.

Therefore, add an additional VSI state flag ICE_VSI_REBUILD_PENDING to
indicate that ice_xdp() can just hot-swap the program.

Also, as ice_vsi_rebuild() flow is touched in this patch, make it more
consistent by deconfiguring VSI when coalesce allocation fails.

Fixes: 2d4238f55697 ("ice: Add support for AF_XDP")
Fixes: efc2214b6047 ("ice: Add support for XDP")
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Tested-by: Chandan Kumar Rout <chandanx.rout@intel.com>
Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
---
 drivers/net/ethernet/intel/ice/ice.h      |  2 ++
 drivers/net/ethernet/intel/ice/ice_lib.c  | 34 ++++++++++++++---------
 drivers/net/ethernet/intel/ice/ice_main.c | 19 +++++++++----
 drivers/net/ethernet/intel/ice/ice_xsk.c  |  3 +-
 4 files changed, 39 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index caaa10157909..ce8b5505b16d 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -318,6 +318,7 @@ enum ice_vsi_state {
 	ICE_VSI_UMAC_FLTR_CHANGED,
 	ICE_VSI_MMAC_FLTR_CHANGED,
 	ICE_VSI_PROMISC_CHANGED,
+	ICE_VSI_REBUILD_PENDING,
 	ICE_VSI_STATE_NBITS		/* must be last */
 };
 
@@ -411,6 +412,7 @@ struct ice_vsi {
 	struct ice_tx_ring **xdp_rings;	 /* XDP ring array */
 	u16 num_xdp_txq;		 /* Used XDP queues */
 	u8 xdp_mapping_mode;		 /* ICE_MAP_MODE_[CONTIG|SCATTER] */
+	struct mutex xdp_state_lock;
 
 	struct net_device **target_netdevs;
 
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 5f2ddcaf7031..a8721ecdf2cd 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -447,6 +447,7 @@ static void ice_vsi_free(struct ice_vsi *vsi)
 
 	ice_vsi_free_stats(vsi);
 	ice_vsi_free_arrays(vsi);
+	mutex_destroy(&vsi->xdp_state_lock);
 	mutex_unlock(&pf->sw_mutex);
 	devm_kfree(dev, vsi);
 }
@@ -626,6 +627,8 @@ static struct ice_vsi *ice_vsi_alloc(struct ice_pf *pf)
 	pf->next_vsi = ice_get_free_slot(pf->vsi, pf->num_alloc_vsi,
 					 pf->next_vsi);
 
+	mutex_init(&vsi->xdp_state_lock);
+
 unlock_pf:
 	mutex_unlock(&pf->sw_mutex);
 	return vsi;
@@ -2973,19 +2976,24 @@ int ice_vsi_rebuild(struct ice_vsi *vsi, u32 vsi_flags)
 	if (WARN_ON(vsi->type == ICE_VSI_VF && !vsi->vf))
 		return -EINVAL;
 
+	mutex_lock(&vsi->xdp_state_lock);
+	clear_bit(ICE_VSI_REBUILD_PENDING, vsi->state);
+
 	ret = ice_vsi_realloc_stat_arrays(vsi);
 	if (ret)
-		goto err_vsi_cfg;
+		goto unlock;
 
 	ice_vsi_decfg(vsi);
 	ret = ice_vsi_cfg_def(vsi);
 	if (ret)
-		goto err_vsi_cfg;
+		goto unlock;
 
 	coalesce = kcalloc(vsi->num_q_vectors,
 			   sizeof(struct ice_coalesce_stored), GFP_KERNEL);
-	if (!coalesce)
-		return -ENOMEM;
+	if (!coalesce) {
+		ret = -ENOMEM;
+		goto decfg;
+	}
 
 	prev_num_q_vectors = ice_vsi_rebuild_get_coalesce(vsi, coalesce);
 
@@ -2993,22 +3001,22 @@ int ice_vsi_rebuild(struct ice_vsi *vsi, u32 vsi_flags)
 	if (ret) {
 		if (vsi_flags & ICE_VSI_FLAG_INIT) {
 			ret = -EIO;
-			goto err_vsi_cfg_tc_lan;
+			goto free_coalesce;
 		}
 
-		kfree(coalesce);
-		return ice_schedule_reset(pf, ICE_RESET_PFR);
+		ret = ice_schedule_reset(pf, ICE_RESET_PFR);
+		goto free_coalesce;
 	}
 
 	ice_vsi_rebuild_set_coalesce(vsi, coalesce, prev_num_q_vectors);
-	kfree(coalesce);
 
-	return 0;
-
-err_vsi_cfg_tc_lan:
-	ice_vsi_decfg(vsi);
+free_coalesce:
 	kfree(coalesce);
-err_vsi_cfg:
+decfg:
+	if (ret)
+		ice_vsi_decfg(vsi);
+unlock:
+	mutex_unlock(&vsi->xdp_state_lock);
 	return ret;
 }
 
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 2d286a4609a5..e92f43850671 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -595,6 +595,7 @@ ice_prepare_for_reset(struct ice_pf *pf, enum ice_reset_req reset_type)
 	/* clear SW filtering DB */
 	ice_clear_hw_tbls(hw);
 	/* disable the VSIs and their queues that are not already DOWN */
+	set_bit(ICE_VSI_REBUILD_PENDING, ice_get_main_vsi(pf)->state);
 	ice_pf_dis_all_vsi(pf, false);
 
 	if (test_bit(ICE_FLAG_PTP_SUPPORTED, pf->flags))
@@ -2995,7 +2996,8 @@ ice_xdp_setup_prog(struct ice_vsi *vsi, struct bpf_prog *prog,
 	}
 
 	/* hot swap progs and avoid toggling link */
-	if (ice_is_xdp_ena_vsi(vsi) == !!prog) {
+	if (ice_is_xdp_ena_vsi(vsi) == !!prog ||
+	    test_bit(ICE_VSI_REBUILD_PENDING, vsi->state)) {
 		ice_vsi_assign_bpf_prog(vsi, prog);
 		return 0;
 	}
@@ -3067,21 +3069,28 @@ static int ice_xdp(struct net_device *dev, struct netdev_bpf *xdp)
 {
 	struct ice_netdev_priv *np = netdev_priv(dev);
 	struct ice_vsi *vsi = np->vsi;
+	int ret;
 
 	if (vsi->type != ICE_VSI_PF) {
 		NL_SET_ERR_MSG_MOD(xdp->extack, "XDP can be loaded only on PF VSI");
 		return -EINVAL;
 	}
 
+	mutex_lock(&vsi->xdp_state_lock);
+
 	switch (xdp->command) {
 	case XDP_SETUP_PROG:
-		return ice_xdp_setup_prog(vsi, xdp->prog, xdp->extack);
+		ret = ice_xdp_setup_prog(vsi, xdp->prog, xdp->extack);
+		break;
 	case XDP_SETUP_XSK_POOL:
-		return ice_xsk_pool_setup(vsi, xdp->xsk.pool,
-					  xdp->xsk.queue_id);
+		ret = ice_xsk_pool_setup(vsi, xdp->xsk.pool, xdp->xsk.queue_id);
+		break;
 	default:
-		return -EINVAL;
+		ret = -EINVAL;
 	}
+
+	mutex_unlock(&vsi->xdp_state_lock);
+	return ret;
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/ice/ice_xsk.c b/drivers/net/ethernet/intel/ice/ice_xsk.c
index 240a7bec242b..a659951fa987 100644
--- a/drivers/net/ethernet/intel/ice/ice_xsk.c
+++ b/drivers/net/ethernet/intel/ice/ice_xsk.c
@@ -390,7 +390,8 @@ int ice_xsk_pool_setup(struct ice_vsi *vsi, struct xsk_buff_pool *pool, u16 qid)
 		goto failure;
 	}
 
-	if_running = netif_running(vsi->netdev) && ice_is_xdp_ena_vsi(vsi);
+	if_running = !test_bit(ICE_VSI_DOWN, vsi->state) &&
+		     ice_is_xdp_ena_vsi(vsi);
 
 	if (if_running) {
 		struct ice_rx_ring *rx_ring = vsi->rx_rings[qid];
-- 
2.43.0


