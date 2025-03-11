Return-Path: <bpf+bounces-53812-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C13B1A5C0D3
	for <lists+bpf@lfdr.de>; Tue, 11 Mar 2025 13:25:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A136177D78
	for <lists+bpf@lfdr.de>; Tue, 11 Mar 2025 12:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDED7258CC2;
	Tue, 11 Mar 2025 12:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kXzEDhTj"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47271256C6F;
	Tue, 11 Mar 2025 12:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741695543; cv=none; b=FhZoW9FoAG7G15iJezwdoIaCYRaB6ckLiSL+/i84Pyj5OJxBfux+dFPEtmhi1bvKtYUuarfYOtQA+F5Defc0Lc6mmqzOJKsv7KWdXw0T3FzS++ifOSEUL1NyjOTEgJ6l31yBRusHJsfw0f+v6gXweiT/EVNsRsB4WpV8QI8sj5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741695543; c=relaxed/simple;
	bh=rofRa6M2JYCQa/vkknLX651Kx/C8RY4aT4P7HmN2O0I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Aqc6h5W48OK3n0oMNKDRxJMfSwgjQIW8wFDIDyA1zchtzdv0krGXw3gMqjRo/o7rbW1SFr7Uo69v853womxrTZKTiquZjx2Dip3jOHCOT5LGc7WiOSpVvfXXMjtGiu3zZ9Rd98qB9wvZstIvKG6t+sTAY5sCXuNE3XSUQGrZau4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kXzEDhTj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 428A8C4CEE9;
	Tue, 11 Mar 2025 12:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741695542;
	bh=rofRa6M2JYCQa/vkknLX651Kx/C8RY4aT4P7HmN2O0I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=kXzEDhTjP7E8dqzsyfbjc1vt1qaqAsXnSn0DKgOEIB04xhK9/x4AHqXgX2/8+9p9G
	 jfG60a51j1kOaKXGAOdm2jw8s50z0i53ZtQv3pj327i7SILvsEXe7LS665TGpJkrqD
	 /me8bN+ZsBjiNn0+i5g0PdEQu9Z5kdizyhTdbFpMidWO4+866rM6MLWewlecNZ5X0c
	 K3K0Xc04YT29FV5zHX0xZ1deIFoFjvvN/at1codWjAtJWc/aZ14DT7pcGyQG67ytSW
	 EOnxG7cQKzq6kEKMyI5wZ2co50Rbr/5tvJqIDjTni7SsXTPADus7BQuahAbKLUa6v/
	 U79D+XOdSJ2Mw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Tue, 11 Mar 2025 13:18:34 +0100
Subject: [PATCH net-next 2/7] net: mvpp2: Add metadata support for xdp mode
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250311-mvneta-xdp-meta-v1-2-36cf1c99790e@kernel.org>
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

Set metadata size building the skb from xdp_buff in mvpp2 driver

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
index f166dc4e650372d66e248601a5c948819e1dcd79..54a235366a01bdba526a1956f27836bcdee210ae 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -3915,13 +3915,13 @@ static int mvpp2_rx(struct mvpp2_port *port, struct napi_struct *napi,
 
 	while (rx_done < rx_todo) {
 		struct mvpp2_rx_desc *rx_desc = mvpp2_rxq_next_desc_get(rxq);
+		u32 rx_status, timestamp, metasize = 0;
 		struct mvpp2_bm_pool *bm_pool;
 		struct page_pool *pp = NULL;
 		struct sk_buff *skb;
 		unsigned int frag_size;
 		dma_addr_t dma_addr;
 		phys_addr_t phys_addr;
-		u32 rx_status, timestamp;
 		int pool, rx_bytes, err, ret;
 		struct page *page;
 		void *data;
@@ -3983,7 +3983,7 @@ static int mvpp2_rx(struct mvpp2_port *port, struct napi_struct *napi,
 			xdp_init_buff(&xdp, PAGE_SIZE, xdp_rxq);
 			xdp_prepare_buff(&xdp, data,
 					 MVPP2_MH_SIZE + MVPP2_SKB_HEADROOM,
-					 rx_bytes, false);
+					 rx_bytes, true);
 
 			ret = mvpp2_run_xdp(port, xdp_prog, &xdp, pp, &ps);
 
@@ -3999,6 +3999,8 @@ static int mvpp2_rx(struct mvpp2_port *port, struct napi_struct *napi,
 				ps.rx_bytes += rx_bytes;
 				continue;
 			}
+
+			metasize = xdp.data - xdp.data_meta;
 		}
 
 		if (frag_size)
@@ -4038,6 +4040,8 @@ static int mvpp2_rx(struct mvpp2_port *port, struct napi_struct *napi,
 
 		skb_reserve(skb, MVPP2_MH_SIZE + MVPP2_SKB_HEADROOM);
 		skb_put(skb, rx_bytes);
+		if (metasize)
+			skb_metadata_set(skb, metasize);
 		skb->ip_summed = mvpp2_rx_csum(port, rx_status);
 		skb->protocol = eth_type_trans(skb, dev);
 

-- 
2.48.1


