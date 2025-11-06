Return-Path: <bpf+bounces-73831-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F492C3AE48
	for <lists+bpf@lfdr.de>; Thu, 06 Nov 2025 13:29:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A83E034A44A
	for <lists+bpf@lfdr.de>; Thu,  6 Nov 2025 12:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 059CF32AABD;
	Thu,  6 Nov 2025 12:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TJ417h+t"
X-Original-To: bpf@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC3A32AAB1;
	Thu,  6 Nov 2025 12:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762432184; cv=none; b=OG9iOtd0MqXHfmi4VBA87ihSl3E6oLVEa/aRfsPxG2TLGzupSBgK7ZhjV5f823i90QySJrGlpHTNKUeAylvjOD/KshCuCkbRlvP/gVfZaCVMP+DTTy4UZvnlDl8iLFMTYKYz7p+be/m9uI+wgLV49kelRcBMX8u5sZCiQ/TpVBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762432184; c=relaxed/simple;
	bh=tA/9M3ARi9alo/ypAVAeWDUjilXQBiFkWC2MawbGD6I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G9iFMtBelOY0vlj6FRNd1uLrJ+8glAWvAAxEufuV24v8RE5CzH8skCxdhQRPs7b+N6gkEmRrZTCarO+0NllqaYx7RrhE2y/KF6ugCic8MOegWcz6aQdTB29tz4/HdTf1C1TRGqqXtbqh6B+luknp9C/62ONrIDspQonCr0U0jXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=TJ417h+t; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=nPqBbMUpCv5pTCYTP8O6tM3Iga00IspR1junwdyt1zs=; b=TJ417h+tcI06ZEgaOT1NLNNoy+
	CpJdWI0I60n9Gkb+MR5ugJCoVdd0iHoSvZn7nXcnRRYYe9cfxlsy/ANSvEwRjPX5HDXB8Skc5Cpck
	B4RTbeK4BV5dr2ierYmk66qGXx3E9/joRIMZnNoJ0KLpDoFXu73fjiMNSzki/MZPx0dKdeq0UTq/E
	kjy2/Gpab2i6qbFTk8wyMTuoMGYMLYsE3sBj2vqOCnAoFSUfYcEYiU+kBZxuihll08SArfd37QLFU
	lQKBKRZiyyr58inYkw0MaL8FB2/Q5b3C6P2ha9ReX6fYxgoyQYmCIxIOI6BT3tvqaP3KtPOjs/JNV
	59dwYK5A==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGyFh-00000004G1l-2SOg;
	Thu, 06 Nov 2025 11:34:08 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 75DD730023C; Thu, 06 Nov 2025 13:29:33 +0100 (CET)
Date: Thu, 6 Nov 2025 13:29:33 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Jiri Olsa <jolsa@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>, bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, x86@kernel.org,
	Yonghong Song <yhs@fb.com>, Song Liu <songliubraving@fb.com>,
	Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCHv2 2/4] x86/fgraph,bpf: Fix stack ORC unwind from
 kprobe_multi return probe
Message-ID: <20251106122933.GW4067720@noisy.programming.kicks-ass.net>
References: <20251103220924.36371-1-jolsa@kernel.org>
 <20251103220924.36371-3-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251103220924.36371-3-jolsa@kernel.org>

On Mon, Nov 03, 2025 at 11:09:22PM +0100, Jiri Olsa wrote:
> Currently we don't get stack trace via ORC unwinder on top of fgraph exit
> handler. We can see that when generating stacktrace from kretprobe_multi
> bpf program which is based on fprobe/fgraph.
> 
> The reason is that the ORC unwind code won't get pass the return_to_handler
> callback installed by fgraph return probe machinery.
> 
> Solving this by creating stack frame in return_to_handler expected by
> ftrace_graph_ret_addr function to recover original return address and
> continue with the unwind.
> 
> Also updating the pt_regs data with cs/flags/rsp which are needed for
> successful stack retrieval from ebpf bpf_get_stackid helper.
>  - in get_perf_callchain we check user_mode(regs) so CS has to be set
>  - in perf_callchain_kernel we call perf_hw_regs(regs), so EFLAGS/FIXED
>     has to be unset
> 
> Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  arch/x86/include/asm/ftrace.h |  5 +++++
>  arch/x86/kernel/ftrace_64.S   |  8 +++++++-
>  include/linux/ftrace.h        | 10 +++++++++-
>  3 files changed, 21 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/include/asm/ftrace.h b/arch/x86/include/asm/ftrace.h
> index 93156ac4ffe0..b08c95872eed 100644
> --- a/arch/x86/include/asm/ftrace.h
> +++ b/arch/x86/include/asm/ftrace.h
> @@ -56,6 +56,11 @@ arch_ftrace_get_regs(struct ftrace_regs *fregs)
>  	return &arch_ftrace_regs(fregs)->regs;
>  }
>  
> +#define arch_ftrace_partial_regs(regs) do {	\
> +	regs->flags &= ~X86_EFLAGS_FIXED;	\
> +	regs->cs = __KERNEL_CS;			\
> +} while (0)

I lost the plot. Why here and not in asm below?

>  #define arch_ftrace_fill_perf_regs(fregs, _regs) do {	\
>  		(_regs)->ip = arch_ftrace_regs(fregs)->regs.ip;		\
>  		(_regs)->sp = arch_ftrace_regs(fregs)->regs.sp;		\
> diff --git a/arch/x86/kernel/ftrace_64.S b/arch/x86/kernel/ftrace_64.S
> index 367da3638167..823dbdd0eb41 100644
> --- a/arch/x86/kernel/ftrace_64.S
> +++ b/arch/x86/kernel/ftrace_64.S
> @@ -354,12 +354,17 @@ SYM_CODE_START(return_to_handler)
>  	UNWIND_HINT_UNDEFINED
>  	ANNOTATE_NOENDBR
>  
> +	/* Restore return_to_handler value that got eaten by previous ret instruction. */
> +	subq $8, %rsp
> +	UNWIND_HINT_FUNC
> +
>  	/* Save ftrace_regs for function exit context  */
>  	subq $(FRAME_SIZE), %rsp
>  
>  	movq %rax, RAX(%rsp)
>  	movq %rdx, RDX(%rsp)
>  	movq %rbp, RBP(%rsp)
> +	movq %rsp, RSP(%rsp)
>  	movq %rsp, %rdi
>  
>  	call ftrace_return_to_handler
> @@ -368,7 +373,8 @@ SYM_CODE_START(return_to_handler)
>  	movq RDX(%rsp), %rdx
>  	movq RAX(%rsp), %rax
>  
> -	addq $(FRAME_SIZE), %rsp
> +	addq $(FRAME_SIZE) + 8, %rsp
> +
>  	/*
>  	 * Jump back to the old return address. This cannot be JMP_NOSPEC rdi
>  	 * since IBT would demand that contain ENDBR, which simply isn't so for

