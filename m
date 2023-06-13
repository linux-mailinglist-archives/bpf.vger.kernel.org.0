Return-Path: <bpf+bounces-2467-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EC9672D66C
	for <lists+bpf@lfdr.de>; Tue, 13 Jun 2023 02:29:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA12D1C20B1B
	for <lists+bpf@lfdr.de>; Tue, 13 Jun 2023 00:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D4E1136A;
	Tue, 13 Jun 2023 00:29:14 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF968621
	for <bpf@vger.kernel.org>; Tue, 13 Jun 2023 00:29:13 +0000 (UTC)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ACEE91
	for <bpf@vger.kernel.org>; Mon, 12 Jun 2023 17:29:10 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-977c72b116fso747218566b.3
        for <bpf@vger.kernel.org>; Mon, 12 Jun 2023 17:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686616149; x=1689208149;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xfY20+wQEcw0xFVkKKM95S9b9Bm5SJX1ZxUsCPW7yS8=;
        b=aL6BvVCtzWlrHEsi9KSdsY/Fx7FTVjEZ5tIvYQ7/K2ERXMCrLeFqx6zwGhINajk0tx
         sW9OxLzwZ2dUrKCLu7NpFXIpiZh5Ef77Z3z7Hw0oLa729FvuzI+31OQyGo+zoKO7D01C
         5TvJnOc4DZlFUm02OzHaqbrI5MZ08dTrlm8mvKz+k6jT4c+aZG+Ozszy8waJX0OSb4tp
         VOXom6rkfziqdrg0DcppiGGwgWsUYBqk3Dz8SjaLkLYnUZnACons5mHOMfBPlEHqbjmm
         VQ1JVTzbSmNS1Kssv3WYrWcHaA2OZFifgl1EIZTTVqWMf7NDQZAXrBFDPFV3LzUdBKWy
         HaMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686616149; x=1689208149;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xfY20+wQEcw0xFVkKKM95S9b9Bm5SJX1ZxUsCPW7yS8=;
        b=efJ6vXHPNO2B0qjfPueLlF9/apidqKPF/GxCmUh2BLnhzHJAv81b5iuBzqv2uSESEE
         KD13mQMvnCuhlCgzJ9pbpbEDUKe2/Sj8rfoBj12OdOElV4A45p8JCQuztfaNvA4xnFRO
         MKA5ERafYSUrukryUDQeKQydcjeDDuesXhhHuYQtm0jjSY6lz6xuXYRpiRINAIyO+H6I
         7+CHPt8NyxZux9/HcSfxygjqtHWmCHqrl6B01Xyp/5BUIJcBVLIFTDsDZCE0nsx8+2ME
         F3RMlUd50Ybnq7ufTS0SnztPzapv6SaE+/fVH5AzOyZ7nJMi2Ior9VNRizIrsGPvYjKs
         K8hg==
X-Gm-Message-State: AC+VfDxL+VkPkVioDxbg335DyM4qRJ/tdjpmhmj5cWETF9DJa+YIUXP5
	VQQ7Ge92+4IBUn1ViVVASu0gk1Hw/NbxnJn/ZL4=
X-Google-Smtp-Source: ACHHUZ4T9H4BSGPnG8SKZW9FQMDEai7yPiN41QZ2xTznxGojUqB0+mLNbd3R7cldv5IHSkyLrbCr1bHTmcYwlMmV1nU=
X-Received: by 2002:a17:907:869f:b0:973:91a5:bff1 with SMTP id
 qa31-20020a170907869f00b0097391a5bff1mr10258876ejc.68.1686616148641; Mon, 12
 Jun 2023 17:29:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230612160801.2804666-1-eddyz87@gmail.com> <20230612160801.2804666-4-eddyz87@gmail.com>
 <CAEf4BzZLsZ5tMnRdY0rH1-EYH0ooUgkKr082neMtE7jTArVkOQ@mail.gmail.com>
 <f44a65796462fd977c63edbeaee10d4cdc665d73.camel@gmail.com> <256afded9974601228e0cf35866ba6eac0e26199.camel@gmail.com>
