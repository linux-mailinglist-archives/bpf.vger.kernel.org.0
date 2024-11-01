Return-Path: <bpf+bounces-43714-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13EED9B8EFC
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2024 11:19:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3864A1C23BAF
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2024 10:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BA63196C7B;
	Fri,  1 Nov 2024 10:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uv0UASTd"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF7E215CD60;
	Fri,  1 Nov 2024 10:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730456342; cv=none; b=ajCatC1hdMFtbmSjfOPziq7+LAWjhKtm7eKWeRsuxHKIfnbxXTLo6qzgAQGqnKX62dsupSO1WBsMKmUJM0R2+fnBniW89iWi75LchfA5T/fNKCG0saHN83UqmMV6AOMZvxWYJrnts4J7IGPHrMkKl5JU03WfR+0i2OgzoTMiAW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730456342; c=relaxed/simple;
	bh=DM3nyWEDCYpz69APcmHhmPvvEkogGMqeYFZSLoUgopk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HwS9cNlUMmF2bPt+lTCYN8uCaaS82dqjw02KnHknSM9VAuFj6WZ3uh9Wdp7k1zj3X/2Zo2/LoT0x2ugntrGdhhRJtGTADpP0kTmivw/cvju4uuAucRmJx04R/N35RF7rOEji6bGLy61tSwPqi7IFEq/JKwg5v66C0HsG+9uQ9HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uv0UASTd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57620C4CECD;
	Fri,  1 Nov 2024 10:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730456342;
	bh=DM3nyWEDCYpz69APcmHhmPvvEkogGMqeYFZSLoUgopk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=uv0UASTd5Gu+ZBDuzZYXykvRWzbhfFJFtqIvgiDM5omG8ILqtHuqxRl44gbMUYO1X
	 o0qXvBPDY04TKovc/Td4/UF2JjdrpV2iX63Zcsd5QoB+UVzBSu2uTgFZiEEa1uohYc
	 xyOYWPHSAinQTPLtfQQ2DNLLSEh8AN0S+hjVIGVjBYeVI4dCKhwiVtzCFNkah2jJd7
	 OQDGhg+ks1NQM9SqJu8tvqb9RJqUm5fP3ovucBCANv9U9xRcOAOnOlH+jjGqAzOeJB
	 +3gggqnyHANH3xziHUPUp0SclUsKxHGK5cNwkZT1SsRmPBYCo8hXGl5o5hLngCV0xX
	 vhNweNkl7Deiw==
