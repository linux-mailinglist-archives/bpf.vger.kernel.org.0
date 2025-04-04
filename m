Return-Path: <bpf+bounces-55322-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA7B7A7BA22
	for <lists+bpf@lfdr.de>; Fri,  4 Apr 2025 11:44:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 153503B3C1E
	for <lists+bpf@lfdr.de>; Fri,  4 Apr 2025 09:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07C151B043E;
	Fri,  4 Apr 2025 09:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e7P7zEt/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1800419D8BC;
	Fri,  4 Apr 2025 09:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743759834; cv=none; b=DsRtaGi+axgza7c+nEPchhx6t+Ka5gN1OiCjzWkwRXmjxYCMV41DmczX/Y7WdOni8kOy8tN8yqHS2Eukiv5B7YJ8XAYgTKOYTMWcNrwqzvCbz/xYLOk41PsX1fJ3FQNsrZ0HrJX1yibYxpFQXS70lGkgVa56x/5BTcQXNE8/Ok0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743759834; c=relaxed/simple;
	bh=Cy5R4h2CMeYfcKq3JmLBbPpLA/1mufrC04ciYKMxz8M=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=TPIexoIaLPwg1Zt30h9PCyfIftxQVizuXHYreLgWjK5ncrzmtY2+/fjssEr3VnpbrEysxpH7ODTEPFMymQo1WTc/hl3Ntz62WDyHv9OxqcC1QIveDFAcUccmDa1W4OAxiCdme7bmLYHLVsx+utLEnkKiRoJKB29SHQHqsV59x9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e7P7zEt/; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-739be717eddso1431381b3a.2;
        Fri, 04 Apr 2025 02:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743759832; x=1744364632; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2dp9HC2qkGWoowunW2raQA7ZBkf3B+GmnuL0MF1UqM0=;
        b=e7P7zEt/jXuTeUfJgSqJrnaWuFCPf8Y16kdVt3zjWmcC3EtJU2Zgbg3DVmDCtN62+N
         NvDERoGyuONgDFqHhQLofIjJugQ3eCWOxEF1KVHnJ+qOvBBSRCcftq56iPxUKUTBtpn6
         fynhxJ9xsQ6egUyOp1Ub7wwKID55ZoYqhz1LxqZU3vqz2DHYs9K2W4cp0wdRyQ/8elsm
         FUkTegoPAkNujBs7WvPf1Z2yuliH+0VfjphLhK54oO4GhxXu4LscB6pextQA7EjZbW/o
         K6uUvW523x8IgL8vxRNYeU7iDWuCvLsLMrZdUu0jlrm8Qg3gCKF2aX3F2UFcwK3yyA4I
         qDZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743759832; x=1744364632;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2dp9HC2qkGWoowunW2raQA7ZBkf3B+GmnuL0MF1UqM0=;
        b=ohBpSfi47uTq4psuBfCFlYU38/OhF8KubeLg91ENnW+mgn3SinXTVD48TRK2qtSue8
         Vo7PYB/bZ0V+zUX6HomLJoQ7BdYd04zI2XIS4RXNwZpHH/KpmPjszvhiA5sb7JqDIFcj
         SqtegMKBPaRNDcnKiBi/F6QigduQ/V93LMq7geASZ9hBIP+VP0VM5WXSMxpduVjTkuME
         VjH/i6Z6xRK6SjYzaLsUVLz/iIox7lRLb5fCnVzA+qcXycY4faM6Pb6HtnEOOZf8GTIG
         psH6HxKe60sgXne3dnLR1T/T4nNT0HAEJmhjEpzPmxQ9OCPfR8eIQLHvCA3SONLdm6Ut
         A0hw==
X-Forwarded-Encrypted: i=1; AJvYcCURVT0yzkNokUuVVemTLlktcXHGbb7q8424nXXzixcjxSOYdhg2Sl93MD4JyLKY/j1/d1yROefs@vger.kernel.org, AJvYcCWQptIXInvnF3fzHfGfdbwF0p3VdV9OoXM6PB1jU2IhB8FqxQpjSbpIkEvyyu1efsc0jp0=@vger.kernel.org, AJvYcCXXvZNoCYkmEfPkoJxhYqEOoRy8ZjYCn806rEI2ZfqCZRmoxBTISIyyTq+YiZrQLttgSgybq2hX5rEc+v1J@vger.kernel.org
X-Gm-Message-State: AOJu0Yx82TtBNC7S72gAq009bMCJ1qQHBxQEt1Ir1IDBq9rVYNoNC6pC
	epkUHVCw5va0bhkKqKSXw1IGkHkE8YX8zVHhZVyNyU2pG78U9jDt
