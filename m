Return-Path: <bpf+bounces-67789-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA6BDB49A79
	for <lists+bpf@lfdr.de>; Mon,  8 Sep 2025 21:59:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E8194E0FD7
	for <lists+bpf@lfdr.de>; Mon,  8 Sep 2025 19:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A81D22D77E2;
	Mon,  8 Sep 2025 19:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ggksai25"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8833E2D6418;
	Mon,  8 Sep 2025 19:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757361495; cv=none; b=NeMF6P9+hj5shrLfe0BsxwCTbRWPVe+CXe4eqkfnm7drBSjZHemgXAlUuxc9BTLqf1DLxBFwO1JICau6bDUZZgESSrMeAFSafsYgoo/wZfVnTX4jZPTzsGdT8oW7YwUDpvxeHoe4MUeWXT01UM6z1eJ91T+gEEbghtIOKPmd+sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757361495; c=relaxed/simple;
	bh=0tCWdXeEFRL74iV8ktRyNlJYVkvZWmgHojgjY5Y+0uo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vEeQQQbTh0gszxR1RgRGd0Kuf30Mjb/EmeTEtW+RYyWgPetU4Mi/mAqal5pcOnRaCqS7eYL0AIkrVT0IYxVv02tt1a6mVAh4MshK+vMPE8g4DSOiexh+qaNJMRDVzNRVgB7eztpMd5UfaHu2AqbOI20Sm51qiNh/Io0lVf2YjRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ggksai25; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757361494; x=1788897494;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0tCWdXeEFRL74iV8ktRyNlJYVkvZWmgHojgjY5Y+0uo=;
  b=Ggksai25Rj7BDdbPhq22jIvoJAnmNngEoCvj82FmHnlAFm9IPQCjXLWd
   p/RBgnXQ56/4SLGTvS96R/NczOaSKHmECTMNK7stCYiMFrNT+xLabCcLe
   WNpUWwuxFHVJST1Tmxep4qSoA5XE/FSt7jkBjVvnte7ZkILR+kf8eSjKS
   E0KtYRISetBRqtMNbxCupNdw+DN3tL4i5GYqT0sBTa0ejQ1Hdesn0ip7j
   ZkEOBidAGM5QFFMAm4nKVijfIwVFYS2KVB7KFFqs7OybMxxVDfBfib0kJ
   LlJ3lsLtWHRoyusdmu6Xj6Gm1+1eRNCGVFxQ/nik9Ltpqz1tMxXuOPoCz
   g==;
X-CSE-ConnectionGUID: NIjfWElqSEm2hzPv7hMNxQ==
X-CSE-MsgGUID: 1zyNXnehTDiz7kGvx4uUMw==
X-IronPort-AV: E=McAfee;i="6800,10657,11547"; a="77088916"
X-IronPort-AV: E=Sophos;i="6.18,249,1751266800"; 
   d="scan'208";a="77088916"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2025 12:58:11 -0700
X-CSE-ConnectionGUID: YxQs0QUBT22G9vfFMzUjkQ==
X-CSE-MsgGUID: QE8gCZIbRQayADUS+TprfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,249,1751266800"; 
   d="scan'208";a="177189730"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa004.jf.intel.com with ESMTP; 08 Sep 2025 12:58:11 -0700
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
Subject: [PATCH net-next 05/13] idpf: add 4-byte completion descriptor definition
Date: Mon,  8 Sep 2025 12:57:35 -0700
Message-ID: <20250908195748.1707057-6-anthony.l.nguyen@intel.com>
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

From: Michal Kubiak <michal.kubiak@intel.com>

In the queue-based scheduling mode, Tx completion descriptor is 4 bytes
comparing to 8 bytes in flow-based.
Add definition for it and allocate the corresponding amount of memory
for the descriptors during the completion queue creation.
This does not include handling 4-byte completions during Tx polling, as
for now, the only user of QB will be XDP, which has its own routines.

Signed-off-by: Michal Kubiak <michal.kubiak@intel.com>
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Tested-by: Ramu R <ramu.r@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 .../net/ethernet/intel/idpf/idpf_lan_txrx.h   |  6 +++-
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   | 34 +++++++++++--------
 drivers/net/ethernet/intel/idpf/idpf_txrx.h   | 11 ++++--
 3 files changed, 33 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_lan_txrx.h b/drivers/net/ethernet/intel/idpf/idpf_lan_txrx.h
index 7492d1713243..20d5af64e750 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_lan_txrx.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_lan_txrx.h
@@ -186,13 +186,17 @@ struct idpf_base_tx_desc {
 	__le64 qw1; /* type_cmd_offset_bsz_l2tag1 */
 }; /* read used with buffer queues */
 
-struct idpf_splitq_tx_compl_desc {
+struct idpf_splitq_4b_tx_compl_desc {
 	/* qid=[10:0] comptype=[13:11] rsvd=[14] gen=[15] */
 	__le16 qid_comptype_gen;
 	union {
 		__le16 q_head; /* Queue head */
 		__le16 compl_tag; /* Completion tag */
 	} q_head_compl_tag;
+}; /* writeback used with completion queues */
+
+struct idpf_splitq_tx_compl_desc {
+	struct idpf_splitq_4b_tx_compl_desc common;
 	u8 ts[3];
 	u8 rsvd; /* Reserved */
 }; /* writeback used with completion queues */
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index 563de9a32919..875a849c87f4 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -115,8 +115,8 @@ static void idpf_compl_desc_rel(struct idpf_compl_queue *complq)
 		return;
 
 	dma_free_coherent(complq->netdev->dev.parent, complq->size,
-			  complq->comp, complq->dma);
-	complq->comp = NULL;
+			  complq->desc_ring, complq->dma);
+	complq->desc_ring = NULL;
 	complq->next_to_use = 0;
 	complq->next_to_clean = 0;
 }
