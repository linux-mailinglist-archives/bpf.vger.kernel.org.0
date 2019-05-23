Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61D72283FE
	for <lists+bpf@lfdr.de>; Thu, 23 May 2019 18:42:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731156AbfEWQmM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 May 2019 12:42:12 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:53666 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730893AbfEWQmM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 May 2019 12:42:12 -0400
Received: by mail-it1-f196.google.com with SMTP id m141so10831323ita.3
        for <bpf@vger.kernel.org>; Thu, 23 May 2019 09:42:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6h5Gv6+Yt9f8QV63xDQZtQKCEMQicjrYgqtB5ciLH/o=;
        b=OvJ8kkaM7BH0a1TWiKuCvGWq6RoblL0kAsFPFanO+MtFkmiHQ9BboniskqpfchhCfb
         qLKE98s6n2Z5wYcTCGRwMXpBiJ+eDZZknbRHgHzcHUA9Km9zib3WfYrSnzY9+sYI5vNP
         kbm8zSs9xNqT5OXrSQktZCGrETS2VvS01vT095d7oxVpNcOZvblw/2lZXDwMe8PM8+CA
         T24o0GxIhESu7SFXWj9IDIjhxnUxLpuXd0iE/DaBLkcTm0L2ageitpb9OTYXDP+n9ewc
         hw7mtbiCNPKvF219Q035ZUffEbm4odqLHHJJCr4DLR5m39EqSRbxnfX0fL+KFD+ERQJl
         gJQw==
X-Gm-Message-State: APjAAAVkr6Urp+hwpcD0EsjnDQhC9o8mEn1sjnaDS64QrBhIdR2eFVNU
        o5yVLYt6Mbp/VeCkqd/lTZg/sHWvvCj8K//GGQBr5fyf6NJ7fIXa
X-Google-Smtp-Source: APXvYqxTZQkYgbBDIvoFkw/ZTDfJz6cpIlSoNKA34ueI1+BGLDPWDqNKplP2eh4Nb/zUp7AWKX8x3jaCM2nKGrpPFYk=
X-Received: by 2002:a24:2e8c:: with SMTP id i134mr13991636ita.9.1558629731329;
 Thu, 23 May 2019 09:42:11 -0700 (PDT)
MIME-Version: 1.0
References: <CACPcB9cB5n1HOmZcVpusJq8rAV5+KfmZ-Lxv3tgsSoy7vNrk7w@mail.gmail.com>
 <20190517091044.GM2606@hirez.programming.kicks-ass.net> <CACPcB9cpNp5CBqoRs+XMCwufzAFa8Pj-gbmj9fb+g5wVdue=ig@mail.gmail.com>
 <20190522140233.GC16275@worktop.programming.kicks-ass.net>
 <ab047883-69f6-1175-153f-5ad9462c6389@fb.com> <20190522174517.pbdopvookggen3d7@treble>
 <20190522234635.a47bettklcf5gt7c@treble> <CACPcB9dRJ89YAMDQdKoDMU=vFfpb5AaY0mWC_Xzw1ZMTFBf6ng@mail.gmail.com>
 <20190523133253.tad6ywzzexks6hrp@treble> <CACPcB9fQKg7xhzhCZaF4UGi=EQs1HLTFgg-C_xJQaUfho3yMyA@mail.gmail.com>
 <20190523152413.m2pbnamihu3s2c5s@treble>
In-Reply-To: <20190523152413.m2pbnamihu3s2c5s@treble>
From:   Kairui Song <kasong@redhat.com>
Date:   Fri, 24 May 2019 00:41:59 +0800
Message-ID: <CACPcB9e0mL6jdNWfH-2K-rkvmQiz=G6mtLiZ+AEmp3-V0x+Z8A@mail.gmail.com>
Subject: Re: Getting empty callchain from perf_callchain_kernel()
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Alexei Starovoitov <ast@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Song Liu <songliubraving@fb.com>,
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

 On Thu, May 23, 2019 at 11:24 PM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
