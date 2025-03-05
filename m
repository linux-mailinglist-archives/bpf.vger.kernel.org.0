Return-Path: <bpf+bounces-53336-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D513A5023B
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 15:37:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D9583B124D
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 14:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6054424887E;
	Wed,  5 Mar 2025 14:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arthurfabre.com header.i=@arthurfabre.com header.b="e/z4DcnZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="w79b3t6k"
X-Original-To: bpf@vger.kernel.org
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5202512EB;
	Wed,  5 Mar 2025 14:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741185227; cv=none; b=qf9+BgiyU2nFegDBSByfEu3I0Q0kIgEtDX+WoqKXZbz9LEPMNddif7Wp7bVOc5Rx58X4N8idOrvJd73gKglqArUJ/6DpvcFG2TFST2UVcUkXsiqq8BJeNIFYYgX+THjw9ufQNbydJ3sQPdES9vQDBqaM//gIUs5DnVnYpk0PQoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741185227; c=relaxed/simple;
	bh=aAWiz1/Yhp/NcPIDekOVc0qpgZDJ2ocfHx18Eg04Eos=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=c3e9ptTlegrhsz1gmq1lzBUkYhDIWTRr7AykE1fkzjJ8wNtO90cvQG4tEYjlqY0mwu/BLuDZkqNi0s9zj2r9oyEXY3uiJxwvmHgmk7qgBGgcmV7uRLdheUmHOg1fa0fMrewHfY/tZpXpLQU9+O7Z/FDOdmqW+ZvI9QGeihPnSkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arthurfabre.com; spf=pass smtp.mailfrom=arthurfabre.com; dkim=pass (2048-bit key) header.d=arthurfabre.com header.i=@arthurfabre.com header.b=e/z4DcnZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=w79b3t6k; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arthurfabre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arthurfabre.com
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 829F813826FD;
	Wed,  5 Mar 2025 09:33:45 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Wed, 05 Mar 2025 09:33:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arthurfabre.com;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm3;
	 t=1741185225; x=1741271625; bh=P8eFBWeyD2bEzgGdiWCgHYqErqW8eiFg
	374J4YEEeKg=; b=e/z4DcnZRHGAJsSfIPZ3ecQeNwHNrmBlfzqn7N7Wn01MWvvT
	0Sy2TgyrXDp3GL4ZOUwn4pTeegiHddpPAjrQ8k+9ZbYRjqdm9Zo+WX8yndP4acel
	PRYbSd5GhARqGMWrRSJcG60awibNySQi65tIH4FyqmTi46wBEd/3K7pk6L67ofnP
	HAPQ+3Qtpd8UbnUhmp6ltT0u9MJQrlP7WklKPvxeZh84O8YtMl+rOGTp7cyrW6sN
	pUj4x8RLj4LVeLYA8RytpQcMLM5lW4BkDJORf5+vlc8IPHz1D6S0ObhoSe8NFfQc
	/EwVL9po/wy22qNXbw6PRIsDSPj/dxPvKNv8xg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741185225; x=
	1741271625; bh=P8eFBWeyD2bEzgGdiWCgHYqErqW8eiFg374J4YEEeKg=; b=w
	79b3t6ki4fV4QlhttHJSMth0t0Q7j8VWdzIgdds53DRhohgoHNAqpvcv2ZG7e9+1
	S+GXXHqYqVuG8OPlctBtj2MKygkfkEcgzqUNjvvMP7GcVO9ohgoOKsnU4Sor3mly
	VukusamhVKMQTaEgxRM1YAK81AKBgBJh8D/14nk8X21bhNycJ4CQPwHbgpJORNPE
	v4rTwt2bl4Jr/hllaKcHWky8IA3DkaRaff1dz2IQdjBoBIN1B4aEhgQQymgzcy8Y
	WYtuL8xRR6xRNf2bvKLvminU38tPKabHGw/T40stDZfWjGLjhQg7PKxpBFxg7mUh
	9NOQ1DDJPVeV2uzSlmI4Q==
