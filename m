Return-Path: <bpf+bounces-51298-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B711A32F96
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2025 20:26:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC0DC3A82CE
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2025 19:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27E1C263C9A;
	Wed, 12 Feb 2025 19:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="PP8CtoNQ"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BBF6263C8A;
	Wed, 12 Feb 2025 19:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739388340; cv=none; b=SotQr28iV78emQx1CEt3JisYrdIC5pXxblDxcT1A+VxpB7ACMbbtHzHiXdBqygPZ4521zh/UQBf4V8y0X6vZzZW1biEJc13z42q8wNwhw93CqvaQsD8+WyiivTBnXXDdlgbuLcVp43UZAPmWMNF5QyFq0oCi0+ukkSjyQAqWAsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739388340; c=relaxed/simple;
	bh=RtNsGaJRyE/K4wlr3g+ZETa4bV1odoQdB8Kp6q0kV38=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IHeJraC5+J2zcL/ZsY/h7JtuMWYbDidVBkviLA9JvjEorJ+oC4sNgg5wnPIUVg9a5S6o0Uc6WFSeYzVdzYEKANyZziEmVCtn11dyGLxN7HuwQGRlEAaSt+zIe/fG+mdgb+xAVtWZkHyoei8VNIPe+qVQT1K2mD9olqe1LRh758U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=PP8CtoNQ; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51C40W7V000328;
	Wed, 12 Feb 2025 11:25:20 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=J
	iCBg/GEk6/RAD/VI56jjVcWd16bzxJO9zBbGFj0dBs=; b=PP8CtoNQMcDoaE4tT
	Dxf+jW7FK+MCjz+7GeMkh9JFh+WHjKXjbz2t7L6SkXmHnMxPm4V3w+G1EYdpw6Wg
	YsasxB5iWLscNHENmYunB/uHLohCGx5gngmo2BVyUVixWzoDcoWV/AxV0xc0Z9kH
	yrYrZq9omL47IIW0KEVqFSyqAX+IuodIbULYLirv2KmIrP2gkpgK3rPXn6KuvWbh
	eybh1bJ0huVD+sCunp8Hyt4LxD8vM5+2SPVIqTazuFgc+8kIjL33f+YltCqTs+vD
	dkDJPVTdgb3n9ttr/sPMkrphaps7aMgFyqRQqRD8b8WdE55f2rPJcu+58aW5bJxE
	uJUvg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 44rm879t0r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Feb 2025 11:25:19 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 12 Feb 2025 11:25:19 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 12 Feb 2025 11:25:19 -0800
Received: from localhost.localdomain (unknown [10.28.36.166])
	by maili.marvell.com (Postfix) with ESMTP id 2793F3F7043;
	Wed, 12 Feb 2025 11:25:12 -0800 (PST)
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
Date: Thu, 13 Feb 2025 00:54:52 +0530
Message-ID: <20250212192456.2771997-3-sumang@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250212192456.2771997-1-sumang@marvell.com>
References: <20250212192456.2771997-1-sumang@marvell.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: uK-TL3nz9VUgG_FGdxn0kG0_qgIsRwBY
X-Proofpoint-ORIG-GUID: uK-TL3nz9VUgG_FGdxn0kG0_qgIsRwBY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-12_06,2025-02-11_01,2024-11-22_01

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


