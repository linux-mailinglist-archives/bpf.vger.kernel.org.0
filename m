Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46DF5476ABC
	for <lists+bpf@lfdr.de>; Thu, 16 Dec 2021 08:02:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234287AbhLPHCq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Dec 2021 02:02:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231981AbhLPHCq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 16 Dec 2021 02:02:46 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0830C061574
        for <bpf@vger.kernel.org>; Wed, 15 Dec 2021 23:02:45 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id 131so61975215ybc.7
        for <bpf@vger.kernel.org>; Wed, 15 Dec 2021 23:02:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4XCC3WSledHomnohHTLTlzujgs+HLAhH3IpVH9hYrkQ=;
        b=iEwtlxAoKK5C508cVNBf/F1HH2zXfGYmLB+pe9zaSykJ/I4mutPe96jjtm06WKIaKJ
         bR5BZEerbR5/eyq4Z70wgvjmzs2daRRUKfQqnE1CpQnuXgRu2bchYr1loed8JtHu+z2H
         ekcjkYAUef55YO8FJoUdZgraQlkYjU0Inw/Wk7Zum8I1GB25Q1RsrJimwFtr/Ok6ROOY
         j348yr843R/1ZUc6yEi7DxkFt7ZC3XgNrVcdGbwA5GetHjkNkFj6cu70LKete1SPs8GU
         t96XtRuJ0BYWKSDxpcZnTlpcDLNwB1k3CKsFN7nIr3DM/FJm411BkiiG95BF0lv8ZccM
         DXJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4XCC3WSledHomnohHTLTlzujgs+HLAhH3IpVH9hYrkQ=;
        b=j7Tt/HNW+8mFzoxsLgkuID8QCvlPGYGJ7FBYaqzvhPJLF7yafbdVJKwnWHbq7Z9GEt
         F5mHPj79Y/AKKxD8y8O34Fd85OE31gM9gdaXWAaFLUbJOAgwJZhn2NW77EMya3KZstyP
         hQjQW/Wdl9Wkuyo81FVOPbULHwtUMdJ7tZcgZWf2O0EU/ByRjwwMjhDzGQCfJw9lP9Bj
         UHymNO5KVcljAAhFPlUl28Rp1ASXJ85vlSvfWNM/E+juFcrGciVrSmQsvGyBrRrwGGuK
         G8KzKZZRP7/eZawKuE6cCzG0hD5cXcfKhZQzuTBQBcdvpDrZcH460aDtFDoLdG4S2Wyu
         DU9Q==
X-Gm-Message-State: AOAM5309k/sajw+Iml/WvkfPuOMx1N3sRnVUTI5wO21tnemNMbO0MYc8
        vwevD9xEf6Vwk4e4wAZHEtbQSoaO+fDj8L5iv1S6dpjhuKA=
X-Google-Smtp-Source: ABdhPJw6gMnXhWR+aiY56ZzCZYjbADjt9IBVT6GYsC5TrXmgFjwBWCyjptzL7CEkwVEDYK4zawdA2LyE2Ua7SzZRCuU=
X-Received: by 2002:a25:4ed4:: with SMTP id c203mr11878716ybb.529.1639638165126;
 Wed, 15 Dec 2021 23:02:45 -0800 (PST)
