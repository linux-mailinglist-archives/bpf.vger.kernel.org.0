Return-Path: <bpf+bounces-69592-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7483DB9B229
	for <lists+bpf@lfdr.de>; Wed, 24 Sep 2025 19:53:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45F591B268EC
	for <lists+bpf@lfdr.de>; Wed, 24 Sep 2025 17:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9333031A55E;
	Wed, 24 Sep 2025 17:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LYvkg8J0"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3583317706;
	Wed, 24 Sep 2025 17:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758736367; cv=none; b=BfshrRPnHMPLZUj377fnNaUkCfKiSPNiD3PDGsGIq8W+c6fnE2lAr5OaEsyZOco/bbxLRyrvt5D4qgPjUwbHzUEInROb07+MP6iakjJYFW5QafF06AJXRBDtOoJY1CJ79f90J6T29aWkVPy9MzNSeTivO0zmg6evSAFG9T2qZjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758736367; c=relaxed/simple;
	bh=rACRW+7255V0EuHCJ2HpGZUDVdsNreY2brExN5EpqnY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n93l9+81E8xcw7Kq4a1n9bem2XlqkKkzuaYr1a+GTZHhW6R3qfnYH1BwQaeP05Ih46Qssw1itd3EIyraOVrgrrl+ChzzPolFwTVk4wISjp1QtcgZSq9t8CqqruWFTcMfYwRh0wWKXnbB42tFCx183YRU4YqvJOo3wYi95YLBmM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LYvkg8J0; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758736365; x=1790272365;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rACRW+7255V0EuHCJ2HpGZUDVdsNreY2brExN5EpqnY=;
  b=LYvkg8J0HGCg3+gFjOTW8XfRls3Tqkzp33/bsjb+pXdRXHZQ8jg38BVr
   kH7kIa/V4Te6HtmWOX/ACHI618pBIu4WateOoxCT53NBxgLiOI4AKa52t
   gSO3wVGrPcPfwLip1NdlvplTCuKacqq5DR97RQrOc2NKtiMbbIubkGF8I
   KoUpKVyr7q9gYDSrLMcbeBV7934GR2olf1X0e6VXijLcqpqejHTIKt8ID
   4FM9xz5y0161D9/lfzZmjzXHljH79kidPdW5VeErxkJoAi3djRFBtyPHs
   E5272tjyPWCCDiOEzXgF2C8hoInKLIoE0ClcKlufOVLwnrsxXd6Hq3H9j
   w==;
X-CSE-ConnectionGUID: 2VM7K4wCSQaNlenrG7iP1A==
X-CSE-MsgGUID: i0W89CQwRvuvRcqBMWm8vQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11563"; a="61152261"
X-IronPort-AV: E=Sophos;i="6.18,291,1751266800"; 
   d="scan'208";a="61152261"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2025 10:52:44 -0700
X-CSE-ConnectionGUID: Yo6JV70/Q9y17ZqRYeiC0w==
X-CSE-MsgGUID: fabfzRA/SUW8mlZMbbr3ZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,291,1751266800"; 
   d="scan'208";a="176701855"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa007.fm.intel.com with ESMTP; 24 Sep 2025 10:52:42 -0700
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
Subject: [PATCH net-next 4/5] idpf: implement Rx path for AF_XDP
Date: Wed, 24 Sep 2025 10:52:27 -0700
Message-ID: <20250924175230.1290529-5-anthony.l.nguyen@intel.com>
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

Implement Rx packet processing specific to AF_XDP ZC using the libeth
XSk infra. Initialize queue registers before allocating buffers to
avoid redundant ifs when updating the queue tail.

Co-developed-by: Michal Kubiak <michal.kubiak@intel.com>
Signed-off-by: Michal Kubiak <michal.kubiak@intel.com>
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Tested-by: Ramu R <ramu.r@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_lib.c  |   8 +-
 drivers/net/ethernet/intel/idpf/idpf_txrx.c |  35 ++-
 drivers/net/ethernet/intel/idpf/idpf_txrx.h |  38 ++-
 drivers/net/ethernet/intel/idpf/xdp.c       |  24 +-
 drivers/net/ethernet/intel/idpf/xsk.c       | 315 ++++++++++++++++++++
 drivers/net/ethernet/intel/idpf/xsk.h       |   6 +
 6 files changed, 405 insertions(+), 21 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
