Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2230681FD3
	for <lists+bpf@lfdr.de>; Tue, 31 Jan 2023 00:45:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbjA3Xph (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 30 Jan 2023 18:45:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjA3Xpg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 30 Jan 2023 18:45:36 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D1582B610
        for <bpf@vger.kernel.org>; Mon, 30 Jan 2023 15:45:34 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id iv8-20020a05600c548800b003db04a0a46bso573wmb.0
        for <bpf@vger.kernel.org>; Mon, 30 Jan 2023 15:45:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Kyjt9tDyysuiVBh7EjMXl10xvGRVtdwFpxY6cMFwJ0Y=;
        b=a3Q9ZvpJCZktzvYCVC1grk6enuC+EklbvCQB3PdDKaNasMQjOE5dqfFmae/AZUA+Jh
         vezDTW8m1P9ZRjAjftf5td5JABH/gNljcdMQ6GCsqkr9WlAliN/0TNs0xY8tWcbLGOkc
         5T5P1XgE3qPdCIskngxuJv7/D/lxF+p6pXCHPa51K8Xq4zcNEXTvLQ0CbVEH0dnXziCS
         i2jOtBArSmjTE8ajLYmcu8ES5VhTQ+gUgnwPHdGAm6s82g99rbty1IDzepOSnuepCiAc
         BoaPZAcTgMd4umWNZftni3bdCPxhAd6KikknEEjPrLOUxdxw80wJidvSkcRa1yWRsN6c
         II6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Kyjt9tDyysuiVBh7EjMXl10xvGRVtdwFpxY6cMFwJ0Y=;
        b=0I9Jt2ThZ5+9DI0PlTjBIVe/1gDwtg3HS4bjIHdV01i1YMh6XPyN1ISCm5V5B5BFu1
         Dv+o6Rw654cZFDnxn+TnPBYebCWip5p8Pu97FOSeR7wRDbCFgOQ7hjCzbIl3Fk9bCfvS
         43HRlwin6E74SttftgB/1SU7hCft598hebihb4cs9mba89HMuInwmXsPnesfmeffrrlj
         a1BW61265tdFrIEnI4Ye8jJ0+7fNM2YzStU9C+bdX5vuLoltI2+EXZn2cfMoMwsPfbfb
         K+HbUopaA2Vrkd0MasTSETU8f1K9xyQkCzrUAOo++C9JbbRBX+iVZtO1LcNLeorFWzyd
         eCxw==
X-Gm-Message-State: AO0yUKXbbnWeoQNzKMF58tKUmIe6ZE+9L7VhRsr9jYJVUQUW5rgavusc
        XBzwDwQawPcTBjVJ9xP0dGM=
X-Google-Smtp-Source: AK7set+8vHPcXYik4rWtDiSxy1hVomg2ERW1EqmWmG6NIQ4xRuLShR3ioKWTOKkCRoNjBAb5gctJsQ==
X-Received: by 2002:a05:600c:2112:b0:3dc:4548:abe6 with SMTP id u18-20020a05600c211200b003dc4548abe6mr10440164wml.12.1675122332391;
        Mon, 30 Jan 2023 15:45:32 -0800 (PST)
Received: from [192.168.1.113] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id p12-20020a05600c430c00b003dc492e4430sm8562812wme.28.2023.01.30.15.45.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 15:45:31 -0800 (PST)
Message-ID: <d8a6ac211053c27463c87beeaa74ee511d3ca796.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 1/1] docs/bpf: Add description of register
 liveness tracking algorithm
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     David Vernet <void@manifault.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com,
        yhs@fb.com
Date:   Tue, 31 Jan 2023 01:45:29 +0200
In-Reply-To: <Y9ghp6G8KiG6fO2a@maniforge>
References: <20230130182400.630997-1-eddyz87@gmail.com>
         <20230130182400.630997-2-eddyz87@gmail.com> <Y9ghp6G8KiG6fO2a@maniforge>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 2023-01-30 at 13:59 -0600, David Vernet wrote:
> On Mon, Jan 30, 2023 at 08:24:00PM +0200, Eduard Zingerman wrote:
> > This is a followup for [1], adds an overview for the register liveness
> > tracking, covers the following points:
> > - why register liveness tracking is useful;
> > - how register parentage chains are constructed;
> > - how liveness marks are applied using the parentage chains.
> >=20
> > [1] https://lore.kernel.org/bpf/CAADnVQKs2i1iuZ5SUGuJtxWVfGYR9kDgYKhq3r=
NV+kBLQCu7rA@mail.gmail.com/
> >=20
> > Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
>=20
> This is great, thanks a lot for writing this up. Left some comments.
>=20
> > ---
> >  Documentation/bpf/verifier.rst | 266 +++++++++++++++++++++++++++++++++
> >  1 file changed, 266 insertions(+)
> >=20
> > diff --git a/Documentation/bpf/verifier.rst b/Documentation/bpf/verifie=
r.rst
> > index 3afa548ec28c..7269933428e1 100644
> > --- a/Documentation/bpf/verifier.rst
> > +++ b/Documentation/bpf/verifier.rst
> > @@ -316,6 +316,272 @@ Pruning considers not only the registers but also=
 the stack (and any spilled
> >  registers it may hold).  They must all be safe for the branch to be pr=
uned.
> >  This is implemented in states_equal().
> > =20
> > +Some technical details about state pruning implementation could be fou=
nd below.

Hi David,

Thank you for commenting. I'll update the doc according to your
s/xxx/yyy/ suggestions, sorry for the amount of missing comas, etc.
Regarding some bigger points please see below.

> > +
> > +Register liveness tracking
> > +--------------------------
> > +
> > +In order to make state pruning effective liveness state is tracked for=
 each
>=20
> Could you please add a comma after "effective"? Will use shorthand
> s/xxx/yyy for future suggestions like this.
>=20
> > +register and stack slot. The basic idea is to identify which registers=
 or stack
