Return-Path: <bpf+bounces-56408-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A7E96A96CA1
	for <lists+bpf@lfdr.de>; Tue, 22 Apr 2025 15:27:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E27C7AB831
	for <lists+bpf@lfdr.de>; Tue, 22 Apr 2025 13:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D72C28C5D5;
	Tue, 22 Apr 2025 13:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arthurfabre.com header.i=@arthurfabre.com header.b="JS2+1Mdb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ExrlHV+z"
X-Original-To: bpf@vger.kernel.org
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7AE28CF48;
	Tue, 22 Apr 2025 13:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745328274; cv=none; b=p+KNDUeo1oOQcsVQzUKihlHQyZmYrn4JM6Tq718OjQCCCTNPt39/jsX8xGPvSmerWm8DfUoAXiGVpnHIUomBiAE77y/D9hEdzBH2rT/G3spkSuGLCy7h+VGjHYr3VTTBeptvbe9DAanQu8xkfnahGXDgJ1GQkljUqgkjn7p6+ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745328274; c=relaxed/simple;
	bh=/2Yw9TRyl4gSzs/TF0L8RweFO2kHkMY05k8f34b6AnM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ab88QXL0eB+3Gk0XtGwUef1C7jWBWieDgxzWI9zmIbddAKKzwyG6ISuVtisk5GETruVIiL9nF07x7W4CrUoSw1C/3/nltV1exgtUV+qLjbIL7INdpHcDhmGCGwvddH3VjL/6xID1p3EhuYYFJHB0X1IN3q4LbPJnuGaRG58Y1m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arthurfabre.com; spf=pass smtp.mailfrom=arthurfabre.com; dkim=pass (2048-bit key) header.d=arthurfabre.com header.i=@arthurfabre.com header.b=JS2+1Mdb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ExrlHV+z; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arthurfabre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arthurfabre.com
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 3549211401D5;
	Tue, 22 Apr 2025 09:24:31 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Tue, 22 Apr 2025 09:24:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arthurfabre.com;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm1;
	 t=1745328271; x=1745414671; bh=v6o/ljuPynBVhwWixEM4SLyxpcEFEJ2T
	GJm/eGTLuYg=; b=JS2+1Mdb6+8hZtpS4jMCP9Xbp/xcVxRev9AxuwXP0OrPW/e0
	gwOHfxTkKVxidzwdYH7JlB6rALREXreYPGdXUiCNVNpb2irh4lzAIpFoKL+mnTDZ
	UFMa4sHP5Mm4E4fOg3eh4uyhtk2FusYzMF5ubRU4B+dDHKxkRgrHrz9h0wCZPiSM
	iWJYLqRejS7FR8muigKtKb1UB1aWFZVzmGud3v+LGteLXJyxMfFDNeRQL4k+nYOl
	Loug8PRXNXYVWfwJ7g4d5gXVW/r9gFJtnECyXHuvaMEoZeUJsx05ZZ1Xu4NSMJGE
	jIWHwf9TSsi5RcdsV5nZ8SAPS9w9EKVy9kElTQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1745328271; x=
	1745414671; bh=v6o/ljuPynBVhwWixEM4SLyxpcEFEJ2TGJm/eGTLuYg=; b=E
	xrlHV+zFQH5UVpuQCbjWoJK8MITE9prozny3LpEN7L9rxG6MS4xPYxbaL1e8DHb0
	7SlZKTaK1gbmiskIKHkWTB5NEtSl5VQ970b43rWLgR7q+5SzszyIHCAG9WE4GP3V
	GKS4J3iiHpqPTC+GwK/LmqWrB10LZBNvxbxAKi6ts/JywQ/TcI+/24u+s1Pa9yjP
	Agg7qhOalBbc3G2RXmm64fbH9tPynolYB/PkwXOHzqlEprWzQiqZJlqemOjQ1pOp
	LWQps+Yh5csZqu2uTLjdY4ay4RMXPS7kQqabN8fQd71HO+CcrNWmzyDY0hUMx1Fy
	rHWeXScvquFnGAW+/wYbQ==
X-ME-Sender: <xms:jpgHaBkItxFq8xV7jbmIrENz0yfqf83TtYtycY9rjQ0yLXkvbME-4w>
    <xme:jpgHaM0EN2l2dJnzTM3Fra7q8VI9k1O6sTOnonUqU5JUnQSQ8YC6GgPrA5xZl41vP
    gYLpUNxNtMiLNEJXw0>
