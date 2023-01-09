Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDBEE662412
	for <lists+bpf@lfdr.de>; Mon,  9 Jan 2023 12:21:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234242AbjAILVh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 9 Jan 2023 06:21:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233876AbjAILV2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 9 Jan 2023 06:21:28 -0500
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A486E183AE
        for <bpf@vger.kernel.org>; Mon,  9 Jan 2023 03:21:27 -0800 (PST)
Received: by mail-pj1-x1042.google.com with SMTP id l1-20020a17090a384100b00226f05b9595so7039521pjf.0
        for <bpf@vger.kernel.org>; Mon, 09 Jan 2023 03:21:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yka3n6xDbB26LBY9dS9pXuA8Tl9/i/Xm4mtmOKgRl/g=;
        b=oaCp9Y57kXmiEbpFiT6sB2ANjdCXqjLaAPLq/4XB0ptzmIrxrU0gVdhoQzwbx0L05D
         718CnbmAsyxp+8i3n9xP3Kgd02Lv+V7NHtYFte3klu7/5V97Bf85cOqblYwKCQsqmrSh
         dDCc0dSXVhkwjgKyoM8gIE6HH0Wh8HzgVEdZV+oBWBtyXkKY8Urpje1lvgkmquN4jOHz
         rgQECk54Kz7P/XNiXAYvQOrMBpiMekZGqZwWTfBCDUNAglncO2RnsGEGcIxGs6Mdh3Gt
         yI+NsXdpXJxs76MbsU57ubqfiS8Jv3tOgDReBfDBfVN+JE4jBT+KYLAMr2kQ+QWn247d
         gHDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yka3n6xDbB26LBY9dS9pXuA8Tl9/i/Xm4mtmOKgRl/g=;
        b=0DXMz+dFPgMLZQO6hL5v6N6RU3yTmCktwbzSY7C5652LHJMnbTKzIK6osTHUABtQ1f
         caM/6wgpvn4let/gFpNmbTSZ2vQ8vhR+4oTgGgdDsDxS3PvoQ8cwY4u9XEOzd5/iFVZe
         eM5mJ2m8gANNYxq9WC3JIZPbUeQMDpDQl2g1jmnWQzLmVqrUtqwTusPbZHl0WH0U1ZIw
         jsJr6HOtiXM5a0F8xJdkT8WlDQy+CE+EOrM1+r/Qzvxsbkh5HqwfctPWyf/Df/7fyiax
         Iz6IkP4+MD2FVruP/XaO+GLf+pGS88zzSohpSh2HXf2SojiOPXLhXyvzR7S8MxRJMEef
         Q+6A==
X-Gm-Message-State: AFqh2krpmt08lUY+pa3158tff9tSUWey0scS2apitH/j5kjuAfjD8skL
        USsnP4BeremjBwj1UkDbFyc=
X-Google-Smtp-Source: AMrXdXswjVOJ+oDjVKdLYCVtlymc8KR6oCTC0dfTOPJKfyXd6ZG6NTWRa8tY8EJrX9mVPB3cBIAMWQ==
X-Received: by 2002:a17:903:2d0:b0:192:b5b3:7ff5 with SMTP id s16-20020a17090302d000b00192b5b37ff5mr38375109plk.50.1673263286983;
        Mon, 09 Jan 2023 03:21:26 -0800 (PST)
Received: from localhost ([2405:201:6014:dae3:7dbb:8857:7c39:bb2a])
        by smtp.gmail.com with ESMTPSA id d2-20020a170903230200b001754fa42065sm5880137plh.143.2023.01.09.03.21.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 03:21:26 -0800 (PST)
Date:   Mon, 9 Jan 2023 16:51:24 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Joanne Koong <joannelkoong@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        David Vernet <void@manifault.com>,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: Re: [PATCH bpf-next v1 2/8] bpf: Fix missing var_off check for
 ARG_PTR_TO_DYNPTR
Message-ID: <20230109112124.ihkrsf6cjcxyhite@apollo>
References: <20230101083403.332783-1-memxor@gmail.com>
 <20230101083403.332783-3-memxor@gmail.com>
 <CAJnrk1bfWghAaSr44EC_jsQpc6hVEzKR9iCzGgru3wfedTM6HA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJnrk1bfWghAaSr44EC_jsQpc6hVEzKR9iCzGgru3wfedTM6HA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jan 06, 2023 at 06:27:06AM IST, Joanne Koong wrote:
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
> I think you meant off instead of reg->off?
>

Ack.

