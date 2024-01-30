Return-Path: <bpf+bounces-20755-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 73917842AFE
	for <lists+bpf@lfdr.de>; Tue, 30 Jan 2024 18:31:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF83EB27CCB
	for <lists+bpf@lfdr.de>; Tue, 30 Jan 2024 17:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2E2412BF21;
	Tue, 30 Jan 2024 17:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sa4nBNSZ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282FA12BF1C;
	Tue, 30 Jan 2024 17:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706635845; cv=none; b=fGaekwPdfZygY1g/JB9dOBXTqFspYXkUsD8tlLBSVyfX1GwScfeNEajbjG1qFc2zv0i1rrHuFXlYbFip2iMqpXshTAO1O+kw2JpWoszqJmDEVJ66dJYujDfHFSxJRh7nSJ2jaet6QzbcwuXtNuYUaRBkWr4rBooEfTaNNCcXorI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706635845; c=relaxed/simple;
	bh=j/MRAZd4rO27lR/Js7eHNUbRnA5tSc70U658SLN+caw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=A8CCwcM2k3Bb8+SYp1DzdRqwk0vGu9wy7XxfIIvX0WooeflaRzCm2NOpbseEJ5AVc8MB3buTMlQ4UbfRKCnRGQX/x1Yl8T6ZOL9c7gbnYPi9WaCCdCZLaDeDZ1jjXXnHvO/YU36Iz2sXAAavBqzJagOpyRaIIdXu/cxPta3iVHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sa4nBNSZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1D00C433F1;
	Tue, 30 Jan 2024 17:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706635844;
	bh=j/MRAZd4rO27lR/Js7eHNUbRnA5tSc70U658SLN+caw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Sa4nBNSZDYxsCNog9y0VHk9V6m4A/iGbJauhtcegzBj/5RlpEShpWtGgMlDVSt764
	 COxlhQB0hEz4wNOCt9bV0NtrYRPONWJh+RonU3Svupit0xZrTesSTeJmYEak8RZjNL
	 QLpCkTVWW1TRVB+njwvV6qZTmE7UJ4Pe4eLR7eOJSNf1E1hZ4Y+lS1afEVH6BGn4Gh
	 gKOTPSQJ0Hq5p6SpaxUtEWeq4l/LfTriG3bYaTVQtyv9nd+d4n7tm7EEQ5snEk3wAy
	 9il95kRmvn//UgqgTlFZ/sK/SzU2Jx95lt/Jx1WIJG91hdCDw0GklkUNZA+XjrlF2C
	 WXUzJCL0yC8Ww==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Pu Lehui <pulehui@huaweicloud.com>, bpf@vger.kernel.org,
 linux-riscv@lists.infradead.org, netdev@vger.kernel.org
Cc: Song Liu <song@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Yonghong Song <yhs@fb.com>, John Fastabend
 <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Luke Nelson
 <luke.r.nels@gmail.com>, Pu Lehui <pulehui@huawei.com>, Pu Lehui
 <pulehui@huaweicloud.com>
Subject: Re: [PATCH bpf-next v2 4/4] riscv, bpf: Mixing bpf2bpf and tailcalls
In-Reply-To: <20240130040958.230673-5-pulehui@huaweicloud.com>
References: <20240130040958.230673-1-pulehui@huaweicloud.com>
 <20240130040958.230673-5-pulehui@huaweicloud.com>
Date: Tue, 30 Jan 2024 18:30:41 +0100
Message-ID: <87sf2eohj2.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Pu Lehui <pulehui@huaweicloud.com> writes:

> From: Pu Lehui <pulehui@huawei.com>
>
> In the current RV64 JIT, if we just don't initialize the TCC in subprog,
> the TCC can be propagated from the parent process to the subprocess, but
> the TCC of the parent process cannot be restored when the subprocess
> exits. Since the RV64 TCC is initialized before saving the callee saved
> registers into the stack, we cannot use the callee saved register to
> pass the TCC, otherwise the original value of the callee saved register
> will be destroyed. So we implemented mixing bpf2bpf and tailcalls
> similar to x86_64, i.e. using a non-callee saved register to transfer
> the TCC between functions, and saving that register to the stack to
> protect the TCC value. At the same time, we also consider the scenario
> of mixing trampoline.
>
> Tests test_bpf.ko and test_verifier have passed, as well as the relative
> testcases of test_progs*.

Ok, I'll summarize, so that I know that I get it. ;-)

All BPF progs (except the main), get the current TCC passed in a6. TCC
is stored in each BPF stack frame.

