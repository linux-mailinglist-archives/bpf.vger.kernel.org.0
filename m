Return-Path: <bpf+bounces-69371-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4771EB956DB
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 12:28:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EE6519C01A5
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 10:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 652FA31A057;
	Tue, 23 Sep 2025 10:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IpumrUwR"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498A52652A6
	for <bpf@vger.kernel.org>; Tue, 23 Sep 2025 10:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758623319; cv=none; b=KRaWEv9lCZrtKOOd98NAuWGCzYZt/mwAJDfxiWVSw+/TkfDr42bQrGN6eb42RAgstgguoxFYESRMlGeVSGPJ5hNL3Qa3HTTRlxTCYGyUZmoDP3aENnlnXBm6pMARh+ebpZvq5y77ecfpNfSnPlXa26haUFzSuuWyWeqReFt/zN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758623319; c=relaxed/simple;
	bh=qNsWtsZJmHIUb0a54dq/Zk97f1zSUhZRzo0hHxDMUiI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=pbPReD2QQgckZQFHHNr8tJDTuUr9hp4QYN4iKA8MwdoGsieUf7sBprMzXCi6ul0IJfxk8JOVYeg8UhAeCnMHhpo5v9gIGBOF6wTjhb7YNveP3UNR1NMKGut+zQUnx1ZdjzmK62wSUep7NtvM4H/IKAx0KefH8GnWxfHXXfyzYVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IpumrUwR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758623317;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Seufh+9IrU9b2MywM8OU6QN1JILtHD4ZNUvycpU3ucM=;
	b=IpumrUwRT9AL6+WHKEhyAu2B7PRWuD6rGcZamC5W0ldj2ipU3hFXKdEsBVYkQf6/tw4Hun
	pD+pt3rOkAVvYHEINHLQAjzkGN6r2O1ycqiUHcHesYAJSshscGwj3iGgIfhWPVDA/1ofXO
	JceGc74qdJSsWzEvzfXbg8hDacAqoco=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-439-7Yk6KzblNIChe8-u8GyrlQ-1; Tue, 23 Sep 2025 06:28:36 -0400
X-MC-Unique: 7Yk6KzblNIChe8-u8GyrlQ-1
X-Mimecast-MFC-AGG-ID: 7Yk6KzblNIChe8-u8GyrlQ_1758623315
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-45e037fd142so47225415e9.3
        for <bpf@vger.kernel.org>; Tue, 23 Sep 2025 03:28:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758623315; x=1759228115;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Seufh+9IrU9b2MywM8OU6QN1JILtHD4ZNUvycpU3ucM=;
        b=BDbWIa75m4fjxcsRrWWgLM5+j7oAT4jeNiZn5w86b7GuQI0tlH/IZoQpHbJpnW8Aqv
         3LWbhloQ5FS5F+qrNx/ZHIR2t/MNYI0XiUMEAuzv/RzetlvxTsqNlujWmZzu7OvS3QH4
         tQAS40q7IJWdgZ/joZOQnI6HNXiH0hiuLs70ir1RZeAdk0qeCL/j19WVu2BVgdtWrm4i
         Xy93ou6R9HCl1z+On+USIFLuhAuPgJAZniqksDtqd8LJANq2Igg4yvpufQI5WZKJWsDO
         7WscMgv2BcOJQBG/aPEdMZKwLXiyX1twMkYA/hSiovqGFvZ45yLTnjAe4KiKrjc4alUb
         b3aw==
X-Forwarded-Encrypted: i=1; AJvYcCW16CMIWP5d2FhAVoxdaHNl/lI9b6NRwAwsnD9PRrQKEuGm1xK8QoIarsgvG4T+dRc7cqA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjX1YELAmgx5L5q7wwx4i868F/HcM/4g/PEMZCYP9bt26a/JxM
	G8zLtfD7XpnOv0KK3Ea8yIagdIIAvGod1UK7vPyFaNtyFwa2Y5oygXNCOIvsK9SQRAxhQEs7HUV
	69TiUacS/6GkSTrkcJ/Njzp+lhSJyVTPSpFy96V1eCKzw3SNm7XlzRg==
X-Gm-Gg: ASbGnctBWlimNoO1yi7HrNUlrBL6GvX5Q44OKcIk0E+1+udkQv6yUIzt4Pa6bP4FCpA
	eAxeseOiEO6+tmw0sMAb1vQeVTyxzyn6Wf5IAGkbYy1BJTo6k47R2NWLNs0Sy1ExCwP6kluLsEW
	O3D4Nwal8IqOLNC2MgHNLTgGtpj3arEgM/IZK31eQFwMGB4h4bJKENcz2+cvCYvPdSXJGdF7+OR
	UNOMxSMsUqTYF5+tS+AuLO6it4Y5xdtaa6GonQB8kTRrG4ge6NU/2+jZ/c5EEOHDRV4UNxMpvHB
	BNvY3H3hlfhRtQ76j4+mbnLD0yyPRfgHlaGiQ83td6Bg14A/K/FC9e9Xgx2+5RA73TWQ9EFXtzT
	oKKdfaxrQZHhe
X-Received: by 2002:a05:600c:b8d:b0:459:d8c2:80b2 with SMTP id 5b1f17b1804b1-46e1d97d863mr18327035e9.7.1758623314773;
        Tue, 23 Sep 2025 03:28:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHE3y5Q9pntwixp7o35wbEMBOVoDHu4y0TA3ICCB6qjtMzYYpwTI3p/PfMW2g4Dp4vpzjkTQg==
X-Received: by 2002:a05:600c:b8d:b0:459:d8c2:80b2 with SMTP id 5b1f17b1804b1-46e1d97d863mr18326795e9.7.1758623314348;
        Tue, 23 Sep 2025 03:28:34 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-464f0d8a2bfsm247445715e9.2.2025.09.23.03.28.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Sep 2025 03:28:33 -0700 (PDT)
Message-ID: <be76fdc6-79f3-4cea-bcdd-e88138efcb3e@redhat.com>
Date: Tue, 23 Sep 2025 12:28:31 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next 11/14] tcp: accecn: fallback outgoing half
 link to non-AccECN
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
References: <20250918162133.111922-1-chia-yu.chang@nokia-bell-labs.com>
 <20250918162133.111922-12-chia-yu.chang@nokia-bell-labs.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250918162133.111922-12-chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/18/25 6:21 PM, chia-yu.chang@nokia-bell-labs.com wrote:
> diff --git a/include/net/tcp_ecn.h b/include/net/tcp_ecn.h
> index 2256d2efa5ec..8317c3f279c9 100644
> --- a/include/net/tcp_ecn.h
> +++ b/include/net/tcp_ecn.h
> @@ -169,7 +169,10 @@ static inline void tcp_accecn_third_ack(struct sock *sk,
>  	switch (ace) {
>  	case 0x0:
>  		/* Invalid value */
> -		tcp_accecn_fail_mode_set(tp, TCP_ACCECN_ACE_FAIL_RECV);
> +		if (!TCP_SKB_CB(skb)->sacked) {
> +			tcp_accecn_fail_mode_set(tp, TCP_ACCECN_ACE_FAIL_RECV |
> +						     TCP_ACCECN_OPT_FAIL_RECV);
> +		}

Minor nit: brackets are not needed above.

/P


