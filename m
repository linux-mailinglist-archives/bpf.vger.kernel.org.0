Return-Path: <bpf+bounces-33579-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BDB491EBE1
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 02:42:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 372A8B21CEB
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 00:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 626C76FCB;
	Tue,  2 Jul 2024 00:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GvweWpG0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD227462
	for <bpf@vger.kernel.org>; Tue,  2 Jul 2024 00:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719880915; cv=none; b=aEhG6W+r+S6LZX/zcCiGnIyA/T6IAaxdardbRT73na9460jpkteBzidGCaFGq3ayUe4PK8Lh0ZpEwCmWkZsKayfkIPsQQ8tX30EhrFzKnmTzI1TQijlRD+XatTQ8SmmqIISan0TjQjU7y2Yqip9xAtWo2mNMlfIDdfJwJlZXINU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719880915; c=relaxed/simple;
	bh=iadx0Cyav1//elSK4XeZwYsB6X8LyV3/hN82hNSB5Zw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kKeVjnpGGJTzwBfQg023/utu8DGHDbjNib7llmUAkJvrV0fUM0CR3rYdb5CipbrA9Dpq0uuY21ZlhMKcN5ZB0sVBWGzBWQSInu69qk9fVDJ1I/K4UXj6AlqRvcrRSfynl6rkfHozjnZUYGmK6iBh1Oj6ABU9GS+fLMgCdJQSsOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GvweWpG0; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7182a634815so2108310a12.3
        for <bpf@vger.kernel.org>; Mon, 01 Jul 2024 17:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719880913; x=1720485713; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ooIocmKMfFo+vYvl+MxvEgsmSvW0VPasPEEGoc7uXg0=;
        b=GvweWpG0948hZifOhm26toc8lxXSDVBpIbytZSDlaTAhlnIGuTzkp2aLyBOpI1oj/e
         eoGUJMrfmckFe1JvhKFPC6jjZs1MUoyzUGSYlYZPgZADZA+aTKtBooakEDJBUn2WzJiq
         xvooLikBO0ERcBueEKZNB2QYxEXbMbIhgHWYiaJ/6yp6fewGdsWg9sKPWB3YesRvc12D
         oNidB96MZvLM0SRQqwGcYB5UTehM7BpgSy0bF1vkS6ByFFrgE0CiIdUHYRQu3WjF5NBu
         nEX0KntKMli+/i7oPup/EYMBEtIGvH+FbXp92buY527cbL+NniMDMUqlZ0XjEBaraYdc
         mk1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719880913; x=1720485713;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ooIocmKMfFo+vYvl+MxvEgsmSvW0VPasPEEGoc7uXg0=;
        b=aXFPbpW7tcAA+K2KYN+r53Ozt3Qb3l0Q6+0edxhJ6RyuRedi8l3qv8zbOQtmc59fdF
         M5fz4GK/GYNZKLU785uCvjIaY/pASsJmlcSkGkX2UrGfMdXjumH1e9jE2XKE6HjX41/p
         XThWADq8MbeW0L0BsAS88RanGBmkD2dXvdhuGKLpONJXaaDd3A/p/96FtY9w0LMp00dR
         F1G9w12RLXi9y0fnV9DkJLdQS4dhW01cf6RQRO4EheP+t+7nw+lYUiS4FCWOZ/gCENaP
         ZJD9gSobNf7rhwbiSX9aHvy1RJtpqrdaAy9I4dlZQEF0aHFohgGmDBfaODSiqQ9cOZwa
         vOag==
X-Gm-Message-State: AOJu0YyvvXPlRSAG9NW14RQPXZqba5/yMRoQZtwYWxpfP1kqlbsvQK95
	E1pTwXsiyDM4Q6Jwgsqh5Kw9MW55JYklZuGhT1aYLi9qvbph/nN6Nu5a/1j7CPlqSSpinHeAAQ8
	kQMbipZY8elDO5Ws+Ix1btR2VattM/Q==
