Return-Path: <bpf+bounces-53325-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BAB5A50220
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 15:35:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D8AE1896451
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 14:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACCA524EAB6;
	Wed,  5 Mar 2025 14:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arthurfabre.com header.i=@arthurfabre.com header.b="bbbDaCzR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="x96j8RKd"
X-Original-To: bpf@vger.kernel.org
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9251724EA95;
	Wed,  5 Mar 2025 14:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741185209; cv=none; b=LsxT89jole9hNBH8VxAww3swKW4+IEdbobumve+SXj5XvhbGh6xrRS7vMHK11c79BzY0uhZLfhvTprlteuttNpWsAM45Z4WlFJaZ63VoOeWnXPJx1lvrFhnAC+KJLB8ZPbgBTo69BhPQ0YVuUYXW9vHaUaewBGYMZHGbNOTziDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741185209; c=relaxed/simple;
	bh=qxv1LsAKRqsKUxDL/Dxta7IuAJCwzGHmYrXlzUsT8vc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aLZIPElRYk1D1TcSyvI3jJ0xHBo4fmgdpuGDZBMmwV6gAjaYzDFxL4e5YdYieWtkTfH2uAaPJwbMogxWsTgS0re19ZjuY2zNcJtatVo/q2SYYap7qXOUEmLkmhlSnn7CSd85FqvoImdbx9eHLckzHCsyOLRuWEKHggJGSRZEtT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arthurfabre.com; spf=pass smtp.mailfrom=arthurfabre.com; dkim=pass (2048-bit key) header.d=arthurfabre.com header.i=@arthurfabre.com header.b=bbbDaCzR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=x96j8RKd; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arthurfabre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arthurfabre.com
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9B1051140210;
	Wed,  5 Mar 2025 09:33:26 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Wed, 05 Mar 2025 09:33:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arthurfabre.com;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm3;
	 t=1741185206; x=1741271606; bh=qelSNgB8wnspupq2rYPj+q9VuLNr5Cac
	v5miRIDC3NU=; b=bbbDaCzRKMzXPakKx1VApcuRpbKYY7Xt0EBXmHIF21TK8LRL
	z8MI62ykQ2Ll90xh1oC3gCEA0IsSzIT+nz0ldhHTUtD/fd4lL0KG2iN7/5g5Iyyl
	pTYGyz3mnuarquMnIsRD0t33+7Bc6hTPKxMR8hPEXOqJz1D+6Cg4+TvoMOp7dPT4
	pDvojuL8XAB1Bo5+di/E2S4tAeA6GLI5n0DO+K22NYXL9r7HIMjCUC/+EfwEfHjb
	DT7WTeA5rMn5C1lhsPFw77KqEbCBhvplFXFbbzRM5YQL73SwW7RefKEM42GsmdI5
	EKxRzCz4KGM+aTwVZrvinkTTd65qd2XQIvtr5w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741185206; x=
	1741271606; bh=qelSNgB8wnspupq2rYPj+q9VuLNr5Cacv5miRIDC3NU=; b=x
	96j8RKdl54gaKPLioY7H/qxkoVMGuSc85WKZ5jMKBLdP91jq29aRT02tdRJg3hyg
	u2ckM39vq7m2pT226KqXqLYiBB8cvpY9+fa8s5kPPdBWzYZsPQmhWdxqfOCXsijS
	Cg2GjkQrj3yZy5RiQcIBNcPB1oetDZZAyq+biFoBDoEpXhKRalTsHb+DzXTdOELZ
	8gU487rQ0yiLXDlj4HSjrJNFMxMevEuHATgmnSw2BpNAuXJM0OC8v8CJ5Rl+nEfr
	oRZjHe8Uv8RF4IJzKGCsh4338dfKgExrXfZRDjbOBJ0ynfpRkcMw4MqlT80KB4nK
	BDySLTtXA6YFlpEwAdIiw==
X-ME-Sender: <xms:tmDIZ_sHxG82qi91XsCgE4DGbd8k2Rd2Oc6YMBg-k30CTDAZG1HWdg>
    <xme:tmDIZwcE_QJyHM5w60e8scKn-9k6DBQNQjre6WTTslXLIpd9f2hy7m3Ij4LgaL6dP
    wp_E62Du8BbALjE4c4>
