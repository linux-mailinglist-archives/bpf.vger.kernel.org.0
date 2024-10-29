Return-Path: <bpf+bounces-43378-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1AF89B487F
	for <lists+bpf@lfdr.de>; Tue, 29 Oct 2024 12:44:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BA931C2254E
	for <lists+bpf@lfdr.de>; Tue, 29 Oct 2024 11:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED154205AB1;
	Tue, 29 Oct 2024 11:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U+Q44E5f"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34AE47464
	for <bpf@vger.kernel.org>; Tue, 29 Oct 2024 11:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730202232; cv=none; b=DvYdi7/T9RqYkh6fC+A55uTNg81PR61jbnVxxVtDP3c4BI5wrE2QotPf3+jGxv0m0CdFhxevy5c8lMTmggMRvbGXM/v8TzEGQkZuK8eNm8lgdqCWQcIa8P2I+V1hJbnJYDleMUjql3RbwDkC1oIa4YZWy4MqFuhNIvgFiU3bc3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730202232; c=relaxed/simple;
	bh=7FX9hMEDd5CqCVYuT+kD+DXzUW/O7JDLJkDmhIU/WHU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=WQj5qZ+EDx/rF2fmcq4LDaAKHYUZCwyWzD8vxboxRdPOShtApI/TWfR1i3wQQQhI2zA2Dtb+rX5zpQ2OaHKL9jyUoP3AuhKVrV4hae3ePa0Z6Ry1FmdZFyXFyt2akfG9ZB6Jt619i+pSSxvtnxxZPNmP3DaEfqzXzq1gozRBldk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U+Q44E5f; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730202228;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rX6BijrrS2O7d2gB4josGNcaJMKvlHXTG8s2SjPX2ww=;
	b=U+Q44E5fu71egbiogvIDhW8wzErmJcTeasuzPIVsZBlNnvi/3cYOCPvODWlr5iC9O4zdzT
	avJZJF1glnkQGpEMLjKYt2Oc5r3MiIgjZ9yBkl2MnM8cZBVog3vYZEGn/tqaAiv9QX0JpE
	5Iz7y5pv75zjqoKwshU0SlFOFixurf4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-pj65KFM-OamHJwm7AHvYSw-1; Tue, 29 Oct 2024 07:43:46 -0400
X-MC-Unique: pj65KFM-OamHJwm7AHvYSw-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-37d504759d0so3517632f8f.0
        for <bpf@vger.kernel.org>; Tue, 29 Oct 2024 04:43:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730202226; x=1730807026;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rX6BijrrS2O7d2gB4josGNcaJMKvlHXTG8s2SjPX2ww=;
        b=WK0BA9wUQuGRmpFJg2+7DLjmsIPYfJhNnHa2Y8y/IJBio7T1zrltk7+QQTIG6J5UBO
         3CJ7WbJJnWnrtGT2xTRBlcMGK3bU3+OMQ3UDtTGatld1Bct6yEGleXBltwBJEWvHKrPA
         pjlWQ7eYGafVNXpGzFzlHu+UDreU4Z1TXpPadRETt/BSDgD6Fe4bRkgDAVbI9VxRfcHe
         uhDbyq7Njo/tjdPokehQ00R25a0tzUG4Bxoxp9ox7WYIjDI+Uc7gDheRjT+lf8b5/GKg
         3MynolgEaMTFF6o1qi8840QIK6l55JLa2f7IwFhq+NwX+MXhUlxs8WZAtUTYNce2ejMW
         w3wg==
X-Forwarded-Encrypted: i=1; AJvYcCVP/Q9nf/ahG6fIxUa4xaFdvFNZk1mfrOxwgZfm2ufkXae0M8Rl1gM9aj4BZ0vFogBjtmM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRFUjzKV/XljI3PpA3RgIjFmVYQZmNP1Z4Hzm30SrlfwIa2hqS
	9SZRbC8JgwKjGEkL7+4AckLOvLPngJwkLttz3h1WP4J4InWH1De0uC2E3RjnwZxTl7KxNMooGed
	V9ecudMN17E9VLWYocScICi+Fg8QrkUPMbe7t2ffFqQhUnGxZPA==