X-Google-Smtp-Source: AGHT+IEt/Q4tdanYaVfyGxpkmH/wZ1m7Un90egTlNysEM9mCIs4iDA5l1WAxs4yTL1S41t/vOiOPok4TuhvXHvKzG/U=
X-Received: by 2002:a05:6a20:1584:b0:1bd:23cc:a3a5 with SMTP id
 adf61e73a8af0-1bef61e7a47mr6944079637.48.1719880913375; Mon, 01 Jul 2024
 17:41:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240629094733.3863850-1-eddyz87@gmail.com> <20240629094733.3863850-3-eddyz87@gmail.com>
In-Reply-To: <20240629094733.3863850-3-eddyz87@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 1 Jul 2024 17:41:40 -0700
Message-ID: <CAEf4Bzb5JoeVAwO6krQPUWHyUad0ya5ivXWukfb+_wrWrs7H5Q@mail.gmail.com>
Subject: Re: [RFC bpf-next v1 2/8] bpf: no_caller_saved_registers attribute
 for helper calls
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev, jose.marchesi@oracle.com, 
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 29, 2024 at 2:48=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> GCC and LLVM define a no_caller_saved_registers function attribute.
> This attribute means that function scratches only some of
> the caller saved registers defined by ABI.
> For BPF the set of such registers could be defined as follows:
> - R0 is scratched only if function is non-void;
> - R1-R5 are scratched only if corresponding parameter type is defined
>   in the function prototype.
>
> This commit introduces flag bpf_func_prot->nocsr.
> If this flag is set for some helper function, verifier assumes that
> it follows no_caller_saved_registers calling convention.
>
> The contract between kernel and clang allows to simultaneously use
> such functions and maintain backwards compatibility with old
> kernels that don't understand no_caller_saved_registers calls
> (nocsr for short):
>
> - clang generates a simple pattern for nocsr calls, e.g.:
>
>     r1 =3D 1;
>     r2 =3D 2;
>     *(u64 *)(r10 - 8)  =3D r1;
>     *(u64 *)(r10 - 16) =3D r2;
>     call %[to_be_inlined_by_jit]

"inline_by_jit" is misleading, it can be inlined by BPF verifier using
BPF instructions, not just by BPF JIT

>     r2 =3D *(u64 *)(r10 - 16);
>     r1 =3D *(u64 *)(r10 - 8);
>     r0 =3D r1;
>     r0 +=3D r2;
>     exit;
>
> - kernel removes unnecessary spills and fills, if called function is
>   inlined by current JIT (with assumption that patch inserted by JIT
>   honors nocsr contract, e.g. does not scratch r3-r5 for the example
>   above), e.g. the code above would be transformed to:
>
>     r1 =3D 1;
>     r2 =3D 2;
>     call %[to_be_inlined_by_jit]
>     r0 =3D r1;
>     r0 +=3D r2;
>     exit;
>
> Technically, the transformation is split into the following phases:
> - during check_cfg() function update_nocsr_pattern_marks() is used to
>   find potential patterns;
> - upon stack read or write access,
>   function check_nocsr_stack_contract() is used to verify if
>   stack offsets, presumably reserved for nocsr patterns, are used
>   only from those patterns;
> - function remove_nocsr_spills_fills(), called from bpf_check(),
>   applies the rewrite for valid patterns.
>
> See comment in match_and_mark_nocsr_pattern() for more details.
>
> Suggested-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
>  include/linux/bpf.h          |   6 +
>  include/linux/bpf_verifier.h |   9 ++
>  kernel/bpf/verifier.c        | 300 ++++++++++++++++++++++++++++++++++-
>  3 files changed, 307 insertions(+), 8 deletions(-)
>

[...]

