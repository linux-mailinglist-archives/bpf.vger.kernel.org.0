Return-Path: <bpf+bounces-70891-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 63251BD8DB3
	for <lists+bpf@lfdr.de>; Tue, 14 Oct 2025 12:59:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9D0DF352938
	for <lists+bpf@lfdr.de>; Tue, 14 Oct 2025 10:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C52D30DEA4;
	Tue, 14 Oct 2025 10:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="MzNf5KuD"
X-Original-To: bpf@vger.kernel.org
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B6030C36F;
	Tue, 14 Oct 2025 10:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760439437; cv=none; b=VcdWRN9Ga/v2FkIlnL7sGzeZwwsCJZXlGicTGptRz1L6J6phcOWTXXYRKRTutjbqHAMkcZ4sSAll5+x0ce3gNM+SNlhKNrgdj4JCknj5xGC7gnkrkexgItAOnr2GKKt1NQVmUUdSZwrQEgO86w31CYp4fEbZ9nL53RaDawluumg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760439437; c=relaxed/simple;
	bh=BTcqGG3yhxOnS6ejwicuqThYGfBp/Y/RvJeLELJoDOE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gxCuLdX42lRQSiOg20YQh9IlhOZVTSy05CY0HWhWnt0/SC6FxzdXuNVhk8PsbGwNMAj0HG8kfi/P2zjw2vHWQrN/qODsYfaLb9r+vBhwUcXFq9TT5fFtwkfyItGJzY9OWPxxctAkjXR3pCA0aK4aC9pq8hdwZbYuv+ruTc32Mik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=MzNf5KuD; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 59EAuVW81574224;
	Tue, 14 Oct 2025 05:56:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1760439391;
	bh=eefmzOzDRguFWe58LmJOHPY5HHwFLQ8o9LWD18ibBRM=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=MzNf5KuDeeWOsbfC01VLTCjrnVz3dxyyJQMbIN1M1c6njvA0008KHHxCpVPE9vaSH
	 pEdatVXz4V7JSQ8gF7FMIw4yaC/y/GGDnYqFR5Qw+SAEkX62NafPFJjqCqzSdEXQci
	 ApcvlLZoVmAUoKwVHkarx2rCMZtM+W/e0QwLBejs=
