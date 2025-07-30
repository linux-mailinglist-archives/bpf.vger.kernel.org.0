Return-Path: <bpf+bounces-64717-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6FCDB16437
	for <lists+bpf@lfdr.de>; Wed, 30 Jul 2025 18:10:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFFB518C5B36
	for <lists+bpf@lfdr.de>; Wed, 30 Jul 2025 16:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F24B2E1723;
	Wed, 30 Jul 2025 16:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HfvJF+st"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79352E11C8;
	Wed, 30 Jul 2025 16:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753891696; cv=none; b=Ov9IzQfA6Xfz21gWJ19Lj9mLFgwDADJOC+7fvVE8xBHROOrGt4eJDSNz6oLELJUyU3V8IQ6s4Y4sVc2mQzBvMD7b/J8CYNzORK/1Fr/oZff0V72WI6mmCfxOnmu1iGk/BWXlhoz/dugJQfrSk6uMYC5LB2ylTO9PYOFIx7Pl/70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753891696; c=relaxed/simple;
	bh=w+KqyWahV2NWonwdvqLkA1S5x8krAA3dHf4EMXh2WSQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KqA8J0rAKY9K1H70DiRQXMPZa+U98EkjqY3OZPJAqe05OrDyYeAuVnCy3hpQ/nsc4rRCU71/E3sQVinwKSkBfLbbdFwi+/3FepG3K7vbZhSUdPIO5WZ1BNhx/Bo96nRCYI2IJvnWNltg058BnrhGnNBB/NGoUiBPvZ8UF03malU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HfvJF+st; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753891694; x=1785427694;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=w+KqyWahV2NWonwdvqLkA1S5x8krAA3dHf4EMXh2WSQ=;
  b=HfvJF+st5dERGnHCR+kzLgEdLfQ1Jl2dyAxYYjHLub7tnrOcyxpP9q9s
   yTJvdqtzX+ALPriuK4G+RQfZdkGgJNQDq7Ygq8CJR5TxaO5UWxNTZr/2E
   xNQzLBMdckZXNLOpm0XB49GZz0wf4riGhGQ+HMgQiXQJSlsU0PdFCRVAa
   S+orHBpYmu50Ci/lMRB02AEe1IAIWK7wVzEZXyi4cx2MTjrq4VIEia3qi
   tOfhRwmbHvQuwu+FDLvPbBgjtmHL/XEhop7lviNb1TX3aZNCZ9FCahgrz
   2hJvXZoGCuteN0u/QYDBQEZPBqGJTSz6GCKZRPfVqemmDf29OzHpZuUhO
   Q==;
X-CSE-ConnectionGUID: xYbvZ2XeQqiLJfb/rovqwg==
X-CSE-MsgGUID: nAuTMPSLSWGb4sCwGR5Qzw==
X-IronPort-AV: E=McAfee;i="6800,10657,11507"; a="67278817"
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; 
   d="scan'208";a="67278817"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2025 09:08:14 -0700
X-CSE-ConnectionGUID: PN9T2pSCQIyV6kD5fFzVSQ==
X-CSE-MsgGUID: nYdgqv1ASHGjz/vWSuj9dA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; 
   d="scan'208";a="163812907"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by fmviesa010.fm.intel.com with ESMTP; 30 Jul 2025 09:08:09 -0700
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
Subject: [PATCH iwl-next v3 06/18] idpf: remove obsolete stashing code
Date: Wed, 30 Jul 2025 18:07:05 +0200
Message-ID: <20250730160717.28976-7-aleksander.lobakin@intel.com>
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

With the new Tx buffer management scheme, there is no need for all of
the stashing mechanisms, the hash table, the reserve buffer stack, etc.
Remove all of that.

Signed-off-by: Joshua Hay <joshua.a.hay@intel.com>
Reviewed-by: Madhu Chittim <madhu.chittim@intel.com>
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_txrx.h |  47 +--
 drivers/net/ethernet/intel/idpf/idpf_txrx.c | 314 ++------------------
 2 files changed, 22 insertions(+), 339 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.h b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
