Return-Path: <bpf+bounces-76703-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ED898CC1DE0
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 10:52:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 85D49305A13A
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 09:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C900D339B56;
	Tue, 16 Dec 2025 09:50:42 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8A4313E2D;
	Tue, 16 Dec 2025 09:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765878642; cv=none; b=LJATjcQEufWzsrUjYwdz70xBQi6e+Nsg8XRvdhOM8S6bSoPZ/J400rWlj/a459q963l2TW34hnHs3j1liyJRp262rRZqwNmmO0QNPSQCrEjlRIUL70KKQoTNu1tOxUU7AQ8BUF41VQDpgERJ28IKUS2OWZ5C7GatB35XxC9nSmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765878642; c=relaxed/simple;
	bh=tU2Ew/8f8l3eRFev3SbH6t3r77IiSGfnF9k/LCo5GLg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sKNAFHsFG6Aa45uKd4PhOMjr1+BYstZkMu+TsfcWJypXOQ4CCqdEKIbfEAKYPSdWzowBiTceiNI7jbusnyqTL4SbXz51xq+7t/1N+w9aTJBZMMqsyGmAUb7RomLhHLtB2E4IF8/e+Mi/+5u3edxIzx1kU/tthHL/GntlCdsMCL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: aaa6b2a2da6411f0a38c85956e01ac42-20251216
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NO_NAME, HR_CTE_8B, HR_CTT_TXT
	HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME, HR_SJ_DIGIT_LEN
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME
	IP_UNTRUSTED, SRC_UNTRUSTED, IP_UNFAMILIAR, SRC_UNFAMILIAR, DN_TRUSTED
	SRC_TRUSTED, SA_EXISTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS
	DMARC_NOPASS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:dabe2fa3-4d8f-45db-9be3-fd6d8183aa66,IP:10,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:5
X-CID-INFO: VERSION:1.3.6,REQID:dabe2fa3-4d8f-45db-9be3-fd6d8183aa66,IP:10,URL
	:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:5
X-CID-META: VersionHash:a9d874c,CLOUDID:2e19a55a483969397a154d5d6ddaf7da,BulkI
	D:251216175036XRN5FI7L,BulkQuantity:0,Recheck:0,SF:17|19|38|66|78|81|82|10
	2|127|850|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bu
	lk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:
	0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: aaa6b2a2da6411f0a38c85956e01ac42-20251216
X-User: duanchenghao@kylinos.cn
Received: from localhost.localdomain [(183.242.174.21)] by mailgw.kylinos.cn
	(envelope-from <duanchenghao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1054710599; Tue, 16 Dec 2025 17:50:34 +0800
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
Subject: [PATCH v3 2/4] LoongArch: Enable exception fixup for specific ADE subcode
Date: Tue, 16 Dec 2025 17:47:51 +0800
Message-Id: <20251216094753.1317231-3-duanchenghao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251216094753.1317231-1-duanchenghao@kylinos.cn>
References: <20251216094753.1317231-1-duanchenghao@kylinos.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patch allows the LoongArch BPF JIT to handle recoverable memory
access errors generated by BPF_PROBE_MEM* instructions.

When a BPF program performs memory access operations, the instructions
it executes may trigger ADEM exceptions. The kernel’s built-in BPF
exception table mechanism (EX_TYPE_BPF) will generate corresponding
exception fixup entries in the JIT compilation phase; however, the
architecture-specific trap handling function needs to proactively call
the common fixup routine to achieve exception recovery.

do_ade(): fix EX_TYPE_BPF memory access exceptions for BPF programs,
ensure safe execution.

Signed-off-by: Chenghao Duan <duanchenghao@kylinos.cn>
---
 arch/loongarch/kernel/traps.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/loongarch/kernel/traps.c b/arch/loongarch/kernel/traps.c
index 004b8ebf0051..201c9a5532f4 100644
--- a/arch/loongarch/kernel/traps.c
+++ b/arch/loongarch/kernel/traps.c
@@ -534,11 +534,18 @@ asmlinkage void noinstr do_fpe(struct pt_regs *regs, unsigned long fcsr)
 
 asmlinkage void noinstr do_ade(struct pt_regs *regs)
 {
-	irqentry_state_t state = irqentry_enter(regs);
+	irqentry_state_t state;
+	unsigned int esubcode = FIELD_GET(CSR_ESTAT_ESUBCODE, regs->csr_estat);
+
+	state = irqentry_enter(regs);
+
+	if ((esubcode == EXSUBCODE_ADEM) && fixup_exception(regs))
+		goto out;
 
 	die_if_kernel("Kernel ade access", regs);
 	force_sig_fault(SIGBUS, BUS_ADRERR, (void __user *)regs->csr_badvaddr);
 
+out:
 	irqentry_exit(regs, state);
 }
 
-- 
2.25.1


