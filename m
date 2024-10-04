Return-Path: <bpf+bounces-41028-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EC8D991263
	for <lists+bpf@lfdr.de>; Sat,  5 Oct 2024 00:39:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCBCF1F23ED5
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 22:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99D1C1B4F26;
	Fri,  4 Oct 2024 22:39:14 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488241ADFE5;
	Fri,  4 Oct 2024 22:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728081554; cv=none; b=svBStdEpSnnYBA/ylADYB0DYhYmGKAKdB3/c23xtDsXIL23cqrjVDzhsRe2ANfYxAPx0Vi7Nd1O1Y67a8QBPab1ub5UVd8eipUA8r38w1pLLITRW0mBfZcwwKTHYQxuavrbtNp03D9RVffbu8iHo9yg5RpxmyB4fFNMXN6xkIAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728081554; c=relaxed/simple;
	bh=tefueRlwND1jrTinLe9/yebVtVaMB4nAUXnZwi6vS2U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g8rowLzGbBMxupg/y97nETRXOL8R83HOSHH8NC3RfP2CPNCgwnWeQZ0BPNP+Hw/E/vLlF5DvZ4ElICzdQufoWKy9kjkbpaX/OOEzyjkWM/GBrMOimq2L1jnyxahMqeRAlK/PohqIIK3sSnBYbBsDcs4Q0KzwXkwmNSnv71qXc5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D489BC4CEC6;
	Fri,  4 Oct 2024 22:39:12 +0000 (UTC)
Date: Fri, 4 Oct 2024 18:40:08 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Sven Schnelle <svens@linux.ibm.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org
Subject: Re: [PATCH 6/7] tracing: add support for function argument to graph
 tracer
Message-ID: <20241004184008.151c64a7@gandalf.local.home>
In-Reply-To: <20240904065908.1009086-7-svens@linux.ibm.com>
References: <20240904065908.1009086-1-svens@linux.ibm.com>
	<20240904065908.1009086-7-svens@linux.ibm.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  4 Sep 2024 08:59:00 +0200
Sven Schnelle <svens@linux.ibm.com> wrote:

> Wire up the code to print function arguments in the function graph
> tracer. This functionality can be enabled/disabled during compile
> time by setting CONFIG_FUNCTION_TRACE_ARGS and during runtime with
> options/funcgraph-args.

I finally got around to looking at your patches. Do you plan on still
working on them? I really like this feature, and I'm willing to do the work
too if you have other things on your plate.

> 
> Example usage:
> 
> 6)              | dummy_xmit [dummy](skb = 0x8887c100, dev = 0x872ca000) {
> 6)              |   consume_skb(skb = 0x8887c100) {
> 6)              |     skb_release_head_state(skb = 0x8887c100) {
> 6)  0.178 us    |       sock_wfree(skb = 0x8887c100)
> 6)  0.627 us    |     }
> 
> Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
> ---
>  include/linux/ftrace.h               |  1 +
>  kernel/trace/fgraph.c                |  6 ++-
>  kernel/trace/trace_functions_graph.c | 74 ++++++++++++++--------------
>  3 files changed, 44 insertions(+), 37 deletions(-)

BTW, this is missing:

diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 2f8017f8d34d..8a218b39d11d 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -879,6 +879,7 @@ static __always_inline bool ftrace_hash_empty(struct ftrace_hash *hash)
 #define TRACE_GRAPH_GRAPH_TIME          0x400
 #define TRACE_GRAPH_PRINT_RETVAL        0x800
 #define TRACE_GRAPH_PRINT_RETVAL_HEX    0x1000
+#define TRACE_GRAPH_ARGS		0x2000
 #define TRACE_GRAPH_PRINT_FILL_SHIFT	28
 #define TRACE_GRAPH_PRINT_FILL_MASK	(0x3 << TRACE_GRAPH_PRINT_FILL_SHIFT)
 
that you added in patch 7, but is needed for this patch, where it does not
build without it.

> 
> diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
> index 56d91041ecd2..5d0ff66f8a70 100644
> --- a/include/linux/ftrace.h
> +++ b/include/linux/ftrace.h
> @@ -1010,6 +1010,7 @@ static inline void ftrace_init(void) { }
>   * to remove extra padding at the end.
>   */
>  struct ftrace_graph_ent {
> +	struct ftrace_regs regs;
>  	unsigned long func; /* Current function */
>  	int depth;
>  } __packed;

This should have a different event type, to not waste the ring buffer when
not needed.

struct ftrace_graph_ent_args {
	struct ftrace_regs_args fargs;
	unsigned long func; /* Current function */
	int depth;
} __packed;

