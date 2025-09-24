Return-Path: <bpf+bounces-69588-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 660C5B9B211
	for <lists+bpf@lfdr.de>; Wed, 24 Sep 2025 19:52:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 409813AD0E5
	for <lists+bpf@lfdr.de>; Wed, 24 Sep 2025 17:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B01DE3168F6;
	Wed, 24 Sep 2025 17:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WWePyyCe"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3375A314B71;
	Wed, 24 Sep 2025 17:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758736364; cv=none; b=fiCT3N2Zdbi+4pFdfkaWzEhBktn2A6Gk0T6YfSdjsDbp/8XcgyDF2jVGY2XgKMQBehZa4ol1sBDi26qz5JHAHd/mh2r+xsljoS7Eqb25hukX8XPrqxEWz7bhfhVop/XQwPXcYwIptLAXTZmm90CDlCm/LOnavSTyM772EeNmNkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758736364; c=relaxed/simple;
	bh=DYdqntyTqVvDyc13NbUh/Nbd4jwp0QswbgQfDeAmWns=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M6ykEfT5B1Y5UFEB2YqO6x+hX6WKoYuH7ET14W1jfuDPDkNrbA+vdBa7hkgrSYaU8TmiMGpiWJjJw9YADQvimdh/yw6UijiXuYnLPZZuGz2NHfXmEiF46PnqhTMb1d08by5NiGRojEmPDGxH673jsgZYmYK8ZMCPu60XspYkP5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WWePyyCe; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758736362; x=1790272362;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DYdqntyTqVvDyc13NbUh/Nbd4jwp0QswbgQfDeAmWns=;
  b=WWePyyCet46U8D7zlmF7++ltdcILmoYTQBv6oi5xNMwSC4oIRzeyEnrU
   v9OUUT++2LmH589BRdRByjWAJvhxsUKpEDYb0x3wqqlIl+WOpaA4YEhZP
   FdM+rMamgl2HdUOq3SCwLt6NtD9rZKSNi0tu8MmrBM7V7Bjxa+n7golfZ
   ZMZqojZAasutI4MRonv2WdvQA1sqXu31lKHM4C+JcmdMfV8kokS742rjs
   7+m30rrNft6I5r7Nu4AGIS/X8BgNKhRBMH60IGah/SgF5FPX8/kEwUEUf
   G1vKkCgElsj3uZgCPcOk5Cm9EIdrU0lUy1ANbReFmWBHgK506Ir1JLv4+
   w==;
X-CSE-ConnectionGUID: hys46h6lRjiFh4HTAbJSJA==
X-CSE-MsgGUID: Y2iBXQaFSjC5G8tNEr8cXg==
X-IronPort-AV: E=McAfee;i="6800,10657,11563"; a="61152234"
X-IronPort-AV: E=Sophos;i="6.18,291,1751266800"; 
   d="scan'208";a="61152234"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2025 10:52:42 -0700
X-CSE-ConnectionGUID: 1iceT8pyRxiBnfvG8qmkow==
X-CSE-MsgGUID: 5Wbeq2yFSbmLpkXae4X9aA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,291,1751266800"; 
   d="scan'208";a="176701843"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa007.fm.intel.com with ESMTP; 24 Sep 2025 10:52:40 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Michal Kubiak <michal.kubiak@intel.com>,
	anthony.l.nguyen@intel.com,
	aleksander.lobakin@intel.com,
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
Subject: [PATCH net-next 2/5] idpf: add XSk pool initialization
Date: Wed, 24 Sep 2025 10:52:25 -0700
Message-ID: <20250924175230.1290529-3-anthony.l.nguyen@intel.com>
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

From: Michal Kubiak <michal.kubiak@intel.com>

Add functionality to setup an XSk buffer pool, including ability to
stop, reconfig and start only selected queues, not the whole device.
Pool DMA mapping is managed by libeth_xdp.

