Return-Path: <bpf+bounces-48952-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5129EA128FC
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 17:44:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF26D3A62B9
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 16:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFCF01925AE;
	Wed, 15 Jan 2025 16:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="glenH+tW"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687E71CEAC2;
	Wed, 15 Jan 2025 16:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736959400; cv=none; b=Xsh/dovzxB2Z58cQGiBGjw9ecwJRlad3HFTNzSYrOywHGbKdmtvQEf8g5FBbWMadbOLhQQA5XrgYBesPw9wSIMUl2pDajz1AV0StxCw+urkwQorV7s1WCqdwU+XQxNHdfigG5ttCkxciUYlxEentPTek4UPZ+8lmiGLkn1tnhDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736959400; c=relaxed/simple;
	bh=jF71yECanwn9cNUTijcUmwJ+pkItliC0L18F9UiIHbA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=W0oGpc6PvT3Hy2XO/oWgBHdUh/Hb6Tu4T1Lw7se/V1av43iLsaYN5LiKYHgVqbAnXxFEgj9jyowjBscWDiYc+O5/2Awo12dNN+8VlO+KwWMdeyee4vXFMuae9IAH1uUjNLG/v1qU9Lvbx3HhtJXovcgJNmuNjkPDNaHocvuiI2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=glenH+tW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DDE7C4CEE0;
	Wed, 15 Jan 2025 16:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736959400;
	bh=jF71yECanwn9cNUTijcUmwJ+pkItliC0L18F9UiIHbA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=glenH+tWaMXvY0ysyt/1j6HGpRVpMqg+d4JD3znXxvMddcmlhv4UBmyeGdjyXe5Uf
	 0K8eOiTbY+uNcIDOEVvi2OkV3Rk1KWLbh8hsz35j6Swh0pYvhegfcLD1nyLKm+gpug
	 kleCqb/OjTBDSNz6XzSMHMX4AKQebvnIb4wT2tOxEVsGz70pqq1/TxiexgkBCARnGi
	 505ZVYIpmZFTtrEcElSAk/jiukZbztjjeW2HQTuYIZ4PqwBMiBoylHNKZItzTRQ3Ly
	 L/Yv+8iks/0aAhbGjfnP3NCuR8FmPAbkgtq4nQI7PYzABd+EGgsl0H82+JzWwkHLLO
	 XODmd6C49TLcQ==
From: Roger Quadros <rogerq@kernel.org>
Date: Wed, 15 Jan 2025 18:43:02 +0200
Subject: [PATCH net-next 3/4] net: ethernet: ti: am65-cpsw: streamline RX
 queue creation and cleanup
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250115-am65-cpsw-streamline-v1-3-326975c36935@kernel.org>
References: <20250115-am65-cpsw-streamline-v1-0-326975c36935@kernel.org>
In-Reply-To: <20250115-am65-cpsw-streamline-v1-0-326975c36935@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Russell King <linux@armlinux.org.uk>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>
Cc: Siddharth Vadapalli <s-vadapalli@ti.com>, srk@ti.com, 
 danishanwar@ti.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, Roger Quadros <rogerq@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=10482; i=rogerq@kernel.org;
 h=from:subject:message-id; bh=jF71yECanwn9cNUTijcUmwJ+pkItliC0L18F9UiIHbA=;
 b=owEBbQKS/ZANAwAIAdJaa9O+djCTAcsmYgBnh+WXFsAA/rFzr4KSVRZmD/sfa6+fPXtGRxHxv
 TsyqexzTvKJAjMEAAEIAB0WIQRBIWXUTJ9SeA+rEFjSWmvTvnYwkwUCZ4fllwAKCRDSWmvTvnYw
 kz+DEADTIHeKIbiYvGEXLjEBIWh3nVN6VO40XC4tXNqvHQefOQ4Zb/em09hvlGyE8vjG2sQuHwD
 yuZwZ6IY1E05W7LIU6u8BtQm1cpQlnqc/ZviL5uDH9DaEInjj1D93gd0Y5PU74zjPuHBevopOdc
 QJDFGkmUuAvvoSSwjCVnt15O0tQQTFCthmKPhJNGnqqoNh0bQn69mq6wq/cBrE/LXWlQCljNs6U
 Zdj1iFFmL+bxv6g3Ss1l1805OGuIkQ9vfwLUyRhEAc3xlGPzWpBUxYJhAnE6W7r4acCOeiP/miI
 XrnNqBrtlhpLGpNZqNRy4ek1/KNUueTGbDELB4Uw1EoD/vOY08c+IuqaO3fYFjILECA7bXPHeWW
 DAhGV4njuwy1Zh1HuB5PNQeQ7ZFaUKRzWcS0E2t6q1xbaZjXrpXj9EFTeLwi4tveH84yyvS3HYY
 xNrzUIyfRMV8CVtbqPiZQ2zGSDFinDeTG3XWcpjQ1zwVmic9EMiaGbyC0nesfFBRxIwnEavy+6P
 jH4jFRj3i7flXvCd3llecfaSNbB5QmbXPRgToaQthDJZs9OhBPL4pmwdW7CqRqvelvN7C8YoQ0/
 frN7WalBq3AbGrhukvEF4lFLeGg3S/ml0NBmTZ9yUBUfzVjThsvBpPqJb0jVTghqgKRq6+KiG0j
 uVAaxRupnaxjELg==
