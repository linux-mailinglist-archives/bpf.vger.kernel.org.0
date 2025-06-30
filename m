Return-Path: <bpf+bounces-61838-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BE57AEE191
	for <lists+bpf@lfdr.de>; Mon, 30 Jun 2025 16:56:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83F9016BC30
	for <lists+bpf@lfdr.de>; Mon, 30 Jun 2025 14:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 706FD28CF6B;
	Mon, 30 Jun 2025 14:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="NZMjds38"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B14928B7F3
	for <bpf@vger.kernel.org>; Mon, 30 Jun 2025 14:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751295355; cv=none; b=OMsp7jHV7eAOs68MujPynSx+KXaLgeS/gsvOCg+u2qTSZBnu+fmesTYf5vpSpHuSgfkCy4qGrWOGfCc4KmZGkkdp0f9uE5H3QSajZlqiL/KphemHCPrC0N0UTsajXbsZpBq2xpCfvE6X7HpMHV3J8gMGZH/vvQkYEd/XY1DIqdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751295355; c=relaxed/simple;
	bh=GzOXkVRZ1RA5wfwUIY960tgkUvDgya6+Pg8nGX0DNWk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LBcCHVY+JvIyyT+vy+1vc6AJ6/HoMIeiGv26R6c1jBtOM4WecZ0URzlLJUdruSU4ZFsi7GUIdij1JYfaHBTUdHUpDBs5qZM0fV671DTQ34H2G0eL8fCNHUH54p4IZIl/Zmp8P41Lju0VhOdLPIKL3G3qk0WzGiuSCSOGqSnpnW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=NZMjds38; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-60c5b7cae8bso3704181a12.1
        for <bpf@vger.kernel.org>; Mon, 30 Jun 2025 07:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1751295351; x=1751900151; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9yAuFLqlKBAFMJXwuipzoYMIa6JSKZx0GpQeqtSpe+k=;
        b=NZMjds38/Y3LPHsudImdq9zbuF/fs0tyKJ+B1N0TOidp73mWF6YLMCUcYsGzfmu8AB
         ljhF8x1NmjIyv8jtCxv1t0dOUk8ncEuQQ8aIwpUEUURvld8Hw0z8tE++0o16zYxGziiL
         e71dDWsI8I5bp3KNQCqyD+p52/Kq0LlQCK7cBzHipy+P2QCg1SBf85zp8VRZZ2HlcCgc
         PKjxU2j9xe/iwf+BGBJAY0kOnN11Ez2xVKOcW/tv8j1A+PFqag7mlA6antn4CdgsnVKH
         W9rquPgoqJ36/0NeGdurDeshkbn2Rjw5txZ35ZQ+vg7z5iE4+oSGYbj4PzAK7iIbVhob
         Cudg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751295351; x=1751900151;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9yAuFLqlKBAFMJXwuipzoYMIa6JSKZx0GpQeqtSpe+k=;
        b=klPe/3YJIpjhSFJ9s8s8g6Um+wtC6r1iHD/hqS7/FDIHKqtbik4HaYAClyOlxMHU1P
         XILRWg16nzksK4XCuO5axBvPcT++XEdgGFuZiDxEMbv/+NEoDjtO2tCeANFyaBmN0jN/
         T8vRf5yq8wuQ5pfHj4VD/HPIKJTGBlTdPa0iuvXQMmWWT1dBEpV4iFEzMhkrnYEBI8zA
         Sw/eQnag8NurKEY8gEF0v7RjiUOIWhQTW5rIBFf0aTFXhHZ3rqvCEkRsMDVVDn2AZA93
         EQQOQ/AwVXYRFHn4h8obwjlawqjm3l3AiAVd0zMr4JaAIpXe5shsWSrCl32NKUsoEMcB
         jaWA==
X-Gm-Message-State: AOJu0YzDySVmY8DbrFQS8PGNicPJLDOv8LOUzMhNjYqX7s7W3nqCe8/H
	/vEFFyVwezNbR2yYEwGixfEGxwU7ADLa6QEtArZ7cmoW8u40PKeJqBvAD9RrMVwA1kZS0rEd7iW
	qLMCS
