Return-Path: <bpf+bounces-53303-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 05483A4FB80
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 11:16:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F22A18930D3
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 10:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE7C9207DF5;
	Wed,  5 Mar 2025 10:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="S8BMwjIo"
X-Original-To: bpf@vger.kernel.org
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27CAD2066D9;
	Wed,  5 Mar 2025 10:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741169731; cv=none; b=SwH4g+6SJv4ETo/smh2ixHMqzYqlvqd3cOUzyzvBowbVID0sIZhKbv1qIv6/w/74LLz1Vjm7y0AGRmHu3HixnMb4qUzFX0on4nY5sT+16wSmmCHMo0OTnz/xVco3lluLZi2uRhf09xrz1jX/j+pDzN6BQVbjnqcuch8lyktmMcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741169731; c=relaxed/simple;
	bh=0Mez4h6v+qVY7DgvnHeg7RRwYZ2nkobNOy9DgfG3sGM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=urgl9lC7dIgwyDkDpQvZ+9UqEXnnZD5NRrkiLZyo3ugE6jb4mp1a3HE2tR00FgxqYrpZNTMCMzSRtOB3SRm50SUhRGT3wo402siZpIF8aXI2bt0whJUwwcQSIwKKLTt999JlyAWGwD46wWqUfIGu7CYjPaSZrW80Xtyh5RgaDxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=S8BMwjIo; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 525AEasi3365532
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Mar 2025 04:14:36 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1741169676;
	bh=46R3UjR8U080i9lalYTR+/jDd0aKmnmmB/pxW+KPQGE=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=S8BMwjIosw6i9LWbpvSgiG1qla6WpyocNO2iebRIIH5TsjOjRlq4yi2s2C2gasHcK
	 V4EhCCrkoOi31lzlX5USasoPBSKr48PGKC2uhzC9AIby3iiWCOd7NO25kQ4QYF1Sg7
	 bxtVCUN8vf9z/20VGRe5l9pTMCYVw8+2kRIWZXLA=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 525AEaxs005493
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 5 Mar 2025 04:14:36 -0600
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 5
 Mar 2025 04:14:35 -0600
Received: from fllvsmtp8.itg.ti.com (10.64.41.158) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 5 Mar 2025 04:14:35 -0600
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
	by fllvsmtp8.itg.ti.com (8.15.2/8.15.2) with ESMTP id 525AEZQe130438;
	Wed, 5 Mar 2025 04:14:35 -0600
Received: from localhost (meghana-pc.dhcp.ti.com [10.24.69.13] (may be forged))
	by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 525AEYeI005841;
	Wed, 5 Mar 2025 04:14:35 -0600
From: Meghana Malladi <m-malladi@ti.com>
To: <rogerq@kernel.org>, <danishanwar@ti.com>, <pabeni@redhat.com>,
        <kuba@kernel.org>, <edumazet@google.com>, <davem@davemloft.net>,
        <andrew+netdev@lunn.ch>
CC: <bpf@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <matthias.schiffer@ew.tq-group.com>, <krzysztof.kozlowski@linaro.org>,
        <dan.carpenter@linaro.org>, <m-malladi@ti.com>,
        <diogo.ivo@siemens.com>, <s.hauer@pengutronix.de>,
        <glaroque@baylibre.com>, <schnelle@linux.ibm.com>, <arnd@kernel.org>,
        <john.fastabend@gmail.com>, <hawk@kernel.org>, <daniel@iogearbox.net>,
        <ast@kernel.org>, <srk@ti.com>, Vignesh Raghavendra
	<vigneshr@ti.com>
Subject: [PATCH net-next v4 3/3] net: ti: icssg-prueth: Add XDP support
Date: Wed, 5 Mar 2025 15:44:22 +0530
Message-ID: <20250305101422.1908370-4-m-malladi@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250305101422.1908370-1-m-malladi@ti.com>
References: <20250305101422.1908370-1-m-malladi@ti.com>
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
Changes from v3 (v4-v3):
- few cosmetic changes inside emac_xmit_xdp_frame() func
- change xdp_state type to u32 from int
Above changes are suggested by Dan Carpenter <dan.carpenter@linaro.org>
- Few improvements in emac_run_xdp case handling as suggested by 
Roger Quadros <rogerq@kernel.org>

 drivers/net/ethernet/ti/icssg/icssg_common.c | 225 +++++++++++++++++--
 drivers/net/ethernet/ti/icssg/icssg_prueth.c | 128 ++++++++++-
 drivers/net/ethernet/ti/icssg/icssg_prueth.h |  17 ++
 3 files changed, 355 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/ti/icssg/icssg_common.c b/drivers/net/ethernet/ti/icssg/icssg_common.c
