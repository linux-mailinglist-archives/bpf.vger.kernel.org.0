Return-Path: <bpf+bounces-33610-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6858A923AA6
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 11:51:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 954B11C20FE6
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 09:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 371D6156F4C;
	Tue,  2 Jul 2024 09:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KVAp/286"
X-Original-To: bpf@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0317D156C47;
	Tue,  2 Jul 2024 09:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719913849; cv=none; b=G7n25zbkeUbYr2FGuQD7DR+X3GUqyBdEZFm57px1L/wwzo6BNRUTPqZ/x77omCk1jrDdWFMUpE0Q5cWQAdQQnI5wLuUEHKmytI3gJnKGcqNk6QWKDnVB3G4RA4why27Wg5Qgj1JD5kx1n0jUce0Bu4zOqfltE1c1WLo8ZfHZzHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719913849; c=relaxed/simple;
	bh=C71q7XOGjq1cp7MEC0epIpQIKzfkI54UVlCdCaChcCA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kh34x7t8dxu1l64vcns8JtkKruCpM4kau6BrevjDkBFCGgYRl2P6bJb6CwWRa1GNKknSUs3FPEneP3kX0b5djxCsXf5F1acBkeo0WWgn6NmofibcT+ck2m0EP48pJfLTmSaevAOuOJ/Dq/Mp2Xk527WdrpowsiKeKbSRfQlzLqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=KVAp/286; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=yVAgFmc2jfemV7dYXU7HrJUVOj82WBlcccsUG2Rh3ts=; b=KVAp/286L9ZgnaYlV3rgbv4Mmm
	oJTk4aZiqPS6tlLFgFd5VoNoJTyekSZnQMunHSeaLleobIuQ4OGtqMEHw4MOP0roiVZ5e4zTKHUMx
	5sMuAS9SSzHNIP2PysDVmKgHD5FC0gA/vmMjHnhiq37TIh5E/JnRQBNdAaxzp+31n9b2VW9sUw/l5
	vukWVQHS8U9i83TFOIz9/unESMNhY2Tsyh+5k5ccVs51qO0fJrLe7Ps3hbkcmf1n0XWE3V1Ymoj1+
	hwbuNGH0ySEfCfcRh+RKsMZwL+Q5CVdhEXGlful0udf5qGYLrN34TcEG8CGhLdIZh2zRZ386xbXSP
	X1ehJbWQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOa9o-00000009nny-1U1Z;
	Tue, 02 Jul 2024 09:50:40 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 08D05300694; Tue,  2 Jul 2024 11:50:37 +0200 (CEST)
Date: Tue, 2 Jul 2024 11:50:36 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, rostedt@goodmis.org,
	mhiramat@kernel.org, x86@kernel.org, mingo@redhat.com,
	tglx@linutronix.de, bpf@vger.kernel.org, rihams@fb.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH] perf,x86: avoid missing caller address in stack traces
 captured in uprobe
Message-ID: <20240702095036.GE11386@noisy.programming.kicks-ass.net>
References: <20240701231027.61930-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240701231027.61930-1-andrii@kernel.org>


+Josj +LKML

On Mon, Jul 01, 2024 at 04:10:27PM -0700, Andrii Nakryiko wrote:
> When tracing user functions with uprobe functionality, it's common to
> install the probe (e.g., a BPF program) at the first instruction of the
> function. This is often going to be `push %rbp` instruction in function
> preamble, which means that within that function frame pointer hasn't
> been established yet. This leads to consistently missing an actual
> caller of the traced function, because perf_callchain_user() only
> records current IP (capturing traced function) and then following frame
> pointer chain (which would be caller's frame, containing the address of
> caller's caller).
> 
> So when we have target_1 -> target_2 -> target_3 call chain and we are
> tracing an entry to target_3, captured stack trace will report
> target_1 -> target_3 call chain, which is wrong and confusing.
> 
> This patch proposes a x86-64-specific heuristic to detect `push %rbp`
> instruction being traced. Given entire kernel implementation of user
> space stack trace capturing works under assumption that user space code
> was compiled with frame pointer register (%rbp) preservation, it seems
> pretty reasonable to use this instruction as a strong indicator that
> this is the entry to the function. In that case, return address is still
> pointed to by %rsp, so we fetch it and add to stack trace before
> proceeding to unwind the rest using frame pointer-based logic.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  arch/x86/events/core.c  | 20 ++++++++++++++++++++
>  include/linux/uprobes.h |  2 ++
>  kernel/events/uprobes.c |  2 ++
>  3 files changed, 24 insertions(+)
> 
> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> index 5b0dd07b1ef1..82d5570b58ff 100644
> --- a/arch/x86/events/core.c
> +++ b/arch/x86/events/core.c
> @@ -2884,6 +2884,26 @@ perf_callchain_user(struct perf_callchain_entry_ctx *entry, struct pt_regs *regs
>  		return;
>  
>  	pagefault_disable();
> +
> +#ifdef CONFIG_UPROBES
> +	/*
> +	 * If we are called from uprobe handler, and we are indeed at the very
> +	 * entry to user function (which is normally a `push %rbp` instruction,
> +	 * under assumption of application being compiled with frame pointers),
> +	 * we should read return address from *regs->sp before proceeding
> +	 * to follow frame pointers, otherwise we'll skip immediate caller
> +	 * as %rbp is not yet setup.
> +	 */
> +	if (current->utask) {
> +		struct arch_uprobe *auprobe = current->utask->auprobe;
> +		u64 ret_addr;
> +
> +		if (auprobe && auprobe->insn[0] == 0x55 /* push %rbp */ &&
> +		    !__get_user(ret_addr, (const u64 __user *)regs->sp))

This u64 is wrong, perf_callchain_user() is always native size.

Additionally, I suppose you should also add a hunk to
perf_callchain_user32(), which is the compat case.

> +			perf_callchain_store(entry, ret_addr);
> +	}
> +#endif
> +
>  	while (entry->nr < entry->max_stack) {
>  		if (!valid_user_frame(fp, sizeof(frame)))
>  			break;
> diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
> index b503fafb7fb3..a270a5892ab4 100644
> --- a/include/linux/uprobes.h
> +++ b/include/linux/uprobes.h
> @@ -76,6 +76,8 @@ struct uprobe_task {
>  	struct uprobe			*active_uprobe;
>  	unsigned long			xol_vaddr;
>  
> +	struct arch_uprobe              *auprobe;
> +
>  	struct return_instance		*return_instances;
>  	unsigned int			depth;
>  };
> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index 99be2adedbc0..6e22e4d80f1e 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -2082,6 +2082,7 @@ static void handler_chain(struct uprobe *uprobe, struct pt_regs *regs)
>  	bool need_prep = false; /* prepare return uprobe, when needed */
>  
>  	down_read(&uprobe->register_rwsem);
> +	current->utask->auprobe = &uprobe->arch;
>  	for (uc = uprobe->consumers; uc; uc = uc->next) {
>  		int rc = 0;
>  
> @@ -2096,6 +2097,7 @@ static void handler_chain(struct uprobe *uprobe, struct pt_regs *regs)
>  
>  		remove &= rc;
>  	}
> +	current->utask->auprobe = NULL;
>  
>  	if (need_prep && !remove)
>  		prepare_uretprobe(uprobe, regs); /* put bp at return */
> -- 
> 2.43.0
> 

