Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ADBD510CCF
	for <lists+bpf@lfdr.de>; Wed, 27 Apr 2022 01:45:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356102AbiDZXsw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 26 Apr 2022 19:48:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242818AbiDZXsv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 26 Apr 2022 19:48:51 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DAD822BD7
        for <bpf@vger.kernel.org>; Tue, 26 Apr 2022 16:45:41 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 17so534501lji.1
        for <bpf@vger.kernel.org>; Tue, 26 Apr 2022 16:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jEPOKtyFXOdZd7LfyAwq9MFYCjYUhsKW5k+2BFYj+vg=;
        b=NxQ0sCQ1L3x248I3/g4Toyc5DuALd9S2QDp4aycOsUPeBaNiG1ROxkjzHkLK/9uVb0
         gLNWxyYNfv4681rNTbBsPiNAZRTPSfo98tr7JM33rrjO5zb1J9q0dhzp6SiXIA3n5njo
         ZXZ/dlZ/410mHCXcRkndIznV4x0vC9uDeMBaaWSmSiHvDrg3BDofpKYkIo/WUmFLsoTM
         qVJAtmKvPFk8R+LxySrPxX2EZXiVZkY/QpU6kkXoYv8cHAUe/l2ymlk4u1v0ni3hSf7b
         EMBrql/ytjbN/Ze/ro7QHne+LZWgn/s0dmE8nnNUm5eqJJzu6KfKzDBu5q+1NDmX4nBH
         Qk1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jEPOKtyFXOdZd7LfyAwq9MFYCjYUhsKW5k+2BFYj+vg=;
        b=v+H0GQN/iCge4DHq3FPY/zZNGiYfSXfVw+rHL5KDL5G13Opt+5FJc9gkkoxZ7b2QsM
         /RAWFeH/xDAUU2MOW3SNcydKDvt4oN9JP2dEUy2JV6vYPMyvQfxhdi9dvl7AvvC2M8po
         H8e5JMhhQ7hx33QJU0/Nwi7AnvyxseX1z8f7yzCLqKUExrdflchR3aRGnQDIxWpcp+9o
         lXv0A9utmd3VW3OeFTT5M7UhGNM20jiO3uYJPXOnZ+wciAZ2XMDUFYPP4poCL33W3yAC
         28f0JXesX+gBDegoakC4z81sy/gtSxaFjN3OvAxQoPABRYmf+rcSIPvOvbpSiauX8Wnu
         RBMw==
X-Gm-Message-State: AOAM531fyXHY1XAgABUUpjBr/Grugq3PHrRi85dC1JVinNl2CaR5z2MZ
        luX6wyRVQXgHXI9yy7lvWDUSADvkGGstuaJthgk=
X-Google-Smtp-Source: ABdhPJy5RluhR62B0Nu7+en4qPrX2R54WZqLDdVBaOV+bWtviCsxipmwbQ3gmSqu8ifTp4r+gpjIWDbzb5Ai+Ex5qxY=
X-Received: by 2002:a2e:b712:0:b0:24f:150e:1a71 with SMTP id
 j18-20020a2eb712000000b0024f150e1a71mr6216248ljo.240.1651016739040; Tue, 26
 Apr 2022 16:45:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220416063429.3314021-1-joannelkoong@gmail.com>
 <20220416063429.3314021-4-joannelkoong@gmail.com> <20220422025212.n4c25z23rj2pp3yu@MBP-98dd607d3435.dhcp.thefacebook.com>
In-Reply-To: <20220422025212.n4c25z23rj2pp3yu@MBP-98dd607d3435.dhcp.thefacebook.com>
From:   Joanne Koong <joannelkoong@gmail.com>
Date:   Tue, 26 Apr 2022 16:45:28 -0700
Message-ID: <CAJnrk1ZczWZi4SAGTqoY1764oei8gCzcEA9a7608R4H2XkisrA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 3/7] bpf: Add bpf_dynptr_from_mem,
 bpf_dynptr_alloc, bpf_dynptr_put
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
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

