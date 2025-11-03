Return-Path: <bpf+bounces-73389-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A83C2E376
	for <lists+bpf@lfdr.de>; Mon, 03 Nov 2025 23:10:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 44D734E2F61
	for <lists+bpf@lfdr.de>; Mon,  3 Nov 2025 22:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9FBE2DEA90;
	Mon,  3 Nov 2025 22:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iqeD1s65"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE522D6E76;
	Mon,  3 Nov 2025 22:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762207806; cv=none; b=FdQUd0yYysV+HFNbT8qKoc+CJ1hCaTlN0OWIjNdTPLMZFJqU1Q9wIuVw2m+GQa9C/VA9TFbqjvL2TLgd2hEpM7so1kkdw1LrACCtiRw52pOnr5lgFdUKGPNvDihhpgrHr9rmSJa8MAhcJV4T58dgvNWlkZmNMkc0Q/FA2DY5Wdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762207806; c=relaxed/simple;
	bh=pkfQpo+GbEUDIH7vRI1r5mF97ogVir0MXeOYNkMWYXg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kgJiO3X+nTI4Ery1rQILUUBJ7aUQ0GzUVwtZeKG08+VATkUMVBOWGSHAKy72bbCv0eo5Fmz0sfhdvg3FKLn91+PjpNLuLjx7QEfh/9KcTFwEbqYrUuZXYtkItE4yAiNgY7t0dvPDf07w6gpHaLvjU9ATG8SJqByu3G4av8J+tDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iqeD1s65; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C70BC4CEE7;
	Mon,  3 Nov 2025 22:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762207805;
	bh=pkfQpo+GbEUDIH7vRI1r5mF97ogVir0MXeOYNkMWYXg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iqeD1s65WyOw3iP4DLe+ZD5s+nmP8j3X4KHN3g8hLcW4f3djKS+k7rUr7A8kfT5dJ
	 2eS5zHE69Tz1Xguh2JAa8ThOnhFDwYgodzpq+1IrHhqlBzU54iDVZsFQPBCGqkq8ZP
	 qirv4LmuJ8/NNI7xoBNMJCLJv3rV3M9IpcUca5Nn2jFV4+fnOH6TT7oUS2/QDUe4ll
	 f6Rcr/3ThmARSsSTwP6W/O7rRKGi9pn3gnNjqctQpA/uamwxpCllNOqLLRLV5Wh+O6
	 +HF41a8IJUPzoHLKgUpdjWRVcutoP5SxzxW2fzSllg29E4prtySFZdk5kFU28nVMh/
	 9R6avi2cgZEbA==
From: Jiri Olsa <jolsa@kernel.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
	bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	x86@kernel.org,
	Yonghong Song <yhs@fb.com>,
	Song Liu <songliubraving@fb.com>,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCHv2 3/4] selftests/bpf: Add stacktrace ips test for kprobe_multi/kretprobe_multi
Date: Mon,  3 Nov 2025 23:09:23 +0100
Message-ID: <20251103220924.36371-4-jolsa@kernel.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251103220924.36371-1-jolsa@kernel.org>
References: <20251103220924.36371-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding test that attaches kprobe/kretprobe multi and verifies the
ORC stacktrace matches expected functions.

Adding bpf_testmod_stacktrace_test function to bpf_testmod kernel
module which is called through several functions so we get reliable
call path for stacktrace.

The test is only for ORC unwinder to keep it simple.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../selftests/bpf/prog_tests/stacktrace_ips.c | 104 ++++++++++++++++++
 .../selftests/bpf/progs/stacktrace_ips.c      |  41 +++++++
 .../selftests/bpf/test_kmods/bpf_testmod.c    |  26 +++++
 3 files changed, 171 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/stacktrace_ips.c
 create mode 100644 tools/testing/selftests/bpf/progs/stacktrace_ips.c

