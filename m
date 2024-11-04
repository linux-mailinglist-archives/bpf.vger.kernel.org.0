Return-Path: <bpf+bounces-43948-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D5379BBEC9
	for <lists+bpf@lfdr.de>; Mon,  4 Nov 2024 21:27:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 496F6B2134F
	for <lists+bpf@lfdr.de>; Mon,  4 Nov 2024 20:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43CE61E5718;
	Mon,  4 Nov 2024 20:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P0d9/maG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f65.google.com (mail-ed1-f65.google.com [209.85.208.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C20B1E6DCD
	for <bpf@vger.kernel.org>; Mon,  4 Nov 2024 20:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730752036; cv=none; b=OB6n+7op9gYbTCXf7FOzxL06P4q6YKViB+YCINqUZoTma5DrcHIdHTuWw2x1HVZB3LpbZroErb0GLeg/UD11UNeeB6uRlmZmrdn4pxffCBo4u4LZ6Y0K1E+hEPker/qkGYroJkSqTTY/UU01u29deE/9eshfm5lEUKyM0mSCahk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730752036; c=relaxed/simple;
	bh=ZbmVCSP2LLFgJ7tTorE2IfxLlFgY00q7B5lgZEk5Rkg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VZqOqK80je0ElQI2gBZOQIrv3Tjw8xLaMHyYAAJIqP60XHVnciGbtlzmADl8DLCRulowAY6gfjTUpHpBH1zdh8VisSh3/SmB24wfRuel6i8qnKN48vlBXjcTO+LxMAKQPnITCuTlM6jil/HN1EWoZX+80+vR+A2CzDU/EPDt3GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P0d9/maG; arc=none smtp.client-ip=209.85.208.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f65.google.com with SMTP id 4fb4d7f45d1cf-5c984352742so5498064a12.1
        for <bpf@vger.kernel.org>; Mon, 04 Nov 2024 12:27:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730752033; x=1731356833; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wxSarzpg+if7WsT27M5VQmF/VuPHnFVvcc7XtNxK8/Q=;
        b=P0d9/maGSR/4AUNkVtts1wVolp08JZcvD8xhXja3lUYgkfjzlI7S64ECkFCxCK45Ak
         YZpS3+yLSsSGJ3olGoVTEbt1aVaDNPf/mmjx/wa1AaZFxYOz/JnVUbrqDlzUcuT6n5Ut
         LpwGqvu0+uWSXsJroZIgxg+CoAY8w5766YQpiVIoy38IiibusJCzJcfNHDjNm+guuNTb
         I1CR/hbDMLoy85M4shBsWvD+ONJRiZzCJRg1NlO5JRMIY/a8RtnPtZjolWbj1JI+g0a1
         JEPN78Nd1wiomYXWMZRmJeuiIBryOPqIhMPR+uFXI5dT9D0zrMGVeO653OJkV2hYtMCR
         MY0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730752033; x=1731356833;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wxSarzpg+if7WsT27M5VQmF/VuPHnFVvcc7XtNxK8/Q=;
        b=o99kJzjrlVD/EawHLH+5k9wAN+QqkNS/aTvIH+po7rCJDZOJlneF9PLPVWQkbDZHQa
         LFBOShOLX1oWoeJX65zrAGr56l6GJMm1gid8R0YSaHXSfqZ04eXt+1kkzwY1wCO+oEp4
         yCpzUcBt3wWHuH1baxDp9KvWjWiiWzRTGxsLQejM+XlFP/R6a9eB3fPugTTuJoHi4vXU
         e7MUzS8jlWistre0kmbLici9BgUuL2LuOPPDue4PCNZOmMIsveK2Qe1N53WmAyUM735r
         0Ix5En5FNwtIFlo6sd+pn8yngY1NDFKXs8Y9uj3/GQz22FndkU7xJPjk9XBVwRwNGpgj
         A5sw==
X-Gm-Message-State: AOJu0YxUDTiZ5QHlHk39QrDKKuu8EdfqBBzxOeIYRnedBVxwxgLt1scp
	B2Tq/3tPEdfcGGPXTUJZF7c67/Rz5tv7huu3LuU6Jw7NJVUwHUgCTbSQcexccg+0c5iN0Ud9jFk
	YjUFOdxb9bxD/cm/GGBBaGPVH6q8=
X-Google-Smtp-Source: AGHT+IHhLQeLnjdeLMrZvnr3hL0Sxry9vJ44T78wMhljT87++xn8Frlj8bAEvKmLG1en4OarjmDvMH3Nw5MHpaOqNCA=
X-Received: by 2002:a05:6402:390b:b0:5ca:d0c:c2c9 with SMTP id
 4fb4d7f45d1cf-5cbbf8b614cmr26148219a12.19.1730752032386; Mon, 04 Nov 2024
 12:27:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241104151716.2079893-1-memxor@gmail.com> <CAADnVQKufpRn5JXhb14K-WKr5oiz8q711DVQdBCHSuQoCanMDg@mail.gmail.com>
In-Reply-To: <CAADnVQKufpRn5JXhb14K-WKr5oiz8q711DVQdBCHSuQoCanMDg@mail.gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Mon, 4 Nov 2024 14:26:36 -0600
Message-ID: <CAP01T74F6VcKTqO6msucjvTMLiHKjLTXk2u_5bQTBq9oJ0fGTQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3] bpf: Refactor active lock management
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, kkd@meta.com, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 4 Nov 2024 at 13:33, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Nov 4, 2024 at 7:17=E2=80=AFAM Kumar Kartikeya Dwivedi <memxor@gm=
ail.com> wrote:
> >
> > When bpf_spin_lock was introduced originally, there was deliberation on
> > whether to use an array of lock IDs, but since bpf_spin_lock is limited
> > to holding a single lock at any given time, we've been using a single I=
D
> > to identify the held lock.
> >
> > In preparation for introducing spin locks that can be taken multiple
> > times, introduce support for acquiring multiple lock IDs. For this
> > purpose, reuse the acquired_refs array and store both lock and pointer
> > references. We tag the entry with REF_TYPE_PTR or REF_TYPE_BPF_LOCK to
> > disambiguate and find the relevant entry. The ptr field is used to trac=
k
> > the map_ptr or btf (for bpf_obj_new allocations) to ensure locks can be
> > matched with protected fields within the same "allocation", i.e.
> > bpf_obj_new object or map value.
> >
> > The struct active_lock is changed to a boolean as the state is part of
> > the acquired_refs array, and we only need active_lock as a cheap way
> > of detecting lock presence.
> >
> > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > ---
> > Changelog:
> > v2 -> v3
> > v2: https://lore.kernel.org/bpf/20241103212252.547071-1-memxor@gmail.co=
m
> >
> >  * Rebase on bpf-next to resolve merge conflict
> >
> > v1 -> v2
> > v1: https://lore.kernel.org/bpf/20241103205856.345580-1-memxor@gmail.co=
m
> >
> >  * Fix refsafe state comparison to check callback_ref and ptr separatel=
y.
> > ---
> >  include/linux/bpf_verifier.h |  34 ++++++---
> >  kernel/bpf/verifier.c        | 138 ++++++++++++++++++++++++++---------
> >  2 files changed, 126 insertions(+), 46 deletions(-)
> >
> > diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.=
h
> > index 4513372c5bc8..1e7e1803d78b 100644
> > --- a/include/linux/bpf_verifier.h
> > +++ b/include/linux/bpf_verifier.h
> > @@ -266,6 +266,10 @@ struct bpf_stack_state {
> >  };
> >
> >  struct bpf_reference_state {
> > +       /* Each reference object has a type. Ensure REF_TYPE_PTR is zer=
o to
> > +        * default to pointer reference on zero initialization of a sta=
te.
> > +        */
> > +       enum { REF_TYPE_PTR =3D 0, REF_TYPE_BPF_LOCK } type;
>
> In the future commit two more values will be added, right?
> And it may push it over line limit.
> I think cleaner to do each value on separate line:
>   enum ref_state_type {
>     REF_TYPE_PTR =3D 0,
>     REF_TYPE_BPF_LOCK
>   } type;
>
> easier to read and less churn.
> Also name that enum type to use later.
>
> Also I'd drop _BPF_ from the middle.
> Just REF_TYPE_LOCK would do.

We're going to have a different lock type though.
But I can rename it when I add it later.

>
> >         /* Track each reference created with a unique id, even if the s=
ame
> >          * instruction creates the reference multiple times (eg, via CA=
LL).
> >          */
> > @@ -274,17 +278,23 @@ struct bpf_reference_state {
> >          * is used purely to inform the user of a reference leak.
> >          */
> >         int insn_idx;
> > -       /* There can be a case like:
> > -        * main (frame 0)
> > -        *  cb (frame 1)
> > -        *   func (frame 3)
> > -        *    cb (frame 4)
> > -        * Hence for frame 4, if callback_ref just stored boolean, it w=
ould be
> > -        * impossible to distinguish nested callback refs. Hence store =
the
> > -        * frameno and compare that to callback_ref in check_reference_=
leak when
> > -        * exiting a callback function.
> > -        */
> > -       int callback_ref;
> > +       union {
> > +               /* There can be a case like:
> > +                * main (frame 0)
> > +                *  cb (frame 1)
> > +                *   func (frame 3)
> > +                *    cb (frame 4)
> > +                * Hence for frame 4, if callback_ref just stored boole=
an, it would be
> > +                * impossible to distinguish nested callback refs. Henc=
e store the
> > +                * frameno and compare that to callback_ref in check_re=
ference_leak when
> > +                * exiting a callback function.
> > +                */
> > +               int callback_ref;
> > +               /* Use to keep track of the source object of a lock, to=
 ensure
> > +                * it matches on unlock.
> > +                */
> > +               void *ptr;
> > +       };
> >  };
> >
> >  struct bpf_retval_range {
> > @@ -434,7 +444,7 @@ struct bpf_verifier_state {
> >         u32 insn_idx;
> >         u32 curframe;
> >
> > -       struct bpf_active_lock active_lock;
>
> remove struct bpf_active_lock as well.
>

Ack.

> > +       bool active_lock;
>
> In the next patch it becomes 'int',
> so let's make it 'int' right away and move it to bpf_func_state
> next to:
>         int acquired_refs;
>         struct bpf_reference_state *refs;
>
> since it's counting locks in this array.
> 'bool' is just a weird from of 1 or 0.
> So 'int' is cleaner in this patch too.
>

Ack.

> >         bool speculative;
> >         bool active_rcu_lock;
> >         u32 active_preempt_lock;
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index ba800c7611e3..ea8ad320e6cc 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -1335,6 +1335,7 @@ static int acquire_reference_state(struct bpf_ver=
ifier_env *env, int insn_idx)
> >         if (err)
> >                 return err;
> >         id =3D ++env->id_gen;
> > +       state->refs[new_ofs].type =3D REF_TYPE_PTR;
> >         state->refs[new_ofs].id =3D id;
> >         state->refs[new_ofs].insn_idx =3D insn_idx;
> >         state->refs[new_ofs].callback_ref =3D state->in_callback_fn ? s=
tate->frameno : 0;
> > @@ -1342,6 +1343,23 @@ static int acquire_reference_state(struct bpf_ve=
rifier_env *env, int insn_idx)
> >         return id;
> >  }
> >
> > +static int acquire_lock_state(struct bpf_verifier_env *env, int insn_i=
dx, int type, int id, void *ptr)
>
> enum ref_state_type instead of 'int type' ?
>

Ack, but eventually it may require passing OR of flags, which I
believe makes the compiler unhappy.
I can make that change later though.

> > +{
> > +       struct bpf_func_state *state =3D cur_func(env);
> > +       int new_ofs =3D state->acquired_refs;
> > +       int err;
> > +
> > +       err =3D resize_reference_state(state, state->acquired_refs + 1)=
;
> > +       if (err)
> > +               return err;
> > +       state->refs[new_ofs].type =3D type;
> > +       state->refs[new_ofs].id =3D id;
> > +       state->refs[new_ofs].insn_idx =3D insn_idx;
> > +       state->refs[new_ofs].ptr =3D ptr;
> > +
> > +       return 0;
> > +}
> > +
> >  /* release function corresponding to acquire_reference_state(). Idempo=
tent. */
> >  static int release_reference_state(struct bpf_func_state *state, int p=
tr_id)
> >  {
> > @@ -1349,6 +1367,8 @@ static int release_reference_state(struct bpf_fun=
c_state *state, int ptr_id)
> >
> >         last_idx =3D state->acquired_refs - 1;
> >         for (i =3D 0; i < state->acquired_refs; i++) {
> > +               if (state->refs[i].type !=3D REF_TYPE_PTR)
> > +                       continue;
> >                 if (state->refs[i].id =3D=3D ptr_id) {
> >                         /* Cannot release caller references in callback=
s */
> >                         if (state->in_callback_fn && state->refs[i].cal=
lback_ref !=3D state->frameno)
> > @@ -1364,6 +1384,43 @@ static int release_reference_state(struct bpf_fu=
nc_state *state, int ptr_id)
> >         return -EINVAL;
> >  }
> >
> > +static int release_lock_state(struct bpf_func_state *state, int type, =
int id, void *ptr)
> > +{
> > +       int i, last_idx;
> > +
> > +       last_idx =3D state->acquired_refs - 1;
> > +       for (i =3D 0; i < state->acquired_refs; i++) {
> > +               if (state->refs[i].type !=3D type)
> > +                       continue;
> > +               if (state->refs[i].id =3D=3D id && state->refs[i].ptr =
=3D=3D ptr) {
> > +                       if (last_idx && i !=3D last_idx)
> > +                               memcpy(&state->refs[i], &state->refs[la=
st_idx],
> > +                                      sizeof(*state->refs));
> > +                       memset(&state->refs[last_idx], 0, sizeof(*state=
->refs));
> > +                       state->acquired_refs--;
> > +                       return 0;
> > +               }
> > +       }
> > +       return -EINVAL;
> > +}
> > +
> > +static struct bpf_reference_state *find_lock_state(struct bpf_verifier=
_env *env, int id, void *ptr)
> > +{
> > +       struct bpf_func_state *state =3D cur_func(env);
> > +       int i;
> > +
> > +       for (i =3D 0; i < state->acquired_refs; i++) {
> > +               struct bpf_reference_state *s =3D &state->refs[i];
> > +
> > +               if (s->type =3D=3D REF_TYPE_PTR)
> > +                       continue;
>
> Let's pass 'enum ref_state_type type' and compare here
> to make it similar to release_lock_state().
> I think it will clean up future patches too.
>

Ok.

> > +
> > +               if (s->id =3D=3D id && s->ptr =3D=3D ptr)
> > +                       return s;
> > +       }
> > +       return NULL;
> > +}
> > +
> >  static void free_func_state(struct bpf_func_state *state)
> >  {
> >         if (!state)
> > @@ -1430,12 +1487,11 @@ static int copy_verifier_state(struct bpf_verif=
ier_state *dst_state,
> >                 dst_state->frame[i] =3D NULL;
> >         }
> >         dst_state->speculative =3D src->speculative;
> > +       dst_state->active_lock =3D src->active_lock;
> >         dst_state->active_rcu_lock =3D src->active_rcu_lock;
> >         dst_state->active_preempt_lock =3D src->active_preempt_lock;
> >         dst_state->in_sleepable =3D src->in_sleepable;
> >         dst_state->curframe =3D src->curframe;
> > -       dst_state->active_lock.ptr =3D src->active_lock.ptr;
> > -       dst_state->active_lock.id =3D src->active_lock.id;
> >         dst_state->branches =3D src->branches;
> >         dst_state->parent =3D src->parent;
> >         dst_state->first_insn_idx =3D src->first_insn_idx;
> > @@ -5423,7 +5479,7 @@ static bool in_sleepable(struct bpf_verifier_env =
*env)
> >  static bool in_rcu_cs(struct bpf_verifier_env *env)
> >  {
> >         return env->cur_state->active_rcu_lock ||
> > -              env->cur_state->active_lock.ptr ||
> > +              env->cur_state->active_lock ||
> >                !in_sleepable(env);
> >  }
> >
> > @@ -7698,6 +7754,7 @@ static int process_spin_lock(struct bpf_verifier_=
env *env, int regno,
> >         struct bpf_map *map =3D NULL;
> >         struct btf *btf =3D NULL;
> >         struct btf_record *rec;
> > +       int err;
> >
> >         if (!is_const) {
> >                 verbose(env,
> > @@ -7729,16 +7786,27 @@ static int process_spin_lock(struct bpf_verifie=
r_env *env, int regno,
> >                 return -EINVAL;
> >         }
> >         if (is_lock) {
> > -               if (cur->active_lock.ptr) {
> > +               void *ptr;
> > +
> > +               if (map)
> > +                       ptr =3D map;
> > +               else
> > +                       ptr =3D btf;
> > +
> > +               if (cur->active_lock) {
> >                         verbose(env,
> >                                 "Locking two bpf_spin_locks are not all=
owed\n");
> >                         return -EINVAL;
> >                 }
> > -               if (map)
> > -                       cur->active_lock.ptr =3D map;
> > -               else
> > -                       cur->active_lock.ptr =3D btf;
> > -               cur->active_lock.id =3D reg->id;
> > +               err =3D acquire_lock_state(env, env->insn_idx, REF_TYPE=
_BPF_LOCK, reg->id, ptr);
> > +               if (err < 0) {
> > +                       verbose(env, "Failed to acquire lock state\n");
> > +                       return err;
> > +               }
> > +               /* It is not safe to allow multiple bpf_spin_lock calls=
, so
> > +                * disallow them until this lock has been unlocked.
> > +                */
> > +               cur->active_lock =3D true;
> >         } else {
> >                 void *ptr;
> >
> > @@ -7747,20 +7815,18 @@ static int process_spin_lock(struct bpf_verifie=
r_env *env, int regno,
> >                 else
> >                         ptr =3D btf;
> >
> > -               if (!cur->active_lock.ptr) {
> > +               if (!cur->active_lock) {
> >                         verbose(env, "bpf_spin_unlock without taking a =
lock\n");
> >                         return -EINVAL;
> >                 }
> > -               if (cur->active_lock.ptr !=3D ptr ||
> > -                   cur->active_lock.id !=3D reg->id) {
> > +
> > +               if (release_lock_state(cur_func(env), REF_TYPE_BPF_LOCK=
, reg->id, ptr)) {
> >                         verbose(env, "bpf_spin_unlock of different lock=
\n");
> >                         return -EINVAL;
> >                 }
> >
> >                 invalidate_non_owning_refs(env);
> > -
> > -               cur->active_lock.ptr =3D NULL;
> > -               cur->active_lock.id =3D 0;
> > +               cur->active_lock =3D false;
> >         }
> >         return 0;
> >  }
> > @@ -9818,7 +9884,7 @@ static int check_func_call(struct bpf_verifier_en=
v *env, struct bpf_insn *insn,
> >                 const char *sub_name =3D subprog_name(env, subprog);
> >
> >                 /* Only global subprogs cannot be called with a lock he=
ld. */
> > -               if (env->cur_state->active_lock.ptr) {
> > +               if (env->cur_state->active_lock) {
> >                         verbose(env, "global function calls are not all=
owed while holding a lock,\n"
> >                                      "use static function instead\n");
> >                         return -EINVAL;
> > @@ -10343,6 +10409,8 @@ static int check_reference_leak(struct bpf_veri=
fier_env *env, bool exception_exi
> >                 return 0;
> >
> >         for (i =3D 0; i < state->acquired_refs; i++) {
> > +               if (state->refs[i].type !=3D REF_TYPE_PTR)
> > +                       continue;
>
> why ?
> check_reference_leak() should complain about unreleased locks too.
>

I'm trying to change that here. Locks will be checked with the
active_locks counter everywhere, reference types are separate, and
only REF_TYPE_PTR.
Now that we've unified everything in check_resource_leak, it should
not be problematic.

> >                 if (!exception_exit && state->in_callback_fn && state->=
refs[i].callback_ref !=3D state->frameno)
> >                         continue;
> >                 verbose(env, "Unreleased reference id=3D%d alloc_insn=
=3D%d\n",
> > @@ -10356,7 +10424,7 @@ static int check_resource_leak(struct bpf_verif=
ier_env *env, bool exception_exit
> >  {
> >         int err;
> >
> > -       if (check_lock && env->cur_state->active_lock.ptr) {
> > +       if (check_lock && env->cur_state->active_lock) {
> >                 verbose(env, "%s cannot be used inside bpf_spin_lock-ed=
 region\n", prefix);
> >                 return -EINVAL;
> >         }
> > @@ -11580,7 +11648,7 @@ static int ref_set_non_owning(struct bpf_verifi=
er_env *env, struct bpf_reg_state
> >         struct bpf_verifier_state *state =3D env->cur_state;
> >         struct btf_record *rec =3D reg_btf_record(reg);
> >
> > -       if (!state->active_lock.ptr) {
> > +       if (!state->active_lock) {
> >                 verbose(env, "verifier internal error: ref_set_non_owni=
ng w/o active lock\n");
> >                 return -EFAULT;
> >         }
> > @@ -11677,6 +11745,7 @@ static int ref_convert_owning_non_owning(struct=
 bpf_verifier_env *env, u32 ref_o
> >   */
> >  static int check_reg_allocation_locked(struct bpf_verifier_env *env, s=
truct bpf_reg_state *reg)
> >  {
> > +       struct bpf_reference_state *s;
> >         void *ptr;
> >         u32 id;
> >
> > @@ -11693,10 +11762,10 @@ static int check_reg_allocation_locked(struct=
 bpf_verifier_env *env, struct bpf_
> >         }
> >         id =3D reg->id;
> >
> > -       if (!env->cur_state->active_lock.ptr)
> > +       if (!env->cur_state->active_lock)
> >                 return -EINVAL;
> > -       if (env->cur_state->active_lock.ptr !=3D ptr ||
> > -           env->cur_state->active_lock.id !=3D id) {
> > +       s =3D find_lock_state(env, id, ptr);
> > +       if (!s) {
> >                 verbose(env, "held lock and object are not in the same =
allocation\n");
> >                 return -EINVAL;
> >         }
> > @@ -17561,8 +17630,19 @@ static bool refsafe(struct bpf_func_state *old=
, struct bpf_func_state *cur,
> >                 return false;
> >
> >         for (i =3D 0; i < old->acquired_refs; i++) {
> > -               if (!check_ids(old->refs[i].id, cur->refs[i].id, idmap)=
)
> > +               if (!check_ids(old->refs[i].id, cur->refs[i].id, idmap)=
 ||
> > +                   old->refs[i].type !=3D cur->refs[i].type)
> >                         return false;
> > +               switch (old->refs[i].type) {
> > +               case REF_TYPE_PTR:
> > +                       if (old->refs[i].callback_ref !=3D cur->refs[i]=
.callback_ref)
> > +                               return false;
> > +                       break;
> > +               default:
> > +                       if (old->refs[i].ptr !=3D cur->refs[i].ptr)
> > +                               return false;
> > +                       break;
>
> I'd future proof a bit by explicitly handling all enum values
> and WARN_ONCE in default.
>

Ok.

> pw-bot: cr

