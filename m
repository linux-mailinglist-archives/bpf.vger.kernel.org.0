Return-Path: <bpf+bounces-60899-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 993BCADE965
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 12:51:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 472957AB742
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 10:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A31042857C9;
	Wed, 18 Jun 2025 10:51:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F60C281508;
	Wed, 18 Jun 2025 10:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750243882; cv=none; b=CubfSdBnVCIOLrpZ7gnCwI5YTljuUSct6DGvHx7lwXBen6Le3HPlP+UEV8raL9akFZZgCzl6IsZD75PoLXE25UpiqLtJ39Tdk+cDFZqOMCd8scYGaJPr2xCdTGst/ug4pN2DxZz5PADd+i5CxYwZyf8VgmtCZwNLrqA9oTxJjjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750243882; c=relaxed/simple;
	bh=fUFyXWZ8Nho6a3FbbDgw0Dos+ahz3ghs6GFziTuJ604=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cB8G8nPTCg9mq2NbJL9m9N3KrMvRYUxvDikLBTAvn+3OFB2qZf8x10o9K4p/KhYgxRHOT82shVJbIgWyFi9ECawb2Twr6OrtosniXgr6L9iCp6cS93TQqIUWDveynCxFBHFRhGghIUI5rbrcZ9ZMGOZkT3KS9HV4HHlpzj6ktSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 279a1f904c3211f0b29709d653e92f7d-20250618
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NO_NAME, HR_CTE_8B, HR_CTT_MISS
	HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME, HR_SJ_DIGIT_LEN
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME
	IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_EXISTED, SN_EXISTED
	SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, CIE_BAD, CIE_GOOD
	CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO, GTI_C_BU, AMN_T1
	AMN_GOOD, AMN_C_TI, AMN_C_BU, ABX_MISS_RDNS
X-CID-CACHE: Type:Local,Time:202506181848+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:502ec6b0-8846-4386-b2ab-f87ae7485496,IP:10,
	URL:0,TC:0,Content:0,EDM:-30,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,AC
	TION:release,TS:-35
X-CID-INFO: VERSION:1.1.45,REQID:502ec6b0-8846-4386-b2ab-f87ae7485496,IP:10,UR
	L:0,TC:0,Content:0,EDM:-30,RT:0,SF:-15,FILE:0,BULK:0,RULE:EDM_GN8D19FE,ACT
	ION:release,TS:-35
X-CID-META: VersionHash:6493067,CLOUDID:cb775d0c997507a316e4d70106dc82cf,BulkI
	D:25061818481409KWSERW,BulkQuantity:0,Recheck:0,SF:17|19|24|44|66|78|81|82
	|102,TC:nil,Content:0|50,EDM:2,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil
	,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,TF_CID_SPAM_SNR,TF_CID_SPAM_FAS
X-UUID: 279a1f904c3211f0b29709d653e92f7d-20250618
X-User: duanchenghao@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <duanchenghao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1687231276; Wed, 18 Jun 2025 18:51:14 +0800
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
	jianghaoran@kylinos.cn
Subject: [PATCH v2 2/4] LoongArch: BPF: Add bpf_arch_text_poke support for Loongarch
Date: Wed, 18 Jun 2025 18:50:46 +0800
Message-Id: <20250618105048.1510560-3-duanchenghao@kylinos.cn>
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

Implement the bpf_arch_text_poke function for the LoongArch
architecture. On LoongArch, since symbol addresses in the direct mapping
region cannot be reached via relative jump instructions from the paged
mapping region, we use the move_imm+jirl instruction pair as absolute
jump instructions. These require 2-5 instructions, so we reserve 5 NOP
instructions in the program as placeholders for function jumps.

Co-developed-by: George Guo <guodongtai@kylinos.cn>
Signed-off-by: George Guo <guodongtai@kylinos.cn>
Signed-off-by: Chenghao Duan <duanchenghao@kylinos.cn>
---
 arch/loongarch/net/bpf_jit.c | 62 ++++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
index fa1500d4a..24332c596 100644
--- a/arch/loongarch/net/bpf_jit.c
+++ b/arch/loongarch/net/bpf_jit.c
@@ -4,6 +4,7 @@
  *
  * Copyright (C) 2022 Loongson Technology Corporation Limited
  */
+#include <linux/memory.h>
 #include "bpf_jit.h"
 
 #define REG_TCC		LOONGARCH_GPR_A6
@@ -1359,3 +1360,64 @@ bool bpf_jit_supports_subprog_tailcalls(void)
 {
 	return true;
 }
+
+static int emit_jump_and_link(struct jit_ctx *ctx, u8 rd, u64 ip, u64 target)
+{
+	s64 offset = (s64)(target - ip);
+
+	if (offset && (offset >= -SZ_128M && offset < SZ_128M)) {
+		emit_insn(ctx, bl, offset >> 2);
+	} else {
+		move_imm(ctx, LOONGARCH_GPR_T1, target, false);
+		emit_insn(ctx, jirl, rd, LOONGARCH_GPR_T1, 0);
+	}
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
+				  (unsigned long)ip, (unsigned long)target);
+}
+
+int bpf_arch_text_poke(void *ip, enum bpf_text_poke_type poke_type,
+		       void *old_addr, void *new_addr)
+{
+	u32 old_insns[5] = {[0 ... 4] = INSN_NOP};
+	u32 new_insns[5] = {[0 ... 4] = INSN_NOP};
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
+	if (memcmp(ip, old_insns, 5 * 4))
+		return -EFAULT;
+
+	ret = gen_jump_or_nops(new_addr, ip, new_insns, is_call);
+	if (ret)
+		return ret;
+
+	mutex_lock(&text_mutex);
+	if (memcmp(ip, new_insns, 5 * 4))
+		ret = larch_insn_text_copy(ip, new_insns, 5 * 4);
+	mutex_unlock(&text_mutex);
+	return ret;
+}
-- 
2.43.0


