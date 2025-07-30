Return-Path: <bpf+bounces-64700-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD972B1612C
	for <lists+bpf@lfdr.de>; Wed, 30 Jul 2025 15:15:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E38C7A7EAC
	for <lists+bpf@lfdr.de>; Wed, 30 Jul 2025 13:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9337A29ACCB;
	Wed, 30 Jul 2025 13:13:34 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2539F293C6C;
	Wed, 30 Jul 2025 13:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753881214; cv=none; b=BR4qG56GcKao9t9txXQkWMRQWhNmhbafbx7/lmjzoCK7faEK5W/uo7C9HMQc00lKfkYcbl2ep3uUHf6Zr9XgCGHii0BioQdYwcxe+LVFqI/sIUtuh3U+KrpS4AXdSGzoxlxqn0WDWpZErOTn5dOWwY+HPJdmJrRiB8ls0gUA+f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753881214; c=relaxed/simple;
	bh=LUMOlBxRpVSF/DaA7+L6uY0i/NbsiEchRZqGxHIdjHg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pBG24456jzTBldR2G+iO1FUus3na875xGsw+4WbPwlkqxnQgl/9P/8h1mxoo+deyzvD4crH7hY1W8PJ6GUsjW1xYXB6KDrQdKXSBIMpLcmR8J0rzEnT9cmYrvouVMsrzmjL21e9l8TrFoQBIvt7wZTCXHcCtB3Sy1qHf3gCW9VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: f70674b06d4611f0b29709d653e92f7d-20250730
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_EXISTED
	SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, CIE_BAD
	CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO, GTI_C_BU, AMN_T1
	AMN_GOOD, AMN_C_TI, AMN_C_BU, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:6acf9f90-2011-4819-9da4-6cd2ce9c47e8,IP:15,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:0
X-CID-INFO: VERSION:1.1.45,REQID:6acf9f90-2011-4819-9da4-6cd2ce9c47e8,IP:15,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:780eeee6487f9fb36ecea225df88561c,BulkI
	D:2507302113222L4W0OVG,BulkQuantity:0,Recheck:0,SF:17|19|24|38|44|66|78|81
	|82|102,TC:nil,Content:0|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS
	:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,A
	RC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,TF_CID_SPAM_SNR
X-UUID: f70674b06d4611f0b29709d653e92f7d-20250730
X-User: duanchenghao@kylinos.cn
Received: from localhost.localdomain [(116.128.244.171)] by mailgw.kylinos.cn
	(envelope-from <duanchenghao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1963060957; Wed, 30 Jul 2025 21:13:20 +0800
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
	geliang@kernel.org,
	Youling Tang <tangyouling@kylinos.cn>
Subject: [PATCH v5 1/5] LoongArch: Add larch_insn_gen_{beq,bne} helpers
Date: Wed, 30 Jul 2025 21:12:53 +0800
Message-Id: <20250730131257.124153-2-duanchenghao@kylinos.cn>
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

Add larch_insn_gen_beq() and larch_insn_gen_bne() helpers which will
be used in BPF trampoline implementation.

Co-developed-by: George Guo <guodongtai@kylinos.cn>
Signed-off-by: George Guo <guodongtai@kylinos.cn>
Co-developed-by: Youling Tang <tangyouling@kylinos.cn>
Signed-off-by: Youling Tang <tangyouling@kylinos.cn>
Signed-off-by: Chenghao Duan <duanchenghao@kylinos.cn>
---
 arch/loongarch/include/asm/inst.h |  2 ++
 arch/loongarch/kernel/inst.c      | 28 ++++++++++++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/arch/loongarch/include/asm/inst.h b/arch/loongarch/include/asm/inst.h
index 3089785ca..2ae96a35d 100644
--- a/arch/loongarch/include/asm/inst.h
+++ b/arch/loongarch/include/asm/inst.h
@@ -511,6 +511,8 @@ u32 larch_insn_gen_lu12iw(enum loongarch_gpr rd, int imm);
 u32 larch_insn_gen_lu32id(enum loongarch_gpr rd, int imm);
 u32 larch_insn_gen_lu52id(enum loongarch_gpr rd, enum loongarch_gpr rj, int imm);
 u32 larch_insn_gen_jirl(enum loongarch_gpr rd, enum loongarch_gpr rj, int imm);
+u32 larch_insn_gen_beq(enum loongarch_gpr rd, enum loongarch_gpr rj, int imm);
+u32 larch_insn_gen_bne(enum loongarch_gpr rd, enum loongarch_gpr rj, int imm);
 
 static inline bool signed_imm_check(long val, unsigned int bit)
 {
diff --git a/arch/loongarch/kernel/inst.c b/arch/loongarch/kernel/inst.c
index 14d7d700b..674e3b322 100644
--- a/arch/loongarch/kernel/inst.c
+++ b/arch/loongarch/kernel/inst.c
@@ -336,3 +336,31 @@ u32 larch_insn_gen_jirl(enum loongarch_gpr rd, enum loongarch_gpr rj, int imm)
 
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
+	emit_beq(&insn, rj, rd, imm >> 2);
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
2.25.1


