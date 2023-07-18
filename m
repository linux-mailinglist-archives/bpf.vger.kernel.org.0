Return-Path: <bpf+bounces-5183-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA66D7585EE
	for <lists+bpf@lfdr.de>; Tue, 18 Jul 2023 22:06:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 093431C20E03
	for <lists+bpf@lfdr.de>; Tue, 18 Jul 2023 20:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 863CE174C6;
	Tue, 18 Jul 2023 20:06:42 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E8A910946;
	Tue, 18 Jul 2023 20:06:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABC02C433C8;
	Tue, 18 Jul 2023 20:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689710800;
	bh=qfpmhLMrS6QORXM3Xjd7lWMjzf7nk3c04e5lJQkrGhI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=pn2R1kqWXQrwBfO+NqPq/oSI8rte6bD9B+KHJdk3LYkgd2pCuMZfhIScI5tloPlhi
	 jpai6yXGQn9PEAEamXHdX+BUYyich/cOpnBhzc3uSgapk6V5wk2cAAOsKUSfcbq6nW
	 YuPnEA8+F7qwH6r0yT408RojtEJFHs4iJ4gVJlI63zLJtMjjjKO2aYG7kEYJT5fFxD
	 X+JTgv5pkSEer07J108tSYJJ7rwqbvHpGZCVrB6SwLK9ocv70osLbYxn9uXkfLgcDT
	 E1EOjPOpmWZCoE6WSn0rGvTj1I7NgEGSZ2zF0s+FubxK/qK6WEe8XimCRJPQN6HiSa
	 KDjxRzcKGOYCg==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Pu Lehui <pulehui@huaweicloud.com>, bpf@vger.kernel.org,
 linux-riscv@lists.infradead.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Martin KaFai
 Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song
 <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>, KP Singh
 <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Palmer Dabbelt
 <palmer@dabbelt.com>, Guo Ren <guoren@kernel.org>, Song Shuai
 <suagrfillet@gmail.com>, Pu Lehui <pulehui@huawei.com>, Pu Lehui
 <pulehui@huaweicloud.com>
Subject: Re: [PATCH bpf] riscv, bpf: Adapt bpf trampoline to optimized riscv
 ftrace framework