> > +slots were used by children of the state to reach the program exit. Re=
gisters
>=20
> IMO the phrasing "used by children of the state" may be a bit confusing.
> What do you think about this?
>=20
> "The basic idea is to track which registers and stack slots are actually
> used during subseqeuent execution of the program, until program exit is
> reached."
>=20
> > +that were never used could be removed from the cached state thus makin=
g more
>=20
> s/Registers that were never/Registers and stack slots that were never
>=20
> > +states equivalent to a cached state. This could be illustrated by the =
following
> > +program::
> > +
> > +  0: call bpf_get_prandom_u32()
> > +  1: r1 =3D 0
> > +  2: if r0 =3D=3D 0 goto +1
> > +  3: r0 =3D 1
> > +  --- checkpoint ---
> > +  4: r0 =3D r1
> > +  5: exit
> > +
> > +Suppose that state cache entry is created at instruction #4 (such entr=
ies are
> > +also called "checkpoints" in the text below), verifier reaches this in=
struction
> > +in two states:
>=20
> Can we split these into two sentences? Wdyt about the following:
>=20
> "Suppose that a state cache entry is created at instruction #4 (such
> entries are also called "checkpoints" in the text below). The verifier
> could reach the instruction with one of two possible register states:"
>=20
> > +
> > +* r0 =3D 1, r1 =3D 0
> > +* r0 =3D 0, r1 =3D 0
> > +
> > +However, only the value of register ``r1`` is important to successfull=
y finish
> > +verification. The goal of liveness tracking algorithm is to spot this =
fact and
>=20
> s/ of liveness tracking/of the liveness tracking
>=20
> > +figure out that both states are actually equivalent.
> > +
> > +Data structures
> > +~~~~~~~~~~~~~~~
> > +
> > +Liveness is tracked using the following data structures::
> > +
> > +  enum bpf_reg_liveness {
> > +	REG_LIVE_NONE =3D 0,
> > +	REG_LIVE_READ32 =3D 0x1,
> > +	REG_LIVE_READ64 =3D 0x2,
> > +	REG_LIVE_READ =3D REG_LIVE_READ32 | REG_LIVE_READ64,
> > +	REG_LIVE_WRITTEN =3D 0x4,
> > +	REG_LIVE_DONE =3D 0x8,
> > +  };
>=20
> FYI, you have the option of using the .. kernel-doc:: directive here, as
> in e.g.:
>=20
> .. kernel-doc:: include/linux/bpf_verifier.h
>   :identifiers: bpf_reg_liveness
>=20
> For enum bpf_reg_liveness and the other types. Doing so would require
> you updating the kernel-doc header comment in
> include/linux/bpf_verifier.h to reflect the description in [0], i.e.
> something like this for enum bpf_reg_liveness:
>=20
> [0]: https://docs.kernel.org/doc-guide/kernel-doc.html#structure-union-an=
d-enumeration-documentation
>=20
> /**
>  * enum bpf_reg_liveness - Liveness marks, used for registers and spilled=
-regs
>  * @REG_LIVE_NONE: reg hasn't been read or written this branch
>  * @REG_LIVE_READ32: reg was read, so we're sensitive to initial value
>  * @REG_LIVE_READ64: likewise, but full 64-bit content matters
>  * @REG_LIVE_READ: An OR of both 32 and 64 bit read reg states.
>  * @REG_LIVE_WRITTEN: reg was written first, screening off later reads
>  * @REG_LIVE_DONE: liveness won't be updating this register anymore
>  *
>  * Read marks propagate upwards until they find a write mark; they record=
 that
>  * "one of this state's descendants read this reg" (and therefore the reg=
 is
>  * relevant for states_equal() checks).
>  * Write marks collect downwards and do not propagate; they record that "=
the
>  * straight-line code that reached this state (from its parent) wrote thi=
s reg"
>  * (and therefore that reads propagated from this state or its descendant=
s
>  * should not propagate to its parent).
>  * A state with a write mark can receive read marks; it just won't propag=
ate
>  * them to its parent, since the write mark is a property, not of the sta=
te,
>  * but of the link between it and its parent.  See mark_reg_read() and
>  * mark_stack_slot_read() in kernel/bpf/verifier.c.
>  */
>=20
> Not everyone likes how the rendered HTML looks, and I tend to agree that
> it looks pretty blocky, but it at least keeps all of this documentation
> in one place and avoids going stale. Also, it has the benefit of
> automatically creating a link to the ..kernel-doc:: comment anywhere
> that "enum bpf_reg_liveness" is written in the Documentation subtree.

Thank you for pointing to this capability. I'd like to stick to the
current variant because I don't need full definitions of struct
bpf_reg_state and others. The only complete definition I want to
describe is enum bpf_reg_liveness, for all others just want to show
the dependencies. I just tried mixing `.. kernel-doc::` for the enum,
and code block for the structs but it looks awkward in the final HTML.