X-Gm-Gg: ASbGncvdlNO1gssjXScSjT5XvdrpvILRP6smEGwHm2QjnxXD7t2HXUwYCX6ztlEuhbJ
	dwibIZvoZPScXlJAJYbpBZG3Oy6akvrIgVJ65Iz8CVCIAF0CYOzWOpp0setgkP9/yXZjvVoh4w/
	cuTO0nyWPL366elH9K7DK2PRGR0+yHiFUumt8JNmJHKegdcBJ7a+w3y7lZruY2QZhZYn/3n6of5
	hK5zbqhcpxCLG02O/dQTGcLsKRUy4/KUAD+Y8vAcNvaMGsjtdIXEl77OFCvAHY4vhN8O9Iv9DNR
	2NRrxzurjL7lslxz4Lj5R/c1zDGECe1utdda0I+cOHWUzOquMrm7ad98Md0uS95lIp1whwRB3l7
	GqK5+Hx4aK5vDjjU1pbBJmeM=
X-Google-Smtp-Source: AGHT+IHla/lWi8LDRu2Y+SJC0LCiuXNaD4R1egj1fCZ39xp2lt9qKISE1OlySN6DP6Qk24H6tK11sw==
X-Received: by 2002:a17:90b:6ce:b0:2ff:6e72:b8e2 with SMTP id 98e67ed59e1d1-306a48f3923mr3567005a91.31.1743759832307;
        Fri, 04 Apr 2025 02:43:52 -0700 (PDT)
Received: from ?IPV6:2001:ee0:4f4e:bd30:f724:d4da:7a88:b9d5? ([2001:ee0:4f4e:bd30:f724:d4da:7a88:b9d5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3057ca47ec7sm3553256a91.15.2025.04.04.02.43.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Apr 2025 02:43:51 -0700 (PDT)
Message-ID: <53b94412-c550-4d90-9275-5b087609b8e3@gmail.com>
Date: Fri, 4 Apr 2025 16:43:44 +0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] virtio-net: disable delayed refill when setting up xdp
From: Bui Quang Minh <minhquangbui99@gmail.com>
To: virtualization@lists.linux.dev
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
References: <20250402054210.67623-1-minhquangbui99@gmail.com>
 <8aad5ff9-6eab-411d-9569-9a2303561ac0@gmail.com>
Content-Language: en-US
In-Reply-To: <8aad5ff9-6eab-411d-9569-9a2303561ac0@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/3/25 17:43, Bui Quang Minh wrote:
> On 4/2/25 12:42, Bui Quang Minh wrote:
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
>>   drivers/net/virtio_net.c | 12 ++++++++++++
>>   1 file changed, 12 insertions(+)
>>
>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>> index 7e4617216a4b..33406d59efe2 100644
>> --- a/drivers/net/virtio_net.c
>> +++ b/drivers/net/virtio_net.c
>> @@ -5956,6 +5956,15 @@ static int virtnet_xdp_set(struct net_device 
>> *dev, struct bpf_prog *prog,
>>       if (!prog && !old_prog)
>>           return 0;
>>   +    /*
>> +     * Make sure refill_work does not run concurrently to
>> +     * avoid napi_disable race which leads to deadlock.
>> +     */
>> +    if (netif_running(dev)) {
>> +        disable_delayed_refill(vi);
>> +        cancel_delayed_work_sync(&vi->refill);
>> +    }
>> +
>>       if (prog)
>>           bpf_prog_add(prog, vi->max_queue_pairs - 1);
>>   @@ -6004,6 +6013,8 @@ static int virtnet_xdp_set(struct net_device 
>> *dev, struct bpf_prog *prog,
>>               virtnet_napi_tx_enable(&vi->sq[i]);
>>           }
>>       }
>> +    if (netif_running(dev))
>> +        enable_delayed_refill(vi);
> While doing some testing, it look likes that we must call 
> try_fill_recv to resume the rx path. I'll do more testing and send a 
> new v2 patch.

I've sent a new patch here: 
https://lore.kernel.org/virtualization/20250404093903.37416-1-minhquangbui99@gmail.com/T/#u. 
As the commit title has changed a little bit, I don't use v2 tag.

Thank you,
Quang Minh.



