Return-Path: <bpf+bounces-56452-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44FECA97833
	for <lists+bpf@lfdr.de>; Tue, 22 Apr 2025 23:09:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A9A23A7771
	for <lists+bpf@lfdr.de>; Tue, 22 Apr 2025 21:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D33A2DA0F5;
	Tue, 22 Apr 2025 21:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FLUDcCbf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07CE244C63
	for <bpf@vger.kernel.org>; Tue, 22 Apr 2025 21:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745356166; cv=none; b=HSorkUrXFnHFGw68nWwbIkZpCEChkNPgqSJk8jGegaHBSeaUQwoaC4yN4OvjfWwWEs0GwIzOduJpxCvJ3QCaP8bHsrVvhY+Jniro7Xe/bi9+RvxILB/Wkynrqb8YQI27OAHEgLN1pgS6eAihAH9Yc54492NWUyxmcWnfyGoQRWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745356166; c=relaxed/simple;
	bh=eZlyZcj4Sv3WG5seMjK6n4q+kpmZ/Gu5GdP5g8QwnbY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G+35PjtNXjHKIAvvg81ePy/UOiyJ40+IGfaUmxFd+ozVlCFO8CKKxZLFt0XkrxsJmwxvIfFZCeDkeQOxRi7+UPxV4q+7FUyfkoK+w3lnDMIzzZMnR3nxDiwPSX901tN1y/9wVKsDQYvZ8lNEoMz3k7Z1omyoOH7T9HbK0RPqllI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FLUDcCbf; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7376e311086so7935298b3a.3
        for <bpf@vger.kernel.org>; Tue, 22 Apr 2025 14:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745356164; x=1745960964; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mw7X2gsowpzV5F+pO4hLRQjiXKYJOLaSSzyUgYa4wPA=;
        b=FLUDcCbfFWYTI4nXzjxXYQPyPAAWUFcEIi40DIcBhm4NrYL91equ/AUKTrWYCkMcHz
         tfMdJeuuvRd3uPYILAZYj9YmNy9BQB6xuJfkMu/maxZkNt4eZrof73gRlDkBMpDaJtLJ
         VajxuNHFeI0rjsFqbmUr8+6E3ZZNett6o2in3OMDVZ5CSYjXz4vtt+tY558mB8XpqL5F
         zsNZokN7Y+wzkInRHLm2ZXEM/WOg3NNZA3vDT9G71c04yq31yZLpLfWBRF4PgcDOYMsW
         ICbPioSZ322ONkPmpYrH1nzbTrAEIH2LzdfCsz+qlcRpGDGcU2tAJS6v1RwWErOAKx5y
         NfvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745356164; x=1745960964;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mw7X2gsowpzV5F+pO4hLRQjiXKYJOLaSSzyUgYa4wPA=;
        b=ot6QFq7V1PdnjIRdllRa1VYQiDY+O6CkN3bydDFD2fx92W/MYMDzDy48+SYZHA6SoY
         8LvdCkH4Iy4wNMAn2npsEQxmoAE+uc9Zc4H8+Pm4D5Yc+xxUZ3vSiYtkJwOuoq8uuvdn
         7YR5Y7BoArjY3pK62F2SD10UNOIq51X7j6obzoFsPyqKcPN5mflfv8y9DQGeADVKLaRH
         nCZ4zAit2WQ5gBn+eAyWEXnq9NW0wFT+T65kIiEvq44+7Flr9cR9/d0KlLvCbHbtRdDo
         5j6kPROl+W6obn+LgiWLKb5OFvHGAVe9dwSmhteUpMkhtt308TbxKytkEGlu/I6sN9i8
         qkiQ==
X-Gm-Message-State: AOJu0YwS8DVuk8gqdfvGn6Yfwka3TcOt1XO8fAkSes1+XPOhJEngrYuK
	jWrmSy6nF6isTneQmEmDphRmDenc5E6AnaemCEg8nhcgDoDTYSQFougOu3YelkG4T/T5Q2OrkCU
	UGz9hRptYvX102ErML9usZK4wvibYVA==
X-Gm-Gg: ASbGncv+QDh8xsqYLewxHyThRkpAq9fchRb9iDUPZfqbUhGBhy06SJcnSdTzTwZm6sZ
	DFIcZEWCm83WAUKYxCSIOIPSSaQMgGbYzE1dZEtag7Nh4JhC1C0AEfIUOpr4rD+o8ZAH12lDGJI
	XuuwXJ6pcxzi23LmMhJMemy+pTTRhOgGt7/0GSZQ==