>=20
> > +
> > +  struct bpf_reg_state {
> > + 	...
> > +	struct bpf_reg_state *parent;
> > + 	...
> > +	enum bpf_reg_liveness live;
> > + 	...
> > +  };
> > +
> > +  struct bpf_stack_state {
> > +	struct bpf_reg_state spilled_ptr;
> > +	...
> > +  };
> > +
> > +  struct bpf_func_state {
> > +	struct bpf_reg_state regs[MAX_BPF_REG];
> > +        ...
> > +	struct bpf_stack_state *stack;
> > +  }
> > + =20
> > +  struct bpf_verifier_state {
> > +	struct bpf_func_state *frame[MAX_CALL_FRAMES];
> > +	struct bpf_verifier_state *parent;
> > +        ...
> > +  }
> > +
> > +* ``REG_LIVE_NONE`` is an initial value assigned to ``->live`` fields =
upon new
> > +  verifier state creation;
> > +
> > +* ``REG_LIVE_WRITTEN`` means that the value of the register (or stack =
slot) is
> > +  defined by some instruction "executed" within verifier state;
> > +
> > +* ``REG_LIVE_READ{32,64}`` means that the value of the register (or st=
ack slot)
> > +  is read by some instruction "executed" within verifier state;
> > +
> > +* ``REG_LIVE_DONE`` is a marker used by ``clean_verifier_state()`` to =
avoid
> > +  processing same verifier state multiple times and for some sanity ch=
ecks;
> > +
> > +* ``->live`` field values are formed by combining ``enum bpf_reg_liven=
ess``
> > +  values using bitwise or.
> > +
> > +Register parentage chains
> > +~~~~~~~~~~~~~~~~~~~~~~~~~
> > + =20
> > +In order to propagate information between parent and child states regi=
ster
>=20
> Suggestion:
>=20
> s/parent and child states register parentage chain/
>   parent and child states, a *register parentage chain*
>=20
> > +parentage chain is established. Each register or stack slot is linked =
to a
> > +corresponding register or stack slot in it's parent state via a ``->pa=
rent``
>=20
> s/it's/its
>=20
> > +pointer. This link is established upon state creation in function
>=20
> suggestion: I think you can remove the word 'function'.
>=20
> > +``is_state_visited()`` and is never changed.
> > +
> > +The rules for correspondence between registers / stack slots are as fo=
llows:
> > +
> > +* For current stack frame registers and stack slots of the new state a=
re linked
> > +  to the registers and stack slots of the parent state with the same i=
ndices.
>=20
> s/For current stack frame registers/For the current stack frame,
> registers
>=20
> > +
> > +* For outer stack frames only caller saved registers (r6-r9) and stack=
 slots are
> > +  linked to the registers and stack slots of the parent state with the=
 same
> > +  indices.
>=20
> s/For the outer stack frames only/For the outer stack frames, only
>=20
> > +
> > +This could be illustrated by the following diagram (arrows stand for
> > +``->parent`` pointers)::
> > +
> > +      ...                    ; Frame #0, some instructions
> > +  --- checkpoint #0 ---
> > +  1 : r6 =3D 42                ; Frame #0
> > +  --- checkpoint #1 ---
> > +  2 : call foo()             ; Frame #0
> > +      ...                    ; Frame #1, instructions from foo()
> > +  --- checkpoint #2 ---
> > +      ...                    ; Frame #1, instructions from foo()
> > +  --- checkpoint #3 ---
> > +      exit                   ; Frame #1, return from foo()
> > +  3 : r1 =3D r6                ; Frame #0  <- current state
> > + =20
> > +             +--------------------------+--------------------------+=
=20
> > +             |         Frame #0         |         Frame #1         |
> > +  Checkpoint +--------------------------+--------------------------+
> > +  #0         | r0-r5 | r6-r9 | fp-8 ... |                          =
=20
> > +             +--------------------------+                          =
=20
> > +                ^       ^       ^
> > +                |       |       |         =20
> > +  Checkpoint +--------------------------+                          =
=20
> > +  #1         | r0-r5 | r6-r9 | fp-8 ... |
> > +             +--------------------------+
> > +                        ^       ^         nil     nil     nil=20
> > +                        |       |          |       |       |         =
=20
> > +  Checkpoint +--------------------------+--------------------------+
> > +  #2         | r0-r5 | r6-r9 | fp-8 ... | r0-r5 | r6-r9 | fp-8 ... |
> > +             +--------------------------+--------------------------+
> > +                        ^       ^          ^       ^       ^ =20
> > +                        |       |          |       |       |
> > +  Checkpoint +--------------------------+--------------------------+
> > +  #3         | r0-r5 | r6-r9 | fp-8 ... | r0-r5 | r6-r9 | fp-8 ... |
> > +             +--------------------------+--------------------------+
> > +                        ^       ^
> > +                        |       |         =20
> > +  Current    +--------------------------+                          =
=20
> > +  state      | r0-r5 | r6-r9 | fp-8 ... |                          =
=20
> > +             +--------------------------+
> > +                        \          =20
> > +                          r6 read mark is propagated via
> > +                          these links all the way up to
> > +                          checkpoint #1.
>=20
> IMO this illustration is kind of confusing as shown, relative to the
> descriptions of current / outer above. 'Frame #1' is potentially in a
> different function / subprog, correct? So it seems kind of confusing to
> see it propagating registers from checkpoint 3 -> checkpoint 2, etc. And
> it's propagating r0-r5. Similarly, it looks like 'Current state' isn't
> propagating r0-r5. I'm sure I'm misunderstanding something.
>=20

