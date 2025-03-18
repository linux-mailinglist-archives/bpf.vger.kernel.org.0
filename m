Return-Path: <bpf+bounces-54306-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BB20CA6730F
	for <lists+bpf@lfdr.de>; Tue, 18 Mar 2025 12:47:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A081319A1E13
	for <lists+bpf@lfdr.de>; Tue, 18 Mar 2025 11:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E47E20C473;
	Tue, 18 Mar 2025 11:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KBECqMmd"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DBE120AF75;
	Tue, 18 Mar 2025 11:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742298390; cv=none; b=AP0rSmE+IVamJHd4dwBPp4hch1ZeDwiZJhdXnWznk6rFkhVF5BSrjKUr6u0IFiLQ0izKGp+Si1mxM7DnOyXe6Oxbf3oaZzxLByCDsHDvddtGjwYCmTo1cgNjPG/bjz1tYoqYg1K0Rq50qML/XA4ab7m70CSKDOtZSQ1o7W14kUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742298390; c=relaxed/simple;
	bh=iVv9lKsgzc7NHnkM2bif0jCWiz/F21PHpCbC8MzU9us=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UCQWN2TeAZL7kvRxqe5FFcpuKjDL4FifGCSiXgZ/+DmuihsA0jdW42OVpMfYas5jnt7hWCFYAFESLzBaQO2bQfT93jGVdIZcuscVSpuPMitUfES4mC0jhB83O1XbPOVwoNP/+Bmz7lMMqc8eYDUyNHpZ/AVXd59oSRN45jmsZRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KBECqMmd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD104C4CEEF;
	Tue, 18 Mar 2025 11:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742298390;
	bh=iVv9lKsgzc7NHnkM2bif0jCWiz/F21PHpCbC8MzU9us=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=KBECqMmdeZ8yKJyBVe2cc8UUyMS4dTq73V1W4rI1ZwPqcLZwmIXMDoHrHFAPjGY6V
	 EGzq4181p57fxkBYmMZ1SWAWgtOZkClekmig7OhdkIylg8nNRu8wuMZzPuv5M2BkR7
	 deXdnJJ2sa5MoHsANTfBX6GJTsx/idultdZVL5WVvrFiontRDeS3yaXy0vAu4SfDB9
	 5lsel9aY6VHkt5gHBBUw3nYKoG+N6J/tykrk0H65Yw0jBAUbcIImaCjGmjJvHFECGz
	 Z9IeXXzwxfXB/y60Chk+vUhjYGM4kd5xkW2dWHi5E4jFnMbDGIcdsE6tNdqoGUFgn3
	 Okyr8lWvlENLQ==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Tue, 18 Mar 2025 12:46:10 +0100
Subject: [PATCH net-next v2 6/7] net: mana: Add metadata support for xdp
 mode
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250318-mvneta-xdp-meta-v2-6-b6075778f61f@kernel.org>
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

Set metadata size building the skb from xdp_buff in mana driver.
mana driver sets xdp headroom to XDP_PACKET_HEADROOM so the headroom is
large enough to contain xdp_frame and xdp metadata.
Please note this patch is just compiled tested.

Reviewed-by: Michal Kubiak <michal.kubiak@intel.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/microsoft/mana/mana_bpf.c | 2 +-
 drivers/net/ethernet/microsoft/mana/mana_en.c  | 4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/microsoft/mana/mana_bpf.c b/drivers/net/ethernet/microsoft/mana/mana_bpf.c
index 23b1521c0df96e7fd595daad8b49fa9be935090c..d30721d4516fc60cf8883f2b35cc561559082ccc 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_bpf.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_bpf.c
@@ -91,7 +91,7 @@ u32 mana_run_xdp(struct net_device *ndev, struct mana_rxq *rxq,
 		goto out;
 
 	xdp_init_buff(xdp, PAGE_SIZE, &rxq->xdp_rxq);
-	xdp_prepare_buff(xdp, buf_va, XDP_PACKET_HEADROOM, pkt_len, false);
+	xdp_prepare_buff(xdp, buf_va, XDP_PACKET_HEADROOM, pkt_len, true);
 
 	act = bpf_prog_run_xdp(prog, xdp);
 
diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index 9a8171f099b63c6a1a6415f12718d46d5d835f97..e190d5ee51544090a703c14c76abdc23797f864a 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -1559,8 +1559,12 @@ static struct sk_buff *mana_build_skb(struct mana_rxq *rxq, void *buf_va,
 		return NULL;
 
 	if (xdp->data_hard_start) {
+		u32 metasize = xdp->data - xdp->data_meta;
+
 		skb_reserve(skb, xdp->data - xdp->data_hard_start);
 		skb_put(skb, xdp->data_end - xdp->data);
+		if (metasize)
+			skb_metadata_set(skb, metasize);
 		return skb;
 	}
 

-- 
2.48.1


