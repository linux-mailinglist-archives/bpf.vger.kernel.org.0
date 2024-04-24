Return-Path: <bpf+bounces-27749-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 149598B163F
	for <lists+bpf@lfdr.de>; Thu, 25 Apr 2024 00:36:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37CEC1C22696
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 22:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5329E16DEA5;
	Wed, 24 Apr 2024 22:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aW8xbx2K"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55CC42263E
	for <bpf@vger.kernel.org>; Wed, 24 Apr 2024 22:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713998177; cv=none; b=n6hRT5OWh6RqE/R2wesSqZrgtfO92FIQKHc72OoxWDGzh5g8FHibFE6VuitcODZbhYbr7F3EFCkSwfkwhSa0CfAYugsXmpJ8rhTzBppDU8l8+2qq77DofKk/8umMigT3T69O3iLhcwsb7RwjOXNq+iDefj2eP3tykEdLofPOxNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713998177; c=relaxed/simple;
	bh=0vp4eWr9HMm3MZPNM2sxEmcWZqw6k61NitVLYpdWpO0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=OW8WgUr0VaoDRdddWE/8a8ehe+F4cwjn9kdqPzkgHhNVyGki63ehQadNekQ7eeVMIQZTg9B4c0Cx4IwI3CK9xD4NLlRn8w1AKwuxbZKshttNZ+cRPSS0ZtOUASTIyhsbyYMsJy0sO0zs+el7F4EVMHelvjz9IxM3CxazzTWC35I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aW8xbx2K; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6184acc1ef3so3882127b3.0
        for <bpf@vger.kernel.org>; Wed, 24 Apr 2024 15:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713998175; x=1714602975; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xXerJ2oD8LL/YMYVJLteVKacUcgpUjeYiqTuP/sFX4o=;
        b=aW8xbx2KHQ5z4tulNHDclQqXoBfFvGtMOYAsvwW3jEVdJIcvDF8ZFJG1iOkccugBiR
         lYDD9x+N/oQGFGOhYIB7hpWOeie7mJZFQka7wmDVp9EuXtK8mO+YVZQQRe+6C3MuNr69
         klQvWuVdTHsfafBBBDtNdBCZk0Ftc+JHfsV/kgAy1UTU866dVkQq2bRxgxTIHyo3/D92
         ytAJ5VYjzs0/Vyisq1WVZVUl/3gul1EJNAFL4yperoF5mDmp+AcLcYPJytSj/5uHYG29
         ou+xujKahJLHBg+hZDEplZHX0lc3xuKOSGAzqeg32ay2BvD0MfoD1uerfccEZZuS5auk
         mi0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713998175; x=1714602975;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xXerJ2oD8LL/YMYVJLteVKacUcgpUjeYiqTuP/sFX4o=;
        b=J0NoL29Ih1P1ie5b9VdYoNVV6asb3rmp4Tz9HWox9qGr1Z1V0L7gAG85VwAdYJQUo9
         h2OPlvdiGPTzaLJmUUJmcA7HEJt8SQ7bzkkxRCZuqKfdZdBW1I49anfyuPwAbCL16kL2
         64GYg9BkVmFyl0lMxmKHbDi+VpSe/By19czjp7xEK0BrsMX1aH0MwMnKe1drgqe+vG7J
         5SbqtNnyP6bnhxHXGgj5msIA1arvrNs2IoXWF/OG6Z65WxrNwIR5osq/f1F4nz4YRe1E
         NcBUqRmWm+phA/znftLaRjPuLHheVqrsaohPUG5svzlV8/ZWV8U6mptQD5bgYHGdXNW0
         9BMA==
X-Forwarded-Encrypted: i=1; AJvYcCVxHH+P7zr6vJPR1F5ioAyN2qgA9BgYJhAkcIQJcAiQ5+Ol77XnGf6HpJiXs9ycJT/CdZUzBzkHyg4h9pvmjV8XMERQ
X-Gm-Message-State: AOJu0YyPFfFBqRdWDnF+vANELO2B3nl6bSOANgV+4AZ9Tz9ERCHrXNa7
	8QmmF/uh8h3ITzNaZJiOg8BpBs4Jdw1hTNa0FvtZc2hH5//6Rkqo
X-Google-Smtp-Source: AGHT+IFY7Rodx9TjSDEXLCwcm0+UDbYy4mtCbsWKPOndiTgct1GcfbmP+pJrUpaensPWf0Hiu25MJA==
X-Received: by 2002:a05:690c:7445:b0:614:74ba:f91c with SMTP id ju5-20020a05690c744500b0061474baf91cmr4537489ywb.19.1713998175158;
        Wed, 24 Apr 2024 15:36:15 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:b112:764b:184d:79d9? ([2600:1700:6cf8:1240:b112:764b:184d:79d9])
        by smtp.gmail.com with ESMTPSA id x30-20020a81af5e000000b0061b1f325755sm3220398ywj.123.2024.04.24.15.36.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Apr 2024 15:36:14 -0700 (PDT)
