Return-Path: <bpf+bounces-51722-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E647A37C48
	for <lists+bpf@lfdr.de>; Mon, 17 Feb 2025 08:32:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EAE23B0253
	for <lists+bpf@lfdr.de>; Mon, 17 Feb 2025 07:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBFCE1A2632;
	Mon, 17 Feb 2025 07:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="udgK2+ZW"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C2461990D8;
	Mon, 17 Feb 2025 07:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739777522; cv=none; b=e19UBJeW24Tl1Et8TyppqAKlF5IIl022yH5njVYMaf63/bCmvURD1lplJUvTVlSfLcKedWLxaN+Rn43n2EwmOM90ZtAZ8pwVwc8slQBnBd5C7Au6ydyFtBpALlg0QXhUjjwXXQOjS0dx2KIAH19ULlKS5MR7rEiWROp1Co9g4mE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739777522; c=relaxed/simple;
	bh=3SDGakUGZ6fH02wYgLScNfAO5y9mbjIYzLs/10eaC6E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eBu6/J5SxqOVei5lwNRcrV8AGqeRflGqNvhqLC5iGXSo5oYeNajiYUlVNe0GzVyozdEoFPeFe2lRxVjkjLr5/J5w4MrljLdF21vez1H69iuSv0xzjG56DQsbPfw4qP5mLWUPKbjGaax378462BUZsP4ZucaPfSg+Ff8Iinm8YlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=udgK2+ZW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C095C4CED1;
	Mon, 17 Feb 2025 07:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739777521;
	bh=3SDGakUGZ6fH02wYgLScNfAO5y9mbjIYzLs/10eaC6E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=udgK2+ZWS6iOGEXBVVYLoT4jAdlCKnUc5VTAnaC9G1b5hsodDSnEdi2HRY4zuEiEb
	 DmwjGhezVBxoRZAw21v9XDRgh32oPm7nyHshUWCUTYvHmpXMF+W5+oaVFZGgQl8cDj
	 eMAFEYDLhyAsydWyWgYCB2OSCcAgXjb+RxhColRgU33LOQ0mQIz3qw9zqhPmJx1OX/
	 EbhYRaiIoTC3jST9Awr9fnxDc21g1FTO5EII1H8aOchr8NfNckUwKwBen1wTx+Q+FU
	 tHqYX5wiyHE/+E7Ukz1OEaeBhil+SMfNqLRMAOes52LKNZg4B0syA6UKFxMpNaGPv9
	 3jrVlrPOCYizQ==
From: Roger Quadros <rogerq@kernel.org>
Date: Mon, 17 Feb 2025 09:31:47 +0200
Subject: [PATCH net-next 2/5] net: ethernet: ti: am65_cpsw: remove cpu
 argument am65_cpsw_run_xdp
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250217-am65-cpsw-zc-prep-v1-2-ce450a62d64f@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2607; i=rogerq@kernel.org;
 h=from:subject:message-id; bh=3SDGakUGZ6fH02wYgLScNfAO5y9mbjIYzLs/10eaC6E=;
 b=owEBbQKS/ZANAwAIAdJaa9O+djCTAcsmYgBnsuXldsET5Jd3SJmS+a7TGtrClz8LhI4PB7dWG
 MI2llQDacGJAjMEAAEIAB0WIQRBIWXUTJ9SeA+rEFjSWmvTvnYwkwUCZ7Ll5QAKCRDSWmvTvnYw
 kyypD/4iJumquHdNsVPD4xEJh8CKpOT6jFq1hoFMol4qNGyJbLYT2cx6qyfYaRRp8R9h3CPLqPZ
 3/3gt55HAxqFG/pioRg8Nqd89I4BC+1DdSqktYxp8Y1Wj0k3FCy0EaZJ89hW2aU2+0onI2ikSNQ
 KLAoFE7uiumB4WEtB+N94UO3HuFVDOiT4wH9uml9/gNY83gxrAe9FIJfbsPv7nyafbD76cc/vpf
 Er6hGcGoofov7A1/jO/lqniaNCkmRFA050XMTIfmfNW+vniOS68uebg/unysOQhIDFpLlN5ZgJn
 06pc4oK61wIGYdOiGMI4zl8EtfzGiSDN8rzLIC3EVTkZHYgN120KgL/lMayfmEgBV3hWL93KC/X
 sKMEmA/iw0cUFVnsSLvvxiG3BgH0183MYmp1Z6fznk+vDLZQf9cWlwTDcIaPwM1DqNNiNQ9wqyn
 SISXx5Qy2YsVYY0lkOW1Erxd+ZiON0fcgE1hAci3pcH+fskon+sIFD3IeAltFX06lG3ys2m9Uas
 J3wSP8/YnFFyOxnEhduZW7lEVwLnlgHLybgI1uxTcJ0r6lZo++rebIyxkZAFThQDUoz50avIVMM
 c98eM6DjacRGDblST+oUOK/ITwnmu18pe+uwWRNT3Qrh6TU8n0HqyfFDzfpjOTQZ41aWjmDHuBI
 HosU/dmOHSahAYg==
