Return-Path: <bpf+bounces-53360-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B887A504AF
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 17:26:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48AD33B2153
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 16:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FC07253B5C;
	Wed,  5 Mar 2025 16:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eHTSS4db"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE61C253B45;
	Wed,  5 Mar 2025 16:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741191770; cv=none; b=V5BWyDSRXjUhCsFzt4lpHEwWAcjUevVOdPlbmLJr2fKeqhCypfMAfwCp0Wb+RKOobtd/hqFyNMPpftZXjfc/6zFskHe2rARXHqKhqnSX8kwGvNSNsrBrErcGmTer1RITJSDywR1AtrEKnnwg3oMPy1NpHCB0R5k3GgnmzO9MfFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741191770; c=relaxed/simple;
	bh=FtWJYW+o714mb3TsccMhQ4fHIovNa8e67r5BCxJE/hY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=itlHVmnCrRaNZOqqkFwcUlh9+z9sU4/r6WmgDkvcbB4N6OcAQyJdapy6bLwkNR9Z9otnm4GPP+YmgjrNDADxar4PFJ0vXNBrYJ4BhBYl34X9pafD/9EcoL9wOhtm7HRZC4Sle22Dt/PwgZY/3rKQ0wYa38s9f6mZ4FKKn+Wetzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eHTSS4db; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741191769; x=1772727769;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FtWJYW+o714mb3TsccMhQ4fHIovNa8e67r5BCxJE/hY=;
  b=eHTSS4dblCaTMOEZVe2wwuQYdSMoukbpSbPGAqNTEGZUcZ+cj6E5zWtE
   EAl2OTsWO0+Lx2kc/rIvgztlMqcvfjzfP1pTjSPD5a+bQG/Mn9I+au7hn
   23+38+o1p7Vk/3vgs86pKOGpkjeLR+Aa5e1NdLIKn3s+WnlosRSjQEcnA
   7cVvjubeTofJruASCMNfTnQTpk/2VAoAz/h9ox7E4txyIQIpJNbHUk9Pu
   w5FUqXIJ+R1lf4bTKsnHZSgabFdoYlhx8fpIORxhvtDdW3WEXVDS7tP4m
   wA0saTvfnuuZtuISrne8AqpqT7asrqUixgeroQYkNc25W89lCbagm1FBr
   A==;
X-CSE-ConnectionGUID: y/syWysaRdWWBUm63Mp+Zw==
X-CSE-MsgGUID: MDPGpH3fS+SeswFSBCOW3Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="42026499"
X-IronPort-AV: E=Sophos;i="6.14,223,1736841600"; 
   d="scan'208";a="42026499"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 08:22:49 -0800
X-CSE-ConnectionGUID: 28w565D8QuGfn5e5aO+AYw==
X-CSE-MsgGUID: bY+5CFEyTNaP42EQlCriyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,223,1736841600"; 
   d="scan'208";a="123832908"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by fmviesa004.fm.intel.com with ESMTP; 05 Mar 2025 08:22:44 -0800
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
Subject: [PATCH net-next 08/16] idpf: make complq cleaning dependent on scheduling mode
Date: Wed,  5 Mar 2025 17:21:24 +0100
Message-ID: <20250305162132.1106080-9-aleksander.lobakin@intel.com>
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

Extend completion queue cleaning function to support queue-based
scheduling mode needed for XDP queues.
Add 4-byte descriptor for queue-based scheduling mode and
perform some refactoring to extract the common code for
both scheduling modes.

Signed-off-by: Michal Kubiak <michal.kubiak@intel.com>
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 .../net/ethernet/intel/idpf/idpf_lan_txrx.h   |   6 +-
 drivers/net/ethernet/intel/idpf/idpf_txrx.h   |  11 +-
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   | 256 +++++++++++-------
 3 files changed, 177 insertions(+), 96 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_lan_txrx.h b/drivers/net/ethernet/intel/idpf/idpf_lan_txrx.h
