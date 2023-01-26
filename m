Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B39767D7C7
	for <lists+bpf@lfdr.de>; Thu, 26 Jan 2023 22:34:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbjAZVe0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 26 Jan 2023 16:34:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjAZVe0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 26 Jan 2023 16:34:26 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0235513E
        for <bpf@vger.kernel.org>; Thu, 26 Jan 2023 13:34:24 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id bk16so3211440wrb.11
        for <bpf@vger.kernel.org>; Thu, 26 Jan 2023 13:34:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JuvWYWRiPrJZbifq7VQlwUtGGdqO4Hu5F8s0d2hKhmI=;
        b=JOcfsU+JHt0DJFprxpkpkJexDuWep3wV4dl1A5x1x/qoo3JM9Y9k8P96rxkxprmEAd
         4Gx4+3Bv+4XiPkuQCYyr0lsKh9bYCFmZpYp89jGI56a6hHLX1tUip0980bC3ef3Zndjm
         Jd/VTw5Vf2eSTK9JWV4CIBAawKyiY3EoHCrQNl+QHhsGTqGhD9ppt772reWCgbf/UA87
         Y7xTHhMRpPVs5yyHE7lIivbCo7S7v9kBOic4BnD2P/CL49iDSY1AlMQxU/TXhdtqNCVx
         UpWR/YoAFX1xzn5Dkwma0dUqrx6dB0opcp9WLrhtHxLWA2zULumlAe/6AoPlKhYQH8PM
         64wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JuvWYWRiPrJZbifq7VQlwUtGGdqO4Hu5F8s0d2hKhmI=;
        b=EoMXGAGOI3SunS70Zb05lVm1VDLuWaSBnR715LjBQA4hPScuBmJ6BZtFy+rStkyAV0
         c+dz1ZjaFRIFHrvGCskMEHSGtntjQxeRct/c4Y2LcGxVn93s2vCagOdot1UIcu3aWb8I
         uhPryB99CjhTLcddu/kOuvg30LHr7iCzumbDjEyIiJ/RUQw0RDNWtIPGB68GxbSVitZu
         3H8bJ10TKShOpogSIXDQh6PneSdr8AA0hc/AtVra1H/tIoax0EN5rrJjoLHyfPptm9DK
         G2VHaeZO80Ex+jwrDRU6uJtSATCE5nnLOTZRXdUCZxRswMpYfNUshxyTqWI8BqmWDeeU
         hOYw==
X-Gm-Message-State: AO0yUKXErfFVia6007XCMESPgS8So8ijzkIQW9L+EF3uKd7xwO9cgyL/
        seg5GVX3pGTcIgrqCm3yjbs=
X-Google-Smtp-Source: AK7set/E4xwANjkJz1GY9Lm1bliZKpoINhni5y2/rQhQvjOw6iSMjORSqs0YrkD8je0NCCo5VSItMA==
X-Received: by 2002:adf:f7c3:0:b0:2bf:c84f:9ed7 with SMTP id a3-20020adff7c3000000b002bfc84f9ed7mr2624533wrq.60.1674768862289;
        Thu, 26 Jan 2023 13:34:22 -0800 (PST)
Received: from [192.168.1.113] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id k4-20020a5d4284000000b00241fde8fe04sm2328265wrq.7.2023.01.26.13.34.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 13:34:21 -0800 (PST)
Message-ID: <af4bf15425d63629c64cbcd08536755f99e7d55a.camel@gmail.com>
Subject: Re: [RFC bpf-next] docs/bpf: Add description of register liveness
 tracking algorithm
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com, yhs@fb.com
Date:   Thu, 26 Jan 2023 23:34:20 +0200
In-Reply-To: <CAEf4Bzahu+gnRqFWenzkHAAbnTTTg18e2LMOvYg-+bqj3+-b4Q@mail.gmail.com>
References: <20230124220343.2942203-1-eddyz87@gmail.com>
         <CAEf4Bzahu+gnRqFWenzkHAAbnTTTg18e2LMOvYg-+bqj3+-b4Q@mail.gmail.com>
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

