Return-Path: <bpf+bounces-76523-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A6C18CB8686
	for <lists+bpf@lfdr.de>; Fri, 12 Dec 2025 10:17:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5F84F30BD1F7
	for <lists+bpf@lfdr.de>; Fri, 12 Dec 2025 09:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 256F531280E;
	Fri, 12 Dec 2025 09:11:19 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0962D47FA;
	Fri, 12 Dec 2025 09:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765530678; cv=none; b=lD2AvAYKbgoTDuC/+A+ljkfx0zyBymKt1HmSHjpCrLAkUeCUtN5+MutGfUeX2E3rMaQqRcLd6DeUO/VjJ1MfxeNtZu5NpYBSURrRdlLX0C+oS5h/y0F4HvF3/nR8sXgzW4K4gOKymGMihCZJjoJWdoR2ODu5dzGn7pd8XYKtHOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765530678; c=relaxed/simple;
	bh=Zfloy8I/PvvV0GgsACcj4Xioz0vOdmYRRY1dbRe0Cjk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sPIV9Ly0cUsfeSr7mT2+aj98YqjU4Yijnto+Ac/c8fddRvVZplKA7lg/RmqQK0b2oKbjj4GMDfZRH0SBWrDtfibz2nFXC8XfGMRme0TJN+sV0fkELluZJ1SpUzQj/VTb6wGicH95cAAwm0KFut+xUKvA77FWIaxTt/SQJcKcaSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 7fb7c50ed73a11f0a38c85956e01ac42-20251212
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NO_NAME, HR_CTE_8B, HR_CTT_MISS
	HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME, HR_SJ_DIGIT_LEN
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME
	IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_EXISTED, SN_EXISTED
	SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:1f5bd522-664d-46f1-9089-86b742ead0e0,IP:10,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:5
X-CID-INFO: VERSION:1.3.6,REQID:1f5bd522-664d-46f1-9089-86b742ead0e0,IP:10,URL
	:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:5
X-CID-META: VersionHash:a9d874c,CLOUDID:69ef054c3d323e05a89e8c12dd9cf042,BulkI
	D:251212171111BX2VBL8B,BulkQuantity:0,Recheck:0,SF:17|19|38|66|78|81|82|10
	2|127|850|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bu
	lk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:
	0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 7fb7c50ed73a11f0a38c85956e01ac42-20251212
X-User: duanchenghao@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <duanchenghao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 500678761; Fri, 12 Dec 2025 17:11:09 +0800
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
Subject: [PATCH v2 1/4] LoongArch: ftrace: Refactor register restoration in ftrace_common_return
Date: Fri, 12 Dec 2025 17:11:00 +0800
Message-Id: <20251212091103.1247753-2-duanchenghao@kylinos.cn>
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

Refactor the register restoration sequence in the ftrace_common_return
function to clearly distinguish between the logic of normal returns and
direct call returns in function tracing scenarios. The logic is as
follows:
1. In the case of a normal return, the execution flow returns to the
traced function, and ftrace must ensure that the register data is
consistent with the state when the function was entered.
ra = parent return address; t0 = traced function return address.

2. In the case of a direct call return, the execution flow jumps to the
custom trampoline function, and ftrace must ensure that the register
data is consistent with the state when ftrace was entered.
ra = traced function return address; t0 = parent return address.

Fixes: 9cdc3b6a299c ("LoongArch: ftrace: Add direct call support")
Signed-off-by: Chenghao Duan <duanchenghao@kylinos.cn>
---
 arch/loongarch/kernel/mcount_dyn.S | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/loongarch/kernel/mcount_dyn.S b/arch/loongarch/kernel/mcount_dyn.S
index d6b474ad1d5e..5729c20e5b8b 100644
--- a/arch/loongarch/kernel/mcount_dyn.S
+++ b/arch/loongarch/kernel/mcount_dyn.S
@@ -94,7 +94,6 @@ SYM_INNER_LABEL(ftrace_graph_call, SYM_L_GLOBAL)
  * at the callsite, so there is no need to restore the T series regs.
  */
 ftrace_common_return:
-	PTR_L		ra, sp, PT_R1
 	PTR_L		a0, sp, PT_R4
 	PTR_L		a1, sp, PT_R5
 	PTR_L		a2, sp, PT_R6
@@ -104,12 +103,17 @@ ftrace_common_return:
 	PTR_L		a6, sp, PT_R10
 	PTR_L		a7, sp, PT_R11
 	PTR_L		fp, sp, PT_R22
-	PTR_L		t0, sp, PT_ERA
 	PTR_L		t1, sp, PT_R13
-	PTR_ADDI	sp, sp, PT_SIZE
 	bnez		t1, .Ldirect
+
+	PTR_L		ra, sp, PT_R1
+	PTR_L		t0, sp, PT_ERA
+	PTR_ADDI	sp, sp, PT_SIZE
 	jr		t0
 .Ldirect:
+	PTR_L		t0, sp, PT_R1
+	PTR_L		ra, sp, PT_ERA
+	PTR_ADDI	sp, sp, PT_SIZE
 	jr		t1
 SYM_CODE_END(ftrace_common)
 
@@ -161,6 +165,8 @@ SYM_CODE_END(return_to_handler)
 #ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
 SYM_CODE_START(ftrace_stub_direct_tramp)
 	UNWIND_HINT_UNDEFINED
-	jr		t0
+	move		t1, ra
+	move		ra, t0
+	jr		t1
 SYM_CODE_END(ftrace_stub_direct_tramp)
 #endif /* CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS */
-- 
2.25.1


