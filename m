Return-Path: <bpf+bounces-69367-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F70B95617
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 12:05:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADC433A009E
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 10:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61ABE13B797;
	Tue, 23 Sep 2025 10:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cBjeFuiB"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71CF627815B
	for <bpf@vger.kernel.org>; Tue, 23 Sep 2025 10:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758621905; cv=none; b=A2Tz/062fnHeApTor5YMAuu1X3mmf70FhGqbxori0ynMTdJH+ZC66Rvp2jK7mhQRqJKIe3vs53jkuu9SgE62brs2mkBhP4+zkcxTR6ep3pmg+Mus/zWlHF0iznBgJnlQPuiQbxgyqpkub/ZQrCWGJLOOKuEQ/yhmv5/5WyzkdkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758621905; c=relaxed/simple;
	bh=ZumSwhxH522m/LliPqf9t5tJA+MJDBIhWI+I852334M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pZA+qkeviucOu/64zz2oP06b4aVtaPY/XaNGVv0tQ3xEWAyVKnLTmIgdHDhP7ceKF7uR9g/fPZUHMSbc1njW0De/or6ZjSM5iyT64rVRHg10n3tITl6NWRMN59wB0j5g6Gcg7UFUVnNfTK8bU6aHzXSdKE8WgJVm28sO7QSHoLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cBjeFuiB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758621903;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8MlXEXY9viVFYgaW7HM7/EGwK4GqnOUp4Wcb/T7Io6s=;
	b=cBjeFuiB4vzqWJcvl4vQiHdmh5o4cU39TslWm0stv4rA7KX11fMcdmGkhTi52rCpPQv1Qd
	/e7vsxq3IZpgqxlXtkujTp65pxk6okXerxDgmdQo3/aPPhEXLZ4KjyUd+qI22jjdVmO3nt
	c7wjS2VlX8VHW+K23iEmvCweMAFIaMc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-66-5hOKX_X7MbWXk13eW45Vkw-1; Tue, 23 Sep 2025 06:05:01 -0400
X-MC-Unique: 5hOKX_X7MbWXk13eW45Vkw-1
X-Mimecast-MFC-AGG-ID: 5hOKX_X7MbWXk13eW45Vkw_1758621900
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-46e1b906bf3so12479425e9.1
        for <bpf@vger.kernel.org>; Tue, 23 Sep 2025 03:05:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758621900; x=1759226700;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8MlXEXY9viVFYgaW7HM7/EGwK4GqnOUp4Wcb/T7Io6s=;
        b=KAZsACInjAsF0cmNtP68BNnyIFxWKikdm914WLQIIWtgiIMfG+IkqSXiPp02ZnvBGe
         O0Qwa4pJVrNeVzX1qXYLgyW6se2JXJrNf9TvW15JStzsDaTNB9oq43I39AerQR3FvFLP
         amlSM+wsToOsSMvXC1PXTE+g5tBgFf0bNiXP8sdekuC76axX7uWApWKyAU75DOB/eSzq
         PZ74kR6QGEsmybOnLQDkuOPnzGVIkHWgK5HFfFzILkdPwH3A5YzssYP69Dqw+EROF5X8
         ojn0Y6HU6X6BgIawzNDl/H1lIRm6qNZG50r8Hb3ZULC/sS7/tXDNR4zzJbtF6IhBpRtZ
         3tQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUNdi/dseVL94SmawyebhKAo5HqfMuXYMA3EOcS0g+/sLMOeprCHagqh4g1Rn4yf7ZcPjg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXhYc0vZWBCTvpo2jt/jM/ETxp3O4qJjwlnoO/mOJEqZxhoF+o
	mjCfOwRVKql94xeZxHq4LIvTJhHpyDRFYQT6yQPGdLCEBf7c4DWiUdBX/CZZnZrP0aybEOQld+5
	ueg97wPP+JX8X0i7WdgA6ZQWgvuZhQ4EX/qm3DdBL3lJyFzDqyOX/sb4u2LwiiQ==
X-Gm-Gg: ASbGnctMwokQjMdSei0fQSXjACEP0rvmdKtxxerK1O7P7RHK9a4IJtkjZCcR6Ywzn0R
	e59TD8q6RcsdiIcp7wOzq7epUPeRJeU7NMCkleUurQibmbXqrSgFQIGjn9it7Ilo95Z4ZEDHvZp
	Uq/JLz7Z5JudW6iZBwmSTAfkxL0yjzxz6EZgKGiDgmUBTwOWfDmUUp2uPmq7dQkaBzZ7wsIfpwe
	4le5XEceCst/UFr7yZGKZ5OP5VTTEs+T1w7L3LSoOH24RYlxDRpHySANY+bKlpG5L9uCXbUcbSr
	VKcV23B9qumFA38Yyc0XVEkS+MGh9bCzpDCrUbv68xpNXRE+Dwlj6r+/huul2oL3unIUwapCT/z
	AeCBOG2fJwlmd
