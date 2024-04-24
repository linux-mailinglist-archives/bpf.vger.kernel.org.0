Return-Path: <bpf+bounces-27746-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ADEA8B1634
	for <lists+bpf@lfdr.de>; Thu, 25 Apr 2024 00:33:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E97B31F23B4B
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 22:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88F302942D;
	Wed, 24 Apr 2024 22:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HXRaaOEE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED8516EC0F
	for <bpf@vger.kernel.org>; Wed, 24 Apr 2024 22:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713997959; cv=none; b=cIly7X7FSXT0+i6H6gCy71XZBREoE9xZsWXVFty/eFkuloaoN+UYPRoeiDNIU56HagpDAxGDqxDkPLRZ7zcpif3iISlSxqIvdfaEN+9j1EKXBXTO4hmLBWIEDPNYovLsK9szbmgvuwRCjjmAAU5H7kp6J6cKAYY/fjxHPZQJTfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713997959; c=relaxed/simple;
	bh=AnN+RdXyA+OY5miNGV77ETsaQhlKjUwXnJx+QxIKiGc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SO/BUJ98pvZarWA7/+QTemLmzt2I4WhvUP9rPoRsENa0Jwy+Tw79ggTFKy+3g/5cjsSJSBogQwLCPHWqjcupWfyIUq8uEscR+RQ8cBpIxcESomQC5skci9QOd6rl6yPO2tzaFjmLSL6/n+pYwScAryYog0rtlvsUdepJ+5ycVAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HXRaaOEE; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-de55993cb6fso485624276.3
        for <bpf@vger.kernel.org>; Wed, 24 Apr 2024 15:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713997956; x=1714602756; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fiwbRKUDJRa5gE0WJLJtORJnErc3kOLShUSStr9Jmcg=;
        b=HXRaaOEET+XIXrbkiwBiWTEI0P2TkVDtq/OmI3gVsbTcdWIrdHLnwIClPUNxLl9qN9
         kwLtywS6TzoGiptlg39TrFecLhPQyhqNBQ3pD9tD+rxo//ztZeblElbvQAxOqdhyfjyn
         GLrLqIVzvVO/5BoTMVauXupxBqknvx7FVVWJt9O7NpEn0Dfl6/EhaMQSC3qKdK6/TD5t
         TvaMacRhBzoyfC+Aehzilh6YlIz787bYlUehJcrynN2iIzkjS8a1T0Q7m4nSEk4kpNSB
         Ycw2VtCaVPRbeWjpYusUPIia9MTsrm4kdS9xl2gShptCe1SjpdOlHl1MJZSFxBsWQfVe
         tgYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713997956; x=1714602756;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fiwbRKUDJRa5gE0WJLJtORJnErc3kOLShUSStr9Jmcg=;
        b=vZcGotGPAXtWCzVM+lF6INjQ7njNaIRxymZsTYjAZVGaRkYC3iLvABlCv6XkhhXVSX
         92FPMxmr+F2noy1BWQCeYhVrhvklKH3DnWaTONXnTRhdvuR1w8SeH5D8i3QfUyKdJCf3
         SNiaF9iqaS2RCnxF8gOKP5nTkjXbC6OrcwTSTwBQE7q02wnskgtIzDSBWn4l5KeS3ylj
         sPnnAaQC+JTUyeHtZWku00vii/Xi5E9FiRymPsp9NJY2o0wrqKBScnGU5FaftAdQhO2F
         AYwhPe44CSM51D174ps0Ln1KN+mwN0xKClC1PkvJGDq4yGlb2X0Q7cQo0HZ3FOBQ2K4Y
         WPyQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBI4fCUruPbmeOKpZhpUhLyf6vUZ61lB0Tt0X6C/8+uKB7u5K7j8TqcHLiRKqkCLrSE0gvHQliVmHwA2S2/SYu3kZM
X-Gm-Message-State: AOJu0YwGcTwkTXfP8XFXUrKN7XmDz8x/NHlKYQrleAt+btnwecT19VXa
	KThr2ePjzyiO4/yAgF0QQMZj14k07o7RSebalo0JHDDqHN3M2v/Y
X-Google-Smtp-Source: AGHT+IGmzgRe9rBeiUKD+EhpuUVxjNfZ/zxWK9N9tmtY7yVX/gHiG98yP/RyU40hDiCDLb4b5RpZSw==
X-Received: by 2002:a25:6914:0:b0:de5:5691:8c2b with SMTP id e20-20020a256914000000b00de556918c2bmr4567673ybc.17.1713997956259;
        Wed, 24 Apr 2024 15:32:36 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:b112:764b:184d:79d9? ([2600:1700:6cf8:1240:b112:764b:184d:79d9])
        by smtp.gmail.com with ESMTPSA id g9-20020a25ef09000000b00de558b96179sm1010690ybd.30.2024.04.24.15.32.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Apr 2024 15:32:35 -0700 (PDT)
