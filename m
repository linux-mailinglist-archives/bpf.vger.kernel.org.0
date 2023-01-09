Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B688F662405
	for <lists+bpf@lfdr.de>; Mon,  9 Jan 2023 12:18:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236940AbjAILR7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 9 Jan 2023 06:17:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237014AbjAILRS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 9 Jan 2023 06:17:18 -0500
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82EC819030
        for <bpf@vger.kernel.org>; Mon,  9 Jan 2023 03:17:09 -0800 (PST)
Received: by mail-pl1-x642.google.com with SMTP id d3so9118993plr.10
        for <bpf@vger.kernel.org>; Mon, 09 Jan 2023 03:17:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zltnvYoJa4sB4lTp2xDC/a1mUrSJnanp0mftHw+5Kzw=;
        b=kBRwX6QfyJHI5dA9SIvmHl4hEKjGF2eN+LvWR7l23p4KUqXqw17Aoj24fkyRPPsEMZ
         LXzS+m3b8ue5YmF11UJ1mr5+50uzEPrf5hNtFl2L8x4XBdVhpBfgaREfnHu3US4BR9xJ
         2Ctt++wenZftoa2k0LEnPf9rr5X/492H/s+CRPodgt6SsaAEoC0CMFhpX7U7nP4JJTut
         tbawNp+VfQrm13AyIrGfW3afs0tzVn1PNmWp9c7nt/DClXLMIwxJy66WE1rOXJ/FeJ+q
         JQf1V/+Odurk6DCPiyhYvWf7qCQrF1/O7oR0wEr8DBZdUUC8NgP/vQ8EQh6znzgQIx7G
         yFOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zltnvYoJa4sB4lTp2xDC/a1mUrSJnanp0mftHw+5Kzw=;
        b=qA2xRZDjyHlseI48FH4bpSZaU4EV4CvUma7FP44HC6waU1XDWq6H2PjywGKCnWyHL2
         5YZbiI5ACdLH8T2WjJKn6E3THOen26n2C0s/aB2QPfJjsyBo+D7uTsxXVPjPKeb05WYP
         xzFpl+5mL2MDNbxnrF6hJed+d2pYAwjo2gtUiggE0x3LPD0MMTBi+ioNY7OoBbhYcxN3
         JO9Z4S+YtXsXW9rBBh7ziyEqIiVYEDkWKoTZwv3JxjEySbs83xAZETS1LNlbdz17QAAi
         M6DwV43FyB/xvk0+E3RBUV3wTZQ2qzSYcQ69sviT41wIAmz9gQJrj9oyfrkgTZ0fYvNB
         apbA==
X-Gm-Message-State: AFqh2kq3GzWttwH9VJs6Tbhtma+uTzNhVDRaB6t7LbBgWCMQ7JXLIiFu
        nt+Q1Z44xv9307Y6p63E/o0=
X-Google-Smtp-Source: AMrXdXs2tRkqN1cBYKYg6YJuCxr/LAx5SEfBqsXdW64ajjbN4PQz72cRxsN0Qc2hKOmmy4VvyPBvDw==
X-Received: by 2002:a17:902:e846:b0:189:f990:24af with SMTP id t6-20020a170902e84600b00189f99024afmr93908452plg.20.1673263028783;
        Mon, 09 Jan 2023 03:17:08 -0800 (PST)
Received: from localhost ([2405:201:6014:dae3:7dbb:8857:7c39:bb2a])
        by smtp.gmail.com with ESMTPSA id m11-20020a170902f20b00b00189fdadef9csm5916424plc.107.2023.01.09.03.17.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 03:17:08 -0800 (PST)
Date:   Mon, 9 Jan 2023 16:47:05 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Joanne Koong <joannelkoong@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        David Vernet <void@manifault.com>,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: Re: [PATCH bpf-next v1 1/8] bpf: Fix state pruning for STACK_DYNPTR
 stack slots
Message-ID: <20230109111705.g5s2pdnp4xw2kmbb@apollo>
References: <20230101083403.332783-1-memxor@gmail.com>
 <20230101083403.332783-2-memxor@gmail.com>
 <CAJnrk1b2YaftHpKJCjcGXBScgp1z9Ff4vFqTuZfDGeNF346cJQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJnrk1b2YaftHpKJCjcGXBScgp1z9Ff4vFqTuZfDGeNF346cJQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jan 06, 2023 at 05:48:06AM IST, Joanne Koong wrote:
> On Sun, Jan 1, 2023 at 12:34 AM Kumar Kartikeya Dwivedi
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
> >
> > What this means is that verifier considers that it's safe to not compare
> > the stack slot if was never read by children states. While liveness
> > marks are usually propagated correctly following the parentage chain for
> > spilled registers (SCALAR_VALUE and PTR_* types), the same is not the
> > case for STACK_DYNPTR.
> >
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
> > index 4a25375ebb0d..f7248235e119 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -781,6 +781,9 @@ static int mark_stack_slots_dynptr(struct bpf_verifier_env *env, struct bpf_reg_
> >                 state->stack[spi - 1].spilled_ptr.ref_obj_id = id;
> >         }
> >
> > +       state->stack[spi].spilled_ptr.live |= REG_LIVE_WRITTEN;
> > +       state->stack[spi - 1].spilled_ptr.live |= REG_LIVE_WRITTEN;
> > +
> >         return 0;
> >  }
> >
> > @@ -805,6 +808,26 @@ static int unmark_stack_slots_dynptr(struct bpf_verifier_env *env, struct bpf_re
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
>
> Where does it get set randomly during verifier state exploration for this case?
>

When unmarking dynptr slots, we set STACK_INVALID. There are no other instances
where a slot is marked STACK_INVALID while verifier is doing symbolic execution.
It is either set by default or after checkpointed state won't be receiving
liveness marks anymore (in clean_live_states).

> > +        * chain will still be live, while earlier reg->parent was NULL, so we
>
> What does "live" in  "parentage chain will still be live" here mean?

It just means it will probably have a non-NULL reg->parent (which mark_reg_read
will follow), by default when STACK_INVALID slot is written to the spilled_ptr
will have reg->parent as NULL.

> what does "earlier" in "earlier reg->parent" refer to here, and why
> was the earlier reg->parent NULL?
>

Earlier refers to the default case when STACK_INVALID was not being set while
unmarking dynptr slots. So any mark_reg_read on spilled_ptr didn't propagate any
read marks. Now it can happen, so to make state pruning less conservative we
need to be more careful in places where REG_LIVE_WRITTEN needs to be set to
stop those register parent chain walks in mark_reg_read.

> > [...]
