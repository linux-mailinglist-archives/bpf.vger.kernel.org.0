Return-Path: <bpf+bounces-27341-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 400A98AC10D
	for <lists+bpf@lfdr.de>; Sun, 21 Apr 2024 21:43:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF2CE2812A8
	for <lists+bpf@lfdr.de>; Sun, 21 Apr 2024 19:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32A293FE51;
	Sun, 21 Apr 2024 19:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jn7soWvs"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A31F53FB14;
	Sun, 21 Apr 2024 19:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713728596; cv=none; b=DO4s5P3T4TVYKFwYxr1kvq3Q7f+CFpb7wR+n2WR5MMw6H1+4Uv1GUOpo1jyz/xj20HsRRoYUpdHIPYWVhheH9XkM7lj/RqZB+ah9bgq9V8vBL2Pgh3FDdSMcM62YlaOttNqoxOp7mWD7D3rU307sle7NyeV90uAjdIk4AlBVNnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713728596; c=relaxed/simple;
	bh=zXsQFP+lBWcQOzhNUiIZY9EDEZ2vOGD8pKD7bKL08jE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XidYYX0vf+hWCAlyaEKMv2ynEQC6Rcyyt6809PuPAcGCWGSqDk5vqpfSQAqvbRfGiyPa4BUsiQIM40Fcl2DuCuGDE8+XrKGWWAXa79EaIlmJp0JsruO7oZO7icTCrvHUC8bWcu1HS2fQc0clHrINL2U5omYk8DolW4oJuizBoIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jn7soWvs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B21F9C113CE;
	Sun, 21 Apr 2024 19:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713728596;
	bh=zXsQFP+lBWcQOzhNUiIZY9EDEZ2vOGD8pKD7bKL08jE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Jn7soWvs0sLr9hsTFqTnjXPH+4DzuW3o3L0MDPilqGczRK9fX7SmEV5p9Q+3PA8Gc
	 /tHNoVHpEtrnDhSQ+5+FDP1KT83QyT9vyVk12ySLSS2pBl+rViPWm/65YekugUoCG2
	 vNo+Woa8nRi0iVTJxsnZMLwz3xT+oxNySIhAAhuXJ05FBQR7WcHS7G9+0R8DTf+GMx
	 UygmSGPv5AaWIgi7DFjz+5qpl17T7j+oR6UeramK0hdiWxQBGlqpzveX5XksKttmos
	 ABHkegTKGpBGDKmxyXqXoXz+wiXk3NUDZ96dpY7E6OmmYwbci2KutYpCq7dlunpJNn
	 Smru/o4B/1Mlg==
From: Jiri Olsa <jolsa@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-api@vger.kernel.org,
	x86@kernel.org,
	bpf@vger.kernel.org,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Ingo Molnar <mingo@redhat.com>,
	Andy Lutomirski <luto@kernel.org>
Subject: [PATCHv3 bpf-next 5/7] selftests/bpf: Add uretprobe syscall call from user space test
Date: Sun, 21 Apr 2024 21:42:04 +0200
Message-ID: <20240421194206.1010934-6-jolsa@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240421194206.1010934-1-jolsa@kernel.org>
References: <20240421194206.1010934-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding test to verify that when called from outside of the
trampoline provided by kernel, the uretprobe syscall will cause
calling process to receive SIGILL signal and the attached bpf
program is no executed.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../selftests/bpf/prog_tests/uprobe_syscall.c | 92 +++++++++++++++++++
 .../selftests/bpf/progs/uprobe_syscall_call.c | 15 +++
 2 files changed, 107 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/uprobe_syscall_call.c

diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
index 1a50cd35205d..9233210a4c33 100644
--- a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
+++ b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
@@ -7,7 +7,10 @@
 #include <unistd.h>
 #include <asm/ptrace.h>
 #include <linux/compiler.h>
+#include <linux/stringify.h>
+#include <sys/wait.h>
 #include "uprobe_syscall.skel.h"
