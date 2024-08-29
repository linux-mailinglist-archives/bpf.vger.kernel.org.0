Return-Path: <bpf+bounces-38394-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BADD39643D4
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 14:04:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E05B21C24A02
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 12:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FECD1A255C;
	Thu, 29 Aug 2024 12:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dlXG5kV3"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E257719413F;
	Thu, 29 Aug 2024 12:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724933025; cv=none; b=ghQ++vUGrp1CkrEHsIliEqFo1mkfZsq9qqWTmxXapahaoR44sOmkfQ+jKxrtW0oK5GLgtDw5NYW1MDQtDpPoaBabDKtKiaFFuJqXAlb9PuL95n2wyJx1je4Bif/CULTASwWB+OJeBqwXnYNSxaK1DtTov1vnAuE/FLr9qy7sSvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724933025; c=relaxed/simple;
	bh=r5XZpgwDTpFEg9NaErhvFH2hf10hQkTPuSlKas4duBw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mJZwgEIXlZos9JMTOhTqFR0cq7/MhzlIALNIYvtLAD5P4VOkS5+fVMYtWm8wXB3Lej8pKOQ+/RLS6fU6E466Gh3iBRgFyqwOtnG/Oqqbqm46rszyuGwCfPzXODWFOhj2yIuqaHZkLPuYVxkqK3StvwFE3gVUeQKZSD8/3t6GT7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dlXG5kV3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7C5CC4CEC7;
	Thu, 29 Aug 2024 12:03:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724933024;
	bh=r5XZpgwDTpFEg9NaErhvFH2hf10hQkTPuSlKas4duBw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=dlXG5kV3uqV1qmhrcaYDhIYNUntyYUrsSyAYF70k857u93alTy/gN15j8WBI0kDOZ
	 3PxpIYBA43vCdELF59pFCAMOtIps0KcJdzGLM8LTfv4e9jh4tu4XCUYFiRuilgSf32
	 rEwjim9px6/TFKTHcaJKRu20vTaWXldh2VEzjGjEP1X7S7gTSTAMExgCVwRjkBCATJ
	 TxKxP7xYhoAMJDz9y88B26Fw/WmcCJHKATdCbTqG0LKZFCQMEJTkkIKGzbzourOz44
	 iMhHIEvibuEdHUAk9mqiSUMP3OR5D+VuQAB3BJznPC2gYdUNaUAU7nxjLOXkcfLlHM
	 l6QH9qfc7B0sg==
