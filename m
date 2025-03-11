Return-Path: <bpf+bounces-53817-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26155A5C0C3
	for <lists+bpf@lfdr.de>; Tue, 11 Mar 2025 13:23:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2ADD83B4D99
	for <lists+bpf@lfdr.de>; Tue, 11 Mar 2025 12:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82EE525B68E;
	Tue, 11 Mar 2025 12:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eVaZnxYr"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1C325A337;
	Tue, 11 Mar 2025 12:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741695558; cv=none; b=GaxdlodhLspRbMKuRlAbNTHUe2yQvamDHhWUP/qVkZcXuqZnJfjOiZ79OYkDnQOLng8+D8F4lqgpsS2vCF/qXvBVqzqBy5KpgVYIlmXy+NqpvtsviavfLgRvZXLukpGuJmG566gyzEbxRw2x5s8HBfteRt7t74aJjRztTk5n97A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741695558; c=relaxed/simple;
	bh=MLsMpE992zK7c/rp7wDJ8MLFrQZSgP8o8puAp87Eh7g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qXhtuVU2L5Mr3KE9mBCCJ2/MAOvYLmbPic4j6Pkqujn9zQQyYIfiB/cw+yhvybKP7qOfN9nPVg+XAjcnAWMBYW93Q/B1j1lATlWlzCa4wEZk21zH2652XgM/J26VxmWoYrJTnZ00L6c294SXNECUj5hsw5kJc7ykT4C6NaGFovo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eVaZnxYr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7E9AC4CEE9;
	Tue, 11 Mar 2025 12:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741695557;
	bh=MLsMpE992zK7c/rp7wDJ8MLFrQZSgP8o8puAp87Eh7g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=eVaZnxYrJmme1pRqmXuM0b7KlF/OsCyV+/1WVsamjyn0u1n98t+jSvcvDwE2PHdXo
	 PeVg0AA7+PE2eWEIBt7YlT6EaBDzyHSwJX4/sJOX7We3veteDkIGBpYL+lfkidUtm7
	 6yxYSzKnThSg1nLR9QIZ8A3+r1GinXUhXsRUfZW67Ro29egFW2uB04XOYrnwUHmmoJ
	 EI5iTq4Cyuk7wnoqTohDTwPaZdCbXNPmrLirmjt+s9OZ80yiPtugXvanuD964AXVE8
	 gutE3VOjt2KYzmtgfgaW6TgR5btcKlKKiX+MGgjailwJ855zg68zCeZI0IPtYMKiWn
	 j8uhqOxX7IfWQ==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Tue, 11 Mar 2025 13:18:39 +0100
Subject: [PATCH net-next 7/7] net: ti: cpsw: Add metadata support for xdp
 mode
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250311-mvneta-xdp-meta-v1-7-36cf1c99790e@kernel.org>
References: <20250311-mvneta-xdp-meta-v1-0-36cf1c99790e@kernel.org>
In-Reply-To: <20250311-mvneta-xdp-meta-v1-0-36cf1c99790e@kernel.org>
To: Marcin Wojtas <marcin.s.wojtas@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>, 
 Sunil Goutham <sgoutham@marvell.com>, Geetha sowjanya <gakula@marvell.com>, 
 Subbaraya Sundeep <sbhatta@marvell.com>, hariprasad <hkelam@marvell.com>, 
 Bharat Bhushan <bbhushan2@marvell.com>, Felix Fietkau <nbd@nbd.name>, 
 Sean Wang <sean.wang@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 "K. Y. Srinivasan" <kys@microsoft.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, Siddharth Vadapalli <s-vadapalli@ti.com>, 
 Roger Quadros <rogerq@kernel.org>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 linux-hyperv@vger.kernel.org, linux-omap@vger.kernel.org, 
 Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2

Set metadata size building the skb from xdp_buff in cpsw/cpsw_new
drivers

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/ti/cpsw.c     | 6 +++++-
 drivers/net/ethernet/ti/cpsw_new.c | 6 +++++-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
