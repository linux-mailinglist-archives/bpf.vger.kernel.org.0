Return-Path: <bpf+bounces-64698-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 885BDB16129
	for <lists+bpf@lfdr.de>; Wed, 30 Jul 2025 15:14:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0DC3562FDE
	for <lists+bpf@lfdr.de>; Wed, 30 Jul 2025 13:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EF2C299ABD;
	Wed, 30 Jul 2025 13:13:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC8D296142;
	Wed, 30 Jul 2025 13:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753881213; cv=none; b=FmooBuD3bIuUMBc+ClSjYLm6ERVBPBXMSvcBzbdlMkE6sE+Ue72XVClLgBhWKFjcmH0OFvqe6BSofiN86AuL1wqa/HFPmB9XRIKPj5xmaIZsiYRnE8wfs2etvSArMsmlbV1f00zTFX7A3SqeDHUWZUgUMpkIV8Q2GCjAouibn7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753881213; c=relaxed/simple;
	bh=vgI8/UvzyAKC5Q5lXfryK7d++m3DCames1QnpSfa/9M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mYSMx2WThu0FdtIFKXafdclmhIPuFHgJqNeHD/sBiaUnxZthnlqbd3Rwu028Kxoe1CyjOE6v52lNoEltU2pBSniJ9RgnkQvzV+1WLPp2ndth6fHC8QlXDir/Mqv0v+f/kwG2CnBCG4WisbhImfSZyqaz9ZNqHBQG/O/HhzUKjX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: f395e1126d4611f0b29709d653e92f7d-20250730
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NO_NAME, HR_CTE_8B, HR_CTT_MISS
	HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME, HR_SJ_DIGIT_LEN
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME
	IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_EXISTED, SN_EXISTED
	SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, CIE_BAD, CIE_GOOD_SPF
	GTI_FG_BS, GTI_FG_IT, GTI_RG_INFO, GTI_C_BU, AMN_T1
	AMN_GOOD, AMN_C_TI, AMN_C_BU, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:01f75f64-c9be-4200-bf23-27dc2c453b57,IP:15,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:0
X-CID-INFO: VERSION:1.1.45,REQID:01f75f64-c9be-4200-bf23-27dc2c453b57,IP:15,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:6c0bea7a29a686be811efbae13ebf183,BulkI
	D:250730211316EUH3H1Z8,BulkQuantity:0,Recheck:0,SF:17|19|24|38|44|66|78|10
	2,TC:nil,Content:0|50,EDM:-3,IP:-2,URL:99|1,File:nil,RT:nil,Bulk:nil,QS:ni
	l,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:
	0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_FSI,TF_CID_SPAM_ULS,TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,
	TF_CID_SPAM_FSD
X-UUID: f395e1126d4611f0b29709d653e92f7d-20250730
X-User: duanchenghao@kylinos.cn
Received: from localhost.localdomain [(116.128.244.171)] by mailgw.kylinos.cn
	(envelope-from <duanchenghao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1600813722; Wed, 30 Jul 2025 21:13:15 +0800
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
	geliang@kernel.org
Subject: [PATCH v5 0/5] Support trampoline for LoongArch
Date: Wed, 30 Jul 2025 21:12:52 +0800
Message-Id: <20250730131257.124153-1-duanchenghao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v5:
1. Modify the internal implementation of larch_insn_text_copy by
   removing the while loop processing. There is a while loop inside
   copy_to_kernel_nofault that handles and copies all data.

2. text_mutex has been added to all usage contexts of
larch_insn_text_copy, and the relevant tests have passed.

-----------------------------------------------------------------------
Historical Version:
v4:
1. Delete the #3 patch of version V3.

2. Add 5 NOP instructions in build_prologue().
   Reserve space for the move_imm + jirl instruction.

3. Differentiate between direct jumps and ftrace jumps of trampoline:
   direct jumps skip 5 instructions.
   ftrace jumps skip 2 instructions.

4. Remove the generation of BL jump instructions in emit_jump_and_link().
   After the trampoline ends, it will jump to the specified register.
   The BL instruction writes PC+4 to r1 instead of allowing the
   specification of rd.

URL for version v4:
https://lore.kernel.org/all/20250724141929.691853-1-duanchenghao@kylinos.cn/
---------
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

URL for version v3:
https://lore.kernel.org/all/20250709055029.723243-1-duanchenghao@kylinos.cn/
---------
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

Chenghao Duan (4):
  LoongArch: Add larch_insn_gen_{beq,bne} helpers
  LoongArch: BPF: Update the code to rename validate_code to
    validate_ctx
  LoongArch: BPF: Implement dynamic code modification support
  LoongArch: BPF: Add bpf trampoline support for Loongarch

Tiezhu Yang (1):
  LoongArch: BPF: Add struct ops support for trampoline

 arch/loongarch/include/asm/inst.h |   3 +
 arch/loongarch/kernel/inst.c      |  54 +++
 arch/loongarch/net/bpf_jit.c      | 527 +++++++++++++++++++++++++++++-
 arch/loongarch/net/bpf_jit.h      |   6 +
 4 files changed, 589 insertions(+), 1 deletion(-)

-- 
2.25.1


