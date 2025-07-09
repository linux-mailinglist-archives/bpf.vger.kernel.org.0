Return-Path: <bpf+bounces-62752-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62719AFDF9B
	for <lists+bpf@lfdr.de>; Wed,  9 Jul 2025 07:50:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A097317A0D5
	for <lists+bpf@lfdr.de>; Wed,  9 Jul 2025 05:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA58526AABA;
	Wed,  9 Jul 2025 05:50:46 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B82021D5BB;
	Wed,  9 Jul 2025 05:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752040246; cv=none; b=G4AP8X3J7fQnAu7qKFIeC8LHE5Z+t71PI3sdMbApmTcdVKnsdsM2Sy4ZxkyuT/ANwI4o5HebmLokNlttE8/ln4rr7mTU+Ot2f9yKyV+JZJ+EeS+B7LRniZ8vrCkmUAGXvvWRRaRpb1+KbaLvrsNNbeN//vGElEwba47n8GfJmBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752040246; c=relaxed/simple;
	bh=zksTj+124sa0mBuIg1QHvvrCwJ/bav6M5yrKT51uQGE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Liom0bggnadLiK5zEXrXM8X/fA3LKxhyhxBKznV4zRcXl1hei+mUGMs88gOGI3F15tROJDcFNl+hCIaLkf77e9ienCgaFx4DCsBKSF71a2KqLuzjs5g4R0dv9u2yqX4RY6TzG/gQOc+UqgD00tYPKq0slvsBaigAcwubB2YLni4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: a1cb05f25c8811f0b29709d653e92f7d-20250709
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NO_NAME, HR_CTE_8B, HR_CTT_MISS
	HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME, HR_SJ_DIGIT_LEN
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME
	IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_EXISTED, SN_EXISTED
	SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, CIE_BAD, CIE_GOOD
	CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO, GTI_C_BU, AMN_T1
	AMN_GOOD, AMN_C_TI, AMN_C_BU, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:b7046966-78cb-4f2d-8967-1533477d78a0,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-5
X-CID-INFO: VERSION:1.1.45,REQID:b7046966-78cb-4f2d-8967-1533477d78a0,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:6493067,CLOUDID:3d7e3a57d0fcf0108fd0e9367978b396,BulkI
	D:2507091339228G2FHZ39,BulkQuantity:1,Recheck:0,SF:17|19|24|38|44|66|78|10
	2,TC:nil,Content:0|50,EDM:-3,IP:-2,URL:99|1,File:nil,RT:nil,Bulk:40,QS:nil
	,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,
	TF_CID_SPAM_ULS
X-UUID: a1cb05f25c8811f0b29709d653e92f7d-20250709
X-User: duanchenghao@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <duanchenghao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 212056178; Wed, 09 Jul 2025 13:50:34 +0800
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
Subject: [PATCH v3 0/5] Support trampoline for LoongArch
Date: Wed,  9 Jul 2025 13:50:24 +0800
Message-Id: <20250709055029.723243-1-duanchenghao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v3:
1. Patch 0003 adds EXECMEM_BPF memory type to the execmem subsystem.

2. Align the size calculated by arch_bpf_trampoline_size to page
boundaries.

3. Add the flush icache operation to larch_insn_text_copy.

4. Unify the implementation of bpf_arch_xxx into the patch
"0004-LoongArch-BPF-Add-bpf_arch_xxxxx-support-for-Loong.patch".

5. Change the patch order. Move the patch
"0002-LoongArch-BPF-Update-the-code-to-rename-validate_.patch" before
"0005-LoongArch-BPF-Add-bpf-trampoline-support-for-Loon.patch".

-----------------------------------------------------------------------
Historical Version:
v2:
1. Change the fixmap in the instruction copy function to set_memory_xxx.

2. Change the implementation method of the following code.
	- arch_alloc_bpf_trampoline
	- arch_free_bpf_trampoline
	Use the BPF core's allocation and free functions.

	- bpf_arch_text_invalidate
	Operate with the function larch_insn_text_copy that carries
	memory attribute modifications.

3. Correct the incorrect code formatting.

URL for version v2:
https://lore.kernel.org/all/20250618105048.1510560-1-duanchenghao@kylinos.cn/
---------
v1:
Support trampoline for LoongArch. The following feature tests have been
completed:
	1. fentry
	2. fexit
	3. fmod_ret

TODO: The support for the struct_ops feature will be provided in
subsequent patches.

URL for version v1:
https://lore.kernel.org/all/20250611035952.111182-1-duanchenghao@kylinos.cn/
-----------------------------------------------------------------------

Chenghao Duan (5):
  LoongArch: Add the function to generate the beq and bne assembly
    instructions.
  LoongArch: BPF: Update the code to rename validate_code to
    validate_ctx.
  LoongArch: BPF: Add EXECMEM_BPF memory to execmem subsystem
  LoongArch: BPF: Add bpf_arch_xxxxx support for Loongarch
  LoongArch: BPF: Add bpf trampoline support for Loongarch

 arch/loongarch/include/asm/inst.h |   3 +
 arch/loongarch/kernel/inst.c      |  60 ++++
 arch/loongarch/mm/init.c          |   6 +
 arch/loongarch/net/bpf_jit.c      | 491 +++++++++++++++++++++++++++++-
 arch/loongarch/net/bpf_jit.h      |   6 +
 5 files changed, 565 insertions(+), 1 deletion(-)

-- 
2.43.0


