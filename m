Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 656EE51E1FA
	for <lists+bpf@lfdr.de>; Sat,  7 May 2022 01:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344905AbiEFXeH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 6 May 2022 19:34:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1445018AbiEFXd5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 6 May 2022 19:33:57 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85F72712D4
        for <bpf@vger.kernel.org>; Fri,  6 May 2022 16:30:12 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id z18so9679816iob.5
        for <bpf@vger.kernel.org>; Fri, 06 May 2022 16:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D/EY7jRXDPDzXNxoPdzPyXE+Tamk1LTjosOj/236u7o=;
        b=ab4nMvG+13FL8IG6D/YjO/+s9gxOszTJ741VMbnIZ7DJBHyIIrDYasT56+AVUC2oYe
         jEboPYCyGTz3Gm3Yp8Dk/teI9NdFFUKEiv7aMn0JNDmg3BRl/Whs/OhaZIyTVNIzAozZ
         s2km46Rk8nkkavm4REXzakSeWWZRyL6wCBkChbp4wxn+pqkvQ6r58MpFa84a4BGVTNER
         2KIzAcZZ7jMICaYp7Mn6KN4gZndmR+HwulLMnOI2UgEac5lbp9j3oNekqPhekNVQ2lT2
         ewcCIHC8nAKf9iGwjTQ4c+TA0QU4gtaUFpDGntHjiTjyx8wX6q8/ABaZxvhnYh0QUpLI
         wniQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D/EY7jRXDPDzXNxoPdzPyXE+Tamk1LTjosOj/236u7o=;
        b=qEBDaCfeN6Vmez4nBpJxRyiZKrlr0Yf6hVGGS2kcXkYnTuuuPTH6rf4MsrkHw9LFh8
         bjzMz/iK9jwLb1YQ6ahBzq5f0ie4N0S9gKLLa6DzersA1HVsNIDf4tsslb6f5beTSg4Z
         USP0rh7rU8KPEmdm6ESfrksaICG6EzJy5uTjNIoQgjOuZPUWhDXX86kB2+VLmHhzXp4p
         6ZVV4Zu20tdgjqWVia+8AvnoTWmCOnXvS31f06dFANibWv7wHDhklVKHb2QXghwEUmbK
         NIHw1O/RIkJGPWTYa2PI9it9QaAjaJqVkMq7APj/t84odn8VRktGS3zsCPWOEpVwzeDq
         8TTA==
X-Gm-Message-State: AOAM530h0+tYc7Tapgv3FfmoFC3t9gKYJpr9kRDnY5/P+NN0ZsN2omVk
        4ySz/3mbKI4nwgMaAlBDV0M6Mpqj8W4QgPCewz4=
X-Google-Smtp-Source: ABdhPJwdSdDooigon9CjYeO1l4ZZ0aXofvLh+/N+S4IpHRjEDMqiITL/uNryjc9NCnxtVPyerkMNHKq8O6wG9qd8/K8=
X-Received: by 2002:a05:6638:2104:b0:326:1e94:efa6 with SMTP id
 n4-20020a056638210400b003261e94efa6mr2564397jaj.234.1651879811742; Fri, 06
 May 2022 16:30:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220428211059.4065379-1-joannelkoong@gmail.com> <20220428211059.4065379-3-joannelkoong@gmail.com>
In-Reply-To: <20220428211059.4065379-3-joannelkoong@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 6 May 2022 16:30:00 -0700
Message-ID: <CAEf4BzaL=JEAqhE=zLG506-Z==TJBwK40A-bon5AzhwMzhhtTQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 2/6] bpf: Add verifier support for dynptrs and
 implement malloc dynptrs
