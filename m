Return-Path: <bpf+bounces-27154-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5FD88AA203
	for <lists+bpf@lfdr.de>; Thu, 18 Apr 2024 20:28:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E82811C21457
	for <lists+bpf@lfdr.de>; Thu, 18 Apr 2024 18:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DA4317A938;
	Thu, 18 Apr 2024 18:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wx9cs3Dx"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7C216D30B
	for <bpf@vger.kernel.org>; Thu, 18 Apr 2024 18:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713464882; cv=none; b=teqDFY+IxyPEmJnO5NDf6M/8H7FgNnDuscMQWsWfIQ6jzlFtu4fmIGIED8etqrb+5TkY20Hj+QqH1/Xhet7lGTRQcoif/T6M+SLQncUcr4eZIoY99pLeo6ym/urfZTjv/KRdNDnYDbsrVLxe7nXuXqdZ2EdYCTcjFBGxrN2u79c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713464882; c=relaxed/simple;
	bh=IwokBc87ZlGFpY5OqAG8+Y51E88XR75DtbiN+Q029Qg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mQhTtYQj8w7OANatxnaph7G30u8obLvr+CaToBV4gvUL4snWRBWOGzyvHpYVMN7J2mzec99cz+9hk5a6g6yT2JPzB8ytE7p4Ct0Ijr6XOh7k5EpybRMGpWawt1ZAsyxwwQ3x/rd0Q94o1iEqt1Fs6FwKFOmv/mG+azVaRH8Me74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wx9cs3Dx; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5aa3af24775so726511eaf.0
        for <bpf@vger.kernel.org>; Thu, 18 Apr 2024 11:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713464880; x=1714069680; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LBu9odGEyDHkUyYE1SQk+8E0412G4gn3OZyJWacd6ek=;
        b=Wx9cs3DxN5bo7Gr5jSFJTt/GaGE4YhvW4zhWMC5IFtBfzGtWwcjLVruiHfO4O0XFeB
         CxC6tkspwv43VrntuWnYjXbAV2P96dAvPmQuLIzLy5mrK8uHbjbiDPuZc8pm+QKHvTMK
         AVe/RK/7mSPcXNZL5gt16C4Pi+kak9zVlbLZ7lozbZswBl58Pzb9cqBUiREagOHb537b
         AYm3oeORbz60S4yFiL9cue8A7DLN8i6o4pa20iSuwe6tepgw+YORNoNJclK8DG4Fi6wv
         Ne3FSpSf7zpZzxCO31IfLzR952V2nOSrow+VqrEGKGGZLVQuX1SIXgppRGmQ/aDTi1xN
         InGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713464880; x=1714069680;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LBu9odGEyDHkUyYE1SQk+8E0412G4gn3OZyJWacd6ek=;
        b=uEQ4wsbQBakC/aWe4M6dDyoi8E004m2MEvPLj0+8lsf2lb/b8/j/LDbZnccFcAa89L
         /GEFvKugDtw75BLkOmT4p06w5jRJPCBmHAhOfhpS6A+ZItDwDZ5ewjIcxx118Nxkb9R/
         F3CaE5YqmPlwn1f8qgzsgEThNWJwA1I/yiVtklT8+E8z/jq7CcWR1dhr9Cv305XKnHxL
         3F4VP//kCXwNaR6o19vQzLoj8ejF+1DJwoG8fyQcAyKjbjgiidqTXLnkgZjeJTT3pfJ/
         ugZN4O5dzk8xQZ8asKMswBHmuoaIKY5Lbdlgzc7ce8MMTJyHOX1pk3Q87Xbk43etcBzq
         6rTg==
X-Forwarded-Encrypted: i=1; AJvYcCUd40HkddQprDJvOn+RzThawONlNMypAi5qE7Xk+2w7wzKDT5idTobMPg1qz8QyU3vlxH35y0G3NbJYEWqqNXf8dRj9
X-Gm-Message-State: AOJu0Ywf839679/TdkRlfUT9XeBFuP7OQP1/FJmTmktsPfkH1RcM8Inm
	AUZZw1ds27WsZjgZAEZFs2G/h+U/OOwkcZWgJoEjKMUQQEQwICZE
X-Google-Smtp-Source: AGHT+IHOi840LuS1JN5U0t9j0OWBYwJv1hMoLvKd5wr8/+REV/9LbYvbhMV5SfvPBvAgpzNJgUvzyQ==
X-Received: by 2002:a4a:d04:0:b0:5aa:538a:ed60 with SMTP id 4-20020a4a0d04000000b005aa538aed60mr40533oob.3.1713464879714;
        Thu, 18 Apr 2024 11:27:59 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:6fe6:94b6:ddee:aa05? ([2600:1700:6cf8:1240:6fe6:94b6:ddee:aa05])
        by smtp.gmail.com with ESMTPSA id m6-20020a056820050600b005aa6a8d7904sm482076ooj.48.2024.04.18.11.27.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Apr 2024 11:27:59 -0700 (PDT)
