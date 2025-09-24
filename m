Return-Path: <bpf+bounces-69590-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77E84B9B226
	for <lists+bpf@lfdr.de>; Wed, 24 Sep 2025 19:53:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED49B3B28E1
	for <lists+bpf@lfdr.de>; Wed, 24 Sep 2025 17:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 094C1319875;
	Wed, 24 Sep 2025 17:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fQzG2iwR"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 621B73164DF;
	Wed, 24 Sep 2025 17:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758736366; cv=none; b=aqIbzdwrOkJFzvI/D718sdlIpuGNZLlYogtKjhFYWobuLORXb1yLV4Cj3jjG+K4nLhFJTpZm343h1XxSgJ2kRPr9+47zXd6wpGJ55CHPUD8lstkEIFNCHxsGjxXerOytQeSFrQPp4Ple2+pyu42G4QJ14kCmQFPVU9no/Z9t8gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758736366; c=relaxed/simple;
	bh=pelRlHWSHaLysfZQ6P3DIQmu+VxHhlAbe8m1i/VlY9o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ay07YCLygiTEuiJuRGg6G+aaKspoXZ/2SkUAyqkxVDVIZr93YB7+0ViajTv2SJ01wER1qUkb1+/SyjmoInozCeInxLsE3oodopmkpFYf/Q+O0A7Xt8kZfJADZvcXuGXenTFcPLmHJS7zKpso2MgS0oj3y41CCjZTcQhdy6sPg7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fQzG2iwR; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758736364; x=1790272364;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pelRlHWSHaLysfZQ6P3DIQmu+VxHhlAbe8m1i/VlY9o=;
  b=fQzG2iwRePuHZtyfHKAsAdBqk7NemJ9H+ROArJuzS6ejChgegeJEtCCM
   GZNUeTB7vQGdw326/rwUWrMpic4IjmMjIX6+ToNx9ECJO2OZh5a1zdSYT
   G+sZ6AujPE/LuziNJV5wBvTF9L1HCNzjG6qYvYTGQYzawrYQSGQZ2pAV8
   9AEU466o/rbFi0yThEQis9wEtK8WCSe2o79P62bVD5LTJSc96iRtEPe0S
   QEKRJFyxv94JAGqorjUFZxidaN1UynxLwTTKkOslLln3JaN/XTA2JpohE
   yXQ5Vl6wGE8KwNsKU+LXlsVSW+5gWjEhtgUv/ffQvnlg/J0/a9mkW9Tfj
   Q==;
X-CSE-ConnectionGUID: 8/H15E7KSCuWEZXVgeJ4Wg==
X-CSE-MsgGUID: SHyUeW41TCeIX+DyyC4bHg==
X-IronPort-AV: E=McAfee;i="6800,10657,11563"; a="61152250"
X-IronPort-AV: E=Sophos;i="6.18,291,1751266800"; 
   d="scan'208";a="61152250"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2025 10:52:43 -0700
X-CSE-ConnectionGUID: ljK34OjCQ3iM0CS4t7w4kA==
X-CSE-MsgGUID: Q/6yDmN6TzClaC15iykfNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,291,1751266800"; 
   d="scan'208";a="176701847"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa007.fm.intel.com with ESMTP; 24 Sep 2025 10:52:41 -0700
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
Subject: [PATCH net-next 3/5] idpf: implement XSk xmit
Date: Wed, 24 Sep 2025 10:52:26 -0700
Message-ID: <20250924175230.1290529-4-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250924175230.1290529-1-anthony.l.nguyen@intel.com>
References: <20250924175230.1290529-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexander Lobakin <aleksander.lobakin@intel.com>

Implement the XSk transmit path using the libeth (libeth_xdp)
XSk infra.
When the NAPI poll is called, XSk Tx queues are polled first,
before regular Tx and Rx. They're generally faster to serve
and have higher priority comparing to regular traffic.

Co-developed-by: Michal Kubiak <michal.kubiak@intel.com>
Signed-off-by: Michal Kubiak <michal.kubiak@intel.com>
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Tested-by: Ramu R <ramu.r@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_txrx.c | 117 ++++++++--
 drivers/net/ethernet/intel/idpf/idpf_txrx.h |  14 +-
 drivers/net/ethernet/intel/idpf/xdp.c       |   2 +-
 drivers/net/ethernet/intel/idpf/xdp.h       |   1 +
 drivers/net/ethernet/intel/idpf/xsk.c       | 232 ++++++++++++++++++++
 drivers/net/ethernet/intel/idpf/xsk.h       |   9 +
 6 files changed, 354 insertions(+), 21 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index 542e09a83bc0..64d5211f6e51 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -5,6 +5,7 @@
 #include "idpf_ptp.h"
 #include "idpf_virtchnl.h"
 #include "xdp.h"
