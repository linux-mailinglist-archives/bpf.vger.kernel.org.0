Return-Path: <bpf+bounces-41999-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46D1499E326
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 11:53:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6763B1C21D46
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 09:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 697C51E32AF;
	Tue, 15 Oct 2024 09:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="RImCyTmH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E96D07F7FC
	for <bpf@vger.kernel.org>; Tue, 15 Oct 2024 09:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728985996; cv=none; b=Fc+SYpZhOrc242VUhVKVojtTe6tPAjU+IxllcDWsIbjbzLua57j7LaX//CfabTy6+zm4cRsyPINXuhtDG+TNadjCPcrRXQvxAZy4FkXU9fxC1MEMUDMgWb7/wjLqaeZ2pttFVHPX7owmQgaHq62kxKSk8nJW9jGH2DRfGZ93mnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728985996; c=relaxed/simple;
	bh=+QiVpaJTqb9lGZxquQMPwOmszRdsIH3dWewjm4uDNPc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bwmt0erKCCRyFRUbu/Lx9NW9Z90ZrH1ypLJPoNJNU1ghxUEzkOdgc0I0bIA9Ok9a8Fw+HhB/9vS1vsMPSEbKa+3XsN/8I72K1KmV1IQ7n+5aUw59X6EqXB8j0davMi/Uk8vSjZy38noq1mQgXUEtvh11Lt0EvFkuHmSDYxwuH4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=RImCyTmH; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2fb5fa911aaso3390931fa.2
        for <bpf@vger.kernel.org>; Tue, 15 Oct 2024 02:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1728985991; x=1729590791; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gXKHChHiIoQp0tWweCcNM5/x2glH+l2xRI6KeML9nf4=;
        b=RImCyTmH1jUX12qXeNqCXjNwCcO4NA39rko4oHZBRSb6DVeBuumbE30kyNhSKCu1q0
         5w9sugSt4W2ir2ZI9o7UBMO2J7r90zc74gbEOFw34jzNqMSK0pUFt/up2NxGWCG9cvt9
         i8Z8RRZNcUpaqDRoIBurWfNdR0/JFBlzlA4nWvK6XlXJAnOI3RvdIjXOHhBlq5yxWePq
         uWuJZFJa8qCIj3UC4FPkDL96SI+dxPv50wJyYdhfvwqMvrIxiQR/X33Y1D6bktoANvQi
         8OqHcIAAnlL/x1aCYP1fItBel3syc6GggeEmpibh91EOb5s4JBX48Px3he5Mt26jd16S
         XG5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728985991; x=1729590791;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gXKHChHiIoQp0tWweCcNM5/x2glH+l2xRI6KeML9nf4=;
        b=TdOH4xv0UTuCgDp8cUPZR/JvMuPSLUyQTVNt0XY6BSCXdY5RT7gBUDwFLbjWBKQUDu
         LneC6/xWWhpPOe2YgGt0XqnUCgjJxvoEVx7bzxJj5xErFV4cX/fEWRKeirqgJoiL74wB
         +nm1H2vSf4jcXkavgx14TIJxiCwBcagLUaGFBDBXbhhvwINTC0dvdpvOeSFUOAuMLLZu
         sAx/FtFi9MoJaSmfHyydWUUP/xBaSTEHP1C8QocG/U9KqF5oTqPlaN1N7G39iwW4/WOF
         Vm7J8uF5A/yZMqFRfae/uhtWuDqw26VL2PNRAi7DPGxLc+p1rI9jn0ILwMrBlPIDbTCu
         +Muw==
X-Forwarded-Encrypted: i=1; AJvYcCXItGnflk5HVnYenb2m5fsHd6I9pyW1OUxevQyNQAl6u75/9HtCftuB5rn4uncTwbFT8/w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLvVvHEfrZuW8L5WXH88RNXKPfI8w5gvoYrr07TgoDplBYH2kI
	0M4zOoWmmoGTX6xouwz+gOeiMf6m8i2eE8A0YC0qY1VwqUZeHUj1n3uP5VpGu0w=
X-Google-Smtp-Source: AGHT+IEHVCGw5gneW8aiZsfe3uUHa9UQ89iqVPpiZ2h77v58WraREjoOic94ZLZj77yCdDgyfYbw+g==
X-Received: by 2002:a05:651c:2220:b0:2fb:3881:35d5 with SMTP id 38308e7fff4ca-2fb3f2c725emr60984831fa.35.1728985990884;
        Tue, 15 Oct 2024 02:53:10 -0700 (PDT)
