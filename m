Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4339663E6F8
	for <lists+bpf@lfdr.de>; Thu,  1 Dec 2022 02:14:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbiLABOR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 30 Nov 2022 20:14:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiLABOP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 30 Nov 2022 20:14:15 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DBEA97039
        for <bpf@vger.kernel.org>; Wed, 30 Nov 2022 17:14:14 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id n20so795587ejh.0
        for <bpf@vger.kernel.org>; Wed, 30 Nov 2022 17:14:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=j+bq1BjmJM7IeUtHEwWA1vgtVxS30D5p9FrGwDGzzJ4=;
        b=CQlJoGY9fNw9YwWJqh3KhZcO+NJ4uaL5cl5ABxfHEg0H/ihkEEMzQdfPAgeGV8ALpx
         nH23H9bF7aBX3IWhZGtRhwT/rse8iQ7DDNDkO/0WGR/S5qnKZz0PDhXnsM4A57aNuUo1
         L4YHYrfqkOWQw+mKgcP+dsCBFdqM9StyZs6uNnhGccKvg9ajuVfKZ+msYFpvHcDfXERp
         yTN4lqE9sHNyMEJ2hMgvA1dRnHlnLwlxAsQEOWSltxYnY3yBy4niKfSKrtsm141/9u+4
         kp1wp1O/I6GbHuJgoLlnilaOxwxzeASW92UM2h+nYxI8Zl1Cg0TdFMQKGyVMeSuUa56F
         QXzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j+bq1BjmJM7IeUtHEwWA1vgtVxS30D5p9FrGwDGzzJ4=;
        b=fOsUjAP1Uc2iWyCcswpWOK8i1eMBFUnjzIglAOrp5l7TdazSG1DGV+ZV+jOe2HGBFS
         aPpMWqTlc8IPJEU48T396j2CR5OcACvrf5RZvUFhJVhtGJKY6eSsGnZmCo3K8f38aR6H
         4DHSpK0ZkT4Lgte+pFM0cDAPGPs+5TNQrcycj4VIKwlytBRey2zJiT5FcTIMaQl1IEyb
         llP4ZnwOtypfCdLGxW+aMfpP4JLqjHEn6+tm347ug3bdA12uU7CoQGt+9uKPg/l8wgTA
         oRUlmDtFAVNUCad+twvX165V9qMo5YRIsztBLMsrje6UdFV3LXZFw0IZ+guoiQX8k9di
         e/1w==
X-Gm-Message-State: ANoB5pkjgRh2zX07dzSfpvfC+G+YXzSvJ3qldLOYPH3nrWpdOfq+BUzP
        C7lX37OxEhMzDSBJAHfm0Ro=
X-Google-Smtp-Source: AA0mqf5ZMqTjJfj9gzfnBbN44k+Vnzb3yViyEcgOeO8ovw7TL8T7Q04PGMoRDRsu/tcG74aQkK8wJQ==
X-Received: by 2002:a17:907:d412:b0:7bc:68cc:7913 with SMTP id vi18-20020a170907d41200b007bc68cc7913mr25721458ejc.589.1669857252518;
        Wed, 30 Nov 2022 17:14:12 -0800 (PST)
Received: from [192.168.1.113] (boundsly.muster.volia.net. [93.72.16.93])
        by smtp.gmail.com with ESMTPSA id 7-20020a170906318700b007c0aefd9339sm164122ejy.175.2022.11.30.17.14.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 17:14:12 -0800 (PST)
Message-ID: <859d531ef1e2b4dab103d316e6f109958f3f1bad.camel@gmail.com>
Subject: Re: [RFC bpf-next 1/2] bpf: verify scalar ids mapping in regsafe()
 using check_ids()
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com, yhs@fb.com
Date:   Thu, 01 Dec 2022 03:14:11 +0200
In-Reply-To: <CAEf4BzZBYQ2EXH4Rj8kmTFb08SkRpnpesjpj6X-AKAtsJnuV6g@mail.gmail.com>
References: <20221128163442.280187-1-eddyz87@gmail.com>
         <20221128163442.280187-2-eddyz87@gmail.com>
         <CAEf4BzZBYQ2EXH4Rj8kmTFb08SkRpnpesjpj6X-AKAtsJnuV6g@mail.gmail.com>
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

