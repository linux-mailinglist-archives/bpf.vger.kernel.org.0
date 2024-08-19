Return-Path: <bpf+bounces-37489-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D6949567F9
	for <lists+bpf@lfdr.de>; Mon, 19 Aug 2024 12:14:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 062B7283A5A
	for <lists+bpf@lfdr.de>; Mon, 19 Aug 2024 10:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C60761607B0;
	Mon, 19 Aug 2024 10:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AR3A4av2"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0BE160783;
	Mon, 19 Aug 2024 10:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724062480; cv=none; b=UmgH+NgJis+wVrlnENU7f+3f6J8Q4NZyxK08RGvGHafAD4VmYg5bPrA/0jhKHI8rbl1zpwH+07DdA8WGuK5aUMgfQ0/HOVEgXZRE5DUmGHi7IjyakDO3K5NnzxceFkSwNLCeWIDs0rZtvGJin/NDonzO5iYyQw/dETCbHilOYqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724062480; c=relaxed/simple;
	bh=fo0nVlCJ+D7aO8Fh3k4D9+86cWZfZR9SQiICElqB6pU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NxOCIwt7NRSB/Ut8+PrffHDDwsAVFbyFmLk3io80I7XeWgCj7wLUz2lVclfOALdJFXAiHdLyS3WURliEY2iAbWqcIAhodns2KtyeadMB61o901BJNyGSIm64PBV7iFQ+jfkyLliS+aeDXZo0ubg8Y9aKpAdcqD4BcyMCAS57iwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AR3A4av2; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724062479; x=1755598479;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fo0nVlCJ+D7aO8Fh3k4D9+86cWZfZR9SQiICElqB6pU=;
  b=AR3A4av2zHnsXUG1l5zZg8NrJbojhQOFonUzX7jx73GuQ10FG7l8whVu
   1bpQZYMnOnI1TPXvfa/0ILSUGSygXneZ6y3nEOWEdXzv9MptuofpEaHau
   sgwtwpUkfJW3bb6l56hZh0OaLEQahvICk72qU8NghGi2rT4u0TkxF5+LD
   CfR2xe3vqJlrDm5AVh/qS4lAHzDNHdLn/3f0gBinzLIlQrXvUa2V8lLgl
   lE0hJz63xkLhOodByJYvfMuW4aUIP+fww6O4yRK5ITlGANIRkC6u+Gaaa
   YLlkS6KQK+WoI9DSs4cazgHow6gEVVzCM2rLkCXhtitghGAA4TnHCdKn8
   Q==;
X-CSE-ConnectionGUID: 8ZIDmEGMSmGirNPe4cOfQA==
X-CSE-MsgGUID: NOx2QiIOTf6dJX5pFHJNTw==
X-IronPort-AV: E=McAfee;i="6700,10204,11168"; a="22443480"
X-IronPort-AV: E=Sophos;i="6.10,158,1719903600"; 
   d="scan'208";a="22443480"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 03:14:38 -0700
X-CSE-ConnectionGUID: 2A4JvDA4Rp+t0KrtYwZxJw==
X-CSE-MsgGUID: vTyWOc+aQl6jqkNy/pAhXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,158,1719903600"; 
   d="scan'208";a="65000871"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa004.fm.intel.com with ESMTP; 19 Aug 2024 03:14:29 -0700
Received: from lincoln.igk.intel.com (lincoln.igk.intel.com [10.102.21.235])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 1CB4B135E8;
	Mon, 19 Aug 2024 11:14:27 +0100 (IST)
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
Subject: [PATCH iwl-net v3 1/6] ice: move netif_queue_set_napi to rtnl-protected sections
Date: Mon, 19 Aug 2024 12:05:38 +0200
Message-ID: <20240819100606.15383-2-larysa.zaremba@intel.com>
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
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Amritha Nambiar <amritha.nambiar@intel.com>
Tested-by: Chandan Kumar Rout <chandanx.rout@intel.com>
Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
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
index 03c4df4ed585..5f2ddcaf7031 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -2286,9 +2286,6 @@ static int ice_vsi_cfg_def(struct ice_vsi *vsi)
 
 		ice_vsi_map_rings_to_vectors(vsi);
 
-		/* Associate q_vector rings to napi */
-		ice_vsi_set_napi_queues(vsi);
-
 		vsi->stat_offsets_loaded = false;
 
 		/* ICE_VSI_CTRL does not need RSS so skip RSS processing */
@@ -2621,6 +2618,7 @@ void ice_vsi_close(struct ice_vsi *vsi)
 	if (!test_and_set_bit(ICE_VSI_DOWN, vsi->state))
 		ice_down(vsi);
 
+	ice_vsi_clear_napi_queues(vsi);
 	ice_vsi_free_irq(vsi);
 	ice_vsi_free_tx_rings(vsi);
 	ice_vsi_free_rx_rings(vsi);
@@ -2687,120 +2685,55 @@ void ice_dis_vsi(struct ice_vsi *vsi, bool locked)
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
+ * ice_vsi_set_napi_queues
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
-
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
+	ice_for_each_q_vector(vsi, v_idx) {
+		struct ice_q_vector *q_vector = vsi->q_vectors[v_idx];
 
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
+ * ice_vsi_clear_napi_queues
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
index 66820ed5e969..2d286a4609a5 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -3537,11 +3537,9 @@ static void ice_napi_add(struct ice_vsi *vsi)
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
@@ -5519,7 +5517,9 @@ static int ice_reinit_interrupt_scheme(struct ice_pf *pf)
 		if (ret)
 			goto err_reinit;
 		ice_vsi_map_rings_to_vectors(pf->vsi[v]);
+		rtnl_lock();
 		ice_vsi_set_napi_queues(pf->vsi[v]);
+		rtnl_unlock();
 	}
 
 	ret = ice_req_irq_msix_misc(pf);
@@ -5533,8 +5533,12 @@ static int ice_reinit_interrupt_scheme(struct ice_pf *pf)
 
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
@@ -5599,6 +5603,9 @@ static int ice_suspend(struct device *dev)
 	ice_for_each_vsi(pf, v) {
 		if (!pf->vsi[v])
 			continue;
+		rtnl_lock();
+		ice_vsi_clear_napi_queues(pf->vsi[v]);
+		rtnl_unlock();
 		ice_vsi_free_q_vectors(pf->vsi[v]);
 	}
 	ice_clear_interrupt_scheme(pf);
@@ -7434,6 +7441,8 @@ int ice_vsi_open(struct ice_vsi *vsi)
 		err = netif_set_real_num_rx_queues(vsi->netdev, vsi->num_rxq);
 		if (err)
 			goto err_set_qs;
+
+		ice_vsi_set_napi_queues(vsi);
 	}
 
 	err = ice_up_complete(vsi);
-- 
2.43.0