On Thu, Apr 21, 2022 at 7:52 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Apr 15, 2022 at 11:34:25PM -0700, Joanne Koong wrote:
> > This patch adds 3 new APIs and the bulk of the verifier work for
> > supporting dynamic pointers in bpf.
> >
> > There are different types of dynptrs. This patch starts with the most
> > basic ones, ones that reference a program's local memory
> > (eg a stack variable) and ones that reference memory that is dynamically
> > allocated on behalf of the program. If the memory is dynamically
> > allocated by the program, the program *must* free it before the program
> > exits. This is enforced by the verifier.
> >
> > The added APIs are:
> >
> > long bpf_dynptr_from_mem(void *data, u32 size, u64 flags, struct bpf_dynptr *ptr);
> > long bpf_dynptr_alloc(u32 size, u64 flags, struct bpf_dynptr *ptr);
> > void bpf_dynptr_put(struct bpf_dynptr *ptr);
> >
> > This patch sets up the verifier to support dynptrs. Dynptrs will always
> > reside on the program's stack frame. As such, their state is tracked
> > in their corresponding stack slot, which includes the type of dynptr
> > (DYNPTR_LOCAL vs. DYNPTR_MALLOC).
> >
> > When the program passes in an uninitialized dynptr (ARG_PTR_TO_DYNPTR |
> > MEM_UNINIT), the stack slots corresponding to the frame pointer
> > where the dynptr resides at are marked as STACK_DYNPTR. For helper functions
> > that take in initialized dynptrs (such as the next patch in this series
> > which supports dynptr reads/writes), the verifier enforces that the
> > dynptr has been initialized by checking that their corresponding stack
> > slots have been marked as STACK_DYNPTR. Dynptr release functions
> > (eg bpf_dynptr_put) will clear the stack slots. The verifier enforces at
> > program exit that there are no acquired dynptr stack slots that need
> > to be released.
> >
> > There are other constraints that are enforced by the verifier as
> > well, such as that the dynptr cannot be written to directly by the bpf
> > program or by non-dynptr helper functions. The last patch in this series
> > contains tests that trigger different cases that the verifier needs to
> > successfully reject.
> >
> > For now, local dynptrs cannot point to referenced memory since the
> > memory can be freed anytime. Support for this will be added as part
> > of a separate patchset.
> >
> > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > ---
> >  include/linux/bpf.h            |  68 +++++-
> >  include/linux/bpf_verifier.h   |  28 +++
> >  include/uapi/linux/bpf.h       |  44 ++++
> >  kernel/bpf/helpers.c           | 110 ++++++++++
> >  kernel/bpf/verifier.c          | 372 +++++++++++++++++++++++++++++++--
> >  scripts/bpf_doc.py             |   2 +
> >  tools/include/uapi/linux/bpf.h |  44 ++++
> >  7 files changed, 654 insertions(+), 14 deletions(-)
> >
[...]
> > +     for (i = 0; i < BPF_REG_SIZE; i++) {
> > +             state->stack[spi].slot_type[i] = STACK_INVALID;
> > +             state->stack[spi - 1].slot_type[i] = STACK_INVALID;
> > +     }
> > +
> > +     state->stack[spi].spilled_ptr.dynptr.type = 0;
> > +     state->stack[spi - 1].spilled_ptr.dynptr.type = 0;
> > +
> > +     state->stack[spi].spilled_ptr.dynptr.first_slot = 0;
> > +
> > +     return 0;
> > +}
> > +
> > +static int mark_as_dynptr_data(struct bpf_verifier_env *env, const struct bpf_func_proto *fn,
> > +                            struct bpf_reg_state *regs)
> > +{
> > +     struct bpf_func_state *state = cur_func(env);
> > +     struct bpf_reg_state *reg, *mem_reg = NULL;
> > +     enum bpf_arg_type arg_type;
> > +     u64 mem_size;
> > +     u32 nr_slots;
> > +     int i, spi;
> > +
> > +     /* We must protect against the case where a program tries to do something
> > +      * like this:
> > +      *
> > +      * bpf_dynptr_from_mem(&ptr, sizeof(ptr), 0, &local);
> > +      * bpf_dynptr_alloc(16, 0, &ptr);
> > +      * bpf_dynptr_write(&local, 0, corrupt_data, sizeof(ptr));
> > +      *
> > +      * If ptr is a variable on the stack, we must mark the stack slot as
> > +      * dynptr data when a local dynptr to it is created.
> > +      */
> > +     for (i = 0; i < MAX_BPF_FUNC_REG_ARGS; i++) {
> > +             arg_type = fn->arg_type[i];
> > +             reg = &regs[BPF_REG_1 + i];
> > +
> > +             if (base_type(arg_type) == ARG_PTR_TO_MEM) {
> > +                     if (base_type(reg->type) == PTR_TO_STACK) {
> > +                             mem_reg = reg;
> > +                             continue;
> > +                     }
> > +                     /* if it's not a PTR_TO_STACK, then we don't need to
> > +                      * mark anything since it can never be used as a dynptr.
> > +                      * We can just return here since there will always be
> > +                      * only one ARG_PTR_TO_MEM in fn.
> > +                      */
> > +                     return 0;
>
> I think the assumption here that NO_OBJ_REF flag reduces ARG_PTR_TO_MEM
> to be stack, a pointer to packet or map value, right?
> Since dynptr can only be on stack, map value and packet memory
> cannot be used to store dynptr.
> So bpf_dynptr_alloc(16, 0, &ptr); is not possible where &ptr
> points to packet or map value?
> So that's what 'return 0' above doing?
> That's probably ok.
>
> Just thinking out loud:
> bpf_dynptr_from_mem(&ptr, sizeof(ptr), 0, &local);
> where &local is a dynptr on stack, but &ptr is a map value?
> The lifetime of the memory tracked by dynptr is not going
> to outlive program execution.
> Probably ok too.
>
After our conversation, I will remove local dynptrs for now.
> > +             } else if (arg_type_is_mem_size(arg_type)) {
> > +                     mem_size = roundup(reg->var_off.value, BPF_REG_SIZE);
> > +             }
> > +     }
> > +
> > +     if (!mem_reg || !mem_size) {
> > +             verbose(env, "verifier internal error: invalid ARG_PTR_TO_MEM args for %s\n", __func__);
> > +             return -EFAULT;
> > +     }
> > +
> > +     spi = get_spi(mem_reg->off);
> > +     if (!is_spi_bounds_valid(state, spi, mem_size)) {
> > +             verbose(env, "verifier internal error: variable not initialized on stack in %s\n", __func__);
> > +             return -EFAULT;
> > +     }
> > +
> > +     nr_slots = mem_size / BPF_REG_SIZE;
> > +     for (i = 0; i < nr_slots; i++)
> > +             state->stack[spi - i].spilled_ptr.is_dynptr_data = true;
>
> So the stack is still STACK_INVALID potentially,
> but we mark it as is_dynptr_data...
> but the data doesn't need to be 8-byte (spill_ptr) aligned.
> So the above loop will mark more stack slots as busy then
> the actual stack memory the dynptr points to.
> Probably ok.
> The stack size is just 512. I wonder whether all this complexity
> with tracking special stack memory is worth it.
> May be restrict dynptr_from_mem to point to non-stack PTR_TO_MEM only?
>
> > +
> > +     return 0;
> > +}
> > +
> > +static bool is_dynptr_reg_valid_uninit(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
> > +                                    bool *is_dynptr_data)
> > +{
> > +     struct bpf_func_state *state = func(env, reg);
> > +     int spi;
> > +
> > +     spi = get_spi(reg->off);
> > +
> > +     if (!is_spi_bounds_valid(state, spi, BPF_DYNPTR_NR_SLOTS))
> > +             return true;
> > +
> > +     if (state->stack[spi].slot_type[0] == STACK_DYNPTR ||
> > +         state->stack[spi - 1].slot_type[0] == STACK_DYNPTR)
> > +             return false;
> > +
> > +     if (state->stack[spi].spilled_ptr.is_dynptr_data ||
> > +         state->stack[spi - 1].spilled_ptr.is_dynptr_data) {
> > +             *is_dynptr_data = true;
> > +             return false;
> > +     }
> > +
> > +     return true;
> > +}
> > +
> > +static bool is_dynptr_reg_valid_init(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
> > +                                  enum bpf_arg_type arg_type)
> > +{
> > +     struct bpf_func_state *state = func(env, reg);
> > +     int spi = get_spi(reg->off);
> > +
> > +     if (!is_spi_bounds_valid(state, spi, BPF_DYNPTR_NR_SLOTS) ||
> > +         state->stack[spi].slot_type[0] != STACK_DYNPTR ||
> > +         state->stack[spi - 1].slot_type[0] != STACK_DYNPTR ||
> > +         !state->stack[spi].spilled_ptr.dynptr.first_slot)
> > +             return false;
> > +
> > +     /* ARG_PTR_TO_DYNPTR takes any type of dynptr */
> > +     if (arg_type == ARG_PTR_TO_DYNPTR)
> > +             return true;
> > +
> > +     return state->stack[spi].spilled_ptr.dynptr.type == arg_to_dynptr_type(arg_type);
> > +}
> > +
> > +static bool stack_access_into_dynptr(struct bpf_func_state *state, int spi, int size)
> > +{
> > +     int nr_slots = roundup(size, BPF_REG_SIZE) / BPF_REG_SIZE;
> > +     int i;
> > +
> > +     for (i = 0; i < nr_slots; i++) {
> > +             if (state->stack[spi - i].slot_type[0] == STACK_DYNPTR)
> > +                     return true;
> > +     }
> > +
> > +     return false;
> > +}
> > +
> >  /* The reg state of a pointer or a bounded scalar was saved when
> >   * it was spilled to the stack.
> >   */
> > @@ -2878,6 +3088,12 @@ static int check_stack_write_fixed_off(struct bpf_verifier_env *env,
> >       }
> >
> >       mark_stack_slot_scratched(env, spi);
> > +
> > +     if (stack_access_into_dynptr(state, spi, size)) {
> > +             verbose(env, "direct write into dynptr is not permitted\n");
> > +             return -EINVAL;
> > +     }
> > +
> >       if (reg && !(off % BPF_REG_SIZE) && register_is_bounded(reg) &&
> >           !register_is_null(reg) && env->bpf_capable) {
> >               if (dst_reg != BPF_REG_FP) {
> > @@ -2999,6 +3215,12 @@ static int check_stack_write_var_off(struct bpf_verifier_env *env,
> >               slot = -i - 1;
> >               spi = slot / BPF_REG_SIZE;
> >               stype = &state->stack[spi].slot_type[slot % BPF_REG_SIZE];
> > +
> > +             if (*stype == STACK_DYNPTR) {
> > +                     verbose(env, "direct write into dynptr is not permitted\n");
> > +                     return -EINVAL;
> > +             }
> > +
> >               mark_stack_slot_scratched(env, spi);
> >
> >               if (!env->allow_ptr_leaks
> > @@ -5141,6 +5363,16 @@ static bool arg_type_is_int_ptr(enum bpf_arg_type type)
> >              type == ARG_PTR_TO_LONG;
> >  }
> >
> > +static inline bool arg_type_is_dynptr(enum bpf_arg_type type)
> > +{
> > +     return base_type(type) == ARG_PTR_TO_DYNPTR;
> > +}
> > +
> > +static inline bool arg_type_is_dynptr_uninit(enum bpf_arg_type type)
> > +{
> > +     return arg_type_is_dynptr(type) && (type & MEM_UNINIT);
> > +}
> > +
> >  static int int_ptr_type_to_size(enum bpf_arg_type type)
> >  {
> >       if (type == ARG_PTR_TO_INT)
> > @@ -5278,6 +5510,7 @@ static const struct bpf_reg_types *compatible_reg_types[__BPF_ARG_TYPE_MAX] = {
> >       [ARG_PTR_TO_STACK]              = &stack_ptr_types,
> >       [ARG_PTR_TO_CONST_STR]          = &const_str_ptr_types,
> >       [ARG_PTR_TO_TIMER]              = &timer_types,
> > +     [ARG_PTR_TO_DYNPTR]             = &stack_ptr_types,
> >  };
> >
> >  static int check_reg_type(struct bpf_verifier_env *env, u32 regno,
> > @@ -5450,10 +5683,16 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
> >               return err;
> >
> >  skip_type_check:
> > -     /* check_func_arg_reg_off relies on only one referenced register being
> > -      * allowed for BPF helpers.
> > -      */
> >       if (reg->ref_obj_id) {
> > +             if (arg_type & NO_OBJ_REF) {
> > +                     verbose(env, "Arg #%d cannot be a referenced object\n",
> > +                             arg + 1);
> > +                     return -EINVAL;
> > +             }
> > +
> > +             /* check_func_arg_reg_off relies on only one referenced register being
> > +              * allowed for BPF helpers.
> > +              */
> >               if (meta->ref_obj_id) {
> >                       verbose(env, "verifier internal error: more than one arg with ref_obj_id R%d %u %u\n",
> >                               regno, reg->ref_obj_id,
> > @@ -5463,16 +5702,26 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
> >               meta->ref_obj_id = reg->ref_obj_id;
> >       }
> >       if (arg_type & OBJ_RELEASE) {
> > -             if (!reg->ref_obj_id) {
> > +             if (arg_type_is_dynptr(arg_type)) {
> > +                     struct bpf_func_state *state = func(env, reg);
> > +                     int spi = get_spi(reg->off);
> > +
> > +                     if (!is_spi_bounds_valid(state, spi, BPF_DYNPTR_NR_SLOTS) ||
> > +                         !state->stack[spi].spilled_ptr.id) {
> > +                             verbose(env, "arg %d is an unacquired reference\n", regno);
> > +                             return -EINVAL;
> > +                     }
> > +                     meta->release_dynptr = true;
> > +             } else if (!reg->ref_obj_id) {
> >                       verbose(env, "arg %d is an unacquired reference\n", regno);
> >                       return -EINVAL;
> >               }
> > -             if (meta->release_ref) {
> > -                     verbose(env, "verifier internal error: more than one release_ref arg R%d\n",
> > -                             regno);
> > +             if (meta->release_regno) {
> > +                     verbose(env, "verifier internal error: more than one release_regno %u %u\n",
> > +                             meta->release_regno, regno);
> >                       return -EFAULT;
> >               }
> > -             meta->release_ref = true;
> > +             meta->release_regno = regno;
> >       }
> >
> >       if (arg_type == ARG_CONST_MAP_PTR) {
> > @@ -5565,6 +5814,44 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
> >               bool zero_size_allowed = (arg_type == ARG_CONST_SIZE_OR_ZERO);
> >
> >               err = check_mem_size_reg(env, reg, regno, zero_size_allowed, meta);
> > +     } else if (arg_type_is_dynptr(arg_type)) {
> > +             /* Can't pass in a dynptr at a weird offset */
> > +             if (reg->off % BPF_REG_SIZE) {
> > +                     verbose(env, "cannot pass in non-zero dynptr offset\n");
> > +                     return -EINVAL;
> > +             }
> > +
> > +             if (arg_type & MEM_UNINIT)  {
> > +                     bool is_dynptr_data = false;
> > +
> > +                     if (!is_dynptr_reg_valid_uninit(env, reg, &is_dynptr_data)) {
> > +                             if (is_dynptr_data)
> > +                                     verbose(env, "Arg #%d cannot be a memory reference for another dynptr\n",
> > +                                             arg + 1);
> > +                             else
> > +                                     verbose(env, "Arg #%d dynptr has to be an uninitialized dynptr\n",
> > +                                             arg + 1);
> > +                             return -EINVAL;
> > +                     }
> > +
> > +                     meta->uninit_dynptr_regno = arg + BPF_REG_1;
> > +             } else if (!is_dynptr_reg_valid_init(env, reg, arg_type)) {
> > +                     const char *err_extra = "";
> > +
> > +                     switch (arg_type & DYNPTR_TYPE_FLAG_MASK) {
> > +                     case DYNPTR_TYPE_LOCAL:
> > +                             err_extra = "local ";
> > +                             break;
> > +                     case DYNPTR_TYPE_MALLOC:
> > +                             err_extra = "malloc ";
> > +                             break;
> > +                     default:
> > +                             break;
> > +                     }
> > +                     verbose(env, "Expected an initialized %sdynptr as arg #%d\n",
> > +                             err_extra, arg + 1);
> > +                     return -EINVAL;
> > +             }
> >       } else if (arg_type_is_alloc_size(arg_type)) {
> >               if (!tnum_is_const(reg->var_off)) {
> >                       verbose(env, "R%d is not a known constant'\n",
> > @@ -6545,6 +6832,28 @@ static int check_reference_leak(struct bpf_verifier_env *env)
> >       return state->acquired_refs ? -EINVAL : 0;
> >  }
> >
> > +/* Called at BPF_EXIT to detect if there are any reference-tracked dynptrs that have
> > + * not been released. Dynptrs to local memory do not need to be released.
> > + */
> > +static int check_dynptr_unreleased(struct bpf_verifier_env *env)
> > +{
> > +     struct bpf_func_state *state = cur_func(env);
> > +     int allocated_slots, i;
> > +
> > +     allocated_slots = state->allocated_stack / BPF_REG_SIZE;
> > +
> > +     for (i = 0; i < allocated_slots; i++) {
> > +             if (state->stack[i].slot_type[0] == STACK_DYNPTR) {
> > +                     if (dynptr_type_refcounted(state->stack[i].spilled_ptr.dynptr.type)) {
> > +                             verbose(env, "spi=%d is an unreleased dynptr\n", i);
> > +                             return -EINVAL;
> > +                     }
> > +             }
> > +     }
>
> I guess it's ok to treat refcnted dynptr special like above.
> I wonder whether we can reuse check_reference_leak logic?
I like this idea! My reason for not storing dynptr reference ids in
state->refs was because it's costly (eg we realloc_array every time we
acquire a reference). But thinking about this some more, I like the
idea of keeping everything unified by having all reference ids reside
within state->refs and checking for leaks the same way. Perhaps we can
optimize acquire_reference_state() as well where we upfront allocate
more space for state->refs instead of having to do a realloc_array
every time.

>
> > +
> > +     return 0;
> > +}
> > +
> >  static int check_bpf_snprintf_call(struct bpf_verifier_env *env,
> >                                  struct bpf_reg_state *regs)
> >  {
> > @@ -6686,8 +6995,38 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
> >                       return err;
> >       }
> >
> > -     if (meta.release_ref) {
> > -             err = release_reference(env, meta.ref_obj_id);
> > +     regs = cur_regs(env);
> > +
> > +     if (meta.uninit_dynptr_regno) {
> > +             enum bpf_arg_type type;
> > +
> > +             /* we write BPF_W bits (4 bytes) at a time */
> > +             for (i = 0; i < BPF_DYNPTR_SIZE; i += 4) {
> > +                     err = check_mem_access(env, insn_idx, meta.uninit_dynptr_regno,
> > +                                            i, BPF_W, BPF_WRITE, -1, false);
>
> Why 4 byte at a time?
> dynptr has an 8 byte pointer in there.
Oh I see. I thought BPF_W was the largest BPF_SIZE but I see now there
is also BPF_DW which is 64-bit. I'll change this to BPF_DW.
>

[...]
> > 2.30.2
> >
