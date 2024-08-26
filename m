Return-Path: <bpf+bounces-38060-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 080CB95E9E4
	for <lists+bpf@lfdr.de>; Mon, 26 Aug 2024 09:06:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BDE51F2373B
	for <lists+bpf@lfdr.de>; Mon, 26 Aug 2024 07:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48C49129E93;
	Mon, 26 Aug 2024 07:06:20 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF7A770E5
	for <bpf@vger.kernel.org>; Mon, 26 Aug 2024 07:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724655980; cv=none; b=r3w70uvhdg+SqddsReFYiORmly9xP9+3dSBP6j6w/uNIKbjXOJ4qavW4Jy/zLyu9Qv2abo27EXuVCqkIJWb7dnDCrjI2vSG8m9fw3J/M/M9LZiokSelWtlHwxbY4eaCaiJS8quMmptH/fKxjE8RO4sPM22aZYGIBVJ6UWBOacco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724655980; c=relaxed/simple;
	bh=XJ24hS+/5/sRA+GM1/4DyssOfC0LuvLF7ukiyeLO+5I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DTFWpMuHSuy+VbQ37ILiAQ3Kj4fYM9WuyaYeaeXQXjyu7OKSbGMtFWilOaanXDUGfD1NrGIcqxutLUOHxl8oNOZEPrQwv2SAnCDLXkP1iuQAtPHzrTE35+N2OXH6LuZr4sIh4LPuSDQcM/+jQem5/9DVShEINpTkWijQcqW3By8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4WshXj5pynz4f3l23
	for <bpf@vger.kernel.org>; Mon, 26 Aug 2024 15:05:57 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 2C4AB1A018D
	for <bpf@vger.kernel.org>; Mon, 26 Aug 2024 15:06:13 +0800 (CST)
Received: from k01.huawei.com (unknown [10.67.174.197])
	by APP2 (Coremail) with SMTP id Syh0CgAH8L5jKcxmTz_5Cg--.20237S3;
	Mon, 26 Aug 2024 15:06:13 +0800 (CST)
From: Xu Kuohai <xukuohai@huaweicloud.com>
To: bpf@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Puranjay Mohan <puranjay@kernel.org>,
	Leon Hwang <hffilwlqm@gmail.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Subject: [PATCH bpf-next 1/2] bpf, arm64: Get rid of fpb
Date: Mon, 26 Aug 2024 15:16:23 +0800
Message-Id: <20240826071624.350108-2-xukuohai@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240826071624.350108-1-xukuohai@huaweicloud.com>
References: <20240826071624.350108-1-xukuohai@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgAH8L5jKcxmTz_5Cg--.20237S3
X-Coremail-Antispam: 1UD129KBjvJXoW3AFWrJry5XFyUXr1UZr4kCrg_yoWxKF4xpF
	sxK340krWfJay5XFWktrn7XF1Skws7C3W7KryY93ySyF9F9r15WF48KayIkFW3CryxAw47
	urWqvw1xCwnxJwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Kb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
	A2048vs2IY020Ec7CjxVAFwI0_JFI_Gr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr4
	1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK
	67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI
	8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAv
	wI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14
	v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUzGYLUUUUU
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

From: Xu Kuohai <xukuohai@huawei.com>

