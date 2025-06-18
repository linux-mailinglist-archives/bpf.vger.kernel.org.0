Return-Path: <bpf+bounces-60902-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 03BF2ADE96B
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 12:52:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AF93189E7A2
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 10:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7647C288500;
	Wed, 18 Jun 2025 10:51:31 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16EB0145348;
	Wed, 18 Jun 2025 10:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750243891; cv=none; b=L71Oas0vz4jRYhmNOJ01ahE0ndaIDsZzKO2H7g3YsgdMaGP+5DyOk0yDskFXCplIYisx5am/0kqcbfl6yIRSv/oLTqWzy0/9USSPQWq08tCO5Tamu6SMH1os3aiRl84mAjWC4RbYK2wKfuhpaCbOld0sUoLBUu99i61Goe+6Ves=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750243891; c=relaxed/simple;
	bh=hke4TjzkwmsEgNYqIFKXOPfHZzI0kW0k4qjEVOz5cMI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cF9iH+1qct7Ms/74HfWSzVEhBOZ17MPyW/dZxDkyr37lisN2CEBMcm1Wn+WTsJu65mONXOpm/fseDeq9CmBqQgV7eLhvNOzmS0pAP6G0Ihb3EzTdOcYb8YmG88tmrpm+o/avryAiKt8RLTVfZOh/c0lLsdQniNvPIYYfcPAjB38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 2bf6bd964c3211f0b29709d653e92f7d-20250618
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
X-CID-O-INFO: VERSION:1.1.45,REQID:98c9aa40-be7e-4314-bc26-3ed6d25cd3f6,IP:10,
	URL:0,TC:0,Content:0,EDM:-30,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,AC
	TION:release,TS:-35
X-CID-INFO: VERSION:1.1.45,REQID:98c9aa40-be7e-4314-bc26-3ed6d25cd3f6,IP:10,UR
	L:0,TC:0,Content:0,EDM:-30,RT:0,SF:-15,FILE:0,BULK:0,RULE:EDM_GN8D19FE,ACT
	ION:release,TS:-35
X-CID-META: VersionHash:6493067,CLOUDID:0b9edccfd399fd440835cedad6c8aaaf,BulkI
	D:250618184817GKNGPLP0,BulkQuantity:0,Recheck:0,SF:17|19|24|44|66|78|81|82
	|102,TC:nil,Content:0|50,EDM:2,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil
	,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: 2bf6bd964c3211f0b29709d653e92f7d-20250618
X-User: duanchenghao@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <duanchenghao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1660142106; Wed, 18 Jun 2025 18:51:21 +0800
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
Subject: [PATCH v2 4/4] LoongArch: BPF: Update the code to rename validate_code to validate_ctx.
Date: Wed, 18 Jun 2025 18:50:48 +0800
Message-Id: <20250618105048.1510560-5-duanchenghao@kylinos.cn>
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

Update the code to rename validate_code to validate_ctx.
validate_code is used to check the validity of code.
validate_ctx is used to check both code validity and table entry
correctness.

Co-developed-by: George Guo <guodongtai@kylinos.cn>
Signed-off-by: George Guo <guodongtai@kylinos.cn>
Signed-off-by: Chenghao Duan <duanchenghao@kylinos.cn>
---
 arch/loongarch/net/bpf_jit.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
index 348ea3bfb..fa187f727 100644
--- a/arch/loongarch/net/bpf_jit.c
+++ b/arch/loongarch/net/bpf_jit.c
@@ -1185,6 +1185,14 @@ static int validate_code(struct jit_ctx *ctx)
 			return -1;
 	}
 
+	return 0;
+}
+
+static int validate_ctx(struct jit_ctx *ctx)
+{
+	if (validate_code(ctx))
+		return -1;
+
 	if (WARN_ON_ONCE(ctx->num_exentries != ctx->prog->aux->num_exentries))
 		return -1;
 
@@ -1293,7 +1301,7 @@ skip_init_ctx:
 	build_epilogue(&ctx);
 
 	/* 3. Extra pass to validate JITed code */
-	if (validate_code(&ctx)) {
+	if (validate_ctx(&ctx)) {
 		bpf_jit_binary_free(header);
 		prog = orig_prog;
 		goto out_offset;
-- 
2.43.0


