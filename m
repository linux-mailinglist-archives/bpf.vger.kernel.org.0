Return-Path: <bpf+bounces-13769-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 176777DD989
	for <lists+bpf@lfdr.de>; Wed,  1 Nov 2023 01:19:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4887FB20E65
	for <lists+bpf@lfdr.de>; Wed,  1 Nov 2023 00:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D31465F;
	Wed,  1 Nov 2023 00:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gmLMlp+l"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922AB7F;
	Wed,  1 Nov 2023 00:19:28 +0000 (UTC)
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 272C5120;
	Tue, 31 Oct 2023 17:19:27 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-5a877e0f0d8so3569737b3.1;
        Tue, 31 Oct 2023 17:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698797966; x=1699402766; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2mbwX2rM0aJnGLITPARud4KCFW3QDrLVzqaFVSs3V8o=;
        b=gmLMlp+lKrQUXIroZkU6HglSnxs9oVl4KNoM8MMFcFkrx9OV3gnzu4DkKWaGl6Bobv
         lkIV2+PYXmLOOleruyxlDwA5BzXM3G025tYsTnQHavbg1xkSaSs/8G2PkzVzHU0v6WEm
         n7FggQEvb12doxPbSGcDOWBR1A9Chpqfu/DRGXEzey6C00Px0G1w06hT3qMVxI2jBEZ0
         F2M6yIHtTOIk90o4f/nGXzbSXxv4izbflD0qs+K7c7ushr3MznpHF/XzI/5QjGZyZzmf
         cFG3cm+ZuV7yWTYsOf+5Pb3GV3GTmk6IzDYQi1uft3ZFokWYqpXGWI/Ew8WnXNDA582h
         E3qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698797966; x=1699402766;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2mbwX2rM0aJnGLITPARud4KCFW3QDrLVzqaFVSs3V8o=;
        b=l5KkbLmB+gPaXviw5S7dfnY/U3bV5TBxXSpG35lkhov24FqMeaCVsHO7QMKxglkAma
         DMo4SSbg+Y1ClSin1lpqfXDMJ4O8N8rQLUdBVZv4TR2dztRDKJcJyS9rR5kTaTxIzYQJ
         dOP9MT2kXfWXNyvw3MZ1KSAfB3FDSfOJYJHUbw4tDPVIxNsiWmiA+kfDrksiQl8gYMTH
         8XkjiVLeeiPA3dSClOJt+UTwZ5Jd460Iyouhs8TkO9lj/+QH91DcKLJUVlju+HvNlnzL
         7XNx9dlGiEaS9I8xha5kN5NqQr7JmgnKZrnVYfp9exRkDV2muQPsH3dpt+xZagdDA+vC
         63XA==
X-Gm-Message-State: AOJu0YzNZvJ7aOBJgwE5P69L1Hxx8y8nEYIKHTg1y81P0Lg48nrYbTDf
	kKcZ5gDzYs/aSLN9zzAp18Q=
X-Google-Smtp-Source: AGHT+IFxcod+uxXc7Mqx28g46M9wOL6AZzP0Zts/UPokeCkd113wn0i9AjQSdArD6Cn4Fc97ZH7lxQ==
X-Received: by 2002:a05:6902:11c1:b0:da3:b0f0:61f5 with SMTP id n1-20020a05690211c100b00da3b0f061f5mr825838ybu.6.1698797966315;
        Tue, 31 Oct 2023 17:19:26 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:ac50:f3c6:2a0c:d29? ([2600:1700:6cf8:1240:ac50:f3c6:2a0c:d29])
        by smtp.gmail.com with ESMTPSA id v134-20020a252f8c000000b00d9abce6acf2sm1427940ybv.59.2023.10.31.17.19.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Oct 2023 17:19:25 -0700 (PDT)
Message-ID: <9e2defb8-e43a-482c-8363-0447c55e497e@gmail.com>
Date: Tue, 31 Oct 2023 17:19:23 -0700
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
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <5a8520dd-0dd6-4d51-9e4a-6eebcf7e792d@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 10/31/23 17:02, Martin KaFai Lau wrote:
> On 10/31/23 4:34 PM, Kui-Feng Lee wrote:
>>>> diff --git a/include/linux/btf.h b/include/linux/btf.h
>>>> index a8813605f2f6..954536431e0b 100644
>>>> --- a/include/linux/btf.h
>>>> +++ b/include/linux/btf.h
>>>> @@ -12,6 +12,8 @@
>>>>   #include <uapi/linux/bpf.h>
>>>>   #define BTF_TYPE_EMIT(type) ((void)(type *)0)
>>>> +#define BTF_STRUCT_OPS_TYPE_EMIT(type) {((void)(struct type *)0);    \
>>>
>>> ((void)(struct type *)0); is new. Why is it needed?
>>
>> This is a trick of BTF to force compiler generate type info for
>> the given type. Without trick, compiler may skip these types if these
>> type are not used at all in the module.  For example, modules usually
>> don't use value types of struct_ops directly.
> It is not the value type and value type emit is understood. It is the 
> struct_ops type itself and it is new addition in this patchset afaict. 
> The value type emit is in the next line which was cut out from the 
> context here.
> 
I mean both of them are required.
In the case of a dummy implementation, struct_ops type itself properly 
never being used, only being declared by the module. Without this line,
the module developer will fail to load a struct_ops map of the dummy
type. This line is added to avoid this awful situation.


