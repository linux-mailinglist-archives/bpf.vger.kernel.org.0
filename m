Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F14A5647A7D
	for <lists+bpf@lfdr.de>; Fri,  9 Dec 2022 01:08:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbiLIAI1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 8 Dec 2022 19:08:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiLIAI0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 8 Dec 2022 19:08:26 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA4EE1E3C8
        for <bpf@vger.kernel.org>; Thu,  8 Dec 2022 16:08:24 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id b2so7803759eja.7
        for <bpf@vger.kernel.org>; Thu, 08 Dec 2022 16:08:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=t3tNAcb3GdbgQ+h3XzyDjHTCaID/WrHLgKHFBEso5o0=;
        b=oUY6KmgIgGwrhsJpecrP2KyiIQZ17WtwPnFh/0RkYybCISqRUJEj4XvmpHUmg+hwto
         gSB0uLjp6SXT1i6iR4pyNEbOqoU0kbeU3H4quveWlnEL3yaDvjsn0+aQFoc447oex4yi
         m+rjEtwVJnd3s74RFQzay9hTzCpXyIo4KpEiRrVuvVBpb5gZlLHV2sepJ+jhef4AyA4z
         BDJk9eMRY3SGBypzk4sB+aFPdspKfnf1lGAWRmJ3qPPr2WutWdJo49OfWSjEwnifQc1t
         kJTbT1zXrpcMXsKyNhVBDTrn+H6ocQLab8K/2c7t6j6s6RDDzvsUMa/8Ux9jUmbZxj/M
         LBnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t3tNAcb3GdbgQ+h3XzyDjHTCaID/WrHLgKHFBEso5o0=;
        b=GhkVL/b2RevKyDVSQ1g7Sr6qVi0QPR7nVF0amJU/Xf/DPiybGfUCO/LtcFACPElNiP
         qZYQMiIBnWT91FGKnTvZdsR0LV5P+MFNw+jUMRcpizh4S2GgbUdxVH953yPr9dVZZBqN
         uRm5WWTT8HrDa3B4TC04k+lY2G2WkUwk8PZ4vMGFcy5nQ7CnTA3yaXFlgMfkoylTsXyR
         ZH8nidzaeGOfEG9EBC5810CaqeXdYa8XiQcEtmiM9JcBkYftozcICzNHUKdMdV/VkyEY
         NSWlCze18mVknUvbR1gCSyUMPrMiExdLpein/zagXWGk/riQ807Ju8bo4pn1/YBFgYkT
         S+IA==
X-Gm-Message-State: ANoB5pnht51hfFjJZRHM1MyyRy+dTOg2oDJPw0VU7hgtbUzwr5lh7pxy
        utS+6rlwxrmJ6BlWr0yH4mU=
X-Google-Smtp-Source: AA0mqf7qbWIa99R8DG9tNoLHafTu1XsuRy4ODPSxBxPI2Bfk48Q8z/emZW/WigkaQMuX/a1/kuv+/Q==
X-Received: by 2002:a17:906:a59:b0:7ad:a797:5bb9 with SMTP id x25-20020a1709060a5900b007ada7975bb9mr4094735ejf.29.1670544503115;
        Thu, 08 Dec 2022 16:08:23 -0800 (PST)
Received: from [192.168.43.226] (178-133-181-48.mobile.vf-ua.net. [178.133.181.48])
        by smtp.gmail.com with ESMTPSA id h23-20020a1709060f5700b007bfacaea851sm10162507ejj.88.2022.12.08.16.08.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 16:08:22 -0800 (PST)
Message-ID: <0d575d4cce7df5fed70876c52507f3df215abbe8.camel@gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Fix to preserve reg parent/live
 fields when copying range info
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com, yhs@fb.com
Date:   Fri, 09 Dec 2022 02:08:21 +0200
In-Reply-To: <CAEf4BzZRN-5JM0Y8VJsaiL_WNeGFtXnyvT6V9v1QAo9BRRLB5A@mail.gmail.com>
References: <20221205011754.310580-1-eddyz87@gmail.com>
         <20221205011754.310580-2-eddyz87@gmail.com>
         <CAEf4BzZRN-5JM0Y8VJsaiL_WNeGFtXnyvT6V9v1QAo9BRRLB5A@mail.gmail.com>
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