Message-ID: <a430fb54-0d8b-4e30-8e1d-f669a119ff3d@gmail.com>
Date: Wed, 24 Apr 2024 15:36:13 -0700
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
 <e314dcd1-b39f-4c3e-a470-10458d704ec0@gmail.com>
Content-Language: en-US
In-Reply-To: <e314dcd1-b39f-4c3e-a470-10458d704ec0@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 4/24/24 15:34, Kui-Feng Lee wrote:
> 
> 
> On 4/24/24 15:32, Kui-Feng Lee wrote:
>>
>>
>> On 4/24/24 13:09, Alexei Starovoitov wrote:
>>> On Mon, Apr 22, 2024 at 7:54 PM Kui-Feng Lee <sinquersw@gmail.com> 
>>> wrote:
>>>>
>>>>
>>>>
>>>> On 4/22/24 19:45, Kui-Feng Lee wrote:
>>>>>
>>>>>
>>>>> On 4/18/24 07:53, Alexei Starovoitov wrote:
>>>>>> On Wed, Apr 17, 2024 at 11:07 PM Kui-Feng Lee <sinquersw@gmail.com>
>>>>>> wrote:
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> On 4/17/24 22:11, Alexei Starovoitov wrote:
>>>>>>>> On Wed, Apr 17, 2024 at 9:31 PM Kui-Feng Lee <sinquersw@gmail.com>
>>>>>>>> wrote:
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> On 4/17/24 20:30, Alexei Starovoitov wrote:
>>>>>>>>>> On Fri, Apr 12, 2024 at 2:08 PM Kui-Feng Lee
>>>>>>>>>> <thinker.li@gmail.com> wrote:
>>>>>>>>>>>
>>>>>>>>>>> The arrays of kptr, bpf_rb_root, and bpf_list_head didn't 
>>>>>>>>>>> work as
>>>>>>>>>>> global variables. This was due to these types being 
>>>>>>>>>>> initialized and
>>>>>>>>>>> verified in a special manner in the kernel. This patchset 
>>>>>>>>>>> allows BPF
>>>>>>>>>>> programs to declare arrays of kptr, bpf_rb_root, and
>>>>>>>>>>> bpf_list_head in
>>>>>>>>>>> the global namespace.
>>>>>>>>>>>
>>>>>>>>>>> The main change is to add "nelems" to btf_fields. The value of
>>>>>>>>>>> "nelems" represents the number of elements in the array if a
>>>>>>>>>>> btf_field
>>>>>>>>>>> represents an array. Otherwise, "nelem" will be 1. The verifier
>>>>>>>>>>> verifies these types based on the information provided by the
>>>>>>>>>>> btf_field.
>>>>>>>>>>>
>>>>>>>>>>> The value of "size" will be the size of the entire array if a
>>>>>>>>>>> btf_field represents an array. Dividing "size" by "nelems" 
>>>>>>>>>>> gives the
>>>>>>>>>>> size of an element. The value of "offset" will be the offset 
>>>>>>>>>>> of the
>>>>>>>>>>> beginning for an array. By putting this together, we can
>>>>>>>>>>> determine the
>>>>>>>>>>> offset of each element in an array. For example,
>>>>>>>>>>>
>>>>>>>>>>>         struct bpf_cpumask __kptr * global_mask_array[2];
>>>>>>>>>>
>>>>>>>>>> Looks like this patch set enables arrays only.
>>>>>>>>>> Meaning the following is supported already:
>>>>>>>>>>
>>>>>>>>>> +private(C) struct bpf_spin_lock glock_c;
>>>>>>>>>> +private(C) struct bpf_list_head ghead_array1 __contains(foo, 
>>>>>>>>>> node2);
>>>>>>>>>> +private(C) struct bpf_list_head ghead_array2 __contains(foo, 
>>>>>>>>>> node2);
>>>>>>>>>>
>>>>>>>>>> while this support is added:
>>>>>>>>>>
>>>>>>>>>> +private(C) struct bpf_spin_lock glock_c;
>>>>>>>>>> +private(C) struct bpf_list_head ghead_array1[3] __contains(foo,
>>>>>>>>>> node2);
>>>>>>>>>> +private(C) struct bpf_list_head ghead_array2[2] __contains(foo,
>>>>>>>>>> node2);
>>>>>>>>>>
>>>>>>>>>> Am I right?
>>>>>>>>>>
>>>>>>>>>> What about the case when bpf_list_head is wrapped in a struct?
>>>>>>>>>> private(C) struct foo {
>>>>>>>>>>       struct bpf_list_head ghead;
>>>>>>>>>> } ghead;
>>>>>>>>>>
>>>>>>>>>> that's not enabled in this patch. I think.
>>>>>>>>>>
>>>>>>>>>> And the following:
>>>>>>>>>> private(C) struct foo {
>>>>>>>>>>       struct bpf_list_head ghead;
>>>>>>>>>> } ghead[2];
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> or
>>>>>>>>>>
>>>>>>>>>> private(C) struct foo {
>>>>>>>>>>       struct bpf_list_head ghead[2];
>>>>>>>>>> } ghead;
>>>>>>>>>>
>>>>>>>>>> Won't work either.
>>>>>>>>>
>>>>>>>>> No, they don't work.
>>>>>>>>> We had a discussion about this in the other day.
>>>>>>>>> I proposed to have another patch set to work on struct types.
>>>>>>>>> Do you prefer to handle it in this patch set?
>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> I think eventually we want to support all such combinations and
>>>>>>>>>> the approach proposed in this patch with 'nelems'
>>>>>>>>>> won't work for wrapper structs.
>>>>>>>>>>
>>>>>>>>>> I think it's better to unroll/flatten all structs and arrays
>>>>>>>>>> and represent them as individual elements in the flattened
>>>>>>>>>> structure. Then there will be no need to special case array with
>>>>>>>>>> 'nelems'.
>>>>>>>>>> All special BTF types will be individual elements with unique 
>>>>>>>>>> offset.
>>>>>>>>>>
>>>>>>>>>> Does this make sense?
>>>>>>>>>
>>>>>>>>> That means it will creates 10 btf_field(s) for an array having 10
>>>>>>>>> elements. The purpose of adding "nelems" is to avoid the
>>>>>>>>> repetition. Do
>>>>>>>>> you prefer to expand them?
>>>>>>>>
>>>>>>>> It's not just expansion, but a common way to handle nested 
>>>>>>>> structs too.
>>>>>>>>
>>>>>>>> I suspect by delaying nested into another patchset this approach
>>>>>>>> will become useless.
>>>>>>>>
>>>>>>>> So try adding nested structs in all combinations as a follow up and
>>>>>>>> I suspect you're realize that "nelems" approach doesn't really 
>>>>>>>> help.
>>>>>>>> You'd need to flatten them all.
>>>>>>>> And once you do there is no need for "nelems".
>>>>>>>
>>>>>>> For me, "nelems" is more like a choice of avoiding repetition of
>>>>>>> information, not a necessary. Before adding "nelems", I had 
>>>>>>> considered
>>>>>>> to expand them as well. But, eventually, I chose to add "nelems".
>>>>>>>
>>>>>>> Since you think this repetition is not a problem, I will expand 
>>>>>>> array as
>>>>>>> individual elements.
>>>>>>
>>>>>> You don't sound convinced :)
>>>>>> Please add support for nested structs on top of your "nelems" 
>>>>>> approach
>>>>>> and prototype the same without "nelems" and let's compare the two.
>>>>>
>>>>>
>>>>> The following is the prototype that flatten arrays and struct types.
>>>>> This approach is definitely simpler than "nelems" one.  However,
>>>>> it will repeat same information as many times as the size of an array.
>>>>> For now, we have a limitation on the number of btf_fields (<= 10).
>>>
>>> I understand the concern and desire to minimize duplication,
>>> but I don't see how this BPF_REPEAT_FIELDS approach is going to work.
>>>  From btf_parse_fields() pov it becomes one giant opaque field
>>> that sort_r() processes as a blob.
>>>
>>> How
>>> btf_record_find(reg->map_ptr->record,
>>>                  off + reg->var_off.value, BPF_KPTR);
>>>
>>> is going to find anything in there?
>>> Are you making a restriction that arrays and nested structs
>>> will only have kptrs in there ?
>>> So BPF_REPEAT_FIELDS can only wrap kptrs ?
>>> But even then these kptrs might have different btf_ids.
>>> So
>>> struct map_value {
>>>     struct {
>>>        struct task __kptr *p1;
>>>        struct thread __kptr *p2;
>>>     } arr[10];
>>> };
>>>
>>> won't be able to be represented as BPF_REPEAT_FIELDS?
>>
>>
>> BPF_REPEAT_FIELDS can handle it. With this case, bpf_parse_fields() 
>> will create a list of btf_fields like this:
>>
>>      [ btf_field(type=BPF_KPTR_..., offset=0, ...),
>>        btf_field(type=BPF_KPTR_..., offset=8, ...),
>>        btf_field(type=BPF_REPEAT_FIELDS, offset=16, repeated_fields=2, 
>> nelems=9, size=16)]
> 
>   An error here.  size should be 16 * 9.
> 
>>
>> You might miss the explanation in [1].
>>
>> btf_record_find() is still doing binary search. Looking for p2 in
>> obj->arr[1], the offset will be 24.  btf_record_find() will find the
>> BPF_REPEATED_FIELDS one, and redirect the offset to
>>
>>    (field->offset - field->size + (16 - field->offset) % field->size) 
                                       ^^^ should be 24
>> == 8
> 
> field->size should be replaced by (field->size / field->nelems).
> 
>>
>> Then, it will return the btf_field whose offset is 8.
>>
>>
>> [1] 
>> https://lore.kernel.org/all/4d3dc24f-fb50-4674-8eec-4c38e4d4b2c1@gmail.com/
>>
>>>
>>> I think that simple flattening without repeat/nelems optimization
>>> is much easier to reason about.
>>> BTF_FIELDS_MAX is just a constant.
>>> Just don't do struct btf_field_info info_arr[BTF_FIELDS_MAX]; on stack.
>>
>> I will switch to flatten one if you think "nelems" &
>> "BPF_REPEAT_FIELDS" are too complicated after reading the explanation in
>> [1].
>>

