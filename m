Return-Path: <bpf+bounces-78107-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 24BCBCFEF0D
	for <lists+bpf@lfdr.de>; Wed, 07 Jan 2026 17:47:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 624D1339F8E1
	for <lists+bpf@lfdr.de>; Wed,  7 Jan 2026 16:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FB5B34D911;
	Wed,  7 Jan 2026 14:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="UPOL8Vpf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547E534D4DF
	for <bpf@vger.kernel.org>; Wed,  7 Jan 2026 14:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767796105; cv=none; b=uMtM5SfufFf+kld3lt+5Zl1WvniB+EQQCIT6wC6v2qK0UeMy9n+aQ5isAD9zPL67nKUqbJLX2vygm1YnnYBVWImFxTpOG7BrbKfjUiQqaXlv1PxpZ3Zs6dhN4o8yyhByTD80mSuQ0scqIkQHg0oWcVtjAiJL4Q7rYezoH2l5ZRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767796105; c=relaxed/simple;
	bh=NaLr3kuYmZoB45GFF481B9GG1CmkcJsN17rUBCCL3X0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ISnWBAY8cXngi39xg1BwU53JuGXA82VCLQWuY4IVlTvBYOuc3VTzCda6JLfIY1Frw15mLEGzL494gHxTbf1J4oG1rY2NmX7IMVGtHtscX4E931wMNQZviRFFBb1csh0lrI0V3FAuU0jRbghhbUerTWYOse0hRNwzNqdfEgEsadA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=UPOL8Vpf; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-64d0d41404cso3144426a12.0
        for <bpf@vger.kernel.org>; Wed, 07 Jan 2026 06:28:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1767796100; x=1768400900; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2BAkb07UvD2AJKDS63sluZRYEIGpz2hmyS1/vul3M/g=;
        b=UPOL8VpfuzfUh3FI6D3L2ER6M04DjigHiZ7CZbaRgH3a/AuWjEwfBKUCOtfnTslerT
         X6XwbytS1loQr42ioieOG7/fkZ3NZ2hCL7d7h6qQ8tcQT6T/SSyRe1T3zOVwm4SaExr3
         mqBJDC3RqJkhLx/iFCNy/1eEfJRYsoE5xEXWD6yZpRCtIBJdH0ooZx8gK/zToURiEBCr
         6BbxTIjegrYLNOSYXxiS3LLYkjuPerRlmplfwSbGrN2EzbxkqHAi/Grxzs/STbsqZdE7
         6ZZS9jAIeBlQhf8UWR2D71iUa8G4otcr+SXhmqfVUfIgglb1gfU1HQbGKuIShM9CQPTH
         S/pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767796100; x=1768400900;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2BAkb07UvD2AJKDS63sluZRYEIGpz2hmyS1/vul3M/g=;
        b=hVaBU2jZjQsXG3bpu/xb7dIvsyertKuRvH0XUCsTwIJuIGdo/xbKn2NsYLJuGy2tdN
         uk8vpbeBybpk9+srDcmVTMt1jnV9zORvArvdiG3KsTxjBp5MPJhnMlN7CiDu3Zhis0zx
         I53SUpY2Bd/pwfhPaUvyozTIJxErZsnJP53yKRwPpTc/m5aQ4yP2afoCviRcCpR0Yfh2
         WWEJjuoLyv/qW6ZKqBSCJy6RYfWxP775lM+qVkvgi0V7+S2HAWBdP+k6Trutiw7qq0vL
         Xoke/BYZfGeSQpQC7O3dOHTjNdFxj7sJn0n5vfiBZhaHpS+lUyIiOi9E6covKzlA+JhV
         7eYg==
X-Gm-Message-State: AOJu0YzTqs1y5u8RcxZNVkDmOc4x2Y4QmNOa4S/iIKju4j3dNABZ6/pi
	0KrDql75dLmukdnzgARlbnUU68RZ655l2CKMy8MYYp9ZFDnd/AX9oySCW2LOBxzTBio=
X-Gm-Gg: AY/fxX66ReZrn5RXF0Q+20zKlns02jREIPqZZjI0xFE09rvOGiXu19l9GDxfjgLNg1/
	SzehSTXrp2Gi9ltYQn7JAxn+jmN6MqaKGBnKZFqfoSmFd3fHu50NMUYrgGehhdF4QwQhigs6S6v
	4GC1RuL1KK0Kaf/iAueC3vlz8X+Y02OOlIDZwunca4lcnF0m4q4ZHFGtuuKy4nA+9oOZljGXxJh
	iW52zTEAXqTIf9jRNXzFghBUF5M08GZ8TAXbTF7wWRxxR3n63x5zyAeSccgd8VhnYhAWZEnd4v7
	jgpRd5rZdCiFarZ3v5JIsHPZsTH7lMXSksF+/0e1ZgebZhDmZ5tufIEaVGe+no2rPj5PDU5QWXj
	CPn/X7xA8IR0dLUtOSmBSDn4dlodylkQF2bo4xGxBsCNgkh8zR4qms9CV41nBwCicrgJ/cZctvM
	b3Tlfn9QiZHyzX/EIyk6hoAzAGoP03NFn5ekIk4KBxmOYCrXOzmFL+N2/9ALw=
X-Google-Smtp-Source: AGHT+IHitZah3Va/SbksXm73SZCgETkvGSFo9DYkkuJ9TIdifet1Vj9nG1ONYb08mumiFWDsb4Zn3Q==
X-Received: by 2002:a05:6402:51c6:b0:64b:7dd2:6ba4 with SMTP id 4fb4d7f45d1cf-65097dc62b6mr2416519a12.4.1767796100477;
        Wed, 07 Jan 2026 06:28:20 -0800 (PST)
Received: from cloudflare.com (79.184.207.118.ipv4.supernova.orange.pl. [79.184.207.118])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6507b9d4c89sm4626004a12.10.2026.01.07.06.28.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 06:28:20 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Wed, 07 Jan 2026 15:28:09 +0100
Subject: [PATCH bpf-next v3 09/17] xdp: Call skb_metadata_set when
 skb->data points at metadata end
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260107-skb-meta-safeproof-netdevs-rx-only-v3-9-0d461c5e4764@cloudflare.com>
References: <20260107-skb-meta-safeproof-netdevs-rx-only-v3-0-0d461c5e4764@cloudflare.com>
In-Reply-To: <20260107-skb-meta-safeproof-netdevs-rx-only-v3-0-0d461c5e4764@cloudflare.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, Simon Horman <horms@kernel.org>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
 kernel-team@cloudflare.com
X-Mailer: b4 0.15-dev-07fe9

Prepare to track skb metadata location independently of MAC header offset.

Following changes will make skb_metadata_set() record where metadata ends
relative to skb->head. Hence the helper must be called when skb->data
points just past the metadata area.

Tweak XDP generic mode accordingly.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 net/core/dev.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 9094c0fb8c68..7f984d86dfe9 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -5467,8 +5467,11 @@ u32 bpf_prog_run_generic_xdp(struct sk_buff *skb, struct xdp_buff *xdp,
 		break;
 	case XDP_PASS:
 		metalen = xdp->data - xdp->data_meta;
-		if (metalen)
+		if (metalen) {
+			__skb_push(skb, mac_len);
 			skb_metadata_set(skb, metalen);
+			__skb_pull(skb, mac_len);
+		}
 		break;
 	}
 

-- 
2.43.0


