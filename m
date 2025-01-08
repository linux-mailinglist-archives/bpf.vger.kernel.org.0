Return-Path: <bpf+bounces-48281-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2C96A06469
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2025 19:31:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3FD916740F
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2025 18:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10DDA20103D;
	Wed,  8 Jan 2025 18:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="HAchgfYh"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD7C200BBE;
	Wed,  8 Jan 2025 18:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736361050; cv=none; b=c76oyGzc0Q1cm6579MnkKConpAcvAnWmIDZ4tZhxbxq6OA9Rs8KLiJJK0NvaKFrnvm5m82+YdT+sZqvVzwBSfSowW2ZIXmlCjv2jLP4ZDKHavH8l5cwWrgEhuE422vm4+oZcwB+vjBJdZw8eAHk/GcLur3wDM6JCPRghCMN5x9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736361050; c=relaxed/simple;
	bh=WbrhzHcRSUNWXEFyAlmz4NYEnPgEH8IHBbo/oJcdagg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eM6s81EqGuufWzlNPS8t2HLmDom18+TjIAv+W6axP6hML1+Kf1WsivCHpCeBukRzn92i9dXmxG3Q/eOAz7mGFzUKovtXNlen4cvVp8JLaq1NWh5AbTFz6OGDOrE+UMyZ7MQb2B16KWdGoDmQqkr2+76PCAMUL2xYauY/ZIKQJCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=HAchgfYh; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 508G3qb8009541;
	Wed, 8 Jan 2025 10:30:27 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=4
	arL7uT+FxHXBop3Ns1Cmzpc3Rn4uLYlKQXgU9WmJdM=; b=HAchgfYhxT3TIlHgD
	R/5cQcb1zRwcNnnfeb8BfvqIZfQyRCvCXisn9DaVEBzcPJU69EQw8TQPgOkkYmGY
	rJsGZDjyOloo89uNdkppjzcFLuYwCP3kf95VfmZu4R/T2yIxUCS8nXNsRWFAIuic
	CUmOQeXWrOQrIxpVdKM0Taneeo/nJ/Ycjte4BvjWxAzPAjJrxNcXaHvuizFbtNPS
	jtkRLn84YSBPYbjcyP1HxFkcco9SHp2Xnupz21GewY77t81NlQChEVO54IOoZ0ac
	K2ani6tghyHc+o4sbTyC9iJgWlxklefA1bp8xjV/3q9s8uk+M5nRQVFEe/iZ5KA5
	A4Hbw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 441vj30bdm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Jan 2025 10:30:27 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 8 Jan 2025 10:30:25 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 8 Jan 2025 10:30:25 -0800
Received: from localhost.localdomain (unknown [10.28.36.166])
	by maili.marvell.com (Postfix) with ESMTP id 8AF1B3F7092;
	Wed,  8 Jan 2025 10:30:20 -0800 (PST)
From: Suman Ghosh <sumang@marvell.com>
To: <sgoutham@marvell.com>, <gakula@marvell.com>, <sbhatta@marvell.com>,
        <hkelam@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <lcherian@marvell.com>,
        <jerinj@marvell.com>, <john.fastabend@gmail.com>,
        <bbhushan2@marvell.com>, <hawk@kernel.org>, <andrew+netdev@lunn.ch>,
        <ast@kernel.org>, <daniel@iogearbox.net>, <bpf@vger.kernel.org>
CC: Suman Ghosh <sumang@marvell.com>
Subject: [net-next PATCH v2 3/6] octeontx2-pf: Add AF_XDP zero copy support for rx side
Date: Wed, 8 Jan 2025 23:59:56 +0530
Message-ID: <20250108182959.2207450-4-sumang@marvell.com>
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
X-Proofpoint-GUID: -JWJ17lUeMCtpSWtI2q7ewU_FIsTz7ZQ
X-Proofpoint-ORIG-GUID: -JWJ17lUeMCtpSWtI2q7ewU_FIsTz7ZQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.687,Hydra:6.0.235,FMLib:17.0.607.475
 definitions=2020-10-13_15,2020-10-13_02,2020-04-07_01

This patch adds support to AF_XDP zero copy for CN10K.
This patch specifically adds receive side support. In this approach once
a xdp program with zero copy support on a specific rx queue is enabled,
then that receive quse is disabled/detached from the existing kernel
queue and re-assigned to the umem memory.

Signed-off-by: Suman Ghosh <sumang@marvell.com>
---
 .../ethernet/marvell/octeontx2/nic/Makefile   |   2 +-
 .../ethernet/marvell/octeontx2/nic/cn10k.c    |   6 +-
 .../marvell/octeontx2/nic/otx2_common.c       | 117 ++++++++---
 .../marvell/octeontx2/nic/otx2_common.h       |   6 +-
 .../ethernet/marvell/octeontx2/nic/otx2_pf.c  |  25 ++-
 .../marvell/octeontx2/nic/otx2_txrx.c         |  82 ++++++--
 .../marvell/octeontx2/nic/otx2_txrx.h         |   6 +
 .../ethernet/marvell/octeontx2/nic/otx2_vf.c  |  12 +-
 .../ethernet/marvell/octeontx2/nic/otx2_xsk.c | 182 ++++++++++++++++++
 .../ethernet/marvell/octeontx2/nic/otx2_xsk.h |  21 ++
 .../ethernet/marvell/octeontx2/nic/qos_sq.c   |   2 +-
 11 files changed, 397 insertions(+), 64 deletions(-)
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/nic/otx2_xsk.c
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/nic/otx2_xsk.h

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/Makefile b/drivers/net/ethernet/marvell/octeontx2/nic/Makefile
index cb6513ab35e7..69e0778f9ac1 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/Makefile
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/Makefile
@@ -9,7 +9,7 @@ obj-$(CONFIG_RVU_ESWITCH) += rvu_rep.o
 
 rvu_nicpf-y := otx2_pf.o otx2_common.o otx2_txrx.o otx2_ethtool.o \
                otx2_flows.o otx2_tc.o cn10k.o otx2_dmac_flt.o \
