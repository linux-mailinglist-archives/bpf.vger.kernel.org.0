Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B67F7675FB8
	for <lists+bpf@lfdr.de>; Fri, 20 Jan 2023 22:45:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbjATVp4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 20 Jan 2023 16:45:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjATVp4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 Jan 2023 16:45:56 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0432C80892
        for <bpf@vger.kernel.org>; Fri, 20 Jan 2023 13:45:53 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id 203so8367808yby.10
        for <bpf@vger.kernel.org>; Fri, 20 Jan 2023 13:45:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+r2qkVJQ8LPVmJIGHQhdFltzXtnz/jd4B3/22NMogGc=;
        b=U+AkFISNPN+mvFiiDf3dvRB1A+DmW2UpT9evLOJI3cfG6xDA94WCTW1kbAyFmjZzNi
         HZww9iitU2AA3F/bMN/0d0QHffA1Scs/Ny45Cb/tf7hF5uHg56s3CDEb5PaZ2hbksWnA
         Pz6LWQmE1vU/VqGndkxkf/S3izJPCO1EdQ66rnrVzNAMEfI5tAvSNjFRvtltXGF4mjPq
         0X7t3yFNHEnYvg6xs3xmmetlZGPSdZDUpoZ0zmEui+0z6ku4Bxm9Rj6YjVGbF3MU4tfo
         223fhkTI/QG0G4F1q4sJFuwoVVijbDDBV5iouBfCY95pWFlu/1iUlqdW5u/CZ4p/YGRY
         bscg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+r2qkVJQ8LPVmJIGHQhdFltzXtnz/jd4B3/22NMogGc=;
        b=5Ami0VR6T5lA+sTAzOBBikMJfLkX5vISdlwelk1uTv4pkhZXGGc3spNkVbr7Pw18tN
         4dxnmOVuyqBfNdQkRn9KFRvp/1MZVLPm7Khy692f/vN1VhdR9QTkI0qcPHKVS2LT+m5A
         lSS4rj4j7u6E4VvuUJdyQn6oGwuCA0vV0e45Fhf7O2ub4/YlePD72AB8V7XjMjV/B7O/
         K9WVKpNHG+MAxODSSKYrnrDl5xgxPj/h4ob++zPGFJshbBx6dsFFKLCkO9IaFVFINnK0
         8/r404SJuTU4xzCKw/O2rHNE4aDpLLD289Ev4IvNFmoKMdYjMHHqmU4M65BB3Q7Kmfu8
         XPTw==
X-Gm-Message-State: AFqh2ko/giAl6qn7JqoeDKLXMaoFzpPlBszfZDt/cLSpuL75DvSSGDap
        5/4Y4K7fs6F7FUiyKbTKGY8AFqmvEnMozXvHjD0=
X-Google-Smtp-Source: AMrXdXtJpN6bZySxTHVbTrQrjFlXTRaUv3sbHG/+rK8t537NIq1sas/HH1AuHALwYJwASMnSHjp5h2WmEmVeznbpfeU=
X-Received: by 2002:a25:7d45:0:b0:802:b7a:4069 with SMTP id
 y66-20020a257d45000000b008020b7a4069mr322926ybc.433.1674251152099; Fri, 20
 Jan 2023 13:45:52 -0800 (PST)
MIME-Version: 1.0
References: <20230120070355.1983560-1-memxor@gmail.com> <20230120070355.1983560-5-memxor@gmail.com>
In-Reply-To: <20230120070355.1983560-5-memxor@gmail.com>
From:   Joanne Koong <joannelkoong@gmail.com>
Date:   Fri, 20 Jan 2023 13:45:41 -0800
Message-ID: <CAJnrk1a6nftb1bO72osdp7b9qBkEimKVAaES92DXecAduiv--A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 04/12] bpf: Invalidate slices on destruction
 of dynptrs on stack
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

