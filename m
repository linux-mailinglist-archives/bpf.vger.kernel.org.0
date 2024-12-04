Return-Path: <bpf+bounces-46082-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 026569E3FCE
	for <lists+bpf@lfdr.de>; Wed,  4 Dec 2024 17:37:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB2CB281D84
	for <lists+bpf@lfdr.de>; Wed,  4 Dec 2024 16:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1E1220C498;
	Wed,  4 Dec 2024 16:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M4rJbZ78"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90DE3182D9
	for <bpf@vger.kernel.org>; Wed,  4 Dec 2024 16:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733330265; cv=none; b=VcTIrz47+MN8n8qJRpXEsaUiYpHgRGbTeySAlrvMpGef1sfcG9uwE2W95Q/YfCyo8qhWHvkHksLsT5gaMmTKvgefU+br0Av8TO7JimbU+qFQhDhSuKIgN2Sbb9FsGy3JPudYoH7obBzykWk2kk2AhUvQaEs1FBnUZVxn0ClxAyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733330265; c=relaxed/simple;
	bh=sneBemz/zWAC0jMHyj1gEfRnzSoGqXS0UMpBa0mslcw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cnJ657HL/qRUXPyIyYYmk/ob42SbVKCofla+5ZsOwD5N3hS8eSDr5Nak1Tzb6qGbuo+1oxNOMkFHz/PnoLcyXZ9c7uRHdOYxcKqXu5LzvBTvUPJzWD0L9Os284n1LHFTdUh+lnmHHvrfU6r0xYdqnbuTNSmn1i1YZ3f8eREHUZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M4rJbZ78; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-434a9f2da82so61638605e9.2
        for <bpf@vger.kernel.org>; Wed, 04 Dec 2024 08:37:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733330262; x=1733935062; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vo7XmdPF2XxceAk6HQc9q7Glj5tmwkIjQRpIY2PLHJA=;
        b=M4rJbZ78TuSu7wwHPieubtG6NGLeLOOD+9jqOlbrKxzz1Uft1yD1YrJmIvrhrJqLDP
         Ms5jGcxgEgTlqNxOvnlPeSx0eZIEq8qXiXOI0V54vz8MZGaYIDbNb53tmewta2Ew9qf+
         IypG5PBKgptNyW5hCTnZdU7LQueKxD5+UOHFO2WTszllSqTzDyKtvqLCKwAavOKCX+jN
         YQ6NwB20iFnQRSrVa4mxSUUT5k97FzPyCYm2p2B2JqG5gVYEB26N3xfK9uKi1mas25aT
         D9nMJLIcVnHqzks40u6cEwJX7zvc9tuoPFt09hM0V91Xs0IBpQnEXIAK0n5P3/1W4S/9
         NabA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733330262; x=1733935062;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vo7XmdPF2XxceAk6HQc9q7Glj5tmwkIjQRpIY2PLHJA=;
        b=PSe7pq7XLKmB39HpVwXG/qxJ+35Y2pvUsMx5kx+j0p7+MNS5nVVXXtj9zCiItpSMYf
         5aUU7sEC4Kr/6LiGXCx6hBreShrtGA/PZlvoxKAGRYDGoZvB8wbHG0wmxDaMy6YleUdm
         eO26mcV340lW2eEIrtKPKA+LLIz+g+B7gpY59NMwEFbtcwjh32KjkI3iT+X20spwTLbx
         IZcsBx2WUHIb8DGmcnKf4rYN0KPm2x+5TQw0t8ZX0DBVJOAJLyrN+ywPYGbMqrJFgBet
         iY9dhEN201RZIPgUXOJbi8+FtvEW0g7QpMmwANz8iRvfWvKNTMKhACptZovtx1LW7L6t
         ffAA==
X-Gm-Message-State: AOJu0YyxbzCexBNZN69qJ9e0M/8XgLfPXAoHjSr+cR5+ba0jMw3THHOc
	h2K0azMna84F8V4W7LtfXVDo2DXrx8Ool1C3fEOjn0WuQYPn33U3+KSaOnjNYzbfxkQlNBRbTj9
	X5s6WPrIC2ItyookcFiYBe8zt4Wo=
X-Gm-Gg: ASbGncviIAZ6fWHjpf1xovfXEUun9/r4Ri4FVpHKmrAAm/o9sbUlLysPg3z++kI7Aao
	9RuAEiiKtrY50WQynrqXDUXeqpjt7NbBVEA==
