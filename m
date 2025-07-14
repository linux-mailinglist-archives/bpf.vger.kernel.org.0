Return-Path: <bpf+bounces-63213-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 375A0B0433F
	for <lists+bpf@lfdr.de>; Mon, 14 Jul 2025 17:17:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1089416C27D
	for <lists+bpf@lfdr.de>; Mon, 14 Jul 2025 15:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F05EF265CBD;
	Mon, 14 Jul 2025 15:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CE/ZsBBm"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06EEC25BEF0
	for <bpf@vger.kernel.org>; Mon, 14 Jul 2025 15:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752505951; cv=none; b=P9G6antX2mEAFCiVm7RTg/Hb+HeWTlZLjRDjPh/m5Ah79JBf0UYpsLnIwrzo59fV96Hifs/f9aHNlQlCgdDP+bAO0t4uGQepB0pnj0ztYyoVVeOI5uksfedqF2Ps82+DkjA4M7Kg2RV6+X7C3hfDjnIuEYEOheSZZGq/3nD0gEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752505951; c=relaxed/simple;
	bh=nUBsyJw1CVVySBdkscf0wKBNx6+3aTki+UmriA4CZ7w=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=G/2WtXT0CDD1cyoVmkalz/InMz3noPpiuKdRcSb/2He6x0uaHcTLynuvR/scI/+j2HGVL+kwoaADNvlgm6lND4/mgCl8N7Zqc2Q629FxSyIkVFYbXgjBF3a0V3oLME0bkOTDSog3c7K81P9OMIN1vmL4/TsoFl4Ih5TFT1sVESI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CE/ZsBBm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752505949;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MByh1M8hBJM6ZO7YZ21H+SItyH0RTixPX6ghJ1VgS10=;
	b=CE/ZsBBmkztiwkM5FOcQnznUuhm4O0ENziOD6M/UoikRqkAZ7zIc21MxBDYcogGeJzlulX
	XO6r3Ffsk3DkJ7JKirNGdujWUwqiZ4kpHZEQXo0dy8IM/Sh6n4WI5+tnoTVB968SAoavSq
	wuRT6eaOz4Z0PNx0f68YAm1N5zT4spo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-137-AtFPR7gLOCSBdPznP7JPOw-1; Mon, 14 Jul 2025 11:12:25 -0400
X-MC-Unique: AtFPR7gLOCSBdPznP7JPOw-1
X-Mimecast-MFC-AGG-ID: AtFPR7gLOCSBdPznP7JPOw_1752505944
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4560b81ff9eso14046885e9.1
        for <bpf@vger.kernel.org>; Mon, 14 Jul 2025 08:12:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752505944; x=1753110744;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MByh1M8hBJM6ZO7YZ21H+SItyH0RTixPX6ghJ1VgS10=;
        b=KvE1+A+d0P1nQEnNA/mMpFJ4CWr2Mmjc5lf9+HJEHg2fBba+Idt/CaPvUeUV4LKNkV
         Gh4CasUuX0J85Tn0MNYY0/UaYqwBi5wvZVIEQ/+YcLSdO311MU6r/+xHa2yNZrmrTXrJ
         6j4RjciR6H7bH92jy73W9QHmQAptm08lW+G5fwzhbVyFrPP8ijnp7tpiLLaKkmnaHHyi
         f+fnNMg74ISKA/S4782bK+RBHT0jA/Lv1pRzoLuGH4fJWLSUHRvbdEQIKkZ1dgqF1RXA
         eAIo0D1mPixsFO2xYJpW3bEtlKw53unjYUi4/pGGMh2osjcgzdYRxbbLcX5tMJciC/jq
         Csow==
X-Forwarded-Encrypted: i=1; AJvYcCXUg3VnY3Y5P17oDWi8GgcA9l3nzn/6nXCzeu8ImgHArO336XiRTDoMsMP3x6jSkpXsPVY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUOMRVoDW8hBN8/BBel6gr7Fz5k5t+V0tRiInvVPsBdi1sDQWi
	xia7oTLrO/glgGCu+8AQcyZsz5ZwqQSG/5G6L2BtdOBECG9JHD5zIGmI8+Z+9r9vNmHnH7umEZ/
	6eDwXG8vsSUI798dZg3YD071jXx5LeB1vRQx54kAQALMIxnOiB4nhvg==
