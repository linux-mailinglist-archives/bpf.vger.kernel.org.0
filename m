Return-Path: <bpf+bounces-46635-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 146509ECD5C
	for <lists+bpf@lfdr.de>; Wed, 11 Dec 2024 14:37:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04790169B1B
	for <lists+bpf@lfdr.de>; Wed, 11 Dec 2024 13:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9502C236FA8;
	Wed, 11 Dec 2024 13:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WjXePPr6"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1718A236914;
	Wed, 11 Dec 2024 13:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733924158; cv=none; b=eFnOVUElFswc4mblDTvmORfkQU8jeruJuu2cLk1QLJw4DJ9IG6wQpJxZzeDqBFITU76cXG4xTL5Oid+VI26rb5Zufe0Z1ieIhkkeDFRlypLe0ZZDkLx6uSy/d6SN+lTbEgFqz4gQjicbMDUVD7sWJtNoatiVzcFvBSQQnd9YkGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733924158; c=relaxed/simple;
	bh=09gvuS1npBvqynFZ+ZH4cs0xqN26Ic6eEPXMk6Tzgac=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IabclwVbdT+K8owWOQizsjYI2tDvMcPPPWCAb9+VmLKYPJnrpr/lYNcxz3j4v+yN9L5Y6w8gQc5d82D7I9w3xuMhzA/MwaO6nrClUFkCIq0T6dqzo3Hztk9gb2w1RWFSz6Ou6YWAzHxN/+QzqPZHzRZUl2ZoihAJeOh7TB60uVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WjXePPr6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 460F7C4CEDD;
	Wed, 11 Dec 2024 13:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733924157;
	bh=09gvuS1npBvqynFZ+ZH4cs0xqN26Ic6eEPXMk6Tzgac=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WjXePPr6DnNkDJZfFBXKvwY2oipuKFfQ9LpMmyKuZWERQvEpxpCbQbkUQ2hsh7Wvc
	 fBWGjRAqDjx6kPYlIVjbK8qwD7PRch5r4fNJY12DxxF+mksY+lk7+n6qZp9gXL6Uwx
	 vtJBsWu3LrVZIETG/+/eXN9Ojq+92dE4YQ4k25wsgQ27u5bG3AElvOTZ3N83XPegP+
	 x9tQ9kYZDcdL7YwgAcFBnoyAUwbLnqwwUdL9oWfnefyhHisd3WVOOPRYp4kIScErHM
	 a/QRo/uIx2umuO7A9XD0K9BCx5UOr57erT43bz1o0waDW+PKEYTTmm3/64VA1UP05E
	 rCuKj9rLXZK4A==
From: Jiri Olsa <jolsa@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH bpf-next 10/13] selftests/bpf: Add uprobe/usdt optimized test
Date: Wed, 11 Dec 2024 14:33:59 +0100
Message-ID: <20241211133403.208920-11-jolsa@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241211133403.208920-1-jolsa@kernel.org>
References: <20241211133403.208920-1-jolsa@kernel.org>
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
 .../selftests/bpf/prog_tests/uprobe_syscall.c | 203 ++++++++++++++++++
 .../selftests/bpf/progs/uprobe_optimized.c    |  29 +++
 2 files changed, 232 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/uprobe_optimized.c

diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
index c397336fe1ed..1dbc26a1130c 100644
--- a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
+++ b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
@@ -14,6 +14,8 @@
 #include <asm/prctl.h>
 #include "uprobe_syscall.skel.h"
 #include "uprobe_syscall_executed.skel.h"
+#include "uprobe_optimized.skel.h"
+#include "sdt.h"
 
 __naked unsigned long uretprobe_regs_trigger(void)
 {
@@ -350,6 +352,186 @@ static void test_uretprobe_shadow_stack(void)
 
 	ARCH_PRCTL(ARCH_SHSTK_DISABLE, ARCH_SHSTK_SHSTK);
 }
