Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8399064774E
	for <lists+bpf@lfdr.de>; Thu,  8 Dec 2022 21:29:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbiLHU3j (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 8 Dec 2022 15:29:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbiLHU3d (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 8 Dec 2022 15:29:33 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA92184B49
        for <bpf@vger.kernel.org>; Thu,  8 Dec 2022 12:29:31 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id bj12so6673203ejb.13
        for <bpf@vger.kernel.org>; Thu, 08 Dec 2022 12:29:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Q5lNP8fm7aFf/hH8aRKxsiRhXS/ftZ/GwchtzvU0R+g=;
        b=S/DPrzYHknNXagmgfSb7N27W09SyYuk2SkjpO2QFjS3e6bqufAzOgS/Q3uZLSua1Mu
         3Io5/jV+4b4j96uFRmxN75+rGOPvrpkUxxi69eUJEliyhoBFsdxQXeL7axavXQ8zGM1r
         eEXhaiMEmwKOIGjqDZ79HwgfM8ADpTcW8FItVkdYH3gdwHoiu9w6yMerEJT1GQs3boCY
         g1P+q8qKxkRxvbyeD2lfo7J7IKKD49JA92ZtzcL338Yu+vMxhm2CtLp4HbwWwUdw6uPr
         RYZ+Wj6EsbrOpKUUq9mWio6UlA/qzKFPcBtEdBpgAYy7B4PMSQQFkEE2AGFNdnvtzQFc
         OdQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q5lNP8fm7aFf/hH8aRKxsiRhXS/ftZ/GwchtzvU0R+g=;
        b=VAKE55/H3ufAH5zEr8olsPIy+XCAKJhgrnNcYeMN2IIe5tU2UyV1/4e67Ad6hXWWDB
         X2puYoaZLXlGLlXl7MSaLpmPoxuEPh0k8yvlptdABUwnfYmm2Vh2Ntrx3VFR+W1e6Fm2
         TPVDuYaKnlnuI1goVz42eqUF+V8qOk5XfzTmomaMnw9mmIJVjB4s0M5+s1BED2yqasE5
         JrxOK1yorgFixGmuSbf1snkUFNzNsmeWMIYGQhqaYy0JXlNbLcgBDFYTFiDjGZrMarb9
         eRFXmTF1woXJUQigvlVWdb+c6oPAp4NHl9J1abXE2pwBAATByrn+DPa4bj6ZwBD+C8kd
         vovQ==
X-Gm-Message-State: ANoB5pktpFhybkQKr9rEVecv3bnAbkIymj477N1ovZh3qeb35NSUUiXQ
        HSe1nu86rWgGhEjC6xxtw+RFu7dF9No12Nx1do8axr0N4zY=
X-Google-Smtp-Source: AA0mqf5Aar1YLBuaTiky9aFdcZv0bVljgq2vlgKIPQsuJ9UZIzZXurYAaM8tjEj2qPopvTJ1WmMgCV2Vjn4JTh1JzR0=
X-Received: by 2002:a17:906:30c1:b0:7b7:eaa9:c1cb with SMTP id
 b1-20020a17090630c100b007b7eaa9c1cbmr8387368ejb.745.1670531370271; Thu, 08
 Dec 2022 12:29:30 -0800 (PST)
MIME-Version: 1.0
References: <20221205011754.310580-1-eddyz87@gmail.com> <20221205011754.310580-2-eddyz87@gmail.com>
In-Reply-To: <20221205011754.310580-2-eddyz87@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 8 Dec 2022 12:29:18 -0800
Message-ID: <CAEf4BzZRN-5JM0Y8VJsaiL_WNeGFtXnyvT6V9v1QAo9BRRLB5A@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Fix to preserve reg parent/live fields
 when copying range info
To:     Eduard Zingerman <eddyz87@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com, yhs@fb.com
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

On Sun, Dec 4, 2022 at 5:18 PM Eduard Zingerman <eddyz87@gmail.com> wrote:
>
> Register range information is copied in several places. The intent is
> to transfer range/id information from one register/stack spill to
> another. Currently this is done using direct register assignment, e.g.:
>
> static void find_equal_scalars(..., struct bpf_reg_state *known_reg)
> {
>         ...
>         struct bpf_reg_state *reg;
>         ...
>                         *reg = *known_reg;
>         ...
> }
>
> However, such assignments also copy the following bpf_reg_state fields:
>
> struct bpf_reg_state {
>         ...
>         struct bpf_reg_state *parent;
>         ...
>         enum bpf_reg_liveness live;
>         ...
> };
>
> Copying of these fields is accidental and incorrect, as could be
> demonstrated by the following example:
>
>      0: call ktime_get_ns()
>      1: r6 = r0
>      2: call ktime_get_ns()
>      3: r7 = r0
>      4: if r0 > r6 goto +1             ; r0 & r6 are unbound thus generated
>                                        ; branch states are identical
>      5: *(u64 *)(r10 - 8) = 0xdeadbeef ; 64-bit write to fp[-8]
>     --- checkpoint ---
>      6: r1 = 42                        ; r1 marked as written
>      7: *(u8 *)(r10 - 8) = r1          ; 8-bit write, fp[-8] parent & live
>                                        ; overwritten
>      8: r2 = *(u64 *)(r10 - 8)
>      9: r0 = 0
>     10: exit
>
> This example is unsafe because 64-bit write to fp[-8] at (5) is
> conditional, thus not all bytes of fp[-8] are guaranteed to be set
> when it is read at (8). However, currently the example passes
> verification.
>
> First, the execution path 1-10 is examined by verifier.
> Suppose that a new checkpoint is created by is_state_visited() at (6).
> After checkpoint creation:
> - r1.parent points to checkpoint.r1,
> - fp[-8].parent points to checkpoint.fp[-8].
> At (6) the r1.live is set to REG_LIVE_WRITTEN.
> At (7) the fp[-8].parent is set to r1.parent and fp[-8].live is set to
> REG_LIVE_WRITTEN, because of the following code called in
> check_stack_write_fixed_off():
>
> static void save_register_state(struct bpf_func_state *state,
>                                 int spi, struct bpf_reg_state *reg,
>                                 int size)
> {
>         ...
>         state->stack[spi].spilled_ptr = *reg;  // <--- parent & live copied
>         if (size == BPF_REG_SIZE)
>                 state->stack[spi].spilled_ptr.live |= REG_LIVE_WRITTEN;
>         ...
> }
>
> Note the intent to mark stack spill as written only if 8 bytes are
> spilled to a slot, however this intent is spoiled by a 'live' field copy.
> At (8) the checkpoint.fp[-8] should be marked as REG_LIVE_READ but
> this does not happen:
> - fp[-8] in a current state is already marked as REG_LIVE_WRITTEN;
> - fp[-8].parent points to checkpoint.r1, parentage chain is used by
>   mark_reg_read() to mark checkpoint states.
> At (10) the verification is finished for path 1-10 and jump 4-6 is
> examined. The checkpoint.fp[-8] never gets REG_LIVE_READ mark and this
> spill is pruned from the cached states by clean_live_states(). Hence
> verifier state obtained via path 1-4,6 is deemed identical to one
> obtained via path 1-6 and program marked as safe.
>
> Note: the example should be executed with BPF_F_TEST_STATE_FREQ flag
> set to force creation of intermediate verifier states.
>
> This commit revisits the locations where bpf_reg_state instances are
> copied and replaces the direct copies with a call to a function
> copy_register_state(dst, src) that preserves 'parent' and 'live'
> fields of the 'dst'.
>
> Fixes: 679c782de14b ("bpf/verifier: per-register parent pointers")
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
>  kernel/bpf/verifier.c | 25 ++++++++++++++++++-------
>  1 file changed, 18 insertions(+), 7 deletions(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index b0db9c10567b..8b0a03aad85e 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -3181,13 +3181,24 @@ static bool __is_pointer_value(bool allow_ptr_leaks,
>         return reg->type != SCALAR_VALUE;
>  }
>
> +/* Copy src state preserving dst->parent and dst->live fields */
> +static void copy_register_state(struct bpf_reg_state *dst, const struct bpf_reg_state *src)
> +{
> +       struct bpf_reg_state *parent = dst->parent;
> +       enum bpf_reg_liveness live = dst->live;
> +
> +       *dst = *src;
> +       dst->parent = parent;
> +       dst->live = live;

It feels like liveness should always be reset when we are copying
register states like this. This copy_register_state() happens when we
do `r1 = r2`, or when we spill/restore register to stack, right? In
all of these cases we should first assume that these registers or
stack slots won't be ever read and would need to be forgotten later.
So any REG_LIVE_READ{32,64} marks should be clear.

But we are preserving old liveness for some reason. Is that intentional?

Similarly for parent pointers, I still feel like resetting parent to
NULL for such statements is the right approach here. But as you
explained offline, LIVE_WRITTEN is equivalent, so ok, fine.

Now, for your example above. I feel like `7: *(u8 *)(r10 - 8) = r1`
should go through a parental chain before we reset parent and mark
parent as READ. That is, when we forcefully turn the previous spilled
register to STACK_MISC, we are basically reading that register and
casting it to an unknown integer. Does that work or does it break
something?

Sorry, I'm repaging all the context after a few days not looking at
this, so some of those questions we might have discussed. But it would
be useful for others to also understand these subtleties.


> +}
> +
>  static void save_register_state(struct bpf_func_state *state,
>                                 int spi, struct bpf_reg_state *reg,
>                                 int size)
>  {
>         int i;
>
> -       state->stack[spi].spilled_ptr = *reg;
> +       copy_register_state(&state->stack[spi].spilled_ptr, reg);

So what I mentioned above. Here, before we copy_register_state, if
size != BPF_REG_SIZE, mark current parent as READ, and then
copy_register_state. What does this break?

>         if (size == BPF_REG_SIZE)
>                 state->stack[spi].spilled_ptr.live |= REG_LIVE_WRITTEN;
>
> @@ -3513,7 +3524,7 @@ static int check_stack_read_fixed_off(struct bpf_verifier_env *env,
>                                  */
>                                 s32 subreg_def = state->regs[dst_regno].subreg_def;
>
> -                               state->regs[dst_regno] = *reg;
> +                               copy_register_state(&state->regs[dst_regno], reg);
>                                 state->regs[dst_regno].subreg_def = subreg_def;
>                         } else {
>                                 for (i = 0; i < size; i++) {
> @@ -3534,7 +3545,7 @@ static int check_stack_read_fixed_off(struct bpf_verifier_env *env,
>
>                 if (dst_regno >= 0) {
>                         /* restore register state from stack */
> -                       state->regs[dst_regno] = *reg;
> +                       copy_register_state(&state->regs[dst_regno], reg);
>                         /* mark reg as written since spilled pointer state likely
>                          * has its liveness marks cleared by is_state_visited()
>                          * which resets stack/reg liveness for state transitions
> @@ -9407,7 +9418,7 @@ static int sanitize_ptr_alu(struct bpf_verifier_env *env,
>          */
>         if (!ptr_is_dst_reg) {
>                 tmp = *dst_reg;
> -               *dst_reg = *ptr_reg;
> +               copy_register_state(dst_reg, ptr_reg);
>         }
>         ret = sanitize_speculative_path(env, NULL, env->insn_idx + 1,
>                                         env->insn_idx);
> @@ -10660,7 +10671,7 @@ static int check_alu_op(struct bpf_verifier_env *env, struct bpf_insn *insn)
>                                          * to propagate min/max range.
>                                          */
>                                         src_reg->id = ++env->id_gen;
> -                               *dst_reg = *src_reg;
> +                               copy_register_state(dst_reg, src_reg);
>                                 dst_reg->live |= REG_LIVE_WRITTEN;
>                                 dst_reg->subreg_def = DEF_NOT_SUBREG;
>                         } else {
> @@ -10671,7 +10682,7 @@ static int check_alu_op(struct bpf_verifier_env *env, struct bpf_insn *insn)
>                                                 insn->src_reg);
>                                         return -EACCES;
>                                 } else if (src_reg->type == SCALAR_VALUE) {
> -                                       *dst_reg = *src_reg;
> +                                       copy_register_state(dst_reg, src_reg);
>                                         /* Make sure ID is cleared otherwise
>                                          * dst_reg min/max could be incorrectly
>                                          * propagated into src_reg by find_equal_scalars()
> @@ -11470,7 +11481,7 @@ static void find_equal_scalars(struct bpf_verifier_state *vstate,
>
>         bpf_for_each_reg_in_vstate(vstate, state, reg, ({
>                 if (reg->type == SCALAR_VALUE && reg->id == known_reg->id)
> -                       *reg = *known_reg;
> +                       copy_register_state(reg, known_reg);

did we discuss what should happen with precision propagation in cases
like this? These "equal scalars" are a bit mind bending, we need to
consider if by tracking precision independently for them we are going
to break anything,

>         }));
>  }
>
> --
> 2.34.1
>
