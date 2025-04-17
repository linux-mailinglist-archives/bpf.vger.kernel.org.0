Return-Path: <bpf+bounces-56159-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD73DA92BF6
	for <lists+bpf@lfdr.de>; Thu, 17 Apr 2025 21:53:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31CC019E72D5
	for <lists+bpf@lfdr.de>; Thu, 17 Apr 2025 19:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC1F72046AD;
	Thu, 17 Apr 2025 19:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gCs8GDGW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f67.google.com (mail-ed1-f67.google.com [209.85.208.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9C51FF5EC
	for <bpf@vger.kernel.org>; Thu, 17 Apr 2025 19:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744919621; cv=none; b=HtPwPQonbKFyUC64AA3izs4cjrIyBBrL+3hRmJO/RL81cHNhu0wXY+DXFMl9cAHj+vjgZ16Rq83SHxC6nVDDLuZDlArTvVfpFj6MhZXMAgke8FOORWYBRsZ9jbx1ULnmlfDDwb1OWmt3FgrrSoP44kWTNwNSTXhCNy1IHcIG9Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744919621; c=relaxed/simple;
	bh=TzwWoK0R9u+P0/mk3JsGzLqmr9QPNgaRkLlauH9YPfc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oDsZ1ir0p8bCHxPjzsN6LmkMRBo407PuUsiQ99pJmdXahCbHNijC0GkKi/1ym1EVi7q1wEUUDVCh23OIDfjiS6JCDtwc+XluG1HtB4hqO851XBdYyta153FH5jA4NzueKLfQCNjWP0L+3XfGB2/7/2WV2ytKrLy/2vfqRFIHsVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gCs8GDGW; arc=none smtp.client-ip=209.85.208.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f67.google.com with SMTP id 4fb4d7f45d1cf-5efe8d9eb12so1999230a12.1
        for <bpf@vger.kernel.org>; Thu, 17 Apr 2025 12:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744919617; x=1745524417; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xA9lNAA4pvVnGUjE0U8cXUT7G5Q+xBFWYGgaGVSBHrk=;
        b=gCs8GDGW86azUPUtsIs2y2uPz0RZ/PoriAAdTQ9yUFWQeXBiuR18gDaLheFrpKIN9C
         q9qUI1j+1MXJAkGqqKJ2pyQZ9BSD+l5lFYXtg9z1L8h5OiFvmJc1S40ovd1zYC2qS4y3
         3BphROHg9Y9AM3Ajv0Pfed103LD39TjVfM0aU6yTuI1e2VPSawzq4Q/scpQ2m8d2cGsD
         2K7k9jvqlsYqGwYrfu11Gpj2NgetaQ3gRRWjh0O6/I92uY9rziE5xphqSDYXPjj0P1+W
         dYSCUVF4YDvRu2g6Purz2NSp1LAneeulXSy0Qf4q15PtwEfkgj7WKQtH7OZtYkEfCgHQ
         d/vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744919617; x=1745524417;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xA9lNAA4pvVnGUjE0U8cXUT7G5Q+xBFWYGgaGVSBHrk=;
        b=fBkK18Tss40/Xxy/1asa/0aPLfB96m7OjpLCLEbzULbLDRnIEjQhyk2ZeKiSI1oO5J
         5SEyWI+bb6Gtjgb0tRkpvWZYDCnGE5H6m9HKHeOCEH0H6OPL8IA0fNkxXsaAXqpL9vYw
         ajHo78kVOhv/9Ou69UAyv/Vz3382wJkGP8jgJx0m2pcxoou8ozIfugw/U3YRllu7EaWr
         gU+oVMKOw69lo4HinWV+swbq5U8CatEaKakhaCVQul9FgIk30cyBP5u9uC3+7czuMKci
         d/d17ZiRR/yVeBti4rtHWNIL10tsvtYEGDVVTxCGJyWJhKl2FoxfzSlBQayls+sh6pQq
         QDLQ==
X-Gm-Message-State: AOJu0YxT3f6Xi5K/8AgHjNFstWOQunaeAwijyHco0thfa1ajrMunduw2
	S0o8oCESrdE5LBT/Xph595DXOL+s5BRjwkvGIComD73QY1Dhwijg7JcvZ7YWtgrtendlwSNoMKH
	21ko6QkEU2hikSU5VHfjrvoht/lo=
X-Gm-Gg: ASbGnctWDln91qLGuvCj/ouQFoqiwAeUjYtOQVY6UojQVYwQerXcdH940CxM9z/gZDD
	tJaRWb0LlRRdjDAtJgEH3yc05owa+HW0aRfj0iv12Kq3Jvw3KEvkkY1YpCu+/akOSz2sUuBBAsK
	0tOTCqTHeM6GyY0VKrbAJFRDs1VwsTSBNrqeIZvcey1I8=
X-Google-Smtp-Source: AGHT+IGBjiAno1LueEPcJnLv+KgCiegD6S0xDCzqjgTEm2K4ymke2oxdVGyajN6QOLKArah93JvvnSi5K0cNuJCdgqI=
X-Received: by 2002:a17:907:9712:b0:ac2:7f28:684e with SMTP id
 a640c23a62f3a-acb74ad7dcemr12372166b.6.1744919617041; Thu, 17 Apr 2025
 12:53:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250414161443.1146103-1-memxor@gmail.com> <20250414161443.1146103-2-memxor@gmail.com>
 <CAMB2axMcgN6_6=jYMSLRO2E_RzJdJe48E2Uy-QBQTFS-XkQ8-g@mail.gmail.com>
In-Reply-To: <CAMB2axMcgN6_6=jYMSLRO2E_RzJdJe48E2Uy-QBQTFS-XkQ8-g@mail.gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Thu, 17 Apr 2025 21:53:00 +0200
X-Gm-Features: ATxdqUHJZPJI9jlhmsgBrMTOmyX4bvb7L12BsstBQP_UO4q9SoqtyYeejLVH5wU
Message-ID: <CAP01T77B0vQr47dZB-+MsCK4ZGT=v66z25h4w_rxpk6Yd+v-iQ@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next/net v1 01/13] bpf: Tie dynptrs to referenced
 source objects
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Barret Rhoden <brho@google.com>, kkd@meta.com, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 14 Apr 2025 at 21:58, Amery Hung <ameryhung@gmail.com> wrote:
>
> On Mon, Apr 14, 2025 at 9:14=E2=80=AFAM Kumar Kartikeya Dwivedi
> <memxor@gmail.com> wrote:
> >
> > Ensure that for dynptr constructors (MEM_UNINIT arg_type) taking a
> > referenced object (ref_obj_id) as their memory source, we set the
> > ref_obj_id of the dynptr appropriately as well. This allows us to
> > tie the lifetime of the dynptr to its source and properly invalidate
> > it when the source object is released.
> >
> > For helpers, we don't have such cases yet as bpf_dynptr_from_mem is
> > not permitted for anything other than PTR_TO_MAP_VALUE, but still pass
> > meta->ref_obj_id as clone_ref_obj_id in case this is relaxed in future.
> > Since they are ossified we know dynptr_from_mem is the only relevant
> > helper and takes one memory argument, so we know the meta->ref_obj_id i=
f
> > non-zero will belong to it.
> >
> > For kfuncs, make sure for constructors, only 1 ref_obj_id argument is
> > seen, as more than one can be ambiguous in terms of ref_obj_id transfer=
.
> > Since more kfuncs can be added with possibly multiple memory arguments,
> > make sure meta->ref_obj_id reassignment won't cause incorrect lifetime
> > analysis in the future using ref_obj_cnt logic.  Set this ref_obj_id as
> > the clone_ref_obj_id, so that it is transferred to the spilled_ptr stac=
k
> > slot register state.
> >
> > Add support to unmark_stack_slots_dynptr to not descend to its child
> > slices (using bool slice parameter) so that we don't have circular call=
s
> > when invoking release_reference. With this logic in place, we may have
> > the following object relationships:
> >                                      +-- slice 1 (ref=3D1)
> >  source (ref=3D1) --> dynptr (ref=3D1) --|-- slice 2 (ref=3D1)
> >                                      +-- slice 3 (ref=3D1)
> >
> > Destroying dynptr prunes the dynptr and all its children slices, but
> > does not affect the source. Releasing the source will effectively prune
> > the entire ownership tree. Dynptr clones with same ref=3D1 will be
> > parallel in the ownership tree.
> >
> >                   +-- orig  dptr (ref=3D1) --> slice 1 (ref=3D1)
> >  source (ref=3D1) --|-- clone dptr (ref=3D1) --> slice 2 (ref=3D1)
> >                   +-- clone dptr (ref=3D1) --> slice 3 (ref=3D1)
> >
> > In such a case, only child slices of the dynptr clone being destroyed
> > are invalidated. Likewise, if the source object goes away, the whole
> > tree ends up getting pruned.
> >
> > Cc: Amery Hung <ameryhung@gmail.com>
> > Fixes: 81bb1c2c3e8e ("bpf: net_sched: Add basic bpf qdisc kfuncs")
> > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > ---
> >  kernel/bpf/verifier.c | 81 ++++++++++++++++++++++++++++---------------
> >  1 file changed, 54 insertions(+), 27 deletions(-)
> >
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 54c6953a8b84..a62dfab9aea6 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -198,7 +198,7 @@ struct bpf_verifier_stack_elem {
> >
> >  static int acquire_reference(struct bpf_verifier_env *env, int insn_id=
x);
> >  static int release_reference_nomark(struct bpf_verifier_state *state, =
int ref_obj_id);
> > -static int release_reference(struct bpf_verifier_env *env, int ref_obj=
_id);
> > +static int release_reference(struct bpf_verifier_env *env, int ref_obj=
_id, bool objects);
> >  static void invalidate_non_owning_refs(struct bpf_verifier_env *env);
> >  static bool in_rbtree_lock_required_cb(struct bpf_verifier_env *env);
> >  static int ref_set_non_owning(struct bpf_verifier_env *env,
> > @@ -299,6 +299,7 @@ struct bpf_kfunc_call_arg_meta {
> >         const char *func_name;
> >         /* Out parameters */
> >         u32 ref_obj_id;
> > +       u32 ref_obj_cnt;
> >         u8 release_regno;
> >         bool r0_rdonly;
> >         u32 ret_btf_id;
> > @@ -759,7 +760,7 @@ static int mark_stack_slots_dynptr(struct bpf_verif=
ier_env *env, struct bpf_reg_
> >         mark_dynptr_stack_regs(env, &state->stack[spi].spilled_ptr,
> >                                &state->stack[spi - 1].spilled_ptr, type=
);
> >
> > -       if (dynptr_type_refcounted(type)) {
> > +       if (dynptr_type_refcounted(type) || clone_ref_obj_id) {
> >                 /* The id is used to track proper releasing */
> >                 int id;
> >
> > @@ -818,22 +819,19 @@ static void invalidate_dynptr(struct bpf_verifier=
_env *env, struct bpf_func_stat
> >         state->stack[spi - 1].spilled_ptr.live |=3D REG_LIVE_WRITTEN;
> >  }
> >
> > -static int unmark_stack_slots_dynptr(struct bpf_verifier_env *env, str=
uct bpf_reg_state *reg)
> > +static int __unmark_stack_slots_dynptr(struct bpf_verifier_env *env, s=
truct bpf_func_state *state,
> > +                                      int spi, bool slice)
> >  {
> > -       struct bpf_func_state *state =3D func(env, reg);
> > -       int spi, ref_obj_id, i;
> > +       u32 ref_obj_id;
> > +       int i;
> >
> > -       spi =3D dynptr_get_spi(env, reg);
> > -       if (spi < 0)
> > -               return spi;
> > +       ref_obj_id =3D state->stack[spi].spilled_ptr.ref_obj_id;
> >
> > -       if (!dynptr_type_refcounted(state->stack[spi].spilled_ptr.dynpt=
r.type)) {
> > +       if (!dynptr_type_refcounted(state->stack[spi].spilled_ptr.dynpt=
r.type) && !ref_obj_id) {
> >                 invalidate_dynptr(env, state, spi);
> >                 return 0;
> >         }
> >
> > -       ref_obj_id =3D state->stack[spi].spilled_ptr.ref_obj_id;
> > -
> >         /* If the dynptr has a ref_obj_id, then we need to invalidate
> >          * two things:
> >          *
> > @@ -842,7 +840,8 @@ static int unmark_stack_slots_dynptr(struct bpf_ver=
ifier_env *env, struct bpf_re
> >          */
> >
> >         /* Invalidate any slices associated with this dynptr */
> > -       WARN_ON_ONCE(release_reference(env, ref_obj_id));
> > +       if (slice)
> > +               WARN_ON_ONCE(release_reference(env, ref_obj_id, false))=
;
>
> I think the slice argument might not be needed if we do the following ins=
tead:
>         if (dynptr_type_refcounted(state->stack[spi].spilled_ptr.dynptr.t=
ype))
>                 WARN_ON_ONCE(release_reference(env, ref_obj_id, false));
>
> When bpf_kfree_skb():
>     -> release_reference(..., object =3D true)
>       -> __unmark_stack_slots_dynptr()
>         -> not calling into release_reference() since
> dynptr_type_refcounted() returns false
>
> When bpf_ringbuf_submit():
>     -> unmark_stack_slots_dynptr()
>       -> release_reference(..., object =3D false)
>         -> not calling __unmark_stack_slots_dynptr() since object =3D=3D =
false
>
> Am I missing anything?

That is true, I will probably try to rework it the way Andrii suggested.

>
> >
> >         /* Invalidate any dynptr clones */
> >         for (i =3D 1; i < state->allocated_stack / BPF_REG_SIZE; i++) {
> > @@ -864,6 +863,18 @@ static int unmark_stack_slots_dynptr(struct bpf_ve=
rifier_env *env, struct bpf_re
> >         return 0;
> >  }
> >
> > +static int unmark_stack_slots_dynptr(struct bpf_verifier_env *env, str=
uct bpf_reg_state *reg, bool slice)
> > +{
> > +       struct bpf_func_state *state =3D func(env, reg);
> > +       int spi;
> > +
> > +       spi =3D dynptr_get_spi(env, reg);
> > +       if (spi < 0)
> > +               return spi;
> > +
> > +       return __unmark_stack_slots_dynptr(env, state, spi, slice);
> > +}
> > +
> >  static void __mark_reg_unknown(const struct bpf_verifier_env *env,
> >                                struct bpf_reg_state *reg);
> >
> > @@ -1075,7 +1086,7 @@ static int unmark_stack_slots_iter(struct bpf_ver=
ifier_env *env,
> >                 struct bpf_reg_state *st =3D &slot->spilled_ptr;
> >
> >                 if (i =3D=3D 0)
> > -                       WARN_ON_ONCE(release_reference(env, st->ref_obj=
_id));
> > +                       WARN_ON_ONCE(release_reference(env, st->ref_obj=
_id, false));
> >
> >                 __mark_reg_not_init(env, st);
> >
> > @@ -9749,7 +9760,7 @@ static int check_func_arg(struct bpf_verifier_env=
 *env, u32 arg,
> >                                          true, meta);
> >                 break;
> >         case ARG_PTR_TO_DYNPTR:
> > -               err =3D process_dynptr_func(env, regno, insn_idx, arg_t=
ype, 0);
> > +               err =3D process_dynptr_func(env, regno, insn_idx, arg_t=
ype, meta->ref_obj_id);
> >                 if (err)
> >                         return err;
> >                 break;
> > @@ -10220,12 +10231,12 @@ static int release_reference_nomark(struct bp=
f_verifier_state *state, int ref_ob
> >   *
> >   * This is the release function corresponding to acquire_reference(). =
Idempotent.
> >   */
> > -static int release_reference(struct bpf_verifier_env *env, int ref_obj=
_id)
> > +static int release_reference(struct bpf_verifier_env *env, int ref_obj=
_id, bool objects)
> >  {
> >         struct bpf_verifier_state *vstate =3D env->cur_state;
> >         struct bpf_func_state *state;
> >         struct bpf_reg_state *reg;
> > -       int err;
> > +       int err, spi;
> >
> >         err =3D release_reference_nomark(vstate, ref_obj_id);
> >         if (err)
> > @@ -10236,6 +10247,19 @@ static int release_reference(struct bpf_verifi=
er_env *env, int ref_obj_id)
> >                         mark_reg_invalid(env, reg);
> >         }));
> >
> > +       if (!objects)
> > +               return 0;
> > +
> > +       bpf_for_each_spilled_reg(spi, state, reg, (1 << STACK_DYNPTR)) =
{
> > +               if (!reg)
> > +                       continue;
> > +               if (!reg->dynptr.first_slot || reg->ref_obj_id !=3D ref=
_obj_id)
> > +                       continue;
> > +               err =3D __unmark_stack_slots_dynptr(env, state, spi, fa=
lse);
> > +               if (err)
> > +                       return err;
> > +       }
> > +
> >         return 0;
> >  }
> >
> > @@ -11357,7 +11381,7 @@ static int check_helper_call(struct bpf_verifie=
r_env *env, struct bpf_insn *insn
> >                                 verbose(env, "verifier internal error: =
CONST_PTR_TO_DYNPTR cannot be released\n");
> >                                 return -EFAULT;
> >                         }
> > -                       err =3D unmark_stack_slots_dynptr(env, &regs[me=
ta.release_regno]);
> > +                       err =3D unmark_stack_slots_dynptr(env, &regs[me=
ta.release_regno], true);
> >                 } else if (func_id =3D=3D BPF_FUNC_kptr_xchg && meta.re=
f_obj_id) {
> >                         u32 ref_obj_id =3D meta.ref_obj_id;
> >                         bool in_rcu =3D in_rcu_cs(env);
> > @@ -11379,7 +11403,7 @@ static int check_helper_call(struct bpf_verifie=
r_env *env, struct bpf_insn *insn
> >                                 }));
> >                         }
> >                 } else if (meta.ref_obj_id) {
> > -                       err =3D release_reference(env, meta.ref_obj_id)=
;
> > +                       err =3D release_reference(env, meta.ref_obj_id,=
 true);
> >                 } else if (register_is_null(&regs[meta.release_regno]))=
 {
> >                         /* meta.ref_obj_id can only be 0 if register th=
at is meant to be
> >                          * released is NULL, which must be > R0.
> > @@ -12974,6 +12998,7 @@ static int check_kfunc_args(struct bpf_verifier=
_env *env, struct bpf_kfunc_call_
> >                         meta->ref_obj_id =3D reg->ref_obj_id;
> >                         if (is_kfunc_release(meta))
> >                                 meta->release_regno =3D regno;
> > +                       meta->ref_obj_cnt++;
>
> Does it make sense to convert other "more than one arg with
> ref_obj_id" checks to using ref_obj_cnt to make it more consistent?

Ack, will change.

>
> Thanks for fixing the bug!
> Amery
>
> >                 }
> >
> >                 ref_t =3D btf_type_skip_modifiers(btf, t->type, &ref_id=
);
> > @@ -13100,13 +13125,19 @@ static int check_kfunc_args(struct bpf_verifi=
er_env *env, struct bpf_kfunc_call_
> >                 case KF_ARG_PTR_TO_DYNPTR:
> >                 {
> >                         enum bpf_arg_type dynptr_arg_type =3D ARG_PTR_T=
O_DYNPTR;
> > -                       int clone_ref_obj_id =3D 0;
> > +                       int clone_ref_obj_id =3D meta->ref_obj_id;
> >
> >                         if (reg->type =3D=3D CONST_PTR_TO_DYNPTR)
> >                                 dynptr_arg_type |=3D MEM_RDONLY;
> >
> > -                       if (is_kfunc_arg_uninit(btf, &args[i]))
> > +                       if (is_kfunc_arg_uninit(btf, &args[i])) {
> >                                 dynptr_arg_type |=3D MEM_UNINIT;
> > +                               /* It's confusing if dynptr constructor=
 takes multiple referenced arguments. */
> > +                               if (meta->ref_obj_cnt > 1) {
> > +                                       verbose(env, "verifier internal=
 error: multiple referenced arguments\n");
> > +                                       return -EFAULT;
> > +                               }
> > +                       }
> >
> >                         if (meta->func_id =3D=3D special_kfunc_list[KF_=
bpf_dynptr_from_skb]) {
> >                                 dynptr_arg_type |=3D DYNPTR_TYPE_SKB;
> > @@ -13582,7 +13613,7 @@ static int check_kfunc_call(struct bpf_verifier=
_env *env, struct bpf_insn *insn,
> >          * PTR_TO_BTF_ID in bpf_kfunc_arg_meta, do the release now.
> >          */
> >         if (meta.release_regno) {
> > -               err =3D release_reference(env, regs[meta.release_regno]=
.ref_obj_id);
> > +               err =3D release_reference(env, regs[meta.release_regno]=
.ref_obj_id, true);
> >                 if (err) {
> >                         verbose(env, "kfunc %s#%d reference has not bee=
n acquired before\n",
> >                                 func_name, meta.func_id);
> > @@ -13603,7 +13634,7 @@ static int check_kfunc_call(struct bpf_verifier=
_env *env, struct bpf_insn *insn,
> >                         return err;
> >                 }
> >
> > -               err =3D release_reference(env, release_ref_obj_id);
> > +               err =3D release_reference(env, release_ref_obj_id, true=
);
> >                 if (err) {
> >                         verbose(env, "kfunc %s#%d reference has not bee=
n acquired before\n",
> >                                 func_name, meta.func_id);
> > @@ -13803,11 +13834,7 @@ static int check_kfunc_call(struct bpf_verifie=
r_env *env, struct bpf_insn *insn,
> >                                         return -EFAULT;
> >                                 }
> >                                 regs[BPF_REG_0].dynptr_id =3D meta.init=
ialized_dynptr.id;
> > -
> > -                               /* we don't need to set BPF_REG_0's ref=
 obj id
> > -                                * because packet slices are not refcou=
nted (see
> > -                                * dynptr_type_refcounted)
> > -                                */
> > +                               regs[BPF_REG_0].ref_obj_id =3D meta.ini=
tialized_dynptr.ref_obj_id;
> >                         } else {
> >                                 verbose(env, "kernel function %s unhand=
led dynamic return type\n",
> >                                         meta.func_name);
> > --
> > 2.47.1
> >

