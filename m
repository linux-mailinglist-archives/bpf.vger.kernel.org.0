Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F60D2CDABE
	for <lists+bpf@lfdr.de>; Thu,  3 Dec 2020 17:06:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728922AbgLCQEz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Dec 2020 11:04:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731206AbgLCQEz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Dec 2020 11:04:55 -0500
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5F49C09424F
        for <bpf@vger.kernel.org>; Thu,  3 Dec 2020 08:03:41 -0800 (PST)
Received: by mail-wm1-x349.google.com with SMTP id q17so1513768wmc.1
        for <bpf@vger.kernel.org>; Thu, 03 Dec 2020 08:03:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=+YlzII1FPWkmmWl374z00jUbytJDOFE0Tn9tWVZ2UuI=;
        b=nAS8arlCbJXC9apqOEdMxcOrnHzUIRhHMseBzyck3v8NFqRoGx42EahAhzmxrOb5W8
         lTki4MTFBScupBrmyXSn3nDL40CGepXn/sm33tzvg2xckuVi+D2s5LO1lwDajXxPpson
         dlhsPbYMfX9Xj0DaPYHpWM/ztQ1RYJggR+h7J6Qvj/lZeBcQ27Bx2rSwem3vAV3CyAcV
         LmNu+2yncq62WQCHl3joSQnC6smpETYpPLNVJzL5ypmcKmHqVfanrdu6ypVsIYopCSKe
         58t+VHN+C+mdUA7rSOzsWniP0cc8hkfdOP5ybD/mso/9jjMmBb933vw984vXOuRs8oDm
         uXWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=+YlzII1FPWkmmWl374z00jUbytJDOFE0Tn9tWVZ2UuI=;
        b=UhuCgLadPtK5ygTu5uI+O8uUvkgnrElJSgP/ARb2Udr3isrA85beKLttN9OxNqaMof
         qBcVe8yQGinybYSvFyFxCJzM4s3GZhfoiDDMWJZANulMXGVXkuPIIVDZIJITPjz7ZEUG
         yp/PRax/jQKeJS2EmN6+DikhP82uljzJ1qIaniBqoC6s4n1iRLKpckTZW7c8Yhn92zij
         AMnieDkMmDQX0ZzCSjXXLzXGjvqNbitRvklaJKb1Egjzs7y2+JHurqzsWw6rw7gfAZIQ
         yDf1HbLmimvz+9oHYGz8x0E1jdP7lFnyPEOQlSn5LiQ7qJMpUaL/yXdVNwoFsT9mQJbB
         qrLQ==
X-Gm-Message-State: AOAM530Ps523thiBXkq0oXCGGm7Tyfz7cA4Bnyz6Zth/cQoYoNjmgTfu
        fur7Ldcu8tih/CvvKDp1+werOhv1lj9eant6H4lX2W+MJD5molzLg/2Jc2M1vxxUOIZv+KwRQZm
        jft7mcmwY4C5VXY5ol6C/kfSxERnGYpkiGAXjEXoCLg7Mt94Z1b6NsBVMPRkwzm0=
X-Google-Smtp-Source: ABdhPJxzhEpI2QeJTsxw8kLtoiRXpeu1K241f+EdSBCTudWQ/2Knr4KMGsS7aTWhJDWONikctEZdHOIPeux/Pg==
Sender: "jackmanb via sendgmr" <jackmanb@beeg.c.googlers.com>
X-Received: from beeg.c.googlers.com ([fda3:e722:ac3:10:28:9cb1:c0a8:11db])
 (user=jackmanb job=sendgmr) by 2002:a1c:e1c6:: with SMTP id
 y189mr3700889wmg.172.1607011420575; Thu, 03 Dec 2020 08:03:40 -0800 (PST)
Date:   Thu,  3 Dec 2020 16:02:44 +0000
In-Reply-To: <20201203160245.1014867-1-jackmanb@google.com>
Message-Id: <20201203160245.1014867-14-jackmanb@google.com>
Mime-Version: 1.0
References: <20201203160245.1014867-1-jackmanb@google.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH bpf-next v3 13/14] bpf: Add tests for new BPF atomic operations
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

This relies on the work done by Yonghong Song in
https://reviews.llvm.org/D72184

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

