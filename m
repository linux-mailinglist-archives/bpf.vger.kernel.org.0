Return-Path: <bpf+bounces-47607-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EC0B9FC5C5
	for <lists+bpf@lfdr.de>; Wed, 25 Dec 2024 15:21:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AECDA161DEF
	for <lists+bpf@lfdr.de>; Wed, 25 Dec 2024 14:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 156721B81B2;
	Wed, 25 Dec 2024 14:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CmWt+LKE"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841B31804E;
	Wed, 25 Dec 2024 14:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735136467; cv=none; b=F+Bj7LDeKwZOGhhc5Ms8zWZCqW/+Hn3BddtGarfKKSzes/FzcvqcPUIuXOm8EmNk7zP9M8T5XusEeRXuJOTTt8r2n7vrKROV3xFds0Wrliegitk35PlBI8lNBV9NvwLrhtgQWuZe0K1vWOf0CPaHIlqXpqS5SJDrqb4Kf3bQ534=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735136467; c=relaxed/simple;
	bh=f+thKF/bM1JiOEKgGU4OroTyArm3hVdDKm0EVDqXmCc=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=FFxkc8iM5ktqCdWyr0uOq68wyS54NEhHOGVJzpMKcgLMbhbNPEqPGJTuSHDoMmHX5JTMqL/S5PyWgNKlRP9kGh1J7kYFPdyeRGzfH0Rlstd0664eK0Kmh9MhIlj+8Q6bV12CXcU6PL2GMl855q3hfoMmTu5QAIVXSos+3p50s/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CmWt+LKE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A76AC4CECD;
	Wed, 25 Dec 2024 14:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735136467;
	bh=f+thKF/bM1JiOEKgGU4OroTyArm3hVdDKm0EVDqXmCc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CmWt+LKETgcvS12DulYxxkVjwE/v+lw4sZDyh5ak0LPUe/U0YOtsJSI+bbSCSGPk+
	 lu2r/tZuO/003VBPuZQNObBmERwudNrmSUk7w/Iz56q5bN6ORkko54q6H7QeYS8yEI
	 OPrkvPfXiFp7qmEtb7IFTsHo0dXFLx/FqtZacrvRPk3xeYBtLSNcQBKBSSu56qXwCA
	 2bnzC+4LZGQFoSC46NWEBFobKDFZWMvfxaawzoX6xy9fnQXYoMD2hUZGZBsfl6JX98
	 qZ5/nlKaVQ3kwFQDqXK9U1TFHvzXZ1BiddN1YJRjcAmduXOUEpfaJofQdYrDzVbcRo
	 bluqVA2QkmCXw==
Date: Wed, 25 Dec 2024 23:21:00 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Masami
 Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Sven Schnelle <svens@linux.ibm.com>, Paul
 Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>, Donglin
 Peng <dolinux.peng@gmail.com>, Zheng Yejian <zhengyejian@huaweicloud.com>,
 bpf@vger.kernel.org
Subject: Re: [PATCH v2 4/4] ftrace: Add arguments to function tracer
Message-Id: <20241225232100.b30731319ee210816d9ac61c@kernel.org>
In-Reply-To: <20241223201542.415861522@goodmis.org>
References: <20241223201347.609298489@goodmis.org>
	<20241223201542.415861522@goodmis.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 23 Dec 2024 15:13:51 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: Sven Schnelle <svens@linux.ibm.com>
> 
> Wire up the code to print function arguments in the function tracer.
> This functionality can be enabled/disabled during runtime with
> options/func-args.
> 
>         ping-689     [004] b....    77.170220: dummy_xmit(skb = 0x82904800, dev = 0x882d0000) <-dev_hard_start_xmit
> 

Looks good to me.

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

