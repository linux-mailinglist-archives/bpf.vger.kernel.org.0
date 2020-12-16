Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE29C2DBE5B
	for <lists+bpf@lfdr.de>; Wed, 16 Dec 2020 11:10:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbgLPKKA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Dec 2020 05:10:00 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:7404 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726010AbgLPKKA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 16 Dec 2020 05:10:00 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4CwrQx5X8Qz9v1ZX;
        Wed, 16 Dec 2020 11:07:37 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id S0xFGHlC178s; Wed, 16 Dec 2020 11:07:37 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4CwrQx4b0Qz9v1Z7;
        Wed, 16 Dec 2020 11:07:37 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 6153E8B7C7;
        Wed, 16 Dec 2020 11:07:38 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id hNuELeHgtjrc; Wed, 16 Dec 2020 11:07:38 +0100 (CET)
Received: from localhost.localdomain (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 71DF18B7BA;
        Wed, 16 Dec 2020 11:07:37 +0100 (CET)
Received: by localhost.localdomain (Postfix, from userid 0)
        id 46B996681D; Wed, 16 Dec 2020 10:07:37 +0000 (UTC)
Message-Id: <1fed5e11ba08ee28d12f3f57986e5b143a6aa937.1608112797.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1608112796.git.christophe.leroy@csgroup.eu>
References: <cover.1608112796.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [RFC PATCH v1 7/7] powerpc/bpf: Implement extended BPF on PPC32
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@chromium.org, naveen.n.rao@linux.ibm.com,
        sandipan@linux.ibm.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Date:   Wed, 16 Dec 2020 10:07:37 +0000 (UTC)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Implement Extended Berkeley Packet Filter on Powerpc 32

Test result with test_bpf module:

	test_bpf: Summary: 378 PASSED, 0 FAILED, [354/366 JIT'ed]

Registers mapping:

	[BPF_REG_0] = r11-r12
	/* function arguments */
	[BPF_REG_1] = r3-r4
	[BPF_REG_2] = r5-r6
	[BPF_REG_3] = r7-r8
	[BPF_REG_4] = r9-r10
	[BPF_REG_5] = r21-r22 (Args 9 and 10 come in via the stack)
	/* non volatile registers */
	[BPF_REG_6] = r23-r24
	[BPF_REG_7] = r25-r26
	[BPF_REG_8] = r27-r28
	[BPF_REG_9] = r29-r30
	/* frame pointer aka BPF_REG_10 */
	[BPF_REG_FP] = r31
	/* eBPF jit internal registers */
	[BPF_REG_AX] = r19-r20
	[TMP_REG] = r18

As PPC32 doesn't have a redzone in the stack,
use r17 as tail call counter.

r0 is used as temporary register as much as possible. It is referenced
directly in the code in order to avoid misuse of it, because some
instructions interpret it as value 0 instead of register r0
(ex: addi, addis, stw, lwz, ...)

The following operations are not implemented:

		case BPF_ALU64 | BPF_DIV | BPF_X: /* dst /= src */
		case BPF_ALU64 | BPF_MOD | BPF_X: /* dst %= src */
		case BPF_STX | BPF_XADD | BPF_DW: /* *(u64 *)(dst + off) += src */

The following operations are only implemented for power of two constants:

		case BPF_ALU64 | BPF_MOD | BPF_K: /* dst %= imm */
		case BPF_ALU64 | BPF_DIV | BPF_K: /* dst /= imm */

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/Kconfig              |    2 +-
 arch/powerpc/net/Makefile         |    2 +-
 arch/powerpc/net/bpf_jit.h        |    4 +
 arch/powerpc/net/bpf_jit32.h      |   58 ++
 arch/powerpc/net/bpf_jit_comp32.c | 1020 +++++++++++++++++++++++++++++
 5 files changed, 1084 insertions(+), 2 deletions(-)
 create mode 100644 arch/powerpc/net/bpf_jit32.h
 create mode 100644 arch/powerpc/net/bpf_jit_comp32.c

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 6d1454d31a53..e09d0bfed843 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -199,7 +199,7 @@ config PPC
 	select HAVE_DEBUG_STACKOVERFLOW
 	select HAVE_DYNAMIC_FTRACE
 	select HAVE_DYNAMIC_FTRACE_WITH_REGS	if MPROFILE_KERNEL
-	select HAVE_EBPF_JIT			if PPC64
+	select HAVE_EBPF_JIT
 	select HAVE_EFFICIENT_UNALIGNED_ACCESS	if !(CPU_LITTLE_ENDIAN && POWER7_CPU)
 	select HAVE_FAST_GUP
 	select HAVE_FTRACE_MCOUNT_RECORD
diff --git a/arch/powerpc/net/Makefile b/arch/powerpc/net/Makefile
index 969cde177880..8e60af32e51e 100644
--- a/arch/powerpc/net/Makefile
+++ b/arch/powerpc/net/Makefile
@@ -2,4 +2,4 @@
 #
 # Arch-specific network modules
 #
-obj-$(CONFIG_BPF_JIT) += bpf_jit_comp.o bpf_jit_comp64.o
+obj-$(CONFIG_BPF_JIT) += bpf_jit_comp.o bpf_jit_comp$(BITS).o
diff --git a/arch/powerpc/net/bpf_jit.h b/arch/powerpc/net/bpf_jit.h
index fb4656986fb9..a45b8266355d 100644
--- a/arch/powerpc/net/bpf_jit.h
+++ b/arch/powerpc/net/bpf_jit.h
@@ -42,6 +42,10 @@
 				EMIT(PPC_RAW_ORI(d, d, IMM_L(i)));	      \
 		} } while(0)
 
+#ifdef CONFIG_PPC32
+#define PPC_EX32(r, i)		EMIT(PPC_RAW_LI((r), (i) < 0 ? -1 : 0))
+#endif
+
 #define PPC_LI64(d, i)		do {					      \
 		if ((long)(i) >= -2147483648 &&				      \
 				(long)(i) < 2147483648)			      \
