Return-Path: <bpf+bounces-64701-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16D63B1612A
	for <lists+bpf@lfdr.de>; Wed, 30 Jul 2025 15:14:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63FFE4E0199
	for <lists+bpf@lfdr.de>; Wed, 30 Jul 2025 13:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F254429B204;
	Wed, 30 Jul 2025 13:13:34 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D4C4A921;
	Wed, 30 Jul 2025 13:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753881214; cv=none; b=tRdjEO8u7DKZu+e/yFAgS/gP+D13aM2xwUaMd7jgIAIyv0tmQrzcUu6it55mnnt38yzcw54dz9dw2gbR++CzEc1jfGend2yF9Ds5K5+JNvsO+ryGHRdnGK2i/bidGd1Ysil/pPBbQGfanjcWp08OzJ8VjuD+R0FaGdo7xcWnA/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753881214; c=relaxed/simple;
	bh=I1dfZ625WX06wEo2cHQO5cIfwJ8aaH9vBk58GBB15o8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EBmxxxmmw5fe8etsNgyWvyroAhdTZ92KuhbG5y7VguH47nXmItyDK9QAMOQipwiGAnTbFCg8Ioz6VvNRYBytyZhLYFT2N4fKs/FtijjL5stMLTo7n56l9hsqypSGSGo8PRLvoBtr3SLjQ/yS04fd+TpUtfDBaWaGRd/JTe8o3KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: fa73457e6d4611f0b29709d653e92f7d-20250730
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NO_NAME, HR_CTE_8B, HR_CTT_MISS
	HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME, HR_SJ_DIGIT_LEN
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME
	IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_EXISTED, SN_EXISTED
	SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, CIE_BAD, CIE_GOOD_SPF
	GTI_FG_BS, GTI_RG_INFO, GTI_C_BU, AMN_T1, AMN_GOOD
	AMN_C_TI, AMN_C_BU, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:750fafda-84ec-4d36-b4ba-944dfeca72ca,IP:15,
	URL:0,TC:0,Content:-25,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,AC
	TION:release,TS:-25
X-CID-INFO: VERSION:1.1.45,REQID:750fafda-84ec-4d36-b4ba-944dfeca72ca,IP:15,UR
	L:0,TC:0,Content:-25,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-25
X-CID-META: VersionHash:6493067,CLOUDID:f38d398521fd7c9f829081806d7a0498,BulkI
	D:2507302113286PVWODW6,BulkQuantity:0,Recheck:0,SF:17|19|24|38|44|66|78|81
	|82|102,TC:nil,Content:0|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS
	:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,A
	RC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: fa73457e6d4611f0b29709d653e92f7d-20250730
