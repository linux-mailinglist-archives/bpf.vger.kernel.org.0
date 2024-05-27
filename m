Return-Path: <bpf+bounces-30627-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CEED18CF73D
	for <lists+bpf@lfdr.de>; Mon, 27 May 2024 03:16:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 477221F21C82
	for <lists+bpf@lfdr.de>; Mon, 27 May 2024 01:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B23781FBA;
	Mon, 27 May 2024 01:16:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 642C038C;
	Mon, 27 May 2024 01:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716772590; cv=none; b=ZRqYFAlwl0+GtTa3jJUtIBUGA2nplMz7RVFi/FmnSY11EvIjRXS42THK5jmzbxKOo5eiCMG6viApPGcI1xG45m23/lgoLBFwU/eWtx+IahqOhbMQfq3gRM8+/RGV2j4ZM5AYTU7oc+FXcKOUzkawf46ozCS+osLEf2JJEBrD89g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716772590; c=relaxed/simple;
	bh=hgb0zfnLV7BoxmFrRxX+n/XHKuKXwMbq4hFC46FTxtc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YmEKI64PTyMaqduvJwWyWcfoKSAq2UCHzx+hw3BbS8ui+2h1XI5M+ytrv10NbnwJ3TZ8WFDYxHTpnUE3oUvalum0iE/cGOyoqePkHXNTTClhLIXca5ofJ5wVIaXD5n4t6LtHrn11sLaw+qjCh+keiJXHaoeARoGc+m3JY44Zx88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8F26C2BD10;
	Mon, 27 May 2024 01:16:27 +0000 (UTC)
Date: Sun, 26 May 2024 21:17:19 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Mark
 Rutland <mark.rutland@arm.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Morton
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
Message-ID: <20240526211719.0c4c2835@gandalf.local.home>
In-Reply-To: <20240527093436.7060d358a64cc2ea3213b07b@kernel.org>
References: <20240525023652.903909489@goodmis.org>
	<20240525023741.836661178@goodmis.org>
	<20240527093436.7060d358a64cc2ea3213b07b@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 27 May 2024 09:34:36 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> > @@ -110,11 +253,13 @@ void ftrace_graph_stop(void)
> >  /* Add a function return address to the trace stack on thread info.*/
> >  static int
> >  ftrace_push_return_trace(unsigned long ret, unsigned long func,
> > -			 unsigned long frame_pointer, unsigned long *retp)
> > +			 unsigned long frame_pointer, unsigned long *retp,
> > +			 int fgraph_idx)  
> 
> We do not need this fgraph_idx parameter anymore because this removed
> reuse-frame check.

Agreed. Will remove.

