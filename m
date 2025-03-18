Return-Path: <bpf+bounces-54301-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6008A672FA
	for <lists+bpf@lfdr.de>; Tue, 18 Mar 2025 12:46:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E9B6420760
	for <lists+bpf@lfdr.de>; Tue, 18 Mar 2025 11:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C35320B7F2;
	Tue, 18 Mar 2025 11:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dnJg0tI1"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D963FC2;
	Tue, 18 Mar 2025 11:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742298377; cv=none; b=V2iiF5V7bDGj23qjZhU7BUdHu+R0nOg8hypXYqQYUIU6xr1wWZe93BXkp8OmsYNmqQq5hFwzysm5E94uee2axHKHkVQPjml0vAh7/K3lSAHnDFtHFaEcBWcQmPuAK9XEjdHJ4qbT6gQZ/ESLFRw/p83ClpL8WXQsu8CeBsPaLYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742298377; c=relaxed/simple;
	bh=5bdfNHNW+EoJKgsImeaU1ELqKAI9RB+ut6VPZYTxSaY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oKtZzJN7Hl+B4LMdWCKgh4D1rb9jFpCaGBV1FlgmGqUroK1OgJcctCUV2YOmQPpSKRsWWJwLxw1CzRqwFVEzBeuDNApvjJWvYNVxnzGu0OB006adkg7orWjCCNH0yTKf+9dK5QUjYKs6Jcqvxc8ChXT55Q4eIzajE61tB/YYWJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dnJg0tI1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84918C4CEDD;
	Tue, 18 Mar 2025 11:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742298377;
	bh=5bdfNHNW+EoJKgsImeaU1ELqKAI9RB+ut6VPZYTxSaY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=dnJg0tI1RHrQUFNIGYqSCDRHEBb8kmU7NXfRpd1yHY9RldMoknRO9txFvGJBrm+9i
	 U3S+wYU6zSEdA6IPrFFPhhLncMYbInYbUgniDhnCLbf7AlmNeyGEKEJ9OfYE7ZQ9M4
	 AdkpRg3WrFBLDqRysfPleQYCb/72T6oKw4BvquInKFv6V/GlfrwB1kDD7dLuJjA3KE
	 Hpz19NKbDM+GG8yGABbbUcxo7bsp2fK1ciHG4vM3L8w8O9d7Rh8HLW8fg+533V9oDL
	 An687yny/E9ghZ84OHVGAIdRgEzE1DIjlYukf7YcbSBJMB66p85UyBd4yJp+RjCPW3
	 EQ+wZtMZOUWYw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Tue, 18 Mar 2025 12:46:05 +0100
Subject: [PATCH net-next v2 1/7] net: mvneta: Add metadata support for xdp
 mode
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250318-mvneta-xdp-meta-v2-1-b6075778f61f@kernel.org>
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

Set metadata size building the skb from xdp_buff in mvneta driver
mvneta sets xdp headroom to:

MVNETA_MH_SIZE + MVNETA_SKB_HEADROOM

where

MVNETA_MH_SIZE 2
MVNETA_SKB_HEADROOM max(NET_SKB_PAD, XDP_PACKET_HEADROOM)

so the headroom is large enough to contain xdp_frame and xdp metadata.

Reviewed-by: Michal Kubiak <michal.kubiak@intel.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/marvell/mvneta.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
index 44b18c57390927e37eac267632cace656bb5526e..147571fdada378e430fd96f2fb4a7e7870b784a2 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -2342,7 +2342,7 @@ mvneta_swbm_rx_frame(struct mvneta_port *pp,
 	prefetch(data);
 	xdp_buff_clear_frags_flag(xdp);
 	xdp_prepare_buff(xdp, data, pp->rx_offset_correction + MVNETA_MH_SIZE,
-			 data_len, false);
+			 data_len, true);
 }
 
 static void
@@ -2396,6 +2396,7 @@ mvneta_swbm_build_skb(struct mvneta_port *pp, struct page_pool *pool,
 		      struct xdp_buff *xdp, u32 desc_status)
 {
 	struct skb_shared_info *sinfo = xdp_get_shared_info_from_buff(xdp);
+	u32 metasize = xdp->data - xdp->data_meta;
 	struct sk_buff *skb;
 	u8 num_frags;
 
@@ -2410,6 +2411,8 @@ mvneta_swbm_build_skb(struct mvneta_port *pp, struct page_pool *pool,
 
 	skb_reserve(skb, xdp->data - xdp->data_hard_start);
 	skb_put(skb, xdp->data_end - xdp->data);
+	if (metasize)
+		skb_metadata_set(skb, metasize);
 	skb->ip_summed = mvneta_rx_csum(pp, desc_status);
 
 	if (unlikely(xdp_buff_has_frags(xdp)))

-- 
2.48.1


