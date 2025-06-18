Return-Path: <bpf+bounces-60900-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B0A80ADE966
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 12:51:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C9EA17DCDD
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 10:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE2F82874EB;
	Wed, 18 Jun 2025 10:51:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C3443ABC;
	Wed, 18 Jun 2025 10:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750243884; cv=none; b=XgnSeXXzdEhnX/DBnmIIu/rkyvgV/fmX9+9narnX2evpamPrYNGJzJpksFlTT1BGFy2ZbPMNnKV8iGLToX31Hr1vIB7ZUZKD2FbienDzi0daPlwrRqF9iZ/yAgDZwdX7ItylwJ5JsDzEqBpaPJJfVfVSvMjM7tVGRoMrj/Jw1qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750243884; c=relaxed/simple;
	bh=+NWfDEi9U7FJzFDSH2mcrKoJw7FeUqkALmourSsSgcY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CaMkxD1D5/NkM7KBCUl9zvEWewHZuhxsDHd44vHWfBhadFMDxXWruowV/06oNZIAG9rMdsYDLeuwVw6Fhxeyt9devmPxKuDjc8pBKv0ovwEkp7KtfRilvOa/i3FAVgDkvPVlIJ86m42dh3rvtaJOh2cDI1Sx0ZlNTEsSqniDbgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 26cffc884c3211f0b29709d653e92f7d-20250618
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_EXISTED
	SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, CIE_BAD
	CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO, GTI_C_BU
	AMN_T1, AMN_GOOD, AMN_C_TI, AMN_C_BU, ABX_MISS_RDNS
X-CID-CACHE: Type:Local,Time:202506181848+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:da639e8b-1a93-4b88-a5d7-8e2bf45be6ab,IP:10,
	URL:0,TC:0,Content:0,EDM:-30,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,AC
	TION:release,TS:-35
X-CID-INFO: VERSION:1.1.45,REQID:da639e8b-1a93-4b88-a5d7-8e2bf45be6ab,IP:10,UR
	L:0,TC:0,Content:0,EDM:-30,RT:0,SF:-15,FILE:0,BULK:0,RULE:EDM_GN8D19FE,ACT
	ION:release,TS:-35
X-CID-META: VersionHash:6493067,CLOUDID:beed39781909102466e59146768bf1cb,BulkI
	D:250618184812UTXWTWDY,BulkQuantity:0,Recheck:0,SF:17|19|24|44|66|78|81|82
	|102,TC:nil,Content:0|50,EDM:2,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil
	,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,TF_CID_SPAM_SNR,TF_CID_SPAM_FAS
X-UUID: 26cffc884c3211f0b29709d653e92f7d-20250618
X-User: duanchenghao@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <duanchenghao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 346226568; Wed, 18 Jun 2025 18:51:13 +0800
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
	Youling Tang <tangyouling@kylinos.cn>
Subject: [PATCH v2 1/4] LoongArch: BPF: The operation commands needed to add a trampoline
Date: Wed, 18 Jun 2025 18:50:45 +0800
Message-Id: <20250618105048.1510560-2-duanchenghao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250618105048.1510560-1-duanchenghao@kylinos.cn>
References: <20250618105048.1510560-1-duanchenghao@kylinos.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add branch jump function:
larch_insn_gen_beq
larch_insn_gen_bne

Add instruction copy function: larch_insn_text_copy

Co-developed-by: George Guo <guodongtai@kylinos.cn>
Signed-off-by: George Guo <guodongtai@kylinos.cn>
Co-developed-by: Youling Tang <tangyouling@kylinos.cn>
Signed-off-by: Youling Tang <tangyouling@kylinos.cn>
Signed-off-by: Chenghao Duan <duanchenghao@kylinos.cn>
---
 arch/loongarch/include/asm/inst.h |  3 ++
 arch/loongarch/kernel/inst.c      | 57 +++++++++++++++++++++++++++++++
 2 files changed, 60 insertions(+)

diff --git a/arch/loongarch/include/asm/inst.h b/arch/loongarch/include/asm/inst.h
index 3089785ca..88bb73e46 100644
--- a/arch/loongarch/include/asm/inst.h
+++ b/arch/loongarch/include/asm/inst.h
@@ -497,6 +497,7 @@ void arch_simulate_insn(union loongarch_instruction insn, struct pt_regs *regs);
 int larch_insn_read(void *addr, u32 *insnp);
 int larch_insn_write(void *addr, u32 insn);
 int larch_insn_patch_text(void *addr, u32 insn);
+int larch_insn_text_copy(void *dst, void *src, size_t len);
 
 u32 larch_insn_gen_nop(void);
 u32 larch_insn_gen_b(unsigned long pc, unsigned long dest);
@@ -511,6 +512,8 @@ u32 larch_insn_gen_lu12iw(enum loongarch_gpr rd, int imm);
 u32 larch_insn_gen_lu32id(enum loongarch_gpr rd, int imm);
 u32 larch_insn_gen_lu52id(enum loongarch_gpr rd, enum loongarch_gpr rj, int imm);
 u32 larch_insn_gen_jirl(enum loongarch_gpr rd, enum loongarch_gpr rj, int imm);
+u32 larch_insn_gen_beq(enum loongarch_gpr rd, enum loongarch_gpr rj, int imm);
+u32 larch_insn_gen_bne(enum loongarch_gpr rd, enum loongarch_gpr rj, int imm);
 
 static inline bool signed_imm_check(long val, unsigned int bit)
 {
diff --git a/arch/loongarch/kernel/inst.c b/arch/loongarch/kernel/inst.c
index 14d7d700b..7423b0772 100644
--- a/arch/loongarch/kernel/inst.c
+++ b/arch/loongarch/kernel/inst.c
@@ -4,6 +4,7 @@
  */
 #include <linux/sizes.h>
 #include <linux/uaccess.h>
+#include <linux/set_memory.h>
 
 #include <asm/cacheflush.h>
 #include <asm/inst.h>
@@ -218,6 +219,34 @@ int larch_insn_patch_text(void *addr, u32 insn)
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
+	return ret;
+}
+
 u32 larch_insn_gen_nop(void)
 {
 	return INSN_NOP;
@@ -336,3 +365,31 @@ u32 larch_insn_gen_jirl(enum loongarch_gpr rd, enum loongarch_gpr rj, int imm)
 
 	return insn.word;
 }
+
+u32 larch_insn_gen_beq(enum loongarch_gpr rd, enum loongarch_gpr rj, int imm)
+{
+	union loongarch_instruction insn;
+
+	if ((imm & 3) || imm < -SZ_128K || imm >= SZ_128K) {
+		pr_warn("The generated beq instruction is out of range.\n");
+		return INSN_BREAK;
+	}
+
+	emit_beq(&insn, rd, rj, imm >> 2);
+
+	return insn.word;
+}
+
+u32 larch_insn_gen_bne(enum loongarch_gpr rd, enum loongarch_gpr rj, int imm)
+{
+	union loongarch_instruction insn;
+
+	if ((imm & 3) || imm < -SZ_128K || imm >= SZ_128K) {
+		pr_warn("The generated bne instruction is out of range.\n");
+		return INSN_BREAK;
+	}
+
+	emit_bne(&insn, rj, rd, imm >> 2);
+
+	return insn.word;
+}
-- 
2.43.0


