Return-Path: <bpf+bounces-48951-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48419A128F9
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 17:44:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 657B63A6362
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 16:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 250ED1C07EE;
	Wed, 15 Jan 2025 16:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N9knrWzr"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9329116A92E;
	Wed, 15 Jan 2025 16:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736959397; cv=none; b=jaamjCoFQYsL7BoQA7QTfC4cvYNpcsRLprUe+RiPaMixJMTARZDIWl7yeFXb/LvVvvYRGHczvnxnQpxPds5BMjPLs+rzJkQlBNyUq4yrlz6L1/RMfXhoGq/PsJGE52HnnTIVtxTApjB1Jp2BkmJFRuYbNAKfKLylDKhXTriHguo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736959397; c=relaxed/simple;
	bh=EK74UAq6GTG/g6jAR54DfVO7VAXVzZEuvAa3GSMYP7s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PhUdKSCgBL7qN+xubecTAODZ688yFf82ypozcHJ4cCq4W8U80A6eZox9WUl/NS1gngyPvvAgHwSoGdLeEeX1MpXgphNa17hIVUkWtgS0kMPN9IxlThYZxdatUP0p6eQ1LVqj/xQO9rSXKDVhaC1uEOFfHNo68D24z8JNec/jVks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N9knrWzr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54247C4CEE1;
	Wed, 15 Jan 2025 16:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736959396;
	bh=EK74UAq6GTG/g6jAR54DfVO7VAXVzZEuvAa3GSMYP7s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=N9knrWzr8w/Axgl6A6IsIYoE3lUwbpj+NWDkrV5gzK5O1ePYlMY70htqvBYO7rtoi
	 MuCv7bG+PxcFpOWeG3pJeRBpXA1+6FZMiezcXwPVKVwqd6AHRVNjxK1spvs9ZVfBh1
	 GDRXBTskXP/pd0L7z7/1ji0bekr3Zf1rvmtCbzCCUubEmhK5esOdEyEclFtYXEo4W1
	 gcWNKg/cq92SWDPKMcvq7O4PAdfYFIp4uka3kmABKdxKJ3oSuSg4So/rsjCqKlUE2M
	 jmR5h7YLytFdsJc2bfh0sGDnyoRvEcAbvBNY2mCyK8/Lws5/uZJ0oFaKZZ/bV/yroX
	 I0F6aqCMZrBkQ==
From: Roger Quadros <rogerq@kernel.org>
Date: Wed, 15 Jan 2025 18:43:01 +0200
Subject: [PATCH net-next 2/4] net: ethernet: ti: am65-cpsw: streamline
 .probe() error handling
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250115-am65-cpsw-streamline-v1-2-326975c36935@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=14375; i=rogerq@kernel.org;
 h=from:subject:message-id; bh=EK74UAq6GTG/g6jAR54DfVO7VAXVzZEuvAa3GSMYP7s=;
 b=owEBbQKS/ZANAwAIAdJaa9O+djCTAcsmYgBnh+WXjCQrj28NhSw1zRV9HiXLl1I7UVRGlOSMZ
 7LnH6BwNz2JAjMEAAEIAB0WIQRBIWXUTJ9SeA+rEFjSWmvTvnYwkwUCZ4fllwAKCRDSWmvTvnYw
 k0ovD/9IwKCq0AIWCgHCyP/5wJxbZzdwb/708lEPiJODMy4JA1Sky6ptnUYK8qydLOUp8EjuN6D
 3VM/jXGtuyVz8227hpVKTfOZAmfTbLrtQd6SY+AiCJf2zX/nLyhHqIiNBM8rgCQtPBz+iL4pkwk
 P6yGYBg+7f5NOhQnVKWi54T5yWYNpl8345kqcuyEs8MWqCymRGDe0xbDd+dK5pDMXNQqFRxXvDv
 55IZcHTjjbD50Pf60JPoBf3e8RbrxFbcjkp7Cp+iuSnS3ILpzmw/iN42RJO7P2Y1i3nr3RmB1cK
 WadU0HzC8rj4dZuAiKN9DYzaR1RtgAUfbpUT+ALK0H0HbizocI2bfMGZEAJF7tPikcl4OtBsSf8
 PzsBx63gzK8/stioBzuyJoU0hRXplqFW03wn6q4N7bfM9NYP5Oz7sz4xUMAetAwPqT2vLL/AdUu
 bM9SCJHmohcZgzDlM4z9n7qvdNCW2gBSbCEAYsAOHIAGkSeULa7oA7+WgMZf2plPGQ7iip/WWhk
 jgyRpsH8m2vtvGSA0B0+/mpk7jvZw4u6qsdVZ4mIwOx01zoCgtU+/f4fvk4DDggmn7SoYNNA4xh
 IgPZAGZ5shUSzHpibmPX/JU7wbXwzQlC2z1VgcSpbjAR3+l8n4qnNyquBvyZ9LnkoPp/8mUUdgF
 vypmnw0kmYXzSPA==
