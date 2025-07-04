Return-Path: <bpf+bounces-62410-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0183AAF99A8
	for <lists+bpf@lfdr.de>; Fri,  4 Jul 2025 19:29:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90BCE3A6F1D
	for <lists+bpf@lfdr.de>; Fri,  4 Jul 2025 17:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25E74207E03;
	Fri,  4 Jul 2025 17:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e+2U3Ttk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A36F1EEE6
	for <bpf@vger.kernel.org>; Fri,  4 Jul 2025 17:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751650163; cv=none; b=ZtRp9gsl85Mp+kwwCfjPrxzSnnu0zWSjJ9LvZuHkmwUt5gqCSCGhRl3eVXGSnVaN6DHSztJnKRWYM37wKeufDFBuwryhIfZDg53bDeZoBLVZ7u7SmvdqHtRjFgeY6As3qrOKnUmv2/dQ8+C+85eD0nuEjWsqNS/VQvGSoYmASd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751650163; c=relaxed/simple;
	bh=m6XwxiZz/TsbtU610Pe4hpjQZZ1EgXEap7KppEYe+ps=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ofr9NSS7sw9KwXB+MgPWmgEOycyM9bI5OJMw9hm/Ef+WDeQqokSQ5nuGyzWXLbl/tDsREJVGn/iKKY61/vGj0RX1UnNrBb31w4Khi/FQRM6z3n+XaSxc132MSSvLtoP9g82WD5ZtU6O/hifoQaxKaC2dFWw/fXDiK0AcAweZvoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e+2U3Ttk; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-70e75f30452so7658967b3.2
        for <bpf@vger.kernel.org>; Fri, 04 Jul 2025 10:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751650160; x=1752254960; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8EG6lSL6XXHlmyZfCD/0/O8Kt2P7wrBonA1cIJBTVgQ=;
        b=e+2U3TtkIACJPTdcfyZU9H4nviCxf9y4/vEhttkTH24kJXg/MXA7Su8Ewf91hSTwbP
         uRPNOMyQgi0sDRujDiKBfiwknYVroV3D1VjSRmKwI/+LGlB81HgLneLGeIAzDjUUQpmP
         vBPudAZZGopzQ5h6YwAM6vUldMcyRHtgwLopoC4HTn4r2Rifhc6xCF2WoVcoGFKyDyK9
         bBC5ZtwvJ+MOL7DAaUb6rRXip2B+Voa6OfDA5b+YQ2WNXRbdLNTKzdWJuOi6XnBd5Llf
         Bs2WAhawr43+WHA1+gZj60Ya3FVxzw/L/6KyhUI1Wo/AMxfoQn65JN2iZmG3r5/cdEfo
         6apQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751650160; x=1752254960;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8EG6lSL6XXHlmyZfCD/0/O8Kt2P7wrBonA1cIJBTVgQ=;
        b=XPHPL1hWpJ5mRk+GuEtdxwsviQvYXYHx85TjbDW66sHKFsqMvZo3lg/67jUxf+1PAY
         NEv6SgidDSuFq18BIyMZRCG99B4LMTQL8SfK73t4YIT/AtmEmUx/rTetUIHH4nXSiB6j
         wLQGjXoxE5n1vMeE4+yrgQJnISf7XqBTmvq93mlCJnlntJ1/VPs2FnqK79kEZzKlJeOu
         m8RROnlJfG9OmnLt6E7OfnPTek3t5LyXwrpkzbg9iKGv+sGgqklSNncFtiRWw0VPCp4t
         ARxN1oGP4UNNjNPQ3snn8LEYjX2QHHSvvVmmtbIiVV85tawZf0XClrzeI5qIo8FzN2Hm
         4ZQQ==
X-Forwarded-Encrypted: i=1; AJvYcCWWSGN7e1VOovMdCD8BsnWw7hyTDDSOaZBTkovQpvL2EOio22PTwYM2u3FpszhrGgNikpM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywfs4Bj/v590QT34QVC7f4DPz/KR6pwl82YTllbf/IPrIvRZPRi
	Mnsfv1sDbIWY9oBKCeIH25xnehEJZ844x807QZV8DyWU+CqtIfI8TPgIa5+TkoEwEKUl9kbiYME
	gGQOLVljsQcw0dVU4yZtCg82rQqTf/q8=
