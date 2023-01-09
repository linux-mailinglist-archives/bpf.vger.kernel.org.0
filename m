Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66CAF662407
	for <lists+bpf@lfdr.de>; Mon,  9 Jan 2023 12:19:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236732AbjAILTZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 9 Jan 2023 06:19:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236892AbjAILSz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 9 Jan 2023 06:18:55 -0500
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6052815F30
        for <bpf@vger.kernel.org>; Mon,  9 Jan 2023 03:18:19 -0800 (PST)
Received: by mail-pj1-x1041.google.com with SMTP id z9-20020a17090a468900b00226b6e7aeeaso9067839pjf.1
        for <bpf@vger.kernel.org>; Mon, 09 Jan 2023 03:18:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BV4do77qCq438iwRAnDFsstMaiPzE6dqLtHdDBv2L7Q=;
        b=b3lB6+8PDt7Zki0N37iDeKdLy8amyabk5Vvh59u6GD+3546+jZBIyCwvKnWdsjgI2f
         J4ub7/G0Acudjap9iyNf12L7Vz6FzdmyntcbWlTwJP+IGje1FIuYrnPnyenLceuUJdUT
         /9knMx75pnK+vDR+PIHcwHNM7Cg8/bbO3pOjBXAKcEEbQUrZifMw/ScDEsnkHbz8pVC4
         Lx4TCUxr71vE65hZd+gaRKt80iBAdaa1ELNTsllMqdp5IELbRk1uBank72fQOzNcIjE4
         AKChvn3lBws9KAqO36zhFlWF4REXWxEtc7HAxsaEIilVuZXSmqfqi+IPYhWUZau/Ts+N
         f9vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BV4do77qCq438iwRAnDFsstMaiPzE6dqLtHdDBv2L7Q=;
        b=7wG3uZIPUs5KwY2y/cO9ATq92YqWjHirmIf/KBZZk9V3QBpH1PQEa70JsBFCOP+YnY
         E7Ewt3H5gMeLT1+VLvXSjQyQDQlSuTwZ9MDIY68u/Fmn/rjm+JUx3XfoIo2yTtS9igPJ
         XXjdu9stOuX0fH7kJVqr9s3wGwk4O9T6VX7Bzz22cPmhzNmoP2P/lb+yCxFj49W6aDtb
         nyn8kFhOKG0JLo3FRcxlifeD/mWZZLQdNg3BBN6QZY9PreT7wktdpkS06CYcXDLyG44p
         iQHvwWMnHdYmXT6TFtrmFnRpYS3AJ/jx9JcFNZcQrAvEqI6AoYqDksGSHr1A7A//h8ru
         OYEQ==
X-Gm-Message-State: AFqh2koLH4YkomUUzlBjfNyWKwbfmub93qmC68so2SC44jJlBwyfVGlF
        WmaVjzMzKerMoZFTGt0Ne3GejPL44zw=
X-Google-Smtp-Source: AMrXdXsHdJbm64Q2m04EpToAPzv/XtnN1oVt+1A5SCgJgGN/L5dgNhb3dLknVTODgLX7YO9lUdGMJg==
X-Received: by 2002:a17:90a:5b08:b0:227:1214:e7a6 with SMTP id o8-20020a17090a5b0800b002271214e7a6mr3222330pji.33.1673263098796;
        Mon, 09 Jan 2023 03:18:18 -0800 (PST)
Received: from localhost ([2405:201:6014:dae3:7dbb:8857:7c39:bb2a])
        by smtp.gmail.com with ESMTPSA id 12-20020a17090a000c00b00225daca646csm3688343pja.34.2023.01.09.03.18.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 03:18:18 -0800 (PST)
Date:   Mon, 9 Jan 2023 16:48:15 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Joanne Koong <joannelkoong@gmail.com>,
        David Vernet <void@manifault.com>,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: Re: [PATCH bpf-next v1 2/8] bpf: Fix missing var_off check for
 ARG_PTR_TO_DYNPTR
Message-ID: <20230109111815.ifb6nkrehjrgivut@apollo>
References: <20230101083403.332783-1-memxor@gmail.com>
 <20230101083403.332783-3-memxor@gmail.com>
 <CAEf4BzZ9-n+F8DoFHCskW9iQ3BZsUBB4ua2TwWdcyYXTjOvHjg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzZ9-n+F8DoFHCskW9iQ3BZsUBB4ua2TwWdcyYXTjOvHjg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jan 05, 2023 at 04:02:11AM IST, Andrii Nakryiko wrote:
> On Sun, Jan 1, 2023 at 12:34 AM Kumar Kartikeya Dwivedi
> <memxor@gmail.com> wrote:
> >
> > Currently, the dynptr function is not checking the variable offset part
> > of PTR_TO_STACK that it needs to check. The fixed offset is considered
> > when computing the stack pointer index, but if the variable offset was
> > not a constant (such that it could not be accumulated in reg->off), we
> > will end up a discrepency where runtime pointer does not point to the
> > actual stack slot we mark as STACK_DYNPTR.
> >
> > It is impossible to precisely track dynptr state when variable offset is
> > not constant, hence, just like bpf_timer, kptr, bpf_spin_lock, etc.
> > simply reject the case where reg->var_off is not constant. Then,
> > consider both reg->off and reg->var_off.value when computing the stack
> > pointer index.
> >
> > A new helper dynptr_get_spi is introduced to hide over these details
> > since the dynptr needs to be located in multiple places outside the
> > process_dynptr_func checks, hence once we know it's a PTR_TO_STACK, we
> > need to enforce these checks in all places.
> >
> > Note that it is disallowed for unprivileged users to have a non-constant
> > var_off, so this problem should only be possible to trigger from
> > programs having CAP_PERFMON. However, its effects can vary.
> >
> > Without the fix, it is possible to replace the contents of the dynptr
> > arbitrarily by making verifier mark different stack slots than actual
> > location and then doing writes to the actual stack address of dynptr at
> > runtime.
> >
> > Fixes: 97e03f521050 ("bpf: Add verifier support for dynptrs")
> > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > ---
> >  kernel/bpf/verifier.c                         | 83 ++++++++++++++-----
> >  .../bpf/prog_tests/kfunc_dynptr_param.c       |  2 +-
> >  .../testing/selftests/bpf/progs/dynptr_fail.c |  6 +-
> >  3 files changed, 66 insertions(+), 25 deletions(-)
> >
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index f7248235e119..ca970f80e395 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -638,11 +638,34 @@ static void print_liveness(struct bpf_verifier_env *env,
> >                 verbose(env, "D");
> >  }
> >
> > -static int get_spi(s32 off)
> > +static int __get_spi(s32 off)
> >  {
> >         return (-off - 1) / BPF_REG_SIZE;
> >  }
> >
> > +static int dynptr_get_spi(struct bpf_verifier_env *env, struct bpf_reg_state *reg)
> > +{
> > +       int off, spi;
> > +
> > +       if (!tnum_is_const(reg->var_off)) {
> > +               verbose(env, "dynptr has to be at the constant offset\n");
> > +               return -EINVAL;
> > +       }
> > +
> > +       off = reg->off + reg->var_off.value;
> > +       if (off % BPF_REG_SIZE) {
> > +               verbose(env, "cannot pass in dynptr at an offset=%d\n", reg->off);
>
> s/reg->off/off/ ?
>

Yep, thanks for catching.

> > +               return -EINVAL;
> > +       }
> > +
> > +       spi = __get_spi(off);
> > +       if (spi < 1) {
> > +               verbose(env, "cannot pass in dynptr at an offset=%d\n", (int)(off + reg->var_off.value));
>
> s/(int)(off + reg->var_off.value)/off/?
>

Same, yes.

> > +               return -EINVAL;
> > +       }
> > +       return spi;
> > +}
> > +
>
> [...]
>
> > @@ -2422,7 +2456,9 @@ static int mark_dynptr_read(struct bpf_verifier_env *env, struct bpf_reg_state *
> >          */
> >         if (reg->type == CONST_PTR_TO_DYNPTR)
> >                 return 0;
> > -       spi = get_spi(reg->off);
> > +       spi = dynptr_get_spi(env, reg);
> > +       if (WARN_ON_ONCE(spi < 0))
> > +               return spi;
> >         /* Caller ensures dynptr is valid and initialized, which means spi is in
> >          * bounds and spi is the first dynptr slot. Simply mark stack slot as
> >          * read.
> > @@ -5946,6 +5982,11 @@ static int process_kptr_func(struct bpf_verifier_env *env, int regno,
> >         return 0;
> >  }
> >
> > +static bool arg_type_is_release(enum bpf_arg_type type)
> > +{
> > +       return type & OBJ_RELEASE;
> > +}
> > +
>
> no need to move it?
>

Yeah, will fix.

> >  /* There are two register types representing a bpf_dynptr, one is PTR_TO_STACK
> >   * which points to a stack slot, and the other is CONST_PTR_TO_DYNPTR.
> >   *
> > @@ -5986,12 +6027,14 @@ int process_dynptr_func(struct bpf_verifier_env *env, int regno,
> >         }
> >         /* CONST_PTR_TO_DYNPTR already has fixed and var_off as 0 due to
> >          * check_func_arg_reg_off's logic. We only need to check offset
> > -        * alignment for PTR_TO_STACK.
> > +        * and its alignment for PTR_TO_STACK.
> >          */
> > -       if (reg->type == PTR_TO_STACK && (reg->off % BPF_REG_SIZE)) {
> > -               verbose(env, "cannot pass in dynptr at an offset=%d\n", reg->off);
> > -               return -EINVAL;
> > +       if (reg->type == PTR_TO_STACK) {
> > +               err = dynptr_get_spi(env, reg);
> > +               if (err < 0)
> > +                       return err;
> >         }
> > +
> >         /*  MEM_UNINIT - Points to memory that is an appropriate candidate for
> >          *               constructing a mutable bpf_dynptr object.
> >          *
> > @@ -6070,11 +6113,6 @@ static bool arg_type_is_mem_size(enum bpf_arg_type type)
> >                type == ARG_CONST_SIZE_OR_ZERO;
> >  }
> >
> > -static bool arg_type_is_release(enum bpf_arg_type type)
> > -{
> > -       return type & OBJ_RELEASE;
> > -}
> > -
> >  static bool arg_type_is_dynptr(enum bpf_arg_type type)
> >  {
> >         return base_type(type) == ARG_PTR_TO_DYNPTR;
> > @@ -6404,8 +6442,9 @@ static u32 dynptr_ref_obj_id(struct bpf_verifier_env *env, struct bpf_reg_state
>
> why not make dynptr_ref_obj_id return int and <0 on error? There seems
> to be just one place where we call dynptr_ref_obj_id and we can check
> and report error there
>

Good suggestion, I'll make that change.

> >
> >         if (reg->type == CONST_PTR_TO_DYNPTR)
> >                 return reg->ref_obj_id;
> > -
> > -       spi = get_spi(reg->off);
> > +       spi = dynptr_get_spi(env, reg);
> > +       if (WARN_ON_ONCE(spi < 0))
> > +               return U32_MAX;
> >         return state->stack[spi].spilled_ptr.ref_obj_id;
> >  }
> >
>
> [...]