During tail calls, the TCC from the stack is loaded, decremented, and
stored to the stack again.

Mixing bpf2bpf/tailcalls means that each *BPF stackframe* can perform up
to "current TCC to max_tailscalls" number of calls.

main_prog() calls subprog1(). subprog1() can perform max_tailscalls.
subprog1() returns, and main_prog() calls subprog2(). subprog2() can
also perform max_tailscalls.

Correct?

Some comments below as well.

> Signed-off-by: Pu Lehui <pulehui@huawei.com>
> ---
>  arch/riscv/net/bpf_jit.h        |  1 +
>  arch/riscv/net/bpf_jit_comp64.c | 89 +++++++++++++--------------------
>  2 files changed, 37 insertions(+), 53 deletions(-)
>
> diff --git a/arch/riscv/net/bpf_jit.h b/arch/riscv/net/bpf_jit.h
> index 8b35f12a4452..d8be89dadf18 100644
> --- a/arch/riscv/net/bpf_jit.h
> +++ b/arch/riscv/net/bpf_jit.h
> @@ -81,6 +81,7 @@ struct rv_jit_context {
>  	int nexentries;
>  	unsigned long flags;
>  	int stack_size;
> +	int tcc_offset;
>  };
>=20=20
>  /* Convert from ninsns to bytes. */
> diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_com=
p64.c
> index 3516d425c5eb..64e0c86d60c4 100644
> --- a/arch/riscv/net/bpf_jit_comp64.c
> +++ b/arch/riscv/net/bpf_jit_comp64.c
> @@ -13,13 +13,11 @@
>  #include <asm/patch.h>
>  #include "bpf_jit.h"
>=20=20
> +#define RV_REG_TCC		RV_REG_A6
>  #define RV_FENTRY_NINSNS	2
>  /* fentry and TCC init insns will be skipped on tailcall */
>  #define RV_TAILCALL_OFFSET	((RV_FENTRY_NINSNS + 1) * 4)
>=20=20
> -#define RV_REG_TCC RV_REG_A6
> -#define RV_REG_TCC_SAVED RV_REG_S6 /* Store A6 in S6 if program do calls=
 */
> -
>  static const int regmap[] =3D {
>  	[BPF_REG_0] =3D	RV_REG_A5,
>  	[BPF_REG_1] =3D	RV_REG_A0,
> @@ -51,14 +49,12 @@ static const int pt_regmap[] =3D {
>  };
>=20=20
>  enum {
> -	RV_CTX_F_SEEN_TAIL_CALL =3D	0,
>  	RV_CTX_F_SEEN_CALL =3D		RV_REG_RA,
>  	RV_CTX_F_SEEN_S1 =3D		RV_REG_S1,
>  	RV_CTX_F_SEEN_S2 =3D		RV_REG_S2,
>  	RV_CTX_F_SEEN_S3 =3D		RV_REG_S3,
>  	RV_CTX_F_SEEN_S4 =3D		RV_REG_S4,
>  	RV_CTX_F_SEEN_S5 =3D		RV_REG_S5,
> -	RV_CTX_F_SEEN_S6 =3D		RV_REG_S6,
>  };
>=20=20
>  static u8 bpf_to_rv_reg(int bpf_reg, struct rv_jit_context *ctx)
> @@ -71,7 +67,6 @@ static u8 bpf_to_rv_reg(int bpf_reg, struct rv_jit_cont=
ext *ctx)
>  	case RV_CTX_F_SEEN_S3:
>  	case RV_CTX_F_SEEN_S4:
>  	case RV_CTX_F_SEEN_S5:
> -	case RV_CTX_F_SEEN_S6:
>  		__set_bit(reg, &ctx->flags);
>  	}
>  	return reg;
> @@ -86,7 +81,6 @@ static bool seen_reg(int reg, struct rv_jit_context *ct=
x)
>  	case RV_CTX_F_SEEN_S3:
>  	case RV_CTX_F_SEEN_S4:
>  	case RV_CTX_F_SEEN_S5:
> -	case RV_CTX_F_SEEN_S6:
>  		return test_bit(reg, &ctx->flags);
>  	}
>  	return false;
> @@ -102,32 +96,6 @@ static void mark_call(struct rv_jit_context *ctx)
>  	__set_bit(RV_CTX_F_SEEN_CALL, &ctx->flags);
>  }
>=20=20
> -static bool seen_call(struct rv_jit_context *ctx)
> -{
> -	return test_bit(RV_CTX_F_SEEN_CALL, &ctx->flags);
> -}
> -
> -static void mark_tail_call(struct rv_jit_context *ctx)
> -{
> -	__set_bit(RV_CTX_F_SEEN_TAIL_CALL, &ctx->flags);
> -}
> -
> -static bool seen_tail_call(struct rv_jit_context *ctx)
> -{
> -	return test_bit(RV_CTX_F_SEEN_TAIL_CALL, &ctx->flags);
> -}
> -
> -static u8 rv_tail_call_reg(struct rv_jit_context *ctx)
> -{
> -	mark_tail_call(ctx);
> -
> -	if (seen_call(ctx)) {
> -		__set_bit(RV_CTX_F_SEEN_S6, &ctx->flags);
> -		return RV_REG_S6;
> -	}
> -	return RV_REG_A6;
> -}
> -
>  static bool is_32b_int(s64 val)
>  {
>  	return -(1L << 31) <=3D val && val < (1L << 31);
> @@ -252,10 +220,7 @@ static void __build_epilogue(bool is_tail_call, stru=
ct rv_jit_context *ctx)
>  		emit_ld(RV_REG_S5, store_offset, RV_REG_SP, ctx);
>  		store_offset -=3D 8;
>  	}
> -	if (seen_reg(RV_REG_S6, ctx)) {
> -		emit_ld(RV_REG_S6, store_offset, RV_REG_SP, ctx);
> -		store_offset -=3D 8;
> -	}
> +	emit_ld(RV_REG_TCC, store_offset, RV_REG_SP, ctx);

