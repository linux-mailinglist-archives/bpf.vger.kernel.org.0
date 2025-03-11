Return-Path: <bpf+bounces-53816-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DA3BA5C0C0
	for <lists+bpf@lfdr.de>; Tue, 11 Mar 2025 13:23:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7671E3B48FD
	for <lists+bpf@lfdr.de>; Tue, 11 Mar 2025 12:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9419825B672;
	Tue, 11 Mar 2025 12:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r8AqGYmk"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120D325A63F;
	Tue, 11 Mar 2025 12:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741695555; cv=none; b=EYqMnR+lod54vyYCaXNqu7qYPWWz30aX1pX6Dg2my5dlfUTjdFgD6NuVJT67+dpiJ0Jbetlm9KZ+3MWXpBA2f31NmNUetAmW0ZsoUiJfQM2Z7U67eQucyZ6xpr8YpG5O5WvVrXDrdcdBGFebec3oAxu6TYVmZezBrBBVqlmHg3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741695555; c=relaxed/simple;
	bh=x+krQGj/SL7R2wTdC09zi8Lq2AOOM9k7jWivDeJJS7E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Kh0x2fsFonW7uKwAkDhj2FWeRtXIZegBud60moeumpQdCpTgryWauxm7LbpcgWvy7OkModElRFEhXi24zNINz3FQyi2bhZZ9MAI/YG89mOTJdGLFd6812EJ9PfOQXb51RHLZXtfIDEdTyPsItwYzSdxd/YAwSKhZ/WNqVDV0wNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r8AqGYmk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 015E2C4CEEC;
	Tue, 11 Mar 2025 12:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741695554;
	bh=x+krQGj/SL7R2wTdC09zi8Lq2AOOM9k7jWivDeJJS7E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=r8AqGYmkKFQQ/vy7x1cM404pF4kwW8b9mOnf9uhfwPUs7/J3vpKMzAJjfAXOquY1L
	 36qn3x0ZcN9kZFSINUG95beouVuvqQk51kt6TDGbq3BeFwB7FJUtrpcmFrxubQZOGU
	 WaTwf6mK71Osy15xecOCW+flQF4dRFyi11XEAXOgo9ilG83bEoUrIqw5f2JS7AD5xh
	 nYpQ1mna/BFRAoAtVl5aUD/Y+dckxhrzHEa5RLHCh8MHWzi5w5MOv1/X62hnh24n/d
	 PUG1fyxAXOIOwqv8D4bs6uqN7OmRF9yI19BP/TSj8f5+bDPq0PutZZBw9SI7I+mQE8
	 IFJYpfJFuFyGQ==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Tue, 11 Mar 2025 13:18:38 +0100
Subject: [PATCH net-next 6/7] net: mana: Add metadata support for xdp mode
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250311-mvneta-xdp-meta-v1-6-36cf1c99790e@kernel.org>
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

Set metadata size building the skb from xdp_buff in mana driver

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
index 2d826077d38cdac7ebe9c355cf883b0d727eeca2..a3986fc47b819dae1f8a1d62ebe1ff051b144236 100644
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


