Return-Path: <bpf+bounces-73709-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BE72C37B24
	for <lists+bpf@lfdr.de>; Wed, 05 Nov 2025 21:24:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E23703BC767
	for <lists+bpf@lfdr.de>; Wed,  5 Nov 2025 20:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A49C34DCC2;
	Wed,  5 Nov 2025 20:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="bhT4TAQj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D0734D4CA
	for <bpf@vger.kernel.org>; Wed,  5 Nov 2025 20:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762374006; cv=none; b=HadVZt74iZZ1JhBFPkoWMPy9P8IpLkxLAKqQb7xed7gmkUBRRfZmgTbvlEQ3Bub2NtRASlhBF+peRDkGn81RkNxRJh9c0pXoFLYtn/99g5/gdxzqfyxqlp7AryQhvnE1DVERtQhjgvum4k5+gNu45ZcaICTkbnS4lI5Qii6NDYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762374006; c=relaxed/simple;
	bh=NFjiFGdeD6gzgMLbIdVyGosLHeh66otTeg/5tHoWKiw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SZMcNEERzq+VD+w/O83tAZm65jJTlSPBPRJjHwMvbidc/u/caWEa9GzbHbLmoe6l5MT8YO/iuSRlThk9KU7C0mdxxCAFWxEARIJ8/OtAQyI4+59YOGPaLNsCaBRGlVO3POPPBOd8uUTKOQjeou9yHavTjgkBSYrMOKcr/+fW9KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=bhT4TAQj; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b714b1290aeso37952666b.2
        for <bpf@vger.kernel.org>; Wed, 05 Nov 2025 12:20:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1762374003; x=1762978803; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JutpWbdG9YYVnRwTeE3UQ1dwhCFVxmeYmgKPLzbCKA4=;
        b=bhT4TAQj8GQjNoAZFuQDUAPlEeU/UDlGXiQh3mSkLOaWQGmSUKNoN1JX9nnXuspnCi
         L605nGdsRocoA8+dkE6dJJTOOiEU1UBtEIFMGmia9aGWthpyQ0mIYT/23Y+PsfA1k+sj
         rdSB7k8XkBsSvdaVr52snlForNVigGae1908WljZpAmraEUFsyg0zjZ7I7AqVRArmYvL
         XI8qUzcL6Sx63pHm7m1WDO/qE5KNUPrN/9j4MgguKSWYlwyD4DAxH77ACRIWUGp3psA3
         5pHYjdnMm3tpwJ6EJZNciUV9zVwCF44xrMEYLHkvGaXHQD5U+aXojG75NBO0XawZSGvc
         lcjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762374003; x=1762978803;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JutpWbdG9YYVnRwTeE3UQ1dwhCFVxmeYmgKPLzbCKA4=;
        b=tlT25QgtnkS5OMv1mkdi1lD7IQANJ1HnMlLfO0niCMOq0Ic7NsB6d1y5lrV+Ll02If
         y6b99o8o9ZqQLU1IV/CCON/JUs+dy84qlmBXz7IBYfxkQOrsXJi9YWi+EVJTicPaiHa3
         KRn+IhqPa+ZK94xskBgmNx3Lkf+7yIl2e6asjpUH05RFKQHGYR9HhoDZEwMEuuzpSQUv
         rULvjr4R85wPZ22c4jw9xlND+fc2MrGOoBE8aPD28Z5KNUuQRj56Zu3nEcwbxJP/YF8n
         2sKr+6/sBzyquQIs264nimkxDzzmJyCyW4E4/3WdHgVfSZLCxRGvDvDC3HcgB9xZn/pL
         sVVQ==
X-Gm-Message-State: AOJu0YymUfBVa6Ue+IIVI8bN8y6YqtEaYhFFoT7xC46zOSevSDgJOePC
	umhoOShkLO2UBUUtl1lnPcCshnkzYTUv1DAS/4EVupJzfQ0NRk+wYLkJww4WE89Xa5w=
X-Gm-Gg: ASbGncu8mi38BtNxSkGeDlA7SK7Aks5IEcHkCKoGYvqQs0IDyDu9nailNiYqD1w6Xcl
	SGNqby5gI9ezRCDBA5JbW51powAtPyT54dpjTVC7PiaDbDFNJ3ciDJFWBYETiZiwjJf/z3EY4qG
	XsLIeva75KWZxQV8vcdV5kxpSqKRHwg9YNA9yD5NCT9a2NvQHixh2rfzRz/+0NFPIOoj9sAARO9
	FElAqbQ7SrXk5KSNswNZaTXcY0hhqBXmvW0eHxYc/YtmEXP6XB7PO3yFnY0C8u+KxffFkpOcqlN
	mEcGSrusEKPy1vDq2VpZy0TYl+1dTuPdJ7jAYKUwsGmpMp+W0sati6Z+Nb/f9DMaCWFeA3SG9X4
	peH/bm+HN2ZS66A6JaY+yjI5LTxHljQkpKWzX+/RkawRCK+kT6kEomM0AcFQeDvGBNSQKDh00Gu
	EmFrp1jMHCvLwyEdxR/ofAVMDvwQ1/rZrshV2vy7+qsN9PzTjnrMFgVFNE
X-Google-Smtp-Source: AGHT+IHFMoXQdNn0rpkh1brEWR+6TkVE/T1PalnlWvIK7M+5tiw5C4YVqbHrcCKAwjMcqk90jxUdDA==
X-Received: by 2002:a17:907:d64a:b0:b72:5380:f655 with SMTP id a640c23a62f3a-b72654c23efmr411812166b.34.1762374002875;
        Wed, 05 Nov 2025 12:20:02 -0800 (PST)
Received: from cloudflare.com (79.184.211.13.ipv4.supernova.orange.pl. [79.184.211.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b728937cc82sm45049466b.21.2025.11.05.12.20.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 12:20:02 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Wed, 05 Nov 2025 21:19:46 +0100
Subject: [PATCH bpf-next v4 09/16] bpf: Make bpf_skb_change_head helper
 metadata-safe
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251105-skb-meta-rx-path-v4-9-5ceb08a9b37b@cloudflare.com>
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

Although bpf_skb_change_head() doesn't move packet data after skb_push(),
skb metadata still needs to be relocated. Use the dedicated helper to
handle it.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 net/core/filter.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 9d157d71277e..69c4e8fb402e 100644
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
@@ -3891,7 +3892,7 @@ static inline int __bpf_skb_change_head(struct sk_buff *skb, u32 head_room,
 		     new_len < skb->len))
 		return -EINVAL;
 
-	ret = skb_cow(skb, head_room);
+	ret = skb_cow(skb, meta_len + head_room);
 	if (likely(!ret)) {
 		/* Idea for this helper is that we currently only
 		 * allow to expand on mac header. This means that
@@ -3903,6 +3904,7 @@ static inline int __bpf_skb_change_head(struct sk_buff *skb, u32 head_room,
 		 * for redirection into L2 device.
 		 */
 		__skb_push(skb, head_room);
+		skb_postpush_data_move(skb, head_room, 0);
 		memset(skb->data, 0, head_room);
 		skb_reset_mac_header(skb);
 		skb_reset_mac_len(skb);

-- 
2.43.0


