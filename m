Return-Path: <bpf+bounces-64771-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59279B16CEB
	for <lists+bpf@lfdr.de>; Thu, 31 Jul 2025 09:51:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7ACD2170686
	for <lists+bpf@lfdr.de>; Thu, 31 Jul 2025 07:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20FD92BCF47;
	Thu, 31 Jul 2025 07:51:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5450B29CB56
	for <bpf@vger.kernel.org>; Thu, 31 Jul 2025 07:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753948281; cv=none; b=aeuz0maaMMc6IkzxschjHyKiCO2a8hh4B77LuOEj1pfi161CM/TJvKRNkw/C2PCQcRBXP3oj9ArmuzYV3ocrplZamh17ROaKPQEixomGk6YxEAk4ro2JTdMr4qr+OfeT9+gAEwgFmcf7J0XEdQhT8w1YF5WU106KT+t0PGaLqEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753948281; c=relaxed/simple;
	bh=9OKHa12OJDT+PQlvN3YXyRlrZ/PcOdM//YqDwU/Z0Xw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=trh8SrW8n6A6z/JNE3O91TO9v6JL46OTUJPnQQgXEej9FS5AgmHgKUawejPlQ6aTlLwrA4cqGABWXfv04l/N8Qx0x8MojiTalQGdmM8ZKTlWAyWkeed9Xunrhrnf0d8F40Meq21whD3Mv9TwuoRD2Vg96GD5uYgoDIB6tgEIGHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 2108eee06de311f0b29709d653e92f7d-20250731
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:ce3a34ce-8839-4a1f-9dbb-f747627a2f31,IP:15,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-40,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-25
X-CID-INFO: VERSION:1.1.45,REQID:ce3a34ce-8839-4a1f-9dbb-f747627a2f31,IP:15,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-40,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-25
X-CID-META: VersionHash:6493067,CLOUDID:3760d0552786e3aa676bef80d6d66123,BulkI
	D:2507311551143WOIS5EH,BulkQuantity:0,Recheck:0,SF:10|24|44|66|78|81|82|10
	2,TC:nil,Content:0|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,B
	EC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FSI
