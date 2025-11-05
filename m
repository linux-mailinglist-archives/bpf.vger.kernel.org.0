Return-Path: <bpf+bounces-73702-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C7CBBC37AF1
	for <lists+bpf@lfdr.de>; Wed, 05 Nov 2025 21:20:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 53DAA4E8EF4
	for <lists+bpf@lfdr.de>; Wed,  5 Nov 2025 20:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4F20335569;
	Wed,  5 Nov 2025 20:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="av/s3W2l"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A650A3469EE
	for <bpf@vger.kernel.org>; Wed,  5 Nov 2025 20:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762373996; cv=none; b=GHyBNTVEP8Q67yc6ZSYh3iQIpZhz8EesghjahEsD/+tCCr+bRe51iPoEn0VANMGTICfVXXFrXQ5IFl6wdkt+jXr7JaL4kWklSVa3ZuCtiGSHMJ48y4pEmpFobXaeBCntNN3UTkKeovJzomf9dzeaARq4Q0x091tiuxPcg9hHtus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762373996; c=relaxed/simple;
	bh=dg/CQiJ9SH+N8WLjJ8P6Yi5KMCvTXCf9lbKxGs0ohNA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qbl+CRHlysxbGoDavW2rAEBt5LvwdZSUqskTy7Jn4ndpz9c15h1SnJFykPMdJnU55Q49FaRPAUlSUWi9vJ7yrv4/YhdLT/5M1XNNi9RZ3BhHGCixuQ18WjyuMOc4zURkFzvhFpHnm3CiGVDVPAkS+LfGwihBuZv99Un8oje8sss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=av/s3W2l; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b7277324054so37945166b.0
        for <bpf@vger.kernel.org>; Wed, 05 Nov 2025 12:19:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1762373993; x=1762978793; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mXk2q4ALXb4iHS81FjGOoDSTFyJQhG/HclBi/7HNWrs=;
        b=av/s3W2lai5KCsmj0nk5HAD6uvDH4kYVcxNrwxXFDhAlvAoH8tk3QB3XIURiKn/2k7
         cljyQ5fn1FW2DVAvs0maKCoz9pCzIvTYN6Xbequ13AkQgF/gmH0UXL/KrnK/84hOPo0E
         GCeR6f/XVIdUhwxjbkO4etVGRHW4td5ZJ+SanxRIG4BsMgIsLuZcpj0EsJCkh1l2wgDg
         1TUL3elV32saRRZNzU+ujWhz3cNN1EvpMie5Ta43tP71NYrPiDN1tTBJIVCsVH6xsrAJ
         TGyqYRQOoZT89nSKpR6wI5K/nmlY24lDrf+/2DdZwie7FmoD3v0875+UgW4O1RNBCFXA
         aifw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762373993; x=1762978793;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mXk2q4ALXb4iHS81FjGOoDSTFyJQhG/HclBi/7HNWrs=;
        b=ROcoBs4DFoImaCFYTWVnf0dngspXmiRN5x3BkZIT9dMRMVZlLjEhDk3A/GkRKIIG21
         f7WMMumiP7XCq5BnbfwxaEFIlKk3rxJ2fResDHaicS+fDuteH8kQOBKyKQlUvHozUkDR
         HCWTWltGD94b6nN4VANWzPEjolC2GEYGzvnaGET8CT5+fMlViHhVzEL/z8w0Bv55O+jE
         qOvc6WuS49bd/WUZcaXtOnNJZJlPJBc0Lu6SlakH7LxrXQYj6+9rB3GHce2hKGGFMh16
         F+P3Hs863dtbUCSuvPk9I99mcS43Wepc1Ll4K9Kx0/op+f6LcRVcJkUBwwkcjweUg1Rs
         3s9w==
X-Gm-Message-State: AOJu0Yw6Fa0f+7SeUh1/BaQaKUgrtEL6pOYJisdmwqjJKaniB/Jd7AzW
	P1pUlQ+ge4XGRPStrwKfA/iLWVZcaej0RkBDKN2YHjHDu4vFJId4mnLDc2+4pxxIMDQ=