Good point. I reviewed the logic in __check_func_call() and it turns
out I missed the actions performed by:
- init_func_state() which cuts all parent links for the newly created
  callee state.
- set_callee_state() which copies r1-r5 from caller byte-to-byte
  (thus including parent link).
I'll update the description and diagram to reflect this.

> > +
> > +Liveness marks tracking
> > +~~~~~~~~~~~~~~~~~~~~~~~
> > +
> > +For each processed instruction verifier propagates information about r=
eads up
>=20
> s/processed instruction verifier/processed instruction, the verifier
>=20
> > +the parentage chain and saves information about writes in the current =
state.
> > +The information about reads is propagated by function ``mark_reg_read(=
)`` which
> > +could be summarized as follows::
> > +
> > +  mark_reg_read(struct bpf_reg_state *state):
> > +      parent =3D state->parent
> > +      while parent:
> > +          if parent->live & REG_LIVE_WRITTEN:
> > +              break
> > +          if parent->live & REG_LIVE_READ64:
> > +              break
> > +          parent->live |=3D REG_LIVE_READ64
> > +          state =3D parent
> > +          parent =3D state->parent
> > +
> > +Note: details about REG_LIVE_READ32 are omitted.
> > +
> > +Also note: the read marks are applied to the **parent** state while wr=
ite marks
> > +are applied to the **current** state.
> > +
> > +Because stack writes could have different sizes ``REG_LIVE_WRITTEN`` m=
arks are
> > +applied conservatively: stack slots are marked as written only if writ=
e size
> > +corresponds to the size of the register, e.g. see function ``save_regi=
ster_state()``.
> > +
> > +Consider the following example::
> > +
> > +  0: (*u64)(r10 - 8) =3D 0
> > +  --- checkpoint #0 ---
> > +  1: (*u32)(r10 - 8) =3D 1
> > +  2: r1 =3D (*u32)(r10 - 8)
> > +
> > +Because write size at instruction (1) is smaller than register size th=
e write
>=20
> s/write size/the write size
>=20
> also
>=20
> s/than register size the/than register size, the
>=20
> > +mark will not be added to fp-8 slot when (1) is verified, thus the fp-=
8 read at
> > +instruction (2) would propagate read mark for fp-8 up to checkpoint #0=
.
>=20
> s/is verified, thus/is verifier. Thus
>=20
> also
>=20
> s/would propagate read mark/would propagate the read mark
>=20
> In general, this sentence explains mechanically why the write won't
> propagate (the write size is smaller than the register size), but I
> think it would be useful to explain why sizeof(write) < sizeof(reg)
> implies that it won't be propagated.
>=20
> > +
> > +Once ``BPF_EXIT`` instruction is reached function ``update_branch_coun=
ts()`` is
>=20
> s/Once ``BPF_EXIT``/Once the ``BPF_EXIT``
>=20
> also
>=20
> s/is reached function/is reached,
>=20
> > +called to update the ``->branches`` counter for each verifier state in=
 a chain
> > +of parent verifier states. When ``->branches`` counter reaches zero th=
e verifier
>=20
> s/When ``->branches`` counter reaches zero/
>   When the ``branches`` counter reaches zero,
>=20
> > +state becomes a valid entry in a set of cached verifier states.
> > +
> > +Each entry of the verifier states cache is post-processed by a functio=
n
> > +``clean_live_states()``. This function marks all registers and stack s=
lots
> > +without ``REG_LIVE_READ{32,64}`` marks as ``NOT_INIT`` or ``STACK_INVA=
LID``.
> > +Registers/stack slots marked in this way are ignored in function ``sta=
cksafe()``
> > +called from ``states_equal()`` when state cache entry is considered fo=
r
>=20
> s/when state cache entry/when a state cache entry
>=20
> > +equivalence with a current state.
> > +
> > +Now it is possible to explain how the example from the beginning of th=
e section
> > +works::
> > +
> > +  0: call bpf_get_prandom_u32()
> > +  1: r1 =3D 0
> > +  2: if r0 =3D=3D 0 goto +1
> > +  3: r0 =3D 1
> > +  --- checkpoint[0] ---
> > +  4: r0 =3D r1
> > +  5: exit
> > +
> > +* At instruction #2 branching point is reached and state ``{ r0 =3D=3D=
 0, r1 =3D=3D 0, pc =3D=3D 4 }``
