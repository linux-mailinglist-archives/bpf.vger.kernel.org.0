Return-Path: <bpf+bounces-34311-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8905692C6B8
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 01:42:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 017B41F22E4B
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 23:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A2F2189F40;
	Tue,  9 Jul 2024 23:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IPRRaiCw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5F8185627
	for <bpf@vger.kernel.org>; Tue,  9 Jul 2024 23:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720568542; cv=none; b=LrP/9mqVNMZZ5bMlTC9hOFvT6TysfYuUQYepeZtRFAhsesH0zwfp9xXLSqsYjRwajch59ZEXrH1KUgcdgNcANQj/WRs2wSRthMq2Ldw0XpgRAbsDsMx/FXKV1kf0Yvt08Owh+Vl1FgY2crsL7xuerS/zGxDYb/Rl22Hqb2Q/N6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720568542; c=relaxed/simple;
	bh=yTfC+GdgEIZbv9sJvudoyGC4nX95QIGa5xebos6mfaI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ul1pjXMkkO1hndVYoEV51KiYlzPjt6Yb4g794W5MEBJdjvm3tqOnECHmSZszPeaW+IU3hjs+aaUnTLIcbN29p04gkFlB8KBrdrIp1t5r0NanPDCYHmq5zFSNdxjPOIGhvsJDC2GWw52DMNjZMOqW62N71VKmr4eOmpr0SsAaBz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IPRRaiCw; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-70b09cb7776so3210553b3a.1
        for <bpf@vger.kernel.org>; Tue, 09 Jul 2024 16:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720568540; x=1721173340; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MromZVlI2OHMp6HrCEZlnIrhTGId8DWPMhGwqJTxkuQ=;
        b=IPRRaiCw6IplVooVjdLqBWe+X3jTk6Q8U1uArZyrdBiqlu7WIt1rwFpGNpGN6vjTI1
         Zig6Fs6tJJ4RCuw1/LChWOS09GiwgBUWmSr165BqXcZNNHRJ9srPUIu2HlxxDc6rSlEG
         4LixtsWbv+Pa5hefTlDLdRVRJfoFoeTlHluAwPLHxDIZXfUM1aIkjb4BX4EXkZbJL3wv
         m5bNRcyWb4nfiboFgAfFqnWyBEyAh7DZMPxUdRbjLB8vB4BDchMQYcYdc/xR7m8RlK8J
         79oVEVqkw/II+AkczJjnKPFv1EozX4c2k1OroLANKt4gfagIuNxlY92Tb61Wa1NZzgLA
         7eyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720568540; x=1721173340;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MromZVlI2OHMp6HrCEZlnIrhTGId8DWPMhGwqJTxkuQ=;
        b=wsH3brofAwOvz4W9bhIa83AkQw/zTzY14GHUghfq46wnGSZ56s6ufTDWL1jYzKuWII
         NmTRSgwGEbcIJ5Eziv2UTg86S23pGA+x+Aj/iH+q7asY4tH+kFpUDEKYBU/IAJA719/Y
         86r4VwLvfWQwxYWF82JCQT7Bifi7ZKOqHnRPv0CREYL4jbW2fC3tRUeRqQ5phAGY/xhf
         JrIvk1TZk8jvy0Z1YM19blafdtyZ/4pSc+cLSCjdb/1vVC+vDhStIsc8ze09otK2xzAc
         X6TGJWisc2iPZXT0qtOKRIeqAnOz93Six/3He3W8pQUkgqJ7ctSepUKzVAMsWWSPB36g
         JwQA==
X-Gm-Message-State: AOJu0YzeqOG4lq/iARqPX1nGXLt6AiU0Cc/Xv9GkFnSh6DWG6/SlINIx
	KUxMobdEoVDlbTRfwErDCvdmkkrzaNzA2Z7sDsFzuQINO79UpMIFHu0qkOf5j/b6nXh+FsmjC4s
	+RD0Lp9Ziy1Tr+41j9oIWSmBW9K0=
