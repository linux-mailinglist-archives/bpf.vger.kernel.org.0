Return-Path: <bpf+bounces-67190-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF58DB4071A
	for <lists+bpf@lfdr.de>; Tue,  2 Sep 2025 16:38:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D80293B2FDF
	for <lists+bpf@lfdr.de>; Tue,  2 Sep 2025 14:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEF423093CA;
	Tue,  2 Sep 2025 14:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t2QYEvUk"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5316931E11F;
	Tue,  2 Sep 2025 14:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756823802; cv=none; b=ZTqW/INqrJE28zPAUQGXj4ZTYI5i7Y54ElrkpHy4/TxXFxNODGMFHioX2r5bh0ggZ2FDfQo4FpkPA6Gc3P3pYSeWDrwn18ObOYx7udeCP+Oc+0rwqYFCDimac8SiiwhXkC7kXrfNA9FvYPtE4EL0PYhwSMULtXf/EsarBR1LMOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756823802; c=relaxed/simple;
	bh=jOrI1/r9cXIWWIBL1iahAvqnnE3/HtGeDR9yXqysb2U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fhbvH2gSDi7eatJ2eXcdyCsdS58+bPRBFVKgcFLStAK+WySqtDxw2s6Gk+NAzV3ypAUQwYM80dDeyhw9lYIXxFQGiE7OTiWaz0rkCb4I15O5pxI8aSRcb6mk1mCQKsz7Q0m1lADDYdWJCeivW2OHqu1fZ+HC9hP8MAoDgvquAYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t2QYEvUk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7D7AC4CEF6;
	Tue,  2 Sep 2025 14:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756823801;
	bh=jOrI1/r9cXIWWIBL1iahAvqnnE3/HtGeDR9yXqysb2U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t2QYEvUkKHXFGrZgaFJ5Y/lV7+xo/IzLJoEXKH+zFjw4X0+9P2QUJ2iC7KT3T62P6
	 uVNzwA6GklARr6xTRoUVF+u0MPIOg5tGIY31GFRKtqFnnjI6EBFjUNeq0ifqWuu6Ct
	 xNpw5o/DtxjJGd8OYFWZaKWXgBiIIro5WSnNwF9bxQ6HsKDEYjTPqhFrjcz8+7fZAr
	 +xqvBmsHjcnH/1eXjlVUMO4DQrtT57NzKCmKa4AyDcsOHycvs42HEahkSZTvADAiUp
	 xLSAMAd0l7I2j+9uT0bWZbnXH7O1VzSSBr2/H8ilEvjnABe+hxvbzs/25erndtT5H0
	 2xRcnAbvAYztA==
From: Jiri Olsa <jolsa@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	x86@kernel.org,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH perf/core 08/11] selftests/bpf: Add uprobe multi context registers changes test
Date: Tue,  2 Sep 2025 16:35:01 +0200
Message-ID: <20250902143504.1224726-9-jolsa@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250902143504.1224726-1-jolsa@kernel.org>
References: <20250902143504.1224726-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding test to check we can change common register values through
uprobe program.

It's x86_64 specific test.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../selftests/bpf/prog_tests/bpf_cookie.c     |   1 +
 .../bpf/prog_tests/uprobe_multi_test.c        | 107 ++++++++++++++++++
 .../selftests/bpf/progs/uprobe_multi.c        |  24 ++++
 3 files changed, 132 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c b/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c
index 4a0670c056ba..2425fd26d1ea 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c
@@ -6,6 +6,7 @@
 #include <sys/syscall.h>
 #include <sys/mman.h>
 #include <unistd.h>
+#include <asm/ptrace.h>
 #include <test_progs.h>
 #include <network_helpers.h>
 #include <bpf/btf.h>
diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
index 2ee17ef1dae2..012652b07399 100644
--- a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
@@ -2,6 +2,7 @@
 
 #include <unistd.h>
 #include <pthread.h>
+#include <asm/ptrace.h>
 #include <test_progs.h>
 #include "uprobe_multi.skel.h"
 #include "uprobe_multi_bench.skel.h"
@@ -1340,6 +1341,111 @@ static void test_bench_attach_usdt(void)
 	printf("%s: detached in %7.3lfs\n", __func__, detach_delta);
 }
 
