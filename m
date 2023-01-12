Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1BA9667EBC
	for <lists+bpf@lfdr.de>; Thu, 12 Jan 2023 20:09:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235752AbjALTJY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 Jan 2023 14:09:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232588AbjALTIw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 12 Jan 2023 14:08:52 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 676221D0F0
        for <bpf@vger.kernel.org>; Thu, 12 Jan 2023 10:52:01 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id d62so3652132ybh.8
        for <bpf@vger.kernel.org>; Thu, 12 Jan 2023 10:52:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oy6U/nT4mg4R6fPllrtNCk6BMu5GYFXlPHIBzY8yS8A=;
        b=VSHiHT8PbwXyLcvPe1rh6t9hCdc3MTJ0ff1onc1o/QRRBwZOq4ClBwUT6NFIzxp/oy
         B7b219h9yROG+ukWKSvTyOPXRFevuIDsWTeeiqJqaQw4IBr16NdytifJ5C4PUVZ1ZlUa
         a23fdTvexHu0hw6Z/9Rb966H1RYo5x26v/a642E12Rjt8AA+NvwP3DKkdK8RBle/cQgV
         vtsjeb3EnFmvxbXasHEIFwD8CZ8yEEgb2o7bv4872qNVfhMunBHcf1WF8bOlODpujKFV
         enGukrWSaBLZ1av3aTBOsGe+sFjZoULiROgNsUJN5vIbXI7W1wi4D2Hlu+6o1WISHLwj
         40+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oy6U/nT4mg4R6fPllrtNCk6BMu5GYFXlPHIBzY8yS8A=;
        b=6aOvr69gE1V3+CyVgKaG15t2h2KAdcaHLi5feZrxKRczH8qW2ykzbrGQTpu+jXaoMC
         NFhfimElsx6H4MD/ha4VgdH2l7V8Kzrunoxy/VAAQ356BLV31bQgpew8ZJOqvp0QxHu1
         NQlrec7K5vDv5v9+8VDAK7K2pIphdS5R9VoO6H9w/9xzIU4Q+mXVcbiz9Ia3T3E2ttti
         NhvL9gssxtvits3QZwQo9BtBtphXMEU8vmc2D7bH10BeTexWcsYHI+vDYHAtzJdMOPoH
         Q47+IYIQwYOugTMJmGigjfpdTUuffIhet+qFbmOIE7TnMtp0Zz6znvKLK8W8JwTPilXO
         5TPw==
X-Gm-Message-State: AFqh2kqW+yH35juG1HKMSjAy6CEnUTLJ+9xMrN65zK+nUJemJCYAboZ0
        iqh8y+YXULzrIltO/dZY9NHvBF6ewlPESSoJPbnbZipBI3M=
X-Google-Smtp-Source: AMrXdXss9m8LDkdEb4NnbxqWkM7F7cy9gzOcFIh9gO03tlmZm/QHpzmJaMf7xfuKicTI7NpgVNK9eyHQ1LdzmdDVsXg=
X-Received: by 2002:a25:3c85:0:b0:6dc:b9ec:7c87 with SMTP id
 j127-20020a253c85000000b006dcb9ec7c87mr8983334yba.322.1673549520467; Thu, 12
 Jan 2023 10:52:00 -0800 (PST)
MIME-Version: 1.0
References: <20230101083403.332783-1-memxor@gmail.com> <20230101083403.332783-4-memxor@gmail.com>
 <CAJnrk1akSFoHx=4nVwqSBJ4Dedh6M5bYm+UdZq3CSG3PM+05WQ@mail.gmail.com> <20230109113049.2pft4sfxsayqcvw6@apollo>
In-Reply-To: <20230109113049.2pft4sfxsayqcvw6@apollo>
From:   Joanne Koong <joannelkoong@gmail.com>
Date:   Thu, 12 Jan 2023 10:51:49 -0800
Message-ID: <CAJnrk1b30vAs-pcgLF31Zr996w2GQD1ObkR2Lvp9ohT4SJ2+rQ@mail.gmail.com>
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

