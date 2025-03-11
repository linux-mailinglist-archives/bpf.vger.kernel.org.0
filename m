Return-Path: <bpf+bounces-53813-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 36CC1A5C0A4
	for <lists+bpf@lfdr.de>; Tue, 11 Mar 2025 13:21:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 728E87A95CA
	for <lists+bpf@lfdr.de>; Tue, 11 Mar 2025 12:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DC19258CE4;
	Tue, 11 Mar 2025 12:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eGYIcZt+"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60F4258CD2;
	Tue, 11 Mar 2025 12:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741695546; cv=none; b=OW14eJEVP+W2XxJ+5GHndxRoqxfOLUxLIlsr6mc9Q5ppnjNQfgjifZq9BPUlcMmNK/6sAmRt6BXx7a4AR9re/kxZy4bFZJAj0SubCmIRFoIRdMl/sXNG1hTlxAa50MjHd3p33xXDOXlPhHqOVk5DLdfSZRiMC89choTdn8PHjlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741695546; c=relaxed/simple;
	bh=WlTKQ3kcPFy8Hxds+Qy4aCVKV8kY2r+qZ2PUzA/IBug=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M5Mmv2R0fEoGt+A5qS/7sXTQrvKJSqje4ZGSiWOjfUsSgfl4l5vAS+jhYwb3Cj2KZRKOHCAFE58VJzWYnJQLMiFmPFDym6oWYfmoiSlO76Gs5mT7rJMFne5vWZ16Tk8pg0XJqAJFBARJXYEl3rSTzoUHECsKhawnn1JVRC/vTe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eGYIcZt+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD207C4CEE9;
	Tue, 11 Mar 2025 12:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741695545;
	bh=WlTKQ3kcPFy8Hxds+Qy4aCVKV8kY2r+qZ2PUzA/IBug=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=eGYIcZt+Un/GTINujdFJtIr0Mdj8NtySDL9FVsZAqLLOXDruVRrxBRsdKxYb/mycm
	 W9v1AbhrCHepRf0w4reU64wK2RSCX7G/nWHeuGxYpbRr2ud4gyTUCEStQnfu+vI806
	 VU8YGqYc3tlITLzZdAs9Sc4YyjqPQCAZPssUEV93gUyVtfC8oLS+RFT8EY7Ox+ofHD
	 rn1gz07XdDV/dj31vYJc4Y3AGFBgCstiDp1oQKwIkO2Z2ytKAg8lNuGIcbUuz0p6QA
	 uXFwAYz29Qd/wPW/6GDhjmIRrWxxE3yJ3f2CgNERitHfBJI8GH1daWFLTNZLadrx7v
	 gZIbiwCDg8rhQ==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Tue, 11 Mar 2025 13:18:35 +0100
Subject: [PATCH net-next 3/7] net: netsec: Add metadata support for xdp
 mode
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250311-mvneta-xdp-meta-v1-3-36cf1c99790e@kernel.org>
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

Set metadata size building the skb from xdp_buff in netsec driver

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/socionext/netsec.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/socionext/netsec.c b/drivers/net/ethernet/socionext/netsec.c
index dc99821c6226fbaece65c8ade23899f610b44a9a..ee890de69ffe795dbdcc5331e36be86769f0d9a6 100644
--- a/drivers/net/ethernet/socionext/netsec.c
+++ b/drivers/net/ethernet/socionext/netsec.c
@@ -970,7 +970,7 @@ static int netsec_process_rx(struct netsec_priv *priv, int budget)
 		struct netsec_de *de = dring->vaddr + (DESC_SZ * idx);
 		struct netsec_desc *desc = &dring->desc[idx];
 		struct page *page = virt_to_page(desc->addr);
-		u32 xdp_result = NETSEC_XDP_PASS;
+		u32 metasize, xdp_result = NETSEC_XDP_PASS;
 		struct sk_buff *skb = NULL;
 		u16 pkt_len, desc_len;
 		dma_addr_t dma_handle;
@@ -1019,7 +1019,7 @@ static int netsec_process_rx(struct netsec_priv *priv, int budget)
 		prefetch(desc->addr);
 
 		xdp_prepare_buff(&xdp, desc->addr, NETSEC_RXBUF_HEADROOM,
-				 pkt_len, false);
+				 pkt_len, true);
 
 		if (xdp_prog) {
 			xdp_result = netsec_run_xdp(priv, xdp_prog, &xdp);
@@ -1048,6 +1048,9 @@ static int netsec_process_rx(struct netsec_priv *priv, int budget)
 
 		skb_reserve(skb, xdp.data - xdp.data_hard_start);
 		skb_put(skb, xdp.data_end - xdp.data);
+		metasize = xdp.data - xdp.data_meta;
+		if (metasize)
+			skb_metadata_set(skb, metasize);
 		skb->protocol = eth_type_trans(skb, priv->ndev);
 
 		if (priv->rx_cksum_offload_flag &&

-- 
2.48.1


