Return-Path: <bpf+bounces-40876-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90C7F98F9D0
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 00:24:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54C032856D5
	for <lists+bpf@lfdr.de>; Thu,  3 Oct 2024 22:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5419F1CC893;
	Thu,  3 Oct 2024 22:24:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0418F824BD;
	Thu,  3 Oct 2024 22:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727994257; cv=none; b=N3duIF8dpp/HDta7mdEZZN+3n9l1pKW0f1KVHys0cBCdgvJduqPhC7V8vybk+XETjMUyDvqfnF6w4c8r5yS7OPG4JdiqJN5Xy6D6OBvjFlYL1ZQ7u4NdIKzBTyXKMGb0FRuTDuCaYql1KCPh9eEjwIr7Cx5LXacONKLis/v/gB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727994257; c=relaxed/simple;
	bh=raR8M16NOle7XE7CZNErhVzOOMwlzVMP+njCLZWY9SU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JXD1DJeobHI7oWI70qJs/NgVOdlzcoAQZSkeVpVd1azcih+TMF9mLBYZ9EV4xQIqnZ68oYKP4syNEzTi/i0xV44tlNMyUQ6QWAdA/O3lVBvK47Lv9wqhrebAEXqUhjftyduHTJt8xg0+UkrZ3CYGAK7dqy/RZoUg6QgwKyfauSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 872B0C4CEC5;
	Thu,  3 Oct 2024 22:24:14 +0000 (UTC)
Date: Thu, 3 Oct 2024 18:25:08 -0400
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
 Michael Jeanson <mjeanson@efficios.com>, Frederic Weisbecker
 <fweisbec@gmail.com>
Subject: Re: [PATCH v1 3/8] tracing/perf: guard syscall probe with
 preempt_notrace
Message-ID: <20241003182508.6ca76abc@gandalf.local.home>
In-Reply-To: <20241003151638.1608537-4-mathieu.desnoyers@efficios.com>
References: <20241003151638.1608537-1-mathieu.desnoyers@efficios.com>
	<20241003151638.1608537-4-mathieu.desnoyers@efficios.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  3 Oct 2024 11:16:33 -0400
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> In preparation for allowing system call enter/exit instrumentation to
> handle page faults, make sure that perf can handle this change by
> explicitly disabling preemption within the perf system call tracepoint
> probes to respect the current expectations within perf ring buffer code.
> 
> This change does not yet allow perf to take page faults per se within
> its probe, but allows its existing probes to adapt to the upcoming
> change.

Frederic,

Does the perf ring buffer expect preemption to be disabled when used?

In other words, is this patch needed?

-- Steve