On Thu, 2023-01-26 at 11:50 -0800, Andrii Nakryiko wrote:
> On Tue, Jan 24, 2023 at 2:04 PM Eduard Zingerman <eddyz87@gmail.com> wrot=
e:
> >=20
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
> > ---
> >  Documentation/bpf/verifier.rst | 237 +++++++++++++++++++++++++++++++++
> >  1 file changed, 237 insertions(+)
> >=20
> > diff --git a/Documentation/bpf/verifier.rst b/Documentation/bpf/verifie=
r.rst
> > index d4326caf01f9..77578ed5a277 100644
> > --- a/Documentation/bpf/verifier.rst
> > +++ b/Documentation/bpf/verifier.rst
> > @@ -316,6 +316,243 @@ Pruning considers not only the registers but also=
 the stack (and any spilled
> >  registers it may hold).  They must all be safe for the branch to be pr=
uned.
> >  This is implemented in states_equal().
> >=20
> > +Some technical details about state pruning implementation could be fou=
nd below.
> > +
> > +Register liveness tracking
> > +--------------------------
> > +
> > +In order to make state pruning effective liveness state is tracked for=
 each
> > +register and stack spill slot. The basic idea is to identify which reg=
isters or
>=20
> not just spill slot, right? Any stack slot (including scalars)

Yes, I'll update the wording to be "stack slot".

>=20
> > +stack slots were used by children of the state to reach the program ex=
it.
> > +Registers that were never used could be removed from the cached state =
thus
> > +making more states equivalent to a cached state. This could be illustr=
ated by
> > +the following program::
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
> > +* r0 =3D 1, r1 =3D 0
> > +* r0 =3D 0, r1 =3D 0
> > +
> > +However, only the value of register ``r1`` is important to successfull=
y finish
> > +verification. The goal of liveness tracking algorithm is to spot this =
fact and
> > +figure out that both states are actually equivalent.
> > +
> > +Data structures
> > +~~~~~~~~~~~~~~~
> > +
> > +Liveness is tracked using the following data structures::
> > +
> > +  enum bpf_reg_liveness {
> > +       REG_LIVE_NONE =3D 0,
> > +       REG_LIVE_READ32 =3D 0x1,
> > +       REG_LIVE_READ64 =3D 0x2,
> > +       REG_LIVE_READ =3D REG_LIVE_READ32 | REG_LIVE_READ64,
> > +       REG_LIVE_WRITTEN =3D 0x4,
> > +       REG_LIVE_DONE =3D 0x8,
> > +  };
> > +
> > +  struct bpf_reg_state {
> > +       ...
> > +       struct bpf_reg_state *parent;
> > +       ...
> > +       enum bpf_reg_liveness live;
> > +       ...
> > +  };
> > +
> > +  struct bpf_stack_state {
> > +       struct bpf_reg_state spilled_ptr;
> > +       ...
> > +  };
> > +
> > +  struct bpf_func_state {
> > +       struct bpf_reg_state regs[MAX_BPF_REG];
> > +        ...
> > +       struct bpf_stack_state *stack;
> > +  }
> > +
> > +  struct bpf_verifier_state {
> > +       struct bpf_func_state *frame[MAX_CALL_FRAMES];
> > +       struct bpf_verifier_state *parent;
> > +        ...
> > +  }
> > +
> > +* ``REG_LIVE_NONE`` is an initial value assigned to ``->live`` fields =
upon new
> > +  verifier state creation;
> > +* ``REG_LIVE_WRITTEN`` means that the value of the register (or spill =
slot) is
> > +  defined by some instruction "executed" within verifier state;
> > +* ``REG_LIVE_READ{32,64}`` means that the value of the register (or sp=
ill slot)
>=20
> ditto, "stack slot" is more generic and correct?
>=20
> > +  is read by some instruction "executed" within verifier state;
> > +* ``REG_LIVE_DONE`` is a marker used by ``clean_verifier_state()`` to =
avoid
> > +  processing same verifier state multiple times and for some sanity ch=
ecks;
> > +* ``->live`` field values are formed by combining ``enum bpf_reg_liven=
ess``
> > +  values using bitwise or.
> > +
> > +Register parent chains
> > +~~~~~~~~~~~~~~~~~~~~~~
> > +
> > +In order to propagate information between parent and child states regi=
ster
> > +parentage chain is established. Each register or spilled stack slot is=
 linked to
> > +a corresponding register or stack spill slot in it's parent state via =
a
> > +``->parent`` pointer. This link is established upon state creation in =
function
> > +``is_state_visited()`` and is never changed.
> > +
> > +The rules for correspondence between registers / stack spill slots are=
 as
