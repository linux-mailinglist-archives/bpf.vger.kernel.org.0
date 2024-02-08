Return-Path: <bpf+bounces-21464-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A687484D74F
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 01:54:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0104F1F22A1F
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 00:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21683D50F;
	Thu,  8 Feb 2024 00:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g5MVGgHU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D6B1E497
	for <bpf@vger.kernel.org>; Thu,  8 Feb 2024 00:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707353659; cv=none; b=kDRmfX/nCHi9fVTU2Sldaoxcxrh6VsRLbp+umxzYuAW9GUPw6e6r0cJKTiIxyF32qy3vH2MAr7vw/4SFTlUYJeQ5eCmgqB3/jAQiigy4GTD0YQAyUYIJ4gPCsaUk4EvNDUSDtV+vyGc1zK3M3a1v1g9++7TPCFRSJseNdElQe+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707353659; c=relaxed/simple;
	bh=lhAwHl9H0RuLvuwUu8NI9/Bf20nzPhzqII20R1dPS0c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z94ZOJrWOFtVWVVZ4cRelQJl3qyqdMmxiSOQfPPsv1g3VLgIz5PeA3eZFtnjMBXqnSCK7VvblyBTRQ/CgMwYAL3gA9I6SG9ovMHsbgf4BX43MJ5fAYvaiSJUT1SsHethdn+V71fmeWqTZK/Veg4mKltavGiEukZd5ZNPI+58RnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g5MVGgHU; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6049e8a54b5so8086467b3.0
        for <bpf@vger.kernel.org>; Wed, 07 Feb 2024 16:54:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707353657; x=1707958457; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z6dmCZv6ryQImcytK9h5IgucEGeDcfHtKgfnCRmY4OQ=;
        b=g5MVGgHU5oRPVwBtePUxvjfQidGoZ7rZGnJHKLrLK4y8RvnFwlss0M7XoSkGM9Ioh7
         8da4pUbNnPMIwnjl0qmoeDXDFsHCIxgrcRz34+Q2oJhS1gxwBn//f0qokWeiBEbnfixn
         Bztia5WOhCR38OI7o2jEjiywllNSC5fvavLlyvsoxr/iLt8NttiGm3Urk4RQSd+LAbTo
         D6NDUEikdcSkvak9+XiYkndOm+sTeXweCV02UVaQZMRXhnRduUCqyXXvqy6VfWVpciZe
         GUgqtae/CaBaD9CkDn58TTijOsLFfBuaXC+6EYmdi+OlDtczOo5TFHR40QqzFbP0z/Sd
         MEuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707353657; x=1707958457;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z6dmCZv6ryQImcytK9h5IgucEGeDcfHtKgfnCRmY4OQ=;
        b=KD4JVXADbP0DnT+U10Vmxe2vOhWR5V9qO3/cMGs44J5nuyLOFyL4/fXw8dP8HQCRqG
         M/vO15YDFvmItzhZLpnyowAW8UXHBlvuPOuXJMDPuUZrxoE3vgkX0QlH7sBSl0LeJxkL
         X6EEvBAh2QRNKYlc6J9JL31lNqzpOM5p86adw6tKPItMdybE+NEymyAFnwPNl1AEJirz
         3x87SVQAkuCZGHsZUe8sKk1y6YS8+uzfSTwLADTXFri8oaz3qGFNbEEmB/lwYU9ARXpp
         sXiJ9ByZoEtHVBgqOxIU4Q11hj/v8H0fAhK/l8eC44EIlOvDL/08WHkLO5M7Q0xu0e7f
         i5NQ==
X-Forwarded-Encrypted: i=1; AJvYcCXskNsEbp2cGNq+gcrzKOvhzrqwtCSQfo6NpdFofkUW5GrOnWAUTh4i4RNTSjnPNbpTn0s6+iQXBctmPTh3TZDlMRaj
X-Gm-Message-State: AOJu0YzRa/H1H6tBGZqvDN/VBtWPYg+w3kTeTFc/stPtyLXk+jl5z+/5
	HlIMglwv9tAw8PAUerAIcxmos4bfRnnsYa5j4pdIkv1pVEPYjJ6+YxycWKMX
