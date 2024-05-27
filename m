Return-Path: <bpf+bounces-30624-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F3A68CF707
	for <lists+bpf@lfdr.de>; Mon, 27 May 2024 02:34:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D3B9B21356
	for <lists+bpf@lfdr.de>; Mon, 27 May 2024 00:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD5131854;
	Mon, 27 May 2024 00:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pHfEKp6V"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F54463D;
	Mon, 27 May 2024 00:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716770083; cv=none; b=ibHapLyjOHD/VMLU+gI3ifGImkJEU9tRQzjjZYQkDuuuLzj0Mj6gqHEoMCQ7wODM8dEFnH3ay/aksysBqCxV/6qFvBng0TNzSbvqjpli5mjQQLS6xkYEJcaEBMyCGFcU/8zsKystiux52eUoXJd9l37qWEJ/c+5NvtZbm8u8lfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716770083; c=relaxed/simple;
	bh=/xC6V6uAdYEa4i+hkqSsca3aTN3SHmEbZZwFAaCh6CE=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=QMbuoblbsz99V8gC4LXNZzKxxuX1ll434y2VfYZwBH2ZjdWa9S11bXpEJc11advUI6cWVl3fq3Hwi+1H488GL6mpCPDXJNRXaAGrp95GNmzO6YoQ3nk61hO28keclocghuakJgFTx/QY7L6UyoRM7+01Swqb2qa4+ZBs23cbUI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pHfEKp6V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBF2FC2BD10;
	Mon, 27 May 2024 00:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716770083;
	bh=/xC6V6uAdYEa4i+hkqSsca3aTN3SHmEbZZwFAaCh6CE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pHfEKp6VJNZ2PXnv15OKpMDq6GZSD71ed/v1+AnzqLclx3GJZuxVv6dLV7Ge7aPoA
	 mcM+9V3rAaJ5H8UMP6rpKkj6ykjXC4gyql10CG2I6KQPhkI9Wry2+dfuYwbBvtt/yQ
	 Uxqu+r2TNHQhkafwpJRRXitNycpCpJY++Q81Qo28qmCM+zSdTeiBsOrj2BLklMRann
	 ObetLabZ8HdUK5c94Rhibi0NtEO0kLZ5zmcRUA+Nukh48na9GS8LIp1TPMoKH/Zv+I
	 x1mPBiNgylCaLfjznd04165FSDoeo8WsJKILDEFYC8PIJ8foCRPqfLBw+8kY5ECkkd
	 G6eNGZb/0sYsA==
Date: Mon, 27 May 2024 09:34:36 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Masami
 Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Alexei Starovoitov
 <alexei.starovoitov@gmail.com>, Florent Revest <revest@chromium.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, bpf <bpf@vger.kernel.org>, Sven
 Schnelle <svens@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>, Jiri
 Olsa <jolsa@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Alan Maguire <alan.maguire@oracle.com>,
 Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner
 <tglx@linutronix.de>, Guo Ren <guoren@kernel.org>
Subject: Re: [PATCH 04/20] function_graph: Allow multiple users to attach to
 function graph
Message-Id: <20240527093436.7060d358a64cc2ea3213b07b@kernel.org>
In-Reply-To: <20240525023741.836661178@goodmis.org>
References: <20240525023652.903909489@goodmis.org>
	<20240525023741.836661178@goodmis.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 24 May 2024 22:36:56 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> 
> Allow for multiple users to attach to function graph tracer at the same
> time. Only 16 simultaneous users can attach to the tracer. This is because
> there's an array that stores the pointers to the attached fgraph_ops. When
> a function being traced is entered, each of the ftrace_ops entryfunc is
> called and if it returns non zero, its index into the array will be added
> to the shadow stack.
> 
> On exit of the function being traced, the shadow stack will contain the
> indexes of the ftrace_ops on the array that want their retfunc to be
> called.
> 
> Because a function may sleep for a long time (if a task sleeps itself),
> the return of the function may be literally days later. If the ftrace_ops
> is removed, its place on the array is replaced with a ftrace_ops that
> contains the stub functions and that will be called when the function
> finally returns.
> 
> If another ftrace_ops is added that happens to get the same index into the
> array, its return function may be called. But that's actually the way
> things current work with the old function graph tracer. If one tracer is
> removed and another is added, the new one will get the return calls of the
> function traced by the previous one, thus this is not a regression. This
> can be fixed by adding a counter to each time the array item is updated and
> save that on the shadow stack as well, such that it won't be called if the
> index saved does not match the index on the array.
> 
> Note, being able to filter functions when both are called is not completely
> handled yet, but that shouldn't be too hard to manage.
> 
> Co-developed with Masami Hiramatsu:
> Link: https://lore.kernel.org/linux-trace-kernel/171509096221.162236.8806372072523195752.stgit@devnote2
> 

Thanks for update this. I have some comments below.

> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
[...]

