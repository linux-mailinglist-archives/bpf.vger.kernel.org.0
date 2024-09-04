Return-Path: <bpf+bounces-38908-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0721996C603
	for <lists+bpf@lfdr.de>; Wed,  4 Sep 2024 20:09:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E85B1F23D1F
	for <lists+bpf@lfdr.de>; Wed,  4 Sep 2024 18:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D47561E2006;
	Wed,  4 Sep 2024 18:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pT4owfc5"
X-Original-To: bpf@vger.kernel.org
Received: from out-184.mta1.migadu.com (out-184.mta1.migadu.com [95.215.58.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E8311E1A17
	for <bpf@vger.kernel.org>; Wed,  4 Sep 2024 18:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725473342; cv=none; b=c1Xyq9i7NC58Hrmgw5OVtO8tiwz1l1JrRIBJscahlu3wxXSOx4JtPyY6GzwyvP3+cfwicL0WB79IW5+9FSVp5R/wAK2va3Ve+HwWc4ZAuZ2LF+UJPq0KUm8kfvUc7dmtzmrh9ufE+GtOjbJUjk2MeyYdqbZlGkTG/AM+dcgqA2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725473342; c=relaxed/simple;
	bh=2nyYQ1UC5v46Q3Y1ubNDKZbB3yv7vpZpdgIMbwwWF9U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YY9bah8gWiPtEgB4Gt93h8PwLDSVIIBOYf1t+CmgJeuD77ejvMD3SBaa7ZFlblON/IT+k9UYzZff5LJrLjd6ZZPQteWDg26eQimrRH/Cq/3PPDoxL59XImLXPTWY+TIV3oZEkL2a96Mx0vcqiddIo0RUkAbHrFPEBUzPWHB7kXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pT4owfc5; arc=none smtp.client-ip=95.215.58.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725473338;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mKjDdEVXma0ICeMhmf/81Zn4eTJz2EtMYKAp+d4q6SI=;
	b=pT4owfc57Y5zxk4Vv1SKxqOC8Le/pJ1odpK74hjJrP+o5egAUL/2oUPobegaqsh/8ocrfN
	svjUYSY66Q0ipJWxAwGudVG0VIOxlOZlPZuMaahUQhs1VIbJ/QUylVuuI17kyIQ53QnPee
	qqZ/ImKHWxuwes6pPOn4UPhRlOqan34=
From: Martin KaFai Lau <martin.lau@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@meta.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next 1/2] bpf: Remove the insn_buf array stack usage from the inline_bpf_loop()
Date: Wed,  4 Sep 2024 11:08:44 -0700
Message-ID: <20240904180847.56947-2-martin.lau@linux.dev>
In-Reply-To: <20240904180847.56947-1-martin.lau@linux.dev>
References: <20240904180847.56947-1-martin.lau@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Martin KaFai Lau <martin.lau@kernel.org>

This patch removes the insn_buf array stack usage from the
inline_bpf_loop(). Instead, the env->insn_buf is used. The
usage in inline_bpf_loop() needs more than 16 insn, so the
INSN_BUF_SIZE needs to be increased from 16 to 32.
The compiler stack size warning on the verifier is gone
after this change.

Cc: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
---
 include/linux/bpf_verifier.h |  2 +-
 kernel/bpf/verifier.c        | 83 ++++++++++++++++++------------------
 2 files changed, 43 insertions(+), 42 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 2e20207315a9..8458632824a4 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -24,7 +24,7 @@
  */
 #define TMP_STR_BUF_LEN 320
 /* Patch buffer size */
-#define INSN_BUF_SIZE 16
+#define INSN_BUF_SIZE 32
 
 /* Liveness marks, used for registers and spilled-regs (in stack slots).
  * Read marks propagate upwards until they find a write mark; they record that
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 217eb0eafa2a..8bfb14d1eb7a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -21232,7 +21232,7 @@ static struct bpf_prog *inline_bpf_loop(struct bpf_verifier_env *env,
 					int position,
 					s32 stack_base,
 					u32 callback_subprogno,
-					u32 *cnt)
+					u32 *total_cnt)
 {
 	s32 r6_offset = stack_base + 0 * BPF_REG_SIZE;
 	s32 r7_offset = stack_base + 1 * BPF_REG_SIZE;
@@ -21241,55 +21241,56 @@ static struct bpf_prog *inline_bpf_loop(struct bpf_verifier_env *env,
 	int reg_loop_cnt = BPF_REG_7;
 	int reg_loop_ctx = BPF_REG_8;
 
+	struct bpf_insn *insn_buf = env->insn_buf;
 	struct bpf_prog *new_prog;
 	u32 callback_start;
 	u32 call_insn_offset;
 	s32 callback_offset;
+	u32 cnt = 0;
 
 	/* This represents an inlined version of bpf_iter.c:bpf_loop,
 	 * be careful to modify this code in sync.
 	 */
-	struct bpf_insn insn_buf[] = {
-		/* Return error and jump to the end of the patch if
-		 * expected number of iterations is too big.
-		 */
-		BPF_JMP_IMM(BPF_JLE, BPF_REG_1, BPF_MAX_LOOPS, 2),
-		BPF_MOV32_IMM(BPF_REG_0, -E2BIG),
-		BPF_JMP_IMM(BPF_JA, 0, 0, 16),
-		/* spill R6, R7, R8 to use these as loop vars */
-		BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_6, r6_offset),
-		BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_7, r7_offset),
-		BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_8, r8_offset),
-		/* initialize loop vars */
-		BPF_MOV64_REG(reg_loop_max, BPF_REG_1),
-		BPF_MOV32_IMM(reg_loop_cnt, 0),
-		BPF_MOV64_REG(reg_loop_ctx, BPF_REG_3),
-		/* loop header,
-		 * if reg_loop_cnt >= reg_loop_max skip the loop body
-		 */
-		BPF_JMP_REG(BPF_JGE, reg_loop_cnt, reg_loop_max, 5),
-		/* callback call,
-		 * correct callback offset would be set after patching
-		 */
-		BPF_MOV64_REG(BPF_REG_1, reg_loop_cnt),
-		BPF_MOV64_REG(BPF_REG_2, reg_loop_ctx),
-		BPF_CALL_REL(0),
-		/* increment loop counter */
-		BPF_ALU64_IMM(BPF_ADD, reg_loop_cnt, 1),
-		/* jump to loop header if callback returned 0 */
-		BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, -6),
-		/* return value of bpf_loop,
-		 * set R0 to the number of iterations
-		 */
-		BPF_MOV64_REG(BPF_REG_0, reg_loop_cnt),
-		/* restore original values of R6, R7, R8 */
-		BPF_LDX_MEM(BPF_DW, BPF_REG_6, BPF_REG_10, r6_offset),
-		BPF_LDX_MEM(BPF_DW, BPF_REG_7, BPF_REG_10, r7_offset),
-		BPF_LDX_MEM(BPF_DW, BPF_REG_8, BPF_REG_10, r8_offset),
-	};
 
