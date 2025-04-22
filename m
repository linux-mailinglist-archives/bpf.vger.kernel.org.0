Return-Path: <bpf+bounces-56392-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BBEAA96C70
	for <lists+bpf@lfdr.de>; Tue, 22 Apr 2025 15:24:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AB373B555A
	for <lists+bpf@lfdr.de>; Tue, 22 Apr 2025 13:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FD89280A58;
	Tue, 22 Apr 2025 13:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arthurfabre.com header.i=@arthurfabre.com header.b="PBAOX/MP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Zg5q+BE7"
X-Original-To: bpf@vger.kernel.org
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D171B27F4E7;
	Tue, 22 Apr 2025 13:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745328236; cv=none; b=tj1rqdUq90FPUaeBxmFgUXhtwQ+5ig4JoJKIU9T/XjqS9KGpt577CSUqkrYODixafwq7Kjhc8fHTbtwhgp50YfRGtF9XRN4NIoRG/V0m110Et1jQMBS2r28S1YmZObg7xbjBRxKbiPXLlUxS8KLzMxYaCqqp8TwGR3Eumfef8+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745328236; c=relaxed/simple;
	bh=TPZYexJWmIaDds39WSD8GeRXUGWjz1NpYF0vOsRnzzc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cWjHuurLQZuuSOxnCxoouIgsWdw67McDkEGHD/XC1urW0Fv7Bv6ixbgcgIrWiobeaDyHMqhEYJ6ec/r0lw0cJ2Xukdtzv+AyTfDGUHyRNmU5N4Pc1FvkNwCc9MYL9rttYG+v77Unb5qD4gnWMlXlMq61SWuUy39AVz4ZdXd++ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arthurfabre.com; spf=pass smtp.mailfrom=arthurfabre.com; dkim=pass (2048-bit key) header.d=arthurfabre.com header.i=@arthurfabre.com header.b=PBAOX/MP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Zg5q+BE7; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arthurfabre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arthurfabre.com
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9666C25401EB;
	Tue, 22 Apr 2025 09:23:52 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 22 Apr 2025 09:23:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arthurfabre.com;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm1;
	 t=1745328232; x=1745414632; bh=j8ie4hpfhozCdT/5LpMzezbzlHwO/1UK
	cynbfdcE4eo=; b=PBAOX/MPvUixN2L1ktFXAARxZ8H13SBFFfV67CGLAGSllEzM
	VKE0TZ9RwO+OxGWXOp+sb/9yFdC/SqF09VTK7OP7lSahA1mDJ0o5KRTc3exuG0Fb
	Q/Q5vIUAZsAAZ8cauLRDiMtuSgiqx9jGHWON2PKj8JnfImu4xfhiZOAEtQgsytAx
	yimWoQ+bcs0SlfmT3l8nTTXvc1Odm6AKQijyfgtYkzPxvqSGr3fJLdokcg7RKyGA
	obh1oN5r+y5Bi1y1NbzCqO3gOl4dcQeUJER4lavCr9AjFQJhLbOmwwwABvvOpVWX
	W0O5fp8S9h3bW+XHPych0EJVKGCmiiWgE+xaaA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1745328232; x=
	1745414632; bh=j8ie4hpfhozCdT/5LpMzezbzlHwO/1UKcynbfdcE4eo=; b=Z
	g5q+BE7cpvGObMFsw5kEKJPStr5InUENPBQYNpimmoz+y7GqZqF/EYbeKOtANP6I
	PmlEogr4n7zU6LxFpKyAViwGrph/qzLmXt76IY+nYUVUtAfYkK2n1nElQTfXoD0J
	BUGSV3yM2Gw9UK9wNc376vVxWc92Eryr0EN7SxooS79iXC3ukUk6z3o3G2gZayPq
	0vJ1XmOhrLUTb4nmXQ8jG+5YZ93XC8Nrit7lPq5Ung0xPMqgAaknR2WRroA+7Jz/
	P0mNjaOa/0mxhtEDGQGYA9VRN/elhT214+hRuZWUDXvEFT26W0xNLOizEHPV2i5a
	2QyqXpi8GbBStIPH9eBuw==
