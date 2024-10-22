Return-Path: <bpf+bounces-42786-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D74F19AB1E3
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 17:21:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40E25B2486A
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 15:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FBCF1A3BDE;
	Tue, 22 Oct 2024 15:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="H2AhGVLw"
X-Original-To: bpf@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9535F1A3BC8;
	Tue, 22 Oct 2024 15:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729610449; cv=none; b=bCfj1IwgU1OthU0o8ZpjL5IndVnS+f5ZlvnJ5DjiUk8/9pvignboHVcCAKJesI/voZRZuZ3qeWZQqcZaCkl3YqSfopzLXfM/XiAnARc583z1dcLQymyakCsiXPdvDTtC/A2qUV+Bfy5/vAzDYfsUAzj5I2v7i+E+5IS4gkvZJUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729610449; c=relaxed/simple;
	bh=CI8O5/CEGDNzrlkCIwc8zGa7x4u/7L0USxNN8JbWDqM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZTv1HlkH0L/qZiK0Fov41EOrT6tjuUgyqnq7dIR9acIjMHS1xguHA4Jdr9+WYrq6RzyoEuj3D2+fzqiEMFnun1AXXVrsQ/fAwDAGjV44DcVSXL7ws231coCUgFmrO49pg2A8/4rfhJlLcfIokVVcslMV1OJ0Ll8nmP1hz4XHAU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=H2AhGVLw; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1729610445;
	bh=CI8O5/CEGDNzrlkCIwc8zGa7x4u/7L0USxNN8JbWDqM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=H2AhGVLwtzfh0cKNLNJ0gUkFZN9B9hxEg7u7bQtCzMKat/KCY46BsZ+w9g8zibYt8
	 CG88VT1nk7Z591jzXN7TrdEDXtVxDrDohGYseGSTbyxwbSsVDu20pyedpYO+paBpVs
	 73t1Lj/t0GUM8p10K9nXPxD9EPZGHipdw7ucG1DEIbp6VCqrbEVhPvG0fKsQpjAE3G
	 O4PCp7HwHOPSIJE4B+vyK8Jp7qjgokb0wU7C3I7K+KpfOV8SrozfNr96vOlbswkU6a
	 r1VUtvvTJOs4SEa1H20m8BWXJSLaM6HBqFzB6id0tmhjgC+usQdV3F/6RWEJc1e4kW
	 xGEqY6zZ4bvsw==
Received: from [172.16.0.134] (96-127-217-162.qc.cable.ebox.net [96.127.217.162])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4XXwqK1PGvzQmX;
	Tue, 22 Oct 2024 11:20:45 -0400 (EDT)
Message-ID: <29c58126-3146-4c61-8166-a894c0e84d08@efficios.com>
Date: Tue, 22 Oct 2024 11:19:01 -0400
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [trace?] [bpf?] KASAN: slab-use-after-free Read in
 bpf_trace_run2 (2)
To: Steven Rostedt <rostedt@goodmis.org>, Jordan Rife <jrife@google.com>
Cc: syzbot+b390c8062d8387b6272a@syzkaller.appspotmail.com, andrii@kernel.org,
 ast@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net,
 eddyz87@gmail.com, haoluo@google.com, john.fastabend@gmail.com,
 jolsa@kernel.org, kpsingh@kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, martin.lau@linux.dev,
 mattbobrowski@google.com, mhiramat@kernel.org, sdf@fomichev.me,
 song@kernel.org, syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
References: <67121037.050a0220.10f4f4.000f.GAE@google.com>
 <20241021182347.77750-1-jrife@google.com>
 <20241022042001.09055543@rorschach.local.home>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20241022042001.09055543@rorschach.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-10-22 04:20, Steven Rostedt wrote:
> 
> Mathieu, can you look at this?

Sure,

> 
> [ more below ]
> 
> On Mon, 21 Oct 2024 18:23:47 +0000
> Jordan Rife <jrife@google.com> wrote:
> 
>> I performed a bisection and this issue starts with commit a363d27cdbc2
>> ("tracing: Allow system call tracepoints to handle page faults") which
>> introduces this change.
>>
>>> + *
>>> + * With @syscall=0, the tracepoint callback array dereference is
>>> + * protected by disabling preemption.
>>> + * With @syscall=1, the tracepoint callback array dereference is
>>> + * protected by Tasks Trace RCU, which allows probes to handle page
>>> + * faults.
>>>    */
>>>   #define __DO_TRACE(name, args, cond, syscall)				\
>>>   	do {								\
>>> @@ -204,11 +212,17 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
>>>   		if (!(cond))						\
>>>   			return;						\
>>>   									\
>>> -		preempt_disable_notrace();				\
>>> +		if (syscall)						\
>>> +			rcu_read_lock_trace();				\
>>> +		else							\
>>> +			preempt_disable_notrace();			\
>>>   									\
>>>   		__DO_TRACE_CALL(name, TP_ARGS(args));			\
>>>   									\
>>> -		preempt_enable_notrace();				\
>>> +		if (syscall)						\
>>> +			rcu_read_unlock_trace();			\
>>> +		else							\
>>> +			preempt_enable_notrace();			\
>>>   	} while (0)
>>
>> Link: https://lore.kernel.org/bpf/20241009010718.2050182-6-mathieu.desnoyers@efficios.com/
>>
>> I reproduced the bug locally by running syz-execprog inside a QEMU VM.
>>
>>> ./syz-execprog -repeat=0 -procs=5 ./repro.syz.txt
>>
>> I /think/ what is happening is that with this change preemption may now
>> occur leading to a scenario where the RCU grace period is insufficient
>> in a few places where call_rcu() is used. In other words, there are a
>> few scenarios where call_rcu_tasks_trace() should be used instead to
>> prevent a use-after-free bug when a preempted tracepoint call tries to
>> access a program, link, etc. that was freed. It seems the syzkaller
>> program induces page faults while attaching raw tracepoints to
>> sys_enter making preemption more likely to occur.
>>
>> kernel/tracepoint.c
>> ===================
>>> ...
>>> static inline void release_probes(struct tracepoint_func *old)
>>> {
>>> 	...
>>> 	call_rcu(&tp_probes->rcu, rcu_free_old_probes); <-- Here
> 
> Have you tried just changing this one to call_rcu_tasks_trace()?

Actually, I see two possible solutions there:

1) If we want to keep unchanged register/unregister functions as a single
    API for normal and syscall tracepoints, and we don't want to add additional
    flags in the tracepoint struct, then we need to chain the call_rcu:

    call_rcu() -> rcu_free_old_probes -> call_rcu_tasks_trace() -> rcu_tasks_trace_free_old_probes.

    Just like we did when we used SRCU.

    This is not perfect because we'd be adding extra delay for reclaim of
    the old probes array for every tracepoint being updated, not just the
    syscall tracepoints, but we probably don't care. This is a straightforward
    initial solution.

    We did something similar with SRCU before and it was OK.

2) If we want something more elegant, we can add a flag to struct tracepoint
    for syscall tracepoints, and use that flag to choose between call_rcu()
    and call_rcu_tasks_trace(). But maybe this additional complexity is not
    even useful.

I'll prepare a patch implementing (1) and send it your way as RFC for further
testing.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


