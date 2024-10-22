Return-Path: <bpf+bounces-42776-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 859139AA14F
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 13:45:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3F94B229EF
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 11:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 137CC1474BC;
	Tue, 22 Oct 2024 11:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C4gSUn4i"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCCDE13BAC3
	for <bpf@vger.kernel.org>; Tue, 22 Oct 2024 11:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729597516; cv=none; b=ZrlJMpuBuhY8QBtLvDPbhCjGScngJuSWQXxyenVbTscR40iCZ/DVFbekZNFBN4aJFFEuNVAq643nmMMTZQ8LUAB7sCRPURYO57Zpt5+Y1JCHWODI8EOyuV2CStJTc9S0uDASSj8kCq33+J/eWw0ypHQd43hese3EuYm/qKP1apI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729597516; c=relaxed/simple;
	bh=WZr6nhUUy78YTMOWnUJE5GttoIrEa/0NxsjsM9zKj14=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U7M998wsthXgGL/KPbbfSozipLuEmUgbb1RugGWRB2cu6QotUHI0fDPL8zuJ1tqsHew7jzaF2W2ct4VH6uL07yIlPfL0V3hVjbmCb15bkdXjar/mZ6tQC3qE55PPOwGNnMloCazwG+ETUcvT9uabrXtdqz47KjwtwDSvDCnp3Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C4gSUn4i; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729597513;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7enNsG1bpUFHlhr1DT8YO4p834Hmfug+sy6xBqiLvdU=;
	b=C4gSUn4iDoH/B3l8/WwKrLEDIUgg09X5wgee7AYchD9i8cjJcnAxf9I6hKiL71e+pALSEn
	0oHx+tNyQlIvwVs/0JO6ZbmjVDqiB28jT1zNhxm1tBVHn7YsnsoQQC8dhVu9AxgLV+tBAo
	eS80uxDBAdFZhqPxrsXojOq3NyKjSkI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-W1LtwbXaNfWYWzOPwz6vfA-1; Tue, 22 Oct 2024 07:45:11 -0400
X-MC-Unique: W1LtwbXaNfWYWzOPwz6vfA-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-37d47fdbbd6so3235583f8f.3
        for <bpf@vger.kernel.org>; Tue, 22 Oct 2024 04:45:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729597510; x=1730202310;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7enNsG1bpUFHlhr1DT8YO4p834Hmfug+sy6xBqiLvdU=;
        b=FY+ArrqPoCbov/NDKJPbBa5o7R3JVtl6mnJgFBx9c582vJeVRNMJKRAeveO91/XIlx
         qxOvk9h4GXtzk7suGMhHK0Tl4ppgLnmmghr03i4lK9dHnBf8FBrjjSDqBdnz2gs1Aaky
         esnGAjV0wzaoSFaTNaOCLrcmeGaJvz5xaUbHa48dff2KjtLwbI8eb5hhtZw0eyTM6XeJ
         utR0vCMSMXYrYR3vE+TGQv8OAyCJiPIRljceqQl7ah7toSewdh4gwShWp9K3zZJw8T1P
         2WyYItulg1NvCxRK5shr/+K0SDZccHUwGuetAT0Q9BrcRjPPJ/qv181h0RSuwInSiVfl
         0xHQ==
X-Forwarded-Encrypted: i=1; AJvYcCXeYTw9q2xBtXGhfVDNOZsUr+HF4x3pkhT9zOdnh7TAlwQw5uzfpcVmkRe/jz8fo/nAwWs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw35Kpq4BVLPTnXV2CJDWFgl4RXKdu8PYL6G9xZ8ilQhaPrUc1V
	/NJbzYbDiR3880I/NNnX7Rhy9BUlPcv5QCXKwKjKjXy/G1peSM+idMdAt72QtqLh6AjquO+C2sI
	YQCK/LPgUHeRi58BZK3g5Jt2YRKZRZnyZJmJGOFOonIptTLAB
X-Received: by 2002:a5d:4ac5:0:b0:37d:5035:451 with SMTP id ffacd0b85a97d-37ef2132fc5mr1627615f8f.10.1729597510367;
        Tue, 22 Oct 2024 04:45:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH9/lCtcCldWBfFoCPcs0bS+J8BhKQ+FTbLQ1w6APtRdz0iPaHCYLpmwsuxKuNHk9sPkkLKSg==
