Return-Path: <bpf+bounces-56403-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F07CFA96C91
	for <lists+bpf@lfdr.de>; Tue, 22 Apr 2025 15:26:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B86E83BA5EB
	for <lists+bpf@lfdr.de>; Tue, 22 Apr 2025 13:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5561E28A3EA;
	Tue, 22 Apr 2025 13:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arthurfabre.com header.i=@arthurfabre.com header.b="SFoiyn8t";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="O9Za5txq"
X-Original-To: bpf@vger.kernel.org
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393FA289348;
	Tue, 22 Apr 2025 13:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745328261; cv=none; b=I23nfq47E/xcJm41suGUJgUzlWGpU6UMoTznl1AsqCXXcwT9XpuHPzSK8Mstx2kBQFPpzfikb7UhwG7z0fp8/HU+OpBMZMcex/GWDEyqTAzCYHqgFyhbT4wkbUxh3SgPQqpBZZFR33mCeKR53UfyxdOYTYCIzmxUMZkftvjOsiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745328261; c=relaxed/simple;
	bh=BW3hXUj8bfhbUNZlGI0u/c+RhDUaklfbTQKhI1SCDKE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=P3wjsXzUyj7GpOHYLStFWfd29EB9zs2f1dgNJ8k0CDCapMGwj8lK5oF8cyU0f2eN0K1WhUohthqVM4XmyTuij+qGMy0LNAjlxJZq5NKiwMKBTfOUkBVDVN3iNmABvPGPgJqYSgkTkuXJXQrX7OThOVRQFYeRKmBeJAOHeiR1uhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arthurfabre.com; spf=pass smtp.mailfrom=arthurfabre.com; dkim=pass (2048-bit key) header.d=arthurfabre.com header.i=@arthurfabre.com header.b=SFoiyn8t; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=O9Za5txq; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arthurfabre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arthurfabre.com
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 379D011401AF;
	Tue, 22 Apr 2025 09:24:19 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 22 Apr 2025 09:24:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arthurfabre.com;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm1;
	 t=1745328259; x=1745414659; bh=yzfJQEkP7X6AZ+/ZbI2fPOyFJBcPHEtU
	bHNmDxMaBhs=; b=SFoiyn8tdyyoMXhOU2yVkCAKKhe2V+X1L+QkatWUpXGwpQ8H
	/T5OmPuBB62KZYtUf/8dJfwDIkrKjBp5TAxc2ZEzv3op+ZzKQ4wuiBWs6Y266GD9
	LTBib5zUnylcMTY1hf1IF//NquEuLv6tZkFTDQKt+IujLezVnTlGATFUEx66PrcO
	Zl/iTjw1jzniR1nmEd54G+maxKJQVK+d5Wu96ZJyRq4AjHdcITBZdnuxk8nJWB5h
	uLSTY8KjQiAc0aoj7RHadJ6hsVKI4rcz4d3k/RBOGgqE28qEo2mIGMBLYTXhv0Bb
	TxOiTGvy+Sn2UEDfgPZmZTdDbaJR1G2MVxo3Wg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1745328259; x=
	1745414659; bh=yzfJQEkP7X6AZ+/ZbI2fPOyFJBcPHEtUbHNmDxMaBhs=; b=O
	9Za5txqbeSpTfNqEFjHEZkTtxszYvud10VeZNgT679TThZcclltTFpnX0CNORYtm
	Z+5ExRobtraIsDZUpqKtEb8x6j836pc3pSkVfz2OXs+V3jBW+ws3aB7SZHutr1yj
	VdlJMbAADEkh1RO/cGEvcN9NBO7ZmGqSVMnYAkUevEggMkccnJfxmQavO5JKuP4N
	g2sRg+GjcND5/n7fnpZNvDSFh3R8XRi8B2DbP9YZegIZ1gp4sa5D/+fAKUSGm/PO
	z/4MmxpkB7M4PHSNQBBT+344J34EZ0EI7nHckVoWGomEAEXI/rUeQ5LdfWDy7Nu9
	RXcVM4pyjXOa936oGtnzw==
X-ME-Sender: <xms:gpgHaElNL5Lm1PPSsVR-1O2ppoq6SakuWcGLWHO9PdW0sEsvbuwLxA>
    <xme:gpgHaD2a1ZLPY8YxaIqSAKbM9AEg58zemF8QVr_RCcJbJFPCZ4LkN2rBP6u7IfktK
    u3PvjsijgA_5Jkk7a0>