On Thu, Jan 19, 2023 at 11:04 PM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> The previous commit implemented destroy_if_dynptr_stack_slot. It
> destroys the dynptr which given spi belongs to, but still doesn't
> invalidate the slices that belong to such a dynptr. While for the case
> of referenced dynptr, we don't allow their overwrite and return an error
> early, we still allow it and destroy the dynptr for unreferenced dynptr.
>
> To be able to enable precise and scoped invalidation of dynptr slices in
> this case, we must be able to associate the source dynptr of slices that
> have been obtained using bpf_dynptr_data. When doing destruction, only
> slices belonging to the dynptr being destructed should be invalidated,
> and nothing else. Currently, dynptr slices belonging to different
> dynptrs are indistinguishible.
>
> Hence, allocate a unique id to each dynptr (CONST_PTR_TO_DYNPTR and
> those on stack). This will be stored as part of reg->id. Whenever using
> bpf_dynptr_data, transfer this unique dynptr id to the returned
> PTR_TO_MEM_OR_NULL slice pointer, and store it in a new per-PTR_TO_MEM
> dynptr_id register state member.
>
> Finally, after establishing such a relationship between dynptrs and
> their slices, implement precise invalidation logic that only invalidates
> slices belong to the destroyed dynptr in destroy_if_dynptr_stack_slot.
>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

Acked-by: Joanne Koong <joannelkoong@gmail.com>

