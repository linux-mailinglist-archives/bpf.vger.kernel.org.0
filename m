Return-Path: <bpf+bounces-74711-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B44EC62EA9
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 09:37:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B79F83B0DD1
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 08:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CC6D31E11C;
	Mon, 17 Nov 2025 08:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UkKVLrYn"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54DD31E0EA;
	Mon, 17 Nov 2025 08:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763368603; cv=none; b=urNY+EgqA9J4YMW8FtfMl61+5r9jE3l19xFBfNCk57f8+XEMt951+JMqHIi1g90laOzQPX+OWgRvxfv9vaCjyiL4TqyjntxFegtXhU50QtfXVS/OjRWXyVZ0+jqpVwTkt9y56zPpaS6wpnsZYbUiLhFvd3vk3cx7oUJjBtt1lT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763368603; c=relaxed/simple;
	bh=/5qSJ8wNriSPHR8ApO6IF7AwqhdYlmZZoO0i8yWAdwc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UExq/Do3sTSMRPft91pV9tM8rppGQeC3fqwSHa6V6qdgzKCIhwEnGwYO9Ezj2bVZfzONCf8GkUHM7+VUFfy8+Oh75PCDoKPMM3ziMW4u5+gshXLWZIXRWo4PxqXD2qWsl2mQdYO1oir3wJtNaapNA6SCqkiRmwc756a32MLwcdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UkKVLrYn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90564C4CEF1;
	Mon, 17 Nov 2025 08:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763368603;
	bh=/5qSJ8wNriSPHR8ApO6IF7AwqhdYlmZZoO0i8yWAdwc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UkKVLrYnrFyMXhjkcxKtZrrReAsFaSfUlQsBf1wnmplIDYmnKUJ/zE8fJSDwegsQZ
	 3aco2hVGHigGyDpyLqqsQzHKjMWt9TKk9aIaYvnZ7MtJzjLp8f9pSZ9igdL5ZSMcxu
	 enSWIOD0MTXcQvlg3DLH+txEEyJDIA6iAvd0sbThOaTOsOVnPyj+/l93W77jzJSNb0
	 6FwphJdihhaQhOAu9++GpU2qpPuTT0N/Li7+rfpsskY0z0pqGJKPR4y8etqjreOaFT
	 2ccP2CVdPp4T2ZHaAVdK0Cz4c3oGH9+qrqANI4rv5LuXN+WIWzarSjt7Z/vhDmu28P
	 R8WZJFKkwvePQ==
From: Jiri Olsa <jolsa@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>
Subject: [PATCH bpf-next 4/4] selftests/bpf: Add test for checking correct nop of optimized usdt
Date: Mon, 17 Nov 2025 09:35:51 +0100
Message-ID: <20251117083551.517393-5-jolsa@kernel.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251117083551.517393-1-jolsa@kernel.org>
References: <20251117083551.517393-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding test that attaches bpf program on usdt probe in 2 scenarios;

- attach program on top of usdt_1 which is standard nop probe
  incidentally followed by nop5. The usdt probe does not have
  extra data in elf note record, so we expect the probe to land
  on the first nop without being optimized.

- attach program on top of usdt_2 which is probe defined on top
  of nop,nop5 combo. The extra data in the elf note record and
  presence of upeobe syscall ensures that the probe is placed
  on top of nop5 and optimized.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/testing/selftests/bpf/.gitignore        |  2 +
 tools/testing/selftests/bpf/Makefile          |  7 +-
 tools/testing/selftests/bpf/prog_tests/usdt.c | 82 +++++++++++++++++++
 tools/testing/selftests/bpf/progs/test_usdt.c |  9 ++
 tools/testing/selftests/bpf/usdt_1.c          | 14 ++++
 tools/testing/selftests/bpf/usdt_2.c          | 13 +++
 6 files changed, 126 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/usdt_1.c
 create mode 100644 tools/testing/selftests/bpf/usdt_2.c

diff --git a/tools/testing/selftests/bpf/.gitignore b/tools/testing/selftests/bpf/.gitignore
index be1ee7ba7ce0..89f480729a6b 100644
--- a/tools/testing/selftests/bpf/.gitignore
+++ b/tools/testing/selftests/bpf/.gitignore
@@ -45,3 +45,5 @@ xdp_synproxy
 xdp_hw_metadata
 xdp_features
 verification_cert.h
+usdt_1
+usdt_2
diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 34ea23c63bd5..4a21657e45f7 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -733,6 +733,10 @@ $(VERIFICATION_CERT) $(PRIVATE_KEY): $(VERIFY_SIG_SETUP)
 $(VERIFY_SIG_HDR): $(VERIFICATION_CERT)
 	$(Q)xxd -i -n test_progs_verification_cert $< > $@
 
+ifeq ($(SRCARCH),$(filter $(SRCARCH),x86))
+USDTX := usdt_1.c usdt_2.c
+endif
+
 # Define test_progs test runner.
 TRUNNER_TESTS_DIR := prog_tests
 TRUNNER_BPF_PROGS_DIR := progs
@@ -754,7 +758,8 @@ TRUNNER_EXTRA_SOURCES := test_progs.c		\
 			 json_writer.c 		\
 			 $(VERIFY_SIG_HDR)		\
 			 flow_dissector_load.h	\
-			 ip_check_defrag_frags.h
+			 ip_check_defrag_frags.h \
+			 $(USDTX)
 TRUNNER_LIB_SOURCES := find_bit.c
 TRUNNER_EXTRA_FILES := $(OUTPUT)/urandom_read				\
 		       $(OUTPUT)/liburandom_read.so			\
