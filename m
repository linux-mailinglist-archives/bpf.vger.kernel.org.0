Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A2D558D22B
	for <lists+bpf@lfdr.de>; Tue,  9 Aug 2022 04:53:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232003AbiHICxU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Aug 2022 22:53:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231713AbiHICxT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Aug 2022 22:53:19 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8B259193C1
        for <bpf@vger.kernel.org>; Mon,  8 Aug 2022 19:53:14 -0700 (PDT)
Received: from linux.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9DxvyMNzPFiwLAKAA--.4926S5;
        Tue, 09 Aug 2022 10:53:05 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, loongarch@lists.linux.dev
Subject: [RFC PATCH 3/5] LoongArch: Add BPF JIT support
Date:   Tue,  9 Aug 2022 10:52:58 +0800
Message-Id: <1660013580-19053-4-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1660013580-19053-1-git-send-email-yangtiezhu@loongson.cn>
References: <1660013580-19053-1-git-send-email-yangtiezhu@loongson.cn>
X-CM-TRANSID: AQAAf9DxvyMNzPFiwLAKAA--.4926S5
X-Coremail-Antispam: 1UD129KBjvAXoWDJFWDtw43GF4rJrW5CF1xXwb_yoW7tFyDKo
        WUZa48Kw1UGr1Uuw43tryYgFyYqF10vrW8G34avrnYkF4rZ3y5WF43Ww43uaySqrs8KFWU
        C3sFvasrAay7Ar4rn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
        AaLaJ3UjIYCTnIWjp_UUUYA7k0a2IF6w4kM7kC6x804xWl14x267AKxVWrJVCq3wAFc2x0
        x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87
        I2jVAFwI0_JrWl82xGYIkIc2x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY
        1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20x
        vEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2
        jsIEc7CjxVAFwI0_Cr1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64
        kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm
        72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc2xSY4AK67AK6r4UMxAIw28Icx
        kI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2Iq
        xVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42
        IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY
        6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aV
        CY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU5K4iUUUUUU==
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

BPF programs are normally handled by a BPF interpreter, add BPF JIT
support for LoongArch to allow the kernel to generate native code
when a program is loaded into the kernel, this will significantly
speed-up processing of BPF programs.

Co-developed-by: Youling Tang <tangyouling@loongson.cn>
Signed-off-by: Youling Tang <tangyouling@loongson.cn>
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 arch/loongarch/Kbuild        |    1 +
 arch/loongarch/Kconfig       |    1 +
 arch/loongarch/net/Makefile  |    7 +
 arch/loongarch/net/bpf_jit.c | 1119 ++++++++++++++++++++++++++++++++++++++++++
 arch/loongarch/net/bpf_jit.h |  946 +++++++++++++++++++++++++++++++++++
 5 files changed, 2074 insertions(+)
 create mode 100644 arch/loongarch/net/Makefile
 create mode 100644 arch/loongarch/net/bpf_jit.c
 create mode 100644 arch/loongarch/net/bpf_jit.h

diff --git a/arch/loongarch/Kbuild b/arch/loongarch/Kbuild
index ab5373d..b01f5cd 100644
--- a/arch/loongarch/Kbuild
+++ b/arch/loongarch/Kbuild
@@ -1,5 +1,6 @@
 obj-y += kernel/
 obj-y += mm/
+obj-y += net/
 obj-y += vdso/
 
 # for cleaning
diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index 1b4d144..77c4d58 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -82,6 +82,7 @@ config LOONGARCH
 	select HAVE_CONTEXT_TRACKING
 	select HAVE_DEBUG_STACKOVERFLOW
 	select HAVE_DMA_CONTIGUOUS
+	select HAVE_EBPF_JIT if 64BIT
 	select HAVE_EXIT_THREAD
 	select HAVE_FAST_GUP
 	select HAVE_GENERIC_VDSO