X-User: duanchenghao@kylinos.cn
Received: from localhost.localdomain [(116.128.244.171)] by mailgw.kylinos.cn
	(envelope-from <duanchenghao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1862959900; Wed, 30 Jul 2025 21:13:26 +0800
From: Chenghao Duan <duanchenghao@kylinos.cn>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	yangtiezhu@loongson.cn,
	hengqi.chen@gmail.com,
	chenhuacai@kernel.org
Cc: martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	kernel@xen0n.name,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	bpf@vger.kernel.org,
	guodongtai@kylinos.cn,
	duanchenghao@kylinos.cn,
	youling.tang@linux.dev,
	jianghaoran@kylinos.cn,
	vincent.mc.li@gmail.com,
	geliang@kernel.org
Subject: [PATCH v5 3/5] LoongArch: BPF: Implement dynamic code modification support
Date: Wed, 30 Jul 2025 21:12:55 +0800
Message-Id: <20250730131257.124153-4-duanchenghao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250730131257.124153-1-duanchenghao@kylinos.cn>
References: <20250730131257.124153-1-duanchenghao@kylinos.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit adds support for BPF dynamic code modification on the
LoongArch architecture.:
1. Implement bpf_arch_text_poke() for runtime instruction patching.
2. Add bpf_arch_text_copy() for instruction block copying.
3. Create bpf_arch_text_invalidate() for code invalidation.

On LoongArch, since symbol addresses in the direct mapping
region cannot be reached via relative jump instructions from the paged
mapping region, we use the move_imm+jirl instruction pair as absolute
jump instructions. These require 2-5 instructions, so we reserve 5 NOP
instructions in the program as placeholders for function jumps.

larch_insn_text_copy is solely used for BPF. The use of
larch_insn_text_copy() requires page_size alignment. Currently, only
the size of the trampoline is page-aligned.

Co-developed-by: George Guo <guodongtai@kylinos.cn>
Signed-off-by: George Guo <guodongtai@kylinos.cn>
Signed-off-by: Chenghao Duan <duanchenghao@kylinos.cn>
---
 arch/loongarch/include/asm/inst.h |   1 +
 arch/loongarch/kernel/inst.c      |  27 ++++++++
 arch/loongarch/net/bpf_jit.c      | 104 ++++++++++++++++++++++++++++++
 3 files changed, 132 insertions(+)

diff --git a/arch/loongarch/include/asm/inst.h b/arch/loongarch/include/asm/inst.h
index 2ae96a35d..88bb73e46 100644
--- a/arch/loongarch/include/asm/inst.h
+++ b/arch/loongarch/include/asm/inst.h
@@ -497,6 +497,7 @@ void arch_simulate_insn(union loongarch_instruction insn, struct pt_regs *regs);
 int larch_insn_read(void *addr, u32 *insnp);
 int larch_insn_write(void *addr, u32 insn);
 int larch_insn_patch_text(void *addr, u32 insn);
+int larch_insn_text_copy(void *dst, void *src, size_t len);
 
 u32 larch_insn_gen_nop(void);
 u32 larch_insn_gen_b(unsigned long pc, unsigned long dest);
diff --git a/arch/loongarch/kernel/inst.c b/arch/loongarch/kernel/inst.c
index 674e3b322..7df63a950 100644
--- a/arch/loongarch/kernel/inst.c
+++ b/arch/loongarch/kernel/inst.c
@@ -4,6 +4,7 @@
  */
 #include <linux/sizes.h>
 #include <linux/uaccess.h>
+#include <linux/set_memory.h>
 
 #include <asm/cacheflush.h>
 #include <asm/inst.h>
@@ -218,6 +219,32 @@ int larch_insn_patch_text(void *addr, u32 insn)
 	return ret;
 }
 
