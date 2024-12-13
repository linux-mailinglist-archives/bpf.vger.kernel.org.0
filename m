Return-Path: <bpf+bounces-46861-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E48989F1086
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 16:13:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C243C161BFE
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 15:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F4471E2009;
	Fri, 13 Dec 2024 15:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=t-8ch.de header.i=@t-8ch.de header.b="cO7j+Caj"
X-Original-To: bpf@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8670D1E1020;
	Fri, 13 Dec 2024 15:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734102771; cv=none; b=ttiChfxqdrdjVOLxyIjdzRzfRg7MO9H2iCVTNhLbAfo9x6t9g88emr7SJMVFd3fFaa6Ii6j5O7kHeeYgcXlAt/GYRw5bdhIq/eTPgLjqkIvWuaufakMK6eQwll7bMS71D2vAPxQhd2FlEfzNUdWQJT9VNLdfcmi8s1AjqxTJ2FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734102771; c=relaxed/simple;
	bh=qVYvnYFhoLLElIWOA2sxrcleLheNl7P1Bvsm9vcs7/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mxj8n7gBy9e0RvuQcqRBbRGQtHtWrqqjMTHI9LerOAwnihFsePacIeapKLZ3byxF8yVYvqcX89KLeYihrAvXxlMIMjHHt8kE9b2s2GXol5I4fCEJQjmahJPZ5Rb92+tLhqVM5MZBUf/bFqGzOyw5Ut03S6f1RKho6KQhxhmUbqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=t-8ch.de; spf=pass smtp.mailfrom=t-8ch.de; dkim=pass (1024-bit key) header.d=t-8ch.de header.i=@t-8ch.de header.b=cO7j+Caj; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=t-8ch.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-8ch.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
	t=1734102766; bh=qVYvnYFhoLLElIWOA2sxrcleLheNl7P1Bvsm9vcs7/0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cO7j+CajBcm/XvkZwZ9CTdbPcVaqtSqYQrXyvbY/rUTjMElW0d0ckntB2D1nhQkUo
	 zGPvpAV122qMB/JiEfPBhmkxvhoDIwdSYIlZJvP8xUkWcW+CY6ETKS0okGZvkTO7oQ
	 o14P+OOg3aHB2n86KtBYcETNy8ArvBGLVjQFRfzg=
Date: Fri, 13 Dec 2024 16:12:46 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, Song Liu <songliubraving@fb.com>, 
	Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>, 
	Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Alan Maguire <alan.maguire@oracle.com>, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next 06/13] uprobes/x86: Add uprobe syscall to speed
 up uprobe
Message-ID: <bd095061-f43b-4b99-bb94-40cdeac76f4c@t-8ch.de>
References: <20241211133403.208920-1-jolsa@kernel.org>
 <20241211133403.208920-7-jolsa@kernel.org>
 <66e85401-b2ec-442d-bebe-c4ff3151e7e2@t-8ch.de>
 <Z1xKAKnX3su21JZu@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z1xKAKnX3su21JZu@krava>

