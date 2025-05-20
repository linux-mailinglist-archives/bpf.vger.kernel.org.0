Return-Path: <bpf+bounces-58534-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CFBAABD387
	for <lists+bpf@lfdr.de>; Tue, 20 May 2025 11:35:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C04218A60A0
	for <lists+bpf@lfdr.de>; Tue, 20 May 2025 09:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D537268C62;
	Tue, 20 May 2025 09:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LDMQTwDj"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF29268FCA
	for <bpf@vger.kernel.org>; Tue, 20 May 2025 09:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747733676; cv=none; b=NHBuB7qyKrz0fEZlV92FCaD3U6pceExXx4VjC0Bkl67nIdiucjFmeidWPM/fqOIqI2vKp2mUWBaBbisSU+LWmKcgzMQ0gurPIvSgZi89EJqwvE4wFRXvpB8sDrX7VwqeinjHxWDDmc0klAIslbtZ2CVDRLZ6sQTgOMvl9aHszQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747733676; c=relaxed/simple;
	bh=PCd7B2CKJamE+lIGpi1n0g7Z4216i/A7aPBeHZSzo10=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=dMMX/32jvS84RfRkKwY4+6LsmWLy2P/ykZzzVzpwxdeRHtFKGpXJc5oKvXZ60aVOIxn9ht4K6jcl2n7l7V55lFx12sfwxIBJVIWmcwhyyK9Ftzu0dYETRK+Z/mWZa7xyS2xNyBGj+y/YOd64TjOAVeG3FxpHvrVVxKe5I+3m3Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LDMQTwDj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747733674;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2NE/+J7lqNQA/ShV5FIY+NGVs5/A/4r4zhgGDuUCRS4=;
	b=LDMQTwDj8D2c/8DtEonqLfGGvnceTOvcDmpQbDV5m7Jp80QedOQA5zeP/q7CtMS8dbHCPW
	Uf3QzUsI9UqyYTzd9KUI5tiaPSBVlKmxfUEWHqojyGBDwoEK5GZoZna5o3ikSKAZdrQk/A
	5M1zLZDP9DPdp6YOjf0a7LBMUFdLFk0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-160-Q_oAPLi1Mu27NlU8hn2mLg-1; Tue, 20 May 2025 05:34:31 -0400
X-MC-Unique: Q_oAPLi1Mu27NlU8hn2mLg-1
X-Mimecast-MFC-AGG-ID: Q_oAPLi1Mu27NlU8hn2mLg_1747733670
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a376da334dso878541f8f.0
        for <bpf@vger.kernel.org>; Tue, 20 May 2025 02:34:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747733670; x=1748338470;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2NE/+J7lqNQA/ShV5FIY+NGVs5/A/4r4zhgGDuUCRS4=;
        b=usiPrTGg473OfTx7TP4wIRvXjdER7ll/7ceM9d04tRwvHtJWPMsl6RIOsdnoc33q3D
         DzTfODcIYijCN5pFF8DqkMBl3HGY9GPsh9+J6AxwFbldTqJC6joXLvBqL/8Pjhj+4ZYs
         FTYoQVd8R+P7x7QVMNnFzklEko1l8+AsCmQpcDjSMFcYRX5cKQeNO6BRof05w0lLmWz6
         lqhWhlZ23JavEjebECyJ6YI+H9jTlqA5oCntgpkjWfKTJMfoZLSiynt2mAvZ02IcBprl
         HuaWhFUMfZNqMqH67nH6rK1WPEA8aKiu2+cm7PERd5Hkz9FvpRK1UZJuasQ4xJanP4NM
         HZcQ==
X-Forwarded-Encrypted: i=1; AJvYcCW05GBsoZ5ao5cDL5Hqb442ENePtT5UzlOeTGtwJ3/u2HZH/DZW4Sm3wN211XJn4xzb9gg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLOJIBKK02v6cIzPz2S4eyuo0E8kyZT3sbdZ3ABdAsmbRUiaUP
	hX33HilXBtxOdESkJHLxYMwSGhIFUN5spT9pzxvyIhacVfIgYuhfFjZj0GvlEFtPt3vsHaOhIEw
	Cga5YsoQwljGMujtiSHgECaCnHT9uyQIIlR1x1unHU0wfxSQtwEg7ig==
