Return-Path: <bpf+bounces-50989-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 303B5A2F048
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 15:52:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 028AD18884AA
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 14:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55961236A7C;
	Mon, 10 Feb 2025 14:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ekKWUl7h"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD430230987;
	Mon, 10 Feb 2025 14:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739199147; cv=none; b=EussdtS0klIiznlxoNuKLW4kvznUfrvA3EIMAWGyLC62w0G/qo/Lj9UXGMhBe+Qwv3Sc+AIOknS/ppdg/+05ppo8Z5upNeEzCVh/wXwVytST4rACqKGS8gAvF61g4rXm35mskR+myTfDrFBgqr07POefOz2u9Bjb6GEf2mNFzhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739199147; c=relaxed/simple;
	bh=P2BvZfapl8SmRLSM8MJDVRi7Xewr105bmnDY2wj9fKY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U6J/Np4mUltquWfPuMgGIxqSPQyOj5vaHRIro/rssfQC9swdEutodh5I2z88/DrqIy+E3U1UJcI/lOlrVeDYE+rKF5DF33e6I+jIW7pkqWnHeHkNpaR/8Vfjo4+uba9MSb5tqwfoI7ATaGqxZ/iG/lDYYerbCuGz2jHZ0NCa9UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ekKWUl7h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77B60C4CED1;
	Mon, 10 Feb 2025 14:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739199147;
	bh=P2BvZfapl8SmRLSM8MJDVRi7Xewr105bmnDY2wj9fKY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ekKWUl7hKagb5yzfZh7Z8xq78ero9ZoFnrnQu2Kh7ZGBlj0kuT4fQVCoTLuasvzEy
	 4+uszB2XjnXDGIMdOqVzhrzEHQwtzOJ5nxfu3FT86h1QsWR3mifsMgFSS4zqrhuMgU
	 qZe16vwl/GXqNoAVM75FdsHRaMSYeVv7ibl+yBeY+yMNUpP/FVlpAkIsZEdkEwm782
	 fFn9FzBmm0446RgoMMo4Fv4YhTHVtSo4yAK+myw2nsSe3b7rUvdznCqEt+ccj+intz
	 ZGy9Vus+w1KfFnFR5Btli9EoSJWnz0HiQK/QHlTXg4o3/dCr1eN4lJM+GvcAV4JWYO
	 MS9ToUA0IEtGw==
From: Roger Quadros <rogerq@kernel.org>
Date: Mon, 10 Feb 2025 16:52:15 +0200
Subject: [PATCH net 1/3] net: ethernet: ti: am65-cpsw: fix memleak in
 certain XDP cases
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250210-am65-cpsw-xdp-fixes-v1-1-ec6b1f7f1aca@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2991; i=rogerq@kernel.org;
 h=from:subject:message-id; bh=P2BvZfapl8SmRLSM8MJDVRi7Xewr105bmnDY2wj9fKY=;
 b=owEBbQKS/ZANAwAIAdJaa9O+djCTAcsmYgBnqhKizQ8izCA0GIpx7TxLLwJmjawOHkmFQ8EJA
 n+3TDc+tXaJAjMEAAEIAB0WIQRBIWXUTJ9SeA+rEFjSWmvTvnYwkwUCZ6oSogAKCRDSWmvTvnYw
 kybpD/9e7yy9viq0JZrLr/Rw/n7xLj+mV6YfSvh2rJvCIKubZ4dNl9Ng5/r3OQ9o0fNGrbWsF/o
 yfRa4Wx6jtxEjq/BO6zvepjUzd7eVPGi7uY/k24LzlqMtMJHJ48B17JaIwbXGOruPFTeubp1FoM
 Bocpyh3KqL4rgYLq0TAJ0Xo8uTbu55GREpgIfTrVvc16JXv1Itg09gIAjFQL6dMT5MBaxDKwQFG
 mVOcSOsUI4Ql585QVRCWdV8AHRJ3gGxplmL1a/J+d7qvtQgXbyzQNmNMBMXXomOtO8YIWINQ0h0
 fxj6OBh01qi0AzDmXwJAtcec2BxpmFVG5q1jfEQZ8NiQON8cdNSW5Gq/+XRdHWdwGjM2m/H+OLD
 /Wv7rKHdZTh0kgW1hNotDjERrx+qyyr62ciO5W1tkfb9qLTnrx45H+kZV2IUaIP7ynHIxCvZaku
 gzcJ+MoJnFX4Ys8TwtKS7xZLhzqlUwz3Zl72070tc4NjOKIxFaccx8jWKhM2emW+RB15p43xxYQ
 G3eqekjTaH6zshyFiF4+Nh5ckIQNb+kYOoT/QsjAqAvgQiWRs7fJ/0I07Fc01XY/EOL0i8jHN+i
 8KYLWd62PDVVUn4JJF0AUxtBKA9dTrRD4YMYXzjrw39Vm5ZJw/Qz6VDLRWhgydwdGNMwUeKQZGE
 V0wMW7Iy90CKW7w==
