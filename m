Return-Path: <bpf+bounces-61947-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00314AEEFEB
	for <lists+bpf@lfdr.de>; Tue,  1 Jul 2025 09:41:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D01A63E1C55
	for <lists+bpf@lfdr.de>; Tue,  1 Jul 2025 07:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 502D125D8E8;
	Tue,  1 Jul 2025 07:41:42 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C34225C6EC
	for <bpf@vger.kernel.org>; Tue,  1 Jul 2025 07:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751355702; cv=none; b=KVTvC2dozRyu+iFgefEE+kk2WQqdGfOon2ktGY4FW0VTDclQXkYo7qfxYdZrJ9PJ5w0zml+gHz/m0DxRpfi31UJqQQk/73xuFRVHNRIIkIfMLXNxxO7kRB7q5agp8u+7x99HBkVgz5AFPv+7FKo9ohbK0TqPEijSUUMCeJmDI0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751355702; c=relaxed/simple;
	bh=/icwVoL+PPlRBVD4J9KDnX6kDbFmfkyVGQx0PswyE98=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mZQ0NcVKmKSnu4kgLGG/Klgl7EvjLCPqZ8djcBi25A/LjMawlQk821UzxuQeoB5hs6/KiMdkZ6C37k2nKiLhV9/wuAPdKBhXxabvspyygHvJTdx2OXKaqWrjznkmog2ztMTfj0g4dyz+G2zPj2aFca+iVzvXxJ8BMnM35epwHJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: ce425c24564e11f0b29709d653e92f7d-20250701
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:36cb74c5-8989-4cd4-a39f-5d9b73412cf4,IP:15,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:0
X-CID-INFO: VERSION:1.1.45,REQID:36cb74c5-8989-4cd4-a39f-5d9b73412cf4,IP:15,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:b1216b2c1c2ed01883b7a66e9d5945aa,BulkI
	D:250701154135SNLJKL50,BulkQuantity:0,Recheck:0,SF:17|19|24|44|66|78|81|82
	|102,TC:nil,Content:0|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:ni
	l,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:
	0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,TF_CID_SPAM_SNR
