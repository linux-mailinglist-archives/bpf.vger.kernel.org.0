Return-Path: <bpf+bounces-61841-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8B70AEE19F
	for <lists+bpf@lfdr.de>; Mon, 30 Jun 2025 16:57:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DE0A3A5B15
	for <lists+bpf@lfdr.de>; Mon, 30 Jun 2025 14:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45E1228DEE1;
	Mon, 30 Jun 2025 14:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="dcOeAaTN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37FBE28C2C7
	for <bpf@vger.kernel.org>; Mon, 30 Jun 2025 14:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751295360; cv=none; b=mOYZT6TVASXaFuPSspPTiu1Ym6C1CShEPQDQ2FBqm+pwkoMxQ3edZq2UMFtuw3W1N8pfbbOfKybvowuIUjFP0/ypFvZ/q9ftM6ml+qZfpvtluMc14wd2f0dvUI1hlsEkEiEkcuX/xWqy7NhlXFK8CGmgNey4Lv2JFCx+6TX7neQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751295360; c=relaxed/simple;
	bh=tp0/7pjFjNfAWAFW/C1KWpYZ2QVz/ZHonLAAPV1x7es=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TEIALP/P1cqO+ByRQB8+EuTbhCFIgrmwIKECn1ErdDk532G5duL5o9xF91X5R5jLMKZnz0w3701vXIPyYsIuNsaGYmnFkSukv66VZH+Wgh9VyOSEiBiHHIW+5ofOsukL+nRErqwjJtB2C+pLaolA0JnDyi62zvwwBFRvQAOM1Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=dcOeAaTN; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ae0d11bb2a7so673923766b.3
        for <bpf@vger.kernel.org>; Mon, 30 Jun 2025 07:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1751295357; x=1751900157; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k41AK/lAB3G+/40Ifa0LxNODOQcU+nxAOMTyMqx8QrE=;
        b=dcOeAaTNqNtL70NY790AgE+Jr0qbBsgUUeEiTy/T1X4zOlntf8VMHzDzRWH0dWjmnw
         pHOf4t4Seo7xi6l6lY5CLj7due3ftTR/k78j9YcOoI7Zdpk8Ne9GDaMWi+b6L8MGGzoo
         mLxSjS7nMb4k7U6MEJz2XHzOFhNJBBN35Wk10JJF6tozV6K3+yhtwiUqMCJ9ziDBQH44
         si3vg/tmJEmB9z7RGtf6qzqg3mq3QHEU2q7X47UL6XaR1wSkkgCwUxuXXmMCu6DuvjhC
         LO73/sW8nUX1RYrOiPiRodXItOzhcD0575xW6fMaaib20DOAfxtSVORmOHIh/W4qy1gj
         PXWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751295357; x=1751900157;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k41AK/lAB3G+/40Ifa0LxNODOQcU+nxAOMTyMqx8QrE=;
        b=n4VwdJldHAMyT1tL4uZYJYP/b1VnFMql5RhGcNbytKlp2DTWMflUpNf4DqCQZBUltI
         15GvTAQHnnavdjT0wflHUC+veLFu87WGgLl6RA0es+Ce7uo9Z+63XeYoES3FZrOrZBix
         eGOVioRYPqwb2ml9EPVENQrGAtLR3xpHwjdiVQcYBUrSZL9sSlsYdax3jRZuyIIKzQtY
         tk+EZHKWOIq5HjSBc6rPqJbHXDU6EpsahBb02q1Nw+1Mg3OdYq53Nfc1mm0/hpARBZI2
         c03Tq6JqEDxceeqOdmkmuXE621Bwd3gVrT/dUvTOTnP9kD33JVPMAtn5UP4Tx+UaUNtw
         uP+w==
X-Gm-Message-State: AOJu0Yz7wi7OJll31wi1gDzvaKBLH7MNuT0WwvunB03vSYE+gmZ6tyDK
	TF+HVXSdZ3gLh9aIQ0jccmgXuYzjR3rnRj4pCqEGx0huu1ugvVzPks2Vo18z1QLtS04=
X-Gm-Gg: ASbGncvhYYpZHvzDewgxZjgg4uVTUiduWFoRjpg1Dd/yPZ8ToGA+C9rmUvXf1xrHWEk
	Mb148veq79NUREV3A1YMthBYeWxoKS9apF0aW/iTrqAIB/o/Vg+dlLbgtL1gEZ6jiOGFSXcSzhG
	+uwHNUvH457lxyWJRFqHEEIvfLcx2Lsn7XCO78k8oWlMWJL9Gmp9ixpxTvYSF8FFS4Ev/nx9ILl
	FyHH65Acdqve7MNfaBoC7+mPMHm3/Rq8SmqnFtdimggCpY0sfBKgngK+F43whnB5AdWmMXugkD+
	yFxty8I+chAMl1ueKu6umN5gz3lTcR/wNEQS4KiDUmk7jiL+jbQVN4UC0A4/Pwfs
X-Google-Smtp-Source: AGHT+IEpSFErIgm6d8K8Dy8kPG6FK9iw/JChQUjUTnZ195PoQpTGZUwpwACE1W5B9PCdsQxcVSB9Ew==
X-Received: by 2002:a17:907:3f97:b0:ae3:6cc8:e431 with SMTP id a640c23a62f3a-ae36cc94000mr999635866b.57.1751295357381;
        Mon, 30 Jun 2025 07:55:57 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2dc::49:10a])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae353c6bca2sm691248166b.111.2025.06.30.07.55.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 07:55:56 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Mon, 30 Jun 2025 16:55:37 +0200
Subject: [PATCH bpf-next 04/13] bpf: Enable read access to skb metadata
 with bpf_dynptr_read
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250630-skb-metadata-thru-dynptr-v1-4-f17da13625d8@cloudflare.com>
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

Make it possible to read from skb metadata area using the
bpf_dynptr_read() BPF helper.

This prepares ground for access to skb metadata from all BPF hooks
which operate on __sk_buff context.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 net/core/filter.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 3c2948517838..f71b4b6b09fb 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -11981,9 +11981,15 @@ int bpf_dynptr_skb_read(const struct bpf_dynptr_kern *src, u32 offset,
 	case SKB_DYNPTR_PAYLOAD:
 		return ____bpf_skb_load_bytes(skb, offset, dst, len);
 
-	case SKB_DYNPTR_METADATA:
-		return -EOPNOTSUPP; /* not implemented */
+	case SKB_DYNPTR_METADATA: {
+		u32 meta_len = skb_metadata_len(skb);
+
+		if (len > meta_len || offset > meta_len - len)
+			return -E2BIG; /* out of bounds */
 
+		memmove(dst, skb_metadata_end(skb) - meta_len + offset, len);
+		return 0;
+	}
 	default:
 		WARN_ONCE(true, "%s: unknown skb dynptr offset %d\n", __func__, src->offset);
 		return -EFAULT;

-- 
2.43.0