> 
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Michael Jeanson <mjeanson@efficios.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Yonghong Song <yhs@fb.com>
> Cc: Paul E. McKenney <paulmck@kernel.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> Cc: bpf@vger.kernel.org
> Cc: Joel Fernandes <joel@joelfernandes.org>
> ---
>  include/trace/perf.h          | 41 +++++++++++++++++++++++++++++++----
>  kernel/trace/trace_syscalls.c | 12 ++++++++++
>  2 files changed, 49 insertions(+), 4 deletions(-)
> 
> diff --git a/include/trace/perf.h b/include/trace/perf.h
> index ded997af481e..5650c1bad088 100644
> --- a/include/trace/perf.h
> +++ b/include/trace/perf.h
> @@ -12,10 +12,10 @@
>  #undef __perf_task
>  #define __perf_task(t)	(__task = (t))
>  
> -#undef DECLARE_EVENT_CLASS
> -#define DECLARE_EVENT_CLASS(call, proto, args, tstruct, assign, print)	\
> +#undef __DECLARE_EVENT_CLASS
> +#define __DECLARE_EVENT_CLASS(call, proto, args, tstruct, assign, print) \
>  static notrace void							\
> -perf_trace_##call(void *__data, proto)					\
> +do_perf_trace_##call(void *__data, proto)				\
>  {									\
>  	struct trace_event_call *event_call = __data;			\
>  	struct trace_event_data_offsets_##call __maybe_unused __data_offsets;\
> @@ -55,8 +55,38 @@ perf_trace_##call(void *__data, proto)					\
>  				  head, __task);			\
>  }
>  
> +/*
> + * Define unused __count and __task variables to use @args to pass
> + * arguments to do_perf_trace_##call. This is needed because the
> + * macros __perf_count and __perf_task introduce the side-effect to
> + * store copies into those local variables.
> + */
> +#undef DECLARE_EVENT_CLASS
> +#define DECLARE_EVENT_CLASS(call, proto, args, tstruct, assign, print)	\
> +__DECLARE_EVENT_CLASS(call, PARAMS(proto), PARAMS(args), PARAMS(tstruct), \
> +		      PARAMS(assign), PARAMS(print))			\
> +static notrace void							\
> +perf_trace_##call(void *__data, proto)					\
> +{									\
> +	u64 __count __attribute__((unused));				\
> +	struct task_struct *__task __attribute__((unused));		\
> +									\
> +	do_perf_trace_##call(__data, args);				\
> +}
> +
>  #undef DECLARE_EVENT_SYSCALL_CLASS
> -#define DECLARE_EVENT_SYSCALL_CLASS DECLARE_EVENT_CLASS
> +#define DECLARE_EVENT_SYSCALL_CLASS(call, proto, args, tstruct, assign, print) \
> +__DECLARE_EVENT_CLASS(call, PARAMS(proto), PARAMS(args), PARAMS(tstruct), \
> +		      PARAMS(assign), PARAMS(print))			\
> +static notrace void							\
> +perf_trace_##call(void *__data, proto)					\
> +{									\
> +	u64 __count __attribute__((unused));				\
> +	struct task_struct *__task __attribute__((unused));		\
> +									\
> +	guard(preempt_notrace)();					\
> +	do_perf_trace_##call(__data, args);				\
> +}
>  
>  /*
>   * This part is compiled out, it is only here as a build time check
> @@ -76,4 +106,7 @@ static inline void perf_test_probe_##call(void)				\
>  	DEFINE_EVENT(template, name, PARAMS(proto), PARAMS(args))
>  
>  #include TRACE_INCLUDE(TRACE_INCLUDE_FILE)
> +
> +#undef __DECLARE_EVENT_CLASS
> +
>  #endif /* CONFIG_PERF_EVENTS */
> diff --git a/kernel/trace/trace_syscalls.c b/kernel/trace/trace_syscalls.c
> index ab4db8c23f36..edcfa47446c7 100644
> --- a/kernel/trace/trace_syscalls.c
> +++ b/kernel/trace/trace_syscalls.c
> @@ -596,6 +596,12 @@ static void perf_syscall_enter(void *ignore, struct pt_regs *regs, long id)
>  	int rctx;
>  	int size;
>  
> +	/*
> +	 * Syscall probe called with preemption enabled, but the ring
> +	 * buffer and per-cpu data require preemption to be disabled.
> +	 */
> +	guard(preempt_notrace)();
> +
>  	syscall_nr = trace_get_syscall_nr(current, regs);
>  	if (syscall_nr < 0 || syscall_nr >= NR_syscalls)
>  		return;
> @@ -698,6 +704,12 @@ static void perf_syscall_exit(void *ignore, struct pt_regs *regs, long ret)
>  	int rctx;
>  	int size;
>  
> +	/*
> +	 * Syscall probe called with preemption enabled, but the ring
> +	 * buffer and per-cpu data require preemption to be disabled.
> +	 */
> +	guard(preempt_notrace)();
> +
>  	syscall_nr = trace_get_syscall_nr(current, regs);
>  	if (syscall_nr < 0 || syscall_nr >= NR_syscalls)
>  		return;


