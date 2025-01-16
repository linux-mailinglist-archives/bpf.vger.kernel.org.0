Return-Path: <bpf+bounces-49081-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FC2DA14210
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2025 20:13:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6DDE17A1977
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2025 19:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3108924169F;
	Thu, 16 Jan 2025 19:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="Bzq6QewU"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2BD2309B2;
	Thu, 16 Jan 2025 19:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737054741; cv=none; b=RX4akiqAfyDst6mRbw0SK2IHfqIRGnjnzDzOA1moRZAQOmXG+dk1T5gUHKZSwKjRBHc1hRyOl0c3i+GUkZureG16eikGSZGCkpW/k1GA5yZCQ02P7TIqibgxXOIdfvGD6rxKU2evScFepsN2MYd2g6fk9SVMy7/Y42sWW5dB3Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737054741; c=relaxed/simple;
	bh=Q28iANzwhVa5POuxJBKvhny3TdVCVH75CDZq9Scx3sQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UfwotIaefRttfA5/PVaMrdxspubTk3KKN68rXZEHKYW/hJZwiWpmKuKYGCU2OR6KKwgFQ9sYsBKQ96CI3nhuW8qFT9eAGGAcgEcwreV5kIaMRHtb8L2MzbhCZ/OqqJkz99XdLPHiSlqRhM85+igpDabDJDYbmLPhDJZ1CLFAsGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=Bzq6QewU; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50GFdWeu030533;
	Thu, 16 Jan 2025 11:12:01 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=q
	29NgmVCqPGhTOexqLQMUQvqY0oSO7xi7wLcXJp4jmA=; b=Bzq6QewUVG2bhqn+E
	HMb0pNrx8hoqf3GmqSu6N6OuwncCCEIJed8/6fyP110fWIdKiFUUzHJ8wxncC6OH
	Z7eiHMyOEvhelkKfxsxbW2EN9dM/W1GMAJlF8DMiCudGJN4aB933E2R0r36KbZ1J
	wijp4isEKAZLQqOXXu+p3CfoD7IDN1mntI47v2iaSVEnSkjeqd0uPBKSLIY6YdFz
	dOdx2CodIBDawKcvIocxvlZat9Z3AvMq5pjy0X2FUrEwB8LVzZcua7Z9nzqVkuIH
	K2YpzD61+tiKOhjATDLLy9edq3hHGH7fpLrlCSYzKHLSMe0ygMXGfuwoImI0BnUY
	thBhg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4474xvrg8q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jan 2025 11:12:01 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 16 Jan 2025 11:12:00 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 16 Jan 2025 11:12:00 -0800
Received: from localhost.localdomain (unknown [10.28.36.166])
	by maili.marvell.com (Postfix) with ESMTP id 74DFD3F7088;
	Thu, 16 Jan 2025 11:11:54 -0800 (PST)
From: Suman Ghosh <sumang@marvell.com>
To: <horms@kernel.org>, <sgoutham@marvell.com>, <gakula@marvell.com>,
        <sbhatta@marvell.com>, <hkelam@marvell.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <lcherian@marvell.com>, <jerinj@marvell.com>,
        <john.fastabend@gmail.com>, <bbhushan2@marvell.com>, <hawk@kernel.org>,
        <andrew+netdev@lunn.ch>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <bpf@vger.kernel.org>
CC: Suman Ghosh <sumang@marvell.com>
Subject: [net-next PATCH v4 5/6] octeontx2-pf: Prepare for AF_XDP
Date: Fri, 17 Jan 2025 00:41:15 +0530
Message-ID: <20250116191116.3357181-6-sumang@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250116191116.3357181-1-sumang@marvell.com>
References: <20250116191116.3357181-1-sumang@marvell.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 4ZPgMVWeM8NNtt6ZUTXiZSwzn5jtNqlH
X-Proofpoint-GUID: 4ZPgMVWeM8NNtt6ZUTXiZSwzn5jtNqlH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-16_08,2025-01-16_01,2024-11-22_01

Implement necessary APIs required for AF_XDP transmit.

Signed-off-by: Hariprasad Kelam <hkelam@marvell.com>
Signed-off-by: Suman Ghosh <sumang@marvell.com>
---
 .../marvell/octeontx2/nic/otx2_common.h       |  1 +
 .../marvell/octeontx2/nic/otx2_txrx.c         | 25 +++++++++++++++++--
 2 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
index 6fd9682e2568..ef6f71b92984 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
@@ -1181,4 +1181,5 @@ static inline int mcam_entry_cmp(const void *a, const void *b)
 dma_addr_t otx2_dma_map_skb_frag(struct otx2_nic *pfvf,
 				 struct sk_buff *skb, int seg, int *len);
 void otx2_dma_unmap_skb_frags(struct otx2_nic *pfvf, struct sg_list *sg);
+int otx2_read_free_sqe(struct otx2_nic *pfvf, u16 qidx);
 #endif /* OTX2_COMMON_H */
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
index eb37b179dcc4..6c748b129cb7 100644
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
@@ -1167,7 +1173,7 @@ bool otx2_sq_append_skb(void *dev, struct netdev_queue *txq,
 	/* Check if there is enough room between producer
 	 * and consumer index.
 	 */
-	free_desc = (sq->cons_head - sq->head - 1 + sq->sqe_cnt) & (sq->sqe_cnt - 1);
+	READ_FREE_SQE(sq, free_desc);
 	if (free_desc < sq->sqe_thresh)
 		return false;
 
@@ -1404,6 +1410,21 @@ static void otx2_xdp_sqe_add_sg(struct otx2_snd_queue *sq, u64 dma_addr,
 	sq->sg[sq->head].flags = flags;
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
 bool otx2_xdp_sq_append_pkt(struct otx2_nic *pfvf, u64 iova, int len,
 			    u16 qidx, u16 flags)
 {
@@ -1412,7 +1433,7 @@ bool otx2_xdp_sq_append_pkt(struct otx2_nic *pfvf, u64 iova, int len,
 	int offset, free_sqe;
 
 	sq = &pfvf->qset.sq[qidx];
-	free_sqe = (sq->num_sqbs - *sq->aura_fc_addr) * sq->sqe_per_sqb;
+	READ_FREE_SQE(sq, free_sqe);
 	if (free_sqe < sq->sqe_thresh)
 		return false;
 
-- 
2.25.1