But also, we need to create a new structure, as nothing should depend on
the size of ftrace_regs (we plan on hiding that completely). I can add a
"struct ftrace_regs_args" that will hold just the args for each arch.
Especially for archs (like x86) where ftrace_regs can be pt_regs in size,
where most of the space is just wasted. Then we can do a:

	ftrace_regs_copy_args(fregs, &entry->addr);

And then:

	char buf[ftrace_regs_size()];
	struct ftrace_regs *fregs = &buf;

	ftrace_regs_from_args(fregs, &entry->addr);

to get the arguments.




> diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
> index fa62ebfa0711..f4bb10c0aa52 100644
> --- a/kernel/trace/fgraph.c
> +++ b/kernel/trace/fgraph.c
> @@ -614,7 +614,7 @@ ftrace_push_return_trace(unsigned long ret, unsigned long func,
>  /* If the caller does not use ftrace, call this function. */
>  int function_graph_enter(unsigned long ret, unsigned long func,
>  			 unsigned long frame_pointer, unsigned long *retp,
> -			struct ftrace_regs *fregs)
> +			 struct ftrace_regs *fregs)
>  {
>  	struct ftrace_graph_ent trace;
>  	unsigned long bitmap = 0;
> @@ -623,6 +623,10 @@ int function_graph_enter(unsigned long ret, unsigned long func,
>  
>  	trace.func = func;
>  	trace.depth = ++current->curr_ret_depth;
> +	if (IS_ENABLED(CONFIG_FUNCTION_TRACE_ARGS) && fregs)
> +		trace.regs = *fregs;
> +	else
> +		memset(&trace.regs, 0, sizeof(struct ftrace_regs));
>  
>  	offset = ftrace_push_return_trace(ret, func, frame_pointer, retp, 0);
>  	if (offset < 0)
> diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_functions_graph.c
> index 13d0387ac6a6..be0cee52944a 100644
> --- a/kernel/trace/trace_functions_graph.c
> +++ b/kernel/trace/trace_functions_graph.c
> @@ -12,6 +12,8 @@
>  #include <linux/interrupt.h>
>  #include <linux/slab.h>
>  #include <linux/fs.h>
> +#include <linux/btf.h>
> +#include <linux/bpf.h>
>  
>  #include "trace.h"
>  #include "trace_output.h"
> @@ -63,6 +65,9 @@ static struct tracer_opt trace_opts[] = {
>  	{ TRACER_OPT(funcgraph-retval, TRACE_GRAPH_PRINT_RETVAL) },
>  	/* Display function return value in hexadecimal format ? */
>  	{ TRACER_OPT(funcgraph-retval-hex, TRACE_GRAPH_PRINT_RETVAL_HEX) },
> +#endif
> +#ifdef CONFIG_FUNCTION_TRACE_ARGS
> +	{ TRACER_OPT(funcgraph-args, TRACE_GRAPH_ARGS) },
>  #endif
>  	/* Include sleep time (scheduled out) between entry and return */
>  	{ TRACER_OPT(sleep-time, TRACE_GRAPH_SLEEP_TIME) },
> @@ -653,7 +658,7 @@ print_graph_duration(struct trace_array *tr, unsigned long long duration,
>  #define __TRACE_GRAPH_PRINT_RETVAL TRACE_GRAPH_PRINT_RETVAL
>  
>  static void print_graph_retval(struct trace_seq *s, unsigned long retval,
> -				bool leaf, void *func, bool hex_format)
> +			       bool hex_format)
>  {
>  	unsigned long err_code = 0;
>  
> @@ -673,28 +678,17 @@ static void print_graph_retval(struct trace_seq *s, unsigned long retval,
>  		err_code = 0;
>  
>  done:
> -	if (leaf) {
> -		if (hex_format || (err_code == 0))
> -			trace_seq_printf(s, "%ps(); /* = 0x%lx */\n",
> -					func, retval);
> -		else
> -			trace_seq_printf(s, "%ps(); /* = %ld */\n",
> -					func, err_code);
> -	} else {
> -		if (hex_format || (err_code == 0))
> -			trace_seq_printf(s, "} /* %ps = 0x%lx */\n",
> -					func, retval);
> -		else
> -			trace_seq_printf(s, "} /* %ps = %ld */\n",
> -					func, err_code);
> -	}
> +	if (hex_format || (err_code == 0))
> +		trace_seq_printf(s, " /* = 0x%lx */", retval);
> +	else
> +		trace_seq_printf(s, " /* = %ld */", err_code);
>  }
>  
>  #else
>  
>  #define __TRACE_GRAPH_PRINT_RETVAL 0
>  
> -#define print_graph_retval(_seq, _retval, _leaf, _func, _format) do {} while (0)
> +#define print_graph_retval(_seq, _retval, _format) do {} while (0)
>  
>  #endif
>  
> @@ -741,16 +735,20 @@ print_graph_entry_leaf(struct trace_iterator *iter,
>  	/* Function */
>  	for (i = 0; i < call->depth * TRACE_GRAPH_INDENT; i++)
>  		trace_seq_putc(s, ' ');
> +	trace_seq_printf(s, "%ps", (void *)graph_ret->func);
> +	if (flags & TRACE_GRAPH_ARGS)
> +		print_function_args(s, &call->regs, graph_ret->func);

Ideally, the flag is going to be set when args is recorded and not used for
printing. If the event is the ftrace_ent_args() this will print the
arguments, otherwise it does not.

To simplify these functions, we probably need to have a:

union fgraph_entry {
	struct ftrace_graph_ent		*normal;
	struct ftrace_graph_ent_args	*args;
};

And switch depending which is which (the header of both is the same as is
for all entries).

-- Steve


> +	else
> +		trace_seq_puts(s, "();");
>  
>  	/*
>  	 * Write out the function return value if the option function-retval is
>  	 * enabled.
>  	 */
>  	if (flags & __TRACE_GRAPH_PRINT_RETVAL)
> -		print_graph_retval(s, graph_ret->retval, true, (void *)call->func,
> -				!!(flags & TRACE_GRAPH_PRINT_RETVAL_HEX));
> -	else
> -		trace_seq_printf(s, "%ps();\n", (void *)call->func);
> +		print_graph_retval(s, graph_ret->retval,
> +				   !!(flags & TRACE_GRAPH_PRINT_RETVAL_HEX));
> +	trace_seq_printf(s, "\n");
>  
>  	print_graph_irq(iter, graph_ret->func, TRACE_GRAPH_RET,
>  			cpu, iter->ent->pid, flags);
> @@ -788,7 +786,12 @@ print_graph_entry_nested(struct trace_iterator *iter,
>  	for (i = 0; i < call->depth * TRACE_GRAPH_INDENT; i++)
>  		trace_seq_putc(s, ' ');
>  
> -	trace_seq_printf(s, "%ps() {\n", (void *)call->func);
> +	trace_seq_printf(s, "%ps", (void *)call->func);
> +	if (flags & TRACE_GRAPH_ARGS)
> +		print_function_args(s, &call->regs, call->func);
> +	else
> +		trace_seq_puts(s, "()");
> +	trace_seq_printf(s, " {\n");
>  
>  	if (trace_seq_has_overflowed(s))
>  		return TRACE_TYPE_PARTIAL_LINE;
> @@ -1028,27 +1031,26 @@ print_graph_return(struct ftrace_graph_ret *trace, struct trace_seq *s,
>  	for (i = 0; i < trace->depth * TRACE_GRAPH_INDENT; i++)
>  		trace_seq_putc(s, ' ');
>  
> +	/*
> +	 * If the return function does not have a matching entry,
> +	 * then the entry was lost. Instead of just printing
> +	 * the '}' and letting the user guess what function this
> +	 * belongs to, write out the function name. Always do
> +	 * that if the funcgraph-tail option is enabled.
> +	 */
> +	if (func_match && !(flags & TRACE_GRAPH_PRINT_TAIL))
> +		trace_seq_puts(s, "}");
> +	else
> +		trace_seq_printf(s, "} /* %ps */", (void *)trace->func);
>  	/*
>  	 * Always write out the function name and its return value if the
>  	 * function-retval option is enabled.
>  	 */
>  	if (flags & __TRACE_GRAPH_PRINT_RETVAL) {
> -		print_graph_retval(s, trace->retval, false, (void *)trace->func,
> +		print_graph_retval(s, trace->retval,
>  			!!(flags & TRACE_GRAPH_PRINT_RETVAL_HEX));
> -	} else {
> -		/*
> -		 * If the return function does not have a matching entry,
> -		 * then the entry was lost. Instead of just printing
> -		 * the '}' and letting the user guess what function this
> -		 * belongs to, write out the function name. Always do
> -		 * that if the funcgraph-tail option is enabled.
> -		 */
> -		if (func_match && !(flags & TRACE_GRAPH_PRINT_TAIL))
> -			trace_seq_puts(s, "}\n");
> -		else
> -			trace_seq_printf(s, "} /* %ps */\n", (void *)trace->func);
>  	}
> -
> +	trace_seq_printf(s, "\n");
>  	/* Overrun */
>  	if (flags & TRACE_GRAPH_PRINT_OVERRUN)
>  		trace_seq_printf(s, " (Overruns: %u)\n",


