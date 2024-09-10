Return-Path: <bpf+bounces-39420-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 504EB972D75
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 11:24:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A83ED1F25A4F
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 09:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FD9C18A950;
	Tue, 10 Sep 2024 09:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A1mewtVy"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093BA1862B8;
	Tue, 10 Sep 2024 09:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725960256; cv=none; b=fgjD1qWDRFyglGq8VgIg9pgUwtvPuW4CXJIKe0TpzrIMmcA8s9UwTwKb1ta89mQvV1qeK92XBMTfkR9/ELe5AcMs+wucDcWHC3YAuUvo39mgDRXDrq25Sp7MruC+74+ZMrGWlccby+YtNdQhXWhZIoAqKjfkaPhhjaS6CTYwDDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725960256; c=relaxed/simple;
	bh=oiMDr8GVpy2/eCsn4LQi/DBcLJpd8KocoE9O2gr3Ps8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cj5lZJjdrUf1NlgMVfl4zozB8Ife+OtKY8z3moDBIBgtU+LIAuld9APBppr24OwAlARg4VEZyDXjYpqc4YdwWJ7zSs6rZwF2wMUMIglYu+t8s2EvBiV+QavY0OHKFp8ucRyU/ny5xWIfLP4gu7ztvzXKg6Le/dh3gq0CDG28AjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A1mewtVy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2236C4CEC6;
	Tue, 10 Sep 2024 09:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725960255;
	bh=oiMDr8GVpy2/eCsn4LQi/DBcLJpd8KocoE9O2gr3Ps8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=A1mewtVy0uIDfbixLaAnUa0/HctR5D+BpsfY58FvG+8ozQv4VV2dyyp2Oj8kHRhOc
	 DI5d9FpzQwSwurFU67eOitEOdSR02OLyx+d2dXba2FhzC3xjOwA5PJwUAnPlD2r92+
	 5IM1e99kfkKdZB20+pytFAKC9nrAch2DDK7toV4kwkEsYlT3iKznTtcQoV5G9ZB3fi
	 fxq0AK+okP9ylT/dVJbseFKkP/5SMXnoeDhXnWIJrC+eXrIGveuE9R5kJTTCYKg9Ok
	 IV0Ejib9CgfoHN4G0mCsPIeZJ3FqRmloubmmhKcgoFxbKewn5pYKqtGQg8na2Xkee2
	 ArZIpYJj8YM1A==
From: Roger Quadros <rogerq@kernel.org>
Date: Tue, 10 Sep 2024 12:23:58 +0300
Subject: [PATCH net-next v4 1/6] net: ethernet: ti: am65-cpsw: Introduce
 multi queue Rx
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240910-am65-cpsw-multi-rx-v4-1-077fa6403043@kernel.org>
References: <20240910-am65-cpsw-multi-rx-v4-0-077fa6403043@kernel.org>
In-Reply-To: <20240910-am65-cpsw-multi-rx-v4-0-077fa6403043@kernel.org>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Siddharth Vadapalli <s-vadapalli@ti.com>, 
 Julien Panis <jpanis@baylibre.com>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>
Cc: Simon Horman <horms@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
 Joe Damato <jdamato@fastly.com>, srk@ti.com, vigneshr@ti.com, 
 danishanwar@ti.com, pekka Varis <p-varis@ti.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, 
 bpf@vger.kernel.org, Roger Quadros <rogerq@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=34010; i=rogerq@kernel.org;
 h=from:subject:message-id; bh=oiMDr8GVpy2/eCsn4LQi/DBcLJpd8KocoE9O2gr3Ps8=;
 b=owEBbQKS/ZANAwAIAdJaa9O+djCTAcsmYgBm4BA0lpO9weXNRuzYjzLiy/EkFCTT9ESQnz5ds
 IQjcHhn6jKJAjMEAAEIAB0WIQRBIWXUTJ9SeA+rEFjSWmvTvnYwkwUCZuAQNAAKCRDSWmvTvnYw
 k9fxD/4tLHjnCm7ZRdlJLvWuLKyGY3ZlTC6Jm2aJQG9sJvoZah4Q5X/+eZ7O/Jhr0CxFzTIihwb
 45gWvGRipwKSlpl6npeC8mm7Aj1E3FzkcXoqxmRh+Ml87OkhTPlTLIcpv8aluPHisYEQjOA08NO
 xa7WmbBarYax0tBZvaPoqJHfUGClIJTRDZMUMxp+OJGIaqeLq2rcnpvcLfTdck/IcqNp2sdQ3ID
 sMI8fqovQxXau5JzNPm50ofX/fGRACdzYZfuDM+en2rv74juzw5tKLemSIbjm/wso/62ri+0do7
 ZhokV4QZj7qySk+8yXg2WvgK4YtbI1uM5Qahs6X4Q8ctlUFXmpCUt6QDqVuXdc9Z4i/YPT7PLvz
 BPpPakQxm2wdFKWWMOhprLXE1qbH5ITXSfNbAJWinkw45mS7cqyaCMW3S1n2y2H0S3HixYCbmFg
 +fcjPwY1bGpGOiIVsBN08fmHXIJKFDuw5hB7NCvZ0MWSu3zJXMZNqtJ51+1z8M7uxfN/P9Evg6z
 vuzCnpYS/jQ+TPB0GlPLOnSxw4jES6Lp6kYZQ8mZj2AcK+gkrho6pReBzsBIVswLP9lyeC+DaSj
 sx2PuntvpIZge3ETtHkAI2Chb1fKhfi8gRprtUn6BWeWPUjBOnforcRD2Lo02UqN49KcFuGPeF7
 PpqR1NAWCFw3S3g==
X-Developer-Key: i=rogerq@kernel.org; a=openpgp;
 fpr=412165D44C9F52780FAB1058D25A6BD3BE763093

am65-cpsw can support up to 8 queues at Rx.
Use a macro AM65_CPSW_MAX_RX_QUEUES to indicate that.
As there is only one DMA channel for RX traffic, the
8 queues come as 8 flows in that channel.

By default, we will start with 1 flow as defined by the
macro AM65_CPSW_DEFAULT_RX_CHN_FLOWS.

User can change the number of flows by ethtool like so
'ethtool -L ethx rx <N>'

All traffic will still come on flow 0. To get traffic on
different flows the Classifiers will need to be set up.

Signed-off-by: Roger Quadros <rogerq@kernel.org>
Reviewed-by: Simon Horman <horms@kernel.org>
---
Changelog:
v4:
- Use single macro AM65_CPSW_MAX_QUEUES for both TX and RX queues
  to simplify code
- reuse am65_cpsw_get/set_per_queue_coalesce for am65_cpsw_get/set_coalesce.
- Return -EINVAL if unsupported tx/rx_coalesce_usecs in
  am65_cpsw_set_coalesce.
