Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B644C41C077
	for <lists+bpf@lfdr.de>; Wed, 29 Sep 2021 10:17:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244559AbhI2ISq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 29 Sep 2021 04:18:46 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:16116 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S244545AbhI2ISq (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 29 Sep 2021 04:18:46 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18T7JwBN012573;
        Wed, 29 Sep 2021 01:16:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=pfpt0220;
 bh=NTEbjflctJRDbu56j8dUWep/v6RNdlCTa7AkW3Eo7qg=;
 b=OjV4WFwPesmpS2geZKCEWb687xxBXY8NOBC1K3fX7yM6fuWtC//pKXbDfl83xWsqz631
 FRm4gsLTfyhkEh8eYodEo2qBBMLecOiavPo5AOKio6xrH6j+wFAhOQu4UMjyzecNRE0c
 /mFfgeEjmKwL6anyKxTF5fMMe2l0P6sPusjOHtNt20LBecIbv5WPA9dl/mMP0wavQIfX
 hi4xrOaRyMRbI0fYVOQb7hLvsABFWYyAqGzDEKrkvQo0cL92VPyAjoz4QNDgQUlVOyEK
 gAzU/y6vvGlwVFIYOvc92fw27R3ZRiQ2TfU6ZqASGNOZesUGMKlMXYpZHvGp1HFq+lCM 1w== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0a-0016f401.pphosted.com with ESMTP id 3bcknk86n4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 29 Sep 2021 01:16:46 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 29 Sep
 2021 01:16:45 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Wed, 29 Sep 2021 01:16:45 -0700
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
        by maili.marvell.com (Postfix) with ESMTP id 054E93F706D;
        Wed, 29 Sep 2021 01:16:41 -0700 (PDT)
From:   Geetha sowjanya <gakula@marvell.com>
To:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <bpf@vger.kernel.org>
CC:     <kuba@kernel.org>, <davem@davemloft.net>, <sgoutham@marvell.com>,
        <gakula@marvell.com>, <hawk@kernel.org>, <ast@kernel.org>,
        <daniel@iogearbox.net>, <andrii@kernel.org>
Subject: [net-next PATCH] octeontx2-pf: Add XDP support to RVU netdev PF
Date:   Wed, 29 Sep 2021 13:46:40 +0530
Message-ID: <20210929081640.14763-1-gakula@marvell.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: e-Rq7TEz4aCoGgQiTZMWvRl2RfuqSC_8
X-Proofpoint-ORIG-GUID: e-Rq7TEz4aCoGgQiTZMWvRl2RfuqSC_8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-29_02,2021-09-28_01,2020-04-07_01
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch implements XDP_PASS, XDP_TX, XDP_DROP and XDP_REDIRECT
support for RVU netdev PF.

Signed-off-by: Geetha sowjanya <gakula@marvell.com>
Signed-off-by: Sunil Goutham <sgoutham@cavium.com>
---
 .../marvell/octeontx2/nic/otx2_common.c       |  35 ++--
 .../marvell/octeontx2/nic/otx2_common.h       |   4 +
 .../ethernet/marvell/octeontx2/nic/otx2_pf.c  | 135 +++++++++++++-
 .../marvell/octeontx2/nic/otx2_txrx.c         | 173 ++++++++++++++++--
 .../marvell/octeontx2/nic/otx2_txrx.h         |   7 +-
 .../ethernet/marvell/octeontx2/nic/otx2_vf.c  |   1 +
 6 files changed, 321 insertions(+), 34 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
index 4c3dbade8cfb..0aa88cea1676 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
@@ -718,7 +718,7 @@ void otx2_sqb_flush(struct otx2_nic *pfvf)
 	int timeout = 1000;
 
 	ptr = (u64 *)otx2_get_regaddr(pfvf, NIX_LF_SQ_OP_STATUS);
-	for (qidx = 0; qidx < pfvf->hw.tx_queues; qidx++) {
+	for (qidx = 0; qidx < pfvf->hw.tot_tx_queues; qidx++) {
 		incr = (u64)qidx << 32;
 		while (timeout) {
 			val = otx2_atomic64_add(incr, ptr);
@@ -835,17 +835,19 @@ static int otx2_sq_init(struct otx2_nic *pfvf, u16 qidx, u16 sqb_aura)
 	if (err)
 		return err;
 
-	err = qmem_alloc(pfvf->dev, &sq->tso_hdrs, qset->sqe_cnt,
-			 TSO_HEADER_SIZE);
-	if (err)
-		return err;
+	if (qidx < pfvf->hw.tx_queues) {
+		err = qmem_alloc(pfvf->dev, &sq->tso_hdrs, qset->sqe_cnt,
+				 TSO_HEADER_SIZE);
+		if (err)
+			return err;
+	}
 
 	sq->sqe_base = sq->sqe->base;
 	sq->sg = kcalloc(qset->sqe_cnt, sizeof(struct sg_list), GFP_KERNEL);
 	if (!sq->sg)
 		return -ENOMEM;
 
-	if (pfvf->ptp) {
+	if (pfvf->ptp && qidx < pfvf->hw.tx_queues) {
 		err = qmem_alloc(pfvf->dev, &sq->timestamps, qset->sqe_cnt,
 				 sizeof(*sq->timestamps));
 		if (err)
@@ -871,20 +873,27 @@ static int otx2_sq_init(struct otx2_nic *pfvf, u16 qidx, u16 sqb_aura)
 static int otx2_cq_init(struct otx2_nic *pfvf, u16 qidx)
 {
 	struct otx2_qset *qset = &pfvf->qset;
+	int err, pool_id, non_xdp_queues;
 	struct nix_aq_enq_req *aq;
 	struct otx2_cq_queue *cq;
-	int err, pool_id;
 
 	cq = &qset->cq[qidx];
 	cq->cq_idx = qidx;
+	non_xdp_queues = pfvf->hw.rx_queues + pfvf->hw.tx_queues;
 	if (qidx < pfvf->hw.rx_queues) {
 		cq->cq_type = CQ_RX;
 		cq->cint_idx = qidx;
 		cq->cqe_cnt = qset->rqe_cnt;
-	} else {
+		if (pfvf->xdp_prog)
+			xdp_rxq_info_reg(&cq->xdp_rxq, pfvf->netdev, qidx, 0);
+	} else if (qidx < non_xdp_queues) {
 		cq->cq_type = CQ_TX;
 		cq->cint_idx = qidx - pfvf->hw.rx_queues;
 		cq->cqe_cnt = qset->sqe_cnt;
+	} else {
+		cq->cq_type = CQ_XDP;
+		cq->cint_idx = qidx - non_xdp_queues;
+		cq->cqe_cnt = qset->sqe_cnt;
 	}
 	cq->cqe_size = pfvf->qset.xqe_size;
 
@@ -991,7 +1000,7 @@ int otx2_config_nix_queues(struct otx2_nic *pfvf)
 	}
 
 	/* Initialize TX queues */
-	for (qidx = 0; qidx < pfvf->hw.tx_queues; qidx++) {
+	for (qidx = 0; qidx < pfvf->hw.tot_tx_queues; qidx++) {
 		u16 sqb_aura = otx2_get_pool_idx(pfvf, AURA_NIX_SQ, qidx);
 
 		err = otx2_sq_init(pfvf, qidx, sqb_aura);
@@ -1038,7 +1047,7 @@ int otx2_config_nix(struct otx2_nic *pfvf)
 
 	/* Set RQ/SQ/CQ counts */
 	nixlf->rq_cnt = pfvf->hw.rx_queues;
-	nixlf->sq_cnt = pfvf->hw.tx_queues;
+	nixlf->sq_cnt = pfvf->hw.tot_tx_queues;
 	nixlf->cq_cnt = pfvf->qset.cq_cnt;
 	nixlf->rss_sz = MAX_RSS_INDIR_TBL_SIZE;
 	nixlf->rss_grps = MAX_RSS_GROUPS;
@@ -1076,7 +1085,7 @@ void otx2_sq_free_sqbs(struct otx2_nic *pfvf)
 	int sqb, qidx;
 	u64 iova, pa;
 
-	for (qidx = 0; qidx < hw->tx_queues; qidx++) {
+	for (qidx = 0; qidx < hw->tot_tx_queues; qidx++) {
 		sq = &qset->sq[qidx];
 		if (!sq->sqb_ptrs)
 			continue;
@@ -1288,7 +1297,7 @@ int otx2_sq_aura_pool_init(struct otx2_nic *pfvf)
 	stack_pages =
 		(num_sqbs + hw->stack_pg_ptrs - 1) / hw->stack_pg_ptrs;
 
-	for (qidx = 0; qidx < hw->tx_queues; qidx++) {
+	for (qidx = 0; qidx < hw->tot_tx_queues; qidx++) {
 		pool_id = otx2_get_pool_idx(pfvf, AURA_NIX_SQ, qidx);
 		/* Initialize aura context */
 		err = otx2_aura_init(pfvf, pool_id, pool_id, num_sqbs);
@@ -1308,7 +1317,7 @@ int otx2_sq_aura_pool_init(struct otx2_nic *pfvf)
 		goto fail;
 
 	/* Allocate pointers and free them to aura/pool */
-	for (qidx = 0; qidx < hw->tx_queues; qidx++) {
+	for (qidx = 0; qidx < hw->tot_tx_queues; qidx++) {
 		pool_id = otx2_get_pool_idx(pfvf, AURA_NIX_SQ, qidx);
 		pool = &pfvf->qset.pool[pool_id];
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
index 069d1b925102..184b4f893856 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
@@ -171,6 +171,8 @@ struct otx2_hw {
 	struct otx2_rss_info	rss_info;
 	u16                     rx_queues;
 	u16                     tx_queues;
+	u16                     xdp_queues;
+	u16                     tot_tx_queues;
 	u16			max_queues;
 	u16			pool_cnt;
 	u16			rqpool_cnt;
@@ -345,6 +347,7 @@ struct otx2_nic {
 	u64			flags;
 	u64			*cq_op_addr;
 
+	struct bpf_prog		*xdp_prog;
 	struct otx2_qset	qset;
 	struct otx2_hw		hw;
 	struct pci_dev		*pdev;
@@ -854,6 +857,7 @@ int otx2_del_macfilter(struct net_device *netdev, const u8 *mac);
 int otx2_add_macfilter(struct net_device *netdev, const u8 *mac);
 int otx2_enable_rxvlan(struct otx2_nic *pf, bool enable);
 int otx2_install_rxvlan_offload_flow(struct otx2_nic *pfvf);
+bool otx2_xdp_sq_append_pkt(struct otx2_nic *pfvf, u64 iova, int len, u16 qidx);
 u16 otx2_get_max_mtu(struct otx2_nic *pfvf);
 /* tc support */
 int otx2_init_tc(struct otx2_nic *nic);
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
index 53df7fff92c4..4d0c085dae0c 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
@@ -13,6 +13,8 @@
 #include <linux/if_vlan.h>
 #include <linux/iommu.h>
 #include <net/ip.h>
+#include <linux/bpf.h>
+#include <linux/bpf_trace.h>
 
 #include "otx2_reg.h"
 #include "otx2_common.h"
@@ -48,9 +50,15 @@ static int otx2_config_hw_rx_tstamp(struct otx2_nic *pfvf, bool enable);
 
 static int otx2_change_mtu(struct net_device *netdev, int new_mtu)
 {
+	struct otx2_nic *pf = netdev_priv(netdev);
 	bool if_up = netif_running(netdev);
 	int err = 0;
 
+	if (pf->xdp_prog && new_mtu > MAX_XDP_MTU) {
+		netdev_warn(netdev, "Jumbo frames not yet supported with XDP, current MTU %d.\n",
+			    netdev->mtu);
+		return -EINVAL;
+	}
 	if (if_up)
 		otx2_stop(netdev);
 
@@ -1180,7 +1188,7 @@ static irqreturn_t otx2_q_intr_handler(int irq, void *data)
 	}
 
 	/* SQ */
-	for (qidx = 0; qidx < pf->hw.tx_queues; qidx++) {
+	for (qidx = 0; qidx < pf->hw.tot_tx_queues; qidx++) {
 		ptr = otx2_get_regaddr(pf, NIX_LF_SQ_OP_INT);
 		val = otx2_atomic64_add((qidx << 44), ptr);
 		otx2_write64(pf, NIX_LF_SQ_OP_INT, (qidx << 44) |
@@ -1283,7 +1291,7 @@ static void otx2_free_sq_res(struct otx2_nic *pf)
 	otx2_ctx_disable(&pf->mbox, NIX_AQ_CTYPE_SQ, false);
 	/* Free SQB pointers */
 	otx2_sq_free_sqbs(pf);
-	for (qidx = 0; qidx < pf->hw.tx_queues; qidx++) {
+	for (qidx = 0; qidx < pf->hw.tot_tx_queues; qidx++) {
 		sq = &qset->sq[qidx];
 		qmem_free(pf->dev, sq->sqe);
 		qmem_free(pf->dev, sq->tso_hdrs);
@@ -1332,7 +1340,7 @@ static int otx2_init_hw_resources(struct otx2_nic *pf)
 	 * so, aura count = pool count.
 	 */
 	hw->rqpool_cnt = hw->rx_queues;
-	hw->sqpool_cnt = hw->tx_queues;
+	hw->sqpool_cnt = hw->tot_tx_queues;
 	hw->pool_cnt = hw->rqpool_cnt + hw->sqpool_cnt;
 
 	pf->max_frs = pf->netdev->mtu + OTX2_ETH_HLEN + OTX2_HW_TIMESTAMP_LEN;
@@ -1503,7 +1511,7 @@ int otx2_open(struct net_device *netdev)
 
 	netif_carrier_off(netdev);
 
-	pf->qset.cq_cnt = pf->hw.rx_queues + pf->hw.tx_queues;
+	pf->qset.cq_cnt = pf->hw.rx_queues + pf->hw.tot_tx_queues;
 	/* RQ and SQs are mapped to different CQs,
 	 * so find out max CQ IRQs (i.e CINTs) needed.
 	 */
@@ -1523,7 +1531,7 @@ int otx2_open(struct net_device *netdev)
 	if (!qset->cq)
 		goto err_free_mem;
 
-	qset->sq = kcalloc(pf->hw.tx_queues,
+	qset->sq = kcalloc(pf->hw.tot_tx_queues,
 			   sizeof(struct otx2_snd_queue), GFP_KERNEL);
 	if (!qset->sq)
 		goto err_free_mem;
@@ -1544,11 +1552,20 @@ int otx2_open(struct net_device *netdev)
 		/* RQ0 & SQ0 are mapped to CINT0 and so on..
 		 * 'cq_ids[0]' points to RQ's CQ and
 		 * 'cq_ids[1]' points to SQ's CQ and
+		 * 'cq_ids[2]' points to XDP's CQ and
 		 */
 		cq_poll->cq_ids[CQ_RX] =
 			(qidx <  pf->hw.rx_queues) ? qidx : CINT_INVALID_CQ;
 		cq_poll->cq_ids[CQ_TX] = (qidx < pf->hw.tx_queues) ?
 				      qidx + pf->hw.rx_queues : CINT_INVALID_CQ;
+		if (pf->xdp_prog)
+			cq_poll->cq_ids[CQ_XDP] = (qidx < pf->hw.xdp_queues) ?
+						  (qidx + pf->hw.rx_queues +
+						  pf->hw.tx_queues) :
+						  CINT_INVALID_CQ;
+		else
+			cq_poll->cq_ids[CQ_XDP] = CINT_INVALID_CQ;
+
 		cq_poll->dev = (void *)pf;
 		netif_napi_add(netdev, &cq_poll->napi,
 			       otx2_napi_handler, NAPI_POLL_WEIGHT);
@@ -2281,6 +2298,111 @@ static int otx2_get_vf_config(struct net_device *netdev, int vf,
 	return 0;
 }
 
+static int otx2_xdp_xmit_tx(struct otx2_nic *pf, struct xdp_frame *xdpf,
+			    int qidx)
+{
+	struct page *page;
+	u64 dma_addr;
+	int err = 0;
+
+	dma_addr = otx2_dma_map_page(pf, virt_to_page(xdpf->data),
+				     offset_in_page(xdpf->data), xdpf->len,
+				     DMA_TO_DEVICE);
+	if (dma_mapping_error(pf->dev, dma_addr))
+		return -ENOMEM;
+
+	err = otx2_xdp_sq_append_pkt(pf, dma_addr, xdpf->len, qidx);
+	if (!err) {
+		otx2_dma_unmap_page(pf, dma_addr, xdpf->len, DMA_TO_DEVICE);
+		page = virt_to_page(xdpf->data);
+		put_page(page);
+		return -ENOMEM;
+	}
+	return 0;
+}
+
+static int otx2_xdp_xmit(struct net_device *netdev, int n,
+			 struct xdp_frame **frames, u32 flags)
+{
+	struct otx2_nic *pf = netdev_priv(netdev);
+	int qidx = smp_processor_id();
+	struct otx2_snd_queue *sq;
+	int drops = 0, i;
+
+	if (!netif_running(netdev))
+		return -ENETDOWN;
+
+	qidx += pf->hw.tx_queues;
+	sq = pf->xdp_prog ? &pf->qset.sq[qidx] : NULL;
+
+	/* Abort xmit if xdp queue is not */
+	if (unlikely(!sq))
+		return -ENXIO;
+
+	if (unlikely(flags & ~XDP_XMIT_FLAGS_MASK))
+		return -EINVAL;
+
+	for (i = 0; i < n; i++) {
+		struct xdp_frame *xdpf = frames[i];
+		int err;
+
+		err = otx2_xdp_xmit_tx(pf, xdpf, qidx);
+		if (err)
+			drops++;
+	}
+	return n - drops;
+}
+
+static int otx2_xdp_setup(struct otx2_nic *pf, struct bpf_prog *prog)
+{
+	struct net_device *dev = pf->netdev;
+	bool if_up = netif_running(pf->netdev);
+	struct bpf_prog *old_prog;
+
+	if (prog && dev->mtu > MAX_XDP_MTU) {
+		netdev_warn(dev, "Jumbo frames not yet supported with XDP\n");
+		return -EOPNOTSUPP;
+	}
+
+	if (if_up)
+		otx2_stop(pf->netdev);
+
+	old_prog = xchg(&pf->xdp_prog, prog);
+
+	if (old_prog)
+		bpf_prog_put(old_prog);
+
+	if (pf->xdp_prog)
+		bpf_prog_add(pf->xdp_prog, pf->hw.rx_queues - 1);
+
+	/* Network stack and XDP shared same rx queues.
+	 * Use separate tx queues for XDP and network stack.
+	 */
+	if (pf->xdp_prog)
+		pf->hw.xdp_queues = pf->hw.rx_queues;
+	else
+		pf->hw.xdp_queues = 0;
+
+	pf->hw.tot_tx_queues += pf->hw.xdp_queues;
+
+	if (if_up)
+		otx2_open(pf->netdev);
+
+	return 0;
+}
+
+static int otx2_xdp(struct net_device *netdev, struct netdev_bpf *xdp)
+{
+	struct otx2_nic *pf = netdev_priv(netdev);
+
+	switch (xdp->command) {
+	case XDP_SETUP_PROG:
+		return otx2_xdp_setup(pf, xdp->prog);
+	default:
+		return -EINVAL;
+	}
+}
+
 static int otx2_set_vf_permissions(struct otx2_nic *pf, int vf,
 				   int req_perm)
 {
@@ -2348,6 +2470,8 @@ static const struct net_device_ops otx2_netdev_ops = {
 	.ndo_set_vf_mac		= otx2_set_vf_mac,
 	.ndo_set_vf_vlan	= otx2_set_vf_vlan,
 	.ndo_get_vf_config	= otx2_get_vf_config,
+	.ndo_bpf		= otx2_xdp,
+	.ndo_xdp_xmit           = otx2_xdp_xmit,
 	.ndo_setup_tc		= otx2_setup_tc,
 	.ndo_set_vf_trust	= otx2_ndo_set_vf_trust,
 };
@@ -2489,6 +2613,7 @@ static int otx2_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	hw->pdev = pdev;
 	hw->rx_queues = qcount;
 	hw->tx_queues = qcount;
+	hw->tot_tx_queues = qcount;
 	hw->max_queues = qcount;
 
 	num_vec = pci_msix_vec_count(pdev);
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
index 3f3ec8ffc4dd..4c701659d43d 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
@@ -8,6 +8,8 @@
 #include <linux/etherdevice.h>
 #include <net/ip.h>
 #include <net/tso.h>
+#include <linux/bpf.h>
+#include <linux/bpf_trace.h>
 
 #include "otx2_reg.h"
 #include "otx2_common.h"
@@ -17,6 +19,10 @@
 #include "cn10k.h"
 
 #define CQE_ADDR(CQ, idx) ((CQ)->cqe_base + ((CQ)->cqe_size * (idx)))
+static bool otx2_xdp_rcv_pkt_handler(struct otx2_nic *pfvf,
+				     struct bpf_prog *prog,
+				     struct nix_cqe_rx_s *cqe,
+				     struct otx2_cq_queue *cq);
 
 static int otx2_nix_cq_op_status(struct otx2_nic *pfvf,
 				 struct otx2_cq_queue *cq)
@@ -98,6 +104,24 @@ static void otx2_dma_unmap_skb_frags(struct otx2_nic *pfvf, struct sg_list *sg)
 	sg->num_segs = 0;
 }
 
+static void otx2_xdp_snd_pkt_handler(struct otx2_nic *pfvf,
+				     struct otx2_snd_queue *sq,
+				 struct nix_cqe_tx_s *cqe)
+{
+	struct nix_send_comp_s *snd_comp = &cqe->comp;
+	struct sg_list *sg;
+	struct page *page;
+	u64 pa;
+
+	sg = &sq->sg[snd_comp->sqe_id];
+
+	pa = otx2_iova_to_phys(pfvf->iommu_domain, sg->dma_addr[0]);
+	otx2_dma_unmap_page(pfvf, sg->dma_addr[0],
+			    sg->size[0], DMA_TO_DEVICE);
+	page = virt_to_page(phys_to_virt(pa));
+	put_page(page);
+}
+
 static void otx2_snd_pkt_handler(struct otx2_nic *pfvf,
 				 struct otx2_cq_queue *cq,
 				 struct otx2_snd_queue *sq,
@@ -310,6 +334,10 @@ static void otx2_rcv_pkt_handler(struct otx2_nic *pfvf,
 			return;
 	}
 
+	if (pfvf->xdp_prog)
+		if (otx2_xdp_rcv_pkt_handler(pfvf, pfvf->xdp_prog, cqe, cq))
+			return;
+
 	skb = napi_get_frags(napi);
 	if (unlikely(!skb))
 		return;
@@ -373,11 +401,6 @@ static int otx2_rx_napi_handler(struct otx2_nic *pfvf,
 	otx2_write64(pfvf, NIX_LF_CQ_OP_DOOR,
 		     ((u64)cq->cq_idx << 32) | processed_cqe);
 
-	if (unlikely(!cq->pool_ptrs))
-		return 0;
-	/* Refill pool with new buffers */
-	pfvf->hw_ops->refill_pool_ptrs(pfvf, cq);
-
 	return processed_cqe;
 }
 
@@ -397,7 +420,7 @@ void otx2_refill_pool_ptrs(void *dev, struct otx2_cq_queue *cq)
 static int otx2_tx_napi_handler(struct otx2_nic *pfvf,
 				struct otx2_cq_queue *cq, int budget)
 {
-	int tx_pkts = 0, tx_bytes = 0;
+	int tx_pkts = 0, tx_bytes = 0, qidx;
 	struct nix_cqe_tx_s *cqe;
 	int processed_cqe = 0;
 
@@ -415,9 +438,15 @@ static int otx2_tx_napi_handler(struct otx2_nic *pfvf,
 				return 0;
 			break;
 		}
-		otx2_snd_pkt_handler(pfvf, cq, &pfvf->qset.sq[cq->cint_idx],
-				     cqe, budget, &tx_pkts, &tx_bytes);
-
+		if (cq->cq_type == CQ_XDP) {
+			qidx = cq->cq_idx - pfvf->hw.rx_queues;
+			otx2_xdp_snd_pkt_handler(pfvf, &pfvf->qset.sq[qidx],
+						 cqe);
+		} else {
+			otx2_snd_pkt_handler(pfvf, cq,
+					     &pfvf->qset.sq[cq->cint_idx],
+					     cqe, budget, &tx_pkts, &tx_bytes);
+		}
 		cqe->hdr.cqe_type = NIX_XQE_TYPE_INVALID;
 		processed_cqe++;
 		cq->pend_cqe--;
@@ -443,6 +472,7 @@ static int otx2_tx_napi_handler(struct otx2_nic *pfvf,
 
 int otx2_napi_handler(struct napi_struct *napi, int budget)
 {
+	struct otx2_cq_queue *rx_cq = NULL;
 	struct otx2_cq_poll *cq_poll;
 	int workdone = 0, cq_idx, i;
 	struct otx2_cq_queue *cq;
@@ -453,17 +483,13 @@ int otx2_napi_handler(struct napi_struct *napi, int budget)
 	pfvf = (struct otx2_nic *)cq_poll->dev;
 	qset = &pfvf->qset;
 
-	for (i = CQS_PER_CINT - 1; i >= 0; i--) {
+	for (i = 0; i < CQS_PER_CINT; i++) {
 		cq_idx = cq_poll->cq_ids[i];
 		if (unlikely(cq_idx == CINT_INVALID_CQ))
 			continue;
 		cq = &qset->cq[cq_idx];
 		if (cq->cq_type == CQ_RX) {
-			/* If the RQ refill WQ task is running, skip napi
-			 * scheduler for this queue.
-			 */
-			if (cq->refill_task_sched)
-				continue;
+			rx_cq = cq;
 			workdone += otx2_rx_napi_handler(pfvf, napi,
 							 cq, budget);
 		} else {
@@ -471,6 +497,8 @@ int otx2_napi_handler(struct napi_struct *napi, int budget)
 		}
 	}
 
+	if (rx_cq && rx_cq->pool_ptrs)
+		pfvf->hw_ops->refill_pool_ptrs(pfvf, rx_cq);
 	/* Clear the IRQ */
 	otx2_write64(pfvf, NIX_LF_CINTX_INT(cq_poll->cint_idx), BIT_ULL(0));
 
@@ -977,6 +1005,9 @@ void otx2_cleanup_rx_cqes(struct otx2_nic *pfvf, struct otx2_cq_queue *cq)
 	int processed_cqe = 0;
 	u64 iova, pa;
 
+	if (pfvf->xdp_prog)
+		xdp_rxq_info_unreg(&cq->xdp_rxq);
+
 	if (otx2_nix_cq_op_status(pfvf, cq) || !cq->pend_cqe)
 		return;
 
@@ -1056,3 +1087,115 @@ int otx2_rxtx_enable(struct otx2_nic *pfvf, bool enable)
 	mutex_unlock(&pfvf->mbox.lock);
 	return err;
 }
+
+static inline void otx2_xdp_sqe_add_sg(struct otx2_snd_queue *sq, u64 dma_addr,
+				       int len, int *offset)
+{
+	struct nix_sqe_sg_s *sg = NULL;
+	u64 *iova = NULL;
+
+	sg = (struct nix_sqe_sg_s *)(sq->sqe_base + *offset);
+	sg->ld_type = NIX_SEND_LDTYPE_LDD;
+	sg->subdc = NIX_SUBDC_SG;
+	sg->segs = 1;
+	sg->seg1_size = len;
+	iova = (void *)sg + sizeof(*sg);
+	*iova = dma_addr;
+	*offset += sizeof(*sg) + sizeof(u64);
+
+	sq->sg[sq->head].dma_addr[0] = dma_addr;
+	sq->sg[sq->head].size[0] = len;
+	sq->sg[sq->head].num_segs = 1;
+}
+
+bool otx2_xdp_sq_append_pkt(struct otx2_nic *pfvf, u64 iova, int len, u16 qidx)
+{
+	struct nix_sqe_hdr_s *sqe_hdr;
+	struct otx2_snd_queue *sq;
+	int offset, free_sqe;
+
+	sq = &pfvf->qset.sq[qidx];
+	free_sqe = (sq->num_sqbs - *sq->aura_fc_addr) * sq->sqe_per_sqb;
+	if (free_sqe < sq->sqe_thresh)
+		return false;
+
+	memset(sq->sqe_base + 8, 0, sq->sqe_size - 8);
+
+	sqe_hdr = (struct nix_sqe_hdr_s *)(sq->sqe_base);
+
+	if (!sqe_hdr->total) {
+		sqe_hdr->aura = sq->aura_id;
+		sqe_hdr->df = 1;
+		sqe_hdr->sq = qidx;
+		sqe_hdr->pnc = 1;
+	}
+	sqe_hdr->total = len;
+	sqe_hdr->sqe_id = sq->head;
+
+	offset = sizeof(*sqe_hdr);
+
+	otx2_xdp_sqe_add_sg(sq, iova, len, &offset);
+	sqe_hdr->sizem1 = (offset / 16) - 1;
+	pfvf->hw_ops->sqe_flush(pfvf, sq, offset, qidx);
+
+	return true;
+}
+
+static bool otx2_xdp_rcv_pkt_handler(struct otx2_nic *pfvf,
+				     struct bpf_prog *prog,
+				     struct nix_cqe_rx_s *cqe,
+				     struct otx2_cq_queue *cq)
+{
+	unsigned char *hard_start, *data;
+	int qidx = cq->cq_idx;
+	struct xdp_buff xdp;
+	struct page *page;
+	u64 iova, pa;
+	u32 act;
+	int err;
+
+	iova = cqe->sg.seg_addr - OTX2_HEAD_ROOM;
+	pa = otx2_iova_to_phys(pfvf->iommu_domain, iova);
+	page = virt_to_page(phys_to_virt(pa));
+
+	xdp_init_buff(&xdp, pfvf->rbsize, &cq->xdp_rxq);
+
+	data = (unsigned char *)phys_to_virt(pa);
+	hard_start = page_address(page);
+	xdp_prepare_buff(&xdp, hard_start, data - hard_start, cqe->sg.seg_size, false);
+
+	act = bpf_prog_run_xdp(prog, &xdp);
+
+	switch (act) {
+	case XDP_PASS:
+		break;
+	case XDP_TX:
+		qidx += pfvf->hw.tx_queues;
+		cq->pool_ptrs++;
+		return otx2_xdp_sq_append_pkt(pfvf, iova,
+					      cqe->sg.seg_size, qidx);
+	case XDP_REDIRECT:
+		cq->pool_ptrs++;
+		err = xdp_do_redirect(pfvf->netdev, &xdp, prog);
+
+		otx2_dma_unmap_page(pfvf, iova, pfvf->rbsize,
+				    DMA_FROM_DEVICE);
+		if (!err)
+			return true;
+		put_page(page);
+		break;
+	default:
+		bpf_warn_invalid_xdp_action(act);
+		break;
+	case XDP_ABORTED:
+		trace_xdp_exception(pfvf->netdev, prog, act);
+		break;
+	case XDP_DROP:
+		otx2_dma_unmap_page(pfvf, iova, pfvf->rbsize,
+				    DMA_FROM_DEVICE);
+		put_page(page);
+		cq->pool_ptrs++;
+		return true;
+	}
+	return false;
+}
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.h b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.h
index 6a97631ff226..5c05774a8d05 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.h
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.h
@@ -11,6 +11,7 @@
 #include <linux/etherdevice.h>
 #include <linux/iommu.h>
 #include <linux/if_vlan.h>
+#include <net/xdp.h>
 
 #define LBK_CHAN_BASE	0x000
 #define SDP_CHAN_BASE	0x700
@@ -25,6 +26,8 @@
 #define OTX2_MAX_GSO_SEGS	255
 #define OTX2_MAX_FRAGS_IN_SQE	9
 
+#define MAX_XDP_MTU	(1530 - OTX2_ETH_HLEN)
+
 /* Rx buffer size should be in multiples of 128bytes */
 #define RCV_FRAG_LEN1(x)				\
 		((OTX2_HEAD_ROOM + OTX2_DATA_ALIGN(x)) + \
@@ -99,7 +102,8 @@ struct otx2_snd_queue {
 enum cq_type {
 	CQ_RX,
 	CQ_TX,
-	CQS_PER_CINT = 2, /* RQ + SQ */
+	CQ_XDP,
+	CQS_PER_CINT = 3, /* RQ + SQ + XDP */
 };
 
 struct otx2_cq_poll {
@@ -130,6 +134,7 @@ struct otx2_cq_queue {
 	void			*cqe_base;
 	struct qmem		*cqe;
 	struct otx2_pool	*rbpool;
+	struct xdp_rxq_info xdp_rxq;
 } ____cacheline_aligned_in_smp;
 
 struct otx2_qset {
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
index 03b4ec630432..05d6fb3c010a 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
@@ -583,6 +583,7 @@ static int otx2vf_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	hw->rx_queues = qcount;
 	hw->tx_queues = qcount;
 	hw->max_queues = qcount;
+	hw->tot_tx_queues = qcount;
 
 	hw->irq_name = devm_kmalloc_array(&hw->pdev->dev, num_vec, NAME_SIZE,
 					  GFP_KERNEL);
-- 
2.17.1