MIME-Version: 1.0
References: <20211215192225.1278237-1-christylee@fb.com> <20211215192225.1278237-3-christylee@fb.com>
In-Reply-To: <20211215192225.1278237-3-christylee@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 15 Dec 2021 23:02:33 -0800
Message-ID: <CAEf4BzZvpODHJ-ca7yifmYBvqw+7ysR5A+HHPVDKHBs8XMzr-A@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 2/3] Right align verifier states in verifier logs
To:     Christy Lee <christylee@fb.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>, christyc.y.lee@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Dec 15, 2021 at 11:22 AM Christy Lee <christylee@fb.com> wrote:
>
> Make the verifier logs more readable, print the verifier states
> on the corresponding instruction line. If the previous line was
> not a bpf instruction, then print the verifier states on its own
> line.
>
> Before:
>
> Validating test_pkt_access_subprog3() func#3...
> 86: R1=invP(id=0) R2=ctx(id=0,off=0,imm=0) R10=fp0
> ; int test_pkt_access_subprog3(int val, struct __sk_buff *skb)
> 86: (bf) r6 = r2
> 87: R2=ctx(id=0,off=0,imm=0) R6_w=ctx(id=0,off=0,imm=0)
> 87: (bc) w7 = w1
> 88: R1=invP(id=0) R7_w=invP(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff))
> ; return get_skb_len(skb) * get_skb_ifindex(val, skb, get_constant(123));
> 88: (bf) r1 = r6
> 89: R1_w=ctx(id=0,off=0,imm=0) R6_w=ctx(id=0,off=0,imm=0)
> 89: (85) call pc+9
> Func#4 is global and valid. Skipping.
> 90: R0_w=invP(id=0)
> 90: (bc) w8 = w0
> 91: R0_w=invP(id=0) R8_w=invP(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff))
> ; return get_skb_len(skb) * get_skb_ifindex(val, skb, get_constant(123));
> 91: (b7) r1 = 123
> 92: R1_w=invP123
> 92: (85) call pc+65
> Func#5 is global and valid. Skipping.
> 93: R0=invP(id=0)
>
> After:
>
> Validating test_pkt_access_subprog3() func#3...
> 86: R1=invP(id=0) R2=ctx(id=0,off=0,imm=0) R10=fp0
> ; int test_pkt_access_subprog3(int val, struct __sk_buff *skb)
> 86: (bf) r6 = r2               ; R2=ctx(id=0,off=0,imm=0) R6_w=ctx(id=0,off=0,imm=0)
> 87: (bc) w7 = w1               ; R1=invP(id=0) R7_w=invP(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff))
> ; return get_skb_len(skb) * get_skb_ifindex(val, skb, get_constant(123));
> 88: (bf) r1 = r6               ; R1_w=ctx(id=0,off=0,imm=0) R6_w=ctx(id=0,off=0,imm=0)
> 89: (85) call pc+9
> Func#4 is global and valid. Skipping.
> 90: R0_w=invP(id=0)
> 90: (bc) w8 = w0               ; R0_w=invP(id=0) R8_w=invP(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff))
> ; return get_skb_len(skb) * get_skb_ifindex(val, skb, get_constant(123));
> 91: (b7) r1 = 123              ; R1_w=invP123
> 92: (85) call pc+65
> Func#5 is global and valid. Skipping.
> 93: R0=invP(id=0)

There seems to be quite a lot of jumpin back and forth in terms of
33th (see off by one error below) vs 40th offsets (this is for
pyperf50 test):

16: (07) r2 += -8               ; R2_w=fp-8
; Event* event = bpf_map_lookup_elem(&eventmap, &zero);
17: (18) r1 = 0xffff88810d81dc00       ;
R1_w=map_ptr(id=0,off=0,ks=4,vs=252,imm=0)
19: (85) call bpf_map_lookup_elem#1    ;
R0=map_value_or_null(id=3,off=0,ks=4,vs=252,imm=0)
20: (bf) r7 = r0                ;
R0=map_value_or_null(id=3,off=0,ks=4,vs=252,imm=0)
R7_w=map_value_or_null(id=3,off=0,ks=4,vs=252,imm=0)
; if (!event)
21: (15) if r7 == 0x0 goto pc+5193     ;
R7_w=map_value(id=0,off=0,ks=4,vs=252,imm=0)
; event->pid = pid;
22: (61) r1 = *(u32 *)(r10 -4)  ;
R1_w=inv(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff)) R10=fp0

Maybe let's bump the minimum to 40?

