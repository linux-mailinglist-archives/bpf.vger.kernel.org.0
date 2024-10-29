Return-Path: <bpf+bounces-43389-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED1299B4CEC
	for <lists+bpf@lfdr.de>; Tue, 29 Oct 2024 16:05:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A6231F24713
	for <lists+bpf@lfdr.de>; Tue, 29 Oct 2024 15:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00EBC192B90;
	Tue, 29 Oct 2024 15:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uNJacqaX"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF4D191F98;
	Tue, 29 Oct 2024 15:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730214342; cv=none; b=q74bjALQEOjL/vE8w6XdzxSk3HWBRtYlbRWMx8a2NRs+ZoxiMQkWBpUE25c5tHJoul3Bgl1zzga2d9RdMIxDKvwiq2ulxgaFuIrNA8uhL1rL1A1RLLKLzqkpj/UKDtzSyuVjGIsMPCp89+AyBhEZUG3kk8aleITl+noLzRyl+bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730214342; c=relaxed/simple;
	bh=JMfPmRSJ24sW8RtpCOVTfks3gqkTlZ3rN5ZS3NtVCbc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=g+Nyxq1qV43SsRgdxj1GvflUcbqz/gJw+h4jkvVSZKmoYQt6ozTeSZ+S6swA00AtbdCNVLbWIEVHKD7NUZdnhs6K7hbZnJHfr7Ew3UT9wO8Mx/sSwHw3rGUQhbzlUrERlMN9u5Kx5t+FOM9MO2Q7+PrpQ13nGY1SvR5PYAlEuFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uNJacqaX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F7B5C4CECD;
	Tue, 29 Oct 2024 15:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730214339;
	bh=JMfPmRSJ24sW8RtpCOVTfks3gqkTlZ3rN5ZS3NtVCbc=;
	h=From:Date:Subject:To:Cc:From;
	b=uNJacqaXXEAxrcQMF7VJtmKRLi/wvzyKPJxCUmKqQyfCTW4dYgf1JYYihjcZF7OMH
	 yqq+/Cv6ZUBm0EkQJJQR6kE7YuSCjwIbzRmQ2jAkVii9cmZqDY0NRrCgjuFR1I8tXv
	 3mjY8Ty+I7qNRHhCX/SQQbuPH9EES9vQGerQ0Zp07LuakYG93ZxqacKEJF/ifub4VH
	 +sixq3H6ttL3BvhYEZrWxnRdI1yiehl0pQHIu8kAYiU+4DK/iTuO8m5qvLSIjl6+V2
	 ftTBGOj3JuPiXR3IhSbqXzfdel/lYsOcDnjGl0OmqxGEkIANtwRchl53IeMcB+wdhU
	 /8I9QBJ5Zb1zQ==
From: Roger Quadros <rogerq@kernel.org>
Date: Tue, 29 Oct 2024 17:05:29 +0200
Subject: [PATCH net] net: ethernet: ti: am65-cpsw: Fix multi queue Rx on J7
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241029-am65-cpsw-multi-rx-j7-fix-v1-1-426ca805918c@kernel.org>
X-B4-Tracking: v=1; b=H4sIALj5IGcC/x2MWw5AMBAAryL7bROtV7iK+ChdrFDS1iMRd9f4n
 ElmHnBkmRzU0QOWTna8mQAijqCflBkJWQcGmchMJDJFtRY59ru7cD0Wz2hvnEsc+MahUlJkVUe
 F1hD63VLQ/7sBQx7a9/0AvZ+FbXAAAAA=
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, Simon Horman <horms@kernel.org>, 
 Vignesh Raghavendra <vigneshr@ti.com>
