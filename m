Return-Path: <bpf+bounces-53361-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BD70A504B1
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 17:26:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 926F5175EF1
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 16:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5594253F08;
	Wed,  5 Mar 2025 16:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VxWlA9fF"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A05B253B72;
	Wed,  5 Mar 2025 16:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741191775; cv=none; b=etu6tm7S3L7Y7AG9/QQ4Jc42wcUBbhk33CZ4iyOpJZOS94hY8IKifOCoFK/ycJKvdNEvMiPXIv+vBRRHwsNswwtsuIt4md6HHmWe/rlSjLJVCPD47qxi4q303tCt2ZWyFqBKzEYKbIXMB7hYH9qe+sAozjm+Kt5mB0q/yT2wxYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741191775; c=relaxed/simple;
	bh=jAtB0tLqg0JPtfCVOOYuPPwRvYKrBGh2CUa45CqPy6I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lkXTpGEB6QwHDeWkkrYQpaO4s8uUsAEG+o7BoXvTL8n86wrtmjsGgKyXMELZ89PhN83RZq5KqovcITwpYXNqEQo8bwMBV5AV/qy1hXsLuVVqTwTPFH/izkDIBVUC5n5jygAErWn5VukIjlUyqnAcClCoTujjBJlJR+0UiHe/b5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VxWlA9fF; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741191774; x=1772727774;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jAtB0tLqg0JPtfCVOOYuPPwRvYKrBGh2CUa45CqPy6I=;
  b=VxWlA9fFlgH0PkczXi4YuRx4yKey3UkP/arkWTgf9KMO5Bx++RwJgSJL
   R9nAo/wwFaCzgy6Lqz2aWs0R5NjSSyeT+2M1pZvWZ9eQ2L9HkkYWr/ZuH
   r0sCpEl+YzPm6qUd1EOC7hSZBKxacGYrEei2/bngYTkxcDmXhYqSaxVTm
   tt65PYbH5TeCYmYCQGCfjIyb0s2HjSxoi9n/G9nviyOKjuHgvsV3dfBhE
   z21bBxn20pgDPT577SwplX9pD3I69oBhKcf4tcO0KGBqyiY12AtyW2mwE
   5U+y61L5vvaoshFaYswEBufnmxQY/sd5OBg5dwDBWeDntN/Y7qTAtMgOs
   w==;
X-CSE-ConnectionGUID: Pz9Ozup2QV2UNITa91NIYw==
X-CSE-MsgGUID: FHuXdaQiQyaadqh/Z8GFEw==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="42026516"
X-IronPort-AV: E=Sophos;i="6.14,223,1736841600"; 
   d="scan'208";a="42026516"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 08:22:53 -0800
X-CSE-ConnectionGUID: 8kUykrx6RAWBY587jKl6Sg==
X-CSE-MsgGUID: +z+I5N/3SgeprcYB8qy8MQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,223,1736841600"; 
   d="scan'208";a="123832921"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by fmviesa004.fm.intel.com with ESMTP; 05 Mar 2025 08:22:49 -0800
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
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Simon Horman <horms@kernel.org>,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 09/16] idpf: remove SW marker handling from NAPI
Date: Wed,  5 Mar 2025 17:21:25 +0100
Message-ID: <20250305162132.1106080-10-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305162132.1106080-1-aleksander.lobakin@intel.com>
References: <20250305162132.1106080-1-aleksander.lobakin@intel.com>
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
 drivers/net/ethernet/intel/idpf/idpf.h        |   7 +-
 drivers/net/ethernet/intel/idpf/idpf_txrx.h   |   4 +-
 drivers/net/ethernet/intel/idpf/idpf_lib.c    |   2 -
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   | 108 +++++++++++-------
 .../net/ethernet/intel/idpf/idpf_virtchnl.c   |  34 ++----
 5 files changed, 80 insertions(+), 75 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf.h b/drivers/net/ethernet/intel/idpf/idpf.h
index 66544faab710..6b51a5dcc1e0 100644
--- a/drivers/net/ethernet/intel/idpf/idpf.h
+++ b/drivers/net/ethernet/intel/idpf/idpf.h
@@ -36,6 +36,7 @@ struct idpf_vport_max_q;
 #define IDPF_NUM_CHUNKS_PER_MSG(struct_sz, chunk_sz)	\
 	((IDPF_CTLQ_MAX_BUF_LEN - (struct_sz)) / (chunk_sz))
 