index 8c7f8ef8f1a1..7f12c7f2e70e 100644
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
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.h b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
index b029f566e57c..9f938301b2c5 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
@@ -743,7 +743,9 @@ libeth_cacheline_set_assert(struct idpf_buf_queue, 64, 24, 32);
 
 /**
  * struct idpf_compl_queue - software structure representing a completion queue
- * @comp: completion descriptor array
+ * @comp: 8-byte completion descriptor array
+ * @comp_4b: 4-byte completion descriptor array
+ * @desc_ring: virtual descriptor ring address
  * @txq_grp: See struct idpf_txq_group
  * @flags: See enum idpf_queue_flags_t
  * @desc_count: Number of descriptors
@@ -763,7 +765,12 @@ libeth_cacheline_set_assert(struct idpf_buf_queue, 64, 24, 32);
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
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index a3f6e8cff7a0..a240ed115e3e 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -156,8 +156,8 @@ static void idpf_compl_desc_rel(struct idpf_compl_queue *complq)
 		return;
 
 	dma_free_coherent(complq->netdev->dev.parent, complq->size,
-			  complq->comp, complq->dma);
-	complq->comp = NULL;
+			  complq->desc_ring, complq->dma);
+	complq->desc_ring = NULL;
 	complq->next_to_use = 0;
 	complq->next_to_clean = 0;
 }
@@ -284,12 +284,16 @@ static int idpf_tx_desc_alloc(const struct idpf_vport *vport,
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
@@ -1921,8 +1925,46 @@ static bool idpf_tx_clean_buf_ring(struct idpf_tx_queue *txq, u16 compl_tag,
 }
 
 /**
- * idpf_tx_handle_rs_completion - clean a single packet and all of its buffers
- * whether on the buffer ring or in the hash table
+ * idpf_parse_compl_desc - Parse the completion descriptor
+ * @desc: completion descriptor to be parsed
+ * @complq: completion queue containing the descriptor
+ * @txq: returns corresponding Tx queue for a given descriptor
+ * @gen_flag: current generation flag in the completion queue
+ *
+ * Return: completion type from descriptor or negative value in case of error:
+ *	   -ENODATA if there is no completion descriptor to be cleaned,
+ *	   -EINVAL if no Tx queue has been found for the completion queue.
+ */
+static int
+idpf_parse_compl_desc(const struct idpf_splitq_4b_tx_compl_desc *desc,
+		      const struct idpf_compl_queue *complq,
+		      struct idpf_tx_queue **txq, bool gen_flag)
+{
+	struct idpf_tx_queue *target;
+	u32 rel_tx_qid, comptype;
+
+	/* if the descriptor isn't done, no work yet to do */
+	comptype = le16_to_cpu(desc->qid_comptype_gen);
+	if (!!(comptype & IDPF_TXD_COMPLQ_GEN_M) != gen_flag)
+		return -ENODATA;
+
+	/* Find necessary info of TX queue to clean buffers */
+	rel_tx_qid = FIELD_GET(IDPF_TXD_COMPLQ_QID_M, comptype);
+	target = likely(rel_tx_qid < complq->txq_grp->num_txq) ?
+		 complq->txq_grp->txqs[rel_tx_qid] : NULL;
+
+	if (!target)
+		return -EINVAL;
+
+	*txq = target;
+
+	/* Determine completion type */
+	return FIELD_GET(IDPF_TXD_COMPLQ_COMPL_TYPE_M, comptype);
+}
+
+/**
+ * idpf_tx_handle_rs_cmpl_qb - clean a single packet and all of its buffers
+ * whether the Tx queue is working in queue-based scheduling
  * @txq: Tx ring to clean
  * @desc: pointer to completion queue descriptor to extract completion
  * information from
@@ -1931,21 +1973,33 @@ static bool idpf_tx_clean_buf_ring(struct idpf_tx_queue *txq, u16 compl_tag,
  *
  * Returns bytes/packets cleaned
  */
-static void idpf_tx_handle_rs_completion(struct idpf_tx_queue *txq,
-					 struct idpf_splitq_tx_compl_desc *desc,
-					 struct libeth_sq_napi_stats *cleaned,
-					 int budget)
+static void
+idpf_tx_handle_rs_cmpl_qb(struct idpf_tx_queue *txq,
+			  const struct idpf_splitq_4b_tx_compl_desc *desc,
+			  struct libeth_sq_napi_stats *cleaned, int budget)
 {
-	u16 compl_tag;
+	u16 head = le16_to_cpu(desc->q_head_compl_tag.q_head);
 
-	if (!idpf_queue_has(FLOW_SCH_EN, txq)) {
-		u16 head = le16_to_cpu(desc->q_head_compl_tag.q_head);
-
-		idpf_tx_splitq_clean(txq, head, budget, cleaned, false);
-		return;
-	}
+	idpf_tx_splitq_clean(txq, head, budget, cleaned, false);
+}
 
