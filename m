Return-Path: <bpf+bounces-38817-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D543396A687
	for <lists+bpf@lfdr.de>; Tue,  3 Sep 2024 20:31:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E12D2859CE
	for <lists+bpf@lfdr.de>; Tue,  3 Sep 2024 18:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3C3B1922DA;
	Tue,  3 Sep 2024 18:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZSzobNLO"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A8318BC22;
	Tue,  3 Sep 2024 18:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725388253; cv=none; b=prLQHd+nwF2VPtGnfMVIupCFth57jWoNWw7cjp9PUs77TnLDG3qy1lrs3OBhOOCHBhkdp92n1oDdkBnMTMKavc578gQNP4VKurB1wy9qCauCM4DSZMqiuRl6O+8Zj5DmVqP/oXViEJbr9d6ZQzMcVS/I3IPHSsrZNMVkxoEa5xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725388253; c=relaxed/simple;
	bh=cnQBfTWNFQ26ykKYB3U0wkOFGtCWe2yyomMc67rHuoQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GPBhMpxm9ZJXzGokoSd6LyD75KOiQPZ2jGqtfmnw7wb+jSzEBf73cNtyaolVvQqH402/iY3qbOEwrxc01nicMlE4J5iWgd6P2HhYEBAD0D5+2BsUgbqjCO++IxYl3hQXMFfssujfWdD1hTd9sHcmPRImEeDoqWUxhnoxWig/ePU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZSzobNLO; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725388251; x=1756924251;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cnQBfTWNFQ26ykKYB3U0wkOFGtCWe2yyomMc67rHuoQ=;
  b=ZSzobNLOprj9+439a5mtduI3jCoBm2Wzv6Wb+TxctJIoWecvehxLMCHK
   znJvk28uUr2BecYZRP6xVa9gnLCBQp0Mz378VoZiefiXJA3lv+aYZOV5f
   PcAW3XEMPAIqBFz+qY5JZfTwkdw3Em+wDwGG0sDCzdYWTytN9Mt64GAdR
   LwXxTLSAkntmgi3psRl//6O0yreN//mvcdzdcScCmAfd/zzcc4NLwYcox
   QFgfl9cUugxGu+Yyd6FZGUGykLef1mmCHFVX2ObU3d+fQg/0NZknUH+e3
   acIDNoUopWnx/99K1Eyui9GEN3NkFyeMJB2GVAycFJ25JP2XX0h4cxwUx
   g==;
X-CSE-ConnectionGUID: kLuZ9Pi+SF6N9iYYcxdQWg==
X-CSE-MsgGUID: iZ3JJKiVRC6fNoP4dheOTw==
X-IronPort-AV: E=McAfee;i="6700,10204,11184"; a="24146991"
X-IronPort-AV: E=Sophos;i="6.10,199,1719903600"; 
   d="scan'208";a="24146991"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2024 11:30:49 -0700
X-CSE-ConnectionGUID: jSAE1ghZTOyXWyQjfPmKgQ==
X-CSE-MsgGUID: h5QsuTqvRF6qHd992K+Kaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,199,1719903600"; 
   d="scan'208";a="88250215"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa002.fm.intel.com with ESMTP; 03 Sep 2024 11:30:48 -0700
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
	kees@kernel.org,
	gustavoars@kernel.org,
	linux-hardening@vger.kernel.org,
	George Kuruvinakunnel <george.kuruvinakunnel@intel.com>
Subject: [PATCH net 1/6] ice: move netif_queue_set_napi to rtnl-protected sections
Date: Tue,  3 Sep 2024 11:30:27 -0700
Message-ID: <20240903183034.3530411-2-anthony.l.nguyen@intel.com>
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

Currently, netif_queue_set_napi() is called from ice_vsi_rebuild() that is
not rtnl-locked when called from the reset. This creates the need to take
the rtnl_lock just for a single function and complicates the
synchronization with .ndo_bpf. At the same time, there no actual need to
fill napi-to-queue information at this exact point.

Fill napi-to-queue information when opening the VSI and clear it when the
VSI is being closed. Those routines are already rtnl-locked.

Also, rewrite napi-to-queue assignment in a way that prevents inclusion of
XDP queues, as this leads to out-of-bounds writes, such as one below.

