Return-Path: <bpf+bounces-15413-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 939837F1FB1
	for <lists+bpf@lfdr.de>; Mon, 20 Nov 2023 22:47:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5E781C216B9
	for <lists+bpf@lfdr.de>; Mon, 20 Nov 2023 21:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27CF338FB4;
	Mon, 20 Nov 2023 21:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IpU6vftx"
X-Original-To: bpf@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D932626A9;
	Mon, 20 Nov 2023 13:47:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=VbEEEvOKQiy4zEH0Fh29KF4UlqN9PFMjTOjddwVcuH0=; b=IpU6vftxa1fXYJ78C8NKRyS+9l
	f7v4iA/kVSFpjbSWiu9akz5U9lxJc07AnqL9j2Objf4DHd6mnsNCRRxH737bJyhjFpFD1fKjFw0/E
	S9J40QiM4h0O8mWcRRQGHVEywvU6hWuYP1C8vNed/oLM1FqvKVEgZdTRLCM8IiHzBSbqTRIcRg60z
	tEW5D+sriSXR1wWbCcBt5UKy6tkB/ZrwxNpeZZMQwtquD+PdOhEiF5nvUf4VzCvQqvHqxin936pNf
	8I1hnpVhmz4WbWMabaHjJfRcPHGqbQYR34Em/11cCC7yDHfXYCIArGDEVvZBcTmhti8NljgnrREK5
	8mOBNh+Q==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1r5C6c-00B8ac-0k;
	Mon, 20 Nov 2023 21:46:58 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 1F2C33004E3; Mon, 20 Nov 2023 22:46:57 +0100 (CET)
Date: Mon, 20 Nov 2023 22:46:57 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org,
	Michael Jeanson <mjeanson@efficios.com>,
	Alexei Starovoitov <ast@kernel.org>, Yonghong Song <yhs@fb.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	bpf@vger.kernel.org, Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH v4 5/5] tracing: convert sys_enter/exit to faultable
 tracepoints
Message-ID: <20231120214657.GB8262@noisy.programming.kicks-ass.net>
References: <20231120205418.334172-1-mathieu.desnoyers@efficios.com>
 <20231120205418.334172-6-mathieu.desnoyers@efficios.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231120205418.334172-6-mathieu.desnoyers@efficios.com>

On Mon, Nov 20, 2023 at 03:54:18PM -0500, Mathieu Desnoyers wrote:

> diff --git a/kernel/trace/trace_syscalls.c b/kernel/trace/trace_syscalls.c
> index de753403cdaf..718a0723a0bc 100644
> --- a/kernel/trace/trace_syscalls.c
> +++ b/kernel/trace/trace_syscalls.c
> @@ -299,27 +299,33 @@ static void ftrace_syscall_enter(void *data, struct pt_regs *regs, long id)
>  	int syscall_nr;
>  	int size;
>  
> +	/*
> +	 * Probe called with preemption enabled (may_fault), but ring buffer and
> +	 * per-cpu data require preemption to be disabled.
> +	 */
> +	preempt_disable_notrace();

	guard(preempt_notrace)();

and ditch all the goto crap.

> +
>  	syscall_nr = trace_get_syscall_nr(current, regs);
>  	if (syscall_nr < 0 || syscall_nr >= NR_syscalls)
> -		return;
> +		goto end;
>  
>  	/* Here we're inside tp handler's rcu_read_lock_sched (__DO_TRACE) */
>  	trace_file = rcu_dereference_sched(tr->enter_syscall_files[syscall_nr]);
>  	if (!trace_file)
> -		return;
> +		goto end;
>  
>  	if (trace_trigger_soft_disabled(trace_file))
> -		return;
> +		goto end;
>  
>  	sys_data = syscall_nr_to_meta(syscall_nr);
>  	if (!sys_data)
> -		return;
> +		goto end;
>  
>  	size = sizeof(*entry) + sizeof(unsigned long) * sys_data->nb_args;
>  
>  	entry = trace_event_buffer_reserve(&fbuffer, trace_file, size);
>  	if (!entry)
> -		return;
> +		goto end;
>  
>  	entry = ring_buffer_event_data(fbuffer.event);
>  	entry->nr = syscall_nr;
> @@ -327,6 +333,8 @@ static void ftrace_syscall_enter(void *data, struct pt_regs *regs, long id)
>  	memcpy(entry->args, args, sizeof(unsigned long) * sys_data->nb_args);
>  
>  	trace_event_buffer_commit(&fbuffer);
> +end:
> +	preempt_enable_notrace();
>  }
>  
>  static void ftrace_syscall_exit(void *data, struct pt_regs *regs, long ret)
> @@ -338,31 +346,39 @@ static void ftrace_syscall_exit(void *data, struct pt_regs *regs, long ret)
>  	struct trace_event_buffer fbuffer;
>  	int syscall_nr;
>  
> +	/*
> +	 * Probe called with preemption enabled (may_fault), but ring buffer and
> +	 * per-cpu data require preemption to be disabled.
> +	 */
> +	preempt_disable_notrace();

