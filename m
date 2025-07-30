Return-Path: <bpf+bounces-64722-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63333B16447
	for <lists+bpf@lfdr.de>; Wed, 30 Jul 2025 18:13:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E8FD1882573
	for <lists+bpf@lfdr.de>; Wed, 30 Jul 2025 16:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B15222E5404;
	Wed, 30 Jul 2025 16:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iaioom1E"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD452E49AC;
	Wed, 30 Jul 2025 16:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753891715; cv=none; b=pUE+HohQUzFL0vXItZrxb6r99YV6XMeZKrDRJDZq25b6OQ8hs/JvWTGU0J05hDsP3tz6K7Rlt8WSZNt3Gjs5YyaPMJu6Uuagbs7fJd8+Zz1spEzmBxac0mxvgnejFZlJuxnvJ62WCEFG3wyFLHgPSWDNyZzVfbk39v75zehewxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753891715; c=relaxed/simple;
	bh=c7i2D1AdoiTDwpo3R681g4dukoz9H0HKMzQlH3iBtLg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lX/SUKa4Bs2SUTP5ia4u/2ZO//PUY3q1woHGMgoYTbnUcr+QbEYSWNm0Xt/wI9W1aqZtdqi2THjtDNjYGk4esKOqqWEaL6EJaaKJFAhL+MThA4hNS/qPy5gbAj8bvGyzuE8Wr1+rRucamug339v9HOtQbvJPKfVG7ubAK0g1BWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iaioom1E; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753891714; x=1785427714;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=c7i2D1AdoiTDwpo3R681g4dukoz9H0HKMzQlH3iBtLg=;
  b=iaioom1Eqem2PlN0kUnyHAhSrfbp/mvWiYw27RlxH2GByLRJ21fpr1vh
   EvUi9C6hciKxT6vFmDVljpwGKrPX1XO1CzXGbIILyjCy31nJgI1ju/TmM
   /Iec28Lx7q++dMS8UTRad/VC3oxVsHuoMi/NZ7H4DDkjx8JevHotaT4wZ
   yC23+hoXy5eY0g5YJhxv7uQymvY7GvXtNNQSyWzbT6fDBVQk1QcGOycmG
   I2+I5pb0Sr6xz1T0EbQwZPfweL2sRt7tUdnOgUrN4oONQXBgrW8DQx1Ka
   iBI96ewXwBO9GkkJ/inDQxrp8BhCRd02teJ3dLbrpN3TxjfejxVFeHNSO
   A==;
X-CSE-ConnectionGUID: nT3F1cWVTQe2SEPdO/Jamg==
X-CSE-MsgGUID: 6Zvys7D/R4KMzGi1I5HTwg==
X-IronPort-AV: E=McAfee;i="6800,10657,11507"; a="67278901"
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; 
   d="scan'208";a="67278901"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2025 09:08:33 -0700
X-CSE-ConnectionGUID: SBbWEAiZRyOfOsvt+jJbUg==
X-CSE-MsgGUID: JkZfOGKuS1KjE1EOxA2i8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; 
   d="scan'208";a="163812993"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by fmviesa010.fm.intel.com with ESMTP; 30 Jul 2025 09:08:29 -0700
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
Subject: [PATCH iwl-next v3 11/18] idpf: remove SW marker handling from NAPI
Date: Wed, 30 Jul 2025 18:07:10 +0200
Message-ID: <20250730160717.28976-12-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250730160717.28976-1-aleksander.lobakin@intel.com>
References: <20250730160717.28976-1-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michal Kubiak <michal.kubiak@intel.com>

SW marker descriptors on completion queues are used only when a queue
is about to be destroyed. It's far from hotpath and handling it in the
hotpath NAPI poll makes no sense.
Instead, run a simple poller after a virtchnl message for destroying
the queue is sent and wait for the replies. If replies for all of the
queues are received, this means the synchronization is done correctly
and we can go forth with stopping the link.

