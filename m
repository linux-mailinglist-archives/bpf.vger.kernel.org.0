Return-Path: <bpf+bounces-50990-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECD7FA2F04C
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 15:53:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 616371888328
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 14:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AC8220487E;
	Mon, 10 Feb 2025 14:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RM59dYvI"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD6A204874;
	Mon, 10 Feb 2025 14:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739199152; cv=none; b=rreImj8JoBTmKCEDeldVTGrt4ZjJX/eqrUq/PTpuMOTeoJZHviLGhCzowPueK3GQ8HAXwjXmGHd7tPKvT1GEwSCASSiZa1/qfo/JjQAdbSBaqRlBKfG7IpL1JC5dWOa6MWFmvDalI9v1CLdttlfjdYZ9/gwEHnXpCe1Wkn0wPJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739199152; c=relaxed/simple;
	bh=lncTpqRYnczSkh5p/M+nCdG+y49YXkzek6zKzkRyYvI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pZHBEYb7GJfD6fhXtJea3+FTWfRGIYEAtjnqDcGjOfJ6DHSqTgUieEKz5fSK3c2OmU12uJomNo6Ijihdjm22qb171Uq/LtUARYpfE7e0XfOZGQa7HjXlarCogLcM9a7rYatgkv2Gifdfqvgb5p50pH1KGZwiYL6q1F/+H2ZSt3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RM59dYvI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B67FDC4CEDF;
	Mon, 10 Feb 2025 14:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739199151;
	bh=lncTpqRYnczSkh5p/M+nCdG+y49YXkzek6zKzkRyYvI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=RM59dYvIaqXJxUL+ip70YoOyaT1aZRc4WxkdrkI3Xv2Vsym4Qu/GzIkkV1gSxBBS+
	 MMp9m2Zbtr+uxZYu3uLKD2CINeQ/w98+vfgz3cgtGWrGMsC5RrKq89ot+VOWvMb0lC
	 oPEnc6lhe0cNZQv1ye+GGXfhYZWXMMGSAax3qAwOS8oBU1pUTY966KxeNM9w1TyDS2
	 yeUXot3yn2qSi3RUxKR8d9gFbjp0fkkd9R0hChCS4/kwtco64b+xFebNDmmfkM0IMR
	 YfonO2tOHlgzZdo8yc8sCsgYUsqyRueRa7VwZSRlpa29UJMy5CsRLvKoc5Sc29+w7L
	 bHViJg9LLz21g==
From: Roger Quadros <rogerq@kernel.org>
Date: Mon, 10 Feb 2025 16:52:16 +0200
Subject: [PATCH net 2/3] net: ethernet: ti: am65-cpsw: fix RX & TX
 statistics for XDP_TX case
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250210-am65-cpsw-xdp-fixes-v1-2-ec6b1f7f1aca@kernel.org>
References: <20250210-am65-cpsw-xdp-fixes-v1-0-ec6b1f7f1aca@kernel.org>
In-Reply-To: <20250210-am65-cpsw-xdp-fixes-v1-0-ec6b1f7f1aca@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Julien Panis <jpanis@baylibre.com>, Jacob Keller <jacob.e.keller@intel.com>
Cc: danishanwar@ti.com, s-vadapalli@ti.com, srk@ti.com, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 Roger Quadros <rogerq@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1990; i=rogerq@kernel.org;
 h=from:subject:message-id; bh=lncTpqRYnczSkh5p/M+nCdG+y49YXkzek6zKzkRyYvI=;
 b=owEBbQKS/ZANAwAIAdJaa9O+djCTAcsmYgBnqhKi4MYM1qAWQ/XNJhpMHhpMX/8HUSd1n1jKn
 ZGAkOTZkleJAjMEAAEIAB0WIQRBIWXUTJ9SeA+rEFjSWmvTvnYwkwUCZ6oSogAKCRDSWmvTvnYw
 k6TnD/9IaCfbKplT9k8Nm/4UtuCKaGAFBtKLfdgPjexNjUZBA9vvfR6X8DsLsCs3FqE6+vFV5VW
 1AbNNnRzAeI/JOf+d0FvJTzKuXF18sKTP8MuOwgWjuXYS+o1ct8BDD3Z2F7WUXRhpwPMTv4hj01
 a/tzI0w3ZOPzK6Z5YmnjP1urqPbup032Sng7geG+PdK9NjREX2YwHiTLfpxsBrwCTkNMt9j+MUu
 w2EuzZuKHVw8f6nQ0xw5Sl24guCeEneu8vQlC+EuyZ9ENAWgHI2rL2cJzoS4PyFlEul7CW8aUdc
 +rK5udQUy3zYWNqqcyjIxrF1jDwY/WDMHQuhMhUE5d+rqTbSys959wBgX59thA1iF+czlUl3Utt
 fteRXPkJgMjDdo9JO/z36/43Y/2gisVrNxOvW9IDKA1LzfcvsSwJ2jSrrxHB5SEQMLR8yFBjW1/
 eimiTkNBaloKBrpRsIm/nHm92t2LTXsiESchxTz/z3xrvIQX3x/jBLYvDpQLHJ2ENhN06wyyCQ5
 wE4nziW71Ha8xPOHNk85+iyui2fA58rh5viyw7uQ8pE1tZq1kryMTW/birNviUoOPnwiXJCMag6
 4nUX+/a/DGwuEl3WhW6U/ONil3lp7C/k/yXBco1MpxfNLBytIqRsfbnXeX8Kh8AoJTm4HnO9qSw
 KAHraiR/xuU2PFg==