+#ifdef __x86_64__
+__naked __maybe_unused unsigned long uprobe_regs_change_trigger(void)
+{
+	asm volatile (
+		"ret\n"
+	);
+}
+
+static __naked void uprobe_regs_change(struct pt_regs *before, struct pt_regs *after)
+{
+	asm volatile (
+		"movq %r11,  48(%rdi)\n"
+		"movq %r10,  56(%rdi)\n"
+		"movq  %r9,  64(%rdi)\n"
+		"movq  %r8,  72(%rdi)\n"
+		"movq %rax,  80(%rdi)\n"
+		"movq %rcx,  88(%rdi)\n"
+		"movq %rdx,  96(%rdi)\n"
+		"movq %rsi, 104(%rdi)\n"
+		"movq %rdi, 112(%rdi)\n"
+
+		/* save 2nd argument */
+		"pushq %rsi\n"
+		"call uprobe_regs_change_trigger\n"
+
+		/* save  return value and load 2nd argument pointer to rax */
+		"pushq %rax\n"
+		"movq 8(%rsp), %rax\n"
+
+		"movq %r11,  48(%rax)\n"
+		"movq %r10,  56(%rax)\n"
+		"movq  %r9,  64(%rax)\n"
+		"movq  %r8,  72(%rax)\n"
+		"movq %rcx,  88(%rax)\n"
+		"movq %rdx,  96(%rax)\n"
+		"movq %rsi, 104(%rax)\n"
+		"movq %rdi, 112(%rax)\n"
+
+		/* restore return value and 2nd argument */
+		"pop %rax\n"
+		"pop %rsi\n"
+
+		"movq %rax,  80(%rsi)\n"
+		"ret\n"
+	);
+}
+
+static void unique_regs_common(void)
+{
+	struct pt_regs before = {}, after = {}, expected = {
+		.rax = 0xc0ffe,
+		.rcx = 0xbad,
+		.rdx = 0xdead,
+		.r8  = 0x8,
+		.r9  = 0x9,
+		.r10 = 0x10,
+		.r11 = 0x11,
+		.rdi = 0x12,
+		.rsi = 0x13,
+	};
+	LIBBPF_OPTS(bpf_uprobe_multi_opts, opts,
+		.unique = true,
+	);
+	struct uprobe_multi *skel;
+
+	skel = uprobe_multi__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_open"))
+		return;
+
+	skel->bss->pid = getpid();
+	skel->bss->regs = expected;
+
+	skel->links.uprobe_change_regs = bpf_program__attach_uprobe_multi(
+						skel->progs.uprobe_change_regs,
+						-1, "/proc/self/exe",
+						"uprobe_regs_change_trigger",
+						&opts);
+	if (!ASSERT_OK_PTR(skel->links.uprobe_change_regs, "bpf_program__attach_uprobe_multi"))
+		goto cleanup;
+
+	uprobe_regs_change(&before, &after);
+
+	ASSERT_EQ(after.rax, expected.rax, "ax");
+	ASSERT_EQ(after.rcx, expected.rcx, "cx");
+	ASSERT_EQ(after.rdx, expected.rdx, "dx");
+	ASSERT_EQ(after.r8,  expected.r8,  "r8");
+	ASSERT_EQ(after.r9,  expected.r9,  "r9");
+	ASSERT_EQ(after.r10, expected.r10, "r10");
+	ASSERT_EQ(after.r11, expected.r11, "r11");
+	ASSERT_EQ(after.rdi, expected.rdi, "rdi");
+	ASSERT_EQ(after.rsi, expected.rsi, "rsi");
+
+cleanup:
+	uprobe_multi__destroy(skel);
+}
+
+static void test_unique(void)
+{
+	if (test__start_subtest("unique_regs_common"))
+		unique_regs_common();
+}
+#else
+static void test_unique(void) { }
+#endif
+
 void test_uprobe_multi_test(void)
 {
 	if (test__start_subtest("skel_api"))
@@ -1372,5 +1478,6 @@ void test_uprobe_multi_test(void)
 		test_session_cookie_skel_api();
 	if (test__start_subtest("session_cookie_recursive"))
 		test_session_recursive_skel_api();
+	test_unique();
 	RUN_TESTS(uprobe_multi_verifier);
 }
diff --git a/tools/testing/selftests/bpf/progs/uprobe_multi.c b/tools/testing/selftests/bpf/progs/uprobe_multi.c
index 44190efcdba2..f26f8b840985 100644
--- a/tools/testing/selftests/bpf/progs/uprobe_multi.c
+++ b/tools/testing/selftests/bpf/progs/uprobe_multi.c
@@ -141,3 +141,27 @@ int usdt_extra(struct pt_regs *ctx)
 	/* we need this one just to mix PID-filtered and global USDT probes */
 	return 0;
 }
+
+#if defined(__TARGET_ARCH_x86)
+struct pt_regs regs;
+
+SEC("uprobe.unique")
+int BPF_UPROBE(uprobe_change_regs)
+{
+	pid_t cur_pid = bpf_get_current_pid_tgid() >> 32;
+
+	if (cur_pid != pid)
+		return 0;
+
+	ctx->ax  = regs.ax;
+	ctx->cx  = regs.cx;
+	ctx->dx  = regs.dx;
+	ctx->r8  = regs.r8;
+	ctx->r9  = regs.r9;
+	ctx->r10 = regs.r10;
+	ctx->r11 = regs.r11;
+	ctx->di  = regs.di;
+	ctx->si  = regs.si;
+	return 0;
+}
+#endif
-- 
2.51.0


