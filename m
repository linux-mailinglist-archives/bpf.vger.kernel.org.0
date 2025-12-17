Return-Path: <bpf+bounces-76824-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 62662CC63E9
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 07:27:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 24C1830FB54E
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 06:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 234D02E92C3;
	Wed, 17 Dec 2025 06:14:59 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617E22DAFAF;
	Wed, 17 Dec 2025 06:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765952098; cv=none; b=Zk4E6OfbnNbUr8wWZ8FLYiXI0PWhYs85oh49FY6JbtFb+lCvMT6kof75sRCQiDZf02tiTvHHciXIw+BMSHda0klRVxoQmSyuAuvOmdis3K7ZuWn9IaCbDgaG5eGwn7GpHnkdVE7Lgis71BjbEPMq7Sh4dtbw34wEO8psvsucZn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765952098; c=relaxed/simple;
	bh=wZLOMETjgoJ2dGINqkm2V8I5bmIvypzJ/UXmJA+ST2I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qqSQEberkUSZPsiqs/Qry/yAoN04gxBqh47WsDI+ibphItSxWDmxs9c7rC9Po/h2hSPqK4hf6mv1GTuGH0yym0p4tsaFOuKwEckCkm/5hhAZ/PJmBnPIfpPav41YkanE9lM23BYUaDpWCzdbqs2EHM68SXtKKKfC6fRcus61oE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: b17e2dc0db0f11f0a38c85956e01ac42-20251217
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
X-CID-O-INFO: VERSION:1.3.6,REQID:54636725-8111-4a94-bf27-e8707e41cefc,IP:10,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:5
X-CID-INFO: VERSION:1.3.6,REQID:54636725-8111-4a94-bf27-e8707e41cefc,IP:10,URL
	:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:5
X-CID-META: VersionHash:a9d874c,CLOUDID:ba6e0229970adc7d7e96f99048600b0c,BulkI
	D:2512171414511WY777SV,BulkQuantity:0,Recheck:0,SF:17|19|38|66|78|81|82|10
	2|127|850|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bu
	lk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:
	0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: b17e2dc0db0f11f0a38c85956e01ac42-20251217
X-User: duanchenghao@kylinos.cn
Received: from localhost.localdomain [(183.242.174.20)] by mailgw.kylinos.cn
	(envelope-from <duanchenghao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1517111480; Wed, 17 Dec 2025 14:14:49 +0800
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
Subject: [PATCH v4 4/7] LoongArch: BPF: Save return address register ra to t0 before trampoline
Date: Wed, 17 Dec 2025 14:14:32 +0800
Message-Id: <20251217061435.802204-5-duanchenghao@kylinos.cn>
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

Modify the build_prologue function to ensure the return address
register ra is saved to t0 before entering trampoline operations.
This change ensures accurate return address handling when a BPF
program calls another BPF program, preventing errors in the
BPF-to-BPF call chain.

Signed-off-by: Chenghao Duan <duanchenghao@kylinos.cn>
---
 arch/loongarch/net/bpf_jit.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
index 76cd24646bec..c560d1e14b9d 100644
--- a/arch/loongarch/net/bpf_jit.c
+++ b/arch/loongarch/net/bpf_jit.c
@@ -139,6 +139,7 @@ static void build_prologue(struct jit_ctx *ctx)
 	stack_adjust = round_up(stack_adjust, 16);
 	stack_adjust += bpf_stack_adjust;
 
+	move_reg(ctx, LOONGARCH_GPR_T0, LOONGARCH_GPR_RA);
 	/* Reserve space for the move_imm + jirl instruction */
 	for (i = 0; i < LOONGARCH_LONG_JUMP_NINSNS; i++)
 		emit_insn(ctx, nop);
-- 
2.25.1