X-Google-Smtp-Source: AGHT+IEjm/PaiRq2zRjpsguaQjiYCZVEQ+xbecgOykrPTu8rbtTbNZwR2FUVnm6sGGYk7z0qrGt8gXcc/i8oGRUrzBg=
X-Received: by 2002:a05:6000:4009:b0:385:fae4:424e with SMTP id
 ffacd0b85a97d-385fd5327bdmr6138065f8f.52.1733330261538; Wed, 04 Dec 2024
 08:37:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241204024154.21386-1-memxor@gmail.com> <20241204024154.21386-2-memxor@gmail.com>
In-Reply-To: <20241204024154.21386-2-memxor@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 4 Dec 2024 08:37:30 -0800
Message-ID: <CAADnVQJpV2+b54q9zcpOg+zJedv8xpA6Csn_6ksTzpcgztmfwQ@mail.gmail.com>
Subject: Re: [PATCH bpf v1 1/2] bpf: Suppress warning for non-zero off raw_tp
 arg NULL check
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, kkd@meta.com, Manu Bretelle <chantra@meta.com>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 3, 2024 at 6:42=E2=80=AFPM Kumar Kartikeya Dwivedi <memxor@gmai=
l.com> wrote:
>
> The fixed commit began marking raw_tp arguments as PTR_MAYBE_NULL to
> avoid dead code elimination in the verifier, since raw_tp arguments
> may actually be NULL at runtime. However, to preserve compatibility,
> it simulated the raw_tp accesses as if the NULL marking was not present.
>
> One of the behaviors permitted by this simulation is offset modification
> for NULL pointers. Typically, this pattern is rejected by the verifier,
> and users make workarounds to prevent the compiler from producing such
> patterns. However, now that it is allowed, when the compiler emits such
> code, the offset modification is allowed and a PTR_MAYBE_NULL raw_tp arg
> with non-zero off can be formed.
>
> The failing example program had the following pseudo-code:
>
> r0 =3D 1024;
> r1 =3D ...; // r1 =3D trusted_or_null_(id=3D1)
> r3 =3D r1;  // r3 =3D trusted_or_null_(id=3D1) r1 =3D trusted_or_null_(id=
=3D1)
> r3 +=3D r0; // r3 =3D trusted_or_null_(id=3D1, off=3D1024)
> if r1 =3D=3D 0 goto pc+X;
>
> At this point, while mark_ptr_or_null_reg will see PTR_MAYBE_NULL and
> off =3D=3D 0 for r1, it will notice non-zero off for r3, and the
> WARN_ON_ONCE will fire, as the condition checks excluding register types
> do not include raw_tp argument type.
>
> This is a pattern produced by LLVM, therefore it is hard to suppress it
> everywhere in BPF programs.
>
> The right "generic" fix for this issue in general, will be permitting
> offset modification for PTR_MAYBE_NULL pointers everywhere, and
> enforcing that the instruction operand of a conditional jump has the
> offset as zero. It's other copies may still have non-zero offset, and
> that is fine. But this is more involved and will take longer to
> integrate.
>
> Hence, for now, when we notice raw_tp args with off !=3D 0 when unmarking
> NULL modifier, simply allocate such pointer a fresh id and remove them
> from the "id" set being currently operated on, and leave them as is
> without removing PTR_MAYBE_NULL marking.
>
> Dereferencing such pointers will still work as the fixed commit allowed
> it for raw_tp args.
>
> This will mean that still, all registers with a given id and off =3D 0
> will be unmarked, even if a register with off !=3D 0 is NULL checked, but
> this shouldn't introducing any incorrectness. Just that any register
> with off !=3D 0 excludes itself from the marking exercise by reassigning
> itself a new id.
>
> Fixes: cb4158ce8ec8 ("bpf: Mark raw_tp arguments with PTR_MAYBE_NULL")
> Reported-by: Manu Bretelle <chantra@meta.com>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  kernel/bpf/verifier.c | 44 ++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 39 insertions(+), 5 deletions(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 1c4ebb326785..37504095a0bc 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -15335,7 +15335,8 @@ static int reg_set_min_max(struct bpf_verifier_en=
v *env,
>         return err;
>  }
>
> -static void mark_ptr_or_null_reg(struct bpf_func_state *state,
> +static void mark_ptr_or_null_reg(struct bpf_verifier_env *env,
> +                                struct bpf_func_state *state,
>                                  struct bpf_reg_state *reg, u32 id,
>                                  bool is_null)
>  {
> @@ -15352,6 +15353,38 @@ static void mark_ptr_or_null_reg(struct bpf_func=
_state *state,
>                  */
>                 if (WARN_ON_ONCE(reg->smin_value || reg->smax_value || !t=
num_equals_const(reg->var_off, 0)))
>                         return;
> +               /* Unlike the MEM_ALLOC and NON_OWN_REF cases explicitly =
tested
> +                * below, where verifier will set off !=3D 0, we allow us=
ers to
> +                * modify offset of PTR_MAYBE_NULL raw_tp args to preserv=
e
> +                * compatibility since they were not marked NULL in older
> +                * kernels. This however means we may see a non-zero offs=
et
> +                * register when marking them non-NULL in verifier state.
> +                * This can happen for the operand of the instruction:
> +                *
> +                * r1 =3D trusted_or_null_(id=3D1);
> +                * if r1 =3D=3D 0 goto X;
> +                *
> +                * or a copy when LLVM produces code like below:
> +                *
> +                * r1 =3D trusted_or_null_(id=3D1);
> +                * r3 =3D r1; // r3 =3D trusted_or_null(id=3D1)
> +                * r3 +=3D K; // r3 =3D trusted_or_null_(id=3D1, off=3DK)
> +                * if r1 =3D=3D 0 goto X; // see r3.off !=3D 0 when unmar=
king _or_null
> +                *
> +                * The right fix would be more generic: lift the restrict=
ion on
> +                * modifying reg->off for PTR_MAYBE_NULL pointers, and on=
ly
> +                * enforce it for the instruction operand of a NULL check=
, while
> +                * allowing non-zero off for other registers, but this is=
 future
> +                * work.
> +                */

I think the comment is too verbose.
Especially considering that we're going to remove this hack in bpf-next.

I can trim it to bare minimum while applying if you're ok ?

> +               if (mask_raw_tp_reg_cond(env, reg) && reg->off) {
> +                       /* We don't reset reg->id back to 0, as it's unex=
pected
> +                        * when PTR_MAYBE_NULL is set. Simply give this r=
eg a
> +                        * new id in case user decides to NULL check it a=
gain.
> +                        */
> +                       reg->id =3D ++env->id_gen;
> +                       return;
> +               }
>                 if (!(type_is_ptr_alloc_obj(reg->type) || type_is_non_own=
ing_ref(reg->type)) &&
>                     WARN_ON_ONCE(reg->off))
>                         return;
> @@ -15385,7 +15418,8 @@ static void mark_ptr_or_null_reg(struct bpf_func_=
state *state,
>  /* The logic is similar to find_good_pkt_pointers(), both could eventual=
ly
>   * be folded together at some point.
>   */
> -static void mark_ptr_or_null_regs(struct bpf_verifier_state *vstate, u32=
 regno,
> +static void mark_ptr_or_null_regs(struct bpf_verifier_env *env,
> +                                 struct bpf_verifier_state *vstate, u32 =
regno,
>                                   bool is_null)
>  {
>         struct bpf_func_state *state =3D vstate->frame[vstate->curframe];
> @@ -15401,7 +15435,7 @@ static void mark_ptr_or_null_regs(struct bpf_veri=
fier_state *vstate, u32 regno,
>                 WARN_ON_ONCE(release_reference_state(state, id));
>
>         bpf_for_each_reg_in_vstate(vstate, state, reg, ({
> -               mark_ptr_or_null_reg(state, reg, id, is_null);
> +               mark_ptr_or_null_reg(env, state, reg, id, is_null);
>         }));
>  }
>
> @@ -15827,9 +15861,9 @@ static int check_cond_jmp_op(struct bpf_verifier_=
env *env,
>                 /* Mark all identical registers in each branch as either
>                  * safe or unknown depending R =3D=3D 0 or R !=3D 0 condi=
tional.
>                  */
> -               mark_ptr_or_null_regs(this_branch, insn->dst_reg,
> +               mark_ptr_or_null_regs(env, this_branch, insn->dst_reg,
>                                       opcode =3D=3D BPF_JNE);
> -               mark_ptr_or_null_regs(other_branch, insn->dst_reg,
> +               mark_ptr_or_null_regs(env, other_branch, insn->dst_reg,
>                                       opcode =3D=3D BPF_JEQ);
>         } else if (!try_match_pkt_pointers(insn, dst_reg, &regs[insn->src=
_reg],
>                                            this_branch, other_branch) &&
> --
> 2.43.5
>

