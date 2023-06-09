Return-Path: <bpf+bounces-2281-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0D0E72A6AD
	for <lists+bpf@lfdr.de>; Sat, 10 Jun 2023 01:22:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 641BA28191E
	for <lists+bpf@lfdr.de>; Fri,  9 Jun 2023 23:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A1AD174C8;
	Fri,  9 Jun 2023 23:22:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1041AC13E
	for <bpf@vger.kernel.org>; Fri,  9 Jun 2023 23:22:27 +0000 (UTC)
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2C0030E5
	for <bpf@vger.kernel.org>; Fri,  9 Jun 2023 16:22:24 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2b1b66a8fd5so25841041fa.0
        for <bpf@vger.kernel.org>; Fri, 09 Jun 2023 16:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686352943; x=1688944943;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zCV4Nxq+vMDBe4+TWTN3BHqn8k3PcaO+bOwtT0ngUeA=;
        b=G1FkQR0CQFWIOsC4W15g36/z+MbBbrNSeX0ZiLK5MhXxnA/tBq2d7zgmAHbI7PkjTD
         9+JEBhgdb8ANQzbYINWf+UZw7CmZR2TLTNcbyhxleiS7zaclbN/HAUfSxDrxTmoIdr9J
         OYEPcx78bz6mUOBMZ0CGhJ4vIUCkM3mTHMw5jUqAsy/Eh9xKODMpdLx+Dut0HiJS/Eh3
         i3FLa9QocN4Gck/g9eHi9CyykQ3xfKKJBU2ZIUShxNLkF623nmFJskBMD5UxeMFbiDPo
         kicSWKwwULqP1ImgQuxTje6swWCYDx6B6VGJqREHYRBzK4pCUvOtxlKftNjVZVNyLZF9
         LzkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686352943; x=1688944943;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zCV4Nxq+vMDBe4+TWTN3BHqn8k3PcaO+bOwtT0ngUeA=;
        b=SM8o3RZ2zJOibtPNgPhxEdYwEVVXM1rUr4O6Wyai4Ga6yP3oEpNJ0t2uCR1wJapNwc
         3YC/TBL/9JiIdc86jaELIC+BGVN0tWivaN9L025syICbvV+NwJEl4jwf0Nl4ayKNUnMh
         PwmGxB3U/2PFCE9oI+PxRL1AT+RxkbTdjCNOeB+SZvT7QrNB2P5vqBQWXXMelBX3QBEA
         nnoFYrkdVo4aaU3D85CJ1EhTT92rMGxy6rczBtIX7HQhpi+1EJtTAPZvt0jEQlmJaBfX
         mIfTRuvF1yewrObMFU8bk5vLAkDawTJamkgVpZoBYTOXoVyarEZGpMdNpbhelCErZdb3
         YU5w==
X-Gm-Message-State: AC+VfDzEojJmSgWRDuPNf1AxxI2CZn7xAi0HyhJqoa2vDa0ZNWT2TTrE
	39TXyi4T5nYK3eYjJqtECi8=
X-Google-Smtp-Source: ACHHUZ7QXdu68bGfXgIqnpt586ZYdnTvnq4iyOWXmr0NcmnbZFP1uPtW4uLea1GSzKKxDZr0fkc/4g==
X-Received: by 2002:a2e:9d8c:0:b0:2b1:c0d3:72cb with SMTP id c12-20020a2e9d8c000000b002b1c0d372cbmr93720ljj.23.1686352942841;
        Fri, 09 Jun 2023 16:22:22 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id 22-20020a05651c009600b002a9f966f4b3sm566699ljq.26.2023.06.09.16.22.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 16:22:22 -0700 (PDT)