+int larch_insn_text_copy(void *dst, void *src, size_t len)
+{
+	int ret;
+	unsigned long flags;
+	unsigned long dst_start, dst_end, dst_len;
+
+	dst_start = round_down((unsigned long)dst, PAGE_SIZE);
+	dst_end = round_up((unsigned long)dst + len, PAGE_SIZE);
+	dst_len = dst_end - dst_start;
+
+	set_memory_rw(dst_start, dst_len / PAGE_SIZE);
+	raw_spin_lock_irqsave(&patch_lock, flags);
+
+	ret = copy_to_kernel_nofault(dst, src, len);
+	if (ret)
+		pr_err("%s: operation failed\n", __func__);
+
+	raw_spin_unlock_irqrestore(&patch_lock, flags);
+	set_memory_rox(dst_start, dst_len / PAGE_SIZE);
+
+	if (!ret)
+		flush_icache_range((unsigned long)dst, (unsigned long)dst + len);
+
+	return ret;
+}
+
 u32 larch_insn_gen_nop(void)
 {
 	return INSN_NOP;
diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
index 7032f11d3..5e6ae7e0e 100644
--- a/arch/loongarch/net/bpf_jit.c
+++ b/arch/loongarch/net/bpf_jit.c
@@ -4,8 +4,12 @@
  *
  * Copyright (C) 2022 Loongson Technology Corporation Limited
  */
+#include <linux/memory.h>
 #include "bpf_jit.h"
 
+#define LOONGARCH_LONG_JUMP_NINSNS 5
+#define LOONGARCH_LONG_JUMP_NBYTES (LOONGARCH_LONG_JUMP_NINSNS * 4)
+
 #define REG_TCC		LOONGARCH_GPR_A6
 #define TCC_SAVED	LOONGARCH_GPR_S5
 
@@ -88,6 +92,7 @@ static u8 tail_call_reg(struct jit_ctx *ctx)
  */
 static void build_prologue(struct jit_ctx *ctx)
 {
+	int i;
 	int stack_adjust = 0, store_offset, bpf_stack_adjust;
 
 	bpf_stack_adjust = round_up(ctx->prog->aux->stack_depth, 16);
@@ -98,6 +103,10 @@ static void build_prologue(struct jit_ctx *ctx)
 	stack_adjust = round_up(stack_adjust, 16);
 	stack_adjust += bpf_stack_adjust;
 
+	/* Reserve space for the move_imm + jirl instruction */
+	for (i = 0; i < LOONGARCH_LONG_JUMP_NINSNS; i++)
+		emit_insn(ctx, nop);
+
 	/*
 	 * First instruction initializes the tail call count (TCC).
 	 * On tail call we skip this instruction, and the TCC is
@@ -1367,3 +1376,98 @@ bool bpf_jit_supports_subprog_tailcalls(void)
 {
 	return true;
 }
+
+static int emit_jump_and_link(struct jit_ctx *ctx, u8 rd, u64 target)
+{
+	if (!target) {
+		pr_err("bpf_jit: jump target address is error\n");
+		return -EFAULT;
+	}
+
+	move_imm(ctx, LOONGARCH_GPR_T1, target, false);
+	emit_insn(ctx, jirl, rd, LOONGARCH_GPR_T1, 0);
+
+	return 0;
+}
+
+static int gen_jump_or_nops(void *target, void *ip, u32 *insns, bool is_call)
+{
+	struct jit_ctx ctx;
+
+	ctx.idx = 0;
+	ctx.image = (union loongarch_instruction *)insns;
+
+	if (!target) {
+		emit_insn((&ctx), nop);
+		emit_insn((&ctx), nop);
+		return 0;
+	}
+
+	return emit_jump_and_link(&ctx, is_call ? LOONGARCH_GPR_T0 : LOONGARCH_GPR_ZERO,
+				  (unsigned long)target);
+}
+
+int bpf_arch_text_poke(void *ip, enum bpf_text_poke_type poke_type,
+		       void *old_addr, void *new_addr)
+{
+	u32 old_insns[LOONGARCH_LONG_JUMP_NINSNS] = {[0 ... 4] = INSN_NOP};
+	u32 new_insns[LOONGARCH_LONG_JUMP_NINSNS] = {[0 ... 4] = INSN_NOP};
+	bool is_call = poke_type == BPF_MOD_CALL;
+	int ret;
+
+	if (!is_kernel_text((unsigned long)ip) &&
+		!is_bpf_text_address((unsigned long)ip))
+		return -ENOTSUPP;
+
+	ret = gen_jump_or_nops(old_addr, ip, old_insns, is_call);
+	if (ret)
+		return ret;
+
+	if (memcmp(ip, old_insns, LOONGARCH_LONG_JUMP_NBYTES))
+		return -EFAULT;
+
+	ret = gen_jump_or_nops(new_addr, ip, new_insns, is_call);
+	if (ret)
+		return ret;
+
+	mutex_lock(&text_mutex);
+	if (memcmp(ip, new_insns, LOONGARCH_LONG_JUMP_NBYTES))
+		ret = larch_insn_text_copy(ip, new_insns, LOONGARCH_LONG_JUMP_NBYTES);
+	mutex_unlock(&text_mutex);
+	return ret;
+}
+
+int bpf_arch_text_invalidate(void *dst, size_t len)
+{
+	int i;
+	int ret = 0;
+	u32 *inst;
+
+	inst = kvmalloc(len, GFP_KERNEL);
+	if (!inst)
+		return -ENOMEM;
+
+	for (i = 0; i < (len/sizeof(u32)); i++)
+		inst[i] = INSN_BREAK;
+
+	mutex_lock(&text_mutex);
+	if (larch_insn_text_copy(dst, inst, len))
+		ret = -EINVAL;
+	mutex_unlock(&text_mutex);
+
+	kvfree(inst);
+	return ret;
+}
+
+void *bpf_arch_text_copy(void *dst, void *src, size_t len)
+{
+	int ret;
+
+	mutex_lock(&text_mutex);
+	ret = larch_insn_text_copy(dst, src, len);
+	mutex_unlock(&text_mutex);
+	if (ret)
+		return ERR_PTR(-EINVAL);
+
+	return dst;
+}
-- 
2.25.1


