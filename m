Return-Path: <bpf+bounces-20674-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CF71841A82
	for <lists+bpf@lfdr.de>; Tue, 30 Jan 2024 04:26:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 032D2282F04
	for <lists+bpf@lfdr.de>; Tue, 30 Jan 2024 03:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D584374DD;
	Tue, 30 Jan 2024 03:26:29 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75900374C2;
	Tue, 30 Jan 2024 03:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706585189; cv=none; b=cnbhO7YXMlAWT6LEC8ObBpW/lTeIIbe5Lj8tDxVrQGxM2j/maqP+f3t2NdnEAdYUxSXQPXOz9n9lLUzlnfMd27cXAvhKzliaVF06glmiYI6VobdoSu3eoFc2N/JftLf/aJs7SdwhDhPslI9lj15Cfnqs0DRBdxxZ+Vcx0vMWIPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706585189; c=relaxed/simple;
	bh=fjg7dMv78aEIl0/oMueaxNbD8gxrI9ElBiY3/UWMVgA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=axPIudd9Ulkhu9EmzMteOHCjrfELbdKQIexx8sqAIN7Gq3eN0MUn8zx51V8C6+M9/V1a2ZLW4Kzddxd3NFJ1OpX30z0LBJzcCQdGNZI+fnrquKBRb83yfioxxBw5x1def30+qXBeu2uVgEf5qNSm3XB/FWg106UnLEHzZtXAUnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4TP9Wx3JSYzvVZs;
	Tue, 30 Jan 2024 11:24:45 +0800 (CST)
Received: from kwepemd100009.china.huawei.com (unknown [7.221.188.135])
	by mail.maildlp.com (Postfix) with ESMTPS id C535C1400FF;
	Tue, 30 Jan 2024 11:26:23 +0800 (CST)
Received: from [10.67.109.184] (10.67.109.184) by
 kwepemd100009.china.huawei.com (7.221.188.135) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1258.28; Tue, 30 Jan 2024 11:26:22 +0800
Message-ID: <c063db6e-e947-4c8a-8f4a-afcdb318feb5@huawei.com>
Date: Tue, 30 Jan 2024 11:26:22 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 4/4] riscv, bpf: Mixing bpf2bpf and tailcalls
Content-Language: en-US
To: Pu Lehui <pulehui@huaweicloud.com>, <bpf@vger.kernel.org>,
	<linux-riscv@lists.infradead.org>, <netdev@vger.kernel.org>
CC: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, Alexei Starovoitov
	<ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
	<andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu
	<song@kernel.org>, Yonghong Song <yhs@fb.com>, John Fastabend
	<john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav Fomichev
	<sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>, Conor Dooley <conor@kernel.org>, Luke
 Nelson <luke.r.nels@gmail.com>
References: <20230919035711.3297256-1-pulehui@huaweicloud.com>
 <20230919035711.3297256-5-pulehui@huaweicloud.com>
From: Pu Lehui <pulehui@huawei.com>
In-Reply-To: <20230919035711.3297256-5-pulehui@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemd100009.china.huawei.com (7.221.188.135)