+#include "xsk.h"
 
 #define idpf_tx_buf_next(buf)		(*(u32 *)&(buf)->priv)
 LIBETH_SQE_CHECK_PRIV(u32);
@@ -53,11 +54,7 @@ void idpf_tx_timeout(struct net_device *netdev, unsigned int txqueue)
 	}
 }
 
-/**
- * idpf_tx_buf_rel_all - Free any empty Tx buffers
- * @txq: queue to be cleaned
- */
-static void idpf_tx_buf_rel_all(struct idpf_tx_queue *txq)
+static void idpf_tx_buf_clean(struct idpf_tx_queue *txq)
 {
 	struct libeth_sq_napi_stats ss = { };
 	struct xdp_frame_bulk bq;
@@ -66,19 +63,30 @@ static void idpf_tx_buf_rel_all(struct idpf_tx_queue *txq)
 		.bq	= &bq,
 		.ss	= &ss,
 	};
-	u32 i;
-
-	/* Buffers already cleared, nothing to do */
-	if (!txq->tx_buf)
-		return;
 
 	xdp_frame_bulk_init(&bq);
 
 	/* Free all the Tx buffer sk_buffs */
-	for (i = 0; i < txq->buf_pool_size; i++)
+	for (u32 i = 0; i < txq->buf_pool_size; i++)
 		libeth_tx_complete_any(&txq->tx_buf[i], &cp);
 
 	xdp_flush_frame_bulk(&bq);