X-Gm-Gg: ASbGncsfh7c+DOb+1vumA5ixF4m9Xk1I52mN30zomSmecRrBn+c5W9a9DJEEpSfsLWx
	UwuqLsFolQaBNoAIhdPC70Ex5OAM2cp8RcDWpmBIwMuIOglt+nGkZkmUBpr9M4V6/aZxhBbx0v6
	Pg1Ysl9lsDZliqfgTwE4vznK1oVAAAbbrnb5UQ/Zo78X47lLIoXqRpODl2ZvMw6g3M2hegl0je/
	tVwc1lbGH4AQZLsZJn6euBQH2zftEVF1bvSm3JoLGDUCD4yCz+SkV+RutQcwEZwqO+9kw6813b7
	/ajMXuy2vEZ/Ao+sbLuzry9FTCGCcPxz0RTGa7hWwna7zV483IiKWlnAMKzmuA4FkCMhzZYYYlI
	eD6gjVF34XNYia/yAvLWHwVRQ/kJGDEx44E/gnb4JgyPG01jZlSiwzlX99rIaCm8ovnVYODstxI
	wIXEizSlZk+WBIy+6p5Rr/jkjQjKKzXYgNSq6dP2qStfRwXQ==
X-Google-Smtp-Source: AGHT+IF98gJttNQSkeuSC8loLs07d8+EuCjbsLOat4XOe7ckgVYMOtJqTDfgihKYv1Ij57z/OYHrNw==
X-Received: by 2002:a17:906:dc8a:b0:b2d:830a:8c0a with SMTP id a640c23a62f3a-b72654ce7e4mr428738666b.35.1762373992959;
        Wed, 05 Nov 2025 12:19:52 -0800 (PST)
Received: from cloudflare.com (79.184.211.13.ipv4.supernova.orange.pl. [79.184.211.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b728968252bsm47667566b.61.2025.11.05.12.19.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 12:19:52 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Wed, 05 Nov 2025 21:19:39 +0100
Subject: [PATCH bpf-next v4 02/16] net: Preserve metadata on
 pskb_expand_head
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251105-skb-meta-rx-path-v4-2-5ceb08a9b37b@cloudflare.com>
References: <20251105-skb-meta-rx-path-v4-0-5ceb08a9b37b@cloudflare.com>
In-Reply-To: <20251105-skb-meta-rx-path-v4-0-5ceb08a9b37b@cloudflare.com>
To: bpf@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, Alexei Starovoitov <ast@kernel.org>, 
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
 KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Arthur Fabre <arthur@arthurfabre.com>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, netdev@vger.kernel.org, 
 kernel-team@cloudflare.com
X-Mailer: b4 0.15-dev-07fe9

pskb_expand_head() copies headroom, including skb metadata, into the newly
allocated head, but then clears the metadata. As a result, metadata is lost
when BPF helpers trigger an skb head reallocation.

Let the skb metadata remain in the newly created copy of head.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 net/core/skbuff.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 6be01454f262..b4fa9aa2df22 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -2218,6 +2218,10 @@ EXPORT_SYMBOL(__pskb_copy_fclone);
  *
  *	All the pointers pointing into skb header may change and must be
  *	reloaded after call to this function.
+ *
+ *	Note: If you skb_push() the start of the buffer after reallocating the
+ *	header, call skb_postpush_data_move() first to move the metadata out of
+ *	the way before writing to &sk_buff->data.
  */
 
 int pskb_expand_head(struct sk_buff *skb, int nhead, int ntail,
@@ -2289,8 +2293,6 @@ int pskb_expand_head(struct sk_buff *skb, int nhead, int ntail,
 	skb->nohdr    = 0;
 	atomic_set(&skb_shinfo(skb)->dataref, 1);
 
-	skb_metadata_clear(skb);
-
 	/* It is not generally safe to change skb->truesize.
 	 * For the moment, we really care of rx path, or
 	 * when skb is orphaned (not attached to a socket).

-- 
2.43.0