Idem.

> +
>  	syscall_nr = trace_get_syscall_nr(current, regs);
>  	if (syscall_nr < 0 || syscall_nr >= NR_syscalls)
> -		return;
> +		goto end;
>  
>  	/* Here we're inside tp handler's rcu_read_lock_sched (__DO_TRACE()) */
>  	trace_file = rcu_dereference_sched(tr->exit_syscall_files[syscall_nr]);
>  	if (!trace_file)
> -		return;
> +		goto end;
>  
>  	if (trace_trigger_soft_disabled(trace_file))
> -		return;
> +		goto end;
>  
>  	sys_data = syscall_nr_to_meta(syscall_nr);
>  	if (!sys_data)
> -		return;
> +		goto end;
>  
>  	entry = trace_event_buffer_reserve(&fbuffer, trace_file, sizeof(*entry));
>  	if (!entry)
> -		return;
> +		goto end;
>  
>  	entry = ring_buffer_event_data(fbuffer.event);
>  	entry->nr = syscall_nr;
>  	entry->ret = syscall_get_return_value(current, regs);
>  
>  	trace_event_buffer_commit(&fbuffer);
> +end:
> +	preempt_enable_notrace();
>  }
>  
>  static int reg_event_syscall_enter(struct trace_event_file *file,
> @@ -377,7 +393,9 @@ static int reg_event_syscall_enter(struct trace_event_file *file,
>  		return -ENOSYS;
>  	mutex_lock(&syscall_trace_lock);
>  	if (!tr->sys_refcount_enter)
> -		ret = register_trace_sys_enter(ftrace_syscall_enter, tr);
> +		ret = register_trace_prio_flags_sys_enter(ftrace_syscall_enter, tr,
> +							  TRACEPOINT_DEFAULT_PRIO,
> +							  TRACEPOINT_MAY_FAULT);
>  	if (!ret) {
>  		rcu_assign_pointer(tr->enter_syscall_files[num], file);
>  		tr->sys_refcount_enter++;
> @@ -415,7 +433,9 @@ static int reg_event_syscall_exit(struct trace_event_file *file,
>  		return -ENOSYS;
>  	mutex_lock(&syscall_trace_lock);
>  	if (!tr->sys_refcount_exit)
> -		ret = register_trace_sys_exit(ftrace_syscall_exit, tr);
> +		ret = register_trace_prio_flags_sys_exit(ftrace_syscall_exit, tr,
> +							 TRACEPOINT_DEFAULT_PRIO,
> +							 TRACEPOINT_MAY_FAULT);
>  	if (!ret) {
>  		rcu_assign_pointer(tr->exit_syscall_files[num], file);
>  		tr->sys_refcount_exit++;

/me hands you a bucket of {}, free of charge.

> @@ -582,20 +602,26 @@ static void perf_syscall_enter(void *ignore, struct pt_regs *regs, long id)
>  	int rctx;
>  	int size;
>  
> +	/*
> +	 * Probe called with preemption enabled (may_fault), but ring buffer and
> +	 * per-cpu data require preemption to be disabled.
> +	 */
> +	preempt_disable_notrace();

Again, guard(preempt_notrace)();

> +
>  	syscall_nr = trace_get_syscall_nr(current, regs);
>  	if (syscall_nr < 0 || syscall_nr >= NR_syscalls)
> -		return;
> +		goto end;
>  	if (!test_bit(syscall_nr, enabled_perf_enter_syscalls))
> -		return;
> +		goto end;
>  
>  	sys_data = syscall_nr_to_meta(syscall_nr);
>  	if (!sys_data)
> -		return;
> +		goto end;
>  
>  	head = this_cpu_ptr(sys_data->enter_event->perf_events);
>  	valid_prog_array = bpf_prog_array_valid(sys_data->enter_event);
>  	if (!valid_prog_array && hlist_empty(head))
> -		return;
> +		goto end;
>  
>  	/* get the size after alignment with the u32 buffer size field */
>  	size = sizeof(unsigned long) * sys_data->nb_args + sizeof(*rec);
> @@ -604,7 +630,7 @@ static void perf_syscall_enter(void *ignore, struct pt_regs *regs, long id)
>  
>  	rec = perf_trace_buf_alloc(size, NULL, &rctx);
>  	if (!rec)
> -		return;
> +		goto end;
>  
>  	rec->nr = syscall_nr;
>  	syscall_get_arguments(current, regs, args);
> @@ -614,12 +640,14 @@ static void perf_syscall_enter(void *ignore, struct pt_regs *regs, long id)
>  	     !perf_call_bpf_enter(sys_data->enter_event, regs, sys_data, rec)) ||
>  	    hlist_empty(head)) {
>  		perf_swevent_put_recursion_context(rctx);
> -		return;
> +		goto end;
>  	}
>  
>  	perf_trace_buf_submit(rec, size, rctx,
>  			      sys_data->enter_event->event.type, 1, regs,
>  			      head, NULL);
> +end:
> +	preempt_enable_notrace();
>  }
>  
>  static int perf_sysenter_enable(struct trace_event_call *call)
> @@ -631,7 +659,9 @@ static int perf_sysenter_enable(struct trace_event_call *call)
>  
>  	mutex_lock(&syscall_trace_lock);
>  	if (!sys_perf_refcount_enter)
> -		ret = register_trace_sys_enter(perf_syscall_enter, NULL);
> +		ret = register_trace_prio_flags_sys_enter(perf_syscall_enter, NULL,
> +							  TRACEPOINT_DEFAULT_PRIO,
> +							  TRACEPOINT_MAY_FAULT);

More {}

>  	if (ret) {
>  		pr_info("event trace: Could not activate syscall entry trace point");
>  	} else {
> @@ -682,20 +712,26 @@ static void perf_syscall_exit(void *ignore, struct pt_regs *regs, long ret)
>  	int rctx;
>  	int size;
>  
> +	/*
> +	 * Probe called with preemption enabled (may_fault), but ring buffer and
> +	 * per-cpu data require preemption to be disabled.
> +	 */
> +	preempt_disable_notrace();

Guess?

> +
>  	syscall_nr = trace_get_syscall_nr(current, regs);
>  	if (syscall_nr < 0 || syscall_nr >= NR_syscalls)
> -		return;
> +		goto end;
>  	if (!test_bit(syscall_nr, enabled_perf_exit_syscalls))
> -		return;
> +		goto end;
>  
>  	sys_data = syscall_nr_to_meta(syscall_nr);
>  	if (!sys_data)
> -		return;
> +		goto end;
>  
>  	head = this_cpu_ptr(sys_data->exit_event->perf_events);
>  	valid_prog_array = bpf_prog_array_valid(sys_data->exit_event);
>  	if (!valid_prog_array && hlist_empty(head))
> -		return;
> +		goto end;
>  
>  	/* We can probably do that at build time */
>  	size = ALIGN(sizeof(*rec) + sizeof(u32), sizeof(u64));
> @@ -703,7 +739,7 @@ static void perf_syscall_exit(void *ignore, struct pt_regs *regs, long ret)
>  
>  	rec = perf_trace_buf_alloc(size, NULL, &rctx);
>  	if (!rec)
> -		return;
> +		goto end;
>  
>  	rec->nr = syscall_nr;
>  	rec->ret = syscall_get_return_value(current, regs);
> @@ -712,11 +748,13 @@ static void perf_syscall_exit(void *ignore, struct pt_regs *regs, long ret)
>  	     !perf_call_bpf_exit(sys_data->exit_event, regs, rec)) ||
>  	    hlist_empty(head)) {
>  		perf_swevent_put_recursion_context(rctx);
> -		return;
> +		goto end;
>  	}
>  
>  	perf_trace_buf_submit(rec, size, rctx, sys_data->exit_event->event.type,
>  			      1, regs, head, NULL);
> +end:
> +	preempt_enable_notrace();
>  }
>  
>  static int perf_sysexit_enable(struct trace_event_call *call)
> @@ -728,7 +766,9 @@ static int perf_sysexit_enable(struct trace_event_call *call)
>  
>  	mutex_lock(&syscall_trace_lock);
>  	if (!sys_perf_refcount_exit)
> -		ret = register_trace_sys_exit(perf_syscall_exit, NULL);
> +		ret = register_trace_prio_flags_sys_exit(perf_syscall_exit, NULL,
> +							 TRACEPOINT_DEFAULT_PRIO,
> +							 TRACEPOINT_MAY_FAULT);

And yet more {}

>  	if (ret) {
>  		pr_info("event trace: Could not activate syscall exit trace point");
>  	} else {
> -- 
> 2.25.1
> 