X-Received: by 2002:a5d:5508:0:b0:37d:51b7:5e08 with SMTP id ffacd0b85a97d-3806117ea93mr9838389f8f.18.1730202225722;
        Tue, 29 Oct 2024 04:43:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFUW11sieopiskBwtqbuDoiZfsz0mhE/TMdfvrLaJCplcw4NptzH3dwCL5GU49qWJwSmFO3vA==
X-Received: by 2002:a5d:5508:0:b0:37d:51b7:5e08 with SMTP id ffacd0b85a97d-3806117ea93mr9838354f8f.18.1730202225285;
        Tue, 29 Oct 2024 04:43:45 -0700 (PDT)
Received: from [192.168.88.248] (146-241-44-112.dyn.eolo.it. [146.241.44.112])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b6f838sm12286162f8f.83.2024.10.29.04.43.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Oct 2024 04:43:44 -0700 (PDT)
Message-ID: <3f194c95-5633-42c2-802a-9a04b4a33a8c@redhat.com>
Date: Tue, 29 Oct 2024 12:43:42 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 net-next 04/14] tcp: extend TCP flags to allow AE
 bit/ACE field
To: chia-yu.chang@nokia-bell-labs.com, netdev@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 dsahern@kernel.org, netfilter-devel@vger.kernel.org, kadlec@netfilter.org,
 coreteam@netfilter.org, pablo@netfilter.org, bpf@vger.kernel.org,
 joel.granados@kernel.org, linux-fsdevel@vger.kernel.org, kees@kernel.org,
 mcgrof@kernel.org, ij@kernel.org, ncardwell@google.com,
 koen.de_schepper@nokia-bell-labs.com, g.white@CableLabs.com,
 ingemar.s.johansson@ericsson.com, mirja.kuehlewind@ericsson.com,
 cheshire@apple.com, rs.ietf@gmx.at, Jason_Livingood@comcast.com,
 vidhi_goel@apple.com
References: <20241021215910.59767-1-chia-yu.chang@nokia-bell-labs.com>
 <20241021215910.59767-5-chia-yu.chang@nokia-bell-labs.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241021215910.59767-5-chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/21/24 23:59, chia-yu.chang@nokia-bell-labs.com wrote:
> diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
> index 9d3dd101ea71..9fe314a59240 100644
> --- a/net/ipv4/tcp_ipv4.c
> +++ b/net/ipv4/tcp_ipv4.c
> @@ -2162,7 +2162,8 @@ static void tcp_v4_fill_cb(struct sk_buff *skb, const struct iphdr *iph,
>  	TCP_SKB_CB(skb)->end_seq = (TCP_SKB_CB(skb)->seq + th->syn + th->fin +
>  				    skb->len - th->doff * 4);
>  	TCP_SKB_CB(skb)->ack_seq = ntohl(th->ack_seq);
> -	TCP_SKB_CB(skb)->tcp_flags = tcp_flag_byte(th);
> +	TCP_SKB_CB(skb)->tcp_flags = ntohs(*(__be16 *)&tcp_flag_word(th)) &
> +				     TCPHDR_FLAGS_MASK;

As you access the same 2 bytes even later.

>  	TCP_SKB_CB(skb)->ip_dsfield = ipv4_get_dsfield(iph);
>  	TCP_SKB_CB(skb)->sacked	 = 0;
>  	TCP_SKB_CB(skb)->has_rxtstamp =

[...]
> @@ -1604,7 +1604,7 @@ int tcp_fragment(struct sock *sk, enum tcp_queue tcp_queue,
>  	int old_factor;
>  	long limit;
>  	int nlen;
> -	u8 flags;
> +	u16 flags;

Minor nit: please respect the reverse x-mas tree order

Cheers,

Paolo


