Return-Path: <bpf+bounces-72237-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EE67C0A948
	for <lists+bpf@lfdr.de>; Sun, 26 Oct 2025 15:19:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D8929349ACE
	for <lists+bpf@lfdr.de>; Sun, 26 Oct 2025 14:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8298224501E;
	Sun, 26 Oct 2025 14:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="LYTHa7El"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744742E0903
	for <bpf@vger.kernel.org>; Sun, 26 Oct 2025 14:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761488328; cv=none; b=H9IgEkHSOKO3HNJAEtuehWgonUubnfGN+w5mVitCbk3T3lalyD9dUEJntOVlc6U7km8Z5Ehivrctzr4vMaPsDaJRpUOF2j8kmx+ojKjOLFNiC9KmzgOXqjfqk9PGScBTysf/YzuC/utjpMhTIV2V7Oak+vtBcGpqQWwqSoCdfBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761488328; c=relaxed/simple;
	bh=xleLnqeTmax3LL9D8FWb7af2lc6VsV84ywgJTWC3NVc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lScMYqlwbuHh/9Rf7QAuxM0b2+9fUs/2lOC6bQJsaI8WO/3/iq/mxZ3XLle6zpdX/rzfsw1ju9NJ3377iDqacs6la5JPtWSWHMtsB/9s9qq2gLCgMuIdBzudJP/OqWCE9ZR26Y4bMTtOSm090qeUvoicMwbitZIMNlwmaQ6uL7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=LYTHa7El; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-63c2d72581fso5520696a12.0
        for <bpf@vger.kernel.org>; Sun, 26 Oct 2025 07:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1761488325; x=1762093125; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=isGYaQWo1V/ui7jH0r+jvXI+ZaW6MhGNSYr2vGlL7Vw=;
        b=LYTHa7ElXVOWVQHy9F+4tNWQfuuVUdG2eQG1mdwZUy6aItfTUakDm42UvYZMHGRHAH
         IoRiefXsJAGiY0cDLgVkXSa8qX4rrfkVJOpZkWOWgMkn35RpzsLYuF16dLe0JWVbOxT4
         IR521eAmRdklxxg1Daq3hNzlITdaDR0R2r+wnW/gTZuWf0xJvCHiHyy0MTvAxtGHQi4b
         n5U+dmGI5yT21fkj633tpYeBGt67idV9E+ZZvroijEiPVlg/rTCwR0a6Toiw/aTeO6+F
         bRFv2Hsq2IxGNTpXZCIOsdihGA0IOevG9jWVEmUYPNym1FZS62vdu7ohbOMTfbPAUQvq
         c6QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761488325; x=1762093125;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=isGYaQWo1V/ui7jH0r+jvXI+ZaW6MhGNSYr2vGlL7Vw=;
        b=ePQeXhvqM29jwySWHY7/B8u3jrutqE00iIDA5+oBmaLTTvibeStThkj65D4YCJFcC7
         hyRMcVTaY2eWCIScBHfowCf5GG5ZaItxhxsKFBWeYRQaI6C9C8MyF16zfq8BCznk7r3t
         BffC9wrZs7uYqZRGGIZXbsO2IwG8tjoULSx5pizuHk4dUr8o/RkW76gYMKMKtNvCRYKY
         SopypVjwEXhaeUlTBRG85pTb3Ud9hrXVFe3gaWl+kXFQR1lZVP1xKy5QmcfyhPA3Mta3
         /oXSkQPT3cXMS5Y5yVj0u2jHFvL5PnWSIaetgMpwYdPLAtGLECR/wIiuPpkTM8UhWEON
         6e8A==
X-Gm-Message-State: AOJu0Yz1TpoANZ4Y3FHZQhsHTKTvf97u6jGpW5wBcZ6MupnPa+MRfOHJ
	+kLcSE2tpJD1kzjTIxoa4BxyGuOAIJ5yGKIDUHRP0H8g0Pb9YJhFCOwJK9elz0uhh9g=
X-Gm-Gg: ASbGncuSZhwmwnwssbf/xx4600/LUzIrWM9sGpV16ij6tPqUAP7MWJedy3AfNoxbEyI
	RH2+EtJgrZ6pgUileqeCp2vSxOx17jVDIrvhYKxAskZ2D1tlZqhTgQn3m4HbdKABSD64i4aoIuv
	WRJHOriEces+eN5qv0fwNzsqZMAS9SslYp/MKC+6WQ5sHroPAko4HI24iShvMocZPVc5mTDHgaq
	SoSEXE4NMxc1T8BIIfGK5UMY0h3RhDMmDLBIbQFQHwvziEr7DHx2xoaZNPKQWfiExFrj7wUNxIu
	U9v6dUd5Zq8gBZmPUjuPKiGO9Fg2Al80+9ovIA3Pv24W3a68w2j/g9NxrDWaJlvARUwPth/L1S2
	rL6vgTU7vUScAtUSX7jinf5KcMNHEttboIGLI9LRprweaoFQpQSlOoZ7enj9v6iZxc24b6bZpXD
	5Mso06MyM8SRgvnyc+84hdxmKIE9r+xEsaKPnX8AxxT0HyXA==
X-Google-Smtp-Source: AGHT+IFQRTyElOtU4RyzWvGnSDXeWSJDk/6TYhzt7r/pJ/mjLfZhfdy+LnatdvgFi/Jk/qUbnvatnw==
X-Received: by 2002:a05:6402:524c:b0:639:1ee3:4e83 with SMTP id 4fb4d7f45d1cf-63c1f64f094mr33757924a12.8.1761488324821;
        Sun, 26 Oct 2025 07:18:44 -0700 (PDT)
Received: from cloudflare.com (79.184.211.13.ipv4.supernova.orange.pl. [79.184.211.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63e7ef8288asm4021766a12.10.2025.10.26.07.18.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Oct 2025 07:18:44 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Sun, 26 Oct 2025 15:18:26 +0100
Subject: [PATCH bpf-next v3 06/16] bpf: Make bpf_skb_vlan_push helper
 metadata-safe
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251026-skb-meta-rx-path-v3-6-37cceebb95d3@cloudflare.com>
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

Use the metadata-aware helper to move packet bytes after skb_push(),
ensuring metadata remains valid after calling the BPF helper.

Also, take care to reserve sufficient headroom for metadata to fit.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 include/linux/if_vlan.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/linux/if_vlan.h b/include/linux/if_vlan.h
index 4ecc2509b0d4..f7f34eb15e06 100644
--- a/include/linux/if_vlan.h
+++ b/include/linux/if_vlan.h
@@ -355,16 +355,17 @@ static inline int __vlan_insert_inner_tag(struct sk_buff *skb,
 					  __be16 vlan_proto, u16 vlan_tci,
 					  unsigned int mac_len)
 {
+	const u8 meta_len = mac_len > ETH_TLEN ? skb_metadata_len(skb) : 0;
 	struct vlan_ethhdr *veth;
 
-	if (skb_cow_head(skb, VLAN_HLEN) < 0)
+	if (skb_cow_head(skb, meta_len + VLAN_HLEN) < 0)
 		return -ENOMEM;
 
 	skb_push(skb, VLAN_HLEN);
 
 	/* Move the mac header sans proto to the beginning of the new header. */
 	if (likely(mac_len > ETH_TLEN))
-		memmove(skb->data, skb->data + VLAN_HLEN, mac_len - ETH_TLEN);
+		skb_postpush_data_move(skb, VLAN_HLEN, mac_len - ETH_TLEN);
 	if (skb_mac_header_was_set(skb))
 		skb->mac_header -= VLAN_HLEN;
 

-- 
2.43.0


