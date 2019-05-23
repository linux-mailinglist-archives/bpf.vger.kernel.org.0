Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 946C9278ED
	for <lists+bpf@lfdr.de>; Thu, 23 May 2019 11:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730150AbfEWJLx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 May 2019 05:11:53 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:34142 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730019AbfEWJLx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 May 2019 05:11:53 -0400
Received: by mail-io1-f65.google.com with SMTP id g84so4281984ioa.1
        for <bpf@vger.kernel.org>; Thu, 23 May 2019 02:11:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l94qEbGUu044pj8ePeJNSLtLKPtD/xq4/ixhvT0dvQU=;
        b=bg/ctCY0dzuf6fUTZW5LCdkKQVn1ShDlaw88gSe1tPaLDEciVPJZokj5L/eWgxwmoa
         Vh0VkelK6HcMOuPQf7/F0cEa4tu5+gpwNv7Bbfqml7ck0Ren5MkxxGasO+OeZcPO8Vyc
         42dQisaoy9/xxe/adE8j+AhHZZ2wErWekhW1UrcVy597h/FOrt21cYspfDbmO0S+zh1l
         H5DijZaAwH7KH0x79BsNdZw3/w07+mXkVhihTvVdNONpfageXuXNPVtTpm0krXhw9mkY
         unl0tLSAxr7TMr0hMkYLW2IAxb/mgTBpIrohGHLKJok2jh/l+g7Qf2hgj+/OasZnmxS6
         WW+A==
X-Gm-Message-State: APjAAAXlrL3mfFR3Q/AR3YJzA8WidEI+Z/AHkUvRA5e+9GqdNf+1SYE8
        71UvEr2GqAcqdftpsodHVm0Z6l6Vxcia/7vTbDg9TA==
X-Google-Smtp-Source: APXvYqz6OBk8d9Pc/o7sPgASa/m9ruMzTpCwtM8dHMd3KeGfyuP94pfd4/zDDDlemoXBeAT+rFedrT7E8Cc5SmtmUYs=
X-Received: by 2002:a6b:7d0d:: with SMTP id c13mr11013930ioq.249.1558602712477;
 Thu, 23 May 2019 02:11:52 -0700 (PDT)
MIME-Version: 1.0
References: <3CD3EE63-0CD2-404A-A403-E11DCF2DF8D9@fb.com> <20190517074600.GJ2623@hirez.programming.kicks-ass.net>
 <20190517081057.GQ2650@hirez.programming.kicks-ass.net> <CACPcB9cB5n1HOmZcVpusJq8rAV5+KfmZ-Lxv3tgsSoy7vNrk7w@mail.gmail.com>
 <20190517091044.GM2606@hirez.programming.kicks-ass.net> <CACPcB9cpNp5CBqoRs+XMCwufzAFa8Pj-gbmj9fb+g5wVdue=ig@mail.gmail.com>
 <20190522140233.GC16275@worktop.programming.kicks-ass.net>
 <ab047883-69f6-1175-153f-5ad9462c6389@fb.com> <20190522174517.pbdopvookggen3d7@treble>
 <20190522234635.a47bettklcf5gt7c@treble> <CACPcB9dRJ89YAMDQdKoDMU=vFfpb5AaY0mWC_Xzw1ZMTFBf6ng@mail.gmail.com>
 <39AB1404-1C9A-43E9-A3EC-AED4AA26DC8C@fb.com>
In-Reply-To: <39AB1404-1C9A-43E9-A3EC-AED4AA26DC8C@fb.com>
From:   Kairui Song <kasong@redhat.com>
Date:   Thu, 23 May 2019 17:11:41 +0800
Message-ID: <CACPcB9e741AcyOyNOp7xuD-snq8bcaecn54w6wiFHs9nk4dKsg@mail.gmail.com>
Subject: Re: Getting empty callchain from perf_callchain_kernel()
To:     Song Liu <songliubraving@fb.com>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Alexei Starovoitov <ast@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

 On Thu, May 23, 2019 at 4:28 PM Song Liu <songliubraving@fb.com> wrote:
>
> > On May 22, 2019, at 11:48 PM, Kairui Song <kasong@redhat.com> wrote:
> >
> > On Thu, May 23, 2019 at 7:46 AM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> >>
> >> On Wed, May 22, 2019 at 12:45:17PM -0500, Josh Poimboeuf wrote:
> >>> On Wed, May 22, 2019 at 02:49:07PM +0000, Alexei Starovoitov wrote:
> >>>> The one that is broken is prog_tests/stacktrace_map.c
> >>>> There we attach bpf to standard tracepoint where
> >>>> kernel suppose to collect pt_regs before calling into bpf.
> >>>> And that's what bpf_get_stackid_tp() is doing.
> >>>> It passes pt_regs (that was collected before any bpf)
> >>>> into bpf_get_stackid() which calls get_perf_callchain().
> >>>> Same thing with kprobes, uprobes.
> >>>
> >>> Is it trying to unwind through ___bpf_prog_run()?
> >>>
> >>> If so, that would at least explain why ORC isn't working.  Objtool
> >>> currently ignores that function because it can't follow the jump table.
> >>
> >> Here's a tentative fix (for ORC, at least).  I'll need to make sure this
> >> doesn't break anything else.
> >>
> >> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> >> index 242a643af82f..1d9a7cc4b836 100644
> >> --- a/kernel/bpf/core.c
> >> +++ b/kernel/bpf/core.c
> >> @@ -1562,7 +1562,6 @@ static u64 ___bpf_prog_run(u64 *regs, const struct bpf_insn *insn, u64 *stack)
> >>                BUG_ON(1);
> >>                return 0;
> >> }
> >> -STACK_FRAME_NON_STANDARD(___bpf_prog_run); /* jump table */
> >>
> >> #define PROG_NAME(stack_size) __bpf_prog_run##stack_size
> >> #define DEFINE_BPF_PROG_RUN(stack_size) \
> >> diff --git a/tools/objtool/check.c b/tools/objtool/check.c
> >> index 172f99195726..2567027fce95 100644
> >> --- a/tools/objtool/check.c
> >> +++ b/tools/objtool/check.c
> >> @@ -1033,13 +1033,6 @@ static struct rela *find_switch_table(struct objtool_file *file,
> >>                if (text_rela->type == R_X86_64_PC32)
> >>                        table_offset += 4;
> >>
> >> -               /*
> >> -                * Make sure the .rodata address isn't associated with a
> >> -                * symbol.  gcc jump tables are anonymous data.
> >> -                */
> >> -               if (find_symbol_containing(rodata_sec, table_offset))
> >> -                       continue;
> >> -
> >>                rodata_rela = find_rela_by_dest(rodata_sec, table_offset);
> >>                if (rodata_rela) {
> >>                        /*
> >
> > Hi Josh, this still won't fix the problem.
> >
> > Problem is not (or not only) with ___bpf_prog_run, what actually went
> > wrong is with the JITed bpf code.
> >
> > For frame pointer unwinder, it seems the JITed bpf code will have a
> > shifted "BP" register? (arch/x86/net/bpf_jit_comp.c:217), so if we can
> > unshift it properly then it will work.
> >
> > I tried below code, and problem is fixed (only for frame pointer
> > unwinder though). Need to find a better way to detect and do any
> > similar trick for bpf part, if this is a feasible way to fix it:
> >
> > diff --git a/arch/x86/kernel/unwind_frame.c b/arch/x86/kernel/unwind_frame.c
> > index 9b9fd4826e7a..2c0fa2aaa7e4 100644
> > --- a/arch/x86/kernel/unwind_frame.c
> > +++ b/arch/x86/kernel/unwind_frame.c
> > @@ -330,8 +330,17 @@ bool unwind_next_frame(struct unwind_state *state)
> >        }
> >
> >        /* Move to the next frame if it's safe: */
> > -       if (!update_stack_state(state, next_bp))
> > -               goto bad_address;
> > +       if (!update_stack_state(state, next_bp)) {
> > +               // Try again with shifted BP
> > +               state->bp += 5; // see AUX_STACK_SPACE
> > +               next_bp = (unsigned long
> > *)READ_ONCE_TASK_STACK(state->task, *state->bp);
> > +               // Clean and refetch stack info, it's marked as error outed
> > +               state->stack_mask = 0;
> > +               get_stack_info(next_bp, state->task,
> > &state->stack_info, &state->stack_mask);
> > +               if (!update_stack_state(state, next_bp)) {
> > +                       goto bad_address;
> > +               }
> > +       }
> >
> >        return true;
> >
> > For ORC unwinder, I think the unwinder can't find any info about the
> > JITed part. Maybe if can let it just skip the JITed part and go to
> > kernel context, then should be good enough.
>
> In this case (tracepoint), the callchain bpf_get_stackid() fetches is the
> callchain at the tracepoint. So we don't need the JITed part.
>

We don't want the JITed part indeed, but the unwinder is now being
called to start directly within the BPF JITed program, so it have to
traceback above the JITed part and ignoring the JITed part.

> BPF program passes the regs at the tracepoint to perf_callchain_kernel().
> However, perf_callchain_kernel() only uses regs->sp for !perf_hw_regs()
> case. This is probably expected, as passing regs in doesn't really help.
>

ORC is not working with a partial dumped regs, and without frame
pointer, can't get a valid BP value in the tracepoint. So it only used
the sp as indicator of target frame. Unwinder was supposed to be
always able to unwind back correctly, so it should also be able to
reach the target frame, then start giving stack trace output.
Unfortunately this is not true when called through the JITed part...

> There are multiple cases in unwind_orc.c:__unwind_start(), which I don't
> understand very well.
>
> Does the above make sense? Did I mis-understand anything?

Yes, and thanks for the reply. See my other comments.

>
> @Alexei, do you remember some rough time/version that ORC unwinder works
> well for tracepoints? Maybe we can dig into that version to see the
> difference.
>

Is there really such a version/time? ORC was not working with every
use case of tracepoint before
d15d356887e770c5f2dcf963b52c7cb510c9e42d, as it require a fuller set
of regs from the tracepoint, however the handler called in the
tracepoint can't get the caller's required regs.

But before the commit d15d356887e770c5f2dcf963b52c7cb510c9e42d, it can
at least give one level of trace back (IP value), so I guess it just
passed the test.

--
Best Regards,
Kairui Song