> Co-developed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
> Changes since v1: https://lore.kernel.org/20240904065908.1009086-8-svens@linux.ibm.com
> 
>  - Save only the arguments into the ring buffer and not the ftrace_regs
>    as the ftrace_regs should be opaque from generic code.
> 
>  - Have the function tracer event be dynamic so that it can hold an array
>    of arguments after the entry.
> 
>  kernel/trace/trace.c              | 12 ++++++--
>  kernel/trace/trace.h              |  3 +-
>  kernel/trace/trace_entries.h      |  5 ++--
>  kernel/trace/trace_functions.c    | 46 +++++++++++++++++++++++++++----
>  kernel/trace/trace_irqsoff.c      |  4 +--
>  kernel/trace/trace_output.c       | 18 ++++++++++--
>  kernel/trace/trace_sched_wakeup.c |  4 +--
>  7 files changed, 75 insertions(+), 17 deletions(-)
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index be62f0ea1814..3c0ffdcdcb7e 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -2897,13 +2897,16 @@ trace_buffer_unlock_commit_nostack(struct trace_buffer *buffer,
>  
>  void
>  trace_function(struct trace_array *tr, unsigned long ip, unsigned long
> -	       parent_ip, unsigned int trace_ctx)
> +	       parent_ip, unsigned int trace_ctx, struct ftrace_regs *fregs)
>  {
>  	struct trace_buffer *buffer = tr->array_buffer.buffer;
>  	struct ring_buffer_event *event;
>  	struct ftrace_entry *entry;
> +	int size = sizeof(*entry);
>  
> -	event = __trace_buffer_lock_reserve(buffer, TRACE_FN, sizeof(*entry),
> +	size += FTRACE_REGS_MAX_ARGS * !!fregs * sizeof(long);
> +
> +	event = __trace_buffer_lock_reserve(buffer, TRACE_FN, size,
>  					    trace_ctx);
>  	if (!event)
>  		return;
> @@ -2911,6 +2914,11 @@ trace_function(struct trace_array *tr, unsigned long ip, unsigned long
>  	entry->ip			= ip;
>  	entry->parent_ip		= parent_ip;
>  
> +	if (fregs) {
> +		for (int i = 0; i < FTRACE_REGS_MAX_ARGS; i++)
> +			entry->args[i] = ftrace_regs_get_argument(fregs, i);
> +	}
> +
>  	if (static_branch_unlikely(&trace_function_exports_enabled))
>  		ftrace_exports(event, TRACE_EXPORT_FUNCTION);
>  	__buffer_unlock_commit(buffer, event);
> diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
> index 6f67bbc17bed..3d4a5ec9ee55 100644
> --- a/kernel/trace/trace.h
> +++ b/kernel/trace/trace.h
> @@ -685,7 +685,8 @@ unsigned long trace_total_entries(struct trace_array *tr);
>  void trace_function(struct trace_array *tr,
>  		    unsigned long ip,
>  		    unsigned long parent_ip,
> -		    unsigned int trace_ctx);
> +		    unsigned int trace_ctx,
> +		    struct ftrace_regs *regs);
>  void trace_graph_function(struct trace_array *tr,
>  		    unsigned long ip,
>  		    unsigned long parent_ip,
> diff --git a/kernel/trace/trace_entries.h b/kernel/trace/trace_entries.h
> index 254491b545c3..11288dc4f59b 100644
> --- a/kernel/trace/trace_entries.h
> +++ b/kernel/trace/trace_entries.h
> @@ -61,8 +61,9 @@ FTRACE_ENTRY_REG(function, ftrace_entry,
>  	TRACE_FN,
>  
>  	F_STRUCT(
> -		__field_fn(	unsigned long,	ip		)
> -		__field_fn(	unsigned long,	parent_ip	)
> +		__field_fn(	unsigned long,		ip		)
> +		__field_fn(	unsigned long,		parent_ip	)
> +		__dynamic_array( unsigned long,		args		)
>  	),
>  
>  	F_printk(" %ps <-- %ps",
> diff --git a/kernel/trace/trace_functions.c b/kernel/trace/trace_functions.c
> index d358c9935164..1f4f02df6f8c 100644
> --- a/kernel/trace/trace_functions.c
> +++ b/kernel/trace/trace_functions.c
> @@ -25,6 +25,9 @@ static void
>  function_trace_call(unsigned long ip, unsigned long parent_ip,
>  		    struct ftrace_ops *op, struct ftrace_regs *fregs);
>  static void
> +function_args_trace_call(unsigned long ip, unsigned long parent_ip,
> +			 struct ftrace_ops *op, struct ftrace_regs *fregs);
> +static void
>  function_stack_trace_call(unsigned long ip, unsigned long parent_ip,
>  			  struct ftrace_ops *op, struct ftrace_regs *fregs);
>  static void
> @@ -42,9 +45,10 @@ enum {
>  	TRACE_FUNC_NO_OPTS		= 0x0, /* No flags set. */
>  	TRACE_FUNC_OPT_STACK		= 0x1,
>  	TRACE_FUNC_OPT_NO_REPEATS	= 0x2,
> +	TRACE_FUNC_OPT_ARGS		= 0x4,
>  
>  	/* Update this to next highest bit. */
> -	TRACE_FUNC_OPT_HIGHEST_BIT	= 0x4
> +	TRACE_FUNC_OPT_HIGHEST_BIT	= 0x8
>  };
>  
>  #define TRACE_FUNC_OPT_MASK	(TRACE_FUNC_OPT_HIGHEST_BIT - 1)
> @@ -114,6 +118,8 @@ static ftrace_func_t select_trace_function(u32 flags_val)
>  	switch (flags_val & TRACE_FUNC_OPT_MASK) {
>  	case TRACE_FUNC_NO_OPTS:
>  		return function_trace_call;
> +	case TRACE_FUNC_OPT_ARGS:
> +		return function_args_trace_call;
>  	case TRACE_FUNC_OPT_STACK:
>  		return function_stack_trace_call;
>  	case TRACE_FUNC_OPT_NO_REPEATS:
> @@ -220,7 +226,34 @@ function_trace_call(unsigned long ip, unsigned long parent_ip,
>  
>  	data = this_cpu_ptr(tr->array_buffer.data);
>  	if (!atomic_read(&data->disabled))
> -		trace_function(tr, ip, parent_ip, trace_ctx);
> +		trace_function(tr, ip, parent_ip, trace_ctx, NULL);
> +
> +	ftrace_test_recursion_unlock(bit);
> +}
> +
> +static void
> +function_args_trace_call(unsigned long ip, unsigned long parent_ip,
> +			 struct ftrace_ops *op, struct ftrace_regs *fregs)
> +{
> +	struct trace_array *tr = op->private;
> +	struct trace_array_cpu *data;
> +	unsigned int trace_ctx;
> +	int bit;
> +	int cpu;
> +
> +	if (unlikely(!tr->function_enabled))
> +		return;
> +
> +	bit = ftrace_test_recursion_trylock(ip, parent_ip);
> +	if (bit < 0)
> +		return;
> +
> +	trace_ctx = tracing_gen_ctx();
> +
> +	cpu = smp_processor_id();
> +	data = per_cpu_ptr(tr->array_buffer.data, cpu);
> +	if (!atomic_read(&data->disabled))
> +		trace_function(tr, ip, parent_ip, trace_ctx, fregs);
>  
>  	ftrace_test_recursion_unlock(bit);
>  }
> @@ -270,7 +303,7 @@ function_stack_trace_call(unsigned long ip, unsigned long parent_ip,
>  
>  	if (likely(disabled == 1)) {
>  		trace_ctx = tracing_gen_ctx_flags(flags);
> -		trace_function(tr, ip, parent_ip, trace_ctx);
> +		trace_function(tr, ip, parent_ip, trace_ctx, NULL);
>  #ifdef CONFIG_UNWINDER_FRAME_POINTER
>  		if (ftrace_pids_enabled(op))
>  			skip++;
> @@ -351,7 +384,7 @@ function_no_repeats_trace_call(unsigned long ip, unsigned long parent_ip,
>  	trace_ctx = tracing_gen_ctx_flags(flags);
>  	process_repeats(tr, ip, parent_ip, last_info, trace_ctx);
>  
> -	trace_function(tr, ip, parent_ip, trace_ctx);
> +	trace_function(tr, ip, parent_ip, trace_ctx, NULL);
>  
>  out:
>  	ftrace_test_recursion_unlock(bit);
> @@ -391,7 +424,7 @@ function_stack_no_repeats_trace_call(unsigned long ip, unsigned long parent_ip,
>  		trace_ctx = tracing_gen_ctx_flags(flags);
>  		process_repeats(tr, ip, parent_ip, last_info, trace_ctx);
>  
> -		trace_function(tr, ip, parent_ip, trace_ctx);
> +		trace_function(tr, ip, parent_ip, trace_ctx, NULL);
>  		__trace_stack(tr, trace_ctx, STACK_SKIP);
>  	}
>  
> @@ -405,6 +438,9 @@ static struct tracer_opt func_opts[] = {
>  	{ TRACER_OPT(func_stack_trace, TRACE_FUNC_OPT_STACK) },
>  #endif
>  	{ TRACER_OPT(func-no-repeats, TRACE_FUNC_OPT_NO_REPEATS) },
> +#ifdef CONFIG_FUNCTION_TRACE_ARGS
> +	{ TRACER_OPT(func-args, TRACE_FUNC_OPT_ARGS) },
> +#endif
>  	{ } /* Always set a last empty entry */
>  };
>  
> diff --git a/kernel/trace/trace_irqsoff.c b/kernel/trace/trace_irqsoff.c
> index 504de7a05498..68ce152dbb8c 100644
> --- a/kernel/trace/trace_irqsoff.c
> +++ b/kernel/trace/trace_irqsoff.c
> @@ -150,7 +150,7 @@ irqsoff_tracer_call(unsigned long ip, unsigned long parent_ip,
>  
>  	trace_ctx = tracing_gen_ctx_flags(flags);
>  
> -	trace_function(tr, ip, parent_ip, trace_ctx);
> +	trace_function(tr, ip, parent_ip, trace_ctx, fregs);
>  
>  	atomic_dec(&data->disabled);
>  }
> @@ -280,7 +280,7 @@ __trace_function(struct trace_array *tr,
>  	if (is_graph(tr))
>  		trace_graph_function(tr, ip, parent_ip, trace_ctx);
>  	else
> -		trace_function(tr, ip, parent_ip, trace_ctx);
> +		trace_function(tr, ip, parent_ip, trace_ctx, NULL);
>  }
>  
>  #else
> diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
> index 40d6c7a9e0c4..aed6758416a0 100644
> --- a/kernel/trace/trace_output.c
> +++ b/kernel/trace/trace_output.c
> @@ -1079,12 +1079,15 @@ enum print_line_t trace_nop_print(struct trace_iterator *iter, int flags,
>  }
>  
>  static void print_fn_trace(struct trace_seq *s, unsigned long ip,
> -			   unsigned long parent_ip, long delta, int flags)
> +			   unsigned long parent_ip, long delta,
> +			   unsigned long *args, int flags)
>  {
>  	ip += delta;
>  	parent_ip += delta;
>  
>  	seq_print_ip_sym(s, ip, flags);
> +	if (args)
> +		print_function_args(s, args, ip);
>  
>  	if ((flags & TRACE_ITER_PRINT_PARENT) && parent_ip) {
>  		trace_seq_puts(s, " <-");
> @@ -1098,10 +1101,19 @@ static enum print_line_t trace_fn_trace(struct trace_iterator *iter, int flags,
>  {
>  	struct ftrace_entry *field;
>  	struct trace_seq *s = &iter->seq;
> +	unsigned long *args;
> +	int args_size;
>  
>  	trace_assign_type(field, iter->ent);
>  
> -	print_fn_trace(s, field->ip, field->parent_ip, iter->tr->text_delta, flags);
> +	args_size = iter->ent_size - offsetof(struct ftrace_entry, args);
> +	if (args_size >= FTRACE_REGS_MAX_ARGS * sizeof(long))
> +		args = field->args;
> +	else
> +		args = NULL;
> +
> +	print_fn_trace(s, field->ip, field->parent_ip, iter->tr->text_delta,
> +		       args, flags);
>  	trace_seq_putc(s, '\n');
>  
>  	return trace_handle_return(s);
> @@ -1774,7 +1786,7 @@ trace_func_repeats_print(struct trace_iterator *iter, int flags,
>  
>  	trace_assign_type(field, iter->ent);
>  
> -	print_fn_trace(s, field->ip, field->parent_ip, iter->tr->text_delta, flags);
> +	print_fn_trace(s, field->ip, field->parent_ip, iter->tr->text_delta, NULL, flags);
>  	trace_seq_printf(s, " (repeats: %u, last_ts:", field->count);
>  	trace_print_time(s, iter,
>  			 iter->ts - FUNC_REPEATS_GET_DELTA_TS(field));
> diff --git a/kernel/trace/trace_sched_wakeup.c b/kernel/trace/trace_sched_wakeup.c
> index 8165382a174a..19b0205b91dd 100644
> --- a/kernel/trace/trace_sched_wakeup.c
> +++ b/kernel/trace/trace_sched_wakeup.c
> @@ -226,7 +226,7 @@ wakeup_tracer_call(unsigned long ip, unsigned long parent_ip,
>  		return;
>  
>  	local_irq_save(flags);
> -	trace_function(tr, ip, parent_ip, trace_ctx);
> +	trace_function(tr, ip, parent_ip, trace_ctx, fregs);
>  	local_irq_restore(flags);
>  
>  	atomic_dec(&data->disabled);
> @@ -311,7 +311,7 @@ __trace_function(struct trace_array *tr,
>  	if (is_graph(tr))
>  		trace_graph_function(tr, ip, parent_ip, trace_ctx);
>  	else
> -		trace_function(tr, ip, parent_ip, trace_ctx);
> +		trace_function(tr, ip, parent_ip, trace_ctx, NULL);
>  }
>  
>  static int wakeup_flag_changed(struct trace_array *tr, u32 mask, int set)
> -- 
> 2.45.2
> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

