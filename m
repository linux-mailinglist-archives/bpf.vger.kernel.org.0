Return-Path: <bpf+bounces-14588-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CBDED7E6D35
	for <lists+bpf@lfdr.de>; Thu,  9 Nov 2023 16:20:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33DEFB20D91
	for <lists+bpf@lfdr.de>; Thu,  9 Nov 2023 15:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3301200C4;
	Thu,  9 Nov 2023 15:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TOf4ghrr"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E212413AEA
	for <bpf@vger.kernel.org>; Thu,  9 Nov 2023 15:20:23 +0000 (UTC)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F13130EB
	for <bpf@vger.kernel.org>; Thu,  9 Nov 2023 07:20:23 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-9c603e2354fso205874866b.1
        for <bpf@vger.kernel.org>; Thu, 09 Nov 2023 07:20:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699543221; x=1700148021; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nkVLygTBSFxVN6zfy+Jfot6EHLLla0KGU/ZP6obzME4=;
        b=TOf4ghrrSydt6JVaAIIUmz80WqmUfnWeltoVQE2zyRIiU3XBK+dCNa3xOZjhRgzOBU
         65QEU2ZnAVnAZO2xJqFT5f6sltSV1PFnC8+bej+9XG5AcT1DJkMoEIlhjZLJLANi/UoZ
         C4/bZla0jV2IH6SPgssXIn15WcNd2p8QuS++BBaKcLx6H8r5ZtOL+bV0Sn5D1CX2zufn
         732iiwGNhLyVwJecSNiy1HxV2fc3TjSF70YoDb/QMkw0t5yJrEeOnJM7hnJilFUp2JSC
         q1AsELx0T+HHZNJPPf3HhCtmSVszGkqLAiqQ3BIC2Cv+UldXoO39oWFbCPdYR0POk6qY
         ZHtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699543221; x=1700148021;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nkVLygTBSFxVN6zfy+Jfot6EHLLla0KGU/ZP6obzME4=;
        b=qG+mM8/5qqsfkKWfG9Tos3F4XH1dMCgCoNmiMlwble8FzGZ/Vh/GA/8+LsD7D9TiZY
         R+k+CiUSL4D/iKBVIhllnawcwlwtIXTXDv24wFp/XMi9njQxwzUOKaoiKeoyXkxb3pAU
         2ABOp7FkY26lncqx3+BcngQLfvF952K5nnjTbvvulE+etXg+tD/UhiYIH3GDoEy2UJqK
         dapayEqX5m/C2CGgebqsmzJ4wsMxh0tmBEVUAZ5cBZ7jYS3Ghq5zwCzratkzm/TQa/8n
         Hkg0q2e+AvXRKxqJxmHIJYlFLWtl/bIenLPbcUjUYy4RAZWZWMksMkrLqXOG5+0mbCys
         t9Kw==
X-Gm-Message-State: AOJu0Yw+a9hIII1RkI7qa4246MJaI8yXFWYYGrjr3wUbUjWxQgXh2jbd
	bNNBVJ/DLh3N6L789SDux/BuqyhDnos=
X-Google-Smtp-Source: AGHT+IFzCORy2ciGDtBbBqqnfltpR5gsXsZiFTdFQtP9BmGKGop75riiyu65YEGFfGg1Fce8MqAsgA==
X-Received: by 2002:a17:907:1b0f:b0:9ba:8ed:ea58 with SMTP id mp15-20020a1709071b0f00b009ba08edea58mr5294037ejc.30.1699543221223;
        Thu, 09 Nov 2023 07:20:21 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id jt6-20020a170906dfc600b009dd7097ca22sm2676354ejc.194.2023.11.09.07.20.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 07:20:20 -0800 (PST)
Message-ID: <3a40d06c4194c5ece81b2e9301a85d70862eaf1e.camel@gmail.com>
Subject: Re: [PATCH bpf-next 2/7] bpf: support non-r10 register spill/fill
 to/from stack in precision tracking
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
 ast@kernel.org,  daniel@iogearbox.net, martin.lau@kernel.org
Cc: kernel-team@meta.com, Tao Lyu <tao.lyu@epfl.ch>
Date: Thu, 09 Nov 2023 17:20:19 +0200
In-Reply-To: <20231031050324.1107444-3-andrii@kernel.org>
References: <20231031050324.1107444-1-andrii@kernel.org>
	 <20231031050324.1107444-3-andrii@kernel.org>
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

