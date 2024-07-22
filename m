Return-Path: <bpf+bounces-35256-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B89DF939399
	for <lists+bpf@lfdr.de>; Mon, 22 Jul 2024 20:31:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72AEE28232A
	for <lists+bpf@lfdr.de>; Mon, 22 Jul 2024 18:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AABB16DC16;
	Mon, 22 Jul 2024 18:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Folc524x"
X-Original-To: bpf@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E550616FF48
	for <bpf@vger.kernel.org>; Mon, 22 Jul 2024 18:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721673083; cv=none; b=QNAbNSy+51IklScMdImgncRg+XYhckl/caxe0FqG+jRi3hWpO4434OnekTxXRVp1V0fcWUVnSVLSaA4t8LQHDD1PNUmNe6x2jM2A6tgDUynslFWzEkUEjrPiHd2yKc03B6HZDFa3+D/jB9OOvSJIjtHRgJYncbpNudlVQs/YCOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721673083; c=relaxed/simple;
	bh=8nBZoDOYaMafbs2tQ5jQ6IBDoBUUsosahG4m4qnGJzM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UPMXhRmRisSdIlEf2TVtY29HOr+hkq1EdG/6PFbzLEIsRpQBO4syUDfxxTvky7QEJ0zvSqyNjhRewh83FlRVrh4Mblxu7VAP0jstziVa3WVR6SQTVB8BKxBi6+UV3t6kkz+NqN3gIH1DuHY1eWvprx7YqqWYywMroSuchNSrLUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Folc524x; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1721673080;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NTsRWIvPgE7R3E+caKP99B5R3ccpA/54CGWPFDvINao=;
	b=Folc524xYNUlVMmI00rWTr1Umqhut8qQhqDe7hbvGy4O1dddIAX8Oul8auGYMvmAr5MElE
	Kutu9INP3NTbngroysrPb8ZPRfRvsLiNIjYCFdqoBuM69LO7va1gwEaVenhoInaXee8YN8
	sHe1ARp9BgIToOIC6SsvLNohg3Vt35M=
X-Envelope-To: ast@kernel.org
X-Envelope-To: andrii@kernel.org
X-Envelope-To: daniel@iogearbox.net
X-Envelope-To: kernel-team@meta.com
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@meta.com
Subject: [PATCH v2 bpf-next 3/3] selftests/bpf: Ensure the unsupported struct_ops prog cannot be loaded
Date: Mon, 22 Jul 2024 11:30:47 -0700
Message-ID: <20240722183049.2254692-4-martin.lau@linux.dev>
In-Reply-To: <20240722183049.2254692-1-martin.lau@linux.dev>
References: <20240722183049.2254692-1-martin.lau@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Martin KaFai Lau <martin.lau@kernel.org>

There is an existing "bpf_tcp_ca/unsupp_cong_op" test to ensure
the unsupported tcp-cc "get_info" struct_ops prog cannot be loaded.

This patch adds a new test in the bpf_testmod such that the
unsupported ops test does not depend on other kernel subsystem
where its supporting ops may be changed in the future.

Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
---
 .../selftests/bpf/bpf_testmod/bpf_testmod.h   |  1 +
 .../bpf/prog_tests/test_struct_ops_module.c   |  2 ++
 .../selftests/bpf/progs/unsupported_ops.c     | 22 +++++++++++++++++++
 3 files changed, 25 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/unsupported_ops.c

diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.h b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.h
index 23fa1872ee67..fe0d402b0d65 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.h
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.h
@@ -35,6 +35,7 @@ struct bpf_testmod_ops {
 	void (*test_2)(int a, int b);
 	/* Used to test nullable arguments. */
 	int (*test_maybe_null)(int dummy, struct task_struct *task);
+	int (*unsupported_ops)(void);
 
 	/* The following fields are used to test shadow copies. */
 	char onebyte;
diff --git a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
index bbcf12696a6b..75a0dea511b3 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
@@ -9,6 +9,7 @@
 #include "struct_ops_nulled_out_cb.skel.h"
 #include "struct_ops_forgotten_cb.skel.h"
 #include "struct_ops_detach.skel.h"
+#include "unsupported_ops.skel.h"
 
 static void check_map_info(struct bpf_map_info *info)
 {
@@ -311,5 +312,6 @@ void serial_test_struct_ops_module(void)
 		test_struct_ops_forgotten_cb();
 	if (test__start_subtest("test_detach_link"))
 		test_detach_link();
+	RUN_TESTS(unsupported_ops);
 }
 
diff --git a/tools/testing/selftests/bpf/progs/unsupported_ops.c b/tools/testing/selftests/bpf/progs/unsupported_ops.c
new file mode 100644
index 000000000000..9180365a3568
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/unsupported_ops.c
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
+
+#include <vmlinux.h>
+#include <bpf/bpf_tracing.h>
+#include "bpf_misc.h"
+#include "../bpf_testmod/bpf_testmod.h"
+
+char _license[] SEC("license") = "GPL";
+
+SEC("struct_ops/unsupported_ops")
+__failure
+__msg("attach to unsupported member unsupported_ops of struct bpf_testmod_ops")
+int BPF_PROG(unsupported_ops)
+{
+	return 0;
+}
+
+SEC(".struct_ops.link")
+struct bpf_testmod_ops testmod = {
+	.unsupported_ops = (void *)unsupported_ops,
+};
-- 
2.43.0