X-Google-Smtp-Source: AGHT+IFpKFgSCahb5SkvLgtHISZCrRrMHZmoWFKu2wTwwljO1pUVALZ/SeDsKN2B46b/ENVYaSC4xcqnfkyUsvjW2fg=
X-Received: by 2002:a05:6a00:21c5:b0:736:326a:bb3e with SMTP id
 d2e1a72fcca58-73dc1566a09mr20269207b3a.15.1745356164167; Tue, 22 Apr 2025
 14:09:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250414161443.1146103-1-memxor@gmail.com> <20250414161443.1146103-2-memxor@gmail.com>
 <CAEf4Bza84ANnQPKJSPwr8d2v50DwWGyuScoPmcv_GNRH_7sG2w@mail.gmail.com> <CAP01T75cMUqZYqpgp7cs_5vro13_tMYehgv7nk1UeKqcrceZNA@mail.gmail.com>
In-Reply-To: <CAP01T75cMUqZYqpgp7cs_5vro13_tMYehgv7nk1UeKqcrceZNA@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 22 Apr 2025 14:09:10 -0700
X-Gm-Features: ATxdqUHHiMjwtGyiN7uHBb_bVoZQN4yPKUHYDhv_Tp9h_D5bUAEbfMJz4zIB12Y
Message-ID: <CAEf4BzaRX4qjrAo=OuOD3NwmSWXYUBkJWzTWRHDQ_H8PFGwXhQ@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next/net v1 01/13] bpf: Tie dynptrs to referenced
 source objects
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, Amery Hung <ameryhung@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Barret Rhoden <brho@google.com>, kkd@meta.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 17, 2025 at 12:52=E2=80=AFPM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> On Wed, 16 Apr 2025 at 23:04, Andrii Nakryiko <andrii.nakryiko@gmail.com>=
 wrote:
> >
> > On Mon, Apr 14, 2025 at 9:14=E2=80=AFAM Kumar Kartikeya Dwivedi
> > <memxor@gmail.com> wrote:
> > >
> > > Ensure that for dynptr constructors (MEM_UNINIT arg_type) taking a
> > > referenced object (ref_obj_id) as their memory source, we set the
> > > ref_obj_id of the dynptr appropriately as well. This allows us to
> > > tie the lifetime of the dynptr to its source and properly invalidate
> > > it when the source object is released.
> > >
> > > For helpers, we don't have such cases yet as bpf_dynptr_from_mem is
> > > not permitted for anything other than PTR_TO_MAP_VALUE, but still pas=
s
> > > meta->ref_obj_id as clone_ref_obj_id in case this is relaxed in futur=
e.
> > > Since they are ossified we know dynptr_from_mem is the only relevant
> > > helper and takes one memory argument, so we know the meta->ref_obj_id=
 if
> > > non-zero will belong to it.
> > >
> > > For kfuncs, make sure for constructors, only 1 ref_obj_id argument is
> > > seen, as more than one can be ambiguous in terms of ref_obj_id transf=
er.
> > > Since more kfuncs can be added with possibly multiple memory argument=
s,
> > > make sure meta->ref_obj_id reassignment won't cause incorrect lifetim=
e
> > > analysis in the future using ref_obj_cnt logic.  Set this ref_obj_id =
as
> > > the clone_ref_obj_id, so that it is transferred to the spilled_ptr st=
ack
> > > slot register state.
> > >
> > > Add support to unmark_stack_slots_dynptr to not descend to its child
> > > slices (using bool slice parameter) so that we don't have circular ca=
lls
> > > when invoking release_reference. With this logic in place, we may hav=
e
> > > the following object relationships:
> > >                                      +-- slice 1 (ref=3D1)
> > >  source (ref=3D1) --> dynptr (ref=3D1) --|-- slice 2 (ref=3D1)
> > >                                      +-- slice 3 (ref=3D1)
> > >
> > > Destroying dynptr prunes the dynptr and all its children slices, but
> > > does not affect the source. Releasing the source will effectively pru=
ne
> > > the entire ownership tree. Dynptr clones with same ref=3D1 will be
> > > parallel in the ownership tree.
> > >
> > >                   +-- orig  dptr (ref=3D1) --> slice 1 (ref=3D1)
> > >  source (ref=3D1) --|-- clone dptr (ref=3D1) --> slice 2 (ref=3D1)
> > >                   +-- clone dptr (ref=3D1) --> slice 3 (ref=3D1)
> > >
> > > In such a case, only child slices of the dynptr clone being destroyed
> > > are invalidated. Likewise, if the source object goes away, the whole
> > > tree ends up getting pruned.
> > >
> > > Cc: Amery Hung <ameryhung@gmail.com>
> > > Fixes: 81bb1c2c3e8e ("bpf: net_sched: Add basic bpf qdisc kfuncs")
> > > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > > ---
> > >  kernel/bpf/verifier.c | 81 ++++++++++++++++++++++++++++-------------=
--
> > >  1 file changed, 54 insertions(+), 27 deletions(-)
> > >

[...]

