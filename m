Return-Path: <bpf+bounces-58533-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8650AABD36B
	for <lists+bpf@lfdr.de>; Tue, 20 May 2025 11:31:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 114B03A5629
	for <lists+bpf@lfdr.de>; Tue, 20 May 2025 09:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC902217716;
	Tue, 20 May 2025 09:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X+Ou/bsE"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B68CD21A424
	for <bpf@vger.kernel.org>; Tue, 20 May 2025 09:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747733481; cv=none; b=SCuwkLe5/Kb5NiWg7HyoQj2OEjFgzvRSxHQ16bS5i4Vu7w2HKZRvzu3LZITGCZJFytdX8vsaY03OtCKVxKULgMvh5/kOoXCsJ/5XZi9/QM0PwVdySRDgoYW5oJJj6C21P5GTVxnudyJ0ke3ZWHw2plCE6/Ge+M4m1WfXDnxgj/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747733481; c=relaxed/simple;
	bh=X4ok8YWlCa7NGxVftNYeJ9eQIINlz6rFsiv1H6pjxGM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Kteq9QT9fQmlBxlWB+nbjsidbPAkjWiaP0jPICJOKqeMKCWSoD5Uk80+AuIz9e/5neL59Md0MtdHFBws1H/Ck65E1R6slB9UjE7JjiCIoIlgOAZdEm4LkXyyrHSGk+l6VAYZ8VVEeEDGI65cuchpF1w3rLLASBPMucJevwlABdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X+Ou/bsE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747733478;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BH9OP+o2aosKCxR2zDdWoBLjtsANkzrb4fGM5IDyvdA=;
	b=X+Ou/bsEWPBEqmmNy6ECUhpNIzAlDaQaKYlvOlz3a++8I8TOipUPZrf3GKG3VwzKKBOALX
	7luMnAatWNcXrdqHJ3FyMPfocRNV4lfPpAEeqlDuhqKOlLnTWDfng/X6bmPahmc8b++DBf
	faVnILyFOEHfuxFwEgbht7Nx5I7nH3w=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-269-8iEOs1OCMvaz6AUUECWlzQ-1; Tue, 20 May 2025 05:31:17 -0400
X-MC-Unique: 8iEOs1OCMvaz6AUUECWlzQ-1
X-Mimecast-MFC-AGG-ID: 8iEOs1OCMvaz6AUUECWlzQ_1747733476
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43d4d15058dso10497025e9.0
        for <bpf@vger.kernel.org>; Tue, 20 May 2025 02:31:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747733476; x=1748338276;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BH9OP+o2aosKCxR2zDdWoBLjtsANkzrb4fGM5IDyvdA=;
        b=ph6G1X2Ym7IgY7FS2/izQEuymztUjnlmWrLerhs4+FyUbNroWOs1aXerRfpElRDRF2
         m/9sJ/tXH5Y7SKv+T1NsA2MrLjbKfYdbQ9Pc1oJcdn1YpjuMioSw1ZJvXZbXkRmIN+qC
         6JRvWrGU6ynd9FJrunph8ynDH3nGXiuuUr2nyYWbydxJW1NyY/tWVKfCVdooks2B0Ubj
         LjLdQSbzyWdXkQpa5b9KyfHXGuvxT+LIbDd4xSLM32Y4APSrY4zlGBaQLZtC95TyHMQE
         aixxaW/I/P+e40yBJpeTrVEY9lHRWaDHgJX1T12QkkI8bYae39VVMrCiqKiwRyikYT23
         2avQ==
X-Forwarded-Encrypted: i=1; AJvYcCXqcPois6xoRWyG4/+bihLpG7KzVuje0sW9d5CtXMd+6lKEIffkhBg7ILtJQEZM/AO4jwY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMgA0W99iqY5IUpSR09nM9tJSJoiLVZt4M53IDS6VXO0ceE5+2
	dRSlYmJHweCPJu6pGWN/QacO0EgW3rM1RaEkPolL6PTIArA9o4Ye9HlWhyMTHLsfaC1yE0kQPkB
	EMAo1tRpHkgdmZoJgpDoB2o5rHbbzuTtTy8LrlZfX3gfKfb6xWadbig==
