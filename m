Return-Path: <bpf+bounces-73707-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BDE7AC37B17
	for <lists+bpf@lfdr.de>; Wed, 05 Nov 2025 21:22:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 222E33BE9C1
	for <lists+bpf@lfdr.de>; Wed,  5 Nov 2025 20:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0247534CFC9;
	Wed,  5 Nov 2025 20:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="bssxiGi2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D673469E3
	for <bpf@vger.kernel.org>; Wed,  5 Nov 2025 20:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762374003; cv=none; b=b1DTZsCt/xNuT6rOBsbGyOVAthi+DcgjoMfTv9K89NxpgbQ+My2z1gCZ6MRo2VADfoSpvOldqIrcG558p++HZ5BA+Xh2b7U8r10g4rOsPHSYMOW6ePCqAP2xBGqcwrXZRMdDwy1G66Gt9SyDCCIZkzY25QpIq+5AQ0QoeMCVgHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762374003; c=relaxed/simple;
	bh=Upet9p7Umb0vqSABysuFrGIKwxYWkwAicwYLyrO3MZQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LlXTILPPq1MURfaivysFxe066FPhWsJUs1CpFYWM6u6/dHMFEh1qGJjkKUdF9krMdRk+IBagS+9TLVWgord6G6k9kCwkcRHEUpxPPxlQqIdlZaYdp2j1xN2hSW9ecXgUzrGn9Rg6L5wkSr9b/AHKpF04ot27JpQwoT+W0gtIlO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=bssxiGi2; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-640c3940649so301609a12.1
        for <bpf@vger.kernel.org>; Wed, 05 Nov 2025 12:20:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1762374000; x=1762978800; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X55o8uffTuoHdCM7ovllE5BsVFypUxba13AdZvH4Yg8=;
        b=bssxiGi2OkwG+1itQ9FHprpjjqoCdDWNKjzf16RxoEblVDo/IVrd2Rja008OVlGRqv
         uDOW0Zjtvac0qvqdbozR4pMtZKbbnG/IBJypl94YwxeuvFRhBigWwlBTmAFgpd08Ub3A
         bnxVB75XajersOHA8Gpe10EmjR5tZffWv5rOOzl90NAU0Bw9Mvtn/fjisC2/2jhmh4i3
         raRgWRlTW6NrzF3IPeKRDXBKyb5mpvivd0m54s0OaJMkCS3I5I25JQ2ysRDS9prjqH8c
         uWSMioPFbhw+rgEAG8PesNUFEmP5R5xP9wQanU+dAJkVb4aH4v1GFeX06bAAa4URkUVJ
         yyyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762374000; x=1762978800;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X55o8uffTuoHdCM7ovllE5BsVFypUxba13AdZvH4Yg8=;
        b=kjLOntR8xNBANkeOIdykOfTJN8o+qRg+0xzZ40T/gJ56w+wo0doMQ8E+IoVs4sNMl6
         p2jCIu6kDU/o4lwvwN+CF5k2k+1+d0+3MAgnaGVWBTzDbSDDh2dN7jDlG5GZ0uFSFuxW
         Hhb42COzu/HMy2JJuugRcY/dDrgSQU3Gi215C9JqjqGBUGjNN3YifbHCrOutMs1GQmZR
         olil6grYf6X32ib+yJZIJW/VjgPQWSOqe5ATKBkHsZMuUW3aaS3NWOLV6gZkvjLXFrja
         BdH0pYkgvvUW9glU34jMnjMs1Kt2zG+ht3QhXQS7IKEfFPPwZDseF+qDZ/CD1YBz3+W1
         kFOg==
X-Gm-Message-State: AOJu0YwzlGhLvxa4bw68+2Wkch91FKlUmd9f9k7T20su9fd3WgZuP21q
	P6lFuBjygkwmO3IXtBGwqN1I/dq9A/+cCxanC9x9EcsSD+VdTQOiS6IdcYurbED3XZ4=
