Return-Path: <bpf+bounces-53326-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D40CA50215
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 15:34:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 485A31688D6
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 14:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64A0C24A073;
	Wed,  5 Mar 2025 14:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arthurfabre.com header.i=@arthurfabre.com header.b="SOHan5ky";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DANHmaR9"
X-Original-To: bpf@vger.kernel.org
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3284624EF77;
	Wed,  5 Mar 2025 14:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741185210; cv=none; b=lbj/YIBjhYUNgIgiZnqi2BsM7rgU8nBzd4aGBunLBTTJa87vY0uymz8Cdxz2+NnpuQG7YQQvtcs3CajpXC3vMjWO/vH7xrXiJO9imDqqs1UJwgDEwRaOsefoU9rmNQENvTTTcX+WtsZbe4dRZ4+5b529ewq27uKKq0WYzYPEWvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741185210; c=relaxed/simple;
	bh=AXqsGUMZjJ3nfR3/zpLp0QNglAVCz66tV2016FOkt0w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ueEbcBPSZlMgLWt7Q8Rcxx3Sx8fHOIe3gEEaNV8ylGSePdJn0JDnq4NNo2iWHDaN69XMqYdxDUkK6ylGBrOX21qmYVHc3iyx8krMH2B+25T8/Z3+Myl+ZvsHcPqVF0VhRtoY+ESJM1cwEu0JRtu//TwUQCGk+0EZpYYY7dOasig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arthurfabre.com; spf=pass smtp.mailfrom=arthurfabre.com; dkim=pass (2048-bit key) header.d=arthurfabre.com header.i=@arthurfabre.com header.b=SOHan5ky; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DANHmaR9; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arthurfabre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arthurfabre.com
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 405DF13826E8;
	Wed,  5 Mar 2025 09:33:28 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 05 Mar 2025 09:33:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arthurfabre.com;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm3;
	 t=1741185208; x=1741271608; bh=fNt401R7YNbzRDUFKtOB/YgJSARNk28u
	a1w/BTuFA1g=; b=SOHan5kyO0cEfhLA6U9WbjJxxREzaRlc51s56z3R1Vhcr0Vs
	Fgtw0o72cDdIwNWvRfbT/AtyL7OSn6Lo2boyrZDaECoOHuesQmdkhz+P1R0819NV
	ylIDnXCQG9AYot9O/by4zArKlHgCONzQVUrv1uzMw7QSuOlRALumrII2pTdcL0L/
	ist4KkmR7pGtl1BcRsB/JJ0lgDSynzsblJzis8zfkDE3aTd7lwmo1hcQVahi2Gzk
	LY5GYo6B046DqoRTfH/SVMaHFrbuRBpjFNiq28Cnox8xWnWQp609Uyey3+r47DhO
	OWj6ocA82X3vCdnb01jIRR3nCvv4YL/f/wzKlw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741185208; x=
	1741271608; bh=fNt401R7YNbzRDUFKtOB/YgJSARNk28ua1w/BTuFA1g=; b=D
	ANHmaR9f0SH8udbtIKois+MoYtoMiNftseEsCiNTBXzgrO56IwP225iDkIGdgxkg
	9TBFV+KU2JRtklbqMl6kM7hfcDl9K1eFk4x9rD02O0qCLsfwbPmYTqNdv1Ol18m2
	HI3ArQZPJpLBp4EOZZ2pabd0DARhyl+YdKj6MWffDqOfb909wxmujIdgj5A1j6G8
	MAj280qMEJWznwwUwpGnrQrIBjA6925o7Fxy5bbaDHI5ea7PvGriupMjVs+mbiFp
	ayaG0Q2IXgu6lDOxp+IcLO08ol3BAThdk5Fr5IM7c/fFX8IxP+/l44UISuuAoiKO
	61Q0Tc3/k39AWKO3oLVmw==