X-ME-Sender: <xms:yWDIZy_LQ4yU12XpEEJVPtzFpqcUH7b9Sbg9YwEO6T6nObeLy8HvTg>
    <xme:yWDIZyvZs_rhzDCDQMGJb6j1ONpFLltmS9OqMxCCyyD4s1UiKhgDk6e59STEiEmuq
    creqe6DBSPhd1chqFw>
X-ME-Received: <xmr:yWDIZ4BxtMg2iYILl8WS6p3akrBZOjHfA0F7H6v-bt55fcUNFLP7noxaUlij-nDghQhauEimT8qXAwJbjUY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdehtdekucetufdoteggodetrf
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
X-ME-Proxy: <xmx:yWDIZ6e_sHlh4Eb3ZTVlrSSzv7Rjc1SPJhyAcb1KAmgfjqIY4eMISQ>
    <xmx:yWDIZ3NoqVhsKzSVkKTNvZMXa5kk0tzJaq9ool0LAdsszHQNSdYAEg>
    <xmx:yWDIZ0ln43i8ygxqKBLhNoXjemJA_YbcpC39ndxN0RSTm5Dj4s86NA>
    <xmx:yWDIZ5shiL8fjXxq_Uxozzy-jqy6FOWTGSLc2F2PCTeO57YSalstfQ>
    <xmx:yWDIZyoYIdwxY1OAB5PoacU_cPBhZIwAMFaoIXZFknb3xYbmfuBVAGqJ>
Feedback-ID: i25f1493c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Mar 2025 09:33:43 -0500 (EST)
From: arthur@arthurfabre.com
Date: Wed, 05 Mar 2025 15:32:13 +0100
Subject: [PATCH RFC bpf-next 16/20] trait: Support sk_buffs
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250305-afabre-traits-010-rfc2-v1-16-d0ecfb869797@cloudflare.com>
References: <20250305-afabre-traits-010-rfc2-v1-0-d0ecfb869797@cloudflare.com>
In-Reply-To: <20250305-afabre-traits-010-rfc2-v1-0-d0ecfb869797@cloudflare.com>
To: netdev@vger.kernel.org, bpf@vger.kernel.org
Cc: jakub@cloudflare.com, hawk@kernel.org, yan@cloudflare.com, 
 jbrandeburg@cloudflare.com, thoiland@redhat.com, lbiancon@redhat.com, 
 Arthur Fabre <afabre@cloudflare.com>
X-Mailer: b4 0.14.2

From: Arthur Fabre <afabre@cloudflare.com>

Hide the space used by traits from skb_headroom(): that space isn't
actually usable.

Preserve the trait store in pskb_expand_head() by copying it ahead of
the new headroom. The struct xdp_frame at the start of the headroom
isn't needed anymore, so we can overwrite it with traits, and introduce
a new flag to indicate traits are stored at the start of the headroom.

Cloned skbs share the same packet data and headroom as the original skb,
so changes to traits in one would be reflected in the other.
Is that ok?
Are there cases where we would want a clone to have different traits?
For now, prevent clones from using traits.

Signed-off-by: Arthur Fabre <afabre@cloudflare.com>
---
 include/linux/skbuff.h | 25 +++++++++++++++++++++++--
 net/core/skbuff.c      | 25 +++++++++++++++++++++++--
 2 files changed, 46 insertions(+), 4 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index d7dfee152ebd26ce87a230222e94076aca793adc..886537508789202339c925b5613574de67b7e43c 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -39,6 +39,7 @@
 #include <net/net_debug.h>
 #include <net/dropreason-core.h>
 #include <net/netmem.h>
+#include <net/trait.h>
 
 /**
  * DOC: skb checksums
@@ -729,6 +730,8 @@ enum skb_traits_type {
 	SKB_TRAITS_NONE,
 	/* Trait store in headroom, offset by sizeof(struct xdp_frame) */
 	SKB_TRAITS_AFTER_XDP,
