Return-Path: <bpf+bounces-71299-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE4C7BEE53C
	for <lists+bpf@lfdr.de>; Sun, 19 Oct 2025 14:46:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 950F1189E10B
	for <lists+bpf@lfdr.de>; Sun, 19 Oct 2025 12:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EB892E9756;
	Sun, 19 Oct 2025 12:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="adPtU8rK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D1D2E8B66
	for <bpf@vger.kernel.org>; Sun, 19 Oct 2025 12:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760877952; cv=none; b=NAL7+uXS6rDZUeYr05Jax+24jBXCoBJCIN5fcr9aL3AxUuxmrpTtdU3TWicDTxY024kZ/ECXJqHQb1icndwSXM0GXppTrGHTgcluUzGcUqcG5GZpjQypvUtnctdmGntOYj9k4g/X/AD6/slYkHwY8ZfcJ3q+BbGa4AcLMC3Qmig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760877952; c=relaxed/simple;
	bh=xleLnqeTmax3LL9D8FWb7af2lc6VsV84ywgJTWC3NVc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IZ+pb3WzISviPEwYjBNC9I/aRvRctKEJf1qDSEIBAybKcswhuYFVHZXWAnEjFiNglnNPKW/z0L8TCXCvcU/tjW2ZZflpIZwtn/eQsuaDrPgzK7VBhQFi/XzN/Hdhj9QmQGr17Sn6Euk3sxSwXh/EvC0xORWgQ3byVwTO4UFEfRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=adPtU8rK; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-61feb87fe26so5682427a12.1
        for <bpf@vger.kernel.org>; Sun, 19 Oct 2025 05:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1760877949; x=1761482749; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=isGYaQWo1V/ui7jH0r+jvXI+ZaW6MhGNSYr2vGlL7Vw=;
        b=adPtU8rKN/NuKMrS3UXb0UDajnJeT3WggmwkNsOk4Ojt0hp3pYWCQbDtRbf8r0ey8o
         KFjQ9LWLu81GohlWE3/9PHOx/BNVYol9SvuDqVSEoZvDfeIjiX9NtZVQcTWGCWr5fAHh
         e3qNFoRflv0BBWMvnAdMLJOad8x6RZDTA5yvE24TWpv6hfYiEL6NpgY8I5ly1gloidlK
         pCXKTvDgnRfGx5GvqqtI4ODDevtNP1X52t28wIAfp2IJLkOovPLjKC+i7DwfpnMunWHu
         leIQqSxoWrDLKA+dRhQuIS8kKv629IPzKvHGFN8ui7/Nj2UBWOjdclx+Jx/U08AZgMl3
         6knw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760877949; x=1761482749;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=isGYaQWo1V/ui7jH0r+jvXI+ZaW6MhGNSYr2vGlL7Vw=;
        b=HIzW0FmCaFum9GeUVTySPSa3UNtnosMGwVX41+KNs/jd52pB+NpEfsXN+GJa3VTDPX
         ZPFgt2G72bZwa1amLNULbJo8pDGdE7KYTHFh0DtFmjXqLberitsw5Q1vcEuG/W74k1nE
         cfNBtxkp2DTQKpRbiTPbrR+m/hJgb+6KXkm2hEJk5JOX5kiKqqhO2QHVaRrS+Rlo0Tyn
         ++uNGKTyB1zLBH8OobnH02LnRcStaTLAEfZw6muhXtAtvFJLPAKLt7GI3c3xhzlOgJoc
         qc8CS+SSkOq2TRIPTI26FUCsJHmHX/3Ns7yDgLDnanf3VONTNlrVBgUwlwPqkkPcmSAt
         rDww==
X-Gm-Message-State: AOJu0YwAOwV5JaNiXFBS0riqIVC3jxEkQ7XvlambtiSgolTX7NmdL69r
	WaxvLun98yZIrPLd8L/TNYfNQCOohCmWuAfLLRPi4dSOJPaHX3c+Znsm1oZoMP/474M=
X-Gm-Gg: ASbGncsrtZ07y+FHpV9RkplJZCZ70AcjvbfLNUjyGOG/WCh4nDFRK10XAXGDvMkVLgZ
	aivOOHA3r3SFGYcQb+jL9b2O1rarwrzCpO6R3qLzBhYdYQUIHtZXZgJlPo+Hfl7x0JwKqPvTGsC
	QUkhDAxLqYAc4bjbpQNTyeIaEcEKiZfl0SgIF5bjKwZIrKxfa0CCdAYaoj34YaUONhUaQLiFTCu
	NTe94/ZcBdKhH6fWz1MSq1WbpcigddrSYUQcIkp4xXvP9BfSG2AduevzgCNIXXhk8SYYo80fu1t
	KlUX88Nvhsi5Ms7KHE2oSrzZnFiT5K4TdNUmzE98KJj3RAifZjXgqflLEgHRN8fP+4egahkWJXr
	yKHaXDGaS4oZIS2eXGV7c2aHjbqgG27cSOy5vtlFloRbUHypgIW6nNo5oBksoT1kYMw/HszM1Tz
	d5KA7c1jlsvKHSL5n44hZfyVkt/kjsg86QrY0a0VZ3XnH51xws
X-Google-Smtp-Source: AGHT+IFm+13/Usyf+mPKHCUlEAe+40VXIyegDq6lyi/sldF2K3bcIYC07yC5iWlYMl11WZINFUSf/Q==
X-Received: by 2002:a05:6402:146e:b0:63a:3e7:49f0 with SMTP id 4fb4d7f45d1cf-63c1f6f5e6bmr9507256a12.33.1760877948902;
        Sun, 19 Oct 2025 05:45:48 -0700 (PDT)
Received: from cloudflare.com (79.184.180.133.ipv4.supernova.orange.pl. [79.184.180.133])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63c7267319esm1381222a12.36.2025.10.19.05.45.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Oct 2025 05:45:47 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Sun, 19 Oct 2025 14:45:29 +0200
Subject: [PATCH bpf-next v2 05/15] bpf: Make bpf_skb_vlan_push helper
 metadata-safe
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251019-skb-meta-rx-path-v2-5-f9a58f3eb6d6@cloudflare.com>
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