[  +0.000004] BUG: KASAN: slab-out-of-bounds in netif_queue_set_napi+0x1c2/0x1e0
[  +0.000012] Write of size 8 at addr ffff889881727c80 by task bash/7047
[  +0.000006] CPU: 24 PID: 7047 Comm: bash Not tainted 6.10.0-rc2+ #2
[  +0.000004] Hardware name: Intel Corporation S2600WFT/S2600WFT, BIOS SE5C620.86B.02.01.0014.082620210524 08/26/2021
[  +0.000003] Call Trace:
[  +0.000003]  <TASK>
[  +0.000002]  dump_stack_lvl+0x60/0x80
[  +0.000007]  print_report+0xce/0x630
[  +0.000007]  ? __pfx__raw_spin_lock_irqsave+0x10/0x10
[  +0.000007]  ? __virt_addr_valid+0x1c9/0x2c0
[  +0.000005]  ? netif_queue_set_napi+0x1c2/0x1e0
[  +0.000003]  kasan_report+0xe9/0x120
[  +0.000004]  ? netif_queue_set_napi+0x1c2/0x1e0
[  +0.000004]  netif_queue_set_napi+0x1c2/0x1e0
[  +0.000005]  ice_vsi_close+0x161/0x670 [ice]
[  +0.000114]  ice_dis_vsi+0x22f/0x270 [ice]
[  +0.000095]  ice_pf_dis_all_vsi.constprop.0+0xae/0x1c0 [ice]
[  +0.000086]  ice_prepare_for_reset+0x299/0x750 [ice]
[  +0.000087]  pci_dev_save_and_disable+0x82/0xd0
[  +0.000006]  pci_reset_function+0x12d/0x230
[  +0.000004]  reset_store+0xa0/0x100
[  +0.000006]  ? __pfx_reset_store+0x10/0x10
[  +0.000002]  ? __pfx_mutex_lock+0x10/0x10
[  +0.000004]  ? __check_object_size+0x4c1/0x640
[  +0.000007]  kernfs_fop_write_iter+0x30b/0x4a0
[  +0.000006]  vfs_write+0x5d6/0xdf0
[  +0.000005]  ? fd_install+0x180/0x350
[  +0.000005]  ? __pfx_vfs_write+0x10/0xA10
[  +0.000004]  ? do_fcntl+0x52c/0xcd0
[  +0.000004]  ? kasan_save_track+0x13/0x60
[  +0.000003]  ? kasan_save_free_info+0x37/0x60
[  +0.000006]  ksys_write+0xfa/0x1d0
[  +0.000003]  ? __pfx_ksys_write+0x10/0x10
[  +0.000002]  ? __x64_sys_fcntl+0x121/0x180
[  +0.000004]  ? _raw_spin_lock+0x87/0xe0
[  +0.000005]  do_syscall_64+0x80/0x170
[  +0.000007]  ? _raw_spin_lock+0x87/0xe0
[  +0.000004]  ? __pfx__raw_spin_lock+0x10/0x10
[  +0.000003]  ? file_close_fd_locked+0x167/0x230
[  +0.000005]  ? syscall_exit_to_user_mode+0x7d/0x220
[  +0.000005]  ? do_syscall_64+0x8c/0x170
[  +0.000004]  ? do_syscall_64+0x8c/0x170
[  +0.000003]  ? do_syscall_64+0x8c/0x170
[  +0.000003]  ? fput+0x1a/0x2c0
[  +0.000004]  ? filp_close+0x19/0x30
[  +0.000004]  ? do_dup2+0x25a/0x4c0
[  +0.000004]  ? __x64_sys_dup2+0x6e/0x2e0
[  +0.000002]  ? syscall_exit_to_user_mode+0x7d/0x220
[  +0.000004]  ? do_syscall_64+0x8c/0x170
[  +0.000003]  ? __count_memcg_events+0x113/0x380
[  +0.000005]  ? handle_mm_fault+0x136/0x820
[  +0.000005]  ? do_user_addr_fault+0x444/0xa80
[  +0.000004]  ? clear_bhb_loop+0x25/0x80
[  +0.000004]  ? clear_bhb_loop+0x25/0x80
[  +0.000002]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  +0.000005] RIP: 0033:0x7f2033593154

