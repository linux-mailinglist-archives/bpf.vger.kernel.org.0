Return-Path: <bpf+bounces-14004-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D67C7DF9DF
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 19:26:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FE6E1C2100B
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 18:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88CD721350;
	Thu,  2 Nov 2023 18:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X8hEBqsp"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD5421345
	for <bpf@vger.kernel.org>; Thu,  2 Nov 2023 18:26:19 +0000 (UTC)
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 904C5DB
	for <bpf@vger.kernel.org>; Thu,  2 Nov 2023 11:26:18 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-59b5484fbe6so15286387b3.1
        for <bpf@vger.kernel.org>; Thu, 02 Nov 2023 11:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698949578; x=1699554378; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=74nSallS3j8xeECFtOFKj7H69sXycPE9hP7FWXtl9Ac=;
        b=X8hEBqspEdZ0Tg56VrhdOK/TJgKR4goCS+KdreVnWevdYnArGYXHv/EQBc6VJH/cqR
         qr3D1JuW5w2VPjc9OY6/ZWBUwAVVc7WmHWATHTG9L5BiGojEjvjkxn9Fq+UtGJ5zUssE
         9+5eirkPs43JXkc02plkE97yCoPXAisOvuskaGWb6OZrQfNPwN6Y4+QTBlCNryLQ6kyE
         abXdx5VVgp8iHDkJvdNylBYwhj/RtgDcJFlV+jyCDs2+Mt+tU7oNH763m8xmiXjPAjaA
         MrUn4LyYGpm5b3VWlyIPwfGEvnKMorgfsxEl8964GIh8vw8Eh5YnXsm+h0SlzOcak6Qn
         XnDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698949578; x=1699554378;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=74nSallS3j8xeECFtOFKj7H69sXycPE9hP7FWXtl9Ac=;
        b=FsqT3meRaW6wJ3BGZEUtvXzHLi5hk+YN2YKleLb81AV8pm88ODUgPnj2UOZtn811bb
         YKWFa8YccJG0lYMKebMLtiCLqLEBkxY+2w3xXNKL4UavRXfHHehXS7RqIksEiBz9Sy1+
         qV5qbbWY4xb+KaJid6n1Dz0MyRhkb+MSWen1Jz0yAvMRYPMQdGgYNryM2cXcbcT46c2T
         qtKoxyDAB5FU/AxOCX4ZoitIrf/3exzRlgr8knJFiBC6MalpjTC0Iav48/Toq7Zid6d2
         TrkU40ki73HEuaNzsO3sI0zgnYUtvkEauKMjXmb26zy95i+YUplm2HRyRqDLCPgUEYwr
         3M4A==
X-Gm-Message-State: AOJu0YwiA0xO+vdJFrgSL2i3BVXIwsgfeJCyPr0ZT9ltrR5smxUJskwL
	mgUyavMkO9MQnGmrxGNCSNI=
X-Google-Smtp-Source: AGHT+IFBTl9Zxkcbpc7yejky5bKz7f/ZHJ8VrIScXpyFI2HvqnYlbpkm5pDnF7HOuJEEld8ZSehLNw==
X-Received: by 2002:a0d:ea95:0:b0:5a7:b96e:9693 with SMTP id t143-20020a0dea95000000b005a7b96e9693mr512806ywe.31.1698949577746;
        Thu, 02 Nov 2023 11:26:17 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:1dc1:b689:e61d:449f? ([2600:1700:6cf8:1240:1dc1:b689:e61d:449f])
        by smtp.gmail.com with ESMTPSA id l11-20020a81570b000000b005a8073e2062sm47576ywb.33.2023.11.02.11.26.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Nov 2023 11:26:17 -0700 (PDT)
Message-ID: <2b2bdd4a-9163-4d31-ad1a-fb8d96fa7dfd@gmail.com>
Date: Thu, 2 Nov 2023 11:26:15 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v8 10/10] selftests/bpf: test case for
 register_bpf_struct_ops().
Content-Language: en-US
To: Martin KaFai Lau <martin.lau@linux.dev>, thinker.li@gmail.com
Cc: kuifeng@meta.com, bpf@vger.kernel.org, ast@kernel.org, song@kernel.org,
 kernel-team@meta.com, andrii@kernel.org, drosen@google.com
