Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34C1266680E
	for <lists+bpf@lfdr.de>; Thu, 12 Jan 2023 01:47:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231650AbjALArT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 11 Jan 2023 19:47:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230308AbjALArR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 11 Jan 2023 19:47:17 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69AD240864
        for <bpf@vger.kernel.org>; Wed, 11 Jan 2023 16:47:15 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id v10so23567806edi.8
        for <bpf@vger.kernel.org>; Wed, 11 Jan 2023 16:47:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VdeQ53Hvxu2KsPViuL0s0VZy0Zb+0keA6f0OQnOALdU=;
        b=jl/8J7APTW1U9s0A6zFPQGXaeLHHtaZ/XdmxtGAqf9swmJAEclO4RFh6HkayBs7iTB
         ywfQXE7TGye0iOQ7BHmlnkgvBp8URkqepkb41k5kyTXJja4Bd/UCquitl0gu0tYb3ZXk
         58bn6irp9aZ/Zo1NweaPg6v6FWe8GgtE1kaSKQKu7j6fuY17sBlF+aMj9XXjN9GGp8jG
         gdrSWlA590f1fTvxJiAgbbqKx/mOwWTbhcACTjRtFAlwHADCZjCItzBA01HF5Dr6o/yK
         MtYGA0Wy9HUXFT9QBY96ty6dolHhQQfjo/neKpIiuIY2R27ZjqoGbk6KLhqhOb4nRo8c
         2pmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VdeQ53Hvxu2KsPViuL0s0VZy0Zb+0keA6f0OQnOALdU=;
        b=zVIsVmPdEzNdIabRGXQCESIYhp7o7qW6jQsh3x+mVhypYSXW32dCK8QdYlMGtPuVUS
         QBVSaRyRfIn5nJeiY3xfHlKU/O2tlU5R6Od4M0fpvukfDFQcsqZ3d7Z6oJoiF3S1HUCj
         6+9URY+bLHeWsvmnyq07xdSDexVVTa7W2O6gby6NB8k9/7X/tcSmvzOCRisrp/3htT/q
         EDpV023jWj0sq8mDj16FUevlB0Qwn850Bf8lqZwiIZxZxioGe0FcgLkND1JBz8DV6BH0
         TcfI0SN9Z9Q8ge92f64QGbNHmEajnf7ASJoJAiLDwhQqbWTzKKCquW9CfPeayRwHCV5C
         7YYw==
X-Gm-Message-State: AFqh2krXX7/u9uyvzywFfYy8+HtXsAnZXwGH2RM1nOn7AEt6ACj2NdaJ
        OdnF8p8QvGx6JQvTaRPKwjVzCIuAg7y+HYxj2Vg=
X-Google-Smtp-Source: AMrXdXs8zFa97X4niXuU6Mk5z752hkOi2vOkG7JfjQ4a95DGgO2k2sK1KgIkRCOUvdAtu/xbYwrHuWEteuNkhQjVOCw=
X-Received: by 2002:aa7:d386:0:b0:495:1602:fe69 with SMTP id
 x6-20020aa7d386000000b004951602fe69mr2460181edq.224.1673484433828; Wed, 11
 Jan 2023 16:47:13 -0800 (PST)
MIME-Version: 1.0
References: <20230101083403.332783-1-memxor@gmail.com> <20230101083403.332783-2-memxor@gmail.com>
 <CAEf4BzZsVQgCcFt-nZMp=YnikidBChyGn02bKp=-PsROGys0=w@mail.gmail.com> <20230109110522.nq34ozj4bo475a53@apollo>
In-Reply-To: <20230109110522.nq34ozj4bo475a53@apollo>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 11 Jan 2023 16:47:01 -0800
Message-ID: <CAEf4BzbyD3g_xHEgX2EiROoQ=+ZFZnM30g7sjA7YZtE0hq8pow@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 1/8] bpf: Fix state pruning for STACK_DYNPTR
 stack slots
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

