Return-Path: <bpf+bounces-27248-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DE478AB50E
	for <lists+bpf@lfdr.de>; Fri, 19 Apr 2024 20:28:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1ADA1C20BDD
	for <lists+bpf@lfdr.de>; Fri, 19 Apr 2024 18:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7115213C3E4;
	Fri, 19 Apr 2024 18:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IeBUOy+4"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2E81E502;
	Fri, 19 Apr 2024 18:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713551318; cv=none; b=nQDzu4FLHnPui/KZnCnHW0GbVa8PA5yEnq5kzMN+CoCFNqxGRgP1SwUhjsfqMY4FuSjGN+oo66qgVZ25AKKbpG+gjdzogg/2C81rn5KNvDNaIIyyIdSt/c0H/3UDXFNsId3qnucjGnebCnzb45KENGd1FRIsKc2p5QlgEb73iWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713551318; c=relaxed/simple;
	bh=rjKt7/bK+OTh70LlxH9GB1NsHBNG7yoeVAoY/Hx21I4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IitI32YdgkQdOEsX1yaYz6eyAp/YXXDVILtoOA2vTyY9peoE4df3lsdDcyzS5wLQMrltoDqLwqlhI13tKAJLV7YUBMuzGmLkxmTfoAXsFD/KeS8WgVVQZ8X7oP4gCXgnKiSOVAmed9TJdB7vaopk/xiwYOuPaKRn5SptdMzJMLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IeBUOy+4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24272C072AA;
	Fri, 19 Apr 2024 18:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713551317;
	bh=rjKt7/bK+OTh70LlxH9GB1NsHBNG7yoeVAoY/Hx21I4=;
	h=From:To:Cc:Subject:Date:From;
	b=IeBUOy+4lRWwfIQZfMjMs5aIrgyK+N7ngNwbGDBIFSxAGMsB+wb2nWOnXAh2vH1bO
	 8gEH9NoezUM6GJvhb0LjbF3uMsKhgRrm8Rv3ppkWlT/eP8RI2DaSVZZyx/YZXQoyXz
	 a/KXy+iGL/8kP05UJbWOZliH+q5CbP1bjvAA6RGkYpLPh77qx/iMWFQwrnb2ZiekhM
	 7u8rBoqEPFLQ3LRrJOGYQKwVtWzbX4qeLBlKr0VZxk+f8TffudxLpvoLlqaND96dHP
	 rlnDgNOzW/OlCJB6hU4ObQqzE0D0GzNiEoLx1ZgkDibk/MnniHK35eDFj5oH1YY9XA
	 TLZm1C6/2VznQ==
From: Puranjay Mohan <puranjay@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	bpf@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: puranjay12@gmail.com
Subject: [PATCH bpf] arm32, bpf: reimplement sign-extension mov instruction
Date: Fri, 19 Apr 2024 18:28:32 +0000
Message-Id: <20240419182832.27707-1-puranjay@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current implementation of the mov instruction with sign extension
has the following problems:

  1. It clobbers the source register if it is not stacked because it
     sign extends the source and then moves it to the destination.
  2. If the dst_reg is stacked, the current code doesn't write the value
     back in case of 64-bit mov.
  3. There is room for improvement by emitting fewer instructions.

The steps for fixing this and the instructions emitted by the JIT are
explained below with examples in all combinations:

Case A: offset == 32:
=====================
  Case A.1: src and dst are stacked registers:
  --------------------------------------------
    1. Load src_lo into tmp_lo
    2. Store tmp_lo into dst_lo
    3. Sign extend tmp_lo into tmp_hi
    4. Store tmp_hi to dst_hi

    Example: r3 = (s32)r3
	r3 is a stacked register

	ldr     r6, [r11, #-16]	// Load r3_lo into tmp_lo
	// str to dst_lo is not emitted because src_lo == dst_lo
	asr     r7, r6, #31	// Sign extend tmp_lo into tmp_hi
	str     r7, [r11, #-12] // Store tmp_hi into r3_hi

  Case A.2: src is stacked but dst is not:
  ----------------------------------------
    1. Load src_lo into dst_lo
    2. Sign extend dst_lo into dst_hi

    Example: r6 = (s32)r3
	r6 maps to {ARM_R5, ARM_R4} and r3 is stacked

	ldr     r4, [r11, #-16] // Load r3_lo into r6_lo
	asr     r5, r4, #31	// Sign extend r6_lo into r6_hi

  Case A.3: src is not stacked but dst is stacked:
  ------------------------------------------------
    1. Store src_lo into dst_lo
    2. Sign extend src_lo into tmp_hi
    3. Store tmp_hi to dst_hi

    Example: r3 = (s32)r6
	r3 is stacked and r6 maps to {ARM_R5, ARM_R4}

	str     r4, [r11, #-16] // Store r6_lo to r3_lo
	asr     r7, r4, #31	// Sign extend r6_lo into tmp_hi
	str     r7, [r11, #-12]	// Store tmp_hi to dest_hi

  Case A.4: Both src and dst are not stacked:
  -------------------------------------------
    1. Mov src_lo into dst_lo
    2. Sign extend src_lo into dst_hi

    Example: (bf) r6 = (s32)r6
	r6 maps to {ARM_R5, ARM_R4}

	// Mov not emitted because dst == src
	asr     r5, r4, #31 // Sign extend r6_lo into r6_hi

Case B: offset != 32:
=====================
  Case B.1: src and dst are stacked registers:
  --------------------------------------------
    1. Load src_lo into tmp_lo
    2. Sign extend tmp_lo according to offset.
    3. Store tmp_lo into dst_lo
    4. Sign extend tmp_lo into tmp_hi
    5. Store tmp_hi to dst_hi

    Example: r9 = (s8)r3
	r9 and r3 are both stacked registers

	ldr     r6, [r11, #-16] // Load r3_lo into tmp_lo
	lsl     r6, r6, #24	// Sign extend tmp_lo
	asr     r6, r6, #24	// ..
	str     r6, [r11, #-56] // Store tmp_lo to r9_lo
	asr     r7, r6, #31	// Sign extend tmp_lo to tmp_hi
	str     r7, [r11, #-52] // Store tmp_hi to r9_hi

  Case B.2: src is stacked but dst is not:
  ----------------------------------------
    1. Load src_lo into dst_lo
    2. Sign extend dst_lo according to offset.
    3. Sign extend tmp_lo into dst_hi

    Example: r6 = (s8)r3
	r6 maps to {ARM_R5, ARM_R4} and r3 is stacked

	ldr     r4, [r11, #-16] // Load r3_lo to r6_lo
	lsl     r4, r4, #24	// Sign extend r6_lo
	asr     r4, r4, #24	// ..
	asr     r5, r4, #31	// Sign extend r6_lo into r6_hi

  Case B.3: src is not stacked but dst is stacked:
  ------------------------------------------------
    1. Sign extend src_lo into tmp_lo according to offset.
    2. Store tmp_lo into dst_lo.
    3. Sign extend src_lo into tmp_hi.
    4. Store tmp_hi to dst_hi.

    Example: r3 = (s8)r1
	r3 is stacked and r1 maps to {ARM_R3, ARM_R2}

	lsl     r6, r2, #24 	// Sign extend r1_lo to tmp_lo
	asr     r6, r6, #24	// ..
	str     r6, [r11, #-16] // Store tmp_lo to r3_lo
	asr     r7, r6, #31	// Sign extend tmp_lo to tmp_hi
	str     r7, [r11, #-12] // Store tmp_hi to r3_hi

  Case B.4: Both src and dst are not stacked:
  -------------------------------------------
    1. Sign extend src_lo into dst_lo according to offset.
    2. Sign extend dst_lo into dst_hi.

    Example: r6 = (s8)r1
	r6 maps to {ARM_R5, ARM_R4} and r1 maps to {ARM_R3, ARM_R2}

	lsl     r4, r2, #24	// Sign extend r1_lo to r6_lo
	asr     r4, r4, #24	// ..
	asr     r5, r4, #31	// Sign extend r6_lo to r6_hi

Fixes: fc832653fa0d ("arm32, bpf: add support for sign-extension mov instruction")
Reported-by: syzbot+186522670e6722692d86@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/000000000000e9a8d80615163f2a@google.com/
Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 arch/arm/net/bpf_jit_32.c | 56 ++++++++++++++++++++++++++++++---------
 1 file changed, 43 insertions(+), 13 deletions(-)

diff --git a/arch/arm/net/bpf_jit_32.c b/arch/arm/net/bpf_jit_32.c
index 1d672457d02f..72b5cd697f5d 100644
--- a/arch/arm/net/bpf_jit_32.c
+++ b/arch/arm/net/bpf_jit_32.c
@@ -871,16 +871,11 @@ static inline void emit_a32_alu_r64(const bool is64, const s8 dst[],
 }
 
 /* dst = src (4 bytes)*/
-static inline void emit_a32_mov_r(const s8 dst, const s8 src, const u8 off,
-				  struct jit_ctx *ctx) {
+static inline void emit_a32_mov_r(const s8 dst, const s8 src, struct jit_ctx *ctx) {
 	const s8 *tmp = bpf2a32[TMP_REG_1];
 	s8 rt;
 
 	rt = arm_bpf_get_reg32(src, tmp[0], ctx);
-	if (off && off != 32) {
-		emit(ARM_LSL_I(rt, rt, 32 - off), ctx);
-		emit(ARM_ASR_I(rt, rt, 32 - off), ctx);
-	}
 	arm_bpf_put_reg32(dst, rt, ctx);
 }
 
@@ -889,15 +884,15 @@ static inline void emit_a32_mov_r64(const bool is64, const s8 dst[],
 				  const s8 src[],
 				  struct jit_ctx *ctx) {
 	if (!is64) {
-		emit_a32_mov_r(dst_lo, src_lo, 0, ctx);
+		emit_a32_mov_r(dst_lo, src_lo, ctx);
 		if (!ctx->prog->aux->verifier_zext)
 			/* Zero out high 4 bytes */
 			emit_a32_mov_i(dst_hi, 0, ctx);
 	} else if (__LINUX_ARM_ARCH__ < 6 &&
 		   ctx->cpu_architecture < CPU_ARCH_ARMv5TE) {
 		/* complete 8 byte move */
-		emit_a32_mov_r(dst_lo, src_lo, 0, ctx);
-		emit_a32_mov_r(dst_hi, src_hi, 0, ctx);
+		emit_a32_mov_r(dst_lo, src_lo, ctx);
+		emit_a32_mov_r(dst_hi, src_hi, ctx);
 	} else if (is_stacked(src_lo) && is_stacked(dst_lo)) {
 		const u8 *tmp = bpf2a32[TMP_REG_1];
 
@@ -917,17 +912,52 @@ static inline void emit_a32_mov_r64(const bool is64, const s8 dst[],
 static inline void emit_a32_movsx_r64(const bool is64, const u8 off, const s8 dst[], const s8 src[],
 				      struct jit_ctx *ctx) {
 	const s8 *tmp = bpf2a32[TMP_REG_1];
-	const s8 *rt;
+	s8 rs;
+	s8 rd;
 
-	rt = arm_bpf_get_reg64(dst, tmp, ctx);
+	if (is_stacked(dst_lo))
+		rd = tmp[1];
+	else
+		rd = dst_lo;
+	rs = arm_bpf_get_reg32(src_lo, rd, ctx);
+	/* rs may be one of src[1], dst[1], or tmp[1] */
+
+	/* Sign extend rs if needed. If off == 32, lower 32-bits of src are moved to dst and sign
+	 * extension only happens in the upper 64 bits.
+	 */
+	if (off != 32) {
+		/* Sign extend rs into rd */
+		emit(ARM_LSL_I(rd, rs, 32 - off), ctx);
+		emit(ARM_ASR_I(rd, rd, 32 - off), ctx);
+	} else {
+		rd = rs;
+	}
+
+	/* Write rd to dst_lo
+	 *
+	 * Optimization:
+	 * Assume:
+	 * 1. dst == src and stacked.
+	 * 2. off == 32
+	 *
+	 * In this case src_lo was loaded into rd(tmp[1]) but rd was not sign extended as off==32.
+	 * So, we don't need to write rd back to dst_lo as they have the same value.
+	 * This saves us one str instruction.
+	 */
+	if (dst_lo != src_lo || off != 32)
+		arm_bpf_put_reg32(dst_lo, rd, ctx);
 
-	emit_a32_mov_r(dst_lo, src_lo, off, ctx);
 	if (!is64) {
 		if (!ctx->prog->aux->verifier_zext)
 			/* Zero out high 4 bytes */
 			emit_a32_mov_i(dst_hi, 0, ctx);
 	} else {
-		emit(ARM_ASR_I(rt[0], rt[1], 31), ctx);
+		if (is_stacked(dst_hi)) {
+			emit(ARM_ASR_I(tmp[0], rd, 31), ctx);
+			arm_bpf_put_reg32(dst_hi, tmp[0], ctx);
+		} else {
+			emit(ARM_ASR_I(dst_hi, rd, 31), ctx);
+		}
 	}
 }
 
-- 
2.40.1


