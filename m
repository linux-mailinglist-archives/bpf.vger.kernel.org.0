Return-Path: <bpf+bounces-53321-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F135BA50211
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 15:34:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A44863B0C66
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 14:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A047724E4BD;
	Wed,  5 Mar 2025 14:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arthurfabre.com header.i=@arthurfabre.com header.b="ToFLQZdE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="C6dho88Y"
X-Original-To: bpf@vger.kernel.org
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DBC124A07C;
	Wed,  5 Mar 2025 14:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741185203; cv=none; b=M5jjRs6Tqn3nxLN6H2YCaIuLX76fgwhLEKdGUKaD1HBBa2F+1g0fldi7RH3ej4qPsMikYJjtHK3CHRIEMHHaovesOFclA/V/J54hf2sIKp7neAP6oGFogjeSDzriPGOrq319Bh7PbIPaXw2FV6BmLBudOllVb7kZgjlz+SRpPuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741185203; c=relaxed/simple;
	bh=qmVEeJKaSlHB670aWXno8J+LHkCC6GUzC2bJyHLdzAw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MxXIGtrSa+iJSXG18D1Ymah/8VBjVn9m5+FEWhVTJkU4RVR16e6rW1iX07MJeinQOClmZLEav2AFEdXbuDjMiN+jIuiescMgXj6UPabNqKzZ7CTCqcauaAYP8T44FJ9lYnNqwf1RsxwS+qGE1bTVzY8pU8QsGv5c/9ZiPVWIti4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arthurfabre.com; spf=pass smtp.mailfrom=arthurfabre.com; dkim=pass (2048-bit key) header.d=arthurfabre.com header.i=@arthurfabre.com header.b=ToFLQZdE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=C6dho88Y; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arthurfabre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arthurfabre.com
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 84F901140122;
	Wed,  5 Mar 2025 09:33:19 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 05 Mar 2025 09:33:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arthurfabre.com;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm3;
	 t=1741185199; x=1741271599; bh=HrkdRASLIyznwcZXcpFIW79Iwc9mintT
	sa0Nyk4khtQ=; b=ToFLQZdEx/q/2oldYjrr3eXwtRs0YAVRgoOCGedZi6alyp0U
	s/I6PS4GS7DLGmuK7oAe0ROURuvPzQY5bBA6XizHouJ6VJWnNgQ4IFD4tdtFvHE3
	RvDz46C2+RKDpBKktUVsuMadXgW+PNKzblQj/Vp45PJ4Wa86hI4sjFOamll1M7df
	ZwiQscLtL8dB7w8xueNiQDPm8IhPPuzjk36xXw3uwpN1J7xGUruFJHH6AF3Gedgr
	9OxVMcgG7GkNMJ9LlFHdXN4x4pjNbgHmv3dxDAF0ZO8bC8jGs8JJ7hjwDx6MMcSH
	tJgag4dJ2ObNLiQYyko/1L8LDBYadErC/n53Pw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741185199; x=
	1741271599; bh=HrkdRASLIyznwcZXcpFIW79Iwc9mintTsa0Nyk4khtQ=; b=C
	6dho88YEoyL3wA2nE1106mc6pt1tDCh5GnyfWkcOxhYObW1EOYViZqfQir7JJS9Z
	qN/qaQ+WOr2HEGIWoe0nHSEWMuCRl0gK2xoZbdfA0VROLeCMgvJEm1aP+1NAaiyU
	Y48sZFT3UHxpPo6YQ5QBW3XS8MboDa2sbA3iioR3YEBzuKzv9ffYvRFPbHu4xh/5
	aCeTp2my+jfuehMKkjCdYtLfY7DWJ3cHuw0hBdlLxtCs2teVsprEY+SDa7oLXudt
	caCgh7mm/I8rJfnJHs2mAYh+xriIbFkMnqH626hn2prQOh5594I9ndhCTzkH3TbF
	nKge6nX48t57BJRwVTQvg==
X-ME-Sender: <xms:r2DIZ0h07zpYxA60NSe6iWwQ3JO3T7JZXbR3YVN7uA4mXToKsFGqtA>
    <xme:r2DIZ9BOwySyQaUu5yOzsYC0dZ_xjbO4a59Aw41jiq2qQKVJeCkzj3PZS6kzLVPjc
    kC2m3bge4eo-iz_PLI>
