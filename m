Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E2C84EFD72
	for <lists+bpf@lfdr.de>; Sat,  2 Apr 2022 02:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241698AbiDBAcB convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Fri, 1 Apr 2022 20:32:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240464AbiDBAcA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 1 Apr 2022 20:32:00 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4358D1A48A4
        for <bpf@vger.kernel.org>; Fri,  1 Apr 2022 17:30:08 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 2320C6Rr031421
        for <bpf@vger.kernel.org>; Fri, 1 Apr 2022 17:30:07 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3f5gpgamk9-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 01 Apr 2022 17:30:07 -0700
Received: from twshared5730.23.frc3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 1 Apr 2022 17:30:05 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id CE00615EB51B7; Fri,  1 Apr 2022 17:29:57 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>,
        Alan Maguire <alan.maguire@oracle.com>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Hengqi Chen <hengqi.chen@gmail.com>
Subject: [PATCH v2 bpf-next 6/7] selftests/bpf: add basic USDT selftests
Date:   Fri, 1 Apr 2022 17:29:43 -0700
Message-ID: <20220402002944.382019-7-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220402002944.382019-1-andrii@kernel.org>
References: <20220402002944.382019-1-andrii@kernel.org>
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: fUX6uC5cAkzwZfAsawzH3tl0dCz2qsG9
X-Proofpoint-GUID: fUX6uC5cAkzwZfAsawzH3tl0dCz2qsG9
Content-Transfer-Encoding: 8BIT
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-04-01_08,2022-03-31_01,2022-02-23_01
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add semaphore-based USDT to test_progs itself and write basic tests to
valicate both auto-attachment and manual attachment logic, as well as
BPF-side functionality.

Also add subtests to validate that libbpf properly deduplicates USDT
specs and handles spec overflow situations correctly, as well as proper
"rollback" of partially-attached multi-spec USDT.

BPF-side of selftest intentionally consists of two files to validate
that usdt.bpf.h header can be included from multiple source code files
that are subsequently linked into final BPF object file without causing
any symbol duplication or other issues. We are validating that __weak
maps and bpf_usdt_xxx() API functions defined in usdt.bpf.h do work as
intended.

USDT selftests use sys/sdt.h header provided by systemtap-sdt-devel, so
document that build-time dependency in Documentation/bpf/bpf_devel_QA.rst.

Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 Documentation/bpf/bpf_devel_QA.rst            |   3 +
 tools/testing/selftests/bpf/Makefile          |  14 +-
 tools/testing/selftests/bpf/prog_tests/usdt.c | 313 ++++++++++++++++++
 tools/testing/selftests/bpf/progs/test_usdt.c |  96 ++++++
 .../selftests/bpf/progs/test_usdt_multispec.c |  34 ++
 5 files changed, 454 insertions(+), 6 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/usdt.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_usdt.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_usdt_multispec.c

diff --git a/Documentation/bpf/bpf_devel_QA.rst b/Documentation/bpf/bpf_devel_QA.rst
index 761474bd7fe6..8eb04076c3a3 100644
--- a/Documentation/bpf/bpf_devel_QA.rst
+++ b/Documentation/bpf/bpf_devel_QA.rst
@@ -465,6 +465,9 @@ https://fedorapeople.org/~acme/dwarves
 Some distros have pahole version 1.16 packaged already, e.g.
 Fedora, Gentoo.
 
+Some selftests rely on sys/sdt.h header defining USDT-related macros. You can
+get them by installing systemtap-sdt-devel package.
+
 Q: Which BPF kernel selftests version should I run my kernel against?
 ---------------------------------------------------------------------
 A: If you run a kernel ``xyz``, then always run the BPF kernel selftests
diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 3820608faf57..0f8c55dfd844 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -328,12 +328,8 @@ SKEL_BLACKLIST := btf__% test_pinning_invalid.c test_sk_assign.c
 
 LINKED_SKELS := test_static_linked.skel.h linked_funcs.skel.h		\
 		linked_vars.skel.h linked_maps.skel.h 			\
