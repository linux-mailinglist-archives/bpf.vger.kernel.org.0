Return-Path: <bpf+bounces-2466-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2020172D590
	for <lists+bpf@lfdr.de>; Tue, 13 Jun 2023 02:11:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E9A32810A6
	for <lists+bpf@lfdr.de>; Tue, 13 Jun 2023 00:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A554064C;
	Tue, 13 Jun 2023 00:11:06 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D4A17E
	for <bpf@vger.kernel.org>; Tue, 13 Jun 2023 00:11:06 +0000 (UTC)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 980621730
	for <bpf@vger.kernel.org>; Mon, 12 Jun 2023 17:11:00 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4f619c2ba18so5615871e87.1
        for <bpf@vger.kernel.org>; Mon, 12 Jun 2023 17:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686615059; x=1689207059;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qjc0fteqo3z+cEy8Pg7IKNNPEHVcif18B1qD/kLGZBQ=;
        b=TDRK/Jx2fVeR3FdWMqOx61qUa1LlHMKMgezaQP+stAcVjZVOcsKljAZj8DNIjWz/0D
         HzbbW135EGjrywu9uZYtKuh1Xnq75Z6YX7dqV1h6v6viAFF06IFgAWWm5ylARiM+fNVC
         ZZR/aGZUNiG1ikrbowfhUn7MBLprIEEw7ZXy9keSnC/09QssvcES8Mf3Vjnt7I06OtMs
         JYNz7OlrDq9ZhFVC+DoHI72R34pa3fh2mMEuhAr4uNvWpV+iVIpYNoQ+Gn+kdPJI+koV
         wJvtmAAlbwf61G3/jVd7OKdVny2Cj6HTAdNPZclLW+TfLW2rwdFUpRFiLbAJtkrGaGR9
         Cqyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686615059; x=1689207059;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qjc0fteqo3z+cEy8Pg7IKNNPEHVcif18B1qD/kLGZBQ=;
        b=TCrbTVag+eFpS690JGBMlzMxDpIUJf0Jew9zJfTOgI6qCzCEK6axGhsfve+3EZrciY
         iwiftf/dDg1ybMydSYhZbi34atVFnb0ntY1zSp8i33hbdcqKqJir77cMet2RZ4Os8EPC
         PuNOJkxGAM8hiETQbCgFjNKW5VwKyZ0fcN9PnwY5doNeR6yUI6/S3NrxsSDyn9pml3zi
         q9JxjG4bjRMqsJEt+8C4iwvrRvAtc4kwAgO+9PmrXnhOrpz+zz52QYo0zKXywdBAVI3G
         monTb9kC0AuNMH/AWoM70x5m2AhnfyTpw1ULjpQpLmXXI9DljA974irAJql6rDi7ZYrV
         1LSQ==
X-Gm-Message-State: AC+VfDxsXoX3D4evqfMxZzheZyOms3vnmLIo4SOrHsVeJbVHJb+/I4tu
	Nj1XhUlVDYmYmVTaGWbKo2U=
X-Google-Smtp-Source: ACHHUZ7lveJNqRc0dxeU1EwzRlC5RuH8ohEBNd+fcQ9EE4Z/8Rxtv76pvDDvxF6SiOGFRAQdiS9FeA==
X-Received: by 2002:a05:6512:1d2:b0:4f3:8269:7228 with SMTP id f18-20020a05651201d200b004f382697228mr5032250lfp.68.1686615058339;
        Mon, 12 Jun 2023 17:10:58 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id m26-20020a19521a000000b004f3942e1fbesm1559438lfb.1.2023.06.12.17.10.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 17:10:57 -0700 (PDT)
