Return-Path: <bpf+bounces-66565-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A8CCB36FE7
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 18:18:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E46E980854
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 16:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C11C26B760;
	Tue, 26 Aug 2025 16:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WQunnjal"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1A436CC68;
	Tue, 26 Aug 2025 16:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756224840; cv=none; b=RUaWvaNe+a29mddsAaJSb5P3p+NQo6YAdcHfq93mOPvzB827J983AcIEJOZhihham1newQXAyijgeEoyTIQ7le7i+lBsOJ2pGrVpCkvLMG5h81deSXKN3W9zKyGpyUpyS5+S6v2Rw476cODoZr7E1hoLQZvWDZgw0JzLY+8Wx8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756224840; c=relaxed/simple;
	bh=Vhy7Nailub8C+q8nS3Gw3ogR5SUVPzBVym0uhTYVSB0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H95Wf+FJ7Icmkchcb7UvnmfeDuH3S8oV6gSxYkDKoiwS+GqRW19HtN9mMxzIHOKUyEZMI3OJyntLpQTtFpzb+NJ3SmVaNTeS+4o0pD2wm5RA+g+98mT9ozElhlGGOY7tNpBSXEmonY/9UghR786Q0Bg481/PrLbBigxOuGXLdQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WQunnjal; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756224838; x=1787760838;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Vhy7Nailub8C+q8nS3Gw3ogR5SUVPzBVym0uhTYVSB0=;
  b=WQunnjallAxiD7INRKQDNwoQFgMHq45ivUEuIgxaG9CpovAwiBxE9j2h
   fwNnxInZ8FqTGBYmRGpRKNlksE6qHeJeSmnSJwJTTqSqTn1wO1fVxgUT3
   G0piXzbJM+F6qdaqHHakGvrxqauH9OPuRru7Q1ji0jKuIqjBDcaCAyyDJ
   r8cCjYkgA3d7pY3TRaDYhC26rYqt+sRDQhW9PjQJVDyAAgrz+N8jFEl22
   HAziLnpb2moNW8HeW/y0pg8XN2SInvAcTC1zy1NklJ14tEciWYql7+9ZI
   WoTwyh90mkd3qKsIu6y7DhtrUcl24x6jwt0nYf7ZQpMrrGZBpQsik08eE
   w==;
X-CSE-ConnectionGUID: zwKORrOeTZyY8+fayxhB8Q==
X-CSE-MsgGUID: stzMVLMGSqKvx7x0mB3wFw==
X-IronPort-AV: E=McAfee;i="6800,10657,11534"; a="46044991"
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="46044991"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 09:13:58 -0700
X-CSE-ConnectionGUID: DBSP2MCIQBe5+gEuLacdHg==
X-CSE-MsgGUID: lfkfDkUqRXSw49hf098Nlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="200562277"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa002.jf.intel.com with ESMTP; 26 Aug 2025 09:13:53 -0700
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
Subject: [PATCH iwl-next v5 07/13] idpf: add support for nointerrupt queues
Date: Tue, 26 Aug 2025 17:55:01 +0200
Message-ID: <20250826155507.2138401-8-aleksander.lobakin@intel.com>
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

Currently, queues are associated 1:1 with interrupt vectors as it's
assumed queues are always interrupt-driven. For XDP, we want to use
Tx queues without interrupts and only do "lazy" cleaning when the number
of free elements is <= threshold (closest pow-2 to 1/4 of the ring).
In order to use a queue without an interrupt, idpf still needs to have
a vector assigned to it to flush descriptors. This vector can be global
and only one for the whole vport to handle all its noirq queues.
Always request one excessive vector and configure it in non-interrupt
mode right away when creating vport, so that it can be used later by
queues when needed (not only XDP ones).

Co-developed-by: Michal Kubiak <michal.kubiak@intel.com>
Signed-off-by: Michal Kubiak <michal.kubiak@intel.com>
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf.h        |  8 +++
 drivers/net/ethernet/intel/idpf/idpf_txrx.h   |  4 ++
 drivers/net/ethernet/intel/idpf/idpf_dev.c    | 11 +++-
 drivers/net/ethernet/intel/idpf/idpf_lib.c    |  2 +-
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   |  8 +++
 drivers/net/ethernet/intel/idpf/idpf_vf_dev.c | 11 +++-
 .../net/ethernet/intel/idpf/idpf_virtchnl.c   | 54 ++++++++++++++-----
 7 files changed, 81 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf.h b/drivers/net/ethernet/intel/idpf/idpf.h
