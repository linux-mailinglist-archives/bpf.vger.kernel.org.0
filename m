Return-Path: <bpf+bounces-58301-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF812AB8630
	for <lists+bpf@lfdr.de>; Thu, 15 May 2025 14:22:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBB3C1890EBD
	for <lists+bpf@lfdr.de>; Thu, 15 May 2025 12:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 004DC29B20B;
	Thu, 15 May 2025 12:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XTv/1Nnv"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760C129A9C2;
	Thu, 15 May 2025 12:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747311288; cv=none; b=HPefTnO2Fb/9l0+Q5mBXDIEnvcdrYLTQR2twH68cnNqKIXhInARm1wIdRNqAjFUO2XRhoJwCj5SD4tTjpApswmA0cp6wLlhkVvftbfajuH1y/3Zzvgke8AQJEp6nWQ5OUy4uo9KzyIdiBE9EQ2kUJVdFUBFU8oejjjZKTXBgY18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747311288; c=relaxed/simple;
	bh=kZxqd1PidHjSEbx2QsEBQfzk94t6iT+W7N9WPdBnG38=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M4QiKuxs3hvXPZBb6FUj6IlbrBe07bpX/qI+HK/7Rkuo92yHYS47d7IrwkYnTsjyQSpvGLpV7hxnDDHsrooLFpXSHgqUW8vL6TxVD5pzjF732q1nz6934U4t/zb0EryCJ9xo99ghiOj5dbf23kDJjHMRfJPfWrkzz4NnYuEQuAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XTv/1Nnv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C43BFC4CEE7;
	Thu, 15 May 2025 12:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747311288;
	bh=kZxqd1PidHjSEbx2QsEBQfzk94t6iT+W7N9WPdBnG38=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XTv/1Nnv6TsrnY1vtCODyB2t/UyHhZf8Y+61ykbWUlgg0uEnf4OJxzefPBOuQmSIV
	 Wyu4RhXnknt3NFBFGkAU1uLXEsazhmpx8f0YmsjtMZTKapgh5p1nam8adTCSZm6EZ9
	 KWMmWiGDIu4P2jWYVWI7P0GEtiFhQHmMHeGKUBZT+eUF7Dd9RcNvujlF0QrLw1qOoT
	 3Ey/co9AFyn+N/iFFD/HNwKGRhC8ifnQlqXIlY9ntgxplxDjS5rNYtSGvH6xR+5IOx
	 Qna7kv6VPVDGRHRbIl0W7oxRrNwciKHhC4aGosrl6f7Vv5DPfAMa4azKCrMDcWhmL4
	 BBZ0s6v4qeqvA==
From: Jiri Olsa <jolsa@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>,
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
	Masami Hiramatsu <mhiramat@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	David Laight <David.Laight@ACULAB.COM>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas@t-8ch.de>,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCHv2 perf/core 14/22] selftests/bpf: Add uprobe/usdt syscall tests
Date: Thu, 15 May 2025 14:11:11 +0200
Message-ID: <20250515121121.2332905-15-jolsa@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250515121121.2332905-1-jolsa@kernel.org>
References: <20250515121121.2332905-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding tests for optimized uprobe/usdt probes.

Checking that we get expected trampoline and attached bpf programs
get executed properly.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../selftests/bpf/prog_tests/uprobe_syscall.c | 289 +++++++++++++++++-
 .../bpf/progs/uprobe_syscall_executed.c       |  32 ++
 2 files changed, 320 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
index 1cce50b5d18c..b9152ca8cdf5 100644
--- a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
+++ b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
@@ -8,6 +8,7 @@
 #include <asm/ptrace.h>
 #include <linux/compiler.h>
 #include <linux/stringify.h>
+#include <linux/kernel.h>
 #include <sys/wait.h>
 #include <sys/syscall.h>
 #include <sys/prctl.h>
@@ -15,6 +16,11 @@
 #include "uprobe_syscall.skel.h"
 #include "uprobe_syscall_executed.skel.h"
 