diff --git a/tools/testing/selftests/bpf/prog_tests/stacktrace_ips.c b/tools/testing/selftests/bpf/prog_tests/stacktrace_ips.c
new file mode 100644
index 000000000000..6fca459ba550
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/stacktrace_ips.c
@@ -0,0 +1,104 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+#include "stacktrace_ips.skel.h"
+
+#ifdef __x86_64__
+static int check_stacktrace_ips(int fd, __u32 key, int cnt, ...)
+{
+	__u64 ips[PERF_MAX_STACK_DEPTH];
+	struct ksyms *ksyms = NULL;
+	int i, err = 0;
+	va_list args;
+
+	/* sorted by addr */
+	ksyms = load_kallsyms_local();
+	if (!ASSERT_OK_PTR(ksyms, "load_kallsyms_local"))
+		return -1;
+
+	/* unlikely, but... */
+	if (!ASSERT_LT(cnt, PERF_MAX_STACK_DEPTH, "check_max"))
+		return -1;
+
+	err = bpf_map_lookup_elem(fd, &key, ips);
+	if (err)
+		goto out;
+
+	/*
+	 * Compare all symbols provided via arguments with stacktrace ips,
+	 * and their related symbol addresses.t
+	 */
+	va_start(args, cnt);
+
+	for (i = 0; i < cnt; i++) {
+		unsigned long val;
+		struct ksym *ksym;
+
+		val = va_arg(args, unsigned long);
+		ksym = ksym_search_local(ksyms, ips[i]);
+		if (!ASSERT_OK_PTR(ksym, "ksym_search_local"))
+			break;
+		ASSERT_EQ(ksym->addr, val, "stack_cmp");
+	}
+
+	va_end(args);
+
+out:
+	free_kallsyms_local(ksyms);
+	return err;
+}
+
+static void test_stacktrace_ips_kprobe_multi(bool retprobe)
+{
+	LIBBPF_OPTS(bpf_kprobe_multi_opts, opts,
+		.retprobe = retprobe
+	);
+	LIBBPF_OPTS(bpf_test_run_opts, topts);
+	struct stacktrace_ips *skel;
+
+	skel = stacktrace_ips__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "stacktrace_ips__open_and_load"))
+		return;
+
+	if (!skel->kconfig->CONFIG_UNWINDER_ORC) {
+		test__skip();
+		goto cleanup;
+	}
+
+	skel->links.kprobe_multi_test = bpf_program__attach_kprobe_multi_opts(
+							skel->progs.kprobe_multi_test,
+							"bpf_testmod_stacktrace_test", &opts);
+	if (!ASSERT_OK_PTR(skel->links.kprobe_multi_test, "bpf_program__attach_kprobe_multi_opts"))
+		goto cleanup;
+
+	trigger_module_test_read(1);
+
+	load_kallsyms();
+
+	check_stacktrace_ips(bpf_map__fd(skel->maps.stackmap), skel->bss->stack_key, 4,
+			     ksym_get_addr("bpf_testmod_stacktrace_test_3"),
+			     ksym_get_addr("bpf_testmod_stacktrace_test_2"),
+			     ksym_get_addr("bpf_testmod_stacktrace_test_1"),
+			     ksym_get_addr("bpf_testmod_test_read"));
+
+cleanup:
+	stacktrace_ips__destroy(skel);
+}
+
+static void __test_stacktrace_ips(void)
+{
+	if (test__start_subtest("kprobe_multi"))
+		test_stacktrace_ips_kprobe_multi(false);
+	if (test__start_subtest("kretprobe_multi"))
+		test_stacktrace_ips_kprobe_multi(true);
+}
+#else
+static void __test_stacktrace_ips(void)
+{
+	test__skip();
+}
+#endif
+
+void test_stacktrace_ips(void)
+{
+	__test_stacktrace_ips();
+}
diff --git a/tools/testing/selftests/bpf/progs/stacktrace_ips.c b/tools/testing/selftests/bpf/progs/stacktrace_ips.c
new file mode 100644
index 000000000000..e2eb30945c1b
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/stacktrace_ips.c
@@ -0,0 +1,41 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2018 Facebook
+
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+#ifndef PERF_MAX_STACK_DEPTH
+#define PERF_MAX_STACK_DEPTH         127
+#endif
+
+typedef __u64 stack_trace_t[PERF_MAX_STACK_DEPTH];
+
+struct {
+	__uint(type, BPF_MAP_TYPE_STACK_TRACE);
+	__uint(max_entries, 16384);
+	__type(key, __u32);
+	__type(value, stack_trace_t);
+} stackmap SEC(".maps");
+
+extern bool CONFIG_UNWINDER_ORC __kconfig __weak;
+
+/*
+ * This function is here to have CONFIG_UNWINDER_ORC
+ * used and added to object BTF.
+ */
+int unused(void)
+{
+	return CONFIG_UNWINDER_ORC ? 0 : 1;
+}
+
+__u32 stack_key;
+
+SEC("kprobe.multi")
+int kprobe_multi_test(struct pt_regs *ctx)
+{
+	stack_key = bpf_get_stackid(ctx, &stackmap, 0);
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
index 8074bc5f6f20..ed0a4721d8fd 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
@@ -417,6 +417,30 @@ noinline int bpf_testmod_fentry_test11(u64 a, void *b, short c, int d,
 	return a + (long)b + c + d + (long)e + f + g + h + i + j + k;
 }
 
+noinline void bpf_testmod_stacktrace_test(void)
+{
+	/* used for stacktrace test as attach function */
+	asm volatile ("");
+}
+
+noinline void bpf_testmod_stacktrace_test_3(void)
+{
+	bpf_testmod_stacktrace_test();
+	asm volatile ("");
+}
+
+noinline void bpf_testmod_stacktrace_test_2(void)
+{
+	bpf_testmod_stacktrace_test_3();
+	asm volatile ("");
+}
+
+noinline void bpf_testmod_stacktrace_test_1(void)
+{
+	bpf_testmod_stacktrace_test_2();
+	asm volatile ("");
+}
+
 int bpf_testmod_fentry_ok;
 
 noinline ssize_t
@@ -497,6 +521,8 @@ bpf_testmod_test_read(struct file *file, struct kobject *kobj,
 			21, 22, 23, 24, 25, 26) != 231)
 		goto out;
 
+	bpf_testmod_stacktrace_test_1();
+
 	bpf_testmod_fentry_ok = 1;
 out:
 	return -EIO; /* always fail */
-- 
2.51.0


