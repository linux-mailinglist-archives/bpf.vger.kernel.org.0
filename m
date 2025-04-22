Return-Path: <bpf+bounces-56400-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65D4DA96C84
	for <lists+bpf@lfdr.de>; Tue, 22 Apr 2025 15:25:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 578F917CA42
	for <lists+bpf@lfdr.de>; Tue, 22 Apr 2025 13:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FEC628136C;
	Tue, 22 Apr 2025 13:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arthurfabre.com header.i=@arthurfabre.com header.b="RF/fhXHs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HZhKBBtO"
X-Original-To: bpf@vger.kernel.org
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C3662853F9;
	Tue, 22 Apr 2025 13:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745328254; cv=none; b=AzhcmQFASXK5iZJ6LPNhnUZh1e1bjsGa/LfZx3w2AcJhGnQlipbzJEsU2VLLyP6wO6/CFYMUdAj23uG4yx85e+zwOEbC5hEmjvrN8jdZtfCC77pKhb8pExe3Yi+KaxyPDmmeRwZ0IHVPU+u6NAsuQjAQeq1+XIJz2XoxlP24G/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745328254; c=relaxed/simple;
	bh=q4GUaExaie3z1Ull4nCxgRE7MIy6LIlrJnJWTerdalc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pIzUExe7NGqPPiEMxBOGVfjvD/q5/Jc6SdCy+D31Jz2q9GzEebXlKq1U52ofD2ZtlQ8ydLNkHI0jx7uBk9egxmzs3ab0Kvon/wN4UPp6M3d2iX0Qy8k1v17gF989lyGqhyKg4VwqXwiPWJ1V0tN4vumk7UnoI++Pbm/9AFYr4t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arthurfabre.com; spf=pass smtp.mailfrom=arthurfabre.com; dkim=pass (2048-bit key) header.d=arthurfabre.com header.i=@arthurfabre.com header.b=RF/fhXHs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HZhKBBtO; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arthurfabre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arthurfabre.com
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0FFF4254022C;
	Tue, 22 Apr 2025 09:24:12 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 22 Apr 2025 09:24:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arthurfabre.com;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm1;
	 t=1745328251; x=1745414651; bh=TElYhO7nk3tEjcHCCSJtvl693SL6r94S
	4Zl/EQWfu8w=; b=RF/fhXHs4mq2I+iKBc1ZlslBt/U/q8iPJ93/Jd7IaBRgMmjC
	8xGIoXvmHyN12Y0MABb0ntNuA/7QPYB5sJbczQ5xOdbbAM0319y/J0YEY7lduDln
	3fMtZrutgJJCoJ1hZ1FRlix+a2qf80BRiJrqrQloRtP0eceCcS3PgWaOwPB4A1rC
	MhCaT6VeG+Qky3nWblMwNzsnj4cvPgW7XMK57rVKmDF2GCXS6aufPQ8orWXv9gUx
	AopfgBQzw61hgpMcpIb2kaR3ZEPsjhPuyeLVdwXpkGYd1BRcK4zIh9NwXHT99MAn
	yntI4YR5RQDuwKwnmeapSiB82KCRyxKUbHtL9g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1745328251; x=
	1745414651; bh=TElYhO7nk3tEjcHCCSJtvl693SL6r94S4Zl/EQWfu8w=; b=H
	ZhKBBtOR84zEJ+Xy9IdTI6uFbIrFNcOc83zMFaI/Ybs71K18vVEKw+0H8niz5haj
	an5TR57hat1QFM5lxZKalEYEfGTaKE9C/caXdUIBObPi0dw8xRb18tde16bJr1p9
	2/S6fD8UarC7B4DUj7eqOO9/HvcrEjY2kAiKQNK63ow6inTxQiXJtItppTFz+h1z
	TIp1I/0NaeRI5cfVus578fQC4cB/IendA7TWszk5HH5tqFt2Bp9Xf2NR0NYzuCwN
	FYi6hsUdCEXkY+fZEG48WdKB3Us3roHvOfrAaRsmCZARqD4mFrdKcxCc0IlLFNeC
	csPY7W4Chxzd+0yKMd6mQ==
