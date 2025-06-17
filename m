Return-Path: <bpf+bounces-60808-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3115ADC6E2
	for <lists+bpf@lfdr.de>; Tue, 17 Jun 2025 11:44:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC0193AB25C
	for <lists+bpf@lfdr.de>; Tue, 17 Jun 2025 09:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6E282C030A;
	Tue, 17 Jun 2025 09:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AMDuYYoD"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3232BE7D0
	for <bpf@vger.kernel.org>; Tue, 17 Jun 2025 09:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750153469; cv=none; b=A/z6i/Z7mD3jBT/qbatV+p7ibTtjuGiV+Tj0KtQ2xfKjqOKU+W5stp6vefeq2QKoctDJXBcvIzXYnJcCM2vsnOzWxzPzjiDFmB1CZ0ucLoC+o3+xdAnZIhmviKIVWaIdpyCfJa7wR/nsAcVrQCUPEFv3iVTK780FKKA+DEUp1KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750153469; c=relaxed/simple;
	bh=e4uRqKiHK+914gVeOIiVV3X3FcUt9r0rHl937hvIjjo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=aJ0NVT43T8iWDYMfbAqOZTSHJj7WkqwmEuUlCxrhd55ghYbyNeuxUAYFfeTi2w6ddnjynFiOIl06W9/zgYPUtpQlczMpukYO7evQzQHAdufOVjEKD5dTkSC8UsUBQg+nrjqHmiGLpDNZxg80C5r6KeEw110xXvBgDoRA0CBXj8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AMDuYYoD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750153466;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rzL8BCb5z5mTe8AmKnSvyMsKdN+ktV9EKzPlxxLDauM=;
	b=AMDuYYoDWFJKnahySOKC7fu/UovDN6k0UTkmMIPV70HymgS1GDLj29vd9bYslqJnpNaeeq
	ugNe4tn24TZsLlZC23YsVaXKRxP0BRDr+uPRfnQM4BQzco1AtYV369AKkttflG443hF4h1
	4XElNQqDsLX6VB7o8dhARnhOVl2ZiWM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-76-mR1d1-0ENsm6t1UBT0FxJw-1; Tue, 17 Jun 2025 05:44:25 -0400
X-MC-Unique: mR1d1-0ENsm6t1UBT0FxJw-1
X-Mimecast-MFC-AGG-ID: mR1d1-0ENsm6t1UBT0FxJw_1750153464
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3a503f28b09so322980f8f.0
        for <bpf@vger.kernel.org>; Tue, 17 Jun 2025 02:44:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750153464; x=1750758264;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rzL8BCb5z5mTe8AmKnSvyMsKdN+ktV9EKzPlxxLDauM=;
        b=fkTYS5mEqmKYMzFzpOyc6rWjxKulyDJt/5gV8PCuybxwqeHPtW6OTwS5fdnLWw+gws
         7qb5KWGod8r1ZPQruA9e9IUsfP9DgysFwHDRKBtyDOXL8xZyMotdv5LkTZLpIdWlxZ4G
         BaI5Ed2IvbYzohX5z+HGcSUjs2/lF0OJgTMHtx01i9k30JL7csXHii/t49apILj8PPht
         dLz+uqo6D14UexiO1nHBhIz9TEx967VHg8PsgcIwuWstrgYZk8Q6X98H6n4I47ogUdyV
         UQNx3FbfahmnBltIG2CBm6GUE6zAcLVttQJJ/nPGU+y3w4A/zioQIVdyJC8krfqNDk5A
         43pg==
X-Forwarded-Encrypted: i=1; AJvYcCUwnFyfMjliowhByTJbBJlWWdj/wSiNNpGxUpRnyTd5lKrebQlKqvJsJJLcuYL/nqUNybE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRXE9Q6KEvN0xnUBFr4Hf8HtaPez0vms/2nKskcuHN9Hy/SZwk
	3Vb8hjEHa0Rf9iXJIbtKzenmK3K20UwnEoKYtvHsusKCOj0W/EuSWItxB+xBCQIKOluFvRUHzvT
	wXqS/4bLuJmkAspM0QLWk4P3kDZ4inrCAp8tbtVAMuUfQLO7CAfyA6w==
X-Gm-Gg: ASbGncu7fRA8AkNjAGNvHUIcXJ68PZwjAAgP5GXD2YLiT9Bu3rjXd/3oIL19Ukz50KZ
	Owj7GW36eX1tLJJ6hozHsbUnvm9aIZnPxZM5K1rTP/pMahDIshYHNRKy2PY+B5/LbIIaslVFtAJ
	xQ916ybfAp2Nql67DrZiXsipLoX2izBPevzahvOvCNuAV1P2qC72ZCJ1KPQuRzmPtgcOdbhohtn
	V9f4QgkoZY0xs0fsjHwunsIpt6vTUmU0A23LgnVMeEVBAOkETtrevk6d+JyJ2D+h9VZingk9Osz
	AR/gICm3VherE9ZsZQvHJnKPGD21pY4ffNcrS0MQKH3gZqY2VlIpKQbVd7WKc4uTm04oWA==
X-Received: by 2002:a05:6000:4106:b0:3a5:7c5a:8c43 with SMTP id ffacd0b85a97d-3a57c5a8d11mr6597963f8f.11.1750153464163;
        Tue, 17 Jun 2025 02:44:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEKE4/hdGNiZlnyMYBRWFUzYwIsk6LZeUq2PZYEGJVxcoKxTedoN7Csr9UGI1dlan0YwSjvcg==
X-Received: by 2002:a05:6000:4106:b0:3a5:7c5a:8c43 with SMTP id ffacd0b85a97d-3a57c5a8d11mr6597942f8f.11.1750153463754;
        Tue, 17 Jun 2025 02:44:23 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2448:cb10:3ac6:72af:52e3:719a? ([2a0d:3344:2448:cb10:3ac6:72af:52e3:719a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532e13d009sm172188815e9.20.2025.06.17.02.44.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jun 2025 02:44:23 -0700 (PDT)
Message-ID: <558d81d1-3cd0-41f8-87b1-aa7be05f2924@redhat.com>
Date: Tue, 17 Jun 2025 11:44:21 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 net-next 11/15] tcp: accecn: AccECN option failure
 handling
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
References: <20250610125314.18557-1-chia-yu.chang@nokia-bell-labs.com>
 <20250610125314.18557-12-chia-yu.chang@nokia-bell-labs.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250610125314.18557-12-chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/10/25 2:53 PM, chia-yu.chang@nokia-bell-labs.com wrote:
> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> index 3de6641c776e..d7cdc6589a9c 100644
> --- a/net/ipv4/tcp_output.c
> +++ b/net/ipv4/tcp_output.c
> @@ -1087,6 +1087,7 @@ static unsigned int tcp_syn_options(struct sock *sk, struct sk_buff *skb,
>  	/* Simultaneous open SYN/ACK needs AccECN option but not SYN */
>  	if (unlikely((TCP_SKB_CB(skb)->tcp_flags & TCPHDR_ACK) &&
>  		     tcp_ecn_mode_accecn(tp) &&
> +		     inet_csk(sk)->icsk_retransmits < 2 &&
>  		     sock_net(sk)->ipv4.sysctl_tcp_ecn_option &&
>  		     remaining >= TCPOLEN_ACCECN_BASE)) {
>  		u32 saving = tcp_synack_options_combine_saving(opts);

AFAICS here the AccECN option is allowed even on the first retransmit as
opposed of what enforced for synack packets and what stated in the
commit message. Why?

Either code change or code/commit message comment needed.

Thanks,

Paolo