> >
> > >                 invalidate_dynptr(env, state, spi);
> > >                 return 0;
> > >         }
> > >
> > > -       ref_obj_id =3D state->stack[spi].spilled_ptr.ref_obj_id;
> > > -
> > >         /* If the dynptr has a ref_obj_id, then we need to invalidate
> > >          * two things:
> > >          *
> > > @@ -842,7 +840,8 @@ static int unmark_stack_slots_dynptr(struct bpf_v=
erifier_env *env, struct bpf_re
> > >          */
> > >
> > >         /* Invalidate any slices associated with this dynptr */
> > > -       WARN_ON_ONCE(release_reference(env, ref_obj_id));
> > > +       if (slice)
> > > +               WARN_ON_ONCE(release_reference(env, ref_obj_id, false=
));
> >
> > tbh, this bool flag to release_reference to prevent cycles feels like
> > a hack and that we are not solving this properly...
> >
> > also, changes in this patch still won't properly support the case
> > where we create dynptr -> slice -> dynptr -> slice -> ... chains,
> > right? Any dynptr in the chain will cause "release" of any other
> > dynptr, including parents, right?
> >
>
> If they share the same ref_obj_id, yes.
> Also, can we construct dynptr from referenced slices? I don't think
> anything except map values work right now.

Amery wanted to allow creating bpf_dynptr_from_mem() from any
PTR_TO_MEM, which would allow creating ringbuf_dynptr -> slice [ ->
mem_dynptr -> slice ]* chains.

> In the chain example, how will we invalidate a dynptr in the later
> chain? Like by overwriting it? Just thinking what and how to test
> this.

Yes, user can always just write over dynptr slots on the stack, which
doesn't even have to be intentional. mem dynptr is never explicitly
released, so technically you can just stop using it and use that stack
space for some other variables.

> Regardless, it is a valid point.
>
> I can choose to introduce a ref_level so that we can track hierarchies
> and only prune things at the same or level below.
> Any opinions on how you think this should be done?

I was thinking that we can form an (implicit) tree of ref objects
through their id and ref_obj_id properties. Each new dynptr gets its
own id and sets its ref_obj_id to whatever id of the resource we are
creating dynptr from (so if it's a slice, then I guess we'd need to
use slices's ref_obj_id, right?). And so you'd have:

ringbuf_dynptr (id=3D1) -> slice (id=3D2,ref_obj_id=3D1) ->
mem_dynptr(id=3D3,ref_obj_id=3D1) -> slice(id=3D4,**ref_obj_id=3D3**) ->
mem_dynptr(id=3D5,ref_obj_id=3D3)

And so if you overwrite mem_dynptr(id=3D3), then you invalidate
id=3D3,4,5; if you overwrite just mem_dynptr(id=3D5), only that one is
invalidated (and id=3D1,2,3,4 stay valid). If you happen to release the
original ringbuf_dynptr(id=3D1), the entire "tree" is invalidated, of
course.

>
> > >
> > >         /* Invalidate any dynptr clones */
> > >         for (i =3D 1; i < state->allocated_stack / BPF_REG_SIZE; i++)=
 {
> >
> > [...]
> >
> > > @@ -10220,12 +10231,12 @@ static int release_reference_nomark(struct =
bpf_verifier_state *state, int ref_ob
> > >   *
> > >   * This is the release function corresponding to acquire_reference()=
. Idempotent.
> > >   */
> > > -static int release_reference(struct bpf_verifier_env *env, int ref_o=
bj_id)
> > > +static int release_reference(struct bpf_verifier_env *env, int ref_o=
bj_id, bool objects)
> >
> > hm, "objects" really doesn't describe anything...
> >
> > >  {
> > >         struct bpf_verifier_state *vstate =3D env->cur_state;
> > >         struct bpf_func_state *state;
> > >         struct bpf_reg_state *reg;
> > > -       int err;
> > > +       int err, spi;
> > >
> > >         err =3D release_reference_nomark(vstate, ref_obj_id);
> > >         if (err)
> > > @@ -10236,6 +10247,19 @@ static int release_reference(struct bpf_veri=
fier_env *env, int ref_obj_id)
> > >                         mark_reg_invalid(env, reg);
> > >         }));
> > >
> > > +       if (!objects)
> > > +               return 0;
> >
> > instead of a bool flag into release_reference, shouldn't the below
> > logic be just a separate function?
>
> Yes, that can make it clearer. It may be unnecessary if the function
> knows which level of the ownership hierarchy to prune correctly, rn
> the flag is partially there because we can call recursively into it
> from unmark_stack_slots_dynptr.
>
> >
> > > +
> > > +       bpf_for_each_spilled_reg(spi, state, reg, (1 << STACK_DYNPTR)=
) {
> > > +               if (!reg)
> > > +                       continue;
> > > +               if (!reg->dynptr.first_slot || reg->ref_obj_id !=3D r=
ef_obj_id)
> > > +                       continue;
> > > +               err =3D __unmark_stack_slots_dynptr(env, state, spi, =
false);
> > > +               if (err)
> > > +                       return err;
> > > +       }
> > > +
> > >         return 0;
> > >  }
> > >
> >
> > [...]

