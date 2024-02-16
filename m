Return-Path: <bpf+bounces-22127-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A58FE8573D0
	for <lists+bpf@lfdr.de>; Fri, 16 Feb 2024 03:40:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 053C01F24350
	for <lists+bpf@lfdr.de>; Fri, 16 Feb 2024 02:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F3DBDF78;
	Fri, 16 Feb 2024 02:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="auWcVfjb"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06993D27A
	for <bpf@vger.kernel.org>; Fri, 16 Feb 2024 02:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708051241; cv=none; b=CocneNukxvYFItcMgyZHBCxY7VG2uFYZITd6IwoQhk1gaV73XMuVnKfbUKbLOH/Ggf6lauE9PlSAV0s3diCYCxHPHpWS3q8wOt7HgoY3uosHiqQNVD/oANb8NWHkhsiaTlTKA/4PxV/Ombl8rCgEeCsotR9NDM9rqyx7YcTas0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708051241; c=relaxed/simple;
	bh=TJPCOqZZ813H3y58oRgeF262FLdR2tZ/h4uYpzV+fvg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TZl1a+EmFiWL0FNc6fzpTH8rv4925cBfMKuRSUI9mE+muyJSfscN2n+saClle6saQ3UpogLByNylXXkwL8LHNMV5dtkd6KtzgHypKivzltk5sYgco7QwAbdXgtBagEookthYBc1SXYkKFR9mSNkci0aXTIhQmYXGAXXzgtBGf78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=auWcVfjb; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-607f8482b88so2422817b3.0
        for <bpf@vger.kernel.org>; Thu, 15 Feb 2024 18:40:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708051239; x=1708656039; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aAqx+DNtfohx3A0ohaMlGEV6NccyucAWbnrcMy+yVXs=;
        b=auWcVfjbPyqCnW/VtVUu7YZZljp70m+ia1TdJHfItcDy3qRtNl2/RX+PwRCAfkLSed
         VH37NoGppGPkWVaQYvDCb8oTWWWa4exs8LCEs7PHMZqyzgC2PgI2JHhXqLsm0+Na3bTX
         eY/2dudezECA2FirDuOLOW42y5nchsQmzHLGhf21oA3TrmsNFLnYg1gBQh3Yb2t3JHQi
         t4sgTkvuuERgiUWhq497N40zJwYzROHCoP1QfiiriMDqj8lxNfuMb7MsC6GTrWAOGplS
         B5+IcE4szdCzD+UaxY8pQrO5Fyyp0EXvnJtiW8mI5IonULQuBN0zHbzoWCbc71TKhKru
         kXBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708051239; x=1708656039;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aAqx+DNtfohx3A0ohaMlGEV6NccyucAWbnrcMy+yVXs=;
        b=DLiJ7Y1NVHepVZ02T74OM5WDHu9psnAh12RAlzX+IJ+5OFtRBlPAuhayIuqEbDDDpE
         H1zH/srBFBL+7iida4aPJgFpX3NoFgSt+D1sikgx9grLK1kibsmekrHIJ9kO/rYEbcN/
         qqve5mFUplsMBvBP6gmizDT5TWzwedngkC2qmZ8qrf/TJgA6WeDQ29qe9fQyOAwTYe9j
         hPrLbDNckEIKL7oVh1p3WHTrUZ+tBTtnF0TuWI8ApaDJlyI3tXRc5Pouz4wzy30NqlUu
         Hx6690apiwg6TdhJxa47sG5fU3xjYXUJhyKvUbIfhjsH5bGc8Dpy6LV8EvIV4iYP8jxj
         b0Mw==
X-Gm-Message-State: AOJu0YziVGnTEla6tEBPxzubUAfS1e+dDMdDoPyNM4io0XTvH0b1ocr6
	KJ0B6K2FTuqo31B6H6yqO9yOJayJ2CnSvcRb40AZiUiz/eCciezSnVashYZL
X-Google-Smtp-Source: AGHT+IGbXX1Q5UUSmn3jNEiO7LT6L3dTXwYAlKhoSevWkYJwsNu4vPmjtnbReoAyOw4bjX06VcbutA==
X-Received: by 2002:a81:7bc5:0:b0:604:9c2e:923f with SMTP id w188-20020a817bc5000000b006049c2e923fmr3828825ywc.32.1708051238850;
        Thu, 15 Feb 2024 18:40:38 -0800 (PST)
Received: from ?IPV6:2600:1700:6cf8:1240:ad0b:a28:ac5d:fc77? ([2600:1700:6cf8:1240:ad0b:a28:ac5d:fc77])
        by smtp.gmail.com with ESMTPSA id t22-20020a0dea16000000b006042eeb20e1sm161968ywe.29.2024.02.15.18.40.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Feb 2024 18:40:38 -0800 (PST)
Message-ID: <65f8cbbc-0330-4df8-8e8b-79c389f82f78@gmail.com>
Date: Thu, 15 Feb 2024 18:40:37 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC bpf-next v2 0/3] Create shadow variables for struct_ops in
 skeletons
Content-Language: en-US
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>, thinker.li@gmail.com
Cc: bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev,
 song@kernel.org, kernel-team@meta.com, andrii@kernel.org, kuifeng@meta.com