X-Google-Smtp-Source: AGHT+IG+LjZp8tmxLybLB8H36k53H2UqRwiNaogq0lVb7w3eljlomN0pc1levzayhYa0H3zaSkKc0w==
X-Received: by 2002:a81:f206:0:b0:604:3d5c:e1f5 with SMTP id i6-20020a81f206000000b006043d5ce1f5mr7337091ywm.1.1707353656690;
        Wed, 07 Feb 2024 16:54:16 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW2LLiqIdOoDYOJ6/4SufG12EXg/mdQWZKzb6CM4ced6UZcvvsBqY9u5uodUoS1wOh2lWWX6E5mjHJqY4mO2BvVVOzkFhZbX4cwgqphT86TKjqQXaNlkv8Il3fCz3HWCp3ZYLjNnU5TNkEEGZmHzQTqrANrz+oQMrh+MxKysgaV4AMl9MZV+YH3egLVGXlxDtb5tHZrCUGowQCl28yctdbL/Dip09xfLPVBfHjqbFg72cS425vVRkMtjrbvoZ7q8gIp2OZdXNYXjbVvuTrT+g==
Received: from ?IPV6:2600:1700:6cf8:1240:50ba:b8f8:e3dd:4d24? ([2600:1700:6cf8:1240:50ba:b8f8:e3dd:4d24])
        by smtp.gmail.com with ESMTPSA id m64-20020a0dca43000000b005f9673cb763sm500761ywd.126.2024.02.07.16.54.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Feb 2024 16:54:16 -0800 (PST)
Message-ID: <dc40bb5e-4622-4a77-b407-bfa7c4307ca8@gmail.com>
Date: Wed, 7 Feb 2024 16:54:14 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v5 3/3] selftests/bpf: Test PTR_MAYBE_NULL
 arguments of struct_ops operators.
Content-Language: en-US
To: Martin KaFai Lau <martin.lau@linux.dev>, thinker.li@gmail.com
Cc: kuifeng@meta.com, bpf@vger.kernel.org, ast@kernel.org, song@kernel.org,
 kernel-team@meta.com, andrii@kernel.org, davemarchevsky@meta.com,
 dvernet@meta.com
References: <20240206063833.2520479-1-thinker.li@gmail.com>
 <20240206063833.2520479-4-thinker.li@gmail.com>
 <cec9564d-ea2d-4d18-9b79-e312d1af1a25@linux.dev>
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <cec9564d-ea2d-4d18-9b79-e312d1af1a25@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2/7/24 14:38, Martin KaFai Lau wrote:
> On 2/5/24 10:38 PM, thinker.li@gmail.com wrote:
>> From: Kui-Feng Lee <thinker.li@gmail.com>
>>
>> Test if the verifier verifies nullable pointer arguments correctly for 
>> BPF
>> struct_ops programs.
>>
>> "test_maybe_null" in struct bpf_testmod_ops is the operator defined 
>> for the
>> test cases here. It has several pointer arguments to various types. These
>> pointers are majorly classified to 3 categories; pointers to struct 
>> types,
>> pointers to scalar types, and pointers to array types. They are handled
>> sightly differently.
> 
> The commit message needs an update. probably make sense to skip what 
> pointer type is supported because this patch set does not change that.

Agree!

