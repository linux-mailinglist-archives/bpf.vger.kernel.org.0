Return-Path: <bpf+bounces-72500-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DEC55C133A0
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 08:03:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 41EBF4F053C
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 07:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48C6926F467;
	Tue, 28 Oct 2025 07:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T6bWB3x+"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA015611E;
	Tue, 28 Oct 2025 07:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761634967; cv=none; b=uwd+aYIn34ub9dUGcCzjleI7iQNCZiSnEtMGIvcIZDP/fOkwg2bk0svMyn9pdGrpTu3tzvgz2UQ9XqhQnnS2ATITSLPGUuRXqLPUrB8zxS867SA5xS6rO6LzhDxTBI/jGCbFzHG/SlAq6fZXXNfLr22Ak/KwooQSbdNcUNXHVe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761634967; c=relaxed/simple;
	bh=up08tc/YUb0cEkc2iUu9WrTdHzt37QPPMWQLPZG4agk=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=VHKFCOjoZobZkve7KUjqgTWsKiLTNcCzk5lcq/vCzv9ZzMExwTpiep9vvRiBXIrLepr9q37qaAt+WY9+uj0aGf15b7bayuDD/n4fv4ZjQxOD4XvD8wuP5ViDv8QWkyUZnUfYwCOF6WY3kos0r+a1GD1HRUwAYnkStday2rg2xuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T6bWB3x+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F83FC4CEE7;
	Tue, 28 Oct 2025 07:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761634967;
	bh=up08tc/YUb0cEkc2iUu9WrTdHzt37QPPMWQLPZG4agk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=T6bWB3x+T5QR/GQV8yx2efAldmRDBWtbACpQ7//0PN1QAK2//tWjuM3AdpYkzkFtS
	 I/pwxBhAnXiS1Z3D5qAt7fkqXiTMzDtyqBQ8yIRVsUXOytarKMFJTXkId5UXzXJGRa
	 lxVx7Umiex4WM3/9gJG3dX6GIb+2GzRQSfivOicHppbnv2GEUjbCI3+Li5qLjfkGh9
	 ECWCK8R6/03eyLNoDFr6otQU9MR+ZJUVCDH3n03fxcpcZYFlY2G3uLEA+JjCf7fZna
	 SlttghSaFm/tIEq5yP8dbuQdFBfdrM9Ko75rUVh7v4ne9HUSC9hYNisl2duPfHH6iw
	 JoMsd5C1wc1Pg==
Date: Tue, 28 Oct 2025 16:02:44 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Jiri Olsa <jolsa@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Josh Poimboeuf
 <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org, x86@kernel.org,
 Yonghong Song <yhs@fb.com>, Song Liu <songliubraving@fb.com>, Andrii
 Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH 2/3] x86/fgraph,bpf: Fix stack ORC unwind from
 kprobe_multi return probe
Message-Id: <20251028160244.e9675ed2b7b624487e86a1e7@kernel.org>
In-Reply-To: <20251027131354.1984006-3-jolsa@kernel.org>
References: <20251027131354.1984006-1-jolsa@kernel.org>
	<20251027131354.1984006-3-jolsa@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 27 Oct 2025 14:13:53 +0100
Jiri Olsa <jolsa@kernel.org> wrote:

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
> Note I feel like it'd be better to set those directly in return_to_handler,
> but Steven suggested setting them later in kprobe_multi code path.

Yeah, stacktrace is not always used from the return handler.

> 
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

Thanks for the fix. This looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>


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
> +
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
> diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
> index 7ded7df6e9b5..07f8c309e432 100644
> --- a/include/linux/ftrace.h
> +++ b/include/linux/ftrace.h
> @@ -193,6 +193,10 @@ static __always_inline struct pt_regs *ftrace_get_regs(struct ftrace_regs *fregs
>  #if !defined(CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS) || \
>  	defined(CONFIG_HAVE_FTRACE_REGS_HAVING_PT_REGS)
>  
> +#ifndef arch_ftrace_partial_regs
> +#define arch_ftrace_partial_regs(regs) do {} while (0)
> +#endif
> +
>  static __always_inline struct pt_regs *
>  ftrace_partial_regs(struct ftrace_regs *fregs, struct pt_regs *regs)
>  {
> @@ -202,7 +206,11 @@ ftrace_partial_regs(struct ftrace_regs *fregs, struct pt_regs *regs)
>  	 * Since arch_ftrace_get_regs() will check some members and may return
>  	 * NULL, we can not use it.
>  	 */
> -	return &arch_ftrace_regs(fregs)->regs;
> +	regs = &arch_ftrace_regs(fregs)->regs;
> +
> +	/* Allow arch specific updates to regs. */
> +	arch_ftrace_partial_regs(regs);
> +	return regs;
>  }
>  
>  #endif /* !CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS || CONFIG_HAVE_FTRACE_REGS_HAVING_PT_REGS */
> -- 
> 2.51.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

