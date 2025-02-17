Return-Path: <bpf+bounces-51721-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A1B4A37C42
	for <lists+bpf@lfdr.de>; Mon, 17 Feb 2025 08:32:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 000FD188AC59
	for <lists+bpf@lfdr.de>; Mon, 17 Feb 2025 07:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDD7419E97F;
	Mon, 17 Feb 2025 07:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uZ8dQFE4"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7A819CC05;
	Mon, 17 Feb 2025 07:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739777518; cv=none; b=An91Jlb1Eg8JqmCZdKN5BtjG72Hii/XXLqBqnKJKjlvX/9QW3jeI+xXjm+RON1Tdy6lsrSyUvzUzDKvt+gW/OobPYK8twNEFxrzj2GWMnc5X/ZY274XbP8qB9omLCjKDyOCyIByhBbXGkan7d7Om3fHfkODrDaV0yf7M5CObPa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739777518; c=relaxed/simple;
	bh=cy12FEVXGEV4OubjLglharecSYtdE4eJP4FWZn1J20U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Y+cry/BlfagKdWclpy+WX69sc7KBSE32+Ylgi5zlJtFOnphJRBpuNtR4ix36KajuF63PIYOqGD1Vzc+3rUCkVKjkfVCBoc7CHt1xli12BpUEcmsMKhCrN24MIgBvo0PySa0BKSnd2XO4vzbKGYpPcaPNaqsbKkfUxnEDBTFGMfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uZ8dQFE4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74FD1C4CEE9;
	Mon, 17 Feb 2025 07:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739777517;
	bh=cy12FEVXGEV4OubjLglharecSYtdE4eJP4FWZn1J20U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=uZ8dQFE420+AaxXCt3E4MPMhx9qOMyJXeYN/gUMATow/4wGKxcJtr4+dHBEM17L5S
	 CC9Kjp3FUD359/wcaVMzht9xTGVgsv6Qf25Nlu+wd29rf/yGSUdsZ0P0tg9H0Vy7bx
	 h7mc1mi5T7WHyoW08kTnltliKag9wWBRSDgXfeKwsMIJt+QVtHtlESTRQwil/jzbaU
	 BNRtjQ6zz0/UZM+2OVgoRylZM/gKbrExzyoE0oPtMxqaNMH68aWMlK+KN5qgDxS2No
	 3B5TcrAJpd/amM1DRzl3EX2q2oatam5lffNXbrLrzM2sBMwtPLOy1ec4yhaMXa5ZXZ
	 UqJJ5eEzisDVA==
From: Roger Quadros <rogerq@kernel.org>
Date: Mon, 17 Feb 2025 09:31:46 +0200
Subject: [PATCH net-next 1/5] net: ethernet: ti: am65-cpsw: remove
 am65_cpsw_nuss_tx_compl_packets_2g()
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250217-am65-cpsw-zc-prep-v1-1-ce450a62d64f@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5645; i=rogerq@kernel.org;
 h=from:subject:message-id; bh=cy12FEVXGEV4OubjLglharecSYtdE4eJP4FWZn1J20U=;
 b=owEBbQKS/ZANAwAIAdJaa9O+djCTAcsmYgBnsuXlt1wKi4z4dCGjceGBFQ2jGiMGSMv03HMJU
 Zw9WuGtMT+JAjMEAAEIAB0WIQRBIWXUTJ9SeA+rEFjSWmvTvnYwkwUCZ7Ll5QAKCRDSWmvTvnYw
 kxOID/44ZZl0LfSjQAalIegP/gE/FlZM3uqmQtByJgzhzK8102iuJEYP60ygBKi/ji8DG/NriEc
 nMgzkgW7AKKaT5ZGLvwCwcOFEWcdp0LtJpAHqB5IE3r3sb30/HigGsXocJ+qhPxjCCyyc+YTnZi
 Pk6Q7u/8mWShM2ZnKieJwW3RU2VIGvwkfYPs5kLqemDw6IQTlml6bS2ZGcYTCqZgKR/4Ony3P3Y
 h+aMo5mklY80t2irlDW/mtJC6ZCS0Ol7d7pnBolCPBa81D5pGaqXfxWRYRsC4Cr/+HhGZxjxWhH
 mfIpn7AOjLZzfnZD1Bk+4vmCbdwJHtHYhsUP2Ch27xHrHmFPhbQvTgNgm3J1ndayO3E2zkwwAU2
 8LKV8gfy9HtZWPVm64j3Oa5yWU8upWUBC1yQbagrOVZjP5tII9IvqWeDv51yIRFhzHm9d1VN5bc
 CacNL53C1cHFmKy46kT+qJk9x+gAOprpr6YvXu5oQlzQLEPJe7Uoc4N5E+5CM++9iBYG2K1qYgW
 qrMh5PMY9D1qqLj/re4omttvqGz8pVCJcuZPVZBCQOl3h1SPWLOm2cHKtd7CR21meYbE7OJ8FHL
 iwdoOTBQnfu5E3NuZP84XnYnpmNApo5NoCDCQdVr7b07LBnx60vvGg6MDprAT4iVk9wPY/IAs6T
 0z5g+10Dt+1JzxQ==