X-ME-Sender: <xms:e5gHaGQOJj92dluKPHWDaqFuPd0DcUNgj9wH2xC3xb5tTq98IiROHw>
    <xme:e5gHaLwUSFgnYpgfDRWjkMtVm7zhYiif5ZY_OOA0ubd1FH_QL7vUW298tq75EhAn0
    Ag7_uVxRv30be0oWSs>
X-ME-Received: <xmr:e5gHaD0UAnYlEMcZN1KodNmAfdFLyvdVD94FXUN6nn4Q8x4yZItbo2-6g7DzTpNzGWO3GjNPfe7K_nN5CTY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgeefkeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhff
    fugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheptehrthhhuhhrucfhrggs
    rhgvuceorghrthhhuhhrsegrrhhthhhurhhfrggsrhgvrdgtohhmqeenucggtffrrghtth
    gvrhhnpeejkeehffejvdefhedtleetgfeivdetgfefffetkeelieefvdefhfeuveevhffh
    ueenucevlhhushhtvghrufhiiigvpeegnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hthhhurhesrghrthhhuhhrfhgrsghrvgdrtghomhdpnhgspghrtghpthhtohepuddvpdhm
    ohguvgepshhmthhpohhuthdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohephigrnhestghlohhuughflhgrrhgvrdgtohhmpdhrtghpthhtohepnhgv
    thguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohephhgrfihksehkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhm
    pdhrtghpthhtohepthhhohhilhgrnhgusehrvgguhhgrthdrtghomhdprhgtphhtthhope
    hjsghrrghnuggvsghurhhgsegtlhhouhgufhhlrghrvgdrtghomhdprhgtphhtthhopegs
    phhfsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghstheskhgvrhhnvg
    hlrdhorhhg
X-ME-Proxy: <xmx:e5gHaCDYMPAK5QTKmPeh1GQwuGRgA0gVr1uA_1maJtLGE5WTWptcaA>
    <xmx:e5gHaPiJvGDqZAWDgP_9GEmhup7OzScaubGybAi3n2OuXOGImHPtTw>
    <xmx:e5gHaOoqwlVe_WbDpLDGSkVZ3EWdFrkNkEAZp5xv0-kZAycV_IMFNw>
    <xmx:e5gHaCgTkOT3NbPVBywyAP-NXbz4nkVn1yrWg1h6sLunasXmILSxWQ>
    <xmx:e5gHaKUS0tAf4PziurgZwxDW4JwzrLA-dHSgZ-IyWXvXFzL0tkMfaGWg>
Feedback-ID: i25f1493c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Apr 2025 09:24:10 -0400 (EDT)
From: Arthur Fabre <arthur@arthurfabre.com>
Date: Tue, 22 Apr 2025 15:23:38 +0200
Subject: [PATCH RFC bpf-next v2 09/17] trait: Store traits in sk_buff
 extension
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250422-afabre-traits-010-rfc2-v2-9-92bcc6b146c9@arthurfabre.com>
References: <20250422-afabre-traits-010-rfc2-v2-0-92bcc6b146c9@arthurfabre.com>
In-Reply-To: <20250422-afabre-traits-010-rfc2-v2-0-92bcc6b146c9@arthurfabre.com>
To: netdev@vger.kernel.org, bpf@vger.kernel.org
Cc: jakub@cloudflare.com, hawk@kernel.org, yan@cloudflare.com, 
 jbrandeburg@cloudflare.com, thoiland@redhat.com, lbiancon@redhat.com, 
 ast@kernel.org, kuba@kernel.org, edumazet@google.com, 
 Arthur Fabre <arthur@arthurfabre.com>
X-Mailer: b4 0.14.2

Use a bit in sk_buff to track whether or not an skb stores traits in
it's headroom.

It's tempting to store it in skb_shared_info like the XDP metadata,
but storing it in the skb allows us to more easily handle cases such as
skb clones in a few patches.

(I couldn't find an existing hole to use in sk_buff, so this makes a 4
byte hole... any pointers to a free bit?)

The following patches add support for handful of drivers, in the final
form we'd like to cover all drivers that currently support XDP metadata.

