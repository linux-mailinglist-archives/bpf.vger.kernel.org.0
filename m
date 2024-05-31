Return-Path: <bpf+bounces-30994-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 956EB8D58A3
	for <lists+bpf@lfdr.de>; Fri, 31 May 2024 04:31:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E645B21B9A
	for <lists+bpf@lfdr.de>; Fri, 31 May 2024 02:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0001078285;
	Fri, 31 May 2024 02:31:34 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27C31F16B;
	Fri, 31 May 2024 02:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717122694; cv=none; b=NA0gvCyw8u/h7ZeIqX2pm+CwIGDmoWJu1Km9j3QKoAoJl9vJsW6bRb27GnffrtpmPE2t4xsy0D4pnu0ZtmUiIg/FUYRQA4J0BtzLKPHHLPs9VN9HD1nIXrA0iVBS2nYHo+5s0ia9UVkAQL2v4f4BVtqlNNkMpaBEAO0OruUJPG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717122694; c=relaxed/simple;
	bh=HPgvz7znQ7uYXknf46QLwPRcWIpnDASNDkawI13u898=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kMopkFWhzElwKUOogGLEjMrW4bPAaPJs34A1ZNLBzUTImr03eBzNMWCQdVHStI84T6YV1+TTjlrHt3Elci5D1+AeJR3cEiZcrZCFW9QvAZFVLJIhC6rfLQ2GNFK0LIjY4QRgYQv6KSq5HLLUiwJhJ4Hnncgr9dAGPrBOgPuYlPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0248C2BBFC;
	Fri, 31 May 2024 02:31:29 +0000 (UTC)
Date: Thu, 30 May 2024 22:30:57 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>, Alexei Starovoitov
 <alexei.starovoitov@gmail.com>, Florent Revest <revest@chromium.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, bpf <bpf@vger.kernel.org>, Sven
 Schnelle <svens@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>, Jiri
 Olsa <jolsa@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Alan Maguire <alan.maguire@oracle.com>,
 Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner
 <tglx@linutronix.de>, Guo Ren <guoren@kernel.org>
Subject: Re: [PATCH 10/20] function_graph: Have the instances use their own
 ftrace_ops for filtering
Message-ID: <20240530223057.21c2a779@rorschach.local.home>
In-Reply-To: <20240525023742.786834257@goodmis.org>
References: <20240525023652.903909489@goodmis.org>
	<20240525023742.786834257@goodmis.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 24 May 2024 22:37:02 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> 
> Allow for instances to have their own ftrace_ops part of the fgraph_ops
> that makes the funtion_graph tracer filter on the set_ftrace_filter file
> of the instance and not the top instance.
> 
> Note that this also requires to update ftrace_graph_func() to call new
> function_graph_enter_ops() instead of function_graph_enter() so that
> it avoid pushing on shadow stack multiple times on the same function.

So I found a major design flaw in this patch.

> 
> Co-developed with Masami Hiramatsu:
> Link: https://lore.kernel.org/linux-trace-kernel/171509102088.162236.15758883237657317789.stgit@devnote2
> 
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---

> diff --git a/arch/x86/kernel/ftrace.c b/arch/x86/kernel/ftrace.c
> index 8da0e66ca22d..998558cb8f15 100644
> --- a/arch/x86/kernel/ftrace.c
> +++ b/arch/x86/kernel/ftrace.c
> @@ -648,9 +648,24 @@ void ftrace_graph_func(unsigned long ip, unsigned long parent_ip,
>  		       struct ftrace_ops *op, struct ftrace_regs *fregs)
>  {
>  	struct pt_regs *regs = &fregs->regs;
> -	unsigned long *stack = (unsigned long *)kernel_stack_pointer(regs);
> +	unsigned long *parent = (unsigned long *)kernel_stack_pointer(regs);
> +	struct fgraph_ops *gops = container_of(op, struct fgraph_ops, ops);
> +	int bit;
> +
> +	if (unlikely(ftrace_graph_is_dead()))
> +		return;
> +
> +	if (unlikely(atomic_read(&current->tracing_graph_pause)))
> +		return;
>  
> -	prepare_ftrace_return(ip, (unsigned long *)stack, 0);
> +	bit = ftrace_test_recursion_trylock(ip, *parent);
> +	if (bit < 0)
> +		return;
> +
> +	if (!function_graph_enter_ops(*parent, ip, 0, parent, gops))

So each registered graph ops has its own ftrace_ops which gets
registered with ftrace, so this function does get called in a loop (by
the ftrace iterator function). This means that we would need that code
to detect the function_graph_enter_ops() getting called multiple times
for the same function. This means each fgraph_ops gits its own retstack
on the shadow stack.

I find this a waste of shadow stack resources, and also complicates the
code with having to deal with tail calls and all that.

BUT! There's good news! I also thought about another way of handling
this. I have something working, but requires a bit of rewriting the
code. I should have something out in a day or two.

-- Steve


> +		*parent = (unsigned long)&return_to_handler;
> +
> +	ftrace_test_recursion_unlock(bit);
>  }
>  #endif
>  