Signed-off-by: Michal Kubiak <michal.kubiak@intel.com>
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Tested-by: Ramu R <ramu.r@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/idpf/Makefile      |   1 +
 .../net/ethernet/intel/idpf/idpf_ethtool.c    |   8 +-
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   | 299 ++++++++++++++++++
 drivers/net/ethernet/intel/idpf/idpf_txrx.h   |   7 +
 drivers/net/ethernet/intel/idpf/xdp.c         |  14 +
 drivers/net/ethernet/intel/idpf/xdp.h         |   2 +
 drivers/net/ethernet/intel/idpf/xsk.c         |  57 ++++
 drivers/net/ethernet/intel/idpf/xsk.h         |  14 +
 8 files changed, 398 insertions(+), 4 deletions(-)
 create mode 100644 drivers/net/ethernet/intel/idpf/xsk.c
 create mode 100644 drivers/net/ethernet/intel/idpf/xsk.h

diff --git a/drivers/net/ethernet/intel/idpf/Makefile b/drivers/net/ethernet/intel/idpf/Makefile
index 0840c3bef371..651ddee942bd 100644
--- a/drivers/net/ethernet/intel/idpf/Makefile
+++ b/drivers/net/ethernet/intel/idpf/Makefile
@@ -23,3 +23,4 @@ idpf-$(CONFIG_PTP_1588_CLOCK)	+= idpf_ptp.o
 idpf-$(CONFIG_PTP_1588_CLOCK)	+= idpf_virtchnl_ptp.o
 
 idpf-y				+= xdp.o
