Return-Path: <bpf+bounces-72238-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA6BEC0A96C
	for <lists+bpf@lfdr.de>; Sun, 26 Oct 2025 15:20:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59100189CB8D
	for <lists+bpf@lfdr.de>; Sun, 26 Oct 2025 14:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 524E22E8E00;
	Sun, 26 Oct 2025 14:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="fPmkFDOI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270142E8B8C
	for <bpf@vger.kernel.org>; Sun, 26 Oct 2025 14:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761488330; cv=none; b=hV/NhkJpyfvk8ecqDpuDaOD7AxehfyZxmzmr7D8vB2ptraqowdL8qtpyOB4kh54JkwQVqHB0tCHf1QW341xg/F4uPEYvcqeH7dX7vRGFE3hMPS4jJEDFFErHldz3efIByDrgCfpcWcrTCJBm/mhbVCR+NGW1b4vow3+LrzdTpzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761488330; c=relaxed/simple;
	bh=NUm71Zd06KWl3P+QfPX44GSmHRrTuDkrZCYwhisbxYI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tKrKM5UtnP9q2uVLOnSoI4RsE/+0iHUDcwgg7ZLnzBjgXXFaYEe+Gzkn+q4gTC+tr0gWkOWo+Kf6zQ0KPDvP7+bwSmkVycw8fwcvvNYC/kVCvO6hMREb/KnNJkHQIy88+qr0KIgY0pO/hp4cY3a617ovxj0NIUuLGzrkYGuZBl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=fPmkFDOI; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-63c09ff13aeso6463325a12.0
        for <bpf@vger.kernel.org>; Sun, 26 Oct 2025 07:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1761488327; x=1762093127; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fGSfs1QWwD7Mhp32E/45KeY7GB3oXHAdzAqWdM10vmo=;
        b=fPmkFDOIJC06yyFfkNNuSMcQRxSGyR1qnvFthFZ4L+c+lgFOB0Dp2inoiasNymWh94
         adwvvGeeatr6XKVsNAqKL+VlVDQC0bRueW7gUW9PRB0yNU5Q69uO+EMpuewaBuSccQeR
         THurK73aaehXRAiJFw3GCbgnhsQr5+iXTAD4jNDYO/VPk6KfLGeeLcqkiJREp74ZEm7Y
         kse11I7Rg6Q3iYVRFxlsDH8BAKx7ESI2yu8bTJyAmOpEvVwrUTtd8gpgimPijF+CD7sz
         /jnUVN77v2DTMFcQbtvpJjgLp8xX486JVs+2E/afuNVerfBSK5DjvhRfKFaeDQXBzNtG
         B67Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761488327; x=1762093127;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fGSfs1QWwD7Mhp32E/45KeY7GB3oXHAdzAqWdM10vmo=;
        b=vgjY+krpF0ZqBPmITvLcnqtsdbL9cnKJWWmPRSjw4rhJuSoc0zvJY/8uhOCIgoOYJ4
         mNr+yVSK0HBWRACToG9JjtD6TMhl73krjzIKqhDdJpcosceO5fw9ux3zTfvAHlYNX1PV
         kyZuZQsc9dyEpSjbTj4+nquSl2aXuuXHXvdG6Qg3Agn/ihEDQuPDSMqVa32bexlQybQI
         4ceVfsG60yE6/nwhnyPbbg1DL2qnQ9MLYx5n82whNNja2fHp518oEN/06TTeCbI3k8+h
         bnkuLZLR0Dppp4HdukfVobBc28qtEDGjsVvLh8Qt7v60d2yCX5JS9Zkh3g5nIP/evLE6
         mjhg==
X-Gm-Message-State: AOJu0YzGCnudEJQ9oHfjE2pEnMdHsqgXO4K+TYus7SsfmaQVZ/2BpmRR
	UrS5XlNYE86k6JpV0lgM/jDe/ho7Lb2GVanCNSOUWkmM1Ouqkel3xn+Az1ixqc+ucP4=
X-Gm-Gg: ASbGncuAqAjYbFFOeTrTCMOdiZt585huGhpx1FfWEI98HeNu06twqlhZunlwcgvx7qq
	rJLjN0PREhP0ivYMuV/kFZvaHzxO8GNOzWDI3yX94gC+ru0JTnECLtBppj/ZHrzX1Oz7xxnla59
	mmZ5llP+XjDHV4aMoUqqKn8x7ECsNrJXgA88CalTM/6Z7kJngyRoFx40y88zIiOsCPWSDpRSYoV
	hJwbQUXVO/yl44QjeggJZtKB9Gi0KLsyd+GuZpEKKMDbg9DrALIJNe+pnH8WgiMtVuKu1XYX6x1
	xsin5BK/WILp2qBTWIKYCSVbhrjiGelfx6837iTMRrqfzpdHvCOBuYEuEFtGMsdAU/P0EgG2jdh
	s3ggBgbu+aD6UAjFhIiDnc8roPolLNmbQjOZTRy+yPI9ACopKi04us/iaIG/PEfjA5R0BeNjqlx
	gy4ImHJNg/hFBzfkrg+/mD0o3hpZ/9EHgJqR3b0huXCyGcBJbr9hbzxQ2V
X-Google-Smtp-Source: AGHT+IFFI9U+/Suj+yHm3motfX0Z0XGy9zKAbiB0+/BAugyFmb1KJIT+GfugeSh4FBo8SVcINKX47w==
X-Received: by 2002:a05:6402:40c5:b0:63c:1e95:dd4c with SMTP id 4fb4d7f45d1cf-63c1f6cea34mr35300386a12.27.1761488327412;
        Sun, 26 Oct 2025 07:18:47 -0700 (PDT)
Received: from cloudflare.com (79.184.211.13.ipv4.supernova.orange.pl. [79.184.211.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63e86c6d7d3sm3526544a12.27.2025.10.26.07.18.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Oct 2025 07:18:46 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Sun, 26 Oct 2025 15:18:27 +0100
Subject: [PATCH bpf-next v3 07/16] bpf: Make bpf_skb_adjust_room
 metadata-safe
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251026-skb-meta-rx-path-v3-7-37cceebb95d3@cloudflare.com>
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
index a64272957601..80a7061102b5 100644
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


