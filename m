Return-Path: <bpf+bounces-51725-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD645A37C53
	for <lists+bpf@lfdr.de>; Mon, 17 Feb 2025 08:34:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 559E3170415
	for <lists+bpf@lfdr.de>; Mon, 17 Feb 2025 07:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 850F81A9B2B;
	Mon, 17 Feb 2025 07:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eJUJP0XI"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062F31990D8;
	Mon, 17 Feb 2025 07:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739777534; cv=none; b=ohoAR9M8YwIuVVd6BaxBpfh3ZW3pjHPluJeZBVWQgvh9HVj9SkoVM7WzWrYifetTAZwhhTXMyXAjphrEJHyNSaZujvrswTmVhim5clagLokwwYlu/N7mWTv+SbBFoOWK5soIWSB8qFQcWIzIwYSRWAwdrQQ3wc2agddntN3EDdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739777534; c=relaxed/simple;
	bh=9NR9uTpmBKM+b/8es4AdXLZK28bJM1hev9e485P/wLY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KJfs9wXgzG8DWJbZQGIqnA0GyCftyv12I5k31Xaj8iTCeN2K07yl07puselYaVF55vmt+0JIBRWgWrmlHWukwSbur4i50uOth6bevGbnanJVIaay+/Atj1V+P2S4FJaX9XccHHx0McYRZk6MA90kzqGYvAU6qPKMUVICKNqXWqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eJUJP0XI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07B05C4CEE2;
	Mon, 17 Feb 2025 07:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739777533;
	bh=9NR9uTpmBKM+b/8es4AdXLZK28bJM1hev9e485P/wLY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=eJUJP0XIwYSpXC/6dzPHdpZCjuomZu1kgWDecA4iagXwSCKSLQJE2xHebREWaDoKv
	 +I9yx0/C0bOtFPlzdncsWSbsRegkFzvkAMcQ8SSXygIzEBoztf3yZAPYCNApcMNO0q
	 1laf6DJe5TOZ2ZLRMzgfdvcEtKrvi8r/xJSsr/yeOQMllHNpcnIa8sjqgVuTCw2M7s
	 AtmWM54pJnd+CXvfWyzygq5X4XPCNAUc8oPk+ZHNT79bZqu29hmg864BMO+mJMSUAh
	 FLAjQZrafG5y3qfXNknMPFNkDjDfb/0YwOm+PPNEjLmGuYsSSAXSw+yI+T3LZFHMY9
	 QzCtBiwwKB9zA==
From: Roger Quadros <rogerq@kernel.org>
Date: Mon, 17 Feb 2025 09:31:50 +0200
Subject: [PATCH net-next 5/5] net: ethernet: ti am65_cpsw: Drop separate TX
 completion functions
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250217-am65-cpsw-zc-prep-v1-5-ce450a62d64f@kernel.org>
References: <20250217-am65-cpsw-zc-prep-v1-0-ce450a62d64f@kernel.org>
In-Reply-To: <20250217-am65-cpsw-zc-prep-v1-0-ce450a62d64f@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Siddharth Vadapalli <s-vadapalli@ti.com>, 
 Md Danish Anwar <danishanwar@ti.com>