X-Developer-Key: i=rogerq@kernel.org; a=openpgp;
 fpr=412165D44C9F52780FAB1058D25A6BD3BE763093

Keep things simple by explicitly cleaning up on .probe() error
path or .remove(). Get rid of devm_add/remove_action() usage.

Rename am65_cpsw_disable_serdes_phy() to
am65_cpsw_nuss_cleanup_slave_ports() and move it right before
am65_cpsw_nuss_init_slave_ports().

Get rid of am65_cpsw_nuss_phylink_cleanup() and introduce
am65_cpsw_nuss_cleanup_ndevs() right before am65_cpsw_nuss_init_ndevs()

Move channel initiailzation code out of am65_cpsw_nuss_register_ndevs()
into new function am65_cpsw_nuss_init_chns().
Add am65_cpsw_nuss_remove_chns() to do reverse of
am65_cpsw_nuss_init_chns().

Add am65_cpsw_nuss_unregister_ndev() to do reverse of
am65_cpsw_nuss_register_ndevs().

Use the introduced helpers in probe/remove.

Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
 drivers/net/ethernet/ti/am65-cpsw-nuss.c | 276 ++++++++++++++-----------------
 1 file changed, 126 insertions(+), 150 deletions(-)

diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
index 36c29d3db329..783ec461dbdc 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
@@ -2056,20 +2056,6 @@ static int am65_cpsw_enable_phy(struct phy *phy)
 	return 0;
 }
 
-static void am65_cpsw_disable_serdes_phy(struct am65_cpsw_common *common)
-{
-	struct am65_cpsw_port *port;
-	struct phy *phy;
-	int i;
-
-	for (i = 0; i < common->port_num; i++) {
-		port = &common->ports[i];
-		phy = port->slave.serdes_phy;
-		if (phy)
-			am65_cpsw_disable_phy(phy);
-	}
-}
-
 static int am65_cpsw_init_serdes_phy(struct device *dev, struct device_node *port_np,
 				     struct am65_cpsw_port *port)
 {
@@ -2222,14 +2208,20 @@ static void am65_cpsw_nuss_slave_disable_unused(struct am65_cpsw_port *port)
 	cpsw_sl_ctl_reset(port->slave.mac_sl);
 }
 
-static void am65_cpsw_nuss_free_tx_chns(void *data)
+static void am65_cpsw_nuss_cleanup_tx_chns(struct am65_cpsw_common *common)
 {
-	struct am65_cpsw_common *common = data;
+	struct device *dev = common->dev;
 	int i;
 
+	common->tx_ch_rate_msk = 0;
 	for (i = 0; i < common->tx_ch_num; i++) {
 		struct am65_cpsw_tx_chn *tx_chn = &common->tx_chns[i];
 
+		if (tx_chn->irq)
+			devm_free_irq(dev, tx_chn->irq, tx_chn);
+
+		netif_napi_del(&tx_chn->napi_tx);
+
 		if (!IS_ERR_OR_NULL(tx_chn->desc_pool))
 			k3_cppi_desc_pool_destroy(tx_chn->desc_pool);
 
@@ -2240,26 +2232,6 @@ static void am65_cpsw_nuss_free_tx_chns(void *data)
 	}
 }
 
