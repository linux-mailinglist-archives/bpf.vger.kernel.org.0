Return-Path: <bpf+bounces-37272-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 234DC9531BE
	for <lists+bpf@lfdr.de>; Thu, 15 Aug 2024 15:57:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8C931F22A72
	for <lists+bpf@lfdr.de>; Thu, 15 Aug 2024 13:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 170E119F470;
	Thu, 15 Aug 2024 13:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="UM26XQGV"
X-Original-To: bpf@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BB5317C9A9;
	Thu, 15 Aug 2024 13:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723730263; cv=none; b=YP+xgEa39gCyNEsXwLFYKpV7RgBhXcVwHs368Vm750+JOpwt8w3nx+D92S5wxYTItMd7YnJpaBGtzy5wdbZYZy7/11WWjcqInj9NmH9mq/bPnqHhYPKXA55Ql2j63yqZAOVAHSZtIki4OSu5HbsU024VGWIlhyWuBNp5/QeO31Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723730263; c=relaxed/simple;
	bh=syLoSRrr/IJyTap3WxKfJZ6zB66dFvWEBIi0jH/f6Qw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TiOlbug1GoPKLxMO4VuEt0elACAKEUOT8mVRfeZSCyguT644yzxpta6JbJJ3J34fOZlfExLqBiwGhl6bAZ6WZqCJeAEplxIspwhdxCNqZ8n0boYzO27VNKKZNrT1g/C12LMnnZbjl0k3z5Xu5WZg/HPaomxt2LWjUO/owAFfI9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=UM26XQGV; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=ZQaMG
	qV6eCHUSrBXt7if74+TPAJ0t26UBuqEhi5Zp7M=; b=UM26XQGV9FcllPQ/g9oiZ
	Ia4VR0tKbi8XgErszHo9ZeN91smiQoHx6KZ6/JpHNnNUp+9997vJVB7Ko1hmM9+B
	un66D2iJWGYSWs3ZWwxog6R3tBoxejleFSatsX6VBQtEWyVmB6gNF+wNU0EQcFTu
	RLlOods60BqhjbTlaDWwnw=
Received: from test-pc.. (unknown [111.48.69.245])
	by gzsmtp1 (Coremail) with SMTP id sCgvCgDHBtDgCL5mlzAwAA--.9515S2;
	Thu, 15 Aug 2024 21:55:47 +0800 (CST)
From: Jiangshan Yi <13667453960@163.com>
To: andrii@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net
Cc: bpf@vger.kernel.org,
	haoluo@google.com,
	john.fastabend@gmail.com,
	jolsa@kernel.org,
	kpsingh@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	eddyz87@gmail.com,
	sdf@fomichev.me,
	danieltimlee@gmail.com,
	linux-kernel@vger.kernel.org,
	13667453960@163.com,
	Jiangshan Yi <yijiangshan@kylinos.cn>,
	Qiang Wang <wangqiang1@kylinos.cn>
Subject: [PATCH] samples/bpf: fix compilation errors with cf-protection option
Date: Thu, 15 Aug 2024 21:55:24 +0800
Message-Id: <20240815135524.140675-1-13667453960@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:sCgvCgDHBtDgCL5mlzAwAA--.9515S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZFWrtry8WF15uw15Jr4rAFb_yoW8uFWxpF
	n5Ca4kKw4rZ3yFgFW7ArWFk3W3Aw4DKrW5Gr1kJrZ0y3ZIvFyvyF4xKr18uFs7GryxCw47
	ZrZYkr9xGrWUA3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zic18DUUUUU=
X-CM-SenderInfo: bprtllyxuvjmiwq6il2tof0z/1tbizQM8+2V4Iqz5UwAAsw

From: Jiangshan Yi <yijiangshan@kylinos.cn>

Currently, compiling the bpf programs will result the compilation errors
with the cf-protection option as follows in arm64 and loongarch64 machine
when using gcc 12.3.1 and clang 17.0.6. This commit fixes the compilation
errors by limited the cf-protection option only used in x86 platform.

[root@localhost linux]# make M=samples/bpf
	......
  CLANG-bpf  samples/bpf/xdp2skb_meta_kern.o
error: option 'cf-protection=return' cannot be specified on this target
error: option 'cf-protection=branch' cannot be specified on this target
2 errors generated.
  CLANG-bpf  samples/bpf/syscall_tp_kern.o
error: option 'cf-protection=return' cannot be specified on this target
error: option 'cf-protection=branch' cannot be specified on this target
2 errors generated.
	......

Fixes: 34f6e38f58db ("samples/bpf: fix warning with ignored-attributes")
Reported-by: Jiangshan Yi <yijiangshan@kylinos.cn>
Tested-by: Qiang Wang <wangqiang1@kylinos.cn>
Signed-off-by: Jiangshan Yi <yijiangshan@kylinos.cn>
---
 samples/bpf/Makefile | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
index 3e003dd6bea0..dca56aa360ff 100644
--- a/samples/bpf/Makefile
+++ b/samples/bpf/Makefile
@@ -169,6 +169,10 @@ BPF_EXTRA_CFLAGS += -I$(srctree)/arch/mips/include/asm/mach-generic
 endif
 endif
 
+ifeq ($(ARCH), x86)
+BPF_EXTRA_CFLAGS += -fcf-protection
+endif
+
 TPROGS_CFLAGS += -Wall -O2
 TPROGS_CFLAGS += -Wmissing-prototypes
 TPROGS_CFLAGS += -Wstrict-prototypes
@@ -405,7 +409,7 @@ $(obj)/%.o: $(src)/%.c
 		-Wno-gnu-variable-sized-type-not-at-end \
 		-Wno-address-of-packed-member -Wno-tautological-compare \
 		-Wno-unknown-warning-option $(CLANG_ARCH_ARGS) \
-		-fno-asynchronous-unwind-tables -fcf-protection \
+		-fno-asynchronous-unwind-tables \
 		-I$(srctree)/samples/bpf/ -include asm_goto_workaround.h \
 		-O2 -emit-llvm -Xclang -disable-llvm-passes -c $< -o - | \
 		$(OPT) -O2 -mtriple=bpf-pc-linux | $(LLVM_DIS) | \
-- 
2.27.0


