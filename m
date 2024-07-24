Return-Path: <bpf+bounces-35577-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2F5393B951
	for <lists+bpf@lfdr.de>; Thu, 25 Jul 2024 00:52:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E63C21C21152
	for <lists+bpf@lfdr.de>; Wed, 24 Jul 2024 22:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC72313DDB8;
	Wed, 24 Jul 2024 22:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uV+A/Re2"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 337BF13D610
	for <bpf@vger.kernel.org>; Wed, 24 Jul 2024 22:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721861567; cv=none; b=cW9U5ryXjDM4ae+tWARrK+bL95ob8QeXqUFyblmrWopkB9CxNIAvfW2L9l2ZQvHOG+MUP8QfNlvjH58hq1Fu4ok+cprLDL8p0c6NAfigShDzQ9MV3nw88bfH0vB0G0Cg7yJjdcmKzC3eJRYwCv5PsT+NrqWQtEWB4GGxLlBq8x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721861567; c=relaxed/simple;
	bh=xrKF6BEn7xM/lFZAUWkAXCxHoR7Z8xeRExFe75nCrl8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o5dKf5exLsOU3IoNx6MBHzqxNB15Pn6Wja8CHmP4cWKv/YG0OAgX/oV2QbpsUSDlSvC868c2FuklHvGTVYo6jFPiAnjLC8wyHv55a/q8A181hhsY24btFcozqVOJq9zJBJCAMx0L08uP2wRUIrTMNJ/7vdm2ixj+oKdt0Z5jv7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uV+A/Re2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83978C32781;
	Wed, 24 Jul 2024 22:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721861566;
	bh=xrKF6BEn7xM/lFZAUWkAXCxHoR7Z8xeRExFe75nCrl8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uV+A/Re2GIQb4j2gTs/TZE5wf0bQp8rT3fcqecC970ONYKPLuTF/ACsI57L9L3MHw
	 /RXK5vt6P7p4GHM5UkhzErVvC39w+c/jkmckOk2STb1pfO2QNNterkYoW9N0WmdxPz
	 sFpFV0JLyzPBgsKx52RUpepA98Gz/aJMZEG26WFgIILR1TmaTgVgF3qBoRdSHNEsYb
	 7cBXKvBkl2Pr0i5kOStJjMCj2Z16+IzcqGEbxcWnMCie1WABVAcSLmN+F42RUGgdkF
	 4bLEWgkNSIFhqYBsp+HL0sSNb1GrNjzXnD6yHbxrfbgog8R43tJHtBKBzHnvxRSW6b
	 jgAD1R2lbNPEw==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org
Cc: linux-mm@kvack.org,
	akpm@linux-foundation.org,
	adobriyan@gmail.com,
	shakeel.butt@linux.dev,
	hannes@cmpxchg.org,
	ak@linux.intel.com,
	osandov@osandov.com,
	song@kernel.org,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH v2 bpf-next 10/10] selftests/bpf: add build ID tests
Date: Wed, 24 Jul 2024 15:52:10 -0700
Message-ID: <20240724225210.545423-11-andrii@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240724225210.545423-1-andrii@kernel.org>
References: <20240724225210.545423-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new set of tests validating behavior of capturing stack traces
with build ID. We extend uprobe_multi target binary with ability to
trigger uprobe (so that we can capture stack traces from it), but also
we allow to force build ID data to be either resident or non-resident in
memory (see also a comment about quirks of MADV_PAGEOUT).

That way we can validate that in non-sleepable context we won't get
build ID (as expected), but with sleepable uprobes we will get that
build ID regardless of it being physically present in memory.

Also, we add a small add-on linker script which reorders
.note.gnu.build-id section and puts it after (big) .text section,
putting build ID data outside of the very first page of ELF file. This
will test all the relaxations we did in build ID parsing logic in kernel
thanks to freader abstraction.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/testing/selftests/bpf/Makefile          |   5 +-
 .../selftests/bpf/prog_tests/build_id.c       | 118 ++++++++++++++++++
 .../selftests/bpf/progs/test_build_id.c       |  31 +++++
 tools/testing/selftests/bpf/uprobe_multi.c    |  41 ++++++
 tools/testing/selftests/bpf/uprobe_multi.ld   |  11 ++
 5 files changed, 204 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/build_id.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_build_id.c
 create mode 100644 tools/testing/selftests/bpf/uprobe_multi.ld

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 888ba68e6592..fe4bca113c78 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -790,9 +790,10 @@ $(OUTPUT)/veristat: $(OUTPUT)/veristat.o
 
 # Linking uprobe_multi can fail due to relocation overflows on mips.
 $(OUTPUT)/uprobe_multi: CFLAGS += $(if $(filter mips, $(ARCH)),-mxgot)
-$(OUTPUT)/uprobe_multi: uprobe_multi.c
+$(OUTPUT)/uprobe_multi: uprobe_multi.c uprobe_multi.ld
 	$(call msg,BINARY,,$@)
