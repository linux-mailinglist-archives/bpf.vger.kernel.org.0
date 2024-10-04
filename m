Return-Path: <bpf+bounces-40908-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F7FB98FBF0
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 03:35:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36E1FB226BB
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 01:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0105A10A24;
	Fri,  4 Oct 2024 01:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="eeCr3bhs"
X-Original-To: bpf@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073918C06;
	Fri,  4 Oct 2024 01:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728005720; cv=none; b=AZ0Oy6lo9FY0SwZl1MElIwLp6ig+tULvJlzaYJKkoIseW2DsmUHokv5IZe4dljemwOGvO/W1Yrkpuc5iMFgvNUGdhmHBmz8IIwt3j6vLgJYrOhuZbPJ0lhneKZtW3hUXj71AOZMFJ5kYQJ5tTCX9Z4Pjx3t3vOrTHR5sIryHY0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728005720; c=relaxed/simple;
	bh=kFIgYd1GyoFetX5O9S6+TQCvwyv29zV3/01SyhjdM48=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c5UFu2Bc3eAg5Worhss9fwd5j6PzzdzyzxqHR8VNJ9sNAU7CmlQL/S2XMGVWYhT3IDSz/d1Uv5uw4MXdlTPTd2rFakmEuT4NhoFgnEaToOAChCZM4wNq+ipkBywDAWyRx5cJ19XBQS9pbqQCUkAKXedx7JLVL3XPeyx5k8klnBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=eeCr3bhs; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1728005718;
	bh=kFIgYd1GyoFetX5O9S6+TQCvwyv29zV3/01SyhjdM48=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=eeCr3bhsVEgaQxQU4Q/ZasrFWXoCTlqtwLQDd6Cpma6aE+Y86bQtR8C+Z3NJVb3Bc
	 yus2m6gyQsjXOgASgtK3LwdPrkE6LmNrAirKEFxX6LO7SoS0AlMfCba/IhnIQKQwWT
	 TWVq0ttmUKjGIOQMlSMHgzxVHuBhi+VF864vtU0qRnhikSVTbnW7WKqkvoZyUwFNFx
	 baFDHDU0zPqpBB4IJeQmufWq4KcjcDPxUN9+ypCzD43rc+ypBYAuxkYU2Cn6pPT8W+
	 IngmVuoEEz27Yb055/850UDkGMyKogUdfmUv48Y7Lt5NnJK7x/AmG3b8EvjPV0eRhA
	 q8aMMxvO0sOKA==
Received: from [IPV6:2606:6d00:100:4000:cacb:9855:de1f:ded2] (unknown [IPv6:2606:6d00:100:4000:cacb:9855:de1f:ded2])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4XKWM960NSzC73;
	Thu,  3 Oct 2024 21:35:17 -0400 (EDT)
Message-ID: <90ca2fee-cdfb-4d48-ab9e-57d8d2b8b8d8@efficios.com>
Date: Thu, 3 Oct 2024 21:33:16 -0400
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/8] tracing/ftrace: guard syscall probe with
 preempt_notrace
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>, Alexei Starovoitov <ast@kernel.org>,
 Yonghong Song <yhs@fb.com>, "Paul E . McKenney" <paulmck@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Namhyung Kim <namhyung@kernel.org>,
 Andrii Nakryiko <andrii.nakryiko@gmail.com>, bpf@vger.kernel.org,
 Joel Fernandes <joel@joelfernandes.org>, linux-trace-kernel@vger.kernel.org,
 Michael Jeanson <mjeanson@efficios.com>
References: <20241003151638.1608537-1-mathieu.desnoyers@efficios.com>
 <20241003151638.1608537-3-mathieu.desnoyers@efficios.com>
 <20241003182304.2b04b74a@gandalf.local.home>
 <6dc21f67-52e1-4ed5-af7f-f047c3c22c11@efficios.com>
 <20241003210403.71d4aa67@gandalf.local.home>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20241003210403.71d4aa67@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-10-04 03:04, Steven Rostedt wrote:
> On Thu, 3 Oct 2024 20:26:29 -0400
> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> 
> 
>> static void ftrace_syscall_enter(void *data, struct pt_regs *regs, long id)
>> {
>>           struct trace_array *tr = data;
>>           struct trace_event_file *trace_file;
>>           struct syscall_trace_enter *entry;
>>           struct syscall_metadata *sys_data;
>>           struct trace_event_buffer fbuffer;
>>           unsigned long args[6];
>>           int syscall_nr;
>>           int size;
>>
>>           syscall_nr = trace_get_syscall_nr(current, regs);
>>           if (syscall_nr < 0 || syscall_nr >= NR_syscalls)
>>                   return;
>>
>>           /* Here we're inside tp handler's rcu_read_lock_sched (__DO_TRACE) */
>>           trace_file = rcu_dereference_sched(tr->enter_syscall_files[syscall_nr]);
>>
>> ^^^^ this function explicitly states that preempt needs to be disabled by
>> tracepoints.
> 
> Ah, I should have known it was the syscall portion. I don't care for this
> hidden dependency. I rather add a preempt disable here and not expect it to
> be disabled when called.

Which is exactly what this patch is doing.

> 
>>
>>           if (!trace_file)
>>                   return;
>>
>>           if (trace_trigger_soft_disabled(trace_file))
>>                   return;
>>
>>           sys_data = syscall_nr_to_meta(syscall_nr);
>>           if (!sys_data)
>>                   return;
>>
>>           size = sizeof(*entry) + sizeof(unsigned long) * sys_data->nb_args;
>>
>>           entry = trace_event_buffer_reserve(&fbuffer, trace_file, size);
>> ^^^^ it reserves space in the ring buffer without disabling preemption explicitly.
>>
>> And also:
>>
>> void *trace_event_buffer_reserve(struct trace_event_buffer *fbuffer,
>>                                    struct trace_event_file *trace_file,
>>                                    unsigned long len)
>> {
>>           struct trace_event_call *event_call = trace_file->event_call;
>>
>>           if ((trace_file->flags & EVENT_FILE_FL_PID_FILTER) &&
>>               trace_event_ignore_this_pid(trace_file))
>>                   return NULL;
>>
>>           /*
>>            * If CONFIG_PREEMPTION is enabled, then the tracepoint itself disables
>>            * preemption (adding one to the preempt_count). Since we are
>>            * interested in the preempt_count at the time the tracepoint was
>>            * hit, we need to subtract one to offset the increment.
>>            */
>> ^^^ This function also explicitly expects preemption to be disabled.
>>
>> So I rest my case. The change I'm introducing for tracepoints
>> don't make any assumptions about whether or not each tracer require
>> preempt off or not: it keeps the behavior the _same_ as it was before.
>>
>> Then it's up to each tracer's developer to change the behavior of their
>> own callbacks as they see fit. But I'm not introducing regressions in
>> tracers with the "big switch" change of making syscall tracepoints
>> faultable. This will belong to changes that are specific to each tracer.
> 
> 
> I rather remove these dependencies at the source. So, IMHO, these places
> should be "fixed" first.
> 
> At least for the ftrace users. But I think the same can be done for the
> other users as well. BPF already stated it just needs "migrate_disable()".
> Let's see what perf has.
> 
> We can then audit all the tracepoint users to make sure they do not need
> preemption disabled.

Why does it need to be a broad refactoring of the entire world ? What is
wrong with the simple approach of introducing this tracepoint faultable
syscall support as a no-op from the tracer's perspective ?

Then we can build on top and figure out if we want to relax things
on a tracer-per-tracer basis.

Thanks,

Mathieu



-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


