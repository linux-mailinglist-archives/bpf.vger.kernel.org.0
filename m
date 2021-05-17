Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F3E7386BEA
	for <lists+bpf@lfdr.de>; Mon, 17 May 2021 23:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244672AbhEQVHy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 17 May 2021 17:07:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234755AbhEQVHx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 17 May 2021 17:07:53 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABEC6C061573;
        Mon, 17 May 2021 14:06:36 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id y2so10349522ybq.13;
        Mon, 17 May 2021 14:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n9LsKY1zedoslunecTvjeVTawJ0hgALxwruYXA7spBE=;
        b=ulUPuOqrTC2RnCGM+MNJxYDKFjknHTa1H5jZ66skPsYf8TRVmeHsDTm3mhsRKtdtYY
         K2Djdnp+YGqcibOChJmmWb1EHPDuiz2U3Y9MKuMpxNOg5fnzQqLUQa3p7koo4B9KCCHc
         VW+vtjrDBlU16KJaBUL9Y7M1y/ZbGSiRDNuizm/Zm2TTiqtJ4k1hK4FxvngES2NlbF2o
         bSFuPYCOVvWnriJ0aF14NB0u7Y5fpHTSuzdYpkwxWRSIuQo97ma6VQEXHOxUOuuluCgz
         Sc+WJnRTJcDKlZVzjQcIpAOeOz2sQoGdIGfOJkUWL5aTlOkITxFsst3ahV5dz/SLjkqQ
         Oi+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n9LsKY1zedoslunecTvjeVTawJ0hgALxwruYXA7spBE=;
        b=S6El1iUk0YHLEmt/byP/rw/xkqg5mxCKckSWG8tfe/brNyXIn+mLNhF7cJcahAb0G3
         FoggcDP6nlQCeTYWnKo98RLHasAGpDVC3cgLH4khjDwsviFyqp9rTp7ttMBXhjPbMTBS
         YlbMGQq209Q3loP8VLfqURTXB+f/JlkiMHwDL22LwBz5aBRlsbfH4jfEbg6yXdV6MNr6
         Nkm+qJVYgbXz9bTVgua4RBN7/TCZCD7CFGv+o7LwBg/qIPdcw2JzkuVHANFMgUTgnsOE
         gxkASdp4LbWhq239+kVsgkb0RtD8Rq7/vv3DXAJS/rBof6A6HJBCbUnrl1hQ97Sp30LL
         h+Lw==
X-Gm-Message-State: AOAM533Z+0ejdx6VMTmoVOQhWupvs2/eSuL7pLRw+trdeh7BG9M7mr3/
        ZY829KRM/OfiFSDQke+wGEZQRTdbDKP4Y774Unc=
X-Google-Smtp-Source: ABdhPJzoK+1SJpFjn8M43vrQPb/LoNv+Jn4FnzG6Xot3IhPO0VJ0eSbQrUfAuBfLxaZVsb/5LjtiqMBJAO/efK79VGo=
X-Received: by 2002:a25:1455:: with SMTP id 82mr2596864ybu.403.1621285595761;
 Mon, 17 May 2021 14:06:35 -0700 (PDT)
MIME-Version: 1.0
References: <161553130371.1038734.7661319550287837734.stgit@devnote2>
 <20210316023003.xbmgce3ndkouu65e@treble> <20210316153022.70cc181a2b3e0f73923e54da@kernel.org>