+
+#define TRAMP "[uprobes-trampoline]"
+
+static unsigned char nop5[5] = { 0x0f, 0x1f, 0x44, 0x00, 0x00 };
+
+noinline void uprobe_test(void)
+{
+	asm volatile ("					\n"
+		".global uprobe_test_nop5		\n"
+		".type uprobe_test_nop5, STT_FUNC	\n"
+		"uprobe_test_nop5:			\n"
+		".byte 0x0f, 0x1f, 0x44, 0x00, 0x00	\n"
+	);
+}
+
+extern u8 uprobe_test_nop5[];
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
+static void check_attach(struct uprobe_optimized *skel, void (*trigger)(void), void *addr)
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
+static void check_detach(struct uprobe_optimized *skel, void (*trigger)(void), void *addr)
+{
+	void *tramp_start, *tramp_end;
+
+	/* [uprobes_trampoline] stays after detach */
+	ASSERT_OK(find_uprobes_trampoline(&tramp_start, &tramp_end), "uprobes_trampoline");
+	ASSERT_OK(memcmp(addr, nop5, 5), "nop5");
+}
+
+static void check(struct uprobe_optimized *skel, struct bpf_link *link,
+		  void (*trigger)(void), void *addr)
+{
+	check_attach(skel, trigger, addr);
+	bpf_link__destroy(link);
+	check_detach(skel, trigger, addr);
+}
+
+static void test_uprobe_legacy(void)
+{
+	struct uprobe_optimized *skel;
+	struct bpf_link *link;
+	unsigned long offset;
+
+	skel = uprobe_optimized__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "uprobe_optimized__open_and_load"))
+		return;
+
+	offset = get_uprobe_offset(&uprobe_test_nop5);
+	if (!ASSERT_GE(offset, 0, "get_uprobe_offset"))
+		goto cleanup;
+
+	link = bpf_program__attach_uprobe_opts(skel->progs.test_1,
+				0, "/proc/self/exe", offset, NULL);
+	if (!ASSERT_OK_PTR(link, "bpf_program__attach_uprobe_opts"))
+		goto cleanup;
+
+	check(skel, link, uprobe_test, uprobe_test_nop5);
+
+cleanup:
+	uprobe_optimized__destroy(skel);
+}
+
+static void test_uprobe_multi(void)
+{
+	struct uprobe_optimized *skel;
+	struct bpf_link *link;
+
+	skel = uprobe_optimized__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "uprobe_optimized__open_and_load"))
+		return;
+
+	link = bpf_program__attach_uprobe_multi(skel->progs.test_2,
+				0, "/proc/self/exe", "uprobe_test_nop5", NULL);
+	if (!ASSERT_OK_PTR(link, "bpf_program__attach_uprobe_multi"))
+		goto cleanup;
+
+	check(skel, link, uprobe_test, uprobe_test_nop5);
+
+cleanup:
+	uprobe_optimized__destroy(skel);
+}
+
+static void test_uprobe_usdt(void)
+{
+	struct uprobe_optimized *skel;
+	struct bpf_link *link;
+	void *addr;
+
+	errno = 0;
+	addr = find_nop5(usdt_test);
+	if (!ASSERT_OK_PTR(addr, "find_nop5"))
+		return;
+
+	skel = uprobe_optimized__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "uprobe_optimized__open_and_load"))
+		return;
+
+	link = bpf_program__attach_usdt(skel->progs.test_3,
+				-1 /* all PIDs */, "/proc/self/exe",
+				"optimized_uprobe", "usdt", NULL);
+	if (!ASSERT_OK_PTR(link, "bpf_program__attach_usdt"))
+		goto cleanup;
+
+	check(skel, link, usdt_test, addr);
+
+cleanup:
+	uprobe_optimized__destroy(skel);
+}
 #else
 static void test_uretprobe_regs_equal(void)
 {
@@ -370,6 +552,21 @@ static void test_uretprobe_shadow_stack(void)
 {
 	test__skip();
 }
+
+static void test_uprobe_legacy(void)
+{
+	test__skip();
+}
+
+static void test_uprobe_multi(void)
+{
+	test__skip();
+}
+
+static void test_uprobe_usdt(void)
+{
+	test__skip();
+}
 #endif
 
 void test_uprobe_syscall(void)
@@ -382,4 +579,10 @@ void test_uprobe_syscall(void)
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
diff --git a/tools/testing/selftests/bpf/progs/uprobe_optimized.c b/tools/testing/selftests/bpf/progs/uprobe_optimized.c
new file mode 100644
index 000000000000..2441d59960a6
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/uprobe_optimized.c
@@ -0,0 +1,29 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "vmlinux.h"
+#include <bpf/bpf_tracing.h>
+#include <bpf/usdt.bpf.h>
+
+char _license[] SEC("license") = "GPL";
+unsigned long executed = 0;
+
+SEC("uprobe")
+int BPF_UPROBE(test_1)
+{
+	executed++;
+	return 0;
+}
+
+SEC("uprobe.multi")
+int BPF_UPROBE(test_2)
+{
+	executed++;
+	return 0;
+}
+
+SEC("usdt")
+int test_3(struct pt_regs *ctx)
+{
+	executed++;
+	return 0;
+}
-- 
2.47.0


