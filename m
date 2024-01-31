Return-Path: <bpf+bounces-20841-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88D7D84453A
	for <lists+bpf@lfdr.de>; Wed, 31 Jan 2024 17:56:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36940B2A4A1
	for <lists+bpf@lfdr.de>; Wed, 31 Jan 2024 16:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C20D12CDA4;
	Wed, 31 Jan 2024 16:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C9g0bSg7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FEB312C54F;
	Wed, 31 Jan 2024 16:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706719800; cv=none; b=bIJkLqAAG0/6uX32DL0V0n8CBDNA2CsPmPmrNS7zSaz4ScmvPMIG9EtNPSshPmH5j4PEFC6MwfLwtTZQS1sl5S78taS8VC/Gfsq8IA38ZWcA6pvo2quoEbsFRjfgFgQ84ENdwgxTR7kJ0AFKS0KWZ3fUQOB/HaOCfDWTmFiKRBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706719800; c=relaxed/simple;
	bh=dumD7ttqScm0LdjY/IpVhA9bCYlBepysRq4/xs786t0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oAqVHJMSufRT+1csBjLyhM9+4RIHSLusAZxDZA0hZOQVtiRF/WFXj5ma+Nkd1RWdBYIabOdJy1gyoMQ8DJBRlGQ6OSoYO7q2lwef8sjST/Qetn/2yJixOr5P+zORr/0CEtVllR8F9EBpeFt6ZX3cBYnZqOf4y+UHoxMUbhFo1Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C9g0bSg7; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-60417488f07so2323517b3.1;
        Wed, 31 Jan 2024 08:49:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706719797; x=1707324597; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YHVjd0RGAsEmzSEWHVEvEMaoTUsMfmi+W8XrmMVYA7U=;
        b=C9g0bSg7/dzvVl9gfAmoR1XsDonHGb7zqfRjdaJnj8HIwfzOEABMctQn5OC8vREsaH
         XSb5uYkcxvjlKHfFKJf6XbHn3MhCXSNh93eGoBIYTGS7NWNLpVgc1EuyLzJjZ1Sut+yH
         vab2cP+rpCUOEKoMz+mnan2h8I2T7tnBol+TA6MBqNIDYVMggc2DYPd/xLdd4AjUujKe
         wohwhkt+IDuqD3EOqEXKYbiyXHm9NlKJpbmqAK1UG6q//o5dy1Du6XPjNOqTx8hP2UFC
         upiYvVkx5Rlm/vgpcmW7wFEkDr9JrFDw9fJhgqzZnH3hTjsQO2LJ4ORTaT3py2oY3WiA
         ZrLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706719797; x=1707324597;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YHVjd0RGAsEmzSEWHVEvEMaoTUsMfmi+W8XrmMVYA7U=;
        b=gk8TYr5bH+Z4sbDdCeQPxswCMB/qeDsFA+WSQtNY8fHCOUNzzvlIayj3ZHTiYAZZPU
         T7sVAYgQbGXHGsAmWWce2csE3RGUpmLD77WU8EqXwuPIDMUa0ujyaDQNTGbalY+6Obve
         7opeoZF/miremVWz2/EQtoBGIDydwDVKQqhL+u/IS58BOLyboXAAdii22fILh71T29bq
         Ohz/6x89CFyhiLK61hsg1dCLmwYn0cLvjflBsGKt+v1nCBSCU/hwFtcx8HMsfdeMID60
         WcHW8+KC49hv9gXSUnbO8G9KbwMTgsQfxVEcBNz2XxHHUrthzYcTqMYt8N21t7VViHFt
         I7DA==
X-Gm-Message-State: AOJu0Yy2WjMYCWk0k7lal96cWZvUlCTPd4u0WfiDDqjFXNtrXFCysWB/
	M5+aLkdOIUbIdi1R36aQodyOCsTldDi+tkL6uElCro3zoTqv1pAi