index 9565e4dc3514..52753dff381c 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
@@ -118,10 +118,6 @@ do {								\
 	((((txq)->next_to_clean > (txq)->next_to_use) ? 0 : (txq)->desc_count) + \
 	(txq)->next_to_clean - (txq)->next_to_use - 1)
 
-#define IDPF_TX_BUF_RSV_UNUSED(txq)	((txq)->stash->buf_stack.top)
-#define IDPF_TX_BUF_RSV_LOW(txq)	(IDPF_TX_BUF_RSV_UNUSED(txq) < \
-					 (txq)->desc_count >> 2)
-
 #define IDPF_TX_COMPLQ_OVERFLOW_THRESH(txcq)	((txcq)->desc_count >> 1)
 /* Determine the absolute number of completions pending, i.e. the number of
  * completions that are expected to arrive on the TX completion queue.
@@ -131,12 +127,6 @@ do {								\
 	0 : U32_MAX) + \
 	(txq)->num_completions_pending - (txq)->complq->num_completions)
 
-#define IDPF_TX_SPLITQ_COMPL_TAG_WIDTH	16
-/* Adjust the generation for the completion tag and wrap if necessary */
-#define IDPF_TX_ADJ_COMPL_TAG_GEN(txq) \
-	((++(txq)->compl_tag_cur_gen) >= (txq)->compl_tag_gen_max ? \
-	0 : (txq)->compl_tag_cur_gen)
-
 #define IDPF_TXBUF_NULL			U32_MAX
 
 #define IDPF_TXD_LAST_DESC_CMD (IDPF_TX_DESC_CMD_EOP | IDPF_TX_DESC_CMD_RS)
