Return-Path: <bpf+bounces-22093-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49FD0856930
	for <lists+bpf@lfdr.de>; Thu, 15 Feb 2024 17:14:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 073A82821A7
	for <lists+bpf@lfdr.de>; Thu, 15 Feb 2024 16:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C76C41386AE;
	Thu, 15 Feb 2024 16:08:50 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 777B51339A9;
	Thu, 15 Feb 2024 16:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708013330; cv=none; b=MCIhCiy/YuLBqBdCm2gV2TMh3BDWi6oGvXWVvSJIqVBDW4DOBBmw8B+38YrQb36H2hHJE/Ug9B/yCEjcYE0apqqF1r3zybRC/2U2RBMX/gIoIbWKvugYVKVe1sXpg7jizXrTa9ZhlBewogS0dI/T+jx7lSbxgWAqJSKt4U8LAVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708013330; c=relaxed/simple;
	bh=oG6XQpiguIejDhBna2Kjxoiz9TbXaIQMa+9CRNJEo5k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=god0upz6gD373yJSEVVNhb+AbDghSGqRUUiiTLDhUQtrzQpjIr3SxItGP8L7yy2T3f+JvtCk2dQzZJ1+Wsp2VUixoXw+dCfK44wkqh1VDZ8ZKmmviLVEx1GrHh9x6sqnsZZhufQty5ar8qHjucVVXlK5MBUrLY7HnNWYa/kWy4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F360C433F1;
	Thu, 15 Feb 2024 16:08:48 +0000 (UTC)
Date: Thu, 15 Feb 2024 11:10:21 -0500
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
Subject: Re: [PATCH v7 25/36] arm64: ftrace: Enable
 HAVE_FUNCTION_GRAPH_FREGS
Message-ID: <20240215111021.05163ba1@gandalf.local.home>
In-Reply-To: <170723232647.502590.10808588686838195094.stgit@devnote2>
References: <170723204881.502590.11906735097521170661.stgit@devnote2>
	<170723232647.502590.10808588686838195094.stgit@devnote2>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  7 Feb 2024 00:12:06 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Enable CONFIG_HAVE_FUNCTION_GRAPH_FREGS on arm64. Note that this
> depends on HAVE_DYNAMIC_FTRACE_WITH_ARGS which is enabled if the
> compiler supports "-fpatchable-function-entry=2". If not, it
> continue to use ftrace_ret_regs.
> 
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>  Changes in v3:
>    - Newly added.
> ---
>  arch/arm64/Kconfig               |    2 ++
>  arch/arm64/include/asm/ftrace.h  |    6 ++++++
>  arch/arm64/kernel/entry-ftrace.S |   28 ++++++++++++++++++++++++++++
>  3 files changed, 36 insertions(+)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index aa7c1d435139..34becd41ae66 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -194,6 +194,8 @@ config ARM64
>  	select HAVE_DYNAMIC_FTRACE
>  	select HAVE_DYNAMIC_FTRACE_WITH_ARGS \
>  		if $(cc-option,-fpatchable-function-entry=2)
> +	select HAVE_FUNCTION_GRAPH_FREGS \
> +		if HAVE_DYNAMIC_FTRACE_WITH_ARGS
>  	select HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS \
>  		if DYNAMIC_FTRACE_WITH_ARGS && DYNAMIC_FTRACE_WITH_CALL_OPS
>  	select HAVE_DYNAMIC_FTRACE_WITH_CALL_OPS \
> diff --git a/arch/arm64/include/asm/ftrace.h b/arch/arm64/include/asm/ftrace.h
> index ab158196480c..efd5dbf74dd6 100644
> --- a/arch/arm64/include/asm/ftrace.h
> +++ b/arch/arm64/include/asm/ftrace.h
> @@ -131,6 +131,12 @@ ftrace_regs_set_return_value(struct ftrace_regs *fregs,
>  	fregs->regs[0] = ret;
>  }
>  
> +static __always_inline unsigned long
> +ftrace_regs_get_frame_pointer(struct ftrace_regs *fregs)
> +{
> +	return fregs->fp;
> +}
> +
>  static __always_inline void
>  ftrace_override_function_with_return(struct ftrace_regs *fregs)
>  {
> diff --git a/arch/arm64/kernel/entry-ftrace.S b/arch/arm64/kernel/entry-ftrace.S
> index f0c16640ef21..d87ccdb9e678 100644
> --- a/arch/arm64/kernel/entry-ftrace.S
> +++ b/arch/arm64/kernel/entry-ftrace.S
> @@ -328,6 +328,33 @@ SYM_FUNC_END(ftrace_stub_graph)
>   * Run ftrace_return_to_handler() before going back to parent.
>   * @fp is checked against the value passed by ftrace_graph_caller().
>   */
> +#ifdef CONFIG_HAVE_FUNCTION_GRAPH_FREGS
> +SYM_CODE_START(return_to_handler)
> +	/* save ftrace_regs except for PC */
> +	sub	sp, sp, #FREGS_SIZE
> +	stp	x0, x1, [sp, #FREGS_X0]
> +	stp	x2, x3, [sp, #FREGS_X2]
> +	stp	x4, x5, [sp, #FREGS_X4]
> +	stp	x6, x7, [sp, #FREGS_X6]
> +	str	x8,     [sp, #FREGS_X8]
> +	str	x29, [sp, #FREGS_FP]
> +	str	x9,  [sp, #FREGS_LR]
> +	str	x10, [sp, #FREGS_SP]

Here too. The above is just garbage.

Let's not fill in garbarge registers. The above is useless on return of a
function. Heck, adding zeros is better than this. But really, we need to
have ftrace regs to have some kind of flag that can state what it holds.
Right now I see three states:

 1 - holds all regs and pt_regs can be retrieved
 2 - only holds function entry regs (parameters and stack)
 3 - only holds function exit regs (return value and stack)

Don't save anything else unless needed.

-- Steve

> +
> +	mov	x0, sp
> +	bl	ftrace_return_to_handler	// addr = ftrace_return_to_hander(fregs);
> +	mov	x30, x0				// restore the original return address
> +
> +	/* restore return value regs */
> +	ldp x0, x1, [sp, #FREGS_X0]
> +	ldp x2, x3, [sp, #FREGS_X2]
> +	ldp x4, x5, [sp, #FREGS_X4]
> +	ldp x6, x7, [sp, #FREGS_X6]
> +	add sp, sp, #FREGS_SIZE
> +
> +	ret
> +SYM_CODE_END(return_to_handler)
> +#else /* !CONFIG_HAVE_FUNCTION_GRAPH_FREGS */
>  SYM_CODE_START(return_to_handler)
>  	/* save return value regs */
>  	sub sp, sp, #FGRET_REGS_SIZE
> @@ -350,4 +377,5 @@ SYM_CODE_START(return_to_handler)
>  
>  	ret
>  SYM_CODE_END(return_to_handler)
> +#endif /* CONFIG_HAVE_FUNCTION_GRAPH_FREGS */
>  #endif /* CONFIG_FUNCTION_GRAPH_TRACER */


