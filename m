Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 989AE622099
	for <lists+bpf@lfdr.de>; Wed,  9 Nov 2022 01:05:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbiKIAFn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Nov 2022 19:05:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiKIAFm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Nov 2022 19:05:42 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5C3F5F84B
        for <bpf@vger.kernel.org>; Tue,  8 Nov 2022 16:05:40 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id ft34so6329522ejc.12
        for <bpf@vger.kernel.org>; Tue, 08 Nov 2022 16:05:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CPobiEfFFBGkWRbf4YKKxxo9zTGGJu27Rf5DBnp3IHc=;
        b=b8SCX6HMRIONNqXQcinEtJ4B28MF8zqBx5LJjtRSit6LiX5dkh1wcNMFf2j3mL0U1P
         F8/EcFDPTjNz2Ae4SVAYF+wQ9RekAsMzExyG0bAWAryhTwOboYcoH+WeOGuOuU3LXd20
         Re8eCYKYZqSB9COjPfU3GujoSva6LAD77pEi+LscseCMqjsSEYaUj6KYhDkhHUj0T0/5
         aB8OJFvjSNY3QAzvUWai7CAwLZX61oqDxwclfzf+Rit/ylomgwmhQlVoXu2jtTdR3kTc
         JN4YT2kJiL1LyYJu4PdXVp+mvmxNiOZYEep8gQiYu9uaVfVVcuGN8pros5rKz318ZOpo
         ZI0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CPobiEfFFBGkWRbf4YKKxxo9zTGGJu27Rf5DBnp3IHc=;
        b=RMWRNLZiNT+9kOkJCfFAVda9QrubYHmcNyDzTXUVBG+4m8POAQjIpwUQt2CSCec/tj
         fqpIWU/9zSMF8SGLBJ/Ih7eDFCeec6XcQnXVX+fhvk8pdSPjcJYKXwoxSkM4jnJHsYYr
         11H9kWzIujE96oFLXR/OcYsVPlfAdpOJ6OruGeH0a0UuFIxF/EysYpfv4hkiv7bfxzk/
         /FO1KOnGJfT9i6bueJx9s24x2Se34QJsZCiLTfPA4tbVYknsgV7QUVAeni+bwhqFm3rn
         lfh4RiSxl/LNm8koPdXml7WRRwyct7cm1F74AUdmiT4DbQ4Raq2B66871HI1FaEzdIps
         qMvA==
X-Gm-Message-State: ANoB5pk+RshWbCpusUMewQ4bcs+aiUYtpmy09BTPgWihqBnftd0ELxJ+
        g8cgympSbwMfyFpzzbU7bqOxOnnREz+f1g8PiS4=
X-Google-Smtp-Source: AA0mqf6VC7FNz1qYGEhN2xS4Q1YOys31cOE6hUXqX5DKglSzQzbenX+YDn6Lc2b2luB7gdNMmm+d785DApe1iPb7wFg=
X-Received: by 2002:a17:906:4e86:b0:7ae:8d01:81f8 with SMTP id
 v6-20020a1709064e8600b007ae8d0181f8mr743640eju.115.1667952339236; Tue, 08 Nov
 2022 16:05:39 -0800 (PST)
MIME-Version: 1.0
References: <20221107230950.7117-1-memxor@gmail.com> <20221107230950.7117-16-memxor@gmail.com>
In-Reply-To: <20221107230950.7117-16-memxor@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 8 Nov 2022 16:05:26 -0800
Message-ID: <CAEf4BzaJbT0pN-tDXAgD67q3JyhjmRmyRRKYsiyjk6musyGdSQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 15/25] bpf: Teach verifier about non-size
 constant arguments
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>,
        Delyan Kratunov <delyank@meta.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Nov 7, 2022 at 3:10 PM Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
