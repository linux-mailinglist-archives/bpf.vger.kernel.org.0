Return-Path: <bpf+bounces-53337-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7BDDA50231
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 15:36:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7B7E16DA8F
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 14:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F32EB2517B9;
	Wed,  5 Mar 2025 14:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arthurfabre.com header.i=@arthurfabre.com header.b="jvEzpgfG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NQijt9bL"
X-Original-To: bpf@vger.kernel.org
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0057F251796;
	Wed,  5 Mar 2025 14:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741185229; cv=none; b=R6ebViwLPIFgtqw+0u46JlRtd4imM6TsRhTUMejYAi2fbosI3jFMJYg6p0/6YCGEaTCjeOtopu6KdsXRusi5TS/ZQJiyYNtBkbkl1BQPXdcbKuu5aAYD6C4ar8M3D1VZ1NiWXpAI+UWyLugobZBjvae5bpvKWx8d4Gowcu8EBv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741185229; c=relaxed/simple;
	bh=RcDbTovihb8NIypJgTsn+XIWRQ7sPppDg7Sd/mECLjw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nANRAV2K7pTP6g1J8pznCLbq3rcosiV9DJnmT3c+09kbreisze5GBrmlOTNS8kgZN8W0fnh4qulVI0ZCAxO5ob9pLUZzywHRwJjFW61FXVeQd41VNAr+oHXRbUXuKeCkDZxH0qyx1u3p7W6IEZEjcjdMpw3fYbvnBX1Gfb3JNag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arthurfabre.com; spf=pass smtp.mailfrom=arthurfabre.com; dkim=pass (2048-bit key) header.d=arthurfabre.com header.i=@arthurfabre.com header.b=jvEzpgfG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NQijt9bL; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arthurfabre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arthurfabre.com
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 29281114024E;
	Wed,  5 Mar 2025 09:33:47 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Wed, 05 Mar 2025 09:33:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arthurfabre.com;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm3;
	 t=1741185227; x=1741271627; bh=H3Q3mi5j6Eq1sW1Wo8iuFfIlsWGGiFrH
	jtw00R758tk=; b=jvEzpgfGGddXOe+RXC06NBvj77/3ApIUM3Kn6BWExI0r3O63
	9KwmdRYdMy/9Hy7nkGa/URAihXSnxJeU4qMPT4OywfFm4yjnObB7U1QNgfx9GDVF
	jiWP0dLhJhnoFhc1ltyFX3NsFZfXuhNTzEhzIxqrmbGf7FLt5KJddo+24GBzQZdF
	vP0W/k7YbNDj3F0GdwYbs6lOOpsBEa2EMH4ClzcumNKE+ZoEEU1G2ljW8BM6dmEq
	/XoYjpNolMqU4Pu6MsE+oxY1K0j2XEtlQy2dZsDOT1a4vLSHUU8Vfuxpd9j5Cyp6
	YYIA97wve/AHSyB4QHZxPj2Wk7+gCU+1Kk7gCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741185227; x=
	1741271627; bh=H3Q3mi5j6Eq1sW1Wo8iuFfIlsWGGiFrHjtw00R758tk=; b=N
	Qijt9bLdnAGskPWmyPMyDAwpHvjmoFjstzqBwNMlr/IYPls0a3H6QGichYS7I0Rk
	2aF+QunffpEtVZd8JODckhC2/9ErVupf8MTbK+fVqLvH8CfIvOK+IiGqadRLQCss
	xk0pa9n70UoVjps/MePn+ZWfmpvuyFI7UXYZ3Bj+5uVkIkT94ooPn7G3M1UxmXvW
	XWGtaf8UbFaAtOMqSh463FbuTHDwuCHj8rq4N4hsPBiilT/lqyiaRFzic1DCfaY5
	zCg/qO62A9GQ18Qc1zUQ1d4jkRFWssQCcPxmdhqVmI0shWVeDUh8Jbm50hDjzXCR
	d4rNdcDXEA8lyg6vYtLUA==
X-ME-Sender: <xms:ymDIZ86enD7Cn0OdLFEMIswYAIOTUf1Uf5N7sN4l1Sg3bVcRsgIeJQ>
    <xme:ymDIZ97NOrHx_q_szMuNG-18E1vls2ffgyBBnVWYMHuH9mEeB318XeOs4RGR1SLk4
    SlevGXK1ZbeHzIwdzY>
