Return-Path: <bpf+bounces-48289-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D228A06490
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2025 19:35:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BFE9167E4A
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2025 18:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 617712040A3;
	Wed,  8 Jan 2025 18:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="R4vpeGZR"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EDB42010EE;
	Wed,  8 Jan 2025 18:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736361266; cv=none; b=SvL9KvKv7B3r5mf2Z3bh79w3OghjZQlO5dBCoJ2Wd7vx+L/bV0L+f4CJ15yy1Cdb4vOpKA+XVF63V+ZnOEsARypFG3TlxisXgOJYkphEtjnXRT/w7tENphIqrMQrr1cnq3sed5y2RA5iP6swyipULQ2mqL3tn6CD0TckPviRTpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736361266; c=relaxed/simple;
	bh=g3Mi44bG8J13OidGZg00DPl4MwER7duTNELT9lghQyg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uB4uQCC7isWJ0k896Caq9oOJecN1icHtAUnBT+FpnyYGk3Z9HEumNf0xsXd3DGVmewJ4S2SN3NxFYBhbPmFrevApudC3nCWAnQrykw5QdZtBzUb7eV6h1MSY2CSQTJyMtwlN2TiGZaeJX1tHTmdZWeH3nCZnPv7QO7UUcMa7M3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=R4vpeGZR; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 508HduKw020996;
	Wed, 8 Jan 2025 10:34:06 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=V
	er/3xMXtJPrzmxoJcBF5j2KjyQOPrjRrZIQAa4Yzk4=; b=R4vpeGZRO0TasDSYa
	ns+PhVcvU1znhNPB0jPYvl8HGW7ZuI4xnLo3f25u9j5zeTrLf0C3p6JTkR81T2op
	u1XD4Lz2UaYzXCIhzF//AT2bLagCdZXcn9tXUc1npDXKs8SB1P8blM35c46fQMkG
	TRLLJu4De5JMvOjDT3AIe3Lr1C2SuNwLnBgHz/WzZ04PQUQrwXcoDKIFAB7QOhsr
	qt7ghwXbhT5EpGImIxZlsCilJ7Gy1MIVa+PM6pBXEWHYvouvyZgAhYShbzNB4OZB
	Gza24DWjknu+87OC8HV2BMhfGPDostyWKrcY0BAimSWgCLwzPXL42YL+30Rx3y23
	3J3ug==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 441wy9r48d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Jan 2025 10:34:06 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 8 Jan 2025 10:34:04 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 8 Jan 2025 10:34:04 -0800
Received: from localhost.localdomain (unknown [10.28.36.166])
	by maili.marvell.com (Postfix) with ESMTP id 4BF293F7091;
	Wed,  8 Jan 2025 10:33:59 -0800 (PST)
From: Suman Ghosh <sumang@marvell.com>
To: <sgoutham@marvell.com>, <gakula@marvell.com>, <sbhatta@marvell.com>,
        <hkelam@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <lcherian@marvell.com>,
        <jerinj@marvell.com>, <john.fastabend@gmail.com>,
        <bbhushan2@marvell.com>, <hawk@kernel.org>, <andrew+netdev@lunn.ch>,
        <ast@kernel.org>, <daniel@iogearbox.net>, <bpf@vger.kernel.org>
CC: Suman Ghosh <sumang@marvell.com>
Subject: [net-next PATCH v2 4/6] octeontx2-pf: Reconfigure RSS table after enabling AF_XDP zerocopy on rx queue
Date: Thu, 9 Jan 2025 00:03:27 +0530
Message-ID: <20250108183329.2207738-5-sumang@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250108183329.2207738-1-sumang@marvell.com>
References: <20250108183329.2207738-1-sumang@marvell.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: vIogf5sPeSTDtMMrpoJaRm2Xv5StY5EO
X-Proofpoint-ORIG-GUID: vIogf5sPeSTDtMMrpoJaRm2Xv5StY5EO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.687,Hydra:6.0.235,FMLib:17.0.607.475
 definitions=2020-10-13_15,2020-10-13_02,2020-04-07_01

RSS table needs to be reconfigured once a rx queue is enabled or
disabled for AF_XDP zerocopy support. After enabling UMEM on a rx queue,
that queue should not be part of RSS queue selection algorithm.
Similarly the queue should be considered again after UMEM is disabled.

Signed-off-by: Suman Ghosh <sumang@marvell.com>
---
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c  | 4 ++++
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c | 6 +++++-
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_xsk.c     | 4 ++++
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
index e73d492ea2fa..7773a3ab7ff8 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
@@ -331,6 +331,10 @@ int otx2_set_rss_table(struct otx2_nic *pfvf, int ctx_id)
 	rss_ctx = rss->rss_ctx[ctx_id];
 	/* Get memory to put this msg */
 	for (idx = 0; idx < rss->rss_size; idx++) {
+		/* Ignore the queue if AF_XDP zero copy is enabled */
+		if (test_bit(rss_ctx->ind_tbl[idx], pfvf->af_xdp_zc_qidx))
+			continue;
+
 		aq = otx2_mbox_alloc_msg_nix_aq_enq(mbox);
 		if (!aq) {
 			/* The shared memory buffer can be full.
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
index 2d53dc77ef1e..010385b29988 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
@@ -910,8 +910,12 @@ static int otx2_get_rxfh(struct net_device *dev,
 		return -ENOENT;
 
 	if (indir) {
-		for (idx = 0; idx < rss->rss_size; idx++)
+		for (idx = 0; idx < rss->rss_size; idx++) {
+			/* Ignore if the rx queue is AF_XDP zero copy enabled */
+			if (test_bit(rss_ctx->ind_tbl[idx], pfvf->af_xdp_zc_qidx))
+				continue;
 			indir[idx] = rss_ctx->ind_tbl[idx];
+		}
 	}
 	if (rxfh->key)
 		memcpy(rxfh->key, rss->key, sizeof(rss->key));
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_xsk.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_xsk.c
index 69098c6a6fed..f6bbe18016ba 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_xsk.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_xsk.c
@@ -130,6 +130,8 @@ int otx2_xsk_pool_enable(struct otx2_nic *pf, struct xsk_buff_pool *pool, u16 qi
 
 	set_bit(qidx, pf->af_xdp_zc_qidx);
 	otx2_clean_up_rq(pf, qidx);
+	/* Reconfigure RSS table as 'qidx' cannot be part of RSS now */
+	otx2_set_rss_table(pf, DEFAULT_RSS_CONTEXT_GROUP);
 	/* Kick start the NAPI context so that receiving will start */
 	return otx2_xsk_wakeup(pf->netdev, qidx, XDP_WAKEUP_RX);
 }
@@ -146,6 +148,8 @@ int otx2_xsk_pool_disable(struct otx2_nic *pf, u16 qidx)
 	otx2_clean_up_rq(pf, qidx);
 	clear_bit(qidx, pf->af_xdp_zc_qidx);
 	xsk_pool_dma_unmap(pool, DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_WEAK_ORDERING);
+	/* Reconfigure RSS table as 'qidx' now need to be part of RSS now */
+	otx2_set_rss_table(pf, DEFAULT_RSS_CONTEXT_GROUP);
 
 	return 0;
 }
-- 
2.25.1