In-Reply-To: <256afded9974601228e0cf35866ba6eac0e26199.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 12 Jun 2023 17:28:56 -0700
Message-ID: <CAEf4BzZhmGCTJ=SZHcPHRy0NdAY9WoVKd_Ws6x+n0xE+1OoHzg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 3/4] bpf: verify scalar ids mapping in
 regsafe() using check_ids()
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jun 12, 2023 at 5:10=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Tue, 2023-06-13 at 00:01 +0300, Eduard Zingerman wrote:
> > On Mon, 2023-06-12 at 12:56 -0700, Andrii Nakryiko wrote:
> > > On Mon, Jun 12, 2023 at 9:08=E2=80=AFAM Eduard Zingerman <eddyz87@gma=
il.com> wrote:
> > > >
> > > > Make sure that the following unsafe example is rejected by verifier=
:
> > > >
> > > > 1: r9 =3D ... some pointer with range X ...
> > > > 2: r6 =3D ... unbound scalar ID=3Da ...
> > > > 3: r7 =3D ... unbound scalar ID=3Db ...
> > > > 4: if (r6 > r7) goto +1
> > > > 5: r6 =3D r7
> > > > 6: if (r6 > X) goto ...
> > > > --- checkpoint ---
> > > > 7: r9 +=3D r7
> > > > 8: *(u64 *)r9 =3D Y
> > > >
> > > > This example is unsafe because not all execution paths verify r7 ra=
nge.
> > > > Because of the jump at (4) the verifier would arrive at (6) in two =
states:
> > > > I.  r6{.id=3Db}, r7{.id=3Db} via path 1-6;
> > > > II. r6{.id=3Da}, r7{.id=3Db} via path 1-4, 6.
> > > >
> > > > Currently regsafe() does not call check_ids() for scalar registers,
> > > > thus from POV of regsafe() states (I) and (II) are identical. If th=
e
> > > > path 1-6 is taken by verifier first, and checkpoint is created at (=
6)
> > > > the path [1-4, 6] would be considered safe.
> > > >
> > > > Changes in this commit:
> > > > - Function check_scalar_ids() is added, it differs from check_ids()=
 in
