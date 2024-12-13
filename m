Return-Path: <bpf+bounces-46849-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 025DF9F0DA7
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 14:49:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF367282307
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 13:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 627D41E25ED;
	Fri, 13 Dec 2024 13:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=t-8ch.de header.i=@t-8ch.de header.b="hcqKWvy2"
X-Original-To: bpf@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD041E0DD5;
	Fri, 13 Dec 2024 13:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734097690; cv=none; b=dvW2XxfWhLkK6ZeVnOxkzZUQzQhHpKs515jlDubdYD4H3Tx+MjeDtiLRo3nVY41gjtIn783PaC14uzAzBa7wFSik1W4QAFnIQl7IT6ls5ToPvSGyvMmTPwdnhy7PEENdbGoFqHYUipBul2MIDhwgyyM3lPYBT2EY5hL3NBsqdLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734097690; c=relaxed/simple;
	bh=S0Bbsf6dqc+B+Jkcb/HpUWRU3bAA4P9Jcd0n8MIhryI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IpP5bIjUO+IQ8H4Vw6vB3+s+nCcsOJB1LRay/wbkKSI3HOn7jyZCrUBfdHznUKWjotJg5q4pR5IGX/nNjKngvU8wlrknzCycky7He3hoSrYB1MIV9Ho7lmYkXQmkioief5keU8wR81kvEbSulXLZKdty2T+bgsMUeUeDhJgzIMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=t-8ch.de; spf=pass smtp.mailfrom=t-8ch.de; dkim=pass (1024-bit key) header.d=t-8ch.de header.i=@t-8ch.de header.b=hcqKWvy2; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=t-8ch.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-8ch.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
	t=1734097681; bh=S0Bbsf6dqc+B+Jkcb/HpUWRU3bAA4P9Jcd0n8MIhryI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hcqKWvy2FbGa2PkAlvlK+A8GOXbhJ9yFCdhLaPGcN4gVCl2GbdAXW7xhFY77GZRyP
	 pH4vyexGOILMoBFG1FzfKocsyiQoaKvnAxsCC1HIjEfHFiAR4yuOyvC41d9GLYRCt5
	 5N/Ul9VfJMX4brGJj3JNu6kFGDU73j7VhHeEbB+E=
Date: Fri, 13 Dec 2024 14:48:00 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To: Jiri Olsa <jolsa@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, Song Liu <songliubraving@fb.com>, 
	Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>, 
	Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Alan Maguire <alan.maguire@oracle.com>, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next 06/13] uprobes/x86: Add uprobe syscall to speed
 up uprobe
Message-ID: <66e85401-b2ec-442d-bebe-c4ff3151e7e2@t-8ch.de>
References: <20241211133403.208920-1-jolsa@kernel.org>
 <20241211133403.208920-7-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241211133403.208920-7-jolsa@kernel.org>