Fixes: 080b0c8d6d26 ("ice: Fix ASSERT_RTNL() warning during certain scenarios")
Fixes: 91fdbce7e8d6 ("ice: Add support in the driver for associating queue with napi")
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Amritha Nambiar <amritha.nambiar@intel.com>
Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Tested-by: George Kuruvinakunnel <george.kuruvinakunnel@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_base.c |  11 +-
 drivers/net/ethernet/intel/ice/ice_lib.c  | 129 ++++++----------------
 drivers/net/ethernet/intel/ice/ice_lib.h  |  10 +-
 drivers/net/ethernet/intel/ice/ice_main.c |  17 ++-
 4 files changed, 49 insertions(+), 118 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_base.c b/drivers/net/ethernet/intel/ice/ice_base.c
index f448d3a84564..c158749a80e0 100644
--- a/drivers/net/ethernet/intel/ice/ice_base.c
+++ b/drivers/net/ethernet/intel/ice/ice_base.c
@@ -190,16 +190,11 @@ static void ice_free_q_vector(struct ice_vsi *vsi, int v_idx)
 	}
 	q_vector = vsi->q_vectors[v_idx];
 
-	ice_for_each_tx_ring(tx_ring, q_vector->tx) {
-		ice_queue_set_napi(vsi, tx_ring->q_index, NETDEV_QUEUE_TYPE_TX,
-				   NULL);
+	ice_for_each_tx_ring(tx_ring, vsi->q_vectors[v_idx]->tx)
 		tx_ring->q_vector = NULL;
-	}
-	ice_for_each_rx_ring(rx_ring, q_vector->rx) {
-		ice_queue_set_napi(vsi, rx_ring->q_index, NETDEV_QUEUE_TYPE_RX,
-				   NULL);
+
+	ice_for_each_rx_ring(rx_ring, vsi->q_vectors[v_idx]->rx)
 		rx_ring->q_vector = NULL;
-	}
 
 	/* only VSI with an associated netdev is set up with NAPI */
 	if (vsi->netdev)
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index f559e60992fa..6676596df88b 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -2286,9 +2286,6 @@ static int ice_vsi_cfg_def(struct ice_vsi *vsi)
 
 		ice_vsi_map_rings_to_vectors(vsi);
 
-		/* Associate q_vector rings to napi */
-		ice_vsi_set_napi_queues(vsi);
-
 		vsi->stat_offsets_loaded = false;
 
 		/* ICE_VSI_CTRL does not need RSS so skip RSS processing */
@@ -2628,6 +2625,7 @@ void ice_vsi_close(struct ice_vsi *vsi)
 	if (!test_and_set_bit(ICE_VSI_DOWN, vsi->state))
 		ice_down(vsi);
 
+	ice_vsi_clear_napi_queues(vsi);
 	ice_vsi_free_irq(vsi);
 	ice_vsi_free_tx_rings(vsi);
 	ice_vsi_free_rx_rings(vsi);
@@ -2694,120 +2692,55 @@ void ice_dis_vsi(struct ice_vsi *vsi, bool locked)
 }
 
 /**
- * __ice_queue_set_napi - Set the napi instance for the queue
- * @dev: device to which NAPI and queue belong
- * @queue_index: Index of queue
- * @type: queue type as RX or TX
- * @napi: NAPI context
- * @locked: is the rtnl_lock already held
- *
- * Set the napi instance for the queue. Caller indicates the lock status.
- */
-static void
-__ice_queue_set_napi(struct net_device *dev, unsigned int queue_index,
-		     enum netdev_queue_type type, struct napi_struct *napi,
-		     bool locked)
-{
-	if (!locked)
-		rtnl_lock();
-	netif_queue_set_napi(dev, queue_index, type, napi);
-	if (!locked)
-		rtnl_unlock();
-}
-
-/**
- * ice_queue_set_napi - Set the napi instance for the queue
- * @vsi: VSI being configured
- * @queue_index: Index of queue
- * @type: queue type as RX or TX
- * @napi: NAPI context
+ * ice_vsi_set_napi_queues - associate netdev queues with napi
+ * @vsi: VSI pointer
  *
- * Set the napi instance for the queue. The rtnl lock state is derived from the
- * execution path.
+ * Associate queue[s] with napi for all vectors.
+ * The caller must hold rtnl_lock.
  */