From: Roger Quadros <rogerq@kernel.org>
Date: Thu, 29 Aug 2024 15:03:19 +0300
Subject: [PATCH net 1/3] net: ethernet: ti: am65-cpsw: fix XDP_DROP, XDP_TX
 and XDP_REDIRECT
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240829-am65-cpsw-xdp-v1-1-ff3c81054a5e@kernel.org>
References: <20240829-am65-cpsw-xdp-v1-0-ff3c81054a5e@kernel.org>
In-Reply-To: <20240829-am65-cpsw-xdp-v1-0-ff3c81054a5e@kernel.org>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Julien Panis <jpanis@baylibre.com>, Jacob Keller <jacob.e.keller@intel.com>
Cc: Siddharth Vadapalli <s-vadapalli@ti.com>, 
 Md Danish Anwar <danishanwar@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Govindarajan Sriramakrishnan <srk@ti.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 Roger Quadros <rogerq@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=7282; i=rogerq@kernel.org;
 h=from:subject:message-id; bh=r5XZpgwDTpFEg9NaErhvFH2hf10hQkTPuSlKas4duBw=;
 b=owEBbQKS/ZANAwAIAdJaa9O+djCTAcsmYgBm0GOXTVM39qQTKlHGotBjOdoTbjnrFnzJqMVN7
 1ixQN/xwQ+JAjMEAAEIAB0WIQRBIWXUTJ9SeA+rEFjSWmvTvnYwkwUCZtBjlwAKCRDSWmvTvnYw
 kxjMEACZa7YTR1P0eJc5F8QIO6VEwb9jTHY2RqZhZti0fp06h7E4VDCuXQ1MeNaIDPeFceFCvTs
 9xPOUo9l2DTf1C2b9o6vJ3CBuWQjW4dqccwbve92xjG2tbZ7tKEwgvsj/ECoK+PFgKXc3dBo81M
 gJNZdwtjZzHjScE6DFwJ5O0uW+hVPP4HDKe79CVYE/bvnoVgK5d9sIgRNUFYk3m8La1/Jn5QvNc
 fLeL/JL8vilC+W5Ux2oNdw4DNIYPvPzwnMbJO6Cd1mNKC0jPMjBvi37UXB2cRf3Skd3Z4YQ0NPa
 i2yl/x8ff45yFmGWd56qMOqpXjeEx0m47RhoAKrLGPjSxkvsCMERL+j+oCosvnzvw8l3jZqn1F7
 VvLDQmADsWdz/Wmu581KheghVeWT/FBY98rw6+GsvUm1aTyP0OQpqW3VD28hcyni7dLWD09FA5P
 p/NYvZ6RFIv/0jTKY0C62UJQsMU1dbzDLRzauaCJXln88GfdA7kayEmjUTws2yddAqm0Rrppi03
 miuvMB4QrUUbKHMGHi9WAwxVxNSBzf9sDwY31e7JeQEev4jA/OdJwG5+yHXv0B47TcKKYbKC4zN
 xYh+O9+M6OV/Q400MaQ0tEN9cL7Brazrr5F+aSSWHwfR5SmOavUrKglRd4gET+5jGnrsNfPWuod
 NzJMEDB4/IOakpw==
X-Developer-Key: i=rogerq@kernel.org; a=openpgp;
 fpr=412165D44C9F52780FAB1058D25A6BD3BE763093

The following XDP_DROP test from [1] stalls the interface after
250 packets.
~# xdb-bench drop -m native eth0
This is because new RX requests are never queued. Fix that.

The below XDP_TX test from [1] fails with a warning
[  499.947381] XDP_WARN: xdp_update_frame_from_buff(line:277): Driver BUG: missing reserved tailroom
~# xdb-bench tx -m native eth0
Fix that by using PAGE_SIZE during xdp_init_buf().

In XDP_REDIRECT case only 1 packet was processed in rx_poll.
Fix it to process up to budget packets.

Fix all XDP error cases to call trace_xdp_exception() and drop the packet
in am65_cpsw_run_xdp().

[1] xdp-tools suite https://github.com/xdp-project/xdp-tools

Fixes: 8acacc40f733 ("net: ethernet: ti: am65-cpsw: Add minimal XDP support")
Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
 drivers/net/ethernet/ti/am65-cpsw-nuss.c | 62 +++++++++++++++++---------------
 1 file changed, 34 insertions(+), 28 deletions(-)

diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
index 81d9f21086ec..9fd2ba26716c 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
@@ -156,12 +156,13 @@
 #define AM65_CPSW_CPPI_TX_PKT_TYPE 0x7
 
 /* XDP */
-#define AM65_CPSW_XDP_CONSUMED 2
-#define AM65_CPSW_XDP_REDIRECT 1
+#define AM65_CPSW_XDP_CONSUMED BIT(1)
+#define AM65_CPSW_XDP_REDIRECT BIT(0)
 #define AM65_CPSW_XDP_PASS     0
 
 /* Include headroom compatible with both skb and xdpf */
-#define AM65_CPSW_HEADROOM (max(NET_SKB_PAD, XDP_PACKET_HEADROOM) + NET_IP_ALIGN)
+#define AM65_CPSW_HEADROOM_NA (max(NET_SKB_PAD, XDP_PACKET_HEADROOM) + NET_IP_ALIGN)
+#define AM65_CPSW_HEADROOM ALIGN(AM65_CPSW_HEADROOM_NA, sizeof(long))
 
 static void am65_cpsw_port_set_sl_mac(struct am65_cpsw_port *slave,
 				      const u8 *dev_addr)
