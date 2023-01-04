Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A610565E005
	for <lists+bpf@lfdr.de>; Wed,  4 Jan 2023 23:32:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240297AbjADWci (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 4 Jan 2023 17:32:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240647AbjADWc0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 4 Jan 2023 17:32:26 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5FEC1C10F
        for <bpf@vger.kernel.org>; Wed,  4 Jan 2023 14:32:24 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id m18so85909227eji.5
        for <bpf@vger.kernel.org>; Wed, 04 Jan 2023 14:32:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WNUQbzaHxPQ9Vzi13ZQW11Lvnv1T3eBUyygJnVUR064=;
        b=C/aDdu6CmNgyd2V/zFwc96SDc/UjFEcUUC0Rup7pHaYld98gWIm5XLCDNCEisy4nC7
         TOM97zl9D3fzT5XnoDqtAfvHBV+ugZEWUFTwaP4MV63DFqOruAuCDD6RkpWpF3f5fZOr
         XCRCmoypVI8S7Cmbo3ewll/BInTupj7Y5N6/6JiBcRzoBOYLDixPecLW2bMnRPMRAcFx
         Wr2C6RBwS4ZMyOODi1XmMnxfXSUbI6TrMqqs3MVhv9wbyz4wB5FiZIPzR+k+WP5OZGxa
         JjK5p/Z0Vy1jYxjNYl2ShKaRYDjYx50+RBcCOYZEi2ZeKSjkTPRvgXY/sckY31xW/dAQ
         ZsFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WNUQbzaHxPQ9Vzi13ZQW11Lvnv1T3eBUyygJnVUR064=;
        b=0TLCZc0NwNWbxqGiOEO5BM4SakL6USdw55QDasS0/eMNnLwUAa4KLrriWPeounBEoI
         haWl0cHXSRMxXIJ646njKeB8ELaB2NQeqbbKRy9q0Cw11b+y0Vn6L37HxxlYPKLur/qo
         WPY1riore6LhpIKqQip2EdMMhAZVDI+Fg2l51X0XycFvacIA7VH62ey1XILScKIDUN0m
         rW6Vlos82CHZ+NoPcuRrfOHMijisDwaDrUkmvakscvSTXJWYWaZ088NZECXFEBFhy5Kq
         Ibi+5QwGFgWhXOp6kGlEen4M6slm3HkY5DnIa/eDWC3XL8NGakR5I5IM9G6JFJKelsEc
         5PyQ==
X-Gm-Message-State: AFqh2kol6vr1i6z7lWGcr9Pkdkl7k2ydNoOAIsWlm+2dvkqrV+ABO3GR
        JLndAG1TVoOZ7CoaFUjDPqiibAy6rL8WxFzdKBq24gWxwBo=
X-Google-Smtp-Source: AMrXdXtYadKRdCvGeres6SXp8CEpc+b8YDUIBpRTlyTVc3zbfThhD79btQM0+Co1PtM0nQdS2VLIfGNUo+AS9F2yv1M=
X-Received: by 2002:a17:906:2ccc:b0:7f3:3b2:314f with SMTP id
 r12-20020a1709062ccc00b007f303b2314fmr3797472ejr.115.1672871543392; Wed, 04
 Jan 2023 14:32:23 -0800 (PST)
MIME-Version: 1.0
References: <20230101083403.332783-1-memxor@gmail.com> <20230101083403.332783-3-memxor@gmail.com>
In-Reply-To: <20230101083403.332783-3-memxor@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 4 Jan 2023 14:32:11 -0800
Message-ID: <CAEf4BzZ9-n+F8DoFHCskW9iQ3BZsUBB4ua2TwWdcyYXTjOvHjg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 2/8] bpf: Fix missing var_off check for ARG_PTR_TO_DYNPTR
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Joanne Koong <joannelkoong@gmail.com>,
        David Vernet <void@manifault.com>,
        Eduard Zingerman <eddyz87@gmail.com>
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

