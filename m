Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFA966606F6
	for <lists+bpf@lfdr.de>; Fri,  6 Jan 2023 20:16:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbjAFTQj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 6 Jan 2023 14:16:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjAFTQi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 6 Jan 2023 14:16:38 -0500
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 544E694
        for <bpf@vger.kernel.org>; Fri,  6 Jan 2023 11:16:35 -0800 (PST)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-4c15c4fc8ccso35071597b3.4
        for <bpf@vger.kernel.org>; Fri, 06 Jan 2023 11:16:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+Qh4gPAvfjVplm2twqnS3ANWJHectrMhdFMUftO1Zjk=;
        b=i9OEgoxRKww3g6SwdTHQ4eXYYxu5QqEswGjNFJh10eRINU99LCy+wgDFojEsfLfVlN
         4PE6ORFtckEBRszwVdeBaR4lUZNTy7lRzt7Y35x0KhjERntGqip9CdpMeugGPSH9pqj1
         vxt+gnSfyTOV7qJLDO1sl2wlBWtQDZwhftdDoLnGwGBE/4XWfN2hPNA5rRPitW6JysF0
         8YbC8mkGc/wBlU81iNS78LR1VbqS5Wh4k8aASDR08JLY27sjjpUkENGo/Tngxdx8siYw
         mdCjmmQo+vyrg1wRpPcovbFml8ZMfXrZ/uoomoFUAI35R5EDDVIG9JzZIOt2sdkGSVVh
         Ehnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+Qh4gPAvfjVplm2twqnS3ANWJHectrMhdFMUftO1Zjk=;
        b=NgbuhZB17sZT/W95q4gkH1GmB5n5jB8/fCbsRkUGEpokxr1D8vD3q1NV/QiQ/WfMgv
         240dWoSZcX2xBhMU31y7ry6te83OMACN6CKEL8bupIbnpS1Ah+w3TySEBNwmXk1H/Tgo
         qYrBUGmpbL+I2geJpVRTpAFaeefwHj4NhHe/RTLKqP4tTN2g3uKVhGRI4RuJL2ik/K7s
         vk2XfQyf7iBrJiKo8WVdLmGE2CxDjngZZXlwCv/GtdFjcMHc6FvbADMGEXdZPn+JTIgs
         328RVlVCUG6M5siEl9jI2HVHJNOZiq9rtqWsxjC33LjGtnUs3beVFJfZg7z7jgxFm7+1
         vjQg==
X-Gm-Message-State: AFqh2kqEQNHdcUNOP2pypmkZwhyLCFpfwGm1MBJZ3ZPS3myrM3sR4c1b
        PVDfYPB7OvK7Mg+2lyw020PN4hJxa8StKjm6KJU=
X-Google-Smtp-Source: AMrXdXtSzOciWgjsAkNc1HOMWqhoa4TVaZy9bbeKNFL4YqO60fxTO7qz1ELL4h334s+oU5gOTym5nlU60fB62h6Trec=
X-Received: by 2002:a05:690c:a93:b0:461:f491:4f97 with SMTP id
 ci19-20020a05690c0a9300b00461f4914f97mr256471ywb.513.1673032594385; Fri, 06
 Jan 2023 11:16:34 -0800 (PST)
