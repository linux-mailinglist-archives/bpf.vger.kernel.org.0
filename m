Return-Path: <bpf+bounces-55210-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FF31A79DB2
	for <lists+bpf@lfdr.de>; Thu,  3 Apr 2025 10:11:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65C291897847
	for <lists+bpf@lfdr.de>; Thu,  3 Apr 2025 08:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B92EC24169E;
	Thu,  3 Apr 2025 08:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E5nNnpmV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63B0241691;
	Thu,  3 Apr 2025 08:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743667866; cv=none; b=d2YtwO+Jl2d2OAJpwApFCxbMnQao1QXnAXaLrAn9NVcRkqnttsDhS6B1bBq4WjiGDn0AT08plPFYal4rt+Hk+lKpVIp0k37LFx2Kk52ya1EXr2TsT7SSBy0RI3bnsgME8oqImJPzqkmyZ2GSZ/sPSoxKJMwgVCWrYeJnhZlb9aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743667866; c=relaxed/simple;
	bh=2R7xbK2zYAifCYk+bxYA2fYSAJkn/8z0fvehWJ4nvyw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=icC/9pnoy0DiZz0OFhiTR49VG/MkEWh3gs+tBkftEZbcFdnuY8MpirWNRNMe2pPKmqTZJJG9xbNF+qaqZFOO9Tg2xq2w78g2fgF0YfCoW4Uik4MtxvO5nqefaxjLdM5Jgyz279sCuWuXsBwUyJmcW+9y8zJKFvboYoYUcwyY/Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E5nNnpmV; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-225df540edcso23004335ad.0;
        Thu, 03 Apr 2025 01:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743667864; x=1744272664; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iUzFKSfu3nO5CAOYlZxLMd314d5zWCMqkdsMAHHXslE=;
        b=E5nNnpmVli3mgdfUexiyX10YTzOlH4nyWL39mpeHWkAUNXsTa/ldqhVJR0eVGNtVBj
         +0s7YScBhkQ+WaAj4s7q0TzEMpu4GMB5n4qd63XJ2xPpwqp8TeUFnpm3MtGJFTXKx/pN
         bTWlNRzGpxPEl6fJSuwioYPl74cSjJe81xhfQYwCWewt0GonHER77dE8SkpGixd4HC84
         6Sef2Foa35uZpvjBcX6mRmDlF+pPTlF5UTchOPBEJJbnod3nQmebwFAZDF/+ToJM22wc
         6rLbwSR7GxZhO/EcN+invekG4TDpTSp3qTsU2waZPNrZ45Vik0tGNmDqVg7eqmTZwEN2
         8AkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743667864; x=1744272664;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iUzFKSfu3nO5CAOYlZxLMd314d5zWCMqkdsMAHHXslE=;
        b=N+goa62lXK63uuWD1A+AZq9dUe1119UJLMOF0RUYBmr3yijjpb1fzIFnR+mjuDzKKd
         ysuRZO5PCRsYDzDvfsHzMKOj6GWONkprzRuFkxjJA0HUVdKfKuvF4Xb3JJbiah9Iu9Lb
         seZaU2WjiQWDRiEoaBQs9SPXg1dd8IgcnoMy3RMWh9SRCT+v1rKp+LwLTXeueul656gp
         hypxYVllPNmT9614JW6IkgB7hNNY8N4SQL+zGbc8z5mJt/CWIlfu2XAfzCW7JuwkraiS
         O1mGBuV5kqYmboskvFsCzDvrfAQq7Rl6BapYsLMYMMLJQiO2upCHfb52Gy+EZEdQK2YS
         vy2A==
X-Forwarded-Encrypted: i=1; AJvYcCU9EWkLv53uiQB6hXBzTGBz47Fx8+VqzuJYtDdIX8kbRYR5ncXg9BkbAlp8IH3+f691ELVde7nk@vger.kernel.org, AJvYcCULozVVy0La968Os2me7/uX1OqFAUrbDB+KMXcT+r1UNiVAljlrqZnH+AH1KrPDQc1ewP0v4KjgTuRMKxNb@vger.kernel.org, AJvYcCWRgrFf7NJ0DqikhxvGDEr8+sKZttyKeZnNRtQwBnuyK2XRiMyyCo6lKSfRy/re5Z0K2DM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYNbWJor99PcUYZQJzJ1vU5aAP8mmZPJ0dANTH6ikRvN8jTmBE
	hwPTYy0flitYnKsgO2ydlX60FVo6RLb75NP//sj4++4axDa4E6o/
