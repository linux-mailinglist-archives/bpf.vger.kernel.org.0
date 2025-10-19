Return-Path: <bpf+bounces-71302-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FE67BEE554
	for <lists+bpf@lfdr.de>; Sun, 19 Oct 2025 14:47:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C7681889723
	for <lists+bpf@lfdr.de>; Sun, 19 Oct 2025 12:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3DB12EA157;
	Sun, 19 Oct 2025 12:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Y38kWrOn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF8D2E9EC8
	for <bpf@vger.kernel.org>; Sun, 19 Oct 2025 12:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760877957; cv=none; b=VLP+Y4k4wfmd66JHhw14auieU/wTEj250rgIOymALtylWkCCn8XFZPxZh40U8pZDL+hXz83K2Y73sV2+yBbiVeAuy58U6LjA2g/alm2An2+d9sBYBTMOeFssklKEtk/Z9OnN6a+Bu0vDMUgbcRVhdazL57PCsDw0tiY7AyJb7dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760877957; c=relaxed/simple;
	bh=UHcbyxEtsQIQOQPkDZD3sw+qx3C40IcIAUyBFPC/W0Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UMhg7nuhzCTq99QeiPgop55IgLAwicefcpiyhdeh9QxGxQsiBqLU2EWW2fk9bAdV2A8fLpeLDJnAZNzqtJlMGX5XGA5XhbMMWWwGYVCq5oth/33l2x4Oc4OtXAgqlKic7rpYO4/Rn2h6cDnamPaS3HcbjwYTBQFcxUSQrJd+/mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Y38kWrOn; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b5b823b4f3dso654887466b.3
        for <bpf@vger.kernel.org>; Sun, 19 Oct 2025 05:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1760877954; x=1761482754; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dt7AuteTVa42+A8b61PSRaLCuKGLTn4vxWnXwMfk5fc=;
        b=Y38kWrOnS11nxniRrY3t/OtiDys+GWAcrOWGARlhrNzEWefebi1ldr23GtWZkQXGlz
         F+m+vZ8+5J/d8ZQju+YtuDuGxzV7j5ApVE8CvL19GKoE5s8GvnWCpiiChBAbLpWoSpcp
         THTRyPINg6JxMbAdDqt9itGGPVZO9eDi/iUqxjSfD7E+ylN3nCZ8x1/eMthO7hjRQY15
         e1VcHhGv5C5yX7Mkhbdi1syjo7xRiU/RJ5dFLzT9jStRhrbcp/YrPpg94/gh6ckCwb2C
         FGy76gFZJEhhXMDQPVtxVnwqln3qE0px6oWne4gT4v2+D5jRXE7MhBkZQ4Mm5OZ1LMOn
         tBWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760877954; x=1761482754;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dt7AuteTVa42+A8b61PSRaLCuKGLTn4vxWnXwMfk5fc=;
        b=LQYrj+5YUL56qY4gw2ej+JthQwMlw/qzlX9WbOCXG2JlaNnubgLnYnZuocNR8oW7lM
         2jum+/fSAXEJvFaHHdfS/MGh9kNHWp31NLMh1ZZRAhj+48py8e/6oElMtXV45cFjT7o2
         hTqlEanA6LAQZ3fwlGcUemuF8NDmrIjxzHqMogU/3lw9neKxK5NVQfxL4W010PAkMo64
         3hH81YY7xyoAowDZslFmhMlpAFB3tnDYuy5ic/WX4Jl7NiFZwvRqZRlzH9LyQf+SFfGS
         aHJymwSEI1LHKyqWCsdCj8bzJDVxBUR6M/0buf9+mrHoMAG6VbSU/bh0wXFsBfc9/GgA
         SyUw==
X-Gm-Message-State: AOJu0Yx9aC83jN7JbQnSvWoaqJ0cZGDlhgPFCrSpgiAbm0d419kF+xsn
	JWcqJTwRumk7R0tv0GZgUr7UWstw0YCJDvSbxqmKoCDThwJwwaRMMkEiGmse7sj3M8Y=
