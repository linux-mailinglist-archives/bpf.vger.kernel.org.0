Return-Path: <bpf+bounces-14058-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E171E7DFDED
	for <lists+bpf@lfdr.de>; Fri,  3 Nov 2023 03:14:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75872281DF1
	for <lists+bpf@lfdr.de>; Fri,  3 Nov 2023 02:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A9F61377;
	Fri,  3 Nov 2023 02:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="doSshCf2"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 091CC1360
	for <bpf@vger.kernel.org>; Fri,  3 Nov 2023 02:14:13 +0000 (UTC)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3597196
	for <bpf@vger.kernel.org>; Thu,  2 Nov 2023 19:14:11 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-9c3aec5f326so533424366b.1
        for <bpf@vger.kernel.org>; Thu, 02 Nov 2023 19:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698977650; x=1699582450; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bsfkpz5xw1QKxpRqfVAzIcYDO1wDr/F0HH8jIKXYkJE=;
        b=doSshCf2EPX0perP6Q6ZqAYmIDNm9t05bTq4v4IQwsASfndewGpCoNluZN/wDqUF0E
         0qjTp/BjWbynjVOi3g3vg3WZxA17srmXYXBtRXOotMefWLL2GUeswibHByq2WVtpqvb/
         MsmO1ZJTwIiWNURLM9DzIVgLBwhv+CXYBJytp7D+d5tqZ4xsRIPIO5ZygdrkX3l4qX7p
         IoVXZ/nQYR87y8GkE7gmihgdy85aQQYkU1bb8wbFLdJbp/XH/oA2EVj4qtMEf/6BXurI
         Xz8q8gqQuLQYGVh53yPe1rZ+ce5DFlmP0FN+Mkbm6n2AonfmO6cxWvHOyKPu2kcPEuCV
         Igiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698977650; x=1699582450;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bsfkpz5xw1QKxpRqfVAzIcYDO1wDr/F0HH8jIKXYkJE=;
        b=Y+EN0M3zvdrNs7yd7rE1tuXylcPfNueGgvI/LpyWJJ7zpdazcAJB2CsISiw7SX86wR
         aoGcrmW21Zxq85hVbbP7vqsdT7JH2brdYHxrdbvLRdzC6HXvUVqo0b3NmF5hhcIYhOg1
         ZV9gA7zPEkVReaNSk5PvtYPW3PtABuOm7ocjQlJMMFn2whQy6HkSqBPZsseMIt8BEV4M
         myrw2wfhJ01r+cnvYBfUslxlsoLKKHnDk3C9WnR0Djn++Z4F7vQ56E/BauNN3cD2Ogix
         UlPJD/8IMGcaf56U8Wt1RomikadeuyAlAJrwsMR/JycuMuf7A0Dvb50d3LxSxfnQEYi5
         Uvag==
X-Gm-Message-State: AOJu0YxZ22BgsCqcaF2jhma+TPtt4/sMRvgsgTnOyAL8Qgvd7fiV4gj+
	6DKjhMvM34Jo35zS9UFKsJuNmo2/+XkFXTL3ZeV3NSPUz28=
X-Google-Smtp-Source: AGHT+IH6D2ftWPF8neO67ezKVzeAh185Njb3eMZMzd9FaNZM/mEeJiNDlbu6K9jltRGsPujAT90nCCKAcLp+FRZODCE=
X-Received: by 2002:a17:906:6a20:b0:9da:de61:8a7 with SMTP id
 qw32-20020a1709066a2000b009dade6108a7mr1488596ejc.10.1698977649903; Thu, 02
 Nov 2023 19:14:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231103000822.2509815-1-andrii@kernel.org> <20231103000822.2509815-5-andrii@kernel.org>
