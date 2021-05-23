Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F0BD38DB66
	for <lists+bpf@lfdr.de>; Sun, 23 May 2021 16:22:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231769AbhEWOXi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 23 May 2021 10:23:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:47532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231764AbhEWOXh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 23 May 2021 10:23:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 85EC661028;
        Sun, 23 May 2021 14:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621779730;
        bh=GhG1LHVMggFbZzoW5Oy3ojkGnnK8OGVIOTqgpYYrXp4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Sx/v+USoPDvDsA/womEcT1YhZ/n8f82vA+qGROqHIJW5gCu6DLCK9KHHLNhsh1wzf
         9uo/BuvncCs6D0UeFDXJeBmeptjdJ6XVM/nYMvj0ROwIQFOFOuHS1C2ZOhAEGZqC5W
         sQoer3wVig8vEF+jstNxxtZsCTmzExF+PQK7r9MV1ucDkbKHeieXUGnraHZVJJJ/66
         mgcrNeITzNzv585RS6Psu4D0+925DYhV8pPRXYktkVBqNEY6yyvjNbFuWKWrTf92H8
         9LTB1pAI2ETAqegzUwQfazBXnlKUszuIl3NLCqIGGNeO7++gkJe8tYVzcW3qT6xe6e
         4wzx9HL9IFFNw==
Date:   Sun, 23 May 2021 23:22:04 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>, X86 ML <x86@kernel.org>,
        Daniel Xu <dxu@dxuuu.xyz>,
        open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kernel Team <kernel-team@fb.com>, Yonghong Song <yhs@fb.com>
Subject: Re: [PATCH -tip v2 00/10] kprobes: Fix stacktrace with kretprobes
Message-Id: <20210523232204.d6f2f2c03f1d26fec5d83618@kernel.org>
In-Reply-To: <CAEf4Bzb46223OxVJeydhhKJVLbWjWiAEXbFZ7yb7=R3D_1y0vQ@mail.gmail.com>
References: <161553130371.1038734.7661319550287837734.stgit@devnote2>
        <20210316023003.xbmgce3ndkouu65e@treble>
        <20210316153022.70cc181a2b3e0f73923e54da@kernel.org>
        <CAEf4Bzb46223OxVJeydhhKJVLbWjWiAEXbFZ7yb7=R3D_1y0vQ@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 17 May 2021 14:06:24 -0700
Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:

> On Tue, Mar 16, 2021 at 1:45 AM Masami Hiramatsu <mhiramat@kernel.org> wrote:
> >
> > On Mon, 15 Mar 2021 21:30:03 -0500
> > Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> >
> > > On Fri, Mar 12, 2021 at 03:41:44PM +0900, Masami Hiramatsu wrote:
> > > > Hello,
> > > >
> > > > Here is the 2nd version of the series to fix the stacktrace with kretprobe.
> > > >
> > > > The 1st series is here;
> > > >
> > > > https://lore.kernel.org/bpf/161495873696.346821.10161501768906432924.stgit@devnote2/
> > > >
> > > > In this version I merged the ORC unwinder fix for kretprobe which discussed in the
> > > > previous thread. [3/10] is updated according to the Miroslav's comment. [4/10] is
> > > > updated for simplify the code. [5/10]-[9/10] are discussed in the previsous tread
> > > > and are introduced to the series.
> > > >
> > > > Daniel, can you also test this again? I and Josh discussed a bit different
> > > > method and I've implemented it on this version.
> > > >
> > > > This actually changes the kretprobe behavisor a bit, now the instraction pointer in
> > > > the pt_regs passed to kretprobe user handler is correctly set the real return
> > > > address. So user handlers can get it via instruction_pointer() API.
> > >
> > > When I add WARN_ON(1) to a test kretprobe, it doesn't unwind properly.
> > >
> > > show_trace_log_lvl() reads the entire stack in lockstep with calls to
> > > the unwinder so that it can decide which addresses get prefixed with
> > > '?'.  So it expects to find an actual return address on the stack.
> > > Instead it finds %rsp.  So it never syncs up with unwind_next_frame()
> > > and shows all remaining addresses as unreliable.
> > >
> > >   Call Trace:
> > >    __kretprobe_trampoline_handler+0xca/0x1a0
> > >    trampoline_handler+0x3d/0x50
> > >    kretprobe_trampoline+0x25/0x50
> > >    ? init_test_probes.cold+0x323/0x387
> > >    ? init_kprobes+0x144/0x14c
> > >    ? init_optprobes+0x15/0x15
> > >    ? do_one_initcall+0x5b/0x300
> > >    ? lock_is_held_type+0xe8/0x140
> > >    ? kernel_init_freeable+0x174/0x2cd
> > >    ? rest_init+0x233/0x233
> > >    ? kernel_init+0xa/0x11d
> > >    ? ret_from_fork+0x22/0x30
> > >
> > > How about pushing 'kretprobe_trampoline' instead of %rsp for the return
> > > address placeholder.  That fixes the above test, and removes the need
> > > for the weird 'state->ip == sp' check:
> > >
> > >   Call Trace:
> > >    __kretprobe_trampoline_handler+0xca/0x150
> > >    trampoline_handler+0x3d/0x50
> > >    kretprobe_trampoline+0x29/0x50
> > >    ? init_test_probes.cold+0x323/0x387
> > >    elfcorehdr_read+0x10/0x10
> > >    init_kprobes+0x144/0x14c
> > >    ? init_optprobes+0x15/0x15
> > >    do_one_initcall+0x72/0x280
> > >    kernel_init_freeable+0x174/0x2cd
> > >    ? rest_init+0x122/0x122
> > >    kernel_init+0xa/0x10e
> > >    ret_from_fork+0x22/0x30
> > >
> > > Though, init_test_probes.cold() (the real return address) is still
> > > listed as unreliable.  Maybe we need a call to kretprobe_find_ret_addr()
> > > in show_trace_log_lvl(), similar to the ftrace_graph_ret_addr() call
> > > there.
> >
> > Thanks for the test!
> > OK, that could be acceptable. However, push %sp still needed for accessing
> > stack address from kretprobe handler via pt_regs. (regs->sp must point
> > the stack address)
> > Anyway, with int3, it pushes one more entry for emulating call, so I think
> > it is OK.
> > Let me update the series!
> >
> 
> Hi Misami,
> 
> Did you get a chance to follow up on this? I checked v5.13-rc1 and it
> still has this issue. Inability to capture a stack trace from BPF
> kretprobes is a pretty big problem for some applications, it would be
> great to get this fixed. Thanks!

