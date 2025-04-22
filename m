Return-Path: <bpf+bounces-56398-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7658BA96C80
	for <lists+bpf@lfdr.de>; Tue, 22 Apr 2025 15:25:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88C1F17C71B
	for <lists+bpf@lfdr.de>; Tue, 22 Apr 2025 13:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38768284B5E;
	Tue, 22 Apr 2025 13:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arthurfabre.com header.i=@arthurfabre.com header.b="kTWXoe5r";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IOuaKN5k"
X-Original-To: bpf@vger.kernel.org
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127B2284B25;
	Tue, 22 Apr 2025 13:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745328249; cv=none; b=aquvmWbyomDC1dcBoCZxEOuAYVEAGReV2iO95Si1yOKACbzcfEDLO1bn+wP3GYfkCHeiXXJHYO+cmkeOIxVQY2CV4TMFE6yaPsOLsYQJ9iFQq2fYiI/vnxDY9d0LHVdChVxubDbHJWKS/OA+invCjCiLpcT1O8e0IsA7mG9/rYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745328249; c=relaxed/simple;
	bh=dQHBmgy6qj3MJ1elbGnwrNEpvDu9DLvoZoWVUykhUxY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Xtpsy0sj6xMhjGHBYYOIHKqPfRo7/U9IHp0hVJAlSAoa7Csc87xCvqsI11DpqvNq54IFCf2B6kp91fRi06BX21ANkudcHSfrLRNZbxQg30llubKFyHAKHgWLhVHQmHKZHLfFjfK5ctiEPu2qsMXvqX3xwNCACdnWAZ+X26S54VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arthurfabre.com; spf=pass smtp.mailfrom=arthurfabre.com; dkim=pass (2048-bit key) header.d=arthurfabre.com header.i=@arthurfabre.com header.b=kTWXoe5r; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IOuaKN5k; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arthurfabre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arthurfabre.com
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 2918A254020B;
	Tue, 22 Apr 2025 09:24:07 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 22 Apr 2025 09:24:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arthurfabre.com;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm1;
	 t=1745328247; x=1745414647; bh=X5s4NnX1bOaYCQB5LMtRBFBCLsMd0BVA
	c4/IcnRNzSw=; b=kTWXoe5rUTW7+LhbqRpwY39S81qm7jvZPlVGpYh+ZbV8tgbm
	902j9TNZVxH2qOYRKLLN78LZTRNoxTX5KJrXxsWCAePQ6TSlAaZ04HkWoZj0oNgR
	TnXtvhDV07xlFI/cVrGenUKQ6GyGk6ZnlfiJ8rsFrdUAekPApkxe5DZ8EpW3O172
	qFcybOurMUEajnHtRyR4w9YwebACvq+cNhsvL66+3g/wranAS3WFzmAYOvpDRcrh
	KbB1eEXFzFI5N3sG5p5D+KV+ejAm7NJmRCim20jvVlU3FZkg7Vd8f5Mv+XwJFsae
	Op4qRKuHvy8arwqw7bvCO4s1IOlLj7M2XF0vIg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1745328247; x=
	1745414647; bh=X5s4NnX1bOaYCQB5LMtRBFBCLsMd0BVAc4/IcnRNzSw=; b=I
	OuaKN5kfowZSZWDVf9cRc451wCustpHKGTiJHDC5gotII/2s96tcORk/NtJ5QAUF
	+UPAua9OEmmzJyts117Zl9qdHCklVOsoOmK68Q9rHJ5sCx6r/fwPbEZylmrNBC7/
	fZwrMFewz8L7jQR/ouDrkjxCQOJSzYXkaeFoMazGgHOFcRjm6wXyFpTL9hh5Hi3i
	vTNsa5io4wyf3gKlJR3EmWaG+EtaZ1XqiWGdOxyX2+6gvRs7UqFghJdiienA+RXC
	GcS2Fsf4JLFtP5po3j7ObCcgUrwYuE4zrE5y7JLEIDfb/Hu8Qu+39nfUnj0bXn+8
	2qdI/o6QB9lFJ2FiLsrIg==
X-ME-Sender: <xms:dpgHaKCDV7ZivWujfi3-89gEyWDEzFoRYruW_7VSBBVfmoHPG9inBA>
    <xme:dpgHaEjn-qIL4xU3wcZhUfMhVEQEY3jBTxeBrJU47j1JygyDBavnK2kZA0nMZyB_k
    l6zV1ll7jtHnnoLupM>
X-ME-Received: <xmr:dpgHaNmBX27LpG26BUyQTpO1NIKmrIpotgBQ5L1VfE-QVPbEtqIBLeFujeoGehavmmflaJ1Xf-8Mhjg0v-I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgeefkeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhff
    fugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheptehrthhhuhhrucfhrggs
    rhgvuceorghrthhhuhhrsegrrhhthhhurhhfrggsrhgvrdgtohhmqeenucggtffrrghtth
    gvrhhnpeejkeehffejvdefhedtleetgfeivdetgfefffetkeelieefvdefhfeuveevhffh
    ueenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hthhhurhesrghrthhhuhhrfhgrsghrvgdrtghomhdpnhgspghrtghpthhtohepuddvpdhm
    ohguvgepshhmthhpohhuthdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohephigrnhestghlohhuughflhgrrhgvrdgtohhmpdhrtghpthhtohepnhgv
    thguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohephhgrfihksehkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhm
    pdhrtghpthhtohepthhhohhilhgrnhgusehrvgguhhgrthdrtghomhdprhgtphhtthhope
    hjsghrrghnuggvsghurhhgsegtlhhouhgufhhlrghrvgdrtghomhdprhgtphhtthhopegs
    phhfsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghstheskhgvrhhnvg
    hlrdhorhhg
