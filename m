Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09A8059B75C
	for <lists+bpf@lfdr.de>; Mon, 22 Aug 2022 04:02:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232126AbiHVB6p (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 21 Aug 2022 21:58:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232143AbiHVB6n (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 21 Aug 2022 21:58:43 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AC63D11C13
        for <bpf@vger.kernel.org>; Sun, 21 Aug 2022 18:58:38 -0700 (PDT)
Received: from [10.130.0.193] (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxvmvG4gJjUiEHAA--.19640S3;
        Mon, 22 Aug 2022 09:58:31 +0800 (CST)
Subject: Re: [PATCH bpf-next v1 3/4] LoongArch: Add BPF JIT support
To:     Tiezhu Yang <yangtiezhu@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
References: <1660996260-11337-1-git-send-email-yangtiezhu@loongson.cn>
 <1660996260-11337-4-git-send-email-yangtiezhu@loongson.cn>
Cc:     bpf@vger.kernel.org, loongarch@lists.linux.dev
From:   Youling Tang <tangyouling@loongson.cn>
Message-ID: <1a68f4f3-7a9e-6cf9-c4d5-98b8b874de31@loongson.cn>
Date:   Mon, 22 Aug 2022 09:58:30 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <1660996260-11337-4-git-send-email-yangtiezhu@loongson.cn>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8DxvmvG4gJjUiEHAA--.19640S3
X-Coremail-Antispam: 1UD129KBjvAXoWDWrW8JF47tr1kCryrGw15Jwb_yoWrKF4kKo
        W7t340kw45Jr13Z343Kry5AFWSvFn29w48J39xArn5ur4rA3sxWFsxJw47u393XFn0qFyj
        kay7XayjvasrAr1Un29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
        AaLaJ3UjIYCTnIWjp_UUUY-7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20EY4v20xva
        j40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2
        x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWx
        JVW8Jr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxV
        W8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xf
        McIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7
        v_Jr0_Gr1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7Mxk0xIA0c2IEe2xF
        o4CEbIxvr21lc2xSY4AK67AK6w4l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr
        0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY
        17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcV
        C0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY
        6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvj
        DU0xZFpf9x0JUChFxUUUUU=
X-CM-SenderInfo: 5wdqw5prxox03j6o00pqjv00gofq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 08/20/2022 07:50 PM, Tiezhu Yang wrote:
> BPF programs are normally handled by a BPF interpreter, add BPF JIT
> support for LoongArch to allow the kernel to generate native code
> when a program is loaded into the kernel, this will significantly
> speed-up processing of BPF programs.
>
> Co-developed-by: Youling Tang <tangyouling@loongson.cn>
> Signed-off-by: Youling Tang <tangyouling@loongson.cn>
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>  arch/loongarch/Kbuild             |    1 +
>  arch/loongarch/Kconfig            |    1 +
>  arch/loongarch/include/asm/inst.h |  185 ++++++
>  arch/loongarch/net/Makefile       |    7 +
>  arch/loongarch/net/bpf_jit.c      | 1113 +++++++++++++++++++++++++++++++++++++
>  arch/loongarch/net/bpf_jit.h      |  308 ++++++++++
>  6 files changed, 1615 insertions(+)
>  create mode 100644 arch/loongarch/net/Makefile
>  create mode 100644 arch/loongarch/net/bpf_jit.c
>  create mode 100644 arch/loongarch/net/bpf_jit.h
>
> diff --git a/arch/loongarch/Kbuild b/arch/loongarch/Kbuild
> index ab5373d..b01f5cd 100644
> --- a/arch/loongarch/Kbuild
> +++ b/arch/loongarch/Kbuild
> @@ -1,5 +1,6 @@
>  obj-y += kernel/
>  obj-y += mm/
> +obj-y += net/
>  obj-y += vdso/
>
>  # for cleaning
> diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
> index 4abc9a2..6d9d846 100644
> --- a/arch/loongarch/Kconfig
> +++ b/arch/loongarch/Kconfig
> @@ -82,6 +82,7 @@ config LOONGARCH
>  	select HAVE_CONTEXT_TRACKING_USER
>  	select HAVE_DEBUG_STACKOVERFLOW
>  	select HAVE_DMA_CONTIGUOUS
> +	select HAVE_EBPF_JIT if 64BIT
>  	select HAVE_EXIT_THREAD
>  	select HAVE_FAST_GUP
>  	select HAVE_GENERIC_VDSO
> diff --git a/arch/loongarch/include/asm/inst.h b/arch/loongarch/include/asm/inst.h
> index de19a96..ac06f2e 100644
> --- a/arch/loongarch/include/asm/inst.h
> +++ b/arch/loongarch/include/asm/inst.h
> @@ -288,4 +288,189 @@ static inline bool unsigned_imm_check(unsigned long val, unsigned int bit)
>  	return val < (1UL << bit);
>  }
>
> +#define DEF_EMIT_REG0I26_FORMAT(NAME, OP)				\
> +static inline void emit_##NAME(union loongarch_instruction *insn,	\
> +			       int offset)				\
> +{									\
> +	unsigned int immediate_l, immediate_h;				\
> +									\
> +	immediate_l = offset & 0xffff;					\
> +	offset >>= 16;							\
> +	immediate_h = offset & 0x3ff;					\
> +									\
> +	insn->reg0i26_format.opcode = OP;				\
> +	insn->reg0i26_format.immediate_l = immediate_l;			\
> +	insn->reg0i26_format.immediate_h = immediate_h;			\
> +}
> +
> +DEF_EMIT_REG0I26_FORMAT(b, b_op)
> +
> +#define DEF_EMIT_REG1I20_FORMAT(NAME, OP)				\
> +static inline void emit_##NAME(union loongarch_instruction *insn,	\
> +			       enum loongarch_gpr rd, int imm)		\
> +{									\
> +	insn->reg1i20_format.opcode = OP;				\
> +	insn->reg1i20_format.immediate = imm;				\
> +	insn->reg1i20_format.rd = rd;					\
> +}
> +
> +DEF_EMIT_REG1I20_FORMAT(lu12iw, lu12iw_op)
> +DEF_EMIT_REG1I20_FORMAT(lu32id, lu32id_op)

We can delete the larch_insn_gen_{lu32id, lu52id, jirl} functions in
inst.c and use emit_xxx.

The implementation of emit_plt_entry() is similarly modified as follows:
struct plt_entry {
         union loongarch_instruction lu12iw;
         union loongarch_instruction lu32id;
         union loongarch_instruction lu52id;
         union loongarch_instruction jirl;
};

static inline struct plt_entry emit_plt_entry(unsigned long val)
{
         union loongarch_instruction *lu12iw, *lu32id, *lu52id, *jirl;

         emit_lu32id(lu12iw, LOONGARCH_GPR_T1, ADDR_IMM(val, LU12IW));
         emit_lu32id(lu32id, LOONGARCH_GPR_T1, ADDR_IMM(val, LU32ID));
         emit_lu52id(lu52id, LOONGARCH_GPR_T1, LOONGARCH_GPR_T1, 
ADDR_IMM(val, LU52ID));
         emit_jirl(jirl, LOONGARCH_GPR_T1, 0, (val & 0xfff) >> 2);

         return (struct plt_entry) { *lu12iw, *lu32id, *lu52id, *jirl };
}