X-UUID: 2108eee06de311f0b29709d653e92f7d-20250731
X-User: jianghaoran@kylinos.cn
Received: from localhost.localdomain [(116.128.244.171)] by mailgw.kylinos.cn
	(envelope-from <jianghaoran@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1819822145; Thu, 31 Jul 2025 15:51:12 +0800
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
	ast@kernel.org,
	Geliang Tang <geliang@kernel.org>
Subject: [PATCH v5 2/2] LoongArch: BPF: Fix tailcall hierarchy
Date: Thu, 31 Jul 2025 15:50:46 +0800
Message-Id: <20250731075046.851694-3-jianghaoran@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250731075046.851694-1-jianghaoran@kylinos.cn>
References: <20250731075046.851694-1-jianghaoran@kylinos.cn>
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

Fixes: bb035ef0cc91 ("LoongArch: BPF: Support mixing bpf2bpf and tailcalls")
Fixes: 5dc615520c4d ("LoongArch: Add BPF JIT support")

Reviewed-by: Geliang Tang <geliang@kernel.org>
Reviewed-by: Hengqi Chen <hengqi.chen@gmail.com>
Signed-off-by: Haoran Jiang <jianghaoran@kylinos.cn>
---
 arch/loongarch/net/bpf_jit.c | 150 ++++++++++++++++++++++++-----------
 1 file changed, 104 insertions(+), 46 deletions(-)

diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
index 3f855d87eee3..e0274ae84651 100644
--- a/arch/loongarch/net/bpf_jit.c
+++ b/arch/loongarch/net/bpf_jit.c
@@ -17,10 +17,7 @@
 #define LOONGARCH_BPF_FENTRY_NBYTES (LOONGARCH_LONG_JUMP_NINSNS * 4)
 
 #define REG_TCC		LOONGARCH_GPR_A6
-#define TCC_SAVED	LOONGARCH_GPR_S5
-
-#define SAVE_RA		BIT(0)
-#define SAVE_TCC	BIT(1)
+#define BPF_TAIL_CALL_CNT_PTR_STACK_OFF(stack) (round_up(stack, 16) - 80)
 
 static const int regmap[] = {
 	/* return value from in-kernel function, and exit value for eBPF program */
@@ -42,32 +39,55 @@ static const int regmap[] = {
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
+		/*
+		 * LOONGARCH_GPR_T3 = MAX_TAIL_CALL_CNT
+		 * if (REG_TCC > T3 )
+		 *	std REG_TCC -> LOONGARCH_GPR_SP + store_offset
+		 * else
+		 *	std REG_TCC -> LOONGARCH_GPR_SP + store_offset
+		 *	REG_TCC = LOONGARCH_GPR_SP + store_offset
+		 *
+		 * std REG_TCC -> LOONGARCH_GPR_SP + store_offset
+		 *
+		 * The purpose of this code is to first push the TCC into stack,
+		 * and then push the address of TCC into stack.
+		 * In cases where bpf2bpf and tailcall are used in combination,
+		 * the value in REG_TCC may be a count or an address,
+		 * these two cases need to be judged and handled separately.
+		 */
+		emit_insn(ctx, addid, LOONGARCH_GPR_T3, LOONGARCH_GPR_ZERO, MAX_TAIL_CALL_CNT);
+		*store_offset -= sizeof(long);
 
-static bool seen_call(struct jit_ctx *ctx)
-{
-	return (ctx->flags & SAVE_RA);
-}
+		emit_cond_jmp(ctx, BPF_JGT, REG_TCC, LOONGARCH_GPR_T3, 4);
 
-static bool seen_tail_call(struct jit_ctx *ctx)
-{
-	return (ctx->flags & SAVE_TCC);
-}
+		/* If REG_TCC < MAX_TAIL_CALL_CNT, the value in REG_TCC is a count,
+		 * push TCC into stack
+		 */
+		emit_insn(ctx, std, REG_TCC, LOONGARCH_GPR_SP, *store_offset);
 
-static u8 tail_call_reg(struct jit_ctx *ctx)
-{
-	if (seen_call(ctx))
-		return TCC_SAVED;
+		/* Push the address of TCC into the REG_TCC */
+		emit_insn(ctx, addid, REG_TCC, LOONGARCH_GPR_SP, *store_offset);
+
+		emit_uncond_jmp(ctx, 2);
+
+		/* If REG_TCC > MAX_TAIL_CALL_CNT, the value in REG_TCC is an address,
+		 * push TCC_ptr into stack
+		 */
+		emit_insn(ctx, std, REG_TCC, LOONGARCH_GPR_SP, *store_offset);
+	} else {
+		*store_offset -= sizeof(long);
+		emit_insn(ctx, std, REG_TCC, LOONGARCH_GPR_SP, *store_offset);
+	}
 
-	return REG_TCC;
+	/*push TCC_ptr into stack*/
+	*store_offset -= sizeof(long);
+	emit_insn(ctx, std, REG_TCC, LOONGARCH_GPR_SP, *store_offset);
 }
 
 /*
@@ -90,6 +110,10 @@ static u8 tail_call_reg(struct jit_ctx *ctx)
  *                            |           $s4           |
  *                            +-------------------------+
  *                            |           $s5           |
+ *                            +-------------------------+
+ *                            |           tcc           |
+ *                            +-------------------------+
+ *                            |           tcc_ptr       |
  *                            +-------------------------+ <--BPF_REG_FP
  *                            |  prog->aux->stack_depth |
  *                            |        (optional)       |
@@ -100,12 +124,17 @@ static void build_prologue(struct jit_ctx *ctx)
 {
 	int i;
 	int stack_adjust = 0, store_offset, bpf_stack_adjust;
+	const struct bpf_prog *prog = ctx->prog;
+	const bool is_main_prog = !bpf_is_subprog(prog);
 
 	bpf_stack_adjust = round_up(ctx->prog->aux->stack_depth, 16);
 
-	/* To store ra, fp, s0, s1, s2, s3, s4 and s5. */
+	/* To store ra, fp, s0, s1, s2, s3, s4, s5 */
 	stack_adjust += sizeof(long) * 8;
 
+	/* To store tcc and tcc_ptr */
+	stack_adjust += sizeof(long) * 2;
+
 	stack_adjust = round_up(stack_adjust, 16);
 	stack_adjust += bpf_stack_adjust;
 
@@ -114,11 +143,12 @@ static void build_prologue(struct jit_ctx *ctx)
 		emit_insn(ctx, nop);
 
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
 
@@ -146,20 +176,13 @@ static void build_prologue(struct jit_ctx *ctx)
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
 
@@ -192,6 +215,16 @@ static void __build_epilogue(struct jit_ctx *ctx, bool is_tail_call)
 	load_offset -= sizeof(long);
 	emit_insn(ctx, ldd, LOONGARCH_GPR_S5, LOONGARCH_GPR_SP, load_offset);
 
+	/*
+	 *  When push into the stack, follow the order of tcc then tcc_ptr.
+	 *  When pop from the stack, first pop tcc_ptr followed by tcc
+	 */
+	load_offset -= 2*sizeof(long);
+	emit_insn(ctx, ldd, REG_TCC, LOONGARCH_GPR_SP, load_offset);
+
+	load_offset += sizeof(long);
+	emit_insn(ctx, ldd, REG_TCC, LOONGARCH_GPR_SP, load_offset);
+
 	emit_insn(ctx, addid, LOONGARCH_GPR_SP, LOONGARCH_GPR_SP, stack_adjust);
 
 	if (!is_tail_call) {
@@ -204,7 +237,7 @@ static void __build_epilogue(struct jit_ctx *ctx, bool is_tail_call)
 		 * Call the next bpf prog and skip the first instruction
 		 * of TCC initialization.
 		 */
-		emit_insn(ctx, jirl, LOONGARCH_GPR_ZERO, LOONGARCH_GPR_T3, 1);
+		emit_insn(ctx, jirl, LOONGARCH_GPR_ZERO, LOONGARCH_GPR_T3, 6);
 	}
 }
 
@@ -226,7 +259,7 @@ bool bpf_jit_supports_far_kfunc_call(void)
 static int emit_bpf_tail_call(struct jit_ctx *ctx, int insn)
 {
 	int off;
-	u8 tcc = tail_call_reg(ctx);
+	int tcc_ptr_off = BPF_TAIL_CALL_CNT_PTR_STACK_OFF(ctx->stack_size);
 	u8 a1 = LOONGARCH_GPR_A1;
 	u8 a2 = LOONGARCH_GPR_A2;
 	u8 t1 = LOONGARCH_GPR_T1;
@@ -255,11 +288,15 @@ static int emit_bpf_tail_call(struct jit_ctx *ctx, int insn)
 		goto toofar;
 
 	/*
-	 * if (--TCC < 0)
-	 *	 goto out;
+	 * if ((*tcc_ptr)++ >= MAX_TAIL_CALL_CNT)
+	 *      goto out;
 	 */
-	emit_insn(ctx, addid, REG_TCC, tcc, -1);
-	if (emit_tailcall_jmp(ctx, BPF_JSLT, REG_TCC, LOONGARCH_GPR_ZERO, jmp_offset) < 0)
+	emit_insn(ctx, ldd, REG_TCC, LOONGARCH_GPR_SP, tcc_ptr_off);
+	emit_insn(ctx, ldd, t3, REG_TCC, 0);
+	emit_insn(ctx, addid, t3, t3, 1);
+	emit_insn(ctx, std, t3, REG_TCC, 0);
+	emit_insn(ctx, addid, t2, LOONGARCH_GPR_ZERO, MAX_TAIL_CALL_CNT);
+	if (emit_tailcall_jmp(ctx, BPF_JSGT, t3, t2, jmp_offset) < 0)
 		goto toofar;
 
 	/*
@@ -480,6 +517,7 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
 	const s16 off = insn->off;
 	const s32 imm = insn->imm;
 	const bool is32 = BPF_CLASS(insn->code) == BPF_ALU || BPF_CLASS(insn->code) == BPF_JMP32;
+	int tcc_ptr_off;
 
 	switch (code) {
 	/* dst = src */
@@ -906,12 +944,16 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
 
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
 		move_addr(ctx, t1, func_addr);
 		emit_insn(ctx, jirl, LOONGARCH_GPR_RA, t1, 0);
 
@@ -922,7 +964,6 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
 
 	/* tail call */
 	case BPF_JMP | BPF_TAIL_CALL:
-		mark_tail_call(ctx);
 		if (emit_bpf_tail_call(ctx, i) < 0)
 			return -EINVAL;
 		break;
@@ -1597,7 +1638,7 @@ static int __arch_prepare_bpf_trampoline(struct jit_ctx *ctx, struct bpf_tramp_i
 {
 	int i;
 	int stack_size = 0, nargs = 0;
-	int retval_off, args_off, nargs_off, ip_off, run_ctx_off, sreg_off;
+	int retval_off, args_off, nargs_off, ip_off, run_ctx_off, sreg_off, tcc_ptr_off;
 	struct bpf_tramp_links *fentry = &tlinks[BPF_TRAMP_FENTRY];
 	struct bpf_tramp_links *fexit = &tlinks[BPF_TRAMP_FEXIT];
 	struct bpf_tramp_links *fmod_ret = &tlinks[BPF_TRAMP_MODIFY_RETURN];
@@ -1633,6 +1674,7 @@ static int __arch_prepare_bpf_trampoline(struct jit_ctx *ctx, struct bpf_tramp_i
 	 *
 	 * FP - sreg_off    [ callee saved reg  ]
 	 *
+	 * FP - tcc_ptr_off [ tail_call_cnt_ptr ]
 	 */
 
 	if (m->nr_args > LOONGARCH_MAX_REG_ARGS)
@@ -1675,6 +1717,12 @@ static int __arch_prepare_bpf_trampoline(struct jit_ctx *ctx, struct bpf_tramp_i
 	stack_size += 8;
 	sreg_off = stack_size;
 
+	/* room of trampoline frame to store tail_call_cnt_ptr */
+	if (flags & BPF_TRAMP_F_TAIL_CALL_CTX) {
+		stack_size += 8;
+		tcc_ptr_off = stack_size;
+	}
+
 	stack_size = round_up(stack_size, 16);
 
 	if (!is_struct_ops) {
@@ -1703,6 +1751,9 @@ static int __arch_prepare_bpf_trampoline(struct jit_ctx *ctx, struct bpf_tramp_i
 		emit_insn(ctx, addid, LOONGARCH_GPR_FP, LOONGARCH_GPR_SP, stack_size);
 	}
 
+	if (flags & BPF_TRAMP_F_TAIL_CALL_CTX)
+		emit_insn(ctx, std, REG_TCC, LOONGARCH_GPR_FP, -tcc_ptr_off);
+
 	/* callee saved register S1 to pass start time */
 	emit_insn(ctx, std, LOONGARCH_GPR_S1, LOONGARCH_GPR_FP, -sreg_off);
 
@@ -1750,6 +1801,10 @@ static int __arch_prepare_bpf_trampoline(struct jit_ctx *ctx, struct bpf_tramp_i
 
 	if (flags & BPF_TRAMP_F_CALL_ORIG) {
 		restore_args(ctx, m->nr_args, args_off);
+
+		if (flags & BPF_TRAMP_F_TAIL_CALL_CTX)
+			emit_insn(ctx, ldd, REG_TCC, LOONGARCH_GPR_FP, -tcc_ptr_off);
+
 		ret = emit_call(ctx, (const u64)orig_call);
 		if (ret)
 			goto out;
@@ -1791,6 +1846,9 @@ static int __arch_prepare_bpf_trampoline(struct jit_ctx *ctx, struct bpf_tramp_i
 
 	emit_insn(ctx, ldd, LOONGARCH_GPR_S1, LOONGARCH_GPR_FP, -sreg_off);
 
+	if (flags & BPF_TRAMP_F_TAIL_CALL_CTX)
+		emit_insn(ctx, ldd, REG_TCC, LOONGARCH_GPR_FP, -tcc_ptr_off);
+
 	if (!is_struct_ops) {
 		/* trampoline called from function entry */
 		emit_insn(ctx, ldd, LOONGARCH_GPR_T0, LOONGARCH_GPR_SP, stack_size - 8);
-- 
2.43.0


