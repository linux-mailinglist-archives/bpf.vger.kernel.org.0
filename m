Return-Path: <bpf+bounces-48541-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01E47A08C6D
	for <lists+bpf@lfdr.de>; Fri, 10 Jan 2025 10:42:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C5583A621E
	for <lists+bpf@lfdr.de>; Fri, 10 Jan 2025 09:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E83520B813;
	Fri, 10 Jan 2025 09:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="aJ2YwIH/"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0D920B206;
	Fri, 10 Jan 2025 09:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736501952; cv=none; b=U2AiDGu6gY5GKP70hQWrPenaEUwIxLepk7Jq3YPrMl/jY21HXd5MwjbzleYuQakDPm6BKXHpPx00jSHTyebrUYuHw8pTor0oAa3/DBKhQ2Kz1noFL+apLEdc8YzSu7sj+OvUtOFLvrT9b0AL24D+66konhoHr+bx9oXGleThn/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736501952; c=relaxed/simple;
	bh=bbnVa4Cz6yYwNCxQ3uJOWleTIq1pC19Lh2BL/RYnSXs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zgr4Dfu7Lm5Oklx+h+wIo6Xl2tOf57qH23XMU90CljAUaB3PmBFvaZoE+7Uyw4J/hJh0M4q4iAIcJcsldWEbH57iQ54qjXmGP6TtpYNOYIpoqq+YpPDqJa2IxynLJIEESWIOP5aOM/eo7rI4nbaHpmY/+1WfAkluSJTV2HeFNlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=aJ2YwIH/; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50A8wdBq028350;
	Fri, 10 Jan 2025 01:38:54 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=N
	/MGyCoVFMc3BH9V9M8lYBV83H5wib6k87VMlTnIwmY=; b=aJ2YwIH/M7N38TYTg
	N5Xvliq8n5KD8YfOSQqgy+z/Ua+Prh8Lfkk/khok0BMyoKzQjdVwN6UW247XOkDP
	VUv6tnt3tX77kFSBLyATPaWYhSqzZSrXV4EIrZkm4rEe19jbc/8CSUAxagrnIT9h
	5/pVnBUt701k1Ne8vC6nLM0AycCYSli+sGmnzvR2cciBGJxF3yLOLI6uhK23fIVj
	5gN3bC4GmunLjG5o9HUUJMNx9z9xUYFpm/sadpM9+QTtN6WHZwtgqm08/ZLuoNig
	Y1C5aRiCpvYxGxeWhGV1Gr2QwrE2aLp10jynMCxM35aGCK68xUmK94YjI8+poDY3
	3HEwQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4430gw036h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Jan 2025 01:38:54 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 10 Jan 2025 01:38:52 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 10 Jan 2025 01:38:52 -0800
Received: from localhost.localdomain (unknown [10.28.36.166])
	by maili.marvell.com (Postfix) with ESMTP id 173813F7084;
	Fri, 10 Jan 2025 01:38:46 -0800 (PST)
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
Subject: [net-next PATCH v3 5/6] Octeontx2-pf: Prepare for AF_XDP
Date: Fri, 10 Jan 2025 15:08:06 +0530
Message-ID: <20250110093807.2451954-6-sumang@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250110093807.2451954-1-sumang@marvell.com>
References: <20250110093807.2451954-1-sumang@marvell.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: cDgUdl0y_JvmaO_VIiUgj2jFso3xbZCI
X-Proofpoint-ORIG-GUID: cDgUdl0y_JvmaO_VIiUgj2jFso3xbZCI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

From: Hariprasad Kelam <hkelam@marvell.com>

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
index 7ef4e196429d..506bf26f64b1 100644
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


