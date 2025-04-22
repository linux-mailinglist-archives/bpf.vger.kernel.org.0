Return-Path: <bpf+bounces-56407-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14C5FA96C9D
	for <lists+bpf@lfdr.de>; Tue, 22 Apr 2025 15:27:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3427917DF75
	for <lists+bpf@lfdr.de>; Tue, 22 Apr 2025 13:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 141A328CF45;
	Tue, 22 Apr 2025 13:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arthurfabre.com header.i=@arthurfabre.com header.b="afjdjW7t";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oTfVggsk"
X-Original-To: bpf@vger.kernel.org
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 055E128C5C2;
	Tue, 22 Apr 2025 13:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745328271; cv=none; b=ogj9IMxXXbgIlAKoQreQOs07CRmLtfA353/wX5UxiEt/6et/HV2FsoVwnP2xIoQJovi5YvnmWJ5orglQm4OhTB8OE8oDHHhj6QYcDbMptWWvfirQ4t+WeSfbSSgnaXnfzuBI2ck291DqJcaZTdpOA0NVVyo+Trlqgl/YjSUx5C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745328271; c=relaxed/simple;
	bh=e6ZkufKDS21f0UyJqVReDFwnEn4IJ4Hrymtj8Y90gdY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fwTurno/em/Q/pc0CWsG3y9GEMyOg0/JyLyOF9bsKMQQpul1D4dMy/VCSYZLN7MTu31nbAmbV9DTdzfOHdPGgay4phtWpDgOIHn4esPr05dVhv9CIbJ3fGWkE3VU4PQgfI+PNVzGofiPgzOw1eUYgUtg2Ajh1AQs7I725O8I6Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arthurfabre.com; spf=pass smtp.mailfrom=arthurfabre.com; dkim=pass (2048-bit key) header.d=arthurfabre.com header.i=@arthurfabre.com header.b=afjdjW7t; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oTfVggsk; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arthurfabre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arthurfabre.com
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C9A3625401C9;
	Tue, 22 Apr 2025 09:24:28 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Tue, 22 Apr 2025 09:24:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arthurfabre.com;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm1;
	 t=1745328268; x=1745414668; bh=4I2nMgNZvyZouGhriuC4mlMG0byRE+Qf
	jSVq3kMsmLY=; b=afjdjW7t5VWIXp06IHd2lb20+hTi8cYS7d3G4RYFcnUaF07t
	NuVkRBIX/iiS3uxiiG9GK/g4J2/xHFlfzWFKFli7vp+rCF5xGGyQrCM2Lmx+W66P
	cKLrAWisnKffwfMJVaULsN6En/Kxq6iy2SGtlbreaMVVzb57cr/eMLiSYemAFHe9
	Fxqw82L7F3d+YF6pqYiA8/IC1+RYJPYMK0JjU7mzp11CwWnLDVJcDUJj6T80wlUY
	cEg4SbGw319aq0YuDUL62WSMtFRN6HPwtqC5LGb4++geALTwqrBwTwth+DeuTOhZ
	Q2h17bSY3ptIpz1w98HXTavHtvcBbWNBcBSd/g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1745328268; x=
	1745414668; bh=4I2nMgNZvyZouGhriuC4mlMG0byRE+QfjSVq3kMsmLY=; b=o
	TfVggsk5nkoP5Dj2AwKp5akVNkQ07pWMQKByf171h9YywUC5KoxmdsyyaACSP3l4
	oIjLlCMe15MtRGTJRg6KtQT+EOVY50YUD3hHRChRkya1nfE1K1VklyWkIuzJ/YlN
	E1J+RX7UQab4xCh5lS8Yfzi46FfRW8Ir0WTtAObrXbTHRFqSHKy2VpyAvYV1q0nV
	PLsTJ2horUl/NBxeT+9WhzVfCgHRsr+ijiC53hFs5a1lUDp0pdedvm0YXVlxrer9
	VJO99Ugr74HlWathH8KSVieUenSYSVfxMwAYB25l7UYOUqbgui/djpWOElNbSE26
	FKUfu0Z28vHVArBlPnSQw==
X-ME-Sender: <xms:jJgHaG_tZhxwDq2cJaFOo5HFlOptIWsFcm0_7fPenXk5qqkGXJA_9w>
    <xme:jJgHaGvubv37UYXqLqNs8PGzwBDOTWcv8OMs-rNF-N2qXO1XWDPyYJpBBipgSo8-J
    hHWfjdztLGOpYpeZdI>
X-ME-Received: <xmr:jJgHaMD9cx7ualHrWW9cBdKFMFwPuceXJ65a9zBpa9cfz_VXEz5pvFC8T2RrganfhvXGp0OrUX3IToJKGb0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgeefkeegucetufdoteggodetrf
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
X-ME-Proxy: <xmx:jJgHaOf2QN-E0_vJm_oV4DAiOQeo2EQ3a8A5CUdi-l1kJmq7iXWxnw>
    <xmx:jJgHaLNutJfMzY1DRbMwCZ5kaD3U3NEKl7NzmursyVVnS2b-jIihQg>
    <xmx:jJgHaImQMnvM242__JwfYZovJtRPwx5vHWNDOL9YXPTNNtk1PttSMA>
    <xmx:jJgHaNsxTGGNUf6rDwVGWYrRfOemQTAcFqBjE03XkxZ-AkQbX0NJzg>
    <xmx:jJgHaN0QI6W_G0uSzn3UAo-eQ7SNUV6p_zBNlHD18DfB4ACYhgGQ6vrg>
Feedback-ID: i25f1493c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Apr 2025 09:24:26 -0400 (EDT)
From: Arthur Fabre <arthur@arthurfabre.com>
Date: Tue, 22 Apr 2025 15:23:45 +0200
Subject: [PATCH RFC bpf-next v2 16/17] xdp generic: Propagate trait
 presence to skb
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250422-afabre-traits-010-rfc2-v2-16-92bcc6b146c9@arthurfabre.com>
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
 net/core/dev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/core/dev.c b/net/core/dev.c
index 1be7cb73a6024fda6797b6dfc895e4ce25f43251..4d1ac5442d2ecf3c22186ab264ab54eb7d302708 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -5226,6 +5226,7 @@ u32 bpf_prog_run_generic_xdp(struct sk_buff *skb, struct xdp_buff *xdp,
 		metalen = xdp->data - xdp->data_meta;
 		if (metalen)
 			skb_metadata_set(skb, metalen);
+		xdp_buff_update_skb(xdp, skb);
 		break;
 	}
 

-- 
2.43.0


