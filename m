Return-Path: <bpf+bounces-13702-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B6D17DCBB3
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 12:24:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 401332817C2
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 11:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BE161A72B;
	Tue, 31 Oct 2023 11:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="as3m0Wv8"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1817E1A70F;
	Tue, 31 Oct 2023 11:24:17 +0000 (UTC)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63D7697;
	Tue, 31 Oct 2023 04:24:16 -0700 (PDT)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39V7TvKx004769;
	Tue, 31 Oct 2023 04:23:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=pfpt0220;
 bh=jxcYiC94VBU9IMPI8prqBSJJjwC0PAd9u+mtlkrs+Fs=;
 b=as3m0Wv8gTcoTk/1kNywYxQcXaflIzxeYOGl1cY+uY6ApsXCTNYCWKD/WSFNVSE8/Wsh
 xHDG4xafLZt9z/ifvqamOaQnc6icyNS1wNi9qUs895wZ3NlsaigJLzXDD+ZmqEo3FsEd
 Dwi/pyq1qmuM+7YisCuCH7H5QzUf8gE7tesFl4PpWAIPOLcuLsUkhRFb8E3VMHPtHCdM
 q5GCRPs1Pf73lnX5zkJfKz4/R0R0faDkEFkI7oRB/bHzSyKcEepC6Y9F0lEHPVBy9m3u
 GZL8La8zZSDL6/gG/mhj2e8xb3T0k6+GmR44tk5ONfQFXqWWSHkmlRHv3zOjvGrLS0HL CQ== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3u11tpa8bj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
	Tue, 31 Oct 2023 04:23:53 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Tue, 31 Oct
 2023 04:23:51 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Tue, 31 Oct 2023 04:23:51 -0700
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
	by maili.marvell.com (Postfix) with ESMTP id DCF723F70C2;
	Tue, 31 Oct 2023 04:23:46 -0700 (PDT)
From: Geetha sowjanya <gakula@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <bpf@vger.kernel.org>
CC: <kuba@kernel.org>, <davem@davemloft.net>, <pabeni@redhat.com>,
        <edumazet@google.com>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <hawk@kernel.org>, <sgoutham@marvell.com>, <gakula@marvell.com>,
        <sbhatta@marvell.com>, <hkelam@marvell.com>
Subject: [net PATCH] octeontx2-pf: Free pending and dropped SQEs
Date: Tue, 31 Oct 2023 16:53:45 +0530
Message-ID: <20231031112345.25291-1-gakula@marvell.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: U1Q4Db0ML9vmH-0MZvETkm2VQxOMh4dZ
X-Proofpoint-ORIG-GUID: U1Q4Db0ML9vmH-0MZvETkm2VQxOMh4dZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-31_01,2023-10-31_03,2023-05-22_02

On interface down, the pending SQEs in the NIX get dropped
or drained out during SMQ flush. But skb's pointed by these
SQEs never get free or updated to the stack as respective CQE
never get added.
This patch fixes the issue by freeing all valid skb's in SQ SG list.

Fixes: b1bc8457e9d0 ("octeontx2-pf: Cleanup all receive buffers in SG descriptor")
Signed-off-by: Geetha sowjanya <gakula@marvell.com>
---
 .../marvell/octeontx2/nic/otx2_common.c       | 15 +++----
 .../marvell/octeontx2/nic/otx2_common.h       |  1 +
 .../ethernet/marvell/octeontx2/nic/otx2_pf.c  |  1 +
 .../marvell/octeontx2/nic/otx2_txrx.c         | 42 +++++++++++++++++++
 4 files changed, 49 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
index 1a42bfded872..7ca6941ea0b9 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
@@ -818,7 +818,6 @@ void otx2_sqb_flush(struct otx2_nic *pfvf)
 	int qidx, sqe_tail, sqe_head;
 	struct otx2_snd_queue *sq;
 	u64 incr, *ptr, val;
-	int timeout = 1000;
 
 	ptr = (u64 *)otx2_get_regaddr(pfvf, NIX_LF_SQ_OP_STATUS);
 	for (qidx = 0; qidx < otx2_get_total_tx_queues(pfvf); qidx++) {
@@ -827,15 +826,11 @@ void otx2_sqb_flush(struct otx2_nic *pfvf)
 			continue;
 
 		incr = (u64)qidx << 32;
-		while (timeout) {
-			val = otx2_atomic64_add(incr, ptr);
-			sqe_head = (val >> 20) & 0x3F;
-			sqe_tail = (val >> 28) & 0x3F;
-			if (sqe_head == sqe_tail)
-				break;
-			usleep_range(1, 3);
-			timeout--;
-		}
+		val = otx2_atomic64_add(incr, ptr);
+		sqe_head = (val >> 20) & 0x3F;
+		sqe_tail = (val >> 28) & 0x3F;
+		if (sqe_head != sqe_tail)
+			usleep_range(50, 60);
 	}
 }
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
index c04a8ee53a82..e7c69b57147e 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
@@ -977,6 +977,7 @@ int otx2_txschq_config(struct otx2_nic *pfvf, int lvl, int prio, bool pfc_en);
 int otx2_txsch_alloc(struct otx2_nic *pfvf);
 void otx2_txschq_stop(struct otx2_nic *pfvf);
 void otx2_txschq_free_one(struct otx2_nic *pfvf, u16 lvl, u16 schq);
