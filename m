Return-Path: <bpf+bounces-51297-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3500DA32F93
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2025 20:26:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D13CD167746
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2025 19:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 810C2262D23;
	Wed, 12 Feb 2025 19:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="d1Ho//Ws"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61188263C60;
	Wed, 12 Feb 2025 19:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739388335; cv=none; b=YmhwPMZnSWn4QtwJ2dfWJlGlzY81xyS//ygt1KCx3IlPR7NnKXqlIH49G2okYrkQLHQ5ENuVjPXssGzS3MSfWZDh2kfQl0UVEENM66vmpt25pHg+E3pC5Ai8JYOzx1CGs6RJrso6slpOeV5nOTae0uIhKGAR+x6IiKh5hCAd85Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739388335; c=relaxed/simple;
	bh=PDQ6bJAApisNsvyu9DdHAcoMBz7dwLxLrxNqxzoNtwY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mclDCbRCMxDKBW05m7BbadoJnhHVhIsX0dLXhRDwQVvebEE2VRS27rCl0zZVBDHgjJfTtEjle/ZS5O3Fd0MbuYq56UXU0KUvH5O2tPBFZT35IJ6NDWnK+XawACo9HEzeDnJqzBKqlJWGTB6yuLuuDRjXa50bYNJ9A6IsMKAAIUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=d1Ho//Ws; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51C41K3i002226;
	Wed, 12 Feb 2025 11:25:13 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=6
	ilhlumpUAaAkieN+tf9v6AWFTVlzrr8VolwXK9mExc=; b=d1Ho//WsIOgcs5GcT
	67Jniqr/mYc0QxQe/R1c8EDROCnyUBHzEHh9aOVLCEpDlbED7vlgAgbDl7bm08+4
	fuiXZCZWWbNtkrVMD5ekPyhG10wDRXJKztm6EO1zGOBGTB/t0FudYjvbwD1YUIku
	p2vyt4nvCxRdD9NombhUFQw9+C1kr0lwfwgZ/XMfh80vzRuzb28Fap0ZEuFxbHBe
	9m0P13VEDGvK85fXP15vjYAaVsr3l16MS04Q6OLPW5rHn8H5yifQZNjIuSaMqQG5
	2p4QCVFAk132SKuYvOSFOaSRDfeC8Szn0WxV23vmFm3XhiR3tyiXpNysIOhULyMj
	I0Auw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 44rm879t0p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Feb 2025 11:25:12 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 12 Feb 2025 11:25:12 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 12 Feb 2025 11:25:11 -0800
Received: from localhost.localdomain (unknown [10.28.36.166])
	by maili.marvell.com (Postfix) with ESMTP id E87783F7043;
	Wed, 12 Feb 2025 11:25:05 -0800 (PST)
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
Subject: [net-next PATCH v6 1/6] octeontx2-pf: use xdp_return_frame() to free xdp buffers
Date: Thu, 13 Feb 2025 00:54:51 +0530
Message-ID: <20250212192456.2771997-2-sumang@marvell.com>
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
X-Proofpoint-GUID: 6wT_E5ahktoetZslc5u_YDEOpaXo_7Vb
X-Proofpoint-ORIG-GUID: 6wT_E5ahktoetZslc5u_YDEOpaXo_7Vb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-12_06,2025-02-11_01,2024-11-22_01

xdp_return_frames() will help to free the xdp frames and their
associated pages back to page pool.

Signed-off-by: Geetha sowjanya <gakula@marvell.com>
Signed-off-by: Suman Ghosh <sumang@marvell.com>
---
 .../marvell/octeontx2/nic/otx2_common.h       |  4 +-
 .../ethernet/marvell/octeontx2/nic/otx2_pf.c  |  7 ++-
 .../marvell/octeontx2/nic/otx2_txrx.c         | 53 +++++++++++--------
 .../marvell/octeontx2/nic/otx2_txrx.h         |  1 +
 4 files changed, 38 insertions(+), 27 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
index 65814e3dc93f..d5fbccb289df 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
@@ -21,6 +21,7 @@
 #include <linux/time64.h>
 #include <linux/dim.h>
 #include <uapi/linux/if_macsec.h>
+#include <net/page_pool/helpers.h>
 
 #include <mbox.h>
 #include <npc.h>