On Wed, 2022-11-30 at 16:26 -0800, Andrii Nakryiko wrote:
> On Mon, Nov 28, 2022 at 8:35 AM Eduard Zingerman <eddyz87@gmail.com> wrot=
e:
> >=20
> > Prior to this commit the following unsafe example passed verification:
> >=20
> > 1: r9 =3D ... some pointer with range X ...
> > 2: r6 =3D ... unbound scalar ID=3Da ...
> > 3: r7 =3D ... unbound scalar ID=3Db ...
> > 4: if (r6 > r7) goto +1
> > 5: r6 =3D r7
> > 6: if (r6 > X) goto ...   ; <-- suppose checkpoint state is created her=
e
> > 7: r9 +=3D r7
> > 8: *(u64 *)r9 =3D Y
> >=20
> > This example is unsafe because not all execution paths verify r7 range.
> > Because of the jump at (4) the verifier would arrive at (6) in two stat=
es:
> > I.  r6{.id=3Db}, r7{.id=3Db} via path 1-6;
> > II. r6{.id=3Da}, r7{.id=3Db} via path 1-4, 6.
> >=20
> > Currently regsafe() does not call check_ids() for scalar registers,
> > thus from POV of regsafe() states (I) and (II) are identical. If the
> > path 1-6 is taken by verifier first and checkpoint is created at (6)
> > the path 1-4, 6 would be considered safe.
> >=20
> > This commit makes the following changes:
> > - a call to check_ids() is added in regsafe() for scalar registers case=
;
> > - a function mark_equal_scalars_as_read() is added to ensure that
> >   registers with identical IDs are preserved in the checkpoint states
> >   in case when find_equal_scalars() updates register range for several
> >   registers sharing the same ID.
> >=20
>=20
> Fixes tag missing?
>=20
> These are tricky changes with subtle details. Let's split check_ids()
> change and all the liveness manipulations into separate patches? They
> are conceptually completely independent, right?
>=20
>=20
> > Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> > ---
> >  kernel/bpf/verifier.c | 87 ++++++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 85 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 6599d25dae38..8a5b7192514a 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -10638,10 +10638,12 @@ static int check_alu_op(struct bpf_verifier_e=
nv *env, struct bpf_insn *insn)
> >                                 /* case: R1 =3D R2
> >                                  * copy register state to dest reg
> >                                  */
> > -                               if (src_reg->type =3D=3D SCALAR_VALUE &=
& !src_reg->id)
> > +                               if (src_reg->type =3D=3D SCALAR_VALUE &=
& !src_reg->id &&
> > +                                   !tnum_is_const(src_reg->var_off))
> >                                         /* Assign src and dst registers=
 the same ID
> >                                          * that will be used by find_eq=
ual_scalars()
> >                                          * to propagate min/max range.
> > +                                        * Skip constants to avoid allo=
cation of useless ID.
> >                                          */
> >                                         src_reg->id =3D ++env->id_gen;
> >                                 *dst_reg =3D *src_reg;
> > @@ -11446,16 +11448,86 @@ static bool try_match_pkt_pointers(const stru=
ct bpf_insn *insn,
> >         return true;
> >  }
> >=20
> > +/* Scalar ID generation in check_alu_op() and logic of
> > + * find_equal_scalars() make the following pattern possible:
> > + *
> > + * 1: r9 =3D ... some pointer with range X ...
> > + * 2: r6 =3D ... unbound scalar ID=3Da ...
> > + * 3: r7 =3D ... unbound scalar ID=3Db ...
> > + * 4: if (r6 > r7) goto +1
> > + * 5: r6 =3D r7
> > + * 6: if (r6 > X) goto ...   ; <-- suppose checkpoint state is created=
 here
> > + * 7: r9 +=3D r7
> > + * 8: *(u64 *)r9 =3D Y
> > + *
> > + * Because of the jump at (4) the verifier would arrive at (6) in two =
states:
> > + * I.  r6{.id=3Db}, r7{.id=3Db}
> > + * II. r6{.id=3Da}, r7{.id=3Db}
> > + *
> > + * Relevant facts:
> > + * - regsafe() matches ID mappings for scalars using check_ids(), this=
 makes
> > + *   states (I) and (II) non-equal;
> > + * - clean_func_state() removes registers not marked as REG_LIVE_READ =
from
> > + *   checkpoint states;
> > + * - mark_reg_read() modifies reg->live for reg->parent (and it's pare=
nts);
> > + * - when r6 =3D r7 is process the bpf_reg_state is copied in full, me=
aning
> > + *   that parent pointers are copied as well.
>=20
> not too familiar with liveness handling, but is this correct and
> expected? Should this be fixed instead of REG_LIVE_READ manipulations?

Well, that's what I wanted to ask, actually :)
Here is how current logic works:
- is_state_visited() has the following two loops in the end:

	for (j =3D 0; j <=3D cur->curframe; j++) {
		for (i =3D j < cur->curframe ? BPF_REG_6 : 0; i < BPF_REG_FP; i++)
			cur->frame[j]->regs[i].parent =3D &new->frame[j]->regs[i];
		for (i =3D 0; i < BPF_REG_FP; i++)
			cur->frame[j]->regs[i].live =3D REG_LIVE_NONE;
	}

	/* all stack frames are accessible from callee, clear them all */
	for (j =3D 0; j <=3D cur->curframe; j++) {
		struct bpf_func_state *frame =3D cur->frame[j];
		struct bpf_func_state *newframe =3D new->frame[j];

		for (i =3D 0; i < frame->allocated_stack / BPF_REG_SIZE; i++) {
			frame->stack[i].spilled_ptr.live =3D REG_LIVE_NONE;
			frame->stack[i].spilled_ptr.parent =3D
						&newframe->stack[i].spilled_ptr;
		}
	}

  These connect the bpf_reg_state members of the new state with
  corresponding (index-wise) members of the parent state.
