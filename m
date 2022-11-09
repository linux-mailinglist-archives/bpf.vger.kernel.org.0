Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 068766232B9
	for <lists+bpf@lfdr.de>; Wed,  9 Nov 2022 19:41:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231378AbiKISlz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Nov 2022 13:41:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231458AbiKISlh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Nov 2022 13:41:37 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDA4E20BE8
        for <bpf@vger.kernel.org>; Wed,  9 Nov 2022 10:41:28 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id d20so16841484plr.10
        for <bpf@vger.kernel.org>; Wed, 09 Nov 2022 10:41:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0klVcULHlU8QXUEofEvOlzpjeMUDF9HThIA1Ap5cafU=;
        b=p/SQBNp03h1dCAlbGNYzoIrkqmkGiVrYdHro8VPgLnF46x5Fhb+eBT+vGz3cUkUVz1
         zTp68PazIW74Ged1YQXZQr8dgQPWCyg/COCiXiLFWo5KE2tuxbVKatSFmKWpa6YYcWsz
         HKOGr+E0A1IzrF4+/5waL8GQCMjrcUxDJgSi3MLYmAwvdfyyimN5/WJ2ELvTO+QlBn8R
         jekUKNtCCihexRGKivqWRHlgpHvu9P3VmMtISPhxaewq9+Xd1xaV2khGYdOC2Sre6PUK
         xC5YHF3lnyCgu7bY2ptzD3XscQpMCUUIvp0JDZevJU/jvYz9dxNv/haw1m7Pmzx/hxlg
         wixg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0klVcULHlU8QXUEofEvOlzpjeMUDF9HThIA1Ap5cafU=;
        b=uid7nLXKuXdG/zaBjUZJJjJJ12ugX3JlbTjPVJBk2i9RbGA1LvxCo9/730V11pRpRB
         Za54s78oLfqTBNm/a92++x80zYacnn9+FmwYoP3u4xB1MNfQMPqAk4b8/dxlZSksKvHS
         pTRj3a32rdaJ9MP2/uxvxLwX/EARk6+KjngcMG7CAiH6SfpF7uXVYsPCCQGuR7o1Iehu
         6KaEy1OX4aT/WxWmxLif/ntMwlu9NQVmK+4IACETASM5mETZC77YyMTuVhdu93nNPKEu
         r+GYMdWIX+AUr8YztM3t10mJTG1lWuNIqnKLLrK0ciA4A9cjB+cJ2CUFguANrnA03grc
         qdBw==
X-Gm-Message-State: ACrzQf2/MLVkbNToMl4KAEd10at6z5zs6lgyAY+x3c/vGaDg0yZQM039
        p9Yr/Sp9kz0WNx0FoZ1F2Ag=
X-Google-Smtp-Source: AMsMyM4ZUz9JyvHCpu62YLqkTLdt2FUaIdXWAL/YJdGWV7vO1gkEdTR/ejC978Dk9zf/eBkFWSfUsQ==
X-Received: by 2002:a17:902:6ac2:b0:184:7a4c:fdd6 with SMTP id i2-20020a1709026ac200b001847a4cfdd6mr61776828plt.54.1668019287955;
        Wed, 09 Nov 2022 10:41:27 -0800 (PST)
Received: from localhost ([103.4.222.252])
        by smtp.gmail.com with ESMTPSA id n126-20020a622784000000b005624e2e0508sm8519407pfn.207.2022.11.09.10.41.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 10:41:27 -0800 (PST)
Date:   Thu, 10 Nov 2022 00:09:14 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Joanne Koong <joannelkoong@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        David Vernet <void@manifault.com>
Subject: Re: [PATCH bpf-next v1 05/13] bpf: Fix state pruning for
 STACK_DYNPTR stack slots
Message-ID: <20221109183914.jutmz277zwbpdlbh@apollo>
References: <20221018135920.726360-1-memxor@gmail.com>
 <20221018135920.726360-6-memxor@gmail.com>
 <CAJnrk1b08wtmrac2HENCSYyRjD3van6jjKmkYP_Lq4gCCLCoHg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJnrk1b08wtmrac2HENCSYyRjD3van6jjKmkYP_Lq4gCCLCoHg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Nov 09, 2022 at 01:52:50AM IST, Joanne Koong wrote:
