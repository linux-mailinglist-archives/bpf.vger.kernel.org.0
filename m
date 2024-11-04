Return-Path: <bpf+bounces-43928-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BAF19BBE0E
	for <lists+bpf@lfdr.de>; Mon,  4 Nov 2024 20:33:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A183EB20BE9
	for <lists+bpf@lfdr.de>; Mon,  4 Nov 2024 19:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72E7D1C3054;
	Mon,  4 Nov 2024 19:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LBp1hRxk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA0716C687
	for <bpf@vger.kernel.org>; Mon,  4 Nov 2024 19:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730748823; cv=none; b=nNoPGWe2om4wbVbGzfSb29b69G+bdktyyFVIXJoJgsUnI6cxNdcaQTWMyI4gwE8WGfVdFanYB8CQxByyKNqcH9dr1ac8PJsjgZ1xK6w6vRyv5tE3laMPsTh1ZkNzeKsnUsJhiQbOdcmblenlpYeIF0YVVlI8HQRn8brA1Q1SpSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730748823; c=relaxed/simple;
	bh=Y/5fpWZRNPx/dp0QJ2yd08IjqS5F84ff/93mdahk+0E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=envxA5pJOfQiY/9c6m0NhHjjPBJ0/NtdN8+JWVjy19at8zn/3p2EDQShAxT9+lNlXPN0gdHhMOnqSM84AA+F9IhK+Izo4NBBrO/02MVqc8BBi8j2izmhzAYVoypRin+gCOl53va5TKivagMq2ghrHM33Q4UjZ4Nivc20Gk9Zm0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LBp1hRxk; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4315eac969aso28716225e9.1
        for <bpf@vger.kernel.org>; Mon, 04 Nov 2024 11:33:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730748819; x=1731353619; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iUqb2O2lkn/Qb3Ka5r8iKJ/IHn3iVr4UEPxxedHLCJQ=;
        b=LBp1hRxkI6JgHQRwC8ygE82vh8DPtJRQnw1qoa0yZQxz7tbmdML4oEqsdan6jEG+YO
         /9WsG0nuHqQyrtv3fnrubojBuF1GgjSwo8ooa34tQdtlLnP1/3FwkESdOXAJ+Zg5B6Kr
         +X6sjDVFkFO3ig74DUaaXOSIZR7Tu7gyNaP3Seuq6mwApYFNBCZJumq7ltJhtOJsslv3
         0S4iPB5HITBzHj4FY8jHkoHxu5V/Slr+tSfxPrws1LvJjg9pPCLu9pxzLH6RWR0ek7ee
         MeUyoxkyMfTiwsOB3idCBimb3kEj/yEAzf1S7D3kTIIrahM7AVH90o8ffY0GHzO1frRG
         JLnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730748819; x=1731353619;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iUqb2O2lkn/Qb3Ka5r8iKJ/IHn3iVr4UEPxxedHLCJQ=;
        b=dW/HcfeO23KL7nZcpcxDWqhYN7gC3sibQ0a9EGOY0OSxWat9lncRQ13H5qItsIL/mR
         9pvPqeWH+EgO0GKINRxAIRlA6PXhdjxINh2jJf9PvQZvSMvwQFyOboJWNbuW+sTNA4w/
         M+L8BJ518QS0Y5OKyyEM7C4B7iQpEgDITV9fFrGPsMBx9k5RbfGg7jQOuvfPnIGc1Yri
         wmYkzrrDyMsjTL4Mizit+IWPGKMCaQj3onvQoSvRJbeCmQg0HQyJhuSd/Cw4npp+FGSv
         Mib3jmfqYJecnSwpbZQxnLUjvfeoVz0BoZfo9KfhToftFgLyqiKfVMDlUbo0oBBkfiFO
         Y4gw==
X-Gm-Message-State: AOJu0Yz0FLpZN2KNVuQ83aHqA8LdWYN1nsFP32QQo0HGMaFa8wctFmI5
	3uBNeBfWfhUUoaZK4WY/hgFzJec4sbABfBSw9XLAXmVraWP8r54jXKvR5NXkcOcAyBN7dtXFsC1
	KO4hnmLZIznGsPvyH/4S38H6Je7Q=
