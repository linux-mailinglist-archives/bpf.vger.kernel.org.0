Return-Path: <bpf+bounces-76705-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BBD5FCC1DCB
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 10:51:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 939313026BCF
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 09:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06FDD33A710;
	Tue, 16 Dec 2025 09:51:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77B133A6FE;
	Tue, 16 Dec 2025 09:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765878681; cv=none; b=hlGN3I/ofOydqtaqURlkKhcnX3xBrCmIUL9wS5tj1F55nhtG/D2AuXQV8A891WnlgpZP4pghM4q9EMDXkTBp43IlWK+G9pHiuYCcjK5q6sShFmtrV1/l4FcURx8wvSY4LvhPAbSr1n+JdprP8DJ/xV+ecLVIEPavXLlZYm6la1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765878681; c=relaxed/simple;
	bh=vcsI2v6tuVS1NUqaNOyqrqhvoG2fZA6wSDcFkwLFsWs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=n5HtFcv5YlvYeCk5VidUsFWy5YmrYvGaNUCFS43Gedoh6kQaGl9llaM0ofdQTrjL6Tsl+cgAGhoZovY/fo6X0RRekUn/sY2bcG/9TTuP9Gi6lF5vgKpXG1owDNF+guleol6VwoKBHNJ58fqlV7Jd2J1UAbxCgIE52BsmOGLNII4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: c0901a5eda6411f0a38c85956e01ac42-20251216
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_UNTRUSTED, SRC_UNTRUSTED, IP_UNFAMILIAR, SRC_UNFAMILIAR
	DN_TRUSTED, SRC_TRUSTED, SA_EXISTED, SN_EXISTED, SPF_NOPASS
	DKIM_NOPASS, DMARC_NOPASS, CIE_BAD, CIE_GOOD_SPF, CIE_UNKNOWN
	GTI_FG_BS, GTI_RG_INFO, GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:79810aac-3fe4-4b6e-82b6-3519e4f6305c,IP:10,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:5
X-CID-INFO: VERSION:1.3.6,REQID:79810aac-3fe4-4b6e-82b6-3519e4f6305c,IP:10,URL
	:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:5
X-CID-META: VersionHash:a9d874c,CLOUDID:8ca50ba58714037dc20ba792347d2749,BulkI
	D:251212171126DK7G45J0,BulkQuantity:2,Recheck:0,SF:17|19|38|66|78|81|82|10
	2|127|850|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bu
	lk:41,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0
	,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: c0901a5eda6411f0a38c85956e01ac42-20251216