X-Developer-Key: i=rogerq@kernel.org; a=openpgp;
 fpr=412165D44C9F52780FAB1058D25A6BD3BE763093

If the XDP program doesn't result in XDP_PASS then we leak the
memory allocated by am65_cpsw_build_skb().

It is pointless to allocate SKB memory before running the XDP
program as we would be wasting CPU cycles for cases other than XDP_PASS.
Move the SKB allocation after evaluating the XDP program result.

This fixes the memleak. A performance boost is seen for XDP_DROP test.

XDP_DROP test:
Before: 460256 rx/s                  0 err/s
After:  784130 rx/s                  0 err/s

Fixes: 8acacc40f733 ("net: ethernet: ti: am65-cpsw: Add minimal XDP support")
Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
 drivers/net/ethernet/ti/am65-cpsw-nuss.c | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
index b663271e79f7..e26c6dc02648 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
@@ -842,7 +842,8 @@ static void am65_cpsw_nuss_tx_cleanup(void *data, dma_addr_t desc_dma)
 
 static struct sk_buff *am65_cpsw_build_skb(void *page_addr,
 					   struct net_device *ndev,
-					   unsigned int len)
+					   unsigned int len,
+					   unsigned int headroom)
 {
 	struct sk_buff *skb;
 
@@ -852,7 +853,7 @@ static struct sk_buff *am65_cpsw_build_skb(void *page_addr,
 	if (unlikely(!skb))
 		return NULL;
 
-	skb_reserve(skb, AM65_CPSW_HEADROOM);
+	skb_reserve(skb, headroom);
 	skb->dev = ndev;
 
 	return skb;
@@ -1277,7 +1278,7 @@ static int am65_cpsw_nuss_rx_packets(struct am65_cpsw_rx_flow *flow,
 	u32 flow_idx = flow->id;
 	struct sk_buff *skb;
 	struct xdp_buff	xdp;
-	int headroom, ret;
+	int headroom = AM65_CPSW_HEADROOM, ret;
 	void *page_addr;
 	u32 *psdata;
 
@@ -1315,16 +1316,8 @@ static int am65_cpsw_nuss_rx_packets(struct am65_cpsw_rx_flow *flow,
 	dev_dbg(dev, "%s rx csum_info:%#x\n", __func__, csum_info);
 
 	dma_unmap_single(rx_chn->dma_dev, buf_dma, buf_dma_len, DMA_FROM_DEVICE);
-
 	k3_cppi_desc_pool_free(rx_chn->desc_pool, desc_rx);
 
-	skb = am65_cpsw_build_skb(page_addr, ndev,
-				  AM65_CPSW_MAX_PACKET_SIZE);
-	if (unlikely(!skb)) {
-		new_page = page;
-		goto requeue;
-	}
-
 	if (port->xdp_prog) {
 		xdp_init_buff(&xdp, PAGE_SIZE, &port->xdp_rxq[flow->id]);
 		xdp_prepare_buff(&xdp, page_addr, AM65_CPSW_HEADROOM,
@@ -1334,9 +1327,14 @@ static int am65_cpsw_nuss_rx_packets(struct am65_cpsw_rx_flow *flow,
 		if (*xdp_state != AM65_CPSW_XDP_PASS)
 			goto allocate;
 
-		/* Compute additional headroom to be reserved */
-		headroom = (xdp.data - xdp.data_hard_start) - skb_headroom(skb);
-		skb_reserve(skb, headroom);
+		headroom = xdp.data - xdp.data_hard_start;
+	}
+
+	skb = am65_cpsw_build_skb(page_addr, ndev,
+				  AM65_CPSW_MAX_PACKET_SIZE, headroom);
+	if (unlikely(!skb)) {
+		new_page = page;
+		goto requeue;
 	}
 
 	ndev_priv = netdev_priv(ndev);

-- 
2.34.1


