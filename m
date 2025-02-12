Return-Path: <bpf+bounces-51232-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2373DA322C3
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2025 10:49:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E0A816778B
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2025 09:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E14F209684;
	Wed, 12 Feb 2025 09:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="bn8VGpvu"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D109A208988;
	Wed, 12 Feb 2025 09:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739353704; cv=none; b=XKa+DkAIs7I7FhhcYVydy3+7pHnBBBZAWhbPbFipWnpLrw2mb7/2oob5MdLzBGaGb7MF8tiKM7MvsSkT9qsD4GzRTYogDUS/mTZSJI5Ib45grldIZKx3IeQJRt648cTWIhW0eUJ50RH3epKacNMtwH6rE3hcGdVeI+XUpg6HGLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739353704; c=relaxed/simple;
	bh=RtNsGaJRyE/K4wlr3g+ZETa4bV1odoQdB8Kp6q0kV38=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D9oSSgH7xaP4w0w78qUaAb+vPRFrcfZa8IaatyuPrHIY4Yj9yRdYTi1kaCed1JMzOuNNAnqAOF6mscMgQUzkbbmk+0BgSs+M2GEahRGLlo9+WdoCPBpRp/gaEUlJoeQqen8ftkliSe0yf0HRfoMWpU3K7yjIQslHpZkPaEGQPEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=bn8VGpvu; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51C59Kuh014229;
	Wed, 12 Feb 2025 01:48:03 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=J
	iCBg/GEk6/RAD/VI56jjVcWd16bzxJO9zBbGFj0dBs=; b=bn8VGpvucsrHUPKU1
	CdYYSDcuYnVD7chB75n0WmbXhRz7VmUyCfn4DYEWSSn4NteBBMh8eatRu7rWrCjd
	n73v4XIlNMlb5TyEVMQQhBGIIlZ7VbMHUK4DvsmjyyrlE2N3MOShP+pJK0u198eE
	zTAFw8bG8Zdwr8HRbXVD83ZQaRO/5scPEi43IMzAHDZK6eNcD3sFuhFiArRuLz55
	EWjKZ2RedYrPMgd8l7eEvKDmJPOrV7dgcjoxAcGJtpECST7APTYl0Ins3xU8gsY6
	LuItBZOc3hskR4aE7LEfEP4ujQTLHY2pNzu6aXEmpitZsBmzu5isDykwqghHPjB8
	0tAew==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 44rn8c8fen-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Feb 2025 01:48:03 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 12 Feb 2025 01:48:02 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 12 Feb 2025 01:48:02 -0800
Received: from localhost.localdomain (unknown [10.28.36.166])
	by maili.marvell.com (Postfix) with ESMTP id D6AA23F708A;
	Wed, 12 Feb 2025 01:47:55 -0800 (PST)
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
Subject: [net-next PATCH v6 2/6] octeontx2-pf: Add AF_XDP non-zero copy support
Date: Wed, 12 Feb 2025 15:17:34 +0530
Message-ID: <20250212094738.2671725-3-sumang@marvell.com>
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
X-Proofpoint-ORIG-GUID: 28mJki0R2iMBhHa319rZ30ona857kj9-
X-Proofpoint-GUID: 28mJki0R2iMBhHa319rZ30ona857kj9-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-12_03,2025-02-11_01,2024-11-22_01

Set xdp rx ring memory type as MEM_TYPE_PAGE_POOL for
af-xdp to work. This is needed since xdp_return_frame
internally will use page pools.

Fixes: 06059a1a9a4a ("octeontx2-pf: Add XDP support to netdev PF")
Signed-off-by: Suman Ghosh <sumang@marvell.com>
---
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
index 2b49bfec7869..161cf33ef89e 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
@@ -1047,6 +1047,7 @@ static int otx2_cq_init(struct otx2_nic *pfvf, u16 qidx)
 	int err, pool_id, non_xdp_queues;
 	struct nix_aq_enq_req *aq;
 	struct otx2_cq_queue *cq;
+	struct otx2_pool *pool;
 
 	cq = &qset->cq[qidx];
 	cq->cq_idx = qidx;
@@ -1055,8 +1056,13 @@ static int otx2_cq_init(struct otx2_nic *pfvf, u16 qidx)
 		cq->cq_type = CQ_RX;
 		cq->cint_idx = qidx;
 		cq->cqe_cnt = qset->rqe_cnt;
-		if (pfvf->xdp_prog)
+		if (pfvf->xdp_prog) {
+			pool = &qset->pool[qidx];
 			xdp_rxq_info_reg(&cq->xdp_rxq, pfvf->netdev, qidx, 0);
+			xdp_rxq_info_reg_mem_model(&cq->xdp_rxq,
+						   MEM_TYPE_PAGE_POOL,
+						   pool->page_pool);
+		}
 	} else if (qidx < non_xdp_queues) {
 		cq->cq_type = CQ_TX;
 		cq->cint_idx = qidx - pfvf->hw.rx_queues;
-- 
2.25.1


