Return-Path: <bpf+bounces-73706-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8343C37B11
	for <lists+bpf@lfdr.de>; Wed, 05 Nov 2025 21:22:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DE883BE54D
	for <lists+bpf@lfdr.de>; Wed,  5 Nov 2025 20:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8216734CFB3;
	Wed,  5 Nov 2025 20:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Z6fx/Zup"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AEFA34C9A1
	for <bpf@vger.kernel.org>; Wed,  5 Nov 2025 20:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762374003; cv=none; b=AXRd9vXs/w7IIwX+YCh8+UNIlVrRqefnBAbFjQfelYc6EbUOc03TfctWgMQ+g7+mBriAPXFZ0JExfXNZL+e6NhboFwYtT1a1J1VglKpz7H119y5ij8SWHQhZbGH6u6NaFLosgrJZlDBs2JwyFz0AoQAxrKeiS6IeArBe/S9tUvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762374003; c=relaxed/simple;
	bh=xleLnqeTmax3LL9D8FWb7af2lc6VsV84ywgJTWC3NVc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YyxkAvNuuyvUgv9q+1A8A4+skcUSAQ2lHS6IjWdSodlD8lO8+iMBeykxKO1Xfbgca0Qi10Uxa4M5XJ3Y6myuzZ0YjqrMlbWWUErM03o3a8Mk8GkUNi8cl32tMFugGlBwtTNfKiOf5LUh3jgk7MgUjikG7AXFXITYsfo/qua5Qls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Z6fx/Zup; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b3c2c748bc8so25913566b.2
        for <bpf@vger.kernel.org>; Wed, 05 Nov 2025 12:20:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1762373999; x=1762978799; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=isGYaQWo1V/ui7jH0r+jvXI+ZaW6MhGNSYr2vGlL7Vw=;
        b=Z6fx/ZupTGWc5n3Qvf320i87hzdXbXTHOWScsxQH9JBHTChe8NJkaxkoCQVjA6PDkg
         6XJnjfdwHK/u7g86oE5FQeitcMC1k3hMKA/AnK/OqL5lSIVxDs/W0Y56zq+S+I8sxdU7
         CzMP1/OCTz3xfB+9qurJdydqmq4glqQ0ADSkbcpM/TBpfnggbUrzjbwu/1KY1VEBXRGf
         FR/SEEwQYlvK/lxGvhOmddcW31I3chGtGDaJAKk0PTnryKpSbFzsnBLIpyMaCimKJj+Y
         hlFsDtZPf3lRnQaXPWdiwJ7TTMQFS4yM4Le1E+aeRMQcUTVDBYxb3dse519F4w8D/3Jj
         Sb5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762373999; x=1762978799;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=isGYaQWo1V/ui7jH0r+jvXI+ZaW6MhGNSYr2vGlL7Vw=;
        b=pUzTZlmaQ5SoOxbwDv7c4FScR4Dbi+1eFlAsP1TWVOCC1FxdsPiVa+hz+jatOaFC8X
         OiyjkFvFNYwJ8tELqMS/BbpSvLCuJTr+vxOrmAs0JYk7EMyJ+XTmGhDNc5eQhOmBW4A/
         cxeLsTYhDODrbtSdv9q3xBHV7pvfAfZGm4YX5ZbzCW5yfhCaMd0AR4sA08BYAUNTTifv
         wANgGEHfK1WIJ55juK9x5XV9EzkUluqfUJukEs+KjIJ7qBgSst7oXx4hLZnLcLNHlteA
         H9WT6/2txYmoUYMd85rpylPuzkEDJxfC7qos6XtrDhyvmxrKm2zUMAj9sxTkBXlRFXCw
         4+tg==
X-Gm-Message-State: AOJu0YyIGrw91o2H6u85+t4Av35UNh46Zl7fyUO3E3SmadzcCCE3gUWG
	e9kMjosLKzyKqhxZSddlmd8YDO8A0VFoprEV36iP97IHtg7CtfZFx5EdtOMyJlsCW+Q=
X-Gm-Gg: ASbGncsaDmrM6QWThVjMWx7HZmA89C/LxMicGf3VSZxVGaKMSJM0rDoQc/X5A4BexO+
	mr0ALqSzNZp7wgJu42akjpIQj/S2/8XP8Q9MUjL/zKREcVAYnTj+7kVV8TIqRS2m+TKbv3939V2
	b5Oni5lNqR1N014drYIKwgZBvQu/2beQZGQcrv+N8/G8bQbqy0U0toSjHrMfxksTbLTuCx98gz9
	7KnU7r+88gcG2i3Y1oVTDw8+wqdMXr3Fjtww8qWKu+ZFwF/JsVs43njggUlpNz+UYycDo/uh5yb
	TqPGn2BB4UvnK0xQrg/3pvjn41HG0k2UD/XXmOnj6xkPIQXl0biYe7wKAEiO85IoFLp42YTjl8M
	bUXHL8HpxYIESAmQZSUJSw6X0IEnYMo/WvUsKzGjiEyp30ev/T/wit8IOybhnCf0CqZUUEsWmJt
	F700SQJ6TJjIy7USMFOLTQAnkcyfz7A34aW5Rh15wek2oZVQ==
X-Google-Smtp-Source: AGHT+IG9x0P3xs8/49geNhcLPgkmjr5oNkQw0WEE7H5YygMuVxUnV8i7AYjOsALrhy8cMyqjK3/30A==
X-Received: by 2002:a17:907:968c:b0:b72:5983:db0a with SMTP id a640c23a62f3a-b7265297e0amr422946166b.15.1762373998635;
        Wed, 05 Nov 2025 12:19:58 -0800 (PST)
Received: from cloudflare.com (79.184.211.13.ipv4.supernova.orange.pl. [79.184.211.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72896c8e3fsm45540666b.75.2025.11.05.12.19.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 12:19:58 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Wed, 05 Nov 2025 21:19:43 +0100
Subject: [PATCH bpf-next v4 06/16] bpf: Make bpf_skb_vlan_push helper
 metadata-safe
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251105-skb-meta-rx-path-v4-6-5ceb08a9b37b@cloudflare.com>
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