diff --git a/arch/loongarch/net/Makefile b/arch/loongarch/net/Makefile
new file mode 100644
index 0000000..1ec12a0
--- /dev/null
+++ b/arch/loongarch/net/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Makefile for arch/loongarch/net
+#
+# Copyright (C) 2022 Loongson Technology Corporation Limited
+#
+obj-$(CONFIG_BPF_JIT) += bpf_jit.o
diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
new file mode 100644
index 0000000..3fe9205
--- /dev/null
+++ b/arch/loongarch/net/bpf_jit.c
@@ -0,0 +1,1119 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * BPF JIT compiler for LoongArch
+ *
+ * Copyright (C) 2022 Loongson Technology Corporation Limited
+ */
+#include "bpf_jit.h"
+
+#define REG_TCC		LOONGARCH_GPR_A6
+#define TCC_SAVED	LOONGARCH_GPR_S5
+
+#define SAVE_RA		BIT(0)
+#define SAVE_TCC	BIT(1)
+
+static const int regmap[] = {
+	/* return value from in-kernel function, and exit value for eBPF program */
+	[BPF_REG_0] = LOONGARCH_GPR_A5,
+	/* arguments from eBPF program to in-kernel function */
+	[BPF_REG_1] = LOONGARCH_GPR_A0,
+	[BPF_REG_2] = LOONGARCH_GPR_A1,
+	[BPF_REG_3] = LOONGARCH_GPR_A2,
+	[BPF_REG_4] = LOONGARCH_GPR_A3,
+	[BPF_REG_5] = LOONGARCH_GPR_A4,
+	/* callee saved registers that in-kernel function will preserve */
+	[BPF_REG_6] = LOONGARCH_GPR_S0,
+	[BPF_REG_7] = LOONGARCH_GPR_S1,
+	[BPF_REG_8] = LOONGARCH_GPR_S2,
+	[BPF_REG_9] = LOONGARCH_GPR_S3,
+	/* read-only frame pointer to access stack */
+	[BPF_REG_FP] = LOONGARCH_GPR_S4,
+	/* temporary register for blinding constants */
+	[BPF_REG_AX] = LOONGARCH_GPR_T0,
+};
+
+static void mark_call(struct jit_ctx *ctx)
+{
+	ctx->flags |= SAVE_RA;
+}
+
+static void mark_tail_call(struct jit_ctx *ctx)
+{
+	ctx->flags |= SAVE_TCC;
+}
+
+static bool seen_call(struct jit_ctx *ctx)
+{
+	return (ctx->flags & SAVE_RA);
+}
+
+static bool seen_tail_call(struct jit_ctx *ctx)
+{
+	return (ctx->flags & SAVE_TCC);
+}
+
+static u8 tail_call_reg(struct jit_ctx *ctx)
+{
+	if (seen_call(ctx))
+		return TCC_SAVED;
+
+	return REG_TCC;
+}
+
+/*
+ * eBPF prog stack layout:
+ *
+ *                                        high
+ * original $sp ------------> +-------------------------+ <--LOONGARCH_GPR_FP
+ *                            |           $ra           |
+ *                            +-------------------------+
+ *                            |           $fp           |
+ *                            +-------------------------+
+ *                            |           $s0           |
+ *                            +-------------------------+
+ *                            |           $s1           |
+ *                            +-------------------------+
+ *                            |           $s2           |
+ *                            +-------------------------+
+ *                            |           $s3           |
+ *                            +-------------------------+
+ *                            |           $s4           |
+ *                            +-------------------------+
+ *                            |           $s5           |
+ *                            +-------------------------+ <--BPF_REG_FP
+ *                            |  prog->aux->stack_depth |
+ *                            |        (optional)       |
+ * current $sp -------------> +-------------------------+
+ *                                        low
+ */
+static void build_prologue(struct jit_ctx *ctx)
+{
+	int stack_adjust = 0, store_offset, bpf_stack_adjust;
+
+	bpf_stack_adjust = round_up(ctx->prog->aux->stack_depth, 16);
+
+	stack_adjust += sizeof(long); /* LOONGARCH_GPR_RA */
+	stack_adjust += sizeof(long); /* LOONGARCH_GPR_FP */
+	stack_adjust += sizeof(long); /* LOONGARCH_GPR_S0 */
+	stack_adjust += sizeof(long); /* LOONGARCH_GPR_S1 */
+	stack_adjust += sizeof(long); /* LOONGARCH_GPR_S2 */
+	stack_adjust += sizeof(long); /* LOONGARCH_GPR_S3 */
+	stack_adjust += sizeof(long); /* LOONGARCH_GPR_S4 */
+	stack_adjust += sizeof(long); /* LOONGARCH_GPR_S5 */
+
+	stack_adjust = round_up(stack_adjust, 16);
+	stack_adjust += bpf_stack_adjust;
+
+	/*
+	 * First instruction initializes the tail call count (TCC).
+	 * On tail call we skip this instruction, and the TCC is
+	 * passed in REG_TCC from the caller.
+	 */
+	emit_insn(ctx, addid, REG_TCC, LOONGARCH_GPR_ZERO, MAX_TAIL_CALL_CNT);
+
+	emit_insn(ctx, addid, LOONGARCH_GPR_SP, LOONGARCH_GPR_SP, -stack_adjust);
+
+	store_offset = stack_adjust - sizeof(long);
+	emit_insn(ctx, std, LOONGARCH_GPR_RA, LOONGARCH_GPR_SP, store_offset);
+
+	store_offset -= sizeof(long);
+	emit_insn(ctx, std, LOONGARCH_GPR_FP, LOONGARCH_GPR_SP, store_offset);
+
+	store_offset -= sizeof(long);
+	emit_insn(ctx, std, LOONGARCH_GPR_S0, LOONGARCH_GPR_SP, store_offset);
+
+	store_offset -= sizeof(long);
+	emit_insn(ctx, std, LOONGARCH_GPR_S1, LOONGARCH_GPR_SP, store_offset);
+
+	store_offset -= sizeof(long);
+	emit_insn(ctx, std, LOONGARCH_GPR_S2, LOONGARCH_GPR_SP, store_offset);
+
+	store_offset -= sizeof(long);
+	emit_insn(ctx, std, LOONGARCH_GPR_S3, LOONGARCH_GPR_SP, store_offset);
+
+	store_offset -= sizeof(long);
+	emit_insn(ctx, std, LOONGARCH_GPR_S4, LOONGARCH_GPR_SP, store_offset);
+
+	store_offset -= sizeof(long);
+	emit_insn(ctx, std, LOONGARCH_GPR_S5, LOONGARCH_GPR_SP, store_offset);
+
+	emit_insn(ctx, addid, LOONGARCH_GPR_FP, LOONGARCH_GPR_SP, stack_adjust);
+
+	if (bpf_stack_adjust)
+		emit_insn(ctx, addid, regmap[BPF_REG_FP], LOONGARCH_GPR_SP, bpf_stack_adjust);
+
+	/*
+	 * Program contains calls and tail calls, so REG_TCC need
+	 * to be saved across calls.
+	 */
+	if (seen_tail_call(ctx) && seen_call(ctx))
+		move_reg(ctx, TCC_SAVED, REG_TCC);
+
+	ctx->stack_size = stack_adjust;
+}
+
+static void __build_epilogue(struct jit_ctx *ctx, bool is_tail_call)
+{
+	int stack_adjust = ctx->stack_size;
+	int load_offset;
+
+	load_offset = stack_adjust - sizeof(long);
+	emit_insn(ctx, ldd, LOONGARCH_GPR_RA, LOONGARCH_GPR_SP, load_offset);
+
+	load_offset -= sizeof(long);
+	emit_insn(ctx, ldd, LOONGARCH_GPR_FP, LOONGARCH_GPR_SP, load_offset);
+
+	load_offset -= sizeof(long);
+	emit_insn(ctx, ldd, LOONGARCH_GPR_S0, LOONGARCH_GPR_SP, load_offset);
+
+	load_offset -= sizeof(long);
+	emit_insn(ctx, ldd, LOONGARCH_GPR_S1, LOONGARCH_GPR_SP, load_offset);
+
+	load_offset -= sizeof(long);
+	emit_insn(ctx, ldd, LOONGARCH_GPR_S2, LOONGARCH_GPR_SP, load_offset);
+
+	load_offset -= sizeof(long);
+	emit_insn(ctx, ldd, LOONGARCH_GPR_S3, LOONGARCH_GPR_SP, load_offset);
+
+	load_offset -= sizeof(long);
+	emit_insn(ctx, ldd, LOONGARCH_GPR_S4, LOONGARCH_GPR_SP, load_offset);
+
+	load_offset -= sizeof(long);
+	emit_insn(ctx, ldd, LOONGARCH_GPR_S5, LOONGARCH_GPR_SP, load_offset);
+
+	emit_insn(ctx, addid, LOONGARCH_GPR_SP, LOONGARCH_GPR_SP, stack_adjust);
+
+	if (!is_tail_call) {
+		/* Set return value */
+		move_reg(ctx, LOONGARCH_GPR_A0, regmap[BPF_REG_0]);
+		/* Return to the caller */
+		emit_insn(ctx, jirl, LOONGARCH_GPR_ZERO, LOONGARCH_GPR_RA, 0);
+	} else {
+		/*
+		 * Call the next bpf prog and skip the first instruction
+		 * of TCC initialization.
+		 */
+		emit_insn(ctx, jirl, LOONGARCH_GPR_ZERO, LOONGARCH_GPR_T3, 1);
+	}
+}
+
+void build_epilogue(struct jit_ctx *ctx)
+{
+	__build_epilogue(ctx, false);
+}
+
+bool bpf_jit_supports_kfunc_call(void)
+{
+	return true;
+}
+
+/* initialized on the first pass of build_body() */
+static int out_offset = -1;
+static int emit_bpf_tail_call(struct jit_ctx *ctx)
+{
+	int off;
+	u8 tcc = tail_call_reg(ctx);
+	u8 a1 = LOONGARCH_GPR_A1;
+	u8 a2 = LOONGARCH_GPR_A2;
+	u8 t1 = LOONGARCH_GPR_T1;
+	u8 t2 = LOONGARCH_GPR_T2;
+	u8 t3 = LOONGARCH_GPR_T3;
+	const int idx0 = ctx->idx;
+
+#define cur_offset (ctx->idx - idx0)
+#define jmp_offset (out_offset - (cur_offset))
+
+	/*
+	 * a0: &ctx
+	 * a1: &array
+	 * a2: index
+	 *
+	 * if (index >= array->map.max_entries)
+	 *	 goto out;
+	 */
+	off = offsetof(struct bpf_array, map.max_entries);
+	emit_insn(ctx, ldwu, t1, a1, off);
+	/* bgeu $a2, $t1, jmp_offset */
+	emit_tailcall_jmp(ctx, BPF_JGE, a2, t1, jmp_offset);
+
+	/*
+	 * if (--TCC < 0)
+	 *	 goto out;
+	 */
+	emit_insn(ctx, addid, REG_TCC, tcc, -1);
+	emit_tailcall_jmp(ctx, BPF_JSLT, REG_TCC, LOONGARCH_GPR_ZERO, jmp_offset);
+
+	/*
+	 * prog = array->ptrs[index];
+	 * if (!prog)
+	 *	 goto out;
+	 */
+	emit_insn(ctx, sllid, t2, a2, 3);
+	emit_insn(ctx, addd, t2, t2, a1);
+	off = offsetof(struct bpf_array, ptrs);
+	emit_insn(ctx, ldd, t2, t2, off);
+	/* beq $t2, $zero, jmp_offset */
+	emit_tailcall_jmp(ctx, BPF_JEQ, t2, LOONGARCH_GPR_ZERO, jmp_offset);
+
+	/* goto *(prog->bpf_func + 4); */
+	off = offsetof(struct bpf_prog, bpf_func);
+	emit_insn(ctx, ldd, t3, t2, off);
+	__build_epilogue(ctx, true);
+
+	/* out: */
+	if (out_offset == -1)
+		out_offset = cur_offset;
+	if (cur_offset != out_offset) {
+		pr_err_once("tail_call out_offset = %d, expected %d!\n",
+			    cur_offset, out_offset);
+		return -1;
+	}
+
+	return 0;
+#undef cur_offset
+#undef jmp_offset
+}
+
+static void emit_atomic(const struct bpf_insn *insn, struct jit_ctx *ctx)
+{
+	const u8 dst = regmap[insn->dst_reg];
+	const u8 src = regmap[insn->src_reg];
+	const u8 t1 = LOONGARCH_GPR_T1;
+	const u8 t2 = LOONGARCH_GPR_T2;
+	const u8 t3 = LOONGARCH_GPR_T3;
+	const s16 off = insn->off;
+	const s32 imm = insn->imm;
+	const bool isdw = (BPF_SIZE(insn->code) == BPF_DW);
+
+	move_imm32(ctx, t1, off, false);
+	emit_insn(ctx, addd, t1, dst, t1);
+	move_reg(ctx, t3, src);
+
+	switch (imm) {
+	/* lock *(size *)(dst + off) <op>= src */
+	case BPF_ADD:
+		if (isdw)
+			emit_insn(ctx, amaddd, t2, src, t1);
+		else
+			emit_insn(ctx, amaddw, t2, src, t1);
+		break;
+	case BPF_AND:
+		if (isdw)
+			emit_insn(ctx, amandd, t2, src, t1);
+		else
+			emit_insn(ctx, amandw, t2, src, t1);
+		break;
+	case BPF_OR:
+		if (isdw)
+			emit_insn(ctx, amord, t2, src, t1);
+		else
+			emit_insn(ctx, amorw, t2, src, t1);
+		break;
+	case BPF_XOR:
+		if (isdw)
+			emit_insn(ctx, amxord, t2, src, t1);
+		else
+			emit_insn(ctx, amxorw, t2, src, t1);
+		break;
+	/* src = atomic_fetch_<op>(dst + off, src) */
+	case BPF_ADD | BPF_FETCH:
+		if (isdw) {
+			emit_insn(ctx, amaddd, src, t3, t1);
+		} else {
+			emit_insn(ctx, amaddw, src, t3, t1);
+			emit_zext_32(ctx, src, true);
+		}
+		break;
+	case BPF_AND | BPF_FETCH:
+		if (isdw) {
+			emit_insn(ctx, amandd, src, t3, t1);
+		} else {
+			emit_insn(ctx, amandw, src, t3, t1);
+			emit_zext_32(ctx, src, true);
+		}
+		break;
+	case BPF_OR | BPF_FETCH:
+		if (isdw) {
+			emit_insn(ctx, amord, src, t3, t1);
+		} else {
+			emit_insn(ctx, amorw, src, t3, t1);
+			emit_zext_32(ctx, src, true);
+		}
+		break;
+	case BPF_XOR | BPF_FETCH:
+		if (isdw) {
+			emit_insn(ctx, amxord, src, t3, t1);
+		} else {
+			emit_insn(ctx, amxorw, src, t3, t1);
+			emit_zext_32(ctx, src, true);
+		}
+		break;
+	/* src = atomic_xchg(dst + off, src); */
+	case BPF_XCHG:
+		if (isdw) {
+			emit_insn(ctx, amswapd, src, t3, t1);
+		} else {
+			emit_insn(ctx, amswapw, src, t3, t1);
+			emit_zext_32(ctx, src, true);
+		}
+		break;
+	/* r0 = atomic_cmpxchg(dst + off, r0, src); */
+	case BPF_CMPXCHG:
+		u8 r0 = regmap[BPF_REG_0];
+
+		move_reg(ctx, t2, r0);
+		if (isdw) {
+			emit_insn(ctx, lld, r0, t1, 0);
+			emit_insn(ctx, bne, t2, r0, 4);
+			move_reg(ctx, t3, src);
+			emit_insn(ctx, scd, t3, t1, 0);
+			emit_insn(ctx, beq, t3, LOONGARCH_GPR_ZERO, -4);
+		} else {
+			emit_insn(ctx, llw, r0, t1, 0);
+			emit_zext_32(ctx, t2, true);
+			emit_zext_32(ctx, r0, true);
+			emit_insn(ctx, bne, t2, r0, 4);
+			move_reg(ctx, t3, src);
+			emit_insn(ctx, scw, t3, t1, 0);
+			emit_insn(ctx, beq, t3, LOONGARCH_GPR_ZERO, -6);
+			emit_zext_32(ctx, r0, true);
+		}
+		break;
+	}
+}
+
+static bool is_signed_bpf_cond(u8 cond)
+{
+	return cond == BPF_JSGT || cond == BPF_JSLT ||
+	       cond == BPF_JSGE || cond == BPF_JSLE;
+}
+
+static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool extra_pass)
+{
+	bool is32 = BPF_CLASS(insn->code) == BPF_ALU ||
+		    BPF_CLASS(insn->code) == BPF_JMP32;
+	const u8 code = insn->code;
+	const u8 cond = BPF_OP(code);
+	const u8 dst = regmap[insn->dst_reg];
+	const u8 src = regmap[insn->src_reg];
+	const u8 t1 = LOONGARCH_GPR_T1;
+	const u8 t2 = LOONGARCH_GPR_T2;
+	const s16 off = insn->off;
+	const s32 imm = insn->imm;
+	int i = insn - ctx->prog->insnsi;
+	int jmp_offset;
+
+	switch (code) {
+	/* dst = src */
+	case BPF_ALU | BPF_MOV | BPF_X:
+	case BPF_ALU64 | BPF_MOV | BPF_X:
+		move_reg(ctx, dst, src);
+		emit_zext_32(ctx, dst, is32);
+		break;
+	/* dst = imm */
+	case BPF_ALU | BPF_MOV | BPF_K:
+	case BPF_ALU64 | BPF_MOV | BPF_K:
+		move_imm32(ctx, dst, imm, is32);
+		break;
+
+	/* dst = dst + src */
+	case BPF_ALU | BPF_ADD | BPF_X:
+	case BPF_ALU64 | BPF_ADD | BPF_X:
+		emit_insn(ctx, addd, dst, dst, src);
+		emit_zext_32(ctx, dst, is32);
+		break;
+	/* dst = dst + imm */
+	case BPF_ALU | BPF_ADD | BPF_K:
+	case BPF_ALU64 | BPF_ADD | BPF_K:
+		if (is_signed_imm12(imm)) {
+			emit_insn(ctx, addid, dst, dst, imm);
+		} else {
+			move_imm32(ctx, t1, imm, is32);
+			emit_insn(ctx, addd, dst, dst, t1);
+		}
+		emit_zext_32(ctx, dst, is32);
+		break;
+
+	/* dst = dst - src */
+	case BPF_ALU | BPF_SUB | BPF_X:
+	case BPF_ALU64 | BPF_SUB | BPF_X:
+		emit_insn(ctx, subd, dst, dst, src);
+		emit_zext_32(ctx, dst, is32);
+		break;
+	/* dst = dst - imm */
+	case BPF_ALU | BPF_SUB | BPF_K:
+	case BPF_ALU64 | BPF_SUB | BPF_K:
+		if (is_signed_imm12(-imm)) {
+			emit_insn(ctx, addid, dst, dst, -imm);
+		} else {
+			move_imm32(ctx, t1, imm, is32);
+			emit_insn(ctx, subd, dst, dst, t1);
+		}
+		emit_zext_32(ctx, dst, is32);
+		break;
+
+	/* dst = dst * src */
+	case BPF_ALU | BPF_MUL | BPF_X:
+	case BPF_ALU64 | BPF_MUL | BPF_X:
+		emit_insn(ctx, muld, dst, dst, src);
+		emit_zext_32(ctx, dst, is32);
+		break;
+	/* dst = dst * imm */
+	case BPF_ALU | BPF_MUL | BPF_K:
+	case BPF_ALU64 | BPF_MUL | BPF_K:
+		move_imm32(ctx, t1, imm, is32);
+		emit_insn(ctx, muld, dst, dst, t1);
+		emit_zext_32(ctx, dst, is32);
+		break;
+
+	/* dst = dst / src */
+	case BPF_ALU | BPF_DIV | BPF_X:
+	case BPF_ALU64 | BPF_DIV | BPF_X:
+		emit_zext_32(ctx, dst, is32);
+		move_reg(ctx, t1, src);
+		emit_zext_32(ctx, t1, is32);
+		emit_insn(ctx, divdu, dst, dst, t1);
+		emit_zext_32(ctx, dst, is32);
+		break;
+	/* dst = dst / imm */
+	case BPF_ALU | BPF_DIV | BPF_K:
+	case BPF_ALU64 | BPF_DIV | BPF_K:
+		move_imm32(ctx, t1, imm, is32);
+		emit_zext_32(ctx, dst, is32);
+		emit_insn(ctx, divdu, dst, dst, t1);
+		emit_zext_32(ctx, dst, is32);
+		break;
+
+	/* dst = dst % src */
+	case BPF_ALU | BPF_MOD | BPF_X:
+	case BPF_ALU64 | BPF_MOD | BPF_X:
+		emit_zext_32(ctx, dst, is32);
+		move_reg(ctx, t1, src);
+		emit_zext_32(ctx, t1, is32);
+		emit_insn(ctx, moddu, dst, dst, t1);
+		emit_zext_32(ctx, dst, is32);
+		break;
+	/* dst = dst % imm */
+	case BPF_ALU | BPF_MOD | BPF_K:
+	case BPF_ALU64 | BPF_MOD | BPF_K:
+		move_imm32(ctx, t1, imm, is32);
+		emit_zext_32(ctx, dst, is32);
+		emit_insn(ctx, moddu, dst, dst, t1);
+		emit_zext_32(ctx, dst, is32);
+		break;
+
+	/* dst = -dst */
+	case BPF_ALU | BPF_NEG:
+	case BPF_ALU64 | BPF_NEG:
+		move_imm32(ctx, t1, imm, is32);
+		emit_insn(ctx, subd, dst, LOONGARCH_GPR_ZERO, dst);
+		emit_zext_32(ctx, dst, is32);
+		break;
+
+	/* dst = dst & src */
+	case BPF_ALU | BPF_AND | BPF_X:
+	case BPF_ALU64 | BPF_AND | BPF_X:
+		emit_insn(ctx, and, dst, dst, src);
+		emit_zext_32(ctx, dst, is32);
+		break;
+	/* dst = dst & imm */
+	case BPF_ALU | BPF_AND | BPF_K:
+	case BPF_ALU64 | BPF_AND | BPF_K:
+		if (is_unsigned_imm12(imm)) {
+			emit_insn(ctx, andi, dst, dst, imm);
+		} else {
+			move_imm32(ctx, t1, imm, is32);
+			emit_insn(ctx, and, dst, dst, t1);
+		}
+		emit_zext_32(ctx, dst, is32);
+		break;
+
+	/* dst = dst | src */
+	case BPF_ALU | BPF_OR | BPF_X:
+	case BPF_ALU64 | BPF_OR | BPF_X:
+		emit_insn(ctx, or, dst, dst, src);
+		emit_zext_32(ctx, dst, is32);
+		break;
+	/* dst = dst | imm */
+	case BPF_ALU | BPF_OR | BPF_K:
+	case BPF_ALU64 | BPF_OR | BPF_K:
+		if (is_unsigned_imm12(imm)) {
+			emit_insn(ctx, ori, dst, dst, imm);
+		} else {
+			move_imm32(ctx, t1, imm, is32);
+			emit_insn(ctx, or, dst, dst, t1);
+		}
+		emit_zext_32(ctx, dst, is32);
+		break;
+
+	/* dst = dst ^ src */
+	case BPF_ALU | BPF_XOR | BPF_X:
+	case BPF_ALU64 | BPF_XOR | BPF_X:
+		emit_insn(ctx, xor, dst, dst, src);
+		emit_zext_32(ctx, dst, is32);
+		break;
+	/* dst = dst ^ imm */
+	case BPF_ALU | BPF_XOR | BPF_K:
+	case BPF_ALU64 | BPF_XOR | BPF_K:
+		if (is_unsigned_imm12(imm)) {
+			emit_insn(ctx, xori, dst, dst, imm);
+		} else {
+			move_imm32(ctx, t1, imm, is32);
+			emit_insn(ctx, xor, dst, dst, t1);
+		}
+		emit_zext_32(ctx, dst, is32);
+		break;
+
+	/* dst = dst << src (logical) */
+	case BPF_ALU | BPF_LSH | BPF_X:
+		emit_insn(ctx, sllw, dst, dst, src);
+		emit_zext_32(ctx, dst, is32);
+		break;
+	case BPF_ALU64 | BPF_LSH | BPF_X:
+		emit_insn(ctx, slld, dst, dst, src);
+		break;
+	/* dst = dst << imm (logical) */
+	case BPF_ALU | BPF_LSH | BPF_K:
+		emit_insn(ctx, slliw, dst, dst, imm);
+		emit_zext_32(ctx, dst, is32);
+		break;
+	case BPF_ALU64 | BPF_LSH | BPF_K:
+		emit_insn(ctx, sllid, dst, dst, imm);
+		break;
+
+	/* dst = dst >> src (logical) */
+	case BPF_ALU | BPF_RSH | BPF_X:
+		emit_insn(ctx, srlw, dst, dst, src);
+		emit_zext_32(ctx, dst, is32);
+		break;
+	case BPF_ALU64 | BPF_RSH | BPF_X:
+		emit_insn(ctx, srld, dst, dst, src);
+		break;
+	/* dst = dst >> imm (logical) */
+	case BPF_ALU | BPF_RSH | BPF_K:
+		emit_insn(ctx, srliw, dst, dst, imm);
+		emit_zext_32(ctx, dst, is32);
+		break;
+	case BPF_ALU64 | BPF_RSH | BPF_K:
+		emit_insn(ctx, srlid, dst, dst, imm);
+		break;
+
+	/* dst = dst >> src (arithmetic) */
+	case BPF_ALU | BPF_ARSH | BPF_X:
+		emit_insn(ctx, sraw, dst, dst, src);
+		emit_zext_32(ctx, dst, is32);
+		break;
+	case BPF_ALU64 | BPF_ARSH | BPF_X:
+		emit_insn(ctx, srad, dst, dst, src);
+		break;
+	/* dst = dst >> imm (arithmetic) */
+	case BPF_ALU | BPF_ARSH | BPF_K:
+		emit_insn(ctx, sraiw, dst, dst, imm);
+		emit_zext_32(ctx, dst, is32);
+		break;
+	case BPF_ALU64 | BPF_ARSH | BPF_K:
+		emit_insn(ctx, sraid, dst, dst, imm);
+		break;
+
+	/* dst = BSWAP##imm(dst) */
+	case BPF_ALU | BPF_END | BPF_FROM_LE:
+		switch (imm) {
+		case 16:
+			/* zero-extend 16 bits into 64 bits */
+			emit_insn(ctx, sllid, dst, dst, 48);
+			emit_insn(ctx, srlid, dst, dst, 48);
+			break;
+		case 32:
+			/* zero-extend 32 bits into 64 bits */
+			emit_zext_32(ctx, dst, is32);
+			break;
+		case 64:
+			/* do nothing */
+			break;
+		}
+		break;
+	case BPF_ALU | BPF_END | BPF_FROM_BE:
+		switch (imm) {
+		case 16:
+			emit_insn(ctx, revb2h, dst, dst);
+			/* zero-extend 16 bits into 64 bits */
+			emit_insn(ctx, sllid, dst, dst, 48);
+			emit_insn(ctx, srlid, dst, dst, 48);
+			break;
+		case 32:
+			emit_insn(ctx, revb2w, dst, dst);
+			/* zero-extend 32 bits into 64 bits */
+			emit_zext_32(ctx, dst, is32);
+			break;
+		case 64:
+			emit_insn(ctx, revbd, dst, dst);
+			break;
+		}
+		break;
+
+	/* PC += off if dst cond src */
+	case BPF_JMP | BPF_JEQ | BPF_X:
+	case BPF_JMP | BPF_JNE | BPF_X:
+	case BPF_JMP | BPF_JGT | BPF_X:
+	case BPF_JMP | BPF_JGE | BPF_X:
+	case BPF_JMP | BPF_JLT | BPF_X:
+	case BPF_JMP | BPF_JLE | BPF_X:
+	case BPF_JMP | BPF_JSGT | BPF_X:
+	case BPF_JMP | BPF_JSGE | BPF_X:
+	case BPF_JMP | BPF_JSLT | BPF_X:
+	case BPF_JMP | BPF_JSLE | BPF_X:
+	case BPF_JMP32 | BPF_JEQ | BPF_X:
+	case BPF_JMP32 | BPF_JNE | BPF_X:
+	case BPF_JMP32 | BPF_JGT | BPF_X:
+	case BPF_JMP32 | BPF_JGE | BPF_X:
+	case BPF_JMP32 | BPF_JLT | BPF_X:
+	case BPF_JMP32 | BPF_JLE | BPF_X:
+	case BPF_JMP32 | BPF_JSGT | BPF_X:
+	case BPF_JMP32 | BPF_JSGE | BPF_X:
+	case BPF_JMP32 | BPF_JSLT | BPF_X:
+	case BPF_JMP32 | BPF_JSLE | BPF_X:
+		jmp_offset = bpf2la_offset(i, off, ctx);
+		move_reg(ctx, t1, dst);
+		move_reg(ctx, t2, src);
+		if (is_signed_bpf_cond(BPF_OP(code))) {
+			emit_sext_32(ctx, t1, is32);
+			emit_sext_32(ctx, t2, is32);
+		} else {
+			emit_zext_32(ctx, t1, is32);
+			emit_zext_32(ctx, t2, is32);
+		}
+		emit_cond_jmp(ctx, cond, t1, t2, jmp_offset);
+		break;
+
+	/* PC += off if dst cond imm */
+	case BPF_JMP | BPF_JEQ | BPF_K:
+	case BPF_JMP | BPF_JNE | BPF_K:
+	case BPF_JMP | BPF_JGT | BPF_K:
+	case BPF_JMP | BPF_JGE | BPF_K:
+	case BPF_JMP | BPF_JLT | BPF_K:
+	case BPF_JMP | BPF_JLE | BPF_K:
+	case BPF_JMP | BPF_JSGT | BPF_K:
+	case BPF_JMP | BPF_JSGE | BPF_K:
+	case BPF_JMP | BPF_JSLT | BPF_K:
+	case BPF_JMP | BPF_JSLE | BPF_K:
+	case BPF_JMP32 | BPF_JEQ | BPF_K:
+	case BPF_JMP32 | BPF_JNE | BPF_K:
+	case BPF_JMP32 | BPF_JGT | BPF_K:
+	case BPF_JMP32 | BPF_JGE | BPF_K:
+	case BPF_JMP32 | BPF_JLT | BPF_K:
+	case BPF_JMP32 | BPF_JLE | BPF_K:
+	case BPF_JMP32 | BPF_JSGT | BPF_K:
+	case BPF_JMP32 | BPF_JSGE | BPF_K:
+	case BPF_JMP32 | BPF_JSLT | BPF_K:
+	case BPF_JMP32 | BPF_JSLE | BPF_K:
+		jmp_offset = bpf2la_offset(i, off, ctx);
+		move_imm32(ctx, t1, imm, false);
+		move_reg(ctx, t2, dst);
+		if (is_signed_bpf_cond(BPF_OP(code))) {
+			emit_sext_32(ctx, t1, is32);
+			emit_sext_32(ctx, t2, is32);
+		} else {
+			emit_zext_32(ctx, t1, is32);
+			emit_zext_32(ctx, t2, is32);
+		}
+		emit_cond_jmp(ctx, cond, t2, t1, jmp_offset);
+		break;
+
+	/* PC += off if dst & src */
+	case BPF_JMP | BPF_JSET | BPF_X:
+	case BPF_JMP32 | BPF_JSET | BPF_X:
+		jmp_offset = bpf2la_offset(i, off, ctx);
+		emit_insn(ctx, and, t1, dst, src);
+		emit_zext_32(ctx, t1, is32);
+		emit_cond_jmp(ctx, cond, t1, LOONGARCH_GPR_ZERO, jmp_offset);
+		break;
+	/* PC += off if dst & imm */
+	case BPF_JMP | BPF_JSET | BPF_K:
+	case BPF_JMP32 | BPF_JSET | BPF_K:
+		jmp_offset = bpf2la_offset(i, off, ctx);
+		move_imm32(ctx, t1, imm, is32);
+		emit_insn(ctx, and, t1, dst, t1);
+		emit_zext_32(ctx, t1, is32);
+		emit_cond_jmp(ctx, cond, t1, LOONGARCH_GPR_ZERO, jmp_offset);
+		break;
+
+	/* PC += off */
+	case BPF_JMP | BPF_JA:
+		jmp_offset = bpf2la_offset(i, off, ctx);
+		emit_uncond_jmp(ctx, jmp_offset, is32);
+		break;
+
+	/* function call */
+	case BPF_JMP | BPF_CALL:
+		bool func_addr_fixed;
+		u64 func_addr;
+		int ret;
+
+		mark_call(ctx);
+		ret = bpf_jit_get_func_addr(ctx->prog, insn, extra_pass,
+					    &func_addr, &func_addr_fixed);
+		if (ret < 0)
+			return ret;
+
+		move_imm64(ctx, t1, func_addr, is32);
+		emit_insn(ctx, jirl, LOONGARCH_GPR_RA, t1, 0);
+		move_reg(ctx, regmap[BPF_REG_0], LOONGARCH_GPR_A0);
+		break;
+
+	/* tail call */
+	case BPF_JMP | BPF_TAIL_CALL:
+		mark_tail_call(ctx);
+		if (emit_bpf_tail_call(ctx))
+			return -EINVAL;
+		break;
+
+	/* function return */
+	case BPF_JMP | BPF_EXIT:
+		emit_sext_32(ctx, regmap[BPF_REG_0], true);
+
+		if (i == ctx->prog->len - 1)
+			break;
+
+		jmp_offset = epilogue_offset(ctx);
+		emit_uncond_jmp(ctx, jmp_offset, true);
+		break;
+
+	/* dst = imm64 */
+	case BPF_LD | BPF_IMM | BPF_DW:
+		u64 imm64 = (u64)(insn + 1)->imm << 32 | (u32)insn->imm;
+
+		move_imm64(ctx, dst, imm64, is32);
+		return 1;
+
+	/* dst = *(size *)(src + off) */
+	case BPF_LDX | BPF_MEM | BPF_B:
+	case BPF_LDX | BPF_MEM | BPF_H:
+	case BPF_LDX | BPF_MEM | BPF_W:
+	case BPF_LDX | BPF_MEM | BPF_DW:
+		if (is_signed_imm12(off)) {
+			switch (BPF_SIZE(code)) {
+			case BPF_B:
+				emit_insn(ctx, ldbu, dst, src, off);
+				break;
+			case BPF_H:
+				emit_insn(ctx, ldhu, dst, src, off);
+				break;
+			case BPF_W:
+				emit_insn(ctx, ldwu, dst, src, off);
+				break;
+			case BPF_DW:
+				emit_insn(ctx, ldd, dst, src, off);
+				break;
+			}
+		} else {
+			move_imm32(ctx, t1, off, is32);
+			switch (BPF_SIZE(code)) {
+			case BPF_B:
+				emit_insn(ctx, ldxbu, dst, src, t1);
+				break;
+			case BPF_H:
+				emit_insn(ctx, ldxhu, dst, src, t1);
+				break;
+			case BPF_W:
+				emit_insn(ctx, ldxwu, dst, src, t1);
+				break;
+			case BPF_DW:
+				emit_insn(ctx, ldxd, dst, src, t1);
+				break;
+			}
+		}
+		break;
+
+	/* *(size *)(dst + off) = imm */
+	case BPF_ST | BPF_MEM | BPF_B:
+	case BPF_ST | BPF_MEM | BPF_H:
+	case BPF_ST | BPF_MEM | BPF_W:
+	case BPF_ST | BPF_MEM | BPF_DW:
+		move_imm32(ctx, t1, imm, is32);
+		if (is_signed_imm12(off)) {
+			switch (BPF_SIZE(code)) {
+			case BPF_B:
+				emit_insn(ctx, stb, t1, dst, off);
+				break;
+			case BPF_H:
+				emit_insn(ctx, sth, t1, dst, off);
+				break;
+			case BPF_W:
+				emit_insn(ctx, stw, t1, dst, off);
+				break;
+			case BPF_DW:
+				emit_insn(ctx, std, t1, dst, off);
+				break;
+			}
+		} else {
+			move_imm32(ctx, t2, off, is32);
+			switch (BPF_SIZE(code)) {
+			case BPF_B:
+				emit_insn(ctx, stxb, t1, dst, t2);
+				break;
+			case BPF_H:
+				emit_insn(ctx, stxh, t1, dst, t2);
+				break;
+			case BPF_W:
+				emit_insn(ctx, stxw, t1, dst, t2);
+				break;
+			case BPF_DW:
+				emit_insn(ctx, stxd, t1, dst, t2);
+				break;
+			}
+		}
+		break;
+
+	/* *(size *)(dst + off) = src */
+	case BPF_STX | BPF_MEM | BPF_B:
+	case BPF_STX | BPF_MEM | BPF_H:
+	case BPF_STX | BPF_MEM | BPF_W:
+	case BPF_STX | BPF_MEM | BPF_DW:
+		if (is_signed_imm12(off)) {
+			switch (BPF_SIZE(code)) {
+			case BPF_B:
+				emit_insn(ctx, stb, src, dst, off);
+				break;
+			case BPF_H:
+				emit_insn(ctx, sth, src, dst, off);
+				break;
+			case BPF_W:
+				emit_insn(ctx, stw, src, dst, off);
+				break;
+			case BPF_DW:
+				emit_insn(ctx, std, src, dst, off);
+				break;
+			}
+		} else {
+			move_imm32(ctx, t1, off, is32);
+			switch (BPF_SIZE(code)) {
+			case BPF_B:
+				emit_insn(ctx, stxb, src, dst, t1);
+				break;
+			case BPF_H:
+				emit_insn(ctx, stxh, src, dst, t1);
+				break;
+			case BPF_W:
+				emit_insn(ctx, stxw, src, dst, t1);
+				break;
+			case BPF_DW:
+				emit_insn(ctx, stxd, src, dst, t1);
+				break;
+			}
+		}
+		break;
+
+	case BPF_STX | BPF_ATOMIC | BPF_W:
+	case BPF_STX | BPF_ATOMIC | BPF_DW:
+		emit_atomic(insn, ctx);
+		break;
+
+	default:
+		pr_err("bpf_jit: unknown opcode %02x\n", code);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int build_body(struct jit_ctx *ctx, bool extra_pass)
+{
+	const struct bpf_prog *prog = ctx->prog;
+	int i;
+
+	for (i = 0; i < prog->len; i++) {
+		const struct bpf_insn *insn = &prog->insnsi[i];
+		int ret;
+
+		if (ctx->image == NULL)
+			ctx->offset[i] = ctx->idx;
+
+		ret = build_insn(insn, ctx, extra_pass);
+		if (ret > 0) {
+			i++;
+			if (ctx->image == NULL)
+				ctx->offset[i] = ctx->idx;
+			continue;
+		}
+		if (ret)
+			return ret;
+	}
+
+	if (ctx->image == NULL)
+		ctx->offset[i] = ctx->idx;
+
+	return 0;
+}
+
+static inline void bpf_flush_icache(void *start, void *end)
+{
+	flush_icache_range((unsigned long)start, (unsigned long)end);
+}
+
+/* Fill space with illegal instructions */
+static void jit_fill_hole(void *area, unsigned int size)
+{
+	u32 *ptr;
+
+	/* We are guaranteed to have aligned memory */
+	for (ptr = area; size >= sizeof(u32); size -= sizeof(u32))
+		*ptr++ = INSN_BREAK;
+}
+
+static int validate_code(struct jit_ctx *ctx)
+{
+	int i;
+	union loongarch_instruction insn;
+
+	for (i = 0; i < ctx->idx; i++) {
+		insn = ctx->image[i];
+		/* Check INSN_BREAK */
+		if (insn.word == INSN_BREAK)
+			return -1;
+	}
+
+	return 0;
+}
+
+struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
+{
+	struct bpf_prog *tmp, *orig_prog = prog;
+	struct bpf_binary_header *header;
+	struct jit_data *jit_data;
+	struct jit_ctx ctx;
+	bool tmp_blinded = false;
+	bool extra_pass = false;
+	int image_size;
+	u8 *image_ptr;
+
+	/*
+	 * If BPF JIT was not enabled then we must fall back to
+	 * the interpreter.
+	 */
+	if (!prog->jit_requested)
+		return orig_prog;
+
+	tmp = bpf_jit_blind_constants(prog);
+	/*
+	 * If blinding was requested and we failed during blinding,
+	 * we must fall back to the interpreter. Otherwise, we save
+	 * the new JITed code.
+	 */
+	if (IS_ERR(tmp))
+		return orig_prog;
+	if (tmp != prog) {
+		tmp_blinded = true;
+		prog = tmp;
+	}
+
+	jit_data = prog->aux->jit_data;
+	if (!jit_data) {
+		jit_data = kzalloc(sizeof(*jit_data), GFP_KERNEL);
+		if (!jit_data) {
+			prog = orig_prog;
+			goto out;
+		}
+		prog->aux->jit_data = jit_data;
+	}
+	if (jit_data->ctx.offset) {
+		ctx = jit_data->ctx;
+		image_ptr = jit_data->image;
+		header = jit_data->header;
+		extra_pass = true;
+		image_size = sizeof(u32) * ctx.idx;
+		goto skip_init_ctx;
+	}
+
+	memset(&ctx, 0, sizeof(ctx));
+	ctx.prog = prog;
+
+	ctx.offset = kcalloc(prog->len + 1, sizeof(u32), GFP_KERNEL);
+	if (ctx.offset == NULL) {
+		prog = orig_prog;
+		goto out_off;
+	}
+
+	/* 1. Initial fake pass to compute ctx->idx and set ctx->flags */
+	if (build_body(&ctx, extra_pass)) {
+		prog = orig_prog;
+		goto out_off;
+	}
+	build_prologue(&ctx);
+	ctx.epilogue_offset = ctx.idx;
+	build_epilogue(&ctx);
+
+	/* Now we know the actual image size.
+	 * As each LoongArch instruction is of length 32bit,
+	 * we are translating number of JITed intructions into
+	 * the size required to store these JITed code.
+	 */
+	image_size = sizeof(u32) * ctx.idx;
+	/* Now we know the size of the structure to make */
+	header = bpf_jit_binary_alloc(image_size, &image_ptr,
+				      sizeof(u32), jit_fill_hole);
+	if (header == NULL) {
+		prog = orig_prog;
+		goto out_off;
+	}
+
+	/* 2. Now, the actual pass to generate final JIT code */
+	ctx.image = (union loongarch_instruction *)image_ptr;
+skip_init_ctx:
+	ctx.idx = 0;
+
+	build_prologue(&ctx);
+	if (build_body(&ctx, extra_pass)) {
+		bpf_jit_binary_free(header);
+		prog = orig_prog;
+		goto out_off;
+	}
+	build_epilogue(&ctx);
+
+	/* 3. Extra pass to validate JITed code */
+	if (validate_code(&ctx)) {
+		bpf_jit_binary_free(header);
+		prog = orig_prog;
+		goto out_off;
+	}
+
+	/* And we're done */
+	if (bpf_jit_enable > 1)
+		bpf_jit_dump(prog->len, image_size, 2, ctx.image);
+
+	/* Update the icache */
+	bpf_flush_icache(header, ctx.image + ctx.idx);
+
+	if (!prog->is_func || extra_pass) {
+		if (extra_pass && ctx.idx != jit_data->ctx.idx) {
+			pr_err_once("multi-func JIT bug %d != %d\n",
+				    ctx.idx, jit_data->ctx.idx);
+			bpf_jit_binary_free(header);
+			prog->bpf_func = NULL;
+			prog->jited = 0;
+			prog->jited_len = 0;
+			goto out_off;
+		}
+		bpf_jit_binary_lock_ro(header);
+	} else {
+		jit_data->ctx = ctx;
+		jit_data->image = image_ptr;
+		jit_data->header = header;
+	}
+	prog->bpf_func = (void *)ctx.image;
+	prog->jited = 1;
+	prog->jited_len = image_size;
+
+	if (!prog->is_func || extra_pass) {
+out_off:
+		kfree(ctx.offset);
+		kfree(jit_data);
+		prog->aux->jit_data = NULL;
+	}
+out:
+	if (tmp_blinded)
+		bpf_jit_prog_release_other(prog, prog == orig_prog ?
+					   tmp : orig_prog);
+
+	out_offset = -1;
+	return prog;
+}
diff --git a/arch/loongarch/net/bpf_jit.h b/arch/loongarch/net/bpf_jit.h
new file mode 100644
index 0000000..86f3036
--- /dev/null
+++ b/arch/loongarch/net/bpf_jit.h
@@ -0,0 +1,946 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * BPF JIT compiler for LoongArch
+ *
+ * Copyright (C) 2022 Loongson Technology Corporation Limited
+ */
+#include <linux/bpf.h>
+#include <linux/filter.h>
+#include <asm/cacheflush.h>
+#include <asm/inst.h>
+
+struct jit_ctx {
+	const struct bpf_prog *prog;
+	unsigned int idx;
+	unsigned int flags;
+	unsigned int epilogue_offset;
+	u32 *offset;
+	union loongarch_instruction *image;
+	u32 stack_size;
+};
+
+struct jit_data {
+	struct bpf_binary_header *header;
+	u8 *image;
+	struct jit_ctx ctx;
+};
+
+#define emit_insn(ctx, func, ...)						\
+do {										\
+	if (ctx->image != NULL) {						\
+		union loongarch_instruction *insn = &ctx->image[ctx->idx];	\
+		emit_##func(insn, ##__VA_ARGS__);				\
+	}									\
+	ctx->idx++;								\
+} while (0)
+
+static inline bool is_unsigned_imm(unsigned long val, unsigned int bit)
+{
+	return val >= 0 && val < (1UL << bit);
+}
+
+static inline bool is_signed_imm(long val, unsigned int bit)
+{
+	return -(1L << (bit - 1)) <= val && val < (1L << (bit - 1));
+}
+
+#define is_signed_imm12(val) is_signed_imm(val, 12)
+#define is_signed_imm16(val) is_signed_imm(val, 16)
+#define is_signed_imm26(val) is_signed_imm(val, 26)
+#define is_signed_imm32(val) is_signed_imm(val, 32)
+#define is_signed_imm52(val) is_signed_imm(val, 52)
+#define is_unsigned_imm12(val) is_unsigned_imm(val, 12)
+
+static inline int bpf2la_offset(int bpf_insn, int off, const struct jit_ctx *ctx)
+{
+	/* BPF JMP offset is relative to the next instruction */
+	bpf_insn++;
+	/*
+	 * Whereas la64 branch instructions encode the offset
+	 * from the branch itself, so we must subtract 1 from the
+	 * instruction offset.
+	 */
+	return (ctx->offset[bpf_insn + off] - (ctx->offset[bpf_insn] - 1));
+}
+
+static inline int epilogue_offset(const struct jit_ctx *ctx)
+{
+	int to = ctx->epilogue_offset;
+	int from = ctx->idx;
+
+	return (to - from);
+}
+
+static inline void emit_ldbu(union loongarch_instruction *insn,
+			     enum loongarch_gpr rd, enum loongarch_gpr rj, int imm)
+{
+	insn->reg2i12_format.opcode = ldbu_op;
+	insn->reg2i12_format.immediate = imm;
+	insn->reg2i12_format.rd = rd;
+	insn->reg2i12_format.rj = rj;
+}
+
+static inline void emit_ldhu(union loongarch_instruction *insn,
+			     enum loongarch_gpr rd, enum loongarch_gpr rj, int imm)
+{
+	insn->reg2i12_format.opcode = ldhu_op;
+	insn->reg2i12_format.immediate = imm;
+	insn->reg2i12_format.rd = rd;
+	insn->reg2i12_format.rj = rj;
+}
+
+static inline void emit_ldwu(union loongarch_instruction *insn,
+			     enum loongarch_gpr rd, enum loongarch_gpr rj, int imm)
+{
+	insn->reg2i12_format.opcode = ldwu_op;
+	insn->reg2i12_format.immediate = imm;
+	insn->reg2i12_format.rd = rd;
+	insn->reg2i12_format.rj = rj;
+}
+
+static inline void emit_ldd(union loongarch_instruction *insn,
+			    enum loongarch_gpr rd, enum loongarch_gpr rj, int imm)
+{
+	insn->reg2i12_format.opcode = ldd_op;
+	insn->reg2i12_format.immediate = imm;
+	insn->reg2i12_format.rd = rd;
+	insn->reg2i12_format.rj = rj;
+}
+
+static inline void emit_stb(union loongarch_instruction *insn,
+			    enum loongarch_gpr rd, enum loongarch_gpr rj, int imm)
+{
+	insn->reg2i12_format.opcode = stb_op;
+	insn->reg2i12_format.immediate = imm;
+	insn->reg2i12_format.rd = rd;
+	insn->reg2i12_format.rj = rj;
+}
+
+static inline void emit_sth(union loongarch_instruction *insn,
+			    enum loongarch_gpr rd, enum loongarch_gpr rj, int imm)
+{
+	insn->reg2i12_format.opcode = sth_op;
+	insn->reg2i12_format.immediate = imm;
+	insn->reg2i12_format.rd = rd;
+	insn->reg2i12_format.rj = rj;
+}
+
+static inline void emit_stw(union loongarch_instruction *insn,
+			    enum loongarch_gpr rd, enum loongarch_gpr rj, int imm)
+{
+	insn->reg2i12_format.opcode = stw_op;
+	insn->reg2i12_format.immediate = imm;
+	insn->reg2i12_format.rd = rd;
+	insn->reg2i12_format.rj = rj;
+}
+
+static inline void emit_std(union loongarch_instruction *insn,
+			    enum loongarch_gpr rd, enum loongarch_gpr rj, int imm)
+{
+	insn->reg2i12_format.opcode = std_op;
+	insn->reg2i12_format.immediate = imm;
+	insn->reg2i12_format.rd = rd;
+	insn->reg2i12_format.rj = rj;
+}
+
+static inline void emit_llw(union loongarch_instruction *insn,
+			    enum loongarch_gpr rd, enum loongarch_gpr rj, int imm)
+{
+	insn->reg2i14_format.opcode = llw_op;
+	insn->reg2i14_format.immediate = imm;
+	insn->reg2i14_format.rd = rd;
+	insn->reg2i14_format.rj = rj;
+}
+
+static inline void emit_lld(union loongarch_instruction *insn,
+			    enum loongarch_gpr rd, enum loongarch_gpr rj, int imm)
+{
+	insn->reg2i14_format.opcode = lld_op;
+	insn->reg2i14_format.immediate = imm;
+	insn->reg2i14_format.rd = rd;
+	insn->reg2i14_format.rj = rj;
+}
+
+static inline void emit_scw(union loongarch_instruction *insn,
+			    enum loongarch_gpr rd, enum loongarch_gpr rj, int imm)
+{
+	insn->reg2i14_format.opcode = scw_op;
+	insn->reg2i14_format.immediate = imm;
+	insn->reg2i14_format.rd = rd;
+	insn->reg2i14_format.rj = rj;
+}
+
+static inline void emit_scd(union loongarch_instruction *insn,
+			    enum loongarch_gpr rd, enum loongarch_gpr rj, int imm)
+{
+	insn->reg2i14_format.opcode = scd_op;
+	insn->reg2i14_format.immediate = imm;
+	insn->reg2i14_format.rd = rd;
+	insn->reg2i14_format.rj = rj;
+}
+
+static inline void emit_ldxbu(union loongarch_instruction *insn, enum loongarch_gpr rd,
+			      enum loongarch_gpr rj, enum loongarch_gpr rk)
+{
+	insn->reg3_format.opcode = ldxbu_op;
+	insn->reg3_format.rd = rd;
+	insn->reg3_format.rj = rj;
+	insn->reg3_format.rk = rk;
+}
+
+static inline void emit_ldxhu(union loongarch_instruction *insn, enum loongarch_gpr rd,
+			      enum loongarch_gpr rj, enum loongarch_gpr rk)
+{
+	insn->reg3_format.opcode = ldxhu_op;
+	insn->reg3_format.rd = rd;
+	insn->reg3_format.rj = rj;
+	insn->reg3_format.rk = rk;
+}
+
+static inline void emit_ldxwu(union loongarch_instruction *insn, enum loongarch_gpr rd,
+			      enum loongarch_gpr rj, enum loongarch_gpr rk)
+{
+	insn->reg3_format.opcode = ldxwu_op;
+	insn->reg3_format.rd = rd;
+	insn->reg3_format.rj = rj;
+	insn->reg3_format.rk = rk;
+}
+
+static inline void emit_ldxd(union loongarch_instruction *insn, enum loongarch_gpr rd,
+			     enum loongarch_gpr rj, enum loongarch_gpr rk)
+{
+	insn->reg3_format.opcode = ldxd_op;
+	insn->reg3_format.rd = rd;
+	insn->reg3_format.rj = rj;
+	insn->reg3_format.rk = rk;
+}
+
+static inline void emit_stxb(union loongarch_instruction *insn, enum loongarch_gpr rd,
+			     enum loongarch_gpr rj, enum loongarch_gpr rk)
+{
+	insn->reg3_format.opcode = stxb_op;
+	insn->reg3_format.rd = rd;
+	insn->reg3_format.rj = rj;
+	insn->reg3_format.rk = rk;
+}
+
+static inline void emit_stxh(union loongarch_instruction *insn, enum loongarch_gpr rd,
+			     enum loongarch_gpr rj, enum loongarch_gpr rk)
+{
+	insn->reg3_format.opcode = stxh_op;
+	insn->reg3_format.rd = rd;
+	insn->reg3_format.rj = rj;
+	insn->reg3_format.rk = rk;
+}
+
+static inline void emit_stxw(union loongarch_instruction *insn, enum loongarch_gpr rd,
+			     enum loongarch_gpr rj, enum loongarch_gpr rk)
+{
+	insn->reg3_format.opcode = stxw_op;
+	insn->reg3_format.rd = rd;
+	insn->reg3_format.rj = rj;
+	insn->reg3_format.rk = rk;
+}
+
+static inline void emit_stxd(union loongarch_instruction *insn, enum loongarch_gpr rd,
+			     enum loongarch_gpr rj, enum loongarch_gpr rk)
+{
+	insn->reg3_format.opcode = stxd_op;
+	insn->reg3_format.rd = rd;
+	insn->reg3_format.rj = rj;
+	insn->reg3_format.rk = rk;
+}
+
+static inline void emit_amaddw(union loongarch_instruction *insn, enum loongarch_gpr rd,
+			       enum loongarch_gpr rk, enum loongarch_gpr rj)
+{
+	insn->reg3_format.opcode = amaddw_op;
+	insn->reg3_format.rd = rd;
+	insn->reg3_format.rk = rk;
+	insn->reg3_format.rj = rj;
+}
+
+static inline void emit_amaddd(union loongarch_instruction *insn, enum loongarch_gpr rd,
+			       enum loongarch_gpr rk, enum loongarch_gpr rj)
+{
+	insn->reg3_format.opcode = amaddd_op;
+	insn->reg3_format.rd = rd;
+	insn->reg3_format.rk = rk;
+	insn->reg3_format.rj = rj;
+}
+
+static inline void emit_amandw(union loongarch_instruction *insn, enum loongarch_gpr rd,
+			       enum loongarch_gpr rk, enum loongarch_gpr rj)
+{
+	insn->reg3_format.opcode = amandw_op;
+	insn->reg3_format.rd = rd;
+	insn->reg3_format.rk = rk;
+	insn->reg3_format.rj = rj;
+}
+
+static inline void emit_amandd(union loongarch_instruction *insn, enum loongarch_gpr rd,
+			       enum loongarch_gpr rk, enum loongarch_gpr rj)
+{
+	insn->reg3_format.opcode = amandd_op;
+	insn->reg3_format.rd = rd;
+	insn->reg3_format.rk = rk;
+	insn->reg3_format.rj = rj;
+}
+
+static inline void emit_amorw(union loongarch_instruction *insn, enum loongarch_gpr rd,
+			      enum loongarch_gpr rk, enum loongarch_gpr rj)
+{
+	insn->reg3_format.opcode = amorw_op;
+	insn->reg3_format.rd = rd;
+	insn->reg3_format.rk = rk;
+	insn->reg3_format.rj = rj;
+}
+
+static inline void emit_amord(union loongarch_instruction *insn, enum loongarch_gpr rd,
+			      enum loongarch_gpr rk, enum loongarch_gpr rj)
+{
+	insn->reg3_format.opcode = amord_op;
+	insn->reg3_format.rd = rd;
+	insn->reg3_format.rk = rk;
+	insn->reg3_format.rj = rj;
+}
+
+static inline void emit_amxorw(union loongarch_instruction *insn, enum loongarch_gpr rd,
+			       enum loongarch_gpr rk, enum loongarch_gpr rj)
+{
+	insn->reg3_format.opcode = amxorw_op;
+	insn->reg3_format.rd = rd;
+	insn->reg3_format.rk = rk;
+	insn->reg3_format.rj = rj;
+}
+
+static inline void emit_amxord(union loongarch_instruction *insn, enum loongarch_gpr rd,
+			       enum loongarch_gpr rk, enum loongarch_gpr rj)
+{
+	insn->reg3_format.opcode = amxord_op;
+	insn->reg3_format.rd = rd;
+	insn->reg3_format.rk = rk;
+	insn->reg3_format.rj = rj;
+}
+
+static inline void emit_amswapw(union loongarch_instruction *insn, enum loongarch_gpr rd,
+				enum loongarch_gpr rk, enum loongarch_gpr rj)
+{
+	insn->reg3_format.opcode = amswapw_op;
+	insn->reg3_format.rd = rd;
+	insn->reg3_format.rk = rk;
+	insn->reg3_format.rj = rj;
+}
+
+static inline void emit_amswapd(union loongarch_instruction *insn, enum loongarch_gpr rd,
+				enum loongarch_gpr rk, enum loongarch_gpr rj)
+{
+	insn->reg3_format.opcode = amswapd_op;
+	insn->reg3_format.rd = rd;
+	insn->reg3_format.rk = rk;
+	insn->reg3_format.rj = rj;
+}
+
+static inline void emit_addd(union loongarch_instruction *insn, enum loongarch_gpr rd,
+			     enum loongarch_gpr rj, enum loongarch_gpr rk)
+{
+	insn->reg3_format.opcode = addd_op;
+	insn->reg3_format.rd = rd;
+	insn->reg3_format.rj = rj;
+	insn->reg3_format.rk = rk;
+}
+
+static inline void emit_addiw(union loongarch_instruction *insn,
+			      enum loongarch_gpr rd, enum loongarch_gpr rj, int imm)
+{
+	insn->reg2i12_format.opcode = addiw_op;
+	insn->reg2i12_format.immediate = imm;
+	insn->reg2i12_format.rd = rd;
+	insn->reg2i12_format.rj = rj;
+}
+
+static inline void emit_addid(union loongarch_instruction *insn,
+			      enum loongarch_gpr rd, enum loongarch_gpr rj, int imm)
+{
+	insn->reg2i12_format.opcode = addid_op;
+	insn->reg2i12_format.immediate = imm;
+	insn->reg2i12_format.rd = rd;
+	insn->reg2i12_format.rj = rj;
+}
+
+static inline void emit_subd(union loongarch_instruction *insn, enum loongarch_gpr rd,
+			     enum loongarch_gpr rj, enum loongarch_gpr rk)
+{
+	insn->reg3_format.opcode = subd_op;
+	insn->reg3_format.rd = rd;
+	insn->reg3_format.rj = rj;
+	insn->reg3_format.rk = rk;
+}
+
+static inline void emit_muld(union loongarch_instruction *insn, enum loongarch_gpr rd,
+			     enum loongarch_gpr rj, enum loongarch_gpr rk)
+{
+	insn->reg3_format.opcode = muld_op;
+	insn->reg3_format.rd = rd;
+	insn->reg3_format.rj = rj;
+	insn->reg3_format.rk = rk;
+}
+
+static inline void emit_divdu(union loongarch_instruction *insn, enum loongarch_gpr rd,
+			      enum loongarch_gpr rj, enum loongarch_gpr rk)
+{
+	insn->reg3_format.opcode = divdu_op;
+	insn->reg3_format.rd = rd;
+	insn->reg3_format.rj = rj;
+	insn->reg3_format.rk = rk;
+}
+
+static inline void emit_moddu(union loongarch_instruction *insn, enum loongarch_gpr rd,
+			      enum loongarch_gpr rj, enum loongarch_gpr rk)
+{
+	insn->reg3_format.opcode = moddu_op;
+	insn->reg3_format.rd = rd;
+	insn->reg3_format.rj = rj;
+	insn->reg3_format.rk = rk;
+}
+
+static inline void emit_and(union loongarch_instruction *insn, enum loongarch_gpr rd,
+			    enum loongarch_gpr rj, enum loongarch_gpr rk)
+{
+	insn->reg3_format.opcode = and_op;
+	insn->reg3_format.rd = rd;
+	insn->reg3_format.rj = rj;
+	insn->reg3_format.rk = rk;
+}
+
+static inline void emit_andi(union loongarch_instruction *insn,
+			     enum loongarch_gpr rd, enum loongarch_gpr rj, u32 imm)
+{
+	insn->reg2ui12_format.opcode = andi_op;
+	insn->reg2ui12_format.immediate = imm;
+	insn->reg2ui12_format.rd = rd;
+	insn->reg2ui12_format.rj = rj;
+}
+
+static inline void emit_or(union loongarch_instruction *insn, enum loongarch_gpr rd,
+			   enum loongarch_gpr rj, enum loongarch_gpr rk)
+{
+	insn->reg3_format.opcode = or_op;
+	insn->reg3_format.rd = rd;
+	insn->reg3_format.rj = rj;
+	insn->reg3_format.rk = rk;
+}
+
+static inline void emit_ori(union loongarch_instruction *insn,
+			    enum loongarch_gpr rd, enum loongarch_gpr rj, u32 imm)
+{
+	insn->reg2ui12_format.opcode = ori_op;
+	insn->reg2ui12_format.immediate = imm;
+	insn->reg2ui12_format.rd = rd;
+	insn->reg2ui12_format.rj = rj;
+}
+
+static inline void emit_xor(union loongarch_instruction *insn, enum loongarch_gpr rd,
+			    enum loongarch_gpr rj, enum loongarch_gpr rk)
+{
+	insn->reg3_format.opcode = xor_op;
+	insn->reg3_format.rd = rd;
+	insn->reg3_format.rj = rj;
+	insn->reg3_format.rk = rk;
+}
+
+static inline void emit_xori(union loongarch_instruction *insn,
+			     enum loongarch_gpr rd, enum loongarch_gpr rj, u32 imm)
+{
+	insn->reg2ui12_format.opcode = xori_op;
+	insn->reg2ui12_format.immediate = imm;
+	insn->reg2ui12_format.rd = rd;
+	insn->reg2ui12_format.rj = rj;
+}
+
+static inline void emit_lu12iw(union loongarch_instruction *insn,
+			       enum loongarch_gpr rd, int imm)
+{
+	insn->reg1i20_format.opcode = lu12iw_op;
+	insn->reg1i20_format.immediate = imm;
+	insn->reg1i20_format.rd = rd;
+}
+
+static inline void emit_lu32id(union loongarch_instruction *insn,
+			       enum loongarch_gpr rd, int imm)
+{
+	insn->reg1i20_format.opcode = lu32id_op;
+	insn->reg1i20_format.immediate = imm;
+	insn->reg1i20_format.rd = rd;
+}
+
+static inline void emit_lu52id(union loongarch_instruction *insn,
+			       enum loongarch_gpr rd, enum loongarch_gpr rj, int imm)
+{
+	insn->reg2i12_format.opcode = lu52id_op;
+	insn->reg2i12_format.immediate = imm;
+	insn->reg2i12_format.rd = rd;
+	insn->reg2i12_format.rj = rj;
+}
+
+static inline void emit_sllw(union loongarch_instruction *insn, enum loongarch_gpr rd,
+			     enum loongarch_gpr rj, enum loongarch_gpr rk)
+{
+	insn->reg3_format.opcode = sllw_op;
+	insn->reg3_format.rd = rd;
+	insn->reg3_format.rj = rj;
+	insn->reg3_format.rk = rk;
+}
+
+static inline void emit_slliw(union loongarch_instruction *insn,
+			      enum loongarch_gpr rd, enum loongarch_gpr rj, u32 imm)
+{
+	insn->reg2ui5_format.opcode = slliw_op;
+	insn->reg2ui5_format.immediate = imm;
+	insn->reg2ui5_format.rd = rd;
+	insn->reg2ui5_format.rj = rj;
+}
+
+static inline void emit_slld(union loongarch_instruction *insn, enum loongarch_gpr rd,
+			     enum loongarch_gpr rj, enum loongarch_gpr rk)
+{
+	insn->reg3_format.opcode = slld_op;
+	insn->reg3_format.rd = rd;
+	insn->reg3_format.rj = rj;
+	insn->reg3_format.rk = rk;
+}
+
+static inline void emit_sllid(union loongarch_instruction *insn,
+			      enum loongarch_gpr rd, enum loongarch_gpr rj, u32 imm)
+{
+	insn->reg2ui6_format.opcode = sllid_op;
+	insn->reg2ui6_format.immediate = imm;
+	insn->reg2ui6_format.rd = rd;
+	insn->reg2ui6_format.rj = rj;
+}
+
+static inline void emit_srlw(union loongarch_instruction *insn, enum loongarch_gpr rd,
+			     enum loongarch_gpr rj, enum loongarch_gpr rk)
+{
+	insn->reg3_format.opcode = srlw_op;
+	insn->reg3_format.rd = rd;
+	insn->reg3_format.rj = rj;
+	insn->reg3_format.rk = rk;
+}
+
+static inline void emit_srliw(union loongarch_instruction *insn,
+			      enum loongarch_gpr rd, enum loongarch_gpr rj, u32 imm)
+{
+	insn->reg2ui5_format.opcode = srliw_op;
+	insn->reg2ui5_format.immediate = imm;
+	insn->reg2ui5_format.rd = rd;
+	insn->reg2ui5_format.rj = rj;
+}
+
+static inline void emit_srld(union loongarch_instruction *insn, enum loongarch_gpr rd,
+			     enum loongarch_gpr rj, enum loongarch_gpr rk)
+{
+	insn->reg3_format.opcode = srld_op;
+	insn->reg3_format.rd = rd;
+	insn->reg3_format.rj = rj;
+	insn->reg3_format.rk = rk;
+}
+
+static inline void emit_srlid(union loongarch_instruction *insn,
+			      enum loongarch_gpr rd, enum loongarch_gpr rj, u32 imm)
+{
+	insn->reg2ui6_format.opcode = srlid_op;
+	insn->reg2ui6_format.immediate = imm;
+	insn->reg2ui6_format.rd = rd;
+	insn->reg2ui6_format.rj = rj;
+}
+
+static inline void emit_sraw(union loongarch_instruction *insn, enum loongarch_gpr rd,
+			     enum loongarch_gpr rj, enum loongarch_gpr rk)
+{
+	insn->reg3_format.opcode = sraw_op;
+	insn->reg3_format.rd = rd;
+	insn->reg3_format.rj = rj;
+	insn->reg3_format.rk = rk;
+}
+
+static inline void emit_sraiw(union loongarch_instruction *insn,
+			      enum loongarch_gpr rd, enum loongarch_gpr rj, u32 imm)
+{
+	insn->reg2ui5_format.opcode = sraiw_op;
+	insn->reg2ui5_format.immediate = imm;
+	insn->reg2ui5_format.rd = rd;
+	insn->reg2ui5_format.rj = rj;
+}
+
+static inline void emit_srad(union loongarch_instruction *insn, enum loongarch_gpr rd,
+			     enum loongarch_gpr rj, enum loongarch_gpr rk)
+{
+	insn->reg3_format.opcode = srad_op;
+	insn->reg3_format.rd = rd;
+	insn->reg3_format.rj = rj;
+	insn->reg3_format.rk = rk;
+}
+
+static inline void emit_sraid(union loongarch_instruction *insn,
+			      enum loongarch_gpr rd, enum loongarch_gpr rj, u32 imm)
+{
+	insn->reg2ui6_format.opcode = sraid_op;
+	insn->reg2ui6_format.immediate = imm;
+	insn->reg2ui6_format.rd = rd;
+	insn->reg2ui6_format.rj = rj;
+}
+
+static inline void emit_beq(union loongarch_instruction *insn,
+			    enum loongarch_gpr rj, enum loongarch_gpr rd, int offset)
+{
+	insn->reg2i16_format.opcode = beq_op;
+	insn->reg2i16_format.immediate = offset;
+	insn->reg2i16_format.rj = rj;
+	insn->reg2i16_format.rd = rd;
+}
+
+static inline void emit_bne(union loongarch_instruction *insn,
+			    enum loongarch_gpr rj, enum loongarch_gpr rd, int offset)
+{
+	insn->reg2i16_format.opcode = bne_op;
+	insn->reg2i16_format.immediate = offset;
+	insn->reg2i16_format.rj = rj;
+	insn->reg2i16_format.rd = rd;
+}
+
+static inline void emit_blt(union loongarch_instruction *insn,
+			    enum loongarch_gpr rj, enum loongarch_gpr rd, int offset)
+{
+	insn->reg2i16_format.opcode = blt_op;
+	insn->reg2i16_format.immediate = offset;
+	insn->reg2i16_format.rj = rj;
+	insn->reg2i16_format.rd = rd;
+}
+
+static inline void emit_bge(union loongarch_instruction *insn,
+			    enum loongarch_gpr rj, enum loongarch_gpr rd, int offset)
+{
+	insn->reg2i16_format.opcode = bge_op;
+	insn->reg2i16_format.immediate = offset;
+	insn->reg2i16_format.rj = rj;
+	insn->reg2i16_format.rd = rd;
+}
+
+static inline void emit_bltu(union loongarch_instruction *insn,
+			     enum loongarch_gpr rj, enum loongarch_gpr rd, int offset)
+{
+	insn->reg2i16_format.opcode = bltu_op;
+	insn->reg2i16_format.immediate = offset;
+	insn->reg2i16_format.rj = rj;
+	insn->reg2i16_format.rd = rd;
+}
+
+static inline void emit_bgeu(union loongarch_instruction *insn,
+			     enum loongarch_gpr rj, enum loongarch_gpr rd, int offset)
+{
+	insn->reg2i16_format.opcode = bgeu_op;
+	insn->reg2i16_format.immediate = offset;
+	insn->reg2i16_format.rj = rj;
+	insn->reg2i16_format.rd = rd;
+}
+
+static inline void emit_b(union loongarch_instruction *insn, int offset)
+{
+	unsigned int immediate_l, immediate_h;
+
+	immediate_l = offset & 0xffff;
+	offset >>= 16;
+	immediate_h = offset & 0x3ff;
+
+	insn->reg0i26_format.opcode = b_op;
+	insn->reg0i26_format.immediate_l = immediate_l;
+	insn->reg0i26_format.immediate_h = immediate_h;
+}
+
+static inline void emit_jirl(union loongarch_instruction *insn,
+			     enum loongarch_gpr rd, enum loongarch_gpr rj, int offset)
+{
+	insn->reg2i16_format.opcode = jirl_op;
+	insn->reg2i16_format.immediate = offset;
+	insn->reg2i16_format.rd = rd;
+	insn->reg2i16_format.rj = rj;
+}
+
+static inline void emit_pcaddu18i(union loongarch_instruction *insn,
+				  enum loongarch_gpr rd, int imm)
+{
+	insn->reg1i20_format.opcode = pcaddu18i_op;
+	insn->reg1i20_format.immediate = imm;
+	insn->reg1i20_format.rd = rd;
+}
+
+static inline void emit_revb2h(union loongarch_instruction *insn,
+			       enum loongarch_gpr rd, enum loongarch_gpr rj)
+{
+	insn->reg2_format.opcode = revb2h_op;
+	insn->reg2_format.rd = rd;
+	insn->reg2_format.rj = rj;
+}
+
+static inline void emit_revb2w(union loongarch_instruction *insn,
+			       enum loongarch_gpr rd, enum loongarch_gpr rj)
+{
+	insn->reg2_format.opcode = revb2w_op;
+	insn->reg2_format.rd = rd;
+	insn->reg2_format.rj = rj;
+}
+
+static inline void emit_revbd(union loongarch_instruction *insn,
+			      enum loongarch_gpr rd, enum loongarch_gpr rj)
+{
+	insn->reg2_format.opcode = revbd_op;
+	insn->reg2_format.rd = rd;
+	insn->reg2_format.rj = rj;
+}
+
+/* Zero-extend 32 bits into 64 bits */
+static inline void emit_zext_32(struct jit_ctx *ctx, enum loongarch_gpr reg, bool is32)
+{
+	if (!is32)
+		return;
+
+	emit_insn(ctx, lu32id, reg, 0);
+}
+
+/* Signed-extend 32 bits into 64 bits */
+static inline void emit_sext_32(struct jit_ctx *ctx, enum loongarch_gpr reg, bool is32)
+{
+	if (!is32)
+		return;
+
+	emit_insn(ctx, addiw, reg, reg, 0);
+}
+
+static inline void move_imm32(struct jit_ctx *ctx, enum loongarch_gpr rd,
+			      int imm32, bool is32)
+{
+	int si20;
+	u32 ui12;
+
+	/* or rd, $zero, $zero */
+	if (imm32 == 0) {
+		emit_insn(ctx, or, rd, LOONGARCH_GPR_ZERO, LOONGARCH_GPR_ZERO);
+		return;
+	}
+
+	/* addiw rd, $zero, imm_11_0(signed) */
+	if (is_signed_imm12(imm32)) {
+		emit_insn(ctx, addiw, rd, LOONGARCH_GPR_ZERO, imm32);
+		goto zext;
+	}
+
+	/* ori rd, $zero, imm_11_0(unsigned) */
+	if (is_unsigned_imm12(imm32)) {
+		emit_insn(ctx, ori, rd, LOONGARCH_GPR_ZERO, imm32);
+		goto zext;
+	}
+
+	/* lu12iw rd, imm_31_12(signed) */
+	si20 = (imm32 >> 12) & 0xfffff;
+	emit_insn(ctx, lu12iw, rd, si20);
+
+	/* ori rd, rd, imm_11_0(unsigned) */
+	ui12 = imm32 & 0xfff;
+	if (ui12 != 0)
+		emit_insn(ctx, ori, rd, rd, ui12);
+
+zext:
+	emit_zext_32(ctx, rd, is32);
+}
+
+static inline void move_imm64(struct jit_ctx *ctx, enum loongarch_gpr rd,
+			      long imm64, bool is32)
+{
+	int imm32, si20, si12;
+	long imm52;
+
+	si12 = (imm64 >> 52) & 0xfff;
+	imm52 = imm64 & 0xfffffffffffff;
+	/* lu52id rd, $zero, imm_63_52(signed) */
+	if (si12 != 0 && imm52 == 0) {
+		emit_insn(ctx, lu52id, rd, LOONGARCH_GPR_ZERO, si12);
+		return;
+	}
+
+	imm32 = imm64 & 0xffffffff;
+	move_imm32(ctx, rd, imm32, is32);
+
+	if (!is_signed_imm32(imm64)) {
+		if (imm52 != 0) {
+			/* lu32id rd, imm_51_32(signed) */
+			si20 = (imm64 >> 32) & 0xfffff;
+			emit_insn(ctx, lu32id, rd, si20);
+		}
+
+		/* lu52id rd, rd, imm_63_52(signed) */
+		if (!is_signed_imm52(imm64))
+			emit_insn(ctx, lu52id, rd, rd, si12);
+	}
+}
+
+static inline void move_reg(struct jit_ctx *ctx, enum loongarch_gpr rd,
+			    enum loongarch_gpr rj)
+{
+	emit_insn(ctx, or, rd, rj, LOONGARCH_GPR_ZERO);
+}
+
+static inline int invert_jmp_cond(u8 cond)
+{
+	switch (cond) {
+	case BPF_JEQ:
+		return BPF_JNE;
+	case BPF_JNE:
+	case BPF_JSET:
+		return BPF_JEQ;
+	case BPF_JGT:
+		return BPF_JLE;
+	case BPF_JGE:
+		return BPF_JLT;
+	case BPF_JLT:
+		return BPF_JGE;
+	case BPF_JLE:
+		return BPF_JGT;
+	case BPF_JSGT:
+		return BPF_JSLE;
+	case BPF_JSGE:
+		return BPF_JSLT;
+	case BPF_JSLT:
+		return BPF_JSGE;
+	case BPF_JSLE:
+		return BPF_JSGT;
+	}
+	return -1;
+}
+
+static inline void cond_jmp_offs16(struct jit_ctx *ctx, u8 cond, enum loongarch_gpr rj,
+				   enum loongarch_gpr rd, int jmp_offset)
+{
+	switch (cond) {
+	case BPF_JEQ:
+		/* PC += jmp_offset if rj == rd */
+		emit_insn(ctx, beq, rj, rd, jmp_offset);
+		return;
+	case BPF_JNE:
+	case BPF_JSET:
+		/* PC += jmp_offset if rj != rd */
+		emit_insn(ctx, bne, rj, rd, jmp_offset);
+		return;
+	case BPF_JGT:
+		/* PC += jmp_offset if rj > rd (unsigned) */
+		emit_insn(ctx, bltu, rd, rj, jmp_offset);
+		return;
+	case BPF_JLT:
+		/* PC += jmp_offset if rj < rd (unsigned) */
+		emit_insn(ctx, bltu, rj, rd, jmp_offset);
+		return;
+	case BPF_JGE:
+		/* PC += jmp_offset if rj >= rd (unsigned) */
+		emit_insn(ctx, bgeu, rj, rd, jmp_offset);
+		return;
+	case BPF_JLE:
+		/* PC += jmp_offset if rj <= rd (unsigned) */
+		emit_insn(ctx, bgeu, rd, rj, jmp_offset);
+		return;
+	case BPF_JSGT:
+		/* PC += jmp_offset if rj > rd (signed) */
+		emit_insn(ctx, blt, rd, rj, jmp_offset);
+		return;
+	case BPF_JSLT:
+		/* PC += jmp_offset if rj < rd (signed) */
+		emit_insn(ctx, blt, rj, rd, jmp_offset);
+		return;
+	case BPF_JSGE:
+		/* PC += jmp_offset if rj >= rd (signed) */
+		emit_insn(ctx, bge, rj, rd, jmp_offset);
+		return;
+	case BPF_JSLE:
+		/* PC += jmp_offset if rj <= rd (signed) */
+		emit_insn(ctx, bge, rd, rj, jmp_offset);
+		return;
+	}
+}
+
+static inline void cond_jmp_offs26(struct jit_ctx *ctx, u8 cond, enum loongarch_gpr rj,
+				   enum loongarch_gpr rd, int jmp_offset)
+{
+	cond = invert_jmp_cond(cond);
+	cond_jmp_offs16(ctx, cond, rj, rd, 2);
+	emit_insn(ctx, b, jmp_offset);
+}
+
+static inline void cond_jmp_offs32(struct jit_ctx *ctx, u8 cond, enum loongarch_gpr rj,
+				   enum loongarch_gpr rd, int jmp_offset)
+{
+	s64 upper, lower;
+
+	upper = (jmp_offset + (1 << 15)) >> 16;
+	lower = jmp_offset & 0xffff;
+
+	cond = invert_jmp_cond(cond);
+	cond_jmp_offs16(ctx, cond, rj, rd, 3);
+
+	/*
+	 * jmp_addr = jmp_offset << 2
+	 * tmp2 = PC + jmp_addr[31, 18] + 18'b0
+	 */
+	emit_insn(ctx, pcaddu18i, LOONGARCH_GPR_T2, upper << 2);
+
+	/* jump to (tmp2 + jmp_addr[17, 2] + 2'b0) */
+	emit_insn(ctx, jirl, LOONGARCH_GPR_ZERO, LOONGARCH_GPR_T2, lower + 1);
+}
+
+static inline void uncond_jmp_offs26(struct jit_ctx *ctx, int jmp_offset)
+{
+	emit_insn(ctx, b, jmp_offset);
+}
+
+static inline void uncond_jmp_offs32(struct jit_ctx *ctx, int jmp_offset, bool is_exit)
+{
+	s64 upper, lower;
+
+	upper = (jmp_offset + (1 << 15)) >> 16;
+	lower = jmp_offset & 0xffff;
+
+	if (is_exit)
+		lower -= 1;
+
+	/*
+	 * jmp_addr = jmp_offset << 2;
+	 * tmp1 = PC + jmp_addr[31, 18] + 18'b0
+	 */
+	emit_insn(ctx, pcaddu18i, LOONGARCH_GPR_T1, upper << 2);
+
+	/* jump to (tmp1 + jmp_addr[17, 2] + 2'b0) */
+	emit_insn(ctx, jirl, LOONGARCH_GPR_ZERO, LOONGARCH_GPR_T1, lower + 1);
+}
+
+static inline void emit_cond_jmp(struct jit_ctx *ctx, u8 cond, enum loongarch_gpr rj,
+				 enum loongarch_gpr rd, int jmp_offset)
+{
+	cond_jmp_offs26(ctx, cond, rj, rd, jmp_offset);
+}
+
+static inline void emit_uncond_jmp(struct jit_ctx *ctx, int jmp_offset, bool is_exit)
+{
+	if (is_signed_imm26(jmp_offset))
+		uncond_jmp_offs26(ctx, jmp_offset);
+	else
+		uncond_jmp_offs32(ctx, jmp_offset, is_exit);
+}
+
+static inline void emit_tailcall_jmp(struct jit_ctx *ctx, u8 cond, enum loongarch_gpr rj,
+				     enum loongarch_gpr rd, int jmp_offset)
+{
+	if (is_signed_imm16(jmp_offset))
+		cond_jmp_offs16(ctx, cond, rj, rd, jmp_offset);
+	else if (is_signed_imm26(jmp_offset))
+		cond_jmp_offs26(ctx, cond, rj, rd, jmp_offset - 1);
+	else
+		cond_jmp_offs32(ctx, cond, rj, rd, jmp_offset - 2);
+}
-- 
2.1.0

