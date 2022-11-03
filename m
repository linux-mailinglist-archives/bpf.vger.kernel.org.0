Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69A6B617EE6
	for <lists+bpf@lfdr.de>; Thu,  3 Nov 2022 15:07:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbiKCOHP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Nov 2022 10:07:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbiKCOHP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Nov 2022 10:07:15 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 876ECE07
        for <bpf@vger.kernel.org>; Thu,  3 Nov 2022 07:07:13 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id v17so3170165edc.8
        for <bpf@vger.kernel.org>; Thu, 03 Nov 2022 07:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NZZy0Mi4ret3F0ZP1x09Qzkgv/PXounT7JLXp8YwYds=;
        b=EjYhkwtestmAr00RWgymWfSKZzTCkX+ihGHxFxSCk2BRl4bjP+fgOQI0Wiiq31Q7VD
         IsTyeMUi1k92ohdZq7qPEa4o09bQWIxjPwVHXQZdzPJjurmKYYVLcb+gJMMdFOzayJ4M
         duA0lRT7NYN/gsTysBe+8rpiO58aKknnG61UJvIlb4CHMHE6hsRfNJOpArqaaAOBdf1T
         KY7sheWdu8O6R9K9IimPjlxa9STFtSPvreulVziEm5wMTcvwnuEc8g0UR0PpCcQQLxSE
         r9e8EeKYmvFg91sx3BmDvuOYQOfqfE5eoAm6sF8KCYtRWxJ31aLRW847Q05qGc0hgrfQ
         peXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NZZy0Mi4ret3F0ZP1x09Qzkgv/PXounT7JLXp8YwYds=;
        b=j10RdLLVnEQhn2Uh3IiT4NKUFMNNsRhhYCzjtj6H2aOU4QacSx/kuTZi5pmz3Xr5UE
         JAcppi01d1MxxNgEBXHgM+usDrk/eO8e5S2aDjcQXYr4cz5GGNosXrzoYOcZlKT7sWJY
         h4xLduG8TeVgnkAm8tIjheRAQJOhbrstHLgYzdxug2cUeVVfXrPDUoX8faMX40gLllUa
         T97QIqZqNPyRXKV4QBmADrrkVL+BA0a9IpmgW34hMpkTPnHJCuYEI74RyZ2M1nXwaMTI
         qDpyHenvkbpSYdxSWAgG40IW7WozQTAsJGS6tqlcJxGaejyy7hI2cSFRPPmTo49hx3r4
         0rDg==
X-Gm-Message-State: ACrzQf3ImwF0N9VsMIGH9HAL6aBh7xXSoW7aaQg/jLa1mkPDlWGo9rxm
        aj0BEzubnjQzKKoXOvbR8k1D/lc9wT3UNxR5zi8=
X-Google-Smtp-Source: AMsMyM4GYYY0glyZGqELaVXQdLFYAVjfWQKhs9Ng18k0AX7A4ZtgGsDCs/deHmqRo4YVGr+IpJ9rEYfgW4KdbDsnUG0=
X-Received: by 2002:a05:6402:2751:b0:443:d90a:43d4 with SMTP id
 z17-20020a056402275100b00443d90a43d4mr30861783edd.368.1667484431893; Thu, 03
 Nov 2022 07:07:11 -0700 (PDT)
MIME-Version: 1.0
References: <20221018135920.726360-1-memxor@gmail.com> <20221018135920.726360-8-memxor@gmail.com>
 <CAJnrk1Y_zn+oR3pN8bd3tHV2VubFxBc00XhcNzaWzHkSn1-UMw@mail.gmail.com> <20221022040830.usuuoeq35mj7vnxe@apollo>
In-Reply-To: <20221022040830.usuuoeq35mj7vnxe@apollo>
From:   Joanne Koong <joannelkoong@gmail.com>
Date:   Thu, 3 Nov 2022 14:07:00 +0000
Message-ID: <CAJnrk1Zucjztcp-jjp_eRszU+P8BJv71-WimLybEqLtPx_T3mQ@mail.gmail.com>
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