To:     Joanne Koong <joannelkoong@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Apr 28, 2022 at 2:12 PM Joanne Koong <joannelkoong@gmail.com> wrote:
>
> This patch adds the bulk of the verifier work for supporting dynamic
> pointers (dynptrs) in bpf. This patch implements malloc-type dynptrs
> through 2 new APIs (bpf_dynptr_alloc and bpf_dynptr_put) that can be
> called by a bpf program. Malloc-type dynptrs are dynptrs that dynamically
> allocate memory on behalf of the program.
>
> A bpf_dynptr is opaque to the bpf program. It is a 16-byte structure
> defined internally as:
>
> struct bpf_dynptr_kern {
>     void *data;
>     u32 size;
>     u32 offset;
> } __aligned(8);
>
> The upper 8 bits of *size* is reserved (it contains extra metadata about
> read-only status and dynptr type); consequently, a dynptr only supports
> memory less than 16 MB.
>
> The 2 new APIs for malloc-type dynptrs are:
>
> long bpf_dynptr_alloc(u32 size, u64 flags, struct bpf_dynptr *ptr);
> void bpf_dynptr_put(struct bpf_dynptr *ptr);
>
> Please note that there *must* be a corresponding bpf_dynptr_put for
> every bpf_dynptr_alloc (even if the alloc fails). This is enforced
> by the verifier.
>
> In the verifier, dynptr state information will be tracked in stack
> slots. When the program passes in an uninitialized dynptr
> (ARG_PTR_TO_DYNPTR | MEM_UNINIT), the stack slots corresponding
> to the frame pointer where the dynptr resides at are marked STACK_DYNPTR.
>
> For helper functions that take in initialized dynptrs (eg
> bpf_dynptr_read + bpf_dynptr_write which are added later in this
> patchset), the verifier enforces that the dynptr has been initialized
> properly by checking that their corresponding stack slots have been marked
> as STACK_DYNPTR. Dynptr release functions (eg bpf_dynptr_put) will clear the
> stack slots. The verifier enforces at program exit that there are no
> referenced dynptrs that haven't been released.
>
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> ---
>  include/linux/bpf.h            |  60 ++++++++-
>  include/linux/bpf_verifier.h   |  21 +++
>  include/uapi/linux/bpf.h       |  30 +++++
>  kernel/bpf/helpers.c           |  75 +++++++++++
>  kernel/bpf/verifier.c          | 225 ++++++++++++++++++++++++++++++++-
>  scripts/bpf_doc.py             |   2 +
>  tools/include/uapi/linux/bpf.h |  30 +++++
>  7 files changed, 440 insertions(+), 3 deletions(-)
>

[...]

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 4565684839f1..16b7ea54a7e0 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -187,6 +187,11 @@ struct bpf_verifier_stack_elem {
>                                           POISON_POINTER_DELTA))
>  #define BPF_MAP_PTR(X)         ((struct bpf_map *)((X) & ~BPF_MAP_PTR_UNPRIV))
>
> +/* forward declarations */

it's kind of obvious from C syntax, this comment doesn't really add value

> +static bool arg_type_is_mem_size(enum bpf_arg_type type);
> +static int acquire_reference_state(struct bpf_verifier_env *env, int insn_idx);
> +static int release_reference(struct bpf_verifier_env *env, int ref_obj_id);
> +

[...]

>  static struct bpf_func_state *func(struct bpf_verifier_env *env,
>                                    const struct bpf_reg_state *reg)
>  {
> @@ -646,6 +672,134 @@ static void mark_verifier_state_scratched(struct bpf_verifier_env *env)
>         env->scratched_stack_slots = ~0ULL;
>  }
>
> +#define DYNPTR_TYPE_FLAG_MASK          DYNPTR_TYPE_MALLOC

can this be put near where DYNPTR_TYPE_MALLOC is defined? It's quite
easy to forget to update this if it's somewhere far away

> +
> +static int arg_to_dynptr_type(enum bpf_arg_type arg_type)
> +{
> +       switch (arg_type & DYNPTR_TYPE_FLAG_MASK) {
> +       case DYNPTR_TYPE_MALLOC:
> +               return BPF_DYNPTR_TYPE_MALLOC;
> +       default:
> +               return BPF_DYNPTR_TYPE_INVALID;
> +       }
> +}
> +

[...]