Received: from [192.168.0.245] ([62.73.69.208])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a2973fba2sm51027766b.47.2024.10.15.02.53.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Oct 2024 02:53:10 -0700 (PDT)
Message-ID: <2cdcad89-2677-4526-8ab5-3624d0300b7f@blackwall.org>
Date: Tue, 15 Oct 2024 12:53:08 +0300
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] bpf: xdp: fallback to SKB mode if DRV flag is absent.
To: Daniel Borkmann <daniel@iogearbox.net>, Hangbin Liu
 <liuhangbin@gmail.com>, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Andrii Nakryiko <andriin@fb.com>,
 Jussi Maki <joamaki@gmail.com>, Jay Vosburgh <jv@jvosburgh.net>,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 Liang Li <liali@redhat.com>
References: <20241015033632.12120-1-liuhangbin@gmail.com>
 <8ef07e79-4812-4e02-a5d1-03a05726dd07@iogearbox.net>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <8ef07e79-4812-4e02-a5d1-03a05726dd07@iogearbox.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 15/10/2024 11:17, Daniel Borkmann wrote:
> On 10/15/24 5:36 AM, Hangbin Liu wrote:
>> After commit c8a36f1945b2 ("bpf: xdp: Fix XDP mode when no mode flags
>> specified"), the mode is automatically set to XDP_MODE_DRV if the driver
>> implements the .ndo_bpf function. However, for drivers like bonding, which
>> only support native XDP for specific modes, this may result in an
>> "unsupported" response.
>>
>> In such cases, let's fall back to SKB mode if the user did not explicitly
>> request DRV mode.
>>

So behaviour changed once, now it's changing again.. IMO it's better to explicitly
error out and let the user decide how to resolve the situation. The above commit
is 4 years old, surely everyone is used to the behaviour by now. If you insist
to do auto-fallback, then at least I'd go with Daniel's suggestion and do it
in the bonding device. Maybe it can return -EFALLBACK, or some other way to
signal the caller and change the mode, but you assume that's what the user
would want, maybe it is and maybe it's not - that is why I'd prefer the
explicit error so conscious action can be taken to resolve the situation.

That being said, I don't have a strong preference, just my few cents. :)

>> Fixes: c8a36f1945b2 ("bpf: xdp: Fix XDP mode when no mode flags specified")
>> Reported-by: Liang Li <liali@redhat.com>
>> Closes: https://issues.redhat.com/browse/RHEL-62339
> 
> nit: The link is not accessible to the public.
> 
> Also, this breaks BPF CI with regards to existing bonding selftest :
> 
>   https://github.com/kernel-patches/bpf/actions/runs/11340153361/job/31536275257
> 
> Given this issue is related to only bonding driver, could this be fixed
> there instead?
> 
>> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
>> ---
>>   net/core/dev.c | 12 +++++++++++-
>>   1 file changed, 11 insertions(+), 1 deletion(-)
>>
>> diff --git a/net/core/dev.c b/net/core/dev.c
>> index ea5fbcd133ae..e32069d81cd7 100644
>> --- a/net/core/dev.c
>> +++ b/net/core/dev.c
>> @@ -9579,6 +9579,7 @@ static int dev_xdp_attach(struct net_device *dev, struct netlink_ext_ack *extack
>>         /* don't call drivers if the effective program didn't change */
>>       if (new_prog != cur_prog) {
>> +reinstall:
>>           bpf_op = dev_xdp_bpf_op(dev, mode);
>>           if (!bpf_op) {
>>               NL_SET_ERR_MSG(extack, "Underlying driver does not support XDP in native mode");
>> @@ -9586,8 +9587,17 @@ static int dev_xdp_attach(struct net_device *dev, struct netlink_ext_ack *extack
>>           }
>>             err = dev_xdp_install(dev, mode, bpf_op, extack, flags, new_prog);
>> -        if (err)
>> +        if (err) {
>> +            /* The driver returns not supported even .ndo_bpf
>> +             * implemented, fall back to SKB mode.
>> +             */
>> +            if (err == -EOPNOTSUPP && mode == XDP_MODE_DRV &&
>> +                !(flags & XDP_FLAGS_DRV_MODE)) {
>> +                mode = XDP_MODE_SKB;
>> +                goto reinstall;
>> +            }
>>               return err;
>> +        }
>>       }
>>         if (link)


