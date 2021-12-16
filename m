Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5F7E477CA5
	for <lists+bpf@lfdr.de>; Thu, 16 Dec 2021 20:37:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236599AbhLPTh6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Dec 2021 14:37:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236556AbhLPTh6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 16 Dec 2021 14:37:58 -0500
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30EB9C061574
        for <bpf@vger.kernel.org>; Thu, 16 Dec 2021 11:37:58 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id 131so74968ybc.7
        for <bpf@vger.kernel.org>; Thu, 16 Dec 2021 11:37:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Jz9Y23Gpq3ooND/KMECaEsDkI0+0sim4VUPZDYZ2aZE=;
        b=SIm9TnH3ylqguI6Wtmd0HErU3XPPbWQzVlzlK4Hz0NDGRd7XJVB6SPz0g1TpRhEBE/
         npIQxoPwQXJywdIndU9hn/cw+3bsJ0OFpMcAM1Kevm3du1RogLzUXDT/3pgLA6AnjSgL
         PiQ4qy0dbOqTgDnmErNMF3r3AH5eC2KocqjSMTPmoiOFMcxP+ktzJtv6v+NcYRJDJnQ+
         cwMfBgbO0Zi/qgqBruKdcwbl3rF7fxDjxRX9Krml6BCnLN65V+Ai9cBx4VfAWL1biN9y
         PnuRD9h9e8kwQM4n1NcH2AZp3fKDVXP3K8n2me+KvA7LpHJZhLbpVlh14E9UUakcF+UJ
         yFGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Jz9Y23Gpq3ooND/KMECaEsDkI0+0sim4VUPZDYZ2aZE=;
        b=PlEC4IzzdBVHH/r8NfPL9C/QhtF2RszwOU8StCTabYXBTrfZjGLPmxRS6CCTuOlyIs
         F0c9snJBZMAU8ThsR6aOppAyVcYdwyq2sunhEPfzi/WVYE/flspaiHdbh/RO5LhP8noJ
         hcgfbx1+OwT1UGbBNWBAKLzLiQyuxX0/T0fYFKUpBMjGjZmHFwCKMPxoUWTyA8Jmy8Xf
         z+1KksiZ/xmxrkPiehtjiKsd4gTGrYOPBKHdTUW5XnI4zmKV1H/0BXG2QZ8eFaMV7Kgf
         TOnz06LG6J4OTRwPc8V8Lek03+81WNH5Tt0Lhp0PYDL/Mi/fxah50wXWhkNESqsIUGvr
         YO0w==
X-Gm-Message-State: AOAM531Qpv8pZPe0Jd03DI94Zai0i8NH1t6iYpmf7Ds41jPmYKMo1Bpy
        x9Xq3VcP4JQ/wTl7KklonU++qqmAoTNWUNa9fKQ=
X-Google-Smtp-Source: ABdhPJzNcTdhGf6OJQIHosidhy6xTLi2jvJw6gGqTQkC0fNaXoba8KAS8O8WJu1zBidbuX7iNzj+0QF5b7pFK1TLhjQ=
X-Received: by 2002:a25:3c9:: with SMTP id 192mr15852560ybd.766.1639683477199;
 Thu, 16 Dec 2021 11:37:57 -0800 (PST)
MIME-Version: 1.0
References: <20211215192225.1278237-1-christylee@fb.com> <20211215192225.1278237-3-christylee@fb.com>
 <CAEf4BzZvpODHJ-ca7yifmYBvqw+7ysR5A+HHPVDKHBs8XMzr-A@mail.gmail.com>
 <CAPqJDZr1AudE2PfbZQarHf0N5i_-xm-zyhfLqS5rogX98UtNLQ@mail.gmail.com> <CAPqJDZqyRLz+Xt77XLfxYbqP3DiEVonBYhhhOCsO4mN-Mc7xQw@mail.gmail.com>
