Return-Path: <bpf+bounces-40946-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B0C4C990691
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 16:48:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B801B23683
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 14:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B5F3221E4C;
	Fri,  4 Oct 2024 14:44:10 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0E421C18E;
	Fri,  4 Oct 2024 14:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728053050; cv=none; b=Z5E/oanIZmwNolqdKkh/g9pB9NbUEejEI/qxwRqTJnSwbFEWIqDvfaarrbLkj2yoHt3dTEyWKHVhBv6z/dYwqpS7EXl7V7j2fefKKtNGwKCOvP9LD8l3TvoXTYMWPR3ZvJtbK1cRPCq2xiZOsUtS6Qcty+imT3xL1VJ3JFDShPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728053050; c=relaxed/simple;
	bh=zcL7rB6iOgKj6+2q8e4CAkd6bnTnFRu52SyVEH0CffY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B1ZagODqYwdLdlHm8H4jC1oiSUt382CAgRQ+EuoKJV+43HZe9aabjDTEHsR8rdWtlU7B7x9TomU8iS9K8EtPZHpecc49iU8BCNIU/ZP5ooyradOcjpzXkMslldNpms9+B9NhqV0ZlNbA01NOL9+eDoxhMo7D+19+zMGELEUcXrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE9A0C4CECF;
	Fri,  4 Oct 2024 14:44:07 +0000 (UTC)
Date: Fri, 4 Oct 2024 10:45:03 -0400
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
Message-ID: <20241004104503.7a1d6b44@gandalf.local.home>
In-Reply-To: <db35f840-1c90-406a-906f-c26aca29be84@efficios.com>
References: <20241003151638.1608537-1-mathieu.desnoyers@efficios.com>
	<20241003151638.1608537-3-mathieu.desnoyers@efficios.com>
	<20241003182304.2b04b74a@gandalf.local.home>
	<6dc21f67-52e1-4ed5-af7f-f047c3c22c11@efficios.com>
	<20241003210403.71d4aa67@gandalf.local.home>
	<90ca2fee-cdfb-4d48-ab9e-57d8d2b8b8d8@efficios.com>
	<20241004092619.0be53f90@gandalf.local.home>
	<db35f840-1c90-406a-906f-c26aca29be84@efficios.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 4 Oct 2024 10:18:59 -0400
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> On 2024-10-04 15:26, Steven Rostedt wrote:
> > On Thu, 3 Oct 2024 21:33:16 -0400
> > Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> >   
> >> On 2024-10-04 03:04, Steven Rostedt wrote:  
> >>> On Thu, 3 Oct 2024 20:26:29 -0400
> >>> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> >>>
> >>>      
> >>>> static void ftrace_syscall_enter(void *data, struct pt_regs *regs, long id)
> >>>> {
> >>>>            struct trace_array *tr = data;
> >>>>            struct trace_event_file *trace_file;
> >>>>            struct syscall_trace_enter *entry;
> >>>>            struct syscall_metadata *sys_data;
> >>>>            struct trace_event_buffer fbuffer;
> >>>>            unsigned long args[6];
> >>>>            int syscall_nr;
> >>>>            int size;
> >>>>
> >>>>            syscall_nr = trace_get_syscall_nr(current, regs);
> >>>>            if (syscall_nr < 0 || syscall_nr >= NR_syscalls)
> >>>>                    return;
> >>>>
> >>>>            /* Here we're inside tp handler's rcu_read_lock_sched (__DO_TRACE) */
> >>>>            trace_file = rcu_dereference_sched(tr->enter_syscall_files[syscall_nr]);
> >>>>
> >>>> ^^^^ this function explicitly states that preempt needs to be disabled by
> >>>> tracepoints.  
> >>>
> >>> Ah, I should have known it was the syscall portion. I don't care for this
> >>> hidden dependency. I rather add a preempt disable here and not expect it to
> >>> be disabled when called.  
> >>
> >> Which is exactly what this patch is doing.  
> > 
> > I was thinking of putting the protection in the function and not the macro.  
> 
> I'm confused by your comment. The protection is added to the function here:

Ah, sorry. I'm the one confused. I was talking about this part:

> +#undef DECLARE_EVENT_SYSCALL_CLASS
> +#define DECLARE_EVENT_SYSCALL_CLASS(call, proto, args, tstruct, assign, print) \
> +__DECLARE_EVENT_CLASS(call, PARAMS(proto), PARAMS(args), PARAMS(tstruct), \
> +		      PARAMS(assign), PARAMS(print))			\
> +static notrace void							\
> +trace_event_raw_event_##call(void *__data, proto)			\
> +{									\
> +	guard(preempt_notrace)();					\
> +	do_trace_event_raw_event_##call(__data, args);			\
> +}
> +

But that's for the non-syscall case.

This is why I shouldn't review patches just before going to bed :-p

-- Steve

