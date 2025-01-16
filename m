Return-Path: <bpf+bounces-49078-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C593A14207
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2025 20:12:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC2901886225
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2025 19:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 295B8236A80;
	Thu, 16 Jan 2025 19:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="MoslGIbN"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB259230272;
	Thu, 16 Jan 2025 19:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737054722; cv=none; b=FOL+zAXOtVFr9vOJxTIlAuRWP/0QQuWO6PAylPdxqleEPCl6WNr49mzqiZ192crr5Q0anzD5t6NhJnd2TegRl6eVFKuRhl2pkolEAOPzya2JeA0DwLQKUkOGmMcx8LEgWpR9jBnJN4BFHC1TtraTsl+AkZmV+3M64S73WqUux2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737054722; c=relaxed/simple;
	bh=Zhn1ektRcJ0SDAtWz6IKKLw/vFj4wN4Ji4g2bIyniMg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XP/agyNMUTG9VEIa0TD8qCyk5lmS+aop3fcahd+2MpPlDsjDiTKw2ysW2saQ0SgpoV4+ZpeYYaCHDTMBO0XvjBaDZAs5hI2pD1MK4OGFlXDQy7NQNqh4CvUPoUTIPRx+WlFiCGhFg2MxvUaHWvlDor7KQwl3lvlYlgHN8WwVRdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=MoslGIbN; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50GGAduC031003;
	Thu, 16 Jan 2025 11:11:37 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=R
	o55BtGF4WkBLxovpcgd8blRTz9k+QWA/Johj1i53wc=; b=MoslGIbNNMM43MtRX
	yZzt9VUJ9rH0CMS0RAtK5Co/rUZ6mrIK2GSYPiOzTwKlWO89WneLaGaD6Q1rtBe8
	P4kuMNOtCJU4Pf2ykbjanMoTk6yPDhJt3p8cJIZfNmHe626Warwx4ZvOodTwlc+h
	nqGuppTf8ChFG/RBJLw55wMZmT+jTDhCiv2BpptrKFit8QYiJnhjt/2XKsyXmBB8
	hOGv/Z495UZUbKGvxukonu9n7nJITDYkIc+hso9iKstQNOGY5z5B03PEC+UzbmQT
	ngfAr9trp0iBUX8Slme3GeQu1t/aZH31BefnYg8eG5A5Jyi7SoSb8i0g1ash1ZSG
	qKQgw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4475dd0dyb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jan 2025 11:11:37 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 16 Jan 2025 11:11:31 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 16 Jan 2025 11:11:31 -0800
Received: from localhost.localdomain (unknown [10.28.36.166])
	by maili.marvell.com (Postfix) with ESMTP id 0DA3B3F708E;
	Thu, 16 Jan 2025 11:11:25 -0800 (PST)
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
Subject: [net-next PATCH v4 1/6] octeontx2-pf: Don't unmap page pool buffer
Date: Fri, 17 Jan 2025 00:41:11 +0530
Message-ID: <20250116191116.3357181-2-sumang@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250116191116.3357181-1-sumang@marvell.com>
References: <20250116191116.3357181-1-sumang@marvell.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: aHrE8Z0UczECRshlK_q6Ojse7Vxr4DhV
X-Proofpoint-ORIG-GUID: aHrE8Z0UczECRshlK_q6Ojse7Vxr4DhV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-16_08,2025-01-16_01,2024-11-22_01

When xdp buffers are from page pool do not dma unmap
the buffers. DMA map/unmap are handled by the page_pool
APIs.

Signed-off-by: Geetha sowjanya <gakula@marvell.com>
Signed-off-by: Suman Ghosh <sumang@marvell.com>
---
 .../marvell/octeontx2/nic/otx2_common.h       |  4 +-
 .../ethernet/marvell/octeontx2/nic/otx2_pf.c  |  8 +++-
 .../marvell/octeontx2/nic/otx2_txrx.c         | 43 +++++++++++++------
 .../marvell/octeontx2/nic/otx2_txrx.h         |  1 +
 4 files changed, 41 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