@@ -246,12 +246,16 @@ static int idpf_tx_desc_alloc(const struct idpf_vport *vport,
 static int idpf_compl_desc_alloc(const struct idpf_vport *vport,
 				 struct idpf_compl_queue *complq)
 {
-	complq->size = array_size(complq->desc_count, sizeof(*complq->comp));
+	u32 desc_size;
 
-	complq->comp = dma_alloc_coherent(complq->netdev->dev.parent,
-					  complq->size, &complq->dma,
-					  GFP_KERNEL);
-	if (!complq->comp)
+	desc_size = idpf_queue_has(FLOW_SCH_EN, complq) ?
+		    sizeof(*complq->comp) : sizeof(*complq->comp_4b);
+	complq->size = array_size(complq->desc_count, desc_size);
+
+	complq->desc_ring = dma_alloc_coherent(complq->netdev->dev.parent,
+					       complq->size, &complq->dma,
+					       GFP_KERNEL);
+	if (!complq->desc_ring)
 		return -ENOMEM;
 
 	complq->next_to_use = 0;
@@ -1759,7 +1763,7 @@ static void idpf_tx_handle_rs_completion(struct idpf_tx_queue *txq,
 	/* RS completion contains queue head for queue based scheduling or
 	 * completion tag for flow based scheduling.
 	 */
-	u16 rs_compl_val = le16_to_cpu(desc->q_head_compl_tag.q_head);
+	u16 rs_compl_val = le16_to_cpu(desc->common.q_head_compl_tag.q_head);
 
 	if (!idpf_queue_has(FLOW_SCH_EN, txq)) {
 		idpf_tx_splitq_clean(txq, rs_compl_val, budget, cleaned, false);
@@ -1794,19 +1798,19 @@ static bool idpf_tx_clean_complq(struct idpf_compl_queue *complq, int budget,
 	do {
 		struct libeth_sq_napi_stats cleaned_stats = { };
 		struct idpf_tx_queue *tx_q;
+		__le16 hw_head;
 		int rel_tx_qid;
-		u16 hw_head;
 		u8 ctype;	/* completion type */
 		u16 gen;
 
 		/* if the descriptor isn't done, no work yet to do */
-		gen = le16_get_bits(tx_desc->qid_comptype_gen,
+		gen = le16_get_bits(tx_desc->common.qid_comptype_gen,
 				    IDPF_TXD_COMPLQ_GEN_M);
 		if (idpf_queue_has(GEN_CHK, complq) != gen)
 			break;
 
 		/* Find necessary info of TX queue to clean buffers */
-		rel_tx_qid = le16_get_bits(tx_desc->qid_comptype_gen,
+		rel_tx_qid = le16_get_bits(tx_desc->common.qid_comptype_gen,
 					   IDPF_TXD_COMPLQ_QID_M);
 		if (rel_tx_qid >= complq->txq_grp->num_txq ||
 		    !complq->txq_grp->txqs[rel_tx_qid]) {
@@ -1816,14 +1820,14 @@ static bool idpf_tx_clean_complq(struct idpf_compl_queue *complq, int budget,
 		tx_q = complq->txq_grp->txqs[rel_tx_qid];
 
 		/* Determine completion type */
-		ctype = le16_get_bits(tx_desc->qid_comptype_gen,
+		ctype = le16_get_bits(tx_desc->common.qid_comptype_gen,
 				      IDPF_TXD_COMPLQ_COMPL_TYPE_M);
 		switch (ctype) {
 		case IDPF_TXD_COMPLT_RE:
-			hw_head = le16_to_cpu(tx_desc->q_head_compl_tag.q_head);
+			hw_head = tx_desc->common.q_head_compl_tag.q_head;
 
-			idpf_tx_splitq_clean(tx_q, hw_head, budget,
-					     &cleaned_stats, true);
+			idpf_tx_splitq_clean(tx_q, le16_to_cpu(hw_head),
+					     budget, &cleaned_stats, true);
 			break;
 		case IDPF_TXD_COMPLT_RS:
 			idpf_tx_handle_rs_completion(tx_q, tx_desc,
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.h b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
index 52753dff381c..11a318fd48d4 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
@@ -728,7 +728,9 @@ libeth_cacheline_set_assert(struct idpf_buf_queue, 64, 24, 32);
 
 /**
  * struct idpf_compl_queue - software structure representing a completion queue
- * @comp: completion descriptor array
+ * @comp: 8-byte completion descriptor array
+ * @comp_4b: 4-byte completion descriptor array
+ * @desc_ring: virtual descriptor ring address
  * @txq_grp: See struct idpf_txq_group
  * @flags: See enum idpf_queue_flags_t
  * @desc_count: Number of descriptors
@@ -748,7 +750,12 @@ libeth_cacheline_set_assert(struct idpf_buf_queue, 64, 24, 32);
  */
 struct idpf_compl_queue {
 	__cacheline_group_begin_aligned(read_mostly);
-	struct idpf_splitq_tx_compl_desc *comp;
+	union {
+		struct idpf_splitq_tx_compl_desc *comp;
+		struct idpf_splitq_4b_tx_compl_desc *comp_4b;
+
+		void *desc_ring;
+	};
 	struct idpf_txq_group *txq_grp;
 
 	DECLARE_BITMAP(flags, __IDPF_Q_FLAGS_NBITS);
-- 
2.47.1


