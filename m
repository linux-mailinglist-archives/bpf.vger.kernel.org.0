Return-Path: <bpf+bounces-52325-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A184A41BFC
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 12:03:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD0821896F1B
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 11:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 579AE25A2CD;
	Mon, 24 Feb 2025 11:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="EYp/+os2"
X-Original-To: bpf@vger.kernel.org
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A0325A2B1;
	Mon, 24 Feb 2025 11:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740394929; cv=none; b=ieJwpUyFh4ONK8qwzeyppVAjt/qqMumEz+++pUFshEnnyUpKe2JNy/SxU0L9oXWtpN0Q/XILNYN/EeMP/Y/lkLKJT6LoJtF9zL6ToaU/d4J0ZHdqzlcN1easePC99z1mI9x5AEt4P3fWmdxIp+P2DUcgyKTSttDce/IDx7tw6ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740394929; c=relaxed/simple;
	bh=TSRCFMHn+vKBYsLL6ZtqgQRghn+kDzWZZBtcFVcezL8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hzzYATBXIMs15LaIl0AhPOMGn2DOniaSPfrtfndaIWsDSsrXab+i6cBi+PyoyKf7RRdYK/ZCI7HsKYQeV4F6FjRDIfy1oYbRSUdhxooSiiV0YlElQmiczI8DqIRgvtOknkPgLAMB5yhe8gJu0KAygABBjlan3/z4fA/TM5bSA0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=EYp/+os2; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 51OB1GRC902041
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Feb 2025 05:01:16 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1740394876;
	bh=W7r7L+LBnmbbRhtkKbNC6ysKkiv2Ise1DljrroFPR0I=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=EYp/+os2JLnz+sF1mNlmTvrVXYLTj6qxdwN7kUSmC0tyKOkuuL6gWFRpiGrGbiZ4o
	 Lf+NXf49Zq8Bq/9BkIxg4FjI3QUkR+sH/+/THldRT4d5GQ8VCz3tzmj9zdsfv+2ibg
	 iRtCHPgBcoXOwEK3rTitBdWtqiWGakTyHLRV+mQc=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 51OB1GQ7001000
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 24 Feb 2025 05:01:16 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 24
 Feb 2025 05:01:15 -0600
Received: from fllvsmtp7.itg.ti.com (10.64.40.31) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 24 Feb 2025 05:01:15 -0600
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
	by fllvsmtp7.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51OB1FhR037086;
	Mon, 24 Feb 2025 05:01:15 -0600
Received: from localhost (meghana-pc.dhcp.ti.com [10.24.69.13] (may be forged))
	by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 51OB1Er0002053;
	Mon, 24 Feb 2025 05:01:15 -0600
From: Meghana Malladi <m-malladi@ti.com>
To: <rogerq@kernel.org>, <danishanwar@ti.com>, <pabeni@redhat.com>,
        <kuba@kernel.org>, <edumazet@google.com>, <davem@davemloft.net>,
        <andrew+netdev@lunn.ch>
CC: <bpf@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <u.kleine-koenig@baylibre.com>, <matthias.schiffer@ew.tq-group.com>,
        <dan.carpenter@linaro.org>, <m-malladi@ti.com>,
        <schnelle@linux.ibm.com>, <diogo.ivo@siemens.com>,
        <glaroque@baylibre.com>, <macro@orcam.me.uk>,
        <john.fastabend@gmail.com>, <hawk@kernel.org>, <daniel@iogearbox.net>,
        <ast@kernel.org>, <srk@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>
Subject: [PATCH net-next v3 3/3] net: ti: icssg-prueth: Add XDP support
Date: Mon, 24 Feb 2025 16:31:02 +0530
Message-ID: <20250224110102.1528552-4-m-malladi@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250224110102.1528552-1-m-malladi@ti.com>
References: <20250224110102.1528552-1-m-malladi@ti.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

From: Roger Quadros <rogerq@kernel.org>

Add native XDP support. We do not support zero copy yet.

