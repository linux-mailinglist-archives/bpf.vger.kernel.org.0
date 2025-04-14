Return-Path: <bpf+bounces-55891-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F266A88C8A
	for <lists+bpf@lfdr.de>; Mon, 14 Apr 2025 21:59:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B5313B2BFF
	for <lists+bpf@lfdr.de>; Mon, 14 Apr 2025 19:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83A801C8FBA;
	Mon, 14 Apr 2025 19:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FN19icfm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5691D79A0
	for <bpf@vger.kernel.org>; Mon, 14 Apr 2025 19:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744660737; cv=none; b=Mo398hECJCTocYMLnMALUhde0OyaJJXld1cYaYXp8LCL5jXSh+Ea0P5MQLhu9r0QFiPOdhu99Kz9EMbcSQE+Z2BW4EXVz9bI1tCrIt/dW9AO6R156pweezgzmRG6dkHI6enI5lVo5JtnXAyE1bijte5SvUh2nBzzwEHPRP4Vu2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744660737; c=relaxed/simple;
	bh=+TsPGLfSfcRq76Jxv0RG+D8qa5cH5Wjh4k7Jwg8u7P8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jcPDtoG+u5JEg4/iJymeZrzf5lMygfDNPBhScQ27GJBXdqg/NDO2eDwFXB6eChZIkkHNlqUPPkAz2XKZqrl2KXvHN0gX2tP46K2OC1rDgPMRjXAJo4YYRGJqzoo2NmWx7SrPN0x5Ayx6Qxe8BXiib2mgeSDWGtCVFz2RydUmSwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FN19icfm; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-702599fa7c5so36262087b3.1
        for <bpf@vger.kernel.org>; Mon, 14 Apr 2025 12:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744660734; x=1745265534; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AP9aMw68cnMug2ABoU1lUJ8hO+7n2hN5LfYaKKxVSQg=;
        b=FN19icfm125GYR17kg6gLu70lcoPC+TQzCa3WqjBwFRaC3bi4veyQuK7HEgfgtiHGC
         fUhCue8Iw4A8FiCUyYyNOYwRAlQBUa+9tgpfoJ1AMk09lrzgN3e3zMRQrNbo3fme/Vy3
         6BOKwItYxUvYbVdpiEmBs1f+pIxrarfZTqyI8byCjF9C0JMym+66sedQYR95Uy/Lv19s
         XGVxu7QRoQhQ8MrWBo1Zqn4JxzRaYlUU1ERKFRjfgmXRKpObAjtva7RL/pjAwtu7j3Y9
         baCs6bm6Y1ASaCrzGaJLcYrtTaHe513yLA7UOzFADDplRadbOYPQxz/h33TtDDnqaVEK
         g7bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744660734; x=1745265534;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AP9aMw68cnMug2ABoU1lUJ8hO+7n2hN5LfYaKKxVSQg=;
        b=PkIrIajHe38cHdcuClRdtSg+raslAKIqjMqCjLbuNj+2VlvFUk+WAclNOth4JeD0+1
         eWrho5Ul/o3qR0Pik7bkn3Uts+ZQdQ69WVjaWqacT2wuIUaM8Dr2MFOI+gUvFjAtNr7C
         8rZGNykwxa5ab9BCNuIhg+qIn4In6whXaJtheLVCFys1U7eOFGFzkyfG7NLB0wsTDrAS
         chGugkw9h8Yt7jNJsagrraBF+LTan78VYs22gBgJOzbRynb/tBYWxxXrkwdXOMsKBw5x
         SktB6p7BHFPbHjZQMUdnFLs3ZgQpLqRuc4r3zxRGlt6oefSXEEXoKEayGzC2/VT78X9l
         CjkA==
X-Gm-Message-State: AOJu0YzuENZ2r5Y/KnYsUa3A7EBijWyP/G/IwgMA2eqm8ZzKh6wajJmx
	uAF1IP3MT1DZsANJYaTOAZN9wsJkIPuKQTME/6YrGvw+0eH7T1Ld2bTetLdbLPVlMLHykoB4QxL
	Sz7G08m4T9zEsLb7amMpWPDijz5g=
