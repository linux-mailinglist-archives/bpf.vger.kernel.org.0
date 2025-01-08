Return-Path: <bpf+bounces-48278-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B665A06463
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2025 19:31:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8D9D18888CC
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2025 18:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E620202C40;
	Wed,  8 Jan 2025 18:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="duCdpGGN"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB4A201116;
	Wed,  8 Jan 2025 18:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736361041; cv=none; b=cF9rwb3TysbZss09HJzz7fB4eYlBc26CxLNp1u3zBlTngpcGH5MXHw0E2N8X0gC7LrF+lqkcJCMwg4n+3Ieh9E/V1FrQzJCYFYzqw2fFSzrqKVeZpMWpB7fN3xrer/ir33bigW1CXIO0lOusQms9kNLqyZtVLrU2Ai9ZvhF/dA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736361041; c=relaxed/simple;
	bh=vFUG8lUtR6XFfcf2pKnc1lBDhFFZJZjU10x1OGnN10Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hQAPBfICzz9YQpPLSy78Xhsv1cAP7PXfFrTDvYsfXXorayL8Ni6kHI8MlEXHQinP95OPRK+UO8ZIJSEpE+ZBspZQWxZJR6yIX1rTG6SXqk+WLlHSSmu6wL0zxn/e3JjY/Gqgq9PfXZsIgAcvoJF7YTBoFYJoOrFzRFDYNBApizg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=duCdpGGN; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 508EHMqg023863;
	Wed, 8 Jan 2025 10:30:15 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=C
	geHzPKr+6f83LVmmbhQX3ysS7XaQ/D+fJzd0OPcxTs=; b=duCdpGGNFYvRueh//
	qeWlAxb1ty+4JhUZhsCCpiNvbWAst6ROV/rGj/e2iej83d166Pp+og+LJgV3QkQX
	IlOnsNLeaCGOIwBR4zOZBeAeGsqGv6eFcAzfVLqhbsnYMMsMS3wmh80EhhVBO99k
	lu/LzE35caMe5o6o1oHQTmi/xFEbvjc/xp8ROXxy/n7k+zTUHv5l8oYYWwjqmnIr
	5PERNnECFm5VzW3Rpz99dgYHA0bAftNdgJ+rgw0y9JW893t30hd/8CAwFDXb6Y9A
	RbpQapnPT+4TCUGPRMlMKsH25nKjzVnzVC5UoPSj80aM99Uqs8uLcbb81xzf2ofh
	SjezQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 441tyrrj63-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Jan 2025 10:30:14 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 8 Jan 2025 10:30:14 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 8 Jan 2025 10:30:14 -0800
Received: from localhost.localdomain (unknown [10.28.36.166])
	by maili.marvell.com (Postfix) with ESMTP id BDFF13F7095;
	Wed,  8 Jan 2025 10:30:08 -0800 (PST)
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
Date: Wed, 8 Jan 2025 23:59:54 +0530
Message-ID: <20250108182959.2207450-2-sumang@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250108182959.2207450-1-sumang@marvell.com>
References: <20250108182959.2207450-1-sumang@marvell.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: DhWnYu66nkHAM7vV4OO7auVScdVqQJMw
X-Proofpoint-ORIG-GUID: DhWnYu66nkHAM7vV4OO7auVScdVqQJMw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

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


