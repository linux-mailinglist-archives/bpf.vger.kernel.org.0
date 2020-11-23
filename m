Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C7D92C1204
	for <lists+bpf@lfdr.de>; Mon, 23 Nov 2020 18:35:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390141AbgKWRcd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 23 Nov 2020 12:32:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387745AbgKWRcd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 23 Nov 2020 12:32:33 -0500
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6589C0613CF
        for <bpf@vger.kernel.org>; Mon, 23 Nov 2020 09:32:32 -0800 (PST)
Received: by mail-wm1-x349.google.com with SMTP id g125so1797378wme.9
        for <bpf@vger.kernel.org>; Mon, 23 Nov 2020 09:32:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=vhVTbQKxrG5vExJohgqApPX+87c2MLFuctJ+rqlbNdo=;
        b=HX8AeDwyOTQoIjh7VHsTIbALzeYm1VxT9yIQB5s5/9va84ZNUP0TXBYr1BHgmErJWv
         PC63drnFf42qCtPG7KeTu5+oi/rtcwMNICso0Lqtvh+aYPz4mggO05jiP3i7zj3q+jti
         hvc9G3lcJld9KiSGD1hyO/OJgeRNgxJjJsRK47y76rK37QkSa8+hPXqCrWmhBxtcuatJ
         Qji7EIzfRYltjR+tbERishIwgoZ2gpUU0ILRfFREzVCfgBk3OXzfYu64rRWLDHUWAc+4
         Gvd2yfkyrAevP20auy2vqgf/lQzQzKoi9ot4BXiF4OPKaHLzADn4FBXOaSbC32O2101D
         U7LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=vhVTbQKxrG5vExJohgqApPX+87c2MLFuctJ+rqlbNdo=;
        b=hVFaytMCdStNTqVbv9yb1BfOSkuUSLElezkOyAqJmQI4wx3qMxR6/+Eyz4etr7Q0bB
         tyEuI/uWEmDkZRghbmdadM2YHUb/CkBdpoE5jmFiS5A+P4VdDkCgY7WyQQ1fY0ZFgJE6
         6Cz9piaKknnWvdilO/CJg6aPto6ui1A4DuQUmyFgcCm0NE58ghPuGX+/BYejpPJcpUvd
         wmtWrtSJF2oS6zbH53xr97VD7FBt65k5geHkEjeyXSOPyRx1k1oRID6pBozMNQrTjHQJ
         Y+xy6mkdIVnVWVLBm+Erx/TKW+dmTWe5wqLgJsbFOhrp3savmh0KjTDBoRbU2yypBR4o
         FYLQ==
X-Gm-Message-State: AOAM533VL8J8FKOJ7RJ4+IrEZgO3HbjJmMocYKwbwvHy/R3EexV55wQm
        rDC7ZeleZchjQTufpnrr+k5MRbV1BZn4IG/5J/+uylSjbCSR5SBJ3u6Ti4LQSztX/Jt5BN2i5/S
        AiNhqj+UtqSXuJOAqyRNNdMwP9afbD6laAlN4lPRXWr1G4SPRrflQM6s4RfKdhRg=
X-Google-Smtp-Source: ABdhPJwET9CWuDpimAkpSuewUoOwbROFzjSOrScKheIxCOPOcDTXoUxS6O6gTfC4B7T5aRfNhHwRI1jChIxleQ==
Sender: "jackmanb via sendgmr" <jackmanb@beeg.c.googlers.com>
X-Received: from beeg.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:11db])
 (user=jackmanb job=sendgmr) by 2002:adf:f102:: with SMTP id
 r2mr739238wro.315.1606152751481; Mon, 23 Nov 2020 09:32:31 -0800 (PST)
Date:   Mon, 23 Nov 2020 17:32:02 +0000
In-Reply-To: <20201123173202.1335708-1-jackmanb@google.com>
Message-Id: <20201123173202.1335708-8-jackmanb@google.com>
Mime-Version: 1.0
References: <20201123173202.1335708-1-jackmanb@google.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH 7/7] bpf: Add tests for new BPF atomic operations
From:   Brendan Jackman <jackmanb@google.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>, Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This relies on the work done by Yonghong Song in
https://reviews.llvm.org/D72184

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 tools/testing/selftests/bpf/Makefile          |   2 +-
 .../selftests/bpf/prog_tests/atomics_test.c   | 145 ++++++++++++++++++
 .../selftests/bpf/progs/atomics_test.c        |  61 ++++++++
 .../selftests/bpf/verifier/atomic_cmpxchg.c   |  96 ++++++++++++
 .../selftests/bpf/verifier/atomic_fetch_add.c | 106 +++++++++++++
 .../selftests/bpf/verifier/atomic_xchg.c      | 113 ++++++++++++++
 6 files changed, 522 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/atomics_test.c
 create mode 100644 tools/testing/selftests/bpf/progs/atomics_test.c
 create mode 100644 tools/testing/selftests/bpf/verifier/atomic_cmpxchg.c
 create mode 100644 tools/testing/selftests/bpf/verifier/atomic_fetch_add.c
 create mode 100644 tools/testing/selftests/bpf/verifier/atomic_xchg.c

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 3d5940cd110d..4e28640ca2d8 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -250,7 +250,7 @@ define CLANG_BPF_BUILD_RULE
 	$(call msg,CLNG-LLC,$(TRUNNER_BINARY),$2)
 	$(Q)($(CLANG) $3 -O2 -target bpf -emit-llvm			\
 		-c $1 -o - || echo "BPF obj compilation failed") | 	\
