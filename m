Return-Path: <bpf+bounces-31816-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDB829039EC
	for <lists+bpf@lfdr.de>; Tue, 11 Jun 2024 13:24:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87835285550
	for <lists+bpf@lfdr.de>; Tue, 11 Jun 2024 11:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B2C917BB07;
	Tue, 11 Jun 2024 11:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZDPpeosE"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D48417B43C;
	Tue, 11 Jun 2024 11:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718105011; cv=none; b=U5AbgSwEK9MtG+vpYXkMEz2F30Wd7q8dGSzAT398AhzaAF9MwhsjfqMo9WK9hSrEWz1b4h/qgtUlKLeggKTee676ugJLrJZK/Lqhnmj27AqyMNAC8CB5zekacaUaxFI9w8qsGQIHDnQ2Z4V3cp503bDjBvBG57Ay6TqE1k7tSe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718105011; c=relaxed/simple;
	bh=DS7+Hm0OTr8osb55SvuyMe5tP8h/Tdu7u34TgYWZPvY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F62dBn8OSxiMJydSxHqJ7jIp852aGfQEW9DV4lXFKH06dtUcC3PicPUkWCz+Y8tCB2f6kqA+PPVvhzkFR4jv7LCQiPvpFdyviJqyyd6WDE1FkIFg/OMr5uKsTHsP4N8HpGeYobgb3szzIRkPGc3CggpNErJ/n5DWip/VopYzefo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZDPpeosE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96188C2BD10;
	Tue, 11 Jun 2024 11:23:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718105011;
	bh=DS7+Hm0OTr8osb55SvuyMe5tP8h/Tdu7u34TgYWZPvY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZDPpeosE+xJNrxZxbqf+GIQzdu1azY0JaPfrO+WFsnebOBCD9J+ZdvlkdKE1GZ3kY
	 x1FEJB0f2M4nTLyuQ991TK1EDwlRq0YWSvX1clzNuRqV+li1OGR7mx4B0Ay8X9NxxJ
	 x3FR3iiAN3IK8MzqPU83AXPyX7S2IIU2UZXuy4Y4TvhE2Ii6afukrdAGFTlExSzK30
	 cAJRsBiNBhWkkP3XrVC98aUxQHAsH6Ji5mZlaf7McUjoBpdvGy+4ZhnFPB+ASP3y4t
	 SQbCFiWbuI+Ddr1ibAQ5akPC3T6VWPaPmXkcHSJyDQifFMqh3AkG9jEpjwPuOA9Oa0
	 lINLeKphbq8vQ==
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
	linux-man@vger.kernel.org,
	x86@kernel.org,
	bpf@vger.kernel.org,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Ingo Molnar <mingo@redhat.com>,
	Andy Lutomirski <luto@kernel.org>,
	"Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
	Deepak Gupta <debug@rivosinc.com>
Subject: [PATCHv8 bpf-next 7/9] selftests/bpf: Add uretprobe syscall call from user space test
Date: Tue, 11 Jun 2024 13:21:56 +0200
Message-ID: <20240611112158.40795-8-jolsa@kernel.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240611112158.40795-1-jolsa@kernel.org>
References: <20240611112158.40795-1-jolsa@kernel.org>
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
program is not executed.

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../selftests/bpf/prog_tests/uprobe_syscall.c | 95 +++++++++++++++++++
 .../bpf/progs/uprobe_syscall_executed.c       | 17 ++++
 2 files changed, 112 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/uprobe_syscall_executed.c

diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
index 1a50cd35205d..11ccd693ef73 100644
--- a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
+++ b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
@@ -7,7 +7,10 @@
 #include <unistd.h>
 #include <asm/ptrace.h>
 #include <linux/compiler.h>
+#include <linux/stringify.h>
+#include <sys/wait.h>
 #include "uprobe_syscall.skel.h"
+#include "uprobe_syscall_executed.skel.h"
 
 __naked unsigned long uretprobe_regs_trigger(void)
 {
@@ -209,6 +212,91 @@ static void test_uretprobe_regs_change(void)
 	}
 }
 
+#ifndef __NR_uretprobe
+#define __NR_uretprobe 463
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
+static void test_uretprobe_syscall_call(void)
+{
+	LIBBPF_OPTS(bpf_uprobe_multi_opts, opts,
+		.retprobe = true,
+	);
+	struct uprobe_syscall_executed *skel;
+	int pid, status, err, go[2], c;
+
+	if (ASSERT_OK(pipe(go), "pipe"))
+		return;
+
+	skel = uprobe_syscall_executed__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "uprobe_syscall_executed__open_and_load"))
+		goto cleanup;
+
+	pid = fork();
+	if (!ASSERT_GE(pid, 0, "fork"))
+		goto cleanup;
+
+	/* child */
+	if (pid == 0) {
+		close(go[1]);
+
+		/* wait for parent's kick */
+		err = read(go[0], &c, 1);
+		if (err != 1)
+			exit(-1);
+
+		uretprobe_syscall_call();
+		_exit(0);
+	}
+
+	skel->links.test = bpf_program__attach_uprobe_multi(skel->progs.test, pid,
+							    "/proc/self/exe",
+							    "uretprobe_syscall_call", &opts);
+	if (!ASSERT_OK_PTR(skel->links.test, "bpf_program__attach_uprobe_multi"))
+		goto cleanup;
+
+	/* kick the child */
+	write(go[1], &c, 1);
+	err = waitpid(pid, &status, 0);
+	ASSERT_EQ(err, pid, "waitpid");
+
+	/* verify the child got killed with SIGILL */
+	ASSERT_EQ(WIFSIGNALED(status), 1, "WIFSIGNALED");
+	ASSERT_EQ(WTERMSIG(status), SIGILL, "WTERMSIG");
+
+	/* verify the uretprobe program wasn't called */
+	ASSERT_EQ(skel->bss->executed, 0, "executed");
+
+cleanup:
+	uprobe_syscall_executed__destroy(skel);
+	close(go[1]);
+	close(go[0]);
+}
 #else
 static void test_uretprobe_regs_equal(void)
 {
@@ -219,6 +307,11 @@ static void test_uretprobe_regs_change(void)
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
@@ -227,4 +320,6 @@ void test_uprobe_syscall(void)
 		test_uretprobe_regs_equal();
 	if (test__start_subtest("uretprobe_regs_change"))
 		test_uretprobe_regs_change();
+	if (test__start_subtest("uretprobe_syscall_call"))
+		test_uretprobe_syscall_call();
 }
diff --git a/tools/testing/selftests/bpf/progs/uprobe_syscall_executed.c b/tools/testing/selftests/bpf/progs/uprobe_syscall_executed.c
new file mode 100644
index 000000000000..0d7f1a7db2e2
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/uprobe_syscall_executed.c
@@ -0,0 +1,17 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <string.h>
+
+struct pt_regs regs;
+
+char _license[] SEC("license") = "GPL";
+
+int executed = 0;
+
+SEC("uretprobe.multi")
+int test(struct pt_regs *regs)
+{
+	executed = 1;
+	return 0;
+}
-- 
2.45.1