X-Gm-Gg: ASbGnctVE5xQRcGLFkjAGzQAxssUcjmVUCUl8FMSFmhsPZ5Z1yyfyMMOzsavYsyJf9/
	RyZeOUOSeuthZ2sPqBYvKYSaF67g3mLBKoEUxFHBlrKE5qHJrLFOlA1xP0GpL0bT4zX6fC85jBt
	yjRJdWUxCONrJbajvU9xsQiLqlW94wn3dsGulda6zNNJso6z8qVV3F1gvWfEgBVKYddTR2x5Lc3
	5rq5I7vaBaVl89cFqKQIfHmJTnhYuK2Hdq3b4kzI3Zxf6VYq3+XJT7+P5gyrWx3CaJTFLOGNswU
	QLo90sU+ZfK/dy/8H9nMd/UH2CQLXt4l5Jjb/gWVwOUxLV8GZpTqe0RZf5E=
X-Received: by 2002:a05:6000:1ac8:b0:3a3:6cf3:9d63 with SMTP id ffacd0b85a97d-3a36cf39e6bmr7068873f8f.34.1747733669695;
        Tue, 20 May 2025 02:34:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEuVkjVQJ2eOY0GRr+yrteefyL9sA1r4XDiPPnflkR/rXOi3fp9tCEjol8O9cOiuqNwVG19PQ==
X-Received: by 2002:a05:6000:1ac8:b0:3a3:6cf3:9d63 with SMTP id ffacd0b85a97d-3a36cf39e6bmr7068828f8f.34.1747733669229;
        Tue, 20 May 2025 02:34:29 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:244f:5710:ef42:9a8d:40c2:f2db? ([2a0d:3344:244f:5710:ef42:9a8d:40c2:f2db])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a35ca5a84csm15787427f8f.31.2025.05.20.02.34.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 May 2025 02:34:28 -0700 (PDT)
Message-ID: <14d6af16-c93d-4b38-b748-76c894c0cdf2@redhat.com>
Date: Tue, 20 May 2025 11:34:26 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 net-next 08/15] tcp: sack option handling improvements
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
 <20250514135642.11203-9-chia-yu.chang@nokia-bell-labs.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250514135642.11203-9-chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/14/25 3:56 PM, chia-yu.chang@nokia-bell-labs.com wrote:
> From: Ilpo Järvinen <ij@kernel.org>
> 
> 1) Don't early return when sack doesn't fit. AccECN code will be
>    placed after this fragment so no early returns please.
> 
> 2) Make sure opts->num_sack_blocks is not left undefined. E.g.,
>    tcp_current_mss() does not memset its opts struct to zero.
>    AccECN code checks if SACK option is present and may even
>    alter it to make room for AccECN option when many SACK blocks
>    are present. Thus, num_sack_blocks needs to be always valid.
> 
> Signed-off-by: Ilpo Järvinen <ij@kernel.org>
> Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> ---
>  net/ipv4/tcp_output.c | 23 ++++++++++++-----------
>  1 file changed, 12 insertions(+), 11 deletions(-)
> 
> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> index d0f0fee8335e..d7fef3d2698b 100644
> --- a/net/ipv4/tcp_output.c
> +++ b/net/ipv4/tcp_output.c
> @@ -1092,17 +1092,18 @@ static unsigned int tcp_established_options(struct sock *sk, struct sk_buff *skb
>  	eff_sacks = tp->rx_opt.num_sacks + tp->rx_opt.dsack;
>  	if (unlikely(eff_sacks)) {
>  		const unsigned int remaining = MAX_TCP_OPTION_SPACE - size;
> -		if (unlikely(remaining < TCPOLEN_SACK_BASE_ALIGNED +
> -					 TCPOLEN_SACK_PERBLOCK))
> -			return size;
> -
> -		opts->num_sack_blocks =
> -			min_t(unsigned int, eff_sacks,
> -			      (remaining - TCPOLEN_SACK_BASE_ALIGNED) /
> -			      TCPOLEN_SACK_PERBLOCK);
> -
> -		size += TCPOLEN_SACK_BASE_ALIGNED +
> -			opts->num_sack_blocks * TCPOLEN_SACK_PERBLOCK;
> +		if (likely(remaining >= TCPOLEN_SACK_BASE_ALIGNED +
> +					TCPOLEN_SACK_PERBLOCK)) {
> +			opts->num_sack_blocks =
> +				min_t(unsigned int, eff_sacks,
> +				      (remaining - TCPOLEN_SACK_BASE_ALIGNED) /
> +				      TCPOLEN_SACK_PERBLOCK);
> +
> +			size += TCPOLEN_SACK_BASE_ALIGNED +
> +				opts->num_sack_blocks * TCPOLEN_SACK_PERBLOCK;
> +		}
> +	} else {
> +		opts->num_sack_blocks = 0;
>  	}

AFAICS here opts->num_sack_blocks is still uninitialized when:

    eff_acks != 0 &&
    remaining < (TCPOLEN_SACK_BASE_ALIGNED + TCPOLEN_SACK_PERBLOCK)

/P


