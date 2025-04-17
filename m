Return-Path: <bpf+bounces-56157-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F3F25A92BF4
	for <lists+bpf@lfdr.de>; Thu, 17 Apr 2025 21:52:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 513D519E72DC
	for <lists+bpf@lfdr.de>; Thu, 17 Apr 2025 19:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25BAF1FFC4F;
	Thu, 17 Apr 2025 19:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YDDyHiIK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f67.google.com (mail-ej1-f67.google.com [209.85.218.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2036C8F0
	for <bpf@vger.kernel.org>; Thu, 17 Apr 2025 19:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744919553; cv=none; b=G47X5cUt1yfjFtZg70ciF3Xq1hXE4h6+BA1TfHlKAWg+dw1SsH1/FpisKh0fpOro0ao9CtkDH06Iwu7+MvYtrVxLDxTsfvRMa8Ax58n4Pk8iOtczb9KGgjr+GgPV/fE4K6W+BN4AHDKlDR+rfkl2jGk808aY+7vhbqkfCC7ZhGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744919553; c=relaxed/simple;
	bh=5/d631wg6XAp5s5D3OHQAd0whgRV6IqCvWPY0QozckE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LhwvfHF51UBI3mKgyDeOcy9c0pxmeE69VgkXTpLGDoAdqFNoiWscWMnJOMux7YkBL3NFc70V1v9Ucb9ox70zODwAj/g4hfM/stmhIsIHX3YnEDUK8fm3PAgi4LAEPEjOJVYsV5oaJGxgWlbmNRlUTEaQgCzTT+7qfQve7ghpVXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YDDyHiIK; arc=none smtp.client-ip=209.85.218.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f67.google.com with SMTP id a640c23a62f3a-ac2c663a3daso210966066b.2
        for <bpf@vger.kernel.org>; Thu, 17 Apr 2025 12:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744919550; x=1745524350; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qr9W4LWtZ/nqYNL5QKq9wkALxy7mKjgS2x/Vg0SL7K8=;
        b=YDDyHiIK791X2cqb4md6Iz9uRDxyxP8tUz9mxqvTC00dwPyl3RPSRwshB+RCJMjX+P
         tQuj26CA00lsKQKMWQD1HvXQAEZfAngYKfuSchmpSmm8KyhmeczzFxnD3TXZQ5t+1T27
         BmEyOPoWg8guQpujDPp/rjkC0BEywYDy60zqDgkodtK/Epzp2ukFKkm3gfFS20MMKFm5
         GJ1sRxdXWpkeBqLywuAW7c3YL2J3k0FU/OlhijC9hBGbFRKbuB1/6NqxM1HyI+qWge35
         IJdnZ93KTKd3Hbrlo0PTl1yJZYPHYN9hWQGz4zHIlCYBc4DumVxECIvr19PCMu4FQXo+
         Q0Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744919550; x=1745524350;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qr9W4LWtZ/nqYNL5QKq9wkALxy7mKjgS2x/Vg0SL7K8=;
        b=Rb7bNLMUyd5hsE9j4ckwlHfov7fymThSXOWKzqBS01KNChEWvg3ymPwPdk5xw372mL
         ft3MGT/O1DnoyPLXitJNQD7BytICy/yHYE4m1E33JWkwtxdQhvlnO3fu6YNpoBxsisbp
         x2k6fvUNo0xkgSnAekQCs82XsCE1e2dV+ItugqWMjpDVQVXoLRE//m50MryQ/Y3mO+d0
         +OhI16wIq5+FzMwrVu82UM0PXFExTJ7RniHO3JhaireyeLv371C3GbFtYmyJ41F5Setz
         X3CCHA6BkZ6TOwRIqrkYCgDFO0Iz8uqdRcXcB2nnGrrhN9+Dq7L9tcyuo4thYI1ZmjII
         FOrQ==
X-Gm-Message-State: AOJu0Yykmk7mHOUzEO72FzxT9iIznSOV39iCdU1ejDJvZVURv4xZucgz
	7x+oX0VXlmypxPxLUzjs7JCWMNyKWLSzRec5x4tjtjXyzyB9NFKUpQ5BhtMvY0e4lWcMf5FyTgZ
	yLlHibnYdR4+dLwQEoSR8sJkKXSI=
X-Gm-Gg: ASbGncvYelhladgR4qxzFuowL+pbK4PdLKyUkT+1TzrHr8iYboEz7iKzNKdCxkMby7u
	uMUQ0R+8NhsBhxfNExpx4g6rI4rjn5sZ7nCYVbXgJPhL5UmE07WA0OoFSdArbn4fItE+4KhHDyk
	BHz+SF9uBjVV1sfO4x2Uy/Mk0OMInCKJPxUotW2lm51vFGRh5nhtQgtQ==
X-Google-Smtp-Source: AGHT+IGMoDsEpMh+y24/3cN5M4cxVlTBCMdDKrXdmkL88feoJJve3wVDb1P2hSRHWJXxMM+oGfxNcfOLPu2hgrYxHZ8=
X-Received: by 2002:a17:907:a48:b0:ac7:e366:1eab with SMTP id
 a640c23a62f3a-acb74dee3b8mr9377166b.48.1744919549550; Thu, 17 Apr 2025
 12:52:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250414161443.1146103-1-memxor@gmail.com> <20250414161443.1146103-2-memxor@gmail.com>
 <CAEf4Bza84ANnQPKJSPwr8d2v50DwWGyuScoPmcv_GNRH_7sG2w@mail.gmail.com>
In-Reply-To: <CAEf4Bza84ANnQPKJSPwr8d2v50DwWGyuScoPmcv_GNRH_7sG2w@mail.gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Thu, 17 Apr 2025 21:51:53 +0200
X-Gm-Features: ATxdqUFrtLJRN6wLoC1NjxD8zWLKY6xRgvsgIR5UeJgNYFy_ycN85SvLfOpSSko
Message-ID: <CAP01T75cMUqZYqpgp7cs_5vro13_tMYehgv7nk1UeKqcrceZNA@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next/net v1 01/13] bpf: Tie dynptrs to referenced
 source objects
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, Amery Hung <ameryhung@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Barret Rhoden <brho@google.com>, kkd@meta.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 16 Apr 2025 at 23:04, Andrii Nakryiko <andrii.nakryiko@gmail.com> w=
rote:
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
>
> it would be a bug to have both conditions true, right? Should we
> express this a bit more explicitly?
> maybe something like
>
> int id =3D 0;
>
> if (dynptr_type_refcounted(type)) {
>     WARN_ON_ONCE(clone_ref_obj_id);
>     id =3D acquire_reference(env, insn_idx);
> }
> if (clone_ref_obj_id)
>     id =3D clone_ref_obj_id;
>
> state->stack[spi].spilled_ptr.ref_obj_id =3D id;
> state->stack[spi - 1].spilled_ptr.ref_obj_id =3D id;
> state->stack[spi].spilled_ptr.live |=3D REG_LIVE_WRITTEN;
> state->stack[spi - 1].spilled_ptr.live |=3D REG_LIVE_WRITTEN;
>
> ?

Yes.

>
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
>
> Eduard already pointed out that `!ref_obj_id` condition is enough now

Ack, will change.

>
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
> tbh, this bool flag to release_reference to prevent cycles feels like
> a hack and that we are not solving this properly...
>
> also, changes in this patch still won't properly support the case
> where we create dynptr -> slice -> dynptr -> slice -> ... chains,
> right? Any dynptr in the chain will cause "release" of any other
> dynptr, including parents, right?
>

If they share the same ref_obj_id, yes.
Also, can we construct dynptr from referenced slices? I don't think
anything except map values work right now.
In the chain example, how will we invalidate a dynptr in the later
chain? Like by overwriting it? Just thinking what and how to test
this.
Regardless, it is a valid point.

I can choose to introduce a ref_level so that we can track hierarchies
and only prune things at the same or level below.
Any opinions on how you think this should be done?

> >
> >         /* Invalidate any dynptr clones */
> >         for (i =3D 1; i < state->allocated_stack / BPF_REG_SIZE; i++) {
>
> [...]
>
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
>
> hm, "objects" really doesn't describe anything...
>
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
>
> instead of a bool flag into release_reference, shouldn't the below
> logic be just a separate function?

Yes, that can make it clearer. It may be unnecessary if the function
knows which level of the ownership hierarchy to prune correctly, rn
the flag is partially there because we can call recursively into it
from unmark_stack_slots_dynptr.

>
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
>
> [...]