Cc: Siddharth Vadapalli <s-vadapalli@ti.com>, 
 Govindarajan Sriramakrishnan <srk@ti.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 Roger Quadros <rogerq@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=11058; i=rogerq@kernel.org;
 h=from:subject:message-id; bh=JMfPmRSJ24sW8RtpCOVTfks3gqkTlZ3rN5ZS3NtVCbc=;
 b=owEBbQKS/ZANAwAIAdJaa9O+djCTAcsmYgBnIPm8ugTRHW57eTVp39CdfAeZEvvPwQ1sv2Gho
 GX1afq4VbKJAjMEAAEIAB0WIQRBIWXUTJ9SeA+rEFjSWmvTvnYwkwUCZyD5vAAKCRDSWmvTvnYw
 k8hREACUmXMarqcGkiHe9l5vAryK9zCrOHRxfUNR/umzK9usmvh8scSVcvtWFC/Wl9KoyVq3l+E
 CGTcW8ZqGYCDUnigrulLHQfN8fpau9kw4g7IQJn4Tn3KI4JoC+mLD01W8rrtFuV/6vAT39BrCfu
 eEaipJ0rBf+qQOz/sfpF+Wnuy50jgmIhu/H645TZU4LNUyUPzeaS1I7U62bft+0ShDza4djFLxj
 4S7EMVqsI+DVDXty4kA+n6BzxY36rLXjhC+hNzRf2OXq/4gSI151l9huvWV1dCYM4lTXYlEBYUn
 3Gw+HTr/pIRNjdNr/pj0kohnWalFyGNjAMjif1QPxF4RPm79vFyKnXQyj4rYP6oPDgqKIoexaq8
 Yo3g8T3K2KCvXDTSBoa2LhaFRjG8OxPcD0X7Wx90ZINtAtY/OfIs6/NLbDn9OSvcoHV0RAYcNS2
 smm/CNOU2sj1WOqlmKqhWoXUAoCGKpScaKCFWNaYJirY0nH40F8gFz0UKdLjcPEBlSvhBmPVtiL
 eVJC56+rqRIG3Qcw8CnvurHXR0IpDF4VcLRj8TQlBnIsUAUnW3jwYq1zVBVe39GM1pymkRzoA94
 BW6j9hfTTL0fmC36uyrHut0dgqipFEG5oyuWuCIRS3OBbhdPKrhAwL8AmFHue+i44y6Xorx81uk
 hU4+wpGLib8FJGw==
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
 drivers/net/ethernet/ti/am65-cpsw-nuss.c | 73 +++++++++++++++-----------------
 drivers/net/ethernet/ti/am65-cpsw-nuss.h |  6 ++-
 2 files changed, 38 insertions(+), 41 deletions(-)

diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
index 0520e9f4bea7..4c46574e111c 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
@@ -339,7 +339,7 @@ static int am65_cpsw_nuss_rx_push(struct am65_cpsw_common *common,
 	struct device *dev = common->dev;
 	dma_addr_t desc_dma;
 	dma_addr_t buf_dma;
-	void *swdata;
+	struct am65_cpsw_swdata *swdata;
 
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
 	u32 buf_dma_len;
-	void *page_addr;
-	void **swdata;
-	int desc_idx;
+	struct page *page;
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
 
@@ -777,6 +772,7 @@ static int am65_cpsw_nuss_common_stop(struct am65_cpsw_common *common)
 	struct am65_cpsw_rx_chn *rx_chn = &common->rx_chns;
 	struct am65_cpsw_tx_chn *tx_chn = common->tx_chns;
 	int i;
+	struct am65_cpsw_rx_flow *flow;
 
 	if (common->usage_count != 1)
 		return 0;
@@ -817,11 +813,12 @@ static int am65_cpsw_nuss_common_stop(struct am65_cpsw_common *common)
 			dev_err(common->dev, "rx teardown timeout\n");
 	}
 
