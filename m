Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13C68422E7E
	for <lists+bpf@lfdr.de>; Tue,  5 Oct 2021 18:54:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236648AbhJEQ4W (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 5 Oct 2021 12:56:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236644AbhJEQ4U (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 5 Oct 2021 12:56:20 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77BA7C061766
        for <bpf@vger.kernel.org>; Tue,  5 Oct 2021 09:54:28 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id g8so1335965edt.7
        for <bpf@vger.kernel.org>; Tue, 05 Oct 2021 09:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anyfinetworks-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0bJJ5op3S8KzZLU4wEQHbfJ00f3b73pPFSVbVpTsH94=;
        b=b/A/KpjVitIESAqOwNQTujODvhaGqSfqBtfKhdRmI8jHb6ZbnmUAE/Ru0BubegZDdq
         p6okQIeXzA69KiPVEyhdhWSLqcFMn7ecnk9JmYCW9fvSXE8/1Tf4irvHkdhKa8P+P2xK
         kq1f/NOEK9jb6XC7IlxL4sN0nn0iejO5KVXOkZvWZkudXz9ebrorXA7B3tdGmLvry4WW
         8DKTHUYr46GicKvwe+Kgg48v9PyGQFX/66YB+4z4gunLfh3AtZciNvXrP3fGvFzRdwBA
         epJTfzCoEz61v6vAsCcABaqe6epCTh4lF1c7KGXQ7GX9emrg0RJvSO6C+8nJIVn8UDa7
         L1sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0bJJ5op3S8KzZLU4wEQHbfJ00f3b73pPFSVbVpTsH94=;
        b=Dx5jpoJvVCaBCtxvPmgpfK9XBH9B9pmUfWtCm4+LlTc/iUvyTeP2R7PYO+dCXeX0j9
         DelI9FjAZljWPWrwfvxHUpNFuBhwF91/b6YcF+kb+EQmV91uECRfcS+yoebynFQ74kG4
         QSojRUUDh96UTSilxuv6iK3RU4N19cY6hSenUgFQ78qThKSdajCnRj1yp6teYTMzdqdp
         YTwuY5YW0I0LsnDcyjEIAl69oTqy6kCsQK/szmUIlX5riSxoZSiRl/MR22ZlU4gUUn9i
         A9qeiTleuzIWmZUjj3e4WSPJyKdPxqBatAqdX7Sax43+TKpZH7GGtntXXPB1Gypj+dxl
         F6iQ==
X-Gm-Message-State: AOAM531R13bHrsTFB6/DcidolNWCJNiIOBo+ZiCDZOp/F17JJVdP0OKO
        NeRWLabx34Um4/54ECxxaFHL0Q==
X-Google-Smtp-Source: ABdhPJz/ApI0yYZC5b23PIZCSth1vyW36TZV3h8+pXSTpnmEV4PASpCnYbiwyfM9ITu0EyOJK/1qzA==
X-Received: by 2002:a17:906:2441:: with SMTP id a1mr25801285ejb.414.1633452865924;
        Tue, 05 Oct 2021 09:54:25 -0700 (PDT)
Received: from anpc2.lan (static-213-115-136-2.sme.telenor.se. [213.115.136.2])
        by smtp.gmail.com with ESMTPSA id x16sm3447818ejj.8.2021.10.05.09.54.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 09:54:25 -0700 (PDT)
From:   Johan Almbladh <johan.almbladh@anyfinetworks.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        paulburton@kernel.org
Cc:     kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org,
        tsbogend@alpha.franken.de, chenhuacai@kernel.org,
        jiaxun.yang@flygoat.com, yangtiezhu@loongson.cn,
        tony.ambardar@gmail.com, bpf@vger.kernel.org,
        linux-mips@vger.kernel.org, netdev@vger.kernel.org,
        Johan Almbladh <johan.almbladh@anyfinetworks.com>
Subject: [PATCH 3/7] mips: bpf: Add eBPF JIT for 32-bit MIPS
Date:   Tue,  5 Oct 2021 18:54:04 +0200
Message-Id: <20211005165408.2305108-4-johan.almbladh@anyfinetworks.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211005165408.2305108-1-johan.almbladh@anyfinetworks.com>
References: <20211005165408.2305108-1-johan.almbladh@anyfinetworks.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This is an implementation of an eBPF JIT for 32-bit MIPS I-V and MIPS32.
The implementation supports all 32-bit and 64-bit ALU and JMP operations,
including the recently-added atomics. 64-bit div/mod and 64-bit atomics
are implemented using function calls to math64 and atomic64 functions,
respectively. All 32-bit operations are implemented natively by the JIT,
except if the CPU lacks ll/sc instructions.

Register mapping
================
All 64-bit eBPF registers are mapped to native 32-bit MIPS register pairs,
and does not use any stack scratch space for register swapping. This means
that all eBPF register data is kept in CPU registers all the time, and
this simplifies the register management a lot. It also reduces the JIT's
pressure on temporary registers since we do not have to move data around.

Native register pairs are ordered according to CPU endiannes, following
the O32 calling convention for passing 64-bit arguments and return values.
The eBPF return value, arguments and callee-saved registers are mapped to
their native MIPS equivalents.

Since the 32 highest bits in the eBPF FP (frame pointer) register are
always zero, only one general-purpose register is actually needed for the
mapping. The MIPS fp register is used for this purpose. The high bits are
mapped to MIPS register r0. This saves us one CPU register, which is much
needed for temporaries, while still allowing us to treat the R10 (FP)
register just like any other eBPF register in the JIT.

The MIPS gp (global pointer) and at (assembler temporary) registers are
used as internal temporary registers for constant blinding. CPU registers
t6-t9 are used internally by the JIT when constructing more complex 64-bit
operations. This is precisely what is needed - two registers to store an
operand value, and two more as scratch registers when performing the
operation.

The register mapping is shown below.

    R0 - $v1, $v0   return value
    R1 - $a1, $a0   argument 1, passed in registers
    R2 - $a3, $a2   argument 2, passed in registers
    R3 - $t1, $t0   argument 3, passed on stack
    R4 - $t3, $t2   argument 4, passed on stack
    R5 - $t4, $t3   argument 5, passed on stack
    R6 - $s1, $s0   callee-saved
    R7 - $s3, $s2   callee-saved
    R8 - $s5, $s4   callee-saved
    R9 - $s7, $s6   callee-saved
    FP - $r0, $fp   32-bit frame pointer
    AX - $gp, $at   constant-blinding
         $t6 - $t9  unallocated, JIT temporaries

Jump offsets
============
The JIT tries to map all conditional JMP operations to MIPS conditional
PC-relative branches. The MIPS branch offset field is 18 bits, in bytes,
which is equivalent to the eBPF 16-bit instruction offset. However, since
the JIT may emit more than one CPU instruction per eBPF instruction, the
field width may overflow. If that happens, the JIT converts the long
conditional jump to a short PC-relative branch with the condition
inverted, jumping over a long unconditional absolute jmp (j).

This conversion will change the instruction offset mapping used for jumps,
and may in turn result in more branch offset overflows. The JIT therefore
dry-runs the translation until no more branches are converted and the
offsets do not change anymore. There is an upper bound on this of course,
and if the JIT hits that limit, the last two iterations are run with all
branches being converted.

Tail call count
===============
The current tail call count is stored in the 16-byte area of the caller's
stack frame that is reserved for the callee in the o32 ABI. The value is
initialized in the prologue, and propagated to the tail-callee by skipping
the initialization instructions when emitting the tail call.

Signed-off-by: Johan Almbladh <johan.almbladh@anyfinetworks.com>
---
 arch/mips/net/Makefile         |    7 +-
 arch/mips/net/bpf_jit_comp.c   | 1032 +++++++++++++++++
 arch/mips/net/bpf_jit_comp.h   |  211 ++++
 arch/mips/net/bpf_jit_comp32.c | 1899 ++++++++++++++++++++++++++++++++
 4 files changed, 3148 insertions(+), 1 deletion(-)
 create mode 100644 arch/mips/net/bpf_jit_comp.c
 create mode 100644 arch/mips/net/bpf_jit_comp.h
 create mode 100644 arch/mips/net/bpf_jit_comp32.c

diff --git a/arch/mips/net/Makefile b/arch/mips/net/Makefile
index d55912349039..e057ee4ba75e 100644
--- a/arch/mips/net/Makefile
+++ b/arch/mips/net/Makefile
@@ -2,4 +2,9 @@
 # MIPS networking code
 
 obj-$(CONFIG_MIPS_CBPF_JIT) += bpf_jit.o bpf_jit_asm.o
-obj-$(CONFIG_MIPS_EBPF_JIT) += ebpf_jit.o
+
+ifeq ($(CONFIG_32BIT),y)
+        obj-$(CONFIG_MIPS_EBPF_JIT) += bpf_jit_comp.o bpf_jit_comp32.o
+else
+        obj-$(CONFIG_MIPS_EBPF_JIT) += ebpf_jit.o
+endif
diff --git a/arch/mips/net/bpf_jit_comp.c b/arch/mips/net/bpf_jit_comp.c
new file mode 100644
index 000000000000..7eb95fc57710
--- /dev/null
+++ b/arch/mips/net/bpf_jit_comp.c
@@ -0,0 +1,1032 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Just-In-Time compiler for eBPF bytecode on MIPS.
+ * Implementation of JIT functions common to 32-bit and 64-bit CPUs.
+ *
+ * Copyright (c) 2021 Anyfi Networks AB.
+ * Author: Johan Almbladh <johan.almbladh@gmail.com>
+ *
+ * Based on code and ideas from
+ * Copyright (c) 2017 Cavium, Inc.
+ * Copyright (c) 2017 Shubham Bansal <illusionist.neo@gmail.com>
+ * Copyright (c) 2011 Mircea Gherzan <mgherzan@gmail.com>
+ */
+
+/*
+ * Code overview
+ * =============
+ *
+ * - bpf_jit_comp.h
+ *   Common definitions and utilities.
+ *
+ * - bpf_jit_comp.c
+ *   Implementation of JIT top-level logic and exported JIT API functions.
+ *   Implementation of internal operations shared by 32-bit and 64-bit code.
+ *   JMP and ALU JIT control code, register control code, shared ALU and
+ *   JMP/JMP32 JIT operations.
+ *
+ * - bpf_jit_comp32.c
+ *   Implementation of functions to JIT prologue, epilogue and a single eBPF
+ *   instruction for 32-bit MIPS CPUs. The functions use shared operations
+ *   where possible, and implement the rest for 32-bit MIPS such as ALU64
+ *   operations.
+ *
+ * - bpf_jit_comp64.c
+ *   Ditto, for 64-bit MIPS CPUs.
+ *
+ * Zero and sign extension
+ * ========================
+ * 32-bit MIPS instructions on 64-bit MIPS registers use sign extension,
+ * but the eBPF instruction set mandates zero extension. We let the verifier
+ * insert explicit zero-extensions after 32-bit ALU operations, both for
+ * 32-bit and 64-bit MIPS JITs. Conditional JMP32 operations on 64-bit MIPs
+ * are JITed with sign extensions inserted when so expected.
+ *
+ * ALU operations
+ * ==============
+ * ALU operations on 32/64-bit MIPS and ALU64 operations on 64-bit MIPS are
+ * JITed in the following steps. ALU64 operations on 32-bit MIPS are more
+ * complicated and therefore only processed by special implementations in
+ * step (3).
+ *
+ * 1) valid_alu_i:
+ *    Determine if an immediate operation can be emitted as such, or if
+ *    we must fall back to the register version.
+ *
+ * 2) rewrite_alu_i:
+ *    Convert BPF operation and immediate value to a canonical form for
+ *    JITing. In some degenerate cases this form may be a no-op.
+ *
+ * 3) emit_alu_{i,i64,r,64}:
+ *    Emit instructions for an ALU or ALU64 immediate or register operation.
+ *
+ * JMP operations
+ * ==============
+ * JMP and JMP32 operations require an JIT instruction offset table for
+ * translating the jump offset. This table is computed by dry-running the
+ * JIT without actually emitting anything. However, the computed PC-relative
+ * offset may overflow the 18-bit offset field width of the native MIPS
+ * branch instruction. In such cases, the long jump is converted into the
+ * following sequence.
+ *
+ *    <branch> !<cond> +2    Inverted PC-relative branch
+ *    nop                    Delay slot
+ *    j <offset>             Unconditional absolute long jump
+ *    nop                    Delay slot
+ *
+ * Since this converted sequence alters the offset table, all offsets must
+ * be re-calculated. This may in turn trigger new branch conversions, so
+ * the process is repeated until no further changes are made. Normally it
+ * completes in 1-2 iterations. If JIT_MAX_ITERATIONS should reached, we
+ * fall back to converting every remaining jump operation. The branch
+ * conversion is independent of how the JMP or JMP32 condition is JITed.
+ *
+ * JMP32 and JMP operations are JITed as follows.
+ *
+ * 1) setup_jmp_{i,r}:
+ *    Convert jump conditional and offset into a form that can be JITed.
+ *    This form may be a no-op, a canonical form, or an inverted PC-relative
+ *    jump if branch conversion is necessary.
+ *
+ * 2) valid_jmp_i:
+ *    Determine if an immediate operations can be emitted as such, or if
+ *    we must fall back to the register version. Applies to JMP32 for 32-bit
+ *    MIPS, and both JMP and JMP32 for 64-bit MIPS.
+ *
+ * 3) emit_jmp_{i,i64,r,r64}:
+ *    Emit instructions for an JMP or JMP32 immediate or register operation.
+ *
+ * 4) finish_jmp_{i,r}:
+ *    Emit any instructions needed to finish the jump. This includes a nop
+ *    for the delay slot if a branch was emitted, and a long absolute jump
+ *    if the branch was converted.
+ */
+
+#include <linux/limits.h>
+#include <linux/bitops.h>
+#include <linux/errno.h>
+#include <linux/filter.h>
+#include <linux/bpf.h>
+#include <linux/slab.h>
+#include <asm/bitops.h>
+#include <asm/cacheflush.h>
+#include <asm/cpu-features.h>
+#include <asm/isa-rev.h>
+#include <asm/uasm.h>
+
+#include "bpf_jit_comp.h"
+
+/* Convenience macros for descriptor access */
+#define CONVERTED(desc)	((desc) & JIT_DESC_CONVERT)
+#define INDEX(desc)	((desc) & ~JIT_DESC_CONVERT)
+
+/*
+ * Push registers on the stack, starting at a given depth from the stack
+ * pointer and increasing. The next depth to be written is returned.
+ */
+int push_regs(struct jit_context *ctx, u32 mask, u32 excl, int depth)
+{
+	int reg;
+
+	for (reg = 0; reg < BITS_PER_BYTE * sizeof(mask); reg++)
+		if (mask & BIT(reg)) {
+			if ((excl & BIT(reg)) == 0) {
+				if (sizeof(long) == 4)
+					emit(ctx, sw, reg, depth, MIPS_R_SP);
+				else /* sizeof(long) == 8 */
+					emit(ctx, sd, reg, depth, MIPS_R_SP);
+			}
+			depth += sizeof(long);
+		}
+
+	ctx->stack_used = max((int)ctx->stack_used, depth);
+	return depth;
+}
+
+/*
+ * Pop registers from the stack, starting at a given depth from the stack
+ * pointer and increasing. The next depth to be read is returned.
+ */
+int pop_regs(struct jit_context *ctx, u32 mask, u32 excl, int depth)
+{
+	int reg;
+
+	for (reg = 0; reg < BITS_PER_BYTE * sizeof(mask); reg++)
+		if (mask & BIT(reg)) {
+			if ((excl & BIT(reg)) == 0) {
+				if (sizeof(long) == 4)
+					emit(ctx, lw, reg, depth, MIPS_R_SP);
+				else /* sizeof(long) == 8 */
+					emit(ctx, ld, reg, depth, MIPS_R_SP);
+			}
+			depth += sizeof(long);
+		}
+
+	return depth;
+}
+
+/* Compute the 28-bit jump target address from a BPF program location */
+int get_target(struct jit_context *ctx, u32 loc)
+{
+	u32 index = INDEX(ctx->descriptors[loc]);
+	unsigned long pc = (unsigned long)&ctx->target[ctx->jit_index];
+	unsigned long addr = (unsigned long)&ctx->target[index];
+
+	if (!ctx->target)
+		return 0;
+
+	if ((addr ^ pc) & ~MIPS_JMP_MASK)
+		return -1;
+
+	return addr & MIPS_JMP_MASK;
+}
+
+/* Compute the PC-relative offset to relative BPF program offset */
+int get_offset(const struct jit_context *ctx, int off)
+{
+	return (INDEX(ctx->descriptors[ctx->bpf_index + off]) -
+		ctx->jit_index - 1) * sizeof(u32);
+}
+
+/* dst = imm (register width) */
+void emit_mov_i(struct jit_context *ctx, u8 dst, s32 imm)
+{
+	if (imm >= -0x8000 && imm <= 0x7fff) {
+		emit(ctx, addiu, dst, MIPS_R_ZERO, imm);
+	} else {
+		emit(ctx, lui, dst, (s16)((u32)imm >> 16));
+		emit(ctx, ori, dst, dst, (u16)(imm & 0xffff));
+	}
+	clobber_reg(ctx, dst);
+}
+
+/* dst = src (register width) */
+void emit_mov_r(struct jit_context *ctx, u8 dst, u8 src)
+{
+	emit(ctx, ori, dst, src, 0);
+	clobber_reg(ctx, dst);
+}
+
+/* Validate ALU immediate range */
+bool valid_alu_i(u8 op, s32 imm)
+{
+	switch (BPF_OP(op)) {
+	case BPF_NEG:
+	case BPF_LSH:
+	case BPF_RSH:
+	case BPF_ARSH:
+		/* All legal eBPF values are valid */
+		return true;
+	case BPF_ADD:
+		/* imm must be 16 bits */
+		return imm >= -0x8000 && imm <= 0x7fff;
+	case BPF_SUB:
+		/* -imm must be 16 bits */
+		return imm >= -0x7fff && imm <= 0x8000;
+	case BPF_AND:
+	case BPF_OR:
+	case BPF_XOR:
+		/* imm must be 16 bits unsigned */
+		return imm >= 0 && imm <= 0xffff;
+	case BPF_MUL:
+		/* imm must be zero or a positive power of two */
+		return imm == 0 || (imm > 0 && is_power_of_2(imm));
+	case BPF_DIV:
+	case BPF_MOD:
+		/* imm must be an 17-bit power of two */
+		return (u32)imm <= 0x10000 && is_power_of_2((u32)imm);
+	}
+	return false;
+}
+
+/* Rewrite ALU immediate operation */
+bool rewrite_alu_i(u8 op, s32 imm, u8 *alu, s32 *val)
+{
+	bool act = true;
+
+	switch (BPF_OP(op)) {
+	case BPF_LSH:
+	case BPF_RSH:
+	case BPF_ARSH:
+	case BPF_ADD:
+	case BPF_SUB:
+	case BPF_OR:
+	case BPF_XOR:
+		/* imm == 0 is a no-op */
+		act = imm != 0;
+		break;
+	case BPF_MUL:
+		if (imm == 1) {
+			/* dst * 1 is a no-op */
+			act = false;
+		} else if (imm == 0) {
+			/* dst * 0 is dst & 0 */
+			op = BPF_AND;
+		} else {
+			/* dst * (1 << n) is dst << n */
+			op = BPF_LSH;
+			imm = ilog2(abs(imm));
+		}
+		break;
+	case BPF_DIV:
+		if (imm == 1) {
+			/* dst / 1 is a no-op */
+			act = false;
+		} else {
+			/* dst / (1 << n) is dst >> n */
+			op = BPF_RSH;
+			imm = ilog2(imm);
+		}
+		break;
+	case BPF_MOD:
+		/* dst % (1 << n) is dst & ((1 << n) - 1) */
+		op = BPF_AND;
+		imm--;
+		break;
+	}
+
+	*alu = op;
+	*val = imm;
+	return act;
+}
+
+/* ALU immediate operation (32-bit) */
+void emit_alu_i(struct jit_context *ctx, u8 dst, s32 imm, u8 op)
+{
+	switch (BPF_OP(op)) {
+	/* dst = -dst */
+	case BPF_NEG:
+		emit(ctx, subu, dst, MIPS_R_ZERO, dst);
+		break;
+	/* dst = dst & imm */
+	case BPF_AND:
+		emit(ctx, andi, dst, dst, (u16)imm);
+		break;
+	/* dst = dst | imm */
+	case BPF_OR:
+		emit(ctx, ori, dst, dst, (u16)imm);
+		break;
+	/* dst = dst ^ imm */
+	case BPF_XOR:
+		emit(ctx, xori, dst, dst, (u16)imm);
+		break;
+	/* dst = dst << imm */
+	case BPF_LSH:
+		emit(ctx, sll, dst, dst, imm);
+		break;
+	/* dst = dst >> imm */
+	case BPF_RSH:
+		emit(ctx, srl, dst, dst, imm);
+		break;
+	/* dst = dst >> imm (arithmetic) */
+	case BPF_ARSH:
+		emit(ctx, sra, dst, dst, imm);
+		break;
+	/* dst = dst + imm */
+	case BPF_ADD:
+		emit(ctx, addiu, dst, dst, imm);
+		break;
+	/* dst = dst - imm */
+	case BPF_SUB:
+		emit(ctx, addiu, dst, dst, -imm);
+		break;
+	}
+	clobber_reg(ctx, dst);
+}
+
+/* ALU register operation (32-bit) */
+void emit_alu_r(struct jit_context *ctx, u8 dst, u8 src, u8 op)
+{
+	switch (BPF_OP(op)) {
+	/* dst = dst & src */
+	case BPF_AND:
+		emit(ctx, and, dst, dst, src);
+		break;
+	/* dst = dst | src */
+	case BPF_OR:
+		emit(ctx, or, dst, dst, src);
+		break;
+	/* dst = dst ^ src */
+	case BPF_XOR:
+		emit(ctx, xor, dst, dst, src);
+		break;
+	/* dst = dst << src */
+	case BPF_LSH:
+		emit(ctx, sllv, dst, dst, src);
+		break;
+	/* dst = dst >> src */
+	case BPF_RSH:
+		emit(ctx, srlv, dst, dst, src);
+		break;
+	/* dst = dst >> src (arithmetic) */
+	case BPF_ARSH:
+		emit(ctx, srav, dst, dst, src);
+		break;
+	/* dst = dst + src */
+	case BPF_ADD:
+		emit(ctx, addu, dst, dst, src);
+		break;
+	/* dst = dst - src */
+	case BPF_SUB:
+		emit(ctx, subu, dst, dst, src);
+		break;
+	/* dst = dst * src */
+	case BPF_MUL:
+		if (cpu_has_mips32r1 || cpu_has_mips32r6) {
+			emit(ctx, mul, dst, dst, src);
+		} else {
+			emit(ctx, multu, dst, src);
+			emit(ctx, mflo, dst);
+		}
+		break;
+	/* dst = dst / src */
+	case BPF_DIV:
+		if (cpu_has_mips32r6) {
+			emit(ctx, divu_r6, dst, dst, src);
+		} else {
+			emit(ctx, divu, dst, src);
+			emit(ctx, mflo, dst);
+		}
+		break;
+	/* dst = dst % src */
+	case BPF_MOD:
+		if (cpu_has_mips32r6) {
+			emit(ctx, modu, dst, dst, src);
+		} else {
+			emit(ctx, divu, dst, src);
+			emit(ctx, mfhi, dst);
+		}
+		break;
+	}
+	clobber_reg(ctx, dst);
+}
+
+/* Atomic read-modify-write (32-bit) */
+void emit_atomic_r(struct jit_context *ctx, u8 dst, u8 src, s16 off, u8 code)
+{
+	emit(ctx, ll, MIPS_R_T9, off, dst);
+	switch (code) {
+	case BPF_ADD:
+	case BPF_ADD | BPF_FETCH:
+		emit(ctx, addu, MIPS_R_T8, MIPS_R_T9, src);
+		break;
+	case BPF_AND:
+	case BPF_AND | BPF_FETCH:
+		emit(ctx, and, MIPS_R_T8, MIPS_R_T9, src);
+		break;
+	case BPF_OR:
+	case BPF_OR | BPF_FETCH:
+		emit(ctx, or, MIPS_R_T8, MIPS_R_T9, src);
+		break;
+	case BPF_XOR:
+	case BPF_XOR | BPF_FETCH:
+		emit(ctx, xor, MIPS_R_T8, MIPS_R_T9, src);
+		break;
+	case BPF_XCHG:
+		emit(ctx, move, MIPS_R_T8, src);
+		break;
+	}
+	emit(ctx, sc, MIPS_R_T8, off, dst);
+	emit(ctx, beqz, MIPS_R_T8, -16);
+	emit(ctx, nop); /* Delay slot */
+
+	if (code & BPF_FETCH) {
+		emit(ctx, move, src, MIPS_R_T9);
+		clobber_reg(ctx, src);
+	}
+}
+
+/* Atomic compare-and-exchange (32-bit) */
+void emit_cmpxchg_r(struct jit_context *ctx, u8 dst, u8 src, u8 res, s16 off)
+{
+	emit(ctx, ll, MIPS_R_T9, off, dst);
+	emit(ctx, bne, MIPS_R_T9, res, 12);
+	emit(ctx, move, MIPS_R_T8, src);     /* Delay slot */
+	emit(ctx, sc, MIPS_R_T8, off, dst);
+	emit(ctx, beqz, MIPS_R_T8, -20);
+	emit(ctx, move, res, MIPS_R_T9);     /* Delay slot */
+	clobber_reg(ctx, res);
+}
+
+/* Swap bytes and truncate a register word or half word */
+void emit_bswap_r(struct jit_context *ctx, u8 dst, u32 width)
+{
+	u8 tmp = MIPS_R_T8;
+	u8 msk = MIPS_R_T9;
+
+	switch (width) {
+	/* Swap bytes in a word */
+	case 32:
+		if (cpu_has_mips32r2 || cpu_has_mips32r6) {
+			emit(ctx, wsbh, dst, dst);
+			emit(ctx, rotr, dst, dst, 16);
+		} else {
+			emit(ctx, sll, tmp, dst, 16);    /* tmp  = dst << 16 */
+			emit(ctx, srl, dst, dst, 16);    /* dst = dst >> 16  */
+			emit(ctx, or, dst, dst, tmp);    /* dst = dst | tmp  */
+
+			emit(ctx, lui, msk, 0xff);       /* msk = 0x00ff0000 */
+			emit(ctx, ori, msk, msk, 0xff);  /* msk = msk | 0xff */
+
+			emit(ctx, and, tmp, dst, msk);   /* tmp = dst & msk  */
+			emit(ctx, sll, tmp, tmp, 8);     /* tmp = tmp << 8   */
+			emit(ctx, srl, dst, dst, 8);     /* dst = dst >> 8   */
+			emit(ctx, and, dst, dst, msk);   /* dst = dst & msk  */
+			emit(ctx, or, dst, dst, tmp);    /* reg = dst | tmp  */
+		}
+		break;
+	/* Swap bytes in a half word */
+	case 16:
+		if (cpu_has_mips32r2 || cpu_has_mips32r6) {
+			emit(ctx, wsbh, dst, dst);
+			emit(ctx, andi, dst, dst, 0xffff);
+		} else {
+			emit(ctx, andi, tmp, dst, 0xff00); /* t = d & 0xff00 */
+			emit(ctx, srl, tmp, tmp, 8);       /* t = t >> 8     */
+			emit(ctx, andi, dst, dst, 0x00ff); /* d = d & 0x00ff */
+			emit(ctx, sll, dst, dst, 8);       /* d = d << 8     */
+			emit(ctx, or,  dst, dst, tmp);     /* d = d | t      */
+		}
+		break;
+	}
+	clobber_reg(ctx, dst);
+}
+
+/* Validate jump immediate range */
+bool valid_jmp_i(u8 op, s32 imm)
+{
+	switch (op) {
+	case JIT_JNOP:
+		/* Immediate value not used */
+		return true;
+	case BPF_JEQ:
+	case BPF_JNE:
+		/* No immediate operation */
+		return false;
+	case BPF_JSET:
+	case JIT_JNSET:
+		/* imm must be 16 bits unsigned */
+		return imm >= 0 && imm <= 0xffff;
+	case BPF_JGE:
+	case BPF_JLT:
+	case BPF_JSGE:
+	case BPF_JSLT:
+		/* imm must be 16 bits */
+		return imm >= -0x8000 && imm <= 0x7fff;
+	case BPF_JGT:
+	case BPF_JLE:
+	case BPF_JSGT:
+	case BPF_JSLE:
+		/* imm + 1 must be 16 bits */
+		return imm >= -0x8001 && imm <= 0x7ffe;
+	}
+	return false;
+}
+
+/* Invert a conditional jump operation */
+static u8 invert_jmp(u8 op)
+{
+	switch (op) {
+	case BPF_JA: return JIT_JNOP;
+	case BPF_JEQ: return BPF_JNE;
+	case BPF_JNE: return BPF_JEQ;
+	case BPF_JSET: return JIT_JNSET;
+	case BPF_JGT: return BPF_JLE;
+	case BPF_JGE: return BPF_JLT;
+	case BPF_JLT: return BPF_JGE;
+	case BPF_JLE: return BPF_JGT;
+	case BPF_JSGT: return BPF_JSLE;
+	case BPF_JSGE: return BPF_JSLT;
+	case BPF_JSLT: return BPF_JSGE;
+	case BPF_JSLE: return BPF_JSGT;
+	}
+	return 0;
+}
+
+/* Prepare a PC-relative jump operation */
+static void setup_jmp(struct jit_context *ctx, u8 bpf_op,
+		      s16 bpf_off, u8 *jit_op, s32 *jit_off)
+{
+	u32 *descp = &ctx->descriptors[ctx->bpf_index];
+	int op = bpf_op;
+	int offset = 0;
+
+	/* Do not compute offsets on the first pass */
+	if (INDEX(*descp) == 0)
+		goto done;
+
+	/* Skip jumps never taken */
+	if (bpf_op == JIT_JNOP)
+		goto done;
+
+	/* Convert jumps always taken */
+	if (bpf_op == BPF_JA)
+		*descp |= JIT_DESC_CONVERT;
+
+	/*
+	 * Current ctx->jit_index points to the start of the branch preamble.
+	 * Since the preamble differs among different branch conditionals,
+	 * the current index cannot be used to compute the branch offset.
+	 * Instead, we use the offset table value for the next instruction,
+	 * which gives the index immediately after the branch delay slot.
+	 */
+	if (!CONVERTED(*descp)) {
+		int target = ctx->bpf_index + bpf_off + 1;
+		int origin = ctx->bpf_index + 1;
+
+		offset = (INDEX(ctx->descriptors[target]) -
+			  INDEX(ctx->descriptors[origin]) + 1) * sizeof(u32);
+	}
+
+	/*
+	 * The PC-relative branch offset field on MIPS is 18 bits signed,
+	 * so if the computed offset is larger than this we generate a an
+	 * absolute jump that we skip with an inverted conditional branch.
+	 */
+	if (CONVERTED(*descp) || offset < -0x20000 || offset > 0x1ffff) {
+		offset = 3 * sizeof(u32);
+		op = invert_jmp(bpf_op);
+		ctx->changes += !CONVERTED(*descp);
+		*descp |= JIT_DESC_CONVERT;
+	}
+
+done:
+	*jit_off = offset;
+	*jit_op = op;
+}
+
+/* Prepare a PC-relative jump operation with immediate conditional */
+void setup_jmp_i(struct jit_context *ctx, s32 imm, u8 width,
+		 u8 bpf_op, s16 bpf_off, u8 *jit_op, s32 *jit_off)
+{
+	bool always = false;
+	bool never = false;
+
+	switch (bpf_op) {
+	case BPF_JEQ:
+	case BPF_JNE:
+		break;
+	case BPF_JSET:
+	case BPF_JLT:
+		never = imm == 0;
+		break;
+	case BPF_JGE:
+		always = imm == 0;
+		break;
+	case BPF_JGT:
+		never = (u32)imm == U32_MAX;
+		break;
+	case BPF_JLE:
+		always = (u32)imm == U32_MAX;
+		break;
+	case BPF_JSGT:
+		never = imm == S32_MAX && width == 32;
+		break;
+	case BPF_JSGE:
+		always = imm == S32_MIN && width == 32;
+		break;
+	case BPF_JSLT:
+		never = imm == S32_MIN && width == 32;
+		break;
+	case BPF_JSLE:
+		always = imm == S32_MAX && width == 32;
+		break;
+	}
+
+	if (never)
+		bpf_op = JIT_JNOP;
+	if (always)
+		bpf_op = BPF_JA;
+	setup_jmp(ctx, bpf_op, bpf_off, jit_op, jit_off);
+}
+
+/* Prepare a PC-relative jump operation with register conditional */
+void setup_jmp_r(struct jit_context *ctx, bool same_reg,
+		 u8 bpf_op, s16 bpf_off, u8 *jit_op, s32 *jit_off)
+{
+	switch (bpf_op) {
+	case BPF_JSET:
+		break;
+	case BPF_JEQ:
+	case BPF_JGE:
+	case BPF_JLE:
+	case BPF_JSGE:
+	case BPF_JSLE:
+		if (same_reg)
+			bpf_op = BPF_JA;
+		break;
+	case BPF_JNE:
+	case BPF_JLT:
+	case BPF_JGT:
+	case BPF_JSGT:
+	case BPF_JSLT:
+		if (same_reg)
+			bpf_op = JIT_JNOP;
+		break;
+	}
+	setup_jmp(ctx, bpf_op, bpf_off, jit_op, jit_off);
+}
+
+/* Finish a PC-relative jump operation */
+int finish_jmp(struct jit_context *ctx, u8 jit_op, s16 bpf_off)
+{
+	/* Emit conditional branch delay slot */
+	if (jit_op != JIT_JNOP)
+		emit(ctx, nop);
+	/*
+	 * Emit an absolute long jump with delay slot,
+	 * if the PC-relative branch was converted.
+	 */
+	if (CONVERTED(ctx->descriptors[ctx->bpf_index])) {
+		int target = get_target(ctx, ctx->bpf_index + bpf_off + 1);
+
+		if (target < 0)
+			return -1;
+		emit(ctx, j, target);
+		emit(ctx, nop);
+	}
+	return 0;
+}
+
+/* Jump immediate (32-bit) */
+void emit_jmp_i(struct jit_context *ctx, u8 dst, s32 imm, s32 off, u8 op)
+{
+	switch (op) {
+	/* No-op, used internally for branch optimization */
+	case JIT_JNOP:
+		break;
+	/* PC += off if dst & imm */
+	case BPF_JSET:
+		emit(ctx, andi, MIPS_R_T9, dst, (u16)imm);
+		emit(ctx, bnez, MIPS_R_T9, off);
+		break;
+	/* PC += off if (dst & imm) == 0 (not in BPF, used for long jumps) */
+	case JIT_JNSET:
+		emit(ctx, andi, MIPS_R_T9, dst, (u16)imm);
+		emit(ctx, beqz, MIPS_R_T9, off);
+		break;
+	/* PC += off if dst > imm */
+	case BPF_JGT:
+		emit(ctx, sltiu, MIPS_R_T9, dst, imm + 1);
+		emit(ctx, beqz, MIPS_R_T9, off);
+		break;
+	/* PC += off if dst >= imm */
+	case BPF_JGE:
+		emit(ctx, sltiu, MIPS_R_T9, dst, imm);
+		emit(ctx, beqz, MIPS_R_T9, off);
+		break;
+	/* PC += off if dst < imm */
+	case BPF_JLT:
+		emit(ctx, sltiu, MIPS_R_T9, dst, imm);
+		emit(ctx, bnez, MIPS_R_T9, off);
+		break;
+	/* PC += off if dst <= imm */
+	case BPF_JLE:
+		emit(ctx, sltiu, MIPS_R_T9, dst, imm + 1);
+		emit(ctx, bnez, MIPS_R_T9, off);
+		break;
+	/* PC += off if dst > imm (signed) */
+	case BPF_JSGT:
+		emit(ctx, slti, MIPS_R_T9, dst, imm + 1);
+		emit(ctx, beqz, MIPS_R_T9, off);
+		break;
+	/* PC += off if dst >= imm (signed) */
+	case BPF_JSGE:
+		emit(ctx, slti, MIPS_R_T9, dst, imm);
+		emit(ctx, beqz, MIPS_R_T9, off);
+		break;
+	/* PC += off if dst < imm (signed) */
+	case BPF_JSLT:
+		emit(ctx, slti, MIPS_R_T9, dst, imm);
+		emit(ctx, bnez, MIPS_R_T9, off);
+		break;
+	/* PC += off if dst <= imm (signed) */
+	case BPF_JSLE:
+		emit(ctx, slti, MIPS_R_T9, dst, imm + 1);
+		emit(ctx, bnez, MIPS_R_T9, off);
+		break;
+	}
+}
+
+/* Jump register (32-bit) */
+void emit_jmp_r(struct jit_context *ctx, u8 dst, u8 src, s32 off, u8 op)
+{
+	switch (op) {
+	/* No-op, used internally for branch optimization */
+	case JIT_JNOP:
+		break;
+	/* PC += off if dst == src */
+	case BPF_JEQ:
+		emit(ctx, beq, dst, src, off);
+		break;
+	/* PC += off if dst != src */
+	case BPF_JNE:
+		emit(ctx, bne, dst, src, off);
+		break;
+	/* PC += off if dst & src */
+	case BPF_JSET:
+		emit(ctx, and, MIPS_R_T9, dst, src);
+		emit(ctx, bnez, MIPS_R_T9, off);
+		break;
+	/* PC += off if (dst & imm) == 0 (not in BPF, used for long jumps) */
+	case JIT_JNSET:
+		emit(ctx, and, MIPS_R_T9, dst, src);
+		emit(ctx, beqz, MIPS_R_T9, off);
+		break;
+	/* PC += off if dst > src */
+	case BPF_JGT:
+		emit(ctx, sltu, MIPS_R_T9, src, dst);
+		emit(ctx, bnez, MIPS_R_T9, off);
+		break;
+	/* PC += off if dst >= src */
+	case BPF_JGE:
+		emit(ctx, sltu, MIPS_R_T9, dst, src);
+		emit(ctx, beqz, MIPS_R_T9, off);
+		break;
+	/* PC += off if dst < src */
+	case BPF_JLT:
+		emit(ctx, sltu, MIPS_R_T9, dst, src);
+		emit(ctx, bnez, MIPS_R_T9, off);
+		break;
+	/* PC += off if dst <= src */
+	case BPF_JLE:
+		emit(ctx, sltu, MIPS_R_T9, src, dst);
+		emit(ctx, beqz, MIPS_R_T9, off);
+		break;
+	/* PC += off if dst > src (signed) */
+	case BPF_JSGT:
+		emit(ctx, slt, MIPS_R_T9, src, dst);
+		emit(ctx, bnez, MIPS_R_T9, off);
+		break;
+	/* PC += off if dst >= src (signed) */
+	case BPF_JSGE:
+		emit(ctx, slt, MIPS_R_T9, dst, src);
+		emit(ctx, beqz, MIPS_R_T9, off);
+		break;
+	/* PC += off if dst < src (signed) */
+	case BPF_JSLT:
+		emit(ctx, slt, MIPS_R_T9, dst, src);
+		emit(ctx, bnez, MIPS_R_T9, off);
+		break;
+	/* PC += off if dst <= src (signed) */
+	case BPF_JSLE:
+		emit(ctx, slt, MIPS_R_T9, src, dst);
+		emit(ctx, beqz, MIPS_R_T9, off);
+		break;
+	}
+}
+
+/* Jump always */
+int emit_ja(struct jit_context *ctx, s16 off)
+{
+	int target = get_target(ctx, ctx->bpf_index + off + 1);
+
+	if (target < 0)
+		return -1;
+	emit(ctx, j, target);
+	emit(ctx, nop);
+	return 0;
+}
+
+/* Jump to epilogue */
+int emit_exit(struct jit_context *ctx)
+{
+	int target = get_target(ctx, ctx->program->len);
+
+	if (target < 0)
+		return -1;
+	emit(ctx, j, target);
+	emit(ctx, nop);
+	return 0;
+}
+
+/* Build the program body from eBPF bytecode */
+static int build_body(struct jit_context *ctx)
+{
+	const struct bpf_prog *prog = ctx->program;
+	unsigned int i;
+
+	ctx->stack_used = 0;
+	for (i = 0; i < prog->len; i++) {
+		const struct bpf_insn *insn = &prog->insnsi[i];
+		u32 *descp = &ctx->descriptors[i];
+		int ret;
+
+		access_reg(ctx, insn->src_reg);
+		access_reg(ctx, insn->dst_reg);
+
+		ctx->bpf_index = i;
+		if (ctx->target == NULL) {
+			ctx->changes += INDEX(*descp) != ctx->jit_index;
+			*descp &= JIT_DESC_CONVERT;
+			*descp |= ctx->jit_index;
+		}
+
+		ret = build_insn(insn, ctx);
+		if (ret < 0)
+			return ret;
+
+		if (ret > 0) {
+			i++;
+			if (ctx->target == NULL)
+				descp[1] = ctx->jit_index;
+		}
+	}
+
+	/* Store the end offset, where the epilogue begins */
+	ctx->descriptors[prog->len] = ctx->jit_index;
+	return 0;
+}
+
+/* Set the branch conversion flag on all instructions */
+static void set_convert_flag(struct jit_context *ctx, bool enable)
+{
+	const struct bpf_prog *prog = ctx->program;
+	u32 flag = enable ? JIT_DESC_CONVERT : 0;
+	unsigned int i;
+
+	for (i = 0; i <= prog->len; i++)
+		ctx->descriptors[i] = INDEX(ctx->descriptors[i]) | flag;
+}
+
+static void jit_fill_hole(void *area, unsigned int size)
+{
+	u32 *p;
+
+	/* We are guaranteed to have aligned memory. */
+	for (p = area; size >= sizeof(u32); size -= sizeof(u32))
+		uasm_i_break(&p, BRK_BUG); /* Increments p */
+}
+
+bool bpf_jit_needs_zext(void)
+{
+	return true;
+}
+
+struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
+{
+	struct bpf_prog *tmp, *orig_prog = prog;
+	struct bpf_binary_header *header = NULL;
+	struct jit_context ctx;
+	bool tmp_blinded = false;
+	unsigned int tmp_idx;
+	unsigned int image_size;
+	u8 *image_ptr;
+	int tries;
+
+	/*
+	 * If BPF JIT was not enabled then we must fall back to
+	 * the interpreter.
+	 */
+	if (!prog->jit_requested)
+		return orig_prog;
+	/*
+	 * If constant blinding was enabled and we failed during blinding
+	 * then we must fall back to the interpreter. Otherwise, we save
+	 * the new JITed code.
+	 */
+	tmp = bpf_jit_blind_constants(prog);
+	if (IS_ERR(tmp))
+		return orig_prog;
+	if (tmp != prog) {
+		tmp_blinded = true;
+		prog = tmp;
+	}
+
+	memset(&ctx, 0, sizeof(ctx));
+	ctx.program = prog;
+
+	/*
+	 * Not able to allocate memory for descriptors[], then
+	 * we must fall back to the interpreter
+	 */
+	ctx.descriptors = kcalloc(prog->len + 1, sizeof(*ctx.descriptors),
+				  GFP_KERNEL);
+	if (ctx.descriptors == NULL)
+		goto out_err;
+
+	/* First pass discovers used resources */
+	if (build_body(&ctx) < 0)
+		goto out_err;
+	/*
+	 * Second pass computes instruction offsets.
+	 * If any PC-relative branches are out of range, a sequence of
+	 * a PC-relative branch + a jump is generated, and we have to
+	 * try again from the beginning to generate the new offsets.
+	 * This is done until no additional conversions are necessary.
+	 * The last two iterations are done with all branches being
+	 * converted, to guarantee offset table convergence within a
+	 * fixed number of iterations.
+	 */
+	ctx.jit_index = 0;
+	build_prologue(&ctx);
+	tmp_idx = ctx.jit_index;
+
+	tries = JIT_MAX_ITERATIONS;
+	do {
+		ctx.jit_index = tmp_idx;
+		ctx.changes = 0;
+		if (tries == 2)
+			set_convert_flag(&ctx, true);
+		if (build_body(&ctx) < 0)
+			goto out_err;
+	} while (ctx.changes > 0 && --tries > 0);
+
+	if (WARN_ONCE(ctx.changes > 0, "JIT offsets failed to converge"))
+		goto out_err;
+
+	build_epilogue(&ctx, MIPS_R_RA);
+
+	/* Now we know the size of the structure to make */
+	image_size = sizeof(u32) * ctx.jit_index;
+	header = bpf_jit_binary_alloc(image_size, &image_ptr,
+				      sizeof(u32), jit_fill_hole);
+	/*
+	 * Not able to allocate memory for the structure then
+	 * we must fall back to the interpretation
+	 */
+	if (header == NULL)
+		goto out_err;
+
+	/* Actual pass to generate final JIT code */
+	ctx.target = (u32 *)image_ptr;
+	ctx.jit_index = 0;
+
+	/*
+	 * If building the JITed code fails somehow,
+	 * we fall back to the interpretation.
+	 */
+	build_prologue(&ctx);
+	if (build_body(&ctx) < 0)
+		goto out_err;
+	build_epilogue(&ctx, MIPS_R_RA);
+
+	/* Populate line info meta data */
+	set_convert_flag(&ctx, false);
+	bpf_prog_fill_jited_linfo(prog, &ctx.descriptors[1]);
+
+	/* Set as read-only exec and flush instruction cache */
+	bpf_jit_binary_lock_ro(header);
+	flush_icache_range((unsigned long)header,
+			   (unsigned long)&ctx.target[ctx.jit_index]);
+
+	if (bpf_jit_enable > 1)
+		bpf_jit_dump(prog->len, image_size, 2, ctx.target);
+
+	prog->bpf_func = (void *)ctx.target;
+	prog->jited = 1;
+	prog->jited_len = image_size;
+
+out:
+	if (tmp_blinded)
+		bpf_jit_prog_release_other(prog, prog == orig_prog ?
+					   tmp : orig_prog);
+	kfree(ctx.descriptors);
+	return prog;
+
+out_err:
+	prog = orig_prog;
+	if (header)
+		bpf_jit_binary_free(header);
+	goto out;
+}
diff --git a/arch/mips/net/bpf_jit_comp.h b/arch/mips/net/bpf_jit_comp.h
new file mode 100644
index 000000000000..44787cf377dd
--- /dev/null
+++ b/arch/mips/net/bpf_jit_comp.h
@@ -0,0 +1,211 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Just-In-Time compiler for eBPF bytecode on 32-bit and 64-bit MIPS.
+ *
+ * Copyright (c) 2021 Anyfi Networks AB.
+ * Author: Johan Almbladh <johan.almbladh@gmail.com>
+ *
+ * Based on code and ideas from
+ * Copyright (c) 2017 Cavium, Inc.
+ * Copyright (c) 2017 Shubham Bansal <illusionist.neo@gmail.com>
+ * Copyright (c) 2011 Mircea Gherzan <mgherzan@gmail.com>
+ */
+
+#ifndef _BPF_JIT_COMP_H
+#define _BPF_JIT_COMP_H
+
+/* MIPS registers */
+#define MIPS_R_ZERO	0   /* Const zero */
+#define MIPS_R_AT	1   /* Asm temp   */
+#define MIPS_R_V0	2   /* Result     */
+#define MIPS_R_V1	3   /* Result     */
+#define MIPS_R_A0	4   /* Argument   */
+#define MIPS_R_A1	5   /* Argument   */
+#define MIPS_R_A2	6   /* Argument   */
+#define MIPS_R_A3	7   /* Argument   */
+#define MIPS_R_A4	8   /* Arg (n64)  */
+#define MIPS_R_A5	9   /* Arg (n64)  */
+#define MIPS_R_A6	10  /* Arg (n64)  */
+#define MIPS_R_A7	11  /* Arg (n64)  */
+#define MIPS_R_T0	8   /* Temp (o32) */
+#define MIPS_R_T1	9   /* Temp (o32) */
+#define MIPS_R_T2	10  /* Temp (o32) */
+#define MIPS_R_T3	11  /* Temp (o32) */
+#define MIPS_R_T4	12  /* Temporary  */
+#define MIPS_R_T5	13  /* Temporary  */
+#define MIPS_R_T6	14  /* Temporary  */
+#define MIPS_R_T7	15  /* Temporary  */
+#define MIPS_R_S0	16  /* Saved      */
+#define MIPS_R_S1	17  /* Saved      */
+#define MIPS_R_S2	18  /* Saved      */
+#define MIPS_R_S3	19  /* Saved      */
+#define MIPS_R_S4	20  /* Saved      */
+#define MIPS_R_S5	21  /* Saved      */
+#define MIPS_R_S6	22  /* Saved      */
+#define MIPS_R_S7	23  /* Saved      */
+#define MIPS_R_T8	24  /* Temporary  */
+#define MIPS_R_T9	25  /* Temporary  */
+/*      MIPS_R_K0	26     Reserved   */
+/*      MIPS_R_K1	27     Reserved   */
+#define MIPS_R_GP	28  /* Global ptr */
+#define MIPS_R_SP	29  /* Stack ptr  */
+#define MIPS_R_FP	30  /* Frame ptr  */
+#define MIPS_R_RA	31  /* Return     */
+
+/*
+ * Jump address mask for immediate jumps. The four most significant bits
+ * must be equal to PC.
+ */
+#define MIPS_JMP_MASK	0x0fffffffUL
+
+/* Maximum number of iterations in offset table computation */
+#define JIT_MAX_ITERATIONS	8
+
+/*
+ * Jump pseudo-instructions used internally
+ * for branch conversion and branch optimization.
+ */
+#define JIT_JNSET	0xe0
+#define JIT_JNOP	0xf0
+
+/* Descriptor flag for PC-relative branch conversion */
+#define JIT_DESC_CONVERT	BIT(31)
+
+/* JIT context for an eBPF program */
+struct jit_context {
+	struct bpf_prog *program;     /* The eBPF program being JITed        */
+	u32 *descriptors;             /* eBPF to JITed CPU insn descriptors  */
+	u32 *target;                  /* JITed code buffer                   */
+	u32 bpf_index;                /* Index of current BPF program insn   */
+	u32 jit_index;                /* Index of current JIT target insn    */
+	u32 changes;                  /* Number of PC-relative branch conv   */
+	u32 accessed;                 /* Bit mask of read eBPF registers     */
+	u32 clobbered;                /* Bit mask of modified CPU registers  */
+	u32 stack_size;               /* Total allocated stack size in bytes */
+	u32 saved_size;               /* Size of callee-saved registers      */
+	u32 stack_used;               /* Stack size used for function calls  */
+};
+
+/* Emit the instruction if the JIT memory space has been allocated */
+#define emit(ctx, func, ...)					\
+do {								\
+	if ((ctx)->target != NULL) {				\
+		u32 *p = &(ctx)->target[ctx->jit_index];	\
+		uasm_i_##func(&p, ##__VA_ARGS__);		\
+	}							\
+	(ctx)->jit_index++;					\
+} while (0)
+
+/*
+ * Mark a BPF register as accessed, it needs to be
+ * initialized by the program if expected, e.g. FP.
+ */
+static inline void access_reg(struct jit_context *ctx, u8 reg)
+{
+	ctx->accessed |= BIT(reg);
+}
+
+/*
+ * Mark a CPU register as clobbered, it needs to be
+ * saved/restored by the program if callee-saved.
+ */
+static inline void clobber_reg(struct jit_context *ctx, u8 reg)
+{
+	ctx->clobbered |= BIT(reg);
+}
+
+/*
+ * Push registers on the stack, starting at a given depth from the stack
+ * pointer and increasing. The next depth to be written is returned.
+ */
+int push_regs(struct jit_context *ctx, u32 mask, u32 excl, int depth);
+
+/*
+ * Pop registers from the stack, starting at a given depth from the stack
+ * pointer and increasing. The next depth to be read is returned.
+ */
+int pop_regs(struct jit_context *ctx, u32 mask, u32 excl, int depth);
+
+/* Compute the 28-bit jump target address from a BPF program location */
+int get_target(struct jit_context *ctx, u32 loc);
+
+/* Compute the PC-relative offset to relative BPF program offset */
+int get_offset(const struct jit_context *ctx, int off);
+
+/* dst = imm (32-bit) */
+void emit_mov_i(struct jit_context *ctx, u8 dst, s32 imm);
+
+/* dst = src (32-bit) */
+void emit_mov_r(struct jit_context *ctx, u8 dst, u8 src);
+
+/* Validate ALU/ALU64 immediate range */
+bool valid_alu_i(u8 op, s32 imm);
+
+/* Rewrite ALU/ALU64 immediate operation */
+bool rewrite_alu_i(u8 op, s32 imm, u8 *alu, s32 *val);
+
+/* ALU immediate operation (32-bit) */
+void emit_alu_i(struct jit_context *ctx, u8 dst, s32 imm, u8 op);
+
+/* ALU register operation (32-bit) */
+void emit_alu_r(struct jit_context *ctx, u8 dst, u8 src, u8 op);
+
+/* Atomic read-modify-write (32-bit) */
+void emit_atomic_r(struct jit_context *ctx, u8 dst, u8 src, s16 off, u8 code);
+
+/* Atomic compare-and-exchange (32-bit) */
+void emit_cmpxchg_r(struct jit_context *ctx, u8 dst, u8 src, u8 res, s16 off);
+
+/* Swap bytes and truncate a register word or half word */
+void emit_bswap_r(struct jit_context *ctx, u8 dst, u32 width);
+
+/* Validate JMP/JMP32 immediate range */
+bool valid_jmp_i(u8 op, s32 imm);
+
+/* Prepare a PC-relative jump operation with immediate conditional */
+void setup_jmp_i(struct jit_context *ctx, s32 imm, u8 width,
+		 u8 bpf_op, s16 bpf_off, u8 *jit_op, s32 *jit_off);
+
+/* Prepare a PC-relative jump operation with register conditional */
+void setup_jmp_r(struct jit_context *ctx, bool same_reg,
+		 u8 bpf_op, s16 bpf_off, u8 *jit_op, s32 *jit_off);
+
+/* Finish a PC-relative jump operation */
+int finish_jmp(struct jit_context *ctx, u8 jit_op, s16 bpf_off);
+
+/* Conditional JMP/JMP32 immediate */
+void emit_jmp_i(struct jit_context *ctx, u8 dst, s32 imm, s32 off, u8 op);
+
+/* Conditional JMP/JMP32 register */
+void emit_jmp_r(struct jit_context *ctx, u8 dst, u8 src, s32 off, u8 op);
+
+/* Jump always */
+int emit_ja(struct jit_context *ctx, s16 off);
+
+/* Jump to epilogue */
+int emit_exit(struct jit_context *ctx);
+
+/*
+ * Build program prologue to set up the stack and registers.
+ * This function is implemented separately for 32-bit and 64-bit JITs.
+ */
+void build_prologue(struct jit_context *ctx);
+
+/*
+ * Build the program epilogue to restore the stack and registers.
+ * This function is implemented separately for 32-bit and 64-bit JITs.
+ */
+void build_epilogue(struct jit_context *ctx, int dest_reg);
+
+/*
+ * Convert an eBPF instruction to native instruction, i.e
+ * JITs an eBPF instruction.
+ * Returns :
+ *	0  - Successfully JITed an 8-byte eBPF instruction
+ *	>0 - Successfully JITed a 16-byte eBPF instruction
+ *	<0 - Failed to JIT.
+ * This function is implemented separately for 32-bit and 64-bit JITs.
+ */
+int build_insn(const struct bpf_insn *insn, struct jit_context *ctx);
+
+#endif /* _BPF_JIT_COMP_H */
diff --git a/arch/mips/net/bpf_jit_comp32.c b/arch/mips/net/bpf_jit_comp32.c
new file mode 100644
index 000000000000..9d7041a2e5d7
--- /dev/null
+++ b/arch/mips/net/bpf_jit_comp32.c
@@ -0,0 +1,1899 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Just-In-Time compiler for eBPF bytecode on MIPS.
+ * Implementation of JIT functions for 32-bit CPUs.
+ *
+ * Copyright (c) 2021 Anyfi Networks AB.
+ * Author: Johan Almbladh <johan.almbladh@gmail.com>
+ *
+ * Based on code and ideas from
+ * Copyright (c) 2017 Cavium, Inc.
+ * Copyright (c) 2017 Shubham Bansal <illusionist.neo@gmail.com>
+ * Copyright (c) 2011 Mircea Gherzan <mgherzan@gmail.com>
+ */
+
+#include <linux/math64.h>
+#include <linux/errno.h>
+#include <linux/filter.h>
+#include <linux/bpf.h>
+#include <asm/cpu-features.h>
+#include <asm/isa-rev.h>
+#include <asm/uasm.h>
+
+#include "bpf_jit_comp.h"
+
+/* MIPS a4-a7 are not available in the o32 ABI */
+#undef MIPS_R_A4
+#undef MIPS_R_A5
+#undef MIPS_R_A6
+#undef MIPS_R_A7
+
+/* Stack is 8-byte aligned in o32 ABI */
+#define MIPS_STACK_ALIGNMENT 8
+
+/*
+ * The top 16 bytes of a stack frame is reserved for the callee in O32 ABI.
+ * This corresponds to stack space for register arguments a0-a3.
+ */
+#define JIT_RESERVED_STACK 16
+
+/* Temporary 64-bit register used by JIT */
+#define JIT_REG_TMP MAX_BPF_JIT_REG
+
+/*
+ * Number of prologue bytes to skip when doing a tail call.
+ * Tail call count (TCC) initialization (8 bytes) always, plus
+ * R0-to-v0 assignment (4 bytes) if big endian.
+ */
+#ifdef __BIG_ENDIAN
+#define JIT_TCALL_SKIP 12
+#else
+#define JIT_TCALL_SKIP 8
+#endif
+
+/* CPU registers holding the callee return value */
+#define JIT_RETURN_REGS	  \
+	(BIT(MIPS_R_V0) | \
+	 BIT(MIPS_R_V1))
+
+/* CPU registers arguments passed to callee directly */
+#define JIT_ARG_REGS      \
+	(BIT(MIPS_R_A0) | \
+	 BIT(MIPS_R_A1) | \
+	 BIT(MIPS_R_A2) | \
+	 BIT(MIPS_R_A3))
+
+/* CPU register arguments passed to callee on stack */
+#define JIT_STACK_REGS    \
+	(BIT(MIPS_R_T0) | \
+	 BIT(MIPS_R_T1) | \
+	 BIT(MIPS_R_T2) | \
+	 BIT(MIPS_R_T3) | \
+	 BIT(MIPS_R_T4) | \
+	 BIT(MIPS_R_T5))
+
+/* Caller-saved CPU registers */
+#define JIT_CALLER_REGS    \
+	(JIT_RETURN_REGS | \
+	 JIT_ARG_REGS    | \
+	 JIT_STACK_REGS)
+
+/* Callee-saved CPU registers */
+#define JIT_CALLEE_REGS   \
+	(BIT(MIPS_R_S0) | \
+	 BIT(MIPS_R_S1) | \
+	 BIT(MIPS_R_S2) | \
+	 BIT(MIPS_R_S3) | \
+	 BIT(MIPS_R_S4) | \
+	 BIT(MIPS_R_S5) | \
+	 BIT(MIPS_R_S6) | \
+	 BIT(MIPS_R_S7) | \
+	 BIT(MIPS_R_GP) | \
+	 BIT(MIPS_R_FP) | \
+	 BIT(MIPS_R_RA))
+
+/*
+ * Mapping of 64-bit eBPF registers to 32-bit native MIPS registers.
+ *
+ * 1) Native register pairs are ordered according to CPU endiannes, following
+ *    the MIPS convention for passing 64-bit arguments and return values.
+ * 2) The eBPF return value, arguments and callee-saved registers are mapped
+ *    to their native MIPS equivalents.
+ * 3) Since the 32 highest bits in the eBPF FP register are always zero,
+ *    only one general-purpose register is actually needed for the mapping.
+ *    We use the fp register for this purpose, and map the highest bits to
+ *    the MIPS register r0 (zero).
+ * 4) We use the MIPS gp and at registers as internal temporary registers
+ *    for constant blinding. The gp register is callee-saved.
+ * 5) One 64-bit temporary register is mapped for use when sign-extending
+ *    immediate operands. MIPS registers t6-t9 are available to the JIT
+ *    for as temporaries when implementing complex 64-bit operations.
+ *
+ * With this scheme all eBPF registers are being mapped to native MIPS
+ * registers without having to use any stack scratch space. The direct
+ * register mapping (2) simplifies the handling of function calls.
+ */
+static const u8 bpf2mips32[][2] = {
+	/* Return value from in-kernel function, and exit value from eBPF */
+	[BPF_REG_0] = {MIPS_R_V1, MIPS_R_V0},
+	/* Arguments from eBPF program to in-kernel function */
+	[BPF_REG_1] = {MIPS_R_A1, MIPS_R_A0},
+	[BPF_REG_2] = {MIPS_R_A3, MIPS_R_A2},
+	/* Remaining arguments, to be passed on the stack per O32 ABI */
+	[BPF_REG_3] = {MIPS_R_T1, MIPS_R_T0},
+	[BPF_REG_4] = {MIPS_R_T3, MIPS_R_T2},
+	[BPF_REG_5] = {MIPS_R_T5, MIPS_R_T4},
+	/* Callee-saved registers that in-kernel function will preserve */
+	[BPF_REG_6] = {MIPS_R_S1, MIPS_R_S0},
+	[BPF_REG_7] = {MIPS_R_S3, MIPS_R_S2},
+	[BPF_REG_8] = {MIPS_R_S5, MIPS_R_S4},
+	[BPF_REG_9] = {MIPS_R_S7, MIPS_R_S6},
+	/* Read-only frame pointer to access the eBPF stack */
+#ifdef __BIG_ENDIAN
+	[BPF_REG_FP] = {MIPS_R_FP, MIPS_R_ZERO},
+#else
+	[BPF_REG_FP] = {MIPS_R_ZERO, MIPS_R_FP},
+#endif
+	/* Temporary register for blinding constants */
+	[BPF_REG_AX] = {MIPS_R_GP, MIPS_R_AT},
+	/* Temporary register for internal JIT use */
+	[JIT_REG_TMP] = {MIPS_R_T7, MIPS_R_T6},
+};
+
+/* Get low CPU register for a 64-bit eBPF register mapping */
+static inline u8 lo(const u8 reg[])
+{
+#ifdef __BIG_ENDIAN
+	return reg[0];
+#else
+	return reg[1];
+#endif
+}
+
+/* Get high CPU register for a 64-bit eBPF register mapping */
+static inline u8 hi(const u8 reg[])
+{
+#ifdef __BIG_ENDIAN
+	return reg[1];
+#else
+	return reg[0];
+#endif
+}
+
+/*
+ * Mark a 64-bit CPU register pair as clobbered, it needs to be
+ * saved/restored by the program if callee-saved.
+ */
+static void clobber_reg64(struct jit_context *ctx, const u8 reg[])
+{
+	clobber_reg(ctx, reg[0]);
+	clobber_reg(ctx, reg[1]);
+}
+
+/* dst = imm (sign-extended) */
+static void emit_mov_se_i64(struct jit_context *ctx, const u8 dst[], s32 imm)
+{
+	emit_mov_i(ctx, lo(dst), imm);
+	if (imm < 0)
+		emit(ctx, addiu, hi(dst), MIPS_R_ZERO, -1);
+	else
+		emit(ctx, move, hi(dst), MIPS_R_ZERO);
+	clobber_reg64(ctx, dst);
+}
+
+/* Zero extension, if verifier does not do it for us  */
+static void emit_zext_ver(struct jit_context *ctx, const u8 dst[])
+{
+	if (!ctx->program->aux->verifier_zext) {
+		emit(ctx, move, hi(dst), MIPS_R_ZERO);
+		clobber_reg(ctx, hi(dst));
+	}
+}
+
+/* Load delay slot, if ISA mandates it */
+static void emit_load_delay(struct jit_context *ctx)
+{
+	if (!cpu_has_mips_2_3_4_5_r)
+		emit(ctx, nop);
+}
+
+/* ALU immediate operation (64-bit) */
+static void emit_alu_i64(struct jit_context *ctx,
+			 const u8 dst[], s32 imm, u8 op)
+{
+	u8 src = MIPS_R_T6;
+
+	/*
+	 * ADD/SUB with all but the max negative imm can be handled by
+	 * inverting the operation and the imm value, saving one insn.
+	 */
+	if (imm > S32_MIN && imm < 0)
+		switch (op) {
+		case BPF_ADD:
+			op = BPF_SUB;
+			imm = -imm;
+			break;
+		case BPF_SUB:
+			op = BPF_ADD;
+			imm = -imm;
+			break;
+		}
+
+	/* Move immediate to temporary register */
+	emit_mov_i(ctx, src, imm);
+
+	switch (op) {
+	/* dst = dst + imm */
+	case BPF_ADD:
+		emit(ctx, addu, lo(dst), lo(dst), src);
+		emit(ctx, sltu, MIPS_R_T9, lo(dst), src);
+		emit(ctx, addu, hi(dst), hi(dst), MIPS_R_T9);
+		if (imm < 0)
+			emit(ctx, addiu, hi(dst), hi(dst), -1);
+		break;
+	/* dst = dst - imm */
+	case BPF_SUB:
+		emit(ctx, sltu, MIPS_R_T9, lo(dst), src);
+		emit(ctx, subu, lo(dst), lo(dst), src);
+		emit(ctx, subu, hi(dst), hi(dst), MIPS_R_T9);
+		if (imm < 0)
+			emit(ctx, addiu, hi(dst), hi(dst), 1);
+		break;
+	/* dst = dst | imm */
+	case BPF_OR:
+		emit(ctx, or, lo(dst), lo(dst), src);
+		if (imm < 0)
+			emit(ctx, addiu, hi(dst), MIPS_R_ZERO, -1);
+		break;
+	/* dst = dst & imm */
+	case BPF_AND:
+		emit(ctx, and, lo(dst), lo(dst), src);
+		if (imm >= 0)
+			emit(ctx, move, hi(dst), MIPS_R_ZERO);
+		break;
+	/* dst = dst ^ imm */
+	case BPF_XOR:
+		emit(ctx, xor, lo(dst), lo(dst), src);
+		if (imm < 0) {
+			emit(ctx, subu, hi(dst), MIPS_R_ZERO, hi(dst));
+			emit(ctx, addiu, hi(dst), hi(dst), -1);
+		}
+		break;
+	}
+	clobber_reg64(ctx, dst);
+}
+
+/* ALU register operation (64-bit) */
+static void emit_alu_r64(struct jit_context *ctx,
+			 const u8 dst[], const u8 src[], u8 op)
+{
+	switch (BPF_OP(op)) {
+	/* dst = dst + src */
+	case BPF_ADD:
+		if (src == dst) {
+			emit(ctx, srl, MIPS_R_T9, lo(dst), 31);
+			emit(ctx, addu, lo(dst), lo(dst), lo(dst));
+		} else {
+			emit(ctx, addu, lo(dst), lo(dst), lo(src));
+			emit(ctx, sltu, MIPS_R_T9, lo(dst), lo(src));
+		}
+		emit(ctx, addu, hi(dst), hi(dst), hi(src));
+		emit(ctx, addu, hi(dst), hi(dst), MIPS_R_T9);
+		break;
+	/* dst = dst - src */
+	case BPF_SUB:
+		emit(ctx, sltu, MIPS_R_T9, lo(dst), lo(src));
+		emit(ctx, subu, lo(dst), lo(dst), lo(src));
+		emit(ctx, subu, hi(dst), hi(dst), hi(src));
+		emit(ctx, subu, hi(dst), hi(dst), MIPS_R_T9);
+		break;
+	/* dst = dst | src */
+	case BPF_OR:
+		emit(ctx, or, lo(dst), lo(dst), lo(src));
+		emit(ctx, or, hi(dst), hi(dst), hi(src));
+		break;
+	/* dst = dst & src */
+	case BPF_AND:
+		emit(ctx, and, lo(dst), lo(dst), lo(src));
+		emit(ctx, and, hi(dst), hi(dst), hi(src));
+		break;
+	/* dst = dst ^ src */
+	case BPF_XOR:
+		emit(ctx, xor, lo(dst), lo(dst), lo(src));
+		emit(ctx, xor, hi(dst), hi(dst), hi(src));
+		break;
+	}
+	clobber_reg64(ctx, dst);
+}
+
+/* ALU invert (64-bit) */
+static void emit_neg_i64(struct jit_context *ctx, const u8 dst[])
+{
+	emit(ctx, sltu, MIPS_R_T9, MIPS_R_ZERO, lo(dst));
+	emit(ctx, subu, lo(dst), MIPS_R_ZERO, lo(dst));
+	emit(ctx, subu, hi(dst), MIPS_R_ZERO, hi(dst));
+	emit(ctx, subu, hi(dst), hi(dst), MIPS_R_T9);
+
+	clobber_reg64(ctx, dst);
+}
+
+/* ALU shift immediate (64-bit) */
+static void emit_shift_i64(struct jit_context *ctx,
+			   const u8 dst[], u32 imm, u8 op)
+{
+	switch (BPF_OP(op)) {
+	/* dst = dst << imm */
+	case BPF_LSH:
+		if (imm < 32) {
+			emit(ctx, srl, MIPS_R_T9, lo(dst), 32 - imm);
+			emit(ctx, sll, lo(dst), lo(dst), imm);
+			emit(ctx, sll, hi(dst), hi(dst), imm);
+			emit(ctx, or, hi(dst), hi(dst), MIPS_R_T9);
+		} else {
+			emit(ctx, sll, hi(dst), lo(dst), imm - 32);
+			emit(ctx, move, lo(dst), MIPS_R_ZERO);
+		}
+		break;
+	/* dst = dst >> imm */
+	case BPF_RSH:
+		if (imm < 32) {
+			emit(ctx, sll, MIPS_R_T9, hi(dst), 32 - imm);
+			emit(ctx, srl, lo(dst), lo(dst), imm);
+			emit(ctx, srl, hi(dst), hi(dst), imm);
+			emit(ctx, or, lo(dst), lo(dst), MIPS_R_T9);
+		} else {
+			emit(ctx, srl, lo(dst), hi(dst), imm - 32);
+			emit(ctx, move, hi(dst), MIPS_R_ZERO);
+		}
+		break;
+	/* dst = dst >> imm (arithmetic) */
+	case BPF_ARSH:
+		if (imm < 32) {
+			emit(ctx, sll, MIPS_R_T9, hi(dst), 32 - imm);
+			emit(ctx, srl, lo(dst), lo(dst), imm);
+			emit(ctx, sra, hi(dst), hi(dst), imm);
+			emit(ctx, or, lo(dst), lo(dst), MIPS_R_T9);
+		} else {
+			emit(ctx, sra, lo(dst), hi(dst), imm - 32);
+			emit(ctx, sra, hi(dst), hi(dst), 31);
+		}
+		break;
+	}
+	clobber_reg64(ctx, dst);
+}
+
+/* ALU shift register (64-bit) */
+static void emit_shift_r64(struct jit_context *ctx,
+			   const u8 dst[], u8 src, u8 op)
+{
+	u8 t1 = MIPS_R_T8;
+	u8 t2 = MIPS_R_T9;
+
+	emit(ctx, andi, t1, src, 32);              /* t1 = src & 32          */
+	emit(ctx, beqz, t1, 16);                   /* PC += 16 if t1 == 0    */
+	emit(ctx, nor, t2, src, MIPS_R_ZERO);      /* t2 = ~src (delay slot) */
+
+	switch (BPF_OP(op)) {
+	/* dst = dst << src */
+	case BPF_LSH:
+		/* Next: shift >= 32 */
+		emit(ctx, sllv, hi(dst), lo(dst), src);    /* dh = dl << src */
+		emit(ctx, move, lo(dst), MIPS_R_ZERO);     /* dl = 0         */
+		emit(ctx, b, 20);                          /* PC += 20       */
+		/* +16: shift < 32 */
+		emit(ctx, srl, t1, lo(dst), 1);            /* t1 = dl >> 1   */
+		emit(ctx, srlv, t1, t1, t2);               /* t1 = t1 >> t2  */
+		emit(ctx, sllv, lo(dst), lo(dst), src);    /* dl = dl << src */
+		emit(ctx, sllv, hi(dst), hi(dst), src);    /* dh = dh << src */
+		emit(ctx, or, hi(dst), hi(dst), t1);       /* dh = dh | t1   */
+		break;
+	/* dst = dst >> src */
+	case BPF_RSH:
+		/* Next: shift >= 32 */
+		emit(ctx, srlv, lo(dst), hi(dst), src);    /* dl = dh >> src */
+		emit(ctx, move, hi(dst), MIPS_R_ZERO);     /* dh = 0         */
+		emit(ctx, b, 20);                          /* PC += 20       */
+		/* +16: shift < 32 */
+		emit(ctx, sll, t1, hi(dst), 1);            /* t1 = dl << 1   */
+		emit(ctx, sllv, t1, t1, t2);               /* t1 = t1 << t2  */
+		emit(ctx, srlv, lo(dst), lo(dst), src);    /* dl = dl >> src */
+		emit(ctx, srlv, hi(dst), hi(dst), src);    /* dh = dh >> src */
+		emit(ctx, or, lo(dst), lo(dst), t1);       /* dl = dl | t1   */
+		break;
+	/* dst = dst >> src (arithmetic) */
+	case BPF_ARSH:
+		/* Next: shift >= 32 */
+		emit(ctx, srav, lo(dst), hi(dst), src);   /* dl = dh >>a src */
+		emit(ctx, sra, hi(dst), hi(dst), 31);     /* dh = dh >>a 31  */
+		emit(ctx, b, 20);                         /* PC += 20        */
+		/* +16: shift < 32 */
+		emit(ctx, sll, t1, hi(dst), 1);           /* t1 = dl << 1    */
+		emit(ctx, sllv, t1, t1, t2);              /* t1 = t1 << t2   */
+		emit(ctx, srlv, lo(dst), lo(dst), src);   /* dl = dl >>a src */
+		emit(ctx, srav, hi(dst), hi(dst), src);   /* dh = dh >> src  */
+		emit(ctx, or, lo(dst), lo(dst), t1);      /* dl = dl | t1    */
+		break;
+	}
+
+	/* +20: Done */
+	clobber_reg64(ctx, dst);
+}
+
+/* ALU mul immediate (64x32-bit) */
+static void emit_mul_i64(struct jit_context *ctx, const u8 dst[], s32 imm)
+{
+	u8 src = MIPS_R_T6;
+	u8 tmp = MIPS_R_T9;
+
+	switch (imm) {
+	/* dst = dst * 1 is a no-op */
+	case 1:
+		break;
+	/* dst = dst * -1 */
+	case -1:
+		emit_neg_i64(ctx, dst);
+		break;
+	case 0:
+		emit_mov_r(ctx, lo(dst), MIPS_R_ZERO);
+		emit_mov_r(ctx, hi(dst), MIPS_R_ZERO);
+		break;
+	/* Full 64x32 multiply */
+	default:
+		/* hi(dst) = hi(dst) * src(imm) */
+		emit_mov_i(ctx, src, imm);
+		if (cpu_has_mips32r1 || cpu_has_mips32r6) {
+			emit(ctx, mul, hi(dst), hi(dst), src);
+		} else {
+			emit(ctx, multu, hi(dst), src);
+			emit(ctx, mflo, hi(dst));
+		}
+
+		/* hi(dst) = hi(dst) - lo(dst) */
+		if (imm < 0)
+			emit(ctx, subu, hi(dst), hi(dst), lo(dst));
+
+		/* tmp = lo(dst) * src(imm) >> 32 */
+		/* lo(dst) = lo(dst) * src(imm) */
+		if (cpu_has_mips32r6) {
+			emit(ctx, muhu, tmp, lo(dst), src);
+			emit(ctx, mulu, lo(dst), lo(dst), src);
+		} else {
+			emit(ctx, multu, lo(dst), src);
+			emit(ctx, mflo, lo(dst));
+			emit(ctx, mfhi, tmp);
+		}
+
+		/* hi(dst) += tmp */
+		emit(ctx, addu, hi(dst), hi(dst), tmp);
+		clobber_reg64(ctx, dst);
+		break;
+	}
+}
+
+/* ALU mul register (64x64-bit) */
+static void emit_mul_r64(struct jit_context *ctx,
+			 const u8 dst[], const u8 src[])
+{
+	u8 acc = MIPS_R_T8;
+	u8 tmp = MIPS_R_T9;
+
+	/* acc = hi(dst) * lo(src) */
+	if (cpu_has_mips32r1 || cpu_has_mips32r6) {
+		emit(ctx, mul, acc, hi(dst), lo(src));
+	} else {
+		emit(ctx, multu, hi(dst), lo(src));
+		emit(ctx, mflo, acc);
+	}
+
+	/* tmp = lo(dst) * hi(src) */
+	if (cpu_has_mips32r1 || cpu_has_mips32r6) {
+		emit(ctx, mul, tmp, lo(dst), hi(src));
+	} else {
+		emit(ctx, multu, lo(dst), hi(src));
+		emit(ctx, mflo, tmp);
+	}
+
+	/* acc += tmp */
+	emit(ctx, addu, acc, acc, tmp);
+
+	/* tmp = lo(dst) * lo(src) >> 32 */
+	/* lo(dst) = lo(dst) * lo(src) */
+	if (cpu_has_mips32r6) {
+		emit(ctx, muhu, tmp, lo(dst), lo(src));
+		emit(ctx, mulu, lo(dst), lo(dst), lo(src));
+	} else {
+		emit(ctx, multu, lo(dst), lo(src));
+		emit(ctx, mflo, lo(dst));
+		emit(ctx, mfhi, tmp);
+	}
+
+	/* hi(dst) = acc + tmp */
+	emit(ctx, addu, hi(dst), acc, tmp);
+	clobber_reg64(ctx, dst);
+}
+
+/* Helper function for 64-bit modulo */
+static u64 jit_mod64(u64 a, u64 b)
+{
+	u64 rem;
+
+	div64_u64_rem(a, b, &rem);
+	return rem;
+}
+
+/* ALU div/mod register (64-bit) */
+static void emit_divmod_r64(struct jit_context *ctx,
+			    const u8 dst[], const u8 src[], u8 op)
+{
+	const u8 *r0 = bpf2mips32[BPF_REG_0]; /* Mapped to v0-v1 */
+	const u8 *r1 = bpf2mips32[BPF_REG_1]; /* Mapped to a0-a1 */
+	const u8 *r2 = bpf2mips32[BPF_REG_2]; /* Mapped to a2-a3 */
+	int exclude, k;
+	u32 addr = 0;
+
+	/* Push caller-saved registers on stack */
+	push_regs(ctx, ctx->clobbered & JIT_CALLER_REGS,
+		  0, JIT_RESERVED_STACK);
+
+	/* Put 64-bit arguments 1 and 2 in registers a0-a3 */
+	for (k = 0; k < 2; k++) {
+		emit(ctx, move, MIPS_R_T9, src[k]);
+		emit(ctx, move, r1[k], dst[k]);
+		emit(ctx, move, r2[k], MIPS_R_T9);
+	}
+
+	/* Emit function call */
+	switch (BPF_OP(op)) {
+	/* dst = dst / src */
+	case BPF_DIV:
+		addr = (u32)&div64_u64;
+		break;
+	/* dst = dst % src */
+	case BPF_MOD:
+		addr = (u32)&jit_mod64;
+		break;
+	}
+	emit_mov_i(ctx, MIPS_R_T9, addr);
+	emit(ctx, jalr, MIPS_R_RA, MIPS_R_T9);
+	emit(ctx, nop); /* Delay slot */
+
+	/* Store the 64-bit result in dst */
+	emit(ctx, move, dst[0], r0[0]);
+	emit(ctx, move, dst[1], r0[1]);
+
+	/* Restore caller-saved registers, excluding the computed result */
+	exclude = BIT(lo(dst)) | BIT(hi(dst));
+	pop_regs(ctx, ctx->clobbered & JIT_CALLER_REGS,
+		 exclude, JIT_RESERVED_STACK);
+	emit_load_delay(ctx);
+
+	clobber_reg64(ctx, dst);
+	clobber_reg(ctx, MIPS_R_V0);
+	clobber_reg(ctx, MIPS_R_V1);
+	clobber_reg(ctx, MIPS_R_RA);
+}
+
+/* Swap bytes in a register word */
+static void emit_swap8_r(struct jit_context *ctx, u8 dst, u8 src, u8 mask)
+{
+	u8 tmp = MIPS_R_T9;
+
+	emit(ctx, and, tmp, src, mask); /* tmp = src & 0x00ff00ff */
+	emit(ctx, sll, tmp, tmp, 8);    /* tmp = tmp << 8         */
+	emit(ctx, srl, dst, src, 8);    /* dst = src >> 8         */
+	emit(ctx, and, dst, dst, mask); /* dst = dst & 0x00ff00ff */
+	emit(ctx, or,  dst, dst, tmp);  /* dst = dst | tmp        */
+}
+
+/* Swap half words in a register word */
+static void emit_swap16_r(struct jit_context *ctx, u8 dst, u8 src)
+{
+	u8 tmp = MIPS_R_T9;
+
+	emit(ctx, sll, tmp, src, 16);  /* tmp = src << 16 */
+	emit(ctx, srl, dst, src, 16);  /* dst = src >> 16 */
+	emit(ctx, or,  dst, dst, tmp); /* dst = dst | tmp */
+}
+
+/* Swap bytes and truncate a register double word, word or half word */
+static void emit_bswap_r64(struct jit_context *ctx, const u8 dst[], u32 width)
+{
+	u8 tmp = MIPS_R_T8;
+
+	switch (width) {
+	/* Swap bytes in a double word */
+	case 64:
+		if (cpu_has_mips32r2 || cpu_has_mips32r6) {
+			emit(ctx, rotr, tmp, hi(dst), 16);
+			emit(ctx, rotr, hi(dst), lo(dst), 16);
+			emit(ctx, wsbh, lo(dst), tmp);
+			emit(ctx, wsbh, hi(dst), hi(dst));
+		} else {
+			emit_swap16_r(ctx, tmp, lo(dst));
+			emit_swap16_r(ctx, lo(dst), hi(dst));
+			emit(ctx, move, hi(dst), tmp);
+
+			emit(ctx, lui, tmp, 0xff);      /* tmp = 0x00ff0000 */
+			emit(ctx, ori, tmp, tmp, 0xff); /* tmp = 0x00ff00ff */
+			emit_swap8_r(ctx, lo(dst), lo(dst), tmp);
+			emit_swap8_r(ctx, hi(dst), hi(dst), tmp);
+		}
+		break;
+	/* Swap bytes in a word */
+	/* Swap bytes in a half word */
+	case 32:
+	case 16:
+		emit_bswap_r(ctx, lo(dst), width);
+		emit(ctx, move, hi(dst), MIPS_R_ZERO);
+		break;
+	}
+	clobber_reg64(ctx, dst);
+}
+
+/* Truncate a register double word, word or half word */
+static void emit_trunc_r64(struct jit_context *ctx, const u8 dst[], u32 width)
+{
+	switch (width) {
+	case 64:
+		break;
+	/* Zero-extend a word */
+	case 32:
+		emit(ctx, move, hi(dst), MIPS_R_ZERO);
+		clobber_reg(ctx, hi(dst));
+		break;
+	/* Zero-extend a half word */
+	case 16:
+		emit(ctx, move, hi(dst), MIPS_R_ZERO);
+		emit(ctx, andi, lo(dst), lo(dst), 0xffff);
+		clobber_reg64(ctx, dst);
+		break;
+	}
+}
+
+/* Load operation: dst = *(size*)(src + off) */
+static void emit_ldx(struct jit_context *ctx,
+		     const u8 dst[], u8 src, s16 off, u8 size)
+{
+	switch (size) {
+	/* Load a byte */
+	case BPF_B:
+		emit(ctx, lbu, lo(dst), off, src);
+		emit(ctx, move, hi(dst), MIPS_R_ZERO);
+		break;
+	/* Load a half word */
+	case BPF_H:
+		emit(ctx, lhu, lo(dst), off, src);
+		emit(ctx, move, hi(dst), MIPS_R_ZERO);
+		break;
+	/* Load a word */
+	case BPF_W:
+		emit(ctx, lw, lo(dst), off, src);
+		emit(ctx, move, hi(dst), MIPS_R_ZERO);
+		break;
+	/* Load a double word */
+	case BPF_DW:
+		if (dst[1] == src) {
+			emit(ctx, lw, dst[0], off + 4, src);
+			emit(ctx, lw, dst[1], off, src);
+		} else {
+			emit(ctx, lw, dst[1], off, src);
+			emit(ctx, lw, dst[0], off + 4, src);
+		}
+		emit_load_delay(ctx);
+		break;
+	}
+	clobber_reg64(ctx, dst);
+}
+
+/* Store operation: *(size *)(dst + off) = src */
+static void emit_stx(struct jit_context *ctx,
+		     const u8 dst, const u8 src[], s16 off, u8 size)
+{
+	switch (size) {
+	/* Store a byte */
+	case BPF_B:
+		emit(ctx, sb, lo(src), off, dst);
+		break;
+	/* Store a half word */
+	case BPF_H:
+		emit(ctx, sh, lo(src), off, dst);
+		break;
+	/* Store a word */
+	case BPF_W:
+		emit(ctx, sw, lo(src), off, dst);
+		break;
+	/* Store a double word */
+	case BPF_DW:
+		emit(ctx, sw, src[1], off, dst);
+		emit(ctx, sw, src[0], off + 4, dst);
+		break;
+	}
+}
+
+/* Atomic read-modify-write (32-bit, non-ll/sc fallback) */
+static void emit_atomic_r32(struct jit_context *ctx,
+			    u8 dst, u8 src, s16 off, u8 code)
+{
+	u32 exclude = 0;
+	u32 addr = 0;
+
+	/* Push caller-saved registers on stack */
+	push_regs(ctx, ctx->clobbered & JIT_CALLER_REGS,
+		  0, JIT_RESERVED_STACK);
+	/*
+	 * Argument 1: dst+off if xchg, otherwise src, passed in register a0
+	 * Argument 2: src if xchg, othersize dst+off, passed in register a1
+	 */
+	emit(ctx, move, MIPS_R_T9, dst);
+	if (code == BPF_XCHG) {
+		emit(ctx, move, MIPS_R_A1, src);
+		emit(ctx, addiu, MIPS_R_A0, MIPS_R_T9, off);
+	} else {
+		emit(ctx, move, MIPS_R_A0, src);
+		emit(ctx, addiu, MIPS_R_A1, MIPS_R_T9, off);
+	}
+
+	/* Emit function call */
+	switch (code) {
+	case BPF_ADD:
+		addr = (u32)&atomic_add;
+		break;
+	case BPF_ADD | BPF_FETCH:
+		addr = (u32)&atomic_fetch_add;
+		break;
+	case BPF_SUB:
+		addr = (u32)&atomic_sub;
+		break;
+	case BPF_SUB | BPF_FETCH:
+		addr = (u32)&atomic_fetch_sub;
+		break;
+	case BPF_OR:
+		addr = (u32)&atomic_or;
+		break;
+	case BPF_OR | BPF_FETCH:
+		addr = (u32)&atomic_fetch_or;
+		break;
+	case BPF_AND:
+		addr = (u32)&atomic_and;
+		break;
+	case BPF_AND | BPF_FETCH:
+		addr = (u32)&atomic_fetch_and;
+		break;
+	case BPF_XOR:
+		addr = (u32)&atomic_xor;
+		break;
+	case BPF_XOR | BPF_FETCH:
+		addr = (u32)&atomic_fetch_xor;
+		break;
+	case BPF_XCHG:
+		addr = (u32)&atomic_xchg;
+		break;
+	}
+	emit_mov_i(ctx, MIPS_R_T9, addr);
+	emit(ctx, jalr, MIPS_R_RA, MIPS_R_T9);
+	emit(ctx, nop); /* Delay slot */
+
+	/* Update src register with old value, if specified */
+	if (code & BPF_FETCH) {
+		emit(ctx, move, src, MIPS_R_V0);
+		exclude = BIT(src);
+		clobber_reg(ctx, src);
+	}
+
+	/* Restore caller-saved registers, except any fetched value */
+	pop_regs(ctx, ctx->clobbered & JIT_CALLER_REGS,
+		 exclude, JIT_RESERVED_STACK);
+	emit_load_delay(ctx);
+	clobber_reg(ctx, MIPS_R_RA);
+}
+
+/* Helper function for 64-bit atomic exchange */
+static s64 jit_xchg64(s64 a, atomic64_t *v)
+{
+	return atomic64_xchg(v, a);
+}
+
+/* Atomic read-modify-write (64-bit) */
+static void emit_atomic_r64(struct jit_context *ctx,
+			    u8 dst, const u8 src[], s16 off, u8 code)
+{
+	const u8 *r0 = bpf2mips32[BPF_REG_0]; /* Mapped to v0-v1 */
+	const u8 *r1 = bpf2mips32[BPF_REG_1]; /* Mapped to a0-a1 */
+	u32 exclude = 0;
+	u32 addr = 0;
+
+	/* Push caller-saved registers on stack */
+	push_regs(ctx, ctx->clobbered & JIT_CALLER_REGS,
+		  0, JIT_RESERVED_STACK);
+	/*
+	 * Argument 1: 64-bit src, passed in registers a0-a1
+	 * Argument 2: 32-bit dst+off, passed in register a2
+	 */
+	emit(ctx, move, MIPS_R_T9, dst);
+	emit(ctx, move, r1[0], src[0]);
+	emit(ctx, move, r1[1], src[1]);
+	emit(ctx, addiu, MIPS_R_A2, MIPS_R_T9, off);
+
+	/* Emit function call */
+	switch (code) {
+	case BPF_ADD:
+		addr = (u32)&atomic64_add;
+		break;
+	case BPF_ADD | BPF_FETCH:
+		addr = (u32)&atomic64_fetch_add;
+		break;
+	case BPF_SUB:
+		addr = (u32)&atomic64_sub;
+		break;
+	case BPF_SUB | BPF_FETCH:
+		addr = (u32)&atomic64_fetch_sub;
+		break;
+	case BPF_OR:
+		addr = (u32)&atomic64_or;
+		break;
+	case BPF_OR | BPF_FETCH:
+		addr = (u32)&atomic64_fetch_or;
+		break;
+	case BPF_AND:
+		addr = (u32)&atomic64_and;
+		break;
+	case BPF_AND | BPF_FETCH:
+		addr = (u32)&atomic64_fetch_and;
+		break;
+	case BPF_XOR:
+		addr = (u32)&atomic64_xor;
+		break;
+	case BPF_XOR | BPF_FETCH:
+		addr = (u32)&atomic64_fetch_xor;
+		break;
+	case BPF_XCHG:
+		addr = (u32)&jit_xchg64;
+		break;
+	}
+	emit_mov_i(ctx, MIPS_R_T9, addr);
+	emit(ctx, jalr, MIPS_R_RA, MIPS_R_T9);
+	emit(ctx, nop); /* Delay slot */
+
+	/* Update src register with old value, if specified */
+	if (code & BPF_FETCH) {
+		emit(ctx, move, lo(src), lo(r0));
+		emit(ctx, move, hi(src), hi(r0));
+		exclude = BIT(src[0]) | BIT(src[1]);
+		clobber_reg64(ctx, src);
+	}
+
+	/* Restore caller-saved registers, except any fetched value */
+	pop_regs(ctx, ctx->clobbered & JIT_CALLER_REGS,
+		 exclude, JIT_RESERVED_STACK);
+	emit_load_delay(ctx);
+	clobber_reg(ctx, MIPS_R_RA);
+}
+
+/* Atomic compare-and-exchange (32-bit, non-ll/sc fallback) */
+static void emit_cmpxchg_r32(struct jit_context *ctx, u8 dst, u8 src, s16 off)
+{
+	const u8 *r0 = bpf2mips32[BPF_REG_0];
+
+	/* Push caller-saved registers on stack */
+	push_regs(ctx, ctx->clobbered & JIT_CALLER_REGS,
+		  JIT_RETURN_REGS, JIT_RESERVED_STACK + 2 * sizeof(u32));
+	/*
+	 * Argument 1: 32-bit dst+off, passed in register a0
+	 * Argument 2: 32-bit r0, passed in register a1
+	 * Argument 3: 32-bit src, passed in register a2
+	 */
+	emit(ctx, addiu, MIPS_R_T9, dst, off);
+	emit(ctx, move, MIPS_R_T8, src);
+	emit(ctx, move, MIPS_R_A1, lo(r0));
+	emit(ctx, move, MIPS_R_A0, MIPS_R_T9);
+	emit(ctx, move, MIPS_R_A2, MIPS_R_T8);
+
+	/* Emit function call */
+	emit_mov_i(ctx, MIPS_R_T9, (u32)&atomic_cmpxchg);
+	emit(ctx, jalr, MIPS_R_RA, MIPS_R_T9);
+	emit(ctx, nop); /* Delay slot */
+
+#ifdef __BIG_ENDIAN
+	emit(ctx, move, lo(r0), MIPS_R_V0);
+#endif
+	/* Restore caller-saved registers, except the return value */
+	pop_regs(ctx, ctx->clobbered & JIT_CALLER_REGS,
+		 JIT_RETURN_REGS, JIT_RESERVED_STACK + 2 * sizeof(u32));
+	emit_load_delay(ctx);
+	clobber_reg(ctx, MIPS_R_V0);
+	clobber_reg(ctx, MIPS_R_V1);
+	clobber_reg(ctx, MIPS_R_RA);
+}
+
+/* Atomic compare-and-exchange (64-bit) */
+static void emit_cmpxchg_r64(struct jit_context *ctx,
+			     u8 dst, const u8 src[], s16 off)
+{
+	const u8 *r0 = bpf2mips32[BPF_REG_0];
+	const u8 *r2 = bpf2mips32[BPF_REG_2];
+
+	/* Push caller-saved registers on stack */
+	push_regs(ctx, ctx->clobbered & JIT_CALLER_REGS,
+		  JIT_RETURN_REGS, JIT_RESERVED_STACK + 2 * sizeof(u32));
+	/*
+	 * Argument 1: 32-bit dst+off, passed in register a0 (a1 unused)
+	 * Argument 2: 64-bit r0, passed in registers a2-a3
+	 * Argument 3: 64-bit src, passed on stack
+	 */
+	push_regs(ctx, BIT(src[0]) | BIT(src[1]), 0, JIT_RESERVED_STACK);
+	emit(ctx, addiu, MIPS_R_T9, dst, off);
+	emit(ctx, move, r2[0], r0[0]);
+	emit(ctx, move, r2[1], r0[1]);
+	emit(ctx, move, MIPS_R_A0, MIPS_R_T9);
+
+	/* Emit function call */
+	emit_mov_i(ctx, MIPS_R_T9, (u32)&atomic64_cmpxchg);
+	emit(ctx, jalr, MIPS_R_RA, MIPS_R_T9);
+	emit(ctx, nop); /* Delay slot */
+
+	/* Restore caller-saved registers, except the return value */
+	pop_regs(ctx, ctx->clobbered & JIT_CALLER_REGS,
+		 JIT_RETURN_REGS, JIT_RESERVED_STACK + 2 * sizeof(u32));
+	emit_load_delay(ctx);
+	clobber_reg(ctx, MIPS_R_V0);
+	clobber_reg(ctx, MIPS_R_V1);
+	clobber_reg(ctx, MIPS_R_RA);
+}
+
+/*
+ * Conditional movz or an emulated equivalent.
+ * Note that the rs register may be modified.
+ */
+static void emit_movz_r(struct jit_context *ctx, u8 rd, u8 rs, u8 rt)
+{
+	if (cpu_has_mips_2) {
+		emit(ctx, movz, rd, rs, rt);           /* rd = rt ? rd : rs  */
+	} else if (cpu_has_mips32r6) {
+		if (rs != MIPS_R_ZERO)
+			emit(ctx, seleqz, rs, rs, rt); /* rs = 0 if rt == 0  */
+		emit(ctx, selnez, rd, rd, rt);         /* rd = 0 if rt != 0  */
+		if (rs != MIPS_R_ZERO)
+			emit(ctx, or, rd, rd, rs);     /* rd = rd | rs       */
+	} else {
+		emit(ctx, bnez, rt, 8);                /* PC += 8 if rd != 0 */
+		emit(ctx, nop);                        /* +0: delay slot     */
+		emit(ctx, or, rd, rs, MIPS_R_ZERO);    /* +4: rd = rs        */
+	}
+	clobber_reg(ctx, rd);
+	clobber_reg(ctx, rs);
+}
+
+/*
+ * Conditional movn or an emulated equivalent.
+ * Note that the rs register may be modified.
+ */
+static void emit_movn_r(struct jit_context *ctx, u8 rd, u8 rs, u8 rt)
+{
+	if (cpu_has_mips_2) {
+		emit(ctx, movn, rd, rs, rt);           /* rd = rt ? rs : rd  */
+	} else if (cpu_has_mips32r6) {
+		if (rs != MIPS_R_ZERO)
+			emit(ctx, selnez, rs, rs, rt); /* rs = 0 if rt == 0  */
+		emit(ctx, seleqz, rd, rd, rt);         /* rd = 0 if rt != 0  */
+		if (rs != MIPS_R_ZERO)
+			emit(ctx, or, rd, rd, rs);     /* rd = rd | rs       */
+	} else {
+		emit(ctx, beqz, rt, 8);                /* PC += 8 if rd == 0 */
+		emit(ctx, nop);                        /* +0: delay slot     */
+		emit(ctx, or, rd, rs, MIPS_R_ZERO);    /* +4: rd = rs        */
+	}
+	clobber_reg(ctx, rd);
+	clobber_reg(ctx, rs);
+}
+
+/* Emulation of 64-bit sltiu rd, rs, imm, where imm may be S32_MAX + 1 */
+static void emit_sltiu_r64(struct jit_context *ctx, u8 rd,
+			   const u8 rs[], s64 imm)
+{
+	u8 tmp = MIPS_R_T9;
+
+	if (imm < 0) {
+		emit_mov_i(ctx, rd, imm);                 /* rd = imm        */
+		emit(ctx, sltu, rd, lo(rs), rd);          /* rd = rsl < rd   */
+		emit(ctx, sltiu, tmp, hi(rs), -1);        /* tmp = rsh < ~0U */
+		emit(ctx, or, rd, rd, tmp);               /* rd = rd | tmp   */
+	} else { /* imm >= 0 */
+		if (imm > 0x7fff) {
+			emit_mov_i(ctx, rd, (s32)imm);     /* rd = imm       */
+			emit(ctx, sltu, rd, lo(rs), rd);   /* rd = rsl < rd  */
+		} else {
+			emit(ctx, sltiu, rd, lo(rs), imm); /* rd = rsl < imm */
+		}
+		emit_movn_r(ctx, rd, MIPS_R_ZERO, hi(rs)); /* rd = 0 if rsh  */
+	}
+}
+
+/* Emulation of 64-bit sltu rd, rs, rt */
+static void emit_sltu_r64(struct jit_context *ctx, u8 rd,
+			  const u8 rs[], const u8 rt[])
+{
+	u8 tmp = MIPS_R_T9;
+
+	emit(ctx, sltu, rd, lo(rs), lo(rt));           /* rd = rsl < rtl     */
+	emit(ctx, subu, tmp, hi(rs), hi(rt));          /* tmp = rsh - rth    */
+	emit_movn_r(ctx, rd, MIPS_R_ZERO, tmp);        /* rd = 0 if tmp != 0 */
+	emit(ctx, sltu, tmp, hi(rs), hi(rt));          /* tmp = rsh < rth    */
+	emit(ctx, or, rd, rd, tmp);                    /* rd = rd | tmp      */
+}
+
+/* Emulation of 64-bit slti rd, rs, imm, where imm may be S32_MAX + 1 */
+static void emit_slti_r64(struct jit_context *ctx, u8 rd,
+			  const u8 rs[], s64 imm)
+{
+	u8 t1 = MIPS_R_T8;
+	u8 t2 = MIPS_R_T9;
+	u8 cmp;
+
+	/*
+	 * if ((rs < 0) ^ (imm < 0)) t1 = imm >u rsl
+	 * else                      t1 = rsl <u imm
+	 */
+	emit_mov_i(ctx, rd, (s32)imm);
+	emit(ctx, sltu, t1, lo(rs), rd);               /* t1 = rsl <u imm   */
+	emit(ctx, sltu, t2, rd, lo(rs));               /* t2 = imm <u rsl   */
+	emit(ctx, srl, rd, hi(rs), 31);                /* rd = rsh >> 31    */
+	if (imm < 0)
+		emit_movz_r(ctx, t1, t2, rd);          /* t1 = rd ? t1 : t2 */
+	else
+		emit_movn_r(ctx, t1, t2, rd);          /* t1 = rd ? t2 : t1 */
+	/*
+	 * if ((imm < 0 && rsh != 0xffffffff) ||
+	 *     (imm >= 0 && rsh != 0))
+	 *      t1 = 0
+	 */
+	if (imm < 0) {
+		emit(ctx, addiu, rd, hi(rs), 1);       /* rd = rsh + 1 */
+		cmp = rd;
+	} else { /* imm >= 0 */
+		cmp = hi(rs);
+	}
+	emit_movn_r(ctx, t1, MIPS_R_ZERO, cmp);        /* t1 = 0 if cmp != 0 */
+
+	/*
+	 * if (imm < 0) rd = rsh < -1
+	 * else         rd = rsh != 0
+	 * rd = rd | t1
+	 */
+	emit(ctx, slti, rd, hi(rs), imm < 0 ? -1 : 0); /* rd = rsh < hi(imm) */
+	emit(ctx, or, rd, rd, t1);                     /* rd = rd | t1       */
+}
+
+/* Emulation of 64-bit(slt rd, rs, rt) */
+static void emit_slt_r64(struct jit_context *ctx, u8 rd,
+			 const u8 rs[], const u8 rt[])
+{
+	u8 t1 = MIPS_R_T7;
+	u8 t2 = MIPS_R_T8;
+	u8 t3 = MIPS_R_T9;
+
+	/*
+	 * if ((rs < 0) ^ (rt < 0)) t1 = rtl <u rsl
+	 * else                     t1 = rsl <u rtl
+	 * if (rsh == rth)          t1 = 0
+	 */
+	emit(ctx, sltu, t1, lo(rs), lo(rt));           /* t1 = rsl <u rtl   */
+	emit(ctx, sltu, t2, lo(rt), lo(rs));           /* t2 = rtl <u rsl   */
+	emit(ctx, xor, t3, hi(rs), hi(rt));            /* t3 = rlh ^ rth    */
+	emit(ctx, srl, rd, t3, 31);                    /* rd = t3 >> 31     */
+	emit_movn_r(ctx, t1, t2, rd);                  /* t1 = rd ? t2 : t1 */
+	emit_movn_r(ctx, t1, MIPS_R_ZERO, t3);         /* t1 = 0 if t3 != 0 */
+
+	/* rd = (rsh < rth) | t1 */
+	emit(ctx, slt, rd, hi(rs), hi(rt));            /* rd = rsh <s rth   */
+	emit(ctx, or, rd, rd, t1);                     /* rd = rd | t1      */
+}
+
+/* Jump immediate (64-bit) */
+static void emit_jmp_i64(struct jit_context *ctx,
+			 const u8 dst[], s32 imm, s32 off, u8 op)
+{
+	u8 tmp = MIPS_R_T6;
+
+	switch (op) {
+	/* No-op, used internally for branch optimization */
+	case JIT_JNOP:
+		break;
+	/* PC += off if dst == imm */
+	/* PC += off if dst != imm */
+	case BPF_JEQ:
+	case BPF_JNE:
+		if (imm >= -0x7fff && imm <= 0x8000) {
+			emit(ctx, addiu, tmp, lo(dst), -imm);
+		} else if ((u32)imm <= 0xffff) {
+			emit(ctx, xori, tmp, lo(dst), imm);
+		} else {       /* Register fallback */
+			emit_mov_i(ctx, tmp, imm);
+			emit(ctx, xor, tmp, lo(dst), tmp);
+		}
+		if (imm < 0) { /* Compare sign extension */
+			emit(ctx, addu, MIPS_R_T9, hi(dst), 1);
+			emit(ctx, or, tmp, tmp, MIPS_R_T9);
+		} else {       /* Compare zero extension */
+			emit(ctx, or, tmp, tmp, hi(dst));
+		}
+		if (op == BPF_JEQ)
+			emit(ctx, beqz, tmp, off);
+		else   /* BPF_JNE */
+			emit(ctx, bnez, tmp, off);
+		break;
+	/* PC += off if dst & imm */
+	/* PC += off if (dst & imm) == 0 (not in BPF, used for long jumps) */
+	case BPF_JSET:
+	case JIT_JNSET:
+		if ((u32)imm <= 0xffff) {
+			emit(ctx, andi, tmp, lo(dst), imm);
+		} else {     /* Register fallback */
+			emit_mov_i(ctx, tmp, imm);
+			emit(ctx, and, tmp, lo(dst), tmp);
+		}
+		if (imm < 0) /* Sign-extension pulls in high word */
+			emit(ctx, or, tmp, tmp, hi(dst));
+		if (op == BPF_JSET)
+			emit(ctx, bnez, tmp, off);
+		else   /* JIT_JNSET */
+			emit(ctx, beqz, tmp, off);
+		break;
+	/* PC += off if dst > imm */
+	case BPF_JGT:
+		emit_sltiu_r64(ctx, tmp, dst, (s64)imm + 1);
+		emit(ctx, beqz, tmp, off);
+		break;
+	/* PC += off if dst >= imm */
+	case BPF_JGE:
+		emit_sltiu_r64(ctx, tmp, dst, imm);
+		emit(ctx, beqz, tmp, off);
+		break;
+	/* PC += off if dst < imm */
+	case BPF_JLT:
+		emit_sltiu_r64(ctx, tmp, dst, imm);
+		emit(ctx, bnez, tmp, off);
+		break;
+	/* PC += off if dst <= imm */
+	case BPF_JLE:
+		emit_sltiu_r64(ctx, tmp, dst, (s64)imm + 1);
+		emit(ctx, bnez, tmp, off);
+		break;
+	/* PC += off if dst > imm (signed) */
+	case BPF_JSGT:
+		emit_slti_r64(ctx, tmp, dst, (s64)imm + 1);
+		emit(ctx, beqz, tmp, off);
+		break;
+	/* PC += off if dst >= imm (signed) */
+	case BPF_JSGE:
+		emit_slti_r64(ctx, tmp, dst, imm);
+		emit(ctx, beqz, tmp, off);
+		break;
+	/* PC += off if dst < imm (signed) */
+	case BPF_JSLT:
+		emit_slti_r64(ctx, tmp, dst, imm);
+		emit(ctx, bnez, tmp, off);
+		break;
+	/* PC += off if dst <= imm (signed) */
+	case BPF_JSLE:
+		emit_slti_r64(ctx, tmp, dst, (s64)imm + 1);
+		emit(ctx, bnez, tmp, off);
+		break;
+	}
+}
+
+/* Jump register (64-bit) */
+static void emit_jmp_r64(struct jit_context *ctx,
+			 const u8 dst[], const u8 src[], s32 off, u8 op)
+{
+	u8 t1 = MIPS_R_T6;
+	u8 t2 = MIPS_R_T7;
+
+	switch (op) {
+	/* No-op, used internally for branch optimization */
+	case JIT_JNOP:
+		break;
+	/* PC += off if dst == src */
+	/* PC += off if dst != src */
+	case BPF_JEQ:
+	case BPF_JNE:
+		emit(ctx, subu, t1, lo(dst), lo(src));
+		emit(ctx, subu, t2, hi(dst), hi(src));
+		emit(ctx, or, t1, t1, t2);
+		if (op == BPF_JEQ)
+			emit(ctx, beqz, t1, off);
+		else   /* BPF_JNE */
+			emit(ctx, bnez, t1, off);
+		break;
+	/* PC += off if dst & src */
+	/* PC += off if (dst & imm) == 0 (not in BPF, used for long jumps) */
+	case BPF_JSET:
+	case JIT_JNSET:
+		emit(ctx, and, t1, lo(dst), lo(src));
+		emit(ctx, and, t2, hi(dst), hi(src));
+		emit(ctx, or, t1, t1, t2);
+		if (op == BPF_JSET)
+			emit(ctx, bnez, t1, off);
+		else   /* JIT_JNSET */
+			emit(ctx, beqz, t1, off);
+		break;
+	/* PC += off if dst > src */
+	case BPF_JGT:
+		emit_sltu_r64(ctx, t1, src, dst);
+		emit(ctx, bnez, t1, off);
+		break;
+	/* PC += off if dst >= src */
+	case BPF_JGE:
+		emit_sltu_r64(ctx, t1, dst, src);
+		emit(ctx, beqz, t1, off);
+		break;
+	/* PC += off if dst < src */
+	case BPF_JLT:
+		emit_sltu_r64(ctx, t1, dst, src);
+		emit(ctx, bnez, t1, off);
+		break;
+	/* PC += off if dst <= src */
+	case BPF_JLE:
+		emit_sltu_r64(ctx, t1, src, dst);
+		emit(ctx, beqz, t1, off);
+		break;
+	/* PC += off if dst > src (signed) */
+	case BPF_JSGT:
+		emit_slt_r64(ctx, t1, src, dst);
+		emit(ctx, bnez, t1, off);
+		break;
+	/* PC += off if dst >= src (signed) */
+	case BPF_JSGE:
+		emit_slt_r64(ctx, t1, dst, src);
+		emit(ctx, beqz, t1, off);
+		break;
+	/* PC += off if dst < src (signed) */
+	case BPF_JSLT:
+		emit_slt_r64(ctx, t1, dst, src);
+		emit(ctx, bnez, t1, off);
+		break;
+	/* PC += off if dst <= src (signed) */
+	case BPF_JSLE:
+		emit_slt_r64(ctx, t1, src, dst);
+		emit(ctx, beqz, t1, off);
+		break;
+	}
+}
+
+/* Function call */
+static int emit_call(struct jit_context *ctx, const struct bpf_insn *insn)
+{
+	bool fixed;
+	u64 addr;
+
+	/* Decode the call address */
+	if (bpf_jit_get_func_addr(ctx->program, insn, false,
+				  &addr, &fixed) < 0)
+		return -1;
+	if (!fixed)
+		return -1;
+
+	/* Push stack arguments */
+	push_regs(ctx, JIT_STACK_REGS, 0, JIT_RESERVED_STACK);
+
+	/* Emit function call */
+	emit_mov_i(ctx, MIPS_R_T9, addr);
+	emit(ctx, jalr, MIPS_R_RA, MIPS_R_T9);
+	emit(ctx, nop); /* Delay slot */
+
+	clobber_reg(ctx, MIPS_R_RA);
+	clobber_reg(ctx, MIPS_R_V0);
+	clobber_reg(ctx, MIPS_R_V1);
+	return 0;
+}
+
+/* Function tail call */
+static int emit_tail_call(struct jit_context *ctx)
+{
+	u8 ary = lo(bpf2mips32[BPF_REG_2]);
+	u8 ind = lo(bpf2mips32[BPF_REG_3]);
+	u8 t1 = MIPS_R_T8;
+	u8 t2 = MIPS_R_T9;
+	int off;
+
+	/*
+	 * Tail call:
+	 * eBPF R1   - function argument (context ptr), passed in a0-a1
+	 * eBPF R2   - ptr to object with array of function entry points
+	 * eBPF R3   - array index of function to be called
+	 * stack[sz] - remaining tail call count, initialized in prologue
+	 */
+
+	/* if (ind >= ary->map.max_entries) goto out */
+	off = offsetof(struct bpf_array, map.max_entries);
+	if (off > 0x7fff)
+		return -1;
+	emit(ctx, lw, t1, off, ary);             /* t1 = ary->map.max_entries*/
+	emit_load_delay(ctx);                    /* Load delay slot          */
+	emit(ctx, sltu, t1, ind, t1);            /* t1 = ind < t1            */
+	emit(ctx, beqz, t1, get_offset(ctx, 1)); /* PC += off(1) if t1 == 0  */
+						 /* (next insn delay slot)   */
+	/* if (TCC-- <= 0) goto out */
+	emit(ctx, lw, t2, ctx->stack_size, MIPS_R_SP);  /* t2 = *(SP + size) */
+	emit_load_delay(ctx);                     /* Load delay slot         */
+	emit(ctx, blez, t2, get_offset(ctx, 1));  /* PC += off(1) if t2 < 0  */
+	emit(ctx, addiu, t2, t2, -1);             /* t2-- (delay slot)       */
+	emit(ctx, sw, t2, ctx->stack_size, MIPS_R_SP);  /* *(SP + size) = t2 */
+
+	/* prog = ary->ptrs[ind] */
+	off = offsetof(struct bpf_array, ptrs);
+	if (off > 0x7fff)
+		return -1;
+	emit(ctx, sll, t1, ind, 2);               /* t1 = ind << 2           */
+	emit(ctx, addu, t1, t1, ary);             /* t1 += ary               */
+	emit(ctx, lw, t2, off, t1);               /* t2 = *(t1 + off)        */
+	emit_load_delay(ctx);                     /* Load delay slot         */
+
+	/* if (prog == 0) goto out */
+	emit(ctx, beqz, t2, get_offset(ctx, 1));  /* PC += off(1) if t2 == 0 */
+	emit(ctx, nop);                           /* Delay slot              */
+
+	/* func = prog->bpf_func + 8 (prologue skip offset) */
+	off = offsetof(struct bpf_prog, bpf_func);
+	if (off > 0x7fff)
+		return -1;
+	emit(ctx, lw, t1, off, t2);                /* t1 = *(t2 + off)       */
+	emit_load_delay(ctx);                      /* Load delay slot        */
+	emit(ctx, addiu, t1, t1, JIT_TCALL_SKIP);  /* t1 += skip (8 or 12)   */
+
+	/* goto func */
+	build_epilogue(ctx, t1);
+	return 0;
+}
+
+/*
+ * Stack frame layout for a JITed program (stack grows down).
+ *
+ * Higher address  : Caller's stack frame       :
+ *                 :----------------------------:
+ *                 : 64-bit eBPF args r3-r5     :
+ *                 :----------------------------:
+ *                 : Reserved / tail call count :
+ *                 +============================+  <--- MIPS sp before call
+ *                 | Callee-saved registers,    |
+ *                 | including RA and FP        |
+ *                 +----------------------------+  <--- eBPF FP (MIPS zero,fp)
+ *                 | Local eBPF variables       |
+ *                 | allocated by program       |
+ *                 +----------------------------+
+ *                 | Reserved for caller-saved  |
+ *                 | registers                  |
+ *                 +----------------------------+
+ *                 | Reserved for 64-bit eBPF   |
+ *                 | args r3-r5 & args passed   |
+ *                 | on stack in kernel calls   |
+ * Lower address   +============================+  <--- MIPS sp
+ */
+
+/* Build program prologue to set up the stack and registers */
+void build_prologue(struct jit_context *ctx)
+{
+	const u8 *r1 = bpf2mips32[BPF_REG_1];
+	const u8 *fp = bpf2mips32[BPF_REG_FP];
+	int stack, saved, locals, reserved;
+
+	/*
+	 * The first two instructions initialize TCC in the reserved (for us)
+	 * 16-byte area in the parent's stack frame. On a tail call, the
+	 * calling function jumps into the prologue after these instructions.
+	 */
+	emit(ctx, ori, MIPS_R_T9, MIPS_R_ZERO,
+	     min(MAX_TAIL_CALL_CNT + 1, 0xffff));
+	emit(ctx, sw, MIPS_R_T9, 0, MIPS_R_SP);
+
+	/*
+	 * Register eBPF R1 contains the 32-bit context pointer argument.
+	 * A 32-bit argument is always passed in MIPS register a0, regardless
+	 * of CPU endianness. Initialize R1 accordingly and zero-extend.
+	 */
+#ifdef __BIG_ENDIAN
+	emit(ctx, move, lo(r1), MIPS_R_A0);
+#endif
+
+	/* === Entry-point for tail calls === */
+
+	/* Zero-extend the 32-bit argument */
+	emit(ctx, move, hi(r1), MIPS_R_ZERO);
+
+	/* If the eBPF frame pointer was accessed it must be saved */
+	if (ctx->accessed & BIT(BPF_REG_FP))
+		clobber_reg64(ctx, fp);
+
+	/* Compute the stack space needed for callee-saved registers */
+	saved = hweight32(ctx->clobbered & JIT_CALLEE_REGS) * sizeof(u32);
+	saved = ALIGN(saved, MIPS_STACK_ALIGNMENT);
+
+	/* Stack space used by eBPF program local data */
+	locals = ALIGN(ctx->program->aux->stack_depth, MIPS_STACK_ALIGNMENT);
+
+	/*
+	 * If we are emitting function calls, reserve extra stack space for
+	 * caller-saved registers and function arguments passed on the stack.
+	 * The required space is computed automatically during resource
+	 * usage discovery (pass 1).
+	 */
+	reserved = ctx->stack_used;
+
+	/* Allocate the stack frame */
+	stack = ALIGN(saved + locals + reserved, MIPS_STACK_ALIGNMENT);
+	emit(ctx, addiu, MIPS_R_SP, MIPS_R_SP, -stack);
+
+	/* Store callee-saved registers on stack */
+	push_regs(ctx, ctx->clobbered & JIT_CALLEE_REGS, 0, stack - saved);
+
+	/* Initialize the eBPF frame pointer if accessed */
+	if (ctx->accessed & BIT(BPF_REG_FP))
+		emit(ctx, addiu, lo(fp), MIPS_R_SP, stack - saved);
+
+	ctx->saved_size = saved;
+	ctx->stack_size = stack;
+}
+
+/* Build the program epilogue to restore the stack and registers */
+void build_epilogue(struct jit_context *ctx, int dest_reg)
+{
+	/* Restore callee-saved registers from stack */
+	pop_regs(ctx, ctx->clobbered & JIT_CALLEE_REGS, 0,
+		 ctx->stack_size - ctx->saved_size);
+	/*
+	 * A 32-bit return value is always passed in MIPS register v0,
+	 * but on big-endian targets the low part of R0 is mapped to v1.
+	 */
+#ifdef __BIG_ENDIAN
+	emit(ctx, move, MIPS_R_V0, MIPS_R_V1);
+#endif
+
+	/* Jump to the return address and adjust the stack pointer */
+	emit(ctx, jr, dest_reg);
+	emit(ctx, addiu, MIPS_R_SP, MIPS_R_SP, ctx->stack_size);
+}
+
+/* Build one eBPF instruction */
+int build_insn(const struct bpf_insn *insn, struct jit_context *ctx)
+{
+	const u8 *dst = bpf2mips32[insn->dst_reg];
+	const u8 *src = bpf2mips32[insn->src_reg];
+	const u8 *res = bpf2mips32[BPF_REG_0];
+	const u8 *tmp = bpf2mips32[JIT_REG_TMP];
+	u8 code = insn->code;
+	s16 off = insn->off;
+	s32 imm = insn->imm;
+	s32 val, rel;
+	u8 alu, jmp;
+
+	switch (code) {
+	/* ALU operations */
+	/* dst = imm */
+	case BPF_ALU | BPF_MOV | BPF_K:
+		emit_mov_i(ctx, lo(dst), imm);
+		emit_zext_ver(ctx, dst);
+		break;
+	/* dst = src */
+	case BPF_ALU | BPF_MOV | BPF_X:
+		if (imm == 1) {
+			/* Special mov32 for zext */
+			emit_mov_i(ctx, hi(dst), 0);
+		} else {
+			emit_mov_r(ctx, lo(dst), lo(src));
+			emit_zext_ver(ctx, dst);
+		}
+		break;
+	/* dst = -dst */
+	case BPF_ALU | BPF_NEG:
+		emit_alu_i(ctx, lo(dst), 0, BPF_NEG);
+		emit_zext_ver(ctx, dst);
+		break;
+	/* dst = dst & imm */
+	/* dst = dst | imm */
+	/* dst = dst ^ imm */
+	/* dst = dst << imm */
+	/* dst = dst >> imm */
+	/* dst = dst >> imm (arithmetic) */
+	/* dst = dst + imm */
+	/* dst = dst - imm */
+	/* dst = dst * imm */
+	/* dst = dst / imm */
+	/* dst = dst % imm */
+	case BPF_ALU | BPF_OR | BPF_K:
+	case BPF_ALU | BPF_AND | BPF_K:
+	case BPF_ALU | BPF_XOR | BPF_K:
+	case BPF_ALU | BPF_LSH | BPF_K:
+	case BPF_ALU | BPF_RSH | BPF_K:
+	case BPF_ALU | BPF_ARSH | BPF_K:
+	case BPF_ALU | BPF_ADD | BPF_K:
+	case BPF_ALU | BPF_SUB | BPF_K:
+	case BPF_ALU | BPF_MUL | BPF_K:
+	case BPF_ALU | BPF_DIV | BPF_K:
+	case BPF_ALU | BPF_MOD | BPF_K:
+		if (!valid_alu_i(BPF_OP(code), imm)) {
+			emit_mov_i(ctx, MIPS_R_T6, imm);
+			emit_alu_r(ctx, lo(dst), MIPS_R_T6, BPF_OP(code));
+		} else if (rewrite_alu_i(BPF_OP(code), imm, &alu, &val)) {
+			emit_alu_i(ctx, lo(dst), val, alu);
+		}
+		emit_zext_ver(ctx, dst);
+		break;
+	/* dst = dst & src */
+	/* dst = dst | src */
+	/* dst = dst ^ src */
+	/* dst = dst << src */
+	/* dst = dst >> src */
+	/* dst = dst >> src (arithmetic) */
+	/* dst = dst + src */
+	/* dst = dst - src */
+	/* dst = dst * src */
+	/* dst = dst / src */
+	/* dst = dst % src */
+	case BPF_ALU | BPF_AND | BPF_X:
+	case BPF_ALU | BPF_OR | BPF_X:
+	case BPF_ALU | BPF_XOR | BPF_X:
+	case BPF_ALU | BPF_LSH | BPF_X:
+	case BPF_ALU | BPF_RSH | BPF_X:
+	case BPF_ALU | BPF_ARSH | BPF_X:
+	case BPF_ALU | BPF_ADD | BPF_X:
+	case BPF_ALU | BPF_SUB | BPF_X:
+	case BPF_ALU | BPF_MUL | BPF_X:
+	case BPF_ALU | BPF_DIV | BPF_X:
+	case BPF_ALU | BPF_MOD | BPF_X:
+		emit_alu_r(ctx, lo(dst), lo(src), BPF_OP(code));
+		emit_zext_ver(ctx, dst);
+		break;
+	/* dst = imm (64-bit) */
+	case BPF_ALU64 | BPF_MOV | BPF_K:
+		emit_mov_se_i64(ctx, dst, imm);
+		break;
+	/* dst = src (64-bit) */
+	case BPF_ALU64 | BPF_MOV | BPF_X:
+		emit_mov_r(ctx, lo(dst), lo(src));
+		emit_mov_r(ctx, hi(dst), hi(src));
+		break;
+	/* dst = -dst (64-bit) */
+	case BPF_ALU64 | BPF_NEG:
+		emit_neg_i64(ctx, dst);
+		break;
+	/* dst = dst & imm (64-bit) */
+	case BPF_ALU64 | BPF_AND | BPF_K:
+		emit_alu_i64(ctx, dst, imm, BPF_OP(code));
+		break;
+	/* dst = dst | imm (64-bit) */
+	/* dst = dst ^ imm (64-bit) */
+	/* dst = dst + imm (64-bit) */
+	/* dst = dst - imm (64-bit) */
+	case BPF_ALU64 | BPF_OR | BPF_K:
+	case BPF_ALU64 | BPF_XOR | BPF_K:
+	case BPF_ALU64 | BPF_ADD | BPF_K:
+	case BPF_ALU64 | BPF_SUB | BPF_K:
+		if (imm)
+			emit_alu_i64(ctx, dst, imm, BPF_OP(code));
+		break;
+	/* dst = dst << imm (64-bit) */
+	/* dst = dst >> imm (64-bit) */
+	/* dst = dst >> imm (64-bit, arithmetic) */
+	case BPF_ALU64 | BPF_LSH | BPF_K:
+	case BPF_ALU64 | BPF_RSH | BPF_K:
+	case BPF_ALU64 | BPF_ARSH | BPF_K:
+		if (imm)
+			emit_shift_i64(ctx, dst, imm, BPF_OP(code));
+		break;
+	/* dst = dst * imm (64-bit) */
+	case BPF_ALU64 | BPF_MUL | BPF_K:
+		emit_mul_i64(ctx, dst, imm);
+		break;
+	/* dst = dst / imm (64-bit) */
+	/* dst = dst % imm (64-bit) */
+	case BPF_ALU64 | BPF_DIV | BPF_K:
+	case BPF_ALU64 | BPF_MOD | BPF_K:
+		/*
+		 * Sign-extend the immediate value into a temporary register,
+		 * and then do the operation on this register.
+		 */
+		emit_mov_se_i64(ctx, tmp, imm);
+		emit_divmod_r64(ctx, dst, tmp, BPF_OP(code));
+		break;
+	/* dst = dst & src (64-bit) */
+	/* dst = dst | src (64-bit) */
+	/* dst = dst ^ src (64-bit) */
+	/* dst = dst + src (64-bit) */
+	/* dst = dst - src (64-bit) */
+	case BPF_ALU64 | BPF_AND | BPF_X:
+	case BPF_ALU64 | BPF_OR | BPF_X:
+	case BPF_ALU64 | BPF_XOR | BPF_X:
+	case BPF_ALU64 | BPF_ADD | BPF_X:
+	case BPF_ALU64 | BPF_SUB | BPF_X:
+		emit_alu_r64(ctx, dst, src, BPF_OP(code));
+		break;
+	/* dst = dst << src (64-bit) */
+	/* dst = dst >> src (64-bit) */
+	/* dst = dst >> src (64-bit, arithmetic) */
+	case BPF_ALU64 | BPF_LSH | BPF_X:
+	case BPF_ALU64 | BPF_RSH | BPF_X:
+	case BPF_ALU64 | BPF_ARSH | BPF_X:
+		emit_shift_r64(ctx, dst, lo(src), BPF_OP(code));
+		break;
+	/* dst = dst * src (64-bit) */
+	case BPF_ALU64 | BPF_MUL | BPF_X:
+		emit_mul_r64(ctx, dst, src);
+		break;
+	/* dst = dst / src (64-bit) */
+	/* dst = dst % src (64-bit) */
+	case BPF_ALU64 | BPF_DIV | BPF_X:
+	case BPF_ALU64 | BPF_MOD | BPF_X:
+		emit_divmod_r64(ctx, dst, src, BPF_OP(code));
+		break;
+	/* dst = htole(dst) */
+	/* dst = htobe(dst) */
+	case BPF_ALU | BPF_END | BPF_FROM_LE:
+	case BPF_ALU | BPF_END | BPF_FROM_BE:
+		if (BPF_SRC(code) ==
+#ifdef __BIG_ENDIAN
+		    BPF_FROM_LE
+#else
+		    BPF_FROM_BE
+#endif
+		    )
+			emit_bswap_r64(ctx, dst, imm);
+		else
+			emit_trunc_r64(ctx, dst, imm);
+		break;
+	/* dst = imm64 */
+	case BPF_LD | BPF_IMM | BPF_DW:
+		emit_mov_i(ctx, lo(dst), imm);
+		emit_mov_i(ctx, hi(dst), insn[1].imm);
+		return 1;
+	/* LDX: dst = *(size *)(src + off) */
+	case BPF_LDX | BPF_MEM | BPF_W:
+	case BPF_LDX | BPF_MEM | BPF_H:
+	case BPF_LDX | BPF_MEM | BPF_B:
+	case BPF_LDX | BPF_MEM | BPF_DW:
+		emit_ldx(ctx, dst, lo(src), off, BPF_SIZE(code));
+		break;
+	/* ST: *(size *)(dst + off) = imm */
+	case BPF_ST | BPF_MEM | BPF_W:
+	case BPF_ST | BPF_MEM | BPF_H:
+	case BPF_ST | BPF_MEM | BPF_B:
+	case BPF_ST | BPF_MEM | BPF_DW:
+		switch (BPF_SIZE(code)) {
+		case BPF_DW:
+			/* Sign-extend immediate value into temporary reg */
+			emit_mov_se_i64(ctx, tmp, imm);
+			break;
+		case BPF_W:
+		case BPF_H:
+		case BPF_B:
+			emit_mov_i(ctx, lo(tmp), imm);
+			break;
+		}
+		emit_stx(ctx, lo(dst), tmp, off, BPF_SIZE(code));
+		break;
+	/* STX: *(size *)(dst + off) = src */
+	case BPF_STX | BPF_MEM | BPF_W:
+	case BPF_STX | BPF_MEM | BPF_H:
+	case BPF_STX | BPF_MEM | BPF_B:
+	case BPF_STX | BPF_MEM | BPF_DW:
+		emit_stx(ctx, lo(dst), src, off, BPF_SIZE(code));
+		break;
+	/* Speculation barrier */
+	case BPF_ST | BPF_NOSPEC:
+		break;
+	/* Atomics */
+	case BPF_STX | BPF_ATOMIC | BPF_W:
+		switch (imm) {
+		case BPF_ADD:
+		case BPF_ADD | BPF_FETCH:
+		case BPF_AND:
+		case BPF_AND | BPF_FETCH:
+		case BPF_OR:
+		case BPF_OR | BPF_FETCH:
+		case BPF_XOR:
+		case BPF_XOR | BPF_FETCH:
+		case BPF_XCHG:
+			if (cpu_has_llsc)
+				emit_atomic_r(ctx, lo(dst), lo(src), off, imm);
+			else /* Non-ll/sc fallback */
+				emit_atomic_r32(ctx, lo(dst), lo(src),
+						off, imm);
+			if (imm & BPF_FETCH)
+				emit_zext_ver(ctx, src);
+			break;
+		case BPF_CMPXCHG:
+			if (cpu_has_llsc)
+				emit_cmpxchg_r(ctx, lo(dst), lo(src),
+					       lo(res), off);
+			else /* Non-ll/sc fallback */
+				emit_cmpxchg_r32(ctx, lo(dst), lo(src), off);
+			/* Result zero-extension inserted by verifier */
+			break;
+		default:
+			goto notyet;
+		}
+		break;
+	/* Atomics (64-bit) */
+	case BPF_STX | BPF_ATOMIC | BPF_DW:
+		switch (imm) {
+		case BPF_ADD:
+		case BPF_ADD | BPF_FETCH:
+		case BPF_AND:
+		case BPF_AND | BPF_FETCH:
+		case BPF_OR:
+		case BPF_OR | BPF_FETCH:
+		case BPF_XOR:
+		case BPF_XOR | BPF_FETCH:
+		case BPF_XCHG:
+			emit_atomic_r64(ctx, lo(dst), src, off, imm);
+			break;
+		case BPF_CMPXCHG:
+			emit_cmpxchg_r64(ctx, lo(dst), src, off);
+			break;
+		default:
+			goto notyet;
+		}
+		break;
+	/* PC += off if dst == src */
+	/* PC += off if dst != src */
+	/* PC += off if dst & src */
+	/* PC += off if dst > src */
+	/* PC += off if dst >= src */
+	/* PC += off if dst < src */
+	/* PC += off if dst <= src */
+	/* PC += off if dst > src (signed) */
+	/* PC += off if dst >= src (signed) */
+	/* PC += off if dst < src (signed) */
+	/* PC += off if dst <= src (signed) */
+	case BPF_JMP32 | BPF_JEQ | BPF_X:
+	case BPF_JMP32 | BPF_JNE | BPF_X:
+	case BPF_JMP32 | BPF_JSET | BPF_X:
+	case BPF_JMP32 | BPF_JGT | BPF_X:
+	case BPF_JMP32 | BPF_JGE | BPF_X:
+	case BPF_JMP32 | BPF_JLT | BPF_X:
+	case BPF_JMP32 | BPF_JLE | BPF_X:
+	case BPF_JMP32 | BPF_JSGT | BPF_X:
+	case BPF_JMP32 | BPF_JSGE | BPF_X:
+	case BPF_JMP32 | BPF_JSLT | BPF_X:
+	case BPF_JMP32 | BPF_JSLE | BPF_X:
+		if (off == 0)
+			break;
+		setup_jmp_r(ctx, dst == src, BPF_OP(code), off, &jmp, &rel);
+		emit_jmp_r(ctx, lo(dst), lo(src), rel, jmp);
+		if (finish_jmp(ctx, jmp, off) < 0)
+			goto toofar;
+		break;
+	/* PC += off if dst == imm */
+	/* PC += off if dst != imm */
+	/* PC += off if dst & imm */
+	/* PC += off if dst > imm */
+	/* PC += off if dst >= imm */
+	/* PC += off if dst < imm */
+	/* PC += off if dst <= imm */
+	/* PC += off if dst > imm (signed) */
+	/* PC += off if dst >= imm (signed) */
+	/* PC += off if dst < imm (signed) */
+	/* PC += off if dst <= imm (signed) */
+	case BPF_JMP32 | BPF_JEQ | BPF_K:
+	case BPF_JMP32 | BPF_JNE | BPF_K:
+	case BPF_JMP32 | BPF_JSET | BPF_K:
+	case BPF_JMP32 | BPF_JGT | BPF_K:
+	case BPF_JMP32 | BPF_JGE | BPF_K:
+	case BPF_JMP32 | BPF_JLT | BPF_K:
+	case BPF_JMP32 | BPF_JLE | BPF_K:
+	case BPF_JMP32 | BPF_JSGT | BPF_K:
+	case BPF_JMP32 | BPF_JSGE | BPF_K:
+	case BPF_JMP32 | BPF_JSLT | BPF_K:
+	case BPF_JMP32 | BPF_JSLE | BPF_K:
+		if (off == 0)
+			break;
+		setup_jmp_i(ctx, imm, 32, BPF_OP(code), off, &jmp, &rel);
+		if (valid_jmp_i(jmp, imm)) {
+			emit_jmp_i(ctx, lo(dst), imm, rel, jmp);
+		} else {
+			/* Move large immediate to register */
+			emit_mov_i(ctx, MIPS_R_T6, imm);
+			emit_jmp_r(ctx, lo(dst), MIPS_R_T6, rel, jmp);
+		}
+		if (finish_jmp(ctx, jmp, off) < 0)
+			goto toofar;
+		break;
+	/* PC += off if dst == src */
+	/* PC += off if dst != src */
+	/* PC += off if dst & src */
+	/* PC += off if dst > src */
+	/* PC += off if dst >= src */
+	/* PC += off if dst < src */
+	/* PC += off if dst <= src */
+	/* PC += off if dst > src (signed) */
+	/* PC += off if dst >= src (signed) */
+	/* PC += off if dst < src (signed) */
+	/* PC += off if dst <= src (signed) */
+	case BPF_JMP | BPF_JEQ | BPF_X:
+	case BPF_JMP | BPF_JNE | BPF_X:
+	case BPF_JMP | BPF_JSET | BPF_X:
+	case BPF_JMP | BPF_JGT | BPF_X:
+	case BPF_JMP | BPF_JGE | BPF_X:
+	case BPF_JMP | BPF_JLT | BPF_X:
+	case BPF_JMP | BPF_JLE | BPF_X:
+	case BPF_JMP | BPF_JSGT | BPF_X:
+	case BPF_JMP | BPF_JSGE | BPF_X:
+	case BPF_JMP | BPF_JSLT | BPF_X:
+	case BPF_JMP | BPF_JSLE | BPF_X:
+		if (off == 0)
+			break;
+		setup_jmp_r(ctx, dst == src, BPF_OP(code), off, &jmp, &rel);
+		emit_jmp_r64(ctx, dst, src, rel, jmp);
+		if (finish_jmp(ctx, jmp, off) < 0)
+			goto toofar;
+		break;
+	/* PC += off if dst == imm */
+	/* PC += off if dst != imm */
+	/* PC += off if dst & imm */
+	/* PC += off if dst > imm */
+	/* PC += off if dst >= imm */
+	/* PC += off if dst < imm */
+	/* PC += off if dst <= imm */
+	/* PC += off if dst > imm (signed) */
+	/* PC += off if dst >= imm (signed) */
+	/* PC += off if dst < imm (signed) */
+	/* PC += off if dst <= imm (signed) */
+	case BPF_JMP | BPF_JEQ | BPF_K:
+	case BPF_JMP | BPF_JNE | BPF_K:
+	case BPF_JMP | BPF_JSET | BPF_K:
+	case BPF_JMP | BPF_JGT | BPF_K:
+	case BPF_JMP | BPF_JGE | BPF_K:
+	case BPF_JMP | BPF_JLT | BPF_K:
+	case BPF_JMP | BPF_JLE | BPF_K:
+	case BPF_JMP | BPF_JSGT | BPF_K:
+	case BPF_JMP | BPF_JSGE | BPF_K:
+	case BPF_JMP | BPF_JSLT | BPF_K:
+	case BPF_JMP | BPF_JSLE | BPF_K:
+		if (off == 0)
+			break;
+		setup_jmp_i(ctx, imm, 64, BPF_OP(code), off, &jmp, &rel);
+		emit_jmp_i64(ctx, dst, imm, rel, jmp);
+		if (finish_jmp(ctx, jmp, off) < 0)
+			goto toofar;
+		break;
+	/* PC += off */
+	case BPF_JMP | BPF_JA:
+		if (off == 0)
+			break;
+		if (emit_ja(ctx, off) < 0)
+			goto toofar;
+		break;
+	/* Tail call */
+	case BPF_JMP | BPF_TAIL_CALL:
+		if (emit_tail_call(ctx) < 0)
+			goto invalid;
+		break;
+	/* Function call */
+	case BPF_JMP | BPF_CALL:
+		if (emit_call(ctx, insn) < 0)
+			goto invalid;
+		break;
+	/* Function return */
+	case BPF_JMP | BPF_EXIT:
+		/*
+		 * Optimization: when last instruction is EXIT
+		 * simply continue to epilogue.
+		 */
+		if (ctx->bpf_index == ctx->program->len - 1)
+			break;
+		if (emit_exit(ctx) < 0)
+			goto toofar;
+		break;
+
+	default:
+invalid:
+		pr_err_once("unknown opcode %02x\n", code);
+		return -EINVAL;
+notyet:
+		pr_info_once("*** NOT YET: opcode %02x ***\n", code);
+		return -EFAULT;
+toofar:
+		pr_info_once("*** TOO FAR: jump at %u opcode %02x ***\n",
+			     ctx->bpf_index, code);
+		return -E2BIG;
+	}
+	return 0;
+}
-- 
2.30.2