index 269e9b41645a..2bfdf0ae24cf 100644
--- a/drivers/net/ethernet/intel/idpf/idpf.h
+++ b/drivers/net/ethernet/intel/idpf/idpf.h
@@ -312,6 +312,9 @@ struct idpf_fsteer_fltr {
  * @num_q_vectors: Number of IRQ vectors allocated
  * @q_vectors: Array of queue vectors
  * @q_vector_idxs: Starting index of queue vectors
+ * @noirq_dyn_ctl: register to enable/disable the vector for NOIRQ queues
+ * @noirq_dyn_ctl_ena: value to write to the above to enable it
+ * @noirq_v_idx: ID of the NOIRQ vector
  * @max_mtu: device given max possible MTU
  * @default_mac_addr: device will give a default MAC to use
  * @rx_itr_profile: RX profiles for Dynamic Interrupt Moderation
@@ -358,6 +361,11 @@ struct idpf_vport {
 	u16 num_q_vectors;
 	struct idpf_q_vector *q_vectors;
 	u16 *q_vector_idxs;
+
+	void __iomem *noirq_dyn_ctl;
+	u32 noirq_dyn_ctl_ena;
+	u16 noirq_v_idx;
+
 	u16 max_mtu;
 	u8 default_mac_addr[ETH_ALEN];
 	u16 rx_itr_profile[IDPF_DIM_PROFILE_SLOTS];
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.h b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
index 1c570794e5bc..f8e579dab21a 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
@@ -58,6 +58,8 @@
 #define IDPF_MBX_Q_VEC		1
 #define IDPF_MIN_Q_VEC		1
 #define IDPF_MIN_RDMA_VEC	2
+/* Data vector for NOIRQ queues */
+#define IDPF_RESERVED_VECS			1
 
 #define IDPF_DFLT_TX_Q_DESC_COUNT		512
 #define IDPF_DFLT_TX_COMPLQ_DESC_COUNT		512
@@ -279,6 +281,7 @@ struct idpf_ptype_state {
  * @__IDPF_Q_HSPLIT_EN: enable header split on Rx (splitq)
  * @__IDPF_Q_PTP: indicates whether the Rx timestamping is enabled for the
  *		  queue
+ * @__IDPF_Q_NOIRQ: queue is polling-driven and has no interrupt
  * @__IDPF_Q_FLAGS_NBITS: Must be last
  */
 enum idpf_queue_flags_t {
@@ -289,6 +292,7 @@ enum idpf_queue_flags_t {
 	__IDPF_Q_CRC_EN,
 	__IDPF_Q_HSPLIT_EN,
 	__IDPF_Q_PTP,
+	__IDPF_Q_NOIRQ,
 
 	__IDPF_Q_FLAGS_NBITS,
 };
diff --git a/drivers/net/ethernet/intel/idpf/idpf_dev.c b/drivers/net/ethernet/intel/idpf/idpf_dev.c
index bfa60f7d43de..3a04a6bd0d7c 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_dev.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_dev.c
@@ -77,7 +77,7 @@ static int idpf_intr_reg_init(struct idpf_vport *vport)
 	int num_vecs = vport->num_q_vectors;
 	struct idpf_vec_regs *reg_vals;
 	int num_regs, i, err = 0;
-	u32 rx_itr, tx_itr;
+	u32 rx_itr, tx_itr, val;
 	u16 total_vecs;
 
 	total_vecs = idpf_get_reserved_vecs(vport->adapter);
@@ -121,6 +121,15 @@ static int idpf_intr_reg_init(struct idpf_vport *vport)
 		intr->tx_itr = idpf_get_reg_addr(adapter, tx_itr);
 	}
 
+	/* Data vector for NOIRQ queues */
+
+	val = reg_vals[vport->q_vector_idxs[i] - IDPF_MBX_Q_VEC].dyn_ctl_reg;
+	vport->noirq_dyn_ctl = idpf_get_reg_addr(adapter, val);
+
+	val = PF_GLINT_DYN_CTL_WB_ON_ITR_M | PF_GLINT_DYN_CTL_INTENA_MSK_M |
+	      FIELD_PREP(PF_GLINT_DYN_CTL_ITR_INDX_M, IDPF_NO_ITR_UPDATE_IDX);
+	vport->noirq_dyn_ctl_ena = val;
+
 free_reg_vals:
 	kfree(reg_vals);
 
diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
index ef9f2b0cef67..baf1f9b196d5 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
@@ -1142,7 +1142,7 @@ static struct idpf_vport *idpf_vport_alloc(struct idpf_adapter *adapter,
 	if (!vport)
 		return vport;
 
-	num_max_q = max(max_q->max_txq, max_q->max_rxq);
+	num_max_q = max(max_q->max_txq, max_q->max_rxq) + IDPF_RESERVED_VECS;
 	if (!adapter->vport_config[idx]) {
 		struct idpf_vport_config *vport_config;
 		struct idpf_q_coalesce *q_coal;
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index d362dab4d5a2..ceab25ee1aad 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -3506,6 +3506,8 @@ static void idpf_vport_intr_dis_irq_all(struct idpf_vport *vport)
 	struct idpf_q_vector *q_vector = vport->q_vectors;
 	int q_idx;
 
+	writel(0, vport->noirq_dyn_ctl);
+
 	for (q_idx = 0; q_idx < vport->num_q_vectors; q_idx++)
 		writel(0, q_vector[q_idx].intr_reg.dyn_ctl);
 }
@@ -3749,6 +3751,8 @@ static void idpf_vport_intr_ena_irq_all(struct idpf_vport *vport)
 		if (qv->num_txq || qv->num_rxq)
 			idpf_vport_intr_update_itr_ena_irq(qv);
 	}
+
+	writel(vport->noirq_dyn_ctl_ena, vport->noirq_dyn_ctl);
 }
 
 /**
@@ -4060,6 +4064,8 @@ static int idpf_vport_intr_init_vec_idx(struct idpf_vport *vport)
 		for (i = 0; i < vport->num_q_vectors; i++)
 			vport->q_vectors[i].v_idx = vport->q_vector_idxs[i];
 
+		vport->noirq_v_idx = vport->q_vector_idxs[i];
+
 		return 0;
 	}
 
@@ -4073,6 +4079,8 @@ static int idpf_vport_intr_init_vec_idx(struct idpf_vport *vport)
 	for (i = 0; i < vport->num_q_vectors; i++)
 		vport->q_vectors[i].v_idx = vecids[vport->q_vector_idxs[i]];
 
+	vport->noirq_v_idx = vecids[vport->q_vector_idxs[i]];
+
 	kfree(vecids);
 
 	return 0;
diff --git a/drivers/net/ethernet/intel/idpf/idpf_vf_dev.c b/drivers/net/ethernet/intel/idpf/idpf_vf_dev.c
index 259d50fded67..4cc58c83688c 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_vf_dev.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_vf_dev.c
@@ -76,7 +76,7 @@ static int idpf_vf_intr_reg_init(struct idpf_vport *vport)
 	int num_vecs = vport->num_q_vectors;
 	struct idpf_vec_regs *reg_vals;
 	int num_regs, i, err = 0;
-	u32 rx_itr, tx_itr;
+	u32 rx_itr, tx_itr, val;
 	u16 total_vecs;
 
 	total_vecs = idpf_get_reserved_vecs(vport->adapter);
@@ -120,6 +120,15 @@ static int idpf_vf_intr_reg_init(struct idpf_vport *vport)
 		intr->tx_itr = idpf_get_reg_addr(adapter, tx_itr);
 	}
 
+	/* Data vector for NOIRQ queues */
+
+	val = reg_vals[vport->q_vector_idxs[i] - IDPF_MBX_Q_VEC].dyn_ctl_reg;
+	vport->noirq_dyn_ctl = idpf_get_reg_addr(adapter, val);
+
+	val = VF_INT_DYN_CTLN_WB_ON_ITR_M | VF_INT_DYN_CTLN_INTENA_MSK_M |
+	      FIELD_PREP(VF_INT_DYN_CTLN_ITR_INDX_M, IDPF_NO_ITR_UPDATE_IDX);
+	vport->noirq_dyn_ctl_ena = val;
+
 free_reg_vals:
 	kfree(reg_vals);
 
diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
index d3289b3e6602..ff4ea49c0957 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -2018,21 +2018,31 @@ int idpf_send_map_unmap_queue_vector_msg(struct idpf_vport *vport, bool map)
 		struct idpf_txq_group *tx_qgrp = &vport->txq_grps[i];
 
 		for (j = 0; j < tx_qgrp->num_txq; j++, k++) {
+			const struct idpf_tx_queue *txq = tx_qgrp->txqs[j];
+			const struct idpf_q_vector *vec;
+			u32 v_idx, tx_itr_idx;
+
 			vqv[k].queue_type =
 				cpu_to_le32(VIRTCHNL2_QUEUE_TYPE_TX);
-			vqv[k].queue_id = cpu_to_le32(tx_qgrp->txqs[j]->q_id);
+			vqv[k].queue_id = cpu_to_le32(txq->q_id);
 
-			if (idpf_is_queue_model_split(vport->txq_model)) {
-				vqv[k].vector_id =
-				cpu_to_le16(tx_qgrp->complq->q_vector->v_idx);
-				vqv[k].itr_idx =
-				cpu_to_le32(tx_qgrp->complq->q_vector->tx_itr_idx);
+			if (idpf_queue_has(NOIRQ, txq))
+				vec = NULL;
+			else if (idpf_is_queue_model_split(vport->txq_model))
+				vec = txq->txq_grp->complq->q_vector;
+			else
+				vec = txq->q_vector;
+
+			if (vec) {
+				v_idx = vec->v_idx;
+				tx_itr_idx = vec->tx_itr_idx;
 			} else {
-				vqv[k].vector_id =
-				cpu_to_le16(tx_qgrp->txqs[j]->q_vector->v_idx);
-				vqv[k].itr_idx =
-				cpu_to_le32(tx_qgrp->txqs[j]->q_vector->tx_itr_idx);
+				v_idx = vport->noirq_v_idx;
+				tx_itr_idx = VIRTCHNL2_ITR_IDX_1;
 			}
+
+			vqv[k].vector_id = cpu_to_le16(v_idx);
+			vqv[k].itr_idx = cpu_to_le32(tx_itr_idx);
 		}
 	}
 
@@ -2050,6 +2060,7 @@ int idpf_send_map_unmap_queue_vector_msg(struct idpf_vport *vport, bool map)
 
 		for (j = 0; j < num_rxq; j++, k++) {
 			struct idpf_rx_queue *rxq;
+			u32 v_idx, rx_itr_idx;
 
 			if (idpf_is_queue_model_split(vport->rxq_model))
 				rxq = &rx_qgrp->splitq.rxq_sets[j]->rxq;
@@ -2059,8 +2070,17 @@ int idpf_send_map_unmap_queue_vector_msg(struct idpf_vport *vport, bool map)
 			vqv[k].queue_type =
 				cpu_to_le32(VIRTCHNL2_QUEUE_TYPE_RX);
 			vqv[k].queue_id = cpu_to_le32(rxq->q_id);
-			vqv[k].vector_id = cpu_to_le16(rxq->q_vector->v_idx);
-			vqv[k].itr_idx = cpu_to_le32(rxq->q_vector->rx_itr_idx);
+
+			if (idpf_queue_has(NOIRQ, rxq)) {
+				v_idx = vport->noirq_v_idx;
+				rx_itr_idx = VIRTCHNL2_ITR_IDX_0;
+			} else {
+				v_idx = rxq->q_vector->v_idx;
+				rx_itr_idx = rxq->q_vector->rx_itr_idx;
+			}
+
+			vqv[k].vector_id = cpu_to_le16(v_idx);
+			vqv[k].itr_idx = cpu_to_le32(rx_itr_idx);
 		}
 	}
 
@@ -3281,9 +3301,15 @@ int idpf_vport_alloc_vec_indexes(struct idpf_vport *vport)
 {
 	struct idpf_vector_info vec_info;
 	int num_alloc_vecs;
+	u32 req;
 
 	vec_info.num_curr_vecs = vport->num_q_vectors;
-	vec_info.num_req_vecs = max(vport->num_txq, vport->num_rxq);
+	if (vec_info.num_curr_vecs)
+		vec_info.num_curr_vecs += IDPF_RESERVED_VECS;
+
+	req = max(vport->num_txq, vport->num_rxq) + IDPF_RESERVED_VECS;
+	vec_info.num_req_vecs = req;
+
 	vec_info.default_vport = vport->default_vport;
 	vec_info.index = vport->idx;
 
@@ -3296,7 +3322,7 @@ int idpf_vport_alloc_vec_indexes(struct idpf_vport *vport)
 		return -EINVAL;
 	}
 
-	vport->num_q_vectors = num_alloc_vecs;
+	vport->num_q_vectors = num_alloc_vecs - IDPF_RESERVED_VECS;
 
 	return 0;
 }
-- 
2.51.0


