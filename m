Return-Path: <bpf+bounces-38396-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D9569643DF
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 14:05:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F22F81F21566
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 12:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39F901AC42C;
	Thu, 29 Aug 2024 12:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="St+4Cc6v"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC2E1ABEC3;
	Thu, 29 Aug 2024 12:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724933033; cv=none; b=kqOWCQvfYuH0hgqxwKTRyA5z9Tb4FeT3atQGSPthuGMa9LIVoGWTfuIQcOtKyR9sWMmKBc6BvXxDb8cbs4f3NvZXJXjol0328W4B/dyY5TnrRffl6WfiH312pVqKSbY5uS/mm9SY+e7HGUFXvcVz6w6iuql+A88139Yl5lcUdt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724933033; c=relaxed/simple;
	bh=dOuHzNG0XJEDwPjcpbqy+p9jK8QPYMUAH4STnCVbKKs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nUWKi2fSzobSFBFEKBPOyIC2udcbkakNGgn69ui4Y9OBE7gD9lUnQmaZ9w139MSIf4QFvfsaO48vntxqypAJfg6Fp6tj1FpoWookCSrapBDah5pS7y8DrByEpXZ/JQJZmXLsBYj8a5IXz8booSnAyrach6yeLvLBh4MWnazjCe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=St+4Cc6v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52154C4CECA;
	Thu, 29 Aug 2024 12:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724933033;
	bh=dOuHzNG0XJEDwPjcpbqy+p9jK8QPYMUAH4STnCVbKKs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=St+4Cc6vLOF5wOhulxwlwALvCnP3BKvh4SNWEC7rLZRAl9Z8BPYLB1CSHkCuVfKJv
	 QZaCRTI9ah70Wx1+RRTFctfRkTYYzhvucgnaxfvNKRC2gycJevuBs5V7OB4v8O9tkj
	 3H+2lpHmRCZdv+rXkAKy29dS5VSzA1nTr93hl0x0lFqlXk39BK8WWESpzAkzWJ4Dof
	 dUMlGhqWtxZDRH8HPcNLDVUeAvbVmYajFjeuV06tyE6NpQ+ncgHfA0dGSBusJdgZNZ
	 WkYaTHdVzVpxmUxCXjkgRiAtfh1k1XPY745TWKqSvSnfr4BB+7IZRL3kzej56KouVN
	 kyJxrFmS5j1cg==
From: Roger Quadros <rogerq@kernel.org>
Date: Thu, 29 Aug 2024 15:03:21 +0300
Subject: [PATCH net 3/3] net: ethernet: ti: am65-cpsw: Fix RX statistics
 for XDP_TX and XDP_REDIRECT
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240829-am65-cpsw-xdp-v1-3-ff3c81054a5e@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2188; i=rogerq@kernel.org;
 h=from:subject:message-id; bh=dOuHzNG0XJEDwPjcpbqy+p9jK8QPYMUAH4STnCVbKKs=;
 b=owEBbQKS/ZANAwAIAdJaa9O+djCTAcsmYgBm0GOYnDkrJLqbi4vIFwnW8rFo8vIQx1fBibN/K
 ZpOCKxSF4iJAjMEAAEIAB0WIQRBIWXUTJ9SeA+rEFjSWmvTvnYwkwUCZtBjmAAKCRDSWmvTvnYw
 k0DaEADTAS1GImIarr3+LWXXZruTSBp7t0/Olxp5KKZuuFEnaL/QyOKyrtbG+laJ05YqXovzQqZ
 toAHNNXuQkzYrvpXEVz+5NkYB2Jmjsd5hLR8JxKZfgVkuZGUB59TLTSSvfnrGp0hH8698kbVcUB
 wYaIxozO9+OTNoIyMPR95rPQj0L0uVwntPYOPXYVpNoUoelFDnN66rlrCMPadEtoBKkNh7dDwKk
 yegwDEqnIGusZuNDy0bFHQaCEE1JGI5hoQGl0qfuRGi7KombOAG0Vwp4paQlByAY9WzvSUIO6ZY
 LWEQ9ZtCi0F8vs3NzbjulUFlQ6gxB8mTYJbHxSELLVpQQ6EEn2LM+pQDcZirq0GFplBjoBsAo9C
 jBpcLFXBS1+mOrcwJ1Cl00ygiCoLiFhypTbMCzdgURO5n2SbjK9Hft0ORyjb6fp8aZ2CY4TvHaU
 jrVkX+fCgUUtVPDhO7BXvKVNhU98U5l0KIFAhZNqh7aKaImfXlgvr7LXmruY5pR01yd7th5T+jf
 d2EecJ4EZ6sz0MEnULGd1/DSI7jisjS4gjEiEezU8nLoHAqsC/horrHPH4sdHypOzP8OsjZEjuG
 Ek5MDXZgpRqGnwPxEWRWwzz24/eFs9EI+RtyyQkQk5M3H32c33Tvim9RXqm6JG7307MjbD/37CY
 kW6NYDpM4iJN4fw==