+#include "uprobe_syscall_call.skel.h"
 
 __naked unsigned long uretprobe_regs_trigger(void)
 {
@@ -209,6 +212,85 @@ static void test_uretprobe_regs_change(void)
 	}
 }
 
+#ifndef __NR_uretprobe
+#define __NR_uretprobe 462
+#endif
+
+__naked unsigned long uretprobe_syscall_call_1(void)
+{
+	/*
+	 * Pretend we are uretprobe trampoline to trigger the return
+	 * probe invocation in order to verify we get SIGILL.
+	 */
+	asm volatile (
+		"pushq %rax\n"
+		"pushq %rcx\n"
+		"pushq %r11\n"
+		"movq $" __stringify(__NR_uretprobe) ", %rax\n"
+		"syscall\n"
+		"popq %r11\n"
+		"popq %rcx\n"
+		"retq\n"
+	);
+}
+
+__naked unsigned long uretprobe_syscall_call(void)
+{
+	asm volatile (
+		"call uretprobe_syscall_call_1\n"
+		"retq\n"
+	);
+}
+
+static void __test_uretprobe_syscall_call(void)
+{
+	struct uprobe_syscall_call *skel = NULL;
+	int err;
+
+	skel = uprobe_syscall_call__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "uprobe_syscall_call__open_and_load"))
+		goto cleanup;
+
+	err = uprobe_syscall_call__attach(skel);
+	if (!ASSERT_OK(err, "uprobe_syscall_call__attach"))
+		goto cleanup;
+
+	uretprobe_syscall_call();
+
+cleanup:
+	uprobe_syscall_call__destroy(skel);
+}
+
+static void trace_pipe_cb(const char *str, void *data)
+{
+	if (strstr(str, "uretprobe called") != NULL)
+		(*(int *)data)++;
+}
+
+static void test_uretprobe_syscall_call(void)
+{
+	int pid, status, found = 0;
+
+	pid = fork();
+	if (!ASSERT_GE(pid, 0, "fork"))
+		return;
+
+	if (pid == 0) {
+		__test_uretprobe_syscall_call();
+		_exit(0);
+	}
+
+	waitpid(pid, &status, 0);
+
+	/* verify the child got killed with SIGILL */
+	ASSERT_EQ(WIFSIGNALED(status), 1, "WIFSIGNALED");
+	ASSERT_EQ(WTERMSIG(status), SIGILL, "WTERMSIG");
+
+	/* verify the uretprobe program wasn't called */
+	ASSERT_OK(read_trace_pipe_iter(trace_pipe_cb, &found, 1000),
+		 "read_trace_pipe_iter");
+	ASSERT_EQ(found, 0, "found");
+}
 #else
 static void test_uretprobe_regs_equal(void)
 {
@@ -219,6 +301,11 @@ static void test_uretprobe_regs_change(void)
 {
 	test__skip();
 }
+
+static void test_uretprobe_syscall_call(void)
+{
+	test__skip();
+}
 #endif
 
 void test_uprobe_syscall(void)
@@ -228,3 +315,8 @@ void test_uprobe_syscall(void)
 	if (test__start_subtest("uretprobe_regs_change"))
 		test_uretprobe_regs_change();
 }
+
+void serial_test_uprobe_syscall_call(void)
+{
+	test_uretprobe_syscall_call();
+}
diff --git a/tools/testing/selftests/bpf/progs/uprobe_syscall_call.c b/tools/testing/selftests/bpf/progs/uprobe_syscall_call.c
new file mode 100644
index 000000000000..5ea03bb47198
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/uprobe_syscall_call.c
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <string.h>
+
+struct pt_regs regs;
+
+char _license[] SEC("license") = "GPL";
+
+SEC("uretprobe//proc/self/exe:uretprobe_syscall_call")
+int uretprobe(struct pt_regs *regs)
+{
+	bpf_printk("uretprobe called");
+	return 0;
+}
-- 
2.44.0


