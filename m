Return-Path: <bpf+bounces-64582-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A41DB14630
	for <lists+bpf@lfdr.de>; Tue, 29 Jul 2025 04:28:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D85454E0705
	for <lists+bpf@lfdr.de>; Tue, 29 Jul 2025 02:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 153EA20A5D6;
	Tue, 29 Jul 2025 02:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GOXl7bFg"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85397202C5C;
	Tue, 29 Jul 2025 02:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753756091; cv=none; b=iqVn3QGmp4Y2PIq0/g764giu2OTvzdaHgQOjjzAH1bWvlgeHv+Gw4sTA4AsvAwUVwycr+rn00w7NIayOEEA4INWHvZLVss5ovPddzxgSBedRNqkEFpUreD/IVual1S/LToh44ptL0XK93FKWhb8nvWDOHfIdBj89UcMPR8ytvpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753756091; c=relaxed/simple;
	bh=BKORl7Jsp53EPIUkMyhH7TFlZTuG5upnhCWsS5l+tH8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Los5/qO2SNqpHh3tYtvcNU71ybqVpK9waKQKo1tyo4wjM28LcwMn60/0vkUm+hb9JyiEC9etO6sHanHoXfA+WerSk/zWbVEsS2POSw9cLZ6D9T2VQY7AWi8HFwazi1eKW4jo1jid7xal3OFPjYuUeA5Fcxq3mPJpYo5spKCDy5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GOXl7bFg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BF63C4CEE7;
	Tue, 29 Jul 2025 02:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753756091;
	bh=BKORl7Jsp53EPIUkMyhH7TFlZTuG5upnhCWsS5l+tH8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=GOXl7bFgapLgKt7Es8gXLKSXiqXWQdqbU2aIOIlgy9cEDZ4p+rTV1urqghACS3an9
	 /2VS/9Q4wtuR4W7dqifj9qwDrsxB7D7nRZFPQK4EpNDAlywo8d6/FHuCUt6y3y54ax
	 tJFu/yU45B4g4B10CgVi0+8JC7Nv4wiEQRVWk+LgNRgIbN2hvR4HUK/KQN5TK0k2e6
	 Mswtd7ztXQYjwGuMTiEvoZ54aC6CAzC504u6FMhyXEx1Eczk4L6gzkMK2a3wfuyQR1
	 WfJ3gAXEgY1OwAwkVsNjDIFVvkntc1GpaMm61ngSw5OtHr41Kjrz8A/QBuec3AijJ1
	 exRIyuAdq9IDQ==
Message-ID: <28f23b9702e159d788506f80c742c04416a60009.camel@kernel.org>
Subject: Re: [PATCH v4 2/2] LoongArch: BPF: Fix tailcall hierarchy
From: Geliang Tang <geliang@kernel.org>
To: Haoran Jiang <jianghaoran@kylinos.cn>, loongarch@lists.linux.dev
Cc: bpf@vger.kernel.org, kernel@xen0n.name, chenhuacai@kernel.org, 
	hengqi.chen@gmail.com, yangtiezhu@loongson.cn, jolsa@kernel.org,
 haoluo@google.com, 	sdf@fomichev.me, kpsingh@kernel.org,
 john.fastabend@gmail.com, 	yonghong.song@linux.dev, song@kernel.org,
 eddyz87@gmail.com, martin.lau@linux.dev, 	andrii@kernel.org,
 daniel@iogearbox.net, ast@kernel.org
Date: Tue, 29 Jul 2025 10:28:00 +0800
In-Reply-To: <20250725102307.1026434-3-jianghaoran@kylinos.cn>
References: <20250725102307.1026434-1-jianghaoran@kylinos.cn>
	 <20250725102307.1026434-3-jianghaoran@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.0-1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Haoran,

Thanks for this patch, I have some comments below.