>
> Signed-off-by: Christy Lee <christylee@fb.com>
> ---
>  include/linux/bpf_verifier.h                  |   3 +
>  kernel/bpf/verifier.c                         |  69 ++++--
>  .../testing/selftests/bpf/prog_tests/align.c  | 196 ++++++++++--------
>  3 files changed, 156 insertions(+), 112 deletions(-)
>
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index c555222c97d6..cf5801c02216 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -388,6 +388,8 @@ static inline bool bpf_verifier_log_full(const struct bpf_verifier_log *log)
>  #define BPF_LOG_LEVEL  (BPF_LOG_LEVEL1 | BPF_LOG_LEVEL2)
>  #define BPF_LOG_MASK   (BPF_LOG_LEVEL | BPF_LOG_STATS)
>  #define BPF_LOG_KERNEL (BPF_LOG_MASK + 1) /* kernel internal flag */
> +#define BPF_LOG_MIN_ALIGNMENT 8
> +#define BPF_LOG_ALIGNMENT_POS 32
>
>  static inline bool bpf_verifier_log_needed(const struct bpf_verifier_log *log)
>  {
> @@ -481,6 +483,7 @@ struct bpf_verifier_env {
>         u32 scratched_regs;
>         /* Same as scratched_regs but for stack slots */
>         u64 scratched_stack_slots;
> +       u32 prev_log_len, prev_insn_print_len;
>  };
>
>  __printf(2, 0) void bpf_verifier_vlog(struct bpf_verifier_log *log,
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index f4228864a3e9..a8f1426b0367 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -795,6 +795,27 @@ static void print_verifier_state(struct bpf_verifier_env *env,
>         mark_verifier_state_clean(env);
>  }
>
> +static u32 vlog_alignment(u32 prev_insn_print_len)
> +{
> +       if (prev_insn_print_len < BPF_LOG_ALIGNMENT_POS)
> +               return BPF_LOG_ALIGNMENT_POS - prev_insn_print_len + 1;

why +1 here?

> +       return round_up(prev_insn_print_len, BPF_LOG_MIN_ALIGNMENT) -
> +              prev_insn_print_len;
> +}
> +
> +static void print_prev_insn_state(struct bpf_verifier_env *env,
> +                                 const struct bpf_func_state *state)
> +{
> +       if (env->prev_log_len == env->log.len_used) {
> +               if (env->prev_log_len)
> +                       bpf_vlog_reset(&env->log, env->prev_log_len - 1);

I don't get this... why do we need this reset? Why just appending
alignment spaces below doesn't work?

> +               verbose(env, "%*c;", vlog_alignment(env->prev_insn_print_len),
> +                       ' ');

nit: keep it on single line

> +       } else
> +               verbose(env, "%d:", env->insn_idx);

if one branch of if/else has {}, the other one has to have them as
well, even if it's a single line statement

> +       print_verifier_state(env, state);
> +}
> +
>  /* copy array src of length n * size bytes to dst. dst is reallocated if it's too
>   * small to hold src. This is different from krealloc since we don't want to preserve
>   * the contents of dst.

[...]

> @@ -9441,8 +9465,10 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
>                         insn->dst_reg);
>                 return -EACCES;
>         }
> -       if (env->log.level & BPF_LOG_LEVEL)
> -               print_verifier_state(env, this_branch->frame[this_branch->curframe]);
> +       if (env->log.level & BPF_LOG_LEVEL) {
> +               print_prev_insn_state(
> +                       env, this_branch->frame[this_branch->curframe]);

nit: keep on a single line. But also is it really a "previous
instruction" or still a current instruction? Maybe just
"print_insn_state"? Do we have "next_insn" helper anywhere? If not,
dropping this "prev_" prefix from helpers and variables would be
cleaner, IMO

> +       }
>         return 0;
>  }
>
> @@ -11310,17 +11336,12 @@ static int do_check(struct bpf_verifier_env *env)
>                 if (need_resched())
>                         cond_resched();
>
> -               if ((env->log.level & BPF_LOG_LEVEL2) ||
> -                   (env->log.level & BPF_LOG_LEVEL && do_print_state)) {
> -                       if (verifier_state_scratched(env) &&
> -                           (env->log.level & BPF_LOG_LEVEL2))
> -                               verbose(env, "%d:", env->insn_idx);
> -                       else
> -                               verbose(env, "\nfrom %d to %d%s:",
> -                                       env->prev_insn_idx, env->insn_idx,
> -                                       env->cur_state->speculative ?
> -                                       " (speculative execution)" : "");
> -                       print_verifier_state(env, state->frame[state->curframe]);
> +               if (env->log.level & BPF_LOG_LEVEL1 && do_print_state) {

() around bit operations

> +                       verbose(env, "\nfrom %d to %d%s:\n", env->prev_insn_idx,
> +                               env->insn_idx,
> +                               env->cur_state->speculative ?
> +                                       " (speculative execution)" :
> +                                             "");

it's ok to go up to 100 characters, please keep the code more readable

>                         do_print_state = false;
>                 }
>
> @@ -11331,9 +11352,17 @@ static int do_check(struct bpf_verifier_env *env)
>                                 .private_data   = env,
>                         };
>
> +                       if (verifier_state_scratched(env))
> +                               print_prev_insn_state(
> +                                       env, state->frame[state->curframe]);
> +
>                         verbose_linfo(env, env->insn_idx, "; ");
> +                       env->prev_log_len = env->log.len_used;
>                         verbose(env, "%d: ", env->insn_idx);
>                         print_bpf_insn(&cbs, insn, env->allow_ptr_leaks);
> +                       env->prev_insn_print_len =
> +                               env->log.len_used - env->prev_log_len;
> +                       env->prev_log_len = env->log.len_used;
>                 }
>
>                 if (bpf_prog_is_dev_bound(env->prog->aux)) {

[...]