X-Gm-Gg: ASbGncu5X5AoQl8cYQhZGu0AxzKZnBHIkIE9eD7USFxqhWY5C1SmQIHwu7lFk8FCN+y
	spo1vKLCvKGCO8m43zD6+uHALhR1Ffr3Y2sgZLoraDZZuacEqwzgSbbGlVoHEj7WEzm0vUATPE0
	BM1eLCH6t+7592Sy5xVguqXuT8nJ1w/xtLSMCPt5HNegGBFXhiecRlxOxr4y92OvEhJss4rx/9D
	4gotXcSdbqPVROu+aeSCtNSgFbVBm0tBcAvcsgOCxSLsgLyyGlqLi7zYIcwQrnFYGX5Ia25IBvT
	fNxxH+TjL77cINUs/xrnOkeW0lKXZpsuvwdY/qSTCAsnOwmApxhm5rtW+t7M/yVOFgpYt5km61N
	K9EzfXhLA+ZcPPFdtGYCk0JV5gg5ggQeoIiw/sQ0qfePR90H9YSaKv6Wp+iVynH5AYp31Q4HT84
	X5HxBKQ7mbMi1aBCRpreSwYpR7dYleLpiCNaUk/HPwQc4VZWLH
X-Google-Smtp-Source: AGHT+IEyImHX6d99mwNK4GhLUVX4Wch1W/SxZcrcIr0bKWWkAjUctI9d/1EAKYqB6wL6C/dhcu/Dmw==
X-Received: by 2002:a17:907:7f22:b0:b49:96e4:1846 with SMTP id a640c23a62f3a-b6473245c5dmr1248212466b.20.1760877954202;
        Sun, 19 Oct 2025 05:45:54 -0700 (PDT)
Received: from cloudflare.com (79.184.180.133.ipv4.supernova.orange.pl. [79.184.180.133])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65e8581780sm488729566b.31.2025.10.19.05.45.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Oct 2025 05:45:53 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Sun, 19 Oct 2025 14:45:32 +0200
Subject: [PATCH bpf-next v2 08/15] bpf: Make bpf_skb_change_head helper
 metadata-safe
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251019-skb-meta-rx-path-v2-8-f9a58f3eb6d6@cloudflare.com>
References: <20251019-skb-meta-rx-path-v2-0-f9a58f3eb6d6@cloudflare.com>
In-Reply-To: <20251019-skb-meta-rx-path-v2-0-f9a58f3eb6d6@cloudflare.com>
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
 netdev@vger.kernel.org, kernel-team@cloudflare.com
X-Mailer: b4 0.15-dev-07fe9

Although bpf_skb_change_head() doesn't move packet data after skb_push(),
skb metadata still needs to be relocated. Use the dedicated helper to
handle it.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 net/core/filter.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 52e496a4ff27..5ad2af9441a3 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -3875,6 +3875,7 @@ static const struct bpf_func_proto sk_skb_change_tail_proto = {
 static inline int __bpf_skb_change_head(struct sk_buff *skb, u32 head_room,
 					u64 flags)
 {
+	const u8 meta_len = skb_metadata_len(skb);
 	u32 max_len = BPF_SKB_MAX_LEN;
 	u32 new_len = skb->len + head_room;
 	int ret;
@@ -3883,7 +3884,7 @@ static inline int __bpf_skb_change_head(struct sk_buff *skb, u32 head_room,
 		     new_len < skb->len))
 		return -EINVAL;
 
-	ret = skb_cow(skb, head_room);
+	ret = skb_cow(skb, meta_len + head_room);
 	if (likely(!ret)) {
 		/* Idea for this helper is that we currently only
 		 * allow to expand on mac header. This means that
@@ -3895,6 +3896,7 @@ static inline int __bpf_skb_change_head(struct sk_buff *skb, u32 head_room,
 		 * for redirection into L2 device.
 		 */
 		__skb_push(skb, head_room);
+		skb_postpush_data_move(skb, head_room, 0);
 		memset(skb->data, 0, head_room);
 		skb_reset_mac_header(skb);
 		skb_reset_mac_len(skb);

-- 
2.43.0