Signed-off-by: Arthur Fabre <arthur@arthurfabre.com>
---
 include/linux/skbuff.h | 11 +++++++++++
 include/net/xdp.h      | 21 +++++++++++++++++++++
 net/core/skbuff.c      |  4 ++++
 3 files changed, 36 insertions(+)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 4f325a1733f8be808345424f737df36e06d4cd98..ae569b1b1af83b586e1be6c69439ef74bac38cf3 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -39,6 +39,7 @@
 #include <net/net_debug.h>
 #include <net/dropreason-core.h>
 #include <net/netmem.h>
+#include <net/trait.h>
 
 /**
  * DOC: skb checksums
@@ -4835,6 +4836,7 @@ enum skb_ext_id {
 #if IS_ENABLED(CONFIG_MCTP_FLOWS)
 	SKB_EXT_MCTP,
 #endif
+	SKB_EXT_TRAITS,
 	SKB_EXT_NUM, /* must be last */
 };
 
@@ -4949,6 +4951,15 @@ static inline void skb_ext_copy(struct sk_buff *dst, const struct sk_buff *s) {}
 static inline bool skb_has_extensions(struct sk_buff *skb) { return false; }
 #endif /* CONFIG_SKB_EXTENSIONS */
 
+static inline void *skb_traits(const struct sk_buff *skb)
+{
+#ifdef CONFIG_SKB_EXTENSIONS
+	return skb_ext_find(skb, SKB_EXT_TRAITS);
+#else
+	return NULL;
+#endif
+}
+
 static inline void nf_reset_ct(struct sk_buff *skb)
 {
 #if defined(CONFIG_NF_CONNTRACK) || defined(CONFIG_NF_CONNTRACK_MODULE)
diff --git a/include/net/xdp.h b/include/net/xdp.h
index 0da1e87afdebfd4323d1944de65a6d63438209bf..cddd5b147cf81fa8afd820c9aa4b86d78958ac3d 100644
--- a/include/net/xdp.h
+++ b/include/net/xdp.h
@@ -127,6 +127,17 @@ static __always_inline void *xdp_buff_traits(const struct xdp_buff *xdp)
 	return xdp->data_hard_start + _XDP_FRAME_SIZE;
 }
 
+static __always_inline void __xdp_flags_update_skb(u32 flags, struct sk_buff *skb, void *traits)
+{
+	if (flags & XDP_FLAGS_TRAITS_SUPPORTED)
+		skb_ext_from_headroom(skb, SKB_EXT_TRAITS, _XDP_FRAME_SIZE, traits_size(traits));
+}
+
+static __always_inline void xdp_buff_update_skb(const struct xdp_buff *xdp, struct sk_buff *skb)
+{
+	__xdp_flags_update_skb(xdp->flags, skb, xdp_buff_traits(xdp));
+}
+
 static __always_inline void
 xdp_init_buff(struct xdp_buff *xdp, u32 frame_sz, struct xdp_rxq_info *rxq)
 {
@@ -302,6 +313,16 @@ xdp_frame_is_frag_pfmemalloc(const struct xdp_frame *frame)
 	return !!(frame->flags & XDP_FLAGS_FRAGS_PF_MEMALLOC);
 }
 
+static void *xdp_frame_traits(const struct xdp_frame *frame)
+{
+	return frame->data + _XDP_FRAME_SIZE;
+}
+
+static __always_inline void xdp_frame_update_skb(struct xdp_frame *frame, struct sk_buff *skb)
+{
+	__xdp_flags_update_skb(frame->flags, skb, xdp_frame_traits(frame));
+}
+
 #define XDP_BULK_QUEUE_SIZE	16
 struct xdp_frame_bulk {
 	int count;
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 34dae26dac4cea448f84dacabdc8fb6f4ac3c1a6..9f27caba82af0be7897b68b5fad087f3e9c62955 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -5043,6 +5043,10 @@ static const u8 skb_ext_type_len[] = {
 #if IS_ENABLED(CONFIG_MCTP_FLOWS)
 	[SKB_EXT_MCTP] = SKB_EXT_CHUNKSIZEOF(struct mctp_flow),
 #endif
+	/* TODO: skb_ext is slab allocated with room for all extensions,
+	 * this makes it a LOT bigger.
+	 */
+	[SKB_EXT_TRAITS] = SKB_EXT_CHUNKS(XDP_PACKET_HEADROOM),
 };
 
 static __always_inline unsigned int skb_ext_alloc_length(void)

-- 
2.43.0