+idpf-y				+= xsk.o
diff --git a/drivers/net/ethernet/intel/idpf/idpf_ethtool.c b/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
index 786d0bacdd3c..a5a1eec9ade8 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
@@ -1245,8 +1245,8 @@ static void idpf_get_ethtool_stats(struct net_device *netdev,
  *
  * returns pointer to rx vector
  */
-static struct idpf_q_vector *idpf_find_rxq_vec(const struct idpf_vport *vport,
-					       int q_num)
+struct idpf_q_vector *idpf_find_rxq_vec(const struct idpf_vport *vport,
+					u32 q_num)
 {
 	int q_grp, q_idx;
 
@@ -1266,8 +1266,8 @@ static struct idpf_q_vector *idpf_find_rxq_vec(const struct idpf_vport *vport,
  *
  * returns pointer to tx vector
  */
-static struct idpf_q_vector *idpf_find_txq_vec(const struct idpf_vport *vport,
-					       int q_num)
+struct idpf_q_vector *idpf_find_txq_vec(const struct idpf_vport *vport,
+					u32 q_num)
 {
 	int q_grp;
 
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index 81b6646dd3fc..542e09a83bc0 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -922,6 +922,305 @@ static int idpf_rx_desc_alloc_all(struct idpf_vport *vport)
 	return err;
 }
 
+static int idpf_init_queue_set(const struct idpf_queue_set *qs)
+{
+	const struct idpf_vport *vport = qs->vport;
+	bool splitq;
+	int err;
+
+	splitq = idpf_is_queue_model_split(vport->rxq_model);
+
+	for (u32 i = 0; i < qs->num; i++) {
+		const struct idpf_queue_ptr *q = &qs->qs[i];
+		struct idpf_buf_queue *bufq;
+
+		switch (q->type) {
+		case VIRTCHNL2_QUEUE_TYPE_RX:
+			err = idpf_rx_desc_alloc(vport, q->rxq);
+			if (err)
+				break;
+
+			err = idpf_xdp_rxq_info_init(q->rxq);
+			if (err)
+				break;
+
+			if (!splitq)
+				err = idpf_rx_bufs_init_singleq(q->rxq);
+
+			break;
+		case VIRTCHNL2_QUEUE_TYPE_RX_BUFFER:
+			bufq = q->bufq;
+
+			err = idpf_bufq_desc_alloc(vport, bufq);
+			if (err)
+				break;
+
+			for (u32 j = 0; j < bufq->q_vector->num_bufq; j++) {
+				struct idpf_buf_queue * const *bufqs;
+				enum libeth_fqe_type type;
+				u32 ts;
+
+				bufqs = bufq->q_vector->bufq;
+				if (bufqs[j] != bufq)
+					continue;
+
+				if (j) {
+					type = LIBETH_FQE_SHORT;
+					ts = bufqs[j - 1]->truesize >> 1;
+				} else {
+					type = LIBETH_FQE_MTU;
+					ts = 0;
+				}
+
+				bufq->truesize = ts;
+
+				err = idpf_rx_bufs_init(bufq, type);
+				break;
+			}
+
+			break;
+		case VIRTCHNL2_QUEUE_TYPE_TX:
+			err = idpf_tx_desc_alloc(vport, q->txq);
+			break;
+		case VIRTCHNL2_QUEUE_TYPE_TX_COMPLETION:
+			err = idpf_compl_desc_alloc(vport, q->complq);
+			break;
+		default:
+			continue;
+		}
+
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
+static void idpf_clean_queue_set(const struct idpf_queue_set *qs)
+{
+	const struct idpf_vport *vport = qs->vport;
+	struct device *dev = vport->netdev->dev.parent;
+
+	for (u32 i = 0; i < qs->num; i++) {
+		const struct idpf_queue_ptr *q = &qs->qs[i];
+
+		switch (q->type) {
+		case VIRTCHNL2_QUEUE_TYPE_RX:
+			idpf_xdp_rxq_info_deinit(q->rxq, vport->rxq_model);
+			idpf_rx_desc_rel(q->rxq, dev, vport->rxq_model);
+			break;
+		case VIRTCHNL2_QUEUE_TYPE_RX_BUFFER:
+			idpf_rx_desc_rel_bufq(q->bufq, dev);
+			break;
+		case VIRTCHNL2_QUEUE_TYPE_TX:
+			idpf_tx_desc_rel(q->txq);
+
+			if (idpf_queue_has(XDP, q->txq)) {
+				q->txq->pending = 0;
+				q->txq->xdp_tx = 0;
+			} else {
+				q->txq->txq_grp->num_completions_pending = 0;
+			}
+
+			writel(q->txq->next_to_use, q->txq->tail);
+			break;
+		case VIRTCHNL2_QUEUE_TYPE_TX_COMPLETION:
+			idpf_compl_desc_rel(q->complq);
+			q->complq->num_completions = 0;
+			break;
+		default:
+			break;
+		}
+	}
+}
+
+static void idpf_qvec_ena_irq(struct idpf_q_vector *qv)
+{
+	if (qv->num_txq) {
+		u32 itr;
+
+		if (IDPF_ITR_IS_DYNAMIC(qv->tx_intr_mode))
+			itr = qv->vport->tx_itr_profile[qv->tx_dim.profile_ix];
+		else
+			itr = qv->tx_itr_value;
+
+		idpf_vport_intr_write_itr(qv, itr, true);
+	}
+
+	if (qv->num_rxq) {
+		u32 itr;
+
+		if (IDPF_ITR_IS_DYNAMIC(qv->rx_intr_mode))
+			itr = qv->vport->rx_itr_profile[qv->rx_dim.profile_ix];
+		else
+			itr = qv->rx_itr_value;
+
+		idpf_vport_intr_write_itr(qv, itr, false);
+	}
+
+	if (qv->num_txq || qv->num_rxq)
+		idpf_vport_intr_update_itr_ena_irq(qv);
+}
+
+/**
+ * idpf_vector_to_queue_set - create a queue set associated with the given
+ *			      queue vector
+ * @qv: queue vector corresponding to the queue pair
+ *
+ * Returns a pointer to a dynamically allocated array of pointers to all
+ * queues associated with a given queue vector (@qv).
+ * Please note that the caller is responsible to free the memory allocated
+ * by this function using kfree().
+ *
+ * Return: &idpf_queue_set on success, %NULL in case of error.
+ */
+static struct idpf_queue_set *
+idpf_vector_to_queue_set(struct idpf_q_vector *qv)
+{
+	bool xdp = qv->vport->xdp_txq_offset;
+	struct idpf_vport *vport = qv->vport;
+	struct idpf_queue_set *qs;
+	u32 num;
+
+	num = qv->num_rxq + qv->num_bufq + qv->num_txq + qv->num_complq;
+	num += xdp ? qv->num_rxq * 2 : 0;
+	if (!num)
+		return NULL;
+
+	qs = idpf_alloc_queue_set(vport, num);
+	if (!qs)
+		return NULL;
+
+	num = 0;
+
+	for (u32 i = 0; i < qv->num_bufq; i++) {
+		qs->qs[num].type = VIRTCHNL2_QUEUE_TYPE_RX_BUFFER;
+		qs->qs[num++].bufq = qv->bufq[i];
+	}
+
+	for (u32 i = 0; i < qv->num_rxq; i++) {
+		qs->qs[num].type = VIRTCHNL2_QUEUE_TYPE_RX;
+		qs->qs[num++].rxq = qv->rx[i];
+	}
+
+	for (u32 i = 0; i < qv->num_txq; i++) {
+		qs->qs[num].type = VIRTCHNL2_QUEUE_TYPE_TX;
+		qs->qs[num++].txq = qv->tx[i];
+	}
+
+	for (u32 i = 0; i < qv->num_complq; i++) {
+		qs->qs[num].type = VIRTCHNL2_QUEUE_TYPE_TX_COMPLETION;
+		qs->qs[num++].complq = qv->complq[i];
+	}
+
+	if (!vport->xdp_txq_offset)
+		goto finalize;
+
+	if (xdp) {
+		for (u32 i = 0; i < qv->num_rxq; i++) {
+			u32 idx = vport->xdp_txq_offset + qv->rx[i]->idx;
+
+			qs->qs[num].type = VIRTCHNL2_QUEUE_TYPE_TX;
+			qs->qs[num++].txq = vport->txqs[idx];
+
+			qs->qs[num].type = VIRTCHNL2_QUEUE_TYPE_TX_COMPLETION;
+			qs->qs[num++].complq = vport->txqs[idx]->complq;
+		}
+	}
+
+finalize:
+	if (num != qs->num) {
+		kfree(qs);
+		return NULL;
+	}
+
+	return qs;
+}
+
+static int idpf_qp_enable(const struct idpf_queue_set *qs, u32 qid)
+{
+	struct idpf_vport *vport = qs->vport;
+	struct idpf_q_vector *q_vector;
+	int err;
+
+	q_vector = idpf_find_rxq_vec(vport, qid);
+
+	err = idpf_init_queue_set(qs);
+	if (err) {
+		netdev_err(vport->netdev, "Could not initialize queues in pair %u: %pe\n",
+			   qid, ERR_PTR(err));
+		return err;
+	}
+
+	err = idpf_send_config_queue_set_msg(qs);
+	if (err) {
+		netdev_err(vport->netdev, "Could not configure queues in pair %u: %pe\n",
+			   qid, ERR_PTR(err));
+		return err;
+	}
+
+	err = idpf_send_enable_queue_set_msg(qs);
+	if (err) {
+		netdev_err(vport->netdev, "Could not enable queues in pair %u: %pe\n",
+			   qid, ERR_PTR(err));
+		return err;
+	}
+
+	napi_enable(&q_vector->napi);
+	idpf_qvec_ena_irq(q_vector);
+
+	netif_start_subqueue(vport->netdev, qid);
+
+	return 0;
+}
+
+static int idpf_qp_disable(const struct idpf_queue_set *qs, u32 qid)
+{
+	struct idpf_vport *vport = qs->vport;
+	struct idpf_q_vector *q_vector;
+	int err;
+
+	q_vector = idpf_find_rxq_vec(vport, qid);
+	netif_stop_subqueue(vport->netdev, qid);
+
+	writel(0, q_vector->intr_reg.dyn_ctl);
+	napi_disable(&q_vector->napi);
+
+	err = idpf_send_disable_queue_set_msg(qs);
+	if (err) {
+		netdev_err(vport->netdev, "Could not disable queues in pair %u: %pe\n",
+			   qid, ERR_PTR(err));
+		return err;
+	}
+
+	idpf_clean_queue_set(qs);
+
+	return 0;
+}
+
+/**
+ * idpf_qp_switch - enable or disable queues associated with queue pair
+ * @vport: vport to switch the pair for
+ * @qid: index of the queue pair to switch
+ * @en: whether to enable or disable the pair
+ *
+ * Return: 0 on success, -errno on failure.
+ */
+int idpf_qp_switch(struct idpf_vport *vport, u32 qid, bool en)
+{
+	struct idpf_q_vector *q_vector = idpf_find_rxq_vec(vport, qid);
+	struct idpf_queue_set *qs __free(kfree) = NULL;
+
+	if (idpf_find_txq_vec(vport, qid) != q_vector)
+		return -EINVAL;
+
+	qs = idpf_vector_to_queue_set(q_vector);
+	if (!qs)
+		return -ENOMEM;
+
+	return en ? idpf_qp_enable(qs, qid) : idpf_qp_disable(qs, qid);
+}
+
 /**
  * idpf_txq_group_rel - Release all resources for txq groups
  * @vport: vport to release txq groups on
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.h b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
index 88dc3db488b1..8faf33786747 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
@@ -1050,6 +1050,13 @@ int idpf_config_rss(struct idpf_vport *vport);
 int idpf_init_rss(struct idpf_vport *vport);
 void idpf_deinit_rss(struct idpf_vport *vport);
 int idpf_rx_bufs_init_all(struct idpf_vport *vport);
+
+struct idpf_q_vector *idpf_find_rxq_vec(const struct idpf_vport *vport,
+					u32 q_num);
+struct idpf_q_vector *idpf_find_txq_vec(const struct idpf_vport *vport,
+					u32 q_num);
+int idpf_qp_switch(struct idpf_vport *vport, u32 qid, bool en);
+
 void idpf_tx_buf_hw_update(struct idpf_tx_queue *tx_q, u32 val,
 			   bool xmit_more);
 unsigned int idpf_size_to_txd_count(unsigned int size);
diff --git a/drivers/net/ethernet/intel/idpf/xdp.c b/drivers/net/ethernet/intel/idpf/xdp.c
index 89d5735f42f2..180335beaae1 100644
--- a/drivers/net/ethernet/intel/idpf/xdp.c
+++ b/drivers/net/ethernet/intel/idpf/xdp.c
@@ -4,6 +4,7 @@
 #include "idpf.h"
 #include "idpf_virtchnl.h"
 #include "xdp.h"
+#include "xsk.h"
 
 static int idpf_rxq_for_each(const struct idpf_vport *vport,
 			     int (*fn)(struct idpf_rx_queue *rxq, void *arg),
@@ -66,6 +67,11 @@ static int __idpf_xdp_rxq_info_init(struct idpf_rx_queue *rxq, void *arg)
 	return 0;
 }
 
+int idpf_xdp_rxq_info_init(struct idpf_rx_queue *rxq)
+{
+	return __idpf_xdp_rxq_info_init(rxq, NULL);
+}
+
 int idpf_xdp_rxq_info_init_all(const struct idpf_vport *vport)
 {
 	return idpf_rxq_for_each(vport, __idpf_xdp_rxq_info_init, NULL);
@@ -84,6 +90,11 @@ static int __idpf_xdp_rxq_info_deinit(struct idpf_rx_queue *rxq, void *arg)
 	return 0;
 }
 
+void idpf_xdp_rxq_info_deinit(struct idpf_rx_queue *rxq, u32 model)
+{
+	__idpf_xdp_rxq_info_deinit(rxq, (void *)(size_t)model);
+}
+
 void idpf_xdp_rxq_info_deinit_all(const struct idpf_vport *vport)
 {
 	idpf_rxq_for_each(vport, __idpf_xdp_rxq_info_deinit,
@@ -442,6 +453,9 @@ int idpf_xdp(struct net_device *dev, struct netdev_bpf *xdp)
 	case XDP_SETUP_PROG:
 		ret = idpf_xdp_setup_prog(vport, xdp);
 		break;
+	case XDP_SETUP_XSK_POOL:
+		ret = idpf_xsk_pool_setup(vport, xdp);
+		break;
 	default:
 notsupp:
 		ret = -EOPNOTSUPP;
diff --git a/drivers/net/ethernet/intel/idpf/xdp.h b/drivers/net/ethernet/intel/idpf/xdp.h
index 66ad83a0e85e..59c0391317c2 100644
--- a/drivers/net/ethernet/intel/idpf/xdp.h
+++ b/drivers/net/ethernet/intel/idpf/xdp.h
@@ -8,7 +8,9 @@
 
 #include "idpf_txrx.h"
 
+int idpf_xdp_rxq_info_init(struct idpf_rx_queue *rxq);
 int idpf_xdp_rxq_info_init_all(const struct idpf_vport *vport);
+void idpf_xdp_rxq_info_deinit(struct idpf_rx_queue *rxq, u32 model);
 void idpf_xdp_rxq_info_deinit_all(const struct idpf_vport *vport);
 void idpf_xdp_copy_prog_to_rqs(const struct idpf_vport *vport,
 			       struct bpf_prog *xdp_prog);
diff --git a/drivers/net/ethernet/intel/idpf/xsk.c b/drivers/net/ethernet/intel/idpf/xsk.c
new file mode 100644
index 000000000000..2098bf160df7
--- /dev/null
+++ b/drivers/net/ethernet/intel/idpf/xsk.c
@@ -0,0 +1,57 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (C) 2025 Intel Corporation */
+
+#include <net/libeth/xsk.h>
+
+#include "idpf.h"
+#include "xsk.h"
+
+int idpf_xsk_pool_setup(struct idpf_vport *vport, struct netdev_bpf *bpf)
+{
+	struct xsk_buff_pool *pool = bpf->xsk.pool;
+	u32 qid = bpf->xsk.queue_id;
+	bool restart;
+	int ret;
+
+	restart = idpf_xdp_enabled(vport) && netif_running(vport->netdev);
+	if (!restart)
+		goto pool;
+
+	ret = idpf_qp_switch(vport, qid, false);
+	if (ret) {
+		NL_SET_ERR_MSG_FMT_MOD(bpf->extack,
+				       "%s: failed to disable queue pair %u: %pe",
+				       netdev_name(vport->netdev), qid,
+				       ERR_PTR(ret));
+		return ret;
+	}
+
+pool:
+	ret = libeth_xsk_setup_pool(vport->netdev, qid, pool);
+	if (ret) {
+		NL_SET_ERR_MSG_FMT_MOD(bpf->extack,
+				       "%s: failed to configure XSk pool for pair %u: %pe",
+				       netdev_name(vport->netdev), qid,
+				       ERR_PTR(ret));
+		return ret;
+	}
+
+	if (!restart)
+		return 0;
+
+	ret = idpf_qp_switch(vport, qid, true);
+	if (ret) {
+		NL_SET_ERR_MSG_FMT_MOD(bpf->extack,
+				       "%s: failed to enable queue pair %u: %pe",
+				       netdev_name(vport->netdev), qid,
+				       ERR_PTR(ret));
+		goto err_dis;
+	}
+
+	return 0;
+
+err_dis:
+	libeth_xsk_setup_pool(vport->netdev, qid, false);
+
+	return ret;
+}
diff --git a/drivers/net/ethernet/intel/idpf/xsk.h b/drivers/net/ethernet/intel/idpf/xsk.h
new file mode 100644
index 000000000000..dc42268ba8e0
--- /dev/null
+++ b/drivers/net/ethernet/intel/idpf/xsk.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright (C) 2025 Intel Corporation */
+
+#ifndef _IDPF_XSK_H_
+#define _IDPF_XSK_H_
+
+#include <linux/types.h>
+
+struct idpf_vport;
+struct netdev_bpf;
+
+int idpf_xsk_pool_setup(struct idpf_vport *vport, struct netdev_bpf *xdp);
+
+#endif /* !_IDPF_XSK_H_ */
-- 
2.47.1