X-Gm-Gg: ASbGnctN2HUSm48/totVs7f3wegJFWV8Fm8J+/xRqXsKIq5KI4SI6SB6FKQCWu1vtjN
	jOAh05BIzLGIgO4snQgYt04ItsVsHmH/boNc4zwU/SV5xpVYm9w+xsu96+Slx1ltTkh8ph+706b
	Uch8fsFvR51M0kI4JBC2J+bhkEEYprtf0ITU7QUWG/lmIWRCbVc22f4/OOnb63F/YloXtpcjApS
	VmbBUnzPRJStCmKUp/QMbyCWyWs+o0dBwdma6CFWh/elM8Hl+9OZXRsDZ6l2xZRaS8bQhcraRPy
	Aszc/jszT5x+2n0RYx3BQ5d54xgYS7o4Fb1H5e/VFc2SpqqnyFik3Qe0snc=
X-Received: by 2002:a05:600c:8288:b0:442:e9ec:4654 with SMTP id 5b1f17b1804b1-442fd6103b3mr143638285e9.8.1747733475869;
        Tue, 20 May 2025 02:31:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH4eTCtqEcb2QJ8yiG7FGm1ZgdHtzNT+qRSAMGaE/4M1xCQYMZ71XVJe2vMw4+geXk/Di2SGA==
X-Received: by 2002:a05:600c:8288:b0:442:e9ec:4654 with SMTP id 5b1f17b1804b1-442fd6103b3mr143637675e9.8.1747733475427;
        Tue, 20 May 2025 02:31:15 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:244f:5710:ef42:9a8d:40c2:f2db? ([2a0d:3344:244f:5710:ef42:9a8d:40c2:f2db])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a35ca6294bsm15986944f8f.51.2025.05.20.02.31.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 May 2025 02:31:14 -0700 (PDT)
Message-ID: <ba1b1b36-cd7f-4b36-9cee-7444c219b4f5@redhat.com>
Date: Tue, 20 May 2025 11:31:12 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 net-next 09/15] tcp: accecn: AccECN option
To: chia-yu.chang@nokia-bell-labs.com, linux-doc@vger.kernel.org,
 corbet@lwn.net, horms@kernel.org, dsahern@kernel.org, kuniyu@amazon.com,
 bpf@vger.kernel.org, netdev@vger.kernel.org, dave.taht@gmail.com,
 jhs@mojatatu.com, kuba@kernel.org, stephen@networkplumber.org,
 xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net,
 edumazet@google.com, andrew+netdev@lunn.ch, donald.hunter@gmail.com,
 ast@fiberby.net, liuhangbin@gmail.com, shuah@kernel.org,
 linux-kselftest@vger.kernel.org, ij@kernel.org, ncardwell@google.com,
 koen.de_schepper@nokia-bell-labs.com, g.white@cablelabs.com,
 ingemar.s.johansson@ericsson.com, mirja.kuehlewind@ericsson.com,
 cheshire@apple.com, rs.ietf@gmx.at, Jason_Livingood@comcast.com,
 vidhi_goel@apple.com
References: <20250514135642.11203-1-chia-yu.chang@nokia-bell-labs.com>
 <20250514135642.11203-10-chia-yu.chang@nokia-bell-labs.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250514135642.11203-10-chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/14/25 3:56 PM, chia-yu.chang@nokia-bell-labs.com wrote:
> This patch uses the existing 1-byte holes in the tcp_sock_write_txrx
> group for new u8 members, but adds a 4-byte hole in tcp_sock_write_rx
> group after the new u32 delivered_ecn_bytes[3] member. Therefore, the
> group size of tcp_sock_write_rx is increased from 96 to 112. 

Note that I'm still concerned by the relevant increase of the cacheline
groups size. My fear is that this change could defeat some/most of the
benefist from the cacheline reorg for all tcp users.