-		test_subskeleton.skel.h test_subskeleton_lib.skel.h
-
-# In the subskeleton case, we want the test_subskeleton_lib.subskel.h file
-# but that's created as a side-effect of the skel.h generation.
-test_subskeleton.skel.h-deps := test_subskeleton_lib2.o test_subskeleton_lib.o test_subskeleton.o
-test_subskeleton_lib.skel.h-deps := test_subskeleton_lib2.o test_subskeleton_lib.o
+		test_subskeleton.skel.h test_subskeleton_lib.skel.h	\
+		test_usdt.skel.h
 
 LSKELS := kfunc_call_test.c fentry_test.c fexit_test.c fexit_sleep.c \
 	test_ringbuf.c atomics.c trace_printk.c trace_vprintk.c \
@@ -346,6 +342,11 @@ test_static_linked.skel.h-deps := test_static_linked1.o test_static_linked2.o
 linked_funcs.skel.h-deps := linked_funcs1.o linked_funcs2.o
 linked_vars.skel.h-deps := linked_vars1.o linked_vars2.o
 linked_maps.skel.h-deps := linked_maps1.o linked_maps2.o
+# In the subskeleton case, we want the test_subskeleton_lib.subskel.h file
+# but that's created as a side-effect of the skel.h generation.
+test_subskeleton.skel.h-deps := test_subskeleton_lib2.o test_subskeleton_lib.o test_subskeleton.o
+test_subskeleton_lib.skel.h-deps := test_subskeleton_lib2.o test_subskeleton_lib.o
+test_usdt.skel.h-deps := test_usdt.o test_usdt_multispec.o
 
 LINKED_BPF_SRCS := $(patsubst %.o,%.c,$(foreach skel,$(LINKED_SKELS),$($(skel)-deps)))
 