On Sat, Oct 22, 2022 at 5:08 AM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> On Sat, Oct 22, 2022 at 04:20:28AM IST, Joanne Koong wrote:
> > On Tue, Oct 18, 2022 at 6:59 AM Kumar Kartikeya Dwivedi
> > <memxor@gmail.com> wrote:
> > >
> > > Currently, while reads are disallowed for dynptr stack slots, writes are
> > > not. Reads don't work from both direct access and helpers, while writes
> > > do work in both cases, but have the effect of overwriting the slot_type.
> > >
> > > While this is fine, handling for a few edge cases is missing. Firstly,
> > > a user can overwrite the stack slots of dynptr partially.
> > >
> > > Consider the following layout:
> > > spi: [d][d][?]
> > >       2  1  0
> > >
> > > First slot is at spi 2, second at spi 1.
> > > Now, do a write of 1 to 8 bytes for spi 1.
> > >
> > > This will essentially either write STACK_MISC for all slot_types or
> > > STACK_MISC and STACK_ZERO (in case of size < BPF_REG_SIZE partial write
> > > of zeroes). The end result is that slot is scrubbed.
> > >
> > > Now, the layout is:
> > > spi: [d][m][?]
> > >       2  1  0
> > >
> > > Suppose if user initializes spi = 1 as dynptr.
> > > We get:
> > > spi: [d][d][d]
> > >       2  1  0
> > >
> > > But this time, both spi 2 and spi 1 have first_slot = true.
> > >
> > > Now, when passing spi 2 to dynptr helper, it will consider it as
> > > initialized as it does not check whether second slot has first_slot ==
> > > false. And spi 1 should already work as normal.
> > >
> > > This effectively replaced size + offset of first dynptr, hence allowing
> > > invalid OOB reads and writes.
> > >
> > > Make a few changes to protect against this:
> > > When writing to PTR_TO_STACK using BPF insns, when we touch spi of a
> > > STACK_DYNPTR type, mark both first and second slot (regardless of which
> > > slot we touch) as STACK_INVALID. Reads are already prevented.
> > >
> > > Second, prevent writing to stack memory from helpers if the range may
> > > contain any STACK_DYNPTR slots. Reads are already prevented.
> > >
> > > For helpers, we cannot allow it to destroy dynptrs from the writes as
> > > depending on arguments, helper may take uninit_mem and dynptr both at
> > > the same time. This would mean that helper may write to uninit_mem
> > > before it reads the dynptr, which would be bad.
> > >
> > > PTR_TO_MEM: [?????dd]
> > >
> > > Depending on the code inside the helper, it may end up overwriting the
> > > dynptr contents first and then read those as the dynptr argument.
> > >
> > > Verifier would only simulate destruction when it does byte by byte
> > > access simulation in check_helper_call for meta.access_size, and
> > > fail to catch this case, as it happens after argument checks.
> > >
> > > The same would need to be done for any other non-trivial objects created
> > > on the stack in the future, such as bpf_list_head on stack, or
> > > bpf_rb_root on stack.
> > >
> > > A common misunderstanding in the current code is that MEM_UNINIT means
> > > writes, but note that writes may also be performed even without
> > > MEM_UNINIT in case of helpers, in that case the code after handling meta
> > > && meta->raw_mode will complain when it sees STACK_DYNPTR. So that
> > > invalid read case also covers writes to potential STACK_DYNPTR slots.
> > > The only loophole was in case of meta->raw_mode which simulated writes
> > > through instructions which could overwrite them.
> > >
> > > A future series sequenced after this will focus on the clean up of
> > > helper access checks and bugs around that.
> >
> > thanks for your work on this (and on the rest of the stack, which I'm
> > still working on reviewing)
> >
> > Regarding writes leading to partial dynptr stack slots, I'm regretting
> > not having the verifier flat-out reject this in the first place
> > (instead of it being allowed but internally the stack slot gets marked
> > as invalid) - I think it overall ends up being more confusing to end
> > users, where there it's not obvious at all that writing to the dynptr
> > on the stack automatically invalidates it. I'm not sure whether it's
> > too late from a public API behavior perspective to change this or not.
>
> It would be incorrect to reject writes into dynptrs whose reference is not
> tracked by the verifier (so bpf_dynptr_from_mem), because the compiler would be
> free to reuse the stack space for some other variable when the local dynptr
> variable's lifetime ends, and the verifier would have no way to know when the
> variable went out of scope.
>
> I feel it is also incorrect to refuse bpf_dynptr_from_mem where unref dynptr
> already exists as well. Right now it sees STACK_DYNPTR in the slot_type and
> fails. But consider something like this:
>
> void prog(void)
> {
>         {
>                 struct bpf_dynptr ptr;
>                 bpf_dynptr_from_mem(...);
>                 ...
>         }
>
>         ...
>
>         {
>                 struct bpf_dynptr ptr;
>                 bpf_dynptr_from_mem(...);
>         }
> }
>
> The program is valid, but if ptr in both scopes share the same stack slots, the
> call in the second scope would fail because verifier would see STACK_DYNPTR in
> slot_type.
>
> It is fine though to simply reject writes in case of dynptrs obtained from
> bpf_ringbuf_reserve_dynptr, because if they are overwritten before being
> released, it will end up being an error later due to unreleased reference state.
> The lifetime of the object in this case is being controlled using BPF helpers
> explicitly.
>
> So I think it is ok to do in the second case, and it is unaffected by backward
> compatibility constraints. It wouldn't have been possible for the unref case
> even when you started out with this.

