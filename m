Return-Path: <bpf+bounces-10202-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E5CA7A30CC
	for <lists+bpf@lfdr.de>; Sat, 16 Sep 2023 16:04:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 565191C20B7E
	for <lists+bpf@lfdr.de>; Sat, 16 Sep 2023 14:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF8F41400A;
	Sat, 16 Sep 2023 14:03:50 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 591F9134D8
	for <bpf@vger.kernel.org>; Sat, 16 Sep 2023 14:03:49 +0000 (UTC)
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FC9DCD4
	for <bpf@vger.kernel.org>; Sat, 16 Sep 2023 07:03:47 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-68fdd6011f2so2477151b3a.3
        for <bpf@vger.kernel.org>; Sat, 16 Sep 2023 07:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1694873026; x=1695477826; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oj4pOI3pVs327qsHEGlUcaJ2/26WPRFSldanwmoKx0c=;
        b=N4P+uUxGnXVdU5xKTfwYny5j7YFUdG4gdBnGtQsWcmpdWD1VLy76saq8rhCblcuwsg
         7EkfMfzQ8fla9xlYKDGbGEwc/NWM4i3u2xCNw5JpP+MAfnqlObMj9WWhwETPDIHvE7/n
         BvzXXLcX8UHDPqdMEoBvD7BDosLDYGlg9Rgm4g9lR65lnsPoIlaYtHai51VYITeTetRd
         rn+U2u6c+DIfXxp9Ab80yDSOTJIFJ/tv/+KsPRdsWyq1VnP+Gx5WqQaPtr08N7nYNb1p
         WLnjUtW32u3WhTXBS+kn55amzOLmulO9f496nEOHrsQi5Yt4cUtvA+H1yiGEZU/zd+V5
         wogg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694873026; x=1695477826;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Oj4pOI3pVs327qsHEGlUcaJ2/26WPRFSldanwmoKx0c=;
        b=TUqQkyL15LKIzgILFDDMM9FxsaOnYLaKnrnt+QLSdv3MXKOJXywetLBnUYJTAAdKur
         3HHp5Tsb6EanvhSDG0GrnqUIKae5vK/5FEG/25TXRP3wyan+3++Laxf4VU4ZH9/p7pen
         72LR8WVF6u7lyfMGxn9ivbldQ3khppOnqCkw2gxVQs2WZNmlGsDbMO66SxpyACUUmO9M
         1ZYceDfWPHtopsqo0LQ0JOnYLFWXrEBc0YGJN0AJiwMb0aO8yT2/0Wypv1ZCg+ZIgVAu
         ntyRMfGrjDip0ZqfdxZtbng9DCDTvPH+OVd17SL1ThnhLbYxPDUprdSB7oxXjEIFQjGP
         AkXg==
X-Gm-Message-State: AOJu0YzEGjUp7te4a88vptOcAnmGFQ0j5E9pJvNo+M104o9Hm9aEXsOF
	K4+NqOgcmi82chfHI83W4gAD3tQUOXeDhKoMdcQ=
X-Google-Smtp-Source: AGHT+IEVzFXumo/J/QE/xF5PDDqrKhmcaVZNjrP37KzyfnDB3I5vEYYde0qucCyi444GkbUpzdEcEw==
X-Received: by 2002:a05:6a20:3cac:b0:15a:478f:9f2e with SMTP id b44-20020a056a203cac00b0015a478f9f2emr5411493pzj.1.1694873026408;
        Sat, 16 Sep 2023 07:03:46 -0700 (PDT)
Received: from [10.5.75.238] ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id n17-20020aa78a51000000b0068bc014f352sm4551431pfa.7.2023.09.16.07.03.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Sep 2023 07:03:44 -0700 (PDT)
Message-ID: <67d07ab7-8202-4bbd-88d9-587707bd58b1@bytedance.com>
Date: Sat, 16 Sep 2023 22:03:36 +0800
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
From: Chuyi Zhou <zhouchuyi@bytedance.com>
In-Reply-To: <CAEf4BzbM=v9KNtQQNcUSRs7mwwKa7FEsBFXO3T1+7KgpZVZKFw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello.

