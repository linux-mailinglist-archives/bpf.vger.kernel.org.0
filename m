Return-Path: <bpf+bounces-61842-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B638AEE199
	for <lists+bpf@lfdr.de>; Mon, 30 Jun 2025 16:56:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7793016DBCA
	for <lists+bpf@lfdr.de>; Mon, 30 Jun 2025 14:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 604ED28C5DB;
	Mon, 30 Jun 2025 14:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Xx5XbX/j"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5AF28DB7A
	for <bpf@vger.kernel.org>; Mon, 30 Jun 2025 14:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751295362; cv=none; b=ntamAAIurO8M/eZ7in9IwXILmFG3hdAULF3OITE+px6CXnDV1YsGOTPj2zJjnuGIKJ6/yxtAndbBsIFttJL+nmvL/EX42r6gOztyzEPfrgZgsIMT8c8KHKsbZVljFtm5G0JyMLWTtm2gwuefM3giAr4DwgMXL7PcWTue0EMCNag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751295362; c=relaxed/simple;
	bh=7JE3/zTuFsdK18Qj0ytha0rL9JEyz2yJs29Jlr1Oz10=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MI6uxFE/CD2rW4Fc5/y5qJooHl0FRgycLiGZ3IywZvooY19faENIV8dap/VD0cHqaGWUWtWrOZcKF01D6ppUCiV4L49b2N+0xXQXPewpEyFzSUFu49c4Rvxh16zTvvyc0Q3Z2ZD0EfSWm+JryfM5S63ImDg0M5eKTNLkau57cCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Xx5XbX/j; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ae360b6249fso521064066b.1
        for <bpf@vger.kernel.org>; Mon, 30 Jun 2025 07:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1751295359; x=1751900159; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U1kpOesSXlO+zwvIVzaNY3+mGeXYR8L4I5ZHqTGx23Q=;
        b=Xx5XbX/jwNVH2HZTOXsFGX8GWFe8dDK874N7KW2DNrFVKRazdO2PZErR1jRL6YrDag
         KEOsKEQqw8VAt3RPgfrPzz903k98e5SM1BAKNGta1XUW8IMY28xrShuwZjQxm3ame8ub
         QMdkJaJm4C0BnF+w0ZP82BEobFvYojFBb7Pe328+cwYkkH2Xa9c9m4Pm7bzK/7xiGM6y
         biEF6//T0V7XP/XdnlPnOayq5SIMW09PQD2PeZtrgCp5cMGa8Q6LXkja+RwhOZT+fFG0
         4QBe1YD1W+LYU9vZGimHKmXFC+NQGaHL/YXHpPuB5WUcAUj9SWEHUgMDLinU9fdNJfJ0
         bu/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751295359; x=1751900159;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U1kpOesSXlO+zwvIVzaNY3+mGeXYR8L4I5ZHqTGx23Q=;
        b=fLXZfP2g7DJLIKS41TByexl7IrEKzXqSNWgS9Mpo4IHiIg6xeG+2B4Xl2UL6MhyA7X
         cwXy+iVCF3j3Yu75mo312cWxu6pEn62u1v6O7uYZX8JRx+f2qAxKz4hyLHInhEYY3+4x
         BSPH/oKSPMQ3Zve2hTTr/HGjnE7lCG99qip7Odel/TksfoHS5LH3uEykv1ZAg1vWDvlM
         GdUatyqTo6HDo+OvATiTAs0agITUzEMwsItxWV37WujTFWfs18n7jtESPCaLc14riD5O
         amrS8DrejPKUNwcI9umUwypgmbqDYV2CeMqup3EUNCT8xoAQ8BqjKt86i5IaFF2yPWPQ
         FNLg==
X-Gm-Message-State: AOJu0YwhzZE/EwfTuoPFuqw2VOBqPZko804Pxubhi1ZhmehD0KQuHOtj
	dSE7+r0PYmPY0U730fejnCYLBjOpOhve7pRSOoTLROf5hcMQZTPHc4SH23o8fbe0g58=
X-Gm-Gg: ASbGncvp0my2aPFT2FTjltM7sVPks1Nv7b4MzKySSSyw0nKGK3tUEPxO4P2lejAmr78
	olmDRhSoUOvE+Fl9g2+pybqUAdY5MFkgG0Tf29fqSdpU1sH163kvayr+PWHieIrz0CCi0mrIk3D
	uBvOmcAzClxQUWegoqajWk1/nlH5S89VvAeBJql82ITJ0J/iP5FcY4QVThaC/FRbRjD9M2HynJZ
	IiTN3wrQX+NyC9/wK63p8/zMRcuhgkJyHgWP4xkU+TvxkPDCVL+RCY7QH66lp3CmuEUKI3sB4o0
	V4j+z+ORNaRyjlLZfsBD18Bn/49y0CLdHN5h7MIGK4c7ra7Or8yY9Q==
X-Google-Smtp-Source: AGHT+IHcHR1xY0UZjLvtYNSXxH0/Z467o845yTpPG1RSgcI9vsbWJprfICNKfzAuj22cLyJg1+cqeA==
X-Received: by 2002:a17:907:7f8f:b0:ae0:a359:a95c with SMTP id a640c23a62f3a-ae3500f6720mr1249738366b.34.1751295359329;
        Mon, 30 Jun 2025 07:55:59 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2dc::49:10a])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae3a36c4940sm66054266b.79.2025.06.30.07.55.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 07:55:58 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Mon, 30 Jun 2025 16:55:38 +0200
Subject: [PATCH bpf-next 05/13] bpf: Enable write access to skb metadata
 with bpf_dynptr_write
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250630-skb-metadata-thru-dynptr-v1-5-f17da13625d8@cloudflare.com>
References: <20250630-skb-metadata-thru-dynptr-v1-0-f17da13625d8@cloudflare.com>
In-Reply-To: <20250630-skb-metadata-thru-dynptr-v1-0-f17da13625d8@cloudflare.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, 
 Arthur Fabre <arthur@arthurfabre.com>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
 Jesse Brandeburg <jbrandeburg@cloudflare.com>, 
 Joanne Koong <joannelkoong@gmail.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>, 
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <thoiland@redhat.com>, 
 Yan Zhai <yan@cloudflare.com>, netdev@vger.kernel.org, 
 kernel-team@cloudflare.com, Stanislav Fomichev <sdf@fomichev.me>
X-Mailer: b4 0.15-dev-07fe9

Make it possible to write to skb metadata area using the
bpf_dynptr_write() BPF helper.

This prepares ground for access to skb metadata from all BPF hooks
which operate on __sk_buff context.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 net/core/filter.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index f71b4b6b09fb..ab6599f42bb7 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -12005,8 +12005,15 @@ int bpf_dynptr_skb_write(const struct bpf_dynptr_kern *dst, u32 offset,
 	case SKB_DYNPTR_PAYLOAD:
 		return ____bpf_skb_store_bytes(skb, offset, src, len, flags);
 
-	case SKB_DYNPTR_METADATA:
-		return -EOPNOTSUPP; /* not implemented */
+	case SKB_DYNPTR_METADATA: {
+		u32 meta_len = skb_metadata_len(skb);
+
+		if (len > meta_len || offset > meta_len - len)
+			return -E2BIG; /* out of bounds */
+
+		memmove(skb_metadata_end(skb) - meta_len + offset, src, len);
+		return 0;
+	}
 
 	default:
 		WARN_ONCE(true, "%s: unknown skb dynptr offset %d\n", __func__, dst->offset);

-- 
2.43.0