MIME-Version: 1.0
References: <20230101083403.332783-1-memxor@gmail.com> <20230101083403.332783-4-memxor@gmail.com>
In-Reply-To: <20230101083403.332783-4-memxor@gmail.com>
From:   Joanne Koong <joannelkoong@gmail.com>
Date:   Fri, 6 Jan 2023 11:16:23 -0800
Message-ID: <CAJnrk1akSFoHx=4nVwqSBJ4Dedh6M5bYm+UdZq3CSG3PM+05WQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 3/8] bpf: Fix partial dynptr stack slot reads/writes
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
> Currently, while reads are disallowed for dynptr stack slots, writes are
> not. Reads don't work from both direct access and helpers, while writes
> do work in both cases, but have the effect of overwriting the slot_type.
>
> While this is fine, handling for a few edge cases is missing. Firstly,
> a user can overwrite the stack slots of dynptr partially.
>
> Consider the following layout:
> spi: [d][d][?]
>       2  1  0
>
> First slot is at spi 2, second at spi 1.
> Now, do a write of 1 to 8 bytes for spi 1.
>
> This will essentially either write STACK_MISC for all slot_types or
> STACK_MISC and STACK_ZERO (in case of size < BPF_REG_SIZE partial write
> of zeroes). The end result is that slot is scrubbed.
>
> Now, the layout is:
> spi: [d][m][?]
>       2  1  0
>
> Suppose if user initializes spi = 1 as dynptr.
> We get:
> spi: [d][d][d]
>       2  1  0
>
> But this time, both spi 2 and spi 1 have first_slot = true.
>
> Now, when passing spi 2 to dynptr helper, it will consider it as
> initialized as it does not check whether second slot has first_slot ==
> false. And spi 1 should already work as normal.
>
> This effectively replaced size + offset of first dynptr, hence allowing
> invalid OOB reads and writes.
>
> Make a few changes to protect against this:
> When writing to PTR_TO_STACK using BPF insns, when we touch spi of a
> STACK_DYNPTR type, mark both first and second slot (regardless of which
> slot we touch) as STACK_INVALID. Reads are already prevented.
>
> Second, prevent writing to stack memory from helpers if the range may
> contain any STACK_DYNPTR slots. Reads are already prevented.
>
> For helpers, we cannot allow it to destroy dynptrs from the writes as
> depending on arguments, helper may take uninit_mem and dynptr both at
> the same time. This would mean that helper may write to uninit_mem
> before it reads the dynptr, which would be bad.
>
> PTR_TO_MEM: [?????dd]
>
> Depending on the code inside the helper, it may end up overwriting the
> dynptr contents first and then read those as the dynptr argument.
>
> Verifier would only simulate destruction when it does byte by byte
> access simulation in check_helper_call for meta.access_size, and
> fail to catch this case, as it happens after argument checks.
>
> The same would need to be done for any other non-trivial objects created
> on the stack in the future, such as bpf_list_head on stack, or
> bpf_rb_root on stack.
>
> A common misunderstanding in the current code is that MEM_UNINIT means
> writes, but note that writes may also be performed even without
> MEM_UNINIT in case of helpers, in that case the code after handling meta
> && meta->raw_mode will complain when it sees STACK_DYNPTR. So that
> invalid read case also covers writes to potential STACK_DYNPTR slots.
> The only loophole was in case of meta->raw_mode which simulated writes
> through instructions which could overwrite them.
>
> A future series sequenced after this will focus on the clean up of
> helper access checks and bugs around that.
>
> Fixes: 97e03f521050 ("bpf: Add verifier support for dynptrs")
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  kernel/bpf/verifier.c | 73 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 73 insertions(+)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index ca970f80e395..b985d90505cc 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -769,6 +769,8 @@ static void mark_dynptr_cb_reg(struct bpf_reg_state *reg,
>         __mark_dynptr_reg(reg, type, true);
>  }
>
> +static void destroy_stack_slots_dynptr(struct bpf_verifier_env *env,
> +                                      struct bpf_func_state *state, int spi);
>
>  static int mark_stack_slots_dynptr(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
>                                    enum bpf_arg_type arg_type, int insn_idx)
> @@ -858,6 +860,44 @@ static int unmark_stack_slots_dynptr(struct bpf_verifier_env *env, struct bpf_re
>         return 0;
>  }
>
> +static void destroy_stack_slots_dynptr(struct bpf_verifier_env *env,
> +                                      struct bpf_func_state *state, int spi)
> +{
> +       int i;
> +
> +       /* We always ensure that STACK_DYNPTR is never set partially,
> +        * hence just checking for slot_type[0] is enough. This is
> +        * different for STACK_SPILL, where it may be only set for
> +        * 1 byte, so code has to use is_spilled_reg.
> +        */
> +       if (state->stack[spi].slot_type[0] != STACK_DYNPTR)
> +               return;

nit: an empty line here helps readability

> +       /* Reposition spi to first slot */
> +       if (!state->stack[spi].spilled_ptr.dynptr.first_slot)
> +               spi = spi + 1;
> +
> +       mark_stack_slot_scratched(env, spi);
> +       mark_stack_slot_scratched(env, spi - 1);
> +
> +       /* Writing partially to one dynptr stack slot destroys both. */
> +       for (i = 0; i < BPF_REG_SIZE; i++) {
> +               state->stack[spi].slot_type[i] = STACK_INVALID;
> +               state->stack[spi - 1].slot_type[i] = STACK_INVALID;
> +       }
> +
> +       /* Do not release reference state, we are destroying dynptr on stack,
> +        * not using some helper to release it. Just reset register.
> +        */

I agree with Andrii's point - I think it'd be more helpful if we error
out here if the dynptr is refcounted. It'd be easy to check too, we
already have dynptr_type_refcounted().

> +       __mark_reg_not_init(env, &state->stack[spi].spilled_ptr);
> +       __mark_reg_not_init(env, &state->stack[spi - 1].spilled_ptr);
> +
> +       /* Same reason as unmark_stack_slots_dynptr above */
> +       state->stack[spi].spilled_ptr.live |= REG_LIVE_WRITTEN;
> +       state->stack[spi - 1].spilled_ptr.live |= REG_LIVE_WRITTEN;
> +
> +       return;

I think we should also invalidate any data slices associated with the
dynptrs? It seems natural that once a dynptr is invalidated, none of
its data slices should be usable.

> +}
> +
>  static bool is_dynptr_reg_valid_uninit(struct bpf_verifier_env *env, struct bpf_reg_state *reg)
>  {
>         struct bpf_func_state *state = func(env, reg);
> @@ -3384,6 +3424,8 @@ static int check_stack_write_fixed_off(struct bpf_verifier_env *env,
>                         env->insn_aux_data[insn_idx].sanitize_stack_spill = true;
>         }
>
> +       destroy_stack_slots_dynptr(env, state, spi);
> +
>         mark_stack_slot_scratched(env, spi);
>         if (reg && !(off % BPF_REG_SIZE) && register_is_bounded(reg) &&
>             !register_is_null(reg) && env->bpf_capable) {
> @@ -3497,6 +3539,13 @@ static int check_stack_write_var_off(struct bpf_verifier_env *env,
>         if (err)
>                 return err;
>
> +       for (i = min_off; i < max_off; i++) {
> +               int slot, spi;
> +
> +               slot = -i - 1;
> +               spi = slot / BPF_REG_SIZE;

I think you can just use __get_spi() here

> +               destroy_stack_slots_dynptr(env, state, spi);

I think here too,

if (state->stack[spi].slot_type[0] == STACK_DYNPTR)
    destroy_stack_slots_dynptr(env, state, spi)

makes it more readable.

And if it is a STACK_DYNPTR, we can also fast-forward i.

> +       }
>
>         /* Variable offset writes destroy any spilled pointers in range. */
>         for (i = min_off; i < max_off; i++) {
> @@ -5524,6 +5573,30 @@ static int check_stack_range_initialized(
>         }
>
>         if (meta && meta->raw_mode) {
> +               /* Ensure we won't be overwriting dynptrs when simulating byte
> +                * by byte access in check_helper_call using meta.access_size.
> +                * This would be a problem if we have a helper in the future
> +                * which takes:
> +                *
> +                *      helper(uninit_mem, len, dynptr)
> +                *
> +                * Now, uninint_mem may overlap with dynptr pointer. Hence, it
> +                * may end up writing to dynptr itself when touching memory from
> +                * arg 1. This can be relaxed on a case by case basis for known
> +                * safe cases, but reject due to the possibilitiy of aliasing by
> +                * default.
> +                */
> +               for (i = min_off; i < max_off + access_size; i++) {
> +                       slot = -i - 1;
> +                       spi = slot / BPF_REG_SIZE;

nit: here too, we can use __get_spi()

> +                       /* raw_mode may write past allocated_stack */
> +                       if (state->allocated_stack <= slot)
> +                               continue;
> +                       if (state->stack[spi].slot_type[slot % BPF_REG_SIZE] == STACK_DYNPTR) {
> +                               verbose(env, "potential write to dynptr at off=%d disallowed\n", i);
> +                               return -EACCES;
> +                       }
> +               }
>                 meta->access_size = access_size;
>                 meta->regno = regno;
>                 return 0;
> --
> 2.39.0
>
