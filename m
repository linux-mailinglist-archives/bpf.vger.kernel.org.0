Return-Path: <bpf+bounces-72322-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 06802C0DFC7
	for <lists+bpf@lfdr.de>; Mon, 27 Oct 2025 14:22:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3C74B4FD283
	for <lists+bpf@lfdr.de>; Mon, 27 Oct 2025 13:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D910261B62;
	Mon, 27 Oct 2025 13:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="naeRLVke"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A513825B30D;
	Mon, 27 Oct 2025 13:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761570875; cv=none; b=u9jomOPw00lrzAvb465oNo51YIli7F6Wuyb+c6MWOeVbbzw1K5Fz6UpbptFPVMhQm8ef4QXFyeKmh4Vm1w7ZQ0N8m08aZdRBGlrC0C8k7NETIhYtuySdc1aaqDE0ikg3SsQTTRgACGUbBG7TVDG4qVjCLx0tMC9JuhhkVYm3pa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761570875; c=relaxed/simple;
	bh=BhUBkDm+5bDEWJKmZohGzkyIrmtlNTNl+61vkFEvsA0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YOaBUjlOHsDBRyD9S+kbpWTufyJ9JarBEwJlyICXktd+5AHJWHeYxLJ4962AUSnjZKDLwSo+5Bv0GtXbTLtTGIzukpm7RV27rTfrGa4GUuF/56WFJJFr0zkkicTnMu4K5wCOazCOkAzENA69ZA19vYiFfPaAbVEW/hLq4PBVN8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=naeRLVke; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CED06C4CEF1;
	Mon, 27 Oct 2025 13:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761570875;
	bh=BhUBkDm+5bDEWJKmZohGzkyIrmtlNTNl+61vkFEvsA0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=naeRLVkeQoD5dT874J2PpIb1TFad+jKeXhw90Pmz3VxjELgexrAeSh50qsd+inY6j
	 4Cg8IkZxMn8QPzvGrG4tgpLjzb6ht/qA/ZIT/PqBUzsPbr5QGVDr2rZ/O3h0GXrZb+
	 CVzdLS+ZDDcvYhh8htdiwmLyUhl+ln+Vs0NE66iBph+fXXwalITnfqVzvOmIXdEvw6
	 n3TRPtnCaVUgg+mOOH3OqRlCcaMC1ofBPVrGH3XFcOMjpyEMAiQ3hSahhuhQ6bslkU
	 LiEtFlEWE5DohzIOIvR22XtRSWztoWEgdM4xtKqV9J/6kTGSDbBWP+oK/Zc5uhSGtg
	 HQ7uprd7YdJEQ==
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
Subject: [PATCH 3/3] selftests/bpf: Add stacktrace ips test for kprobe_multi/kretprobe_multi
Date: Mon, 27 Oct 2025 14:13:54 +0100
Message-ID: <20251027131354.1984006-4-jolsa@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251027131354.1984006-1-jolsa@kernel.org>
References: <20251027131354.1984006-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding test that attaches kprobe/kretprobe multi and verifies the
ORC stacktrace matches expected functions.

It skips the test for if kernels built with frame pointer unwinder.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../selftests/bpf/prog_tests/stacktrace_ips.c | 108 ++++++++++++++++++
 .../selftests/bpf/progs/stacktrace_ips.c      |  51 +++++++++
 .../selftests/bpf/test_kmods/bpf_testmod.c    |  26 +++++
 3 files changed, 185 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/stacktrace_ips.c
 create mode 100644 tools/testing/selftests/bpf/progs/stacktrace_ips.c

diff --git a/tools/testing/selftests/bpf/prog_tests/stacktrace_ips.c b/tools/testing/selftests/bpf/prog_tests/stacktrace_ips.c
new file mode 100644
index 000000000000..3dfa03be6cd0
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/stacktrace_ips.c
@@ -0,0 +1,108 @@
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
+	va_start(args, cnt);
+
+	for (i = 0; i < cnt; i++) {
+		unsigned long val;
+		struct ksym *ksym;
+
+		if (!ASSERT_NEQ(ips[i], 0, "ip_not_zero"))
+			break;
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
+	int prog_fd, err;
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
+	skel->links.kprobe_multi_stack_test = bpf_program__attach_kprobe_multi_opts(
+							skel->progs.kprobe_multi_stack_test,
+							"bpf_testmod_stacktrace_test", &opts);
+	if (!ASSERT_OK_PTR(skel->links.kprobe_multi_stack_test, "bpf_program__attach_kprobe_multi_opts"))
+		goto cleanup;
+
+	prog_fd = bpf_program__fd(skel->progs.trigger);
+	err = bpf_prog_test_run_opts(prog_fd, &topts);
+	ASSERT_OK(err, "test_run");
+	ASSERT_EQ(topts.retval, 0, "test_run");
+
+	trigger_module_test_read(1);
+
+	load_kallsyms();
+
+	check_stacktrace_ips(bpf_map__fd(skel->maps.stackmap), skel->bss->stack_key, 3,
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
index 000000000000..984b5b838885
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/stacktrace_ips.c
@@ -0,0 +1,51 @@
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
+/*
+ * No tests in here, just to trigger 'bpf_fentry_test*'
+ * through tracing test_run.
+ */
+SEC("fentry/bpf_modify_return_test")
+int BPF_PROG(trigger)
+{
+       return 0;
+}
+
+SEC("kprobe.multi")
+int kprobe_multi_stack_test(struct pt_regs *ctx)
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


