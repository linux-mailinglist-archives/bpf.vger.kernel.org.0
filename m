Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92BC865F865
	for <lists+bpf@lfdr.de>; Fri,  6 Jan 2023 01:57:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236394AbjAFA50 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 5 Jan 2023 19:57:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236402AbjAFA5V (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 5 Jan 2023 19:57:21 -0500
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10BD65E08E
        for <bpf@vger.kernel.org>; Thu,  5 Jan 2023 16:57:19 -0800 (PST)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-4b6255ce5baso3054697b3.11
        for <bpf@vger.kernel.org>; Thu, 05 Jan 2023 16:57:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NG1CqFQogmEV8XjmudJjO0rdJzuHEymK7cwCmz0OeR8=;
        b=Pl+dhnHxGDkuAX/SxjJjPeLqvVdGDG7MVyWKlBc8VEEjAN2zkn4+RhVLpTCA8KxNkr
         vuH/L3q41Kh1R5S/DuAp36Jt/I1RBywT5yLU6EVDkYlIBosg9bN5de0GuKelmRDwquKV
         W1ZY51908W/pFbPgUjX0Q3fNuJ0EO9pj6WmdoclgfhmPPAuV8zOFKxcrUjOW3MOGMlST
         pP7h4KN/KeGBUrCFR+V+pvtoXShJ1zHUW/dNHQkjJfQgEHifSppXdFTq1hsRHbLIpvUZ
         y4L3S+uXXjdm2E3RPLbP67UTGCaGfVSNUgVIol8K8tixLKeM2cRxApgLdMJIiY2GWhZR
         IWKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NG1CqFQogmEV8XjmudJjO0rdJzuHEymK7cwCmz0OeR8=;
        b=Ut99+PQ0ieFFUSXvNNjQjLFcuLk24P07295mOrHeDZFhAJ1g+tcYMZK1EsO5F+2xe/
         mqk7H09NYyOc/aws4S71EnrIdX9M3mfOki3GnRPvBFHdbbKSNGiQJzeN56PsSMtBg41q
         B3vTJG8YhbkUNmBEph3I2SdyB/1HOlJ4v6xQTHNIomUdYw/DCcvLwoGvJB+EPX0w53vw
         TuYU3CSzPCgesvla8JrpixIkESPGGhJh5XEKltDSeoLCVqMrvyus2AAuHP8xKOGhI9pv
         aMh5/hwR7bX0s4BWhuJ6y8DHjwq2nxfUxsGS32FKPGOWwF9fTTd/GIlDzE1WVr42Xsfk
         TLAg==
X-Gm-Message-State: AFqh2krAuTt9JcTQzrIYIRuXRkc9ZWGbd4xAhxN4fi1dy5JmS285uPCp
        m0lWFdPbyvhncaMxFp2a38154GNHcMNQ6zPSsRw=
X-Google-Smtp-Source: AMrXdXuKvTNhjiVDa8gaNc1MnvfzUDQgqtKgCIj5haqtek0RPmCO2SWCbrVrduO7owd8czH41MAsWrQvuFM0R4SuRd0=
X-Received: by 2002:a81:94d:0:b0:420:79d:355c with SMTP id 74-20020a81094d000000b00420079d355cmr7964527ywj.499.1672966638177;
 Thu, 05 Jan 2023 16:57:18 -0800 (PST)
MIME-Version: 1.0
References: <20230101083403.332783-1-memxor@gmail.com> <20230101083403.332783-3-memxor@gmail.com>
In-Reply-To: <20230101083403.332783-3-memxor@gmail.com>
From:   Joanne Koong <joannelkoong@gmail.com>
Date:   Thu, 5 Jan 2023 16:57:06 -0800
Message-ID: <CAJnrk1bfWghAaSr44EC_jsQpc6hVEzKR9iCzGgru3wfedTM6HA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 2/8] bpf: Fix missing var_off check for ARG_PTR_TO_DYNPTR
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

I think you meant off instead of reg->off?

> +               return -EINVAL;
> +       }
> +
> +       spi = __get_spi(off);
> +       if (spi < 1) {
> +               verbose(env, "cannot pass in dynptr at an offset=%d\n", (int)(off + reg->var_off.value));

I think you meant off instead of off + reg->var_off.value

> +               return -EINVAL;
> +       }

I think this if (spi < 1) check should have the same logic
is_spi_bounds_valid() does (eg checking against total allocated slots
as well). I think we can combine is_spi_bounds_valid() with this
function and then every place we call is_spi_bounds_valid()

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
> @@ -839,7 +866,11 @@ static bool is_dynptr_reg_valid_uninit(struct bpf_verifier_env *env, struct bpf_
>         if (reg->type == CONST_PTR_TO_DYNPTR)
>                 return false;
>
> -       spi = get_spi(reg->off);
> +       spi = dynptr_get_spi(env, reg);
> +       if (spi < 0)
> +               return spi;
> +
> +       /* We will do check_mem_access to check and update stack bounds later */
>         if (!is_spi_bounds_valid(state, spi, BPF_DYNPTR_NR_SLOTS))
>                 return true;
>
> @@ -855,14 +886,15 @@ static bool is_dynptr_reg_valid_uninit(struct bpf_verifier_env *env, struct bpf_
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
> @@ -891,7 +923,9 @@ static bool is_dynptr_type_expected(struct bpf_verifier_env *env, struct bpf_reg
>         if (reg->type == CONST_PTR_TO_DYNPTR) {
>                 return reg->dynptr.type == dynptr_type;
>         } else {
> -               spi = get_spi(reg->off);
> +               spi = dynptr_get_spi(env, reg);
> +               if (WARN_ON_ONCE(spi < 0))
> +                       return false;
>                 return state->stack[spi].spilled_ptr.dynptr.type == dynptr_type;
>         }
>  }
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

nit: I dont think you need this arg_type_is_release() change

> +
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

nit: if we do something like

If (reg->type == PTR_TO_STACK) {
    spi = dynptr_get_spi(env, reg);
    if (spi < 0)
        return spi;
} else {
    spi = __get_spi(reg->off);
}

then we can just pass in spi to is_dynptr_reg_valid_uninit() and
is_dynptr_reg_valid_init() instead of having to recompute/check them
again

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
> @@ -6479,7 +6518,9 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
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
> index 78debc1b3820..32df3647b794 100644
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
> @@ -444,7 +444,7 @@ int invalid_write2(void *ctx)
>   * non-const offset
>   */
>  SEC("?raw_tp")
> -__failure __msg("Expected an initialized dynptr as arg #1")
> +__failure __msg("arg 1 is an unacquired reference")
>  int invalid_write3(void *ctx)
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
> 2.39.0
>
