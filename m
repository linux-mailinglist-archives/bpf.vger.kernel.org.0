Return-Path: <bpf+bounces-56951-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1331AA0E74
	for <lists+bpf@lfdr.de>; Tue, 29 Apr 2025 16:15:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A049A1B6777C
	for <lists+bpf@lfdr.de>; Tue, 29 Apr 2025 14:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5DCD2D92C0;
	Tue, 29 Apr 2025 14:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hVgSMPKM"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 766542D3A6B
	for <bpf@vger.kernel.org>; Tue, 29 Apr 2025 14:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745935911; cv=none; b=AqoaoaM2rC7zxG358T3utEYK3JEIY84nsvl4STLlBL9Vh13ZU2oQI9+Bv5VWb9YGL3raYi4dbfIZ8492EnrCWbcvEhTuKHHSz3MfcqjIaE0WWEL8iKDEZPO1GSa/pftGJMLuruVmzJOPcMEz6N05xn30nrU+ylp5bnQOQOrcJsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745935911; c=relaxed/simple;
	bh=1mWbmMWiBxdmu0mNqZsShlyNxanUeS4D+aqJvaV0WbU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=u8M58AHRiGSXcG7MDG+5W+NZ/V+RzO24/ieizVzwmQbwXBUybArxUi21iHVTB35eAQWeVGgMPO1g6SKJIejTu/Wzc0evDKuO/TaoPVZkLNQ2wfxQuZu01xGKdZ3Yhfkw0SbyAx34Q0bjZ0eC5dDVN2x5PFSvPafSCm4cAziG2nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hVgSMPKM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745935907;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qH12Etv0qHrCzY9jRgjcqc6FKy4BzsqSvbZIKh9RcZE=;
	b=hVgSMPKMbOWrVXVgMIDXH29xsOJ4xnbiWuYdu6QpyMIkmlqQzFRjBnNIZK6tY+st+0gdSN
	JRopU3ohjkGMrDayldGG1Z+X66sZh7UZW5lGdp3PGF1QV689XKmjNwDis/eL6kiicljh4C
	i3sh2rn4PWR8KbaKlFP7H9bYYLBGTGQ=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-204-aD3ZF2b0MMmbmAp25yzV0A-1; Tue, 29 Apr 2025 10:11:45 -0400
X-MC-Unique: aD3ZF2b0MMmbmAp25yzV0A-1
X-Mimecast-MFC-AGG-ID: aD3ZF2b0MMmbmAp25yzV0A_1745935904
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-ac287f28514so502243266b.0
        for <bpf@vger.kernel.org>; Tue, 29 Apr 2025 07:11:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745935904; x=1746540704;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qH12Etv0qHrCzY9jRgjcqc6FKy4BzsqSvbZIKh9RcZE=;
        b=bNmc1qvDCSBn71Jr/TZvuzzEAhrwBKuljte7y0yFR6YMR5adKCwZ57LnPUldZpzX0J
         5zuQV0lHkBkJVno6PcIZ+NMkORGv0mHHoDjTcb5xGDzvWv1+dSjmBzzF7dzqs4Sz0n2I
         xBpo6S2os97AcQ4csatXN4WGPiLpYSPtWy4twFqRJOrDrTwYuACTiJ/phYbfYohnmRx1
         JEWiBYk6edJghIH0TDvcEYRiXP117rvilZAiwnOth7mla0s+XljkQ5sctoTY1TT3F+Y1
         yvRoL+1yHkmZS+Cqe4qMMyHX3GSPIbpQ3wruhjDV1NadKKQNSc899xV1F/07W9S457bs
         Jv8g==
X-Forwarded-Encrypted: i=1; AJvYcCVm3s6duA06wlN6mp4xYKtfT0mUy4/cEHX8+xggfaWhiFZmnQBpDzJdyv+5IC4p4lpbqCQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywc9dih+BO0NIBIcuiIvTpdOSM+dR2zjehJgct22dRsIKT00jNB
	XLU3riFOiI4z6KiyM+gBU7ykkApgzWzWDpvn1+Nro361lY/9xdvmvmTRhXN1O51pbDf1peTzVRT
	xdq9QEaCOP/vcutZfcYiMdeyoutdqVXKq41nC/9DhEIr+TfLjBQ==
X-Gm-Gg: ASbGnctcnYPoGO4rpOhy/yfb0eTl7FMhNGjswC1C4Oj/8BrhEWLOiaaA8k3y+RRoOFv
	dvvohsN8GkxMWWGmJWVvDI5X0PWhwk+jFZXcN3VbW37eAV2VKJKIGdQ6ShTZiJkDNDIagWAaoUQ
	rI2xp0M4F/1GcNgvYxzewdpsDKnMg1Z6a6fnw9BbAtU6ZPjx/TGBaBzNP0KGUQj/CZFS1y7OZMf
	LYMwJt+kFTd3gyI3ajCroiVQFxxWjTaaqLwliX3LSwbJz/BL5cN06CO+N4Iyzk/VoU4foLNcPj+
	n8/YBGBMV2+JsyiylPk=
X-Received: by 2002:a17:907:1c8d:b0:ac7:efed:3ab with SMTP id a640c23a62f3a-ace848f745dmr1220501266b.21.1745935904086;
        Tue, 29 Apr 2025 07:11:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IElghu3EXtiRA0dcWZkvwVQYdf4WKlBfMmqxihycklfFgZq7KTn7jN4RnbqcDK4PsFiTrlCdA==
X-Received: by 2002:a17:907:1c8d:b0:ac7:efed:3ab with SMTP id a640c23a62f3a-ace848f745dmr1220496366b.21.1745935903625;
        Tue, 29 Apr 2025 07:11:43 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2726:1910::f39? ([2a0d:3344:2726:1910::f39])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ace6e58673dsm776276566b.76.2025.04.29.07.11.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Apr 2025 07:11:43 -0700 (PDT)
Message-ID: <298cfc4c-3818-4c6e-9348-4b1aff00e96c@redhat.com>
Date: Tue, 29 Apr 2025 16:11:40 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 net-next 15/15] tcp: try to avoid safer when ACKs are
 thinned
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
 <20250422153602.54787-16-chia-yu.chang@nokia-bell-labs.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250422153602.54787-16-chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 4/22/25 5:36 PM, chia-yu.chang@nokia-bell-labs.com wrote:
> From: Ilpo Järvinen <ij@kernel.org>
> 
> Add newly acked pkts EWMA. When ACK thinning occurs, select
> between safer and unsafe cep delta in AccECN processing based
> on it. If the packets ACKed per ACK tends to be large, don't
> conservatively assume ACE field overflow.
> 
> Signed-off-by: Ilpo Järvinen <ij@kernel.org>
> Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> ---
>  include/linux/tcp.h  |  1 +
>  net/ipv4/tcp.c       |  4 +++-
>  net/ipv4/tcp_input.c | 20 +++++++++++++++++++-
>  3 files changed, 23 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/tcp.h b/include/linux/tcp.h
> index b93bf1785008..99ca0b8435c8 100644
> --- a/include/linux/tcp.h
> +++ b/include/linux/tcp.h
> @@ -315,6 +315,7 @@ struct tcp_sock {
>  		est_ecnfield:2;/* ECN field for AccECN delivered estimates */
>  	u32	app_limited;	/* limited until "delivered" reaches this val */
>  	u64	accecn_opt_tstamp;	/* Last AccECN option sent timestamp */
> +	u16	pkts_acked_ewma;/* Pkts acked EWMA for AccECN cep heuristic */

It looks like this field is accessed only on the RX path and does not
belong to this cacheline group.

/P