> > +follows:
> > +
> > +* For current stack frame registers and stack spill slots of the new s=
tate are
> > +  linked to the registers and stack spill slots of the parent state wi=
th the
> > +  same indices.
> > +
> > +* For outer stack frames only caller saved registers (r6-r9) and stack=
 spill
> > +  slots are linked to the registers and stack spill slots of the paren=
t state
> > +  with the same indices.
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
> > +
> > +             +--------------------------+--------------------------+
> > +             |         Frame #0         |         Frame #1         |
> > +  Checkpoint +--------------------------+--------------------------+
> > +  #0         | r0-r5 | r6-r9 | fp-8 ... |
> > +             +--------------------------+
> > +                ^       ^       ^
> > +                |       |       |
> > +  Checkpoint +--------------------------+
> > +  #1         | r0-r5 | r6-r9 | fp-8 ... |
> > +             +--------------------------+
> > +                        ^       ^
> > +                        |       |
> > +  Checkpoint +--------------------------+--------------------------+
> > +  #2         | r0-r5 | r6-r9 | fp-8 ... | r0-r5 | r6-r9 | fp-8 ... |
> > +             +--------------------------+--------------------------+
>=20
> wouldn't r6-r9 in frame #1 point to r6-r9 of frame #0 in parent state?
> Or do they point to r6-r9 of frame #0 in the same checkpoint? Either
> way, should we clarify that part on the diagram somehow?

This is the loop at the end of is_state_visited() that sets up the
register links (initially the links are zero because of the kzalloc()
call used for memory allocation):

	cur->parent =3D new;
        ...
	for (j =3D 0; j <=3D cur->curframe; j++) {
		for (i =3D j < cur->curframe ? BPF_REG_6 : 0; i < BPF_REG_FP; i++)
			cur->frame[j]->regs[i].parent =3D &new->frame[j]->regs[i];
                ...
	}
       =20
The `new` refers to `struct bpf_verifier_state` instance that would
remain in cache, the `cur` refers to the state that would be used to
continue verification.

Note that all links in this loop are setup only for identical indices,
so registers from frame #1 can't point to registers from frame #0.

As far as I understand the following happens (please correct me if I'm wron=
g):
- when checkpoint #1 is created from the state derived from
  checkpoint #0, the cur->curframe is 0;
- when `call foo` is processed a new instance of `struct bpf_func_state`
  is allocated to represent frame #1, all parent pointers within this
  instance are set to null (see call `kzalloc(*callee)` in __check_func_cal=
l());
- checkpoint #2 is derived from a state described above, thus frame #1
  r0-r9 parent links are null.

I'll add a note on the diagram that the links are null.


>=20
> > +                        ^       ^          ^       ^      ^
> > +                        |       |          |       |      |
> > +  Checkpoint +--------------------------+--------------------------+
> > +  #3         | r0-r5 | r6-r9 | fp-8 ... | r0-r5 | r6-r9 | fp-8 ... |
> > +             +--------------------------+--------------------------+
> > +                        ^       ^
> > +                        |       |
> > +  Current    +--------------------------+
> > +  state      | r0-r5 | r6-r9 | fp-8 ... |
> > +             +--------------------------+
> > +                        \
> > +                          r6 read mark is propagated via
> > +                          these links all the way up to
> > +                          checkpoint #1.
> > +
> > +Liveness marks tracking
> > +~~~~~~~~~~~~~~~~~~~~~~~
> > +
> > +For each processed instruction verifier propagates information about r=
eads up
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
> > +Also note: the read marks are applied to the *parent* state while writ=
e marks
> > +are applied to the *current* state.
> > +
> > +Because stack writes could have different sizes ``REG_LIVE_WRITTEN`` m=
arks are
> > +applied conservatively: stack spills are marked as written only if wri=
te size
> > +corresponds to the size of the register, see function ``save_register_=
state()``
> > +for an example.
>=20
> so this paragraph mentions a very subtle interaction for stack slots
> that only get partial register spill and keep other bytes as
> STACK_MISC. I don't know how much into details we should go her, but
> maybe calling out explicitly that this has implications when we mix
> register spill and scalar data in a single 8-byte stack slot would be
> useful?

I can add the following text:

--- 8< -----------------------------

Consider the following example::

  0: (*u64)(r10 - 8) =3D 0
  --- checkpoint #0 ---
  1: (*u32)(r10 - 8) =3D 1
  2: r1 =3D (*u32)(r10 - 8)