On Mon, 2023-10-30 at 22:03 -0700, Andrii Nakryiko wrote:

All makes sense, a few nitpicks below.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

> +/* instruction history flags, used in bpf_insn_hist_entry.flags field */
> +enum {
> +	/* instruction references stack slot through PTR_TO_STACK register;
> +	 * we also store stack's frame number in lower 3 bits (MAX_CALL_FRAMES =
is 8)
> +	 * and accessed stack slot's index in next 6 bits (MAX_BPF_STACK is 512=
,
> +	 * 8 bytes per slot, so slot index (spi) is [0, 63])
> +	 */
> +	INSN_F_FRAMENO_MASK =3D 0x7, /* 3 bits */
> +
> +	INSN_F_SPI_MASK =3D 0x3f, /* 6 bits */
> +	INSN_F_SPI_SHIFT =3D 3, /* shifted 3 bits to the left */
> +
> +	INSN_F_STACK_ACCESS =3D BIT(9), /* we need 10 bits total */
> +};
> +
> +static_assert(INSN_F_FRAMENO_MASK + 1 >=3D MAX_CALL_FRAMES);
> +static_assert(INSN_F_SPI_MASK + 1 >=3D MAX_BPF_STACK / 8);
> +
>  struct bpf_insn_hist_entry {
> -	u32 prev_idx;
>  	u32 idx;
> +	/* insn idx can't be bigger than 1 million */
> +	u32 prev_idx : 22;
> +	/* special flags, e.g., whether insn is doing register stack spill/load=
 */
> +	u32 flags : 10;
>  };

Nitpick: maybe use separate bit-fields for frameno and spi instead of
         flags? Or add dedicated accessor functions?