On Thu, 2022-12-08 at 12:29 -0800, Andrii Nakryiko wrote:
> On Sun, Dec 4, 2022 at 5:18 PM Eduard Zingerman <eddyz87@gmail.com> wrote=
:
> >=20
> > Register range information is copied in several places. The intent is
> > to transfer range/id information from one register/stack spill to
> > another. Currently this is done using direct register assignment, e.g.:
> >=20
> > static void find_equal_scalars(..., struct bpf_reg_state *known_reg)
> > {
> >         ...
> >         struct bpf_reg_state *reg;
> >         ...
> >                         *reg =3D *known_reg;
> >         ...
> > }
> >=20
> > However, such assignments also copy the following bpf_reg_state fields:
> >=20
> > struct bpf_reg_state {
> >         ...
> >         struct bpf_reg_state *parent;
> >         ...
> >         enum bpf_reg_liveness live;
> >         ...
> > };
> >=20
> > Copying of these fields is accidental and incorrect, as could be
> > demonstrated by the following example:
> >=20
> >      0: call ktime_get_ns()
> >      1: r6 =3D r0
> >      2: call ktime_get_ns()
> >      3: r7 =3D r0
> >      4: if r0 > r6 goto +1             ; r0 & r6 are unbound thus gener=
ated
> >                                        ; branch states are identical
> >      5: *(u64 *)(r10 - 8) =3D 0xdeadbeef ; 64-bit write to fp[-8]
> >     --- checkpoint ---
> >      6: r1 =3D 42                        ; r1 marked as written
> >      7: *(u8 *)(r10 - 8) =3D r1          ; 8-bit write, fp[-8] parent &=
 live