Message-ID: <c00b8c69-deb6-414c-a7ed-7f4a3c1ab83b@gmail.com>
Date: Wed, 24 Apr 2024 15:32:34 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 00/11] Enable BPF programs to declare arrays
 of kptr, bpf_rb_root, and bpf_list_head.
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
Content-Language: en-US
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <CAADnVQJFtRwwGm=zEa=CgskY57gXPsG240FA66xZFBONqPTYTg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 4/24/24 13:09, Alexei Starovoitov wrote:
> On Mon, Apr 22, 2024 at 7:54 PM Kui-Feng Lee <sinquersw@gmail.com> wrote:
>>
>>
>>
>> On 4/22/24 19:45, Kui-Feng Lee wrote:
>>>
>>>
>>> On 4/18/24 07:53, Alexei Starovoitov wrote:
>>>> On Wed, Apr 17, 2024 at 11:07 PM Kui-Feng Lee <sinquersw@gmail.com>
>>>> wrote:
>>>>>
>>>>>
>>>>>
>>>>> On 4/17/24 22:11, Alexei Starovoitov wrote:
>>>>>> On Wed, Apr 17, 2024 at 9:31 PM Kui-Feng Lee <sinquersw@gmail.com>
>>>>>> wrote:
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> On 4/17/24 20:30, Alexei Starovoitov wrote:
>>>>>>>> On Fri, Apr 12, 2024 at 2:08 PM Kui-Feng Lee
>>>>>>>> <thinker.li@gmail.com> wrote:
>>>>>>>>>
>>>>>>>>> The arrays of kptr, bpf_rb_root, and bpf_list_head didn't work as
>>>>>>>>> global variables. This was due to these types being initialized and
>>>>>>>>> verified in a special manner in the kernel. This patchset allows BPF
>>>>>>>>> programs to declare arrays of kptr, bpf_rb_root, and
>>>>>>>>> bpf_list_head in
>>>>>>>>> the global namespace.
>>>>>>>>>
>>>>>>>>> The main change is to add "nelems" to btf_fields. The value of
>>>>>>>>> "nelems" represents the number of elements in the array if a
>>>>>>>>> btf_field
>>>>>>>>> represents an array. Otherwise, "nelem" will be 1. The verifier
>>>>>>>>> verifies these types based on the information provided by the
>>>>>>>>> btf_field.
>>>>>>>>>
>>>>>>>>> The value of "size" will be the size of the entire array if a
>>>>>>>>> btf_field represents an array. Dividing "size" by "nelems" gives the
>>>>>>>>> size of an element. The value of "offset" will be the offset of the
>>>>>>>>> beginning for an array. By putting this together, we can
>>>>>>>>> determine the
>>>>>>>>> offset of each element in an array. For example,
>>>>>>>>>
>>>>>>>>>         struct bpf_cpumask __kptr * global_mask_array[2];
>>>>>>>>
>>>>>>>> Looks like this patch set enables arrays only.
>>>>>>>> Meaning the following is supported already:
>>>>>>>>
>>>>>>>> +private(C) struct bpf_spin_lock glock_c;
>>>>>>>> +private(C) struct bpf_list_head ghead_array1 __contains(foo, node2);
>>>>>>>> +private(C) struct bpf_list_head ghead_array2 __contains(foo, node2);
>>>>>>>>
>>>>>>>> while this support is added:
>>>>>>>>
>>>>>>>> +private(C) struct bpf_spin_lock glock_c;
>>>>>>>> +private(C) struct bpf_list_head ghead_array1[3] __contains(foo,
>>>>>>>> node2);
>>>>>>>> +private(C) struct bpf_list_head ghead_array2[2] __contains(foo,
>>>>>>>> node2);
>>>>>>>>
>>>>>>>> Am I right?
>>>>>>>>
>>>>>>>> What about the case when bpf_list_head is wrapped in a struct?
>>>>>>>> private(C) struct foo {
>>>>>>>>       struct bpf_list_head ghead;
>>>>>>>> } ghead;
>>>>>>>>
>>>>>>>> that's not enabled in this patch. I think.
>>>>>>>>
>>>>>>>> And the following:
>>>>>>>> private(C) struct foo {
>>>>>>>>       struct bpf_list_head ghead;
>>>>>>>> } ghead[2];
>>>>>>>>
>>>>>>>>
>>>>>>>> or
>>>>>>>>
>>>>>>>> private(C) struct foo {
>>>>>>>>       struct bpf_list_head ghead[2];
>>>>>>>> } ghead;
>>>>>>>>
>>>>>>>> Won't work either.
>>>>>>>
>>>>>>> No, they don't work.
>>>>>>> We had a discussion about this in the other day.
>>>>>>> I proposed to have another patch set to work on struct types.
>>>>>>> Do you prefer to handle it in this patch set?
>>>>>>>
>>>>>>>>
>>>>>>>> I think eventually we want to support all such combinations and
>>>>>>>> the approach proposed in this patch with 'nelems'
>>>>>>>> won't work for wrapper structs.
>>>>>>>>
>>>>>>>> I think it's better to unroll/flatten all structs and arrays
>>>>>>>> and represent them as individual elements in the flattened
>>>>>>>> structure. Then there will be no need to special case array with
>>>>>>>> 'nelems'.
>>>>>>>> All special BTF types will be individual elements with unique offset.
>>>>>>>>
>>>>>>>> Does this make sense?
>>>>>>>
>>>>>>> That means it will creates 10 btf_field(s) for an array having 10
>>>>>>> elements. The purpose of adding "nelems" is to avoid the
>>>>>>> repetition. Do
>>>>>>> you prefer to expand them?
>>>>>>
>>>>>> It's not just expansion, but a common way to handle nested structs too.
>>>>>>
>>>>>> I suspect by delaying nested into another patchset this approach
>>>>>> will become useless.
>>>>>>
>>>>>> So try adding nested structs in all combinations as a follow up and
>>>>>> I suspect you're realize that "nelems" approach doesn't really help.
>>>>>> You'd need to flatten them all.
>>>>>> And once you do there is no need for "nelems".
>>>>>
>>>>> For me, "nelems" is more like a choice of avoiding repetition of
>>>>> information, not a necessary. Before adding "nelems", I had considered
>>>>> to expand them as well. But, eventually, I chose to add "nelems".
>>>>>
>>>>> Since you think this repetition is not a problem, I will expand array as
>>>>> individual elements.
>>>>
>>>> You don't sound convinced :)
>>>> Please add support for nested structs on top of your "nelems" approach
>>>> and prototype the same without "nelems" and let's compare the two.
>>>
>>>
>>> The following is the prototype that flatten arrays and struct types.
>>> This approach is definitely simpler than "nelems" one.  However,
>>> it will repeat same information as many times as the size of an array.
>>> For now, we have a limitation on the number of btf_fields (<= 10).
> 
> I understand the concern and desire to minimize duplication,
> but I don't see how this BPF_REPEAT_FIELDS approach is going to work.
>  From btf_parse_fields() pov it becomes one giant opaque field
> that sort_r() processes as a blob.
> 
> How
> btf_record_find(reg->map_ptr->record,
>                  off + reg->var_off.value, BPF_KPTR);
> 
> is going to find anything in there?
> Are you making a restriction that arrays and nested structs
> will only have kptrs in there ?
> So BPF_REPEAT_FIELDS can only wrap kptrs ?
> But even then these kptrs might have different btf_ids.
> So
> struct map_value {
>     struct {
>        struct task __kptr *p1;
>        struct thread __kptr *p2;
>     } arr[10];
> };
> 
> won't be able to be represented as BPF_REPEAT_FIELDS?


BPF_REPEAT_FIELDS can handle it. With this case, bpf_parse_fields() will 
create a list of btf_fields like this:

     [ btf_field(type=BPF_KPTR_..., offset=0, ...),
       btf_field(type=BPF_KPTR_..., offset=8, ...),
       btf_field(type=BPF_REPEAT_FIELDS, offset=16, repeated_fields=2, 
nelems=9, size=16)]

You might miss the explanation in [1].

btf_record_find() is still doing binary search. Looking for p2 in
obj->arr[1], the offset will be 24.  btf_record_find() will find the
BPF_REPEATED_FIELDS one, and redirect the offset to

   (field->offset - field->size + (16 - field->offset) % field->size) == 8

Then, it will return the btf_field whose offset is 8.


[1] 
https://lore.kernel.org/all/4d3dc24f-fb50-4674-8eec-4c38e4d4b2c1@gmail.com/

> 
> I think that simple flattening without repeat/nelems optimization
> is much easier to reason about.
> BTF_FIELDS_MAX is just a constant.
> Just don't do struct btf_field_info info_arr[BTF_FIELDS_MAX]; on stack.

I will switch to flatten one if you think "nelems" &
"BPF_REPEAT_FIELDS" are too complicated after reading the explanation in
[1].