> =20
> -#define MAX_CALL_FRAMES 8
>  /* Maximum number of register states that can exist at once */
>  #define BPF_ID_MAP_SIZE ((MAX_BPF_REG + MAX_BPF_STACK / BPF_REG_SIZE) * =
MAX_CALL_FRAMES)
>  struct bpf_verifier_state {
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 2905ce2e8b34..fbb779583d52 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -3479,14 +3479,20 @@ static bool is_jmp_point(struct bpf_verifier_env =
*env, int insn_idx)
>  }
> =20
>  /* for any branch, call, exit record the history of jmps in the given st=
ate */
> -static int push_jmp_history(struct bpf_verifier_env *env,
> -			    struct bpf_verifier_state *cur)
> +static int push_insn_history(struct bpf_verifier_env *env, struct bpf_ve=
rifier_state *cur,
> +			     int insn_flags)
>  {
>  	struct bpf_insn_hist_entry *p;
>  	size_t alloc_size;
> =20
> -	if (!is_jmp_point(env, env->insn_idx))
> +	/* combine instruction flags if we already recorded this instruction */
> +	if (cur->insn_hist_end > cur->insn_hist_start &&
> +	    (p =3D &env->insn_hist[cur->insn_hist_end - 1]) &&
> +	    p->idx =3D=3D env->insn_idx &&
> +	    p->prev_idx =3D=3D env->prev_insn_idx) {
> +		p->flags |=3D insn_flags;

Nitpick: maybe add an assert to check that frameno/spi are not or'ed?

[...]

> +static struct bpf_insn_hist_entry *get_hist_insn_entry(struct bpf_verifi=
er_env *env,
> +						       u32 hist_start, u32 hist_end, int insn_idx)

Nitpick: maybe rename 'hist_insn' to 'insn_hist', i.e. 'get_insn_hist_entry=
'?

[...]

> @@ -4713,9 +4711,12 @@ static int check_stack_write_fixed_off(struct bpf_=
verifier_env *env,
> =20
>  		/* Mark slots affected by this stack write. */
>  		for (i =3D 0; i < size; i++)
> -			state->stack[spi].slot_type[(slot - i) % BPF_REG_SIZE] =3D
> -				type;
> +			state->stack[spi].slot_type[(slot - i) % BPF_REG_SIZE] =3D type;
> +		insn_flags =3D 0; /* not a register spill */
>  	}
> +
> +	if (insn_flags)
> +		return push_insn_history(env, env->cur_state, insn_flags);

Maybe add a check that insn is BPF_ST or BPF_STX here?
Only these cases are supported by backtrack_insn() while
check_mem_access() is called from multiple places.

>  	return 0;
>  }
> =20
> @@ -4908,6 +4909,7 @@ static int check_stack_read_fixed_off(struct bpf_ve=
rifier_env *env,
>  	int i, slot =3D -off - 1, spi =3D slot / BPF_REG_SIZE;
>  	struct bpf_reg_state *reg;
>  	u8 *stype, type;
> +	int insn_flags =3D INSN_F_STACK_ACCESS | (spi << INSN_F_SPI_SHIFT) | re=
g_state->frameno;
> =20
>  	stype =3D reg_state->stack[spi].slot_type;
>  	reg =3D &reg_state->stack[spi].spilled_ptr;
> @@ -4953,12 +4955,10 @@ static int check_stack_read_fixed_off(struct bpf_=
verifier_env *env,
>  					return -EACCES;
>  				}
>  				mark_reg_unknown(env, state->regs, dst_regno);
> +				insn_flags =3D 0; /* not restoring original register state */
>  			}
>  			state->regs[dst_regno].live |=3D REG_LIVE_WRITTEN;
> -			return 0;
> -		}
> -
> -		if (dst_regno >=3D 0) {
> +		} else if (dst_regno >=3D 0) {
>  			/* restore register state from stack */
>  			copy_register_state(&state->regs[dst_regno], reg);
>  			/* mark reg as written since spilled pointer state likely
> @@ -4994,7 +4994,10 @@ static int check_stack_read_fixed_off(struct bpf_v=
erifier_env *env,
>  		mark_reg_read(env, reg, reg->parent, REG_LIVE_READ64);
>  		if (dst_regno >=3D 0)
>  			mark_reg_stack_read(env, reg_state, off, off + size, dst_regno);
> +		insn_flags =3D 0; /* we are not restoring spilled register */
>  	}
> +	if (insn_flags)
> +		return push_insn_history(env, env->cur_state, insn_flags);
>  	return 0;
>  }
> =20
> @@ -7125,7 +7128,6 @@ static int check_atomic(struct bpf_verifier_env *en=
v, int insn_idx, struct bpf_i
>  			       BPF_SIZE(insn->code), BPF_WRITE, -1, true, false);
>  	if (err)
>  		return err;
> -
>  	return 0;
>  }
> =20
> @@ -17001,7 +17003,8 @@ static int is_state_visited(struct bpf_verifier_e=
nv *env, int insn_idx)
>  			 * the precision needs to be propagated back in
>  			 * the current state.
>  			 */
> -			err =3D err ? : push_jmp_history(env, cur);
> +			if (is_jmp_point(env, env->insn_idx))
> +				err =3D err ? : push_insn_history(env, cur, 0);
>  			err =3D err ? : propagate_precision(env, &sl->state);
>  			if (err)
>  				return err;
> @@ -17265,7 +17268,7 @@ static int do_check(struct bpf_verifier_env *env)
>  		}
> =20
>  		if (is_jmp_point(env, env->insn_idx)) {
> -			err =3D push_jmp_history(env, state);
> +			err =3D push_insn_history(env, state, 0);
>  			if (err)
>  				return err;
>  		}
> diff --git a/tools/testing/selftests/bpf/progs/verifier_subprog_precision=
.c b/tools/testing/selftests/bpf/progs/verifier_subprog_precision.c
> index db6b3143338b..88c4207c6b4c 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_subprog_precision.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_subprog_precision.c
> @@ -487,7 +487,24 @@ __success __log_level(2)
>   * so we won't be able to mark stack slot fp-8 as precise, and so will
>   * fallback to forcing all as precise
>   */
> -__msg("mark_precise: frame0: falling back to forcing all scalars precise=
")
> +__msg("10: (0f) r1 +=3D r7")
> +__msg("mark_precise: frame0: last_idx 10 first_idx 7 subseq_idx -1")
> +__msg("mark_precise: frame0: regs=3Dr7 stack=3D before 9: (bf) r1 =3D r8=
")
> +__msg("mark_precise: frame0: regs=3Dr7 stack=3D before 8: (27) r7 *=3D 4=
")
> +__msg("mark_precise: frame0: regs=3Dr7 stack=3D before 7: (79) r7 =3D *(=
u64 *)(r10 -8)")
> +__msg("mark_precise: frame0: parent state regs=3D stack=3D-8:  R0_w=3D2 =
R6_w=3D1 R8_rw=3Dmap_value(off=3D0,ks=3D4,vs=3D16,imm=3D0) R10=3Dfp0 fp-8_r=
w=3DP1")
> +__msg("mark_precise: frame0: last_idx 18 first_idx 0 subseq_idx 7")
> +__msg("mark_precise: frame0: regs=3D stack=3D-8 before 18: (95) exit")
> +__msg("mark_precise: frame1: regs=3D stack=3D before 17: (0f) r0 +=3D r2=
")
> +__msg("mark_precise: frame1: regs=3D stack=3D before 16: (79) r2 =3D *(u=
64 *)(r1 +0)")
> +__msg("mark_precise: frame1: regs=3D stack=3D before 15: (79) r0 =3D *(u=
64 *)(r10 -16)")
> +__msg("mark_precise: frame1: regs=3D stack=3D before 14: (7b) *(u64 *)(r=
10 -16) =3D r2")
> +__msg("mark_precise: frame1: regs=3D stack=3D before 13: (7b) *(u64 *)(r=
1 +0) =3D r2")
> +__msg("mark_precise: frame1: regs=3Dr2 stack=3D before 6: (85) call pc+6=
")
> +__msg("mark_precise: frame0: regs=3Dr2 stack=3D before 5: (bf) r2 =3D r6=
")
> +__msg("mark_precise: frame0: regs=3Dr6 stack=3D before 4: (07) r1 +=3D -=
8")
> +__msg("mark_precise: frame0: regs=3Dr6 stack=3D before 3: (bf) r1 =3D r1=
0")
> +__msg("mark_precise: frame0: regs=3Dr6 stack=3D before 2: (b7) r6 =3D 1"=
)
>  __naked int subprog_spill_into_parent_stack_slot_precise(void)
>  {
>  	asm volatile (
> @@ -522,14 +539,68 @@ __naked int subprog_spill_into_parent_stack_slot_pr=
ecise(void)
>  	);
>  }
> =20
> -__naked __noinline __used
> -static __u64 subprog_with_checkpoint(void)
> +SEC("?raw_tp")
> +__success __log_level(2)
> +__msg("17: (0f) r1 +=3D r0")
> +__msg("mark_precise: frame0: last_idx 17 first_idx 0 subseq_idx -1")
> +__msg("mark_precise: frame0: regs=3Dr0 stack=3D before 16: (bf) r1 =3D r=
7")
> +__msg("mark_precise: frame0: regs=3Dr0 stack=3D before 15: (27) r0 *=3D =
4")
> +__msg("mark_precise: frame0: regs=3Dr0 stack=3D before 14: (79) r0 =3D *=
(u64 *)(r10 -16)")
> +__msg("mark_precise: frame0: regs=3D stack=3D-16 before 13: (7b) *(u64 *=
)(r7 -8) =3D r0")
> +__msg("mark_precise: frame0: regs=3Dr0 stack=3D before 12: (79) r0 =3D *=
(u64 *)(r8 +16)")
> +__msg("mark_precise: frame0: regs=3D stack=3D-16 before 11: (7b) *(u64 *=
)(r8 +16) =3D r0")
> +__msg("mark_precise: frame0: regs=3Dr0 stack=3D before 10: (79) r0 =3D *=
(u64 *)(r7 -8)")
> +__msg("mark_precise: frame0: regs=3D stack=3D-16 before 9: (7b) *(u64 *)=
(r10 -16) =3D r0")
> +__msg("mark_precise: frame0: regs=3Dr0 stack=3D before 8: (07) r8 +=3D -=
32")
> +__msg("mark_precise: frame0: regs=3Dr0 stack=3D before 7: (bf) r8 =3D r1=
0")
> +__msg("mark_precise: frame0: regs=3Dr0 stack=3D before 6: (07) r7 +=3D -=
8")
> +__msg("mark_precise: frame0: regs=3Dr0 stack=3D before 5: (bf) r7 =3D r1=
0")
> +__msg("mark_precise: frame0: regs=3Dr0 stack=3D before 21: (95) exit")
> +__msg("mark_precise: frame1: regs=3Dr0 stack=3D before 20: (bf) r0 =3D r=
1")
> +__msg("mark_precise: frame1: regs=3Dr1 stack=3D before 4: (85) call pc+1=
5")
> +__msg("mark_precise: frame0: regs=3Dr1 stack=3D before 3: (bf) r1 =3D r6=
")
> +__msg("mark_precise: frame0: regs=3Dr6 stack=3D before 2: (b7) r6 =3D 1"=
)
> +__naked int stack_slot_aliases_precision(void)
>  {
>  	asm volatile (
> -		"r0 =3D 0;"
> -		/* guaranteed checkpoint if BPF_F_TEST_STATE_FREQ is used */
> -		"goto +0;"
> +		"r6 =3D 1;"
> +		/* pass r6 through r1 into subprog to get it back as r0;
> +		 * this whole chain will have to be marked as precise later
> +		 */
> +		"r1 =3D r6;"
> +		"call identity_subprog;"
> +		/* let's setup two registers that are aliased to r10 */
> +		"r7 =3D r10;"
> +		"r7 +=3D -8;"			/* r7 =3D r10 - 8 */
> +		"r8 =3D r10;"
> +		"r8 +=3D -32;"			/* r8 =3D r10 - 32 */
> +		/* now spill subprog's return value (a r6 -> r1 -> r0 chain)
> +		 * a few times through different stack pointer regs, making
> +		 * sure to use r10, r7, and r8 both in LDX and STX insns, and
> +		 * *importantly* also using a combination of const var_off and
> +		 * insn->off to validate that we record final stack slot
> +		 * correctly, instead of relying on just insn->off derivation,
> +		 * which is only valid for r10-based stack offset
> +		 */
> +		"*(u64 *)(r10 - 16) =3D r0;"
> +		"r0 =3D *(u64 *)(r7 - 8);"	/* r7 - 8 =3D=3D r10 - 16 */
> +		"*(u64 *)(r8 + 16) =3D r0;"	/* r8 + 16 =3D r10 - 16 */
> +		"r0 =3D *(u64 *)(r8 + 16);"
> +		"*(u64 *)(r7 - 8) =3D r0;"
> +		"r0 =3D *(u64 *)(r10 - 16);"
> +		/* get ready to use r0 as an index into array to force precision */
> +		"r0 *=3D 4;"
> +		"r1 =3D %[vals];"
> +		/* here r0->r1->r6 chain is forced to be precise and has to be
> +		 * propagated back to the beginning, including through the
> +		 * subprog call and all the stack spills and loads
> +		 */
> +		"r1 +=3D r0;"
> +		"r0 =3D *(u32 *)(r1 + 0);"
>  		"exit;"
> +		:
> +		: __imm_ptr(vals)
> +		: __clobber_common, "r6"
>  	);
>  }
> =20
> diff --git a/tools/testing/selftests/bpf/verifier/precise.c b/tools/testi=
ng/selftests/bpf/verifier/precise.c
> index 0d84dd1f38b6..8a2ff81d8350 100644
> --- a/tools/testing/selftests/bpf/verifier/precise.c
> +++ b/tools/testing/selftests/bpf/verifier/precise.c
> @@ -140,10 +140,11 @@
>  	.result =3D REJECT,
>  },
>  {
> -	"precise: ST insn causing spi > allocated_stack",
> +	"precise: ST zero to stack insn is supported",
>  	.insns =3D {
>  	BPF_MOV64_REG(BPF_REG_3, BPF_REG_10),
>  	BPF_JMP_IMM(BPF_JNE, BPF_REG_3, 123, 0),
> +	/* not a register spill, so we stop precision propagation for R4 here *=
/
>  	BPF_ST_MEM(BPF_DW, BPF_REG_3, -8, 0),
>  	BPF_LDX_MEM(BPF_DW, BPF_REG_4, BPF_REG_10, -8),
>  	BPF_MOV64_IMM(BPF_REG_0, -1),
> @@ -157,11 +158,11 @@
>  	mark_precise: frame0: last_idx 4 first_idx 2\
>  	mark_precise: frame0: regs=3Dr4 stack=3D before 4\
>  	mark_precise: frame0: regs=3Dr4 stack=3D before 3\
> -	mark_precise: frame0: regs=3D stack=3D-8 before 2\
> -	mark_precise: frame0: falling back to forcing all scalars precise\
> -	force_precise: frame0: forcing r0 to be precise\
>  	mark_precise: frame0: last_idx 5 first_idx 5\
> -	mark_precise: frame0: parent state regs=3D stack=3D:",
> +	mark_precise: frame0: parent state regs=3Dr0 stack=3D:\
> +	mark_precise: frame0: last_idx 4 first_idx 2\
> +	mark_precise: frame0: regs=3Dr0 stack=3D before 4\
> +	5: R0=3D-1 R4=3D0",
>  	.result =3D VERBOSE_ACCEPT,
>  	.retval =3D -1,
>  },
> @@ -169,6 +170,8 @@
>  	"precise: STX insn causing spi > allocated_stack",
>  	.insns =3D {
>  	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_prandom_u32),
> +	/* make later reg spill more interesting by having somewhat known scala=
r */
> +	BPF_ALU64_IMM(BPF_AND, BPF_REG_0, 0xff),
>  	BPF_MOV64_REG(BPF_REG_3, BPF_REG_10),
>  	BPF_JMP_IMM(BPF_JNE, BPF_REG_3, 123, 0),
>  	BPF_STX_MEM(BPF_DW, BPF_REG_3, BPF_REG_0, -8),
> @@ -179,18 +182,21 @@
>  	},
>  	.prog_type =3D BPF_PROG_TYPE_XDP,
>  	.flags =3D BPF_F_TEST_STATE_FREQ,
> -	.errstr =3D "mark_precise: frame0: last_idx 6 first_idx 6\
> +	.errstr =3D "mark_precise: frame0: last_idx 7 first_idx 7\
>  	mark_precise: frame0: parent state regs=3Dr4 stack=3D:\
> -	mark_precise: frame0: last_idx 5 first_idx 3\
> -	mark_precise: frame0: regs=3Dr4 stack=3D before 5\
> -	mark_precise: frame0: regs=3Dr4 stack=3D before 4\
> -	mark_precise: frame0: regs=3D stack=3D-8 before 3\
> -	mark_precise: frame0: falling back to forcing all scalars precise\
> -	force_precise: frame0: forcing r0 to be precise\
> -	force_precise: frame0: forcing r0 to be precise\
> -	force_precise: frame0: forcing r0 to be precise\
> -	force_precise: frame0: forcing r0 to be precise\
> -	mark_precise: frame0: last_idx 6 first_idx 6\
> +	mark_precise: frame0: last_idx 6 first_idx 4\
> +	mark_precise: frame0: regs=3Dr4 stack=3D before 6: (b7) r0 =3D -1\
> +	mark_precise: frame0: regs=3Dr4 stack=3D before 5: (79) r4 =3D *(u64 *)=
(r10 -8)\
> +	mark_precise: frame0: regs=3D stack=3D-8 before 4: (7b) *(u64 *)(r3 -8)=
 =3D r0\
> +	mark_precise: frame0: parent state regs=3Dr0 stack=3D:\
> +	mark_precise: frame0: last_idx 3 first_idx 3\
> +	mark_precise: frame0: regs=3Dr0 stack=3D before 3: (55) if r3 !=3D 0x7b=
 goto pc+0\
> +	mark_precise: frame0: regs=3Dr0 stack=3D before 2: (bf) r3 =3D r10\
> +	mark_precise: frame0: regs=3Dr0 stack=3D before 1: (57) r0 &=3D 255\
> +	mark_precise: frame0: parent state regs=3Dr0 stack=3D:\
> +	mark_precise: frame0: last_idx 0 first_idx 0\
> +	mark_precise: frame0: regs=3Dr0 stack=3D before 0: (85) call bpf_get_pr=
andom_u32#7\
> +	mark_precise: frame0: last_idx 7 first_idx 7\
>  	mark_precise: frame0: parent state regs=3D stack=3D:",
>  	.result =3D VERBOSE_ACCEPT,
>  	.retval =3D -1,




