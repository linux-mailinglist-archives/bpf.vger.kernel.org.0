Return-Path: <bpf+bounces-67788-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F2E2B49A75
	for <lists+bpf@lfdr.de>; Mon,  8 Sep 2025 21:58:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8939E4E02E4
	for <lists+bpf@lfdr.de>; Mon,  8 Sep 2025 19:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B0312D73AD;
	Mon,  8 Sep 2025 19:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hTVzu+bu"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11EA02D63F8;
	Mon,  8 Sep 2025 19:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757361494; cv=none; b=Azc1xJtA63129JLTnzQnB7bEjsiqrJhy8sZs7Ev5U7cBccY6/+ronHD9F7tTE6o02o2hDPPT2PcRTKCuof14jhcwnUwG3dhsUX1xoFUwnFY7y3CP1u5ZziWB8/Wuw1C81nvAjG0ZhX0CwUWWDxc7KR4e7C/LtyZ1KVZ+SVQeRjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757361494; c=relaxed/simple;
	bh=EwzbpycqbR+bY27CvtkCWbBEEfqJpiss5+AkvO23vKQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tN75t9Kv3NES8V0el/5A9WPBQRSvnWdoiazbh9mSFc3JJdUHcgNTtYwhZkwYm8yRj0ezsI8vlE5sfkuRfyd6UVYDxFIQYLO/QdwSLbN2EI2jVR8PbSb9zcR7GelTwMItNhL1EH9unwu8V/FPP3W5/+qKSdmrk4+kRBTSzHkGyhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hTVzu+bu; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757361494; x=1788897494;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EwzbpycqbR+bY27CvtkCWbBEEfqJpiss5+AkvO23vKQ=;
  b=hTVzu+buLOPeg+kdH/SLs7rUs0mcv4oLu8RkzXk1S5kqgE/AqOV2HKTH
   8emVQ35PuWLV13N76OIakNYrzT7CL/HV3rdAzPMDiJRXEQAqACjUHZfoU
   x0kJodbchPypeDcmTdOLPWhb5XDxkSRKoGbKH0wmNFy2kiO+eFvt+C3k2
   ODt33HGRJ8uPv9G25IU5oszzJxSQZp67cLxzOVS23auUr3jNcfo9PruI5
   z+xrfYX4MMFIWzfH2JnoLWtxy0xQfli3r05E9iOpcVpm7q+I3sM7CzMus
   vFXksFYolyXSNFJSUDXokfrgzZL4WRJNuuKyxKmFpPheef+PuuDLMKEkZ
   A==;
X-CSE-ConnectionGUID: qi/62Co8QWeB68DTerA0FA==
X-CSE-MsgGUID: F0j6vX0sTvSTBYt4jXF5NA==
X-IronPort-AV: E=McAfee;i="6800,10657,11547"; a="77088907"
X-IronPort-AV: E=Sophos;i="6.18,249,1751266800"; 
   d="scan'208";a="77088907"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2025 12:58:11 -0700
X-CSE-ConnectionGUID: 5FAgJV4sStGhj4mHhULOGA==
X-CSE-MsgGUID: eSlrzjuQRmOt1D2Mu/15Dw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,249,1751266800"; 
   d="scan'208";a="177189727"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa004.jf.intel.com with ESMTP; 08 Sep 2025 12:58:11 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	anthony.l.nguyen@intel.com,
	michal.kubiak@intel.com,
	maciej.fijalkowski@intel.com,
	magnus.karlsson@intel.com,
	przemyslaw.kitszel@intel.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	horms@kernel.org,
	sdf@fomichev.me,
	nxne.cnse.osdt.itp.upstreaming@intel.com,
	bpf@vger.kernel.org,
	Ramu R <ramu.r@intel.com>
Subject: [PATCH net-next 04/13] idpf: link NAPIs to queues
Date: Mon,  8 Sep 2025 12:57:34 -0700
Message-ID: <20250908195748.1707057-5-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250908195748.1707057-1-anthony.l.nguyen@intel.com>
References: <20250908195748.1707057-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexander Lobakin <aleksander.lobakin@intel.com>