X-Developer-Key: i=rogerq@kernel.org; a=openpgp;
 fpr=412165D44C9F52780FAB1058D25A6BD3BE763093

Introduce am65_cpsw_create_rxqs() and am65_cpsw_destroy_rxqs()
and use them.

Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
 drivers/net/ethernet/ti/am65-cpsw-nuss.c | 243 +++++++++++++++----------------
 1 file changed, 119 insertions(+), 124 deletions(-)

diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
index 783ec461dbdc..b5e679bb3f3c 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
@@ -497,35 +497,61 @@ static void am65_cpsw_init_host_port_switch(struct am65_cpsw_common *common);
 static void am65_cpsw_init_host_port_emac(struct am65_cpsw_common *common);
 static void am65_cpsw_init_port_switch_ale(struct am65_cpsw_port *port);
 static void am65_cpsw_init_port_emac_ale(struct am65_cpsw_port *port);
+static inline void am65_cpsw_put_page(struct am65_cpsw_rx_flow *flow,
+				      struct page *page,
+				      bool allow_direct);
+static void am65_cpsw_nuss_rx_cleanup(void *data, dma_addr_t desc_dma);
 
-static void am65_cpsw_destroy_xdp_rxqs(struct am65_cpsw_common *common)
+static void am65_cpsw_destroy_rxq(struct am65_cpsw_common *common, int id)
 {
 	struct am65_cpsw_rx_chn *rx_chn = &common->rx_chns;
 	struct am65_cpsw_rx_flow *flow;
 	struct xdp_rxq_info *rxq;
-	int id, port;
+	int port;
 
-	for (id = 0; id < common->rx_ch_num_flows; id++) {
-		flow = &rx_chn->flows[id];
+	flow = &rx_chn->flows[id];
+	napi_disable(&flow->napi_rx);
+	hrtimer_cancel(&flow->rx_hrtimer);
+	k3_udma_glue_reset_rx_chn(rx_chn->rx_chn, id, rx_chn,
+				  am65_cpsw_nuss_rx_cleanup, !!id);
 
-		for (port = 0; port < common->port_num; port++) {
-			if (!common->ports[port].ndev)
-				continue;
+	for (port = 0; port < common->port_num; port++) {
+		if (!common->ports[port].ndev)
+			continue;
 
-			rxq = &common->ports[port].xdp_rxq[id];
+		rxq = &common->ports[port].xdp_rxq[id];
 
-			if (xdp_rxq_info_is_reg(rxq))
-				xdp_rxq_info_unreg(rxq);
-		}
+		if (xdp_rxq_info_is_reg(rxq))
+			xdp_rxq_info_unreg(rxq);
+	}
 
-		if (flow->page_pool) {
-			page_pool_destroy(flow->page_pool);
-			flow->page_pool = NULL;
-		}
+	if (flow->page_pool) {
+		page_pool_destroy(flow->page_pool);
+		flow->page_pool = NULL;
 	}
 }
 
-static int am65_cpsw_create_xdp_rxqs(struct am65_cpsw_common *common)
+static void am65_cpsw_destroy_rxqs(struct am65_cpsw_common *common)
+{
+	struct am65_cpsw_rx_chn *rx_chn = &common->rx_chns;
+	int id;
+
+	reinit_completion(&common->tdown_complete);
+	k3_udma_glue_tdown_rx_chn(rx_chn->rx_chn, true);
+
+	if (common->pdata.quirks & AM64_CPSW_QUIRK_DMA_RX_TDOWN_IRQ) {
+		id = wait_for_completion_timeout(&common->tdown_complete, msecs_to_jiffies(1000));
+		if (!id)
+			dev_err(common->dev, "rx teardown timeout\n");
+	}
+
+	for (id = common->rx_ch_num_flows - 1; id >= 0; id--)
+		am65_cpsw_destroy_rxq(common, id);
+
+	k3_udma_glue_disable_rx_chn(common->rx_chns.rx_chn);
+}
+
+static int am65_cpsw_create_rxq(struct am65_cpsw_common *common, int id)
 {
 	struct am65_cpsw_rx_chn *rx_chn = &common->rx_chns;
 	struct page_pool_params pp_params = {
@@ -540,45 +566,92 @@ static int am65_cpsw_create_xdp_rxqs(struct am65_cpsw_common *common)
 	struct am65_cpsw_rx_flow *flow;
 	struct xdp_rxq_info *rxq;
 	struct page_pool *pool;
-	int id, port, ret;
+	struct page *page;
+	int port, ret, i;
 
-	for (id = 0; id < common->rx_ch_num_flows; id++) {
-		flow = &rx_chn->flows[id];
-		pp_params.napi = &flow->napi_rx;
-		pool = page_pool_create(&pp_params);
-		if (IS_ERR(pool)) {
-			ret = PTR_ERR(pool);
+	flow = &rx_chn->flows[id];
+	pp_params.napi = &flow->napi_rx;
+	pool = page_pool_create(&pp_params);
+	if (IS_ERR(pool)) {
+		ret = PTR_ERR(pool);
+		return ret;
+	}
+
+	flow->page_pool = pool;
+
+	/* using same page pool is allowed as no running rx handlers
+	 * simultaneously for both ndevs
+	 */
+	for (port = 0; port < common->port_num; port++) {
+		if (!common->ports[port].ndev)
+		/* FIXME should we BUG here? */
+			continue;
+
+		rxq = &common->ports[port].xdp_rxq[id];
+		ret = xdp_rxq_info_reg(rxq, common->ports[port].ndev,
+				       id, flow->napi_rx.napi_id);
+		if (ret)
+			goto err;
+
+		ret = xdp_rxq_info_reg_mem_model(rxq,
+						 MEM_TYPE_PAGE_POOL,
+						 pool);
+		if (ret)
+			goto err;
+	}
+
+	for (i = 0; i < AM65_CPSW_MAX_RX_DESC; i++) {
+		page = page_pool_dev_alloc_pages(flow->page_pool);
+		if (!page) {
+			dev_err(common->dev, "cannot allocate page in flow %d\n",
+				id);
+			ret = -ENOMEM;
 			goto err;
 		}
 
-		flow->page_pool = pool;
+		ret = am65_cpsw_nuss_rx_push(common, page, id);
+		if (ret < 0) {
+			dev_err(common->dev,
+				"cannot submit page to rx channel flow %d, error %d\n",
+				id, ret);
+			am65_cpsw_put_page(flow, page, false);
+			goto err;
+		}
+	}
 
-		/* using same page pool is allowed as no running rx handlers
-		 * simultaneously for both ndevs
-		 */
-		for (port = 0; port < common->port_num; port++) {
-			if (!common->ports[port].ndev)
-				continue;
+	napi_enable(&flow->napi_rx);
+	return 0;
 
-			rxq = &common->ports[port].xdp_rxq[id];
+err:
+	am65_cpsw_destroy_rxq(common, id);
+	return ret;
+}
 
-			ret = xdp_rxq_info_reg(rxq, common->ports[port].ndev,
-					       id, flow->napi_rx.napi_id);
-			if (ret)
-				goto err;
+static int am65_cpsw_create_rxqs(struct am65_cpsw_common *common)
+{
+	int id, ret;
 
-			ret = xdp_rxq_info_reg_mem_model(rxq,
-							 MEM_TYPE_PAGE_POOL,
-							 pool);
-			if (ret)
-				goto err;
+	for (id = 0; id < common->rx_ch_num_flows; id++) {
+		ret = am65_cpsw_create_rxq(common, id);
+		if (ret) {
+			dev_err(common->dev, "couldn't create rxq %d: %d\n",
+				id, ret);
+			goto err;
 		}
 	}
 
+	ret = k3_udma_glue_enable_rx_chn(common->rx_chns.rx_chn);
+	if (ret) {
+		dev_err(common->dev, "couldn't enable rx chn: %d\n", ret);
+		goto err;
+	}
+
 	return 0;
 
 err:
-	am65_cpsw_destroy_xdp_rxqs(common);
+	for (--id; id >= 0; id--)
+		am65_cpsw_destroy_rxq(common, id);
+
 	return ret;
 }
 
@@ -642,7 +715,6 @@ static void am65_cpsw_nuss_rx_cleanup(void *data, dma_addr_t desc_dma)
 	k3_udma_glue_rx_cppi5_to_dma_addr(rx_chn->rx_chn, &buf_dma);
 	dma_unmap_single(rx_chn->dma_dev, buf_dma, buf_dma_len, DMA_FROM_DEVICE);
 	k3_cppi_desc_pool_free(rx_chn->desc_pool, desc_rx);
-
 	am65_cpsw_put_page(&rx_chn->flows[flow_id], page, false);
 }
 
@@ -717,12 +789,9 @@ static struct sk_buff *am65_cpsw_build_skb(void *page_addr,
 static int am65_cpsw_nuss_common_open(struct am65_cpsw_common *common)
 {
 	struct am65_cpsw_host *host_p = am65_common_get_host(common);
-	struct am65_cpsw_rx_chn *rx_chn = &common->rx_chns;
 	struct am65_cpsw_tx_chn *tx_chn = common->tx_chns;
-	int port_idx, i, ret, tx, flow_idx;
-	struct am65_cpsw_rx_flow *flow;
+	int port_idx, ret, tx;
 	u32 val, port_mask;
-	struct page *page;
 
 	if (common->usage_count)
 		return 0;
@@ -782,47 +851,9 @@ static int am65_cpsw_nuss_common_open(struct am65_cpsw_common *common)
 
 	am65_cpsw_qos_tx_p0_rate_init(common);
 
-	ret = am65_cpsw_create_xdp_rxqs(common);
-	if (ret) {
-		dev_err(common->dev, "Failed to create XDP rx queues\n");
+	ret = am65_cpsw_create_rxqs(common);
+	if (ret)
 		return ret;
-	}
-
-	for (flow_idx = 0; flow_idx < common->rx_ch_num_flows; flow_idx++) {
-		flow = &rx_chn->flows[flow_idx];
-		for (i = 0; i < AM65_CPSW_MAX_RX_DESC; i++) {
-			page = page_pool_dev_alloc_pages(flow->page_pool);
-			if (!page) {
-				dev_err(common->dev, "cannot allocate page in flow %d\n",
-					flow_idx);
-				ret = -ENOMEM;
-				goto fail_rx;
-			}
-
-			ret = am65_cpsw_nuss_rx_push(common, page, flow_idx);
-			if (ret < 0) {
-				dev_err(common->dev,
-					"cannot submit page to rx channel flow %d, error %d\n",
-					flow_idx, ret);
-				am65_cpsw_put_page(flow, page, false);
-				goto fail_rx;
-			}
-		}
-	}
-
-	ret = k3_udma_glue_enable_rx_chn(rx_chn->rx_chn);
-	if (ret) {
-		dev_err(common->dev, "couldn't enable rx chn: %d\n", ret);
-		goto fail_rx;
-	}
-
-	for (i = 0; i < common->rx_ch_num_flows ; i++) {
-		napi_enable(&rx_chn->flows[i].napi_rx);
-		if (rx_chn->flows[i].irq_disabled) {
-			rx_chn->flows[i].irq_disabled = false;
-			enable_irq(rx_chn->flows[i].irq);
-		}
-	}
 
 	for (tx = 0; tx < common->tx_ch_num; tx++) {
 		ret = k3_udma_glue_enable_tx_chn(tx_chn[tx].tx_chn);
@@ -845,30 +876,13 @@ static int am65_cpsw_nuss_common_open(struct am65_cpsw_common *common)
 		tx--;
 	}
 
-	for (flow_idx = 0; i < common->rx_ch_num_flows; flow_idx++) {
-		flow = &rx_chn->flows[flow_idx];
-		if (!flow->irq_disabled) {
-			disable_irq(flow->irq);
-			flow->irq_disabled = true;
-		}
-		napi_disable(&flow->napi_rx);
-	}
-
-	k3_udma_glue_disable_rx_chn(rx_chn->rx_chn);
-
-fail_rx:
-	for (i = 0; i < common->rx_ch_num_flows; i++)
-		k3_udma_glue_reset_rx_chn(rx_chn->rx_chn, i, rx_chn,
-					  am65_cpsw_nuss_rx_cleanup, !!i);
-
-	am65_cpsw_destroy_xdp_rxqs(common);
+	am65_cpsw_destroy_rxqs(common);
 
 	return ret;
 }
 
 static int am65_cpsw_nuss_common_stop(struct am65_cpsw_common *common)
 {
-	struct am65_cpsw_rx_chn *rx_chn = &common->rx_chns;
 	struct am65_cpsw_tx_chn *tx_chn = common->tx_chns;
 	int i;
 
@@ -902,31 +916,12 @@ static int am65_cpsw_nuss_common_stop(struct am65_cpsw_common *common)
 		k3_udma_glue_disable_tx_chn(tx_chn[i].tx_chn);
 	}
 
-	reinit_completion(&common->tdown_complete);
-	k3_udma_glue_tdown_rx_chn(rx_chn->rx_chn, true);
-
-	if (common->pdata.quirks & AM64_CPSW_QUIRK_DMA_RX_TDOWN_IRQ) {
-		i = wait_for_completion_timeout(&common->tdown_complete, msecs_to_jiffies(1000));
-		if (!i)
-			dev_err(common->dev, "rx teardown timeout\n");
-	}
-
-	for (i = common->rx_ch_num_flows - 1; i >= 0; i--) {
-		napi_disable(&rx_chn->flows[i].napi_rx);
-		hrtimer_cancel(&rx_chn->flows[i].rx_hrtimer);
-		k3_udma_glue_reset_rx_chn(rx_chn->rx_chn, i, rx_chn,
-					  am65_cpsw_nuss_rx_cleanup, !!i);
-	}
-
-	k3_udma_glue_disable_rx_chn(rx_chn->rx_chn);
-
+	am65_cpsw_destroy_rxqs(common);
 	cpsw_ale_stop(common->ale);
 
 	writel(0, common->cpsw_base + AM65_CPSW_REG_CTL);
 	writel(0, common->cpsw_base + AM65_CPSW_REG_STAT_PORT_EN);
 
-	am65_cpsw_destroy_xdp_rxqs(common);
-
 	dev_dbg(common->dev, "cpsw_nuss stopped\n");
 	return 0;
 }

-- 
2.34.1


