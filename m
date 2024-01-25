Return-Path: <bpf+bounces-20356-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F00F83D070
	for <lists+bpf@lfdr.de>; Fri, 26 Jan 2024 00:13:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D4641F29100
	for <lists+bpf@lfdr.de>; Thu, 25 Jan 2024 23:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69ED012B9A;
	Thu, 25 Jan 2024 23:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fCutontv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6066A125B2
	for <bpf@vger.kernel.org>; Thu, 25 Jan 2024 23:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706224417; cv=none; b=FVdajh4qDT2+qMeGSbhJk4wvVB5SNA+TI0wIWTqliTuzU3B2/DwosQHpLWKQ31eeGZMsFoh/h7HTqluFCaYxfn8WlFEJXh790+8P7A4Ch6pnB2/qhtWmq8ruvZW0tCcKym6Mbkgb9uWaSShq83FHsb3aZuf2RFFaoOjz0QrGQkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706224417; c=relaxed/simple;
	bh=VKKG25uXTFbPWSUe/8mrcXPqOUZksKcFeldK0By8IVA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mPa9xGm8oSJrEwWKWaa51WbL2w4GaW0NvqfdKMgwpV6wMlsXRtOFUVjM/Z5fWbMxjANlTjff3KPezSfUMQeX+RlkGoZtmFMuhPqNpU95ljI3QTwvubGHeqaQaXGDcoR6FTaZG+twF55Dyh4vNJv3gzRii0Fw86tdataFPnI8v/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fCutontv; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-5edfcba97e3so74729487b3.2
        for <bpf@vger.kernel.org>; Thu, 25 Jan 2024 15:13:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706224414; x=1706829214; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xdKW/zlQNSxI1PvEig8g81w7/dPI96eH7UNN1qYWGGI=;
        b=fCutontv8kxVzcPaU+oGnUOjyH4IbvKGLyaHj21fXD0UM5gPxiNJkzU2myx6KzlH1F
         YRCOCJySCbHU36Ny1r15+oOSO2zU5fdLr7VbexGjoW6aKD7+ha5K4vAo4eD6ZsQCE2He
         RCthtmg3toj5fbCHGfK+sXoKukHL/sz1v6kLIiNzH+bHEPLEKG4jZlkY90Z6rEZxpSfZ
         2nyO+MngfD7hq0kn7ATDNE7hmwI84g7LhbWR56FidmRnpb7l40+0gWw+R+QcW2BSFX/m
         b6Xh3WvxfuJ15l8Kg1jS950Y7Bni9zWdtxVS5TynjSJQP9D/S5Ss/KXZSiP7k2mK9bIh
         c1Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706224414; x=1706829214;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xdKW/zlQNSxI1PvEig8g81w7/dPI96eH7UNN1qYWGGI=;
        b=K+I+REz3K8qV0RBgOuK0ia8o5Z2ZqiBNSpYEbM848hLnqKM53/xbmkceVVqdTyCusX
         hr6xhgEiOriEtpe94aZaN6G7uvLHt0U804zaJCKcwDTtwuwUi6wQ8bEQ9Q3HzrZa3HCs
         Ehyzf2XZdQu4N3/YKmimGPKlB15NgEehnh4WdvTZsiP/fTZ5bZq1W+uSMCHsJdYdHegs
         n60grMbg3+fglGJEd34fTO6yhIruP1SB3Gz8vp6V1wRDRVVwF/i0bFFfXHjZIUCSxTIH
         WNLXpsiS+K7fB8/ValwoEm56bmWFxrBUYU7gIrNjhO8/reAPPaczDDeS9xLaW96AZ3hJ
         j8yw==
X-Gm-Message-State: AOJu0YwCDWaBgVeQffddeerRIoFFv6pxGTh7Dzb1A5RlL9szBh+x+fVe
	3DvJrpZECqY2WLgzFWZLk+QsPaQLT74GjyHrgahhWJTfpRefEpfm
X-Google-Smtp-Source: AGHT+IHME8WeRYCjOv/ZIJk7TKE2blzUDAHUujx8tjoEhFtYO5e6j788rz4BzQ1yPLc14KYrsWJeSg==
X-Received: by 2002:a81:a085:0:b0:5ff:860f:21d5 with SMTP id x127-20020a81a085000000b005ff860f21d5mr609515ywg.33.1706224414099;
        Thu, 25 Jan 2024 15:13:34 -0800 (PST)
Received: from ?IPV6:2600:1700:6cf8:1240:f81f:566c:c5f6:9b00? ([2600:1700:6cf8:1240:f81f:566c:c5f6:9b00])
        by smtp.gmail.com with ESMTPSA id t18-20020a818312000000b005ffa3fa57f9sm987155ywf.51.2024.01.25.15.13.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jan 2024 15:13:33 -0800 (PST)
Message-ID: <b1819ff0-872b-4cab-91d2-b496929d49f7@gmail.com>
Date: Thu, 25 Jan 2024 15:13:32 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC bpf-next] bpf: Create shadow variables for struct_ops in
 skeletons.
Content-Language: en-US
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>, thinker.li@gmail.com
Cc: bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev,
 song@kernel.org, kernel-team@meta.com, andrii@kernel.org, kuifeng@meta.com