> +static int unmark_stack_slots_dynptr(struct bpf_verifier_env *env, struct bpf_reg_state *reg)
> +{
> +       struct bpf_func_state *state = func(env, reg);
> +       int spi, i;
> +
> +       spi = get_spi(reg->off);
> +
> +       if (!is_spi_bounds_valid(state, spi, BPF_DYNPTR_NR_SLOTS))
> +               return -EINVAL;
> +
> +       for (i = 0; i < BPF_REG_SIZE; i++) {
> +               state->stack[spi].slot_type[i] = STACK_INVALID;
> +               state->stack[spi - 1].slot_type[i] = STACK_INVALID;
> +       }
> +
> +       /* Invalidate any slices associated with this dynptr */
> +       if (dynptr_type_refcounted(state->stack[spi].spilled_ptr.dynptr.type)) {
> +               release_reference(env, state->stack[spi].spilled_ptr.id);
> +               state->stack[spi].spilled_ptr.id = 0;
> +               state->stack[spi - 1].spilled_ptr.id = 0;
> +       }
> +
> +       state->stack[spi].spilled_ptr.dynptr.type = 0;
> +       state->stack[spi - 1].spilled_ptr.dynptr.type = 0;
> +
> +       state->stack[spi].spilled_ptr.dynptr.first_slot = false;

nit: given you marked slots as STACK_INVALID, we shouldn't even look
into spilled_ptr.dynptr, so this zeroing out isn't necessary, right?

> +
> +       return 0;
> +}
> +
> +static bool is_dynptr_reg_valid_uninit(struct bpf_verifier_env *env, struct bpf_reg_state *reg)
> +{
> +       struct bpf_func_state *state = func(env, reg);
> +       int spi = get_spi(reg->off);
> +       int i;
> +
> +       if (!is_spi_bounds_valid(state, spi, BPF_DYNPTR_NR_SLOTS))
> +               return true;

hm... if spi bounds are invalid, shouldn't that be an error?...

> +
> +       for (i = 0; i < BPF_REG_SIZE; i++) {
> +               if (state->stack[spi].slot_type[i] == STACK_DYNPTR ||
> +                   state->stack[spi - 1].slot_type[i] == STACK_DYNPTR)
> +                       return false;
> +       }
> +
> +       return true;
> +}
> +
> +static bool is_dynptr_reg_valid_init(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
> +                                    enum bpf_arg_type arg_type)
> +{
> +       struct bpf_func_state *state = func(env, reg);
> +       int spi = get_spi(reg->off);
> +       int i;
> +
> +       if (!is_spi_bounds_valid(state, spi, BPF_DYNPTR_NR_SLOTS) ||
> +           !state->stack[spi].spilled_ptr.dynptr.first_slot)
> +               return false;
> +
> +       for (i = 0; i < BPF_REG_SIZE; i++) {
> +           if (state->stack[spi].slot_type[i] != STACK_DYNPTR ||
> +               state->stack[spi - 1].slot_type[i] != STACK_DYNPTR)
> +                   return false;
> +       }

minor, but seems like it's pretty common operation to set or check all
those "microslots" to STACK_DYNPTR, would two small helpers be useful
for this (e.g., is_stack_dynptr() and set_stack_dynptr() or something
along those lines)?

> +
> +       /* ARG_PTR_TO_DYNPTR takes any type of dynptr */
> +       if (arg_type == ARG_PTR_TO_DYNPTR)
> +               return true;
> +
> +       return state->stack[spi].spilled_ptr.dynptr.type == arg_to_dynptr_type(arg_type);
> +}
> +

[...]

> @@ -5837,6 +6011,35 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
>                 bool zero_size_allowed = (arg_type == ARG_CONST_SIZE_OR_ZERO);
>
>                 err = check_mem_size_reg(env, reg, regno, zero_size_allowed, meta);
> +       } else if (arg_type_is_dynptr(arg_type)) {
> +               /* Can't pass in a dynptr at a weird offset */
> +               if (reg->off % BPF_REG_SIZE) {
> +                       verbose(env, "cannot pass in non-zero dynptr offset\n");
> +                       return -EINVAL;
> +               }
> +
> +               if (arg_type & MEM_UNINIT)  {
> +                       if (!is_dynptr_reg_valid_uninit(env, reg)) {
> +                               verbose(env, "Arg #%d dynptr has to be an uninitialized dynptr\n",
> +                                       arg + BPF_REG_1);
> +                               return -EINVAL;
> +                       }
> +
> +                       meta->uninit_dynptr_regno = arg + BPF_REG_1;

do we need a check that meta->uninit_dynptr_regno isn't already set?
I.e., prevent two uninit dynptr in a helper?

> +               } else if (!is_dynptr_reg_valid_init(env, reg, arg_type)) {
> +                       const char *err_extra = "";
> +
> +                       switch (arg_type & DYNPTR_TYPE_FLAG_MASK) {
> +                       case DYNPTR_TYPE_MALLOC:
> +                               err_extra = "malloc ";
> +                               break;
> +                       default:
> +                               break;
> +                       }
> +                       verbose(env, "Expected an initialized %sdynptr as arg #%d\n",
> +                               err_extra, arg + BPF_REG_1);
> +                       return -EINVAL;
> +               }
>         } else if (arg_type_is_alloc_size(arg_type)) {
>                 if (!tnum_is_const(reg->var_off)) {
>                         verbose(env, "R%d is not a known constant'\n",

[...]
