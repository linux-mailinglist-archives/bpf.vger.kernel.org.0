Return-Path: <bpf+bounces-66562-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49293B36FC2
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 18:15:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FADB1892FB4
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 16:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3B993164A1;
	Tue, 26 Aug 2025 16:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bpvkgPHJ"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93DD931A54D;
	Tue, 26 Aug 2025 16:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756224826; cv=none; b=BnJyQAbsIQz0cS61p8dGob5X05xH+SYpE+JJo2UN+sY+nQnXBY2GdXLhSy7JmtwESOG9UQk9EGqX90jaZjyZwYQAXdR1XcRcQWCwY801fAmMs+Psk9i999WfIWGbxoITnJAHrVoIoS1Dsi9nVOO1XQk37wbEwfUT4EeixdJBOAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756224826; c=relaxed/simple;
	bh=o+1HV0j8Kaso9cXniUzmaJsDKPTGfWFDT3rQDUMmpio=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qF6aPYP0p58w0Kk5ENqjw2G9X4hiVLYGx3247NUH5xEoXg8t6kXluDuQSPQFtaWUHaNfMsG4JlqKpxjWeDDRP0ihSbzvcPcUJVA/66Uo+pYpVzUZ2FyyFBTwNYj4tHiiLpeiS3MaYKlkq9UNW0KTs5zEFA05ZOSbgcRJicchcdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bpvkgPHJ; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756224825; x=1787760825;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=o+1HV0j8Kaso9cXniUzmaJsDKPTGfWFDT3rQDUMmpio=;
  b=bpvkgPHJftRxzSS9YWwzXM+HHTwPm6/xhXkbG6ErJ9MAGxFgjy4M5RvN
   hJ4yZA/mrQBOoi6ML2rivPAgscer8vndFazXbO3n0SIvSFPE4aKQi34y0
   k2g7HZb7OLcBl9hBGkdTZM7loFcYYiGCgObXwd+EeLD2bhNcQ66AzK64I
   BxRTOQL3KbS+fhGbafx0NZ4FWkWw2WnWi3bczSWow2+CdwIphJzzWgehU
   Q7OXPiI7hx78tjWSoEb97V9cel/wezuXskdsC7Hul5Pdc4zg3u+RnUTAQ
   D1s+W0EAtVm4l/zxLKvTjX++JUSyQFaC/HyToO5Y8V3sXYU2PnX6x7yVD
   w==;
X-CSE-ConnectionGUID: vI4hS26WSuaM0h8DZ5Bcag==
X-CSE-MsgGUID: 8GkoBUDoT/2X3PGoOTyGTg==
X-IronPort-AV: E=McAfee;i="6800,10657,11534"; a="46044923"
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="46044923"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 09:13:44 -0700
X-CSE-ConnectionGUID: bB5BXYTDSuq5F86T+eWFcQ==
X-CSE-MsgGUID: EOPxBbbAS4a01YcMlJX5Yg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="200562149"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa002.jf.intel.com with ESMTP; 26 Aug 2025 09:13:40 -0700
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Michal Kubiak <michal.kubiak@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Simon Horman <horms@kernel.org>,
	nxne.cnse.osdt.itp.upstreaming@intel.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH iwl-next v5 04/13] idpf: link NAPIs to queues
Date: Tue, 26 Aug 2025 17:54:58 +0200
Message-ID: <20250826155507.2138401-5-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250826155507.2138401-1-aleksander.lobakin@intel.com>
References: <20250826155507.2138401-1-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
---
 drivers/net/ethernet/intel/idpf/idpf_lib.c  | 38 +++++++++++++++------
 drivers/net/ethernet/intel/idpf/idpf_txrx.c | 17 +++++++++
 2 files changed, 45 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
index 67236a68f6be..b5a7215488b9 100644
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
index f49791eab07d..0a2a2b21d1ef 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -3423,6 +3423,20 @@ void idpf_vport_intr_rel(struct idpf_vport *vport)
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
@@ -3443,6 +3457,7 @@ static void idpf_vport_intr_rel_irq(struct idpf_vport *vport)
 		vidx = vport->q_vector_idxs[vector];
 		irq_num = adapter->msix_entries[vidx].vector;
 
+		idpf_q_vector_set_napi(q_vector, false);
 		kfree(free_irq(irq_num, q_vector));
 	}
 }
@@ -3630,6 +3645,8 @@ static int idpf_vport_intr_req_irq(struct idpf_vport *vport)
 				   "Request_irq failed, error: %d\n", err);
 			goto free_q_irqs;
 		}
+
+		idpf_q_vector_set_napi(q_vector, true);
 	}
 
 	return 0;
-- 
2.51.0


