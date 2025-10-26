Return-Path: <bpf+bounces-72240-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42EE0C0A990
	for <lists+bpf@lfdr.de>; Sun, 26 Oct 2025 15:21:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 308F83B0F26
	for <lists+bpf@lfdr.de>; Sun, 26 Oct 2025 14:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED9572E9EC2;
	Sun, 26 Oct 2025 14:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="A6dn64r3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122602E8E11
	for <bpf@vger.kernel.org>; Sun, 26 Oct 2025 14:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761488333; cv=none; b=GcyCH4TGi85kJ0venkjtFjbLnIY85mr5BGuPoFgW3QXLrE6kVPh1AC0yOT/+8i/i3qB8uOOdiBTuta/qBlOVGJr6wvVPy3rn0nSpkW/yMSDgAjBniL0aYPfa0ua4Jg4/ysd5NdMquXZ7p/caQ3+6BhTQt8+s69E9aof17PIMJYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761488333; c=relaxed/simple;
	bh=UhRnZxPKGVuuOuQb5qRk96XqSFF/BCmMMYfjJSYcsHA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ng1TIFQT8I9CIpXA+Ecm0KwCF0L+QKtvsrhvlmUmdVFDK10ZuO+PFwZI9Rm1YMwWhkS6RORa94TDvR4/WTETq/bJKHiLA0HsxvwKVY3+aN+w9xj4VgEFfAX4fshgbDsAcYpNBQnvy4ffsqTiGi2fhnuo34sEOWGrwSDUkDS+/Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=A6dn64r3; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b6d5c59f2b6so484690966b.2
        for <bpf@vger.kernel.org>; Sun, 26 Oct 2025 07:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1761488330; x=1762093130; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cmluj4MnRwKAAu/c6HXjSmgF+5mTcBLf8ktoHdBKxf4=;
        b=A6dn64r3Mep2XO6irVMroVAFlOa00AbHjUyRS3/05ZrEcdjPpTpkMXlzi/QhCurNog
         ZmXgZkeu8L67JN1FqKCI6s3WDKepri7+thvssns67uOxxYTH6BIf7ojE/w1cq0Chhv2q
         kszvxRM3BBDOqKF28A6z4PK+PqBjEZugy+L4UGwaLOUX/LjS55NbzfdxJsQgxVsHtveA
         IVNwj/0NMLLOcDhYStJqb8Z55S3LFdJmAyfXE9tB5z0CJKVCg3xmT7b7pzyRKGlRHoP0
         HZITvWWI9sckR5f/+H/eyslQz5EDxQj1iRlMaA/I6JPRkQWJW7+Fm4NXJfNMbEL2C1PV
         r7RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761488330; x=1762093130;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cmluj4MnRwKAAu/c6HXjSmgF+5mTcBLf8ktoHdBKxf4=;
        b=gcuuNxUTXW/Kpq6rQBpPWoXN2THM2mdQ/bfZp+b3oNWW34fOffbeeLdCfYDv+urXxK
         Ho2Ilved3ygeiOKHP67ndWscEd3QAlpnw+WTerQVZAwxFYfhZ/nFdsyanRLKaim0MpQE
         cLAN3Fws/k74grH1ILI4jDUZHW+IhPI7Sk9S/a5tCb9UN2cIIdFpJVXoL4EU/eCo1FnD
         sGKjcbwNHKX05qxIurs5tE9sSyubYmIH6YQk93jkLjvDJB9vlA0VVYgw9ZlsvQPhxxgs
         8U3icuFKcdcyD/5CUO8OHGaxeQWHrrHI71SQ9GXeTLwhydYLAExkTR4UfA8vAswOg/o0
         yghw==
X-Gm-Message-State: AOJu0YxoINrJbbZEJeOxA7ig7gn33ei2ZB7un6AeJBKR6kKk0CsFXMFd
	k4+hML2Y9JnKim3Zhed9zN//Al+NkEsjcKjkVkfXTAn+ZtEiCdbrUq0vGwV7W+50I6g=