References: <20240214020836.1845354-1-thinker.li@gmail.com>
 <CAEf4BzbwZLMD=LWqZ_kmMeyLWvpzbeLGXSgWVQPSCsdnh+mufQ@mail.gmail.com>
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <CAEf4BzbwZLMD=LWqZ_kmMeyLWvpzbeLGXSgWVQPSCsdnh+mufQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2/15/24 15:50, Andrii Nakryiko wrote:
> On Tue, Feb 13, 2024 at 6:08 PM <thinker.li@gmail.com> wrote:
>>
>> From: Kui-Feng Lee <thinker.li@gmail.com>
>>
>> This RFC is for gathering feedback/opinions on the design.
>> Based on the feedback received for v1, I made some modifications.
>>
>> == Pointers to Shadow Copies ==
>>
>> With the current implementation, the code generator will create a
>> pointer to a shadow copy of the struct_ops map for each map. For
>> instance, if we define a testmod_1 as a struct_ops map, we can access
>> its corresponding shadow variable "data" using the pointer.
>>
>>      skel->struct_ops.testmod1->data
>>
>> == Shadow Info ==
>>
>> The code generator also generates a shadow info to describe the layout
>> of the data pointed to by all these pointers. For instance, the
>> following shadow info describes the layout of a struct_ops map called
>> testmod_1, which has 3 members: test_1, test_2, and data.
>>
>>      static struct bpf_struct_ops_member_info member_info_testmod_1[] = {
>>          {
>>                  .name = "test_1",
>>                  .offset = .....,
>>                  .size = .....,
>>          },
>>          {
>>                  .name = "test_2",
>>                  .offset = .....,
>>                  .size = .....,
>>          },
>>          {
>>                  .name = "data",
>>                  .offset = .....,
>>                  .size = .....,
>>          },
>>      };
>>      static struct bpf_struct_ops_map_info map_info[] = {
>>          {
>>                  .name = "testmod_1",
>>                  .members = member_info_testmod_1,
>>                  .cnt = ARRAY_SIZE(member_info_testmod_1),
>>                  .data_size = sizeof(struct_ops->testmod_1),
>>          },
>>      };
>>      static struct bpf_struct_ops_shadow_info shadow_info = {
>>          .maps = map_info,
>>          .cnt = ARRAY_SIZE(map_info),
>>      };
>>
>> A shadow info describes the layout of the shadow copies of all
>> struct_ops maps included in a skeleton. (Defined in *__shadow_info())
> 
> I must be missing something, but libbpf knows the layout of struct_ops
> struct through BTF, why do we need all these descriptors?

I explain it in the response for part 1.

> 
>>
>> == libbpf Creates Shadow Copies ==
>>
>> This shadow info should be passed to bpf_object__open_skeleton() as a
>> part of "opts" so that libbpf can create shadow copies with the layout
>> described by the shadow info. For now, *__open() in the skeleton will
>> automatically pass the shadow info to bpf_object__open_skeleton(),
>> looking like the following example.
>>
>>      static inline struct struct_ops_module *
>>      struct_ops_module__open(void)
>>      {
>>          DECLARE_LIBBPF_OPTS(bpf_object_open_opts, opts);
>>
>>          opts.struct_ops_shadow = struct_ops_module__shadow_info();
>>
>>          return struct_ops_module__open_opts(*** BLURB HERE ***opts);
>>      }
>>
>> The function bpf_map__initial_value() will return the shadow copy that
>> is created based on the received shadow info. Therefore, in the
>> function *__open_opts() in the skeleton, the pointers to shadow copies
>> will be initialized with the values returned from
>> bpf_map__initial_value(). For instance,
>>
>>     obj->struct_ops.testmod_1 =
>>          bpf_map__initial_value(obj->maps.testmod_1, NULL);
>>
> 
> I also don't get why you need to allocate some extra "shadow memory"
> if we already have struct bpf_struct_ops->data pointer malloc()'ed
> during bpf_map initialization, and its size matches exactly the
> struct_ops's type size.


I assume that the alignments & padding of BPF and the user space
programs are different. (Check the response for part 1 as well)

> 
>> This line of code will be included in the *__open_opts() function. If
>> the opts.struct_ops_shadow is not set, bpf_map__initial_value() will
>> return a NULL.
>>
>> ========================================
>> DESCRIPTION form v1
>> ========================================
>>
> 
> you probably don't need to keep cover letter from previous versions if
> they are not relevant anymore
> 
> [...]


Sure!
It explains what the feature is and how to use this feature.
So, I keep it here for people just found this discussion.

> 
>>
>> ---
>>
>> v1: https://lore.kernel.org/all/20240124224130.859921-1-thinker.li@gmail.com/
>>
>> Kui-Feng Lee (3):
>>    libbpf: Create a shadow copy for each struct_ops map if necessary.
>>    bpftool: generated shadow variables for struct_ops maps.
>>    selftests/bpf: Test if shadow variables work.
>>
>>   tools/bpf/bpftool/gen.c                       | 358 +++++++++++++++++-
>>   tools/lib/bpf/libbpf.c                        | 195 +++++++++-
>>   tools/lib/bpf/libbpf.h                        |  34 +-
>>   tools/lib/bpf/libbpf.map                      |   1 +
>>   tools/lib/bpf/libbpf_internal.h               |   1 +
>>   .../selftests/bpf/bpf_testmod/bpf_testmod.c   |   6 +-
>>   .../selftests/bpf/bpf_testmod/bpf_testmod.h   |   1 +
>>   .../bpf/prog_tests/test_struct_ops_module.c   |  16 +-
>>   .../selftests/bpf/progs/struct_ops_module.c   |   8 +
>>   9 files changed, 596 insertions(+), 24 deletions(-)
>>
>> --
>> 2.34.1
>>

