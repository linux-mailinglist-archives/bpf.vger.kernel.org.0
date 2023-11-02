Return-Path: <bpf+bounces-13875-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F66B7DE9CF
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 01:59:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F4008B211A8
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 00:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E70F111F;
	Thu,  2 Nov 2023 00:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B7CkjyMn"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8994710E7;
	Thu,  2 Nov 2023 00:59:35 +0000 (UTC)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6615E8;
	Wed,  1 Nov 2023 17:59:33 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-5b499b18b28so5522047b3.0;
        Wed, 01 Nov 2023 17:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698886773; x=1699491573; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9V4JXN+dcGRzeaE5V8SxgYSNwz57A00kFhKDPhYPWC0=;
        b=B7CkjyMnaCQe61H4+EMbKrxoVPy7TZcguooJNmGaVvWIPrWUiYSg6IDmwJjUgzF4TQ
         rYXa3q7jaAhmtRo+jF7CAMigzhG+0lKsnddBiqxB36sn680wlqwOOHcfPorGtkqFwSMz
         USzGu5YNu/rsH9Kk7gQzyNYkcTxco1rnk+vSc9cLySu4qgMGGKkqdgZWMggeZal9Ea/A
         8XnfKECIvJ/bHa3l4dmRgXI9+Xku6/LNKJHLnsbHW/NE2aLwNnTV/lYldif/0Sczm3es
         Ey+lPVG8u/xOoYTIS5UiIWGjnBQrq9QhYwIqmZAnp2i48/SI6un7B8qZxzDPeY2Nu6mj
         HuEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698886773; x=1699491573;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9V4JXN+dcGRzeaE5V8SxgYSNwz57A00kFhKDPhYPWC0=;
        b=B6nOwngqGdbrInAXFVU8YxynuMT399VzQpcpb+Tpx6O4771EGuQZSm4tsHRil8C5tM
         3wQ65A9t4EuZT3MGgqmIKK98vKhbFVSkO04rFpXz6PtxL2oitf3swab2A8ghrJYJTYwK
         6YhaxQLQb09yTmUrDSfr9DKcS35JPUjc2SE9J2LoZP+LsjgGgOw7MUnQbvTM4wT11QOv
         Nk5QPTnlp/sx13qUtecHQO4AUwW+YV8BdTRI9qMw1kjIwG2iCm4nvNAQtD42VzScA5EZ
         ea9uBzXtPjnnA6Fc/h7AaBGSwB/FMCTnowS9w8FLH3hbBqr6J/LUs+zzK2vOLVutj+VY
         gKZg==
X-Gm-Message-State: AOJu0Yw9FawYyPGMCLy8eYl2T/B/T+09CGp2J2f/j+L/ycPyb17dIpbd
	LskGt7CY4wEKHXIWM5WYySM=
X-Google-Smtp-Source: AGHT+IGZfXgxMti9LJh05JRHRMmGvJej6cUB8N2PXANSqNZzj5BkQH6WknTeC1AWHh1RD+ZBZfWWvQ==
X-Received: by 2002:a81:b659:0:b0:5a8:f9fa:aba4 with SMTP id h25-20020a81b659000000b005a8f9faaba4mr18595791ywk.2.1698886772956;
        Wed, 01 Nov 2023 17:59:32 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:eea0:6f66:c57d:6b7c? ([2600:1700:6cf8:1240:eea0:6f66:c57d:6b7c])
        by smtp.gmail.com with ESMTPSA id d8-20020a814f08000000b005845e6f9b50sm623867ywb.113.2023.11.01.17.59.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Nov 2023 17:59:32 -0700 (PDT)
Message-ID: <c4427a57-aea9-4acc-a6be-e30cfb1dbaad@gmail.com>
Date: Wed, 1 Nov 2023 17:59:30 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v8 07/10] bpf, net: switch to dynamic
 registration
Content-Language: en-US
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: kuifeng@meta.com, netdev@vger.kernel.org, bpf@vger.kernel.org,
 ast@kernel.org, song@kernel.org, kernel-team@meta.com, andrii@kernel.org,
 thinker.li@gmail.com, drosen@google.com
References: <20231030192810.382942-1-thinker.li@gmail.com>
 <20231030192810.382942-8-thinker.li@gmail.com>
 <183fd964-8910-b7e6-436a-f5f82c2bafb0@linux.dev>
 <10f383a2-c83b-4a40-a1f9-bcf33c76c164@gmail.com>
 <5a8520dd-0dd6-4d51-9e4a-6eebcf7e792d@linux.dev>
 <51be2e5e-8def-45c5-8864-6b0dcc794300@gmail.com>
 <331802b3-07bd-7fec-32a7-b85a8dae1391@linux.dev>
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <331802b3-07bd-7fec-32a7-b85a8dae1391@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 11/1/23 17:17, Martin KaFai Lau wrote:
> On 10/31/23 5:19 PM, Kui-Feng Lee wrote:
>>
>>
>> On 10/31/23 17:02, Martin KaFai Lau wrote:
>>> On 10/31/23 4:34 PM, Kui-Feng Lee wrote:
>>>>>> diff --git a/include/linux/btf.h b/include/linux/btf.h
>>>>>> index a8813605f2f6..954536431e0b 100644
>>>>>> --- a/include/linux/btf.h
>>>>>> +++ b/include/linux/btf.h
>>>>>> @@ -12,6 +12,8 @@
>>>>>>   #include <uapi/linux/bpf.h>
>>>>>>   #define BTF_TYPE_EMIT(type) ((void)(type *)0)
>>>>>> +#define BTF_STRUCT_OPS_TYPE_EMIT(type) {((void)(struct type 
>>>>>> *)0);    \
>>>>>
>>>>> ((void)(struct type *)0); is new. Why is it needed?
>>>>
>>>> This is a trick of BTF to force compiler generate type info for
>>>> the given type. Without trick, compiler may skip these types if these
>>>> type are not used at all in the module.  For example, modules usually
>>>> don't use value types of struct_ops directly.
>>> It is not the value type and value type emit is understood. It is the 
>>> struct_ops type itself and it is new addition in this patchset 
>>> afaict. The value type emit is in the next line which was cut out 
>>> from the context here.
>>>
>> I mean both of them are required.
>> In the case of a dummy implementation, struct_ops type itself properly 
>> never being used, only being declared by the module. Without this line,
> 
> Other than bpf_dummy_ops, after reg(), the struct_ops->func() must be 
> used somewhere in the kernel or module. Like tcp must be using the 
> tcp_congestion_ops after reg(). bpf_dummy_ops is very special and 
> probably should be moved out to bpf_testmod somehow but this is for 
> later. Even bpf_dummy_ops does not have an issue now. Why it is needed 
> after the kmod support change?
> 
> or it is a preemptive addition to be future proof only?
> 
> Addition is fine if it is required to work. I am trying to understand 
> why this new addition is needed after the kmod support change. The 
> reason why this is needed after the kmod support change is not obvious 
> from looking at the code. The commit message didn't mention why and what 
> broke after this kmod change. If someone wants to clean it up a few 
> months later, we will need to figure out why it was added in the first 
> place.


It is a future proof.
What do you think if I add a comment in the code?

> 
> 
>> the module developer will fail to load a struct_ops map of the dummy
>> type. This line is added to avoid this awful situation.
>>
> 

