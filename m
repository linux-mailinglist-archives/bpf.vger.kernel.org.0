Return-Path: <bpf+bounces-30995-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 996BA8D58EC
	for <lists+bpf@lfdr.de>; Fri, 31 May 2024 05:12:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5660C287B08
	for <lists+bpf@lfdr.de>; Fri, 31 May 2024 03:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 004852110F;
	Fri, 31 May 2024 03:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b8rEi16g"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793F078C75;
	Fri, 31 May 2024 03:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717125168; cv=none; b=thwas17T9PJS0fbS15ojT9OEM9AXgr+mjXBdoTnFGovBltL9yCmtKx1KJe5uDif8LAbxQNwLC74T8ZeReUwQANQo5CImdVq1GcAVonD1J31iIbCdbU0SOBoEk1cp5bnzjjTMleLQRvXUAmCsaeCUoSg/NJNi6nv9KSQbV1MstXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717125168; c=relaxed/simple;
	bh=mvABzWLO0ZmTDSHnXzGQCtztJaHFqaLp4xV/xy/JZD4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=uA0GIJOymK0kK6EesrZMkIttk71Zs75RjXRkY4+BvA15HDSkS1i6PGaa04KW2M2lX+UEYubjETXrES2C7u7btXePmR4XDCY176telOHmG9GdQzXHB6vsU/YzcFyz1qhKtKXlOdcqJbrJCka2G3Pe8x5/GOO0zUdbYSPCq3zN/Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b8rEi16g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FB4BC116B1;
	Fri, 31 May 2024 03:12:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717125168;
	bh=mvABzWLO0ZmTDSHnXzGQCtztJaHFqaLp4xV/xy/JZD4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=b8rEi16g2AUW9vHMlCM+VGX3A979YOL+TbVmHAUr/A7tCD1av8ezZFA8Qns1UdcIe
	 BEN+3sNEtCrL7fEn54+wD5Rz8YjnKjHcJetmwJrhT9pt35vd6ZM5Q7CvR9jGCyUdLF
	 kXz8axFghW4GZD1K8xvStJmkebMN/wcT2Ej6oJoc8aBIZHsPAtpWxtfzGc0W2WgGnk
	 ru92ZEIZCifBzk4IZfk9gzMJ2sAvNON9awbsSiOzURPXHh//tV3jwmh+r5p4eX4rYS
	 iXnW9swLMAinWK0actw41aRF5jrBYwmIFIuXC1oaKnp1bV92j3IjBP6mF3wAUfqYlS
	 rh/LNYCiykWnQ==
Date: Fri, 31 May 2024 12:12:41 +0900
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
Subject: Re: [PATCH 10/20] function_graph: Have the instances use their own
 ftrace_ops for filtering
Message-Id: <20240531121241.c586189caad8d31d597f614d@kernel.org>
In-Reply-To: <20240530223057.21c2a779@rorschach.local.home>
References: <20240525023652.903909489@goodmis.org>
	<20240525023742.786834257@goodmis.org>
	<20240530223057.21c2a779@rorschach.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 30 May 2024 22:30:57 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Fri, 24 May 2024 22:37:02 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> > 
> > Allow for instances to have their own ftrace_ops part of the fgraph_ops
> > that makes the funtion_graph tracer filter on the set_ftrace_filter file
> > of the instance and not the top instance.
> > 
> > Note that this also requires to update ftrace_graph_func() to call new
> > function_graph_enter_ops() instead of function_graph_enter() so that
> > it avoid pushing on shadow stack multiple times on the same function.
> 
> So I found a major design flaw in this patch.
> 
> > 
> > Co-developed with Masami Hiramatsu:
> > Link: https://lore.kernel.org/linux-trace-kernel/171509102088.162236.15758883237657317789.stgit@devnote2
> > 
> > Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> > ---
> 
> > diff --git a/arch/x86/kernel/ftrace.c b/arch/x86/kernel/ftrace.c
> > index 8da0e66ca22d..998558cb8f15 100644
> > --- a/arch/x86/kernel/ftrace.c
> > +++ b/arch/x86/kernel/ftrace.c
> > @@ -648,9 +648,24 @@ void ftrace_graph_func(unsigned long ip, unsigned long parent_ip,
> >  		       struct ftrace_ops *op, struct ftrace_regs *fregs)
> >  {
> >  	struct pt_regs *regs = &fregs->regs;
> > -	unsigned long *stack = (unsigned long *)kernel_stack_pointer(regs);
> > +	unsigned long *parent = (unsigned long *)kernel_stack_pointer(regs);
> > +	struct fgraph_ops *gops = container_of(op, struct fgraph_ops, ops);
> > +	int bit;
> > +
> > +	if (unlikely(ftrace_graph_is_dead()))
> > +		return;
> > +
> > +	if (unlikely(atomic_read(&current->tracing_graph_pause)))
> > +		return;
> >  
> > -	prepare_ftrace_return(ip, (unsigned long *)stack, 0);
> > +	bit = ftrace_test_recursion_trylock(ip, *parent);
> > +	if (bit < 0)
> > +		return;
> > +
> > +	if (!function_graph_enter_ops(*parent, ip, 0, parent, gops))
> 
> So each registered graph ops has its own ftrace_ops which gets
> registered with ftrace, so this function does get called in a loop (by
> the ftrace iterator function). This means that we would need that code
> to detect the function_graph_enter_ops() getting called multiple times
> for the same function. This means each fgraph_ops gits its own retstack
> on the shadow stack.

Ah, that is my concern and the reason why I added bitmap and stack reuse
code in the ftrace_push_return_trace().

> 
> I find this a waste of shadow stack resources, and also complicates the
> code with having to deal with tail calls and all that.
> 
> BUT! There's good news! I also thought about another way of handling
> this. I have something working, but requires a bit of rewriting the
> code. I should have something out in a day or two.

Hmm, I just wonder why you don't reocver my bitmap check and stack
reusing code. Are there any problem on it? (Too complicated?)

Thanks,

> 
> -- Steve
> 
> 
> > +		*parent = (unsigned long)&return_to_handler;
> > +
> > +	ftrace_test_recursion_unlock(bit);
> >  }
> >  #endif
> >  
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