Message-ID: <3e49f57cf291039837366da0e9f622fd8254faff.camel@gmail.com>
Subject: Re: [PATCH bpf-next v4 3/4] bpf: verify scalar ids mapping in
 regsafe() using check_ids()
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net,  martin.lau@linux.dev, kernel-team@fb.com, yhs@fb.com
Date: Sat, 10 Jun 2023 02:22:21 +0300
In-Reply-To: <CAEf4BzYar7RifhvAgtjit0ibCXfJPHEHHxa85GYbphU-WartXA@mail.gmail.com>
References: <20230609210143.2625430-1-eddyz87@gmail.com>
	 <20230609210143.2625430-4-eddyz87@gmail.com>
	 <CAEf4BzYar7RifhvAgtjit0ibCXfJPHEHHxa85GYbphU-WartXA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, 2023-06-09 at 16:11 -0700, Andrii Nakryiko wrote:
> On Fri, Jun 9, 2023 at 2:02=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
> >=20
> > Make sure that the following unsafe example is rejected by verifier:
> >=20
> > 1: r9 =3D ... some pointer with range X ...
> > 2: r6 =3D ... unbound scalar ID=3Da ...
> > 3: r7 =3D ... unbound scalar ID=3Db ...
> > 4: if (r6 > r7) goto +1
> > 5: r6 =3D r7
> > 6: if (r6 > X) goto ...
> > --- checkpoint ---
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
> > path 1-6 is taken by verifier first, and checkpoint is created at (6)
> > the path [1-4, 6] would be considered safe.
> >=20
> > This commit adds a new function: check_scalar_ids() and updates
> > regsafe() to call it for precise scalar registers.
> > check_scalar_ids() differs from check_ids() in order to:
> > - treat ID zero as a unique scalar ID;
> > - disallow mapping same 'cur_id' to multiple 'old_id'.
> >=20
> > To minimize the impact on verification performance, avoid generating
> > bpf_reg_state::id for constant scalar values when processing BPF_MOV
> > in check_alu_op(). Scalar IDs are utilized by find_equal_scalars() to
> > propagate information about value ranges for registers that hold the
> > same value. However, there is no need to propagate range information
> > for constants.
> >=20
> > Fixes: 75748837b7e5 ("bpf: Propagate scalar ranges through register ass=
ignments.")
> > Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> > ---
> >  include/linux/bpf_verifier.h |  1 +
> >  kernel/bpf/verifier.c        | 77 +++++++++++++++++++++++++++++++++---
> >  2 files changed, 73 insertions(+), 5 deletions(-)
> >=20
>=20
> I have lots of gripes with specifics in this patch, as you can see
> below. But ultimately this should fix the issue and we can discuss the
> rest separately.
>=20
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
>=20
>=20
> > diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.=
h
> > index 73a98f6240fd..1bdda17fad70 100644
> > --- a/include/linux/bpf_verifier.h
> > +++ b/include/linux/bpf_verifier.h
> > @@ -584,6 +584,7 @@ struct bpf_verifier_env {
> >         u32 used_map_cnt;               /* number of used maps */
> >         u32 used_btf_cnt;               /* number of used BTF objects *=
/
> >         u32 id_gen;                     /* used to generate unique reg =
IDs */
> > +       u32 tmp_id_gen;
> >         bool explore_alu_limits;
> >         bool allow_ptr_leaks;
> >         bool allow_uninit_stack;
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index f719de396c61..c6797742f38e 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -12942,12 +12942,14 @@ static int check_alu_op(struct bpf_verifier_e=
nv *env, struct bpf_insn *insn)
> >                 if (BPF_SRC(insn->code) =3D=3D BPF_X) {
> >                         struct bpf_reg_state *src_reg =3D regs + insn->=
src_reg;
> >                         struct bpf_reg_state *dst_reg =3D regs + insn->=
dst_reg;
> > +                       bool need_id =3D src_reg->type =3D=3D SCALAR_VA=
LUE && !src_reg->id &&
> > +                                      !tnum_is_const(src_reg->var_off)=
;
> >=20
> >                         if (BPF_CLASS(insn->code) =3D=3D BPF_ALU64) {
> >                                 /* case: R1 =3D R2
> >                                  * copy register state to dest reg
> >                                  */
> > -                               if (src_reg->type =3D=3D SCALAR_VALUE &=
& !src_reg->id)
> > +                               if (need_id)
> >                                         /* Assign src and dst registers=
 the same ID
> >                                          * that will be used by find_eq=
ual_scalars()
> >                                          * to propagate min/max range.
> > @@ -12966,7 +12968,7 @@ static int check_alu_op(struct bpf_verifier_env=
 *env, struct bpf_insn *insn)
> >                                 } else if (src_reg->type =3D=3D SCALAR_=
VALUE) {
> >                                         bool is_src_reg_u32 =3D src_reg=
->umax_value <=3D U32_MAX;
> >=20
> > -                                       if (is_src_reg_u32 && !src_reg-=
>id)
> > +                                       if (is_src_reg_u32 && need_id)
> >                                                 src_reg->id =3D ++env->=
id_gen;
> >                                         copy_register_state(dst_reg, sr=
c_reg);
> >                                         /* Make sure ID is cleared if s=
rc_reg is not in u32 range otherwise
> > @@ -15148,6 +15150,36 @@ static bool check_ids(u32 old_id, u32 cur_id, =
struct bpf_id_pair *idmap)
> >         return false;
> >  }
> >=20
> > +/* Similar to check_ids(), but:
> > + * - disallow mapping of different 'old_id' values to same 'cur_id' va=
lue;
> > + * - for zero 'old_id' or 'cur_id' allocate a unique temporary ID
> > + *   to allow pairs like '0 vs unique ID', 'unique ID vs 0'.
> > + */
> > +static bool check_scalar_ids(struct bpf_verifier_env *env, u32 old_id,=
 u32 cur_id,
> > +                            struct bpf_id_pair *idmap)
> > +{
> > +       unsigned int i;
> > +
> > +       old_id =3D old_id ? old_id : ++env->tmp_id_gen;
> > +       cur_id =3D cur_id ? cur_id : ++env->tmp_id_gen;
> > +
> > +       for (i =3D 0; i < BPF_ID_MAP_SIZE; i++) {
> > +               if (!idmap[i].old) {
> > +                       /* Reached an empty slot; haven't seen this id =
before */
> > +                       idmap[i].old =3D old_id;
> > +                       idmap[i].cur =3D cur_id;
> > +                       return true;
> > +               }
> > +               if (idmap[i].old =3D=3D old_id)
> > +                       return idmap[i].cur =3D=3D cur_id;
> > +               if (idmap[i].cur =3D=3D cur_id)
> > +                       return false;
>=20
> As I mentioned, I think we should do it always (even if in some
> *partial* cases this might not be necessary to guarantee correctness),
> I believe this is what idmap semantics is promising to check, but we
> actually don't. But we can discuss that separately.

I'll compile the list of use-cases and we can discuss.

>=20
> > +       }
> > +       /* We ran out of idmap slots, which should be impossible */
> > +       WARN_ON_ONCE(1);
> > +       return false;
> > +}
> > +
> >  static void clean_func_state(struct bpf_verifier_env *env,
> >                              struct bpf_func_state *st)
> >  {
> > @@ -15253,6 +15285,15 @@ static bool regs_exact(const struct bpf_reg_st=
ate *rold,
> >                check_ids(rold->ref_obj_id, rcur->ref_obj_id, idmap);
> >  }
> >=20
> > +static bool scalar_regs_exact(struct bpf_verifier_env *env,
> > +                             const struct bpf_reg_state *rold,
> > +                             const struct bpf_reg_state *rcur,
> > +                             struct bpf_id_pair *idmap)
> > +{
> > +       return memcmp(rold, rcur, offsetof(struct bpf_reg_state, id)) =
=3D=3D 0 &&
> > +              check_scalar_ids(env, rold->id, rcur->id, idmap);
>=20
> At this point I don't know if there is any benefit to having this
> special scalar_regs_exact() implementation. We are just assuming that
> memcmp() of 88 bytes is significantly faster than doing range_within()
> (8 straightforward comparisons) and tnum_in() (few bit operations and
> one comparison). And if this doesn't work out, we pay the price of
> both memcmp and range_within+tnum_in. Plus check_scalar_ids() in both
> cases.
>=20
> I suspect that just dropping memcmp() will be at least not worse, if not =
better.

Sounds reasonable, but I'm a bit hesitant here because of the "explore_alu_=
limits":

             if (scalar_regs_exact(env, rold, rcur, idmap))
                      return true;
             if (env->explore_alu_limits)
                      return false;

tbh, I don't understand if this special case is necessary for "explore_alu_=
limits",
will think about it.

>=20
> > +}
> > +
> >  /* Returns true if (rold safe implies rcur safe) */
> >  static bool regsafe(struct bpf_verifier_env *env, struct bpf_reg_state=
 *rold,
> >                     struct bpf_reg_state *rcur, struct bpf_id_pair *idm=
ap)
> > @@ -15292,15 +15333,39 @@ static bool regsafe(struct bpf_verifier_env *=
env, struct bpf_reg_state *rold,
> >=20
> >         switch (base_type(rold->type)) {
> >         case SCALAR_VALUE:
> > -               if (regs_exact(rold, rcur, idmap))
> > +               if (scalar_regs_exact(env, rold, rcur, idmap))
> >                         return true;
> >                 if (env->explore_alu_limits)
> >                         return false;
> >                 if (!rold->precise)
> >                         return true;
> > -               /* new val must satisfy old val knowledge */
> > +               /* Why check_ids() for scalar registers?
> > +                *
> > +                * Consider the following BPF code:
> > +                *   1: r6 =3D ... unbound scalar, ID=3Da ...
> > +                *   2: r7 =3D ... unbound scalar, ID=3Db ...
> > +                *   3: if (r6 > r7) goto +1
> > +                *   4: r6 =3D r7
> > +                *   5: if (r6 > X) goto ...
> > +                *   6: ... memory operation using r7 ...
> > +                *
> > +                * First verification path is [1-6]:
> > +                * - at (4) same bpf_reg_state::id (b) would be assigne=
d to r6 and r7;
> > +                * - at (5) r6 would be marked <=3D X, find_equal_scala=
rs() would also mark
> > +                *   r7 <=3D X, because r6 and r7 share same id.
> > +                * Next verification path is [1-4, 6].
> > +                *
> > +                * Instruction (6) would be reached in two states:
> > +                *   I.  r6{.id=3Db}, r7{.id=3Db} via path 1-6;
> > +                *   II. r6{.id=3Da}, r7{.id=3Db} via path 1-4, 6.
> > +                *
> > +                * Use check_ids() to distinguish these states.
> > +                * ---
> > +                * Also verify that new value satisfies old value range=
 knowledge.
> > +                */
> >                 return range_within(rold, rcur) &&
> > -                      tnum_in(rold->var_off, rcur->var_off);
> > +                      tnum_in(rold->var_off, rcur->var_off) &&
> > +                      check_scalar_ids(env, rold->id, rcur->id, idmap)=
;
> >         case PTR_TO_MAP_KEY:
> >         case PTR_TO_MAP_VALUE:
> >         case PTR_TO_MEM:
> > @@ -15542,6 +15607,8 @@ static bool states_equal(struct bpf_verifier_en=
v *env,
> >         if (old->active_rcu_lock !=3D cur->active_rcu_lock)
> >                 return false;
> >=20
> > +       env->tmp_id_gen =3D env->id_gen;
> > +
>=20
> sigh, this is kind of ugly, but ok :( Ideally we have
>=20
> struct idmap_scratch {
>     int id_gen;
>     struct bpf_id_pair mapping[BPF_ID_MAP_SIZE];
> }
>=20
> and just initialize idmap_scratch.id_gen =3D env->id_gen and keep all
> this very local to id_map.

This looks better, will update the patch.

>=20
> But I'm nitpicking.
>=20
>=20
> >         /* for states to be equal callsites have to be the same
> >          * and all frame states need to be equivalent
> >          */
> > --
> > 2.40.1
> >=20