X-Gm-Gg: ASbGncs867g6aGNLjkIG94TxPZKXGVFbG8wt77b3Q0lIZENhQgZXhbvggHovzRx9JUc
	TpOXa/YGW0YNsp2oJIt09NYehnEdbWbbmh0fSVUXAU9BKJj7DlPNseLwOp0do0f2FwleO9MfNzg
	g8QyAljRs7xCLh0XoF/JDchn0TnVeNobsXRzZ/ARjMb4yUvOirw24qPK0ykhuC4A3t5fYujXvPu
	qfmiF17Fnreoxix+5L2BMh82c9e3vBLimFuYqGlZv7rI4ehcR3uoP2bFjGN9BZELF69a4Xee0/M
	BlEqJgnfaM1ffdC6Qvk0vnuth5Ousx0VqT6BHrkf1fEeIOQUtKciscF7h3MZSfEZU++bSM1fjRo
	/sE9UGkXxOzS2BJZKiTj4sB4sKLRGAKI7QSbu2YOACwaGmByB6WgnguThNCKC3IMZWfxeGg1LcA
	XnD3eun7qcTnA0oLfsBc6Dmd2ClxOPlrlYB4i/SnNK1dvVyA==
X-Google-Smtp-Source: AGHT+IHYEZUc0PCYiR9LIi0xrC5j1dImYFwuHlOX8FBHT5WMg+2WuwxE9uz5JJggz/6AKHomGQVGBA==
X-Received: by 2002:a17:906:4fc4:b0:b2e:6b3b:fbe7 with SMTP id a640c23a62f3a-b646ff85d64mr3673013666b.0.1761488330359;
        Sun, 26 Oct 2025 07:18:50 -0700 (PDT)
Received: from cloudflare.com (79.184.211.13.ipv4.supernova.orange.pl. [79.184.211.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d853c5c0dsm469046866b.40.2025.10.26.07.18.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Oct 2025 07:18:50 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Sun, 26 Oct 2025 15:18:29 +0100
Subject: [PATCH bpf-next v3 09/16] bpf: Make bpf_skb_change_head helper
 metadata-safe
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251026-skb-meta-rx-path-v3-9-37cceebb95d3@cloudflare.com>
References: <20251026-skb-meta-rx-path-v3-0-37cceebb95d3@cloudflare.com>
In-Reply-To: <20251026-skb-meta-rx-path-v3-0-37cceebb95d3@cloudflare.com>
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

Although bpf_skb_change_head() doesn't move packet data after skb_push(),
skb metadata still needs to be relocated. Use the dedicated helper to
handle it.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 net/core/filter.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 09a094546ddb..6d69bf56ab54 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -3882,6 +3882,7 @@ static const struct bpf_func_proto sk_skb_change_tail_proto = {
 static inline int __bpf_skb_change_head(struct sk_buff *skb, u32 head_room,
 					u64 flags)
 {
+	const u8 meta_len = skb_metadata_len(skb);
 	u32 max_len = BPF_SKB_MAX_LEN;
 	u32 new_len = skb->len + head_room;
 	int ret;
@@ -3890,7 +3891,7 @@ static inline int __bpf_skb_change_head(struct sk_buff *skb, u32 head_room,
 		     new_len < skb->len))
 		return -EINVAL;
 
-	ret = skb_cow(skb, head_room);
+	ret = skb_cow(skb, meta_len + head_room);
 	if (likely(!ret)) {
 		/* Idea for this helper is that we currently only
 		 * allow to expand on mac header. This means that
@@ -3902,6 +3903,7 @@ static inline int __bpf_skb_change_head(struct sk_buff *skb, u32 head_room,
 		 * for redirection into L2 device.
 		 */
 		__skb_push(skb, head_room);
+		skb_postpush_data_move(skb, head_room, 0);
 		memset(skb->data, 0, head_room);
 		skb_reset_mac_header(skb);
 		skb_reset_mac_len(skb);

-- 
2.43.0