X-Gm-Gg: ASbGncsMDpDttfowIu566zR2i72V2m+sul+SRgrRXc0kRanIENXM1rMukCy82o47aGT
	QPLnhK1dqs5qSQ2FKLADjtTD5dQwk4wCEEYBWGAhhXvfPsDhYuIEEeqwahOeevVhXiElBKv3CZR
	EDcBgr6ddZqPcZaaiusA2x1WyTY80+Pz80VdUPA4gs24Iy/Eqt1LGURmeIshiKfXg6MdFIQdw3k
	/70
X-Google-Smtp-Source: AGHT+IGIBnplq/aUhdoMAZOC4Qasyw6hh3iYOXOPeKtaYa3xUhr6BNamCeYxEbl9e7zoaV3Nocs7x40KI8SvPd2ujp4=
X-Received: by 2002:a05:690c:4b8f:b0:710:f1a9:1ba0 with SMTP id
 00721157ae682-71668c0f743mr46458897b3.3.1751650160371; Fri, 04 Jul 2025
 10:29:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250614064056.237005-1-sidchintamaneni@gmail.com>
 <20250614064056.237005-4-sidchintamaneni@gmail.com> <CAP01T77TBA3eEVoqGMVTpYsEzvg0f7Q95guH0SDQ3gZK=q+Tag@mail.gmail.com>
In-Reply-To: <CAP01T77TBA3eEVoqGMVTpYsEzvg0f7Q95guH0SDQ3gZK=q+Tag@mail.gmail.com>
From: Raj Sahu <rjsu26@gmail.com>
Date: Fri, 4 Jul 2025 10:29:04 -0700
X-Gm-Features: Ac12FXwxE3nG62ZtP3zl2L1qLI7abaYhQI5KKx0OW4KnE75CqfH3wSWPaVA1jIg
Message-ID: <CAM6KYssFT35L5HN_Fes-2BdhEO6EmhF9Qa+WSWLML4qnZ0z1tA@mail.gmail.com>
Subject: Re: [RFC bpf-next v2 3/4] bpf: Runtime part of fast-path termination approach
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Siddharth Chintamaneni <sidchintamaneni@gmail.com>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, djwillia@vt.edu, miloc@vt.edu, 
	ericts@vt.edu, rahult@vt.edu, doniaghazy@vt.edu, quanzhif@vt.edu, 
	jinghao7@illinois.edu, egor@vt.edu, sairoop10@gmail.com
Content-Type: text/plain; charset="UTF-8"

> > Introduces watchdog based runtime mechanism to terminate
> > a BPF program. When a BPF program is interrupted by
> > an watchdog, its registers are are passed onto the bpf_die.
> >
> > Inside bpf_die we perform the text_poke and stack walk
> > to stub helpers/kfunc replace bpf_loop helper if called
> > inside bpf program.
> >
> > Current implementation doesn't handle the termination of
> > tailcall programs.
> >
> > There is a known issue by calling text_poke inside interrupt
> > context - https://elixir.bootlin.com/linux/v6.15.1/source/kernel/smp.c#L815.
>
> I don't have a good idea so far, maybe by deferring work to wq context?
> Each CPU would need its own context and schedule work there.
> The problem is that it may not be invoked immediately.
We will give it a try using wq. We were a bit hesitant in pursuing wq
earlier because to modify the return address on the stack we would
want to interrupt the running BPF program and access its stack since
that's a key part of the design.

Will need some suggestions here on how to achieve that.