> >                                        ; overwritten
> >      8: r2 =3D *(u64 *)(r10 - 8)
> >      9: r0 =3D 0
> >     10: exit
> >=20
> > This example is unsafe because 64-bit write to fp[-8] at (5) is
> > conditional, thus not all bytes of fp[-8] are guaranteed to be set
> > when it is read at (8). However, currently the example passes
> > verification.
> >=20
> > First, the execution path 1-10 is examined by verifier.
> > Suppose that a new checkpoint is created by is_state_visited() at (6).
> > After checkpoint creation:
> > - r1.parent points to checkpoint.r1,
> > - fp[-8].parent points to checkpoint.fp[-8].
> > At (6) the r1.live is set to REG_LIVE_WRITTEN.
> > At (7) the fp[-8].parent is set to r1.parent and fp[-8].live is set to
> > REG_LIVE_WRITTEN, because of the following code called in
> > check_stack_write_fixed_off():
> >=20
> > static void save_register_state(struct bpf_func_state *state,
> >                                 int spi, struct bpf_reg_state *reg,
> >                                 int size)
> > {
> >         ...
> >         state->stack[spi].spilled_ptr =3D *reg;  // <--- parent & live =
copied
> >         if (size =3D=3D BPF_REG_SIZE)
> >                 state->stack[spi].spilled_ptr.live |=3D REG_LIVE_WRITTE=
N;
> >         ...
> > }
> >=20
> > Note the intent to mark stack spill as written only if 8 bytes are
> > spilled to a slot, however this intent is spoiled by a 'live' field cop=
y.
> > At (8) the checkpoint.fp[-8] should be marked as REG_LIVE_READ but
> > this does not happen:
> > - fp[-8] in a current state is already marked as REG_LIVE_WRITTEN;
> > - fp[-8].parent points to checkpoint.r1, parentage chain is used by
> >   mark_reg_read() to mark checkpoint states.
> > At (10) the verification is finished for path 1-10 and jump 4-6 is
> > examined. The checkpoint.fp[-8] never gets REG_LIVE_READ mark and this
> > spill is pruned from the cached states by clean_live_states(). Hence
> > verifier state obtained via path 1-4,6 is deemed identical to one
> > obtained via path 1-6 and program marked as safe.
> >=20
> > Note: the example should be executed with BPF_F_TEST_STATE_FREQ flag
> > set to force creation of intermediate verifier states.
> >=20
> > This commit revisits the locations where bpf_reg_state instances are
> > copied and replaces the direct copies with a call to a function
> > copy_register_state(dst, src) that preserves 'parent' and 'live'
> > fields of the 'dst'.
> >=20
> > Fixes: 679c782de14b ("bpf/verifier: per-register parent pointers")
> > Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> > ---
> >  kernel/bpf/verifier.c | 25 ++++++++++++++++++-------
> >  1 file changed, 18 insertions(+), 7 deletions(-)
> >=20
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index b0db9c10567b..8b0a03aad85e 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -3181,13 +3181,24 @@ static bool __is_pointer_value(bool allow_ptr_l=
eaks,
> >         return reg->type !=3D SCALAR_VALUE;
> >  }
> >=20
> > +/* Copy src state preserving dst->parent and dst->live fields */
> > +static void copy_register_state(struct bpf_reg_state *dst, const struc=
t bpf_reg_state *src)
> > +{
> > +       struct bpf_reg_state *parent =3D dst->parent;
> > +       enum bpf_reg_liveness live =3D dst->live;
> > +
> > +       *dst =3D *src;
> > +       dst->parent =3D parent;
> > +       dst->live =3D live;
>=20
> It feels like liveness should always be reset when we are copying
> register states like this. This copy_register_state() happens when we
> do `r1 =3D r2`, or when we spill/restore register to stack, right? In

And also in find_equal_scalars().

> all of these cases we should first assume that these registers or
> stack slots won't be ever read and would need to be forgotten later.
> So any REG_LIVE_READ{32,64} marks should be clear.
>=20
> But we are preserving old liveness for some reason. Is that intentional?

Yes. There are two values that we can write to dst->live:
REG_LIVE_NONE & REG_LIVE_WRITTEN.

The REG_LIVE_NONE would be incorrect for the following program:

--- checkpoint #0 ---
  0: *(u64 *)(r10 - 8) =3D 42
--- checkpoint #1 ---
  1: *(u64 *)(r10 - 8) =3D 7
  2: *(u8  *)(r10 - 8) =3D r1
  3: r2 =3D *(u64 *)(r10 - 8)

At (1) check_stack_write_fixed_off() will mark fp[-8] as REG_LIVE_WRITTEN.
At (2) check_stack_write_fixed_off() can't mark fp[-8] as
REG_LIVE_WRITTEN because the write is u8.

So, if copy_register_state() is changed to "dst->live =3D REG_LIVE_NONE;"
the REG_LIVE_WRITTEN mark would be lost and checkpoint[0].fp[-8] would
be marked as read at (3).

Now, suppose REG_LIVE_WRITTEN is used instead of REG_LIVE_NONE:
"dst->live =3D REG_LIVE_WRITTEN;". It would be incorrect for a similar
program:

--- checkpoint #0 ---
  0: *(u64 *)(r10 - 8) =3D 42
--- checkpoint #1 ---
  1: *(u8  *)(r10 - 8) =3D r1
  2: r2 =3D *(u64 *)(r10 - 8)

At (1) check_stack_write_fixed_off() will call copy_register_state()
thus marking fp[-8] as written, which would prevent
checkpoint[0].fp[-8] from getting a read mark at (2).

find_equal_scalars() shouldn't touch liveness as well.

So, I opted to leave 'dst->live' as is and let the calling code deal
with it (as it has more context).

> Similarly for parent pointers, I still feel like resetting parent to
> NULL for such statements is the right approach here. But as you
> explained offline, LIVE_WRITTEN is equivalent, so ok, fine.
>
> Now, for your example above. I feel like `7: *(u8 *)(r10 - 8) =3D r1`
> should go through a parental chain before we reset parent and mark
> parent as READ. That is, when we forcefully turn the previous spilled
> register to STACK_MISC, we are basically reading that register and
> casting it to an unknown integer. Does that work or does it break
> something?

For this instruction the following happens on master:
- do_check() in BPF_STX branch calls check_reg_arg(..., SRC_OP) for r1,
  which marks it as REG_LIVE_READ;
- do_check() in BPF_STX branch calls ... check_stack_write_fixed_off()
  which calls save_register_state(), which:
  - converts byte fp[-1]..fp[-7] to STACK_MISC;
  - converts byte fp[-8] to STACK_SPILL;
  - copies r1 byte-to-byte to fp[-8].spilled_ptr, which breaks
    parentage chain and liveness info:
    - fp[-8].spilled_ptr.parent is now checkpoint.r1;
    - fp[-8].spilled_ptr.live is now REG_LIVE_WRITTEN.

For this instruction the following happens with this patch:
- do_check() in BPF_STX branch calls check_reg_arg(..., SRC_OP) for r1,
  which marks it as REG_LIVE_READ;
- do_check() in BPF_STX branch calls ... check_stack_write_fixed_off()
  which calls save_register_state(), which:
  - converts bytes fp[-1]..fp[-7] to STACK_MISC;
  - converts byte fp[-8] to STACK_SPILL;
  - copies r1 to fp[-8].spilled_ptr using copy_register_state:
    - fp[-8].spilled_ptr.parent is preserved to be checkpoint.fp[-8].spille=
d_ptr;
    - fp[-8].spilled_ptr.live is preserved to be REG_LIVE_NONE.

In both cases fp[-8] is *not* marked as READ as a result of (7).
And it shouldn't because no read actually occurred and it would lead to
unnecessary read marks e.g. in the following situation:

 5: *(u64 *)(r10 - 8) =3D 0xdeadbeef
--- checkpoint ---
 6: r1 =3D 42
 7: *(u8 *)(r10 - 8) =3D r1
 8: *(u64 *)(r10 - 8) =3D r2

>=20
> Sorry, I'm repaging all the context after a few days not looking at
> this, so some of those questions we might have discussed. But it would
> be useful for others to also understand these subtleties.
>=20
>=20
> > +}
> > +
> >  static void save_register_state(struct bpf_func_state *state,
> >                                 int spi, struct bpf_reg_state *reg,
> >                                 int size)
> >  {
> >         int i;
> >=20
> > -       state->stack[spi].spilled_ptr =3D *reg;
> > +       copy_register_state(&state->stack[spi].spilled_ptr, reg);
>=20
> So what I mentioned above. Here, before we copy_register_state, if
> size !=3D BPF_REG_SIZE, mark current parent as READ, and then
> copy_register_state. What does this break?

You are talking about 'state->stack[spi].spilled_ptr.parent', right?
I don't see an example of it breaking something, but as in the example
above it can lead to unnecessary read marks.

> >         if (size =3D=3D BPF_REG_SIZE)
> >                 state->stack[spi].spilled_ptr.live |=3D REG_LIVE_WRITTE=
N;
> >=20
> > @@ -3513,7 +3524,7 @@ static int check_stack_read_fixed_off(struct bpf_=
verifier_env *env,
> >                                  */
> >                                 s32 subreg_def =3D state->regs[dst_regn=
o].subreg_def;
> >=20
> > -                               state->regs[dst_regno] =3D *reg;
> > +                               copy_register_state(&state->regs[dst_re=
gno], reg);
> >                                 state->regs[dst_regno].subreg_def =3D s=
ubreg_def;
> >                         } else {
> >                                 for (i =3D 0; i < size; i++) {
> > @@ -3534,7 +3545,7 @@ static int check_stack_read_fixed_off(struct bpf_=
verifier_env *env,
> >=20
> >                 if (dst_regno >=3D 0) {
> >                         /* restore register state from stack */
> > -                       state->regs[dst_regno] =3D *reg;
> > +                       copy_register_state(&state->regs[dst_regno], re=
g);
> >                         /* mark reg as written since spilled pointer st=
ate likely
> >                          * has its liveness marks cleared by is_state_v=
isited()
> >                          * which resets stack/reg liveness for state tr=
ansitions
> > @@ -9407,7 +9418,7 @@ static int sanitize_ptr_alu(struct bpf_verifier_e=
nv *env,
> >          */
> >         if (!ptr_is_dst_reg) {
> >                 tmp =3D *dst_reg;
> > -               *dst_reg =3D *ptr_reg;
> > +               copy_register_state(dst_reg, ptr_reg);
> >         }
> >         ret =3D sanitize_speculative_path(env, NULL, env->insn_idx + 1,
> >                                         env->insn_idx);
> > @@ -10660,7 +10671,7 @@ static int check_alu_op(struct bpf_verifier_env=
 *env, struct bpf_insn *insn)
> >                                          * to propagate min/max range.
> >                                          */
> >                                         src_reg->id =3D ++env->id_gen;
> > -                               *dst_reg =3D *src_reg;
> > +                               copy_register_state(dst_reg, src_reg);
> >                                 dst_reg->live |=3D REG_LIVE_WRITTEN;
> >                                 dst_reg->subreg_def =3D DEF_NOT_SUBREG;
> >                         } else {
> > @@ -10671,7 +10682,7 @@ static int check_alu_op(struct bpf_verifier_env=
 *env, struct bpf_insn *insn)
> >                                                 insn->src_reg);
> >                                         return -EACCES;
> >                                 } else if (src_reg->type =3D=3D SCALAR_=
VALUE) {
> > -                                       *dst_reg =3D *src_reg;
> > +                                       copy_register_state(dst_reg, sr=
c_reg);
> >                                         /* Make sure ID is cleared othe=
rwise
> >                                          * dst_reg min/max could be inc=
orrectly
> >                                          * propagated into src_reg by f=
ind_equal_scalars()
> > @@ -11470,7 +11481,7 @@ static void find_equal_scalars(struct bpf_verif=
ier_state *vstate,
> >=20
> >         bpf_for_each_reg_in_vstate(vstate, state, reg, ({
> >                 if (reg->type =3D=3D SCALAR_VALUE && reg->id =3D=3D kno=
wn_reg->id)
> > -                       *reg =3D *known_reg;
> > +                       copy_register_state(reg, known_reg);
>=20
> did we discuss what should happen with precision propagation in cases
> like this? These "equal scalars" are a bit mind bending, we need to
> consider if by tracking precision independently for them we are going
> to break anything,

That's the scary part. In [1] I have an example that shows that scalar
ids must be matched using check_ids() in regsafe(). There I modified
regsafe() as follows:

@@ -12891,6 +12969,11 @@ static bool regsafe(struct bpf_verifier_env *env, =
struct bpf_reg_state *rold,
 		if (env->explore_alu_limits)
 			return false;
 		if (rcur->type =3D=3D SCALAR_VALUE) {
+			/* id relations must be preserved, see comment in
+			 * mark_equal_scalars_as_read() for SCALAR_VALUE example.
+			 */
+			if (rold->id && !check_ids(rold->id, rcur->id, idmap))
+				return false;
 			if (!rold->precise)
 				return true;
 			/* new val must satisfy old val knowledge */

The idea is to check that all scalar ids match before checking for
'precise'. Even if some of these scalar IDs are imprecise. It seems to
me that this is conservatively safe but I hoped to get some comments
from you or Alexei.

Also, I don't know how to make a test case for [1] without this patch,
so this one comes first.

I think that it is possible to do precision propagation
for find_equal_scalars() if jump history is enriched with
information like scalar ids, which could then be used in
__mark_chain_precision() (because when something is marked as precise
all the conditionals that lead to this are in the current jump
history).

[1] https://lore.kernel.org/bpf/20221128163442.280187-1-eddyz87@gmail.com/

>=20
> >         }));
> >  }
> >=20
> > --
> > 2.34.1
> >=20