- find_equal_scalars() looks as follows:
  static void find_equal_scalars(struct bpf_verifier_state *vstate,
                               struct bpf_reg_state *known_reg)
  {
	struct bpf_func_state *state;
	struct bpf_reg_state *reg;

	bpf_for_each_reg_in_vstate(vstate, state, reg, ({
		if (reg->type =3D=3D SCALAR_VALUE && reg->id =3D=3D known_reg->id)
			*reg =3D *known_reg;  // <--- full copy, incl. parent pointer
	}));
  }
- mark_reg_read() updates the ->live field of the *parent* register
  when called only if ->live field of the *current* register is not
  marked as written.
- in case if register is overwritten it's ->live field is marked as
  written, e.g. see check_stack_read_fixed_off().
 =20
Suppose we have an example:

---- checkpoint ----
r1 =3D r0               ; now r1.parent =3D=3D &checkpoint->regs[0]
r2 =3D r1               ; now r2.parent =3D=3D &checkpoint->regs[0]
if (r1 =3D=3D 0) goto +42
...

Given the above logic only &checkpoint->regs[0] would receive read
marks. Although I'm not the original author but this behavior seem to
make sense.

>=20
> > + *
> > + * Thus, for execution path 1-6:
> > + * - both r6->parent and r7->parent point to the same register in the =
parent state (r7);
> > + * - only *one* register in the checkpoint state would receive REG_LIV=
E_READ mark;
>=20
> I'm trying to understand this. Clearly both r6 and r7 are read. r6 for
> if (r6 > X) check, r7 for r9 manipulations. Why do we end up not
> marking one of them as read using a normal logic?

When (r6 > X) is processed find_equal_scalars() updates parent
pointers for all registers with the same ID as r6, in this case only
for r7. So, after find_equal_scalars() is done both current state r6
and r7 ->parent point to the r6 of the latest checkpoint state.

>=20
> I have this bad feeling I'm missing something very important here or
> we have some bug somewhere else. So please help me understand which
> one it is. This special liveness manipulation seems wrong.
>=20
> My concern is that if I have some code like
>=20
> r6 =3D r7;
> r9 +=3D r6;
>=20
> and I never use r7 anymore after that, then we should be able to
> forget r7 and treat it as NOT_INIT. But you are saying it's unsafe
> right now and that doesn't make much sense to me.

It is unsafe because of the "spooky action at a distance" produced by
a combination of:
- allocation of scalar IDs for moves, see check_alu_op() case for
  64-bit move;
- find_equal_scalars() that propagates range, this one is only
  executed for conditional jumps.

>=20
>=20
> > + * - clean_func_state() would remove r6 from checkpoint state (mark it=
 NOT_INIT).