References: <20240124224130.859921-1-thinker.li@gmail.com>
 <CAEf4BzZaFh3BaDYhTAWCuZBZ9t_2C2iXOsCGF88LeNb+ndVaXg@mail.gmail.com>
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <CAEf4BzZaFh3BaDYhTAWCuZBZ9t_2C2iXOsCGF88LeNb+ndVaXg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 1/25/24 14:21, Andrii Nakryiko wrote:
> On Wed, Jan 24, 2024 at 2:41 PM <thinker.li@gmail.com> wrote:
>>
>> From: Kui-Feng Lee <thinker.li@gmail.com>
>>
>> Create shadow variables for the fields of struct_ops maps in a skeleton
>> with the same name as the respective fields. For instance, if struct
>> bpf_testmod_ops has a "data" field as following, you can access or modify
>> its value through a shadow variable also named "data" in the skeleton.
>>
>>    SEC(".struct_ops.link")
>>    struct bpf_testmod_ops testmod_1 = {
>>        .data = 0x1,
>>    };
>>
>> Then, you can change the value in the following manner as shown in the code
>> below.
>>
>>    skel->st_ops_vars.testmod_1.data = 13;
>>
>> It is helpful to configure a struct_ops map during the execution of a
>> program. For instance, you can include a flag in a struct_ops type to
>> modify the way the kernel handles an instance. By implementing this
>> feature, a user space program can alter the flag's value prior to loading
>> an instance into the kernel.
>>
>> The code generator for skeletons will produce code that copies values to
>> shadow variables from the internal data buffer when a skeleton is
>> opened. It will also copy values from shadow variables back to the internal
>> data buffer before a skeleton is loaded into the kernel.
>>
>> The code generator will calculate the offset of a field and generate code
>> that copies the value of the field from or to the shadow variable to or
>> from the struct_ops internal data, with an offset relative to the beginning
>> of the internal data. For instance, if the "data" field in struct
>> bpf_testmod_ops is situated 16 bytes from the beginning of the struct, the
>> address for the "data" field of struct bpf_testmod_ops will be the starting
>> address plus 16.
>>
>> The offset is calculated during code generation, so it is always in line
>> with the internal data in the skeleton. Even if the user space programs and
>> the BPF program were not compiled together, any differences in versions
>> would not impact correctness. This means that even if the BPF program and
>> the user space program reference different versions of the "struct
>> bpf_testmod_ops" and have different offsets for "data", these offsets
>> computed by the code generator would still function correctly.
>>
>> The user space programs can only modify values by using these shadow
>> variables when the skeleton is open, but before being loaded. Once the
>> skeleton is loaded, the value is copied to the kernel, and any future
>> changes only affect the shadow variables in the user space memory and do
>> not update the kernel space. The shadow variables are not initialized
>> before opening a skeleton, so you cannot update values through them before
>> opening.
>>
>> For function pointers (operators), you can change/replace their values with
>> other BPF programs. For example, the test case in test_struct_ops_module.c
>> points .test_2 to test_3() while it was pointed to test_2() by assigning a
>> new value to the shadow variable.
>>
>>    skel->st_ops_vars.testmod_1.test_2 = skel->progs.test_3;
>>
>> However, you need to turn off autoload for test_2() since it is not
>> assigned to any struct_ops map anymore. Or, it will fails to load test_2().
>>
>>   bpf_program__set_autoload(skel->progs.test_2, false);
>>
>> You can define more struct_ops programs than necessary. However, you need
>> to turn autoload off for unused ones.
> 
> Overall I like the idea, it seems like a pretty natural and powerful
> interface. Few things I'd do a bit differently:
> 
> - less code gen in the skeleton. It feels like it's better to teach
> libbpf to allow getting/setting intial struct_ops map "image" using
> standard bpf_map__initial_value() and bpf_map__set_initial_value().
> That fits with other global data maps.

Right, it is doable to move some logic from the code generator to
libbpf. The only thing should keep in the code generator should be
generating shadow variable fields in the skeleton.

> 
> - I think all struct ops maps should be in skel->struct_ops.<name>,
> not struct_ops_vars. I'd probably also combine struct_ops.link and
> no-link struct ops in one section for simplicity

agree!

> 
> - getting underlying struct_ops BTF type should be possible to do
> through bpf_map__btf_value_type_id(), no need for struct_ops-specific
> one

AFAIK, libbpf doesn't set def.value_type_id for struct_ops maps.
bpf_map__btf_value_type_id() doesn't return the ID of a struct_ops type.
I will check what the side effects are if def.value_type_id is set for
struct_ops maps.

> 
> - you have a bunch of specific logic to dump INT/ENUM/PTR, I wonder if
> we can just reuse libbpf's BTF dumping API to dump everything? Though
> for prog pointers we'd want to rewrite them to `struct bpf_program *`
> field, not sure yet how hard it is.

I am not quite sure what part you are talking about.
Do you mean the code skipping type modifiers?
The implementation skips all const (and static/volatile/... etc) to make
sure the user space programs can change these values without any
tricky type casting.

> 
> The above is brief, so please ask questions where it's not clear what
> I propose, thanks!
> 
> [...]

Thank you for the comments.