Thanks,
Youling

> +DEF_EMIT_REG1I20_FORMAT(pcaddu18i, pcaddu18i_op)
> +
> +#define DEF_EMIT_REG2_FORMAT(NAME, OP)					\
> +static inline void emit_##NAME(union loongarch_instruction *insn,	\
> +			       enum loongarch_gpr rd,			\
> +			       enum loongarch_gpr rj)			\
> +{									\
> +	insn->reg2_format.opcode = OP;					\
> +	insn->reg2_format.rd = rd;					\
> +	insn->reg2_format.rj = rj;					\
> +}
> +
> +DEF_EMIT_REG2_FORMAT(revb2h, revb2h_op)
> +DEF_EMIT_REG2_FORMAT(revb2w, revb2w_op)
> +DEF_EMIT_REG2_FORMAT(revbd, revbd_op)
> +
> +#define DEF_EMIT_REG2I5_FORMAT(NAME, OP)				\
> +static inline void emit_##NAME(union loongarch_instruction *insn,	\
> +			       enum loongarch_gpr rd,			\
> +			       enum loongarch_gpr rj,			\
> +			       int imm)					\
> +{									\
> +	insn->reg2i5_format.opcode = OP;				\
> +	insn->reg2i5_format.immediate = imm;				\
> +	insn->reg2i5_format.rd = rd;					\
> +	insn->reg2i5_format.rj = rj;					\
> +}
> +
> +DEF_EMIT_REG2I5_FORMAT(slliw, slliw_op)
> +DEF_EMIT_REG2I5_FORMAT(srliw, srliw_op)
> +DEF_EMIT_REG2I5_FORMAT(sraiw, sraiw_op)
> +
> +#define DEF_EMIT_REG2I6_FORMAT(NAME, OP)				\
> +static inline void emit_##NAME(union loongarch_instruction *insn,	\
> +			       enum loongarch_gpr rd,			\
> +			       enum loongarch_gpr rj,			\
> +			       int imm)					\
> +{									\
> +	insn->reg2i6_format.opcode = OP;				\
> +	insn->reg2i6_format.immediate = imm;				\
> +	insn->reg2i6_format.rd = rd;					\
> +	insn->reg2i6_format.rj = rj;					\
> +}
> +
> +DEF_EMIT_REG2I6_FORMAT(sllid, sllid_op)
> +DEF_EMIT_REG2I6_FORMAT(srlid, srlid_op)
> +DEF_EMIT_REG2I6_FORMAT(sraid, sraid_op)
> +
> +#define DEF_EMIT_REG2I12_FORMAT(NAME, OP)				\
> +static inline void emit_##NAME(union loongarch_instruction *insn,	\
> +			       enum loongarch_gpr rd,			\
> +			       enum loongarch_gpr rj,			\
> +			       int imm)					\
> +{									\
> +	insn->reg2i12_format.opcode = OP;				\
> +	insn->reg2i12_format.immediate = imm;				\
> +	insn->reg2i12_format.rd = rd;					\
> +	insn->reg2i12_format.rj = rj;					\
> +}
> +
> +DEF_EMIT_REG2I12_FORMAT(addiw, addiw_op)
> +DEF_EMIT_REG2I12_FORMAT(addid, addid_op)
> +DEF_EMIT_REG2I12_FORMAT(lu52id, lu52id_op)
> +DEF_EMIT_REG2I12_FORMAT(andi, andi_op)
> +DEF_EMIT_REG2I12_FORMAT(ori, ori_op)
> +DEF_EMIT_REG2I12_FORMAT(xori, xori_op)
> +DEF_EMIT_REG2I12_FORMAT(ldbu, ldbu_op)
> +DEF_EMIT_REG2I12_FORMAT(ldhu, ldhu_op)
> +DEF_EMIT_REG2I12_FORMAT(ldwu, ldwu_op)
> +DEF_EMIT_REG2I12_FORMAT(ldd, ldd_op)
> +DEF_EMIT_REG2I12_FORMAT(stb, stb_op)
> +DEF_EMIT_REG2I12_FORMAT(sth, sth_op)
> +DEF_EMIT_REG2I12_FORMAT(stw, stw_op)
> +DEF_EMIT_REG2I12_FORMAT(std, std_op)
> +
> +#define DEF_EMIT_REG2I14_FORMAT(NAME, OP)				\
> +static inline void emit_##NAME(union loongarch_instruction *insn,	\
> +			       enum loongarch_gpr rd,			\
> +			       enum loongarch_gpr rj,			\
> +			       int imm)					\
> +{									\
> +	insn->reg2i14_format.opcode = OP;				\
> +	insn->reg2i14_format.immediate = imm;				\
> +	insn->reg2i14_format.rd = rd;					\
> +	insn->reg2i14_format.rj = rj;					\
> +}
> +
> +DEF_EMIT_REG2I14_FORMAT(llw, llw_op)
> +DEF_EMIT_REG2I14_FORMAT(scw, scw_op)
> +DEF_EMIT_REG2I14_FORMAT(lld, lld_op)
> +DEF_EMIT_REG2I14_FORMAT(scd, scd_op)
> +
> +#define DEF_EMIT_REG2I16_FORMAT(NAME, OP)				\
> +static inline void emit_##NAME(union loongarch_instruction *insn,	\
> +			       enum loongarch_gpr rj,			\
> +			       enum loongarch_gpr rd,			\
> +			       int offset)				\
> +{									\
> +	insn->reg2i16_format.opcode = OP;				\
> +	insn->reg2i16_format.immediate = offset;			\
> +	insn->reg2i16_format.rj = rj;					\
> +	insn->reg2i16_format.rd = rd;					\
> +}
> +
> +DEF_EMIT_REG2I16_FORMAT(beq, beq_op)
> +DEF_EMIT_REG2I16_FORMAT(bne, bne_op)
> +DEF_EMIT_REG2I16_FORMAT(blt, blt_op)
> +DEF_EMIT_REG2I16_FORMAT(bge, bge_op)
> +DEF_EMIT_REG2I16_FORMAT(bltu, bltu_op)
> +DEF_EMIT_REG2I16_FORMAT(bgeu, bgeu_op)
> +DEF_EMIT_REG2I16_FORMAT(jirl, jirl_op)
> +
> +#define DEF_EMIT_REG3_FORMAT(NAME, OP)					\
> +static inline void emit_##NAME(union loongarch_instruction *insn,	\
> +			       enum loongarch_gpr rd,			\
> +			       enum loongarch_gpr rj,			\
> +			       enum loongarch_gpr rk)			\
> +{									\
> +	insn->reg3_format.opcode = OP;					\
> +	insn->reg3_format.rd = rd;					\
> +	insn->reg3_format.rj = rj;					\
> +	insn->reg3_format.rk = rk;					\
> +}
> +
> +DEF_EMIT_REG3_FORMAT(addd, addd_op)
> +DEF_EMIT_REG3_FORMAT(subd, subd_op)
> +DEF_EMIT_REG3_FORMAT(muld, muld_op)
> +DEF_EMIT_REG3_FORMAT(divdu, divdu_op)
> +DEF_EMIT_REG3_FORMAT(moddu, moddu_op)
> +DEF_EMIT_REG3_FORMAT(and, and_op)
> +DEF_EMIT_REG3_FORMAT(or, or_op)
> +DEF_EMIT_REG3_FORMAT(xor, xor_op)
> +DEF_EMIT_REG3_FORMAT(sllw, sllw_op)
> +DEF_EMIT_REG3_FORMAT(slld, slld_op)
> +DEF_EMIT_REG3_FORMAT(srlw, srlw_op)
> +DEF_EMIT_REG3_FORMAT(srld, srld_op)
> +DEF_EMIT_REG3_FORMAT(sraw, sraw_op)
> +DEF_EMIT_REG3_FORMAT(srad, srad_op)
> +DEF_EMIT_REG3_FORMAT(ldxbu, ldxbu_op)
> +DEF_EMIT_REG3_FORMAT(ldxhu, ldxhu_op)
> +DEF_EMIT_REG3_FORMAT(ldxwu, ldxwu_op)
> +DEF_EMIT_REG3_FORMAT(ldxd, ldxd_op)
> +DEF_EMIT_REG3_FORMAT(stxb, stxb_op)
> +DEF_EMIT_REG3_FORMAT(stxh, stxh_op)
> +DEF_EMIT_REG3_FORMAT(stxw, stxw_op)
> +DEF_EMIT_REG3_FORMAT(stxd, stxd_op)
> +DEF_EMIT_REG3_FORMAT(amaddw, amaddw_op)
> +DEF_EMIT_REG3_FORMAT(amaddd, amaddd_op)
> +DEF_EMIT_REG3_FORMAT(amandw, amandw_op)
> +DEF_EMIT_REG3_FORMAT(amandd, amandd_op)
> +DEF_EMIT_REG3_FORMAT(amorw, amorw_op)
> +DEF_EMIT_REG3_FORMAT(amord, amord_op)
> +DEF_EMIT_REG3_FORMAT(amxorw, amxorw_op)
> +DEF_EMIT_REG3_FORMAT(amxord, amxord_op)
> +DEF_EMIT_REG3_FORMAT(amswapw, amswapw_op)
> +DEF_EMIT_REG3_FORMAT(amswapd, amswapd_op)
> +
>  #endif /* _ASM_INST_H */
> diff --git a/arch/loongarch/net/Makefile b/arch/loongarch/net/Makefile
> new file mode 100644
> index 0000000..1ec12a0
> --- /dev/null
> +++ b/arch/loongarch/net/Makefile
> @@ -0,0 +1,7 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +# Makefile for arch/loongarch/net
> +#
> +# Copyright (C) 2022 Loongson Technology Corporation Limited
> +#
> +obj-$(CONFIG_BPF_JIT) += bpf_jit.o
> diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
> new file mode 100644
> index 0000000..2f41b9b
> --- /dev/null
> +++ b/arch/loongarch/net/bpf_jit.c
> @@ -0,0 +1,1113 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * BPF JIT compiler for LoongArch
> + *
> + * Copyright (C) 2022 Loongson Technology Corporation Limited
> + */
> +#include "bpf_jit.h"
> +
> +#define REG_TCC		LOONGARCH_GPR_A6
> +#define TCC_SAVED	LOONGARCH_GPR_S5
> +
> +#define SAVE_RA		BIT(0)
> +#define SAVE_TCC	BIT(1)
> +
> +static const int regmap[] = {
> +	/* return value from in-kernel function, and exit value for eBPF program */
> +	[BPF_REG_0] = LOONGARCH_GPR_A5,
> +	/* arguments from eBPF program to in-kernel function */
> +	[BPF_REG_1] = LOONGARCH_GPR_A0,
> +	[BPF_REG_2] = LOONGARCH_GPR_A1,
> +	[BPF_REG_3] = LOONGARCH_GPR_A2,
> +	[BPF_REG_4] = LOONGARCH_GPR_A3,
> +	[BPF_REG_5] = LOONGARCH_GPR_A4,
> +	/* callee saved registers that in-kernel function will preserve */
> +	[BPF_REG_6] = LOONGARCH_GPR_S0,
> +	[BPF_REG_7] = LOONGARCH_GPR_S1,
> +	[BPF_REG_8] = LOONGARCH_GPR_S2,
> +	[BPF_REG_9] = LOONGARCH_GPR_S3,
> +	/* read-only frame pointer to access stack */
> +	[BPF_REG_FP] = LOONGARCH_GPR_S4,
> +	/* temporary register for blinding constants */
> +	[BPF_REG_AX] = LOONGARCH_GPR_T0,
> +};
> +
> +static void mark_call(struct jit_ctx *ctx)
> +{
> +	ctx->flags |= SAVE_RA;
> +}
> +
> +static void mark_tail_call(struct jit_ctx *ctx)
> +{
> +	ctx->flags |= SAVE_TCC;
> +}
> +
> +static bool seen_call(struct jit_ctx *ctx)
> +{
> +	return (ctx->flags & SAVE_RA);
> +}
> +
> +static bool seen_tail_call(struct jit_ctx *ctx)
> +{
> +	return (ctx->flags & SAVE_TCC);
> +}
> +
> +static u8 tail_call_reg(struct jit_ctx *ctx)
> +{
> +	if (seen_call(ctx))
> +		return TCC_SAVED;
> +
> +	return REG_TCC;
> +}
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
> +static void __build_epilogue(struct jit_ctx *ctx, bool is_tail_call)
> +{
> +	int stack_adjust = ctx->stack_size;
> +	int load_offset;
> +
> +	load_offset = stack_adjust - sizeof(long);
> +	emit_insn(ctx, ldd, LOONGARCH_GPR_RA, LOONGARCH_GPR_SP, load_offset);
> +
> +	load_offset -= sizeof(long);
> +	emit_insn(ctx, ldd, LOONGARCH_GPR_FP, LOONGARCH_GPR_SP, load_offset);
> +
> +	load_offset -= sizeof(long);
> +	emit_insn(ctx, ldd, LOONGARCH_GPR_S0, LOONGARCH_GPR_SP, load_offset);
> +
> +	load_offset -= sizeof(long);
> +	emit_insn(ctx, ldd, LOONGARCH_GPR_S1, LOONGARCH_GPR_SP, load_offset);
> +
> +	load_offset -= sizeof(long);
> +	emit_insn(ctx, ldd, LOONGARCH_GPR_S2, LOONGARCH_GPR_SP, load_offset);
> +
> +	load_offset -= sizeof(long);
> +	emit_insn(ctx, ldd, LOONGARCH_GPR_S3, LOONGARCH_GPR_SP, load_offset);
> +
> +	load_offset -= sizeof(long);
> +	emit_insn(ctx, ldd, LOONGARCH_GPR_S4, LOONGARCH_GPR_SP, load_offset);
> +
> +	load_offset -= sizeof(long);
> +	emit_insn(ctx, ldd, LOONGARCH_GPR_S5, LOONGARCH_GPR_SP, load_offset);
> +
> +	emit_insn(ctx, addid, LOONGARCH_GPR_SP, LOONGARCH_GPR_SP, stack_adjust);
> +
> +	if (!is_tail_call) {
> +		/* Set return value */
> +		move_reg(ctx, LOONGARCH_GPR_A0, regmap[BPF_REG_0]);
> +		/* Return to the caller */
> +		emit_insn(ctx, jirl, LOONGARCH_GPR_RA, LOONGARCH_GPR_ZERO, 0);
> +	} else {
> +		/*
> +		 * Call the next bpf prog and skip the first instruction
> +		 * of TCC initialization.
> +		 */
> +		emit_insn(ctx, jirl, LOONGARCH_GPR_T3, LOONGARCH_GPR_ZERO, 1);
> +	}
> +}
> +
> +void build_epilogue(struct jit_ctx *ctx)
> +{
> +	__build_epilogue(ctx, false);
> +}
> +
> +bool bpf_jit_supports_kfunc_call(void)
> +{
> +	return true;
> +}
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
> +static void emit_atomic(const struct bpf_insn *insn, struct jit_ctx *ctx)
> +{
> +	const u8 dst = regmap[insn->dst_reg];
> +	const u8 src = regmap[insn->src_reg];
> +	const u8 t1 = LOONGARCH_GPR_T1;
> +	const u8 t2 = LOONGARCH_GPR_T2;
> +	const u8 t3 = LOONGARCH_GPR_T3;
> +	const s16 off = insn->off;
> +	const s32 imm = insn->imm;
> +	const bool isdw = BPF_SIZE(insn->code) == BPF_DW;
> +
> +	move_imm32(ctx, t1, off, false);
> +	emit_insn(ctx, addd, t1, dst, t1);
> +	move_reg(ctx, t3, src);
> +
> +	switch (imm) {
> +	/* lock *(size *)(dst + off) <op>= src */
> +	case BPF_ADD:
> +		if (isdw)
> +			emit_insn(ctx, amaddd, t2, t1, src);
> +		else
> +			emit_insn(ctx, amaddw, t2, t1, src);
> +		break;
> +	case BPF_AND:
> +		if (isdw)
> +			emit_insn(ctx, amandd, t2, t1, src);
> +		else
> +			emit_insn(ctx, amandw, t2, t1, src);
> +		break;
> +	case BPF_OR:
> +		if (isdw)
> +			emit_insn(ctx, amord, t2, t1, src);
> +		else
> +			emit_insn(ctx, amorw, t2, t1, src);
> +		break;
> +	case BPF_XOR:
> +		if (isdw)
> +			emit_insn(ctx, amxord, t2, t1, src);
> +		else
> +			emit_insn(ctx, amxorw, t2, t1, src);
> +		break;
> +	/* src = atomic_fetch_<op>(dst + off, src) */
> +	case BPF_ADD | BPF_FETCH:
> +		if (isdw) {
> +			emit_insn(ctx, amaddd, src, t1, t3);
> +		} else {
> +			emit_insn(ctx, amaddw, src, t1, t3);
> +			emit_zext_32(ctx, src, true);
> +		}
> +		break;
> +	case BPF_AND | BPF_FETCH:
> +		if (isdw) {
> +			emit_insn(ctx, amandd, src, t1, t3);
> +		} else {
> +			emit_insn(ctx, amandw, src, t1, t3);
> +			emit_zext_32(ctx, src, true);
> +		}
> +		break;
> +	case BPF_OR | BPF_FETCH:
> +		if (isdw) {
> +			emit_insn(ctx, amord, src, t1, t3);
> +		} else {
> +			emit_insn(ctx, amorw, src, t1, t3);
> +			emit_zext_32(ctx, src, true);
> +		}
> +		break;
> +	case BPF_XOR | BPF_FETCH:
> +		if (isdw) {
> +			emit_insn(ctx, amxord, src, t1, t3);
> +		} else {
> +			emit_insn(ctx, amxorw, src, t1, t3);
> +			emit_zext_32(ctx, src, true);
> +		}
> +		break;
> +	/* src = atomic_xchg(dst + off, src); */
> +	case BPF_XCHG:
> +		if (isdw) {
> +			emit_insn(ctx, amswapd, src, t1, t3);
> +		} else {
> +			emit_insn(ctx, amswapw, src, t1, t3);
> +			emit_zext_32(ctx, src, true);
> +		}
> +		break;
> +	/* r0 = atomic_cmpxchg(dst + off, r0, src); */
> +	case BPF_CMPXCHG:
> +		u8 r0 = regmap[BPF_REG_0];
> +
> +		move_reg(ctx, t2, r0);
> +		if (isdw) {
> +			emit_insn(ctx, lld, r0, t1, 0);
> +			emit_insn(ctx, bne, t2, r0, 4);
> +			move_reg(ctx, t3, src);
> +			emit_insn(ctx, scd, t3, t1, 0);
> +			emit_insn(ctx, beq, t3, LOONGARCH_GPR_ZERO, -4);
> +		} else {
> +			emit_insn(ctx, llw, r0, t1, 0);
> +			emit_zext_32(ctx, t2, true);
> +			emit_zext_32(ctx, r0, true);
> +			emit_insn(ctx, bne, t2, r0, 4);
> +			move_reg(ctx, t3, src);
> +			emit_insn(ctx, scw, t3, t1, 0);
> +			emit_insn(ctx, beq, t3, LOONGARCH_GPR_ZERO, -6);
> +			emit_zext_32(ctx, r0, true);
> +		}
> +		break;
> +	}
> +}
> +
> +static bool is_signed_bpf_cond(u8 cond)
> +{
> +	return cond == BPF_JSGT || cond == BPF_JSLT ||
> +	       cond == BPF_JSGE || cond == BPF_JSLE;
> +}
> +
> +static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool extra_pass)
> +{
> +	const bool is32 = BPF_CLASS(insn->code) == BPF_ALU ||
> +			  BPF_CLASS(insn->code) == BPF_JMP32;
> +	const u8 code = insn->code;
> +	const u8 cond = BPF_OP(code);
> +	const u8 dst = regmap[insn->dst_reg];
> +	const u8 src = regmap[insn->src_reg];
> +	const u8 t1 = LOONGARCH_GPR_T1;
> +	const u8 t2 = LOONGARCH_GPR_T2;
> +	const s16 off = insn->off;
> +	const s32 imm = insn->imm;
> +	int i = insn - ctx->prog->insnsi;
> +	int jmp_offset;
> +
> +	switch (code) {
> +	/* dst = src */
> +	case BPF_ALU | BPF_MOV | BPF_X:
> +	case BPF_ALU64 | BPF_MOV | BPF_X:
> +		move_reg(ctx, dst, src);
> +		emit_zext_32(ctx, dst, is32);
> +		break;
> +	/* dst = imm */
> +	case BPF_ALU | BPF_MOV | BPF_K:
> +	case BPF_ALU64 | BPF_MOV | BPF_K:
> +		move_imm32(ctx, dst, imm, is32);
> +		break;
> +
> +	/* dst = dst + src */
> +	case BPF_ALU | BPF_ADD | BPF_X:
> +	case BPF_ALU64 | BPF_ADD | BPF_X:
> +		emit_insn(ctx, addd, dst, dst, src);
> +		emit_zext_32(ctx, dst, is32);
> +		break;
> +	/* dst = dst + imm */
> +	case BPF_ALU | BPF_ADD | BPF_K:
> +	case BPF_ALU64 | BPF_ADD | BPF_K:
> +		if (is_signed_imm12(imm)) {
> +			emit_insn(ctx, addid, dst, dst, imm);
> +		} else {
> +			move_imm32(ctx, t1, imm, is32);
> +			emit_insn(ctx, addd, dst, dst, t1);
> +		}
> +		emit_zext_32(ctx, dst, is32);
> +		break;
> +
> +	/* dst = dst - src */
> +	case BPF_ALU | BPF_SUB | BPF_X:
> +	case BPF_ALU64 | BPF_SUB | BPF_X:
> +		emit_insn(ctx, subd, dst, dst, src);
> +		emit_zext_32(ctx, dst, is32);
> +		break;
> +	/* dst = dst - imm */
> +	case BPF_ALU | BPF_SUB | BPF_K:
> +	case BPF_ALU64 | BPF_SUB | BPF_K:
> +		if (is_signed_imm12(-imm)) {
> +			emit_insn(ctx, addid, dst, dst, -imm);
> +		} else {
> +			move_imm32(ctx, t1, imm, is32);
> +			emit_insn(ctx, subd, dst, dst, t1);
> +		}
> +		emit_zext_32(ctx, dst, is32);
> +		break;
> +
> +	/* dst = dst * src */
> +	case BPF_ALU | BPF_MUL | BPF_X:
> +	case BPF_ALU64 | BPF_MUL | BPF_X:
> +		emit_insn(ctx, muld, dst, dst, src);
> +		emit_zext_32(ctx, dst, is32);
> +		break;
> +	/* dst = dst * imm */
> +	case BPF_ALU | BPF_MUL | BPF_K:
> +	case BPF_ALU64 | BPF_MUL | BPF_K:
> +		move_imm32(ctx, t1, imm, is32);
> +		emit_insn(ctx, muld, dst, dst, t1);
> +		emit_zext_32(ctx, dst, is32);
> +		break;
> +
> +	/* dst = dst / src */
> +	case BPF_ALU | BPF_DIV | BPF_X:
> +	case BPF_ALU64 | BPF_DIV | BPF_X:
> +		emit_zext_32(ctx, dst, is32);
> +		move_reg(ctx, t1, src);
> +		emit_zext_32(ctx, t1, is32);
> +		emit_insn(ctx, divdu, dst, dst, t1);
> +		emit_zext_32(ctx, dst, is32);
> +		break;
> +	/* dst = dst / imm */
> +	case BPF_ALU | BPF_DIV | BPF_K:
> +	case BPF_ALU64 | BPF_DIV | BPF_K:
> +		move_imm32(ctx, t1, imm, is32);
> +		emit_zext_32(ctx, dst, is32);
> +		emit_insn(ctx, divdu, dst, dst, t1);
> +		emit_zext_32(ctx, dst, is32);
> +		break;
> +
> +	/* dst = dst % src */
> +	case BPF_ALU | BPF_MOD | BPF_X:
> +	case BPF_ALU64 | BPF_MOD | BPF_X:
> +		emit_zext_32(ctx, dst, is32);
> +		move_reg(ctx, t1, src);
> +		emit_zext_32(ctx, t1, is32);
> +		emit_insn(ctx, moddu, dst, dst, t1);
> +		emit_zext_32(ctx, dst, is32);
> +		break;
> +	/* dst = dst % imm */
> +	case BPF_ALU | BPF_MOD | BPF_K:
> +	case BPF_ALU64 | BPF_MOD | BPF_K:
> +		move_imm32(ctx, t1, imm, is32);
> +		emit_zext_32(ctx, dst, is32);
> +		emit_insn(ctx, moddu, dst, dst, t1);
> +		emit_zext_32(ctx, dst, is32);
> +		break;
> +
> +	/* dst = -dst */
> +	case BPF_ALU | BPF_NEG:
> +	case BPF_ALU64 | BPF_NEG:
> +		move_imm32(ctx, t1, imm, is32);
> +		emit_insn(ctx, subd, dst, LOONGARCH_GPR_ZERO, dst);
> +		emit_zext_32(ctx, dst, is32);
> +		break;
> +
> +	/* dst = dst & src */
> +	case BPF_ALU | BPF_AND | BPF_X:
> +	case BPF_ALU64 | BPF_AND | BPF_X:
> +		emit_insn(ctx, and, dst, dst, src);
> +		emit_zext_32(ctx, dst, is32);
> +		break;
> +	/* dst = dst & imm */
> +	case BPF_ALU | BPF_AND | BPF_K:
> +	case BPF_ALU64 | BPF_AND | BPF_K:
> +		if (is_unsigned_imm12(imm)) {
> +			emit_insn(ctx, andi, dst, dst, imm);
> +		} else {
> +			move_imm32(ctx, t1, imm, is32);
> +			emit_insn(ctx, and, dst, dst, t1);
> +		}
> +		emit_zext_32(ctx, dst, is32);
> +		break;
> +
> +	/* dst = dst | src */
> +	case BPF_ALU | BPF_OR | BPF_X:
> +	case BPF_ALU64 | BPF_OR | BPF_X:
> +		emit_insn(ctx, or, dst, dst, src);
> +		emit_zext_32(ctx, dst, is32);
> +		break;
> +	/* dst = dst | imm */
> +	case BPF_ALU | BPF_OR | BPF_K:
> +	case BPF_ALU64 | BPF_OR | BPF_K:
> +		if (is_unsigned_imm12(imm)) {
> +			emit_insn(ctx, ori, dst, dst, imm);
> +		} else {
> +			move_imm32(ctx, t1, imm, is32);
> +			emit_insn(ctx, or, dst, dst, t1);
> +		}
> +		emit_zext_32(ctx, dst, is32);
> +		break;
> +
> +	/* dst = dst ^ src */
> +	case BPF_ALU | BPF_XOR | BPF_X:
> +	case BPF_ALU64 | BPF_XOR | BPF_X:
> +		emit_insn(ctx, xor, dst, dst, src);
> +		emit_zext_32(ctx, dst, is32);
> +		break;
> +	/* dst = dst ^ imm */
> +	case BPF_ALU | BPF_XOR | BPF_K:
> +	case BPF_ALU64 | BPF_XOR | BPF_K:
> +		if (is_unsigned_imm12(imm)) {
> +			emit_insn(ctx, xori, dst, dst, imm);
> +		} else {
> +			move_imm32(ctx, t1, imm, is32);
> +			emit_insn(ctx, xor, dst, dst, t1);
> +		}
> +		emit_zext_32(ctx, dst, is32);
> +		break;
> +
> +	/* dst = dst << src (logical) */
> +	case BPF_ALU | BPF_LSH | BPF_X:
> +		emit_insn(ctx, sllw, dst, dst, src);
> +		emit_zext_32(ctx, dst, is32);
> +		break;
> +	case BPF_ALU64 | BPF_LSH | BPF_X:
> +		emit_insn(ctx, slld, dst, dst, src);
> +		break;
> +	/* dst = dst << imm (logical) */
> +	case BPF_ALU | BPF_LSH | BPF_K:
> +		emit_insn(ctx, slliw, dst, dst, imm);
> +		emit_zext_32(ctx, dst, is32);
> +		break;
> +	case BPF_ALU64 | BPF_LSH | BPF_K:
> +		emit_insn(ctx, sllid, dst, dst, imm);
> +		break;
> +
> +	/* dst = dst >> src (logical) */
> +	case BPF_ALU | BPF_RSH | BPF_X:
> +		emit_insn(ctx, srlw, dst, dst, src);
> +		emit_zext_32(ctx, dst, is32);
> +		break;
> +	case BPF_ALU64 | BPF_RSH | BPF_X:
> +		emit_insn(ctx, srld, dst, dst, src);
> +		break;
> +	/* dst = dst >> imm (logical) */
> +	case BPF_ALU | BPF_RSH | BPF_K:
> +		emit_insn(ctx, srliw, dst, dst, imm);
> +		emit_zext_32(ctx, dst, is32);
> +		break;
> +	case BPF_ALU64 | BPF_RSH | BPF_K:
> +		emit_insn(ctx, srlid, dst, dst, imm);
> +		break;
> +
> +	/* dst = dst >> src (arithmetic) */
> +	case BPF_ALU | BPF_ARSH | BPF_X:
> +		emit_insn(ctx, sraw, dst, dst, src);
> +		emit_zext_32(ctx, dst, is32);
> +		break;
> +	case BPF_ALU64 | BPF_ARSH | BPF_X:
> +		emit_insn(ctx, srad, dst, dst, src);
> +		break;
> +	/* dst = dst >> imm (arithmetic) */
> +	case BPF_ALU | BPF_ARSH | BPF_K:
> +		emit_insn(ctx, sraiw, dst, dst, imm);
> +		emit_zext_32(ctx, dst, is32);
> +		break;
> +	case BPF_ALU64 | BPF_ARSH | BPF_K:
> +		emit_insn(ctx, sraid, dst, dst, imm);
> +		break;
> +
> +	/* dst = BSWAP##imm(dst) */
> +	case BPF_ALU | BPF_END | BPF_FROM_LE:
> +		switch (imm) {
> +		case 16:
> +			/* zero-extend 16 bits into 64 bits */
> +			emit_insn(ctx, sllid, dst, dst, 48);
> +			emit_insn(ctx, srlid, dst, dst, 48);
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
> +static int build_body(struct jit_ctx *ctx, bool extra_pass)
> +{
> +	const struct bpf_prog *prog = ctx->prog;
> +	int i;
> +
> +	for (i = 0; i < prog->len; i++) {
> +		const struct bpf_insn *insn = &prog->insnsi[i];
> +		int ret;
> +
> +		if (ctx->image == NULL)
> +			ctx->offset[i] = ctx->idx;
> +
> +		ret = build_insn(insn, ctx, extra_pass);
> +		if (ret > 0) {
> +			i++;
> +			if (ctx->image == NULL)
> +				ctx->offset[i] = ctx->idx;
> +			continue;
> +		}
> +		if (ret)
> +			return ret;
> +	}
> +
> +	if (ctx->image == NULL)
> +		ctx->offset[i] = ctx->idx;
> +
> +	return 0;
> +}
> +
> +static inline void bpf_flush_icache(void *start, void *end)
> +{
> +	flush_icache_range((unsigned long)start, (unsigned long)end);
> +}
> +
> +/* Fill space with illegal instructions */
> +static void jit_fill_hole(void *area, unsigned int size)
> +{
> +	u32 *ptr;
> +
> +	/* We are guaranteed to have aligned memory */
> +	for (ptr = area; size >= sizeof(u32); size -= sizeof(u32))
> +		*ptr++ = INSN_BREAK;
> +}
> +
> +static int validate_code(struct jit_ctx *ctx)
> +{
> +	int i;
> +	union loongarch_instruction insn;
> +
> +	for (i = 0; i < ctx->idx; i++) {
> +		insn = ctx->image[i];
> +		/* Check INSN_BREAK */
> +		if (insn.word == INSN_BREAK)
> +			return -1;
> +	}
> +
> +	return 0;
> +}
> +
> +struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
> +{
> +	struct bpf_prog *tmp, *orig_prog = prog;
> +	struct bpf_binary_header *header;
> +	struct jit_data *jit_data;
> +	struct jit_ctx ctx;
> +	bool tmp_blinded = false;
> +	bool extra_pass = false;
> +	int image_size;
> +	u8 *image_ptr;
> +
> +	/*
> +	 * If BPF JIT was not enabled then we must fall back to
> +	 * the interpreter.
> +	 */
> +	if (!prog->jit_requested)
> +		return orig_prog;
> +
> +	tmp = bpf_jit_blind_constants(prog);
> +	/*
> +	 * If blinding was requested and we failed during blinding,
> +	 * we must fall back to the interpreter. Otherwise, we save
> +	 * the new JITed code.
> +	 */
> +	if (IS_ERR(tmp))
> +		return orig_prog;
> +	if (tmp != prog) {
> +		tmp_blinded = true;
> +		prog = tmp;
> +	}
> +
> +	jit_data = prog->aux->jit_data;
> +	if (!jit_data) {
> +		jit_data = kzalloc(sizeof(*jit_data), GFP_KERNEL);
> +		if (!jit_data) {
> +			prog = orig_prog;
> +			goto out;
> +		}
> +		prog->aux->jit_data = jit_data;
> +	}
> +	if (jit_data->ctx.offset) {
> +		ctx = jit_data->ctx;
> +		image_ptr = jit_data->image;
> +		header = jit_data->header;
> +		extra_pass = true;
> +		image_size = sizeof(u32) * ctx.idx;
> +		goto skip_init_ctx;
> +	}
> +
> +	memset(&ctx, 0, sizeof(ctx));
> +	ctx.prog = prog;
> +
> +	ctx.offset = kcalloc(prog->len + 1, sizeof(u32), GFP_KERNEL);
> +	if (ctx.offset == NULL) {
> +		prog = orig_prog;
> +		goto out_off;
> +	}
> +
> +	/* 1. Initial fake pass to compute ctx->idx and set ctx->flags */
> +	if (build_body(&ctx, extra_pass)) {
> +		prog = orig_prog;
> +		goto out_off;
> +	}
> +	build_prologue(&ctx);
> +	ctx.epilogue_offset = ctx.idx;
> +	build_epilogue(&ctx);
> +
> +	/* Now we know the actual image size.
> +	 * As each LoongArch instruction is of length 32bit,
> +	 * we are translating number of JITed intructions into
> +	 * the size required to store these JITed code.
> +	 */
> +	image_size = sizeof(u32) * ctx.idx;
> +	/* Now we know the size of the structure to make */
> +	header = bpf_jit_binary_alloc(image_size, &image_ptr,
> +				      sizeof(u32), jit_fill_hole);
> +	if (header == NULL) {
> +		prog = orig_prog;
> +		goto out_off;
> +	}
> +
> +	/* 2. Now, the actual pass to generate final JIT code */
> +	ctx.image = (union loongarch_instruction *)image_ptr;
> +skip_init_ctx:
> +	ctx.idx = 0;
> +
> +	build_prologue(&ctx);
> +	if (build_body(&ctx, extra_pass)) {
> +		bpf_jit_binary_free(header);
> +		prog = orig_prog;
> +		goto out_off;
> +	}
> +	build_epilogue(&ctx);
> +
> +	/* 3. Extra pass to validate JITed code */
> +	if (validate_code(&ctx)) {
> +		bpf_jit_binary_free(header);
> +		prog = orig_prog;
> +		goto out_off;
> +	}
> +
> +	/* And we're done */
> +	if (bpf_jit_enable > 1)
> +		bpf_jit_dump(prog->len, image_size, 2, ctx.image);
> +
> +	/* Update the icache */
> +	bpf_flush_icache(header, ctx.image + ctx.idx);
> +
> +	if (!prog->is_func || extra_pass) {
> +		if (extra_pass && ctx.idx != jit_data->ctx.idx) {
> +			pr_err_once("multi-func JIT bug %d != %d\n",
> +				    ctx.idx, jit_data->ctx.idx);
> +			bpf_jit_binary_free(header);
> +			prog->bpf_func = NULL;
> +			prog->jited = 0;
> +			prog->jited_len = 0;
> +			goto out_off;
> +		}
> +		bpf_jit_binary_lock_ro(header);
> +	} else {
> +		jit_data->ctx = ctx;
> +		jit_data->image = image_ptr;
> +		jit_data->header = header;
> +	}
> +	prog->bpf_func = (void *)ctx.image;
> +	prog->jited = 1;
> +	prog->jited_len = image_size;
> +
> +	if (!prog->is_func || extra_pass) {
> +out_off:
> +		kfree(ctx.offset);
> +		kfree(jit_data);
> +		prog->aux->jit_data = NULL;
> +	}
> +out:
> +	if (tmp_blinded)
> +		bpf_jit_prog_release_other(prog, prog == orig_prog ?
> +					   tmp : orig_prog);
> +
> +	out_offset = -1;
> +	return prog;
> +}
> diff --git a/arch/loongarch/net/bpf_jit.h b/arch/loongarch/net/bpf_jit.h
> new file mode 100644
> index 0000000..9c735f3
> --- /dev/null
> +++ b/arch/loongarch/net/bpf_jit.h
> @@ -0,0 +1,308 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * BPF JIT compiler for LoongArch
> + *
> + * Copyright (C) 2022 Loongson Technology Corporation Limited
> + */
> +#include <linux/bpf.h>
> +#include <linux/filter.h>
> +#include <asm/cacheflush.h>
> +#include <asm/inst.h>
> +
> +struct jit_ctx {
> +	const struct bpf_prog *prog;
> +	unsigned int idx;
> +	unsigned int flags;
> +	unsigned int epilogue_offset;
> +	u32 *offset;
> +	union loongarch_instruction *image;
> +	u32 stack_size;
> +};
> +
> +struct jit_data {
> +	struct bpf_binary_header *header;
> +	u8 *image;
> +	struct jit_ctx ctx;
> +};
> +
> +#define emit_insn(ctx, func, ...)						\
> +do {										\
> +	if (ctx->image != NULL) {						\
> +		union loongarch_instruction *insn = &ctx->image[ctx->idx];	\
> +		emit_##func(insn, ##__VA_ARGS__);				\
> +	}									\
> +	ctx->idx++;								\
> +} while (0)
> +
> +#define is_signed_imm12(val)	signed_imm_check(val, 12)
> +#define is_signed_imm16(val)	signed_imm_check(val, 16)
> +#define is_signed_imm26(val)	signed_imm_check(val, 26)
> +#define is_signed_imm32(val)	signed_imm_check(val, 32)
> +#define is_signed_imm52(val)	signed_imm_check(val, 52)
> +#define is_unsigned_imm12(val)	unsigned_imm_check(val, 12)
> +
> +static inline int bpf2la_offset(int bpf_insn, int off, const struct jit_ctx *ctx)
> +{
> +	/* BPF JMP offset is relative to the next instruction */
> +	bpf_insn++;
> +	/*
> +	 * Whereas loongarch branch instructions encode the offset
> +	 * from the branch itself, so we must subtract 1 from the
> +	 * instruction offset.
> +	 */
> +	return (ctx->offset[bpf_insn + off] - (ctx->offset[bpf_insn] - 1));
> +}
> +
> +static inline int epilogue_offset(const struct jit_ctx *ctx)
> +{
> +	int to = ctx->epilogue_offset;
> +	int from = ctx->idx;
> +
> +	return (to - from);
> +}
> +
> +/* Zero-extend 32 bits into 64 bits */
> +static inline void emit_zext_32(struct jit_ctx *ctx, enum loongarch_gpr reg, bool is32)
> +{
> +	if (!is32)
> +		return;
> +
> +	emit_insn(ctx, lu32id, reg, 0);
> +}
> +
> +/* Signed-extend 32 bits into 64 bits */
> +static inline void emit_sext_32(struct jit_ctx *ctx, enum loongarch_gpr reg, bool is32)
> +{
> +	if (!is32)
> +		return;
> +
> +	emit_insn(ctx, addiw, reg, reg, 0);
> +}
> +
> +static inline void move_imm32(struct jit_ctx *ctx, enum loongarch_gpr rd,
> +			      int imm32, bool is32)
> +{
> +	int si20;
> +	u32 ui12;
> +
> +	/* or rd, $zero, $zero */
> +	if (imm32 == 0) {
> +		emit_insn(ctx, or, rd, LOONGARCH_GPR_ZERO, LOONGARCH_GPR_ZERO);
> +		return;
> +	}
> +
> +	/* addiw rd, $zero, imm_11_0(signed) */
> +	if (is_signed_imm12(imm32)) {
> +		emit_insn(ctx, addiw, rd, LOONGARCH_GPR_ZERO, imm32);
> +		goto zext;
> +	}
> +
> +	/* ori rd, $zero, imm_11_0(unsigned) */
> +	if (is_unsigned_imm12(imm32)) {
> +		emit_insn(ctx, ori, rd, LOONGARCH_GPR_ZERO, imm32);
> +		goto zext;
> +	}
> +
> +	/* lu12iw rd, imm_31_12(signed) */
> +	si20 = (imm32 >> 12) & 0xfffff;
> +	emit_insn(ctx, lu12iw, rd, si20);
> +
> +	/* ori rd, rd, imm_11_0(unsigned) */
> +	ui12 = imm32 & 0xfff;
> +	if (ui12 != 0)
> +		emit_insn(ctx, ori, rd, rd, ui12);
> +
> +zext:
> +	emit_zext_32(ctx, rd, is32);
> +}
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
> +static inline int invert_jmp_cond(u8 cond)
> +{
> +	switch (cond) {
> +	case BPF_JEQ:
> +		return BPF_JNE;
> +	case BPF_JNE:
> +	case BPF_JSET:
> +		return BPF_JEQ;
> +	case BPF_JGT:
> +		return BPF_JLE;
> +	case BPF_JGE:
> +		return BPF_JLT;
> +	case BPF_JLT:
> +		return BPF_JGE;
> +	case BPF_JLE:
> +		return BPF_JGT;
> +	case BPF_JSGT:
> +		return BPF_JSLE;
> +	case BPF_JSGE:
> +		return BPF_JSLT;
> +	case BPF_JSLT:
> +		return BPF_JSGE;
> +	case BPF_JSLE:
> +		return BPF_JSGT;
> +	}
> +	return -1;
> +}
> +
> +static inline void cond_jmp_offs16(struct jit_ctx *ctx, u8 cond, enum loongarch_gpr rj,
> +				   enum loongarch_gpr rd, int jmp_offset)
> +{
> +	switch (cond) {
> +	case BPF_JEQ:
> +		/* PC += jmp_offset if rj == rd */
> +		emit_insn(ctx, beq, rj, rd, jmp_offset);
> +		return;
> +	case BPF_JNE:
> +	case BPF_JSET:
> +		/* PC += jmp_offset if rj != rd */
> +		emit_insn(ctx, bne, rj, rd, jmp_offset);
> +		return;
> +	case BPF_JGT:
> +		/* PC += jmp_offset if rj > rd (unsigned) */
> +		emit_insn(ctx, bltu, rd, rj, jmp_offset);
> +		return;
> +	case BPF_JLT:
> +		/* PC += jmp_offset if rj < rd (unsigned) */
> +		emit_insn(ctx, bltu, rj, rd, jmp_offset);
> +		return;
> +	case BPF_JGE:
> +		/* PC += jmp_offset if rj >= rd (unsigned) */
> +		emit_insn(ctx, bgeu, rj, rd, jmp_offset);
> +		return;
> +	case BPF_JLE:
> +		/* PC += jmp_offset if rj <= rd (unsigned) */
> +		emit_insn(ctx, bgeu, rd, rj, jmp_offset);
> +		return;
> +	case BPF_JSGT:
> +		/* PC += jmp_offset if rj > rd (signed) */
> +		emit_insn(ctx, blt, rd, rj, jmp_offset);
> +		return;
> +	case BPF_JSLT:
> +		/* PC += jmp_offset if rj < rd (signed) */
> +		emit_insn(ctx, blt, rj, rd, jmp_offset);
> +		return;
> +	case BPF_JSGE:
> +		/* PC += jmp_offset if rj >= rd (signed) */
> +		emit_insn(ctx, bge, rj, rd, jmp_offset);
> +		return;
> +	case BPF_JSLE:
> +		/* PC += jmp_offset if rj <= rd (signed) */
> +		emit_insn(ctx, bge, rd, rj, jmp_offset);
> +		return;
> +	}
> +}
> +
> +static inline void cond_jmp_offs26(struct jit_ctx *ctx, u8 cond, enum loongarch_gpr rj,
> +				   enum loongarch_gpr rd, int jmp_offset)
> +{
> +	cond = invert_jmp_cond(cond);
> +	cond_jmp_offs16(ctx, cond, rj, rd, 2);
> +	emit_insn(ctx, b, jmp_offset);
> +}
> +
> +static inline void cond_jmp_offs32(struct jit_ctx *ctx, u8 cond, enum loongarch_gpr rj,
> +				   enum loongarch_gpr rd, int jmp_offset)
> +{
> +	s64 upper, lower;
> +
> +	upper = (jmp_offset + (1 << 15)) >> 16;
> +	lower = jmp_offset & 0xffff;
> +
> +	cond = invert_jmp_cond(cond);
> +	cond_jmp_offs16(ctx, cond, rj, rd, 3);
> +
> +	/*
> +	 * jmp_addr = jmp_offset << 2
> +	 * tmp2 = PC + jmp_addr[31, 18] + 18'b0
> +	 */
> +	emit_insn(ctx, pcaddu18i, LOONGARCH_GPR_T2, upper << 2);
> +
> +	/* jump to (tmp2 + jmp_addr[17, 2] + 2'b0) */
> +	emit_insn(ctx, jirl, LOONGARCH_GPR_T2, LOONGARCH_GPR_ZERO, lower + 1);
> +}
> +
> +static inline void uncond_jmp_offs26(struct jit_ctx *ctx, int jmp_offset)
> +{
> +	emit_insn(ctx, b, jmp_offset);
> +}
> +
> +static inline void uncond_jmp_offs32(struct jit_ctx *ctx, int jmp_offset, bool is_exit)
> +{
> +	s64 upper, lower;
> +
> +	upper = (jmp_offset + (1 << 15)) >> 16;
> +	lower = jmp_offset & 0xffff;
> +
> +	if (is_exit)
> +		lower -= 1;
> +
> +	/*
> +	 * jmp_addr = jmp_offset << 2;
> +	 * tmp1 = PC + jmp_addr[31, 18] + 18'b0
> +	 */
> +	emit_insn(ctx, pcaddu18i, LOONGARCH_GPR_T1, upper << 2);
> +
> +	/* jump to (tmp1 + jmp_addr[17, 2] + 2'b0) */
> +	emit_insn(ctx, jirl, LOONGARCH_GPR_T1, LOONGARCH_GPR_ZERO, lower + 1);
> +}
> +
> +static inline void emit_cond_jmp(struct jit_ctx *ctx, u8 cond, enum loongarch_gpr rj,
> +				 enum loongarch_gpr rd, int jmp_offset)
> +{
> +	cond_jmp_offs26(ctx, cond, rj, rd, jmp_offset);
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
>

