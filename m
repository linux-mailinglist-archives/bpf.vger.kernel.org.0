Return-Path: <bpf+bounces-54303-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F9CA67303
	for <lists+bpf@lfdr.de>; Tue, 18 Mar 2025 12:46:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F6CA19A1A85
	for <lists+bpf@lfdr.de>; Tue, 18 Mar 2025 11:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F01A20A5DE;
	Tue, 18 Mar 2025 11:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G/8bSdeF"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC71E3FC2;
	Tue, 18 Mar 2025 11:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742298383; cv=none; b=K/vZbn4bVCBFZHyjZZsA5iP8QJejagahB638FRsVlZRvZkTqAYEqLuHYYu8MzBP7DnIgQEPLyiDl14ZUDcbbw5+g5zEXeAi7v5cNWMPttlFp/EiukyNl/h8o7H+CfkrPAF7TlkPKrDs/tgcD9GE6hRw9qHj+ymCgZBmmQZA5xLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742298383; c=relaxed/simple;
	bh=OxxwCX4kmkFgORosEwbEM+9lMLPNKxBrIFre8ujLNdY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kLYKTv3TjpP92iEiR3ilNhYK3kD75HegBnVHev4LKVZW6L1us4ysPDR3HGsnZFPxLE7I/JoWfUFWkG9TkYOb/9Nm4pc8XY1XetxWFwBRS7D1aejGHxQgwmxou+Tc0XsOq3rVMoV6zzhk4PDH8inmsyDQSRKF9y83WNmo4j6Q/Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G/8bSdeF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E22FEC4CEEE;
	Tue, 18 Mar 2025 11:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742298382;
	bh=OxxwCX4kmkFgORosEwbEM+9lMLPNKxBrIFre8ujLNdY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=G/8bSdeF2XHkLu2RJLqgr1qcc3i6Xqs9vw1Kb8R7xY+Fhi+0qxrWc+cK7qxI1FdJL
	 SS9/v+gso/M9T1ReB7ioMHdNvFXQ74ImLErduWqE3fubCGlD6gfANC1nj5NWggcloQ
	 UAjkdTZmYRgdVo66u0YvV3qtp1AcqUexUDNL77Y90PSDdyDtyRaxljl0cgT3qpMiBc
	 sLPQRd2J4E7JhLpm0Q7XJSmpiOOvxc9bSvcPPGY/2HsGFAd1WIPookJdVIVMv0pe+u
	 Z4oaogFa1h5bqyrwnXJlNbRTr0lO6MlVVP0YpHqUnT147kwtp4IOKu7TrPtNCwHrcu
	 mYphVAbb4JLRA==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Tue, 18 Mar 2025 12:46:07 +0100
Subject: [PATCH net-next v2 3/7] net: netsec: Add metadata support for xdp
 mode
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250318-mvneta-xdp-meta-v2-3-b6075778f61f@kernel.org>
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

Set metadata size building the skb from xdp_buff in netsec driver.
netsec driver sets xdp headroom to NETSEC_RXBUF_HEADROOM:

NETSEC_RXBUF_HEADROOM max(XDP_PACKET_HEADROOM, NET_SKB_PAD) + NET_IP_ALIGN

so the headroom is large enough to contain xdp_frame and xdp metadata.
Please note this patch is just compiled tested.

Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Reviewed-by: Michal Kubiak <michal.kubiak@intel.com>
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


