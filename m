Return-Path: <bpf+bounces-53331-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 204C5A50226
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 15:36:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F32C3B2311
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 14:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA05424E4A8;
	Wed,  5 Mar 2025 14:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arthurfabre.com header.i=@arthurfabre.com header.b="YHCL16gK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="l6L4eZlD"
X-Original-To: bpf@vger.kernel.org
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3FD32505A3;
	Wed,  5 Mar 2025 14:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741185219; cv=none; b=Rr3xBUfo+uJxpNFJ0NX6ibENrCd4NUvXrVVeuh2kPqXQd/9PYF+4LcxO3qzl+aGHreHnSQ+/Og8orGFFasty4NlzXnbyLfB1CsXN3Y0D0Y3XNHB35K/3afJc0n4c9UkdUfc+1eYQSAYhXnqOd6FJl6Vx59Ou5sRP4u3h0w0Nh1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741185219; c=relaxed/simple;
	bh=5A2BC89iPT2R5CsY1G6WWz1zdKXqY9Sc7caSn5kzKnw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HvqFI0IR3UGE+7TAHauZoyae4N02m3vsITVMyh+Dh0j27a4niMnip6bTPbLr0sNVuKmiyUMH79Z3wL0TOC+Szrq6mj/Y0YQrZc0Vm9WN/Tz8cGvOOg62TVcV92DLt3B3m1OK6y60FVX9B/I8izkHl1RYcfUsy05BophcsdDoP+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arthurfabre.com; spf=pass smtp.mailfrom=arthurfabre.com; dkim=pass (2048-bit key) header.d=arthurfabre.com header.i=@arthurfabre.com header.b=YHCL16gK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=l6L4eZlD; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arthurfabre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arthurfabre.com
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D271511401F8;
	Wed,  5 Mar 2025 09:33:36 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Wed, 05 Mar 2025 09:33:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arthurfabre.com;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm3;
	 t=1741185216; x=1741271616; bh=T1TDGy+aGcL5GXLTKfJf+nXwA5yAxBek
	JCkVmMjW4vg=; b=YHCL16gKwqO9rU15UUxLcvEo8CCLTbTTuqUqynkNpi8tFSyT
	s/m2A/9goz1Ar0NWiFFrUfmj81M9R+l4Usn0AlxpRHXWYL3vf6gAFegbHv8nCro0
	XXnNUOrfyuFN5xu3EYvLwvAwYfGm2baEY3Dx5vB8Ze5osXIxiqdWT6ssDtCyb49Z
	tk1fi9LRJLw6b2Xs5HKpq7LFX0l2UKbx9rP2wepwW05GiayU9zCZ/232MLUNwEdY
	IqJ4xjPBeZ+ZJybNcTuvGZXTmxdEurkdiolmES9JaP4rNkzmcL7xX2cG8ph9He+s
	C6bWM2jpEb2qOkG1L2BkUbxTr5EzYRmJvvhVuA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741185216; x=
	1741271616; bh=T1TDGy+aGcL5GXLTKfJf+nXwA5yAxBekJCkVmMjW4vg=; b=l
	6L4eZlDsSHA9mN+DO2BseRLK83gHChJlVt1YGhpYF9+QO8lH4CMcsknI4bP2jYnl
	WCQU3K5jE+J56ptngb9LTnVIHXTZ5oKTlqHmbBWeqdxl2cvZULOBQkX4aBG7gA3D
	4pNrXyXQuCk6vy4i8uA/5m6wE5OUnZbVdCW8iGPNFpJLJiU35VL4QRTh9dfrmxF0
	Xg40AojCCgFAnfgAwHsXO7GFzilESVsU3LX3ChxVPaj8uiHWEmX3u5B1HjdgAqF0
	lSr4onfOPbjkxwPoaYpmmLL6uWfVKHpOdnu9vxgEVWxYnXxrVpJI0vMIE4yrwmBO
	x7QJgYyD4XhSF/sDpyy4g==
