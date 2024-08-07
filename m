Return-Path: <bpf+bounces-36638-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95C2494B3C8
	for <lists+bpf@lfdr.de>; Thu,  8 Aug 2024 01:41:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BB781F23B6D
	for <lists+bpf@lfdr.de>; Wed,  7 Aug 2024 23:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B058315A868;
	Wed,  7 Aug 2024 23:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JlNpBX9j"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF57155337;
	Wed,  7 Aug 2024 23:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723074066; cv=none; b=u5zRnw/bBGF/IvSvbxzsF7JIm/fGl8bsNS8tVdgjDr9NCIY1+WOE4ysTh8A3onl+FHCoGVajtCjNwCJmAJb9UE3b/k5RqtKvXL6btbBfW4Euf8CIbg0GGWsbelAtGgrt4U4PVJ1ae7Eb4MwB+mrWzXIYcNXGO99L05BHdo0os+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723074066; c=relaxed/simple;
	bh=hAHRGfhHTT27DNY5NeOM9zG7twQB27NQc7Kw1Yx1Eb8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kiVoLNkRh9erYN14YGRYC/L2sEuiwFeeazeuw9U7Or0T28ymijSRMRMtCBJjMGMhuw1OeM5ueS38CY0ydF+aWAF+cO9jYhcEM/fH7veNqAz/67kAMb+qJLWXdqZT/7rwIQT8Aah1YeaSj8zG+vctRl8TPdL5Gj7ztKX9kAMYYGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JlNpBX9j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D440EC32781;
	Wed,  7 Aug 2024 23:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723074066;
	bh=hAHRGfhHTT27DNY5NeOM9zG7twQB27NQc7Kw1Yx1Eb8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JlNpBX9jVKmIG53xvPwkmLHj8GrI1W0nZDunZqSBiafNrJAimSpyjR0Zoys3ZCVnL
	 jRxl8G6yD6XeMT9XSCeHXwhBo16rhquu7Z5x6GIea5MUL3DNd27ryjMBi/qUrHtbiM
	 CiLV7VqELYvDt3NyZ24tAaRZxIMrXplnxmzg8TWxpSmIluLn88IOm09MFFb/kwbxQM
	 +7TUTxBYYZ0+DJzUigLHsmtcHfKcUfWbN5a05efBShYfG4uJ0xZPzdikya1K4Ts26n
	 6BSQ6q5MFjq02vEaO5lFmBDpHRGTVOI8Sbvr8GuxhBOEn6y8lvwzB42BqspOvgsTrM
	 nRIphpYe/SHQA==
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
	jannh@google.com,
	linux-fsdevel@vger.kernel.org,
	willy@infradead.org,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH v4 bpf-next 10/10] selftests/bpf: add build ID tests
Date: Wed,  7 Aug 2024 16:40:29 -0700
Message-ID: <20240807234029.456316-11-andrii@kernel.org>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240807234029.456316-1-andrii@kernel.org>
References: <20240807234029.456316-1-andrii@kernel.org>
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
index 7e4b107b37b4..e47d983d2694 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -787,9 +787,10 @@ $(OUTPUT)/veristat: $(OUTPUT)/veristat.o
 
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
index 000000000000..aec9c8d6bc96
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
+void serial_test_build_id(void)
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
2.43.5


