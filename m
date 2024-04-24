Return-Path: <bpf+bounces-27747-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EFA598B163C
	for <lists+bpf@lfdr.de>; Thu, 25 Apr 2024 00:34:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6533B1F23DAC
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 22:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEBEE16E89C;
	Wed, 24 Apr 2024 22:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Aa/uqIR5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82B116E878
	for <bpf@vger.kernel.org>; Wed, 24 Apr 2024 22:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713998073; cv=none; b=pDePDH3Lb+W64TpY/PWbigkvcTeS6CgFglbSa5fjXmLG/iPHXLGRrJYbDPjAil6tK0sWcBc082atKB46TU0K2CxgR3XAdkP/XfN9oQ0cV0i6e6jcTRmYqUIgGR48snn0DA2qODkFEuHwrZ71nym2jPFfdo4sh5XTRAtcLObEfOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713998073; c=relaxed/simple;
	bh=CWsLDU2fssLLh+YBnoJeaK3O770w3pg/2lVzfeMXutI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=kJxzYUwV5xFkqDM4BsSNcIwGC4ezM6Zeynn/jUh9N5bf6Ve5JR0Qe+ksa+1kMnxksBug6HtrZCL9cHtRL9FlohfiPYQ8DBw3zQHAetRtUQWz3iTQNW2itFJQAS4aYt1B5w4XwrPcJzKz/hWWEK19AOEFkVvWEoJ5QSu7psXShJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Aa/uqIR5; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6184acc1ef3so3870077b3.0
        for <bpf@vger.kernel.org>; Wed, 24 Apr 2024 15:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713998071; x=1714602871; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=T/dNM5LZdzNk0b1Un5n8z7q5eht412B4yhTSj6UbM1c=;
        b=Aa/uqIR5xGiW8iMhCwIdfK1N9efv+EfyPV0CHeSDjZQuvZX+t2QKhxkzqsU9xpveYT
         5g+NhZ+thRwVS4jPEpRBfSoEJj8AS4OE0Ar9ti1wrPrIJoAG+/5yBYYeMh4Ruh3ih5B5
         rXF1OP8U8h1PSnq5ffPCU0lwL5W4egIwweNUkyhoBgbw73QFSauj4t/Od4oaxVHqqpqb
         yqVCK40YWmB1xbyIxIdQwijlQmGe/8u6gD2WsZF/d6B6sSJjS4fa3bXWjKqRIZfBs+Xd
         QccVxtdjLGfRM2R+bOIZzpUoaLpf6O51miRt2bB8v2JrWpzCmrgcHxhtHRJX4rnLOWHV
         CmwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713998071; x=1714602871;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T/dNM5LZdzNk0b1Un5n8z7q5eht412B4yhTSj6UbM1c=;
        b=QimElvcU2zZ1ilQnjSE3i8btD5BUuvCvT2DA9vXM/OoMt0LW8qdQvE8Q1rFbOjy7M6
         RRMifhD9nAXuILvV4F4WQe7pobZdNTbJy+CGKTAy9EfRCzG1dhF4LYTjX6LSjowgl29J
         DnYvg2IKkBLEvckgfa40p3jyRGnJzDyEy3IIU6/vvSeYHoKFPG8NQppbzWakNQ+JyWsy
         qY2GsnPZF3/zDB7LlG+9ijj9rNJH5vBkzX5P72BvG4Lw72PNvDbI56oCGccIEA0Hp9dQ
         +cHwiLRDy8g9vKFRxwuy165jqFRsAoF8Ch517Y64FM31jTrVzdIuCncURqn3yiCMfoeb
         vqCg==
X-Forwarded-Encrypted: i=1; AJvYcCXwmqxU20PkCso/5RkltrlSzFna1QuxqdkGq0/A72UcfyB9u1q7+RfLDPH2J4XzuY6NQ65/HCkERPKCu6as2rA/OyeG
X-Gm-Message-State: AOJu0YzOJ1f66u25iaFCLnd6qPcOGoF1kt5M1In2Aj+u6QGO1oPqqAZP
	mqNkguWX6FGRXhT/KiuQfKNcF9xXtUKDr2GNsx9HFzWiHYxm4w+a