-	for (i = 0; i < common->rx_ch_num_flows; i++) {
+	for (i = common->rx_ch_num_flows - 1; i >= 0; i--) {
+		flow = &rx_chn->flows[i];
 		napi_disable(&rx_chn->flows[i].napi_rx);
 		hrtimer_cancel(&rx_chn->flows[i].rx_hrtimer);
-		k3_udma_glue_reset_rx_chn(rx_chn->rx_chn, i, &rx_chn->flows[i],
-					  am65_cpsw_nuss_rx_cleanup, 0);
+		k3_udma_glue_reset_rx_chn(rx_chn->rx_chn, i, rx_chn,
+					  am65_cpsw_nuss_rx_cleanup, !!i);
 	}
 
 	k3_udma_glue_disable_rx_chn(rx_chn->rx_chn);
@@ -1028,7 +1025,7 @@ static int am65_cpsw_xdp_tx_frame(struct net_device *ndev,
 static int am65_cpsw_run_xdp(struct am65_cpsw_rx_flow *flow,
 			     struct am65_cpsw_port *port,
 			     struct xdp_buff *xdp,
-			     int desc_idx, int cpu, int *len)
+			     int cpu, int *len)
 {
 	struct am65_cpsw_common *common = flow->common;
 	struct am65_cpsw_ndev_priv *ndev_priv;
@@ -1101,7 +1098,7 @@ static int am65_cpsw_run_xdp(struct am65_cpsw_rx_flow *flow,
 	}
 
 	page = virt_to_head_page(xdp->data);
-	am65_cpsw_put_page(flow, page, true, desc_idx);
+	am65_cpsw_put_page(flow, page, true);
 
 out:
 	return ret;
@@ -1150,6 +1147,7 @@ static int am65_cpsw_nuss_rx_packets(struct am65_cpsw_rx_flow *flow,
 	struct am65_cpsw_ndev_stats *stats;
 	struct cppi5_host_desc_t *desc_rx;
 	struct device *dev = common->dev;
+	struct am65_cpsw_swdata *swdata;
 	struct page *page, *new_page;
 	dma_addr_t desc_dma, buf_dma;
 	struct am65_cpsw_port *port;
@@ -1159,7 +1157,6 @@ static int am65_cpsw_nuss_rx_packets(struct am65_cpsw_rx_flow *flow,
 	struct sk_buff *skb;
 	struct xdp_buff	xdp;
 	void *page_addr;
-	void **swdata;
 	u32 *psdata;
 
 	*xdp_state = AM65_CPSW_XDP_PASS;
@@ -1182,8 +1179,8 @@ static int am65_cpsw_nuss_rx_packets(struct am65_cpsw_rx_flow *flow,
 		__func__, flow_idx, &desc_dma);
 
 	swdata = cppi5_hdesc_get_swdata(desc_rx);
-	page_addr = *swdata;
-	page = virt_to_page(page_addr);
+	page = swdata->page;
+	page_addr = page_address(page);
 	cppi5_hdesc_get_obuf(desc_rx, &buf_dma, &buf_dma_len);
 	k3_udma_glue_rx_cppi5_to_dma_addr(rx_chn->rx_chn, &buf_dma);
 	pkt_len = cppi5_hdesc_get_pktlen(desc_rx);
@@ -1201,7 +1198,6 @@ static int am65_cpsw_nuss_rx_packets(struct am65_cpsw_rx_flow *flow,
 
 	desc_idx = am65_cpsw_nuss_desc_idx(rx_chn->desc_pool, desc_rx,
 					   rx_chn->dsize_log2);
-
 	skb = am65_cpsw_build_skb(page_addr, ndev,
 				  AM65_CPSW_MAX_PACKET_SIZE);
 	if (unlikely(!skb)) {
@@ -1213,7 +1209,7 @@ static int am65_cpsw_nuss_rx_packets(struct am65_cpsw_rx_flow *flow,
 		xdp_init_buff(&xdp, PAGE_SIZE, &port->xdp_rxq[flow->id]);
 		xdp_prepare_buff(&xdp, page_addr, AM65_CPSW_HEADROOM,
 				 pkt_len, false);
-		*xdp_state = am65_cpsw_run_xdp(flow, port, &xdp, desc_idx,
+		*xdp_state = am65_cpsw_run_xdp(flow, port, &xdp,
 					       cpu, &pkt_len);
 		if (*xdp_state != AM65_CPSW_XDP_PASS)
 			goto allocate;
@@ -1247,10 +1243,8 @@ static int am65_cpsw_nuss_rx_packets(struct am65_cpsw_rx_flow *flow,
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
@@ -1258,7 +1252,7 @@ static int am65_cpsw_nuss_rx_packets(struct am65_cpsw_rx_flow *flow,
 requeue:
 	ret = am65_cpsw_nuss_rx_push(common, new_page, flow_idx);
 	if (WARN_ON(ret < 0)) {
-		am65_cpsw_put_page(flow, new_page, true, desc_idx);
+		am65_cpsw_put_page(flow, new_page, true);
 		ndev->stats.rx_errors++;
 		ndev->stats.rx_dropped++;
 	}
@@ -2402,10 +2396,6 @@ static int am65_cpsw_nuss_init_rx_chns(struct am65_cpsw_common *common)
 	for (i = 0; i < common->rx_ch_num_flows; i++) {
 		flow = &rx_chn->flows[i];
 		flow->page_pool = NULL;
-		flow->pages = devm_kcalloc(dev, AM65_CPSW_MAX_RX_DESC,
-					   sizeof(*flow->pages), GFP_KERNEL);
-		if (!flow->pages)
-			return -ENOMEM;
 	}
 
 	rx_chn->rx_chn = k3_udma_glue_request_rx_chn(dev, "rx", &rx_cfg);
@@ -2455,10 +2445,12 @@ static int am65_cpsw_nuss_init_rx_chns(struct am65_cpsw_common *common)
 		flow = &rx_chn->flows[i];
 		flow->id = i;
 		flow->common = common;
+		flow->irq = -EINVAL;
 
 		rx_flow_cfg.ring_rxfdq0_id = fdqring_id;
 		rx_flow_cfg.rx_cfg.size = max_desc_num;
-		rx_flow_cfg.rxfdq_cfg.size = max_desc_num;
+		/* share same FDQ for all flows */
+		rx_flow_cfg.rxfdq_cfg.size = max_desc_num * rx_cfg.flow_id_num;
 		rx_flow_cfg.rxfdq_cfg.mode = common->pdata.fdqring_mode;
 
 		ret = k3_udma_glue_rx_flow_init(rx_chn->rx_chn,
@@ -2496,6 +2488,7 @@ static int am65_cpsw_nuss_init_rx_chns(struct am65_cpsw_common *common)
 		if (ret) {
 			dev_err(dev, "failure requesting rx %d irq %u, %d\n",
 				i, flow->irq, ret);
+			flow->irq = -EINVAL;
 			goto err;
 		}
 	}
@@ -3349,8 +3342,8 @@ static int am65_cpsw_nuss_register_ndevs(struct am65_cpsw_common *common)
 
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

---
base-commit: 42f7652d3eb527d03665b09edac47f85fb600924
change-id: 20241023-am65-cpsw-multi-rx-j7-fix-f9a2149be6dd

Best regards,
-- 
Roger Quadros <rogerq@kernel.org>


