Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 921EE662430
	for <lists+bpf@lfdr.de>; Mon,  9 Jan 2023 12:27:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233288AbjAIL1T (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 9 Jan 2023 06:27:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237008AbjAIL1D (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 9 Jan 2023 06:27:03 -0500
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D522B12600
        for <bpf@vger.kernel.org>; Mon,  9 Jan 2023 03:27:02 -0800 (PST)
Received: by mail-pl1-x641.google.com with SMTP id jl4so9154564plb.8
        for <bpf@vger.kernel.org>; Mon, 09 Jan 2023 03:27:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SM2czQN++u3GMx3SonrA581TvXNZwZk5rt8pO6KoSuU=;
        b=iujJiDVHUuloCyg9SD4PxpN18gtA46FMpWmykhSVpEMBS5TWiNFRHdsY/W9cKDnNOM
         INVsQox5c6Narq895g+zQA7BpPclOkXGsUh9Qk7KHLegAXU53aq1fMHtM+7P8No+flml
         ncmZjRJ7nitGw+c9YOt6bluz2vHgpqoYsiQ51lLvTpAmh6hOP6y1DDDpKJaxc1kpQA3W
         X+mUUJBjcbf9eUN3kAuzY1oLVZPeh4vjy1gJYBxjK1dmxScUiCQNCmjM4ejmUuxflrB2
         VxSOCyRjcJRZA1yQ7qalGKv7zjZiU8E02De02fFRWGUptgHhh/r99Cc4yXBxMyVOnVWs
         Bebw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SM2czQN++u3GMx3SonrA581TvXNZwZk5rt8pO6KoSuU=;
        b=bNer3khuHPYipWHy8hhdpweZnKtqa7WPEkKkIoBhK69325TldJkBT9OvxNv7+DcaS0
         zbiQmji0tezP355XrrmkN2hvY2WhGLeFBFpwKZjho2uklGe8UVW0nFUOoQhoFakFO30q
         yTSggTUtq9swMeu6wgZORvltIouMCO8M6xXfC+nSUUHNrD3B6wFEq3DgXWwtIyh5shnL
         j267ykIxDr/XPxO7tVMyBoYWUckYJDKWqpZTfayVSbcsTvypPMSqt0EDFmzkzHpqXz+g
         r8Jlohhazp/zBNbRbIe3BN/7SUDvdJmPRZjF9UNmAaV7CG6bVz+pUJnmwgh8uaSIOWcM
         KQIw==
X-Gm-Message-State: AFqh2kqza1MUCVTodcw31jM4gjAAxWtn52rLlrvIMyHB8VCq4OxTqu4l
        dwqtSEx8FHUfxqbB0t/eWBY=
X-Google-Smtp-Source: AMrXdXu7mu888Q8EAdBwYHDyU1TGfBuqHdBJYRzs9jWvXXBJAhvlQWJkOwDR78kiposY8uWRoB/bWg==
X-Received: by 2002:a05:6a20:a016:b0:b5:e461:48b4 with SMTP id p22-20020a056a20a01600b000b5e46148b4mr2326256pzj.22.1673263622313;
        Mon, 09 Jan 2023 03:27:02 -0800 (PST)
Received: from localhost ([2405:201:6014:dae3:7dbb:8857:7c39:bb2a])
        by smtp.gmail.com with ESMTPSA id d5-20020a63d645000000b00478fd9bb6c7sm5001075pgj.75.2023.01.09.03.27.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 03:27:01 -0800 (PST)
Date:   Mon, 9 Jan 2023 16:56:59 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Joanne Koong <joannelkoong@gmail.com>,
        David Vernet <void@manifault.com>,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: Re: [PATCH bpf-next v1 3/8] bpf: Fix partial dynptr stack slot
 reads/writes
Message-ID: <20230109112659.uw6oil6ges5be455@apollo>
References: <20230101083403.332783-1-memxor@gmail.com>
 <20230101083403.332783-4-memxor@gmail.com>
 <CAEf4Bzb7VY=cAq+6=M3VoG-KswYjDTc64qGbv2CwDY5gOpfteA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4Bzb7VY=cAq+6=M3VoG-KswYjDTc64qGbv2CwDY5gOpfteA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jan 05, 2023 at 04:12:52AM IST, Andrii Nakryiko wrote:
> On Sun, Jan 1, 2023 at 12:34 AM Kumar Kartikeya Dwivedi
> <memxor@gmail.com> wrote:
> >
> > Currently, while reads are disallowed for dynptr stack slots, writes are
> > not. Reads don't work from both direct access and helpers, while writes
> > do work in both cases, but have the effect of overwriting the slot_type.
> >
> > While this is fine, handling for a few edge cases is missing. Firstly,
> > a user can overwrite the stack slots of dynptr partially.
> >
> > Consider the following layout:
> > spi: [d][d][?]
> >       2  1  0
> >
> > First slot is at spi 2, second at spi 1.
> > Now, do a write of 1 to 8 bytes for spi 1.
> >
> > This will essentially either write STACK_MISC for all slot_types or
> > STACK_MISC and STACK_ZERO (in case of size < BPF_REG_SIZE partial write
> > of zeroes). The end result is that slot is scrubbed.
> >
> > Now, the layout is:
> > spi: [d][m][?]
> >       2  1  0
> >
> > Suppose if user initializes spi = 1 as dynptr.
> > We get:
> > spi: [d][d][d]
> >       2  1  0
> >
> > But this time, both spi 2 and spi 1 have first_slot = true.
> >
> > Now, when passing spi 2 to dynptr helper, it will consider it as
> > initialized as it does not check whether second slot has first_slot ==
> > false. And spi 1 should already work as normal.
> >
> > This effectively replaced size + offset of first dynptr, hence allowing
> > invalid OOB reads and writes.
> >
> > Make a few changes to protect against this:
> > When writing to PTR_TO_STACK using BPF insns, when we touch spi of a
> > STACK_DYNPTR type, mark both first and second slot (regardless of which
> > slot we touch) as STACK_INVALID. Reads are already prevented.
> >
> > Second, prevent writing to stack memory from helpers if the range may
> > contain any STACK_DYNPTR slots. Reads are already prevented.
> >
> > For helpers, we cannot allow it to destroy dynptrs from the writes as
> > depending on arguments, helper may take uninit_mem and dynptr both at
> > the same time. This would mean that helper may write to uninit_mem
> > before it reads the dynptr, which would be bad.
> >
> > PTR_TO_MEM: [?????dd]
> >
> > Depending on the code inside the helper, it may end up overwriting the
> > dynptr contents first and then read those as the dynptr argument.
> >
> > Verifier would only simulate destruction when it does byte by byte
> > access simulation in check_helper_call for meta.access_size, and
> > fail to catch this case, as it happens after argument checks.
> >
> > The same would need to be done for any other non-trivial objects created
> > on the stack in the future, such as bpf_list_head on stack, or
> > bpf_rb_root on stack.
> >
> > A common misunderstanding in the current code is that MEM_UNINIT means
> > writes, but note that writes may also be performed even without
> > MEM_UNINIT in case of helpers, in that case the code after handling meta
> > && meta->raw_mode will complain when it sees STACK_DYNPTR. So that
> > invalid read case also covers writes to potential STACK_DYNPTR slots.
> > The only loophole was in case of meta->raw_mode which simulated writes
> > through instructions which could overwrite them.
> >
> > A future series sequenced after this will focus on the clean up of
> > helper access checks and bugs around that.
> >
> > Fixes: 97e03f521050 ("bpf: Add verifier support for dynptrs")
> > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > ---
> >  kernel/bpf/verifier.c | 73 +++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 73 insertions(+)
> >
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index ca970f80e395..b985d90505cc 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -769,6 +769,8 @@ static void mark_dynptr_cb_reg(struct bpf_reg_state *reg,
> >         __mark_dynptr_reg(reg, type, true);
> >  }
> >
> > +static void destroy_stack_slots_dynptr(struct bpf_verifier_env *env,
> > +                                      struct bpf_func_state *state, int spi);
> >
> >  static int mark_stack_slots_dynptr(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
> >                                    enum bpf_arg_type arg_type, int insn_idx)
> > @@ -858,6 +860,44 @@ static int unmark_stack_slots_dynptr(struct bpf_verifier_env *env, struct bpf_re
> >         return 0;
> >  }
> >
> > +static void destroy_stack_slots_dynptr(struct bpf_verifier_env *env,
> > +                                      struct bpf_func_state *state, int spi)
> > +{
> > +       int i;
> > +
> > +       /* We always ensure that STACK_DYNPTR is never set partially,
> > +        * hence just checking for slot_type[0] is enough. This is
> > +        * different for STACK_SPILL, where it may be only set for
> > +        * 1 byte, so code has to use is_spilled_reg.
> > +        */
> > +       if (state->stack[spi].slot_type[0] != STACK_DYNPTR)
> > +               return;
> > +       /* Reposition spi to first slot */
> > +       if (!state->stack[spi].spilled_ptr.dynptr.first_slot)
> > +               spi = spi + 1;
> > +
> > +       mark_stack_slot_scratched(env, spi);
> > +       mark_stack_slot_scratched(env, spi - 1);
> > +
> > +       /* Writing partially to one dynptr stack slot destroys both. */
> > +       for (i = 0; i < BPF_REG_SIZE; i++) {
> > +               state->stack[spi].slot_type[i] = STACK_INVALID;
> > +               state->stack[spi - 1].slot_type[i] = STACK_INVALID;
> > +       }
> > +
> > +       /* Do not release reference state, we are destroying dynptr on stack,
> > +        * not using some helper to release it. Just reset register.
> > +        */
> > +       __mark_reg_not_init(env, &state->stack[spi].spilled_ptr);
> > +       __mark_reg_not_init(env, &state->stack[spi - 1].spilled_ptr);
> > +
> > +       /* Same reason as unmark_stack_slots_dynptr above */
> > +       state->stack[spi].spilled_ptr.live |= REG_LIVE_WRITTEN;
> > +       state->stack[spi - 1].spilled_ptr.live |= REG_LIVE_WRITTEN;
> > +
> > +       return;
> > +}
> > +
> >  static bool is_dynptr_reg_valid_uninit(struct bpf_verifier_env *env, struct bpf_reg_state *reg)
> >  {
> >         struct bpf_func_state *state = func(env, reg);
> > @@ -3384,6 +3424,8 @@ static int check_stack_write_fixed_off(struct bpf_verifier_env *env,
> >                         env->insn_aux_data[insn_idx].sanitize_stack_spill = true;
> >         }
> >
> > +       destroy_stack_slots_dynptr(env, state, spi);
> > +
>
> subjective, but it feels like having an explicit slot_type !=
> STACK_DYNPTR here is better, then "destroy_stack_slots_dynptr"
> actually is doing destruction, not "maybe_destroy_stack_slots_dynptr",
> which you effectively are implementing here
>

The intent of the function is to destroy any dynptr which the spi belongs to.
If there is nothing, it will just return. I don't mind pulling the check out,
but I think it's going to be done before each call for this function, so it felt
better to keep it inside it and make non STACK_DYNPTR case a no-op.

> also, shouldn't overwrite of dynptrs w/ ref_obj_id be prevented early
> on with a meaningful error, instead of waiting for "unreleased
> reference" error later on? for ref_obj_id dynptrs we know that you
> have to call helper with OBJ_RELEASE semantics, at which point we'll
> reset stack slots
>
> am I missing something?
>

Yes, I can make that change.

>
> >         mark_stack_slot_scratched(env, spi);
> >         if (reg && !(off % BPF_REG_SIZE) && register_is_bounded(reg) &&
> >             !register_is_null(reg) && env->bpf_capable) {
> > @@ -3497,6 +3539,13 @@ static int check_stack_write_var_off(struct bpf_verifier_env *env,
> >         if (err)
> >                 return err;
> >
> > +       for (i = min_off; i < max_off; i++) {
> > +               int slot, spi;
> > +
> > +               slot = -i - 1;
> > +               spi = slot / BPF_REG_SIZE;
> > +               destroy_stack_slots_dynptr(env, state, spi);
> > +       }
> >
> >         /* Variable offset writes destroy any spilled pointers in range. */
> >         for (i = min_off; i < max_off; i++) {
> > @@ -5524,6 +5573,30 @@ static int check_stack_range_initialized(
> >         }
> >
> >         if (meta && meta->raw_mode) {
> > +               /* Ensure we won't be overwriting dynptrs when simulating byte
> > +                * by byte access in check_helper_call using meta.access_size.
> > +                * This would be a problem if we have a helper in the future
> > +                * which takes:
> > +                *
> > +                *      helper(uninit_mem, len, dynptr)
> > +                *
> > +                * Now, uninint_mem may overlap with dynptr pointer. Hence, it
> > +                * may end up writing to dynptr itself when touching memory from
> > +                * arg 1. This can be relaxed on a case by case basis for known
> > +                * safe cases, but reject due to the possibilitiy of aliasing by
> > +                * default.
> > +                */
> > +               for (i = min_off; i < max_off + access_size; i++) {
> > +                       slot = -i - 1;
>
> nit: slot name is misleading, we normally call entire 8-byte slot a
> "slot", while here slot is actually off, right? same above.
>

The same naming has been used in multiple places, probably because these
functions also get an off parameter passed in from the caller. I guess
stack_off sounds better?

> > +                       spi = slot / BPF_REG_SIZE;
> > +                       /* raw_mode may write past allocated_stack */
> > +                       if (state->allocated_stack <= slot)
> > +                               continue;
> > +                       if (state->stack[spi].slot_type[slot % BPF_REG_SIZE] == STACK_DYNPTR) {
> > +                               verbose(env, "potential write to dynptr at off=%d disallowed\n", i);
> > +                               return -EACCES;
> > +                       }
> > +               }
> >                 meta->access_size = access_size;
> >                 meta->regno = regno;
> >                 return 0;
> > --
> > 2.39.0
> >