> -static int find_subprog(struct bpf_verifier_env *env, int off)
> +/* Find subprogram that contains instruction at 'off' */
> +static int find_containing_subprog(struct bpf_verifier_env *env, int off=
)
>  {
> -       struct bpf_subprog_info *p;
> +       struct bpf_subprog_info *vals =3D env->subprog_info;
> +       int high =3D env->subprog_cnt - 1;
> +       int low =3D 0, ret =3D -ENOENT;
>
> -       p =3D bsearch(&off, env->subprog_info, env->subprog_cnt,
> -                   sizeof(env->subprog_info[0]), cmp_subprogs);
> -       if (!p)
> +       if (off >=3D env->prog->len || off < 0)
>                 return -ENOENT;
> -       return p - env->subprog_info;
>
> +       while (low <=3D high) {
> +               int mid =3D (low + high)/2;

styling nit: (...) / 2

> +               struct bpf_subprog_info *val =3D &vals[mid];
> +               int diff =3D off - val->start;
> +
> +               if (diff < 0) {

tbh, this hurts my brain. Why not write human-readable and more meaningful

if (off < val->start)

?


> +                       high =3D mid - 1;
> +               } else {
> +                       low =3D mid + 1;
> +                       /* remember last time mid.start <=3D off */
> +                       ret =3D mid;
> +               }

feel free to ignore, but I find this unnecessary `ret =3D mid` part a
bit inelegant. See find_linfo in kernel/bpf/log.c for how
lower_bound-like binary search could be implemented without this (I
mean the pattern where invariant keeps low or high as always
satisfying the condition and the other one being adjusted with +1 or
-1, depending on desired logic).


> +       }
> +       return ret;
> +}
> +
> +/* Find subprogram that starts exactly at 'off' */
> +static int find_subprog(struct bpf_verifier_env *env, int off)
> +{
> +       int idx;
> +
> +       idx =3D find_containing_subprog(env, off);
> +       if (idx < 0 || env->subprog_info[idx].start !=3D off)
> +               return -ENOENT;
> +       return idx;
>  }
>

[...]