X-Google-Smtp-Source: AGHT+IEaCqfLpceM2nmDvStrqtDvl4zb38xBvjaPq6PT79zhXZpex/Z3OUJBbv0I5hbQoOny+l353TE3yuFnQXfyD3o=
X-Received: by 2002:a05:6a00:8d0:b0:70b:5394:8cae with SMTP id
 d2e1a72fcca58-70b539490e4mr107434b3a.28.1720568539767; Tue, 09 Jul 2024
 16:42:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240704102402.1644916-1-eddyz87@gmail.com> <20240704102402.1644916-3-eddyz87@gmail.com>
In-Reply-To: <20240704102402.1644916-3-eddyz87@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 9 Jul 2024 16:42:07 -0700
Message-ID: <CAEf4BzaC--u8egj_JXrR4VoedeFdX3W=sKZt1aO9+ed44tQxWw@mail.gmail.com>
Subject: Re: [RFC bpf-next v2 2/9] bpf: no_caller_saved_registers attribute
 for helper calls
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev, puranjay@kernel.org, jose.marchesi@oracle.com, 
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 4, 2024 at 3:24=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> GCC and LLVM define a no_caller_saved_registers function attribute.
> This attribute means that function scratches only some of
> the caller saved registers defined by ABI.
> For BPF the set of such registers could be defined as follows:
> - R0 is scratched only if function is non-void;
> - R1-R5 are scratched only if corresponding parameter type is defined
>   in the function prototype.
>
> This commit introduces flag bpf_func_prot->allow_nocsr.
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
>     call %[to_be_inlined]
>     r2 =3D *(u64 *)(r10 - 16);
>     r1 =3D *(u64 *)(r10 - 8);
>     r0 =3D r1;
>     r0 +=3D r2;
>     exit;
>
> - kernel removes unnecessary spills and fills, if called function is
>   inlined by verifier or current JIT (with assumption that patch
>   inserted by verifier or JIT honors nocsr contract, e.g. does not
>   scratch r3-r5 for the example above), e.g. the code above would be
>   transformed to:
>
>     r1 =3D 1;
>     r2 =3D 2;
>     call %[to_be_inlined]
>     r0 =3D r1;
>     r0 +=3D r2;
>     exit;
>
> Technically, the transformation is split into the following phases:
> - function mark_nocsr_pattern_patterns(), called from bpf_check()
>   searches and marks potential patterns in instruction auxiliary data;
> - upon stack read or write access,
>   function check_nocsr_stack_contract() is used to verify if
>   stack offsets, presumably reserved for nocsr patterns, are used
>   only from those patterns;
> - function do_misc_fixups(), called from bpf_check(),
>   applies the rewrite for valid patterns.
>
> See comment in mark_nocsr_pattern_for_call() for more details.
>
> Suggested-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
>  include/linux/bpf.h          |   6 +
>  include/linux/bpf_verifier.h |  14 ++
>  kernel/bpf/verifier.c        | 300 ++++++++++++++++++++++++++++++++++-
>  3 files changed, 314 insertions(+), 6 deletions(-)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 960780ef04e1..391e19c5cd68 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -807,6 +807,12 @@ struct bpf_func_proto {
>         bool gpl_only;
>         bool pkt_access;
>         bool might_sleep;
> +       /* set to true if helper follows contract for gcc/llvm
> +        * attribute no_caller_saved_registers:
> +        * - void functions do not scratch r0
> +        * - functions taking N arguments scratch only registers r1-rN
> +        */
> +       bool allow_nocsr;
>         enum bpf_return_type ret_type;
>         union {
>                 struct {
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 2b54e25d2364..735ae0901b3d 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -585,6 +585,15 @@ struct bpf_insn_aux_data {
>          * accepts callback function as a parameter.
>          */
>         bool calls_callback;
> +       /* true if STX or LDX instruction is a part of a spill/fill
> +        * pattern for a no_caller_saved_registers call.
> +        */
> +       u8 nocsr_pattern:1;
> +       /* for CALL instructions, a number of spill/fill pairs in the
> +        * no_caller_saved_registers pattern.
> +        */
> +       u8 nocsr_spills_num:3;

despite bitfields this will extend bpf_insn_aux_data by 8 bytes. there
are 2 bytes of padding after alu_state, let's put this there.

And let's not add bitfields unless absolutely necessary (this can be
always done later).

> +
>  };
>
>  #define MAX_USED_MAPS 64 /* max number of maps accessed by one eBPF prog=
ram */
> @@ -641,6 +650,11 @@ struct bpf_subprog_info {
>         u32 linfo_idx; /* The idx to the main_prog->aux->linfo */
>         u16 stack_depth; /* max. stack depth used by this function */
>         u16 stack_extra;
> +       /* stack depth after which slots reserved for
> +        * no_caller_saved_registers spills/fills start,
> +        * value <=3D nocsr_stack_off belongs to the spill/fill area.

are you sure about <=3D (not <), it seems like nocsr_stack_off is
exclusive right bound for nocsr stack region (it would be good to call
this out explicitly here)

> +        */
> +       s16 nocsr_stack_off;
>         bool has_tail_call: 1;
>         bool tail_call_reachable: 1;
>         bool has_ld_abs: 1;
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 4869f1fb0a42..d16a249b59ad 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -2471,16 +2471,37 @@ static int cmp_subprogs(const void *a, const void=
 *b)
>                ((struct bpf_subprog_info *)b)->start;
>  }
>
> -static int find_subprog(struct bpf_verifier_env *env, int off)
> +/* Find subprogram that contains instruction at 'off' */
> +static int find_containing_subprog(struct bpf_verifier_env *env, int off=
)
>  {
> -       struct bpf_subprog_info *p;
> +       struct bpf_subprog_info *vals =3D env->subprog_info;
> +       int l, r, m;
>
> -       p =3D bsearch(&off, env->subprog_info, env->subprog_cnt,
> -                   sizeof(env->subprog_info[0]), cmp_subprogs);
> -       if (!p)
> +       if (off >=3D env->prog->len || off < 0 || env->subprog_cnt =3D=3D=
 0)
>                 return -ENOENT;
> -       return p - env->subprog_info;
>
> +       l =3D 0;
> +       m =3D 0;

no need to initialize m

> +       r =3D env->subprog_cnt - 1;
> +       while (l < r) {
> +               m =3D l + (r - l + 1) / 2;
> +               if (vals[m].start <=3D off)
> +                       l =3D m;
> +               else
> +                       r =3D m - 1;
> +       }
> +       return l;
> +}

I love it, looks great :)

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
>  static int add_subprog(struct bpf_verifier_env *env, int off)
> @@ -4501,6 +4522,23 @@ static int get_reg_width(struct bpf_reg_state *reg=
)
>         return fls64(reg->umax_value);
>  }
>
> +/* See comment for mark_nocsr_pattern_for_call() */
> +static void check_nocsr_stack_contract(struct bpf_verifier_env *env, str=
uct bpf_func_state *state,
> +                                      int insn_idx, int off)
> +{
> +       struct bpf_subprog_info *subprog =3D &env->subprog_info[state->su=
bprogno];
> +       struct bpf_insn_aux_data *aux =3D &env->insn_aux_data[insn_idx];
> +
> +       if (subprog->nocsr_stack_off <=3D off || aux->nocsr_pattern)
> +               return;

can helper call instruction go through this check? E.g., if we do
bpf_probe_read_kernel() into stack slot, where do we check that that
slot is not overlapping with nocsr spill/fill region?

> +       /* access to the region [max_stack_depth .. nocsr_stack_off]

ok, here nocsr_stack_off should be exclusive, no?

> +        * from something that is not a part of the nocsr pattern,
> +        * disable nocsr rewrites for current subprogram by setting
> +        * nocsr_stack_off to a value smaller than any possible offset.
> +        */
> +       subprog->nocsr_stack_off =3D S16_MIN;
> +}
> +
>  /* check_stack_{read,write}_fixed_off functions track spill/fill of regi=
sters,
>   * stack boundary and alignment are checked in check_mem_access()
>   */
> @@ -4549,6 +4587,7 @@ static int check_stack_write_fixed_off(struct bpf_v=
erifier_env *env,
>         if (err)
>                 return err;
>
> +       check_nocsr_stack_contract(env, state, insn_idx, off);
>         mark_stack_slot_scratched(env, spi);
>         if (reg && !(off % BPF_REG_SIZE) && reg->type =3D=3D SCALAR_VALUE=
 && env->bpf_capable) {
>                 bool reg_value_fits;
> @@ -4682,6 +4721,7 @@ static int check_stack_write_var_off(struct bpf_ver=
ifier_env *env,
>                         return err;
>         }
>
> +       check_nocsr_stack_contract(env, state, insn_idx, min_off);
>         /* Variable offset writes destroy any spilled pointers in range. =
*/
>         for (i =3D min_off; i < max_off; i++) {
>                 u8 new_type, *stype;
> @@ -4820,6 +4860,7 @@ static int check_stack_read_fixed_off(struct bpf_ve=
rifier_env *env,
>         reg =3D &reg_state->stack[spi].spilled_ptr;
>
>         mark_stack_slot_scratched(env, spi);
> +       check_nocsr_stack_contract(env, state, env->insn_idx, off);
>
>         if (is_spilled_reg(&reg_state->stack[spi])) {
>                 u8 spill_size =3D 1;
> @@ -4980,6 +5021,7 @@ static int check_stack_read_var_off(struct bpf_veri=
fier_env *env,
>         min_off =3D reg->smin_value + off;
>         max_off =3D reg->smax_value + off;
>         mark_reg_stack_read(env, ptr_state, min_off, max_off + size, dst_=
regno);
> +       check_nocsr_stack_contract(env, ptr_state, env->insn_idx, min_off=
);
>         return 0;
>  }
>
> @@ -15951,6 +15993,206 @@ static int visit_func_call_insn(int t, struct b=
pf_insn *insns,
>         return ret;
>  }
>
> +/* Bitmask with 1s for all caller saved registers */
> +#define ALL_CALLER_SAVED_REGS ((1u << CALLER_SAVED_REGS) - 1)
> +
> +/* Return a bitmask specifying which caller saved registers are
> + * modified by a call to a helper.
> + * (Either as a return value or as scratch registers).
> + *
> + * For normal helpers registers R0-R5 are scratched.
> + * For helpers marked as no_csr:
> + * - scratch R0 if function is non-void;
> + * - scratch R1-R5 if corresponding parameter type is set
> + *   in the function prototype.
> + */
> +static u8 get_helper_reg_mask(const struct bpf_func_proto *fn)

suggestion: to make this less confusing, here we are returning a mask
of registers that are clobbered by the helper, is that right? so
get_helper_clobber_mask() maybe?

> +{
> +       u8 mask;
> +       int i;
> +
> +       if (!fn->allow_nocsr)
> +               return ALL_CALLER_SAVED_REGS;
> +
> +       mask =3D 0;
> +       if (fn->ret_type !=3D RET_VOID)
> +               mask |=3D BIT(BPF_REG_0);
> +       for (i =3D 0; i < ARRAY_SIZE(fn->arg_type); ++i)
> +               if (fn->arg_type[i] !=3D ARG_DONTCARE)
> +                       mask |=3D BIT(BPF_REG_1 + i);
> +       return mask;
> +}
> +
> +/* True if do_misc_fixups() replaces calls to helper number 'imm',
> + * replacement patch is presumed to follow no_caller_saved_registers con=
tract
> + * (see mark_nocsr_pattern_for_call() below).
> + */
> +static bool verifier_inlines_helper_call(struct bpf_verifier_env *env, s=
32 imm)
> +{
> +       return false;
> +}
> +
> +/* If 'insn' is a call that follows no_caller_saved_registers contract
> + * and called function is inlined by current jit or verifier,
> + * return a mask with 1s corresponding to registers that are scratched
> + * by this call (depends on return type and number of return parameters)=
.

return parameters? was it supposed to be "function parameters/arguments"?

> + * Otherwise return ALL_CALLER_SAVED_REGS mask.
> + */
> +static u32 call_csr_mask(struct bpf_verifier_env *env, struct bpf_insn *=
insn)

you use u8 for get_helper_reg_mask() and u32 here, why not keep them consis=
tent?

similar to the naming nit above, I think we should be a bit more
explicit with what "mask" actually means. Is this also clobber mask?

> +{
> +       const struct bpf_func_proto *fn;
> +
> +       if (bpf_helper_call(insn) &&
> +           (verifier_inlines_helper_call(env, insn->imm) || bpf_jit_inli=
nes_helper_call(insn->imm)) &&
> +           get_helper_proto(env, insn->imm, &fn) =3D=3D 0 &&
> +           fn->allow_nocsr)
> +               return ~get_helper_reg_mask(fn);

hm... I'm a bit confused why we do a negation here? aren't we working
with clobbering mask... I'll keep reading for now.

> +
> +       return ALL_CALLER_SAVED_REGS;
> +}
> +
> +/* GCC and LLVM define a no_caller_saved_registers function attribute.
> + * This attribute means that function scratches only some of
> + * the caller saved registers defined by ABI.
> + * For BPF the set of such registers could be defined as follows:
> + * - R0 is scratched only if function is non-void;
> + * - R1-R5 are scratched only if corresponding parameter type is defined
> + *   in the function prototype.
> + *
> + * The contract between kernel and clang allows to simultaneously use
> + * such functions and maintain backwards compatibility with old
> + * kernels that don't understand no_caller_saved_registers calls
> + * (nocsr for short):
> + *
> + * - for nocsr calls clang allocates registers as-if relevant r0-r5
> + *   registers are not scratched by the call;
> + *
> + * - as a post-processing step, clang visits each nocsr call and adds
> + *   spill/fill for every live r0-r5;
> + *
> + * - stack offsets used for the spill/fill are allocated as minimal
> + *   stack offsets in whole function and are not used for any other
> + *   purposes;
> + *
> + * - when kernel loads a program, it looks for such patterns
> + *   (nocsr function surrounded by spills/fills) and checks if
> + *   spill/fill stack offsets are used exclusively in nocsr patterns;
> + *
> + * - if so, and if verifier or current JIT inlines the call to the
> + *   nocsr function (e.g. a helper call), kernel removes unnecessary
> + *   spill/fill pairs;
> + *
> + * - when old kernel loads a program, presence of spill/fill pairs
> + *   keeps BPF program valid, albeit slightly less efficient.
> + *
> + * For example:
> + *
> + *   r1 =3D 1;
> + *   r2 =3D 2;
> + *   *(u64 *)(r10 - 8)  =3D r1;            r1 =3D 1;
> + *   *(u64 *)(r10 - 16) =3D r2;            r2 =3D 2;
> + *   call %[to_be_inlined]         -->   call %[to_be_inlined]
> + *   r2 =3D *(u64 *)(r10 - 16);            r0 =3D r1;
> + *   r1 =3D *(u64 *)(r10 - 8);             r0 +=3D r2;
> + *   r0 =3D r1;                            exit;
> + *   r0 +=3D r2;
> + *   exit;
> + *
> + * The purpose of mark_nocsr_pattern_for_call is to:
> + * - look for such patterns;
> + * - mark spill and fill instructions in env->insn_aux_data[*].nocsr_pat=
tern;
> + * - mark set env->insn_aux_data[*].nocsr_spills_num for call instructio=
n;
> + * - update env->subprog_info[*]->nocsr_stack_off to find an offset
> + *   at which nocsr spill/fill stack slots start.
> + *
> + * The .nocsr_pattern and .nocsr_stack_off are used by
> + * check_nocsr_stack_contract() to check if every stack access to
> + * nocsr spill/fill stack slot originates from spill/fill
> + * instructions, members of nocsr patterns.
> + *
> + * If such condition holds true for a subprogram, nocsr patterns could
> + * be rewritten by do_misc_fixups().
> + * Otherwise nocsr patterns are not changed in the subprogram
> + * (code, presumably, generated by an older clang version).
> + *
> + * For example, it is *not* safe to remove spill/fill below:
> + *
> + *   r1 =3D 1;
> + *   *(u64 *)(r10 - 8)  =3D r1;            r1 =3D 1;
> + *   call %[to_be_inlined]         -->   call %[to_be_inlined]
> + *   r1 =3D *(u64 *)(r10 - 8);             r0 =3D *(u64 *)(r10 - 8);  <-=
--- wrong !!!
> + *   r0 =3D *(u64 *)(r10 - 8);             r0 +=3D r1;
> + *   r0 +=3D r1;                           exit;
> + *   exit;
> + */
> +static void mark_nocsr_pattern_for_call(struct bpf_verifier_env *env, in=
t t)

t is insn_idx, let's not carry over old crufty check_cfg naming

> +{
> +       struct bpf_insn *insns =3D env->prog->insnsi, *stx, *ldx;
> +       struct bpf_subprog_info *subprog;
> +       u32 csr_mask =3D call_csr_mask(env, &insns[t]);
> +       u32 reg_mask =3D ~csr_mask | ~ALL_CALLER_SAVED_REGS;

tbh, I'm lost with all these bitmask and their inversions...
call_csr_mask()'s result is basically always used inverted, so why not
return inverted mask in the first place?

> +       int s, i;
> +       s16 off;
> +
> +       if (csr_mask =3D=3D ALL_CALLER_SAVED_REGS)
> +               return;
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

kind of ugly that we assume stx before we actually checked that it's
STX?... maybe split humongous if below into instruction checking
(with code and src_reg) and then off checking separately?

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

() around & operation?

> +                       break;
> +               reg_mask |=3D BIT(stx->src_reg);
> +               env->insn_aux_data[t - i].nocsr_pattern =3D 1;
> +               env->insn_aux_data[t + i].nocsr_pattern =3D 1;
> +       }
> +       if (i =3D=3D 1)
> +               return;
> +       env->insn_aux_data[t].nocsr_spills_num =3D i - 1;
> +       s =3D find_containing_subprog(env, t);
> +       /* can't happen */

then don't check ;) we leave the state partially set for CSR but not
quite. We either should error out completely or just assume
correctness of find_containing_subprog, IMO

> +       if (WARN_ON_ONCE(s < 0))
> +               return;
> +       subprog =3D &env->subprog_info[s];
> +       subprog->nocsr_stack_off =3D min(subprog->nocsr_stack_off, off);

should this be max()? offsets are negative, right? so if nocsr uses -8
and -16 as in the example, entire [-16, 0) region is nocsr region

> +}
> +
> +/* Update the following fields when appropriate:
> + * - env->insn_aux_data[*].nocsr_pattern
> + * - env->insn_aux_data[*].spills_num and
> + * - env->subprog_info[*].nocsr_stack_off
> + * See mark_nocsr_pattern_for_call().
> + */
> +static int mark_nocsr_patterns(struct bpf_verifier_env *env)
> +{
> +       struct bpf_insn *insn =3D env->prog->insnsi;
> +       int i, insn_cnt =3D env->prog->len;
> +
> +       for (i =3D 0; i < insn_cnt; i++, insn++)
> +               /* might be extended to handle kfuncs as well */
> +               if (bpf_helper_call(insn))
> +                       mark_nocsr_pattern_for_call(env, i);
> +       return 0;
> +}
> +
>  /* Visits the instruction at index t and returns one of the following:
>   *  < 0 - an error occurred
>   *  DONE_EXPLORING - the instruction was fully explored
> @@ -20119,6 +20361,48 @@ static int do_misc_fixups(struct bpf_verifier_en=
v *env)
>                         goto next_insn;
>                 if (insn->src_reg =3D=3D BPF_PSEUDO_CALL)
>                         goto next_insn;
> +               /* Remove unnecessary spill/fill pairs, members of nocsr =
pattern */
> +               if (env->insn_aux_data[i + delta].nocsr_spills_num > 0) {
> +                       u32 j, spills_num =3D env->insn_aux_data[i + delt=
a].nocsr_spills_num;
> +                       int err;
> +
> +                       /* don't apply this on a second visit */
> +                       env->insn_aux_data[i + delta].nocsr_spills_num =
=3D 0;
> +
> +                       /* check if spill/fill stack access is in expecte=
d offset range */
> +                       for (j =3D 1; j <=3D spills_num; ++j) {
> +                               if ((insn - j)->off >=3D subprogs[cur_sub=
prog].nocsr_stack_off ||
> +                                   (insn + j)->off >=3D subprogs[cur_sub=
prog].nocsr_stack_off) {
> +                                       /* do a second visit of this inst=
ruction,
> +                                        * so that verifier can inline it
> +                                        */
> +                                       i -=3D 1;
> +                                       insn -=3D 1;
> +                                       goto next_insn;
> +                               }
> +                       }

I don't get this loop, can you elaborate? Why are we double-checking
anything here, didn't we do this already?

> +
> +                       /* apply the rewrite:
> +                        *   *(u64 *)(r10 - X) =3D rY ; num-times
> +                        *   call()                               -> call=
()
> +                        *   rY =3D *(u64 *)(r10 - X) ; num-times
> +                        */
> +                       err =3D verifier_remove_insns(env, i + delta - sp=
ills_num, spills_num);
> +                       if (err)
> +                               return err;
> +                       err =3D verifier_remove_insns(env, i + delta - sp=
ills_num + 1, spills_num);
> +                       if (err)
> +                               return err;

why not a single bpf_patch_insn_data()?

> +
> +                       i +=3D spills_num - 1;
> +                       /*   ^            ^   do a second visit of this i=
nstruction,
> +                        *   |            '-- so that verifier can inline=
 it
> +                        *   '--------------- jump over deleted fills
> +                        */
> +                       delta -=3D 2 * spills_num;
> +                       insn =3D env->prog->insnsi + i + delta;
> +                       goto next_insn;

why not adjust the state and just fall through, what goto next_insn
does that we can't (and next instruction is misleading, so I'd rather
fix up and move forward)

> +               }
>                 if (insn->src_reg =3D=3D BPF_PSEUDO_KFUNC_CALL) {
>                         ret =3D fixup_kfunc_call(env, insn, insn_buf, i +=
 delta, &cnt);
>                         if (ret)
> @@ -21704,6 +21988,10 @@ int bpf_check(struct bpf_prog **prog, union bpf_=
attr *attr, bpfptr_t uattr, __u3
>         if (ret < 0)
>                 goto skip_full_check;
>
> +       ret =3D mark_nocsr_patterns(env);
> +       if (ret < 0)
> +               goto skip_full_check;
> +
>         ret =3D do_check_main(env);
>         ret =3D ret ?: do_check_subprogs(env);
>
> --
> 2.45.2
>

