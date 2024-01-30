Return-Path: <bpf+bounces-20724-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 601C8842470
	for <lists+bpf@lfdr.de>; Tue, 30 Jan 2024 13:07:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 141861F2478B
	for <lists+bpf@lfdr.de>; Tue, 30 Jan 2024 12:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAB8B67E69;
	Tue, 30 Jan 2024 12:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="Rkx4k3O6"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE30679E5;
	Tue, 30 Jan 2024 12:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706616416; cv=none; b=fDKyHQ8cZAVNBcNQHK+jZiIaunZJ/p01pVAl4X9odLYHiugRRwfztFTEMyBRDWcTWUequIPIVb+gkWrVb7PHn3uEQtlTB7M0q8a9EzEjIOTOIG0LUzkAjpsjThkB6AqWsQN9AcMkXft2bC9+8s5oZ8wSeY4fZNKyI7OLXWCtuOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706616416; c=relaxed/simple;
	bh=adWxji5JCkpeR4Tg54o4IjDz9Q6/P4r5JmGOGBT7y6E=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CAPHFnqGJdrr0HJQPQyDWKrGIFDJWDHJf5STOY8DYPnRXozuggEJBztsDdzzoA8GRSXKfwaSoh+UApzxJkGnD7Hy9AmK1WH4w9d0MDblKKPiI72mBx7hFA1YlyT5N6bMrXARDoN4vWEvEddD7BmWWim7UFZObL/z2TXraLb1kgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=Rkx4k3O6; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40UAorfc027107;
	Tue, 30 Jan 2024 04:06:24 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:mime-version:content-type; s=
	pfpt0220; bh=62dZ6GBkhNBWzuByxFX6B3fDWKM6s7akNOoK7y5IauE=; b=Rkx
	4k3O66nkmPsiMnpVgijMgB9TTffnq0n875iCkn3usKxsay/j/PjxkibBUYAClpPJ
	Q98IvxSr5+ghm5Al+M6pFzEDZRSh8yhWfKcZkok9RWEIN9M1znEcT3eoztGjjSyg
	Jpzjc/Hex5Y2AX3jMgMtCy7ZvmzzUgzlS42CEUK8VOvbUqby97fFDWwxKtpSx9PO
	w/YX5QItwokG3rZ4jYiMUKpcfkmPhoUboBpHxeX9Z0Qsw9tpBVr9uUFaf1ql7v4F
	hSkrRuXRMBbTstzCU/Rhowz0HhH27HSIgQXX9cHN62x/q2lUUBD1iBQW7iISGQqw
	AD4xGS1iIgBYNLO0dfw==
Received: from dc5-exch01.marvell.com ([199.233.59.181])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3vx4vre4k5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
	Tue, 30 Jan 2024 04:06:23 -0800 (PST)
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Tue, 30 Jan
 2024 04:06:22 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Tue, 30 Jan 2024 04:06:22 -0800
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
	by maili.marvell.com (Postfix) with ESMTP id 937CF3F70BD;
	Tue, 30 Jan 2024 04:06:16 -0800 (PST)
From: Geetha sowjanya <gakula@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <bpf@vger.kernel.org>
CC: <kuba@kernel.org>, <davem@davemloft.net>, <pabeni@redhat.com>,
        <edumazet@google.com>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <hawk@kernel.org>, <john.fastabend@gmail.com>, <sgoutham@marvell.com>,
        <gakula@marvell.com>, <sbhatta@marvell.com>, <hkelam@marvell.com>
Subject: [net PATCH] octeontx2-pf: Remove xdp queues on program detach
Date: Tue, 30 Jan 2024 17:36:10 +0530
Message-ID: <20240130120610.16673-1-gakula@marvell.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: VlQYAd3mFYDWfMeXr004MyGsqQWC6c5B
X-Proofpoint-GUID: VlQYAd3mFYDWfMeXr004MyGsqQWC6c5B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-30_05,2024-01-30_01,2023-05-22_02

XDP queues are created/destroyed when a XDP program
is attached/detached. In current driver xdp_queues are not
getting destroyed on program exit due to incorrect xdp_queue
and tot_tx_queue count values.

This patch fixes the issue by setting tot_tx_queue and xdp_queue
count to correct values. It also fixes xdp.data_hard_start address.

Fixes: 06059a1a9a4a ("octeontx2-pf: Add XDP support to netdev PF")
Signed-off-by: Geetha sowjanya <gakula@marvell.com>
---
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c | 1 -
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c      | 3 +--
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c    | 7 +++----
 3 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
index 2928898c7f8d..7f786de61014 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
@@ -314,7 +314,6 @@ static int otx2_set_channels(struct net_device *dev,
 	pfvf->hw.tx_queues = channel->tx_count;
 	if (pfvf->xdp_prog)
 		pfvf->hw.xdp_queues = channel->rx_count;
-	pfvf->hw.non_qos_queues =  pfvf->hw.tx_queues + pfvf->hw.xdp_queues;
 
 	if (if_up)
 		err = dev->netdev_ops->ndo_open(dev);
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
index a57455aebff6..e5fe67e73865 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
@@ -1744,6 +1744,7 @@ int otx2_open(struct net_device *netdev)
 	/* RQ and SQs are mapped to different CQs,
 	 * so find out max CQ IRQs (i.e CINTs) needed.
 	 */
+	pf->hw.non_qos_queues =  pf->hw.tx_queues + pf->hw.xdp_queues;
 	pf->hw.cint_cnt = max3(pf->hw.rx_queues, pf->hw.tx_queues,
 			       pf->hw.tc_tx_queues);
 
@@ -2643,8 +2644,6 @@ static int otx2_xdp_setup(struct otx2_nic *pf, struct bpf_prog *prog)
 		xdp_features_clear_redirect_target(dev);
 	}
 
-	pf->hw.non_qos_queues += pf->hw.xdp_queues;
-
 	if (if_up)
 		otx2_open(pf->netdev);
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
index 4d519ea833b2..f828d32737af 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
@@ -1403,7 +1403,7 @@ static bool otx2_xdp_rcv_pkt_handler(struct otx2_nic *pfvf,
 				     struct otx2_cq_queue *cq,
 				     bool *need_xdp_flush)
 {
-	unsigned char *hard_start, *data;
+	unsigned char *hard_start;
 	int qidx = cq->cq_idx;
 	struct xdp_buff xdp;
 	struct page *page;
@@ -1417,9 +1417,8 @@ static bool otx2_xdp_rcv_pkt_handler(struct otx2_nic *pfvf,
 
 	xdp_init_buff(&xdp, pfvf->rbsize, &cq->xdp_rxq);
 
-	data = (unsigned char *)phys_to_virt(pa);
-	hard_start = page_address(page);
-	xdp_prepare_buff(&xdp, hard_start, data - hard_start,
+	hard_start = (unsigned char *)phys_to_virt(pa);
+	xdp_prepare_buff(&xdp, hard_start, OTX2_HEAD_ROOM,
 			 cqe->sg.seg_size, false);
 
 	act = bpf_prog_run_xdp(prog, &xdp);
-- 
2.25.1


