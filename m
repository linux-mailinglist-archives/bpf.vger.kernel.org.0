Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A441E59B7CC
	for <lists+bpf@lfdr.de>; Mon, 22 Aug 2022 04:52:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232000AbiHVCuo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 21 Aug 2022 22:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231878AbiHVCun (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 21 Aug 2022 22:50:43 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 29F94240BF
        for <bpf@vger.kernel.org>; Sun, 21 Aug 2022 19:50:39 -0700 (PDT)
Received: from [192.168.20.136] (unknown [171.223.99.204])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Cx72v57gJjdCYHAA--.28411S3;
        Mon, 22 Aug 2022 10:50:34 +0800 (CST)
Message-ID: <9a81abf8-27f3-fbbb-f3c4-2e9d071cde40@loongson.cn>
Date:   Mon, 22 Aug 2022 10:50:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH bpf-next v1 3/4] LoongArch: Add BPF JIT support
Content-Language: en-US
To:     Tiezhu Yang <yangtiezhu@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, loongarch@lists.linux.dev
References: <1660996260-11337-1-git-send-email-yangtiezhu@loongson.cn>
 <1660996260-11337-4-git-send-email-yangtiezhu@loongson.cn>
From:   Jinyang He <hejinyang@loongson.cn>
In-Reply-To: <1660996260-11337-4-git-send-email-yangtiezhu@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8Cx72v57gJjdCYHAA--.28411S3
X-Coremail-Antispam: 1UD129KBjvAXoW3Cry8Kw1xKFyDKFyrXrWUurg_yoW8XFyrto
        Wqvry0ka15Jr13Aw1akry5C3sIqF1v9w48JrWayrn5GrWrAas8XrsxXw47u393XFn0qFyU
        CFW7WayjvasFyF1Un29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
        AaLaJ3UjIYCTnIWjp_UUUYB7k0a2IF6w4kM7kC6x804xWl14x267AKxVW8JVW5JwAFc2x0
        x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj4
        1l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0
        I7IYx2IY6xkF7I0E14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjc
        xK6I8E87Iv6xkF7I0E14v26F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40E
        FcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr
        0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxv
        r21lc2xSY4AK67AK6r4UMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMx
        CIbckI1I0E14v26r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_
        JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14
        v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xva
        j40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJV
        W8JbIYCTnIWIevJa73UjIFyTuYvjxUgUPiUUUUU
X-CM-SenderInfo: pkhmx0p1dqwqxorr0wxvrqhubq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi, Tiezhu,