diff --git a/tools/testing/selftests/bpf/prog_tests/usdt.c b/tools/testing/selftests/bpf/prog_tests/usdt.c
index f4be5269fa90..a8ca2920c009 100644
--- a/tools/testing/selftests/bpf/prog_tests/usdt.c
+++ b/tools/testing/selftests/bpf/prog_tests/usdt.c
@@ -247,6 +247,86 @@ static void subtest_basic_usdt(bool optimized)
 #undef TRIGGER
 }
 
+#ifdef __x86_64
+extern void usdt_1(void);
+extern void usdt_2(void);
+
+/* nop, nop5 */
+static unsigned char nop15[6] = { 0x90, 0x0f, 0x1f, 0x44, 0x00, 0x00 };
+
+static void *find_nop15(void *fn)
+{
+	int i;
+
+	for (i = 0; i < 10; i++) {
+		if (!memcmp(nop15, fn + i, 5))
+			return fn + i;
+	}
+	return NULL;
+}
+
+static void subtest_optimized_attach(void)
+{
+	struct test_usdt *skel;
+	__u8 *addr_1, *addr_2;
+
+	addr_1 = find_nop15(usdt_1);
+	if (!ASSERT_OK_PTR(addr_1, "find_nop15"))
+		return;
+
+	addr_2 = find_nop15(usdt_2);
+	if (!ASSERT_OK_PTR(addr_2, "find_nop15"))
+		return;
+
+	skel = test_usdt__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "test_usdt__open_and_load"))
+		return;
+
+	/*
+	 * Attach program on top of usdt_1 which is standard nop probe
+	 * incidentally followed by nop5. The usdt probe does not have
+	 * extra data in elf note record, so we expect the probe to land
+	 * on the first nop without being optimized.
+	 */
+	skel->links.usdt_executed = bpf_program__attach_usdt(skel->progs.usdt_executed,
+						     0 /*self*/, "/proc/self/exe",
+						     "optimized_attach", "usdt_1", NULL);
+	if (!ASSERT_OK_PTR(skel->links.usdt_executed, "bpf_program__attach_usdt"))
+		goto cleanup;
+
+	usdt_1();
+	usdt_1();
+
+	/* nop is on addr_1 address */
+	ASSERT_EQ(*addr_1, 0xcc, "int3");
+	ASSERT_EQ(skel->bss->executed, 2, "executed");
+
+	bpf_link__destroy(skel->links.usdt_executed);
+
+	/*
+	 * Attach program on top of usdt_2 which is probe defined on top
+	 * of nop,nop5 combo. The extra data in the elf note record and
+	 * presence of uprobe syscall ensures that the probe is placed
+	 * on top of nop5 and optimized.
+	 */
+	skel->links.usdt_executed = bpf_program__attach_usdt(skel->progs.usdt_executed,
+						     0 /*self*/, "/proc/self/exe",
+						     "optimized_attach", "usdt_2", NULL);
+	if (!ASSERT_OK_PTR(skel->links.usdt_executed, "bpf_program__attach_usdt"))
+		goto cleanup;
+
+	usdt_2();
+	usdt_2();
+
+	/* nop5 is on addr_2 + 1 address */
+	ASSERT_EQ(*(addr_2 + 1), 0xe8, "call");
+	ASSERT_EQ(skel->bss->executed, 4, "executed");
+
+cleanup:
+	test_usdt__destroy(skel);
+}
+#endif
+
 unsigned short test_usdt_100_semaphore SEC(".probes");
 unsigned short test_usdt_300_semaphore SEC(".probes");
 unsigned short test_usdt_400_semaphore SEC(".probes");
@@ -516,6 +596,8 @@ void test_usdt(void)
 #ifdef __x86_64__
 	if (test__start_subtest("basic_optimized"))
 		subtest_basic_usdt(true);
+	if (test__start_subtest("optimized_attach"))
+		subtest_optimized_attach();
 #endif
 	if (test__start_subtest("multispec"))
 		subtest_multispec_usdt();
diff --git a/tools/testing/selftests/bpf/progs/test_usdt.c b/tools/testing/selftests/bpf/progs/test_usdt.c
index a78c87537b07..6911868cdf67 100644
--- a/tools/testing/selftests/bpf/progs/test_usdt.c
+++ b/tools/testing/selftests/bpf/progs/test_usdt.c
@@ -138,4 +138,13 @@ int usdt_sib(struct pt_regs *ctx)
 	return 0;
 }
 
+int executed;
+
+SEC("usdt")
+int usdt_executed(struct pt_regs *ctx)
+{
+	executed++;
+	return 0;
+}
+
 char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/usdt_1.c b/tools/testing/selftests/bpf/usdt_1.c
new file mode 100644
index 000000000000..0e00702b1701
--- /dev/null
+++ b/tools/testing/selftests/bpf/usdt_1.c
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Include usdt.h with defined USDT_NOP macro will switch
+ * off the extra info in usdt probe.
+ */
+#define USDT_NOP .byte 0x90, 0x0f, 0x1f, 0x44, 0x00, 0x00
+#include "usdt.h"
+
+__attribute__((aligned(16)))
+void usdt_1(void)
+{
+	USDT(optimized_attach, usdt_1);
+}
diff --git a/tools/testing/selftests/bpf/usdt_2.c b/tools/testing/selftests/bpf/usdt_2.c
new file mode 100644
index 000000000000..fcb7417a1953
--- /dev/null
+++ b/tools/testing/selftests/bpf/usdt_2.c
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Include usdt.h with the extra info in usdt probe and
+ * nop/nop5 combo for usdt attach point.
+ */
+#include "usdt.h"
+
+__attribute__((aligned(16)))
+void usdt_2(void)
+{
+	USDT(optimized_attach, usdt_2);
+}
-- 
2.51.1