> ---
>  include/linux/bpf_verifier.h                  |  5 +-
>  kernel/bpf/verifier.c                         | 74 ++++++++++++++++---
>  .../testing/selftests/bpf/progs/dynptr_fail.c |  4 +-
>  3 files changed, 68 insertions(+), 15 deletions(-)
>
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 127058cfec47..aa83de1fe755 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -70,7 +70,10 @@ struct bpf_reg_state {
>                         u32 btf_id;
>                 };
>
> -               u32 mem_size; /* for PTR_TO_MEM | PTR_TO_MEM_OR_NULL */
> +               struct { /* for PTR_TO_MEM | PTR_TO_MEM_OR_NULL */
> +                       u32 mem_size;
> +                       u32 dynptr_id; /* for dynptr slices */
> +               };
>
>                 /* For dynptr stack slots */
>                 struct {
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 5c7f29ca94ec..01cb802776fd 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -255,6 +255,7 @@ struct bpf_call_arg_meta {
>         int mem_size;
>         u64 msize_max_value;
>         int ref_obj_id;
> +       int dynptr_id;
>         int map_uid;
>         int func_id;
>         struct btf *btf;
> @@ -750,23 +751,27 @@ static bool dynptr_type_refcounted(enum bpf_dynptr_type type)
>
>  static void __mark_dynptr_reg(struct bpf_reg_state *reg,
>                               enum bpf_dynptr_type type,
> -                             bool first_slot);
> +                             bool first_slot, int dynptr_id);
>
>  static void __mark_reg_not_init(const struct bpf_verifier_env *env,
>                                 struct bpf_reg_state *reg);
>
> -static void mark_dynptr_stack_regs(struct bpf_reg_state *sreg1,
> +static void mark_dynptr_stack_regs(struct bpf_verifier_env *env,
> +                                  struct bpf_reg_state *sreg1,
>                                    struct bpf_reg_state *sreg2,
>                                    enum bpf_dynptr_type type)
>  {
> -       __mark_dynptr_reg(sreg1, type, true);
> -       __mark_dynptr_reg(sreg2, type, false);
> +       int id = ++env->id_gen;
> +
> +       __mark_dynptr_reg(sreg1, type, true, id);
> +       __mark_dynptr_reg(sreg2, type, false, id);
>  }
>
> -static void mark_dynptr_cb_reg(struct bpf_reg_state *reg,
> +static void mark_dynptr_cb_reg(struct bpf_verifier_env *env,
> +                              struct bpf_reg_state *reg,
>                                enum bpf_dynptr_type type)
>  {
> -       __mark_dynptr_reg(reg, type, true);
> +       __mark_dynptr_reg(reg, type, true, ++env->id_gen);
>  }
>
>  static int destroy_if_dynptr_stack_slot(struct bpf_verifier_env *env,
> @@ -795,7 +800,7 @@ static int mark_stack_slots_dynptr(struct bpf_verifier_env *env, struct bpf_reg_
>         if (type == BPF_DYNPTR_TYPE_INVALID)
>                 return -EINVAL;
>
> -       mark_dynptr_stack_regs(&state->stack[spi].spilled_ptr,
> +       mark_dynptr_stack_regs(env, &state->stack[spi].spilled_ptr,
>                                &state->stack[spi - 1].spilled_ptr, type);
>
>         if (dynptr_type_refcounted(type)) {
> @@ -871,7 +876,9 @@ static void __mark_reg_unknown(const struct bpf_verifier_env *env,
>  static int destroy_if_dynptr_stack_slot(struct bpf_verifier_env *env,
>                                         struct bpf_func_state *state, int spi)
>  {
> -       int i;
> +       struct bpf_func_state *fstate;
> +       struct bpf_reg_state *dreg;
> +       int i, dynptr_id;
>
>         /* We always ensure that STACK_DYNPTR is never set partially,
>          * hence just checking for slot_type[0] is enough. This is
> @@ -899,7 +906,19 @@ static int destroy_if_dynptr_stack_slot(struct bpf_verifier_env *env,
>                 state->stack[spi - 1].slot_type[i] = STACK_INVALID;
>         }
>
> -       /* TODO: Invalidate any slices associated with this dynptr */
> +       dynptr_id = state->stack[spi].spilled_ptr.id;
> +       /* Invalidate any slices associated with this dynptr */
> +       bpf_for_each_reg_in_vstate(env->cur_state, fstate, dreg, ({
> +               /* Dynptr slices are only PTR_TO_MEM_OR_NULL and PTR_TO_MEM */
> +               if (dreg->type != (PTR_TO_MEM | PTR_MAYBE_NULL) && dreg->type != PTR_TO_MEM)
> +                       continue;
> +               if (dreg->dynptr_id == dynptr_id) {
> +                       if (!env->allow_ptr_leaks)
> +                               __mark_reg_not_init(env, dreg);
> +                       else
> +                               __mark_reg_unknown(env, dreg);
> +               }
> +       }));
>
>         /* Do not release reference state, we are destroying dynptr on stack,
>          * not using some helper to release it. Just reset register.
> @@ -1562,7 +1581,7 @@ static void mark_reg_known_zero(struct bpf_verifier_env *env,
>  }
>
>  static void __mark_dynptr_reg(struct bpf_reg_state *reg, enum bpf_dynptr_type type,
> -                             bool first_slot)
> +                             bool first_slot, int dynptr_id)
>  {
>         /* reg->type has no meaning for STACK_DYNPTR, but when we set reg for
>          * callback arguments, it does need to be CONST_PTR_TO_DYNPTR, so simply
> @@ -1570,6 +1589,8 @@ static void __mark_dynptr_reg(struct bpf_reg_state *reg, enum bpf_dynptr_type ty
>          */
>         __mark_reg_known_zero(reg);
>         reg->type = CONST_PTR_TO_DYNPTR;
> +       /* Give each dynptr a unique id to uniquely associate slices to it. */
> +       reg->id = dynptr_id;
>         reg->dynptr.type = type;
>         reg->dynptr.first_slot = first_slot;
>  }
> @@ -6532,6 +6553,19 @@ int check_func_arg_reg_off(struct bpf_verifier_env *env,
>         }
>  }
>
> +static int dynptr_id(struct bpf_verifier_env *env, struct bpf_reg_state *reg)
> +{
> +       struct bpf_func_state *state = func(env, reg);
> +       int spi;
> +
> +       if (reg->type == CONST_PTR_TO_DYNPTR)
> +               return reg->id;
> +       spi = dynptr_get_spi(env, reg);
> +       if (spi < 0)
> +               return spi;
> +       return state->stack[spi].spilled_ptr.id;
> +}
> +
>  static int dynptr_ref_obj_id(struct bpf_verifier_env *env, struct bpf_reg_state *reg)
>  {
>         struct bpf_func_state *state = func(env, reg);
> @@ -7601,7 +7635,7 @@ static int set_user_ringbuf_callback_state(struct bpf_verifier_env *env,
>          * callback_fn(const struct bpf_dynptr_t* dynptr, void *callback_ctx);
>          */
>         __mark_reg_not_init(env, &callee->regs[BPF_REG_0]);
> -       mark_dynptr_cb_reg(&callee->regs[BPF_REG_1], BPF_DYNPTR_TYPE_LOCAL);
> +       mark_dynptr_cb_reg(env, &callee->regs[BPF_REG_1], BPF_DYNPTR_TYPE_LOCAL);
>         callee->regs[BPF_REG_2] = caller->regs[BPF_REG_3];
>
>         /* unused */
> @@ -8107,18 +8141,31 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
>                 for (i = 0; i < MAX_BPF_FUNC_REG_ARGS; i++) {
>                         if (arg_type_is_dynptr(fn->arg_type[i])) {
>                                 struct bpf_reg_state *reg = &regs[BPF_REG_1 + i];
> -                               int ref_obj_id;
> +                               int id, ref_obj_id;
> +
> +                               if (meta.dynptr_id) {
> +                                       verbose(env, "verifier internal error: meta.dynptr_id already set\n");
> +                                       return -EFAULT;
> +                               }
>
>                                 if (meta.ref_obj_id) {
>                                         verbose(env, "verifier internal error: meta.ref_obj_id already set\n");
>                                         return -EFAULT;
>                                 }
>
> +                               id = dynptr_id(env, reg);
> +                               if (id < 0) {
> +                                       verbose(env, "verifier internal error: failed to obtain dynptr id\n");
> +                                       return id;
> +                               }
> +
>                                 ref_obj_id = dynptr_ref_obj_id(env, reg);
>                                 if (ref_obj_id < 0) {
>                                         verbose(env, "verifier internal error: failed to obtain dynptr ref_obj_id\n");
>                                         return ref_obj_id;
>                                 }
> +
> +                               meta.dynptr_id = id;
>                                 meta.ref_obj_id = ref_obj_id;
>                                 break;
>                         }
> @@ -8275,6 +8322,9 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
>                 return -EFAULT;
>         }
>
> +       if (is_dynptr_ref_function(func_id))
> +               regs[BPF_REG_0].dynptr_id = meta.dynptr_id;
> +
>         if (is_ptr_cast_function(func_id) || is_dynptr_ref_function(func_id)) {
>                 /* For release_reference() */
>                 regs[BPF_REG_0].ref_obj_id = meta.ref_obj_id;
> diff --git a/tools/testing/selftests/bpf/progs/dynptr_fail.c b/tools/testing/selftests/bpf/progs/dynptr_fail.c
> index 9dc3f23a8270..e43000c63c66 100644
> --- a/tools/testing/selftests/bpf/progs/dynptr_fail.c
> +++ b/tools/testing/selftests/bpf/progs/dynptr_fail.c
> @@ -67,7 +67,7 @@ static int get_map_val_dynptr(struct bpf_dynptr *ptr)
>   * bpf_ringbuf_submit/discard_dynptr call
>   */
>  SEC("?raw_tp")
> -__failure __msg("Unreleased reference id=1")
> +__failure __msg("Unreleased reference id=2")
>  int ringbuf_missing_release1(void *ctx)
>  {
>         struct bpf_dynptr ptr;
> @@ -80,7 +80,7 @@ int ringbuf_missing_release1(void *ctx)
>  }
>
>  SEC("?raw_tp")
> -__failure __msg("Unreleased reference id=2")
> +__failure __msg("Unreleased reference id=4")
>  int ringbuf_missing_release2(void *ctx)
>  {
>         struct bpf_dynptr ptr1, ptr2;
> --
> 2.39.1
>