-static void am65_cpsw_nuss_remove_tx_chns(struct am65_cpsw_common *common)
-{
-	struct device *dev = common->dev;
-	int i;
-
-	devm_remove_action(dev, am65_cpsw_nuss_free_tx_chns, common);
-
-	common->tx_ch_rate_msk = 0;
-	for (i = 0; i < common->tx_ch_num; i++) {
-		struct am65_cpsw_tx_chn *tx_chn = &common->tx_chns[i];
-
-		if (tx_chn->irq)
-			devm_free_irq(dev, tx_chn->irq, tx_chn);
-
-		netif_napi_del(&tx_chn->napi_tx);
-	}
-
-	am65_cpsw_nuss_free_tx_chns(common);
-}
-
 static int am65_cpsw_nuss_ndev_add_tx_napi(struct am65_cpsw_common *common)
 {
 	struct device *dev = common->dev;
@@ -2360,36 +2332,14 @@ static int am65_cpsw_nuss_init_tx_chns(struct am65_cpsw_common *common)
 	}
 
 	ret = am65_cpsw_nuss_ndev_add_tx_napi(common);
-	if (ret) {
+	if (ret)
 		dev_err(dev, "Failed to add tx NAPI %d\n", ret);
-		goto err;
-	}
 
 err:
-	i = devm_add_action(dev, am65_cpsw_nuss_free_tx_chns, common);
-	if (i) {
-		dev_err(dev, "Failed to add free_tx_chns action %d\n", i);
-		return i;
-	}
-
 	return ret;
 }
 
-static void am65_cpsw_nuss_free_rx_chns(void *data)
-{
-	struct am65_cpsw_common *common = data;
-	struct am65_cpsw_rx_chn *rx_chn;
-
-	rx_chn = &common->rx_chns;
-
-	if (!IS_ERR_OR_NULL(rx_chn->desc_pool))
-		k3_cppi_desc_pool_destroy(rx_chn->desc_pool);
-
-	if (!IS_ERR_OR_NULL(rx_chn->rx_chn))
-		k3_udma_glue_release_rx_chn(rx_chn->rx_chn);
-}
-
-static void am65_cpsw_nuss_remove_rx_chns(struct am65_cpsw_common *common)
+static void am65_cpsw_nuss_cleanup_rx_chns(struct am65_cpsw_common *common)
 {
 	struct device *dev = common->dev;
 	struct am65_cpsw_rx_chn *rx_chn;
@@ -2398,7 +2348,6 @@ static void am65_cpsw_nuss_remove_rx_chns(struct am65_cpsw_common *common)
 
 	rx_chn = &common->rx_chns;
 	flows = rx_chn->flows;
-	devm_remove_action(dev, am65_cpsw_nuss_free_rx_chns, common);
 
 	for (i = 0; i < common->rx_ch_num_flows; i++) {
 		if (!(flows[i].irq < 0))
@@ -2406,7 +2355,11 @@ static void am65_cpsw_nuss_remove_rx_chns(struct am65_cpsw_common *common)
 		netif_napi_del(&flows[i].napi_rx);
 	}
 
-	am65_cpsw_nuss_free_rx_chns(common);
+	if (!IS_ERR_OR_NULL(rx_chn->desc_pool))
+		k3_cppi_desc_pool_destroy(rx_chn->desc_pool);
+
+	if (!IS_ERR_OR_NULL(rx_chn->rx_chn))
+		k3_udma_glue_release_rx_chn(rx_chn->rx_chn);
 
 	common->rx_flow_id_base = -1;
 }
@@ -2535,14 +2488,7 @@ static int am65_cpsw_nuss_init_rx_chns(struct am65_cpsw_common *common)
 
 	/* setup classifier to route priorities to flows */
 	cpsw_ale_classifier_setup_default(common->ale, common->rx_ch_num_flows);
-
 err:
-	i = devm_add_action(dev, am65_cpsw_nuss_free_rx_chns, common);
-	if (i) {
-		dev_err(dev, "Failed to add free_rx_chns action %d\n", i);
-		return i;
-	}
-
 	return ret;
 }
 