> > +static void bpf_terminate_timer_init(const struct bpf_prog *prog)
> > +{
> > +       ktime_t timeout = ktime_set(1, 0); // 1s, 0ns
> > +
> > +       /* Initialize timer on Monotonic clock, relative mode */
> > +       hrtimer_setup(&prog->term_states->hrtimer, bpf_termination_wd_callback, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
>
> Hmm, doesn't this need to be a per-CPU hrtimer? Otherwise all
> concurrent invocations will race to set up and start it?
> Doesn't even look thread safe, unless I'm missing something.
Yes, this was an oversight. Thanks for pointing it out.
> > +       /* Start watchdog */
> > +       hrtimer_start(&prog->term_states->hrtimer, timeout, HRTIMER_MODE_REL);
> > +}
> > +
> > +static void bpf_terminate_timer_cancel(const struct bpf_prog *prog)
> > +{
> > +       hrtimer_cancel(&prog->term_states->hrtimer);
> > +}
> > +
> >  static __always_inline u32 __bpf_prog_run(const struct bpf_prog *prog,
> >                                           const void *ctx,
> >                                           bpf_dispatcher_fn dfunc)
> > @@ -706,7 +735,11 @@ static __always_inline u32 __bpf_prog_run(const struct bpf_prog *prog,
> >                 u64 duration, start = sched_clock();
> >                 unsigned long flags;
> >
> > +               update_term_per_cpu_flag(prog, 1);
> > +               bpf_terminate_timer_init(prog);
> >                 ret = dfunc(ctx, prog->insnsi, prog->bpf_func);
> > +               bpf_terminate_timer_cancel(prog);
> > +               update_term_per_cpu_flag(prog, 0);
> >
> >                 duration = sched_clock() - start;
> >                 stats = this_cpu_ptr(prog->stats);
> > @@ -715,8 +748,11 @@ static __always_inline u32 __bpf_prog_run(const struct bpf_prog *prog,
> >                 u64_stats_add(&stats->nsecs, duration);
> >                 u64_stats_update_end_irqrestore(&stats->syncp, flags);
> >         } else {
> > +               update_term_per_cpu_flag(prog, 1);
> > +               bpf_terminate_timer_init(prog);
> >                 ret = dfunc(ctx, prog->insnsi, prog->bpf_func);
> > -       }
> > +               bpf_terminate_timer_cancel(prog);
> > +               update_term_per_cpu_flag(prog, 0);}
> >         return ret;
> >  }
>
> Hmm, did you profile how much overhead this adds? It's not completely
> free, right?
> I guess the per_cpu flag's lock is uncontended, so there wouldn't be
> too much overhead there (though it's still an extra atomic op on the
> fast path).
> hrtimer_setup() won't be that expensive either, but I think
> hrtimer_start() can be.
> Also, what about programs invoked from BPF trampoline? We would need
> such "watchdog" protection for potentially every program, right?
>
> I'm more concerned about the implications of using an hrtimer around
> every program invocation though.
> Imagine that the program gets invoked in task context, the same
> program then runs in interrupt context (let's say it's a tracing
> program).
> Even the simple hrtimer_cancel() when returning from interrupt context
> can potentially deadlock the kernel if the task context program hit
> its limit and was inside the timer callback.
> Let alone the fact that we can have recursion on the same CPU as above
> or by repeatedly invoking the same program, which reprograms the timer
> again.
>
> I think we should piggy back on softlockup / hardlockup checks (that's
> what I did long ago), but for simplicity I would just drop these time
> based enforcement checks from the set for now.
> They're incomplete, and potentially buggy. Instead you can invoke
> bpf_die() when a program hits the loop's max count limit or something
> similar, in order to test this.
> We also need to account for sleepable programs, so a 1 second
> hardcoded limit is probably not appropriate.
> Enforcement is orthogonal to how a program is cleaned up, though as
> important, but it can be revisited once we sort out the first part.
ACK
We can do some profiling eventually then if we decide to bring it back.
The deadlock case is a good case to consider, however a program's
recursion is not possible on a given CPU right?

Earlier we were thinking of enforcing performance based runtime
policies for BPF programs. Looks like it is getting hard to implement
it. So I think we will go ahead and rely on the kernel/ bpf mechanism
to detect bad BPF programs (stalls, pf, etc).

