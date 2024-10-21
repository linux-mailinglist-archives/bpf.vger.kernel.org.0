Return-Path: <bpf+bounces-42601-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 999559A654A
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 12:55:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5654E282D34
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 10:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 564481F9403;
	Mon, 21 Oct 2024 10:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OKY6yUX0"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0C81E573B
	for <bpf@vger.kernel.org>; Mon, 21 Oct 2024 10:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729507783; cv=none; b=Jrj/yb72NBlNhL4baBNfMY7hkIzUKotHshmgnrJJ6uyVNl6hYcPII8qsDO9GqqGiJlAH56vQDheo5tFC/y2C89DxsDG2Zs7u9WAoGgKFKORxPRT9yrd+4KAdf84eWRNZviD7EXdQptsUtwGUwNzdJ0A35PQ7XEc2fRFgJB4W0ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729507783; c=relaxed/simple;
	bh=f25VOJ4jl4EZ6U5b3xJzeqopBjiOxy3HcpyoNBkD144=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=t7dvtZ5Hy+tQdqh7YNSmZXUUsoUyWRA5+CUV1g3jXnUSpL9QEkeg/0YKdJwJcE2Iws3C4QM1gC8XrhflSBZ1sFP6rwOKWLXC5a712rLWQR8qctZDmDeDg2cfK3hEH06ePUscFKLmvvAHncVTNkK69KCM3p3MtuIWkcKbP9Xrqy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OKY6yUX0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729507780;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zl8NkxhsjOVprDoWW2Qzq8vxlGshkjvvdBctdUvmGdo=;
	b=OKY6yUX0B7vLNczEYoQU/BU0wEFoV4vB0A3ZnGOIIqcOuQO4qvqC8yPXJNURfDkbzdakM/
	eq3GxMU0sjo82MQI/4MaQWqSmBz/dAn48WOE70/yjVKiihD69K40Xr2HmbLN+dPlSQDOox
	6UmzJQ4i9gcjiHBz2t32UqXEaz3jmJo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-297-rROX9Jp3MCaC78IFuEk6UA-1; Mon, 21 Oct 2024 06:49:39 -0400
X-MC-Unique: rROX9Jp3MCaC78IFuEk6UA-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4315afcae6cso22706435e9.0
        for <bpf@vger.kernel.org>; Mon, 21 Oct 2024 03:49:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729507778; x=1730112578;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zl8NkxhsjOVprDoWW2Qzq8vxlGshkjvvdBctdUvmGdo=;
        b=utaZISPdQ0bibJKUfnjCPQyAkijgiMrVCmMWOmUQ7JwkuuOOHh5zPbD6vttrNg0cFJ
         JArSqI2YOJiItqLLgrCdD++trCvIOH5AujbU4PHU64/cxdepx4p94w4rqcsvy4EFUzC6
         Y5SW3aiOwnoqzKm9QWR3bLqgVB52ADAYO3FHk9swAV3tEm1IcIHJ+7P8862c5FzqKm/c
         0UVtfa9CkkhBUTzEv2QAlBdXeJOL9jUvNs0JjhLRsly5gheqK0+4EZQkUG4Fdn1DJ2Lx
         RqyETH8HiFVg3I8oxIr43nG5d6N+05yhpJMP0T3m5IO1Hv9VHjzluHeTs7jJeI1IgsRg
         fzoA==
X-Forwarded-Encrypted: i=1; AJvYcCVqV7b6Sr794sQfoHirvCxV3wkziRZlUzOai8M6Q3dQ4sXB9jeVKJlRAqEahi9/gSkq0co=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbWrHvDRcm4BIyFkXaydGHYp667r2A+KKhLp9+tHwE48Qlwb6N
	IX2JLoYYGK+MD0bK/4jrm99IrBeCr3K+5ODJQ8uCJf28iRtLZz+b29CZzhQIPEVAUWsFHAWs7Tb
	o21MUE+C9vnwDY7Io7ifknxa5pVuOcdPXrs8qJoN2hKV1JCf/aw==
X-Received: by 2002:a05:600c:1d27:b0:431:44aa:ee2c with SMTP id 5b1f17b1804b1-4316163bb0bmr68211865e9.9.1729507778226;
        Mon, 21 Oct 2024 03:49:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFPmc6ba7ssou9GTOtZg5r3s7a95KOOzPAX+9aC1kAiYD6uc9w3/zs/WO4t3sdTFuEXumAz/A==
X-Received: by 2002:a05:600c:1d27:b0:431:44aa:ee2c with SMTP id 5b1f17b1804b1-4316163bb0bmr68211595e9.9.1729507777852;
        Mon, 21 Oct 2024 03:49:37 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:1b73:a910::f71? ([2a0d:3344:1b73:a910::f71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4316f5c2cb8sm53805945e9.31.2024.10.21.03.49.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Oct 2024 03:49:37 -0700 (PDT)
Message-ID: <f792a828-8a61-4a14-bef8-ff318b5a4ac3@redhat.com>
Date: Mon, 21 Oct 2024 12:49:35 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 07/10] net: ip: make ip_route_input_noref()
 return drop reasons
From: Paolo Abeni <pabeni@redhat.com>
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 dsahern@kernel.org, pablo@netfilter.org, kadlec@netfilter.org,
 roopa@nvidia.com, razor@blackwall.org, gnault@redhat.com,
 bigeasy@linutronix.de, idosch@nvidia.com, ast@kernel.org,
 dongml2@chinatelecom.cn, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org,
 coreteam@netfilter.org, bridge@lists.linux.dev, bpf@vger.kernel.org
References: <20241015140800.159466-1-dongml2@chinatelecom.cn>
 <20241015140800.159466-8-dongml2@chinatelecom.cn>
 <c6e8f053-32bb-4ebd-871b-af416d0b0531@redhat.com>
Content-Language: en-US
In-Reply-To: <c6e8f053-32bb-4ebd-871b-af416d0b0531@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/21/24 12:44, Paolo Abeni wrote:
> On 10/15/24 16:07, Menglong Dong wrote:
>> diff --git a/net/core/lwt_bpf.c b/net/core/lwt_bpf.c
>> index e0ca24a58810..a4652f2a103a 100644
>> --- a/net/core/lwt_bpf.c
>> +++ b/net/core/lwt_bpf.c
>> @@ -98,6 +98,7 @@ static int bpf_lwt_input_reroute(struct sk_buff *skb)
>>  		skb_dst_drop(skb);
>>  		err = ip_route_input_noref(skb, iph->daddr, iph->saddr,
>>  					   ip4h_dscp(iph), dev);
>> +		err = err ? -EINVAL : 0;
> 
> Please introduce and use a drop_reason variable here instead of 'err',
> to make it clear the type conversion.

Or even better, collapse the 2 statements:

		err = ip_route_input_noref(skb, iph->daddr, iph->saddr,
				   ip4h_dscp(iph), dev) ? -EINVAL : 0;

There are other places which could use a similar changes.

Thanks,

Paolo


