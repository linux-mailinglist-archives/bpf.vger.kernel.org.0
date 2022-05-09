Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C5EA52054C
	for <lists+bpf@lfdr.de>; Mon,  9 May 2022 21:26:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240572AbiEITaH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 9 May 2022 15:30:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240567AbiEITaG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 9 May 2022 15:30:06 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01D5B2A720
        for <bpf@vger.kernel.org>; Mon,  9 May 2022 12:26:12 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id e3so16409648ios.6
        for <bpf@vger.kernel.org>; Mon, 09 May 2022 12:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CQ30/sXmMPr8M08IwFWtHBBkQYxPsQiKbJtUuU+XWHo=;
        b=iEakTCnW/qPdzrQy+gjwJe6hmjqbUyhenVlVOqYhlMF10UBFcF1I4XWibXp5+UMZkN
         aDEoir7PgZZ2/Jsa7kguJdqv8BikWcuDelijAG6ZA9N5X665G5ZyH3IkOd/PEH0kXBNT
         zHYYNAy0V3fOpH//M8SNZFlX6jcXKUiFgsyXokyfvqHCOZCc+3NNSeKzNUHvoUX6xXWo
         0LutlP4srm7a80zmvdcZlHDDtYETdoR2f1U6L6AsUcctXYjNpdZzr8aTXzFMP6RL+qxZ
         JY2San7Yl/frPmy08NiaX0/9IQszpbG4gnir1bKn/sWt+C/dACz1t4A2DKKIYzCiSGH/
         X7Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CQ30/sXmMPr8M08IwFWtHBBkQYxPsQiKbJtUuU+XWHo=;
        b=KKyJrqRtJFMNwjy1r36kOMGXfH1Iq/slTXr1ebwJ9pBbVnLZRMrDQ3Fz6MyIAhstvZ
         r3acOsUcVcpA6/pL0S2ivuA4U71sCPUcPC/+GoEEDb3nTjTHZPW2KudiOTnIonXuJgrN
         5toI+NqkRR6vV/Y+rV5tCEEvmWstSCY2YigtN2Z9PjpV4ITENTzn5Ygv1xg7fjRmc/EK
         1iqLOUM5ZWNAwMeLHCXQjYU/UHXgGjOygADhJhYLVNU+fFVdmxPY1cZUvep4wm8z1OXZ
         07qij2HY8Cutuz6QI1xSdNmv3BKp8/n+Wm4eFCzLCA7nh4/KKSKujFANyD2IK8HuomLl
         /zZA==
X-Gm-Message-State: AOAM530vYBL9aghQI10KnoUfrtWg5+X6BnVRUVj+sr95CBJOtBJ8dN4R
        O0TGbvj2NhxTPnZPibtvcndcFLYSF/28viOnGgg=
X-Google-Smtp-Source: ABdhPJzzz6ium+B/BP3Yr60cgoXrt+PGduRxf7hpDmhNm+bEDGlk11F6ufFOYdewliVmbW2/UfFtSoMtnEWo9egNTGs=
X-Received: by 2002:a5e:8e42:0:b0:657:bc82:64e5 with SMTP id
 r2-20020a5e8e42000000b00657bc8264e5mr6881346ioo.112.1652124371333; Mon, 09
 May 2022 12:26:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220428211059.4065379-1-joannelkoong@gmail.com>
 <20220428211059.4065379-3-joannelkoong@gmail.com> <CAEf4BzaL=JEAqhE=zLG506-Z==TJBwK40A-bon5AzhwMzhhtTQ@mail.gmail.com>
 <CAJnrk1ZQq7=7xk3jH14OxSyH=qRDprw1vv4fep2UHQeAMJo5xQ@mail.gmail.com>
In-Reply-To: <CAJnrk1ZQq7=7xk3jH14OxSyH=qRDprw1vv4fep2UHQeAMJo5xQ@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 9 May 2022 12:26:00 -0700
Message-ID: <CAEf4BzZzLAOgWaa2u9WZumiczDjbj_MhkihB9sOyQ8R6gFCDvQ@mail.gmail.com>
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

