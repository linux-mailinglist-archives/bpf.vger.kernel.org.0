Return-Path: <bpf+bounces-38190-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19DD99616BA
	for <lists+bpf@lfdr.de>; Tue, 27 Aug 2024 20:18:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 454C1B23CA4
	for <lists+bpf@lfdr.de>; Tue, 27 Aug 2024 18:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE7331D416A;
	Tue, 27 Aug 2024 18:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="t1Ns06XY"
X-Original-To: bpf@vger.kernel.org
Received: from out-176.mta0.migadu.com (out-176.mta0.migadu.com [91.218.175.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA1A1D4148
	for <bpf@vger.kernel.org>; Tue, 27 Aug 2024 18:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724782646; cv=none; b=Gj/lV9rViAARnHBcq8H/jVmrTidOjouH4hZ27QeVp/ppFXMpDLK6ALaYInORvQL06oTbSQrJxaHCACOS+ASTv/uVF3z+D9QnMXOHsyhgch3m9Fa35vIX71L7ndHBoZ8G1AuOuGLZc1E2QsbZHhP7b3wbYJm49T09ZlM3OboUGlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724782646; c=relaxed/simple;
	bh=f01knn1y89ilOJI7pY+/JW2v9GvOZnAu0nb2LOoDS6k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K/7HrIMus2NPC40h9USYkM0ZoKuVtQwpy7PgV+j1Ii4XCLsoq+93L050PfVTzN+pVJb//XVIodOUSYGSOnFvY9xzJbEwo5YstTwKn8s8vQ1K35xgWE0FhzKGUzo+vKN+zf6EG+GkRlbwUJNXl7yjB8YrqHS/7YjPp0TRyRlX3TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=t1Ns06XY; arc=none smtp.client-ip=91.218.175.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724782642;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xq1n+QeFbpPrEDpCvP7u0+YcImnW+yUcz+Mb8dBuLoc=;
	b=t1Ns06XYe6LvNZ+orofs9j1bqkObvEG3QdjrAo0gS0+eqk4S10OQ0ZaYyZaLZ1XdsXxd9X
	7vCAWy26cjTQ8JWbPbAV+LkmO1FBipPhD21CXZApy4A62iX0d+6Oq0iY20JQGzutmRMh4c
	mJH0Djye9bQic5ZdJPkPJbgeQm325Dg=
From: Martin KaFai Lau <martin.lau@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Amery Hung <ameryhung@gmail.com>,
	kernel-team@meta.com
Subject: [PATCH v3 bpf-next 8/9] selftests/bpf: A pro/epilogue test when the main prog jumps back to the 1st insn
Date: Tue, 27 Aug 2024 11:16:44 -0700
Message-ID: <20240827181647.847890-9-martin.lau@linux.dev>
In-Reply-To: <20240827181647.847890-1-martin.lau@linux.dev>
References: <20240827181647.847890-1-martin.lau@linux.dev>
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

Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
---
 .../selftests/bpf/prog_tests/pro_epilogue.c   |   2 +
 .../bpf/progs/pro_epilogue_goto_start.c       | 149 ++++++++++++++++++
 2 files changed, 151 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/pro_epilogue_goto_start.c

diff --git a/tools/testing/selftests/bpf/prog_tests/pro_epilogue.c b/tools/testing/selftests/bpf/prog_tests/pro_epilogue.c
index 98de677c55a9..b2e467cf15fe 100644
--- a/tools/testing/selftests/bpf/prog_tests/pro_epilogue.c
+++ b/tools/testing/selftests/bpf/prog_tests/pro_epilogue.c
@@ -5,6 +5,7 @@
 #include "pro_epilogue_subprog.skel.h"
 #include "pro_epilogue_kfunc.skel.h"
 #include "epilogue_tailcall.skel.h"
+#include "pro_epilogue_goto_start.skel.h"
 
 struct st_ops_args {
 	int a;
@@ -45,6 +46,7 @@ void test_pro_epilogue(void)
 {
 	RUN_TESTS(pro_epilogue_subprog);
 	RUN_TESTS(pro_epilogue_kfunc);
+	RUN_TESTS(pro_epilogue_goto_start);
 	if (test__start_subtest("tailcall"))
 		test_tailcall();
 }
diff --git a/tools/testing/selftests/bpf/progs/pro_epilogue_goto_start.c b/tools/testing/selftests/bpf/progs/pro_epilogue_goto_start.c
new file mode 100644
index 000000000000..0ddc646cc24b
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
+__xlated("1: r7 = *(u32 *)(r6 +0)")
+__xlated("2: w7 += 1000")
+__xlated("3: *(u32 *)(r6 +0) = r7")
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
+__xlated("10: r6 = *(u32 *)(r1 +0)")
+__xlated("11: w6 += 10000")
+__xlated("12: *(u32 *)(r1 +0) = r6")
+__xlated("13: w0 = w6")
+__xlated("14: w0 *= 2")
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
+__xlated("1: r7 = *(u32 *)(r6 +0)")
+__xlated("2: w7 += 1000")
+__xlated("3: *(u32 *)(r6 +0) = r7")
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
+__xlated("14: r6 = *(u32 *)(r1 +0)")
+__xlated("15: w6 += 10000")
+__xlated("16: *(u32 *)(r1 +0) = r6")
+__xlated("17: w0 = w6")
+__xlated("18: w0 *= 2")
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


