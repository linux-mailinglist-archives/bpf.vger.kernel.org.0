Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5258F68E53B
	for <lists+bpf@lfdr.de>; Wed,  8 Feb 2023 02:05:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbjBHBFm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Feb 2023 20:05:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbjBHBFl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 7 Feb 2023 20:05:41 -0500
X-Greylist: delayed 102498 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 07 Feb 2023 17:05:39 PST
Received: from out-140.mta1.migadu.com (out-140.mta1.migadu.com [IPv6:2001:41d0:203:375::8c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E405B13D51
        for <bpf@vger.kernel.org>; Tue,  7 Feb 2023 17:05:39 -0800 (PST)
Message-ID: <616140cf-b2e1-5bca-a6cb-8057c7d9ae0d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1675818338;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0kuTdAUIE6/TXj87b59BOlU5zp58IKFwDaWZ5de5JdE=;
        b=vjoVDtdSyvQ/T9UFsSZ8Ds130BTobH1T9HzQQN5Um0Jc8zZiUvqFpmyjMDgZdc4jCp4IUo
        uW5orS2d2V/1vCLf9z6MLaIJiVSUDBqCzKqiRYZk0GhVqP2FaGFGv7clGi99tllAXXw7+Y
        aRUR3tOldvdgt5vh77btbAjDFnsFi6U=
Date:   Tue, 7 Feb 2023 17:05:29 -0800
MIME-Version: 1.0
Subject: Re: [PATCH v2 bpf-next] Add support for tracing programs in
 BPF_PROG_RUN
Content-Language: en-US
To:     Grant Seltzer Richman <grantseltzer@gmail.com>
Cc:     andrii@kernel.org, kpsingh@kernel.org, bpf@vger.kernel.org
References: <20230203182812.20657-1-grantseltzer@gmail.com>
 <6433db0e-5cc6-8acc-b92f-eb5e17f032d6@linux.dev>
 <CAO658oVRQTL8HfKFJ3X8zjYRLJCQWROjzyOcXeP=uVRML1UYOw@mail.gmail.com>
 <f2afdc22-a9c1-eaad-fab4-2ff61b409282@linux.dev>
 <CAO658oUUZf2eAA-hRvGm8=u9bX-g2xXxB_Vvr1b5Bg=wKX6xQw@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <CAO658oUUZf2eAA-hRvGm8=u9bX-g2xXxB_Vvr1b5Bg=wKX6xQw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 2/7/23 7:46 AM, Grant Seltzer Richman wrote:
> On Mon, Feb 6, 2023 at 3:37 PM Martin KaFai Lau <martin.lau@linux.dev> wrote:
>>
>> On 2/5/23 9:29 AM, Grant Seltzer Richman wrote:
>>> On Sat, Feb 4, 2023 at 1:58 AM Martin KaFai Lau <martin.lau@linux.dev> wrote:
>>>>
>>>> On 2/3/23 10:28 AM, Grant Seltzer wrote:
>>>>> This patch changes the behavior of how BPF_PROG_RUN treats tracing
>>>>> (fentry/fexit) programs. Previously only a return value is injected
>>>>> but the actual program was not run.
>>>>
>>>> hmm... I don't understand this. The actual program is run by attaching to the
>>>> bpf_fentry_test{1,2,3...}. eg. The test in fentry_test.c
>>>
>>> I'm not sure what you mean. Are you saying in order to use the
>>> BPF_PROG_RUN bpf syscall command the user must first attach to
>>> `bpf_fentry_test1` (or any 1-8), and then execute the BPF_PROG_RUN?
>>
>> It is how the fentry/fexit/fmod_ret...BPF_PROG_TYPE_TRACIN_xxx prog is setup to
>> run now in test_run. afaik, these tracing progs require the trampoline setup
>> before calling the bpf prog, so don't understand how __bpf_prog_test_run_tracing
>> will work safely.
> 
> My goal is to be able to take a bpf program of type
> BPF_PROG_TYPE_TRACING and run it via BPF_PROG_TEST_RUN without having
> to attach it. The motivation is testing. You can run tracing programs
> but the actual program isn't run, from the users perspective the
> syscall just returns 0. You can see how I'm testing this here [1].
> 
> If I understand you correctly, it's possible to do something like
> this, can you give me more information on how I can and I'll be sure
> to submit documentation for it?
> 
> [1] https://github.com/grantseltzer/bpf-prog-test-run/tree/main/programs

In raw tracepoint, the "ctx" is just a u64 array for the args.

fentry/fexit/fmod_ret is much demanding than preparing a u64 array. The 
trampoline is preparing more than just 'args'. The trampoline is likely to be 
expanded and changed in the future also. You can take a look at 
arch_prepare_bpf_trampoline().

Yes, might be the trampoline preparation can be reused. However, I am not 
convinced tracing program can be tested through test_run in a meaningful and 
reliable way to worth this complication. eg. A tracing function taking 'struct 
task_struct *task'. It is not easy for the user space program to prepare the ctx 
containing a task_struct and the task_struct layout may change also. There are 
so many traceable kernel functions and I don't think test_run can ever become a 
single point to test tracing prog for all kernel functions.
[ Side-note: test_run for skb/xdp has much narrower focus in terms of argument 
because it is driven by the packet header like the standard IPv6/TCP/UDP. ]

Even for bpf_prog_test_run_raw_tp, the raw_tp_test_run.c is mostly testing if 
the prog is running on a particular cpu. It is not looking into the args which 
is what the tracing prog usually does.

Please attach the tracing prog to the kernel function to test
or reuse the existing bpf_prog_test_run_raw_tp to test it if it does not care 
the args.

