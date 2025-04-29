Return-Path: <bpf+bounces-56916-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51B99AA08FB
	for <lists+bpf@lfdr.de>; Tue, 29 Apr 2025 12:57:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BC4E844F94
	for <lists+bpf@lfdr.de>; Tue, 29 Apr 2025 10:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 067EA2BF3F7;
	Tue, 29 Apr 2025 10:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q38RdTDm"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF80C2C10B2
	for <bpf@vger.kernel.org>; Tue, 29 Apr 2025 10:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745924242; cv=none; b=dd/iICk5IT5CC4LJOf8v/BBKmnuA5H871dghyNMlsk5liT5O4xFCMzmOgASEvy620eQp+PyTLXGb+LKMXSZV/Mkdu0rJ0hdRXN19pHFERf2XsUbuEaMaxxKbEuxGynX8jfPSEkhVcsV2BpbZld+8HoMVo94d05s7FaDpDYDqXFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745924242; c=relaxed/simple;
	bh=E0OPxLkNygm8USuIrlqcZJClXsTtsoX726UOJ72djK4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Ueif4glpZNGliCdiLKy81Lo7CiTAeINtyHKPbbwqUBp/gT8qWS/bUSFLAwCVult1vhpM34ZDIxdX5ioF9jo47iwya7Yv+fE9HsYNmDLmPOvIcw88KN1qmak29vPAkEU2uZi8sTJvxq2+UBJHdErOYXWXnnPjc11xFlFlXdzP5qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q38RdTDm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745924240;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N32jCRGy40LR70yv+XWjgcmG1isI4rJ5byTryD47s3k=;
	b=Q38RdTDm+ty2UcYrlsb2ocAIPEFkyWK7FG2OlrLJr0sFs8eEQKRvMD4zVHOlMZFJ9PGt0y
	WRyXcqMXfGpRelbV23zrAg4G5GbydJvP4v2Ki9vXzkPMGXSfUyPXieavVCMpOEey+ccY2M
	vFujDC06O6i+t1EgUKReokxQDEGITKw=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-48-x1tdomU1O0mgYFQPlN9bFA-1; Tue, 29 Apr 2025 06:57:18 -0400
X-MC-Unique: x1tdomU1O0mgYFQPlN9bFA-1
X-Mimecast-MFC-AGG-ID: x1tdomU1O0mgYFQPlN9bFA_1745924237
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-ac28f255a36so412665066b.3
        for <bpf@vger.kernel.org>; Tue, 29 Apr 2025 03:57:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745924237; x=1746529037;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N32jCRGy40LR70yv+XWjgcmG1isI4rJ5byTryD47s3k=;
        b=QAfF6qA8bktOigHamSr60kEpBxInP6W2MzeYZ+URi2ayTBuGDLg26GN2Q6Lvx2SkOB
         ue1fGxQtNDPkVdWnbimhFjhY9SAysieZVlhdo/Rm1o/GNb3tfAySUeB/GXbQxmD3M+99
         /OeYZnzXQciCe9kcEICEb43iD01WMc1CSKr2cHE/IOgKbcbYTjZHimRaqbuNVixUjyuR
         X+cftdTOFpVVA+AA/yMNDjt7fh0gRN7Lb5vjQBPU+WM2LG4ibfXnuNWuKFVdYwAooklQ
         RX2/K+992KHbCGALNWz/8GKwrZYA3V5ITfhkd7BfvjfBiMS4lY27A0FlruzjwkYOXFzn
         k2RA==
X-Forwarded-Encrypted: i=1; AJvYcCUKQy/XhaMnVrlujD0GRXZcZTONvzkgBtnmN9awG6qVDTdOCELEiBBGtyZZ+YjI9ssSnK0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxbXfyD05b5VelZL5wHeGwImFCIzCSfCT6c7lb0M5ObAEC58ve
	MYEtJY+LDKog65h9G1FuyfVLFEAlZAS7oqxrnZlcyEJ3cxVnSwAIoKOuJPUYFfLPb9TDYWWZ4ys
	mTn8A1gYM2ZhQrXC1wblSAdcjwvxLmsTCl71yiWAEZityeKWFtc0S3La54qfL
X-Gm-Gg: ASbGncsjUxq+bvkoR4lCsAvDxniEk7lySy2FEtJ46r0KTcsTFU1IFJoMQw5yOl0eI+s
	oWHWGGMY5tbJGejufXpp1B6arbUzsrYTWkNXTV8lZN2cYBwwQjWg7E5D2ZWb7zAOsYFepTX9sPF
	0c2a1V1hWxmc1g2EV2HAdta79zS/8L7zdd/EEeHAISOoSNFCOfBIOKHnGnfXW+99SDRvBRJYM+/
	kgOEHqu29HmlrU255XOR88mTblYzeIXyCFQnKVX96FgQRLp4v3K2bgSrfIQE2qq3DVoQHiKdjkN
	9fmYFaiYbWAl6UR2UYrKCHnVNbWwTHnLZT+JUTimAIy16ZYtt3NtRB6BpLU=
X-Received: by 2002:a17:907:2da3:b0:ace:3643:1959 with SMTP id a640c23a62f3a-acec4b404d3mr314486066b.7.1745924237093;
        Tue, 29 Apr 2025 03:57:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH/jnW581mQ3SHUDuxVAhF02Euf5vxmHyY7s5LblelgJiI21k8fqSpEuo/N+KjPdIUHg6RjQQ==
