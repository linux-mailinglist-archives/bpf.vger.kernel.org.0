Return-Path: <bpf+bounces-48748-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 324A1A10395
	for <lists+bpf@lfdr.de>; Tue, 14 Jan 2025 11:05:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EC9E18894D3
	for <lists+bpf@lfdr.de>; Tue, 14 Jan 2025 10:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF0621CBE95;
	Tue, 14 Jan 2025 10:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W7O7f9YM"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F981ADC7E;
	Tue, 14 Jan 2025 10:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736849126; cv=none; b=BwGBiXhja/iQ9Nzhse7sQho8bX36S9tzU7qBETaRV9aiWEgjibAFseAfP+nQ2To8SlFFhjuWoXHNh57VVjOgczbTFRDLAQOp1GeL2s5fmfJw7hu5nZYCXqnd31cu0VG8RwKJCijD1UVR7XjsLvZ01mPjLF6xcjpbtAxb6Li0LLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736849126; c=relaxed/simple;
	bh=ljvr730by3N+ahLejFsaDgo0llRk/pJOnSiC16km6wY=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=JCw4R2j8ETMf1FUUxdvY7Fo8WzeeCZbGFNXTZOFw2m/BaEBviZPwAm976DGf7hOWgWZNzulY71/XWGqavSHGmm0oGGMOffEjYi1GN52vVRGa2X08oRGH9FXDCVokbfzAdqARCGk1Zm0WSmDRhX0jS+KB8+VsKtK7JyMPB0hXA/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W7O7f9YM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01004C4CEDD;
	Tue, 14 Jan 2025 10:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736849125;
	bh=ljvr730by3N+ahLejFsaDgo0llRk/pJOnSiC16km6wY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=W7O7f9YMDBvk+fu6sw+Pds4mBLwx5TYOlI/Lw6HCQG6DguARqVFRXLgUN3+x5OxqL
	 7knF4R0wPhxlByTmsOnP1AVkuLBv/RbN9dFKsNpMWyXeDhC93Xmmtl2OGFdNqazArj
	 3QP5UZDnWgo3gwMa8bA2BMLbHqkKr9lZb5dKnpQRvQ4FgjciL44nL8LWYBAJCGVWe/
	 c2mOh8O30zDBe/zQNbTpGIe5uc/Qzke4WLD0EOpqYpZuWXcLIugrHOTY1xv+mrxxiU
	 6J2k87B9F3bLIEfO+D0jLAy5acmXN5Tdsg5JNb7hYNeViYIkKwMD2VgidVtJwkkWlC
	 qh79VI1lttl5Q==
Date: Tue, 14 Jan 2025 19:05:21 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: oleg@redhat.com, Aleksa Sarai <cyphar@cyphar.com>, Eyal Birger
 <eyal.birger@gmail.com>, mhiramat@kernel.org, linux-kernel
 <linux-kernel@vger.kernel.org>, linux-trace-kernel@vger.kernel.org,
 BPF-dev-list <bpf@vger.kernel.org>, Song Liu <songliubraving@fb.com>,
 Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>,
 peterz@infradead.org, tglx@linutronix.de, bp@alien8.de, x86@kernel.org,
 linux-api@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii.nakryiko@gmail.com>, "rostedt@goodmis.org"
 <rostedt@goodmis.org>, rafi@rbk.io, Shmulik Ladkani
 <shmulik.ladkani@gmail.com>
Subject: Re: Crash when attaching uretprobes to processes running in Docker
Message-Id: <20250114190521.0b69a1af64cac41106101154@kernel.org>
In-Reply-To: <Z4YszJfOvFEAaKjF@krava>
References: <CAHsH6Gs3Eh8DFU0wq58c_LF8A4_+o6z456J7BidmcVY2AqOnHQ@mail.gmail.com>
	<20250110.152323-sassy.torch.lavish.rent-vKX3ul5B3qyi@cyphar.com>
	<Z4K7D10rjuVeRCKq@krava>
	<Z4YszJfOvFEAaKjF@krava>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 14 Jan 2025 10:22:20 +0100
Jiri Olsa <olsajiri@gmail.com> wrote:

> On Sat, Jan 11, 2025 at 07:40:15PM +0100, Jiri Olsa wrote:
> > On Sat, Jan 11, 2025 at 02:25:37AM +1100, Aleksa Sarai wrote:
> > > On 2025-01-10, Eyal Birger <eyal.birger@gmail.com> wrote:
> > > > Hi,
> > > > 
> > > > When attaching uretprobes to processes running inside docker, the attached
> > > > process is segfaulted when encountering the retprobe. The offending commit
> > > > is:
> > > > 
> > > > ff474a78cef5 ("uprobe: Add uretprobe syscall to speed up return probe")
> > > > 
> > > > To my understanding, the reason is that now that uretprobe is a system call,
> > > > the default seccomp filters in docker block it as they only allow a specific
> > > > set of known syscalls.
> > > 
> > > FWIW, the default seccomp profile of Docker _should_ return -ENOSYS for
> > > uretprobe (runc has a bunch of ugly logic to try to guarantee this if
> > > Docker hasn't updated their profile to include it). Though I guess that
> > > isn't sufficient for the magic that uretprobe(2) does...
> > > 
> > > > This behavior can be reproduced by the below bash script, which works before
> > > > this commit.
> > > > 
> > > > Reported-by: Rafael Buchbinder <rafi@rbk.io>
> > 
> > hi,
> > nice ;-) thanks for the report, the problem seems to be that uretprobe syscall
> > is blocked and uretprobe trampoline does not expect that
> > 
> > I think we could add code to the uretprobe trampoline to detect this and
> > execute standard int3 as fallback to process uretprobe, I'm checking on that
> 
> hack below seems to fix the issue, it's using rbx to signal that uretprobe
> syscall got executed, if not, trampoline does int3 and executes uretprobe
> handler in the old way
> 
> unfortunately now the uretprobe trampoline size crosses the xol slot limit so
> will need to come up with some generic/arch code solution for that, code below
> is neglecting that for now
> 
> jirka
> 
> 
> ---
>  arch/x86/kernel/uprobes.c | 24 ++++++++++++++++++++++++
>  include/linux/uprobes.h   |  1 +
>  kernel/events/uprobes.c   | 10 ++++++++--
>  3 files changed, 33 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
> index 5a952c5ea66b..b54863f6fa25 100644
> --- a/arch/x86/kernel/uprobes.c
> +++ b/arch/x86/kernel/uprobes.c
> @@ -315,14 +315,25 @@ asm (
>  	".global uretprobe_trampoline_entry\n"
>  	"uretprobe_trampoline_entry:\n"
>  	"pushq %rax\n"
> +	"pushq %rbx\n"
>  	"pushq %rcx\n"
>  	"pushq %r11\n"
> +	"movq $1, %rbx\n"
>  	"movq $" __stringify(__NR_uretprobe) ", %rax\n"
>  	"syscall\n"
>  	".global uretprobe_syscall_check\n"
>  	"uretprobe_syscall_check:\n"
> +	"or %rbx,%rbx\n"
> +	"jz uretprobe_syscall_return\n"
>  	"popq %r11\n"
>  	"popq %rcx\n"
> +	"popq %rbx\n"
> +	"popq %rax\n"
> +	"int3\n"
> +	"uretprobe_syscall_return:\n"
> +	"popq %r11\n"
> +	"popq %rcx\n"
> +	"popq %rbx\n"
>  
>  	/* The uretprobe syscall replaces stored %rax value with final
>  	 * return address, so we don't restore %rax in here and just
> @@ -338,6 +349,16 @@ extern u8 uretprobe_trampoline_entry[];
>  extern u8 uretprobe_trampoline_end[];
>  extern u8 uretprobe_syscall_check[];
>  
> +#define UINSNS_PER_PAGE                 (PAGE_SIZE/UPROBE_XOL_SLOT_BYTES)
> +
> +bool arch_is_uretprobe_trampoline(unsigned long vaddr)
> +{
> +	unsigned long start = uprobe_get_trampoline_vaddr();
> +	unsigned long end = start + 2*UINSNS_PER_PAGE;
> +
> +	return vaddr >= start && vaddr < end;
> +}
> +
>  void *arch_uprobe_trampoline(unsigned long *psize)
>  {
>  	static uprobe_opcode_t insn = UPROBE_SWBP_INSN;
> @@ -418,6 +439,9 @@ SYSCALL_DEFINE0(uretprobe)
>  	regs->r11 = regs->flags;
>  	regs->cx  = regs->ip;
>  
> +	/* zero rbx to signal trampoline that uretprobe syscall was executed */
> +	regs->bx  = 0;

Can we just return -ENOSYS as like as other syscall instead of
using rbx as a side channel?
We can carefully check the return address is not -ERRNO when set up
and reserve the -ENOSYS for this use case.

Thank you,

> +
>  	return regs->ax;
>  
>  sigill:
> diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
> index e0a4c2082245..dbde57a68a1b 100644
> --- a/include/linux/uprobes.h
> +++ b/include/linux/uprobes.h
> @@ -213,6 +213,7 @@ extern void arch_uprobe_copy_ixol(struct page *page, unsigned long vaddr,
>  extern void uprobe_handle_trampoline(struct pt_regs *regs);
>  extern void *arch_uprobe_trampoline(unsigned long *psize);
>  extern unsigned long uprobe_get_trampoline_vaddr(void);
> +bool arch_is_uretprobe_trampoline(unsigned long vaddr);
>  #else /* !CONFIG_UPROBES */
>  struct uprobes_state {
>  };
> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index fa04b14a7d72..73df64109f38 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -1703,6 +1703,11 @@ void * __weak arch_uprobe_trampoline(unsigned long *psize)
>  	return &insn;
>  }
>  
> +bool __weak arch_is_uretprobe_trampoline(unsigned long vaddr)
> +{
> +	return vaddr == uprobe_get_trampoline_vaddr();
> +}
> +
>  static struct xol_area *__create_xol_area(unsigned long vaddr)
>  {
>  	struct mm_struct *mm = current->mm;
> @@ -1725,8 +1730,9 @@ static struct xol_area *__create_xol_area(unsigned long vaddr)
>  
>  	area->vaddr = vaddr;
>  	init_waitqueue_head(&area->wq);
> -	/* Reserve the 1st slot for get_trampoline_vaddr() */
> +	/* Reserve the first two slots for get_trampoline_vaddr() */
>  	set_bit(0, area->bitmap);
> +	set_bit(1, area->bitmap);
>  	insns = arch_uprobe_trampoline(&insns_size);
>  	arch_uprobe_copy_ixol(area->page, 0, insns, insns_size);
>  
> @@ -2536,7 +2542,7 @@ static void handle_swbp(struct pt_regs *regs)
>  	int is_swbp;
>  
>  	bp_vaddr = uprobe_get_swbp_addr(regs);
> -	if (bp_vaddr == uprobe_get_trampoline_vaddr())
> +	if (arch_is_uretprobe_trampoline(bp_vaddr))
>  		return uprobe_handle_trampoline(regs);
>  
>  	rcu_read_lock_trace();
> -- 
> 2.47.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

