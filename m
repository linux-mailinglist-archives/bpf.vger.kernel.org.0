Return-Path: <bpf+bounces-56061-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17B69A90D91
	for <lists+bpf@lfdr.de>; Wed, 16 Apr 2025 23:04:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6029119E0298
	for <lists+bpf@lfdr.de>; Wed, 16 Apr 2025 21:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0627622FF41;
	Wed, 16 Apr 2025 21:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PCOY1rEV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2FA11B4235
	for <bpf@vger.kernel.org>; Wed, 16 Apr 2025 21:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744837491; cv=none; b=b7l0QTiKQ3TTaAvficGQOuhsZaaJERv0/+U6+VxdeDxcn2vjWPqHJFZ8UOLQ034t+Dqiqd3jJrCw1E8TVlhBFMxLcSWfhJfw0eAIJRNC3Pzx0kwap9oo4rqvuhYtQIio23UP/3EW6Ez3L55VBikbUzJqA5+KjfRaChj5gx/bjPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744837491; c=relaxed/simple;
	bh=pcZW8kBEQcQdHKKqf2RlGc/Rxg87ZAehqXUOZjp7+AA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cQPeH2bOV1AOYJaaoPf280qQvxi3lYx3Zvu/DumkLWrGHJcc7snAuBcG+NJ5b4HAfAgtpUl258hfUysIbn6APbRfTIsNxwV0umA4ARz0GwCREMOsmlEEK04jLJpQq0auBq2TY8XCSKTeDg3HdmwOGTwSuGfa7qol0ENd2nUb+3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PCOY1rEV; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-736bfa487c3so33463b3a.1
        for <bpf@vger.kernel.org>; Wed, 16 Apr 2025 14:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744837489; x=1745442289; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cMhMLMnt8pOTUl1BKh9BA3RrDoe2F6Y8Y/JsOTXBveI=;
        b=PCOY1rEVDzEHW/rLorSx2DCn1j2oJn0dhIuAt0XlbvtlhBr/uc9DxHeMdRanb48iXV
         v4mWN3mx1bDI1ZhDMEShlV8ZztaXyK+TvJBP5Pq8zHZwJBiTLYalLuQ48Wh1np50SgUy
         n36V4Ezon4fT6TK8HyZypQBUWWwh0k7txuaa2adtDXz0aZY63Uybi6ZCUYoRwf/YQIa1
         jaObPNrzAqIndc4s6jdJKiLlb62wrJMyQmA/MfNC+AcZOMO9+7e3U/vL/w52fcFaEk1S
         PHe2oSH4bkGLsD+AYUujAAiALqW+cD69NXI/ic8pT7joCiLjtCxmrCpdgBpesZQRoYW8
         oNNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744837489; x=1745442289;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cMhMLMnt8pOTUl1BKh9BA3RrDoe2F6Y8Y/JsOTXBveI=;
        b=tehJtzWsd7cyB2RXR6hX5+0eP8SwZRRMMwcwV7DvEBnaD9Ty3qkxLPpwmM14uyq7cj
         rSs7q5UtQYmsAqx/BcuzsOq15LGX9A704P6RYBBNs6iAASTDPu7uVUCQgTEbOWehiTGY
         dVLQE0Hgt/+BbHI44GXk1LkiV13JdOxfFePYjjuFxddqHywQi4ejx/MoriDCMidAsM4h
         V7tIwSj34NiMc0egh4wAUs7yAKV6+YZSqgRnXnM7CrBi3+Z3aqzih3VPakPP6GgXEpc/
         pcQ6Mw4E42/6UwOYpb6jE57rgrr3cXbRVqZQ/4awuxKzeaUVpkxSCE+iucvrsZ0a37vv
         9I6A==
X-Gm-Message-State: AOJu0Yzg6fJ1j48zWAKSeN2mDynqtmiRKoKtlpK30nqYAnM7v1n7qkO6
	YTIzxW+p8eFpOD4nDM5WqYKzqPyp1n+XZ1rQf7pHAz3AxXgWb6uU09j5EcfX+8AOT6OQWO7qhZx
	MIvywVkHCelxwL8Z4q2l58N1/L5LOvA==
X-Gm-Gg: ASbGncsFQzVtciK8SO57Rd0F+VPmtey+wL+5VaN1PeOJMqEMSFf23OVZCnhPCeJXhUd
	buvN5CC5a3NhVFvQcJUmIXSvZKvDC+9mDMgFtgQiTinJskccuCF3a0VZ4pAmEE9xLeGAccU/pzg
	5q+ud6mRxjhwxxJ5Pb+jaMxhmb35vc87AO9NPYLoLH4mrrSn+X
X-Google-Smtp-Source: AGHT+IE5aQ2zdXkLk1TspMc9WmchGD8X3qTmoYjQSvsRXBCP5ezS1tyF7pR4U24YJC8mxW1D26hrDfi7UOWci5bh/j4=
X-Received: by 2002:a05:6a00:b8b:b0:736:54c9:df2c with SMTP id
 d2e1a72fcca58-73c267c1ba0mr4419611b3a.15.1744837488978; Wed, 16 Apr 2025
 14:04:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250414161443.1146103-1-memxor@gmail.com> <20250414161443.1146103-2-memxor@gmail.com>
In-Reply-To: <20250414161443.1146103-2-memxor@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 16 Apr 2025 14:04:35 -0700
X-Gm-Features: ATxdqUFpAbNy9edul1My1MV6lWJfuzhlgDhQM9EILTO4-GOzntLhAbKT6OBaQ3k
Message-ID: <CAEf4Bza84ANnQPKJSPwr8d2v50DwWGyuScoPmcv_GNRH_7sG2w@mail.gmail.com>
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

it would be a bug to have both conditions true, right? Should we
express this a bit more explicitly?
maybe something like

int id =3D 0;

if (dynptr_type_refcounted(type)) {
    WARN_ON_ONCE(clone_ref_obj_id);
    id =3D acquire_reference(env, insn_idx);
}
if (clone_ref_obj_id)
    id =3D clone_ref_obj_id;

state->stack[spi].spilled_ptr.ref_obj_id =3D id;
state->stack[spi - 1].spilled_ptr.ref_obj_id =3D id;
state->stack[spi].spilled_ptr.live |=3D REG_LIVE_WRITTEN;
state->stack[spi - 1].spilled_ptr.live |=3D REG_LIVE_WRITTEN;

?

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

Eduard already pointed out that `!ref_obj_id` condition is enough now

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

tbh, this bool flag to release_reference to prevent cycles feels like
a hack and that we are not solving this properly...

also, changes in this patch still won't properly support the case
where we create dynptr -> slice -> dynptr -> slice -> ... chains,
right? Any dynptr in the chain will cause "release" of any other
dynptr, including parents, right?

>
>         /* Invalidate any dynptr clones */
>         for (i =3D 1; i < state->allocated_stack / BPF_REG_SIZE; i++) {

[...]

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

hm, "objects" really doesn't describe anything...

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

instead of a bool flag into release_reference, shouldn't the below
logic be just a separate function?

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

[...]