@@ -1094,7 +1095,8 @@ int otx2_del_macfilter(struct net_device *netdev, const u8 *mac);
 int otx2_add_macfilter(struct net_device *netdev, const u8 *mac);
 int otx2_enable_rxvlan(struct otx2_nic *pf, bool enable);
 int otx2_install_rxvlan_offload_flow(struct otx2_nic *pfvf);
-bool otx2_xdp_sq_append_pkt(struct otx2_nic *pfvf, u64 iova, int len, u16 qidx);
+bool otx2_xdp_sq_append_pkt(struct otx2_nic *pfvf, struct xdp_frame *xdpf,
+			    u64 iova, int len, u16 qidx, u16 flags);
 u16 otx2_get_max_mtu(struct otx2_nic *pfvf);
 int otx2_handle_ntuple_tc_features(struct net_device *netdev,
 				   netdev_features_t features);
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
index e1dde93e8af8..4347a3c95350 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
@@ -2691,7 +2691,6 @@ static int otx2_get_vf_config(struct net_device *netdev, int vf,
 static int otx2_xdp_xmit_tx(struct otx2_nic *pf, struct xdp_frame *xdpf,
 			    int qidx)
 {
-	struct page *page;
 	u64 dma_addr;
 	int err = 0;
 
@@ -2701,11 +2700,11 @@ static int otx2_xdp_xmit_tx(struct otx2_nic *pf, struct xdp_frame *xdpf,
 	if (dma_mapping_error(pf->dev, dma_addr))
 		return -ENOMEM;
 
-	err = otx2_xdp_sq_append_pkt(pf, dma_addr, xdpf->len, qidx);
+	err = otx2_xdp_sq_append_pkt(pf, xdpf, dma_addr, xdpf->len,
+				     qidx, XDP_REDIRECT);
 	if (!err) {
 		otx2_dma_unmap_page(pf, dma_addr, xdpf->len, DMA_TO_DEVICE);
-		page = virt_to_page(xdpf->data);
-		put_page(page);
+		xdp_return_frame(xdpf);
 		return -ENOMEM;
 	}
 	return 0;
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
index 224cef938927..8b44dd3c17a8 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
@@ -96,20 +96,16 @@ static unsigned int frag_num(unsigned int i)
 
 static void otx2_xdp_snd_pkt_handler(struct otx2_nic *pfvf,
 				     struct otx2_snd_queue *sq,
-				 struct nix_cqe_tx_s *cqe)
+				     struct nix_cqe_tx_s *cqe)
 {
 	struct nix_send_comp_s *snd_comp = &cqe->comp;
 	struct sg_list *sg;
-	struct page *page;
-	u64 pa;
 
 	sg = &sq->sg[snd_comp->sqe_id];
-
-	pa = otx2_iova_to_phys(pfvf->iommu_domain, sg->dma_addr[0]);
-	otx2_dma_unmap_page(pfvf, sg->dma_addr[0],
-			    sg->size[0], DMA_TO_DEVICE);
-	page = virt_to_page(phys_to_virt(pa));
-	put_page(page);
+	if (sg->flags & XDP_REDIRECT)
+		otx2_dma_unmap_page(pfvf, sg->dma_addr[0], sg->size[0], DMA_TO_DEVICE);
+	xdp_return_frame((struct xdp_frame *)sg->skb);
+	sg->skb = (u64)NULL;
 }
 
 static void otx2_snd_pkt_handler(struct otx2_nic *pfvf,
@@ -1359,8 +1355,9 @@ void otx2_free_pending_sqe(struct otx2_nic *pfvf)
 	}
 }
 
-static void otx2_xdp_sqe_add_sg(struct otx2_snd_queue *sq, u64 dma_addr,
-				int len, int *offset)
+static void otx2_xdp_sqe_add_sg(struct otx2_snd_queue *sq,
+				struct xdp_frame *xdpf,
+				u64 dma_addr, int len, int *offset, u16 flags)
 {
 	struct nix_sqe_sg_s *sg = NULL;
 	u64 *iova = NULL;
@@ -1377,9 +1374,12 @@ static void otx2_xdp_sqe_add_sg(struct otx2_snd_queue *sq, u64 dma_addr,
 	sq->sg[sq->head].dma_addr[0] = dma_addr;
 	sq->sg[sq->head].size[0] = len;
 	sq->sg[sq->head].num_segs = 1;
+	sq->sg[sq->head].flags = flags;
+	sq->sg[sq->head].skb = (u64)xdpf;
 }
 
-bool otx2_xdp_sq_append_pkt(struct otx2_nic *pfvf, u64 iova, int len, u16 qidx)
+bool otx2_xdp_sq_append_pkt(struct otx2_nic *pfvf, struct xdp_frame *xdpf,
+			    u64 iova, int len, u16 qidx, u16 flags)
 {
 	struct nix_sqe_hdr_s *sqe_hdr;
 	struct otx2_snd_queue *sq;
@@ -1405,7 +1405,7 @@ bool otx2_xdp_sq_append_pkt(struct otx2_nic *pfvf, u64 iova, int len, u16 qidx)
 
 	offset = sizeof(*sqe_hdr);
 
-	otx2_xdp_sqe_add_sg(sq, iova, len, &offset);
+	otx2_xdp_sqe_add_sg(sq, xdpf, iova, len, &offset, flags);
 	sqe_hdr->sizem1 = (offset / 16) - 1;
 	pfvf->hw_ops->sqe_flush(pfvf, sq, offset, qidx);
 
@@ -1419,6 +1419,8 @@ static bool otx2_xdp_rcv_pkt_handler(struct otx2_nic *pfvf,
 				     bool *need_xdp_flush)
 {
 	unsigned char *hard_start;
+	struct otx2_pool *pool;
+	struct xdp_frame *xdpf;
 	int qidx = cq->cq_idx;
 	struct xdp_buff xdp;
 	struct page *page;
@@ -1426,6 +1428,7 @@ static bool otx2_xdp_rcv_pkt_handler(struct otx2_nic *pfvf,
 	u32 act;
 	int err;
 
+	pool = &pfvf->qset.pool[qidx];
 	iova = cqe->sg.seg_addr - OTX2_HEAD_ROOM;
 	pa = otx2_iova_to_phys(pfvf->iommu_domain, iova);
 	page = virt_to_page(phys_to_virt(pa));
@@ -1444,19 +1447,21 @@ static bool otx2_xdp_rcv_pkt_handler(struct otx2_nic *pfvf,
 	case XDP_TX:
 		qidx += pfvf->hw.tx_queues;
 		cq->pool_ptrs++;
-		return otx2_xdp_sq_append_pkt(pfvf, iova,
-					      cqe->sg.seg_size, qidx);
+		xdpf = xdp_convert_buff_to_frame(&xdp);
+		return otx2_xdp_sq_append_pkt(pfvf, xdpf, cqe->sg.seg_addr,
+					      cqe->sg.seg_size, qidx, XDP_TX);
 	case XDP_REDIRECT:
 		cq->pool_ptrs++;
 		err = xdp_do_redirect(pfvf->netdev, &xdp, prog);
-
-		otx2_dma_unmap_page(pfvf, iova, pfvf->rbsize,
-				    DMA_FROM_DEVICE);
 		if (!err) {
 			*need_xdp_flush = true;
 			return true;
 		}
-		put_page(page);
+
+		otx2_dma_unmap_page(pfvf, iova, pfvf->rbsize,
+				    DMA_FROM_DEVICE);
+		xdpf = xdp_convert_buff_to_frame(&xdp);
+		xdp_return_frame(xdpf);
 		break;
 	default:
 		bpf_warn_invalid_xdp_action(pfvf->netdev, prog, act);
@@ -1465,10 +1470,14 @@ static bool otx2_xdp_rcv_pkt_handler(struct otx2_nic *pfvf,
 		trace_xdp_exception(pfvf->netdev, prog, act);
 		break;
 	case XDP_DROP:
-		otx2_dma_unmap_page(pfvf, iova, pfvf->rbsize,
-				    DMA_FROM_DEVICE);
-		put_page(page);
 		cq->pool_ptrs++;
+		if (page->pp) {
+			page_pool_recycle_direct(pool->page_pool, page);
+		} else {
+			otx2_dma_unmap_page(pfvf, iova, pfvf->rbsize,
+					    DMA_FROM_DEVICE);
+			put_page(page);
+		}
 		return true;
 	}
 	return false;
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.h b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.h
index d23810963fdb..92e1e84cad75 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.h
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.h
@@ -76,6 +76,7 @@ struct otx2_rcv_queue {
 
 struct sg_list {
 	u16	num_segs;
+	u16	flags;
 	u64	skb;
 	u64	size[OTX2_MAX_FRAGS_IN_SQE];
 	u64	dma_addr[OTX2_MAX_FRAGS_IN_SQE];
-- 
2.25.1


