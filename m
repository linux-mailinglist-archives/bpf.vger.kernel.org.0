Return-Path: <bpf+bounces-71301-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B353EBEE54E
	for <lists+bpf@lfdr.de>; Sun, 19 Oct 2025 14:47:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E738D1886149
	for <lists+bpf@lfdr.de>; Sun, 19 Oct 2025 12:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EAA72E9ECC;
	Sun, 19 Oct 2025 12:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Z5uyaqzZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A3852E972E
	for <bpf@vger.kernel.org>; Sun, 19 Oct 2025 12:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760877955; cv=none; b=hLOn0zta4KdimZTYx5yRwm0LvmAjkmRSZxL/LbiWbXmbqz4DJPM4AQyhYTym5zwqxdarDPX7Ufb1wXYwKQsvtIXBcia1T9YXwtQyHMM6L2XGVrzarD63Ai444rQnp2rEc0j2OpGMK41myw2TOjYvit93OGkVUwiCtZM7/GWtPKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760877955; c=relaxed/simple;
	bh=Dpo1MHnhWXyr+fuQYgrkB5o0Ycz8VFedY0IVeyWKR9o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Q64/KVn0Zn1Bw6HK/T5ZiXAm2DYAyszvbATiB3684WHaJOLJiMFtQHsvT4D4KHXYij0lSHYp7s9ayyTdH+U8F8aaATj6foHlG34hlyj28U9wSiDg20rrHAr+8B3zcfGzR1hDw8Rc4HM6QWHT0fthkPXDuKcZiFG2ucMfhOEgtqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Z5uyaqzZ; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b00a9989633so741665966b.0
        for <bpf@vger.kernel.org>; Sun, 19 Oct 2025 05:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1760877952; x=1761482752; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lePNzez0IJKAF9x8/QAXM92ZwfXE4CTTFNo/I1ractM=;
        b=Z5uyaqzZWjYrmCxmdDWwsTscGh9C5jI8d9ADavX59J7F7tH6Lyx10B/L6i6nPasNck
         LvmFcMEiJE1zkO4GvHTxId1NjppICDSgBuzIUGvPpt6IGAwd2LCnnZ3xVXjKoNjZ8pA1
         oBgVcLR2MYhAa4mFNgmWiVSMeGBKtGRruSl5b8QzcEjxDohtdmiHwpR17Xf4l/n7o0jL
         +tDxycaIrbeEwNEwLzKsxsXVVubqbDGX62e5mNU+PhxGW5yxRjqb7dewPRchXqI/31P9
         kWx5Q1Cnf4putRmLJraxeys+kX74uV5Z2bK6Bq+JodL+FX82Axo8u2rSXVwAYove9ZGc
         Vaiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760877952; x=1761482752;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lePNzez0IJKAF9x8/QAXM92ZwfXE4CTTFNo/I1ractM=;
        b=Nu2FIkuYF2XJlAkMVZfXAGIEoNAwgJFoUBBr9wW84+r73rArJr0CQ0xZysW8JwSHhR
         bJF4ztowx+4BeoIE/X6MR4hUDhcdEgfzyiw3Euv3DG8Rh/gos5JtZ6wWF6hR+xSZVq1p
         7t+Ymm8tgDN9XZvDBDM9kgm5+k9b2368ciwdnMSmD7bw/3sTWMkCaG1L2S/AgP4w/iYH
         Ys53rU9vdXt2OUSp4FV0pMOxQwe3bEypCpNVOQ3ibn2lvNDBi0g0UxHky7ikoPlMYj0R
         fl/Cn1x+pcdN3S4Sa6OL168dD2wrULMOGhM5rRqkV8ezVt09Da8+2nJ2fWanChzJBlbO
         nA8g==
X-Gm-Message-State: AOJu0YxtKWLWMw9hvBxAwSOm4S5HCpWJJfZJJ8We8un8w0rGMjoFEzgT
	OxGLTuCT8c8iCaRqRmO9N+KHJo6/Wbwxjdj4OLjG/SZ7/Y3GYCOSpJAZaztxfvkOSkE=
X-Gm-Gg: ASbGncumh0dg7G8zicUt7B6zC7vwYD6f6gdVsBDlbR4EIpLHikQOaaaMC2yrnMNHH7i
	f+qKQRHEbFk5aqX4AJ+G3GXrDIHpDJGkx8F/xVRwWdKhoetGpOuMzjqKEQQ0kTGeRwtN19wttzG
	hUcgngv9cfWEA5DJiBx/O/R9VUJJaX96gAkd1QwLjSVQSAsQkVQ9ddTRyG7jj01VyRqqe4wGMUA
	j+XKzZCtm+Drhns9mdYkbOr13jHJyF+F3sScpAjCZojsVp46Olfecr3TAPnRJe4ZdEYPB35NlhE
	pTx0wGYoUKqoLDjTlL/MUZjf61n1xmDpnFZvyQbnQ1zXyc/GKGbphOY7vzq6Fbyj+N3Sp33HUgy
	18kt+SaX9kzCBlH0UuK7z3C27psQZQK5fJGRsapviqAjr78aDjdnx2JPLdl1RPJEbDd1fsru4MX
	O2PYQMSokmRZAI72rQLMirmsnGquUmt4v1nACwfhszIEDOWDS94lM39z5PHHHfeKGgVBwqLg==
X-Google-Smtp-Source: AGHT+IE5QxJtuh/2HWQE8IlaiHQmI1YRxJ2D2O/f+fM8sFxzwfMZzu+YE7Ei/qXC7jt98nZh29ccsA==
X-Received: by 2002:a17:907:c304:b0:b57:d5de:444a with SMTP id a640c23a62f3a-b6054400322mr1722241066b.15.1760877952425;
        Sun, 19 Oct 2025 05:45:52 -0700 (PDT)
Received: from cloudflare.com (79.184.180.133.ipv4.supernova.orange.pl. [79.184.180.133])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65e7da35c3sm495619366b.4.2025.10.19.05.45.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Oct 2025 05:45:51 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Sun, 19 Oct 2025 14:45:31 +0200
Subject: [PATCH bpf-next v2 07/15] bpf: Make bpf_skb_change_proto helper
 metadata-safe
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251019-skb-meta-rx-path-v2-7-f9a58f3eb6d6@cloudflare.com>
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

bpf_skb_change_proto reuses the same headroom operations as
bpf_skb_adjust_room, already updated to handle metadata safely.

The remaining step is to ensure that there is sufficient headroom to
accommodate metadata on skb_push().

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 net/core/filter.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 5e1a52694423..52e496a4ff27 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -3326,10 +3326,11 @@ static int bpf_skb_net_hdr_pop(struct sk_buff *skb, u32 off, u32 len)
 static int bpf_skb_proto_4_to_6(struct sk_buff *skb)
 {
 	const u32 len_diff = sizeof(struct ipv6hdr) - sizeof(struct iphdr);
+	const u8 meta_len = skb_metadata_len(skb);
 	u32 off = skb_mac_header_len(skb);
 	int ret;
 
-	ret = skb_cow(skb, len_diff);
+	ret = skb_cow(skb, meta_len + len_diff);
 	if (unlikely(ret < 0))
 		return ret;
 

-- 
2.43.0