X-User: duanchenghao@kylinos.cn
Received: from localhost.localdomain [(183.242.174.21)] by mailgw.kylinos.cn
	(envelope-from <duanchenghao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1587119060; Tue, 16 Dec 2025 17:51:11 +0800
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
	linux-trace-kernel@vger.kernel.org,
	Youling Tang <tangyouling@kylinos.cn>
Subject: [PATCH v3 4/4] LoongArch: ftrace: Adjust register stack restore order in direct call trampolines
Date: Tue, 16 Dec 2025 17:47:53 +0800
Message-Id: <20251216094753.1317231-5-duanchenghao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251216094753.1317231-1-duanchenghao@kylinos.cn>
References: <20251216094753.1317231-1-duanchenghao@kylinos.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Ensure that in the ftrace direct call logic, the CPU register state
(with ra = parent return address) is restored to the correct state
after the execution of the custom trampoline function and before
returning to the traced function. Additionally, guarantee the
correctness of the jump logic for jr t0 (traced function address).

Reported-by: Youling Tang <tangyouling@kylinos.cn>
Signed-off-by: Chenghao Duan <duanchenghao@kylinos.cn>
---
 samples/ftrace/ftrace-direct-modify.c       | 8 ++++----
 samples/ftrace/ftrace-direct-multi-modify.c | 8 ++++----
 samples/ftrace/ftrace-direct-multi.c        | 4 ++--
 samples/ftrace/ftrace-direct-too.c          | 4 ++--
 samples/ftrace/ftrace-direct.c              | 4 ++--
 5 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/samples/ftrace/ftrace-direct-modify.c b/samples/ftrace/ftrace-direct-modify.c
index da3a9f2091f5..1ba1927b548e 100644
--- a/samples/ftrace/ftrace-direct-modify.c
+++ b/samples/ftrace/ftrace-direct-modify.c
@@ -176,8 +176,8 @@ asm (
 "	st.d	$t0, $sp, 0\n"
 "	st.d	$ra, $sp, 8\n"
 "	bl	my_direct_func1\n"
-"	ld.d	$t0, $sp, 0\n"
-"	ld.d	$ra, $sp, 8\n"
+"	ld.d	$ra, $sp, 0\n"
+"	ld.d	$t0, $sp, 8\n"
 "	addi.d	$sp, $sp, 16\n"
 "	jr	$t0\n"
 "	.size		my_tramp1, .-my_tramp1\n"
@@ -189,8 +189,8 @@ asm (
 "	st.d	$t0, $sp, 0\n"
 "	st.d	$ra, $sp, 8\n"
 "	bl	my_direct_func2\n"
-"	ld.d	$t0, $sp, 0\n"
-"	ld.d	$ra, $sp, 8\n"
+"	ld.d	$ra, $sp, 0\n"
+"	ld.d	$t0, $sp, 8\n"
 "	addi.d	$sp, $sp, 16\n"
 "	jr	$t0\n"
 "	.size		my_tramp2, .-my_tramp2\n"
diff --git a/samples/ftrace/ftrace-direct-multi-modify.c b/samples/ftrace/ftrace-direct-multi-modify.c
index 8f7986d698d8..7a7822dfeb50 100644
--- a/samples/ftrace/ftrace-direct-multi-modify.c
+++ b/samples/ftrace/ftrace-direct-multi-modify.c
@@ -199,8 +199,8 @@ asm (
 "	move	$a0, $t0\n"
 "	bl	my_direct_func1\n"
 "	ld.d	$a0, $sp, 0\n"
-"	ld.d	$t0, $sp, 8\n"
-"	ld.d	$ra, $sp, 16\n"
+"	ld.d	$ra, $sp, 8\n"
+"	ld.d	$t0, $sp, 16\n"
 "	addi.d	$sp, $sp, 32\n"
 "	jr	$t0\n"
 "	.size		my_tramp1, .-my_tramp1\n"
@@ -215,8 +215,8 @@ asm (
 "	move	$a0, $t0\n"
 "	bl	my_direct_func2\n"
 "	ld.d	$a0, $sp, 0\n"
-"	ld.d	$t0, $sp, 8\n"
-"	ld.d	$ra, $sp, 16\n"
+"	ld.d	$ra, $sp, 8\n"
+"	ld.d	$t0, $sp, 16\n"
 "	addi.d	$sp, $sp, 32\n"
 "	jr	$t0\n"
 "	.size		my_tramp2, .-my_tramp2\n"
diff --git a/samples/ftrace/ftrace-direct-multi.c b/samples/ftrace/ftrace-direct-multi.c
index db326c81a27d..3fe6ddaf0b69 100644
--- a/samples/ftrace/ftrace-direct-multi.c
+++ b/samples/ftrace/ftrace-direct-multi.c
@@ -131,8 +131,8 @@ asm (
 "	move	$a0, $t0\n"
 "	bl	my_direct_func\n"
 "	ld.d	$a0, $sp, 0\n"
-"	ld.d	$t0, $sp, 8\n"
-"	ld.d	$ra, $sp, 16\n"
+"	ld.d	$ra, $sp, 8\n"
+"	ld.d	$t0, $sp, 16\n"
 "	addi.d	$sp, $sp, 32\n"
 "	jr	$t0\n"
 "	.size		my_tramp, .-my_tramp\n"
diff --git a/samples/ftrace/ftrace-direct-too.c b/samples/ftrace/ftrace-direct-too.c
index 3d0fa260332d..bf2411aa6fd7 100644
--- a/samples/ftrace/ftrace-direct-too.c
+++ b/samples/ftrace/ftrace-direct-too.c
@@ -143,8 +143,8 @@ asm (
 "	ld.d	$a0, $sp, 0\n"
 "	ld.d	$a1, $sp, 8\n"
 "	ld.d	$a2, $sp, 16\n"
-"	ld.d	$t0, $sp, 24\n"
-"	ld.d	$ra, $sp, 32\n"
+"	ld.d	$ra, $sp, 24\n"
+"	ld.d	$t0, $sp, 32\n"
 "	addi.d	$sp, $sp, 48\n"
 "	jr	$t0\n"
 "	.size		my_tramp, .-my_tramp\n"
diff --git a/samples/ftrace/ftrace-direct.c b/samples/ftrace/ftrace-direct.c
index 956834b0d19a..5368c8c39cbb 100644
--- a/samples/ftrace/ftrace-direct.c
+++ b/samples/ftrace/ftrace-direct.c
@@ -124,8 +124,8 @@ asm (
 "	st.d	$ra, $sp, 16\n"
 "	bl	my_direct_func\n"
 "	ld.d	$a0, $sp, 0\n"
-"	ld.d	$t0, $sp, 8\n"
-"	ld.d	$ra, $sp, 16\n"
+"	ld.d	$ra, $sp, 8\n"
+"	ld.d	$t0, $sp, 16\n"
 "	addi.d	$sp, $sp, 32\n"
 "	jr	$t0\n"
 "	.size		my_tramp, .-my_tramp\n"
-- 
2.25.1


