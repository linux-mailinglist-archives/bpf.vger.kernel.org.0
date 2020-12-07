Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3D132D15AC
	for <lists+bpf@lfdr.de>; Mon,  7 Dec 2020 17:14:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727689AbgLGQJv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Dec 2020 11:09:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727687AbgLGQJq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Dec 2020 11:09:46 -0500
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8BD8C0619D8
        for <bpf@vger.kernel.org>; Mon,  7 Dec 2020 08:08:35 -0800 (PST)
Received: by mail-wr1-x449.google.com with SMTP id n13so4989366wrs.10
        for <bpf@vger.kernel.org>; Mon, 07 Dec 2020 08:08:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=F8q15uurYusuqCI5WIqN7I1H0pNNgVy0iWxVaQ2psc8=;
        b=aVHsbq/aTvNRVCTyJnu32HSN9RTP2X8ES/7cWcgsq9aaW+Fb6m4Oxj34gktoU8z7AX
         sScZCVkopOG79HSne8d4v7iMD3rCBP0aznBFTV5BcXU5/PwUPbevvAQh+lDSj9IS3T44
         Q/y0E9RnpGoyh8DjnsQrDY0nissosl+0+JmnqoL+RyYrLwMVM97xVmrSYStkiMLUrBPX
         pn+SYoj060qA0bfQaAjVXjCAzI54ikfmlKwJ4admc6CVeyutUbqLZMeQhUkpHihPHdui
         WORm6hfQsjEwRjV7E/nY++o33Fcq1IvqxwXqSrD5DvgmcVUa3q6eAU/1FLEQmPWhLkht
         aXug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=F8q15uurYusuqCI5WIqN7I1H0pNNgVy0iWxVaQ2psc8=;
        b=sHMHmw6jONiyYd/6iqH1QzAFU4bk81AOcINQSrJ0Kfjk/e+Jg5CQ9xzOEfvTTMmSAB
         R1f+Pj0qZOmLwp7YdDXLyfBg39rIw+Gg1L5XLCRHPKN5Qbt73HgtY8gXfo8tfxuErU7Z
         OWZjjfd+p43W5Fq38y/GbWZHly76cv4RxMX1e2Q1m5XMhO8jiJhFoOSJfO5Ba54UL4DI
         AEWhnC9lb+JFxIYuCbq0Oy+4Q8x6HiVVasb8LUsQqzBmAEAvDyPVc2zQEDUH/57dWvgR
         eQbKkv5cIFF95d5JyBqXJtkmR3aO3A+MR+t1TrDLjJQqnlzstNYs9N+R1jkGmJ0UyYfo
         FZlg==
X-Gm-Message-State: AOAM532v9rcngoOaKQziAzdJQZZSundjTNRDl55rUq4vBnoVxchxd/3n
        GGQXyr0LSXmif9Ra66bxPFc518N1zh2d1jPTJXrMoRvanPaJNfPGopLEJ8OcIq0wuF1ftdGkdVW
        9kFTyxVhs9tm9tsxSC7EQtpSaFayIGwIe5IhaYycDN5DJzACY67YO9J0taF/h9TI=
X-Google-Smtp-Source: ABdhPJwVQxNbTSafRBavTsq3fYlp0FmZm1KWw34bR1I+ZoRbVZ1T8lbb+0l6Qf1IE+zCfaxYIPfz776jiLp0vQ==
Sender: "jackmanb via sendgmr" <jackmanb@beeg.c.googlers.com>
X-Received: from beeg.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:11db])
 (user=jackmanb job=sendgmr) by 2002:a7b:c8c8:: with SMTP id
 f8mr55288wml.0.1607357313913; Mon, 07 Dec 2020 08:08:33 -0800 (PST)
Date:   Mon,  7 Dec 2020 16:07:33 +0000
In-Reply-To: <20201207160734.2345502-1-jackmanb@google.com>
Message-Id: <20201207160734.2345502-11-jackmanb@google.com>
Mime-Version: 1.0
References: <20201207160734.2345502-1-jackmanb@google.com>
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
Subject: [PATCH bpf-next v4 10/11] bpf: Add tests for new BPF atomic operations
From:   Brendan Jackman <jackmanb@google.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>, Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        linux-kernel@vger.kernel.org, Jann Horn <jannh@google.com>,
        Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The prog_test that's added depends on Clang/LLVM features added by