bpf prog accesses stack using BPF_FP as the base address and a negative
immediate number as offset. But arm64 ldr/str instructions only support
non-negative immediate number as offset. To simplify the jited result,
commit 5b3d19b9bd40 ("bpf, arm64: Adjust the offset of str/ldr(immediate)
to positive number") introduced FPB to represent the lowest stack address
that the bpf prog being jited may access, and with this address as the
baseline, it converts BPF_FP plus negative immediate offset number to FPB
plus non-negative immediate offset.

Considering that for a given bpf prog, the jited stack space is fixed
with A64_SP as the lowest address and BPF_FP as the highest address.
Thus we can get rid of FPB and converts BPF_FP plus negative immediate
offset to A64_SP plus non-negative immediate offset.

Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
---
 arch/arm64/net/bpf_jit_comp.c | 104 ++++------------------------------
 1 file changed, 11 insertions(+), 93 deletions(-)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index 59e05a7aea56..5c9039cf261d 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -28,7 +28,6 @@
 #define TMP_REG_2 (MAX_BPF_JIT_REG + 1)
 #define TCCNT_PTR (MAX_BPF_JIT_REG + 2)
 #define TMP_REG_3 (MAX_BPF_JIT_REG + 3)
-#define FP_BOTTOM (MAX_BPF_JIT_REG + 4)
 #define ARENA_VM_START (MAX_BPF_JIT_REG + 5)
 
 #define check_imm(bits, imm) do {				\
@@ -67,7 +66,6 @@ static const int bpf2a64[] = {
 	[TCCNT_PTR] = A64_R(26),
 	/* temporary register for blinding constants */
 	[BPF_REG_AX] = A64_R(9),
-	[FP_BOTTOM] = A64_R(27),
 	/* callee saved register for kern_vm_start address */
 	[ARENA_VM_START] = A64_R(28),
 };
@@ -81,7 +79,6 @@ struct jit_ctx {
 	__le32 *image;
 	__le32 *ro_image;
 	u32 stack_size;
-	int fpb_offset;
 	u64 user_vm_start;
 };
 
@@ -330,7 +327,6 @@ static int build_prologue(struct jit_ctx *ctx, bool ebpf_from_cbpf,
 	const u8 r8 = bpf2a64[BPF_REG_8];
 	const u8 r9 = bpf2a64[BPF_REG_9];
 	const u8 fp = bpf2a64[BPF_REG_FP];
-	const u8 fpb = bpf2a64[FP_BOTTOM];
 	const u8 arena_vm_base = bpf2a64[ARENA_VM_START];
 	const int idx0 = ctx->idx;
 	int cur_offset;
@@ -381,7 +377,7 @@ static int build_prologue(struct jit_ctx *ctx, bool ebpf_from_cbpf,
 		emit(A64_PUSH(r6, r7, A64_SP), ctx);
 		emit(A64_PUSH(r8, r9, A64_SP), ctx);
 		prepare_bpf_tail_call_cnt(ctx);
-		emit(A64_PUSH(fpb, A64_R(28), A64_SP), ctx);
+		emit(A64_PUSH(A64_R(27), A64_R(28), A64_SP), ctx);
 	} else {
 		/*
 		 * Exception callback receives FP of Main Program as third
@@ -427,8 +423,6 @@ static int build_prologue(struct jit_ctx *ctx, bool ebpf_from_cbpf,
 		emit(A64_PUSH(A64_R(23), A64_R(24), A64_SP), ctx);
 	}
 
-	emit(A64_SUB_I(1, fpb, fp, ctx->fpb_offset), ctx);
-
 	/* Stack must be multiples of 16B */
 	ctx->stack_size = round_up(prog->aux->stack_depth, 16);
 
@@ -745,7 +739,6 @@ static void build_epilogue(struct jit_ctx *ctx, bool is_exception_cb)
 	const u8 r9 = bpf2a64[BPF_REG_9];
 	const u8 fp = bpf2a64[BPF_REG_FP];
 	const u8 ptr = bpf2a64[TCCNT_PTR];
-	const u8 fpb = bpf2a64[FP_BOTTOM];
 
 	/* We're done with BPF stack */
 	emit(A64_ADD_I(1, A64_SP, A64_SP, ctx->stack_size), ctx);
@@ -760,7 +753,7 @@ static void build_epilogue(struct jit_ctx *ctx, bool is_exception_cb)
 		emit(A64_POP(A64_R(23), A64_R(24), A64_SP), ctx);
 
 	/* Restore x27 and x28 */
-	emit(A64_POP(fpb, A64_R(28), A64_SP), ctx);
+	emit(A64_POP(A64_R(27), A64_R(28), A64_SP), ctx);
 	/* Restore fs (x25) and x26 */
 	emit(A64_POP(ptr, fp, A64_SP), ctx);
 	emit(A64_POP(ptr, fp, A64_SP), ctx);
@@ -887,7 +880,6 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx,
 	const u8 tmp = bpf2a64[TMP_REG_1];
 	const u8 tmp2 = bpf2a64[TMP_REG_2];
 	const u8 fp = bpf2a64[BPF_REG_FP];
-	const u8 fpb = bpf2a64[FP_BOTTOM];
 	const u8 arena_vm_base = bpf2a64[ARENA_VM_START];
 	const s16 off = insn->off;
 	const s32 imm = insn->imm;
@@ -1339,9 +1331,9 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx,
 			emit(A64_ADD(1, tmp2, src, arena_vm_base), ctx);
 			src = tmp2;
 		}
-		if (ctx->fpb_offset > 0 && src == fp && BPF_MODE(insn->code) != BPF_PROBE_MEM32) {
-			src_adj = fpb;
-			off_adj = off + ctx->fpb_offset;
+		if (src == fp) {
+			src_adj = A64_SP;
+			off_adj = off + ctx->stack_size;
 		} else {
 			src_adj = src;
 			off_adj = off;
@@ -1432,9 +1424,9 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx,
 			emit(A64_ADD(1, tmp2, dst, arena_vm_base), ctx);
 			dst = tmp2;
 		}
-		if (ctx->fpb_offset > 0 && dst == fp && BPF_MODE(insn->code) != BPF_PROBE_MEM32) {
-			dst_adj = fpb;
-			off_adj = off + ctx->fpb_offset;
+		if (dst == fp) {
+			dst_adj = A64_SP;
+			off_adj = off + ctx->stack_size;
 		} else {
 			dst_adj = dst;
 			off_adj = off;
@@ -1494,9 +1486,9 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx,
 			emit(A64_ADD(1, tmp2, dst, arena_vm_base), ctx);
 			dst = tmp2;
 		}
-		if (ctx->fpb_offset > 0 && dst == fp && BPF_MODE(insn->code) != BPF_PROBE_MEM32) {
-			dst_adj = fpb;
-			off_adj = off + ctx->fpb_offset;
+		if (dst == fp) {
+			dst_adj = A64_SP;
+			off_adj = off + ctx->stack_size;
 		} else {
 			dst_adj = dst;
 			off_adj = off;
@@ -1565,79 +1557,6 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx,
 	return 0;
 }
 
-/*
- * Return 0 if FP may change at runtime, otherwise find the minimum negative
- * offset to FP, converts it to positive number, and align down to 8 bytes.
- */
-static int find_fpb_offset(struct bpf_prog *prog)
-{
-	int i;
-	int offset = 0;
-
-	for (i = 0; i < prog->len; i++) {
-		const struct bpf_insn *insn = &prog->insnsi[i];
-		const u8 class = BPF_CLASS(insn->code);
-		const u8 mode = BPF_MODE(insn->code);
-		const u8 src = insn->src_reg;
-		const u8 dst = insn->dst_reg;
-		const s32 imm = insn->imm;
-		const s16 off = insn->off;
-
-		switch (class) {
-		case BPF_STX:
-		case BPF_ST:
-			/* fp holds atomic operation result */
-			if (class == BPF_STX && mode == BPF_ATOMIC &&
-			    ((imm == BPF_XCHG ||
-			      imm == (BPF_FETCH | BPF_ADD) ||
-			      imm == (BPF_FETCH | BPF_AND) ||
-			      imm == (BPF_FETCH | BPF_XOR) ||
-			      imm == (BPF_FETCH | BPF_OR)) &&
-			     src == BPF_REG_FP))
-				return 0;
-
-			if (mode == BPF_MEM && dst == BPF_REG_FP &&
-			    off < offset)
-				offset = insn->off;
-			break;
-
-		case BPF_JMP32:
-		case BPF_JMP:
-			break;
-
-		case BPF_LDX:
-		case BPF_LD:
-			/* fp holds load result */
-			if (dst == BPF_REG_FP)
-				return 0;
-
-			if (class == BPF_LDX && mode == BPF_MEM &&
-			    src == BPF_REG_FP && off < offset)
-				offset = off;
-			break;
-
-		case BPF_ALU:
-		case BPF_ALU64:
-		default:
-			/* fp holds ALU result */
-			if (dst == BPF_REG_FP)
-				return 0;
-		}
-	}
-
-	if (offset < 0) {
-		/*
-		 * safely be converted to a positive 'int', since insn->off
-		 * is 's16'
-		 */
-		offset = -offset;
-		/* align down to 8 bytes */
-		offset = ALIGN_DOWN(offset, 8);
-	}
-
-	return offset;
-}
-
 static int build_body(struct jit_ctx *ctx, bool extra_pass)
 {
 	const struct bpf_prog *prog = ctx->prog;
@@ -1774,7 +1693,6 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 		goto out_off;
 	}
 
-	ctx.fpb_offset = find_fpb_offset(prog);
 	ctx.user_vm_start = bpf_arena_get_user_vm_start(prog->aux->arena);
 
 	/*
-- 
2.43.0


