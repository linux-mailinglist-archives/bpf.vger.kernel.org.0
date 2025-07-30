Return-Path: <bpf+bounces-64714-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B55F0B1642E
	for <lists+bpf@lfdr.de>; Wed, 30 Jul 2025 18:09:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2AAD5408D5
	for <lists+bpf@lfdr.de>; Wed, 30 Jul 2025 16:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A0802DFF12;
	Wed, 30 Jul 2025 16:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kEasMkMH"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A1E2DFA38;
	Wed, 30 Jul 2025 16:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753891681; cv=none; b=nkUPRFrW6JhJGKsgsITHq3Y1hw2Sj3MWbrvwvkQDI70+EZPc+cfgKcZn0zkk8FAYcU69++rRtiTxpYVFqqVro5o3INPoqcsK3zCD89XqlojvPYjJsqepWyvjxEDkQ+s5dbGiYapbF3U4eKQVKznZk0zGKpMhfq5eAQpX8xeLiLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753891681; c=relaxed/simple;
	bh=iFdIu3q4bKeHjVsxAxW5j+y0lJTfdPS0eNCGIn0TM2g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mhYVxl2l/Oh3BYCAR6jhIMsOkFPXMq5Unzwabl8VS6RBlYYSVyGuaVcf4ma3TIxMZafFvy0NLAXI2omL+MxpTx0h9gCBCLxH8OcRmCmufhpIbMCJY17jttPr1Wj2wxIVtbl37162EDb0+0v72J4KPKWBGsHXJYG2c6uBwPtSNrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kEasMkMH; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753891680; x=1785427680;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iFdIu3q4bKeHjVsxAxW5j+y0lJTfdPS0eNCGIn0TM2g=;
  b=kEasMkMHomAsW9QZAPkmwQZ/NWs3fRwB1msVwCMiX8nn7SGH2L6zmphe
   lUOPRWtekxf4ad7xbrW9l2qF2xshrX3WqJB/mJndHF7NFT+dTUgCUkk+G
   O8qn1Vgtavg0E5p9osfJ3ZB/f8I6DyHHSRgegLlWEW5A/ZPD9GgqRxrsD
   G1dE3+AVPVbivZMDUvHp/zinyF9iKidpQv07yfbAsrQv+pNkY1jyHiOfx
   Rth4ZJJviRJqxzU9nPiOd26eA8Js2iPuQ8YO2oKazj2/btbA1a89iKFWD
   l1lQNaSMhXngKF4lXol/815aigudvDVBMxTsfjufaN3+wj/nBb4OiCLsd
   A==;
X-CSE-ConnectionGUID: 1LmDIMb8QXKXmfnKSLOTFw==
X-CSE-MsgGUID: HtMh4wxpQU+q2B718Eb8lg==
X-IronPort-AV: E=McAfee;i="6800,10657,11507"; a="67278757"
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; 
   d="scan'208";a="67278757"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2025 09:08:00 -0700
X-CSE-ConnectionGUID: ZVqNrNZ1TAGUloREMaL49A==
X-CSE-MsgGUID: aldWHSI+RRa6r1m0tx5PxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; 
   d="scan'208";a="163812869"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by fmviesa010.fm.intel.com with ESMTP; 30 Jul 2025 09:07:55 -0700
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
	linux-kernel@vger.kernel.org,
	Joshua Hay <joshua.a.hay@intel.com>,
	Madhu Chittim <madhu.chittim@intel.com>
Subject: [PATCH iwl-next v3 03/18] idpf: simplify and fix splitq Tx packet rollback error path
Date: Wed, 30 Jul 2025 18:07:02 +0200
Message-ID: <20250730160717.28976-4-aleksander.lobakin@intel.com>
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

From: Joshua Hay <joshua.a.hay@intel.com>

Move (and rename) the existing rollback logic to singleq.c since that
will be the only consumer. Create a simplified splitq specific rollback
function to loop through and unmap tx_bufs based on the completion tag.
This is critical before replacing the Tx buffer ring with the buffer
pool since the previous rollback indexing will not work to unmap the
chained buffers from the pool.

Cache the next_to_use index before any portion of the packet is put on
the descriptor ring. In case of an error, the rollback will bump tail to
the correct next_to_use value. Because the splitq path now supports
different types of context descriptors (and potentially multiple in the
future), this will take care of rolling back any and all context
descriptors encoded on the ring for the erroneous packet. The previous
rollback logic was broken for PTP packets since it would not account for
the PTP context descriptor.

Fixes: 1a49cf814fe1 ("idpf: add Tx timestamp flows")
Signed-off-by: Joshua Hay <joshua.a.hay@intel.com>
Reviewed-by: Madhu Chittim <madhu.chittim@intel.com>
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_txrx.h   |  5 +-
 .../ethernet/intel/idpf/idpf_singleq_txrx.c   | 57 +++++++++++-
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   | 91 ++++++++-----------
 3 files changed, 95 insertions(+), 58 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.h b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
