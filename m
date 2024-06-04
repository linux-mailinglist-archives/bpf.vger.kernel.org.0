Return-Path: <bpf+bounces-31307-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50B5F8FB4C7
	for <lists+bpf@lfdr.de>; Tue,  4 Jun 2024 16:06:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72F871C21384
	for <lists+bpf@lfdr.de>; Tue,  4 Jun 2024 14:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5781D17C72;
	Tue,  4 Jun 2024 14:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cSSL1J1k"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB06F171C9;
	Tue,  4 Jun 2024 14:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717509968; cv=none; b=qUbz5V4DhOg1Z+fwrkxLrNyunojYtCpODEc0aAPNJckOROh/tbsE7g7TI3MdbjMAVZraVUtjbueiEh0WenLVpWH7xFNfNwZeZ8IE7Xcm+VJnPOLDS9sofrTM2t7CXB2xaKib9ckX3RRL/jWn+MIUraAs0kMWPyMBDvzmLnSe+Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717509968; c=relaxed/simple;
	bh=46xCi/XDubx5Ggm1z6bnsFr6EInBTbfNV7xpSUKnQy4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=l+ocsD45R7SIWX1mU0TuWmsRq0lnqdMmwqz9tJnFohm1EjCxPhdLnxQL/qEjOY7YjZfCaJOOF65x5EQp8i2TgBsdNRmCMa27Vqi2UOFUGll5pDNJpspR8KYNnQFz7QWH6KnJFcjXxJzOS4aM+tQvdnRj7h0g2WbvmbLQm84bR8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cSSL1J1k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FDC6C2BBFC;
	Tue,  4 Jun 2024 14:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717509968;
	bh=46xCi/XDubx5Ggm1z6bnsFr6EInBTbfNV7xpSUKnQy4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cSSL1J1k5EFYdTgeOr5CXeVulV7NSIq2ZAqBWBwZPTn50bUdoXLo3jw/1sNSx48aj
	 QZlERaXbg2NKXVQkn/rhZddnhSfK7lC1Z1CbFZ12Q8MuLqTzXUxkAm6tjdlI1F9dbS
	 4XDdtzRmG2rZ3Iid3lSKE442XqWXHi3VtMJEXGlfvFFgNEgDcXpqXBNREcb7/W42mI
	 Km4vWUr4bp1SGVCwzvca6L8O7A0tBypDgruTUrj8Jcf8/HpzlOwDmxjG9xdVFZfHA/
	 JzpUHX1aKNzOSOnmsrbC7Znm4UF7b9l5Tr29cNRDQitndUl5c3SPutiyevefkM8W1C
	 MhIksD/PxITNw==
Date: Tue, 4 Jun 2024 23:06:03 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, rostedt@goodmis.org, x86@kernel.org,
 peterz@infradead.org, mingo@redhat.com, tglx@linutronix.de,
 bpf@vger.kernel.org, rihams@fb.com, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2 3/4] perf,x86: avoid missing caller address in stack
 traces captured in uprobe
Message-Id: <20240604230603.16e5fedaf3d9a4981e619259@kernel.org>
In-Reply-To: <20240522013845.1631305-4-andrii@kernel.org>
References: <20240522013845.1631305-1-andrii@kernel.org>
	<20240522013845.1631305-4-andrii@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 21 May 2024 18:38:44 -0700
Andrii Nakryiko <andrii@kernel.org> wrote:

> When tracing user functions with uprobe functionality, it's common to
> install the probe (e.g., a BPF program) at the first instruction of the
> function. This is often going to be `push %rbp` instruction in function
> preamble, which means that within that function frame pointer hasn't
> been established yet. This leads to consistently missing an actual
> caller of the traced function, because perf_callchain_user() only
> records current IP (capturing traced function) and then following frame
> pointer chain (which would be caller's frame, containing the address of
> caller's caller).

I thought this problem might be solved by sframe.

> 
> So when we have target_1 -> target_2 -> target_3 call chain and we are
> tracing an entry to target_3, captured stack trace will report
> target_1 -> target_3 call chain, which is wrong and confusing.
> 
> This patch proposes a x86-64-specific heuristic to detect `push %rbp`
> instruction being traced.

I like this kind of idea :) But I think this should be done in
the user-space, not in the kernel because it is not always sure
that the user program uses stack frames. 

> If that's the case, with the assumption that
> applicatoin is compiled with frame pointers, this instruction would be
> a strong indicator that this is the entry to the function. In that case,
> return address is still pointed to by %rsp, so we fetch it and add to
> stack trace before proceeding to unwind the rest using frame
> pointer-based logic.

Why don't we make it in the userspace BPF program? If it is done
in the user space, like perf-probe, I'm OK. But I doubt to do this in
kernel. That means it is not flexible.

More than anything, without user-space helper to find function
symbols, uprobe does not know the function entry. Then I'm curious
why don't you do this in the user space.

At least, this should be done in the user of uprobes, like trace_uprobe
or bpf.


Thank you,

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
> +			perf_callchain_store(entry, ret_addr);
> +	}
> +#endif
> +
>  	while (entry->nr < entry->max_stack) {
>  		if (!valid_user_frame(fp, sizeof(frame)))
>  			break;
> diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
> index 0c57eec85339..7b785cd30d86 100644
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
> index 1c99380dc89d..504693845187 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -2072,6 +2072,7 @@ static void handler_chain(struct uprobe *uprobe, struct pt_regs *regs)
>  	bool need_prep = false; /* prepare return uprobe, when needed */
>  
>  	down_read(&uprobe->register_rwsem);
> +	current->utask->auprobe = &uprobe->arch;
>  	for (uc = uprobe->consumers; uc; uc = uc->next) {
>  		int rc = 0;
>  
> @@ -2086,6 +2087,7 @@ static void handler_chain(struct uprobe *uprobe, struct pt_regs *regs)
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


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