On 2024-12-13 15:51:44+0100, Jiri Olsa wrote:
> On Fri, Dec 13, 2024 at 02:48:00PM +0100, Thomas Weißschuh wrote:
> 
> SNIP
> 
> > > +static int tramp_mremap(const struct vm_special_mapping *sm, struct vm_area_struct *new_vma)
> > > +{
> > > +	return -EPERM;
> > > +}
> > > +
> > > +static struct vm_special_mapping tramp_mapping = {
> > > +	.name   = "[uprobes-trampoline]",
> > > +	.mremap = tramp_mremap,
> > > +};
> > > +
> > > +SYSCALL_DEFINE0(uprobe)
> > > +{
> > > +	struct pt_regs *regs = task_pt_regs(current);
> > > +	struct vm_area_struct *vma;
> > > +	unsigned long bp_vaddr;
> > > +	int err;
> > > +
> > > +	err = copy_from_user(&bp_vaddr, (void __user *)regs->sp + 3*8, sizeof(bp_vaddr));
> > 
> > A #define for the magic values would be nice.
> 
> the 3*8 is to skip 3 values pushed on stack and get the return ip value,
> I'd prefer to keep 3*8 but it's definitely missing explaining comment
> above, wdyt?

A comment sounds good.

> > > +	if (err) {
> > > +		force_sig(SIGILL);
> > > +		return -1;
> > > +	}
> > > +
> > > +	/* Allow execution only from uprobe trampolines. */
> > > +	vma = vma_lookup(current->mm, regs->ip);
> > > +	if (!vma || vma->vm_private_data != (void *) &tramp_mapping) {
> > 
> > vma_is_special_mapping()
> 
> did not know about this function, thanks
> 
> > 
> > > +		force_sig(SIGILL);
> > > +		return -1;
> > > +	}
> > > +
> > > +	handle_syscall_uprobe(regs, bp_vaddr - 5);
> > > +	return 0;
> > > +}
> > > +
> > > +asm (
> > > +	".pushsection .rodata\n"
> > > +	".global uprobe_trampoline_entry\n"
> > > +	"uprobe_trampoline_entry:\n"
> > > +	"endbr64\n"
> > > +	"push %rcx\n"
> > > +	"push %r11\n"
> > > +	"push %rax\n"
> > > +	"movq $" __stringify(__NR_uprobe) ", %rax\n"
> > > +	"syscall\n"
> > > +	"pop %rax\n"
> > > +	"pop %r11\n"
> > > +	"pop %rcx\n"
> > > +	"ret\n"
> > > +	".global uprobe_trampoline_end\n"
> > > +	"uprobe_trampoline_end:\n"
> > > +	".popsection\n"
> > > +);
> > > +
> > > +extern __visible u8 uprobe_trampoline_entry[];
> > > +extern __visible u8 uprobe_trampoline_end[];
> > > +
> > > +const struct vm_special_mapping *arch_uprobe_trampoline_mapping(void)
> > > +{
> > > +	struct pt_regs *regs = task_pt_regs(current);
> > > +
> > > +	return user_64bit_mode(regs) ? &tramp_mapping : NULL;
> > > +}
> > > +
> > > +static int __init arch_uprobes_init(void)
> > > +{
> > > +	unsigned long size = uprobe_trampoline_end - uprobe_trampoline_entry;
> > > +	static struct page *pages[2];
> > > +	struct page *page;
> > > +
> > > +	page = alloc_page(GFP_HIGHUSER);
> > 
> > That page could be in static memory, removing the need for the explicit
> > allocation. It could also be __ro_after_init.
> > Then tramp_mapping itself can be const.
> 
> hum, how would that look like? I think that to get proper page object
> you have to call alloc_page or some other page alloc family function..
> what do I miss?

static u8 trampoline_page[PAGE_SIZE] __ro_after_init __aligned(PAGE_SIZE);
static struct page *tramp_mapping_pages[2] __ro_after_init;

static const struct vm_special_mapping tramp_mapping = {
	.name   = "[uprobes-trampoline]",
	.pages  = tramp_mapping_pages,
	.mremap = tramp_mremap,
};

static int __init arch_uprobes_init(void)
{
	...
	trampoline_pages[0] = virt_to_page(trampoline_page);
	...
}

Untested, but it's similar to the stuff the vDSO implementations are
doing which I am working with at the moment.

> > 
> > Also this seems to waste the page on 32bit kernels.
> 
> it's inside CONFIG_X86_64 ifdef
> 
> > 
> > > +	if (!page)
> > > +		return -ENOMEM;
> > > +	pages[0] = page;
> > > +	tramp_mapping.pages = (struct page **) &pages;
> > 
> > tramp_mapping.pages = pages; ?
> 
> I think the compiler will cry about *pages[2] vs **pages types mismatch,
> but I'll double check that

It compiles for me.

> thanks,
> jirka
> 
> > 
> > > +	arch_uprobe_copy_ixol(page, 0, uprobe_trampoline_entry, size);
> > > +	return 0;
> > > +}
> > > +
> > > +late_initcall(arch_uprobes_init);
> > > +
> > >  /*
> > >   * If arch_uprobe->insn doesn't use rip-relative addressing, return
> > >   * immediately.  Otherwise, rewrite the instruction so that it accesses
> > 
> > [..]