+}
+
+/**
+ * idpf_tx_buf_rel_all - Free any empty Tx buffers
+ * @txq: queue to be cleaned
+ */
+static void idpf_tx_buf_rel_all(struct idpf_tx_queue *txq)
+{
+	/* Buffers already cleared, nothing to do */
+	if (!txq->tx_buf)
+		return;
+
+	if (idpf_queue_has(XSK, txq))
+		idpf_xsksq_clean(txq);
+	else
+		idpf_tx_buf_clean(txq);
 
 	kfree(txq->tx_buf);
 	txq->tx_buf = NULL;
@@ -102,6 +110,8 @@ static void idpf_tx_desc_rel(struct idpf_tx_queue *txq)
 	if (!xdp)
 		netdev_tx_reset_subqueue(txq->netdev, txq->idx);
 
+	idpf_xsk_clear_queue(txq, VIRTCHNL2_QUEUE_TYPE_TX);
+
 	if (!txq->desc_ring)
 		return;
 
@@ -122,6 +132,8 @@ static void idpf_tx_desc_rel(struct idpf_tx_queue *txq)
  */
 static void idpf_compl_desc_rel(struct idpf_compl_queue *complq)
 {
+	idpf_xsk_clear_queue(complq, VIRTCHNL2_QUEUE_TYPE_TX_COMPLETION);
+
 	if (!complq->comp)
 		return;
 
@@ -214,6 +226,8 @@ static int idpf_tx_desc_alloc(const struct idpf_vport *vport,
 	tx_q->next_to_clean = 0;
 	idpf_queue_set(GEN_CHK, tx_q);
 
+	idpf_xsk_setup_queue(vport, tx_q, VIRTCHNL2_QUEUE_TYPE_TX);
+
 	if (!idpf_queue_has(FLOW_SCH_EN, tx_q))
 		return 0;
 
@@ -273,6 +287,9 @@ static int idpf_compl_desc_alloc(const struct idpf_vport *vport,
 	complq->next_to_clean = 0;
 	idpf_queue_set(GEN_CHK, complq);
 
+	idpf_xsk_setup_queue(vport, complq,
+			     VIRTCHNL2_QUEUE_TYPE_TX_COMPLETION);
+
 	return 0;
 }
 
@@ -1077,13 +1094,13 @@ static void idpf_qvec_ena_irq(struct idpf_q_vector *qv)
 static struct idpf_queue_set *
 idpf_vector_to_queue_set(struct idpf_q_vector *qv)
 {
-	bool xdp = qv->vport->xdp_txq_offset;
+	bool xdp = qv->vport->xdp_txq_offset && !qv->num_xsksq;
 	struct idpf_vport *vport = qv->vport;
 	struct idpf_queue_set *qs;
 	u32 num;
 
 	num = qv->num_rxq + qv->num_bufq + qv->num_txq + qv->num_complq;
-	num += xdp ? qv->num_rxq * 2 : 0;
+	num += xdp ? qv->num_rxq * 2 : qv->num_xsksq * 2;
 	if (!num)
 		return NULL;
 
@@ -1126,6 +1143,14 @@ idpf_vector_to_queue_set(struct idpf_q_vector *qv)
 			qs->qs[num].type = VIRTCHNL2_QUEUE_TYPE_TX_COMPLETION;
 			qs->qs[num++].complq = vport->txqs[idx]->complq;
 		}
+	} else {
+		for (u32 i = 0; i < qv->num_xsksq; i++) {
+			qs->qs[num].type = VIRTCHNL2_QUEUE_TYPE_TX;
+			qs->qs[num++].txq = qv->xsksq[i];
+
+			qs->qs[num].type = VIRTCHNL2_QUEUE_TYPE_TX_COMPLETION;
+			qs->qs[num++].complq = qv->xsksq[i]->complq;
+		}
 	}
 
 finalize:
@@ -1152,6 +1177,29 @@ static int idpf_qp_enable(const struct idpf_queue_set *qs, u32 qid)
 		return err;
 	}
 
+	if (!vport->xdp_txq_offset)
+		goto config;
+
+	q_vector->xsksq = kcalloc(DIV_ROUND_UP(vport->num_rxq_grp,
+					       vport->num_q_vectors),
+				  sizeof(*q_vector->xsksq), GFP_KERNEL);
+	if (!q_vector->xsksq)
+		return -ENOMEM;
+
+	for (u32 i = 0; i < qs->num; i++) {
+		const struct idpf_queue_ptr *q = &qs->qs[i];
+
+		if (q->type != VIRTCHNL2_QUEUE_TYPE_TX)
+			continue;
+
+		if (!idpf_queue_has(XSK, q->txq))
+			continue;
+
+		q->txq->q_vector = q_vector;
+		q_vector->xsksq[q_vector->num_xsksq++] = q->txq;
+	}
+
+config:
 	err = idpf_send_config_queue_set_msg(qs);
 	if (err) {
 		netdev_err(vport->netdev, "Could not configure queues in pair %u: %pe\n",
@@ -1195,6 +1243,9 @@ static int idpf_qp_disable(const struct idpf_queue_set *qs, u32 qid)
 
 	idpf_clean_queue_set(qs);
 
+	kfree(q_vector->xsksq);
+	q_vector->num_xsksq = 0;
+
 	return 0;
 }
 
@@ -3690,7 +3741,7 @@ static irqreturn_t idpf_vport_intr_clean_queues(int __always_unused irq,
 	struct idpf_q_vector *q_vector = (struct idpf_q_vector *)data;
 
 	q_vector->total_events++;
-	napi_schedule(&q_vector->napi);
+	napi_schedule_irqoff(&q_vector->napi);
 
 	return IRQ_HANDLED;
 }
@@ -3731,6 +3782,8 @@ void idpf_vport_intr_rel(struct idpf_vport *vport)
 	for (u32 v_idx = 0; v_idx < vport->num_q_vectors; v_idx++) {
 		struct idpf_q_vector *q_vector = &vport->q_vectors[v_idx];
 
+		kfree(q_vector->xsksq);
+		q_vector->xsksq = NULL;
 		kfree(q_vector->complq);
 		q_vector->complq = NULL;
 		kfree(q_vector->bufq);
@@ -4214,7 +4267,7 @@ static int idpf_vport_splitq_napi_poll(struct napi_struct *napi, int budget)
 {
 	struct idpf_q_vector *q_vector =
 				container_of(napi, struct idpf_q_vector, napi);
-	bool clean_complete;
+	bool clean_complete = true;
 	int work_done = 0;
 
 	/* Handle case where we are called by netpoll with a budget of 0 */
@@ -4224,8 +4277,13 @@ static int idpf_vport_splitq_napi_poll(struct napi_struct *napi, int budget)
 		return 0;
 	}
 
-	clean_complete = idpf_rx_splitq_clean_all(q_vector, budget, &work_done);
-	clean_complete &= idpf_tx_splitq_clean_all(q_vector, budget, &work_done);
+	for (u32 i = 0; i < q_vector->num_xsksq; i++)
+		clean_complete &= idpf_xsk_xmit(q_vector->xsksq[i]);
+
+	clean_complete &= idpf_tx_splitq_clean_all(q_vector, budget,
+						   &work_done);
+	clean_complete &= idpf_rx_splitq_clean_all(q_vector, budget,
+						   &work_done);
 
 	/* If work not completed, return budget and polling will return */
 	if (!clean_complete) {
@@ -4238,7 +4296,7 @@ static int idpf_vport_splitq_napi_poll(struct napi_struct *napi, int budget)
 	/* Exit the polling mode, but don't re-enable interrupts if stack might
 	 * poll us due to busy-polling
 	 */
-	if (likely(napi_complete_done(napi, work_done)))
+	if (napi_complete_done(napi, work_done))
 		idpf_vport_intr_update_itr_ena_irq(q_vector);
 	else
 		idpf_vport_intr_set_wb_on_itr(q_vector);
@@ -4331,6 +4389,20 @@ static void idpf_vport_intr_map_vector_to_qs(struct idpf_vport *vport)
 
 		qv_idx++;
 	}
+
+	for (i = 0; i < vport->num_xdp_txq; i++) {
+		struct idpf_tx_queue *xdpsq;
+		struct idpf_q_vector *qv;
+
+		xdpsq = vport->txqs[vport->xdp_txq_offset + i];
+		if (!idpf_queue_has(XSK, xdpsq))
+			continue;
+
+		qv = idpf_find_rxq_vec(vport, i);
+
+		xdpsq->q_vector = qv;
+		qv->xsksq[qv->num_xsksq++] = xdpsq;
+	}
 }
 
 /**
@@ -4468,6 +4540,15 @@ int idpf_vport_intr_alloc(struct idpf_vport *vport)
 					   GFP_KERNEL);
 		if (!q_vector->complq)
 			goto error;
+
+		if (!vport->xdp_txq_offset)
+			continue;
+
+		q_vector->xsksq = kcalloc(rxqs_per_vector,
+					  sizeof(*q_vector->xsksq),
+					  GFP_KERNEL);
+		if (!q_vector->xsksq)
+			goto error;
 	}
 
 	return 0;
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.h b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
index 8faf33786747..e8e63027425c 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
@@ -285,6 +285,7 @@ struct idpf_ptype_state {
  *		  queue
  * @__IDPF_Q_NOIRQ: queue is polling-driven and has no interrupt
  * @__IDPF_Q_XDP: this is an XDP queue
+ * @__IDPF_Q_XSK: the queue has an XSk pool installed
  * @__IDPF_Q_FLAGS_NBITS: Must be last
  */
 enum idpf_queue_flags_t {
@@ -297,6 +298,7 @@ enum idpf_queue_flags_t {
 	__IDPF_Q_PTP,
 	__IDPF_Q_NOIRQ,
 	__IDPF_Q_XDP,
+	__IDPF_Q_XSK,
 
 	__IDPF_Q_FLAGS_NBITS,
 };
@@ -363,10 +365,12 @@ struct idpf_intr_reg {
  * @num_txq: Number of TX queues
  * @num_bufq: Number of buffer queues
  * @num_complq: number of completion queues
+ * @num_xsksq: number of XSk send queues
  * @rx: Array of RX queues to service
  * @tx: Array of TX queues to service
  * @bufq: Array of buffer queues to service
  * @complq: array of completion queues
+ * @xsksq: array of XSk send queues
  * @intr_reg: See struct idpf_intr_reg
  * @napi: napi handler
  * @total_events: Number of interrupts processed
@@ -389,10 +393,12 @@ struct idpf_q_vector {
 	u16 num_txq;
 	u16 num_bufq;
 	u16 num_complq;
+	u16 num_xsksq;
 	struct idpf_rx_queue **rx;
 	struct idpf_tx_queue **tx;
 	struct idpf_buf_queue **bufq;
 	struct idpf_compl_queue **complq;
+	struct idpf_tx_queue **xsksq;
 
 	struct idpf_intr_reg intr_reg;
 	__cacheline_group_end_aligned(read_mostly);
@@ -418,7 +424,7 @@ struct idpf_q_vector {
 
 	__cacheline_group_end_aligned(cold);
 };
-libeth_cacheline_set_assert(struct idpf_q_vector, 120,
+libeth_cacheline_set_assert(struct idpf_q_vector, 136,
 			    24 + sizeof(struct napi_struct) +
 			    2 * sizeof(struct dim),
 			    8);
@@ -578,6 +584,7 @@ libeth_cacheline_set_assert(struct idpf_rx_queue,
  * @txq_grp: See struct idpf_txq_group
  * @complq: corresponding completion queue in XDP mode
  * @dev: Device back pointer for DMA mapping
+ * @pool: corresponding XSk pool if installed
  * @tail: Tail offset. Used for both queue models single and split
  * @flags: See enum idpf_queue_flags_t
  * @idx: For TX queue, it is used as index to map between TX queue group and
@@ -631,7 +638,10 @@ struct idpf_tx_queue {
 		struct idpf_txq_group *txq_grp;
 		struct idpf_compl_queue *complq;
 	};
-	struct device *dev;
+	union {
+		struct device *dev;
+		struct xsk_buff_pool *pool;
+	};
 	void __iomem *tail;
 
 	DECLARE_BITMAP(flags, __IDPF_Q_FLAGS_NBITS);
diff --git a/drivers/net/ethernet/intel/idpf/xdp.c b/drivers/net/ethernet/intel/idpf/xdp.c
index 180335beaae1..2b8b75a16804 100644
--- a/drivers/net/ethernet/intel/idpf/xdp.c
+++ b/drivers/net/ethernet/intel/idpf/xdp.c
@@ -225,7 +225,7 @@ static int idpf_xdp_parse_cqe(const struct idpf_splitq_4b_tx_compl_desc *desc,
 	return upper_16_bits(val);
 }
 
-static u32 idpf_xdpsq_poll(struct idpf_tx_queue *xdpsq, u32 budget)
+u32 idpf_xdpsq_poll(struct idpf_tx_queue *xdpsq, u32 budget)
 {
 	struct idpf_compl_queue *cq = xdpsq->complq;
 	u32 tx_ntc = xdpsq->next_to_clean;
diff --git a/drivers/net/ethernet/intel/idpf/xdp.h b/drivers/net/ethernet/intel/idpf/xdp.h
index 59c0391317c2..479f5ef3c604 100644
--- a/drivers/net/ethernet/intel/idpf/xdp.h
+++ b/drivers/net/ethernet/intel/idpf/xdp.h
@@ -18,6 +18,7 @@ void idpf_xdp_copy_prog_to_rqs(const struct idpf_vport *vport,
 int idpf_xdpsqs_get(const struct idpf_vport *vport);
 void idpf_xdpsqs_put(const struct idpf_vport *vport);
 
+u32 idpf_xdpsq_poll(struct idpf_tx_queue *xdpsq, u32 budget);
 bool idpf_xdp_tx_flush_bulk(struct libeth_xdp_tx_bulk *bq, u32 flags);
 
 /**
diff --git a/drivers/net/ethernet/intel/idpf/xsk.c b/drivers/net/ethernet/intel/idpf/xsk.c
index 2098bf160df7..5c9f6f0a9fae 100644
--- a/drivers/net/ethernet/intel/idpf/xsk.c
+++ b/drivers/net/ethernet/intel/idpf/xsk.c
@@ -4,8 +4,240 @@
 #include <net/libeth/xsk.h>
 
 #include "idpf.h"
+#include "xdp.h"
 #include "xsk.h"
 
+static void idpf_xsk_tx_timer(struct work_struct *work);
+
+static void idpf_xsk_setup_txq(const struct idpf_vport *vport,
+			       struct idpf_tx_queue *txq)
+{
+	struct xsk_buff_pool *pool;
+	u32 qid;
+
+	idpf_queue_clear(XSK, txq);
+
+	if (!idpf_queue_has(XDP, txq))
+		return;
+
+	qid = txq->idx - vport->xdp_txq_offset;
+
+	pool = xsk_get_pool_from_qid(vport->netdev, qid);
+	if (!pool || !pool->dev)
+		return;
+
+	txq->pool = pool;
+	libeth_xdpsq_init_timer(txq->timer, txq, &txq->xdp_lock,
+				idpf_xsk_tx_timer);
+
+	idpf_queue_assign(NOIRQ, txq, xsk_uses_need_wakeup(pool));
+	idpf_queue_set(XSK, txq);
+}
+
+static void idpf_xsk_setup_complq(const struct idpf_vport *vport,
+				  struct idpf_compl_queue *complq)
+{
+	const struct xsk_buff_pool *pool;
+	u32 qid;
+
+	idpf_queue_clear(XSK, complq);
+
+	if (!idpf_queue_has(XDP, complq))
+		return;
+
+	qid = complq->txq_grp->txqs[0]->idx - vport->xdp_txq_offset;
+
+	pool = xsk_get_pool_from_qid(vport->netdev, qid);
+	if (!pool || !pool->dev)
+		return;
+
+	idpf_queue_set(XSK, complq);
+}
+
+void idpf_xsk_setup_queue(const struct idpf_vport *vport, void *q,
+			  enum virtchnl2_queue_type type)
+{
+	if (!idpf_xdp_enabled(vport))
+		return;
+
+	switch (type) {
+	case VIRTCHNL2_QUEUE_TYPE_TX:
+		idpf_xsk_setup_txq(vport, q);
+		break;
+	case VIRTCHNL2_QUEUE_TYPE_TX_COMPLETION:
+		idpf_xsk_setup_complq(vport, q);
+		break;
+	default:
+		break;
+	}
+}
+
+void idpf_xsk_clear_queue(void *q, enum virtchnl2_queue_type type)
+{
+	struct idpf_compl_queue *complq;
+	struct idpf_tx_queue *txq;
+
+	switch (type) {
+	case VIRTCHNL2_QUEUE_TYPE_TX:
+		txq = q;
+		if (!idpf_queue_has_clear(XSK, txq))
+			return;
+
+		idpf_queue_set(NOIRQ, txq);
+		txq->dev = txq->netdev->dev.parent;
+		break;
+	case VIRTCHNL2_QUEUE_TYPE_TX_COMPLETION:
+		complq = q;
+		idpf_queue_clear(XSK, complq);
+		break;
+	default:
+		break;
+	}
+}
+
+void idpf_xsksq_clean(struct idpf_tx_queue *xdpsq)
+{
+	struct libeth_xdpsq_napi_stats ss = { };
+	u32 ntc = xdpsq->next_to_clean;
+	struct xdp_frame_bulk bq;
+	struct libeth_cq_pp cp = {
+		.dev	= xdpsq->pool->dev,
+		.bq	= &bq,
+		.xss	= &ss,
+	};
+	u32 xsk_frames = 0;
+
+	xdp_frame_bulk_init(&bq);
+
+	while (ntc != xdpsq->next_to_use) {
+		struct libeth_sqe *sqe = &xdpsq->tx_buf[ntc];
+
+		if (sqe->type)
+			libeth_xdp_complete_tx(sqe, &cp);
+		else
+			xsk_frames++;
+
+		if (unlikely(++ntc == xdpsq->desc_count))
+			ntc = 0;
+	}
+
+	xdp_flush_frame_bulk(&bq);
+
+	if (xsk_frames)
+		xsk_tx_completed(xdpsq->pool, xsk_frames);
+}
+
+static noinline u32 idpf_xsksq_complete_slow(struct idpf_tx_queue *xdpsq,
+					     u32 done)
+{
+	struct libeth_xdpsq_napi_stats ss = { };
+	u32 ntc = xdpsq->next_to_clean;
+	u32 cnt = xdpsq->desc_count;
+	struct xdp_frame_bulk bq;
+	struct libeth_cq_pp cp = {
+		.dev	= xdpsq->pool->dev,
+		.bq	= &bq,
+		.xss	= &ss,
+		.napi	= true,
+	};
+	u32 xsk_frames = 0;
+
+	xdp_frame_bulk_init(&bq);
+
+	for (u32 i = 0; likely(i < done); i++) {
+		struct libeth_sqe *sqe = &xdpsq->tx_buf[ntc];
+
+		if (sqe->type)
+			libeth_xdp_complete_tx(sqe, &cp);
+		else
+			xsk_frames++;
+
+		if (unlikely(++ntc == cnt))
+			ntc = 0;
+	}
+
+	xdp_flush_frame_bulk(&bq);
+
+	xdpsq->next_to_clean = ntc;
+	xdpsq->xdp_tx -= cp.xdp_tx;
+
+	return xsk_frames;
+}
+
+static __always_inline u32 idpf_xsksq_complete(void *_xdpsq, u32 budget)
+{
+	struct idpf_tx_queue *xdpsq = _xdpsq;
+	u32 tx_ntc = xdpsq->next_to_clean;
+	u32 tx_cnt = xdpsq->desc_count;
+	u32 done_frames;
+	u32 xsk_frames;
+
+	done_frames = idpf_xdpsq_poll(xdpsq, budget);
+	if (unlikely(!done_frames))
+		return 0;
+
+	if (likely(!xdpsq->xdp_tx)) {
+		tx_ntc += done_frames;
+		if (tx_ntc >= tx_cnt)
+			tx_ntc -= tx_cnt;
+
+		xdpsq->next_to_clean = tx_ntc;
+		xsk_frames = done_frames;
+
+		goto finalize;
+	}
+
+	xsk_frames = idpf_xsksq_complete_slow(xdpsq, done_frames);
+	if (xsk_frames)
+finalize:
+		xsk_tx_completed(xdpsq->pool, xsk_frames);
+
+	xdpsq->pending -= done_frames;
+
+	return done_frames;
+}
+
+static u32 idpf_xsk_xmit_prep(void *_xdpsq, struct libeth_xdpsq *sq)
+{
+	struct idpf_tx_queue *xdpsq = _xdpsq;
+
+	*sq = (struct libeth_xdpsq){
+		.pool		= xdpsq->pool,
+		.sqes		= xdpsq->tx_buf,
+		.descs		= xdpsq->desc_ring,
+		.count		= xdpsq->desc_count,
+		.lock		= &xdpsq->xdp_lock,
+		.ntu		= &xdpsq->next_to_use,
+		.pending	= &xdpsq->pending,
+	};
+
+	/*
+	 * The queue is cleaned, the budget is already known, optimize out
+	 * the second min() by passing the type limit.
+	 */
+	return U32_MAX;
+}
+
+bool idpf_xsk_xmit(struct idpf_tx_queue *xsksq)
+{
+	u32 free;
+
+	libeth_xdpsq_lock(&xsksq->xdp_lock);
+
+	free = xsksq->desc_count - xsksq->pending;
+	if (free < xsksq->thresh)
+		free += idpf_xsksq_complete(xsksq, xsksq->thresh);
+
+	return libeth_xsk_xmit_do_bulk(xsksq->pool, xsksq,
+				       min(free - 1, xsksq->thresh),
+				       libeth_xsktmo, idpf_xsk_xmit_prep,
+				       idpf_xdp_tx_xmit, idpf_xdp_tx_finalize);
+}
+
+LIBETH_XDP_DEFINE_START();
+LIBETH_XDP_DEFINE_TIMER(static idpf_xsk_tx_timer, idpf_xsksq_complete);
+LIBETH_XDP_DEFINE_END();
+
 int idpf_xsk_pool_setup(struct idpf_vport *vport, struct netdev_bpf *bpf)
 {
 	struct xsk_buff_pool *pool = bpf->xsk.pool;
diff --git a/drivers/net/ethernet/intel/idpf/xsk.h b/drivers/net/ethernet/intel/idpf/xsk.h
index dc42268ba8e0..d08fd51b0fc6 100644
--- a/drivers/net/ethernet/intel/idpf/xsk.h
+++ b/drivers/net/ethernet/intel/idpf/xsk.h
@@ -6,9 +6,18 @@
 
 #include <linux/types.h>
 
+enum virtchnl2_queue_type;
+struct idpf_tx_queue;
 struct idpf_vport;
 struct netdev_bpf;
 
+void idpf_xsk_setup_queue(const struct idpf_vport *vport, void *q,
+			  enum virtchnl2_queue_type type);
+void idpf_xsk_clear_queue(void *q, enum virtchnl2_queue_type type);
+
+void idpf_xsksq_clean(struct idpf_tx_queue *xdpq);
+bool idpf_xsk_xmit(struct idpf_tx_queue *xsksq);
+
 int idpf_xsk_pool_setup(struct idpf_vport *vport, struct netdev_bpf *xdp);
 
 #endif /* !_IDPF_XSK_H_ */
-- 
2.47.1