In-Reply-To: <20230715090137.2141358-1-pulehui@huaweicloud.com>
References: <20230715090137.2141358-1-pulehui@huaweicloud.com>
Date: Tue, 18 Jul 2023 22:06:37 +0200
Message-ID: <87lefdougi.fsf@all.your.base.are.belong.to.us>
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
> Commit 6724a76cff85 ("riscv: ftrace: Reduce the detour code size to
> half") optimizes the detour code size of kernel functions to half with
> T0 register and the upcoming DYNAMIC_FTRACE_WITH_DIRECT_CALLS of riscv
> is based on this optimization, we need to adapt riscv bpf trampoline
> based on this. One thing to do is to reduce detour code size of bpf
> programs, and the second is to deal with the return address after the
> execution of bpf trampoline. Meanwhile, add more comments and rename
> some variables to make more sense. The related tests have passed.
>
> This adaptation needs to be merged before the upcoming
> DYNAMIC_FTRACE_WITH_DIRECT_CALLS of riscv, otherwise it will crash due
> to a mismatch in the return address. So we target this modification to
> bpf tree and add fixes tag for locating.

Thank you for working on this!

> Fixes: 6724a76cff85 ("riscv: ftrace: Reduce the detour code size to half")

This is not a fix. Nothing is broken. Only that this patch much come
before or as part of the ftrace series.

> Signed-off-by: Pu Lehui <pulehui@huawei.com>
> ---
>  arch/riscv/net/bpf_jit_comp64.c | 110 ++++++++++++++------------------
>  1 file changed, 47 insertions(+), 63 deletions(-)
>
> diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_com=
p64.c
> index c648864c8cd1..ffc9aa42f918 100644
> --- a/arch/riscv/net/bpf_jit_comp64.c
> +++ b/arch/riscv/net/bpf_jit_comp64.c
> @@ -241,7 +241,7 @@ static void __build_epilogue(bool is_tail_call, struc=
t rv_jit_context *ctx)
>  	if (!is_tail_call)
>  		emit_mv(RV_REG_A0, RV_REG_A5, ctx);
>  	emit_jalr(RV_REG_ZERO, is_tail_call ? RV_REG_T3 : RV_REG_RA,
> -		  is_tail_call ? 20 : 0, /* skip reserved nops and TCC init */
> +		  is_tail_call ? 12 : 0, /* skip reserved nops and TCC init */

Maybe be explicit, and use the "DETOUR_INSNS" from below (and convert to
bytes)?

>  		  ctx);
>  }
>=20=20
> @@ -618,32 +618,7 @@ static int add_exception_handler(const struct bpf_in=
sn *insn,
>  	return 0;
>  }
>=20=20
> -static int gen_call_or_nops(void *target, void *ip, u32 *insns)
> -{
> -	s64 rvoff;
> -	int i, ret;
> -	struct rv_jit_context ctx;
> -
> -	ctx.ninsns =3D 0;
> -	ctx.insns =3D (u16 *)insns;
> -
> -	if (!target) {
> -		for (i =3D 0; i < 4; i++)
> -			emit(rv_nop(), &ctx);
> -		return 0;
> -	}
> -
> -	rvoff =3D (s64)(target - (ip + 4));
> -	emit(rv_sd(RV_REG_SP, -8, RV_REG_RA), &ctx);
> -	ret =3D emit_jump_and_link(RV_REG_RA, rvoff, false, &ctx);
> -	if (ret)
> -		return ret;
> -	emit(rv_ld(RV_REG_RA, -8, RV_REG_SP), &ctx);
> -
> -	return 0;
> -}
> -
> -static int gen_jump_or_nops(void *target, void *ip, u32 *insns)
> +static int gen_jump_or_nops(void *target, void *ip, u32 *insns, bool is_=
call)
>  {
>  	s64 rvoff;
>  	struct rv_jit_context ctx;
> @@ -658,38 +633,38 @@ static int gen_jump_or_nops(void *target, void *ip,=
 u32 *insns)
>  	}
>=20=20
>  	rvoff =3D (s64)(target - ip);
> -	return emit_jump_and_link(RV_REG_ZERO, rvoff, false, &ctx);
> +	return emit_jump_and_link(is_call ? RV_REG_T0 : RV_REG_ZERO,
> +				  rvoff, false, &ctx);

Nit: Please use the full 100 char width.

>  }
>=20=20
> +#define DETOUR_NINSNS	2

Better name? Maybe call this patchable function entry something? Also,
to catch future breaks like this -- would it make sense to have a
static_assert() combined with something tied to
-fpatchable-function-entry=3D from arch/riscv/Makefile?

> +
>  int bpf_arch_text_poke(void *ip, enum bpf_text_poke_type poke_type,
>  		       void *old_addr, void *new_addr)
>  {
> -	u32 old_insns[4], new_insns[4];
> +	u32 old_insns[DETOUR_NINSNS], new_insns[DETOUR_NINSNS];
>  	bool is_call =3D poke_type =3D=3D BPF_MOD_CALL;
> -	int (*gen_insns)(void *target, void *ip, u32 *insns);
> -	int ninsns =3D is_call ? 4 : 2;
>  	int ret;
>=20=20
> -	if (!is_bpf_text_address((unsigned long)ip))
> +	if (!is_kernel_text((unsigned long)ip) &&
> +	    !is_bpf_text_address((unsigned long)ip))
>  		return -ENOTSUPP;
>=20=20
> -	gen_insns =3D is_call ? gen_call_or_nops : gen_jump_or_nops;
> -
> -	ret =3D gen_insns(old_addr, ip, old_insns);
> +	ret =3D gen_jump_or_nops(old_addr, ip, old_insns, is_call);
>  	if (ret)
>  		return ret;
>=20=20
> -	if (memcmp(ip, old_insns, ninsns * 4))
> +	if (memcmp(ip, old_insns, DETOUR_NINSNS * 4))
>  		return -EFAULT;
>=20=20
> -	ret =3D gen_insns(new_addr, ip, new_insns);
> +	ret =3D gen_jump_or_nops(new_addr, ip, new_insns, is_call);
>  	if (ret)
>  		return ret;
>=20=20
>  	cpus_read_lock();
>  	mutex_lock(&text_mutex);
> -	if (memcmp(ip, new_insns, ninsns * 4))
> -		ret =3D patch_text(ip, new_insns, ninsns);
> +	if (memcmp(ip, new_insns, DETOUR_NINSNS * 4))
> +		ret =3D patch_text(ip, new_insns, DETOUR_NINSNS);
>  	mutex_unlock(&text_mutex);
>  	cpus_read_unlock();
>=20=20
> @@ -717,7 +692,7 @@ static void restore_args(int nregs, int args_off, str=
uct rv_jit_context *ctx)
>  }
>=20=20
>  static int invoke_bpf_prog(struct bpf_tramp_link *l, int args_off, int r=
etval_off,
> -			   int run_ctx_off, bool save_ret, struct rv_jit_context *ctx)
> +			   int run_ctx_off, bool save_retval, struct rv_jit_context *ctx)

