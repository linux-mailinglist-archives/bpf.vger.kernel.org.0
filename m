Return-Path: <bpf+bounces-47610-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B41C9FC5ED
	for <lists+bpf@lfdr.de>; Wed, 25 Dec 2024 16:42:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3C93163597
	for <lists+bpf@lfdr.de>; Wed, 25 Dec 2024 15:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C28718E361;
	Wed, 25 Dec 2024 15:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="osUJ3xhO"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB8B2AD2C;
	Wed, 25 Dec 2024 15:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735141318; cv=none; b=ASUnWOvL32Bei5pMSw/+Jz4sGfU5DfLY9AIPdl2rYCz/a8pulVtUFfZWeHlj8QK/hbSWlKPhdb+hdrh6TVrWlY80pCxOG2JWdYGoA6H+MWbkT1rmvbqFmvkPrQa6aI3SGj4eybfkmU2JYqBvWCGfCE+xzNY3gpPzC1HSksDdajI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735141318; c=relaxed/simple;
	bh=aOYw3ZFJxmQw04fuGTqFXGviBsSwoPK4N79grPBtUkE=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=qOELwi42ENti7RSHWCH34o0n5kdKzSQeEnnEvh13jSOJ4q+S6Bd9zaF624QgWB+uR/isdDsARGm/tsKIxcUpiOv00uYAFW2OAFpdlOgFqb2z2f0/piyCBEhgNDyrVupzrMPJU5pEGdyx0WovZ9E6tEM6fQgoe47Xz73iqoeAsPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=osUJ3xhO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07D0FC4CECD;
	Wed, 25 Dec 2024 15:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735141318;
	bh=aOYw3ZFJxmQw04fuGTqFXGviBsSwoPK4N79grPBtUkE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=osUJ3xhONMC+ypq6XENWiHc+L6X7cLZW8jCwu+PPRv3kgAC5TzosWtMR/EH4IhT1g
	 40kV6tZNC7O98HHklqwrrHdnpNcRHLvvkKPfmWED3kxPJjiYHZUxbf+tllSrbnVvlg
	 LnM6kjbvjYFqaTQqkCOsdbj1CnStWTzfN/+k13xdyjO0wcmu3G1PrBPoCEOZuEsNp0
	 wVGxRFS+f5RI3y2UWR5Qf+y8I9JAMQa9AMMs30fFTXZeSLEHy3uV8GLvgZpK0r+Da4
	 +XE52Gseka7X4sIuVcLdRUWoiXa5DIWRhQV/UedGneVtR0QNAcXuw3bVMDvMUOstn0
	 OYvYOrL7MFpRA==
Date: Thu, 26 Dec 2024 00:41:52 +0900
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
Subject: Re: [PATCH v2 2/4] ftrace: Add support for function argument to
 graph tracer
Message-Id: <20241226004152.0bddb524aed8bb0de4eeb43c@kernel.org>
In-Reply-To: <20241223201542.067076254@goodmis.org>
References: <20241223201347.609298489@goodmis.org>
	<20241223201542.067076254@goodmis.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 23 Dec 2024 15:13:49 -0500
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



> Co-developed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
> Changes since v1: https://lore.kernel.org/20240904065908.1009086-7-svens@linux.ibm.com
>  
>  - Record just FTRACE_REGS_MAX_ARGS into the ring buffer and not the
>    entire ftrace_regs structure, as that structure should be opaque
>    from generic code.
> 
>  - Make the function graph entry event have a dynamic size, so that an
>    array of arguments may be added in the ring buffer after it.
> 
>  kernel/trace/Kconfig                 |   6 ++
>  kernel/trace/trace.h                 |   1 +
>  kernel/trace/trace_entries.h         |   7 +-
>  kernel/trace/trace_functions_graph.c | 147 +++++++++++++++++++++------
>  4 files changed, 125 insertions(+), 36 deletions(-)
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
> index ad9f008d7dd7..6f67bbc17bed 100644
> --- a/kernel/trace/trace.h
> +++ b/kernel/trace/trace.h
> @@ -887,6 +887,7 @@ static __always_inline bool ftrace_hash_empty(struct ftrace_hash *hash)
>  #define TRACE_GRAPH_PRINT_RETVAL        0x800
>  #define TRACE_GRAPH_PRINT_RETVAL_HEX    0x1000
>  #define TRACE_GRAPH_PRINT_RETADDR       0x2000
> +#define TRACE_GRAPH_ARGS		0x4000
>  #define TRACE_GRAPH_PRINT_FILL_SHIFT	28
>  #define TRACE_GRAPH_PRINT_FILL_MASK	(0x3 << TRACE_GRAPH_PRINT_FILL_SHIFT)
>  
> diff --git a/kernel/trace/trace_entries.h b/kernel/trace/trace_entries.h
> index 82fd174ebbe0..254491b545c3 100644
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
> index d0e4f412c298..c8eda9bebdf4 100644
> --- a/kernel/trace/trace_functions_graph.c
> +++ b/kernel/trace/trace_functions_graph.c
> @@ -12,6 +12,8 @@
>  #include <linux/interrupt.h>
>  #include <linux/slab.h>
>  #include <linux/fs.h>
> +#include <linux/btf.h>
> +#include <linux/bpf.h>

Do we need these headers? I think it is wrapped by print_function_args().

>  
>  #include "trace.h"
>  #include "trace_output.h"
> @@ -70,6 +72,10 @@ static struct tracer_opt trace_opts[] = {
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
> @@ -110,25 +116,41 @@ static void
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
> @@ -174,9 +196,9 @@ struct fgraph_times {
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
> @@ -248,7 +270,7 @@ int trace_graph_entry(struct ftrace_graph_ent *trace,
>  
>  			ret = __trace_graph_retaddr_entry(tr, trace, trace_ctx, retaddr);
>  		} else
> -			ret = __trace_graph_entry(tr, trace, trace_ctx);
> +			ret = __graph_entry(tr, trace, trace_ctx, fregs);
>  	} else {
>  		ret = 0;
>  	}
> @@ -259,6 +281,20 @@ int trace_graph_entry(struct ftrace_graph_ent *trace,
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
> @@ -423,7 +459,10 @@ static int graph_trace_init(struct trace_array *tr)
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
> @@ -780,7 +819,7 @@ static void print_graph_retaddr(struct trace_seq *s, struct fgraph_retaddr_ent_e
>  
>  static void print_graph_retval(struct trace_seq *s, struct ftrace_graph_ent_entry *entry,
>  				struct ftrace_graph_ret *graph_ret, void *func,
> -				u32 opt_flags, u32 trace_flags)
> +				u32 opt_flags, u32 trace_flags, int args_size)
>  {
>  	unsigned long err_code = 0;
>  	unsigned long retval = 0;
> @@ -814,7 +853,14 @@ static void print_graph_retval(struct trace_seq *s, struct ftrace_graph_ent_entr
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
> @@ -836,12 +882,13 @@ static void print_graph_retval(struct trace_seq *s, struct ftrace_graph_ent_entr
>  	}
>  
>  	if (!entry || print_retval || print_retaddr)
> -		trace_seq_puts(s, " */\n");
> +		trace_seq_puts(s, " */");

Do we need this change?

Thank you,



-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