Signed-off-by: Michal Kubiak <michal.kubiak@intel.com>
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf.h        |  7 +-
 drivers/net/ethernet/intel/idpf/idpf_txrx.h   |  4 +-
 drivers/net/ethernet/intel/idpf/idpf_lib.c    |  2 -
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   | 97 ++++++++++++-------
 .../net/ethernet/intel/idpf/idpf_virtchnl.c   | 34 ++-----
 5 files changed, 72 insertions(+), 72 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf.h b/drivers/net/ethernet/intel/idpf/idpf.h
index f4c0eaf9bde3..d462568e7c29 100644
--- a/drivers/net/ethernet/intel/idpf/idpf.h
+++ b/drivers/net/ethernet/intel/idpf/idpf.h
@@ -40,6 +40,7 @@ struct idpf_vport_max_q;
 #define IDPF_NUM_CHUNKS_PER_MSG(struct_sz, chunk_sz)	\
 	((IDPF_CTLQ_MAX_BUF_LEN - (struct_sz)) / (chunk_sz))
 
+#define IDPF_WAIT_FOR_MARKER_TIMEO	500
 #define IDPF_MAX_WAIT			500
 
 /* available message levels */
@@ -246,13 +247,10 @@ enum idpf_vport_reset_cause {
 /**
  * enum idpf_vport_flags - Vport flags
  * @IDPF_VPORT_DEL_QUEUES: To send delete queues message
- * @IDPF_VPORT_SW_MARKER: Indicate TX pipe drain software marker packets
- *			  processing is done
  * @IDPF_VPORT_FLAGS_NBITS: Must be last
  */
 enum idpf_vport_flags {
 	IDPF_VPORT_DEL_QUEUES,
-	IDPF_VPORT_SW_MARKER,
 	IDPF_VPORT_FLAGS_NBITS,
 };
 
@@ -318,7 +316,6 @@ struct idpf_fsteer_fltr {
  * @tx_itr_profile: TX profiles for Dynamic Interrupt Moderation
  * @port_stats: per port csum, header split, and other offload stats
  * @link_up: True if link is up
- * @sw_marker_wq: workqueue for marker packets
  * @tx_tstamp_caps: Capabilities negotiated for Tx timestamping
  * @tstamp_config: The Tx tstamp config
  * @tstamp_task: Tx timestamping task
@@ -367,8 +364,6 @@ struct idpf_vport {
 
 	bool link_up;
 
-	wait_queue_head_t sw_marker_wq;
-
 	struct idpf_ptp_vport_tx_tstamp_caps *tx_tstamp_caps;
 	struct kernel_hwtstamp_config tstamp_config;
 	struct work_struct tstamp_task;
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.h b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
index 11a318fd48d4..1c570794e5bc 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
@@ -275,7 +275,6 @@ struct idpf_ptype_state {
  *			  bit and Q_RFL_GEN is the SW bit.
  * @__IDPF_Q_FLOW_SCH_EN: Enable flow scheduling
  * @__IDPF_Q_SW_MARKER: Used to indicate TX queue marker completions
- * @__IDPF_Q_POLL_MODE: Enable poll mode
  * @__IDPF_Q_CRC_EN: enable CRC offload in singleq mode
  * @__IDPF_Q_HSPLIT_EN: enable header split on Rx (splitq)
  * @__IDPF_Q_PTP: indicates whether the Rx timestamping is enabled for the
@@ -287,7 +286,6 @@ enum idpf_queue_flags_t {
 	__IDPF_Q_RFL_GEN_CHK,
 	__IDPF_Q_FLOW_SCH_EN,
 	__IDPF_Q_SW_MARKER,
-	__IDPF_Q_POLL_MODE,
 	__IDPF_Q_CRC_EN,
 	__IDPF_Q_HSPLIT_EN,
 	__IDPF_Q_PTP,
@@ -1036,4 +1034,6 @@ bool idpf_rx_singleq_buf_hw_alloc_all(struct idpf_rx_queue *rxq,
 				      u16 cleaned_count);
 int idpf_tso(struct sk_buff *skb, struct idpf_tx_offload_params *off);
 
+void idpf_wait_for_sw_marker_completion(const struct idpf_tx_queue *txq);
+
 #endif /* !_IDPF_TXRX_H_ */
diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
index da588d78846e..ba709663bfb5 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
@@ -1565,8 +1565,6 @@ void idpf_init_task(struct work_struct *work)
 	index = vport->idx;
 	vport_config = adapter->vport_config[index];
 
-	init_waitqueue_head(&vport->sw_marker_wq);
-
 	spin_lock_init(&vport_config->mac_filter_list_lock);
 
 	INIT_LIST_HEAD(&vport_config->user_config.mac_filter_list);
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index 8a7b58ae05d4..a98b37ca9443 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -1539,32 +1539,6 @@ int idpf_vport_queues_alloc(struct idpf_vport *vport)
 	return err;
 }
 
-/**
- * idpf_tx_handle_sw_marker - Handle queue marker packet
- * @tx_q: tx queue to handle software marker
- */
-static void idpf_tx_handle_sw_marker(struct idpf_tx_queue *tx_q)
-{
-	struct idpf_netdev_priv *priv = netdev_priv(tx_q->netdev);
-	struct idpf_vport *vport = priv->vport;
-	int i;
-
-	idpf_queue_clear(SW_MARKER, tx_q);
-	/* Hardware must write marker packets to all queues associated with
-	 * completion queues. So check if all queues received marker packets
-	 */
-	for (i = 0; i < vport->num_txq; i++)
-		/* If we're still waiting on any other TXQ marker completions,
-		 * just return now since we cannot wake up the marker_wq yet.
-		 */
-		if (idpf_queue_has(SW_MARKER, vport->txqs[i]))
-			return;
-
-	/* Drain complete */
-	set_bit(IDPF_VPORT_SW_MARKER, vport->flags);
-	wake_up(&vport->sw_marker_wq);
-}
-
 /**
  * idpf_tx_read_tstamp - schedule a work to read Tx timestamp value
  * @txq: queue to read the timestamp from
@@ -1812,9 +1786,6 @@ static bool idpf_tx_clean_complq(struct idpf_compl_queue *complq, int budget,
 			idpf_tx_handle_rs_completion(tx_q, tx_desc,
 						     &cleaned_stats, budget);
 			break;
-		case IDPF_TXD_COMPLT_SW_MARKER:
-			idpf_tx_handle_sw_marker(tx_q);
-			break;
 		default:
 			netdev_err(tx_q->netdev,
 				   "Unknown TX completion type: %d\n", ctype);
@@ -1886,6 +1857,66 @@ static bool idpf_tx_clean_complq(struct idpf_compl_queue *complq, int budget,
 	return !!complq_budget;
 }
 
+/**
+ * idpf_wait_for_sw_marker_completion - wait for SW marker of disabled Tx queue
+ * @txq: disabled Tx queue
+ *
+ * When Tx queue is requested for disabling, the CP sends a special completion
+ * descriptor called "SW marker", meaning the queue is ready to be destroyed.
+ * If, for some reason, the marker is not received within 500 ms, break the
+ * polling to not hang the driver.
+ */
+void idpf_wait_for_sw_marker_completion(const struct idpf_tx_queue *txq)
+{
+	struct idpf_compl_queue *complq = txq->txq_grp->complq;
+	u32 ntc = complq->next_to_clean;
+	unsigned long timeout;
+	bool flow, gen_flag;
+
+	if (!idpf_queue_has(SW_MARKER, txq))
+		return;
+
+	flow = idpf_queue_has(FLOW_SCH_EN, complq);
+	gen_flag = idpf_queue_has(GEN_CHK, complq);
+
+	timeout = jiffies + msecs_to_jiffies(IDPF_WAIT_FOR_MARKER_TIMEO);
+
+	do {
+		struct idpf_splitq_4b_tx_compl_desc *tx_desc;
+		struct idpf_tx_queue *target;
+		u32 ctype_gen, id;
+
+		tx_desc = flow ? &complq->comp[ntc].common :
+			  &complq->comp_4b[ntc];
+		ctype_gen = le16_to_cpu(tx_desc->qid_comptype_gen);
+
+		if (!!(ctype_gen & IDPF_TXD_COMPLQ_GEN_M) != gen_flag) {
+			usleep_range(500, 1000);
+			continue;
+		}
+
+		if (FIELD_GET(IDPF_TXD_COMPLQ_COMPL_TYPE_M, ctype_gen) !=
+		    IDPF_TXD_COMPLT_SW_MARKER)
+			goto next;
+
+		id = FIELD_GET(IDPF_TXD_COMPLQ_QID_M, ctype_gen);
+		target = complq->txq_grp->txqs[id];
+
+		idpf_queue_clear(SW_MARKER, target);
+		if (target == txq)
+			break;
+
+next:
+		if (unlikely(++ntc == complq->desc_count)) {
+			ntc = 0;
+			gen_flag = !gen_flag;
+		}
+	} while (time_before(jiffies, timeout));
+
+	idpf_queue_assign(GEN_CHK, complq, gen_flag);
+	complq->next_to_clean = ntc;
+}
+
 /**
  * idpf_tx_splitq_build_ctb - populate command tag and size for queue
  * based scheduling descriptors
@@ -3996,14 +4027,6 @@ static int idpf_vport_splitq_napi_poll(struct napi_struct *napi, int budget)
 		return budget;
 	}
 
-	/* Switch to poll mode in the tear-down path after sending disable
-	 * queues virtchnl message, as the interrupts will be disabled after
-	 * that.
-	 */
-	if (unlikely(q_vector->num_txq && idpf_queue_has(POLL_MODE,
-							 q_vector->tx[0])))
-		return budget;
-
 	work_done = min_t(int, work_done, budget - 1);
 
 	/* Exit the polling mode, but don't re-enable interrupts if stack might
diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
index c6aab401a09e..2be318c3f8e6 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -724,21 +724,17 @@ int idpf_recv_mb_msg(struct idpf_adapter *adapter)
  **/
 static int idpf_wait_for_marker_event(struct idpf_vport *vport)
 {
-	int event;
-	int i;
-
-	for (i = 0; i < vport->num_txq; i++)
-		idpf_queue_set(SW_MARKER, vport->txqs[i]);
+	bool markers_rcvd = true;
 
-	event = wait_event_timeout(vport->sw_marker_wq,
-				   test_and_clear_bit(IDPF_VPORT_SW_MARKER,
-						      vport->flags),
-				   msecs_to_jiffies(500));
+	for (u32 i = 0; i < vport->num_txq; i++) {
+		struct idpf_tx_queue *txq = vport->txqs[i];
 
-	for (i = 0; i < vport->num_txq; i++)
-		idpf_queue_clear(POLL_MODE, vport->txqs[i]);
+		idpf_queue_set(SW_MARKER, txq);
+		idpf_wait_for_sw_marker_completion(txq);
+		markers_rcvd &= !idpf_queue_has(SW_MARKER, txq);
+	}
 
-	if (event)
+	if (markers_rcvd)
 		return 0;
 
 	dev_warn(&vport->adapter->pdev->dev, "Failed to receive marker packets\n");
@@ -2137,24 +2133,12 @@ int idpf_send_enable_queues_msg(struct idpf_vport *vport)
  */
 int idpf_send_disable_queues_msg(struct idpf_vport *vport)
 {
-	int err, i;
+	int err;
 
 	err = idpf_send_ena_dis_queues_msg(vport, false);
 	if (err)
 		return err;
 
-	/* switch to poll mode as interrupts will be disabled after disable
-	 * queues virtchnl message is sent
-	 */
-	for (i = 0; i < vport->num_txq; i++)
-		idpf_queue_set(POLL_MODE, vport->txqs[i]);
-
-	/* schedule the napi to receive all the marker packets */
-	local_bh_disable();
-	for (i = 0; i < vport->num_q_vectors; i++)
-		napi_schedule(&vport->q_vectors[i].napi);
-	local_bh_enable();
-
 	return idpf_wait_for_marker_event(vport);
 }
 
-- 
2.50.1


