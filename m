Return-Path: <bpf+bounces-13905-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5702E7DEBBD
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 05:19:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93BBDB2121C
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 04:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72DBA1C35;
	Thu,  2 Nov 2023 04:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TKbhKGwM"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A541860;
	Thu,  2 Nov 2023 04:19:46 +0000 (UTC)
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED5DD121;
	Wed,  1 Nov 2023 21:19:40 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-5a822f96aedso6310397b3.2;
        Wed, 01 Nov 2023 21:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698898780; x=1699503580; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M9Gxt1h48lKZ1rLwMQIIGfMgYauSsW3fTROZdY6jY90=;
        b=TKbhKGwMWFgddKgWpICuQKyr+XidQoDQTKtgBr6qCnUiwS1kJvU1hbFOY0oJCrydB9
         vVDWYLK7TYkfCNorl4Hp/4kGMSdFYgWm0umSToxJvfGzJZ668l2YrlQhm9clLTdB8GhX
         9sJQ26kF33IXZBZNZwDBVrYLsCmh9/AOv3i1LOR4s8GjgrTgDDCQ99s07ocUQTbT8gGZ
         q3MEy28MqGQM96ZlZOV3G0EB901zoiYUczox1xOlJpDRGr8mv9O/chQsL4Ud4jdLwBZF
         CKvadmgZHG5X6nghpnQkcqF/5bwuOmwV4+2L5yht9bC+tNhcnNZnOyTBHQHu+t8bJvT9
         slYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698898780; x=1699503580;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M9Gxt1h48lKZ1rLwMQIIGfMgYauSsW3fTROZdY6jY90=;
        b=tB4lQu0c2F3ellYDe+gNCVaEvj8LYG5SGFOYWRjXzc6qCJChzxBIjWLOPqGEMTH6Jv
         qIxQj+V3eLVXQOwCAMoLlmMXA5/Y59rzR43ufKUZWjyrdGj+VP0O7RfyoNhhTr9zJF5I
         +SAbj/Fo7ZIjkFvUPa7VhcmgrkvAOndteZumYSvHaxAbKg04ZJdWzK7Ev6tf97Xki6Tg
         twmJpALeeM01YFXHjdp+2EtYJCFgXfiPf3avde5zdIrvE6t0T/rMQj3zfHE1HAZQsXAk
         BLYwpMhRm5SUXAPCWxVYU7jrKuMF2xRAnTE5UDc2kqzTTOPOB0eFREONh9j61xFJoa3C
         IS5Q==
X-Gm-Message-State: AOJu0YxZebK8OtI+YeAXnDnDUmiP9mvUPUioG4H9EHtfkBOGQtjPU1fK
	a2QWiHmXu3rrUpd/ZAkJNzo=
X-Google-Smtp-Source: AGHT+IE//bkC9M9EKMrJAtjfDXAaSy/O0f9WnvzgG9VfAxdFKlSwT8j0pBYDqHAsS6bewygdZkU5Yw==
X-Received: by 2002:a81:b10a:0:b0:5a7:a81b:d9af with SMTP id p10-20020a81b10a000000b005a7a81bd9afmr16826848ywh.7.1698898779990;
        Wed, 01 Nov 2023 21:19:39 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:ba42:cd04:2f52:d854? ([2600:1700:6cf8:1240:ba42:cd04:2f52:d854])
        by smtp.gmail.com with ESMTPSA id e3-20020a816903000000b0058427045833sm790678ywc.133.2023.11.01.21.19.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Nov 2023 21:19:39 -0700 (PDT)
