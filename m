Return-Path: <bpf+bounces-27111-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DACF8A92C5
	for <lists+bpf@lfdr.de>; Thu, 18 Apr 2024 08:07:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 057DA1F21854
	for <lists+bpf@lfdr.de>; Thu, 18 Apr 2024 06:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 051A0651B1;
	Thu, 18 Apr 2024 06:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dCj/RxND"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 240D6EDF
	for <bpf@vger.kernel.org>; Thu, 18 Apr 2024 06:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713420443; cv=none; b=UwLBP0fr2IYw4MaS8lMgkBSArEfYBYQJnL6EUAk1hqYGq4ZJlscqraRHYvh4HiDJ1//QS2KC2MisDutdtRSYkjKWmDuB20/2Xv9HQ0Q+w7lsk9bpO/6eCmmVJmHiC6G6dCzCQPde7zxHYMjr5PzKedf4JEsjEMScbAjvGe4RvEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713420443; c=relaxed/simple;
	bh=gp0XWA+R/JSCiUI4BAYZQxLoa5ThZ/O/87KPAmB8aDQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FXBVE6t5dJAFBEwA+A4+28cuc/ocuO8COd+3TLKekEnfdIQ7NJl37mEnFnONTOi+iqbFthxt81p6ZAlZjy1p3IgBwaLbEe+3S7fCs8gt+qAL0ASAS1NuRyap3cJdlzCjOu4QBwzmnZ+8wPwqE4oxLAcuR7D+dz35gvyZiIXnb4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dCj/RxND; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5aa2a74c238so328510eaf.3
        for <bpf@vger.kernel.org>; Wed, 17 Apr 2024 23:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713420441; x=1714025241; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zeMR9vbPPvLuh5XpLippuCIq9ZYQOxisp9yBJHbDt5U=;
        b=dCj/RxNDa6t4DOue3H2/X6hz0znSi4YcbphBbVqWzBBf04v0z4Bc+HWbmns/6amMF1
         zEQ34Zk8ir/cQJEyDN/6/AyXkI2YXocUjP15yHnuDrouGRKg/NOP+FWJwlSyRNLrb6je
         R5Ty0gcbUrKzfdvy8SC51CS7Uxb8FcuR1BpP85LObgYu8/95zNw+bQAInSXeOXQ9//+m
         gydfsVdZQ2ebfCZ9Y5r297PVpI7CE8hH5feWkqsGnVeWzbM0N5KbfQTJvm4CN8DTtddB
         tS/330SXYUb6wwWH9PnR4fXMwOuEd5nOUJ1S3vbuj90C9yaJh+TDkWebU3KVqJIVsymx
         TPPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713420441; x=1714025241;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zeMR9vbPPvLuh5XpLippuCIq9ZYQOxisp9yBJHbDt5U=;
        b=HH9z2nLwbTKosP1l0wJmRN+f1hgjKkOo4tE8rJn74DWbzng9ADMalbmrX0TGFyBuyY
         CzZSsvFP2+M8XCjG4nQwQCulfwQ8+GmLlkoN1v5gckK7lAz1utgP4jNp2or7+GMohbwo
         sqqzGhJWaUJde5URF6/BFXRRIpdw0ymNdnMd26cqHnorkHzINQ0tCo5huaVfzIsekNOk
         CK1vclgrUwYrOia5ig4aJFUwQHpyra3J47KIPyZJf16fAZ4mEkQSycXzWxNDGpeIUcPX
         9pG/dTZEUVljJmWwdLpDNf8raLUQSB9wAvF8qwLd8i5qIGFjIlUbdqw9kbFCtpJM1qad
         AfdA==
X-Forwarded-Encrypted: i=1; AJvYcCVSSd0BQWV5M+ZQsJAGcN1USklx0FbCIDW2P4OvxgHyMkpC1jG1vXaiEBb2lXZO58szhPhwKN4HZY/qebBhGORkH+Ce
X-Gm-Message-State: AOJu0Ywaw7Nm4E0/RS/0OAUw3qqyHtjzGt4K1uIQiwKyZlFdSVaVxT2S
	6nGy2N5aqQx5bnY1o7gks4D0Zp976Sa1IYZmUqq9ATWaMJtXl75+6yJkrg==
X-Google-Smtp-Source: AGHT+IGPapSfOLjDNFk1BuPIhfGsv6eUvFXf/QQCJ1nEuUArThGRJoEhvE+yl4JiBR2ks3KszOneuA==
X-Received: by 2002:a05:6871:28c:b0:22e:dfc7:6cdd with SMTP id i12-20020a056871028c00b0022edfc76cddmr2236084oae.50.1713420440721;
        Wed, 17 Apr 2024 23:07:20 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:f03d:b488:be92:3bc9? ([2600:1700:6cf8:1240:f03d:b488:be92:3bc9])
        by smtp.gmail.com with ESMTPSA id ov26-20020a056870cb9a00b0022e9ffdb5a5sm271300oab.24.2024.04.17.23.07.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Apr 2024 23:07:20 -0700 (PDT)