X-Developer-Key: i=rogerq@kernel.org; a=openpgp;
 fpr=412165D44C9F52780FAB1058D25A6BD3BE763093

We are not using ndev->stats for rx_packets and rx_bytes anymore.
Instead, we use per CPU stats which are collated in
am65_cpsw_nuss_ndo_get_stats().

Fix RX statistics for XDP_TX and XDP_REDIRECT cases.

Fixes: 8acacc40f733 ("net: ethernet: ti: am65-cpsw: Add minimal XDP support")
Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
 drivers/net/ethernet/ti/am65-cpsw-nuss.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
index 03577a008df2..b06b8872b4eb 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
@@ -998,7 +998,9 @@ static int am65_cpsw_run_xdp(struct am65_cpsw_common *common,
 			     int desc_idx, int cpu, int *len)
 {
 	struct am65_cpsw_rx_chn *rx_chn = &common->rx_chns;
+	struct am65_cpsw_ndev_priv *ndev_priv;
 	struct net_device *ndev = port->ndev;
+	struct am65_cpsw_ndev_stats *stats;
 	int ret = AM65_CPSW_XDP_CONSUMED;
 	struct am65_cpsw_tx_chn *tx_chn;
 	struct netdev_queue *netif_txq;
@@ -1016,6 +1018,9 @@ static int am65_cpsw_run_xdp(struct am65_cpsw_common *common,
 	/* XDP prog might have changed packet data and boundaries */
 	*len = xdp->data_end - xdp->data;
 
+	ndev_priv = netdev_priv(ndev);
+	stats = this_cpu_ptr(ndev_priv->stats);
+
 	switch (act) {
 	case XDP_PASS:
 		ret = AM65_CPSW_XDP_PASS;
@@ -1035,16 +1040,20 @@ static int am65_cpsw_run_xdp(struct am65_cpsw_common *common,
 		if (err)
 			goto drop;
 
-		ndev->stats.rx_bytes += *len;
-		ndev->stats.rx_packets++;
+		u64_stats_update_begin(&stats->syncp);
+		stats->rx_bytes += *len;
+		stats->rx_packets++;
+		u64_stats_update_end(&stats->syncp);
 		ret = AM65_CPSW_XDP_CONSUMED;
 		goto out;
 	case XDP_REDIRECT:
 		if (unlikely(xdp_do_redirect(ndev, xdp, prog)))
 			goto drop;
 
-		ndev->stats.rx_bytes += *len;
-		ndev->stats.rx_packets++;
+		u64_stats_update_begin(&stats->syncp);
+		stats->rx_bytes += *len;
+		stats->rx_packets++;
+		u64_stats_update_end(&stats->syncp);
 		ret = AM65_CPSW_XDP_REDIRECT;
 		goto out;
 	default:

-- 
2.34.1


