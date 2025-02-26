Return-Path: <bpf+bounces-52649-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75118A463AB
	for <lists+bpf@lfdr.de>; Wed, 26 Feb 2025 15:51:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFA043B5CF2
	for <lists+bpf@lfdr.de>; Wed, 26 Feb 2025 14:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 381ED212FB4;
	Wed, 26 Feb 2025 14:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SBBPn9hc"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1622222A5;
	Wed, 26 Feb 2025 14:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740581336; cv=none; b=gnhFWcdhwZYI4GEkU3r0E36W7PayIo5TLzEGFuBSIu2J4RemKt2oEfHTLETVuk52tSwfm8dtPb73Rs8eEBc5VZNjnu6Tin64uzasiMqJpAAPflRDXm7RBPpjrnU4JSeeWZF9QHYgxpdHylDzJlOEWr8V/vxhixGZ8r6YoyZKk2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740581336; c=relaxed/simple;
	bh=AbBaqP9w/NNjreD1ZEvZfrm2nt1L2A7aFAYmp9BxPBM=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=bghMn0lxGAc1Uv/CimaCJR4ZNgz5QvrSqk+UzN8HVVg5P0e+p0rNN5Dwekj04rSs0QSvPPadpyRVvWoWvCIenlySsmA9zGONAF+OZ6Moilorbo+GP92RLh7QDCfwsZsI62i468cXQRrJW1fZwOl44vwQ/Ej7f/yd4pw3f+vh9v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SBBPn9hc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 365A3C4CED6;
	Wed, 26 Feb 2025 14:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740581336;
	bh=AbBaqP9w/NNjreD1ZEvZfrm2nt1L2A7aFAYmp9BxPBM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SBBPn9hcx22VcHLFCaZDACMnQvzE8PXmaJl0xMMWNktsngiXt9KKvnpypkzgSQkm+
	 9Htu7lZBR6/QjDeO+53wk9BwCfor8Nr4VL2HSfGYrID9bo63Lt8+25ARKVSAtJLcaW
	 dWGkm1uecOsBXhSiBr/wvnWCuPm3zR+eH6/VJqZMwkF9SzKZRZe+xWCXJJSgVbqvdz
	 DxwLwvPmCs+2qiFYSQkPYMA8ERbSwBaX3qKbDMOvbp1idISlS9qzB52wnuOfjGmA+K
	 UvCV/m7EHHhJvXCQempAkGPXv0XB/FokLwYAQ602D5WoUbxh0PBIESl8C/Us4aBJTi
	 4DvqOAKxyWMPg==
Date: Wed, 26 Feb 2025 23:48:52 +0900
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
Subject: Re: [PATCH v3 2/4] ftrace: Add support for function argument to
 graph tracer
Message-Id: <20250226234852.5b6d2c34ef02d3e9a4b80d4e@kernel.org>
In-Reply-To: <20250225222653.724198940@goodmis.org>
References: <20250225222601.423129938@goodmis.org>
	<20250225222653.724198940@goodmis.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 25 Feb 2025 17:26:03 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: Sven Schnelle <svens@linux.ibm.com>