>
> Currently, the verifier has support for various arguments that either
> describe the size of the memory being passed in to a helper, or describe
> the size of the memory being returned. When a constant is passed in like
> this, it is assumed for the purposes of precision tracking that if the
> value in the already explored safe state is within the value in current
> state, it would fine to prune the search.
>
> While this holds well for size arguments, arguments where each value may
> denote a distinct meaning and needs to be verified separately needs more
> work. Search can only be pruned if both are equivalent values. In all
> other cases, it would be incorrect to treat those two precise registers
> as equivalent if the new value satisfies the old one (i.e. old <= cur).
>
> Hence, make the register precision marker tri-state. There are now three
> values that reg->precise takes: NOT_PRECISE, PRECISE, EXACT.
>
> Both PRECISE and EXACT are 'true' values. EXACT affects how regsafe
> decides whether both registers are equivalent for the purposes of
> verifier state equivalence. When it sees that old state register has
> reg->precise == EXACT, unless both are equivalent, it will return false.
> Otherwise, for PRECISE case it falls back to the default check that is
> present now (i.e. thinking that we're talking about sizes).
>
> This is required as a future patch introduces a BPF memory allocator
> interface, where we take the program BTF's type ID as an argument. Each
> distinct type ID may result in the returned pointer obtaining a
> different size, hence precision tracking is needed, and pruning cannot
> just happen when the old value is within the current value. It must only
> happen when the type ID is equal. The type ID will always correspond to
> prog->aux->btf hence actual type match is not required.
>
> Finally, change mark_chain_precision precision argument to EXACT for
> kfuncs constant non-size scalar arguments (tagged with __k suffix).
>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---

I think this needs a bit more thinking, tbh. First, with my recent
changes we don't even set precision marks in current state, everything
stays imprecise. And then under CAP_BPF we also aggressively reset
precision. This might work for EXACT, but needs careful consideration.

But, taking a step back. I'm trying to understand why this whole EXACT
mode is necessary. SCALAR has min/max values which regsafe() does
check. So for those special ___k arguments, if we correctly set
min/max values to be *exactly* the btf_id passed in, why would
regsafe()'s logic not work?

>  include/linux/bpf_verifier.h |  10 +++-
>  kernel/bpf/verifier.c        | 111 ++++++++++++++++++++++-------------
>  2 files changed, 76 insertions(+), 45 deletions(-)
>
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index f3a601d33fb3..1e246ec2ff37 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -43,6 +43,12 @@ enum bpf_reg_liveness {
>         REG_LIVE_DONE = 0x8, /* liveness won't be updating this register anymore */
>  };
>
> +enum bpf_reg_precise {
> +       NOT_PRECISE,

IMPRECISE?

> +       PRECISE,
> +       EXACT,
> +};
> +
>  struct bpf_reg_state {
>         /* Ordering of fields matters.  See states_equal() */
>         enum bpf_reg_type type;
> @@ -180,7 +186,7 @@ struct bpf_reg_state {
>         s32 subreg_def;
>         enum bpf_reg_liveness live;
>         /* if (!precise && SCALAR_VALUE) min/max/tnum don't affect safety */
> -       bool precise;
> +       enum bpf_reg_precise precise;
>  };
>
>  enum bpf_stack_slot_type {
> @@ -626,8 +632,6 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
>                             struct bpf_attach_target_info *tgt_info);
>  void bpf_free_kfunc_btf_tab(struct bpf_kfunc_btf_tab *tab);
>
> -int mark_chain_precision(struct bpf_verifier_env *env, int regno);
> -
>  #define BPF_BASE_TYPE_MASK     GENMASK(BPF_BASE_TYPE_BITS - 1, 0)
>
>  /* extract base type from bpf_{arg, return, reg}_type. */
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 7515b31d2c40..5bfc151711b9 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -864,7 +864,7 @@ static void print_verifier_state(struct bpf_verifier_env *env,
>                 print_liveness(env, reg->live);
>                 verbose(env, "=");
>                 if (t == SCALAR_VALUE && reg->precise)
> -                       verbose(env, "P");
> +                       verbose(env, reg->precise == EXACT ? "E" : "P");
>                 if ((t == SCALAR_VALUE || t == PTR_TO_STACK) &&
>                     tnum_is_const(reg->var_off)) {
>                         /* reg->off should be 0 for SCALAR_VALUE */
> @@ -961,7 +961,7 @@ static void print_verifier_state(struct bpf_verifier_env *env,
>                         t = reg->type;
>                         verbose(env, "=%s", t == SCALAR_VALUE ? "" : reg_type_str(env, t));
>                         if (t == SCALAR_VALUE && reg->precise)
> -                               verbose(env, "P");
> +                               verbose(env, reg->precise == EXACT ? "E" : "P");
>                         if (t == SCALAR_VALUE && tnum_is_const(reg->var_off))
>                                 verbose(env, "%lld", reg->var_off.value + reg->off);
>                 } else {
> @@ -1695,7 +1695,16 @@ static void __mark_reg_unknown(const struct bpf_verifier_env *env,
>         reg->type = SCALAR_VALUE;
>         reg->var_off = tnum_unknown;
>         reg->frameno = 0;
> -       reg->precise = !env->bpf_capable;
> +       /* Helpers requiring EXACT for constant arguments cannot be called from
> +        * programs without CAP_BPF. This is because we don't propagate
> +        * precision markers when CAP_BPF is missing. If we allowed calling such
> +        * heleprs in those programs, the default would have to be EXACT for
> +        * them, which would be too aggresive, or we'd have to propagate it.

typos: helpers, aggressive

> +        *
> +        * Currently, only bpf_obj_new kfunc requires EXACT precision for its
> +        * scalar argument, which is a kfunc (and thus behind CAP_BPF).
> +        */
> +       reg->precise = !env->bpf_capable ? PRECISE : NOT_PRECISE;
>         __mark_reg_unbounded(reg);
>  }
>

[...]

>         /* Do sanity checks against current state of register and/or stack
>          * slot, but don't set precise flag in current state, as precision
> @@ -2969,7 +2982,7 @@ static int __mark_chain_precision(struct bpf_verifier_env *env, int frame, int r
>                                                 reg_mask &= ~(1u << i);
>                                                 continue;
>                                         }
> -                                       reg->precise = true;
> +                                       reg->precise = precise;
>                                 }
>                                 return 0;
>                         }
> @@ -2988,7 +3001,7 @@ static int __mark_chain_precision(struct bpf_verifier_env *env, int frame, int r
>                                 err = backtrack_insn(env, i, &reg_mask, &stack_mask);
>                         }
>                         if (err == -ENOTSUPP) {
> -                               mark_all_scalars_precise(env, st);
> +                               mark_all_scalars_precise(env, st, precise);

well... do you really intend to remark everything as EXACT, even
registers that have no business of being EXACT? Seems a bit too blunt.

>                                 return 0;
>                         } else if (err) {
>                                 return err;
> @@ -3029,7 +3042,7 @@ static int __mark_chain_precision(struct bpf_verifier_env *env, int frame, int r
>                         }
>                         if (!reg->precise)
>                                 new_marks = true;
> -                       reg->precise = true;
> +                       reg->precise = precise;
>                 }
>
>                 bitmap_from_u64(mask, stack_mask);

[...]
