Return-Path: <bpf+bounces-38479-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E406C965184
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 23:10:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 142A71C233AB
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 21:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CD2E1B375A;
	Thu, 29 Aug 2024 21:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="toIzKfZR"
X-Original-To: bpf@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4EC818B491
	for <bpf@vger.kernel.org>; Thu, 29 Aug 2024 21:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724965768; cv=none; b=gjDJx0+50I9qlZgVMXy0mSYKD3kCAZ+hzJ/UfpZSUNIrOkqI12iV1DWhjX1Z9MI4Dq9kpOCPfl5KF7tYJjz5qrw+Qf5SR2FCwLElPvlD2r9i4gS9/j200cjdtsS8Os852PCACIPMibkO0XC68vKd9BL8dVU98z2dc08QFDNHQPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724965768; c=relaxed/simple;
	bh=rMZKBQGnSpx0zSLiS7u5BPkYt3IzmjEaB3C/24oywYc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RdawO0CwFlzxlcns8eFgWNDbaf0+tUkParZqKg9EZQrdas4JN0gtKPD1OnX/lPUZ5NKjk2N2PQ84P0feRAv6gBOhKfG/8w1OurwvoJXDlasKKxuFlga4DvpIqPBqkZFemmpoTJ3h77gcPTaAf2x1MfJ1z2pcKVg3WQtRrIuyoyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=toIzKfZR; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724965764;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aLKS+u8nvp/eMKcdMnaT5PHXC5mSCvNUkiFfNTd3R7c=;
	b=toIzKfZRycGwDbbGmvFK8FeuyDAvCQpxAX/kRrPRDQEvSvnDRH/Cvhn427N5VNKSizSDIV
	+QoSuK7/3YfQVT9+Q7RyGJ2VvUtR/djdanFlwvXSCNGu4zgPXBde1pcxZCpXREyKwdznw7
	G+vnwInIh06ybvtqvRw2kHvOLBTfjoQ=
From: Martin KaFai Lau <martin.lau@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Amery Hung <ameryhung@gmail.com>,
	kernel-team@meta.com
Subject: [PATCH v5 bpf-next 8/9] selftests/bpf: A pro/epilogue test when the main prog jumps back to the 1st insn
Date: Thu, 29 Aug 2024 14:08:30 -0700
Message-ID: <20240829210833.388152-9-martin.lau@linux.dev>
In-Reply-To: <20240829210833.388152-1-martin.lau@linux.dev>
References: <20240829210833.388152-1-martin.lau@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Martin KaFai Lau <martin.lau@kernel.org>

This patch adds a pro/epilogue test when the main prog has a goto insn
that goes back to the very first instruction of the prog. It is
to test the correctness of the adjust_jmp_off(prog, 0, delta)
after the verifier has applied the prologue and/or epilogue patch.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
---
 .../selftests/bpf/prog_tests/pro_epilogue.c   |   2 +
 .../bpf/progs/pro_epilogue_goto_start.c       | 149 ++++++++++++++++++
 2 files changed, 151 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/pro_epilogue_goto_start.c

diff --git a/tools/testing/selftests/bpf/prog_tests/pro_epilogue.c b/tools/testing/selftests/bpf/prog_tests/pro_epilogue.c
index b82525c29de8..f974ae9ac610 100644
--- a/tools/testing/selftests/bpf/prog_tests/pro_epilogue.c
+++ b/tools/testing/selftests/bpf/prog_tests/pro_epilogue.c
@@ -4,6 +4,7 @@
 #include <test_progs.h>
 #include "pro_epilogue.skel.h"
 #include "epilogue_tailcall.skel.h"
