Return-Path: <bpf+bounces-51235-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BDBDA322CC
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2025 10:50:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 557957A4201
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2025 09:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF05120ADC7;
	Wed, 12 Feb 2025 09:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="ALpwiHpd"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961082080D0;
	Wed, 12 Feb 2025 09:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739353727; cv=none; b=nn+1aFQveMo8WbpMSMWoVRKuhgRg9JbhqnrUoRGPT9mXoMxbUpdxKRSDg69lFYs38NFRtaOn0vtqQNb8JMsoTpFoHTrNBitFxQfap4WKEjc8dhIPuhW2HSk9zUJMt6nmkmB0jymRjNvkuJhPdWrUBDGtq+w3xT1cPESAVkNIRqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739353727; c=relaxed/simple;
	bh=p4lLou9jR/5i5jryQ+c5wNxurkN/k/jBM8ck1oxCZBw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jITlbkwHxp1CpFHJlXRX9m6xvDg6NtmUjz2N794z1IugUJI42OL5lAeg6ASc949+O2jF02iV3u1SyFmr3gGtYLzsOltdBphO0NVoF6I38rmse+zR99Bp2uLjR7rD9px7M5cnrbE1aC+LSfarOje407sEHJ6GGno7psGSB9nBamU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=ALpwiHpd; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51C6Wr8T026989;
	Wed, 12 Feb 2025 01:48:26 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=B
	M1NwnrPgoeHtetmEdpZ7hXW8xXmFgczyGTaEVLIXAE=; b=ALpwiHpdpSTnTUDbb
	gg2d59DQPK1KGXw1M5xqjpqb9YY78dLU/zNSCyzs7LRPZQNSL6aoDTGWzKBoEa71
	sYi8+8VJLttvsjXQH2mw35odbXynm6Uw41ljO8NYi9nudrEPKvZ0/1xHBD2sXllU
	e8Yv8l9oik1DVJfD4QXfL2EZ2l8kAei9dTrV6I44jROMbFoLN50Wqgx00xIrYWf3
	BwopogGHzKamVPMKwsVmZ56sU4ZIr1LiuCP0RrF/nclfIkRe9/eh3A3I9W+kzo4t
	G06RUbT1YmOalqp0vbHLrTIVaBP3hoZmWTAqtQwLSHqIAxyBTYtuh7cz+ic0YjxS
	UiJcw==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 44rpfcramx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Feb 2025 01:48:26 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 12 Feb 2025 01:48:25 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 12 Feb 2025 01:48:25 -0800
Received: from localhost.localdomain (unknown [10.28.36.166])
	by maili.marvell.com (Postfix) with ESMTP id 54E963F708A;
	Wed, 12 Feb 2025 01:48:19 -0800 (PST)
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
Subject: [net-next PATCH v6 5/6] octeontx2-pf: Prepare for AF_XDP
Date: Wed, 12 Feb 2025 15:17:37 +0530
Message-ID: <20250212094738.2671725-6-sumang@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250212094738.2671725-1-sumang@marvell.com>
References: <20250212094738.2671725-1-sumang@marvell.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: lF42CQDtNwn4B0sOYuZA5wuhUpIz-moB
X-Proofpoint-GUID: lF42CQDtNwn4B0sOYuZA5wuhUpIz-moB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-12_03,2025-02-11_01,2024-11-22_01

Implement necessary APIs required for AF_XDP transmit.

Signed-off-by: Hariprasad Kelam <hkelam@marvell.com>
Signed-off-by: Suman Ghosh <sumang@marvell.com>
---
 .../marvell/octeontx2/nic/otx2_common.h       |  1 +
 .../marvell/octeontx2/nic/otx2_txrx.c         | 25 +++++++++++++++++--
 2 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
index 60508971b62f..19e9e2e72233 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
@@ -1181,4 +1181,5 @@ static inline int mcam_entry_cmp(const void *a, const void *b)
 dma_addr_t otx2_dma_map_skb_frag(struct otx2_nic *pfvf,
 				 struct sk_buff *skb, int seg, int *len);
 void otx2_dma_unmap_skb_frags(struct otx2_nic *pfvf, struct sg_list *sg);
+int otx2_read_free_sqe(struct otx2_nic *pfvf, u16 qidx);
 #endif /* OTX2_COMMON_H */
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
index 00b6903ba250..9a6c1f1a3ee0 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
@@ -30,6 +30,12 @@
 
 DEFINE_STATIC_KEY_FALSE(cn10k_ipsec_sa_enabled);
 
+static int otx2_get_free_sqe(struct otx2_snd_queue *sq)
+{
+	return (sq->cons_head - sq->head - 1 + sq->sqe_cnt)
+		& (sq->sqe_cnt - 1);
+}
+
 static bool otx2_xdp_rcv_pkt_handler(struct otx2_nic *pfvf,
 				     struct bpf_prog *prog,
 				     struct nix_cqe_rx_s *cqe,
@@ -1157,7 +1163,7 @@ bool otx2_sq_append_skb(void *dev, struct netdev_queue *txq,
 	/* Check if there is enough room between producer
 	 * and consumer index.
 	 */
-	free_desc = (sq->cons_head - sq->head - 1 + sq->sqe_cnt) & (sq->sqe_cnt - 1);
+	free_desc = otx2_get_free_sqe(sq);
 	if (free_desc < sq->sqe_thresh)
 		return false;
 
@@ -1396,6 +1402,21 @@ static void otx2_xdp_sqe_add_sg(struct otx2_snd_queue *sq,
 	sq->sg[sq->head].skb = (u64)xdpf;
 }
 
+int otx2_read_free_sqe(struct otx2_nic *pfvf, u16 qidx)
+{
+	struct otx2_snd_queue *sq;
+	int free_sqe;
+
+	sq = &pfvf->qset.sq[qidx];
+	free_sqe = otx2_get_free_sqe(sq);
+	if (free_sqe < sq->sqe_thresh) {
+		netdev_warn(pfvf->netdev, "No free sqe for Send queue%d\n", qidx);
+		return 0;
+	}
+
+	return free_sqe - sq->sqe_thresh;
+}
+
 bool otx2_xdp_sq_append_pkt(struct otx2_nic *pfvf, struct xdp_frame *xdpf,
 			    u64 iova, int len, u16 qidx, u16 flags)
 {
@@ -1404,7 +1425,7 @@ bool otx2_xdp_sq_append_pkt(struct otx2_nic *pfvf, struct xdp_frame *xdpf,
 	int offset, free_sqe;
 
 	sq = &pfvf->qset.sq[qidx];
-	free_sqe = (sq->num_sqbs - *sq->aura_fc_addr) * sq->sqe_per_sqb;
+	free_sqe = otx2_get_free_sqe(sq);
 	if (free_sqe < sq->sqe_thresh)
 		return false;
 
-- 
2.25.1


