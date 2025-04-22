Return-Path: <bpf+bounces-56402-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C06CCA96C8C
	for <lists+bpf@lfdr.de>; Tue, 22 Apr 2025 15:26:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1816F3B9BF6
	for <lists+bpf@lfdr.de>; Tue, 22 Apr 2025 13:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01C76288CBF;
	Tue, 22 Apr 2025 13:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arthurfabre.com header.i=@arthurfabre.com header.b="mbNdXJ9k";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hyivNu5C"
X-Original-To: bpf@vger.kernel.org
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75042857DE;
	Tue, 22 Apr 2025 13:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745328259; cv=none; b=oaBxqng42Unfm6RZHCB3IPTBYzLY8z2S0EYXvCVqWTR78bUHVp4Xrt8xa4choEHsY+qLwK/aRATSinnJjlE30ybNymvaTaFIcbMmTD6b8lmfEAE30TDYeQ05sIW542SpoVvB5largAOYJqF07lRwsxnFZpNFQDn1BGcHnoZemvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745328259; c=relaxed/simple;
	bh=QdzyYwrRvmigeBbDHEFGPutKgW1te3UaOl4aK69dQiw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dWKkQ51z1547AIhJ7T/yNVQ3iGRhOCDzjPm9XYK58eYlsWRezY4jN4V4oWeaJHgM4+YC3qkjd3cbMmE7Jw4EmibIZ+qs1wxXqxfe3m/WyffESZuMLSceKeU2IzeoRnTei/k5oWl4ZFqdi8sS7IHwYjzAu34PzsRIKjYCim4/+7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arthurfabre.com; spf=pass smtp.mailfrom=arthurfabre.com; dkim=pass (2048-bit key) header.d=arthurfabre.com header.i=@arthurfabre.com header.b=mbNdXJ9k; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hyivNu5C; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arthurfabre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arthurfabre.com
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id CDFCF1140190;
	Tue, 22 Apr 2025 09:24:16 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 22 Apr 2025 09:24:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arthurfabre.com;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm1;
	 t=1745328256; x=1745414656; bh=1mfEO65EqZvoWoPLJtaDbXfwOH2Gs6As
	tuJfxne+Tg4=; b=mbNdXJ9kMhKFQigh7kYpbA45n+CUNkqvozyYSWsxb+8HyBwQ
	lngFp2+VL9oqJF/SOUxUiUoXTNMKoShc4khoERTimsZS3vKWSNE6DmwK5IY+E7iL
	a0NHT+k7bjxf6vb3+KrEAFdC9IBJNPSa+0KJa/PzougdNUI0QqVcsJzqlnsNcC7W
	YQN8MKWRe8BnpG/5ZwxFlLT19J49TidQmask3A41XAG/5ucRY8jWujR+Q8p1/ipS
	heY+MhW/R1/TSLxG4tJVCX7WXICCBPkj8zOXiJsxGJoYlUhYa71TqVsbTc1DZxrP
	DED57HnEVAEXo3FI6fljYkgKLuwT0AHtq3UxRA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1745328256; x=
	1745414656; bh=1mfEO65EqZvoWoPLJtaDbXfwOH2Gs6AstuJfxne+Tg4=; b=h
	yivNu5CryRiEfR0tCVmVI/nJkEp575jhX47yjeS4guZZeg4W8v1ncrcryJwOh1AU
	IrIWyWjbocdQcMe/rO43CxPH8clat2pcN7OlfdteNJPCJIxYD3anZIizoME4RBSs
	bh5sH+at5QomcBy5lG08+LGbxvT4cSn76U9yWakbLUVbCqKITeubjfBY6tcp48ER
	v2xD7aff7gJKZSIoLQ0b3IcsI1ufaOOC6jMBtzqN6ulfe2V4uPsDdkcHKG6m8Kpc
	NOI8XkS7rfw6YWdQ919yx1HQzDn1OJlt6NDa67x5NTNQ+euKuK3K3KXhJWKPaXjn
	Pf37qugi+0X3NzXF97SAQ==