Change-Id: Iecc12f35f0ded4a1dd805cce1be576e7b27917ef
Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 tools/testing/selftests/bpf/Makefile          |   4 +
 .../selftests/bpf/prog_tests/atomics_test.c   | 262 ++++++++++++++++++
 .../selftests/bpf/progs/atomics_test.c        | 154 ++++++++++
 .../selftests/bpf/verifier/atomic_and.c       |  77 +++++
 .../selftests/bpf/verifier/atomic_cmpxchg.c   |  96 +++++++
 .../selftests/bpf/verifier/atomic_fetch_add.c | 106 +++++++
 .../selftests/bpf/verifier/atomic_or.c        |  77 +++++
 .../selftests/bpf/verifier/atomic_xchg.c      |  46 +++
 .../selftests/bpf/verifier/atomic_xor.c       |  77 +++++
 9 files changed, 899 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/atomics_test.c
 create mode 100644 tools/testing/selftests/bpf/progs/atomics_test.c
 create mode 100644 tools/testing/selftests/bpf/verifier/atomic_and.c
 create mode 100644 tools/testing/selftests/bpf/verifier/atomic_cmpxchg.c
 create mode 100644 tools/testing/selftests/bpf/verifier/atomic_fetch_add.c
 create mode 100644 tools/testing/selftests/bpf/verifier/atomic_or.c
 create mode 100644 tools/testing/selftests/bpf/verifier/atomic_xchg.c
 create mode 100644 tools/testing/selftests/bpf/verifier/atomic_xor.c

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index f21c4841a612..448a9eb1a56c 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -431,11 +431,15 @@ TRUNNER_EXTRA_FILES := $(OUTPUT)/urandom_read				\
 		       $(wildcard progs/btf_dump_test_case_*.c)
 TRUNNER_BPF_BUILD_RULE := CLANG_BPF_BUILD_RULE
 TRUNNER_BPF_CFLAGS := $(BPF_CFLAGS) $(CLANG_CFLAGS)
+ifeq ($(feature-clang-bpf-atomics),1)
+  TRUNNER_BPF_CFLAGS += -DENABLE_ATOMICS_TESTS
+endif
 TRUNNER_BPF_LDFLAGS := -mattr=+alu32
 $(eval $(call DEFINE_TEST_RUNNER,test_progs))
 
 # Define test_progs-no_alu32 test runner.
 TRUNNER_BPF_BUILD_RULE := CLANG_NOALU32_BPF_BUILD_RULE
+TRUNNER_BPF_CFLAGS := $(BPF_CFLAGS) $(CLANG_CFLAGS)
 TRUNNER_BPF_LDFLAGS :=
 $(eval $(call DEFINE_TEST_RUNNER,test_progs,no_alu32))
 
