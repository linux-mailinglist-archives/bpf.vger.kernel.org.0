Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 726711146D6
	for <lists+bpf@lfdr.de>; Thu,  5 Dec 2019 19:23:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729145AbfLESXU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 5 Dec 2019 13:23:20 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40191 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbfLESXT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 5 Dec 2019 13:23:19 -0500
Received: by mail-pg1-f194.google.com with SMTP id k25so1972946pgt.7;
        Thu, 05 Dec 2019 10:23:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/lG0oSGzGzOnnq7aZ/8Kv2T9Lb2eGNqT+MTjTFUCOiU=;
        b=ILuYifvZioayjl0SF35MOb6jsvFxyaYyfXi6H3EkPbrkZ4eEbMaZ3Z1uswD9j3kr48
         BaxYFANQs2pOIiUWHwBb9BzVPZ/300++rIjQsjjiRNvVbWiL8LcZ2iAbY/rAqT6wtlDx
         N9vAzANwKzfbc1PX+vqealaOEzmYoM2RF/cSpL+WWiID9Oiaj+MKHv2WAfaSynm5dZ+o
         QGaj2KB6s2rCTgtfpVNgki4jKDSEAPqQX7NM2/0odH2GkxnDDaGnysOEEWjfXo5oy7ej
         R57R14Ka5+v4CB6QhXUX5yHZuIB6gxwlkgYFMBQZXuFNsj5EtYJDsBbEUGbJSjaKQ+RR
         3KRQ==
X-Gm-Message-State: APjAAAV+FZP174mp2n2x/7Zy4D34zCYbXNp6IbZN0wudSqd4DUuz7S4I
        fEafaYR+hwQzDImm/M0Kdt+O4ekTW1M75g==
X-Google-Smtp-Source: APXvYqx5y0cSw9uZm91AvQGVs4fzK6TJTBjfK/TkZxpf96pFq2ZqBTg2SQINI3uV1TNDgFITgtIiXA==
X-Received: by 2002:a63:b20f:: with SMTP id x15mr10591502pge.65.1575570197266;
        Thu, 05 Dec 2019 10:23:17 -0800 (PST)
Received: from localhost ([2601:646:8a00:9810:5af3:56d9:f882:39d4])
        by smtp.gmail.com with ESMTPSA id k60sm414554pjh.22.2019.12.05.10.23.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2019 10:23:16 -0800 (PST)
From:   Paul Burton <paulburton@kernel.org>
To:     linux-mips@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Paul Burton <paulburton@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Hassan Naveed <hnaveed@wavecomp.com>,
        Tony Ambardar <itugrok@yahoo.com>, bpf@vger.kernel.org,
        netdev@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH] MIPS: BPF: Restore MIPS32 cBPF JIT; disable MIPS32 eBPF JIT