-	*cnt = ARRAY_SIZE(insn_buf);
-	new_prog = bpf_patch_insn_data(env, position, insn_buf, *cnt);
+	/* Return error and jump to the end of the patch if
+	 * expected number of iterations is too big.
+	 */
+	insn_buf[cnt++] = BPF_JMP_IMM(BPF_JLE, BPF_REG_1, BPF_MAX_LOOPS, 2);
+	insn_buf[cnt++] = BPF_MOV32_IMM(BPF_REG_0, -E2BIG);
+	insn_buf[cnt++] = BPF_JMP_IMM(BPF_JA, 0, 0, 16);
+	/* spill R6, R7, R8 to use these as loop vars */
+	insn_buf[cnt++] = BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_6, r6_offset);
+	insn_buf[cnt++] = BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_7, r7_offset);
+	insn_buf[cnt++] = BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_8, r8_offset);
+	/* initialize loop vars */
+	insn_buf[cnt++] = BPF_MOV64_REG(reg_loop_max, BPF_REG_1);
+	insn_buf[cnt++] = BPF_MOV32_IMM(reg_loop_cnt, 0);
+	insn_buf[cnt++] = BPF_MOV64_REG(reg_loop_ctx, BPF_REG_3);
+	/* loop header,
+	 * if reg_loop_cnt >= reg_loop_max skip the loop body
+	 */
+	insn_buf[cnt++] = BPF_JMP_REG(BPF_JGE, reg_loop_cnt, reg_loop_max, 5);
+	/* callback call,
+	 * correct callback offset would be set after patching
+	 */
+	insn_buf[cnt++] = BPF_MOV64_REG(BPF_REG_1, reg_loop_cnt);
+	insn_buf[cnt++] = BPF_MOV64_REG(BPF_REG_2, reg_loop_ctx);
+	insn_buf[cnt++] = BPF_CALL_REL(0);
+	/* increment loop counter */
+	insn_buf[cnt++] = BPF_ALU64_IMM(BPF_ADD, reg_loop_cnt, 1);
+	/* jump to loop header if callback returned 0 */
+	insn_buf[cnt++] = BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, -6);
+	/* return value of bpf_loop,
+	 * set R0 to the number of iterations
+	 */
+	insn_buf[cnt++] = BPF_MOV64_REG(BPF_REG_0, reg_loop_cnt);
+	/* restore original values of R6, R7, R8 */
+	insn_buf[cnt++] = BPF_LDX_MEM(BPF_DW, BPF_REG_6, BPF_REG_10, r6_offset);
+	insn_buf[cnt++] = BPF_LDX_MEM(BPF_DW, BPF_REG_7, BPF_REG_10, r7_offset);
+	insn_buf[cnt++] = BPF_LDX_MEM(BPF_DW, BPF_REG_8, BPF_REG_10, r8_offset);
+
+	*total_cnt = cnt;
+	new_prog = bpf_patch_insn_data(env, position, insn_buf, cnt);
 	if (!new_prog)
 		return new_prog;
 
-- 
2.43.5


