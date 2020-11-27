Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32FD52C6B2B
	for <lists+bpf@lfdr.de>; Fri, 27 Nov 2020 18:59:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733031AbgK0R6Q (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 27 Nov 2020 12:58:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732919AbgK0R6Q (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 27 Nov 2020 12:58:16 -0500
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60CFCC0613D2
        for <bpf@vger.kernel.org>; Fri, 27 Nov 2020 09:58:15 -0800 (PST)
Received: by mail-wm1-x34a.google.com with SMTP id o19so3483845wme.2
        for <bpf@vger.kernel.org>; Fri, 27 Nov 2020 09:58:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=dPT+lQWJVLkIOZCl+Ehie0vjz1PRtZaDFnCAvmHCwNo=;
        b=wCrqQ3p638zJv03Hi0Zjj6NaKsHOwiFhrl/AoYKYNR5ZhN6G3mpWJoNzb5tKpIXcbg
         E4sfa/+h5jWvCactB1/7i4O+skz135GYfCqU1Ga3OFa/h1i+Z/F4RilPvNuquRkeiVy8
         L1HWY36FW0zD5QSJ77PRoNSvUgHh0HSuLtggt5hg1liJasyF2uLedQdpC4YAbpAkrN7T
         Kro5LM2K5aG5AJdcp8yQB1rpKEXOy4YDVNZJ+2L0W3vXOE0qNeWJHdJr2O2kLGgCcFdJ
         7HbysCiRFep3txIdJBO1UcgU4foz6JC1Af8OJ4iX0OJludvlop5+K5hFwzaUXMHsM8j7
         u/ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=dPT+lQWJVLkIOZCl+Ehie0vjz1PRtZaDFnCAvmHCwNo=;
        b=pu3ZdN3sLhDxBgCYXVaHDxYaX+UrNUY17wOEaWoV2qLQ86JmdgmOjpj2Ugcb9E7kcz
         3Xm5AdkHH7OlNlEfieaznvAq9nEgXDAWYb5ozgJjI27UIbo3LCK34B9FLwIhVrjhDe0h
         B9Zw4OyL3zc7Z7nLDEAwSOa+hQI9keexdaSGJMcmAghIYeHC9ml3lDRJTMY5yQC6nkYs
         UbUY4Ou6+ESoIcPcVaTGbKHulUycYjqBXmz+fp8D+/akM6FvmAYY7er+ue24F+xbm1S4
         RrGmMG+7ZjQbLdT8eej8E8XvydqAGoro+rgATH3tZO8qctXylJGtLKx8jT7zQFx6DhEQ
         NjRg==
X-Gm-Message-State: AOAM530zrQdt1zBhGhRJ6deRPRn2LRrh97OA0AKkgaShNvNh7be0LYfo
        yGbFJzPz5VJpJC4SJsko5690B7Oi6PX6UnlqXZot4+ecHSawKSUyC+zvlzjdMMVJ0YfggrU5mip
        RNuevIfY1FgICoPClqXzxfVyss7Z2wQaEhk1SaMXg1jC2tCMFTCpDX6OTMjNfpHo=
X-Google-Smtp-Source: ABdhPJw4IuY7eYouHoaWm235PapJTC5s95Ac9K8GM5JT4mTePiFV/KVgx3tBOuXDTC4iUC1wRoeURJj1jZidEw==
Sender: "jackmanb via sendgmr" <jackmanb@beeg.c.googlers.com>
X-Received: from beeg.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:11db])
 (user=jackmanb job=sendgmr) by 2002:a1c:f20e:: with SMTP id
 s14mr10419901wmc.126.1606499893900; Fri, 27 Nov 2020 09:58:13 -0800 (PST)
Date:   Fri, 27 Nov 2020 17:57:37 +0000
In-Reply-To: <20201127175738.1085417-1-jackmanb@google.com>
Message-Id: <20201127175738.1085417-13-jackmanb@google.com>
Mime-Version: 1.0
References: <20201127175738.1085417-1-jackmanb@google.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH v2 bpf-next 12/13] bpf: Add tests for new BPF atomic operations
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