X-Google-Smtp-Source: AGHT+IG7ibpPW30OTwS3tVprp8hsrX05tZUnVIlc9h0Np57DPGVxpg7xohU+99504wuRcg6W2rtdjQ==
X-Received: by 2002:a05:690c:6281:b0:61a:e2f8:f7ca with SMTP id hm1-20020a05690c628100b0061ae2f8f7camr5602152ywb.21.1713998070624;
        Wed, 24 Apr 2024 15:34:30 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:b112:764b:184d:79d9? ([2600:1700:6cf8:1240:b112:764b:184d:79d9])
        by smtp.gmail.com with ESMTPSA id k15-20020a81ed0f000000b006167f45edf9sm3193194ywm.89.2024.04.24.15.34.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Apr 2024 15:34:30 -0700 (PDT)
Message-ID: <e314dcd1-b39f-4c3e-a470-10458d704ec0@gmail.com>
Date: Wed, 24 Apr 2024 15:34:28 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 00/11] Enable BPF programs to declare arrays
 of kptr, bpf_rb_root, and bpf_list_head.
From: Kui-Feng Lee <sinquersw@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Kui-Feng Lee <thinker.li@gmail.com>, bpf <bpf@vger.kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Kernel Team <kernel-team@meta.com>, Andrii Nakryiko <andrii@kernel.org>,
 Kui-Feng Lee <kuifeng@meta.com>
References: <20240412210814.603377-1-thinker.li@gmail.com>
 <CAADnVQKP4HESABxxjKXqkyAEC4i_yP7_CT+L=+vzOhnMr5LiXg@mail.gmail.com>
 <1ce45df0-4471-4c0c-b37e-3e51b77fa5b5@gmail.com>
 <CAADnVQKjGFdiy4nYTsbfH5rm7T9gt_VhHd3R+0s4yS9eqTtSaA@mail.gmail.com>
 <6d25660d-103a-4541-977f-525bd2d38cd0@gmail.com>
 <CAADnVQ+hGv0oVx4_uPs2yr=vWC80OEEXLm_FcZLBfsthu0yFbA@mail.gmail.com>
 <57b4d1ca-a444-4e28-9c22-9b81c352b4cb@gmail.com>
 <90652139-f541-4a99-837e-e5857c901f61@gmail.com>
 <CAADnVQJFtRwwGm=zEa=CgskY57gXPsG240FA66xZFBONqPTYTg@mail.gmail.com>
 <c00b8c69-deb6-414c-a7ed-7f4a3c1ab83b@gmail.com>
