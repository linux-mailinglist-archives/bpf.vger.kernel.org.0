Return-Path: <bpf+bounces-38203-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53A09961833
	for <lists+bpf@lfdr.de>; Tue, 27 Aug 2024 21:49:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 113B02850C8
	for <lists+bpf@lfdr.de>; Tue, 27 Aug 2024 19:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24AE41D31B1;
	Tue, 27 Aug 2024 19:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="paC6njEM"
X-Original-To: bpf@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D896A1D2781
	for <bpf@vger.kernel.org>; Tue, 27 Aug 2024 19:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724788162; cv=none; b=Nx6U3aK1h4iPIpJrgbNOPksCOQc85+7nCwGX7Ld3PNYGM1OAWfQNwQg5Z0DbqxPdC2dGSGs6nAKyZ/CKJwc0s+AMa2+P/bYwY0hlnusZyIaIcMTB1lgq6hOgeVIcTcxkMa4fFenubgDDa6xTSMGAUDeOC9scIaZc0KC6PTC89Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724788162; c=relaxed/simple;
	bh=/CrTo/P/AXj6CZgYBYuEqV0mmAAj2+ZVvlhtMK3jl9U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bPbfWF5Q3VBY8YlBIPjVeDXP1hYtQV1DXt8ddvtLpuPE9w1Z0Fn2CUo2OtXM63zZYjE/CcuLXUQtOIb+q05lFI7/iWrvKE954j11My/GW8IyW3Iil8dVAlHIIzB4rjz4zWWigOj1s2N2pXlwHakDywS8pJK96JN1houiHs/yufk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=paC6njEM; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724788159;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ay2VPJfZp4OSD7AAcehiJ71a59uweokKAQ2FaVq0lMc=;
	b=paC6njEMDOMO+1shR4kSOfU6/adT44Uza5ZAupiS2mgNd1n0XN81Mn7+CA9M4Ynf/qIsRD
	n2WlPvkxQh9KnIopg0aGxR7Kr9f5mpi46wKIiqHyhePK1/5XXWIxTGQ74VTCD19z3zwFts
	vVpUXXtra8BA2X8lgfSHa3Fn2DaIDdU=
From: Martin KaFai Lau <martin.lau@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Amery Hung <ameryhung@gmail.com>,
	kernel-team@meta.com
Subject: [PATCH v4 bpf-next 9/9] selftests/bpf: Test epilogue patching when the main prog has multiple BPF_EXIT
Date: Tue, 27 Aug 2024 12:48:32 -0700
Message-ID: <20240827194834.1423815-10-martin.lau@linux.dev>
In-Reply-To: <20240827194834.1423815-1-martin.lau@linux.dev>
References: <20240827194834.1423815-1-martin.lau@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Martin KaFai Lau <martin.lau@kernel.org>

This patch tests the epilogue patching when the main prog has
multiple BPF_EXIT. The verifier should have patched the 2nd (and
later) BPF_EXIT with a BPF_JA that goes back to the earlier
patched epilogue instructions.

Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
---
 .../selftests/bpf/prog_tests/pro_epilogue.c   |  2 +
 .../selftests/bpf/progs/epilogue_exit.c       | 78 +++++++++++++++++++
 2 files changed, 80 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/epilogue_exit.c

diff --git a/tools/testing/selftests/bpf/prog_tests/pro_epilogue.c b/tools/testing/selftests/bpf/prog_tests/pro_epilogue.c
index b2e467cf15fe..58c18529a802 100644
--- a/tools/testing/selftests/bpf/prog_tests/pro_epilogue.c
+++ b/tools/testing/selftests/bpf/prog_tests/pro_epilogue.c
@@ -6,6 +6,7 @@
 #include "pro_epilogue_kfunc.skel.h"
 #include "epilogue_tailcall.skel.h"
 #include "pro_epilogue_goto_start.skel.h"
+#include "epilogue_exit.skel.h"
 
 struct st_ops_args {
 	int a;
@@ -47,6 +48,7 @@ void test_pro_epilogue(void)
 	RUN_TESTS(pro_epilogue_subprog);
 	RUN_TESTS(pro_epilogue_kfunc);
 	RUN_TESTS(pro_epilogue_goto_start);
+	RUN_TESTS(epilogue_exit);
 	if (test__start_subtest("tailcall"))
 		test_tailcall();
 }
diff --git a/tools/testing/selftests/bpf/progs/epilogue_exit.c b/tools/testing/selftests/bpf/progs/epilogue_exit.c
new file mode 100644
index 000000000000..8c03256c7491
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/epilogue_exit.c
@@ -0,0 +1,78 @@
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
+/* save __u64 *ctx to stack */
+__xlated("0: *(u64 *)(r10 -8) = r1")
+/* main prog */
+__xlated("1: r1 = *(u64 *)(r1 +0)")
+__xlated("2: r2 = *(u32 *)(r1 +0)")
+__xlated("3: if r2 == 0x0 goto pc+10")
+__xlated("4: r0 = 0")
+__xlated("5: *(u32 *)(r1 +0) = 0")
+/* epilogue */
+__xlated("6: r1 = *(u64 *)(r10 -8)")
+__xlated("7: r1 = *(u64 *)(r1 +0)")
+__xlated("8: r6 = *(u32 *)(r1 +0)")
+__xlated("9: w6 += 10000")
+__xlated("10: *(u32 *)(r1 +0) = r6")
+__xlated("11: w0 = w6")
+__xlated("12: w0 *= 2")
+__xlated("13: exit")
+/* 2nd part of the main prog after the first exit */
+__xlated("14: *(u32 *)(r1 +0) = 1")
+__xlated("15: r0 = 1")
+/* Clear the r1 to ensure it does not have
+ * off-by-1 error and ensure it jumps back to the
+ * beginning of epilogue which initializes
+ * the r1 with the ctx ptr.
+ */
+__xlated("16: r1 = 0")
+__xlated("17: gotol pc-12")
+SEC("struct_ops/test_epilogue_exit")
+__naked int test_epilogue_exit(void)
+{
+	asm volatile (
+	"r1 = *(u64 *)(r1 +0);"
+	"r2 = *(u32 *)(r1 +0);"
+	"if r2 == 0 goto +3;"
+	"r0 = 0;"
+	"*(u32 *)(r1 + 0) = 0;"
+	"exit;"
+	"*(u32 *)(r1 + 0) = 1;"
+	"r0 = 1;"
+	"r1 = 0;"
+	"exit;"
+	::: __clobber_all);
+}
+
+SEC(".struct_ops.link")
+struct bpf_testmod_st_ops epilogue_exit = {
+	.test_epilogue = (void *)test_epilogue_exit,
+};
+
+SEC("syscall")
+__retval(20000)
+int syscall_epilogue_exit0(void *ctx)
+{
+	struct st_ops_args args = { .a = 1 };
+
+	return bpf_kfunc_st_ops_test_epilogue(&args);
+}
+
+SEC("syscall")
+__retval(20002)
+int syscall_epilogue_exit1(void *ctx)
+{
+	struct st_ops_args args = {};
+
+	return bpf_kfunc_st_ops_test_epilogue(&args);
+}
-- 
2.43.5


