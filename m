Return-Path: <bpf+bounces-76825-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 109C2CC63B5
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 07:24:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3D62A302F18D
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 06:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CBCC2EBBAF;
	Wed, 17 Dec 2025 06:15:00 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E207B2DC33F;
	Wed, 17 Dec 2025 06:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765952100; cv=none; b=dn0ba/MzEvv2X+jsuorp0qIX8/3kwKCY9QAoRbtW7BWe2KjYF8nDYGF10eD7bBb7NnGjxwDPm9Ui5RCOGg6apaXCmWEJBC2uRap6gvci6kBQHopEcGNcjI8GHVYc/rR40lD2KnXOeDknbHf1MRS7ewydfONPuvvuBWda1JyqISs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765952100; c=relaxed/simple;
	bh=YQruH6xDYid2KbeZCuW/EBXAgV9ICz90owU6l1cryUA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=M1fglqy0rRyw+W/X3qJ28JeC2EF+PcYYkVSZ2mfH/3bQ8ZrPPNvx5C8TvvzztOmDvx2tVZUBdYujArE60U/4nwoKEjZCpx95uNeqXoT4lspCqYzKFDIUsIivONHBffLy7CuMJlSrB9aq3XTrUbBG38twXAG5iZzdiceNyhUZJEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: b135e326db0f11f0a38c85956e01ac42-20251217
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
X-CID-O-INFO: VERSION:1.3.6,REQID:68546b5d-548d-4ec0-961d-bcc2aeb890f4,IP:10,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:5
X-CID-INFO: VERSION:1.3.6,REQID:68546b5d-548d-4ec0-961d-bcc2aeb890f4,IP:10,URL
	:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:5
X-CID-META: VersionHash:a9d874c,CLOUDID:1897838be0a3ac86b89d997081ea7b68,BulkI
	D:251217141451YB1P9FB7,BulkQuantity:0,Recheck:0,SF:17|19|38|66|78|81|82|10
	2|127|850|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bu
	lk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:
	0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: b135e326db0f11f0a38c85956e01ac42-20251217
X-User: duanchenghao@kylinos.cn
Received: from localhost.localdomain [(183.242.174.20)] by mailgw.kylinos.cn
	(envelope-from <duanchenghao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 784059731; Wed, 17 Dec 2025 14:14:49 +0800
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
Subject: [PATCH v4 3/7] LoongArch: BPF: Enable and fix trampoline-based tracing for module functions
Date: Wed, 17 Dec 2025 14:14:31 +0800
Message-Id: <20251217061435.802204-4-duanchenghao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251217061435.802204-1-duanchenghao@kylinos.cn>
References: <20251217061435.802204-1-duanchenghao@kylinos.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the previous restrictions that blocked the tracing of kernel
module functions. Fix the issue that previously caused kernel lockups
when attempting to trace module functions.

Before entering the trampoline code, the return address register ra
shall store the address of the next assembly instruction after the
'bl trampoline' instruction, which is the traced function address, and
the register t0 shall store the parent function return address. Refine
the trampoline return logic to ensure that register data remains
correct when returning to both the traced function and the parent
function.

Before this patch was applied, the module_attach test in selftests/bpf
encountered a deadlock issue. This was caused by an incorrect jump
address after the trampoline execution, which resulted in an infinite
loop within the module function.

Fixes: 677e6123e3d2 ("LoongArch: BPF: Disable trampoline for kernel module function trace")

Signed-off-by: Chenghao Duan <duanchenghao@kylinos.cn>
---
 arch/loongarch/net/bpf_jit.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
index 8dc58781b8eb..76cd24646bec 100644
--- a/arch/loongarch/net/bpf_jit.c
+++ b/arch/loongarch/net/bpf_jit.c
@@ -1265,7 +1265,7 @@ static int emit_jump_or_nops(void *target, void *ip, u32 *insns, bool is_call)
 		return 0;
 	}
 
-	return emit_jump_and_link(&ctx, is_call ? LOONGARCH_GPR_T0 : LOONGARCH_GPR_ZERO, (u64)target);
+	return emit_jump_and_link(&ctx, is_call ? LOONGARCH_GPR_RA : LOONGARCH_GPR_ZERO, (u64)target);
 }
 
 static int emit_call(struct jit_ctx *ctx, u64 addr)
@@ -1622,14 +1622,12 @@ static int __arch_prepare_bpf_trampoline(struct jit_ctx *ctx, struct bpf_tramp_i
 
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
@@ -1722,12 +1720,16 @@ static int __arch_prepare_bpf_trampoline(struct jit_ctx *ctx, struct bpf_tramp_i
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


