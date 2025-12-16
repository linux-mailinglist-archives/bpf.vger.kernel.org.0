Return-Path: <bpf+bounces-76704-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CA393CC1DC8
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 10:51:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C593F3016FB0
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 09:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5BD5336EE8;
	Tue, 16 Dec 2025 09:51:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09CB2324B24;
	Tue, 16 Dec 2025 09:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765878677; cv=none; b=c/5FivojZtTg/NT/jDPIEDajBnp3Nm91Jh1kbNfdoEtCS6SyB7nrMmFF5IncV7l1FeCJXoGz9NTZ3yujoz1miVc+5XvMuhuXgyIhBzdvvCkuz/5W+MHXE0R+9v88/ArapNgZgf9Rruz+9ZsuTc+9gLzd/oLI+jTfQlNnumlRXo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765878677; c=relaxed/simple;
	bh=Y5auGuaxvfZHLlp+fQ2vMzFeUByrU/gY2iyIPC35ya4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=O2qmNAU1boak3FbV/55wNma7zQvszrFUcBEsEmcrDpGl5Pk5+nIaBmGBW2KJbLSdPLFpjFAP5ZG3YR8A9VBA8CRx4mYCvJScEpL4JLTpgn2EbHTxGfLbIr+u9iK8oXiVjaFQRW0ZL1AUJi+gd+XubSeHWvaC/ktLd6oSR56ZFcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: bef2e3c0da6411f0a38c85956e01ac42-20251216
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NO_NAME, HR_CTE_8B, HR_CTT_MISS
	HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME, HR_SJ_DIGIT_LEN
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME
	IP_UNTRUSTED, SRC_UNTRUSTED, IP_UNFAMILIAR, SRC_UNFAMILIAR, DN_TRUSTED
	SRC_TRUSTED, SA_EXISTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS
	DMARC_NOPASS, CIE_BAD, CIE_GOOD_SPF, CIE_UNKNOWN, GTI_FG_BS
	GTI_RG_INFO, GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:d29f5b63-1cda-40aa-8730-d3f5981b4398,IP:10,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:5
X-CID-INFO: VERSION:1.3.6,REQID:d29f5b63-1cda-40aa-8730-d3f5981b4398,IP:10,URL
	:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:5
X-CID-META: VersionHash:a9d874c,CLOUDID:14c2d1e48919b5226a006462b9174905,BulkI
	D:251216175109TSL2QGY3,BulkQuantity:0,Recheck:0,SF:17|19|38|66|78|81|82|10
	2|127|850|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bu
	lk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:
	0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: bef2e3c0da6411f0a38c85956e01ac42-20251216
X-User: duanchenghao@kylinos.cn
Received: from localhost.localdomain [(183.242.174.21)] by mailgw.kylinos.cn
	(envelope-from <duanchenghao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 138411781; Tue, 16 Dec 2025 17:51:08 +0800
From: Chenghao Duan <duanchenghao@kylinos.cn>
To: yangtiezhu@loongson.cn,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mark.rutland@arm.com,
	hengqi.chen@gmail.com,
	chenhuacai@kernel.org
Cc: kernel@xen0n.name,
	zhangtianyang@loongson.cn,
	masahiroy@kernel.org,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	bpf@vger.kernel.org,
	duanchenghao@kylinos.cn,
	youling.tang@linux.dev,
	jianghaoran@kylinos.cn,
	vincent.mc.li@gmail.com,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v3 3/4] LoongArch: BPF: Enhance trampoline support for kernel and module tracing
Date: Tue, 16 Dec 2025 17:47:52 +0800
Message-Id: <20251216094753.1317231-4-duanchenghao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251216094753.1317231-1-duanchenghao@kylinos.cn>
References: <20251216094753.1317231-1-duanchenghao@kylinos.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch addresses two main issues in the LoongArch BPF trampoline
implementation:

1. BPF-to-BPF call handling:
 - Modify the build_prologue function to ensure that the value of the
 return address register ra is saved to t0 before entering the
 trampoline operation.
 - This ensures that the return address handling logic is accurate and
 error-free when a BPF program calls another BPF program.

2. Enable Module Function Tracing Support:
 - Remove the previous restrictions that blocked the tracing of kernel
 module functions.
 - Fix the issue that previously caused kernel lockups when attempting
 to trace module functions

3. Related Function Optimizations:
 - Adjust the jump offset of tail calls to ensure correct instruction
   alignment.
 - Enhance the bpf_arch_text_poke() function to enable accurate location
 of BPF program entry points.
 - Refine the trampoline return logic to ensure that the register data
 is correct when returning to both the traced function and the parent
 function.

After applying the current patch series, the following selftests/bpf
test cases all pass:
./test_progs -t module_attach
./test_progs -t module_fentry_shadow
./test_progs -t subprogs
./test_progs -t subprogs_extable
./test_progs -t tailcalls
./test_progs -t struct_ops -d struct_ops_multi_pages
./test_progs -t fexit_bpf2bpf
./test_progs -t fexit_stress
./test_progs -t fentry_test/fentry
./test_progs -t fexit_test/fexit
./test_progs -t fentry_fexit
./test_progs -t modify_return
./test_progs -t fexit_sleep
./test_progs -t trampoline_count

Signed-off-by: Chenghao Duan <duanchenghao@kylinos.cn>
---
 arch/loongarch/net/bpf_jit.c | 38 +++++++++++++++++++++++++-----------
 1 file changed, 27 insertions(+), 11 deletions(-)

diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
index 8dc58781b8eb..0c16a1b18e8f 100644
--- a/arch/loongarch/net/bpf_jit.c
+++ b/arch/loongarch/net/bpf_jit.c
@@ -139,6 +139,7 @@ static void build_prologue(struct jit_ctx *ctx)
 	stack_adjust = round_up(stack_adjust, 16);
 	stack_adjust += bpf_stack_adjust;
 
+	move_reg(ctx, LOONGARCH_GPR_T0, LOONGARCH_GPR_RA);
 	/* Reserve space for the move_imm + jirl instruction */
 	for (i = 0; i < LOONGARCH_LONG_JUMP_NINSNS; i++)
 		emit_insn(ctx, nop);
@@ -238,7 +239,7 @@ static void __build_epilogue(struct jit_ctx *ctx, bool is_tail_call)
 		 * Call the next bpf prog and skip the first instruction
 		 * of TCC initialization.
 		 */
-		emit_insn(ctx, jirl, LOONGARCH_GPR_ZERO, LOONGARCH_GPR_T3, 6);
+		emit_insn(ctx, jirl, LOONGARCH_GPR_ZERO, LOONGARCH_GPR_T3, 7);
 	}
 }
 
@@ -1265,7 +1266,7 @@ static int emit_jump_or_nops(void *target, void *ip, u32 *insns, bool is_call)
 		return 0;
 	}
 
-	return emit_jump_and_link(&ctx, is_call ? LOONGARCH_GPR_T0 : LOONGARCH_GPR_ZERO, (u64)target);
+	return emit_jump_and_link(&ctx, is_call ? LOONGARCH_GPR_RA : LOONGARCH_GPR_ZERO, (u64)target);
 }
 
 static int emit_call(struct jit_ctx *ctx, u64 addr)
@@ -1289,6 +1290,10 @@ int bpf_arch_text_poke(void *ip, enum bpf_text_poke_type old_t,
 		       void *new_addr)
 {
 	int ret;
+	unsigned long size = 0;
+	unsigned long offset = 0;
+	char namebuf[KSYM_NAME_LEN];
+	void *image = NULL;
 	bool is_call;
 	u32 old_insns[LOONGARCH_LONG_JUMP_NINSNS] = {[0 ... 4] = INSN_NOP};
 	u32 new_insns[LOONGARCH_LONG_JUMP_NINSNS] = {[0 ... 4] = INSN_NOP};
@@ -1296,9 +1301,18 @@ int bpf_arch_text_poke(void *ip, enum bpf_text_poke_type old_t,
 	/* Only poking bpf text is supported. Since kernel function entry
 	 * is set up by ftrace, we rely on ftrace to poke kernel functions.
 	 */
-	if (!is_bpf_text_address((unsigned long)ip))
+	if (!__bpf_address_lookup((unsigned long)ip, &size, &offset, namebuf))
 		return -ENOTSUPP;
 
+	image = ip - offset;
+	/* zero offset means we're poking bpf prog entry */
+	if (offset == 0)
+		/* skip to the nop instruction in bpf prog entry:
+		 * move t0, ra
+		 * nop
+		 */
+		ip = image + LOONGARCH_INSN_SIZE;
+
 	is_call = old_t == BPF_MOD_CALL;
 	ret = emit_jump_or_nops(old_addr, ip, old_insns, is_call);
 	if (ret)
@@ -1622,14 +1636,12 @@ static int __arch_prepare_bpf_trampoline(struct jit_ctx *ctx, struct bpf_tramp_i
 
 	/* To traced function */
 	/* Ftrace jump skips 2 NOP instructions */
-	if (is_kernel_text((unsigned long)orig_call))
+	if (is_kernel_text((unsigned long)orig_call) ||
+	    is_module_text_address((unsigned long)orig_call))
 		orig_call += LOONGARCH_FENTRY_NBYTES;
 	/* Direct jump skips 5 NOP instructions */
 	else if (is_bpf_text_address((unsigned long)orig_call))
 		orig_call += LOONGARCH_BPF_FENTRY_NBYTES;
-	/* Module tracing not supported - cause kernel lockups */
-	else if (is_module_text_address((unsigned long)orig_call))
-		return -ENOTSUPP;
 
 	if (flags & BPF_TRAMP_F_CALL_ORIG) {
 		move_addr(ctx, LOONGARCH_GPR_A0, (const u64)im);
@@ -1722,12 +1734,16 @@ static int __arch_prepare_bpf_trampoline(struct jit_ctx *ctx, struct bpf_tramp_i
 		emit_insn(ctx, ldd, LOONGARCH_GPR_FP, LOONGARCH_GPR_SP, 0);
 		emit_insn(ctx, addid, LOONGARCH_GPR_SP, LOONGARCH_GPR_SP, 16);
 
-		if (flags & BPF_TRAMP_F_SKIP_FRAME)
+		if (flags & BPF_TRAMP_F_SKIP_FRAME) {
 			/* return to parent function */
-			emit_insn(ctx, jirl, LOONGARCH_GPR_ZERO, LOONGARCH_GPR_RA, 0);
-		else
-			/* return to traced function */
+			move_reg(ctx, LOONGARCH_GPR_RA, LOONGARCH_GPR_T0);
 			emit_insn(ctx, jirl, LOONGARCH_GPR_ZERO, LOONGARCH_GPR_T0, 0);
+		} else {
+			/* return to traced function */
+			move_reg(ctx, LOONGARCH_GPR_T1, LOONGARCH_GPR_RA);
+			move_reg(ctx, LOONGARCH_GPR_RA, LOONGARCH_GPR_T0);
+			emit_insn(ctx, jirl, LOONGARCH_GPR_ZERO, LOONGARCH_GPR_T1, 0);
+		}
 	}
 
 	ret = ctx->idx;
-- 
2.25.1


