Return-Path: <bpf+bounces-56950-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 906B3AA0E32
	for <lists+bpf@lfdr.de>; Tue, 29 Apr 2025 16:08:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 698FB460AA8
	for <lists+bpf@lfdr.de>; Tue, 29 Apr 2025 14:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1A5F21129D;
	Tue, 29 Apr 2025 14:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yhe1l6bs"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8FC12D029B
	for <bpf@vger.kernel.org>; Tue, 29 Apr 2025 14:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745935706; cv=none; b=lMDE6T4XoCtptrQtHL9lzSQmMwA9uh8yll2QSwRl5P2ouqzHjgxwxDfTStfEjyg95za1MpU6uTmdW9XF4wJoegKsMwztF4Meqn/wQpLTmHuXSS0W/E/9RQsIXjvSR4SF4xQQBvU3zqUw+jFXpy0m1LW4BQWPVdRtatsueUwVhHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745935706; c=relaxed/simple;
	bh=ha8igNbGM13aMHaHrQdfISRaLlgwfMIsDFvz65727oY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=BvF4HCWxxLvhQzz2yt4InhwuVanKuJotMVqfTo9SpsDEzDgpnL5AWpykvrLKsKUS/VQhnYaNkBO/rZll3Y3vkOpSr/NcsLT53Hiqusfzsu31XkIsNDuNt/y5iCxFvXcBKCpSKT3u5zwQ+OF6u2v2xqk4YTv7CVLwfYn3Nz+/DWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Yhe1l6bs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745935703;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=suG985EOjCX8biycL8J7gZpWEOyx9rBhI4py/TvWT9I=;
	b=Yhe1l6bsLJVx67/hCq56R46OYSquaqWO2FMn98O7361SRUnO+zgc7ZNE8A5ILl8Ry2nZi1
	nZp8e/B2nlHE3kXXZBIBbeFZQzmOxCUi9ho45RhVZr8Wj+ElIjCPGJNEAcrmWLdeG2uXyn
	jLIpVEOQnqrY7fiP5GJD8DY4OWWt67o=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-427-od6UFSsiP0m-EpCyr8OAaQ-1; Tue, 29 Apr 2025 10:08:14 -0400
X-MC-Unique: od6UFSsiP0m-EpCyr8OAaQ-1
X-Mimecast-MFC-AGG-ID: od6UFSsiP0m-EpCyr8OAaQ_1745935693
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-ac3c219371bso469605166b.0
        for <bpf@vger.kernel.org>; Tue, 29 Apr 2025 07:08:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745935692; x=1746540492;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=suG985EOjCX8biycL8J7gZpWEOyx9rBhI4py/TvWT9I=;
        b=F2hRWaF+eJKFLBGmuF/YnAEntiGAr0zM4JqQS1acQh9MTCheA8SGBzlOOC4ltGL6Zu
         Xc+PhaiwfI12PpRUTxYMzqZ921SZQUQgiPohC0DKMNyuVOKFXJt0SGZCQh+OGTHNh3tQ
         AC3R2DWaxSX/OIkVDz1aaSBwa+OI5RYsf+2xDRiHE6kaIXvRQwrx3kEr7MOYGw/nd5Vn
         E23hP4Io7fRgPJew9XbfzWg0ZX+/C9OvwjeIrjFcaPVfDHQTm0aGvgLykDoc7rCrq4dJ
         NxCk1UHk2Mq/ZS+0F6wJCNAZzbTNOonR8hlrImkCpcaAJ1AMIyaeu7GxrL0Sc3AyB1FY
         1qAg==
X-Forwarded-Encrypted: i=1; AJvYcCUPjx3YgB8DG5ke0blhYsmoJaMvgrrlpVVV4irJ8JX9y1PKdYkLkpLcDQG2x+pfgVbEO0g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxewEq2yG6CMJs+sdGoVBZ1y2EUUUgCCwcxLTVdTMuoMEJSMWvT
	8xfgxeOEaO2RPLBfqxG/98DSkydl1CAvzM6EfmOLgF7ojlSATWJPvF0o4VIW1ds+bkI5E3Xf33T
	nrgA0/yufyb0EPtQm7VXYvr+6xjP5OVJJQvKmin43ntm39eXADw==
X-Gm-Gg: ASbGnctl0ywydjGtdKJKZCtKPRkDFAZin719xH5Dr3GPEkY6cd36S5s1+flNS9Ijv3j
	SOxNuq6tw5T5vBJ9ph1cZjU4oKZ6X2hFrrcht1tUHoRbTOU11lJhpESo6XRnanOdGcFH10Vim6L
	n8t4N1P2cw0Mm+qalT7juKT1cMphwPWEtdJ4MAx2d7/gSPHbgwT5r5pdOloRbfTTg4SAAB3Dqcs
	OgMAEddySYaIH3AaCjZoqF2vOme3ltwEqLYDFu8xNp2Kbn6ETRn2nA5bGPozp8rLbyVBwuoWsH3
	HbU0nhcG4jIf/4LCbS4=
X-Received: by 2002:a17:906:264d:b0:ace:d710:a8d1 with SMTP id a640c23a62f3a-aced710ab95mr45808766b.24.1745935692476;
        Tue, 29 Apr 2025 07:08:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE0o5uLI0ku+DTzc9hke4sQ0b5ZTjR+yED75DjtR+K5/25/riwLVDPh0sFesxL/FxQTYulrqQ==
X-Received: by 2002:a17:906:264d:b0:ace:d710:a8d1 with SMTP id a640c23a62f3a-aced710ab95mr45803066b.24.1745935691981;
        Tue, 29 Apr 2025 07:08:11 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2726:1910::f39? ([2a0d:3344:2726:1910::f39])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ace6ed7205dsm777011666b.156.2025.04.29.07.08.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Apr 2025 07:08:11 -0700 (PDT)
Message-ID: <eed29236-f238-46c2-a60d-fbdd3955dc99@redhat.com>
Date: Tue, 29 Apr 2025 16:08:08 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 net-next 11/15] tcp: accecn: AccECN option failure
 handling
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
 <20250422153602.54787-12-chia-yu.chang@nokia-bell-labs.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250422153602.54787-12-chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/22/25 5:35 PM, chia-yu.chang@nokia-bell-labs.com wrote:
> @@ -555,6 +556,30 @@ static void smc_check_reset_syn_req(const struct tcp_sock *oldtp,
>  #endif
>  }
>  
> +u8 tcp_accecn_option_init(const struct sk_buff *skb, u8 opt_offset)
> +{
> +	unsigned char *ptr = skb_transport_header(skb) + opt_offset;
> +	unsigned int optlen = ptr[1] - 2;
> +
> +	WARN_ON_ONCE(ptr[0] != TCPOPT_ACCECN0 && ptr[0] != TCPOPT_ACCECN1);

This warn shoul be dropped, too.

/P


