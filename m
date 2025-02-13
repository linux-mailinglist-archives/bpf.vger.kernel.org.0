Return-Path: <bpf+bounces-51361-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C47BA3374F
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2025 06:34:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20793168A39
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2025 05:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76C402080DE;
	Thu, 13 Feb 2025 05:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="dmr1rl8M"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65656206F15;
	Thu, 13 Feb 2025 05:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739424761; cv=none; b=IvtdE1OjONSFtIVuN41OB8terJXH+S39j4j7SFqI0q5I7l9S/PB9FegzBJwIIWpxAklwdNykrwpoDmoI/EKTc2DLhESLfJaqUR+EFlRIKFUUOk8Cky/VMZSsCRnNehjBugDYz3JAAusKE0k2ybqkprvMYvt8aTZDzwhdGcJzz5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739424761; c=relaxed/simple;
	bh=T0D0QW3526r5x0b6c5X8yywhhi8pHH1LN4572UOSvJI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BW3aQRoklxA04yG6irC9q9nTZlss2pvo/lHAUjwu5TAq6m049eAPH6qGBZKdxPsC1QwJCFRL+I2JAw/hSanLE/udd+jIbypA0IU0HZSB2GZWtX+64QAfjm4FWs5LgYPaIp5BwcWoGFvgfCIL7o0WaxaUQDo+xom7QpVzuQbPDvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=dmr1rl8M; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51D0O7mc009202;
	Wed, 12 Feb 2025 21:32:20 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=F
	EcO6PG3fq76Fm0efy0QRlKYReNJSABQ67wgnEK4Y9w=; b=dmr1rl8MHDMqeJj2y
	BgzQsUuz/jBi2yQlnP+pjgbQTCHArf+qAaGWhdpfM871ASm9DkykbbEQjvdNkzzM
	LAA+PAdL1BGPNW6VnP0rH3w2JqToif8uVjhmISzKS+i7J6As5ldQ0sad4759Cu+d
	eghIOEN6CjJ/aVasX2Nb1qG3gHKtsPWhcqLv7B/rmq5hBT7QPmgAZvLSz2PKtjPT
	nq1oNzVD3mdvdcVgZC5UBo+izDWlTxGn6v2h71jsf6sDtAY/IJmtDxm6qRdjiGpA
	hLfb7UqeffG4D6gegqgDrGEAcdBctT/E52v3jpspgj8PuVUa/HzEDEiZyVROrVzb
	I3fKw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 44s65fgg6h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Feb 2025 21:32:20 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 12 Feb 2025 21:32:19 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 12 Feb 2025 21:32:19 -0800
Received: from localhost.localdomain (unknown [10.28.36.166])
	by maili.marvell.com (Postfix) with ESMTP id 501323F7096;
	Wed, 12 Feb 2025 21:32:13 -0800 (PST)
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
Subject: [net-next PATCH v6 4/6] octeontx2-pf: Reconfigure RSS table after enabling AF_XDP zerocopy on rx queue
Date: Thu, 13 Feb 2025 11:01:39 +0530
Message-ID: <20250213053141.2833254-5-sumang@marvell.com>
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
X-Proofpoint-ORIG-GUID: pcCHEJCiuUYHu4dX6rPMBhff90Odkym9
X-Proofpoint-GUID: pcCHEJCiuUYHu4dX6rPMBhff90Odkym9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-13_02,2025-02-11_01,2024-11-22_01

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
index 92b0dba07853..6f7c11d59942 100644
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
index 894c1e0aea6f..3bdee1603fac 100644
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


