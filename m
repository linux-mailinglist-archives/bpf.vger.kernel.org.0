Return-Path: <bpf+bounces-56399-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13430A96C88
	for <lists+bpf@lfdr.de>; Tue, 22 Apr 2025 15:25:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8724189FDFD
	for <lists+bpf@lfdr.de>; Tue, 22 Apr 2025 13:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3647E2853FC;
	Tue, 22 Apr 2025 13:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arthurfabre.com header.i=@arthurfabre.com header.b="T5e6jc4j";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AP4G8pvn"
X-Original-To: bpf@vger.kernel.org
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62262853E8;
	Tue, 22 Apr 2025 13:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745328252; cv=none; b=a97oa6W5Qot5bgomiGxlktPEJkCf9ON+eTAYlV/S87BYPZc96Vl8KekWN2D7P0laugWenJFByNVzG7v88eZ8SNCEuDCzU5vTyoDIHQi5H91JzJ4gD3SUQk2G2RXZk+2jBtFFxFk0uspvLEs/OXijrbhY8YxBWEslcN0fKMnDzWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745328252; c=relaxed/simple;
	bh=M1ke4g3TEtpET+wKFTZ2azEf1tdKJ3qaBmECVnzSOQY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FHkoGkqbYHu9KEcgg+hU/zT2zf5BjoD7Nyumxm+M9j+1yaqgAoH2GtOFJNJIqIXTYeoJ/9y6URWgEN84a6eead1FOrn/FqVXr6i4BlthrxPLQ2Xp87tU5EErDO1szuLN95gs/RcqaH6yqOOgkNK1NvsacHUSKt9OTegChnEnOMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arthurfabre.com; spf=pass smtp.mailfrom=arthurfabre.com; dkim=pass (2048-bit key) header.d=arthurfabre.com header.i=@arthurfabre.com header.b=T5e6jc4j; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AP4G8pvn; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arthurfabre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arthurfabre.com
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id A8C4C11401B9;
	Tue, 22 Apr 2025 09:24:09 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Tue, 22 Apr 2025 09:24:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arthurfabre.com;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm1;
	 t=1745328249; x=1745414649; bh=LocyY7G+eeu/jXmqExoAC46MZ+cmmGho
	P+I3DktGyEE=; b=T5e6jc4jqcB8ocQ8HwPZFaGb6CvVy/RDxGL3Pyp3wSRYnXi3
	iUOaxObwI32/wJvth2G18/UL65CkSg0ftGZfYCjDtTitfr3565QD+K3myZqAr7gP
	mPqhlybXgq2eBJKmqSbe3YS5KZfJJt5++Yv3fSenol803jUNx4YzFCCAX3+3UeLr
	9SLxHqhzO2+/n/8V6nkGpGXFMLm9g2gPkV6VpSpNCTUS3lfCVn19JLvmtbDq6Q14
	mIIXVph9mK6HwQOItY1g4RtFrM0GjU2E8dUHCTCUrBr3kXmLTzvbHnRCsq3o4inu
	8re6mnD/IO3AophILaqnxojd96vrzxdT1oUfoQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1745328249; x=
	1745414649; bh=LocyY7G+eeu/jXmqExoAC46MZ+cmmGhoP+I3DktGyEE=; b=A
	P4G8pvnmwTnPxUrzW9ScmTE1pkFtECXOFuaXfLCUiK26Sz5tp5DlWNQsLJIXeU4g
	O51AqzO8xQHPQnn5qHdl/SLTlLoFgiHpEBOIrDtuNA8cQ9UJYnyfRbL2JnH6khz1
	sfybIGl9YamxERMHnZdKG4O1Q9klnGerPalH+pUsscveKEMrP5QRoJt/gOecFzVV
	+e8T/Z6zjYgyFuVI9l4jWuYnBtZ6Rb9VdDRZOq4s/hTaMGFAMoBhFPlaq/56T0RU
	W7uW35wqOEhS4/0XJFzHprVi3kSpT5JuoXPdWsNL4gndu+ZMwfweYarw1BJeHU+V
	dxGiHKwhERMPzlxzHC3LA==