@@ -2626,6 +2572,22 @@ static int am65_cpsw_init_cpts(struct am65_cpsw_common *common)
 	return 0;
 }
 
+static void am65_cpsw_nuss_cleanup_slave_ports(struct am65_cpsw_common *common)
+{
+	struct am65_cpsw_port *port;
+	struct phy *phy;
+	int i;
+
+	for (i = 0; i < common->port_num; i++) {
+		port = &common->ports[i];
+		phy = port->slave.serdes_phy;
+		if (phy) {
+			am65_cpsw_disable_phy(phy);
+			port->slave.serdes_phy = NULL;
+		}
+	}
+}
+
 static int am65_cpsw_nuss_init_slave_ports(struct am65_cpsw_common *common)
 {
 	struct device_node *node, *port_np;
@@ -2743,18 +2705,6 @@ static int am65_cpsw_nuss_init_slave_ports(struct am65_cpsw_common *common)
 	return ret;
 }
 
-static void am65_cpsw_nuss_phylink_cleanup(struct am65_cpsw_common *common)
-{
-	struct am65_cpsw_port *port;
-	int i;
-
-	for (i = 0; i < common->port_num; i++) {
-		port = &common->ports[i];
-		if (port->slave.phylink)
-			phylink_destroy(port->slave.phylink);
-	}
-}
-
 static int
 am65_cpsw_nuss_init_port_ndev(struct am65_cpsw_common *common, u32 port_idx)
 {
@@ -2863,34 +2813,42 @@ am65_cpsw_nuss_init_port_ndev(struct am65_cpsw_common *common, u32 port_idx)
 	return 0;
 }
 
-static int am65_cpsw_nuss_init_ndevs(struct am65_cpsw_common *common)
+static void am65_cpsw_nuss_cleanup_ndevs(struct am65_cpsw_common *common)
 {
-	int ret;
+	struct am65_cpsw_port *port;
 	int i;
 
 	for (i = 0; i < common->port_num; i++) {
-		ret = am65_cpsw_nuss_init_port_ndev(common, i);
-		if (ret)
-			return ret;
+		port = &common->ports[i];
+		if (port->disabled)
+			continue;
+
+		if (port->slave.phylink) {
+			phylink_destroy(port->slave.phylink);
+			port->slave.phylink = NULL;
+		}
+
+		if (port->ndev) {
+			free_netdev(port->ndev);
+			port->ndev = NULL;
+		}
 	}
 
-	return ret;
+	common->dma_ndev = NULL;
 }
 
-static void am65_cpsw_nuss_cleanup_ndev(struct am65_cpsw_common *common)
+static int am65_cpsw_nuss_init_ndevs(struct am65_cpsw_common *common)
 {
-	struct am65_cpsw_port *port;
+	int ret;
 	int i;
 
 	for (i = 0; i < common->port_num; i++) {
-		port = &common->ports[i];
-		if (!port->ndev)
-			continue;
-		if (port->ndev->reg_state == NETREG_REGISTERED)
-			unregister_netdev(port->ndev);
-		free_netdev(port->ndev);
-		port->ndev = NULL;
+		ret = am65_cpsw_nuss_init_port_ndev(common, i);
+		if (ret)
+			return ret;
 	}
+
+	return ret;
 }
 
 static void am65_cpsw_port_offload_fwd_mark_update(struct am65_cpsw_common *common)
@@ -3338,21 +3296,29 @@ static void am65_cpsw_unregister_devlink(struct am65_cpsw_common *common)
 	devlink_free(common->devlink);
 }
 