-void
-ice_queue_set_napi(struct ice_vsi *vsi, unsigned int queue_index,
-		   enum netdev_queue_type type, struct napi_struct *napi)
+void ice_vsi_set_napi_queues(struct ice_vsi *vsi)
 {
-	struct ice_pf *pf = vsi->back;
+	struct net_device *netdev = vsi->netdev;
+	int q_idx, v_idx;
 
-	if (!vsi->netdev)
+	if (!netdev)
 		return;
 
-	if (current_work() == &pf->serv_task ||
-	    test_bit(ICE_PREPARED_FOR_RESET, pf->state) ||
-	    test_bit(ICE_DOWN, pf->state) ||
-	    test_bit(ICE_SUSPENDED, pf->state))
-		__ice_queue_set_napi(vsi->netdev, queue_index, type, napi,
-				     false);
-	else
-		__ice_queue_set_napi(vsi->netdev, queue_index, type, napi,
-				     true);
-}
+	ice_for_each_rxq(vsi, q_idx)
+		netif_queue_set_napi(netdev, q_idx, NETDEV_QUEUE_TYPE_RX,
+				     &vsi->rx_rings[q_idx]->q_vector->napi);
 
-/**
- * __ice_q_vector_set_napi_queues - Map queue[s] associated with the napi
- * @q_vector: q_vector pointer
- * @locked: is the rtnl_lock already held
- *
- * Associate the q_vector napi with all the queue[s] on the vector.
- * Caller indicates the lock status.
- */
-void __ice_q_vector_set_napi_queues(struct ice_q_vector *q_vector, bool locked)
-{
-	struct ice_rx_ring *rx_ring;
-	struct ice_tx_ring *tx_ring;
-
-	ice_for_each_rx_ring(rx_ring, q_vector->rx)
-		__ice_queue_set_napi(q_vector->vsi->netdev, rx_ring->q_index,
-				     NETDEV_QUEUE_TYPE_RX, &q_vector->napi,
-				     locked);
-
-	ice_for_each_tx_ring(tx_ring, q_vector->tx)
-		__ice_queue_set_napi(q_vector->vsi->netdev, tx_ring->q_index,
-				     NETDEV_QUEUE_TYPE_TX, &q_vector->napi,
-				     locked);
+	ice_for_each_txq(vsi, q_idx)
+		netif_queue_set_napi(netdev, q_idx, NETDEV_QUEUE_TYPE_TX,
+				     &vsi->tx_rings[q_idx]->q_vector->napi);
 	/* Also set the interrupt number for the NAPI */
-	netif_napi_set_irq(&q_vector->napi, q_vector->irq.virq);
-}
+	ice_for_each_q_vector(vsi, v_idx) {
+		struct ice_q_vector *q_vector = vsi->q_vectors[v_idx];
 
-/**
- * ice_q_vector_set_napi_queues - Map queue[s] associated with the napi
- * @q_vector: q_vector pointer
- *
- * Associate the q_vector napi with all the queue[s] on the vector
- */
-void ice_q_vector_set_napi_queues(struct ice_q_vector *q_vector)
-{
-	struct ice_rx_ring *rx_ring;
-	struct ice_tx_ring *tx_ring;
-
-	ice_for_each_rx_ring(rx_ring, q_vector->rx)
-		ice_queue_set_napi(q_vector->vsi, rx_ring->q_index,
-				   NETDEV_QUEUE_TYPE_RX, &q_vector->napi);
-
-	ice_for_each_tx_ring(tx_ring, q_vector->tx)
-		ice_queue_set_napi(q_vector->vsi, tx_ring->q_index,
-				   NETDEV_QUEUE_TYPE_TX, &q_vector->napi);
-	/* Also set the interrupt number for the NAPI */
-	netif_napi_set_irq(&q_vector->napi, q_vector->irq.virq);
+		netif_napi_set_irq(&q_vector->napi, q_vector->irq.virq);
+	}
 }
 
 /**
- * ice_vsi_set_napi_queues
+ * ice_vsi_clear_napi_queues - dissociate netdev queues from napi
  * @vsi: VSI pointer
  *
- * Associate queue[s] with napi for all vectors
+ * Clear the association between all VSI queues queue[s] and napi.
+ * The caller must hold rtnl_lock.
  */
