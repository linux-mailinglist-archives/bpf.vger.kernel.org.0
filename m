Return-Path: <bpf+bounces-50631-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CC0BA2A3A9
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 09:55:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 808B13A8A2C
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 08:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 366A1225A4C;
	Thu,  6 Feb 2025 08:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="XbMiA1oo"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E320C224AF0;
	Thu,  6 Feb 2025 08:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738831910; cv=none; b=fl5GdTrXnAeeYW8cq9zUK5iru88+NaS5aXP7MWDF0ZOR2MJqIEIoitaJinSCcES2VHLRtAUE8plkR8va4Ir3jMr/7Cd3PCIcdl6uJxyp5f4ncXs2o0S27wBrrjXYn6yzk8aEqTIfuSJfa/KEzB1/nFMZxAX8xJahuAK7tf5hUJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738831910; c=relaxed/simple;
	bh=6nm9rTP7Hh1x0WcVFijsN0rFNupyhWJnEDcHSgYy77E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cd3ywxis/iuhupTsv1cPRckrZPkRIYr6DgUgCY0CxnOVxIIhsrCT7pgMff7RfJzniuRov9Uai6g3B2y+AdfmxomZBhb9iEIufl2grFxPK8US/pW1YQMTVmKuWqGpd4SCY9oYB4HDJNJhn/LBPnxLuepcfTJhQsQ+Hc6mshr+DsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=XbMiA1oo; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5168PNYV016449;
	Thu, 6 Feb 2025 00:51:29 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=k
	lGcRcy5ExH+CBOSYb9emcz2rkAjiyQjvrPJfna9QPI=; b=XbMiA1ooEGMpBGtyR
	Kp2nL+d47jZZ3SoVJovc/e/6rGetww49mXJkZNO5d8FINcpUKy/D/6BvnY1e6Xio
	LLnvwsxMwtRsLg7pM9N0Bdi1DbDwziYj6Nf4eS/is33sE9znD09kn3/0TKiBZifv
	8skj9n0cJTbE+vToSXZ72X0panpU+tmPi3Yk6LScybH0XWeb2TeE0nnxl6ACdHTQ
	MLfFekNs4mCxJLJBOaNGyvzpcOyzdgWiSLuK4KAUEAn2SFW1Vw5pVFI01pKjKBMM
	tJghsCo0prOswMqPd3kl8vIJFvNJgwRoTaTulH4Id9Z4PCq3rcnEDmeGptlHiB6l
	dwF/w==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 44msja01h0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Feb 2025 00:51:28 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 6 Feb 2025 00:51:27 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 6 Feb 2025 00:51:27 -0800
Received: from localhost.localdomain (unknown [10.28.36.166])
	by maili.marvell.com (Postfix) with ESMTP id 3096E3F7086;
	Thu,  6 Feb 2025 00:51:20 -0800 (PST)
From: Suman Ghosh <sumang@marvell.com>
To: <horms@kernel.org>, <sgoutham@marvell.com>, <gakula@marvell.com>,
        <sbhatta@marvell.com>, <hkelam@marvell.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <lcherian@marvell.com>, <jerinj@marvell.com>,
        <john.fastabend@gmail.com>, <bbhushan2@marvell.com>, <hawk@kernel.org>,
        <andrew+netdev@lunn.ch>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <bpf@vger.kernel.org>, <larysa.zaremba@intel.com>
CC: Suman Ghosh <sumang@marvell.com>
Subject: [net-next PATCH v5 6/6] octeontx2-pf: AF_XDP zero copy transmit support
Date: Thu, 6 Feb 2025 14:20:34 +0530
Message-ID: <20250206085034.1978172-7-sumang@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250206085034.1978172-1-sumang@marvell.com>
References: <20250206085034.1978172-1-sumang@marvell.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: lk6nwz4UpZJA0asWo-3mKcsn1nrlbN_3
X-Proofpoint-GUID: lk6nwz4UpZJA0asWo-3mKcsn1nrlbN_3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-06_02,2025-02-05_03,2024-11-22_01

This patch implements below changes,

1. To avoid concurrency with normal traffic uses
   XDP queues.

2. Since there are chances that XDP and AF_XDP can
   fall under same queue uses separate flags to handle
   dma buffers.

