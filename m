Return-Path: <bpf+bounces-77822-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C809CF3763
	for <lists+bpf@lfdr.de>; Mon, 05 Jan 2026 13:15:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0AB57300DB1E
	for <lists+bpf@lfdr.de>; Mon,  5 Jan 2026 12:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BB37335061;
	Mon,  5 Jan 2026 12:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="SIezLRJ4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23DB3335BAD
	for <bpf@vger.kernel.org>; Mon,  5 Jan 2026 12:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767615292; cv=none; b=kZhPxQPTJ+QzxPm4QcNi+sXUdHfRa5Yf1ORZ4khXOdcDV5FyQ2+9YOtafoYzRnWxSCdglfEV+5tfhcnjAQYJpEytZUoYUG3G7dla+yWi5dOHZSkoNJMfRyQG+jzUJzP+vGar57NKjnbGzWV4w4sXJrhD8XDMeixfAFpdb767/UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767615292; c=relaxed/simple;
	bh=1tuE34tqdRZ0Cq/ciIXf0IbqXReLHJ00YT+wtQPddnU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rqxiJij0+70KzjxQmBkXCit0qebtBkDoW3Lc5wjXus1u6LFLXcJtUGRORZWDLAlT+kOkoA3ucgvXdHowvEP+YrYlOyhWFmuj3gL3vuqR/4nZJYVOioLk/bRRWARdNeyrFy2VGad7dyO653NZpXrxYLtpbNuCtighcirP0Ixy9B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=SIezLRJ4; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-64b9cb94ff5so18163624a12.2
        for <bpf@vger.kernel.org>; Mon, 05 Jan 2026 04:14:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1767615289; x=1768220089; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bvsM1sRJWYDcPZakX1MsPvBpIu+3P2Cxb3oshH7eLdY=;
        b=SIezLRJ4AVA4pUlrYJWYpK4OjS0xu8c0PR+pDma7V1KQoqUFsb81WUdqtJI7bVzC/O
         7LH49Rg/jtEqWzWvq5ypXal3WU9d68196xXcEYs0vajyRYwHL/aN+gLdF4Jlc3UwtkZB
         P811MuYoud7f1MnST8zLFlDh5EbAKbYoAvBewXVuo0cf3ABc4tbd3F3u2/iPGapTO+2D
         KVuLTRl1zvtVTbac+j7lX+e+O/sRSxKI6RZJCf9FsOjW8hP2+ApeiNkx1lZJcZuo2fwB
         n5xhYnjlUAej9mdOB0jbNkzmLTK+G9pTl/QIRHCVrTVWSnf2OVYarez1c70NHC5bNiPM
         +Iag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767615289; x=1768220089;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bvsM1sRJWYDcPZakX1MsPvBpIu+3P2Cxb3oshH7eLdY=;
        b=sQvhbQ0d7F+wqfOONdiftPkapgnB5ojqG/ZiWkd8RboFQKQwPdADjDfDIpkFSA86mz
         v/HKuyPc3ksLuOemeIkYF4K7rQQpBy+7xdn/9GVLq3QRHUQ9UhUvihBvAOgbuRIlTM5i
         hvDKYuexnckpJPl50D5ho5MqRg0ZAL3a0T2uE+u1P09uJUB/FFrCI3T8L/gws7/gzcgx
         dExeRbAysRDq3DfsG1H7GSCzNMGIIP1SguxtqV3tEahvGW5EwRl+p32ALEwWAU8r6hN7
         kGjUlRntpM2gyYAsOkk453mcOkYWNyNVVioj/J7VELEKJkvMNGVpuVKnN92kxm2pvZ0K
         iYOg==
X-Gm-Message-State: AOJu0Yx2Zs1JEFYsYDI4y/GcbckAU9/YLGfMfLNUa+oSTId9MJuEqWs9
	FGKu+bs27dsxokruvBCWnogx+L5JpciQchpPtvT7wZAfLzv56AZTfaVFsipLCl3+2Vw=
X-Gm-Gg: AY/fxX4rgsXas/JeCEzJ41lWuQVwnymckUJO08cLuv+Iaz77sYYCtDcw/Tx3mMFoaQo
	XZ0KHJ0Tfl15yd1o8fD2pPlZkhtcmXLH+mEkMMihT16vUWodc3nNxK15STHj8ljJw7w7Ocx5zii
	TkTDWhPnPu8v5eGlzRKSCx0Py77MX2d05q4pO+2T6Y6AcyoXnoj6y6d9exMl1gFzK2xrOALR87Y
	US2GjXqiymAKeJkFcnkvJo8+fjKwseq7bN4MULkJjzesJvqBWxZ87PZasZO1+OPp5CeVVnHJRRW
	AtZeUVE3VXBpKCeReS9sgRJnJ7CCodU7bpBGPW0Q/maA5A20H8NbUU63PsuUFCOrH1h4VTdhaGs
	i7ARyUZOW28iH0exjMM4iJ2PiRkCkVISf8ZfEe+U/i8UOYRoe+XZWpF2khSJitDQJJ12Of0dBJi
	rQzPYPd0V1ac4MFs+IzH1v18NMPIIIzOFSnG0VCm3XjtO6+gZsf9lBkKCYDR4=
X-Google-Smtp-Source: AGHT+IGB7MLOlR1tLtuW8MR85eupPc/VpekFTuwvyLYlBNEjUgo9TT1UfR0xNH8NjYLmvRnpdpM93g==
X-Received: by 2002:a17:907:3cca:b0:b83:c7ff:a47c with SMTP id a640c23a62f3a-b83c7ffa5b2mr1145231766b.17.1767615289369;
        Mon, 05 Jan 2026 04:14:49 -0800 (PST)
Received: from cloudflare.com (79.184.207.118.ipv4.supernova.orange.pl. [79.184.207.118])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037ab7f7bsm5433934466b.18.2026.01.05.04.14.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 04:14:49 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Mon, 05 Jan 2026 13:14:33 +0100
Subject: [PATCH bpf-next v2 08/16] xsk: Call skb_metadata_set when
 skb->data points at metadata end
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260105-skb-meta-safeproof-netdevs-rx-only-v2-8-a21e679b5afa@cloudflare.com>
References: <20260105-skb-meta-safeproof-netdevs-rx-only-v2-0-a21e679b5afa@cloudflare.com>
In-Reply-To: <20260105-skb-meta-safeproof-netdevs-rx-only-v2-0-a21e679b5afa@cloudflare.com>
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
already points past the metadata area.

Adjust AF_XDP to pull from skb->data before calling skb_metadata_set().

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 net/core/xdp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/xdp.c b/net/core/xdp.c
index fee6d080ee85..f35661305660 100644
--- a/net/core/xdp.c
+++ b/net/core/xdp.c
@@ -768,8 +768,8 @@ struct sk_buff *xdp_build_skb_from_zc(struct xdp_buff *xdp)
 
 	metalen = xdp->data - xdp->data_meta;
 	if (metalen > 0) {
-		skb_metadata_set(skb, metalen);
 		__skb_pull(skb, metalen);
+		skb_metadata_set(skb, metalen);
 	}
 
 	skb_record_rx_queue(skb, rxq->queue_index);

-- 
2.43.0