X-ME-Sender: <xms:aJgHaIVUgAfwnlBjOFCmZ23LIB0mPdMI6K4wMAzxCL9DrUIs7slsCg>
    <xme:aJgHaMmWJQZ2-w8topaA2lf6Ol_Q1LXXc7YloOlsBz_84H8_0QCYKC-679NsK5Jcb
    712HaJCYyD_3mB35-s>
X-ME-Received: <xmr:aJgHaMYhJqpeDDD2-tEu6YXHgCPJXXzwKOW99n5s2fKdz7M87PopC0rgPy-a86TJ4ZbGjI9KOPt3E79oJjU>
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
X-ME-Proxy: <xmx:aJgHaHWx_8_a6OTdtUuCqlzKYgwToLlU4fITpKlxRYrdJbVjrFus2w>
    <xmx:aJgHaClxbZNCHb4HPyhfcDA18rfVDRQhkcNuzhBfnWpfdyUPlMPlpw>
    <xmx:aJgHaMeg9nn2F1VxPCMr27ynP9JBcXa6qWgbCJ2FZtxL0bgpO6alsA>
    <xmx:aJgHaEHQhr6AA7G6h4zvGR_Kt709IRfIv3kTYtsaFqyUabkA-sjTiw>
    <xmx:aJgHaD4RpA1bCywjMdPpwVo-ozbPpw_Pt7tkZ6-qndpgzFQ5b3j9K93l>
Feedback-ID: i25f1493c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Apr 2025 09:23:50 -0400 (EDT)
From: Arthur Fabre <arthur@arthurfabre.com>
Date: Tue, 22 Apr 2025 15:23:30 +0200
Subject: [PATCH RFC bpf-next v2 01/17] trait: limited KV store for packet
 metadata
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250422-afabre-traits-010-rfc2-v2-1-92bcc6b146c9@arthurfabre.com>
References: <20250422-afabre-traits-010-rfc2-v2-0-92bcc6b146c9@arthurfabre.com>
In-Reply-To: <20250422-afabre-traits-010-rfc2-v2-0-92bcc6b146c9@arthurfabre.com>
To: netdev@vger.kernel.org, bpf@vger.kernel.org
Cc: jakub@cloudflare.com, hawk@kernel.org, yan@cloudflare.com, 
 jbrandeburg@cloudflare.com, thoiland@redhat.com, lbiancon@redhat.com, 
 ast@kernel.org, kuba@kernel.org, edumazet@google.com, 
 Arthur Fabre <arthur@arthurfabre.com>
X-Mailer: b4 0.14.2

A (very limited) KV store to support storing KVs in the packet headroom,
with:
- 64 keys (0-63).
- 0, 4 or 8 byte values.
- O(1) lookup
- O(n) insertion
- A fixed 16 byte header.

Values are stored ordered by key, immediately following the fixed
header.

A future batch API will allow setting multiple consecutive keys at once.
This will allow values bigger than 8 bytes to be stored.
16 byte values would be particularly useful to store UUIDs and IPv6
addresses.

Implemented in a header file so functions are always inlinable.

Signed-off-by: Arthur Fabre <arthur@arthurfabre.com>
---
 include/net/trait.h | 263 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 263 insertions(+)

