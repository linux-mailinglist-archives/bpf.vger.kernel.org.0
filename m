Return-Path: <bpf+bounces-22092-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CF5FD85692D
	for <lists+bpf@lfdr.de>; Thu, 15 Feb 2024 17:14:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56F6DB2A4C0
	for <lists+bpf@lfdr.de>; Thu, 15 Feb 2024 16:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A1981350CB;
	Thu, 15 Feb 2024 16:06:37 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CFF013342A;
	Thu, 15 Feb 2024 16:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708013197; cv=none; b=CddAc8iwQt5auDUeW4hfYbs34zpzsX0yas+GgITu4gY9TO/6GRs+WmfB2tRyBAuMz17L4Tg7QS4iVQGJ/9Key2/GWxhDmDr9swo23o/bkBiVo4+kwLridClvkdbIVNcXgO4zYpiAktIcD72OBbtU4BWx/9EGyJJPhERboZtxCCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708013197; c=relaxed/simple;
	bh=JICvr0D4tYvl5DaKYMCiv1tn6ushEDdrtmyTwJvTNJU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=COjHdklXc+JVZrh1C0JSVEsGrIXS+R3lBP9M7SIgnCqYh7Q12CGBMietnhQCmR+aKbxQFSlTYZmPrD/gzArm64bxk9LP+FP8DZTRhvaglxNWgMRM4/dJSZLJV30bVKedLIALUqWMRRMQs8HYt8/wPzt96GCPE2lCg8fW1mu7FVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00AA4C43390;
	Thu, 15 Feb 2024 16:06:34 +0000 (UTC)
Date: Thu, 15 Feb 2024 11:08:08 -0500
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
Subject: Re: [PATCH v7 24/36] x86/ftrace: Enable HAVE_FUNCTION_GRAPH_FREGS
Message-ID: <20240215110808.752c9b67@gandalf.local.home>
In-Reply-To: <170723231592.502590.12367006830540525214.stgit@devnote2>
References: <170723204881.502590.11906735097521170661.stgit@devnote2>
	<170723231592.502590.12367006830540525214.stgit@devnote2>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  7 Feb 2024 00:11:56 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Support HAVE_FUNCTION_GRAPH_FREGS on x86-64, which saves ftrace_regs
> on the stack in ftrace_graph return trampoline so that the callbacks
> can access registers via ftrace_regs APIs.
> 
> Note that this only recovers 'rax' and 'rdx' registers because other
> registers are not used anymore and recovered by caller. 'rax' and
> 'rdx' will be used for passing the return value.
> 
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>  Changes in v3:
>   - Add a comment about rip.
>  Changes in v2:
>   - Save rsp register and drop clearing orig_ax.
> ---
>  arch/x86/Kconfig            |    3 ++-
>  arch/x86/kernel/ftrace_64.S |   37 +++++++++++++++++++++++++++++--------
>  2 files changed, 31 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 5edec175b9bf..ccf17d8b6f5f 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -223,7 +223,8 @@ config X86
>  	select HAVE_FAST_GUP
>  	select HAVE_FENTRY			if X86_64 || DYNAMIC_FTRACE
>  	select HAVE_FTRACE_MCOUNT_RECORD
> -	select HAVE_FUNCTION_GRAPH_RETVAL	if HAVE_FUNCTION_GRAPH_TRACER
> +	select HAVE_FUNCTION_GRAPH_FREGS	if HAVE_DYNAMIC_FTRACE_WITH_ARGS
> +	select HAVE_FUNCTION_GRAPH_RETVAL	if !HAVE_DYNAMIC_FTRACE_WITH_ARGS
>  	select HAVE_FUNCTION_GRAPH_TRACER	if X86_32 || (X86_64 && DYNAMIC_FTRACE)
>  	select HAVE_FUNCTION_TRACER
>  	select HAVE_GCC_PLUGINS
> diff --git a/arch/x86/kernel/ftrace_64.S b/arch/x86/kernel/ftrace_64.S
> index 214f30e9f0c0..8a16f774604e 100644
> --- a/arch/x86/kernel/ftrace_64.S
> +++ b/arch/x86/kernel/ftrace_64.S
> @@ -348,21 +348,42 @@ STACK_FRAME_NON_STANDARD_FP(__fentry__)
>  SYM_CODE_START(return_to_handler)
>  	UNWIND_HINT_UNDEFINED
>  	ANNOTATE_NOENDBR
> -	subq  $24, %rsp
> +	/*
> +	 * Save the registers requires for ftrace_regs;
> +	 * rax, rcx, rdx, rdi, rsi, r8, r9 and rbp
> +	 */
> +	subq $(FRAME_SIZE), %rsp
> +	movq %rax, RAX(%rsp)
> +	movq %rcx, RCX(%rsp)
> +	movq %rdx, RDX(%rsp)
> +	movq %rsi, RSI(%rsp)
> +	movq %rdi, RDI(%rsp)
> +	movq %r8, R8(%rsp)
> +	movq %r9, R9(%rsp)
> +	movq %rbp, RBP(%rsp)

This unconditionally slows down function graph tracer for no good reason.

Most of the above is going to be garbage anyway, except the rax and rdx.

I would recommend than we set something else in the ftrace regs that states
this only holds return values. Anything else will just get invalid.

I'm really against saving garbage. The purpose of ftrace_regs is that it
can hold incomplete data.

-- Steve


> +	/*
> +	 * orig_ax is not cleared because it is used for indicating the direct
> +	 * trampoline in the fentry. And rip is not set because we don't know
> +	 * the correct return address here.
> +	 */
> +
> +	leaq FRAME_SIZE(%rsp), %rcx
> +	movq %rcx, RSP(%rsp)
>  
> -	/* Save the return values */
> -	movq %rax, (%rsp)
> -	movq %rdx, 8(%rsp)
> -	movq %rbp, 16(%rsp)
>  	movq %rsp, %rdi
>  
>  	call ftrace_return_to_handler
>  
>  	movq %rax, %rdi
> -	movq 8(%rsp), %rdx
> -	movq (%rsp), %rax
>  
> -	addq $24, %rsp
> +	/*
> +	 * Restore only rax and rdx because other registers are not used
> +	 * for return value nor callee saved. Caller will reuse/recover it.
> +	 */
> +	movq RDX(%rsp), %rdx
> +	movq RAX(%rsp), %rax
> +
> +	addq $(FRAME_SIZE), %rsp
>  	/*
>  	 * Jump back to the old return address. This cannot be JMP_NOSPEC rdi
>  	 * since IBT would demand that contain ENDBR, which simply isn't so for