Why do you need to restore RV_REG_TCC? We're passing RV_REG_TCC (a6) as
an argument at all call-sites, and for tailcalls we're loading from the
stack.

Is this to fake the a6 argument for the tail-call? If so, it's better to
move it to emit_bpf_tail_call(), instead of letting all programs pay for
it.

>=20=20
>  	emit_addi(RV_REG_SP, RV_REG_SP, stack_adjust, ctx);
>  	/* Set return value. */
> @@ -343,7 +308,6 @@ static void emit_branch(u8 cond, u8 rd, u8 rs, int rv=
off,
>  static int emit_bpf_tail_call(int insn, struct rv_jit_context *ctx)
>  {
>  	int tc_ninsn, off, start_insn =3D ctx->ninsns;
> -	u8 tcc =3D rv_tail_call_reg(ctx);
>=20=20
>  	/* a0: &ctx
>  	 * a1: &array
> @@ -366,9 +330,11 @@ static int emit_bpf_tail_call(int insn, struct rv_ji=
t_context *ctx)
>  	/* if (--TCC < 0)
>  	 *     goto out;
>  	 */
> -	emit_addi(RV_REG_TCC, tcc, -1, ctx);
> +	emit_ld(RV_REG_TCC, ctx->tcc_offset, RV_REG_SP, ctx);
> +	emit_addi(RV_REG_TCC, RV_REG_TCC, -1, ctx);
>  	off =3D ninsns_rvoff(tc_ninsn - (ctx->ninsns - start_insn));
>  	emit_branch(BPF_JSLT, RV_REG_TCC, RV_REG_ZERO, off, ctx);
> +	emit_sd(RV_REG_SP, ctx->tcc_offset, RV_REG_TCC, ctx);
>=20=20
>  	/* prog =3D array->ptrs[index];
>  	 * if (!prog)
> @@ -767,7 +733,7 @@ static int __arch_prepare_bpf_trampoline(struct bpf_t=
ramp_image *im,
>  	int i, ret, offset;
>  	int *branches_off =3D NULL;
>  	int stack_size =3D 0, nregs =3D m->nr_args;
> -	int retval_off, args_off, nregs_off, ip_off, run_ctx_off, sreg_off;
> +	int retval_off, args_off, nregs_off, ip_off, run_ctx_off, sreg_off, tcc=
_off;
>  	struct bpf_tramp_links *fentry =3D &tlinks[BPF_TRAMP_FENTRY];
>  	struct bpf_tramp_links *fexit =3D &tlinks[BPF_TRAMP_FEXIT];
>  	struct bpf_tramp_links *fmod_ret =3D &tlinks[BPF_TRAMP_MODIFY_RETURN];
> @@ -812,6 +778,8 @@ static int __arch_prepare_bpf_trampoline(struct bpf_t=
ramp_image *im,
>  	 *
>  	 * FP - sreg_off    [ callee saved reg	]
>  	 *
> +	 * FP - tcc_off     [ tail call count	] BPF_TRAMP_F_TAIL_CALL_CTX
> +	 *
>  	 *		    [ pads              ] pads for 16 bytes alignment
>  	 */
>=20=20
> @@ -853,6 +821,11 @@ static int __arch_prepare_bpf_trampoline(struct bpf_=
tramp_image *im,
>  	stack_size +=3D 8;
>  	sreg_off =3D stack_size;
>=20=20
> +	if (flags & BPF_TRAMP_F_TAIL_CALL_CTX) {
> +		stack_size +=3D 8;
> +		tcc_off =3D stack_size;
> +	}
> +
>  	stack_size =3D round_up(stack_size, 16);
>=20=20
>  	if (!is_struct_ops) {
> @@ -879,6 +852,10 @@ static int __arch_prepare_bpf_trampoline(struct bpf_=
tramp_image *im,
>  		emit_addi(RV_REG_FP, RV_REG_SP, stack_size, ctx);
>  	}
>=20=20
> +	/* store tail call count */
> +	if (flags & BPF_TRAMP_F_TAIL_CALL_CTX)
> +		emit_sd(RV_REG_FP, -tcc_off, RV_REG_TCC, ctx);
> +
>  	/* callee saved register S1 to pass start time */
>  	emit_sd(RV_REG_FP, -sreg_off, RV_REG_S1, ctx);
>=20=20
> @@ -932,6 +909,9 @@ static int __arch_prepare_bpf_trampoline(struct bpf_t=
ramp_image *im,
>=20=20
>  	if (flags & BPF_TRAMP_F_CALL_ORIG) {
>  		restore_args(nregs, args_off, ctx);
> +		/* restore TCC to RV_REG_TCC before calling the original function */
> +		if (flags & BPF_TRAMP_F_TAIL_CALL_CTX)
> +			emit_ld(RV_REG_TCC, -tcc_off, RV_REG_FP, ctx);
>  		ret =3D emit_call((const u64)orig_call, true, ctx);
>  		if (ret)
>  			goto out;
> @@ -963,6 +943,9 @@ static int __arch_prepare_bpf_trampoline(struct bpf_t=
ramp_image *im,
>  		ret =3D emit_call((const u64)__bpf_tramp_exit, true, ctx);
>  		if (ret)
>  			goto out;
> +	} else if (flags & BPF_TRAMP_F_TAIL_CALL_CTX) {
> +		/* restore TCC to RV_REG_TCC before calling the original function */
> +		emit_ld(RV_REG_TCC, -tcc_off, RV_REG_FP, ctx);
>  	}
>=20=20
>  	if (flags & BPF_TRAMP_F_RESTORE_REGS)
> @@ -1455,6 +1438,9 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, =
struct rv_jit_context *ctx,
>  		if (ret < 0)
>  			return ret;
>=20=20
> +		/* restore TCC from stack to RV_REG_TCC */
> +		emit_ld(RV_REG_TCC, ctx->tcc_offset, RV_REG_SP, ctx);
> +
>  		ret =3D emit_call(addr, fixed_addr, ctx);
>  		if (ret)
>  			return ret;
> @@ -1733,8 +1719,7 @@ void bpf_jit_build_prologue(struct rv_jit_context *=
ctx)
>  		stack_adjust +=3D 8;
>  	if (seen_reg(RV_REG_S5, ctx))
>  		stack_adjust +=3D 8;
> -	if (seen_reg(RV_REG_S6, ctx))
> -		stack_adjust +=3D 8;
> +	stack_adjust +=3D 8; /* RV_REG_TCC */
>=20=20
>  	stack_adjust =3D round_up(stack_adjust, 16);
>  	stack_adjust +=3D bpf_stack_adjust;
> @@ -1749,7 +1734,8 @@ void bpf_jit_build_prologue(struct rv_jit_context *=
ctx)
>  	 * (TCC) register. This instruction is skipped for tail calls.
>  	 * Force using a 4-byte (non-compressed) instruction.
>  	 */
> -	emit(rv_addi(RV_REG_TCC, RV_REG_ZERO, MAX_TAIL_CALL_CNT), ctx);
> +	if (!bpf_is_subprog(ctx->prog))
> +		emit(rv_addi(RV_REG_TCC, RV_REG_ZERO, MAX_TAIL_CALL_CNT), ctx);

You're conditionally emitting the instruction. Doesn't this break
RV_TAILCALL_OFFSET?


Bj=C3=B6rn

