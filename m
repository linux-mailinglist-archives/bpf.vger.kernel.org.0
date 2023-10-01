Return-Path: <bpf+bounces-11168-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E297C7B4622
	for <lists+bpf@lfdr.de>; Sun,  1 Oct 2023 10:21:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 95375284754
	for <lists+bpf@lfdr.de>; Sun,  1 Oct 2023 08:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7509214F6F;
	Sun,  1 Oct 2023 08:21:20 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C7C9CA59
	for <bpf@vger.kernel.org>; Sun,  1 Oct 2023 08:21:18 +0000 (UTC)
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA4D6C6
	for <bpf@vger.kernel.org>; Sun,  1 Oct 2023 01:21:16 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-690ba63891dso12224231b3a.2
        for <bpf@vger.kernel.org>; Sun, 01 Oct 2023 01:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1696148476; x=1696753276; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nb2D3LuQXiqDzGOTpeZzuHnR6ZfiMCGFmdYta0VCauI=;
        b=BNdqHacUuGF9KIhNxHqfX/PSVxUjgTKkJY5g845ujOsvAcxhe2NvYVP1vpWoNUEu0Z
         ZQLjHeLuMxArel/PNxQgFcz7ZTj6Sa6MkPZGtUjX/azGxaKy7o420hc6OFu/7MtWr5kN
         MOkNtE7yCDHQaiUZBxyTAYYbhQmaVXXaYt3Iyl/aZSlWomrsHFHbgsVlSAZk0AUk7n6u
         uYhLEqJoNkCINyyrpY4DiDcUHXH6AjhBPxh2FN6bIOulG4HW2SStoogQc5dLYejh7gSb
         Cj1Fwe0GVPudTNNFxy1lcQrfOXRfeetlNOegSnxaASUJREoA/U3+DS9KbEVNgD2M04cP
         CvSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696148476; x=1696753276;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nb2D3LuQXiqDzGOTpeZzuHnR6ZfiMCGFmdYta0VCauI=;
        b=G6cp5X0pRLsVBwutF0fU0RsjUkIhCvepcj4rGn/l3yOVqD762j13Rd3btophGl8usE
         RfNVTteu0CVu/kxtcjhN2Q8g2aSp6fuqH2YIOJx/b20iQfGqU7dlKYY0JsJiip+VYcHn
         nae8R6iL9hI/qZsIZSt4bV58aZuR2W6u0xaZw0lgJAW/ebk4SKAAqvrZFFOnQPMip8xV
         sP4kpYz/6zFL+zem0m6Lhwxblp1vWUQzcTtqWlnbrO6BLrNxe2fz9dM8Z7693a6FD8Sl
         z92uq8R/vIiABX70RG2bipc7HJj5WZ6iKD+fRgMqlzrcTbg24F4Sbu2KorxF72bdq3Y5
         Logw==
X-Gm-Message-State: AOJu0Yy7cHsDNiHaDL3205W+1ebLTFdiGdd41O6ZKC49EJgcqrsKswYe
	53ZS/obKmC3LJvdE6mPTfZjAzQ==
X-Google-Smtp-Source: AGHT+IHSbN28+T0fwUvP9GyB72rIm+vRF8T2jfcpUGcg1FbAADZsCOPu/+wOGpe2l59nBarDraHgWA==
X-Received: by 2002:aa7:88c3:0:b0:68a:4261:ab7f with SMTP id k3-20020aa788c3000000b0068a4261ab7fmr8452493pff.31.1696148476108;
        Sun, 01 Oct 2023 01:21:16 -0700 (PDT)
Received: from ?IPV6:2409:8a28:5060:6c21:2872:efd0:e8fb:f8d8? ([2409:8a28:5060:6c21:2872:efd0:e8fb:f8d8])
        by smtp.gmail.com with ESMTPSA id g23-20020aa78197000000b00684ca1b45b9sm17972119pfi.149.2023.10.01.01.21.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Oct 2023 01:21:15 -0700 (PDT)
Message-ID: <425309da-ec03-df8b-3565-d226dd1a1715@bytedance.com>
Date: Sun, 1 Oct 2023 16:21:08 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH bpf-next v3 3/7] bpf: Introduce task open coded iterator
 kfuncs
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@kernel.org, tj@kernel.org,
 linux-kernel@vger.kernel.org
References: <20230925105552.817513-1-zhouchuyi@bytedance.com>
 <20230925105552.817513-4-zhouchuyi@bytedance.com>
 <CAEf4BzZFBFPMBs6t4GM7GRt-c-Po9KkQqxQ_Zo9vuG=KuqeLzQ@mail.gmail.com>
 <716adfa5-bd5d-3fe2-108c-ff24b2e81420@bytedance.com>
 <CAEf4BzaAtybx=Cbb6zD1otgQ-Jm+Xta0_8rwmL_ZYb3GzjSwWg@mail.gmail.com>
From: Chuyi Zhou <zhouchuyi@bytedance.com>
In-Reply-To: <CAEf4BzaAtybx=Cbb6zD1otgQ-Jm+Xta0_8rwmL_ZYb3GzjSwWg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello, Andrii