> On Tue, Oct 18, 2022 at 6:59 AM Kumar Kartikeya Dwivedi
> <memxor@gmail.com> wrote:
> >
> > The root of the problem is missing liveness marking for STACK_DYNPTR
> > slots. This leads to all kinds of problems inside stacksafe.
> >
> > The verifier by default inside stacksafe ignores spilled_ptr in stack
> > slots which do not have REG_LIVE_READ marks. Since this is being checked
> > in the 'old' explored state, it must have already done clean_live_states
> > for this old bpf_func_state. Hence, it won't be receiving any more
> > liveness marks from to be explored insns (it has received REG_LIVE_DONE
> > marking from liveness point of view).
>
> To summarize, your last two sentences are saying that once an "old"
> state has been explored, its liveness will never be modified when the
> verifier explores other newer states, correct?
>

Yes, once you enter is_state_visited for a prune point with the current state,
it will do clean_live_states for all existing states at that insn_idx (with the
same callsite) for states with branches == 0. The branches counter keeps track
of currently being explored paths. It is always 1 by default for cur.]

So it is not ok to set REG_LIVE_DONE for them when branches > 0, as it shows
that there are still other paths that need to be explored and this is possibly a
parent of those.

So when branches == 0, it becomes a completely explored state with nothing left
to be simulated for it. It will be receiving no more liveness marks from
anything, so we can set REG_LIVE_DONE for its regs.

An example is an if statement. When you do that you use push_stack to push one
state to be explored, and the follow the 'else' in the current state. When
current reaches BPF_EXIT, you will pop the other branch and continue exploring
from there. So when we do push_stack cur->parent.branches will become 2, and it
will be 1 for both cur and the pushed state.

> >
> > What this means is that verifier considers that it's safe to not compare
> > the stack slot if was never read by children states. While liveness
> > marks are usually propagated correctly following the parentage chain for
> > spilled registers (SCALAR_VALUE and PTR_* types), the same is not the
> > case for STACK_DYNPTR.
> >
>
> In the context of liveness marking, what is "parent" and "children"?
> Is the parent the first possibility that is explored, and every
> possibility after that is its children?
>

parent will be the state we forked from, the registers in current are connected
to the same registers in parent using reg->parent. Liveness allows us to know
whether that forked child state ever really used the particular reg in our state
later.

Once everything has been explored for our children and our branches count drops
to 0, and a reg never got REG_LIVE_READ propagated by following reg->parent
whenever a read was done for a reg, we know that the reg was unused, so it isn't
required to compare it during states_equal checks. Both regsafe and stacksafe
ignore regs without REG_LIVE_READ.

The child sets REG_LIVE_WRITTEN whenever it overwrites a reg, as that value of
the parent no longer matters to it. There are some subtleties (like not setting
it when size != BPF_REG_SIZE, because the partial contents still continue to
matter).