@@ -154,18 +144,6 @@ union idpf_tx_flex_desc {
 
 #define idpf_tx_buf libeth_sqe
 
-/**
- * struct idpf_buf_lifo - LIFO for managing OOO completions
- * @top: Used to know how many buffers are left
- * @size: Total size of LIFO
- * @bufs: Backing array
- */
-struct idpf_buf_lifo {
-	u16 top;
-	u16 size;
-	struct idpf_tx_stash **bufs;
-};
-
 /**
  * struct idpf_tx_offload_params - Offload parameters for a given packet
  * @tx_flags: Feature flags enabled for this packet
@@ -476,17 +454,6 @@ struct idpf_tx_queue_stats {
 #define IDPF_ITR_IDX_SPACING(spacing, dflt)	(spacing ? spacing : dflt)
 #define IDPF_DIM_DEFAULT_PROFILE_IX		1
 
-/**
- * struct idpf_txq_stash - Tx buffer stash for Flow-based scheduling mode
- * @buf_stack: Stack of empty buffers to store buffer info for out of order
- *	       buffer completions. See struct idpf_buf_lifo
- * @sched_buf_hash: Hash table to store buffers
- */
-struct idpf_txq_stash {
-	struct idpf_buf_lifo buf_stack;
-	DECLARE_HASHTABLE(sched_buf_hash, 12);
-} ____cacheline_aligned;
-
 /**
  * struct idpf_rx_queue - software structure representing a receive queue
  * @rx: universal receive descriptor array
@@ -631,11 +598,7 @@ libeth_cacheline_set_assert(struct idpf_rx_queue, 64,
  *		   only once at the end of the cleaning routine.
  * @clean_budget: singleq only, queue cleaning budget
  * @cleaned_pkts: Number of packets cleaned for the above said case
- * @stash: Tx buffer stash for Flow-based scheduling mode
  * @refillq: Pointer to refill queue
- * @compl_tag_bufid_m: Completion tag buffer id mask
- * @compl_tag_cur_gen: Used to keep track of current completion tag generation
- * @compl_tag_gen_max: To determine when compl_tag_cur_gen should be reset
  * @cached_tstamp_caps: Tx timestamp capabilities negotiated with the CP
  * @tstamp_task: Work that handles Tx timestamp read
  * @stats_sync: See struct u64_stats_sync
@@ -666,7 +629,6 @@ struct idpf_tx_queue {
 	u16 desc_count;
 
 	u16 tx_min_pkt_len;
-	u16 compl_tag_gen_s;
 
 	struct net_device *netdev;
 	__cacheline_group_end_aligned(read_mostly);
@@ -683,13 +645,8 @@ struct idpf_tx_queue {
 	};
 	u16 cleaned_pkts;
 
-	struct idpf_txq_stash *stash;
 	struct idpf_sw_queue *refillq;
 
-	u16 compl_tag_bufid_m;
-	u16 compl_tag_cur_gen;
-	u16 compl_tag_gen_max;
-
 	struct idpf_ptp_vport_tx_tstamp_caps *cached_tstamp_caps;
 	struct work_struct *tstamp_task;
 
@@ -707,7 +664,7 @@ struct idpf_tx_queue {
 	__cacheline_group_end_aligned(cold);
 };
 libeth_cacheline_set_assert(struct idpf_tx_queue, 64,
-			    120 + sizeof(struct u64_stats_sync),
+			    104 + sizeof(struct u64_stats_sync),
 			    32);
 
 /**
@@ -918,7 +875,6 @@ struct idpf_rxq_group {
  * @vport: Vport back pointer
  * @num_txq: Number of TX queues associated
  * @txqs: Array of TX queue pointers
- * @stashes: array of OOO stashes for the queues
  * @complq: Associated completion queue pointer, split queue only
  * @num_completions_pending: Total number of completions pending for the
  *			     completion queue, acculumated for all TX queues
@@ -933,7 +889,6 @@ struct idpf_txq_group {
 
 	u16 num_txq;
 	struct idpf_tx_queue *txqs[IDPF_LARGE_MAX_Q];
-	struct idpf_txq_stash *stashes;
 
 	struct idpf_compl_queue *complq;
 
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index edba032b990b..1dba069c8ff6 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -8,48 +8,12 @@
 #include "idpf_ptp.h"
 #include "idpf_virtchnl.h"
 
-struct idpf_tx_stash {
-	struct hlist_node hlist;
-	struct libeth_sqe buf;
-};
-
 #define idpf_tx_buf_next(buf)		(*(u32 *)&(buf)->priv)
-#define idpf_tx_buf_compl_tag(buf)	(*(u32 *)&(buf)->priv)
 LIBETH_SQE_CHECK_PRIV(u32);
 
 static bool idpf_chk_linearize(struct sk_buff *skb, unsigned int max_bufs,
 			       unsigned int count);
 
-/**
- * idpf_buf_lifo_push - push a buffer pointer onto stack
- * @stack: pointer to stack struct
- * @buf: pointer to buf to push
- *
- * Returns 0 on success, negative on failure
- **/
-static int idpf_buf_lifo_push(struct idpf_buf_lifo *stack,
-			      struct idpf_tx_stash *buf)
-{
-	if (unlikely(stack->top == stack->size))
-		return -ENOSPC;
-
-	stack->bufs[stack->top++] = buf;
-
-	return 0;
-}
-
-/**
- * idpf_buf_lifo_pop - pop a buffer pointer from stack
- * @stack: pointer to stack struct
- **/
-static struct idpf_tx_stash *idpf_buf_lifo_pop(struct idpf_buf_lifo *stack)
-{
-	if (unlikely(!stack->top))
-		return NULL;
-
-	return stack->bufs[--stack->top];
-}
-
 /**
  * idpf_tx_timeout - Respond to a Tx Hang
  * @netdev: network interface device structure
@@ -78,14 +42,11 @@ void idpf_tx_timeout(struct net_device *netdev, unsigned int txqueue)
 static void idpf_tx_buf_rel_all(struct idpf_tx_queue *txq)
 {
 	struct libeth_sq_napi_stats ss = { };
-	struct idpf_buf_lifo *buf_stack;
-	struct idpf_tx_stash *stash;
 	struct libeth_cq_pp cp = {
 		.dev	= txq->dev,
 		.ss	= &ss,
 	};
-	struct hlist_node *tmp;
-	u32 i, tag;
+	u32 i;
 
 	/* Buffers already cleared, nothing to do */
 	if (!txq->tx_buf)
@@ -97,33 +58,6 @@ static void idpf_tx_buf_rel_all(struct idpf_tx_queue *txq)
 
 	kfree(txq->tx_buf);
 	txq->tx_buf = NULL;
-
-	if (!idpf_queue_has(FLOW_SCH_EN, txq))
-		return;
-
-	buf_stack = &txq->stash->buf_stack;
-	if (!buf_stack->bufs)
-		return;
-
-	/*
-	 * If a Tx timeout occurred, there are potentially still bufs in the
-	 * hash table, free them here.
-	 */
-	hash_for_each_safe(txq->stash->sched_buf_hash, tag, tmp, stash,
-			   hlist) {
-		if (!stash)
-			continue;
-
-		libeth_tx_complete(&stash->buf, &cp);
-		hash_del(&stash->hlist);
-		idpf_buf_lifo_push(buf_stack, stash);
-	}
-
-	for (i = 0; i < buf_stack->size; i++)
-		kfree(buf_stack->bufs[i]);
-
-	kfree(buf_stack->bufs);
-	buf_stack->bufs = NULL;
 }
 
 /**
@@ -199,9 +133,6 @@ static void idpf_tx_desc_rel_all(struct idpf_vport *vport)
  */
 static int idpf_tx_buf_alloc_all(struct idpf_tx_queue *tx_q)
 {
-	struct idpf_buf_lifo *buf_stack;
-	int i;
-
 	/* Allocate book keeping buffers only. Buffers to be supplied to HW
 	 * are allocated by kernel network stack and received as part of skb
 	 */
@@ -213,29 +144,6 @@ static int idpf_tx_buf_alloc_all(struct idpf_tx_queue *tx_q)
 	if (!tx_q->tx_buf)
 		return -ENOMEM;
 
-	if (!idpf_queue_has(FLOW_SCH_EN, tx_q))
-		return 0;
-
-	buf_stack = &tx_q->stash->buf_stack;
-
-	/* Initialize tx buf stack for out-of-order completions if
-	 * flow scheduling offload is enabled
-	 */
-	buf_stack->bufs = kcalloc(tx_q->desc_count, sizeof(*buf_stack->bufs),
-				  GFP_KERNEL);
-	if (!buf_stack->bufs)
-		return -ENOMEM;
-
-	buf_stack->size = tx_q->desc_count;
-	buf_stack->top = tx_q->desc_count;
-
-	for (i = 0; i < tx_q->desc_count; i++) {
-		buf_stack->bufs[i] = kzalloc(sizeof(*buf_stack->bufs[i]),
-					     GFP_KERNEL);
-		if (!buf_stack->bufs[i])
-			return -ENOMEM;
-	}
-
 	return 0;
 }
 