> 
> Wire up the code to print function arguments in the function graph
> tracer. This functionality can be enabled/disabled during runtime with
> options/funcgraph-args.
> 
> Example usage:
> 
> 6)              | dummy_xmit [dummy](skb = 0x8887c100, dev = 0x872ca000) {
> 6)              |   consume_skb(skb = 0x8887c100) {
> 6)              |     skb_release_head_state(skb = 0x8887c100) {
> 6)  0.178 us    |       sock_wfree(skb = 0x8887c100)
> 6)  0.627 us    |     }
> 
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Paul Walmsley <paul.walmsley@sifive.com>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: Albert Ou <aou@eecs.berkeley.edu>
> Cc: Guo Ren <guoren@kernel.org>
> Cc: Donglin Peng <dolinux.peng@gmail.com>
> Cc: Zheng Yejian <zhengyejian@huaweicloud.com>
> Link: https://lore.kernel.org/20241223201542.067076254@goodmis.org
> Co-developed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  kernel/trace/Kconfig                 |   6 ++
>  kernel/trace/trace.h                 |   1 +
>  kernel/trace/trace_entries.h         |   7 +-
>  kernel/trace/trace_functions_graph.c | 143 +++++++++++++++++++++------
>  4 files changed, 122 insertions(+), 35 deletions(-)
> 
> diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
> index 60412c1012ef..033fba0633cf 100644
> --- a/kernel/trace/Kconfig
> +++ b/kernel/trace/Kconfig
> @@ -268,6 +268,12 @@ config FUNCTION_TRACE_ARGS
>  	depends on HAVE_FUNCTION_ARG_ACCESS_API
>  	depends on DEBUG_INFO_BTF
>  	default y
> +	help
> +	  If supported with function argument access API and BTF, then
> +	  the function tracer and function graph tracer will support printing
> +	  of function arguments. This feature is off by default, and can be
> +	  enabled via the trace option func-args (for the function tracer) and
> +	  funcgraph-args (for the function graph tracer)
>  
>  config DYNAMIC_FTRACE
>  	bool "enable/disable function tracing dynamically"
> diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
> index 9c21ba45b7af..6963cd83b6da 100644
> --- a/kernel/trace/trace.h
> +++ b/kernel/trace/trace.h
> @@ -897,6 +897,7 @@ static __always_inline bool ftrace_hash_empty(struct ftrace_hash *hash)
>  #define TRACE_GRAPH_PRINT_RETVAL        0x800
>  #define TRACE_GRAPH_PRINT_RETVAL_HEX    0x1000
>  #define TRACE_GRAPH_PRINT_RETADDR       0x2000
> +#define TRACE_GRAPH_ARGS		0x4000
>  #define TRACE_GRAPH_PRINT_FILL_SHIFT	28
>  #define TRACE_GRAPH_PRINT_FILL_MASK	(0x3 << TRACE_GRAPH_PRINT_FILL_SHIFT)
>  
> diff --git a/kernel/trace/trace_entries.h b/kernel/trace/trace_entries.h
> index fbfb396905a6..77a8ba3bc1e3 100644
> --- a/kernel/trace/trace_entries.h
> +++ b/kernel/trace/trace_entries.h
> @@ -72,17 +72,18 @@ FTRACE_ENTRY_REG(function, ftrace_entry,
>  );
>  
>  /* Function call entry */
> -FTRACE_ENTRY_PACKED(funcgraph_entry, ftrace_graph_ent_entry,
> +FTRACE_ENTRY(funcgraph_entry, ftrace_graph_ent_entry,
>  
>  	TRACE_GRAPH_ENT,
>  
>  	F_STRUCT(
>  		__field_struct(	struct ftrace_graph_ent,	graph_ent	)
>  		__field_packed(	unsigned long,	graph_ent,	func		)
> -		__field_packed(	int,		graph_ent,	depth		)
> +		__field_packed(	unsigned long,	graph_ent,	depth		)
> +		__dynamic_array(unsigned long,	args				)
>  	),
>  
> -	F_printk("--> %ps (%d)", (void *)__entry->func, __entry->depth)
> +	F_printk("--> %ps (%lu)", (void *)__entry->func, __entry->depth)
>  );
>  
>  #ifdef CONFIG_FUNCTION_GRAPH_RETADDR
> diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_functions_graph.c
> index 136c750b0b4d..406b21472bde 100644
> --- a/kernel/trace/trace_functions_graph.c
> +++ b/kernel/trace/trace_functions_graph.c
> @@ -70,6 +70,10 @@ static struct tracer_opt trace_opts[] = {
>  #ifdef CONFIG_FUNCTION_GRAPH_RETADDR
>  	/* Display function return address ? */
>  	{ TRACER_OPT(funcgraph-retaddr, TRACE_GRAPH_PRINT_RETADDR) },
> +#endif
> +#ifdef CONFIG_FUNCTION_TRACE_ARGS
> +	/* Display function arguments ? */
> +	{ TRACER_OPT(funcgraph-args, TRACE_GRAPH_ARGS) },
>  #endif
>  	/* Include sleep time (scheduled out) between entry and return */
>  	{ TRACER_OPT(sleep-time, TRACE_GRAPH_SLEEP_TIME) },
> @@ -110,25 +114,41 @@ static void
>  print_graph_duration(struct trace_array *tr, unsigned long long duration,
>  		     struct trace_seq *s, u32 flags);
>  
> -int __trace_graph_entry(struct trace_array *tr,
> -				struct ftrace_graph_ent *trace,
> -				unsigned int trace_ctx)
> +static int __graph_entry(struct trace_array *tr, struct ftrace_graph_ent *trace,
> +			 unsigned int trace_ctx, struct ftrace_regs *fregs)
>  {
>  	struct ring_buffer_event *event;
>  	struct trace_buffer *buffer = tr->array_buffer.buffer;
>  	struct ftrace_graph_ent_entry *entry;
> +	int size;
>  
> -	event = trace_buffer_lock_reserve(buffer, TRACE_GRAPH_ENT,
> -					  sizeof(*entry), trace_ctx);
> +	/* If fregs is defined, add FTRACE_REGS_MAX_ARGS long size words */
> +	size = sizeof(*entry) + (FTRACE_REGS_MAX_ARGS * !!fregs * sizeof(long));

Is `!!fregs` always 1 if fregs != NULL? (seems to depend on compiler)

Others looks good to me.

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thank you,

> +
> +	event = trace_buffer_lock_reserve(buffer, TRACE_GRAPH_ENT, size, trace_ctx);
>  	if (!event)
>  		return 0;
> -	entry	= ring_buffer_event_data(event);
> -	entry->graph_ent			= *trace;
> +
> +	entry = ring_buffer_event_data(event);
> +	entry->graph_ent = *trace;
> +
> +	if (fregs) {
> +		for (int i = 0; i < FTRACE_REGS_MAX_ARGS; i++)
> +			entry->args[i] = ftrace_regs_get_argument(fregs, i);
> +	}
> +
>  	trace_buffer_unlock_commit_nostack(buffer, event);
>  
>  	return 1;
>  }
>  
> +int __trace_graph_entry(struct trace_array *tr,
> +				struct ftrace_graph_ent *trace,
> +				unsigned int trace_ctx)
> +{
> +	return __graph_entry(tr, trace, trace_ctx, NULL);
> +}
> +
>  #ifdef CONFIG_FUNCTION_GRAPH_RETADDR
>  int __trace_graph_retaddr_entry(struct trace_array *tr,
>  				struct ftrace_graph_ent *trace,
> @@ -174,9 +194,9 @@ struct fgraph_times {
>  	unsigned long long		sleeptime; /* may be optional! */
>  };
>  
> -int trace_graph_entry(struct ftrace_graph_ent *trace,
> -		      struct fgraph_ops *gops,
> -		      struct ftrace_regs *fregs)
> +static int graph_entry(struct ftrace_graph_ent *trace,
> +		       struct fgraph_ops *gops,
> +		       struct ftrace_regs *fregs)
>  {
>  	unsigned long *task_var = fgraph_get_task_var(gops);
>  	struct trace_array *tr = gops->private;
> @@ -246,7 +266,7 @@ int trace_graph_entry(struct ftrace_graph_ent *trace,
>  			unsigned long retaddr = ftrace_graph_top_ret_addr(current);
>  			ret = __trace_graph_retaddr_entry(tr, trace, trace_ctx, retaddr);
>  		} else {
> -			ret = __trace_graph_entry(tr, trace, trace_ctx);
> +			ret = __graph_entry(tr, trace, trace_ctx, fregs);
>  		}
>  	}
>  	preempt_enable_notrace();
> @@ -254,6 +274,20 @@ int trace_graph_entry(struct ftrace_graph_ent *trace,
>  	return ret;
>  }
>  
> +int trace_graph_entry(struct ftrace_graph_ent *trace,
> +		      struct fgraph_ops *gops,
> +		      struct ftrace_regs *fregs)
> +{
> +	return graph_entry(trace, gops, NULL);
> +}
> +
> +static int trace_graph_entry_args(struct ftrace_graph_ent *trace,
> +				  struct fgraph_ops *gops,
> +				  struct ftrace_regs *fregs)
> +{
> +	return graph_entry(trace, gops, fregs);
> +}
> +
>  static void
>  __trace_graph_function(struct trace_array *tr,
>  		unsigned long ip, unsigned int trace_ctx)
> @@ -418,7 +452,10 @@ static int graph_trace_init(struct trace_array *tr)
>  {
>  	int ret;
>  
> -	tr->gops->entryfunc = trace_graph_entry;
> +	if (tracer_flags_is_set(TRACE_GRAPH_ARGS))
> +		tr->gops->entryfunc = trace_graph_entry_args;
> +	else
> +		tr->gops->entryfunc = trace_graph_entry;
>  
>  	if (tracing_thresh)
>  		tr->gops->retfunc = trace_graph_thresh_return;
> @@ -775,7 +812,7 @@ static void print_graph_retaddr(struct trace_seq *s, struct fgraph_retaddr_ent_e
>  
>  static void print_graph_retval(struct trace_seq *s, struct ftrace_graph_ent_entry *entry,
>  				struct ftrace_graph_ret *graph_ret, void *func,
> -				u32 opt_flags, u32 trace_flags)
> +				u32 opt_flags, u32 trace_flags, int args_size)
>  {
>  	unsigned long err_code = 0;
>  	unsigned long retval = 0;
> @@ -809,7 +846,14 @@ static void print_graph_retval(struct trace_seq *s, struct ftrace_graph_ent_entr
>  		if (entry->ent.type != TRACE_GRAPH_RETADDR_ENT)
>  			print_retaddr = false;
>  
> -		trace_seq_printf(s, "%ps();", func);
> +		trace_seq_printf(s, "%ps", func);
> +
> +		if (args_size >= FTRACE_REGS_MAX_ARGS * sizeof(long)) {
> +			print_function_args(s, entry->args, (unsigned long)func);
> +			trace_seq_putc(s, ';');
> +		} else
> +			trace_seq_puts(s, "();");
> +
>  		if (print_retval || print_retaddr)
>  			trace_seq_puts(s, " /*");
>  		else
> @@ -836,7 +880,8 @@ static void print_graph_retval(struct trace_seq *s, struct ftrace_graph_ent_entr
>  
>  #else
>  
> -#define print_graph_retval(_seq, _ent, _ret, _func, _opt_flags, _trace_flags) do {} while (0)
> +#define print_graph_retval(_seq, _ent, _ret, _func, _opt_flags, _trace_flags, args_size) \
> +	do {} while (0)
>  
>  #endif
>  
> @@ -852,10 +897,14 @@ print_graph_entry_leaf(struct trace_iterator *iter,
>  	struct ftrace_graph_ret *graph_ret;
>  	struct ftrace_graph_ent *call;
>  	unsigned long long duration;
> +	unsigned long ret_func;
>  	unsigned long func;
> +	int args_size;
>  	int cpu = iter->cpu;
>  	int i;
>  
> +	args_size = iter->ent_size - offsetof(struct ftrace_graph_ent_entry, args);
> +
>  	graph_ret = &ret_entry->ret;
>  	call = &entry->graph_ent;
>  	duration = ret_entry->rettime - ret_entry->calltime;
> @@ -887,16 +936,25 @@ print_graph_entry_leaf(struct trace_iterator *iter,
>  	for (i = 0; i < call->depth * TRACE_GRAPH_INDENT; i++)
>  		trace_seq_putc(s, ' ');
>  
> +	ret_func = graph_ret->func + iter->tr->text_delta;
> +
>  	/*
>  	 * Write out the function return value or return address
>  	 */
>  	if (flags & (__TRACE_GRAPH_PRINT_RETVAL | __TRACE_GRAPH_PRINT_RETADDR)) {
>  		print_graph_retval(s, entry, graph_ret,
>  				   (void *)graph_ret->func + iter->tr->text_delta,
> -				   flags, tr->trace_flags);
> +				   flags, tr->trace_flags, args_size);
>  	} else {
> -		trace_seq_printf(s, "%ps();\n", (void *)func);
> +		trace_seq_printf(s, "%ps", (void *)ret_func);
> +
> +		if (args_size >= FTRACE_REGS_MAX_ARGS * sizeof(long)) {
> +			print_function_args(s, entry->args, ret_func);
> +			trace_seq_putc(s, ';');
> +		} else
> +			trace_seq_puts(s, "();");
>  	}
> +	trace_seq_printf(s, "\n");
>  
>  	print_graph_irq(iter, graph_ret->func, TRACE_GRAPH_RET,
>  			cpu, iter->ent->pid, flags);
> @@ -913,6 +971,7 @@ print_graph_entry_nested(struct trace_iterator *iter,
>  	struct fgraph_data *data = iter->private;
>  	struct trace_array *tr = iter->tr;
>  	unsigned long func;
> +	int args_size;
>  	int i;
>  
>  	if (data) {
> @@ -937,7 +996,17 @@ print_graph_entry_nested(struct trace_iterator *iter,
>  
>  	func = call->func + iter->tr->text_delta;
>  
> -	trace_seq_printf(s, "%ps() {", (void *)func);
> +	trace_seq_printf(s, "%ps", (void *)func);
> +
> +	args_size = iter->ent_size - offsetof(struct ftrace_graph_ent_entry, args);
> +
> +	if (args_size >= FTRACE_REGS_MAX_ARGS * sizeof(long))
> +		print_function_args(s, entry->args, func);
> +	else
> +		trace_seq_puts(s, "()");
> +
> +	trace_seq_puts(s, " {");
> +
>  	if (flags & __TRACE_GRAPH_PRINT_RETADDR  &&
>  		entry->ent.type == TRACE_GRAPH_RETADDR_ENT)
>  		print_graph_retaddr(s, (struct fgraph_retaddr_ent_entry *)entry,
> @@ -1107,21 +1176,38 @@ print_graph_entry(struct ftrace_graph_ent_entry *field, struct trace_seq *s,
>  			struct trace_iterator *iter, u32 flags)
>  {
>  	struct fgraph_data *data = iter->private;
> -	struct ftrace_graph_ent *call = &field->graph_ent;
> +	struct ftrace_graph_ent *call;
>  	struct ftrace_graph_ret_entry *leaf_ret;
>  	static enum print_line_t ret;
>  	int cpu = iter->cpu;
> +	/*
> +	 * print_graph_entry() may consume the current event,
> +	 * thus @field may become invalid, so we need to save it.
> +	 * sizeof(struct ftrace_graph_ent_entry) is very small,
> +	 * it can be safely saved at the stack.
> +	 */
> +	struct ftrace_graph_ent_entry *entry;
> +	u8 save_buf[sizeof(*entry) + FTRACE_REGS_MAX_ARGS * sizeof(long)];
> +
> +	/* The ent_size is expected to be as big as the entry */
> +	if (iter->ent_size > sizeof(save_buf))
> +		iter->ent_size = sizeof(save_buf);
> +
> +	entry = (void *)save_buf;
> +	memcpy(entry, field, iter->ent_size);
> +
> +	call = &entry->graph_ent;
>  
>  	if (check_irq_entry(iter, flags, call->func, call->depth))
>  		return TRACE_TYPE_HANDLED;
>  
>  	print_graph_prologue(iter, s, TRACE_GRAPH_ENT, call->func, flags);
>  
> -	leaf_ret = get_return_for_leaf(iter, field);
> +	leaf_ret = get_return_for_leaf(iter, entry);
>  	if (leaf_ret)
> -		ret = print_graph_entry_leaf(iter, field, leaf_ret, s, flags);
> +		ret = print_graph_entry_leaf(iter, entry, leaf_ret, s, flags);
>  	else
> -		ret = print_graph_entry_nested(iter, field, s, cpu, flags);
> +		ret = print_graph_entry_nested(iter, entry, s, cpu, flags);
>  
>  	if (data) {
>  		/*
> @@ -1195,7 +1281,8 @@ print_graph_return(struct ftrace_graph_ret_entry *retentry, struct trace_seq *s,
>  	 * funcgraph-retval option is enabled.
>  	 */
>  	if (flags & __TRACE_GRAPH_PRINT_RETVAL) {
> -		print_graph_retval(s, NULL, trace, (void *)func, flags, tr->trace_flags);
> +		print_graph_retval(s, NULL, trace, (void *)func, flags,
> +				   tr->trace_flags, 0);
>  	} else {
>  		/*
>  		 * If the return function does not have a matching entry,
> @@ -1323,16 +1410,8 @@ print_graph_function_flags(struct trace_iterator *iter, u32 flags)
>  
>  	switch (entry->type) {
>  	case TRACE_GRAPH_ENT: {
> -		/*
> -		 * print_graph_entry() may consume the current event,
> -		 * thus @field may become invalid, so we need to save it.
> -		 * sizeof(struct ftrace_graph_ent_entry) is very small,
> -		 * it can be safely saved at the stack.
> -		 */
> -		struct ftrace_graph_ent_entry saved;
>  		trace_assign_type(field, entry);
> -		saved = *field;
> -		return print_graph_entry(&saved, s, iter, flags);
> +		return print_graph_entry(field, s, iter, flags);
>  	}
>  #ifdef CONFIG_FUNCTION_GRAPH_RETADDR
>  	case TRACE_GRAPH_RETADDR_ENT: {
> -- 
> 2.47.2
> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