在 2023/9/30 05:27, Andrii Nakryiko 写道:
> On Wed, Sep 27, 2023 at 8:29 PM Chuyi Zhou <zhouchuyi@bytedance.com> wrote:
>>
>> Hello,
>>
>> 在 2023/9/28 07:20, Andrii Nakryiko 写道:
>>> On Mon, Sep 25, 2023 at 3:56 AM Chuyi Zhou <zhouchuyi@bytedance.com> wrote:
>>>>
>>>> This patch adds kfuncs bpf_iter_task_{new,next,destroy} which allow
>>>> creation and manipulation of struct bpf_iter_task in open-coded iterator
>>>> style. BPF programs can use these kfuncs or through bpf_for_each macro to
>>>> iterate all processes in the system.
>>>>
>>>> The API design keep consistent with SEC("iter/task"). bpf_iter_task_new()
>>>> accepts a specific task and iterating type which allows:
>>>> 1. iterating all process in the system
>>>>
>>>> 2. iterating all threads in the system
>>>>
>>>> 3. iterating all threads of a specific task
>>>> Here we also resuse enum bpf_iter_task_type and rename BPF_TASK_ITER_TID
>>>> to BPF_TASK_ITER_THREAD, rename BPF_TASK_ITER_TGID to BPF_TASK_ITER_PROC.
>>>>
>>>> The newly-added struct bpf_iter_task has a name collision with a selftest
>>>> for the seq_file task iter's bpf skel, so the selftests/bpf/progs file is
>>>> renamed in order to avoid the collision.
>>>>
>>>> Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>
>>>> ---
>>>>    include/linux/bpf.h                           |  8 +-
>>>>    kernel/bpf/helpers.c                          |  3 +
>>>>    kernel/bpf/task_iter.c                        | 96 ++++++++++++++++---
>>>>    .../testing/selftests/bpf/bpf_experimental.h  |  5 +
>>>>    .../selftests/bpf/prog_tests/bpf_iter.c       | 18 ++--
>>>>    .../{bpf_iter_task.c => bpf_iter_tasks.c}     |  0
>>>>    6 files changed, 106 insertions(+), 24 deletions(-)
>>>>    rename tools/testing/selftests/bpf/progs/{bpf_iter_task.c => bpf_iter_tasks.c} (100%)
>>>>
>>>


[...]

>>>> +get_next_task:
>>>> +       kit->pos = next_task(kit->pos);
>>>> +       kit->task = kit->pos;
>>>> +       if (kit->pos == &init_task)
>>>> +               kit->pos = NULL;
>>>
>>> I can't say I completely follow the logic (e.g., for
>>> BPF_TASK_ITER_PROC, why do we do next_task() on first next() call)?
>>> Can you elabore the expected behavior for various combinations of
>>> types and starting task argument?
>>>
>>
>> Thanks for the review.
>>
>> The expected behavior of current implementation is:
>>
>> BPF_TASK_ITER_PROC:
>>
>> init_task->first_process->second_process->...->last_process->init_task
>>
>> We would exit before visiting init_task again.
> 
> ah, ok, so in this case it's more like BPF_TASK_ITER_ALL_PROCS, i.e.,
> we iterate all processes in the system. Input `task` that we provide
> is ignored/meaningless, right? Maybe we should express it as
> ALL_PROCS?
> 
>>
>> BPF_TASK_ITER_THREAD:
>>
>> group_task->first_thread->second_thread->...->last_thread->group_task
>>
>> We would exit before visiting group_task again.
>>
> 
> And this one is iterating threads of a process specified by given
> `task`, right?   This is where my confusion comes from. ITER_PROC and
> ITER_THREAD, by their name, seems to be very similar, but in reality
> ITER_PROC is more like ITER_ALL (except process vs thread iteration),
> while ITER_THREAD is parameterized by input `task`.
> 
> I'm not sure what's the least confusing way to name and organize
> everything, but I think it's quite confusing right now, unfortunately.
> I wonder if you or someone else have a better suggestion on making
> this more straightforward?
> 

Maybe here we can introduce new enums and not reuse or rename 
BPF_TASK_ITER_TID/BPF_TASK_ITER_TGID?

{
BPF_TASK_ITER_ALL_PROC,
BPF_TASK_ITER_ALL_THREAD,
BPF_TASK_ITER_THREAD
}

BPF_TASK_ITER_TID/BPF_TASK_ITER_TGID are inner flags. Looking at the
example usage of SEC("iter/task"), unlike 
BPF_CGROUP_ITER_DESCENDANTS_PRE/BPF_CGROUP_ITER_DESCENDANTS_POST, we 
actually don't use BPF_TASK_ITER_TID/BPF_TASK_ITER_TGID directly. When 
using SEC("iter/task"), we just set pid/tid for struct 
bpf_iter_link_info. Exposing new enums to users for open coded 
task_iters will not confuse users.

Thanks.