X-ME-Received: <xmr:tmDIZyxZLVeQcIAXRJbhKzyi-1-gJY_tjpfL8c9GghiMH8rqmiBOTqSBEcifb8XNvf1oONUchkJpCJ6Pwzk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdehtdejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpegrrhhthhhurhesrghrthhhuhhrfhgrsghrvgdrtghomhenucggtf
    frrghtthgvrhhnpeffueehtddtkeetgfelteejledvjeekgeduleffjeetfeekveeggffh
    fefhvdegffenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhroh
    hmpegrrhhthhhurhesrghrthhhuhhrfhgrsghrvgdrtghomhdpnhgspghrtghpthhtohep
    ledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepthhhohhilhgrnhgusehrvgguhh
    grthdrtghomhdprhgtphhtthhopehlsghirghntghonhesrhgvughhrghtrdgtohhmpdhr
    tghpthhtohephhgrfihksehkvghrnhgvlhdrohhrghdprhgtphhtthhopegsphhfsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghfrggsrhgvsegtlhhouhgufhhl
    rghrvgdrtghomhdprhgtphhtthhopehjrghkuhgssegtlhhouhgufhhlrghrvgdrtghomh
    dprhgtphhtthhopeihrghnsegtlhhouhgufhhlrghrvgdrtghomhdprhgtphhtthhopehn
    vghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjsghrrghnug
    gvsghurhhgsegtlhhouhgufhhlrghrvgdrtghomh
X-ME-Proxy: <xmx:tmDIZ-Pr333o9ods6fJx0XjI3ybkUmjhG5RScBGSZtAdXIu3CrP8bg>
    <xmx:tmDIZ_8lzVEEbTymZDyV6CzcYb40QdzUnjZbgcCxE4lfcKw4XvLRww>
    <xmx:tmDIZ-Xjds45SVOlEa3GLGzd_5MzT2f9_H3w8vPPRpoWRtlDMqbr4A>
    <xmx:tmDIZwdYGNlXrDYS89YnULRJxmEft-ktvVqkvtzGEohiC-8_2krLRw>
    <xmx:tmDIZ2bLo9WvPlzauya7TGAlQ79oYET4rhOH-OYk6hMrgGYR72bIEM-f>
Feedback-ID: i25f1493c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Mar 2025 09:33:24 -0500 (EST)
From: arthur@arthurfabre.com
Date: Wed, 05 Mar 2025 15:32:02 +0100
Subject: [PATCH RFC bpf-next 05/20] trait: Replace memcpy calls with inline
 copies
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250305-afabre-traits-010-rfc2-v1-5-d0ecfb869797@cloudflare.com>
References: <20250305-afabre-traits-010-rfc2-v1-0-d0ecfb869797@cloudflare.com>
In-Reply-To: <20250305-afabre-traits-010-rfc2-v1-0-d0ecfb869797@cloudflare.com>
To: netdev@vger.kernel.org, bpf@vger.kernel.org
Cc: jakub@cloudflare.com, hawk@kernel.org, yan@cloudflare.com, 
 jbrandeburg@cloudflare.com, thoiland@redhat.com, lbiancon@redhat.com, 
 Arthur Fabre <afabre@cloudflare.com>
X-Mailer: b4 0.14.2

From: Arthur Fabre <afabre@cloudflare.com>

When copying trait values to or from the caller, the size isn't a
constant so memcpy() ends up being a function call.

Replace it with an inline implementation that only handles the sizes we
support.

We store values "packed", so they won't necessarily be 4 or 8 byte
aligned.

Setting and getting traits is roughly ~40% faster.

Signed-off-by: Arthur Fabre <afabre@cloudflare.com>
---
 include/net/trait.h | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/include/net/trait.h b/include/net/trait.h
index 536b8a17dbbc091b4d1a4d7b4b21c1e36adea86a..d4581a877bd57a32e2ad032147c906764d6d37f8 100644
--- a/include/net/trait.h
+++ b/include/net/trait.h
@@ -7,6 +7,7 @@
 #include <linux/errno.h>
 #include <linux/string.h>
 #include <linux/bitops.h>
+#include <linux/unaligned.h>
 
 /* Traits are a very limited KV store, with:
  * - 64 keys (0-63).
@@ -145,23 +146,23 @@ int trait_set(void *traits, void *hard_end, u64 key, const void *val, u64 len, u
 			memmove(traits + off + len, traits + off, traits_size(traits) - off);
 	}
 
-	/* Set our value. */
-	memcpy(traits + off, val, len);
-
-	/* Store our length in header. */
 	u64 encode_len = 0;
-
 	switch (len) {
 	case 2:
+		/* Values are least two bytes, so they'll be two byte aligned */
+		*(u16 *)(traits + off) = *(u16 *)val;
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
@@ -201,7 +202,19 @@ int trait_get(void *traits, u64 key, void *val, u64 val_len)
 	if (real_len > val_len)
 		return -ENOSPC;
 
-	memcpy(val, traits + off, real_len);
+	switch (real_len) {
+	case 2:
+		/* Values are least two bytes, so they'll be two byte aligned */
+		*(u16 *)val = *(u16 *)(traits + off);
+		break;
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


