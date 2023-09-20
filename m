Return-Path: <bpf+bounces-10448-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C0757A7ED9
	for <lists+bpf@lfdr.de>; Wed, 20 Sep 2023 14:21:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1376D281AB0
	for <lists+bpf@lfdr.de>; Wed, 20 Sep 2023 12:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 140E530FA9;
	Wed, 20 Sep 2023 12:21:12 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD4E30FA4
	for <bpf@vger.kernel.org>; Wed, 20 Sep 2023 12:21:06 +0000 (UTC)
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0022EC2
	for <bpf@vger.kernel.org>; Wed, 20 Sep 2023 05:21:01 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-690d8fb3b7eso787042b3a.1
        for <bpf@vger.kernel.org>; Wed, 20 Sep 2023 05:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1695212461; x=1695817261; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mC7PMNi633RPauJRLcRRoFDPwY5qljFR3rrAcYTFakQ=;
        b=bxPgN5HPOfewUC3jeLYr5Jz5/8IognvhFpyTmfY6zLOJ8FZwfsTFI+VPCzBX+XkTJd
         oTK4XZCnTsKCbFvSEF5XjXbv0r1YE8Mt6xabiGddfTVM0oRU6//XyE0K2oPbjkBAAb8Z
         PfNSbtnhrBtOFXohPmt1UCR34Lt2LjoYFylGv8RjzGL5V4LZw3aXyqW8URQvQrTjmcve
         CQiCuCMo0VXS3pus+ZGHvoW0do1Hf5BOjX4g/MSV04lpX7m2KLOJD4YPJGLUmDbs2QsM
         5Cd8IkqCKPAsoZwmXIDlK/Edh70G9pyQy6/MSgEUHPVwtokSNxp9deh24gDT0R0r2ijv
         npZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695212461; x=1695817261;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mC7PMNi633RPauJRLcRRoFDPwY5qljFR3rrAcYTFakQ=;
        b=isOiFfk+PZ2Az3Mdo+jTRCM8ezqp0+iX1Sw5LCBjyJ6UI+v8jQF2Zd8YJ48fdR1kly
         gnfCwQYv4R8VZG0kby4JvY2JkHSCvSXqP18/jrcu5vpHCh4mugfH8F6Zr/O0TnvCgnLn
         q/5XsFyKwrSS+2GYajcQKu/mYM6tutcT8xQgHcZ07QDIXDMLOdGeJRHs655ivYeicMMk
         CzBAxKgEY2MsoEnM5mKWTKbtQE3QSjmRDkqRxrJhkXpLAC/SvdWIQdGo1F/IUNLnaXoV
         tOcwQCOLJuj4/HcHqy69sgJDFntmD3Tmaoo3OPOZ59X4xEAlsGPjaAsJCF5WiD5zpegU
         X3TA==
X-Gm-Message-State: AOJu0YyNU/1JI0PG5Mh0Pr5FteVNizVOwUKZ79YDdVOQzQoEPUDmzBlC
	gqmWtIVMQk+K+CwqNJq27JS+lmAhfheaZrXfqJc=
X-Google-Smtp-Source: AGHT+IFnEwGRvjyjrtYyQ+WUhx0lHHTvR3vXJmrWmSnm82kstTqE7wIfPUWiVpkAcKrNkCYMPuvDwg==
X-Received: by 2002:a05:6a20:7483:b0:14d:d636:ed3a with SMTP id p3-20020a056a20748300b0014dd636ed3amr2735388pzd.23.1695212461228;
        Wed, 20 Sep 2023 05:21:01 -0700 (PDT)
Received: from [10.84.145.144] ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id s24-20020aa78298000000b0068be348e35fsm10152148pfm.166.2023.09.20.05.20.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Sep 2023 05:21:00 -0700 (PDT)
Message-ID: <6a1bee69-962c-b28e-b21a-76377e932529@bytedance.com>
Date: Wed, 20 Sep 2023 20:20:54 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH bpf-next v2 3/6] bpf: Introduce process open coded
 iterator kfuncs
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@kernel.org, tj@kernel.org,
 linux-kernel@vger.kernel.org
References: <20230912070149.969939-1-zhouchuyi@bytedance.com>
 <20230912070149.969939-4-zhouchuyi@bytedance.com>
 <CAEf4BzbsBUGiPJ+_RG3c3WdEWNQy2b6h60kLDREcXDsNp3E0_Q@mail.gmail.com>
 <30eadbff-8340-a721-362b-ff82de03cb9f@bytedance.com>
 <CAEf4BzbM=v9KNtQQNcUSRs7mwwKa7FEsBFXO3T1+7KgpZVZKFw@mail.gmail.com>
 <67d07ab7-8202-4bbd-88d9-587707bd58b1@bytedance.com>
 <CAEf4Bzb_hMRbDU_0ibpzsf4eZ3mR4D=0SLu9E2dLHsP8=-ALiw@mail.gmail.com>
From: Chuyi Zhou <zhouchuyi@bytedance.com>
In-Reply-To: <CAEf4Bzb_hMRbDU_0ibpzsf4eZ3mR4D=0SLu9E2dLHsP8=-ALiw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