+#include "pro_epilogue_goto_start.skel.h"
 
 struct st_ops_args {
 	__u64 a;
@@ -51,6 +52,7 @@ static void test_tailcall(void)
 void test_pro_epilogue(void)
 {
 	RUN_TESTS(pro_epilogue);
+	RUN_TESTS(pro_epilogue_goto_start);
 	if (test__start_subtest("tailcall"))
 		test_tailcall();
 }
diff --git a/tools/testing/selftests/bpf/progs/pro_epilogue_goto_start.c b/tools/testing/selftests/bpf/progs/pro_epilogue_goto_start.c
new file mode 100644
index 000000000000..3529e53be355
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/pro_epilogue_goto_start.c
@@ -0,0 +1,149 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
+
+#include <vmlinux.h>
+#include <bpf/bpf_tracing.h>
+#include "bpf_misc.h"
+#include "../bpf_testmod/bpf_testmod.h"
+#include "../bpf_testmod/bpf_testmod_kfunc.h"
+
+char _license[] SEC("license") = "GPL";
+
+__success
+/* prologue */
+__xlated("0: r6 = *(u64 *)(r1 +0)")
+__xlated("1: r7 = *(u64 *)(r6 +0)")
+__xlated("2: r7 += 1000")
+__xlated("3: *(u64 *)(r6 +0) = r7")
+/* main prog */
+__xlated("4: if r1 == 0x0 goto pc+5")
+__xlated("5: if r1 == 0x1 goto pc+2")
+__xlated("6: r1 = 1")
+__xlated("7: goto pc-3")
+__xlated("8: r1 = 0")
+__xlated("9: goto pc-6")
+__xlated("10: r0 = 0")
+__xlated("11: exit")
+SEC("struct_ops/test_prologue_goto_start")
+__naked int test_prologue_goto_start(void)
+{
+	asm volatile (
+	"if r1 == 0 goto +5;"
+	"if r1 == 1 goto +2;"
+	"r1 = 1;"
+	"goto -3;"
+	"r1 = 0;"
+	"goto -6;"
+	"r0 = 0;"
+	"exit;"
+	::: __clobber_all);
+}
+
+__success
+/* save __u64 *ctx to stack */
+__xlated("0: *(u64 *)(r10 -8) = r1")
+/* main prog */
+__xlated("1: if r1 == 0x0 goto pc+5")
+__xlated("2: if r1 == 0x1 goto pc+2")
+__xlated("3: r1 = 1")
+__xlated("4: goto pc-3")
+__xlated("5: r1 = 0")
+__xlated("6: goto pc-6")
+__xlated("7: r0 = 0")
+/* epilogue */
+__xlated("8: r1 = *(u64 *)(r10 -8)")
+__xlated("9: r1 = *(u64 *)(r1 +0)")
+__xlated("10: r6 = *(u64 *)(r1 +0)")
+__xlated("11: r6 += 10000")
+__xlated("12: *(u64 *)(r1 +0) = r6")
+__xlated("13: r0 = r6")
+__xlated("14: r0 *= 2")
+__xlated("15: exit")
+SEC("struct_ops/test_epilogue_goto_start")
+__naked int test_epilogue_goto_start(void)
+{
+	asm volatile (
+	"if r1 == 0 goto +5;"
+	"if r1 == 1 goto +2;"
+	"r1 = 1;"
+	"goto -3;"
+	"r1 = 0;"
+	"goto -6;"
+	"r0 = 0;"
+	"exit;"
+	::: __clobber_all);
+}
+
+__success
+/* prologue */
+__xlated("0: r6 = *(u64 *)(r1 +0)")
+__xlated("1: r7 = *(u64 *)(r6 +0)")
+__xlated("2: r7 += 1000")
+__xlated("3: *(u64 *)(r6 +0) = r7")
+/* save __u64 *ctx to stack */
+__xlated("4: *(u64 *)(r10 -8) = r1")
+/* main prog */
+__xlated("5: if r1 == 0x0 goto pc+5")
+__xlated("6: if r1 == 0x1 goto pc+2")
+__xlated("7: r1 = 1")
+__xlated("8: goto pc-3")
+__xlated("9: r1 = 0")
+__xlated("10: goto pc-6")
+__xlated("11: r0 = 0")
+/* epilogue */
+__xlated("12: r1 = *(u64 *)(r10 -8)")
+__xlated("13: r1 = *(u64 *)(r1 +0)")
+__xlated("14: r6 = *(u64 *)(r1 +0)")
+__xlated("15: r6 += 10000")
+__xlated("16: *(u64 *)(r1 +0) = r6")
+__xlated("17: r0 = r6")
+__xlated("18: r0 *= 2")
+__xlated("19: exit")
+SEC("struct_ops/test_pro_epilogue_goto_start")
+__naked int test_pro_epilogue_goto_start(void)
+{
+	asm volatile (
+	"if r1 == 0 goto +5;"
+	"if r1 == 1 goto +2;"
+	"r1 = 1;"
+	"goto -3;"
+	"r1 = 0;"
+	"goto -6;"
+	"r0 = 0;"
+	"exit;"
+	::: __clobber_all);
+}
+
+SEC(".struct_ops.link")
+struct bpf_testmod_st_ops epilogue_goto_start = {
+	.test_prologue = (void *)test_prologue_goto_start,
+	.test_epilogue = (void *)test_epilogue_goto_start,
+	.test_pro_epilogue = (void *)test_pro_epilogue_goto_start,
+};
+
+SEC("syscall")
+__retval(0)
+int syscall_prologue_goto_start(void *ctx)
+{
+	struct st_ops_args args = {};
+
+	return bpf_kfunc_st_ops_test_prologue(&args);
+}
+
+SEC("syscall")
+__retval(20000) /* (EPILOGUE_A [10000]) * 2 */
+int syscall_epilogue_goto_start(void *ctx)
+{
+	struct st_ops_args args = {};
+
+	return bpf_kfunc_st_ops_test_epilogue(&args);
+}
+
+SEC("syscall")
+__retval(22000) /* (PROLOGUE_A [1000] + EPILOGUE_A [10000]) * 2 */
+int syscall_pro_epilogue_goto_start(void *ctx)
+{
+	struct st_ops_args args = {};
+
+	return bpf_kfunc_st_ops_test_pro_epilogue(&args);
+}
-- 
2.43.5