Yonghong in commit 286daafd6512 (was https://reviews.llvm.org/D72184).

Note the use of a define called ENABLE_ATOMICS_TESTS: this is used
to:

 - Avoid breaking the build for people on old versions of Clang
 - Avoid needing separate lists of test objects for no_alu32, where
   atomics are not supported even if Clang has the feature.

The atomics_test.o BPF object is built unconditionally both for
test_progs and test_progs-no_alu32. For test_progs, if Clang supports
atomics, ENABLE_ATOMICS_TESTS is defined, so it includes the proper
test code. Otherwise, progs and global vars are defined anyway, as
stubs; this means that the skeleton user code still builds.

The atomics_test.o userspace object is built once and used for both
test_progs and test_progs-no_alu32. A variable called skip_tests is
defined in the BPF object's data section, which tells the userspace
object whether to skip the atomics test.

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 tools/testing/selftests/bpf/Makefile          |  10 +
 .../selftests/bpf/prog_tests/atomics.c        | 246 ++++++++++++++++++
 tools/testing/selftests/bpf/progs/atomics.c   | 154 +++++++++++
 .../selftests/bpf/verifier/atomic_and.c       |  77 ++++++
 .../selftests/bpf/verifier/atomic_cmpxchg.c   |  96 +++++++
 .../selftests/bpf/verifier/atomic_fetch_add.c | 106 ++++++++
 .../selftests/bpf/verifier/atomic_or.c        |  77 ++++++
 .../selftests/bpf/verifier/atomic_xchg.c      |  46 ++++
 .../selftests/bpf/verifier/atomic_xor.c       |  77 ++++++
 9 files changed, 889 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/atomics.c
 create mode 100644 tools/testing/selftests/bpf/progs/atomics.c
 create mode 100644 tools/testing/selftests/bpf/verifier/atomic_and.c
 create mode 100644 tools/testing/selftests/bpf/verifier/atomic_cmpxchg.c
 create mode 100644 tools/testing/selftests/bpf/verifier/atomic_fetch_add.c
 create mode 100644 tools/testing/selftests/bpf/verifier/atomic_or.c
 create mode 100644 tools/testing/selftests/bpf/verifier/atomic_xchg.c
 create mode 100644 tools/testing/selftests/bpf/verifier/atomic_xor.c

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index ac25ba5d0d6c..13bc1d736164 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -239,6 +239,12 @@ BPF_CFLAGS = -g -D__TARGET_ARCH_$(SRCARCH) $(MENDIAN) 			\
 	     -I$(INCLUDE_DIR) -I$(CURDIR) -I$(APIDIR)			\
 	     -I$(abspath $(OUTPUT)/../usr/include)
 
+# BPF atomics support was added to Clang in llvm-project commit 286daafd6512
+# (release 12.0.0).
+BPF_ATOMICS_SUPPORTED = $(shell \
+	echo "int x = 0; int foo(void) { return __sync_val_compare_and_swap(&x, 1, 2); }" \
+	| $(CLANG) -x cpp-output -S -target bpf -mcpu=v3 - -o /dev/null && echo 1 || echo 0)
+
 CLANG_CFLAGS = $(CLANG_SYS_INCLUDES) \
 	       -Wno-compare-distinct-pointer-types
 
@@ -399,11 +405,15 @@ TRUNNER_EXTRA_FILES := $(OUTPUT)/urandom_read $(OUTPUT)/bpf_testmod.ko	\
 		       $(wildcard progs/btf_dump_test_case_*.c)
 TRUNNER_BPF_BUILD_RULE := CLANG_BPF_BUILD_RULE
 TRUNNER_BPF_CFLAGS := $(BPF_CFLAGS) $(CLANG_CFLAGS)
+ifeq ($(BPF_ATOMICS_SUPPORTED),1)
+  TRUNNER_BPF_CFLAGS += -DENABLE_ATOMICS_TESTS
+endif
 TRUNNER_BPF_LDFLAGS := -mattr=+alu32
 $(eval $(call DEFINE_TEST_RUNNER,test_progs))
 
 # Define test_progs-no_alu32 test runner.
 TRUNNER_BPF_BUILD_RULE := CLANG_NOALU32_BPF_BUILD_RULE
+TRUNNER_BPF_CFLAGS := $(BPF_CFLAGS) $(CLANG_CFLAGS)
 TRUNNER_BPF_LDFLAGS :=
 $(eval $(call DEFINE_TEST_RUNNER,test_progs,no_alu32))
 
diff --git a/tools/testing/selftests/bpf/prog_tests/atomics.c b/tools/testing/selftests/bpf/prog_tests/atomics.c
new file mode 100644
index 000000000000..c841a3abc2f7
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/atomics.c
@@ -0,0 +1,246 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <test_progs.h>
+
+#include "atomics.skel.h"
+
+static void test_add(struct atomics *skel)
+{
+	int err, prog_fd;
+	__u32 duration = 0, retval;
+	struct bpf_link *link;
+
+	link = bpf_program__attach(skel->progs.add);
+	if (CHECK(IS_ERR(link), "attach(add)", "err: %ld\n", PTR_ERR(link)))
+		return;
+
+	prog_fd = bpf_program__fd(skel->progs.add);
+	err = bpf_prog_test_run(prog_fd, 1, NULL, 0,
+				NULL, NULL, &retval, &duration);
+	if (CHECK(err || retval, "test_run add",
+		  "err %d errno %d retval %d duration %d\n", err, errno, retval, duration))
+		goto cleanup;
+
+	ASSERT_EQ(skel->data->add64_value, 3, "add64_value");
+	ASSERT_EQ(skel->bss->add64_result, 1, "add64_result");
+
+	ASSERT_EQ(skel->data->add32_value, 3, "add32_value");
+	ASSERT_EQ(skel->bss->add32_result, 1, "add32_result");
+
+	ASSERT_EQ(skel->bss->add_stack_value_copy, 3, "add_stack_value");
+	ASSERT_EQ(skel->bss->add_stack_result, 1, "add_stack_result");
+
+	ASSERT_EQ(skel->data->add_noreturn_value, 3, "add_noreturn_value");
+
+cleanup:
+	bpf_link__destroy(link);
+}
+
+static void test_sub(struct atomics *skel)
+{
+	int err, prog_fd;
+	__u32 duration = 0, retval;
+	struct bpf_link *link;
+
+	link = bpf_program__attach(skel->progs.sub);
+	if (CHECK(IS_ERR(link), "attach(sub)", "err: %ld\n", PTR_ERR(link)))
+		return;
+
+	prog_fd = bpf_program__fd(skel->progs.sub);
+	err = bpf_prog_test_run(prog_fd, 1, NULL, 0,
+				NULL, NULL, &retval, &duration);
+	if (CHECK(err || retval, "test_run sub",
+		  "err %d errno %d retval %d duration %d\n",
+		  err, errno, retval, duration))
+		goto cleanup;
+
+	ASSERT_EQ(skel->data->sub64_value, -1, "sub64_value");
+	ASSERT_EQ(skel->bss->sub64_result, 1, "sub64_result");
+
+	ASSERT_EQ(skel->data->sub32_value, -1, "sub32_value");
+	ASSERT_EQ(skel->bss->sub32_result, 1, "sub32_result");
+
+	ASSERT_EQ(skel->bss->sub_stack_value_copy, -1, "sub_stack_value");
+	ASSERT_EQ(skel->bss->sub_stack_result, 1, "sub_stack_result");
+
+	ASSERT_EQ(skel->data->sub_noreturn_value, -1, "sub_noreturn_value");
+
+cleanup:
+	bpf_link__destroy(link);
+}
+
+static void test_and(struct atomics *skel)
+{
+	int err, prog_fd;
+	__u32 duration = 0, retval;
+	struct bpf_link *link;
+
+	link = bpf_program__attach(skel->progs.and);
+	if (CHECK(IS_ERR(link), "attach(and)", "err: %ld\n", PTR_ERR(link)))
+		return;
+
+	prog_fd = bpf_program__fd(skel->progs.and);
+	err = bpf_prog_test_run(prog_fd, 1, NULL, 0,
+				NULL, NULL, &retval, &duration);
+	if (CHECK(err || retval, "test_run and",
+		  "err %d errno %d retval %d duration %d\n", err, errno, retval, duration))
+		goto cleanup;
+
+	ASSERT_EQ(skel->data->and64_value, 0x010ull << 32, "and64_value");
+	ASSERT_EQ(skel->bss->and64_result, 0x110ull << 32, "and64_result");
+
+	ASSERT_EQ(skel->data->and32_value, 0x010, "and32_value");
+	ASSERT_EQ(skel->bss->and32_result, 0x110, "and32_result");
+
+	ASSERT_EQ(skel->data->and_noreturn_value, 0x010ull << 32, "and_noreturn_value");
+cleanup:
+	bpf_link__destroy(link);
+}
+
+static void test_or(struct atomics *skel)
+{
+	int err, prog_fd;
+	__u32 duration = 0, retval;
+	struct bpf_link *link;
+
+	link = bpf_program__attach(skel->progs.or);
+	if (CHECK(IS_ERR(link), "attach(or)", "err: %ld\n", PTR_ERR(link)))
+		return;
+
+	prog_fd = bpf_program__fd(skel->progs.or);
+	err = bpf_prog_test_run(prog_fd, 1, NULL, 0,
+				NULL, NULL, &retval, &duration);
+	if (CHECK(err || retval, "test_run or",
+		  "err %d errno %d retval %d duration %d\n",
+		  err, errno, retval, duration))
+		goto cleanup;
+
+	ASSERT_EQ(skel->data->or64_value, 0x111ull << 32, "or64_value");
+	ASSERT_EQ(skel->bss->or64_result, 0x110ull << 32, "or64_result");
+
+	ASSERT_EQ(skel->data->or32_value, 0x111, "or32_value");
+	ASSERT_EQ(skel->bss->or32_result, 0x110, "or32_result");
+
+	ASSERT_EQ(skel->data->or_noreturn_value, 0x111ull << 32, "or_noreturn_value");
+cleanup:
+	bpf_link__destroy(link);
+}
+
+static void test_xor(struct atomics *skel)
+{
+	int err, prog_fd;
+	__u32 duration = 0, retval;
+	struct bpf_link *link;
+
+	link = bpf_program__attach(skel->progs.xor);
+	if (CHECK(IS_ERR(link), "attach(xor)", "err: %ld\n", PTR_ERR(link)))
+		return;
+
+	prog_fd = bpf_program__fd(skel->progs.xor);
+	err = bpf_prog_test_run(prog_fd, 1, NULL, 0,
+				NULL, NULL, &retval, &duration);
+	if (CHECK(err || retval, "test_run xor",
+		  "err %d errno %d retval %d duration %d\n", err, errno, retval, duration))
+		goto cleanup;
+
+	ASSERT_EQ(skel->data->xor64_value, 0x101ull << 32, "xor64_value");
+	ASSERT_EQ(skel->bss->xor64_result, 0x110ull << 32, "xor64_result");
+
+	ASSERT_EQ(skel->data->xor32_value, 0x101, "xor32_value");
+	ASSERT_EQ(skel->bss->xor32_result, 0x110, "xor32_result");
+
+	ASSERT_EQ(skel->data->xor_noreturn_value, 0x101ull << 32, "xor_nxoreturn_value");
+cleanup:
+	bpf_link__destroy(link);
+}
+
+static void test_cmpxchg(struct atomics *skel)
+{
+	int err, prog_fd;
+	__u32 duration = 0, retval;
+	struct bpf_link *link;
+
+	link = bpf_program__attach(skel->progs.cmpxchg);
+	if (CHECK(IS_ERR(link), "attach(cmpxchg)", "err: %ld\n", PTR_ERR(link)))
+		return;
+
+	prog_fd = bpf_program__fd(skel->progs.cmpxchg);
+	err = bpf_prog_test_run(prog_fd, 1, NULL, 0,
+				NULL, NULL, &retval, &duration);
+	if (CHECK(err || retval, "test_run add",
+		  "err %d errno %d retval %d duration %d\n", err, errno, retval, duration))
+		goto cleanup;
+
+	ASSERT_EQ(skel->data->cmpxchg64_value, 2, "cmpxchg64_value");
+	ASSERT_EQ(skel->bss->cmpxchg64_result_fail, 1, "cmpxchg_result_fail");
+	ASSERT_EQ(skel->bss->cmpxchg64_result_succeed, 1, "cmpxchg_result_succeed");
+
+	ASSERT_EQ(skel->data->cmpxchg32_value, 2, "lcmpxchg32_value");
+	ASSERT_EQ(skel->bss->cmpxchg32_result_fail, 1, "cmpxchg_result_fail");
+	ASSERT_EQ(skel->bss->cmpxchg32_result_succeed, 1, "cmpxchg_result_succeed");
+
+cleanup:
+	bpf_link__destroy(link);
+}
+
+static void test_xchg(struct atomics *skel)
+{
+	int err, prog_fd;
+	__u32 duration = 0, retval;
+	struct bpf_link *link;
+
+	link = bpf_program__attach(skel->progs.xchg);
+	if (CHECK(IS_ERR(link), "attach(xchg)", "err: %ld\n", PTR_ERR(link)))
+		return;
+
+	prog_fd = bpf_program__fd(skel->progs.xchg);
+	err = bpf_prog_test_run(prog_fd, 1, NULL, 0,
+				NULL, NULL, &retval, &duration);
+	if (CHECK(err || retval, "test_run add",
+		  "err %d errno %d retval %d duration %d\n", err, errno, retval, duration))
+		goto cleanup;
+
+	ASSERT_EQ(skel->data->xchg64_value, 2, "xchg64_value");
+	ASSERT_EQ(skel->bss->xchg64_result, 1, "xchg_result");
+
+	ASSERT_EQ(skel->data->xchg32_value, 2, "xchg32_value");
+	ASSERT_EQ(skel->bss->xchg32_result, 1, "xchg_result");
+
+cleanup:
+	bpf_link__destroy(link);
+}
+
+void test_atomics(void)
+{
+	struct atomics *skel;
+	__u32 duration = 0;
+
+	skel = atomics__open_and_load();
+	if (CHECK(!skel, "skel_load", "atomics skeleton failed\n"))
+		return;
+
+	if (skel->data->skip_tests) {
+		printf("%s:SKIP:no ENABLE_ATOMICS_TESTS (missing Clang BPF atomics support)",
+		       __func__);
+		test__skip();
+		goto cleanup;
+	}
+
+	if (test__start_subtest("add"))
+		test_add(skel);
+	if (test__start_subtest("sub"))
+		test_sub(skel);
+	if (test__start_subtest("and"))
+		test_and(skel);
+	if (test__start_subtest("or"))
+		test_or(skel);
+	if (test__start_subtest("xor"))
+		test_xor(skel);
+	if (test__start_subtest("cmpxchg"))
+		test_cmpxchg(skel);
+	if (test__start_subtest("xchg"))
+		test_xchg(skel);
+
+cleanup:
+	atomics__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/atomics.c b/tools/testing/selftests/bpf/progs/atomics.c
new file mode 100644
index 000000000000..d40c93496843
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/atomics.c
@@ -0,0 +1,154 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include <stdbool.h>
+
+#ifdef ENABLE_ATOMICS_TESTS
+bool skip_tests __attribute((__section__(".data"))) = false;
+#else
+bool skip_tests = true;
+#endif
+
+__u64 add64_value = 1;
+__u64 add64_result = 0;
+__u32 add32_value = 1;
+__u32 add32_result = 0;
+__u64 add_stack_value_copy = 0;
+__u64 add_stack_result = 0;
+__u64 add_noreturn_value = 1;
+
+SEC("fentry/bpf_fentry_test1")
+int BPF_PROG(add, int a)
+{
+#ifdef ENABLE_ATOMICS_TESTS
+	__u64 add_stack_value = 1;
+
+	add64_result = __sync_fetch_and_add(&add64_value, 2);
+	add32_result = __sync_fetch_and_add(&add32_value, 2);
+	add_stack_result = __sync_fetch_and_add(&add_stack_value, 2);
+	add_stack_value_copy = add_stack_value;
+	__sync_fetch_and_add(&add_noreturn_value, 2);
+#endif
+
+	return 0;
+}
+
+__s64 sub64_value = 1;
+__s64 sub64_result = 0;
+__s32 sub32_value = 1;
+__s32 sub32_result = 0;
+__s64 sub_stack_value_copy = 0;
+__s64 sub_stack_result = 0;
+__s64 sub_noreturn_value = 1;
+
+SEC("fentry/bpf_fentry_test1")
+int BPF_PROG(sub, int a)
+{
+#ifdef ENABLE_ATOMICS_TESTS
+	__u64 sub_stack_value = 1;
+
+	sub64_result = __sync_fetch_and_sub(&sub64_value, 2);
+	sub32_result = __sync_fetch_and_sub(&sub32_value, 2);
+	sub_stack_result = __sync_fetch_and_sub(&sub_stack_value, 2);
+	sub_stack_value_copy = sub_stack_value;
+	__sync_fetch_and_sub(&sub_noreturn_value, 2);
+#endif
+
+	return 0;
+}
+
+__u64 and64_value = (0x110ull << 32);
+__u64 and64_result = 0;
+__u32 and32_value = 0x110;
+__u32 and32_result = 0;
+__u64 and_noreturn_value = (0x110ull << 32);
+
+SEC("fentry/bpf_fentry_test1")
+int BPF_PROG(and, int a)
+{
+#ifdef ENABLE_ATOMICS_TESTS
+
+	and64_result = __sync_fetch_and_and(&and64_value, 0x011ull << 32);
+	and32_result = __sync_fetch_and_and(&and32_value, 0x011);
+	__sync_fetch_and_and(&and_noreturn_value, 0x011ull << 32);
+#endif
+
+	return 0;
+}
+
+__u64 or64_value = (0x110ull << 32);
+__u64 or64_result = 0;
+__u32 or32_value = 0x110;
+__u32 or32_result = 0;
+__u64 or_noreturn_value = (0x110ull << 32);
+
+SEC("fentry/bpf_fentry_test1")
+int BPF_PROG(or, int a)
+{
+#ifdef ENABLE_ATOMICS_TESTS
+	or64_result = __sync_fetch_and_or(&or64_value, 0x011ull << 32);
+	or32_result = __sync_fetch_and_or(&or32_value, 0x011);
+	__sync_fetch_and_or(&or_noreturn_value, 0x011ull << 32);
+#endif
+
+	return 0;
+}
+
+__u64 xor64_value = (0x110ull << 32);
+__u64 xor64_result = 0;
+__u32 xor32_value = 0x110;
+__u32 xor32_result = 0;
+__u64 xor_noreturn_value = (0x110ull << 32);
+
+SEC("fentry/bpf_fentry_test1")
+int BPF_PROG(xor, int a)
+{
+#ifdef ENABLE_ATOMICS_TESTS
+	xor64_result = __sync_fetch_and_xor(&xor64_value, 0x011ull << 32);
+	xor32_result = __sync_fetch_and_xor(&xor32_value, 0x011);
+	__sync_fetch_and_xor(&xor_noreturn_value, 0x011ull << 32);
+#endif
+
+	return 0;
+}
+
+__u64 cmpxchg64_value = 1;
+__u64 cmpxchg64_result_fail = 0;
+__u64 cmpxchg64_result_succeed = 0;
+__u32 cmpxchg32_value = 1;
+__u32 cmpxchg32_result_fail = 0;
+__u32 cmpxchg32_result_succeed = 0;
+
+SEC("fentry/bpf_fentry_test1")
+int BPF_PROG(cmpxchg, int a)
+{
+#ifdef ENABLE_ATOMICS_TESTS
+	cmpxchg64_result_fail = __sync_val_compare_and_swap(&cmpxchg64_value, 0, 3);
+	cmpxchg64_result_succeed = __sync_val_compare_and_swap(&cmpxchg64_value, 1, 2);
+
+	cmpxchg32_result_fail = __sync_val_compare_and_swap(&cmpxchg32_value, 0, 3);
+	cmpxchg32_result_succeed = __sync_val_compare_and_swap(&cmpxchg32_value, 1, 2);
+#endif
+
+	return 0;
+}
+
+__u64 xchg64_value = 1;
+__u64 xchg64_result = 0;
+__u32 xchg32_value = 1;
+__u32 xchg32_result = 0;
+
+SEC("fentry/bpf_fentry_test1")
+int BPF_PROG(xchg, int a)
+{
+#ifdef ENABLE_ATOMICS_TESTS
+	__u64 val64 = 2;
+	__u32 val32 = 2;
+
+	__atomic_exchange(&xchg64_value, &val64, &xchg64_result, __ATOMIC_RELAXED);
+	__atomic_exchange(&xchg32_value, &val32, &xchg32_result, __ATOMIC_RELAXED);
+#endif
+
+	return 0;
+}
diff --git a/tools/testing/selftests/bpf/verifier/atomic_and.c b/tools/testing/selftests/bpf/verifier/atomic_and.c
new file mode 100644
index 000000000000..7eea6d9dfd7d
--- /dev/null
+++ b/tools/testing/selftests/bpf/verifier/atomic_and.c
@@ -0,0 +1,77 @@
+{
+	"BPF_ATOMIC_AND without fetch",
+	.insns = {
+		/* val = 0x110; */
+		BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0x110),
+		/* atomic_and(&val, 0x011); */
+		BPF_MOV64_IMM(BPF_REG_1, 0x011),
+		BPF_ATOMIC_AND(BPF_DW, BPF_REG_10, BPF_REG_1, -8),
+		/* if (val != 0x010) exit(2); */
+		BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_10, -8),
+		BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0x010, 2),
+		BPF_MOV64_IMM(BPF_REG_0, 2),
+		BPF_EXIT_INSN(),
+		/* r1 should not be clobbered, no BPF_FETCH flag */
+		BPF_MOV64_IMM(BPF_REG_0, 0),
+		BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, 0x011, 1),
+		BPF_MOV64_IMM(BPF_REG_0, 1),
+		BPF_EXIT_INSN(),
+	},
+	.result = ACCEPT,
+},
+{
+	"BPF_ATOMIC_AND with fetch",
+	.insns = {
+		BPF_MOV64_IMM(BPF_REG_0, 123),
+		/* val = 0x110; */
+		BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0x110),
+		/* old = atomic_fetch_and(&val, 0x011); */
+		BPF_MOV64_IMM(BPF_REG_1, 0x011),
+		BPF_ATOMIC_FETCH_AND(BPF_DW, BPF_REG_10, BPF_REG_1, -8),
+		/* if (old != 0x110) exit(3); */
+		BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, 0x110, 2),
+		BPF_MOV64_IMM(BPF_REG_0, 3),
+		BPF_EXIT_INSN(),
+		/* if (val != 0x010) exit(2); */
+		BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_10, -8),
+		BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, 0x010, 2),
+		BPF_MOV64_IMM(BPF_REG_1, 2),
+		BPF_EXIT_INSN(),
+		/* Check R0 wasn't clobbered (for fear of x86 JIT bug) */
+		BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 123, 2),
+		BPF_MOV64_IMM(BPF_REG_0, 1),
+		BPF_EXIT_INSN(),
+		/* exit(0); */
+		BPF_MOV64_IMM(BPF_REG_0, 0),
+		BPF_EXIT_INSN(),
+	},
+	.result = ACCEPT,
+},
+{
+	"BPF_ATOMIC_AND with fetch 32bit",
+	.insns = {
+		/* r0 = (s64) -1 */
+		BPF_MOV64_IMM(BPF_REG_0, 0),
+		BPF_ALU64_IMM(BPF_SUB, BPF_REG_0, 1),
+		/* val = 0x110; */
+		BPF_ST_MEM(BPF_W, BPF_REG_10, -4, 0x110),
+		/* old = atomic_fetch_and(&val, 0x011); */
+		BPF_MOV32_IMM(BPF_REG_1, 0x011),
+		BPF_ATOMIC_FETCH_AND(BPF_W, BPF_REG_10, BPF_REG_1, -4),
+		/* if (old != 0x110) exit(3); */
+		BPF_JMP32_IMM(BPF_JEQ, BPF_REG_1, 0x110, 2),
+		BPF_MOV32_IMM(BPF_REG_0, 3),
+		BPF_EXIT_INSN(),
+		/* if (val != 0x010) exit(2); */
+		BPF_LDX_MEM(BPF_W, BPF_REG_1, BPF_REG_10, -4),
+		BPF_JMP32_IMM(BPF_JEQ, BPF_REG_1, 0x010, 2),
+		BPF_MOV32_IMM(BPF_REG_1, 2),
+		BPF_EXIT_INSN(),
+		/* Check R0 wasn't clobbered (for fear of x86 JIT bug)
+		 * It should be -1 so add 1 to get exit code.
+		 */
+		BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 1),
+		BPF_EXIT_INSN(),
+	},
+	.result = ACCEPT,
+},
diff --git a/tools/testing/selftests/bpf/verifier/atomic_cmpxchg.c b/tools/testing/selftests/bpf/verifier/atomic_cmpxchg.c
new file mode 100644
index 000000000000..335e12690be7
--- /dev/null
+++ b/tools/testing/selftests/bpf/verifier/atomic_cmpxchg.c
@@ -0,0 +1,96 @@
+{
+	"atomic compare-and-exchange smoketest - 64bit",
+	.insns = {
+		/* val = 3; */
+		BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 3),
+		/* old = atomic_cmpxchg(&val, 2, 4); */
+		BPF_MOV64_IMM(BPF_REG_1, 4),
+		BPF_MOV64_IMM(BPF_REG_0, 2),
+		BPF_ATOMIC_CMPXCHG(BPF_DW, BPF_REG_10, BPF_REG_1, -8),
+		/* if (old != 3) exit(2); */
+		BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 3, 2),
+		BPF_MOV64_IMM(BPF_REG_0, 2),
+		BPF_EXIT_INSN(),
+		/* if (val != 3) exit(3); */
+		BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_10, -8),
+		BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 3, 2),
+		BPF_MOV64_IMM(BPF_REG_0, 3),
+		BPF_EXIT_INSN(),
+		/* old = atomic_cmpxchg(&val, 3, 4); */
+		BPF_MOV64_IMM(BPF_REG_1, 4),
+		BPF_MOV64_IMM(BPF_REG_0, 3),
+		BPF_ATOMIC_CMPXCHG(BPF_DW, BPF_REG_10, BPF_REG_1, -8),
+		/* if (old != 3) exit(4); */
+		BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 3, 2),
+		BPF_MOV64_IMM(BPF_REG_0, 4),
+		BPF_EXIT_INSN(),
+		/* if (val != 4) exit(5); */
+		BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_10, -8),
+		BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 4, 2),
+		BPF_MOV64_IMM(BPF_REG_0, 5),
+		BPF_EXIT_INSN(),
+		/* exit(0); */
+		BPF_MOV64_IMM(BPF_REG_0, 0),
+		BPF_EXIT_INSN(),
+	},
+	.result = ACCEPT,
+},
+{
+	"atomic compare-and-exchange smoketest - 32bit",
+	.insns = {
+		/* val = 3; */
+		BPF_ST_MEM(BPF_W, BPF_REG_10, -4, 3),
+		/* old = atomic_cmpxchg(&val, 2, 4); */
+		BPF_MOV32_IMM(BPF_REG_1, 4),
+		BPF_MOV32_IMM(BPF_REG_0, 2),
+		BPF_ATOMIC_CMPXCHG(BPF_W, BPF_REG_10, BPF_REG_1, -4),
+		/* if (old != 3) exit(2); */
+		BPF_JMP32_IMM(BPF_JEQ, BPF_REG_0, 3, 2),
+		BPF_MOV32_IMM(BPF_REG_0, 2),
+		BPF_EXIT_INSN(),
+		/* if (val != 3) exit(3); */
+		BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_10, -4),
+		BPF_JMP32_IMM(BPF_JEQ, BPF_REG_0, 3, 2),
+		BPF_MOV32_IMM(BPF_REG_0, 3),
+		BPF_EXIT_INSN(),
+		/* old = atomic_cmpxchg(&val, 3, 4); */
+		BPF_MOV32_IMM(BPF_REG_1, 4),
+		BPF_MOV32_IMM(BPF_REG_0, 3),
+		BPF_ATOMIC_CMPXCHG(BPF_W, BPF_REG_10, BPF_REG_1, -4),
+		/* if (old != 3) exit(4); */
+		BPF_JMP32_IMM(BPF_JEQ, BPF_REG_0, 3, 2),
+		BPF_MOV32_IMM(BPF_REG_0, 4),
+		BPF_EXIT_INSN(),
+		/* if (val != 4) exit(5); */
+		BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_10, -4),
+		BPF_JMP32_IMM(BPF_JEQ, BPF_REG_0, 4, 2),
+		BPF_MOV32_IMM(BPF_REG_0, 5),
+		BPF_EXIT_INSN(),
+		/* exit(0); */
+		BPF_MOV32_IMM(BPF_REG_0, 0),
+		BPF_EXIT_INSN(),
+	},
+	.result = ACCEPT,
+},
+{
+	"Can't use cmpxchg on uninit src reg",
+	.insns = {
+		BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 3),
+		BPF_MOV64_IMM(BPF_REG_0, 3),
+		BPF_ATOMIC_CMPXCHG(BPF_DW, BPF_REG_10, BPF_REG_2, -8),
+		BPF_EXIT_INSN(),
+	},
+	.result = REJECT,
+	.errstr = "!read_ok",
+},
+{
+	"Can't use cmpxchg on uninit memory",
+	.insns = {
+		BPF_MOV64_IMM(BPF_REG_0, 3),
+		BPF_MOV64_IMM(BPF_REG_2, 4),
+		BPF_ATOMIC_CMPXCHG(BPF_DW, BPF_REG_10, BPF_REG_2, -8),
+		BPF_EXIT_INSN(),
+	},
+	.result = REJECT,
+	.errstr = "invalid read from stack",
+},
diff --git a/tools/testing/selftests/bpf/verifier/atomic_fetch_add.c b/tools/testing/selftests/bpf/verifier/atomic_fetch_add.c
new file mode 100644
index 000000000000..7c87bc9a13de
--- /dev/null
+++ b/tools/testing/selftests/bpf/verifier/atomic_fetch_add.c
@@ -0,0 +1,106 @@
+{
+	"BPF_ATOMIC_FETCH_ADD smoketest - 64bit",
+	.insns = {
+		BPF_MOV64_IMM(BPF_REG_0, 0),
+		/* Write 3 to stack */
+		BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 3),
+		/* Put a 1 in R1, add it to the 3 on the stack, and load the value back into R1 */
+		BPF_MOV64_IMM(BPF_REG_1, 1),
+		BPF_ATOMIC_FETCH_ADD(BPF_DW, BPF_REG_10, BPF_REG_1, -8),
+		/* Check the value we loaded back was 3 */
+		BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, 3, 2),
+		BPF_MOV64_IMM(BPF_REG_0, 1),
+		BPF_EXIT_INSN(),
+		/* Load value from stack */
+		BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_10, -8),
+		/* Check value loaded from stack was 4 */
+		BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, 4, 1),
+		BPF_MOV64_IMM(BPF_REG_0, 2),
+		BPF_EXIT_INSN(),
+	},
+	.result = ACCEPT,
+},
+{
+	"BPF_ATOMIC_FETCH_ADD smoketest - 32bit",
+	.insns = {
+		BPF_MOV64_IMM(BPF_REG_0, 0),
+		/* Write 3 to stack */
+		BPF_ST_MEM(BPF_W, BPF_REG_10, -4, 3),
+		/* Put a 1 in R1, add it to the 3 on the stack, and load the value back into R1 */
+		BPF_MOV32_IMM(BPF_REG_1, 1),
+		BPF_ATOMIC_FETCH_ADD(BPF_W, BPF_REG_10, BPF_REG_1, -4),
+		/* Check the value we loaded back was 3 */
+		BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, 3, 2),
+		BPF_MOV64_IMM(BPF_REG_0, 1),
+		BPF_EXIT_INSN(),
+		/* Load value from stack */
+		BPF_LDX_MEM(BPF_W, BPF_REG_1, BPF_REG_10, -4),
+		/* Check value loaded from stack was 4 */
+		BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, 4, 1),
+		BPF_MOV64_IMM(BPF_REG_0, 2),
+		BPF_EXIT_INSN(),
+	},
+	.result = ACCEPT,
+},
+{
+	"Can't use ATM_FETCH_ADD on frame pointer",
+	.insns = {
+		BPF_MOV64_IMM(BPF_REG_0, 0),
+		BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 3),
+		BPF_ATOMIC_FETCH_ADD(BPF_DW, BPF_REG_10, BPF_REG_10, -8),
+		BPF_EXIT_INSN(),
+	},
+	.result = REJECT,
+	.errstr_unpriv = "R10 leaks addr into mem",
+	.errstr = "frame pointer is read only",
+},
+{
+	"Can't use ATM_FETCH_ADD on uninit src reg",
+	.insns = {
+		BPF_MOV64_IMM(BPF_REG_0, 0),
+		BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 3),
+		BPF_ATOMIC_FETCH_ADD(BPF_DW, BPF_REG_10, BPF_REG_2, -8),
+		BPF_EXIT_INSN(),
+	},
+	.result = REJECT,
+	/* It happens that the address leak check is first, but it would also be
+	 * complain about the fact that we're trying to modify R10.
+	 */
+	.errstr = "!read_ok",
+},
+{
+	"Can't use ATM_FETCH_ADD on uninit dst reg",
+	.insns = {
+		BPF_MOV64_IMM(BPF_REG_0, 0),
+		BPF_ATOMIC_FETCH_ADD(BPF_DW, BPF_REG_2, BPF_REG_0, -8),
+		BPF_EXIT_INSN(),
+	},
+	.result = REJECT,
+	/* It happens that the address leak check is first, but it would also be
+	 * complain about the fact that we're trying to modify R10.
+	 */
+	.errstr = "!read_ok",
+},
+{
+	"Can't use ATM_FETCH_ADD on kernel memory",
+	.insns = {
+		/* This is an fentry prog, context is array of the args of the
+		 * kernel function being called. Load first arg into R2.
+		 */
+		BPF_LDX_MEM(BPF_DW, BPF_REG_2, BPF_REG_1, 0),
+		/* First arg of bpf_fentry_test7 is a pointer to a struct.
+		 * Attempt to modify that struct. Verifier shouldn't let us
+		 * because it's kernel memory.
+		 */
+		BPF_MOV64_IMM(BPF_REG_3, 1),
+		BPF_ATOMIC_FETCH_ADD(BPF_DW, BPF_REG_2, BPF_REG_3, 0),
+		/* Done */
+		BPF_MOV64_IMM(BPF_REG_0, 0),
+		BPF_EXIT_INSN(),
+	},
+	.prog_type = BPF_PROG_TYPE_TRACING,
+	.expected_attach_type = BPF_TRACE_FENTRY,
+	.kfunc = "bpf_fentry_test7",
+	.result = REJECT,
+	.errstr = "only read is supported",
+},
diff --git a/tools/testing/selftests/bpf/verifier/atomic_or.c b/tools/testing/selftests/bpf/verifier/atomic_or.c
new file mode 100644
index 000000000000..1b22fb2881f0
--- /dev/null
+++ b/tools/testing/selftests/bpf/verifier/atomic_or.c
@@ -0,0 +1,77 @@
+{
+	"BPF_ATOMIC_OR without fetch",
+	.insns = {
+		/* val = 0x110; */
+		BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0x110),
+		/* atomic_or(&val, 0x011); */
+		BPF_MOV64_IMM(BPF_REG_1, 0x011),
+		BPF_ATOMIC_OR(BPF_DW, BPF_REG_10, BPF_REG_1, -8),
+		/* if (val != 0x111) exit(2); */
+		BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_10, -8),
+		BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0x111, 2),
+		BPF_MOV64_IMM(BPF_REG_0, 2),
+		BPF_EXIT_INSN(),
+		/* r1 should not be clobbered, no BPF_FETCH flag */
+		BPF_MOV64_IMM(BPF_REG_0, 0),
+		BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, 0x011, 1),
+		BPF_MOV64_IMM(BPF_REG_0, 1),
+		BPF_EXIT_INSN(),
+	},
+	.result = ACCEPT,
+},
+{
+	"BPF_ATOMIC_OR with fetch",
+	.insns = {
+		BPF_MOV64_IMM(BPF_REG_0, 123),
+		/* val = 0x110; */
+		BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0x110),
+		/* old = atomic_fetch_or(&val, 0x011); */
+		BPF_MOV64_IMM(BPF_REG_1, 0x011),
+		BPF_ATOMIC_FETCH_OR(BPF_DW, BPF_REG_10, BPF_REG_1, -8),
+		/* if (old != 0x110) exit(3); */
+		BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, 0x110, 2),
+		BPF_MOV64_IMM(BPF_REG_0, 3),
+		BPF_EXIT_INSN(),
+		/* if (val != 0x111) exit(2); */
+		BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_10, -8),
+		BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, 0x111, 2),
+		BPF_MOV64_IMM(BPF_REG_1, 2),
+		BPF_EXIT_INSN(),
+		/* Check R0 wasn't clobbered (for fear of x86 JIT bug) */
+		BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 123, 2),
+		BPF_MOV64_IMM(BPF_REG_0, 1),
+		BPF_EXIT_INSN(),
+		/* exit(0); */
+		BPF_MOV64_IMM(BPF_REG_0, 0),
+		BPF_EXIT_INSN(),
+	},
+	.result = ACCEPT,
+},
+{
+	"BPF_ATOMIC_OR with fetch 32bit",
+	.insns = {
+		/* r0 = (s64) -1 */
+		BPF_MOV64_IMM(BPF_REG_0, 0),
+		BPF_ALU64_IMM(BPF_SUB, BPF_REG_0, 1),
+		/* val = 0x110; */
+		BPF_ST_MEM(BPF_W, BPF_REG_10, -4, 0x110),
+		/* old = atomic_fetch_or(&val, 0x011); */
+		BPF_MOV32_IMM(BPF_REG_1, 0x011),
+		BPF_ATOMIC_FETCH_OR(BPF_W, BPF_REG_10, BPF_REG_1, -4),
+		/* if (old != 0x110) exit(3); */
+		BPF_JMP32_IMM(BPF_JEQ, BPF_REG_1, 0x110, 2),
+		BPF_MOV32_IMM(BPF_REG_0, 3),
+		BPF_EXIT_INSN(),
+		/* if (val != 0x111) exit(2); */
+		BPF_LDX_MEM(BPF_W, BPF_REG_1, BPF_REG_10, -4),
+		BPF_JMP32_IMM(BPF_JEQ, BPF_REG_1, 0x111, 2),
+		BPF_MOV32_IMM(BPF_REG_1, 2),
+		BPF_EXIT_INSN(),
+		/* Check R0 wasn't clobbered (for fear of x86 JIT bug)
+		 * It should be -1 so add 1 to get exit code.
+		 */
+		BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 1),
+		BPF_EXIT_INSN(),
+	},
+	.result = ACCEPT,
+},
diff --git a/tools/testing/selftests/bpf/verifier/atomic_xchg.c b/tools/testing/selftests/bpf/verifier/atomic_xchg.c
new file mode 100644
index 000000000000..9348ac490e24
--- /dev/null
+++ b/tools/testing/selftests/bpf/verifier/atomic_xchg.c
@@ -0,0 +1,46 @@
+{
+	"atomic exchange smoketest - 64bit",
+	.insns = {
+		/* val = 3; */
+		BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 3),
+		/* old = atomic_xchg(&val, 4); */
+		BPF_MOV64_IMM(BPF_REG_1, 4),
+		BPF_ATOMIC_XCHG(BPF_DW, BPF_REG_10, BPF_REG_1, -8),
+		/* if (old != 3) exit(1); */
+		BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, 3, 2),
+		BPF_MOV64_IMM(BPF_REG_0, 1),
+		BPF_EXIT_INSN(),
+		/* if (val != 4) exit(2); */
+		BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_10, -8),
+		BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 4, 2),
+		BPF_MOV64_IMM(BPF_REG_0, 2),
+		BPF_EXIT_INSN(),
+		/* exit(0); */
+		BPF_MOV64_IMM(BPF_REG_0, 0),
+		BPF_EXIT_INSN(),
+	},
+	.result = ACCEPT,
+},
+{
+	"atomic exchange smoketest - 32bit",
+	.insns = {
+		/* val = 3; */
+		BPF_ST_MEM(BPF_W, BPF_REG_10, -4, 3),
+		/* old = atomic_xchg(&val, 4); */
+		BPF_MOV32_IMM(BPF_REG_1, 4),
+		BPF_ATOMIC_XCHG(BPF_W, BPF_REG_10, BPF_REG_1, -4),
+		/* if (old != 3) exit(1); */
+		BPF_JMP32_IMM(BPF_JEQ, BPF_REG_1, 3, 2),
+		BPF_MOV32_IMM(BPF_REG_0, 1),
+		BPF_EXIT_INSN(),
+		/* if (val != 4) exit(2); */
+		BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_10, -4),
+		BPF_JMP32_IMM(BPF_JEQ, BPF_REG_0, 4, 2),
+		BPF_MOV32_IMM(BPF_REG_0, 2),
+		BPF_EXIT_INSN(),
+		/* exit(0); */
+		BPF_MOV32_IMM(BPF_REG_0, 0),
+		BPF_EXIT_INSN(),
+	},
+	.result = ACCEPT,
+},
diff --git a/tools/testing/selftests/bpf/verifier/atomic_xor.c b/tools/testing/selftests/bpf/verifier/atomic_xor.c
new file mode 100644
index 000000000000..d1315419a3a8
--- /dev/null
+++ b/tools/testing/selftests/bpf/verifier/atomic_xor.c
@@ -0,0 +1,77 @@
+{
+	"BPF_ATOMIC_XOR without fetch",
+	.insns = {
+		/* val = 0x110; */
+		BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0x110),
+		/* atomic_xor(&val, 0x011); */
+		BPF_MOV64_IMM(BPF_REG_1, 0x011),
+		BPF_ATOMIC_XOR(BPF_DW, BPF_REG_10, BPF_REG_1, -8),
+		/* if (val != 0x101) exit(2); */
+		BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_10, -8),
+		BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0x101, 2),
+		BPF_MOV64_IMM(BPF_REG_0, 2),
+		BPF_EXIT_INSN(),
+		/* r1 should not be clobbered, no BPF_FETCH flag */
+		BPF_MOV64_IMM(BPF_REG_0, 0),
+		BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, 0x011, 1),
+		BPF_MOV64_IMM(BPF_REG_0, 1),
+		BPF_EXIT_INSN(),
+	},
+	.result = ACCEPT,
+},
+{
+	"BPF_ATOMIC_XOR with fetch",
+	.insns = {
+		BPF_MOV64_IMM(BPF_REG_0, 123),
+		/* val = 0x110; */
+		BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0x110),
+		/* old = atomic_fetch_xor(&val, 0x011); */
+		BPF_MOV64_IMM(BPF_REG_1, 0x011),
+		BPF_ATOMIC_FETCH_XOR(BPF_DW, BPF_REG_10, BPF_REG_1, -8),
+		/* if (old != 0x110) exit(3); */
+		BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, 0x110, 2),
+		BPF_MOV64_IMM(BPF_REG_0, 3),
+		BPF_EXIT_INSN(),
+		/* if (val != 0x101) exit(2); */
+		BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_10, -8),
+		BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, 0x101, 2),
+		BPF_MOV64_IMM(BPF_REG_1, 2),
+		BPF_EXIT_INSN(),
+		/* Check R0 wasn't clobbered (fxor fear of x86 JIT bug) */
+		BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 123, 2),
+		BPF_MOV64_IMM(BPF_REG_0, 1),
+		BPF_EXIT_INSN(),
+		/* exit(0); */
+		BPF_MOV64_IMM(BPF_REG_0, 0),
+		BPF_EXIT_INSN(),
+	},
+	.result = ACCEPT,
+},
+{
+	"BPF_ATOMIC_XOR with fetch 32bit",
+	.insns = {
+		/* r0 = (s64) -1 */
+		BPF_MOV64_IMM(BPF_REG_0, 0),
+		BPF_ALU64_IMM(BPF_SUB, BPF_REG_0, 1),
+		/* val = 0x110; */
+		BPF_ST_MEM(BPF_W, BPF_REG_10, -4, 0x110),
+		/* old = atomic_fetch_xor(&val, 0x011); */
+		BPF_MOV32_IMM(BPF_REG_1, 0x011),
+		BPF_ATOMIC_FETCH_XOR(BPF_W, BPF_REG_10, BPF_REG_1, -4),
+		/* if (old != 0x110) exit(3); */
+		BPF_JMP32_IMM(BPF_JEQ, BPF_REG_1, 0x110, 2),
+		BPF_MOV32_IMM(BPF_REG_0, 3),
+		BPF_EXIT_INSN(),
+		/* if (val != 0x101) exit(2); */
+		BPF_LDX_MEM(BPF_W, BPF_REG_1, BPF_REG_10, -4),
+		BPF_JMP32_IMM(BPF_JEQ, BPF_REG_1, 0x101, 2),
+		BPF_MOV32_IMM(BPF_REG_1, 2),
+		BPF_EXIT_INSN(),
+		/* Check R0 wasn't clobbered (fxor fear of x86 JIT bug)
+		 * It should be -1 so add 1 to get exit code.
+		 */
+		BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 1),
+		BPF_EXIT_INSN(),
+	},
+	.result = ACCEPT,
+},
-- 
2.29.2.576.ga3fc446d84-goog