-	$(LLC) -mattr=dwarfris -march=bpf -mcpu=v3 $4 -filetype=obj -o $2
+	$(LLC) -mattr=dwarfris -march=bpf -mcpu=v4 $4 -filetype=obj -o $2
 endef
 # Similar to CLANG_BPF_BUILD_RULE, but with disabled alu32
 define CLANG_NOALU32_BPF_BUILD_RULE
diff --git a/tools/testing/selftests/bpf/prog_tests/atomics_test.c b/tools/testing/selftests/bpf/prog_tests/atomics_test.c
new file mode 100644
index 000000000000..a4859d88fc11
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/atomics_test.c
@@ -0,0 +1,145 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <test_progs.h>
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
+	      "_stackbit atomic add value was not incremented (got %lld want 2)\n",
+	      atomics_skel->bss->add_stack_value_copy);
+	CHECK(atomics_skel->bss->add_stack_result != 1, "add_stack_result",
+	      "_stackbit atomic add bad return value (got %lld want 1)\n",
+	      atomics_skel->bss->add_stack_result);
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
+	      "64bit cmpxchg left unexpected value (got %lld want 2)\n",
+	      atomics_skel->data->cmpxchg64_value);
+	CHECK(atomics_skel->bss->cmpxchg64_result_fail != 1, "cmpxchg_result_fail",
+	      "64bit cmpxchg returned bad result (got %lld want 1)\n",
+	      atomics_skel->bss->cmpxchg64_result_fail);
+	CHECK(atomics_skel->bss->cmpxchg64_result_succeed != 1, "cmpxchg_result_succeed",
+	      "64bit cmpxchg returned bad result (got %lld want 1)\n",
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
+	test_cmpxchg();
+	test_xchg();
+}
diff --git a/tools/testing/selftests/bpf/progs/atomics_test.c b/tools/testing/selftests/bpf/progs/atomics_test.c
new file mode 100644
index 000000000000..d81f45eb6c45
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/atomics_test.c
@@ -0,0 +1,61 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+__u64 add64_value = 1;
+__u64 add64_result;
+__u32 add32_value = 1;
+__u32 add32_result;
+__u64 add_stack_value_copy;
+__u64 add_stack_result;
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
+__u64 cmpxchg64_value = 1;
+__u64 cmpxchg64_result_fail;
+__u64 cmpxchg64_result_succeed;
+__u32 cmpxchg32_value = 1;
+__u32 cmpxchg32_result_fail;
+__u32 cmpxchg32_result_succeed;
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
+__u64 xchg64_result;
+__u32 xchg32_value = 1;
+__u32 xchg32_result;
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
diff --git a/tools/testing/selftests/bpf/verifier/atomic_xchg.c b/tools/testing/selftests/bpf/verifier/atomic_xchg.c
new file mode 100644
index 000000000000..b39d8c0dabf9
--- /dev/null
+++ b/tools/testing/selftests/bpf/verifier/atomic_xchg.c
@@ -0,0 +1,113 @@
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
+{
+	"atomic set smoketest - 64bit",
+	.insns = {
+	/* val = 3; */
+	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 3),
+	/* atomic_xchg(&val, 4); */
+	BPF_MOV64_IMM(BPF_REG_1, 4),
+	BPF_ATOMIC_SET(BPF_DW, BPF_REG_10, BPF_REG_1, -8),
+	/* r1 should not be clobbered, no BPF_FETCH flag */
+	BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, 4, 2),
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
+	"atomic set smoketest - 32bit",
+	.insns = {
+	/* val = 3; */
+	BPF_ST_MEM(BPF_W, BPF_REG_10, -4, 3),
+	/* atomic_xchg(&val, 4); */
+	BPF_MOV32_IMM(BPF_REG_1, 4),
+	BPF_ATOMIC_SET(BPF_W, BPF_REG_10, BPF_REG_1, -4),
+	/* r1 should not be clobbered, no BPF_FETCH flag */
+	BPF_JMP32_IMM(BPF_JEQ, BPF_REG_1, 4, 2),
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
+{
+	"Can't use atomic set on kernel memory",
+	.insns = {
+	/* This is an fentry prog, context is array of the args of the
+	 * kernel function being called. Load first arg into R2.
+	 */
+	BPF_LDX_MEM(BPF_DW, BPF_REG_2, BPF_REG_1, 0),
+	/* First arg of bpf_fentry_test7 is a pointer to a struct.
+	 * Attempt to modify that struct. Verifier shouldn't let us
+	 * because it's kernel memory.
+	 */
+	BPF_MOV64_IMM(BPF_REG_3, 1),
+	BPF_ATOMIC_SET(BPF_DW, BPF_REG_2, BPF_REG_3, 0),
+	BPF_EXIT_INSN(),
+	},
+	.prog_type = BPF_PROG_TYPE_TRACING,
+	.expected_attach_type = BPF_TRACE_FENTRY,
+	.kfunc = "bpf_fentry_test7",
+	.result = REJECT,
+	.errstr = "only read is supported",
+},
-- 
2.29.2.454.gaff20da3a2-goog

