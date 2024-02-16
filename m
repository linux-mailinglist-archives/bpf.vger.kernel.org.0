Return-Path: <bpf+bounces-22147-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ECF13857CEE
	for <lists+bpf@lfdr.de>; Fri, 16 Feb 2024 13:50:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52726B20B4E
	for <lists+bpf@lfdr.de>; Fri, 16 Feb 2024 12:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D90B1292D0;
	Fri, 16 Feb 2024 12:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lYsvJKr6"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7C112883D;
	Fri, 16 Feb 2024 12:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708087789; cv=none; b=T6ZSYqqVQqb8p342TLW5jWqD6xHxpM9WvDQcqxqZsQTSQCurwjYH+/JGxY/4bv8zk9GWe3Uv1h11E1m4ALNEzTEa7RUdl/yRcN4GckgUx21r/V5AvJU/aCETR1jy2mq3XcRFBk9VprcfUQhWEVCIGab88RZ+2kgaH6VyrimhSZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708087789; c=relaxed/simple;
	bh=pqG7w2RnbS8BjbrhNK5arbiLuDG9/PkGucdIlBTC7jQ=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=VzUerZfRrZuvm1RpE2WVmVJwH5JSghCIz08ypAGr+Gx1uXInjc1sAmXaVtoFgU09bvH305tan7gjhLEbY8EvlQWrJMko0DZG+SSxW4Rf0hNSs410Wnm9FII+/HpCEs66HbW8070ryi8pvnuc/pDuXTajdQxTKgOAiFKncZPKvlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lYsvJKr6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A3A0C433F1;
	Fri, 16 Feb 2024 12:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708087789;
	bh=pqG7w2RnbS8BjbrhNK5arbiLuDG9/PkGucdIlBTC7jQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lYsvJKr6f1cDQxULIAqOHGUjAPWhOUnOdn1C+TbA8lA3hxsduzPKxdBLGgwMBWB7M
	 kiXdCnYEOkDVenej53oTYpjgJAbNbJMslgDuo74yB6I0Z09mVh1Hy3KIGvELHcNg5P
	 PIoj+BzPZJWi0VNasRgsWJcxOHw0hP/SiKKfr7w/SCOZVtCkXYmWw3TQANXo4MvF9L
	 QNCSQJQ8Xt8/QPm3ts66EB6M+k9HvH42s3MzbnbXOPE6LEhtYvY6ZGvEOsH+quo7XJ
	 c9FCslRDZWKZesYSbUiKnMwQsS6/+c9d1LIdCL14Z8sM4lBx3V7aixtpy5NZI7WeDA
	 El3dXqDQ7QqrQ==
Date: Fri, 16 Feb 2024 21:49:27 +0900
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
Subject: Re: [PATCH v7 25/36] arm64: ftrace: Enable
 HAVE_FUNCTION_GRAPH_FREGS
Message-Id: <20240216214927.9f25ba478d24883c72bdec81@kernel.org>
In-Reply-To: <20240215111021.05163ba1@gandalf.local.home>
References: <170723204881.502590.11906735097521170661.stgit@devnote2>
	<170723232647.502590.10808588686838195094.stgit@devnote2>
	<20240215111021.05163ba1@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 15 Feb 2024 11:10:21 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Wed,  7 Feb 2024 00:12:06 +0900
> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> 
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> > Enable CONFIG_HAVE_FUNCTION_GRAPH_FREGS on arm64. Note that this
> > depends on HAVE_DYNAMIC_FTRACE_WITH_ARGS which is enabled if the
> > compiler supports "-fpatchable-function-entry=2". If not, it
> > continue to use ftrace_ret_regs.
> > 
> > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > ---
> >  Changes in v3:
> >    - Newly added.
> > ---
> >  arch/arm64/Kconfig               |    2 ++
> >  arch/arm64/include/asm/ftrace.h  |    6 ++++++
> >  arch/arm64/kernel/entry-ftrace.S |   28 ++++++++++++++++++++++++++++
> >  3 files changed, 36 insertions(+)
> > 
> > diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > index aa7c1d435139..34becd41ae66 100644
> > --- a/arch/arm64/Kconfig
> > +++ b/arch/arm64/Kconfig
> > @@ -194,6 +194,8 @@ config ARM64
> >  	select HAVE_DYNAMIC_FTRACE
> >  	select HAVE_DYNAMIC_FTRACE_WITH_ARGS \
> >  		if $(cc-option,-fpatchable-function-entry=2)
> > +	select HAVE_FUNCTION_GRAPH_FREGS \
> > +		if HAVE_DYNAMIC_FTRACE_WITH_ARGS
> >  	select HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS \
> >  		if DYNAMIC_FTRACE_WITH_ARGS && DYNAMIC_FTRACE_WITH_CALL_OPS
> >  	select HAVE_DYNAMIC_FTRACE_WITH_CALL_OPS \
> > diff --git a/arch/arm64/include/asm/ftrace.h b/arch/arm64/include/asm/ftrace.h
> > index ab158196480c..efd5dbf74dd6 100644
> > --- a/arch/arm64/include/asm/ftrace.h
> > +++ b/arch/arm64/include/asm/ftrace.h
> > @@ -131,6 +131,12 @@ ftrace_regs_set_return_value(struct ftrace_regs *fregs,
> >  	fregs->regs[0] = ret;
> >  }
> >  
> > +static __always_inline unsigned long
> > +ftrace_regs_get_frame_pointer(struct ftrace_regs *fregs)
> > +{
> > +	return fregs->fp;
> > +}
> > +
> >  static __always_inline void
> >  ftrace_override_function_with_return(struct ftrace_regs *fregs)
> >  {
> > diff --git a/arch/arm64/kernel/entry-ftrace.S b/arch/arm64/kernel/entry-ftrace.S
> > index f0c16640ef21..d87ccdb9e678 100644
> > --- a/arch/arm64/kernel/entry-ftrace.S
> > +++ b/arch/arm64/kernel/entry-ftrace.S
> > @@ -328,6 +328,33 @@ SYM_FUNC_END(ftrace_stub_graph)
> >   * Run ftrace_return_to_handler() before going back to parent.
> >   * @fp is checked against the value passed by ftrace_graph_caller().
> >   */
> > +#ifdef CONFIG_HAVE_FUNCTION_GRAPH_FREGS
> > +SYM_CODE_START(return_to_handler)
> > +	/* save ftrace_regs except for PC */
> > +	sub	sp, sp, #FREGS_SIZE
> > +	stp	x0, x1, [sp, #FREGS_X0]
> > +	stp	x2, x3, [sp, #FREGS_X2]
> > +	stp	x4, x5, [sp, #FREGS_X4]
> > +	stp	x6, x7, [sp, #FREGS_X6]
> > +	str	x8,     [sp, #FREGS_X8]
> > +	str	x29, [sp, #FREGS_FP]
> > +	str	x9,  [sp, #FREGS_LR]
> > +	str	x10, [sp, #FREGS_SP]
> 
> Here too. The above is just garbage.
> 
> Let's not fill in garbarge registers. The above is useless on return of a
> function. Heck, adding zeros is better than this. But really, we need to
> have ftrace regs to have some kind of flag that can state what it holds.
> Right now I see three states:
> 
>  1 - holds all regs and pt_regs can be retrieved
>  2 - only holds function entry regs (parameters and stack)
>  3 - only holds function exit regs (return value and stack)
> 
> Don't save anything else unless needed.

OK, it is reasonable to save the registers depending on the context.

Thanks,

> 
> -- Steve
> 
> > +
> > +	mov	x0, sp
> > +	bl	ftrace_return_to_handler	// addr = ftrace_return_to_hander(fregs);
> > +	mov	x30, x0				// restore the original return address
> > +
> > +	/* restore return value regs */
> > +	ldp x0, x1, [sp, #FREGS_X0]
> > +	ldp x2, x3, [sp, #FREGS_X2]
> > +	ldp x4, x5, [sp, #FREGS_X4]
> > +	ldp x6, x7, [sp, #FREGS_X6]
> > +	add sp, sp, #FREGS_SIZE
> > +
> > +	ret
> > +SYM_CODE_END(return_to_handler)
> > +#else /* !CONFIG_HAVE_FUNCTION_GRAPH_FREGS */
> >  SYM_CODE_START(return_to_handler)
> >  	/* save return value regs */
> >  	sub sp, sp, #FGRET_REGS_SIZE
> > @@ -350,4 +377,5 @@ SYM_CODE_START(return_to_handler)
> >  
> >  	ret
> >  SYM_CODE_END(return_to_handler)
> > +#endif /* CONFIG_HAVE_FUNCTION_GRAPH_FREGS */
> >  #endif /* CONFIG_FUNCTION_GRAPH_TRACER */
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