diff --git a/arch/powerpc/net/bpf_jit32.h b/arch/powerpc/net/bpf_jit32.h
new file mode 100644
index 000000000000..3e8149f45368
--- /dev/null
+++ b/arch/powerpc/net/bpf_jit32.h
@@ -0,0 +1,58 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * BPF JIT compiler for PPC32
+ *
+ */
+#ifndef _BPF_JIT32_H
+#define _BPF_JIT32_H
+
+#include "bpf_jit.h"
+
+/*
+ * Stack layout:
+ *
+ *		[	prev sp		] <-------------
+ *		[   nv gpr save area	] 16 * 4	|
+ * fp (r31) -->	[   ebpf stack space	] upto 512	|
+ *		[     frame header	] 16		|
+ * sp (r1) --->	[    stack pointer	] --------------
+ */
+
+/* for gpr non volatile registers r18 to r31 (14) + r17 for tail call + alignment */
+#define BPF_PPC_STACK_SAVE	(14 * 4 + 4 + 4)
+/* stack frame, ensure this is quadword aligned */
+#define BPF_PPC_STACKFRAME(ctx)	(STACK_FRAME_MIN_SIZE + BPF_PPC_STACK_SAVE + (ctx)->stack_size)
+
+#ifndef __ASSEMBLY__
+
+/* BPF register usage */
+#define TMP_REG	(MAX_BPF_JIT_REG + 0)
+
+/* BPF to ppc register mappings */
+static const int b2p[] = {
+	/* function return value */
+	[BPF_REG_0] = 12,
+	/* function arguments */
+	[BPF_REG_1] = 4,
+	[BPF_REG_2] = 6,
+	[BPF_REG_3] = 8,
+	[BPF_REG_4] = 10,
+	[BPF_REG_5] = 22,
+	/* non volatile registers */
+	[BPF_REG_6] = 24,
+	[BPF_REG_7] = 26,
+	[BPF_REG_8] = 28,
+	[BPF_REG_9] = 30,
+	/* frame pointer aka BPF_REG_10 */
+	[BPF_REG_FP] = 31,
+	/* eBPF jit internal registers */
+	[BPF_REG_AX] = 20,
+	[TMP_REG] = 18,
+};
+
+/* PPC NVR range -- update this if we ever use NVRs below r18 */
+#define BPF_PPC_NVR_MIN		18
+
+#endif /* !__ASSEMBLY__ */
+
+#endif
diff --git a/arch/powerpc/net/bpf_jit_comp32.c b/arch/powerpc/net/bpf_jit_comp32.c
new file mode 100644
index 000000000000..72eef501899b
--- /dev/null
+++ b/arch/powerpc/net/bpf_jit_comp32.c
@@ -0,0 +1,1020 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * eBPF JIT compiler for PPC32
+ *
+ * Copyright 2020 Christophe Leroy <christophe.leroy@csgroup.eu>
+ *		  CS GROUP France
+ *
+ * Based on PPC64 eBPF JIT compiler by Naveen N. Rao
+ */
+#include <linux/moduleloader.h>
+#include <asm/cacheflush.h>
+#include <asm/asm-compat.h>
+#include <linux/netdevice.h>
+#include <linux/filter.h>
+#include <linux/if_vlan.h>
+#include <asm/kprobes.h>
+#include <linux/bpf.h>
+
+#include "bpf_jit32.h"
+
+static int bpf_jit_stack_offsetof(struct codegen_context *ctx, int reg)
+{
+	if ((reg >= BPF_PPC_NVR_MIN && reg < 32) || reg == __REG_R17)
+		return BPF_PPC_STACKFRAME(ctx) - 4 * (32 - reg);
+
+	WARN(true, "BPF JIT is asking about unknown registers");
+	/* Use the hole we have left for alignment */
+	return BPF_PPC_STACKFRAME(ctx) - 4 * (32 - __REG_R16);
+}
+
+void bpf_jit_build_prologue(u32 *image, struct codegen_context *ctx)
+{
+	int i;
+
+	/* First arg comes in as a 32 bits pointer. */
+	EMIT(PPC_RAW_MR(b2p[BPF_REG_1], __REG_R3));
+	EMIT(PPC_RAW_LI(b2p[BPF_REG_1] - 1, 0));
+
+	/*
+	 * Initialize tail_call_cnt in r17 if we do tail calls.
+	 * Otherwise, put in NOPs so that it can be skipped when we are
+	 * invoked through a tail call.
+	 */
+	if (ctx->seen & SEEN_TAILCALL) {
+		EMIT(PPC_RAW_STWU(__REG_R1, __REG_R1, -BPF_PPC_STACKFRAME(ctx)));
+		EMIT(PPC_RAW_STW(__REG_R17, __REG_R1, bpf_jit_stack_offsetof(ctx, __REG_R17)));
+		EMIT(PPC_RAW_LI(__REG_R17, 0));
+		/* Skip already done stackframe setup */
+		PPC_JMP((ctx->idx + 2) * 4);
+	} else {
+		EMIT(PPC_RAW_NOP());
+		EMIT(PPC_RAW_NOP());
+		EMIT(PPC_RAW_NOP());
+		EMIT(PPC_RAW_NOP());
+	}
+
+#define BPF_TAILCALL_PROLOGUE_SIZE	24
+
+	EMIT(PPC_RAW_STWU(__REG_R1, __REG_R1, -BPF_PPC_STACKFRAME(ctx)));
+
+	/*
+	 * We need a stack frame, but we don't necessarily need to
+	 * save/restore LR unless we call other functions
+	 */
+	if (ctx->seen & SEEN_FUNC) {
+		EMIT(PPC_RAW_MFLR(__REG_R0));
+		EMIT(PPC_RAW_STW(__REG_R0, __REG_R1, BPF_PPC_STACKFRAME(ctx) + PPC_LR_STKOFF));
+	}
+
+	/*
+	 * Back up non-volatile regs -- registers r18-r31
+	 */
+	for (i = BPF_PPC_NVR_MIN; i <= 31; i++)
+		if (bpf_is_seen_register(ctx, i))
+			EMIT(PPC_RAW_STW(i, __REG_R1, bpf_jit_stack_offsetof(ctx, i)));
+
+	/* If needed retrieve arguments 9 and 10, ie 5th 64 bits arg.*/
+	if (bpf_is_seen_register(ctx, b2p[BPF_REG_5])) {
+		EMIT(PPC_RAW_LWZ(b2p[BPF_REG_5] - 1, __REG_R1, BPF_PPC_STACKFRAME(ctx)) + 8);
+		EMIT(PPC_RAW_LWZ(b2p[BPF_REG_5], __REG_R1, BPF_PPC_STACKFRAME(ctx)) + 12);
+	}
+
+	/* Setup frame pointer to point to the bpf stack area */
+	if (bpf_is_seen_register(ctx, b2p[BPF_REG_FP]))
+		EMIT(PPC_RAW_ADDI(b2p[BPF_REG_FP], __REG_R1,
+				  STACK_FRAME_MIN_SIZE + ctx->stack_size));
+}
+
+static void bpf_jit_emit_common_epilogue(u32 *image, struct codegen_context *ctx)
+{
+	int i;
+
+	/* Restore NVRs */
+	for (i = BPF_PPC_NVR_MIN; i <= 31; i++)
+		if (bpf_is_seen_register(ctx, i))
+			EMIT(PPC_RAW_LWZ(i, __REG_R1, bpf_jit_stack_offsetof(ctx, i)));
+
+	/* Tear down our stack frame */
+	EMIT(PPC_RAW_ADDI(__REG_R1, __REG_R1, BPF_PPC_STACKFRAME(ctx)));
+	if (ctx->seen & SEEN_FUNC) {
+		EMIT(PPC_RAW_LWZ(__REG_R0, __REG_R1, PPC_LR_STKOFF));
+		EMIT(PPC_RAW_MTLR(__REG_R0));
+	}
+}
+
+void bpf_jit_build_epilogue(u32 *image, struct codegen_context *ctx)
+{
+	EMIT(PPC_RAW_MR(__REG_R3, b2p[BPF_REG_0]));
+
+	if (ctx->seen & SEEN_TAILCALL)
+		EMIT(PPC_RAW_LWZ(__REG_R17, __REG_R1, bpf_jit_stack_offsetof(ctx, __REG_R17)));
+
+	bpf_jit_emit_common_epilogue(image, ctx);
+
+	EMIT(PPC_RAW_BLR());
+}
+
+void bpf_jit_emit_func_call_rel(u32 *image, struct codegen_context *ctx, u64 func)
+{
+	/* Load function address into r0 */
+	EMIT(PPC_RAW_LIS(__REG_R0, IMM_H(func)));
+	EMIT(PPC_RAW_ORI(__REG_R0, __REG_R0, IMM_L(func)));
+	EMIT(PPC_RAW_MTLR(__REG_R0));
+	EMIT(PPC_RAW_BLRL());
+}
+
+static void bpf_jit_emit_tail_call(u32 *image, struct codegen_context *ctx, u32 out)
+{
+	/*
+	 * By now, the eBPF program has already setup parameters in r3-r6
+	 * r3-r4/BPF_REG_1 - pointer to ctx -- passed as is to the next bpf program
+	 * r5-r6/BPF_REG_2 - pointer to bpf_array
+	 * r7-r8/BPF_REG_3 - index in bpf_array
+	 */
+	int b2p_bpf_array = b2p[BPF_REG_2];
+	int b2p_index = b2p[BPF_REG_3];
+
+	/*
+	 * if (index >= array->map.max_entries)
+	 *   goto out;
+	 */
+	EMIT(PPC_RAW_LWZ(__REG_R0, b2p_bpf_array, offsetof(struct bpf_array, map.max_entries)));
+	EMIT(PPC_RAW_CMPLW(b2p_index, __REG_R0));
+	PPC_BCC(COND_GE, out);
+
+	/*
+	 * if (tail_call_cnt > MAX_TAIL_CALL_CNT)
+	 *   goto out;
+	 */
+	EMIT(PPC_RAW_CMPLWI(__REG_R17, MAX_TAIL_CALL_CNT));
+	PPC_BCC(COND_GT, out);
+
+	/*
+	 * tail_call_cnt++;
+	 */
+	EMIT(PPC_RAW_ADDI(__REG_R17, __REG_R17, 1));
+
+	/* prog = array->ptrs[index]; */
+	EMIT(PPC_RAW_RLWINM(__REG_R3, b2p_index, 2, 0, 29));
+	EMIT(PPC_RAW_ADD(__REG_R3, __REG_R3, b2p_bpf_array));
+	EMIT(PPC_RAW_LWZ(__REG_R3, __REG_R3, offsetof(struct bpf_array, ptrs)));
+
+	/*
+	 * if (prog == NULL)
+	 *   goto out;
+	 */
+	EMIT(PPC_RAW_CMPLWI(__REG_R3, 0));
+	PPC_BCC(COND_EQ, out);
+
+	/* goto *(prog->bpf_func + prologue_size); */
+	EMIT(PPC_RAW_LWZ(__REG_R3, __REG_R3, offsetof(struct bpf_prog, bpf_func)));
+	EMIT(PPC_RAW_ADDIC(__REG_R3, __REG_R3, BPF_TAILCALL_PROLOGUE_SIZE));
+	EMIT(PPC_RAW_MTCTR(__REG_R3));
+
+	EMIT(PPC_RAW_MR(__REG_R3, b2p[BPF_REG_1]));
+
+	/* tear down stack, restore NVRs, ... */
+	bpf_jit_emit_common_epilogue(image, ctx);
+
+	EMIT(PPC_RAW_BCTR());
+	/* out: */
+}
+
+/* Assemble the body code between the prologue & epilogue */
+int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, struct codegen_context *ctx,
+		       u32 *addrs, bool extra_pass)
+{
+	const struct bpf_insn *insn = fp->insnsi;
+	int flen = fp->len;
+	int i, ret;
+
+	/* Start of epilogue code - will only be valid 2nd pass onwards */
+	u32 exit_addr = addrs[flen];
+
+	for (i = 0; i < flen; i++) {
+		u32 code = insn[i].code;
+		u32 dst_reg = b2p[insn[i].dst_reg];
+		u32 dst_reg_h = dst_reg - 1;
+		u32 src_reg = b2p[insn[i].src_reg];
+		u32 src_reg_h = src_reg - 1;
+		u32 tmp_reg = b2p[TMP_REG];
+		s16 off = insn[i].off;
+		s32 imm = insn[i].imm;
+		bool func_addr_fixed;
+		u64 func_addr;
+		u32 true_cond;
+
+		/*
+		 * addrs[] maps a BPF bytecode address into a real offset from
+		 * the start of the body code.
+		 */
+		addrs[i] = ctx->idx * 4;
+
+		/*
+		 * As an optimization, we note down which registers
+		 * are used so that we can only save/restore those in our
+		 * prologue and epilogue. We do this here regardless of whether
+		 * the actual BPF instruction uses src/dst registers or not
+		 * (for instance, BPF_CALL does not use them). The expectation
+		 * is that those instructions will have src_reg/dst_reg set to
+		 * 0. Even otherwise, we just lose some prologue/epilogue
+		 * optimization but everything else should work without
+		 * any issues.
+		 */
+		if (dst_reg >= 3 && dst_reg < 32) {
+			bpf_set_seen_register(ctx, dst_reg);
+			bpf_set_seen_register(ctx, dst_reg_h);
+		}
+
+		if (src_reg >= 3 && src_reg < 32) {
+			bpf_set_seen_register(ctx, src_reg);
+			bpf_set_seen_register(ctx, src_reg_h);
+		}
+
+		switch (code) {
+		/*
+		 * Arithmetic operations: ADD/SUB/MUL/DIV/MOD/NEG
+		 */
+		case BPF_ALU | BPF_ADD | BPF_X: /* (u32) dst += (u32) src */
+			EMIT(PPC_RAW_ADD(dst_reg, dst_reg, src_reg));
+			break;
+		case BPF_ALU64 | BPF_ADD | BPF_X: /* dst += src */
+			EMIT(PPC_RAW_ADDC(dst_reg, dst_reg, src_reg));
+			EMIT(PPC_RAW_ADDE(dst_reg_h, dst_reg_h, src_reg_h));
+			break;
+		case BPF_ALU | BPF_SUB | BPF_X: /* (u32) dst -= (u32) src */
+			EMIT(PPC_RAW_SUB(dst_reg, dst_reg, src_reg));
+			break;
+		case BPF_ALU64 | BPF_SUB | BPF_X: /* dst -= src */
+			EMIT(PPC_RAW_SUBFC(dst_reg, src_reg, dst_reg));
+			EMIT(PPC_RAW_SUBFE(dst_reg_h, src_reg_h, dst_reg_h));
+			break;
+		case BPF_ALU | BPF_SUB | BPF_K: /* (u32) dst -= (u32) imm */
+			imm = -imm;
+			fallthrough;
+		case BPF_ALU | BPF_ADD | BPF_K: /* (u32) dst += (u32) imm */
+			if (IMM_HA(imm) & 0xffff)
+				EMIT(PPC_RAW_ADDIS(dst_reg, dst_reg, IMM_HA(imm)));
+			if (IMM_L(imm))
+				EMIT(PPC_RAW_ADDI(dst_reg, dst_reg, IMM_L(imm)));
+			break;
+		case BPF_ALU64 | BPF_SUB | BPF_K: /* dst -= imm */
+			imm = -imm;
+			fallthrough;
+		case BPF_ALU64 | BPF_ADD | BPF_K: /* dst += imm */
+			if (!imm)
+				break;
+
+			if (imm >= -32768 && imm < 32768) {
+				EMIT(PPC_RAW_ADDIC(dst_reg, dst_reg, imm));
+			} else {
+				PPC_LI32(__REG_R0, imm);
+				EMIT(PPC_RAW_ADDC(dst_reg, dst_reg, __REG_R0));
+			}
+			if (imm >= 0)
+				EMIT(PPC_RAW_ADDZE(dst_reg_h, dst_reg_h));
+			else
+				EMIT(PPC_RAW_ADDME(dst_reg_h, dst_reg_h));
+			break;
+		case BPF_ALU64 | BPF_MUL | BPF_X: /* dst *= src */
+			bpf_set_seen_register(ctx, tmp_reg);
+			EMIT(PPC_RAW_MULW(__REG_R0, dst_reg, src_reg_h));
+			EMIT(PPC_RAW_MULW(dst_reg_h, dst_reg_h, src_reg));
+			EMIT(PPC_RAW_MULHWU(tmp_reg, dst_reg, src_reg));
+			EMIT(PPC_RAW_MULW(dst_reg, dst_reg, src_reg));
+			EMIT(PPC_RAW_ADD(dst_reg_h, dst_reg_h, __REG_R0));
+			EMIT(PPC_RAW_ADD(dst_reg_h, dst_reg_h, tmp_reg));
+			break;
+		case BPF_ALU | BPF_MUL | BPF_X: /* (u32) dst *= (u32) src */
+			EMIT(PPC_RAW_MULW(dst_reg, dst_reg, src_reg));
+			break;
+		case BPF_ALU | BPF_MUL | BPF_K: /* (u32) dst *= (u32) imm */
+			if (imm >= -32768 && imm < 32768) {
+				EMIT(PPC_RAW_MULI(dst_reg, dst_reg, imm));
+			} else {
+				PPC_LI32(__REG_R0, imm);
+				EMIT(PPC_RAW_MULW(dst_reg, dst_reg, __REG_R0));
+			}
+			break;
+		case BPF_ALU64 | BPF_MUL | BPF_K: /* dst *= imm */
+			if (!imm) {
+				PPC_LI32(dst_reg, 0);
+				PPC_LI32(dst_reg_h, 0);
+				break;
+			}
+			if (imm == 1)
+				break;
+			if (imm == -1) {
+				EMIT(PPC_RAW_SUBFIC(dst_reg, dst_reg, 0));
+				EMIT(PPC_RAW_SUBFZE(dst_reg_h, dst_reg_h));
+				break;
+			}
+			bpf_set_seen_register(ctx, tmp_reg);
+			PPC_LI32(tmp_reg, imm);
+			EMIT(PPC_RAW_MULW(dst_reg_h, dst_reg_h, tmp_reg));
+			if (imm < 0)
+				EMIT(PPC_RAW_SUB(dst_reg_h, dst_reg_h, dst_reg));
+			EMIT(PPC_RAW_MULHWU(__REG_R0, dst_reg, tmp_reg));
+			EMIT(PPC_RAW_MULW(dst_reg, dst_reg, tmp_reg));
+			EMIT(PPC_RAW_ADD(dst_reg_h, dst_reg_h, __REG_R0));
+			break;
+		case BPF_ALU | BPF_DIV | BPF_X: /* (u32) dst /= (u32) src */
+			EMIT(PPC_RAW_DIVWU(dst_reg, dst_reg, src_reg));
+			break;
+		case BPF_ALU | BPF_MOD | BPF_X: /* (u32) dst %= (u32) src */
+			EMIT(PPC_RAW_DIVWU(__REG_R0, dst_reg, src_reg));
+			EMIT(PPC_RAW_MULW(__REG_R0, src_reg, __REG_R0));
+			EMIT(PPC_RAW_SUB(dst_reg, dst_reg, __REG_R0));
+			break;
+		case BPF_ALU64 | BPF_DIV | BPF_X: /* dst /= src */
+			return -EOPNOTSUPP;
+		case BPF_ALU64 | BPF_MOD | BPF_X: /* dst %= src */
+			return -EOPNOTSUPP;
+		case BPF_ALU | BPF_DIV | BPF_K: /* (u32) dst /= (u32) imm */
+			if (!imm)
+				return -EINVAL;
+			if (imm == 1)
+				break;
+
+			PPC_LI32(__REG_R0, imm);
+			EMIT(PPC_RAW_DIVWU(dst_reg, dst_reg, __REG_R0));
+			break;
+		case BPF_ALU | BPF_MOD | BPF_K: /* (u32) dst %= (u32) imm */
+			if (!imm)
+				return -EINVAL;
+
+			if (!is_power_of_2((u32)imm)) {
+				bpf_set_seen_register(ctx, tmp_reg);
+				PPC_LI32(tmp_reg, imm);
+				EMIT(PPC_RAW_DIVWU(__REG_R0, dst_reg, tmp_reg));
+				EMIT(PPC_RAW_MULW(__REG_R0, tmp_reg, __REG_R0));
+				EMIT(PPC_RAW_SUB(dst_reg, dst_reg, __REG_R0));
+				break;
+			}
+			if (imm == 1)
+				EMIT(PPC_RAW_LI(dst_reg, 0));
+			else
+				EMIT(PPC_RAW_RLWINM(dst_reg, dst_reg, 0, 32 - ilog2((u32)imm), 31));
+
+			break;
+		case BPF_ALU64 | BPF_MOD | BPF_K: /* dst %= imm */
+			if (!imm)
+				return -EINVAL;
+			if (imm < 0)
+				imm = -imm;
+			if (!is_power_of_2(imm))
+				return -EOPNOTSUPP;
+			if (imm == 1)
+				EMIT(PPC_RAW_LI(dst_reg, 0));
+			else
+				EMIT(PPC_RAW_RLWINM(dst_reg, dst_reg, 0, 32 - ilog2(imm), 31));
+			EMIT(PPC_RAW_LI(dst_reg_h, 0));
+			break;
+		case BPF_ALU64 | BPF_DIV | BPF_K: /* dst /= imm */
+			if (!imm)
+				return -EINVAL;
+			if (!is_power_of_2(abs(imm)))
+				return -EOPNOTSUPP;
+
+			if (imm < 0) {
+				EMIT(PPC_RAW_SUBFIC(dst_reg, dst_reg, 0));
+				EMIT(PPC_RAW_SUBFZE(dst_reg_h, dst_reg_h));
+				imm = -imm;
+			}
+			if (imm == 1)
+				break;
+			imm = ilog2(imm);
+			EMIT(PPC_RAW_RLWINM(dst_reg, dst_reg, 32 - imm, imm, 31));
+			EMIT(PPC_RAW_RLWIMI(dst_reg, dst_reg_h, 32 - imm, 0, imm - 1));
+			EMIT(PPC_RAW_SRAWI(dst_reg_h, dst_reg_h, imm));
+			break;
+		case BPF_ALU | BPF_NEG: /* (u32) dst = -dst */
+			EMIT(PPC_RAW_NEG(dst_reg, dst_reg));
+			break;
+		case BPF_ALU64 | BPF_NEG: /* dst = -dst */
+			EMIT(PPC_RAW_SUBFIC(dst_reg, dst_reg, 0));
+			EMIT(PPC_RAW_SUBFZE(dst_reg_h, dst_reg_h));
+			break;
+
+		/*
+		 * Logical operations: AND/OR/XOR/[A]LSH/[A]RSH
+		 */
+		case BPF_ALU64 | BPF_AND | BPF_X: /* dst = dst & src */
+			EMIT(PPC_RAW_AND(dst_reg, dst_reg, src_reg));
+			EMIT(PPC_RAW_AND(dst_reg_h, dst_reg_h, src_reg_h));
+			break;
+		case BPF_ALU | BPF_AND | BPF_X: /* (u32) dst = dst & src */
+			EMIT(PPC_RAW_AND(dst_reg, dst_reg, src_reg));
+			break;
+		case BPF_ALU64 | BPF_AND | BPF_K: /* dst = dst & imm */
+			if (imm >= 0)
+				EMIT(PPC_RAW_LI(dst_reg_h, 0));
+			fallthrough;
+		case BPF_ALU | BPF_AND | BPF_K: /* (u32) dst = dst & imm */
+			if (!IMM_H(imm)) {
+				EMIT(PPC_RAW_ANDI(dst_reg, dst_reg, IMM_L(imm)));
+			} else if (!IMM_L(imm)) {
+				EMIT(PPC_RAW_ANDIS(dst_reg, dst_reg, IMM_H(imm)));
+			} else if (imm == (((1 << fls(imm)) - 1) ^ ((1 << (ffs(i) - 1)) - 1))) {
+				EMIT(PPC_RAW_RLWINM(dst_reg, dst_reg, 0,
+						    32 - fls(imm), 32 - ffs(imm)));
+			} else {
+				PPC_LI32(__REG_R0, imm);
+				EMIT(PPC_RAW_AND(dst_reg, dst_reg, __REG_R0));
+			}
+			break;
+		case BPF_ALU64 | BPF_OR | BPF_X: /* dst = dst | src */
+			EMIT(PPC_RAW_OR(dst_reg, dst_reg, src_reg));
+			EMIT(PPC_RAW_OR(dst_reg_h, dst_reg_h, src_reg_h));
+			break;
+		case BPF_ALU | BPF_OR | BPF_X: /* dst = (u32) dst | (u32) src */
+			EMIT(PPC_RAW_OR(dst_reg, dst_reg, src_reg));
+			break;
+		case BPF_ALU64 | BPF_OR | BPF_K:/* dst = dst | imm */
+			/* Sign-extended */
+			if (imm < 0)
+				EMIT(PPC_RAW_LI(dst_reg_h, -1));
+			fallthrough;
+		case BPF_ALU | BPF_OR | BPF_K:/* dst = (u32) dst | (u32) imm */
+			if (IMM_L(imm))
+				EMIT(PPC_RAW_ORI(dst_reg, dst_reg, IMM_L(imm)));
+			if (IMM_H(imm))
+				EMIT(PPC_RAW_ORIS(dst_reg, dst_reg, IMM_H(imm)));
+			break;
+		case BPF_ALU64 | BPF_XOR | BPF_X: /* dst ^= src */
+			if (dst_reg == src_reg) {
+				EMIT(PPC_RAW_LI(dst_reg, 0));
+				EMIT(PPC_RAW_LI(dst_reg_h, 0));
+			} else {
+				EMIT(PPC_RAW_XOR(dst_reg, dst_reg, src_reg));
+				EMIT(PPC_RAW_XOR(dst_reg_h, dst_reg_h, src_reg_h));
+			}
+			break;
+		case BPF_ALU | BPF_XOR | BPF_X: /* (u32) dst ^= src */
+			if (dst_reg == src_reg)
+				EMIT(PPC_RAW_LI(dst_reg, 0));
+			else
+				EMIT(PPC_RAW_XOR(dst_reg, dst_reg, src_reg));
+			break;
+		case BPF_ALU64 | BPF_XOR | BPF_K: /* dst ^= imm */
+			if (imm < 0)
+				EMIT(PPC_RAW_NOR(dst_reg_h, dst_reg_h, dst_reg_h));
+			fallthrough;
+		case BPF_ALU | BPF_XOR | BPF_K: /* (u32) dst ^= (u32) imm */
+			if (IMM_L(imm))
+				EMIT(PPC_RAW_XORI(dst_reg, dst_reg, IMM_L(imm)));
+			if (IMM_H(imm))
+				EMIT(PPC_RAW_XORIS(dst_reg, dst_reg, IMM_H(imm)));
+			break;
+		case BPF_ALU | BPF_LSH | BPF_X: /* (u32) dst <<= (u32) src */
+			EMIT(PPC_RAW_SLW(dst_reg, dst_reg, src_reg));
+			break;
+		case BPF_ALU64 | BPF_LSH | BPF_X: /* dst <<= src; */
+			EMIT(PPC_RAW_ADDIC_DOT(__REG_R0, src_reg, -32));
+			PPC_BCC_SHORT(COND_LT, (ctx->idx + 4) * 4);
+			EMIT(PPC_RAW_SLW(dst_reg_h, dst_reg, __REG_R0));
+			EMIT(PPC_RAW_LI(dst_reg, 0));
+			PPC_JMP((ctx->idx + 6) * 4);
+			EMIT(PPC_RAW_SUBFIC(__REG_R0, src_reg, 32));
+			EMIT(PPC_RAW_SLW(dst_reg_h, dst_reg_h, src_reg));
+			EMIT(PPC_RAW_SRW(__REG_R0, dst_reg, __REG_R0));
+			EMIT(PPC_RAW_SLW(dst_reg, dst_reg, src_reg));
+			EMIT(PPC_RAW_OR(dst_reg_h, dst_reg_h, __REG_R0));
+			break;
+		case BPF_ALU | BPF_LSH | BPF_K: /* (u32) dst <<== (u32) imm */
+			if (!imm)
+				break;
+			EMIT(PPC_RAW_SLWI(dst_reg, dst_reg, imm));
+			break;
+		case BPF_ALU64 | BPF_LSH | BPF_K: /* dst <<== imm */
+			if (imm < 0)
+				return -EINVAL;
+			if (!imm)
+				break;
+			if (imm < 32) {
+				EMIT(PPC_RAW_RLWINM(dst_reg_h, dst_reg_h, imm, 0, 31 - imm));
+				EMIT(PPC_RAW_RLWIMI(dst_reg_h, dst_reg, imm, 32 - imm, 31));
+				EMIT(PPC_RAW_RLWINM(dst_reg, dst_reg, imm, 0, 31 - imm));
+				break;
+			}
+			if (imm < 64)
+				EMIT(PPC_RAW_RLWINM(dst_reg_h, dst_reg, imm, 0, 31 - imm));
+			else
+				EMIT(PPC_RAW_LI(dst_reg_h, 0));
+			EMIT(PPC_RAW_LI(dst_reg, 0));
+			break;
+		case BPF_ALU | BPF_RSH | BPF_X: /* (u32) dst >>= (u32) src */
+			EMIT(PPC_RAW_SRW(dst_reg, dst_reg, src_reg));
+			break;
+		case BPF_ALU64 | BPF_RSH | BPF_X: /* dst >>= src */
+			EMIT(PPC_RAW_ADDIC_DOT(__REG_R0, src_reg, -32));
+			PPC_BCC_SHORT(COND_LT, (ctx->idx + 4) * 4);
+			EMIT(PPC_RAW_SRW(dst_reg, dst_reg_h, __REG_R0));
+			EMIT(PPC_RAW_LI(dst_reg_h, 0));
+			PPC_JMP((ctx->idx + 6) * 4);
+			EMIT(PPC_RAW_SUBFIC(0, src_reg, 32));
+			EMIT(PPC_RAW_SRW(dst_reg, dst_reg, src_reg));
+			EMIT(PPC_RAW_SLW(__REG_R0, dst_reg_h, __REG_R0));
+			EMIT(PPC_RAW_SRW(dst_reg_h, dst_reg_h, src_reg));
+			EMIT(PPC_RAW_OR(dst_reg, dst_reg, __REG_R0));
+			break;
+		case BPF_ALU | BPF_RSH | BPF_K: /* (u32) dst >>= (u32) imm */
+			if (!imm)
+				break;
+			EMIT(PPC_RAW_SRWI(dst_reg, dst_reg, imm));
+			break;
+		case BPF_ALU64 | BPF_RSH | BPF_K: /* dst >>= imm */
+			if (imm < 0)
+				return -EINVAL;
+			if (!imm)
+				break;
+			if (imm < 32) {
+				EMIT(PPC_RAW_RLWINM(dst_reg, dst_reg, 32 - imm, imm, 31));
+				EMIT(PPC_RAW_RLWIMI(dst_reg, dst_reg_h, 32 - imm, 0, imm - 1));
+				EMIT(PPC_RAW_RLWINM(dst_reg_h, dst_reg_h, 32 - imm, imm, 31));
+				break;
+			}
+			if (imm < 64)
+				EMIT(PPC_RAW_RLWINM(dst_reg, dst_reg_h, 64 - imm, imm - 32, 31));
+			else
+				EMIT(PPC_RAW_LI(dst_reg, 0));
+			EMIT(PPC_RAW_LI(dst_reg_h, 0));
+			break;
+		case BPF_ALU | BPF_ARSH | BPF_X: /* (s32) dst >>= src */
+			EMIT(PPC_RAW_SRAW(dst_reg_h, dst_reg, src_reg));
+			break;
+		case BPF_ALU64 | BPF_ARSH | BPF_X: /* (s64) dst >>= src */
+			EMIT(PPC_RAW_ADDIC_DOT(__REG_R0, src_reg, -32));
+			PPC_BCC_SHORT(COND_LT, (ctx->idx + 4) * 4);
+			EMIT(PPC_RAW_SRAW(dst_reg, dst_reg_h, __REG_R0));
+			EMIT(PPC_RAW_SRAWI(dst_reg_h, dst_reg_h, 31));
+			PPC_JMP((ctx->idx + 6) * 4);
+			EMIT(PPC_RAW_SUBFIC(0, src_reg, 32));
+			EMIT(PPC_RAW_SRW(dst_reg, dst_reg, src_reg));
+			EMIT(PPC_RAW_SLW(__REG_R0, dst_reg_h, __REG_R0));
+			EMIT(PPC_RAW_SRAW(dst_reg_h, dst_reg_h, src_reg));
+			EMIT(PPC_RAW_OR(dst_reg, dst_reg, __REG_R0));
+			break;
+		case BPF_ALU | BPF_ARSH | BPF_K: /* (s32) dst >>= imm */
+			if (!imm)
+				break;
+			EMIT(PPC_RAW_SRAWI(dst_reg, dst_reg, imm));
+			break;
+		case BPF_ALU64 | BPF_ARSH | BPF_K: /* (s64) dst >>= imm */
+			if (imm < 0)
+				return -EINVAL;
+			if (!imm)
+				break;
+			if (imm < 32) {
+				EMIT(PPC_RAW_RLWINM(dst_reg, dst_reg, 32 - imm, imm, 31));
+				EMIT(PPC_RAW_RLWIMI(dst_reg, dst_reg_h, 32 - imm, 0, imm - 1));
+				EMIT(PPC_RAW_SRAWI(dst_reg_h, dst_reg_h, imm));
+				break;
+			}
+			if (imm < 64)
+				EMIT(PPC_RAW_SRAWI(dst_reg, dst_reg_h, imm - 32));
+			else
+				EMIT(PPC_RAW_SRAWI(dst_reg, dst_reg_h, 31));
+			EMIT(PPC_RAW_SRAWI(dst_reg_h, dst_reg_h, 31));
+			break;
+
+		/*
+		 * MOV
+		 */
+		case BPF_ALU64 | BPF_MOV | BPF_X: /* dst = src */
+			if (dst_reg == src_reg)
+				break;
+			EMIT(PPC_RAW_MR(dst_reg, src_reg));
+			EMIT(PPC_RAW_MR(dst_reg_h, src_reg_h));
+			break;
+		case BPF_ALU | BPF_MOV | BPF_X: /* (u32) dst = src */
+			/* special mov32 for zext */
+			if (imm == 1)
+				EMIT(PPC_RAW_LI(dst_reg_h, 0));
+			else if (dst_reg != src_reg)
+				EMIT(PPC_RAW_MR(dst_reg, src_reg));
+			break;
+		case BPF_ALU64 | BPF_MOV | BPF_K: /* dst = (s64) imm */
+			PPC_LI32(dst_reg, imm);
+			PPC_EX32(dst_reg_h, imm);
+			break;
+		case BPF_ALU | BPF_MOV | BPF_K: /* (u32) dst = imm */
+			PPC_LI32(dst_reg, imm);
+			break;
+
+		/*
+		 * BPF_FROM_BE/LE
+		 */
+		case BPF_ALU | BPF_END | BPF_FROM_LE:
+			switch (imm) {
+			case 16:
+				/* Rotate 8 bits left & mask with 0x0000ff00 */
+				EMIT(PPC_RAW_RLWINM(__REG_R0, dst_reg, 8, 16, 23));
+				/* Rotate 8 bits right & insert LSB to reg */
+				EMIT(PPC_RAW_RLWIMI(__REG_R0, dst_reg, 24, 24, 31));
+				/* Move result back to dst_reg_h */
+				EMIT(PPC_RAW_MR(dst_reg, __REG_R0));
+				break;
+			case 32:
+				/*
+				 * Rotate word left by 8 bits:
+				 * 2 bytes are already in their final position
+				 * -- byte 2 and 4 (of bytes 1, 2, 3 and 4)
+				 */
+				EMIT(PPC_RAW_RLWINM(__REG_R0, dst_reg, 8, 0, 31));
+				/* Rotate 24 bits and insert byte 1 */
+				EMIT(PPC_RAW_RLWIMI(__REG_R0, dst_reg, 24, 0, 7));
+				/* Rotate 24 bits and insert byte 3 */
+				EMIT(PPC_RAW_RLWIMI(__REG_R0, dst_reg, 24, 16, 23));
+				EMIT(PPC_RAW_MR(dst_reg, __REG_R0));
+				break;
+			case 64:
+				bpf_set_seen_register(ctx, tmp_reg);
+				EMIT(PPC_RAW_RLWINM(tmp_reg, dst_reg, 8, 0, 31));
+				EMIT(PPC_RAW_RLWINM(__REG_R0, dst_reg_h, 8, 0, 31));
+				/* Rotate 24 bits and insert byte 1 */
+				EMIT(PPC_RAW_RLWIMI(tmp_reg, dst_reg, 24, 0, 7));
+				EMIT(PPC_RAW_RLWIMI(__REG_R0, dst_reg_h, 24, 0, 7));
+				/* Rotate 24 bits and insert byte 3 */
+				EMIT(PPC_RAW_RLWIMI(tmp_reg, dst_reg, 24, 16, 23));
+				EMIT(PPC_RAW_RLWIMI(__REG_R0, dst_reg_h, 24, 16, 23));
+				EMIT(PPC_RAW_MR(dst_reg, __REG_R0));
+				EMIT(PPC_RAW_MR(dst_reg_h, tmp_reg));
+				break;
+			}
+			break;
+		case BPF_ALU | BPF_END | BPF_FROM_BE:
+			switch (imm) {
+			case 16:
+				/* zero-extend 16 bits into 32 bits */
+				EMIT(PPC_RAW_RLWINM(dst_reg, dst_reg, 0, 16, 31));
+				break;
+			case 32:
+			case 64:
+				/* nop */
+				break;
+			}
+			break;
+
+		/*
+		 * BPF_ST(X)
+		 */
+		case BPF_STX | BPF_MEM | BPF_B: /* *(u8 *)(dst + off) = src */
+			EMIT(PPC_RAW_STB(src_reg, dst_reg, off));
+			break;
+		case BPF_ST | BPF_MEM | BPF_B: /* *(u8 *)(dst + off) = imm */
+			PPC_LI32(__REG_R0, imm);
+			EMIT(PPC_RAW_STB(__REG_R0, dst_reg, off));
+			break;
+		case BPF_STX | BPF_MEM | BPF_H: /* (u16 *)(dst + off) = src */
+			EMIT(PPC_RAW_STH(src_reg, dst_reg, off));
+			break;
+		case BPF_ST | BPF_MEM | BPF_H: /* (u16 *)(dst + off) = imm */
+			PPC_LI32(__REG_R0, imm);
+			EMIT(PPC_RAW_STH(__REG_R0, dst_reg, off));
+			break;
+		case BPF_STX | BPF_MEM | BPF_W: /* *(u32 *)(dst + off) = src */
+			EMIT(PPC_RAW_STW(src_reg, dst_reg, off));
+			break;
+		case BPF_ST | BPF_MEM | BPF_W: /* *(u32 *)(dst + off) = imm */
+			PPC_LI32(__REG_R0, imm);
+			EMIT(PPC_RAW_STW(__REG_R0, dst_reg, off));
+			break;
+		case BPF_STX | BPF_MEM | BPF_DW: /* (u64 *)(dst + off) = src */
+			EMIT(PPC_RAW_STW(src_reg_h, dst_reg, off));
+			EMIT(PPC_RAW_STW(src_reg, dst_reg, off + 4));
+			break;
+		case BPF_ST | BPF_MEM | BPF_DW: /* *(u64 *)(dst + off) = imm */
+			PPC_LI32(__REG_R0, imm);
+			EMIT(PPC_RAW_STW(__REG_R0, dst_reg, off + 4));
+			PPC_EX32(__REG_R0, imm);
+			EMIT(PPC_RAW_STW(__REG_R0, dst_reg, off));
+			break;
+
+		/*
+		 * BPF_STX XADD (atomic_add)
+		 */
+		case BPF_STX | BPF_XADD | BPF_W: /* *(u32 *)(dst + off) += src */
+			bpf_set_seen_register(ctx, tmp_reg);
+			/* Get offset into TMP_REG */
+			EMIT(PPC_RAW_LI(tmp_reg, off));
+			/* load value from memory into r0 */
+			EMIT(PPC_RAW_LWARX(__REG_R0, tmp_reg, dst_reg, 0));
+			/* add value from src_reg into this */
+			EMIT(PPC_RAW_ADD(__REG_R0, __REG_R0, src_reg));
+			/* store result back */
+			EMIT(PPC_RAW_STWCX(__REG_R0, tmp_reg, dst_reg));
+			/* we're done if this succeeded */
+			PPC_BCC_SHORT(COND_NE, (ctx->idx - 3) * 4);
+			break;
+
+		case BPF_STX | BPF_XADD | BPF_DW: /* *(u64 *)(dst + off) += src */
+			return -EOPNOTSUPP;
+
+		/*
+		 * BPF_LDX
+		 */
+		case BPF_LDX | BPF_MEM | BPF_B: /* dst = *(u8 *)(ul) (src + off) */
+			EMIT(PPC_RAW_LBZ(dst_reg, src_reg, off));
+			if (!fp->aux->verifier_zext)
+				EMIT(PPC_RAW_LI(dst_reg_h, 0));
+			break;
+		case BPF_LDX | BPF_MEM | BPF_H: /* dst = *(u16 *)(ul) (src + off) */
+			EMIT(PPC_RAW_LHZ(dst_reg, src_reg, off));
+			if (!fp->aux->verifier_zext)
+				EMIT(PPC_RAW_LI(dst_reg_h, 0));
+			break;
+		case BPF_LDX | BPF_MEM | BPF_W: /* dst = *(u32 *)(ul) (src + off) */
+			EMIT(PPC_RAW_LWZ(dst_reg, src_reg, off));
+			if (!fp->aux->verifier_zext)
+				EMIT(PPC_RAW_LI(dst_reg_h, 0));
+			break;
+		case BPF_LDX | BPF_MEM | BPF_DW: /* dst = *(u64 *)(ul) (src + off) */
+			EMIT(PPC_RAW_LWZ(dst_reg_h, src_reg, off));
+			EMIT(PPC_RAW_LWZ(dst_reg, src_reg, off + 4));
+			break;
+
+		/*
+		 * Doubleword load
+		 * 16 byte instruction that uses two 'struct bpf_insn'
+		 */
+		case BPF_LD | BPF_IMM | BPF_DW: /* dst = (u64) imm */
+			PPC_LI32(dst_reg_h, (u32)insn[i + 1].imm);
+			PPC_LI32(dst_reg, (u32)insn[i].imm);
+			/* Adjust for two bpf instructions */
+			addrs[++i] = ctx->idx * 4;
+			break;
+
+		/*
+		 * Return/Exit
+		 */
+		case BPF_JMP | BPF_EXIT:
+			/*
+			 * If this isn't the very last instruction, branch to
+			 * the epilogue. If we _are_ the last instruction,
+			 * we'll just fall through to the epilogue.
+			 */
+			if (i != flen - 1)
+				PPC_JMP(exit_addr);
+			/* else fall through to the epilogue */
+			break;
+
+		/*
+		 * Call kernel helper or bpf function
+		 */
+		case BPF_JMP | BPF_CALL:
+			ctx->seen |= SEEN_FUNC;
+
+			ret = bpf_jit_get_func_addr(fp, &insn[i], extra_pass,
+						    &func_addr, &func_addr_fixed);
+			if (ret < 0)
+				return ret;
+
+			if (bpf_is_seen_register(ctx, b2p[BPF_REG_5])) {
+				EMIT(PPC_RAW_STW(b2p[BPF_REG_5] - 1, __REG_R1, 8));
+				EMIT(PPC_RAW_STW(b2p[BPF_REG_5], __REG_R1, 12));
+			}
+
+			bpf_jit_emit_func_call_rel(image, ctx, func_addr);
+
+			EMIT(PPC_RAW_MR(b2p[BPF_REG_0] - 1, __REG_R3));
+			EMIT(PPC_RAW_MR(b2p[BPF_REG_0], __REG_R4));
+			break;
+
+		/*
+		 * Jumps and branches
+		 */
+		case BPF_JMP | BPF_JA:
+			PPC_JMP(addrs[i + 1 + off]);
+			break;
+
+		case BPF_JMP | BPF_JGT | BPF_K:
+		case BPF_JMP | BPF_JGT | BPF_X:
+		case BPF_JMP | BPF_JSGT | BPF_K:
+		case BPF_JMP | BPF_JSGT | BPF_X:
+		case BPF_JMP32 | BPF_JGT | BPF_K:
+		case BPF_JMP32 | BPF_JGT | BPF_X:
+		case BPF_JMP32 | BPF_JSGT | BPF_K:
+		case BPF_JMP32 | BPF_JSGT | BPF_X:
+			true_cond = COND_GT;
+			goto cond_branch;
+		case BPF_JMP | BPF_JLT | BPF_K:
+		case BPF_JMP | BPF_JLT | BPF_X:
+		case BPF_JMP | BPF_JSLT | BPF_K:
+		case BPF_JMP | BPF_JSLT | BPF_X:
+		case BPF_JMP32 | BPF_JLT | BPF_K:
+		case BPF_JMP32 | BPF_JLT | BPF_X:
+		case BPF_JMP32 | BPF_JSLT | BPF_K:
+		case BPF_JMP32 | BPF_JSLT | BPF_X:
+			true_cond = COND_LT;
+			goto cond_branch;
+		case BPF_JMP | BPF_JGE | BPF_K:
+		case BPF_JMP | BPF_JGE | BPF_X:
+		case BPF_JMP | BPF_JSGE | BPF_K:
+		case BPF_JMP | BPF_JSGE | BPF_X:
+		case BPF_JMP32 | BPF_JGE | BPF_K:
+		case BPF_JMP32 | BPF_JGE | BPF_X:
+		case BPF_JMP32 | BPF_JSGE | BPF_K:
+		case BPF_JMP32 | BPF_JSGE | BPF_X:
+			true_cond = COND_GE;
+			goto cond_branch;
+		case BPF_JMP | BPF_JLE | BPF_K:
+		case BPF_JMP | BPF_JLE | BPF_X:
+		case BPF_JMP | BPF_JSLE | BPF_K:
+		case BPF_JMP | BPF_JSLE | BPF_X:
+		case BPF_JMP32 | BPF_JLE | BPF_K:
+		case BPF_JMP32 | BPF_JLE | BPF_X:
+		case BPF_JMP32 | BPF_JSLE | BPF_K:
+		case BPF_JMP32 | BPF_JSLE | BPF_X:
+			true_cond = COND_LE;
+			goto cond_branch;
+		case BPF_JMP | BPF_JEQ | BPF_K:
+		case BPF_JMP | BPF_JEQ | BPF_X:
+		case BPF_JMP32 | BPF_JEQ | BPF_K:
+		case BPF_JMP32 | BPF_JEQ | BPF_X:
+			true_cond = COND_EQ;
+			goto cond_branch;
+		case BPF_JMP | BPF_JNE | BPF_K:
+		case BPF_JMP | BPF_JNE | BPF_X:
+		case BPF_JMP32 | BPF_JNE | BPF_K:
+		case BPF_JMP32 | BPF_JNE | BPF_X:
+			true_cond = COND_NE;
+			goto cond_branch;
+		case BPF_JMP | BPF_JSET | BPF_K:
+		case BPF_JMP | BPF_JSET | BPF_X:
+		case BPF_JMP32 | BPF_JSET | BPF_K:
+		case BPF_JMP32 | BPF_JSET | BPF_X:
+			true_cond = COND_NE;
+			/* fallthrough; */
+
+cond_branch:
+			switch (code) {
+			case BPF_JMP | BPF_JGT | BPF_X:
+			case BPF_JMP | BPF_JLT | BPF_X:
+			case BPF_JMP | BPF_JGE | BPF_X:
+			case BPF_JMP | BPF_JLE | BPF_X:
+			case BPF_JMP | BPF_JEQ | BPF_X:
+			case BPF_JMP | BPF_JNE | BPF_X:
+				/* unsigned comparison */
+				EMIT(PPC_RAW_CMPLW(dst_reg_h, src_reg_h));
+				PPC_BCC_SHORT(COND_NE, (ctx->idx + 2) * 4);
+				EMIT(PPC_RAW_CMPLW(dst_reg, src_reg));
+				break;
+			case BPF_JMP32 | BPF_JGT | BPF_X:
+			case BPF_JMP32 | BPF_JLT | BPF_X:
+			case BPF_JMP32 | BPF_JGE | BPF_X:
+			case BPF_JMP32 | BPF_JLE | BPF_X:
+			case BPF_JMP32 | BPF_JEQ | BPF_X:
+			case BPF_JMP32 | BPF_JNE | BPF_X:
+				/* unsigned comparison */
+				EMIT(PPC_RAW_CMPLW(dst_reg, src_reg));
+				break;
+			case BPF_JMP | BPF_JSGT | BPF_X:
+			case BPF_JMP | BPF_JSLT | BPF_X:
+			case BPF_JMP | BPF_JSGE | BPF_X:
+			case BPF_JMP | BPF_JSLE | BPF_X:
+				/* signed comparison */
+				EMIT(PPC_RAW_CMPW(dst_reg_h, src_reg_h));
+				PPC_BCC_SHORT(COND_NE, (ctx->idx + 2) * 4);
+				EMIT(PPC_RAW_CMPLW(dst_reg, src_reg));
+				break;
+			case BPF_JMP32 | BPF_JSGT | BPF_X:
+			case BPF_JMP32 | BPF_JSLT | BPF_X:
+			case BPF_JMP32 | BPF_JSGE | BPF_X:
+			case BPF_JMP32 | BPF_JSLE | BPF_X:
+				/* signed comparison */
+				EMIT(PPC_RAW_CMPW(dst_reg, src_reg));
+				break;
+			case BPF_JMP | BPF_JSET | BPF_X:
+				EMIT(PPC_RAW_AND_DOT(__REG_R0, dst_reg_h, src_reg_h));
+				PPC_BCC_SHORT(COND_NE, (ctx->idx + 2) * 4);
+				EMIT(PPC_RAW_AND_DOT(__REG_R0, dst_reg, src_reg));
+				break;
+			case BPF_JMP32 | BPF_JSET | BPF_X: {
+				EMIT(PPC_RAW_AND_DOT(__REG_R0, dst_reg, src_reg));
+				break;
+			case BPF_JMP | BPF_JNE | BPF_K:
+			case BPF_JMP | BPF_JEQ | BPF_K:
+			case BPF_JMP | BPF_JGT | BPF_K:
+			case BPF_JMP | BPF_JLT | BPF_K:
+			case BPF_JMP | BPF_JGE | BPF_K:
+			case BPF_JMP | BPF_JLE | BPF_K:
+				/*
+				 * Need sign-extended load, so only positive
+				 * values can be used as imm in cmplwi
+				 */
+				if (imm >= 0 && imm < 32768) {
+					EMIT(PPC_RAW_CMPLWI(dst_reg_h, 0));
+					PPC_BCC_SHORT(COND_NE, (ctx->idx + 2) * 4);
+					EMIT(PPC_RAW_CMPLWI(dst_reg, imm));
+				} else {
+					/* sign-extending load ... but unsigned comparison */
+					PPC_EX32(__REG_R0, imm);
+					EMIT(PPC_RAW_CMPLW(dst_reg_h, __REG_R0));
+					PPC_LI32(__REG_R0, imm);
+					PPC_BCC_SHORT(COND_NE, (ctx->idx + 2) * 4);
+					EMIT(PPC_RAW_CMPLW(dst_reg, __REG_R0));
+				}
+				break;
+			case BPF_JMP32 | BPF_JNE | BPF_K:
+			case BPF_JMP32 | BPF_JEQ | BPF_K:
+			case BPF_JMP32 | BPF_JGT | BPF_K:
+			case BPF_JMP32 | BPF_JLT | BPF_K:
+			case BPF_JMP32 | BPF_JGE | BPF_K:
+			case BPF_JMP32 | BPF_JLE | BPF_K:
+				if (imm >= 0 && imm < 65536) {
+					EMIT(PPC_RAW_CMPLWI(dst_reg, imm));
+				} else {
+					PPC_LI32(__REG_R0, imm);
+					EMIT(PPC_RAW_CMPLW(dst_reg, __REG_R0));
+				}
+				break;
+			}
+			case BPF_JMP | BPF_JSGT | BPF_K:
+			case BPF_JMP | BPF_JSLT | BPF_K:
+			case BPF_JMP | BPF_JSGE | BPF_K:
+			case BPF_JMP | BPF_JSLE | BPF_K:
+				if (imm >= 0 && imm < 65536) {
+					EMIT(PPC_RAW_CMPWI(dst_reg_h, imm < 0 ? -1 : 0));
+					PPC_BCC_SHORT(COND_NE, (ctx->idx + 2) * 4);
+					EMIT(PPC_RAW_CMPLWI(dst_reg, imm));
+				} else {
+					/* sign-extending load */
+					EMIT(PPC_RAW_CMPWI(dst_reg_h, imm < 0 ? -1 : 0));
+					PPC_LI32(__REG_R0, imm);
+					PPC_BCC_SHORT(COND_NE, (ctx->idx + 2) * 4);
+					EMIT(PPC_RAW_CMPLW(dst_reg, __REG_R0));
+				}
+				break;
+			case BPF_JMP32 | BPF_JSGT | BPF_K:
+			case BPF_JMP32 | BPF_JSLT | BPF_K:
+			case BPF_JMP32 | BPF_JSGE | BPF_K:
+			case BPF_JMP32 | BPF_JSLE | BPF_K:
+				/*
+				 * signed comparison, so any 16-bit value
+				 * can be used in cmpwi
+				 */
+				if (imm >= -32768 && imm < 32768) {
+					EMIT(PPC_RAW_CMPWI(dst_reg, imm));
+				} else {
+					/* sign-extending load */
+					PPC_LI32(__REG_R0, imm);
+					EMIT(PPC_RAW_CMPW(dst_reg, __REG_R0));
+				}
+				break;
+			case BPF_JMP | BPF_JSET | BPF_K:
+				/* andi does not sign-extend the immediate */
+				if (imm >= 0 && imm < 32768) {
+					/* PPC_ANDI is _only/always_ dot-form */
+					EMIT(PPC_RAW_ANDI(__REG_R0, dst_reg, imm));
+				} else {
+					PPC_LI32(__REG_R0, imm);
+					if (imm < 0) {
+						EMIT(PPC_RAW_CMPWI(dst_reg_h, 0));
+						PPC_BCC_SHORT(COND_NE, (ctx->idx + 2) * 4);
+					}
+					EMIT(PPC_RAW_AND_DOT(__REG_R0, dst_reg, __REG_R0));
+				}
+				break;
+			case BPF_JMP32 | BPF_JSET | BPF_K:
+				/* andi does not sign-extend the immediate */
+				if (imm >= -32768 && imm < 32768) {
+					/* PPC_ANDI is _only/always_ dot-form */
+					EMIT(PPC_RAW_ANDI(__REG_R0, dst_reg, imm));
+				} else {
+					PPC_LI32(__REG_R0, imm);
+					EMIT(PPC_RAW_AND_DOT(__REG_R0, dst_reg, __REG_R0));
+				}
+				break;
+			}
+			PPC_BCC(true_cond, addrs[i + 1 + off]);
+			break;
+
+		/*
+		 * Tail call
+		 */
+		case BPF_JMP | BPF_TAIL_CALL:
+			ctx->seen |= SEEN_TAILCALL;
+			bpf_jit_emit_tail_call(image, ctx, addrs[i + 1]);
+			break;
+
+		default:
+			/*
+			 * The filter contains something cruel & unusual.
+			 * We don't handle it, but also there shouldn't be
+			 * anything missing from our list.
+			 */
+			pr_err_ratelimited("eBPF filter opcode %04x (@%d) unsupported\n", code, i);
+			return -EOPNOTSUPP;
+		}
+		if (BPF_CLASS(code) == BPF_ALU && !fp->aux->verifier_zext &&
+		    !insn_is_zext(&insn[i + 1]))
+			EMIT(PPC_RAW_LI(dst_reg_h, 0));
+	}
+
+	/* Set end-of-body-code address for exit. */
+	addrs[i] = ctx->idx * 4;
+
+	return 0;
+}
-- 
2.25.0