X-ME-Received: <xmr:jpgHaHqRGWW9GrRziKK_4NiGLugjJmlNFDqmJsWsSKO6CZyPl8xqqJnLH6q3r6L9A5oYrnEldzkm6BVdv80>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgeefkeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhff
    fugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheptehrthhhuhhrucfhrggs
    rhgvuceorghrthhhuhhrsegrrhhthhhurhhfrggsrhgvrdgtohhmqeenucggtffrrghtth
    gvrhhnpeejkeehffejvdefhedtleetgfeivdetgfefffetkeelieefvdefhfeuveevhffh
    ueenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hthhhurhesrghrthhhuhhrfhgrsghrvgdrtghomhdpnhgspghrtghpthhtohepuddvpdhm
    ohguvgepshhmthhpohhuthdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohephigrnhestghlohhuughflhgrrhgvrdgtohhmpdhrtghpthhtohepnhgv
    thguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohephhgrfihksehkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhm
    pdhrtghpthhtohepthhhohhilhgrnhgusehrvgguhhgrthdrtghomhdprhgtphhtthhope
    hjsghrrghnuggvsghurhhgsegtlhhouhgufhhlrghrvgdrtghomhdprhgtphhtthhopegs
    phhfsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghstheskhgvrhhnvg
    hlrdhorhhg
X-ME-Proxy: <xmx:jpgHaBn58TEl280PcogCsywZGpBY8tzRbvP7FGiOrzyzGqqvaUVV6w>
    <xmx:jpgHaP1JIzcr7MF9zjqNXPWLWYOYYAtoGJznUJJx7sz3POR6uM25CA>
    <xmx:jpgHaAtroko9EllO513JDuJWnqxstl41tLGwxsnJ-gLTt4BAWal1MA>
    <xmx:jpgHaDUHFV6ovzJ8zh6DzDniaJ-aWP-Khere8Q80weXulglVKvPbIQ>
    <xmx:j5gHaDLmuEdV-a-sOb7phAA63lb5BjDYla-V6XqS67jHYKJrftsRSrnT>
Feedback-ID: i25f1493c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Apr 2025 09:24:29 -0400 (EDT)
From: Arthur Fabre <arthur@arthurfabre.com>
Date: Tue, 22 Apr 2025 15:23:46 +0200
Subject: [PATCH RFC bpf-next v2 17/17] trait: Allow socket filters to
 access traits
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250422-afabre-traits-010-rfc2-v2-17-92bcc6b146c9@arthurfabre.com>
References: <20250422-afabre-traits-010-rfc2-v2-0-92bcc6b146c9@arthurfabre.com>
In-Reply-To: <20250422-afabre-traits-010-rfc2-v2-0-92bcc6b146c9@arthurfabre.com>
To: netdev@vger.kernel.org, bpf@vger.kernel.org
Cc: jakub@cloudflare.com, hawk@kernel.org, yan@cloudflare.com, 
 jbrandeburg@cloudflare.com, thoiland@redhat.com, lbiancon@redhat.com, 
 ast@kernel.org, kuba@kernel.org, edumazet@google.com, 
 Arthur Fabre <arthur@arthurfabre.com>
X-Mailer: b4 0.14.2

Add kfuncs to allow socket filter programs access to traits in an skb.

To ensure every skb can modify traits independently, copy on write if
multiple skbs are using the same traits.

To allow new traits to be set (which requires more memory), try to use
up more of the headroom of the skb if we run out of space setting.

Signed-off-by: Arthur Fabre <arthur@arthurfabre.com>
---
 include/linux/skbuff.h |   9 ++++
 net/core/skbuff.c      | 112 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 121 insertions(+)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index ae569b1b1af83b586e1be6c69439ef74bac38cf3..e573889cf1256e7aff84b488af875a13f558cb01 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -4874,9 +4874,11 @@ void *__skb_ext_set(struct sk_buff *skb, enum skb_ext_id id,
 		    struct skb_ext *ext);
 void *skb_ext_add(struct sk_buff *skb, enum skb_ext_id id);
 void *skb_ext_from_headroom(struct sk_buff *skb, enum skb_ext_id id, int head_offset, int size);
+bool skb_ext_grow_headroom(const struct sk_buff *skb, int add);
 void __skb_ext_del(struct sk_buff *skb, enum skb_ext_id id);
 void __skb_ext_put(struct skb_ext *ext);
 int __skb_ext_total_size(const struct skb_ext *ext);
+int skb_ext_size(const struct sk_buff *skb, enum skb_ext_id id);
 
 static inline void skb_ext_put(struct sk_buff *skb)
 {
@@ -4960,6 +4962,13 @@ static inline void *skb_traits(const struct sk_buff *skb)
 #endif
 }
 