> On Thu, May 23, 2019 at 10:50:24PM +0800, Kairui Song wrote:
> > > > Hi Josh, this still won't fix the problem.
> > > >
> > > > Problem is not (or not only) with ___bpf_prog_run, what actually went
> > > > wrong is with the JITed bpf code.
> > >
> > > There seem to be a bunch of issues.  My patch at least fixes the failing
> > > selftest reported by Alexei for ORC.
> > >
> > > How can I recreate your issue?
> >
> > Hmm, I used bcc's example to attach bpf to trace point, and with that
> > fix stack trace is still invalid.
> >
> > CMD I used with bcc:
> > python3 ./tools/stackcount.py t:sched:sched_fork
>
> I've had problems in the past getting bcc to build, so I was hoping it
> was reproducible with a standalone selftest.
>
> > And I just had another try applying your patch, self test is also failing.
>
> Is it the same selftest reported by Alexei?
>
>   test_stacktrace_map:FAIL:compare_map_keys stackid_hmap vs. stackmap err -1 errno 2
>
> > I'm applying on my local master branch, a few days older than
> > upstream, I can update and try again, am I missing anything?
>
> The above patch had some issues, so with some configs you might see an
> objtool warning for ___bpf_prog_run(), in which case the patch doesn't
> fix the test_stacktrace_map selftest.
>
> Here's the latest version which should fix it in all cases (based on
> tip/master):
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/jpoimboe/linux.git/commit/?h=bpf-orc-fix

Hmm, I still get the failure:
test_stacktrace_map:FAIL:compare_map_keys stackid_hmap vs. stackmap
err -1 errno 2

And I didn't see how this will fix the issue. As long as ORC need to
unwind through the JITed code it will fail. And that will happen
before reaching ___bpf_prog_run.

>
> > > > For frame pointer unwinder, it seems the JITed bpf code will have a
> > > > shifted "BP" register? (arch/x86/net/bpf_jit_comp.c:217), so if we can
> > > > unshift it properly then it will work.
> > >
> > > Yeah, that looks like a frame pointer bug in emit_prologue().
> > >
> > > > I tried below code, and problem is fixed (only for frame pointer
> > > > unwinder though). Need to find a better way to detect and do any
> > > > similar trick for bpf part, if this is a feasible way to fix it:
> > > >
> > > > diff --git a/arch/x86/kernel/unwind_frame.c b/arch/x86/kernel/unwind_frame.c
> > > > index 9b9fd4826e7a..2c0fa2aaa7e4 100644
> > > > --- a/arch/x86/kernel/unwind_frame.c
> > > > +++ b/arch/x86/kernel/unwind_frame.c
> > > > @@ -330,8 +330,17 @@ bool unwind_next_frame(struct unwind_state *state)
> > > >         }
> > > >
> > > >         /* Move to the next frame if it's safe: */
> > > > -       if (!update_stack_state(state, next_bp))
> > > > -               goto bad_address;
> > > > +       if (!update_stack_state(state, next_bp)) {
> > > > +               // Try again with shifted BP
> > > > +               state->bp += 5; // see AUX_STACK_SPACE
> > > > +               next_bp = (unsigned long
> > > > *)READ_ONCE_TASK_STACK(state->task, *state->bp);
> > > > +               // Clean and refetch stack info, it's marked as error outed
> > > > +               state->stack_mask = 0;
> > > > +               get_stack_info(next_bp, state->task,
> > > > &state->stack_info, &state->stack_mask);
> > > > +               if (!update_stack_state(state, next_bp)) {
> > > > +                       goto bad_address;
> > > > +               }
> > > > +       }
> > > >
> > > >         return true;
> > >
> > > Nack.
> > >
> > > > For ORC unwinder, I think the unwinder can't find any info about the
> > > > JITed part. Maybe if can let it just skip the JITed part and go to
> > > > kernel context, then should be good enough.
> > >
> > > If it's starting from a fake pt_regs then that's going to be a
> > > challenge.
> > >
> > > Will the JIT code always have the same stack layout?  If so then we
> > > could hard code that knowledge in ORC.  Or even better, create a generic
> > > interface for ORC to query the creator of the generated code about the
> > > stack layout.
> >
> > I think yes.
> >
> > Not sure why we have the BP shift yet, if the prolog code could be
> > tweaked to work with frame pointer unwinder it will be good to have.
> > But still not for ORC.
> >
> > Will it be a good idea to have a region reserved for the JITed code?
> > Currently it shares the region with "module mapping space". If let it
> > have a separate region, when the unwinder meet any code in that region
> > it will know it's JITed code and then can do something special about
> > it.
> >
> > This should make it much easier for both frame pointer and ORC unwinder to work.
>
> There's no need to put special cases in the FP unwinder when we can
> instead just fix the frame pointer usage in the JIT code.
>
> For ORC, I'm thinking we may be able to just require that all generated
> code (BPF and others) always use frame pointers.  Then when ORC doesn't
> recognize a code address, it could try using the frame pointer as a
> fallback.

Right, this sounds the right way to fix it, I believe this can fix
everything well.

>
> Once I get a reproducer I can do the patches for all that.
>
> --
> Josh
--
Best Regards,
Kairui Song