On 2022/8/20 19:50, Tiezhu Yang wrote:
> BPF programs are normally handled by a BPF interpreter, add BPF JIT
> support for LoongArch to allow the kernel to generate native code
> when a program is loaded into the kernel, this will significantly
> speed-up processing of BPF programs.
>
> Co-developed-by: Youling Tang <tangyouling@loongson.cn>
> Signed-off-by: Youling Tang <tangyouling@loongson.cn>
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>   arch/loongarch/Kbuild             |    1 +
>   arch/loongarch/Kconfig            |    1 +
>   arch/loongarch/include/asm/inst.h |  185 ++++++
>   arch/loongarch/net/Makefile       |    7 +
>   arch/loongarch/net/bpf_jit.c      | 1113 +++++++++++++++++++++++++++++++++++++
>   arch/loongarch/net/bpf_jit.h      |  308 ++++++++++
>   6 files changed, 1615 insertions(+)
>   create mode 100644 arch/loongarch/net/Makefile
>   create mode 100644 arch/loongarch/net/bpf_jit.c
>   create mode 100644 arch/loongarch/net/bpf_jit.h
[...]
> +
> +/*
> + * eBPF prog stack layout:
> + *
> + *                                        high
> + * original $sp ------------> +-------------------------+ <--LOONGARCH_GPR_FP
> + *                            |           $ra           |
> + *                            +-------------------------+
> + *                            |           $fp           |
> + *                            +-------------------------+
> + *                            |           $s0           |
> + *                            +-------------------------+
> + *                            |           $s1           |
> + *                            +-------------------------+
> + *                            |           $s2           |
> + *                            +-------------------------+
> + *                            |           $s3           |
> + *                            +-------------------------+
> + *                            |           $s4           |
> + *                            +-------------------------+
> + *                            |           $s5           |
> + *                            +-------------------------+ <--BPF_REG_FP
> + *                            |  prog->aux->stack_depth |
> + *                            |        (optional)       |
> + * current $sp -------------> +-------------------------+
> + *                                        low
> + */
> +static void build_prologue(struct jit_ctx *ctx)
> +{
> +	int stack_adjust = 0, store_offset, bpf_stack_adjust;
> +
> +	bpf_stack_adjust = round_up(ctx->prog->aux->stack_depth, 16);
> +
> +	/* To store ra, fp, s0, s1, s2, s3, s4 and s5. */
> +	stack_adjust += sizeof(long) * 8;
> +
> +	stack_adjust = round_up(stack_adjust, 16);
> +	stack_adjust += bpf_stack_adjust;
> +
> +	/*
> +	 * First instruction initializes the tail call count (TCC).
> +	 * On tail call we skip this instruction, and the TCC is
> +	 * passed in REG_TCC from the caller.
> +	 */
> +	emit_insn(ctx, addid, REG_TCC, LOONGARCH_GPR_ZERO, MAX_TAIL_CALL_CNT);
> +
> +	emit_insn(ctx, addid, LOONGARCH_GPR_SP, LOONGARCH_GPR_SP, -stack_adjust);

Have you checked the stack size before this, such as in compiler or
common codes? Is there any chance of overflow 12bits range?

> +
> +	store_offset = stack_adjust - sizeof(long);
> +	emit_insn(ctx, std, LOONGARCH_GPR_RA, LOONGARCH_GPR_SP, store_offset);
> +
> +	store_offset -= sizeof(long);
> +	emit_insn(ctx, std, LOONGARCH_GPR_FP, LOONGARCH_GPR_SP, store_offset);
> +
> +	store_offset -= sizeof(long);
> +	emit_insn(ctx, std, LOONGARCH_GPR_S0, LOONGARCH_GPR_SP, store_offset);
> +
> +	store_offset -= sizeof(long);
> +	emit_insn(ctx, std, LOONGARCH_GPR_S1, LOONGARCH_GPR_SP, store_offset);
> +
> +	store_offset -= sizeof(long);
> +	emit_insn(ctx, std, LOONGARCH_GPR_S2, LOONGARCH_GPR_SP, store_offset);
> +
> +	store_offset -= sizeof(long);
> +	emit_insn(ctx, std, LOONGARCH_GPR_S3, LOONGARCH_GPR_SP, store_offset);
> +
> +	store_offset -= sizeof(long);
> +	emit_insn(ctx, std, LOONGARCH_GPR_S4, LOONGARCH_GPR_SP, store_offset);
> +
> +	store_offset -= sizeof(long);
> +	emit_insn(ctx, std, LOONGARCH_GPR_S5, LOONGARCH_GPR_SP, store_offset);
> +
> +	emit_insn(ctx, addid, LOONGARCH_GPR_FP, LOONGARCH_GPR_SP, stack_adjust);
> +
> +	if (bpf_stack_adjust)
> +		emit_insn(ctx, addid, regmap[BPF_REG_FP], LOONGARCH_GPR_SP, bpf_stack_adjust);
> +
> +	/*
> +	 * Program contains calls and tail calls, so REG_TCC need
> +	 * to be saved across calls.
> +	 */
> +	if (seen_tail_call(ctx) && seen_call(ctx))
> +		move_reg(ctx, TCC_SAVED, REG_TCC);
> +
> +	ctx->stack_size = stack_adjust;
> +}
> +
[...]
> +
> +/* initialized on the first pass of build_body() */
> +static int out_offset = -1;
> +static int emit_bpf_tail_call(struct jit_ctx *ctx)
> +{
> +	int off;
> +	u8 tcc = tail_call_reg(ctx);
> +	u8 a1 = LOONGARCH_GPR_A1;
> +	u8 a2 = LOONGARCH_GPR_A2;
> +	u8 t1 = LOONGARCH_GPR_T1;
> +	u8 t2 = LOONGARCH_GPR_T2;
> +	u8 t3 = LOONGARCH_GPR_T3;
> +	const int idx0 = ctx->idx;
> +
> +#define cur_offset (ctx->idx - idx0)
> +#define jmp_offset (out_offset - (cur_offset))
> +
> +	/*
> +	 * a0: &ctx
> +	 * a1: &array
> +	 * a2: index
> +	 *
> +	 * if (index >= array->map.max_entries)
> +	 *	 goto out;
> +	 */
> +	off = offsetof(struct bpf_array, map.max_entries);
> +	emit_insn(ctx, ldwu, t1, a1, off);
> +	/* bgeu $a2, $t1, jmp_offset */
> +	emit_tailcall_jmp(ctx, BPF_JGE, a2, t1, jmp_offset);
> +
> +	/*
> +	 * if (--TCC < 0)
> +	 *	 goto out;
> +	 */
> +	emit_insn(ctx, addid, REG_TCC, tcc, -1);
> +	emit_tailcall_jmp(ctx, BPF_JSLT, REG_TCC, LOONGARCH_GPR_ZERO, jmp_offset);
> +
> +	/*
> +	 * prog = array->ptrs[index];
> +	 * if (!prog)
> +	 *	 goto out;
> +	 */
> +	emit_insn(ctx, sllid, t2, a2, 3);
> +	emit_insn(ctx, addd, t2, t2, a1);
alsl.d
> +	off = offsetof(struct bpf_array, ptrs);
> +	emit_insn(ctx, ldd, t2, t2, off);
> +	/* beq $t2, $zero, jmp_offset */
> +	emit_tailcall_jmp(ctx, BPF_JEQ, t2, LOONGARCH_GPR_ZERO, jmp_offset);
> +
> +	/* goto *(prog->bpf_func + 4); */
> +	off = offsetof(struct bpf_prog, bpf_func);
> +	emit_insn(ctx, ldd, t3, t2, off);
> +	__build_epilogue(ctx, true);
> +
> +	/* out: */
> +	if (out_offset == -1)
> +		out_offset = cur_offset;
> +	if (cur_offset != out_offset) {
> +		pr_err_once("tail_call out_offset = %d, expected %d!\n",
> +			    cur_offset, out_offset);
> +		return -1;
> +	}
> +
> +	return 0;
> +#undef cur_offset
> +#undef jmp_offset
> +}
> +
[...]
> +
> +	/* dst = BSWAP##imm(dst) */
> +	case BPF_ALU | BPF_END | BPF_FROM_LE:
> +		switch (imm) {
> +		case 16:
> +			/* zero-extend 16 bits into 64 bits */
> +			emit_insn(ctx, sllid, dst, dst, 48);
> +			emit_insn(ctx, srlid, dst, dst, 48);
bstrpick.d
> +			break;
> +		case 32:
> +			/* zero-extend 32 bits into 64 bits */
> +			emit_zext_32(ctx, dst, is32);
> +			break;
> +		case 64:
> +			/* do nothing */
> +			break;
> +		}
> +		break;
> +	case BPF_ALU | BPF_END | BPF_FROM_BE:
> +		switch (imm) {
> +		case 16:
> +			emit_insn(ctx, revb2h, dst, dst);
> +			/* zero-extend 16 bits into 64 bits */
> +			emit_insn(ctx, sllid, dst, dst, 48);
> +			emit_insn(ctx, srlid, dst, dst, 48);
> +			break;
> +		case 32:
> +			emit_insn(ctx, revb2w, dst, dst);
> +			/* zero-extend 32 bits into 64 bits */
> +			emit_zext_32(ctx, dst, is32);
> +			break;
> +		case 64:
> +			emit_insn(ctx, revbd, dst, dst);
> +			break;
> +		}
> +		break;
> +
> +	/* PC += off if dst cond src */
> +	case BPF_JMP | BPF_JEQ | BPF_X:
> +	case BPF_JMP | BPF_JNE | BPF_X:
> +	case BPF_JMP | BPF_JGT | BPF_X:
> +	case BPF_JMP | BPF_JGE | BPF_X:
> +	case BPF_JMP | BPF_JLT | BPF_X:
> +	case BPF_JMP | BPF_JLE | BPF_X:
> +	case BPF_JMP | BPF_JSGT | BPF_X:
> +	case BPF_JMP | BPF_JSGE | BPF_X:
> +	case BPF_JMP | BPF_JSLT | BPF_X:
> +	case BPF_JMP | BPF_JSLE | BPF_X:
> +	case BPF_JMP32 | BPF_JEQ | BPF_X:
> +	case BPF_JMP32 | BPF_JNE | BPF_X:
> +	case BPF_JMP32 | BPF_JGT | BPF_X:
> +	case BPF_JMP32 | BPF_JGE | BPF_X:
> +	case BPF_JMP32 | BPF_JLT | BPF_X:
> +	case BPF_JMP32 | BPF_JLE | BPF_X:
> +	case BPF_JMP32 | BPF_JSGT | BPF_X:
> +	case BPF_JMP32 | BPF_JSGE | BPF_X:
> +	case BPF_JMP32 | BPF_JSLT | BPF_X:
> +	case BPF_JMP32 | BPF_JSLE | BPF_X:
> +		jmp_offset = bpf2la_offset(i, off, ctx);
> +		move_reg(ctx, t1, dst);
> +		move_reg(ctx, t2, src);
> +		if (is_signed_bpf_cond(BPF_OP(code))) {
> +			emit_sext_32(ctx, t1, is32);
> +			emit_sext_32(ctx, t2, is32);
> +		} else {
> +			emit_zext_32(ctx, t1, is32);
> +			emit_zext_32(ctx, t2, is32);
> +		}
> +		emit_cond_jmp(ctx, cond, t1, t2, jmp_offset);
> +		break;
> +
> +	/* PC += off if dst cond imm */
> +	case BPF_JMP | BPF_JEQ | BPF_K:
> +	case BPF_JMP | BPF_JNE | BPF_K:
> +	case BPF_JMP | BPF_JGT | BPF_K:
> +	case BPF_JMP | BPF_JGE | BPF_K:
> +	case BPF_JMP | BPF_JLT | BPF_K:
> +	case BPF_JMP | BPF_JLE | BPF_K:
> +	case BPF_JMP | BPF_JSGT | BPF_K:
> +	case BPF_JMP | BPF_JSGE | BPF_K:
> +	case BPF_JMP | BPF_JSLT | BPF_K:
> +	case BPF_JMP | BPF_JSLE | BPF_K:
> +	case BPF_JMP32 | BPF_JEQ | BPF_K:
> +	case BPF_JMP32 | BPF_JNE | BPF_K:
> +	case BPF_JMP32 | BPF_JGT | BPF_K:
> +	case BPF_JMP32 | BPF_JGE | BPF_K:
> +	case BPF_JMP32 | BPF_JLT | BPF_K:
> +	case BPF_JMP32 | BPF_JLE | BPF_K:
> +	case BPF_JMP32 | BPF_JSGT | BPF_K:
> +	case BPF_JMP32 | BPF_JSGE | BPF_K:
> +	case BPF_JMP32 | BPF_JSLT | BPF_K:
> +	case BPF_JMP32 | BPF_JSLE | BPF_K:
> +		jmp_offset = bpf2la_offset(i, off, ctx);
> +		move_imm32(ctx, t1, imm, false);
imm = 0 -> t1->zero
> +		move_reg(ctx, t2, dst);
> +		if (is_signed_bpf_cond(BPF_OP(code))) {
> +			emit_sext_32(ctx, t1, is32);
> +			emit_sext_32(ctx, t2, is32);
> +		} else {
> +			emit_zext_32(ctx, t1, is32);
> +			emit_zext_32(ctx, t2, is32);
> +		}
> +		emit_cond_jmp(ctx, cond, t2, t1, jmp_offset);
> +		break;
> +
> +	/* PC += off if dst & src */
> +	case BPF_JMP | BPF_JSET | BPF_X:
> +	case BPF_JMP32 | BPF_JSET | BPF_X:
> +		jmp_offset = bpf2la_offset(i, off, ctx);
> +		emit_insn(ctx, and, t1, dst, src);
> +		emit_zext_32(ctx, t1, is32);
> +		emit_cond_jmp(ctx, cond, t1, LOONGARCH_GPR_ZERO, jmp_offset);
> +		break;
> +	/* PC += off if dst & imm */
> +	case BPF_JMP | BPF_JSET | BPF_K:
> +	case BPF_JMP32 | BPF_JSET | BPF_K:
> +		jmp_offset = bpf2la_offset(i, off, ctx);
> +		move_imm32(ctx, t1, imm, is32);
> +		emit_insn(ctx, and, t1, dst, t1);
> +		emit_zext_32(ctx, t1, is32);
> +		emit_cond_jmp(ctx, cond, t1, LOONGARCH_GPR_ZERO, jmp_offset);
> +		break;
> +
> +	/* PC += off */
> +	case BPF_JMP | BPF_JA:
> +		jmp_offset = bpf2la_offset(i, off, ctx);
> +		emit_uncond_jmp(ctx, jmp_offset, is32);
> +		break;
> +
> +	/* function call */
> +	case BPF_JMP | BPF_CALL:
> +		bool func_addr_fixed;
> +		u64 func_addr;
> +		int ret;
> +
> +		mark_call(ctx);
> +		ret = bpf_jit_get_func_addr(ctx->prog, insn, extra_pass,
> +					    &func_addr, &func_addr_fixed);
> +		if (ret < 0)
> +			return ret;
> +
> +		move_imm64(ctx, t1, func_addr, is32);
> +		emit_insn(ctx, jirl, t1, LOONGARCH_GPR_RA, 0);
> +		move_reg(ctx, regmap[BPF_REG_0], LOONGARCH_GPR_A0);
> +		break;
> +
> +	/* tail call */
> +	case BPF_JMP | BPF_TAIL_CALL:
> +		mark_tail_call(ctx);
> +		if (emit_bpf_tail_call(ctx))
> +			return -EINVAL;
> +		break;
> +
> +	/* function return */
> +	case BPF_JMP | BPF_EXIT:
> +		emit_sext_32(ctx, regmap[BPF_REG_0], true);
> +
> +		if (i == ctx->prog->len - 1)
> +			break;
> +
> +		jmp_offset = epilogue_offset(ctx);
> +		emit_uncond_jmp(ctx, jmp_offset, true);
> +		break;
> +
> +	/* dst = imm64 */
> +	case BPF_LD | BPF_IMM | BPF_DW:
> +		u64 imm64 = (u64)(insn + 1)->imm << 32 | (u32)insn->imm;
> +
> +		move_imm64(ctx, dst, imm64, is32);
> +		return 1;
> +
> +	/* dst = *(size *)(src + off) */
> +	case BPF_LDX | BPF_MEM | BPF_B:
> +	case BPF_LDX | BPF_MEM | BPF_H:
> +	case BPF_LDX | BPF_MEM | BPF_W:
> +	case BPF_LDX | BPF_MEM | BPF_DW:
> +		if (is_signed_imm12(off)) {
> +			switch (BPF_SIZE(code)) {
> +			case BPF_B:
> +				emit_insn(ctx, ldbu, dst, src, off);
> +				break;
> +			case BPF_H:
> +				emit_insn(ctx, ldhu, dst, src, off);
> +				break;
> +			case BPF_W:
> +				emit_insn(ctx, ldwu, dst, src, off);
> +				break;
> +			case BPF_DW:
> +				emit_insn(ctx, ldd, dst, src, off);
> +				break;
> +			}
> +		} else {
> +			move_imm32(ctx, t1, off, is32);
> +			switch (BPF_SIZE(code)) {
> +			case BPF_B:
> +				emit_insn(ctx, ldxbu, dst, src, t1);
> +				break;
> +			case BPF_H:
> +				emit_insn(ctx, ldxhu, dst, src, t1);
> +				break;
> +			case BPF_W:
> +				emit_insn(ctx, ldxwu, dst, src, t1);
> +				break;
> +			case BPF_DW:
> +				emit_insn(ctx, ldxd, dst, src, t1);
> +				break;

In BFD_W, BFF_DW cases, if offsets is quadruple and in 16bits range,
we can use [ld/st]ptr.[w/d].
> +			}
> +		}
> +		break;
> +
> +	/* *(size *)(dst + off) = imm */
> +	case BPF_ST | BPF_MEM | BPF_B:
> +	case BPF_ST | BPF_MEM | BPF_H:
> +	case BPF_ST | BPF_MEM | BPF_W:
> +	case BPF_ST | BPF_MEM | BPF_DW:
> +		move_imm32(ctx, t1, imm, is32);
> +		if (is_signed_imm12(off)) {
> +			switch (BPF_SIZE(code)) {
> +			case BPF_B:
> +				emit_insn(ctx, stb, t1, dst, off);
> +				break;
> +			case BPF_H:
> +				emit_insn(ctx, sth, t1, dst, off);
> +				break;
> +			case BPF_W:
> +				emit_insn(ctx, stw, t1, dst, off);
> +				break;
> +			case BPF_DW:
> +				emit_insn(ctx, std, t1, dst, off);
> +				break;
> +			}
> +		} else {
> +			move_imm32(ctx, t2, off, is32);
> +			switch (BPF_SIZE(code)) {
> +			case BPF_B:
> +				emit_insn(ctx, stxb, t1, dst, t2);
> +				break;
> +			case BPF_H:
> +				emit_insn(ctx, stxh, t1, dst, t2);
> +				break;
> +			case BPF_W:
> +				emit_insn(ctx, stxw, t1, dst, t2);
> +				break;
> +			case BPF_DW:
> +				emit_insn(ctx, stxd, t1, dst, t2);
> +				break;
> +			}
> +		}
> +		break;
> +
> +	/* *(size *)(dst + off) = src */
> +	case BPF_STX | BPF_MEM | BPF_B:
> +	case BPF_STX | BPF_MEM | BPF_H:
> +	case BPF_STX | BPF_MEM | BPF_W:
> +	case BPF_STX | BPF_MEM | BPF_DW:
> +		if (is_signed_imm12(off)) {
> +			switch (BPF_SIZE(code)) {
> +			case BPF_B:
> +				emit_insn(ctx, stb, src, dst, off);
> +				break;
> +			case BPF_H:
> +				emit_insn(ctx, sth, src, dst, off);
> +				break;
> +			case BPF_W:
> +				emit_insn(ctx, stw, src, dst, off);
> +				break;
> +			case BPF_DW:
> +				emit_insn(ctx, std, src, dst, off);
> +				break;
> +			}
> +		} else {
> +			move_imm32(ctx, t1, off, is32);
> +			switch (BPF_SIZE(code)) {
> +			case BPF_B:
> +				emit_insn(ctx, stxb, src, dst, t1);
> +				break;
> +			case BPF_H:
> +				emit_insn(ctx, stxh, src, dst, t1);
> +				break;
> +			case BPF_W:
> +				emit_insn(ctx, stxw, src, dst, t1);
> +				break;
> +			case BPF_DW:
> +				emit_insn(ctx, stxd, src, dst, t1);
> +				break;
> +			}
> +		}
> +		break;
> +
> +	case BPF_STX | BPF_ATOMIC | BPF_W:
> +	case BPF_STX | BPF_ATOMIC | BPF_DW:
> +		emit_atomic(insn, ctx);
> +		break;
> +
> +	default:
> +		pr_err("bpf_jit: unknown opcode %02x\n", code);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
[...]
> +
> +static inline void move_imm64(struct jit_ctx *ctx, enum loongarch_gpr rd,
> +			      long imm64, bool is32)
> +{
> +	int imm32, si20, si12;
> +	long imm52;
> +
> +	si12 = (imm64 >> 52) & 0xfff;
> +	imm52 = imm64 & 0xfffffffffffff;
> +	/* lu52id rd, $zero, imm_63_52(signed) */
> +	if (si12 != 0 && imm52 == 0) {
> +		emit_insn(ctx, lu52id, rd, LOONGARCH_GPR_ZERO, si12);
> +		return;
> +	}
> +
> +	imm32 = imm64 & 0xffffffff;
> +	move_imm32(ctx, rd, imm32, is32);
> +
> +	if (!is_signed_imm32(imm64)) {
> +		if (imm52 != 0) {
> +			/* lu32id rd, imm_51_32(signed) */
> +			si20 = (imm64 >> 32) & 0xfffff;
> +			emit_insn(ctx, lu32id, rd, si20);
Imm32 is signed, lu32i.d can be optimized in some cases.
> +		}
> +
> +		/* lu52id rd, rd, imm_63_52(signed) */
> +		if (!is_signed_imm52(imm64))
> +			emit_insn(ctx, lu52id, rd, rd, si12);
> +	}
> +}
> +
> +static inline void move_reg(struct jit_ctx *ctx, enum loongarch_gpr rd,
> +			    enum loongarch_gpr rj)
> +{
> +	emit_insn(ctx, or, rd, rj, LOONGARCH_GPR_ZERO);
> +}
> +
[...]
> +
> +static inline void emit_cond_jmp(struct jit_ctx *ctx, u8 cond, enum loongarch_gpr rj,
> +				 enum loongarch_gpr rd, int jmp_offset)
> +{
> +	cond_jmp_offs26(ctx, cond, rj, rd, jmp_offset);

Why not call cond_jmp_offs16 as a preference?


Thanks,

Jinyang

> +}
> +
> +static inline void emit_uncond_jmp(struct jit_ctx *ctx, int jmp_offset, bool is_exit)
> +{
> +	if (is_signed_imm26(jmp_offset))
> +		uncond_jmp_offs26(ctx, jmp_offset);
> +	else
> +		uncond_jmp_offs32(ctx, jmp_offset, is_exit);
> +}
> +
> +static inline void emit_tailcall_jmp(struct jit_ctx *ctx, u8 cond, enum loongarch_gpr rj,
> +				     enum loongarch_gpr rd, int jmp_offset)
> +{
> +	if (is_signed_imm16(jmp_offset))
> +		cond_jmp_offs16(ctx, cond, rj, rd, jmp_offset);
> +	else if (is_signed_imm26(jmp_offset))
> +		cond_jmp_offs26(ctx, cond, rj, rd, jmp_offset - 1);
> +	else
> +		cond_jmp_offs32(ctx, cond, rj, rd, jmp_offset - 2);
> +}