Message-ID: <4a7d22ed-e34f-4e75-a796-8d2744b6c62e@gmail.com>
Date: Wed, 1 Nov 2023 21:19:38 -0700
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
 <c4427a57-aea9-4acc-a6be-e30cfb1dbaad@gmail.com>
 <22051390-2331-ad11-406b-1e5c6dbcd6a2@linux.dev>
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <22051390-2331-ad11-406b-1e5c6dbcd6a2@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 11/1/23 18:32, Martin KaFai Lau wrote:
> On 11/1/23 5:59 PM, Kui-Feng Lee wrote:
>>
>>
>> On 11/1/23 17:17, Martin KaFai Lau wrote:
>>> On 10/31/23 5:19 PM, Kui-Feng Lee wrote:
>>>>
>>>>
>>>> On 10/31/23 17:02, Martin KaFai Lau wrote:
>>>>> On 10/31/23 4:34 PM, Kui-Feng Lee wrote:
>>>>>>>> diff --git a/include/linux/btf.h b/include/linux/btf.h
>>>>>>>> index a8813605f2f6..954536431e0b 100644
>>>>>>>> --- a/include/linux/btf.h
>>>>>>>> +++ b/include/linux/btf.h
>>>>>>>> @@ -12,6 +12,8 @@
>>>>>>>>   #include <uapi/linux/bpf.h>
>>>>>>>>   #define BTF_TYPE_EMIT(type) ((void)(type *)0)
>>>>>>>> +#define BTF_STRUCT_OPS_TYPE_EMIT(type) {((void)(struct type 
>>>>>>>> *)0);    \
>>>>>>>
>>>>>>> ((void)(struct type *)0); is new. Why is it needed?
>>>>>>
>>>>>> This is a trick of BTF to force compiler generate type info for
>>>>>> the given type. Without trick, compiler may skip these types if these
>>>>>> type are not used at all in the module.  For example, modules usually
>>>>>> don't use value types of struct_ops directly.
>>>>> It is not the value type and value type emit is understood. It is 
>>>>> the struct_ops type itself and it is new addition in this patchset 
>>>>> afaict. The value type emit is in the next line which was cut out 
>>>>> from the context here.
>>>>>
>>>> I mean both of them are required.
>>>> In the case of a dummy implementation, struct_ops type itself 
>>>> properly never being used, only being declared by the module. 
>>>> Without this line,
>>>
>>> Other than bpf_dummy_ops, after reg(), the struct_ops->func() must be 
>>> used somewhere in the kernel or module. Like tcp must be using the 
>>> tcp_congestion_ops after reg(). bpf_dummy_ops is very special and 
>>> probably should be moved out to bpf_testmod somehow but this is for 
>>> later. Even bpf_dummy_ops does not have an issue now. Why it is 
>>> needed after the kmod support change?
>>>
>>> or it is a preemptive addition to be future proof only?
>>>
>>> Addition is fine if it is required to work. I am trying to understand 
>>> why this new addition is needed after the kmod support change. The 
>>> reason why this is needed after the kmod support change is not 
>>> obvious from looking at the code. The commit message didn't mention 
>>> why and what broke after this kmod change. If someone wants to clean 
>>> it up a few months later, we will need to figure out why it was added 
>>> in the first place.
>>
>>
>> It is a future proof.
>> What do you think if I add a comment in the code?
> 
> If it is not required to work, I prefer not adding it to avoid confusion 
> and avoid future cleanup temptation. Even the artificial bpf_dummy_ops 
> does not need it, so not enough reason to introduce this code redundancy.

Got it!

> 
> Switch topic.
> While we are on a new macro topic, I think a new macro will be useful to 
> emit the value type and register_bpf_struct_ops together. wdyt?

Like this?

#define REGISTER_STRUCT_OPS(st_type, st_ops) { \
         BTF_STRUCT_OPS_TYPE_EMIT(st_type);  \
         register_bpf_struct_ops(st_ops); } while(0)

static int bpf_testmod_init(void) {
     ....
     REGISTER_STRUCT_OPS(bpf_testmod_ops, &bpf_bpf_testmod_ops);
     ....
}

or you like something more aggressive

#define REGISTER_STRUCT_OPS(st_type) { \
         BTF_STRUCT_OPS_TYPE_EMIT(st_type);  \
         register_bpf_struct_ops(&bpf_##st_type); } while(0)




> 
>>
>>>
>>>
>>>> the module developer will fail to load a struct_ops map of the dummy
>>>> type. This line is added to avoid this awful situation.
>>>>
>>>
> 

