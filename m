Return-Path: <bpf+bounces-56397-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90949A96C7D
	for <lists+bpf@lfdr.de>; Tue, 22 Apr 2025 15:25:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACECC17C6B8
	for <lists+bpf@lfdr.de>; Tue, 22 Apr 2025 13:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A3D4284B4A;
	Tue, 22 Apr 2025 13:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arthurfabre.com header.i=@arthurfabre.com header.b="CSZgF6UD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MgcOnQV/"
X-Original-To: bpf@vger.kernel.org
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEEB7284B3A;
	Tue, 22 Apr 2025 13:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745328248; cv=none; b=E9lwaiYSFifW60m1HIikE6Qpodj7SX3T1w+MQ5C+tuwB2lp8EJ7CEBBFJtbdS2tcIhEz1wL4k4wAh/RUSPEq6NHXNPpRVHL5imcfQPCTRKZusrTsdVHMQQt0W/+/545Nxfr0f8GPq69HO+P6LFTYVkFEil3wKuagYJhQAqqwnZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745328248; c=relaxed/simple;
	bh=jT4Q3eT5i2cxqDFx2ZWE9IRI77i879/YJiS1aqW7MgI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YZoj7pvWBILmCO5h/VfvvzYc3fBeClYDDZCByS/7ghoxEJElMGEhnYUnCvmTw6TxLhCEtAD8wW6ZNvahwBcWdOzWBL9KQPhd1jKjLGl+bnGYbS7yEsrUYRIElXiY4HvqGCk6UUjDk7twJHHRcFgrMO2hJv5NDw+ycPqoehpDUy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arthurfabre.com; spf=pass smtp.mailfrom=arthurfabre.com; dkim=pass (2048-bit key) header.d=arthurfabre.com header.i=@arthurfabre.com header.b=CSZgF6UD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MgcOnQV/; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arthurfabre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arthurfabre.com
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id A7DB811401A5;
	Tue, 22 Apr 2025 09:24:04 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 22 Apr 2025 09:24:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arthurfabre.com;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm1;
	 t=1745328244; x=1745414644; bh=RebCkDrKo004tV0wOx8hzrDwtx5JZloT
	o5iKPL2aips=; b=CSZgF6UDCvJRiPwdXeVSpHhyJp8xaANIW3xOkoOJb3/XMpW4
	Q7tluzD6Tn/HEv9TQW56khWlQb0r6LTpq1FemNCyAuJBGFexgu/o7mB79MvZyniQ
	mu1ji/7LQG4av2wqwDND2Do3nq6nHBMKhu2m2fSn3DmiccEYaYt0zJn8wiCBNycp
	GM25WANp60L3OmPqQwWRPrNsBqn9T0+ynCrFJejcT5ypvv1h4xu0XkFWTkDq5fzu
	y+F8H6RVfkO+QjJg/357P7CnKTYJd+YCmDKorlXObiXvlLfgCKk43YwbH5ZenH+K
	uOYekW8tsf5sE5CH7GSn12pEYh5LVxibZc5xVQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1745328244; x=
	1745414644; bh=RebCkDrKo004tV0wOx8hzrDwtx5JZloTo5iKPL2aips=; b=M
	gcOnQV/VsLqITzeQRN8bWC3M2rIcp0h0JTODoL937mzxsSmivpm37KEnQ4T24PNq
	ubaTPnsnV7x2lDuDibNhANZgNbsRomX0CWmAEq3YbcPLjGY+81WWLyzeqM1Mo6gL
	fcGWFg9xwrbs8JL9G2qsoAL9J0gBB8+9bOEiwnHhduQFwBpQO5rcV91Wp4x1Mdaj
	ZYo1M5242wpQtzahCFw2PkAPyGH2UOWgNxgM7I1kFAOqyzUljwUZvgAImCKB5nvG
	9sNWVxxRil/Id7vMjbN1rqSwZ2IJSMzUdMkcDxI1oK0kxOm3nyL2ajZZvzILx8GF
	TA2LqfHjpJi3PejPXzosA==
X-ME-Sender: <xms:dJgHaNdlLaipukNS0FgekONj_N3PM4lp4H-AuxOH_ISa4uXU9ZyLGA>
    <xme:dJgHaLOi_QAgaSZ4o6n0diK1UnkgNU6eO7lr4dTYMpQ_EC30nCNw-7Y-W6uAUgVqO
    tcF-L3abWmGTotw1rg>