I see! I didn't realize the compiler can reuse the stack slot for
different variables within the same stack frame. I agree with your
thoughts.

>
> > ANyways, assuming it is too late, I left a few comments below.
> >
> > >
> > > Fixes: 97e03f521050 ("bpf: Add verifier support for dynptrs")
> > > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > > ---
> > >  kernel/bpf/verifier.c | 76 +++++++++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 76 insertions(+)
> > >
> > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > index 0fd73f96c5e2..89ae384ea6a7 100644
> > > --- a/kernel/bpf/verifier.c
> > > +++ b/kernel/bpf/verifier.c
> > > @@ -740,6 +740,8 @@ static void mark_dynptr_cb_reg(struct bpf_reg_state *reg1,
> > >         __mark_dynptr_regs(reg1, NULL, type);
> > >  }
> > >
> > > +static void destroy_stack_slots_dynptr(struct bpf_verifier_env *env,
> > > +                                      struct bpf_func_state *state, int spi);
> > >
> > >  static int mark_stack_slots_dynptr(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
> > >                                    enum bpf_arg_type arg_type, int insn_idx)
> > > @@ -755,6 +757,9 @@ static int mark_stack_slots_dynptr(struct bpf_verifier_env *env, struct bpf_reg_
> > >         if (!is_spi_bounds_valid(state, spi, BPF_DYNPTR_NR_SLOTS))
> > >                 return -EINVAL;
> > >
> > > +       destroy_stack_slots_dynptr(env, state, spi);
> > > +       destroy_stack_slots_dynptr(env, state, spi - 1);
> >
> > I don't think we need these two lines. mark_stack_slots_dynptr() is
> > called only in the case where an uninitialized dynptr is getting
> > initialized; is_dynptr_reg_valid_uninit() will have already been
> > called prior to this (in check_func_arg()), where
> > is_dynptr_reg_valid_uninit() will have checked that for any
> > uninitialized dynptr, the stack slot has not already been marked as
> > STACK_DYNTPR. Maybe I'm missing something in this analysis? What are
> > your thoughts?
> >
>
> You're right, it shouldn't be needed here now.
> In case of insn writes we already destroy both slots of a pair.
>
> If we decide to allow mark_stack_slots_dynptr on STACK_DYNPTR that is
> unreferenced, per the discussion above, I will keep it, because it would be
> needed then, otherwise I will drop it.

I think we should remove these two lines from this patch and have the
code for allowing mark_stack_slots_dynptr on unreferenced
STACK_DYNPTRs as a separate patch since that will also require changes
to is_dynptr_reg_valid_uninit().

>
> > > +
> > >         for (i = 0; i < BPF_REG_SIZE; i++) {
> > >                 state->stack[spi].slot_type[i] = STACK_DYNPTR;
> > >                 state->stack[spi - 1].slot_type[i] = STACK_DYNPTR;
> > > @@ -829,6 +834,44 @@ static int unmark_stack_slots_dynptr(struct bpf_verifier_env *env, struct bpf_re
> > >         return 0;
> > >  }
> > >
> > > +static void destroy_stack_slots_dynptr(struct bpf_verifier_env *env,
> > > +                                      struct bpf_func_state *state, int spi)
> > > +{
> > > +       int i;
> > > +
> > > +       /* We always ensure that STACK_DYNPTR is never set partially,
> > > +        * hence just checking for slot_type[0] is enough. This is
> > > +        * different for STACK_SPILL, where it may be only set for
> > > +        * 1 byte, so code has to use is_spilled_reg.
> > > +        */
> > > +       if (state->stack[spi].slot_type[0] != STACK_DYNPTR)
> > > +               return;
> > > +       /* Reposition spi to first slot */
> > > +       if (!state->stack[spi].spilled_ptr.dynptr.first_slot)
> > > +               spi = spi + 1;
> > > +
> > > +       mark_stack_slot_scratched(env, spi);
> > > +       mark_stack_slot_scratched(env, spi - 1);
> > > +
> > > +       /* Writing partially to one dynptr stack slot destroys both. */
> > > +       for (i = 0; i < BPF_REG_SIZE; i++) {
> > > +               state->stack[spi].slot_type[i] = STACK_INVALID;
> > > +               state->stack[spi - 1].slot_type[i] = STACK_INVALID;
> > > +       }
> > > +
> > > +       /* Do not release reference state, we are destroying dynptr on stack,
> > > +        * not using some helper to release it. Just reset register.
> > > +        */
> > > +       __mark_reg_not_init(env, &state->stack[spi].spilled_ptr);
> > > +       __mark_reg_not_init(env, &state->stack[spi - 1].spilled_ptr);
> > > +
> > > +       /* Same reason as unmark_stack_slots_dynptr above */
> > > +       state->stack[spi].spilled_ptr.live |= REG_LIVE_WRITTEN;
> > > +       state->stack[spi - 1].spilled_ptr.live |= REG_LIVE_WRITTEN;
> > > +
> > > +       return;
> > > +}
> >
> > I think it'd be cleaner if we combined this and
> > unmark_stack_slots_dynptr() into one function. The logic is pretty
> > much the same except for if the reference state should be released.
> >
>
> Ack, will do. I can put this logic in a common function and both could be
> callers of that, passing true/false, so it remains readable while avoiding the
> duplication.
>
> > > +
> > >  static bool is_dynptr_reg_valid_uninit(struct bpf_verifier_env *env, struct bpf_reg_state *reg)
> > >  {
> > >         struct bpf_func_state *state = func(env, reg);
> > > @@ -3183,6 +3226,8 @@ static int check_stack_write_fixed_off(struct bpf_verifier_env *env,
> > >                         env->insn_aux_data[insn_idx].sanitize_stack_spill = true;
> > >         }
> > >
> > > +       destroy_stack_slots_dynptr(env, state, spi);
> >
> > If the stack slot is a dynptr, I think we can just return after this
> > call, else we do extra work and mark the stack slots as STACK_MISC
> > (3rd case in the if statement).
> >
>
> That is the intention here. The destroy_stack_slots_dynptr overwrites two slots,
> while we still simulate the write to the slot being written to.
>
> [?][d][d]
>  2  1  0
>
> If I wrote to spi = 1, it would now be [?][m][?].
> Earlier it would have been [?][m][d].
>
> Any stray write (either fixed or variable offset) to a dynptr slot ends the
> lifetime of the dynptr object, so both slots representing the dynptr object need
> to be invalidated.
>
> But the write itself needs to happen, and its state has to be reflected in the
> stack state for those particular slot(s).
>
> The main point here is to prevent partial destruction, which allows manifesting
> the case described in the commit log. Writing to one slot of the two
> representing a dynptr invalidates both.

Returning after the destroy_stack_slots_dynptr call would overwrite
both slots; my previous point was that we could return after calling
this instead of also going through the 3rd if statement below. But I
just realized that we do need to go through the 3rd if statement since
the stack slots need to be STACK_MISC, not STACK_INVALID.

>
> > > +
> > >         mark_stack_slot_scratched(env, spi);
> > >         if (reg && !(off % BPF_REG_SIZE) && register_is_bounded(reg) &&
> > >             !register_is_null(reg) && env->bpf_capable) {
> > > @@ -3296,6 +3341,13 @@ static int check_stack_write_var_off(struct bpf_verifier_env *env,
> > >         if (err)
> > >                 return err;
> > >
> > > +       for (i = min_off; i < max_off; i++) {
> > > +               int slot, spi;
> > > +
> > > +               slot = -i - 1;
> > > +               spi = slot / BPF_REG_SIZE;
> > > +               destroy_stack_slots_dynptr(env, state, spi);
> > > +       }
> > >
> >
> > Instead of calling destroy_stack_slots_dynptr() in
> > check_stack_write_fixed_off() and check_stack_write_var_off(), I think
> > calling it from check_stack_write() would be a better place. I think
> > that'd be more efficient as well where if it is a write to a dynptr,
> > we can directly return after invalidating the stack slot.
> >
>
> We cannot directly return, as explained above.
>
> > >         /* Variable offset writes destroy any spilled pointers in range. */
> > >         for (i = min_off; i < max_off; i++) {
> > > @@ -5257,6 +5309,30 @@ static int check_stack_range_initialized(
> > >         }
> > >
> > >         if (meta && meta->raw_mode) {
> > > +               /* Ensure we won't be overwriting dynptrs when simulating byte
> > > +                * by byte access in check_helper_call using meta.access_size.
> > > +                * This would be a problem if we have a helper in the future
> > > +                * which takes:
> > > +                *
> > > +                *      helper(uninit_mem, len, dynptr)
> > > +                *
> > > +                * Now, uninint_mem may overlap with dynptr pointer. Hence, it
> > > +                * may end up writing to dynptr itself when touching memory from
> > > +                * arg 1. This can be relaxed on a case by case basis for known
> > > +                * safe cases, but reject due to the possibilitiy of aliasing by
> > > +                * default.
> > > +                */
> > > +               for (i = min_off; i < max_off + access_size; i++) {
> > > +                       slot = -i - 1;
> > > +                       spi = slot / BPF_REG_SIZE;
> >
> > I think we can just use get_spi(i) here
> >
>
> Ack.
>
> > > +                       /* raw_mode may write past allocated_stack */
> > > +                       if (state->allocated_stack <= slot)
> > > +                               continue;
> >
> > break?
> >
>
> I think you realised why it's continue in your other reply :).