X-Google-Smtp-Source: AGHT+IEcIgpd+234ZcUXYNzQh9OSMEpC9HugLLWmpCB82EMyPmek26rl23qCxrhuJ7PM3O1HytiyP0AlVZl8KQAwsL0=
X-Received: by 2002:a5d:47c5:0:b0:37c:cc7c:761c with SMTP id
 ffacd0b85a97d-381c130731fmr13577435f8f.3.1730748818820; Mon, 04 Nov 2024
 11:33:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241104151716.2079893-1-memxor@gmail.com>
In-Reply-To: <20241104151716.2079893-1-memxor@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 4 Nov 2024 11:33:26 -0800
Message-ID: <CAADnVQKufpRn5JXhb14K-WKr5oiz8q711DVQdBCHSuQoCanMDg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3] bpf: Refactor active lock management
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, kkd@meta.com, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 4, 2024 at 7:17=E2=80=AFAM Kumar Kartikeya Dwivedi <memxor@gmai=
l.com> wrote:
>
> When bpf_spin_lock was introduced originally, there was deliberation on
> whether to use an array of lock IDs, but since bpf_spin_lock is limited
> to holding a single lock at any given time, we've been using a single ID
> to identify the held lock.
>
> In preparation for introducing spin locks that can be taken multiple
> times, introduce support for acquiring multiple lock IDs. For this
> purpose, reuse the acquired_refs array and store both lock and pointer
> references. We tag the entry with REF_TYPE_PTR or REF_TYPE_BPF_LOCK to
> disambiguate and find the relevant entry. The ptr field is used to track
> the map_ptr or btf (for bpf_obj_new allocations) to ensure locks can be
> matched with protected fields within the same "allocation", i.e.
> bpf_obj_new object or map value.
>
> The struct active_lock is changed to a boolean as the state is part of
> the acquired_refs array, and we only need active_lock as a cheap way
> of detecting lock presence.
>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
> Changelog:
> v2 -> v3
> v2: https://lore.kernel.org/bpf/20241103212252.547071-1-memxor@gmail.com
>
>  * Rebase on bpf-next to resolve merge conflict
>
> v1 -> v2
> v1: https://lore.kernel.org/bpf/20241103205856.345580-1-memxor@gmail.com
>
>  * Fix refsafe state comparison to check callback_ref and ptr separately.
> ---
>  include/linux/bpf_verifier.h |  34 ++++++---
>  kernel/bpf/verifier.c        | 138 ++++++++++++++++++++++++++---------
>  2 files changed, 126 insertions(+), 46 deletions(-)
>
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 4513372c5bc8..1e7e1803d78b 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -266,6 +266,10 @@ struct bpf_stack_state {
>  };
>
>  struct bpf_reference_state {
> +       /* Each reference object has a type. Ensure REF_TYPE_PTR is zero =
to
> +        * default to pointer reference on zero initialization of a state=
.
> +        */
> +       enum { REF_TYPE_PTR =3D 0, REF_TYPE_BPF_LOCK } type;

In the future commit two more values will be added, right?
And it may push it over line limit.
I think cleaner to do each value on separate line:
  enum ref_state_type {
    REF_TYPE_PTR =3D 0,
    REF_TYPE_BPF_LOCK
  } type;

easier to read and less churn.
Also name that enum type to use later.

Also I'd drop _BPF_ from the middle.
Just REF_TYPE_LOCK would do.

>         /* Track each reference created with a unique id, even if the sam=
e
>          * instruction creates the reference multiple times (eg, via CALL=
).
>          */
> @@ -274,17 +278,23 @@ struct bpf_reference_state {
>          * is used purely to inform the user of a reference leak.
>          */
>         int insn_idx;
> -       /* There can be a case like:
> -        * main (frame 0)
> -        *  cb (frame 1)
> -        *   func (frame 3)
> -        *    cb (frame 4)
> -        * Hence for frame 4, if callback_ref just stored boolean, it wou=
ld be
> -        * impossible to distinguish nested callback refs. Hence store th=
e
> -        * frameno and compare that to callback_ref in check_reference_le=
ak when
> -        * exiting a callback function.
> -        */
> -       int callback_ref;
> +       union {
> +               /* There can be a case like:
> +                * main (frame 0)
> +                *  cb (frame 1)
> +                *   func (frame 3)
> +                *    cb (frame 4)
> +                * Hence for frame 4, if callback_ref just stored boolean=
, it would be
> +                * impossible to distinguish nested callback refs. Hence =
store the
> +                * frameno and compare that to callback_ref in check_refe=
rence_leak when
> +                * exiting a callback function.
> +                */
> +               int callback_ref;
> +               /* Use to keep track of the source object of a lock, to e=
nsure
> +                * it matches on unlock.
> +                */
> +               void *ptr;
> +       };
>  };
>
>  struct bpf_retval_range {
> @@ -434,7 +444,7 @@ struct bpf_verifier_state {
>         u32 insn_idx;
>         u32 curframe;
>
> -       struct bpf_active_lock active_lock;

remove struct bpf_active_lock as well.

> +       bool active_lock;

In the next patch it becomes 'int',
so let's make it 'int' right away and move it to bpf_func_state
next to:
        int acquired_refs;
        struct bpf_reference_state *refs;

since it's counting locks in this array.
'bool' is just a weird from of 1 or 0.
So 'int' is cleaner in this patch too.

>         bool speculative;
>         bool active_rcu_lock;
>         u32 active_preempt_lock;
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index ba800c7611e3..ea8ad320e6cc 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -1335,6 +1335,7 @@ static int acquire_reference_state(struct bpf_verif=
ier_env *env, int insn_idx)
>         if (err)
>                 return err;
>         id =3D ++env->id_gen;
> +       state->refs[new_ofs].type =3D REF_TYPE_PTR;
>         state->refs[new_ofs].id =3D id;
>         state->refs[new_ofs].insn_idx =3D insn_idx;
>         state->refs[new_ofs].callback_ref =3D state->in_callback_fn ? sta=
te->frameno : 0;
> @@ -1342,6 +1343,23 @@ static int acquire_reference_state(struct bpf_veri=
fier_env *env, int insn_idx)
>         return id;
>  }
>
> +static int acquire_lock_state(struct bpf_verifier_env *env, int insn_idx=
, int type, int id, void *ptr)

enum ref_state_type instead of 'int type' ?

> +{
> +       struct bpf_func_state *state =3D cur_func(env);
> +       int new_ofs =3D state->acquired_refs;
> +       int err;
> +
> +       err =3D resize_reference_state(state, state->acquired_refs + 1);
> +       if (err)
> +               return err;
> +       state->refs[new_ofs].type =3D type;
> +       state->refs[new_ofs].id =3D id;
> +       state->refs[new_ofs].insn_idx =3D insn_idx;
> +       state->refs[new_ofs].ptr =3D ptr;
> +
> +       return 0;
> +}
> +
>  /* release function corresponding to acquire_reference_state(). Idempote=
nt. */
>  static int release_reference_state(struct bpf_func_state *state, int ptr=
_id)
>  {
> @@ -1349,6 +1367,8 @@ static int release_reference_state(struct bpf_func_=
state *state, int ptr_id)
>
>         last_idx =3D state->acquired_refs - 1;
>         for (i =3D 0; i < state->acquired_refs; i++) {
> +               if (state->refs[i].type !=3D REF_TYPE_PTR)
> +                       continue;
>                 if (state->refs[i].id =3D=3D ptr_id) {
>                         /* Cannot release caller references in callbacks =
*/
>                         if (state->in_callback_fn && state->refs[i].callb=
ack_ref !=3D state->frameno)
> @@ -1364,6 +1384,43 @@ static int release_reference_state(struct bpf_func=
_state *state, int ptr_id)
>         return -EINVAL;
>  }
>
> +static int release_lock_state(struct bpf_func_state *state, int type, in=
t id, void *ptr)
> +{
> +       int i, last_idx;
> +
> +       last_idx =3D state->acquired_refs - 1;
> +       for (i =3D 0; i < state->acquired_refs; i++) {
> +               if (state->refs[i].type !=3D type)
> +                       continue;
> +               if (state->refs[i].id =3D=3D id && state->refs[i].ptr =3D=
=3D ptr) {
> +                       if (last_idx && i !=3D last_idx)
> +                               memcpy(&state->refs[i], &state->refs[last=
_idx],
> +                                      sizeof(*state->refs));
> +                       memset(&state->refs[last_idx], 0, sizeof(*state->=
refs));
> +                       state->acquired_refs--;
> +                       return 0;
> +               }
> +       }
> +       return -EINVAL;
> +}
> +
> +static struct bpf_reference_state *find_lock_state(struct bpf_verifier_e=
nv *env, int id, void *ptr)
> +{
> +       struct bpf_func_state *state =3D cur_func(env);
> +       int i;
> +
> +       for (i =3D 0; i < state->acquired_refs; i++) {
> +               struct bpf_reference_state *s =3D &state->refs[i];
> +
> +               if (s->type =3D=3D REF_TYPE_PTR)
> +                       continue;

Let's pass 'enum ref_state_type type' and compare here
to make it similar to release_lock_state().
I think it will clean up future patches too.

> +
> +               if (s->id =3D=3D id && s->ptr =3D=3D ptr)
> +                       return s;
> +       }
> +       return NULL;
> +}
> +
>  static void free_func_state(struct bpf_func_state *state)
>  {
>         if (!state)
> @@ -1430,12 +1487,11 @@ static int copy_verifier_state(struct bpf_verifie=
r_state *dst_state,
>                 dst_state->frame[i] =3D NULL;
>         }
>         dst_state->speculative =3D src->speculative;
> +       dst_state->active_lock =3D src->active_lock;
>         dst_state->active_rcu_lock =3D src->active_rcu_lock;
>         dst_state->active_preempt_lock =3D src->active_preempt_lock;
>         dst_state->in_sleepable =3D src->in_sleepable;
>         dst_state->curframe =3D src->curframe;
> -       dst_state->active_lock.ptr =3D src->active_lock.ptr;
> -       dst_state->active_lock.id =3D src->active_lock.id;
>         dst_state->branches =3D src->branches;
>         dst_state->parent =3D src->parent;
>         dst_state->first_insn_idx =3D src->first_insn_idx;
> @@ -5423,7 +5479,7 @@ static bool in_sleepable(struct bpf_verifier_env *e=
nv)
>  static bool in_rcu_cs(struct bpf_verifier_env *env)
>  {
>         return env->cur_state->active_rcu_lock ||
> -              env->cur_state->active_lock.ptr ||
> +              env->cur_state->active_lock ||
>                !in_sleepable(env);
>  }
>
> @@ -7698,6 +7754,7 @@ static int process_spin_lock(struct bpf_verifier_en=
v *env, int regno,
>         struct bpf_map *map =3D NULL;
>         struct btf *btf =3D NULL;
>         struct btf_record *rec;
> +       int err;
>
>         if (!is_const) {
>                 verbose(env,
> @@ -7729,16 +7786,27 @@ static int process_spin_lock(struct bpf_verifier_=
env *env, int regno,
>                 return -EINVAL;
>         }
>         if (is_lock) {
> -               if (cur->active_lock.ptr) {
> +               void *ptr;
> +
> +               if (map)
> +                       ptr =3D map;
> +               else
> +                       ptr =3D btf;
> +
> +               if (cur->active_lock) {
>                         verbose(env,
>                                 "Locking two bpf_spin_locks are not allow=
ed\n");
>                         return -EINVAL;
>                 }
> -               if (map)
> -                       cur->active_lock.ptr =3D map;
> -               else
> -                       cur->active_lock.ptr =3D btf;
> -               cur->active_lock.id =3D reg->id;
> +               err =3D acquire_lock_state(env, env->insn_idx, REF_TYPE_B=
PF_LOCK, reg->id, ptr);
> +               if (err < 0) {
> +                       verbose(env, "Failed to acquire lock state\n");
> +                       return err;
> +               }
> +               /* It is not safe to allow multiple bpf_spin_lock calls, =
so
> +                * disallow them until this lock has been unlocked.
> +                */
> +               cur->active_lock =3D true;
>         } else {
>                 void *ptr;
>
> @@ -7747,20 +7815,18 @@ static int process_spin_lock(struct bpf_verifier_=
env *env, int regno,
>                 else
>                         ptr =3D btf;
>
> -               if (!cur->active_lock.ptr) {
> +               if (!cur->active_lock) {
>                         verbose(env, "bpf_spin_unlock without taking a lo=
ck\n");
>                         return -EINVAL;
>                 }
> -               if (cur->active_lock.ptr !=3D ptr ||
> -                   cur->active_lock.id !=3D reg->id) {
> +
> +               if (release_lock_state(cur_func(env), REF_TYPE_BPF_LOCK, =
reg->id, ptr)) {
>                         verbose(env, "bpf_spin_unlock of different lock\n=
");
>                         return -EINVAL;
>                 }
>
>                 invalidate_non_owning_refs(env);
> -
> -               cur->active_lock.ptr =3D NULL;
> -               cur->active_lock.id =3D 0;
> +               cur->active_lock =3D false;
>         }
>         return 0;
>  }
> @@ -9818,7 +9884,7 @@ static int check_func_call(struct bpf_verifier_env =
*env, struct bpf_insn *insn,
>                 const char *sub_name =3D subprog_name(env, subprog);
>
>                 /* Only global subprogs cannot be called with a lock held=
. */
> -               if (env->cur_state->active_lock.ptr) {
> +               if (env->cur_state->active_lock) {
>                         verbose(env, "global function calls are not allow=
ed while holding a lock,\n"
>                                      "use static function instead\n");
>                         return -EINVAL;
> @@ -10343,6 +10409,8 @@ static int check_reference_leak(struct bpf_verifi=
er_env *env, bool exception_exi
>                 return 0;
>
>         for (i =3D 0; i < state->acquired_refs; i++) {
> +               if (state->refs[i].type !=3D REF_TYPE_PTR)
> +                       continue;

why ?
check_reference_leak() should complain about unreleased locks too.

>                 if (!exception_exit && state->in_callback_fn && state->re=
fs[i].callback_ref !=3D state->frameno)
>                         continue;
>                 verbose(env, "Unreleased reference id=3D%d alloc_insn=3D%=
d\n",
> @@ -10356,7 +10424,7 @@ static int check_resource_leak(struct bpf_verifie=
r_env *env, bool exception_exit
>  {
>         int err;
>
> -       if (check_lock && env->cur_state->active_lock.ptr) {
> +       if (check_lock && env->cur_state->active_lock) {
>                 verbose(env, "%s cannot be used inside bpf_spin_lock-ed r=
egion\n", prefix);
>                 return -EINVAL;
>         }
> @@ -11580,7 +11648,7 @@ static int ref_set_non_owning(struct bpf_verifier=
_env *env, struct bpf_reg_state
>         struct bpf_verifier_state *state =3D env->cur_state;
>         struct btf_record *rec =3D reg_btf_record(reg);
>
> -       if (!state->active_lock.ptr) {
> +       if (!state->active_lock) {
>                 verbose(env, "verifier internal error: ref_set_non_owning=
 w/o active lock\n");
>                 return -EFAULT;
>         }
> @@ -11677,6 +11745,7 @@ static int ref_convert_owning_non_owning(struct b=
pf_verifier_env *env, u32 ref_o
>   */
>  static int check_reg_allocation_locked(struct bpf_verifier_env *env, str=
uct bpf_reg_state *reg)
>  {
> +       struct bpf_reference_state *s;
>         void *ptr;
>         u32 id;
>
> @@ -11693,10 +11762,10 @@ static int check_reg_allocation_locked(struct b=
pf_verifier_env *env, struct bpf_
>         }
>         id =3D reg->id;
>
> -       if (!env->cur_state->active_lock.ptr)
> +       if (!env->cur_state->active_lock)
>                 return -EINVAL;
> -       if (env->cur_state->active_lock.ptr !=3D ptr ||
> -           env->cur_state->active_lock.id !=3D id) {
> +       s =3D find_lock_state(env, id, ptr);
> +       if (!s) {
>                 verbose(env, "held lock and object are not in the same al=
location\n");
>                 return -EINVAL;
>         }
> @@ -17561,8 +17630,19 @@ static bool refsafe(struct bpf_func_state *old, =
struct bpf_func_state *cur,
>                 return false;
>
>         for (i =3D 0; i < old->acquired_refs; i++) {
> -               if (!check_ids(old->refs[i].id, cur->refs[i].id, idmap))
> +               if (!check_ids(old->refs[i].id, cur->refs[i].id, idmap) |=
|
> +                   old->refs[i].type !=3D cur->refs[i].type)
>                         return false;
> +               switch (old->refs[i].type) {
> +               case REF_TYPE_PTR:
> +                       if (old->refs[i].callback_ref !=3D cur->refs[i].c=
allback_ref)
> +                               return false;
> +                       break;
> +               default:
> +                       if (old->refs[i].ptr !=3D cur->refs[i].ptr)
> +                               return false;
> +                       break;

I'd future proof a bit by explicitly handling all enum values
and WARN_ONCE in default.

pw-bot: cr