@@ -933,7 +934,7 @@ static int am65_cpsw_xdp_tx_frame(struct net_device *ndev,
 	host_desc = k3_cppi_desc_pool_alloc(tx_chn->desc_pool);
 	if (unlikely(!host_desc)) {
 		ndev->stats.tx_dropped++;
-		return -ENOMEM;
+		return AM65_CPSW_XDP_CONSUMED;	/* drop */
 	}
 
 	am65_cpsw_nuss_set_buf_type(tx_chn, host_desc, buf_type);
@@ -942,7 +943,7 @@ static int am65_cpsw_xdp_tx_frame(struct net_device *ndev,
 				 pkt_len, DMA_TO_DEVICE);
 	if (unlikely(dma_mapping_error(tx_chn->dma_dev, dma_buf))) {
 		ndev->stats.tx_dropped++;
-		ret = -ENOMEM;
+		ret = AM65_CPSW_XDP_CONSUMED;	/* drop */
 		goto pool_free;
 	}
 
@@ -977,6 +978,7 @@ static int am65_cpsw_xdp_tx_frame(struct net_device *ndev,
 		/* Inform BQL */
 		netdev_tx_completed_queue(netif_txq, 1, pkt_len);
 		ndev->stats.tx_errors++;
+		ret = AM65_CPSW_XDP_CONSUMED; /* drop */
 		goto dma_unmap;
 	}
 
@@ -1004,6 +1006,7 @@ static int am65_cpsw_run_xdp(struct am65_cpsw_common *common,
 	struct bpf_prog *prog;
 	struct page *page;
 	u32 act;
+	int err;
 
 	prog = READ_ONCE(port->xdp_prog);
 	if (!prog)
@@ -1023,14 +1026,14 @@ static int am65_cpsw_run_xdp(struct am65_cpsw_common *common,
 
 		xdpf = xdp_convert_buff_to_frame(xdp);
 		if (unlikely(!xdpf))
-			break;
+			goto drop;
 
 		__netif_tx_lock(netif_txq, cpu);
-		ret = am65_cpsw_xdp_tx_frame(ndev, tx_chn, xdpf,
+		err = am65_cpsw_xdp_tx_frame(ndev, tx_chn, xdpf,
 					     AM65_CPSW_TX_BUF_TYPE_XDP_TX);
 		__netif_tx_unlock(netif_txq);
-		if (ret)
-			break;
+		if (err)
+			goto drop;
 
 		ndev->stats.rx_bytes += *len;
 		ndev->stats.rx_packets++;
@@ -1038,7 +1041,7 @@ static int am65_cpsw_run_xdp(struct am65_cpsw_common *common,
 		goto out;
 	case XDP_REDIRECT:
 		if (unlikely(xdp_do_redirect(ndev, xdp, prog)))
-			break;
+			goto drop;
 
 		ndev->stats.rx_bytes += *len;
 		ndev->stats.rx_packets++;
@@ -1048,6 +1051,7 @@ static int am65_cpsw_run_xdp(struct am65_cpsw_common *common,
 		bpf_warn_invalid_xdp_action(ndev, prog, act);
 		fallthrough;
 	case XDP_ABORTED:
+drop:
 		trace_xdp_exception(ndev, prog, act);
 		fallthrough;
 	case XDP_DROP:
@@ -1056,7 +1060,6 @@ static int am65_cpsw_run_xdp(struct am65_cpsw_common *common,
 
 	page = virt_to_head_page(xdp->data);
 	am65_cpsw_put_page(rx_chn, page, true, desc_idx);
-
 out:
 	return ret;
 }
@@ -1095,7 +1098,7 @@ static void am65_cpsw_nuss_rx_csum(struct sk_buff *skb, u32 csum_info)
 }
 
 static int am65_cpsw_nuss_rx_packets(struct am65_cpsw_common *common,
-				     u32 flow_idx, int cpu)
+				     u32 flow_idx, int cpu, int *xdp_state)
 {
 	struct am65_cpsw_rx_chn *rx_chn = &common->rx_chns;
 	u32 buf_dma_len, pkt_len, port_id = 0, csum_info;
@@ -1114,6 +1117,7 @@ static int am65_cpsw_nuss_rx_packets(struct am65_cpsw_common *common,
 	void **swdata;
 	u32 *psdata;
 
+	*xdp_state = AM65_CPSW_XDP_PASS;
 	ret = k3_udma_glue_pop_rx_chn(rx_chn->rx_chn, flow_idx, &desc_dma);
 	if (ret) {
 		if (ret != -ENODATA)
@@ -1161,15 +1165,13 @@ static int am65_cpsw_nuss_rx_packets(struct am65_cpsw_common *common,
 	}
 
 	if (port->xdp_prog) {
-		xdp_init_buff(&xdp, AM65_CPSW_MAX_PACKET_SIZE, &port->xdp_rxq);
-
-		xdp_prepare_buff(&xdp, page_addr, skb_headroom(skb),
+		xdp_init_buff(&xdp, PAGE_SIZE, &port->xdp_rxq);
+		xdp_prepare_buff(&xdp, page_addr, AM65_CPSW_HEADROOM,
 				 pkt_len, false);
-
-		ret = am65_cpsw_run_xdp(common, port, &xdp, desc_idx,
-					cpu, &pkt_len);
-		if (ret != AM65_CPSW_XDP_PASS)
-			return ret;
+		*xdp_state = am65_cpsw_run_xdp(common, port, &xdp, desc_idx,
+					       cpu, &pkt_len);
+		if (*xdp_state != AM65_CPSW_XDP_PASS)
+			goto allocate;
 
 		/* Compute additional headroom to be reserved */
 		headroom = (xdp.data - xdp.data_hard_start) - skb_headroom(skb);
@@ -1193,9 +1195,13 @@ static int am65_cpsw_nuss_rx_packets(struct am65_cpsw_common *common,
 	stats->rx_bytes += pkt_len;
 	u64_stats_update_end(&stats->syncp);
 
+allocate:
 	new_page = page_pool_dev_alloc_pages(rx_chn->page_pool);
-	if (unlikely(!new_page))
+	if (unlikely(!new_page)) {
+		dev_err(dev, "page alloc failed\n");
 		return -ENOMEM;
+	}
+
 	rx_chn->pages[desc_idx] = new_page;
 
 	if (netif_dormant(ndev)) {
@@ -1229,8 +1235,9 @@ static int am65_cpsw_nuss_rx_poll(struct napi_struct *napi_rx, int budget)
 	struct am65_cpsw_common *common = am65_cpsw_napi_to_common(napi_rx);
 	int flow = AM65_CPSW_MAX_RX_FLOWS;
 	int cpu = smp_processor_id();
-	bool xdp_redirect = false;
+	int xdp_state_or = 0;
 	int cur_budget, ret;
+	int xdp_state;
 	int num_rx = 0;
 
 	/* process every flow */
@@ -1238,12 +1245,11 @@ static int am65_cpsw_nuss_rx_poll(struct napi_struct *napi_rx, int budget)
 		cur_budget = budget - num_rx;
 
 		while (cur_budget--) {
-			ret = am65_cpsw_nuss_rx_packets(common, flow, cpu);
-			if (ret) {
-				if (ret == AM65_CPSW_XDP_REDIRECT)
-					xdp_redirect = true;
+			ret = am65_cpsw_nuss_rx_packets(common, flow, cpu,
+							&xdp_state);
+			xdp_state_or |= xdp_state;
+			if (ret)
 				break;
-			}
 			num_rx++;
 		}
 
@@ -1251,7 +1257,7 @@ static int am65_cpsw_nuss_rx_poll(struct napi_struct *napi_rx, int budget)
 			break;
 	}
 
-	if (xdp_redirect)
+	if (xdp_state_or & AM65_CPSW_XDP_REDIRECT)
 		xdp_do_flush();
 
 	dev_dbg(common->dev, "%s num_rx:%d %d\n", __func__, num_rx, budget);

-- 
2.34.1


