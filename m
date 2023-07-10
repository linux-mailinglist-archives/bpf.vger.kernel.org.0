Return-Path: <bpf+bounces-4552-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1EB074C9C0
	for <lists+bpf@lfdr.de>; Mon, 10 Jul 2023 03:57:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60960280F64
	for <lists+bpf@lfdr.de>; Mon, 10 Jul 2023 01:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A0FF17D2;
	Mon, 10 Jul 2023 01:57:11 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9DEF17C8
	for <bpf@vger.kernel.org>; Mon, 10 Jul 2023 01:57:10 +0000 (UTC)
Received: from mailgw.kylinos.cn (unknown [124.126.103.232])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C842BEE;
	Sun,  9 Jul 2023 18:57:08 -0700 (PDT)
X-UUID: 06188fefb575434da11446c1d3861c80-20230710
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.27,REQID:809c74b7-40f3-4e1c-85dc-7d90e1d84bb3,IP:15,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:0
X-CID-INFO: VERSION:1.1.27,REQID:809c74b7-40f3-4e1c-85dc-7d90e1d84bb3,IP:15,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:0
X-CID-META: VersionHash:01c9525,CLOUDID:ba820968-314d-4083-81b6-6a74159151eb,B
	ulkID:230710095658WWG00CKR,BulkQuantity:0,Recheck:0,SF:44|24|17|19|102,TC:
	nil,Content:0,EDM:-3,IP:-2,URL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OS
	I:0,OSA:0,AV:0,LES:1,SPR:NO
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_ULS,TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,
	TF_CID_SPAM_FSI
X-UUID: 06188fefb575434da11446c1d3861c80-20230710
X-User: jianghaoran@kylinos.cn
Received: from localhost.localdomain [(39.156.73.12)] by mailgw
	(envelope-from <jianghaoran@kylinos.cn>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES128-GCM-SHA256 128/128)
	with ESMTP id 1691520724; Mon, 10 Jul 2023 09:56:57 +0800
From: Haoran Jiang <jianghaoran@kylinos.cn>
To: linux-kernel@vger.kernel.org
Cc: loongarch@lists.linux.dev,
	llvm@lists.linux.dev,
	bpf@vger.kernel.org,
	chenhuacai@kernel.org,
	trix@redhat.com,
	ndesaulniers@google.com,
	nathan@kernel.org,
	jolsa@kernel.org,
	haoluo@google.com,
	sdf@google.com,
	kpsingh@kernel.org,
	john.fastabend@gmail.com,
	yhs@fb.com,
	song@kernel.org,
	martin.lau@linux.dev,
	andrii@kernel.org,
	daniel@iogearbox.net,
	ast@kernel.org,
	kernel@xen0n.name,
	yangtiezhu@loongson.cn
Subject: [PATCH] samples/bpf: Fix compilation failure for samples/bpf on Loongarch Fedora
Date: Mon, 10 Jul 2023 09:51:20 +0800
Message-Id: <20230710015120.44818-1-jianghaoran@kylinos.cn>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

When building the latest samples/bpf on Loongarch Fedora

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

Test on Loongarch Fedora:
https://github.com/fedora-remix-loongarch/releases-info

Signed-off-by: Haoran Jiang <jianghaoran@kylinos.cn>
---
 samples/bpf/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
index 615f24ebc49c..b301796a3862 100644
--- a/samples/bpf/Makefile
+++ b/samples/bpf/Makefile
@@ -434,7 +434,7 @@ $(obj)/%.o: $(src)/%.c
 	@echo "  CLANG-bpf " $@
 	$(Q)$(CLANG) $(NOSTDINC_FLAGS) $(LINUXINCLUDE) $(BPF_EXTRA_CFLAGS) \
 		-I$(obj) -I$(srctree)/tools/testing/selftests/bpf/ \
-		-I$(LIBBPF_INCLUDE) \
+		-I$(LIBBPF_INCLUDE) $(CLANG_SYS_INCLUDES) \
 		-D__KERNEL__ -D__BPF_TRACING__ -Wno-unused-value -Wno-pointer-sign \
 		-D__TARGET_ARCH_$(SRCARCH) -Wno-compare-distinct-pointer-types \
 		-Wno-gnu-variable-sized-type-not-at-end \
-- 
2.27.0