In-Reply-To: <20210316153022.70cc181a2b3e0f73923e54da@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 17 May 2021 14:06:24 -0700
Message-ID: <CAEf4Bzb46223OxVJeydhhKJVLbWjWiAEXbFZ7yb7=R3D_1y0vQ@mail.gmail.com>
Subject: Re: [PATCH -tip v2 00/10] kprobes: Fix stacktrace with kretprobes
To:     Masami Hiramatsu <mhiramat@kernel.org>
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Mar 16, 2021 at 1:45 AM Masami Hiramatsu <mhiramat@kernel.org> wrote:
>
> On Mon, 15 Mar 2021 21:30:03 -0500
> Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
> > On Fri, Mar 12, 2021 at 03:41:44PM +0900, Masami Hiramatsu wrote:
> > > Hello,
> > >
> > > Here is the 2nd version of the series to fix the stacktrace with kretprobe.
> > >
> > > The 1st series is here;
> > >
> > > https://lore.kernel.org/bpf/161495873696.346821.10161501768906432924.stgit@devnote2/
> > >
> > > In this version I merged the ORC unwinder fix for kretprobe which discussed in the
> > > previous thread. [3/10] is updated according to the Miroslav's comment. [4/10] is
> > > updated for simplify the code. [5/10]-[9/10] are discussed in the previsous tread
> > > and are introduced to the series.
> > >
> > > Daniel, can you also test this again? I and Josh discussed a bit different
> > > method and I've implemented it on this version.
> > >
> > > This actually changes the kretprobe behavisor a bit, now the instraction pointer in
> > > the pt_regs passed to kretprobe user handler is correctly set the real return
> > > address. So user handlers can get it via instruction_pointer() API.
> >
> > When I add WARN_ON(1) to a test kretprobe, it doesn't unwind properly.
> >
> > show_trace_log_lvl() reads the entire stack in lockstep with calls to
> > the unwinder so that it can decide which addresses get prefixed with
> > '?'.  So it expects to find an actual return address on the stack.
> > Instead it finds %rsp.  So it never syncs up with unwind_next_frame()
> > and shows all remaining addresses as unreliable.
> >
> >   Call Trace:
> >    __kretprobe_trampoline_handler+0xca/0x1a0
> >    trampoline_handler+0x3d/0x50
> >    kretprobe_trampoline+0x25/0x50
> >    ? init_test_probes.cold+0x323/0x387
> >    ? init_kprobes+0x144/0x14c
> >    ? init_optprobes+0x15/0x15
> >    ? do_one_initcall+0x5b/0x300
> >    ? lock_is_held_type+0xe8/0x140
> >    ? kernel_init_freeable+0x174/0x2cd
> >    ? rest_init+0x233/0x233
> >    ? kernel_init+0xa/0x11d
> >    ? ret_from_fork+0x22/0x30
> >
> > How about pushing 'kretprobe_trampoline' instead of %rsp for the return
> > address placeholder.  That fixes the above test, and removes the need
> > for the weird 'state->ip == sp' check:
> >
> >   Call Trace:
> >    __kretprobe_trampoline_handler+0xca/0x150
> >    trampoline_handler+0x3d/0x50
> >    kretprobe_trampoline+0x29/0x50
> >    ? init_test_probes.cold+0x323/0x387
> >    elfcorehdr_read+0x10/0x10
> >    init_kprobes+0x144/0x14c
> >    ? init_optprobes+0x15/0x15
> >    do_one_initcall+0x72/0x280
> >    kernel_init_freeable+0x174/0x2cd
> >    ? rest_init+0x122/0x122
> >    kernel_init+0xa/0x10e
> >    ret_from_fork+0x22/0x30
> >
> > Though, init_test_probes.cold() (the real return address) is still
> > listed as unreliable.  Maybe we need a call to kretprobe_find_ret_addr()
> > in show_trace_log_lvl(), similar to the ftrace_graph_ret_addr() call
> > there.
>
> Thanks for the test!
> OK, that could be acceptable. However, push %sp still needed for accessing
> stack address from kretprobe handler via pt_regs. (regs->sp must point
> the stack address)
> Anyway, with int3, it pushes one more entry for emulating call, so I think
> it is OK.
> Let me update the series!
>

Hi Misami,

Did you get a chance to follow up on this? I checked v5.13-rc1 and it
still has this issue. Inability to capture a stack trace from BPF
kretprobes is a pretty big problem for some applications, it would be
great to get this fixed. Thanks!


> Thank you!
>
> >
> >
> >
> > diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
> > index 06f33bfebc50..70188fdd288e 100644
> > --- a/arch/x86/kernel/kprobes/core.c
> > +++ b/arch/x86/kernel/kprobes/core.c
> > @@ -766,19 +766,19 @@ asm(
> >       "kretprobe_trampoline:\n"
> >       /* We don't bother saving the ss register */
> >  #ifdef CONFIG_X86_64
> > -     "       pushq %rsp\n"
> > +     /* Push fake return address to tell the unwinder it's a kretprobe */
> > +     "       pushq $kretprobe_trampoline\n"
> >       UNWIND_HINT_FUNC
> >       "       pushfq\n"
> >       SAVE_REGS_STRING
> >       "       movq %rsp, %rdi\n"
> >       "       call trampoline_handler\n"
> > -     /* Replace saved sp with true return address. */
> > +     /* Replace the fake return address with the real one. */
> >       "       movq %rax, 19*8(%rsp)\n"
> >       RESTORE_REGS_STRING
> >       "       popfq\n"
> >  #else
> >       "       pushl %esp\n"
> > -     UNWIND_HINT_FUNC
> >       "       pushfl\n"
> >       SAVE_REGS_STRING
> >       "       movl %esp, %eax\n"
> > diff --git a/arch/x86/kernel/unwind_orc.c b/arch/x86/kernel/unwind_orc.c
> > index 1d1b9388a1b1..1d3de84d2410 100644
> > --- a/arch/x86/kernel/unwind_orc.c
> > +++ b/arch/x86/kernel/unwind_orc.c
> > @@ -548,8 +548,7 @@ bool unwind_next_frame(struct unwind_state *state)
> >                * In those cases, find the correct return address from
> >                * task->kretprobe_instances list.
> >                */
> > -             if (state->ip == sp ||
> > -                 is_kretprobe_trampoline(state->ip))
> > +             if (is_kretprobe_trampoline(state->ip))
> >                       state->ip = kretprobe_find_ret_addr(state->task,
> >                                                           &state->kr_iter);
> >
> >
> >
>
>
> --
> Masami Hiramatsu <mhiramat@kernel.org>
