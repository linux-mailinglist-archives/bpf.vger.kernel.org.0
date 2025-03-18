Return-Path: <bpf+bounces-54302-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46976A672FF
	for <lists+bpf@lfdr.de>; Tue, 18 Mar 2025 12:46:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1440189215A
	for <lists+bpf@lfdr.de>; Tue, 18 Mar 2025 11:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB0D120B80F;
	Tue, 18 Mar 2025 11:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Te31cvkx"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D493FC2;
	Tue, 18 Mar 2025 11:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742298380; cv=none; b=fl4T6n6wBpui5hmQtRHmw7pMIA1xwmtnIhp8R3x6Duz26/hvDcqwJ8cwCWGNwtKFde2kLnyui2uOwYFjWaNE0Uk/2o625H2OOtjDAisWyxXAAZK1hIaZpQ3fONGksEJzajiwhMhcw4lsJ0Ee9DhoU2rTF5vdAznhGTXjR4NwlrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742298380; c=relaxed/simple;
	bh=DCr2QpGbgPQw5gBmGdkCjX3bRDvZZMiE3YTraB6GULE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aG1XeJaay3vLUYV9ur2L/pK9y2XCSEZ7VaJFKfeIn5lfUFakuSPRs4qCAdk1zGlUkyo7pun0pUK7ZBxkOBqqzlDFEK3U/8KN4l2ENDnva4ewysYJbivhehqeIKljuTSn6acN3IQeRU6q4qbviLvaRw+gvxqXYemL2ZnqMocR6No=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Te31cvkx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C9BFC4CEE3;
	Tue, 18 Mar 2025 11:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742298379;
	bh=DCr2QpGbgPQw5gBmGdkCjX3bRDvZZMiE3YTraB6GULE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Te31cvkxgm1OC0ygqentt4hfJVDMpbqGU6XN9WM/QgVrhshyKV2EPy2l6uhTaB8Fy
	 ZPHGW0Tu3cXt93oFNCDkjuKfmVg9uXLIIu1sc7pnZyQbuIlh6T/0rUxWwO+5kQJ/D4
	 uAfzhPB/WsnDV8eudDpkdhQYWg97CLNnQdAiID0VTmUDBtYdtlOPuRHlgL5MWaeYS5
	 MsFx31Jcr0YBnC5n89hAEGMuwr+3qz9lQ0emYDtxfgr/b8Z+aXchmsKaUePLBYqaoT
	 KNAfpXXUGi9Yq0GOXJT6ZbGW8vod831j87d7PKNOA89oV0mRNnTqvBt99lVec+fOfU
	 kwfLx7iv5aB4Q==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Tue, 18 Mar 2025 12:46:06 +0100
Subject: [PATCH net-next v2 2/7] net: mvpp2: Add metadata support for xdp
 mode
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250318-mvneta-xdp-meta-v2-2-b6075778f61f@kernel.org>
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

Set metadata size building the skb from xdp_buff in mvpp2 driver
mvpp2 driver sets xdp headroom to:

MVPP2_MH_SIZE + MVPP2_SKB_HEADROOM

where

MVPP2_MH_SIZE 2
MVPP2_SKB_HEADROOM min(max(XDP_PACKET_HEADROOM, NET_SKB_PAD), 224)

so the headroom is large enough to contain xdp_frame and xdp metadata.
Please note this patch is just compiled tested.

Reviewed-by: Michal Kubiak <michal.kubiak@intel.com>
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