Add the missing linking of NAPIs to netdev queues when enabling
interrupt vectors in order to support NAPI configuration and
interfaces requiring get_rx_queue()->napi to be set (like XSk
busy polling).

As currently, idpf_vport_{start,stop}() is called from several flows
with inconsistent RTNL locking, we need to synchronize them to avoid
runtime assertions. Notably:

* idpf_{open,stop}() -- regular NDOs, RTNL is always taken;
* idpf_initiate_soft_reset() -- usually called under RTNL;
* idpf_init_task -- called from the init work, needs RTNL;
* idpf_vport_dealloc -- called without RTNL taken, needs it.

Expand common idpf_vport_{start,stop}() to take an additional bool
telling whether we need to manually take the RTNL lock.

Suggested-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com> # helper
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Tested-by: Ramu R <ramu.r@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_lib.c  | 38 +++++++++++++++------
 drivers/net/ethernet/intel/idpf/idpf_txrx.c | 17 +++++++++
 2 files changed, 45 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
index e327950c93d8..f4b89d222610 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
@@ -884,14 +884,18 @@ static void idpf_remove_features(struct idpf_vport *vport)
 /**
  * idpf_vport_stop - Disable a vport
  * @vport: vport to disable
+ * @rtnl: whether to take RTNL lock
  */
-static void idpf_vport_stop(struct idpf_vport *vport)
+static void idpf_vport_stop(struct idpf_vport *vport, bool rtnl)
 {
 	struct idpf_netdev_priv *np = netdev_priv(vport->netdev);
 
 	if (np->state <= __IDPF_VPORT_DOWN)
 		return;
 
+	if (rtnl)
+		rtnl_lock();
+
 	netif_carrier_off(vport->netdev);
 	netif_tx_disable(vport->netdev);
 
@@ -913,6 +917,9 @@ static void idpf_vport_stop(struct idpf_vport *vport)
 	idpf_vport_queues_rel(vport);
 	idpf_vport_intr_rel(vport);
 	np->state = __IDPF_VPORT_DOWN;
+
+	if (rtnl)
+		rtnl_unlock();
 }
 
 /**
@@ -936,7 +943,7 @@ static int idpf_stop(struct net_device *netdev)
 	idpf_vport_ctrl_lock(netdev);
 	vport = idpf_netdev_to_vport(netdev);
 
-	idpf_vport_stop(vport);
+	idpf_vport_stop(vport, false);
 
 	idpf_vport_ctrl_unlock(netdev);
 
@@ -1029,7 +1036,7 @@ static void idpf_vport_dealloc(struct idpf_vport *vport)
 	idpf_idc_deinit_vport_aux_device(vport->vdev_info);
 
 	idpf_deinit_mac_addr(vport);
-	idpf_vport_stop(vport);
+	idpf_vport_stop(vport, true);
 
 	if (!test_bit(IDPF_HR_RESET_IN_PROG, adapter->flags))
 		idpf_decfg_netdev(vport);
@@ -1370,8 +1377,9 @@ static void idpf_rx_init_buf_tail(struct idpf_vport *vport)
 /**
  * idpf_vport_open - Bring up a vport
  * @vport: vport to bring up
+ * @rtnl: whether to take RTNL lock
  */
-static int idpf_vport_open(struct idpf_vport *vport)
+static int idpf_vport_open(struct idpf_vport *vport, bool rtnl)
 {
 	struct idpf_netdev_priv *np = netdev_priv(vport->netdev);
 	struct idpf_adapter *adapter = vport->adapter;
@@ -1381,6 +1389,9 @@ static int idpf_vport_open(struct idpf_vport *vport)
 	if (np->state != __IDPF_VPORT_DOWN)
 		return -EBUSY;
 
+	if (rtnl)
+		rtnl_lock();
+
 	/* we do not allow interface up just yet */
 	netif_carrier_off(vport->netdev);
 
@@ -1388,7 +1399,7 @@ static int idpf_vport_open(struct idpf_vport *vport)
 	if (err) {
 		dev_err(&adapter->pdev->dev, "Failed to allocate interrupts for vport %u: %d\n",
 			vport->vport_id, err);
-		return err;
+		goto err_rtnl_unlock;
 	}
 
 	err = idpf_vport_queues_alloc(vport);
@@ -1475,6 +1486,9 @@ static int idpf_vport_open(struct idpf_vport *vport)
 		goto deinit_rss;
 	}
 