+int skb_trait_set(struct sk_buff *skb, u64 key,
+			const void *val, u64 val__sz, u64 flags);
+int skb_trait_is_set(const struct sk_buff *skb, u64 key);
+int skb_trait_get(const struct sk_buff *skb, u64 key,
+			void *val, u64 val__sz);
+int skb_trait_del(const struct sk_buff *skb, u64 key);
+
 static inline void nf_reset_ct(struct sk_buff *skb)
 {
 #if defined(CONFIG_NF_CONNTRACK) || defined(CONFIG_NF_CONNTRACK_MODULE)
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 9f27caba82af0be7897b68b5fad087f3e9c62955..27e163b83b12ffac973e1e098f035b807e1f4232 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -7148,6 +7148,19 @@ void *skb_ext_from_headroom(struct sk_buff *skb, enum skb_ext_id id, int head_of
 	return __skb_ext_set_active(skb, new, id);
 }
 
+bool skb_ext_grow_headroom(const struct sk_buff *skb, int add)
+{
+	if (!skb->active_extensions)
+		return false;
+	if (skb->extensions->mode != SKB_EXT_HEADROOM)
+		return false;
+	if (skb_headroom(skb) < add)
+		return false;
+
+	skb->extensions->chunks += SKB_EXT_CHUNKS(add);
+	return true;
+}
+
 #ifdef CONFIG_XFRM
 static void skb_ext_put_sp(struct sec_path *sp)
 {
@@ -7215,8 +7228,107 @@ int __skb_ext_total_size(const struct skb_ext *ext)
 {
 	return SKB_EXT_CHUNKS_BYTES(ext->chunks);
 }
+
+int skb_ext_size(const struct sk_buff *skb, enum skb_ext_id id)
+{
+	if (!skb_ext_exist(skb, id))
+		return 0;
+
+	switch (skb->extensions->mode) {
+	case SKB_EXT_ALLOC:
+		return skb_ext_type_len[id];
+	case SKB_EXT_HEADROOM:
+		return SKB_EXT_CHUNKS_BYTES(skb->extensions->chunks - skb->extensions->offset[id]);
+	}
+}
 #endif /* CONFIG_SKB_EXTENSIONS */
 
+__bpf_kfunc_start_defs();
+
+__bpf_kfunc int skb_trait_set(struct sk_buff *skb, u64 key,
+			      const void *val, u64 val__sz, u64 flags)
+{
+#ifndef CONFIG_SKB_EXTENSIONS
+	return -EOPNOTSUPP;
+#else
+	int err;
+	void *traits = skb_traits(skb);
+
+	if (!traits)
+		return -EOPNOTSUPP;
+
+	/* Traits are shared, get our own copy before modifying */
+	if (refcount_read(&skb->extensions->refcnt) > 1) {
+		traits = skb_ext_add(skb, SKB_EXT_TRAITS);
+		if (!traits)
+			return -ENOMEM;
+	}
+
+	err = trait_set(traits, traits + skb_ext_size(skb, SKB_EXT_TRAITS),
+			key, val, val__sz, flags);
+	if (err == -ENOSPC && skb->extensions->mode == SKB_EXT_HEADROOM) {
+		/* Take more headroom if available */
+		if (!skb_ext_grow_headroom(skb, val__sz))
+			return err;
+
+		err = trait_set(traits, traits + skb_ext_size(skb, SKB_EXT_TRAITS),
+				key, val, val__sz, flags);
+	}
+	return err;
+#endif /* CONFIG_SKB_EXTENSIONS */
+}
+
+__bpf_kfunc int skb_trait_is_set(const struct sk_buff *skb, u64 key)
+{
+	void *traits = skb_traits(skb);
+
+	if (!traits)
+		return -EOPNOTSUPP;
+
+	return trait_is_set(traits, key);
+}
+
+__bpf_kfunc int skb_trait_get(const struct sk_buff *skb, u64 key,
+			      void *val, u64 val__sz)
+{
+	void *traits = skb_traits(skb);
+
+	if (!traits)
+		return -EOPNOTSUPP;
+
+	return trait_get(traits, key, val, val__sz);
+}
+
+__bpf_kfunc int skb_trait_del(const struct sk_buff *skb, u64 key)
+{
+	void *traits = skb_traits(skb);
+
+	if (!traits)
+		return -EOPNOTSUPP;
+
+	return trait_del(traits, key);
+}
+
+__bpf_kfunc_end_defs();
+
+BTF_KFUNCS_START(bpf_skb_traits)
+BTF_ID_FLAGS(func, skb_trait_set)
+BTF_ID_FLAGS(func, skb_trait_is_set)
+BTF_ID_FLAGS(func, skb_trait_get)
+BTF_ID_FLAGS(func, skb_trait_del)
+BTF_KFUNCS_END(bpf_skb_traits)
+
+static const struct btf_kfunc_id_set bpf_traits_kfunc_set = {
+	.owner = THIS_MODULE,
+	.set   = &bpf_skb_traits,
+};
+
+static int init_subsystem(void)
+{
+	return register_btf_kfunc_id_set(BPF_PROG_TYPE_SOCKET_FILTER, &bpf_traits_kfunc_set);
+}
+late_initcall(init_subsystem);
+
 static void kfree_skb_napi_cache(struct sk_buff *skb)
 {
 	/* if SKB is a clone, don't handle this case */

-- 
2.43.0


