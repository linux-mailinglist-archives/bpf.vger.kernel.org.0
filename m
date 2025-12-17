Return-Path: <bpf+bounces-76828-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7956DCC6406
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 07:30:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 72EA7312EC85
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 06:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 799EA2DC792;
	Wed, 17 Dec 2025 06:15:03 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 798ED2EB872;
	Wed, 17 Dec 2025 06:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765952103; cv=none; b=ovlSWCZtCZ5uspIlxzpVYveygMKEHstN6RACrE6RIabmv2Tz3AkvIDkYuU5++tMZyyATXODeyJY03+jc8L0ONvVnxZRQvczFe+F0rlmJHOUbw5h6SE23jp9Jd75rwXOWkP9dm0z68MVwF0McwggXONRAVn13PFY8BL+s3VUoNIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765952103; c=relaxed/simple;
	bh=WLDcyUQpfa0qKW1T1Zd8X2+eNMhk9ImYjFtpapGBMWU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=trHSZX/4pbIt6mC0JaA605iOVveY5avEWYg4Fp69RDglcPP81MsENo6vcnVL9F42O07Qvqy/R0DBVcpIANb5/20kapiEf5vnWeK9JK4Pl6ymCGoZYxeLCaqcOWdYUOG3Lb7GSbHXw4KdC85FBU4Nc0gpEWNB82930m8LbA2MWEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: b45ccc7cdb0f11f0a38c85956e01ac42-20251217
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
X-CID-O-INFO: VERSION:1.3.6,REQID:66f060b5-49c3-4c94-be10-6e82ec42ed6f,IP:10,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:5
X-CID-INFO: VERSION:1.3.6,REQID:66f060b5-49c3-4c94-be10-6e82ec42ed6f,IP:10,URL
	:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:5
X-CID-META: VersionHash:a9d874c,CLOUDID:9ed4d91d2c7b25ac4dd7b7b3ed3762e8,BulkI
	D:251217141457MPWBEX6H,BulkQuantity:0,Recheck:0,SF:17|19|38|66|78|81|82|10
	2|127|850|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bu
	lk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:
	0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: b45ccc7cdb0f11f0a38c85956e01ac42-20251217
X-User: duanchenghao@kylinos.cn
Received: from localhost.localdomain [(183.242.174.20)] by mailgw.kylinos.cn
	(envelope-from <duanchenghao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 612073974; Wed, 17 Dec 2025 14:14:54 +0800
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
Subject: [PATCH v4 6/7] LoongArch: BPF: Enhance the bpf_arch_text_poke() function
Date: Wed, 17 Dec 2025 14:14:34 +0800
Message-Id: <20251217061435.802204-7-duanchenghao@kylinos.cn>
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

Enhance the bpf_arch_text_poke() function to enable accurate location
of BPF program entry points.

When modifying the entry point of a BPF program, skip the move t0, ra
instruction to ensure the correct logic and copy of the jump address.

Signed-off-by: Chenghao Duan <duanchenghao@kylinos.cn>
---
 arch/loongarch/net/bpf_jit.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
index 3dbabacc8856..0c16a1b18e8f 100644
--- a/arch/loongarch/net/bpf_jit.c
+++ b/arch/loongarch/net/bpf_jit.c
@@ -1290,6 +1290,10 @@ int bpf_arch_text_poke(void *ip, enum bpf_text_poke_type old_t,
 		       void *new_addr)
 {
 	int ret;
+	unsigned long size = 0;
+	unsigned long offset = 0;
+	char namebuf[KSYM_NAME_LEN];
+	void *image = NULL;
 	bool is_call;
 	u32 old_insns[LOONGARCH_LONG_JUMP_NINSNS] = {[0 ... 4] = INSN_NOP};
 	u32 new_insns[LOONGARCH_LONG_JUMP_NINSNS] = {[0 ... 4] = INSN_NOP};
@@ -1297,9 +1301,18 @@ int bpf_arch_text_poke(void *ip, enum bpf_text_poke_type old_t,
 	/* Only poking bpf text is supported. Since kernel function entry
 	 * is set up by ftrace, we rely on ftrace to poke kernel functions.
 	 */
-	if (!is_bpf_text_address((unsigned long)ip))
+	if (!__bpf_address_lookup((unsigned long)ip, &size, &offset, namebuf))
 		return -ENOTSUPP;
 
+	image = ip - offset;
+	/* zero offset means we're poking bpf prog entry */
+	if (offset == 0)
+		/* skip to the nop instruction in bpf prog entry:
+		 * move t0, ra
+		 * nop
+		 */
+		ip = image + LOONGARCH_INSN_SIZE;
+
 	is_call = old_t == BPF_MOD_CALL;
 	ret = emit_jump_or_nops(old_addr, ip, old_insns, is_call);
 	if (ret)
-- 
2.25.1