From: Roger Quadros <rogerq@kernel.org>
Date: Fri, 01 Nov 2024 12:18:50 +0200
Subject: [PATCH net v3 1/2] net: ethernet: ti: am65-cpsw: Fix multi queue
 Rx on J7
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241101-am65-cpsw-multi-rx-j7-fix-v3-1-338fdd6a55da@kernel.org>
References: <20241101-am65-cpsw-multi-rx-j7-fix-v3-0-338fdd6a55da@kernel.org>
In-Reply-To: <20241101-am65-cpsw-multi-rx-j7-fix-v3-0-338fdd6a55da@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, Simon Horman <horms@kernel.org>, 
 Vignesh Raghavendra <vigneshr@ti.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Siddharth Vadapalli <s-vadapalli@ti.com>, 
 Md Danish Anwar <danishanwar@ti.com>, 
 Govindarajan Sriramakrishnan <srk@ti.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 Roger Quadros <rogerq@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=10390; i=rogerq@kernel.org;
 h=from:subject:message-id; bh=DM3nyWEDCYpz69APcmHhmPvvEkogGMqeYFZSLoUgopk=;
 b=owEBbQKS/ZANAwAIAdJaa9O+djCTAcsmYgBnJKsNDJDYzBGdb5XKJLdgu+z2cz4LXwF+QChCR
 YXy7LJ0lw+JAjMEAAEIAB0WIQRBIWXUTJ9SeA+rEFjSWmvTvnYwkwUCZySrDQAKCRDSWmvTvnYw
 k12aD/0Z1OgABhzzDyLXnp7acsNhhVWGxK0+wWLcqb6cFcCE3FiTtQ7HLbkYqmJwmcAX015KAdV
 scX60VOBtwmKFrP3AgyCxJtZVRTPnEaN0HpaS2pQp11xinxomJoXYT1Sdkr21t50Q7TQ2csVwmi
 0aYVeCr2Gr9SF4O8OmRy+fpQGOq5edpBW3QTwGOvN67oDDtnKLJOCQlgmgYL1yBXlV0t/tLclGj
 pbIHSN6/VWn3yTrY36b6F7ZsbhDCtu3quGlOq+wuAfcQZQSZDgtArzC2qQPm/1dvT4KWxjsQ77Y
 LfrCOFACbjiXCwuUlGcAo3adwHXjaz1vbTjR4RsZMHWU6cB4VuKcBHmpH2csl2MS0aL/IFP3RUZ
 FxZ+GbcotfrFmxYA99Po+zbeyRHTMow3LHpVLITF9jY5ze/3pz8LOofjf838H978acbEcXYSGH7
 HPz/JLXLwrtOJAs0ku4etT/X7HZg6lhZ9BrQ9BOpP3qJSh2FGzMN3QXXootd8fAs8j3z+CNyviM
 FTMwrQ08ID4HjMjOqM55f5bhHvNyIkG+p5Q5JMBM1EutMRrF+l3qqdhLemlkmhm90CgbTRpnrQ4
 FGy9Ev6q/p1B8HEQpmt6pQMxJa4WDUYglYNomGCplMnKRaOU22HTfxZEiNRv4e0IMHjMoOVDuuC
 QjYR3SAmW4f08zg==
X-Developer-Key: i=rogerq@kernel.org; a=openpgp;
 fpr=412165D44C9F52780FAB1058D25A6BD3BE763093

On J7 platforms, setting up multiple RX flows was failing
as the RX free descriptor ring 0 is shared among all flows
and we did not allocate enough elements in the RX free descriptor
ring 0 to accommodate for all RX flows.

This issue is not present on AM62 as separate pair of
rings are used for free and completion rings for each flow.

Fix this by allocating enough elements for RX free descriptor
ring 0.

However, we can no longer rely on desc_idx (descriptor based
offsets) to identify the pages in the respective flows as
free descriptor ring includes elements for all flows.
To solve this, introduce a new swdata data structure to store
flow_id and page. This can be used to identify which flow (page_pool)
and page the descriptor belonged to when popped out of the
RX rings.

Fixes: da70d184a8c3 ("net: ethernet: ti: am65-cpsw: Introduce multi queue Rx")
Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
 drivers/net/ethernet/ti/am65-cpsw-nuss.c | 73 +++++++++++++-------------------
 drivers/net/ethernet/ti/am65-cpsw-nuss.h |  6 ++-
 2 files changed, 35 insertions(+), 44 deletions(-)

diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
index 0520e9f4bea7..70aea654c79f 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
@@ -337,9 +337,9 @@ static int am65_cpsw_nuss_rx_push(struct am65_cpsw_common *common,
 	struct am65_cpsw_rx_chn *rx_chn = &common->rx_chns;
 	struct cppi5_host_desc_t *desc_rx;
 	struct device *dev = common->dev;
+	struct am65_cpsw_swdata *swdata;
 	dma_addr_t desc_dma;
 	dma_addr_t buf_dma;
-	void *swdata;
 
 	desc_rx = k3_cppi_desc_pool_alloc(rx_chn->desc_pool);
 	if (!desc_rx) {
@@ -363,7 +363,8 @@ static int am65_cpsw_nuss_rx_push(struct am65_cpsw_common *common,
 	cppi5_hdesc_attach_buf(desc_rx, buf_dma, AM65_CPSW_MAX_PACKET_SIZE,
 			       buf_dma, AM65_CPSW_MAX_PACKET_SIZE);
 	swdata = cppi5_hdesc_get_swdata(desc_rx);
-	*((void **)swdata) = page_address(page);
+	swdata->page = page;
+	swdata->flow_id = flow_idx;
 
 	return k3_udma_glue_push_rx_chn(rx_chn->rx_chn, flow_idx,
 					desc_rx, desc_dma);
@@ -519,36 +520,31 @@ static enum am65_cpsw_tx_buf_type am65_cpsw_nuss_buf_type(struct am65_cpsw_tx_ch
 
 static inline void am65_cpsw_put_page(struct am65_cpsw_rx_flow *flow,
 				      struct page *page,
-				      bool allow_direct,
-				      int desc_idx)
+				      bool allow_direct)
 {
 	page_pool_put_full_page(flow->page_pool, page, allow_direct);
-	flow->pages[desc_idx] = NULL;
 }
 
 static void am65_cpsw_nuss_rx_cleanup(void *data, dma_addr_t desc_dma)
 {
-	struct am65_cpsw_rx_flow *flow = data;
+	struct am65_cpsw_rx_chn *rx_chn = data;
 	struct cppi5_host_desc_t *desc_rx;
-	struct am65_cpsw_rx_chn *rx_chn;
+	struct am65_cpsw_swdata *swdata;
 	dma_addr_t buf_dma;
+	struct page *page;
 	u32 buf_dma_len;
-	void *page_addr;
-	void **swdata;
-	int desc_idx;
+	u32 flow_id;
 
-	rx_chn = &flow->common->rx_chns;
 	desc_rx = k3_cppi_desc_pool_dma2virt(rx_chn->desc_pool, desc_dma);
 	swdata = cppi5_hdesc_get_swdata(desc_rx);
-	page_addr = *swdata;
+	page = swdata->page;
+	flow_id = swdata->flow_id;
 	cppi5_hdesc_get_obuf(desc_rx, &buf_dma, &buf_dma_len);
 	k3_udma_glue_rx_cppi5_to_dma_addr(rx_chn->rx_chn, &buf_dma);
 	dma_unmap_single(rx_chn->dma_dev, buf_dma, buf_dma_len, DMA_FROM_DEVICE);
 	k3_cppi_desc_pool_free(rx_chn->desc_pool, desc_rx);
 
-	desc_idx = am65_cpsw_nuss_desc_idx(rx_chn->desc_pool, desc_rx,
-					   rx_chn->dsize_log2);
-	am65_cpsw_put_page(flow, virt_to_page(page_addr), false, desc_idx);
+	am65_cpsw_put_page(&rx_chn->flows[flow_id], page, false);
 }
 
 static void am65_cpsw_nuss_xmit_free(struct am65_cpsw_tx_chn *tx_chn,
@@ -703,14 +699,13 @@ static int am65_cpsw_nuss_common_open(struct am65_cpsw_common *common)
 				ret = -ENOMEM;
 				goto fail_rx;
 			}
-			flow->pages[i] = page;
 
 			ret = am65_cpsw_nuss_rx_push(common, page, flow_idx);
 			if (ret < 0) {
 				dev_err(common->dev,
 					"cannot submit page to rx channel flow %d, error %d\n",
 					flow_idx, ret);
-				am65_cpsw_put_page(flow, page, false, i);
+				am65_cpsw_put_page(flow, page, false);
 				goto fail_rx;
 			}
 		}
@@ -764,8 +759,8 @@ static int am65_cpsw_nuss_common_open(struct am65_cpsw_common *common)
 
 fail_rx:
 	for (i = 0; i < common->rx_ch_num_flows; i++)
-		k3_udma_glue_reset_rx_chn(rx_chn->rx_chn, i, &rx_chn->flows[i],
-					  am65_cpsw_nuss_rx_cleanup, 0);
+		k3_udma_glue_reset_rx_chn(rx_chn->rx_chn, i, rx_chn,
+					  am65_cpsw_nuss_rx_cleanup, !!i);
 
 	am65_cpsw_destroy_xdp_rxqs(common);
 
@@ -817,11 +812,11 @@ static int am65_cpsw_nuss_common_stop(struct am65_cpsw_common *common)
 			dev_err(common->dev, "rx teardown timeout\n");
 	}
 
-	for (i = 0; i < common->rx_ch_num_flows; i++) {
+	for (i = common->rx_ch_num_flows - 1; i >= 0; i--) {
 		napi_disable(&rx_chn->flows[i].napi_rx);
 		hrtimer_cancel(&rx_chn->flows[i].rx_hrtimer);
-		k3_udma_glue_reset_rx_chn(rx_chn->rx_chn, i, &rx_chn->flows[i],
-					  am65_cpsw_nuss_rx_cleanup, 0);
+		k3_udma_glue_reset_rx_chn(rx_chn->rx_chn, i, rx_chn,
+					  am65_cpsw_nuss_rx_cleanup, !!i);
 	}
 
 	k3_udma_glue_disable_rx_chn(rx_chn->rx_chn);
@@ -1028,7 +1023,7 @@ static int am65_cpsw_xdp_tx_frame(struct net_device *ndev,
 static int am65_cpsw_run_xdp(struct am65_cpsw_rx_flow *flow,
 			     struct am65_cpsw_port *port,
 			     struct xdp_buff *xdp,
-			     int desc_idx, int cpu, int *len)
+			     int cpu, int *len)
 {
 	struct am65_cpsw_common *common = flow->common;
 	struct am65_cpsw_ndev_priv *ndev_priv;
@@ -1101,7 +1096,7 @@ static int am65_cpsw_run_xdp(struct am65_cpsw_rx_flow *flow,
 	}
 
 	page = virt_to_head_page(xdp->data);
-	am65_cpsw_put_page(flow, page, true, desc_idx);
+	am65_cpsw_put_page(flow, page, true);
 
 out:
 	return ret;
@@ -1150,16 +1145,16 @@ static int am65_cpsw_nuss_rx_packets(struct am65_cpsw_rx_flow *flow,
 	struct am65_cpsw_ndev_stats *stats;
 	struct cppi5_host_desc_t *desc_rx;
 	struct device *dev = common->dev;
+	struct am65_cpsw_swdata *swdata;
 	struct page *page, *new_page;
 	dma_addr_t desc_dma, buf_dma;
 	struct am65_cpsw_port *port;
-	int headroom, desc_idx, ret;
 	struct net_device *ndev;
 	u32 flow_idx = flow->id;
 	struct sk_buff *skb;
 	struct xdp_buff	xdp;
+	int headroom, ret;
 	void *page_addr;
-	void **swdata;
 	u32 *psdata;
 
 	*xdp_state = AM65_CPSW_XDP_PASS;
@@ -1182,8 +1177,8 @@ static int am65_cpsw_nuss_rx_packets(struct am65_cpsw_rx_flow *flow,
 		__func__, flow_idx, &desc_dma);
 
 	swdata = cppi5_hdesc_get_swdata(desc_rx);
-	page_addr = *swdata;
-	page = virt_to_page(page_addr);
+	page = swdata->page;
+	page_addr = page_address(page);
 	cppi5_hdesc_get_obuf(desc_rx, &buf_dma, &buf_dma_len);
 	k3_udma_glue_rx_cppi5_to_dma_addr(rx_chn->rx_chn, &buf_dma);
 	pkt_len = cppi5_hdesc_get_pktlen(desc_rx);
@@ -1199,9 +1194,6 @@ static int am65_cpsw_nuss_rx_packets(struct am65_cpsw_rx_flow *flow,
 
 	k3_cppi_desc_pool_free(rx_chn->desc_pool, desc_rx);
 
-	desc_idx = am65_cpsw_nuss_desc_idx(rx_chn->desc_pool, desc_rx,
-					   rx_chn->dsize_log2);
-
 	skb = am65_cpsw_build_skb(page_addr, ndev,
 				  AM65_CPSW_MAX_PACKET_SIZE);
 	if (unlikely(!skb)) {
@@ -1213,7 +1205,7 @@ static int am65_cpsw_nuss_rx_packets(struct am65_cpsw_rx_flow *flow,
 		xdp_init_buff(&xdp, PAGE_SIZE, &port->xdp_rxq[flow->id]);
 		xdp_prepare_buff(&xdp, page_addr, AM65_CPSW_HEADROOM,
 				 pkt_len, false);
-		*xdp_state = am65_cpsw_run_xdp(flow, port, &xdp, desc_idx,
+		*xdp_state = am65_cpsw_run_xdp(flow, port, &xdp,
 					       cpu, &pkt_len);
 		if (*xdp_state != AM65_CPSW_XDP_PASS)
 			goto allocate;
@@ -1247,10 +1239,8 @@ static int am65_cpsw_nuss_rx_packets(struct am65_cpsw_rx_flow *flow,
 		return -ENOMEM;
 	}
 
-	flow->pages[desc_idx] = new_page;
-
 	if (netif_dormant(ndev)) {
-		am65_cpsw_put_page(flow, new_page, true, desc_idx);
+		am65_cpsw_put_page(flow, new_page, true);
 		ndev->stats.rx_dropped++;
 		return 0;
 	}
@@ -1258,7 +1248,7 @@ static int am65_cpsw_nuss_rx_packets(struct am65_cpsw_rx_flow *flow,
 requeue:
 	ret = am65_cpsw_nuss_rx_push(common, new_page, flow_idx);
 	if (WARN_ON(ret < 0)) {
-		am65_cpsw_put_page(flow, new_page, true, desc_idx);
+		am65_cpsw_put_page(flow, new_page, true);
 		ndev->stats.rx_errors++;
 		ndev->stats.rx_dropped++;
 	}
@@ -2402,10 +2392,6 @@ static int am65_cpsw_nuss_init_rx_chns(struct am65_cpsw_common *common)
 	for (i = 0; i < common->rx_ch_num_flows; i++) {
 		flow = &rx_chn->flows[i];
 		flow->page_pool = NULL;
-		flow->pages = devm_kcalloc(dev, AM65_CPSW_MAX_RX_DESC,
-					   sizeof(*flow->pages), GFP_KERNEL);
-		if (!flow->pages)
-			return -ENOMEM;
 	}
 
 	rx_chn->rx_chn = k3_udma_glue_request_rx_chn(dev, "rx", &rx_cfg);
@@ -2458,7 +2444,8 @@ static int am65_cpsw_nuss_init_rx_chns(struct am65_cpsw_common *common)
 
 		rx_flow_cfg.ring_rxfdq0_id = fdqring_id;
 		rx_flow_cfg.rx_cfg.size = max_desc_num;
-		rx_flow_cfg.rxfdq_cfg.size = max_desc_num;
+		/* share same FDQ for all flows */
+		rx_flow_cfg.rxfdq_cfg.size = max_desc_num * rx_cfg.flow_id_num;
 		rx_flow_cfg.rxfdq_cfg.mode = common->pdata.fdqring_mode;
 
 		ret = k3_udma_glue_rx_flow_init(rx_chn->rx_chn,
@@ -3349,8 +3336,8 @@ static int am65_cpsw_nuss_register_ndevs(struct am65_cpsw_common *common)
 
 	for (i = 0; i < common->rx_ch_num_flows; i++)
 		k3_udma_glue_reset_rx_chn(rx_chan->rx_chn, i,
-					  &rx_chan->flows[i],
-					  am65_cpsw_nuss_rx_cleanup, 0);
+					  rx_chan,
+					  am65_cpsw_nuss_rx_cleanup, !!i);
 
 	k3_udma_glue_disable_rx_chn(rx_chan->rx_chn);
 
diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.h b/drivers/net/ethernet/ti/am65-cpsw-nuss.h
index dc8d544230dc..92a27ba4c601 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-nuss.h
+++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.h
@@ -101,10 +101,14 @@ struct am65_cpsw_rx_flow {
 	struct hrtimer rx_hrtimer;
 	unsigned long rx_pace_timeout;
 	struct page_pool *page_pool;
-	struct page **pages;
 	char name[32];
 };
 
+struct am65_cpsw_swdata {
+	u32 flow_id;
+	struct page *page;
+};
+
 struct am65_cpsw_rx_chn {
 	struct device *dev;
 	struct device *dma_dev;

-- 
2.34.1


