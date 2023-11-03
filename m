Return-Path: <bpf+bounces-14084-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0EF37E07DA
	for <lists+bpf@lfdr.de>; Fri,  3 Nov 2023 18:56:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72157281F43
	for <lists+bpf@lfdr.de>; Fri,  3 Nov 2023 17:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 768752134C;
	Fri,  3 Nov 2023 17:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZRaOEtBM"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA52221341
	for <bpf@vger.kernel.org>; Fri,  3 Nov 2023 17:56:15 +0000 (UTC)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED5CBD78
	for <bpf@vger.kernel.org>; Fri,  3 Nov 2023 10:56:09 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-9d242846194so353530866b.1
        for <bpf@vger.kernel.org>; Fri, 03 Nov 2023 10:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699034168; x=1699638968; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UN+gjvdcm/SdnNacn/gjnCPuGuDR2euApKwJF3xDErs=;
        b=ZRaOEtBMQS+QEN0VyuVvUQJySbC5mk8jvMEvokSCrK5QX38UYJ6QBgI+nUhzs8HcnH
         RCWUsOL+aJHY5evveF7oigfZa5BwiSPpCge0WRYvqda3cBXDnTtK/ZiAFq9/GYH1evrR
         WQZMoc/lgGyq47r5AX2IxFmvFc9b3OqCLpsyGyWaSJotAI+CKDCr/KuOY6SDyZ+pcnlW
         nwoKsdEDTjoxKD/b0L7vtlzNl4KPweIbEZXlr8Tg0lJat3vKoIvZuFTMWR/zva127DIX
         WXtVbv5g5t0L7JMigNbm/TDvUnSmJz4mQLdGaFHIToe4VO/s6TujMDQ6tij0NIfFFcIU
         MSYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699034168; x=1699638968;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UN+gjvdcm/SdnNacn/gjnCPuGuDR2euApKwJF3xDErs=;
        b=MqEARAfmDMA9nixx2yazsmhzzRcFjmXncOv3mhmNe2uxnsx0F7z07arumDjNakCzjJ
         H57VRoc3zkJ8cDsJaijUT8jADO8GgsS+dAxDw4AK/c5jokWMNQ0bd7lj2fhtBvhe7Ljp
         Yqu/nmzPdl2Vk1DGy03fwW+B+1PzvUsHSucBjVET+aQnvODmudkNliuzC4tUhntxzjes
         gSZAqzyYSCwPzVummipJCHqRyQBB7wZmOrj99PTYXNe502a1luF+Hj7Vr0N7WDi8MzKV
         JavI1+/L91Hln3Nb0HUNKa264tnhTyaqqo4xMAszQe+lo1jKnAm7BA+BOSdNyUjw/tvY
         ZpwQ==
X-Gm-Message-State: AOJu0YxhqTPUGgueAaPRKoMyn7V0X6aOn3RBaseMcz+Tz09xVwY0sR9c
	5DaHASD5/V6gFISDsSIoP5a5sNGDN04=
X-Google-Smtp-Source: AGHT+IH5GgUfbvrInGpLpabZgheR4FP59ZJrU2BJOxJQoGZHkd1j4jcOQP/XeiSV1l4BBjomUgOUzg==
X-Received: by 2002:a17:907:a0e:b0:9bf:b129:5984 with SMTP id bb14-20020a1709070a0e00b009bfb1295984mr6643714ejc.77.1699034167998;
        Fri, 03 Nov 2023 10:56:07 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id s16-20020a170906355000b009a193a5acffsm1130841eja.121.2023.11.03.10.56.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Nov 2023 10:56:07 -0700 (PDT)
Message-ID: <f0344812c7d5cf1384b0fb7a04100d940fdbcaf1.camel@gmail.com>
Subject: Re: [PATCH bpf-next 04/13] bpf: add register bounds sanity checks
 and sanitization
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
 ast@kernel.org,  daniel@iogearbox.net, martin.lau@kernel.org
Cc: kernel-team@meta.com
Date: Fri, 03 Nov 2023 19:56:06 +0200
In-Reply-To: <20231103000822.2509815-5-andrii@kernel.org>
References: <20231103000822.2509815-1-andrii@kernel.org>
	 <20231103000822.2509815-5-andrii@kernel.org>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.0 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2023-11-02 at 17:08 -0700, Andrii Nakryiko wrote:
> Add simple sanity checks that validate well-formed ranges (min <=3D max)
> across u64, s64, u32, and s32 ranges. Also for cases when the value is
> constant (either 64-bit or 32-bit), we validate that ranges and tnums
> are in agreement.
>=20
> These bounds checks are performed at the end of BPF_ALU/BPF_ALU64
> operations, on conditional jumps, and for LDX instructions (where subreg
> zero/sign extension is probably the most important to check). This
> covers most of the interesting cases.
>=20
> Also, we validate the sanity of the return register when manually
> adjusting it for some special helpers.
>=20
> By default, sanity violation will trigger a warning in verifier log and
> resetting register bounds to "unbounded" ones. But to aid development
> and debugging, BPF_F_TEST_SANITY_STRICT flag is added, which will
> trigger hard failure of verification with -EFAULT on register bounds
> violations. This allows selftests to catch such issues. veristat will
> also gain a CLI option to enable this behavior.

This is a useful check but I'm not sure about placement.
It might be useful to guard calls to coerce_subreg_to_size_sx() as well.
Maybe insert it as a part of the main do_check() loop but filter
by instruction class (and also force on stack_pop)?

>=20
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  include/linux/bpf_verifier.h   |   1 +
>  include/uapi/linux/bpf.h       |   3 +
>  kernel/bpf/syscall.c           |   3 +-
>  kernel/bpf/verifier.c          | 117 ++++++++++++++++++++++++++-------
>  tools/include/uapi/linux/bpf.h |   3 +
>  5 files changed, 101 insertions(+), 26 deletions(-)
>=20
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 24213a99cc79..402b6bc44a1b 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -602,6 +602,7 @@ struct bpf_verifier_env {
>  	int stack_size;			/* number of states to be processed */
>  	bool strict_alignment;		/* perform strict pointer alignment checks */
>  	bool test_state_freq;		/* test verifier with different pruning frequenc=
y */
> +	bool test_sanity_strict;	/* fail verification on sanity violations */
>  	struct bpf_verifier_state *cur_state; /* current verifier state */
>  	struct bpf_verifier_state_list **explored_states; /* search pruning opt=
imization */
>  	struct bpf_verifier_state_list *free_list;
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 0f6cdf52b1da..b99c1e0e2730 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -1200,6 +1200,9 @@ enum bpf_perf_event_type {
>   */
>  #define BPF_F_XDP_DEV_BOUND_ONLY	(1U << 6)
> =20
> +/* The verifier internal test flag. Behavior is undefined */
> +#define BPF_F_TEST_SANITY_STRICT	(1U << 7)
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
>  				 BPF_F_SLEEPABLE |
>  				 BPF_F_TEST_RND_HI32 |
>  				 BPF_F_XDP_HAS_FRAGS |
> -				 BPF_F_XDP_DEV_BOUND_ONLY))
> +				 BPF_F_XDP_DEV_BOUND_ONLY |
> +				 BPF_F_TEST_SANITY_STRICT))
>  		return -EINVAL;
> =20
>  	if (!IS_ENABLED(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS) &&
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 8691cacd3ad3..af4e2fecbef2 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -2615,6 +2615,56 @@ static void reg_bounds_sync(struct bpf_reg_state *=
reg)
>  	__update_reg_bounds(reg);
>  }
> =20
> +static int reg_bounds_sanity_check(struct bpf_verifier_env *env,
> +				   struct bpf_reg_state *reg, const char *ctx)
> +{
> +	const char *msg;
> +
> +	if (reg->umin_value > reg->umax_value ||
> +	    reg->smin_value > reg->smax_value ||
> +	    reg->u32_min_value > reg->u32_max_value ||
> +	    reg->s32_min_value > reg->s32_max_value) {
> +		    msg =3D "range bounds violation";
> +		    goto out;
> +	}
> +
> +	if (tnum_is_const(reg->var_off)) {
> +		u64 uval =3D reg->var_off.value;
> +		s64 sval =3D (s64)uval;
> +
> +		if (reg->umin_value !=3D uval || reg->umax_value !=3D uval ||
> +		    reg->smin_value !=3D sval || reg->smax_value !=3D sval) {
> +			msg =3D "const tnum out of sync with range bounds";
> +			goto out;
> +		}
> +	}
> +
> +	if (tnum_subreg_is_const(reg->var_off)) {
> +		u32 uval32 =3D tnum_subreg(reg->var_off).value;
> +		s32 sval32 =3D (s32)uval32;
> +
> +		if (reg->u32_min_value !=3D uval32 || reg->u32_max_value !=3D uval32 |=
|
> +		    reg->s32_min_value !=3D sval32 || reg->s32_max_value !=3D sval32) =
{
> +			msg =3D "const subreg tnum out of sync with range bounds";
> +			goto out;
> +		}
> +	}
> +
> +	return 0;
> +out:
> +	verbose(env, "REG SANITY VIOLATION (%s): %s u64=3D[%#llx, %#llx] "
> +		"s64=3D[%#llx, %#llx] u32=3D[%#x, %#x] s32=3D[%#x, %#x] var_off=3D(%#l=
lx, %#llx)\n",
> +		ctx, msg, reg->umin_value, reg->umax_value,
> +		reg->smin_value, reg->smax_value,
> +		reg->u32_min_value, reg->u32_max_value,
> +		reg->s32_min_value, reg->s32_max_value,
> +		reg->var_off.value, reg->var_off.mask);
> +	if (env->test_sanity_strict)
> +		return -EFAULT;
> +	__mark_reg_unbounded(reg);
> +	return 0;
> +}
> +
>  static bool __reg32_bound_s64(s32 a)
>  {
>  	return a >=3D 0 && a <=3D S32_MAX;
> @@ -9928,14 +9978,15 @@ static int prepare_func_exit(struct bpf_verifier_=
env *env, int *insn_idx)
>  	return 0;
>  }
> =20
> -static void do_refine_retval_range(struct bpf_reg_state *regs, int ret_t=
ype,
> -				   int func_id,
> -				   struct bpf_call_arg_meta *meta)
> +static int do_refine_retval_range(struct bpf_verifier_env *env,
> +				  struct bpf_reg_state *regs, int ret_type,
> +				  int func_id,
> +				  struct bpf_call_arg_meta *meta)
>  {
>  	struct bpf_reg_state *ret_reg =3D &regs[BPF_REG_0];
> =20
>  	if (ret_type !=3D RET_INTEGER)
> -		return;
> +		return 0;
> =20
>  	switch (func_id) {
>  	case BPF_FUNC_get_stack:
> @@ -9961,6 +10012,8 @@ static void do_refine_retval_range(struct bpf_reg_=
state *regs, int ret_type,
>  		reg_bounds_sync(ret_reg);
>  		break;
>  	}
> +
> +	return reg_bounds_sanity_check(env, ret_reg, "retval");
>  }
> =20
>  static int
> @@ -10612,7 +10665,9 @@ static int check_helper_call(struct bpf_verifier_=
env *env, struct bpf_insn *insn
>  		regs[BPF_REG_0].ref_obj_id =3D id;
>  	}
> =20
> -	do_refine_retval_range(regs, fn->ret_type, func_id, &meta);
> +	err =3D do_refine_retval_range(env, regs, fn->ret_type, func_id, &meta)=
;
> +	if (err)
> +		return err;
> =20
>  	err =3D check_map_func_compatibility(env, meta.map_ptr, func_id);
>  	if (err)
> @@ -14079,13 +14134,12 @@ static int check_alu_op(struct bpf_verifier_env=
 *env, struct bpf_insn *insn)
> =20
>  		/* check dest operand */
>  		err =3D check_reg_arg(env, insn->dst_reg, DST_OP_NO_MARK);
> +		err =3D err ?: adjust_reg_min_max_vals(env, insn);
>  		if (err)
>  			return err;
> -
> -		return adjust_reg_min_max_vals(env, insn);
>  	}
> =20
> -	return 0;
> +	return reg_bounds_sanity_check(env, &regs[insn->dst_reg], "alu");
>  }
> =20
>  static void find_good_pkt_pointers(struct bpf_verifier_state *vstate,
> @@ -14609,18 +14663,21 @@ static void regs_refine_cond_op(struct bpf_reg_=
state *reg1, struct bpf_reg_state
>   * Technically we can do similar adjustments for pointers to the same ob=
ject,
>   * but we don't support that right now.
>   */
> -static void reg_set_min_max(struct bpf_reg_state *true_reg1,
> -			    struct bpf_reg_state *true_reg2,
> -			    struct bpf_reg_state *false_reg1,
> -			    struct bpf_reg_state *false_reg2,
> -			    u8 opcode, bool is_jmp32)
> +static int reg_set_min_max(struct bpf_verifier_env *env,
> +			   struct bpf_reg_state *true_reg1,
> +			   struct bpf_reg_state *true_reg2,
> +			   struct bpf_reg_state *false_reg1,
> +			   struct bpf_reg_state *false_reg2,
> +			   u8 opcode, bool is_jmp32)
>  {
> +	int err;
> +
>  	/* If either register is a pointer, we can't learn anything about its
>  	 * variable offset from the compare (unless they were a pointer into
>  	 * the same object, but we don't bother with that).
>  	 */
>  	if (false_reg1->type !=3D SCALAR_VALUE || false_reg2->type !=3D SCALAR_=
VALUE)
> -		return;
> +		return 0;
> =20
>  	/* fallthrough (FALSE) branch */
>  	regs_refine_cond_op(false_reg1, false_reg2, rev_opcode(opcode), is_jmp3=
2);
> @@ -14631,6 +14688,12 @@ static void reg_set_min_max(struct bpf_reg_state=
 *true_reg1,
>  	regs_refine_cond_op(true_reg1, true_reg2, opcode, is_jmp32);
>  	reg_bounds_sync(true_reg1);
>  	reg_bounds_sync(true_reg2);
> +
> +	err =3D reg_bounds_sanity_check(env, true_reg1, "true_reg1");
> +	err =3D err ?: reg_bounds_sanity_check(env, true_reg2, "true_reg2");
> +	err =3D err ?: reg_bounds_sanity_check(env, false_reg1, "false_reg1");
> +	err =3D err ?: reg_bounds_sanity_check(env, false_reg2, "false_reg2");
> +	return err;
>  }
> =20
>  static void mark_ptr_or_null_reg(struct bpf_func_state *state,
> @@ -14924,15 +14987,20 @@ static int check_cond_jmp_op(struct bpf_verifie=
r_env *env,
>  	other_branch_regs =3D other_branch->frame[other_branch->curframe]->regs=
;
> =20
>  	if (BPF_SRC(insn->code) =3D=3D BPF_X) {
> -		reg_set_min_max(&other_branch_regs[insn->dst_reg],
> -				&other_branch_regs[insn->src_reg],
> -				dst_reg, src_reg, opcode, is_jmp32);
> +		err =3D reg_set_min_max(env,
> +				      &other_branch_regs[insn->dst_reg],
> +				      &other_branch_regs[insn->src_reg],
> +				      dst_reg, src_reg, opcode, is_jmp32);
>  	} else /* BPF_SRC(insn->code) =3D=3D BPF_K */ {
> -		reg_set_min_max(&other_branch_regs[insn->dst_reg],
> -				src_reg /* fake one */,
> -				dst_reg, src_reg /* same fake one */,
> -				opcode, is_jmp32);
> +		err =3D reg_set_min_max(env,
> +				      &other_branch_regs[insn->dst_reg],
> +				      src_reg /* fake one */,
> +				      dst_reg, src_reg /* same fake one */,
> +				      opcode, is_jmp32);
>  	}
> +	if (err)
> +		return err;
> +
>  	if (BPF_SRC(insn->code) =3D=3D BPF_X &&
>  	    src_reg->type =3D=3D SCALAR_VALUE && src_reg->id &&
>  	    !WARN_ON_ONCE(src_reg->id !=3D other_branch_regs[insn->src_reg].id)=
) {
> @@ -17435,10 +17503,8 @@ static int do_check(struct bpf_verifier_env *env=
)
>  					       insn->off, BPF_SIZE(insn->code),
>  					       BPF_READ, insn->dst_reg, false,
>  					       BPF_MODE(insn->code) =3D=3D BPF_MEMSX);
> -			if (err)
> -				return err;
> -
> -			err =3D save_aux_ptr_type(env, src_reg_type, true);
> +			err =3D err ?: save_aux_ptr_type(env, src_reg_type, true);
> +			err =3D err ?: reg_bounds_sanity_check(env, &regs[insn->dst_reg], "ld=
x");
>  			if (err)
>  				return err;
>  		} else if (class =3D=3D BPF_STX) {
> @@ -20725,6 +20791,7 @@ int bpf_check(struct bpf_prog **prog, union bpf_a=
ttr *attr, bpfptr_t uattr, __u3
> =20
>  	if (is_priv)
>  		env->test_state_freq =3D attr->prog_flags & BPF_F_TEST_STATE_FREQ;
> +	env->test_sanity_strict =3D attr->prog_flags & BPF_F_TEST_SANITY_STRICT=
;
> =20
>  	env->explored_states =3D kvcalloc(state_htab_size(env),
>  				       sizeof(struct bpf_verifier_state_list *),
> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bp=
f.h
> index 0f6cdf52b1da..b99c1e0e2730 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -1200,6 +1200,9 @@ enum bpf_perf_event_type {
>   */
>  #define BPF_F_XDP_DEV_BOUND_ONLY	(1U << 6)
> =20
> +/* The verifier internal test flag. Behavior is undefined */
> +#define BPF_F_TEST_SANITY_STRICT	(1U << 7)
> +
>  /* link_create.kprobe_multi.flags used in LINK_CREATE command for
>   * BPF_TRACE_KPROBE_MULTI attach type to create return probe.
>   */