X-ME-Received: <xmr:ymDIZ7dzB481Pfo2zenb-KUnEaB8nWMd2P3VUFhyG3KK5URPVCs-z9FgvNzkwjLvbDtut5r7QjlP5Hfpiog>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdehtdejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpegrrhhthhhurhesrghrthhhuhhrfhgrsghrvgdrtghomhenucggtf
    frrghtthgvrhhnpeffueehtddtkeetgfelteejledvjeekgeduleffjeetfeekveeggffh
    fefhvdegffenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpegrrhhthhhurhesrghrthhhuhhrfhgrsghrvgdrtghomhdpnhgspghrtghpthhtohep
    ledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepthhhohhilhgrnhgusehrvgguhh
    grthdrtghomhdprhgtphhtthhopehlsghirghntghonhesrhgvughhrghtrdgtohhmpdhr
    tghpthhtohephhgrfihksehkvghrnhgvlhdrohhrghdprhgtphhtthhopegsphhfsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghfrggsrhgvsegtlhhouhgufhhl
    rghrvgdrtghomhdprhgtphhtthhopehjrghkuhgssegtlhhouhgufhhlrghrvgdrtghomh
    dprhgtphhtthhopeihrghnsegtlhhouhgufhhlrghrvgdrtghomhdprhgtphhtthhopehn
    vghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjsghrrghnug
    gvsghurhhgsegtlhhouhgufhhlrghrvgdrtghomh
X-ME-Proxy: <xmx:y2DIZxIbujuWhSEYGlYGoJP0t9q8EyjK5x5SiRlXdR2n6RGYs7VNlw>
    <xmx:y2DIZwJ3a2_upVpDSq_8TkfRwvZ8qV3-Rk1uJYYw22l_HE__VLt94g>
    <xmx:y2DIZywUbPAcJtE9nNVJ4so7PEVmYPS5Lyv1v25kMRjSFtsO1eKTnA>
    <xmx:y2DIZ0KwUatc8k9PIBXRabTJzrs57dJD4GVohiYfHyFHPqihl6ViNg>
    <xmx:y2DIZ1UktL_Ejx0lXxeXYwWBut6d8D_NR5QlIMGB4KuNTCrtUk7I33D->
Feedback-ID: i25f1493c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Mar 2025 09:33:45 -0500 (EST)
From: arthur@arthurfabre.com
Date: Wed, 05 Mar 2025 15:32:14 +0100
Subject: [PATCH RFC bpf-next 17/20] trait: Allow socket filters to access
 traits
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250305-afabre-traits-010-rfc2-v1-17-d0ecfb869797@cloudflare.com>
References: <20250305-afabre-traits-010-rfc2-v1-0-d0ecfb869797@cloudflare.com>
In-Reply-To: <20250305-afabre-traits-010-rfc2-v1-0-d0ecfb869797@cloudflare.com>
To: netdev@vger.kernel.org, bpf@vger.kernel.org
Cc: jakub@cloudflare.com, hawk@kernel.org, yan@cloudflare.com, 
 jbrandeburg@cloudflare.com, thoiland@redhat.com, lbiancon@redhat.com, 
 Arthur Fabre <afabre@cloudflare.com>
X-Mailer: b4 0.14.2

From: Arthur Fabre <afabre@cloudflare.com>

Add kfuncs to allow socket filter programs access to traits in an skb.

Signed-off-by: Arthur Fabre <afabre@cloudflare.com>
---
 net/core/filter.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index 79b78e7cd57fd78c6cc8443da54ae96408c496b0..47f18fb0e23c2c19d26f9b408653c6756a5110c7 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -12063,6 +12063,39 @@ __bpf_kfunc int bpf_sk_assign_tcp_reqsk(struct __sk_buff *s, struct sock *sk,
 #endif
 }
 
+__bpf_kfunc int bpf_skb_trait_set(const struct sk_buff *skb, u64 key,
+				  const void *val, u64 val__sz, u64 flags)
+{
+	void *traits = skb_traits(skb);
+
+	if (!traits)
+		return -EOPNOTSUPP;
+
+	return trait_set(traits, skb_metadata_end(skb) - skb_metadata_len(skb),
+			 key, val, val__sz, flags);
+}
+
+__bpf_kfunc int bpf_skb_trait_get(const struct sk_buff *skb, u64 key,
+				  void *val, u64 val__sz)
+{
+	void *traits = skb_traits(skb);
+
+	if (!traits)
+		return -EOPNOTSUPP;
+
+	return trait_get(traits, key, val, val__sz);
+}
+
+__bpf_kfunc int bpf_skb_trait_del(const struct sk_buff *skb, u64 key)
+{
+	void *traits = skb_traits(skb);
+
+	if (!traits)
+		return -EOPNOTSUPP;
+
+	return trait_del(traits, key);
+}
+
 __bpf_kfunc_end_defs();
 
 int bpf_dynptr_from_skb_rdonly(struct __sk_buff *skb, u64 flags,
@@ -12082,6 +12115,9 @@ int bpf_dynptr_from_skb_rdonly(struct __sk_buff *skb, u64 flags,
 
 BTF_KFUNCS_START(bpf_kfunc_check_set_skb)
 BTF_ID_FLAGS(func, bpf_dynptr_from_skb, KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_skb_trait_set)
+BTF_ID_FLAGS(func, bpf_skb_trait_get)
+BTF_ID_FLAGS(func, bpf_skb_trait_del)
 BTF_KFUNCS_END(bpf_kfunc_check_set_skb)
 
 BTF_KFUNCS_START(bpf_kfunc_check_set_xdp)

-- 
2.43.0


