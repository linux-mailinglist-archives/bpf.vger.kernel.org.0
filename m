Return-Path: <bpf+bounces-54527-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D5F8A6B525
	for <lists+bpf@lfdr.de>; Fri, 21 Mar 2025 08:36:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89F3918885FF
	for <lists+bpf@lfdr.de>; Fri, 21 Mar 2025 07:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 943121EDA35;
	Fri, 21 Mar 2025 07:36:29 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EAAB1EB184;
	Fri, 21 Mar 2025 07:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742542589; cv=none; b=ibiGYtFcG3PRAZfC4Wo+srFbxC3XMTBv/+oOIIdFusrSb8m+ZuaeDUgM25hMZxLXIFiqO3dmq3yQDHnJ9Yu/O35yqDiZwo+Z96CRgj5VAbIdm9PwNOWCJP3P9MpKfNsxCKMHDuY98Hl9Y+pGgGjDXJvpC4hJ3zYGId5WFFPJYqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742542589; c=relaxed/simple;
	bh=fS/gdm7jl9A9E/8qkYUBnE/GTJQ194bTtcWytpXr2hc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PWICkfyd/tBc09vvRHWh0Xd4ctLL8dQpP/PWI3Z7qtlMHF6QoMoLadHHMfKG0OA/I21nWvC9Mj3DyC1mDmKdK+tavDB1RdefHu7pFoFt/dZYycL0RSTHYbzjxRehZIR2dFsLLKkrXUCVhx15Q0bFDxuJRjp10WyURnA5sLLHnls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 2dc6dd46062711f0a216b1d71e6e1362-20250321
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:1ed1ee8c-635a-4db8-905f-5fd8e445a575,IP:0,U
	RL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:6493067,CLOUDID:39ed90eb5f5a2127bb68b461e85b47f3,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0|50,EDM:5,IP:n
	il,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LE
	S:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 2dc6dd46062711f0a216b1d71e6e1362-20250321
Received: from node4.com.cn [(10.44.16.170)] by mailgw.kylinos.cn
	(envelope-from <zhangxi@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1895884079; Fri, 21 Mar 2025 15:36:18 +0800
Received: from node4.com.cn (localhost [127.0.0.1])
	by node4.com.cn (NSMail) with SMTP id EC8911600052C;
	Fri, 21 Mar 2025 15:36:17 +0800 (CST)
X-ns-mid: postfix-67DD16F1-274370864
Received: from localhost.localdomain (unknown [172.30.80.11])
	by node4.com.cn (NSMail) with ESMTPA id 4DAB91600052C;
	Fri, 21 Mar 2025 07:36:15 +0000 (UTC)
From: Zhang Xi <zhangxi@kylinos.cn>
To: chenhuacai@kernel.org
Cc: linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	llvm@lists.linux.de,
	yangtiezhu@loongson.cn,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	nathan@kernel.org,
	nick.desaulniers+lkml@gmail.com,
	morbo@google.com,
	justinstitt@google.com,
	yijiangshan@kylinos.cn,
	zhangxi <zhangxi@kylinos.cn>
Subject: [PATCH v2] selftests/bpf: fix the compilation errors caused by larchintrin.h
Date: Fri, 21 Mar 2025 15:36:13 +0800
Message-Id: <20250321073613.1082510-1-zhangxi@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250317083142.561104-1-zhangxi@kylinos.cn>
References: <20250317083142.561104-1-zhangxi@kylinos.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: zhangxi <zhangxi@kylinos.cn>

On the LoongArch platform, the header file 'larchintrin.h' is provided by
the package clang-libs, and it is necessary to add CLANG_SYS_INCLUDES to
the compilation command.

make M=3Dsamples/bpf, compilation errors:

In file included from sockex2_kern.c:2:
In file included from /root/work/src/github/linux/include/uapi/linux/in.h=
:25:
In file included from /root/work/src/github/linux/include/linux/socket.h:=
8:
In file included from /root/work/src/github/linux/include/linux/uio.h:9:
In file included from /root/work/src/github/linux/include/linux/thread_in=
fo.h:60:
In file included from /root/work/src/github/linux/arch/loongarch/include/=
asm/thread_info.h:15:
In file included from /root/work/src/github/linux/arch/loongarch/include/=
asm/processor.h:13:
In file included from /root/work/src/github/linux/arch/loongarch/include/=
asm/cpu-info.h:11:
/root/work/src/github/linux/arch/loongarch/include/asm/loongarch.h:13:10:=
 fatal error: 'larchintrin.h' file not found
   13 | #include <larchintrin.h>

Signed-off-by: zhangxi <zhangxi@kylinos.cn>
---
 samples/bpf/Makefile | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
index dd9944a97b7e..f459360c99bc 100644
--- a/samples/bpf/Makefile
+++ b/samples/bpf/Makefile
@@ -337,6 +337,10 @@ endef
=20
 CLANG_SYS_INCLUDES =3D $(call get_sys_includes,$(CLANG))
=20
+ifeq ($(ARCH), loongarch)
+CLANG_CFLAGS =3D $(CLANG_SYS_INCLUDES)
+endif
+
 $(obj)/xdp_router_ipv4.bpf.o: $(obj)/xdp_sample.bpf.o
=20
 $(obj)/%.bpf.o: $(src)/%.bpf.c $(obj)/vmlinux.h $(src)/xdp_sample.bpf.h =
$(src)/xdp_sample_shared.h
@@ -376,7 +380,7 @@ $(obj)/%.o: $(src)/%.c
 	@echo "  CLANG-bpf " $@
 	$(Q)$(CLANG) $(NOSTDINC_FLAGS) $(LINUXINCLUDE) $(BPF_EXTRA_CFLAGS) \
 		-I$(obj) -I$(srctree)/tools/testing/selftests/bpf/ \
-		-I$(LIBBPF_INCLUDE) \
+		-I$(LIBBPF_INCLUDE) $(CLANG_CFLAGS)\
 		-D__KERNEL__ -D__BPF_TRACING__ -Wno-unused-value -Wno-pointer-sign \
 		-D__TARGET_ARCH_$(SRCARCH) -Wno-compare-distinct-pointer-types \
 		-Wno-gnu-variable-sized-type-not-at-end \
--=20
2.25.1