> > clean_live_states hence simply rewrites these stack slots to the type
> > STACK_INVALID since it sees no REG_LIVE_READ marks.
> >
> > The end result is that we will never see STACK_DYNPTR slots in explored
> > state. Even if verifier was conservatively matching !REG_LIVE_READ
> > slots, very next check continuing the stacksafe loop on seeing
> > STACK_INVALID would again prevent further checks.
> >
> > Now as long as verifier stores an explored state which we can compare to
> > when reaching a pruning point, we can abuse this bug to make verifier
> > prune search for obviously unsafe paths using STACK_DYNPTR slots
> > thinking they are never used hence safe.
> >
> > Doing this in unprivileged mode is a bit challenging. add_new_state is
> > only set when seeing BPF_F_TEST_STATE_FREQ (which requires privileges)
> > or when jmps_processed difference is >= 2 and insn_processed difference
> > is >= 8. So coming up with the unprivileged case requires a little more
> > work, but it is still totally possible. The test case being discussed
> > below triggers the heuristic even in unprivileged mode.
> >
> > However, it no longer works since commit
> > 8addbfc7b308 ("bpf: Gate dynptr API behind CAP_BPF").
> >
> > Let's try to study the test step by step.
> >
> > Consider the following program (C style BPF ASM):
> >
> > 0  r0 = 0;
> > 1  r6 = &ringbuf_map;
> > 3  r1 = r6;
> > 4  r2 = 8;
> > 5  r3 = 0;
> > 6  r4 = r10;
> > 7  r4 -= -16;
> > 8  call bpf_ringbuf_reserve_dynptr;
> > 9  if r0 == 0 goto pc+1;
> > 10 goto pc+1;
> > 11 *(r10 - 16) = 0xeB9F;
> > 12 r1 = r10;
> > 13 r1 -= -16;
> > 14 r2 = 0;
> > 15 call bpf_ringbuf_discard_dynptr;
> > 16 r0 = 0;
> > 17 exit;
> >
> > We know that insn 12 will be a pruning point, hence if we force
> > add_new_state for it, it will first verify the following path as
> > safe in straight line exploration:
> > 0 1 3 4 5 6 7 8 9 -> 10 -> (12) 13 14 15 16 17
> >
> > Then, when we arrive at insn 12 from the following path:
> > 0 1 3 4 5 6 7 8 9 -> 11 (12)
> >
> > We will find a state that has been verified as safe already at insn 12.
> > Since register state is same at this point, regsafe will pass. Next, in
> > stacksafe, for spi = 0 and spi = 1 (location of our dynptr) is skipped
> > seeing !REG_LIVE_READ. The rest matches, so stacksafe returns true.
> > Next, refsafe is also true as reference state is unchanged in both
> > states.
> >
> > The states are considered equivalent and search is pruned.
> >
> > Hence, we are able to construct a dynptr with arbitrary contents and use
> > the dynptr API to operate on this arbitrary pointer and arbitrary size +
> > offset.
> >
> > To fix this, first define a mark_dynptr_read function that propagates
> > liveness marks whenever a valid initialized dynptr is accessed by dynptr
> > helpers. REG_LIVE_WRITTEN is marked whenever we initialize an
> > uninitialized dynptr. This is done in mark_stack_slots_dynptr. It allows
> > screening off mark_reg_read and not propagating marks upwards from that
> > point.
> >
> > This ensures that we either set REG_LIVE_READ64 on both dynptr slots, or
> > none, so clean_live_states either sets both slots to STACK_INVALID or
> > none of them. This is the invariant the checks inside stacksafe rely on.
> >
> > Next, do a complete comparison of both stack slots whenever they have
> > STACK_DYNPTR. Compare the dynptr type stored in the spilled_ptr, and
> > also whether both form the same first_slot. Only then is the later path
> > safe.
> >
> > Fixes: 97e03f521050 ("bpf: Add verifier support for dynptrs")
> > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > ---
> >  kernel/bpf/verifier.c | 73 +++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 73 insertions(+)
> >
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index a8c277e51d63..8f667180f70f 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -752,6 +752,9 @@ static int mark_stack_slots_dynptr(struct bpf_verifier_env *env, struct bpf_reg_
> >                 state->stack[spi - 1].spilled_ptr.ref_obj_id = id;
> >         }
> >
> > +       state->stack[spi].spilled_ptr.live |= REG_LIVE_WRITTEN;
> > +       state->stack[spi - 1].spilled_ptr.live |= REG_LIVE_WRITTEN;
> > +
>
> Is the purpose of REG_LIVE_WRITTEN that it indicates to the verifier
> that this register needs to be checked when comparing the state
> against another possible state?
>

It simply means that the slot was overwritten, so we shouldn't be following
spilled_ptr.parent when doing mark_reg_read for the spilled_ptr in
mark_dynptr_read. __mark_reg_not_init won't touch live, parent, and other such
states, so they need to be handled separately.