@@ -400,6 +401,7 @@ $(TRUNNER_BPF_OBJS): $(TRUNNER_OUTPUT)/%.o:				\
 		     $(TRUNNER_BPF_PROGS_DIR)/*.h			\
 		     $$(INCLUDE_DIR)/vmlinux.h				\
 		     $(wildcard $(BPFDIR)/bpf_*.h)			\
+		     $(wildcard $(BPFDIR)/*.bpf.h)			\
 		     | $(TRUNNER_OUTPUT) $$(BPFOBJ)
 	$$(call $(TRUNNER_BPF_BUILD_RULE),$$<,$$@,			\
 					  $(TRUNNER_BPF_CFLAGS))
diff --git a/tools/testing/selftests/bpf/prog_tests/usdt.c b/tools/testing/selftests/bpf/prog_tests/usdt.c
new file mode 100644
index 000000000000..d5a3125d4a4d
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/usdt.c
@@ -0,0 +1,313 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2022 Meta Platforms, Inc. and affiliates. */
+#include <test_progs.h>
+
+#define _SDT_HAS_SEMAPHORES 1
+#include <sys/sdt.h>
+
+#include "test_usdt.skel.h"
+
+int lets_test_this(int);
+
+static volatile int idx = 2;
+static volatile __u64 bla = 0xFEDCBA9876543210ULL;
+static volatile short nums[] = {-1, -2, -3, };
+
+static volatile struct {
+	int x;
+	signed char y;
+} t1 = { 1, -127 };
+
+#define SEC(name) __attribute__((section(name), used))
+
+unsigned short test_usdt0_semaphore SEC(".probes");
+unsigned short test_usdt3_semaphore SEC(".probes");
+unsigned short test_usdt12_semaphore SEC(".probes");
+
+static void __always_inline trigger_func(int x) {
+	long y = 42;
+
+	if (test_usdt0_semaphore)
+		STAP_PROBE(test, usdt0);
+	if (test_usdt3_semaphore)
+		STAP_PROBE3(test, usdt3, x, y, &bla);
+	if (test_usdt12_semaphore) {
+		STAP_PROBE12(test, usdt12,
+			     x, x + 1, y, x + y, 5,
+			     y / 7, bla, &bla, -9, nums[x],
+			     nums[idx], t1.y);
+	}
+}
+
+static void subtest_basic_usdt(void)
+{
+	LIBBPF_OPTS(bpf_usdt_opts, opts);
+	struct test_usdt *skel;
+	struct test_usdt__bss *bss;
+	int err;
+
+	skel = test_usdt__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_open"))
+		return;
+
+	bss = skel->bss;
+	bss->my_pid = getpid();
+
+	err = test_usdt__attach(skel);
+	if (!ASSERT_OK(err, "skel_attach"))
+		goto cleanup;
+
+	/* usdt0 won't be auto-attached */
+	opts.usdt_cookie = 0xcafedeadbeeffeed;
+	skel->links.usdt0 = bpf_program__attach_usdt(skel->progs.usdt0,
+						     0 /*self*/, "/proc/self/exe",
+						     "test", "usdt0", &opts);
+	if (!ASSERT_OK_PTR(skel->links.usdt0, "usdt0_link"))
+		goto cleanup;
+
+	trigger_func(1);
+
+	ASSERT_EQ(bss->usdt0_called, 1, "usdt0_called");
+	ASSERT_EQ(bss->usdt3_called, 1, "usdt3_called");
+	ASSERT_EQ(bss->usdt12_called, 1, "usdt12_called");
+
+	ASSERT_EQ(bss->usdt0_cookie, 0xcafedeadbeeffeed, "usdt0_cookie");
+	ASSERT_EQ(bss->usdt0_arg_cnt, 0, "usdt0_arg_cnt");
+	ASSERT_EQ(bss->usdt0_arg_ret, -ENOENT, "usdt0_arg_ret");
+
+	/* auto-attached usdt3 gets default zero cookie value */
+	ASSERT_EQ(bss->usdt3_cookie, 0, "usdt3_cookie");
+	ASSERT_EQ(bss->usdt3_arg_cnt, 3, "usdt3_arg_cnt");
+
+	ASSERT_EQ(bss->usdt3_arg_rets[0], 0, "usdt3_arg1_ret");
+	ASSERT_EQ(bss->usdt3_arg_rets[1], 0, "usdt3_arg2_ret");
+	ASSERT_EQ(bss->usdt3_arg_rets[2], 0, "usdt3_arg3_ret");
+	ASSERT_EQ(bss->usdt3_args[0], 1, "usdt3_arg1");
+	ASSERT_EQ(bss->usdt3_args[1], 42, "usdt3_arg2");
+	ASSERT_EQ(bss->usdt3_args[2], (uintptr_t)&bla, "usdt3_arg3");
+
+	/* auto-attached usdt12 gets default zero cookie value */
+	ASSERT_EQ(bss->usdt12_cookie, 0, "usdt12_cookie");
+	ASSERT_EQ(bss->usdt12_arg_cnt, 12, "usdt12_arg_cnt");
+
+	ASSERT_EQ(bss->usdt12_args[0], 1, "usdt12_arg1");
+	ASSERT_EQ(bss->usdt12_args[1], 1 + 1, "usdt12_arg2");
+	ASSERT_EQ(bss->usdt12_args[2], 42, "usdt12_arg3");
+	ASSERT_EQ(bss->usdt12_args[3], 42 + 1, "usdt12_arg4");
+	ASSERT_EQ(bss->usdt12_args[4], 5, "usdt12_arg5");
+	ASSERT_EQ(bss->usdt12_args[5], 42 / 7, "usdt12_arg6");
+	ASSERT_EQ(bss->usdt12_args[6], bla, "usdt12_arg7");
+	ASSERT_EQ(bss->usdt12_args[7], (uintptr_t)&bla, "usdt12_arg8");
+	ASSERT_EQ(bss->usdt12_args[8], -9, "usdt12_arg9");
+	ASSERT_EQ(bss->usdt12_args[9], nums[1], "usdt12_arg10");
+	ASSERT_EQ(bss->usdt12_args[10], nums[idx], "usdt12_arg11");
+	ASSERT_EQ(bss->usdt12_args[11], t1.y, "usdt12_arg12");
+
+	/* trigger_func() is marked __always_inline, so USDT invocations will be
+	 * inlined in two different places, meaning that each USDT will have
+	 * at least 2 different places to be attached to. This verifies that
+	 * bpf_program__attach_usdt() handles this properly and attaches to
+	 * all possible places of USDT invocation.
+	 */
+	trigger_func(2);
+
+	ASSERT_EQ(bss->usdt0_called, 2, "usdt0_called");
+	ASSERT_EQ(bss->usdt3_called, 2, "usdt3_called");
+	ASSERT_EQ(bss->usdt12_called, 2, "usdt12_called");
+
+	/* only check values that depend on trigger_func()'s input value */
+	ASSERT_EQ(bss->usdt3_args[0], 2, "usdt3_arg1");
+
+	ASSERT_EQ(bss->usdt12_args[0], 2, "usdt12_arg1");
+	ASSERT_EQ(bss->usdt12_args[1], 2 + 1, "usdt12_arg2");
+	ASSERT_EQ(bss->usdt12_args[3], 42 + 2, "usdt12_arg4");
+	ASSERT_EQ(bss->usdt12_args[9], nums[2], "usdt12_arg10");
+
+	/* detach and re-attach usdt3 */
+	bpf_link__destroy(skel->links.usdt3);
+
+	opts.usdt_cookie = 0xBADC00C51E;
+	skel->links.usdt3 = bpf_program__attach_usdt(skel->progs.usdt3, -1 /* any pid */,
+						     "/proc/self/exe", "test", "usdt3", &opts);
+	if (!ASSERT_OK_PTR(skel->links.usdt3, "usdt3_reattach"))
+		goto cleanup;
+
+	trigger_func(3);
+
+	ASSERT_EQ(bss->usdt3_called, 3, "usdt3_called");
+	/* this time usdt3 has custom cookie */
+	ASSERT_EQ(bss->usdt3_cookie, 0xBADC00C51E, "usdt3_cookie");
+	ASSERT_EQ(bss->usdt3_arg_cnt, 3, "usdt3_arg_cnt");
+
+	ASSERT_EQ(bss->usdt3_arg_rets[0], 0, "usdt3_arg1_ret");
+	ASSERT_EQ(bss->usdt3_arg_rets[1], 0, "usdt3_arg2_ret");
+	ASSERT_EQ(bss->usdt3_arg_rets[2], 0, "usdt3_arg3_ret");
+	ASSERT_EQ(bss->usdt3_args[0], 3, "usdt3_arg1");
+	ASSERT_EQ(bss->usdt3_args[1], 42, "usdt3_arg2");
+	ASSERT_EQ(bss->usdt3_args[2], (uintptr_t)&bla, "usdt3_arg3");
+
+cleanup:
+	test_usdt__destroy(skel);
+}
+
+unsigned short test_usdt_100_semaphore SEC(".probes");
+unsigned short test_usdt_300_semaphore SEC(".probes");
+unsigned short test_usdt_400_semaphore SEC(".probes");
+
+#define R10(F, X)  F(X+0); F(X+1);F(X+2); F(X+3); F(X+4); \
+		   F(X+5); F(X+6); F(X+7); F(X+8); F(X+9);
+#define R100(F, X) R10(F,X+ 0);R10(F,X+10);R10(F,X+20);R10(F,X+30);R10(F,X+40); \
+		   R10(F,X+50);R10(F,X+60);R10(F,X+70);R10(F,X+80);R10(F,X+90);
+
+/* carefully control that we get exactly 100 inlines by preventing inlining */
+static void __always_inline f100(int x)
+{
+	STAP_PROBE1(test, usdt_100, x);
+}
+
+__weak void trigger_100_usdts(void)
+{
+	R100(f100, 0);
+}
+
+/* we shouldn't be able to attach to test:usdt2_300 USDT as we don't have as
+ * many slots for specs. It's important that each STAP_PROBE2() invocation
+ * (after untolling) gets different arg spec due to compiler inlining i as
+ * a constant
+ */
+static void __always_inline f300(int x)
+{
+	STAP_PROBE1(test, usdt_300, x);
+}
+
+__weak void trigger_300_usdts(void)
+{
+	R100(f300, 0);
+	R100(f300, 100);
+	R100(f300, 200);
+}
+
+static void __always_inline f400(int x __attribute__((unused)))
+{
+	static int y;
+
+	STAP_PROBE1(test, usdt_400, y++);
+}
+
+/* this time we have 400 different USDT call sites, but they have uniform
+ * argument location, so libbpf's spec string deduplication logic should keep
+ * spec count use very small and so we should be able to attach to all 400
+ * call sites
+ */
+__weak void trigger_400_usdts(void)
+{
+	R100(f400, 0);
+	R100(f400, 100);
+	R100(f400, 200);
+	R100(f400, 300);
+}
+
+static void subtest_multispec_usdt(void)
+{
+	LIBBPF_OPTS(bpf_usdt_opts, opts);
+	struct test_usdt *skel;
+	struct test_usdt__bss *bss;
+	int err, i;
+
+	skel = test_usdt__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_open"))
+		return;
+
+	bss = skel->bss;
+	bss->my_pid = getpid();
+
+	err = test_usdt__attach(skel);
+	if (!ASSERT_OK(err, "skel_attach"))
+		goto cleanup;
+
+	/* usdt_100 is auto-attached and there are 100 inlined call sites,
+	 * let's validate that all of them are properly attached to and
+	 * handled from BPF side
+	 */
+	trigger_100_usdts();
+
+	ASSERT_EQ(bss->usdt_100_called, 100, "usdt_100_called");
+	ASSERT_EQ(bss->usdt_100_sum, 99 * 100 / 2, "usdt_100_sum");
+
+	/* Stress test free spec ID tracking. By default libbpf allows up to
+	 * 256 specs to be used, so if we don't return free spec IDs back
+	 * after few detachments and re-attachments we should run out of
+	 * available spec IDs.
+	 */
+	for (i = 0; i < 2; i++) {
+		bpf_link__destroy(skel->links.usdt_100);
+
+		skel->links.usdt_100 = bpf_program__attach_usdt(skel->progs.usdt_100, -1,
+							        "/proc/self/exe",
+								"test", "usdt_100", NULL);
+		if (!ASSERT_OK_PTR(skel->links.usdt_100, "usdt_100_reattach"))
+			goto cleanup;
+
+		bss->usdt_100_sum = 0;
+		trigger_100_usdts();
+
+		ASSERT_EQ(bss->usdt_100_called, (i + 1) * 100 + 100, "usdt_100_called");
+		ASSERT_EQ(bss->usdt_100_sum, 99 * 100 / 2, "usdt_100_sum");
+	}
+
+	/* Now let's step it up and try to attach USDT that requires more than
+	 * 256 attach points with different specs for each.
+	 * Note that we need trigger_300_usdts() only to actually have 300
+	 * USDT call sites, we are not going to actually trace them.
+	 */
+	trigger_300_usdts();
+
+	/* we'll reuse usdt_100 BPF program for usdt_300 test */
+	bpf_link__destroy(skel->links.usdt_100);
+	skel->links.usdt_100 = bpf_program__attach_usdt(skel->progs.usdt_100, -1, "/proc/self/exe",
+							"test", "usdt_300", NULL);
+	err = -errno;
+	if (!ASSERT_ERR_PTR(skel->links.usdt_100, "usdt_300_bad_attach"))
+		goto cleanup;
+	ASSERT_EQ(err, -E2BIG, "usdt_300_attach_err");
+
+	/* let's check that there are no "dangling" BPF programs attached due
+	 * to partial success of the above test:usdt_300 attachment
+	 */
+	bss->usdt_100_called = 0;
+	bss->usdt_100_sum = 0;
+
+	f300(777); /* this is 301st instance of usdt_300 */
+
+	ASSERT_EQ(bss->usdt_100_called, 0, "usdt_301_called");
+	ASSERT_EQ(bss->usdt_100_sum, 0, "usdt_301_sum");
+
+	/* This time we have USDT with 400 inlined invocations, but arg specs
+	 * should be the same across all sites, so libbpf will only need to
+	 * use one spec and thus we'll be able to attach 400 uprobes
+	 * successfully.
+	 *
+	 * Again, we are reusing usdt_100 BPF program.
+	 */
+	skel->links.usdt_100 = bpf_program__attach_usdt(skel->progs.usdt_100, -1,
+							"/proc/self/exe",
+							"test", "usdt_400", NULL);
+	if (!ASSERT_OK_PTR(skel->links.usdt_100, "usdt_400_attach"))
+		goto cleanup;
+
+	trigger_400_usdts();
+
+	ASSERT_EQ(bss->usdt_100_called, 400, "usdt_400_called");
+	ASSERT_EQ(bss->usdt_100_sum, 399 * 400 / 2, "usdt_400_sum");
+
+cleanup:
+	test_usdt__destroy(skel);
+}
+
+void test_usdt(void)
+{
+	if (test__start_subtest("basic"))
+		subtest_basic_usdt();
+	if (test__start_subtest("multispec"))
+		subtest_multispec_usdt();
+}
diff --git a/tools/testing/selftests/bpf/progs/test_usdt.c b/tools/testing/selftests/bpf/progs/test_usdt.c
new file mode 100644
index 000000000000..505aab9a5234
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_usdt.c
@@ -0,0 +1,96 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2022 Meta Platforms, Inc. and affiliates. */
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/usdt.bpf.h>
+
+int my_pid;
+
+int usdt0_called;
+u64 usdt0_cookie;
+int usdt0_arg_cnt;
+int usdt0_arg_ret;
+
+SEC("usdt")
+int usdt0(struct pt_regs *ctx)
+{
+	long tmp;
+
+	if (my_pid != (bpf_get_current_pid_tgid() >> 32))
+		return 0;
+
+	__sync_fetch_and_add(&usdt0_called, 1);
+
+	usdt0_cookie = bpf_usdt_cookie(ctx);
+	usdt0_arg_cnt = bpf_usdt_arg_cnt(ctx);
+	/* should return -ENOENT for any arg_num */
+	usdt0_arg_ret = bpf_usdt_arg(ctx, bpf_get_prandom_u32(), &tmp);
+	return 0;
+}
+
+int usdt3_called;
+u64 usdt3_cookie;
+int usdt3_arg_cnt;
+int usdt3_arg_rets[3];
+u64 usdt3_args[3];
+
+SEC("usdt//proc/self/exe:test:usdt3")
+int usdt3(struct pt_regs *ctx)
+{
+	long tmp;
+
+	if (my_pid != (bpf_get_current_pid_tgid() >> 32))
+		return 0;
+
+	__sync_fetch_and_add(&usdt3_called, 1);
+
+	usdt3_cookie = bpf_usdt_cookie(ctx);
+	usdt3_arg_cnt = bpf_usdt_arg_cnt(ctx);
+
+	usdt3_arg_rets[0] = bpf_usdt_arg(ctx, 0, &tmp);
+	usdt3_args[0] = (int)tmp;
+
+	usdt3_arg_rets[1] = bpf_usdt_arg(ctx, 1, &tmp);
+	usdt3_args[1] = (long)tmp;
+
+	usdt3_arg_rets[2] = bpf_usdt_arg(ctx, 2, &tmp);
+	usdt3_args[2] = (uintptr_t)tmp;
+
+	return 0;
+}
+
+int usdt12_called;
+u64 usdt12_cookie;
+int usdt12_arg_cnt;
+u64 usdt12_args[12];
+
+SEC("usdt//proc/self/exe:test:usdt12")
+int BPF_USDT(usdt12, int a1, int a2, long a3, long a4, unsigned a5,
+		     long a6, __u64 a7, uintptr_t a8, int a9, short a10,
+		     short a11, signed char a12)
+{
+	if (my_pid != (bpf_get_current_pid_tgid() >> 32))
+		return 0;
+
+	__sync_fetch_and_add(&usdt12_called, 1);
+
+	usdt12_cookie = bpf_usdt_cookie(ctx);
+	usdt12_arg_cnt = bpf_usdt_arg_cnt(ctx);
+
+	usdt12_args[0] = a1;
+	usdt12_args[1] = a2;
+	usdt12_args[2] = a3;
+	usdt12_args[3] = a4;
+	usdt12_args[4] = a5;
+	usdt12_args[5] = a6;
+	usdt12_args[6] = a7;
+	usdt12_args[7] = a8;
+	usdt12_args[8] = a9;
+	usdt12_args[9] = a10;
+	usdt12_args[10] = a11;
+	usdt12_args[11] = a12;
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/test_usdt_multispec.c b/tools/testing/selftests/bpf/progs/test_usdt_multispec.c
new file mode 100644
index 000000000000..96fe128790d1
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_usdt_multispec.c
@@ -0,0 +1,34 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2022 Meta Platforms, Inc. and affiliates. */
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/usdt.bpf.h>
+
+/* this file is linked together with test_usdt.c to validate that ust.bpf.h
+ * can be included in multiple .bpf.c files forming single final BPF object
+ * file
+ */
+
+extern int my_pid;
+
+int usdt_100_called;
+int usdt_100_sum;
+
+SEC("usdt//proc/self/exe:test:usdt_100")
+int BPF_USDT(usdt_100, int x)
+{
+	long tmp;
+
+	if (my_pid != (bpf_get_current_pid_tgid() >> 32))
+		return 0;
+
+	__sync_fetch_and_add(&usdt_100_called, 1);
+	__sync_fetch_and_add(&usdt_100_sum, x);
+
+	bpf_printk("X is %d, sum is %d", x, usdt_100_sum);
+
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.30.2