diff --git a/include/net/trait.h b/include/net/trait.h
new file mode 100644
index 0000000000000000000000000000000000000000..af42c1ad2416d5c38631f1f0305ef9fefe43bd87
--- /dev/null
+++ b/include/net/trait.h
@@ -0,0 +1,263 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2025 Arthur Fabre, Cloudflare */
+#ifndef __LINUX_NET_TRAIT_H__
+#define __LINUX_NET_TRAIT_H__
+
+#include <linux/types.h>
+#include <linux/errno.h>
+#include <linux/string.h>
+#include <linux/bitops.h>
+
+/* Traits are a very limited KV store, with:
+ * - 64 keys (0-63).
+ * - 0 (flag), 4, or 8 byte values.
+ * - O(1) lookup
+ * - O(n) insertion
+ * - A fixed 16 byte header.
+ */
+struct __trait_hdr {
+	/* Values are stored ordered by key, immediately after the header.
+	 *
+	 * The size of each value set is stored in the header as two bits:
+	 *  - 00: Not set.
+	 *  - 01: 0 bytes.
+	 *  - 10: 4 bytes.
+	 *  - 11: 8 bytes.
+	 *
+	 * Naively storing the size of each value (eg packing 4 of them in a byte)
+	 * doesn't let us efficiently calculate the offset of the value of an arbitrary key:
+	 * we'd have to mask out and sum the sizes of all preceding values.
+	 *
+	 * Instead, store the high and low bits of the size in two separate words:
+	 *  - A high bit in the high word.
+	 *  - A low bit in the low word.
+	 * The bit position of each word, LSb 0, is the key.
+	 *
+	 * To calculate the offset of the value of a key:
+	 *  - Mask out subsequent keys from both words.
+	 *  - Count the number of bits in each word: hamming weight (single amd64 instruction).
+	 *  - Map the bits to sizes.
+	 */
+	u64 high;
+	u64 low;
+};
+
+static __always_inline bool __trait_valid_len(u64 len)
+{
+	return len == 0 || len == 4 || len == 8;
+}
+
+static __always_inline bool __trait_valid_key(u64 key)
+{
+	return key < 64;
+}
+
+static __always_inline int __trait_total_length(struct __trait_hdr h)
+{
+	return (hweight64(h.high) << 2)
+		// For size 8, we only get 2. Add another 4 in.
+		+ (hweight64(h.high & h.low) << 2);
+}
+
+static __always_inline struct __trait_hdr __trait_and(struct __trait_hdr h, u64 mask)
+{
+	return (struct __trait_hdr){
+		h.high & mask,
+		h.low & mask,
+	};
+}
+
+static __always_inline int __trait_offset(struct __trait_hdr h, u64 key)
+{
+	/* Calculate total length of previous keys by masking out keys after. */
+	return sizeof(struct __trait_hdr) + __trait_total_length(__trait_and(h, ~(~0llu << key)));
+}
+
+/**
+ * traits_init() - Initialize a trait store.
+ * @traits: Start of trait store area.
+ * @hard_end: Hard limit the trait store can currently grow up against.
+ *            Can change dynamically after initialization, as long as it
+ *            does not overwrite any area already used (see traits_size()).
+ *
+ * Return:
+ * * %0       - Success.
+ * * %-ENOMEM - Not enough room to store any traits.
+ */
+static __always_inline int traits_init(void *traits, void *hard_end)
+{
+	if (traits + sizeof(struct __trait_hdr) > hard_end)
+		return -ENOMEM;
+
+	memset(traits, 0, sizeof(struct __trait_hdr));
+	return 0;
+}
+
+/**
+ * traits_size() - Total size currently used by a trait store.
+ * @traits: Start of trait store area.
+ *
+ * Return: Size in bytes.
+ */
+static __always_inline int traits_size(void *traits)
+{
+	return sizeof(struct __trait_hdr) + __trait_total_length(*(struct __trait_hdr *)traits);
+}
+
+/**
+ * trait_set() - Set a trait key.
+ * @traits: Start of trait store area.
+ * @hard_end: Hard limit the trait store can currently grow up against.
+ * @key: The key to set.
+ * @val: The value to set.
+ * @len: The length of the value.
+ * @flags: Unused for now. Should be 0.
+ *
+ * Return:
+ * * %0       - Success.
+ * * %-EINVAL - Key or length invalid.
+ * * %-EBUSY  - Key previously set with different length.
+ * * %-ENOSPC - Not enough room left to store value.
+ */
+static __always_inline
+int trait_set(void *traits, void *hard_end, u64 key, const void *val, u64 len, u64 flags)
+{
+	if (!__trait_valid_key(key) || !__trait_valid_len(len))
+		return -EINVAL;
+
+	struct __trait_hdr *h = (struct __trait_hdr *)traits;
+
+	/* Offset of value of this key. */
+	int off = __trait_offset(*h, key);
+
+	if ((h->high & (1ull << key)) || (h->low & (1ull << key))) {
+		/* Key is already set, but with a different length */
+		if (__trait_total_length(__trait_and(*h, (1ull << key))) != len)
+			return -EBUSY;
+	} else {
+		/* Figure out if we have enough room left: total length of everything now. */
+		if (traits + sizeof(struct __trait_hdr) + __trait_total_length(*h) + len > hard_end)
+			return -ENOSPC;
+
+		/* Memmove all the kvs after us over. */
+		if (traits_size(traits) > off)
+			memmove(traits + off + len, traits + off, traits_size(traits) - off);
+	}
+
+	/* Set our value. */
+	memcpy(traits + off, val, len);
+
+	/* Store our length in header. */
+	u64 encode_len = 0;
+
+	switch (len) {
+	case 0:
+		encode_len = 1;
+		break;
+	case 4:
+		encode_len = 2;
+		break;
+	case 8:
+		encode_len = 3;
+		break;
+	}
+	h->high |= (encode_len >> 1) << key;
+	h->low |= (encode_len & 1) << key;
+	return 0;
+}
+
+/**
+ * trait_is_set() - Check if a trait key is set.
+ * @traits: Start of trait store area.
+ * @key: The key to check.
+ *
+ * Return:
+ * * %0       - Key is not set.
+ * * %1       - Key is set.
+ * * %-EINVAL - Key or length invalid.
+ */
+static __always_inline
+int trait_is_set(void *traits, u64 key)
+{
+	if (!__trait_valid_key(key))
+		return -EINVAL;
+
+	struct __trait_hdr h = *(struct __trait_hdr *)traits;
+
+	return ((h.high & (1ull << key)) || (h.low & (1ull << key))) != 0;
+}
+
+/**
+ * trait_get() - Get a trait key.
+ * @traits: Start of trait store area.
+ * @key: The key to get.
+ * @val: Where to put stored value.
+ * @val_len: The length of val.
+ *
+ * Return:
+ * * %>0      - Actual size of value.
+ * * %-EINVAL - Key or length invalid.
+ * * %-ENOENT - Key has not been set with trait_set() previously.
+ * * %-ENOSPC - Val is not big enough to hold stored value.
+ */
+static __always_inline
+int trait_get(void *traits, u64 key, void *val, u64 val_len)
+{
+	if (!__trait_valid_key(key))
+		return -EINVAL;
+
+	struct __trait_hdr h = *(struct __trait_hdr *)traits;
+
+	/* Check key is set */
+	if (!((h.high & (1ull << key)) || (h.low & (1ull << key))))
+		return -ENOENT;
+
+	/* Offset of value of this key */
+	int off = __trait_offset(h, key);
+
+	/* Figure out our length */
+	int real_len = __trait_total_length(__trait_and(h, (1ull << key)));
+
+	if (real_len > val_len)
+		return -ENOSPC;
+
+	memcpy(val, traits + off, real_len);
+	return real_len;
+}
+
+/**
+ * trait_del() - Delete a trait key.
+ * @traits: Start of trait store area.
+ * @key: The key to delete.
+ *
+ * Return:
+ * * %0       - Success.
+ * * %-EINVAL - Key or length invalid.
+ * * %-ENOENT - Key has not been set with trait_set() previously.
+ */
+static __always_inline int trait_del(void *traits, u64 key)
+{
+	if (!__trait_valid_key(key))
+		return -EINVAL;
+
+	struct __trait_hdr *h = (struct __trait_hdr *)traits;
+
+	/* Check key is set */
+	if (!((h->high & (1ull << key)) || (h->low & (1ull << key))))
+		return -ENOENT;
+
+	/* Offset and length of value of this key */
+	int off = __trait_offset(*h, key);
+	int len = __trait_total_length(__trait_and(*h, (1ull << key)));
+
+	/* Memmove all the kvs after us over */
+	if (traits_size(traits) > off + len)
+		memmove(traits + off, traits + off + len, traits_size(traits) - off - len);
+
+	/* Clear our length in header */
+	h->high &= ~(1ull << key);
+	h->low &= ~(1ull << key);
+	return 0;
+}
+
+#endif /* __LINUX_NET_TRAIT_H__ */

-- 
2.43.0


