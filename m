Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC3165B12AA
	for <lists+bpf@lfdr.de>; Thu,  8 Sep 2022 04:50:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbiIHCuf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Sep 2022 22:50:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiIHCue (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Sep 2022 22:50:34 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54980BFE8E
        for <bpf@vger.kernel.org>; Wed,  7 Sep 2022 19:50:33 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id r7so8561092ile.11
        for <bpf@vger.kernel.org>; Wed, 07 Sep 2022 19:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=IEhVIgGEFJajcLRE7aSK6j3B+FJnsnFcKKgc1zrRrwM=;
        b=LkObl/fLZ5ZhZLMAz286NPgxJIDFG3CyIiUXKhv0WMg/UcqivkEwj9+00frvfdjhzm
         oAsSehdVtID6jFG+ezCVfxLgpb7rXCoDqJBU4rspdATJ2EVBWro98py25X3x143XVdig
         8JFpxfYFzC2mYoazoS6Xclit3q2M/camXanb0ALVOt+e7k6vJK35AerEEQT91+nL7rME
         bE2eCpQu+SMvEweFUQWeZUU6CNgRuBf6YB2VG2J+ejFcIUNqye5/6dLtr2wpGlK14aSC
         a+ZUC8suwa1pZlSlZa6QP7jr9Y0LvDeiurrabVCQqPGZ/o6m+0KTj7uuW5WhKW95DyMS
         D2tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=IEhVIgGEFJajcLRE7aSK6j3B+FJnsnFcKKgc1zrRrwM=;
        b=YB0bmV4nKbDYEuORyFf1ycCD723Zl8rgQjEyszSAKpZdAIDNoLsa3W9Ta9y3YfRTVJ
         1/jjvjq9lpk1wvahu78c01ZVM6qIV3+nOhpg7s9aSS5jkKwig4pylmf5I6wfntHFwbfx
         Za3LhQZTfm/ibglmm0T4eWHZXvU0uOKr2SYmNKCntl2toxjf2udbD5+N+xaGCHNoG7Ks
         g1ek1KHW5h3HF51wvYF99umswZ9PceC9zP9QjSNWLAVgHjOa7fqwA6Jz0n51UlAfCWyk
         ss93cXpSlXxUENwqCD0cEsOdi6FGCEO4bPQTQVsx/qP6OMGTBCLLiB0uhvwsaJyXwQ9j
         H7tA==
X-Gm-Message-State: ACgBeo2VYOV62HhgQd793vW0YqcoChZ41QchYLTXR1wqmySzxWs00Iwm
        v8dEFesnLAcwwXcsLGxDZfN8kUaYOpojV/oeoeA=
X-Google-Smtp-Source: AA6agR6uCbiMB7FCIoe0CJQZSRn8VrX0sX6Np8HKYtMNQzsZh8xWYbV2BmDM5ZJeyH20O8SvjKLd5Lt49HnlTgLo+Mg=
X-Received: by 2002:a05:6e02:198b:b0:2f2:d90:22a6 with SMTP id
 g11-20020a056e02198b00b002f20d9022a6mr765059ilf.219.1662605432636; Wed, 07
 Sep 2022 19:50:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220904204145.3089-1-memxor@gmail.com> <20220904204145.3089-13-memxor@gmail.com>
 <20220907221124.3dmeq2e5lf3mzijd@macbook-pro-4.dhcp.thefacebook.com>
In-Reply-To: <20220907221124.3dmeq2e5lf3mzijd@macbook-pro-4.dhcp.thefacebook.com>
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date:   Thu, 8 Sep 2022 04:49:56 +0200
Message-ID: <CAP01T76wapPi8nGVQLTVVtFPRTf-UFT63=x_+hSRB-oqr+w71g@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next v1 12/32] bpf: Teach verifier about non-size
 constant arguments
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Delyan Kratunov <delyank@fb.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 8 Sept 2022 at 00:11, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Sun, Sep 04, 2022 at 10:41:25PM +0200, Kumar Kartikeya Dwivedi wrote:
> > Currently, the verifier has support for various arguments that either
> > describe the size of the memory being passed in to a helper, or describe
> > the size of the memory being returned. When a constant is passed in like
> > this, it is assumed for the purposes of precision tracking that if the
> > value in the already explored safe state is within the value in current
> > state, it would fine to prune the search.
> >
> > While this holds well for size arguments, arguments where each value may
> > denote a distinct meaning and needs to be verified separately needs more
> > work. Search can only be pruned if both are constant values and both are
> > equal. In all other cases, it would be incorrect to treat those two
> > precise registers as equivalent if the new value satisfies the old one
> > (i.e. old <= cur).
> >
> > Hence, make the register precision marker tri-state. There are now three
> > values that reg->precise takes: NOT_PRECISE, PRECISE, PRECISE_ABSOLUTE.
> >
> > Both PRECISE and PRECISE_ABSOLUTE are 'true' values. PRECISE_ABSOLUTE
> > affects how regsafe decides whether both registers are equivalent for
> > the purposes of verifier state equivalence. When it sees that one
> > register has reg->precise == PRECISE_ABSOLUTE, unless both are absolute,
> > it will return false. When both are, it returns true only when both are
> > const and both have the same value. Otherwise, for PRECISE case it falls
> > back to the default check that is present now (i.e. thinking that we're
> > talking about sizes).
> >
> > This is required as a future patch introduces a BPF memory allocator
> > interface, where we take the program BTF's type ID as an argument. Each
> > distinct type ID may result in the returned pointer obtaining a
> > different size, hence precision tracking is needed, and pruning cannot
> > just happen when the old value is within the current value. It must only
> > happen when the type ID is equal. The type ID will always correspond to
> > prog->aux->btf hence actual type match is not required.
> >
> > Finally, change mark_chain_precision to mark_chain_precision_absolute
> > for kfuncs constant non-size scalar arguments (tagged with __k suffix).
> >
> > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > ---
> >  include/linux/bpf_verifier.h |  8 +++-
> >  kernel/bpf/verifier.c        | 93 ++++++++++++++++++++++++++----------
> >  2 files changed, 76 insertions(+), 25 deletions(-)
> >
> > diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> > index b4a11ff56054..c4d21568d192 100644
> > --- a/include/linux/bpf_verifier.h
> > +++ b/include/linux/bpf_verifier.h
> > @@ -43,6 +43,12 @@ enum bpf_reg_liveness {
> >       REG_LIVE_DONE = 0x8, /* liveness won't be updating this register anymore */
> >  };
> >
> > +enum bpf_reg_precise {
> > +     NOT_PRECISE,
> > +     PRECISE,
> > +     PRECISE_ABSOLUTE,
> > +};
>
> Can we make it less verbose ?
>
> NOT_PRECISE,
> PRECISE,
> EXACT
>

