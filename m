Return-Path: <bpf+bounces-22262-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7059285A823
	for <lists+bpf@lfdr.de>; Mon, 19 Feb 2024 17:05:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C442282E32
	for <lists+bpf@lfdr.de>; Mon, 19 Feb 2024 16:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFF223BB48;
	Mon, 19 Feb 2024 16:05:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2573A8FB;
	Mon, 19 Feb 2024 16:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708358724; cv=none; b=MX+8E0ND/AboiToynBW2/al1k5z3GQtBi/fYCP651u/xd+7MubxpxVCQxk84r+ivtWyVGxkLeoQfT1IsDpZQopc4EAc5AnbbQcRW0BNo8L9XJadsG3RCM0lDm0NHNXE8jjiUh+H16UkkY/rXLrCbcE6xEQZVlkfOcPS3kIDXktQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708358724; c=relaxed/simple;
	bh=/dckHxJU8Um9rSbczYrIkkwQ4W5d5/C4/kuOUKIhTok=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=txD7BYYttdKICxqutmsqG/Np+7T9JXzRaGhnaI5qN0LwadVKuYXnSxywGonn0xfMCI/QvUTWarLYpr5C0DBPKk8yb3LtHohLEXF36BQLs6gUQZ7s6vhbAmgBKk2wkWx3TuAda2kg3PMfOowHo/MzAOP+7D/rHcTV+IstNLJAm2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87B9FC433C7;
	Mon, 19 Feb 2024 16:05:22 +0000 (UTC)
Date: Mon, 19 Feb 2024 11:07:05 -0500
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
Subject: Re: [PATCH v7 22/36] function_graph: Add a new entry handler with
 parent_ip and ftrace_regs
Message-ID: <20240219110705.0c1ffa9c@gandalf.local.home>
In-Reply-To: <170723229401.502590.8644663781359457778.stgit@devnote2>
References: <170723204881.502590.11906735097521170661.stgit@devnote2>
	<170723229401.502590.8644663781359457778.stgit@devnote2>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  7 Feb 2024 00:11:34 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Add a new entry handler to fgraph_ops as 'entryregfunc'  which takes
> parent_ip and ftrace_regs. Note that the 'entryfunc' and 'entryregfunc'
> are mutual exclusive. You can set only one of them.
> 
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>  Changes in v3:
>   - Update for new multiple fgraph.
> ---
>  arch/arm64/kernel/ftrace.c               |    2 +
>  arch/loongarch/kernel/ftrace_dyn.c       |    2 +
>  arch/powerpc/kernel/trace/ftrace.c       |    2 +
>  arch/powerpc/kernel/trace/ftrace_64_pg.c |   10 ++++---
>  arch/x86/kernel/ftrace.c                 |   42 ++++++++++++++++--------------
>  include/linux/ftrace.h                   |   19 +++++++++++---
>  kernel/trace/fgraph.c                    |   30 +++++++++++++++++----
>  7 files changed, 72 insertions(+), 35 deletions(-)
> 
> diff --git a/arch/arm64/kernel/ftrace.c b/arch/arm64/kernel/ftrace.c
> index b96740829798..779b975f03f5 100644
> --- a/arch/arm64/kernel/ftrace.c
> +++ b/arch/arm64/kernel/ftrace.c
> @@ -497,7 +497,7 @@ void ftrace_graph_func(unsigned long ip, unsigned long parent_ip,
>  		return;
>  
>  	if (!function_graph_enter_ops(*parent, ip, frame_pointer,
> -				      (void *)frame_pointer, gops))
> +				      (void *)frame_pointer, fregs, gops))

I would like to replace that second frame_pointer with fregs.


>  		*parent = (unsigned long)&return_to_handler;
>  
>  	ftrace_test_recursion_unlock(bit);
> diff --git a/arch/loongarch/kernel/ftrace_dyn.c b/arch/loongarch/kernel/ftrace_dyn.c
> index 81d18b911cc1..45d26c6e6564 100644
> --- a/arch/loongarch/kernel/ftrace_dyn.c
> +++ b/arch/loongarch/kernel/ftrace_dyn.c
> @@ -250,7 +250,7 @@ void ftrace_graph_func(unsigned long ip, unsigned long parent_ip,
>  
>  	old = *parent;
>  
> -	if (!function_graph_enter_ops(old, ip, 0, parent, gops))
> +	if (!function_graph_enter_ops(old, ip, 0, parent, fregs, gops))

That is, to replace the parent with fregs, as the parent can be retrieved
from fregs.

We should add a fregs helper (something like):

unsigned long *fregs_caller_addr(fregs) {
	return (unsigned long *)(kernel_stack_pointer(fregs->regs) + PT_R1);
}

That returns the address that points to the parent caller on the stack.

This was on my todo list to do. That is, replace the passing of the parent
of the stack with fregs as it is redundant information.

>  		*parent = return_hooker;
>  }
>  #else
> diff --git a/arch/powerpc/kernel/trace/ftrace.c b/arch/powerpc/kernel/trace/ftrace.c
> index 4ef8bf480279..eeaaa798f4f9 100644
> --- a/arch/powerpc/kernel/trace/ftrace.c
> +++ b/arch/powerpc/kernel/trace/ftrace.c
> @@ -423,7 +423,7 @@ void ftrace_graph_func(unsigned long ip, unsigned long parent_ip,
>  	if (bit < 0)
>  		goto out;
>  
> -	if (!function_graph_enter_ops(parent_ip, ip, 0, (unsigned long *)sp, gops))
> +	if (!function_graph_enter_ops(parent_ip, ip, 0, (unsigned long *)sp, fregs, gops))
>  		parent_ip = ppc_function_entry(return_to_handler);
>  
>  	ftrace_test_recursion_unlock(bit);
> diff --git a/arch/powerpc/kernel/trace/ftrace_64_pg.c b/arch/powerpc/kernel/trace/ftrace_64_pg.c
> index 7b85c3b460a3..43f6cfaaf7db 100644
> --- a/arch/powerpc/kernel/trace/ftrace_64_pg.c
> +++ b/arch/powerpc/kernel/trace/ftrace_64_pg.c
> @@ -795,7 +795,8 @@ int ftrace_disable_ftrace_graph_caller(void)
>   * in current thread info. Return the address we want to divert to.
>   */
>  static unsigned long
> -__prepare_ftrace_return(unsigned long parent, unsigned long ip, unsigned long sp)
> +__prepare_ftrace_return(unsigned long parent, unsigned long ip, unsigned long sp,
> +			struct ftrace_regs *fregs)

And sp shouldn't need to be passed in either, as hat should be part of the fregs.

I really like to consolidate the parameters and not just keep adding to
them. This all slows down the logic to load the parameters.

-- Steve


>  {
>  	unsigned long return_hooker;
>  	int bit;

