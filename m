Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A8A667EDC3
	for <lists+bpf@lfdr.de>; Fri, 27 Jan 2023 19:45:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234367AbjA0Sp3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 27 Jan 2023 13:45:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234401AbjA0Sp2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 27 Jan 2023 13:45:28 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46DD077DC0
        for <bpf@vger.kernel.org>; Fri, 27 Jan 2023 10:45:26 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id ud5so16159313ejc.4
        for <bpf@vger.kernel.org>; Fri, 27 Jan 2023 10:45:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2vUle81INBSCEDg/ZCd6y1wrnrOZfRjlClZ0tm+39d4=;
        b=pQ+r6FfkBTN9XRyi4iTX2biUiXtFxxlQaCYht8lEN/Zo1RQUP2QsbQVzF+lOiONNPN
         B9zfTwrMogRGK2G3vF+y853z5TEzYnCs0qoKNDKwR+JTV7LkC3uTWsto4jI2OlFOCalO
         /Qh9pwhHmq3RAL/KUV7NXopg382I/AHER24ZlWx8xsFlU6yo9T3Sra+hngIvY4nD6EJp
         qnoNMnx1kdFSmF64ZO86DI2kkXhjpQX057dbc1aBKMIPPM0ZifM+t0RYBHlGeAWrAbsn
         tz7ImFSMNSPxYOOut1/UbB5rBAdibftNObwlcpixqthfTr4kFH8Qmz+HESkWEKpvNt/2
         09Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2vUle81INBSCEDg/ZCd6y1wrnrOZfRjlClZ0tm+39d4=;
        b=cNKzvozsE3io4nFSpNQzQtjgI1uYp/e1tr3XzqZ21eEqpLYxeiSHGB5SUY0JvyfT6a
         0oXLJzEtdk6xFqVsmkEAwMjueMwnNVlnL9MU1MoqCPv3wyvqW2o4ZsiCIWLUonPOepxz
         vjgs2AhNYi3+9A+yxxTIPpF8t/ixAmMfBMqC3Ox9HIBywYJp6Yj7PLnvSVgcoN9nEUQT
         O8m3mKZvl6qpZWuuHU6HKWkhVxW9gkqVIqg8Ta/I4cftO/rbRWGjLLGKg9isY9vrjZKg
         kD+NpW3PpjimKgPiIAXNbvzLUjvnToZIXDJYlUAm90xbSBYAOHEgFFRsDNiXAF6Jp3y0
         Mq6w==
X-Gm-Message-State: AO0yUKVLrKjI6K2YP0NODp1ePS6X4OAsR3yiu2X8F0jyibknxA4OqtWn
        154l55a+qP9I+iNq0L3LPyUr7Q9RiqOlMizZUyM=
X-Google-Smtp-Source: AK7set/bE1Y04QNqeuOluRTMHUtA12JMEZjqZJeB9u8W9LMsESwdinkaZMjUQdnLXtUvlayALTuVSmIY5l0yDLPQmPM=
X-Received: by 2002:a17:906:f1cd:b0:878:4854:fc97 with SMTP id
 gx13-20020a170906f1cd00b008784854fc97mr2443279ejb.296.1674845124635; Fri, 27
 Jan 2023 10:45:24 -0800 (PST)
MIME-Version: 1.0
References: <20230124220343.2942203-1-eddyz87@gmail.com> <CAEf4Bzahu+gnRqFWenzkHAAbnTTTg18e2LMOvYg-+bqj3+-b4Q@mail.gmail.com>
 <af4bf15425d63629c64cbcd08536755f99e7d55a.camel@gmail.com>
In-Reply-To: <af4bf15425d63629c64cbcd08536755f99e7d55a.camel@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 27 Jan 2023 10:45:12 -0800
Message-ID: <CAEf4BzZHZxsB_-C18nySPVpkfxEZ70jy3R1GDz2+uCkewmyRkw@mail.gmail.com>
Subject: Re: [RFC bpf-next] docs/bpf: Add description of register liveness
 tracking algorithm
To:     Eduard Zingerman <eddyz87@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com, yhs@fb.com
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

On Thu, Jan 26, 2023 at 1:34 PM Eduard Zingerman <eddyz87@gmail.com> wrote:
>
> On Thu, 2023-01-26 at 11:50 -0800, Andrii Nakryiko wrote:
> > On Tue, Jan 24, 2023 at 2:04 PM Eduard Zingerman <eddyz87@gmail.com> wrote:
> > >
> > > This is a followup for [1], adds an overview for the register liveness
> > > tracking, covers the following points:
> > > - why register liveness tracking is useful;
> > > - how register parentage chains are constructed;
> > > - how liveness marks are applied using the parentage chains.
> > >
> > > [1] https://lore.kernel.org/bpf/CAADnVQKs2i1iuZ5SUGuJtxWVfGYR9kDgYKhq3rNV+kBLQCu7rA@mail.gmail.com/
> > >
> > > Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> > > ---
> > >  Documentation/bpf/verifier.rst | 237 +++++++++++++++++++++++++++++++++
> > >  1 file changed, 237 insertions(+)
> > >

[...]