References: <20231030192810.382942-1-thinker.li@gmail.com>
 <20231030192810.382942-11-thinker.li@gmail.com>
 <ee0d2862-7bc8-76da-1eca-30b3c80858a0@linux.dev>
 <c1267fed-e982-46ab-b0c7-83bed4108cd3@gmail.com>
 <223ab9b2-ca4b-4670-449b-5256af5e589a@linux.dev>
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <223ab9b2-ca4b-4670-449b-5256af5e589a@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 11/1/23 18:43, Martin KaFai Lau wrote:
> On 10/31/23 5:30 PM, Kui-Feng Lee wrote:
>>
>>
>> On 10/30/23 23:59, Martin KaFai Lau wrote:
>>> On 10/30/23 12:28 PM, thinker.li@gmail.com wrote:
>>>> diff --git 
>>>> a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c 
>>>> b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
>>>> new file mode 100644
>>>> index 000000000000..3a00dc294583
>>>> --- /dev/null
>>>> +++ b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
>>>> @@ -0,0 +1,39 @@
>>>> +// SPDX-License-Identifier: GPL-2.0
>>>> +/* Copyright (c) 2023 Meta Platforms, Inc. and affiliates. */
>>>> +#include <test_progs.h>
>>>> +#include <time.h>
>>>> +
>>>> +#include "rcu_tasks_trace_gp.skel.h"
>>>> +#include "struct_ops_module.skel.h"
>>>> +
>>>> +static void test_regular_load(void)
>>>> +{
>>>> +    struct struct_ops_module *skel;
>>>> +    struct bpf_link *link;
>>>> +    DECLARE_LIBBPF_OPTS(bpf_object_open_opts, opts);
>>>> +    int err;
>>>> +
>>>> +    skel = struct_ops_module__open_opts(&opts);
>>>> +    if (!ASSERT_OK_PTR(skel, "struct_ops_module_open"))
>>>> +        return;
>>>> +    err = struct_ops_module__load(skel);
>>>> +    if (!ASSERT_OK(err, "struct_ops_module_load"))
>>>> +        return;
>>>> +
>>>> +    link = bpf_map__attach_struct_ops(skel->maps.testmod_1);
>>>> +    ASSERT_OK_PTR(link, "attach_test_mod_1");
>>>> +
>>>> +    /* test_2() will be called from bpf_dummy_reg() in 
>>>> bpf_testmod.c */
>>>> +    ASSERT_EQ(skel->bss->test_2_result, 7, "test_2_result");
>>>> +
>>>> +    bpf_link__destroy(link);
>>>> +
>>>> +    struct_ops_module__destroy(skel);
>>>> +}
>>>> +
>>>> +void serial_test_struct_ops_module(void)
>>>> +{
>>>> +    if (test__start_subtest("regular_load"))
>>>> +        test_regular_load();
>>>
>>> Could it also add some negative tests, e.g. missing 'struct 
>>> bpf_struct_ops_common_value', reg() when the module is gone...etc.
>>>
>>> [ ... ]
>>>
>>>> +/* This function will trigger call_rcu_tasks_trace() in the kernel */
>>>> +static int kern_sync_rcu_tasks_trace(void)
>>>
>>> With patch 4, is it still needed?
>>
>> Patch 4 shortens time of holding the module, but it still can happen
>> since bpf_link_put() is performed asynchronously.
> 
> Is the link pinned to a file that triggers bpf_link_put()?
> Otherwise, close() should reach bpf_link_put_direct() which is synchronous.
> 
> Even if it went through bpf_link_put(), rcu_tasks_trace_gp is very 
> specific to the bpf sleepable tracing prog. Is it the correct one to wait?

You are right! We don't test pinned link. I will remove this part.

> 
>>
>>>
>>>> +{
>>>> +    struct rcu_tasks_trace_gp *rcu;
>>>> +    time_t start;
>>>> +    long gp_seq;
>>>> +    LIBBPF_OPTS(bpf_test_run_opts, opts);
>>>> +
>>>> +    rcu = rcu_tasks_trace_gp__open_and_load();
>>>> +    if (IS_ERR(rcu))
>>>> +        return -EFAULT;
>>>> +    if (rcu_tasks_trace_gp__attach(rcu))
>>>> +        return -EFAULT;
>>>> +
>>>> +    gp_seq = READ_ONCE(rcu->bss->gp_seq);
>>>> +
>>>> +    if 
>>>> (bpf_prog_test_run_opts(bpf_program__fd(rcu->progs.do_call_rcu_tasks_trace),
>>>> +                   &opts))
>>>> +        return -EFAULT;
>>>> +    if (opts.retval != 0)
>>>> +        return -EFAULT;
>>>> +
>>>> +    start = time(NULL);
>>>> +    while ((start + 2) > time(NULL) &&
>>>> +           gp_seq == READ_ONCE(rcu->bss->gp_seq))
>>>> +        sched_yield();
>>>> +
>>>> +    rcu_tasks_trace_gp__destroy(rcu);
>>>> +
>>>> +    return 0;
>>>> +}
>>>> +
>>>>   /*
>>>>    * Trigger synchronize_rcu() in kernel.
>>>>    */
>>>>   int kern_sync_rcu(void)
>>>>   {
>>>> +    if (kern_sync_rcu_tasks_trace())
>>>> +        return -EFAULT;
>>>>       return syscall(__NR_membarrier, MEMBARRIER_CMD_SHARED, 0, 0);
>>>>   }
>>>
> 