Note the hackery in the Makefile that is necessary to avoid breaking
tests for people who haven't yet got a version of Clang supporting
V4. It seems like this hackery ought to be confined to
tools/build/feature - I tried implementing that and found that it
ballooned into an explosion of nightmares at the top of
tools/testing/selftests/bpf/Makefile without actually improving the
clarity of the CLANG_BPF_BUILD_RULE code at all. Hence the simple
$(shell) call...

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 tools/testing/selftests/bpf/Makefile          |  12 +-
 .../selftests/bpf/prog_tests/atomics_test.c   | 329 ++++++++++++++++++
 .../selftests/bpf/progs/atomics_test.c        | 124 +++++++
 .../selftests/bpf/verifier/atomic_and.c       |  77 ++++
 .../selftests/bpf/verifier/atomic_cmpxchg.c   |  96 +++++
 .../selftests/bpf/verifier/atomic_fetch_add.c | 106 ++++++
 .../selftests/bpf/verifier/atomic_or.c        |  77 ++++
 .../selftests/bpf/verifier/atomic_sub.c       |  44 +++
 .../selftests/bpf/verifier/atomic_xchg.c      |  46 +++
 .../selftests/bpf/verifier/atomic_xor.c       |  77 ++++
 tools/testing/selftests/bpf/verifier/ctx.c    |   2 +-
 11 files changed, 987 insertions(+), 3 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/atomics_test.c
 create mode 100644 tools/testing/selftests/bpf/progs/atomics_test.c
 create mode 100644 tools/testing/selftests/bpf/verifier/atomic_and.c
 create mode 100644 tools/testing/selftests/bpf/verifier/atomic_cmpxchg.c
 create mode 100644 tools/testing/selftests/bpf/verifier/atomic_fetch_add.c
 create mode 100644 tools/testing/selftests/bpf/verifier/atomic_or.c
 create mode 100644 tools/testing/selftests/bpf/verifier/atomic_sub.c
 create mode 100644 tools/testing/selftests/bpf/verifier/atomic_xchg.c
 create mode 100644 tools/testing/selftests/bpf/verifier/atomic_xor.c

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 3d5940cd110d..5eadfd09037d 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -228,6 +228,12 @@ IS_LITTLE_ENDIAN = $(shell $(CC) -dM -E - </dev/null | \
 			grep 'define __BYTE_ORDER__ __ORDER_LITTLE_ENDIAN__')
 MENDIAN=$(if $(IS_LITTLE_ENDIAN),-mlittle-endian,-mbig-endian)
 
+# Determine if Clang supports BPF arch v4, and therefore atomics.
+CLANG_SUPPORTS_V4=$(if $(findstring v4,$(shell $(CLANG) --target=bpf -mcpu=? 2>&1)),true,)
+ifeq ($(CLANG_SUPPORTS_V4),true)
+	CFLAGS += -DENABLE_ATOMICS_TESTS
+endif
+
 CLANG_SYS_INCLUDES = $(call get_sys_includes,$(CLANG))
 BPF_CFLAGS = -g -D__TARGET_ARCH_$(SRCARCH) $(MENDIAN) 			\
 	     -I$(INCLUDE_DIR) -I$(CURDIR) -I$(APIDIR)			\
@@ -250,7 +256,9 @@ define CLANG_BPF_BUILD_RULE
 	$(call msg,CLNG-LLC,$(TRUNNER_BINARY),$2)
 	$(Q)($(CLANG) $3 -O2 -target bpf -emit-llvm			\
 		-c $1 -o - || echo "BPF obj compilation failed") | 	\
-	$(LLC) -mattr=dwarfris -march=bpf -mcpu=v3 $4 -filetype=obj -o $2
+	$(LLC) -mattr=dwarfris -march=bpf				\
+		-mcpu=$(if $(CLANG_SUPPORTS_V4),v4,v3)			\
+		$4 -filetype=obj -o $2
 endef
 # Similar to CLANG_BPF_BUILD_RULE, but with disabled alu32
 define CLANG_NOALU32_BPF_BUILD_RULE
@@ -391,7 +399,7 @@ TRUNNER_EXTRA_SOURCES := test_progs.c cgroup_helpers.c trace_helpers.c	\
 TRUNNER_EXTRA_FILES := $(OUTPUT)/urandom_read				\
 		       $(wildcard progs/btf_dump_test_case_*.c)
 TRUNNER_BPF_BUILD_RULE := CLANG_BPF_BUILD_RULE
-TRUNNER_BPF_CFLAGS := $(BPF_CFLAGS) $(CLANG_CFLAGS)
+TRUNNER_BPF_CFLAGS := $(BPF_CFLAGS) $(CLANG_CFLAGS) $(if $(CLANG_SUPPORTS_V4),-DENABLE_ATOMICS_TESTS,)
 TRUNNER_BPF_LDFLAGS := -mattr=+alu32
 $(eval $(call DEFINE_TEST_RUNNER,test_progs))
 
