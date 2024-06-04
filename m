Return-Path: <bpf+bounces-31381-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D8488FBCFB
	for <lists+bpf@lfdr.de>; Tue,  4 Jun 2024 22:04:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52A2B1F25CC7
	for <lists+bpf@lfdr.de>; Tue,  4 Jun 2024 20:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF89B14BF91;
	Tue,  4 Jun 2024 20:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kGPFjltm"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E2D14B06E;
	Tue,  4 Jun 2024 20:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717531441; cv=none; b=m78UTjjKC/OpN9zT3aiAdb9cYGILMfqohqEclZf6j7sUmGKuE7zIFPjiLPxQOB99WxwRlEvjyBKqzx6rjoIQrQQo/7aqUH5ADxmO4DsY0n8hjEqJSi/vLSJ9ik4mP36r0s0Nf78IW2XJ7J6/ipp+Vh0OqDOCV9P7IQ2ReF5uP1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717531441; c=relaxed/simple;
	bh=CmzoveDdgtuX9uW3EQCl2u70qoS5RT28wNQKn8Oddbs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=esTouQr6zdRQEErTkrio8GYj7kRPnHrIGJ9IIRgxJaSjmxS9ACyY+2M2L0TJAdHhrnwb5lQZYQIk+ptR+OUBc2pji37huUT3Ww93jbBwV+dk1Sfk3whzVF/6gbJrrkUdUsS09zq8KA+Bfua5eOj4eliE2oWOjKPayBHprZxTpJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kGPFjltm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF06DC2BBFC;
	Tue,  4 Jun 2024 20:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717531440;
	bh=CmzoveDdgtuX9uW3EQCl2u70qoS5RT28wNQKn8Oddbs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kGPFjltm7U/AN2d6nJR0mn/WkRcDPgVCPvnW00sd6+QQEmdbOX9jqGhDUopK9Bv5s
	 7RVRzJ1k+rFItowXnYQCRGzSAO44sjTrjcQghu2jeP4IWGqBSy4tE5hNoFslc7snKj
	 w3ENm7ftW62vIXXaca0Ir6S5uWyYjrmGJuj9XNTX+Wbb0FlVoI7gIdGPWunI8PqXI2
	 azq2pZPuyMwL4fbxjAuDuG+mJ24VCdDNYsuggd5pAeKb6Rih1r71fCUvdWQOnNxW3y
	 UETSHNmPf0dz0SfIEz1O369NRn/8WHyoHWIpQe84LrYkI3tGWYFK5gtVWYjPOl/s8c
	 f7AsQ/5qqFSjw==
From: Jiri Olsa <jolsa@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [RFC bpf-next 07/10] selftests/bpf: Add uprobe session test
Date: Tue,  4 Jun 2024 22:02:18 +0200
Message-ID: <20240604200221.377848-8-jolsa@kernel.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240604200221.377848-1-jolsa@kernel.org>
References: <20240604200221.377848-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding uprobe session test and testing that the entry program
return value controls execution of the return probe program.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../bpf/prog_tests/uprobe_multi_test.c        | 38 ++++++++++++++
 .../bpf/progs/uprobe_multi_session.c          | 52 +++++++++++++++++++
 2 files changed, 90 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/uprobe_multi_session.c

diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
index 8269cdee33ae..fddca2597818 100644
--- a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
@@ -5,6 +5,7 @@
 #include "uprobe_multi.skel.h"
 #include "uprobe_multi_bench.skel.h"
 #include "uprobe_multi_usdt.skel.h"
+#include "uprobe_multi_session.skel.h"
 #include "bpf/libbpf_internal.h"
 #include "testing_helpers.h"
 
@@ -497,6 +498,41 @@ static void test_link_api(void)
 	__test_link_api(child);
 }
 
+static void test_session_skel_api(void)
+{
+	struct uprobe_multi_session *skel = NULL;
+	LIBBPF_OPTS(bpf_kprobe_multi_opts, opts);
+	struct bpf_link *link = NULL;
+	int err;
+
+	skel = uprobe_multi_session__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "fentry_raw_skel_load"))
+		goto cleanup;
+
+	skel->bss->pid = getpid();
+
+	err = uprobe_multi_session__attach(skel);
+	if (!ASSERT_OK(err, " uprobe_multi_session__attach"))
+		goto cleanup;
+
+	/* trigger all probes */
+	skel->bss->uprobe_multi_func_1_addr = (__u64) uprobe_multi_func_1;
+	skel->bss->uprobe_multi_func_2_addr = (__u64) uprobe_multi_func_2;
+	skel->bss->uprobe_multi_func_3_addr = (__u64) uprobe_multi_func_3;
+
+	uprobe_multi_func_1();
+	uprobe_multi_func_2();
+	uprobe_multi_func_3();
+
+	ASSERT_EQ(skel->bss->uprobe_session_result[0], 1, "uprobe_multi_func_1_result");
+	ASSERT_EQ(skel->bss->uprobe_session_result[1], 2, "uprobe_multi_func_1_result");
+	ASSERT_EQ(skel->bss->uprobe_session_result[2], 1, "uprobe_multi_func_1_result");
+
+cleanup:
+	bpf_link__destroy(link);
+	uprobe_multi_session__destroy(skel);
+}
+
 static void test_bench_attach_uprobe(void)
 {
 	long attach_start_ns = 0, attach_end_ns = 0;
@@ -585,4 +621,6 @@ void test_uprobe_multi_test(void)
 		test_bench_attach_usdt();
 	if (test__start_subtest("attach_api_fails"))
 		test_attach_api_fails();
+	if (test__start_subtest("session"))
+		test_session_skel_api();
 }
diff --git a/tools/testing/selftests/bpf/progs/uprobe_multi_session.c b/tools/testing/selftests/bpf/progs/uprobe_multi_session.c
new file mode 100644
index 000000000000..b382d7d29475
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/uprobe_multi_session.c
@@ -0,0 +1,52 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include <stdbool.h>
+#include "bpf_kfuncs.h"
+#include "bpf_misc.h"
+
+char _license[] SEC("license") = "GPL";
+
+__u64 uprobe_multi_func_1_addr = 0;
+__u64 uprobe_multi_func_2_addr = 0;
+__u64 uprobe_multi_func_3_addr = 0;
+
+__u64 uprobe_session_result[3];
+
+int pid = 0;
+
+static int uprobe_multi_check(void *ctx, bool is_return)
+{
+	const __u64 funcs[] = {
+		uprobe_multi_func_1_addr,
+		uprobe_multi_func_2_addr,
+		uprobe_multi_func_3_addr,
+	};
+	unsigned int i;
+	__u64 addr;
+
+	if (bpf_get_current_pid_tgid() >> 32 != pid)
+		return 1;
+
+	addr = bpf_get_func_ip(ctx);
+
+	for (i = 0; i < ARRAY_SIZE(funcs); i++) {
+		if (funcs[i] == addr) {
+			uprobe_session_result[i]++;
+			break;
+                }
+        }
+
+	if ((addr == uprobe_multi_func_1_addr) ||
+	    (addr == uprobe_multi_func_3_addr))
+		return 1;
+
+	return 0;
+}
+
+SEC("uprobe.session//proc/self/exe:uprobe_multi_func_*")
+int uprobe(struct pt_regs *ctx)
+{
+	return uprobe_multi_check(ctx, bpf_session_is_return());
+}
-- 
2.45.1