Signed-off-by: Hariprasad Kelam <hkelam@marvell.com>
Signed-off-by: Suman Ghosh <sumang@marvell.com>
---
 .../marvell/octeontx2/nic/otx2_common.c       |  4 ++
 .../marvell/octeontx2/nic/otx2_common.h       |  6 +++
 .../ethernet/marvell/octeontx2/nic/otx2_pf.c  |  2 +-
 .../marvell/octeontx2/nic/otx2_txrx.c         | 54 ++++++++++++++-----
 .../marvell/octeontx2/nic/otx2_txrx.h         |  2 +
 .../ethernet/marvell/octeontx2/nic/otx2_xsk.c | 43 ++++++++++++++-
 .../ethernet/marvell/octeontx2/nic/otx2_xsk.h |  3 ++
 7 files changed, 97 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
index ec8fc2813443..75c45c06cfb1 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
@@ -1037,6 +1037,10 @@ int otx2_sq_init(struct otx2_nic *pfvf, u16 qidx, u16 sqb_aura)
 
 	sq->stats.bytes = 0;
 	sq->stats.pkts = 0;
+	/* Attach XSK_BUFF_POOL to XDP queue */
+	if (qidx > pfvf->hw.xdp_queues)
+		otx2_attach_xsk_buff(pfvf, sq, (qidx - pfvf->hw.xdp_queues));
+
 
 	chan_offset = qidx % pfvf->hw.tx_chan_cnt;
 	err = pfvf->hw_ops->sq_aq_init(pfvf, qidx, chan_offset, sqb_aura);
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
index 19e9e2e72233..1e88422825be 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
@@ -129,6 +129,12 @@ enum otx2_errcodes_re {
 	ERRCODE_IL4_CSUM = 0x22,
 };
 