In-Reply-To: <CAPqJDZqyRLz+Xt77XLfxYbqP3DiEVonBYhhhOCsO4mN-Mc7xQw@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 16 Dec 2021 11:37:45 -0800
Message-ID: <CAEf4BzbUaf+iCj0dM_2jhw8BiFk35BHnKhRtkCpNGi4VrLk1GQ@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 2/3] Right align verifier states in verifier logs
To:     Christy Lee <christyc.y.lee@gmail.com>
Cc:     Christy Lee <christylee@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Dec 16, 2021 at 8:03 AM Christy Lee <christyc.y.lee@gmail.com> wrote:
>
> On Thu, Dec 16, 2021 at 7:59 AM Christy Lee <christyc.y.lee@gmail.com> wrote:>
>
> Apologies, resending this because the previous email was not plain text.
>
> >
> > On Wed, Dec 15, 2021 at 11:02 PM Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
> >>
> >> On Wed, Dec 15, 2021 at 11:22 AM Christy Lee <christylee@fb.com> wrote:
> >> >
> >
> > [...]
> >>
> >>
> >> There seems to be quite a lot of jumpin back and forth in terms of
> >> 33th (see off by one error below) vs 40th offsets (this is for
> >> pyperf50 test):
> >>
> >> 16: (07) r2 += -8               ; R2_w=fp-8
> >> ; Event* event = bpf_map_lookup_elem(&eventmap, &zero);
> >> 17: (18) r1 = 0xffff88810d81dc00       ;
> >> R1_w=map_ptr(id=0,off=0,ks=4,vs=252,imm=0)
> >> 19: (85) call bpf_map_lookup_elem#1    ;
> >> R0=map_value_or_null(id=3,off=0,ks=4,vs=252,imm=0)
> >> 20: (bf) r7 = r0                ;
> >> R0=map_value_or_null(id=3,off=0,ks=4,vs=252,imm=0)
> >> R7_w=map_value_or_null(id=3,off=0,ks=4,vs=252,imm=0)
> >> ; if (!event)
> >> 21: (15) if r7 == 0x0 goto pc+5193     ;
> >> R7_w=map_value(id=0,off=0,ks=4,vs=252,imm=0)
> >> ; event->pid = pid;
> >> 22: (61) r1 = *(u32 *)(r10 -4)  ;
> >> R1_w=inv(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff)) R10=fp0
> >>
> >> Maybe let's bump the minimum to 40?
> >
> > Will do! I'll experiment with the nicest looking offset.
> >>
> >>
> >> >
> >> > Signed-off-by: Christy Lee <christylee@fb.com>
> >
> > [...]
> >>
> >> >
> >> > +static u32 vlog_alignment(u32 prev_insn_print_len)
> >> > +{
> >> > +       if (prev_insn_print_len < BPF_LOG_ALIGNMENT_POS)
> >> > +               return BPF_LOG_ALIGNMENT_POS - prev_insn_print_len + 1;
> >>
> >> why +1 here?
> >
> > I wanted the insn_state to be prepended by BPF_LOG_ALIGNMENT_POS
> > number of characters, in this case, that would be prepended by 32 and starting
> > at 33. This ensures that whether prev_insn_print_len is smaller than
> > BPF_LOG_ALIGNMENT_POS or not, the insn_states would be aligned properly,
> > there would be an off-by-one error otherwise.
> >>
> >>
> >> > +       return round_up(prev_insn_print_len, BPF_LOG_MIN_ALIGNMENT) -
> >> > +              prev_insn_print_len;
> >> > +}
> >> > +
> >> > +static void print_prev_insn_state(struct bpf_verifier_env *env,
> >> > +                                 const struct bpf_func_state *state)
> >> > +{
> >> > +       if (env->prev_log_len == env->log.len_used) {
> >> > +               if (env->prev_log_len)
> >> > +                       bpf_vlog_reset(&env->log, env->prev_log_len - 1);
> >>
> >> I don't get this... why do we need this reset? Why just appending
> >> alignment spaces below doesn't work?
> >
> > The insn are printed via print_bpf_insn() which ends the line with a '\n', we need to
> > reset one character in order to remove the new line and print insn_state on the same
> > line. print_bpf_insn() is defined in kernel/bpf/disasm.h and used by bpf_tool as well, so I
> > didn't want to modify it.

oh, can you please leave a small comment explaining that?

> >>
> >>
> >> > +               verbose(env, "%*c;", vlog_alignment(env->prev_insn_print_len),
> >> > +                       ' ');
> >>
> >> nit: keep it on single line
> >>
> >> > +       } else
> >> > +               verbose(env, "%d:", env->insn_idx);
> >>
> >> if one branch of if/else has {}, the other one has to have them as
> >> well, even if it's a single line statement
> >>
> >> > +       print_verifier_state(env, state);
> >> > +}
> >> > +
> >> >  /* copy array src of length n * size bytes to dst. dst is reallocated if it's too
> >> >   * small to hold src. This is different from krealloc since we don't want to preserve
> >> >   * the contents of dst.
> >>
> >> [...]
> >>
> >> > @@ -9441,8 +9465,10 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
> >> >                         insn->dst_reg);
> >> >                 return -EACCES;
> >> >         }
> >> > -       if (env->log.level & BPF_LOG_LEVEL)
> >> > -               print_verifier_state(env, this_branch->frame[this_branch->curframe]);
> >> > +       if (env->log.level & BPF_LOG_LEVEL) {
> >> > +               print_prev_insn_state(
> >> > +                       env, this_branch->frame[this_branch->curframe]);
> >>
> >> nit: keep on a single line. But also is it really a "previous
> >> instruction" or still a current instruction? Maybe just
> >> "print_insn_state"? Do we have "next_insn" helper anywhere? If not,
> >> dropping this "prev_" prefix from helpers and variables would be
> >> cleaner, IMO
> >>
> >> > +       }
> >> >         return 0;
> >> >  }
> >> >
> >> > @@ -11310,17 +11336,12 @@ static int do_check(struct bpf_verifier_env *env)
> >> >                 if (need_resched())
> >> >                         cond_resched();
> >> >
> >> > -               if ((env->log.level & BPF_LOG_LEVEL2) ||
> >> > -                   (env->log.level & BPF_LOG_LEVEL && do_print_state)) {
> >> > -                       if (verifier_state_scratched(env) &&
> >> > -                           (env->log.level & BPF_LOG_LEVEL2))
> >> > -                               verbose(env, "%d:", env->insn_idx);
> >> > -                       else
> >> > -                               verbose(env, "\nfrom %d to %d%s:",
> >> > -                                       env->prev_insn_idx, env->insn_idx,
> >> > -                                       env->cur_state->speculative ?
> >> > -                                       " (speculative execution)" : "");
> >> > -                       print_verifier_state(env, state->frame[state->curframe]);
> >> > +               if (env->log.level & BPF_LOG_LEVEL1 && do_print_state) {
> >>
> >> () around bit operations
> >>
> >> > +                       verbose(env, "\nfrom %d to %d%s:\n", env->prev_insn_idx,
> >> > +                               env->insn_idx,
> >> > +                               env->cur_state->speculative ?
> >> > +                                       " (speculative execution)" :
> >> > +                                             "");
> >>
> >> it's ok to go up to 100 characters, please keep the code more readable
> >>
> >> >                         do_print_state = false;
> >> >                 }
> >> >
> >> > @@ -11331,9 +11352,17 @@ static int do_check(struct bpf_verifier_env *env)
> >> >                                 .private_data   = env,
> >> >                         };
> >> >
> >> > +                       if (verifier_state_scratched(env))
> >> > +                               print_prev_insn_state(
> >> > +                                       env, state->frame[state->curframe]);
> >> > +
> >> >                         verbose_linfo(env, env->insn_idx, "; ");
> >> > +                       env->prev_log_len = env->log.len_used;
> >> >                         verbose(env, "%d: ", env->insn_idx);
> >> >                         print_bpf_insn(&cbs, insn, env->allow_ptr_leaks);
> >> > +                       env->prev_insn_print_len =
> >> > +                               env->log.len_used - env->prev_log_len;
> >> > +                       env->prev_log_len = env->log.len_used;
> >> >                 }
> >> >
> >> >                 if (bpf_prog_is_dev_bound(env->prog->aux)) {
> >>
> >> [...]