@@ -349,8 +257,6 @@ static int idpf_tx_desc_alloc_all(struct idpf_vport *vport)
 	for (i = 0; i < vport->num_txq_grp; i++) {
 		for (j = 0; j < vport->txq_grps[i].num_txq; j++) {
 			struct idpf_tx_queue *txq = vport->txq_grps[i].txqs[j];
-			u8 gen_bits = 0;
-			u16 bufidx_mask;
 
 			err = idpf_tx_desc_alloc(vport, txq);
 			if (err) {
@@ -359,34 +265,6 @@ static int idpf_tx_desc_alloc_all(struct idpf_vport *vport)
 					i);
 				goto err_out;
 			}
-
-			if (!idpf_is_queue_model_split(vport->txq_model))
-				continue;
-
-			txq->compl_tag_cur_gen = 0;
-
-			/* Determine the number of bits in the bufid
-			 * mask and add one to get the start of the
-			 * generation bits
-			 */
-			bufidx_mask = txq->desc_count - 1;
-			while (bufidx_mask >> 1) {
-				txq->compl_tag_gen_s++;
-				bufidx_mask = bufidx_mask >> 1;
-			}
-			txq->compl_tag_gen_s++;
-
-			gen_bits = IDPF_TX_SPLITQ_COMPL_TAG_WIDTH -
-							txq->compl_tag_gen_s;
-			txq->compl_tag_gen_max = GETMAXVAL(gen_bits);
-
-			/* Set bufid mask based on location of first
-			 * gen bit; it cannot simply be the descriptor
-			 * ring size-1 since we can have size values
-			 * where not all of those bits are set.
-			 */
-			txq->compl_tag_bufid_m =
-				GETMAXVAL(txq->compl_tag_gen_s);
 		}
 
 		if (!idpf_is_queue_model_split(vport->txq_model))
