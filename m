Return-Path: <bpf+bounces-27830-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70D368B273A
	for <lists+bpf@lfdr.de>; Thu, 25 Apr 2024 19:10:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27184287C05
	for <lists+bpf@lfdr.de>; Thu, 25 Apr 2024 17:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A136514D715;
	Thu, 25 Apr 2024 17:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EKxBxpfQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E2014D70C
	for <bpf@vger.kernel.org>; Thu, 25 Apr 2024 17:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714064999; cv=none; b=e0XeZdqbA6AYk3x5zCLG529JpKTNjmO0EjOxdw7S1GY6x7KlpiSqFrHinhxlQhQ/btc6M07qWoWyORfHSrLxCCU0Wiv5PWjyClyz1Ts3j44IJo1VRap5bFIa/l2eyWZL3D3ur7zbKuT4IfArQZE2O7Oz+8wuGpnX5DKMBByzKDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714064999; c=relaxed/simple;
	bh=uCe692/+x1s7G8H0/TiMaMq5fwyaOor7c5Xhj+G2U1Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RGp+/d240+Kjja95teyHPTdw5TPZOBmB9WzHca54AmvnbDGkjwbZIRc+WUpculUitxQfZ/RgExHN3ThRFwsx3UwMGyAe+dNjrDnN1MO2j/xjN3mWZqQZZ5k8yXPh/wYbFlfZqVZrpbQftsbbVU12SI/UxkEhc6VqcAq4BUVhFJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EKxBxpfQ; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-618769020bcso13852107b3.3
        for <bpf@vger.kernel.org>; Thu, 25 Apr 2024 10:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714064996; x=1714669796; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5dpOLhR6Oa/CBD+LAfidIjDe/2nk3wvd4vtrvQBfPZM=;
        b=EKxBxpfQxN5IJ1Enr9ZO6/dUR+46j+TW/K484zAUQR2qQSIYOZ7GE5KrOHtiMtW4G3
         xfPZBx+zTmVxdBz+6QNDYjc708EHA31g2wlxsJm1hAtJpHl0Pnf5jvzLxHfo7I4piQYM
         gXN8m+goRgx+IwRAlnKcU7OboM6IxMNVIt2ekDmiFDx6re5DuwmvVOpc/BPu17AoLZFR
         mXgCJK/ZU6bqIrzAVW4Yh2aWyOdO9FJhTnxDugTqDrRGLHarVX7a/MXxo7YZ43fEHQmv
         jlmGMvd1SjYeozv4/TjD7Uj7Gt2te5m7ABXgygNLw3rvSaNTgqXaZk6Izo37qOcOhsPR
         vPZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714064996; x=1714669796;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5dpOLhR6Oa/CBD+LAfidIjDe/2nk3wvd4vtrvQBfPZM=;
        b=oFkOHWBiq8gt5Pm0wBWpKtRsaD6dWsk6yBlP9tfpjuQdyam2sLdyci/DVF9Ajlq2nm
         jMiyATBog/A7lEZSNxUAfl2S6Tb8KfOMiYQMWwRfDA2zdUlNAbjlzAL8kDz99uyW2Ijs
         epWzwYPIsMe59DmRkMeTsEu3zCh0Sh6ZFOlTXbu3AkmuiLRk8lYCMJiGNx2GvRSBKGma
         cWIAdxIYrcd1Nphl3hvEmYqvqghT5Ocale0ckR5TbGmdC5lkZiTTSuqqVpGfkC386D/8
         +OUEjku4sTXJ/a6axZJCnHZB7IlTchC7saJGt+yAJw3b/yVlB8lZ51jbYsO1HDy92qLq
         c9+A==
X-Forwarded-Encrypted: i=1; AJvYcCW3qd+qhDmexxspjL2rJ6f0/c7yuoZ1gRyAHiOYZ6xUN3dWo1rlw9OpvW7cMn6DjSzdJlaU2KAWWoZjPkyC8nalkhSk
X-Gm-Message-State: AOJu0Yz7kyZJp8gKwewG8unnRstR3tGllcvnU3npzhLtfY4ol13UBop0
	Q0vWhND7bGXzHc7l2YGRfXTi/zS8BN7hkky2/mwFjZQ9cVmMVFrl
X-Google-Smtp-Source: AGHT+IFk6jtidq+Ql4uiSoiNmAvTJD8ZYqgbtvH2hocFon/o5Gs1eObnAAojbSDKlF66bttt9OiTuw==
X-Received: by 2002:a05:690c:6c08:b0:61a:d6ce:487a with SMTP id ir8-20020a05690c6c0800b0061ad6ce487amr105237ywb.19.1714064996451;
        Thu, 25 Apr 2024 10:09:56 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:ecc1:7924:c821:d1f5? ([2600:1700:6cf8:1240:ecc1:7924:c821:d1f5])
        by smtp.gmail.com with ESMTPSA id x192-20020a0dd5c9000000b0061b0cbb6938sm3662933ywd.83.2024.04.25.10.09.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Apr 2024 10:09:56 -0700 (PDT)