+	/* Trait store at start of headroom */
+	SKB_TRAITS_AT_HEAD,
 };
 
 /**
@@ -1029,7 +1032,7 @@ struct sk_buff {
 	__u8			csum_not_inet:1;
 #endif
 	__u8			unreadable:1;
-	__u8			traits_type:1;	/* See enum skb_traits_type */
+	__u8			traits_type:2;	/* See enum skb_traits_type */
 #if defined(CONFIG_NET_SCHED) || defined(CONFIG_NET_XGRESS)
 	__u16			tc_index;	/* traffic control index */
 #endif
@@ -2836,6 +2839,18 @@ static inline void *pskb_pull(struct sk_buff *skb, unsigned int len)
 
 void skb_condense(struct sk_buff *skb);
 
+static inline void *skb_traits(const struct sk_buff *skb)
+{
+	switch (skb->traits_type) {
+	case SKB_TRAITS_AFTER_XDP:
+		return skb->head + _XDP_FRAME_SIZE;
+	case SKB_TRAITS_AT_HEAD:
+		return skb->head;
+	default:
+		return NULL;
+	}
+}
+
 /**
  *	skb_headroom - bytes at buffer head
  *	@skb: buffer to check
@@ -2844,7 +2859,13 @@ void skb_condense(struct sk_buff *skb);
  */
 static inline unsigned int skb_headroom(const struct sk_buff *skb)
 {
-	return skb->data - skb->head;
+	int trait_size = 0;
+	void *traits = skb_traits(skb);
+
+	if (traits)
+		trait_size = traits_size(traits);
+
+	return skb->data - skb->head - trait_size;
 }
 
 /**
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 7b03b64fdcb276f68ce881d1d8da8e4c6b897efc..83f58517738e8ff12990c28b09336ed44f4be32a 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -1515,6 +1515,19 @@ static struct sk_buff *__skb_clone(struct sk_buff *n, struct sk_buff *skb)
 	atomic_inc(&(skb_shinfo(skb)->dataref));
 	skb->cloned = 1;
 
+	/* traits would end up shared with the clone,
+	 * and edits would be reflected there.
+	 *
+	 * Is that ok? What if the original skb and the clone take different paths?
+	 * Does that even happen?
+	 *
+	 * If that's not ok, we could copy the traits and store them in an extension header
+	 * for clones.
+	 *
+	 * For now, pretend the clone doesn't have any traits.
+	 */
+	skb->traits_type = SKB_TRAITS_NONE;
+
 	return n;
 #undef C
 }
@@ -2170,7 +2183,7 @@ int pskb_expand_head(struct sk_buff *skb, int nhead, int ntail,
 	unsigned int osize = skb_end_offset(skb);
 	unsigned int size = osize + nhead + ntail;
 	long off;
-	u8 *data;
+	u8 *data, *head;
 	int i;
 
 	BUG_ON(nhead < 0);
@@ -2187,10 +2200,18 @@ int pskb_expand_head(struct sk_buff *skb, int nhead, int ntail,
 		goto nodata;
 	size = SKB_WITH_OVERHEAD(size);
 
+	head = skb->head;
+	if (skb->traits_type != SKB_TRAITS_NONE) {
+		head = skb_traits(skb) + traits_size(skb_traits(skb));
+		/* struct xdp_frame isn't needed in the headroom, drop it */
+		memcpy(data, skb_traits(skb), traits_size(skb_traits(skb)));
+		skb->traits_type = SKB_TRAITS_AT_HEAD;
+	}
+
 	/* Copy only real data... and, alas, header. This should be
 	 * optimized for the cases when header is void.
 	 */
-	memcpy(data + nhead, skb->head, skb_tail_pointer(skb) - skb->head);
+	memcpy(data + nhead, head, skb_tail_pointer(skb) - head);
 
 	memcpy((struct skb_shared_info *)(data + size),
 	       skb_shinfo(skb),

-- 
2.43.0