Message-ID: <237e0652-58b2-4de2-8f15-029f398f389a@gmail.com>
Date: Thu, 18 Apr 2024 11:27:57 -0700
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
Content-Language: en-US
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <CAADnVQ+hGv0oVx4_uPs2yr=vWC80OEEXLm_FcZLBfsthu0yFbA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 4/18/24 07:53, Alexei Starovoitov wrote:
> On Wed, Apr 17, 2024 at 11:07 PM Kui-Feng Lee <sinquersw@gmail.com> wrote:
>>
>>
>>
>> On 4/17/24 22:11, Alexei Starovoitov wrote:
>>> On Wed, Apr 17, 2024 at 9:31 PM Kui-Feng Lee <sinquersw@gmail.com> wrote:
>>>>
>>>>
>>>>
>>>> On 4/17/24 20:30, Alexei Starovoitov wrote:
>>>>> On Fri, Apr 12, 2024 at 2:08 PM Kui-Feng Lee <thinker.li@gmail.com> wrote:
>>>>>>
>>>>>> The arrays of kptr, bpf_rb_root, and bpf_list_head didn't work as
>>>>>> global variables. This was due to these types being initialized and
>>>>>> verified in a special manner in the kernel. This patchset allows BPF
>>>>>> programs to declare arrays of kptr, bpf_rb_root, and bpf_list_head in
>>>>>> the global namespace.
>>>>>>
>>>>>> The main change is to add "nelems" to btf_fields. The value of
>>>>>> "nelems" represents the number of elements in the array if a btf_field
>>>>>> represents an array. Otherwise, "nelem" will be 1. The verifier
>>>>>> verifies these types based on the information provided by the
>>>>>> btf_field.
>>>>>>
>>>>>> The value of "size" will be the size of the entire array if a
>>>>>> btf_field represents an array. Dividing "size" by "nelems" gives the
>>>>>> size of an element. The value of "offset" will be the offset of the
>>>>>> beginning for an array. By putting this together, we can determine the
>>>>>> offset of each element in an array. For example,
>>>>>>
>>>>>>        struct bpf_cpumask __kptr * global_mask_array[2];
>>>>>
>>>>> Looks like this patch set enables arrays only.
>>>>> Meaning the following is supported already:
>>>>>
>>>>> +private(C) struct bpf_spin_lock glock_c;
>>>>> +private(C) struct bpf_list_head ghead_array1 __contains(foo, node2);
>>>>> +private(C) struct bpf_list_head ghead_array2 __contains(foo, node2);
>>>>>
>>>>> while this support is added:
>>>>>
>>>>> +private(C) struct bpf_spin_lock glock_c;
>>>>> +private(C) struct bpf_list_head ghead_array1[3] __contains(foo, node2);
>>>>> +private(C) struct bpf_list_head ghead_array2[2] __contains(foo, node2);
>>>>>
>>>>> Am I right?
>>>>>
>>>>> What about the case when bpf_list_head is wrapped in a struct?
>>>>> private(C) struct foo {
>>>>>      struct bpf_list_head ghead;
>>>>> } ghead;
>>>>>
>>>>> that's not enabled in this patch. I think.
>>>>>
>>>>> And the following:
>>>>> private(C) struct foo {
>>>>>      struct bpf_list_head ghead;
>>>>> } ghead[2];
>>>>>
>>>>>
>>>>> or
>>>>>
>>>>> private(C) struct foo {
>>>>>      struct bpf_list_head ghead[2];
>>>>> } ghead;
>>>>>
>>>>> Won't work either.
>>>>
>>>> No, they don't work.
>>>> We had a discussion about this in the other day.
>>>> I proposed to have another patch set to work on struct types.
>>>> Do you prefer to handle it in this patch set?
>>>>
>>>>>
>>>>> I think eventually we want to support all such combinations and
>>>>> the approach proposed in this patch with 'nelems'
>>>>> won't work for wrapper structs.
>>>>>
>>>>> I think it's better to unroll/flatten all structs and arrays
>>>>> and represent them as individual elements in the flattened
>>>>> structure. Then there will be no need to special case array with 'nelems'.
>>>>> All special BTF types will be individual elements with unique offset.
>>>>>
>>>>> Does this make sense?
>>>>
>>>> That means it will creates 10 btf_field(s) for an array having 10
>>>> elements. The purpose of adding "nelems" is to avoid the repetition. Do
>>>> you prefer to expand them?
>>>
>>> It's not just expansion, but a common way to handle nested structs too.
>>>
>>> I suspect by delaying nested into another patchset this approach
>>> will become useless.
>>>
>>> So try adding nested structs in all combinations as a follow up and
>>> I suspect you're realize that "nelems" approach doesn't really help.
>>> You'd need to flatten them all.
>>> And once you do there is no need for "nelems".
>>
>> For me, "nelems" is more like a choice of avoiding repetition of
>> information, not a necessary. Before adding "nelems", I had considered
>> to expand them as well. But, eventually, I chose to add "nelems".
>>
>> Since you think this repetition is not a problem, I will expand array as
>> individual elements.
> 
> You don't sound convinced :)
> Please add support for nested structs on top of your "nelems" approach
> and prototype the same without "nelems" and let's compare the two.

Flattening is definitely easier to implement.