Message-ID: <6d25660d-103a-4541-977f-525bd2d38cd0@gmail.com>
Date: Wed, 17 Apr 2024 23:07:19 -0700
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
Content-Language: en-US
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <CAADnVQKjGFdiy4nYTsbfH5rm7T9gt_VhHd3R+0s4yS9eqTtSaA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 4/17/24 22:11, Alexei Starovoitov wrote:
> On Wed, Apr 17, 2024 at 9:31 PM Kui-Feng Lee <sinquersw@gmail.com> wrote:
>>
>>
>>
>> On 4/17/24 20:30, Alexei Starovoitov wrote:
>>> On Fri, Apr 12, 2024 at 2:08 PM Kui-Feng Lee <thinker.li@gmail.com> wrote:
>>>>
>>>> The arrays of kptr, bpf_rb_root, and bpf_list_head didn't work as
>>>> global variables. This was due to these types being initialized and
>>>> verified in a special manner in the kernel. This patchset allows BPF
>>>> programs to declare arrays of kptr, bpf_rb_root, and bpf_list_head in
>>>> the global namespace.
>>>>
>>>> The main change is to add "nelems" to btf_fields. The value of
>>>> "nelems" represents the number of elements in the array if a btf_field
>>>> represents an array. Otherwise, "nelem" will be 1. The verifier
>>>> verifies these types based on the information provided by the
>>>> btf_field.
>>>>
>>>> The value of "size" will be the size of the entire array if a
>>>> btf_field represents an array. Dividing "size" by "nelems" gives the
>>>> size of an element. The value of "offset" will be the offset of the
>>>> beginning for an array. By putting this together, we can determine the
>>>> offset of each element in an array. For example,
>>>>
>>>>       struct bpf_cpumask __kptr * global_mask_array[2];
>>>
>>> Looks like this patch set enables arrays only.
>>> Meaning the following is supported already:
>>>
>>> +private(C) struct bpf_spin_lock glock_c;
>>> +private(C) struct bpf_list_head ghead_array1 __contains(foo, node2);
>>> +private(C) struct bpf_list_head ghead_array2 __contains(foo, node2);
>>>
>>> while this support is added:
>>>
>>> +private(C) struct bpf_spin_lock glock_c;
>>> +private(C) struct bpf_list_head ghead_array1[3] __contains(foo, node2);
>>> +private(C) struct bpf_list_head ghead_array2[2] __contains(foo, node2);
>>>
>>> Am I right?
>>>
>>> What about the case when bpf_list_head is wrapped in a struct?
>>> private(C) struct foo {
>>>     struct bpf_list_head ghead;
>>> } ghead;
>>>
>>> that's not enabled in this patch. I think.
>>>
>>> And the following:
>>> private(C) struct foo {
>>>     struct bpf_list_head ghead;
>>> } ghead[2];
>>>
>>>
>>> or
>>>
>>> private(C) struct foo {
>>>     struct bpf_list_head ghead[2];
>>> } ghead;
>>>
>>> Won't work either.
>>
>> No, they don't work.
>> We had a discussion about this in the other day.
>> I proposed to have another patch set to work on struct types.
>> Do you prefer to handle it in this patch set?
>>
>>>
>>> I think eventually we want to support all such combinations and
>>> the approach proposed in this patch with 'nelems'
>>> won't work for wrapper structs.
>>>
>>> I think it's better to unroll/flatten all structs and arrays
>>> and represent them as individual elements in the flattened
>>> structure. Then there will be no need to special case array with 'nelems'.
>>> All special BTF types will be individual elements with unique offset.
>>>
>>> Does this make sense?
>>
>> That means it will creates 10 btf_field(s) for an array having 10
>> elements. The purpose of adding "nelems" is to avoid the repetition. Do
>> you prefer to expand them?
> 
> It's not just expansion, but a common way to handle nested structs too.
> 
> I suspect by delaying nested into another patchset this approach
> will become useless.
> 
> So try adding nested structs in all combinations as a follow up and
> I suspect you're realize that "nelems" approach doesn't really help.
> You'd need to flatten them all.
> And once you do there is no need for "nelems".

For me, "nelems" is more like a choice of avoiding repetition of
information, not a necessary. Before adding "nelems", I had considered
to expand them as well. But, eventually, I chose to add "nelems".

Since you think this repetition is not a problem, I will expand array as
individual elements.