X-Gm-Gg: ASbGncsh0gxva4Nfhws577wxen4/kibq1zIjtRdAQEGxT6mTjGH3YOyBe7z8t0aZ+oC
	sfcN6AiD+rLJcb2YAd+llYN2jhKNDzJ9e9fm1x/BdN1/LsXiEl16zkLoiXkwm2k5ekhfpB78sDu
	3MBdhGvt6PqOUBdW4FIGI7AMe4eIKbPMaepIhT9WZChsFlKgZSj5qLfT+u7Dt/aGz265zMwf7QN
	73fLx8ePtjbNMpm1yrQ+lYe2bhUQZATajW0U3Fa9e3yLqxRAixNqHOXE/fplOgUUJOcsAAk/RrS
	WJmkDpnIIFvDU/bXIbL2C8m01lLv/koXuRhEzk4H/cIhooBfg2VPraALYmaV2G42F1Vfv2e1uQe
	18bUj6joDlm63oFMmdyVikLo=
X-Google-Smtp-Source: AGHT+IF4eQzBfv+ODf73ZPw7KCMX4BruvGE2f4o7JP7Bv1oXNuTH3a7SodgEPjBCqKICofhoR7aC0A==
X-Received: by 2002:a17:902:820d:b0:21f:40de:ae4e with SMTP id d9443c01a7336-229765ce2bdmr28438375ad.9.1743667863970;
        Thu, 03 Apr 2025 01:11:03 -0700 (PDT)
Received: from ?IPV6:2001:ee0:4f4e:bd30:1c8a:9f9b:3aa6:dc25? ([2001:ee0:4f4e:bd30:1c8a:9f9b:3aa6:dc25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-229785ad0d6sm8658415ad.22.2025.04.03.01.10.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Apr 2025 01:11:03 -0700 (PDT)
Message-ID: <653b71a4-99a5-49d4-b927-fe2bf5890896@gmail.com>
Date: Thu, 3 Apr 2025 15:10:57 +0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] virtio-net: disable delayed refill when setting up xdp
To: Paolo Abeni <pabeni@redhat.com>, virtualization@lists.linux.dev
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
References: <20250402054210.67623-1-minhquangbui99@gmail.com>
 <4b3bea7c-110d-48eb-bcf6-58f4b2cd1999@redhat.com>
Content-Language: en-US
From: Bui Quang Minh <minhquangbui99@gmail.com>
In-Reply-To: <4b3bea7c-110d-48eb-bcf6-58f4b2cd1999@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/3/25 14:24, Paolo Abeni wrote:
> On 4/2/25 7:42 AM, Bui Quang Minh wrote:
>> When setting up XDP for a running interface, we call napi_disable() on
>> the receive queue's napi. In delayed refill_work, it also calls
>> napi_disable() on the receive queue's napi. This can leads to deadlock
>> when napi_disable() is called on an already disabled napi. This commit
>> fixes this by disabling future and cancelling all inflight delayed
>> refill works before calling napi_disabled() in virtnet_xdp_set.
>>
>> Fixes: 4941d472bf95 ("virtio-net: do not reset during XDP set")
>> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
>> ---
>>   drivers/net/virtio_net.c | 12 ++++++++++++
>>   1 file changed, 12 insertions(+)
>>
>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>> index 7e4617216a4b..33406d59efe2 100644
>> --- a/drivers/net/virtio_net.c
>> +++ b/drivers/net/virtio_net.c
>> @@ -5956,6 +5956,15 @@ static int virtnet_xdp_set(struct net_device *dev, struct bpf_prog *prog,
>>   	if (!prog && !old_prog)
>>   		return 0;
>>   
>> +	/*
>> +	 * Make sure refill_work does not run concurrently to
>> +	 * avoid napi_disable race which leads to deadlock.
>> +	 */
>> +	if (netif_running(dev)) {
>> +		disable_delayed_refill(vi);
>> +		cancel_delayed_work_sync(&vi->refill);
> AFAICS at this point refill_work() could still be running, why don't you
> need to call flush_delayed_work()?

AFAIK, the cancel_delayed_work_sync (this is a synchronous version) 
provides somewhat stronger guarantee than the flush_delayed_work. 
Internally, the cancel_delayed_work_sync will also call to __flush_work. 
The cancel_delayed_work_sync temporarily disables the work before 
calling __flush_work, so that even if refill_work tries to re-queue 
itself, that re-queue will fail. As the refill_work can actually 
re-queue itself, I think we must use cancel_delayed_work_sync here.

Thanks,
Quang Minh.