X-ME-Sender: <xms:eZgHaN3EDNIlbtmlkv9mIoA0bc9etO6UJOdU49bawLhDzmFO6k9DpQ>
    <xme:eZgHaEF8AFIxIkSz6hqDWTi2DNeHmaFSxyxZF6JhkqinunI3VSyzUFrHJB3GNY2TX
    z_DUqCVR3xcHO7Mehw>
X-ME-Received: <xmr:eZgHaN6lIzu4ZpzhPISuZZ6URbGjyJdXdlGDDxxDVm6ZWzi4K0uNd8j-8d0bFQiI3fEMUoc-JTHppJMVoSI>
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
X-ME-Proxy: <xmx:eZgHaK1_vubXSm3dBC6zAC1URxKQZmhgKfjQEOy-5r8j9PlFlwP8-A>
    <xmx:eZgHaAGPkVsbu9rJR-MibmZ2W2I-4gfONxzsIqNTxxElv6-7yoWNGA>
    <xmx:eZgHaL9lR_ddhlj3BN1bkh2oweRD8zgyzY5bl7qP8oaPCvuzdlktkQ>
    <xmx:eZgHaNl9gU8onbcvvrYHk0va24nm6pkPpjN7jSV0R3EhxuXI0CI4jg>
    <xmx:eZgHaNbCzHUBbphcLai3Vr0OvBO6a4tZyHPs0IcQm-7FcbNaVQbn7hTO>
Feedback-ID: i25f1493c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Apr 2025 09:24:07 -0400 (EDT)
From: Arthur Fabre <arthur@arthurfabre.com>
Date: Tue, 22 Apr 2025 15:23:37 +0200
Subject: [PATCH RFC bpf-next v2 08/17] skb: Extension header in packet
 headroom
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250422-afabre-traits-010-rfc2-v2-8-92bcc6b146c9@arthurfabre.com>
References: <20250422-afabre-traits-010-rfc2-v2-0-92bcc6b146c9@arthurfabre.com>
In-Reply-To: <20250422-afabre-traits-010-rfc2-v2-0-92bcc6b146c9@arthurfabre.com>
To: netdev@vger.kernel.org, bpf@vger.kernel.org
Cc: jakub@cloudflare.com, hawk@kernel.org, yan@cloudflare.com, 
 jbrandeburg@cloudflare.com, thoiland@redhat.com, lbiancon@redhat.com, 
 ast@kernel.org, kuba@kernel.org, edumazet@google.com, 
 Arthur Fabre <arthur@arthurfabre.com>
X-Mailer: b4 0.14.2

We want to store traits in an skb extension header (see next commit).
To avoid having to allocate memory separately, and copy the traits from
the headroom to the allocated memory, allow extensions to be stored
directly in the headroom.

Only one extension may be stored at a time in the headroom, adding
another extension will allocate memory and copy the existing headroom
backed extension over.

To save space, headroom backed extensions do not use pre-declared sizes:
the amount of headroom space to use is controlled at runtime.
This preserves headroom space for other uses, like encap headers.

Signed-off-by: Arthur Fabre <arthur@arthurfabre.com>
---
 include/linux/skbuff.h |  22 ++++++++++
 net/core/skbuff.c      | 115 ++++++++++++++++++++++++++++++++++++++++++-------
 2 files changed, 121 insertions(+), 16 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index b974a277975a8a7b6f40c362542e9e8522539009..4f325a1733f8be808345424f737df36e06d4cd98 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -2829,6 +2829,10 @@ static inline void *pskb_pull(struct sk_buff *skb, unsigned int len)
 
 void skb_condense(struct sk_buff *skb);
 