-	$(Q)$(CC) $(CFLAGS) -O0 $(LDFLAGS) $^ $(LDLIBS) -o $@
+	$(Q)$(CC) $(CFLAGS) -Wl,-T,uprobe_multi.ld -O0 $(LDFLAGS) 	\
+		$(filter-out %.ld,$^) $(LDLIBS) -o $@
 
 EXTRA_CLEAN := $(SCRATCH_DIR) $(HOST_SCRATCH_DIR)			\
 	prog_tests/tests.h map_tests/tests.h verifier/tests.h		\
diff --git a/tools/testing/selftests/bpf/prog_tests/build_id.c b/tools/testing/selftests/bpf/prog_tests/build_id.c
new file mode 100644
index 000000000000..8e6d3603be61
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/build_id.c
@@ -0,0 +1,118 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
+#include <test_progs.h>
+
+#include "test_build_id.skel.h"
+
+static char build_id[BPF_BUILD_ID_SIZE];
+static int build_id_sz;
+
+static void print_stack(struct bpf_stack_build_id *stack, int frame_cnt)
+{
+	int i, j;
+
+	for (i = 0; i < frame_cnt; i++) {
+		printf("FRAME #%02d: ", i);
+		switch (stack[i].status) {
+		case BPF_STACK_BUILD_ID_EMPTY:
+			printf("<EMPTY>\n");
+			break;
+		case BPF_STACK_BUILD_ID_VALID:
+			printf("BUILD ID = ");
+			for (j = 0; j < BPF_BUILD_ID_SIZE; j++)
+				printf("%02hhx", (unsigned)stack[i].build_id[j]);
+			printf(" OFFSET = %llx", (unsigned long long)stack[i].offset);
+			break;
+		case BPF_STACK_BUILD_ID_IP:
+			printf("IP = %llx", (unsigned long long)stack[i].ip);
+			break;
+		default:
+			printf("UNEXPECTED STATUS %d ", stack[i].status);
+			break;
+		}
+		printf("\n");
+	}
+}
+
+static void subtest_nofault(bool build_id_resident)
+{
+	struct test_build_id *skel;
+	struct bpf_stack_build_id *stack;
+	int frame_cnt;
+
+	skel = test_build_id__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_open"))
+		return;
+
+	skel->links.uprobe_nofault = bpf_program__attach(skel->progs.uprobe_nofault);
+	if (!ASSERT_OK_PTR(skel->links.uprobe_nofault, "link"))
+		goto cleanup;
+
+	if (build_id_resident)
+		ASSERT_OK(system("./uprobe_multi uprobe-paged-in"), "trigger_uprobe");
+	else
+		ASSERT_OK(system("./uprobe_multi uprobe-paged-out"), "trigger_uprobe");
+
+	if (!ASSERT_GT(skel->bss->res_nofault, 0, "res"))
+		goto cleanup;
+
+	stack = skel->bss->stack_nofault;
+	frame_cnt = skel->bss->res_nofault / sizeof(struct bpf_stack_build_id);
+	if (env.verbosity >= VERBOSE_NORMAL)
+		print_stack(stack, frame_cnt);
+
+	if (build_id_resident) {
+		ASSERT_EQ(stack[0].status, BPF_STACK_BUILD_ID_VALID, "build_id_status");
+		ASSERT_EQ(memcmp(stack[0].build_id, build_id, build_id_sz), 0, "build_id_match");
+	} else {
+		ASSERT_EQ(stack[0].status, BPF_STACK_BUILD_ID_IP, "build_id_status");
+	}
+
+cleanup:
+	test_build_id__destroy(skel);
+}
+
+static void subtest_sleepable(void)
+{
+	struct test_build_id *skel;
+	struct bpf_stack_build_id *stack;
+	int frame_cnt;
+
+	skel = test_build_id__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_open"))
+		return;
+
+	skel->links.uprobe_sleepable = bpf_program__attach(skel->progs.uprobe_sleepable);
+	if (!ASSERT_OK_PTR(skel->links.uprobe_sleepable, "link"))
+		goto cleanup;
+
+	/* force build ID to not be paged in */
+	ASSERT_OK(system("./uprobe_multi uprobe-paged-out"), "trigger_uprobe");
+
+	if (!ASSERT_GT(skel->bss->res_sleepable, 0, "res"))
+		goto cleanup;
+
+	stack = skel->bss->stack_sleepable;
+	frame_cnt = skel->bss->res_sleepable / sizeof(struct bpf_stack_build_id);
+	if (env.verbosity >= VERBOSE_NORMAL)
+		print_stack(stack, frame_cnt);
+
+	ASSERT_EQ(stack[0].status, BPF_STACK_BUILD_ID_VALID, "build_id_status");
+	ASSERT_EQ(memcmp(stack[0].build_id, build_id, build_id_sz), 0, "build_id_match");
+
+cleanup:
+	test_build_id__destroy(skel);
+}
+
+void test_build_id(void)
+{
+	build_id_sz = read_build_id("uprobe_multi", build_id, sizeof(build_id));
+	ASSERT_EQ(build_id_sz, BPF_BUILD_ID_SIZE, "parse_build_id");
+
+	if (test__start_subtest("nofault-paged-out"))
+		subtest_nofault(false /* not resident */);
+	if (test__start_subtest("nofault-paged-in"))
+		subtest_nofault(true /* resident */);
+	if (test__start_subtest("sleepable"))
+		subtest_sleepable();
+}
diff --git a/tools/testing/selftests/bpf/progs/test_build_id.c b/tools/testing/selftests/bpf/progs/test_build_id.c
new file mode 100644
index 000000000000..32ce59f9aa27
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_build_id.c
@@ -0,0 +1,31 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+
+struct bpf_stack_build_id stack_sleepable[128];
+int res_sleepable;
+
+struct bpf_stack_build_id stack_nofault[128];
+int res_nofault;
+
+SEC("uprobe.multi/./uprobe_multi:uprobe")
+int uprobe_nofault(struct pt_regs *ctx)
+{
+	res_nofault = bpf_get_stack(ctx, stack_nofault, sizeof(stack_nofault),
+				    BPF_F_USER_STACK | BPF_F_USER_BUILD_ID);
+
+	return 0;
+}
+
+SEC("uprobe.multi.s/./uprobe_multi:uprobe")
+int uprobe_sleepable(struct pt_regs *ctx)
+{
+	res_sleepable = bpf_get_stack(ctx, stack_sleepable, sizeof(stack_sleepable),
+				      BPF_F_USER_STACK | BPF_F_USER_BUILD_ID);
+
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/uprobe_multi.c b/tools/testing/selftests/bpf/uprobe_multi.c
index 7ffa563ffeba..c7828b13e5ff 100644
--- a/tools/testing/selftests/bpf/uprobe_multi.c
+++ b/tools/testing/selftests/bpf/uprobe_multi.c
@@ -2,8 +2,21 @@
 
 #include <stdio.h>
 #include <string.h>
+#include <stdbool.h>
+#include <stdint.h>
+#include <sys/mman.h>
+#include <unistd.h>
 #include <sdt.h>
 
+#ifndef MADV_POPULATE_READ
+#define MADV_POPULATE_READ 22
+#endif
+
+int __attribute__((weak)) uprobe(void)
+{
+	return 0;
+}
+
 #define __PASTE(a, b) a##b
 #define PASTE(a, b) __PASTE(a, b)
 
@@ -75,6 +88,30 @@ static int usdt(void)
 	return 0;
 }
 