Date:   Thu,  5 Dec 2019 10:23:18 -0800
Message-Id: <20191205182318.2761605-1-paulburton@kernel.org>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Commit 716850ab104d ("MIPS: eBPF: Initial eBPF support for MIPS32
architecture.") enabled our eBPF JIT for MIPS32 kernels, whereas it has
previously only been availailable for MIPS64. It was my understanding at
the time that the BPF test suite was passing & JITing a comparable
number of tests to our cBPF JIT [1], but it turns out that was not the
case.

The eBPF JIT has a number of problems on MIPS32:

- Most notably various code paths still result in emission of MIPS64
  instructions which will cause reserved instruction exceptions & kernel
  panics when run on MIPS32 CPUs.

- The eBPF JIT doesn't account for differences between the O32 ABI used
  by MIPS32 kernels versus the N64 ABI used by MIPS64 kernels. Notably
  arguments beyond the first 4 are passed on the stack in O32, and this
  is entirely unhandled when JITing a BPF_CALL instruction. Stack space
  must be reserved for arguments even if they all fit in registers, and
  the callee is free to assume that stack space has been reserved for
  its use - with the eBPF JIT this is not the case, so calling any
  function can result in clobbering values on the stack & unpredictable
  behaviour. Function arguments in eBPF are always 64-bit values which
  is also entirely unhandled - the JIT still uses a single (32-bit)
  register per argument. As a result all function arguments are always
  passed incorrectly when JITing a BPF_CALL instruction, leading to
  kernel crashes or strange behavior.

- The JIT attempts to bail our on use of ALU64 instructions or 64-bit
  memory access instructions. The code doing this at the start of
  build_one_insn() incorrectly checks whether BPF_OP() equals BPF_DW,
  when it should really be checking BPF_SIZE() & only doing so when
  BPF_CLASS() is one of BPF_{LD,LDX,ST,STX}. This results in false
  positives that cause more bailouts than intended, and that in turns
  hides some of the problems described above.

- The kernel's cBPF->eBPF translation makes heavy use of 64-bit eBPF
  instructions that the MIPS32 eBPF JIT bails out on, leading to most
  cBPF programs not being JITed at all.

Until these problems are resolved, revert the removal of the cBPF JIT &
the enabling of the eBPF JIT on MIPS32 done by commit 716850ab104d
("MIPS: eBPF: Initial eBPF support for MIPS32 architecture.").

Note that this does not undo the changes made to the eBPF JIT by that
commit, since they are a useful starting point to providing MIPS32
support - they're just not nearly complete.

[1] https://lore.kernel.org/linux-mips/MWHPR2201MB13583388481F01A422CE7D66D4410@MWHPR2201MB1358.namprd22.prod.outlook.com/

Signed-off-by: Paul Burton <paulburton@kernel.org>
Fixes: 716850ab104d ("MIPS: eBPF: Initial eBPF support for MIPS32 architecture.")
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Hassan Naveed <hnaveed@wavecomp.com>
Cc: Tony Ambardar <itugrok@yahoo.com>
Cc: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org
Cc: <stable@vger.kernel.org> # v5.2+
---
 arch/mips/Kconfig           |    3 +-
 arch/mips/net/Makefile      |    1 +
 arch/mips/net/bpf_jit.c     | 1270 +++++++++++++++++++++++++++++++++++
 arch/mips/net/bpf_jit_asm.S |  285 ++++++++
 4 files changed, 1558 insertions(+), 1 deletion(-)
 create mode 100644 arch/mips/net/bpf_jit.c
 create mode 100644 arch/mips/net/bpf_jit_asm.S

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index a0bd9bdb5f83..069f13a68aef 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -46,7 +46,8 @@ config MIPS
 	select HAVE_ARCH_TRACEHOOK
 	select HAVE_ARCH_TRANSPARENT_HUGEPAGE if CPU_SUPPORTS_HUGEPAGES
 	select HAVE_ASM_MODVERSIONS
-	select HAVE_EBPF_JIT if (!CPU_MICROMIPS)
+	select HAVE_CBPF_JIT if (!64BIT && !CPU_MICROMIPS)
+	select HAVE_EBPF_JIT if (64BIT && !CPU_MICROMIPS)
 	select HAVE_CONTEXT_TRACKING
 	select HAVE_COPY_THREAD_TLS
 	select HAVE_C_RECORDMCOUNT
diff --git a/arch/mips/net/Makefile b/arch/mips/net/Makefile
index 2d03af7d6b19..d55912349039 100644
--- a/arch/mips/net/Makefile
+++ b/arch/mips/net/Makefile
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
 # MIPS networking code
 
+obj-$(CONFIG_MIPS_CBPF_JIT) += bpf_jit.o bpf_jit_asm.o
 obj-$(CONFIG_MIPS_EBPF_JIT) += ebpf_jit.o
diff --git a/arch/mips/net/bpf_jit.c b/arch/mips/net/bpf_jit.c
new file mode 100644
index 000000000000..3a0e34f4e615
--- /dev/null
+++ b/arch/mips/net/bpf_jit.c
@@ -0,0 +1,1270 @@
+/*
+ * Just-In-Time compiler for BPF filters on MIPS
+ *
+ * Copyright (c) 2014 Imagination Technologies Ltd.
+ * Author: Markos Chandras <markos.chandras@imgtec.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; version 2 of the License.
+ */
+
+#include <linux/bitops.h>
+#include <linux/compiler.h>
+#include <linux/errno.h>
+#include <linux/filter.h>
+#include <linux/if_vlan.h>
+#include <linux/moduleloader.h>
+#include <linux/netdevice.h>
+#include <linux/string.h>
+#include <linux/slab.h>
+#include <linux/types.h>
+#include <asm/asm.h>
+#include <asm/bitops.h>
+#include <asm/cacheflush.h>
+#include <asm/cpu-features.h>
+#include <asm/uasm.h>
+
+#include "bpf_jit.h"
+
+/* ABI
+ * r_skb_hl	SKB header length
+ * r_data	SKB data pointer
+ * r_off	Offset
+ * r_A		BPF register A
+ * r_X		BPF register X
+ * r_skb	*skb
+ * r_M		*scratch memory
+ * r_skb_len	SKB length
+ *
+ * On entry (*bpf_func)(*skb, *filter)
+ * a0 = MIPS_R_A0 = skb;
+ * a1 = MIPS_R_A1 = filter;
+ *
+ * Stack
+ * ...
+ * M[15]
+ * M[14]
+ * M[13]
+ * ...
+ * M[0] <-- r_M
+ * saved reg k-1
+ * saved reg k-2
+ * ...
+ * saved reg 0 <-- r_sp
+ * <no argument area>
+ *
+ *                     Packet layout
+ *
+ * <--------------------- len ------------------------>
+ * <--skb-len(r_skb_hl)-->< ----- skb->data_len ------>
+ * ----------------------------------------------------
+ * |                  skb->data                       |
+ * ----------------------------------------------------
+ */
+
+#define ptr typeof(unsigned long)
+
+#define SCRATCH_OFF(k)		(4 * (k))
+
+/* JIT flags */
+#define SEEN_CALL		(1 << BPF_MEMWORDS)
+#define SEEN_SREG_SFT		(BPF_MEMWORDS + 1)
+#define SEEN_SREG_BASE		(1 << SEEN_SREG_SFT)
+#define SEEN_SREG(x)		(SEEN_SREG_BASE << (x))
+#define SEEN_OFF		SEEN_SREG(2)
+#define SEEN_A			SEEN_SREG(3)
+#define SEEN_X			SEEN_SREG(4)
+#define SEEN_SKB		SEEN_SREG(5)
+#define SEEN_MEM		SEEN_SREG(6)
+/* SEEN_SK_DATA also implies skb_hl an skb_len */
+#define SEEN_SKB_DATA		(SEEN_SREG(7) | SEEN_SREG(1) | SEEN_SREG(0))
+
+/* Arguments used by JIT */
+#define ARGS_USED_BY_JIT	2 /* only applicable to 64-bit */
+
+#define SBIT(x)			(1 << (x)) /* Signed version of BIT() */
+
+/**
+ * struct jit_ctx - JIT context
+ * @skf:		The sk_filter
+ * @prologue_bytes:	Number of bytes for prologue
+ * @idx:		Instruction index
+ * @flags:		JIT flags
+ * @offsets:		Instruction offsets
+ * @target:		Memory location for the compiled filter
+ */
+struct jit_ctx {
+	const struct bpf_prog *skf;
+	unsigned int prologue_bytes;
+	u32 idx;
+	u32 flags;
+	u32 *offsets;
+	u32 *target;
+};
+
+
+static inline int optimize_div(u32 *k)
+{
+	/* power of 2 divides can be implemented with right shift */
+	if (!(*k & (*k-1))) {
+		*k = ilog2(*k);
+		return 1;
+	}
+
+	return 0;
+}
+
+static inline void emit_jit_reg_move(ptr dst, ptr src, struct jit_ctx *ctx);
+
+/* Simply emit the instruction if the JIT memory space has been allocated */
+#define emit_instr(ctx, func, ...)			\
+do {							\
+	if ((ctx)->target != NULL) {			\
+		u32 *p = &(ctx)->target[ctx->idx];	\
+		uasm_i_##func(&p, ##__VA_ARGS__);	\
+	}						\
+	(ctx)->idx++;					\
+} while (0)
+
+/*
+ * Similar to emit_instr but it must be used when we need to emit
+ * 32-bit or 64-bit instructions
+ */
+#define emit_long_instr(ctx, func, ...)			\
+do {							\
+	if ((ctx)->target != NULL) {			\
+		u32 *p = &(ctx)->target[ctx->idx];	\
+		UASM_i_##func(&p, ##__VA_ARGS__);	\
+	}						\
+	(ctx)->idx++;					\
+} while (0)
+
+/* Determine if immediate is within the 16-bit signed range */
+static inline bool is_range16(s32 imm)
+{
+	return !(imm >= SBIT(15) || imm < -SBIT(15));
+}
+
+static inline void emit_addu(unsigned int dst, unsigned int src1,
+			     unsigned int src2, struct jit_ctx *ctx)
+{
+	emit_instr(ctx, addu, dst, src1, src2);
+}
+
+static inline void emit_nop(struct jit_ctx *ctx)
+{
+	emit_instr(ctx, nop);
+}
+
+/* Load a u32 immediate to a register */
+static inline void emit_load_imm(unsigned int dst, u32 imm, struct jit_ctx *ctx)
+{
+	if (ctx->target != NULL) {
+		/* addiu can only handle s16 */
+		if (!is_range16(imm)) {
+			u32 *p = &ctx->target[ctx->idx];
+			uasm_i_lui(&p, r_tmp_imm, (s32)imm >> 16);
+			p = &ctx->target[ctx->idx + 1];
+			uasm_i_ori(&p, dst, r_tmp_imm, imm & 0xffff);
+		} else {
+			u32 *p = &ctx->target[ctx->idx];
+			uasm_i_addiu(&p, dst, r_zero, imm);
+		}
+	}
+	ctx->idx++;
+
+	if (!is_range16(imm))
+		ctx->idx++;
+}
+
+static inline void emit_or(unsigned int dst, unsigned int src1,
+			   unsigned int src2, struct jit_ctx *ctx)
+{
+	emit_instr(ctx, or, dst, src1, src2);
+}
+
+static inline void emit_ori(unsigned int dst, unsigned src, u32 imm,
+			    struct jit_ctx *ctx)
+{
+	if (imm >= BIT(16)) {
+		emit_load_imm(r_tmp, imm, ctx);
+		emit_or(dst, src, r_tmp, ctx);
+	} else {
+		emit_instr(ctx, ori, dst, src, imm);
+	}
+}
+
+static inline void emit_daddiu(unsigned int dst, unsigned int src,
+			       int imm, struct jit_ctx *ctx)
+{
+	/*
+	 * Only used for stack, so the imm is relatively small
+	 * and it fits in 15-bits
+	 */
+	emit_instr(ctx, daddiu, dst, src, imm);
+}
+
+static inline void emit_addiu(unsigned int dst, unsigned int src,
+			      u32 imm, struct jit_ctx *ctx)
+{
+	if (!is_range16(imm)) {
+		emit_load_imm(r_tmp, imm, ctx);
+		emit_addu(dst, r_tmp, src, ctx);
+	} else {
+		emit_instr(ctx, addiu, dst, src, imm);
+	}
+}
+
+static inline void emit_and(unsigned int dst, unsigned int src1,
+			    unsigned int src2, struct jit_ctx *ctx)
+{
+	emit_instr(ctx, and, dst, src1, src2);
+}
+
+static inline void emit_andi(unsigned int dst, unsigned int src,
+			     u32 imm, struct jit_ctx *ctx)
+{
+	/* If imm does not fit in u16 then load it to register */
+	if (imm >= BIT(16)) {
+		emit_load_imm(r_tmp, imm, ctx);
+		emit_and(dst, src, r_tmp, ctx);
+	} else {
+		emit_instr(ctx, andi, dst, src, imm);
+	}
+}
+
+static inline void emit_xor(unsigned int dst, unsigned int src1,
+			    unsigned int src2, struct jit_ctx *ctx)
+{
+	emit_instr(ctx, xor, dst, src1, src2);
+}
+
+static inline void emit_xori(ptr dst, ptr src, u32 imm, struct jit_ctx *ctx)
+{
+	/* If imm does not fit in u16 then load it to register */
+	if (imm >= BIT(16)) {
+		emit_load_imm(r_tmp, imm, ctx);
+		emit_xor(dst, src, r_tmp, ctx);
+	} else {
+		emit_instr(ctx, xori, dst, src, imm);
+	}
+}
+
+static inline void emit_stack_offset(int offset, struct jit_ctx *ctx)
+{
+	emit_long_instr(ctx, ADDIU, r_sp, r_sp, offset);
+}
+
+static inline void emit_subu(unsigned int dst, unsigned int src1,
+			     unsigned int src2, struct jit_ctx *ctx)
+{
+	emit_instr(ctx, subu, dst, src1, src2);
+}
+
+static inline void emit_neg(unsigned int reg, struct jit_ctx *ctx)
+{
+	emit_subu(reg, r_zero, reg, ctx);
+}
+
+static inline void emit_sllv(unsigned int dst, unsigned int src,
+			     unsigned int sa, struct jit_ctx *ctx)
+{
+	emit_instr(ctx, sllv, dst, src, sa);
+}
+
+static inline void emit_sll(unsigned int dst, unsigned int src,
+			    unsigned int sa, struct jit_ctx *ctx)
+{
+	/* sa is 5-bits long */
+	if (sa >= BIT(5))
+		/* Shifting >= 32 results in zero */
+		emit_jit_reg_move(dst, r_zero, ctx);
+	else
+		emit_instr(ctx, sll, dst, src, sa);
+}
+
+static inline void emit_srlv(unsigned int dst, unsigned int src,
+			     unsigned int sa, struct jit_ctx *ctx)
+{
+	emit_instr(ctx, srlv, dst, src, sa);
+}
+
+static inline void emit_srl(unsigned int dst, unsigned int src,
+			    unsigned int sa, struct jit_ctx *ctx)
+{
+	/* sa is 5-bits long */
+	if (sa >= BIT(5))
+		/* Shifting >= 32 results in zero */
+		emit_jit_reg_move(dst, r_zero, ctx);
+	else
+		emit_instr(ctx, srl, dst, src, sa);
+}
+
+static inline void emit_slt(unsigned int dst, unsigned int src1,
+			    unsigned int src2, struct jit_ctx *ctx)
+{
+	emit_instr(ctx, slt, dst, src1, src2);
+}
+
+static inline void emit_sltu(unsigned int dst, unsigned int src1,
+			     unsigned int src2, struct jit_ctx *ctx)
+{
+	emit_instr(ctx, sltu, dst, src1, src2);
+}
+
+static inline void emit_sltiu(unsigned dst, unsigned int src,
+			      unsigned int imm, struct jit_ctx *ctx)
+{
+	/* 16 bit immediate */
+	if (!is_range16((s32)imm)) {
+		emit_load_imm(r_tmp, imm, ctx);
+		emit_sltu(dst, src, r_tmp, ctx);
+	} else {
+		emit_instr(ctx, sltiu, dst, src, imm);
+	}
+
+}
+
+/* Store register on the stack */
+static inline void emit_store_stack_reg(ptr reg, ptr base,
+					unsigned int offset,
+					struct jit_ctx *ctx)
+{
+	emit_long_instr(ctx, SW, reg, offset, base);
+}
+
+static inline void emit_store(ptr reg, ptr base, unsigned int offset,
+			      struct jit_ctx *ctx)
+{
+	emit_instr(ctx, sw, reg, offset, base);
+}
+
+static inline void emit_load_stack_reg(ptr reg, ptr base,
+				       unsigned int offset,
+				       struct jit_ctx *ctx)
+{
+	emit_long_instr(ctx, LW, reg, offset, base);
+}
+
+static inline void emit_load(unsigned int reg, unsigned int base,
+			     unsigned int offset, struct jit_ctx *ctx)
+{
+	emit_instr(ctx, lw, reg, offset, base);
+}
+
+static inline void emit_load_byte(unsigned int reg, unsigned int base,
+				  unsigned int offset, struct jit_ctx *ctx)
+{
+	emit_instr(ctx, lb, reg, offset, base);
+}
+
+static inline void emit_half_load(unsigned int reg, unsigned int base,
+				  unsigned int offset, struct jit_ctx *ctx)
+{
+	emit_instr(ctx, lh, reg, offset, base);
+}
+
+static inline void emit_half_load_unsigned(unsigned int reg, unsigned int base,
+					   unsigned int offset, struct jit_ctx *ctx)
+{
+	emit_instr(ctx, lhu, reg, offset, base);
+}
+
+static inline void emit_mul(unsigned int dst, unsigned int src1,
+			    unsigned int src2, struct jit_ctx *ctx)
+{
+	emit_instr(ctx, mul, dst, src1, src2);
+}
+
+static inline void emit_div(unsigned int dst, unsigned int src,
+			    struct jit_ctx *ctx)
+{
+	if (ctx->target != NULL) {
+		u32 *p = &ctx->target[ctx->idx];
+		uasm_i_divu(&p, dst, src);
+		p = &ctx->target[ctx->idx + 1];
+		uasm_i_mflo(&p, dst);
+	}
+	ctx->idx += 2; /* 2 insts */
+}
+
+static inline void emit_mod(unsigned int dst, unsigned int src,
+			    struct jit_ctx *ctx)
+{
+	if (ctx->target != NULL) {
+		u32 *p = &ctx->target[ctx->idx];
+		uasm_i_divu(&p, dst, src);
+		p = &ctx->target[ctx->idx + 1];
+		uasm_i_mfhi(&p, dst);
+	}
+	ctx->idx += 2; /* 2 insts */
+}
+
+static inline void emit_dsll(unsigned int dst, unsigned int src,
+			     unsigned int sa, struct jit_ctx *ctx)
+{
+	emit_instr(ctx, dsll, dst, src, sa);
+}
+
+static inline void emit_dsrl32(unsigned int dst, unsigned int src,
+			       unsigned int sa, struct jit_ctx *ctx)
+{
+	emit_instr(ctx, dsrl32, dst, src, sa);
+}
+
+static inline void emit_wsbh(unsigned int dst, unsigned int src,
+			     struct jit_ctx *ctx)
+{
+	emit_instr(ctx, wsbh, dst, src);
+}
+
+/* load pointer to register */
+static inline void emit_load_ptr(unsigned int dst, unsigned int src,
+				     int imm, struct jit_ctx *ctx)
+{
+	/* src contains the base addr of the 32/64-pointer */
+	emit_long_instr(ctx, LW, dst, imm, src);
+}
+
+/* load a function pointer to register */
+static inline void emit_load_func(unsigned int reg, ptr imm,
+				  struct jit_ctx *ctx)
+{
+	if (IS_ENABLED(CONFIG_64BIT)) {
+		/* At this point imm is always 64-bit */
+		emit_load_imm(r_tmp, (u64)imm >> 32, ctx);
+		emit_dsll(r_tmp_imm, r_tmp, 16, ctx); /* left shift by 16 */
+		emit_ori(r_tmp, r_tmp_imm, (imm >> 16) & 0xffff, ctx);
+		emit_dsll(r_tmp_imm, r_tmp, 16, ctx); /* left shift by 16 */
+		emit_ori(reg, r_tmp_imm, imm & 0xffff, ctx);
+	} else {
+		emit_load_imm(reg, imm, ctx);
+	}
+}
+
+/* Move to real MIPS register */
+static inline void emit_reg_move(ptr dst, ptr src, struct jit_ctx *ctx)
+{
+	emit_long_instr(ctx, ADDU, dst, src, r_zero);
+}
+
+/* Move to JIT (32-bit) register */
+static inline void emit_jit_reg_move(ptr dst, ptr src, struct jit_ctx *ctx)
+{
+	emit_addu(dst, src, r_zero, ctx);
+}
+
+/* Compute the immediate value for PC-relative branches. */
+static inline u32 b_imm(unsigned int tgt, struct jit_ctx *ctx)
+{
+	if (ctx->target == NULL)
+		return 0;
+
+	/*
+	 * We want a pc-relative branch. We only do forward branches
+	 * so tgt is always after pc. tgt is the instruction offset
+	 * we want to jump to.
+
+	 * Branch on MIPS:
+	 * I: target_offset <- sign_extend(offset)
+	 * I+1: PC += target_offset (delay slot)
+	 *
+	 * ctx->idx currently points to the branch instruction
+	 * but the offset is added to the delay slot so we need
+	 * to subtract 4.
+	 */
+	return ctx->offsets[tgt] -
+		(ctx->idx * 4 - ctx->prologue_bytes) - 4;
+}
+
+static inline void emit_bcond(int cond, unsigned int reg1, unsigned int reg2,
+			     unsigned int imm, struct jit_ctx *ctx)
+{
+	if (ctx->target != NULL) {
+		u32 *p = &ctx->target[ctx->idx];
+
+		switch (cond) {
+		case MIPS_COND_EQ:
+			uasm_i_beq(&p, reg1, reg2, imm);
+			break;
+		case MIPS_COND_NE:
+			uasm_i_bne(&p, reg1, reg2, imm);
+			break;
+		case MIPS_COND_ALL:
+			uasm_i_b(&p, imm);
+			break;
+		default:
+			pr_warn("%s: Unhandled branch conditional: %d\n",
+				__func__, cond);
+		}
+	}
+	ctx->idx++;
+}
+
+static inline void emit_b(unsigned int imm, struct jit_ctx *ctx)
+{
+	emit_bcond(MIPS_COND_ALL, r_zero, r_zero, imm, ctx);
+}
+
+static inline void emit_jalr(unsigned int link, unsigned int reg,
+			     struct jit_ctx *ctx)
+{
+	emit_instr(ctx, jalr, link, reg);
+}
+
+static inline void emit_jr(unsigned int reg, struct jit_ctx *ctx)
+{
+	emit_instr(ctx, jr, reg);
+}
+
+static inline u16 align_sp(unsigned int num)
+{
+	/* Double word alignment for 32-bit, quadword for 64-bit */
+	unsigned int align = IS_ENABLED(CONFIG_64BIT) ? 16 : 8;
+	num = (num + (align - 1)) & -align;
+	return num;
+}
+
+static void save_bpf_jit_regs(struct jit_ctx *ctx, unsigned offset)
+{
+	int i = 0, real_off = 0;
+	u32 sflags, tmp_flags;
+
+	/* Adjust the stack pointer */
+	if (offset)
+		emit_stack_offset(-align_sp(offset), ctx);
+
+	tmp_flags = sflags = ctx->flags >> SEEN_SREG_SFT;
+	/* sflags is essentially a bitmap */
+	while (tmp_flags) {
+		if ((sflags >> i) & 0x1) {
+			emit_store_stack_reg(MIPS_R_S0 + i, r_sp, real_off,
+					     ctx);
+			real_off += SZREG;
+		}
+		i++;
+		tmp_flags >>= 1;
+	}
+
+	/* save return address */
+	if (ctx->flags & SEEN_CALL) {
+		emit_store_stack_reg(r_ra, r_sp, real_off, ctx);
+		real_off += SZREG;
+	}
+
+	/* Setup r_M leaving the alignment gap if necessary */
+	if (ctx->flags & SEEN_MEM) {
+		if (real_off % (SZREG * 2))
+			real_off += SZREG;
+		emit_long_instr(ctx, ADDIU, r_M, r_sp, real_off);
+	}
+}
+
+static void restore_bpf_jit_regs(struct jit_ctx *ctx,
+				 unsigned int offset)
+{
+	int i, real_off = 0;
+	u32 sflags, tmp_flags;
+
+	tmp_flags = sflags = ctx->flags >> SEEN_SREG_SFT;
+	/* sflags is a bitmap */
+	i = 0;
+	while (tmp_flags) {
+		if ((sflags >> i) & 0x1) {
+			emit_load_stack_reg(MIPS_R_S0 + i, r_sp, real_off,
+					    ctx);
+			real_off += SZREG;
+		}
+		i++;
+		tmp_flags >>= 1;
+	}
+
+	/* restore return address */
+	if (ctx->flags & SEEN_CALL)
+		emit_load_stack_reg(r_ra, r_sp, real_off, ctx);
+
+	/* Restore the sp and discard the scrach memory */
+	if (offset)
+		emit_stack_offset(align_sp(offset), ctx);
+}
+
+static unsigned int get_stack_depth(struct jit_ctx *ctx)
+{
+	int sp_off = 0;
+
+
+	/* How may s* regs do we need to preserved? */
+	sp_off += hweight32(ctx->flags >> SEEN_SREG_SFT) * SZREG;
+
+	if (ctx->flags & SEEN_MEM)
+		sp_off += 4 * BPF_MEMWORDS; /* BPF_MEMWORDS are 32-bit */
+
+	if (ctx->flags & SEEN_CALL)
+		sp_off += SZREG; /* Space for our ra register */
+
+	return sp_off;
+}
+
+static void build_prologue(struct jit_ctx *ctx)
+{
+	int sp_off;
+
+	/* Calculate the total offset for the stack pointer */
+	sp_off = get_stack_depth(ctx);
+	save_bpf_jit_regs(ctx, sp_off);
+
+	if (ctx->flags & SEEN_SKB)
+		emit_reg_move(r_skb, MIPS_R_A0, ctx);
+
+	if (ctx->flags & SEEN_SKB_DATA) {
+		/* Load packet length */
+		emit_load(r_skb_len, r_skb, offsetof(struct sk_buff, len),
+			  ctx);
+		emit_load(r_tmp, r_skb, offsetof(struct sk_buff, data_len),
+			  ctx);
+		/* Load the data pointer */
+		emit_load_ptr(r_skb_data, r_skb,
+			      offsetof(struct sk_buff, data), ctx);
+		/* Load the header length */
+		emit_subu(r_skb_hl, r_skb_len, r_tmp, ctx);
+	}
+
+	if (ctx->flags & SEEN_X)
+		emit_jit_reg_move(r_X, r_zero, ctx);
+
+	/*
+	 * Do not leak kernel data to userspace, we only need to clear
+	 * r_A if it is ever used.  In fact if it is never used, we
+	 * will not save/restore it, so clearing it in this case would
+	 * corrupt the state of the caller.
+	 */
+	if (bpf_needs_clear_a(&ctx->skf->insns[0]) &&
+	    (ctx->flags & SEEN_A))
+		emit_jit_reg_move(r_A, r_zero, ctx);
+}
+
+static void build_epilogue(struct jit_ctx *ctx)
+{
+	unsigned int sp_off;
+
+	/* Calculate the total offset for the stack pointer */
+
+	sp_off = get_stack_depth(ctx);
+	restore_bpf_jit_regs(ctx, sp_off);
+
+	/* Return */
+	emit_jr(r_ra, ctx);
+	emit_nop(ctx);
+}
+
+#define CHOOSE_LOAD_FUNC(K, func) \
+	((int)K < 0 ? ((int)K >= SKF_LL_OFF ? func##_negative : func) : \
+	 func##_positive)
+
+static int build_body(struct jit_ctx *ctx)
+{
+	const struct bpf_prog *prog = ctx->skf;
+	const struct sock_filter *inst;
+	unsigned int i, off, condt;
+	u32 k, b_off __maybe_unused;
+	u8 (*sk_load_func)(unsigned long *skb, int offset);
+
+	for (i = 0; i < prog->len; i++) {
+		u16 code;
+
+		inst = &(prog->insns[i]);
+		pr_debug("%s: code->0x%02x, jt->0x%x, jf->0x%x, k->0x%x\n",
+			 __func__, inst->code, inst->jt, inst->jf, inst->k);
+		k = inst->k;
+		code = bpf_anc_helper(inst);
+
+		if (ctx->target == NULL)
+			ctx->offsets[i] = ctx->idx * 4;
+
+		switch (code) {
+		case BPF_LD | BPF_IMM:
+			/* A <- k ==> li r_A, k */
+			ctx->flags |= SEEN_A;
+			emit_load_imm(r_A, k, ctx);
+			break;
+		case BPF_LD | BPF_W | BPF_LEN:
+			BUILD_BUG_ON(FIELD_SIZEOF(struct sk_buff, len) != 4);
+			/* A <- len ==> lw r_A, offset(skb) */
+			ctx->flags |= SEEN_SKB | SEEN_A;
+			off = offsetof(struct sk_buff, len);
+			emit_load(r_A, r_skb, off, ctx);
+			break;
+		case BPF_LD | BPF_MEM:
+			/* A <- M[k] ==> lw r_A, offset(M) */
+			ctx->flags |= SEEN_MEM | SEEN_A;
+			emit_load(r_A, r_M, SCRATCH_OFF(k), ctx);
+			break;
+		case BPF_LD | BPF_W | BPF_ABS:
+			/* A <- P[k:4] */
+			sk_load_func = CHOOSE_LOAD_FUNC(k, sk_load_word);
+			goto load;
+		case BPF_LD | BPF_H | BPF_ABS:
+			/* A <- P[k:2] */
+			sk_load_func = CHOOSE_LOAD_FUNC(k, sk_load_half);
+			goto load;
+		case BPF_LD | BPF_B | BPF_ABS:
+			/* A <- P[k:1] */
+			sk_load_func = CHOOSE_LOAD_FUNC(k, sk_load_byte);
+load:
+			emit_load_imm(r_off, k, ctx);
+load_common:
+			ctx->flags |= SEEN_CALL | SEEN_OFF |
+				SEEN_SKB | SEEN_A | SEEN_SKB_DATA;
+
+			emit_load_func(r_s0, (ptr)sk_load_func, ctx);
+			emit_reg_move(MIPS_R_A0, r_skb, ctx);
+			emit_jalr(MIPS_R_RA, r_s0, ctx);
+			/* Load second argument to delay slot */
+			emit_reg_move(MIPS_R_A1, r_off, ctx);
+			/* Check the error value */
+			emit_bcond(MIPS_COND_EQ, r_ret, 0, b_imm(i + 1, ctx),
+				   ctx);
+			/* Load return register on DS for failures */
+			emit_reg_move(r_ret, r_zero, ctx);
+			/* Return with error */
+			emit_b(b_imm(prog->len, ctx), ctx);
+			emit_nop(ctx);
+			break;
+		case BPF_LD | BPF_W | BPF_IND:
+			/* A <- P[X + k:4] */
+			sk_load_func = sk_load_word;
+			goto load_ind;
+		case BPF_LD | BPF_H | BPF_IND:
+			/* A <- P[X + k:2] */
+			sk_load_func = sk_load_half;
+			goto load_ind;
+		case BPF_LD | BPF_B | BPF_IND:
+			/* A <- P[X + k:1] */
+			sk_load_func = sk_load_byte;
+load_ind:
+			ctx->flags |= SEEN_OFF | SEEN_X;
+			emit_addiu(r_off, r_X, k, ctx);
+			goto load_common;
+		case BPF_LDX | BPF_IMM:
+			/* X <- k */
+			ctx->flags |= SEEN_X;
+			emit_load_imm(r_X, k, ctx);
+			break;
+		case BPF_LDX | BPF_MEM:
+			/* X <- M[k] */
+			ctx->flags |= SEEN_X | SEEN_MEM;
+			emit_load(r_X, r_M, SCRATCH_OFF(k), ctx);
+			break;
+		case BPF_LDX | BPF_W | BPF_LEN:
+			/* X <- len */
+			ctx->flags |= SEEN_X | SEEN_SKB;
+			off = offsetof(struct sk_buff, len);
+			emit_load(r_X, r_skb, off, ctx);
+			break;
+		case BPF_LDX | BPF_B | BPF_MSH:
+			/* X <- 4 * (P[k:1] & 0xf) */
+			ctx->flags |= SEEN_X | SEEN_CALL | SEEN_SKB;
+			/* Load offset to a1 */
+			emit_load_func(r_s0, (ptr)sk_load_byte, ctx);
+			/*
+			 * This may emit two instructions so it may not fit
+			 * in the delay slot. So use a0 in the delay slot.
+			 */
+			emit_load_imm(MIPS_R_A1, k, ctx);
+			emit_jalr(MIPS_R_RA, r_s0, ctx);
+			emit_reg_move(MIPS_R_A0, r_skb, ctx); /* delay slot */
+			/* Check the error value */
+			emit_bcond(MIPS_COND_NE, r_ret, 0,
+				   b_imm(prog->len, ctx), ctx);
+			emit_reg_move(r_ret, r_zero, ctx);
+			/* We are good */
+			/* X <- P[1:K] & 0xf */
+			emit_andi(r_X, r_A, 0xf, ctx);
+			/* X << 2 */
+			emit_b(b_imm(i + 1, ctx), ctx);
+			emit_sll(r_X, r_X, 2, ctx); /* delay slot */
+			break;
+		case BPF_ST:
+			/* M[k] <- A */
+			ctx->flags |= SEEN_MEM | SEEN_A;
+			emit_store(r_A, r_M, SCRATCH_OFF(k), ctx);
+			break;
+		case BPF_STX:
+			/* M[k] <- X */
+			ctx->flags |= SEEN_MEM | SEEN_X;
+			emit_store(r_X, r_M, SCRATCH_OFF(k), ctx);
+			break;
+		case BPF_ALU | BPF_ADD | BPF_K:
+			/* A += K */
+			ctx->flags |= SEEN_A;
+			emit_addiu(r_A, r_A, k, ctx);
+			break;
+		case BPF_ALU | BPF_ADD | BPF_X:
+			/* A += X */
+			ctx->flags |= SEEN_A | SEEN_X;
+			emit_addu(r_A, r_A, r_X, ctx);
+			break;
+		case BPF_ALU | BPF_SUB | BPF_K:
+			/* A -= K */
+			ctx->flags |= SEEN_A;
+			emit_addiu(r_A, r_A, -k, ctx);
+			break;
+		case BPF_ALU | BPF_SUB | BPF_X:
+			/* A -= X */
+			ctx->flags |= SEEN_A | SEEN_X;
+			emit_subu(r_A, r_A, r_X, ctx);
+			break;
+		case BPF_ALU | BPF_MUL | BPF_K:
+			/* A *= K */
+			/* Load K to scratch register before MUL */
+			ctx->flags |= SEEN_A;
+			emit_load_imm(r_s0, k, ctx);
+			emit_mul(r_A, r_A, r_s0, ctx);
+			break;
+		case BPF_ALU | BPF_MUL | BPF_X:
+			/* A *= X */
+			ctx->flags |= SEEN_A | SEEN_X;
+			emit_mul(r_A, r_A, r_X, ctx);
+			break;
+		case BPF_ALU | BPF_DIV | BPF_K:
+			/* A /= k */
+			if (k == 1)
+				break;
+			if (optimize_div(&k)) {
+				ctx->flags |= SEEN_A;
+				emit_srl(r_A, r_A, k, ctx);
+				break;
+			}
+			ctx->flags |= SEEN_A;
+			emit_load_imm(r_s0, k, ctx);
+			emit_div(r_A, r_s0, ctx);
+			break;
+		case BPF_ALU | BPF_MOD | BPF_K:
+			/* A %= k */
+			if (k == 1) {
+				ctx->flags |= SEEN_A;
+				emit_jit_reg_move(r_A, r_zero, ctx);
+			} else {
+				ctx->flags |= SEEN_A;
+				emit_load_imm(r_s0, k, ctx);
+				emit_mod(r_A, r_s0, ctx);
+			}
+			break;
+		case BPF_ALU | BPF_DIV | BPF_X:
+			/* A /= X */
+			ctx->flags |= SEEN_X | SEEN_A;
+			/* Check if r_X is zero */
+			emit_bcond(MIPS_COND_EQ, r_X, r_zero,
+				   b_imm(prog->len, ctx), ctx);
+			emit_load_imm(r_ret, 0, ctx); /* delay slot */
+			emit_div(r_A, r_X, ctx);
+			break;
+		case BPF_ALU | BPF_MOD | BPF_X:
+			/* A %= X */
+			ctx->flags |= SEEN_X | SEEN_A;
+			/* Check if r_X is zero */
+			emit_bcond(MIPS_COND_EQ, r_X, r_zero,
+				   b_imm(prog->len, ctx), ctx);
+			emit_load_imm(r_ret, 0, ctx); /* delay slot */
+			emit_mod(r_A, r_X, ctx);
+			break;
+		case BPF_ALU | BPF_OR | BPF_K:
+			/* A |= K */
+			ctx->flags |= SEEN_A;
+			emit_ori(r_A, r_A, k, ctx);
+			break;
+		case BPF_ALU | BPF_OR | BPF_X:
+			/* A |= X */
+			ctx->flags |= SEEN_A;
+			emit_ori(r_A, r_A, r_X, ctx);
+			break;
+		case BPF_ALU | BPF_XOR | BPF_K:
+			/* A ^= k */
+			ctx->flags |= SEEN_A;
+			emit_xori(r_A, r_A, k, ctx);
+			break;
+		case BPF_ANC | SKF_AD_ALU_XOR_X:
+		case BPF_ALU | BPF_XOR | BPF_X:
+			/* A ^= X */
+			ctx->flags |= SEEN_A;
+			emit_xor(r_A, r_A, r_X, ctx);
+			break;
+		case BPF_ALU | BPF_AND | BPF_K:
+			/* A &= K */
+			ctx->flags |= SEEN_A;
+			emit_andi(r_A, r_A, k, ctx);
+			break;
+		case BPF_ALU | BPF_AND | BPF_X:
+			/* A &= X */
+			ctx->flags |= SEEN_A | SEEN_X;
+			emit_and(r_A, r_A, r_X, ctx);
+			break;
+		case BPF_ALU | BPF_LSH | BPF_K:
+			/* A <<= K */
+			ctx->flags |= SEEN_A;
+			emit_sll(r_A, r_A, k, ctx);
+			break;
+		case BPF_ALU | BPF_LSH | BPF_X:
+			/* A <<= X */
+			ctx->flags |= SEEN_A | SEEN_X;
+			emit_sllv(r_A, r_A, r_X, ctx);
+			break;
+		case BPF_ALU | BPF_RSH | BPF_K:
+			/* A >>= K */
+			ctx->flags |= SEEN_A;
+			emit_srl(r_A, r_A, k, ctx);
+			break;
+		case BPF_ALU | BPF_RSH | BPF_X:
+			ctx->flags |= SEEN_A | SEEN_X;
+			emit_srlv(r_A, r_A, r_X, ctx);
+			break;
+		case BPF_ALU | BPF_NEG:
+			/* A = -A */
+			ctx->flags |= SEEN_A;
+			emit_neg(r_A, ctx);
+			break;
+		case BPF_JMP | BPF_JA:
+			/* pc += K */
+			emit_b(b_imm(i + k + 1, ctx), ctx);
+			emit_nop(ctx);
+			break;
+		case BPF_JMP | BPF_JEQ | BPF_K:
+			/* pc += ( A == K ) ? pc->jt : pc->jf */
+			condt = MIPS_COND_EQ | MIPS_COND_K;
+			goto jmp_cmp;
+		case BPF_JMP | BPF_JEQ | BPF_X:
+			ctx->flags |= SEEN_X;
+			/* pc += ( A == X ) ? pc->jt : pc->jf */
+			condt = MIPS_COND_EQ | MIPS_COND_X;
+			goto jmp_cmp;
+		case BPF_JMP | BPF_JGE | BPF_K:
+			/* pc += ( A >= K ) ? pc->jt : pc->jf */
+			condt = MIPS_COND_GE | MIPS_COND_K;
+			goto jmp_cmp;
+		case BPF_JMP | BPF_JGE | BPF_X:
+			ctx->flags |= SEEN_X;
+			/* pc += ( A >= X ) ? pc->jt : pc->jf */
+			condt = MIPS_COND_GE | MIPS_COND_X;
+			goto jmp_cmp;
+		case BPF_JMP | BPF_JGT | BPF_K:
+			/* pc += ( A > K ) ? pc->jt : pc->jf */
+			condt = MIPS_COND_GT | MIPS_COND_K;
+			goto jmp_cmp;
+		case BPF_JMP | BPF_JGT | BPF_X:
+			ctx->flags |= SEEN_X;
+			/* pc += ( A > X ) ? pc->jt : pc->jf */
+			condt = MIPS_COND_GT | MIPS_COND_X;
+jmp_cmp:
+			/* Greater or Equal */
+			if ((condt & MIPS_COND_GE) ||
+			    (condt & MIPS_COND_GT)) {
+				if (condt & MIPS_COND_K) { /* K */
+					ctx->flags |= SEEN_A;
+					emit_sltiu(r_s0, r_A, k, ctx);
+				} else { /* X */
+					ctx->flags |= SEEN_A |
+						SEEN_X;
+					emit_sltu(r_s0, r_A, r_X, ctx);
+				}
+				/* A < (K|X) ? r_scrach = 1 */
+				b_off = b_imm(i + inst->jf + 1, ctx);
+				emit_bcond(MIPS_COND_NE, r_s0, r_zero, b_off,
+					   ctx);
+				emit_nop(ctx);
+				/* A > (K|X) ? scratch = 0 */
+				if (condt & MIPS_COND_GT) {
+					/* Checking for equality */
+					ctx->flags |= SEEN_A | SEEN_X;
+					if (condt & MIPS_COND_K)
+						emit_load_imm(r_s0, k, ctx);
+					else
+						emit_jit_reg_move(r_s0, r_X,
+								  ctx);
+					b_off = b_imm(i + inst->jf + 1, ctx);
+					emit_bcond(MIPS_COND_EQ, r_A, r_s0,
+						   b_off, ctx);
+					emit_nop(ctx);
+					/* Finally, A > K|X */
+					b_off = b_imm(i + inst->jt + 1, ctx);
+					emit_b(b_off, ctx);
+					emit_nop(ctx);
+				} else {
+					/* A >= (K|X) so jump */
+					b_off = b_imm(i + inst->jt + 1, ctx);
+					emit_b(b_off, ctx);
+					emit_nop(ctx);
+				}
+			} else {
+				/* A == K|X */
+				if (condt & MIPS_COND_K) { /* K */
+					ctx->flags |= SEEN_A;
+					emit_load_imm(r_s0, k, ctx);
+					/* jump true */
+					b_off = b_imm(i + inst->jt + 1, ctx);
+					emit_bcond(MIPS_COND_EQ, r_A, r_s0,
+						   b_off, ctx);
+					emit_nop(ctx);
+					/* jump false */
+					b_off = b_imm(i + inst->jf + 1,
+						      ctx);
+					emit_bcond(MIPS_COND_NE, r_A, r_s0,
+						   b_off, ctx);
+					emit_nop(ctx);
+				} else { /* X */
+					/* jump true */
+					ctx->flags |= SEEN_A | SEEN_X;
+					b_off = b_imm(i + inst->jt + 1,
+						      ctx);
+					emit_bcond(MIPS_COND_EQ, r_A, r_X,
+						   b_off, ctx);
+					emit_nop(ctx);
+					/* jump false */
+					b_off = b_imm(i + inst->jf + 1, ctx);
+					emit_bcond(MIPS_COND_NE, r_A, r_X,
+						   b_off, ctx);
+					emit_nop(ctx);
+				}
+			}
+			break;
+		case BPF_JMP | BPF_JSET | BPF_K:
+			ctx->flags |= SEEN_A;
+			/* pc += (A & K) ? pc -> jt : pc -> jf */
+			emit_load_imm(r_s1, k, ctx);
+			emit_and(r_s0, r_A, r_s1, ctx);
+			/* jump true */
+			b_off = b_imm(i + inst->jt + 1, ctx);
+			emit_bcond(MIPS_COND_NE, r_s0, r_zero, b_off, ctx);
+			emit_nop(ctx);
+			/* jump false */
+			b_off = b_imm(i + inst->jf + 1, ctx);
+			emit_b(b_off, ctx);
+			emit_nop(ctx);
+			break;
+		case BPF_JMP | BPF_JSET | BPF_X:
+			ctx->flags |= SEEN_X | SEEN_A;
+			/* pc += (A & X) ? pc -> jt : pc -> jf */
+			emit_and(r_s0, r_A, r_X, ctx);
+			/* jump true */
+			b_off = b_imm(i + inst->jt + 1, ctx);
+			emit_bcond(MIPS_COND_NE, r_s0, r_zero, b_off, ctx);
+			emit_nop(ctx);
+			/* jump false */
+			b_off = b_imm(i + inst->jf + 1, ctx);
+			emit_b(b_off, ctx);
+			emit_nop(ctx);
+			break;
+		case BPF_RET | BPF_A:
+			ctx->flags |= SEEN_A;
+			if (i != prog->len - 1)
+				/*
+				 * If this is not the last instruction
+				 * then jump to the epilogue
+				 */
+				emit_b(b_imm(prog->len, ctx), ctx);
+			emit_reg_move(r_ret, r_A, ctx); /* delay slot */
+			break;
+		case BPF_RET | BPF_K:
+			/*
+			 * It can emit two instructions so it does not fit on
+			 * the delay slot.
+			 */
+			emit_load_imm(r_ret, k, ctx);
+			if (i != prog->len - 1) {
+				/*
+				 * If this is not the last instruction
+				 * then jump to the epilogue
+				 */
+				emit_b(b_imm(prog->len, ctx), ctx);
+				emit_nop(ctx);
+			}
+			break;
+		case BPF_MISC | BPF_TAX:
+			/* X = A */
+			ctx->flags |= SEEN_X | SEEN_A;
+			emit_jit_reg_move(r_X, r_A, ctx);
+			break;
+		case BPF_MISC | BPF_TXA:
+			/* A = X */
+			ctx->flags |= SEEN_A | SEEN_X;
+			emit_jit_reg_move(r_A, r_X, ctx);
+			break;
+		/* AUX */
+		case BPF_ANC | SKF_AD_PROTOCOL:
+			/* A = ntohs(skb->protocol */
+			ctx->flags |= SEEN_SKB | SEEN_OFF | SEEN_A;
+			BUILD_BUG_ON(FIELD_SIZEOF(struct sk_buff,
+						  protocol) != 2);
+			off = offsetof(struct sk_buff, protocol);
+			emit_half_load(r_A, r_skb, off, ctx);
+#ifdef CONFIG_CPU_LITTLE_ENDIAN
+			/* This needs little endian fixup */
+			if (cpu_has_wsbh) {
+				/* R2 and later have the wsbh instruction */
+				emit_wsbh(r_A, r_A, ctx);
+			} else {
+				/* Get first byte */
+				emit_andi(r_tmp_imm, r_A, 0xff, ctx);
+				/* Shift it */
+				emit_sll(r_tmp, r_tmp_imm, 8, ctx);
+				/* Get second byte */
+				emit_srl(r_tmp_imm, r_A, 8, ctx);
+				emit_andi(r_tmp_imm, r_tmp_imm, 0xff, ctx);
+				/* Put everyting together in r_A */
+				emit_or(r_A, r_tmp, r_tmp_imm, ctx);
+			}
+#endif
+			break;
+		case BPF_ANC | SKF_AD_CPU:
+			ctx->flags |= SEEN_A | SEEN_OFF;
+			/* A = current_thread_info()->cpu */
+			BUILD_BUG_ON(FIELD_SIZEOF(struct thread_info,
+						  cpu) != 4);
+			off = offsetof(struct thread_info, cpu);
+			/* $28/gp points to the thread_info struct */
+			emit_load(r_A, 28, off, ctx);
+			break;
+		case BPF_ANC | SKF_AD_IFINDEX:
+			/* A = skb->dev->ifindex */
+		case BPF_ANC | SKF_AD_HATYPE:
+			/* A = skb->dev->type */
+			ctx->flags |= SEEN_SKB | SEEN_A;
+			off = offsetof(struct sk_buff, dev);
+			/* Load *dev pointer */
+			emit_load_ptr(r_s0, r_skb, off, ctx);
+			/* error (0) in the delay slot */
+			emit_bcond(MIPS_COND_EQ, r_s0, r_zero,
+				   b_imm(prog->len, ctx), ctx);
+			emit_reg_move(r_ret, r_zero, ctx);
+			if (code == (BPF_ANC | SKF_AD_IFINDEX)) {
+				BUILD_BUG_ON(FIELD_SIZEOF(struct net_device, ifindex) != 4);
+				off = offsetof(struct net_device, ifindex);
+				emit_load(r_A, r_s0, off, ctx);
+			} else { /* (code == (BPF_ANC | SKF_AD_HATYPE) */
+				BUILD_BUG_ON(FIELD_SIZEOF(struct net_device, type) != 2);
+				off = offsetof(struct net_device, type);
+				emit_half_load_unsigned(r_A, r_s0, off, ctx);
+			}
+			break;
+		case BPF_ANC | SKF_AD_MARK:
+			ctx->flags |= SEEN_SKB | SEEN_A;
+			BUILD_BUG_ON(FIELD_SIZEOF(struct sk_buff, mark) != 4);
+			off = offsetof(struct sk_buff, mark);
+			emit_load(r_A, r_skb, off, ctx);
+			break;
+		case BPF_ANC | SKF_AD_RXHASH:
+			ctx->flags |= SEEN_SKB | SEEN_A;
+			BUILD_BUG_ON(FIELD_SIZEOF(struct sk_buff, hash) != 4);
+			off = offsetof(struct sk_buff, hash);
+			emit_load(r_A, r_skb, off, ctx);
+			break;
+		case BPF_ANC | SKF_AD_VLAN_TAG:
+			ctx->flags |= SEEN_SKB | SEEN_A;
+			BUILD_BUG_ON(FIELD_SIZEOF(struct sk_buff,
+						  vlan_tci) != 2);
+			off = offsetof(struct sk_buff, vlan_tci);
+			emit_half_load_unsigned(r_A, r_skb, off, ctx);
+			break;
+		case BPF_ANC | SKF_AD_VLAN_TAG_PRESENT:
+			ctx->flags |= SEEN_SKB | SEEN_A;
+			emit_load_byte(r_A, r_skb, PKT_VLAN_PRESENT_OFFSET(), ctx);
+			if (PKT_VLAN_PRESENT_BIT)
+				emit_srl(r_A, r_A, PKT_VLAN_PRESENT_BIT, ctx);
+			if (PKT_VLAN_PRESENT_BIT < 7)
+				emit_andi(r_A, r_A, 1, ctx);
+			break;
+		case BPF_ANC | SKF_AD_PKTTYPE:
+			ctx->flags |= SEEN_SKB;
+
+			emit_load_byte(r_tmp, r_skb, PKT_TYPE_OFFSET(), ctx);
+			/* Keep only the last 3 bits */
+			emit_andi(r_A, r_tmp, PKT_TYPE_MAX, ctx);
+#ifdef __BIG_ENDIAN_BITFIELD
+			/* Get the actual packet type to the lower 3 bits */
+			emit_srl(r_A, r_A, 5, ctx);
+#endif
+			break;
+		case BPF_ANC | SKF_AD_QUEUE:
+			ctx->flags |= SEEN_SKB | SEEN_A;
+			BUILD_BUG_ON(FIELD_SIZEOF(struct sk_buff,
+						  queue_mapping) != 2);
+			BUILD_BUG_ON(offsetof(struct sk_buff,
+					      queue_mapping) > 0xff);
+			off = offsetof(struct sk_buff, queue_mapping);
+			emit_half_load_unsigned(r_A, r_skb, off, ctx);
+			break;
+		default:
+			pr_debug("%s: Unhandled opcode: 0x%02x\n", __FILE__,
+				 inst->code);
+			return -1;
+		}
+	}
+
+	/* compute offsets only during the first pass */
+	if (ctx->target == NULL)
+		ctx->offsets[i] = ctx->idx * 4;
+
+	return 0;
+}
+
+void bpf_jit_compile(struct bpf_prog *fp)
+{
+	struct jit_ctx ctx;
+	unsigned int alloc_size, tmp_idx;
+
+	if (!bpf_jit_enable)
+		return;
+
+	memset(&ctx, 0, sizeof(ctx));
+
+	ctx.offsets = kcalloc(fp->len + 1, sizeof(*ctx.offsets), GFP_KERNEL);
+	if (ctx.offsets == NULL)
+		return;
+
+	ctx.skf = fp;
+
+	if (build_body(&ctx))
+		goto out;
+
+	tmp_idx = ctx.idx;
+	build_prologue(&ctx);
+	ctx.prologue_bytes = (ctx.idx - tmp_idx) * 4;
+	/* just to complete the ctx.idx count */
+	build_epilogue(&ctx);
+
+	alloc_size = 4 * ctx.idx;
+	ctx.target = module_alloc(alloc_size);
+	if (ctx.target == NULL)
+		goto out;
+
+	/* Clean it */
+	memset(ctx.target, 0, alloc_size);
+
+	ctx.idx = 0;
+
+	/* Generate the actual JIT code */
+	build_prologue(&ctx);
+	build_body(&ctx);
+	build_epilogue(&ctx);
+
+	/* Update the icache */
+	flush_icache_range((ptr)ctx.target, (ptr)(ctx.target + ctx.idx));
+
+	if (bpf_jit_enable > 1)
+		/* Dump JIT code */
+		bpf_jit_dump(fp->len, alloc_size, 2, ctx.target);
+
+	fp->bpf_func = (void *)ctx.target;
+	fp->jited = 1;
+
+out:
+	kfree(ctx.offsets);
+}
+
+void bpf_jit_free(struct bpf_prog *fp)
+{
+	if (fp->jited)
+		module_memfree(fp->bpf_func);
+
+	bpf_prog_unlock_free(fp);
+}
diff --git a/arch/mips/net/bpf_jit_asm.S b/arch/mips/net/bpf_jit_asm.S
new file mode 100644
index 000000000000..57154c5883b6
--- /dev/null
+++ b/arch/mips/net/bpf_jit_asm.S
@@ -0,0 +1,285 @@
+/*
+ * bpf_jib_asm.S: Packet/header access helper functions for MIPS/MIPS64 BPF
+ * compiler.
+ *
+ * Copyright (C) 2015 Imagination Technologies Ltd.
+ * Author: Markos Chandras <markos.chandras@imgtec.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; version 2 of the License.
+ */
+
+#include <asm/asm.h>
+#include <asm/isa-rev.h>
+#include <asm/regdef.h>
+#include "bpf_jit.h"
+
+/* ABI
+ *
+ * r_skb_hl	skb header length
+ * r_skb_data	skb data
+ * r_off(a1)	offset register
+ * r_A		BPF register A
+ * r_X		PF register X
+ * r_skb(a0)	*skb
+ * r_M		*scratch memory
+ * r_skb_le	skb length
+ * r_s0		Scratch register 0
+ * r_s1		Scratch register 1
+ *
+ * On entry:
+ * a0: *skb
+ * a1: offset (imm or imm + X)
+ *
+ * All non-BPF-ABI registers are free for use. On return, we only
+ * care about r_ret. The BPF-ABI registers are assumed to remain
+ * unmodified during the entire filter operation.
+ */
+
+#define skb	a0
+#define offset	a1
+#define SKF_LL_OFF  (-0x200000) /* Can't include linux/filter.h in assembly */
+
+	/* We know better :) so prevent assembler reordering etc */
+	.set 	noreorder
+
+#define is_offset_negative(TYPE)				\
+	/* If offset is negative we have more work to do */	\
+	slti	t0, offset, 0;					\
+	bgtz	t0, bpf_slow_path_##TYPE##_neg;			\
+	/* Be careful what follows in DS. */
+
+#define is_offset_in_header(SIZE, TYPE)				\
+	/* Reading from header? */				\
+	addiu	$r_s0, $r_skb_hl, -SIZE;			\
+	slt	t0, $r_s0, offset;				\
+	bgtz	t0, bpf_slow_path_##TYPE;			\
+
+LEAF(sk_load_word)
+	is_offset_negative(word)
+FEXPORT(sk_load_word_positive)
+	is_offset_in_header(4, word)
+	/* Offset within header boundaries */
+	PTR_ADDU t1, $r_skb_data, offset
+	.set	reorder
+	lw	$r_A, 0(t1)
+	.set	noreorder
+#ifdef CONFIG_CPU_LITTLE_ENDIAN
+# if MIPS_ISA_REV >= 2
+	wsbh	t0, $r_A
+	rotr	$r_A, t0, 16
+# else
+	sll	t0, $r_A, 24
+	srl	t1, $r_A, 24
+	srl	t2, $r_A, 8
+	or	t0, t0, t1
+	andi	t2, t2, 0xff00
+	andi	t1, $r_A, 0xff00
+	or	t0, t0, t2
+	sll	t1, t1, 8
+	or	$r_A, t0, t1
+# endif
+#endif
+	jr	$r_ra
+	 move	$r_ret, zero
+	END(sk_load_word)
+
+LEAF(sk_load_half)
+	is_offset_negative(half)
+FEXPORT(sk_load_half_positive)
+	is_offset_in_header(2, half)
+	/* Offset within header boundaries */
+	PTR_ADDU t1, $r_skb_data, offset
+	lhu	$r_A, 0(t1)
+#ifdef CONFIG_CPU_LITTLE_ENDIAN
+# if MIPS_ISA_REV >= 2
+	wsbh	$r_A, $r_A
+# else
+	sll	t0, $r_A, 8
+	srl	t1, $r_A, 8
+	andi	t0, t0, 0xff00
+	or	$r_A, t0, t1
+# endif
+#endif
+	jr	$r_ra
+	 move	$r_ret, zero
+	END(sk_load_half)
+
+LEAF(sk_load_byte)
+	is_offset_negative(byte)
+FEXPORT(sk_load_byte_positive)
+	is_offset_in_header(1, byte)
+	/* Offset within header boundaries */
+	PTR_ADDU t1, $r_skb_data, offset
+	lbu	$r_A, 0(t1)
+	jr	$r_ra
+	 move	$r_ret, zero
+	END(sk_load_byte)
+
+/*
+ * call skb_copy_bits:
+ * (prototype in linux/skbuff.h)
+ *
+ * int skb_copy_bits(sk_buff *skb, int offset, void *to, int len)
+ *
+ * o32 mandates we leave 4 spaces for argument registers in case
+ * the callee needs to use them. Even though we don't care about
+ * the argument registers ourselves, we need to allocate that space
+ * to remain ABI compliant since the callee may want to use that space.
+ * We also allocate 2 more spaces for $r_ra and our return register (*to).
+ *
+ * n64 is a bit different. The *caller* will allocate the space to preserve
+ * the arguments. So in 64-bit kernels, we allocate the 4-arg space for no
+ * good reason but it does not matter that much really.
+ *
+ * (void *to) is returned in r_s0
+ *
+ */
+#ifdef CONFIG_CPU_LITTLE_ENDIAN
+#define DS_OFFSET(SIZE) (4 * SZREG)
+#else
+#define DS_OFFSET(SIZE) ((4 * SZREG) + (4 - SIZE))
+#endif
+#define bpf_slow_path_common(SIZE)				\
+	/* Quick check. Are we within reasonable boundaries? */ \
+	LONG_ADDIU	$r_s1, $r_skb_len, -SIZE;		\
+	sltu		$r_s0, offset, $r_s1;			\
+	beqz		$r_s0, fault;				\
+	/* Load 4th argument in DS */				\
+	 LONG_ADDIU	a3, zero, SIZE;				\
+	PTR_ADDIU	$r_sp, $r_sp, -(6 * SZREG);		\
+	PTR_LA		t0, skb_copy_bits;			\
+	PTR_S		$r_ra, (5 * SZREG)($r_sp);		\
+	/* Assign low slot to a2 */				\
+	PTR_ADDIU	a2, $r_sp, DS_OFFSET(SIZE);		\
+	jalr		t0;					\
+	/* Reset our destination slot (DS but it's ok) */	\
+	 INT_S		zero, (4 * SZREG)($r_sp);		\
+	/*							\
+	 * skb_copy_bits returns 0 on success and -EFAULT	\
+	 * on error. Our data live in a2. Do not bother with	\
+	 * our data if an error has been returned.		\
+	 */							\
+	/* Restore our frame */					\
+	PTR_L		$r_ra, (5 * SZREG)($r_sp);		\
+	INT_L		$r_s0, (4 * SZREG)($r_sp);		\
+	bltz		v0, fault;				\
+	 PTR_ADDIU	$r_sp, $r_sp, 6 * SZREG;		\
+	move		$r_ret, zero;				\
+
+NESTED(bpf_slow_path_word, (6 * SZREG), $r_sp)
+	bpf_slow_path_common(4)
+#ifdef CONFIG_CPU_LITTLE_ENDIAN
+# if MIPS_ISA_REV >= 2
+	wsbh	t0, $r_s0
+	jr	$r_ra
+	 rotr	$r_A, t0, 16
+# else
+	sll	t0, $r_s0, 24
+	srl	t1, $r_s0, 24
+	srl	t2, $r_s0, 8
+	or	t0, t0, t1
+	andi	t2, t2, 0xff00
+	andi	t1, $r_s0, 0xff00
+	or	t0, t0, t2
+	sll	t1, t1, 8
+	jr	$r_ra
+	 or	$r_A, t0, t1
+# endif
+#else
+	jr	$r_ra
+	 move	$r_A, $r_s0
+#endif
+
+	END(bpf_slow_path_word)
+
+NESTED(bpf_slow_path_half, (6 * SZREG), $r_sp)
+	bpf_slow_path_common(2)
+#ifdef CONFIG_CPU_LITTLE_ENDIAN
+# if MIPS_ISA_REV >= 2
+	jr	$r_ra
+	 wsbh	$r_A, $r_s0
+# else
+	sll	t0, $r_s0, 8
+	andi	t1, $r_s0, 0xff00
+	andi	t0, t0, 0xff00
+	srl	t1, t1, 8
+	jr	$r_ra
+	 or	$r_A, t0, t1
+# endif
+#else
+	jr	$r_ra
+	 move	$r_A, $r_s0
+#endif
+
+	END(bpf_slow_path_half)
+
+NESTED(bpf_slow_path_byte, (6 * SZREG), $r_sp)
+	bpf_slow_path_common(1)
+	jr	$r_ra
+	 move	$r_A, $r_s0
+
+	END(bpf_slow_path_byte)
+
+/*
+ * Negative entry points
+ */
+	.macro bpf_is_end_of_data
+	li	t0, SKF_LL_OFF
+	/* Reading link layer data? */
+	slt	t1, offset, t0
+	bgtz	t1, fault
+	/* Be careful what follows in DS. */
+	.endm
+/*
+ * call skb_copy_bits:
+ * (prototype in linux/filter.h)
+ *
+ * void *bpf_internal_load_pointer_neg_helper(const struct sk_buff *skb,
+ *                                            int k, unsigned int size)
+ *
+ * see above (bpf_slow_path_common) for ABI restrictions
+ */
+#define bpf_negative_common(SIZE)					\
+	PTR_ADDIU	$r_sp, $r_sp, -(6 * SZREG);			\
+	PTR_LA		t0, bpf_internal_load_pointer_neg_helper;	\
+	PTR_S		$r_ra, (5 * SZREG)($r_sp);			\
+	jalr		t0;						\
+	 li		a2, SIZE;					\
+	PTR_L		$r_ra, (5 * SZREG)($r_sp);			\
+	/* Check return pointer */					\
+	beqz		v0, fault;					\
+	 PTR_ADDIU	$r_sp, $r_sp, 6 * SZREG;			\
+	/* Preserve our pointer */					\
+	move		$r_s0, v0;					\
+	/* Set return value */						\
+	move		$r_ret, zero;					\
+
+bpf_slow_path_word_neg:
+	bpf_is_end_of_data
+NESTED(sk_load_word_negative, (6 * SZREG), $r_sp)
+	bpf_negative_common(4)
+	jr	$r_ra
+	 lw	$r_A, 0($r_s0)
+	END(sk_load_word_negative)
+
+bpf_slow_path_half_neg:
+	bpf_is_end_of_data
+NESTED(sk_load_half_negative, (6 * SZREG), $r_sp)
+	bpf_negative_common(2)
+	jr	$r_ra
+	 lhu	$r_A, 0($r_s0)
+	END(sk_load_half_negative)
+
+bpf_slow_path_byte_neg:
+	bpf_is_end_of_data
+NESTED(sk_load_byte_negative, (6 * SZREG), $r_sp)
+	bpf_negative_common(1)
+	jr	$r_ra
+	 lbu	$r_A, 0($r_s0)
+	END(sk_load_byte_negative)
+
+fault:
+	jr	$r_ra
+	 addiu $r_ret, zero, 1
-- 
2.24.0

