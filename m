Return-Path: <bpf+bounces-40892-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E89498FB81
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 02:28:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A56341F23767
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 00:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3456A211C;
	Fri,  4 Oct 2024 00:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="fPJkrHLX"
X-Original-To: bpf@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E25DE17C9;
	Fri,  4 Oct 2024 00:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728001713; cv=none; b=R6WzWdBOpyBpVm8thPRV3h6xGzzFJrZnVzM+XmIXNSZAAHYrHSiI4u3n5/l4NNAcFo+zhSy26iBOkaV2uIUIvf3ChKWwfZbT/ik9WamDDXC05fh4DQ0OpRjwi2WH/YHeejk/sMlwvuQ6uInHpS5VfAkYUohUPnBmlSUQJ0//TjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728001713; c=relaxed/simple;
	bh=FwiyiYDZkYOPSRMQH9F+kysZz4UJLi3X5NIfwF+Dr9k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D8GELiPQllsI0Ne2Z3tyKrjQHfAR9FaJosXjDwtYDcvrQHJC9cEbywadk0pb+LDMANFN7Ea6VyB/xV0jbGLgSjGmbT2gP95kXXKyRmNepFLrYNTNVvxe2u8Q5qjPsfTk7XMCZGEGkS00NDmpL+lttoPKxnTL3OP47DRZT2RVpVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=fPJkrHLX; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1728001710;
	bh=FwiyiYDZkYOPSRMQH9F+kysZz4UJLi3X5NIfwF+Dr9k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fPJkrHLXZuq/yPsOdPHymQtNyZVqCHu+gLp4RHmdPwR2Uzw04AuJgE7DWDrikJl3l
	 IIdFdOu5wdM6MMBmMXJ/GyDg1Oby1jDk5AFAdtojXZ0pzwPGXyMyhrYlsGOAGw2tCp
	 PImcFuwuT9F8rBZASqYKdT//pRW7WzLC5OwUnPnnuCo+ZOPMJpupwlvrssUeic72Dn
	 7lG6wcVe+Gj6FC4DBzde5mixQC+VOPu7gWT1DNWywVoOvxts6U1HKQyTAMd6Q6IVEH
	 o/qNXRPO29JMtOePGx19ew4y4wMv2dKNRnOrboBHxkKExqY3Z/qDSeZdiZGCKw6cWl
	 lgPM97e1BSFQA==
Received: from [IPV6:2606:6d00:100:4000:cacb:9855:de1f:ded2] (unknown [IPv6:2606:6d00:100:4000:cacb:9855:de1f:ded2])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4XKTt65SRtzBG9;
	Thu,  3 Oct 2024 20:28:30 -0400 (EDT)
Message-ID: <6dc21f67-52e1-4ed5-af7f-f047c3c22c11@efficios.com>
Date: Thu, 3 Oct 2024 20:26:29 -0400
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
Content-Language: en-US
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <20241003182304.2b04b74a@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-10-04 00:23, Steven Rostedt wrote:
> On Thu,  3 Oct 2024 11:16:32 -0400
> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> 
>> In preparation for allowing system call enter/exit instrumentation to
>> handle page faults, make sure that ftrace can handle this change by
>> explicitly disabling preemption within the ftrace system call tracepoint
>> probes to respect the current expectations within ftrace ring buffer
>> code.
> 
> The ftrace ring buffer doesn't expect preemption being disabled before use.
> It will explicitly disable preemption.
> 
> I don't think this patch is needed.

Steve,

Look here:

static void ftrace_syscall_enter(void *data, struct pt_regs *regs, long id)
{
         struct trace_array *tr = data;
         struct trace_event_file *trace_file;
         struct syscall_trace_enter *entry;
         struct syscall_metadata *sys_data;
         struct trace_event_buffer fbuffer;
         unsigned long args[6];
         int syscall_nr;
         int size;

         syscall_nr = trace_get_syscall_nr(current, regs);
         if (syscall_nr < 0 || syscall_nr >= NR_syscalls)
                 return;

         /* Here we're inside tp handler's rcu_read_lock_sched (__DO_TRACE) */
         trace_file = rcu_dereference_sched(tr->enter_syscall_files[syscall_nr]);

^^^^ this function explicitly states that preempt needs to be disabled by
tracepoints.

         if (!trace_file)
                 return;

         if (trace_trigger_soft_disabled(trace_file))
                 return;

         sys_data = syscall_nr_to_meta(syscall_nr);
         if (!sys_data)
                 return;

         size = sizeof(*entry) + sizeof(unsigned long) * sys_data->nb_args;

         entry = trace_event_buffer_reserve(&fbuffer, trace_file, size);
^^^^ it reserves space in the ring buffer without disabling preemption explicitly.

And also:

void *trace_event_buffer_reserve(struct trace_event_buffer *fbuffer,
                                  struct trace_event_file *trace_file,
                                  unsigned long len)
{
         struct trace_event_call *event_call = trace_file->event_call;

         if ((trace_file->flags & EVENT_FILE_FL_PID_FILTER) &&
             trace_event_ignore_this_pid(trace_file))
                 return NULL;

         /*
          * If CONFIG_PREEMPTION is enabled, then the tracepoint itself disables
          * preemption (adding one to the preempt_count). Since we are
          * interested in the preempt_count at the time the tracepoint was
          * hit, we need to subtract one to offset the increment.
          */
^^^ This function also explicitly expects preemption to be disabled.

So I rest my case. The change I'm introducing for tracepoints
don't make any assumptions about whether or not each tracer require
preempt off or not: it keeps the behavior the _same_ as it was before.

Then it's up to each tracer's developer to change the behavior of their
own callbacks as they see fit. But I'm not introducing regressions in
tracers with the "big switch" change of making syscall tracepoints
faultable. This will belong to changes that are specific to each tracer.

Thanks,

Mathieu

> 
> -- Steve
> 
> 
>>
>> This change does not yet allow ftrace to take page faults per se within
>> its probe, but allows its existing probes to adapt to the upcoming
>> change.
>>
>> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>> Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>> Cc: Michael Jeanson <mjeanson@efficios.com>
>> Cc: Steven Rostedt <rostedt@goodmis.org>
>> Cc: Masami Hiramatsu <mhiramat@kernel.org>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Cc: Alexei Starovoitov <ast@kernel.org>
>> Cc: Yonghong Song <yhs@fb.com>
>> Cc: Paul E. McKenney <paulmck@kernel.org>
>> Cc: Ingo Molnar <mingo@redhat.com>
>> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
>> Cc: Namhyung Kim <namhyung@kernel.org>
>> Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
>> Cc: bpf@vger.kernel.org
>> Cc: Joel Fernandes <joel@joelfernandes.org>

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


