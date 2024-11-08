Return-Path: <bpf+bounces-44364-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB5A9C2269
	for <lists+bpf@lfdr.de>; Fri,  8 Nov 2024 17:48:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9344F1F2526F
	for <lists+bpf@lfdr.de>; Fri,  8 Nov 2024 16:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20C7D1EABAF;
	Fri,  8 Nov 2024 16:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EeCZCwBT"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3361E0E15
	for <bpf@vger.kernel.org>; Fri,  8 Nov 2024 16:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731084440; cv=none; b=AVAJgJWzBS+U+UI8WlWbjSR7fEMuXXlmlw8Yju52QnO1WA4AhkWL9kwspU/8znv6jIhoyqi6Ge3Ju5y2wKthtQYee321hKWPCls7YcdmZzD4AGvON6CMqSj94dG/NAtvmfVlflj7rzzX5nMu1GaxfWluCM5rsk+a/qdTZJbOOnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731084440; c=relaxed/simple;
	bh=LjJVosaVV8VZZYl0msQv5bgAMnoA8ds8SVqI6M2WSSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MqD4RJTTrxvzzfoRp9ZIsoMnw0PEEnUbhSpjwyAlio0fC4G0Z/vqXMEJ/U74bK2wCszxUdeNNS7Xd5X5CVioOHB9515RtDfRWyQob/BdgQZCpbAMYe+VKoJLUx9bvTQqyZk1jE6eUTrAXqLXeLtFh1Y0kahNK3kcpMWo+qCZui8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EeCZCwBT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731084438;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RrfC5q+p1hRQazHgbLjKpHsQFhKuqen69LFywqbKp+0=;
	b=EeCZCwBTywXWeqnMlkGBI595BwdBsu5W8gdIQAfmMYOYjWEn2fQiZFoBpDf8u+dpztZNMU
	4aGhoijgZ+R8LGcQs60oliEEYsqsgcgG2A8RnjcMhYaksUjQZYVEC1M8uRtjEzWaDtack4
	H1gxPDNbkO83VA/qZ6cjxnRxjy2+ZyQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-489-dCUPBOfAMOCev7qrqG5Wzw-1; Fri, 08 Nov 2024 11:47:16 -0500
X-MC-Unique: dCUPBOfAMOCev7qrqG5Wzw-1
X-Mimecast-MFC-AGG-ID: dCUPBOfAMOCev7qrqG5Wzw
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-37d603515cfso1157338f8f.1
        for <bpf@vger.kernel.org>; Fri, 08 Nov 2024 08:47:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731084435; x=1731689235;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RrfC5q+p1hRQazHgbLjKpHsQFhKuqen69LFywqbKp+0=;
        b=c5YWDwSglv8tshlNL+xuwRRU4UzbwoPAN8R0Yla61GSLYuDAbbKvVSVn3TnZD9F/1g
         JxFRs3/Gd5LCCesmmg1+wslRHSY7DJb9nKayNWsLd8nXX1eViAGXqWMq2YJDsFRYc1z5
         6ImuXF3sGTlLkMs8YqwMtWI/7yApodEwDbrB04lxIdvAmEMH+eP/KSKo/cK/la7YdFak
         8wI+vchTjYYJCjLKxQN+DFfYQYmNiP7iwVhk5KhH98GkVtPqWJg16184yL7onyWonJ4m
         t2siDT6jRmFMCuS0yKhxPHj/Dw87p5JuwkqQoL1cks1iIoX0/G7GAu/Fq71dGwet1Byg
         /aSA==
X-Forwarded-Encrypted: i=1; AJvYcCXrmgpehiVLcSChiV9le8KksF0E3PIY4X0B5QfiDold4T8+SieF33z2XMSQcNf7ZP8fPjQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyborobKiUqq4y4nPrtwOzkMzciC1KjsUvcCbMgoWhcBxxXgFxC
	ESMimnuIZKcenuBFtSGa6CjgZpaqKJc+KzKB5RonKwRPtO0NJ1RQwNVVhHqFHryNBoHavLvoBcE
	mzhB9tLYvDzGIzEmLEOQnDvTJ54JraMdSVT7/swoorSyDZaoHbQ==
X-Received: by 2002:a05:6000:1863:b0:37d:4846:3d29 with SMTP id ffacd0b85a97d-381f186bd0fmr2959652f8f.28.1731084435532;
        Fri, 08 Nov 2024 08:47:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHWcA41LXOh161RiZjWnOUtvZ9VjaYlW0EStSNknKhrAL/eqwHFCZUrVVXjDZ0PTGHOOgAS9A==
X-Received: by 2002:a05:6000:1863:b0:37d:4846:3d29 with SMTP id ffacd0b85a97d-381f186bd0fmr2959622f8f.28.1731084435183;
        Fri, 08 Nov 2024 08:47:15 -0800 (PST)
Received: from debian (2a01cb058d23d60039a5c1e29a817dbe.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:39a5:c1e2:9a81:7dbe])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381ed9719easm5508835f8f.9.2024.11.08.08.47.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 08:47:14 -0800 (PST)
Date: Fri, 8 Nov 2024 17:47:12 +0100
From: Guillaume Nault <gnault@redhat.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>, bpf@vger.kernel.org
Subject: [PATCH net-next 1/2] bpf: ipv4: Prepare __bpf_redirect_neigh_v4() to
 future .flowi4_tos conversion.
Message-ID: <35eacc8955003e434afb1365d404193cc98a9579.1731064982.git.gnault@redhat.com>
References: <cover.1731064982.git.gnault@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1731064982.git.gnault@redhat.com>

Use ip4h_dscp() to get the DSCP from the IPv4 header, then convert the
dscp_t value to __u8 with inet_dscp_to_dsfield().

Then, when we'll convert .flowi4_tos to dscp_t, we'll just have to drop
the inet_dscp_to_dsfield() call.

Signed-off-by: Guillaume Nault <gnault@redhat.com>
---
 net/core/filter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 82f92ed0dc72..c3a722134ca1 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -2355,7 +2355,7 @@ static int __bpf_redirect_neigh_v4(struct sk_buff *skb, struct net_device *dev,
 		struct flowi4 fl4 = {
 			.flowi4_flags = FLOWI_FLAG_ANYSRC,
 			.flowi4_mark  = skb->mark,
-			.flowi4_tos   = ip4h->tos & INET_DSCP_MASK,
+			.flowi4_tos   = inet_dscp_to_dsfield(ip4h_dscp(ip4h)),
 			.flowi4_oif   = dev->ifindex,
 			.flowi4_proto = ip4h->protocol,
 			.daddr	      = ip4h->daddr,
-- 
2.39.2