+#ifdef CONFIG_SKB_EXTENSIONS
+int skb_ext_headroom_used(const struct sk_buff *skb);
+#endif
+
 /**
  *	skb_headroom - bytes at buffer head
  *	@skb: buffer to check
@@ -2837,7 +2841,11 @@ void skb_condense(struct sk_buff *skb);
  */
 static inline unsigned int skb_headroom(const struct sk_buff *skb)
 {
+#ifdef CONFIG_SKB_EXTENSIONS
+	return skb->data - skb->head - skb_ext_headroom_used(skb);
+#else
 	return skb->data - skb->head;
+#endif
 }
 
 /**
@@ -4830,10 +4838,21 @@ enum skb_ext_id {
 	SKB_EXT_NUM, /* must be last */
 };
 
+enum skb_ext_mode {
+	/* struct skb_ext heap allocated */
+	SKB_EXT_ALLOC,
+	/* struct skb_ext in skb data headroom.
+	 * Only a single extension can be used at a time.
+	 * Size given to extension is dynamic.
+	 */
+	SKB_EXT_HEADROOM,
+};
+
 /**
  *	struct skb_ext - sk_buff extensions
  *	@refcnt: 1 on allocation, deallocated on 0
  *	@offset: offset to add to @data to obtain extension address
+ *	@mode: see enum skb_ext_mode
  *	@chunks: size currently allocated, stored in SKB_EXT_ALIGN_SHIFT units
  *	@data: start of extension data, variable sized
  *
@@ -4844,6 +4863,7 @@ struct skb_ext {
 	refcount_t refcnt;
 	u8 offset[SKB_EXT_NUM]; /* in chunks of 8 bytes */
 	u8 chunks;		/* same */
+	enum skb_ext_mode mode;
 	char data[] __aligned(8);
 };
 
@@ -4851,8 +4871,10 @@ struct skb_ext *__skb_ext_alloc(gfp_t flags);
 void *__skb_ext_set(struct sk_buff *skb, enum skb_ext_id id,
 		    struct skb_ext *ext);
 void *skb_ext_add(struct sk_buff *skb, enum skb_ext_id id);
+void *skb_ext_from_headroom(struct sk_buff *skb, enum skb_ext_id id, int head_offset, int size);
 void __skb_ext_del(struct sk_buff *skb, enum skb_ext_id id);
 void __skb_ext_put(struct skb_ext *ext);