diff --git a/tools/testing/selftests/bpf/prog_tests/atomics_test.c b/tools/testing/selftests/bpf/prog_tests/atomics_test.c
new file mode 100644
index 000000000000..8ecc0392fdf9
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/atomics_test.c
@@ -0,0 +1,329 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <test_progs.h>
+
+#ifdef ENABLE_ATOMICS_TESTS
+
+#include "atomics_test.skel.h"
+
+static void test_add(void)
+{
+	struct atomics_test *atomics_skel = NULL;
+	int err, prog_fd;
+	__u32 duration = 0, retval;
+
+	atomics_skel = atomics_test__open_and_load();
+	if (CHECK(!atomics_skel, "atomics_skel_load", "atomics skeleton failed\n"))
+		goto cleanup;
+
+	err = atomics_test__attach(atomics_skel);
+	if (CHECK(err, "atomics_attach", "atomics attach failed: %d\n", err))
+		goto cleanup;
+
+	prog_fd = bpf_program__fd(atomics_skel->progs.add);
+	err = bpf_prog_test_run(prog_fd, 1, NULL, 0,
+				NULL, NULL, &retval, &duration);
+	if (CHECK(err || retval, "test_run add",
+		  "err %d errno %d retval %d duration %d\n",
+		  err, errno, retval, duration))
+		goto cleanup;
+
+	CHECK(atomics_skel->data->add64_value != 3, "add64_value",
+	      "64bit atomic add value was not incremented (got %lld want 2)\n",
+	      atomics_skel->data->add64_value);
+	CHECK(atomics_skel->bss->add64_result != 1, "add64_result",
+	      "64bit atomic add bad return value (got %lld want 1)\n",
+	      atomics_skel->bss->add64_result);
+
+	CHECK(atomics_skel->data->add32_value != 3, "add32_value",
+	      "32bit atomic add value was not incremented (got %d want 2)\n",
+	      atomics_skel->data->add32_value);
+	CHECK(atomics_skel->bss->add32_result != 1, "add32_result",
+	      "32bit atomic add bad return value (got %d want 1)\n",
+	      atomics_skel->bss->add32_result);
+
+	CHECK(atomics_skel->bss->add_stack_value_copy != 3, "add_stack_value",
+	      "stack atomic add value was not incremented (got %lld want 2)\n",
+	      atomics_skel->bss->add_stack_value_copy);
+	CHECK(atomics_skel->bss->add_stack_result != 1, "add_stack_result",
+	      "stack atomic add bad return value (got %lld want 1)\n",
+	      atomics_skel->bss->add_stack_result);
+
+cleanup:
+	atomics_test__destroy(atomics_skel);
+}
+
+static void test_sub(void)
+{
+	struct atomics_test *atomics_skel = NULL;
+	int err, prog_fd;
+	__u32 duration = 0, retval;
+
+	atomics_skel = atomics_test__open_and_load();
+	if (CHECK(!atomics_skel, "atomics_skel_load", "atomics skeleton failed\n"))
+		goto cleanup;
+
+	err = atomics_test__attach(atomics_skel);
+	if (CHECK(err, "atomics_attach", "atomics attach failed: %d\n", err))
+		goto cleanup;
+
+	prog_fd = bpf_program__fd(atomics_skel->progs.sub);
+	err = bpf_prog_test_run(prog_fd, 1, NULL, 0,
+				NULL, NULL, &retval, &duration);
+	if (CHECK(err || retval, "test_run sub",
+		  "err %d errno %d retval %d duration %d\n",
+		  err, errno, retval, duration))
+		goto cleanup;
+
+	CHECK(atomics_skel->data->sub64_value != -1, "sub64_value",
+	      "64bit atomic sub value was not decremented (got %lld want -1)\n",
+	      atomics_skel->data->sub64_value);
+	CHECK(atomics_skel->bss->sub64_result != 1, "sub64_result",
+	      "64bit atomic sub bad return value (got %lld want 1)\n",
+	      atomics_skel->bss->sub64_result);
+
+	CHECK(atomics_skel->data->sub32_value != -1, "sub32_value",
+	      "32bit atomic sub value was not decremented (got %d want -1)\n",
+	      atomics_skel->data->sub32_value);
+	CHECK(atomics_skel->bss->sub32_result != 1, "sub32_result",
+	      "32bit atomic sub bad return value (got %d want 1)\n",
+	      atomics_skel->bss->sub32_result);
+
+	CHECK(atomics_skel->bss->sub_stack_value_copy != -1, "sub_stack_value",
+	      "stack atomic sub value was not decremented (got %lld want -1)\n",
+	      atomics_skel->bss->sub_stack_value_copy);
+	CHECK(atomics_skel->bss->sub_stack_result != 1, "sub_stack_result",
+	      "stack atomic sub bad return value (got %lld want 1)\n",
+	      atomics_skel->bss->sub_stack_result);
+
+cleanup:
+	atomics_test__destroy(atomics_skel);
+}
+
+static void test_and(void)
+{
+	struct atomics_test *atomics_skel = NULL;
+	int err, prog_fd;
+	__u32 duration = 0, retval;
+
+	atomics_skel = atomics_test__open_and_load();
+	if (CHECK(!atomics_skel, "atomics_skel_load", "atomics skeleton failed\n"))
+		goto cleanup;
+
+	err = atomics_test__attach(atomics_skel);
+	if (CHECK(err, "atomics_attach", "atomics attach failed: %d\n", err))
+		goto cleanup;
+
+	prog_fd = bpf_program__fd(atomics_skel->progs.and);
+	err = bpf_prog_test_run(prog_fd, 1, NULL, 0,
+				NULL, NULL, &retval, &duration);
+	if (CHECK(err || retval, "test_run and",
+		  "err %d errno %d retval %d duration %d\n",
+		  err, errno, retval, duration))
+		goto cleanup;
+
+	CHECK(atomics_skel->data->and64_value != 0x010ull << 32, "and64_value",
+	      "64bit atomic and, bad value (got 0x%llx want 0x%llx)\n",
+	      atomics_skel->data->and64_value, 0x010ull << 32);
+	CHECK(atomics_skel->bss->and64_result != 0x110ull << 32, "and64_result",
+	      "64bit atomic and, bad result (got 0x%llx want 0x%llx)\n",
+	      atomics_skel->bss->and64_result, 0x110ull << 32);
+
+	CHECK(atomics_skel->data->and32_value != 0x010, "and32_value",
+	      "32bit atomic and, bad value (got 0x%x want 0x%x)\n",
+	      atomics_skel->data->and32_value, 0x010);
+	CHECK(atomics_skel->bss->and32_result != 0x110, "and32_result",
+	      "32bit atomic and, bad result (got 0x%x want 0x%x)\n",
+	      atomics_skel->bss->and32_result, 0x110);
+
+cleanup:
+	atomics_test__destroy(atomics_skel);
+}
+
+static void test_or(void)
+{
+	struct atomics_test *atomics_skel = NULL;
+	int err, prog_fd;
+	__u32 duration = 0, retval;
+
+	atomics_skel = atomics_test__open_and_load();
+	if (CHECK(!atomics_skel, "atomics_skel_load", "atomics skeleton failed\n"))
+		goto cleanup;
+
+	err = atomics_test__attach(atomics_skel);
+	if (CHECK(err, "atomics_attach", "atomics attach failed: %d\n", err))
+		goto cleanup;
+
+	prog_fd = bpf_program__fd(atomics_skel->progs.or);
+	err = bpf_prog_test_run(prog_fd, 1, NULL, 0,
+				NULL, NULL, &retval, &duration);
+	if (CHECK(err || retval, "test_run or",
+		  "err %d errno %d retval %d duration %d\n",
+		  err, errno, retval, duration))
+		goto cleanup;
+
+	CHECK(atomics_skel->data->or64_value != 0x111ull << 32, "or64_value",
+	      "64bit atomic or, bad value (got 0x%llx want 0x%llx)\n",
+	      atomics_skel->data->or64_value, 0x111ull << 32);
+	CHECK(atomics_skel->bss->or64_result != 0x110ull << 32, "or64_result",
+	      "64bit atomic or, bad result (got 0x%llx want 0x%llx)\n",
+	      atomics_skel->bss->or64_result, 0x110ull << 32);
+
+	CHECK(atomics_skel->data->or32_value != 0x111, "or32_value",
+	      "32bit atomic or, bad value (got 0x%x want 0x%x)\n",
+	      atomics_skel->data->or32_value, 0x111);
+	CHECK(atomics_skel->bss->or32_result != 0x110, "or32_result",
+	      "32bit atomic or, bad result (got 0x%x want 0x%x)\n",
+	      atomics_skel->bss->or32_result, 0x110);
+
+cleanup:
+	atomics_test__destroy(atomics_skel);
+}
+
+static void test_xor(void)
+{
+	struct atomics_test *atomics_skel = NULL;
+	int err, prog_fd;
+	__u32 duration = 0, retval;
+
+	atomics_skel = atomics_test__open_and_load();
+	if (CHECK(!atomics_skel, "atomics_skel_load", "atomics skeleton failed\n"))
+		goto cleanup;
+
+	err = atomics_test__attach(atomics_skel);
+	if (CHECK(err, "atomics_attach", "atomics attach failed: %d\n", err))
+		goto cleanup;
+
+	prog_fd = bpf_program__fd(atomics_skel->progs.xor);
+	err = bpf_prog_test_run(prog_fd, 1, NULL, 0,
+				NULL, NULL, &retval, &duration);
+	if (CHECK(err || retval, "test_run xor",
+		  "err %d errno %d retval %d duration %d\n",
+		  err, errno, retval, duration))
+		goto cleanup;
+
+	CHECK(atomics_skel->data->xor64_value != 0x101ull << 32, "xor64_value",
+	      "64bit atomic xor, bad value (got 0x%llx want 0x%llx)\n",
+	      atomics_skel->data->xor64_value, 0x101ull << 32);
+	CHECK(atomics_skel->bss->xor64_result != 0x110ull << 32, "xor64_result",
+	      "64bit atomic xor, bad result (got 0x%llx want 0x%llx)\n",
+	      atomics_skel->bss->xor64_result, 0x110ull << 32);
+
+	CHECK(atomics_skel->data->xor32_value != 0x101, "xor32_value",
+	      "32bit atomic xor, bad value (got 0x%x want 0x%x)\n",
+	      atomics_skel->data->xor32_value, 0x101);
+	CHECK(atomics_skel->bss->xor32_result != 0x110, "xor32_result",
+	      "32bit atomic xor, bad result (got 0x%x want 0x%x)\n",
+	      atomics_skel->bss->xor32_result, 0x110);
+
+cleanup:
+	atomics_test__destroy(atomics_skel);
+}
+
+static void test_cmpxchg(void)
+{
+	struct atomics_test *atomics_skel = NULL;
+	int err, prog_fd;
+	__u32 duration = 0, retval;
+
+	atomics_skel = atomics_test__open_and_load();
+	if (CHECK(!atomics_skel, "atomics_skel_load", "atomics skeleton failed\n"))
+		goto cleanup;
+
+	err = atomics_test__attach(atomics_skel);
+	if (CHECK(err, "atomics_attach", "atomics attach failed: %d\n", err))
+		goto cleanup;
+
+	prog_fd = bpf_program__fd(atomics_skel->progs.add);
+	err = bpf_prog_test_run(prog_fd, 1, NULL, 0,
+				NULL, NULL, &retval, &duration);
+	if (CHECK(err || retval, "test_run add",
+		  "err %d errno %d retval %d duration %d\n",
+		  err, errno, retval, duration))
+		goto cleanup;
+
+	CHECK(atomics_skel->data->cmpxchg64_value != 2, "cmpxchg64_value",
+	      "64bit cmpxchg left unexpected value (got %llx want 2)\n",
+	      atomics_skel->data->cmpxchg64_value);
+	CHECK(atomics_skel->bss->cmpxchg64_result_fail != 1, "cmpxchg_result_fail",
+	      "64bit cmpxchg returned bad result (got %llx want 1)\n",
+	      atomics_skel->bss->cmpxchg64_result_fail);
+	CHECK(atomics_skel->bss->cmpxchg64_result_succeed != 1, "cmpxchg_result_succeed",
+	      "64bit cmpxchg returned bad result (got %llx want 1)\n",
+	      atomics_skel->bss->cmpxchg64_result_succeed);
+
+	CHECK(atomics_skel->data->cmpxchg32_value != 2, "cmpxchg32_value",
+	      "32bit cmpxchg left unexpected value (got %d want 2)\n",
+	      atomics_skel->data->cmpxchg32_value);
+	CHECK(atomics_skel->bss->cmpxchg32_result_fail != 1, "cmpxchg_result_fail",
+	      "32bit cmpxchg returned bad result (got %d want 1)\n",
+	      atomics_skel->bss->cmpxchg32_result_fail);
+	CHECK(atomics_skel->bss->cmpxchg32_result_succeed != 1, "cmpxchg_result_succeed",
+	      "32bit cmpxchg returned bad result (got %d want 1)\n",
+	      atomics_skel->bss->cmpxchg32_result_succeed);
+
+cleanup:
+	atomics_test__destroy(atomics_skel);
+}
+
+static void test_xchg(void)
+{
+	struct atomics_test *atomics_skel = NULL;
+	int err, prog_fd;
+	__u32 duration = 0, retval;
+
+	atomics_skel = atomics_test__open_and_load();
+	if (CHECK(!atomics_skel, "atomics_skel_load", "atomics skeleton failed\n"))
+		goto cleanup;
+
+	err = atomics_test__attach(atomics_skel);
+	if (CHECK(err, "atomics_attach", "atomics attach failed: %d\n", err))
+		goto cleanup;
+
+	prog_fd = bpf_program__fd(atomics_skel->progs.add);
+	err = bpf_prog_test_run(prog_fd, 1, NULL, 0,
+				NULL, NULL, &retval, &duration);
+	if (CHECK(err || retval, "test_run add",
+		  "err %d errno %d retval %d duration %d\n",
+		  err, errno, retval, duration))
+		goto cleanup;
+
+	CHECK(atomics_skel->data->xchg64_value != 2, "xchg64_value",
+	      "64bit xchg left unexpected value (got %lld want 2)\n",
+	      atomics_skel->data->xchg64_value);
+	CHECK(atomics_skel->bss->xchg64_result != 1, "xchg_result",
+	      "64bit xchg returned bad result (got %lld want 1)\n",
+	      atomics_skel->bss->xchg64_result);
+
+	CHECK(atomics_skel->data->xchg32_value != 2, "xchg32_value",
+	      "32bit xchg left unexpected value (got %d want 2)\n",
+	      atomics_skel->data->xchg32_value);
+	CHECK(atomics_skel->bss->xchg32_result != 1, "xchg_result",
+	      "32bit xchg returned bad result (got %d want 1)\n",
+	      atomics_skel->bss->xchg32_result);
+
+cleanup:
+	atomics_test__destroy(atomics_skel);
+}
+
+void test_atomics_test(void)
+{
+	test_add();
+	test_sub();
+	test_and();
+	test_or();
+	test_xor();
+	test_cmpxchg();
+	test_xchg();
+}
+
+#else /* ENABLE_ATOMICS_TESTS */
+
+void test_atomics_test(void)
+{
+	printf("%s:SKIP:no ENABLE_ATOMICS_TEST (missing Clang BPF atomics support)",
+	       __func__);
+	test__skip();
+}
+
+#endif /* ENABLE_ATOMICS_TESTS */
diff --git a/tools/testing/selftests/bpf/progs/atomics_test.c b/tools/testing/selftests/bpf/progs/atomics_test.c
new file mode 100644
index 000000000000..3139b00937e5
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/atomics_test.c
@@ -0,0 +1,124 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+#ifdef ENABLE_ATOMICS_TESTS
+
+__u64 add64_value = 1;
+__u64 add64_result = 0;
+__u32 add32_value = 1;
+__u32 add32_result = 0;
+__u64 add_stack_value_copy = 0;
+__u64 add_stack_result = 0;
+SEC("fentry/bpf_fentry_test1")
+int BPF_PROG(add, int a)
+{
+	__u64 add_stack_value = 1;
+
+	add64_result = __sync_fetch_and_add(&add64_value, 2);
+	add32_result = __sync_fetch_and_add(&add32_value, 2);
+	add_stack_result = __sync_fetch_and_add(&add_stack_value, 2);
+	add_stack_value_copy = add_stack_value;
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
+SEC("fentry/bpf_fentry_test1")
+int BPF_PROG(sub, int a)
+{
+	__u64 sub_stack_value = 1;
+
+	sub64_result = __sync_fetch_and_sub(&sub64_value, 2);
+	sub32_result = __sync_fetch_and_sub(&sub32_value, 2);
+	sub_stack_result = __sync_fetch_and_sub(&sub_stack_value, 2);
+	sub_stack_value_copy = sub_stack_value;
+
+	return 0;
+}
+
+__u64 and64_value = (0x110ull << 32);
+__u64 and64_result = 0;
+__u32 and32_value = 0x110;
+__u32 and32_result = 0;
+SEC("fentry/bpf_fentry_test1")
+int BPF_PROG(and, int a)
+{
+
+	and64_result = __sync_fetch_and_and(&and64_value, 0x011ull << 32);
+	and32_result = __sync_fetch_and_and(&and32_value, 0x011);
+
+	return 0;
+}
+
+__u64 or64_value = (0x110ull << 32);
+__u64 or64_result = 0;
+__u32 or32_value = 0x110;
+__u32 or32_result = 0;
+SEC("fentry/bpf_fentry_test1")
+int BPF_PROG(or, int a)
+{
+	or64_result = __sync_fetch_and_or(&or64_value, 0x011ull << 32);
+	or32_result = __sync_fetch_and_or(&or32_value, 0x011);
+
+	return 0;
+}
+
+__u64 xor64_value = (0x110ull << 32);
+__u64 xor64_result = 0;
+__u32 xor32_value = 0x110;
+__u32 xor32_result = 0;
+SEC("fentry/bpf_fentry_test1")
+int BPF_PROG(xor, int a)
+{
+	xor64_result = __sync_fetch_and_xor(&xor64_value, 0x011ull << 32);
+	xor32_result = __sync_fetch_and_xor(&xor32_value, 0x011);
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
+SEC("fentry/bpf_fentry_test1")
+int BPF_PROG(cmpxchg, int a)
+{
+	cmpxchg64_result_fail = __sync_val_compare_and_swap(
+		&cmpxchg64_value, 0, 3);
+	cmpxchg64_result_succeed = __sync_val_compare_and_swap(
+		&cmpxchg64_value, 1, 2);
+
+	cmpxchg32_result_fail = __sync_val_compare_and_swap(
+		&cmpxchg32_value, 0, 3);
+	cmpxchg32_result_succeed = __sync_val_compare_and_swap(
+		&cmpxchg32_value, 1, 2);
+
+	return 0;
+}
+
+__u64 xchg64_value = 1;
+__u64 xchg64_result = 0;
+__u32 xchg32_value = 1;
+__u32 xchg32_result = 0;
+SEC("fentry/bpf_fentry_test1")
+int BPF_PROG(xchg, int a)
+{
+	__u64 val64 = 2;
+	__u32 val32 = 2;
+
+	__atomic_exchange(&xchg64_value, &val64, &xchg64_result, __ATOMIC_RELAXED);
+	__atomic_exchange(&xchg32_value, &val32, &xchg32_result, __ATOMIC_RELAXED);
+
+	return 0;
+}
+
+#endif /* ENABLE_ATOMICS_TESTS */
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
index 000000000000..eb43a06428fa
--- /dev/null
+++ b/tools/testing/selftests/bpf/verifier/atomic_cmpxchg.c
@@ -0,0 +1,96 @@
+{
+	"atomic compare-and-exchange smoketest - 64bit",
+	.insns = {
+	/* val = 3; */
+	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 3),
+	/* old = atomic_cmpxchg(&val, 2, 4); */
+	BPF_MOV64_IMM(BPF_REG_1, 4),
+	BPF_MOV64_IMM(BPF_REG_0, 2),
+	BPF_ATOMIC_CMPXCHG(BPF_DW, BPF_REG_10, BPF_REG_1, -8),
+	/* if (old != 3) exit(2); */
+	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 3, 2),
+	BPF_MOV64_IMM(BPF_REG_0, 2),
+	BPF_EXIT_INSN(),
+	/* if (val != 3) exit(3); */
+	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_10, -8),
+	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 3, 2),
+	BPF_MOV64_IMM(BPF_REG_0, 3),
+	BPF_EXIT_INSN(),
+	/* old = atomic_cmpxchg(&val, 3, 4); */
+	BPF_MOV64_IMM(BPF_REG_1, 4),
+	BPF_MOV64_IMM(BPF_REG_0, 3),
+	BPF_ATOMIC_CMPXCHG(BPF_DW, BPF_REG_10, BPF_REG_1, -8),
+	/* if (old != 3) exit(4); */
+	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 3, 2),
+	BPF_MOV64_IMM(BPF_REG_0, 4),
+	BPF_EXIT_INSN(),
+	/* if (val != 4) exit(5); */
+	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_10, -8),
+	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 4, 2),
+	BPF_MOV64_IMM(BPF_REG_0, 5),
+	BPF_EXIT_INSN(),
+	/* exit(0); */
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	},
+	.result = ACCEPT,
+},
+{
+	"atomic compare-and-exchange smoketest - 32bit",
+	.insns = {
+	/* val = 3; */
+	BPF_ST_MEM(BPF_W, BPF_REG_10, -4, 3),
+	/* old = atomic_cmpxchg(&val, 2, 4); */
+	BPF_MOV32_IMM(BPF_REG_1, 4),
+	BPF_MOV32_IMM(BPF_REG_0, 2),
+	BPF_ATOMIC_CMPXCHG(BPF_W, BPF_REG_10, BPF_REG_1, -4),
+	/* if (old != 3) exit(2); */
+	BPF_JMP32_IMM(BPF_JEQ, BPF_REG_0, 3, 2),
+	BPF_MOV32_IMM(BPF_REG_0, 2),
+	BPF_EXIT_INSN(),
+	/* if (val != 3) exit(3); */
+	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_10, -4),
+	BPF_JMP32_IMM(BPF_JEQ, BPF_REG_0, 3, 2),
+	BPF_MOV32_IMM(BPF_REG_0, 3),
+	BPF_EXIT_INSN(),
+	/* old = atomic_cmpxchg(&val, 3, 4); */
+	BPF_MOV32_IMM(BPF_REG_1, 4),
+	BPF_MOV32_IMM(BPF_REG_0, 3),
+	BPF_ATOMIC_CMPXCHG(BPF_W, BPF_REG_10, BPF_REG_1, -4),
+	/* if (old != 3) exit(4); */
+	BPF_JMP32_IMM(BPF_JEQ, BPF_REG_0, 3, 2),
+	BPF_MOV32_IMM(BPF_REG_0, 4),
+	BPF_EXIT_INSN(),
+	/* if (val != 4) exit(5); */
+	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_10, -4),
+	BPF_JMP32_IMM(BPF_JEQ, BPF_REG_0, 4, 2),
+	BPF_MOV32_IMM(BPF_REG_0, 5),
+	BPF_EXIT_INSN(),
+	/* exit(0); */
+	BPF_MOV32_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	},
+	.result = ACCEPT,
+},
+{
+	"Can't use cmpxchg on uninit src reg",
+	.insns = {
+	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 3),
+	BPF_MOV64_IMM(BPF_REG_0, 3),
+	BPF_ATOMIC_CMPXCHG(BPF_DW, BPF_REG_10, BPF_REG_2, -8),
+	BPF_EXIT_INSN(),
+	},
+	.result = REJECT,
+	.errstr = "!read_ok",
+},
+{
+	"Can't use cmpxchg on uninit memory",
+	.insns = {
+	BPF_MOV64_IMM(BPF_REG_0, 3),
+	BPF_MOV64_IMM(BPF_REG_2, 4),
+	BPF_ATOMIC_CMPXCHG(BPF_DW, BPF_REG_10, BPF_REG_2, -8),
+	BPF_EXIT_INSN(),
+	},
+	.result = REJECT,
+	.errstr = "invalid read from stack",
+},
diff --git a/tools/testing/selftests/bpf/verifier/atomic_fetch_add.c b/tools/testing/selftests/bpf/verifier/atomic_fetch_add.c
new file mode 100644
index 000000000000..c3236510cb64
--- /dev/null
+++ b/tools/testing/selftests/bpf/verifier/atomic_fetch_add.c
@@ -0,0 +1,106 @@
+{
+	"BPF_ATOMIC_FETCH_ADD smoketest - 64bit",
+	.insns = {
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	/* Write 3 to stack */
+	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 3),
+	/* Put a 1 in R1, add it to the 3 on the stack, and load the value back into R1 */
+	BPF_MOV64_IMM(BPF_REG_1, 1),
+	BPF_ATOMIC_FETCH_ADD(BPF_DW, BPF_REG_10, BPF_REG_1, -8),
+	/* Check the value we loaded back was 3 */
+	BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, 3, 2),
+	BPF_MOV64_IMM(BPF_REG_0, 1),
+	BPF_EXIT_INSN(),
+	/* Load value from stack */
+	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_10, -8),
+	/* Check value loaded from stack was 4 */
+	BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, 4, 1),
+	BPF_MOV64_IMM(BPF_REG_0, 2),
+	BPF_EXIT_INSN(),
+	},
+	.result = ACCEPT,
+},
+{
+	"BPF_ATOMIC_FETCH_ADD smoketest - 32bit",
+	.insns = {
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	/* Write 3 to stack */
+	BPF_ST_MEM(BPF_W, BPF_REG_10, -4, 3),
+	/* Put a 1 in R1, add it to the 3 on the stack, and load the value back into R1 */
+	BPF_MOV32_IMM(BPF_REG_1, 1),
+	BPF_ATOMIC_FETCH_ADD(BPF_W, BPF_REG_10, BPF_REG_1, -4),
+	/* Check the value we loaded back was 3 */
+	BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, 3, 2),
+	BPF_MOV64_IMM(BPF_REG_0, 1),
+	BPF_EXIT_INSN(),
+	/* Load value from stack */
+	BPF_LDX_MEM(BPF_W, BPF_REG_1, BPF_REG_10, -4),
+	/* Check value loaded from stack was 4 */
+	BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, 4, 1),
+	BPF_MOV64_IMM(BPF_REG_0, 2),
+	BPF_EXIT_INSN(),
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
diff --git a/tools/testing/selftests/bpf/verifier/atomic_sub.c b/tools/testing/selftests/bpf/verifier/atomic_sub.c
new file mode 100644
index 000000000000..8a198f8bc194
--- /dev/null
+++ b/tools/testing/selftests/bpf/verifier/atomic_sub.c
@@ -0,0 +1,44 @@
+{
+	"BPF_ATOMIC_SUB without fetch",
+	.insns = {
+		/* val = 100; */
+		BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 100),
+		/* atomic_sub(&val, 4); */
+		BPF_MOV64_IMM(BPF_REG_1, 4),
+		BPF_ATOMIC_SUB(BPF_DW, BPF_REG_10, BPF_REG_1, -8),
+		/* if (val != 96) exit(2); */
+		BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_10, -8),
+		BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 96, 2),
+		BPF_MOV64_IMM(BPF_REG_0, 2),
+		BPF_EXIT_INSN(),
+		/* r1 should not be clobbered, no BPF_FETCH flag */
+		BPF_MOV64_IMM(BPF_REG_0, 0),
+		BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, 4, 1),
+		BPF_MOV64_IMM(BPF_REG_0, 1),
+		BPF_EXIT_INSN(),
+	},
+	.result = ACCEPT,
+},
+{
+	"BPF_ATOMIC_SUB with fetch",
+	.insns = {
+		/* val = 100; */
+		BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 100),
+		/* old = atomic_fetch_sub(&val, 4); */
+		BPF_MOV64_IMM(BPF_REG_1, 4),
+		BPF_ATOMIC_FETCH_SUB(BPF_DW, BPF_REG_10, BPF_REG_1, -8),
+		/* if (old != 100) exit(3); */
+		BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, 100, 2),
+		BPF_MOV64_IMM(BPF_REG_0, 3),
+		BPF_EXIT_INSN(),
+		/* if (val != 96) exit(2); */
+		BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_10, -8),
+		BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 96, 2),
+		BPF_MOV64_IMM(BPF_REG_0, 2),
+		BPF_EXIT_INSN(),
+		/* exit(0); */
+		BPF_MOV64_IMM(BPF_REG_0, 0),
+		BPF_EXIT_INSN(),
+	},
+	.result = ACCEPT,
+},
diff --git a/tools/testing/selftests/bpf/verifier/atomic_xchg.c b/tools/testing/selftests/bpf/verifier/atomic_xchg.c
new file mode 100644
index 000000000000..6ab7b2bdc6b7
--- /dev/null
+++ b/tools/testing/selftests/bpf/verifier/atomic_xchg.c
@@ -0,0 +1,46 @@
+{
+	"atomic exchange smoketest - 64bit",
+	.insns = {
+	/* val = 3; */
+	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 3),
+	/* old = atomic_xchg(&val, 4); */
+	BPF_MOV64_IMM(BPF_REG_1, 4),
+	BPF_ATOMIC_XCHG(BPF_DW, BPF_REG_10, BPF_REG_1, -8),
+	/* if (old != 3) exit(1); */
+	BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, 3, 2),
+	BPF_MOV64_IMM(BPF_REG_0, 1),
+	BPF_EXIT_INSN(),
+	/* if (val != 4) exit(2); */
+	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_10, -8),
+	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 4, 2),
+	BPF_MOV64_IMM(BPF_REG_0, 2),
+	BPF_EXIT_INSN(),
+	/* exit(0); */
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	},
+	.result = ACCEPT,
+},
+{
+	"atomic exchange smoketest - 32bit",
+	.insns = {
+	/* val = 3; */
+	BPF_ST_MEM(BPF_W, BPF_REG_10, -4, 3),
+	/* old = atomic_xchg(&val, 4); */
+	BPF_MOV32_IMM(BPF_REG_1, 4),
+	BPF_ATOMIC_XCHG(BPF_W, BPF_REG_10, BPF_REG_1, -4),
+	/* if (old != 3) exit(1); */
+	BPF_JMP32_IMM(BPF_JEQ, BPF_REG_1, 3, 2),
+	BPF_MOV32_IMM(BPF_REG_0, 1),
+	BPF_EXIT_INSN(),
+	/* if (val != 4) exit(2); */
+	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_10, -4),
+	BPF_JMP32_IMM(BPF_JEQ, BPF_REG_0, 4, 2),
+	BPF_MOV32_IMM(BPF_REG_0, 2),
+	BPF_EXIT_INSN(),
+	/* exit(0); */
+	BPF_MOV32_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
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
diff --git a/tools/testing/selftests/bpf/verifier/ctx.c b/tools/testing/selftests/bpf/verifier/ctx.c
index a6d2d82b3447..ede3842d123b 100644
--- a/tools/testing/selftests/bpf/verifier/ctx.c
+++ b/tools/testing/selftests/bpf/verifier/ctx.c
@@ -13,7 +13,7 @@
 	"context stores via BPF_ATOMIC",
 	.insns = {
 	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_ATOMIC_ADD(BPF_W, BPF_REG_1, BPF_REG_0, offsetof(struct __sk_buff)),
+	BPF_ATOMIC_ADD(BPF_W, BPF_REG_1, BPF_REG_0, offsetof(struct __sk_buff, mark)),
 	BPF_EXIT_INSN(),
 	},
 	.errstr = "BPF_ATOMIC stores into R1 ctx is not allowed",
-- 
2.29.2.454.gaff20da3a2-goog