X-Received: by 2002:a17:907:2da3:b0:ace:3643:1959 with SMTP id a640c23a62f3a-acec4b404d3mr314483466b.7.1745924236627;
        Tue, 29 Apr 2025 03:57:16 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2726:1910:4ca0:1e29:d7a3:b897? ([2a0d:3344:2726:1910:4ca0:1e29:d7a3:b897])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acec3d78514sm137841166b.131.2025.04.29.03.57.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Apr 2025 03:57:16 -0700 (PDT)
Message-ID: <2067a9f7-eba4-476d-a095-3d6301e14830@redhat.com>
Date: Tue, 29 Apr 2025 12:57:13 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 net-next 07/15] tcp: allow embedding leftover into
 option padding
To: chia-yu.chang@nokia-bell-labs.com, horms@kernel.org, dsahern@kernel.org,
 kuniyu@amazon.com, bpf@vger.kernel.org, netdev@vger.kernel.org,
 dave.taht@gmail.com, jhs@mojatatu.com, kuba@kernel.org,
 stephen@networkplumber.org, xiyou.wangcong@gmail.com, jiri@resnulli.us,
 davem@davemloft.net, edumazet@google.com, andrew+netdev@lunn.ch,
 donald.hunter@gmail.com, ast@fiberby.net, liuhangbin@gmail.com,
 shuah@kernel.org, linux-kselftest@vger.kernel.org, ij@kernel.org,
 ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com,
 g.white@cablelabs.com, ingemar.s.johansson@ericsson.com,
 mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at,
 Jason_Livingood@comcast.com, vidhi_goel@apple.com
References: <20250422153602.54787-1-chia-yu.chang@nokia-bell-labs.com>
 <20250422153602.54787-8-chia-yu.chang@nokia-bell-labs.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250422153602.54787-8-chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/22/25 5:35 PM, chia-yu.chang@nokia-bell-labs.com wrote:
> @@ -709,6 +709,8 @@ static __be32 *process_tcp_ao_options(struct tcp_sock *tp,
>  	return ptr;
>  }
>  
> +#define NOP_LEFTOVER	((TCPOPT_NOP << 8) | TCPOPT_NOP)
> +
>  /* Write previously computed TCP options to the packet.
>   *
>   * Beware: Something in the Internet is very sensitive to the ordering of
> @@ -727,8 +729,10 @@ static void tcp_options_write(struct tcphdr *th, struct tcp_sock *tp,
>  			      struct tcp_out_options *opts,
>  			      struct tcp_key *key)
>  {
> +	u16 leftover_bytes = NOP_LEFTOVER;      /* replace next NOPs if avail */
>  	__be32 *ptr = (__be32 *)(th + 1);
>  	u16 options = opts->options;	/* mungable copy */
> +	int leftover_size = 2;
>  
>  	if (tcp_key_is_md5(key)) {
>  		*ptr++ = htonl((TCPOPT_NOP << 24) | (TCPOPT_NOP << 16) |
> @@ -763,17 +767,22 @@ static void tcp_options_write(struct tcphdr *th, struct tcp_sock *tp,
>  	}
>  
>  	if (unlikely(OPTION_SACK_ADVERTISE & options)) {
> -		*ptr++ = htonl((TCPOPT_NOP << 24) |
> -			       (TCPOPT_NOP << 16) |
> +		*ptr++ = htonl((leftover_bytes << 16) |
>  			       (TCPOPT_SACK_PERM << 8) |
>  			       TCPOLEN_SACK_PERM);
> +		leftover_bytes = NOP_LEFTOVER;

Why? isn't leftover_bytes already == NOP_LEFTOVER?

>  	}
>  
>  	if (unlikely(OPTION_WSCALE & options)) {
> -		*ptr++ = htonl((TCPOPT_NOP << 24) |
> +		u8 highbyte = TCPOPT_NOP;
> +
> +		if (unlikely(leftover_size == 1))

How can the above conditional be true?

> +			highbyte = leftover_bytes >> 8;
> +		*ptr++ = htonl((highbyte << 24) |
>  			       (TCPOPT_WINDOW << 16) |
>  			       (TCPOLEN_WINDOW << 8) |
>  			       opts->ws);
> +		leftover_bytes = NOP_LEFTOVER;

Why? isn't leftover_bytes already == NOP_LEFTOVER?

>  	}
>  
>  	if (unlikely(opts->num_sack_blocks)) {
> @@ -781,8 +790,7 @@ static void tcp_options_write(struct tcphdr *th, struct tcp_sock *tp,
>  			tp->duplicate_sack : tp->selective_acks;
>  		int this_sack;
>  
> -		*ptr++ = htonl((TCPOPT_NOP  << 24) |
> -			       (TCPOPT_NOP  << 16) |
> +		*ptr++ = htonl((leftover_bytes << 16) |
>  			       (TCPOPT_SACK <<  8) |
>  			       (TCPOLEN_SACK_BASE + (opts->num_sack_blocks *
>  						     TCPOLEN_SACK_PERBLOCK)));
> @@ -794,6 +802,10 @@ static void tcp_options_write(struct tcphdr *th, struct tcp_sock *tp,
>  		}
>  
>  		tp->rx_opt.dsack = 0;
> +	} else if (unlikely(leftover_bytes != NOP_LEFTOVER)) {

I really feel like I'm missing some code chunk, but I don't see any
possible value for leftover_bytes other than NOP_LEFTOVER

/P


