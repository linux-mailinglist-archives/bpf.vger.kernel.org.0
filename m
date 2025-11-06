Return-Path: <bpf+bounces-73816-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38222C3AB17
	for <lists+bpf@lfdr.de>; Thu, 06 Nov 2025 12:50:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BDF446190E
	for <lists+bpf@lfdr.de>; Thu,  6 Nov 2025 11:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F31130F949;
	Thu,  6 Nov 2025 11:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SNBRTV7C";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="CkXxIvsQ"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3A7284663
	for <bpf@vger.kernel.org>; Thu,  6 Nov 2025 11:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762429134; cv=none; b=HC+ZXHijpvlcyyTY+Amiw3tiE6Qku8edyqBi9O0Z5SgKsVWtEMIdLq86hmn8dgZYrNwf/Whbh2IC8XbtQPcNwlhHEIRpIO9yo0EK1gXNHlgdKd/o/1lq0PuT9EAty2xZEzYrcgDZf2CuvLb6L887IgjvLlAs8fAdSXYK7DE+wQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762429134; c=relaxed/simple;
	bh=1im8cEsSwPU3z1wUcIFZMYr3Hf80GzC/cfDI1HoTkEk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LHYdOm6kNVD6i6v7d4kv96NtQE9dlThHD9+z0JwYMOzb2SaaheNJOnhnW6xLCCeICYl9zWOGwc0uY+PFaJmZfz74IeByTlFEGOqJoZeAd0LP0t1yZhiiFjF+F5u+oPzy/rWVXip027in3MqeLdgSRwPA8T5oyX4ssemdg1VQxqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SNBRTV7C; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=CkXxIvsQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762429132;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qsR7dUNbKYyGm3G2Ypb+Ygd27jeSq0CETiTbO/x2Dv8=;
	b=SNBRTV7Ceum6BIanmmbDHOlNoaUjHzIKV4FZHS8lRR2jq7CwOCzV/BXCsr16QxXDbOVl89
	7Xn48I4IepYJlDgUVfJJtg9dSg4dNhJhw9VSnX9MA8MO/yg4etHwSjG4/cz7c3sWspAeNa
	aMtLnM5asj29ymVPUse1JZfCYE6Es/0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-2AUzU0PzO8O2DY5Dcgugow-1; Thu, 06 Nov 2025 06:38:50 -0500
X-MC-Unique: 2AUzU0PzO8O2DY5Dcgugow-1
X-Mimecast-MFC-AGG-ID: 2AUzU0PzO8O2DY5Dcgugow_1762429130
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-429c5f1e9faso668849f8f.3
        for <bpf@vger.kernel.org>; Thu, 06 Nov 2025 03:38:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762429129; x=1763033929; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qsR7dUNbKYyGm3G2Ypb+Ygd27jeSq0CETiTbO/x2Dv8=;
        b=CkXxIvsQ9x5e8EpPuwTJUCKNVCnZ2f0k0CWy/W+XEw78HvukKVA5U1U+Vu2WTT1awY
         4PyuuIaPZ57C/0apYFhcBfuOwlglqMbXHaEg5ydS5plXaa8X1U9Enus1QQshy/OZ8WA4
         80LfMFXFnkXVq1MJAGVQ4xkoghAXY8Sh3R1Nb0gV3Y566s9cYLaBwUW00z6MMqvNr4Lq
         IMa04RUxTWVhyM5O82G0uQYS18SbVaNLntkj3YCh0LUi6jnhOheaaaj1aO7oEeDjkwH/
         37hxIxYQ8/4Mzcb6EZMb3+v3LKv8KU57Cf/C7HU1Q/PIsuMK15rp2prP2YvW7yiRJiLF
         TaCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762429129; x=1763033929;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qsR7dUNbKYyGm3G2Ypb+Ygd27jeSq0CETiTbO/x2Dv8=;
        b=T/F4/HJJL3vVgk/V8UScLF/08LSJNjbW9yfd//i/i4pxwkMlekU00YZ14W5/G6kdDH
         wFBwi/H03xIVT+kOHC9VKtW87RPnQAMgKGNFcmAr51Qc6Q/orqlKOnlDu1d9Bd3EJUgm
         /pt/lXOIA38iYKqNz5o97YZU+F/DIjdqLI8czPOaRF+OzOa+JTSBA89R2iAJqtxS52L7
         483hND1HFwnep8FaEYOx3lgtLVhM0ZQws4qh4p9Mo0wCtwTsp5i+hJoZDf2XFVK0F6MU
         iJZWsrjTZuHRyo1tFKE42ok9n6Ry++TpdVz7AICpKP+CZxdlECwDs/+8k2e8XfsmGD/U
         287A==