In-Reply-To: <20231103000822.2509815-5-andrii@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 2 Nov 2023 19:13:58 -0700
Message-ID: <CAEf4BzaPLh7Amjie_pqWAF_nAofKYcjSdohx5L88C04kGUCRFA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 04/13] bpf: add register bounds sanity checks and sanitization
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 2, 2023 at 5:08=E2=80=AFPM Andrii Nakryiko <andrii@kernel.org> =
wrote:
>
> Add simple sanity checks that validate well-formed ranges (min <=3D max)
> across u64, s64, u32, and s32 ranges. Also for cases when the value is
> constant (either 64-bit or 32-bit), we validate that ranges and tnums
> are in agreement.
>
> These bounds checks are performed at the end of BPF_ALU/BPF_ALU64
> operations, on conditional jumps, and for LDX instructions (where subreg
> zero/sign extension is probably the most important to check). This
> covers most of the interesting cases.
>
> Also, we validate the sanity of the return register when manually
> adjusting it for some special helpers.
>
> By default, sanity violation will trigger a warning in verifier log and
> resetting register bounds to "unbounded" ones. But to aid development
> and debugging, BPF_F_TEST_SANITY_STRICT flag is added, which will
> trigger hard failure of verification with -EFAULT on register bounds
> violations. This allows selftests to catch such issues. veristat will
> also gain a CLI option to enable this behavior.
>

BTW, besides two verifier_bounds "artificial" selftests, we seem to
have one more violation in more real-world-like test:
bpf_cubic.bpf.c's bpf_cubic_cong_avoid:

; if (!(x & (~0ull << (BITS_PER_U64-1))))
166: (65) if r1 s> 0xffffffff goto pc+1
REG SANITY VIOLATION (true_reg1): range bounds violation
u64=3D[0x4000000000000000, 0x1fd809fd00000000] s64=3D[0x0,
0x1fd809fd00000000] u32=3D[0x0, 0x0] s32=3D[0x0, 0x0] var_off=3D(0x0,
0x1fd809fd00000000)

We get to the point where R1 state is like this (before violation
checks detection was added):

R1=3Dscalar(id=3D59,smin=3Dumin=3D4611686018427387904,smax=3Dumax=3D2294594=
992376643584,smin32=3D0,smax32=3Dumax32=3D0,var_off=3D(0x0;
0x1fd809fd00000000))

umin >=3D umax, smin >=3D smax.

All this before any of the verifier changes we landed in the previous
patch set. I.e., none of my changes caused this breakage, it's
pre-existing problem.

> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  include/linux/bpf_verifier.h   |   1 +
>  include/uapi/linux/bpf.h       |   3 +
>  kernel/bpf/syscall.c           |   3 +-
>  kernel/bpf/verifier.c          | 117 ++++++++++++++++++++++++++-------
>  tools/include/uapi/linux/bpf.h |   3 +
>  5 files changed, 101 insertions(+), 26 deletions(-)
>
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 24213a99cc79..402b6bc44a1b 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -602,6 +602,7 @@ struct bpf_verifier_env {
>         int stack_size;                 /* number of states to be process=
ed */
>         bool strict_alignment;          /* perform strict pointer alignme=
nt checks */
>         bool test_state_freq;           /* test verifier with different p=
runing frequency */
> +       bool test_sanity_strict;        /* fail verification on sanity vi=
olations */
>         struct bpf_verifier_state *cur_state; /* current verifier state *=
/
>         struct bpf_verifier_state_list **explored_states; /* search pruni=
ng optimization */
>         struct bpf_verifier_state_list *free_list;
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 0f6cdf52b1da..b99c1e0e2730 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -1200,6 +1200,9 @@ enum bpf_perf_event_type {
>   */
>  #define BPF_F_XDP_DEV_BOUND_ONLY       (1U << 6)
>
> +/* The verifier internal test flag. Behavior is undefined */
> +#define BPF_F_TEST_SANITY_STRICT       (1U << 7)
> +
>  /* link_create.kprobe_multi.flags used in LINK_CREATE command for
>   * BPF_TRACE_KPROBE_MULTI attach type to create return probe.
>   */
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 0ed286b8a0f0..f266e03ba342 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -2573,7 +2573,8 @@ static int bpf_prog_load(union bpf_attr *attr, bpfp=
tr_t uattr, u32 uattr_size)
>                                  BPF_F_SLEEPABLE |
>                                  BPF_F_TEST_RND_HI32 |
>                                  BPF_F_XDP_HAS_FRAGS |
> -                                BPF_F_XDP_DEV_BOUND_ONLY))
> +                                BPF_F_XDP_DEV_BOUND_ONLY |
> +                                BPF_F_TEST_SANITY_STRICT))
>                 return -EINVAL;
>
>         if (!IS_ENABLED(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS) &&
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 8691cacd3ad3..af4e2fecbef2 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -2615,6 +2615,56 @@ static void reg_bounds_sync(struct bpf_reg_state *=
reg)
>         __update_reg_bounds(reg);
>  }
>
> +static int reg_bounds_sanity_check(struct bpf_verifier_env *env,
> +                                  struct bpf_reg_state *reg, const char =
*ctx)
> +{
> +       const char *msg;
> +
> +       if (reg->umin_value > reg->umax_value ||
> +           reg->smin_value > reg->smax_value ||
> +           reg->u32_min_value > reg->u32_max_value ||
> +           reg->s32_min_value > reg->s32_max_value) {
> +                   msg =3D "range bounds violation";
> +                   goto out;
> +       }
> +
> +       if (tnum_is_const(reg->var_off)) {
> +               u64 uval =3D reg->var_off.value;
> +               s64 sval =3D (s64)uval;
> +
> +               if (reg->umin_value !=3D uval || reg->umax_value !=3D uva=
l ||
> +                   reg->smin_value !=3D sval || reg->smax_value !=3D sva=
l) {
> +                       msg =3D "const tnum out of sync with range bounds=
";
> +                       goto out;
> +               }
> +       }
> +
> +       if (tnum_subreg_is_const(reg->var_off)) {
> +               u32 uval32 =3D tnum_subreg(reg->var_off).value;
> +               s32 sval32 =3D (s32)uval32;
> +
> +               if (reg->u32_min_value !=3D uval32 || reg->u32_max_value =
!=3D uval32 ||
> +                   reg->s32_min_value !=3D sval32 || reg->s32_max_value =
!=3D sval32) {
> +                       msg =3D "const subreg tnum out of sync with range=
 bounds";
> +                       goto out;
> +               }
> +       }
> +
> +       return 0;
> +out:
> +       verbose(env, "REG SANITY VIOLATION (%s): %s u64=3D[%#llx, %#llx] =
"
> +               "s64=3D[%#llx, %#llx] u32=3D[%#x, %#x] s32=3D[%#x, %#x] v=
ar_off=3D(%#llx, %#llx)\n",
> +               ctx, msg, reg->umin_value, reg->umax_value,
> +               reg->smin_value, reg->smax_value,
> +               reg->u32_min_value, reg->u32_max_value,
> +               reg->s32_min_value, reg->s32_max_value,
> +               reg->var_off.value, reg->var_off.mask);
> +       if (env->test_sanity_strict)
> +               return -EFAULT;
> +       __mark_reg_unbounded(reg);
> +       return 0;
> +}
> +
>  static bool __reg32_bound_s64(s32 a)
>  {
>         return a >=3D 0 && a <=3D S32_MAX;
> @@ -9928,14 +9978,15 @@ static int prepare_func_exit(struct bpf_verifier_=
env *env, int *insn_idx)
>         return 0;
>  }
>
> -static void do_refine_retval_range(struct bpf_reg_state *regs, int ret_t=
ype,
> -                                  int func_id,
> -                                  struct bpf_call_arg_meta *meta)
> +static int do_refine_retval_range(struct bpf_verifier_env *env,
> +                                 struct bpf_reg_state *regs, int ret_typ=
e,
> +                                 int func_id,
> +                                 struct bpf_call_arg_meta *meta)
>  {
>         struct bpf_reg_state *ret_reg =3D &regs[BPF_REG_0];
>
>         if (ret_type !=3D RET_INTEGER)
> -               return;
> +               return 0;
>
>         switch (func_id) {
>         case BPF_FUNC_get_stack:
> @@ -9961,6 +10012,8 @@ static void do_refine_retval_range(struct bpf_reg_=
state *regs, int ret_type,
>                 reg_bounds_sync(ret_reg);
>                 break;
>         }
> +
> +       return reg_bounds_sanity_check(env, ret_reg, "retval");
>  }
>
>  static int
> @@ -10612,7 +10665,9 @@ static int check_helper_call(struct bpf_verifier_=
env *env, struct bpf_insn *insn
>                 regs[BPF_REG_0].ref_obj_id =3D id;
>         }
>
> -       do_refine_retval_range(regs, fn->ret_type, func_id, &meta);
> +       err =3D do_refine_retval_range(env, regs, fn->ret_type, func_id, =
&meta);
> +       if (err)
> +               return err;
>
>         err =3D check_map_func_compatibility(env, meta.map_ptr, func_id);
>         if (err)
> @@ -14079,13 +14134,12 @@ static int check_alu_op(struct bpf_verifier_env=
 *env, struct bpf_insn *insn)
>
>                 /* check dest operand */
>                 err =3D check_reg_arg(env, insn->dst_reg, DST_OP_NO_MARK)=
;
> +               err =3D err ?: adjust_reg_min_max_vals(env, insn);
>                 if (err)
>                         return err;
> -
> -               return adjust_reg_min_max_vals(env, insn);
>         }
>
> -       return 0;
> +       return reg_bounds_sanity_check(env, &regs[insn->dst_reg], "alu");
>  }
>
>  static void find_good_pkt_pointers(struct bpf_verifier_state *vstate,
> @@ -14609,18 +14663,21 @@ static void regs_refine_cond_op(struct bpf_reg_=
state *reg1, struct bpf_reg_state
>   * Technically we can do similar adjustments for pointers to the same ob=
ject,
>   * but we don't support that right now.
>   */
> -static void reg_set_min_max(struct bpf_reg_state *true_reg1,
> -                           struct bpf_reg_state *true_reg2,
> -                           struct bpf_reg_state *false_reg1,
> -                           struct bpf_reg_state *false_reg2,
> -                           u8 opcode, bool is_jmp32)
> +static int reg_set_min_max(struct bpf_verifier_env *env,
> +                          struct bpf_reg_state *true_reg1,
> +                          struct bpf_reg_state *true_reg2,
> +                          struct bpf_reg_state *false_reg1,
> +                          struct bpf_reg_state *false_reg2,
> +                          u8 opcode, bool is_jmp32)
>  {
> +       int err;
> +
>         /* If either register is a pointer, we can't learn anything about=
 its
>          * variable offset from the compare (unless they were a pointer i=
nto
>          * the same object, but we don't bother with that).
>          */
>         if (false_reg1->type !=3D SCALAR_VALUE || false_reg2->type !=3D S=
CALAR_VALUE)
> -               return;
> +               return 0;
>
>         /* fallthrough (FALSE) branch */
>         regs_refine_cond_op(false_reg1, false_reg2, rev_opcode(opcode), i=
s_jmp32);
> @@ -14631,6 +14688,12 @@ static void reg_set_min_max(struct bpf_reg_state=
 *true_reg1,
>         regs_refine_cond_op(true_reg1, true_reg2, opcode, is_jmp32);
>         reg_bounds_sync(true_reg1);
>         reg_bounds_sync(true_reg2);
> +
> +       err =3D reg_bounds_sanity_check(env, true_reg1, "true_reg1");
> +       err =3D err ?: reg_bounds_sanity_check(env, true_reg2, "true_reg2=
");
> +       err =3D err ?: reg_bounds_sanity_check(env, false_reg1, "false_re=
g1");
> +       err =3D err ?: reg_bounds_sanity_check(env, false_reg2, "false_re=
g2");
> +       return err;
>  }
>
>  static void mark_ptr_or_null_reg(struct bpf_func_state *state,
> @@ -14924,15 +14987,20 @@ static int check_cond_jmp_op(struct bpf_verifie=
r_env *env,
>         other_branch_regs =3D other_branch->frame[other_branch->curframe]=
->regs;
>
>         if (BPF_SRC(insn->code) =3D=3D BPF_X) {
> -               reg_set_min_max(&other_branch_regs[insn->dst_reg],
> -                               &other_branch_regs[insn->src_reg],
> -                               dst_reg, src_reg, opcode, is_jmp32);
> +               err =3D reg_set_min_max(env,
> +                                     &other_branch_regs[insn->dst_reg],
> +                                     &other_branch_regs[insn->src_reg],
> +                                     dst_reg, src_reg, opcode, is_jmp32)=
;
>         } else /* BPF_SRC(insn->code) =3D=3D BPF_K */ {
> -               reg_set_min_max(&other_branch_regs[insn->dst_reg],
> -                               src_reg /* fake one */,
> -                               dst_reg, src_reg /* same fake one */,
> -                               opcode, is_jmp32);
> +               err =3D reg_set_min_max(env,
> +                                     &other_branch_regs[insn->dst_reg],
> +                                     src_reg /* fake one */,
> +                                     dst_reg, src_reg /* same fake one *=
/,
> +                                     opcode, is_jmp32);
>         }
> +       if (err)
> +               return err;
> +
>         if (BPF_SRC(insn->code) =3D=3D BPF_X &&
>             src_reg->type =3D=3D SCALAR_VALUE && src_reg->id &&
>             !WARN_ON_ONCE(src_reg->id !=3D other_branch_regs[insn->src_re=
g].id)) {
> @@ -17435,10 +17503,8 @@ static int do_check(struct bpf_verifier_env *env=
)
>                                                insn->off, BPF_SIZE(insn->=
code),
>                                                BPF_READ, insn->dst_reg, f=
alse,
>                                                BPF_MODE(insn->code) =3D=
=3D BPF_MEMSX);
> -                       if (err)
> -                               return err;
> -
> -                       err =3D save_aux_ptr_type(env, src_reg_type, true=
);
> +                       err =3D err ?: save_aux_ptr_type(env, src_reg_typ=
e, true);
> +                       err =3D err ?: reg_bounds_sanity_check(env, &regs=
[insn->dst_reg], "ldx");
>                         if (err)
>                                 return err;
>                 } else if (class =3D=3D BPF_STX) {
> @@ -20725,6 +20791,7 @@ int bpf_check(struct bpf_prog **prog, union bpf_a=
ttr *attr, bpfptr_t uattr, __u3
>
>         if (is_priv)
>                 env->test_state_freq =3D attr->prog_flags & BPF_F_TEST_ST=
ATE_FREQ;
> +       env->test_sanity_strict =3D attr->prog_flags & BPF_F_TEST_SANITY_=
STRICT;
>
>         env->explored_states =3D kvcalloc(state_htab_size(env),
>                                        sizeof(struct bpf_verifier_state_l=
ist *),
> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bp=
f.h
> index 0f6cdf52b1da..b99c1e0e2730 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -1200,6 +1200,9 @@ enum bpf_perf_event_type {
>   */
>  #define BPF_F_XDP_DEV_BOUND_ONLY       (1U << 6)
>
> +/* The verifier internal test flag. Behavior is undefined */
> +#define BPF_F_TEST_SANITY_STRICT       (1U << 7)
> +
>  /* link_create.kprobe_multi.flags used in LINK_CREATE command for
>   * BPF_TRACE_KPROBE_MULTI attach type to create return probe.
>   */
> --
> 2.34.1
>