X-ME-Received: <xmr:gpgHaCrSIXt2cHiUyxgkhv53HhvW6GFryfDsSOKNmXx23tx0S1TsPWHgPD6m-eWerY5Fnhm-XnfTJUQgyWI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgeefkeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhff
    fugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheptehrthhhuhhrucfhrggs
    rhgvuceorghrthhhuhhrsegrrhhthhhurhhfrggsrhgvrdgtohhmqeenucggtffrrghtth
    gvrhhnpeejkeehffejvdefhedtleetgfeivdetgfefffetkeelieefvdefhfeuveevhffh
    ueenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hthhhurhesrghrthhhuhhrfhgrsghrvgdrtghomhdpnhgspghrtghpthhtohepuddvpdhm
    ohguvgepshhmthhpohhuthdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohephigrnhestghlohhuughflhgrrhgvrdgtohhmpdhrtghpthhtohepnhgv
    thguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohephhgrfihksehkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhm
    pdhrtghpthhtohepthhhohhilhgrnhgusehrvgguhhgrthdrtghomhdprhgtphhtthhope
    hjsghrrghnuggvsghurhhgsegtlhhouhgufhhlrghrvgdrtghomhdprhgtphhtthhopegs
    phhfsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghstheskhgvrhhnvg
    hlrdhorhhg
X-ME-Proxy: <xmx:gpgHaAmk0z-eZxgZ4Eng0YnsgCED6hLFXQLuhavKh7b7YteIymiAug>
    <xmx:gpgHaC2yDJVDl2-THG5Ql3PHfNGQ8KfsNOq_VTUJgpc-as4wmVN1Uw>
    <xmx:gpgHaHvn3qZeeerMzuDRBEEGxXjlpoi4SCwqvio_y7RRmCPWW_ax6Q>
    <xmx:gpgHaOWi4tJdjwoYwXAZq-4oOJeOCeysRYn1hJWcvnywp8AC0LIH1w>
    <xmx:g5gHaOJJQThSQGpFQdRFHND3qfk_k9pjQvxhR7QpEZqcYrVZmGzGxPMy>
Feedback-ID: i25f1493c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Apr 2025 09:24:17 -0400 (EDT)
From: Arthur Fabre <arthur@arthurfabre.com>
Date: Tue, 22 Apr 2025 15:23:41 +0200
Subject: [PATCH RFC bpf-next v2 12/17] veth: Propagate trait presence to
 skb
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250422-afabre-traits-010-rfc2-v2-12-92bcc6b146c9@arthurfabre.com>
References: <20250422-afabre-traits-010-rfc2-v2-0-92bcc6b146c9@arthurfabre.com>
In-Reply-To: <20250422-afabre-traits-010-rfc2-v2-0-92bcc6b146c9@arthurfabre.com>
To: netdev@vger.kernel.org, bpf@vger.kernel.org
Cc: jakub@cloudflare.com, hawk@kernel.org, yan@cloudflare.com, 
 jbrandeburg@cloudflare.com, thoiland@redhat.com, lbiancon@redhat.com, 
 ast@kernel.org, kuba@kernel.org, edumazet@google.com, 
 Arthur Fabre <arthur@arthurfabre.com>
X-Mailer: b4 0.14.2

Call the common xdp_buff_update_skb() / xdp_frame_update_skb() helpers.

Signed-off-by: Arthur Fabre <arthur@arthurfabre.com>
---
 drivers/net/veth.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index 7bb53961c0eaf4de642d20e49c9e47770dc367dd..a0f70aa145790700eed37349b337b723edc7612e 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -703,6 +703,8 @@ static void veth_xdp_rcv_bulk_skb(struct veth_rq *rq, void **frames,
 			stats->rx_drops++;
 			continue;
 		}
+
+		xdp_frame_update_skb(frames[i], skb);
 		napi_gro_receive(&rq->xdp_napi, skb);
 	}
 }
@@ -855,6 +857,8 @@ static struct sk_buff *veth_xdp_rcv_skb(struct veth_rq *rq,
 	metalen = xdp->data - xdp->data_meta;
 	if (metalen)
 		skb_metadata_set(skb, metalen);
+
+	xdp_buff_update_skb(xdp, skb);
 out:
 	return skb;
 drop:

-- 
2.43.0


