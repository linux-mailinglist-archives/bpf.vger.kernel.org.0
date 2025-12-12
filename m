Return-Path: <bpf+bounces-76526-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F937CB86A7
	for <lists+bpf@lfdr.de>; Fri, 12 Dec 2025 10:19:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 35FC53096CC0
	for <lists+bpf@lfdr.de>; Fri, 12 Dec 2025 09:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AAC331283C;
	Fri, 12 Dec 2025 09:11:45 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68FFA30DEB2;
	Fri, 12 Dec 2025 09:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765530704; cv=none; b=ftekZMIOZf1iyNBKQOmoiH4WdkmLH4fg1dx3ysPLVJCoK1Nc2Nhzw36Ynuafqc7xjrt3jaK2kbNtm/7X79wy9BCXwzwTimF12cl5/h8ZS6FJW0fPXJfibEzhWXqqTh+fQlz4qA40qc+d4GkdtYmdf3a0gHLV7pj9ru1JViWVR5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765530704; c=relaxed/simple;
	bh=pkliUrzEeUU6sVjnmAseowuvxhsqVM8s2e/pKg8RqRs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gH1F1Yfur79O8RnWexxcyefZKO7FGq1oPkz6rGwbvr/Gkhr49wxRUdK4589wycyffhGvHzWr/SZ7nIyww9ZjXOEvw8k4KZZgcxs2WO//kcq7OK13jMbdts31PA/kXwkxZMkwNqTRpuYQwFbxo3RH6KHOEes6SnhFbhRWmD0U0ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 8d732b5cd73a11f0a38c85956e01ac42-20251212
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NO_NAME, HR_CTE_8B, HR_CTT_MISS
	HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME, HR_SJ_DIGIT_LEN
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME
	IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_EXISTED, SN_EXISTED
	SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:9164bdee-4e35-4824-8d6c-52da678fe158,IP:10,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:5
X-CID-INFO: VERSION:1.3.6,REQID:9164bdee-4e35-4824-8d6c-52da678fe158,IP:10,URL
	:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:5
X-CID-META: VersionHash:a9d874c,CLOUDID:5e16e23be3cc20cfdcd1ae7847815dd2,BulkI
	D:2512121711350DZ09CJT,BulkQuantity:0,Recheck:0,SF:17|19|38|66|78|81|82|10
	2|127|850|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bu
	lk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:
	0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 8d732b5cd73a11f0a38c85956e01ac42-20251212
X-User: duanchenghao@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <duanchenghao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 125336568; Fri, 12 Dec 2025 17:11:32 +0800
From: Chenghao Duan <duanchenghao@kylinos.cn>
To: yangtiezhu@loongson.cn,
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
	vincent.mc.li@gmail.com
Subject: [PATCH v2 3/4] LoongArch: BPF: Enhance trampoline support for kernel and module tracing
Date: Fri, 12 Dec 2025 17:11:02 +0800
Message-Id: <20251212091103.1247753-4-duanchenghao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251212091103.1247753-1-duanchenghao@kylinos.cn>
References: <20251212091103.1247753-1-duanchenghao@kylinos.cn>
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