Message-ID: <1d6d9056-ce5c-467f-b914-7a38a32e0186@gmail.com>
Date: Thu, 25 Apr 2024 10:09:54 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 00/11] Enable BPF programs to declare arrays
 of kptr, bpf_rb_root, and bpf_list_head.
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>
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
 <CAEf4BzatWpnT6PM=7dz1S=G_kz1NP5S4nwD=Ka8aBXekBb-Beg@mail.gmail.com>
Content-Language: en-US
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <CAEf4BzatWpnT6PM=7dz1S=G_kz1NP5S4nwD=Ka8aBXekBb-Beg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 4/24/24 17:48, Andrii Nakryiko wrote:
> On Wed, Apr 24, 2024 at 1:09 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
>>
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
>>>>>>>>>> global variables. This was due to these types being initialized and
>>>>>>>>>> verified in a special manner in the kernel. This patchset allows BPF
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
>>>>>>>>>> btf_field represents an array. Dividing "size" by "nelems" gives the
>>>>>>>>>> size of an element. The value of "offset" will be the offset of the
>>>>>>>>>> beginning for an array. By putting this together, we can
>>>>>>>>>> determine the
>>>>>>>>>> offset of each element in an array. For example,
>>>>>>>>>>
>>>>>>>>>>         struct bpf_cpumask __kptr * global_mask_array[2];
>>>>>>>>>
>>>>>>>>> Looks like this patch set enables arrays only.
>>>>>>>>> Meaning the following is supported already:
>>>>>>>>>
>>>>>>>>> +private(C) struct bpf_spin_lock glock_c;
>>>>>>>>> +private(C) struct bpf_list_head ghead_array1 __contains(foo, node2);
>>>>>>>>> +private(C) struct bpf_list_head ghead_array2 __contains(foo, node2);
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
>>>>>>>>>       struct bpf_list_head ghead;
>>>>>>>>> } ghead;
>>>>>>>>>
>>>>>>>>> that's not enabled in this patch. I think.
>>>>>>>>>
>>>>>>>>> And the following:
>>>>>>>>> private(C) struct foo {
>>>>>>>>>       struct bpf_list_head ghead;
>>>>>>>>> } ghead[2];
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> or
>>>>>>>>>
>>>>>>>>> private(C) struct foo {
>>>>>>>>>       struct bpf_list_head ghead[2];
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
>>>>>>>>> All special BTF types will be individual elements with unique offset.
>>>>>>>>>
>>>>>>>>> Does this make sense?
>>>>>>>>
>>>>>>>> That means it will creates 10 btf_field(s) for an array having 10
>>>>>>>> elements. The purpose of adding "nelems" is to avoid the
>>>>>>>> repetition. Do
>>>>>>>> you prefer to expand them?
>>>>>>>
>>>>>>> It's not just expansion, but a common way to handle nested structs too.
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
>>>>>> information, not a necessary. Before adding "nelems", I had considered
>>>>>> to expand them as well. But, eventually, I chose to add "nelems".
>>>>>>
>>>>>> Since you think this repetition is not a problem, I will expand array as
>>>>>> individual elements.
>>>>>
>>>>> You don't sound convinced :)
>>>>> Please add support for nested structs on top of your "nelems" approach
>>>>> and prototype the same without "nelems" and let's compare the two.
>>>>
>>>>
>>>> The following is the prototype that flatten arrays and struct types.
>>>> This approach is definitely simpler than "nelems" one.  However,
>>>> it will repeat same information as many times as the size of an array.
>>>> For now, we have a limitation on the number of btf_fields (<= 10).
>>
>> I understand the concern and desire to minimize duplication,
>> but I don't see how this BPF_REPEAT_FIELDS approach is going to work.
>>  From btf_parse_fields() pov it becomes one giant opaque field
>> that sort_r() processes as a blob.
>>
>> How
>> btf_record_find(reg->map_ptr->record,
>>                  off + reg->var_off.value, BPF_KPTR);
>>
>> is going to find anything in there?
>> Are you making a restriction that arrays and nested structs
>> will only have kptrs in there ?
>> So BPF_REPEAT_FIELDS can only wrap kptrs ?
>> But even then these kptrs might have different btf_ids.
>> So
>> struct map_value {
>>     struct {
>>        struct task __kptr *p1;
>>        struct thread __kptr *p2;
>>     } arr[10];
>> };
>>
>> won't be able to be represented as BPF_REPEAT_FIELDS?
>>
>> I think that simple flattening without repeat/nelems optimization
>> is much easier to reason about.
> 
> +100 to this, BPF_REPEAT_FIELDS just will add an extra layer of
> cognitive overload. Even if it can handle all conceivable situations,
> let's just have a list of all "unique fields". We already do dynamic
> memory allocation for struct btf_record, one more or less doesn't
> matter all that much. We seem to be doing this once per map, not per
> instruction or per state.
> 
> Let's keep it simple.
> 


Thank you for the feedback.
I will move to the flatten approach.

>> BTF_FIELDS_MAX is just a constant.
>> Just don't do struct btf_field_info info_arr[BTF_FIELDS_MAX]; on stack.