Because write size at instruction (1) is smaller than register size
the write mark will not be added to fp-8 slot when (1) is verified,
thus the fp-8 read at instruction (2) would propagate read mark for
fp-8 up to checkpoint #0.

----------------------------- >8 ---

wdyt?

>=20
> > +
> > +Once ``BPF_EXIT`` instruction is reached function ``update_branch_coun=
ts()`` is
> > +called to update the ``->branches`` counter for each verifier state in=
 a chain
> > +of parent verifier states. When ``->branches`` counter reaches zero th=
e verifier
> > +state becomes a valid entry in a set of cached verifier states.
> > +
> > +Each entry of the verifier states cache is post-processed by a functio=
n
> > +``clean_live_states()``. This function marks all registers and stack s=
pills
> > +without ``REG_LIVE_READ{32,64}`` marks as ``NOT_INIT`` or ``STACK_INVA=
LID``.
> > +Registers/stack spills marked in this way are ignored in function ``st=
acksafe()``
> > +called from ``states_equal()`` when state cache entry is considered fo=
r
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
> > +* At instruction #4:
> > +
> > +  * ``checkpoint[0]`` states cache entry is created: ``{ r0 =3D=3D 1, =
r1 =3D=3D 0, pc =3D=3D 4 }``;
> > +  * ``checkpoint[0].r0`` is marked as written;
> > +  * ``checkpoint[0].r1`` is marked as read;
> > +
> > +* At instruction #5 exit is reached and ``checkpoint[0]`` can now be p=
rocessed
> > +  by ``clean_live_states()``, after this processing ``checkpoint[0].r0=
`` has a
> > +  read mark and all other registers and stack spills are marked as ``N=
OT_INIT``
> > +  or ``STACK_INVALID``
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
> > +state is found in the states cache. All read marks present on register=
s and
> > +stack spills of the cached state must be propagated over the parentage=
 chain of
> > +the current state. Function ``propagate_liveness()`` handles this case=
.
> > +
> > +For example, consider the following state parentage chain::
> > +
> > +          +---+
> > +   A ---> | B | ---> exit
> > +          |   |
> > +   C ---> | D |
> > +          +---+
> > +
> > +* Chain ``A -> B -> exit`` is verified first;
> > +* State ``B`` has read marks for registers ``r1`` and ``r2``;
> > +* State ``D`` is considered equivalent to state ``B``;
> > +
> > +* Read marks for ``r1`` and ``r2`` have to be added in state ``C``, ot=
herwise
> > +  state ``C`` might get mistakenly marked as equivalent to some future=
 state
> > +  ``E`` with different values for registers in question.
>=20
> So I'm a bit confused by this section. We are talking about read marks
> in B and D, and then imply that C has to get it as well, but we don't
> mention what happens in A. The implication here is probably that read
> marks that were bubbled up into A should be bubbled up into C, right?
> But that's not very obvious? Could there be cases where read marks in
> B are screened in A and never make into it? In that case similar thing
> will presumably happen for C?

I agree it might be confusing, what about the following text instead:

--- 8< -----------------------------

For example, consider the following state parentage chain (S is a
starting state, A-E are derived states, -> arrows show which state is
derived from which)::

                      r1 read
               <-------------                    A[r1] =3D=3D 0
                    +---+                        C[r1] =3D=3D 0
      S ---> A ---> | B | ---> exit              E[r1] =3D=3D 1
      |             |   |
      ` ---> C ---> | D |
      |             +---+
      ` ---> E       =20
                      ^
             ^        |___   suppose all these
             |             states are at insn #Y
      suppose all these
    states are at insn #X

* Chain of states ``S -> A -> B -> exit`` is verified first.

* While ``B -> exit`` is verified register ``r1`` is read and this
  read mark is propagated up to state ``A``.

* When chain of states ``C -> D`` is verified the state ``D`` turns
  out to be equivalent to state ``B``.

* The read mark for ``r1`` has to be propagated to state ``C``,
  otherwise state ``C`` might get mistakenly marked as equivalent to
  state ``E`` even though values for register ``r1`` differ between
  ``C`` and ``E``.

----------------------------- >8 ---

The reason I don't want to put an example program here is that example
programs I can come up with are even more confusing than explanation above.

> I'd also call out conceptual similarity of this after the fact
> propagation of liveness marks to precision marks. It's the same idea
> and need.

Could you please suggest wording for this point?

>=20
> > +
> >  Understanding eBPF verifier messages
> >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >=20
> > --
> > 2.39.0
> >=20