index 0cb6fa6e5b7d4fb9703633f0d67a7e95e6e7d8aa..a984b7d84e5e5917b83547c862924ccd30d83601 100644
--- a/drivers/net/ethernet/ti/cpsw.c
+++ b/drivers/net/ethernet/ti/cpsw.c
@@ -351,6 +351,7 @@ static void cpsw_rx_handler(void *token, int len, int status)
 	int			ret = 0, port, ch = xmeta->ch;
 	int			headroom = CPSW_HEADROOM_NA;
 	struct net_device	*ndev = xmeta->ndev;
+	u32			metasize = 0;
 	struct cpsw_priv	*priv;
 	struct page_pool	*pool;
 	struct sk_buff		*skb;
@@ -400,7 +401,7 @@ static void cpsw_rx_handler(void *token, int len, int status)
 			size -= CPSW_RX_VLAN_ENCAP_HDR_SIZE;
 		}
 
-		xdp_prepare_buff(&xdp, pa, headroom, size, false);
+		xdp_prepare_buff(&xdp, pa, headroom, size, true);
 
 		port = priv->emac_port + cpsw->data.dual_emac;
 		ret = cpsw_run_xdp(priv, ch, &xdp, page, port, &len);
@@ -408,6 +409,7 @@ static void cpsw_rx_handler(void *token, int len, int status)
 			goto requeue;
 
 		headroom = xdp.data - xdp.data_hard_start;
+		metasize = xdp.data - xdp.data_meta;
 
 		/* XDP prog can modify vlan tag, so can't use encap header */
 		status &= ~CPDMA_RX_VLAN_ENCAP;
@@ -423,6 +425,8 @@ static void cpsw_rx_handler(void *token, int len, int status)
 
 	skb_reserve(skb, headroom);
 	skb_put(skb, len);
+	if (metasize)
+		skb_metadata_set(skb, metasize);
 	skb->dev = ndev;
 	if (status & CPDMA_RX_VLAN_ENCAP)
 		cpsw_rx_vlan_encap(skb);
diff --git a/drivers/net/ethernet/ti/cpsw_new.c b/drivers/net/ethernet/ti/cpsw_new.c
index 3da1c131335df1ff79b32ce0e3ea5200a2e53f4b..5b5b52e4e7a757a14965fe6df41935aed547111f 100644
--- a/drivers/net/ethernet/ti/cpsw_new.c
+++ b/drivers/net/ethernet/ti/cpsw_new.c
@@ -293,6 +293,7 @@ static void cpsw_rx_handler(void *token, int len, int status)
 	struct page_pool *pool;
 	struct sk_buff *skb;
 	struct xdp_buff xdp;
+	u32 metasize = 0;
 	int ret = 0;
 	dma_addr_t dma;
 
@@ -345,13 +346,14 @@ static void cpsw_rx_handler(void *token, int len, int status)
 			size -= CPSW_RX_VLAN_ENCAP_HDR_SIZE;
 		}
 
-		xdp_prepare_buff(&xdp, pa, headroom, size, false);
+		xdp_prepare_buff(&xdp, pa, headroom, size, true);
 
 		ret = cpsw_run_xdp(priv, ch, &xdp, page, priv->emac_port, &len);
 		if (ret != CPSW_XDP_PASS)
 			goto requeue;
 
 		headroom = xdp.data - xdp.data_hard_start;
+		metasize = xdp.data - xdp.data_meta;
 
 		/* XDP prog can modify vlan tag, so can't use encap header */
 		status &= ~CPDMA_RX_VLAN_ENCAP;
@@ -368,6 +370,8 @@ static void cpsw_rx_handler(void *token, int len, int status)
 	skb->offload_fwd_mark = priv->offload_fwd_mark;
 	skb_reserve(skb, headroom);
 	skb_put(skb, len);
+	if (metasize)
+		skb_metadata_set(skb, metasize);
 	skb->dev = ndev;
 	if (status & CPDMA_RX_VLAN_ENCAP)
 		cpsw_rx_vlan_encap(skb);

-- 
2.48.1