+#define IDPF_WAIT_FOR_MARKER_TIMEO	500
 #define IDPF_MAX_WAIT			500
 
 /* available message levels */
@@ -224,13 +225,10 @@ enum idpf_vport_reset_cause {
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
 
@@ -289,7 +287,6 @@ struct idpf_port_stats {
  * @tx_itr_profile: TX profiles for Dynamic Interrupt Moderation
  * @port_stats: per port csum, header split, and other offload stats
  * @link_up: True if link is up
- * @sw_marker_wq: workqueue for marker packets
  */
 struct idpf_vport {
 	u16 num_txq;
@@ -332,8 +329,6 @@ struct idpf_vport {
 	struct idpf_port_stats port_stats;
 
 	bool link_up;
-
-	wait_queue_head_t sw_marker_wq;
 };
 
 /**
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.h b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
index 9f938301b2c5..dd6cc3b5cdab 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
@@ -286,7 +286,6 @@ struct idpf_ptype_state {
  *			  bit and Q_RFL_GEN is the SW bit.
  * @__IDPF_Q_FLOW_SCH_EN: Enable flow scheduling
  * @__IDPF_Q_SW_MARKER: Used to indicate TX queue marker completions
- * @__IDPF_Q_POLL_MODE: Enable poll mode
  * @__IDPF_Q_CRC_EN: enable CRC offload in singleq mode
  * @__IDPF_Q_HSPLIT_EN: enable header split on Rx (splitq)
  * @__IDPF_Q_FLAGS_NBITS: Must be last
@@ -296,7 +295,6 @@ enum idpf_queue_flags_t {
 	__IDPF_Q_RFL_GEN_CHK,
 	__IDPF_Q_FLOW_SCH_EN,
 	__IDPF_Q_SW_MARKER,
-	__IDPF_Q_POLL_MODE,
 	__IDPF_Q_CRC_EN,
 	__IDPF_Q_HSPLIT_EN,
 
@@ -1044,6 +1042,8 @@ bool idpf_rx_singleq_buf_hw_alloc_all(struct idpf_rx_queue *rxq,
 				      u16 cleaned_count);
 int idpf_tso(struct sk_buff *skb, struct idpf_tx_offload_params *off);
 
+void idpf_wait_for_sw_marker_completion(struct idpf_tx_queue *txq);
+
 static inline bool idpf_tx_maybe_stop_common(struct idpf_tx_queue *tx_q,
 					     u32 needed)
 {
diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
index f3aea7bcdaa3..e17582d15e27 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
@@ -1501,8 +1501,6 @@ void idpf_init_task(struct work_struct *work)
 	index = vport->idx;
 	vport_config = adapter->vport_config[index];
 
-	init_waitqueue_head(&vport->sw_marker_wq);
-
 	spin_lock_init(&vport_config->mac_filter_list_lock);
 
 	INIT_LIST_HEAD(&vport_config->user_config.mac_filter_list);
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index a240ed115e3e..4e3de6031422 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -1626,32 +1626,6 @@ int idpf_vport_queues_alloc(struct idpf_vport *vport)
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
  * idpf_tx_clean_stashed_bufs - clean bufs that were stored for
  * out of order completions
@@ -2008,6 +1982,19 @@ idpf_tx_handle_rs_cmpl_fb(struct idpf_tx_queue *txq,
 		idpf_tx_clean_stashed_bufs(txq, compl_tag, cleaned, budget);
 }
 
+/**
+ * idpf_tx_update_complq_indexes - update completion queue indexes
+ * @complq: completion queue being updated
+ * @ntc: current "next to clean" index value
+ * @gen_flag: current "generation" flag value
+ */
+static void idpf_tx_update_complq_indexes(struct idpf_compl_queue *complq,
+					  int ntc, bool gen_flag)
+{
+	complq->next_to_clean = ntc + complq->desc_count;
+	idpf_queue_assign(GEN_CHK, complq, gen_flag);
+}
+
 /**
  * idpf_tx_finalize_complq - Finalize completion queue cleaning
  * @complq: completion queue to finalize
@@ -2059,8 +2046,7 @@ static void idpf_tx_finalize_complq(struct idpf_compl_queue *complq, int ntc,
 		tx_q->cleaned_pkts = 0;
 	}
 
-	complq->next_to_clean = ntc + complq->desc_count;
-	idpf_queue_assign(GEN_CHK, complq, gen_flag);
+	idpf_tx_update_complq_indexes(complq, ntc, gen_flag);
 }
 
 /**
@@ -2115,9 +2101,6 @@ static bool idpf_tx_clean_complq(struct idpf_compl_queue *complq, int budget,
 							  &cleaned_stats,
 							  budget);
 			break;
-		case IDPF_TXD_COMPLT_SW_MARKER:
-			idpf_tx_handle_sw_marker(tx_q);
-			break;
 		case -ENODATA:
 			goto exit_clean_complq;
 		case -EINVAL:
@@ -2159,6 +2142,59 @@ static bool idpf_tx_clean_complq(struct idpf_compl_queue *complq, int budget,
 	return !!complq_budget;
 }
 
+/**
+ * idpf_wait_for_sw_marker_completion - wait for SW marker of disabled Tx queue
+ * @txq: disabled Tx queue
+ */
+void idpf_wait_for_sw_marker_completion(struct idpf_tx_queue *txq)
+{
+	struct idpf_compl_queue *complq = txq->txq_grp->complq;
+	struct idpf_splitq_4b_tx_compl_desc *tx_desc;
+	s16 ntc = complq->next_to_clean;
+	unsigned long timeout;
+	bool flow, gen_flag;
+	u32 pos = ntc;
+
+	if (!idpf_queue_has(SW_MARKER, txq))
+		return;
+
+	flow = idpf_queue_has(FLOW_SCH_EN, complq);
+	gen_flag = idpf_queue_has(GEN_CHK, complq);
+
+	timeout = jiffies + msecs_to_jiffies(IDPF_WAIT_FOR_MARKER_TIMEO);
+	tx_desc = flow ? &complq->comp[pos].common : &complq->comp_4b[pos];
+	ntc -= complq->desc_count;
+
+	do {
+		struct idpf_tx_queue *tx_q;
+		int ctype;
+
+		ctype = idpf_parse_compl_desc(tx_desc, complq, &tx_q,
+					      gen_flag);
+		if (ctype == IDPF_TXD_COMPLT_SW_MARKER) {
+			idpf_queue_clear(SW_MARKER, tx_q);
+			if (txq == tx_q)
+				break;
+		} else if (ctype == -ENODATA) {
+			usleep_range(500, 1000);
+			continue;
+		}
+
+		pos++;
+		ntc++;
+		if (unlikely(!ntc)) {
+			ntc -= complq->desc_count;
+			pos = 0;
+			gen_flag = !gen_flag;
+		}
+
+		tx_desc = flow ? &complq->comp[pos].common :
+			  &complq->comp_4b[pos];
+		prefetch(tx_desc);
+	} while (time_before(jiffies, timeout));
+
+	idpf_tx_update_complq_indexes(complq, ntc, gen_flag);
+}
 /**
  * idpf_tx_splitq_build_ctb - populate command tag and size for queue
  * based scheduling descriptors
@@ -4130,15 +4166,7 @@ static int idpf_vport_splitq_napi_poll(struct napi_struct *napi, int budget)
 	else
 		idpf_vport_intr_set_wb_on_itr(q_vector);
 
-	/* Switch to poll mode in the tear-down path after sending disable
-	 * queues virtchnl message, as the interrupts will be disabled after
-	 * that
-	 */
-	if (unlikely(q_vector->num_txq && idpf_queue_has(POLL_MODE,
-							 q_vector->tx[0])))
-		return budget;
-	else
-		return work_done;
+	return work_done;
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
index 135af3cc243f..24495e4d6c78 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -752,21 +752,17 @@ int idpf_recv_mb_msg(struct idpf_adapter *adapter)
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
@@ -1993,24 +1989,12 @@ int idpf_send_enable_queues_msg(struct idpf_vport *vport)
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
2.48.1