Cc: srk@ti.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, Roger Quadros <rogerq@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=7478; i=rogerq@kernel.org;
 h=from:subject:message-id; bh=9NR9uTpmBKM+b/8es4AdXLZK28bJM1hev9e485P/wLY=;
 b=owEBbQKS/ZANAwAIAdJaa9O+djCTAcsmYgBnsuXmEyIePQd9YEPN2pu3BwgVtOrkS7DSCm0Lw
 8Tal2YWG8yJAjMEAAEIAB0WIQRBIWXUTJ9SeA+rEFjSWmvTvnYwkwUCZ7Ll5gAKCRDSWmvTvnYw
 kz1OEACPetSKeh0GKVbNUc4GzjCa2PoQXCqa8as2sGqzUUvb7S7ksBsKEv/78f+EGvO77/lP4Lw
 bDQ1Gn9T/mHFVv+x8Ury9rVBaDOStgus/FASST9eR/LNTw3W99iZ0dBGjIqP+a0J0t40a1byfdh
 gQR0wxXvw91VnjUqRU3JeRG5s7bv7HrnCDYFR64p7PuhpbJAWrxF8sqPGz4q4Mp3bUGRxZ3fqRO
 zBe4fFY/WpRknrXwp8+uKNZXntIo0X0aExIk8XW0uj6baaga6HEXoTGQWr/JFJoQrM5UO6lM8b3
 jBsai9NVUMVX33XOsjwBCHPY0kl/573JQRdKLNsiAfHIglH9Q44+n1/yVHlmn31BCFh4cTmHVu8
 t16eSS/gWpxF7k0bb5vt2uPpXVoo182OOu29Ga3fhfWSMsQtVvwpuhlh6uw8ps6qY+aESCT9QY1
 QOEHiFRFueblTVVAUGsRp3VIv6EJLFqIKdYMKUBfyTyLXRVqijdACdTNZTnbDxv7xkOqeDmBhF6
 wTKv+jT6GiHnCYpcRVpq9U6V6g+r0A2+E5YNYXcgTgOhbNLKyzMYK9BM2JBxvzMTHR+ZC4MXsYK
 NLWexSwiIA+8AIMwvwMTRS5myqK7OjAdkyudzL+tEnEtNCYcRK3jURE9uEba5P2BFCLbqWWKMSS
 f4YKlDucdjGVW6Q==
X-Developer-Key: i=rogerq@kernel.org; a=openpgp;
 fpr=412165D44C9F52780FAB1058D25A6BD3BE763093

Drop separate TX completion functions for SKB and XDP. To do that
use the SW_DATA mechanism to store ndev and skb/xdpf for TX packets.

Use BUILD_BUG_ON_MSG() to fail build if SW_DATA size exceeds whats
available. i.e. AM65_CPSW_NAV_SW_DATA_SIZE.

Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
 drivers/net/ethernet/ti/am65-cpsw-nuss.c | 82 ++++++++++----------------------
 drivers/net/ethernet/ti/am65-cpsw-nuss.h |  8 ++++
 2 files changed, 32 insertions(+), 58 deletions(-)

diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
index 32349cc58e2e..213ec2cbe436 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
@@ -830,19 +830,19 @@ static void am65_cpsw_nuss_tx_cleanup(void *data, dma_addr_t desc_dma)
 {
 	struct am65_cpsw_tx_chn *tx_chn = data;
 	enum am65_cpsw_tx_buf_type buf_type;
+	struct am65_cpsw_tx_swdata *swdata;
 	struct cppi5_host_desc_t *desc_tx;
 	struct xdp_frame *xdpf;
 	struct sk_buff *skb;
-	void **swdata;
 
 	desc_tx = k3_cppi_desc_pool_dma2virt(tx_chn->desc_pool, desc_dma);
 	swdata = cppi5_hdesc_get_swdata(desc_tx);
 	buf_type = am65_cpsw_nuss_buf_type(tx_chn, desc_dma);
 	if (buf_type == AM65_CPSW_TX_BUF_TYPE_SKB) {
-		skb = *(swdata);
+		skb = swdata->skb;
 		dev_kfree_skb_any(skb);
 	} else {
-		xdpf = *(swdata);
+		xdpf = swdata->xdpf;
 		xdp_return_frame(xdpf);
 	}
 
@@ -1099,10 +1099,10 @@ static int am65_cpsw_xdp_tx_frame(struct net_device *ndev,
 	struct am65_cpsw_common *common = am65_ndev_to_common(ndev);
 	struct am65_cpsw_port *port = am65_ndev_to_port(ndev);
 	struct cppi5_host_desc_t *host_desc;
+	struct am65_cpsw_tx_swdata *swdata;
 	struct netdev_queue *netif_txq;
 	dma_addr_t dma_desc, dma_buf;
 	u32 pkt_len = xdpf->len;
-	void **swdata;
 	int ret;
 
 	host_desc = k3_cppi_desc_pool_alloc(tx_chn->desc_pool);
@@ -1132,7 +1132,8 @@ static int am65_cpsw_xdp_tx_frame(struct net_device *ndev,
 	cppi5_hdesc_attach_buf(host_desc, dma_buf, pkt_len, dma_buf, pkt_len);
 
 	swdata = cppi5_hdesc_get_swdata(host_desc);
-	*(swdata) = xdpf;
+	swdata->ndev = ndev;
+	swdata->xdpf = xdpf;
 
 	/* Report BQL before sending the packet */
 	netif_txq = netdev_get_tx_queue(ndev, tx_chn->id);
@@ -1433,52 +1434,6 @@ static int am65_cpsw_nuss_rx_poll(struct napi_struct *napi_rx, int budget)
 	return num_rx;
 }
 
-static struct sk_buff *
-am65_cpsw_nuss_tx_compl_packet_skb(struct am65_cpsw_tx_chn *tx_chn,
-				   dma_addr_t desc_dma)
-{
-	struct cppi5_host_desc_t *desc_tx;
-	struct sk_buff *skb;
-	void **swdata;
-
-	desc_tx = k3_cppi_desc_pool_dma2virt(tx_chn->desc_pool,
-					     desc_dma);
-	swdata = cppi5_hdesc_get_swdata(desc_tx);
-	skb = *(swdata);
-	am65_cpsw_nuss_xmit_free(tx_chn, desc_tx);
-
-	am65_cpts_tx_timestamp(tx_chn->common->cpts, skb);
-
-	dev_sw_netstats_tx_add(skb->dev, 1, skb->len);
-
-	return skb;
-}
-
-static struct xdp_frame *
-am65_cpsw_nuss_tx_compl_packet_xdp(struct am65_cpsw_common *common,
-				   struct am65_cpsw_tx_chn *tx_chn,
-				   dma_addr_t desc_dma,
-				   struct net_device **ndev)
-{
-	struct cppi5_host_desc_t *desc_tx;
-	struct am65_cpsw_port *port;
-	struct xdp_frame *xdpf;
-	u32 port_id = 0;
-	void **swdata;
-
-	desc_tx = k3_cppi_desc_pool_dma2virt(tx_chn->desc_pool, desc_dma);
-	cppi5_desc_get_tags_ids(&desc_tx->hdr, NULL, &port_id);
-	swdata = cppi5_hdesc_get_swdata(desc_tx);
-	xdpf = *(swdata);
-	am65_cpsw_nuss_xmit_free(tx_chn, desc_tx);
-
-	port = am65_common_get_port(common, port_id);
-	dev_sw_netstats_tx_add(port->ndev, 1, xdpf->len);
-	*ndev = port->ndev;
-
-	return xdpf;
-}
-
 static void am65_cpsw_nuss_tx_wake(struct am65_cpsw_tx_chn *tx_chn, struct net_device *ndev,
 				   struct netdev_queue *netif_txq)
 {
@@ -1501,6 +1456,8 @@ static int am65_cpsw_nuss_tx_compl_packets(struct am65_cpsw_common *common,
 {
 	bool single_port = AM65_CPSW_IS_CPSW2G(common);
 	enum am65_cpsw_tx_buf_type buf_type;
+	struct am65_cpsw_tx_swdata *swdata;
+	struct cppi5_host_desc_t *desc_tx;
 	struct device *dev = common->dev;
 	struct am65_cpsw_tx_chn *tx_chn;
 	struct netdev_queue *netif_txq;
@@ -1531,15 +1488,18 @@ static int am65_cpsw_nuss_tx_compl_packets(struct am65_cpsw_common *common,
 			break;
 		}
 
+		desc_tx = k3_cppi_desc_pool_dma2virt(tx_chn->desc_pool,
+						     desc_dma);
+		swdata = cppi5_hdesc_get_swdata(desc_tx);
+		ndev = swdata->ndev;
 		buf_type = am65_cpsw_nuss_buf_type(tx_chn, desc_dma);
 		if (buf_type == AM65_CPSW_TX_BUF_TYPE_SKB) {
-			skb = am65_cpsw_nuss_tx_compl_packet_skb(tx_chn, desc_dma);
-			ndev = skb->dev;
+			skb = swdata->skb;
+			am65_cpts_tx_timestamp(tx_chn->common->cpts, skb);
 			pkt_len = skb->len;
 			napi_consume_skb(skb, budget);
 		} else {
-			xdpf = am65_cpsw_nuss_tx_compl_packet_xdp(common, tx_chn,
-								  desc_dma, &ndev);
+			xdpf = swdata->xdpf;
 			pkt_len = xdpf->len;
 			if (buf_type == AM65_CPSW_TX_BUF_TYPE_XDP_TX)
 				xdp_return_frame_rx_napi(xdpf);
@@ -1549,7 +1509,8 @@ static int am65_cpsw_nuss_tx_compl_packets(struct am65_cpsw_common *common,
 
 		total_bytes += pkt_len;
 		num_tx++;
-
+		am65_cpsw_nuss_xmit_free(tx_chn, desc_tx);
+		dev_sw_netstats_tx_add(ndev, 1, pkt_len);
 		if (!single_port) {
 			/* as packets from multi ports can be interleaved
 			 * on the same channel, we have to figure out the
@@ -1632,12 +1593,12 @@ static netdev_tx_t am65_cpsw_nuss_ndo_slave_xmit(struct sk_buff *skb,
 	struct am65_cpsw_common *common = am65_ndev_to_common(ndev);
 	struct cppi5_host_desc_t *first_desc, *next_desc, *cur_desc;
 	struct am65_cpsw_port *port = am65_ndev_to_port(ndev);
+	struct am65_cpsw_tx_swdata *swdata;
 	struct device *dev = common->dev;
 	struct am65_cpsw_tx_chn *tx_chn;
 	struct netdev_queue *netif_txq;
 	dma_addr_t desc_dma, buf_dma;
 	int ret, q_idx, i;
-	void **swdata;
 	u32 *psdata;
 	u32 pkt_len;
 
@@ -1683,7 +1644,8 @@ static netdev_tx_t am65_cpsw_nuss_ndo_slave_xmit(struct sk_buff *skb,
 	k3_udma_glue_tx_dma_to_cppi5_addr(tx_chn->tx_chn, &buf_dma);
 	cppi5_hdesc_attach_buf(first_desc, buf_dma, pkt_len, buf_dma, pkt_len);
 	swdata = cppi5_hdesc_get_swdata(first_desc);
-	*(swdata) = skb;
+	swdata->ndev = ndev;
+	swdata->skb = skb;
 	psdata = cppi5_hdesc_get_psdata(first_desc);
 
 	/* HW csum offload if enabled */
@@ -3525,6 +3487,10 @@ static int am65_cpsw_nuss_probe(struct platform_device *pdev)
 	__be64 id_temp;
 	int ret, i;
 
+	BUILD_BUG_ON_MSG(sizeof(struct am65_cpsw_tx_swdata) > AM65_CPSW_NAV_SW_DATA_SIZE,
+			 "TX SW_DATA size exceeds AM65_CPSW_NAV_SW_DATA_SIZE");
+	BUILD_BUG_ON_MSG(sizeof(struct am65_cpsw_swdata) > AM65_CPSW_NAV_SW_DATA_SIZE,
+			 "SW_DATA size exceeds AM65_CPSW_NAV_SW_DATA_SIZE");
 	common = devm_kzalloc(dev, sizeof(struct am65_cpsw_common), GFP_KERNEL);
 	if (!common)
 		return -ENOMEM;
diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.h b/drivers/net/ethernet/ti/am65-cpsw-nuss.h
index e7832a5cf3cc..917c37e4e89b 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-nuss.h
+++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.h
@@ -104,6 +104,14 @@ struct am65_cpsw_rx_flow {
 	char name[32];
 };
 
+struct am65_cpsw_tx_swdata {
+	struct net_device *ndev;
+	union {
+		struct sk_buff *skb;
+		struct xdp_frame *xdpf;
+	};
+};
+
 struct am65_cpsw_swdata {
 	u32 flow_id;
 	struct page *page;

-- 
2.34.1