> > + *
> > + * Consequently, when execution path 1-4, 6 reaches (6) in state (II)
> > + * regsafe() won't be able to see a mismatch in ID mappings.
> > + *
> > + * To avoid this issue mark_equal_scalars_as_read() conservatively
> > + * marks all registers with matching ID as REG_LIVE_READ, thus
> > + * preserving r6 and r7 in the checkpoint state for the example above.
> > + */
> > +static void mark_equal_scalars_as_read(struct bpf_verifier_state *vsta=
te, int id)
> > +{
> > +       struct bpf_verifier_state *st;
> > +       struct bpf_func_state *state;
> > +       struct bpf_reg_state *reg;
> > +       bool move_up;
> > +       int i =3D 0;
> > +
> > +       for (st =3D vstate, move_up =3D true; st && move_up; st =3D st-=
>parent) {
> > +               move_up =3D false;
> > +               bpf_for_each_reg_in_vstate(st, state, reg, ({
> > +                       if (reg->type =3D=3D SCALAR_VALUE && reg->id =
=3D=3D id &&
> > +                           !(reg->live & REG_LIVE_READ)) {
> > +                               reg->live |=3D REG_LIVE_READ;
> > +                               move_up =3D true;
> > +                       }
> > +                       ++i;
> > +               }));
> > +       }
> > +}
> > +
> >  static void find_equal_scalars(struct bpf_verifier_state *vstate,
> >                                struct bpf_reg_state *known_reg)
> >  {
> >         struct bpf_func_state *state;
> >         struct bpf_reg_state *reg;
> > +       int count =3D 0;
> >=20
> >         bpf_for_each_reg_in_vstate(vstate, state, reg, ({
> > -               if (reg->type =3D=3D SCALAR_VALUE && reg->id =3D=3D kno=
wn_reg->id)
> > +               if (reg->type =3D=3D SCALAR_VALUE && reg->id =3D=3D kno=
wn_reg->id) {
> >                         *reg =3D *known_reg;
> > +                       ++count;
> > +               }
> >         }));
> > +
> > +       /* Count equal to 1 means that find_equal_scalars have not
> > +        * found any registers with the same ID (except self), thus
> > +        * the range knowledge have not been transferred and there is
> > +        * no need to preserve registers with the same ID in a parent
> > +        * state.
> > +        */
> > +       if (count > 1)
> > +               mark_equal_scalars_as_read(vstate->parent, known_reg->i=
d);
> >  }
> >=20
> >  static int check_cond_jmp_op(struct bpf_verifier_env *env,
> > @@ -12878,6 +12950,12 @@ static bool regsafe(struct bpf_verifier_env *e=
nv, struct bpf_reg_state *rold,
> >                  */
> >                 return equal && rold->frameno =3D=3D rcur->frameno;
> >=20
> > +       /* even if two registers are identical the id mapping might div=
erge
> > +        * e.g. rold{.id=3D1}, rcur{.id=3D1}, idmap{1->2}
> > +        */
> > +       if (equal && rold->type =3D=3D SCALAR_VALUE && rold->id)
> > +               return check_ids(rold->id, rcur->id, idmap);
>=20
> nit: let's teach check_ids() to handle the id =3D=3D 0 case properly
> instead of guarding everything with `if (rold->id)`?
>=20
> but also I think this applies not just to SCALARs, right? the memcmp()
> check above has to be augmented with check_ids() for id and ref_obj_id

Yes, it is the same issue as described in [1] as you pointed out.
I'll updated it for other branches, but I want the main issue to
be sorted out first.

[1] https://lore.kernel.org/bpf/CAEf4BzbFB5g4oUfyxk9rHy-PJSLQ3h8q9mV=3DrVoX=
fr_JVm8+1Q@mail.gmail.com/

>=20
> > +
> >         if (equal)
> >                 return true;
> >=20
> > @@ -12891,6 +12969,11 @@ static bool regsafe(struct bpf_verifier_env *e=
nv, struct bpf_reg_state *rold,
> >                 if (env->explore_alu_limits)
> >                         return false;
> >                 if (rcur->type =3D=3D SCALAR_VALUE) {
> > +                       /* id relations must be preserved, see comment =
in
> > +                        * mark_equal_scalars_as_read() for SCALAR_VALU=
E example.
> > +                        */
> > +                       if (rold->id && !check_ids(rold->id, rcur->id, =
idmap))
> > +                               return false;
> >                         if (!rold->precise)
> >                                 return true;
> >                         /* new val must satisfy old val knowledge */
> > --
> > 2.34.1
> >=20

