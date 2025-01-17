Return-Path: <bpf+bounces-49198-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B70DA15146
	for <lists+bpf@lfdr.de>; Fri, 17 Jan 2025 15:08:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BDA33AAB7E
	for <lists+bpf@lfdr.de>; Fri, 17 Jan 2025 14:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57AB820127A;
	Fri, 17 Jan 2025 14:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NVWRJS8H"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18931FFC67;
	Fri, 17 Jan 2025 14:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737122829; cv=none; b=OTwn1ep0odxQpfkijr45sgFoaqa53jH5fkdYTWVlS+3SdrKP3Hv+SHmbdDnReNEK6otOw2qM8vDm3w9RQ5z8I+bMB+oFvLa2g+35mwhVBFzrbfWIGDO3wJnr7dbgP9rbvsyWCMPHNlAvc3WL1e2kFoDrP4h6oLKDu6yY8sZ+Cuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737122829; c=relaxed/simple;
	bh=d3cIgCE7zSt3uyvGlm5j4+GUZUGPxbHk+TqB/Ez3/tI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=se1s4iAbf8sDpVlZfapDqJW6emVOkFj0/xma0dicmj/m7HB4VEfIrOaEHZgeEVhgf+NQ7DRfG6IaWxVOxkpSGcpHUNSaD8RqYG1UNKuqFE8AfB0yTbuGlmHCFw8WnebWdjRKnfCQR2eibBBmS/5M+3z7Dcf+lLn4nAhfcPtVNXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NVWRJS8H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87656C4CEE2;
	Fri, 17 Jan 2025 14:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737122829;
	bh=d3cIgCE7zSt3uyvGlm5j4+GUZUGPxbHk+TqB/Ez3/tI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=NVWRJS8H82FKtveZuMW3iKixUeA9IAYsmCzXs9cR29D7SYc+CRaqUemrBlRQEy+Zy
	 YUGQCtnWdeEPmELoEnuMeT7cmiz5uGY3EpgQAzXB5ItowUGbecVznbW/ue/O11Kwo0
	 QwW351guqjmkVJ94+bVyflaJtcSv1nDJ+S7bGeRDrwn9t8b2DtEcv3LwK1IIxV5WxD
	 6X2rGuwdlnfIqPG6JRzce4gcPaluY/7j1mZwRre2BZGT73XVg2ZdlGPT5SVC0IKb4W
	 eH95NZTzELsmCzLRUhk1eenBS967WI//yLbJC0wwrXp1K/U7ZtscNR6TlGgbJR+dY5
	 2sBsEVS9mjV6A==
From: Roger Quadros <rogerq@kernel.org>
Date: Fri, 17 Jan 2025 16:06:34 +0200
Subject: [PATCH net-next v2 2/3] net: ethernet: ti: am65-cpsw: streamline
 RX queue creation and cleanup
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250117-am65-cpsw-streamline-v2-2-91a29c97e569@kernel.org>
References: <20250117-am65-cpsw-streamline-v2-0-91a29c97e569@kernel.org>
In-Reply-To: <20250117-am65-cpsw-streamline-v2-0-91a29c97e569@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Russell King <linux@armlinux.org.uk>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>
Cc: Siddharth Vadapalli <s-vadapalli@ti.com>, srk@ti.com, 
 danishanwar@ti.com, "Russell King (Oracle)" <linux@armlinux.org.uk>, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 Roger Quadros <rogerq@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=10482; i=rogerq@kernel.org;
 h=from:subject:message-id; bh=d3cIgCE7zSt3uyvGlm5j4+GUZUGPxbHk+TqB/Ez3/tI=;
 b=owEBbQKS/ZANAwAIAdJaa9O+djCTAcsmYgBnimQAHB1QHaJ4nJywvzomDfxqj6gdrESOZvJ1N
 8JxWccGd5GJAjMEAAEIAB0WIQRBIWXUTJ9SeA+rEFjSWmvTvnYwkwUCZ4pkAAAKCRDSWmvTvnYw
 kzwgD/9nio+teeadLTZaKPUa3VFU8LDQ53oC9lolXvO2UY9YJ7uFoEewfdbQXXbfmQ5p/UV2fhR
 Rpxd1+VQaIBT/JpCcikiXMIT/+/oWseuKg7JAViTpcZHcQyejqdFdzhEXPLQIp1EgTCTNDG+RJx
 vRDoMAmmllYX6QaDBUWCrBhjbj1mdGw+hP7UKZUjvZ0DLULBII31gj18TTTeCPAMTgk0mhFIqLD
 fcjhfCFqOQ77qBR6Ayq3lXqXTk+e9RU2c1MOaxxKly1LPhx+iPQ4BP4/GzmUPtXMqERFsbpoeuu
 h5rwCiKEGAn8ua3q8npdE+aO+ZpLEEtdqlbSLyD3bWQNhIiTrnLfJRs61/UUXrAErvSXxZGZGsz
 luya1QlJEH7k+gmgFm0ClV7q8m8Jgj0pjvlBD++7KZ1kSYO2DVTYiGnYxfViPWkAt5nEoECDhjd
 aJYtaPecsJBL5D2nkKWAXBI1zmJ9NG5ixpwrYfs08pW1iXleQD4MmpjOjpIcLCfM7HiVhloBrym
 Gq4Czqjqx7tLt0XhRJmes5JAzzt8IXNGPdlAqb0gZNIO9Y8EC8KkTTVfj7PxJwIBvjoxGfvcea4
 ifjpSM9Q+SPAEtk9pGDpEmLZrUo5wzRIaRiTILgc0pdItYPl557dGlIb73ADKhri4zGrdMvKK5A
 boogE2Pwk0D/B1Q==
X-Developer-Key: i=rogerq@kernel.org; a=openpgp;
 fpr=412165D44C9F52780FAB1058D25A6BD3BE763093

Introduce am65_cpsw_create_rxqs() and am65_cpsw_destroy_rxqs()
and use them.

Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
 drivers/net/ethernet/ti/am65-cpsw-nuss.c | 243 +++++++++++++++----------------
 1 file changed, 119 insertions(+), 124 deletions(-)

diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
index f5ae63999516..5c87002eeee9 100644
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


