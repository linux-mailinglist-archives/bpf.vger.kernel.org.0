Return-Path: <bpf+bounces-53301-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3144BA4FB78
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 11:15:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 810BE189279F
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 10:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94599206F1B;
	Wed,  5 Mar 2025 10:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="fD/zMfzm"
X-Original-To: bpf@vger.kernel.org
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5ED2063ED;
	Wed,  5 Mar 2025 10:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741169717; cv=none; b=n7vYkUELbybQG3xmuk6/W9udCWUnhFCqXod9aLFOZn4xWZN0l8LQScBdcSWe/EFAZZ7MUOFtmcDBAO8s1OUybiCNgQvZLojILm7Cbp5jS5PMIAwrhw66JEKtuIIuPcE8LF7a7DPcLxa3chQ1gGMPf//tvTzvuHlgyqvUJzu4DnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741169717; c=relaxed/simple;
	bh=IYGeX6wCtPvsVRSGdW3NGvekk0z55XEcxkrzbrxzQaE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ejEhICdzjTcOUg34fDtZvDuE5eRDrbzMPylMrAJxksZx8UO9C0kChqqIFzhfXKrFX4i9zVet52WaBgqGaySggUJ+A2dJTFtJmPWu8hDiiKMCMWZBw32FWSLidsKkpDukQqcO+69GQXSZwCxXnyq6ASc3pS9cp1olFixxfjH9TzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=fD/zMfzm; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 525AEXJD3282315
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Mar 2025 04:14:33 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1741169673;
	bh=WKe8i56YW9+FKurGjSLcFKVh/d3KB3RrqZMs1az8ESg=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=fD/zMfzmSo5ULO8LQg7Pnq8m4sDPbrfcLvw8jCdgnRiEbCw/5x0anco2yrdINPgJ0
	 6ZMelgt6butc9NHZj2pZdcYISBvOsjgYTLzSeWGj1sCabPsiWJXbrl7mg8SyqosxSB
	 6z8PXh5Y+IluqlHhEDFGVTyA+rloCUVuYoVaWjTw=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 525AEXpF005480
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 5 Mar 2025 04:14:33 -0600
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 5
 Mar 2025 04:14:33 -0600
Received: from fllvsmtp8.itg.ti.com (10.64.41.158) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 5 Mar 2025 04:14:32 -0600
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
	by fllvsmtp8.itg.ti.com (8.15.2/8.15.2) with ESMTP id 525AEWDp130413;
	Wed, 5 Mar 2025 04:14:32 -0600
Received: from localhost (meghana-pc.dhcp.ti.com [10.24.69.13] (may be forged))
	by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 525AEWKw005834;
	Wed, 5 Mar 2025 04:14:32 -0600
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
Subject: [PATCH net-next v4 2/3] net: ti: icssg-prueth: introduce and use prueth_swdata struct for SWDATA
Date: Wed, 5 Mar 2025 15:44:21 +0530
Message-ID: <20250305101422.1908370-3-m-malladi@ti.com>
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

We have different cases for SWDATA (skb, page, cmd, etc)
so it is better to have a dedicated data structure for that.
We can embed the type field inside the struct and use it
to interpret the data in completion handlers.

Signed-off-by: Roger Quadros <rogerq@kernel.org>
Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
Signed-off-by: Meghana Malladi <m-malladi@ti.com>
---
Changes from v3 (v4-v3):
- remove SWDATA size information from commit message
- Fix handling of packets for non-skb type inside emac_tx_complete_packets()
- Remove incrementing budget for incorrect swdata type
- use PRUETH_SWDATA_CMD in emac_send_command_sr1()
All the above changes are suggested by Roger Quadros <rogerq@kernel.org> and
Dan Carpenter <dan.carpenter@linaro.org>

 drivers/net/ethernet/ti/icssg/icssg_common.c  | 52 +++++++++++--------
 drivers/net/ethernet/ti/icssg/icssg_prueth.c  |  3 ++
 drivers/net/ethernet/ti/icssg/icssg_prueth.h  | 16 ++++++
 .../net/ethernet/ti/icssg/icssg_prueth_sr1.c  |  9 ++--
 4 files changed, 54 insertions(+), 26 deletions(-)