-	compl_tag = le16_to_cpu(desc->q_head_compl_tag.compl_tag);
+/**
+ * idpf_tx_handle_rs_cmpl_fb - clean a single packet and all of its buffers
+ * whether on the buffer ring or in the hash table (flow-based scheduling only)
+ * @txq: Tx ring to clean
+ * @desc: pointer to completion queue descriptor to extract completion
+ * information from
+ * @cleaned: pointer to stats struct to track cleaned packets/bytes
+ * @budget: Used to determine if we are in netpoll
+ *
+ * Returns bytes/packets cleaned
+ */
+static void
+idpf_tx_handle_rs_cmpl_fb(struct idpf_tx_queue *txq,
+			  const struct idpf_splitq_4b_tx_compl_desc *desc,
+			  struct libeth_sq_napi_stats *cleaned, int budget)
+{
+	u16 compl_tag = le16_to_cpu(desc->q_head_compl_tag.compl_tag);
 
 	/* If we didn't clean anything on the ring, this packet must be
 	 * in the hash table. Go clean it there.
@@ -1954,6 +2008,61 @@ static void idpf_tx_handle_rs_completion(struct idpf_tx_queue *txq,
 		idpf_tx_clean_stashed_bufs(txq, compl_tag, cleaned, budget);
 }
 
+/**
+ * idpf_tx_finalize_complq - Finalize completion queue cleaning
+ * @complq: completion queue to finalize
+ * @ntc: next to complete index
+ * @gen_flag: current state of generation flag
+ * @cleaned: returns number of packets cleaned
+ */
+static void idpf_tx_finalize_complq(struct idpf_compl_queue *complq, int ntc,
+				    bool gen_flag, int *cleaned)
+{
+	struct idpf_netdev_priv *np;
+	bool complq_ok = true;
+	int i;
+
+	/* Store the state of the complq to be used later in deciding if a
+	 * TXQ can be started again
+	 */
+	if (unlikely(IDPF_TX_COMPLQ_PENDING(complq->txq_grp) >
+		     IDPF_TX_COMPLQ_OVERFLOW_THRESH(complq)))
+		complq_ok = false;
+
+	np = netdev_priv(complq->netdev);
+	for (i = 0; i < complq->txq_grp->num_txq; ++i) {
+		struct idpf_tx_queue *tx_q = complq->txq_grp->txqs[i];
+		struct netdev_queue *nq;
+		bool dont_wake;
+
+		/* We didn't clean anything on this queue, move along */
+		if (!tx_q->cleaned_bytes)
+			continue;
+
+		*cleaned += tx_q->cleaned_pkts;
+
+		/* Update BQL */
+		nq = netdev_get_tx_queue(tx_q->netdev, tx_q->idx);
+
+		dont_wake = !complq_ok || IDPF_TX_BUF_RSV_LOW(tx_q) ||
+			    np->state != __IDPF_VPORT_UP ||
+			    !netif_carrier_ok(tx_q->netdev);
+		/* Check if the TXQ needs to and can be restarted */
+		__netif_txq_completed_wake(nq, tx_q->cleaned_pkts, tx_q->cleaned_bytes,
+					   IDPF_DESC_UNUSED(tx_q), IDPF_TX_WAKE_THRESH,
+					   dont_wake);
+
+		/* Reset cleaned stats for the next time this queue is
+		 * cleaned
+		 */
+		tx_q->cleaned_bytes = 0;
+		tx_q->cleaned_pkts = 0;
+	}
+
+	complq->next_to_clean = ntc + complq->desc_count;
+	idpf_queue_assign(GEN_CHK, complq, gen_flag);
+}
+
 /**
  * idpf_tx_clean_complq - Reclaim resources on completion queue
  * @complq: Tx ring to clean
@@ -1965,60 +2074,56 @@ static void idpf_tx_handle_rs_completion(struct idpf_tx_queue *txq,
 static bool idpf_tx_clean_complq(struct idpf_compl_queue *complq, int budget,
 				 int *cleaned)
 {
-	struct idpf_splitq_tx_compl_desc *tx_desc;
+	struct idpf_splitq_4b_tx_compl_desc *tx_desc;
 	s16 ntc = complq->next_to_clean;
-	struct idpf_netdev_priv *np;
 	unsigned int complq_budget;
-	bool complq_ok = true;
-	int i;
+	bool flow, gen_flag;
+	u32 pos = ntc;
+
+	flow = idpf_queue_has(FLOW_SCH_EN, complq);
+	gen_flag = idpf_queue_has(GEN_CHK, complq);
 
 	complq_budget = complq->clean_budget;
-	tx_desc = &complq->comp[ntc];
+	tx_desc = flow ? &complq->comp[pos].common : &complq->comp_4b[pos];
 	ntc -= complq->desc_count;
 
 	do {
 		struct libeth_sq_napi_stats cleaned_stats = { };
 		struct idpf_tx_queue *tx_q;
-		int rel_tx_qid;
 		u16 hw_head;
-		u8 ctype;	/* completion type */
-		u16 gen;
-
-		/* if the descriptor isn't done, no work yet to do */
-		gen = le16_get_bits(tx_desc->qid_comptype_gen,
-				    IDPF_TXD_COMPLQ_GEN_M);
-		if (idpf_queue_has(GEN_CHK, complq) != gen)
-			break;
-
-		/* Find necessary info of TX queue to clean buffers */
-		rel_tx_qid = le16_get_bits(tx_desc->qid_comptype_gen,
-					   IDPF_TXD_COMPLQ_QID_M);
-		if (rel_tx_qid >= complq->txq_grp->num_txq ||
-		    !complq->txq_grp->txqs[rel_tx_qid]) {
-			netdev_err(complq->netdev, "TxQ not found\n");
-			goto fetch_next_desc;
-		}
-		tx_q = complq->txq_grp->txqs[rel_tx_qid];
+		int ctype;
 
-		/* Determine completion type */
-		ctype = le16_get_bits(tx_desc->qid_comptype_gen,
-				      IDPF_TXD_COMPLQ_COMPL_TYPE_M);
+		ctype = idpf_parse_compl_desc(tx_desc, complq, &tx_q,
+					      gen_flag);
 		switch (ctype) {
 		case IDPF_TXD_COMPLT_RE:
+			if (unlikely(!flow))
+				goto fetch_next_desc;
+
 			hw_head = le16_to_cpu(tx_desc->q_head_compl_tag.q_head);
 
 			idpf_tx_splitq_clean(tx_q, hw_head, budget,
 					     &cleaned_stats, true);
 			break;
 		case IDPF_TXD_COMPLT_RS:
-			idpf_tx_handle_rs_completion(tx_q, tx_desc,
-						     &cleaned_stats, budget);
+			if (flow)
+				idpf_tx_handle_rs_cmpl_fb(tx_q, tx_desc,
+							  &cleaned_stats,
+							  budget);
+			else
+				idpf_tx_handle_rs_cmpl_qb(tx_q, tx_desc,
+							  &cleaned_stats,
+							  budget);
 			break;
 		case IDPF_TXD_COMPLT_SW_MARKER:
 			idpf_tx_handle_sw_marker(tx_q);
 			break;
+		case -ENODATA:
+			goto exit_clean_complq;
+		case -EINVAL:
+			goto fetch_next_desc;
 		default:
-			netdev_err(tx_q->netdev,
+			netdev_err(complq->netdev,
 				   "Unknown TX completion type: %d\n", ctype);
 			goto fetch_next_desc;
 		}
@@ -2032,59 +2137,24 @@ static bool idpf_tx_clean_complq(struct idpf_compl_queue *complq, int budget,
 		u64_stats_update_end(&tx_q->stats_sync);
 
 fetch_next_desc:
-		tx_desc++;
+		pos++;
 		ntc++;
 		if (unlikely(!ntc)) {
 			ntc -= complq->desc_count;
-			tx_desc = &complq->comp[0];
-			idpf_queue_change(GEN_CHK, complq);
+			pos = 0;
+			gen_flag = !gen_flag;
 		}
 
+		tx_desc = flow ? &complq->comp[pos].common :
+			  &complq->comp_4b[pos];
 		prefetch(tx_desc);
 
 		/* update budget accounting */
 		complq_budget--;
 	} while (likely(complq_budget));
 
-	/* Store the state of the complq to be used later in deciding if a
-	 * TXQ can be started again
-	 */
-	if (unlikely(IDPF_TX_COMPLQ_PENDING(complq->txq_grp) >
-		     IDPF_TX_COMPLQ_OVERFLOW_THRESH(complq)))
-		complq_ok = false;
-
-	np = netdev_priv(complq->netdev);
-	for (i = 0; i < complq->txq_grp->num_txq; ++i) {
-		struct idpf_tx_queue *tx_q = complq->txq_grp->txqs[i];
-		struct netdev_queue *nq;
-		bool dont_wake;
-
-		/* We didn't clean anything on this queue, move along */
-		if (!tx_q->cleaned_bytes)
-			continue;
-
-		*cleaned += tx_q->cleaned_pkts;
-
-		/* Update BQL */
-		nq = netdev_get_tx_queue(tx_q->netdev, tx_q->idx);
-
-		dont_wake = !complq_ok || IDPF_TX_BUF_RSV_LOW(tx_q) ||
-			    np->state != __IDPF_VPORT_UP ||
-			    !netif_carrier_ok(tx_q->netdev);
-		/* Check if the TXQ needs to and can be restarted */
-		__netif_txq_completed_wake(nq, tx_q->cleaned_pkts, tx_q->cleaned_bytes,
-					   IDPF_DESC_UNUSED(tx_q), IDPF_TX_WAKE_THRESH,
-					   dont_wake);
-
-		/* Reset cleaned stats for the next time this queue is
-		 * cleaned
-		 */
-		tx_q->cleaned_bytes = 0;
-		tx_q->cleaned_pkts = 0;
-	}
-
-	ntc += complq->desc_count;
-	complq->next_to_clean = ntc;
+exit_clean_complq:
+	idpf_tx_finalize_complq(complq, ntc, gen_flag, cleaned);
 
 	return !!complq_budget;
 }
-- 
2.48.1


