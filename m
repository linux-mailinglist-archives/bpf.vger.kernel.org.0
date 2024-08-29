Return-Path: <bpf+bounces-38480-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 438C5965185
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 23:10:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E17401F24767
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 21:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D91DC18C349;
	Thu, 29 Aug 2024 21:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EL5qWfE+"
X-Original-To: bpf@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6BE18C004
	for <bpf@vger.kernel.org>; Thu, 29 Aug 2024 21:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724965781; cv=none; b=QBlA/lkYK7Qm5e+fAn5O3/WZ6itZl8j2BJyUe98edeBKWcodmuOWwm8KTd01xnwnkXkgyYOsacmQsBwHWnOajMpkcYIvu7wvavZFMQE4836JiBxNAHUEH9iLBaXM5jWD01vcplwL5Yu7T5pYE2s7xRJ8XkYlOeT29QU4dTEmNv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724965781; c=relaxed/simple;
	bh=b5Fwe61DFmJ8tmrcnmSF8rJjSIL1m4OZD7BoGZFBwVc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EYUfw7to2tVZnR6KmqsfkVl5ktOdnDan6iKj/npZuUgjjo2RNVpa/OajiFzXNnaKly9roM2TzZT4Z5KrFAhYRLIxvwotK2/Giq8aROQMuaI/dXBGlp2zr4/zdxLbUhofBIOW0VYh15AL83/5fQ7MKgeu+EmSSbAqwZmpY67F26E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EL5qWfE+; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724965778;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YDxOXoz1D1BErybxpiUhhKu2WtIM5oqXzOaZ4JKezYg=;
	b=EL5qWfE+QsxVtqCxh/KoGkUmpHP/mpA5cdHQYdcCKqFzhtLp8RouYYniTc2mzJCwer8Ar6
	Uo/ldK7x27uJ3H+8ApxcIwcZ5+k0z5sUufuIwSZ5Qa6qFRthPR7isl/yyCe0SNvnj0vHGr
	FOUamh0X5nJ23bOUkEBJjYw9aGgrKBE=
From: Martin KaFai Lau <martin.lau@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Amery Hung <ameryhung@gmail.com>,
	kernel-team@meta.com
Subject: [PATCH v5 bpf-next 9/9] selftests/bpf: Test epilogue patching when the main prog has multiple BPF_EXIT
Date: Thu, 29 Aug 2024 14:08:31 -0700
Message-ID: <20240829210833.388152-10-martin.lau@linux.dev>
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

This patch tests the epilogue patching when the main prog has
multiple BPF_EXIT. The verifier should have patched the 2nd (and
later) BPF_EXIT with a BPF_JA that goes back to the earlier
patched epilogue instructions.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
---
 .../selftests/bpf/prog_tests/pro_epilogue.c   |  2 +
 .../selftests/bpf/progs/epilogue_exit.c       | 82 +++++++++++++++++++
 2 files changed, 84 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/epilogue_exit.c

diff --git a/tools/testing/selftests/bpf/prog_tests/pro_epilogue.c b/tools/testing/selftests/bpf/prog_tests/pro_epilogue.c
index f974ae9ac610..509883e6823a 100644
--- a/tools/testing/selftests/bpf/prog_tests/pro_epilogue.c
+++ b/tools/testing/selftests/bpf/prog_tests/pro_epilogue.c
@@ -5,6 +5,7 @@
 #include "pro_epilogue.skel.h"
 #include "epilogue_tailcall.skel.h"
 #include "pro_epilogue_goto_start.skel.h"
+#include "epilogue_exit.skel.h"
 
 struct st_ops_args {
 	__u64 a;
@@ -53,6 +54,7 @@ void test_pro_epilogue(void)
 {
 	RUN_TESTS(pro_epilogue);
 	RUN_TESTS(pro_epilogue_goto_start);
+	RUN_TESTS(epilogue_exit);
 	if (test__start_subtest("tailcall"))
 		test_tailcall();
 }
diff --git a/tools/testing/selftests/bpf/progs/epilogue_exit.c b/tools/testing/selftests/bpf/progs/epilogue_exit.c
new file mode 100644
index 000000000000..33d3a57bee90
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/epilogue_exit.c
@@ -0,0 +1,82 @@
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
+__xlated("2: r2 = *(u64 *)(r1 +0)")
+__xlated("3: r3 = 0")
+__xlated("4: r4 = 1")
+__xlated("5: if r2 == 0x0 goto pc+10")
+__xlated("6: r0 = 0")
+__xlated("7: *(u64 *)(r1 +0) = r3")
+/* epilogue */
+__xlated("8: r1 = *(u64 *)(r10 -8)")
+__xlated("9: r1 = *(u64 *)(r1 +0)")
+__xlated("10: r6 = *(u64 *)(r1 +0)")
+__xlated("11: r6 += 10000")
+__xlated("12: *(u64 *)(r1 +0) = r6")
+__xlated("13: r0 = r6")
+__xlated("14: r0 *= 2")
+__xlated("15: exit")
+/* 2nd part of the main prog after the first exit */
+__xlated("16: *(u64 *)(r1 +0) = r4")
+__xlated("17: r0 = 1")
+/* Clear the r1 to ensure it does not have
+ * off-by-1 error and ensure it jumps back to the
+ * beginning of epilogue which initializes
+ * the r1 with the ctx ptr.
+ */
+__xlated("18: r1 = 0")
+__xlated("19: gotol pc-12")
+SEC("struct_ops/test_epilogue_exit")
+__naked int test_epilogue_exit(void)
+{
+	asm volatile (
+	"r1 = *(u64 *)(r1 +0);"
+	"r2 = *(u64 *)(r1 +0);"
+	"r3 = 0;"
+	"r4 = 1;"
+	"if r2 == 0 goto +3;"
+	"r0 = 0;"
+	"*(u64 *)(r1 + 0) = r3;"
+	"exit;"
+	"*(u64 *)(r1 + 0) = r4;"
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


