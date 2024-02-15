Return-Path: <bpf+bounces-22091-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 530588568C3
	for <lists+bpf@lfdr.de>; Thu, 15 Feb 2024 17:05:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F373AB23F6E
	for <lists+bpf@lfdr.de>; Thu, 15 Feb 2024 16:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A2221339BA;
	Thu, 15 Feb 2024 16:02:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB241339AC;
	Thu, 15 Feb 2024 16:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708012953; cv=none; b=KwLNwlZcYK3LaoL7EPTJEK5IuAjewmd3NeSjKk5h2s2uURbtM1i4axuaAYX6r4TFUHjv8Bz6hCmaHJX07MaM2CoWIkuPPlcJ4W7JnxWqUhY1TKRKU/+iuE1I7Zbeu0Y2540iybSSwB/5UnoHl/RSNXaNu4S71y5T6RlLiUGeDs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708012953; c=relaxed/simple;
	bh=/+fne283SwLfLLYGzz2ez1h0i4N4vwIofnJGJ1JOlLE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TItRQphPFBRuab8KBH9Bun//8yaXciIAvGbfTQUPqpe3t46AU2hKxObW47b6urgflQZYEdSv+VXunsCM1LDVvWsShCtA2YtL0Cnd8sldQC1y22CXh3zYr9elof4mcohyZ5JH9ec7ULNfCZGCZdWf5KrjrhK3K1R6R8ST+Bxx61w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B129C433C7;
	Thu, 15 Feb 2024 16:02:31 +0000 (UTC)
Date: Thu, 15 Feb 2024 11:04:04 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Florent Revest
 <revest@chromium.org>, linux-trace-kernel@vger.kernel.org, LKML
 <linux-kernel@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
 bpf <bpf@vger.kernel.org>, Sven Schnelle <svens@linux.ibm.com>, Alexei
 Starovoitov <ast@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Arnaldo
 Carvalho de Melo <acme@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Alan Maguire <alan.maguire@oracle.com>, Mark Rutland
 <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>, Thomas
 Gleixner <tglx@linutronix.de>, Guo Ren <guoren@kernel.org>
Subject: Re: [PATCH v7 23/36] function_graph: Add a new exit handler with
 parent_ip and ftrace_regs
Message-ID: <20240215110404.4e8c5a94@gandalf.local.home>
In-Reply-To: <170723230476.502590.16817817024423790038.stgit@devnote2>
References: <170723204881.502590.11906735097521170661.stgit@devnote2>
	<170723230476.502590.16817817024423790038.stgit@devnote2>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  7 Feb 2024 00:11:44 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> diff --git a/arch/x86/include/asm/ftrace.h b/arch/x86/include/asm/ftrace.h
> index c88bf47f46da..a061f8832b20 100644
> --- a/arch/x86/include/asm/ftrace.h
> +++ b/arch/x86/include/asm/ftrace.h
> @@ -72,6 +72,8 @@ arch_ftrace_get_regs(struct ftrace_regs *fregs)
>  	override_function_with_return(&(fregs)->regs)
>  #define ftrace_regs_query_register_offset(name) \
>  	regs_query_register_offset(name)
> +#define ftrace_regs_get_frame_pointer(fregs) \
> +	frame_pointer(&(fregs)->regs)
>  

Doesn't the above belong in the next patch that implements this for x86?