X-ME-Sender: <xms:gJgHaJ0V4eq87VbuLjXUNrv4rH7KrhPKSq0_JeHYXrQV3xOrm0djQg>
    <xme:gJgHaAFe85Vm95doaJWoh-XWYJOLCVT-lb1UTFuXDy2n-lzE6LykNbx-WkGoPDoww
    UjmM3aE1xDNme_c5Zg>
X-ME-Received: <xmr:gJgHaJ5EYP0CNqCSOtYtJekT0FWWJGAU22ARFRwDpVU--vU-DhMD2JX1hdFEctpfAnnTvDoF98l09iFJPV8>
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
X-ME-Proxy: <xmx:gJgHaG2XLuq5wbQpsoukuvpAtrt5ezNZ6T6Ci-7J9DwRbOzXbqnD7g>
    <xmx:gJgHaMErouwTCOM980Ifu8NEDcQYdoKfgEpoh_zI9Z8vjA7Ff7ZCHQ>
    <xmx:gJgHaH-jLqkY_16N-N7CIjpUjKeWbXEtIbMQMSrLu6OCEZf7JHQlrQ>
    <xmx:gJgHaJlIcT0_cQoA9wfLNVO3nInyU6b-UjEvQmdMN9dKmmMEy9X6_w>
    <xmx:gJgHaJatQbMQNOZe_0W76IE8UbFO_eq5bC3GuRBgyhuKyoqjNBTG42EC>
Feedback-ID: i25f1493c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Apr 2025 09:24:14 -0400 (EDT)
From: Arthur Fabre <arthur@arthurfabre.com>
Date: Tue, 22 Apr 2025 15:23:40 +0200
Subject: [PATCH RFC bpf-next v2 11/17] ice: Propagate trait presence to skb
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250422-afabre-traits-010-rfc2-v2-11-92bcc6b146c9@arthurfabre.com>
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
 drivers/net/ethernet/intel/ice/ice_txrx.c | 4 ++++
 drivers/net/ethernet/intel/ice/ice_xsk.c  | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
index 1e4f6f6ee449c96ed1afe6fa4c677a7b2caf53e8..ff2d79b4232181be05f413e451ac0b05e0c65bfd 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
@@ -1011,6 +1011,8 @@ ice_build_skb(struct ice_rx_ring *rx_ring, struct xdp_buff *xdp)
 					   nr_frags * xdp->frame_sz,
 					   xdp_buff_is_frag_pfmemalloc(xdp));
 
+	xdp_buff_update_skb(xdp, skb);
+
 	return skb;
 }
 
@@ -1092,6 +1094,8 @@ ice_construct_skb(struct ice_rx_ring *rx_ring, struct xdp_buff *xdp)
 					   xdp_buff_is_frag_pfmemalloc(xdp));
 	}
 
+	xdp_buff_update_skb(xdp, skb);
+
 	return skb;
 }
 
diff --git a/drivers/net/ethernet/intel/ice/ice_xsk.c b/drivers/net/ethernet/intel/ice/ice_xsk.c
index a3a4eaa17739ae084ccbe2cc75f3d10ca1be3fdc..84ff6b585967e04de3cdd6230ff7d1327c08fae0 100644
--- a/drivers/net/ethernet/intel/ice/ice_xsk.c
+++ b/drivers/net/ethernet/intel/ice/ice_xsk.c
@@ -573,6 +573,8 @@ ice_construct_skb_zc(struct ice_rx_ring *rx_ring, struct xdp_buff *xdp)
 		__skb_pull(skb, metasize);
 	}
 
+	xdp_buff_update_skb(xdp, skb);
+
 	if (likely(!xdp_buff_has_frags(xdp)))
 		goto out;
 

-- 
2.43.0


