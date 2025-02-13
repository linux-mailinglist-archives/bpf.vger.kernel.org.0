Return-Path: <bpf+bounces-51362-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90F15A33752
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2025 06:34:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5AAA168D90
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2025 05:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA26620764A;
	Thu, 13 Feb 2025 05:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="BsRaIGxL"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD59D2066F0;
	Thu, 13 Feb 2025 05:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739424769; cv=none; b=HjpUy4kF6HeoMei3QISG5NuYqR3UFbqFyIYb1BzBvMB4XQJmwhcS5TW4oa3K7GJuNZkdXRwWYF3jzhnYnm0x54iK17pjJRp1aIr0YiSeVE9dnD4Ei32G7aIp+KfnfMjpxyj6B6zVyOqaI/PXPaP24X5O2XBkRl3RlZErsYOwLKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739424769; c=relaxed/simple;
	bh=p4lLou9jR/5i5jryQ+c5wNxurkN/k/jBM8ck1oxCZBw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q13LZYzzKUFYTIFNa1h7e+bOVeLsiBYnhbA0j8wO9LE/OmYaf3tQ8bELaZXylX7j+AFsEkejNT/awHXNAgb7qPY4Xtlu7MVU6O/Ifruwd9ZfvipMkCuqpR7VBh/gTYwQvKX3xcpH3FWHymGS5NQE4I6aWiPMSQT/1TeJathCEWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=BsRaIGxL; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51D5OLO2023573;
	Wed, 12 Feb 2025 21:32:27 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=B
	M1NwnrPgoeHtetmEdpZ7hXW8xXmFgczyGTaEVLIXAE=; b=BsRaIGxLp9VhP6ifH
	H0iRUDcJJjxIGgQj0rclYAFTIhmeFLp3z+0ibOPpalLDAbsXcqhNrjYuOmjkkEcw
	6bX3pvcemRowvyrl+isNrLF7/okJ7WGvu+m45WUA4v9FwWol9JwWefnTP/YOKx1c
	CpFX75CrZCMtoynLV/l9ZQEmN5HhyZokhN5Mc9RoN4ymB9sj5+ZhHvNdHZgFMsmq
	5bAw1iUZuBwqOh9/X3Cy6zRHktU4rDRgZst+gbJDvaEo93Vr5LxQFPvkv5oihRT/
	XYi4pi858FPSNxOWlX/sf+fFfPCieqdnxhfZwtyLipAKJwTEvFJ2f786MRAtc2i4
	VeSpw==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 44rw9g9pms-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Feb 2025 21:32:27 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 12 Feb 2025 21:32:27 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 12 Feb 2025 21:32:26 -0800
Received: from localhost.localdomain (unknown [10.28.36.166])
	by maili.marvell.com (Postfix) with ESMTP id CA34F3F7096;
	Wed, 12 Feb 2025 21:32:20 -0800 (PST)
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
Date: Thu, 13 Feb 2025 11:01:40 +0530
Message-ID: <20250213053141.2833254-6-sumang@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250213053141.2833254-1-sumang@marvell.com>
References: <20250213053141.2833254-1-sumang@marvell.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: ogiZgEFV6MdZZnP9_S9PjLz6pDD5mb6o
X-Proofpoint-ORIG-GUID: ogiZgEFV6MdZZnP9_S9PjLz6pDD5mb6o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-13_02,2025-02-11_01,2024-11-22_01

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