+void otx2_free_pending_sqe(struct otx2_nic *pfvf);
 void otx2_sqb_flush(struct otx2_nic *pfvf);
 int otx2_alloc_rbuf(struct otx2_nic *pfvf, struct otx2_pool *pool,
 		    dma_addr_t *dma);
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
index 6daf4d58c25d..8e82db6092af 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
@@ -1589,6 +1589,7 @@ static void otx2_free_hw_resources(struct otx2_nic *pf)
 		else
 			otx2_cleanup_tx_cqes(pf, cq);
 	}
+	otx2_free_pending_sqe(pf);
 
 	otx2_free_sq_res(pf);
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
index 53b2a4ef5298..6ee15f3c25ed 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
@@ -1247,9 +1247,11 @@ void otx2_cleanup_rx_cqes(struct otx2_nic *pfvf, struct otx2_cq_queue *cq, int q
 
 void otx2_cleanup_tx_cqes(struct otx2_nic *pfvf, struct otx2_cq_queue *cq)
 {
+	int tx_pkts = 0, tx_bytes = 0;
 	struct sk_buff *skb = NULL;
 	struct otx2_snd_queue *sq;
 	struct nix_cqe_tx_s *cqe;
+	struct netdev_queue *txq;
 	int processed_cqe = 0;
 	struct sg_list *sg;
 	int qidx;
@@ -1270,12 +1272,20 @@ void otx2_cleanup_tx_cqes(struct otx2_nic *pfvf, struct otx2_cq_queue *cq)
 		sg = &sq->sg[cqe->comp.sqe_id];
 		skb = (struct sk_buff *)sg->skb;
 		if (skb) {
+			tx_bytes += skb->len;
+			tx_pkts++;
 			otx2_dma_unmap_skb_frags(pfvf, sg);
 			dev_kfree_skb_any(skb);
 			sg->skb = (u64)NULL;
 		}
 	}
 
+	if (likely(tx_pkts)) {
+		if (qidx >= pfvf->hw.tx_queues)
+			qidx -= pfvf->hw.xdp_queues;
+		txq = netdev_get_tx_queue(pfvf->netdev, qidx);
+		netdev_tx_completed_queue(txq, tx_pkts, tx_bytes);
+	}
 	/* Free CQEs to HW */
 	otx2_write64(pfvf, NIX_LF_CQ_OP_DOOR,
 		     ((u64)cq->cq_idx << 32) | processed_cqe);
@@ -1302,6 +1312,38 @@ int otx2_rxtx_enable(struct otx2_nic *pfvf, bool enable)
 	return err;
 }
 
+void otx2_free_pending_sqe(struct otx2_nic *pfvf)
+{
+	int tx_pkts = 0, tx_bytes = 0;
+	struct sk_buff *skb = NULL;
+	struct otx2_snd_queue *sq;
+	struct netdev_queue *txq;
+	struct sg_list *sg;
+	int sq_idx, sqe;
+
+	for (sq_idx = 0; sq_idx < pfvf->hw.tx_queues; sq_idx++) {
+		sq = &pfvf->qset.sq[sq_idx];
+		for (sqe = 0; sqe < sq->sqe_cnt; sqe++) {
+			sg = &sq->sg[sqe];
+			skb = (struct sk_buff *)sg->skb;
+			if (skb) {
+				tx_bytes += skb->len;
+				tx_pkts++;
+				otx2_dma_unmap_skb_frags(pfvf, sg);
+				dev_kfree_skb_any(skb);
+				sg->skb = (u64)NULL;
+			}
+		}
+
+		if (!tx_pkts)
+			continue;
+		txq = netdev_get_tx_queue(pfvf->netdev, sq_idx);
+		netdev_tx_completed_queue(txq, tx_pkts, tx_bytes);
+		tx_pkts = 0;
+		tx_bytes = 0;
+	}
+}
+
 static void otx2_xdp_sqe_add_sg(struct otx2_snd_queue *sq, u64 dma_addr,
 				int len, int *offset)
 {
-- 
2.25.1