Received: from DLEE212.ent.ti.com (dlee212.ent.ti.com [157.170.170.114])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 59EAuVeD1005239
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 14 Oct 2025 05:56:31 -0500
Received: from DLEE206.ent.ti.com (157.170.170.90) by DLEE212.ent.ti.com
 (157.170.170.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 14 Oct
 2025 05:56:30 -0500
Received: from fllvem-mr07.itg.ti.com (10.64.41.89) by DLEE206.ent.ti.com
 (157.170.170.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 14 Oct 2025 05:56:30 -0500
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
	by fllvem-mr07.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59EAuUPQ2934595;
	Tue, 14 Oct 2025 05:56:30 -0500
Received: from localhost (meghana-pc.dhcp.ti.com [10.24.69.13] (may be forged))
	by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 59EAuTRI010682;
	Tue, 14 Oct 2025 05:56:30 -0500
From: Meghana Malladi <m-malladi@ti.com>
To: <horms@kernel.org>, <namcao@linutronix.de>, <jacob.e.keller@intel.com>,
        <m-malladi@ti.com>, <christian.koenig@amd.com>,
        <sumit.semwal@linaro.org>, <sdf@fomichev.me>,
        <john.fastabend@gmail.com>, <hawk@kernel.org>, <daniel@iogearbox.net>,
        <ast@kernel.org>, <pabeni@redhat.com>, <kuba@kernel.org>,
        <edumazet@google.com>, <davem@davemloft.net>, <andrew+netdev@lunn.ch>
CC: <linaro-mm-sig@lists.linaro.org>, <dri-devel@lists.freedesktop.org>,
        <linux-media@vger.kernel.org>, <bpf@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        Vignesh Raghavendra
	<vigneshr@ti.com>,
        Roger Quadros <rogerq@kernel.org>, <danishanwar@ti.com>
Subject: [PATCH net-next v3 4/6] net: ti: icssg-prueth: Make emac_run_xdp function independent of page
Date: Tue, 14 Oct 2025 16:26:10 +0530
Message-ID: <20251014105613.2808674-5-m-malladi@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251014105613.2808674-1-m-malladi@ti.com>
References: <20251014105613.2808674-1-m-malladi@ti.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

emac_run_xdp function runs xdp program, at a given hook point
in the Rx path of the driver in NAPI context and returns
XDP return codes. In zero copy mode the driver receives
packets using UMEM frames instead of pages (native XDP).
Decouple the usage of page in this function.

Signed-off-by: Meghana Malladi <m-malladi@ti.com>
---
 drivers/net/ethernet/ti/icssg/icssg_common.c | 26 ++++++++++++--------
 drivers/net/ethernet/ti/icssg/icssg_prueth.c |  3 ++-
 drivers/net/ethernet/ti/icssg/icssg_prueth.h |  9 +++++--
 3 files changed, 25 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/ti/icssg/icssg_common.c b/drivers/net/ethernet/ti/icssg/icssg_common.c
index b526f246ecb9..bc6dc7bf3f6a 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_common.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_common.c
@@ -647,15 +647,15 @@ void emac_rx_timestamp(struct prueth_emac *emac,
  * emac_xmit_xdp_frame - transmits an XDP frame
  * @emac: emac device
  * @xdpf: data to transmit
- * @page: page from page pool if already DMA mapped
  * @q_idx: queue id
+ * @buff_type: Type of buffer to be transmitted
  *
  * Return: XDP state
  */
 u32 emac_xmit_xdp_frame(struct prueth_emac *emac,
 			struct xdp_frame *xdpf,
-			struct page *page,
-			unsigned int q_idx)
+			unsigned int q_idx,
+			enum prueth_tx_buff_type buff_type)
 {
 	struct cppi5_host_desc_t *first_desc;
 	struct net_device *ndev = emac->ndev;
@@ -663,6 +663,7 @@ u32 emac_xmit_xdp_frame(struct prueth_emac *emac,
 	struct prueth_tx_chn *tx_chn;
 	dma_addr_t desc_dma, buf_dma;
 	struct prueth_swdata *swdata;
+	struct page *page;
 	u32 *epib;
 	int ret;
 
@@ -679,7 +680,12 @@ u32 emac_xmit_xdp_frame(struct prueth_emac *emac,
 		return ICSSG_XDP_CONSUMED;	/* drop */
 	}
 
-	if (page) { /* already DMA mapped by page_pool */
+	if (buff_type == PRUETH_TX_BUFF_TYPE_XDP_TX) { /* already DMA mapped by page_pool */
+		page = virt_to_head_page(xdpf->data);
+		if (unlikely(!page)) {
+			netdev_err(ndev, "xdp tx: failed to get page from xdpf\n");
+			goto drop_free_descs;
+		}
 		buf_dma = page_pool_get_dma_addr(page);
 		buf_dma += xdpf->headroom + sizeof(struct xdp_frame);
 	} else { /* Map the linear buffer */
@@ -734,13 +740,11 @@ EXPORT_SYMBOL_GPL(emac_xmit_xdp_frame);
  * emac_run_xdp - run an XDP program
  * @emac: emac device
  * @xdp: XDP buffer containing the frame
- * @page: page with RX data if already DMA mapped
  * @len: Rx descriptor packet length
  *
  * Return: XDP state
  */
-static u32 emac_run_xdp(struct prueth_emac *emac, struct xdp_buff *xdp,
-			struct page *page, u32 *len)
+static u32 emac_run_xdp(struct prueth_emac *emac, struct xdp_buff *xdp, u32 *len)
 {
 	struct net_device *ndev = emac->ndev;
 	struct netdev_queue *netif_txq;
@@ -767,7 +771,8 @@ static u32 emac_run_xdp(struct prueth_emac *emac, struct xdp_buff *xdp,
 		q_idx = cpu % emac->tx_ch_num;
 		netif_txq = netdev_get_tx_queue(ndev, q_idx);
 		__netif_tx_lock(netif_txq, cpu);
-		result = emac_xmit_xdp_frame(emac, xdpf, page, q_idx);
+		result = emac_xmit_xdp_frame(emac, xdpf, q_idx,
+					     PRUETH_TX_BUFF_TYPE_XDP_TX);
 		__netif_tx_unlock(netif_txq);
 		if (result == ICSSG_XDP_CONSUMED) {
 			ndev->stats.tx_dropped++;
@@ -792,7 +797,8 @@ static u32 emac_run_xdp(struct prueth_emac *emac, struct xdp_buff *xdp,
 		fallthrough; /* handle aborts by dropping packet */
 	case XDP_DROP:
 		ndev->stats.rx_dropped++;
-		page_pool_recycle_direct(emac->rx_chns.pg_pool, page);
+		page_pool_recycle_direct(emac->rx_chns.pg_pool,
+					 virt_to_head_page(xdp->data));
 		return ICSSG_XDP_CONSUMED;
 	}
 }
@@ -861,7 +867,7 @@ static int emac_rx_packet(struct prueth_emac *emac, u32 flow_id, u32 *xdp_state)
 		xdp_init_buff(&xdp, PAGE_SIZE, &rx_chn->xdp_rxq);
 		xdp_prepare_buff(&xdp, pa, PRUETH_HEADROOM, pkt_len, false);
 
-		*xdp_state = emac_run_xdp(emac, &xdp, page, &pkt_len);
+		*xdp_state = emac_run_xdp(emac, &xdp, &pkt_len);
 		if (*xdp_state != ICSSG_XDP_PASS)
 			goto requeue;
 		headroom = xdp.data - xdp.data_hard_start;
diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
index 78778f0e8f4a..296034ab6c67 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
@@ -1177,7 +1177,8 @@ static int emac_xdp_xmit(struct net_device *dev, int n, struct xdp_frame **frame
 	__netif_tx_lock(netif_txq, cpu);
 	for (i = 0; i < n; i++) {
 		xdpf = frames[i];
-		err = emac_xmit_xdp_frame(emac, xdpf, NULL, q_idx);
+		err = emac_xmit_xdp_frame(emac, xdpf, q_idx,
+					  PRUETH_TX_BUFF_TYPE_XDP_NDO);
 		if (err != ICSSG_XDP_TX) {
 			ndev->stats.tx_dropped++;
 			break;
diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.h b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
index 90b3e9c9e148..74a0e5ed2a47 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.h
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
@@ -154,6 +154,11 @@ enum prueth_swdata_type {
 	PRUETH_SWDATA_XSK,
 };
 
+enum prueth_tx_buff_type {
+	PRUETH_TX_BUFF_TYPE_XDP_TX,
+	PRUETH_TX_BUFF_TYPE_XDP_NDO,
+};
+
 struct prueth_swdata {
 	enum prueth_swdata_type type;
 	union prueth_data {
@@ -502,8 +507,8 @@ void prueth_put_cores(struct prueth *prueth, int slice);
 u64 icssg_ts_to_ns(u32 hi_sw, u32 hi, u32 lo, u32 cycle_time_ns);
 u32 emac_xmit_xdp_frame(struct prueth_emac *emac,
 			struct xdp_frame *xdpf,
-			struct page *page,
-			unsigned int q_idx);
+			unsigned int q_idx,
+			enum prueth_tx_buff_type buff_type);
 void prueth_rx_cleanup(void *data, dma_addr_t desc_dma);
 void prueth_tx_cleanup(void *data, dma_addr_t desc_dma);
 int prueth_xsk_wakeup(struct net_device *ndev, u32 qid, u32 flags);
-- 
2.43.0


