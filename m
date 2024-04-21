Return-Path: <bpf+bounces-27339-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7755C8AC107
	for <lists+bpf@lfdr.de>; Sun, 21 Apr 2024 21:43:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CCFD281234
	for <lists+bpf@lfdr.de>; Sun, 21 Apr 2024 19:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78CD04317B;
	Sun, 21 Apr 2024 19:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bdONDeQY"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD883A1A2;
	Sun, 21 Apr 2024 19:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713728573; cv=none; b=WvvsdzviaB4zgJDMoTcEatiExaRyeVdnX6R3UB0HL8Wu99ctx+2zFmIZzP7Tv2s9Kx6Yqj/XMRFPIecchxfwodFarXJLzkzqrWarsz/Rpsztgf4coIgAsCmOS35OXgShT6uQsc6C1/E3TPhMOcrgsQj1KWWx8bXK3IbkWSHTdHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713728573; c=relaxed/simple;
	bh=X3NKIEpwmKsyUxgmoaW6AEzBnvvIxsNfnxPt7ebcd1E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gmInzQtqQkXePP1h8WpJrGK2wLlq0faBC3knMqJ5PwDA+UR3xc5yH8D+Zn1Q33yTdQJWsU/pigYemDNvz9k2wPRgKkiQrHpVIJuQk67wNbb+k8rYXNlP97HcpHQuGFgYe8gIHufVUs5ObsvvXz1qamsfBbCl87cS69Rasec8Mac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bdONDeQY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B520BC113CE;
	Sun, 21 Apr 2024 19:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713728572;
	bh=X3NKIEpwmKsyUxgmoaW6AEzBnvvIxsNfnxPt7ebcd1E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bdONDeQYqtOSB2DmNo5syK+xl4CFS3mYTIG0lhBTSZ5zC6gYck/46zruYrf0IFOZQ
	 BQiVzWMyyQBWvu1MSSWX0GmtLZoG+JXU6yKwBWPXUQTToex3rmGJMMjWWsr3UB09Hd
	 bxEg47u5FHB0Iwn7aamw1tHNd2Ef49pA/T4Vj5YPcaj0SfAPraHlRKrH3Sx5VFb7ei
	 20ifdoN2jgfySM069H0B+HDrLZXn/Jmn4oOQ6yEhsuaSxyaG4pETcE10hdDL9AmEFr
	 cx0lPp8gtmF8PNS7IU9XI6SE6XdoCN8nh4o7eb7VG4/mWDjI1PKK5giFDFxRpar47a
	 z+OwxSqUkViiQ==
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
Subject: [PATCHv3 bpf-next 3/7] selftests/bpf: Add uretprobe syscall test for regs integrity
Date: Sun, 21 Apr 2024 21:42:02 +0200
Message-ID: <20240421194206.1010934-4-jolsa@kernel.org>
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

Add uretprobe syscall test that compares register values before
and after the uretprobe is hit. It also compares the register
values seen from attached bpf program.

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/include/linux/compiler.h                |   4 +
 .../selftests/bpf/prog_tests/uprobe_syscall.c | 163 ++++++++++++++++++
 .../selftests/bpf/progs/uprobe_syscall.c      |  15 ++
 3 files changed, 182 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
 create mode 100644 tools/testing/selftests/bpf/progs/uprobe_syscall.c

diff --git a/tools/include/linux/compiler.h b/tools/include/linux/compiler.h
index 8a63a9913495..6f7f22ac9da5 100644
--- a/tools/include/linux/compiler.h
+++ b/tools/include/linux/compiler.h
@@ -62,6 +62,10 @@
 #define __nocf_check __attribute__((nocf_check))
 #endif
 
+#ifndef __naked
+#define __naked __attribute__((__naked__))
+#endif
+
 /* Are two types/vars the same type (ignoring qualifiers)? */
 #ifndef __same_type
 # define __same_type(a, b) __builtin_types_compatible_p(typeof(a), typeof(b))
diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
new file mode 100644
index 000000000000..311ac19d8992
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
@@ -0,0 +1,163 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <test_progs.h>
+
+#ifdef __x86_64__
+
+#include <unistd.h>
+#include <asm/ptrace.h>
+#include <linux/compiler.h>
+#include "uprobe_syscall.skel.h"
+
+__naked unsigned long uretprobe_regs_trigger(void)
+{
+	asm volatile (
+		"movq $0xdeadbeef, %rax\n"
+		"ret\n"
+	);
+}
+
+__naked void uretprobe_regs(struct pt_regs *before, struct pt_regs *after)
+{
+	asm volatile (
+		"movq %r15,   0(%rdi)\n"
+		"movq %r14,   8(%rdi)\n"
+		"movq %r13,  16(%rdi)\n"
+		"movq %r12,  24(%rdi)\n"
+		"movq %rbp,  32(%rdi)\n"
+		"movq %rbx,  40(%rdi)\n"
+		"movq %r11,  48(%rdi)\n"
+		"movq %r10,  56(%rdi)\n"
+		"movq  %r9,  64(%rdi)\n"
+		"movq  %r8,  72(%rdi)\n"
+		"movq %rax,  80(%rdi)\n"
+		"movq %rcx,  88(%rdi)\n"
+		"movq %rdx,  96(%rdi)\n"
+		"movq %rsi, 104(%rdi)\n"
+		"movq %rdi, 112(%rdi)\n"
+		"movq   $0, 120(%rdi)\n" /* orig_rax */
+		"movq   $0, 128(%rdi)\n" /* rip      */
+		"movq   $0, 136(%rdi)\n" /* cs       */
+		"pushf\n"
+		"pop %rax\n"
+		"movq %rax, 144(%rdi)\n" /* eflags   */
+		"movq %rsp, 152(%rdi)\n" /* rsp      */
+		"movq   $0, 160(%rdi)\n" /* ss       */
+
+		/* save 2nd argument */
+		"pushq %rsi\n"
+		"call uretprobe_regs_trigger\n"
+
+		/* save  return value and load 2nd argument pointer to rax */
+		"pushq %rax\n"
+		"movq 8(%rsp), %rax\n"
+
+		"movq %r15,   0(%rax)\n"
+		"movq %r14,   8(%rax)\n"
+		"movq %r13,  16(%rax)\n"
+		"movq %r12,  24(%rax)\n"
+		"movq %rbp,  32(%rax)\n"
+		"movq %rbx,  40(%rax)\n"
+		"movq %r11,  48(%rax)\n"
+		"movq %r10,  56(%rax)\n"
+		"movq  %r9,  64(%rax)\n"
+		"movq  %r8,  72(%rax)\n"
+		"movq %rcx,  88(%rax)\n"
+		"movq %rdx,  96(%rax)\n"
+		"movq %rsi, 104(%rax)\n"
+		"movq %rdi, 112(%rax)\n"
+		"movq   $0, 120(%rax)\n" /* orig_rax */
+		"movq   $0, 128(%rax)\n" /* rip      */
+		"movq   $0, 136(%rax)\n" /* cs       */
+
+		/* restore return value and 2nd argument */
+		"pop %rax\n"
+		"pop %rsi\n"
+
+		"movq %rax,  80(%rsi)\n"
+
+		"pushf\n"
+		"pop %rax\n"
+
+		"movq %rax, 144(%rsi)\n" /* eflags   */
+		"movq %rsp, 152(%rsi)\n" /* rsp      */
+		"movq   $0, 160(%rsi)\n" /* ss       */
+		"ret\n"
+);
+}
+
+static void test_uretprobe_regs_equal(void)
+{
+	struct uprobe_syscall *skel = NULL;
+	struct pt_regs before = {}, after = {};
+	unsigned long *pb = (unsigned long *) &before;
+	unsigned long *pa = (unsigned long *) &after;
+	unsigned long *pp;
+	unsigned int i, cnt;
+	int err;
+
+	skel = uprobe_syscall__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "uprobe_syscall__open_and_load"))
+		goto cleanup;
+
+	err = uprobe_syscall__attach(skel);
+	if (!ASSERT_OK(err, "uprobe_syscall__attach"))
+		goto cleanup;
+
+	uretprobe_regs(&before, &after);
+
+	pp = (unsigned long *) &skel->bss->regs;
+	cnt = sizeof(before)/sizeof(*pb);
+
+	for (i = 0; i < cnt; i++) {
+		unsigned int offset = i * sizeof(unsigned long);
+
+		/*
+		 * Check register before and after uretprobe_regs_trigger call
+		 * that triggers the uretprobe.
+		 */
+		switch (offset) {
+		case offsetof(struct pt_regs, rax):
+			ASSERT_EQ(pa[i], 0xdeadbeef, "return value");
+			break;
+		default:
+			if (!ASSERT_EQ(pb[i], pa[i], "register before-after value check"))
+				fprintf(stdout, "failed register offset %u\n", offset);
+		}
+
+		/*
+		 * Check register seen from bpf program and register after
+		 * uretprobe_regs_trigger call
+		 */
+		switch (offset) {
+		/*
+		 * These values will be different (not set in uretprobe_regs),
+		 * we don't care.
+		 */
+		case offsetof(struct pt_regs, orig_rax):
+		case offsetof(struct pt_regs, rip):
+		case offsetof(struct pt_regs, cs):
+		case offsetof(struct pt_regs, rsp):
+		case offsetof(struct pt_regs, ss):
+			break;
+		default:
+			if (!ASSERT_EQ(pp[i], pa[i], "register prog-after value check"))
+				fprintf(stdout, "failed register offset %u\n", offset);
+		}
+	}
+
+cleanup:
+	uprobe_syscall__destroy(skel);
+}
+#else
+static void test_uretprobe_regs_equal(void)
+{
+	test__skip();
+}
+#endif
+
+void test_uprobe_syscall(void)
+{
+	if (test__start_subtest("uretprobe_regs_equal"))
+		test_uretprobe_regs_equal();
+}
diff --git a/tools/testing/selftests/bpf/progs/uprobe_syscall.c b/tools/testing/selftests/bpf/progs/uprobe_syscall.c
new file mode 100644
index 000000000000..8a4fa6c7ef59
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/uprobe_syscall.c
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
+SEC("uretprobe//proc/self/exe:uretprobe_regs_trigger")
+int uretprobe(struct pt_regs *ctx)
+{
+	__builtin_memcpy(&regs, ctx, sizeof(regs));
+	return 0;
+}
-- 
2.44.0


