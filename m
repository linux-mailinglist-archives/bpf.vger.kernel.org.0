Return-Path: <bpf+bounces-30106-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C5858CAC92
	for <lists+bpf@lfdr.de>; Tue, 21 May 2024 12:50:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11A4B282701
	for <lists+bpf@lfdr.de>; Tue, 21 May 2024 10:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9CBE73173;
	Tue, 21 May 2024 10:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FVc8/R1L"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536FF6F086;
	Tue, 21 May 2024 10:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716288575; cv=none; b=byUjrFjwXFIcy9zFHCfw1b41i0r4pJKj7QphtE3YfbrsHXO7FPR0SqAIOlSDqkBB2kEUrc7PzyQxfHDta2qBoZk0pmyUWxQqwFkfF3ioI3fRCuR0+seDREDJL4QtrAjslHm361ojNPm4IL9/c+a0Lo0vqUXmWXtg81SJJ0FHjj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716288575; c=relaxed/simple;
	bh=lW/3gzi9X62qpxx+XfjSgU8B5H9BM2eiM14Ks29Hm10=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CbdTmaxIU4INWE8yOGJoTLyScYJwAe9Az4anLmZ9plUZxAU+ClvscVfcwTACmE0yWWphYXw1rwfbf5sT1QZ5p2Lo457sO4Oojaf4h/9Kj3x2YIhjvyVCDZyK0sEUK/LL7xQzG8ZJQzpapg3UetgdLzgf5diIensCIncAbaFnwvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FVc8/R1L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66D0BC4AF0E;
	Tue, 21 May 2024 10:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716288575;
	bh=lW/3gzi9X62qpxx+XfjSgU8B5H9BM2eiM14Ks29Hm10=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FVc8/R1L53KFJ48iZ2iLycmDxu2dE/vQ1Rvh3NzcIN7CKenZYw1e3JV0c/1YeyywX
	 leHFIQl+Fx6M2GM7FPiI7eH3cW9fvW4ihrWK4WoyAYr+Ser7ZcEO3a8oMoM/O3jFqu
	 UD3i4ITyufjg80zLH0O9CJ/Zvrcw1BftjhfPIxcjnWHkl9sgrb56pjSFaGO9u8GsK6
	 WiW8K4bAKNPjLJa9Jpjarv6b7TUVYLmpkbi+ru6uRs7zhgMtHiXrYTZA1QFdCimkdR
	 qRPfB1SAbBWNc1IoiXpDL7jOByIKNPFk5aAhACPmrpKEIaTUCdLBDhOopclEyxcboV
	 qWfDbKlVWzF8Q==
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
Subject: [PATCHv6 bpf-next 5/9] selftests/bpf: Add uretprobe syscall test for regs integrity
Date: Tue, 21 May 2024 12:48:21 +0200
Message-ID: <20240521104825.1060966-6-jolsa@kernel.org>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240521104825.1060966-1-jolsa@kernel.org>
References: <20240521104825.1060966-1-jolsa@kernel.org>
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
Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
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
2.45.0