在 2023/9/20 07:30, Andrii Nakryiko 写道:
> On Sat, Sep 16, 2023 at 7:03 AM Chuyi Zhou <zhouchuyi@bytedance.com> wrote:
>>
>> Hello.
>>
>> 在 2023/9/16 04:37, Andrii Nakryiko 写道:
>>> On Fri, Sep 15, 2023 at 8:03 AM Chuyi Zhou <zhouchuyi@bytedance.com> wrote:
>>>> 在 2023/9/15 07:26, Andrii Nakryiko 写道:
>>>>> On Tue, Sep 12, 2023 at 12:02 AM Chuyi Zhou <zhouchuyi@bytedance.com> wrote:
>>>>>>
>>>>>> This patch adds kfuncs bpf_iter_process_{new,next,destroy} which allow
>>>>>> creation and manipulation of struct bpf_iter_process in open-coded iterator
>>>>>> style. BPF programs can use these kfuncs or through bpf_for_each macro to
>>>>>> iterate all processes in the system.
>>>>>>
>> [...cut...]
>>>>>
>>>>> Few high level thoughts. I think it would be good to follow
>>>>> SEC("iter/task") naming and approach. Open-coded iterators in many
>>>>> ways are in-kernel counterpart to iterator programs, so keeping them
>>>>> close enough within reason is useful for knowledge transfer.
>>>>>
>>>>> SEC("iter/task") allows to:
>>>>> a) iterate all threads in the system
>>>>> b) iterate all threads for a given TGID
>>>>> c) it also allows to "iterate" a single thread or process, but that's
>>>>> a bit less relevant for in-kernel iterator, but we can still support
>>>>> them, why not?
>>>>>
>>>>> I'm not sure if it supports iterating all processes (as in group
>>>>> leaders of each task group) in the system, but if it's possible I
>>>>> think we should support it at least for open-coded iterator, seems
>>>>> like a very useful functionality.
>>>>>
>>>>> So to that end, let's design a small set of input arguments for
>>>>> bpf_iter_process_new() that would allow to specify this as flags +
>>>>> either (optional) struct task_struct * pointer to represent
>>>>> task/process or PID/TGID.
>>>>>
>>>>
>>>> Another concern from Alexei was the readability of the API of open-coded
>>>> in BPF Program[1].
>>>>
>>>> bpf_for_each(task, curr) is straightforward. Users can easily understand
>>>> that this API does the same thing as 'for_each_process' in kernel.
>>>
>>> In general, users might have no idea about for_each_process macro in
>>> the kernel, so I don't find this particular argument very convincing.
>>>
>>> We can add a separate set of iterator kfuncs for every useful
>>> combination of conditions, of course, but it's a double-edged sword.
>>> Needing to use a different iterator just to specify a different
>>> direction of cgroup iteration (from the example you referred in [1])
>>> also means that it's now harder to write some generic function that
>>> needs to do something for all cgroups matching some criteria where the
>>> order might be coming as an argument.
>>>
>>> Similarly for task iterators. It's not hard to imagine some processing
>>> that can be equivalently done per thread or per process in the system,
>>> or on each thread of the process, depending on some conditions or
>>> external configuration. Having to do three different
>>> bpf_for_each(task_xxx, task, ...) for this seems suboptimal. If the
>>> nature of the thing that is iterated over is the same, and it's just a
>>> different set of filters to specify which subset of those items should
>>> be iterated, I think it's better to try to stick to the same iterator
>>> with few simple arguments. IMO, of course, there is no objectively
>>> best approach.
>>>
>>>>
>>>> However, if we keep the approach of SEC("iter/task")
>>>>
>>>> enum ITER_ITEM {
>>>>           ITER_TASK,
>>>>           ITER_THREAD,
>>>> }
>>>>
>>>> __bpf_kfunc int bpf_iter_task_new(struct bpf_iter_process *it, struct
>>>> task_struct *group_task, enum ITER_ITEM type)
>>>>
>>>> the API have to chang:
>>>>
>>>>
>>>> bpf_for_each(task, curr, NULL, ITERATE_TASK) // iterate all process in
>>>> the  system
>>>> bpf_for_each(task, curr, group_leader, ITERATE_THREAD) // iterate all
>>>> thread of group_leader
>>>> bpf_for_each(task, curr, NULL, ITERATE_THREAD) //iterate all threads of
>>>> all the process in the system
>>>>
>>>> Useres may guess what are this API actually doing....
>>>
>>> I'd expect users to consult documentation before trying to use an
>>> unfamiliar cutting-edge functionality. So let's try to keep
>>> documentation clear and up to the point. Extra flag argument doesn't
>>> seem to be a big deal.
>>
>> Thanks for your suggestion!
>>
>> Before we begin working on the next version, I have outlined a detailed
>> API design here:
>>
>> 1.task_iter
>>
>> It will be used to iterate process/threads like SEC("iter/task"). Here
>> we should better to follow the naming and approach SEC("iter/task"):
>>
>> enum {
>>          ITERATE_PROCESS,
>>          ITERATE_THREAD,
>> }
>>
>> __bpf_kfunc int bpf_iter_task_new(struct bpf_iter_task *it, struct
>> task_struct *task, int flag);
>>
>> If we want to iterate all processes in the system, the iteration will
>> start from the *task* which is passed from user.(since process in the
>> system are connected through a linked list)
> 
> but will go through all of them anyways, right? it's kind of
> surprising from usability standpoint to have to pass some task_struct
> to iterate all of them, tbh. I wonder if it's hard to adjust kfunc
> validation to allow "nullable" pointers? We can look at that
> separately, of course.
> 

Yes, little subtle here. When we want to iterate threads of a task, we 
may want the verifier to ensure the *task* is a valid pointer, which 
would require KF_TRUSTED_ARGS. However, when we want to iterate all 
process/threads in the system, we want to accept a null pointer.

Anyway, I will try to explore a workaround in the verifier here.

Thanks.