diff --git a/tools/testing/selftests/bpf/prog_tests/atomics_test.c b/tools/testing/selftests/bpf/prog_tests/atomics_test.c
new file mode 100644
index 000000000000..66f0ccf4f4ec
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/atomics_test.c
@@ -0,0 +1,262 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <test_progs.h>
+
+
+#include "atomics_test.skel.h"
+
+static struct atomics_test *setup(void)
+{
+	struct atomics_test *atomics_skel;
+	__u32 duration = 0, err;
+
+	atomics_skel = atomics_test__open_and_load();
+	if (CHECK(!atomics_skel, "atomics_skel_load", "atomics skeleton failed\n"))
+		return NULL;
+
+	if (atomics_skel->data->skip_tests) {
+		printf("%s:SKIP:no ENABLE_ATOMICS_TEST (missing Clang BPF atomics support)",
+		       __func__);
+		test__skip();
+		goto err;
+	}
+
+	err = atomics_test__attach(atomics_skel);
+	if (CHECK(err, "atomics_attach", "atomics attach failed: %d\n", err))
+		goto err;
+
+	return atomics_skel;
+
+err:
+	atomics_test__destroy(atomics_skel);
+	return NULL;
+}
+
+static void test_add(void)
+{
+	struct atomics_test *atomics_skel;
+	int err, prog_fd;
+	__u32 duration = 0, retval;
+
+	atomics_skel = setup();
+	if (!atomics_skel)
+		return;
+
+	prog_fd = bpf_program__fd(atomics_skel->progs.add);
+	err = bpf_prog_test_run(prog_fd, 1, NULL, 0,
+				NULL, NULL, &retval, &duration);
+	if (CHECK(err || retval, "test_run add",
+		  "err %d errno %d retval %d duration %d\n",
+		  err, errno, retval, duration))
+		goto cleanup;
+
+	ASSERT_EQ(atomics_skel->data->add64_value, 3, "add64_value");
+	ASSERT_EQ(atomics_skel->bss->add64_result, 1, "add64_result");
+
+	ASSERT_EQ(atomics_skel->data->add32_value, 3, "add32_value");
+	ASSERT_EQ(atomics_skel->bss->add32_result, 1, "add32_result");
+
+	ASSERT_EQ(atomics_skel->bss->add_stack_value_copy, 3, "add_stack_value");
+	ASSERT_EQ(atomics_skel->bss->add_stack_result, 1, "add_stack_result");
+
+	ASSERT_EQ(atomics_skel->data->add_noreturn_value, 3, "add_noreturn_value");
+
+cleanup:
+	atomics_test__destroy(atomics_skel);
+}
+
+static void test_sub(void)
+{
+	struct atomics_test *atomics_skel;
+	int err, prog_fd;
+	__u32 duration = 0, retval;
+
+	atomics_skel = setup();
+	if (!atomics_skel)
+		return;
+
+	prog_fd = bpf_program__fd(atomics_skel->progs.sub);
+	err = bpf_prog_test_run(prog_fd, 1, NULL, 0,
+				NULL, NULL, &retval, &duration);
+	if (CHECK(err || retval, "test_run sub",
+		  "err %d errno %d retval %d duration %d\n",
+		  err, errno, retval, duration))
+		goto cleanup;
+
+	ASSERT_EQ(atomics_skel->data->sub64_value, -1, "sub64_value");
+	ASSERT_EQ(atomics_skel->bss->sub64_result, 1, "sub64_result");
+
+	ASSERT_EQ(atomics_skel->data->sub32_value, -1, "sub32_value");
+	ASSERT_EQ(atomics_skel->bss->sub32_result, 1, "sub32_result");
+
+	ASSERT_EQ(atomics_skel->bss->sub_stack_value_copy, -1, "sub_stack_value");
+	ASSERT_EQ(atomics_skel->bss->sub_stack_result, 1, "sub_stack_result");
+
+	ASSERT_EQ(atomics_skel->data->sub_noreturn_value, -1, "sub_noreturn_value");
+
+cleanup:
+	atomics_test__destroy(atomics_skel);
+}
+
+static void test_and(void)
+{
+	struct atomics_test *atomics_skel;
+	int err, prog_fd;
+	__u32 duration = 0, retval;
+
+	atomics_skel = setup();
+	if (!atomics_skel)
+		return;
+
+	prog_fd = bpf_program__fd(atomics_skel->progs.and);
+	err = bpf_prog_test_run(prog_fd, 1, NULL, 0,
+				NULL, NULL, &retval, &duration);
+	if (CHECK(err || retval, "test_run and",
+		  "err %d errno %d retval %d duration %d\n",
+		  err, errno, retval, duration))
+		goto cleanup;
+
+	ASSERT_EQ(atomics_skel->data->and64_value, 0x010ull << 32, "and64_value");
+	ASSERT_EQ(atomics_skel->bss->and64_result, 0x110ull << 32, "and64_result");
+
+	ASSERT_EQ(atomics_skel->data->and32_value, 0x010, "and32_value");
+	ASSERT_EQ(atomics_skel->bss->and32_result, 0x110, "and32_result");
+
+	ASSERT_EQ(atomics_skel->data->and_noreturn_value, 0x010ull << 32, "and_noreturn_value");
+cleanup:
+	atomics_test__destroy(atomics_skel);
+}
+
+static void test_or(void)
+{
+	struct atomics_test *atomics_skel;
+	int err, prog_fd;
+	__u32 duration = 0, retval;
+
+	atomics_skel = setup();
+	if (!atomics_skel)
+		return;
+
+	prog_fd = bpf_program__fd(atomics_skel->progs.or);
+	err = bpf_prog_test_run(prog_fd, 1, NULL, 0,
+				NULL, NULL, &retval, &duration);
+	if (CHECK(err || retval, "test_run or",
+		  "err %d errno %d retval %d duration %d\n",
+		  err, errno, retval, duration))
+		goto cleanup;
+
+	ASSERT_EQ(atomics_skel->data->or64_value, 0x111ull << 32, "or64_value");
+	ASSERT_EQ(atomics_skel->bss->or64_result, 0x110ull << 32, "or64_result");
+
+	ASSERT_EQ(atomics_skel->data->or32_value, 0x111, "or32_value");
+	ASSERT_EQ(atomics_skel->bss->or32_result, 0x110, "or32_result");
+
+	ASSERT_EQ(atomics_skel->data->or_noreturn_value, 0x111ull << 32, "or_noreturn_value");
+cleanup:
+	atomics_test__destroy(atomics_skel);
+}
+
+static void test_xor(void)
+{
+	struct atomics_test *atomics_skel;
+	int err, prog_fd;
+	__u32 duration = 0, retval;
+
+	atomics_skel = setup();
+	if (!atomics_skel)
+		return;
+
+	prog_fd = bpf_program__fd(atomics_skel->progs.xor);
+	err = bpf_prog_test_run(prog_fd, 1, NULL, 0,
+				NULL, NULL, &retval, &duration);
+	if (CHECK(err || retval, "test_run xor",
+		  "err %d errno %d retval %d duration %d\n",
+		  err, errno, retval, duration))
+		goto cleanup;
+
+	ASSERT_EQ(atomics_skel->data->xor64_value, 0x101ull << 32, "xor64_value");
+	ASSERT_EQ(atomics_skel->bss->xor64_result, 0x110ull << 32, "xor64_result");
+
+	ASSERT_EQ(atomics_skel->data->xor32_value, 0x101, "xor32_value");
+	ASSERT_EQ(atomics_skel->bss->xor32_result, 0x110, "xor32_result");
+
+	ASSERT_EQ(atomics_skel->data->xor_noreturn_value, 0x101ull << 32, "xor_nxoreturn_value");
+cleanup:
+	atomics_test__destroy(atomics_skel);
+}
+
+static void test_cmpxchg(void)
+{
+	struct atomics_test *atomics_skel;
+	int err, prog_fd;
+	__u32 duration = 0, retval;
+
+	atomics_skel = setup();
+	if (!atomics_skel)
+		return;
+
+	prog_fd = bpf_program__fd(atomics_skel->progs.add);
+	err = bpf_prog_test_run(prog_fd, 1, NULL, 0,
+				NULL, NULL, &retval, &duration);
+	if (CHECK(err || retval, "test_run add",
+		  "err %d errno %d retval %d duration %d\n",
+		  err, errno, retval, duration))
+		goto cleanup;
+
+	ASSERT_EQ(atomics_skel->data->cmpxchg64_value, 2, "cmpxchg64_value");
+	ASSERT_EQ(atomics_skel->bss->cmpxchg64_result_fail, 1, "cmpxchg_result_fail");
+	ASSERT_EQ(atomics_skel->bss->cmpxchg64_result_succeed, 1, "cmpxchg_result_succeed");
+
+	ASSERT_EQ(atomics_skel->data->cmpxchg32_value, 2, "cmpxchg32_value");
+	ASSERT_EQ(atomics_skel->bss->cmpxchg32_result_fail, 1, "cmpxchg_result_fail");
+	ASSERT_EQ(atomics_skel->bss->cmpxchg32_result_succeed, 1, "cmpxchg_result_succeed");
+
+cleanup:
+	atomics_test__destroy(atomics_skel);
+}
+
+static void test_xchg(void)
+{
+	struct atomics_test *atomics_skel;
+	int err, prog_fd;
+	__u32 duration = 0, retval;
+
+	atomics_skel = setup();
+	if (!atomics_skel)
+		return;
+
+	prog_fd = bpf_program__fd(atomics_skel->progs.add);
+	err = bpf_prog_test_run(prog_fd, 1, NULL, 0,
+				NULL, NULL, &retval, &duration);
+	if (CHECK(err || retval, "test_run add",
+		  "err %d errno %d retval %d duration %d\n",
+		  err, errno, retval, duration))
+		goto cleanup;
+
+	ASSERT_EQ(atomics_skel->data->xchg64_value, 2, "xchg64_value");
+	ASSERT_EQ(atomics_skel->bss->xchg64_result, 1, "xchg_result");
+
+	ASSERT_EQ(atomics_skel->data->xchg32_value, 2, "xchg32_value");
+	ASSERT_EQ(atomics_skel->bss->xchg32_result, 1, "xchg_result");
+
+cleanup:
+	atomics_test__destroy(atomics_skel);
+}
+
+void test_atomics_test(void)
+{
+	if (test__start_subtest("add"))
+		test_add();
+	if (test__start_subtest("sub"))
+		test_sub();
+	if (test__start_subtest("and"))
+		test_and();
+	if (test__start_subtest("or"))
+		test_or();
+	if (test__start_subtest("xor"))
+		test_xor();
+	if (test__start_subtest("cmpxchg"))
+		test_cmpxchg();
+	if (test__start_subtest("xchg"))
+		test_xchg();
+}
diff --git a/tools/testing/selftests/bpf/progs/atomics_test.c b/tools/testing/selftests/bpf/progs/atomics_test.c
new file mode 100644
index 000000000000..d40c93496843
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/atomics_test.c
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
2.29.2.454.gaff20da3a2-goog