> > > +Register parent chains
> > > +~~~~~~~~~~~~~~~~~~~~~~
> > > +
> > > +In order to propagate information between parent and child states register
> > > +parentage chain is established. Each register or spilled stack slot is linked to
> > > +a corresponding register or stack spill slot in it's parent state via a
> > > +``->parent`` pointer. This link is established upon state creation in function
> > > +``is_state_visited()`` and is never changed.
> > > +
> > > +The rules for correspondence between registers / stack spill slots are as
> > > +follows:
> > > +
> > > +* For current stack frame registers and stack spill slots of the new state are
> > > +  linked to the registers and stack spill slots of the parent state with the
> > > +  same indices.
> > > +
> > > +* For outer stack frames only caller saved registers (r6-r9) and stack spill
> > > +  slots are linked to the registers and stack spill slots of the parent state
> > > +  with the same indices.
> > > +
> > > +This could be illustrated by the following diagram (arrows stand for
> > > +``->parent`` pointers)::
> > > +
> > > +      ...                    ; Frame #0, some instructions
> > > +  --- checkpoint #0 ---
> > > +  1 : r6 = 42                ; Frame #0
> > > +  --- checkpoint #1 ---
> > > +  2 : call foo()             ; Frame #0
> > > +      ...                    ; Frame #1, instructions from foo()
> > > +  --- checkpoint #2 ---
> > > +      ...                    ; Frame #1, instructions from foo()
> > > +  --- checkpoint #3 ---
> > > +      exit                   ; Frame #1, return from foo()
> > > +  3 : r1 = r6                ; Frame #0  <- current state
> > > +
> > > +             +--------------------------+--------------------------+
> > > +             |         Frame #0         |         Frame #1         |
> > > +  Checkpoint +--------------------------+--------------------------+
> > > +  #0         | r0-r5 | r6-r9 | fp-8 ... |
> > > +             +--------------------------+
> > > +                ^       ^       ^
> > > +                |       |       |
> > > +  Checkpoint +--------------------------+
> > > +  #1         | r0-r5 | r6-r9 | fp-8 ... |
> > > +             +--------------------------+
> > > +                        ^       ^
> > > +                        |       |
> > > +  Checkpoint +--------------------------+--------------------------+
> > > +  #2         | r0-r5 | r6-r9 | fp-8 ... | r0-r5 | r6-r9 | fp-8 ... |
> > > +             +--------------------------+--------------------------+
> >
> > wouldn't r6-r9 in frame #1 point to r6-r9 of frame #0 in parent state?
> > Or do they point to r6-r9 of frame #0 in the same checkpoint? Either
> > way, should we clarify that part on the diagram somehow?
>
> This is the loop at the end of is_state_visited() that sets up the
> register links (initially the links are zero because of the kzalloc()
> call used for memory allocation):
>
>         cur->parent = new;
>         ...
>         for (j = 0; j <= cur->curframe; j++) {
>                 for (i = j < cur->curframe ? BPF_REG_6 : 0; i < BPF_REG_FP; i++)
>                         cur->frame[j]->regs[i].parent = &new->frame[j]->regs[i];
>                 ...
>         }
>
> The `new` refers to `struct bpf_verifier_state` instance that would
> remain in cache, the `cur` refers to the state that would be used to
> continue verification.
>
> Note that all links in this loop are setup only for identical indices,
> so registers from frame #1 can't point to registers from frame #0.
>
> As far as I understand the following happens (please correct me if I'm wrong):
> - when checkpoint #1 is created from the state derived from
>   checkpoint #0, the cur->curframe is 0;
> - when `call foo` is processed a new instance of `struct bpf_func_state`
>   is allocated to represent frame #1, all parent pointers within this
>   instance are set to null (see call `kzalloc(*callee)` in __check_func_call());
> - checkpoint #2 is derived from a state described above, thus frame #1
>   r0-r9 parent links are null.
>
> I'll add a note on the diagram that the links are null.

yes, you are right, they will be null and thinking about this a bit
more there is no logical connection between r6-r9 of parent and child
functions. It's just a requirement that child function saves/restores
their values if they are used within that function.

>
>
> >
> > > +                        ^       ^          ^       ^      ^
> > > +                        |       |          |       |      |
> > > +  Checkpoint +--------------------------+--------------------------+
> > > +  #3         | r0-r5 | r6-r9 | fp-8 ... | r0-r5 | r6-r9 | fp-8 ... |
> > > +             +--------------------------+--------------------------+
> > > +                        ^       ^
> > > +                        |       |
> > > +  Current    +--------------------------+
> > > +  state      | r0-r5 | r6-r9 | fp-8 ... |
> > > +             +--------------------------+
> > > +                        \
> > > +                          r6 read mark is propagated via
> > > +                          these links all the way up to
> > > +                          checkpoint #1.
> > > +
> > > +Liveness marks tracking
> > > +~~~~~~~~~~~~~~~~~~~~~~~
> > > +
> > > +For each processed instruction verifier propagates information about reads up
> > > +the parentage chain and saves information about writes in the current state.
> > > +The information about reads is propagated by function ``mark_reg_read()`` which
> > > +could be summarized as follows::
> > > +
> > > +  mark_reg_read(struct bpf_reg_state *state):
> > > +      parent = state->parent
> > > +      while parent:
> > > +          if parent->live & REG_LIVE_WRITTEN:
> > > +              break
> > > +          if parent->live & REG_LIVE_READ64:
> > > +              break
> > > +          parent->live |= REG_LIVE_READ64
> > > +          state = parent
> > > +          parent = state->parent
> > > +
> > > +Note: details about REG_LIVE_READ32 are omitted.
> > > +
> > > +Also note: the read marks are applied to the *parent* state while write marks
> > > +are applied to the *current* state.
> > > +
> > > +Because stack writes could have different sizes ``REG_LIVE_WRITTEN`` marks are
> > > +applied conservatively: stack spills are marked as written only if write size
> > > +corresponds to the size of the register, see function ``save_register_state()``
> > > +for an example.
> >
> > so this paragraph mentions a very subtle interaction for stack slots
> > that only get partial register spill and keep other bytes as
> > STACK_MISC. I don't know how much into details we should go her, but
> > maybe calling out explicitly that this has implications when we mix
> > register spill and scalar data in a single 8-byte stack slot would be
> > useful?
>
> I can add the following text:
>
> --- 8< -----------------------------
>
> Consider the following example::
>
>   0: (*u64)(r10 - 8) = 0
>   --- checkpoint #0 ---
>   1: (*u32)(r10 - 8) = 1
>   2: r1 = (*u32)(r10 - 8)
>
> Because write size at instruction (1) is smaller than register size
> the write mark will not be added to fp-8 slot when (1) is verified,
> thus the fp-8 read at instruction (2) would propagate read mark for
> fp-8 up to checkpoint #0.
>
> ----------------------------- >8 ---
>
> wdyt?

Looks good to me, thanks.

>
> >

[...]

> > > +Read marks propagation for cache hits
> > > +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > +
> > > +Another important point is handling of read marks when a previously verified
> > > +state is found in the states cache. All read marks present on registers and
> > > +stack spills of the cached state must be propagated over the parentage chain of
> > > +the current state. Function ``propagate_liveness()`` handles this case.
> > > +
> > > +For example, consider the following state parentage chain::
> > > +
> > > +          +---+
> > > +   A ---> | B | ---> exit
> > > +          |   |
> > > +   C ---> | D |
> > > +          +---+
> > > +
> > > +* Chain ``A -> B -> exit`` is verified first;
> > > +* State ``B`` has read marks for registers ``r1`` and ``r2``;
> > > +* State ``D`` is considered equivalent to state ``B``;
> > > +
> > > +* Read marks for ``r1`` and ``r2`` have to be added in state ``C``, otherwise
> > > +  state ``C`` might get mistakenly marked as equivalent to some future state
> > > +  ``E`` with different values for registers in question.
> >
> > So I'm a bit confused by this section. We are talking about read marks
> > in B and D, and then imply that C has to get it as well, but we don't
> > mention what happens in A. The implication here is probably that read
> > marks that were bubbled up into A should be bubbled up into C, right?
> > But that's not very obvious? Could there be cases where read marks in
> > B are screened in A and never make into it? In that case similar thing
> > will presumably happen for C?
>
> I agree it might be confusing, what about the following text instead:
>
> --- 8< -----------------------------
>
> For example, consider the following state parentage chain (S is a
> starting state, A-E are derived states, -> arrows show which state is
> derived from which)::
>
>                       r1 read
>                <-------------                    A[r1] == 0
>                     +---+                        C[r1] == 0
>       S ---> A ---> | B | ---> exit              E[r1] == 1
>       |             |   |
>       ` ---> C ---> | D |
>       |             +---+
>       ` ---> E
>                       ^
>              ^        |___   suppose all these
>              |             states are at insn #Y
>       suppose all these
>     states are at insn #X
>
> * Chain of states ``S -> A -> B -> exit`` is verified first.
>
> * While ``B -> exit`` is verified register ``r1`` is read and this

nit: gmail complains about missing comma between "verified register",
and it does make reading this easier

>   read mark is propagated up to state ``A``.
>
> * When chain of states ``C -> D`` is verified the state ``D`` turns
>   out to be equivalent to state ``B``.
>
> * The read mark for ``r1`` has to be propagated to state ``C``,
>   otherwise state ``C`` might get mistakenly marked as equivalent to
>   state ``E`` even though values for register ``r1`` differ between
>   ``C`` and ``E``.
>
> ----------------------------- >8 ---
>
> The reason I don't want to put an example program here is that example
> programs I can come up with are even more confusing than explanation above.

No, this is perfect and very clear, IMO. Just add the comma ;)

>
> > I'd also call out conceptual similarity of this after the fact
> > propagation of liveness marks to precision marks. It's the same idea
> > and need.
>
> Could you please suggest wording for this point?

I don't have an easy and succinct way to explain this, tbh. This is
not strictly necessary for understanding, so let's not add anything.

>
> >
> > > +
> > >  Understanding eBPF verifier messages
> > >  ====================================
> > >
> > > --
> > > 2.39.0
> > >
>