diff --git a/drivers/net/ethernet/ti/icssg/icssg_common.c b/drivers/net/ethernet/ti/icssg/icssg_common.c
index acbb79ad8b0c..fee1204db367 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_common.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_common.c
@@ -136,12 +136,12 @@ int emac_tx_complete_packets(struct prueth_emac *emac, int chn,
 	struct net_device *ndev = emac->ndev;
 	struct cppi5_host_desc_t *desc_tx;
 	struct netdev_queue *netif_txq;
+	struct prueth_swdata *swdata;
 	struct prueth_tx_chn *tx_chn;
 	unsigned int total_bytes = 0;
 	struct sk_buff *skb;
 	dma_addr_t desc_dma;
 	int res, num_tx = 0;
-	void **swdata;
 
 	tx_chn = &emac->tx_chns[chn];
 
@@ -161,16 +161,11 @@ int emac_tx_complete_packets(struct prueth_emac *emac, int chn,
 		desc_tx = k3_cppi_desc_pool_dma2virt(tx_chn->desc_pool,
 						     desc_dma);
 		swdata = cppi5_hdesc_get_swdata(desc_tx);
-
-		/* was this command's TX complete? */
-		if (emac->is_sr1 && *(swdata) == emac->cmd_data) {
-			prueth_xmit_free(tx_chn, desc_tx);
-			continue;
-		}
-
-		skb = *(swdata);
 		prueth_xmit_free(tx_chn, desc_tx);
+		if (swdata->type != PRUETH_SWDATA_SKB)
+			continue;
 
+		skb = swdata->data.skb;
 		ndev = skb->dev;
 		ndev->stats.tx_packets++;
 		ndev->stats.tx_bytes += skb->len;
@@ -472,9 +467,9 @@ int prueth_dma_rx_push_mapped(struct prueth_emac *emac,
 {
 	struct net_device *ndev = emac->ndev;
 	struct cppi5_host_desc_t *desc_rx;
+	struct prueth_swdata *swdata;
 	dma_addr_t desc_dma;
 	dma_addr_t buf_dma;
-	void **swdata;
 
 	buf_dma = page_pool_get_dma_addr(page) + PRUETH_HEADROOM;
 	desc_rx = k3_cppi_desc_pool_alloc(rx_chn->desc_pool);
@@ -490,7 +485,8 @@ int prueth_dma_rx_push_mapped(struct prueth_emac *emac,
 	cppi5_hdesc_attach_buf(desc_rx, buf_dma, buf_len, buf_dma, buf_len);
 
 	swdata = cppi5_hdesc_get_swdata(desc_rx);
-	*swdata = page;
+	swdata->type = PRUETH_SWDATA_PAGE;
+	swdata->data.page = page;
 
 	return k3_udma_glue_push_rx_chn(rx_chn->rx_chn, PRUETH_RX_FLOW_DATA,
 					desc_rx, desc_dma);
@@ -539,11 +535,11 @@ static int emac_rx_packet(struct prueth_emac *emac, u32 flow_id)
 	u32 buf_dma_len, pkt_len, port_id = 0;
 	struct net_device *ndev = emac->ndev;
 	struct cppi5_host_desc_t *desc_rx;
+	struct prueth_swdata *swdata;
 	dma_addr_t desc_dma, buf_dma;
 	struct page *page, *new_page;
 	struct page_pool *pool;
 	struct sk_buff *skb;
-	void **swdata;
 	u32 *psdata;
 	void *pa;
 	int ret;
@@ -561,7 +557,13 @@ static int emac_rx_packet(struct prueth_emac *emac, u32 flow_id)
 
 	desc_rx = k3_cppi_desc_pool_dma2virt(rx_chn->desc_pool, desc_dma);
 	swdata = cppi5_hdesc_get_swdata(desc_rx);
-	page = *swdata;
+	if (swdata->type != PRUETH_SWDATA_PAGE) {
+		netdev_err(ndev, "rx_pkt: invalid swdata->type %d\n", swdata->type);
+		k3_cppi_desc_pool_free(rx_chn->desc_pool, desc_rx);
+		return 0;
+	}
+
+	page = swdata->data.page;
 	page_pool_dma_sync_for_cpu(pool, page, 0, PAGE_SIZE);
 	cppi5_hdesc_get_obuf(desc_rx, &buf_dma, &buf_dma_len);
 	k3_udma_glue_rx_cppi5_to_dma_addr(rx_chn->rx_chn, &buf_dma);
@@ -626,15 +628,18 @@ static void prueth_rx_cleanup(void *data, dma_addr_t desc_dma)
 {
 	struct prueth_rx_chn *rx_chn = data;
 	struct cppi5_host_desc_t *desc_rx;
+	struct prueth_swdata *swdata;
 	struct page_pool *pool;
 	struct page *page;
-	void **swdata;
 
 	pool = rx_chn->pg_pool;
 	desc_rx = k3_cppi_desc_pool_dma2virt(rx_chn->desc_pool, desc_dma);
 	swdata = cppi5_hdesc_get_swdata(desc_rx);
-	page = *swdata;
-	page_pool_recycle_direct(pool, page);
+	if (swdata->type == PRUETH_SWDATA_PAGE) {
+		page = swdata->data.page;
+		page_pool_recycle_direct(pool, page);
+	}
+
 	k3_cppi_desc_pool_free(rx_chn->desc_pool, desc_rx);
 }
 
@@ -671,13 +676,13 @@ enum netdev_tx icssg_ndo_start_xmit(struct sk_buff *skb, struct net_device *ndev
 	struct prueth_emac *emac = netdev_priv(ndev);
 	struct prueth *prueth = emac->prueth;
 	struct netdev_queue *netif_txq;
+	struct prueth_swdata *swdata;
 	struct prueth_tx_chn *tx_chn;
 	dma_addr_t desc_dma, buf_dma;
 	u32 pkt_len, dst_tag_id;
 	int i, ret = 0, q_idx;
 	bool in_tx_ts = 0;
 	int tx_ts_cookie;
-	void **swdata;
 	u32 *epib;
 
 	pkt_len = skb_headlen(skb);
@@ -739,7 +744,8 @@ enum netdev_tx icssg_ndo_start_xmit(struct sk_buff *skb, struct net_device *ndev
 	k3_udma_glue_tx_dma_to_cppi5_addr(tx_chn->tx_chn, &buf_dma);
 	cppi5_hdesc_attach_buf(first_desc, buf_dma, pkt_len, buf_dma, pkt_len);
 	swdata = cppi5_hdesc_get_swdata(first_desc);
-	*swdata = skb;
+	swdata->type = PRUETH_SWDATA_SKB;
+	swdata->data.skb = skb;
 
 	/* Handle the case where skb is fragmented in pages */
 	cur_desc = first_desc;
@@ -842,15 +848,17 @@ static void prueth_tx_cleanup(void *data, dma_addr_t desc_dma)
 {
 	struct prueth_tx_chn *tx_chn = data;
 	struct cppi5_host_desc_t *desc_tx;
+	struct prueth_swdata *swdata;
 	struct sk_buff *skb;
-	void **swdata;
 
 	desc_tx = k3_cppi_desc_pool_dma2virt(tx_chn->desc_pool, desc_dma);
 	swdata = cppi5_hdesc_get_swdata(desc_tx);
-	skb = *(swdata);
-	prueth_xmit_free(tx_chn, desc_tx);
+	if (swdata->type == PRUETH_SWDATA_SKB) {
+		skb = swdata->data.skb;
+		dev_kfree_skb_any(skb);
+	}
 
-	dev_kfree_skb_any(skb);
+	prueth_xmit_free(tx_chn, desc_tx);
 }
 
 irqreturn_t prueth_rx_irq(int irq, void *dev_id)
diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
index 00ed97860547..3ff8c322f9d9 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
@@ -1522,6 +1522,9 @@ static int prueth_probe(struct platform_device *pdev)
 
 	np = dev->of_node;
 
+	BUILD_BUG_ON_MSG((sizeof(struct prueth_swdata) > PRUETH_NAV_SW_DATA_SIZE),
+			 "insufficient SW_DATA size");
+
 	prueth = devm_kzalloc(dev, sizeof(*prueth), GFP_KERNEL);
 	if (!prueth)
 		return -ENOMEM;
diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.h b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
index c7b906de18af..3bbabd007129 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.h
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
@@ -136,6 +136,22 @@ struct prueth_rx_chn {
 	struct page_pool *pg_pool;
 };
 
+enum prueth_swdata_type {
+	PRUETH_SWDATA_INVALID = 0,
+	PRUETH_SWDATA_SKB,
+	PRUETH_SWDATA_PAGE,
+	PRUETH_SWDATA_CMD,
+};
+
+struct prueth_swdata {
+	enum prueth_swdata_type type;
+	union prueth_data {
+		struct sk_buff *skb;
+		struct page *page;
+		u32 cmd;
+	} data;
+};
+
 /* There are 4 Tx DMA channels, but the highest priority is CH3 (thread 3)
  * and lower three are lower priority channels or threads.
  */
diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c b/drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c
index 8f5719a98614..ff5f41bf499e 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c
@@ -84,7 +84,7 @@ static int emac_send_command_sr1(struct prueth_emac *emac, u32 cmd)
 	__le32 *data = emac->cmd_data;
 	dma_addr_t desc_dma, buf_dma;
 	struct prueth_tx_chn *tx_chn;
-	void **swdata;
+	struct prueth_swdata *swdata;
 	int ret = 0;
 	u32 *epib;
 
@@ -122,7 +122,8 @@ static int emac_send_command_sr1(struct prueth_emac *emac, u32 cmd)
 
 	cppi5_hdesc_attach_buf(first_desc, buf_dma, pkt_len, buf_dma, pkt_len);
 	swdata = cppi5_hdesc_get_swdata(first_desc);
-	*swdata = data;
+	swdata->type = PRUETH_SWDATA_CMD;
+	swdata->data.cmd = le32_to_cpu(data[0]);
 
 	cppi5_hdesc_set_pktlen(first_desc, pkt_len);
 	desc_dma = k3_cppi_desc_pool_virt2dma(tx_chn->desc_pool, first_desc);
@@ -275,9 +276,9 @@ static struct page *prueth_process_rx_mgm(struct prueth_emac *emac,
 	struct net_device *ndev = emac->ndev;
 	struct cppi5_host_desc_t *desc_rx;
 	struct page *page, *new_page;
+	struct prueth_swdata *swdata;
 	dma_addr_t desc_dma, buf_dma;
 	u32 buf_dma_len;
-	void **swdata;
 	int ret;
 
 	ret = k3_udma_glue_pop_rx_chn(rx_chn->rx_chn, flow_id, &desc_dma);
@@ -299,7 +300,7 @@ static struct page *prueth_process_rx_mgm(struct prueth_emac *emac,
 	}
 
 	swdata = cppi5_hdesc_get_swdata(desc_rx);
-	page = *swdata;
+	page = swdata->data.page;
 	cppi5_hdesc_get_obuf(desc_rx, &buf_dma, &buf_dma_len);
 
 	dma_unmap_single(rx_chn->dma_dev, buf_dma, buf_dma_len, DMA_FROM_DEVICE);
-- 
2.43.0