X-Received: by 2002:a5d:4ac5:0:b0:37d:5035:451 with SMTP id ffacd0b85a97d-37ef2132fc5mr1627593f8f.10.1729597509995;
        Tue, 22 Oct 2024 04:45:09 -0700 (PDT)
Received: from [10.43.17.17] (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0a3650esm6504274f8f.4.2024.10.22.04.45.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Oct 2024 04:45:09 -0700 (PDT)
Message-ID: <3d1ad598-531a-4e31-a0cc-b8fe05d37f64@redhat.com>
Date: Tue, 22 Oct 2024 13:45:08 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] objpool: fix choosing allocation for percpu slots
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
 Matt Wu <wuqiang.matt@bytedance.com>, bpf@vger.kernel.org,
 Andrii Nakryiko <andrii@kernel.org>
References: <20240826060718.267261-1-vmalik@redhat.com>
 <20241022141748.521cb2d6a4a86428c9bfc99e@kernel.org>
From: Viktor Malik <vmalik@redhat.com>
Content-Language: en-US
In-Reply-To: <20241022141748.521cb2d6a4a86428c9bfc99e@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/22/24 07:17, Masami Hiramatsu (Google) wrote:
> On Mon, 26 Aug 2024 08:07:18 +0200
> Viktor Malik <vmalik@redhat.com> wrote:
> 
>> objpool intends to use vmalloc for default (non-atomic) allocations of
>> percpu slots and objects. However, the condition checking if GFP flags
>> are equal to GFP_ATOMIC is wrong b/c GFP_ATOMIC is a combination of bits
> 
> You meant "whether GFP flags sets any bit of GFP_ATOMIC is wrong"?

Well, I meant that the condition is wrong w.r.t. what is supposedly its
original purpose. But feel free to rephrase as you seem fit or I can
send v3 if you prefer.

Thanks.
Viktor

> 
>> (__GFP_HIGH|__GFP_KSWAPD_RECLAIM) and so `pool->gfp & GFP_ATOMIC` will
>> be true if either bit is set. Since GFP_ATOMIC and GFP_KERNEL share the
>> ___GFP_KSWAPD_RECLAIM bit, kmalloc will be used in cases when GFP_KERNEL
>> is specified, i.e. in all current usages of objpool.
>>
>> This may lead to unexpected OOM errors since kmalloc cannot allocate
>> large amounts of memory.
>>
>> For instance, objpool is used by fprobe rethook which in turn is used by
>> BPF kretprobe.multi and kprobe.session probe types. Trying to attach
>> these to all kernel functions with libbpf using
>>
>>     SEC("kprobe.session/*")
>>     int kprobe(struct pt_regs *ctx)
>>     {
>>         [...]
>>     }
>>
>> fails on objpool slot allocation with ENOMEM.
>>
>> Fix the condition to truly use vmalloc by default.
>>
> 
> Anyway, this looks good to me.
> 
> Thank you,
> 
>> Fixes: b4edb8d2d464 ("lib: objpool added: ring-array based lockless MPMC")
>> Signed-off-by: Viktor Malik <vmalik@redhat.com>
>> Acked-by: Andrii Nakryiko <andrii@kernel.org>
>> Reviewed-by: Matt Wu <wuqiang.matt@bytedance.com>
>> ---
>>  lib/objpool.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/lib/objpool.c b/lib/objpool.c
>> index 234f9d0bd081..fd108fe0d095 100644
>> --- a/lib/objpool.c
>> +++ b/lib/objpool.c
>> @@ -76,7 +76,7 @@ objpool_init_percpu_slots(struct objpool_head *pool, int nr_objs,
>>  		 * mimimal size of vmalloc is one page since vmalloc would
>>  		 * always align the requested size to page size
>>  		 */
>> -		if (pool->gfp & GFP_ATOMIC)
>> +		if ((pool->gfp & GFP_ATOMIC) == GFP_ATOMIC)
>>  			slot = kmalloc_node(size, pool->gfp, cpu_to_node(i));
>>  		else
>>  			slot = __vmalloc_node(size, sizeof(void *), pool->gfp,
>> -- 
>> 2.46.0
>>
> 
> 