+enum otx2_xdp_action {
+	OTX2_XDP_TX	  = BIT(0),
+	OTX2_XDP_REDIRECT = BIT(1),
+	OTX2_AF_XDP_FRAME = BIT(2),
+};
+
 struct otx2_dev_stats {
 	u64 rx_bytes;
 	u64 rx_frames;
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
index 188ab6b6fb16..47b05a9c3db5 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
@@ -2693,7 +2693,7 @@ static int otx2_xdp_xmit_tx(struct otx2_nic *pf, struct xdp_frame *xdpf,
 		return -ENOMEM;
 
 	err = otx2_xdp_sq_append_pkt(pf, xdpf, dma_addr, xdpf->len,
-				     qidx, XDP_REDIRECT);
+				     qidx, OTX2_XDP_REDIRECT);
 	if (!err) {
 		otx2_dma_unmap_page(pf, dma_addr, xdpf->len, DMA_TO_DEVICE);
 		xdp_return_frame(xdpf);
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
index b012d8794f18..ded0d76a8f37 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
@@ -20,6 +20,7 @@
 #include "otx2_txrx.h"
 #include "otx2_ptp.h"
 #include "cn10k.h"
+#include "otx2_xsk.h"
 
 #define CQE_ADDR(CQ, idx) ((CQ)->cqe_base + ((CQ)->cqe_size * (idx)))
 #define READ_FREE_SQE(SQ, free_sqe)						   \
@@ -103,19 +104,22 @@ static unsigned int frag_num(unsigned int i)
 
 static void otx2_xdp_snd_pkt_handler(struct otx2_nic *pfvf,
 				     struct otx2_snd_queue *sq,
-				     struct nix_cqe_tx_s *cqe)
+				     struct nix_cqe_tx_s *cqe,
+				     int *xsk_frames)
 {
 	struct nix_send_comp_s *snd_comp = &cqe->comp;
 	struct sg_list *sg;
-	struct page *page;
-	u64 pa, iova;
+	u64 iova;
 
 	sg = &sq->sg[snd_comp->sqe_id];
 
+	if (sg->flags & OTX2_AF_XDP_FRAME) {
+		(*xsk_frames)++;
+		return;
+	}
+
 	iova = sg->dma_addr[0];
-	pa = otx2_iova_to_phys(pfvf->iommu_domain, iova);
-	page = virt_to_page(phys_to_virt(pa));
-	if (sg->flags & XDP_REDIRECT)
+	if (sg->flags & OTX2_XDP_REDIRECT)
 		otx2_dma_unmap_page(pfvf, sg->dma_addr[0], sg->size[0], DMA_TO_DEVICE);
 	xdp_return_frame((struct xdp_frame *)sg->skb);
 	sg->skb = (u64)NULL;
@@ -440,6 +444,18 @@ int otx2_refill_pool_ptrs(void *dev, struct otx2_cq_queue *cq)
 	return cnt - cq->pool_ptrs;
 }
 
+static void otx2_zc_submit_pkts(struct otx2_nic *pfvf, struct xsk_buff_pool *xsk_pool,
+				int *xsk_frames, int qidx, int budget)
+{
+	if (*xsk_frames)
+		xsk_tx_completed(xsk_pool, *xsk_frames);
+
+	if (xsk_uses_need_wakeup(xsk_pool))
+		xsk_set_tx_need_wakeup(xsk_pool);
+
+	otx2_zc_napi_handler(pfvf, xsk_pool, qidx, budget);
+}
+
 static int otx2_tx_napi_handler(struct otx2_nic *pfvf,
 				struct otx2_cq_queue *cq, int budget)
 {
@@ -448,16 +464,22 @@ static int otx2_tx_napi_handler(struct otx2_nic *pfvf,
 	struct nix_cqe_tx_s *cqe;
 	struct net_device *ndev;
 	int processed_cqe = 0;
+	int xsk_frames = 0;
+
+	qidx = cq->cq_idx - pfvf->hw.rx_queues;
+	sq = &pfvf->qset.sq[qidx];
 
 	if (cq->pend_cqe >= budget)
 		goto process_cqe;
 
-	if (otx2_nix_cq_op_status(pfvf, cq) || !cq->pend_cqe)
+	if (otx2_nix_cq_op_status(pfvf, cq) || !cq->pend_cqe) {
+		if (sq->xsk_pool)
+			otx2_zc_submit_pkts(pfvf, sq->xsk_pool, &xsk_frames,
+					    qidx, budget);
 		return 0;
+	}
 
 process_cqe:
-	qidx = cq->cq_idx - pfvf->hw.rx_queues;
-	sq = &pfvf->qset.sq[qidx];
 
 	while (likely(processed_cqe < budget) && cq->pend_cqe) {
 		cqe = (struct nix_cqe_tx_s *)otx2_get_next_cqe(cq);
@@ -467,10 +489,8 @@ static int otx2_tx_napi_handler(struct otx2_nic *pfvf,
 			break;
 		}
 
-		qidx = cq->cq_idx - pfvf->hw.rx_queues;
-
 		if (cq->cq_type == CQ_XDP)
-			otx2_xdp_snd_pkt_handler(pfvf, sq, cqe);
+			otx2_xdp_snd_pkt_handler(pfvf, sq, cqe, &xsk_frames);
 		else
 			otx2_snd_pkt_handler(pfvf, cq, &pfvf->qset.sq[qidx],
 					     cqe, budget, &tx_pkts, &tx_bytes);
@@ -511,6 +531,10 @@ static int otx2_tx_napi_handler(struct otx2_nic *pfvf,
 		    netif_carrier_ok(ndev))
 			netif_tx_wake_queue(txq);
 	}
+
+	if (sq->xsk_pool)
+		otx2_zc_submit_pkts(pfvf, sq->xsk_pool, &xsk_frames, qidx, budget);
+
 	return 0;
 }
 
@@ -1505,8 +1529,10 @@ static bool otx2_xdp_rcv_pkt_handler(struct otx2_nic *pfvf,
 		qidx += pfvf->hw.tx_queues;
 		cq->pool_ptrs++;
 		xdpf = xdp_convert_buff_to_frame(&xdp);
-		return otx2_xdp_sq_append_pkt(pfvf, xdpf, cqe->sg.seg_addr,
-					      cqe->sg.seg_size, qidx, XDP_TX);
+		return otx2_xdp_sq_append_pkt(pfvf, xdpf,
+					      cqe->sg.seg_addr,
+					      cqe->sg.seg_size,
+					      qidx, OTX2_XDP_TX);
 	case XDP_REDIRECT:
 		cq->pool_ptrs++;
 		if (xsk_buff) {
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.h b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.h
index 8f346fbc8221..acf259d72008 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.h
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.h
@@ -106,6 +106,8 @@ struct otx2_snd_queue {
 	/* SQE ring and CPT response queue for Inline IPSEC */
 	struct qmem		*sqe_ring;
 	struct qmem		*cpt_resp;
+	/* Buffer pool for af_xdp zero-copy */
+	struct xsk_buff_pool    *xsk_pool;
 } ____cacheline_aligned_in_smp;
 
 enum cq_type {
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_xsk.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_xsk.c
index 13dcbbe6112d..40a539a122d9 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_xsk.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_xsk.c
@@ -140,11 +140,14 @@ int otx2_xsk_pool_disable(struct otx2_nic *pf, u16 qidx)
 {
 	struct net_device *netdev = pf->netdev;
 	struct xsk_buff_pool *pool;
+	struct otx2_snd_queue *sq;
 
 	pool = xsk_get_pool_from_qid(netdev, qidx);
 	if (!pool)
 		return -EINVAL;
 
+	sq = &pf->qset.sq[qidx + pf->hw.tx_queues];
+	sq->xsk_pool = NULL;
 	otx2_clean_up_rq(pf, qidx);
 	clear_bit(qidx, pf->af_xdp_zc_qidx);
 	xsk_pool_dma_unmap(pool, DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_WEAK_ORDERING);
@@ -171,7 +174,7 @@ int otx2_xsk_wakeup(struct net_device *dev, u32 queue_id, u32 flags)
 	if (pf->flags & OTX2_FLAG_INTF_DOWN)
 		return -ENETDOWN;
 
-	if (queue_id >= pf->hw.rx_queues)
+	if (queue_id >= pf->hw.rx_queues || queue_id >= pf->hw.tx_queues)
 		return -EINVAL;
 
 	cq_poll = &qset->napi[queue_id];
@@ -179,8 +182,44 @@ int otx2_xsk_wakeup(struct net_device *dev, u32 queue_id, u32 flags)
 		return -EINVAL;
 
 	/* Trigger interrupt */
-	if (!napi_if_scheduled_mark_missed(&cq_poll->napi))
+	if (!napi_if_scheduled_mark_missed(&cq_poll->napi)) {
 		otx2_write64(pf, NIX_LF_CINTX_ENA_W1S(cq_poll->cint_idx), BIT_ULL(0));
+		otx2_write64(pf, NIX_LF_CINTX_INT_W1S(cq_poll->cint_idx), BIT_ULL(0));
+	}
 
 	return 0;
 }
+
+void otx2_attach_xsk_buff(struct otx2_nic *pfvf, struct otx2_snd_queue *sq, int qidx)
+{
+	if (test_bit(qidx, pfvf->af_xdp_zc_qidx))
+		sq->xsk_pool = xsk_get_pool_from_qid(pfvf->netdev, qidx);
+}
+
+void otx2_zc_napi_handler(struct otx2_nic *pfvf, struct xsk_buff_pool *pool,
+			  int queue, int budget)
+{
+	struct xdp_desc *xdp_desc = pool->tx_descs;
+	int err, i, work_done = 0, batch;
+
+	budget = min(budget, otx2_read_free_sqe(pfvf, queue));
+	batch = xsk_tx_peek_release_desc_batch(pool, budget);
+	if (!batch)
+		return;
+
+	for (i = 0; i < batch; i++) {
+		dma_addr_t dma_addr;
+
+		dma_addr = xsk_buff_raw_get_dma(pool, xdp_desc[i].addr);
+		err = otx2_xdp_sq_append_pkt(pfvf, NULL, dma_addr, xdp_desc[i].len,
+					     queue, OTX2_AF_XDP_FRAME);
+		if (!err) {
+			netdev_err(pfvf->netdev, "AF_XDP: Unable to transfer packet err%d\n", err);
+			break;
+		}
+		work_done++;
+	}
+
+	if (work_done)
+		xsk_tx_release(pool);
+}
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_xsk.h b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_xsk.h
index 022b3433edbb..8047fafee8fe 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_xsk.h
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_xsk.h
@@ -17,5 +17,8 @@ int otx2_xsk_pool_disable(struct otx2_nic *pf, u16 qid);
 int otx2_xsk_pool_alloc_buf(struct otx2_nic *pfvf, struct otx2_pool *pool,
 			    dma_addr_t *dma, int idx);
 int otx2_xsk_wakeup(struct net_device *dev, u32 queue_id, u32 flags);
+void otx2_zc_napi_handler(struct otx2_nic *pfvf, struct xsk_buff_pool *pool,
+			  int queue, int budget);
+void otx2_attach_xsk_buff(struct otx2_nic *pfvf, struct otx2_snd_queue *sq, int qidx);
 
 #endif /* OTX2_XSK_H */
-- 
2.25.1