>  struct ftrace_ops;
>  #define ftrace_graph_func ftrace_graph_func
> diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
> index 65d4d4b68768..da2a23f5a9ed 100644
> --- a/include/linux/ftrace.h
> +++ b/include/linux/ftrace.h
> @@ -43,7 +43,9 @@ struct dyn_ftrace;
>  
>  char *arch_ftrace_match_adjust(char *str, const char *search);
>  
> -#ifdef CONFIG_HAVE_FUNCTION_GRAPH_RETVAL
> +#ifdef CONFIG_HAVE_FUNCTION_GRAPH_FREGS
> +unsigned long ftrace_return_to_handler(struct ftrace_regs *fregs);
> +#elif defined(CONFIG_HAVE_FUNCTION_GRAPH_RETVAL)
>  struct fgraph_ret_regs;
>  unsigned long ftrace_return_to_handler(struct fgraph_ret_regs *ret_regs);
>  #else
> @@ -157,6 +159,7 @@ struct ftrace_regs {
>  #define ftrace_regs_set_instruction_pointer(fregs, ip) do { } while (0)
>  #endif /* CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS */
>  
> +

spurious newline.

>  static __always_inline struct pt_regs *ftrace_get_regs(struct ftrace_regs *fregs)
>  {
>  	if (!fregs)
> @@ -1067,6 +1070,10 @@ typedef int (*trace_func_graph_regs_ent_t)(unsigned long func,
>  					   unsigned long parent_ip,
>  					   struct ftrace_regs *fregs,
>  					   struct fgraph_ops *); /* entry w/ regs */
> +typedef void (*trace_func_graph_regs_ret_t)(unsigned long func,
> +					    unsigned long parent_ip,
> +					    struct ftrace_regs *,
> +					    struct fgraph_ops *); /* return w/ regs */
>  
>  extern int ftrace_graph_entry_stub(struct ftrace_graph_ent *trace, struct fgraph_ops *gops);
>  
> @@ -1076,6 +1083,7 @@ struct fgraph_ops {
>  	trace_func_graph_ent_t		entryfunc;
>  	trace_func_graph_ret_t		retfunc;
>  	trace_func_graph_regs_ent_t	entryregfunc;
> +	trace_func_graph_regs_ret_t	retregfunc;
>  	struct ftrace_ops		ops; /* for the hash lists */
>  	void				*private;
>  	int				idx;
> diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
> index 61c541c36596..308b3bec01b1 100644
> --- a/kernel/trace/Kconfig
> +++ b/kernel/trace/Kconfig
> @@ -34,6 +34,9 @@ config HAVE_FUNCTION_GRAPH_TRACER
>  config HAVE_FUNCTION_GRAPH_RETVAL
>  	bool
>  
> +config HAVE_FUNCTION_GRAPH_FREGS
> +	bool
> +
>  config HAVE_DYNAMIC_FTRACE
>  	bool
>  	help
> @@ -232,7 +235,7 @@ config FUNCTION_GRAPH_TRACER
>  
>  config FUNCTION_GRAPH_RETVAL
>  	bool "Kernel Function Graph Return Value"
> -	depends on HAVE_FUNCTION_GRAPH_RETVAL
> +	depends on HAVE_FUNCTION_GRAPH_RETVAL || HAVE_FUNCTION_GRAPH_FREGS
>  	depends on FUNCTION_GRAPH_TRACER
>  	default n
>  	help
> diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
> index 459912ca72e0..12e5f108e242 100644
> --- a/kernel/trace/fgraph.c
> +++ b/kernel/trace/fgraph.c
> @@ -752,8 +752,8 @@ int function_graph_enter_ops(unsigned long ret, unsigned long func,
>  
>  /* Retrieve a function return address to the trace stack on thread info.*/
>  static struct ftrace_ret_stack *
> -ftrace_pop_return_trace(struct ftrace_graph_ret *trace, unsigned long *ret,
> -			unsigned long frame_pointer, int *index)
> +ftrace_pop_return_trace(unsigned long *ret, unsigned long frame_pointer,
> +			int *index)
>  {
>  	struct ftrace_ret_stack *ret_stack;
>  
> @@ -798,10 +798,6 @@ ftrace_pop_return_trace(struct ftrace_graph_ret *trace, unsigned long *ret,
>  
>  	*index += FGRAPH_RET_INDEX;
>  	*ret = ret_stack->ret;
> -	trace->func = ret_stack->func;
> -	trace->calltime = ret_stack->calltime;
> -	trace->overrun = atomic_read(&current->trace_overrun);
> -	trace->depth = current->curr_ret_depth;

There's a lot of information stored in the trace structure. Why not pass
that to the new retregfunc?

Then you don't need to separate this code out.

>  	/*
>  	 * We still want to trace interrupts coming in if
>  	 * max_depth is set to 1. Make sure the decrement is
> @@ -840,21 +836,42 @@ static struct notifier_block ftrace_suspend_notifier = {
>  /* fgraph_ret_regs is not defined without CONFIG_FUNCTION_GRAPH_RETVAL */
>  struct fgraph_ret_regs;
>  
> +static void fgraph_call_retfunc(struct ftrace_regs *fregs,
> +				struct fgraph_ret_regs *ret_regs,
> +				struct ftrace_ret_stack *ret_stack,
> +				struct fgraph_ops *gops)
> +{
> +	struct ftrace_graph_ret trace;
> +
> +	trace.func = ret_stack->func;
> +	trace.calltime = ret_stack->calltime;
> +	trace.overrun = atomic_read(&current->trace_overrun);
> +	trace.depth = current->curr_ret_depth;
> +	trace.rettime = trace_clock_local();
> +#ifdef CONFIG_FUNCTION_GRAPH_RETVAL
> +	if (fregs)
> +		trace.retval = ftrace_regs_get_return_value(fregs);
> +	else
> +		trace.retval = fgraph_ret_regs_return_value(ret_regs);
> +#endif
> +	gops->retfunc(&trace, gops);
> +}
> +
>  /*
>   * Send the trace to the ring-buffer.
>   * @return the original return address.
>   */
> -static unsigned long __ftrace_return_to_handler(struct fgraph_ret_regs *ret_regs,
> +static unsigned long __ftrace_return_to_handler(struct ftrace_regs *fregs,
> +						struct fgraph_ret_regs *ret_regs,
>  						unsigned long frame_pointer)
>  {
>  	struct ftrace_ret_stack *ret_stack;
> -	struct ftrace_graph_ret trace;
>  	unsigned long bitmap;
>  	unsigned long ret;
>  	int index;
>  	int i;
>  
> -	ret_stack = ftrace_pop_return_trace(&trace, &ret, frame_pointer, &index);
> +	ret_stack = ftrace_pop_return_trace(&ret, frame_pointer, &index);
>  
>  	if (unlikely(!ret_stack)) {
>  		ftrace_graph_stop();
> @@ -863,10 +880,8 @@ static unsigned long __ftrace_return_to_handler(struct fgraph_ret_regs *ret_regs
>  		return (unsigned long)panic;
>  	}
>  
> -	trace.rettime = trace_clock_local();
> -#ifdef CONFIG_FUNCTION_GRAPH_RETVAL
> -	trace.retval = fgraph_ret_regs_return_value(ret_regs);
> -#endif
> +	if (fregs)
> +		ftrace_regs_set_instruction_pointer(fregs, ret);
>  
>  	bitmap = get_fgraph_index_bitmap(current, index);
>  	for (i = 0; i < FGRAPH_ARRAY_SIZE; i++) {
> @@ -877,7 +892,10 @@ static unsigned long __ftrace_return_to_handler(struct fgraph_ret_regs *ret_regs
>  		if (gops == &fgraph_stub)
>  			continue;
>  
> -		gops->retfunc(&trace, gops);
> +		if (gops->retregfunc)
> +			gops->retregfunc(ret_stack->func, ret, fregs, gops);
> +		else
> +			fgraph_call_retfunc(fregs, ret_regs, ret_stack, gops);
>  	}
>  
>  	/*
> @@ -892,20 +910,22 @@ static unsigned long __ftrace_return_to_handler(struct fgraph_ret_regs *ret_regs
>  	return ret;
>  }
>  
> -/*
> - * After all architecures have selected HAVE_FUNCTION_GRAPH_RETVAL, we can
> - * leave only ftrace_return_to_handler(ret_regs).
> - */
> -#ifdef CONFIG_HAVE_FUNCTION_GRAPH_RETVAL
> +#ifdef CONFIG_HAVE_FUNCTION_GRAPH_FREGS
> +unsigned long ftrace_return_to_handler(struct ftrace_regs *fregs)
> +{
> +	return __ftrace_return_to_handler(fregs, NULL,
> +				ftrace_regs_get_frame_pointer(fregs));
> +}
> +#elif defined(CONFIG_HAVE_FUNCTION_GRAPH_RETVAL)
>  unsigned long ftrace_return_to_handler(struct fgraph_ret_regs *ret_regs)
>  {
> -	return __ftrace_return_to_handler(ret_regs,
> +	return __ftrace_return_to_handler(NULL, ret_regs,
>  				fgraph_ret_regs_frame_pointer(ret_regs));
>  }
>  #else
>  unsigned long ftrace_return_to_handler(unsigned long frame_pointer)
>  {
> -	return __ftrace_return_to_handler(NULL, frame_pointer);
> +	return __ftrace_return_to_handler(NULL, NULL, frame_pointer);
>  }
>  #endif
>  
> @@ -1262,9 +1282,15 @@ int register_ftrace_graph(struct fgraph_ops *gops)
>  	int ret = 0;
>  	int i;
>  
> -	if (gops->entryfunc && gops->entryregfunc)
> +	if ((gops->entryfunc && gops->entryregfunc) ||
> +	    (gops->retfunc && gops->retregfunc))
>  		return -EINVAL;

With a union, you don't need this.

Now, is it possible to have a entryregfunc and a retfunc, or a entryfunc
and a retregfunc?

-- Steve

>  
> +#ifndef CONFIG_HAVE_FUNCTION_GRAPH_FREGS
> +	if (gops->retregfunc)
> +		return -EOPNOTSUPP;
> +#endif
> +
>  	mutex_lock(&ftrace_lock);
>  
>  	if (!gops->ops.func) {