Why the save_retval name change? This churn is not needed IMO
(especially since you keep using the _ret name below). Please keep the
old name.

>  {
>  	int ret, branch_off;
>  	struct bpf_prog *p =3D l->link.prog;
> @@ -757,7 +732,7 @@ static int invoke_bpf_prog(struct bpf_tramp_link *l, =
int args_off, int retval_of
>  	if (ret)
>  		return ret;
>=20=20
> -	if (save_ret)
> +	if (save_retval)
>  		emit_sd(RV_REG_FP, -retval_off, regmap[BPF_REG_0], ctx);
>=20=20
>  	/* update branch with beqz */
> @@ -787,20 +762,19 @@ static int __arch_prepare_bpf_trampoline(struct bpf=
_tramp_image *im,
>  	int i, ret, offset;
>  	int *branches_off =3D NULL;
>  	int stack_size =3D 0, nregs =3D m->nr_args;
> -	int retaddr_off, fp_off, retval_off, args_off;
> -	int nregs_off, ip_off, run_ctx_off, sreg_off;
> +	int fp_off, retval_off, args_off, nregs_off, ip_off, run_ctx_off, sreg_=
off;
>  	struct bpf_tramp_links *fentry =3D &tlinks[BPF_TRAMP_FENTRY];
>  	struct bpf_tramp_links *fexit =3D &tlinks[BPF_TRAMP_FEXIT];
>  	struct bpf_tramp_links *fmod_ret =3D &tlinks[BPF_TRAMP_MODIFY_RETURN];
>  	void *orig_call =3D func_addr;
> -	bool save_ret;
> +	bool save_retval, traced_ret;
>  	u32 insn;
>=20=20
>  	/* Generated trampoline stack layout:
>  	 *
>  	 * FP - 8	    [ RA of parent func	] return address of parent
>  	 *					  function
> -	 * FP - retaddr_off [ RA of traced func	] return address of traced
> +	 * FP - 16	    [ RA of traced func	] return address of
>  	traced

BPF code uses frame pointers. Shouldn't the trampoline frame look like a
regular frame [1], i.e. start with return address followed by previous
frame pointer?

>  	 *					  function
>  	 * FP - fp_off	    [ FP of parent func ]
>  	 *
> @@ -833,17 +807,20 @@ static int __arch_prepare_bpf_trampoline(struct bpf=
_tramp_image *im,
>  	if (nregs > 8)
>  		return -ENOTSUPP;
>=20=20
> -	/* room for parent function return address */
> +	/* room for return address of parent function */
>  	stack_size +=3D 8;
>=20=20
> -	stack_size +=3D 8;
> -	retaddr_off =3D stack_size;
> +	/* whether return to return address of traced function after bpf trampo=
line */
> +	traced_ret =3D func_addr && !(flags & BPF_TRAMP_F_SKIP_FRAME);
> +	/* room for return address of traced function */
> +	if (traced_ret)
> +		stack_size +=3D 8;
>=20=20
>  	stack_size +=3D 8;
>  	fp_off =3D stack_size;
>=20=20
> -	save_ret =3D flags & (BPF_TRAMP_F_CALL_ORIG | BPF_TRAMP_F_RET_FENTRY_RE=
T);
> -	if (save_ret) {
> +	save_retval =3D flags & (BPF_TRAMP_F_CALL_ORIG | BPF_TRAMP_F_RET_FENTRY=
_RET);
> +	if (save_retval) {
>  		stack_size +=3D 8;
>  		retval_off =3D stack_size;
>  	}
> @@ -869,7 +846,11 @@ static int __arch_prepare_bpf_trampoline(struct bpf_=
tramp_image *im,
>=20=20
>  	emit_addi(RV_REG_SP, RV_REG_SP, -stack_size, ctx);
>=20=20
> -	emit_sd(RV_REG_SP, stack_size - retaddr_off, RV_REG_RA, ctx);
> +	/* store return address of parent function */
> +	emit_sd(RV_REG_SP, stack_size - 8, RV_REG_RA, ctx);
> +	/* store return address of traced function */
> +	if (traced_ret)
> +		emit_sd(RV_REG_SP, stack_size - 16, RV_REG_T0, ctx);
>  	emit_sd(RV_REG_SP, stack_size - fp_off, RV_REG_FP, ctx);
>=20=20
>  	emit_addi(RV_REG_FP, RV_REG_SP, stack_size, ctx);
> @@ -890,7 +871,7 @@ static int __arch_prepare_bpf_trampoline(struct bpf_t=
ramp_image *im,
>=20=20
>  	/* skip to actual body of traced function */
>  	if (flags & BPF_TRAMP_F_SKIP_FRAME)
> -		orig_call +=3D 16;
> +		orig_call +=3D 8;

Use the define above so it's obvious what you're skipping.

>=20=20
>  	if (flags & BPF_TRAMP_F_CALL_ORIG) {
>  		emit_imm(RV_REG_A0, (const s64)im, ctx);
> @@ -962,22 +943,25 @@ static int __arch_prepare_bpf_trampoline(struct bpf=
_tramp_image *im,
>  	if (flags & BPF_TRAMP_F_RESTORE_REGS)
>  		restore_args(nregs, args_off, ctx);
>=20=20
> -	if (save_ret)
> +	if (save_retval)
>  		emit_ld(RV_REG_A0, -retval_off, RV_REG_FP, ctx);
>=20=20
>  	emit_ld(RV_REG_S1, -sreg_off, RV_REG_FP, ctx);
>=20=20
> -	if (flags & BPF_TRAMP_F_SKIP_FRAME)
> -		/* return address of parent function */
> +	if (traced_ret) {
> +		/* restore return address of parent function */
>  		emit_ld(RV_REG_RA, stack_size - 8, RV_REG_SP, ctx);
> -	else
> -		/* return address of traced function */
> -		emit_ld(RV_REG_RA, stack_size - retaddr_off, RV_REG_SP, ctx);
> +		/* restore return address of traced function */
> +		emit_ld(RV_REG_T0, stack_size - 16, RV_REG_SP, ctx);
> +	} else {
> +		/* restore return address of parent function */
> +		emit_ld(RV_REG_T0, stack_size - 8, RV_REG_SP, ctx);
> +	}
>=20=20
>  	emit_ld(RV_REG_FP, stack_size - fp_off, RV_REG_SP, ctx);
>  	emit_addi(RV_REG_SP, RV_REG_SP, stack_size, ctx);
>=20=20
> -	emit_jalr(RV_REG_ZERO, RV_REG_RA, 0, ctx);
> +	emit_jalr(RV_REG_ZERO, RV_REG_T0, 0, ctx);
>=20=20
>  	ret =3D ctx->ninsns;
>  out:
> @@ -1664,7 +1648,7 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, =
struct rv_jit_context *ctx,
>=20=20
>  void bpf_jit_build_prologue(struct rv_jit_context *ctx)
>  {
> -	int i, stack_adjust =3D 0, store_offset, bpf_stack_adjust;
> +	int stack_adjust =3D 0, store_offset, bpf_stack_adjust;
>=20=20
>  	bpf_stack_adjust =3D round_up(ctx->prog->aux->stack_depth, 16);
>  	if (bpf_stack_adjust)
> @@ -1691,9 +1675,9 @@ void bpf_jit_build_prologue(struct rv_jit_context *=
ctx)
>=20=20
>  	store_offset =3D stack_adjust - 8;
>=20=20
> -	/* reserve 4 nop insns */
> -	for (i =3D 0; i < 4; i++)
> -		emit(rv_nop(), ctx);
> +	/* 2 nops reserved for auipc+jalr pair */
> +	emit(rv_nop(), ctx);
> +	emit(rv_nop(), ctx);

Use the define above, instead of hardcoding two nops.


Thanks,
Bj=C3=B6rn

[1] https://github.com/riscv-non-isa/riscv-elf-psabi-doc/blob/master/riscv-=
cc.adoc#frame-pointer-convention

