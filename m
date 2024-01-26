Return-Path: <bpf+bounces-20417-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5071383E0EF
	for <lists+bpf@lfdr.de>; Fri, 26 Jan 2024 18:55:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D008B1F25B49
	for <lists+bpf@lfdr.de>; Fri, 26 Jan 2024 17:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E814F20335;
	Fri, 26 Jan 2024 17:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="epo1IB2Q"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB89120327
	for <bpf@vger.kernel.org>; Fri, 26 Jan 2024 17:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706291697; cv=none; b=eKJaMJoDzRo2HNkpQl46A80CswxIh8VwjaN2ydhR2F/ggBknzm+DUZtAkO6KfngaVMjaBTBDTePTaL6VynxdOs6ZhbRy/o8lbWSeSnMotLvqMCykUU8uW1PR5u7CJ2pjSavYB5A6a6bckUdTXKzGk0X1AtVUEMgbin58pNTtkts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706291697; c=relaxed/simple;
	bh=OddhWpvP8aDMxIyKGauA5SEs4RJwFHE5ELQ2u4zMLlw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k92bsMwnZHCrQnVIslqy8NrU5/1j/J2e1SOXesCM8iaEfl9/WGFHzSBicgiNKXBfkSUdXHyJXU0YPY1ooxPnX1Z104hFU0zbcZsAVyc13iNJMg4OjuNXEoTxpaYsk2q8F9r8Gz6hTETWmW933yVQt6Q1GdoP9Nuhjl1aGI8WiKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=epo1IB2Q; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-5ffe7e7b7b3so6031467b3.3
        for <bpf@vger.kernel.org>; Fri, 26 Jan 2024 09:54:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706291695; x=1706896495; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FCzs5bqFdLCCW1/QIg338CST5GCVhjf85h1XmZgkVMY=;
        b=epo1IB2QS1rIPoIN1u4uEAbU63gI6OusEO2f30ZKzOtz6q30OqgxgysRqCb2oeVw7c
         zirPxVTvnhG4U3YvdD0IBlWlHMXsGyLNcVPGm1Nx1AKK8rENc9ucf3DhaFZ/Rm2Pvs2A
         f9lXYAEIhNjfp50JrJ9lF0oZiSO9Kky3LW57v2LOVvmcbbI074BnKx58d4ppSwXdTKgE
         QQzV80EeOPNQoY9bM9HV3EHcEAvLrAl/0tTp7qdTcKQaQxmlQHy/rGqZOqog0O1ZlBAA
         /bOIgseGoaRtJeSgI/FLCvF/Xmm6DjHmZkMkOXL9IkZuEbP9aX4mkG9i61twfkXzYPtw
         tqkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706291695; x=1706896495;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FCzs5bqFdLCCW1/QIg338CST5GCVhjf85h1XmZgkVMY=;
        b=NeZqddB+OsF7W6yiveU+UmB+vPLe7jbgvKKWaa++t3SwPUSumXWS8Up6qrBRgxfeOZ
         g9FzZ2q1BntBY8qP4eotey79y4aPcO0Egvf9U61QB2GQiIyrZnFF6fh6uWy7Vbv0umxd
         wCtlCaPBOzxtqRsp5rZn2XzEQkoolxtQELhg3RdV3uNF2Xlodj75lm0Rv78ae/SN3T3+
         S+xcIuaW/7u3te/4uOAUZYo3MK2D79w6bSz7PYO73CYxaE+O7au6mH3mD1sCehWMOtYs
         QBs0dEJA7nABObgieAwtomsl8h7bBQZ/9Dk3XrUzAGXUzUoexi04OopN199MPByT08EJ
         TijQ==
X-Gm-Message-State: AOJu0Yz98r2GjwSGMMfeaydeuJ+iC0waA1YMLN5fyZNVUY12W2VXFzsS
	8T/rNO47hhRqZPbsE3z7p71a4YSlRjYZf/v6abfswLKqE8CdlnOV2dYyXOl4
X-Google-Smtp-Source: AGHT+IGYyL84OoYyMT/4XSVA27oY32LR4VfFCOOmtbJ6VTVr8fOmy15iqavx3FcKnGJu6NvWFvVoiQ==
X-Received: by 2002:a05:690c:f95:b0:5fa:ee58:1dc9 with SMTP id df21-20020a05690c0f9500b005faee581dc9mr179689ywb.76.1706291694494;
        Fri, 26 Jan 2024 09:54:54 -0800 (PST)
Received: from ?IPV6:2600:1700:6cf8:1240:8f61:3de:99e1:36a? ([2600:1700:6cf8:1240:8f61:3de:99e1:36a])
        by smtp.gmail.com with ESMTPSA id hc2-20020a05690c480200b005e1a5593c0csm517202ywb.60.2024.01.26.09.54.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jan 2024 09:54:54 -0800 (PST)
