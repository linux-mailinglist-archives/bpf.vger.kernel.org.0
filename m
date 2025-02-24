Return-Path: <bpf+bounces-52358-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ED4AA422BF
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 15:18:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2894D442AA1
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 14:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AA3A170A1B;
	Mon, 24 Feb 2025 14:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="injkndbs"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45FF13CA81;
	Mon, 24 Feb 2025 14:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740405884; cv=none; b=sxLuYhsOzf4ETQWLDWVLE/1P+5ReBnXN0rpE25eS1s6ImQqgFbETG0MHxj2X3MuLF6nIgdKTHp2UN4MQDixySVjyGjx6wHY05VKn1FCj9sNM9BdotVab20/v3W6h0pXIVQHFVMeYVeSXgYg0rufn/iOSGby28WKta1m+oBlUZ6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740405884; c=relaxed/simple;
	bh=08yQ2M1QgstTqrVMfXHy3RZ7HxixmsWT8XAzUUgbydU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fJLIKvJwwcDn1lqn8y4/zfR75YC1a/8lM6io89aWJOEEh/eYmGqLOtWZMoUNYOrBOsROps2O37pS1ohk3SFXZ9+YWGTfGERCcUl3AX9zno6OXqRMWCZYjHjWc6sc9RGi3KjdAXhW6B+2di37cpkvOwb6A8AbwTFlwXP1odwJd/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=injkndbs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7365DC4CED6;
	Mon, 24 Feb 2025 14:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740405884;
	bh=08yQ2M1QgstTqrVMfXHy3RZ7HxixmsWT8XAzUUgbydU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=injkndbs5AF3zSz55cqvJ9AgjmVI9s35ei4aeqrvLoIdI/TOt4VoKTrlcIJCqOXY4
	 Z32b6JIzIpmd+oyGvFLylA4NIrFRLEHxZJ4WvUROLDlj8prGlxeIvEVyrJMxwvBCM4
	 2zBLEC0vNFPtoJvZ2W/qQhjuQ4yD359ZrEtpk0Qamkf5VFq7CEGMxPoMDyTxa+oFHp
	 vBHfT5UXEN9qIZRHQRvTAGjim5IGNAUDZIiSAcJ5kjV0ThTWYCNwgI0AQYFMJPDBrY
	 b/6iXxC4ig8MyNnEiCtMTnaNSarF2uldwv7DrgNdmlONNoxNioPq3MY8DbuSQFXhwb
	 PtnuoQn6o+aAg==
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
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas@t-8ch.de>
Subject: [PATCH RFCv2 15/18] selftests/bpf: Add uprobe/usdt syscall tests
Date: Mon, 24 Feb 2025 15:01:47 +0100
Message-ID: <20250224140151.667679-16-jolsa@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250224140151.667679-1-jolsa@kernel.org>
References: <20250224140151.667679-1-jolsa@kernel.org>
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
 .../selftests/bpf/prog_tests/uprobe_syscall.c | 221 +++++++++++++++++-
 .../bpf/progs/uprobe_syscall_executed.c       |  34 ++-
 2 files changed, 249 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
index 2b00f16406c8..b337db6e12be 100644
--- a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
+++ b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
@@ -14,6 +14,7 @@
 #include <asm/prctl.h>
 #include "uprobe_syscall.skel.h"
 #include "uprobe_syscall_executed.skel.h"
+#include "sdt.h"
 
 __naked unsigned long uretprobe_regs_trigger(void)
 {
@@ -277,10 +278,10 @@ static void test_uretprobe_syscall_call(void)
 		_exit(0);
 	}
 
-	skel->links.test = bpf_program__attach_uprobe_multi(skel->progs.test, pid,
-							    "/proc/self/exe",
-							    "uretprobe_syscall_call", &opts);
-	if (!ASSERT_OK_PTR(skel->links.test, "bpf_program__attach_uprobe_multi"))
+	skel->links.test_uretprobe_multi = bpf_program__attach_uprobe_multi(skel->progs.test_uretprobe_multi,
+							pid, "/proc/self/exe",
+							"uretprobe_syscall_call", &opts);
+	if (!ASSERT_OK_PTR(skel->links.test_uretprobe_multi, "bpf_program__attach_uprobe_multi"))
 		goto cleanup;
 
 	/* kick the child */
