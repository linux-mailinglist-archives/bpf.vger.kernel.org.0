Return-Path: <bpf+bounces-54456-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D1A5A6A545
	for <lists+bpf@lfdr.de>; Thu, 20 Mar 2025 12:49:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28FB5462A29
	for <lists+bpf@lfdr.de>; Thu, 20 Mar 2025 11:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CA04226CE5;
	Thu, 20 Mar 2025 11:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pRNireS8"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F163822259C;
	Thu, 20 Mar 2025 11:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742471095; cv=none; b=jab3LuXlcLCmT0P3dPkmagyaEIVXb4GovLykqK0yakSgexyVi07TJt1+JCSvKmtqQ1WRnOUNI4/qHHppQDxa6aroEElJgFV3t3PtJtd7g9viZW884Wgy47kB/Yx8NrOfLfwj/Czf31LKPhBmC68taIJLbcEB/xuOltzWJf9Afzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742471095; c=relaxed/simple;
	bh=Yw+rjwbREZIOAZtVO5EBdVoYdv4EsvTnDSh40I9fLI4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O2R21WjtqTjAC6+5QUpZqoNQID9UKe8i1vjfUEn1HGO+K59dguG8EsUyYyTla09sIv6tBuwCe2hl/6LgWdi+q0SMXk+F9WV9Ibut+/8XHKvwgPh4PWeHPP49hkgaPmMCLzNKfvJ2zzG5MIgh+89p67Wfd+U9T2Qox8SKj7PgA7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pRNireS8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9436BC4CEE8;
	Thu, 20 Mar 2025 11:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742471094;
	bh=Yw+rjwbREZIOAZtVO5EBdVoYdv4EsvTnDSh40I9fLI4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pRNireS84UF+ee1ZTyUbVu42lYhY+J9VtmaS1zJu2NvCVXLWR7GrTeZEeVXI+vKsJ
	 gFyphfjmIsmvMCSFgk8h89caz4vucJL3Q9pGdclq++T0pxMfAZSSLb6Ad+mmBV4OJR
	 3Soe4xuDoYgrrxJpwdMptavEJqWH+9ETliUODghMsKV7F9tGx4vl76IuoVpEex8M7a
	 STlcxBOmperDAE7QM8GZW1FGs6MKCCKPAzgoia/DH0h7rhF+7efZDRf92gee7gh0Jp
	 VwdGCA8o4doSkxLeIMMc38a6eqxwAEu741fqByKc3wQ9qpv+X1ZFfLueH7ITykMuF4
	 UIeqQqLTWQbFw==
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
Subject: [PATCH RFCv3 15/23] selftests/bpf: Add uprobe/usdt syscall tests
Date: Thu, 20 Mar 2025 12:41:50 +0100
Message-ID: <20250320114200.14377-16-jolsa@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250320114200.14377-1-jolsa@kernel.org>
References: <20250320114200.14377-1-jolsa@kernel.org>
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
 .../selftests/bpf/prog_tests/uprobe_syscall.c | 257 ++++++++++++++++++
 .../bpf/progs/uprobe_syscall_executed.c       |  37 +++
 2 files changed, 294 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
index 3c74a079e6d9..d648bf8eca64 100644
--- a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
+++ b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
@@ -14,6 +14,9 @@
 #include <asm/prctl.h>
 #include "uprobe_syscall.skel.h"
 #include "uprobe_syscall_executed.skel.h"
+#include "sdt.h"
+
+#pragma GCC diagnostic ignored "-Wattributes"
 
 __naked unsigned long uretprobe_regs_trigger(void)
 {
@@ -351,6 +354,252 @@ static void test_uretprobe_shadow_stack(void)
 	ARCH_PRCTL(ARCH_SHSTK_DISABLE, ARCH_SHSTK_SHSTK);
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
+	STAP_PROBE(optimized_uprobe, usdt);
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
+static void check_attach(struct uprobe_syscall_executed *skel, trigger_t trigger,
+			 void *addr, int executed)
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
+	ASSERT_EQ(skel->bss->executed, executed, "executed");
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
+static void check_detach(struct uprobe_syscall_executed *skel, trigger_t trigger, void *addr)
+{
+	void *tramp_start, *tramp_end;
+
+	/* [uprobes_trampoline] stays after detach */
+	ASSERT_OK(find_uprobes_trampoline(&tramp_start, &tramp_end), "uprobes_trampoline");
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
 static void __test_uprobe_syscall(void)
 {
 	if (test__start_subtest("uretprobe_regs_equal"))
@@ -361,6 +610,14 @@ static void __test_uprobe_syscall(void)
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
index 2e1b689ed4fb..7bb4338c3ee2 100644
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
@@ -9,9 +11,44 @@ char _license[] SEC("license") = "GPL";
 
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
 int test_uretprobe_multi(struct pt_regs *ctx)
 {
 	executed++;
 	return 0;
 }
+
+SEC("uprobe.session")
+int test_uprobe_session(struct pt_regs *ctx)
+{
+	executed++;
+	return 0;
+}
+
+SEC("usdt")
+int test_usdt(struct pt_regs *ctx)
+{
+	executed++;
+	return 0;
+}
-- 
2.49.0