+#define USDT_NOP .byte 0x0f, 0x1f, 0x44, 0x00, 0x00
+#include "usdt.h"
+
+#pragma GCC diagnostic ignored "-Wattributes"
+
 __naked unsigned long uretprobe_regs_trigger(void)
 {
 	asm volatile (
@@ -305,6 +311,270 @@ static void test_uretprobe_syscall_call(void)
 	close(go[0]);
 }
 
+#define TRAMP "[uprobes-trampoline]"
+
+__attribute__((aligned(16)))
+__nocf_check __weak __naked void uprobe_test(void)
+{
+	asm volatile ("					\n"
+		".byte 0x0f, 0x1f, 0x44, 0x00, 0x00	\n"
+		"ret					\n"
+	);
+}
+
+__attribute__((aligned(16)))
+__nocf_check __weak void usdt_test(void)
+{
+	USDT(optimized_uprobe, usdt);
+}
+
+static int find_uprobes_trampoline(void **start, void **end)
+{
+	char line[128];
+	int ret = -1;
+	FILE *maps;
+
+	maps = fopen("/proc/self/maps", "r");
+	if (!maps) {
+		fprintf(stderr, "cannot open maps\n");
+		return -1;
+	}
+
+	while (fgets(line, sizeof(line), maps)) {
+		int m = -1;
+
+		/* We care only about private r-x mappings. */
+		if (sscanf(line, "%p-%p r-xp %*x %*x:%*x %*u %n", start, end, &m) != 2)
+			continue;
+		if (m < 0)
+			continue;
+		if (!strncmp(&line[m], TRAMP, sizeof(TRAMP)-1)) {
+			ret = 0;
+			break;
+		}
+	}
+
+	fclose(maps);
+	return ret;
+}
+
+static unsigned char nop5[5] = { 0x0f, 0x1f, 0x44, 0x00, 0x00 };
+
+static void *find_nop5(void *fn)
+{
+	int i;
+
+	for (i = 0; i < 10; i++) {
+		if (!memcmp(nop5, fn + i, 5))
+			return fn + i;
+	}
+	return NULL;
+}
+
+typedef void (__attribute__((nocf_check)) *trigger_t)(void);
+
+static bool shstk_is_enabled;
+
+static void check_attach(struct uprobe_syscall_executed *skel, trigger_t trigger,
+			 void *addr, int executed)
+{
+	void *tramp_start, *tramp_end;
+	struct __arch_relative_insn {
+		__u8 op;
+		__s32 raddr;
+	} __packed *call;
+	__s32 delta;
+	__u8 *bp;
+
+	/* Uprobe gets optimized after first trigger, so let's press twice. */
+	trigger();
+	trigger();
+
+	if (!shstk_is_enabled &&
+	    !ASSERT_OK(find_uprobes_trampoline(&tramp_start, &tramp_end), "uprobes_trampoline"))
+		return;
+
+	/* Make sure bpf program got executed.. */
+	ASSERT_EQ(skel->bss->executed, executed, "executed");
+
+	if (shstk_is_enabled) {
+		/* .. and check optimization is disabled under shadow stack. */
+		bp = (__u8 *) addr;
+		ASSERT_EQ(*bp, 0xcc, "int3");
+	} else {
+		/* .. and check the trampoline is as expected. */
+		call = (struct __arch_relative_insn *) addr;
+		delta = (unsigned long) tramp_start - ((unsigned long) addr + 5);
+
+		ASSERT_EQ(call->op, 0xe8, "call");
+		ASSERT_EQ(call->raddr, delta, "delta");
+		ASSERT_EQ(tramp_end - tramp_start, 4096, "size");
+	}
+}
+
+static void check_detach(struct uprobe_syscall_executed *skel, trigger_t trigger, void *addr)
+{
+	void *tramp_start, *tramp_end;
+
+	/* [uprobes_trampoline] stays after detach */
+	ASSERT_OK(!shstk_is_enabled &&
+		  find_uprobes_trampoline(&tramp_start, &tramp_end), "uprobes_trampoline");
+	ASSERT_OK(memcmp(addr, nop5, 5), "nop5");
+}
+
+static void check(struct uprobe_syscall_executed *skel, struct bpf_link *link,
+		  trigger_t trigger, void *addr, int executed)
+{
+	check_attach(skel, trigger, addr, executed);
+	bpf_link__destroy(link);
+	check_detach(skel, trigger, addr);
+}
+
+static void test_uprobe_legacy(void)
+{
+	struct uprobe_syscall_executed *skel = NULL;
+	LIBBPF_OPTS(bpf_uprobe_opts, opts,
+		.retprobe = true,
+	);
+	struct bpf_link *link;
+	unsigned long offset;
+
+	offset = get_uprobe_offset(&uprobe_test);
+	if (!ASSERT_GE(offset, 0, "get_uprobe_offset"))
+		goto cleanup;
+
+	/* uprobe */
+	skel = uprobe_syscall_executed__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "uprobe_syscall_executed__open_and_load"))
+		return;
+
+	skel->bss->pid = getpid();
+
+	link = bpf_program__attach_uprobe_opts(skel->progs.test_uprobe,
+				0, "/proc/self/exe", offset, NULL);
+	if (!ASSERT_OK_PTR(link, "bpf_program__attach_uprobe_opts"))
+		goto cleanup;
+
+	check(skel, link, uprobe_test, uprobe_test, 2);
+
+	/* uretprobe */
+	skel->bss->executed = 0;
+
+	link = bpf_program__attach_uprobe_opts(skel->progs.test_uretprobe,
+				0, "/proc/self/exe", offset, &opts);
+	if (!ASSERT_OK_PTR(link, "bpf_program__attach_uprobe_opts"))
+		goto cleanup;
+
+	check(skel, link, uprobe_test, uprobe_test, 2);
+
+cleanup:
+	uprobe_syscall_executed__destroy(skel);
+}
+
+static void test_uprobe_multi(void)
+{
+	struct uprobe_syscall_executed *skel = NULL;
+	LIBBPF_OPTS(bpf_uprobe_multi_opts, opts);
+	struct bpf_link *link;
+	unsigned long offset;
+
+	offset = get_uprobe_offset(&uprobe_test);
+	if (!ASSERT_GE(offset, 0, "get_uprobe_offset"))
+		goto cleanup;
+
+	opts.offsets = &offset;
+	opts.cnt = 1;
+
+	skel = uprobe_syscall_executed__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "uprobe_syscall_executed__open_and_load"))
+		return;
+
+	skel->bss->pid = getpid();
+
+	/* uprobe.multi */
+	link = bpf_program__attach_uprobe_multi(skel->progs.test_uprobe_multi,
+				0, "/proc/self/exe", NULL, &opts);
+	if (!ASSERT_OK_PTR(link, "bpf_program__attach_uprobe_multi"))
+		goto cleanup;
+
+	check(skel, link, uprobe_test, uprobe_test, 2);
+
+	/* uretprobe.multi */
+	skel->bss->executed = 0;
+	opts.retprobe = true;
+	link = bpf_program__attach_uprobe_multi(skel->progs.test_uretprobe_multi,
+				0, "/proc/self/exe", NULL, &opts);
+	if (!ASSERT_OK_PTR(link, "bpf_program__attach_uprobe_multi"))
+		goto cleanup;
+
+	check(skel, link, uprobe_test, uprobe_test, 2);
+
+cleanup:
+	uprobe_syscall_executed__destroy(skel);
+}
+
+static void test_uprobe_session(void)
+{
+	struct uprobe_syscall_executed *skel = NULL;
+	LIBBPF_OPTS(bpf_uprobe_multi_opts, opts,
+		.session = true,
+	);
+	struct bpf_link *link;
+	unsigned long offset;
+
+	offset = get_uprobe_offset(&uprobe_test);
+	if (!ASSERT_GE(offset, 0, "get_uprobe_offset"))
+		goto cleanup;
+
+	opts.offsets = &offset;
+	opts.cnt = 1;
+
+	skel = uprobe_syscall_executed__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "uprobe_syscall_executed__open_and_load"))
+		return;
+
+	skel->bss->pid = getpid();
+
+	link = bpf_program__attach_uprobe_multi(skel->progs.test_uprobe_session,
+				0, "/proc/self/exe", NULL, &opts);
+	if (!ASSERT_OK_PTR(link, "bpf_program__attach_uprobe_multi"))
+		goto cleanup;
+
+	check(skel, link, uprobe_test, uprobe_test, 4);
+
+cleanup:
+	uprobe_syscall_executed__destroy(skel);
+}
+
+static void test_uprobe_usdt(void)
+{
+	struct uprobe_syscall_executed *skel;
+	struct bpf_link *link;
+	void *addr;
+
+	errno = 0;
+	addr = find_nop5(usdt_test);
+	if (!ASSERT_OK_PTR(addr, "find_nop5"))
+		return;
+
+	skel = uprobe_syscall_executed__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "uprobe_syscall_executed__open_and_load"))
+		return;
+
+	skel->bss->pid = getpid();
+
+	link = bpf_program__attach_usdt(skel->progs.test_usdt,
+				-1 /* all PIDs */, "/proc/self/exe",
+				"optimized_uprobe", "usdt", NULL);
+	if (!ASSERT_OK_PTR(link, "bpf_program__attach_usdt"))
+		goto cleanup;
+
+	check(skel, link, usdt_test, addr, 2);
+
+cleanup:
+	uprobe_syscall_executed__destroy(skel);
+}
+
 /*
  * Borrowed from tools/testing/selftests/x86/test_shadow_stack.c.
  *
@@ -347,11 +617,20 @@ static void test_uretprobe_shadow_stack(void)
 		return;
 	}
 
-	/* Run all of the uretprobe tests. */
+	/* Run all the tests with shadow stack in place. */
+	shstk_is_enabled = true;
+
 	test_uretprobe_regs_equal();
 	test_uretprobe_regs_change();
 	test_uretprobe_syscall_call();
 
