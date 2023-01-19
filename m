Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E9716745C3
	for <lists+bpf@lfdr.de>; Thu, 19 Jan 2023 23:18:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbjASWSF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 19 Jan 2023 17:18:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbjASWRd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 19 Jan 2023 17:17:33 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D845817CC1
        for <bpf@vger.kernel.org>; Thu, 19 Jan 2023 14:00:14 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id e202so4389284ybh.11
        for <bpf@vger.kernel.org>; Thu, 19 Jan 2023 14:00:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DsJzYYAWj+j7NPhU5U2dOnuWxTeZfxSTaGaWmr1iscc=;
        b=iJqj1mohewisO0e+e5wywxVXG8DKfOYxOE3XdcaGBHSXRHlIlSzNDJT4beIknGp6ll
         4hW8t0Ki572G+WPtWzY736Xdu9kTLzUuHgMLophp/SZScS3FF5A0+modp+8UCg+nXuP3
         RK5OHi/Kf9PC8DEPCWiHN+z9p9islcXhphksm2tMvoZf9lz99pkL3X3dK+Jq7pzF5gs5
         ZpJNWJ6nqvU8i7M4zlCVMv+1zuyfALOpJcNm2nlqTeg8GiY+1QIHA/lAoPoB1YmLpyMC
         hZeXPi3TAemzeJWsOizW6itJo82PUS/tlIccqbsssax8CbcQ6f9Njlrh51ne5roRXn4n
         CCGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DsJzYYAWj+j7NPhU5U2dOnuWxTeZfxSTaGaWmr1iscc=;
        b=McWqU0XawmTNQVIYBkrFZuFNt4ixrlXxgGLOOwuSqkvvpnvrN1EsfjY3VnbaiDZMEq
         4o0tL0RyCCBj12JgWhqvku56yYV0dXGM1ovX/R/n5Z4GHH0InczoLh88zTs8EPS+JG4G
         QSmRcWI0660EKDbTBWDikK49eOd5KCUVc+Yy4tuK4Xm42lQhJwWViwFUH3kPw1f5rDty
         wcftVdunL1LTbnLjWjUG+kdZtbXcA6uLYQsMLiwNvv7hS0x0WMrZOc9vkEu1C+zXiI+X
         PTGr/lvE7fOMFheD95jrpuE2Gwe8/BlM6IZV0XUOzA14nYK6xxR0tVKWZOFEYTtQLFlm
         i8zw==
X-Gm-Message-State: AFqh2krqSkY0eDx7W8mdsHZ3R1MGP5wmVK0gNppKKrenMBdLBDBW7GCF
        QyBZOd+NiD85ar150MiMmMpNP+AHfgtcN8ATyog=
X-Google-Smtp-Source: AMrXdXsHJPkljPG1qZBfDIeEiyf66HHI5CiOsZrmmYMvYCL40U3rqC5+oFOnWQ4X72XVBk2k2Zp4LjDXY58KXtXLpwg=
X-Received: by 2002:a25:2413:0:b0:711:cae6:c734 with SMTP id
 k19-20020a252413000000b00711cae6c734mr1519439ybk.433.1674165613940; Thu, 19
 Jan 2023 14:00:13 -0800 (PST)
MIME-Version: 1.0
References: <20230119021442.1465269-1-memxor@gmail.com> <20230119021442.1465269-3-memxor@gmail.com>
In-Reply-To: <20230119021442.1465269-3-memxor@gmail.com>
From:   Joanne Koong <joannelkoong@gmail.com>
Date:   Thu, 19 Jan 2023 14:00:02 -0800
Message-ID: <CAJnrk1a4j1zeztQ0nRdC7T85rxZhuf+hdpeh_7FWMioCHOjLNw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 02/11] bpf: Fix missing var_off check for ARG_PTR_TO_DYNPTR
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
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

On Wed, Jan 18, 2023 at 6:14 PM Kumar Kartikeya Dwivedi
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
>  kernel/bpf/verifier.c                         | 83 +++++++++++++++----
>  .../bpf/prog_tests/kfunc_dynptr_param.c       |  2 +-
>  .../testing/selftests/bpf/progs/dynptr_fail.c |  4 +-
>  3 files changed, 68 insertions(+), 21 deletions(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 89de5bc46f27..eeb6f1b2bd60 100644
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

nit: "at a constant offset" instead of "at the constant offset"?

> +               return -EINVAL;
> +       }
> +
> +       off = reg->off + reg->var_off.value;
> +       if (off % BPF_REG_SIZE) {
> +               verbose(env, "cannot pass in dynptr at an offset=%d\n", off);
> +               return -EINVAL;
> +       }
> +
> +       spi = __get_spi(off);
> +       if (spi < 1) {
> +               verbose(env, "cannot pass in dynptr at an offset=%d\n", off);
> +               return -EINVAL;
> +       }