> >         return 0;
> >  }
> >
> > @@ -776,6 +779,26 @@ static int unmark_stack_slots_dynptr(struct bpf_verifier_env *env, struct bpf_re
> >
> >         __mark_reg_not_init(env, &state->stack[spi].spilled_ptr);
> >         __mark_reg_not_init(env, &state->stack[spi - 1].spilled_ptr);
> > +
> > +       /* Why do we need to set REG_LIVE_WRITTEN for STACK_INVALID slot?
> > +        *
> > +        * While we don't allow reading STACK_INVALID, it is still possible to
> > +        * do <8 byte writes marking some but not all slots as STACK_MISC. Then,
> > +        * helpers or insns can do partial read of that part without failing,
> > +        * but check_stack_range_initialized, check_stack_read_var_off, and
> > +        * check_stack_read_fixed_off will do mark_reg_read for all 8-bytes of
> > +        * the slot conservatively. Hence we need to screen off those liveness
> > +        * marking walks.
> > +        *
> > +        * This was not a problem before because STACK_INVALID is only set by
> > +        * default, or in clean_live_states after REG_LIVE_DONE, not randomly
> > +        * during verifier state exploration. Hence, for this case parentage
> > +        * chain will still be live, while earlier reg->parent was NULL, so we
> > +        * need REG_LIVE_WRITTEN to screen off read marker propagation.
>
> What does "screen off" mean in "screen off those liveness marking
> walks" and "screen off read marker propagation"?
>

"screen off" simply means setting REG_LIVE_WRITTEN prevents mark_reg_read from
following reg->parent pointers after that point. What was in this stack slot
doesn't matter anymore as it was overwritten, so it's liveness won't matter and
any reads don't have to be propagated upwards. They need to be propagated to
this slot if children states use it.

> > +        */
> > +       state->stack[spi].spilled_ptr.live |= REG_LIVE_WRITTEN;
> > +       state->stack[spi - 1].spilled_ptr.live |= REG_LIVE_WRITTEN;
> > +
>
>
> >         return 0;
> >  }
> >
> > @@ -2354,6 +2377,30 @@ static int mark_reg_read(struct bpf_verifier_env *env,
> >         return 0;
> >  }
> >
> > +static int mark_dynptr_read(struct bpf_verifier_env *env, struct bpf_reg_state *reg)
> > +{
> > +       struct bpf_func_state *state = func(env, reg);
> > +       int spi, ret;
> > +
> > +       /* For CONST_PTR_TO_DYNPTR, it must have already been done by
> > +        * check_reg_arg in check_helper_call and mark_btf_func_reg_size in
> > +        * check_kfunc_call.
> > +        */
> > +       if (reg->type == CONST_PTR_TO_DYNPTR)
> > +               return 0;
> > +       spi = get_spi(reg->off);
> > +       /* Caller ensures dynptr is valid and initialized, which means spi is in
> > +        * bounds and spi is the first dynptr slot. Simply mark stack slot as
> > +        * read.
> > +        */
> > +       ret = mark_reg_read(env, &state->stack[spi].spilled_ptr,
> > +                           state->stack[spi].spilled_ptr.parent, REG_LIVE_READ64);
> > +       if (ret)
> > +               return ret;
> > +       return mark_reg_read(env, &state->stack[spi - 1].spilled_ptr,
> > +                            state->stack[spi - 1].spilled_ptr.parent, REG_LIVE_READ64);
> > +}
> > +
> >  /* This function is supposed to be used by the following 32-bit optimization
> >   * code only. It returns TRUE if the source or destination register operates
> >   * on 64-bit, otherwise return FALSE.
> > @@ -5648,6 +5695,7 @@ int process_dynptr_func(struct bpf_verifier_env *env, int regno,
> >                         u8 *uninit_dynptr_regno)
> >  {
> >         struct bpf_reg_state *regs = cur_regs(env), *reg = &regs[regno];
> > +       int err;
> >
> >         if ((arg_type & (MEM_UNINIT | MEM_RDONLY)) == (MEM_UNINIT | MEM_RDONLY)) {
> >                 verbose(env, "verifier internal error: misconfigured dynptr helper type flags\n");
> > @@ -5729,6 +5777,10 @@ int process_dynptr_func(struct bpf_verifier_env *env, int regno,
> >                                 err_extra, argno + 1);
> >                         return -EINVAL;
> >                 }
> > +
> > +               err = mark_dynptr_read(env, reg);
> > +               if (err)
> > +                       return err;
> >         }
> >         return 0;
> >  }
> > @@ -11793,6 +11845,27 @@ static bool stacksafe(struct bpf_verifier_env *env, struct bpf_func_state *old,
> >                          * return false to continue verification of this path
> >                          */
> >                         return false;
> > +               /* Both are same slot_type, but STACK_DYNPTR requires more
> > +                * checks before it can considered safe.
> > +                */
> > +               if (old->stack[spi].slot_type[i % BPF_REG_SIZE] == STACK_DYNPTR) {
> > +                       /* If both are STACK_DYNPTR, type must be same */
> > +                       if (old->stack[spi].spilled_ptr.dynptr.type != cur->stack[spi].spilled_ptr.dynptr.type)
> > +                               return false;
> > +                       /* Both should also have first slot at same spi */
> > +                       if (old->stack[spi].spilled_ptr.dynptr.first_slot != cur->stack[spi].spilled_ptr.dynptr.first_slot)
> > +                               return false;
> > +                       /* ids should be same */
> > +                       if (!!old->stack[spi].spilled_ptr.ref_obj_id != !!cur->stack[spi].spilled_ptr.ref_obj_id)
>
> Do we need two !s or is just one ! enough?
>

It is trying to test whether both have ref_obj_id or none.
So if set it turns non-zero to 1, otherwise 0.
Then 1 != 0 or 0 != 1 fails, 0 == 0 or 1 == 1 succeeds,
and if ref_obj_id is set we match the ids in the next comparison.