-static int am65_cpsw_nuss_register_ndevs(struct am65_cpsw_common *common)
+static void am65_cpsw_nuss_cleanup_chns(struct am65_cpsw_common *common)
+{
+	am65_cpsw_nuss_cleanup_rx_chns(common);
+	am65_cpsw_nuss_cleanup_tx_chns(common);
+}
+
+static int am65_cpsw_nuss_init_chns(struct am65_cpsw_common *common)
 {
 	struct am65_cpsw_rx_chn *rx_chan = &common->rx_chns;
 	struct am65_cpsw_tx_chn *tx_chan = common->tx_chns;
-	struct device *dev = common->dev;
-	struct am65_cpsw_port *port;
-	int ret = 0, i;
+	int ret, i;
 
 	/* init tx channels */
 	ret = am65_cpsw_nuss_init_tx_chns(common);
 	if (ret)
 		return ret;
+
+	/* init rx channels */
 	ret = am65_cpsw_nuss_init_rx_chns(common);
-	if (ret)
+	if (ret) {
+		am65_cpsw_nuss_cleanup_tx_chns(common);
 		return ret;
+	}
 
 	/* The DMA Channels are not guaranteed to be in a clean state.
 	 * Reset and disable them to ensure that they are back to the
@@ -3371,13 +3337,32 @@ static int am65_cpsw_nuss_register_ndevs(struct am65_cpsw_common *common)
 
 	k3_udma_glue_disable_rx_chn(rx_chan->rx_chn);
 
-	ret = am65_cpsw_nuss_register_devlink(common);
-	if (ret)
-		return ret;
+	return 0;
+}
+
+static void am65_cpsw_nuss_unregister_ndev(struct am65_cpsw_common *common)
+{
+	struct am65_cpsw_port *port;
+	int i;
 
 	for (i = 0; i < common->port_num; i++) {
 		port = &common->ports[i];
+		if (!port->ndev)
+			continue;
+
+		if (port->ndev->reg_state == NETREG_REGISTERED)
+			unregister_netdev(port->ndev);
+	}
+}
+
+static int am65_cpsw_nuss_register_ndevs(struct am65_cpsw_common *common)
+{
+	struct device *dev = common->dev;
+	struct am65_cpsw_port *port;
+	int ret = 0, i;
 
+	for (i = 0; i < common->port_num; i++) {
+		port = &common->ports[i];
 		if (!port->ndev)
 			continue;
 
@@ -3387,25 +3372,11 @@ static int am65_cpsw_nuss_register_ndevs(struct am65_cpsw_common *common)
 		if (ret) {
 			dev_err(dev, "error registering slave net device%i %d\n",
 				i, ret);
-			goto err_cleanup_ndev;
+			return ret;
 		}
 	}
 
-	ret = am65_cpsw_register_notifiers(common);
-	if (ret)
-		goto err_cleanup_ndev;
-
-	/* can't auto unregister ndev using devm_add_action() due to
-	 * devres release sequence in DD core for DMA
-	 */
-
 	return 0;
-
-err_cleanup_ndev:
-	am65_cpsw_nuss_cleanup_ndev(common);
-	am65_cpsw_unregister_devlink(common);
-
-	return ret;
 }
 
 int am65_cpsw_nuss_update_tx_rx_chns(struct am65_cpsw_common *common,
@@ -3413,17 +3384,10 @@ int am65_cpsw_nuss_update_tx_rx_chns(struct am65_cpsw_common *common,
 {
 	int ret;
 
-	am65_cpsw_nuss_remove_tx_chns(common);
-	am65_cpsw_nuss_remove_rx_chns(common);
-
+	am65_cpsw_nuss_cleanup_chns(common);
 	common->tx_ch_num = num_tx;
 	common->rx_ch_num_flows = num_rx;
-	ret = am65_cpsw_nuss_init_tx_chns(common);
-	if (ret)
-		return ret;
-
-	ret = am65_cpsw_nuss_init_rx_chns(common);
-
+	ret = am65_cpsw_nuss_init_chns(common);
 	return ret;
 }
 
@@ -3599,7 +3563,7 @@ static int am65_cpsw_nuss_probe(struct platform_device *pdev)
 
 	ret = am65_cpsw_nuss_init_slave_ports(common);
 	if (ret)
-		goto err_of_clear;
+		goto err_ports_clear;
 
 	/* init common data */
 	ale_params.dev = dev;
@@ -3613,7 +3577,7 @@ static int am65_cpsw_nuss_probe(struct platform_device *pdev)
 	if (IS_ERR(common->ale)) {
 		dev_err(dev, "error initializing ale engine\n");
 		ret = PTR_ERR(common->ale);
-		goto err_of_clear;
+		goto err_ports_clear;
 	}
 
 	ale_entries = common->ale->params.ale_entries;
@@ -3622,7 +3586,7 @@ static int am65_cpsw_nuss_probe(struct platform_device *pdev)
 					   GFP_KERNEL);
 	ret = am65_cpsw_init_cpts(common);
 	if (ret)
-		goto err_of_clear;
+		goto err_ports_clear;
 
 	/* init ports */
 	for (i = 0; i < common->port_num; i++)
@@ -3634,19 +3598,39 @@ static int am65_cpsw_nuss_probe(struct platform_device *pdev)
 
 	ret = am65_cpsw_nuss_init_ndevs(common);
 	if (ret)
-		goto err_ndevs_clear;
+		goto err_cpts_release;
+
+	ret = am65_cpsw_nuss_init_chns(common);
+	if (ret)
+		goto err_cleanup_ndevs;
+
+	ret = am65_cpsw_nuss_register_devlink(common);
+	if (ret)
+		goto err_cleanup_chns;
 
 	ret = am65_cpsw_nuss_register_ndevs(common);
 	if (ret)
-		goto err_ndevs_clear;
+		goto err_unregister_devlink;
+
+	ret = am65_cpsw_register_notifiers(common);
+	if (ret)
+		goto err_unregister_ndev;
 
 	pm_runtime_put(dev);
 	return 0;
 
-err_ndevs_clear:
-	am65_cpsw_nuss_cleanup_ndev(common);
-	am65_cpsw_nuss_phylink_cleanup(common);
+err_unregister_ndev:
+	am65_cpsw_nuss_unregister_ndev(common);
+err_unregister_devlink:
+	am65_cpsw_unregister_devlink(common);
+err_cleanup_chns:
+	am65_cpsw_nuss_cleanup_chns(common);
+err_cleanup_ndevs:
+	am65_cpsw_nuss_cleanup_ndevs(common);
+err_cpts_release:
 	am65_cpts_release(common->cpts);
+err_ports_clear:
+	am65_cpsw_nuss_cleanup_slave_ports(common);
 err_of_clear:
 	if (common->mdio_dev)
 		of_platform_device_destroy(common->mdio_dev, NULL);
@@ -3675,15 +3659,12 @@ static void am65_cpsw_nuss_remove(struct platform_device *pdev)
 	}
 
 	am65_cpsw_unregister_notifiers(common);