Message-ID: <f007e17a-93b3-4199-b0ef-0817c38518ac@gmail.com>
Date: Fri, 26 Jan 2024 09:54:52 -0800
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
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: thinker.li@gmail.com, bpf@vger.kernel.org, ast@kernel.org,
 martin.lau@linux.dev, song@kernel.org, kernel-team@meta.com,
 andrii@kernel.org, kuifeng@meta.com
References: <20240124224130.859921-1-thinker.li@gmail.com>
 <CAEf4BzZaFh3BaDYhTAWCuZBZ9t_2C2iXOsCGF88LeNb+ndVaXg@mail.gmail.com>
 <b1819ff0-872b-4cab-91d2-b496929d49f7@gmail.com>
 <CAEf4BzZ7jke36H+UOyU8_UQCksF4QhEmu94=H70=uJqbdOPRRw@mail.gmail.com>
 <e472da72-4031-4502-bfc5-392c8e332816@gmail.com>
 <CAEf4BzbjJYXM3ZYDGRxhSB3_T+aZyrvii8V5MJC7RcoF62_==Q@mail.gmail.com>
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <CAEf4BzbjJYXM3ZYDGRxhSB3_T+aZyrvii8V5MJC7RcoF62_==Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 1/26/24 09:28, Andrii Nakryiko wrote:
> On Thu, Jan 25, 2024 at 6:46 PM Kui-Feng Lee <sinquersw@gmail.com> wrote:
>>
>>
>>
>> On 1/25/24 15:59, Andrii Nakryiko wrote:
>>> On Thu, Jan 25, 2024 at 3:13 PM Kui-Feng Lee <sinquersw@gmail.com> wrote:
>>>>
>>>>
>>>>
>>>> On 1/25/24 14:21, Andrii Nakryiko wrote:
>>>>> On Wed, Jan 24, 2024 at 2:41 PM <thinker.li@gmail.com> wrote:
>>>>>>
>>>>>> From: Kui-Feng Lee <thinker.li@gmail.com>
>>>>>>
>>>>>> Create shadow variables for the fields of struct_ops maps in a skeleton
>>>>>> with the same name as the respective fields. For instance, if struct
>>>>>> bpf_testmod_ops has a "data" field as following, you can access or modify
>>>>>> its value through a shadow variable also named "data" in the skeleton.
>>>>>>
>>>>>>      SEC(".struct_ops.link")
>>>>>>      struct bpf_testmod_ops testmod_1 = {
>>>>>>          .data = 0x1,
>>>>>>      };
>>>>>>
>>>>>> Then, you can change the value in the following manner as shown in the code
>>>>>> below.
>>>>>>
>>>>>>      skel->st_ops_vars.testmod_1.data = 13;
>>>>>>
>>>>>> It is helpful to configure a struct_ops map during the execution of a
>>>>>> program. For instance, you can include a flag in a struct_ops type to
>>>>>> modify the way the kernel handles an instance. By implementing this
>>>>>> feature, a user space program can alter the flag's value prior to loading
>>>>>> an instance into the kernel.
>>>>>>
>>>>>> The code generator for skeletons will produce code that copies values to
>>>>>> shadow variables from the internal data buffer when a skeleton is
>>>>>> opened. It will also copy values from shadow variables back to the internal
>>>>>> data buffer before a skeleton is loaded into the kernel.
>>>>>>
>>>>>> The code generator will calculate the offset of a field and generate code
>>>>>> that copies the value of the field from or to the shadow variable to or
>>>>>> from the struct_ops internal data, with an offset relative to the beginning
>>>>>> of the internal data. For instance, if the "data" field in struct
>>>>>> bpf_testmod_ops is situated 16 bytes from the beginning of the struct, the
>>>>>> address for the "data" field of struct bpf_testmod_ops will be the starting
>>>>>> address plus 16.
>>>>>>
>>>>>> The offset is calculated during code generation, so it is always in line
>>>>>> with the internal data in the skeleton. Even if the user space programs and
>>>>>> the BPF program were not compiled together, any differences in versions
>>>>>> would not impact correctness. This means that even if the BPF program and
>>>>>> the user space program reference different versions of the "struct
>>>>>> bpf_testmod_ops" and have different offsets for "data", these offsets
>>>>>> computed by the code generator would still function correctly.
>>>>>>
>>>>>> The user space programs can only modify values by using these shadow
>>>>>> variables when the skeleton is open, but before being loaded. Once the
>>>>>> skeleton is loaded, the value is copied to the kernel, and any future
>>>>>> changes only affect the shadow variables in the user space memory and do
>>>>>> not update the kernel space. The shadow variables are not initialized
>>>>>> before opening a skeleton, so you cannot update values through them before
>>>>>> opening.
>>>>>>
>>>>>> For function pointers (operators), you can change/replace their values with
>>>>>> other BPF programs. For example, the test case in test_struct_ops_module.c
>>>>>> points .test_2 to test_3() while it was pointed to test_2() by assigning a
>>>>>> new value to the shadow variable.
>>>>>>
>>>>>>      skel->st_ops_vars.testmod_1.test_2 = skel->progs.test_3;
>>>>>>
>>>>>> However, you need to turn off autoload for test_2() since it is not
>>>>>> assigned to any struct_ops map anymore. Or, it will fails to load test_2().
>>>>>>
>>>>>>     bpf_program__set_autoload(skel->progs.test_2, false);
>>>>>>
>>>>>> You can define more struct_ops programs than necessary. However, you need
>>>>>> to turn autoload off for unused ones.
>>>>>
>>>>> Overall I like the idea, it seems like a pretty natural and powerful
>>>>> interface. Few things I'd do a bit differently:
>>>>>
>>>>> - less code gen in the skeleton. It feels like it's better to teach
>>>>> libbpf to allow getting/setting intial struct_ops map "image" using
>>>>> standard bpf_map__initial_value() and bpf_map__set_initial_value().
>>>>> That fits with other global data maps.
>>>>
>>>> Right, it is doable to move some logic from the code generator to
>>>> libbpf. The only thing should keep in the code generator should be
>>>> generating shadow variable fields in the skeleton.
>>>>
>>>>>
>>>>> - I think all struct ops maps should be in skel->struct_ops.<name>,
>>>>> not struct_ops_vars. I'd probably also combine struct_ops.link and
>>>>> no-link struct ops in one section for simplicity
>>>>
>>>> agree!
>>>>
>>>>>
>>>>> - getting underlying struct_ops BTF type should be possible to do
>>>>> through bpf_map__btf_value_type_id(), no need for struct_ops-specific
>>>>> one
>>>>
>>>> AFAIK, libbpf doesn't set def.value_type_id for struct_ops maps.
>>>> bpf_map__btf_value_type_id() doesn't return the ID of a struct_ops type.
>>>> I will check what the side effects are if def.value_type_id is set for
>>>> struct_ops maps.
>>>
>>> Yes, it doesn't right now, not sure why, though. At least we can fix
>>> that on libbpf sid
>>>
>>>>
>>>>>
>>>>> - you have a bunch of specific logic to dump INT/ENUM/PTR, I wonder if
>>>>> we can just reuse libbpf's BTF dumping API to dump everything? Though
>>>>> for prog pointers we'd want to rewrite them to `struct bpf_program *`
>>>>> field, not sure yet how hard it is.
>>>>
>>>> I am not quite sure what part you are talking about.
>>>> Do you mean the code skipping type modifiers?
>>>> The implementation skips all const (and static/volatile/... etc) to make
>>>> sure the user space programs can change these values without any
>>>> tricky type casting.
>>>>
>>>
>>> No, I'm talking about gen_st_ops_shadow_vars and gen_st_ops_func_one,
>>> which don't handle members of type STRUCT/UNION, for example. I didn't
>>> look too deeply into details of the implementation in those parts, but
>>> I don't see any reason why we shouldn't support embedded struct
>>> members there?
>>
>>
>> One of goals here is to make sure the result doesn't affect by the
>> change of types between versions. So, even a BPF program and a user
>> space program are compiled separated with different versions of a type,
>> they should still work together if the skeleton doesn't miss any
>> field required by the user space program.
> 
> I don't see a problem here. There is some local type information that
> was used to compile BPF object file. Libbpf knows it, it's in BTF.
> This is the type user knows about and fills out. Then during BPF
> object load libbpf will translate it to whatever kernel actually
> expects. I think it all works out fine and not really a concern. We
> just stick (consistently) to what was compiled into .bpf.o's BTF
> information.

This paragraph is the background of the following issue.
I mean this goal implies the following issue. Because of this, the
generator needs to generate the definitions of struct and union types
in the header files instead of relying on definitions being included
from other existing header files.


> 
>>
>> For fields of struct or
>> union types, that means we also have to include definitions of all
>> these types in the header files of skeletons.  It may also raise
>> type conflicts if we don't rename these types properly.
> 
> That's true, and is basically similar to the problem we have with
> global variables and their types. The only difference is that these
> struct_ops types are generally not controlled by users, and rather
> come from kernel (vmlinux.h and such), so you are right, this might
> cause some problems. Ok, we can start simple and skip those for now, I
> guess.


Great! Thanks!

> 
>>
>>>
>>>>>
>>>>> The above is brief, so please ask questions where it's not clear what
>>>>> I propose, thanks!
>>>>>
>>>>> [...]
>>>>
>>>> Thank you for the comments.
>>>>