X-Developer-Key: i=rogerq@kernel.org; a=openpgp;
 fpr=412165D44C9F52780FAB1058D25A6BD3BE763093

The only difference between am65_cpsw_nuss_tx_compl_packets_2g() and
am65_cpsw_nuss_tx_compl_packets() is the usage of spin_lock() and
netdev_tx_completed_queue() + am65_cpsw_nuss_tx_wake at every packet
in the latter.

Insted of having 2 separate functions for TX completion, merge them
into one. This will reduce code duplication and make maintenance easier.

Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
 drivers/net/ethernet/ti/am65-cpsw-nuss.c | 98 ++++++++------------------------
 1 file changed, 25 insertions(+), 73 deletions(-)

diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
index a2b6a30918f6..75b402132e3f 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
@@ -1502,6 +1502,7 @@ static void am65_cpsw_nuss_tx_wake(struct am65_cpsw_tx_chn *tx_chn, struct net_d
 static int am65_cpsw_nuss_tx_compl_packets(struct am65_cpsw_common *common,
 					   int chn, unsigned int budget, bool *tdown)
 {
+	bool single_port = AM65_CPSW_IS_CPSW2G(common);
 	enum am65_cpsw_tx_buf_type buf_type;
 	struct device *dev = common->dev;
 	struct am65_cpsw_tx_chn *tx_chn;
@@ -1509,6 +1510,7 @@ static int am65_cpsw_nuss_tx_compl_packets(struct am65_cpsw_common *common,
 	unsigned int total_bytes = 0;
 	struct net_device *ndev;
 	struct xdp_frame *xdpf;
+	unsigned int pkt_len;
 	struct sk_buff *skb;
 	dma_addr_t desc_dma;
 	int res, num_tx = 0;
@@ -1516,9 +1518,12 @@ static int am65_cpsw_nuss_tx_compl_packets(struct am65_cpsw_common *common,
 	tx_chn = &common->tx_chns[chn];
 
 	while (true) {
-		spin_lock(&tx_chn->lock);
+		if (!single_port)
+			spin_lock(&tx_chn->lock);
 		res = k3_udma_glue_pop_tx_chn(tx_chn->tx_chn, &desc_dma);
-		spin_unlock(&tx_chn->lock);
+		if (!single_port)
+			spin_unlock(&tx_chn->lock);
+
 		if (res == -ENODATA)
 			break;
 
@@ -1533,23 +1538,35 @@ static int am65_cpsw_nuss_tx_compl_packets(struct am65_cpsw_common *common,
 		if (buf_type == AM65_CPSW_TX_BUF_TYPE_SKB) {
 			skb = am65_cpsw_nuss_tx_compl_packet_skb(tx_chn, desc_dma);
 			ndev = skb->dev;
-			total_bytes = skb->len;
+			pkt_len = skb->len;
 			napi_consume_skb(skb, budget);
 		} else {
 			xdpf = am65_cpsw_nuss_tx_compl_packet_xdp(common, tx_chn,
 								  desc_dma, &ndev);
-			total_bytes = xdpf->len;
+			pkt_len = xdpf->len;
 			if (buf_type == AM65_CPSW_TX_BUF_TYPE_XDP_TX)
 				xdp_return_frame_rx_napi(xdpf);
 			else
 				xdp_return_frame(xdpf);
 		}
+
+		total_bytes += pkt_len;
 		num_tx++;
 
-		netif_txq = netdev_get_tx_queue(ndev, chn);
+		if (!single_port) {
+			/* as packets from multi ports can be interleaved
+			 * on the same channel, we have to figure out the
+			 * port/queue at every packet and report it/wake queue.
+			 */
+			netif_txq = netdev_get_tx_queue(ndev, chn);
+			netdev_tx_completed_queue(netif_txq, 1, pkt_len);
+			am65_cpsw_nuss_tx_wake(tx_chn, ndev, netif_txq);
+		}
+	}
 
+	if (single_port) {
+		netif_txq = netdev_get_tx_queue(ndev, chn);
 		netdev_tx_completed_queue(netif_txq, num_tx, total_bytes);
-
 		am65_cpsw_nuss_tx_wake(tx_chn, ndev, netif_txq);
 	}
 
@@ -1558,66 +1575,6 @@ static int am65_cpsw_nuss_tx_compl_packets(struct am65_cpsw_common *common,
 	return num_tx;
 }
 
-static int am65_cpsw_nuss_tx_compl_packets_2g(struct am65_cpsw_common *common,
-					      int chn, unsigned int budget, bool *tdown)
-{
-	enum am65_cpsw_tx_buf_type buf_type;
-	struct device *dev = common->dev;
-	struct am65_cpsw_tx_chn *tx_chn;
-	struct netdev_queue *netif_txq;
-	unsigned int total_bytes = 0;
-	struct net_device *ndev;
-	struct xdp_frame *xdpf;
-	struct sk_buff *skb;
-	dma_addr_t desc_dma;
-	int res, num_tx = 0;
-
-	tx_chn = &common->tx_chns[chn];
-
-	while (true) {
-		res = k3_udma_glue_pop_tx_chn(tx_chn->tx_chn, &desc_dma);
-		if (res == -ENODATA)
-			break;
-
-		if (cppi5_desc_is_tdcm(desc_dma)) {
-			if (atomic_dec_and_test(&common->tdown_cnt))
-				complete(&common->tdown_complete);
-			*tdown = true;
-			break;
-		}
-
-		buf_type = am65_cpsw_nuss_buf_type(tx_chn, desc_dma);
-		if (buf_type == AM65_CPSW_TX_BUF_TYPE_SKB) {
-			skb = am65_cpsw_nuss_tx_compl_packet_skb(tx_chn, desc_dma);
-			ndev = skb->dev;
-			total_bytes += skb->len;
-			napi_consume_skb(skb, budget);
-		} else {
-			xdpf = am65_cpsw_nuss_tx_compl_packet_xdp(common, tx_chn,
-								  desc_dma, &ndev);
-			total_bytes += xdpf->len;
-			if (buf_type == AM65_CPSW_TX_BUF_TYPE_XDP_TX)
-				xdp_return_frame_rx_napi(xdpf);
-			else
-				xdp_return_frame(xdpf);
-		}
-		num_tx++;
-	}
-
-	if (!num_tx)
-		return 0;
-
-	netif_txq = netdev_get_tx_queue(ndev, chn);
-
-	netdev_tx_completed_queue(netif_txq, num_tx, total_bytes);
-
-	am65_cpsw_nuss_tx_wake(tx_chn, ndev, netif_txq);
-
-	dev_dbg(dev, "%s:%u pkt:%d\n", __func__, chn, num_tx);
-
-	return num_tx;
-}
-
 static enum hrtimer_restart am65_cpsw_nuss_tx_timer_callback(struct hrtimer *timer)
 {
 	struct am65_cpsw_tx_chn *tx_chns =
@@ -1633,13 +1590,8 @@ static int am65_cpsw_nuss_tx_poll(struct napi_struct *napi_tx, int budget)
 	bool tdown = false;
 	int num_tx;
 
-	if (AM65_CPSW_IS_CPSW2G(tx_chn->common))
-		num_tx = am65_cpsw_nuss_tx_compl_packets_2g(tx_chn->common, tx_chn->id,
-							    budget, &tdown);
-	else
-		num_tx = am65_cpsw_nuss_tx_compl_packets(tx_chn->common,
-							 tx_chn->id, budget, &tdown);
-
+	num_tx = am65_cpsw_nuss_tx_compl_packets(tx_chn->common,
+						 tx_chn->id, budget, &tdown);
 	if (num_tx >= budget)
 		return budget;
 

-- 
2.34.1