> @@ -110,11 +253,13 @@ void ftrace_graph_stop(void)
>  /* Add a function return address to the trace stack on thread info.*/
>  static int
>  ftrace_push_return_trace(unsigned long ret, unsigned long func,
> -			 unsigned long frame_pointer, unsigned long *retp)
> +			 unsigned long frame_pointer, unsigned long *retp,
> +			 int fgraph_idx)

We do not need this fgraph_idx parameter anymore because this removed
reuse-frame check.

>  {
>  	struct ftrace_ret_stack *ret_stack;
>  	unsigned long long calltime;
> -	int index;
> +	unsigned long val;
> +	int offset;
>  
>  	if (unlikely(ftrace_graph_is_dead()))
>  		return -EBUSY;
> @@ -124,24 +269,57 @@ ftrace_push_return_trace(unsigned long ret, unsigned long func,
>  
>  	BUILD_BUG_ON(SHADOW_STACK_SIZE % sizeof(long));
>  
> +	/* Set val to "reserved" with the delta to the new fgraph frame */
> +	val = (FGRAPH_TYPE_RESERVED << FGRAPH_TYPE_SHIFT) | FGRAPH_FRAME_OFFSET;
> +
>  	/*
>  	 * We must make sure the ret_stack is tested before we read
>  	 * anything else.
>  	 */
>  	smp_rmb();
>  
> -	/* The return trace stack is full */
> -	if (current->curr_ret_stack >= SHADOW_STACK_MAX_INDEX) {
> +	/*
> +	 * Check if there's room on the shadow stack to fit a fraph frame
> +	 * and a bitmap word.
> +	 */
> +	if (current->curr_ret_stack + FGRAPH_FRAME_OFFSET + 1 >= SHADOW_STACK_MAX_OFFSET) {
>  		atomic_inc(&current->trace_overrun);
>  		return -EBUSY;
>  	}
>  
>  	calltime = trace_clock_local();
>  
> -	index = current->curr_ret_stack;
> -	RET_STACK_INC(current->curr_ret_stack);
> -	ret_stack = RET_STACK(current, index);
> +	offset = READ_ONCE(current->curr_ret_stack);
> +	ret_stack = RET_STACK(current, offset);
> +	offset += FGRAPH_FRAME_OFFSET;
> +
> +	/* ret offset = FGRAPH_FRAME_OFFSET ; type = reserved */
> +	current->ret_stack[offset] = val;
> +	ret_stack->ret = ret;
> +	/*
> +	 * The unwinders expect curr_ret_stack to point to either zero
> +	 * or an offset where to find the next ret_stack. Even though the
> +	 * ret stack might be bogus, we want to write the ret and the
> +	 * offset to find the ret_stack before we increment the stack point.
> +	 * If an interrupt comes in now before we increment the curr_ret_stack
> +	 * it may blow away what we wrote. But that's fine, because the
> +	 * offset will still be correct (even though the 'ret' won't be).
> +	 * What we worry about is the offset being correct after we increment
> +	 * the curr_ret_stack and before we update that offset, as if an
> +	 * interrupt comes in and does an unwind stack dump, it will need
> +	 * at least a correct offset!
> +	 */
>  	barrier();
> +	WRITE_ONCE(current->curr_ret_stack, offset + 1);
> +	/*
> +	 * This next barrier is to ensure that an interrupt coming in
> +	 * will not corrupt what we are about to write.
> +	 */
> +	barrier();
> +
> +	/* Still keep it reserved even if an interrupt came in */
> +	current->ret_stack[offset] = val;
> +
>  	ret_stack->ret = ret;
>  	ret_stack->func = func;
>  	ret_stack->calltime = calltime;
> @@ -151,7 +329,7 @@ ftrace_push_return_trace(unsigned long ret, unsigned long func,
>  #ifdef HAVE_FUNCTION_GRAPH_RET_ADDR_PTR
>  	ret_stack->retp = retp;
>  #endif
> -	return 0;
> +	return offset;
>  }
>  
>  /*
> @@ -168,49 +346,67 @@ ftrace_push_return_trace(unsigned long ret, unsigned long func,
>  # define MCOUNT_INSN_SIZE 0
>  #endif
>  
> +/* If the caller does not use ftrace, call this function. */
>  int function_graph_enter(unsigned long ret, unsigned long func,
>  			 unsigned long frame_pointer, unsigned long *retp)
>  {
>  	struct ftrace_graph_ent trace;
> +	unsigned long bitmap = 0;
> +	int offset;
> +	int i;
>  
>  	trace.func = func;
>  	trace.depth = ++current->curr_ret_depth;
>  
> -	if (ftrace_push_return_trace(ret, func, frame_pointer, retp))
> +	offset = ftrace_push_return_trace(ret, func, frame_pointer, retp, 0);
> +	if (offset < 0)
>  		goto out;
>  
> -	/* Only trace if the calling function expects to */
> -	if (!fgraph_array[0]->entryfunc(&trace))
> +	for (i = 0; i < fgraph_array_cnt; i++) {
> +		struct fgraph_ops *gops = fgraph_array[i];
> +
> +		if (gops == &fgraph_stub)
> +			continue;
> +
> +		if (gops->entryfunc(&trace))
> +			bitmap |= BIT(i);
> +	}
> +
> +	if (!bitmap)
>  		goto out_ret;
>  
> +	/*
> +	 * Since this function uses fgraph_idx = 0 as a tail-call checking
> +	 * flag, set that bit always.
> +	 */

This comment is also out-of-date.

> +	set_bitmap(current, offset, bitmap | BIT(0));

And we do not need to set BIT(0) anymore.

> +
>  	return 0;
>   out_ret:
> -	RET_STACK_DEC(current->curr_ret_stack);
> +	current->curr_ret_stack -= FGRAPH_FRAME_OFFSET + 1;
>   out:
>  	current->curr_ret_depth--;
>  	return -EBUSY;
>  }
>  
>  /* Retrieve a function return address to the trace stack on thread info.*/
> -static void
> +static struct ftrace_ret_stack *
>  ftrace_pop_return_trace(struct ftrace_graph_ret *trace, unsigned long *ret,
> -			unsigned long frame_pointer)
> +			unsigned long frame_pointer, int *offset)
>  {
>  	struct ftrace_ret_stack *ret_stack;
> -	int index;
>  
> -	index = current->curr_ret_stack;
> -	RET_STACK_DEC(index);
> +	ret_stack = get_ret_stack(current, current->curr_ret_stack, offset);
>  
> -	if (unlikely(index < 0 || index > SHADOW_STACK_MAX_INDEX)) {
> +	if (unlikely(!ret_stack)) {
>  		ftrace_graph_stop();
> -		WARN_ON(1);
> +		WARN(1, "Bad function graph ret_stack pointer: %d",
> +		     current->curr_ret_stack);
>  		/* Might as well panic, otherwise we have no where to go */
>  		*ret = (unsigned long)panic;
> -		return;
> +		return NULL;
>  	}
>  
> -	ret_stack = RET_STACK(current, index);
>  #ifdef HAVE_FUNCTION_GRAPH_FP_TEST
>  	/*
>  	 * The arch may choose to record the frame pointer used
> @@ -230,26 +426,29 @@ ftrace_pop_return_trace(struct ftrace_graph_ret *trace, unsigned long *ret,
>  		ftrace_graph_stop();
>  		WARN(1, "Bad frame pointer: expected %lx, received %lx\n"
>  		     "  from func %ps return to %lx\n",
> -		     current->ret_stack[index].fp,
> +		     ret_stack->fp,
>  		     frame_pointer,
>  		     (void *)ret_stack->func,
>  		     ret_stack->ret);
>  		*ret = (unsigned long)panic;
> -		return;
> +		return NULL;
>  	}
>  #endif
>  
> +	*offset += FGRAPH_FRAME_OFFSET;
>  	*ret = ret_stack->ret;
>  	trace->func = ret_stack->func;
>  	trace->calltime = ret_stack->calltime;
>  	trace->overrun = atomic_read(&current->trace_overrun);
> -	trace->depth = current->curr_ret_depth--;
> +	trace->depth = current->curr_ret_depth;
>  	/*
>  	 * We still want to trace interrupts coming in if
>  	 * max_depth is set to 1. Make sure the decrement is
>  	 * seen before ftrace_graph_return.
>  	 */
>  	barrier();
> +
> +	return ret_stack;
>  }
>  
>  /*
> @@ -287,30 +486,47 @@ struct fgraph_ret_regs;
>  static unsigned long __ftrace_return_to_handler(struct fgraph_ret_regs *ret_regs,
>  						unsigned long frame_pointer)
>  {
> +	struct ftrace_ret_stack *ret_stack;
>  	struct ftrace_graph_ret trace;
> +	unsigned long bitmap;
>  	unsigned long ret;
> +	int offset;
> +	int i;
> +
> +	ret_stack = ftrace_pop_return_trace(&trace, &ret, frame_pointer, &offset);
> +
> +	if (unlikely(!ret_stack)) {
> +		ftrace_graph_stop();
> +		WARN_ON(1);
> +		/* Might as well panic. What else to do? */
> +		return (unsigned long)panic;
> +	}
>  
> -	ftrace_pop_return_trace(&trace, &ret, frame_pointer);
> +	trace.rettime = trace_clock_local();
>  #ifdef CONFIG_FUNCTION_GRAPH_RETVAL
>  	trace.retval = fgraph_ret_regs_return_value(ret_regs);
>  #endif
> -	trace.rettime = trace_clock_local();
> -	fgraph_array[0]->retfunc(&trace);
> +
> +	bitmap = get_bitmap_bits(current, offset);
> +	for (i = 0; i < FGRAPH_ARRAY_SIZE; i++) {
> +		struct fgraph_ops *gops = fgraph_array[i];
> +
> +		if (!(bitmap & BIT(i)))
> +			continue;
> +		if (gops == &fgraph_stub)

nit: here, we can make this check unlikely() because the above
bitmap check already filtered. (Some sleepable functions leave
the return frame on shadow stack after gops is unregistered. But it
also rare compared with living time.)


Thank you,



-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