X-Gm-Gg: ASbGncvThYIJXUMJvbRzaM1CHkAm6xxVUP4ZFeV3pmtZNzzKG/hHq9Dj62sqxpfkeX5
	QcQ+85p07nbT0RXNcjiLwOC50tRgZKTLaE5PAI24zMPLQto6c2Eqj1IKh6r2GjU27m6wH7Syel+
	MAPV/A4TV+Jr3w38v0idplQGgKTi0vEMgJs39Cy49Kee0IqXcQvWTu9X9WkCX9vCbKE0Ylqq86R
	2HG+eOSHZEluHvsR7HD+2vjqGKfNsIt91PCjbBQbxQBBhkzMYbERmdanKYgxqqP894O94pNqLDX
	fWODOMB7P39sd6iK9bA0v2K3fjHOEVnCCnLk5W35tVgnd8+NzulpKQ/dYyH+7ydei4ReVJbOB9o
	29jbl39gp1rvQOtfLEadKNrvZOmtzR3JAHkvqQCMD4+ucU8bAhafIHGIDu4mGSIsnjbvc1pZ3ZD
	C0+iDMeIpBBZLpHNvaXgOq5qqEYlr6ghUrQN9Q2l97IUv+xw==
X-Google-Smtp-Source: AGHT+IEeYrYl/OAh/p1kXCZz9B2usparRxxtEyJ5l71YSfRdwcIDc+ZFpw7Om2A4L5Q5XP5Kp+Movw==
X-Received: by 2002:a17:907:94c1:b0:b6d:6026:58da with SMTP id a640c23a62f3a-b72654e25b7mr469640466b.34.1762374000017;
        Wed, 05 Nov 2025 12:20:00 -0800 (PST)
Received: from cloudflare.com (79.184.211.13.ipv4.supernova.orange.pl. [79.184.211.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b728937cc82sm45038766b.21.2025.11.05.12.19.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 12:19:59 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Wed, 05 Nov 2025 21:19:44 +0100
Subject: [PATCH bpf-next v4 07/16] bpf: Make bpf_skb_adjust_room
 metadata-safe
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251105-skb-meta-rx-path-v4-7-5ceb08a9b37b@cloudflare.com>
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

bpf_skb_adjust_room() may push or pull bytes from skb->data. In both cases,
skb metadata must be moved accordingly to stay accessible.

Replace existing memmove() calls, which only move payload, with a helper
that also handles metadata. Reserve enough space for metadata to fit after
skb_push.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 net/core/filter.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 96714eab9c91..370ddc61bc72 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -3260,11 +3260,11 @@ static void bpf_skb_change_protocol(struct sk_buff *skb, u16 proto)
 
 static int bpf_skb_generic_push(struct sk_buff *skb, u32 off, u32 len)
 {
-	/* Caller already did skb_cow() with len as headroom,
+	/* Caller already did skb_cow() with meta_len+len as headroom,
 	 * so no need to do it here.
 	 */
 	skb_push(skb, len);
-	memmove(skb->data, skb->data + len, off);
+	skb_postpush_data_move(skb, len, off);
 	memset(skb->data + off, 0, len);
 
 	/* No skb_postpush_rcsum(skb, skb->data + off, len)
@@ -3288,7 +3288,7 @@ static int bpf_skb_generic_pop(struct sk_buff *skb, u32 off, u32 len)
 	old_data = skb->data;
 	__skb_pull(skb, len);
 	skb_postpull_rcsum(skb, old_data + off, len);
-	memmove(skb->data, old_data, off);
+	skb_postpull_data_move(skb, len, off);
 
 	return 0;
 }
@@ -3496,6 +3496,7 @@ static int bpf_skb_net_grow(struct sk_buff *skb, u32 off, u32 len_diff,
 	u8 inner_mac_len = flags >> BPF_ADJ_ROOM_ENCAP_L2_SHIFT;
 	bool encap = flags & BPF_F_ADJ_ROOM_ENCAP_L3_MASK;
 	u16 mac_len = 0, inner_net = 0, inner_trans = 0;
+	const u8 meta_len = skb_metadata_len(skb);
 	unsigned int gso_type = SKB_GSO_DODGY;
 	int ret;
 
@@ -3506,7 +3507,7 @@ static int bpf_skb_net_grow(struct sk_buff *skb, u32 off, u32 len_diff,
 			return -ENOTSUPP;
 	}
 
-	ret = skb_cow_head(skb, len_diff);
+	ret = skb_cow_head(skb, meta_len + len_diff);
 	if (unlikely(ret < 0))
 		return ret;
 

-- 
2.43.0