Some additional feedback from Eric and/or Neal more than welcome!

A possible alternative could be placing all the accounting fields
outside of all the fastpath cache groups, i.e. after
__cacheline_group_end(tcp_sock_write_rx)

> @@ -710,6 +713,8 @@ static __be32 *process_tcp_ao_options(struct tcp_sock *tp,
>  	return ptr;
>  }
>  
> +#define NOP_LEFTOVER	((TCPOPT_NOP << 8) | TCPOPT_NOP)
> +
>  /* Write previously computed TCP options to the packet.
>   *
>   * Beware: Something in the Internet is very sensitive to the ordering of
> @@ -728,8 +733,10 @@ static void tcp_options_write(struct tcphdr *th, struct tcp_sock *tp,
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
> @@ -763,18 +770,64 @@ static void tcp_options_write(struct tcphdr *th, struct tcp_sock *tp,
>  		*ptr++ = htonl(opts->tsecr);
>  	}
>  
> +	if (OPTION_ACCECN & options) {
> +		const u8 ect0_idx = INET_ECN_ECT_0 - 1;
> +		const u8 ect1_idx = INET_ECN_ECT_1 - 1;
> +		const u8 ce_idx = INET_ECN_CE - 1;
> +		u32 e0b;
> +		u32 e1b;
> +		u32 ceb;
> +		u8 len;
> +
> +		e0b = opts->ecn_bytes[ect0_idx] + TCP_ACCECN_E0B_INIT_OFFSET;
> +		e1b = opts->ecn_bytes[ect1_idx] + TCP_ACCECN_E1B_INIT_OFFSET;
> +		ceb = opts->ecn_bytes[ce_idx] + TCP_ACCECN_CEB_INIT_OFFSET;
> +		len = TCPOLEN_ACCECN_BASE +
> +		      opts->num_accecn_fields * TCPOLEN_ACCECN_PERFIELD;
> +
> +		if (opts->num_accecn_fields == 2) {
> +			*ptr++ = htonl((TCPOPT_ACCECN1 << 24) | (len << 16) |
> +				       ((e1b >> 8) & 0xffff));
> +			*ptr++ = htonl(((e1b & 0xff) << 24) |
> +				       (ceb & 0xffffff));
> +		} else if (opts->num_accecn_fields == 1) {
> +			*ptr++ = htonl((TCPOPT_ACCECN1 << 24) | (len << 16) |
> +				       ((e1b >> 8) & 0xffff));
> +			leftover_bytes = ((e1b & 0xff) << 8) |
> +					 TCPOPT_NOP;
> +			leftover_size = 1;
> +		} else if (opts->num_accecn_fields == 0) {
> +			leftover_bytes = (TCPOPT_ACCECN1 << 8) | len;
> +			leftover_size = 2;
> +		} else if (opts->num_accecn_fields == 3) {
> +			*ptr++ = htonl((TCPOPT_ACCECN1 << 24) | (len << 16) |
> +				       ((e1b >> 8) & 0xffff));
> +			*ptr++ = htonl(((e1b & 0xff) << 24) |
> +				       (ceb & 0xffffff));
> +			*ptr++ = htonl(((e0b & 0xffffff) << 8) |
> +				       TCPOPT_NOP);
> +		}
> +		if (tp)
> +			tp->accecn_minlen = 0;
> +	}
> +
>  	if (unlikely(OPTION_SACK_ADVERTISE & options)) {
> -		*ptr++ = htonl((TCPOPT_NOP << 24) |
> -			       (TCPOPT_NOP << 16) |
> +		*ptr++ = htonl((leftover_bytes << 16) |
>  			       (TCPOPT_SACK_PERM << 8) |
>  			       TCPOLEN_SACK_PERM);
> +		leftover_bytes = NOP_LEFTOVER;

AFAICS here leftover_size could be == 1. why is not reset to 2?

More importantly this looks quite fragile and error prone. *Possibly*
have a tcp_accecn_write_option() helper that would rewrite the existing
option as needed could be simpler and less impacting for the existing code?

/P