On Mon, Jan 9, 2023 at 3:30 AM Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
>
> On Sat, Jan 07, 2023 at 12:46:23AM IST, Joanne Koong wrote:
> > On Sun, Jan 1, 2023 at 12:34 AM Kumar Kartikeya Dwivedi
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
> > >
> > > Fixes: 97e03f521050 ("bpf: Add verifier support for dynptrs")
> > > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > > ---
> > >  kernel/bpf/verifier.c | 73 +++++++++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 73 insertions(+)
> > >
> > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > index ca970f80e395..b985d90505cc 100644
> > > --- a/kernel/bpf/verifier.c
> > > +++ b/kernel/bpf/verifier.c
> > > @@ -769,6 +769,8 @@ static void mark_dynptr_cb_reg(struct bpf_reg_state *reg,
> > >         __mark_dynptr_reg(reg, type, true);
> > >  }
> > >
> > > +static void destroy_stack_slots_dynptr(struct bpf_verifier_env *env,
> > > +                                      struct bpf_func_state *state, int spi);
> > >
> > >  static int mark_stack_slots_dynptr(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
> > >                                    enum bpf_arg_type arg_type, int insn_idx)
> > > @@ -858,6 +860,44 @@ static int unmark_stack_slots_dynptr(struct bpf_verifier_env *env, struct bpf_re
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
> >
> > nit: an empty line here helps readability
> >
>
> Ok.
>
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
> >
> > I agree with Andrii's point - I think it'd be more helpful if we error
> > out here if the dynptr is refcounted. It'd be easy to check too, we
> > already have dynptr_type_refcounted().
> >
>
> Ack, I'll change it to return an error early.
>
> > > +       __mark_reg_not_init(env, &state->stack[spi].spilled_ptr);
> > > +       __mark_reg_not_init(env, &state->stack[spi - 1].spilled_ptr);
> > > +
> > > +       /* Same reason as unmark_stack_slots_dynptr above */
> > > +       state->stack[spi].spilled_ptr.live |= REG_LIVE_WRITTEN;
> > > +       state->stack[spi - 1].spilled_ptr.live |= REG_LIVE_WRITTEN;
> > > +
> > > +       return;
> >
> > I think we should also invalidate any data slices associated with the
> > dynptrs? It seems natural that once a dynptr is invalidated, none of
> > its data slices should be usable.
> >
>
> Great catch, will fix.
>
> > > +}
> > > +
> > >  static bool is_dynptr_reg_valid_uninit(struct bpf_verifier_env *env, struct bpf_reg_state *reg)
> > >  {
> > >         struct bpf_func_state *state = func(env, reg);
> > > @@ -3384,6 +3424,8 @@ static int check_stack_write_fixed_off(struct bpf_verifier_env *env,
> > >                         env->insn_aux_data[insn_idx].sanitize_stack_spill = true;
> > >         }
> > >
> > > +       destroy_stack_slots_dynptr(env, state, spi);
> > > +
> > >         mark_stack_slot_scratched(env, spi);
> > >         if (reg && !(off % BPF_REG_SIZE) && register_is_bounded(reg) &&
> > >             !register_is_null(reg) && env->bpf_capable) {
> > > @@ -3497,6 +3539,13 @@ static int check_stack_write_var_off(struct bpf_verifier_env *env,
> > >         if (err)
> > >                 return err;
> > >
> > > +       for (i = min_off; i < max_off; i++) {
> > > +               int slot, spi;
> > > +
> > > +               slot = -i - 1;
> > > +               spi = slot / BPF_REG_SIZE;
> >
> > I think you can just use __get_spi() here
> >
>
> Ack.
>
> > > +               destroy_stack_slots_dynptr(env, state, spi);
> >
> > I think here too,
> >
> > if (state->stack[spi].slot_type[0] == STACK_DYNPTR)
> >     destroy_stack_slots_dynptr(env, state, spi)
> >
> > makes it more readable.
> >
> > And if it is a STACK_DYNPTR, we can also fast-forward i.
> >
>
> No issues with such a change, but it's going to precede almost every call to
> this function. I don't have a strong preference, but we could also call it
> destroy_if_dynptr_stack_slot to make it more clear the destructon is conditional
> and move it inside the function.

I don't have a strong preference either. Calling it
destroy_if_dynptr_stack_slot() sounds good as well.

>
> > [...]