X-Developer-Key: i=rogerq@kernel.org; a=openpgp;
 fpr=412165D44C9F52780FAB1058D25A6BD3BE763093

am65_cpsw_run_xdp() can figure out the cpu id itself.
No need to pass it around 2 functions so drop it.

Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
 drivers/net/ethernet/ti/am65-cpsw-nuss.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
index 75b402132e3f..6bd4f526cb8e 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
@@ -1167,14 +1167,14 @@ static int am65_cpsw_xdp_tx_frame(struct net_device *ndev,
 
 static int am65_cpsw_run_xdp(struct am65_cpsw_rx_flow *flow,
 			     struct am65_cpsw_port *port,
-			     struct xdp_buff *xdp,
-			     int cpu, int *len)
+			     struct xdp_buff *xdp, int *len)
 {
 	struct am65_cpsw_common *common = flow->common;
 	struct net_device *ndev = port->ndev;
 	int ret = AM65_CPSW_XDP_CONSUMED;
 	struct am65_cpsw_tx_chn *tx_chn;
 	struct netdev_queue *netif_txq;
+	int cpu = smp_processor_id();
 	struct xdp_frame *xdpf;
 	struct bpf_prog *prog;
 	struct page *page;
@@ -1274,7 +1274,7 @@ static void am65_cpsw_nuss_rx_csum(struct sk_buff *skb, u32 csum_info)
 }
 
 static int am65_cpsw_nuss_rx_packets(struct am65_cpsw_rx_flow *flow,
-				     int cpu, int *xdp_state)
+				     int *xdp_state)
 {
 	struct am65_cpsw_rx_chn *rx_chn = &flow->common->rx_chns;
 	u32 buf_dma_len, pkt_len, port_id = 0, csum_info;
@@ -1334,8 +1334,7 @@ static int am65_cpsw_nuss_rx_packets(struct am65_cpsw_rx_flow *flow,
 		xdp_init_buff(&xdp, PAGE_SIZE, &port->xdp_rxq[flow->id]);
 		xdp_prepare_buff(&xdp, page_addr, AM65_CPSW_HEADROOM,
 				 pkt_len, false);
-		*xdp_state = am65_cpsw_run_xdp(flow, port, &xdp,
-					       cpu, &pkt_len);
+		*xdp_state = am65_cpsw_run_xdp(flow, port, &xdp, &pkt_len);
 		if (*xdp_state != AM65_CPSW_XDP_PASS)
 			goto allocate;
 
@@ -1399,7 +1398,6 @@ static int am65_cpsw_nuss_rx_poll(struct napi_struct *napi_rx, int budget)
 {
 	struct am65_cpsw_rx_flow *flow = am65_cpsw_napi_to_rx_flow(napi_rx);
 	struct am65_cpsw_common *common = flow->common;
-	int cpu = smp_processor_id();
 	int xdp_state_or = 0;
 	int cur_budget, ret;
 	int xdp_state;
@@ -1408,7 +1406,7 @@ static int am65_cpsw_nuss_rx_poll(struct napi_struct *napi_rx, int budget)
 	/* process only this flow */
 	cur_budget = budget;
 	while (cur_budget--) {
-		ret = am65_cpsw_nuss_rx_packets(flow, cpu, &xdp_state);
+		ret = am65_cpsw_nuss_rx_packets(flow, &xdp_state);
 		xdp_state_or |= xdp_state;
 		if (ret)
 			break;

-- 
2.34.1