Adding an iteration based termination for bpf_loop won't be enough
because an expensive callback won't need too many
iterations,comparatively, to exceed runtime expectations.


> > @@ -1119,6 +1155,9 @@ int sk_get_filter(struct sock *sk, sockptr_t optval, unsigned int len);
> >  bool sk_filter_charge(struct sock *sk, struct sk_filter *fp);
> >  void sk_filter_uncharge(struct sock *sk, struct sk_filter *fp);
> >
> > +#ifdef CONFIG_X86_64
> > +int bpf_loop_termination(u32 nr_loops, void *callback_fn, void *callback_ctx, u64 flags);
> > +#endif
> >  int bpf_loop_term_callback(u64 reg_loop_cnt, u64 *reg_loop_ctx);
> >  void *bpf_termination_null_func(u64 r1, u64 r2, u64 r3, u64 r4, u64 r5);
> >  u64 __bpf_call_base(u64 r1, u64 r2, u64 r3, u64 r4, u64 r5);
> > diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> > index 2a02e9cafd5a..735518735779 100644
> > --- a/kernel/bpf/core.c
> > +++ b/kernel/bpf/core.c
> > @@ -1583,6 +1583,21 @@ noinline int bpf_loop_term_callback(u64 reg_loop_cnt, u64 *reg_loop_ctx)
> >  }
> >  EXPORT_SYMBOL_GPL(bpf_loop_term_callback);
> >
> > +#ifdef CONFIG_X86_64
> > +noinline int bpf_loop_termination(u32 nr_loops, void *callback_fn, void *callback_ctx, u64 flags)
> > +{
> > +       asm volatile(
> > +               "pop %rbx\n\t"
> > +               "pop %rbp\n\t"
> > +               "pop %r12\n\t"
> > +               "pop %r13\n\t"
> > +       );
> > +       return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(bpf_loop_termination);
> > +STACK_FRAME_NON_STANDARD(bpf_loop_termination);
>
> You can move this into an arch-specific helper, see
> bpf_timed_may_goto.S in arch/x86/net.
> For non-x86, the whole logic should not kick in.
>
> Also this function needs more comments. Why is restoring these 4
> registers correct?
> It is not clear from the code, please point out where they are being saved.
>
> If this is about restoring callee saved registers, then it looks broken to me.
> Only those scratched are saved by the JIT (see callee_regs_used in
> bpf_jit_comp.c), so it would be plain wrong.
> r12 is unused except for arenas. rbx, r13, r14, r15 are used, at max.
>
> It would make more sense to move the logic into the JIT, as I suggested above.
> Even then, you either need to spill all callee regs, or figure out a
> way to conditionally restore.
Should have added more comments : )
bpf_loop_termination is supposed to be the replacement of bpf_loop
helper call for the cases when a BPF program didn't inline them.
The original bpf_loop helper has 4 arguments which we observed were
getting saved onto the stack.
The 4 pop instructions are to remove the 4 saved registers from the stack.
We did have our concerns about the compiler not saving all 4 of them or maybe
saving them in a different order, but didn't observe that in the testing.
But I agree it's a bit hacky although we were not sure how else to
figure this out.

If we end up pursuing the wq approach, this hack won't be applicable anyways
(handler will be running on a different stack). We'll have to figure
out another way then.