I still think this if (spi < 1) check should have the same logic
is_spi_bounds_valid() does (eg checking against total allocated slots
as well). I think we can combine is_spi_bounds_valid() with this
function and then remove every place we call is_spi_bounds_valid().
WDYT?

> +       return spi;
> +}
> +
>  static bool is_spi_bounds_valid(struct bpf_func_state *state, int spi, int nr_slots)
>  {
>         int allocated_slots = state->allocated_stack / BPF_REG_SIZE;
> @@ -754,7 +777,9 @@ static int mark_stack_slots_dynptr(struct bpf_verifier_env *env, struct bpf_reg_
>         enum bpf_dynptr_type type;
>         int spi, i, id;
>
> -       spi = get_spi(reg->off);
> +       spi = dynptr_get_spi(env, reg);
> +       if (spi < 0)
> +               return spi;
>
>         if (!is_spi_bounds_valid(state, spi, BPF_DYNPTR_NR_SLOTS))
>                 return -EINVAL;
> @@ -792,7 +817,9 @@ static int unmark_stack_slots_dynptr(struct bpf_verifier_env *env, struct bpf_re
>         struct bpf_func_state *state = func(env, reg);
>         int spi, i;
>
> -       spi = get_spi(reg->off);
> +       spi = dynptr_get_spi(env, reg);
> +       if (spi < 0)
> +               return spi;
>
>         if (!is_spi_bounds_valid(state, spi, BPF_DYNPTR_NR_SLOTS))
>                 return -EINVAL;
> @@ -844,7 +871,11 @@ static bool is_dynptr_reg_valid_uninit(struct bpf_verifier_env *env, struct bpf_
>         if (reg->type == CONST_PTR_TO_DYNPTR)
>                 return false;
>
> -       spi = get_spi(reg->off);
> +       spi = dynptr_get_spi(env, reg);
> +       if (spi < 0)
> +               return false;
> +
> +       /* We will do check_mem_access to check and update stack bounds later */
>         if (!is_spi_bounds_valid(state, spi, BPF_DYNPTR_NR_SLOTS))
>                 return true;
>
> @@ -860,14 +891,15 @@ static bool is_dynptr_reg_valid_uninit(struct bpf_verifier_env *env, struct bpf_
>  static bool is_dynptr_reg_valid_init(struct bpf_verifier_env *env, struct bpf_reg_state *reg)
>  {
>         struct bpf_func_state *state = func(env, reg);
> -       int spi;
> -       int i;
> +       int spi, i;
>
>         /* This already represents first slot of initialized bpf_dynptr */
>         if (reg->type == CONST_PTR_TO_DYNPTR)
>                 return true;
>
> -       spi = get_spi(reg->off);
> +       spi = dynptr_get_spi(env, reg);
> +       if (spi < 0)
> +               return false;
>         if (!is_spi_bounds_valid(state, spi, BPF_DYNPTR_NR_SLOTS) ||
>             !state->stack[spi].spilled_ptr.dynptr.first_slot)
>                 return false;
> @@ -896,7 +928,9 @@ static bool is_dynptr_type_expected(struct bpf_verifier_env *env, struct bpf_reg
>         if (reg->type == CONST_PTR_TO_DYNPTR) {
>                 return reg->dynptr.type == dynptr_type;
>         } else {
> -               spi = get_spi(reg->off);
> +               spi = dynptr_get_spi(env, reg);
> +               if (spi < 0)
> +                       return false;
>                 return state->stack[spi].spilled_ptr.dynptr.type == dynptr_type;
>         }
>  }
> @@ -2429,7 +2463,9 @@ static int mark_dynptr_read(struct bpf_verifier_env *env, struct bpf_reg_state *
>          */
>         if (reg->type == CONST_PTR_TO_DYNPTR)
>                 return 0;
> -       spi = get_spi(reg->off);
> +       spi = dynptr_get_spi(env, reg);
> +       if (spi < 0)
> +               return spi;
>         /* Caller ensures dynptr is valid and initialized, which means spi is in
>          * bounds and spi is the first dynptr slot. Simply mark stack slot as
>          * read.
> @@ -5993,12 +6029,14 @@ int process_dynptr_func(struct bpf_verifier_env *env, int regno,
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
> @@ -6404,15 +6442,16 @@ int check_func_arg_reg_off(struct bpf_verifier_env *env,
>         }
>  }
>
> -static u32 dynptr_ref_obj_id(struct bpf_verifier_env *env, struct bpf_reg_state *reg)
> +static int dynptr_ref_obj_id(struct bpf_verifier_env *env, struct bpf_reg_state *reg)
>  {
>         struct bpf_func_state *state = func(env, reg);
>         int spi;
>
>         if (reg->type == CONST_PTR_TO_DYNPTR)
>                 return reg->ref_obj_id;
> -
> -       spi = get_spi(reg->off);
> +       spi = dynptr_get_spi(env, reg);
> +       if (spi < 0)
> +               return spi;
>         return state->stack[spi].spilled_ptr.ref_obj_id;
>  }
>
> @@ -6486,7 +6525,9 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
>                          * PTR_TO_STACK.
>                          */
>                         if (reg->type == PTR_TO_STACK) {
> -                               spi = get_spi(reg->off);
> +                               spi = dynptr_get_spi(env, reg);
> +                               if (spi < 0)
> +                                       return spi;
>                                 if (!is_spi_bounds_valid(state, spi, BPF_DYNPTR_NR_SLOTS) ||
>                                     !state->stack[spi].spilled_ptr.ref_obj_id) {
>                                         verbose(env, "arg %d is an unacquired reference\n", regno);
> @@ -7976,13 +8017,19 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
>                 for (i = 0; i < MAX_BPF_FUNC_REG_ARGS; i++) {
>                         if (arg_type_is_dynptr(fn->arg_type[i])) {
>                                 struct bpf_reg_state *reg = &regs[BPF_REG_1 + i];
> +                               int ref_obj_id;
>
>                                 if (meta.ref_obj_id) {
>                                         verbose(env, "verifier internal error: meta.ref_obj_id already set\n");
>                                         return -EFAULT;
>                                 }
>
> -                               meta.ref_obj_id = dynptr_ref_obj_id(env, reg);
> +                               ref_obj_id = dynptr_ref_obj_id(env, reg);
> +                               if (err < 0) {
> +                                       verbose(env, "verifier internal error: failed to obtain dynptr ref_obj_id\n");
> +                                       return err;
> +                               }
> +                               meta.ref_obj_id = ref_obj_id;
>                                 break;
>                         }
>                 }
> diff --git a/tools/testing/selftests/bpf/prog_tests/kfunc_dynptr_param.c b/tools/testing/selftests/bpf/prog_tests/kfunc_dynptr_param.c
> index a9229260a6ce..72800b1e8395 100644
> --- a/tools/testing/selftests/bpf/prog_tests/kfunc_dynptr_param.c
> +++ b/tools/testing/selftests/bpf/prog_tests/kfunc_dynptr_param.c
> @@ -18,7 +18,7 @@ static struct {
>         const char *expected_verifier_err_msg;
>         int expected_runtime_err;
>  } kfunc_dynptr_tests[] = {
> -       {"not_valid_dynptr", "Expected an initialized dynptr as arg #1", 0},
> +       {"not_valid_dynptr", "cannot pass in dynptr at an offset=-8", 0},
>         {"not_ptr_to_stack", "arg#0 expected pointer to stack or dynptr_ptr", 0},
>         {"dynptr_data_null", NULL, -EBADMSG},
>  };
> diff --git a/tools/testing/selftests/bpf/progs/dynptr_fail.c b/tools/testing/selftests/bpf/progs/dynptr_fail.c
> index 78debc1b3820..02d57b95cf6e 100644
> --- a/tools/testing/selftests/bpf/progs/dynptr_fail.c
> +++ b/tools/testing/selftests/bpf/progs/dynptr_fail.c
> @@ -382,7 +382,7 @@ int invalid_helper1(void *ctx)
>
>  /* A dynptr can't be passed into a helper function at a non-zero offset */
>  SEC("?raw_tp")
> -__failure __msg("Expected an initialized dynptr as arg #3")
> +__failure __msg("cannot pass in dynptr at an offset=-8")
>  int invalid_helper2(void *ctx)
>  {
>         struct bpf_dynptr ptr;
> @@ -584,7 +584,7 @@ int invalid_read4(void *ctx)
>
>  /* Initializing a dynptr on an offset should fail */
>  SEC("?raw_tp")
> -__failure __msg("invalid write to stack")
> +__failure __msg("cannot pass in dynptr at an offset=0")
>  int invalid_offset(void *ctx)
>  {
>         struct bpf_dynptr ptr;
> --
> 2.39.1
>