Yes, looks better.

> > +
> >  struct bpf_reg_state {
> >       /* Ordering of fields matters.  See states_equal() */
> >       enum bpf_reg_type type;
> > @@ -180,7 +186,7 @@ struct bpf_reg_state {
> >       s32 subreg_def;
> >       enum bpf_reg_liveness live;
> >       /* if (!precise && SCALAR_VALUE) min/max/tnum don't affect safety */
> > -     bool precise;
> > +     enum bpf_reg_precise precise;
>
> Have been thinking whether
>   bool precise;
>   bool exact;
> would be better,
> but doesn't look like it.
>
> >  };
> >
> >  enum bpf_stack_slot_type {
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index b28e88d6fabd..571790ac58d4 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -838,7 +838,7 @@ static void print_verifier_state(struct bpf_verifier_env *env,
> >               print_liveness(env, reg->live);
> >               verbose(env, "=");
> >               if (t == SCALAR_VALUE && reg->precise)
> > -                     verbose(env, "P");
> > +                     verbose(env, reg->precise == PRECISE_ABSOLUTE ? "PA" : "P");
>
> and here it would be just 'E'
>
> >               if ((t == SCALAR_VALUE || t == PTR_TO_STACK) &&
> >                   tnum_is_const(reg->var_off)) {
> >                       /* reg->off should be 0 for SCALAR_VALUE */
> > @@ -935,7 +935,7 @@ static void print_verifier_state(struct bpf_verifier_env *env,
> >                       t = reg->type;
> >                       verbose(env, "=%s", t == SCALAR_VALUE ? "" : reg_type_str(env, t));
> >                       if (t == SCALAR_VALUE && reg->precise)
> > -                             verbose(env, "P");
> > +                             verbose(env, reg->precise == PRECISE_ABSOLUTE ? "PA" : "P");
> >                       if (t == SCALAR_VALUE && tnum_is_const(reg->var_off))
> >                               verbose(env, "%lld", reg->var_off.value + reg->off);
> >               } else {
> > @@ -1668,7 +1668,17 @@ static void __mark_reg_unknown(const struct bpf_verifier_env *env,
> >       reg->type = SCALAR_VALUE;
> >       reg->var_off = tnum_unknown;
> >       reg->frameno = 0;
> > -     reg->precise = env->subprog_cnt > 1 || !env->bpf_capable;
> > +     /* Helpers requiring PRECISE_ABSOLUTE for constant arguments cannot be
> > +      * called from programs without CAP_BPF. This is because we don't
> > +      * propagate precision markers for when CAP_BPF is missing. If we
> > +      * allowed calling such heleprs in those programs, the default would
> > +      * have to be PRECISE_ABSOLUTE for them, which would be too aggresive.
> > +      *
> > +      * We still propagate PRECISE_ABSOLUTE when subprog_cnt > 1, hence
> > +      * those cases would still override the default PRECISE value when
> > +      * we propagate the precision markers.
> > +      */
> > +     reg->precise = (env->subprog_cnt > 1 || !env->bpf_capable) ? PRECISE : NOT_PRECISE;
> >       __mark_reg_unbounded(reg);
> >  }
> >
> > @@ -2717,7 +2727,8 @@ static int backtrack_insn(struct bpf_verifier_env *env, int idx,
> >   * For now backtracking falls back into conservative marking.
> >   */
> >  static void mark_all_scalars_precise(struct bpf_verifier_env *env,
> > -                                  struct bpf_verifier_state *st)
> > +                                  struct bpf_verifier_state *st,
> > +                                  bool absolute)
> >  {
> >       struct bpf_func_state *func;
> >       struct bpf_reg_state *reg;
> > @@ -2733,7 +2744,7 @@ static void mark_all_scalars_precise(struct bpf_verifier_env *env,
> >                               reg = &func->regs[j];
> >                               if (reg->type != SCALAR_VALUE)
> >                                       continue;
> > -                             reg->precise = true;
> > +                             reg->precise = absolute ? PRECISE_ABSOLUTE : PRECISE;
> >                       }
> >                       for (j = 0; j < func->allocated_stack / BPF_REG_SIZE; j++) {
> >                               if (!is_spilled_reg(&func->stack[j]))
> > @@ -2741,13 +2752,13 @@ static void mark_all_scalars_precise(struct bpf_verifier_env *env,
> >                               reg = &func->stack[j].spilled_ptr;
> >                               if (reg->type != SCALAR_VALUE)
> >                                       continue;
> > -                             reg->precise = true;
> > +                             reg->precise = absolute ? PRECISE_ABSOLUTE : PRECISE;
> >                       }
> >               }
> >  }
> >
> >  static int __mark_chain_precision(struct bpf_verifier_env *env, int regno,
> > -                               int spi)
> > +                               int spi, bool absolute)
>
> instead of bool pls pass enum bpf_reg_precise
>
> >  {
> >       struct bpf_verifier_state *st = env->cur_state;
> >       int first_idx = st->first_insn_idx;
> > @@ -2774,7 +2785,7 @@ static int __mark_chain_precision(struct bpf_verifier_env *env, int regno,
> >                       new_marks = true;
> >               else
> >                       reg_mask = 0;
> > -             reg->precise = true;
> > +             reg->precise = absolute ? PRECISE_ABSOLUTE : PRECISE;
> >       }
> >
> >       while (spi >= 0) {
> > @@ -2791,7 +2802,7 @@ static int __mark_chain_precision(struct bpf_verifier_env *env, int regno,
> >                       new_marks = true;
> >               else
> >                       stack_mask = 0;
> > -             reg->precise = true;
> > +             reg->precise = absolute ? PRECISE_ABSOLUTE : PRECISE;
> >               break;
> >       }
> >
> > @@ -2813,7 +2824,7 @@ static int __mark_chain_precision(struct bpf_verifier_env *env, int regno,
> >                               err = backtrack_insn(env, i, &reg_mask, &stack_mask);
> >                       }
> >                       if (err == -ENOTSUPP) {
> > -                             mark_all_scalars_precise(env, st);
> > +                             mark_all_scalars_precise(env, st, absolute);
> >                               return 0;
> >                       } else if (err) {
> >                               return err;
> > @@ -2854,7 +2865,7 @@ static int __mark_chain_precision(struct bpf_verifier_env *env, int regno,
> >                       }
> >                       if (!reg->precise)
> >                               new_marks = true;
> > -                     reg->precise = true;
> > +                     reg->precise = absolute ? PRECISE_ABSOLUTE : PRECISE;
> >               }
> >
> >               bitmap_from_u64(mask, stack_mask);
> > @@ -2873,7 +2884,7 @@ static int __mark_chain_precision(struct bpf_verifier_env *env, int regno,
> >                                * fp-8 and it's "unallocated" stack space.
> >                                * In such case fallback to conservative.
> >                                */
> > -                             mark_all_scalars_precise(env, st);
> > +                             mark_all_scalars_precise(env, st, absolute);
> >                               return 0;
> >                       }
> >
> > @@ -2888,7 +2899,7 @@ static int __mark_chain_precision(struct bpf_verifier_env *env, int regno,
> >                       }
> >                       if (!reg->precise)
> >                               new_marks = true;
> > -                     reg->precise = true;
> > +                     reg->precise = absolute ? PRECISE_ABSOLUTE : PRECISE;
> >               }
> >               if (env->log.level & BPF_LOG_LEVEL2) {
> >                       verbose(env, "parent %s regs=%x stack=%llx marks:",
> > @@ -2910,12 +2921,24 @@ static int __mark_chain_precision(struct bpf_verifier_env *env, int regno,
> >
> >  static int mark_chain_precision(struct bpf_verifier_env *env, int regno)
> >  {
> > -     return __mark_chain_precision(env, regno, -1);
> > +     return __mark_chain_precision(env, regno, -1, false);
> > +}
> > +
> > +static int mark_chain_precision_absolute(struct bpf_verifier_env *env, int regno)
> > +{
> > +     WARN_ON_ONCE(!env->bpf_capable);
> > +     return __mark_chain_precision(env, regno, -1, true);
> >  }
> >
> >  static int mark_chain_precision_stack(struct bpf_verifier_env *env, int spi)
> >  {
> > -     return __mark_chain_precision(env, -1, spi);
> > +     return __mark_chain_precision(env, -1, spi, false);
> > +}
>
> No need to fork the functions so much.
> Just add enum bpf_reg_precise to existing two functions.
>
> > +
> > +static int mark_chain_precision_absolute_stack(struct bpf_verifier_env *env, int spi)
> > +{
> > +     WARN_ON_ONCE(!env->bpf_capable);
> > +     return __mark_chain_precision(env, -1, spi, true);
> >  }
> >
> >  static bool is_spillable_regtype(enum bpf_reg_type type)
> > @@ -3253,7 +3276,7 @@ static void mark_reg_stack_read(struct bpf_verifier_env *env,
> >                * backtracking. Any register that contributed
> >                * to const 0 was marked precise before spill.
> >                */
> > -             state->regs[dst_regno].precise = true;
> > +             state->regs[dst_regno].precise = PRECISE;
> >       } else {
> >               /* have read misc data from the stack */
> >               mark_reg_unknown(env, state->regs, dst_regno);
> > @@ -7903,7 +7926,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_arg_m
> >                                       verbose(env, "R%d must be a known constant\n", regno);
> >                                       return -EINVAL;
> >                               }
> > -                             ret = mark_chain_precision(env, regno);
> > +                             ret = mark_chain_precision_absolute(env, regno);
> >                               if (ret < 0)
> >                                       return ret;
> >                               meta->arg_constant.found = true;
> > @@ -11899,9 +11922,23 @@ static bool regsafe(struct bpf_verifier_env *env, struct bpf_reg_state *rold,
> >               if (rcur->type == SCALAR_VALUE) {
> >                       if (!rold->precise && !rcur->precise)
> >                               return true;
> > -                     /* new val must satisfy old val knowledge */
> > -                     return range_within(rold, rcur) &&
> > -                            tnum_in(rold->var_off, rcur->var_off);
> > +                     /* We can only determine safety when type of precision
> > +                      * needed is same. For absolute, we must compare actual
> > +                      * value, otherwise old being within the current value
> > +                      * suffices.
> > +                      */
> > +                     if (rold->precise == PRECISE_ABSOLUTE || rcur->precise == PRECISE_ABSOLUTE) {
> > +                             /* Both should be PRECISE_ABSOLUTE for a comparison */
> > +                             if (rold->precise != rcur->precise)
> > +                                     return false;
> > +                             if (!tnum_is_const(rold->var_off) || !tnum_is_const(rcur->var_off))
> > +                                     return false;
> > +                             return rold->var_off.value == rcur->var_off.value;
>
> Probably better to do
> if (rold->precise == EXACT || rcu->precise == EXACT)
>   return false;
>
> because
>  if (equal)
>     return true;
> should have already happened if they were exact match.
>

I'll add a comment about that, just to make it clear.
and I agree with all the suggestions.