> 
> >  {
> >  	struct ftrace_ret_stack *ret_stack;
> >  	unsigned long long calltime;
> > -	int index;
> > +	unsigned long val;
> > +	int offset;
> >  
> >  	if (unlikely(ftrace_graph_is_dead()))
> >  		return -EBUSY;
> > @@ -124,24 +269,57 @@ ftrace_push_return_trace(unsigned long ret, unsigned long func,
> >  
> >  	BUILD_BUG_ON(SHADOW_STACK_SIZE % sizeof(long));
> >  
> > +	/* Set val to "reserved" with the delta to the new fgraph frame */
> > +	val = (FGRAPH_TYPE_RESERVED << FGRAPH_TYPE_SHIFT) | FGRAPH_FRAME_OFFSET;
> > +
> >  	/*
> >  	 * We must make sure the ret_stack is tested before we read
> >  	 * anything else.
> >  	 */
> >  	smp_rmb();
> >  
> > -	/* The return trace stack is full */
> > -	if (current->curr_ret_stack >= SHADOW_STACK_MAX_INDEX) {
> > +	/*
> > +	 * Check if there's room on the shadow stack to fit a fraph frame
> > +	 * and a bitmap word.
> > +	 */
> > +	if (current->curr_ret_stack + FGRAPH_FRAME_OFFSET + 1 >= SHADOW_STACK_MAX_OFFSET) {
> >  		atomic_inc(&current->trace_overrun);
> >  		return -EBUSY;
> >  	}
> >  
> >  	calltime = trace_clock_local();
> >  
> > -	index = current->curr_ret_stack;
> > -	RET_STACK_INC(current->curr_ret_stack);
> > -	ret_stack = RET_STACK(current, index);
> > +	offset = READ_ONCE(current->curr_ret_stack);
> > +	ret_stack = RET_STACK(current, offset);
> > +	offset += FGRAPH_FRAME_OFFSET;
> > +
> > +	/* ret offset = FGRAPH_FRAME_OFFSET ; type = reserved */
> > +	current->ret_stack[offset] = val;
> > +	ret_stack->ret = ret;
> > +	/*
> > +	 * The unwinders expect curr_ret_stack to point to either zero
> > +	 * or an offset where to find the next ret_stack. Even though the
> > +	 * ret stack might be bogus, we want to write the ret and the
> > +	 * offset to find the ret_stack before we increment the stack point.
> > +	 * If an interrupt comes in now before we increment the curr_ret_stack
> > +	 * it may blow away what we wrote. But that's fine, because the
> > +	 * offset will still be correct (even though the 'ret' won't be).
> > +	 * What we worry about is the offset being correct after we increment
> > +	 * the curr_ret_stack and before we update that offset, as if an
> > +	 * interrupt comes in and does an unwind stack dump, it will need
> > +	 * at least a correct offset!
> > +	 */
> >  	barrier();
> > +	WRITE_ONCE(current->curr_ret_stack, offset + 1);
> > +	/*
> > +	 * This next barrier is to ensure that an interrupt coming in
> > +	 * will not corrupt what we are about to write.
> > +	 */
> > +	barrier();
> > +
> > +	/* Still keep it reserved even if an interrupt came in */
> > +	current->ret_stack[offset] = val;
> > +
> >  	ret_stack->ret = ret;
> >  	ret_stack->func = func;
> >  	ret_stack->calltime = calltime;
> > @@ -151,7 +329,7 @@ ftrace_push_return_trace(unsigned long ret, unsigned long func,
> >  #ifdef HAVE_FUNCTION_GRAPH_RET_ADDR_PTR
> >  	ret_stack->retp = retp;
> >  #endif
> > -	return 0;
> > +	return offset;
> >  }
> >  
> >  /*
> > @@ -168,49 +346,67 @@ ftrace_push_return_trace(unsigned long ret, unsigned long func,
> >  # define MCOUNT_INSN_SIZE 0
> >  #endif
> >  
> > +/* If the caller does not use ftrace, call this function. */
> >  int function_graph_enter(unsigned long ret, unsigned long func,
> >  			 unsigned long frame_pointer, unsigned long *retp)
> >  {
> >  	struct ftrace_graph_ent trace;
> > +	unsigned long bitmap = 0;
> > +	int offset;
> > +	int i;
> >  
> >  	trace.func = func;
> >  	trace.depth = ++current->curr_ret_depth;
> >  
> > -	if (ftrace_push_return_trace(ret, func, frame_pointer, retp))
> > +	offset = ftrace_push_return_trace(ret, func, frame_pointer, retp, 0);
> > +	if (offset < 0)
> >  		goto out;
> >  
> > -	/* Only trace if the calling function expects to */
> > -	if (!fgraph_array[0]->entryfunc(&trace))
> > +	for (i = 0; i < fgraph_array_cnt; i++) {
> > +		struct fgraph_ops *gops = fgraph_array[i];
> > +
> > +		if (gops == &fgraph_stub)
> > +			continue;
> > +
> > +		if (gops->entryfunc(&trace))
> > +			bitmap |= BIT(i);
> > +	}
> > +
> > +	if (!bitmap)
> >  		goto out_ret;
> >  
> > +	/*
> > +	 * Since this function uses fgraph_idx = 0 as a tail-call checking
> > +	 * flag, set that bit always.
> > +	 */  
> 
> This comment is also out-of-date.
> 
> > +	set_bitmap(current, offset, bitmap | BIT(0));  
> 
> And we do not need to set BIT(0) anymore.

Right. When looking at your first comment, I did a search for fgraph_idx
and noticed this code, and realized it should be removed too. And of
course, you noticed it too ;-)


> 
> > +
> >  	return 0;
> >   out_ret:
> > -	RET_STACK_DEC(current->curr_ret_stack);
> > +	current->curr_ret_stack -= FGRAPH_FRAME_OFFSET + 1;
> >   out:
> >  	current->curr_ret_depth--;
> >  	return -EBUSY;
> >  }
> >  
> >  /* Retrieve a function return address to the trace stack on thread info.*/
> > -static void
> > +static struct ftrace_ret_stack *
> >  ftrace_pop_return_trace(struct ftrace_graph_ret *trace, unsigned long *ret,
> > -			unsigned long frame_pointer)
> > +			unsigned long frame_pointer, int *offset)
> >  {
> >  	struct ftrace_ret_stack *ret_stack;
> > -	int index;
> >  
> > -	index = current->curr_ret_stack;
> > -	RET_STACK_DEC(index);
> > +	ret_stack = get_ret_stack(current, current->curr_ret_stack, offset);
> >  
> > -	if (unlikely(index < 0 || index > SHADOW_STACK_MAX_INDEX)) {
> > +	if (unlikely(!ret_stack)) {
> >  		ftrace_graph_stop();
> > -		WARN_ON(1);
> > +		WARN(1, "Bad function graph ret_stack pointer: %d",
> > +		     current->curr_ret_stack);
> >  		/* Might as well panic, otherwise we have no where to go */
> >  		*ret = (unsigned long)panic;
> > -		return;
> > +		return NULL;
> >  	}
> >  
> > -	ret_stack = RET_STACK(current, index);
> >  #ifdef HAVE_FUNCTION_GRAPH_FP_TEST
> >  	/*
> >  	 * The arch may choose to record the frame pointer used
> > @@ -230,26 +426,29 @@ ftrace_pop_return_trace(struct ftrace_graph_ret *trace, unsigned long *ret,
> >  		ftrace_graph_stop();
> >  		WARN(1, "Bad frame pointer: expected %lx, received %lx\n"
> >  		     "  from func %ps return to %lx\n",
> > -		     current->ret_stack[index].fp,
> > +		     ret_stack->fp,
> >  		     frame_pointer,
> >  		     (void *)ret_stack->func,
> >  		     ret_stack->ret);
> >  		*ret = (unsigned long)panic;
> > -		return;
> > +		return NULL;
> >  	}
> >  #endif
> >  
> > +	*offset += FGRAPH_FRAME_OFFSET;
> >  	*ret = ret_stack->ret;
> >  	trace->func = ret_stack->func;
> >  	trace->calltime = ret_stack->calltime;
> >  	trace->overrun = atomic_read(&current->trace_overrun);
> > -	trace->depth = current->curr_ret_depth--;
> > +	trace->depth = current->curr_ret_depth;
> >  	/*
> >  	 * We still want to trace interrupts coming in if
> >  	 * max_depth is set to 1. Make sure the decrement is
> >  	 * seen before ftrace_graph_return.
> >  	 */
> >  	barrier();
> > +
> > +	return ret_stack;
> >  }
> >  
> >  /*
> > @@ -287,30 +486,47 @@ struct fgraph_ret_regs;
> >  static unsigned long __ftrace_return_to_handler(struct fgraph_ret_regs *ret_regs,
> >  						unsigned long frame_pointer)
> >  {
> > +	struct ftrace_ret_stack *ret_stack;
> >  	struct ftrace_graph_ret trace;
> > +	unsigned long bitmap;
> >  	unsigned long ret;
> > +	int offset;
> > +	int i;
> > +
> > +	ret_stack = ftrace_pop_return_trace(&trace, &ret, frame_pointer, &offset);
> > +
> > +	if (unlikely(!ret_stack)) {
> > +		ftrace_graph_stop();
> > +		WARN_ON(1);
> > +		/* Might as well panic. What else to do? */
> > +		return (unsigned long)panic;
> > +	}
> >  
> > -	ftrace_pop_return_trace(&trace, &ret, frame_pointer);
> > +	trace.rettime = trace_clock_local();
> >  #ifdef CONFIG_FUNCTION_GRAPH_RETVAL
> >  	trace.retval = fgraph_ret_regs_return_value(ret_regs);
> >  #endif
> > -	trace.rettime = trace_clock_local();
> > -	fgraph_array[0]->retfunc(&trace);
> > +
> > +	bitmap = get_bitmap_bits(current, offset);
> > +	for (i = 0; i < FGRAPH_ARRAY_SIZE; i++) {
> > +		struct fgraph_ops *gops = fgraph_array[i];
> > +
> > +		if (!(bitmap & BIT(i)))
> > +			continue;
> > +		if (gops == &fgraph_stub)  
> 
> nit: here, we can make this check unlikely() because the above
> bitmap check already filtered. (Some sleepable functions leave
> the return frame on shadow stack after gops is unregistered. But it
> also rare compared with living time.)

Sure.

Thanks for the review.

-- Steve