+	if (rtnl)
+		rtnl_unlock();
+
 	return 0;
 
 deinit_rss:
@@ -1492,6 +1506,10 @@ static int idpf_vport_open(struct idpf_vport *vport)
 intr_rel:
 	idpf_vport_intr_rel(vport);
 
+err_rtnl_unlock:
+	if (rtnl)
+		rtnl_unlock();
+
 	return err;
 }
 
@@ -1572,7 +1590,7 @@ void idpf_init_task(struct work_struct *work)
 	np = netdev_priv(vport->netdev);
 	np->state = __IDPF_VPORT_DOWN;
 	if (test_and_clear_bit(IDPF_VPORT_UP_REQUESTED, vport_config->flags))
-		idpf_vport_open(vport);
+		idpf_vport_open(vport, true);
 
 	/* Spawn and return 'idpf_init_task' work queue until all the
 	 * default vports are created
@@ -1962,7 +1980,7 @@ int idpf_initiate_soft_reset(struct idpf_vport *vport,
 		idpf_send_delete_queues_msg(vport);
 	} else {
 		set_bit(IDPF_VPORT_DEL_QUEUES, vport->flags);
-		idpf_vport_stop(vport);
+		idpf_vport_stop(vport, false);
 	}
 
 	idpf_deinit_rss(vport);
@@ -1992,7 +2010,7 @@ int idpf_initiate_soft_reset(struct idpf_vport *vport,
 		goto err_open;
 
 	if (current_state == __IDPF_VPORT_UP)
-		err = idpf_vport_open(vport);
+		err = idpf_vport_open(vport, false);
 
 	goto free_vport;
 
@@ -2002,7 +2020,7 @@ int idpf_initiate_soft_reset(struct idpf_vport *vport,
 
 err_open:
 	if (current_state == __IDPF_VPORT_UP)
-		idpf_vport_open(vport);
+		idpf_vport_open(vport, false);
 
 free_vport:
 	kfree(new_vport);
@@ -2240,7 +2258,7 @@ static int idpf_open(struct net_device *netdev)
 	if (err)
 		goto unlock;
 
-	err = idpf_vport_open(vport);
+	err = idpf_vport_open(vport, false);
 
 unlock:
 	idpf_vport_ctrl_unlock(netdev);
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index 53fb5cf496cc..563de9a32919 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -3424,6 +3424,20 @@ void idpf_vport_intr_rel(struct idpf_vport *vport)
 	vport->q_vectors = NULL;
 }
 
+static void idpf_q_vector_set_napi(struct idpf_q_vector *q_vector, bool link)
+{
+	struct napi_struct *napi = link ? &q_vector->napi : NULL;
+	struct net_device *dev = q_vector->vport->netdev;
+
+	for (u32 i = 0; i < q_vector->num_rxq; i++)
+		netif_queue_set_napi(dev, q_vector->rx[i]->idx,
+				     NETDEV_QUEUE_TYPE_RX, napi);
+
+	for (u32 i = 0; i < q_vector->num_txq; i++)
+		netif_queue_set_napi(dev, q_vector->tx[i]->idx,
+				     NETDEV_QUEUE_TYPE_TX, napi);
+}
+
 /**
  * idpf_vport_intr_rel_irq - Free the IRQ association with the OS
  * @vport: main vport structure
@@ -3444,6 +3458,7 @@ static void idpf_vport_intr_rel_irq(struct idpf_vport *vport)
 		vidx = vport->q_vector_idxs[vector];
 		irq_num = adapter->msix_entries[vidx].vector;
 
+		idpf_q_vector_set_napi(q_vector, false);
 		kfree(free_irq(irq_num, q_vector));
 	}
 }
@@ -3631,6 +3646,8 @@ static int idpf_vport_intr_req_irq(struct idpf_vport *vport)
 				   "Request_irq failed, error: %d\n", err);
 			goto free_q_irqs;
 		}
+
+		idpf_q_vector_set_napi(q_vector, true);
 	}
 
 	return 0;
-- 
2.47.1


