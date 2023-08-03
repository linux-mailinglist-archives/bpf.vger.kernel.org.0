Return-Path: <bpf+bounces-6833-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD82576E4FE
	for <lists+bpf@lfdr.de>; Thu,  3 Aug 2023 11:52:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7872728206A
	for <lists+bpf@lfdr.de>; Thu,  3 Aug 2023 09:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A270F15AD0;
	Thu,  3 Aug 2023 09:52:47 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1117E
	for <bpf@vger.kernel.org>; Thu,  3 Aug 2023 09:52:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A972AC433C8;
	Thu,  3 Aug 2023 09:52:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691056365;
	bh=+DDY0D4Y6bFjiG8v3EZ/JqpUklUKAy8LVEiwQiD7ld4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Uq53IrApDnK2ynOsTLE5dMpcmx7Le5FKJMMWMeJSQuBBmrKNCQeytW81i4qkJ6qKi
	 e2J9Gb76NJpFlDbF2ac4oRfhR8cfZN6eYKLr2m556vysCmSIF7Uh9i0Yv/yxHnjK7X
	 FPQX32IlwzURRAMoM6dcKBOBzFi+7Nw6F4+eQ7gXCKqIcavQhMGCjsB+pOgfPlBOBT
	 eyZYMAOQd6hP0b2xEBKbSyT3OZormZvU+iYKhgM9plrG6TZw64fzuV3Zbv7ywaVx0k
	 xkg9qiE3Wy8yZDHBIzzwQsRUqiYm94EIwzbOmmZGUikBWXAUCGHbrZBU3fCquA+XBR
	 I7xWhiRUjm2nA==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Alan Maguire <alan.maguire@oracle.com>,
	bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCHv2 bpf-next 2/3] selftests/bpf: Add bpf_get_func_ip tests for uprobe on function entry
Date: Thu,  3 Aug 2023 11:52:18 +0200
Message-ID: <20230803095219.1669065-3-jolsa@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230803095219.1669065-1-jolsa@kernel.org>
References: <20230803095219.1669065-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding get_func_ip tests for uprobe on function entry that
validates that bpf_get_func_ip returns proper values from
both uprobe and return uprobe.

Tested-by: Alan Maguire <alan.maguire@oracle.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../bpf/prog_tests/get_func_ip_test.c         | 11 ++++++++
 .../selftests/bpf/progs/get_func_ip_test.c    | 25 +++++++++++++++++--
 2 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/get_func_ip_test.c b/tools/testing/selftests/bpf/prog_tests/get_func_ip_test.c
index fede8ef58b5b..114cdbc04caf 100644
--- a/tools/testing/selftests/bpf/prog_tests/get_func_ip_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/get_func_ip_test.c
@@ -1,6 +1,11 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <test_progs.h>
 #include "get_func_ip_test.skel.h"
+#include "get_func_ip_uprobe_test.skel.h"
+
+static noinline void uprobe_trigger(void)
+{
+}
 
 static void test_function_entry(void)
 {
@@ -20,6 +25,8 @@ static void test_function_entry(void)
 	if (!ASSERT_OK(err, "get_func_ip_test__attach"))
 		goto cleanup;
 
+	skel->bss->uprobe_trigger = (unsigned long) uprobe_trigger;
+
 	prog_fd = bpf_program__fd(skel->progs.test1);
 	err = bpf_prog_test_run_opts(prog_fd, &topts);
 	ASSERT_OK(err, "test_run");
@@ -30,11 +37,15 @@ static void test_function_entry(void)
 
 	ASSERT_OK(err, "test_run");
 
+	uprobe_trigger();
+
 	ASSERT_EQ(skel->bss->test1_result, 1, "test1_result");
 	ASSERT_EQ(skel->bss->test2_result, 1, "test2_result");
 	ASSERT_EQ(skel->bss->test3_result, 1, "test3_result");
 	ASSERT_EQ(skel->bss->test4_result, 1, "test4_result");
 	ASSERT_EQ(skel->bss->test5_result, 1, "test5_result");
+	ASSERT_EQ(skel->bss->test7_result, 1, "test7_result");
+	ASSERT_EQ(skel->bss->test8_result, 1, "test8_result");
 
 cleanup:
 	get_func_ip_test__destroy(skel);
diff --git a/tools/testing/selftests/bpf/progs/get_func_ip_test.c b/tools/testing/selftests/bpf/progs/get_func_ip_test.c
index 8559e698b40d..8956eb78a226 100644
--- a/tools/testing/selftests/bpf/progs/get_func_ip_test.c
+++ b/tools/testing/selftests/bpf/progs/get_func_ip_test.c
@@ -1,8 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <linux/bpf.h>
+#include "vmlinux.h"
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
-#include <stdbool.h>
 
 char _license[] SEC("license") = "GPL";
 
@@ -83,3 +82,25 @@ int test6(struct pt_regs *ctx)
 	test6_result = (const void *) addr == 0;
 	return 0;
 }
+
+unsigned long uprobe_trigger;
+
+__u64 test7_result = 0;
+SEC("uprobe//proc/self/exe:uprobe_trigger")
+int BPF_UPROBE(test7)
+{
+	__u64 addr = bpf_get_func_ip(ctx);
+
+	test7_result = (const void *) addr == (const void *) uprobe_trigger;
+	return 0;
+}
+
+__u64 test8_result = 0;
+SEC("uretprobe//proc/self/exe:uprobe_trigger")
+int BPF_URETPROBE(test8, int ret)
+{
+	__u64 addr = bpf_get_func_ip(ctx);
+
+	test8_result = (const void *) addr == (const void *) uprobe_trigger;
+	return 0;
+}
-- 
2.41.0