> 
>>
>> A BPF program should check a pointer for NULL beforehand to access the
>> value pointed by the nullable pointer arguments, or the verifier should
>> reject the programs. The test here includes two parts; the programs
>> checking pointers properly and the programs not checking pointers
>> beforehand. The test checks if the verifier accepts the programs checking
>> properly and rejects the programs not checking at all.
>>
>> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
>> ---
>>   .../selftests/bpf/bpf_testmod/bpf_testmod.c   | 12 ++++-
>>   .../selftests/bpf/bpf_testmod/bpf_testmod.h   |  7 +++
>>   .../prog_tests/test_struct_ops_maybe_null.c   | 47 +++++++++++++++++++
>>   .../bpf/progs/struct_ops_maybe_null.c         | 31 ++++++++++++
>>   .../bpf/progs/struct_ops_maybe_null_fail.c    | 25 ++++++++++
>>   5 files changed, 121 insertions(+), 1 deletion(-)
>>   create mode 100644 
>> tools/testing/selftests/bpf/prog_tests/test_struct_ops_maybe_null.c
>>   create mode 100644 
>> tools/testing/selftests/bpf/progs/struct_ops_maybe_null.c
>>   create mode 100644 
>> tools/testing/selftests/bpf/progs/struct_ops_maybe_null_fail.c
>>
>> diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c 
>> b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
>> index a06daebc75c9..891a2b5f422c 100644
>> --- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
>> +++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
>> @@ -555,7 +555,10 @@ static int bpf_dummy_reg(void *kdata)
>>   {
>>       struct bpf_testmod_ops *ops = kdata;
>> -    ops->test_2(4, 3);
>> +    if (ops->test_maybe_null)
>> +        ops->test_maybe_null(0, NULL);
> 
> afaict, the "static void maybe_null(void)" test below does not exercise 
> this line of change.

I will remove it.

> 
>> +    else
>> +        ops->test_2(4, 3);
>>       return 0;
>>   }
>> @@ -573,9 +576,16 @@ static void bpf_testmod_test_2(int a, int b)
>>   {
>>   }
>> +static int bpf_testmod_ops__test_maybe_null(int dummy,
>> +                        struct task_struct *task__nullable)
>> +{
>> +    return 0;
>> +}
>> +
>>   static struct bpf_testmod_ops __bpf_testmod_ops = {
>>       .test_1 = bpf_testmod_test_1,
>>       .test_2 = bpf_testmod_test_2,
>> +    .test_maybe_null = bpf_testmod_ops__test_maybe_null,
>>   };
>>   struct bpf_struct_ops bpf_bpf_testmod_ops = {
>> diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.h 
>> b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.h
>> index 537beca42896..c51580c9119d 100644
>> --- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.h
>> +++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.h
>> @@ -5,6 +5,8 @@
>>   #include <linux/types.h>
>> +struct task_struct;
>> +
>>   struct bpf_testmod_test_read_ctx {
>>       char *buf;
>>       loff_t off;
>> @@ -28,9 +30,14 @@ struct bpf_iter_testmod_seq {
>>       int cnt;
>>   };
>> +typedef u32 (*ar_t)[2];
>> +typedef u32 (*ar2_t)[];
> 
> They are not needed in v5.

Sure!

> 
>> +
>>   struct bpf_testmod_ops {
>>       int (*test_1)(void);
>>       void (*test_2)(int a, int b);
>> +    /* Used to test nullable arguments. */
>> +    int (*test_maybe_null)(int dummy, struct task_struct *task);
>>   };
>>   #endif /* _BPF_TESTMOD_H */
>> diff --git 
>> a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_maybe_null.c 
>> b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_maybe_null.c
>> new file mode 100644
>> index 000000000000..1c057c62d893
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_maybe_null.c
>> @@ -0,0 +1,47 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
>> +#include <test_progs.h>
>> +#include <time.h>
> 
> Why time.h?

It should be removed now.

> 
>> +
>> +#include "struct_ops_maybe_null.skel.h"
>> +#include "struct_ops_maybe_null_fail.skel.h"
>> +
>> +/* Test that the verifier accepts a program that access a nullable 
>> pointer
>> + * with a proper check.
>> + */
>> +static void maybe_null(void)
>> +{
>> +    struct struct_ops_maybe_null *skel;
>> +
>> +    skel = struct_ops_maybe_null__open_and_load();
>> +    if (!ASSERT_OK_PTR(skel, "struct_ops_module_open_and_load"))
>> +        return;
>> +
>> +    struct_ops_maybe_null__destroy(skel);
>> +}
>> +
>> +/* Test that the verifier rejects a program that access a nullable 
>> pointer
>> + * without a check beforehand.
>> + */
>> +static void maybe_null_fail(void)
>> +{
>> +    struct struct_ops_maybe_null_fail *skel;
>> +
>> +    skel = struct_ops_maybe_null_fail__open_and_load();
>> +    if (ASSERT_ERR_PTR(skel, "struct_ops_module_fail__open_and_load"))
>> +        return;
>> +
>> +    struct_ops_maybe_null_fail__destroy(skel);
>> +}
>> +
>> +void test_struct_ops_maybe_null(void)
>> +{
>> +    /* The verifier verifies the programs at load time, so testing both
>> +     * programs in the same compile-unit is complicated. We run them in
>> +     * separate objects to simplify the testing.
>> +     */
>> +    if (test__start_subtest("maybe_null"))
>> +        maybe_null();
>> +    if (test__start_subtest("maybe_null_fail"))
>> +        maybe_null_fail();
>> +}
>> diff --git a/tools/testing/selftests/bpf/progs/struct_ops_maybe_null.c 
>> b/tools/testing/selftests/bpf/progs/struct_ops_maybe_null.c
>> new file mode 100644
>> index 000000000000..c5769c742900
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/progs/struct_ops_maybe_null.c
>> @@ -0,0 +1,31 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
>> +#include <vmlinux.h>
>> +#include <bpf/bpf_helpers.h>
>> +#include <bpf/bpf_tracing.h>
>> +#include "../bpf_testmod/bpf_testmod.h"
>> +
>> +char _license[] SEC("license") = "GPL";
>> +
>> +u64 tgid = 0;
> 
> u64 here.
> 
>> +
>> +/* This is a test BPF program that uses struct_ops to access an argument
>> + * that may be NULL. This is a test for the verifier to ensure that 
>> it can
>> + * rip PTR_MAYBE_NULL correctly. There are tree pointers; task, 
>> scalar, and
>> + * ar. They are used to test the cases of PTR_TO_BTF_ID, PTR_TO_BUF, 
>> and array.
>> + */
>> +SEC("struct_ops/test_maybe_null")
>> +int BPF_PROG(test_maybe_null, int dummy,
>> +         struct task_struct *task)
>> +{
>> +    if (task)
>> +        tgid = task->tgid;
>> +
>> +    return 0;
>> +}
>> +
>> +SEC(".struct_ops.link")
>> +struct bpf_testmod_ops testmod_1 = {
>> +    .test_maybe_null = (void *)test_maybe_null,
>> +};
>> +
>> diff --git 
>> a/tools/testing/selftests/bpf/progs/struct_ops_maybe_null_fail.c 
>> b/tools/testing/selftests/bpf/progs/struct_ops_maybe_null_fail.c
>> new file mode 100644
>> index 000000000000..566be47fb40b
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/progs/struct_ops_maybe_null_fail.c
>> @@ -0,0 +1,25 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
>> +#include <vmlinux.h>
>> +#include <bpf/bpf_helpers.h>
>> +#include <bpf/bpf_tracing.h>
>> +#include "../bpf_testmod/bpf_testmod.h"
>> +
>> +char _license[] SEC("license") = "GPL";
>> +
>> +int tgid = 0;
> 
> but int here.
> 
> understand that it does not matter and not the focus of this test but 
> still better be consistent and use the correct one.

I will chnage them to pid_t.

> 
>> +
>> +SEC("struct_ops/test_maybe_null_struct_ptr")
>> +int BPF_PROG(test_maybe_null_struct_ptr, int dummy,
>> +         struct task_struct *task)
>> +{
>> +    tgid = task->tgid;
>> +
>> +    return 0;
>> +}
>> +
>> +SEC(".struct_ops.link")
>> +struct bpf_testmod_ops testmod_struct_ptr = {
>> +    .test_maybe_null = (void *)test_maybe_null_struct_ptr,
>> +};
>> +
> 

