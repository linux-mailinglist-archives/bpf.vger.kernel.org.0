Return-Path: <bpf+bounces-48286-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 624F2A06486
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2025 19:34:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 323D43A60A7
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2025 18:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29A8E202C5D;
	Wed,  8 Jan 2025 18:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="bwlwqLuA"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F7E202C4F;
	Wed,  8 Jan 2025 18:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736361243; cv=none; b=IYiaKL4VRIQ2X7PyIlv/EBQiGqUL//79IYMzKLDph9aIh/swhBBJ3pHuny8l1Y02mkmERY4YAzGxxuW3tpQ4iDomUanKOEBS7MdT/OG6jrW59OzVnndwZNZGe71ZXceVmQE6HTeZKf7KIP2qWUT2of3UzEcKggJ49mgx4RJEMLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736361243; c=relaxed/simple;
	bh=vFUG8lUtR6XFfcf2pKnc1lBDhFFZJZjU10x1OGnN10Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ot+04R4HFjlT/7Q9ow9yvuMOXQQgnvOE8Xf1rByeGof7wVS8ywf7q0iFEpdj59SU1tjK3l3xrt4n+fdn3V0Pfn7XrPoN3JQNhZIOrv9fvdx8Ldz76BWk2ttrttqkVGHMYm59YztThuduq/xACyqm0VYZSeIliqdVLuloMXVgLC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=bwlwqLuA; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 508G3qbG009541;
	Wed, 8 Jan 2025 10:33:45 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=C
	geHzPKr+6f83LVmmbhQX3ysS7XaQ/D+fJzd0OPcxTs=; b=bwlwqLuApHbwIeEga
	NBVeB2VDNqjWd0YV7uRRfeVdRiG9SbsHsw6qGyB1fkcOSLW+WImFGig+aN0f5wAP
	My6mq8xmU79l6ybEge1c0pxqbt6dhb/PKcZrOrU0DjqbGoVW/ogqJRJ6TJfaOydM
	J+4654DiSVXipVJIBA+CGECj2O1hqNb1npJTY+Hbhh74FZzXRUN1SpSidyRaK2C+
	K24/LNcm25/1M2703z0AcAc+vrHAtQRnUFrTBOyHfM3dwJUea6ln/S05Y+8JFOsP
	6kpolHwIvfhmCXcHdBWj3fAlOmun0KleP8PQhwvV/Wyh8+sXh1mvLsQcv5BrKoag
	a7wPA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 441vj30bq5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Jan 2025 10:33:44 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 8 Jan 2025 10:33:43 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 8 Jan 2025 10:33:43 -0800
Received: from localhost.localdomain (unknown [10.28.36.166])
	by maili.marvell.com (Postfix) with ESMTP id 52C653F7091;
	Wed,  8 Jan 2025 10:33:38 -0800 (PST)
From: Suman Ghosh <sumang@marvell.com>
To: <sgoutham@marvell.com>, <gakula@marvell.com>, <sbhatta@marvell.com>,
        <hkelam@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <lcherian@marvell.com>,
        <jerinj@marvell.com>, <john.fastabend@gmail.com>,
        <bbhushan2@marvell.com>, <hawk@kernel.org>, <andrew+netdev@lunn.ch>,
        <ast@kernel.org>, <daniel@iogearbox.net>, <bpf@vger.kernel.org>
CC: Suman Ghosh <sumang@marvell.com>
Subject: [net-next PATCH v2 1/6] octeontx2-pf: Add AF_XDP non-zero copy support
Date: Thu, 9 Jan 2025 00:03:24 +0530
Message-ID: <20250108183329.2207738-2-sumang@marvell.com>
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
X-Proofpoint-GUID: Z0r8Ik_Spq6IZeeKBCcAb61eIdqMSSIk
X-Proofpoint-ORIG-GUID: Z0r8Ik_Spq6IZeeKBCcAb61eIdqMSSIk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.687,Hydra:6.0.235,FMLib:17.0.607.475
 definitions=2020-10-13_15,2020-10-13_02,2020-04-07_01

For XDP, page_pool APIs are getting used now. But the memory type was
not getting set due to which XDP_REDIRECT and hence AF_XDP was not
working. This patch ads the memory type MEM_TYPE_PAGE_POOL as the memory
model of the XDP program.

Signed-off-by: Suman Ghosh <sumang@marvell.com>
---
 .../ethernet/marvell/octeontx2/nic/otx2_common.c    |  8 +++++++-
 .../net/ethernet/marvell/octeontx2/nic/otx2_txrx.c  | 13 ++++++++++---
 2 files changed, 17 insertions(+), 4 deletions(-)

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
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
index 224cef938927..ed8b37eb2054 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
@@ -96,7 +96,7 @@ static unsigned int frag_num(unsigned int i)
 
 static void otx2_xdp_snd_pkt_handler(struct otx2_nic *pfvf,
 				     struct otx2_snd_queue *sq,
-				 struct nix_cqe_tx_s *cqe)
+				     struct nix_cqe_tx_s *cqe)
 {
 	struct nix_send_comp_s *snd_comp = &cqe->comp;
 	struct sg_list *sg;
@@ -109,6 +109,11 @@ static void otx2_xdp_snd_pkt_handler(struct otx2_nic *pfvf,
 	otx2_dma_unmap_page(pfvf, sg->dma_addr[0],
 			    sg->size[0], DMA_TO_DEVICE);
 	page = virt_to_page(phys_to_virt(pa));
+	if (page->pp) {
+		page_pool_recycle_direct(page->pp, page);
+		return;
+	}
+
 	put_page(page);
 }
 
@@ -1419,6 +1424,7 @@ static bool otx2_xdp_rcv_pkt_handler(struct otx2_nic *pfvf,
 				     bool *need_xdp_flush)
 {
 	unsigned char *hard_start;
+	struct otx2_pool *pool;
 	int qidx = cq->cq_idx;
 	struct xdp_buff xdp;
 	struct page *page;
@@ -1426,6 +1432,7 @@ static bool otx2_xdp_rcv_pkt_handler(struct otx2_nic *pfvf,
 	u32 act;
 	int err;
 
+	pool = &pfvf->qset.pool[qidx];
 	iova = cqe->sg.seg_addr - OTX2_HEAD_ROOM;
 	pa = otx2_iova_to_phys(pfvf->iommu_domain, iova);
 	page = virt_to_page(phys_to_virt(pa));
@@ -1456,7 +1463,7 @@ static bool otx2_xdp_rcv_pkt_handler(struct otx2_nic *pfvf,
 			*need_xdp_flush = true;
 			return true;
 		}
-		put_page(page);
+		page_pool_recycle_direct(pool->page_pool, page);
 		break;
 	default:
 		bpf_warn_invalid_xdp_action(pfvf->netdev, prog, act);
@@ -1467,7 +1474,7 @@ static bool otx2_xdp_rcv_pkt_handler(struct otx2_nic *pfvf,
 	case XDP_DROP:
 		otx2_dma_unmap_page(pfvf, iova, pfvf->rbsize,
 				    DMA_FROM_DEVICE);
-		put_page(page);
+		page_pool_recycle_direct(pool->page_pool, page);
 		cq->pool_ptrs++;
 		return true;
 	}
-- 
2.25.1