X-ME-Proxy: <xmx:dpgHaIyrQvTnPBw-YDf_b3b-_ls8Ff_QQgJLMbUsgKfJ0C1NBz5ldw>
    <xmx:dpgHaPSW1q_ykJ-RoyIQkuL1PHvf2m1FsYXEC6C-tjhIsMqQovKXCQ>
    <xmx:dpgHaDYa1Otz1lFvO8jgH2tXxD412IWp9L0JAY4TEmbZjaadXnHVgQ>
    <xmx:dpgHaIQ-QWn7L-hit_5WGRWUUQDx8e4eT3l9g36M7UJDA_9zNp2Zrw>
    <xmx:dpgHaAHYxvYWPpYmrpCbAzBLnlGboyT6U_WFBKaexxD89_a3aPQ0PVUa>
Feedback-ID: i25f1493c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Apr 2025 09:24:05 -0400 (EDT)
From: Arthur Fabre <arthur@arthurfabre.com>
Date: Tue, 22 Apr 2025 15:23:36 +0200
Subject: [PATCH RFC bpf-next v2 07/17] trait: Replace memmove calls with
 inline move
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250422-afabre-traits-010-rfc2-v2-7-92bcc6b146c9@arthurfabre.com>
References: <20250422-afabre-traits-010-rfc2-v2-0-92bcc6b146c9@arthurfabre.com>
In-Reply-To: <20250422-afabre-traits-010-rfc2-v2-0-92bcc6b146c9@arthurfabre.com>
To: netdev@vger.kernel.org, bpf@vger.kernel.org
Cc: jakub@cloudflare.com, hawk@kernel.org, yan@cloudflare.com, 
 jbrandeburg@cloudflare.com, thoiland@redhat.com, lbiancon@redhat.com, 
 ast@kernel.org, kuba@kernel.org, edumazet@google.com, 
 Arthur Fabre <arthur@arthurfabre.com>
X-Mailer: b4 0.14.2

When inserting or deleting traits, we need to move any subsequent
traits over.

Replace it with an inline implementation to avoid the function call
overhead. This is especially expensive on AMD with SRSO.

In practice we shouldn't have too much data to move around, and we're
naturally limited to 238 bytes max, so a dumb implementation should
hopefully be fast enough.

Jesper Brouer kindly ran benchmarks on real hardware with three configs:
- Intel: E5-1650 v4
- AMD SRSO: 9684X SRSO
- AMD IBPB: 9684X SRSO=IBPB

		Intel	AMD IBPB	AMD SRSO
xdp-trait-get	5.530	3.901		9.188		(ns/op)
xdp-trait-set	7.538	4.941		10.050		(ns/op)
xdp-trait-move	14.245	8.865		14.834		(ns/op)
function call	1.319	1.359		5.703		(ns/op)
indirect call	8.922	6.251		10.329		(ns/op)

Signed-off-by: Arthur Fabre <arthur@arthurfabre.com>
---
 include/net/trait.h | 40 ++++++++++++++++++++++++++++++++++++----
 1 file changed, 36 insertions(+), 4 deletions(-)

diff --git a/include/net/trait.h b/include/net/trait.h
index 4013351549731c4e3bede211dbe9fbe651556dc9..1fc5f773ab9af689ac0f6e29fd3c1e62c04cfff8 100644
--- a/include/net/trait.h
+++ b/include/net/trait.h
@@ -74,6 +74,40 @@ static __always_inline int __trait_offset(struct __trait_hdr h, u64 key)
 	return sizeof(struct __trait_hdr) + __trait_total_length(__trait_and(h, ~(~0llu << key)));
 }
 
+/* Avoid overhead of memmove() function call when possible. */
+static __always_inline void __trait_move(void *src, int off, size_t n)
+{
+	if (n == 0)
+		return;
+
+	if (!IS_ENABLED(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS) || BITS_PER_LONG != 64) {
+		memmove(src + off, src, n);
+		return;
+	}
+
+	/* Need to move in reverse to handle overlap. */
+	if (off > 0)
+		src += n;
+
+#define ___trait_move(op) do { \
+		src -= (off > 0) ? sizeof(u##op) : 0; \
+		*(u##op *)(src + off) = *(u##op *)src; \
+		src += (off < 0) ? sizeof(u##op) : 0; \
+	} while (0)
+
+	for (int w = 0; w < n / 8; w++)
+		___trait_move(64);
+
+	if (n & 4)
+		___trait_move(32);
+
+	if (n & 2)
+		___trait_move(16);
+
+	if (n & 1)
+		___trait_move(8);
+}
+
 /**
  * traits_init() - Initialize a trait store.
  * @traits: Start of trait store area.
@@ -141,8 +175,7 @@ int trait_set(void *traits, void *hard_end, u64 key, const void *val, u64 len, u
 			return -ENOSPC;
 
 		/* Memmove all the kvs after us over. */
-		if (traits_size(traits) > off)
-			memmove(traits + off + len, traits + off, traits_size(traits) - off);
+		__trait_move(traits + off, len, traits_size(traits) - off);
 	}
 
 	u64 encode_len = 0;
@@ -258,8 +291,7 @@ static __always_inline int trait_del(void *traits, u64 key)
 	int len = __trait_total_length(__trait_and(*h, (1ull << key)));
 
 	/* Memmove all the kvs after us over */
-	if (traits_size(traits) > off + len)
-		memmove(traits + off, traits + off + len, traits_size(traits) - off - len);
+	__trait_move(traits + off + len, -len, traits_size(traits) - off - len);
 
 	/* Clear our length in header */
 	h->high &= ~(1ull << key);

-- 
2.43.0