X-Forwarded-Encrypted: i=1; AJvYcCU6qOQogO+AGmhN78OEtWgCM9l8MOl6hEL57bbsGkRiXWlAo/oA32weB6VRbep9Gq+hDMA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxphIEo8EcvcsmUlSIL24cPCKo2PHciqoDBLgquQoSsr4VW17TG
	ldsP5JIacQEbmUOsjobsGUuDNbyKG1SKWcOW6o779rPpIWcurG8PNuF5gwQVGEMTrl+kX7twa1h
	eoeBInbXubMTeCEskZHPxrmITSauhzL3p7YYANJ1rpXY/TC4NyY6siw==
X-Gm-Gg: ASbGncv0ahg0gRHxeERRes7S9i2yk/xSTAlqxG/dywNCtQXVpLDecHCir9wRWsGU8nF
	8MTaijv2kLOGe0fQ24gyC0xgrzNX24JePZg+WmPsnPgYkVLn/BRJyiKaf/redC2novwxmQZmtnM
	ssMMWcZbg4mwVeTCAH8gXHNUyJ2TYVtcHjZ2ft8YibWNAV601y1Gd8xaC7eKj3vHmFg2mplZQ/h
	dq/rxuc2p2o/i+8SquJdenbVcnQ4dEJEGa7msCbEr5cQgsqGjcvY+1675dfsdiS5uRuCvO/A/EP
	5EIYFsNrW06poY8/avm4lD1TqVW+lehM5+FgAnCbLR/Kl/O3CH6WxOrTwlI1NQoDDR2p0+1Qo+i
	vrw==
X-Received: by 2002:a05:600c:3551:b0:475:dd59:d8da with SMTP id 5b1f17b1804b1-4775ce2b673mr68256795e9.40.1762429129523;
        Thu, 06 Nov 2025 03:38:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE7kUvneRaqEvt7Kh1+lSjkJl0uXf/wS14yYzwd3nHIQHFp+DgBSlRyvRM7xPYT467KsqDWCg==
X-Received: by 2002:a05:600c:3551:b0:475:dd59:d8da with SMTP id 5b1f17b1804b1-4775ce2b673mr68256395e9.40.1762429129057;
        Thu, 06 Nov 2025 03:38:49 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.83])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47764152a13sm13759115e9.13.2025.11.06.03.38.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Nov 2025 03:38:48 -0800 (PST)
Message-ID: <bc1ebcd0-c42c-4b59-a37a-13ee214e90a6@redhat.com>
Date: Thu, 6 Nov 2025 12:38:46 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 net-next 05/14] tcp: L4S ECT(1) identifier and
 NEEDS_ACCECN for CC modules
To: chia-yu.chang@nokia-bell-labs.com, edumazet@google.com, parav@nvidia.com,
 linux-doc@vger.kernel.org, corbet@lwn.net, horms@kernel.org,
 dsahern@kernel.org, kuniyu@google.com, bpf@vger.kernel.org,
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
References: <20251030143435.13003-1-chia-yu.chang@nokia-bell-labs.com>
 <20251030143435.13003-6-chia-yu.chang@nokia-bell-labs.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251030143435.13003-6-chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/30/25 3:34 PM, chia-yu.chang@nokia-bell-labs.com wrote:
> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> index 7f5df7a71f62..d475f80b2248 100644
> --- a/net/ipv4/tcp_output.c
> +++ b/net/ipv4/tcp_output.c
> @@ -328,12 +328,17 @@ static void tcp_ecn_send(struct sock *sk, struct sk_buff *skb,
>  			 struct tcphdr *th, int tcp_header_len)
>  {
>  	struct tcp_sock *tp = tcp_sk(sk);
> +	bool ecn_ect_1;
>  
>  	if (!tcp_ecn_mode_any(tp))
>  		return;
>  
> +	ecn_ect_1 = tp->ecn_flags & TCP_ECN_ECT_1;
> +	if (ecn_ect_1 && !tcp_accecn_ace_fail_recv(tp))
> +		__INET_ECN_xmit(sk, true);

I'm possibly lost, but I can't find ecn_flags TCP_ECN_ECT_1 bit being
set here or elsewhere in this series.

Also why isn't this chunk under `if (tcp_ecn_mode_accecn(tp))` ?

/P