> +static u8 get_helper_reg_mask(const struct bpf_func_proto *fn)
> +{
> +       u8 mask;
> +       int i;
> +
> +       if (!fn->nocsr)
> +               return ALL_CALLER_SAVED_REGS;
> +
> +       mask =3D 0;
> +       mask |=3D fn->ret_type =3D=3D RET_VOID ? 0 : BIT(BPF_REG_0);
> +       for (i =3D 0; i < ARRAY_SIZE(fn->arg_type); ++i)
> +               mask |=3D fn->arg_type[i] =3D=3D ARG_DONTCARE ? 0 : BIT(B=
PF_REG_1 + i);

again subjective, but

if (fn->ret_type !=3D RET_VOID)
    mask |=3D BIT(BPF_REG_0);

(and similarly for ARG_DONTCARE)

seems a bit more readable and not that much more verbose

> +       return mask;
> +}
> +
> +/* True if do_misc_fixups() replaces calls to helper number 'imm',
> + * replacement patch is presumed to follow no_caller_saved_registers con=
tract
> + * (see match_and_mark_nocsr_pattern() below).
> + */
> +static bool verifier_inlines_helper_call(struct bpf_verifier_env *env, s=
32 imm)
> +{

note that there is now also bpf_jit_inlines_helper_call()


> +       return false;
> +}
> +
> +/* If 'insn' is a call that follows no_caller_saved_registers contract
> + * and called function is inlined by current jit, return a mask with
> + * 1s corresponding to registers that are scratched by this call
> + * (depends on return type and number of return parameters).
> + * Otherwise return ALL_CALLER_SAVED_REGS mask.
> + */
> +static u32 call_csr_mask(struct bpf_verifier_env *env, struct bpf_insn *=
insn)
> +{
> +       const struct bpf_func_proto *fn;
> +
> +       if (bpf_helper_call(insn) &&
> +           verifier_inlines_helper_call(env, insn->imm) &&

strictly speaking, does nocsr have anything to do with inlining,
though? E.g., if we know for sure (however, that's a separate issue)
that helper implementation doesn't touch extra registers, why do we
need inlining to make use of nocsr?

> +           get_helper_proto(env, insn->imm, &fn) =3D=3D 0 &&
> +           fn->nocsr)
> +               return ~get_helper_reg_mask(fn);
> +
> +       return ALL_CALLER_SAVED_REGS;
> +}
> +

[...]

> + * For example, it is *not* safe to remove spill/fill below:
> + *
> + *   r1 =3D 1;
> + *   *(u64 *)(r10 - 8)  =3D r1;            r1 =3D 1;
> + *   call %[to_be_inlined_by_jit]  -->   call %[to_be_inlined_by_jit]
> + *   r1 =3D *(u64 *)(r10 - 8);             r0 =3D *(u64 *)(r10 - 8);  <-=
--- wrong !!!
> + *   r0 =3D *(u64 *)(r10 - 8);             r0 +=3D r1;
> + *   r0 +=3D r1;                           exit;
> + *   exit;
> + */
> +static int match_and_mark_nocsr_pattern(struct bpf_verifier_env *env, in=
t t, bool mark)
> +{
> +       struct bpf_insn *insns =3D env->prog->insnsi, *stx, *ldx;
> +       struct bpf_subprog_info *subprog;
> +       u32 csr_mask =3D call_csr_mask(env, &insns[t]);
> +       u32 reg_mask =3D ~csr_mask | ~ALL_CALLER_SAVED_REGS;
> +       int s, i;
> +       s16 off;
> +
> +       if (csr_mask =3D=3D ALL_CALLER_SAVED_REGS)
> +               return false;

false -> 0 ?

> +
> +       for (i =3D 1, off =3D 0; i <=3D ARRAY_SIZE(caller_saved); ++i, of=
f +=3D BPF_REG_SIZE) {
> +               if (t - i < 0 || t + i >=3D env->prog->len)
> +                       break;
> +               stx =3D &insns[t - i];
> +               ldx =3D &insns[t + i];
> +               if (off =3D=3D 0) {
> +                       off =3D stx->off;
> +                       if (off % BPF_REG_SIZE !=3D 0)
> +                               break;

just return here?

> +               }
> +               if (/* *(u64 *)(r10 - off) =3D r[0-5]? */
> +                   stx->code !=3D (BPF_STX | BPF_MEM | BPF_DW) ||
> +                   stx->dst_reg !=3D BPF_REG_10 ||
> +                   /* r[0-5] =3D *(u64 *)(r10 - off)? */
> +                   ldx->code !=3D (BPF_LDX | BPF_MEM | BPF_DW) ||
> +                   ldx->src_reg !=3D BPF_REG_10 ||
> +                   /* check spill/fill for the same reg and offset */
> +                   stx->src_reg !=3D ldx->dst_reg ||
> +                   stx->off !=3D ldx->off ||
> +                   stx->off !=3D off ||
> +                   /* this should be a previously unseen register */
> +                   BIT(stx->src_reg) & reg_mask)
> +                       break;
> +               reg_mask |=3D BIT(stx->src_reg);
> +               if (mark) {
> +                       env->insn_aux_data[t - i].nocsr_pattern =3D true;
> +                       env->insn_aux_data[t + i].nocsr_pattern =3D true;
> +               }
> +       }
> +       if (i =3D=3D 1)
> +               return 0;
> +       if (mark) {
> +               s =3D find_containing_subprog(env, t);
> +               /* can't happen */
> +               if (WARN_ON_ONCE(s < 0))
> +                       return 0;
> +               subprog =3D &env->subprog_info[s];
> +               subprog->nocsr_stack_off =3D min(subprog->nocsr_stack_off=
, off);
> +       }

why not split pattern detection and all this other marking logic? You
can return "the size of csr pattern", meaning how many spills/fills
are there surrounding the call, no? Then all the marking can be done
(if necessary) by the caller.

The question is what to do with zero patter (no spills/fills for nocsr
call, is that valid case?)

> +       return i - 1;
> +}
> +
> +/* If instruction 't' is a nocsr call surrounded by spill/fill pairs,
> + * update env->subprog_info[_]->nocsr_stack_off and
> + * env->insn_aux_data[_].nocsr_pattern fields.
> + */
> +static void update_nocsr_pattern_marks(struct bpf_verifier_env *env, int=
 t)
> +{
> +       match_and_mark_nocsr_pattern(env, t, true);
> +}
> +
> +/* If instruction 't' is a nocsr call surrounded by spill/fill pairs,
> + * return the number of such pairs.
> + */
> +static int match_nocsr_pattern(struct bpf_verifier_env *env, int t)
> +{
> +       return match_and_mark_nocsr_pattern(env, t, false);
> +}
> +
>  /* Visits the instruction at index t and returns one of the following:
>   *  < 0 - an error occurred
>   *  DONE_EXPLORING - the instruction was fully explored
> @@ -16017,6 +16262,8 @@ static int visit_insn(int t, struct bpf_verifier_=
env *env)
>                                 mark_force_checkpoint(env, t);
>                         }
>                 }
> +               if (insn->src_reg =3D=3D 0)
> +                       update_nocsr_pattern_marks(env, t);

as you mentioned, we discussed moving this from check_cfg() step, as
it doesn't seem to be coupled with "graph" part of the algorithm

>                 return visit_func_call_insn(t, insns, env, insn->src_reg =
=3D=3D BPF_PSEUDO_CALL);
>
>         case BPF_JA:
> @@ -19063,15 +19310,16 @@ static int opt_remove_dead_code(struct bpf_veri=
fier_env *env)
>         return 0;
>  }
>
> +static const struct bpf_insn NOP =3D BPF_JMP_IMM(BPF_JA, 0, 0, 0);
> +
>  static int opt_remove_nops(struct bpf_verifier_env *env)
>  {
> -       const struct bpf_insn ja =3D BPF_JMP_IMM(BPF_JA, 0, 0, 0);
>         struct bpf_insn *insn =3D env->prog->insnsi;
>         int insn_cnt =3D env->prog->len;
>         int i, err;
>
>         for (i =3D 0; i < insn_cnt; i++) {
> -               if (memcmp(&insn[i], &ja, sizeof(ja)))
> +               if (memcmp(&insn[i], &NOP, sizeof(NOP)))
>                         continue;
>
>                 err =3D verifier_remove_insns(env, i, 1);
> @@ -20801,6 +21049,39 @@ static int optimize_bpf_loop(struct bpf_verifier=
_env *env)
>         return 0;
>  }
>
> +/* Remove unnecessary spill/fill pairs, members of nocsr pattern.
> + * Do this as a separate pass to avoid interfering with helper/kfunc
> + * inlining logic in do_misc_fixups().
> + * See comment for match_and_mark_nocsr_pattern().
> + */
> +static int remove_nocsr_spills_fills(struct bpf_verifier_env *env)
> +{
> +       struct bpf_subprog_info *subprogs =3D env->subprog_info;
> +       int i, j, spills_num, cur_subprog =3D 0;
> +       struct bpf_insn *insn =3D env->prog->insnsi;
> +       int insn_cnt =3D env->prog->len;
> +
> +       for (i =3D 0; i < insn_cnt; i++, insn++) {
> +               spills_num =3D match_nocsr_pattern(env, i);

we can probably afford a single-byte field somewhere in
bpf_insn_aux_data to remember "csr pattern size" instead of just a
true/false fact that it is nocsr call. And so we wouldn't need to do
pattern matching again here, we'll just have all the data.


> +               if (spills_num =3D=3D 0)
> +                       goto next_insn;
> +               for (j =3D 1; j <=3D spills_num; ++j)
> +                       if ((insn - j)->off >=3D subprogs[cur_subprog].no=
csr_stack_off ||
> +                           (insn + j)->off >=3D subprogs[cur_subprog].no=
csr_stack_off)
> +                               goto next_insn;
> +               /* NOPs are removed by opt_remove_nops() later */
> +               for (j =3D 1; j <=3D spills_num; ++j) {
> +                       *(insn - j) =3D NOP;
> +                       *(insn + j) =3D NOP;
> +               }
> +
> +next_insn:
> +               if (subprogs[cur_subprog + 1].start =3D=3D i + 1)
> +                       cur_subprog++;
> +       }
> +       return 0;
> +}
> +
>  static void free_states(struct bpf_verifier_env *env)
>  {
>         struct bpf_verifier_state_list *sl, *sln;
> @@ -21719,6 +22000,9 @@ int bpf_check(struct bpf_prog **prog, union bpf_a=
ttr *attr, bpfptr_t uattr, __u3
>         if (ret =3D=3D 0)
>                 ret =3D optimize_bpf_loop(env);
>
> +       if (ret =3D=3D 0)
> +               ret =3D remove_nocsr_spills_fills(env);
> +
>         if (is_priv) {
>                 if (ret =3D=3D 0)
>                         opt_hard_wire_dead_code_branches(env);
> --
> 2.45.2
>

