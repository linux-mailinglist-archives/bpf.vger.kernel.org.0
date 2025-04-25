Return-Path: <bpf+bounces-56688-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F318A9C453
	for <lists+bpf@lfdr.de>; Fri, 25 Apr 2025 11:53:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FE8A9C049C
	for <lists+bpf@lfdr.de>; Fri, 25 Apr 2025 09:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1880E23D28F;
	Fri, 25 Apr 2025 09:51:18 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7529B238C04;
	Fri, 25 Apr 2025 09:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745574677; cv=none; b=SYOkff3DP8ZEpGh8QiMGnpXPq6RAJv9PhGb+Xo7GTebZNM7kgvyC5BWCI+BrOMUjvVKdJfyYfEGYuBQiWKMp5cGpUJcVgOnnwTpUlfvi5BRmHNxt5uHLZP5yytAPFgz3KCllygDysU43Q3ny0KMSLFTFAgFy3/Cp7tNzKZPnxjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745574677; c=relaxed/simple;
	bh=aCnbddNjcpDZwKRa9tup09qc7MePN4i0Whw6J3J7Wjs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=avkrTVk0KVmG5DMI51Ed0bH/WfT1/OaBmkBNSUpRpqluppncwxGKu+F02bRiAM36vvQBZ606+uUoMu4euPZVVx84MRyCW+dxPMsjjLpAxgHVLK8mp8Cj+oEzLQiNcWc8Y3cqsYAygJ5B4ce/R8e/mm5mwxvs7dxJ+DPlVYMfRtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: ceea4baa21ba11f0a216b1d71e6e1362-20250425
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME
	IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_UNTRUSTED, SA_UNFAMILIAR
	SN_UNTRUSTED, SN_UNFAMILIAR, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS
	UD_TRUSTED, CIE_BAD, CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS
	GTI_C_CI, GTI_FG_IT, GTI_RG_INFO, GTI_C_BU, AMN_T1
	AMN_GOOD, AMN_C_TI, AMN_C_BU, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:0ddfab29-0e91-4b04-bf02-984af4606283,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:5
X-CID-INFO: VERSION:1.1.45,REQID:0ddfab29-0e91-4b04-bf02-984af4606283,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:5
X-CID-META: VersionHash:6493067,CLOUDID:7782e4460cd16490f63496accad47f71,BulkI
	D:250425175109UY6YW1YJ,BulkQuantity:0,Recheck:0,SF:19|24|44|66|72|78|102,T
	C:nil,Content:0|50,EDM:-3,IP:-2,URL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:
	nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_FSI,TF_CID_SPAM_ULS,TF_CID_SPAM_SNR,TF_CID_SPAM_FSD
X-UUID: ceea4baa21ba11f0a216b1d71e6e1362-20250425
X-User: jianghaoran@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <jianghaoran@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1796518417; Fri, 25 Apr 2025 17:51:06 +0800
From: Haoran Jiang <jianghaoran@kylinos.cn>
To: linux-kernel@vger.kernel.org
Cc: daniel@iogearbox.net,
	ast@kernel.org,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	nathan@kernel.org,
	ndesaulniers@google.com,
	trix@redhat.com,
	bpf@vger.kernel.org,
	llvm@lists.linux.dev,
	chenhuacai@kernel.org,
	yangtiezhu@loongson.cn,
	zhangxi <zhangxi@kylinos.cn>
Subject: [PATCH] samples/bpf: Fix compilation failure for samples/bpf on LoongArch Fedora
Date: Fri, 25 Apr 2025 17:50:42 +0800
Message-Id: <20250425095042.838824-1-jianghaoran@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When building the latest samples/bpf on LoongArch Fedora

     make M=samples/bpf

There are compilation errors as follows:

In file included from ./linux/samples/bpf/sockex2_kern.c:2:
In file included from ./include/uapi/linux/in.h:25:
In file included from ./include/linux/socket.h:8:
In file included from ./include/linux/uio.h:9:
In file included from ./include/linux/thread_info.h:60:
In file included from ./arch/loongarch/include/asm/thread_info.h:15:
In file included from ./arch/loongarch/include/asm/processor.h:13:
In file included from ./arch/loongarch/include/asm/cpu-info.h:11:
./arch/loongarch/include/asm/loongarch.h:13:10: fatal error: 'larchintrin.h' file not found
         ^~~~~~~~~~~~~~~
1 error generated.

larchintrin.h is included in /usr/lib64/clang/14.0.6/include,
and the header file location is specified at compile time.

Test on LoongArch Fedora:
https://github.com/fedora-remix-loongarch/releases-info

Signed-off-by: Haoran Jiang <jianghaoran@kylinos.cn>
Signed-off-by: zhangxi <zhangxi@kylinos.cn>
Change-Id: I5fca6f0cee21e429982c5a3865efc5afeb3fa757
---
 samples/bpf/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
index 3fa16412db15..927d72659173 100644
--- a/samples/bpf/Makefile
+++ b/samples/bpf/Makefile
@@ -392,7 +392,7 @@ $(obj)/%.o: $(src)/%.c
 	@echo "  CLANG-bpf " $@
 	$(Q)$(CLANG) $(NOSTDINC_FLAGS) $(LINUXINCLUDE) $(BPF_EXTRA_CFLAGS) \
 		-I$(obj) -I$(srctree)/tools/testing/selftests/bpf/ \
-		-I$(LIBBPF_INCLUDE) \
+		-I$(LIBBPF_INCLUDE) $(CLANG_SYS_INCLUDES) \
 		-D__KERNEL__ -D__BPF_TRACING__ -Wno-unused-value -Wno-pointer-sign \
 		-D__TARGET_ARCH_$(SRCARCH) -Wno-compare-distinct-pointer-types \
 		-Wno-gnu-variable-sized-type-not-at-end \
-- 
2.25.1


