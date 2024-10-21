Return-Path: <bpf+bounces-42593-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 997639A64C2
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 12:50:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43617B2A813
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 10:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78F751F7091;
	Mon, 21 Oct 2024 10:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B3xA0Bty"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C341F4FD0
	for <bpf@vger.kernel.org>; Mon, 21 Oct 2024 10:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729507017; cv=none; b=QlHb5Dhtnh6Kj/FyVd679TjgR9dAzQzN9frOUEOaiLPnlc+ArcA1T1MIUXCfkl3UQUYLVbo/QpyHyA/qKkoeheUXxxv3GaCkakGRTqhD2kWnnimcPL5g+KtUjidca0zMxFFHTrS986RKVmPi1WAbUd2UQNpzSP2AApE5wSA7M38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729507017; c=relaxed/simple;
	bh=lPEiblptSouibb7WFhNi9rGs9Bb3s7/GT0xRZ4fg4VY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=kuy2MJPcNabo2kNueVn5ktqDu+2KOyQTTxmf/gm3cY7qCRS6iB+khqPh62UjFgb39acNSpashNHbbFnwve4RroBlnzDSKsp7YvIlBPybEouq9Z5ydkjtbHG08LGp6AR8j24dUuzqHJtT+gSWZJ2wbLQz1muBKQNtxnH7qUiEgnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B3xA0Bty; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729507013;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lTSf3YKmAE+ZgWB5bS9KvyFO6sfcn+EvZQhAD8CYTeI=;
	b=B3xA0Bty4elUSvptV+BL6c/6J88UyhHNml9hFRqXhAv3TwdkwBzCLvx+Hk1kn+kSZ+LZHo
	UVIPFJUKrXxDBWsEbecPK6PfPUb+NsMgEIBYxGFQFXKk/i9Rs0xrBtj4INSHwfEXhgsj10
	pLTM1yhmOlHbmtvwZMr3QcOinCbtSiU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-487-vo8yuXfSPKqLanOJ0oH0aQ-1; Mon, 21 Oct 2024 06:36:52 -0400
X-MC-Unique: vo8yuXfSPKqLanOJ0oH0aQ-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4315b7b0c16so30704615e9.1
        for <bpf@vger.kernel.org>; Mon, 21 Oct 2024 03:36:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729507008; x=1730111808;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lTSf3YKmAE+ZgWB5bS9KvyFO6sfcn+EvZQhAD8CYTeI=;
        b=gZZKx0aalj5Q1KVm/2deUJnrZFkO5nJppBDOQXTK9Iq4bCrFDUFcFTmhKw+ReS0MIT
         7UKCxbOeshkb4JY/FgwxMWS0CFHQkaSKyHUdu1lIoqYslV41cMT+3UJhLCdu2UC6k8Xx
         7rwWqvMbeWKNYGypSYBXAX8peor/06IJ9F2ERR/FMSdCUfdyqvKzCUkYE+RcSbM8r2Ym
         vkQjAuF631CUU9Fs5sfAq3DTqak4K3+iX+qZJiEhVLukS2Hn2jpD5t0Yg1tja1oz+Q6X
         abhr+1fwbEBitLo6/kvMmHsV0T+XSNfziWw0mrrNHJceXfNZfT1jL8NKPebfO2eEGOwJ
         9TeQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZ8wJ0+Un/36XOsHmn55UoxSAbw6i+R4j/qn4jOalF4AKklRWRp+Dvq19dBTGDcAXlUYc=@vger.kernel.org
X-Gm-Message-State: AOJu0YylOlfnPzdtPYtK9dO7GF5wGUtql/QYG+YNP/9bc2GL1DPpBA3X
	dVT0eAE9SmMwRf+SNdDx0sE6jzOvG1T1Yv53mgRGIMgxjvZszGQeweAyEg8YU6aztQ0hLfMkxKp
	dWQD7v/dqJwWYQUZKg5qRXF3Yjjp3B/kq7M7xS94leqFtJ2of7A==
X-Received: by 2002:adf:f141:0:b0:37d:4ebe:1647 with SMTP id ffacd0b85a97d-37eb488c4d7mr6627892f8f.49.1729507008010;
        Mon, 21 Oct 2024 03:36:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGr3vKPJxaebwFcXlOBxK2rvLgodp7PKXmmX7JS5OeC9VpYp3nL6jzYBBr/CEoA24nLd9cOZw==
X-Received: by 2002:adf:f141:0:b0:37d:4ebe:1647 with SMTP id ffacd0b85a97d-37eb488c4d7mr6627868f8f.49.1729507007676;
        Mon, 21 Oct 2024 03:36:47 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:1b73:a910::f71? ([2a0d:3344:1b73:a910::f71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0b94356sm3975738f8f.67.2024.10.21.03.36.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Oct 2024 03:36:47 -0700 (PDT)
Message-ID: <c83c58ed-32c4-4d6b-8877-2b6392fcec8f@redhat.com>
Date: Mon, 21 Oct 2024 12:36:45 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 02/10] net: ip: make fib_validate_source()
 return drop reason
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
 <20241015140800.159466-3-dongml2@chinatelecom.cn>
 <71a20e24-10e8-42a8-8509-7e704aff9c5c@redhat.com>
Content-Language: en-US
In-Reply-To: <71a20e24-10e8-42a8-8509-7e704aff9c5c@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/21/24 12:20, Paolo Abeni wrote:
> On 10/15/24 16:07, Menglong Dong wrote:
>> @@ -1785,9 +1785,10 @@ static int __mkroute_input(struct sk_buff *skb, const struct fib_result *res,
>>  		return -EINVAL;
>>  	}
>>  
>> -	err = fib_validate_source(skb, saddr, daddr, dscp, FIB_RES_OIF(*res),
>> -				  in_dev->dev, in_dev, &itag);
>> +	err = __fib_validate_source(skb, saddr, daddr, dscp, FIB_RES_OIF(*res),
>> +				    in_dev->dev, in_dev, &itag);
>>  	if (err < 0) {
>> +		err = -EINVAL;
>>  		ip_handle_martian_source(in_dev->dev, in_dev, skb, daddr,
>>  					 saddr);
> 
> I'm sorry for not noticing this issue before, but must preserve (at
> least) the -EXDEV error code from the unpatched version or RP Filter MIB
> accounting in ip_rcv_finish_core() will be fooled.

Please, ignore this comment. ENOCOFFEE here, sorry.

/P