On Mon, Jan 9, 2023 at 3:05 AM Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
>
> On Thu, Jan 05, 2023 at 03:54:03AM IST, Andrii Nakryiko wrote:
> > On Sun, Jan 1, 2023 at 12:34 AM Kumar Kartikeya Dwivedi
> > <memxor@gmail.com> wrote:
> > >
> > > The root of the problem is missing liveness marking for STACK_DYNPTR
> > > slots. This leads to all kinds of problems inside stacksafe.
> > >
> > > The verifier by default inside stacksafe ignores spilled_ptr in stack
> > > slots which do not have REG_LIVE_READ marks. Since this is being checked
> > > in the 'old' explored state, it must have already done clean_live_states
> > > for this old bpf_func_state. Hence, it won't be receiving any more
> > > liveness marks from to be explored insns (it has received REG_LIVE_DONE
> > > marking from liveness point of view).
> > >
> > > What this means is that verifier considers that it's safe to not compare
> > > the stack slot if was never read by children states. While liveness
> > > marks are usually propagated correctly following the parentage chain for
> > > spilled registers (SCALAR_VALUE and PTR_* types), the same is not the
> > > case for STACK_DYNPTR.
> > >
> > > clean_live_states hence simply rewrites these stack slots to the type
> > > STACK_INVALID since it sees no REG_LIVE_READ marks.
> > >
> > > The end result is that we will never see STACK_DYNPTR slots in explored
> > > state. Even if verifier was conservatively matching !REG_LIVE_READ
> > > slots, very next check continuing the stacksafe loop on seeing
> > > STACK_INVALID would again prevent further checks.
> > >
> > > Now as long as verifier stores an explored state which we can compare to
> > > when reaching a pruning point, we can abuse this bug to make verifier
> > > prune search for obviously unsafe paths using STACK_DYNPTR slots
> > > thinking they are never used hence safe.
> > >
> > > Doing this in unprivileged mode is a bit challenging. add_new_state is
> > > only set when seeing BPF_F_TEST_STATE_FREQ (which requires privileges)
> > > or when jmps_processed difference is >= 2 and insn_processed difference
> > > is >= 8. So coming up with the unprivileged case requires a little more
> > > work, but it is still totally possible. The test case being discussed
> > > below triggers the heuristic even in unprivileged mode.
> > >
> > > However, it no longer works since commit
> > > 8addbfc7b308 ("bpf: Gate dynptr API behind CAP_BPF").
> > >
> > > Let's try to study the test step by step.
> > >
> > > Consider the following program (C style BPF ASM):
> > >
> > > 0  r0 = 0;
> > > 1  r6 = &ringbuf_map;
> > > 3  r1 = r6;
> > > 4  r2 = 8;
> > > 5  r3 = 0;
> > > 6  r4 = r10;
> > > 7  r4 -= -16;
> > > 8  call bpf_ringbuf_reserve_dynptr;
> > > 9  if r0 == 0 goto pc+1;
> > > 10 goto pc+1;
> > > 11 *(r10 - 16) = 0xeB9F;
> > > 12 r1 = r10;
> > > 13 r1 -= -16;
> > > 14 r2 = 0;
> > > 15 call bpf_ringbuf_discard_dynptr;
> > > 16 r0 = 0;
> > > 17 exit;
> > >
> > > We know that insn 12 will be a pruning point, hence if we force
> > > add_new_state for it, it will first verify the following path as
> > > safe in straight line exploration:
> > > 0 1 3 4 5 6 7 8 9 -> 10 -> (12) 13 14 15 16 17
> > >
> > > Then, when we arrive at insn 12 from the following path:
> > > 0 1 3 4 5 6 7 8 9 -> 11 (12)
> > >
> > > We will find a state that has been verified as safe already at insn 12.
> > > Since register state is same at this point, regsafe will pass. Next, in
> > > stacksafe, for spi = 0 and spi = 1 (location of our dynptr) is skipped
> > > seeing !REG_LIVE_READ. The rest matches, so stacksafe returns true.
> > > Next, refsafe is also true as reference state is unchanged in both
> > > states.
> > >
> > > The states are considered equivalent and search is pruned.
> > >
> > > Hence, we are able to construct a dynptr with arbitrary contents and use
> > > the dynptr API to operate on this arbitrary pointer and arbitrary size +
> > > offset.
> > >
> > > To fix this, first define a mark_dynptr_read function that propagates
> > > liveness marks whenever a valid initialized dynptr is accessed by dynptr
> > > helpers. REG_LIVE_WRITTEN is marked whenever we initialize an
> > > uninitialized dynptr. This is done in mark_stack_slots_dynptr. It allows
> > > screening off mark_reg_read and not propagating marks upwards from that
> > > point.
> > >
> > > This ensures that we either set REG_LIVE_READ64 on both dynptr slots, or
> > > none, so clean_live_states either sets both slots to STACK_INVALID or
> > > none of them. This is the invariant the checks inside stacksafe rely on.
> > >
> > > Next, do a complete comparison of both stack slots whenever they have
> > > STACK_DYNPTR. Compare the dynptr type stored in the spilled_ptr, and
> > > also whether both form the same first_slot. Only then is the later path
> > > safe.
> > >
> > > Fixes: 97e03f521050 ("bpf: Add verifier support for dynptrs")
> > > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > > ---
> > >  kernel/bpf/verifier.c | 73 +++++++++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 73 insertions(+)
> > >
> > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > index 4a25375ebb0d..f7248235e119 100644
> > > --- a/kernel/bpf/verifier.c
> > > +++ b/kernel/bpf/verifier.c
> > > @@ -781,6 +781,9 @@ static int mark_stack_slots_dynptr(struct bpf_verifier_env *env, struct bpf_reg_
> > >                 state->stack[spi - 1].spilled_ptr.ref_obj_id = id;
> > >         }
> > >
> > > +       state->stack[spi].spilled_ptr.live |= REG_LIVE_WRITTEN;
> > > +       state->stack[spi - 1].spilled_ptr.live |= REG_LIVE_WRITTEN;
> > > +
> > >         return 0;
> > >  }
> > >
> > > @@ -805,6 +808,26 @@ static int unmark_stack_slots_dynptr(struct bpf_verifier_env *env, struct bpf_re
> > >
> > >         __mark_reg_not_init(env, &state->stack[spi].spilled_ptr);
> > >         __mark_reg_not_init(env, &state->stack[spi - 1].spilled_ptr);
> > > +
> > > +       /* Why do we need to set REG_LIVE_WRITTEN for STACK_INVALID slot?
> > > +        *
> > > +        * While we don't allow reading STACK_INVALID, it is still possible to
> > > +        * do <8 byte writes marking some but not all slots as STACK_MISC. Then,
> > > +        * helpers or insns can do partial read of that part without failing,
> > > +        * but check_stack_range_initialized, check_stack_read_var_off, and
> > > +        * check_stack_read_fixed_off will do mark_reg_read for all 8-bytes of
> > > +        * the slot conservatively. Hence we need to screen off those liveness
> > > +        * marking walks.
> > > +        *
> > > +        * This was not a problem before because STACK_INVALID is only set by
> > > +        * default, or in clean_live_states after REG_LIVE_DONE, not randomly
> > > +        * during verifier state exploration. Hence, for this case parentage
> > > +        * chain will still be live, while earlier reg->parent was NULL, so we
> > > +        * need REG_LIVE_WRITTEN to screen off read marker propagation.
> > > +        */
> > > +       state->stack[spi].spilled_ptr.live |= REG_LIVE_WRITTEN;
> > > +       state->stack[spi - 1].spilled_ptr.live |= REG_LIVE_WRITTEN;
> > > +
> > >         return 0;
> > >  }
> > >
> > > @@ -2388,6 +2411,30 @@ static int mark_reg_read(struct bpf_verifier_env *env,
> > >         return 0;
> > >  }
> > >
> > > +static int mark_dynptr_read(struct bpf_verifier_env *env, struct bpf_reg_state *reg)
> > > +{
> > > +       struct bpf_func_state *state = func(env, reg);
> > > +       int spi, ret;
> > > +
> > > +       /* For CONST_PTR_TO_DYNPTR, it must have already been done by
> > > +        * check_reg_arg in check_helper_call and mark_btf_func_reg_size in
> > > +        * check_kfunc_call.
> > > +        */
> > > +       if (reg->type == CONST_PTR_TO_DYNPTR)
> > > +               return 0;
> > > +       spi = get_spi(reg->off);
> > > +       /* Caller ensures dynptr is valid and initialized, which means spi is in
> > > +        * bounds and spi is the first dynptr slot. Simply mark stack slot as
> > > +        * read.
> > > +        */
> > > +       ret = mark_reg_read(env, &state->stack[spi].spilled_ptr,
> > > +                           state->stack[spi].spilled_ptr.parent, REG_LIVE_READ64);
> > > +       if (ret)
> > > +               return ret;
> > > +       return mark_reg_read(env, &state->stack[spi - 1].spilled_ptr,
> > > +                            state->stack[spi - 1].spilled_ptr.parent, REG_LIVE_READ64);
> > > +}
> > > +
> > >  /* This function is supposed to be used by the following 32-bit optimization
> > >   * code only. It returns TRUE if the source or destination register operates
> > >   * on 64-bit, otherwise return FALSE.
> > > @@ -5928,6 +5975,7 @@ int process_dynptr_func(struct bpf_verifier_env *env, int regno,
> > >                         enum bpf_arg_type arg_type, struct bpf_call_arg_meta *meta)
> > >  {
> > >         struct bpf_reg_state *regs = cur_regs(env), *reg = &regs[regno];
> > > +       int err;
> > >
> > >         /* MEM_UNINIT and MEM_RDONLY are exclusive, when applied to an
> > >          * ARG_PTR_TO_DYNPTR (or ARG_PTR_TO_DYNPTR | DYNPTR_TYPE_*):
> > > @@ -6008,6 +6056,10 @@ int process_dynptr_func(struct bpf_verifier_env *env, int regno,
> > >                                 err_extra, regno);
> > >                         return -EINVAL;
> > >                 }
> > > +
> > > +               err = mark_dynptr_read(env, reg);
> > > +               if (err)
> > > +                       return err;
> > >         }
> > >         return 0;
> > >  }
> > > @@ -13204,6 +13256,27 @@ static bool stacksafe(struct bpf_verifier_env *env, struct bpf_func_state *old,
> > >                          * return false to continue verification of this path
> > >                          */
> > >                         return false;
> > > +               /* Both are same slot_type, but STACK_DYNPTR requires more
> > > +                * checks before it can considered safe.
> > > +                */
> > > +               if (old->stack[spi].slot_type[i % BPF_REG_SIZE] == STACK_DYNPTR) {
> >
> > how about moving this check right after `if (i % BPF_REG_SIZE !=
> > BPF_REG_SIZE - 1)` ? Then we can actually generalize this to a switch
> > to handle STACK_SPILL and STACK_DYNPTR separately. I'm adding
> > STACK_ITER in my upcoming patch set, so this will have all the things
> > ready for that?
> >
> > switch (old->stack[spi].slot_type[BPF_REG_SIZE - 1]) {
> > case STACK_SPILL:
> >   if (!regsafe(...))
> >      return false;
> >   break;
> > case STACK_DYNPTR:
> >   ...
> >   break;
> > /* and then eventually */
> > case STACK_ITER:
> >   ...
> >
> > WDYT?
> >
>
> I can do this, it certainly makes sense with your upcoming changes, and it does
> look cleaner.
>
> > > +                       /* If both are STACK_DYNPTR, type must be same */
> > > +                       if (old->stack[spi].spilled_ptr.dynptr.type != cur->stack[spi].spilled_ptr.dynptr.type)
> >
> > struct bpf_reg_state *old_reg, *cur_reg;
> >
> > old_reg = &old->stack[spi].spilled_ptr;
> > cur_reg = &cur->stack[spi].spilled_ptr;
> >
> > and then use old_reg and cur_reg in one simple if
> >
> > here's how I have it locally:
> >
> >                 case STACK_DYNPTR:
> >                         old_reg = &old->stack[spi].spilled_ptr;
> >                         cur_reg = &cur->stack[spi].spilled_ptr;
> >                         if (old_reg->dynptr.type != cur_reg->dynptr.type ||
> >                             old_reg->dynptr.first_slot !=
> > cur_reg->dynptr.first_slot ||
> >                             !check_ids(old_reg->ref_obj_id,
> > cur_reg->ref_obj_id, idmap))
> >                                 return false;
> >                         break;
> >
> > seems a bit cleaner?
> >
>
> Yep.
>
> > I'm also thinking of getting rid of first_slot field and instead have
> > a rule that first slot has proper type set, but the next one has
> > BPF_DYNPTR_TYPE_INVALID as type. This should simplify things a bit, I
> > think. At least it seems that way for STACK_ITER state I'm adding. But
> > that's a separate refactoring, probably.
> >
>
> Yeah, I'd rather not mix that into this set. Let me know if you think that's
> better and I can follow up after the next iteration with that change.

So far it looks better for me, but we can always fix it later.

>
> > > +                               return false;
> > > +                       /* Both should also have first slot at same spi */
> > > +                       if (old->stack[spi].spilled_ptr.dynptr.first_slot != cur->stack[spi].spilled_ptr.dynptr.first_slot)
> > > +                               return false;
> > > +                       /* ids should be same */
> > > +                       if (!!old->stack[spi].spilled_ptr.ref_obj_id != !!cur->stack[spi].spilled_ptr.ref_obj_id)
> > > +                               return false;
> > > +                       if (old->stack[spi].spilled_ptr.ref_obj_id &&
> > > +                           !check_ids(old->stack[spi].spilled_ptr.ref_obj_id,
> > > +                                      cur->stack[spi].spilled_ptr.ref_obj_id, idmap))
> >
> > my previous change to tech check_ids to enforce that either id have to
> > be zeroes or non-zeroes at the same time already landed, so you don't
> > need to check `old->stack[spi].spilled_ptr.ref_obj_id`. Even more, it
> > seems wrong to do this check like this, because if cur has ref_obj_id
> > set we'll ignore it, right?
>
> The check before that ensures either both are set or both are unset. If there is
> a mismatch we return false. I see that check_ids does it now, so yes it wouldn't
> be needed anymore. I am not sure about the last part, I don't think it will be
> ignored?

Right, I forgot about that `if with !!old.ref_obj_id != !!cur.ref_obj_id`.