> > +               return -EINVAL;
> > +       }
> > +
> > +       spi = __get_spi(off);
> > +       if (spi < 1) {
> > +               verbose(env, "cannot pass in dynptr at an offset=%d\n", (int)(off + reg->var_off.value));
>
> I think you meant off instead of off + reg->var_off.value
>

Ack.

> > +               return -EINVAL;
> > +       }
>
> I think this if (spi < 1) check should have the same logic
> is_spi_bounds_valid() does (eg checking against total allocated slots
> as well). I think we can combine is_spi_bounds_valid() with this
> function and then every place we call is_spi_bounds_valid()
>

Ok, I'll combine both.

> > +       return spi;
> > +}
> > +
> >  static bool is_spi_bounds_valid(struct bpf_func_state *state, int spi, int nr_slots)
> >  {
> >         int allocated_slots = state->allocated_stack / BPF_REG_SIZE;
> > @@ -754,7 +777,9 @@ static int mark_stack_slots_dynptr(struct bpf_verifier_env *env, struct bpf_reg_
> >         enum bpf_dynptr_type type;
> >         int spi, i, id;
> >
> > -       spi = get_spi(reg->off);
> > +       spi = dynptr_get_spi(env, reg);
> > +       if (spi < 0)
> > +               return spi;
> >
> >         if (!is_spi_bounds_valid(state, spi, BPF_DYNPTR_NR_SLOTS))
> >                 return -EINVAL;
> > @@ -792,7 +817,9 @@ static int unmark_stack_slots_dynptr(struct bpf_verifier_env *env, struct bpf_re
> >         struct bpf_func_state *state = func(env, reg);
> >         int spi, i;
> >
> > -       spi = get_spi(reg->off);
> > +       spi = dynptr_get_spi(env, reg);
> > +       if (spi < 0)
> > +               return spi;
> >
> >         if (!is_spi_bounds_valid(state, spi, BPF_DYNPTR_NR_SLOTS))
> >                 return -EINVAL;
> > @@ -839,7 +866,11 @@ static bool is_dynptr_reg_valid_uninit(struct bpf_verifier_env *env, struct bpf_
> >         if (reg->type == CONST_PTR_TO_DYNPTR)
> >                 return false;
> >
> > -       spi = get_spi(reg->off);
> > +       spi = dynptr_get_spi(env, reg);
> > +       if (spi < 0)
> > +               return spi;
> > +
> > +       /* We will do check_mem_access to check and update stack bounds later */
> >         if (!is_spi_bounds_valid(state, spi, BPF_DYNPTR_NR_SLOTS))
> >                 return true;
> >
> > @@ -855,14 +886,15 @@ static bool is_dynptr_reg_valid_uninit(struct bpf_verifier_env *env, struct bpf_
> >  static bool is_dynptr_reg_valid_init(struct bpf_verifier_env *env, struct bpf_reg_state *reg)
> >  {
> >         struct bpf_func_state *state = func(env, reg);
> > -       int spi;
> > -       int i;
> > +       int spi, i;
> >
> >         /* This already represents first slot of initialized bpf_dynptr */
> >         if (reg->type == CONST_PTR_TO_DYNPTR)
> >                 return true;
> >
> > -       spi = get_spi(reg->off);
> > +       spi = dynptr_get_spi(env, reg);
> > +       if (spi < 0)
> > +               return false;
> >         if (!is_spi_bounds_valid(state, spi, BPF_DYNPTR_NR_SLOTS) ||
> >             !state->stack[spi].spilled_ptr.dynptr.first_slot)
> >                 return false;
> > @@ -891,7 +923,9 @@ static bool is_dynptr_type_expected(struct bpf_verifier_env *env, struct bpf_reg
> >         if (reg->type == CONST_PTR_TO_DYNPTR) {
> >                 return reg->dynptr.type == dynptr_type;
> >         } else {
> > -               spi = get_spi(reg->off);
> > +               spi = dynptr_get_spi(env, reg);
> > +               if (WARN_ON_ONCE(spi < 0))
> > +                       return false;
> >                 return state->stack[spi].spilled_ptr.dynptr.type == dynptr_type;
> >         }
> >  }
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
>
> nit: I dont think you need this arg_type_is_release() change
>

Ack.

> > +
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
>
> > +       if (reg->type == PTR_TO_STACK) {
> > +               err = dynptr_get_spi(env, reg);
> > +               if (err < 0)
> > +                       return err;
> >         }
>
> nit: if we do something like
>
> If (reg->type == PTR_TO_STACK) {
>     spi = dynptr_get_spi(env, reg);
>     if (spi < 0)
>         return spi;
> } else {
>     spi = __get_spi(reg->off);
> }
>
> then we can just pass in spi to is_dynptr_reg_valid_uninit() and
> is_dynptr_reg_valid_init() instead of having to recompute/check them
> again
>

Seems a little misleading to set it to something in the else branch (where stack
pointer index has no meaning), but I do see your point, I guess it can be
ignored for the other case and set to 0 by default.

> [...]