X-Developer-Key: i=rogerq@kernel.org; a=openpgp;
 fpr=412165D44C9F52780FAB1058D25A6BD3BE763093

For successful XDP_TX and XDP_REDIRECT cases, the packet was received
successfully so update RX statistics. Use original received
packet length for that.

TX packets statistics are incremented on TX completion so don't
update it while TX queueing.

If xdp_convert_buff_to_frame() fails, increment tx_dropped.

Signed-off-by: Roger Quadros <rogerq@kernel.org>
Fixes: 8acacc40f733 ("net: ethernet: ti: am65-cpsw: Add minimal XDP support")
---
 drivers/net/ethernet/ti/am65-cpsw-nuss.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
index e26c6dc02648..bee2d66b9ccf 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
@@ -1170,9 +1170,11 @@ static int am65_cpsw_run_xdp(struct am65_cpsw_rx_flow *flow,
 	struct xdp_frame *xdpf;
 	struct bpf_prog *prog;
 	struct page *page;
+	int pkt_len;
 	u32 act;
 	int err;
 
+	pkt_len = *len;
 	prog = READ_ONCE(port->xdp_prog);
 	if (!prog)
 		return AM65_CPSW_XDP_PASS;
@@ -1190,8 +1192,10 @@ static int am65_cpsw_run_xdp(struct am65_cpsw_rx_flow *flow,
 		netif_txq = netdev_get_tx_queue(ndev, tx_chn->id);
 
 		xdpf = xdp_convert_buff_to_frame(xdp);
-		if (unlikely(!xdpf))
+		if (unlikely(!xdpf)) {
+			ndev->stats.tx_dropped++;
 			goto drop;
+		}
 
 		__netif_tx_lock(netif_txq, cpu);
 		err = am65_cpsw_xdp_tx_frame(ndev, tx_chn, xdpf,
@@ -1200,14 +1204,14 @@ static int am65_cpsw_run_xdp(struct am65_cpsw_rx_flow *flow,
 		if (err)
 			goto drop;
 
-		dev_sw_netstats_tx_add(ndev, 1, *len);
+		dev_sw_netstats_rx_add(ndev, pkt_len);
 		ret = AM65_CPSW_XDP_CONSUMED;
 		goto out;
 	case XDP_REDIRECT:
 		if (unlikely(xdp_do_redirect(ndev, xdp, prog)))
 			goto drop;
 
-		dev_sw_netstats_rx_add(ndev, *len);
+		dev_sw_netstats_rx_add(ndev, pkt_len);
 		ret = AM65_CPSW_XDP_REDIRECT;
 		goto out;
 	default:

-- 
2.34.1