-
-	/* must unregister ndevs here because DD release_driver routine calls
-	 * dma_deconfigure(dev) before devres_release_all(dev)
-	 */
-	am65_cpsw_nuss_cleanup_ndev(common);
+	am65_cpsw_nuss_unregister_ndev(common);
 	am65_cpsw_unregister_devlink(common);
-	am65_cpsw_nuss_phylink_cleanup(common);
+	am65_cpsw_nuss_cleanup_chns(common);
+	am65_cpsw_nuss_cleanup_ndevs(common);
 	am65_cpts_release(common->cpts);
-	am65_cpsw_disable_serdes_phy(common);
+	am65_cpsw_nuss_cleanup_slave_ports(common);
 
 	if (common->mdio_dev)
 		of_platform_device_destroy(common->mdio_dev, NULL);
@@ -3723,9 +3704,7 @@ static int am65_cpsw_nuss_suspend(struct device *dev)
 	}
 
 	am65_cpts_suspend(common->cpts);
-
-	am65_cpsw_nuss_remove_rx_chns(common);
-	am65_cpsw_nuss_remove_tx_chns(common);
+	am65_cpsw_nuss_cleanup_chns(common);
 
 	return 0;
 }
@@ -3738,10 +3717,7 @@ static int am65_cpsw_nuss_resume(struct device *dev)
 	struct net_device *ndev;
 	int i, ret;
 
-	ret = am65_cpsw_nuss_init_tx_chns(common);
-	if (ret)
-		return ret;
-	ret = am65_cpsw_nuss_init_rx_chns(common);
+	ret = am65_cpsw_nuss_init_chns(common);
 	if (ret)
 		return ret;
 

-- 
2.34.1