Signed-off-by: Roger Quadros <rogerq@kernel.org>
Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
Signed-off-by: Meghana Malladi <m-malladi@ti.com>
---
Changes since v2 (v3-v2):
- Use page_pool contained in the page instead of using passing page_pool
(rx_chn) as part of swdata
- dev_sw_netstats_tx_add() instead of incrementing the stats directly
- Add missing ndev->stats.tx_dropped++ wherever applicable
- Move k3_cppi_desc_pool_alloc() before the DMA mapping for easier cleanup
on failure
- Replace rxp->napi_id with emac->napi_rx.napi_id in prueth_create_xdp_rxqs()

All the above changes have been suggested by Roger Quadros <rogerq@kernel.org>

 drivers/net/ethernet/ti/icssg/icssg_common.c | 219 +++++++++++++++++--
 drivers/net/ethernet/ti/icssg/icssg_prueth.c | 125 ++++++++++-
 drivers/net/ethernet/ti/icssg/icssg_prueth.h |  17 ++
 3 files changed, 346 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/ti/icssg/icssg_common.c b/drivers/net/ethernet/ti/icssg/icssg_common.c
index 01eeabe83eff..4716e24ea05d 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_common.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_common.c
@@ -98,11 +98,19 @@ void prueth_xmit_free(struct prueth_tx_chn *tx_chn,
 {
 	struct cppi5_host_desc_t *first_desc, *next_desc;
 	dma_addr_t buf_dma, next_desc_dma;
+	struct prueth_swdata *swdata;
 	u32 buf_dma_len;
 
 	first_desc = desc;
 	next_desc = first_desc;
 
+	swdata = cppi5_hdesc_get_swdata(desc);
+	if (swdata->type == PRUETH_SWDATA_PAGE) {
+		page_pool_recycle_direct(swdata->data.page->pp,
+					 swdata->data.page);
+		goto free_desc;
+	}
+
 	cppi5_hdesc_get_obuf(first_desc, &buf_dma, &buf_dma_len);
 	k3_udma_glue_tx_cppi5_to_dma_addr(tx_chn->tx_chn, &buf_dma);
 
@@ -126,6 +134,7 @@ void prueth_xmit_free(struct prueth_tx_chn *tx_chn,
 		k3_cppi_desc_pool_free(tx_chn->desc_pool, next_desc);
 	}
 
+free_desc:
 	k3_cppi_desc_pool_free(tx_chn->desc_pool, first_desc);
 }
 EXPORT_SYMBOL_GPL(prueth_xmit_free);
@@ -139,6 +148,7 @@ int emac_tx_complete_packets(struct prueth_emac *emac, int chn,
 	struct prueth_swdata *swdata;
 	struct prueth_tx_chn *tx_chn;
 	unsigned int total_bytes = 0;
+	struct xdp_frame *xdpf;
 	struct sk_buff *skb;
 	dma_addr_t desc_dma;
 	int res, num_tx = 0;
@@ -168,21 +178,28 @@ int emac_tx_complete_packets(struct prueth_emac *emac, int chn,
 			continue;
 		}
 
-		if (swdata->type != PRUETH_SWDATA_SKB) {
+		switch (swdata->type) {
+		case PRUETH_SWDATA_SKB:
+			skb = swdata->data.skb;
+			dev_sw_netstats_tx_add(skb->dev, 1, skb->len);
+			total_bytes += skb->len;
+			napi_consume_skb(skb, budget);
+			break;
+		case PRUETH_SWDATA_XDPF:
+			xdpf = swdata->data.xdpf;
+			dev_sw_netstats_tx_add(ndev, 1, xdpf->len);
+			total_bytes += xdpf->len;
+			xdp_return_frame(xdpf);
+			break;
+		default:
 			netdev_err(ndev, "tx_complete: invalid swdata type %d\n", swdata->type);
 			prueth_xmit_free(tx_chn, desc_tx);
+			ndev->stats.tx_dropped++;
 			budget++;
 			continue;
 		}
 
-		skb = swdata->data.skb;
 		prueth_xmit_free(tx_chn, desc_tx);
-
-		ndev = skb->dev;
-		ndev->stats.tx_packets++;
-		ndev->stats.tx_bytes += skb->len;
-		total_bytes += skb->len;
-		napi_consume_skb(skb, budget);
 		num_tx++;
 	}
 
@@ -541,7 +558,153 @@ void emac_rx_timestamp(struct prueth_emac *emac,
 	ssh->hwtstamp = ns_to_ktime(ns);
 }
 
-static int emac_rx_packet(struct prueth_emac *emac, u32 flow_id)
+/**
+ * emac_xmit_xdp_frame - transmits an XDP frame
+ * @emac: emac device
+ * @xdpf: data to transmit
+ * @page: page from page pool if already DMA mapped
+ * @q_idx: queue id
+ *
+ * Return: XDP state
+ */
+int emac_xmit_xdp_frame(struct prueth_emac *emac,
+			struct xdp_frame *xdpf,
+			struct page *page,
+			unsigned int q_idx)
+{
+	struct cppi5_host_desc_t *first_desc;
+	struct net_device *ndev = emac->ndev;
+	struct prueth_tx_chn *tx_chn;
+	dma_addr_t desc_dma, buf_dma;
+	struct prueth_swdata *swdata;
+	u32 *epib;
+	int ret;
+
+	void *data = xdpf->data;
+	u32 pkt_len = xdpf->len;
+
+	if (q_idx >= PRUETH_MAX_TX_QUEUES) {
+		netdev_err(ndev, "xdp tx: invalid q_id %d\n", q_idx);
+		return ICSSG_XDP_CONSUMED;	/* drop */
+	}
+
+	tx_chn = &emac->tx_chns[q_idx];
+
+	first_desc = k3_cppi_desc_pool_alloc(tx_chn->desc_pool);
+	if (!first_desc) {
+		netdev_dbg(ndev, "xdp tx: failed to allocate descriptor\n");
+		goto drop_free_descs;	/* drop */
+	}
+
+	if (page) { /* already DMA mapped by page_pool */
+		buf_dma = page_pool_get_dma_addr(page);
+		buf_dma += xdpf->headroom + sizeof(struct xdp_frame);
+	} else { /* Map the linear buffer */
+		buf_dma = dma_map_single(tx_chn->dma_dev, data, pkt_len, DMA_TO_DEVICE);
+		if (dma_mapping_error(tx_chn->dma_dev, buf_dma)) {
+			netdev_err(ndev, "xdp tx: failed to map data buffer\n");
+			goto drop_free_descs;	/* drop */
+		}
+	}
+
+	cppi5_hdesc_init(first_desc, CPPI5_INFO0_HDESC_EPIB_PRESENT,
+			 PRUETH_NAV_PS_DATA_SIZE);
+	cppi5_hdesc_set_pkttype(first_desc, 0);
+	epib = first_desc->epib;
+	epib[0] = 0;
+	epib[1] = 0;
+
+	/* set dst tag to indicate internal qid at the firmware which is at
+	 * bit8..bit15. bit0..bit7 indicates port num for directed
+	 * packets in case of switch mode operation
+	 */
+	cppi5_desc_set_tags_ids(&first_desc->hdr, 0, (emac->port_id | (q_idx << 8)));
+	k3_udma_glue_tx_dma_to_cppi5_addr(tx_chn->tx_chn, &buf_dma);
+	cppi5_hdesc_attach_buf(first_desc, buf_dma, pkt_len, buf_dma, pkt_len);
+	swdata = cppi5_hdesc_get_swdata(first_desc);
+	if (page) {
+		swdata->type = PRUETH_SWDATA_PAGE;
+		swdata->data.page = page;
+	} else {
+		swdata->type = PRUETH_SWDATA_XDPF;
+		swdata->data.xdpf = xdpf;
+	}
+
+	cppi5_hdesc_set_pktlen(first_desc, pkt_len);
+	desc_dma = k3_cppi_desc_pool_virt2dma(tx_chn->desc_pool, first_desc);
+
+	ret = k3_udma_glue_push_tx_chn(tx_chn->tx_chn, first_desc, desc_dma);
+	if (ret) {
+		netdev_err(ndev, "xdp tx: push failed: %d\n", ret);
+		goto drop_free_descs;
+	}
+
+	return ICSSG_XDP_TX;
+
+drop_free_descs:
+	prueth_xmit_free(tx_chn, first_desc);
+	return ICSSG_XDP_CONSUMED;
+}
+EXPORT_SYMBOL_GPL(emac_xmit_xdp_frame);
+
+/**
+ * emac_run_xdp - run an XDP program
+ * @emac: emac device
+ * @xdp: XDP buffer containing the frame
+ * @page: page with RX data if already DMA mapped
+ *
+ * Return: XDP state
+ */
+static int emac_run_xdp(struct prueth_emac *emac, struct xdp_buff *xdp,
+			struct page *page)
+{
+	struct net_device *ndev = emac->ndev;
+	int err, result = ICSSG_XDP_PASS;
+	struct bpf_prog *xdp_prog;
+	struct xdp_frame *xdpf;
+	int q_idx;
+	u32 act;
+
+	xdp_prog = READ_ONCE(emac->xdp_prog);
+	act = bpf_prog_run_xdp(xdp_prog, xdp);
+	switch (act) {
+	case XDP_PASS:
+		break;
+	case XDP_TX:
+		/* Send packet to TX ring for immediate transmission */
+		xdpf = xdp_convert_buff_to_frame(xdp);
+		if (unlikely(!xdpf))
+			goto drop;
+
+		q_idx = smp_processor_id() % emac->tx_ch_num;
+		result = emac_xmit_xdp_frame(emac, xdpf, page, q_idx);
+		if (result == ICSSG_XDP_CONSUMED)
+			goto drop;
+		break;
+	case XDP_REDIRECT:
+		err = xdp_do_redirect(emac->ndev, xdp, xdp_prog);
+		if (err)
+			goto drop;
+		result = ICSSG_XDP_REDIR;
+		break;
+	default:
+		bpf_warn_invalid_xdp_action(emac->ndev, xdp_prog, act);
+		fallthrough;
+	case XDP_ABORTED:
+drop:
+		trace_xdp_exception(emac->ndev, xdp_prog, act);
+		fallthrough; /* handle aborts by dropping packet */
+	case XDP_DROP:
+		ndev->stats.tx_dropped++;
+		result = ICSSG_XDP_CONSUMED;
+		page_pool_recycle_direct(emac->rx_chns.pg_pool, page);
+		break;
+	}
+
+	return result;
+}
+
+static int emac_rx_packet(struct prueth_emac *emac, u32 flow_id, int *xdp_state)
 {
 	struct prueth_rx_chn *rx_chn = &emac->rx_chns;
 	u32 buf_dma_len, pkt_len, port_id = 0;
@@ -552,10 +715,12 @@ static int emac_rx_packet(struct prueth_emac *emac, u32 flow_id)
 	struct page *page, *new_page;
 	struct page_pool *pool;
 	struct sk_buff *skb;
+	struct xdp_buff xdp;
 	u32 *psdata;
 	void *pa;
 	int ret;
 
+	*xdp_state = 0;
 	pool = rx_chn->pg_pool;
 	ret = k3_udma_glue_pop_rx_chn(rx_chn->rx_chn, flow_id, &desc_dma);
 	if (ret) {
@@ -596,9 +761,21 @@ static int emac_rx_packet(struct prueth_emac *emac, u32 flow_id)
 		goto requeue;
 	}
 
-	/* prepare skb and send to n/w stack */
 	pa = page_address(page);
-	skb = napi_build_skb(pa, PAGE_SIZE);
+	if (emac->xdp_prog) {
+		xdp_init_buff(&xdp, PAGE_SIZE, &rx_chn->xdp_rxq);
+		xdp_prepare_buff(&xdp, pa, PRUETH_HEADROOM, pkt_len, false);
+
+		*xdp_state = emac_run_xdp(emac, &xdp, page);
+		if (*xdp_state == ICSSG_XDP_PASS)
+			skb = xdp_build_skb_from_buff(&xdp);
+		else
+			goto requeue;
+	} else {
+		/* prepare skb and send to n/w stack */
+		skb = napi_build_skb(pa, PAGE_SIZE);
+	}
+
 	if (!skb) {
 		ndev->stats.rx_dropped++;
 		page_pool_recycle_direct(pool, page);
@@ -861,13 +1038,23 @@ static void prueth_tx_cleanup(void *data, dma_addr_t desc_dma)
 	struct prueth_tx_chn *tx_chn = data;
 	struct cppi5_host_desc_t *desc_tx;
 	struct prueth_swdata *swdata;
+	struct xdp_frame *xdpf;
 	struct sk_buff *skb;
 
 	desc_tx = k3_cppi_desc_pool_dma2virt(tx_chn->desc_pool, desc_dma);
 	swdata = cppi5_hdesc_get_swdata(desc_tx);
-	if (swdata->type == PRUETH_SWDATA_SKB) {
+
+	switch (swdata->type) {
+	case PRUETH_SWDATA_SKB:
 		skb = swdata->data.skb;
 		dev_kfree_skb_any(skb);
+		break;
+	case PRUETH_SWDATA_XDPF:
+		xdpf = swdata->data.xdpf;
+		xdp_return_frame(xdpf);
+		break;
+	default:
+		break;
 	}
 
 	prueth_xmit_free(tx_chn, desc_tx);
@@ -904,15 +1091,18 @@ int icssg_napi_rx_poll(struct napi_struct *napi_rx, int budget)
 		PRUETH_RX_FLOW_DATA_SR1 : PRUETH_RX_FLOW_DATA;
 	int flow = emac->is_sr1 ?
 		PRUETH_MAX_RX_FLOWS_SR1 : PRUETH_MAX_RX_FLOWS;
+	int xdp_state_or = 0;
 	int num_rx = 0;
 	int cur_budget;
+	int xdp_state;
 	int ret;
 
 	while (flow--) {
 		cur_budget = budget - num_rx;
 
 		while (cur_budget--) {
-			ret = emac_rx_packet(emac, flow);
+			ret = emac_rx_packet(emac, flow, &xdp_state);
+			xdp_state_or |= xdp_state;
 			if (ret)
 				break;
 			num_rx++;
@@ -922,6 +1112,9 @@ int icssg_napi_rx_poll(struct napi_struct *napi_rx, int budget)
 			break;
 	}
 
+	if (xdp_state_or & ICSSG_XDP_REDIR)
+		xdp_do_flush();
+
 	if (num_rx < budget && napi_complete_done(napi_rx, num_rx)) {
 		if (unlikely(emac->rx_pace_timeout_ns)) {
 			hrtimer_start(&emac->rx_hrtimer,
diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
index 3ff8c322f9d9..1acbf9e1bade 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
@@ -559,6 +559,33 @@ const struct icss_iep_clockops prueth_iep_clockops = {
 	.perout_enable = prueth_perout_enable,
 };
 
+static int prueth_create_xdp_rxqs(struct prueth_emac *emac)
+{
+	struct xdp_rxq_info *rxq = &emac->rx_chns.xdp_rxq;
+	struct page_pool *pool = emac->rx_chns.pg_pool;
+	int ret;
+
+	ret = xdp_rxq_info_reg(rxq, emac->ndev, 0, emac->napi_rx.napi_id);
+	if (ret)
+		return ret;
+
+	ret = xdp_rxq_info_reg_mem_model(rxq, MEM_TYPE_PAGE_POOL, pool);
+	if (ret)
+		xdp_rxq_info_unreg(rxq);
+
+	return ret;
+}
+
+static void prueth_destroy_xdp_rxqs(struct prueth_emac *emac)
+{
+	struct xdp_rxq_info *rxq = &emac->rx_chns.xdp_rxq;
+
+	if (!xdp_rxq_info_is_reg(rxq))
+		return;
+
+	xdp_rxq_info_unreg(rxq);
+}
+
 static int icssg_prueth_add_mcast(struct net_device *ndev, const u8 *addr)
 {
 	struct net_device *real_dev;
@@ -780,10 +807,14 @@ static int emac_ndo_open(struct net_device *ndev)
 	if (ret)
 		goto free_tx_ts_irq;
 
-	ret = k3_udma_glue_enable_rx_chn(emac->rx_chns.rx_chn);
+	ret = prueth_create_xdp_rxqs(emac);
 	if (ret)
 		goto reset_rx_chn;
 
+	ret = k3_udma_glue_enable_rx_chn(emac->rx_chns.rx_chn);
+	if (ret)
+		goto destroy_xdp_rxqs;
+
 	for (i = 0; i < emac->tx_ch_num; i++) {
 		ret = k3_udma_glue_enable_tx_chn(emac->tx_chns[i].tx_chn);
 		if (ret)
@@ -809,6 +840,8 @@ static int emac_ndo_open(struct net_device *ndev)
 	 * any SKB for completion. So set false to free_skb
 	 */
 	prueth_reset_tx_chan(emac, i, false);
+destroy_xdp_rxqs:
+	prueth_destroy_xdp_rxqs(emac);
 reset_rx_chn:
 	prueth_reset_rx_chan(&emac->rx_chns, max_rx_flows, false);
 free_tx_ts_irq:
@@ -879,7 +912,7 @@ static int emac_ndo_stop(struct net_device *ndev)
 	k3_udma_glue_tdown_rx_chn(emac->rx_chns.rx_chn, true);
 
 	prueth_reset_rx_chan(&emac->rx_chns, max_rx_flows, true);
-
+	prueth_destroy_xdp_rxqs(emac);
 	napi_disable(&emac->napi_rx);
 	hrtimer_cancel(&emac->rx_hrtimer);
 
@@ -1024,6 +1057,90 @@ static int emac_ndo_vlan_rx_del_vid(struct net_device *ndev,
 	return 0;
 }
 
+/**
+ * emac_xdp_xmit - Implements ndo_xdp_xmit
+ * @dev: netdev
+ * @n: number of frames
+ * @frames: array of XDP buffer pointers
+ * @flags: XDP extra info
+ *
+ * Return: number of frames successfully sent. Failed frames
+ * will be free'ed by XDP core.
+ *
+ * For error cases, a negative errno code is returned and no-frames
+ * are transmitted (caller must handle freeing frames).
+ **/
+static int emac_xdp_xmit(struct net_device *dev, int n, struct xdp_frame **frames,
+			 u32 flags)
+{
+	struct prueth_emac *emac = netdev_priv(dev);
+	unsigned int q_idx;
+	int nxmit = 0;
+	int i;
+
+	q_idx = smp_processor_id() % emac->tx_ch_num;
+
+	if (unlikely(flags & ~XDP_XMIT_FLAGS_MASK))
+		return -EINVAL;
+
+	for (i = 0; i < n; i++) {
+		struct xdp_frame *xdpf = frames[i];
+		int err;
+
+		err = emac_xmit_xdp_frame(emac, xdpf, NULL, q_idx);
+		if (err != ICSSG_XDP_TX)
+			break;
+		nxmit++;
+	}
+
+	return nxmit;
+}
+
+/**
+ * emac_xdp_setup - add/remove an XDP program
+ * @emac: emac device
+ * @bpf: XDP program
+ *
+ * Return: Always 0 (Success)
+ **/
+static int emac_xdp_setup(struct prueth_emac *emac, struct netdev_bpf *bpf)
+{
+	struct bpf_prog *prog = bpf->prog;
+	xdp_features_t val;
+
+	val = NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRECT |
+	      NETDEV_XDP_ACT_NDO_XMIT;
+	xdp_set_features_flag(emac->ndev, val);
+
+	if (!emac->xdpi.prog && !prog)
+		return 0;
+
+	WRITE_ONCE(emac->xdp_prog, prog);
+
+	xdp_attachment_setup(&emac->xdpi, bpf);
+
+	return 0;
+}
+
+/**
+ * emac_ndo_bpf - implements ndo_bpf for icssg_prueth
+ * @ndev: network adapter device
+ * @bpf: XDP program
+ *
+ * Return: 0 on success, error code on failure.
+ **/
+static int emac_ndo_bpf(struct net_device *ndev, struct netdev_bpf *bpf)
+{
+	struct prueth_emac *emac = netdev_priv(ndev);
+
+	switch (bpf->command) {
+	case XDP_SETUP_PROG:
+		return emac_xdp_setup(emac, bpf);
+	default:
+		return -EINVAL;
+	}
+}
+
 static const struct net_device_ops emac_netdev_ops = {
 	.ndo_open = emac_ndo_open,
 	.ndo_stop = emac_ndo_stop,
@@ -1038,6 +1155,8 @@ static const struct net_device_ops emac_netdev_ops = {
 	.ndo_fix_features = emac_ndo_fix_features,
 	.ndo_vlan_rx_add_vid = emac_ndo_vlan_rx_add_vid,
 	.ndo_vlan_rx_kill_vid = emac_ndo_vlan_rx_del_vid,
+	.ndo_bpf = emac_ndo_bpf,
+	.ndo_xdp_xmit = emac_xdp_xmit,
 };
 
 static int prueth_netdev_init(struct prueth *prueth,
@@ -1066,6 +1185,8 @@ static int prueth_netdev_init(struct prueth *prueth,
 	emac->prueth = prueth;
 	emac->ndev = ndev;
 	emac->port_id = port;
+	emac->xdp_prog = NULL;
+	emac->ndev->pcpu_stat_type = NETDEV_PCPU_STAT_TSTATS;
 	emac->cmd_wq = create_singlethread_workqueue("icssg_cmd_wq");
 	if (!emac->cmd_wq) {
 		ret = -ENOMEM;
diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.h b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
index 3bbabd007129..0675919beb94 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.h
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
@@ -8,6 +8,8 @@
 #ifndef __NET_TI_ICSSG_PRUETH_H
 #define __NET_TI_ICSSG_PRUETH_H
 
+#include <linux/bpf.h>
+#include <linux/bpf_trace.h>
 #include <linux/etherdevice.h>
 #include <linux/genalloc.h>
 #include <linux/if_vlan.h>
@@ -134,6 +136,7 @@ struct prueth_rx_chn {
 	unsigned int irq[ICSSG_MAX_RFLOWS];	/* separate irq per flow */
 	char name[32];
 	struct page_pool *pg_pool;
+	struct xdp_rxq_info xdp_rxq;
 };
 
 enum prueth_swdata_type {
@@ -141,6 +144,7 @@ enum prueth_swdata_type {
 	PRUETH_SWDATA_SKB,
 	PRUETH_SWDATA_PAGE,
 	PRUETH_SWDATA_CMD,
+	PRUETH_SWDATA_XDPF,
 };
 
 struct prueth_swdata {
@@ -149,6 +153,7 @@ struct prueth_swdata {
 		struct sk_buff *skb;
 		struct page *page;
 		u32 cmd;
+		struct xdp_frame *xdpf;
 	} data;
 };
 
@@ -159,6 +164,12 @@ struct prueth_swdata {
 
 #define PRUETH_MAX_TX_TS_REQUESTS	50 /* Max simultaneous TX_TS requests */
 
+/* XDP BPF state */
+#define ICSSG_XDP_PASS           0
+#define ICSSG_XDP_CONSUMED       BIT(0)
+#define ICSSG_XDP_TX             BIT(1)
+#define ICSSG_XDP_REDIR          BIT(2)
+
 /* Minimum coalesce time in usecs for both Tx and Rx */
 #define ICSSG_MIN_COALESCE_USECS 20
 
@@ -227,6 +238,8 @@ struct prueth_emac {
 	unsigned long rx_pace_timeout_ns;
 
 	struct netdev_hw_addr_list vlan_mcast_list[MAX_VLAN_ID];
+	struct bpf_prog *xdp_prog;
+	struct xdp_attachment_info xdpi;
 };
 
 /* The buf includes headroom compatible with both skb and xdpf */
@@ -465,5 +478,9 @@ void prueth_put_cores(struct prueth *prueth, int slice);
 
 /* Revision specific helper */
 u64 icssg_ts_to_ns(u32 hi_sw, u32 hi, u32 lo, u32 cycle_time_ns);
+int emac_xmit_xdp_frame(struct prueth_emac *emac,
+			struct xdp_frame *xdpf,
+			struct page *page,
+			unsigned int q_idx);
 
 #endif /* __NET_TI_ICSSG_PRUETH_H */
-- 
2.43.0