+int __skb_ext_total_size(const struct skb_ext *ext);
 
 static inline void skb_ext_put(struct sk_buff *skb)
 {
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 6cbf77bc61fce74c934628fd74b3a2cb7809e464..34dae26dac4cea448f84dacabdc8fb6f4ac3c1a6 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -2232,7 +2232,7 @@ int pskb_expand_head(struct sk_buff *skb, int nhead, int ntail,
 	unsigned int osize = skb_end_offset(skb);
 	unsigned int size = osize + nhead + ntail;
 	long off;
-	u8 *data;
+	u8 *data, *head;
 	int i;
 
 	BUG_ON(nhead < 0);
@@ -2249,10 +2249,20 @@ int pskb_expand_head(struct sk_buff *skb, int nhead, int ntail,
 		goto nodata;
 	size = SKB_WITH_OVERHEAD(size);
 
+	head = skb->head;
+#ifdef CONFIG_SKB_EXTENSIONS
+	/* Keep skb_ext at the start of the new headroom */
+	if (skb_has_extensions(skb) && skb->extensions->mode == SKB_EXT_HEADROOM) {
+		head += __skb_ext_total_size(skb->extensions);
+		memcpy(data, skb->extensions, __skb_ext_total_size(skb->extensions));
+		skb->extensions = (struct skb_ext *)data;
+	}
+#endif
+
 	/* Copy only real data... and, alas, header. This should be
 	 * optimized for the cases when header is void.
 	 */
-	memcpy(data + nhead, skb->head, skb_tail_pointer(skb) - skb->head);
+	memcpy(data + nhead, head, skb_tail_pointer(skb) - head);
 
 	memcpy((struct skb_shared_info *)(data + size),
 	       skb_shinfo(skb),
@@ -5013,7 +5023,9 @@ EXPORT_SYMBOL_GPL(skb_segment);
 
 #ifdef CONFIG_SKB_EXTENSIONS
 #define SKB_EXT_ALIGN_VALUE	8
-#define SKB_EXT_CHUNKSIZEOF(x)	(ALIGN((sizeof(x)), SKB_EXT_ALIGN_VALUE) / SKB_EXT_ALIGN_VALUE)
+#define SKB_EXT_CHUNKS(x)	(ALIGN((x), SKB_EXT_ALIGN_VALUE) / SKB_EXT_ALIGN_VALUE)
+#define SKB_EXT_CHUNKSIZEOF(x)	(SKB_EXT_CHUNKS(sizeof(x)))
+#define SKB_EXT_CHUNKS_BYTES(x) ((x) * SKB_EXT_ALIGN_VALUE)
 
 static const u8 skb_ext_type_len[] = {
 #if IS_ENABLED(CONFIG_BRIDGE_NETFILTER)
@@ -5033,7 +5045,7 @@ static const u8 skb_ext_type_len[] = {
 #endif
 };
 
-static __always_inline unsigned int skb_ext_total_length(void)
+static __always_inline unsigned int skb_ext_alloc_length(void)
 {
 	unsigned int l = SKB_EXT_CHUNKSIZEOF(struct skb_ext);
 	int i;
@@ -5048,11 +5060,11 @@ static void skb_extensions_init(void)
 {
 	BUILD_BUG_ON(SKB_EXT_NUM >= 8);
 #if !IS_ENABLED(CONFIG_KCOV_INSTRUMENT_ALL)
-	BUILD_BUG_ON(skb_ext_total_length() > 255);
+	BUILD_BUG_ON(skb_ext_alloc_length() > 255);
 #endif
 
 	skbuff_ext_cache = kmem_cache_create("skbuff_ext_cache",
-					     SKB_EXT_ALIGN_VALUE * skb_ext_total_length(),
+					     SKB_EXT_CHUNKS_BYTES(skb_ext_alloc_length()),
 					     0,
 					     SLAB_HWCACHE_ALIGN|SLAB_PANIC,
 					     NULL);
@@ -6934,7 +6946,7 @@ EXPORT_SYMBOL(skb_condense);
 #ifdef CONFIG_SKB_EXTENSIONS
 static void *skb_ext_get_ptr(struct skb_ext *ext, enum skb_ext_id id)
 {
-	return (void *)ext + (ext->offset[id] * SKB_EXT_ALIGN_VALUE);
+	return (void *)ext + SKB_EXT_CHUNKS_BYTES(ext->offset[id]);
 }
 
 /**
@@ -6963,14 +6975,15 @@ static struct skb_ext *skb_ext_maybe_cow(struct skb_ext *old,
 {
 	struct skb_ext *new;
 
-	if (refcount_read(&old->refcnt) == 1)
+	/* SKB_EXT_HEADROOM only supports a single extension, always copy */
+	if (refcount_read(&old->refcnt) == 1 && old->mode == SKB_EXT_ALLOC)
 		return old;
 
 	new = kmem_cache_alloc(skbuff_ext_cache, GFP_ATOMIC);
 	if (!new)
 		return NULL;
 
-	memcpy(new, old, old->chunks * SKB_EXT_ALIGN_VALUE);
+	memcpy(new, old, SKB_EXT_CHUNKS_BYTES(old->chunks));
 	refcount_set(&new->refcnt, 1);
 
 #ifdef CONFIG_XFRM
@@ -7018,6 +7031,14 @@ void *__skb_ext_set(struct sk_buff *skb, enum skb_ext_id id,
 	return skb_ext_get_ptr(ext, id);
 }
 
+static void *__skb_ext_set_active(struct sk_buff *skb, struct skb_ext *ext, enum skb_ext_id id)
+{
+	skb->slow_gro = 1;
+	skb->extensions = ext;
+	skb->active_extensions |= 1 << id;
+	return skb_ext_get_ptr(ext, id);
+}
+
 /**
  * skb_ext_add - allocate space for given extension, COW if needed
  * @skb: buffer
@@ -7045,7 +7066,7 @@ void *skb_ext_add(struct sk_buff *skb, enum skb_ext_id id)
 			return NULL;
 
 		if (__skb_ext_exist(new, id))
-			goto set_active;
+			return __skb_ext_set_active(skb, new, id);
 
 		newoff = new->chunks;
 	} else {
@@ -7059,14 +7080,70 @@ void *skb_ext_add(struct sk_buff *skb, enum skb_ext_id id)
 	newlen = newoff + skb_ext_type_len[id];
 	new->chunks = newlen;
 	new->offset[id] = newoff;
-set_active:
-	skb->slow_gro = 1;
-	skb->extensions = new;
-	skb->active_extensions |= 1 << id;
-	return skb_ext_get_ptr(new, id);
+
+	return __skb_ext_set_active(skb, new, id);
 }
 EXPORT_SYMBOL(skb_ext_add);
 
+/**
+ * skb_ext_headroom_used - Number of headroom bytes used by extensions.
+ * @skb: buffer
+ *
+ * Returns the number of headroom bytes currently used by extensions.
+ */
+int skb_ext_headroom_used(const struct sk_buff *skb)
+{
+	if (!skb->active_extensions)
+		return 0;
+	if (skb->extensions->mode != SKB_EXT_HEADROOM)
+		return 0;
+
+	return SKB_EXT_CHUNKS_BYTES(skb->extensions->chunks);
+}
+
+/**
+ * skb_ext_from_headroom - store skb_ext in the packet headroom,
+ * and reuse headroom data for a single extension.
+ * @skb: buffer
+ * @id: extension to use headroom data for
+ * @head_offset: offset in bytes to start of headroom data to reuse
+ *               Must be a multiple of SKB_EXT_ALIGN_VALUE.
+ *               Must be bigger than sizeof(struct skb_ext).
+ * @size: size bytes following head_offset will be used for the
+ *        extension.
+ *
+ * Reuses the packet headroom to avoid a separate memory allocation:
+ * - struct skb_ext is stored at the start of the headroom.
+ * - head_offset - head_offset+size is given to the extension.
+ *
+ * Returns pointer to the extension or NULL on failure.
+ */
+void *skb_ext_from_headroom(struct sk_buff *skb, enum skb_ext_id id, int head_offset, int size)
+{
+	struct skb_ext *new;
+	unsigned int newoff;
+
+	if (head_offset % SKB_EXT_ALIGN_VALUE != 0)
+		return NULL;
+	if (head_offset < sizeof(struct skb_ext))
+		return NULL;
+	if (skb_headroom(skb) < head_offset + size)
+		return NULL;
+	if (skb->active_extensions)
+		return NULL;
+
+	new = (struct skb_ext *)skb->head;
+	new->mode = SKB_EXT_HEADROOM;
+	memset(new->offset, 0, sizeof(new->offset));
+	refcount_set(&new->refcnt, 1);
+
+	newoff = SKB_EXT_CHUNKS(head_offset);
+	new->chunks = newoff + SKB_EXT_CHUNKS(size);
+	new->offset[id] = newoff;
+
+	return __skb_ext_set_active(skb, new, id);
+}
+
 #ifdef CONFIG_XFRM
 static void skb_ext_put_sp(struct sec_path *sp)
 {
@@ -7125,9 +7202,15 @@ void __skb_ext_put(struct skb_ext *ext)
 		skb_ext_put_mctp(skb_ext_get_ptr(ext, SKB_EXT_MCTP));
 #endif
 
-	kmem_cache_free(skbuff_ext_cache, ext);
+	if (ext->mode == SKB_EXT_ALLOC)
+		kmem_cache_free(skbuff_ext_cache, ext);
 }
 EXPORT_SYMBOL(__skb_ext_put);
+
+int __skb_ext_total_size(const struct skb_ext *ext)
+{
+	return SKB_EXT_CHUNKS_BYTES(ext->chunks);
+}
 #endif /* CONFIG_SKB_EXTENSIONS */
 
 static void kfree_skb_napi_cache(struct sk_buff *skb)

-- 
2.43.0


