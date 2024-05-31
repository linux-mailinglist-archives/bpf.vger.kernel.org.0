Return-Path: <bpf+bounces-31036-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B74948D64DF
	for <lists+bpf@lfdr.de>; Fri, 31 May 2024 16:52:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD026B2B250
	for <lists+bpf@lfdr.de>; Fri, 31 May 2024 14:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B352558B9;
	Fri, 31 May 2024 14:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="noplJiD1"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F7BA6F2EB;
	Fri, 31 May 2024 14:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717167029; cv=none; b=lG3Jm3bZ6bi6R4Qm0iiCmZ2ZCdVwSmP/DZxd9XikJ67P9w6h3FmQfg+LEWu50iZCAxlsNJExEzuFlqsa4NpdWAhvz3SRX8ADJzwWjg4RINznhDfg+EaUOx4jX6nOsaQAW3bO1nz5h3jtTDBK5vC7Im8iJYirKbeiQqJicJTuGFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717167029; c=relaxed/simple;
	bh=SoFBpNqzbtb+5DiL1b3Xa2w1zfCNY7f9atKzwbTKab0=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=mgtLhNLpGBNxB0PdvpSJVn6YhLj5vWiSO0mVibDA0BjTFJUYDN5XMc2AMH4aNMqu5GtEaPk+UoSePUOjmPT8AvjaD6P+8dFU/rQGK9IfwgVRuWct/TAynJ34M6r8eCTOYkpwuCAmdxreu1w0/ZggXqcp5pFZ3acRDHChi5rXDlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=noplJiD1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 957B3C116B1;
	Fri, 31 May 2024 14:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717167029;
	bh=SoFBpNqzbtb+5DiL1b3Xa2w1zfCNY7f9atKzwbTKab0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=noplJiD1JNJetlnp2zOzi5qcDqbPSkw74sQoxNmQDAo2MshMOAQqpSJOyJukYUFwu
	 pwQJJq6CtfBr+2nfEO6WfL7DkO9SxDJJRv/jptWw7CLxLEeREj3cZ0CVsls45I9ImK
	 xyu2/Kj/sYtgRi8jlfTebsYG+ZD67Og5DLr5fBRYvfQt1aEw0gq2PSAR1YD5noFp/t
	 Qi63eq1BK8bhuN6L8jX0ES01kBlVLvMPQD6YnPWRq6znArglYSKhk1JYrjoqH1nMmQ
	 pV/ayB5yUs89kLcAwko7vUXIVSZAlGg+ilAWUpFxwuhV7NktlDepEd6vNX989fSoTH
	 yDvcsaNaLV9eA==
Date: Fri, 31 May 2024 23:50:23 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
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
Subject: Re: [PATCH 10/20] function_graph: Have the instances use their own
 ftrace_ops for filtering
Message-Id: <20240531235023.a0b2b207362eba2f8b5c16f7@kernel.org>
In-Reply-To: <20240531020346.6c13e2d4@rorschach.local.home>
References: <20240525023652.903909489@goodmis.org>
	<20240525023742.786834257@goodmis.org>
	<20240530223057.21c2a779@rorschach.local.home>
	<20240531121241.c586189caad8d31d597f614d@kernel.org>
	<20240531020346.6c13e2d4@rorschach.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 31 May 2024 02:03:46 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Fri, 31 May 2024 12:12:41 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> 
