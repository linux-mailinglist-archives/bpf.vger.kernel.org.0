Return-Path: <bpf+bounces-22139-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FBDE85781B
	for <lists+bpf@lfdr.de>; Fri, 16 Feb 2024 09:55:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 178502832F7
	for <lists+bpf@lfdr.de>; Fri, 16 Feb 2024 08:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D178D1B950;
	Fri, 16 Feb 2024 08:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hjza4dJc"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D2A31B946;
	Fri, 16 Feb 2024 08:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708073670; cv=none; b=JO3N3NEVOxOjbxUwjLbfcs9sx33vD752qVtpQJzGYHZVex0WtdLh4hxxMpbKlc2StXmjacxSvZlpXtyj4Pi2jZJcwusyfFo7JvW5HgBEScx5uWOGkwL+N7k6fpOQIxDop0BjdENQC1P8FvDUhQRwbElO+tVWQwI4YB2j7Ejy/7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708073670; c=relaxed/simple;
	bh=8yoLoVuMaVp/tWX6NtXM03pCFmXTbQbmXsQiE0p0b/A=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=D6vxtixH3aJlOsmai392mjnf6nb1Ym8/LeueJayP4lV5sckdouJqH5NQ+YqvOUw9Gi3tkVSPwEBzn6Agi8Q4qG4cNU6H2C/AMOdeFECHGlDxJD0MyB9CtsUSLyM3D46BbVBedcyfQp4mzE2C2QdOKnVlyhmfr1t1QbCalD9GUiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hjza4dJc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7678C433F1;
	Fri, 16 Feb 2024 08:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708073669;
	bh=8yoLoVuMaVp/tWX6NtXM03pCFmXTbQbmXsQiE0p0b/A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Hjza4dJcDPk2BdpZ3yzVgVWVaslyT2Wn7Knq/7ZeALFYddcDeBm7KaW9L2YVVDVHe
	 Y6JSuvyEevYLGUkf+4WXAiMlC0DI8WJCQETjx4Ruqh/5W8RFxUxQ+uZDM7p1IwM/62
	 YqgXqK/RbNo7rrKmVbbBpa6qY41McsPsjpM2I46LH6g7RKa4VneWr77aj70zYvu6Qo
	 qRzdy4UnBcovwBJCUuHDfHD6HVImBd0qkSuYn5tm0ZuTBB2pPyv9MNlFQ2oITaZQOC
	 n13j7JX85t/kWyLpddo550Nwk4MJ4MuUnqSXj/vatzKXECnBRBtExeBnJofpiCM+SJ
	 qzHPjso2tMXGQ==
Date: Fri, 16 Feb 2024 17:54:23 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
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
Message-Id: <20240216175423.1a5d7a9762b5a693e273b40f@kernel.org>
In-Reply-To: <20240215110808.752c9b67@gandalf.local.home>
References: <170723204881.502590.11906735097521170661.stgit@devnote2>
	<170723231592.502590.12367006830540525214.stgit@devnote2>
	<20240215110808.752c9b67@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 15 Feb 2024 11:08:08 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Wed,  7 Feb 2024 00:11:56 +0900
> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> 
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> > Support HAVE_FUNCTION_GRAPH_FREGS on x86-64, which saves ftrace_regs
> > on the stack in ftrace_graph return trampoline so that the callbacks
> > can access registers via ftrace_regs APIs.
> > 
> > Note that this only recovers 'rax' and 'rdx' registers because other
> > registers are not used anymore and recovered by caller. 'rax' and
> > 'rdx' will be used for passing the return value.
> > 
> > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > ---
> >  Changes in v3:
> >   - Add a comment about rip.
> >  Changes in v2:
> >   - Save rsp register and drop clearing orig_ax.
> > ---
> >  arch/x86/Kconfig            |    3 ++-
> >  arch/x86/kernel/ftrace_64.S |   37 +++++++++++++++++++++++++++++--------
> >  2 files changed, 31 insertions(+), 9 deletions(-)
> > 
> > diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> > index 5edec175b9bf..ccf17d8b6f5f 100644
> > --- a/arch/x86/Kconfig
> > +++ b/arch/x86/Kconfig
> > @@ -223,7 +223,8 @@ config X86
> >  	select HAVE_FAST_GUP
> >  	select HAVE_FENTRY			if X86_64 || DYNAMIC_FTRACE
> >  	select HAVE_FTRACE_MCOUNT_RECORD
> > -	select HAVE_FUNCTION_GRAPH_RETVAL	if HAVE_FUNCTION_GRAPH_TRACER
> > +	select HAVE_FUNCTION_GRAPH_FREGS	if HAVE_DYNAMIC_FTRACE_WITH_ARGS
> > +	select HAVE_FUNCTION_GRAPH_RETVAL	if !HAVE_DYNAMIC_FTRACE_WITH_ARGS
> >  	select HAVE_FUNCTION_GRAPH_TRACER	if X86_32 || (X86_64 && DYNAMIC_FTRACE)
> >  	select HAVE_FUNCTION_TRACER
> >  	select HAVE_GCC_PLUGINS
> > diff --git a/arch/x86/kernel/ftrace_64.S b/arch/x86/kernel/ftrace_64.S
> > index 214f30e9f0c0..8a16f774604e 100644
> > --- a/arch/x86/kernel/ftrace_64.S
> > +++ b/arch/x86/kernel/ftrace_64.S
> > @@ -348,21 +348,42 @@ STACK_FRAME_NON_STANDARD_FP(__fentry__)
> >  SYM_CODE_START(return_to_handler)
> >  	UNWIND_HINT_UNDEFINED
> >  	ANNOTATE_NOENDBR
> > -	subq  $24, %rsp
> > +	/*
> > +	 * Save the registers requires for ftrace_regs;
> > +	 * rax, rcx, rdx, rdi, rsi, r8, r9 and rbp
> > +	 */
> > +	subq $(FRAME_SIZE), %rsp
> > +	movq %rax, RAX(%rsp)
> > +	movq %rcx, RCX(%rsp)
> > +	movq %rdx, RDX(%rsp)
> > +	movq %rsi, RSI(%rsp)
> > +	movq %rdi, RDI(%rsp)
> > +	movq %r8, R8(%rsp)
> > +	movq %r9, R9(%rsp)
> > +	movq %rbp, RBP(%rsp)
> 
> This unconditionally slows down function graph tracer for no good reason.
> 
> Most of the above is going to be garbage anyway, except the rax and rdx.
> 
> I would recommend than we set something else in the ftrace regs that states
> this only holds return values. Anything else will just get invalid.
> 
> I'm really against saving garbage. The purpose of ftrace_regs is that it
> can hold incomplete data.

Ah, OK. I misunderstood. I thought ftrace_regs was expected to be filled
with reduced (arch-defined) register set. But it just ensures that holds
some registers depends on the context.

Thank you,

> 
> -- Steve
> 
> 
> > +	/*
> > +	 * orig_ax is not cleared because it is used for indicating the direct
> > +	 * trampoline in the fentry. And rip is not set because we don't know
> > +	 * the correct return address here.
> > +	 */
> > +
> > +	leaq FRAME_SIZE(%rsp), %rcx
> > +	movq %rcx, RSP(%rsp)
> >  
> > -	/* Save the return values */
> > -	movq %rax, (%rsp)
> > -	movq %rdx, 8(%rsp)
> > -	movq %rbp, 16(%rsp)
> >  	movq %rsp, %rdi
> >  
> >  	call ftrace_return_to_handler
> >  
> >  	movq %rax, %rdi
> > -	movq 8(%rsp), %rdx
> > -	movq (%rsp), %rax
> >  
> > -	addq $24, %rsp
> > +	/*
> > +	 * Restore only rax and rdx because other registers are not used
> > +	 * for return value nor callee saved. Caller will reuse/recover it.
> > +	 */
> > +	movq RDX(%rsp), %rdx
> > +	movq RAX(%rsp), %rax
> > +
> > +	addq $(FRAME_SIZE), %rsp
> >  	/*
> >  	 * Jump back to the old return address. This cannot be JMP_NOSPEC rdi
> >  	 * since IBT would demand that contain ENDBR, which simply isn't so for
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