X-ME-Received: <xmr:r2DIZ8HGFx_zc-KqFCa658sQeUISG7qKiSRmVrFGsSvFeKxd94HGnJpv7t2MDtLevzCHrWja9hO7XbM1Mgk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdehtdejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtkeertder
    tdejnecuhfhrohhmpegrrhhthhhurhesrghrthhhuhhrfhgrsghrvgdrtghomhenucggtf
    frrghtthgvrhhnpeefkefhgeevhfeiffegfefgheeijeevgfehfeelhffguefgudelveej
    geffuefhvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpegrrhhthhhurhesrghrthhhuhhrfhgrsghrvgdrtghomhdpnhgspghrtghpthhtohep
    ledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepthhhohhilhgrnhgusehrvgguhh
    grthdrtghomhdprhgtphhtthhopehlsghirghntghonhesrhgvughhrghtrdgtohhmpdhr
    tghpthhtohephhgrfihksehkvghrnhgvlhdrohhrghdprhgtphhtthhopegsphhfsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghfrggsrhgvsegtlhhouhgufhhl
    rghrvgdrtghomhdprhgtphhtthhopehjrghkuhgssegtlhhouhgufhhlrghrvgdrtghomh
    dprhgtphhtthhopeihrghnsegtlhhouhgufhhlrghrvgdrtghomhdprhgtphhtthhopehn
    vghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjsghrrghnug
    gvsghurhhgsegtlhhouhgufhhlrghrvgdrtghomh
X-ME-Proxy: <xmx:r2DIZ1RygHbP-Vxzaw9yI1jXTPTUp8e07QA2v1rqY_gSPRDdNJUOpA>
    <xmx:r2DIZxzqG1Vkf-xae0JpKMO1w0G0PCmX6M77jsUCMEpWJQBoEWs6Ow>
    <xmx:r2DIZz5y7uvkpfIK47jq-6h9FpalTBjW6OadSpwVojtQW1IASfRanQ>
    <xmx:r2DIZ-zp7zZOG3TxH1NsIBJPznepmDRhTk8Q8L8XyafMzVagt6lzgA>
    <xmx:r2DIZxfQpoJJXZexWwD4FK8iKwkq6358nPA0AGNnF06_Z12RQXBnedOc>
Feedback-ID: i25f1493c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Mar 2025 09:33:17 -0500 (EST)
From: arthur@arthurfabre.com
Date: Wed, 05 Mar 2025 15:31:58 +0100
Subject: [PATCH RFC bpf-next 01/20] trait: limited KV store for packet
 metadata
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250305-afabre-traits-010-rfc2-v1-1-d0ecfb869797@cloudflare.com>
References: <20250305-afabre-traits-010-rfc2-v1-0-d0ecfb869797@cloudflare.com>
In-Reply-To: <20250305-afabre-traits-010-rfc2-v1-0-d0ecfb869797@cloudflare.com>
To: netdev@vger.kernel.org, bpf@vger.kernel.org
Cc: jakub@cloudflare.com, hawk@kernel.org, yan@cloudflare.com, 
 jbrandeburg@cloudflare.com, thoiland@redhat.com, lbiancon@redhat.com, 
 Arthur Fabre <afabre@cloudflare.com>
X-Mailer: b4 0.14.2

From: Arthur Fabre <afabre@cloudflare.com>

A (very limited) KV store to support storing KVs in the packet headroom,
with:
- 64 keys (0-63).
- 2, 4 or 8 byte values.
- O(1) lookup
- O(n) insertion
- A fixed 16 byte header.

Values are stored ordered by key, immediately following the fixed
header.

This could be extended in the future, for now it implements the smallest
possible API. The API intentionally uses u64 keys to not impose
restrictions on the implementation in the future.

I picked 2¸ 4, and 8 bytes arbitrarily. We could also support 0 sized
values for use as flags.
A 16 byte value could be useful to store UUIDs and IPv6 addresses.
If we want more than 3 sizes, we can add a word to the header (for a
total of 24 bytes) to support 7 sizes.

We could also allow users to set several consecutive keys in one
trait_set() call to support storing larger values.

Implemented in the header file so functions are always inlinable.

Signed-off-by: Arthur Fabre <afabre@cloudflare.com>
---
 include/net/trait.h | 243 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 243 insertions(+)

diff --git a/include/net/trait.h b/include/net/trait.h
new file mode 100644
index 0000000000000000000000000000000000000000..536b8a17dbbc091b4d1a4d7b4b21c1e36adea86a
--- /dev/null
+++ b/include/net/trait.h
@@ -0,0 +1,243 @@
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
+ * - 2, 4 or 8 byte values.
+ * - O(1) lookup
+ * - O(n) insertion
+ * - A fixed 16 byte header.
+ */
+struct __trait_hdr {
+	/* Values are stored ordered by key, immediately after the header.
+	 *
+	 * The size of each value set is stored in the header as two bits:
+	 *  - 00: Not set.
+	 *  - 01: 2 bytes.
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
+	 *  - Calculate the hamming weight / population count of each word.
+	 *    Single instruction on modern amd64 CPUs.
+	 *  - hweight(low) + hweight(high)<<1 is offset.
+	 */
+	u64 high;
+	u64 low;
+};
+
+static __always_inline bool __trait_valid_len(u64 len)
+{
+	return len == 2 || len == 4 || len == 8;
+}
+
+static __always_inline bool __trait_valid_key(u64 key)
+{
+	return key < 64;
+}
+
+static __always_inline int __trait_total_length(struct __trait_hdr h)
+{
+	return (hweight64(h.low) << 1) + (hweight64(h.high) << 2)
+		// For size 8, we only get 4+2=6. Add another 2 in.
+		+ (hweight64(h.high & h.low) << 1);
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
+	case 2:
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


