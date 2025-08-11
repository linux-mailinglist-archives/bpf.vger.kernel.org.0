Return-Path: <bpf+bounces-65355-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 29C6AB211C4
	for <lists+bpf@lfdr.de>; Mon, 11 Aug 2025 18:25:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E26218A490C
	for <lists+bpf@lfdr.de>; Mon, 11 Aug 2025 16:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A93AA2E339E;
	Mon, 11 Aug 2025 16:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F+nRuDd9"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5182E2EE0;
	Mon, 11 Aug 2025 16:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754928797; cv=none; b=MAOlssDF7oK/DxDH+Jl/JfPNtalCewj0Z2fCZYm5KtYSkaHTsUw3MDXp2TwQXn/vbIQYC4gcZB1+UJiB5v53jx09y+ZkydjNw41/t1Yuw7048m404YmNUM+9AGTfCXgS44tG1yJqfSMZNgnNQa2uJLMz3mW3UYbS/7j5NTjd0y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754928797; c=relaxed/simple;
	bh=Mhp8DyvClPxqYBcVY8u3CSbGFV7N8agLw64YPGO4VRI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VRhLTAvy0bsO605TXSPYQcYG0hQ9XKuK+jlJ501ltEj5pPFkpbgW/iTECVAGRow4r0l/o3zKEVgAytkQN9VQ50vCjKD/28iCG3gGuSKdeywDIHH0hY+DstYTMhQwSwG+BwDBARR8gfr/IYrMpTd2XFsIiLz6AjG8iJMsGIhk5uU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F+nRuDd9; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754928795; x=1786464795;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Mhp8DyvClPxqYBcVY8u3CSbGFV7N8agLw64YPGO4VRI=;
  b=F+nRuDd9PY7GHcmQUTM3w58sOOfYENcnayDxcg3rNzVqXSyPOUeQ9eYw
   2OMxS/E0xfIGAF7AMmEWAheBMZqsAc7093eHJ8NCsg94k3yIjIy9VrvPh
   pc5kvtUmBVJNFrXo/kATe3DK1ID5GvhJv3/ufUBUV9DnJdm4E0cyiS9RZ
   jId3SAsX34VRl3MS/3Brx+UzOtCV7NJ2QLLyWkaBeAuPjHwcVaHzJetbh
   WITPF5R2OLprtRpU+qOlKICWCrYM0EGIra2f8u3j5sB/T6n4JMbksFojR
   sn3UmPhlQRjmqC0gK3KOp4tGkUHLN8tqqz6eJCDL9KZ+H3+Qebyg0tSHF
   A==;
X-CSE-ConnectionGUID: f8m8eLA7TDqFug17fMjDtg==
X-CSE-MsgGUID: 1BFoBM64Rvq8dtrgYKFSQg==
X-IronPort-AV: E=McAfee;i="6800,10657,11518"; a="56899633"
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="56899633"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2025 09:13:15 -0700
X-CSE-ConnectionGUID: oBPCMtEESfGFvH12haQ46w==
X-CSE-MsgGUID: Qz2fN1mtTwiPfK5aOQUn6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="165163215"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa006.jf.intel.com with ESMTP; 11 Aug 2025 09:13:11 -0700
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
Subject: [PATCH iwl-next v4 07/13] idpf: add support for nointerrupt queues
Date: Mon, 11 Aug 2025 18:10:38 +0200
Message-ID: <20250811161044.32329-8-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250811161044.32329-1-aleksander.lobakin@intel.com>
References: <20250811161044.32329-1-aleksander.lobakin@intel.com>
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
index d462568e7c29..b727a84450f1 100644
--- a/drivers/net/ethernet/intel/idpf/idpf.h
+++ b/drivers/net/ethernet/intel/idpf/idpf.h
@@ -310,6 +310,9 @@ struct idpf_fsteer_fltr {
  * @num_q_vectors: Number of IRQ vectors allocated
  * @q_vectors: Array of queue vectors
  * @q_vector_idxs: Starting index of queue vectors
+ * @noirq_dyn_ctl: register to enable/disable the vector for NOIRQ queues
+ * @noirq_dyn_ctl_ena: value to write to the above to enable it
+ * @noirq_v_idx: ID of the NOIRQ vector
  * @max_mtu: device given max possible MTU
  * @default_mac_addr: device will give a default MAC to use
  * @rx_itr_profile: RX profiles for Dynamic Interrupt Moderation
@@ -356,6 +359,11 @@ struct idpf_vport {
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
index 2a0ba72dd5b1..24f6ab23d97e 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
@@ -1141,7 +1141,7 @@ static struct idpf_vport *idpf_vport_alloc(struct idpf_adapter *adapter,
 	if (!vport)
 		return vport;
 
-	num_max_q = max(max_q->max_txq, max_q->max_rxq);
+	num_max_q = max(max_q->max_txq, max_q->max_rxq) + IDPF_RESERVED_VECS;
 	if (!adapter->vport_config[idx]) {
 		struct idpf_vport_config *vport_config;
 		struct idpf_q_coalesce *q_coal;
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index f3ff481a5ae1..faa2d1c0a1c4 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -3591,6 +3591,8 @@ static void idpf_vport_intr_dis_irq_all(struct idpf_vport *vport)
 	struct idpf_q_vector *q_vector = vport->q_vectors;
 	int q_idx;
 
+	writel(0, vport->noirq_dyn_ctl);
+
 	for (q_idx = 0; q_idx < vport->num_q_vectors; q_idx++)
 		writel(0, q_vector[q_idx].intr_reg.dyn_ctl);
 }
@@ -3834,6 +3836,8 @@ static void idpf_vport_intr_ena_irq_all(struct idpf_vport *vport)
 		if (qv->num_txq || qv->num_rxq)
 			idpf_vport_intr_update_itr_ena_irq(qv);
 	}
+
+	writel(vport->noirq_dyn_ctl_ena, vport->noirq_dyn_ctl);
 }
 
 /**
@@ -4145,6 +4149,8 @@ static int idpf_vport_intr_init_vec_idx(struct idpf_vport *vport)
 		for (i = 0; i < vport->num_q_vectors; i++)
 			vport->q_vectors[i].v_idx = vport->q_vector_idxs[i];
 
+		vport->noirq_v_idx = vport->q_vector_idxs[i];
+
 		return 0;
 	}
 
@@ -4158,6 +4164,8 @@ static int idpf_vport_intr_init_vec_idx(struct idpf_vport *vport)
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
2.50.1