index fee1204db367..df5da7a98abf 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_common.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_common.c
@@ -98,11 +98,20 @@ void prueth_xmit_free(struct prueth_tx_chn *tx_chn,
 {
 	struct cppi5_host_desc_t *first_desc, *next_desc;
 	dma_addr_t buf_dma, next_desc_dma;
+	struct prueth_swdata *swdata;
+	struct page *page;
 	u32 buf_dma_len;
 
 	first_desc = desc;
 	next_desc = first_desc;
 
+	swdata = cppi5_hdesc_get_swdata(desc);
+	if (swdata->type == PRUETH_SWDATA_PAGE) {
+		page = swdata->data.page;
+		page_pool_recycle_direct(page->pp, swdata->data.page);
+		goto free_desc;
+	}
+
 	cppi5_hdesc_get_obuf(first_desc, &buf_dma, &buf_dma_len);
 	k3_udma_glue_tx_cppi5_to_dma_addr(tx_chn->tx_chn, &buf_dma);
 
@@ -126,6 +135,7 @@ void prueth_xmit_free(struct prueth_tx_chn *tx_chn,
 		k3_cppi_desc_pool_free(tx_chn->desc_pool, next_desc);
 	}
 
+free_desc:
 	k3_cppi_desc_pool_free(tx_chn->desc_pool, first_desc);
 }
 EXPORT_SYMBOL_GPL(prueth_xmit_free);
@@ -139,6 +149,7 @@ int emac_tx_complete_packets(struct prueth_emac *emac, int chn,
 	struct prueth_swdata *swdata;
 	struct prueth_tx_chn *tx_chn;
 	unsigned int total_bytes = 0;
+	struct xdp_frame *xdpf;
 	struct sk_buff *skb;
 	dma_addr_t desc_dma;
 	int res, num_tx = 0;
@@ -161,16 +172,28 @@ int emac_tx_complete_packets(struct prueth_emac *emac, int chn,
 		desc_tx = k3_cppi_desc_pool_dma2virt(tx_chn->desc_pool,
 						     desc_dma);
 		swdata = cppi5_hdesc_get_swdata(desc_tx);
-		prueth_xmit_free(tx_chn, desc_tx);
-		if (swdata->type != PRUETH_SWDATA_SKB)
+
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
+			netdev_err(ndev, "tx_complete: invalid swdata type %d\n", swdata->type);
+			prueth_xmit_free(tx_chn, desc_tx);
+			ndev->stats.tx_dropped++;
 			continue;
+		}
 
-		skb = swdata->data.skb;
-		ndev = skb->dev;
-		ndev->stats.tx_packets++;
-		ndev->stats.tx_bytes += skb->len;
-		total_bytes += skb->len;
-		napi_consume_skb(skb, budget);
+		prueth_xmit_free(tx_chn, desc_tx);
 		num_tx++;
 	}
 
@@ -529,7 +552,153 @@ void emac_rx_timestamp(struct prueth_emac *emac,
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
+u32 emac_xmit_xdp_frame(struct prueth_emac *emac,
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
+		buf_dma = dma_map_single(tx_chn->dma_dev, xdpf->data, xdpf->len, DMA_TO_DEVICE);
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
+	cppi5_hdesc_attach_buf(first_desc, buf_dma, xdpf->len, buf_dma, xdpf->len);
+	swdata = cppi5_hdesc_get_swdata(first_desc);
+	if (page) {
+		swdata->type = PRUETH_SWDATA_PAGE;
+		swdata->data.page = page;
+	} else {
+		swdata->type = PRUETH_SWDATA_XDPF;
+		swdata->data.xdpf = xdpf;
+	}
+
+	cppi5_hdesc_set_pktlen(first_desc, xdpf->len);
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
+ * @len: Rx descriptor packet length
+ *
+ * Return: XDP state
+ */
+static u32 emac_run_xdp(struct prueth_emac *emac, struct xdp_buff *xdp,
+			struct page *page, u32 *len)
+{
+	struct net_device *ndev = emac->ndev;
+	struct bpf_prog *xdp_prog;
+	struct xdp_frame *xdpf;
+	u32 pkt_len = *len;
+	u32 act, result;
+	int q_idx, err;
+
+	xdp_prog = READ_ONCE(emac->xdp_prog);
+	act = bpf_prog_run_xdp(xdp_prog, xdp);
+	switch (act) {
+	case XDP_PASS:
+		return ICSSG_XDP_PASS;
+	case XDP_TX:
+		/* Send packet to TX ring for immediate transmission */
+		xdpf = xdp_convert_buff_to_frame(xdp);
+		if (unlikely(!xdpf)) {
+			ndev->stats.tx_dropped++;
+			goto drop;
+		}
+
+		q_idx = smp_processor_id() % emac->tx_ch_num;
+		result = emac_xmit_xdp_frame(emac, xdpf, page, q_idx);
+		if (result == ICSSG_XDP_CONSUMED)
+			goto drop;
+
+		dev_sw_netstats_rx_add(ndev, xdpf->len);
+		return result;
+	case XDP_REDIRECT:
+		err = xdp_do_redirect(emac->ndev, xdp, xdp_prog);
+		if (err)
+			goto drop;
+
+		dev_sw_netstats_rx_add(ndev, pkt_len);
+		return ICSSG_XDP_REDIR;
+	default:
+		bpf_warn_invalid_xdp_action(emac->ndev, xdp_prog, act);
+		fallthrough;
+	case XDP_ABORTED:
+drop:
+		trace_xdp_exception(emac->ndev, xdp_prog, act);
+		fallthrough; /* handle aborts by dropping packet */
+	case XDP_DROP:
+		ndev->stats.rx_dropped++;
+		page_pool_recycle_direct(emac->rx_chns.pg_pool, page);
+		return ICSSG_XDP_CONSUMED;
+	}
+}
+
+static int emac_rx_packet(struct prueth_emac *emac, u32 flow_id, u32 *xdp_state)
 {
 	struct prueth_rx_chn *rx_chn = &emac->rx_chns;
 	u32 buf_dma_len, pkt_len, port_id = 0;
@@ -540,10 +709,12 @@ static int emac_rx_packet(struct prueth_emac *emac, u32 flow_id)
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
@@ -584,9 +755,21 @@ static int emac_rx_packet(struct prueth_emac *emac, u32 flow_id)
 		goto requeue;
 	}
 
-	/* prepare skb and send to n/w stack */
 	pa = page_address(page);
-	skb = napi_build_skb(pa, PAGE_SIZE);
+	if (emac->xdp_prog) {
+		xdp_init_buff(&xdp, PAGE_SIZE, &rx_chn->xdp_rxq);
+		xdp_prepare_buff(&xdp, pa, PRUETH_HEADROOM, pkt_len, false);
+
+		*xdp_state = emac_run_xdp(emac, &xdp, page, &pkt_len);
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
@@ -849,13 +1032,23 @@ static void prueth_tx_cleanup(void *data, dma_addr_t desc_dma)
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
@@ -892,15 +1085,18 @@ int icssg_napi_rx_poll(struct napi_struct *napi_rx, int budget)
 		PRUETH_RX_FLOW_DATA_SR1 : PRUETH_RX_FLOW_DATA;
 	int flow = emac->is_sr1 ?
 		PRUETH_MAX_RX_FLOWS_SR1 : PRUETH_MAX_RX_FLOWS;
+	int xdp_state_or = 0;
 	int num_rx = 0;
 	int cur_budget;
+	u32 xdp_state;
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
@@ -910,6 +1106,9 @@ int icssg_napi_rx_poll(struct napi_struct *napi_rx, int budget)
 			break;
 	}
 
+	if (xdp_state_or & ICSSG_XDP_REDIR)
+		xdp_do_flush();
+
 	if (num_rx < budget && napi_complete_done(napi_rx, num_rx)) {
 		if (unlikely(emac->rx_pace_timeout_ns)) {
 			hrtimer_start(&emac->rx_hrtimer,
diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
index 3ff8c322f9d9..c4a995630eca 100644
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
 
@@ -1024,6 +1057,93 @@ static int emac_ndo_vlan_rx_del_vid(struct net_device *ndev,
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
+	struct net_device *ndev = emac->ndev;
+	struct xdp_frame *xdpf;
+	unsigned int q_idx;
+	int nxmit = 0;
+	u32 err;
+	int i;
+
+	q_idx = smp_processor_id() % emac->tx_ch_num;
+
+	if (unlikely(flags & ~XDP_XMIT_FLAGS_MASK))
+		return -EINVAL;
+
+	for (i = 0; i < n; i++) {
+		xdpf = frames[i];
+		err = emac_xmit_xdp_frame(emac, xdpf, NULL, q_idx);
+		if (err != ICSSG_XDP_TX) {
+			ndev->stats.tx_dropped++;
+			break;
+		}
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
@@ -1038,6 +1158,8 @@ static const struct net_device_ops emac_netdev_ops = {
 	.ndo_fix_features = emac_ndo_fix_features,
 	.ndo_vlan_rx_add_vid = emac_ndo_vlan_rx_add_vid,
 	.ndo_vlan_rx_kill_vid = emac_ndo_vlan_rx_del_vid,
+	.ndo_bpf = emac_ndo_bpf,
+	.ndo_xdp_xmit = emac_xdp_xmit,
 };
 
 static int prueth_netdev_init(struct prueth *prueth,
@@ -1066,6 +1188,8 @@ static int prueth_netdev_init(struct prueth *prueth,
 	emac->prueth = prueth;
 	emac->ndev = ndev;
 	emac->port_id = port;
+	emac->xdp_prog = NULL;
+	emac->ndev->pcpu_stat_type = NETDEV_PCPU_STAT_TSTATS;
 	emac->cmd_wq = create_singlethread_workqueue("icssg_cmd_wq");
 	if (!emac->cmd_wq) {
 		ret = -ENOMEM;
diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.h b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
index 3bbabd007129..1dd76e2adfcd 100644
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
+u32 emac_xmit_xdp_frame(struct prueth_emac *emac,
+			struct xdp_frame *xdpf,
+			struct page *page,
+			unsigned int q_idx);
 
 #endif /* __NET_TI_ICSSG_PRUETH_H */
-- 
2.43.0