On 2024-12-11 14:33:55+0100, Jiri Olsa wrote:
> Adding new uprobe syscall that calls uprobe handlers for given
> 'breakpoint' address.
> 
> The idea is that the 'breakpoint' address calls the user space
> trampoline which executes the uprobe syscall.
> 
> The syscall handler reads the return address of the initial call
> to retrieve the original 'breakpoint' address. With this address
> we find the related uprobe object and call its consumers.
> 
> Adding the arch_uprobe_trampoline_mapping function that provides
> uprobe trampoline mapping. This mapping is backed with one global
> page initialized at __init time and shared by the all the mapping
> instances.
> 
> We do not allow to execute uprobe syscall if the caller is not
> from uprobe trampoline mapping.
> 
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  arch/x86/entry/syscalls/syscall_64.tbl |  1 +
>  arch/x86/kernel/uprobes.c              | 80 ++++++++++++++++++++++++++
>  include/linux/syscalls.h               |  2 +
>  include/linux/uprobes.h                |  1 +
>  kernel/events/uprobes.c                | 22 +++++++
>  kernel/sys_ni.c                        |  1 +
>  6 files changed, 107 insertions(+)
> 
> diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
> index 5eb708bff1c7..88e388c7675b 100644
> --- a/arch/x86/entry/syscalls/syscall_64.tbl
> +++ b/arch/x86/entry/syscalls/syscall_64.tbl
> @@ -345,6 +345,7 @@
>  333	common	io_pgetevents		sys_io_pgetevents
>  334	common	rseq			sys_rseq
>  335	common	uretprobe		sys_uretprobe
> +336	common	uprobe			sys_uprobe
>  # don't use numbers 387 through 423, add new calls after the last
>  # 'common' entry
>  424	common	pidfd_send_signal	sys_pidfd_send_signal
> diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
> index 22a17c149a55..23e4f2821cff 100644
> --- a/arch/x86/kernel/uprobes.c
> +++ b/arch/x86/kernel/uprobes.c
> @@ -425,6 +425,86 @@ SYSCALL_DEFINE0(uretprobe)
>  	return -1;
>  }
>  
> +static int tramp_mremap(const struct vm_special_mapping *sm, struct vm_area_struct *new_vma)
> +{
> +	return -EPERM;
> +}
> +
> +static struct vm_special_mapping tramp_mapping = {
> +	.name   = "[uprobes-trampoline]",
> +	.mremap = tramp_mremap,
> +};
> +
> +SYSCALL_DEFINE0(uprobe)
> +{
> +	struct pt_regs *regs = task_pt_regs(current);
> +	struct vm_area_struct *vma;
> +	unsigned long bp_vaddr;
> +	int err;
> +
> +	err = copy_from_user(&bp_vaddr, (void __user *)regs->sp + 3*8, sizeof(bp_vaddr));

A #define for the magic values would be nice.

> +	if (err) {
> +		force_sig(SIGILL);
> +		return -1;
> +	}
> +
> +	/* Allow execution only from uprobe trampolines. */
> +	vma = vma_lookup(current->mm, regs->ip);
> +	if (!vma || vma->vm_private_data != (void *) &tramp_mapping) {

vma_is_special_mapping()

> +		force_sig(SIGILL);
> +		return -1;
> +	}
> +
> +	handle_syscall_uprobe(regs, bp_vaddr - 5);
> +	return 0;
> +}
> +
> +asm (
> +	".pushsection .rodata\n"
> +	".global uprobe_trampoline_entry\n"
> +	"uprobe_trampoline_entry:\n"
> +	"endbr64\n"
> +	"push %rcx\n"
> +	"push %r11\n"
> +	"push %rax\n"
> +	"movq $" __stringify(__NR_uprobe) ", %rax\n"
> +	"syscall\n"
> +	"pop %rax\n"
> +	"pop %r11\n"
> +	"pop %rcx\n"
> +	"ret\n"
> +	".global uprobe_trampoline_end\n"
> +	"uprobe_trampoline_end:\n"
> +	".popsection\n"
> +);
> +
> +extern __visible u8 uprobe_trampoline_entry[];
> +extern __visible u8 uprobe_trampoline_end[];
> +
> +const struct vm_special_mapping *arch_uprobe_trampoline_mapping(void)
> +{
> +	struct pt_regs *regs = task_pt_regs(current);
> +
> +	return user_64bit_mode(regs) ? &tramp_mapping : NULL;
> +}
> +
> +static int __init arch_uprobes_init(void)
> +{
> +	unsigned long size = uprobe_trampoline_end - uprobe_trampoline_entry;
> +	static struct page *pages[2];
> +	struct page *page;
> +
> +	page = alloc_page(GFP_HIGHUSER);

That page could be in static memory, removing the need for the explicit
allocation. It could also be __ro_after_init.
Then tramp_mapping itself can be const.

Also this seems to waste the page on 32bit kernels.

> +	if (!page)
> +		return -ENOMEM;
> +	pages[0] = page;
> +	tramp_mapping.pages = (struct page **) &pages;

tramp_mapping.pages = pages; ?

> +	arch_uprobe_copy_ixol(page, 0, uprobe_trampoline_entry, size);
> +	return 0;
> +}
> +
> +late_initcall(arch_uprobes_init);
> +
>  /*
>   * If arch_uprobe->insn doesn't use rip-relative addressing, return
>   * immediately.  Otherwise, rewrite the instruction so that it accesses

[..]

