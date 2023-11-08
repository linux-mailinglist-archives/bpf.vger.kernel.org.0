Return-Path: <bpf+bounces-14537-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F9797E60EC
	for <lists+bpf@lfdr.de>; Thu,  9 Nov 2023 00:17:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4F30B20E36
	for <lists+bpf@lfdr.de>; Wed,  8 Nov 2023 23:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8B05374CD;
	Wed,  8 Nov 2023 23:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UULKIzPs"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0BD37155;
	Wed,  8 Nov 2023 23:17:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46EFCC433C8;
	Wed,  8 Nov 2023 23:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699485442;
	bh=A61QSgAHTUidhHWNUPoLyQP/PqkIqPBtNVyUIxXzMHU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UULKIzPsczyyz8cCJQUw/8Q1tUxWoFTHW7cXMRqA2ACnlxst706WPH8w4eLMsU3pC
	 d16rBnzR0bMGTrmdgfBUe8c8IiFgCIYMCdQUOOJVtZJAniIrsgwQgWXLyQXS5L7SKh
	 oXLQzav6+r+fFhgmrVarqmckySccE68DjZTMo4KWVhraxqBMwKyR+aU5RrTLo6U8Bf
	 tJUxCSi+cX8al2DgVGlR/1ZId31TSzUWl4zyRetB7qVQLqr2NIItGGlYZWA+hwI/Qw
	 i4iitv9lfhel2ZYujY/IS8aSkJ8z5E0mw75+m9wcnj7Y0GPDOnxDLLEZpVLaXsR8Jt
	 gd67ul8gZBLwg==
Date: Thu, 9 Nov 2023 08:17:16 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Steven Rostedt
 <rostedt@goodmis.org>, Florent Revest <revest@chromium.org>,
 linux-trace-kernel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, bpf <bpf@vger.kernel.org>, Sven
 Schnelle <svens@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>, Jiri
 Olsa <jolsa@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Alan Maguire <alan.maguire@oracle.com>,
 Mark Rutland <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>, Guo Ren <guoren@kernel.org>
Subject: Re: [RFC PATCH v2 20/31] function_graph: Add a new exit handler
 with parent_ip and ftrace_regs
Message-Id: <20231109081716.aecba97c4ee005250fe163c0@kernel.org>
In-Reply-To: <169945369135.55307.16963023663631933656.stgit@devnote2>
References: <169945345785.55307.5003201137843449313.stgit@devnote2>
	<169945369135.55307.16963023663631933656.stgit@devnote2>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  8 Nov 2023 23:28:11 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Add a new return handler to fgraph_ops as 'retregfunc'  which takes
