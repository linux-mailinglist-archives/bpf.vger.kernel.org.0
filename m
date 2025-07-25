Return-Path: <bpf+bounces-64357-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97033B11C01
	for <lists+bpf@lfdr.de>; Fri, 25 Jul 2025 12:16:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BFE51892C53
	for <lists+bpf@lfdr.de>; Fri, 25 Jul 2025 10:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4DF42E54C5;
	Fri, 25 Jul 2025 10:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BsyH1QmA"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461D02E543E;
	Fri, 25 Jul 2025 10:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753438310; cv=none; b=tCw8fEvTBOummEQyGdWbhGwZL7OHCzM/lF4gcRT+/UncMhavZy4J3D6evJjnHOtKYtpdojd9YpCvK149e0StbuvM3gl/JcEOb+YNDnT1RhQQrfg0qXpywTGrDnfg2ALx/U/p7VuZZ9hkxhkREIw+9wPedaXNwk8j54wwItAoO+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753438310; c=relaxed/simple;
	bh=aQi8U07nJiWlsTT5drTwPLEyTiRfoLQE1Ei661AEFGg=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=lGmFzkSoel3ji9RB9FOLVRpHFQ8McZswd9h6ENTfGCoK2c72D9WyD+5pWsgoYFvgX6nIITUXBsoKEqjoJaFGyvcD+X/Yz5dH8IZ93SqF/oA/UC/v9h+h6LanNNYY/3qnxj00vrWQkeyHT8CfvKYnprtQrkSvlgeNqB+4Hbshok0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BsyH1QmA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7759CC4CEEF;
	Fri, 25 Jul 2025 10:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753438310;
	bh=aQi8U07nJiWlsTT5drTwPLEyTiRfoLQE1Ei661AEFGg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BsyH1QmAEBaDpMXgiYVtkjMpPj6V3kdLijfyR9LCzGs54en6ZqJOZYtrpi0+yt/2r
	 myuxb5HZpN0baWKw1JbQDQN04E0jM1uhDgpD7S2xCj0cC72/gN2EsjiR/oFr8O5ZVo
	 iP4xsUyaC3NMWnsGETUdTMjJYIx8qLEJQTH2g5KYE2NgRztVfrSojIMt+CVTnfoF9c
	 EsbY7fbhIJFf8DpUyqOawdvOSAAfc9d2I67P9Be1NqZ8wWdw6p210IHTOV47n0/EOo
	 WtGUI5J8hQXn4O8HoAIrgepshehOLCKYg9kSW0S4Z1ByVJixrrFbpnzBWwE/YOGLxh
	 t5MbMJZiUHw3g==
Date: Fri, 25 Jul 2025 19:11:43 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Jiri Olsa <jolsa@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 x86@kernel.org, Song Liu <songliubraving@fb.com>, Yonghong Song
 <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>, Hao Luo
 <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Alan Maguire <alan.maguire@oracle.com>, David Laight
 <David.Laight@ACULAB.COM>, Thomas =?UTF-8?B?V2Vpw59zY2h1aA==?=
 <thomas@t-8ch.de>, Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCHv6 perf/core 09/22] uprobes/x86: Add uprobe syscall to
 speed up uprobe
Message-Id: <20250725191143.fabe4f33abf0856780ec1f0e@kernel.org>
In-Reply-To: <20250720112133.244369-10-jolsa@kernel.org>
References: <20250720112133.244369-1-jolsa@kernel.org>
	<20250720112133.244369-10-jolsa@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 20 Jul 2025 13:21:19 +0200
Jiri Olsa <jolsa@kernel.org> wrote:

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
> The uprobe syscall ensures the consumer (bpf program) sees registers
> values in the state before the trampoline was called.
> 

Looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks!

> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  arch/x86/entry/syscalls/syscall_64.tbl |   1 +
>  arch/x86/kernel/uprobes.c              | 139 +++++++++++++++++++++++++
>  include/linux/syscalls.h               |   2 +
>  include/linux/uprobes.h                |   1 +
>  kernel/events/uprobes.c                |  17 +++
>  kernel/sys_ni.c                        |   1 +
>  6 files changed, 161 insertions(+)
> 
> diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
> index cfb5ca41e30d..9fd1291e7bdf 100644
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
> index 6c4dcbdd0c3c..d18e1ae59901 100644
> --- a/arch/x86/kernel/uprobes.c
> +++ b/arch/x86/kernel/uprobes.c
> @@ -752,6 +752,145 @@ void arch_uprobe_clear_state(struct mm_struct *mm)
>  	hlist_for_each_entry_safe(tramp, n, &state->head_tramps, node)
>  		destroy_uprobe_trampoline(tramp);
>  }
> +
> +static bool __in_uprobe_trampoline(unsigned long ip)
> +{
> +	struct vm_area_struct *vma = vma_lookup(current->mm, ip);
> +
> +	return vma && vma_is_special_mapping(vma, &tramp_mapping);
> +}
> +
> +static bool in_uprobe_trampoline(unsigned long ip)
> +{
> +	struct mm_struct *mm = current->mm;
> +	bool found, retry = true;
> +	unsigned int seq;
> +
> +	rcu_read_lock();
> +	if (mmap_lock_speculate_try_begin(mm, &seq)) {
> +		found = __in_uprobe_trampoline(ip);
> +		retry = mmap_lock_speculate_retry(mm, seq);
> +	}
> +	rcu_read_unlock();
> +
> +	if (retry) {
> +		mmap_read_lock(mm);
> +		found = __in_uprobe_trampoline(ip);
> +		mmap_read_unlock(mm);
> +	}
> +	return found;
> +}
> +
> +/*
> + * See uprobe syscall trampoline; the call to the trampoline will push
> + * the return address on the stack, the trampoline itself then pushes
> + * cx, r11 and ax.
> + */
> +struct uprobe_syscall_args {
> +	unsigned long ax;
> +	unsigned long r11;
> +	unsigned long cx;
> +	unsigned long retaddr;
> +};
> +
> +SYSCALL_DEFINE0(uprobe)
> +{
> +	struct pt_regs *regs = task_pt_regs(current);
> +	struct uprobe_syscall_args args;
> +	unsigned long ip, sp;
> +	int err;
> +
> +	/* Allow execution only from uprobe trampolines. */
> +	if (!in_uprobe_trampoline(regs->ip))
> +		goto sigill;
> +
> +	err = copy_from_user(&args, (void __user *)regs->sp, sizeof(args));
> +	if (err)
> +		goto sigill;
> +
> +	ip = regs->ip;
> +
> +	/*
> +	 * expose the "right" values of ax/r11/cx/ip/sp to uprobe_consumer/s, plus:
> +	 * - adjust ip to the probe address, call saved next instruction address
> +	 * - adjust sp to the probe's stack frame (check trampoline code)
> +	 */
> +	regs->ax  = args.ax;
> +	regs->r11 = args.r11;
> +	regs->cx  = args.cx;
> +	regs->ip  = args.retaddr - 5;
> +	regs->sp += sizeof(args);
> +	regs->orig_ax = -1;
> +
> +	sp = regs->sp;
> +
> +	handle_syscall_uprobe(regs, regs->ip);
> +
> +	/*
> +	 * Some of the uprobe consumers has changed sp, we can do nothing,
> +	 * just return via iret.
> +	 */
> +	if (regs->sp != sp) {
> +		/* skip the trampoline call */
> +		if (args.retaddr - 5 == regs->ip)
> +			regs->ip += 5;
> +		return regs->ax;
> +	}
> +
> +	regs->sp -= sizeof(args);
> +
> +	/* for the case uprobe_consumer has changed ax/r11/cx */
> +	args.ax  = regs->ax;
> +	args.r11 = regs->r11;
> +	args.cx  = regs->cx;
> +
> +	/* keep return address unless we are instructed otherwise */
> +	if (args.retaddr - 5 != regs->ip)
> +		args.retaddr = regs->ip;
> +
> +	regs->ip = ip;
> +
> +	err = copy_to_user((void __user *)regs->sp, &args, sizeof(args));
> +	if (err)
> +		goto sigill;
> +
> +	/* ensure sysret, see do_syscall_64() */
> +	regs->r11 = regs->flags;
> +	regs->cx  = regs->ip;
> +	return 0;
> +
> +sigill:
> +	force_sig(SIGILL);
> +	return -1;
> +}
> +
> +asm (
> +	".pushsection .rodata\n"
> +	".balign " __stringify(PAGE_SIZE) "\n"
> +	"uprobe_trampoline_entry:\n"
> +	"push %rcx\n"
> +	"push %r11\n"
> +	"push %rax\n"
> +	"movq $" __stringify(__NR_uprobe) ", %rax\n"
> +	"syscall\n"
> +	"pop %rax\n"
> +	"pop %r11\n"
> +	"pop %rcx\n"
> +	"ret\n"
> +	".balign " __stringify(PAGE_SIZE) "\n"
> +	".popsection\n"
> +);
> +
> +extern u8 uprobe_trampoline_entry[];
> +
> +static int __init arch_uprobes_init(void)
> +{
> +	tramp_mapping_pages[0] = virt_to_page(uprobe_trampoline_entry);
> +	return 0;
> +}
> +
> +late_initcall(arch_uprobes_init);
> +
>  #else /* 32-bit: */
>  /*
>   * No RIP-relative addressing on 32-bit
> diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
> index e5603cc91963..b0cc60f1c458 100644
> --- a/include/linux/syscalls.h
> +++ b/include/linux/syscalls.h
> @@ -998,6 +998,8 @@ asmlinkage long sys_ioperm(unsigned long from, unsigned long num, int on);
>  
>  asmlinkage long sys_uretprobe(void);
>  
> +asmlinkage long sys_uprobe(void);
> +
>  /* pciconfig: alpha, arm, arm64, ia64, sparc */
>  asmlinkage long sys_pciconfig_read(unsigned long bus, unsigned long dfn,
>  				unsigned long off, unsigned long len,
> diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
> index b40d33aae016..b6b077cc7d0f 100644
> --- a/include/linux/uprobes.h
> +++ b/include/linux/uprobes.h
> @@ -239,6 +239,7 @@ extern unsigned long uprobe_get_trampoline_vaddr(void);
>  extern void uprobe_copy_from_page(struct page *page, unsigned long vaddr, void *dst, int len);
>  extern void arch_uprobe_clear_state(struct mm_struct *mm);
>  extern void arch_uprobe_init_state(struct mm_struct *mm);
> +extern void handle_syscall_uprobe(struct pt_regs *regs, unsigned long bp_vaddr);
>  #else /* !CONFIG_UPROBES */
>  struct uprobes_state {
>  };
> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index acec91a676b7..cbba31c0495f 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -2772,6 +2772,23 @@ static void handle_swbp(struct pt_regs *regs)
>  	rcu_read_unlock_trace();
>  }
>  
> +void handle_syscall_uprobe(struct pt_regs *regs, unsigned long bp_vaddr)
> +{
> +	struct uprobe *uprobe;
> +	int is_swbp;
> +
> +	guard(rcu_tasks_trace)();
> +
> +	uprobe = find_active_uprobe_rcu(bp_vaddr, &is_swbp);
> +	if (!uprobe)
> +		return;
> +	if (!get_utask())
> +		return;
> +	if (arch_uprobe_ignore(&uprobe->arch, regs))
> +		return;
> +	handler_chain(uprobe, regs);
> +}
> +
>  /*
>   * Perform required fix-ups and disable singlestep.
>   * Allow pending signals to take effect.
> diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
> index c00a86931f8c..bf5d05c635ff 100644
> --- a/kernel/sys_ni.c
> +++ b/kernel/sys_ni.c
> @@ -392,3 +392,4 @@ COND_SYSCALL(setuid16);
>  COND_SYSCALL(rseq);
>  
>  COND_SYSCALL(uretprobe);
> +COND_SYSCALL(uprobe);
> -- 
> 2.50.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