> > > >   the following aspects:
> > > >   - treats ID zero as a unique scalar ID;
> > > >   - disallows mapping same 'cur_id' to multiple 'old_id'.
> > > > - check_scalar_ids() needs to generate temporary unique IDs, field
> > > >   'tmp_id_gen' is added to bpf_verifier_env::idmap_scratch to
> > > >   facilitate this.
> > > > - Function scalar_regs_exact() is added, it differs from regs_exact=
()
> > > >   in the following aspects:
> > > >   - uses check_scalar_ids() for ID comparison;
> > > >   - does not check reg_obj_id as this field is not used for scalar
> > > >     values.
> > > > - regsafe() is updated to:
> > > >   - use check_scalar_ids() for precise scalar registers.
> > > >   - use scalar_regs_exact() for scalar registers, but only for
> > > >     explore_alu_limits branch. This simplifies control flow for sca=
lar
> > > >     case, and has no measurable performance impact.
> > > > - check_alu_op() is updated avoid generating bpf_reg_state::id for
> > > >   constant scalar values when processing BPF_MOV. ID is needed to
> > > >   propagate range information for identical values, but there is
> > > >   nothing to propagate for constants.
> > > >
> > > > Fixes: 75748837b7e5 ("bpf: Propagate scalar ranges through register=
 assignments.")
> > > > Acked-by: Andrii Nakryiko <andrii@kernel.org>
> > > > Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> > > > ---
> > > >  include/linux/bpf_verifier.h |  17 ++++--
> > > >  kernel/bpf/verifier.c        | 108 ++++++++++++++++++++++++++++---=
----
> > > >  2 files changed, 97 insertions(+), 28 deletions(-)
> > > >
> > > > diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verif=
ier.h
> > > > index 73a98f6240fd..042b76fe8e29 100644
> > > > --- a/include/linux/bpf_verifier.h
> > > > +++ b/include/linux/bpf_verifier.h
> > > > @@ -313,11 +313,6 @@ struct bpf_idx_pair {
> > > >         u32 idx;
> > > >  };
> > > >
> > > > -struct bpf_id_pair {
> > > > -       u32 old;
> > > > -       u32 cur;
> > > > -};
> > > > -
> > > >  #define MAX_CALL_FRAMES 8
> > > >  /* Maximum number of register states that can exist at once */
> > > >  #define BPF_ID_MAP_SIZE ((MAX_BPF_REG + MAX_BPF_STACK / BPF_REG_SI=
ZE) * MAX_CALL_FRAMES)
> > > > @@ -559,6 +554,16 @@ struct backtrack_state {
> > > >         u64 stack_masks[MAX_CALL_FRAMES];
> > > >  };
> > > >
> > > > +struct bpf_id_pair {
> > > > +       u32 old;
> > > > +       u32 cur;
> > > > +};
> > > > +
> > > > +struct bpf_idmap {
> > > > +       u32 tmp_id_gen;
> > > > +       struct bpf_id_pair map[BPF_ID_MAP_SIZE];
> > > > +};
> > > > +
> > > >  struct bpf_idset {
> > > >         u32 count;
> > > >         u32 ids[BPF_ID_MAP_SIZE];
> > > > @@ -596,7 +601,7 @@ struct bpf_verifier_env {
> > > >         struct bpf_verifier_log log;
> > > >         struct bpf_subprog_info subprog_info[BPF_MAX_SUBPROGS + 1];
> > > >         union {
> > > > -               struct bpf_id_pair idmap_scratch[BPF_ID_MAP_SIZE];
> > > > +               struct bpf_idmap idmap_scratch;
> > > >                 struct bpf_idset idset_scratch;
> > > >         };
> > > >         struct {
> > > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > > index 9b5f2433194f..b15ebfed207a 100644
> > > > --- a/kernel/bpf/verifier.c
> > > > +++ b/kernel/bpf/verifier.c
> > > > @@ -12942,12 +12942,14 @@ static int check_alu_op(struct bpf_verifi=
er_env *env, struct bpf_insn *insn)
> > > >                 if (BPF_SRC(insn->code) =3D=3D BPF_X) {
> > > >                         struct bpf_reg_state *src_reg =3D regs + in=
sn->src_reg;
> > > >                         struct bpf_reg_state *dst_reg =3D regs + in=
sn->dst_reg;
> > > > +                       bool need_id =3D src_reg->type =3D=3D SCALA=
R_VALUE && !src_reg->id &&
> > > > +                                      !tnum_is_const(src_reg->var_=
off);
> > > >
> > > >                         if (BPF_CLASS(insn->code) =3D=3D BPF_ALU64)=
 {
> > > >                                 /* case: R1 =3D R2
> > > >                                  * copy register state to dest reg
> > > >                                  */
> > > > -                               if (src_reg->type =3D=3D SCALAR_VAL=
UE && !src_reg->id)
> > > > +                               if (need_id)
> > > >                                         /* Assign src and dst regis=
ters the same ID
> > > >                                          * that will be used by fin=
d_equal_scalars()
> > > >                                          * to propagate min/max ran=
ge.
> > > > @@ -12966,7 +12968,7 @@ static int check_alu_op(struct bpf_verifier=
_env *env, struct bpf_insn *insn)
> > > >                                 } else if (src_reg->type =3D=3D SCA=
LAR_VALUE) {
> > > >                                         bool is_src_reg_u32 =3D src=
_reg->umax_value <=3D U32_MAX;
> > > >
> > > > -                                       if (is_src_reg_u32 && !src_=
reg->id)
> > > > +                                       if (is_src_reg_u32 && need_=
id)
> > > >                                                 src_reg->id =3D ++e=
nv->id_gen;
> > > >                                         copy_register_state(dst_reg=
, src_reg);
> > > >                                         /* Make sure ID is cleared =
if src_reg is not in u32 range otherwise
> > > > @@ -15122,8 +15124,9 @@ static bool range_within(struct bpf_reg_sta=
te *old,
> > > >   * So we look through our idmap to see if this old id has been see=
n before.  If
> > > >   * so, we require the new id to match; otherwise, we add the id pa=
ir to the map.
> > > >   */
> > > > -static bool check_ids(u32 old_id, u32 cur_id, struct bpf_id_pair *=
idmap)
> > > > +static bool check_ids(u32 old_id, u32 cur_id, struct bpf_idmap *id=
map)
> > > >  {
> > > > +       struct bpf_id_pair *map =3D idmap->map;
> > > >         unsigned int i;
> > > >
> > > >         /* either both IDs should be set or both should be zero */
> > > > @@ -15134,14 +15137,44 @@ static bool check_ids(u32 old_id, u32 cur=
_id, struct bpf_id_pair *idmap)
> > > >                 return true;
> > > >
> > > >         for (i =3D 0; i < BPF_ID_MAP_SIZE; i++) {
> > > > -               if (!idmap[i].old) {
> > > > +               if (!map[i].old) {
> > > >                         /* Reached an empty slot; haven't seen this=
 id before */
> > > > -                       idmap[i].old =3D old_id;
> > > > -                       idmap[i].cur =3D cur_id;
> > > > +                       map[i].old =3D old_id;
> > > > +                       map[i].cur =3D cur_id;
> > > >                         return true;
> > > >                 }
> > > > -               if (idmap[i].old =3D=3D old_id)
> > > > -                       return idmap[i].cur =3D=3D cur_id;
> > > > +               if (map[i].old =3D=3D old_id)
> > > > +                       return map[i].cur =3D=3D cur_id;
> > > > +       }
> > > > +       /* We ran out of idmap slots, which should be impossible */
> > > > +       WARN_ON_ONCE(1);
> > > > +       return false;
> > > > +}
> > > > +
> > > > +/* Similar to check_ids(), but:
> > > > + * - disallow mapping of different 'old_id' values to same 'cur_id=
' value;
> > > > + * - for zero 'old_id' or 'cur_id' allocate a unique temporary ID
> > > > + *   to allow pairs like '0 vs unique ID', 'unique ID vs 0'.
> > > > + */
> > > > +static bool check_scalar_ids(u32 old_id, u32 cur_id, struct bpf_id=
map *idmap)
> > > > +{
> > > > +       struct bpf_id_pair *map =3D idmap->map;
> > > > +       unsigned int i;
> > > > +
> > > > +       old_id =3D old_id ? old_id : ++idmap->tmp_id_gen;
> > > > +       cur_id =3D cur_id ? cur_id : ++idmap->tmp_id_gen;
> > > > +
> > > > +       for (i =3D 0; i < BPF_ID_MAP_SIZE; i++) {
> > > > +               if (!map[i].old) {
> > > > +                       /* Reached an empty slot; haven't seen this=
 id before */
> > > > +                       map[i].old =3D old_id;
> > > > +                       map[i].cur =3D cur_id;
> > > > +                       return true;
> > > > +               }
> > > > +               if (map[i].old =3D=3D old_id)
> > > > +                       return map[i].cur =3D=3D cur_id;
> > > > +               if (map[i].cur =3D=3D cur_id)
> > > > +                       return false;
> > >
> > > We were discussing w/ Alexei (offline) making these changes as
> > > backportable and minimal as possible, so I looked again how to
> > > minimize all the extra code added.
> > >
> > > I still insist that the current logic in check_ids() is invalid to
> > > allow the same cur_id to map to two different old_ids, especially for
> > > non-SCALAR, actually. E.g., a situation where we have a register that
> > > is auto-invalidated. E.g., bpf_iter element (each gets an ID), or it
> > > could be id'ed dynptr_ringbuf.
> > >
> > > Think about the following situation:
> > >
> > > In the old state, we could have r1.id =3D 1; r2.id =3D 2; Two registe=
rs
> > > keep two separate pointers to ringbuf.
> > >
> > > In the new state, we have r1.id =3D r2.id =3D 3; That is, two registe=
rs
> > > keep the *same* pointer to ringbuf elem.
> > >
> > > Now imagine that a BPF program has bpf_ringbuf_submit(r1) and
> > > invalidates this register. With the old state it will invalidate r1
> > > and will keep r2 valid. So it's safe for the BPF program to keep
> > > working with r2 as valid ringbuf (and eventually submit it as well).
> > >
> > > Now this is entirely unsafe for the new state. Once
> > > bpf_ringbuf_submit(r1) happens, r2 shouldn't be accessed anymore. But
> > > yet it will be declared safe with current check_ids() logic.
> > >
> > > Ergo, check_ids() should make sure we do not have multi-mapping for
> > > any of the IDs. Even if in some corner case that might be ok.
> > >
> > > I actually tested this change with veristat, there are no regressions
> > > at all. I think it's both safe from a perf standpoint, and necessary
> > > and safe from a correctness standpoint.
> > >
> > > So all in all (I did inline scalar_regs_exact in a separate patch, up
> > > to you), I have these changes on top and they all are good from
> > > veristat perspective:
> >
> > Ok, rinbuf is a good example.
> > To minimize the patch-set I'll do the following:
> > - move your check_ids patch to the beginning of the series
> > - add selftest for ringbuf
> > - squash the scalar_regs_exact patch with current patch #3
> >
> > And resubmit with EFAULT fix in patch #1.
> > Thank you for looking into this.
>
> Welp, it turns out it is not possible to create a failing example with
> ringbuf. This is so, because ringbuf objects are tracked in
> bpf_func_state::refs (of type struct bpf_reference_state).
>
> ID of each acquired object is stored in this array and compared in
> func_states_equal() using refsafe() function:
>
>   static bool refsafe(struct bpf_func_state *old, struct bpf_func_state *=
cur,
>                     struct bpf_idmap *idmap)
>   {
>         int i;
>
>         if (old->acquired_refs !=3D cur->acquired_refs)
>                 return false;
>
>         for (i =3D 0; i < old->acquired_refs; i++) {
>                 if (!check_ids(old->refs[i].id, cur->refs[i].id, idmap))
>                         return false;
>         }
>
>         return true;
>   }
>
> Whatever combination of old and current IDs we get in register is
> later checked against full list of acquired IDs.
>
> So far I haven't been able to create a counter-example that shows the
> following snippet is necessary in check_ids():
>
> +               if (map[i].cur =3D=3D cur_id)
> +                       return false;
>
> But this saga has to end somehow :)

ha-ha, yep. I think we should add this check and not rely on some
side-effects of other checks for correctness.

> I'll just squash your patches on top of patch #3, since there are not
> verification performance regressions.

Thanks!

>
> >
> > >
> > > Author: Andrii Nakryiko <andrii@kernel.org>
> > > Date:   Mon Jun 12 12:53:25 2023 -0700
> > >
> > >     bpf: inline scalar_regs_exact
> > >
> > >     Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > >
> > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > index 9d5fefd970a3..c5606613136d 100644
> > > --- a/kernel/bpf/verifier.c
> > > +++ b/kernel/bpf/verifier.c
> > > @@ -15262,14 +15262,6 @@ static bool regs_exact(const struct
> > > bpf_reg_state *rold,
> > >                check_ids(rold->ref_obj_id, rcur->ref_obj_id, idmap);
> > >  }
> > >
> > > -static bool scalar_regs_exact(const struct bpf_reg_state *rold,
> > > -                             const struct bpf_reg_state *rcur,
> > > -                             struct bpf_idmap *idmap)
> > > -{
> > > -       return memcmp(rold, rcur, offsetof(struct bpf_reg_state, id))=
 =3D=3D 0 &&
> > > -              check_scalar_ids(rold->id, rcur->id, idmap);
> > > -}
> > > -
> > >  /* Returns true if (rold safe implies rcur safe) */
> > >  static bool regsafe(struct bpf_verifier_env *env, struct bpf_reg_sta=
te *rold,
> > >                     struct bpf_reg_state *rcur, struct bpf_idmap *idm=
ap)
> > > @@ -15309,8 +15301,13 @@ static bool regsafe(struct bpf_verifier_env
> > > *env, struct bpf_reg_state *rold,
> > >
> > >         switch (base_type(rold->type)) {
> > >         case SCALAR_VALUE:
> > > -               if (env->explore_alu_limits)
> > > -                       return scalar_regs_exact(rold, rcur, idmap);
> > > +               if (env->explore_alu_limits) {
> > > +                       /* explore_alu_limits disables tnum_in() and
> > > range_within()
> > > +                        * logic and requires everything to be strict
> > > +                        */
> > > +                       return memcmp(rold, rcur, offsetof(struct
> > > bpf_reg_state, id)) =3D=3D 0 &&
> > > +                              check_scalar_ids(rold->id, rcur->id, i=
dmap);
> > > +               }
> > >                 if (!rold->precise)
> > >                         return true;
> > >                 /* Why check_ids() for scalar registers?
> > >
> > > commit 57297c01fe747e423cd3c924ef492c0688d8057a
> > > Author: Andrii Nakryiko <andrii@kernel.org>
> > > Date:   Mon Jun 12 11:46:46 2023 -0700
> > >
> > >     bpf: make check_ids disallow multi-mapping of IDs universally
> > >
> > >     Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > >
> > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > index 3da77713d1ca..9d5fefd970a3 100644
> > > --- a/kernel/bpf/verifier.c
> > > +++ b/kernel/bpf/verifier.c
> > > @@ -15137,6 +15137,8 @@ static bool check_ids(u32 old_id, u32 cur_id,
> > > struct bpf_idmap *idmap)
> > >                 }
> > >                 if (map[i].old =3D=3D old_id)
> > >                         return map[i].cur =3D=3D cur_id;
> > > +               if (map[i].cur =3D=3D cur_id)
> > > +                       return false;
> > >         }
> > >         /* We ran out of idmap slots, which should be impossible */
> > >         WARN_ON_ONCE(1);
> > > @@ -15144,33 +15146,15 @@ static bool check_ids(u32 old_id, u32
> > > cur_id, struct bpf_idmap *idmap)
> > >  }
> > >
> > >  /* Similar to check_ids(), but:
> > > - * - disallow mapping of different 'old_id' values to same 'cur_id' =
value;
> > >   * - for zero 'old_id' or 'cur_id' allocate a unique temporary ID
> > >   *   to allow pairs like '0 vs unique ID', 'unique ID vs 0'.
> > >   */
> > >  static bool check_scalar_ids(u32 old_id, u32 cur_id, struct bpf_idma=
p *idmap)
> > >  {
> > > -       struct bpf_id_pair *map =3D idmap->map;
> > > -       unsigned int i;
> > > -
> > >         old_id =3D old_id ? old_id : ++idmap->tmp_id_gen;
> > >         cur_id =3D cur_id ? cur_id : ++idmap->tmp_id_gen;
> > >
> > > -       for (i =3D 0; i < BPF_ID_MAP_SIZE; i++) {
> > > -               if (!map[i].old) {
> > > -                       /* Reached an empty slot; haven't seen this i=
d before */
> > > -                       map[i].old =3D old_id;
> > > -                       map[i].cur =3D cur_id;
> > > -                       return true;
> > > -               }
> > > -               if (map[i].old =3D=3D old_id)
> > > -                       return map[i].cur =3D=3D cur_id;
> > > -               if (map[i].cur =3D=3D cur_id)
> > > -                       return false;
> > > -       }
> > > -       /* We ran out of idmap slots, which should be impossible */
> > > -       WARN_ON_ONCE(1);
> > > -       return false;
> > > +       return check_ids(old_id, cur_id, idmap);
> > >  }
> > >
> > >  static void clean_func_state(struct bpf_verifier_env *env,
> > >
> > >
> > >
> > > >         }
> > > >         /* We ran out of idmap slots, which should be impossible */
> > > >         WARN_ON_ONCE(1);
> > > > @@ -15246,16 +15279,24 @@ static void clean_live_states(struct bpf_=
verifier_env *env, int insn,
> > > >
> > > >  static bool regs_exact(const struct bpf_reg_state *rold,
> > > >                        const struct bpf_reg_state *rcur,
> > > > -                      struct bpf_id_pair *idmap)
> > > > +                      struct bpf_idmap *idmap)
> > > >  {
> > > >         return memcmp(rold, rcur, offsetof(struct bpf_reg_state, id=
)) =3D=3D 0 &&
> > > >                check_ids(rold->id, rcur->id, idmap) &&
> > > >                check_ids(rold->ref_obj_id, rcur->ref_obj_id, idmap)=
;
> > > >  }
> > > >
> > >
> > > [...]
> >
>