> > On Thu, 30 May 2024 22:30:57 -0400
> > Steven Rostedt <rostedt@goodmis.org> wrote:
> > 
> > > On Fri, 24 May 2024 22:37:02 -0400
> > > Steven Rostedt <rostedt@goodmis.org> wrote:
> > >   
> > > > From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> > > > 
> > > > Allow for instances to have their own ftrace_ops part of the fgraph_ops
> > > > that makes the funtion_graph tracer filter on the set_ftrace_filter file
> > > > of the instance and not the top instance.
> > > > 
> > > > Note that this also requires to update ftrace_graph_func() to call new
> > > > function_graph_enter_ops() instead of function_graph_enter() so that
> > > > it avoid pushing on shadow stack multiple times on the same function.  
> > > 
> > > So I found a major design flaw in this patch.
> > >   
> > > > 
> > > > Co-developed with Masami Hiramatsu:
> > > > Link: https://lore.kernel.org/linux-trace-kernel/171509102088.162236.15758883237657317789.stgit@devnote2
> > > > 
> > > > Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> > > > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > > > Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> > > > ---  
> > >   
> > > > diff --git a/arch/x86/kernel/ftrace.c b/arch/x86/kernel/ftrace.c
> > > > index 8da0e66ca22d..998558cb8f15 100644
> > > > --- a/arch/x86/kernel/ftrace.c
> > > > +++ b/arch/x86/kernel/ftrace.c
> > > > @@ -648,9 +648,24 @@ void ftrace_graph_func(unsigned long ip, unsigned long parent_ip,
> > > >  		       struct ftrace_ops *op, struct ftrace_regs *fregs)
> > > >  {
> > > >  	struct pt_regs *regs = &fregs->regs;
> > > > -	unsigned long *stack = (unsigned long *)kernel_stack_pointer(regs);
> > > > +	unsigned long *parent = (unsigned long *)kernel_stack_pointer(regs);
> > > > +	struct fgraph_ops *gops = container_of(op, struct fgraph_ops, ops);
> > > > +	int bit;
> > > > +
> > > > +	if (unlikely(ftrace_graph_is_dead()))
> > > > +		return;
> > > > +
> > > > +	if (unlikely(atomic_read(&current->tracing_graph_pause)))
> > > > +		return;
> > > >  
> > > > -	prepare_ftrace_return(ip, (unsigned long *)stack, 0);
> > > > +	bit = ftrace_test_recursion_trylock(ip, *parent);
> > > > +	if (bit < 0)
> > > > +		return;
> > > > +
> > > > +	if (!function_graph_enter_ops(*parent, ip, 0, parent, gops))  
> > > 
> > > So each registered graph ops has its own ftrace_ops which gets
> > > registered with ftrace, so this function does get called in a loop (by
> > > the ftrace iterator function). This means that we would need that code
> > > to detect the function_graph_enter_ops() getting called multiple times
> > > for the same function. This means each fgraph_ops gits its own retstack
> > > on the shadow stack.  
> > 
> > Ah, that is my concern and the reason why I added bitmap and stack reuse
> > code in the ftrace_push_return_trace().
> > 
> > > 
> > > I find this a waste of shadow stack resources, and also complicates the
> > > code with having to deal with tail calls and all that.
> > > 
> > > BUT! There's good news! I also thought about another way of handling
> > > this. I have something working, but requires a bit of rewriting the
> > > code. I should have something out in a day or two.  
> > 
> > Hmm, I just wonder why you don't reocver my bitmap check and stack
> > reusing code. Are there any problem on it? (Too complicated?)
> > 
> 
> I actually dislike the use of ftrace itself to do the loop. I rather
> have fgraph be in control of it.

(actually, I agreed with you, looping in ftrace may cause trouble)

> 
> I've come up with a new "subops" assignment, where you can have one
> ftrace_ops represent multiple sub ftrace_ops. Basically, each fgraph
> ops can register its own ftrace_ops under a single graph_ops
> ftrace_ops. The graph_ops will be used to decide what functions call
> the callback, and then the callback does the multiplexing.

So is it similar to the fprobe/kprobe, use shared signle ftrace_ops,
but keep each fgraph has own hash table?

> This removes the need to touch the architecture code. It can also be
> used by fprobes to handle the attachments to functions for several
> different sets of callbacks.
> 
> I'll send out patches soon.

OK, I'll wait for that.

Thank you!

> 
> -- Steve
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