On Sun, Jan 1, 2023 at 12:34 AM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> Currently, the dynptr function is not checking the variable offset part
> of PTR_TO_STACK that it needs to check. The fixed offset is considered
> when computing the stack pointer index, but if the variable offset was
> not a constant (such that it could not be accumulated in reg->off), we
> will end up a discrepency where runtime pointer does not point to the
> actual stack slot we mark as STACK_DYNPTR.
>
> It is impossible to precisely track dynptr state when variable offset is
> not constant, hence, just like bpf_timer, kptr, bpf_spin_lock, etc.
> simply reject the case where reg->var_off is not constant. Then,
> consider both reg->off and reg->var_off.value when computing the stack
> pointer index.
>
> A new helper dynptr_get_spi is introduced to hide over these details
> since the dynptr needs to be located in multiple places outside the
> process_dynptr_func checks, hence once we know it's a PTR_TO_STACK, we
> need to enforce these checks in all places.
>
> Note that it is disallowed for unprivileged users to have a non-constant
> var_off, so this problem should only be possible to trigger from
> programs having CAP_PERFMON. However, its effects can vary.
>
> Without the fix, it is possible to replace the contents of the dynptr
> arbitrarily by making verifier mark different stack slots than actual
> location and then doing writes to the actual stack address of dynptr at
> runtime.
>
> Fixes: 97e03f521050 ("bpf: Add verifier support for dynptrs")
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  kernel/bpf/verifier.c                         | 83 ++++++++++++++-----
>  .../bpf/prog_tests/kfunc_dynptr_param.c       |  2 +-
>  .../testing/selftests/bpf/progs/dynptr_fail.c |  6 +-
>  3 files changed, 66 insertions(+), 25 deletions(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index f7248235e119..ca970f80e395 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -638,11 +638,34 @@ static void print_liveness(struct bpf_verifier_env *env,
>                 verbose(env, "D");
>  }
>
> -static int get_spi(s32 off)
> +static int __get_spi(s32 off)
>  {
>         return (-off - 1) / BPF_REG_SIZE;
>  }
>
> +static int dynptr_get_spi(struct bpf_verifier_env *env, struct bpf_reg_state *reg)
> +{
> +       int off, spi;
> +
> +       if (!tnum_is_const(reg->var_off)) {
> +               verbose(env, "dynptr has to be at the constant offset\n");
> +               return -EINVAL;
> +       }
> +
> +       off = reg->off + reg->var_off.value;
> +       if (off % BPF_REG_SIZE) {
> +               verbose(env, "cannot pass in dynptr at an offset=%d\n", reg->off);

s/reg->off/off/ ?

> +               return -EINVAL;
> +       }
> +
> +       spi = __get_spi(off);
> +       if (spi < 1) {
> +               verbose(env, "cannot pass in dynptr at an offset=%d\n", (int)(off + reg->var_off.value));

s/(int)(off + reg->var_off.value)/off/?

> +               return -EINVAL;
> +       }
> +       return spi;
> +}
> +

[...]

> @@ -2422,7 +2456,9 @@ static int mark_dynptr_read(struct bpf_verifier_env *env, struct bpf_reg_state *
>          */
>         if (reg->type == CONST_PTR_TO_DYNPTR)
>                 return 0;
> -       spi = get_spi(reg->off);
> +       spi = dynptr_get_spi(env, reg);
> +       if (WARN_ON_ONCE(spi < 0))
> +               return spi;
>         /* Caller ensures dynptr is valid and initialized, which means spi is in
>          * bounds and spi is the first dynptr slot. Simply mark stack slot as
>          * read.
> @@ -5946,6 +5982,11 @@ static int process_kptr_func(struct bpf_verifier_env *env, int regno,
>         return 0;
>  }
>
> +static bool arg_type_is_release(enum bpf_arg_type type)
> +{
> +       return type & OBJ_RELEASE;
> +}
> +

no need to move it?

>  /* There are two register types representing a bpf_dynptr, one is PTR_TO_STACK
>   * which points to a stack slot, and the other is CONST_PTR_TO_DYNPTR.
>   *
> @@ -5986,12 +6027,14 @@ int process_dynptr_func(struct bpf_verifier_env *env, int regno,
>         }
>         /* CONST_PTR_TO_DYNPTR already has fixed and var_off as 0 due to
>          * check_func_arg_reg_off's logic. We only need to check offset
> -        * alignment for PTR_TO_STACK.
> +        * and its alignment for PTR_TO_STACK.
>          */
> -       if (reg->type == PTR_TO_STACK && (reg->off % BPF_REG_SIZE)) {
> -               verbose(env, "cannot pass in dynptr at an offset=%d\n", reg->off);
> -               return -EINVAL;
> +       if (reg->type == PTR_TO_STACK) {
> +               err = dynptr_get_spi(env, reg);
> +               if (err < 0)
> +                       return err;
>         }
> +
>         /*  MEM_UNINIT - Points to memory that is an appropriate candidate for
>          *               constructing a mutable bpf_dynptr object.
>          *
> @@ -6070,11 +6113,6 @@ static bool arg_type_is_mem_size(enum bpf_arg_type type)
>                type == ARG_CONST_SIZE_OR_ZERO;
>  }
>
> -static bool arg_type_is_release(enum bpf_arg_type type)
> -{
> -       return type & OBJ_RELEASE;
> -}
> -
>  static bool arg_type_is_dynptr(enum bpf_arg_type type)
>  {
>         return base_type(type) == ARG_PTR_TO_DYNPTR;
> @@ -6404,8 +6442,9 @@ static u32 dynptr_ref_obj_id(struct bpf_verifier_env *env, struct bpf_reg_state

why not make dynptr_ref_obj_id return int and <0 on error? There seems
to be just one place where we call dynptr_ref_obj_id and we can check
and report error there

>
>         if (reg->type == CONST_PTR_TO_DYNPTR)
>                 return reg->ref_obj_id;
> -
> -       spi = get_spi(reg->off);
> +       spi = dynptr_get_spi(env, reg);
> +       if (WARN_ON_ONCE(spi < 0))
> +               return U32_MAX;
>         return state->stack[spi].spilled_ptr.ref_obj_id;
>  }
>

[...]