index 65814e3dc93f..951fdf6bc2c4 100644
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
+bool otx2_xdp_sq_append_pkt(struct otx2_nic *pfvf, u64 iova, int len,
+			    u16 qidx, u16 flags);
 u16 otx2_get_max_mtu(struct otx2_nic *pfvf);
 int otx2_handle_ntuple_tc_features(struct net_device *netdev,
 				   netdev_features_t features);
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
index e1dde93e8af8..8ba44164736a 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
@@ -2701,11 +2701,15 @@ static int otx2_xdp_xmit_tx(struct otx2_nic *pf, struct xdp_frame *xdpf,
 	if (dma_mapping_error(pf->dev, dma_addr))
 		return -ENOMEM;
 
-	err = otx2_xdp_sq_append_pkt(pf, dma_addr, xdpf->len, qidx);
+	err = otx2_xdp_sq_append_pkt(pf, dma_addr, xdpf->len,
+				     qidx, XDP_REDIRECT);
 	if (!err) {
 		otx2_dma_unmap_page(pf, dma_addr, xdpf->len, DMA_TO_DEVICE);
 		page = virt_to_page(xdpf->data);
-		put_page(page);
+		if (page->pp)
+			page_pool_recycle_direct(page->pp, page);
+		else
+			put_page(page);
 		return -ENOMEM;
 	}
 	return 0;
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
index 224cef938927..2859f397f99e 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
@@ -101,14 +101,20 @@ static void otx2_xdp_snd_pkt_handler(struct otx2_nic *pfvf,
 	struct nix_send_comp_s *snd_comp = &cqe->comp;
 	struct sg_list *sg;
 	struct page *page;
-	u64 pa;
+	u64 pa, iova;
 
 	sg = &sq->sg[snd_comp->sqe_id];
 
-	pa = otx2_iova_to_phys(pfvf->iommu_domain, sg->dma_addr[0]);
-	otx2_dma_unmap_page(pfvf, sg->dma_addr[0],
-			    sg->size[0], DMA_TO_DEVICE);
+	iova = sg->dma_addr[0] - OTX2_HEAD_ROOM;
+	pa = otx2_iova_to_phys(pfvf->iommu_domain, iova);
 	page = virt_to_page(phys_to_virt(pa));
+	if (sg->flags & XDP_REDIRECT)
+		otx2_dma_unmap_page(pfvf, sg->dma_addr[0], sg->size[0], DMA_TO_DEVICE);
+
+	if (page->pp) {
+		page_pool_recycle_direct(page->pp, page);
+		return;
+	}
 	put_page(page);
 }
 
@@ -1360,7 +1366,7 @@ void otx2_free_pending_sqe(struct otx2_nic *pfvf)
 }
 
 static void otx2_xdp_sqe_add_sg(struct otx2_snd_queue *sq, u64 dma_addr,
-				int len, int *offset)
+				int len, int *offset, u16 flags)
 {
 	struct nix_sqe_sg_s *sg = NULL;
 	u64 *iova = NULL;
@@ -1377,9 +1383,11 @@ static void otx2_xdp_sqe_add_sg(struct otx2_snd_queue *sq, u64 dma_addr,
 	sq->sg[sq->head].dma_addr[0] = dma_addr;
 	sq->sg[sq->head].size[0] = len;
 	sq->sg[sq->head].num_segs = 1;
+	sq->sg[sq->head].flags = flags;
 }
 
-bool otx2_xdp_sq_append_pkt(struct otx2_nic *pfvf, u64 iova, int len, u16 qidx)
+bool otx2_xdp_sq_append_pkt(struct otx2_nic *pfvf, u64 iova, int len,
+			    u16 qidx, u16 flags)
 {
 	struct nix_sqe_hdr_s *sqe_hdr;
 	struct otx2_snd_queue *sq;
@@ -1405,7 +1413,7 @@ bool otx2_xdp_sq_append_pkt(struct otx2_nic *pfvf, u64 iova, int len, u16 qidx)
 
 	offset = sizeof(*sqe_hdr);
 
-	otx2_xdp_sqe_add_sg(sq, iova, len, &offset);
+	otx2_xdp_sqe_add_sg(sq, iova, len, &offset, flags);
 	sqe_hdr->sizem1 = (offset / 16) - 1;
 	pfvf->hw_ops->sqe_flush(pfvf, sq, offset, qidx);
 
@@ -1419,6 +1427,7 @@ static bool otx2_xdp_rcv_pkt_handler(struct otx2_nic *pfvf,
 				     bool *need_xdp_flush)
 {
 	unsigned char *hard_start;
+	struct otx2_pool *pool;
 	int qidx = cq->cq_idx;
 	struct xdp_buff xdp;
 	struct page *page;
@@ -1426,6 +1435,7 @@ static bool otx2_xdp_rcv_pkt_handler(struct otx2_nic *pfvf,
 	u32 act;
 	int err;
 
+	pool = &pfvf->qset.pool[qidx];
 	iova = cqe->sg.seg_addr - OTX2_HEAD_ROOM;
 	pa = otx2_iova_to_phys(pfvf->iommu_domain, iova);
 	page = virt_to_page(phys_to_virt(pa));
@@ -1444,18 +1454,23 @@ static bool otx2_xdp_rcv_pkt_handler(struct otx2_nic *pfvf,
 	case XDP_TX:
 		qidx += pfvf->hw.tx_queues;
 		cq->pool_ptrs++;
-		return otx2_xdp_sq_append_pkt(pfvf, iova,
-					      cqe->sg.seg_size, qidx);
+		return otx2_xdp_sq_append_pkt(pfvf, cqe->sg.seg_addr,
+					      cqe->sg.seg_size, qidx, XDP_TX);
 	case XDP_REDIRECT:
 		cq->pool_ptrs++;
 		err = xdp_do_redirect(pfvf->netdev, &xdp, prog);
 
-		otx2_dma_unmap_page(pfvf, iova, pfvf->rbsize,
-				    DMA_FROM_DEVICE);
 		if (!err) {
 			*need_xdp_flush = true;
 			return true;
 		}
+		if (page->pp) {
+			page_pool_recycle_direct(pool->page_pool, page);
+			return false;
+		}
+
+		otx2_dma_unmap_page(pfvf, iova, pfvf->rbsize,
+				    DMA_FROM_DEVICE);
 		put_page(page);
 		break;
 	default:
@@ -1465,10 +1480,14 @@ static bool otx2_xdp_rcv_pkt_handler(struct otx2_nic *pfvf,
 		trace_xdp_exception(pfvf->netdev, prog, act);
 		break;
 	case XDP_DROP:
+		cq->pool_ptrs++;
+		if (page->pp) {
+			page_pool_recycle_direct(pool->page_pool, page);
+			return true;
+		}
 		otx2_dma_unmap_page(pfvf, iova, pfvf->rbsize,
 				    DMA_FROM_DEVICE);
 		put_page(page);
-		cq->pool_ptrs++;
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