-               otx2_devlink.o qos_sq.o qos.o
+               otx2_devlink.o qos_sq.o qos.o otx2_xsk.o
 rvu_nicvf-y := otx2_vf.o
 rvu_rep-y := rep.o
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k.c b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k.c
index a15cc86635d6..9a2865c60850 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k.c
@@ -112,9 +112,12 @@ int cn10k_refill_pool_ptrs(void *dev, struct otx2_cq_queue *cq)
 	struct otx2_nic *pfvf = dev;
 	int cnt = cq->pool_ptrs;
 	u64 ptrs[NPA_MAX_BURST];
+	struct otx2_pool *pool;
 	dma_addr_t bufptr;
 	int num_ptrs = 1;
 
+	pool = &pfvf->qset.pool[cq->cq_idx];
+
 	/* Refill pool with new buffers */
 	while (cq->pool_ptrs) {
 		if (otx2_alloc_buffer(pfvf, cq, &bufptr)) {
@@ -124,7 +127,8 @@ int cn10k_refill_pool_ptrs(void *dev, struct otx2_cq_queue *cq)
 			break;
 		}
 		cq->pool_ptrs--;
-		ptrs[num_ptrs] = (u64)bufptr + OTX2_HEAD_ROOM;
+		ptrs[num_ptrs] = pool->xsk_pool ? (u64)bufptr : (u64)bufptr + OTX2_HEAD_ROOM;
+
 		num_ptrs++;
 		if (num_ptrs == NPA_MAX_BURST || cq->pool_ptrs == 0) {
 			__cn10k_aura_freeptr(pfvf, cq->cq_idx, ptrs,
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
index 161cf33ef89e..e73d492ea2fa 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
@@ -17,6 +17,7 @@
 #include "otx2_common.h"
 #include "otx2_struct.h"
 #include "cn10k.h"
+#include "otx2_xsk.h"
 
 static bool otx2_is_pfc_enabled(struct otx2_nic *pfvf)
 {
@@ -549,10 +550,13 @@ static int otx2_alloc_pool_buf(struct otx2_nic *pfvf, struct otx2_pool *pool,
 }
 
 static int __otx2_alloc_rbuf(struct otx2_nic *pfvf, struct otx2_pool *pool,
-			     dma_addr_t *dma)
+			     dma_addr_t *dma, int qidx, int idx)
 {
 	u8 *buf;
 
+	if (pool->xsk_pool)
+		return otx2_xsk_pool_alloc_buf(pfvf, pool, dma, idx);
+
 	if (pool->page_pool)
 		return otx2_alloc_pool_buf(pfvf, pool, dma);
 
@@ -571,12 +575,12 @@ static int __otx2_alloc_rbuf(struct otx2_nic *pfvf, struct otx2_pool *pool,
 }
 
 int otx2_alloc_rbuf(struct otx2_nic *pfvf, struct otx2_pool *pool,
-		    dma_addr_t *dma)
+		    dma_addr_t *dma, int qidx, int idx)
 {
 	int ret;
 
 	local_bh_disable();
-	ret = __otx2_alloc_rbuf(pfvf, pool, dma);
+	ret = __otx2_alloc_rbuf(pfvf, pool, dma, qidx, idx);
 	local_bh_enable();
 	return ret;
 }
@@ -584,7 +588,8 @@ int otx2_alloc_rbuf(struct otx2_nic *pfvf, struct otx2_pool *pool,
 int otx2_alloc_buffer(struct otx2_nic *pfvf, struct otx2_cq_queue *cq,
 		      dma_addr_t *dma)
 {
-	if (unlikely(__otx2_alloc_rbuf(pfvf, cq->rbpool, dma)))
+	if (unlikely(__otx2_alloc_rbuf(pfvf, cq->rbpool, dma,
+				       cq->cq_idx, cq->pool_ptrs - 1)))
 		return -ENOMEM;
 	return 0;
 }
@@ -884,7 +889,7 @@ void otx2_sqb_flush(struct otx2_nic *pfvf)
 #define RQ_PASS_LVL_AURA (255 - ((95 * 256) / 100)) /* RED when 95% is full */
 #define RQ_DROP_LVL_AURA (255 - ((99 * 256) / 100)) /* Drop when 99% is full */
 
-static int otx2_rq_init(struct otx2_nic *pfvf, u16 qidx, u16 lpb_aura)
+int otx2_rq_init(struct otx2_nic *pfvf, u16 qidx, u16 lpb_aura)
 {
 	struct otx2_qset *qset = &pfvf->qset;
 	struct nix_aq_enq_req *aq;
@@ -1041,7 +1046,7 @@ int otx2_sq_init(struct otx2_nic *pfvf, u16 qidx, u16 sqb_aura)
 
 }
 
-static int otx2_cq_init(struct otx2_nic *pfvf, u16 qidx)
+int otx2_cq_init(struct otx2_nic *pfvf, u16 qidx)
 {
 	struct otx2_qset *qset = &pfvf->qset;
 	int err, pool_id, non_xdp_queues;
@@ -1057,11 +1062,18 @@ static int otx2_cq_init(struct otx2_nic *pfvf, u16 qidx)
 		cq->cint_idx = qidx;
 		cq->cqe_cnt = qset->rqe_cnt;
 		if (pfvf->xdp_prog) {
-			pool = &qset->pool[qidx];
 			xdp_rxq_info_reg(&cq->xdp_rxq, pfvf->netdev, qidx, 0);
-			xdp_rxq_info_reg_mem_model(&cq->xdp_rxq,
-						   MEM_TYPE_PAGE_POOL,
-						   pool->page_pool);
+			pool = &qset->pool[qidx];
+			if (pool->xsk_pool) {
+				xdp_rxq_info_reg_mem_model(&cq->xdp_rxq,
+							   MEM_TYPE_XSK_BUFF_POOL,
+							   NULL);
+				xsk_pool_set_rxq_info(pool->xsk_pool, &cq->xdp_rxq);
+			} else if (pool->page_pool) {
+				xdp_rxq_info_reg_mem_model(&cq->xdp_rxq,
+							   MEM_TYPE_PAGE_POOL,
+							   pool->page_pool);
+			}
 		}
 	} else if (qidx < non_xdp_queues) {
 		cq->cq_type = CQ_TX;
@@ -1281,9 +1293,10 @@ void otx2_free_bufs(struct otx2_nic *pfvf, struct otx2_pool *pool,
 
 	pa = otx2_iova_to_phys(pfvf->iommu_domain, iova);
 	page = virt_to_head_page(phys_to_virt(pa));
-
 	if (pool->page_pool) {
 		page_pool_put_full_page(pool->page_pool, page, true);
+	} else if (pool->xsk_pool) {
+		/* Note: No way of identifying xdp_buff */
 	} else {
 		dma_unmap_page_attrs(pfvf->dev, iova, size,
 				     DMA_FROM_DEVICE,
@@ -1298,6 +1311,7 @@ void otx2_free_aura_ptr(struct otx2_nic *pfvf, int type)
 	int pool_id, pool_start = 0, pool_end = 0, size = 0;
 	struct otx2_pool *pool;
 	u64 iova;
+	int idx;
 
 	if (type == AURA_NIX_SQ) {
 		pool_start = otx2_get_pool_idx(pfvf, type, 0);
@@ -1312,8 +1326,8 @@ void otx2_free_aura_ptr(struct otx2_nic *pfvf, int type)
 
 	/* Free SQB and RQB pointers from the aura pool */
 	for (pool_id = pool_start; pool_id < pool_end; pool_id++) {
-		iova = otx2_aura_allocptr(pfvf, pool_id);
 		pool = &pfvf->qset.pool[pool_id];
+		iova = otx2_aura_allocptr(pfvf, pool_id);
 		while (iova) {
 			if (type == AURA_NIX_RQ)
 				iova -= OTX2_HEAD_ROOM;
@@ -1322,6 +1336,13 @@ void otx2_free_aura_ptr(struct otx2_nic *pfvf, int type)
 
 			iova = otx2_aura_allocptr(pfvf, pool_id);
 		}
+
+		for (idx = 0 ; idx < pool->xdp_cnt; idx++) {
+			if (!pool->xdp[idx])
+				continue;
+
+			xsk_buff_free(pool->xdp[idx]);
+		}
 	}
 }
 
@@ -1337,8 +1358,12 @@ void otx2_aura_pool_free(struct otx2_nic *pfvf)
 		pool = &pfvf->qset.pool[pool_id];
 		qmem_free(pfvf->dev, pool->stack);
 		qmem_free(pfvf->dev, pool->fc_addr);
-		page_pool_destroy(pool->page_pool);
-		pool->page_pool = NULL;
+		if (pool->page_pool) {
+			page_pool_destroy(pool->page_pool);
+			pool->page_pool = NULL;
+		}
+		devm_kfree(pfvf->dev, pool->xdp);
+		pool->xsk_pool = NULL;
 	}
 	devm_kfree(pfvf->dev, pfvf->qset.pool);
 	pfvf->qset.pool = NULL;
@@ -1425,6 +1450,7 @@ int otx2_pool_init(struct otx2_nic *pfvf, u16 pool_id,
 		   int stack_pages, int numptrs, int buf_size, int type)
 {
 	struct page_pool_params pp_params = { 0 };
+	struct xsk_buff_pool *xsk_pool;
 	struct npa_aq_enq_req *aq;
 	struct otx2_pool *pool;
 	int err;
@@ -1468,21 +1494,35 @@ int otx2_pool_init(struct otx2_nic *pfvf, u16 pool_id,
 	aq->ctype = NPA_AQ_CTYPE_POOL;
 	aq->op = NPA_AQ_INSTOP_INIT;
 
-	if (type != AURA_NIX_RQ) {
-		pool->page_pool = NULL;
+	if (type != AURA_NIX_RQ)
+		return 0;
+
+	if (!test_bit(pool_id, pfvf->af_xdp_zc_qidx)) {
+		pp_params.order = get_order(buf_size);
+		pp_params.flags = PP_FLAG_DMA_MAP;
+		pp_params.pool_size = min(OTX2_PAGE_POOL_SZ, numptrs);
+		pp_params.nid = NUMA_NO_NODE;
+		pp_params.dev = pfvf->dev;
+		pp_params.dma_dir = DMA_FROM_DEVICE;
+		pool->page_pool = page_pool_create(&pp_params);
+		if (IS_ERR(pool->page_pool)) {
+			netdev_err(pfvf->netdev, "Creation of page pool failed\n");
+			return PTR_ERR(pool->page_pool);
+		}
 		return 0;
 	}
 
-	pp_params.order = get_order(buf_size);
-	pp_params.flags = PP_FLAG_DMA_MAP;
-	pp_params.pool_size = min(OTX2_PAGE_POOL_SZ, numptrs);
-	pp_params.nid = NUMA_NO_NODE;
-	pp_params.dev = pfvf->dev;
-	pp_params.dma_dir = DMA_FROM_DEVICE;
-	pool->page_pool = page_pool_create(&pp_params);
-	if (IS_ERR(pool->page_pool)) {
-		netdev_err(pfvf->netdev, "Creation of page pool failed\n");
-		return PTR_ERR(pool->page_pool);
+	/* Set XSK pool to support AF_XDP zero-copy */
+	xsk_pool = xsk_get_pool_from_qid(pfvf->netdev, pool_id);
+	if (xsk_pool) {
+		pool->xsk_pool = xsk_pool;
+		pool->xdp_cnt = numptrs;
+		pool->xdp = devm_kcalloc(pfvf->dev,
+					 numptrs, sizeof(struct xdp_buff *), GFP_KERNEL);
+		if (IS_ERR(pool->xdp)) {
+			netdev_err(pfvf->netdev, "Creation of xsk pool failed\n");
+			return PTR_ERR(pool->xdp);
+		}
 	}
 
 	return 0;
@@ -1543,9 +1583,18 @@ int otx2_sq_aura_pool_init(struct otx2_nic *pfvf)
 		}
 
 		for (ptr = 0; ptr < num_sqbs; ptr++) {
-			err = otx2_alloc_rbuf(pfvf, pool, &bufptr);
-			if (err)
+			err = otx2_alloc_rbuf(pfvf, pool, &bufptr, pool_id, ptr);
+			if (err) {
+				if (pool->xsk_pool) {
+					ptr--;
+					while (ptr >= 0) {
+						xsk_buff_free(pool->xdp[ptr]);
+						ptr--;
+					}
+				}
 				goto err_mem;
+			}
+
 			pfvf->hw_ops->aura_freeptr(pfvf, pool_id, bufptr);
 			sq->sqb_ptrs[sq->sqb_count++] = (u64)bufptr;
 		}
@@ -1595,11 +1644,19 @@ int otx2_rq_aura_pool_init(struct otx2_nic *pfvf)
 	/* Allocate pointers and free them to aura/pool */
 	for (pool_id = 0; pool_id < hw->rqpool_cnt; pool_id++) {
 		pool = &pfvf->qset.pool[pool_id];
+
 		for (ptr = 0; ptr < num_ptrs; ptr++) {
-			err = otx2_alloc_rbuf(pfvf, pool, &bufptr);
-			if (err)
+			err = otx2_alloc_rbuf(pfvf, pool, &bufptr, pool_id, ptr);
+			if (err) {
+				if (pool->xsk_pool) {
+					while (ptr)
+						xsk_buff_free(pool->xdp[--ptr]);
+				}
 				return -ENOMEM;
+			}
+
 			pfvf->hw_ops->aura_freeptr(pfvf, pool_id,
+						   pool->xsk_pool ? bufptr :
 						   bufptr + OTX2_HEAD_ROOM);
 		}
 	}
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
index 951fdf6bc2c4..6fd9682e2568 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
@@ -532,6 +532,8 @@ struct otx2_nic {
 
 	/* Inline ipsec */
 	struct cn10k_ipsec	ipsec;
+	/* af_xdp zero-copy */
+	unsigned long		*af_xdp_zc_qidx;
 };
 
 static inline bool is_otx2_lbkvf(struct pci_dev *pdev)
@@ -1003,7 +1005,7 @@ void otx2_txschq_free_one(struct otx2_nic *pfvf, u16 lvl, u16 schq);
 void otx2_free_pending_sqe(struct otx2_nic *pfvf);
 void otx2_sqb_flush(struct otx2_nic *pfvf);
 int otx2_alloc_rbuf(struct otx2_nic *pfvf, struct otx2_pool *pool,
-		    dma_addr_t *dma);
+		    dma_addr_t *dma, int qidx, int idx);
 int otx2_rxtx_enable(struct otx2_nic *pfvf, bool enable);
 void otx2_ctx_disable(struct mbox *mbox, int type, bool npa);
 int otx2_nix_config_bp(struct otx2_nic *pfvf, bool enable);
@@ -1033,6 +1035,8 @@ void otx2_pfaf_mbox_destroy(struct otx2_nic *pf);
 void otx2_disable_mbox_intr(struct otx2_nic *pf);
 void otx2_disable_napi(struct otx2_nic *pf);
 irqreturn_t otx2_cq_intr_handler(int irq, void *cq_irq);
+int otx2_rq_init(struct otx2_nic *pfvf, u16 qidx, u16 lpb_aura);
+int otx2_cq_init(struct otx2_nic *pfvf, u16 qidx);
 
 /* RSS configuration APIs*/
 int otx2_rss_init(struct otx2_nic *pfvf);
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
index 8ba44164736a..78472ecfd97e 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
@@ -27,6 +27,7 @@
 #include "qos.h"
 #include <rvu_trace.h>
 #include "cn10k_ipsec.h"
+#include "otx2_xsk.h"
 
 #define DRV_NAME	"rvu_nicpf"
 #define DRV_STRING	"Marvell RVU NIC Physical Function Driver"
@@ -1662,9 +1663,7 @@ void otx2_free_hw_resources(struct otx2_nic *pf)
 	struct nix_lf_free_req *free_req;
 	struct mbox *mbox = &pf->mbox;
 	struct otx2_cq_queue *cq;
-	struct otx2_pool *pool;
 	struct msg_req *req;
-	int pool_id;
 	int qidx;
 
 	/* Ensure all SQE are processed */
@@ -1705,13 +1704,6 @@ void otx2_free_hw_resources(struct otx2_nic *pf)
 	/* Free RQ buffer pointers*/
 	otx2_free_aura_ptr(pf, AURA_NIX_RQ);
 
-	for (qidx = 0; qidx < pf->hw.rx_queues; qidx++) {
-		pool_id = otx2_get_pool_idx(pf, AURA_NIX_RQ, qidx);
-		pool = &pf->qset.pool[pool_id];
-		page_pool_destroy(pool->page_pool);
-		pool->page_pool = NULL;
-	}
-
 	otx2_free_cq_res(pf);
 
 	/* Free all ingress bandwidth profiles allocated */
@@ -2793,6 +2785,8 @@ static int otx2_xdp(struct net_device *netdev, struct netdev_bpf *xdp)
 	switch (xdp->command) {
 	case XDP_SETUP_PROG:
 		return otx2_xdp_setup(pf, xdp->prog);
+	case XDP_SETUP_XSK_POOL:
+		return otx2_xsk_pool_setup(pf, xdp->xsk.pool, xdp->xsk.queue_id);
 	default:
 		return -EINVAL;
 	}
@@ -2870,6 +2864,7 @@ static const struct net_device_ops otx2_netdev_ops = {
 	.ndo_set_vf_vlan	= otx2_set_vf_vlan,
 	.ndo_get_vf_config	= otx2_get_vf_config,
 	.ndo_bpf		= otx2_xdp,
+	.ndo_xsk_wakeup		= otx2_xsk_wakeup,
 	.ndo_xdp_xmit           = otx2_xdp_xmit,
 	.ndo_setup_tc		= otx2_setup_tc,
 	.ndo_set_vf_trust	= otx2_ndo_set_vf_trust,
@@ -3208,16 +3203,26 @@ static int otx2_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	/* Enable link notifications */
 	otx2_cgx_config_linkevents(pf, true);
 
+	pf->af_xdp_zc_qidx = bitmap_zalloc(qcount, GFP_KERNEL);
+	if (!pf->af_xdp_zc_qidx) {
+		err = -ENOMEM;
+		goto err_af_xdp_zc;
+	}
+
 #ifdef CONFIG_DCB
 	err = otx2_dcbnl_set_ops(netdev);
 	if (err)
-		goto err_pf_sriov_init;
+		goto err_dcbnl_set_ops;
 #endif
 
 	otx2_qos_init(pf, qos_txqs);
 
 	return 0;
 
+err_dcbnl_set_ops:
+	bitmap_free(pf->af_xdp_zc_qidx);
+err_af_xdp_zc:
+	otx2_sriov_vfcfg_cleanup(pf);
 err_pf_sriov_init:
 	otx2_shutdown_tc(pf);
 err_mcam_flow_del:
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
index 730f2b7742db..465f5f8e3c33 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
@@ -12,6 +12,7 @@
 #include <linux/bpf_trace.h>
 #include <net/ip6_checksum.h>
 #include <net/xfrm.h>
+#include <net/xdp.h>
 
 #include "otx2_reg.h"
 #include "otx2_common.h"
@@ -536,6 +537,7 @@ int otx2_napi_handler(struct napi_struct *napi, int budget)
 	struct otx2_cq_poll *cq_poll;
 	int workdone = 0, cq_idx, i;
 	struct otx2_cq_queue *cq;
+	struct otx2_pool *pool;
 	struct otx2_qset *qset;
 	struct otx2_nic *pfvf;
 	int filled_cnt = -1;
@@ -560,6 +562,7 @@ int otx2_napi_handler(struct napi_struct *napi, int budget)
 
 	if (rx_cq && rx_cq->pool_ptrs)
 		filled_cnt = pfvf->hw_ops->refill_pool_ptrs(pfvf, rx_cq);
+
 	/* Clear the IRQ */
 	otx2_write64(pfvf, NIX_LF_CINTX_INT(cq_poll->cint_idx), BIT_ULL(0));
 
@@ -572,20 +575,31 @@ int otx2_napi_handler(struct napi_struct *napi, int budget)
 		if (pfvf->flags & OTX2_FLAG_ADPTV_INT_COAL_ENABLED)
 			otx2_adjust_adaptive_coalese(pfvf, cq_poll);
 
+		if (likely(cq))
+			pool = &pfvf->qset.pool[cq->cq_idx];
+
 		if (unlikely(!filled_cnt)) {
 			struct refill_work *work;
 			struct delayed_work *dwork;
 
-			work = &pfvf->refill_wrk[cq->cq_idx];
-			dwork = &work->pool_refill_work;
-			/* Schedule a task if no other task is running */
-			if (!cq->refill_task_sched) {
-				work->napi = napi;
-				cq->refill_task_sched = true;
-				schedule_delayed_work(dwork,
-						      msecs_to_jiffies(100));
+			if (likely(cq)) {
+				work = &pfvf->refill_wrk[cq->cq_idx];
+				dwork = &work->pool_refill_work;
+				/* Schedule a task if no other task is running */
+				if (!cq->refill_task_sched) {
+					work->napi = napi;
+					cq->refill_task_sched = true;
+					schedule_delayed_work(dwork,
+							      msecs_to_jiffies(100));
+				}
 			}
+			/* Call for wake-up for not able to fill buffers */
+			if (pool->xsk_pool)
+				xsk_set_rx_need_wakeup(pool->xsk_pool);
 		} else {
+			/* Clear wake-up, since buffers are filled successfully */
+			if (pool->xsk_pool)
+				xsk_clear_rx_need_wakeup(pool->xsk_pool);
 			/* Re-enable interrupts */
 			otx2_write64(pfvf,
 				     NIX_LF_CINTX_ENA_W1S(cq_poll->cint_idx),
@@ -1236,15 +1250,19 @@ void otx2_cleanup_rx_cqes(struct otx2_nic *pfvf, struct otx2_cq_queue *cq, int q
 	u16 pool_id;
 	u64 iova;
 
-	if (pfvf->xdp_prog)
+	pool_id = otx2_get_pool_idx(pfvf, AURA_NIX_RQ, qidx);
+	pool = &pfvf->qset.pool[pool_id];
+
+	if (pfvf->xdp_prog) {
+		if (pool->page_pool)
+			xdp_rxq_info_unreg_mem_model(&cq->xdp_rxq);
+
 		xdp_rxq_info_unreg(&cq->xdp_rxq);
+	}
 
 	if (otx2_nix_cq_op_status(pfvf, cq) || !cq->pend_cqe)
 		return;
 
-	pool_id = otx2_get_pool_idx(pfvf, AURA_NIX_RQ, qidx);
-	pool = &pfvf->qset.pool[pool_id];
-
 	while (cq->pend_cqe) {
 		cqe = (struct nix_cqe_rx_s *)otx2_get_next_cqe(cq);
 		processed_cqe++;
@@ -1429,13 +1447,24 @@ static bool otx2_xdp_rcv_pkt_handler(struct otx2_nic *pfvf,
 	unsigned char *hard_start;
 	struct otx2_pool *pool;
 	int qidx = cq->cq_idx;
-	struct xdp_buff xdp;
+	struct xdp_buff xdp, *xsk_buff = NULL;
 	struct page *page;
 	u64 iova, pa;
 	u32 act;
 	int err;
 
 	pool = &pfvf->qset.pool[qidx];
+
+	if (pool->xsk_pool) {
+		xsk_buff = pool->xdp[--cq->rbpool->xdp_top];
+		if (!xsk_buff)
+			return false;
+
+		xsk_buff->data_end = xsk_buff->data + cqe->sg.seg_size;
+		act = bpf_prog_run_xdp(prog, xsk_buff);
+		goto handle_xdp_verdict;
+	}
+
 	iova = cqe->sg.seg_addr - OTX2_HEAD_ROOM;
 	pa = otx2_iova_to_phys(pfvf->iommu_domain, iova);
 	page = virt_to_page(phys_to_virt(pa));
@@ -1448,6 +1477,7 @@ static bool otx2_xdp_rcv_pkt_handler(struct otx2_nic *pfvf,
 
 	act = bpf_prog_run_xdp(prog, &xdp);
 
+handle_xdp_verdict:
 	switch (act) {
 	case XDP_PASS:
 		break;
@@ -1458,8 +1488,18 @@ static bool otx2_xdp_rcv_pkt_handler(struct otx2_nic *pfvf,
 					      cqe->sg.seg_size, qidx, XDP_TX);
 	case XDP_REDIRECT:
 		cq->pool_ptrs++;
-		err = xdp_do_redirect(pfvf->netdev, &xdp, prog);
+		if (xsk_buff) {
+			err = xdp_do_redirect(pfvf->netdev, xsk_buff, prog);
+			if (!err) {
+				*need_xdp_flush = true;
+				return true;
+			}
+			return false;
+		}
 
+		err = xdp_do_redirect(pfvf->netdev, &xdp, prog);
+		otx2_dma_unmap_page(pfvf, iova, pfvf->rbsize,
+				    DMA_FROM_DEVICE);
 		if (!err) {
 			*need_xdp_flush = true;
 			return true;
@@ -1477,17 +1517,21 @@ static bool otx2_xdp_rcv_pkt_handler(struct otx2_nic *pfvf,
 		bpf_warn_invalid_xdp_action(pfvf->netdev, prog, act);
 		break;
 	case XDP_ABORTED:
+		if (xsk_buff)
+			xsk_buff_free(xsk_buff);
 		trace_xdp_exception(pfvf->netdev, prog, act);
 		break;
 	case XDP_DROP:
 		cq->pool_ptrs++;
-		if (page->pp) {
+		if (xsk_buff) {
+			xsk_buff_free(xsk_buff);
+		} else if (page->pp) {
 			page_pool_recycle_direct(pool->page_pool, page);
-			return true;
+		} else {
+			otx2_dma_unmap_page(pfvf, iova, pfvf->rbsize,
+					    DMA_FROM_DEVICE);
+			put_page(page);
 		}
-		otx2_dma_unmap_page(pfvf, iova, pfvf->rbsize,
-				    DMA_FROM_DEVICE);
-		put_page(page);
 		return true;
 	}
 	return false;
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.h b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.h
index 92e1e84cad75..8f346fbc8221 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.h
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.h
@@ -12,6 +12,7 @@
 #include <linux/iommu.h>
 #include <linux/if_vlan.h>
 #include <net/xdp.h>
+#include <net/xdp_sock_drv.h>
 
 #define LBK_CHAN_BASE	0x000
 #define SDP_CHAN_BASE	0x700
@@ -128,7 +129,11 @@ struct otx2_pool {
 	struct qmem		*stack;
 	struct qmem		*fc_addr;
 	struct page_pool	*page_pool;
+	struct xsk_buff_pool	*xsk_pool;
+	struct xdp_buff		**xdp;
+	u16			xdp_cnt;
 	u16			rbsize;
+	u16			xdp_top;
 };
 
 struct otx2_cq_queue {
@@ -145,6 +150,7 @@ struct otx2_cq_queue {
 	void			*cqe_base;
 	struct qmem		*cqe;
 	struct otx2_pool	*rbpool;
+	bool			xsk_zc_en;
 	struct xdp_rxq_info xdp_rxq;
 } ____cacheline_aligned_in_smp;
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
index e926c6ce96cf..e43ecfb633f8 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
@@ -722,15 +722,25 @@ static int otx2vf_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (err)
 		goto err_shutdown_tc;
 
+	vf->af_xdp_zc_qidx = bitmap_zalloc(qcount, GFP_KERNEL);
+	if (!vf->af_xdp_zc_qidx) {
+		err = -ENOMEM;
+		goto err_af_xdp_zc;
+	}
+
 #ifdef CONFIG_DCB
 	err = otx2_dcbnl_set_ops(netdev);
 	if (err)
-		goto err_shutdown_tc;
+		goto err_dcbnl_set_ops;
 #endif
 	otx2_qos_init(vf, qos_txqs);
 
 	return 0;
 
+err_dcbnl_set_ops:
+	bitmap_free(vf->af_xdp_zc_qidx);
+err_af_xdp_zc:
+	otx2_unregister_dl(vf);
 err_shutdown_tc:
 	otx2_shutdown_tc(vf);
 err_unreg_netdev:
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_xsk.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_xsk.c
new file mode 100644
index 000000000000..69098c6a6fed
--- /dev/null
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_xsk.c
@@ -0,0 +1,182 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Marvell RVU Ethernet driver
+ *
+ * Copyright (C) 2024 Marvell.
+ *
+ */
+
+#include <linux/bpf_trace.h>
+#include <linux/stringify.h>
+#include <net/xdp_sock_drv.h>
+#include <net/xdp.h>
+
+#include "otx2_common.h"
+#include "otx2_xsk.h"
+
+int otx2_xsk_pool_alloc_buf(struct otx2_nic *pfvf, struct otx2_pool *pool,
+			    dma_addr_t *dma, int idx)
+{
+	struct xdp_buff *xdp;
+	int delta;
+
+	xdp = xsk_buff_alloc(pool->xsk_pool);
+	if (!xdp)
+		return -ENOMEM;
+
+	pool->xdp[pool->xdp_top++] = xdp;
+	*dma = OTX2_DATA_ALIGN(xsk_buff_xdp_get_dma(xdp));
+	/* Adjust xdp->data for unaligned addresses */
+	delta = *dma - xsk_buff_xdp_get_dma(xdp);
+	xdp->data += delta;
+
+	return 0;
+}
+
+static int otx2_xsk_ctx_disable(struct otx2_nic *pfvf, u16 qidx, int aura_id)
+{
+	struct nix_cn10k_aq_enq_req *cn10k_rq_aq;
+	struct npa_aq_enq_req *aura_aq;
+	struct npa_aq_enq_req *pool_aq;
+	struct nix_aq_enq_req *rq_aq;
+
+	if (test_bit(CN10K_LMTST, &pfvf->hw.cap_flag)) {
+		cn10k_rq_aq = otx2_mbox_alloc_msg_nix_cn10k_aq_enq(&pfvf->mbox);
+		if (!cn10k_rq_aq)
+			return -ENOMEM;
+		cn10k_rq_aq->qidx = qidx;
+		cn10k_rq_aq->rq.ena = 0;
+		cn10k_rq_aq->rq_mask.ena = 1;
+		cn10k_rq_aq->ctype = NIX_AQ_CTYPE_RQ;
+		cn10k_rq_aq->op = NIX_AQ_INSTOP_WRITE;
+	} else {
+		rq_aq = otx2_mbox_alloc_msg_nix_aq_enq(&pfvf->mbox);
+		if (!rq_aq)
+			return -ENOMEM;
+		rq_aq->qidx = qidx;
+		rq_aq->sq.ena = 0;
+		rq_aq->sq_mask.ena = 1;
+		rq_aq->ctype = NIX_AQ_CTYPE_RQ;
+		rq_aq->op = NIX_AQ_INSTOP_WRITE;
+	}
+
+	aura_aq = otx2_mbox_alloc_msg_npa_aq_enq(&pfvf->mbox);
+	if (!aura_aq) {
+		otx2_mbox_reset(&pfvf->mbox.mbox, 0);
+		return -ENOMEM;
+	}
+
+	aura_aq->aura_id = aura_id;
+	aura_aq->aura.ena = 0;
+	aura_aq->aura_mask.ena = 1;
+	aura_aq->ctype = NPA_AQ_CTYPE_AURA;
+	aura_aq->op = NPA_AQ_INSTOP_WRITE;
+
+	pool_aq = otx2_mbox_alloc_msg_npa_aq_enq(&pfvf->mbox);
+	if (!pool_aq) {
+		otx2_mbox_reset(&pfvf->mbox.mbox, 0);
+		return -ENOMEM;
+	}
+
+	pool_aq->aura_id = aura_id;
+	pool_aq->pool.ena = 0;
+	pool_aq->pool_mask.ena = 1;
+
+	pool_aq->ctype = NPA_AQ_CTYPE_POOL;
+	pool_aq->op = NPA_AQ_INSTOP_WRITE;
+
+	return otx2_sync_mbox_msg(&pfvf->mbox);
+}
+
+static void otx2_clean_up_rq(struct otx2_nic *pfvf, int qidx)
+{
+	struct otx2_qset *qset = &pfvf->qset;
+	struct otx2_cq_queue *cq;
+	struct otx2_pool *pool;
+	u64 iova;
+
+	/* If the DOWN flag is set SQs are already freed */
+	if (pfvf->flags & OTX2_FLAG_INTF_DOWN)
+		return;
+
+	cq = &qset->cq[qidx];
+	if (cq)
+		otx2_cleanup_rx_cqes(pfvf, cq, qidx);
+
+	pool = &pfvf->qset.pool[qidx];
+	iova = otx2_aura_allocptr(pfvf, qidx);
+	while (iova) {
+		iova -= OTX2_HEAD_ROOM;
+		otx2_free_bufs(pfvf, pool, iova, pfvf->rbsize);
+		iova = otx2_aura_allocptr(pfvf, qidx);
+	}
+
+	mutex_lock(&pfvf->mbox.lock);
+	otx2_xsk_ctx_disable(pfvf, qidx, qidx);
+	mutex_unlock(&pfvf->mbox.lock);
+}
+
+int otx2_xsk_pool_enable(struct otx2_nic *pf, struct xsk_buff_pool *pool, u16 qidx)
+{
+	u16 rx_queues = pf->hw.rx_queues;
+	u16 tx_queues = pf->hw.tx_queues;
+	int err;
+
+	if (qidx >= rx_queues || qidx >= tx_queues)
+		return -EINVAL;
+
+	err = xsk_pool_dma_map(pool, pf->dev, DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_WEAK_ORDERING);
+	if (err)
+		return err;
+
+	set_bit(qidx, pf->af_xdp_zc_qidx);
+	otx2_clean_up_rq(pf, qidx);
+	/* Kick start the NAPI context so that receiving will start */
+	return otx2_xsk_wakeup(pf->netdev, qidx, XDP_WAKEUP_RX);
+}
+
+int otx2_xsk_pool_disable(struct otx2_nic *pf, u16 qidx)
+{
+	struct net_device *netdev = pf->netdev;
+	struct xsk_buff_pool *pool;
+
+	pool = xsk_get_pool_from_qid(netdev, qidx);
+	if (!pool)
+		return -EINVAL;
+
+	otx2_clean_up_rq(pf, qidx);
+	clear_bit(qidx, pf->af_xdp_zc_qidx);
+	xsk_pool_dma_unmap(pool, DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_WEAK_ORDERING);
+
+	return 0;
+}
+
+int otx2_xsk_pool_setup(struct otx2_nic *pf, struct xsk_buff_pool *pool, u16 qidx)
+{
+	if (pool)
+		return otx2_xsk_pool_enable(pf, pool, qidx);
+
+	return otx2_xsk_pool_disable(pf, qidx);
+}
+
+int otx2_xsk_wakeup(struct net_device *dev, u32 queue_id, u32 flags)
+{
+	struct otx2_nic *pf = netdev_priv(dev);
+	struct otx2_cq_poll *cq_poll = NULL;
+	struct otx2_qset *qset = &pf->qset;
+
+	if (pf->flags & OTX2_FLAG_INTF_DOWN)
+		return -ENETDOWN;
+
+	if (queue_id >= pf->hw.rx_queues)
+		return -EINVAL;
+
+	cq_poll = &qset->napi[queue_id];
+	if (!cq_poll)
+		return -EINVAL;
+
+	/* Trigger interrupt */
+	if (!napi_if_scheduled_mark_missed(&cq_poll->napi))
+		otx2_write64(pf, NIX_LF_CINTX_ENA_W1S(cq_poll->cint_idx), BIT_ULL(0));
+
+	return 0;
+}
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_xsk.h b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_xsk.h
new file mode 100644
index 000000000000..022b3433edbb
--- /dev/null
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_xsk.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Marvell RVU PF/VF Netdev Devlink
+ *
+ * Copyright (C) 2024 Marvell.
+ *
+ */
+
+#ifndef	OTX2_XSK_H
+#define	OTX2_XSK_H
+
+struct otx2_nic;
+struct xsk_buff_pool;
+
+int otx2_xsk_pool_setup(struct otx2_nic *pf, struct xsk_buff_pool *pool, u16 qid);
+int otx2_xsk_pool_enable(struct otx2_nic *pf, struct xsk_buff_pool *pool, u16 qid);
+int otx2_xsk_pool_disable(struct otx2_nic *pf, u16 qid);
+int otx2_xsk_pool_alloc_buf(struct otx2_nic *pfvf, struct otx2_pool *pool,
+			    dma_addr_t *dma, int idx);
+int otx2_xsk_wakeup(struct net_device *dev, u32 queue_id, u32 flags);
+
+#endif /* OTX2_XSK_H */
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/qos_sq.c b/drivers/net/ethernet/marvell/octeontx2/nic/qos_sq.c
index 9d887bfc3108..c5dbae0e513b 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/qos_sq.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/qos_sq.c
@@ -82,7 +82,7 @@ static int otx2_qos_sq_aura_pool_init(struct otx2_nic *pfvf, int qidx)
 	}
 
 	for (ptr = 0; ptr < num_sqbs; ptr++) {
-		err = otx2_alloc_rbuf(pfvf, pool, &bufptr);
+		err = otx2_alloc_rbuf(pfvf, pool, &bufptr, pool_id, ptr);
 		if (err)
 			goto sqb_free;
 		pfvf->hw_ops->aura_freeptr(pfvf, pool_id, bufptr);
-- 
2.25.1


