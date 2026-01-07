Return-Path: <bpf+bounces-78095-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C3E4FCFE85A
	for <lists+bpf@lfdr.de>; Wed, 07 Jan 2026 16:17:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4BA1430AC165
	for <lists+bpf@lfdr.de>; Wed,  7 Jan 2026 15:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8421533F395;
	Wed,  7 Jan 2026 14:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cOew/IRO"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A2133EB13;
	Wed,  7 Jan 2026 14:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767795371; cv=none; b=bub7//TK9uq9c7yVtTVvDlisizq7gpEcSayuBsDFeF055SzFSarYf42pLl+KbLENhWISiPIif6T/noB3Uqx3i/oL1rPN55aWhB1LmiQu1yPvi9oDE+fZaPZBvl20I4NDYA4Rcs3Hhtzn9thA6AECNS/AA5YcmgG75dy6j84TElQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767795371; c=relaxed/simple;
	bh=Hfk0xs9mtMTgHWqYqiIZSwai97YK7tXfeXKFSxGISsw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=He96GHWhJlE215gBreXw2oJTc45Rba7p1AV739FgKS/DvkbpLWXrbKr/PQawKwarGWaMY1DRu1Rdbeh+WaakoO5Meko6YInBHYTlIwGaiT/sT5XTJ1vuVuWAOJd7/5C35DMd6zSZoNuuIgpIaIGPswM+CRtPpoXO1PhCJz0bSGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cOew/IRO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 911F4C4CEF1;
	Wed,  7 Jan 2026 14:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767795371;
	bh=Hfk0xs9mtMTgHWqYqiIZSwai97YK7tXfeXKFSxGISsw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cOew/IROfm9qzOOTQIlOisZOSH2KDoX3TgEbHyuflgqC5Z5szpbbIyuEetC1flL6Y
	 SYTDzqJW12y5zkLVrJYPlpNkw9Wxr3Wl6b6qFj2lSry637N+RjGLs1BNZp3EX/T67s
	 doWTIk3TUg3TiyRXTEGzUuGaNUaYKOTU75qGJxUFaPkUDAdFQlmbe0SXBxJB+IQaq8
	 a1gL6Qy83KbVAlQgf6RA1sokeiZ2VtjnXC/YcLo3oT9GhG7GFW01i8XXcMFp9YP8Ju
	 1t/kHF5utWwL9fzUqEQ285i3g1aeqr3Kn+MnpolB5I9wfd2ytmGhbMHTjmxNF/kKxZ
	 YCtS4FD8oCXVw==
Date: Wed, 7 Jan 2026 14:16:05 +0000
From: Will Deacon <will@kernel.org>
To: Jiri Olsa <jolsa@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mahe Tardy <mahe.tardy@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>, bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, x86@kernel.org,
	Yonghong Song <yhs@fb.com>, Song Liu <songliubraving@fb.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH bpf-next 1/2] arm64/ftrace,bpf: Fix partial regs after
 bpf_prog_run
Message-ID: <aV5qpZwxgVRu2Q8w@willie-the-truck>
References: <20260107093256.54616-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260107093256.54616-1-jolsa@kernel.org>

On Wed, Jan 07, 2026 at 10:32:55AM +0100, Jiri Olsa wrote:
> Mahe reported issue with bpf_override_return helper not working when
> executed from kprobe.multi bpf program on arm.
> 
> The problem is that on arm we use alternate storage for pt_regs object
> that is passed to bpf_prog_run and if any register is changed (which
> is the case of bpf_override_return) it's not propagated back to actual
> pt_regs object.
> 
> Fixing this by introducing and calling ftrace_partial_regs_update function
> to propagate the values of changed registers (ip and stack).
> 
> Fixes: b9b55c8912ce ("tracing: Add ftrace_partial_regs() for converting ftrace_regs to pt_regs")
> Reported-by: Mahe Tardy <mahe.tardy@gmail.com>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
> v1 changes:
>  - used ftrace_partial_regs_update with comments from Steven
> 
>  arch/arm64/include/asm/ftrace.h | 24 ++++++++++++++++++++++++
>  include/linux/ftrace.h          |  3 +++
>  kernel/trace/bpf_trace.c        |  1 +
>  3 files changed, 28 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/ftrace.h b/arch/arm64/include/asm/ftrace.h
> index 1621c84f44b3..177c7bbf3b84 100644
> --- a/arch/arm64/include/asm/ftrace.h
> +++ b/arch/arm64/include/asm/ftrace.h
> @@ -157,6 +157,30 @@ ftrace_partial_regs(const struct ftrace_regs *fregs, struct pt_regs *regs)
>  	return regs;
>  }
>  
> +/*
> + * ftrace_partial_regs_update - update the original ftrace_regs from regs
> + * @fregs: The ftrace_regs to update from @regs
> + * @regs: The partial regs from ftrace_partial_regs() that was updated
> + *
> + * Some architectures have the partial regs living in the ftrace_regs
> + * structure, whereas other architectures need to make a different copy
> + * of the @regs. If a partial @regs is retrieved by ftrace_partial_regs() and
> + * if the code using @regs updates a field (like the instruction pointer or
> + * stack pointer) it may need to propagate that change to the original @fregs
> + * it retrieved the partial @regs from. Use this function to guarantee that
> + * update happens.
> + */
> +static __always_inline void
> +ftrace_partial_regs_update(const struct ftrace_regs *fregs, struct pt_regs *regs)
> +{
> +	struct __arch_ftrace_regs *afregs = arch_ftrace_regs(fregs);
> +
> +	if (afregs->pc != regs->pc) {
> +		afregs->pc = regs->pc;
> +		afregs->regs[0] = regs->regs[0];
> +	}
> +}

I still don't understand why we need anything new in the arch code for this.

We've selected HAVE_ARCH_FTRACE_REGS and we implement
ftrace_regs_set_instruction_pointer() and ftrace_regs_set_return_value()
so the core code already has everything it needs to make this work
without additional arch support.

Will

