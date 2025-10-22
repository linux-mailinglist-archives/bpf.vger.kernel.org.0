Return-Path: <bpf+bounces-71853-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9F90BFE44C
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 23:17:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 825E33A7A49
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 21:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 245042798FA;
	Wed, 22 Oct 2025 21:17:00 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 674C39463;
	Wed, 22 Oct 2025 21:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761167819; cv=none; b=PqfR+2Z7D/RiH7KNqWryo/chEge9GNlSufmsK+CuZa9Cn81SuQB5sno1WxsRh0L0A7ACHBXwuUSFiMVNu9QhgN+Hf80lpMjgVc1OanKiFPOffBOniXAe1/kOywhZAsLrhpeT6K9iOYZgU8pRXo6E5XAE140hvaktT3LdzEg7oC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761167819; c=relaxed/simple;
	bh=/Yh6+9oLE8uSTSThzikMCf+rnr7EALaT5ZiI8nXKrj0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SXvh5CvC+kBYhxSuC25Rc6hFZSBoekWGrIphq/pKjwL7m7YB5ikn/vh/IM2AQLb+hjpQPlfOxexDrcZ7ZHT6pBfXeIy9A8KfO2K7vTSyyIWN1NC2SetQZiGMYGqYb0G/TYLYM/8LlNqFK6AUdJqYLrPYIbCA/ffwz2nZWSdYvYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf09.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id 1305513BD1E;
	Wed, 22 Oct 2025 21:16:49 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf09.hostedemail.com (Postfix) with ESMTPA id D3C7220028;
	Wed, 22 Oct 2025 21:16:46 +0000 (UTC)
Date: Wed, 22 Oct 2025 17:17:11 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Feng Yang <yangfeng59949@163.com>, andrii@kernel.org,
 bpf@vger.kernel.org, jpoimboe@kernel.org,
 linux-trace-kernel@vger.kernel.org, mhiramat@kernel.org,
 peterz@infradead.org, x86@kernel.org, yhs@fb.com
Subject: Re: [BUG] no ORC stacktrace from kretprobe.multi bpf program
Message-ID: <20251022171711.5c18f043@gandalf.local.home>
In-Reply-To: <aPlBcKq7S-bD3B56@krava>
References: <20251015121138.4190d046@gandalf.local.home>
	<20251022090429.136755-1-yangfeng59949@163.com>
	<aPjO0yLCxPbUJP9r@krava>
	<20251022102819.7675ee7a@gandalf.local.home>
	<aPlBcKq7S-bD3B56@krava>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: D3C7220028
X-Stat-Signature: 5tad4r8wmxqhxpormusw64mpxidi7t3j
X-Rspamd-Server: rspamout02
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+4fBjaojyP9yMLdqQJMWHbcoQ6KaMJu58=
X-HE-Tag: 1761167806-478715
X-HE-Meta: U2FsdGVkX19rL+kxtbxt7dxNmIT4It9iiuGPL4U0huZkGoK1nmdhVIqnRG2+YSFPE7H4J5pbxLlcR8my9iW4V1wkgzTbk7kV/XSe+40Urzd9ro+JrLleSIpsFkLZSh4m+zS8f0iJcj1agjOuIiRudv+zw+FtHokM3fo5QwjolAVmloh5XY09oMosN3Xy/zfvbBp/g9285p67PK/8CPZ5zMxtTzOTNGSQiGpPp2IsLQP+LBYql/hXaxoN2FS8EDnjxTyIX7jjAZMUAUQxAdOb6lWFxtwXwq6HGg+fvHKVWdP3WnMCRDjFeNL4Wph7TKxnH3lWhCLtQlQ9rSM34l+nFHUZSQ/NDVee

On Wed, 22 Oct 2025 22:41:20 +0200
Jiri Olsa <olsajiri@gmail.com> wrote:

> >   
> > >  	ANNOTATE_NOENDBR
> > > +	push $return_to_handler
> > > +	UNWIND_HINT_FUNC  
> > 
> > OK, so what happened here is that you put in the return_to_handle into the
> > stack and told ORC that this is a normal function, and that when it
> > triggers to do a lookup from the handler itself.  
> 
> together with the "push $return_to_handler" it suppose to instruct ftrace_graph_ret_addr
> to go get the 'real' return address from shadow stack
> 
> > 
> > I wonder if we could just add a new UNWIND_HINT that tells ORC to do that?  
> 
> if I remove the initial UNWIND_HINT_UNDEFINED I get objtool warning
> about unreachable instruction

Right. I was thinking we add UNWIND_HINT_RETHOOK and an
UNWIND_HINT_TYPE_RETHOOK that lets objtool know that this function is a
"return_to_hook" function and the unwinder can do something special with it.

> 
> >   
> > >  
> > >  	/* Save ftrace_regs for function exit context  */
> > >  	subq $(FRAME_SIZE), %rsp
> > > @@ -360,6 +362,9 @@ SYM_CODE_START(return_to_handler)
> > >  	movq %rax, RAX(%rsp)
> > >  	movq %rdx, RDX(%rsp)
> > >  	movq %rbp, RBP(%rsp)
> > > +	movq %rsp, RSP(%rsp)
> > > +	movq $0, EFLAGS(%rsp)
> > > +	movq $__KERNEL_CS, CS(%rsp)  
> > 
> > Is this simulating some kind of interrupt?  
> 
> there are several checks in pt_regs on these fields 
> 
> - in get_perf_callchain we check user_mode(regs) so CS has to be set
> - in perf_callchain_kernel we call perf_hw_regs(regs), so EFLAGS has to be set

So this is a different issue. I rather have this added in
kprobe_multi_link_prog_run as its the only user of it. Or have the
ftrace_regs conversion update it. This isn't something that should be done
at every call and slow everyone else down.

> 
> >   
> > >  	movq %rsp, %rdi
> > >  
> > >  	call ftrace_return_to_handler  
> > 
> > Now it gets tricky in the ftrace_return_to_handler as the first thing it
> > does is to pop the shadow stack, which makes the return_to_handler lookup
> > different, as its no longer on the stack that the unwinder will use.  
> 
> hum strange.. the resulting stack trace seems ok, I'll make it a
> selftest I send it
> 
> ftrace_graph_ret_addr that checks on the 'real return address seems
> to have 2 ways of getting to it:
> 
>         i = *idx ? : task->curr_ret_stack;
> 
> I dont know how that previous pop affects this, but I'm sure it's
> more complicated than this ;-)

Oh wait, it may be OK. I forgot I had to change the pop function to give
the data back, but it doesn't modify the task->curr_ret_stack until after
it calls all the callbacks. That's because the shadow stack still has the
data that is being passed from the entry callback. So it can't be updated
yet otherwise that data on the shadow stack will get corrupted.

Yeah, the return_to_handler should work up until the end of
ftrace_return_to_handler().

-- Steve


