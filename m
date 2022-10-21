Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78B336081D2
	for <lists+bpf@lfdr.de>; Sat, 22 Oct 2022 00:50:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbiJUWur (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Oct 2022 18:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbiJUWup (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Oct 2022 18:50:45 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99448157448
        for <bpf@vger.kernel.org>; Fri, 21 Oct 2022 15:50:41 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id e18so11122047edj.3
        for <bpf@vger.kernel.org>; Fri, 21 Oct 2022 15:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FHZGadK6QIuAsvyEjR76nOGwc60dLuUz44aJj7zQ/8w=;
        b=T2XkSGFppH/LdeydZLiz4SEbvrnCv72KdpMcS/BtxrGvE4yXrI6WqXf9t/f8BROPGS
         c5dWrXIwmyuuYaiuAJrfOFFgYNEE9Vsib02rUAqaGPZgBqndJ6PR99GJgGDyDhGouHz2
         HCXGCVKHVjXpCVMLsBU4tauBhT9cs3OkGea2HLGvCgRp2MNVqYhwyDDodxlzuP2ThRAe
         Reu8AtVh0YGMHANLTjaXKaponZkJGPoAk2jyCYkpustfxCa4q33KhSQ9qBt46g1aoSDz
         q+wMJZsyv6ppq2+b2y1Mtke4fI+CL5zyQ0OlgSz/LM4jH2MiaQItUxsbhaIOXeiS48ZC
         POxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FHZGadK6QIuAsvyEjR76nOGwc60dLuUz44aJj7zQ/8w=;
        b=bKpMIxIKd0CzZfaqA2C7SOMXtVJ9u8yI8Z85ivokGhiXRgUNiCsBDVH90MAnuCKF4H
         c/6V0ZH+tnemMzp8IMixWoINzocD1FO0hNLNrJYXQ8BU68m/viu0sxXUh+2qxxLThZx9
         hQv9KkrmTCrhO8+oRN6b0CGAEdrvQC+M6X6qPqqYCA7mJ6+9XMHTpdXSz9dj2tupOf2d
         Z+A/hR4nDahdPvw/UtlLonjv9bT+CgBqZ2PiGD9JxTrA5fVRDnLLAuLDBwyX40usxOkn
         UYHTilDdzibpbzGG2eAw9tmZ9Nd9VT5n4ZR3AQkRJQ2nfUBtVTzZqgXKZp2JrfINLyUd
         RUtA==
X-Gm-Message-State: ACrzQf2UsA8Gplpt3H+EN39E7iww3RSrrofzaF6OQwMW510G9ElXvScx
        2YfYdwKfnJSo5p1bKAomfszggivHDITwGEb0MzjJaUvczIQ=
X-Google-Smtp-Source: AMsMyM6/lMS6oq8Np9cXXAbgkKgBlOaRMJ3ROSPOyrTB/M26HqJaiKa2+lzCv2XhpUBnF/Dq8/JvUIkuKtQd4juObGI=
X-Received: by 2002:a17:907:a4e:b0:77d:94d:8148 with SMTP id
 be14-20020a1709070a4e00b0077d094d8148mr17051938ejc.607.1666392640011; Fri, 21
 Oct 2022 15:50:40 -0700 (PDT)
MIME-Version: 1.0
References: <20221018135920.726360-1-memxor@gmail.com> <20221018135920.726360-8-memxor@gmail.com>
In-Reply-To: <20221018135920.726360-8-memxor@gmail.com>
From:   Joanne Koong <joannelkoong@gmail.com>
Date:   Fri, 21 Oct 2022 15:50:28 -0700
Message-ID: <CAJnrk1Y_zn+oR3pN8bd3tHV2VubFxBc00XhcNzaWzHkSn1-UMw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 07/13] bpf: Fix partial dynptr stack slot reads/writes
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        David Vernet <void@manifault.com>
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

On Tue, Oct 18, 2022 at 6:59 AM Kumar Kartikeya Dwivedi
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

thanks for your work on this (and on the rest of the stack, which I'm
still working on reviewing)

Regarding writes leading to partial dynptr stack slots, I'm regretting
not having the verifier flat-out reject this in the first place
(instead of it being allowed but internally the stack slot gets marked
as invalid) - I think it overall ends up being more confusing to end
users, where there it's not obvious at all that writing to the dynptr
on the stack automatically invalidates it. I'm not sure whether it's
too late from a public API behavior perspective to change this or not.
ANyways, assuming it is too late, I left a few comments below.

>
> Fixes: 97e03f521050 ("bpf: Add verifier support for dynptrs")
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  kernel/bpf/verifier.c | 76 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 76 insertions(+)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 0fd73f96c5e2..89ae384ea6a7 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -740,6 +740,8 @@ static void mark_dynptr_cb_reg(struct bpf_reg_state *reg1,
>         __mark_dynptr_regs(reg1, NULL, type);
>  }
>
> +static void destroy_stack_slots_dynptr(struct bpf_verifier_env *env,
> +                                      struct bpf_func_state *state, int spi);
>
>  static int mark_stack_slots_dynptr(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
>                                    enum bpf_arg_type arg_type, int insn_idx)
> @@ -755,6 +757,9 @@ static int mark_stack_slots_dynptr(struct bpf_verifier_env *env, struct bpf_reg_
>         if (!is_spi_bounds_valid(state, spi, BPF_DYNPTR_NR_SLOTS))
>                 return -EINVAL;
>
> +       destroy_stack_slots_dynptr(env, state, spi);
> +       destroy_stack_slots_dynptr(env, state, spi - 1);

I don't think we need these two lines. mark_stack_slots_dynptr() is
called only in the case where an uninitialized dynptr is getting
initialized; is_dynptr_reg_valid_uninit() will have already been
called prior to this (in check_func_arg()), where
is_dynptr_reg_valid_uninit() will have checked that for any
uninitialized dynptr, the stack slot has not already been marked as
STACK_DYNTPR. Maybe I'm missing something in this analysis? What are
your thoughts?

> +
>         for (i = 0; i < BPF_REG_SIZE; i++) {
>                 state->stack[spi].slot_type[i] = STACK_DYNPTR;
>                 state->stack[spi - 1].slot_type[i] = STACK_DYNPTR;
> @@ -829,6 +834,44 @@ static int unmark_stack_slots_dynptr(struct bpf_verifier_env *env, struct bpf_re
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
> +       __mark_reg_not_init(env, &state->stack[spi].spilled_ptr);
> +       __mark_reg_not_init(env, &state->stack[spi - 1].spilled_ptr);
> +
> +       /* Same reason as unmark_stack_slots_dynptr above */
> +       state->stack[spi].spilled_ptr.live |= REG_LIVE_WRITTEN;
> +       state->stack[spi - 1].spilled_ptr.live |= REG_LIVE_WRITTEN;
> +
> +       return;
> +}

I think it'd be cleaner if we combined this and
unmark_stack_slots_dynptr() into one function. The logic is pretty
much the same except for if the reference state should be released.

> +
>  static bool is_dynptr_reg_valid_uninit(struct bpf_verifier_env *env, struct bpf_reg_state *reg)
>  {
>         struct bpf_func_state *state = func(env, reg);
> @@ -3183,6 +3226,8 @@ static int check_stack_write_fixed_off(struct bpf_verifier_env *env,
>                         env->insn_aux_data[insn_idx].sanitize_stack_spill = true;
>         }
>
> +       destroy_stack_slots_dynptr(env, state, spi);

If the stack slot is a dynptr, I think we can just return after this
call, else we do extra work and mark the stack slots as STACK_MISC
(3rd case in the if statement).

> +
>         mark_stack_slot_scratched(env, spi);
>         if (reg && !(off % BPF_REG_SIZE) && register_is_bounded(reg) &&
>             !register_is_null(reg) && env->bpf_capable) {
> @@ -3296,6 +3341,13 @@ static int check_stack_write_var_off(struct bpf_verifier_env *env,
>         if (err)
>                 return err;
>
> +       for (i = min_off; i < max_off; i++) {
> +               int slot, spi;
> +
> +               slot = -i - 1;
> +               spi = slot / BPF_REG_SIZE;
> +               destroy_stack_slots_dynptr(env, state, spi);
> +       }
>

Instead of calling destroy_stack_slots_dynptr() in
check_stack_write_fixed_off() and check_stack_write_var_off(), I think
calling it from check_stack_write() would be a better place. I think
that'd be more efficient as well where if it is a write to a dynptr,
we can directly return after invalidating the stack slot.

>         /* Variable offset writes destroy any spilled pointers in range. */
>         for (i = min_off; i < max_off; i++) {
> @@ -5257,6 +5309,30 @@ static int check_stack_range_initialized(
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

I think we can just use get_spi(i) here

> +                       /* raw_mode may write past allocated_stack */
> +                       if (state->allocated_stack <= slot)
> +                               continue;

break?

> +                       if (state->stack[spi].slot_type[slot % BPF_REG_SIZE] == STACK_DYNPTR) {
> +                               verbose(env, "potential write to dynptr at off=%d disallowed\n", i);
> +                               return -EACCES;
> +                       }
> +               }
>                 meta->access_size = access_size;
>                 meta->regno = regno;
>                 return 0;
> --
> 2.38.0
>