> > +  is pushed to states processing queue (pc stands for program counter)=
.
> > + =20
> > +* At instruction #4:
> > + =20
> > +  * ``checkpoint[0]`` states cache entry is created: ``{ r0 =3D=3D 1, =
r1 =3D=3D 0, pc =3D=3D 4 }``;
> > +  * ``checkpoint[0].r0`` is marked as written;
> > +  * ``checkpoint[0].r1`` is marked as read;
> > +
> > +* At instruction #5 exit is reached and ``checkpoint[0]`` can now be p=
rocessed
> > +  by ``clean_live_states()``, after this processing ``checkpoint[0].r0=
`` has a
>=20
> s/by ``clean_live_states()``, after/by ``clean_live_states()``. After
>=20
> > +  read mark and all other registers and stack slots are marked as ``NO=
T_INIT``
> > +  or ``STACK_INVALID``
> > + =20
> > +* The state ``{ r0 =3D=3D 0, r1 =3D=3D 0, pc =3D=3D 4 }`` is popped fr=
om the states queue
> > +  and is compared against a cached state ``{ r1 =3D=3D 0, pc =3D=3D 4 =
}``, the states
> > +  are considered equivalent.
> > +
> > +Read marks propagation for cache hits
> > +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > +
> > +Another important point is handling of read marks when a previously ve=
rified
>=20
> s/is handling of/is the handling of
>=20
> > +state is found in the states cache. All read marks present on register=
s and
> > +stack slots of the cached state must be propagated over the parentage =
chain of
> > +the current state. Function ``propagate_liveness()`` handles this case=
.
>=20
> Suggestion: Consider expanding the sentence to include why it's
> necessary to propagate like this. You explain below after the diagram,
> but it might be helpful to clarify here so the reader has some context
> when reading over the diagram.

Well, I figured that the diagram below is the simplest way to describe
why this logic is necessary. I'll try to come up with some condensed
description as you suggest.

>=20
> > +
> > +For example, consider the following state parentage chain (S is a
> > +starting state, A-E are derived states, -> arrows show which state is
> > +derived from which)::
> > +
> > +                      r1 read
> > +               <-------------                    A[r1] =3D=3D 0
> > +                    +---+                        C[r1] =3D=3D 0
> > +      S ---> A ---> | B | ---> exit              E[r1] =3D=3D 1
> > +      |             |   |
> > +      ` ---> C ---> | D |
> > +      |             +---+
> > +      ` ---> E       =20
> > +                      ^
> > +             ^        |___   suppose all these
> > +             |             states are at insn #Y
> > +      suppose all these
> > +    states are at insn #X
> > +
> > +* Chain of states ``S -> A -> B -> exit`` is verified first.
> > +
> > +* While ``B -> exit`` is verified, register ``r1`` is read and this re=
ad mark is
> > +  propagated up to state ``A``.
> > +
> > +* When chain of states ``C -> D`` is verified the state ``D`` turns ou=
t to be
> > +  equivalent to state ``B``.
> > +
> > +* The read mark for ``r1`` has to be propagated to state ``C``, otherw=
ise state
> > +  ``C`` might get mistakenly marked as equivalent to state ``E`` even =
though
> > +  values for register ``r1`` differ between ``C`` and ``E``.
> > +
> >  Understanding eBPF verifier messages
> >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > =20
> > --=20
> > 2.39.0
> >=20