> > +#endif
> > +
> >  /* Base function for offset calculation. Needs to go into .text section,
> >   * therefore keeping it non-static as well; will also be used by JITs
> >   * anyway later on, so do not let the compiler omit it. This also needs
> > diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> > index cd8e7c47e3fe..065767ae1bd1 100644
> > --- a/kernel/bpf/syscall.c
> > +++ b/kernel/bpf/syscall.c
> > @@ -37,6 +37,10 @@
> >  #include <linux/trace_events.h>
> >  #include <linux/tracepoint.h>
> >  #include <linux/overflow.h>
> > +#include <asm/unwind.h>
> > +#include <asm/insn.h>
> > +#include <asm/text-patching.h>
> > +#include <asm/irq_regs.h>
> >
> >  #include <net/netfilter/nf_bpf_link.h>
> >  #include <net/netkit.h>
> > @@ -2767,6 +2771,207 @@ static int sanity_check_jit_len(struct bpf_prog *prog)
> >         return 0;
> >  }
> >
> > +static bool per_cpu_flag_is_true(struct bpf_term_aux_states *term_states, int cpu_id)
> > +{
> > +       unsigned long flags;
> > +       spin_lock_irqsave(&term_states->per_cpu_state[cpu_id].lock,
> > +                               flags);
> > +       if (term_states->per_cpu_state[cpu_id].cpu_flag == 1) {
> > +               spin_unlock_irqrestore(&term_states->per_cpu_state[cpu_id].lock,
> > +                                       flags);
> > +               return true;
> > +       }
> > +       spin_unlock_irqrestore(&term_states->per_cpu_state[cpu_id].lock,
> > +                               flags);
> > +       return false;
> > +}
> > +
> > +static int is_bpf_address(struct bpf_prog *prog, unsigned long addr)
>
> Use prog == bpf_prog_ksym_find(addr) here.
> Also, rename this function to something like is_bpf_prog_text_address
> (scoped version of is_bpf_text_address).
>
> > +{
> > +
> > +        unsigned long bpf_func_addr = (unsigned long)prog->bpf_func;
> > +        if ((addr > bpf_func_addr) &&
> > +                        (addr < bpf_func_addr + prog->jited_len)){
> > +                return 1;
> > +        }
> > +
> > +        for (int subprog = 1; subprog < prog->aux->func_cnt; subprog++) {
> > +                struct bpf_prog *bpf_subprog = prog->aux->func[subprog];
> > +                unsigned long bpf_subprog_func_addr =
> > +                                        (unsigned long)bpf_subprog->bpf_func;
> > +                if ((addr > bpf_subprog_func_addr) && (addr < bpf_subprog_func_addr +
> > +                                                        bpf_subprog->jited_len)) {
> > +                        return 1;
> > +                }
> > +        }
> > +
> > +        return 0;
> > +}
> > +
> > +/*
> > + * For a call instruction in a BPF program, return the stubbed insn buff.
> > + * Returns new instruction buff if stubbing required,
> > + *        NULL if no change needed.
> > + */
> > +__always_inline char* find_termination_realloc(struct insn orig_insn, unsigned char *orig_addr,
> > +                                              struct insn patch_insn, unsigned char *patch_addr) {
> > +
> > +       unsigned long new_target;
> > +       unsigned long original_call_target = (unsigned long)orig_addr + 5 + orig_insn.immediate.value;
> > +
> > +       unsigned long patch_call_target = (unsigned long)patch_addr + 5 + patch_insn.immediate.value;
> > +
> > +       /* As per patch prog, no stubbing needed. */
> > +       if (patch_call_target == original_call_target)
> > +               return NULL;
> > +
> > +       /* bpf_termination_null_func is the generic stub function unless its either of
> > +       * the bpf_loop helper or the associated callback
> > +       */
> > +       new_target = (unsigned long)bpf_termination_null_func;
> > +       if (patch_call_target == (unsigned long)bpf_loop_term_callback)
> > +               new_target = (unsigned long)bpf_loop_term_callback;
> > +
> > +
> > +       unsigned long new_rel = (unsigned long)(new_target - (unsigned long)(orig_addr + 5));
> > +
> > +       char *new_insn = kmalloc(5, GFP_KERNEL);
>
> This can fail, so you'd have to return NULL even in cases where you
> need to patch the target...
> I'd suggest modifying the contract of the function to not depend on
> returning NULL, can be some out parameter.
>
> > +       new_insn[0] = 0xE8;
> > +       new_insn[1] = (new_rel >> 0) & 0xff;
> > +       new_insn[2] = (new_rel >> 8) & 0xff;
> > +       new_insn[3] = (new_rel >> 16) & 0xff;
> > +       new_insn[4] = (new_rel >> 24) & 0xff;
> > +
> > +       return new_insn;
> > +}
> > +
> > +/*
> > + * Given a bpf program and a corresponding termination patch prog
> > + * (generated during verification), this program will patch all
> > + * call instructions in prog and decide whether to stub them
> > + * based on whether the termination_prog has stubbed or not.
> > + */
> > +static void __maybe_unused in_place_patch_bpf_prog(struct bpf_prog *prog, struct bpf_prog *patch_prog){
> > +
> > +       uint32_t size = 0;
> > +
> > +       while (size < prog->jited_len) {
> > +              unsigned char *addr = (unsigned char*)prog->bpf_func;
> > +              unsigned char *addr_patch = (unsigned char*)patch_prog->bpf_func;
> > +
> > +              struct insn insn;
> > +              struct insn insn_patch;
> > +
> > +              addr += size;
> > +              /* Decode original instruction */
> > +               if (WARN_ON_ONCE(insn_decode_kernel(&insn, addr))) {
> > +                       return;
> > +               }
> > +
> > +               /* Check for call instruction */
> > +               if (insn.opcode.bytes[0] != CALL_INSN_OPCODE) {
> > +                       goto next_insn;
> > +               }
> > +
> > +              addr_patch += size;
> > +              /* Decode patch_prog instruction */
> > +               if (WARN_ON_ONCE(insn_decode_kernel(&insn_patch, addr_patch))) {
> > +                       return ;
> > +               }
> > +
> > +              // Stub the call instruction if needed
> > +              char *buf;
> > +              if ((buf = find_termination_realloc(insn, addr, insn_patch, addr_patch)) != NULL) {
> > +                      smp_text_poke_batch_add(addr, buf, insn.length, NULL);
> > +                      kfree(buf);
>
> I think we should find a way to make this work without allocations.
> What if it fails? Are we going to let the program keep executing
> forever.
> Doesn't seem like a good option.
>
> > +              }
> > +
> > +       next_insn:
> > +               size += insn.length;
> > +       }
> > +}
> > +
> > +
> > +void bpf_die(void *data)
> > +{
> > +       struct bpf_prog *prog, *patch_prog;
> > +       int cpu_id = raw_smp_processor_id();
>
> Assuming you make the hrtimer per-CPU.
> So the hrtimer is not pinned to the CPU (HRTIMER_MODE_PINNED), hence
> it can be fired on any other CPU when the timer expires.
> This means you lose the associativity between the CPU where the
> program invocation did not complete in 1 second.
> Instead I think it might be better to have it in the per-cpu state,
> and stash the CPU number there and use container_of to obtain it.
>
> > +
> > +       prog = (struct bpf_prog *)data;
> > +       patch_prog = prog->term_states->patch_prog;
> > +
> > +       if (!per_cpu_flag_is_true(prog->term_states, cpu_id))
> > +               return;
>
> Unless hrtimer_cancel() provides a write barrier, this can return
> early if the write to 0 in the per-CPU flag gets reordered.
> It would be better to be explicit there.
>
> > +
> > +       unsigned long jmp_offset = prog->jited_len - (4 /*First endbr is 4 bytes*/
> > +                                               + 5 /*5 bytes of noop*/
> > +                                               + 5 /*5 bytes of jmp return_thunk*/);
>
> This is all x86 specific, so at the very least it should be guarded.
> The proper way would be to add a weak stub in core.c and provide an
> implementation in the arch-specific directory.
>
> > +       char new_insn[5];
> > +       new_insn[0] = 0xE9;
> > +       new_insn[1] = (jmp_offset >> 0) & 0xff;
> > +       new_insn[2] = (jmp_offset >> 8) & 0xff;
> > +       new_insn[3] = (jmp_offset >> 16) & 0xff;
> > +       new_insn[4] = (jmp_offset >> 24) & 0xff;
> > +       smp_text_poke_batch_add(prog->bpf_func + 4, new_insn, 5, NULL);
> > +
> > +       /* poke all progs and subprogs */
> > +       if (prog->aux->func_cnt) {
> > +               for(int i=0; i<prog->aux->func_cnt; i++){
> > +                       in_place_patch_bpf_prog(prog->aux->func[i], patch_prog->aux->func[i]);
> > +               }
> > +       } else {
> > +               in_place_patch_bpf_prog(prog, patch_prog);
> > +       }
> > +       /* flush all text poke calls */
> > +       smp_text_poke_batch_finish();
> > +
> > +
> > + #ifdef CONFIG_X86_64
> > +       struct unwind_state state;
> > +       unsigned long addr, bpf_loop_addr, bpf_loop_term_addr;
> > +       struct pt_regs *regs = get_irq_regs();
> > +       char str[KSYM_SYMBOL_LEN];
> > +       bpf_loop_addr = (unsigned long)bpf_loop_proto.func;
> > +       bpf_loop_term_addr = (unsigned long)bpf_loop_termination;
> > +       unwind_start(&state, current, regs, NULL);
> > +
> > +       addr = unwind_get_return_address(&state);
> > +
> > +       unsigned long stack_addr = regs->sp;
> > +       while (addr) {
> > +               if (is_bpf_address(prog, addr)) {
> > +                       break;
> > +               } else {
> > +                       const char *name = kallsyms_lookup(addr, NULL, NULL, NULL, str);
> > +                       if (name) {
> > +                               unsigned long lookup_addr = kallsyms_lookup_name(name);
> > +                               if (lookup_addr && lookup_addr == bpf_loop_addr) {
> > +                                       while (*(unsigned long *)stack_addr != addr) {
> > +                                               stack_addr += 1;
> > +                                       }
> > +                                       *(unsigned long *)stack_addr = bpf_loop_term_addr;
> > +                               }
> > +                       }
> > +               }
> > +               unwind_next_frame(&state);
> > +               addr = unwind_get_return_address(&state);
> > +       }
>
> Instead of doing all this munging by hand, a better way is to figure
> out the frame base pointer using arch_bpf_stack_walk, then figure out
> the return address using that.
>
> > +#endif
> > +
> > +       return;
> > +}
> > +
> > +enum hrtimer_restart bpf_termination_wd_callback(struct hrtimer *hr)
> > +{
> > +
> > +       struct bpf_term_aux_states *term_states = container_of(hr, struct bpf_term_aux_states, hrtimer);
> > +       struct bpf_prog *prog = term_states->prog;
> > +       bpf_die(prog);
> > +       return HRTIMER_NORESTART;
> > +
> > +}
> > +EXPORT_SYMBOL_GPL(bpf_termination_wd_callback);
> > +
> >  static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size)
> >  {
> >         enum bpf_prog_type type = attr->prog_type;
> > @@ -2995,6 +3200,7 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size)
> >         err = sanity_check_jit_len(prog);
> >         if (err < 0)
> >                 goto free_used_maps;
> > +       prog->term_states->prog = prog;
> >
> >         err = bpf_prog_alloc_id(prog);
> >         if (err)
> > diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> > index c4b1a98ff726..16f685c861a3 100644
> > --- a/kernel/bpf/trampoline.c
> > +++ b/kernel/bpf/trampoline.c
> > @@ -908,6 +908,9 @@ static u64 notrace __bpf_prog_enter_recur(struct bpf_prog *prog, struct bpf_tram
> >                         prog->aux->recursion_detected(prog);
> >                 return 0;
> >         }
> > +
> > +       update_term_per_cpu_flag(prog, 1);
> > +       bpf_terminate_timer_init(prog);
> >         return bpf_prog_start_time();
> >  }
> >
> > @@ -941,6 +944,8 @@ static void notrace __bpf_prog_exit_recur(struct bpf_prog *prog, u64 start,
> >         bpf_reset_run_ctx(run_ctx->saved_run_ctx);
> >
> >         update_prog_stats(prog, start);
> > +       bpf_terminate_timer_cancel(prog);
> > +       update_term_per_cpu_flag(prog, 0);
> >         this_cpu_dec(*(prog->active));
> >         migrate_enable();
> >         rcu_read_unlock();
> > --
> > 2.43.0
> >
ACK

