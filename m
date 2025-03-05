Return-Path: <bpf+bounces-53328-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6E3FA5021E
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 15:35:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 635F43B1BCD
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 14:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A2CF2500CF;
	Wed,  5 Mar 2025 14:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arthurfabre.com header.i=@arthurfabre.com header.b="uU6UodM0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ugSko2eY"
X-Original-To: bpf@vger.kernel.org
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892CB24FC0A;
	Wed,  5 Mar 2025 14:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741185214; cv=none; b=nSajZp2PYiWJdUTHkFoRCxYomxwk6SxKqEVeVM5+EvuF/t/RlZFgVzHOxhASUGDvuQyQJLP5GRBvmOzjRsapcqyE+wdr3ybOmQk5TyUtuCLiL+hLZk9ZWiwxf5q9xtMfuHrWPDzbaVfcVsOhS2zb7Mny7XjDFvWzbiJrateFIUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741185214; c=relaxed/simple;
	bh=mfUsoO14IQldAwz5DqUWP3X3/mCdwxyhS+11WgRQ2tY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oS7dSZmfUwzbnkEVvsOmnpN/EBiG/TCPlCWlpMEFGUX19oMh8NOw61zwhYb6rwz/IW9I/YVgmsuVAL6IxLSFHRLjw1J7Uwwf3jmDLoBpEIchCcXugOEbU/VB1Dp2vzZZy/8zrXdwRw9uqEOeOXG7RIFY/TqyiMyWtM/4RCaQG0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arthurfabre.com; spf=pass smtp.mailfrom=arthurfabre.com; dkim=pass (2048-bit key) header.d=arthurfabre.com header.i=@arthurfabre.com header.b=uU6UodM0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ugSko2eY; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arthurfabre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arthurfabre.com
Received: from phl-compute-13.internal (phl-compute-13.phl.internal [10.202.2.53])
	by mailfout.phl.internal (Postfix) with ESMTP id 8E08913826DD;
	Wed,  5 Mar 2025 09:33:31 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-13.internal (MEProxy); Wed, 05 Mar 2025 09:33:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arthurfabre.com;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm3;
	 t=1741185211; x=1741271611; bh=+eymztBpYrvjHP3XdFqYJYpwv+edl3BS
	3I768fbcNog=; b=uU6UodM03rWydn7xtKs6ywIw/TsLldGy+LHIegx3kEJhUmyH
	CQ7Is4o/AfDzlgL8WaEncB+Tcaej8qFgD9xkGwmRyD8H+3HM79sZaMlJD3duidZ7
	4qbCSvLwTtmkT3qDJqoVXrT/qI+gebrCz4AlJuYX4KwttI/GIW+FKfkXmKsUgZra
	jY3D9gtVgq9f6/2Jq9XIfAhgur5unZhz3hCmIvDxaslpKxJh8JXu+G7DmRrX2LGc
	edSXgDT7Fuvh7+CJc23Dzs3xG2mVOGxmBGS29coxPz9ZoLAC797QhG7j62b9uJ6R
	f1U6F+F1t5a6idtHlFsRqgO7TZvicBYjDGAdcg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741185211; x=
	1741271611; bh=+eymztBpYrvjHP3XdFqYJYpwv+edl3BS3I768fbcNog=; b=u
	gSko2eYyNIs7gdt2C8sLhjMQB6v3gfuWXUwuothMtQMz4ligJCM0+RSfjeDSdG7/
	wlOS8zsGF+pGXnZQmFXDD/H84h+UA9v+pyq6w+C7KRDrLinAMVmVfZhOsn4f1c91
	h9V7U8iw/8/ztkoBzbPuU/hrxH7sjlbRsCxAkJwAZIsU9FEwZ5Wpwzfaba2go7PR
	nQYd7YRuwSk/55s7WkqsygtIUmYu70uXOgSsq4PVy8USn5SDzl8DrIi1bdcy+9bp
	Fukf04Oh/i2A/QNOEN0hAToXM1qzLq6myHA8NFIKBmIkj6TUSIgyCaxoyHUhM2o8
	pnuAubSqXmcbzlfsKsZow==
X-ME-Sender: <xms:u2DIZzaIriH4R49D2moBj63VKBXi4gtTb7vBxVGyZwGH0_p3OI4imA>
    <xme:u2DIZyafbtOWhPaHjMK4imgYi-y1qblVZXL0sGGFgu-Qnt1F4W-sLMkzyCas8v5cE
    XdkrwdpF6qHZmeGjZg>
