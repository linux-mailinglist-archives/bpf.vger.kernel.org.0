Return-Path: <bpf+bounces-42117-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB17899FD6C
	for <lists+bpf@lfdr.de>; Wed, 16 Oct 2024 02:53:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF48B1C2230F
	for <lists+bpf@lfdr.de>; Wed, 16 Oct 2024 00:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ADA51F956;
	Wed, 16 Oct 2024 00:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q93vvCO3"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3DA713AF2;
	Wed, 16 Oct 2024 00:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729040009; cv=none; b=Gwpcd773+1CV2F4hGM2512PUg0mkIxANMB5WD9FCH8DLRb/7r+DqKYxILdgokdI/LGqZO0vbqymtpxCnAeQRhT5UhqrlVkxio1RaBZUR9KPYrSpq6J0AsfvkYAL2R5jGz/Lsv1HzFteNudB7KFMcc+4V0TTuJZWeoVWGTdanuPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729040009; c=relaxed/simple;
	bh=3Jw+/zXOc7n7uaOHukE6ywARpluWPCIQyRzKTeLkOZs=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Nl+EyLXZPxN5uIwzhACjTzEdDZuSVr440ZOaLLngcWXqWKIaXM8CzrXGoFjzG+87JWLYCzjYVQpxvXzZf+3+KHBYUSvIcqOGwOSFqosfYhGqtMl6cn0OijXx7Ukl0XUlw8XgBHWC0h0a0j+PrGr74WHnYhSVFJ4eSm0eFW5z3p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q93vvCO3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C25ACC4CEC6;
	Wed, 16 Oct 2024 00:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729040008;
	bh=3Jw+/zXOc7n7uaOHukE6ywARpluWPCIQyRzKTeLkOZs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Q93vvCO3saJSrY/00MBQfUj2NRcrZbCQkyC2GYeAgCw3fovaiDpWItogJyvnJGFsw
	 Fk1JjDsn5RZJNU752wwb9cRPvZWs00/lBewLtOm/lhK0Yjkym+HCyA5p019zJInPaf
	 CrRaK3ntJQrNn58iF/cGTTjqDZ/QiS5pdq5C7ARVsya2GVU5TmOMVMNZt+a1hNusCV
	 XSPcCKA9Vbfw/ikF8hkAtDRKOPK5WE4/pg2tIU5Hx+WsgJEFgg+iyrlv56U4qcIXXd
	 f+NWJUJ+owa98zfbocnr5AqFwpucE904h28BhhY0hxDM9jXiBJvfqs5PXTZ5GYdLmC
	 wi6z2+MgwV5rQ==
Date: Wed, 16 Oct 2024 09:53:24 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org,
 rostedt@goodmis.org, mhiramat@kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH RFC] rethook: inline arch_rethook_trampoline_callback()
 in assembly code
Message-Id: <20241016095324.6277c64a744af80c704c3636@kernel.org>
In-Reply-To: <CAEf4Bza9X_yp84ujDMwGengK1wTPjwZhtH7aXtPfXj6eT1M5Eg@mail.gmail.com>
References: <20240425000211.708557-1-andrii@kernel.org>
	<CAEf4Bza9X_yp84ujDMwGengK1wTPjwZhtH7aXtPfXj6eT1M5Eg@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Andrii,

Sorry I excavated this from patchwork.

On Mon, 29 Apr 2024 15:38:08 -0700
Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:

> On Wed, Apr 24, 2024 at 5:02 PM Andrii Nakryiko <andrii@kernel.org> wrote:
> >
> > At the lowest level, rethook-based kretprobes on x86-64 architecture go
> > through arch_rethoook_trampoline() function, manually written in
> > assembly, which calls into a simple arch_rethook_trampoline_callback()
> > function, written in C, and only doing a few straightforward field
> > assignments, before calling further into rethook_trampoline_handler(),
> > which handles kretprobe callbacks generically.
> >
> > Looking at simplicity of arch_rethook_trampoline_callback(), it seems
> > not really worthwhile to spend an extra function call just to do 4 or
> > 5 assignments. As such, this patch proposes to "inline"
> > arch_rethook_trampoline_callback() into arch_rethook_trampoline() by
> > manually implementing it in an assembly code.

Yeah, I think it is possible, but this makes code ugly, that is
trade-off. As you say, we should move this with other ugly inline
assembly code into kprobe.S or something like it. With my current
fprobe-on-fgraph, rethook is only required for kretprobes, so it
is natual and simple to have kprobe.S.

Thank you,