+	test_uprobe_legacy();
+	test_uprobe_multi();
+	test_uprobe_session();
+	test_uprobe_usdt();
+
+	shstk_is_enabled = false;
+
 	ARCH_PRCTL(ARCH_SHSTK_DISABLE, ARCH_SHSTK_SHSTK);
 }
 
@@ -365,6 +644,14 @@ static void __test_uprobe_syscall(void)
 		test_uretprobe_syscall_call();
 	if (test__start_subtest("uretprobe_shadow_stack"))
 		test_uretprobe_shadow_stack();
+	if (test__start_subtest("uprobe_legacy"))
+		test_uprobe_legacy();
+	if (test__start_subtest("uprobe_multi"))
+		test_uprobe_multi();
+	if (test__start_subtest("uprobe_session"))
+		test_uprobe_session();
+	if (test__start_subtest("uprobe_usdt"))
+		test_uprobe_usdt();
 }
 #else
 static void __test_uprobe_syscall(void)
diff --git a/tools/testing/selftests/bpf/progs/uprobe_syscall_executed.c b/tools/testing/selftests/bpf/progs/uprobe_syscall_executed.c
index c4c3447378ba..84f795b4abaf 100644
--- a/tools/testing/selftests/bpf/progs/uprobe_syscall_executed.c
+++ b/tools/testing/selftests/bpf/progs/uprobe_syscall_executed.c
@@ -1,6 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
 #include "vmlinux.h"
 #include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/usdt.bpf.h>
 #include <string.h>
 
 struct pt_regs regs;
@@ -17,8 +19,38 @@ static int inc_executed(void)
 	return 0;
 }
 
+SEC("uprobe")
+int BPF_UPROBE(test_uprobe)
+{
+	return inc_executed();
+}
+
+SEC("uretprobe")
+int BPF_URETPROBE(test_uretprobe)
+{
+	return inc_executed();
+}
+
+SEC("uprobe.multi")
+int test_uprobe_multi(struct pt_regs *ctx)
+{
+	return inc_executed();
+}
+
 SEC("uretprobe.multi")
 int test_uretprobe_multi(struct pt_regs *ctx)
 {
 	return inc_executed();
 }
+
+SEC("uprobe.session")
+int test_uprobe_session(struct pt_regs *ctx)
+{
+	return inc_executed();
+}
+
+SEC("usdt")
+int test_usdt(struct pt_regs *ctx)
+{
+	return inc_executed();
+}
-- 
2.49.0


