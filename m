Return-Path: <bpf+bounces-64271-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88EC6B10D6A
	for <lists+bpf@lfdr.de>; Thu, 24 Jul 2025 16:25:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C4D8B064E1
	for <lists+bpf@lfdr.de>; Thu, 24 Jul 2025 14:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A30552E2F04;
	Thu, 24 Jul 2025 14:21:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06FEF2E0925;
	Thu, 24 Jul 2025 14:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753366888; cv=none; b=Lshw0mea9pQRARjmkNq/d0a9A0wKJi50Ll3qgs1ARN2yZnh1tINIP59vR8GagHtb/HuUYowXrW8XbGVbjBWoxy3IUmhOSByvjw4pRqr3mqXLVYCzjXjD+anC3TAX+Dwl3FDAXrOhfiOYtt6U8uyLEIGLk2WsaM7FerrbhI2e/kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753366888; c=relaxed/simple;
	bh=+NOwuItkA6UL6RCcQB9e9iJsfakYjQzgvN5EPMBLEiM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XbyzY9BTz/dnc4dkfhsVf8fRDTjzOYdYSICwEIHOHVgYc4rxzLoVqXxbSrR66op7XpQw/Tn4wp19b73FIzdd4EbAxI28LrEGvrtN3K5I+gyXJiF6jAEd/0U4ekY0vZQbF1QDiAIG/tajxR1lts3YO9mac3VXwtYUujC5bUl4i18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 7879e70a689911f0b29709d653e92f7d-20250724
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
X-CID-O-INFO: VERSION:1.1.45,REQID:0962744b-6a59-4294-87a7-70f2975228d2,IP:10,
	URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:-9,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-4
X-CID-INFO: VERSION:1.1.45,REQID:0962744b-6a59-4294-87a7-70f2975228d2,IP:10,UR
	L:0,TC:0,Content:-5,EDM:0,RT:0,SF:-9,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-4
X-CID-META: VersionHash:6493067,CLOUDID:dd647aab0ce4feca90d86509ffcea32c,BulkI
	D:250724222122GPQL7DQX,BulkQuantity:0,Recheck:0,SF:17|19|24|38|43|66|74|78
	|81|82|102,TC:nil,Content:0|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil
	,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:
	0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: 7879e70a689911f0b29709d653e92f7d-20250724
X-User: duanchenghao@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <duanchenghao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 11500825; Thu, 24 Jul 2025 22:21:20 +0800
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
	vincent.mc.li@gmail.com
Subject: [PATCH v4 3/5] LoongArch: BPF: Add bpf_arch_xxxxx support for Loongarch
Date: Thu, 24 Jul 2025 22:19:27 +0800
Message-Id: <20250724141929.691853-4-duanchenghao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250724141929.691853-1-duanchenghao@kylinos.cn>
References: <20250724141929.691853-1-duanchenghao@kylinos.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement the functions of bpf_arch_text_poke, bpf_arch_text_copy, and
bpf_arch_text_invalidate on the LoongArch architecture.

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
Reviewed-by: Hengqi Chen <hengqi.chen@gmail.com>
Reviewed-by: Huacai Chen <chenhuacai@kernel.org>
---
 arch/loongarch/include/asm/inst.h |  1 +
 arch/loongarch/kernel/inst.c      | 32 ++++++++++
 arch/loongarch/net/bpf_jit.c      | 97 +++++++++++++++++++++++++++++++
 3 files changed, 130 insertions(+)

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
index 674e3b322..8d6594968 100644
--- a/arch/loongarch/kernel/inst.c
+++ b/arch/loongarch/kernel/inst.c
@@ -4,6 +4,7 @@
  */
 #include <linux/sizes.h>
 #include <linux/uaccess.h>
+#include <linux/set_memory.h>
 
 #include <asm/cacheflush.h>
 #include <asm/inst.h>
@@ -218,6 +219,37 @@ int larch_insn_patch_text(void *addr, u32 insn)
 	return ret;
 }
 
+int larch_insn_text_copy(void *dst, void *src, size_t len)
+{
+	unsigned long flags;
+	size_t wlen = 0;
+	size_t size;
+	void *ptr;
+	int ret = 0;
+
+	set_memory_rw((unsigned long)dst, round_up(len, PAGE_SIZE) / PAGE_SIZE);
+	raw_spin_lock_irqsave(&patch_lock, flags);
+	while (wlen < len) {
+		ptr = dst + wlen;
+		size = min_t(size_t, PAGE_SIZE - offset_in_page(ptr),
+			     len - wlen);
+
+		ret = copy_to_kernel_nofault(ptr, src + wlen, size);
+		if (ret) {
+			pr_err("%s: operation failed\n", __func__);
+			break;
+		}
+		wlen += size;
+	}
+	raw_spin_unlock_irqrestore(&patch_lock, flags);
+	set_memory_rox((unsigned long)dst, round_up(len, PAGE_SIZE) / PAGE_SIZE);
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
index 7032f11d3..86504e710 100644
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
@@ -1367,3 +1376,91 @@ bool bpf_jit_supports_subprog_tailcalls(void)
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
+	if (larch_insn_text_copy(dst, inst, len))
+		ret = -EINVAL;
+
+	kvfree(inst);
+	return ret;
+}
+
+void *bpf_arch_text_copy(void *dst, void *src, size_t len)
+{
+	if (larch_insn_text_copy(dst, src, len))
+		return ERR_PTR(-EINVAL);
+
+	return dst;
+}
-- 
2.25.1


