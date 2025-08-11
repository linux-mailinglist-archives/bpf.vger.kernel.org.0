Return-Path: <bpf+bounces-65353-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A451B211B6
	for <lists+bpf@lfdr.de>; Mon, 11 Aug 2025 18:24:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B79A018A2521
	for <lists+bpf@lfdr.de>; Mon, 11 Aug 2025 16:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF1CD2E2DC4;
	Mon, 11 Aug 2025 16:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EwydkiLs"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 956DE2E2859;
	Mon, 11 Aug 2025 16:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754928788; cv=none; b=aDuXSMluliMZe5S5yD2g+k9y5sZU9I/La4aduM7h34FNUH0InDcKL6BoR3o/NJmZKXM8emcRPcf7kftIlAx6OdqRn9MQSKkwGjoKYuj0+0mF0FXWIBa93MVqBhHKyzs+QJY/z2sHkV4jXFGFXSeHw0LZWNC2HPkM0lNS2pVwJHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754928788; c=relaxed/simple;
	bh=C5Jh3SkVeWnr/L9uRLbmYtK7d9tUCOvfiBxyZp/umys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ALmQXNrUIKuiBFSwVxAcSfVQwgZsdhDPAFsmgzuHQ8gSgqJVWLR0HHFa4F/Atsy7Zsa9w4BUELpD7ixnP7KiNyauONrIIFmYeHD+6FB21bOEf8VWhfH1Pbf/Hk3u0+qLcG2FVlBNys/UmZFAG5vPpbVwVcfwKtIVr8FRD+6bl1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EwydkiLs; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754928787; x=1786464787;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=C5Jh3SkVeWnr/L9uRLbmYtK7d9tUCOvfiBxyZp/umys=;
  b=EwydkiLsqyTYUpEzYDDJkyQk6J5V+6bwKD+7eiGRNMIPVtgE+yVwZhmZ
   nvgWKd3+rKlKQJn7VBronOkPzjHDONI629pLlGHff/oyTVv5APFFBYyfF
   7xeS4jMRGWe+t5ZGJ0pHV0lTQHmuF/oZm8MbDd3fBNS9gdUfswuuesxLi
   1MQtjOKwgbIlE0AlK1bHLSSslk/Kbduu4+pCfdPBWjAqYPoKO9UmiM99r
   PmO9ttFkmBZRYKSFnpvXxPu2HKcjSV/WyOlOOwA6OgDS/4MNWd2MDsNhJ
   zvzfHoflM6q/N663bmaK76kHqyNjX/ZJ48Wxayu+8BMxl/IUWkozcsBuB
   w==;
X-CSE-ConnectionGUID: i6s/gVKsTRy9DzQ0mRFb0Q==
X-CSE-MsgGUID: x0tAY2yWQmWgGWVWpO78gg==
X-IronPort-AV: E=McAfee;i="6800,10657,11518"; a="56899603"
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="56899603"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2025 09:13:06 -0700
X-CSE-ConnectionGUID: 3cIqBxKsSUOyFbBXTe7g3A==
X-CSE-MsgGUID: AznHCsBxR52tuGFiqy7b9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="165163205"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa006.jf.intel.com with ESMTP; 11 Aug 2025 09:13:02 -0700
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
Subject: [PATCH iwl-next v4 05/13] idpf: add 4-byte completion descriptor definition
Date: Mon, 11 Aug 2025 18:10:36 +0200
Message-ID: <20250811161044.32329-6-aleksander.lobakin@intel.com>
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

From: Michal Kubiak <michal.kubiak@intel.com>

In the queue-based scheduling mode, Tx completion descriptor is 4 bytes
comparing to 8 bytes in flow-based.
Add definition for it and allocate the corresponding amount of memory
for the descriptors during the completion queue creation.
This does not include handling 4-byte completions during Tx polling, as
for now, the only user of QB will be XDP, which has its own routines.

Signed-off-by: Michal Kubiak <michal.kubiak@intel.com>
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 .../net/ethernet/intel/idpf/idpf_lan_txrx.h   |  6 +++-
 drivers/net/ethernet/intel/idpf/idpf_txrx.h   | 11 ++++--
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   | 34 +++++++++++--------
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
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index 834ff436d852..723190563eb2 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -95,8 +95,8 @@ static void idpf_compl_desc_rel(struct idpf_compl_queue *complq)
 		return;
 
 	dma_free_coherent(complq->netdev->dev.parent, complq->size,
-			  complq->comp, complq->dma);
-	complq->comp = NULL;
+			  complq->desc_ring, complq->dma);
+	complq->desc_ring = NULL;
 	complq->next_to_use = 0;
 	complq->next_to_clean = 0;
 }
@@ -225,12 +225,16 @@ static int idpf_tx_desc_alloc(const struct idpf_vport *vport,
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
@@ -1738,7 +1742,7 @@ static void idpf_tx_handle_rs_completion(struct idpf_tx_queue *txq,
 	/* RS completion contains queue head for queue based scheduling or
 	 * completion tag for flow based scheduling.
 	 */
-	u16 rs_compl_val = le16_to_cpu(desc->q_head_compl_tag.q_head);
+	u16 rs_compl_val = le16_to_cpu(desc->common.q_head_compl_tag.q_head);
 
 	if (!idpf_queue_has(FLOW_SCH_EN, txq)) {
 		idpf_tx_splitq_clean(txq, rs_compl_val, budget, cleaned, false);
@@ -1773,19 +1777,19 @@ static bool idpf_tx_clean_complq(struct idpf_compl_queue *complq, int budget,
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
@@ -1795,14 +1799,14 @@ static bool idpf_tx_clean_complq(struct idpf_compl_queue *complq, int budget,
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
-- 
2.50.1