@@ -1041,9 +919,6 @@ static void idpf_txq_group_rel(struct idpf_vport *vport)
 
 		kfree(txq_grp->complq);
 		txq_grp->complq = NULL;
-
-		if (flow_sch_en)
-			kfree(txq_grp->stashes);
 	}
 	kfree(vport->txq_grps);
 	vport->txq_grps = NULL;
@@ -1404,7 +1279,6 @@ static int idpf_txq_group_alloc(struct idpf_vport *vport, u16 num_txq)
 	for (i = 0; i < vport->num_txq_grp; i++) {
 		struct idpf_txq_group *tx_qgrp = &vport->txq_grps[i];
 		struct idpf_adapter *adapter = vport->adapter;
-		struct idpf_txq_stash *stashes;
 		int j;
 
 		tx_qgrp->vport = vport;
@@ -1417,15 +1291,6 @@ static int idpf_txq_group_alloc(struct idpf_vport *vport, u16 num_txq)
 				goto err_alloc;
 		}
 
-		if (split && flow_sch_en) {
-			stashes = kcalloc(num_txq, sizeof(*stashes),
-					  GFP_KERNEL);
-			if (!stashes)
-				goto err_alloc;
-
-			tx_qgrp->stashes = stashes;
-		}
-
 		for (j = 0; j < tx_qgrp->num_txq; j++) {
 			struct idpf_tx_queue *q = tx_qgrp->txqs[j];
 
@@ -1445,11 +1310,6 @@ static int idpf_txq_group_alloc(struct idpf_vport *vport, u16 num_txq)
 			if (!flow_sch_en)
 				continue;
 
-			if (split) {
-				q->stash = &stashes[j];
-				hash_init(q->stash->sched_buf_hash);
-			}
-
 			idpf_queue_set(FLOW_SCH_EN, q);
 
 			q->refillq = kzalloc(sizeof(*q->refillq), GFP_KERNEL);
@@ -1741,87 +1601,6 @@ static void idpf_tx_read_tstamp(struct idpf_tx_queue *txq, struct sk_buff *skb)
 	spin_unlock_bh(&tx_tstamp_caps->status_lock);
 }
 