-void ice_vsi_set_napi_queues(struct ice_vsi *vsi)
+void ice_vsi_clear_napi_queues(struct ice_vsi *vsi)
 {
-	int i;
+	struct net_device *netdev = vsi->netdev;
+	int q_idx;
 
-	if (!vsi->netdev)
+	if (!netdev)
 		return;
 
-	ice_for_each_q_vector(vsi, i)
-		ice_q_vector_set_napi_queues(vsi->q_vectors[i]);
+	ice_for_each_txq(vsi, q_idx)
+		netif_queue_set_napi(netdev, q_idx, NETDEV_QUEUE_TYPE_TX, NULL);
+
+	ice_for_each_rxq(vsi, q_idx)
+		netif_queue_set_napi(netdev, q_idx, NETDEV_QUEUE_TYPE_RX, NULL);
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.h b/drivers/net/ethernet/intel/ice/ice_lib.h
index 94ce8964dda6..36d86535695d 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.h
+++ b/drivers/net/ethernet/intel/ice/ice_lib.h
@@ -44,16 +44,10 @@ void ice_vsi_cfg_netdev_tc(struct ice_vsi *vsi, u8 ena_tc);
 struct ice_vsi *
 ice_vsi_setup(struct ice_pf *pf, struct ice_vsi_cfg_params *params);
 
-void
-ice_queue_set_napi(struct ice_vsi *vsi, unsigned int queue_index,
-		   enum netdev_queue_type type, struct napi_struct *napi);
-
-void __ice_q_vector_set_napi_queues(struct ice_q_vector *q_vector, bool locked);
-
-void ice_q_vector_set_napi_queues(struct ice_q_vector *q_vector);
-
 void ice_vsi_set_napi_queues(struct ice_vsi *vsi);
 
+void ice_vsi_clear_napi_queues(struct ice_vsi *vsi);
+
 int ice_vsi_release(struct ice_vsi *vsi);
 
 void ice_vsi_close(struct ice_vsi *vsi);
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 46d3c5a34d6a..263833346d3a 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -3558,11 +3558,9 @@ static void ice_napi_add(struct ice_vsi *vsi)
 	if (!vsi->netdev)
 		return;
 
-	ice_for_each_q_vector(vsi, v_idx) {
+	ice_for_each_q_vector(vsi, v_idx)
 		netif_napi_add(vsi->netdev, &vsi->q_vectors[v_idx]->napi,
 			       ice_napi_poll);
-		__ice_q_vector_set_napi_queues(vsi->q_vectors[v_idx], false);
-	}
 }
 
 /**
@@ -5540,7 +5538,9 @@ static int ice_reinit_interrupt_scheme(struct ice_pf *pf)
 		if (ret)
 			goto err_reinit;
 		ice_vsi_map_rings_to_vectors(pf->vsi[v]);
+		rtnl_lock();
 		ice_vsi_set_napi_queues(pf->vsi[v]);
+		rtnl_unlock();
 	}
 
 	ret = ice_req_irq_msix_misc(pf);
@@ -5554,8 +5554,12 @@ static int ice_reinit_interrupt_scheme(struct ice_pf *pf)
 
 err_reinit:
 	while (v--)
-		if (pf->vsi[v])
+		if (pf->vsi[v]) {
+			rtnl_lock();
+			ice_vsi_clear_napi_queues(pf->vsi[v]);
+			rtnl_unlock();
 			ice_vsi_free_q_vectors(pf->vsi[v]);
+		}
 
 	return ret;
 }
@@ -5620,6 +5624,9 @@ static int ice_suspend(struct device *dev)
 	ice_for_each_vsi(pf, v) {
 		if (!pf->vsi[v])
 			continue;
+		rtnl_lock();
+		ice_vsi_clear_napi_queues(pf->vsi[v]);
+		rtnl_unlock();
 		ice_vsi_free_q_vectors(pf->vsi[v]);
 	}
 	ice_clear_interrupt_scheme(pf);
@@ -7455,6 +7462,8 @@ int ice_vsi_open(struct ice_vsi *vsi)
 		err = netif_set_real_num_rx_queues(vsi->netdev, vsi->num_rxq);
 		if (err)
 			goto err_set_qs;
+
+		ice_vsi_set_napi_queues(vsi);
 	}
 
 	err = ice_up_complete(vsi);
-- 
2.42.0


