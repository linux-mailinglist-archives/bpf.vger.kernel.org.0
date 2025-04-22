Return-Path: <bpf+bounces-56401-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD6F8A96C92
	for <lists+bpf@lfdr.de>; Tue, 22 Apr 2025 15:26:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C148919E0003
	for <lists+bpf@lfdr.de>; Tue, 22 Apr 2025 13:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B35D2857EF;
	Tue, 22 Apr 2025 13:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arthurfabre.com header.i=@arthurfabre.com header.b="Q8C252Kn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="umItEZFD"
X-Original-To: bpf@vger.kernel.org
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97FED2857D5;
	Tue, 22 Apr 2025 13:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745328258; cv=none; b=A9+++zEN/fn6tJx5GdrUeLNAniPN/V3Zf9yzN+i1XM0au9YLZlR6rqtFF8xvUAI0Z+IzugQ4jRkHav3IMwNJMpG61n5VwlB0DBUbkPb29J3t7HYlN3ZXk/i3kIeJOa8fV2bSMl5WVBlDKGiPnNkyeyTvBxkMvvZNytfMSMxzpG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745328258; c=relaxed/simple;
	bh=MD4RcbCLa6EbvwCaM+b2VpBhv0vcm8pp1bRfzGVp/58=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uUEJH4WESofgJJHiQUy87xOAFPNjuEm/3LRHkDyOaQl0vGIOBejpYZdHVD7zE53HMeM6bg0f4XNWUq2Z57Ebfmc6M36b49wg8jPELqf+N9nW84w5AB8YfierVQaLlxE8ZG8ZBK6sQTldWxZNb0aVzLQSEiCVPjVPzV4vZ3q/4L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arthurfabre.com; spf=pass smtp.mailfrom=arthurfabre.com; dkim=pass (2048-bit key) header.d=arthurfabre.com header.i=@arthurfabre.com header.b=Q8C252Kn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=umItEZFD; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arthurfabre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arthurfabre.com
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 67262254020F;
	Tue, 22 Apr 2025 09:24:14 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 22 Apr 2025 09:24:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arthurfabre.com;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm1;
	 t=1745328254; x=1745414654; bh=/BK4qm8i7A0azwHQOqS+LRzWaPNd+X7a
	Qo0aPHBSxJ8=; b=Q8C252KnLhdQ14klNTjsepaEnx2mu8PVGtwd+ggzuIjDPg8U
	1qhNloxVTxyrHw2AssPIz+pmXtP2j3kD/UrRba6Jqhj9j+b/8W6egV7fN46U+vAo
	d35T96kAC9g84/cCezaz81gJV82zKkXMVGB6rNfm5I3MZ9UKazsh8GHQ0+lXOHRJ
	lEmuJHi2sjZu0oqGQ/VTQzgkF1p88U67mycb5bWt5dYndALJtVWYRfZzjOTi2Zs3
	jg4ii+QdW0k158XpwRaTRnYsCZhK0dgdErLfrEULNZUfDsc4J1ggHhZyoCeqgpc8
	E6PMI/FNUvKYp6y2FCgnk7E9TV57T78kqQrjvg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1745328254; x=
	1745414654; bh=/BK4qm8i7A0azwHQOqS+LRzWaPNd+X7aQo0aPHBSxJ8=; b=u
	mItEZFDuyIxlr2YZBVojhGQdJnStqOtNQRx5NIr5QBai63BctfiQyH2einaLSdKP
	oJBM3mdAd+7FchBn5uNASsZBIDc9swkKreUPW4CSdPx/BmnbnJd6VuQrMopzQpjA
	7N9E8oz5ZRQXwAqTD2wTQVrimQrVzyRtc5fiYig8XGQWYONCEg01bYf7vmVpvDb1
	DbFdJi+4gv4gmZ8GKJTIihmqcUn/1iej1yWspHMY7fR9EbMJEGzBNv7SH2zsv4e1
	bl89i1CiqMb7Ss7Dn3zqog1RNmvSlLITw9Kv6VwiIVkGsKT60map4/ex+J1Tm+bu
	ojEB0UVxzOYmpgDL4OYrg==
X-ME-Sender: <xms:fpgHaKw-zaZqYS6KIopSBYF7OtNN3bthg4SHxcAaVgXnZoXO96vofQ>
    <xme:fpgHaGRTOKJXdyrh50Mo4oMHx23W0JlK6vvMBFScgomwb9XsLT-Y6yhdd2lPzF2fS
    vMYbCgf-ZuOWfoD5jA>
X-ME-Received: <xmr:fpgHaMWxdzw6Vbw2CifiVAkvnkLDd8zNHrHS4TGMDTFwEVYAZwsiOrYW_NQvTCPwJSuCOux4JmJ0xLyMnhg>
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
X-ME-Proxy: <xmx:fpgHaAgbLUWeJNXPsuUXR-Ux_7CvrYSRb12i3WccB-pKuGSQ4qwrsQ>
    <xmx:fpgHaMB2IRITK64ScQYv_0MXcX0SRXXK0f3QDOCbNmPWhRFoe-r0yA>
    <xmx:fpgHaBKs1kItd0WCUtOCgBbdrsWchXqEPHEUz8U2fykMM_EMGBlX3A>
    <xmx:fpgHaDABNQMXHoP4NFH-IgRJ0sM0n3HGJQ9PKcvNxzR9Pdup5ZAfAg>
    <xmx:fpgHaK3sw8kISxVwGBVY_8N3gslxnqdrb9ktScjnmvL2P1Bbq6fOEyTH>
Feedback-ID: i25f1493c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Apr 2025 09:24:12 -0400 (EDT)
From: Arthur Fabre <arthur@arthurfabre.com>
Date: Tue, 22 Apr 2025 15:23:39 +0200
Subject: [PATCH RFC bpf-next v2 10/17] bnxt: Propagate trait presence to
 skb
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250422-afabre-traits-010-rfc2-v2-10-92bcc6b146c9@arthurfabre.com>
References: <20250422-afabre-traits-010-rfc2-v2-0-92bcc6b146c9@arthurfabre.com>
In-Reply-To: <20250422-afabre-traits-010-rfc2-v2-0-92bcc6b146c9@arthurfabre.com>
To: netdev@vger.kernel.org, bpf@vger.kernel.org
Cc: jakub@cloudflare.com, hawk@kernel.org, yan@cloudflare.com, 
 jbrandeburg@cloudflare.com, thoiland@redhat.com, lbiancon@redhat.com, 
 ast@kernel.org, kuba@kernel.org, edumazet@google.com, 
 Arthur Fabre <arthur@arthurfabre.com>
X-Mailer: b4 0.14.2

Call the common xdp_buff_update_skb() helper.

Signed-off-by: Arthur Fabre <arthur@arthurfabre.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index c8e3468eee612ad622bfbecfd7cc1ae3396061fd..0eba3e307a3edbc5fe1abf2fa45e6256d98574c2 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -2297,6 +2297,10 @@ static int bnxt_rx_pkt(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
 			}
 		}
 	}
+
+	if (xdp_active)
+		xdp_buff_update_skb(&xdp, skb);
+
 	bnxt_deliver_skb(bp, bnapi, skb);
 	rc = 1;
 

-- 
2.43.0


