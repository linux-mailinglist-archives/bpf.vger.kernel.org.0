Return-Path: <bpf+bounces-40896-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D18098FBCA
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 03:03:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4626A1F22084
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 01:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C4E57483;
	Fri,  4 Oct 2024 01:03:12 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA9517FE;
	Fri,  4 Oct 2024 01:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728003791; cv=none; b=mjFkFEg90hI/8eWXAlWAQi7RBb63sA9yyI3dcieGwHbzkkxqqowdnOgq1j5Iiu9wdkAI/oOyn2wLOcIEndASa5U+//1PcG4LCM+PDPiXo9ZLTxrcYtC4vKYSzTm/QPxWEYU/H3uzuLWZ0+pRjPDagM8fKtUi1WOdQfVoncGtfaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728003791; c=relaxed/simple;
	bh=GPmYZM+KCGMsR0gV2kVrawD7HDcqj7FrJiUxEYnQrNU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oMtC61G3/22v9h8KkNUGqeWXTxw5hKS6I/vktoKBwZ22mmAVSWZ6KYxz4g2LuwG37oKmz5KSFb+JT1dgKI/dY4V1w9bHVl3xiYUirlEoKHSUn/gCtCfTWeXRB5hWh4xqvUspLngEdTDQzvKb9CiF9kp+yruCmmSpKiBN6USXVV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63259C4CEC5;
	Fri,  4 Oct 2024 01:03:09 +0000 (UTC)
Date: Thu, 3 Oct 2024 21:04:03 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>, Alexei Starovoitov <ast@kernel.org>,
 Yonghong Song <yhs@fb.com>, "Paul E . McKenney" <paulmck@kernel.org>, Ingo
 Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark
 Rutland <mark.rutland@arm.com>, Alexander Shishkin
 <alexander.shishkin@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>,
 Andrii Nakryiko <andrii.nakryiko@gmail.com>, bpf@vger.kernel.org, Joel
 Fernandes <joel@joelfernandes.org>, linux-trace-kernel@vger.kernel.org,
 Michael Jeanson <mjeanson@efficios.com>
Subject: Re: [PATCH v1 2/8] tracing/ftrace: guard syscall probe with
 preempt_notrace
Message-ID: <20241003210403.71d4aa67@gandalf.local.home>
In-Reply-To: <6dc21f67-52e1-4ed5-af7f-f047c3c22c11@efficios.com>
References: <20241003151638.1608537-1-mathieu.desnoyers@efficios.com>
	<20241003151638.1608537-3-mathieu.desnoyers@efficios.com>
	<20241003182304.2b04b74a@gandalf.local.home>
	<6dc21f67-52e1-4ed5-af7f-f047c3c22c11@efficios.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 3 Oct 2024 20:26:29 -0400
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:


> static void ftrace_syscall_enter(void *data, struct pt_regs *regs, long id)
> {
>          struct trace_array *tr = data;
>          struct trace_event_file *trace_file;
>          struct syscall_trace_enter *entry;
>          struct syscall_metadata *sys_data;
>          struct trace_event_buffer fbuffer;
>          unsigned long args[6];
>          int syscall_nr;
>          int size;
> 
>          syscall_nr = trace_get_syscall_nr(current, regs);
>          if (syscall_nr < 0 || syscall_nr >= NR_syscalls)
>                  return;
> 
>          /* Here we're inside tp handler's rcu_read_lock_sched (__DO_TRACE) */
>          trace_file = rcu_dereference_sched(tr->enter_syscall_files[syscall_nr]);
> 
> ^^^^ this function explicitly states that preempt needs to be disabled by
> tracepoints.

Ah, I should have known it was the syscall portion. I don't care for this
hidden dependency. I rather add a preempt disable here and not expect it to
be disabled when called.

> 
>          if (!trace_file)
>                  return;
> 
>          if (trace_trigger_soft_disabled(trace_file))
>                  return;
> 
>          sys_data = syscall_nr_to_meta(syscall_nr);
>          if (!sys_data)
>                  return;
> 
>          size = sizeof(*entry) + sizeof(unsigned long) * sys_data->nb_args;
> 
>          entry = trace_event_buffer_reserve(&fbuffer, trace_file, size);
> ^^^^ it reserves space in the ring buffer without disabling preemption explicitly.
> 
> And also:
> 
> void *trace_event_buffer_reserve(struct trace_event_buffer *fbuffer,
>                                   struct trace_event_file *trace_file,
>                                   unsigned long len)
> {
>          struct trace_event_call *event_call = trace_file->event_call;
> 
>          if ((trace_file->flags & EVENT_FILE_FL_PID_FILTER) &&
>              trace_event_ignore_this_pid(trace_file))
>                  return NULL;
> 
>          /*
>           * If CONFIG_PREEMPTION is enabled, then the tracepoint itself disables
>           * preemption (adding one to the preempt_count). Since we are
>           * interested in the preempt_count at the time the tracepoint was
>           * hit, we need to subtract one to offset the increment.
>           */
> ^^^ This function also explicitly expects preemption to be disabled.
> 
> So I rest my case. The change I'm introducing for tracepoints
> don't make any assumptions about whether or not each tracer require
> preempt off or not: it keeps the behavior the _same_ as it was before.
> 
> Then it's up to each tracer's developer to change the behavior of their
> own callbacks as they see fit. But I'm not introducing regressions in
> tracers with the "big switch" change of making syscall tracepoints
> faultable. This will belong to changes that are specific to each tracer.


I rather remove these dependencies at the source. So, IMHO, these places
should be "fixed" first.

At least for the ftrace users. But I think the same can be done for the
other users as well. BPF already stated it just needs "migrate_disable()".
Let's see what perf has.

We can then audit all the tracepoint users to make sure they do not need
preemption disabled.

-- Steve