On 2023/9/19 11:57, Pu Lehui wrote:
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
> 
> Signed-off-by: Pu Lehui <pulehui@huawei.com>
> ---
>   arch/riscv/net/bpf_jit.h        |  1 +
>   arch/riscv/net/bpf_jit_comp64.c | 91 ++++++++++++++-------------------
>   2 files changed, 39 insertions(+), 53 deletions(-)
> 
> diff --git a/arch/riscv/net/bpf_jit.h b/arch/riscv/net/bpf_jit.h
> index d21c6c92a..ca518846c 100644
> --- a/arch/riscv/net/bpf_jit.h
> +++ b/arch/riscv/net/bpf_jit.h
> @@ -75,6 +75,7 @@ struct rv_jit_context {
>   	int nexentries;
>   	unsigned long flags;
>   	int stack_size;
> +	int tcc_offset;
>   };
>   
>   /* Convert from ninsns to bytes. */
> diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
> index f2ded1151..f37be4911 100644
> --- a/arch/riscv/net/bpf_jit_comp64.c
> +++ b/arch/riscv/net/bpf_jit_comp64.c
> @@ -13,13 +13,11 @@
>   #include <asm/patch.h>
>   #include "bpf_jit.h"
>   
> +#define RV_REG_TCC		RV_REG_A6
>   #define RV_FENTRY_NINSNS	2
>   /* fentry and TCC init insns will be skipped on tailcall */
>   #define RV_TAILCALL_OFFSET	((RV_FENTRY_NINSNS + 1) * 4)
>   
> -#define RV_REG_TCC RV_REG_A6
> -#define RV_REG_TCC_SAVED RV_REG_S6 /* Store A6 in S6 if program do calls */
> -
>   static const int regmap[] = {
>   	[BPF_REG_0] =	RV_REG_A5,
>   	[BPF_REG_1] =	RV_REG_A0,
> @@ -51,14 +49,12 @@ static const int pt_regmap[] = {
>   };
>   
>   enum {
> -	RV_CTX_F_SEEN_TAIL_CALL =	0,
>   	RV_CTX_F_SEEN_CALL =		RV_REG_RA,
>   	RV_CTX_F_SEEN_S1 =		RV_REG_S1,
>   	RV_CTX_F_SEEN_S2 =		RV_REG_S2,
>   	RV_CTX_F_SEEN_S3 =		RV_REG_S3,
>   	RV_CTX_F_SEEN_S4 =		RV_REG_S4,
>   	RV_CTX_F_SEEN_S5 =		RV_REG_S5,
> -	RV_CTX_F_SEEN_S6 =		RV_REG_S6,
>   };
>   
>   static u8 bpf_to_rv_reg(int bpf_reg, struct rv_jit_context *ctx)
> @@ -71,7 +67,6 @@ static u8 bpf_to_rv_reg(int bpf_reg, struct rv_jit_context *ctx)
>   	case RV_CTX_F_SEEN_S3:
>   	case RV_CTX_F_SEEN_S4:
>   	case RV_CTX_F_SEEN_S5:
> -	case RV_CTX_F_SEEN_S6:
>   		__set_bit(reg, &ctx->flags);
>   	}
>   	return reg;
> @@ -86,7 +81,6 @@ static bool seen_reg(int reg, struct rv_jit_context *ctx)
>   	case RV_CTX_F_SEEN_S3:
>   	case RV_CTX_F_SEEN_S4:
>   	case RV_CTX_F_SEEN_S5:
> -	case RV_CTX_F_SEEN_S6:
>   		return test_bit(reg, &ctx->flags);
>   	}
>   	return false;
> @@ -102,32 +96,6 @@ static void mark_call(struct rv_jit_context *ctx)
>   	__set_bit(RV_CTX_F_SEEN_CALL, &ctx->flags);
>   }
>   
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
>   static bool is_32b_int(s64 val)
>   {
>   	return -(1L << 31) <= val && val < (1L << 31);
> @@ -235,10 +203,7 @@ static void __build_epilogue(bool is_tail_call, struct rv_jit_context *ctx)
>   		emit_ld(RV_REG_S5, store_offset, RV_REG_SP, ctx);
>   		store_offset -= 8;
>   	}
> -	if (seen_reg(RV_REG_S6, ctx)) {
> -		emit_ld(RV_REG_S6, store_offset, RV_REG_SP, ctx);
> -		store_offset -= 8;
> -	}
> +	emit_ld(RV_REG_TCC, store_offset, RV_REG_SP, ctx);
>   
>   	emit_addi(RV_REG_SP, RV_REG_SP, stack_adjust, ctx);
>   	/* Set return value. */
> @@ -332,7 +297,6 @@ static void emit_zext_32(u8 reg, struct rv_jit_context *ctx)
>   static int emit_bpf_tail_call(int insn, struct rv_jit_context *ctx)
>   {
>   	int tc_ninsn, off, start_insn = ctx->ninsns;
> -	u8 tcc = rv_tail_call_reg(ctx);
>   
>   	/* a0: &ctx
>   	 * a1: &array
> @@ -355,9 +319,11 @@ static int emit_bpf_tail_call(int insn, struct rv_jit_context *ctx)
>   	/* if (--TCC < 0)
>   	 *     goto out;
>   	 */
> -	emit_addi(RV_REG_TCC, tcc, -1, ctx);
> +	emit_ld(RV_REG_TCC, ctx->tcc_offset, RV_REG_SP, ctx);
> +	emit_addi(RV_REG_TCC, RV_REG_TCC, -1, ctx);
>   	off = ninsns_rvoff(tc_ninsn - (ctx->ninsns - start_insn));
>   	emit_branch(BPF_JSLT, RV_REG_TCC, RV_REG_ZERO, off, ctx);
> +	emit_sd(RV_REG_SP, ctx->tcc_offset, RV_REG_TCC, ctx);
>   
>   	/* prog = array->ptrs[index];
>   	 * if (!prog)
> @@ -763,7 +729,7 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
>   	int i, ret, offset;
>   	int *branches_off = NULL;
>   	int stack_size = 0, nregs = m->nr_args;
> -	int retval_off, args_off, nregs_off, ip_off, run_ctx_off, sreg_off;
> +	int retval_off, args_off, nregs_off, ip_off, run_ctx_off, sreg_off, tcc_off;
>   	struct bpf_tramp_links *fentry = &tlinks[BPF_TRAMP_FENTRY];
>   	struct bpf_tramp_links *fexit = &tlinks[BPF_TRAMP_FEXIT];
>   	struct bpf_tramp_links *fmod_ret = &tlinks[BPF_TRAMP_MODIFY_RETURN];
> @@ -807,6 +773,8 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
>   	 *
>   	 * FP - sreg_off    [ callee saved reg	]
>   	 *
> +	 * FP - tcc_off     [ tail call count	] BPF_TRAMP_F_TAIL_CALL_CTX
> +	 *
>   	 *		    [ pads              ] pads for 16 bytes alignment
>   	 */
>   
> @@ -848,6 +816,11 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
>   	stack_size += 8;
>   	sreg_off = stack_size;
>   
> +	if (flags & BPF_TRAMP_F_TAIL_CALL_CTX) {
> +		stack_size += 8;
> +		tcc_off = stack_size;
> +	}
> +
>   	stack_size = round_up(stack_size, 16);
>   
>   	if (func_addr) {
> @@ -874,6 +847,10 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
>   		emit_addi(RV_REG_FP, RV_REG_SP, stack_size, ctx);
>   	}
>   
> +	/* store tail call count */
> +	if (flags & BPF_TRAMP_F_TAIL_CALL_CTX)
> +		emit_sd(RV_REG_FP, -tcc_off, RV_REG_TCC, ctx);
> +
>   	/* callee saved register S1 to pass start time */
>   	emit_sd(RV_REG_FP, -sreg_off, RV_REG_S1, ctx);
>   
> @@ -927,6 +904,9 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
>   
>   	if (flags & BPF_TRAMP_F_CALL_ORIG) {
>   		restore_args(nregs, args_off, ctx);
> +		/* restore TCC to RV_REG_TCC before calling the original function */
> +		if (flags & BPF_TRAMP_F_TAIL_CALL_CTX)
> +			emit_ld(RV_REG_TCC, -tcc_off, RV_REG_FP, ctx);
>   		ret = emit_call((const u64)orig_call, true, ctx);
>   		if (ret)
>   			goto out;
> @@ -967,6 +947,10 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
>   
>   	emit_ld(RV_REG_S1, -sreg_off, RV_REG_FP, ctx);
>   
> +	/* restore TCC to RV_REG_TCC before calling the original function */
> +	if (flags & BPF_TRAMP_F_TAIL_CALL_CTX)
> +		emit_ld(RV_REG_TCC, -tcc_off, RV_REG_FP, ctx);

Sorry guys. This will emit double times when `flags & 
BPF_TRAMP_F_CALL_ORIG`. Will fix it in next version.

> +
>   	if (func_addr) {
>   		/* trampoline called from function entry */
>   		emit_ld(RV_REG_T0, stack_size - 8, RV_REG_SP, ctx);
> @@ -1476,6 +1460,9 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
>   		if (ret < 0)
>   			return ret;
>   
> +		/* restore TCC from stack to RV_REG_TCC */
> +		emit_ld(RV_REG_TCC, ctx->tcc_offset, RV_REG_SP, ctx);
> +
>   		ret = emit_call(addr, fixed_addr, ctx);
>   		if (ret)
>   			return ret;
> @@ -1735,6 +1722,7 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
>   void bpf_jit_build_prologue(struct rv_jit_context *ctx)
>   {
>   	int i, stack_adjust = 0, store_offset, bpf_stack_adjust;
> +	bool is_main = ctx->prog->aux->func_idx == 0;
>   
>   	bpf_stack_adjust = round_up(ctx->prog->aux->stack_depth, 16);
>   	if (bpf_stack_adjust)
> @@ -1753,8 +1741,7 @@ void bpf_jit_build_prologue(struct rv_jit_context *ctx)
>   		stack_adjust += 8;
>   	if (seen_reg(RV_REG_S5, ctx))
>   		stack_adjust += 8;
> -	if (seen_reg(RV_REG_S6, ctx))
> -		stack_adjust += 8;
> +	stack_adjust += 8; /* RV_REG_TCC */
>   
>   	stack_adjust = round_up(stack_adjust, 16);
>   	stack_adjust += bpf_stack_adjust;
> @@ -1769,7 +1756,8 @@ void bpf_jit_build_prologue(struct rv_jit_context *ctx)
>   	 * (TCC) register. This instruction is skipped for tail calls.
>   	 * Force using a 4-byte (non-compressed) instruction.
>   	 */
> -	emit(rv_addi(RV_REG_TCC, RV_REG_ZERO, MAX_TAIL_CALL_CNT), ctx);
> +	if (is_main)
> +		emit(rv_addi(RV_REG_TCC, RV_REG_ZERO, MAX_TAIL_CALL_CNT), ctx);
>   
>   	emit_addi(RV_REG_SP, RV_REG_SP, -stack_adjust, ctx);
>   
> @@ -1799,22 +1787,14 @@ void bpf_jit_build_prologue(struct rv_jit_context *ctx)
>   		emit_sd(RV_REG_SP, store_offset, RV_REG_S5, ctx);
>   		store_offset -= 8;
>   	}
> -	if (seen_reg(RV_REG_S6, ctx)) {
> -		emit_sd(RV_REG_SP, store_offset, RV_REG_S6, ctx);
> -		store_offset -= 8;
> -	}
> +	emit_sd(RV_REG_SP, store_offset, RV_REG_TCC, ctx);
> +	ctx->tcc_offset = store_offset;
>   
>   	emit_addi(RV_REG_FP, RV_REG_SP, stack_adjust, ctx);
>   
>   	if (bpf_stack_adjust)
>   		emit_addi(RV_REG_S5, RV_REG_SP, bpf_stack_adjust, ctx);
>   
> -	/* Program contains calls and tail calls, so RV_REG_TCC need
> -	 * to be saved across calls.
> -	 */
> -	if (seen_tail_call(ctx) && seen_call(ctx))
> -		emit_mv(RV_REG_TCC_SAVED, RV_REG_TCC, ctx);
> -
>   	ctx->stack_size = stack_adjust;
>   }
>   
> @@ -1827,3 +1807,8 @@ bool bpf_jit_supports_kfunc_call(void)
>   {
>   	return true;
>   }
> +
> +bool bpf_jit_supports_subprog_tailcalls(void)
> +{
> +	return true;
> +}