X-ME-Received: <xmr:u2DIZ18_fgvJtHmPvQBOaK7GZE_RawIATlcLYFHXEVkNzGFc8tvR0FUluyRHb0xVSoxxuxNQStyfQfzG9oM>
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
X-ME-Proxy: <xmx:u2DIZ5rBJ2RxvhKr-jbbH7BerxDvWWcEn55HSWsm3uR9S0bJ3gJA_Q>
    <xmx:u2DIZ-qOGZ9gn-COq2r4tVxTGh5khyqhQP0UPSClOi3wPDUurTOAkQ>
    <xmx:u2DIZ_Sx5uBhjUEpEXbUYCvYnrMaz-_bvR6prReK2h5hUZBQryTN_w>
    <xmx:u2DIZ2qOqB2bdgVnyUhY5fBG0Y2JuZWGfkQInL1_D2mSJS2__Sa_pQ>
    <xmx:u2DIZ918eFQ5qQ6m-5baoOAPeOhBEActxp9riwpwAOdkSaNybRcQYQzf>
Feedback-ID: i25f1493c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Mar 2025 09:33:29 -0500 (EST)
From: arthur@arthurfabre.com
Date: Wed, 05 Mar 2025 15:32:05 +0100
Subject: [PATCH RFC bpf-next 08/20] trait: Propagate presence of traits to
 sk_buff
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250305-afabre-traits-010-rfc2-v1-8-d0ecfb869797@cloudflare.com>
References: <20250305-afabre-traits-010-rfc2-v1-0-d0ecfb869797@cloudflare.com>
In-Reply-To: <20250305-afabre-traits-010-rfc2-v1-0-d0ecfb869797@cloudflare.com>
To: netdev@vger.kernel.org, bpf@vger.kernel.org
Cc: jakub@cloudflare.com, hawk@kernel.org, yan@cloudflare.com, 
 jbrandeburg@cloudflare.com, thoiland@redhat.com, lbiancon@redhat.com, 
 Arthur Fabre <afabre@cloudflare.com>
X-Mailer: b4 0.14.2

From: Arthur Fabre <afabre@cloudflare.com>

Use a bit in sk_buff to track whether or not an skb stores traits in
it's headroom.

It's tempting to store it in skb_shared_info like the XDP metadata,
but storing it in the skb allows us to more easily handle cases such as
skb clones in a few patches.

(I couldn't find an existing hole to use in sk_buff, so this makes a 4
byte hole... any pointers to a free bit?)

The following patches add support for handful of drivers, in the final
form we'd like to cover all drivers that currently support XDP metadata.

Signed-off-by: Arthur Fabre <afabre@cloudflare.com>
---
 include/linux/skbuff.h |  7 +++++++
 include/net/xdp.h      | 12 ++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 03553c2200ab1c3750b799edb94fa3b94e11a5f1..d7dfee152ebd26ce87a230222e94076aca793adc 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -725,6 +725,12 @@ enum skb_tstamp_type {
 	__SKB_CLOCK_MAX = SKB_CLOCK_TAI,
 };
 
+enum skb_traits_type {
+	SKB_TRAITS_NONE,
+	/* Trait store in headroom, offset by sizeof(struct xdp_frame) */
+	SKB_TRAITS_AFTER_XDP,
+};
+
 /**
  * DOC: Basic sk_buff geometry
  *
@@ -1023,6 +1029,7 @@ struct sk_buff {
 	__u8			csum_not_inet:1;
 #endif
 	__u8			unreadable:1;
+	__u8			traits_type:1;	/* See enum skb_traits_type */
 #if defined(CONFIG_NET_SCHED) || defined(CONFIG_NET_XGRESS)
 	__u16			tc_index;	/* traffic control index */
 #endif
diff --git a/include/net/xdp.h b/include/net/xdp.h
index 84afe07d09efdb2ab0cb78b904f02cb74f9a56b6..e2e7c270efa3cbd11bddd234010b91daee5009a2 100644
--- a/include/net/xdp.h
+++ b/include/net/xdp.h
@@ -119,6 +119,12 @@ static __always_inline void xdp_buff_set_frag_pfmemalloc(struct xdp_buff *xdp)
 static bool xdp_data_meta_unsupported(const struct xdp_buff *xdp);
 static void xdp_set_data_meta_invalid(struct xdp_buff *xdp);
 
+static __always_inline void xdp_buff_update_skb(struct xdp_buff *xdp, struct sk_buff *skb)
+{
+	if (!xdp_data_meta_unsupported(xdp))
+		skb->traits_type = SKB_TRAITS_AFTER_XDP;
+}
+
 static __always_inline void *xdp_buff_traits(const struct xdp_buff *xdp)
 {
 	return xdp->data_hard_start + _XDP_FRAME_SIZE;
@@ -298,6 +304,12 @@ xdp_frame_is_frag_pfmemalloc(const struct xdp_frame *frame)
 	return !!(frame->flags & XDP_FLAGS_FRAGS_PF_MEMALLOC);
 }
 
+static __always_inline void xdp_frame_update_skb(struct xdp_frame *frame, struct sk_buff *skb)
+{
+	if (!frame->meta_unsupported)
+		skb->traits_type = SKB_TRAITS_AFTER_XDP;
+}
+
 #define XDP_BULK_QUEUE_SIZE	16
 struct xdp_frame_bulk {
 	int count;

-- 
2.43.0