-/**
- * idpf_tx_clean_stashed_bufs - clean bufs that were stored for
- * out of order completions
- * @txq: queue to clean
- * @compl_tag: completion tag of packet to clean (from completion descriptor)
- * @cleaned: pointer to stats struct to track cleaned packets/bytes
- * @budget: Used to determine if we are in netpoll
- */
-static void idpf_tx_clean_stashed_bufs(struct idpf_tx_queue *txq,
-				       u16 compl_tag,
-				       struct libeth_sq_napi_stats *cleaned,
-				       int budget)
-{
-	struct idpf_tx_stash *stash;
-	struct hlist_node *tmp_buf;
-	struct libeth_cq_pp cp = {
-		.dev	= txq->dev,
-		.ss	= cleaned,
-		.napi	= budget,
-	};
-
-	/* Buffer completion */
-	hash_for_each_possible_safe(txq->stash->sched_buf_hash, stash, tmp_buf,
-				    hlist, compl_tag) {
-		if (unlikely(idpf_tx_buf_compl_tag(&stash->buf) != compl_tag))
-			continue;
-
-		hash_del(&stash->hlist);
-
-		if (stash->buf.type == LIBETH_SQE_SKB &&
-		    (skb_shinfo(stash->buf.skb)->tx_flags & SKBTX_IN_PROGRESS))
-			idpf_tx_read_tstamp(txq, stash->buf.skb);
-
-		libeth_tx_complete(&stash->buf, &cp);
-
-		/* Push shadow buf back onto stack */
-		idpf_buf_lifo_push(&txq->stash->buf_stack, stash);
-	}
-}
-
-/**
- * idpf_stash_flow_sch_buffers - store buffer parameters info to be freed at a
- * later time (only relevant for flow scheduling mode)
- * @txq: Tx queue to clean
- * @tx_buf: buffer to store
- */
-static int idpf_stash_flow_sch_buffers(struct idpf_tx_queue *txq,
-				       struct idpf_tx_buf *tx_buf)
-{
-	struct idpf_tx_stash *stash;
-
-	if (unlikely(tx_buf->type <= LIBETH_SQE_CTX))
-		return 0;
-
-	stash = idpf_buf_lifo_pop(&txq->stash->buf_stack);
-	if (unlikely(!stash)) {
-		net_err_ratelimited("%s: No out-of-order TX buffers left!\n",
-				    netdev_name(txq->netdev));
-
-		return -ENOMEM;
-	}
-
-	/* Store buffer params in shadow buffer */
-	stash->buf.skb = tx_buf->skb;
-	stash->buf.bytes = tx_buf->bytes;
-	stash->buf.packets = tx_buf->packets;
-	stash->buf.type = tx_buf->type;
-	stash->buf.nr_frags = tx_buf->nr_frags;
-	dma_unmap_addr_set(&stash->buf, dma, dma_unmap_addr(tx_buf, dma));
-	dma_unmap_len_set(&stash->buf, len, dma_unmap_len(tx_buf, len));
-	idpf_tx_buf_compl_tag(&stash->buf) = idpf_tx_buf_compl_tag(tx_buf);
-
-	/* Add buffer to buf_hash table to be freed later */
-	hash_add(txq->stash->sched_buf_hash, &stash->hlist,
-		 idpf_tx_buf_compl_tag(&stash->buf));
-
-	tx_buf->type = LIBETH_SQE_EMPTY;
-
-	return 0;
-}
-
 #define idpf_tx_splitq_clean_bump_ntc(txq, ntc, desc, buf)	\
 do {								\
 	if (unlikely(++(ntc) == (txq)->desc_count)) {		\
@@ -1849,14 +1628,8 @@ do {								\
  * Separate packet completion events will be reported on the completion queue,
  * and the buffers will be cleaned separately. The stats are not updated from
  * this function when using flow-based scheduling.
- *
- * Furthermore, in flow scheduling mode, check to make sure there are enough
- * reserve buffers to stash the packet. If there are not, return early, which
- * will leave next_to_clean pointing to the packet that failed to be stashed.
- *
- * Return: false in the scenario above, true otherwise.
  */
-static bool idpf_tx_splitq_clean(struct idpf_tx_queue *tx_q, u16 end,
+static void idpf_tx_splitq_clean(struct idpf_tx_queue *tx_q, u16 end,
 				 int napi_budget,
 				 struct libeth_sq_napi_stats *cleaned,
 				 bool descs_only)
@@ -1870,12 +1643,11 @@ static bool idpf_tx_splitq_clean(struct idpf_tx_queue *tx_q, u16 end,
 		.napi	= napi_budget,
 	};
 	struct idpf_tx_buf *tx_buf;
-	bool clean_complete = true;
 
 	if (descs_only) {
 		/* Bump ring index to mark as cleaned. */
 		tx_q->next_to_clean = end;
-		return true;
+		return;
 	}
 
 	tx_desc = &tx_q->flex_tx[ntc];
@@ -1896,53 +1668,24 @@ static bool idpf_tx_splitq_clean(struct idpf_tx_queue *tx_q, u16 end,
 			break;
 
 		eop_idx = tx_buf->rs_idx;
+		libeth_tx_complete(tx_buf, &cp);
 
-		if (descs_only) {
-			if (IDPF_TX_BUF_RSV_UNUSED(tx_q) < tx_buf->nr_frags) {
-				clean_complete = false;
-				goto tx_splitq_clean_out;
-			}
-
-			idpf_stash_flow_sch_buffers(tx_q, tx_buf);
+		/* unmap remaining buffers */
+		while (ntc != eop_idx) {
+			idpf_tx_splitq_clean_bump_ntc(tx_q, ntc,
+						      tx_desc, tx_buf);
 
-			while (ntc != eop_idx) {
-				idpf_tx_splitq_clean_bump_ntc(tx_q, ntc,
-							      tx_desc, tx_buf);
-				idpf_stash_flow_sch_buffers(tx_q, tx_buf);
-			}
-		} else {
+			/* unmap any remaining paged data */
 			libeth_tx_complete(tx_buf, &cp);
-
-			/* unmap remaining buffers */
-			while (ntc != eop_idx) {
-				idpf_tx_splitq_clean_bump_ntc(tx_q, ntc,
-							      tx_desc, tx_buf);
-
-				/* unmap any remaining paged data */
-				libeth_tx_complete(tx_buf, &cp);
-			}
 		}
 
 fetch_next_txq_desc:
 		idpf_tx_splitq_clean_bump_ntc(tx_q, ntc, tx_desc, tx_buf);
 	}
 
-tx_splitq_clean_out:
 	tx_q->next_to_clean = ntc;
-
-	return clean_complete;
 }
 
-#define idpf_tx_clean_buf_ring_bump_ntc(txq, ntc, buf)	\
-do {							\
-	(buf)++;					\
-	(ntc)++;					\
-	if (unlikely((ntc) == (txq)->desc_count)) {	\
-		buf = (txq)->tx_buf;			\
-		ntc = 0;				\
-	}						\
-} while (0)
-
 /**
  * idpf_tx_clean_bufs - clean flow scheduling TX queue buffers
  * @txq: queue to clean
@@ -1953,7 +1696,7 @@ do {							\
  * Clean all buffers associated with the packet starting at buf_id. Returns the
  * byte/segment count for the cleaned packet.
  */
-static bool idpf_tx_clean_bufs(struct idpf_tx_queue *txq, u32 buf_id,
+static void idpf_tx_clean_bufs(struct idpf_tx_queue *txq, u32 buf_id,
 			       struct libeth_sq_napi_stats *cleaned,
 			       int budget)
 {
@@ -1980,8 +1723,6 @@ static bool idpf_tx_clean_bufs(struct idpf_tx_queue *txq, u32 buf_id,
 		libeth_tx_complete(tx_buf, &cp);
 		idpf_post_buf_refill(txq->refillq, buf_id);
 	}
-
-	return true;
 }
 
 /**
@@ -2000,22 +1741,17 @@ static void idpf_tx_handle_rs_completion(struct idpf_tx_queue *txq,
 					 struct libeth_sq_napi_stats *cleaned,
 					 int budget)
 {
-	u16 compl_tag;
+	/* RS completion contains queue head for queue based scheduling or
+	 * completion tag for flow based scheduling.
+	 */
+	u16 rs_compl_val = le16_to_cpu(desc->q_head_compl_tag.q_head);
 
 	if (!idpf_queue_has(FLOW_SCH_EN, txq)) {
-		u16 head = le16_to_cpu(desc->q_head_compl_tag.q_head);
-
-		idpf_tx_splitq_clean(txq, head, budget, cleaned, false);
+		idpf_tx_splitq_clean(txq, rs_compl_val, budget, cleaned, false);
 		return;
 	}
 
-	compl_tag = le16_to_cpu(desc->q_head_compl_tag.compl_tag);
-
-	/* If we didn't clean anything on the ring, this packet must be
-	 * in the hash table. Go clean it there.
-	 */
-	if (!idpf_tx_clean_bufs(txq, compl_tag, cleaned, budget))
-		idpf_tx_clean_stashed_bufs(txq, compl_tag, cleaned, budget);
+	idpf_tx_clean_bufs(txq, rs_compl_val, cleaned, budget);
 }
 
 /**
@@ -2132,8 +1868,7 @@ static bool idpf_tx_clean_complq(struct idpf_compl_queue *complq, int budget,
 		/* Update BQL */
 		nq = netdev_get_tx_queue(tx_q->netdev, tx_q->idx);
 
-		dont_wake = !complq_ok || IDPF_TX_BUF_RSV_LOW(tx_q) ||
-			    np->state != __IDPF_VPORT_UP ||
+		dont_wake = !complq_ok || np->state != __IDPF_VPORT_UP ||
 			    !netif_carrier_ok(tx_q->netdev);
 		/* Check if the TXQ needs to and can be restarted */
 		__netif_txq_completed_wake(nq, tx_q->cleaned_pkts, tx_q->cleaned_bytes,
@@ -2204,7 +1939,6 @@ static int idpf_txq_has_room(struct idpf_tx_queue *tx_q, u32 descs_needed,
 	if (IDPF_DESC_UNUSED(tx_q) < descs_needed ||
 	    IDPF_TX_COMPLQ_PENDING(tx_q->txq_grp) >
 		IDPF_TX_COMPLQ_OVERFLOW_THRESH(tx_q->txq_grp->complq) ||
-	    IDPF_TX_BUF_RSV_LOW(tx_q) ||
 	    idpf_tx_splitq_get_free_bufs(tx_q->refillq) < bufs_needed)
 		return 0;
 	return 1;
@@ -2328,10 +2062,8 @@ static unsigned int idpf_tx_splitq_bump_ntu(struct idpf_tx_queue *txq, u16 ntu)
 {
 	ntu++;
 
-	if (ntu == txq->desc_count) {
+	if (ntu == txq->desc_count)
 		ntu = 0;
-		txq->compl_tag_cur_gen = IDPF_TX_ADJ_COMPL_TAG_GEN(txq);
-	}
 
 	return ntu;
 }
@@ -2513,8 +2245,6 @@ static void idpf_tx_splitq_map(struct idpf_tx_queue *tx_q,
 			if (unlikely(++i == tx_q->desc_count)) {
 				tx_desc = &tx_q->flex_tx[0];
 				i = 0;
-				tx_q->compl_tag_cur_gen =
-					IDPF_TX_ADJ_COMPL_TAG_GEN(tx_q);
 			} else {
 				tx_desc++;
 			}
@@ -2545,7 +2275,6 @@ static void idpf_tx_splitq_map(struct idpf_tx_queue *tx_q,
 		if (unlikely(++i == tx_q->desc_count)) {
 			tx_desc = &tx_q->flex_tx[0];
 			i = 0;
-			tx_q->compl_tag_cur_gen = IDPF_TX_ADJ_COMPL_TAG_GEN(tx_q);
 		} else {
 			tx_desc++;
 		}
@@ -2979,10 +2708,9 @@ static netdev_tx_t idpf_tx_splitq_frame(struct sk_buff *skb,
 
 		tx_params.dtype = IDPF_TX_DESC_DTYPE_FLEX_FLOW_SCHE;
 		tx_params.eop_cmd = IDPF_TXD_FLEX_FLOW_CMD_EOP;
-		/* Set the RE bit to catch any packets that may have not been
-		 * stashed during RS completion cleaning. MIN_GAP is set to
-		 * MIN_RING size to ensure it will be set at least once each
-		 * time around the ring.
+		/* Set the RE bit to periodically "clean" the descriptor ring.
+		 * MIN_GAP is set to MIN_RING size to ensure it will be set at
+		 * least once each time around the ring.
 		 */
 		if (idpf_tx_splitq_need_re(tx_q)) {
 			tx_params.eop_cmd |= IDPF_TXD_FLEX_FLOW_CMD_RE;
-- 
2.50.1