On Mon, May 9, 2022 at 11:58 AM Joanne Koong <joannelkoong@gmail.com> wrote:
>
> On Fri, May 6, 2022 at 4:30 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Thu, Apr 28, 2022 at 2:12 PM Joanne Koong <joannelkoong@gmail.com> wrote:
> > >
> > > This patch adds the bulk of the verifier work for supporting dynamic
> > > pointers (dynptrs) in bpf. This patch implements malloc-type dynptrs
> > > through 2 new APIs (bpf_dynptr_alloc and bpf_dynptr_put) that can be
> > > called by a bpf program. Malloc-type dynptrs are dynptrs that dynamically
> > > allocate memory on behalf of the program.
> > >
> > > A bpf_dynptr is opaque to the bpf program. It is a 16-byte structure
> > > defined internally as:
> > >
> > > struct bpf_dynptr_kern {
> > >     void *data;
> > >     u32 size;
> > >     u32 offset;
> > > } __aligned(8);
> > >
> > > The upper 8 bits of *size* is reserved (it contains extra metadata about
> > > read-only status and dynptr type); consequently, a dynptr only supports
> > > memory less than 16 MB.
> > >
> > > The 2 new APIs for malloc-type dynptrs are:
> > >
> > > long bpf_dynptr_alloc(u32 size, u64 flags, struct bpf_dynptr *ptr);
> > > void bpf_dynptr_put(struct bpf_dynptr *ptr);
> > >
> > > Please note that there *must* be a corresponding bpf_dynptr_put for
> > > every bpf_dynptr_alloc (even if the alloc fails). This is enforced
> > > by the verifier.
> > >
> > > In the verifier, dynptr state information will be tracked in stack
> > > slots. When the program passes in an uninitialized dynptr
> > > (ARG_PTR_TO_DYNPTR | MEM_UNINIT), the stack slots corresponding
> > > to the frame pointer where the dynptr resides at are marked STACK_DYNPTR.
> > >
> > > For helper functions that take in initialized dynptrs (eg
> > > bpf_dynptr_read + bpf_dynptr_write which are added later in this
> > > patchset), the verifier enforces that the dynptr has been initialized
> > > properly by checking that their corresponding stack slots have been marked
> > > as STACK_DYNPTR. Dynptr release functions (eg bpf_dynptr_put) will clear the
> > > stack slots. The verifier enforces at program exit that there are no
> > > referenced dynptrs that haven't been released.
> > >
> > > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > > ---
> > >  include/linux/bpf.h            |  60 ++++++++-
> > >  include/linux/bpf_verifier.h   |  21 +++
> > >  include/uapi/linux/bpf.h       |  30 +++++
> > >  kernel/bpf/helpers.c           |  75 +++++++++++
> > >  kernel/bpf/verifier.c          | 225 ++++++++++++++++++++++++++++++++-
> > >  scripts/bpf_doc.py             |   2 +
> > >  tools/include/uapi/linux/bpf.h |  30 +++++
> > >  7 files changed, 440 insertions(+), 3 deletions(-)
> > >
> >
> > [...]
> >
> > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > index 4565684839f1..16b7ea54a7e0 100644
> > > --- a/kernel/bpf/verifier.c
> > > +++ b/kernel/bpf/verifier.c
> > > @@ -187,6 +187,11 @@ struct bpf_verifier_stack_elem {
> > >                                           POISON_POINTER_DELTA))
> > >  #define BPF_MAP_PTR(X)         ((struct bpf_map *)((X) & ~BPF_MAP_PTR_UNPRIV))
> > >
> > > +/* forward declarations */
> >
> > it's kind of obvious from C syntax, this comment doesn't really add value
> >
> > > +static bool arg_type_is_mem_size(enum bpf_arg_type type);
> > > +static int acquire_reference_state(struct bpf_verifier_env *env, int insn_idx);
> > > +static int release_reference(struct bpf_verifier_env *env, int ref_obj_id);
> > > +
> >
> > [...]
> >
> > >  static struct bpf_func_state *func(struct bpf_verifier_env *env,
> > >                                    const struct bpf_reg_state *reg)
> > >  {
> > > @@ -646,6 +672,134 @@ static void mark_verifier_state_scratched(struct bpf_verifier_env *env)
> > >         env->scratched_stack_slots = ~0ULL;
> > >  }
> > >
> > > +#define DYNPTR_TYPE_FLAG_MASK          DYNPTR_TYPE_MALLOC
> >
> > can this be put near where DYNPTR_TYPE_MALLOC is defined? It's quite
> > easy to forget to update this if it's somewhere far away
> Sounds great!
> >
> > > +
> > > +static int arg_to_dynptr_type(enum bpf_arg_type arg_type)
> > > +{
> > > +       switch (arg_type & DYNPTR_TYPE_FLAG_MASK) {
> > > +       case DYNPTR_TYPE_MALLOC:
> > > +               return BPF_DYNPTR_TYPE_MALLOC;
> > > +       default:
> > > +               return BPF_DYNPTR_TYPE_INVALID;
> > > +       }
> > > +}
> > > +
> >
> > [...]
> >
> > > +static int unmark_stack_slots_dynptr(struct bpf_verifier_env *env, struct bpf_reg_state *reg)
> > > +{
> > > +       struct bpf_func_state *state = func(env, reg);
> > > +       int spi, i;
> > > +
> > > +       spi = get_spi(reg->off);
> > > +
> > > +       if (!is_spi_bounds_valid(state, spi, BPF_DYNPTR_NR_SLOTS))
> > > +               return -EINVAL;
> > > +
> > > +       for (i = 0; i < BPF_REG_SIZE; i++) {
> > > +               state->stack[spi].slot_type[i] = STACK_INVALID;
> > > +               state->stack[spi - 1].slot_type[i] = STACK_INVALID;
> > > +       }
> > > +
> > > +       /* Invalidate any slices associated with this dynptr */
> > > +       if (dynptr_type_refcounted(state->stack[spi].spilled_ptr.dynptr.type)) {
> > > +               release_reference(env, state->stack[spi].spilled_ptr.id);
> > > +               state->stack[spi].spilled_ptr.id = 0;
> > > +               state->stack[spi - 1].spilled_ptr.id = 0;
> > > +       }
> > > +
> > > +       state->stack[spi].spilled_ptr.dynptr.type = 0;
> > > +       state->stack[spi - 1].spilled_ptr.dynptr.type = 0;
> > > +
> > > +       state->stack[spi].spilled_ptr.dynptr.first_slot = false;
> >
> > nit: given you marked slots as STACK_INVALID, we shouldn't even look
> > into spilled_ptr.dynptr, so this zeroing out isn't necessary, right?
> My concern was that if the stack slot gets reused and we don't zero
> this out, then this would lead to some erroneous state. Do you think
> this is a valid concern or an unnecessary concern?

It depends whether we have such assumptions elsewhere right now. I
hope not, but if we do, then we might better zero-out when we
initialize the slot. In any case, memset() sounds like a more robust
solution here.

> >
> > > +
> > > +       return 0;
> > > +}
> > > +
> > > +static bool is_dynptr_reg_valid_uninit(struct bpf_verifier_env *env, struct bpf_reg_state *reg)
> > > +{
> > > +       struct bpf_func_state *state = func(env, reg);
> > > +       int spi = get_spi(reg->off);
> > > +       int i;
> > > +
> > > +       if (!is_spi_bounds_valid(state, spi, BPF_DYNPTR_NR_SLOTS))
> > > +               return true;
> >
> > hm... if spi bounds are invalid, shouldn't that be an error?...
> The spi bounds can be invalid if the uninitialized dynptr variable
> hasn't yet been allocated on the stack. We do the stack allocation for
> it in check_helper_call() after we check all the args (we call this
> is_dynptr_reg_valid_uninit function when we check the args).
> >
> > > +
> > > +       for (i = 0; i < BPF_REG_SIZE; i++) {
> > > +               if (state->stack[spi].slot_type[i] == STACK_DYNPTR ||
> > > +                   state->stack[spi - 1].slot_type[i] == STACK_DYNPTR)
> > > +                       return false;
> > > +       }
> > > +
> > > +       return true;
> > > +}
> > > +
> > > +static bool is_dynptr_reg_valid_init(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
> > > +                                    enum bpf_arg_type arg_type)
> > > +{
> > > +       struct bpf_func_state *state = func(env, reg);
> > > +       int spi = get_spi(reg->off);
> > > +       int i;
> > > +
> > > +       if (!is_spi_bounds_valid(state, spi, BPF_DYNPTR_NR_SLOTS) ||
> > > +           !state->stack[spi].spilled_ptr.dynptr.first_slot)
> > > +               return false;
> > > +
> > > +       for (i = 0; i < BPF_REG_SIZE; i++) {
> > > +           if (state->stack[spi].slot_type[i] != STACK_DYNPTR ||
> > > +               state->stack[spi - 1].slot_type[i] != STACK_DYNPTR)
> > > +                   return false;
> > > +       }
> >
> > minor, but seems like it's pretty common operation to set or check all
> > those "microslots" to STACK_DYNPTR, would two small helpers be useful
> > for this (e.g., is_stack_dynptr() and set_stack_dynptr() or something
> > along those lines)?
> I think having is_stack_dynptr() might be misleading because
> !is_stack_dynptr() does not mean the stack slots are not dynptr.
> is_stack_dynptr() is true only if both stack slots are marked as
> dynptr, !is_stack_dynptr() is therefore true if one or both slots are
> not marked as dynptr, but really the stack slots are truly not dynptr
> only if both slots are not marked as dynptr. (for example, if spi is
> STACK_DYNPTR and spi - 1 is not, !is_stack_dynptr is true, but really
> it is not a stack dynptr only if both slots are not marked as dynptr).
>
> looking through the file, I think there is currently only one place
> where we set the stack dynptr (in mark_stack_slots_dynptr) and test if
> it is a stack dynptr (in is_dynptr_reg_valid_init), so maybe just
> leaving this as is is okay? But I'm also happy to move these to
> smaller helpers if you don't think the !is_stack_dynptr() is too
> misleading/confusing.

it's fine as is, this was minor thing

> >
> > > +
> > > +       /* ARG_PTR_TO_DYNPTR takes any type of dynptr */
> > > +       if (arg_type == ARG_PTR_TO_DYNPTR)
> > > +               return true;
> > > +
> > > +       return state->stack[spi].spilled_ptr.dynptr.type == arg_to_dynptr_type(arg_type);
> > > +}
> > > +
> >
> > [...]
> >
> > > @@ -5837,6 +6011,35 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
> > >                 bool zero_size_allowed = (arg_type == ARG_CONST_SIZE_OR_ZERO);
> > >
> > >                 err = check_mem_size_reg(env, reg, regno, zero_size_allowed, meta);
> > > +       } else if (arg_type_is_dynptr(arg_type)) {
> > > +               /* Can't pass in a dynptr at a weird offset */
> > > +               if (reg->off % BPF_REG_SIZE) {
> > > +                       verbose(env, "cannot pass in non-zero dynptr offset\n");
> > > +                       return -EINVAL;
> > > +               }
> > > +
> > > +               if (arg_type & MEM_UNINIT)  {
> > > +                       if (!is_dynptr_reg_valid_uninit(env, reg)) {
> > > +                               verbose(env, "Arg #%d dynptr has to be an uninitialized dynptr\n",
> > > +                                       arg + BPF_REG_1);
> > > +                               return -EINVAL;
> > > +                       }
> > > +
> > > +                       meta->uninit_dynptr_regno = arg + BPF_REG_1;
> >
> > do we need a check that meta->uninit_dynptr_regno isn't already set?
> > I.e., prevent two uninit dynptr in a helper?
> I don't think we do because the helper functions only take in one
> uninitialized dynptr at the moment, but adding this check would
> prevent the case where in the future, there are more than 1
> uninitialized dynptr args and this verifier code didn't get modified
> to support that. I will add this in for v4.

That's the point of such checks: to guarantee that currently we don't
have helper definition that would break verifier with unexpected
argument combinations. If or when we extend this "only one out dynptr"
rule, we'll need to update various places in verifier to support that,
including this one. That's expected and good.

> >
> > > +               } else if (!is_dynptr_reg_valid_init(env, reg, arg_type)) {
> > > +                       const char *err_extra = "";
> > > +
> > > +                       switch (arg_type & DYNPTR_TYPE_FLAG_MASK) {
> > > +                       case DYNPTR_TYPE_MALLOC:
> > > +                               err_extra = "malloc ";
> > > +                               break;
> > > +                       default:
> > > +                               break;
> > > +                       }
> > > +                       verbose(env, "Expected an initialized %sdynptr as arg #%d\n",
> > > +                               err_extra, arg + BPF_REG_1);
> > > +                       return -EINVAL;
> > > +               }
> > >         } else if (arg_type_is_alloc_size(arg_type)) {
> > >                 if (!tnum_is_const(reg->var_off)) {
> > >                         verbose(env, "R%d is not a known constant'\n",
> >
> > [...]
