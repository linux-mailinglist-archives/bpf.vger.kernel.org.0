Return-Path: <bpf+bounces-67707-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 64450B48D0F
	for <lists+bpf@lfdr.de>; Mon,  8 Sep 2025 14:14:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C598B7A6EB9
	for <lists+bpf@lfdr.de>; Mon,  8 Sep 2025 12:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08F252FCBFC;
	Mon,  8 Sep 2025 12:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uYTYimiT"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A7AE552;
	Mon,  8 Sep 2025 12:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757333634; cv=none; b=r067d2DitxM5XIA2olGAjgvAjFgNnl9ZpJPN4OsnyxLCWApKQvVc3xFArwfYPU61l0CJdPXHj4FjuMR6+BF87t0HCYb3ZeziJch6EFomyPg5tx7rpRgGtSPaRd3mSV65kKU1ScLOrfrttNpnpGrMhgQAK3h8xNWZaqM9oAEEs8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757333634; c=relaxed/simple;
	bh=3NANpKXl+pfp3BrIntDBj/EVTt9o2TzdBlkEWj5GkFY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ntRDVdQ8IoaZwpvuCw7FZfQScw2S6GtnXN3oXHvW1lT+4L1hvi+9P6pk9dlbwxK5NUOQfvW9pUVPMtV8Jr8AnKV4trz4G6Uwqa7QKiQYHBM5mIBBaVilC+BS2n8p8Q5lA/Xm4qDGs8+/bVBnQTHBvB5w8Xod9+mWYWt8gll2Ppg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uYTYimiT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B960C4CEF1;
	Mon,  8 Sep 2025 12:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757333634;
	bh=3NANpKXl+pfp3BrIntDBj/EVTt9o2TzdBlkEWj5GkFY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uYTYimiTjHSbdiJOJkADemdOKy/gS0G+yiBtjAGY7+bi41x1Ls2/rAR8O8IFnn0B8
	 6H5MlxjQ8nrQD4fZI9tzVrX03mFaOUrYFe4v3MiLVFZqUIbr95GGnlMQFzRqDLusO2
	 wEhaZG00T1etgtWXwySOpftlmRoSvi4JU1dQSmJvwK5BNgPkSEkERt4ZezG7R6400I
	 5RvSS8GAkPh7vdDeZnlHSJuZftSMz+DGQFKdgIAAFTHBhQBEyHE0WNksLF8wQdqstX
	 34drD48gisu4c0zKmOtsbBJlkNQwmruFCl6iqcqsMFjkwmcv9BwVYAHbJuYf6GC2OO
	 wwbsXEREW0BLg==
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
Subject: [PATCHv2 perf/core 3/4] selftests/bpf: Add uprobe context registers changes test
Date: Mon,  8 Sep 2025 14:13:09 +0200
Message-ID: <20250908121310.46824-4-jolsa@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250908121310.46824-1-jolsa@kernel.org>
References: <20250908121310.46824-1-jolsa@kernel.org>
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
 .../testing/selftests/bpf/prog_tests/uprobe.c | 114 +++++++++++++++++-
 .../testing/selftests/bpf/progs/test_uprobe.c |  24 ++++
 2 files changed, 137 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe.c b/tools/testing/selftests/bpf/prog_tests/uprobe.c
index cf3e0e7a64fa..19dd900df188 100644
--- a/tools/testing/selftests/bpf/prog_tests/uprobe.c
+++ b/tools/testing/selftests/bpf/prog_tests/uprobe.c
@@ -2,6 +2,7 @@
 /* Copyright (c) 2023 Hengqi Chen */
 
 #include <test_progs.h>
+#include <asm/ptrace.h>
 #include "test_uprobe.skel.h"
 
 static FILE *urand_spawn(int *pid)
@@ -33,7 +34,7 @@ static int urand_trigger(FILE **urand_pipe)
 	return exit_code;
 }
 
-void test_uprobe(void)
+static void test_uprobe_attach(void)
 {
 	LIBBPF_OPTS(bpf_uprobe_opts, uprobe_opts);
 	struct test_uprobe *skel;
@@ -93,3 +94,114 @@ void test_uprobe(void)
 		pclose(urand_pipe);
 	test_uprobe__destroy(skel);
 }
+
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
+static void regs_common(void)
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
+	LIBBPF_OPTS(bpf_uprobe_opts, uprobe_opts);
+	struct test_uprobe *skel;
+
+	skel = test_uprobe__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_open"))
+		return;
+
+	skel->bss->my_pid = getpid();
+	skel->bss->regs = expected;
+
+	uprobe_opts.func_name = "uprobe_regs_change_trigger";
+	skel->links.test_regs_change = bpf_program__attach_uprobe_opts(skel->progs.test_regs_change,
+							    -1,
+							    "/proc/self/exe",
+							    0 /* offset */,
+							    &uprobe_opts);
+	if (!ASSERT_OK_PTR(skel->links.test_regs_change, "bpf_program__attach_uprobe_opts"))
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
+	test_uprobe__destroy(skel);
+}
+
+static void test_uprobe_regs_change(void)
+{
+	if (test__start_subtest("regs_change_common"))
+		regs_common();
+}
+#else
+static void test_uprobe_regs_change(void) { }
+#endif
+
+void test_uprobe(void)
+{
+	if (test__start_subtest("attach"))
+		test_uprobe_attach();
+	test_uprobe_regs_change();
+}
diff --git a/tools/testing/selftests/bpf/progs/test_uprobe.c b/tools/testing/selftests/bpf/progs/test_uprobe.c
index 896c88a4960d..9437bd76a437 100644
--- a/tools/testing/selftests/bpf/progs/test_uprobe.c
+++ b/tools/testing/selftests/bpf/progs/test_uprobe.c
@@ -59,3 +59,27 @@ int BPF_UPROBE(test4)
 	test4_result = 1;
 	return 0;
 }
+
+#if defined(__TARGET_ARCH_x86)
+struct pt_regs regs;
+
+SEC("uprobe")
+int BPF_UPROBE(test_regs_change)
+{
+	pid_t pid = bpf_get_current_pid_tgid() >> 32;
+
+	if (pid != my_pid)
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


