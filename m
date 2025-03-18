Return-Path: <bpf+bounces-54305-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C092CA6730B
	for <lists+bpf@lfdr.de>; Tue, 18 Mar 2025 12:47:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9A5542140D
	for <lists+bpf@lfdr.de>; Tue, 18 Mar 2025 11:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E059B20C034;
	Tue, 18 Mar 2025 11:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FO+/WkVR"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D50F20AF75;
	Tue, 18 Mar 2025 11:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742298388; cv=none; b=HrfPRiUdSpBQp0xKY7zZZ0dY+nC4N+oU5CoflyKyxdxgquSOOG1Hyv2F9QQgYgbErnbrKZscyzOc16ONHNEbX/OLsSB/70LEbWnf4/ojCPlzXmZ1rmaIgwTqSgXtb2mNPEyCBqIeYaBIM0o0KMv05Fdbloz6jhUh4Q5V32phaDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742298388; c=relaxed/simple;
	bh=rCs+UrDUnktbdcw/dcYq2H0+m4LMlYoRtzFBUJPS9mM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Utlx+phPvXFSqcg5AKgYjr4j/yV8lwmPpU45HPUVS0O1x3tFrkiCBjIxO7vs3o6EqFHcHCt2Gx5UAqKskvKDDyBjiQzlU69W00ACgGjx7088x3g2HWLTp9TKXOXYgm7QQf/OfDYppFCkr0xp/pHxXVRzoFAlpFJjjp3HqOO0yto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FO+/WkVR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46396C4CEDD;
	Tue, 18 Mar 2025 11:46:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742298387;
	bh=rCs+UrDUnktbdcw/dcYq2H0+m4LMlYoRtzFBUJPS9mM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=FO+/WkVRAwmPbiaKbNXqxIgsH2lu0e7EGaDmOohEAp6ewe9UFMMUwgjNDkfMecZ67
	 t9+bexBKdKF4l2aRqPMjh5ysoV+mZtkicBTHdlfSG75EdgGgzG+ItywjjiOtkw6b8N
	 dAYaGJ6SPV2LZpZ+5Rk8DFxcLxBupSWV2NwUc3kapEbEq0a6RucKe88aM5x0+5rX5f
	 MDcE5aBBEV8VgWLuD9H63kl32IOsSAfSc3lFlJUB2tHzP5DS6Q7SfSuehU5Dmhjrc3
	 OzXNn8hf54A9OmcPdrHmD/gfQAz9dgYJr6mNeK+Zwiuu48WrpzLS/O8kxYyy51EEDj
	 F6vSBpkJdvccQ==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Tue, 18 Mar 2025 12:46:09 +0100
Subject: [PATCH net-next v2 5/7] net: ethernet: mediatek: Add metadata
 support for xdp mode
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250318-mvneta-xdp-meta-v2-5-b6075778f61f@kernel.org>
References: <20250318-mvneta-xdp-meta-v2-0-b6075778f61f@kernel.org>
In-Reply-To: <20250318-mvneta-xdp-meta-v2-0-b6075778f61f@kernel.org>
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
 Roger Quadros <rogerq@kernel.org>, Lorenzo Bianconi <lorenzo@kernel.org>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 linux-hyperv@vger.kernel.org, linux-omap@vger.kernel.org, 
 Michal Kubiak <michal.kubiak@intel.com>
X-Mailer: b4 0.14.2

Set metadata size building the skb from xdp_buff in mediatek driver.
mtk_eth_soc driver sets xdp headroom to XDP_PACKET_HEADROOM so the
headroom is large enough to contain xdp_frame and xdp metadata.
Please note this patch is just compiled tested.

Reviewed-by: Michal Kubiak <michal.kubiak@intel.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/mediatek/mtk_eth_soc.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
index 922330b3f4d70421276ecd3f4ab175b3ae263f71..43197b28b3e745319e974c6022a6a51b6953f60a 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -2122,7 +2122,7 @@ static int mtk_poll_rx(struct napi_struct *napi, int budget,
 		if (ring->page_pool) {
 			struct page *page = virt_to_head_page(data);
 			struct xdp_buff xdp;
-			u32 ret;
+			u32 ret, metasize;
 
 			new_data = mtk_page_pool_get_buff(ring->page_pool,
 							  &dma_addr,
@@ -2138,7 +2138,7 @@ static int mtk_poll_rx(struct napi_struct *napi, int budget,
 
 			xdp_init_buff(&xdp, PAGE_SIZE, &ring->xdp_q);
 			xdp_prepare_buff(&xdp, data, MTK_PP_HEADROOM, pktlen,
-					 false);
+					 true);
 			xdp_buff_clear_frags_flag(&xdp);
 
 			ret = mtk_xdp_run(eth, ring, &xdp, netdev);
@@ -2158,6 +2158,9 @@ static int mtk_poll_rx(struct napi_struct *napi, int budget,
 
 			skb_reserve(skb, xdp.data - xdp.data_hard_start);
 			skb_put(skb, xdp.data_end - xdp.data);
+			metasize = xdp.data - xdp.data_meta;
+			if (metasize)
+				skb_metadata_set(skb, metasize);
 			skb_mark_for_recycle(skb);
 		} else {
 			if (ring->frag_size <= PAGE_SIZE)

-- 
2.48.1