X-ME-Sender: <xms:uGDIZyuMFiTxyg-QCw1za1wh67FAe9QWmT0aS6I7OtNq596-0BvVZQ>
    <xme:uGDIZ3dsImkzz-_77Zna_1unGnMa8BkMYx93QuxPwH3xRlZiK8PKQkM6aGLMDK8YF
    EDQhTneBLfDlpsl6jE>
X-ME-Received: <xmr:uGDIZ9xwL9imlplxptHNH05cllDRk5_F1ew79o81NQWCtorr_J68riMMx9UgOOSLmYW-TqUDpA9b9E3M5DQ>
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
X-ME-Proxy: <xmx:uGDIZ9MhTMMK9daGtzA9WA2u8tOx-T2GOW84PkG0g6h9PavvRj9vtw>
    <xmx:uGDIZy-9lfLjosX4Hpit8uHsjGqTCWGxAHYPh3XKSr5jkjvtR96tbw>
    <xmx:uGDIZ1Vj9HtEZnffzA2LisoftFuWgfQ4wRzDEufcaT5YLph-6FWwVg>
    <xmx:uGDIZ7c6RhNPY0ipMLtY6qJd1K07lCzmLdAMjWJJol21Hi2K7S9IMg>
    <xmx:uGDIZ1ZdSb9MsYl65QUbOhQ-Qam30QZbc8EWB8Npgl5lJcE9a7MS1dzp>
Feedback-ID: i25f1493c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Mar 2025 09:33:26 -0500 (EST)
From: arthur@arthurfabre.com
Date: Wed, 05 Mar 2025 15:32:03 +0100
Subject: [PATCH RFC bpf-next 06/20] trait: Replace memmove calls with
 inline move
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250305-afabre-traits-010-rfc2-v1-6-d0ecfb869797@cloudflare.com>
References: <20250305-afabre-traits-010-rfc2-v1-0-d0ecfb869797@cloudflare.com>
In-Reply-To: <20250305-afabre-traits-010-rfc2-v1-0-d0ecfb869797@cloudflare.com>
To: netdev@vger.kernel.org, bpf@vger.kernel.org
Cc: jakub@cloudflare.com, hawk@kernel.org, yan@cloudflare.com, 
 jbrandeburg@cloudflare.com, thoiland@redhat.com, lbiancon@redhat.com, 
 Arthur Fabre <afabre@cloudflare.com>
X-Mailer: b4 0.14.2

From: Arthur Fabre <afabre@cloudflare.com>

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

Signed-off-by: Arthur Fabre <afabre@cloudflare.com>
---
 include/net/trait.h | 40 ++++++++++++++++++++++++++++++++++++----
 1 file changed, 36 insertions(+), 4 deletions(-)

diff --git a/include/net/trait.h b/include/net/trait.h
index d4581a877bd57a32e2ad032147c906764d6d37f8..111ce766345cef45fd95e562eda6a7d01c6b76da 100644
--- a/include/net/trait.h
+++ b/include/net/trait.h
@@ -75,6 +75,40 @@ static __always_inline int __trait_offset(struct __trait_hdr h, u64 key)
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
@@ -142,8 +176,7 @@ int trait_set(void *traits, void *hard_end, u64 key, const void *val, u64 len, u
 			return -ENOSPC;
 
 		/* Memmove all the kvs after us over. */
-		if (traits_size(traits) > off)
-			memmove(traits + off + len, traits + off, traits_size(traits) - off);
+		__trait_move(traits + off, len, traits_size(traits) - off);
 	}
 
 	u64 encode_len = 0;
@@ -244,8 +277,7 @@ static __always_inline int trait_del(void *traits, u64 key)
 	int len = __trait_total_length(__trait_and(*h, (1ull << key)));
 
 	/* Memmove all the kvs after us over */
-	if (traits_size(traits) > off + len)
-		memmove(traits + off, traits + off + len, traits_size(traits) - off - len);
+	__trait_move(traits + off + len, -len, traits_size(traits) - off - len);
 
 	/* Clear our length in header */
 	h->high &= ~(1ull << key);

-- 
2.43.0