Content-Language: en-US
In-Reply-To: <c00b8c69-deb6-414c-a7ed-7f4a3c1ab83b@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 4/24/24 15:32, Kui-Feng Lee wrote:
> 
> 
> On 4/24/24 13:09, Alexei Starovoitov wrote:
>> On Mon, Apr 22, 2024 at 7:54 PM Kui-Feng Lee <sinquersw@gmail.com> wrote:
>>>
>>>
>>>
>>> On 4/22/24 19:45, Kui-Feng Lee wrote:
>>>>
>>>>
>>>> On 4/18/24 07:53, Alexei Starovoitov wrote:
>>>>> On Wed, Apr 17, 2024 at 11:07 PM Kui-Feng Lee <sinquersw@gmail.com>
>>>>> wrote:
>>>>>>
>>>>>>
>>>>>>
>>>>>> On 4/17/24 22:11, Alexei Starovoitov wrote:
>>>>>>> On Wed, Apr 17, 2024 at 9:31 PM Kui-Feng Lee <sinquersw@gmail.com>
>>>>>>> wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>> On 4/17/24 20:30, Alexei Starovoitov wrote:
>>>>>>>>> On Fri, Apr 12, 2024 at 2:08 PM Kui-Feng Lee
>>>>>>>>> <thinker.li@gmail.com> wrote:
>>>>>>>>>>
>>>>>>>>>> The arrays of kptr, bpf_rb_root, and bpf_list_head didn't work as
>>>>>>>>>> global variables. This was due to these types being 
>>>>>>>>>> initialized and
>>>>>>>>>> verified in a special manner in the kernel. This patchset 
>>>>>>>>>> allows BPF
>>>>>>>>>> programs to declare arrays of kptr, bpf_rb_root, and
>>>>>>>>>> bpf_list_head in
>>>>>>>>>> the global namespace.
>>>>>>>>>>
>>>>>>>>>> The main change is to add "nelems" to btf_fields. The value of
>>>>>>>>>> "nelems" represents the number of elements in the array if a
>>>>>>>>>> btf_field
>>>>>>>>>> represents an array. Otherwise, "nelem" will be 1. The verifier
>>>>>>>>>> verifies these types based on the information provided by the
>>>>>>>>>> btf_field.
>>>>>>>>>>
>>>>>>>>>> The value of "size" will be the size of the entire array if a
>>>>>>>>>> btf_field represents an array. Dividing "size" by "nelems" 
>>>>>>>>>> gives the
>>>>>>>>>> size of an element. The value of "offset" will be the offset 
>>>>>>>>>> of the
>>>>>>>>>> beginning for an array. By putting this together, we can
>>>>>>>>>> determine the
>>>>>>>>>> offset of each element in an array. For example,
>>>>>>>>>>
>>>>>>>>>>         struct bpf_cpumask __kptr * global_mask_array[2];
>>>>>>>>>
>>>>>>>>> Looks like this patch set enables arrays only.
>>>>>>>>> Meaning the following is supported already:
>>>>>>>>>
>>>>>>>>> +private(C) struct bpf_spin_lock glock_c;
>>>>>>>>> +private(C) struct bpf_list_head ghead_array1 __contains(foo, 
>>>>>>>>> node2);
>>>>>>>>> +private(C) struct bpf_list_head ghead_array2 __contains(foo, 
>>>>>>>>> node2);
>>>>>>>>>
>>>>>>>>> while this support is added:
>>>>>>>>>
>>>>>>>>> +private(C) struct bpf_spin_lock glock_c;
>>>>>>>>> +private(C) struct bpf_list_head ghead_array1[3] __contains(foo,
>>>>>>>>> node2);
>>>>>>>>> +private(C) struct bpf_list_head ghead_array2[2] __contains(foo,
>>>>>>>>> node2);
>>>>>>>>>
>>>>>>>>> Am I right?
>>>>>>>>>
>>>>>>>>> What about the case when bpf_list_head is wrapped in a struct?
>>>>>>>>> private(C) struct foo {
>>>>>>>>>       struct bpf_list_head ghead;
>>>>>>>>> } ghead;
>>>>>>>>>
>>>>>>>>> that's not enabled in this patch. I think.
>>>>>>>>>
>>>>>>>>> And the following:
>>>>>>>>> private(C) struct foo {
>>>>>>>>>       struct bpf_list_head ghead;
>>>>>>>>> } ghead[2];
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> or
>>>>>>>>>
>>>>>>>>> private(C) struct foo {
>>>>>>>>>       struct bpf_list_head ghead[2];
>>>>>>>>> } ghead;
>>>>>>>>>
>>>>>>>>> Won't work either.
>>>>>>>>
>>>>>>>> No, they don't work.
>>>>>>>> We had a discussion about this in the other day.
>>>>>>>> I proposed to have another patch set to work on struct types.
>>>>>>>> Do you prefer to handle it in this patch set?
>>>>>>>>
>>>>>>>>>
>>>>>>>>> I think eventually we want to support all such combinations and
>>>>>>>>> the approach proposed in this patch with 'nelems'
>>>>>>>>> won't work for wrapper structs.
>>>>>>>>>
>>>>>>>>> I think it's better to unroll/flatten all structs and arrays
>>>>>>>>> and represent them as individual elements in the flattened
>>>>>>>>> structure. Then there will be no need to special case array with
>>>>>>>>> 'nelems'.
>>>>>>>>> All special BTF types will be individual elements with unique 
>>>>>>>>> offset.
>>>>>>>>>
>>>>>>>>> Does this make sense?
>>>>>>>>
>>>>>>>> That means it will creates 10 btf_field(s) for an array having 10
>>>>>>>> elements. The purpose of adding "nelems" is to avoid the
>>>>>>>> repetition. Do
>>>>>>>> you prefer to expand them?
>>>>>>>
>>>>>>> It's not just expansion, but a common way to handle nested 
>>>>>>> structs too.
>>>>>>>
>>>>>>> I suspect by delaying nested into another patchset this approach
>>>>>>> will become useless.
>>>>>>>
>>>>>>> So try adding nested structs in all combinations as a follow up and
>>>>>>> I suspect you're realize that "nelems" approach doesn't really help.
>>>>>>> You'd need to flatten them all.
>>>>>>> And once you do there is no need for "nelems".
>>>>>>
>>>>>> For me, "nelems" is more like a choice of avoiding repetition of
>>>>>> information, not a necessary. Before adding "nelems", I had 
>>>>>> considered
>>>>>> to expand them as well. But, eventually, I chose to add "nelems".
>>>>>>
>>>>>> Since you think this repetition is not a problem, I will expand 
>>>>>> array as
>>>>>> individual elements.
>>>>>
>>>>> You don't sound convinced :)
>>>>> Please add support for nested structs on top of your "nelems" approach
>>>>> and prototype the same without "nelems" and let's compare the two.
>>>>
>>>>
>>>> The following is the prototype that flatten arrays and struct types.
>>>> This approach is definitely simpler than "nelems" one.  However,
>>>> it will repeat same information as many times as the size of an array.
>>>> For now, we have a limitation on the number of btf_fields (<= 10).
>>
>> I understand the concern and desire to minimize duplication,
>> but I don't see how this BPF_REPEAT_FIELDS approach is going to work.
>>  From btf_parse_fields() pov it becomes one giant opaque field
>> that sort_r() processes as a blob.
>>
>> How
>> btf_record_find(reg->map_ptr->record,
>>                  off + reg->var_off.value, BPF_KPTR);
>>
>> is going to find anything in there?
>> Are you making a restriction that arrays and nested structs
>> will only have kptrs in there ?
>> So BPF_REPEAT_FIELDS can only wrap kptrs ?
>> But even then these kptrs might have different btf_ids.
>> So
>> struct map_value {
>>     struct {
>>        struct task __kptr *p1;
>>        struct thread __kptr *p2;
>>     } arr[10];
>> };
>>
>> won't be able to be represented as BPF_REPEAT_FIELDS?
> 
> 
> BPF_REPEAT_FIELDS can handle it. With this case, bpf_parse_fields() will 
> create a list of btf_fields like this:
> 
>      [ btf_field(type=BPF_KPTR_..., offset=0, ...),
>        btf_field(type=BPF_KPTR_..., offset=8, ...),
>        btf_field(type=BPF_REPEAT_FIELDS, offset=16, repeated_fields=2, 
> nelems=9, size=16)]

  An error here.  size should be 16 * 9.

> 
> You might miss the explanation in [1].
> 
> btf_record_find() is still doing binary search. Looking for p2 in
> obj->arr[1], the offset will be 24.  btf_record_find() will find the
> BPF_REPEATED_FIELDS one, and redirect the offset to
> 
>    (field->offset - field->size + (16 - field->offset) % field->size) == 8

field->size should be replaced by (field->size / field->nelems).

> 
> Then, it will return the btf_field whose offset is 8.
> 
> 
> [1] 
> https://lore.kernel.org/all/4d3dc24f-fb50-4674-8eec-4c38e4d4b2c1@gmail.com/
> 
>>
>> I think that simple flattening without repeat/nelems optimization
>> is much easier to reason about.
>> BTF_FIELDS_MAX is just a constant.
>> Just don't do struct btf_field_info info_arr[BTF_FIELDS_MAX]; on stack.
> 
> I will switch to flatten one if you think "nelems" &
> "BPF_REPEAT_FIELDS" are too complicated after reading the explanation in
> [1].
> 