OK, let me rework this series.

Thank you,


> 
> 
> > Thank you!
> >
> > >
> > >
> > >
> > > diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
> > > index 06f33bfebc50..70188fdd288e 100644
> > > --- a/arch/x86/kernel/kprobes/core.c
> > > +++ b/arch/x86/kernel/kprobes/core.c
> > > @@ -766,19 +766,19 @@ asm(
> > >       "kretprobe_trampoline:\n"
> > >       /* We don't bother saving the ss register */
> > >  #ifdef CONFIG_X86_64
> > > -     "       pushq %rsp\n"
> > > +     /* Push fake return address to tell the unwinder it's a kretprobe */
> > > +     "       pushq $kretprobe_trampoline\n"
> > >       UNWIND_HINT_FUNC
> > >       "       pushfq\n"
> > >       SAVE_REGS_STRING
> > >       "       movq %rsp, %rdi\n"
> > >       "       call trampoline_handler\n"
> > > -     /* Replace saved sp with true return address. */
> > > +     /* Replace the fake return address with the real one. */
> > >       "       movq %rax, 19*8(%rsp)\n"
> > >       RESTORE_REGS_STRING
> > >       "       popfq\n"
> > >  #else
> > >       "       pushl %esp\n"
> > > -     UNWIND_HINT_FUNC
> > >       "       pushfl\n"
> > >       SAVE_REGS_STRING
> > >       "       movl %esp, %eax\n"
> > > diff --git a/arch/x86/kernel/unwind_orc.c b/arch/x86/kernel/unwind_orc.c
> > > index 1d1b9388a1b1..1d3de84d2410 100644
> > > --- a/arch/x86/kernel/unwind_orc.c
> > > +++ b/arch/x86/kernel/unwind_orc.c
> > > @@ -548,8 +548,7 @@ bool unwind_next_frame(struct unwind_state *state)
> > >                * In those cases, find the correct return address from
> > >                * task->kretprobe_instances list.
> > >                */
> > > -             if (state->ip == sp ||
> > > -                 is_kretprobe_trampoline(state->ip))
> > > +             if (is_kretprobe_trampoline(state->ip))
> > >                       state->ip = kretprobe_find_ret_addr(state->task,
> > >                                                           &state->kr_iter);
> > >
> > >
> > >
> >
> >
> > --
> > Masami Hiramatsu <mhiramat@kernel.org>


-- 
Masami Hiramatsu <mhiramat@kernel.org>