> >
> > This has two motivations. First, we do get a bit of runtime speed up by
> > avoiding function calls. Using BPF selftests's bench tool, we see
> > 0.6%-0.8% throughput improvement for kretprobe/multi-kretprobe
> > triggering code path:
> >
> > BEFORE (latest probes/for-next)
> > ===============================
> > kretprobe      :   10.455 ± 0.024M/s
> > kretprobe-multi:   11.150 ± 0.012M/s
> >
> > AFTER (probes/for-next + this patch)
> > ====================================
> > kretprobe      :   10.540 ± 0.009M/s (+0.8%)
> > kretprobe-multi:   11.219 ± 0.042M/s (+0.6%)
> >
> > Second, and no less importantly for some specialized use cases, this
> > avoids unnecessarily "polluting" LBR records with an extra function call
> > (recorded as a jump by CPU). This is the case for the retsnoop ([0])
> > tool, which relies havily on capturing LBR records to provide users with
> > lots of insight into kernel internals.
> >
> > This RFC patch is only inlining this function for x86-64, but it's
> > possible to do that for 32-bit x86 arch as well and then remove
> > arch_rethook_trampoline_callback() implementation altogether. Please let
> > me know if this change is acceptable and whether I should complete it
> > with 32-bit "inlining" as well. Thanks!
> >
> >   [0] https://nakryiko.com/posts/retsnoop-intro/#peering-deep-into-functions-with-lbr
> >
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> >  arch/x86/kernel/asm-offsets_64.c |  4 ++++
> >  arch/x86/kernel/rethook.c        | 37 +++++++++++++++++++++++++++-----
> >  2 files changed, 36 insertions(+), 5 deletions(-)
> >
> > diff --git a/arch/x86/kernel/asm-offsets_64.c b/arch/x86/kernel/asm-offsets_64.c
> > index bb65371ea9df..5c444abc540c 100644
> > --- a/arch/x86/kernel/asm-offsets_64.c
> > +++ b/arch/x86/kernel/asm-offsets_64.c
> > @@ -42,6 +42,10 @@ int main(void)
> >         ENTRY(r14);
> >         ENTRY(r15);
> >         ENTRY(flags);
> > +       ENTRY(ip);
> > +       ENTRY(cs);
> > +       ENTRY(ss);
> > +       ENTRY(orig_ax);
> >         BLANK();
> >  #undef ENTRY
> >
> > diff --git a/arch/x86/kernel/rethook.c b/arch/x86/kernel/rethook.c
> > index 8a1c0111ae79..3e1c01beebd1 100644
> > --- a/arch/x86/kernel/rethook.c
> > +++ b/arch/x86/kernel/rethook.c
> > @@ -6,6 +6,7 @@
> >  #include <linux/rethook.h>
> >  #include <linux/kprobes.h>
> >  #include <linux/objtool.h>
> > +#include <asm/asm-offsets.h>
> >
> >  #include "kprobes/common.h"
> >
> > @@ -34,10 +35,36 @@ asm(
> >         "       pushq %rsp\n"
> >         "       pushfq\n"
> >         SAVE_REGS_STRING
> > -       "       movq %rsp, %rdi\n"
> > -       "       call arch_rethook_trampoline_callback\n"
> > +       "       movq %rsp, %rdi\n" /* $rdi points to regs */
> > +       /* fixup registers */
> > +       /* regs->cs = __KERNEL_CS; */
> > +       "       movq $" __stringify(__KERNEL_CS) ", " __stringify(pt_regs_cs) "(%rdi)\n"
> > +       /* regs->ip = (unsigned long)&arch_rethook_trampoline; */
> > +       "       movq $arch_rethook_trampoline, " __stringify(pt_regs_ip) "(%rdi)\n"
> > +       /* regs->orig_ax = ~0UL; */
> > +       "       movq $0xffffffffffffffff, " __stringify(pt_regs_orig_ax) "(%rdi)\n"
> > +       /* regs->sp += 2*sizeof(long); */
> > +       "       addq $16, " __stringify(pt_regs_sp) "(%rdi)\n"
> > +       /* 2nd arg is frame_pointer = (long *)(regs + 1); */
> > +       "       lea " __stringify(PTREGS_SIZE) "(%rdi), %rsi\n"
> 
> BTW, all this __stringify() ugliness can be avoided if we move this
> assembly into its own .S file, like lots of other assembly functions
> in arch/x86/kernel subdir. That has another benefit of generating
> better line information in DWARF for those assembly instructions. It's
> lots more work, so before I do this, I'd like to get confirmation that
> this change is acceptable in principle.
> 
> > +       /*
> > +        * The return address at 'frame_pointer' is recovered by the
> > +        * arch_rethook_fixup_return() which called from this
> > +        * rethook_trampoline_handler().
> > +        */
> > +       "       call rethook_trampoline_handler\n"
> > +       /*
> > +        * Copy FLAGS to 'pt_regs::ss' so we can do RET right after POPF.
> > +        *
> > +        * We don't save/restore %rax below, because we ignore
> > +        * rethook_trampoline_handler result.
> > +        *
> > +        * *(unsigned long *)&regs->ss = regs->flags;
> > +        */
> > +       "       mov " __stringify(pt_regs_flags) "(%rsp), %rax\n"
> > +       "       mov %rax, " __stringify(pt_regs_ss) "(%rsp)\n"
> >         RESTORE_REGS_STRING
> > -       /* In the callback function, 'regs->flags' is copied to 'regs->ss'. */
> > +       /* We just copied 'regs->flags' into 'regs->ss'. */
> >         "       addq $16, %rsp\n"
> >         "       popfq\n"
> >  #else
> > @@ -61,6 +88,7 @@ asm(
> >  );
> >  NOKPROBE_SYMBOL(arch_rethook_trampoline);
> >
> > +#ifdef CONFIG_X86_32
> >  /*
> >   * Called from arch_rethook_trampoline
> >   */
> > @@ -70,9 +98,7 @@ __used __visible void arch_rethook_trampoline_callback(struct pt_regs *regs)
> >
> >         /* fixup registers */
> >         regs->cs = __KERNEL_CS;
> > -#ifdef CONFIG_X86_32
> >         regs->gs = 0;
> > -#endif
> >         regs->ip = (unsigned long)&arch_rethook_trampoline;
> >         regs->orig_ax = ~0UL;
> >         regs->sp += 2*sizeof(long);
> > @@ -92,6 +118,7 @@ __used __visible void arch_rethook_trampoline_callback(struct pt_regs *regs)
> >         *(unsigned long *)&regs->ss = regs->flags;
> >  }
> >  NOKPROBE_SYMBOL(arch_rethook_trampoline_callback);
> > +#endif
> >
> >  /*
> >   * arch_rethook_trampoline() skips updating frame pointer. The frame pointer
> > --
> > 2.43.0
> >


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