在 2023/9/16 04:37, Andrii Nakryiko 写道:
> On Fri, Sep 15, 2023 at 8:03 AM Chuyi Zhou <zhouchuyi@bytedance.com> wrote:
>> 在 2023/9/15 07:26, Andrii Nakryiko 写道:
>>> On Tue, Sep 12, 2023 at 12:02 AM Chuyi Zhou <zhouchuyi@bytedance.com> wrote:
>>>>
>>>> This patch adds kfuncs bpf_iter_process_{new,next,destroy} which allow
>>>> creation and manipulation of struct bpf_iter_process in open-coded iterator
>>>> style. BPF programs can use these kfuncs or through bpf_for_each macro to
>>>> iterate all processes in the system.
>>>>
[...cut...]
>>>
>>> Few high level thoughts. I think it would be good to follow
>>> SEC("iter/task") naming and approach. Open-coded iterators in many
>>> ways are in-kernel counterpart to iterator programs, so keeping them
>>> close enough within reason is useful for knowledge transfer.
>>>
>>> SEC("iter/task") allows to:
>>> a) iterate all threads in the system
>>> b) iterate all threads for a given TGID
>>> c) it also allows to "iterate" a single thread or process, but that's
>>> a bit less relevant for in-kernel iterator, but we can still support
>>> them, why not?
>>>
>>> I'm not sure if it supports iterating all processes (as in group
>>> leaders of each task group) in the system, but if it's possible I
>>> think we should support it at least for open-coded iterator, seems
>>> like a very useful functionality.
>>>
>>> So to that end, let's design a small set of input arguments for
>>> bpf_iter_process_new() that would allow to specify this as flags +
>>> either (optional) struct task_struct * pointer to represent
>>> task/process or PID/TGID.
>>>
>>
>> Another concern from Alexei was the readability of the API of open-coded
>> in BPF Program[1].
>>
>> bpf_for_each(task, curr) is straightforward. Users can easily understand
>> that this API does the same thing as 'for_each_process' in kernel.
> 
> In general, users might have no idea about for_each_process macro in
> the kernel, so I don't find this particular argument very convincing.
> 
> We can add a separate set of iterator kfuncs for every useful
> combination of conditions, of course, but it's a double-edged sword.
> Needing to use a different iterator just to specify a different
> direction of cgroup iteration (from the example you referred in [1])
> also means that it's now harder to write some generic function that
> needs to do something for all cgroups matching some criteria where the
> order might be coming as an argument.
> 
> Similarly for task iterators. It's not hard to imagine some processing
> that can be equivalently done per thread or per process in the system,
> or on each thread of the process, depending on some conditions or
> external configuration. Having to do three different
> bpf_for_each(task_xxx, task, ...) for this seems suboptimal. If the
> nature of the thing that is iterated over is the same, and it's just a
> different set of filters to specify which subset of those items should
> be iterated, I think it's better to try to stick to the same iterator
> with few simple arguments. IMO, of course, there is no objectively
> best approach.
> 
>>
>> However, if we keep the approach of SEC("iter/task")
>>
>> enum ITER_ITEM {
>>          ITER_TASK,
>>          ITER_THREAD,
>> }
>>
>> __bpf_kfunc int bpf_iter_task_new(struct bpf_iter_process *it, struct
>> task_struct *group_task, enum ITER_ITEM type)
>>
>> the API have to chang:
>>
>>
>> bpf_for_each(task, curr, NULL, ITERATE_TASK) // iterate all process in
>> the  system
>> bpf_for_each(task, curr, group_leader, ITERATE_THREAD) // iterate all
>> thread of group_leader
>> bpf_for_each(task, curr, NULL, ITERATE_THREAD) //iterate all threads of
>> all the process in the system
>>
>> Useres may guess what are this API actually doing....
> 
> I'd expect users to consult documentation before trying to use an
> unfamiliar cutting-edge functionality. So let's try to keep
> documentation clear and up to the point. Extra flag argument doesn't
> seem to be a big deal.

Thanks for your suggestion!

Before we begin working on the next version, I have outlined a detailed 
API design here:

1.task_iter

It will be used to iterate process/threads like SEC("iter/task"). Here 
we should better to follow the naming and approach SEC("iter/task"):

enum {
	ITERATE_PROCESS,
	ITERATE_THREAD,
}

__bpf_kfunc int bpf_iter_task_new(struct bpf_iter_task *it, struct 
task_struct *task, int flag);

If we want to iterate all processes in the system, the iteration will 
start from the *task* which is passed from user.(since process in the 
system are connected through a linked list)

Additionally, the *task* can allow users to specify iterating all 
threads within a task group.

SEC("xxx")
int xxxx(void *ctx)
{
	struct task_struct *pos;
	struct task_struct *cur_task = bpf_get_current_task_btf();

	bpf_rcu_read_lock();

	// iterating all process in the system start from cur_task
	bpf_for_each(task, pos, cur_task, ITERATE_PROCESS) {
		
	}

	// iterate all thread belongs to cur_task group.
	bpf_for_each(task, pos, cur_task, ITERATE_THREAD) {
	
	}
	
	bpf_rcu_read_unlock();
	return 0;
}

Iterating all thread of each process is great（ITERATE_ALL）. But maybe 
let's break it down step by step and implement 
ITERATE_PROCESS/ITERATE_THREAD first? (I'm little worried about the cpu 
overhead of ITERATE_ALL, since we are doing a heavy job in BPF Prog)

I wanted to reuse BPF_TASK_ITER_ALL/BPF_TASK_ITER_TID/BPF_TASK_ITER_TGID 
insted of new enums like ITERATE_PROCESS/ITERATE_THREAD. But it seems 
necessary. In BPF Prog, we usually operate task_struct directly instead 
of pid/tgid. It's a little weird to use 
BPF_TASK_ITER_TID/BPF_TASK_ITER_TGID here:

bpf_for_each(task, pos, cur_task, BPF_TASK_ITER_TID) {
}

On the other hand, 
BPF_TASK_ITER_ALL/BPF_TASK_ITER_TID/BPF_TASK_ITER_TGID are inner flags 
that are hidden from the users.
Exposing ITERATE_PROCESS/ITERATE_THREAD will not cause confusion to user.


2. css_iter.

css_iter will be used to:
(1) iterating subsystem, like 
for_each_mem_cgroup_tree/cpuset_for_each_descendant_pre in kernel.
(2) iterating cgroup. (patch-6's selfetest has a basic example)

css(cgroup_subsys_state) is more fundamental than struct cgroup. I think 
we'd better operating css rather than cgroup, since it's can be hard for 
cgroup_iter to achive (2). So here we keep the name of "css_iter", 
BPF_CGROUP_ITER_DESCENDANTS_PRE/BPF_CGROUP_ITER_DESCENDANTS_POST/BPF_CGROUP_ITER_ANCESTORS_UP 
can be reused.


__bpf_kfunc int bpf_iter_css_new(struct bpf_iter_css *it,
		struct cgroup_subsys_state *root, unsigned int flag)

bpf_for_each(css, root, BPF_CGROUP_ITER_DESCENDANTS_PRE)

Thanks.





