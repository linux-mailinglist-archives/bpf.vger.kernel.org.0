Return-Path: <bpf+bounces-53811-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 01672A5C107
	for <lists+bpf@lfdr.de>; Tue, 11 Mar 2025 13:27:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B97C189BC92
	for <lists+bpf@lfdr.de>; Tue, 11 Mar 2025 12:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2763F2580D7;
	Tue, 11 Mar 2025 12:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oB2Mkk3h"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975F4257AFA;
	Tue, 11 Mar 2025 12:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741695540; cv=none; b=guOtNeOoFC2iu82DirUkEfRikSnHTajCRcTacgVWZjqq8ttqwzHCGpX9z8aX2Bvc9SyNOznxhtzBDrrb//8qar2CfrHeahrLMc/QqhR4rLead7etSQkZL8ceUaXo39w4xwkJsxVrflUi48LPNZaNtYhthJDYhabJLLLOQDLOzTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741695540; c=relaxed/simple;
	bh=USZFGVWbz/e1RaRs2NXM0mQ04IIB7x/0EIOh9y03ySU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PUjuTURmzPJge8KcZUSajK4+N3g8NaCaShZnlg58BsHQHabYT/pf0VTIybCXAGlKvRNpD9i/mvo5Srgaj7H6OCVztYzoPMgN/cB+W2HNoAPeVoInhg4fUaqRmN23F0jTOnsl7hXFNtfhFUUggpkTAxzkk5XYAYdlk9zi5dtTR+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oB2Mkk3h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90A6DC113CF;
	Tue, 11 Mar 2025 12:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741695540;
	bh=USZFGVWbz/e1RaRs2NXM0mQ04IIB7x/0EIOh9y03ySU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=oB2Mkk3hBvNB3izblm0qRhOfK4PEK8hibRGaEZRQvMUibbec9EvlXmivGInwdGNJM
	 ptMAvd13ztY7+CJGWD/Lap9bPsddC9SF4Hl5KCQdRwckcNlR/8NZazyAFw5gAB2sjq
	 JJ2IRdQFahbqwNe+a9VWCIkr6l1Mk48AmNm73ABXU5HWXegoin4isUNwLGlvhsMUDq
	 RwheRwYDMxaSLWQAkpNcc0dZWgyuSCM0H+sKntBP8crvuoQTavLP+8KoCoDg8bMp/Q
	 8eMsyKXSUq8SGR23Jln+mWyP1INwHXCQXz/Pagtk/J1Gi36+ManpY661QdcPu8LXDy
	 YdOYe6s7wPLtA==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Tue, 11 Mar 2025 13:18:33 +0100
Subject: [PATCH net-next 1/7] net: mvneta: Add metadata support for xdp
 mode
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250311-mvneta-xdp-meta-v1-1-36cf1c99790e@kernel.org>
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

Set metadata size building the skb from xdp_buff in mvneta driver

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


