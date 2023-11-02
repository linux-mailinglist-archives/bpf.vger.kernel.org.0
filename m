Return-Path: <bpf+bounces-13880-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D40357DEA4E
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 02:44:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34D0EB21137
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 01:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25E4215B8;
	Thu,  2 Nov 2023 01:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Ur92OU+H"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D243E10E7
	for <bpf@vger.kernel.org>; Thu,  2 Nov 2023 01:43:51 +0000 (UTC)
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [IPv6:2001:41d0:203:375::b7])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7EC911B
	for <bpf@vger.kernel.org>; Wed,  1 Nov 2023 18:43:46 -0700 (PDT)
Message-ID: <223ab9b2-ca4b-4670-449b-5256af5e589a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1698889425;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mYBbhHHkCKmmFs0ccbKplTN6E7iYSAMFJRXU7YWB1YY=;
	b=Ur92OU+HPHZ6n5NPr62KIudKOU6It5vWOh5mFvXFh3H3YDJUdMcaoMAlonK6SRrmD7NHVb
	I3cgnjHVHXN+bcL4qnwi8NDPu0KgmX+W2r6eYpUDYEgR8Xk9efk3bA/O+iu2P8RcTkrYVs
	PXRR2aeLYAR4ST5dhq6+Vq+JfGoup0Y=
Date: Wed, 1 Nov 2023 18:43:40 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v8 10/10] selftests/bpf: test case for
 register_bpf_struct_ops().
Content-Language: en-US
To: Kui-Feng Lee <sinquersw@gmail.com>, thinker.li@gmail.com
Cc: kuifeng@meta.com, bpf@vger.kernel.org, ast@kernel.org, song@kernel.org,
 kernel-team@meta.com, andrii@kernel.org, drosen@google.com
References: <20231030192810.382942-1-thinker.li@gmail.com>
 <20231030192810.382942-11-thinker.li@gmail.com>
 <ee0d2862-7bc8-76da-1eca-30b3c80858a0@linux.dev>
 <c1267fed-e982-46ab-b0c7-83bed4108cd3@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <c1267fed-e982-46ab-b0c7-83bed4108cd3@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 10/31/23 5:30 PM, Kui-Feng Lee wrote:
> 
> 
> On 10/30/23 23:59, Martin KaFai Lau wrote:
>> On 10/30/23 12:28 PM, thinker.li@gmail.com wrote:
>>> diff --git a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c 
>>> b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
>>> new file mode 100644
>>> index 000000000000..3a00dc294583
>>> --- /dev/null
>>> +++ b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
>>> @@ -0,0 +1,39 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +/* Copyright (c) 2023 Meta Platforms, Inc. and affiliates. */
>>> +#include <test_progs.h>
>>> +#include <time.h>
>>> +
>>> +#include "rcu_tasks_trace_gp.skel.h"
>>> +#include "struct_ops_module.skel.h"
>>> +
>>> +static void test_regular_load(void)
>>> +{
>>> +    struct struct_ops_module *skel;
>>> +    struct bpf_link *link;
>>> +    DECLARE_LIBBPF_OPTS(bpf_object_open_opts, opts);
>>> +    int err;
>>> +
>>> +    skel = struct_ops_module__open_opts(&opts);
>>> +    if (!ASSERT_OK_PTR(skel, "struct_ops_module_open"))
>>> +        return;
>>> +    err = struct_ops_module__load(skel);
>>> +    if (!ASSERT_OK(err, "struct_ops_module_load"))
>>> +        return;
>>> +
>>> +    link = bpf_map__attach_struct_ops(skel->maps.testmod_1);
>>> +    ASSERT_OK_PTR(link, "attach_test_mod_1");
>>> +
>>> +    /* test_2() will be called from bpf_dummy_reg() in bpf_testmod.c */
>>> +    ASSERT_EQ(skel->bss->test_2_result, 7, "test_2_result");
>>> +
>>> +    bpf_link__destroy(link);
>>> +
>>> +    struct_ops_module__destroy(skel);
>>> +}
>>> +
>>> +void serial_test_struct_ops_module(void)
>>> +{
>>> +    if (test__start_subtest("regular_load"))
>>> +        test_regular_load();
>>
>> Could it also add some negative tests, e.g. missing 'struct 
>> bpf_struct_ops_common_value', reg() when the module is gone...etc.
>>
>> [ ... ]
>>
>>> +/* This function will trigger call_rcu_tasks_trace() in the kernel */
>>> +static int kern_sync_rcu_tasks_trace(void)
>>
>> With patch 4, is it still needed?
> 
> Patch 4 shortens time of holding the module, but it still can happen
> since bpf_link_put() is performed asynchronously.

Is the link pinned to a file that triggers bpf_link_put()?
Otherwise, close() should reach bpf_link_put_direct() which is synchronous.

Even if it went through bpf_link_put(), rcu_tasks_trace_gp is very specific to 
the bpf sleepable tracing prog. Is it the correct one to wait?

> 
>>
>>> +{
>>> +    struct rcu_tasks_trace_gp *rcu;
>>> +    time_t start;
>>> +    long gp_seq;
>>> +    LIBBPF_OPTS(bpf_test_run_opts, opts);
>>> +
>>> +    rcu = rcu_tasks_trace_gp__open_and_load();
>>> +    if (IS_ERR(rcu))
>>> +        return -EFAULT;
>>> +    if (rcu_tasks_trace_gp__attach(rcu))
>>> +        return -EFAULT;
>>> +
>>> +    gp_seq = READ_ONCE(rcu->bss->gp_seq);
>>> +
>>> +    if 
>>> (bpf_prog_test_run_opts(bpf_program__fd(rcu->progs.do_call_rcu_tasks_trace),
>>> +                   &opts))
>>> +        return -EFAULT;
>>> +    if (opts.retval != 0)
>>> +        return -EFAULT;
>>> +
>>> +    start = time(NULL);
>>> +    while ((start + 2) > time(NULL) &&
>>> +           gp_seq == READ_ONCE(rcu->bss->gp_seq))
>>> +        sched_yield();
>>> +
>>> +    rcu_tasks_trace_gp__destroy(rcu);
>>> +
>>> +    return 0;
>>> +}
>>> +
>>>   /*
>>>    * Trigger synchronize_rcu() in kernel.
>>>    */
>>>   int kern_sync_rcu(void)
>>>   {
>>> +    if (kern_sync_rcu_tasks_trace())
>>> +        return -EFAULT;
>>>       return syscall(__NR_membarrier, MEMBARRIER_CMD_SHARED, 0, 0);
>>>   }
>>