X-Gm-Gg: ASbGncvHH28C6/8Tp0+9cQxM1++hgFHl1b4uMfB3xYhXAxDHhu4IE82df86dMr6YOZW
	pAw4V7RSialFO4uJ4tRnXryoDRryn1GRibkfCJQlJdCZp2SLXwQuFmLQVMiGb1nJZB7/LHP6nzZ
	eOlTENEKrXJdYYc91TDsQLpYCau5S7fwAAj8ujZNnXm4xJhHzK5Yn853cofYlu8D+yROFnOMxe1
	ia/X29FnmCQ6BAmhrJJpGrtrWop+qKX/ZeIWUM7LJS2IOV8ATaYJW644BD8/nOFGuczUi/6Sh9U
	phuuOffkm79D6qpL1LUPZ6AEdaLClanYmw0vzbVj7vH5Lh93uzWWTw==
X-Google-Smtp-Source: AGHT+IFCiQAs8MG30WW1mkut9KO5kpk5+ZbaZhMcZCQePzx+1UTgyvDYGVEfRamJGADQE/utk2Izxw==
X-Received: by 2002:a17:906:794e:b0:adb:4342:e898 with SMTP id a640c23a62f3a-ae3500b3f07mr1467700966b.28.1751295351457;
        Mon, 30 Jun 2025 07:55:51 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2dc::49:10a])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae373bc594esm443950966b.96.2025.06.30.07.55.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 07:55:50 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Mon, 30 Jun 2025 16:55:34 +0200
Subject: [PATCH bpf-next 01/13] bpf: Ignore dynptr offset in skb data
 access
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250630-skb-metadata-thru-dynptr-v1-1-f17da13625d8@cloudflare.com>
References: <20250630-skb-metadata-thru-dynptr-v1-0-f17da13625d8@cloudflare.com>
In-Reply-To: <20250630-skb-metadata-thru-dynptr-v1-0-f17da13625d8@cloudflare.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, 
 Arthur Fabre <arthur@arthurfabre.com>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
 Jesse Brandeburg <jbrandeburg@cloudflare.com>, 
 Joanne Koong <joannelkoong@gmail.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>, 
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <thoiland@redhat.com>, 
 Yan Zhai <yan@cloudflare.com>, netdev@vger.kernel.org, 
 kernel-team@cloudflare.com, Stanislav Fomichev <sdf@fomichev.me>
X-Mailer: b4 0.15-dev-07fe9

Prepare to use (struct bpf_dynptr)->offset to distinguish between an skb
dynptr for the payload vs the metadata area.

ptr->offset is always set to zero by bpf_dynptr_from_skb(). We don't need
to account for it on access.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 kernel/bpf/helpers.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index f48fa3fe8dec..40c18b37ab05 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1776,7 +1776,7 @@ static int __bpf_dynptr_read(void *dst, u32 len, const struct bpf_dynptr_kern *s
 		memmove(dst, src->data + src->offset + offset, len);
 		return 0;
 	case BPF_DYNPTR_TYPE_SKB:
-		return __bpf_skb_load_bytes(src->data, src->offset + offset, dst, len);
+		return __bpf_skb_load_bytes(src->data, offset, dst, len);
 	case BPF_DYNPTR_TYPE_XDP:
 		return __bpf_xdp_load_bytes(src->data, src->offset + offset, dst, len);
 	default:
@@ -1829,8 +1829,7 @@ int __bpf_dynptr_write(const struct bpf_dynptr_kern *dst, u32 offset, void *src,
 		memmove(dst->data + dst->offset + offset, src, len);
 		return 0;
 	case BPF_DYNPTR_TYPE_SKB:
-		return __bpf_skb_store_bytes(dst->data, dst->offset + offset, src, len,
-					     flags);
+		return __bpf_skb_store_bytes(dst->data, offset, src, len, flags);
 	case BPF_DYNPTR_TYPE_XDP:
 		if (flags)
 			return -EINVAL;
@@ -2695,9 +2694,9 @@ __bpf_kfunc void *bpf_dynptr_slice(const struct bpf_dynptr *p, u32 offset,
 		return ptr->data + ptr->offset + offset;
 	case BPF_DYNPTR_TYPE_SKB:
 		if (buffer__opt)
-			return skb_header_pointer(ptr->data, ptr->offset + offset, len, buffer__opt);
+			return skb_header_pointer(ptr->data, offset, len, buffer__opt);
 		else
-			return skb_pointer_if_linear(ptr->data, ptr->offset + offset, len);
+			return skb_pointer_if_linear(ptr->data, offset, len);
 	case BPF_DYNPTR_TYPE_XDP:
 	{
 		void *xdp_ptr = bpf_xdp_pointer(ptr->data, ptr->offset + offset, len);

-- 
2.43.0