X-Gm-Gg: ASbGncuHNmr6Fq5bwqfE4Zya+HHapx/uEE6zh0/6e+M1ysTwtGthWSbHDdNGlh0l2QU
	Q9G7xfOKMWjoeqDhojmvul6+ZF3vVNfS7sQsLRFDMI1nPFgeGGLGdmJAjVo9hfoAkeWm2j4yCq/
	BRRaG0SbEfrXuMkm2xQn9+Q/Xjptnoq57yxnvTOAJddsQ0RSNfc/Giq+5dp0oLGUeEsppm0Udu6
	17y/cztzTlzs+nq9JPfgaofUMNloq81JAICxFBtVDYSnuboylw5SI3cgg86iQviB3j7xmhiu2Eq
	zjJZyazP9bG52E79Temtyg5A9hmHTPXGkGLGW6tugoA=
X-Received: by 2002:a05:600c:841a:b0:456:1b6b:daaa with SMTP id 5b1f17b1804b1-4561b6bdd3amr38488185e9.29.1752505944253;
        Mon, 14 Jul 2025 08:12:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGI8sx2a/TCHL+bqItM/OhugxGKDQcaU6p5roxACLJIP/WtAGE/GxnvHPR1UMcQFIC+o2xoAQ==
X-Received: by 2002:a05:600c:841a:b0:456:1b6b:daaa with SMTP id 5b1f17b1804b1-4561b6bdd3amr38487625e9.29.1752505943842;
        Mon, 14 Jul 2025 08:12:23 -0700 (PDT)
Received: from [192.168.0.115] ([212.105.155.228])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454cd56d936sm117404425e9.0.2025.07.14.08.12.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jul 2025 08:12:23 -0700 (PDT)
Message-ID: <e3bef5ed-535f-4ce3-9ea4-f6a40df448ff@redhat.com>
Date: Mon, 14 Jul 2025 17:12:20 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 net-next 12/15] tcp: accecn: AccECN option send
 control
To: chia-yu.chang@nokia-bell-labs.com, edumazet@google.com,
 linux-doc@vger.kernel.org, corbet@lwn.net, horms@kernel.org,
 dsahern@kernel.org, kuniyu@amazon.com, bpf@vger.kernel.org,
 netdev@vger.kernel.org, dave.taht@gmail.com, jhs@mojatatu.com,
 kuba@kernel.org, stephen@networkplumber.org, xiyou.wangcong@gmail.com,
 jiri@resnulli.us, davem@davemloft.net, andrew+netdev@lunn.ch,
 donald.hunter@gmail.com, ast@fiberby.net, liuhangbin@gmail.com,
 shuah@kernel.org, linux-kselftest@vger.kernel.org, ij@kernel.org,
 ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com,
 g.white@cablelabs.com, ingemar.s.johansson@ericsson.com,
 mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at,
 Jason_Livingood@comcast.com, vidhi_goel@apple.com
References: <20250704085345.46530-1-chia-yu.chang@nokia-bell-labs.com>
 <20250704085345.46530-13-chia-yu.chang@nokia-bell-labs.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250704085345.46530-13-chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/4/25 10:53 AM, chia-yu.chang@nokia-bell-labs.com wrote:
> @@ -1151,7 +1155,10 @@ static unsigned int tcp_established_options(struct sock *sk, struct sk_buff *skb
>  	}
>  
>  	if (tcp_ecn_mode_accecn(tp) &&
> -	    READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_ecn_option)) {
> +	    READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_ecn_option) &&
> +	    (READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_ecn_option) >= TCP_ACCECN_OPTION_FULL ||
> +	     tp->accecn_opt_demand ||
> +	     tcp_accecn_option_beacon_check(sk))) {
>  		opts->use_synack_ecn_bytes = 0;
>  		size += tcp_options_fit_accecn(opts, tp->accecn_minlen,
>  					       MAX_TCP_OPTION_SPACE - size);

whoops, I almost missed it...

Please call READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_ecn_option) only
once, i.e.:

	if (tcp_ecn_mode_accecn(tp)) {
		int ecn_opt = READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_ecn_option);

		if (ecn_opt && (ecn_opt >= TCP_ACCECN_OPTION_FULL || // ...

/P