X-ME-Received: <xmr:dJgHaGhwj3pN7gNVfQgMdC1zmI_WOSeI3lhggTrraVivndZg4HcCbaBt-yZGfACGvunMNm2qW3bOOcrR0-I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgeefkeehucetufdoteggodetrf
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
X-ME-Proxy: <xmx:dJgHaG-40yIb436WdmEAdcRuThM-WunZr6m8O8NyIqrR9DIRm_rOtA>
    <xmx:dJgHaJsFcZBCWeAIyQwv0N1uaZP8koUyhXH0Y_cLZiXhn-C5jbt4xg>
    <xmx:dJgHaFFB8yDM_WvqPqOTLkzYA9-H3FM3S-eAQIkGBOwRfOkUq3JYqQ>
    <xmx:dJgHaAMni3sU15GaIQvNm0TX2XKxJankRzf2zsBVhdrbtxZoFNchJg>
    <xmx:dJgHaACDd66WSaGcPgREeErYC6fbObVzhC_Cv8Eb2QCtQLuUqZk3z1HO>
Feedback-ID: i25f1493c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Apr 2025 09:24:02 -0400 (EDT)
From: Arthur Fabre <arthur@arthurfabre.com>
Date: Tue, 22 Apr 2025 15:23:35 +0200
Subject: [PATCH RFC bpf-next v2 06/17] trait: Replace memcpy calls with
 inline copies
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250422-afabre-traits-010-rfc2-v2-6-92bcc6b146c9@arthurfabre.com>
References: <20250422-afabre-traits-010-rfc2-v2-0-92bcc6b146c9@arthurfabre.com>
In-Reply-To: <20250422-afabre-traits-010-rfc2-v2-0-92bcc6b146c9@arthurfabre.com>
To: netdev@vger.kernel.org, bpf@vger.kernel.org
Cc: jakub@cloudflare.com, hawk@kernel.org, yan@cloudflare.com, 
 jbrandeburg@cloudflare.com, thoiland@redhat.com, lbiancon@redhat.com, 
 ast@kernel.org, kuba@kernel.org, edumazet@google.com, 
 Arthur Fabre <arthur@arthurfabre.com>
X-Mailer: b4 0.14.2

When copying trait values to or from the caller, the size isn't a
constant so memcpy() ends up being a function call.

Replace it with an inline implementation that only handles the sizes we
support.

We store values "packed", so they won't necessarily be 4 or 8 byte
aligned.

Setting and getting traits is roughly ~40% faster.

Signed-off-by: Arthur Fabre <arthur@arthurfabre.com>
---
 include/net/trait.h | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/include/net/trait.h b/include/net/trait.h
index af42c1ad2416d5c38631f1f0305ef9fefe43bd87..4013351549731c4e3bede211dbe9fbe651556dc9 100644
--- a/include/net/trait.h
+++ b/include/net/trait.h
@@ -7,6 +7,7 @@
 #include <linux/errno.h>
 #include <linux/string.h>
 #include <linux/bitops.h>
+#include <linux/unaligned.h>
 
 /* Traits are a very limited KV store, with:
  * - 64 keys (0-63).
@@ -144,23 +145,21 @@ int trait_set(void *traits, void *hard_end, u64 key, const void *val, u64 len, u
 			memmove(traits + off + len, traits + off, traits_size(traits) - off);
 	}
 
-	/* Set our value. */
-	memcpy(traits + off, val, len);
-
-	/* Store our length in header. */
 	u64 encode_len = 0;
-
 	switch (len) {
 	case 0:
 		encode_len = 1;
 		break;
 	case 4:
+		put_unaligned(*(u32 *)val, (u32 *)(traits + off));
 		encode_len = 2;
 		break;
 	case 8:
+		put_unaligned(*(u64 *)val, (u64 *)(traits + off));
 		encode_len = 3;
 		break;
 	}
+
 	h->high |= (encode_len >> 1) << key;
 	h->low |= (encode_len & 1) << key;
 	return 0;
@@ -195,7 +194,7 @@ int trait_is_set(void *traits, u64 key)
  * @val_len: The length of val.
  *
  * Return:
- * * %>0      - Actual size of value.
+ * * %>=0     - Actual size of value.
  * * %-EINVAL - Key or length invalid.
  * * %-ENOENT - Key has not been set with trait_set() previously.
  * * %-ENOSPC - Val is not big enough to hold stored value.
@@ -221,7 +220,15 @@ int trait_get(void *traits, u64 key, void *val, u64 val_len)
 	if (real_len > val_len)
 		return -ENOSPC;
 
-	memcpy(val, traits + off, real_len);
+	switch (real_len) {
+	case 4:
+		*(u32 *)val = get_unaligned((u32 *)(traits + off));
+		break;
+	case 8:
+		*(u64 *)val = get_unaligned((u64 *)(traits + off));
+		break;
+	}
+
 	return real_len;
 }
 

-- 
2.43.0