+extern char build_id_start[];
+extern char build_id_end[];
+
+int __attribute__((weak)) trigger_uprobe(bool build_id_resident)
+{
+	int page_sz = sysconf(_SC_PAGESIZE);
+	void *addr;
+
+	/* page-align build ID start */
+	addr = (void *)((uintptr_t)&build_id_start & ~(page_sz - 1));
+
+	/* to guarantee MADV_PAGEOUT work reliably, we need to ensure that
+	 * memory range is mapped into current process, so we unconditionally
+	 * do MADV_POPULATE_READ, and then MADV_PAGEOUT, if necessary
+	 */
+	madvise(addr, page_sz, MADV_POPULATE_READ);
+	if (!build_id_resident)
+		madvise(addr, page_sz, MADV_PAGEOUT);
+
+	(void)uprobe();
+
+	return 0;
+}
+
 int main(int argc, char **argv)
 {
 	if (argc != 2)
@@ -84,6 +121,10 @@ int main(int argc, char **argv)
 		return bench();
 	if (!strcmp("usdt", argv[1]))
 		return usdt();
+	if (!strcmp("uprobe-paged-out", argv[1]))
+		return trigger_uprobe(false /* page-out build ID */);
+	if (!strcmp("uprobe-paged-in", argv[1]))
+		return trigger_uprobe(true /* page-in build ID */);
 
 error:
 	fprintf(stderr, "usage: %s <bench|usdt>\n", argv[0]);
diff --git a/tools/testing/selftests/bpf/uprobe_multi.ld b/tools/testing/selftests/bpf/uprobe_multi.ld
new file mode 100644
index 000000000000..a2e94828bc8c
--- /dev/null
+++ b/tools/testing/selftests/bpf/uprobe_multi.ld
@@ -0,0 +1,11 @@
+SECTIONS
+{
+	. = ALIGN(4096);
+	.note.gnu.build-id : { *(.note.gnu.build-id) }
+	. = ALIGN(4096);
+}
+INSERT AFTER .text;
+
+build_id_start = ADDR(.note.gnu.build-id);
+build_id_end = ADDR(.note.gnu.build-id) + SIZEOF(.note.gnu.build-id);
+
-- 
2.43.0