index 0559f1da88a9..9b8f7a6d65d6 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
@@ -1424,16 +1424,16 @@ static int idpf_vport_open(struct idpf_vport *vport, bool rtnl)
 		goto queues_rel;
 	}
 
-	err = idpf_rx_bufs_init_all(vport);
+	err = idpf_queue_reg_init(vport);
 	if (err) {
-		dev_err(&adapter->pdev->dev, "Failed to initialize RX buffers for vport %u: %d\n",
+		dev_err(&adapter->pdev->dev, "Failed to initialize queue registers for vport %u: %d\n",
 			vport->vport_id, err);
 		goto queues_rel;
 	}
 
-	err = idpf_queue_reg_init(vport);
+	err = idpf_rx_bufs_init_all(vport);
 	if (err) {
-		dev_err(&adapter->pdev->dev, "Failed to initialize queue registers for vport %u: %d\n",
+		dev_err(&adapter->pdev->dev, "Failed to initialize RX buffers for vport %u: %d\n",
 			vport->vport_id, err);
 		goto queues_rel;
 	}
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index 64d5211f6e51..67963c0f4541 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -389,6 +389,11 @@ static void idpf_rx_buf_rel_bufq(struct idpf_buf_queue *bufq)
 	if (!bufq->buf)
 		return;
 
+	if (idpf_queue_has(XSK, bufq)) {
+		idpf_xskfq_rel(bufq);
+		return;
+	}
+
 	/* Free all the bufs allocated and given to hw on Rx queue */
 	for (u32 i = 0; i < bufq->desc_count; i++)
 		idpf_rx_page_rel(&bufq->buf[i]);
@@ -437,11 +442,14 @@ static void idpf_rx_desc_rel(struct idpf_rx_queue *rxq, struct device *dev,
 	if (!rxq)
 		return;
 
-	libeth_xdp_return_stash(&rxq->xdp);
+	if (!idpf_queue_has(XSK, rxq))
+		libeth_xdp_return_stash(&rxq->xdp);
 
 	if (!idpf_is_queue_model_split(model))
 		idpf_rx_buf_rel_all(rxq);
 
+	idpf_xsk_clear_queue(rxq, VIRTCHNL2_QUEUE_TYPE_RX);
+
 	rxq->next_to_alloc = 0;
 	rxq->next_to_clean = 0;
 	rxq->next_to_use = 0;
@@ -464,6 +472,7 @@ static void idpf_rx_desc_rel_bufq(struct idpf_buf_queue *bufq,
 		return;
 
 	idpf_rx_buf_rel_bufq(bufq);
+	idpf_xsk_clear_queue(bufq, VIRTCHNL2_QUEUE_TYPE_RX_BUFFER);
 
 	bufq->next_to_alloc = 0;
 	bufq->next_to_clean = 0;
@@ -751,6 +760,9 @@ static int idpf_rx_bufs_init(struct idpf_buf_queue *bufq,
 	};
 	int ret;
 
+	if (idpf_queue_has(XSK, bufq))
+		return idpf_xskfq_init(bufq);
+
 	ret = libeth_rx_fq_create(&fq, &bufq->q_vector->napi);
 	if (ret)
 		return ret;
@@ -846,6 +858,8 @@ static int idpf_rx_desc_alloc(const struct idpf_vport *vport,
 	rxq->next_to_use = 0;
 	idpf_queue_set(GEN_CHK, rxq);
 
+	idpf_xsk_setup_queue(vport, rxq, VIRTCHNL2_QUEUE_TYPE_RX);
+
 	return 0;
 }
 
@@ -871,9 +885,10 @@ static int idpf_bufq_desc_alloc(const struct idpf_vport *vport,
 	bufq->next_to_alloc = 0;
 	bufq->next_to_clean = 0;
 	bufq->next_to_use = 0;
-
 	idpf_queue_set(GEN_CHK, bufq);
 
+	idpf_xsk_setup_queue(vport, bufq, VIRTCHNL2_QUEUE_TYPE_RX_BUFFER);
+
 	return 0;
 }
 
@@ -3381,9 +3396,9 @@ __idpf_rx_process_skb_fields(struct idpf_rx_queue *rxq, struct sk_buff *skb,
 	return 0;
 }
 
-static bool idpf_rx_process_skb_fields(struct sk_buff *skb,
-				       const struct libeth_xdp_buff *xdp,
-				       struct libeth_rq_napi_stats *rs)
+bool idpf_rx_process_skb_fields(struct sk_buff *skb,
+				const struct libeth_xdp_buff *xdp,
+				struct libeth_rq_napi_stats *rs)
 {
 	struct idpf_rx_queue *rxq;
 
@@ -4242,7 +4257,9 @@ static bool idpf_rx_splitq_clean_all(struct idpf_q_vector *q_vec, int budget,
 		struct idpf_rx_queue *rxq = q_vec->rx[i];
 		int pkts_cleaned_per_q;
 
-		pkts_cleaned_per_q = idpf_rx_splitq_clean(rxq, budget_per_q);
+		pkts_cleaned_per_q = idpf_queue_has(XSK, rxq) ?
+				     idpf_xskrq_poll(rxq, budget_per_q) :
+				     idpf_rx_splitq_clean(rxq, budget_per_q);
 		/* if we clean as many as budgeted, we must not be done */
 		if (pkts_cleaned_per_q >= budget_per_q)
 			clean_complete = false;
@@ -4252,8 +4269,10 @@ static bool idpf_rx_splitq_clean_all(struct idpf_q_vector *q_vec, int budget,
 
 	nid = numa_mem_id();
 
-	for (i = 0; i < q_vec->num_bufq; i++)
-		idpf_rx_clean_refillq_all(q_vec->bufq[i], nid);
+	for (i = 0; i < q_vec->num_bufq; i++) {
+		if (!idpf_queue_has(XSK, q_vec->bufq[i]))
+			idpf_rx_clean_refillq_all(q_vec->bufq[i], nid);
+	}
 
 	return clean_complete;
 }
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.h b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
index e8e63027425c..a42aa4669c3c 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
@@ -141,6 +141,8 @@ do {								\
 #define IDPF_TX_FLAGS_TUNNEL		BIT(3)
 #define IDPF_TX_FLAGS_TSYN		BIT(4)
 
+struct libeth_rq_napi_stats;
+
 union idpf_tx_flex_desc {
 	struct idpf_flex_tx_desc q; /* queue based scheduling */
 	struct idpf_flex_tx_sched_desc flow; /* flow based scheduling */
@@ -491,6 +493,8 @@ struct idpf_tx_queue_stats {
  * @next_to_clean: Next descriptor to clean
  * @next_to_alloc: RX buffer to allocate at
  * @xdp: XDP buffer with the current frame
+ * @xsk: current XDP buffer in XSk mode
+ * @pool: XSk pool if installed
  * @cached_phc_time: Cached PHC time for the Rx queue
  * @stats_sync: See struct u64_stats_sync
  * @q_stats: See union idpf_rx_queue_stats
@@ -546,7 +550,13 @@ struct idpf_rx_queue {
 	u32 next_to_clean;
 	u32 next_to_alloc;
 
-	struct libeth_xdp_buff_stash xdp;
+	union {
+		struct libeth_xdp_buff_stash xdp;
+		struct {
+			struct libeth_xdp_buff *xsk;
+			struct xsk_buff_pool *pool;
+		};
+	};
 	u64 cached_phc_time;
 
 	struct u64_stats_sync stats_sync;
@@ -711,16 +721,20 @@ libeth_cacheline_set_assert(struct idpf_tx_queue, 64,
 /**
  * struct idpf_buf_queue - software structure representing a buffer queue
  * @split_buf: buffer descriptor array
- * @hdr_buf: &libeth_fqe for header buffers
- * @hdr_pp: &page_pool for header buffers
  * @buf: &libeth_fqe for data buffers
  * @pp: &page_pool for data buffers
+ * @xsk_buf: &xdp_buff for XSk Rx buffers
+ * @pool: &xsk_buff_pool on XSk queues
+ * @hdr_buf: &libeth_fqe for header buffers
+ * @hdr_pp: &page_pool for header buffers
  * @tail: Tail offset
  * @flags: See enum idpf_queue_flags_t
  * @desc_count: Number of descriptors
+ * @thresh: refill threshold in XSk
  * @next_to_use: Next descriptor to use
  * @next_to_clean: Next descriptor to clean
  * @next_to_alloc: RX buffer to allocate at
+ * @pending: number of buffers to refill (Xsk)
  * @hdr_truesize: truesize for buffer headers
  * @truesize: truesize for data buffers
  * @q_id: Queue id
@@ -734,14 +748,24 @@ libeth_cacheline_set_assert(struct idpf_tx_queue, 64,
 struct idpf_buf_queue {
 	__cacheline_group_begin_aligned(read_mostly);
 	struct virtchnl2_splitq_rx_buf_desc *split_buf;
+	union {
+		struct {
+			struct libeth_fqe *buf;
+			struct page_pool *pp;
+		};
+		struct {
+			struct libeth_xdp_buff **xsk_buf;
+			struct xsk_buff_pool *pool;
+		};
+	};
 	struct libeth_fqe *hdr_buf;
 	struct page_pool *hdr_pp;
-	struct libeth_fqe *buf;
-	struct page_pool *pp;
 	void __iomem *tail;
 
 	DECLARE_BITMAP(flags, __IDPF_Q_FLAGS_NBITS);
 	u32 desc_count;
+
+	u32 thresh;
 	__cacheline_group_end_aligned(read_mostly);
 
 	__cacheline_group_begin_aligned(read_write);
@@ -749,6 +773,7 @@ struct idpf_buf_queue {
 	u32 next_to_clean;
 	u32 next_to_alloc;
 
+	u32 pending;
 	u32 hdr_truesize;
 	u32 truesize;
 	__cacheline_group_end_aligned(read_write);
@@ -1079,6 +1104,9 @@ netdev_tx_t idpf_tx_singleq_frame(struct sk_buff *skb,
 netdev_tx_t idpf_tx_start(struct sk_buff *skb, struct net_device *netdev);
 bool idpf_rx_singleq_buf_hw_alloc_all(struct idpf_rx_queue *rxq,
 				      u16 cleaned_count);
+bool idpf_rx_process_skb_fields(struct sk_buff *skb,
+				const struct libeth_xdp_buff *xdp,
+				struct libeth_rq_napi_stats *rs);
 int idpf_tso(struct sk_buff *skb, struct idpf_tx_offload_params *off);
 
 void idpf_wait_for_sw_marker_completion(const struct idpf_tx_queue *txq);
diff --git a/drivers/net/ethernet/intel/idpf/xdp.c b/drivers/net/ethernet/intel/idpf/xdp.c
index 2b8b75a16804..cde6d56553d2 100644
--- a/drivers/net/ethernet/intel/idpf/xdp.c
+++ b/drivers/net/ethernet/intel/idpf/xdp.c
@@ -46,7 +46,6 @@ static int __idpf_xdp_rxq_info_init(struct idpf_rx_queue *rxq, void *arg)
 {
 	const struct idpf_vport *vport = rxq->q_vector->vport;
 	bool split = idpf_is_queue_model_split(vport->rxq_model);
-	const struct page_pool *pp;
 	int err;
 
 	err = __xdp_rxq_info_reg(&rxq->xdp_rxq, vport->netdev, rxq->idx,
@@ -55,8 +54,18 @@ static int __idpf_xdp_rxq_info_init(struct idpf_rx_queue *rxq, void *arg)
 	if (err)
 		return err;
 
-	pp = split ? rxq->bufq_sets[0].bufq.pp : rxq->pp;
-	xdp_rxq_info_attach_page_pool(&rxq->xdp_rxq, pp);
+	if (idpf_queue_has(XSK, rxq)) {
+		err = xdp_rxq_info_reg_mem_model(&rxq->xdp_rxq,
+						 MEM_TYPE_XSK_BUFF_POOL,
+						 rxq->pool);
+		if (err)
+			goto unreg;
+	} else {
+		const struct page_pool *pp;
+
+		pp = split ? rxq->bufq_sets[0].bufq.pp : rxq->pp;
+		xdp_rxq_info_attach_page_pool(&rxq->xdp_rxq, pp);
+	}
 
 	if (!split)
 		return 0;
@@ -65,6 +74,11 @@ static int __idpf_xdp_rxq_info_init(struct idpf_rx_queue *rxq, void *arg)
 	rxq->num_xdp_txq = vport->num_xdp_txq;
 
 	return 0;
+
+unreg:
+	xdp_rxq_info_unreg(&rxq->xdp_rxq);
+
+	return err;
 }
 
 int idpf_xdp_rxq_info_init(struct idpf_rx_queue *rxq)
@@ -84,7 +98,9 @@ static int __idpf_xdp_rxq_info_deinit(struct idpf_rx_queue *rxq, void *arg)
 		rxq->num_xdp_txq = 0;
 	}
 
-	xdp_rxq_info_detach_mem_model(&rxq->xdp_rxq);
+	if (!idpf_queue_has(XSK, rxq))
+		xdp_rxq_info_detach_mem_model(&rxq->xdp_rxq);
+
 	xdp_rxq_info_unreg(&rxq->xdp_rxq);
 
 	return 0;
diff --git a/drivers/net/ethernet/intel/idpf/xsk.c b/drivers/net/ethernet/intel/idpf/xsk.c
index 5c9f6f0a9fae..ba35dca946d5 100644
--- a/drivers/net/ethernet/intel/idpf/xsk.c
+++ b/drivers/net/ethernet/intel/idpf/xsk.c
@@ -9,6 +9,47 @@
 
 static void idpf_xsk_tx_timer(struct work_struct *work);
 
+static void idpf_xsk_setup_rxq(const struct idpf_vport *vport,
+			       struct idpf_rx_queue *rxq)
+{
+	struct xsk_buff_pool *pool;
+
+	pool = xsk_get_pool_from_qid(vport->netdev, rxq->idx);
+	if (!pool || !pool->dev || !xsk_buff_can_alloc(pool, 1))
+		return;
+
+	rxq->pool = pool;
+
+	idpf_queue_set(XSK, rxq);
+}
+
+static void idpf_xsk_setup_bufq(const struct idpf_vport *vport,
+				struct idpf_buf_queue *bufq)
+{
+	struct xsk_buff_pool *pool;
+	u32 qid = U32_MAX;
+
+	for (u32 i = 0; i < vport->num_rxq_grp; i++) {
+		const struct idpf_rxq_group *grp = &vport->rxq_grps[i];
+
+		for (u32 j = 0; j < vport->num_bufqs_per_qgrp; j++) {
+			if (&grp->splitq.bufq_sets[j].bufq == bufq) {
+				qid = grp->splitq.rxq_sets[0]->rxq.idx;
+				goto setup;
+			}
+		}
+	}
+
+setup:
+	pool = xsk_get_pool_from_qid(vport->netdev, qid);
+	if (!pool || !pool->dev || !xsk_buff_can_alloc(pool, 1))
+		return;
+
+	bufq->pool = pool;
+
+	idpf_queue_set(XSK, bufq);
+}
+
 static void idpf_xsk_setup_txq(const struct idpf_vport *vport,
 			       struct idpf_tx_queue *txq)
 {
@@ -61,6 +102,12 @@ void idpf_xsk_setup_queue(const struct idpf_vport *vport, void *q,
 		return;
 
 	switch (type) {
+	case VIRTCHNL2_QUEUE_TYPE_RX:
+		idpf_xsk_setup_rxq(vport, q);
+		break;
+	case VIRTCHNL2_QUEUE_TYPE_RX_BUFFER:
+		idpf_xsk_setup_bufq(vport, q);
+		break;
 	case VIRTCHNL2_QUEUE_TYPE_TX:
 		idpf_xsk_setup_txq(vport, q);
 		break;
@@ -75,9 +122,25 @@ void idpf_xsk_setup_queue(const struct idpf_vport *vport, void *q,
 void idpf_xsk_clear_queue(void *q, enum virtchnl2_queue_type type)
 {
 	struct idpf_compl_queue *complq;
+	struct idpf_buf_queue *bufq;
+	struct idpf_rx_queue *rxq;
 	struct idpf_tx_queue *txq;
 
 	switch (type) {
+	case VIRTCHNL2_QUEUE_TYPE_RX:
+		rxq = q;
+		if (!idpf_queue_has_clear(XSK, rxq))
+			return;
+
+		rxq->pool = NULL;
+		break;
+	case VIRTCHNL2_QUEUE_TYPE_RX_BUFFER:
+		bufq = q;
+		if (!idpf_queue_has_clear(XSK, bufq))
+			return;
+
+		bufq->pool = NULL;
+		break;
 	case VIRTCHNL2_QUEUE_TYPE_TX:
 		txq = q;
 		if (!idpf_queue_has_clear(XSK, txq))
@@ -197,6 +260,31 @@ static __always_inline u32 idpf_xsksq_complete(void *_xdpsq, u32 budget)
 	return done_frames;
 }
 
+static u32 idpf_xsk_tx_prep(void *_xdpsq, struct libeth_xdpsq *sq)
+{
+	struct idpf_tx_queue *xdpsq = _xdpsq;
+	u32 free;
+
+	libeth_xdpsq_lock(&xdpsq->xdp_lock);
+
+	free = xdpsq->desc_count - xdpsq->pending;
+	if (free < xdpsq->thresh)
+		free += idpf_xsksq_complete(xdpsq, xdpsq->thresh);
+
+	*sq = (struct libeth_xdpsq){
+		.pool		= xdpsq->pool,
+		.sqes		= xdpsq->tx_buf,
+		.descs		= xdpsq->desc_ring,
+		.count		= xdpsq->desc_count,
+		.lock		= &xdpsq->xdp_lock,
+		.ntu		= &xdpsq->next_to_use,
+		.pending	= &xdpsq->pending,
+		.xdp_tx		= &xdpsq->xdp_tx,
+	};
+
+	return free;
+}
+
 static u32 idpf_xsk_xmit_prep(void *_xdpsq, struct libeth_xdpsq *sq)
 {
 	struct idpf_tx_queue *xdpsq = _xdpsq;
@@ -236,8 +324,225 @@ bool idpf_xsk_xmit(struct idpf_tx_queue *xsksq)
 
 LIBETH_XDP_DEFINE_START();
 LIBETH_XDP_DEFINE_TIMER(static idpf_xsk_tx_timer, idpf_xsksq_complete);
+LIBETH_XSK_DEFINE_FLUSH_TX(static idpf_xsk_tx_flush_bulk, idpf_xsk_tx_prep,
+			   idpf_xdp_tx_xmit);
+LIBETH_XSK_DEFINE_RUN(static idpf_xsk_run_pass, idpf_xsk_run_prog,
+		      idpf_xsk_tx_flush_bulk, idpf_rx_process_skb_fields);
+LIBETH_XSK_DEFINE_FINALIZE(static idpf_xsk_finalize_rx, idpf_xsk_tx_flush_bulk,
+			   idpf_xdp_tx_finalize);
 LIBETH_XDP_DEFINE_END();
 
+static void idpf_xskfqe_init(const struct libeth_xskfq_fp *fq, u32 i)
+{
+	struct virtchnl2_splitq_rx_buf_desc *desc = fq->descs;
+
+	desc = &desc[i];
+#ifdef __LIBETH_WORD_ACCESS
+	*(u64 *)&desc->qword0 = i;
+#else
+	desc->qword0.buf_id = cpu_to_le16(i);
+#endif
+	desc->pkt_addr = cpu_to_le64(libeth_xsk_buff_xdp_get_dma(fq->fqes[i]));
+}
+
+static bool idpf_xskfq_refill_thresh(struct idpf_buf_queue *bufq, u32 count)
+{
+	struct libeth_xskfq_fp fq = {
+		.pool	= bufq->pool,
+		.fqes	= bufq->xsk_buf,
+		.descs	= bufq->split_buf,
+		.ntu	= bufq->next_to_use,
+		.count	= bufq->desc_count,
+	};
+	u32 done;
+
+	done = libeth_xskfqe_alloc(&fq, count, idpf_xskfqe_init);
+	writel(fq.ntu, bufq->tail);
+
+	bufq->next_to_use = fq.ntu;
+	bufq->pending -= done;
+
+	return done == count;
+}
+
+static bool idpf_xskfq_refill(struct idpf_buf_queue *bufq)
+{
+	u32 count, rx_thresh = bufq->thresh;
+
+	count = ALIGN_DOWN(bufq->pending - 1, rx_thresh);
+
+	for (u32 i = 0; i < count; i += rx_thresh) {
+		if (unlikely(!idpf_xskfq_refill_thresh(bufq, rx_thresh)))
+			return false;
+	}
+
+	return true;
+}
+
+int idpf_xskfq_init(struct idpf_buf_queue *bufq)
+{
+	struct libeth_xskfq fq = {
+		.pool	= bufq->pool,
+		.count	= bufq->desc_count,
+		.nid	= idpf_q_vector_to_mem(bufq->q_vector),
+	};
+	int ret;
+
+	ret = libeth_xskfq_create(&fq);
+	if (ret)
+		return ret;
+
+	bufq->xsk_buf = fq.fqes;
+	bufq->pending = fq.pending;
+	bufq->thresh = fq.thresh;
+	bufq->rx_buf_size = fq.buf_len;
+
+	if (!idpf_xskfq_refill(bufq))
+		netdev_err(bufq->pool->netdev,
+			   "failed to allocate XSk buffers for qid %d\n",
+			   bufq->pool->queue_id);
+
+	bufq->next_to_alloc = bufq->next_to_use;
+
+	idpf_queue_clear(HSPLIT_EN, bufq);
+	bufq->rx_hbuf_size = 0;
+
+	return 0;
+}
+
+void idpf_xskfq_rel(struct idpf_buf_queue *bufq)
+{
+	struct libeth_xskfq fq = {
+		.fqes	= bufq->xsk_buf,
+	};
+
+	libeth_xskfq_destroy(&fq);
+
+	bufq->rx_buf_size = fq.buf_len;
+	bufq->thresh = fq.thresh;
+	bufq->pending = fq.pending;
+}
+
+struct idpf_xskfq_refill_set {
+	struct {
+		struct idpf_buf_queue	*q;
+		u32			buf_id;
+		u32			pending;
+	} bufqs[IDPF_MAX_BUFQS_PER_RXQ_GRP];
+};
+
+static bool idpf_xskfq_refill_set(const struct idpf_xskfq_refill_set *set)
+{
+	bool ret = true;
+
+	for (u32 i = 0; i < ARRAY_SIZE(set->bufqs); i++) {
+		struct idpf_buf_queue *bufq = set->bufqs[i].q;
+		u32 ntc;
+
+		if (!bufq)
+			continue;
+
+		ntc = set->bufqs[i].buf_id;
+		if (unlikely(++ntc == bufq->desc_count))
+			ntc = 0;
+
+		bufq->next_to_clean = ntc;
+		bufq->pending += set->bufqs[i].pending;
+
+		if (bufq->pending > bufq->thresh)
+			ret &= idpf_xskfq_refill(bufq);
+	}
+
+	return ret;
+}
+
+int idpf_xskrq_poll(struct idpf_rx_queue *rxq, u32 budget)
+{
+	struct idpf_xskfq_refill_set set = { };
+	struct libeth_rq_napi_stats rs = { };
+	bool wake, gen, fail = false;
+	u32 ntc = rxq->next_to_clean;
+	struct libeth_xdp_buff *xdp;
+	LIBETH_XDP_ONSTACK_BULK(bq);
+	u32 cnt = rxq->desc_count;
+
+	wake = xsk_uses_need_wakeup(rxq->pool);
+	if (wake)
+		xsk_clear_rx_need_wakeup(rxq->pool);
+
+	gen = idpf_queue_has(GEN_CHK, rxq);
+
+	libeth_xsk_tx_init_bulk(&bq, rxq->xdp_prog, rxq->xdp_rxq.dev,
+				rxq->xdpsqs, rxq->num_xdp_txq);
+	xdp = rxq->xsk;
+
+	while (likely(rs.packets < budget)) {
+		const struct virtchnl2_rx_flex_desc_adv_nic_3 *rx_desc;
+		struct idpf_xdp_rx_desc desc __uninitialized;
+		struct idpf_buf_queue *bufq;
+		u32 bufq_id, buf_id;
+
+		rx_desc = &rxq->rx[ntc].flex_adv_nic_3_wb;
+
+		idpf_xdp_get_qw0(&desc, rx_desc);
+		if (idpf_xdp_rx_gen(&desc) != gen)
+			break;
+
+		dma_rmb();
+
+		bufq_id = idpf_xdp_rx_bufq(&desc);
+		bufq = set.bufqs[bufq_id].q;
+		if (!bufq) {
+			bufq = &rxq->bufq_sets[bufq_id].bufq;
+			set.bufqs[bufq_id].q = bufq;
+		}
+
+		idpf_xdp_get_qw1(&desc, rx_desc);
+		buf_id = idpf_xdp_rx_buf(&desc);
+
+		set.bufqs[bufq_id].buf_id = buf_id;
+		set.bufqs[bufq_id].pending++;
+
+		xdp = libeth_xsk_process_buff(xdp, bufq->xsk_buf[buf_id],
+					      idpf_xdp_rx_len(&desc));
+
+		if (unlikely(++ntc == cnt)) {
+			ntc = 0;
+			gen = !gen;
+			idpf_queue_change(GEN_CHK, rxq);
+		}
+
+		if (!idpf_xdp_rx_eop(&desc) || unlikely(!xdp))
+			continue;
+
+		fail = !idpf_xsk_run_pass(xdp, &bq, rxq->napi, &rs, rx_desc);
+		xdp = NULL;
+
+		if (fail)
+			break;
+	}
+
+	idpf_xsk_finalize_rx(&bq);
+
+	rxq->next_to_clean = ntc;
+	rxq->xsk = xdp;
+
+	fail |= !idpf_xskfq_refill_set(&set);
+
+	u64_stats_update_begin(&rxq->stats_sync);
+	u64_stats_add(&rxq->q_stats.packets, rs.packets);
+	u64_stats_add(&rxq->q_stats.bytes, rs.bytes);
+	u64_stats_update_end(&rxq->stats_sync);
+
+	if (!wake)
+		return unlikely(fail) ? budget : rs.packets;
+
+	if (unlikely(fail))
+		xsk_set_rx_need_wakeup(rxq->pool);
+
+	return rs.packets;
+}
+
 int idpf_xsk_pool_setup(struct idpf_vport *vport, struct netdev_bpf *bpf)
 {
 	struct xsk_buff_pool *pool = bpf->xsk.pool;
@@ -245,6 +550,16 @@ int idpf_xsk_pool_setup(struct idpf_vport *vport, struct netdev_bpf *bpf)
 	bool restart;
 	int ret;
 
+	if (pool && !IS_ALIGNED(xsk_pool_get_rx_frame_size(pool),
+				LIBETH_RX_BUF_STRIDE)) {
+		NL_SET_ERR_MSG_FMT_MOD(bpf->extack,
+				       "%s: HW doesn't support frames sizes not aligned to %u (qid %u: %u)",
+				       netdev_name(vport->netdev),
+				       LIBETH_RX_BUF_STRIDE, qid,
+				       xsk_pool_get_rx_frame_size(pool));
+		return -EINVAL;
+	}
+
 	restart = idpf_xdp_enabled(vport) && netif_running(vport->netdev);
 	if (!restart)
 		goto pool;
diff --git a/drivers/net/ethernet/intel/idpf/xsk.h b/drivers/net/ethernet/intel/idpf/xsk.h
index d08fd51b0fc6..d5338cbef8bd 100644
--- a/drivers/net/ethernet/intel/idpf/xsk.h
+++ b/drivers/net/ethernet/intel/idpf/xsk.h
@@ -7,6 +7,8 @@
 #include <linux/types.h>
 
 enum virtchnl2_queue_type;
+struct idpf_buf_queue;
+struct idpf_rx_queue;
 struct idpf_tx_queue;
 struct idpf_vport;
 struct netdev_bpf;
@@ -15,7 +17,11 @@ void idpf_xsk_setup_queue(const struct idpf_vport *vport, void *q,
 			  enum virtchnl2_queue_type type);
 void idpf_xsk_clear_queue(void *q, enum virtchnl2_queue_type type);
 
+int idpf_xskfq_init(struct idpf_buf_queue *bufq);
+void idpf_xskfq_rel(struct idpf_buf_queue *bufq);
 void idpf_xsksq_clean(struct idpf_tx_queue *xdpq);
+
+int idpf_xskrq_poll(struct idpf_rx_queue *rxq, u32 budget);
 bool idpf_xsk_xmit(struct idpf_tx_queue *xsksq);
 
 int idpf_xsk_pool_setup(struct idpf_vport *vport, struct netdev_bpf *xdp);
-- 
2.47.1