- move am65_cpsw_nuss_remove_rx/tx_chns() to am65_cpsw_nuss_update_tx_rx_chns()
- don't set skip_fdq during k3_udma_glue_reset_rx_chn(). Fixes breakage
  during ifdown/up.

v3:
- style fixes: reverse xmas tree and checkpatch.pl --max-line-length=80
- typo fix: Classifer -> Classifier
- added Reviewed-by Simon Horman
---
 drivers/net/ethernet/ti/am65-cpsw-ethtool.c |  75 +++---
 drivers/net/ethernet/ti/am65-cpsw-nuss.c    | 385 ++++++++++++++++------------
 drivers/net/ethernet/ti/am65-cpsw-nuss.h    |  39 +--
 3 files changed, 269 insertions(+), 230 deletions(-)

diff --git a/drivers/net/ethernet/ti/am65-cpsw-ethtool.c b/drivers/net/ethernet/ti/am65-cpsw-ethtool.c
index 539d5ca82f52..9032444435e9 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-ethtool.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-ethtool.c
@@ -427,9 +427,9 @@ static void am65_cpsw_get_channels(struct net_device *ndev,
 {
 	struct am65_cpsw_common *common = am65_ndev_to_common(ndev);
 
-	ch->max_rx = AM65_CPSW_MAX_RX_QUEUES;
-	ch->max_tx = AM65_CPSW_MAX_TX_QUEUES;
-	ch->rx_count = AM65_CPSW_MAX_RX_QUEUES;
+	ch->max_rx = AM65_CPSW_MAX_QUEUES;
+	ch->max_tx = AM65_CPSW_MAX_QUEUES;
+	ch->rx_count = common->rx_ch_num_flows;
 	ch->tx_count = common->tx_ch_num;
 }
 
@@ -447,9 +447,8 @@ static int am65_cpsw_set_channels(struct net_device *ndev,
 	if (common->usage_count)
 		return -EBUSY;
 
-	am65_cpsw_nuss_remove_tx_chns(common);
-
-	return am65_cpsw_nuss_update_tx_chns(common, chs->tx_count);
+	return am65_cpsw_nuss_update_tx_rx_chns(common, chs->tx_count,
+						chs->rx_count);
 }
 
 static void
@@ -913,80 +912,64 @@ static void am65_cpsw_get_mm_stats(struct net_device *ndev,
 	s->MACMergeHoldCount = readl(base + AM65_CPSW_STATN_IET_TX_HOLD);
 }
 
-static int am65_cpsw_get_coalesce(struct net_device *ndev, struct ethtool_coalesce *coal,
-				  struct kernel_ethtool_coalesce *kernel_coal,
-				  struct netlink_ext_ack *extack)
-{
-	struct am65_cpsw_common *common = am65_ndev_to_common(ndev);
-	struct am65_cpsw_tx_chn *tx_chn;
-
-	tx_chn = &common->tx_chns[0];
-
-	coal->rx_coalesce_usecs = common->rx_pace_timeout / 1000;
-	coal->tx_coalesce_usecs = tx_chn->tx_pace_timeout / 1000;
-
-	return 0;
-}
-
 static int am65_cpsw_get_per_queue_coalesce(struct net_device *ndev, u32 queue,
 					    struct ethtool_coalesce *coal)
 {
 	struct am65_cpsw_common *common = am65_ndev_to_common(ndev);
+	struct am65_cpsw_rx_flow *rx_flow;
 	struct am65_cpsw_tx_chn *tx_chn;
 
-	if (queue >= AM65_CPSW_MAX_TX_QUEUES)
+	if (queue >= AM65_CPSW_MAX_QUEUES)
 		return -EINVAL;
 
 	tx_chn = &common->tx_chns[queue];
-
 	coal->tx_coalesce_usecs = tx_chn->tx_pace_timeout / 1000;
 
+	rx_flow = &common->rx_chns.flows[queue];
+	coal->rx_coalesce_usecs = rx_flow->rx_pace_timeout / 1000;
+
 	return 0;
 }
 
-static int am65_cpsw_set_coalesce(struct net_device *ndev, struct ethtool_coalesce *coal,
+static int am65_cpsw_get_coalesce(struct net_device *ndev, struct ethtool_coalesce *coal,
 				  struct kernel_ethtool_coalesce *kernel_coal,
 				  struct netlink_ext_ack *extack)
 {
-	struct am65_cpsw_common *common = am65_ndev_to_common(ndev);
-	struct am65_cpsw_tx_chn *tx_chn;
-
-	tx_chn = &common->tx_chns[0];
-
-	if (coal->rx_coalesce_usecs && coal->rx_coalesce_usecs < 20)
-		return -EINVAL;
-
-	if (coal->tx_coalesce_usecs && coal->tx_coalesce_usecs < 20)
-		return -EINVAL;
-
-	common->rx_pace_timeout = coal->rx_coalesce_usecs * 1000;
-	tx_chn->tx_pace_timeout = coal->tx_coalesce_usecs * 1000;
-
-	return 0;
+	return am65_cpsw_get_per_queue_coalesce(ndev, 0, coal);
 }
 
 static int am65_cpsw_set_per_queue_coalesce(struct net_device *ndev, u32 queue,
 					    struct ethtool_coalesce *coal)
 {
 	struct am65_cpsw_common *common = am65_ndev_to_common(ndev);
+	struct am65_cpsw_rx_flow *rx_flow;
 	struct am65_cpsw_tx_chn *tx_chn;
 
-	if (queue >= AM65_CPSW_MAX_TX_QUEUES)
+	if (queue >= AM65_CPSW_MAX_QUEUES)
 		return -EINVAL;
 
 	tx_chn = &common->tx_chns[queue];
-
-	if (coal->tx_coalesce_usecs && coal->tx_coalesce_usecs < 20) {
-		dev_info(common->dev, "defaulting to min value of 20us for tx-usecs for tx-%u\n",
-			 queue);
-		coal->tx_coalesce_usecs = 20;
-	}
+	if (coal->tx_coalesce_usecs && coal->tx_coalesce_usecs < 20)
+		return -EINVAL;
 
 	tx_chn->tx_pace_timeout = coal->tx_coalesce_usecs * 1000;
 
+	rx_flow = &common->rx_chns.flows[queue];
+	if (coal->rx_coalesce_usecs && coal->rx_coalesce_usecs < 20)
+		return -EINVAL;
+
+	rx_flow->rx_pace_timeout = coal->rx_coalesce_usecs * 1000;
+
 	return 0;
 }
 
+static int am65_cpsw_set_coalesce(struct net_device *ndev, struct ethtool_coalesce *coal,
+				  struct kernel_ethtool_coalesce *kernel_coal,
+				  struct netlink_ext_ack *extack)
+{
+	return am65_cpsw_set_per_queue_coalesce(ndev, 0, coal);
+}
+
 const struct ethtool_ops am65_cpsw_ethtool_ops_slave = {
 	.begin			= am65_cpsw_ethtool_op_begin,
 	.complete		= am65_cpsw_ethtool_op_complete,
diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
index b7e5d0fb5d19..76e62351b30b 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
@@ -138,7 +138,7 @@
 	 AM65_CPSW_PN_TS_CTL_RX_ANX_F_EN)
 
 #define AM65_CPSW_ALE_AGEOUT_DEFAULT	30
-/* Number of TX/RX descriptors */
+/* Number of TX/RX descriptors per channel/flow */
 #define AM65_CPSW_MAX_TX_DESC	500
 #define AM65_CPSW_MAX_RX_DESC	500
 
@@ -150,6 +150,7 @@
 			 NETIF_MSG_RX_ERR | NETIF_MSG_TX_ERR)
 
 #define AM65_CPSW_DEFAULT_TX_CHNS	8
+#define AM65_CPSW_DEFAULT_RX_CHN_FLOWS	1
 
 /* CPPI streaming packet interface */
 #define AM65_CPSW_CPPI_TX_FLOW_ID  0x3FFF
@@ -331,7 +332,7 @@ static void am65_cpsw_nuss_ndo_host_tx_timeout(struct net_device *ndev,
 }
 
 static int am65_cpsw_nuss_rx_push(struct am65_cpsw_common *common,
-				  struct page *page)
+				  struct page *page, u32 flow_idx)
 {
 	struct am65_cpsw_rx_chn *rx_chn = &common->rx_chns;
 	struct cppi5_host_desc_t *desc_rx;
@@ -364,7 +365,8 @@ static int am65_cpsw_nuss_rx_push(struct am65_cpsw_common *common,
 	swdata = cppi5_hdesc_get_swdata(desc_rx);
 	*((void **)swdata) = page_address(page);
 
-	return k3_udma_glue_push_rx_chn(rx_chn->rx_chn, 0, desc_rx, desc_dma);
+	return k3_udma_glue_push_rx_chn(rx_chn->rx_chn, flow_idx,
+					desc_rx, desc_dma);
 }
 
 void am65_cpsw_nuss_set_p0_ptype(struct am65_cpsw_common *common)
@@ -399,22 +401,27 @@ static void am65_cpsw_init_port_emac_ale(struct am65_cpsw_port *port);
 static void am65_cpsw_destroy_xdp_rxqs(struct am65_cpsw_common *common)
 {
 	struct am65_cpsw_rx_chn *rx_chn = &common->rx_chns;
+	struct am65_cpsw_rx_flow *flow;
 	struct xdp_rxq_info *rxq;
-	int i;
+	int id, port;
 
-	for (i = 0; i < common->port_num; i++) {
-		if (!common->ports[i].ndev)
-			continue;
+	for (id = 0; id < common->rx_ch_num_flows; id++) {
+		flow = &rx_chn->flows[id];
 
-		rxq = &common->ports[i].xdp_rxq;
+		for (port = 0; port < common->port_num; port++) {
+			if (!common->ports[port].ndev)
+				continue;
 
-		if (xdp_rxq_info_is_reg(rxq))
-			xdp_rxq_info_unreg(rxq);
-	}
+			rxq = &common->ports[port].xdp_rxq[id];
+
+			if (xdp_rxq_info_is_reg(rxq))
+				xdp_rxq_info_unreg(rxq);
+		}
 
-	if (rx_chn->page_pool) {
-		page_pool_destroy(rx_chn->page_pool);
-		rx_chn->page_pool = NULL;
+		if (flow->page_pool) {
+			page_pool_destroy(flow->page_pool);
+			flow->page_pool = NULL;
+		}
 	}
 }
 
@@ -428,31 +435,44 @@ static int am65_cpsw_create_xdp_rxqs(struct am65_cpsw_common *common)
 		.nid = dev_to_node(common->dev),
 		.dev = common->dev,
 		.dma_dir = DMA_BIDIRECTIONAL,
-		.napi = &common->napi_rx,
+		/* .napi set dynamically */
 	};
+	struct am65_cpsw_rx_flow *flow;
 	struct xdp_rxq_info *rxq;
 	struct page_pool *pool;
-	int i, ret;
-
-	pool = page_pool_create(&pp_params);
-	if (IS_ERR(pool))
-		return PTR_ERR(pool);
+	int id, port, ret;
+
+	for (id = 0; id < common->rx_ch_num_flows; id++) {
+		flow = &rx_chn->flows[id];
+		pp_params.napi = &flow->napi_rx;
+		pool = page_pool_create(&pp_params);
+		if (IS_ERR(pool)) {
+			ret = PTR_ERR(pool);
+			goto err;
+		}
 
-	rx_chn->page_pool = pool;
+		flow->page_pool = pool;
 
-	for (i = 0; i < common->port_num; i++) {
-		if (!common->ports[i].ndev)
-			continue;
+		/* using same page pool is allowed as no running rx handlers
+		 * simultaneously for both ndevs
+		 */
+		for (port = 0; port < common->port_num; port++) {
+			if (!common->ports[port].ndev)
+				continue;
 
-		rxq = &common->ports[i].xdp_rxq;
+			rxq = &common->ports[port].xdp_rxq[id];
 
-		ret = xdp_rxq_info_reg(rxq, common->ports[i].ndev, i, 0);
-		if (ret)
-			goto err;
+			ret = xdp_rxq_info_reg(rxq, common->ports[port].ndev,
+					       id, flow->napi_rx.napi_id);
+			if (ret)
+				goto err;
 
-		ret = xdp_rxq_info_reg_mem_model(rxq, MEM_TYPE_PAGE_POOL, pool);
-		if (ret)
-			goto err;
+			ret = xdp_rxq_info_reg_mem_model(rxq,
+							 MEM_TYPE_PAGE_POOL,
+							 pool);
+			if (ret)
+				goto err;
+		}
 	}
 
 	return 0;
@@ -497,25 +517,27 @@ static enum am65_cpsw_tx_buf_type am65_cpsw_nuss_buf_type(struct am65_cpsw_tx_ch
 								       desc_idx);
 }
 
-static inline void am65_cpsw_put_page(struct am65_cpsw_rx_chn *rx_chn,
+static inline void am65_cpsw_put_page(struct am65_cpsw_rx_flow *flow,
 				      struct page *page,
 				      bool allow_direct,
 				      int desc_idx)
 {
-	page_pool_put_full_page(rx_chn->page_pool, page, allow_direct);
-	rx_chn->pages[desc_idx] = NULL;
+	page_pool_put_full_page(flow->page_pool, page, allow_direct);
+	flow->pages[desc_idx] = NULL;
 }
 
 static void am65_cpsw_nuss_rx_cleanup(void *data, dma_addr_t desc_dma)
 {
-	struct am65_cpsw_rx_chn *rx_chn = data;
+	struct am65_cpsw_rx_flow *flow = data;
 	struct cppi5_host_desc_t *desc_rx;
+	struct am65_cpsw_rx_chn *rx_chn;
 	dma_addr_t buf_dma;
 	u32 buf_dma_len;
 	void *page_addr;
 	void **swdata;
 	int desc_idx;
 
+	rx_chn = &flow->common->rx_chns;
 	desc_rx = k3_cppi_desc_pool_dma2virt(rx_chn->desc_pool, desc_dma);
 	swdata = cppi5_hdesc_get_swdata(desc_rx);
 	page_addr = *swdata;
@@ -526,7 +548,7 @@ static void am65_cpsw_nuss_rx_cleanup(void *data, dma_addr_t desc_dma)
 
 	desc_idx = am65_cpsw_nuss_desc_idx(rx_chn->desc_pool, desc_rx,
 					   rx_chn->dsize_log2);
-	am65_cpsw_put_page(rx_chn, virt_to_page(page_addr), false, desc_idx);
+	am65_cpsw_put_page(flow, virt_to_page(page_addr), false, desc_idx);
 }
 
 static void am65_cpsw_nuss_xmit_free(struct am65_cpsw_tx_chn *tx_chn,
@@ -602,7 +624,8 @@ static int am65_cpsw_nuss_common_open(struct am65_cpsw_common *common)
 	struct am65_cpsw_host *host_p = am65_common_get_host(common);
 	struct am65_cpsw_rx_chn *rx_chn = &common->rx_chns;
 	struct am65_cpsw_tx_chn *tx_chn = common->tx_chns;
-	int port_idx, i, ret, tx;
+	int port_idx, i, ret, tx, flow_idx;
+	struct am65_cpsw_rx_flow *flow;
 	u32 val, port_mask;
 	struct page *page;
 
@@ -670,27 +693,26 @@ static int am65_cpsw_nuss_common_open(struct am65_cpsw_common *common)
 		return ret;
 	}
 
-	for (i = 0; i < rx_chn->descs_num; i++) {
-		page = page_pool_dev_alloc_pages(rx_chn->page_pool);
-		if (!page) {
-			ret = -ENOMEM;
-			if (i)
+	for (flow_idx = 0; flow_idx < common->rx_ch_num_flows; flow_idx++) {
+		flow = &rx_chn->flows[flow_idx];
+		for (i = 0; i < AM65_CPSW_MAX_RX_DESC; i++) {
+			page = page_pool_dev_alloc_pages(flow->page_pool);
+			if (!page) {
+				dev_err(common->dev, "cannot allocate page in flow %d\n",
+					flow_idx);
+				ret = -ENOMEM;
 				goto fail_rx;
+			}
+			flow->pages[i] = page;
 
-			return ret;
-		}
-		rx_chn->pages[i] = page;
-
-		ret = am65_cpsw_nuss_rx_push(common, page);
-		if (ret < 0) {
-			dev_err(common->dev,
-				"cannot submit page to channel rx: %d\n",
-				ret);
-			am65_cpsw_put_page(rx_chn, page, false, i);
-			if (i)
+			ret = am65_cpsw_nuss_rx_push(common, page, flow_idx);
+			if (ret < 0) {
+				dev_err(common->dev,
+					"cannot submit page to rx channel flow %d, error %d\n",
+					flow_idx, ret);
+				am65_cpsw_put_page(flow, page, false, i);
 				goto fail_rx;
-
-			return ret;
+			}
 		}
 	}
 
@@ -700,6 +722,14 @@ static int am65_cpsw_nuss_common_open(struct am65_cpsw_common *common)
 		goto fail_rx;
 	}
 
+	for (i = 0; i < common->rx_ch_num_flows ; i++) {
+		napi_enable(&rx_chn->flows[i].napi_rx);
+		if (rx_chn->flows[i].irq_disabled) {
+			rx_chn->flows[i].irq_disabled = false;
+			enable_irq(rx_chn->flows[i].irq);
+		}
+	}
+
 	for (tx = 0; tx < common->tx_ch_num; tx++) {
 		ret = k3_udma_glue_enable_tx_chn(tx_chn[tx].tx_chn);
 		if (ret) {
@@ -711,12 +741,6 @@ static int am65_cpsw_nuss_common_open(struct am65_cpsw_common *common)
 		napi_enable(&tx_chn[tx].napi_tx);
 	}
 
-	napi_enable(&common->napi_rx);
-	if (common->rx_irq_disabled) {
-		common->rx_irq_disabled = false;
-		enable_irq(rx_chn->irq);
-	}
-
 	dev_dbg(common->dev, "cpsw_nuss started\n");
 	return 0;
 
@@ -727,11 +751,24 @@ static int am65_cpsw_nuss_common_open(struct am65_cpsw_common *common)
 		tx--;
 	}
 
+	for (flow_idx = 0; i < common->rx_ch_num_flows; flow_idx++) {
+		flow = &rx_chn->flows[flow_idx];
+		if (!flow->irq_disabled) {
+			disable_irq(flow->irq);
+			flow->irq_disabled = true;
+		}
+		napi_disable(&flow->napi_rx);
+	}
+
 	k3_udma_glue_disable_rx_chn(rx_chn->rx_chn);
 
 fail_rx:
-	k3_udma_glue_reset_rx_chn(rx_chn->rx_chn, 0, rx_chn,
-				  am65_cpsw_nuss_rx_cleanup, 0);
+	for (i = 0; i < common->rx_ch_num_flows; i--)
+		k3_udma_glue_reset_rx_chn(rx_chn->rx_chn, i, &rx_chn->flows[i],
+					  am65_cpsw_nuss_rx_cleanup, 0);
+
+	am65_cpsw_destroy_xdp_rxqs(common);
+
 	return ret;
 }
 
@@ -780,12 +817,12 @@ static int am65_cpsw_nuss_common_stop(struct am65_cpsw_common *common)
 			dev_err(common->dev, "rx teardown timeout\n");
 	}
 
-	napi_disable(&common->napi_rx);
-	hrtimer_cancel(&common->rx_hrtimer);
-
-	for (i = 0; i < AM65_CPSW_MAX_RX_FLOWS; i++)
-		k3_udma_glue_reset_rx_chn(rx_chn->rx_chn, i, rx_chn,
-					  am65_cpsw_nuss_rx_cleanup, !!i);
+	for (i = 0; i < common->rx_ch_num_flows; i++) {
+		napi_disable(&rx_chn->flows[i].napi_rx);
+		hrtimer_cancel(&rx_chn->flows[i].rx_hrtimer);
+		k3_udma_glue_reset_rx_chn(rx_chn->rx_chn, i, &rx_chn->flows[i],
+					  am65_cpsw_nuss_rx_cleanup, 0);
+	}
 
 	k3_udma_glue_disable_rx_chn(rx_chn->rx_chn);
 
@@ -794,10 +831,6 @@ static int am65_cpsw_nuss_common_stop(struct am65_cpsw_common *common)
 	writel(0, common->cpsw_base + AM65_CPSW_REG_CTL);
 	writel(0, common->cpsw_base + AM65_CPSW_REG_STAT_PORT_EN);
 
-	for (i = 0; i < rx_chn->descs_num; i++) {
-		if (rx_chn->pages[i])
-			am65_cpsw_put_page(rx_chn, rx_chn->pages[i], false, i);
-	}
 	am65_cpsw_destroy_xdp_rxqs(common);
 
 	dev_dbg(common->dev, "cpsw_nuss stopped\n");
@@ -868,7 +901,7 @@ static int am65_cpsw_nuss_ndo_slave_open(struct net_device *ndev)
 		goto runtime_put;
 	}
 