On Fri, 2025-07-25 at 18:23 +0800, Haoran Jiang wrote:
> In specific use cases combining tailcalls and BPF-to-BPF calls，
> MAX_TAIL_CALL_CNT won't work because of missing tail_call_cnt
> back-propagation from callee to caller。This patch fixes this
> tailcall issue caused by abusing the tailcall in bpf2bpf feature
> on LoongArch like the way of "bpf, x64: Fix tailcall hierarchy".
> 
> push tail_call_cnt_ptr and tail_call_cnt into the stack,
> tail_call_cnt_ptr is passed between tailcall and bpf2bpf,
> uses tail_call_cnt_ptr to increment tail_call_cnt.
> 
> Fixes: bb035ef0cc91 ("LoongArch: BPF: Support mixing bpf2bpf and
> tailcalls")
> Fixes: 5dc615520c4d ("LoongArch: Add BPF JIT support")
> 
> Reviewed-by: Hengqi Chen <hengqi.chen@gmail.com>
> Signed-off-by: Haoran Jiang <jianghaoran@kylinos.cn>
> ---
>  arch/loongarch/net/bpf_jit.c | 160 +++++++++++++++++++++++++--------
> --
>  1 file changed, 113 insertions(+), 47 deletions(-)
> 
> diff --git a/arch/loongarch/net/bpf_jit.c
> b/arch/loongarch/net/bpf_jit.c
> index 5cd2eb210bc5..ca264014fb95 100644
> --- a/arch/loongarch/net/bpf_jit.c
> +++ b/arch/loongarch/net/bpf_jit.c
> @@ -17,10 +17,7 @@
>  #define LOONGARCH_BPF_FENTRY_NBYTES (LOONGARCH_LONG_JUMP_NINSNS * 4)
>  
>  #define REG_TCC		LOONGARCH_GPR_A6
> -#define TCC_SAVED	LOONGARCH_GPR_S5
> -
> -#define SAVE_RA		BIT(0)
> -#define SAVE_TCC	BIT(1)
> +#define BPF_TAIL_CALL_CNT_PTR_STACK_OFF(stack) (round_up(stack, 16)
> - 80)
>  
>  static const int regmap[] = {
>  	/* return value from in-kernel function, and exit value for
> eBPF program */
> @@ -42,32 +39,59 @@ static const int regmap[] = {
>  	[BPF_REG_AX] = LOONGARCH_GPR_T0,
>  };
>  
> -static void mark_call(struct jit_ctx *ctx)
> +static void prepare_bpf_tail_call_cnt(struct jit_ctx *ctx, int
> *store_offset)
>  {
> -	ctx->flags |= SAVE_RA;
> -}
> +	const struct bpf_prog *prog = ctx->prog;
> +	const bool is_main_prog = !bpf_is_subprog(prog);
>  
> -static void mark_tail_call(struct jit_ctx *ctx)
> -{
> -	ctx->flags |= SAVE_TCC;
> -}
> +	if (is_main_prog) {
> +		/*
> +		 * LOONGARCH_GPR_T3 = MAX_TAIL_CALL_CNT
> +		 * if (REG_TCC > T3 )
> +		 *	std REG_TCC -> LOONGARCH_GPR_SP +
> store_offset
> +		 * else
> +		 *	std REG_TCC -> LOONGARCH_GPR_SP +
> store_offset
> +		 *	REG_TCC = LOONGARCH_GPR_SP + store_offset

The comment doesn't exactly match the code below, which checks if
REG_TCC < MAX_TAIL_CALL_CNT first, then REG_TCC > MAX_TAIL_CALL_CNT. I
think we could update this comment here, WDYT?

> +		 *
> +		 * std REG_TCC -> LOONGARCH_GPR_SP + store_offset
> +		 *
> +		 * The purpose of this code is to first push the TCC
> into stack,
> +		 * and then push the address of TCC into stack.
> +		 * In cases where bpf2bpf and tailcall are used in
> combination，
> +		 * the value in REG_TCC may be a count or an
> address，
> +		 * these two cases need to be judged and handled
> separately。

You mixed Chinese punctuation marks in the above three lines.

> +		 *

No need to add this new line.

> +		 */
> +		emit_insn(ctx, addid, LOONGARCH_GPR_T3,
> LOONGARCH_GPR_ZERO, MAX_TAIL_CALL_CNT);
> +		*store_offset -= sizeof(long);
>  
> -static bool seen_call(struct jit_ctx *ctx)
> -{
> -	return (ctx->flags & SAVE_RA);
> -}
> +		emit_cond_jmp(ctx, BPF_JGT, REG_TCC,
> LOONGARCH_GPR_T3, 4);
>  
> -static bool seen_tail_call(struct jit_ctx *ctx)
> -{
> -	return (ctx->flags & SAVE_TCC);
> -}
> +		/* If REG_TCC < MAX_TAIL_CALL_CNT, the value in
> REG_TCC is a count,
> +		 * push TCC into stack
> +		 */
> +		emit_insn(ctx, std, REG_TCC, LOONGARCH_GPR_SP,
> *store_offset);
>  
> -static u8 tail_call_reg(struct jit_ctx *ctx)
> -{
> -	if (seen_call(ctx))
> -		return TCC_SAVED;
> +		/* Push the address of TCC into the stack */
> +		emit_insn(ctx, addid, REG_TCC, LOONGARCH_GPR_SP,
> *store_offset);
>  
> -	return REG_TCC;
> +		emit_uncond_jmp(ctx, 2);
> +
> +		/* If REG_TCC > MAX_TAIL_CALL_CNT, the value in
> REG_TCC is an address,
> +		 * push TCC_ptr into stack
> +		 */
> +		emit_insn(ctx, std, REG_TCC, LOONGARCH_GPR_SP,
> *store_offset);
> +
> +		*store_offset -= sizeof(long);
> +		emit_insn(ctx, std, REG_TCC, LOONGARCH_GPR_SP,
> *store_offset);
> +
> +	} else {
> +		*store_offset -= sizeof(long);
> +		emit_insn(ctx, std, REG_TCC, LOONGARCH_GPR_SP,
> *store_offset);
> +
> +		*store_offset -= sizeof(long);
> +		emit_insn(ctx, std, REG_TCC, LOONGARCH_GPR_SP,
> *store_offset);

These two lines in 'if' block and 'else' block are the same, so they
can be moved out of 'if... else...'. If so, the comment above needs to
be updated accordingly.

> +	}
>  }
>  
>  /*
> @@ -90,6 +114,10 @@ static u8 tail_call_reg(struct jit_ctx *ctx)
>   *                            |           $s4           |
>   *                            +-------------------------+
>   *                            |           $s5           |
> + *                            +-------------------------+
> + *                            |           tcc           |
> + *                            +-------------------------+
> + *                            |           tcc_ptr       |
>   *                            +-------------------------+ <--
> BPF_REG_FP
>   *                            |  prog->aux->stack_depth |
>   *                            |        (optional)       |
> @@ -100,11 +128,14 @@ static void build_prologue(struct jit_ctx *ctx)
>  {
>  	int i;
>  	int stack_adjust = 0, store_offset, bpf_stack_adjust;
> +	const struct bpf_prog *prog = ctx->prog;
> +	const bool is_main_prog = !bpf_is_subprog(prog);
> +

No need to add this new line.

>  
>  	bpf_stack_adjust = round_up(ctx->prog->aux->stack_depth,
> 16);
>  
> -	/* To store ra, fp, s0, s1, s2, s3, s4 and s5. */
> -	stack_adjust += sizeof(long) * 8;
> +	/* To store ra, fp, s0, s1, s2, s3, s4, s5, tcc and tcc_ptr
> */
> +	stack_adjust += sizeof(long) * 10;

How about keeping "stack_adjust += sizeof(long) * 8;" unchanged, but
add a new one:

        /* To store tcc and tcc_ptr */
	stack_adjust += sizeof(long) * 2;

>  
>  	stack_adjust = round_up(stack_adjust, 16);
>  	stack_adjust += bpf_stack_adjust;
> @@ -114,11 +145,13 @@ static void build_prologue(struct jit_ctx *ctx)
>  		emit_insn(ctx, nop);
>  
>  	/*
> -	 * First instruction initializes the tail call count (TCC).
> -	 * On tail call we skip this instruction, and the TCC is
> +	 * First instruction initializes the tail call count (TCC)
> register
> +	 * to zero. On tail call we skip this instruction, and the
> TCC is
>  	 * passed in REG_TCC from the caller.
>  	 */
> -	emit_insn(ctx, addid, REG_TCC, LOONGARCH_GPR_ZERO,
> MAX_TAIL_CALL_CNT);
> +	if (is_main_prog)
> +		emit_insn(ctx, addid, REG_TCC, LOONGARCH_GPR_ZERO,
> 0);
> +

No need to add this new line.

>  
>  	emit_insn(ctx, addid, LOONGARCH_GPR_SP, LOONGARCH_GPR_SP, -
> stack_adjust);
>  
> @@ -146,20 +179,14 @@ static void build_prologue(struct jit_ctx *ctx)
>  	store_offset -= sizeof(long);
>  	emit_insn(ctx, std, LOONGARCH_GPR_S5, LOONGARCH_GPR_SP,
> store_offset);
>  
> +	prepare_bpf_tail_call_cnt(ctx, &store_offset);
> +
> +

No need to add this new line.

>  	emit_insn(ctx, addid, LOONGARCH_GPR_FP, LOONGARCH_GPR_SP,
> stack_adjust);
>  
>  	if (bpf_stack_adjust)
>  		emit_insn(ctx, addid, regmap[BPF_REG_FP],
> LOONGARCH_GPR_SP, bpf_stack_adjust);
>  
> -	/*
> -	 * Program contains calls and tail calls, so REG_TCC need
> -	 * to be saved across calls.
> -	 */
> -	if (seen_tail_call(ctx) && seen_call(ctx))
> -		move_reg(ctx, TCC_SAVED, REG_TCC);
> -	else
> -		emit_insn(ctx, nop);
> -
>  	ctx->stack_size = stack_adjust;
>  }
>  
> @@ -192,6 +219,16 @@ static void __build_epilogue(struct jit_ctx
> *ctx, bool is_tail_call)
>  	load_offset -= sizeof(long);
>  	emit_insn(ctx, ldd, LOONGARCH_GPR_S5, LOONGARCH_GPR_SP,
> load_offset);
>  
> +	/*
> +	 *  When push into the stack, follow the order of tcc then
> tcc_ptr.
> +	 *  When pop from the stack, first pop tcc_ptr followed by
> tcc
> +	 */
> +	load_offset -= 2*sizeof(long);
> +	emit_insn(ctx, ldd, REG_TCC, LOONGARCH_GPR_SP, load_offset);
> +
> +	load_offset += sizeof(long);
> +	emit_insn(ctx, ldd, REG_TCC, LOONGARCH_GPR_SP, load_offset);
> +
>  	emit_insn(ctx, addid, LOONGARCH_GPR_SP, LOONGARCH_GPR_SP,
> stack_adjust);
>  
>  	if (!is_tail_call) {
> @@ -204,7 +241,7 @@ static void __build_epilogue(struct jit_ctx *ctx,
> bool is_tail_call)
>  		 * Call the next bpf prog and skip the first
> instruction
>  		 * of TCC initialization.
>  		 */
> -		emit_insn(ctx, jirl, LOONGARCH_GPR_ZERO,
> LOONGARCH_GPR_T3, 1);
> +		emit_insn(ctx, jirl, LOONGARCH_GPR_ZERO,
> LOONGARCH_GPR_T3, 6);
>  	}
>  }
>  
> @@ -226,7 +263,7 @@ bool bpf_jit_supports_far_kfunc_call(void)
>  static int emit_bpf_tail_call(struct jit_ctx *ctx, int insn)
>  {
>  	int off;
> -	u8 tcc = tail_call_reg(ctx);
> +	int tcc_ptr_off = BPF_TAIL_CALL_CNT_PTR_STACK_OFF(ctx-
> >stack_size);
>  	u8 a1 = LOONGARCH_GPR_A1;
>  	u8 a2 = LOONGARCH_GPR_A2;
>  	u8 t1 = LOONGARCH_GPR_T1;
> @@ -255,11 +292,15 @@ static int emit_bpf_tail_call(struct jit_ctx
> *ctx, int insn)
>  		goto toofar;
>  
>  	/*
> -	 * if (--TCC < 0)
> -	 *	 goto out;
> +	 * if ((*tcc_ptr)++ >= MAX_TAIL_CALL_CNT)
> +	 *      goto out;
>  	 */
> -	emit_insn(ctx, addid, REG_TCC, tcc, -1);
> -	if (emit_tailcall_jmp(ctx, BPF_JSLT, REG_TCC,
> LOONGARCH_GPR_ZERO, jmp_offset) < 0)
> +	emit_insn(ctx, ldd, REG_TCC, LOONGARCH_GPR_SP, tcc_ptr_off);
> +	emit_insn(ctx, ldd, t3, REG_TCC, 0);
> +	emit_insn(ctx, addid, t3, t3, 1);
> +	emit_insn(ctx, std, t3, REG_TCC, 0);
> +	emit_insn(ctx, addid, t2, LOONGARCH_GPR_ZERO,
> MAX_TAIL_CALL_CNT);
> +	if (emit_tailcall_jmp(ctx, BPF_JSGT, t3, t2, jmp_offset) <
> 0)
>  		goto toofar;
>  
>  	/*
> @@ -480,6 +521,7 @@ static int build_insn(const struct bpf_insn
> *insn, struct jit_ctx *ctx, bool ext
>  	const s16 off = insn->off;
>  	const s32 imm = insn->imm;
>  	const bool is32 = BPF_CLASS(insn->code) == BPF_ALU ||
> BPF_CLASS(insn->code) == BPF_JMP32;
> +	int tcc_ptr_off;
>  
>  	switch (code) {
>  	/* dst = src */
> @@ -906,12 +948,17 @@ static int build_insn(const struct bpf_insn
> *insn, struct jit_ctx *ctx, bool ext
>  
>  	/* function call */
>  	case BPF_JMP | BPF_CALL:
> -		mark_call(ctx);
>  		ret = bpf_jit_get_func_addr(ctx->prog, insn,
> extra_pass,
>  					    &func_addr,
> &func_addr_fixed);
>  		if (ret < 0)
>  			return ret;
>  
> +		if (insn->src_reg == BPF_PSEUDO_CALL) {
> +			tcc_ptr_off =
> BPF_TAIL_CALL_CNT_PTR_STACK_OFF(ctx->stack_size);
> +			emit_insn(ctx, ldd, REG_TCC,
> LOONGARCH_GPR_SP, tcc_ptr_off);
> +		}
> +
> +

No need to add this new line.

>  		move_addr(ctx, t1, func_addr);
>  		emit_insn(ctx, jirl, LOONGARCH_GPR_RA, t1, 0);
>  
> @@ -922,7 +969,6 @@ static int build_insn(const struct bpf_insn
> *insn, struct jit_ctx *ctx, bool ext
>  
>  	/* tail call */
>  	case BPF_JMP | BPF_TAIL_CALL:
> -		mark_tail_call(ctx);
>  		if (emit_bpf_tail_call(ctx, i) < 0)
>  			return -EINVAL;
>  		break;
> @@ -1590,7 +1636,7 @@ static int __arch_prepare_bpf_trampoline(struct
> jit_ctx *ctx, struct bpf_tramp_i
>  {
>  	int i;
>  	int stack_size = 0, nargs = 0;
> -	int retval_off, args_off, nargs_off, ip_off, run_ctx_off,
> sreg_off;
> +	int retval_off, args_off, nargs_off, ip_off, run_ctx_off,
> sreg_off, tcc_ptr_off;
>  	struct bpf_tramp_links *fentry = &tlinks[BPF_TRAMP_FENTRY];
>  	struct bpf_tramp_links *fexit = &tlinks[BPF_TRAMP_FEXIT];
>  	struct bpf_tramp_links *fmod_ret =
> &tlinks[BPF_TRAMP_MODIFY_RETURN];
> @@ -1626,6 +1672,7 @@ static int __arch_prepare_bpf_trampoline(struct
> jit_ctx *ctx, struct bpf_tramp_i
>  	 *
>  	 * FP - sreg_off    [ callee saved reg  ]
>  	 *
> +	 * FP - tcc_ptr_off [ tail_call_cnt_ptr ]
>  	 */
>  
>  	if (m->nr_args > LOONGARCH_MAX_REG_ARGS)
> @@ -1668,6 +1715,13 @@ static int
> __arch_prepare_bpf_trampoline(struct jit_ctx *ctx, struct bpf_tramp_i
>  	stack_size += 8;
>  	sreg_off = stack_size;
>  
> +	/* room of trampoline frame to store tail_call_cnt_ptr */
> +	if (flags & BPF_TRAMP_F_TAIL_CALL_CTX) {
> +		stack_size += 8;
> +		tcc_ptr_off = stack_size;
> +	}
> +
> +

No need to add this new line.

>  	stack_size = round_up(stack_size, 16);
>  
>  	if (!is_struct_ops) {
> @@ -1696,6 +1750,10 @@ static int
> __arch_prepare_bpf_trampoline(struct jit_ctx *ctx, struct bpf_tramp_i
>  		emit_insn(ctx, addid, LOONGARCH_GPR_FP,
> LOONGARCH_GPR_SP, stack_size);
>  	}
>  
> +	if (flags & BPF_TRAMP_F_TAIL_CALL_CTX)
> +		emit_insn(ctx, std, REG_TCC, LOONGARCH_GPR_FP, -
> tcc_ptr_off);
> +
> +

No need to add this new line.

>  	/* callee saved register S1 to pass start time */
>  	emit_insn(ctx, std, LOONGARCH_GPR_S1, LOONGARCH_GPR_FP, -
> sreg_off);
>  
> @@ -1743,6 +1801,10 @@ static int
> __arch_prepare_bpf_trampoline(struct jit_ctx *ctx, struct bpf_tramp_i
>  
>  	if (flags & BPF_TRAMP_F_CALL_ORIG) {
>  		restore_args(ctx, m->nr_args, args_off);
> +
> +		if (flags & BPF_TRAMP_F_TAIL_CALL_CTX)
> +			emit_insn(ctx, ldd, REG_TCC,
> LOONGARCH_GPR_FP, -tcc_ptr_off);
> +
>  		ret = emit_call(ctx, (const u64)orig_call);
>  		if (ret)
>  			goto out;
> @@ -1784,6 +1846,10 @@ static int
> __arch_prepare_bpf_trampoline(struct jit_ctx *ctx, struct bpf_tramp_i
>  
>  	emit_insn(ctx, ldd, LOONGARCH_GPR_S1, LOONGARCH_GPR_FP, -
> sreg_off);
>  
> +	if (flags & BPF_TRAMP_F_TAIL_CALL_CTX)
> +		emit_insn(ctx, ldd, REG_TCC, LOONGARCH_GPR_FP, -
> tcc_ptr_off);
> +
> +

No need to add this new line.

>  	if (!is_struct_ops) {
>  		/* trampoline called from function entry */
>  		emit_insn(ctx, ldd, LOONGARCH_GPR_T0,
> LOONGARCH_GPR_SP, stack_size - 8);

Thanks,
-Geliang