Message-ID: <256afded9974601228e0cf35866ba6eac0e26199.camel@gmail.com>
Subject: Re: [PATCH bpf-next v5 3/4] bpf: verify scalar ids mapping in
 regsafe() using check_ids()
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net,  martin.lau@linux.dev, kernel-team@fb.com, yhs@fb.com
Date: Tue, 13 Jun 2023 03:10:56 +0300
In-Reply-To: <f44a65796462fd977c63edbeaee10d4cdc665d73.camel@gmail.com>
References: <20230612160801.2804666-1-eddyz87@gmail.com>
	 <20230612160801.2804666-4-eddyz87@gmail.com>
	 <CAEf4BzZLsZ5tMnRdY0rH1-EYH0ooUgkKr082neMtE7jTArVkOQ@mail.gmail.com>
	 <f44a65796462fd977c63edbeaee10d4cdc665d73.camel@gmail.com>
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
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, 2023-06-13 at 00:01 +0300, Eduard Zingerman wrote:
> On Mon, 2023-06-12 at 12:56 -0700, Andrii Nakryiko wrote:
> > On Mon, Jun 12, 2023 at 9:08=E2=80=AFAM Eduard Zingerman <eddyz87@gmail=
.com> wrote:
> > >=20
> > > Make sure that the following unsafe example is rejected by verifier:
> > >=20
> > > 1: r9 =3D ... some pointer with range X ...
> > > 2: r6 =3D ... unbound scalar ID=3Da ...
> > > 3: r7 =3D ... unbound scalar ID=3Db ...
> > > 4: if (r6 > r7) goto +1
> > > 5: r6 =3D r7
> > > 6: if (r6 > X) goto ...
> > > --- checkpoint ---
> > > 7: r9 +=3D r7
> > > 8: *(u64 *)r9 =3D Y
> > >=20
> > > This example is unsafe because not all execution paths verify r7 rang=
e.
> > > Because of the jump at (4) the verifier would arrive at (6) in two st=
ates:
> > > I.  r6{.id=3Db}, r7{.id=3Db} via path 1-6;
> > > II. r6{.id=3Da}, r7{.id=3Db} via path 1-4, 6.
> > >=20
> > > Currently regsafe() does not call check_ids() for scalar registers,
> > > thus from POV of regsafe() states (I) and (II) are identical. If the
> > > path 1-6 is taken by verifier first, and checkpoint is created at (6)
> > > the path [1-4, 6] would be considered safe.
> > >=20
> > > Changes in this commit:
> > > - Function check_scalar_ids() is added, it differs from check_ids() i=
n
> > >   the following aspects:
> > >   - treats ID zero as a unique scalar ID;
> > >   - disallows mapping same 'cur_id' to multiple 'old_id'.
> > > - check_scalar_ids() needs to generate temporary unique IDs, field
> > >   'tmp_id_gen' is added to bpf_verifier_env::idmap_scratch to
> > >   facilitate this.
> > > - Function scalar_regs_exact() is added, it differs from regs_exact()
> > >   in the following aspects:
> > >   - uses check_scalar_ids() for ID comparison;
> > >   - does not check reg_obj_id as this field is not used for scalar
> > >     values.
> > > - regsafe() is updated to:
> > >   - use check_scalar_ids() for precise scalar registers.
> > >   - use scalar_regs_exact() for scalar registers, but only for
> > >     explore_alu_limits branch. This simplifies control flow for scala=
r
> > >     case, and has no measurable performance impact.
> > > - check_alu_op() is updated avoid generating bpf_reg_state::id for
> > >   constant scalar values when processing BPF_MOV. ID is needed to
> > >   propagate range information for identical values, but there is
> > >   nothing to propagate for constants.
> > >=20
> > > Fixes: 75748837b7e5 ("bpf: Propagate scalar ranges through register a=
ssignments.")
> > > Acked-by: Andrii Nakryiko <andrii@kernel.org>
> > > Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> > > ---
> > >  include/linux/bpf_verifier.h |  17 ++++--
> > >  kernel/bpf/verifier.c        | 108 ++++++++++++++++++++++++++++-----=
--
> > >  2 files changed, 97 insertions(+), 28 deletions(-)
> > >=20
> > > diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifie=
r.h
> > > index 73a98f6240fd..042b76fe8e29 100644
> > > --- a/include/linux/bpf_verifier.h
> > > +++ b/include/linux/bpf_verifier.h
> > > @@ -313,11 +313,6 @@ struct bpf_idx_pair {
> > >         u32 idx;
> > >  };
> > >=20
> > > -struct bpf_id_pair {
> > > -       u32 old;
> > > -       u32 cur;
> > > -};
> > > -
> > >  #define MAX_CALL_FRAMES 8
> > >  /* Maximum number of register states that can exist at once */
> > >  #define BPF_ID_MAP_SIZE ((MAX_BPF_REG + MAX_BPF_STACK / BPF_REG_SIZE=
) * MAX_CALL_FRAMES)
> > > @@ -559,6 +554,16 @@ struct backtrack_state {
> > >         u64 stack_masks[MAX_CALL_FRAMES];
> > >  };
> > >=20
> > > +struct bpf_id_pair {
> > > +       u32 old;
> > > +       u32 cur;
> > > +};
> > > +
> > > +struct bpf_idmap {
> > > +       u32 tmp_id_gen;
> > > +       struct bpf_id_pair map[BPF_ID_MAP_SIZE];
> > > +};
> > > +
> > >  struct bpf_idset {
> > >         u32 count;
> > >         u32 ids[BPF_ID_MAP_SIZE];
> > > @@ -596,7 +601,7 @@ struct bpf_verifier_env {
> > >         struct bpf_verifier_log log;
> > >         struct bpf_subprog_info subprog_info[BPF_MAX_SUBPROGS + 1];
> > >         union {
> > > -               struct bpf_id_pair idmap_scratch[BPF_ID_MAP_SIZE];
> > > +               struct bpf_idmap idmap_scratch;
> > >                 struct bpf_idset idset_scratch;
> > >         };
> > >         struct {
> > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > index 9b5f2433194f..b15ebfed207a 100644
> > > --- a/kernel/bpf/verifier.c
> > > +++ b/kernel/bpf/verifier.c
> > > @@ -12942,12 +12942,14 @@ static int check_alu_op(struct bpf_verifier=
_env *env, struct bpf_insn *insn)
> > >                 if (BPF_SRC(insn->code) =3D=3D BPF_X) {
> > >                         struct bpf_reg_state *src_reg =3D regs + insn=
->src_reg;
> > >                         struct bpf_reg_state *dst_reg =3D regs + insn=
->dst_reg;
> > > +                       bool need_id =3D src_reg->type =3D=3D SCALAR_=
VALUE && !src_reg->id &&
> > > +                                      !tnum_is_const(src_reg->var_of=
f);
> > >=20
> > >                         if (BPF_CLASS(insn->code) =3D=3D BPF_ALU64) {
> > >                                 /* case: R1 =3D R2
> > >                                  * copy register state to dest reg
> > >                                  */
> > > -                               if (src_reg->type =3D=3D SCALAR_VALUE=
 && !src_reg->id)
> > > +                               if (need_id)
> > >                                         /* Assign src and dst registe=
rs the same ID
> > >                                          * that will be used by find_=
equal_scalars()
> > >                                          * to propagate min/max range=
.
> > > @@ -12966,7 +12968,7 @@ static int check_alu_op(struct bpf_verifier_e=
nv *env, struct bpf_insn *insn)
> > >                                 } else if (src_reg->type =3D=3D SCALA=
R_VALUE) {
> > >                                         bool is_src_reg_u32 =3D src_r=
eg->umax_value <=3D U32_MAX;
> > >=20
> > > -                                       if (is_src_reg_u32 && !src_re=
g->id)
> > > +                                       if (is_src_reg_u32 && need_id=
)
> > >                                                 src_reg->id =3D ++env=
->id_gen;
> > >                                         copy_register_state(dst_reg, =
src_reg);
> > >                                         /* Make sure ID is cleared if=
 src_reg is not in u32 range otherwise
> > > @@ -15122,8 +15124,9 @@ static bool range_within(struct bpf_reg_state=
 *old,
> > >   * So we look through our idmap to see if this old id has been seen =
before.  If
> > >   * so, we require the new id to match; otherwise, we add the id pair=
 to the map.
> > >   */
> > > -static bool check_ids(u32 old_id, u32 cur_id, struct bpf_id_pair *id=
map)
> > > +static bool check_ids(u32 old_id, u32 cur_id, struct bpf_idmap *idma=
p)
> > >  {
> > > +       struct bpf_id_pair *map =3D idmap->map;
> > >         unsigned int i;
> > >=20
> > >         /* either both IDs should be set or both should be zero */
> > > @@ -15134,14 +15137,44 @@ static bool check_ids(u32 old_id, u32 cur_i=
d, struct bpf_id_pair *idmap)
> > >                 return true;
> > >=20
> > >         for (i =3D 0; i < BPF_ID_MAP_SIZE; i++) {
> > > -               if (!idmap[i].old) {
> > > +               if (!map[i].old) {
> > >                         /* Reached an empty slot; haven't seen this i=
d before */
> > > -                       idmap[i].old =3D old_id;
> > > -                       idmap[i].cur =3D cur_id;
> > > +                       map[i].old =3D old_id;
> > > +                       map[i].cur =3D cur_id;
> > >                         return true;
> > >                 }
> > > -               if (idmap[i].old =3D=3D old_id)
> > > -                       return idmap[i].cur =3D=3D cur_id;
> > > +               if (map[i].old =3D=3D old_id)
> > > +                       return map[i].cur =3D=3D cur_id;
> > > +       }
> > > +       /* We ran out of idmap slots, which should be impossible */
> > > +       WARN_ON_ONCE(1);
> > > +       return false;
> > > +}
> > > +
> > > +/* Similar to check_ids(), but:
> > > + * - disallow mapping of different 'old_id' values to same 'cur_id' =
value;
> > > + * - for zero 'old_id' or 'cur_id' allocate a unique temporary ID
> > > + *   to allow pairs like '0 vs unique ID', 'unique ID vs 0'.
> > > + */
> > > +static bool check_scalar_ids(u32 old_id, u32 cur_id, struct bpf_idma=
p *idmap)
> > > +{
> > > +       struct bpf_id_pair *map =3D idmap->map;
> > > +       unsigned int i;
> > > +
> > > +       old_id =3D old_id ? old_id : ++idmap->tmp_id_gen;
> > > +       cur_id =3D cur_id ? cur_id : ++idmap->tmp_id_gen;
> > > +
> > > +       for (i =3D 0; i < BPF_ID_MAP_SIZE; i++) {
> > > +               if (!map[i].old) {
> > > +                       /* Reached an empty slot; haven't seen this i=
d before */
> > > +                       map[i].old =3D old_id;
> > > +                       map[i].cur =3D cur_id;
> > > +                       return true;
> > > +               }
> > > +               if (map[i].old =3D=3D old_id)
> > > +                       return map[i].cur =3D=3D cur_id;
> > > +               if (map[i].cur =3D=3D cur_id)
> > > +                       return false;
> >=20
> > We were discussing w/ Alexei (offline) making these changes as
> > backportable and minimal as possible, so I looked again how to
> > minimize all the extra code added.
> >=20
> > I still insist that the current logic in check_ids() is invalid to
> > allow the same cur_id to map to two different old_ids, especially for
> > non-SCALAR, actually. E.g., a situation where we have a register that
> > is auto-invalidated. E.g., bpf_iter element (each gets an ID), or it
> > could be id'ed dynptr_ringbuf.
> >=20
> > Think about the following situation:
> >=20
> > In the old state, we could have r1.id =3D 1; r2.id =3D 2; Two registers
> > keep two separate pointers to ringbuf.
> >=20
> > In the new state, we have r1.id =3D r2.id =3D 3; That is, two registers
> > keep the *same* pointer to ringbuf elem.
> >=20
> > Now imagine that a BPF program has bpf_ringbuf_submit(r1) and
> > invalidates this register. With the old state it will invalidate r1
> > and will keep r2 valid. So it's safe for the BPF program to keep
> > working with r2 as valid ringbuf (and eventually submit it as well).
> >=20
> > Now this is entirely unsafe for the new state. Once
> > bpf_ringbuf_submit(r1) happens, r2 shouldn't be accessed anymore. But
> > yet it will be declared safe with current check_ids() logic.
> >=20
> > Ergo, check_ids() should make sure we do not have multi-mapping for
> > any of the IDs. Even if in some corner case that might be ok.
> >=20
> > I actually tested this change with veristat, there are no regressions
> > at all. I think it's both safe from a perf standpoint, and necessary
> > and safe from a correctness standpoint.
> >=20
> > So all in all (I did inline scalar_regs_exact in a separate patch, up
> > to you), I have these changes on top and they all are good from
> > veristat perspective:
>=20
> Ok, rinbuf is a good example.
> To minimize the patch-set I'll do the following:
> - move your check_ids patch to the beginning of the series
> - add selftest for ringbuf
> - squash the scalar_regs_exact patch with current patch #3
>=20
> And resubmit with EFAULT fix in patch #1.
> Thank you for looking into this.

Welp, it turns out it is not possible to create a failing example with
ringbuf. This is so, because ringbuf objects are tracked in
bpf_func_state::refs (of type struct bpf_reference_state).

ID of each acquired object is stored in this array and compared in
func_states_equal() using refsafe() function:

  static bool refsafe(struct bpf_func_state *old, struct bpf_func_state *cu=
r,
  		    struct bpf_idmap *idmap)
  {
  	int i;
 =20
  	if (old->acquired_refs !=3D cur->acquired_refs)
  		return false;
 =20
  	for (i =3D 0; i < old->acquired_refs; i++) {
  		if (!check_ids(old->refs[i].id, cur->refs[i].id, idmap))
  			return false;
  	}
 =20
  	return true;
  }
 =20
Whatever combination of old and current IDs we get in register is
later checked against full list of acquired IDs.

So far I haven't been able to create a counter-example that shows the
following snippet is necessary in check_ids():

+               if (map[i].cur =3D=3D cur_id)
+                       return false;

But this saga has to end somehow :)
I'll just squash your patches on top of patch #3, since there are not
verification performance regressions.

>=20
> >=20
> > Author: Andrii Nakryiko <andrii@kernel.org>
> > Date:   Mon Jun 12 12:53:25 2023 -0700
> >=20
> >     bpf: inline scalar_regs_exact
> >=20
> >     Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> >=20
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 9d5fefd970a3..c5606613136d 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -15262,14 +15262,6 @@ static bool regs_exact(const struct
> > bpf_reg_state *rold,
> >                check_ids(rold->ref_obj_id, rcur->ref_obj_id, idmap);
> >  }
> >=20
> > -static bool scalar_regs_exact(const struct bpf_reg_state *rold,
> > -                             const struct bpf_reg_state *rcur,
> > -                             struct bpf_idmap *idmap)
> > -{
> > -       return memcmp(rold, rcur, offsetof(struct bpf_reg_state, id)) =
=3D=3D 0 &&
> > -              check_scalar_ids(rold->id, rcur->id, idmap);
> > -}
> > -
> >  /* Returns true if (rold safe implies rcur safe) */
> >  static bool regsafe(struct bpf_verifier_env *env, struct bpf_reg_state=
 *rold,
> >                     struct bpf_reg_state *rcur, struct bpf_idmap *idmap=
)
> > @@ -15309,8 +15301,13 @@ static bool regsafe(struct bpf_verifier_env
> > *env, struct bpf_reg_state *rold,
> >=20
> >         switch (base_type(rold->type)) {
> >         case SCALAR_VALUE:
> > -               if (env->explore_alu_limits)
> > -                       return scalar_regs_exact(rold, rcur, idmap);
> > +               if (env->explore_alu_limits) {
> > +                       /* explore_alu_limits disables tnum_in() and
> > range_within()
> > +                        * logic and requires everything to be strict
> > +                        */
> > +                       return memcmp(rold, rcur, offsetof(struct
> > bpf_reg_state, id)) =3D=3D 0 &&
> > +                              check_scalar_ids(rold->id, rcur->id, idm=
ap);
> > +               }
> >                 if (!rold->precise)
> >                         return true;
> >                 /* Why check_ids() for scalar registers?
> >=20
> > commit 57297c01fe747e423cd3c924ef492c0688d8057a
> > Author: Andrii Nakryiko <andrii@kernel.org>
> > Date:   Mon Jun 12 11:46:46 2023 -0700
> >=20
> >     bpf: make check_ids disallow multi-mapping of IDs universally
> >=20
> >     Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> >=20
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 3da77713d1ca..9d5fefd970a3 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -15137,6 +15137,8 @@ static bool check_ids(u32 old_id, u32 cur_id,
> > struct bpf_idmap *idmap)
> >                 }
> >                 if (map[i].old =3D=3D old_id)
> >                         return map[i].cur =3D=3D cur_id;
> > +               if (map[i].cur =3D=3D cur_id)
> > +                       return false;
> >         }
> >         /* We ran out of idmap slots, which should be impossible */
> >         WARN_ON_ONCE(1);
> > @@ -15144,33 +15146,15 @@ static bool check_ids(u32 old_id, u32
> > cur_id, struct bpf_idmap *idmap)
> >  }
> >=20
> >  /* Similar to check_ids(), but:
> > - * - disallow mapping of different 'old_id' values to same 'cur_id' va=
lue;
> >   * - for zero 'old_id' or 'cur_id' allocate a unique temporary ID
> >   *   to allow pairs like '0 vs unique ID', 'unique ID vs 0'.
> >   */
> >  static bool check_scalar_ids(u32 old_id, u32 cur_id, struct bpf_idmap =
*idmap)
> >  {
> > -       struct bpf_id_pair *map =3D idmap->map;
> > -       unsigned int i;
> > -
> >         old_id =3D old_id ? old_id : ++idmap->tmp_id_gen;
> >         cur_id =3D cur_id ? cur_id : ++idmap->tmp_id_gen;
> >=20
> > -       for (i =3D 0; i < BPF_ID_MAP_SIZE; i++) {
> > -               if (!map[i].old) {
> > -                       /* Reached an empty slot; haven't seen this id =
before */
> > -                       map[i].old =3D old_id;
> > -                       map[i].cur =3D cur_id;
> > -                       return true;
> > -               }
> > -               if (map[i].old =3D=3D old_id)
> > -                       return map[i].cur =3D=3D cur_id;
> > -               if (map[i].cur =3D=3D cur_id)
> > -                       return false;
> > -       }
> > -       /* We ran out of idmap slots, which should be impossible */
> > -       WARN_ON_ONCE(1);
> > -       return false;
> > +       return check_ids(old_id, cur_id, idmap);
> >  }
> >=20
> >  static void clean_func_state(struct bpf_verifier_env *env,
> >=20
> >=20
> >=20
> > >         }
> > >         /* We ran out of idmap slots, which should be impossible */
> > >         WARN_ON_ONCE(1);
> > > @@ -15246,16 +15279,24 @@ static void clean_live_states(struct bpf_ve=
rifier_env *env, int insn,
> > >=20
> > >  static bool regs_exact(const struct bpf_reg_state *rold,
> > >                        const struct bpf_reg_state *rcur,
> > > -                      struct bpf_id_pair *idmap)
> > > +                      struct bpf_idmap *idmap)
> > >  {
> > >         return memcmp(rold, rcur, offsetof(struct bpf_reg_state, id))=
 =3D=3D 0 &&
> > >                check_ids(rold->id, rcur->id, idmap) &&
> > >                check_ids(rold->ref_obj_id, rcur->ref_obj_id, idmap);
> > >  }
> > >=20
> >=20
> > [...]
>=20