-	ret = netif_set_real_num_rx_queues(ndev, AM65_CPSW_MAX_RX_QUEUES);
+	ret = netif_set_real_num_rx_queues(ndev, common->rx_ch_num_flows);
 	if (ret) {
 		dev_err(common->dev, "cannot set real number of rx queues\n");
 		goto runtime_put;
@@ -992,12 +1025,12 @@ static int am65_cpsw_xdp_tx_frame(struct net_device *ndev,
 	return ret;
 }
 
-static int am65_cpsw_run_xdp(struct am65_cpsw_common *common,
+static int am65_cpsw_run_xdp(struct am65_cpsw_rx_flow *flow,
 			     struct am65_cpsw_port *port,
 			     struct xdp_buff *xdp,
 			     int desc_idx, int cpu, int *len)
 {
-	struct am65_cpsw_rx_chn *rx_chn = &common->rx_chns;
+	struct am65_cpsw_common *common = flow->common;
 	struct am65_cpsw_ndev_priv *ndev_priv;
 	struct net_device *ndev = port->ndev;
 	struct am65_cpsw_ndev_stats *stats;
@@ -1026,7 +1059,7 @@ static int am65_cpsw_run_xdp(struct am65_cpsw_common *common,
 		ret = AM65_CPSW_XDP_PASS;
 		goto out;
 	case XDP_TX:
-		tx_chn = &common->tx_chns[cpu % AM65_CPSW_MAX_TX_QUEUES];
+		tx_chn = &common->tx_chns[cpu % AM65_CPSW_MAX_QUEUES];
 		netif_txq = netdev_get_tx_queue(ndev, tx_chn->id);
 
 		xdpf = xdp_convert_buff_to_frame(xdp);
@@ -1068,7 +1101,8 @@ static int am65_cpsw_run_xdp(struct am65_cpsw_common *common,
 	}
 
 	page = virt_to_head_page(xdp->data);
-	am65_cpsw_put_page(rx_chn, page, true, desc_idx);
+	am65_cpsw_put_page(flow, page, true, desc_idx);
+
 out:
 	return ret;
 }
@@ -1106,11 +1140,12 @@ static void am65_cpsw_nuss_rx_csum(struct sk_buff *skb, u32 csum_info)
 	}
 }
 
-static int am65_cpsw_nuss_rx_packets(struct am65_cpsw_common *common,
-				     u32 flow_idx, int cpu, int *xdp_state)
+static int am65_cpsw_nuss_rx_packets(struct am65_cpsw_rx_flow *flow,
+				     int cpu, int *xdp_state)
 {
-	struct am65_cpsw_rx_chn *rx_chn = &common->rx_chns;
+	struct am65_cpsw_rx_chn *rx_chn = &flow->common->rx_chns;
 	u32 buf_dma_len, pkt_len, port_id = 0, csum_info;
+	struct am65_cpsw_common *common = flow->common;
 	struct am65_cpsw_ndev_priv *ndev_priv;
 	struct am65_cpsw_ndev_stats *stats;
 	struct cppi5_host_desc_t *desc_rx;
@@ -1120,6 +1155,7 @@ static int am65_cpsw_nuss_rx_packets(struct am65_cpsw_common *common,
 	struct am65_cpsw_port *port;
 	int headroom, desc_idx, ret;
 	struct net_device *ndev;
+	u32 flow_idx = flow->id;
 	struct sk_buff *skb;
 	struct xdp_buff	xdp;
 	void *page_addr;
@@ -1174,10 +1210,10 @@ static int am65_cpsw_nuss_rx_packets(struct am65_cpsw_common *common,
 	}
 
 	if (port->xdp_prog) {
-		xdp_init_buff(&xdp, PAGE_SIZE, &port->xdp_rxq);
+		xdp_init_buff(&xdp, PAGE_SIZE, &port->xdp_rxq[flow->id]);
 		xdp_prepare_buff(&xdp, page_addr, AM65_CPSW_HEADROOM,
 				 pkt_len, false);
-		*xdp_state = am65_cpsw_run_xdp(common, port, &xdp, desc_idx,
+		*xdp_state = am65_cpsw_run_xdp(flow, port, &xdp, desc_idx,
 					       cpu, &pkt_len);
 		if (*xdp_state != AM65_CPSW_XDP_PASS)
 			goto allocate;
@@ -1195,7 +1231,7 @@ static int am65_cpsw_nuss_rx_packets(struct am65_cpsw_common *common,
 	skb_mark_for_recycle(skb);
 	skb->protocol = eth_type_trans(skb, ndev);
 	am65_cpsw_nuss_rx_csum(skb, csum_info);
-	napi_gro_receive(&common->napi_rx, skb);
+	napi_gro_receive(&flow->napi_rx, skb);
 
 	stats = this_cpu_ptr(ndev_priv->stats);
 
@@ -1205,24 +1241,24 @@ static int am65_cpsw_nuss_rx_packets(struct am65_cpsw_common *common,
 	u64_stats_update_end(&stats->syncp);
 
 allocate:
-	new_page = page_pool_dev_alloc_pages(rx_chn->page_pool);
+	new_page = page_pool_dev_alloc_pages(flow->page_pool);
 	if (unlikely(!new_page)) {
 		dev_err(dev, "page alloc failed\n");
 		return -ENOMEM;
 	}
 
-	rx_chn->pages[desc_idx] = new_page;
+	flow->pages[desc_idx] = new_page;
 
 	if (netif_dormant(ndev)) {
-		am65_cpsw_put_page(rx_chn, new_page, true, desc_idx);
+		am65_cpsw_put_page(flow, new_page, true, desc_idx);
 		ndev->stats.rx_dropped++;
 		return 0;
 	}
 
 requeue:
-	ret = am65_cpsw_nuss_rx_push(common, new_page);
+	ret = am65_cpsw_nuss_rx_push(common, new_page, flow_idx);
 	if (WARN_ON(ret < 0)) {
-		am65_cpsw_put_page(rx_chn, new_page, true, desc_idx);
+		am65_cpsw_put_page(flow, new_page, true, desc_idx);
 		ndev->stats.rx_errors++;
 		ndev->stats.rx_dropped++;
 	}
@@ -1232,38 +1268,32 @@ static int am65_cpsw_nuss_rx_packets(struct am65_cpsw_common *common,
 
 static enum hrtimer_restart am65_cpsw_nuss_rx_timer_callback(struct hrtimer *timer)
 {
-	struct am65_cpsw_common *common =
-			container_of(timer, struct am65_cpsw_common, rx_hrtimer);
+	struct am65_cpsw_rx_flow *flow = container_of(timer,
+						      struct am65_cpsw_rx_flow,
+						      rx_hrtimer);
 
-	enable_irq(common->rx_chns.irq);
+	enable_irq(flow->irq);
 	return HRTIMER_NORESTART;
 }
 
 static int am65_cpsw_nuss_rx_poll(struct napi_struct *napi_rx, int budget)
 {
-	struct am65_cpsw_common *common = am65_cpsw_napi_to_common(napi_rx);
-	int flow = AM65_CPSW_MAX_RX_FLOWS;
+	struct am65_cpsw_rx_flow *flow = am65_cpsw_napi_to_rx_flow(napi_rx);
+	struct am65_cpsw_common *common = flow->common;
 	int cpu = smp_processor_id();
 	int xdp_state_or = 0;
 	int cur_budget, ret;
 	int xdp_state;
 	int num_rx = 0;
 
-	/* process every flow */
-	while (flow--) {
-		cur_budget = budget - num_rx;
-
-		while (cur_budget--) {
-			ret = am65_cpsw_nuss_rx_packets(common, flow, cpu,
-							&xdp_state);
-			xdp_state_or |= xdp_state;
-			if (ret)
-				break;
-			num_rx++;
-		}
-
-		if (num_rx >= budget)
+	/* process only this flow */
+	cur_budget = budget;
+	while (cur_budget--) {
+		ret = am65_cpsw_nuss_rx_packets(flow, cpu, &xdp_state);
+		xdp_state_or |= xdp_state;
+		if (ret)
 			break;
+		num_rx++;
 	}
 
 	if (xdp_state_or & AM65_CPSW_XDP_REDIRECT)
@@ -1272,14 +1302,14 @@ static int am65_cpsw_nuss_rx_poll(struct napi_struct *napi_rx, int budget)
 	dev_dbg(common->dev, "%s num_rx:%d %d\n", __func__, num_rx, budget);
 
 	if (num_rx < budget && napi_complete_done(napi_rx, num_rx)) {
-		if (common->rx_irq_disabled) {
-			common->rx_irq_disabled = false;
-			if (unlikely(common->rx_pace_timeout)) {
-				hrtimer_start(&common->rx_hrtimer,
-					      ns_to_ktime(common->rx_pace_timeout),
+		if (flow->irq_disabled) {
+			flow->irq_disabled = false;
+			if (unlikely(flow->rx_pace_timeout)) {
+				hrtimer_start(&flow->rx_hrtimer,
+					      ns_to_ktime(flow->rx_pace_timeout),
 					      HRTIMER_MODE_REL_PINNED);
 			} else {
-				enable_irq(common->rx_chns.irq);
+				enable_irq(flow->irq);
 			}
 		}
 	}
@@ -1527,11 +1557,11 @@ static int am65_cpsw_nuss_tx_poll(struct napi_struct *napi_tx, int budget)
 
 static irqreturn_t am65_cpsw_nuss_rx_irq(int irq, void *dev_id)
 {
-	struct am65_cpsw_common *common = dev_id;
+	struct am65_cpsw_rx_flow *flow = dev_id;
 
-	common->rx_irq_disabled = true;
+	flow->irq_disabled = true;
 	disable_irq_nosync(irq);
-	napi_schedule(&common->napi_rx);
+	napi_schedule(&flow->napi_rx);
 
 	return IRQ_HANDLED;
 }
@@ -2176,7 +2206,7 @@ static void am65_cpsw_nuss_free_tx_chns(void *data)
 	}
 }
 
-void am65_cpsw_nuss_remove_tx_chns(struct am65_cpsw_common *common)
+static void am65_cpsw_nuss_remove_tx_chns(struct am65_cpsw_common *common)
 {
 	struct device *dev = common->dev;
 	int i;
@@ -2191,15 +2221,9 @@ void am65_cpsw_nuss_remove_tx_chns(struct am65_cpsw_common *common)
 			devm_free_irq(dev, tx_chn->irq, tx_chn);
 
 		netif_napi_del(&tx_chn->napi_tx);
-
-		if (!IS_ERR_OR_NULL(tx_chn->desc_pool))
-			k3_cppi_desc_pool_destroy(tx_chn->desc_pool);
-
-		if (!IS_ERR_OR_NULL(tx_chn->tx_chn))
-			k3_udma_glue_release_tx_chn(tx_chn->tx_chn);
-
-		memset(tx_chn, 0, sizeof(*tx_chn));
 	}
+
+	am65_cpsw_nuss_free_tx_chns(common);
 }
 
 static int am65_cpsw_nuss_ndev_add_tx_napi(struct am65_cpsw_common *common)
@@ -2331,19 +2355,22 @@ static void am65_cpsw_nuss_free_rx_chns(void *data)
 		k3_udma_glue_release_rx_chn(rx_chn->rx_chn);
 }
 
-static void am65_cpsw_nuss_remove_rx_chns(void *data)
+static void am65_cpsw_nuss_remove_rx_chns(struct am65_cpsw_common *common)
 {
-	struct am65_cpsw_common *common = data;
 	struct device *dev = common->dev;
 	struct am65_cpsw_rx_chn *rx_chn;
+	struct am65_cpsw_rx_flow *flows;
+	int i;
 
 	rx_chn = &common->rx_chns;
+	flows = rx_chn->flows;
 	devm_remove_action(dev, am65_cpsw_nuss_free_rx_chns, common);
 
-	if (!(rx_chn->irq < 0))
-		devm_free_irq(dev, rx_chn->irq, common);
-
-	netif_napi_del(&common->napi_rx);
+	for (i = 0; i < common->rx_ch_num_flows; i++) {
+		if (!(flows[i].irq < 0))
+			devm_free_irq(dev, flows[i].irq, &flows[i]);
+		netif_napi_del(&flows[i].napi_rx);
+	}
 
 	am65_cpsw_nuss_free_rx_chns(common);
 
@@ -2356,6 +2383,7 @@ static int am65_cpsw_nuss_init_rx_chns(struct am65_cpsw_common *common)
 	struct k3_udma_glue_rx_channel_cfg rx_cfg = { 0 };
 	u32  max_desc_num = AM65_CPSW_MAX_RX_DESC;
 	struct device *dev = common->dev;
+	struct am65_cpsw_rx_flow *flow;
 	u32 hdesc_size, hdesc_size_out;
 	u32 fdqring_id;
 	int i, ret = 0;
@@ -2364,12 +2392,21 @@ static int am65_cpsw_nuss_init_rx_chns(struct am65_cpsw_common *common)
 					   AM65_CPSW_NAV_SW_DATA_SIZE);
 
 	rx_cfg.swdata_size = AM65_CPSW_NAV_SW_DATA_SIZE;
-	rx_cfg.flow_id_num = AM65_CPSW_MAX_RX_FLOWS;
+	rx_cfg.flow_id_num = common->rx_ch_num_flows;
 	rx_cfg.flow_id_base = common->rx_flow_id_base;
 
 	/* init all flows */
 	rx_chn->dev = dev;
-	rx_chn->descs_num = max_desc_num;
+	rx_chn->descs_num = max_desc_num * rx_cfg.flow_id_num;
+
+	for (i = 0; i < common->rx_ch_num_flows; i++) {
+		flow = &rx_chn->flows[i];
+		flow->page_pool = NULL;
+		flow->pages = devm_kcalloc(dev, AM65_CPSW_MAX_RX_DESC,
+					   sizeof(*flow->pages), GFP_KERNEL);
+		if (!flow->pages)
+			return -ENOMEM;
+	}
 
 	rx_chn->rx_chn = k3_udma_glue_request_rx_chn(dev, "rx", &rx_cfg);
 	if (IS_ERR(rx_chn->rx_chn)) {
@@ -2392,13 +2429,6 @@ static int am65_cpsw_nuss_init_rx_chns(struct am65_cpsw_common *common)
 	rx_chn->dsize_log2 = __fls(hdesc_size_out);
 	WARN_ON(hdesc_size_out != (1 << rx_chn->dsize_log2));
 
-	rx_chn->page_pool = NULL;
-
-	rx_chn->pages = devm_kcalloc(dev, rx_chn->descs_num,
-				     sizeof(*rx_chn->pages), GFP_KERNEL);
-	if (!rx_chn->pages)
-		return -ENOMEM;
-
 	common->rx_flow_id_base =
 			k3_udma_glue_rx_get_flow_id_base(rx_chn->rx_chn);
 	dev_info(dev, "set new flow-id-base %u\n", common->rx_flow_id_base);
@@ -2422,6 +2452,10 @@ static int am65_cpsw_nuss_init_rx_chns(struct am65_cpsw_common *common)
 				K3_UDMA_GLUE_SRC_TAG_LO_USE_REMOTE_SRC_TAG,
 		};
 
+		flow = &rx_chn->flows[i];
+		flow->id = i;
+		flow->common = common;
+
 		rx_flow_cfg.ring_rxfdq0_id = fdqring_id;
 		rx_flow_cfg.rx_cfg.size = max_desc_num;
 		rx_flow_cfg.rxfdq_cfg.size = max_desc_num;
@@ -2438,28 +2472,32 @@ static int am65_cpsw_nuss_init_rx_chns(struct am65_cpsw_common *common)
 				k3_udma_glue_rx_flow_get_fdq_id(rx_chn->rx_chn,
 								i);
 
-		rx_chn->irq = k3_udma_glue_rx_get_irq(rx_chn->rx_chn, i);
-
-		if (rx_chn->irq < 0) {
+		flow->irq = k3_udma_glue_rx_get_irq(rx_chn->rx_chn, i);
+		if (flow->irq <= 0) {
 			dev_err(dev, "Failed to get rx dma irq %d\n",
-				rx_chn->irq);
-			ret = rx_chn->irq;
+				flow->irq);
+			ret = flow->irq;
 			goto err;
 		}
-	}
-
-	netif_napi_add(common->dma_ndev, &common->napi_rx,
-		       am65_cpsw_nuss_rx_poll);
-	hrtimer_init(&common->rx_hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_PINNED);
-	common->rx_hrtimer.function = &am65_cpsw_nuss_rx_timer_callback;
 
-	ret = devm_request_irq(dev, rx_chn->irq,
-			       am65_cpsw_nuss_rx_irq,
-			       IRQF_TRIGGER_HIGH, dev_name(dev), common);
-	if (ret) {
-		dev_err(dev, "failure requesting rx irq %u, %d\n",
-			rx_chn->irq, ret);
-		goto err;
+		snprintf(flow->name,
+			 sizeof(flow->name), "%s-rx%d",
+			 dev_name(dev), i);
+		netif_napi_add(common->dma_ndev, &flow->napi_rx,
+			       am65_cpsw_nuss_rx_poll);
+		hrtimer_init(&flow->rx_hrtimer, CLOCK_MONOTONIC,
+			     HRTIMER_MODE_REL_PINNED);
+		flow->rx_hrtimer.function = &am65_cpsw_nuss_rx_timer_callback;
+
+		ret = devm_request_irq(dev, flow->irq,
+				       am65_cpsw_nuss_rx_irq,
+				       IRQF_TRIGGER_HIGH,
+				       flow->name, flow);
+		if (ret) {
+			dev_err(dev, "failure requesting rx %d irq %u, %d\n",
+				i, flow->irq, ret);
+			goto err;
+		}
 	}
 
 err:
@@ -2705,8 +2743,8 @@ am65_cpsw_nuss_init_port_ndev(struct am65_cpsw_common *common, u32 port_idx)
 	/* alloc netdev */
 	port->ndev = devm_alloc_etherdev_mqs(common->dev,
 					     sizeof(struct am65_cpsw_ndev_priv),
-					     AM65_CPSW_MAX_TX_QUEUES,
-					     AM65_CPSW_MAX_RX_QUEUES);
+					     AM65_CPSW_MAX_QUEUES,
+					     AM65_CPSW_MAX_QUEUES);
 	if (!port->ndev) {
 		dev_err(dev, "error allocating slave net_device %u\n",
 			port->port_id);
@@ -3303,9 +3341,10 @@ static int am65_cpsw_nuss_register_ndevs(struct am65_cpsw_common *common)
 		k3_udma_glue_disable_tx_chn(tx_chan[i].tx_chn);
 	}
 
-	for (i = 0; i < AM65_CPSW_MAX_RX_FLOWS; i++)
-		k3_udma_glue_reset_rx_chn(rx_chan->rx_chn, i, rx_chan,
-					  am65_cpsw_nuss_rx_cleanup, !!i);
+	for (i = 0; i < common->rx_ch_num_flows; i++)
+		k3_udma_glue_reset_rx_chn(rx_chan->rx_chn, i,
+					  &rx_chan->flows[i],
+					  am65_cpsw_nuss_rx_cleanup, 0);
 
 	k3_udma_glue_disable_rx_chn(rx_chan->rx_chn);
 
@@ -3346,12 +3385,21 @@ static int am65_cpsw_nuss_register_ndevs(struct am65_cpsw_common *common)
 	return ret;
 }
 
-int am65_cpsw_nuss_update_tx_chns(struct am65_cpsw_common *common, int num_tx)
+int am65_cpsw_nuss_update_tx_rx_chns(struct am65_cpsw_common *common,
+				     int num_tx, int num_rx)
 {
 	int ret;
 
+	am65_cpsw_nuss_remove_tx_chns(common);
+	am65_cpsw_nuss_remove_rx_chns(common);
+
 	common->tx_ch_num = num_tx;
+	common->rx_ch_num_flows = num_rx;
 	ret = am65_cpsw_nuss_init_tx_chns(common);
+	if (ret)
+		return ret;
+
+	ret = am65_cpsw_nuss_init_rx_chns(common);
 
 	return ret;
 }
@@ -3481,6 +3529,7 @@ static int am65_cpsw_nuss_probe(struct platform_device *pdev)
 	common->rx_flow_id_base = -1;
 	init_completion(&common->tdown_complete);
 	common->tx_ch_num = AM65_CPSW_DEFAULT_TX_CHNS;
+	common->rx_ch_num_flows = AM65_CPSW_DEFAULT_RX_CHN_FLOWS;
 	common->pf_p0_rx_ptype_rrobin = false;
 	common->default_vlan = 1;
 
@@ -3672,8 +3721,10 @@ static int am65_cpsw_nuss_resume(struct device *dev)
 		return ret;
 
 	/* If RX IRQ was disabled before suspend, keep it disabled */
-	if (common->rx_irq_disabled)
-		disable_irq(common->rx_chns.irq);
+	for (i = 0; i < common->rx_ch_num_flows; i++) {
+		if (common->rx_chns.flows[i].irq_disabled)
+			disable_irq(common->rx_chns.flows[i].irq);
+	}
 
 	am65_cpts_resume(common->cpts);
 
diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.h b/drivers/net/ethernet/ti/am65-cpsw-nuss.h
index e2ce2be320bd..dc8d544230dc 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-nuss.h
+++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.h
@@ -21,9 +21,7 @@ struct am65_cpts;
 
 #define HOST_PORT_NUM		0
 
-#define AM65_CPSW_MAX_TX_QUEUES	8
-#define AM65_CPSW_MAX_RX_QUEUES	1
-#define AM65_CPSW_MAX_RX_FLOWS	1
+#define AM65_CPSW_MAX_QUEUES	8	/* both TX & RX */
 
 #define AM65_CPSW_PORT_VLAN_REG_OFFSET	0x014
 
@@ -58,7 +56,7 @@ struct am65_cpsw_port {
 	struct am65_cpsw_qos		qos;
 	struct devlink_port		devlink_port;
 	struct bpf_prog			*xdp_prog;
-	struct xdp_rxq_info		xdp_rxq;
+	struct xdp_rxq_info		xdp_rxq[AM65_CPSW_MAX_QUEUES];
 	/* Only for suspend resume context */
 	u32				vid_context;
 };
@@ -94,16 +92,27 @@ struct am65_cpsw_tx_chn {
 	u32 rate_mbps;
 };
 
+struct am65_cpsw_rx_flow {
+	u32 id;
+	struct napi_struct napi_rx;
+	struct am65_cpsw_common	*common;
+	int irq;
+	bool irq_disabled;
+	struct hrtimer rx_hrtimer;
+	unsigned long rx_pace_timeout;
+	struct page_pool *page_pool;
+	struct page **pages;
+	char name[32];
+};
+
 struct am65_cpsw_rx_chn {
 	struct device *dev;
 	struct device *dma_dev;
 	struct k3_cppi_desc_pool *desc_pool;
 	struct k3_udma_glue_rx_channel *rx_chn;
-	struct page_pool *page_pool;
-	struct page **pages;
 	u32 descs_num;
 	unsigned char dsize_log2;
-	int irq;
+	struct am65_cpsw_rx_flow flows[AM65_CPSW_MAX_QUEUES];
 };
 
 #define AM65_CPSW_QUIRK_I2027_NO_TX_CSUM BIT(0)
@@ -145,16 +154,12 @@ struct am65_cpsw_common {
 	u32			tx_ch_rate_msk;
 	u32			rx_flow_id_base;
 
-	struct am65_cpsw_tx_chn	tx_chns[AM65_CPSW_MAX_TX_QUEUES];
+	struct am65_cpsw_tx_chn	tx_chns[AM65_CPSW_MAX_QUEUES];
 	struct completion	tdown_complete;
 	atomic_t		tdown_cnt;
 
+	int			rx_ch_num_flows;
 	struct am65_cpsw_rx_chn	rx_chns;
-	struct napi_struct	napi_rx;
-
-	bool			rx_irq_disabled;
-	struct hrtimer		rx_hrtimer;
-	unsigned long		rx_pace_timeout;
 
 	u32			nuss_ver;
 	u32			cpsw_ver;
@@ -203,8 +208,8 @@ struct am65_cpsw_ndev_priv {
 #define am65_common_get_host(common) (&(common)->host)
 #define am65_common_get_port(common, id) (&(common)->ports[(id) - 1])
 
-#define am65_cpsw_napi_to_common(pnapi) \
-	container_of(pnapi, struct am65_cpsw_common, napi_rx)
+#define am65_cpsw_napi_to_rx_flow(pnapi) \
+	container_of(pnapi, struct am65_cpsw_rx_flow, napi_rx)
 #define am65_cpsw_napi_to_tx_chn(pnapi) \
 	container_of(pnapi, struct am65_cpsw_tx_chn, napi_tx)
 
@@ -215,8 +220,8 @@ struct am65_cpsw_ndev_priv {
 extern const struct ethtool_ops am65_cpsw_ethtool_ops_slave;
 
 void am65_cpsw_nuss_set_p0_ptype(struct am65_cpsw_common *common);
-void am65_cpsw_nuss_remove_tx_chns(struct am65_cpsw_common *common);
-int am65_cpsw_nuss_update_tx_chns(struct am65_cpsw_common *common, int num_tx);
+int am65_cpsw_nuss_update_tx_rx_chns(struct am65_cpsw_common *common,
+				     int num_tx, int num_rx);
 
 bool am65_cpsw_port_dev_check(const struct net_device *dev);
 

-- 
2.34.1


