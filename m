Return-Path: <bpf+bounces-50630-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A59A3A2A39F
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 09:53:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14D4918898C2
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 08:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEE8B225A38;
	Thu,  6 Feb 2025 08:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="Q1PXSJRR"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F4D225A30;
	Thu,  6 Feb 2025 08:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738831901; cv=none; b=OsMGUhcUptlr5HVPXcfEX+bWook7vHQEA88N1sillfGd2vR3JPm2IOWoQXb+EPMwm7wu9cjloLvZYfTaCS/GuyssAJxQU3QIseI9+Ahva0LjNITOJRdq5gCsKZf0pIZ+KYKDgMPifKmBbPAZkDQ/QWFb1PzQUloq8r4CFSff/II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738831901; c=relaxed/simple;
	bh=o4Ohhn57E2EGxKhpzP56dqYCexrAo2Ifk0JEjlDL++k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DBybzPopgxMC6O16a9/WRfOdwBgsRm9BxhzyVG8/vxKtUG8WR9QEGaPIMV56ePUGoIjrYUxX4qIXdR9qOQjXQTH0WJRl9We9aJxFVYPW/AtuSsud5UrpKURa4fdV6NSBw4c7DeNUBGoQAW/5U4OTK1aG5BzJ9RIq3pj7h4y9PCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=Q1PXSJRR; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5165cW15028788;
	Thu, 6 Feb 2025 00:51:21 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=O
	OHfYPVguYROE667g4CJKkR1hR54z2jg3i6qtoAA/l0=; b=Q1PXSJRRNImrAWZy1
	g0q99IaJp59bg2qDweVvRO7gT4GjSydMv4+SLlhYAhp6ppAtRTRb3VXrm1jJxsRt
	y0sRPz9zxW/1CVHqUTc9d0IU5avDJyFSXZ/jLPvgoUz9C3Fssnq0geA4MtA2aJNi
	IzEIb/X5OHBKG0AGA7eAyGnUdtXSFAR0mu616PDzKc4UOvjd9vcZaE0oK/u7HLQh
	IUjG9oo1EyysacFrhI8NNChet7mt+yM5jlxoPOvTz20KrwxA5wPKj1w2+KQfZ9qX
	yGjHl2AMfw/3vkoVpNBAykiSpv5MbAjkZfDF4EB39UEzA4EDQvWus0iBBf3DN+Fj
	IEgPQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 44mq418a70-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Feb 2025 00:51:21 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 6 Feb 2025 00:51:19 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 6 Feb 2025 00:51:19 -0800
Received: from localhost.localdomain (unknown [10.28.36.166])
	by maili.marvell.com (Postfix) with ESMTP id C73CD3F705F;
	Thu,  6 Feb 2025 00:51:13 -0800 (PST)
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
Subject: [net-next PATCH v5 5/6] octeontx2-pf: Prepare for AF_XDP
Date: Thu, 6 Feb 2025 14:20:33 +0530
Message-ID: <20250206085034.1978172-6-sumang@marvell.com>
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
X-Proofpoint-GUID: FvXkCdoO0IrXENjl0DbHd3cmcyWYBxzP
X-Proofpoint-ORIG-GUID: FvXkCdoO0IrXENjl0DbHd3cmcyWYBxzP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-06_02,2025-02-05_03,2024-11-22_01

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
index 44137160bdf6..b012d8794f18 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
@@ -22,6 +22,12 @@
 #include "cn10k.h"
 
 #define CQE_ADDR(CQ, idx) ((CQ)->cqe_base + ((CQ)->cqe_size * (idx)))
+#define READ_FREE_SQE(SQ, free_sqe)						   \
+	do {							                   \
+		typeof(SQ) _SQ = (SQ);						   \
+		free_sqe = (((_SQ)->cons_head - (_SQ)->head - 1 + (_SQ)->sqe_cnt)  \
+			   & ((_SQ)->sqe_cnt - 1));                                \
+	} while (0)
 #define PTP_PORT	        0x13F
 /* PTPv2 header Original Timestamp starts at byte offset 34 and
  * contains 6 byte seconds field and 4 byte nano seconds field.
@@ -1163,7 +1169,7 @@ bool otx2_sq_append_skb(void *dev, struct netdev_queue *txq,
 	/* Check if there is enough room between producer
 	 * and consumer index.
 	 */
-	free_desc = (sq->cons_head - sq->head - 1 + sq->sqe_cnt) & (sq->sqe_cnt - 1);
+	READ_FREE_SQE(sq, free_desc);
 	if (free_desc < sq->sqe_thresh)
 		return false;
 
@@ -1402,6 +1408,21 @@ static void otx2_xdp_sqe_add_sg(struct otx2_snd_queue *sq,
 	sq->sg[sq->head].skb = (u64)xdpf;
 }
 
+int otx2_read_free_sqe(struct otx2_nic *pfvf, u16 qidx)
+{
+	struct otx2_snd_queue *sq;
+	int free_sqe;
+
+	sq = &pfvf->qset.sq[qidx];
+	READ_FREE_SQE(sq, free_sqe);
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
@@ -1410,7 +1431,7 @@ bool otx2_xdp_sq_append_pkt(struct otx2_nic *pfvf, struct xdp_frame *xdpf,
 	int offset, free_sqe;
 
 	sq = &pfvf->qset.sq[qidx];
-	free_sqe = (sq->num_sqbs - *sq->aura_fc_addr) * sq->sqe_per_sqb;
+	READ_FREE_SQE(sq, free_sqe);
 	if (free_sqe < sq->sqe_thresh)
 		return false;
 
-- 
2.25.1