X-Gm-Gg: ASbGncuFlbpvowCfSDAvZ4ZPbrkPhalyDSKAXYKlsMJOvmjLnLJpTZYi25uP4Y+dr11
	eDVuYG3KEhgdTqFqM9PswpPvAzR7G5GHbq3tM4h86rDX8VPfFnLpZnk3ojXj7AhIvIpMZBlT8Kl
	W5nGP3P/+jmYmbiEixV8NYfT6Myh9BhGYN
X-Google-Smtp-Source: AGHT+IEafdOKaw3PmauuWAkhu/wyGkZ5ikizhVZ4zIb4YjXjY3NjchGczPn6fypEdJJD2lGJCt6q0H22rarwPy1Kgyg=
X-Received: by 2002:a05:690c:884:b0:6fd:3153:2010 with SMTP id
 00721157ae682-705a1ef89edmr9138287b3.7.1744660733935; Mon, 14 Apr 2025
 12:58:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250414161443.1146103-1-memxor@gmail.com> <20250414161443.1146103-2-memxor@gmail.com>
In-Reply-To: <20250414161443.1146103-2-memxor@gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Mon, 14 Apr 2025 12:58:43 -0700
X-Gm-Features: ATxdqUHVhEOB8BNXzTMPiWNr1bp5TKQvO5Lj55oGWpNjGOeR4nTFREYREW7X8aM
Message-ID: <CAMB2axMcgN6_6=jYMSLRO2E_RzJdJe48E2Uy-QBQTFS-XkQ8-g@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next/net v1 01/13] bpf: Tie dynptrs to referenced
 source objects
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Barret Rhoden <brho@google.com>, kkd@meta.com, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 14, 2025 at 9:14=E2=80=AFAM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> Ensure that for dynptr constructors (MEM_UNINIT arg_type) taking a
> referenced object (ref_obj_id) as their memory source, we set the
> ref_obj_id of the dynptr appropriately as well. This allows us to
> tie the lifetime of the dynptr to its source and properly invalidate
> it when the source object is released.
>
> For helpers, we don't have such cases yet as bpf_dynptr_from_mem is
> not permitted for anything other than PTR_TO_MAP_VALUE, but still pass
> meta->ref_obj_id as clone_ref_obj_id in case this is relaxed in future.
> Since they are ossified we know dynptr_from_mem is the only relevant
> helper and takes one memory argument, so we know the meta->ref_obj_id if
> non-zero will belong to it.
>
> For kfuncs, make sure for constructors, only 1 ref_obj_id argument is
> seen, as more than one can be ambiguous in terms of ref_obj_id transfer.
> Since more kfuncs can be added with possibly multiple memory arguments,
> make sure meta->ref_obj_id reassignment won't cause incorrect lifetime
> analysis in the future using ref_obj_cnt logic.  Set this ref_obj_id as
> the clone_ref_obj_id, so that it is transferred to the spilled_ptr stack
> slot register state.
>
> Add support to unmark_stack_slots_dynptr to not descend to its child
> slices (using bool slice parameter) so that we don't have circular calls
> when invoking release_reference. With this logic in place, we may have
> the following object relationships:
>                                      +-- slice 1 (ref=3D1)
>  source (ref=3D1) --> dynptr (ref=3D1) --|-- slice 2 (ref=3D1)
>                                      +-- slice 3 (ref=3D1)
>
> Destroying dynptr prunes the dynptr and all its children slices, but
> does not affect the source. Releasing the source will effectively prune
> the entire ownership tree. Dynptr clones with same ref=3D1 will be
> parallel in the ownership tree.
>
>                   +-- orig  dptr (ref=3D1) --> slice 1 (ref=3D1)
>  source (ref=3D1) --|-- clone dptr (ref=3D1) --> slice 2 (ref=3D1)
>                   +-- clone dptr (ref=3D1) --> slice 3 (ref=3D1)
>
> In such a case, only child slices of the dynptr clone being destroyed
> are invalidated. Likewise, if the source object goes away, the whole
> tree ends up getting pruned.
>
> Cc: Amery Hung <ameryhung@gmail.com>
> Fixes: 81bb1c2c3e8e ("bpf: net_sched: Add basic bpf qdisc kfuncs")
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  kernel/bpf/verifier.c | 81 ++++++++++++++++++++++++++++---------------
>  1 file changed, 54 insertions(+), 27 deletions(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 54c6953a8b84..a62dfab9aea6 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -198,7 +198,7 @@ struct bpf_verifier_stack_elem {
>
>  static int acquire_reference(struct bpf_verifier_env *env, int insn_idx)=
;
>  static int release_reference_nomark(struct bpf_verifier_state *state, in=
t ref_obj_id);
> -static int release_reference(struct bpf_verifier_env *env, int ref_obj_i=
d);
> +static int release_reference(struct bpf_verifier_env *env, int ref_obj_i=
d, bool objects);
>  static void invalidate_non_owning_refs(struct bpf_verifier_env *env);
>  static bool in_rbtree_lock_required_cb(struct bpf_verifier_env *env);
>  static int ref_set_non_owning(struct bpf_verifier_env *env,
> @@ -299,6 +299,7 @@ struct bpf_kfunc_call_arg_meta {
>         const char *func_name;
>         /* Out parameters */
>         u32 ref_obj_id;
> +       u32 ref_obj_cnt;
>         u8 release_regno;
>         bool r0_rdonly;
>         u32 ret_btf_id;
> @@ -759,7 +760,7 @@ static int mark_stack_slots_dynptr(struct bpf_verifie=
r_env *env, struct bpf_reg_
>         mark_dynptr_stack_regs(env, &state->stack[spi].spilled_ptr,
>                                &state->stack[spi - 1].spilled_ptr, type);
>
> -       if (dynptr_type_refcounted(type)) {
> +       if (dynptr_type_refcounted(type) || clone_ref_obj_id) {
>                 /* The id is used to track proper releasing */
>                 int id;
>
> @@ -818,22 +819,19 @@ static void invalidate_dynptr(struct bpf_verifier_e=
nv *env, struct bpf_func_stat
>         state->stack[spi - 1].spilled_ptr.live |=3D REG_LIVE_WRITTEN;
>  }
>
> -static int unmark_stack_slots_dynptr(struct bpf_verifier_env *env, struc=
t bpf_reg_state *reg)
> +static int __unmark_stack_slots_dynptr(struct bpf_verifier_env *env, str=
uct bpf_func_state *state,
> +                                      int spi, bool slice)
>  {
> -       struct bpf_func_state *state =3D func(env, reg);
> -       int spi, ref_obj_id, i;
> +       u32 ref_obj_id;
> +       int i;
>
> -       spi =3D dynptr_get_spi(env, reg);
> -       if (spi < 0)
> -               return spi;
> +       ref_obj_id =3D state->stack[spi].spilled_ptr.ref_obj_id;
>
> -       if (!dynptr_type_refcounted(state->stack[spi].spilled_ptr.dynptr.=
type)) {
> +       if (!dynptr_type_refcounted(state->stack[spi].spilled_ptr.dynptr.=
type) && !ref_obj_id) {
>                 invalidate_dynptr(env, state, spi);
>                 return 0;
>         }
>
> -       ref_obj_id =3D state->stack[spi].spilled_ptr.ref_obj_id;
> -
>         /* If the dynptr has a ref_obj_id, then we need to invalidate
>          * two things:
>          *
> @@ -842,7 +840,8 @@ static int unmark_stack_slots_dynptr(struct bpf_verif=
ier_env *env, struct bpf_re
>          */
>
>         /* Invalidate any slices associated with this dynptr */
> -       WARN_ON_ONCE(release_reference(env, ref_obj_id));
> +       if (slice)
> +               WARN_ON_ONCE(release_reference(env, ref_obj_id, false));

I think the slice argument might not be needed if we do the following inste=
ad:
        if (dynptr_type_refcounted(state->stack[spi].spilled_ptr.dynptr.typ=
e))
                WARN_ON_ONCE(release_reference(env, ref_obj_id, false));

When bpf_kfree_skb():
    -> release_reference(..., object =3D true)
      -> __unmark_stack_slots_dynptr()
        -> not calling into release_reference() since
dynptr_type_refcounted() returns false

When bpf_ringbuf_submit():
    -> unmark_stack_slots_dynptr()
      -> release_reference(..., object =3D false)
        -> not calling __unmark_stack_slots_dynptr() since object =3D=3D fa=
lse

Am I missing anything?

>
>         /* Invalidate any dynptr clones */
>         for (i =3D 1; i < state->allocated_stack / BPF_REG_SIZE; i++) {
> @@ -864,6 +863,18 @@ static int unmark_stack_slots_dynptr(struct bpf_veri=
fier_env *env, struct bpf_re
>         return 0;
>  }
>
> +static int unmark_stack_slots_dynptr(struct bpf_verifier_env *env, struc=
t bpf_reg_state *reg, bool slice)
> +{
> +       struct bpf_func_state *state =3D func(env, reg);
> +       int spi;
> +
> +       spi =3D dynptr_get_spi(env, reg);
> +       if (spi < 0)
> +               return spi;
> +
> +       return __unmark_stack_slots_dynptr(env, state, spi, slice);
> +}
> +
>  static void __mark_reg_unknown(const struct bpf_verifier_env *env,
>                                struct bpf_reg_state *reg);
>
> @@ -1075,7 +1086,7 @@ static int unmark_stack_slots_iter(struct bpf_verif=
ier_env *env,
>                 struct bpf_reg_state *st =3D &slot->spilled_ptr;
>
>                 if (i =3D=3D 0)
> -                       WARN_ON_ONCE(release_reference(env, st->ref_obj_i=
d));
> +                       WARN_ON_ONCE(release_reference(env, st->ref_obj_i=
d, false));
>
>                 __mark_reg_not_init(env, st);
>
> @@ -9749,7 +9760,7 @@ static int check_func_arg(struct bpf_verifier_env *=
env, u32 arg,
>                                          true, meta);
>                 break;
>         case ARG_PTR_TO_DYNPTR:
> -               err =3D process_dynptr_func(env, regno, insn_idx, arg_typ=
e, 0);
> +               err =3D process_dynptr_func(env, regno, insn_idx, arg_typ=
e, meta->ref_obj_id);
>                 if (err)
>                         return err;
>                 break;
> @@ -10220,12 +10231,12 @@ static int release_reference_nomark(struct bpf_=
verifier_state *state, int ref_ob
>   *
>   * This is the release function corresponding to acquire_reference(). Id=
empotent.
>   */
> -static int release_reference(struct bpf_verifier_env *env, int ref_obj_i=
d)
> +static int release_reference(struct bpf_verifier_env *env, int ref_obj_i=
d, bool objects)
>  {
>         struct bpf_verifier_state *vstate =3D env->cur_state;
>         struct bpf_func_state *state;
>         struct bpf_reg_state *reg;
> -       int err;
> +       int err, spi;
>
>         err =3D release_reference_nomark(vstate, ref_obj_id);
>         if (err)
> @@ -10236,6 +10247,19 @@ static int release_reference(struct bpf_verifier=
_env *env, int ref_obj_id)
>                         mark_reg_invalid(env, reg);
>         }));
>
> +       if (!objects)
> +               return 0;
> +
> +       bpf_for_each_spilled_reg(spi, state, reg, (1 << STACK_DYNPTR)) {
> +               if (!reg)
> +                       continue;
> +               if (!reg->dynptr.first_slot || reg->ref_obj_id !=3D ref_o=
bj_id)
> +                       continue;
> +               err =3D __unmark_stack_slots_dynptr(env, state, spi, fals=
e);
> +               if (err)
> +                       return err;
> +       }
> +
>         return 0;
>  }
>
> @@ -11357,7 +11381,7 @@ static int check_helper_call(struct bpf_verifier_=
env *env, struct bpf_insn *insn
>                                 verbose(env, "verifier internal error: CO=
NST_PTR_TO_DYNPTR cannot be released\n");
>                                 return -EFAULT;
>                         }
> -                       err =3D unmark_stack_slots_dynptr(env, &regs[meta=
.release_regno]);
> +                       err =3D unmark_stack_slots_dynptr(env, &regs[meta=
.release_regno], true);
>                 } else if (func_id =3D=3D BPF_FUNC_kptr_xchg && meta.ref_=
obj_id) {
>                         u32 ref_obj_id =3D meta.ref_obj_id;
>                         bool in_rcu =3D in_rcu_cs(env);
> @@ -11379,7 +11403,7 @@ static int check_helper_call(struct bpf_verifier_=
env *env, struct bpf_insn *insn
>                                 }));
>                         }
>                 } else if (meta.ref_obj_id) {
> -                       err =3D release_reference(env, meta.ref_obj_id);
> +                       err =3D release_reference(env, meta.ref_obj_id, t=
rue);
>                 } else if (register_is_null(&regs[meta.release_regno])) {
>                         /* meta.ref_obj_id can only be 0 if register that=
 is meant to be
>                          * released is NULL, which must be > R0.
> @@ -12974,6 +12998,7 @@ static int check_kfunc_args(struct bpf_verifier_e=
nv *env, struct bpf_kfunc_call_
>                         meta->ref_obj_id =3D reg->ref_obj_id;
>                         if (is_kfunc_release(meta))
>                                 meta->release_regno =3D regno;
> +                       meta->ref_obj_cnt++;

Does it make sense to convert other "more than one arg with
ref_obj_id" checks to using ref_obj_cnt to make it more consistent?

Thanks for fixing the bug!
Amery

>                 }
>
>                 ref_t =3D btf_type_skip_modifiers(btf, t->type, &ref_id);
> @@ -13100,13 +13125,19 @@ static int check_kfunc_args(struct bpf_verifier=
_env *env, struct bpf_kfunc_call_
>                 case KF_ARG_PTR_TO_DYNPTR:
>                 {
>                         enum bpf_arg_type dynptr_arg_type =3D ARG_PTR_TO_=
DYNPTR;
> -                       int clone_ref_obj_id =3D 0;
> +                       int clone_ref_obj_id =3D meta->ref_obj_id;
>
>                         if (reg->type =3D=3D CONST_PTR_TO_DYNPTR)
>                                 dynptr_arg_type |=3D MEM_RDONLY;
>
> -                       if (is_kfunc_arg_uninit(btf, &args[i]))
> +                       if (is_kfunc_arg_uninit(btf, &args[i])) {
>                                 dynptr_arg_type |=3D MEM_UNINIT;
> +                               /* It's confusing if dynptr constructor t=
akes multiple referenced arguments. */
> +                               if (meta->ref_obj_cnt > 1) {
> +                                       verbose(env, "verifier internal e=
rror: multiple referenced arguments\n");
> +                                       return -EFAULT;
> +                               }
> +                       }
>
>                         if (meta->func_id =3D=3D special_kfunc_list[KF_bp=
f_dynptr_from_skb]) {
>                                 dynptr_arg_type |=3D DYNPTR_TYPE_SKB;
> @@ -13582,7 +13613,7 @@ static int check_kfunc_call(struct bpf_verifier_e=
nv *env, struct bpf_insn *insn,
>          * PTR_TO_BTF_ID in bpf_kfunc_arg_meta, do the release now.
>          */
>         if (meta.release_regno) {
> -               err =3D release_reference(env, regs[meta.release_regno].r=
ef_obj_id);
> +               err =3D release_reference(env, regs[meta.release_regno].r=
ef_obj_id, true);
>                 if (err) {
>                         verbose(env, "kfunc %s#%d reference has not been =
acquired before\n",
>                                 func_name, meta.func_id);
> @@ -13603,7 +13634,7 @@ static int check_kfunc_call(struct bpf_verifier_e=
nv *env, struct bpf_insn *insn,
>                         return err;
>                 }
>
> -               err =3D release_reference(env, release_ref_obj_id);
> +               err =3D release_reference(env, release_ref_obj_id, true);
>                 if (err) {
>                         verbose(env, "kfunc %s#%d reference has not been =
acquired before\n",
>                                 func_name, meta.func_id);
> @@ -13803,11 +13834,7 @@ static int check_kfunc_call(struct bpf_verifier_=
env *env, struct bpf_insn *insn,
>                                         return -EFAULT;
>                                 }
>                                 regs[BPF_REG_0].dynptr_id =3D meta.initia=
lized_dynptr.id;
> -
> -                               /* we don't need to set BPF_REG_0's ref o=
bj id
> -                                * because packet slices are not refcount=
ed (see
> -                                * dynptr_type_refcounted)
> -                                */
> +                               regs[BPF_REG_0].ref_obj_id =3D meta.initi=
alized_dynptr.ref_obj_id;
>                         } else {
>                                 verbose(env, "kernel function %s unhandle=
d dynamic return type\n",
>                                         meta.func_name);
> --
> 2.47.1
>

