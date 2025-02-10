Return-Path: <bpf+bounces-50953-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 706F2A2E987
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 11:34:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 467E63A4DA4
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 10:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70F251C5F32;
	Mon, 10 Feb 2025 10:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="GSNf8YbI"
X-Original-To: bpf@vger.kernel.org
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00FF117591;
	Mon, 10 Feb 2025 10:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739183684; cv=none; b=TpnHVf6lYUsJ0ehG1uO6RIZ6bIC1Gpv8wsOBb71bTQ5ySCIQ2Dth+SquOl/g/B+QiFb12Vw9kSAOQGLRbI27Bh73lOo7/OufvrZC3eVZy31KbOGPCHpGb9Oq5g8z9l9/d/ntPwdgbAyYNjBuWH6WmaPjsJkprlmX9qMUyGEMryM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739183684; c=relaxed/simple;
	bh=6xhQe58apX1iidhAWVxgEcf4RPIt8ZHWi7vpEI++4pQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gGNWgyDAQqf0DZXe8+BGrPSi83OxaQt6MbTxHtMX56a1w8tcI/7LvFsBbQfC5JA2CLP4bhXuYueBQVYg8TQDphhvO86UDXGfMJHygeuLpZUO4HsS/2mvo8sbFHJeoF29lmuIgjqSP3u/gwHjZeyfCgjdgL6xVXaQl+ismbXp5Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=GSNf8YbI; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 51AAY5Vj3393387
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Feb 2025 04:34:05 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1739183645;
	bh=Sv4b5NVpXzCHisqEvUyRD23v7ufs1KnFG/uyf9a3DXQ=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=GSNf8YbICAVn6Q7vYZf75yUMJUN30n/Bg5jSBe7QxwkC7iAEXRdlWc3vrZJof7fJb
	 KOnHdYSvj/8Mu0STRRKCqaAG5mww9bV/gnSyMLlq1LlnbCEVoJ9jZmobn04YOkajhy
	 XIgyvTNzyesiH30noEWvZmzURP/gFHmsLm/a6TFs=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 51AAY5PF074085
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 10 Feb 2025 04:34:05 -0600
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 10
 Feb 2025 04:34:04 -0600
Received: from fllvsmtp8.itg.ti.com (10.64.41.158) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 10 Feb 2025 04:34:04 -0600
Received: from fllv0122.itg.ti.com (fllv0122.itg.ti.com [10.247.120.72])
	by fllvsmtp8.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51AAY4hp109014;
	Mon, 10 Feb 2025 04:34:04 -0600
Received: from localhost (meghana-pc.dhcp.ti.com [10.24.69.13] (may be forged))
	by fllv0122.itg.ti.com (8.14.7/8.14.7) with ESMTP id 51AAY4BV021838;
	Mon, 10 Feb 2025 04:34:04 -0600
From: Meghana Malladi <m-malladi@ti.com>
To: <rogerq@kernel.org>, <danishanwar@ti.com>, <pabeni@redhat.com>,
        <kuba@kernel.org>, <edumazet@google.com>, <davem@davemloft.net>,
        <andrew+netdev@lunn.ch>
CC: <bpf@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <u.kleine-koenig@baylibre.com>, <krzysztof.kozlowski@linaro.org>,
        <dan.carpenter@linaro.org>, <m-malladi@ti.com>,
        <schnelle@linux.ibm.com>, <glaroque@baylibre.com>,
        <rdunlap@infradead.org>, <diogo.ivo@siemens.com>,
        <jan.kiszka@siemens.com>, <john.fastabend@gmail.com>,
        <hawk@kernel.org>, <daniel@iogearbox.net>, <ast@kernel.org>,
        <srk@ti.com>, Vignesh Raghavendra
	<vigneshr@ti.com>
Subject: [PATCH net-next v2 2/3] net: ti: icssg-prueth: introduce and use prueth_swdata struct for SWDATA
Date: Mon, 10 Feb 2025 16:03:51 +0530
Message-ID: <20250210103352.541052-3-m-malladi@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250210103352.541052-1-m-malladi@ti.com>
References: <20250210103352.541052-1-m-malladi@ti.com>
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

Increase SWDATA size to 48 so we have some room to add
more data if required.

Signed-off-by: Roger Quadros <rogerq@kernel.org>
Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
Signed-off-by: Meghana Malladi <m-malladi@ti.com>
---
v1: https://lore.kernel.org/all/20250122124951.3072410-1-m-malladi@ti.com/