X-Google-Smtp-Source: AGHT+IFFKxRUj/PV9hsITMpNTloEegZejZHcf3Gw2OynG5rLJM5gigQ+Fxn9DCpf7kjsfQ5KNCI12A==
X-Received: by 2002:a81:ae42:0:b0:604:1013:5b46 with SMTP id g2-20020a81ae42000000b0060410135b46mr1721357ywk.32.1706719796030;
        Wed, 31 Jan 2024 08:49:56 -0800 (PST)
Received: from ?IPV6:2600:1700:6cf8:1240:d270:81b6:1108:542b? ([2600:1700:6cf8:1240:d270:81b6:1108:542b])
        by smtp.gmail.com with ESMTPSA id z138-20020a0dd790000000b00603cd139668sm2489517ywd.139.2024.01.31.08.49.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jan 2024 08:49:55 -0800 (PST)
Message-ID: <33e72531-b525-4c9f-a9cc-73175b7cd721@gmail.com>
Date: Wed, 31 Jan 2024 08:49:54 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v7 1/8] net_sched: Introduce eBPF based Qdisc
Content-Language: en-US
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Amery Hung <ameryhung@gmail.com>, bpf@vger.kernel.org,
 yangpeihao@sjtu.edu.cn, toke@redhat.com, jhs@mojatatu.com, jiri@resnulli.us,
 sdf@google.com, xiyou.wangcong@gmail.com, yepeilin.cs@gmail.com,
 netdev@vger.kernel.org, Kui-Feng Lee <thinker.li@gmail.com>
References: <cover.1705432850.git.amery.hung@bytedance.com>
 <232881645a5c4c05a35df4ff1f08a19ef9a02662.1705432850.git.amery.hung@bytedance.com>
 <0484f7f7-715f-4084-b42d-6d43ebb5180f@linux.dev>
 <CAMB2axM1TVw05jZsFe7TsKKRN8jw=YOwu-+rA9bOAkOiCPyFqQ@mail.gmail.com>
 <01fdb720-c0dc-495d-a42d-756aa2bf4455@linux.dev>
 <CAMB2axOZqwgksukO5d4OiXeEgo2jFrgnzO5PQwABi_WxYFycGg@mail.gmail.com>
 <8c00bd63-2d00-401e-af6d-1b6aebac4701@linux.dev>
 <845df264-adb3-4e00-bb8e-2a0ac1d331ae@gmail.com>
 <b36c40fb-d274-41ea-abbe-231bebfabdc9@linux.dev>
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <b36c40fb-d274-41ea-abbe-231bebfabdc9@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 1/30/24 17:01, Martin KaFai Lau wrote:
> On 1/30/24 9:49 AM, Kui-Feng Lee wrote:
>>>> 2. Returning a kptr from a program and treating it as releasing the 
>>>> reference.
>>>
>>> e.g. for dequeue:
>>>
>>> struct Qdisc_ops {
>>>      /* ... */
>>>      struct sk_buff *        (*dequeue)(struct Qdisc *);
>>> };
>>>
>>>
>>> Right now the verifier should complain on check_reference_leak() if 
>>> the struct_ops bpf prog is returning a referenced kptr.
>>>
>>> Unlike an argument, the return type of a function does not have a 
>>> name to tag. It is the first case that a struct_ops bpf_prog returning a 
>>
>> We may tag the stub functions instead, right?
> 
> What is the suggestion on how to tag the return type?
> 
> I was suggesting it doesn't need to tag and it should by default require 
> a trusted ptr for the pointer returned by struct_ops. The pointer 
> argument and the return pointer of a struct_ops should be a trusted ptr.


That make sense to me. Should we also allow operators to return a null
pointer?

> 
>> Is the purpose here to return a referenced pointer from a struct_ops
>> operator without verifier complaining?
> 
> Yes, basically need to teach the verifier the kernel will do the 
> reference release.
> 
>>
>>> pointer. One idea is to assume it must be a trusted pointer 
>>> (PTR_TRUSTED) and the verifier should check it is indeed with 
>>> PTR_TRUSTED flag.
>>>
>>> May be release_reference_state() can be called to assume the kernel 
>>> will release it as long as the return pointer type is PTR_TRUSTED and 
>>> the type matches the return type of the ops. Take a look at 
>>> check_return_code(). 
> 