X-UUID: ce425c24564e11f0b29709d653e92f7d-20250701
X-User: jianghaoran@kylinos.cn
Received: from localhost.localdomain [(39.156.73.13)] by mailgw.kylinos.cn
	(envelope-from <jianghaoran@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 160592336; Tue, 01 Jul 2025 15:41:31 +0800
From: Haoran Jiang <jianghaoran@kylinos.cn>
To: loongarch@lists.linux.dev
Cc: bpf@vger.kernel.org,
	kernel@xen0n.name,
	chenhuacai@kernel.org,
	hengqi.chen@gmail.com,
	yangtiezhu@loongson.cn,
	jolsa@kernel.org,
	haoluo@google.com,
	sdf@fomichev.me,
	kpsingh@kernel.org,
	john.fastabend@gmail.com,
	yonghong.song@linux.dev,
	song@kernel.org,
	eddyz87@gmail.com,
	martin.lau@linux.dev,
	andrii@kernel.org,
	daniel@iogearbox.net,
	ast@kernel.org
Subject: [PATCH 2/2] LoongArch: BPF: Fix tailcall hierarchy
Date: Tue,  1 Jul 2025 15:41:10 +0800
Message-Id: <20250701074110.525363-3-jianghaoran@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250701074110.525363-1-jianghaoran@kylinos.cn>
References: <20250701074110.525363-1-jianghaoran@kylinos.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

In specific use cases combining tailcalls and BPF-to-BPF calls，
MAX_TAIL_CALL_CNT won't work because of missing tail_call_cnt
back-propagation from callee to caller。This patch fixes this
tailcall issue caused by abusing the tailcall in bpf2bpf feature
on LoongArch like the way of "bpf, x64: Fix tailcall hierarchy".

push tail_call_cnt_ptr and tail_call_cnt into the stack,
tail_call_cnt_ptr is passed between tailcall and bpf2bpf,
uses tail_call_cnt_ptr to increment tail_call_cnt.

Signed-off-by: Haoran Jiang <jianghaoran@kylinos.cn>
---
 arch/loongarch/net/bpf_jit.c | 112 ++++++++++++++++++++++-------------
 1 file changed, 71 insertions(+), 41 deletions(-)

diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
index d85490e7de89..ba409e598b94 100644
--- a/arch/loongarch/net/bpf_jit.c
+++ b/arch/loongarch/net/bpf_jit.c
@@ -12,6 +12,9 @@
 #define SAVE_RA		BIT(0)
 #define SAVE_TCC	BIT(1)
 
+#define BPF_TAIL_CALL_CNT_PTR_STACK_OFF(stack) (round_up(stack, 16) - 80)
+
+
 static const int regmap[] = {
 	/* return value from in-kernel function, and exit value for eBPF program */
 	[BPF_REG_0] = LOONGARCH_GPR_A5,
@@ -32,32 +35,37 @@ static const int regmap[] = {
 	[BPF_REG_AX] = LOONGARCH_GPR_T0,
 };
 
-static void mark_call(struct jit_ctx *ctx)
+static void prepare_bpf_tail_call_cnt(struct jit_ctx *ctx, int *store_offset)
 {
-	ctx->flags |= SAVE_RA;
-}
+	const struct bpf_prog *prog = ctx->prog;
+	const bool is_main_prog = !bpf_is_subprog(prog);
 
-static void mark_tail_call(struct jit_ctx *ctx)
-{
-	ctx->flags |= SAVE_TCC;
-}
+	if (is_main_prog) {
+		emit_insn(ctx, addid, LOONGARCH_GPR_T3, LOONGARCH_GPR_ZERO, MAX_TAIL_CALL_CNT);
+		*store_offset -= sizeof(long);
 
-static bool seen_call(struct jit_ctx *ctx)
-{
-	return (ctx->flags & SAVE_RA);
-}
+		emit_tailcall_jmp(ctx, BPF_JGT, REG_TCC, LOONGARCH_GPR_T3, 4);
 
-static bool seen_tail_call(struct jit_ctx *ctx)
-{
-	return (ctx->flags & SAVE_TCC);
-}
+		/* If REG_TCC < MAX_TAIL_CALL_CNT, push REG_TCC into stack */
+		emit_insn(ctx, std, REG_TCC, LOONGARCH_GPR_SP, *store_offset);
 
-static u8 tail_call_reg(struct jit_ctx *ctx)
-{
-	if (seen_call(ctx))
-		return TCC_SAVED;
+		/* Calculate the pointer to REG_TCC in the stack and assign it to REG_TCC */
+		emit_insn(ctx, addid, REG_TCC, LOONGARCH_GPR_SP, *store_offset);
+
+		emit_uncond_jmp(ctx, 2);
+
+		emit_insn(ctx, std, REG_TCC, LOONGARCH_GPR_SP, *store_offset);
 
-	return REG_TCC;
+		*store_offset -= sizeof(long);
+		emit_insn(ctx, std, REG_TCC, LOONGARCH_GPR_SP, *store_offset);
+
+	} else {
+		*store_offset -= sizeof(long);
+		emit_insn(ctx, std, REG_TCC, LOONGARCH_GPR_SP, *store_offset);
+
+		*store_offset -= sizeof(long);
+		emit_insn(ctx, std, REG_TCC, LOONGARCH_GPR_SP, *store_offset);
+	}
 }
 
 /*
@@ -80,6 +88,10 @@ static u8 tail_call_reg(struct jit_ctx *ctx)
  *                            |           $s4           |
  *                            +-------------------------+
  *                            |           $s5           |
+ *                            +-------------------------+
+ *                            |          reg_tcc        |
+ *                            +-------------------------+
+ *                            |          reg_tcc_ptr    |
  *                            +-------------------------+ <--BPF_REG_FP
  *                            |  prog->aux->stack_depth |
  *                            |        (optional)       |
@@ -89,21 +101,24 @@ static u8 tail_call_reg(struct jit_ctx *ctx)
 static void build_prologue(struct jit_ctx *ctx)
 {
 	int stack_adjust = 0, store_offset, bpf_stack_adjust;
+	const struct bpf_prog *prog = ctx->prog;
+	const bool is_main_prog = !bpf_is_subprog(prog);
 
 	bpf_stack_adjust = round_up(ctx->prog->aux->stack_depth, 16);
 
-	/* To store ra, fp, s0, s1, s2, s3, s4 and s5. */
-	stack_adjust += sizeof(long) * 8;
+	/* To store ra, fp, s0, s1, s2, s3, s4, s5, reg_tcc and reg_tcc_ptr */
+	stack_adjust += sizeof(long) * 10;
 
 	stack_adjust = round_up(stack_adjust, 16);
 	stack_adjust += bpf_stack_adjust;
 
 	/*
-	 * First instruction initializes the tail call count (TCC).
-	 * On tail call we skip this instruction, and the TCC is
+	 * First instruction initializes the tail call count (TCC) register
+	 * to zero. On tail call we skip this instruction, and the TCC is
 	 * passed in REG_TCC from the caller.
 	 */
-	emit_insn(ctx, addid, REG_TCC, LOONGARCH_GPR_ZERO, MAX_TAIL_CALL_CNT);
+	if (is_main_prog)
+		emit_insn(ctx, addid, REG_TCC, LOONGARCH_GPR_ZERO, 0);
 
 	emit_insn(ctx, addid, LOONGARCH_GPR_SP, LOONGARCH_GPR_SP, -stack_adjust);
 
@@ -131,20 +146,13 @@ static void build_prologue(struct jit_ctx *ctx)
 	store_offset -= sizeof(long);
 	emit_insn(ctx, std, LOONGARCH_GPR_S5, LOONGARCH_GPR_SP, store_offset);
 
+	prepare_bpf_tail_call_cnt(ctx, &store_offset);
+
 	emit_insn(ctx, addid, LOONGARCH_GPR_FP, LOONGARCH_GPR_SP, stack_adjust);
 
 	if (bpf_stack_adjust)
 		emit_insn(ctx, addid, regmap[BPF_REG_FP], LOONGARCH_GPR_SP, bpf_stack_adjust);
 
-	/*
-	 * Program contains calls and tail calls, so REG_TCC need
-	 * to be saved across calls.
-	 */
-	if (seen_tail_call(ctx) && seen_call(ctx))
-		move_reg(ctx, TCC_SAVED, REG_TCC);
-	else
-		emit_insn(ctx, nop);
-
 	ctx->stack_size = stack_adjust;
 }
 
@@ -177,6 +185,17 @@ static void __build_epilogue(struct jit_ctx *ctx, bool is_tail_call)
 	load_offset -= sizeof(long);
 	emit_insn(ctx, ldd, LOONGARCH_GPR_S5, LOONGARCH_GPR_SP, load_offset);
 
+	/*
+	 *  When push into the stack, follow the order of tcc then tcc_ptr.
+	 *  When pop from the stack, first pop tcc_ptr followed by tcc
+	 */
+	load_offset -= 2*sizeof(long);
+	emit_insn(ctx, ldd, REG_TCC, LOONGARCH_GPR_SP, load_offset);
+
+	/* pop tcc_ptr to REG_TCC */
+	load_offset += sizeof(long);
+	emit_insn(ctx, ldd, REG_TCC, LOONGARCH_GPR_SP, load_offset);
+
 	emit_insn(ctx, addid, LOONGARCH_GPR_SP, LOONGARCH_GPR_SP, stack_adjust);
 
 	if (!is_tail_call) {
@@ -211,7 +230,8 @@ bool bpf_jit_supports_far_kfunc_call(void)
 static int emit_bpf_tail_call(int insn, struct jit_ctx *ctx)
 {
 	int off;
-	u8 tcc = tail_call_reg(ctx);
+	int tcc_ptr_off = BPF_TAIL_CALL_CNT_PTR_STACK_OFF(ctx->stack_size);
+
 	u8 a1 = LOONGARCH_GPR_A1;
 	u8 a2 = LOONGARCH_GPR_A2;
 	u8 t1 = LOONGARCH_GPR_T1;
@@ -239,12 +259,17 @@ static int emit_bpf_tail_call(int insn, struct jit_ctx *ctx)
 		goto toofar;
 
 	/*
-	 * if (--TCC < 0)
-	 *	 goto out;
+	 * if ((*tcc_ptr)++ >= MAX_TAIL_CALL_CNT)
+	 *      goto out;
 	 */
-	emit_insn(ctx, addid, REG_TCC, tcc, -1);
+	emit_insn(ctx, ldd, REG_TCC, LOONGARCH_GPR_SP, tcc_ptr_off);
+	emit_insn(ctx, ldd, t3, REG_TCC, 0);
+	emit_insn(ctx, addid, t3, t3, 1);
+	emit_insn(ctx, std, t3, REG_TCC, 0);
+	emit_insn(ctx, addid, t2, LOONGARCH_GPR_ZERO, MAX_TAIL_CALL_CNT);
+
 	jmp_offset = tc_ninsn - (ctx->idx - idx0);
-	if (emit_tailcall_jmp(ctx, BPF_JSLT, REG_TCC, LOONGARCH_GPR_ZERO, jmp_offset) < 0)
+	if (emit_tailcall_jmp(ctx, BPF_JSGT, t3, t2, jmp_offset) < 0)
 		goto toofar;
 
 	/*
@@ -464,6 +489,7 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
 	const s16 off = insn->off;
 	const s32 imm = insn->imm;
 	const bool is32 = BPF_CLASS(insn->code) == BPF_ALU || BPF_CLASS(insn->code) == BPF_JMP32;
+	int tcc_ptr_off;
 
 	switch (code) {
 	/* dst = src */
@@ -890,12 +916,17 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
 
 	/* function call */
 	case BPF_JMP | BPF_CALL:
-		mark_call(ctx);
 		ret = bpf_jit_get_func_addr(ctx->prog, insn, extra_pass,
 					    &func_addr, &func_addr_fixed);
 		if (ret < 0)
 			return ret;
 
+		if (insn->src_reg == BPF_PSEUDO_CALL) {
+			tcc_ptr_off = BPF_TAIL_CALL_CNT_PTR_STACK_OFF(ctx->stack_size);
+			emit_insn(ctx, ldd, REG_TCC, LOONGARCH_GPR_SP, tcc_ptr_off);
+		}
+
+
 		move_addr(ctx, t1, func_addr);
 		emit_insn(ctx, jirl, LOONGARCH_GPR_RA, t1, 0);
 
@@ -906,7 +937,6 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
 
 	/* tail call */
 	case BPF_JMP | BPF_TAIL_CALL:
-		mark_tail_call(ctx);
 		if (emit_bpf_tail_call(i, ctx) < 0)
 			return -EINVAL;
 		break;
-- 
2.43.0