> parent_ip and ftrace_regs instead of ftrace_graph_ret. This handler
> is available only if the arch support CONFIG_HAVE_FUNCTION_GRAPH_FREGS.
> Note that the 'retfunc' and 'reregfunc' are mutual exclusive.
> You can set only one of them.
> 
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>  arch/x86/include/asm/ftrace.h |    2 +
>  include/linux/ftrace.h        |   10 +++++-
>  kernel/trace/Kconfig          |    5 ++-
>  kernel/trace/fgraph.c         |   74 +++++++++++++++++++++++++++--------------
>  4 files changed, 63 insertions(+), 28 deletions(-)
> 
> diff --git a/arch/x86/include/asm/ftrace.h b/arch/x86/include/asm/ftrace.h
> index fc60974a1d89..4701d009c215 100644
> --- a/arch/x86/include/asm/ftrace.h
> +++ b/arch/x86/include/asm/ftrace.h
> @@ -72,6 +72,8 @@ arch_ftrace_get_regs(struct ftrace_regs *fregs)
>  	override_function_with_return(&(fregs)->regs)
>  #define ftrace_regs_query_register_offset(name) \
>  	regs_query_register_offset(name)
> +#define ftrace_regs_get_frame_pointer(fregs) \
> +	frame_pointer(&(fregs)->regs)
>  
>  struct ftrace_ops;
>  #define ftrace_graph_func ftrace_graph_func
> diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
> index c91b234949d5..8efccd911d41 100644
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
> @@ -156,6 +158,7 @@ struct ftrace_regs {
>  #define ftrace_regs_set_instruction_pointer(fregs, ip) do { } while (0)
>  #endif /* CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS */
>  
> +
>  static __always_inline struct pt_regs *ftrace_get_regs(struct ftrace_regs *fregs)
>  {
>  	if (!fregs)
> @@ -1066,6 +1069,10 @@ typedef int (*trace_func_graph_regs_ent_t)(unsigned long func,
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
> @@ -1075,6 +1082,7 @@ struct fgraph_ops {
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
> index 6567b18c6c54..cf240914ef9b 100644
> --- a/kernel/trace/fgraph.c
> +++ b/kernel/trace/fgraph.c
> @@ -623,8 +623,7 @@ int function_graph_enter_regs(unsigned long ret, unsigned long func,
>  
>  /* Retrieve a function return address to the trace stack on thread info.*/
>  static struct ftrace_ret_stack *
> -ftrace_pop_return_trace(struct ftrace_graph_ret *trace, unsigned long *ret,
> -			unsigned long frame_pointer)
> +ftrace_pop_return_trace(unsigned long *ret, unsigned long frame_pointer)
>  {
>  	struct ftrace_ret_stack *ret_stack;
>  	int index;
> @@ -669,10 +668,6 @@ ftrace_pop_return_trace(struct ftrace_graph_ret *trace, unsigned long *ret,
>  #endif
>  
>  	*ret = ret_stack->ret;
> -	trace->func = ret_stack->func;
> -	trace->calltime = ret_stack->calltime;
> -	trace->overrun = atomic_read(&current->trace_overrun);
> -	trace->depth = current->curr_ret_depth;
>  	/*
>  	 * We still want to trace interrupts coming in if
>  	 * max_depth is set to 1. Make sure the decrement is
> @@ -711,22 +706,43 @@ static struct notifier_block ftrace_suspend_notifier = {
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
> +		trace.retval = ftrace_regs_return_value(fregs);
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
> -	unsigned long ret;
> +	struct fgraph_ops *gops;
>  	int curr_ret_stack;
> +	unsigned long ret;
>  	int stop_at;
>  	int index;
> -	int idx;
>  
> -	ret_stack = ftrace_pop_return_trace(&trace, &ret, frame_pointer);
> +	ret_stack = ftrace_pop_return_trace(&ret, frame_pointer);
>  
>  	if (unlikely(!ret_stack)) {
>  		ftrace_graph_stop();
> @@ -735,11 +751,6 @@ static unsigned long __ftrace_return_to_handler(struct fgraph_ret_regs *ret_regs
>  		return (unsigned long)panic;
>  	}
>  
> -	trace.rettime = trace_clock_local();
> -#ifdef CONFIG_FUNCTION_GRAPH_RETVAL
> -	trace.retval = fgraph_ret_regs_return_value(ret_regs);
> -#endif
> -

So, here we need

	if (fregs)
		ftrace_regs_set_instruction_pointer(fregs, ret);

set return address to the instruction pointer.

Thank you,

>  	curr_ret_stack = current->curr_ret_stack;
>  	index = get_ret_stack_index(current, curr_ret_stack - 1);
>  
> @@ -752,8 +763,11 @@ static unsigned long __ftrace_return_to_handler(struct fgraph_ret_regs *ret_regs
>  		val = current->ret_stack[curr_ret_stack - 1];
>  		switch (__get_type(val)) {
>  		case FGRAPH_TYPE_ARRAY:
> -			idx = __get_array(val);
> -			fgraph_array[idx]->retfunc(&trace, fgraph_array[idx]);
> +			gops = fgraph_array[__get_array(val)];
> +			if (gops->retregfunc)
> +				gops->retregfunc(ret_stack->func, ret, fregs, gops);
> +			else
> +				fgraph_call_retfunc(fregs, ret_regs, ret_stack, gops);
>  			curr_ret_stack -= __get_index(val);
>  			break;
>  		case FGRAPH_TYPE_RESERVED:
> @@ -777,20 +791,22 @@ static unsigned long __ftrace_return_to_handler(struct fgraph_ret_regs *ret_regs
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
> @@ -1131,9 +1147,15 @@ int register_ftrace_graph(struct fgraph_ops *gops)
>  	int ret = 0;
>  	int i;
>  
> -	if (gops->entryfunc && gops->entryregfunc)
> +	if ((gops->entryfunc && gops->entryregfunc) ||
> +	    (gops->retfunc && gops->retregfunc))
>  		return -EINVAL;
>  
> +#ifndef CONFIG_HAVE_FUNCTION_GRAPH_FREGS
> +	if (gops->retregfunc)
> +		return -EOPNOTSUPP;
> +#endif
> +
>  	mutex_lock(&ftrace_lock);
>  
>  	if (!gops->ops.func) {
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