Changes since v1 (v2-v1): None

 drivers/net/ethernet/ti/icssg/icssg_common.c  | 47 ++++++++++++-------
 drivers/net/ethernet/ti/icssg/icssg_config.h  |  2 +-
 drivers/net/ethernet/ti/icssg/icssg_prueth.c  |  6 +++
 drivers/net/ethernet/ti/icssg/icssg_prueth.h  | 18 +++++++
 .../net/ethernet/ti/icssg/icssg_prueth_sr1.c  |  4 +-
 5 files changed, 58 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/ti/icssg/icssg_common.c b/drivers/net/ethernet/ti/icssg/icssg_common.c
index c3c1e2bf461e..a124c5773551 100644
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
 
@@ -163,12 +163,18 @@ int emac_tx_complete_packets(struct prueth_emac *emac, int chn,
 		swdata = cppi5_hdesc_get_swdata(desc_tx);
 
 		/* was this command's TX complete? */
-		if (emac->is_sr1 && *(swdata) == emac->cmd_data) {
+		if (emac->is_sr1 && (void *)(swdata) == emac->cmd_data) {
 			prueth_xmit_free(tx_chn, desc_tx);
 			continue;
 		}
 
-		skb = *(swdata);
+		if (swdata->type != PRUETH_SWDATA_SKB) {
+			netdev_err(ndev, "tx_complete: invalid swdata type %d\n", swdata->type);
+			budget++;
+			continue;
+		}
+
+		skb = swdata->data.skb;
 		prueth_xmit_free(tx_chn, desc_tx);
 
 		ndev = skb->dev;
@@ -472,9 +478,9 @@ int prueth_dma_rx_push_mapped(struct prueth_emac *emac,
 {
 	struct net_device *ndev = emac->ndev;
 	struct cppi5_host_desc_t *desc_rx;
+	struct prueth_swdata *swdata;
 	dma_addr_t desc_dma;
 	dma_addr_t buf_dma;
-	void **swdata;
 
 	buf_dma = page_pool_get_dma_addr(page) + PRUETH_HEADROOM;
 	desc_rx = k3_cppi_desc_pool_alloc(rx_chn->desc_pool);
@@ -490,7 +496,8 @@ int prueth_dma_rx_push_mapped(struct prueth_emac *emac,
 	cppi5_hdesc_attach_buf(desc_rx, buf_dma, buf_len, buf_dma, buf_len);
 
 	swdata = cppi5_hdesc_get_swdata(desc_rx);
-	*swdata = page;
+	swdata->type = PRUETH_SWDATA_PAGE;
+	swdata->data.page = page;
 
 	return k3_udma_glue_push_rx_chn(rx_chn->rx_chn, PRUETH_RX_FLOW_DATA,
 					desc_rx, desc_dma);
@@ -539,11 +546,11 @@ static int emac_rx_packet(struct prueth_emac *emac, u32 flow_id)
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
@@ -561,7 +568,11 @@ static int emac_rx_packet(struct prueth_emac *emac, u32 flow_id)
 
 	desc_rx = k3_cppi_desc_pool_dma2virt(rx_chn->desc_pool, desc_dma);
 	swdata = cppi5_hdesc_get_swdata(desc_rx);
-	page = *swdata;
+	if (swdata->type != PRUETH_SWDATA_PAGE) {
+		netdev_err(ndev, "rx_pkt: invalid swdata->type %d\n", swdata->type);
+		return 0;
+	}
+	page = swdata->data.page;
 
 	page_pool_dma_sync_for_cpu(pool, page, 0, PAGE_SIZE);
 	cppi5_hdesc_get_obuf(desc_rx, &buf_dma, &buf_dma_len);
@@ -627,16 +638,18 @@ static void prueth_rx_cleanup(void *data, dma_addr_t desc_dma)
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
 	k3_cppi_desc_pool_free(rx_chn->desc_pool, desc_rx);
 }
 
@@ -673,13 +686,13 @@ enum netdev_tx icssg_ndo_start_xmit(struct sk_buff *skb, struct net_device *ndev
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
@@ -741,7 +754,8 @@ enum netdev_tx icssg_ndo_start_xmit(struct sk_buff *skb, struct net_device *ndev
 	k3_udma_glue_tx_dma_to_cppi5_addr(tx_chn->tx_chn, &buf_dma);
 	cppi5_hdesc_attach_buf(first_desc, buf_dma, pkt_len, buf_dma, pkt_len);
 	swdata = cppi5_hdesc_get_swdata(first_desc);
-	*swdata = skb;
+	swdata->type = PRUETH_SWDATA_SKB;
+	swdata->data.skb = skb;
 
 	/* Handle the case where skb is fragmented in pages */
 	cur_desc = first_desc;
@@ -844,15 +858,16 @@ static void prueth_tx_cleanup(void *data, dma_addr_t desc_dma)
 {
 	struct prueth_tx_chn *tx_chn = data;
 	struct cppi5_host_desc_t *desc_tx;
+	struct prueth_swdata *swdata;
 	struct sk_buff *skb;
-	void **swdata;
 
 	desc_tx = k3_cppi_desc_pool_dma2virt(tx_chn->desc_pool, desc_dma);
 	swdata = cppi5_hdesc_get_swdata(desc_tx);
-	skb = *(swdata);
+	if (swdata->type == PRUETH_SWDATA_SKB) {
+		skb = swdata->data.skb;
+		dev_kfree_skb_any(skb);
+	}
 	prueth_xmit_free(tx_chn, desc_tx);
-
-	dev_kfree_skb_any(skb);
 }
 
 irqreturn_t prueth_rx_irq(int irq, void *dev_id)
diff --git a/drivers/net/ethernet/ti/icssg/icssg_config.h b/drivers/net/ethernet/ti/icssg/icssg_config.h
index c884e9fa099e..eab84e11d80e 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_config.h
+++ b/drivers/net/ethernet/ti/icssg/icssg_config.h
@@ -20,7 +20,7 @@ struct icssg_flow_cfg {
 
 #define PRUETH_PKT_TYPE_CMD	0x10
 #define PRUETH_NAV_PS_DATA_SIZE	16	/* Protocol specific data size */
-#define PRUETH_NAV_SW_DATA_SIZE	16	/* SW related data size */
+#define PRUETH_NAV_SW_DATA_SIZE	48	/* SW related data size */
 #define PRUETH_MAX_TX_DESC	512
 #define PRUETH_MAX_RX_DESC	512
 #define PRUETH_MAX_RX_FLOWS	1	/* excluding default flow */
diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
index 00ed97860547..e5e4efe485f6 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
@@ -1522,6 +1522,12 @@ static int prueth_probe(struct platform_device *pdev)
 
 	np = dev->of_node;
 
+	if (sizeof(struct prueth_swdata) > PRUETH_NAV_SW_DATA_SIZE) {
+		dev_err(dev, "insufficient SW_DATA size: %d vs %ld\n",
+			PRUETH_NAV_SW_DATA_SIZE, sizeof(struct prueth_swdata));
+		return -ENOMEM;
+	}
+
 	prueth = devm_kzalloc(dev, sizeof(*prueth), GFP_KERNEL);
 	if (!prueth)
 		return -ENOMEM;
diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.h b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
index c7b906de18af..2c8585255b7c 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.h
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
@@ -136,6 +136,24 @@ struct prueth_rx_chn {
 	struct page_pool *pg_pool;
 };
 
+enum prueth_swdata_type {
+	PRUETH_SWDATA_INVALID = 0,
+	PRUETH_SWDATA_SKB,
+	PRUETH_SWDATA_PAGE,
+	PRUETH_SWDATA_CMD,
+};
+
+union prueth_data {
+	struct sk_buff *skb;
+	struct page *page;
+	u32 cmd;
+};
+
+struct prueth_swdata {
+	union prueth_data data;
+	enum prueth_swdata_type type;
+};
+
 /* There are 4 Tx DMA channels, but the highest priority is CH3 (thread 3)
  * and lower three are lower priority channels or threads.
  */
diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c b/drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c
index aeeb8a50376b..7bbe0808b3ec 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c
@@ -275,10 +275,10 @@ static struct sk_buff *prueth_process_rx_mgm(struct prueth_emac *emac,
 	struct net_device *ndev = emac->ndev;
 	struct cppi5_host_desc_t *desc_rx;
 	struct page *page, *new_page;
+	struct prueth_swdata *swdata;
 	dma_addr_t desc_dma, buf_dma;
 	u32 buf_dma_len, pkt_len;
 	struct sk_buff *skb;
-	void **swdata;
 	void *pa;
 	int ret;
 
@@ -301,7 +301,7 @@ static struct sk_buff *prueth_process_rx_mgm(struct prueth_emac *emac,
 	}
 
 	swdata = cppi5_hdesc_get_swdata(desc_rx);
-	page = *swdata;
+	page = swdata->data.page;
 	cppi5_hdesc_get_obuf(desc_rx, &buf_dma, &buf_dma_len);
 	pkt_len = cppi5_hdesc_get_pktlen(desc_rx);
 
-- 
2.43.0