X-ME-Sender: <xms:wGDIZ93QpdfItKttn7XIJMbQr_w7gpue64QrOHYAwhmHNFF-8JN-fw>
    <xme:wGDIZ0GY8kQZFcqM1a0h5RbvytuXXxvk1QRpEXNr2HZGbpClVOxQNahSM6ooqZKcs
    _X7hON6eun7_5mQv9M>
X-ME-Received: <xmr:wGDIZ96RYQHUFzlBviu9DRMBwOCD8lh0tLHT--tnoSYXNLMBAJNgjlJ31J0WrlrPnms0Yz4QV1cusCD3oiU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdehtdejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpegrrhhthhhurhesrghrthhhuhhrfhgrsghrvgdrtghomhenucggtf
    frrghtthgvrhhnpeffueehtddtkeetgfelteejledvjeekgeduleffjeetfeekveeggffh
    fefhvdegffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpegrrhhthhhurhesrghrthhhuhhrfhgrsghrvgdrtghomhdpnhgspghrtghpthhtohep
    ledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepthhhohhilhgrnhgusehrvgguhh
    grthdrtghomhdprhgtphhtthhopehlsghirghntghonhesrhgvughhrghtrdgtohhmpdhr
    tghpthhtohephhgrfihksehkvghrnhgvlhdrohhrghdprhgtphhtthhopegsphhfsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghfrggsrhgvsegtlhhouhgufhhl
    rghrvgdrtghomhdprhgtphhtthhopehjrghkuhgssegtlhhouhgufhhlrghrvgdrtghomh
    dprhgtphhtthhopeihrghnsegtlhhouhgufhhlrghrvgdrtghomhdprhgtphhtthhopehn
    vghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjsghrrghnug
    gvsghurhhgsegtlhhouhgufhhlrghrvgdrtghomh
X-ME-Proxy: <xmx:wGDIZ637I4FKGSzkXiWAOeiN5Y78GSLko6aF9i-D6QIY94_zyEqooQ>
    <xmx:wGDIZwFbL5Y1oREs6_ObKvz7kRlWyYzGQoPjnfYd1ZML-eVWkkUZvg>
    <xmx:wGDIZ79Bv8EpHaQdiZUQZaXpkwNA_N9RT6DbFwIZEozBVWj75C9mnQ>
    <xmx:wGDIZ9kpMgTgaGMy1-pYUn5uhiYyoltpUW7jdzmZyHnmV3cBFqIfug>
    <xmx:wGDIZ7BhkxlDxYSuLnD9ZxRsdnchrW7uQ87uZE99cw82izzkjUb_9Upy>
Feedback-ID: i25f1493c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Mar 2025 09:33:35 -0500 (EST)
From: arthur@arthurfabre.com
Date: Wed, 05 Mar 2025 15:32:08 +0100
Subject: [PATCH RFC bpf-next 11/20] veth: Propagate trait presence to skb
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250305-afabre-traits-010-rfc2-v1-11-d0ecfb869797@cloudflare.com>
References: <20250305-afabre-traits-010-rfc2-v1-0-d0ecfb869797@cloudflare.com>
In-Reply-To: <20250305-afabre-traits-010-rfc2-v1-0-d0ecfb869797@cloudflare.com>
To: netdev@vger.kernel.org, bpf@vger.kernel.org
Cc: jakub@cloudflare.com, hawk@kernel.org, yan@cloudflare.com, 
 jbrandeburg@cloudflare.com, thoiland@redhat.com, lbiancon@redhat.com, 
 Arthur Fabre <afabre@cloudflare.com>
X-Mailer: b4 0.14.2

From: Arthur Fabre <afabre@cloudflare.com>

Call the common xdp_buff_update_skb() / xdp_frame_update_skb() helpers.

Signed-off-by: Arthur Fabre <afabre@cloudflare.com>
---
 drivers/net/veth.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index 01251868a9c27592f0dfbcdc32c0afbd7e9baafc..186ea9e09efbcb6abb01effcec5f7d03a186cefe 100644
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