index c75ca5d3e57c..a7632d845a2a 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
@@ -196,6 +196,7 @@ struct idpf_tx_offload_params {
  * @compl_tag: Associated tag for completion
  * @td_tag: Descriptor tunneling tag
  * @offload: Offload parameters
+ * @prev_ntu: stored TxQ next_to_use in case of rollback
  */
 struct idpf_tx_splitq_params {
 	enum idpf_tx_desc_dtype_value dtype;
@@ -206,6 +207,8 @@ struct idpf_tx_splitq_params {
 	};
 
 	struct idpf_tx_offload_params offload;
+
+	u16 prev_ntu;
 };
 
 enum idpf_tx_ctx_desc_eipt_offload {
@@ -1042,8 +1045,6 @@ void idpf_tx_buf_hw_update(struct idpf_tx_queue *tx_q, u32 val,
 			   bool xmit_more);
 unsigned int idpf_size_to_txd_count(unsigned int size);
 netdev_tx_t idpf_tx_drop_skb(struct idpf_tx_queue *tx_q, struct sk_buff *skb);
-void idpf_tx_dma_map_error(struct idpf_tx_queue *txq, struct sk_buff *skb,
-			   struct idpf_tx_buf *first, u16 ring_idx);
 unsigned int idpf_tx_desc_count_required(struct idpf_tx_queue *txq,
 					 struct sk_buff *skb);
 void idpf_tx_timeout(struct net_device *netdev, unsigned int txqueue);
diff --git a/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c
index 555879b1248d..57c0f5ab8f9e 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c
@@ -179,6 +179,58 @@ static int idpf_tx_singleq_csum(struct sk_buff *skb,
 	return 1;
 }
 
+/**
+ * idpf_tx_singleq_dma_map_error - handle TX DMA map errors
+ * @txq: queue to send buffer on
+ * @skb: send buffer
+ * @first: original first buffer info buffer for packet
+ * @idx: starting point on ring to unwind
+ */
+static void idpf_tx_singleq_dma_map_error(struct idpf_tx_queue *txq,
+					  struct sk_buff *skb,
+					  struct idpf_tx_buf *first, u16 idx)
+{
+	struct libeth_sq_napi_stats ss = { };
+	struct libeth_cq_pp cp = {
+		.dev	= txq->dev,
+		.ss	= &ss,
+	};
+
+	u64_stats_update_begin(&txq->stats_sync);
+	u64_stats_inc(&txq->q_stats.dma_map_errs);
+	u64_stats_update_end(&txq->stats_sync);
+
+	/* clear dma mappings for failed tx_buf map */
+	for (;;) {
+		struct idpf_tx_buf *tx_buf;
+
+		tx_buf = &txq->tx_buf[idx];
+		libeth_tx_complete(tx_buf, &cp);
+		if (tx_buf == first)
+			break;
+		if (idx == 0)
+			idx = txq->desc_count;
+		idx--;
+	}
+
+	if (skb_is_gso(skb)) {
+		union idpf_tx_flex_desc *tx_desc;
+
+		/* If we failed a DMA mapping for a TSO packet, we will have
+		 * used one additional descriptor for a context
+		 * descriptor. Reset that here.
+		 */
+		tx_desc = &txq->flex_tx[idx];
+		memset(tx_desc, 0, sizeof(*tx_desc));
+		if (idx == 0)
+			idx = txq->desc_count;
+		idx--;
+	}
+
+	/* Update tail in case netdev_xmit_more was previously true */
+	idpf_tx_buf_hw_update(txq, idx, false);
+}
+
 /**
  * idpf_tx_singleq_map - Build the Tx base descriptor
  * @tx_q: queue to send buffer on
@@ -219,8 +271,9 @@ static void idpf_tx_singleq_map(struct idpf_tx_queue *tx_q,
 	for (frag = &skb_shinfo(skb)->frags[0];; frag++) {
 		unsigned int max_data = IDPF_TX_MAX_DESC_DATA_ALIGNED;
 
-		if (dma_mapping_error(tx_q->dev, dma))
-			return idpf_tx_dma_map_error(tx_q, skb, first, i);
+		if (unlikely(dma_mapping_error(tx_q->dev, dma)))
+			return idpf_tx_singleq_dma_map_error(tx_q, skb,
+							     first, i);
 
 		/* record length, and DMA address */
 		dma_unmap_len_set(tx_buf, len, size);
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index 3262707c8fab..99d9081beef0 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -2339,57 +2339,6 @@ unsigned int idpf_tx_desc_count_required(struct idpf_tx_queue *txq,
 	return count;
 }
 
-/**
- * idpf_tx_dma_map_error - handle TX DMA map errors
- * @txq: queue to send buffer on
- * @skb: send buffer
- * @first: original first buffer info buffer for packet
- * @idx: starting point on ring to unwind
- */
-void idpf_tx_dma_map_error(struct idpf_tx_queue *txq, struct sk_buff *skb,
-			   struct idpf_tx_buf *first, u16 idx)
-{
-	struct libeth_sq_napi_stats ss = { };
-	struct libeth_cq_pp cp = {
-		.dev	= txq->dev,
-		.ss	= &ss,
-	};
-
-	u64_stats_update_begin(&txq->stats_sync);
-	u64_stats_inc(&txq->q_stats.dma_map_errs);
-	u64_stats_update_end(&txq->stats_sync);
-
-	/* clear dma mappings for failed tx_buf map */
-	for (;;) {
-		struct idpf_tx_buf *tx_buf;
-
-		tx_buf = &txq->tx_buf[idx];
-		libeth_tx_complete(tx_buf, &cp);
-		if (tx_buf == first)
-			break;
-		if (idx == 0)
-			idx = txq->desc_count;
-		idx--;
-	}
-
-	if (skb_is_gso(skb)) {
-		union idpf_tx_flex_desc *tx_desc;
-
-		/* If we failed a DMA mapping for a TSO packet, we will have
-		 * used one additional descriptor for a context
-		 * descriptor. Reset that here.
-		 */
-		tx_desc = &txq->flex_tx[idx];
-		memset(tx_desc, 0, sizeof(*tx_desc));
-		if (idx == 0)
-			idx = txq->desc_count;
-		idx--;
-	}
-
-	/* Update tail in case netdev_xmit_more was previously true */
-	idpf_tx_buf_hw_update(txq, idx, false);
-}
-
 /**
  * idpf_tx_splitq_bump_ntu - adjust NTU and generation
  * @txq: the tx ring to wrap
@@ -2438,6 +2387,37 @@ static bool idpf_tx_get_free_buf_id(struct idpf_sw_queue *refillq,
 	return true;
 }
 
+/**
+ * idpf_tx_splitq_pkt_err_unmap - Unmap buffers and bump tail in case of error
+ * @txq: Tx queue to unwind
+ * @params: pointer to splitq params struct
+ * @first: starting buffer for packet to unmap
+ */
+static void idpf_tx_splitq_pkt_err_unmap(struct idpf_tx_queue *txq,
+					 struct idpf_tx_splitq_params *params,
+					 struct idpf_tx_buf *first)
+{
+	struct libeth_sq_napi_stats ss = { };
+	struct idpf_tx_buf *tx_buf = first;
+	struct libeth_cq_pp cp = {
+		.dev    = txq->dev,
+		.ss     = &ss,
+	};
+	u32 idx = 0;
+
+	u64_stats_update_begin(&txq->stats_sync);
+	u64_stats_inc(&txq->q_stats.dma_map_errs);
+	u64_stats_update_end(&txq->stats_sync);
+
+	do {
+		libeth_tx_complete(tx_buf, &cp);
+		idpf_tx_clean_buf_ring_bump_ntc(txq, idx, tx_buf);
+	} while (idpf_tx_buf_compl_tag(tx_buf) == params->compl_tag);
+
+	/* Update tail in case netdev_xmit_more was previously true. */
+	idpf_tx_buf_hw_update(txq, params->prev_ntu, false);
+}
+
 /**
  * idpf_tx_splitq_map - Build the Tx flex descriptor
  * @tx_q: queue to send buffer on
@@ -2482,8 +2462,9 @@ static void idpf_tx_splitq_map(struct idpf_tx_queue *tx_q,
 	for (frag = &skb_shinfo(skb)->frags[0];; frag++) {
 		unsigned int max_data = IDPF_TX_MAX_DESC_DATA_ALIGNED;
 
-		if (dma_mapping_error(tx_q->dev, dma))
-			return idpf_tx_dma_map_error(tx_q, skb, first, i);
+		if (unlikely(dma_mapping_error(tx_q->dev, dma)))
+			return idpf_tx_splitq_pkt_err_unmap(tx_q, params,
+							    first);
 
 		first->nr_frags++;
 		idpf_tx_buf_compl_tag(tx_buf) = params->compl_tag;
@@ -2939,7 +2920,9 @@ static bool idpf_tx_splitq_need_re(struct idpf_tx_queue *tx_q)
 static netdev_tx_t idpf_tx_splitq_frame(struct sk_buff *skb,
 					struct idpf_tx_queue *tx_q)
 {
-	struct idpf_tx_splitq_params tx_params = { };
+	struct idpf_tx_splitq_params tx_params = {
+		.prev_ntu = tx_q->next_to_use,
+	};
 	union idpf_flex_tx_ctx_desc *ctx_desc;
 	struct idpf_tx_buf *first;
 	unsigned int count;
-- 
2.50.1