X-Received: by 2002:a05:600c:c8a:b0:46e:978:e231 with SMTP id 5b1f17b1804b1-46e1e0aec9bmr21981655e9.17.1758621899822;
        Tue, 23 Sep 2025 03:04:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHI25GAUzFMzn1I18q3eiplupnGbcDgSnNTWVjo5qrpHHjC0ezlLXo+X0Ba4DizXVJNpGvdsQ==
X-Received: by 2002:a05:600c:c8a:b0:46e:978:e231 with SMTP id 5b1f17b1804b1-46e1e0aec9bmr21981025e9.17.1758621899350;
        Tue, 23 Sep 2025 03:04:59 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-403ec628ff7sm3599419f8f.4.2025.09.23.03.04.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Sep 2025 03:04:58 -0700 (PDT)
Message-ID: <476c5c79-bc37-4c41-865d-d04d1d6974c4@redhat.com>
Date: Tue, 23 Sep 2025 12:04:56 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next 04/14] tcp: L4S ECT(1) identifier and
 NEEDS_ACCECN for CC modules
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
Cc: Olivier Tilmans <olivier.tilmans@nokia.com>
References: <20250918162133.111922-1-chia-yu.chang@nokia-bell-labs.com>
 <20250918162133.111922-5-chia-yu.chang@nokia-bell-labs.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250918162133.111922-5-chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/18/25 6:21 PM, chia-yu.chang@nokia-bell-labs.com wrote:
> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> 
> Two CA module flags are added in this patch. First, a new CA module
> flag (TCP_CONG_NEEDS_ACCECN) defines that the CA expects to negotiate
> AccECN functionality using the ECE, CWR and AE flags in the TCP header.
> The detailed AccECN negotiaotn during the 3WHS can be found in the
> AccECN spec:
>   https://tools.ietf.org/id/draft-ietf-tcpm-accurate-ecn-28.txt
> 
> Second, when ECN is negociated for a TCP flow, it defaults to use
> ECT(0) in the IP header. L4S service, however, needs to se ECT(1).
> This patch enables CA to control whether ECT(0) or ECT(1) should
> be used on a per-segment basis. A new flag (TCP_CONG_WANTS_ECT_1)

I find this description confusing/contradictory with the implementation
where TCP_CONG_WANTS_ECT_1 is actually a mask.


> @@ -1322,6 +1328,18 @@ static inline bool tcp_ca_needs_ecn(const struct sock *sk)
>  	return icsk->icsk_ca_ops->flags & TCP_CONG_NEEDS_ECN;
>  }
>  
> +static inline bool tcp_ca_needs_accecn(const struct sock *sk)
> +{
> +	const struct inet_connection_sock *icsk = inet_csk(sk);
> +
> +	return icsk->icsk_ca_ops->flags & TCP_CONG_NEEDS_ACCECN;
> +}
> +
> +static inline bool tcp_ca_wants_ect_1(const struct sock *sk)
> +{
> +	return inet_csk(sk)->icsk_ca_ops->flags & TCP_CONG_WANTS_ECT_1;

Should the above tests be:

	(inet_csk(sk)->icsk_ca_ops->flags & TCP_CONG_WANTS_ECT_1) ==
TCP_CONG_WANTS_ECT_1

?

Otherwise existing CC with TCP_CONG_NEEDS_ECN will unexpectedly switch
to ECT_1 usage.

[...]
> diff --git a/net/ipv4/tcp_cong.c b/net/ipv4/tcp_cong.c
> index df758adbb445..f9efbcf1d856 100644
> --- a/net/ipv4/tcp_cong.c
> +++ b/net/ipv4/tcp_cong.c
> @@ -227,7 +227,7 @@ void tcp_assign_congestion_control(struct sock *sk)
>  
>  	memset(icsk->icsk_ca_priv, 0, sizeof(icsk->icsk_ca_priv));
>  	if (ca->flags & TCP_CONG_NEEDS_ECN)
> -		INET_ECN_xmit(sk);
> +		__INET_ECN_xmit(sk, tcp_ca_wants_ect_1(sk));

Possibly a new helper for the above statement could be useful

/P