@@ -351,6 +352,212 @@ static void test_uretprobe_shadow_stack(void)
 	ARCH_PRCTL(ARCH_SHSTK_DISABLE, ARCH_SHSTK_SHSTK);
 }
 
+#define TRAMP "[uprobes-trampoline]"
+
+static unsigned char nop5[5] = { 0x0f, 0x1f, 0x44, 0x00, 0x00 };
+
+__naked noinline void uprobe_test(void)
+{
+	asm volatile ("					\n"
+		".byte 0x0f, 0x1f, 0x44, 0x00, 0x00	\n"
+		"ret					\n"
+	);
+}
+
+noinline void usdt_test(void)
+{
+	STAP_PROBE(optimized_uprobe, usdt);
+}
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
+static void check_attach(struct uprobe_syscall_executed *skel, void (*trigger)(void), void *addr)
+{
+	void *tramp_start, *tramp_end;
+	struct __arch_relative_insn {
+		u8 op;
+		s32 raddr;
+	} __packed *call;
+
+	s32 delta;
+
+	/* Uprobe gets optimized after first trigger, so let's press twice. */
+	trigger();
+	trigger();
+
+	if (!ASSERT_OK(find_uprobes_trampoline(&tramp_start, &tramp_end), "uprobes_trampoline"))
+		return;
+
+	/* Make sure bpf program got executed.. */
+	ASSERT_EQ(skel->bss->executed, 2, "executed");
+
+	/* .. and check the trampoline is as expected. */
+	call = (struct __arch_relative_insn *) addr;
+	delta = (unsigned long) tramp_start - ((unsigned long) addr + 5);
+
+	ASSERT_EQ(call->op, 0xe8, "call");
+	ASSERT_EQ(call->raddr, delta, "delta");
+	ASSERT_EQ(tramp_end - tramp_start, 4096, "size");
+}
+
+static void check_detach(struct uprobe_syscall_executed *skel, void (*trigger)(void), void *addr)
+{
+	void *tramp_start, *tramp_end;
+
+	/* [uprobes_trampoline] stays after detach */
+	ASSERT_OK(find_uprobes_trampoline(&tramp_start, &tramp_end), "uprobes_trampoline");
+	ASSERT_OK(memcmp(addr, nop5, 5), "nop5");
+}
+
+static void check(struct uprobe_syscall_executed *skel, struct bpf_link *link,
+		  void (*trigger)(void), void *addr)
+{
+	check_attach(skel, trigger, addr);
+	bpf_link__destroy(link);
+	check_detach(skel, trigger, addr);
+}
+
+static void test_uprobe_legacy(void)
+{
+	LIBBPF_OPTS(bpf_uprobe_opts, opts,
+		.retprobe = true,
+	);
+	struct uprobe_syscall_executed *skel;
+	struct bpf_link *link;
+	unsigned long offset;
+
+	skel = uprobe_syscall_executed__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "uprobe_syscall_executed__open_and_load"))
+		return;
+
+	/* uprobe */
+	offset = get_uprobe_offset(&uprobe_test);
+	if (!ASSERT_GE(offset, 0, "get_uprobe_offset"))
+		goto cleanup;
+
+	link = bpf_program__attach_uprobe_opts(skel->progs.test_uprobe,
+				0, "/proc/self/exe", offset, NULL);
+	if (!ASSERT_OK_PTR(link, "bpf_program__attach_uprobe_opts"))
+		goto cleanup;
+
+	check(skel, link, uprobe_test, uprobe_test);
+
+	/* uretprobe */
+	skel->bss->executed = 0;
+	offset = get_uprobe_offset(&uprobe_test);
+	if (!ASSERT_GE(offset, 0, "get_uprobe_offset"))
+		goto cleanup;
+
+	link = bpf_program__attach_uprobe_opts(skel->progs.test_uretprobe,
+				0, "/proc/self/exe", offset, NULL);
+	if (!ASSERT_OK_PTR(link, "bpf_program__attach_uprobe_opts"))
+		goto cleanup;
+
+	check(skel, link, uprobe_test, uprobe_test);
+
+cleanup:
+	uprobe_syscall_executed__destroy(skel);
+}
+
+static void test_uprobe_multi(void)
+{
+	LIBBPF_OPTS(bpf_uprobe_multi_opts, opts,
+		.retprobe = true,
+	);
+	struct uprobe_syscall_executed *skel;
+	struct bpf_link *link;
+
+	skel = uprobe_syscall_executed__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "uprobe_syscall_executed__open_and_load"))
+		return;
+
+	/* uprobe.multi */
+	link = bpf_program__attach_uprobe_multi(skel->progs.test_uprobe_multi,
+				0, "/proc/self/exe", "uprobe_test", NULL);
+	if (!ASSERT_OK_PTR(link, "bpf_program__attach_uprobe_multi"))
+		goto cleanup;
+
+	check(skel, link, uprobe_test, uprobe_test);
+
+	/* uretprobe.multi */
+	skel->bss->executed = 0;
+	link = bpf_program__attach_uprobe_multi(skel->progs.test_uretprobe_multi,
+				0, "/proc/self/exe", "uprobe_test", &opts);
+	if (!ASSERT_OK_PTR(link, "bpf_program__attach_uprobe_multi"))
+		goto cleanup;
+
+	check(skel, link, uprobe_test, uprobe_test);
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
+	link = bpf_program__attach_usdt(skel->progs.test_usdt,
+				-1 /* all PIDs */, "/proc/self/exe",
+				"optimized_uprobe", "usdt", NULL);
+	if (!ASSERT_OK_PTR(link, "bpf_program__attach_usdt"))
+		goto cleanup;
+
+	check(skel, link, usdt_test, addr);
+
+cleanup:
+	uprobe_syscall_executed__destroy(skel);
+}
+
 static void __test_uprobe_syscall(void)
 {
 	if (test__start_subtest("uretprobe_regs_equal"))
@@ -361,6 +568,12 @@ static void __test_uprobe_syscall(void)
 		test_uretprobe_syscall_call();
 	if (test__start_subtest("uretprobe_shadow_stack"))
 		test_uretprobe_shadow_stack();
+	if (test__start_subtest("uprobe_legacy"))
+		test_uprobe_legacy();
+	if (test__start_subtest("uprobe_multi"))
+		test_uprobe_multi();
+	if (test__start_subtest("uprobe_usdt"))
+		test_uprobe_usdt();
 }
 #else
 static void __test_uprobe_syscall(void)
diff --git a/tools/testing/selftests/bpf/progs/uprobe_syscall_executed.c b/tools/testing/selftests/bpf/progs/uprobe_syscall_executed.c
index 0d7f1a7db2e2..802fd562ce4c 100644
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
@@ -9,9 +11,37 @@ char _license[] SEC("license") = "GPL";
 
 int executed = 0;
 
+SEC("uprobe")
+int BPF_UPROBE(test_uprobe)
+{
+	executed++;
+	return 0;
+}
+
+SEC("uretprobe")
+int BPF_URETPROBE(test_uretprobe)
+{
+	executed++;
+	return 0;
+}
+
+SEC("uprobe.multi")
+int test_uprobe_multi(struct pt_regs *ctx)
+{
+	executed++;
+	return 0;
+}
+
 SEC("uretprobe.multi")
-int test(struct pt_regs *regs)
+int test_uretprobe_multi(struct pt_regs *ctx)
+{
+	executed++;
+	return 0;
+}
+
+SEC("usdt")
+int test_usdt(struct pt_regs *ctx)
 {
-	executed = 1;
+	executed++;
 	return 0;
 }
-- 
2.48.1


