Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68FE34F218A
	for <lists+bpf@lfdr.de>; Tue,  5 Apr 2022 06:09:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbiDEC5L convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Mon, 4 Apr 2022 22:57:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231225AbiDEC4Y (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 4 Apr 2022 22:56:24 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B12F2D57A5
        for <bpf@vger.kernel.org>; Mon,  4 Apr 2022 19:05:56 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 234NPExP022550
        for <bpf@vger.kernel.org>; Mon, 4 Apr 2022 16:42:33 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3f7x4xdg0s-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 04 Apr 2022 16:42:32 -0700
Received: from twshared31479.05.prn5.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 4 Apr 2022 16:42:29 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id BF4BC1661B529; Mon,  4 Apr 2022 16:42:15 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>,
        Alan Maguire <alan.maguire@oracle.com>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Hengqi Chen <hengqi.chen@gmail.com>
Subject: [PATCH v3 bpf-next 6/7] selftests/bpf: add basic USDT selftests
Date:   Mon, 4 Apr 2022 16:42:01 -0700
Message-ID: <20220404234202.331384-7-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220404234202.331384-1-andrii@kernel.org>
References: <20220404234202.331384-1-andrii@kernel.org>
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: tib9Mj-NHiSpdRXemBRicE5SxNhYV5Zk
X-Proofpoint-ORIG-GUID: tib9Mj-NHiSpdRXemBRicE5SxNhYV5Zk
Content-Transfer-Encoding: 8BIT
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-04-04_09,2022-03-31_01,2022-02-23_01
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
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

USDT selftests utilize sys/sdt.h header that on Ubuntu systems comes
from systemtap-sdt-devel package. But to simplify everyone's life,
including CI but especially casual contributors to bpf/bpf-next that
are trying to build selftests, I've checked in sys/sdt.h header from [0]
directly. This way it will work on all architectures and distros without
having to figure it out for every relevant combination and adding any
extra implicit package dependencies.

  [0] https://sourceware.org/git?p=systemtap.git;a=blob_plain;f=includes/sys/sdt.h;h=ca0162b4dc57520b96638c8ae79ad547eb1dd3a1;hb=HEAD

Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
Acked-by: Dave Marchevsky <davemarchevsky@fb.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/testing/selftests/bpf/Makefile          |  14 +-
 tools/testing/selftests/bpf/prog_tests/usdt.c | 313 +++++++++++
 tools/testing/selftests/bpf/progs/test_usdt.c |  96 ++++
 .../selftests/bpf/progs/test_usdt_multispec.c |  34 ++
 tools/testing/selftests/bpf/sdt-config.h      |   6 +
 tools/testing/selftests/bpf/sdt.h             | 513 ++++++++++++++++++
 6 files changed, 970 insertions(+), 6 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/usdt.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_usdt.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_usdt_multispec.c
 create mode 100644 tools/testing/selftests/bpf/sdt-config.h
 create mode 100644 tools/testing/selftests/bpf/sdt.h

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
index 000000000000..0677c9bfd40b
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/usdt.c
@@ -0,0 +1,313 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2022 Meta Platforms, Inc. and affiliates. */
+#include <test_progs.h>
+
+#define _SDT_HAS_SEMAPHORES 1
+#include "../sdt.h"
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
index 000000000000..3a090681f981
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
+/* this file is linked together with test_usdt.c to validate that usdt.bpf.h
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
diff --git a/tools/testing/selftests/bpf/sdt-config.h b/tools/testing/selftests/bpf/sdt-config.h
new file mode 100644
index 000000000000..733045a52771
--- /dev/null
+++ b/tools/testing/selftests/bpf/sdt-config.h
@@ -0,0 +1,6 @@
+/* includes/sys/sdt-config.h.  Generated from sdt-config.h.in by configure.
+
+   This file just defines _SDT_ASM_SECTION_AUTOGROUP_SUPPORT to 0 or 1 to
+   indicate whether the assembler supports "?" in .pushsection directives.  */
+
+#define _SDT_ASM_SECTION_AUTOGROUP_SUPPORT 1
diff --git a/tools/testing/selftests/bpf/sdt.h b/tools/testing/selftests/bpf/sdt.h
new file mode 100644
index 000000000000..ca0162b4dc57
--- /dev/null
+++ b/tools/testing/selftests/bpf/sdt.h
@@ -0,0 +1,513 @@
+/* <sys/sdt.h> - Systemtap static probe definition macros.
+
+   This file is dedicated to the public domain, pursuant to CC0
+   (https://creativecommons.org/publicdomain/zero/1.0/)
+*/
+
+#ifndef _SYS_SDT_H
+#define _SYS_SDT_H    1
+
+/*
+  This file defines a family of macros
+
+       STAP_PROBEn(op1, ..., opn)
+
+  that emit a nop into the instruction stream, and some data into an auxiliary
+  note section.  The data in the note section describes the operands, in terms
+  of size and location.  Each location is encoded as assembler operand string.
+  Consumer tools such as gdb or systemtap insert breakpoints on top of
+  the nop, and decode the location operand-strings, like an assembler,
+  to find the values being passed.
+
+  The operand strings are selected by the compiler for each operand.
+  They are constrained by gcc inline-assembler codes.  The default is:
+
+  #define STAP_SDT_ARG_CONSTRAINT nor
+
+  This is a good default if the operands tend to be integral and
+  moderate in number (smaller than number of registers).  In other
+  cases, the compiler may report "'asm' requires impossible reload" or
+  similar.  In this case, consider simplifying the macro call (fewer
+  and simpler operands), reduce optimization, or override the default
+  constraints string via:
+
+  #define STAP_SDT_ARG_CONSTRAINT g
+  #include <sys/sdt.h>
+
+  See also:
+  https://sourceware.org/systemtap/wiki/UserSpaceProbeImplementation
+  https://gcc.gnu.org/onlinedocs/gcc/Constraints.html
+ */
+
+
+
+#ifdef __ASSEMBLER__
+# define _SDT_PROBE(provider, name, n, arglist)	\
+  _SDT_ASM_BODY(provider, name, _SDT_ASM_SUBSTR_1, (_SDT_DEPAREN_##n arglist)) \
+  _SDT_ASM_BASE
+# define _SDT_ASM_1(x)			x;
+# define _SDT_ASM_2(a, b)		a,b;
+# define _SDT_ASM_3(a, b, c)		a,b,c;
+# define _SDT_ASM_5(a, b, c, d, e)	a,b,c,d,e;
+# define _SDT_ASM_STRING_1(x)		.asciz #x;
+# define _SDT_ASM_SUBSTR_1(x)		.ascii #x;
+# define _SDT_DEPAREN_0()				/* empty */
+# define _SDT_DEPAREN_1(a)				a
+# define _SDT_DEPAREN_2(a,b)				a b
+# define _SDT_DEPAREN_3(a,b,c)				a b c
+# define _SDT_DEPAREN_4(a,b,c,d)			a b c d
+# define _SDT_DEPAREN_5(a,b,c,d,e)			a b c d e
+# define _SDT_DEPAREN_6(a,b,c,d,e,f)			a b c d e f
+# define _SDT_DEPAREN_7(a,b,c,d,e,f,g)			a b c d e f g
+# define _SDT_DEPAREN_8(a,b,c,d,e,f,g,h)		a b c d e f g h
+# define _SDT_DEPAREN_9(a,b,c,d,e,f,g,h,i)		a b c d e f g h i
+# define _SDT_DEPAREN_10(a,b,c,d,e,f,g,h,i,j)		a b c d e f g h i j
+# define _SDT_DEPAREN_11(a,b,c,d,e,f,g,h,i,j,k)		a b c d e f g h i j k
+# define _SDT_DEPAREN_12(a,b,c,d,e,f,g,h,i,j,k,l)	a b c d e f g h i j k l
+#else
+#if defined _SDT_HAS_SEMAPHORES
+#define _SDT_NOTE_SEMAPHORE_USE(provider, name) \
+  __asm__ __volatile__ ("" :: "m" (provider##_##name##_semaphore));
+#else
+#define _SDT_NOTE_SEMAPHORE_USE(provider, name)
+#endif
+
+# define _SDT_PROBE(provider, name, n, arglist) \
+  do {									    \
+    _SDT_NOTE_SEMAPHORE_USE(provider, name); \
+    __asm__ __volatile__ (_SDT_ASM_BODY(provider, name, _SDT_ASM_ARGS, (n)) \
+			  :: _SDT_ASM_OPERANDS_##n arglist);		    \
+    __asm__ __volatile__ (_SDT_ASM_BASE);				    \
+  } while (0)
+# define _SDT_S(x)			#x
+# define _SDT_ASM_1(x)			_SDT_S(x) "\n"
+# define _SDT_ASM_2(a, b)		_SDT_S(a) "," _SDT_S(b) "\n"
+# define _SDT_ASM_3(a, b, c)		_SDT_S(a) "," _SDT_S(b) "," \
+					_SDT_S(c) "\n"
+# define _SDT_ASM_5(a, b, c, d, e)	_SDT_S(a) "," _SDT_S(b) "," \
+					_SDT_S(c) "," _SDT_S(d) "," \
+					_SDT_S(e) "\n"
+# define _SDT_ASM_ARGS(n)		_SDT_ASM_TEMPLATE_##n
+# define _SDT_ASM_STRING_1(x)		_SDT_ASM_1(.asciz #x)
+# define _SDT_ASM_SUBSTR_1(x)		_SDT_ASM_1(.ascii #x)
+
+# define _SDT_ARGFMT(no)                _SDT_ASM_1(_SDT_SIGN %n[_SDT_S##no]) \
+                                        _SDT_ASM_1(_SDT_SIZE %n[_SDT_S##no]) \
+                                        _SDT_ASM_1(_SDT_TYPE %n[_SDT_S##no]) \
+                                        _SDT_ASM_SUBSTR(_SDT_ARGTMPL(_SDT_A##no))
+
+
+# ifndef STAP_SDT_ARG_CONSTRAINT
+# if defined __powerpc__
+# define STAP_SDT_ARG_CONSTRAINT        nZr
+# elif defined __arm__
+# define STAP_SDT_ARG_CONSTRAINT        g
+# else
+# define STAP_SDT_ARG_CONSTRAINT        nor
+# endif
+# endif
+
+# define _SDT_STRINGIFY(x)              #x
+# define _SDT_ARG_CONSTRAINT_STRING(x)  _SDT_STRINGIFY(x)
+/* _SDT_S encodes the size and type as 0xSSTT which is decoded by the assembler
+   macros _SDT_SIZE and _SDT_TYPE */
+# define _SDT_ARG(n, x)				    \
+  [_SDT_S##n] "n" ((_SDT_ARGSIGNED (x) ? (int)-1 : 1) * (-(((int) _SDT_ARGSIZE (x)) << 8) + (-(0x7f & __builtin_classify_type (x))))), \
+  [_SDT_A##n] _SDT_ARG_CONSTRAINT_STRING (STAP_SDT_ARG_CONSTRAINT) (_SDT_ARGVAL (x))
+#endif
+#define _SDT_ASM_STRING(x)		_SDT_ASM_STRING_1(x)
+#define _SDT_ASM_SUBSTR(x)		_SDT_ASM_SUBSTR_1(x)
+
+#define _SDT_ARGARRAY(x)	(__builtin_classify_type (x) == 14	\
+				 || __builtin_classify_type (x) == 5)
+
+#ifdef __cplusplus
+# define _SDT_ARGSIGNED(x)	(!_SDT_ARGARRAY (x) \
+				 && __sdt_type<__typeof (x)>::__sdt_signed)
+# define _SDT_ARGSIZE(x)	(_SDT_ARGARRAY (x) \
+				 ? sizeof (void *) : sizeof (x))
+# define _SDT_ARGVAL(x)		(x)
+
+# include <cstddef>
+
+template<typename __sdt_T>
+struct __sdt_type
+{
+  static const bool __sdt_signed = false;
+};
+  
+#define __SDT_ALWAYS_SIGNED(T) \
+template<> struct __sdt_type<T> { static const bool __sdt_signed = true; };
+#define __SDT_COND_SIGNED(T,CT)						\
+template<> struct __sdt_type<T> { static const bool __sdt_signed = ((CT)(-1) < 1); };
+__SDT_ALWAYS_SIGNED(signed char)
+__SDT_ALWAYS_SIGNED(short)
+__SDT_ALWAYS_SIGNED(int)
+__SDT_ALWAYS_SIGNED(long)
+__SDT_ALWAYS_SIGNED(long long)
+__SDT_ALWAYS_SIGNED(volatile signed char)
+__SDT_ALWAYS_SIGNED(volatile short)
+__SDT_ALWAYS_SIGNED(volatile int)
+__SDT_ALWAYS_SIGNED(volatile long)
+__SDT_ALWAYS_SIGNED(volatile long long)
+__SDT_ALWAYS_SIGNED(const signed char)
+__SDT_ALWAYS_SIGNED(const short)
+__SDT_ALWAYS_SIGNED(const int)
+__SDT_ALWAYS_SIGNED(const long)
+__SDT_ALWAYS_SIGNED(const long long)
+__SDT_ALWAYS_SIGNED(const volatile signed char)
+__SDT_ALWAYS_SIGNED(const volatile short)
+__SDT_ALWAYS_SIGNED(const volatile int)
+__SDT_ALWAYS_SIGNED(const volatile long)
+__SDT_ALWAYS_SIGNED(const volatile long long)
+__SDT_COND_SIGNED(char, char)
+__SDT_COND_SIGNED(wchar_t, wchar_t)
+__SDT_COND_SIGNED(volatile char, char)
+__SDT_COND_SIGNED(volatile wchar_t, wchar_t)
+__SDT_COND_SIGNED(const char, char)
+__SDT_COND_SIGNED(const wchar_t, wchar_t)
+__SDT_COND_SIGNED(const volatile char, char)
+__SDT_COND_SIGNED(const volatile wchar_t, wchar_t)
+#if defined (__GNUC__) && (__GNUC__ > 4 || (__GNUC__ == 4 && __GNUC_MINOR__ >= 4))
+/* __SDT_COND_SIGNED(char16_t) */
+/* __SDT_COND_SIGNED(char32_t) */
+#endif
+
+template<typename __sdt_E>
+struct __sdt_type<__sdt_E[]> : public __sdt_type<__sdt_E *> {};
+
+template<typename __sdt_E, size_t __sdt_N>
+struct __sdt_type<__sdt_E[__sdt_N]> : public __sdt_type<__sdt_E *> {};
+
+#elif !defined(__ASSEMBLER__)
+__extension__ extern unsigned long long __sdt_unsp;
+# define _SDT_ARGINTTYPE(x)						\
+  __typeof (__builtin_choose_expr (((__builtin_classify_type (x)	\
+				     + 3) & -4) == 4, (x), 0U))
+# define _SDT_ARGSIGNED(x)						\
+  (!__extension__							\
+   (__builtin_constant_p ((((unsigned long long)			\
+			    (_SDT_ARGINTTYPE (x)) __sdt_unsp)		\
+			   & ((unsigned long long)1 << (sizeof (unsigned long long)	\
+				       * __CHAR_BIT__ - 1))) == 0)	\
+    || (_SDT_ARGINTTYPE (x)) -1 > (_SDT_ARGINTTYPE (x)) 0))
+# define _SDT_ARGSIZE(x)	\
+  (_SDT_ARGARRAY (x) ? sizeof (void *) : sizeof (x))
+# define _SDT_ARGVAL(x)		(x)
+#endif
+
+#if defined __powerpc__ || defined __powerpc64__
+# define _SDT_ARGTMPL(id)	%I[id]%[id]
+#elif defined __i386__
+# define _SDT_ARGTMPL(id)	%k[id]  /* gcc.gnu.org/PR80115 sourceware.org/PR24541 */
+#else
+# define _SDT_ARGTMPL(id)	%[id]
+#endif
+
+/* NB: gdb PR24541 highlighted an unspecified corner of the sdt.h
+   operand note format.
+
+   The named register may be a longer or shorter (!) alias for the
+   storage where the value in question is found.  For example, on
+   i386, 64-bit value may be put in register pairs, and the register
+   name stored would identify just one of them.  Previously, gcc was
+   asked to emit the %w[id] (16-bit alias of some registers holding
+   operands), even when a wider 32-bit value was used.
+
+   Bottom line: the byte-width given before the @ sign governs.  If
+   there is a mismatch between that width and that of the named
+   register, then a sys/sdt.h note consumer may need to employ
+   architecture-specific heuristics to figure out where the compiler
+   has actually put the complete value.
+*/
+
+#ifdef __LP64__
+# define _SDT_ASM_ADDR	.8byte
+#else
+# define _SDT_ASM_ADDR	.4byte
+#endif
+
+/* The ia64 and s390 nop instructions take an argument. */
+#if defined(__ia64__) || defined(__s390__) || defined(__s390x__)
+#define _SDT_NOP	nop 0
+#else
+#define _SDT_NOP	nop
+#endif
+
+#define _SDT_NOTE_NAME	"stapsdt"
+#define _SDT_NOTE_TYPE	3
+
+/* If the assembler supports the necessary feature, then we can play
+   nice with code in COMDAT sections, which comes up in C++ code.
+   Without that assembler support, some combinations of probe placements
+   in certain kinds of C++ code may produce link-time errors.  */
+#include "sdt-config.h"
+#if _SDT_ASM_SECTION_AUTOGROUP_SUPPORT
+# define _SDT_ASM_AUTOGROUP "?"
+#else
+# define _SDT_ASM_AUTOGROUP ""
+#endif
+
+#define _SDT_DEF_MACROS							     \
+	_SDT_ASM_1(.altmacro)						     \
+	_SDT_ASM_1(.macro _SDT_SIGN x)				     	     \
+	_SDT_ASM_3(.pushsection .note.stapsdt,"","note")		     \
+	_SDT_ASM_1(.iflt \\x)						     \
+	_SDT_ASM_1(.ascii "-")						     \
+	_SDT_ASM_1(.endif)						     \
+	_SDT_ASM_1(.popsection)						     \
+	_SDT_ASM_1(.endm)						     \
+	_SDT_ASM_1(.macro _SDT_SIZE_ x)					     \
+	_SDT_ASM_3(.pushsection .note.stapsdt,"","note")		     \
+	_SDT_ASM_1(.ascii "\x")						     \
+	_SDT_ASM_1(.popsection)						     \
+	_SDT_ASM_1(.endm)						     \
+	_SDT_ASM_1(.macro _SDT_SIZE x)					     \
+	_SDT_ASM_1(_SDT_SIZE_ %%((-(-\\x*((-\\x>0)-(-\\x<0))))>>8))	     \
+	_SDT_ASM_1(.endm)						     \
+	_SDT_ASM_1(.macro _SDT_TYPE_ x)				             \
+	_SDT_ASM_3(.pushsection .note.stapsdt,"","note")		     \
+	_SDT_ASM_2(.ifc 8,\\x)					     	     \
+	_SDT_ASM_1(.ascii "f")						     \
+	_SDT_ASM_1(.endif)						     \
+	_SDT_ASM_1(.ascii "@")						     \
+	_SDT_ASM_1(.popsection)						     \
+	_SDT_ASM_1(.endm)						     \
+	_SDT_ASM_1(.macro _SDT_TYPE x)				     	     \
+	_SDT_ASM_1(_SDT_TYPE_ %%((\\x)&(0xff)))			     \
+	_SDT_ASM_1(.endm)
+
+#define _SDT_UNDEF_MACROS						      \
+  _SDT_ASM_1(.purgem _SDT_SIGN)						      \
+  _SDT_ASM_1(.purgem _SDT_SIZE_)					      \
+  _SDT_ASM_1(.purgem _SDT_SIZE)						      \
+  _SDT_ASM_1(.purgem _SDT_TYPE_)					      \
+  _SDT_ASM_1(.purgem _SDT_TYPE)
+
+#define _SDT_ASM_BODY(provider, name, pack_args, args, ...)		      \
+  _SDT_DEF_MACROS							      \
+  _SDT_ASM_1(990:	_SDT_NOP)					      \
+  _SDT_ASM_3(		.pushsection .note.stapsdt,_SDT_ASM_AUTOGROUP,"note") \
+  _SDT_ASM_1(		.balign 4)					      \
+  _SDT_ASM_3(		.4byte 992f-991f, 994f-993f, _SDT_NOTE_TYPE)	      \
+  _SDT_ASM_1(991:	.asciz _SDT_NOTE_NAME)				      \
+  _SDT_ASM_1(992:	.balign 4)					      \
+  _SDT_ASM_1(993:	_SDT_ASM_ADDR 990b)				      \
+  _SDT_ASM_1(		_SDT_ASM_ADDR _.stapsdt.base)			      \
+  _SDT_SEMAPHORE(provider,name)						      \
+  _SDT_ASM_STRING(provider)						      \
+  _SDT_ASM_STRING(name)							      \
+  pack_args args							      \
+  _SDT_ASM_SUBSTR(\x00)							      \
+  _SDT_UNDEF_MACROS							      \
+  _SDT_ASM_1(994:	.balign 4)					      \
+  _SDT_ASM_1(		.popsection)
+
+#define _SDT_ASM_BASE							      \
+  _SDT_ASM_1(.ifndef _.stapsdt.base)					      \
+  _SDT_ASM_5(		.pushsection .stapsdt.base,"aG","progbits",	      \
+							.stapsdt.base,comdat) \
+  _SDT_ASM_1(		.weak _.stapsdt.base)				      \
+  _SDT_ASM_1(		.hidden _.stapsdt.base)				      \
+  _SDT_ASM_1(	_.stapsdt.base: .space 1)				      \
+  _SDT_ASM_2(		.size _.stapsdt.base, 1)			      \
+  _SDT_ASM_1(		.popsection)					      \
+  _SDT_ASM_1(.endif)
+
+#if defined _SDT_HAS_SEMAPHORES
+#define _SDT_SEMAPHORE(p,n) \
+	_SDT_ASM_1(		_SDT_ASM_ADDR p##_##n##_semaphore)
+#else
+#define _SDT_SEMAPHORE(p,n) _SDT_ASM_1(		_SDT_ASM_ADDR 0)
+#endif
+
+#define _SDT_ASM_BLANK _SDT_ASM_SUBSTR(\x20)
+#define _SDT_ASM_TEMPLATE_0		/* no arguments */
+#define _SDT_ASM_TEMPLATE_1		_SDT_ARGFMT(1)
+#define _SDT_ASM_TEMPLATE_2		_SDT_ASM_TEMPLATE_1 _SDT_ASM_BLANK _SDT_ARGFMT(2)
+#define _SDT_ASM_TEMPLATE_3		_SDT_ASM_TEMPLATE_2 _SDT_ASM_BLANK _SDT_ARGFMT(3)
+#define _SDT_ASM_TEMPLATE_4		_SDT_ASM_TEMPLATE_3 _SDT_ASM_BLANK _SDT_ARGFMT(4)
+#define _SDT_ASM_TEMPLATE_5		_SDT_ASM_TEMPLATE_4 _SDT_ASM_BLANK _SDT_ARGFMT(5)
+#define _SDT_ASM_TEMPLATE_6		_SDT_ASM_TEMPLATE_5 _SDT_ASM_BLANK _SDT_ARGFMT(6)
+#define _SDT_ASM_TEMPLATE_7		_SDT_ASM_TEMPLATE_6 _SDT_ASM_BLANK _SDT_ARGFMT(7)
+#define _SDT_ASM_TEMPLATE_8		_SDT_ASM_TEMPLATE_7 _SDT_ASM_BLANK _SDT_ARGFMT(8)
+#define _SDT_ASM_TEMPLATE_9		_SDT_ASM_TEMPLATE_8 _SDT_ASM_BLANK _SDT_ARGFMT(9)
+#define _SDT_ASM_TEMPLATE_10		_SDT_ASM_TEMPLATE_9 _SDT_ASM_BLANK _SDT_ARGFMT(10)
+#define _SDT_ASM_TEMPLATE_11		_SDT_ASM_TEMPLATE_10 _SDT_ASM_BLANK _SDT_ARGFMT(11)
+#define _SDT_ASM_TEMPLATE_12		_SDT_ASM_TEMPLATE_11 _SDT_ASM_BLANK _SDT_ARGFMT(12)
+#define _SDT_ASM_OPERANDS_0()		[__sdt_dummy] "g" (0)
+#define _SDT_ASM_OPERANDS_1(arg1)	_SDT_ARG(1, arg1)
+#define _SDT_ASM_OPERANDS_2(arg1, arg2) \
+  _SDT_ASM_OPERANDS_1(arg1), _SDT_ARG(2, arg2)
+#define _SDT_ASM_OPERANDS_3(arg1, arg2, arg3) \
+  _SDT_ASM_OPERANDS_2(arg1, arg2), _SDT_ARG(3, arg3)
+#define _SDT_ASM_OPERANDS_4(arg1, arg2, arg3, arg4) \
+  _SDT_ASM_OPERANDS_3(arg1, arg2, arg3), _SDT_ARG(4, arg4)
+#define _SDT_ASM_OPERANDS_5(arg1, arg2, arg3, arg4, arg5) \
+  _SDT_ASM_OPERANDS_4(arg1, arg2, arg3, arg4), _SDT_ARG(5, arg5)
+#define _SDT_ASM_OPERANDS_6(arg1, arg2, arg3, arg4, arg5, arg6) \
+  _SDT_ASM_OPERANDS_5(arg1, arg2, arg3, arg4, arg5), _SDT_ARG(6, arg6)
+#define _SDT_ASM_OPERANDS_7(arg1, arg2, arg3, arg4, arg5, arg6, arg7) \
+  _SDT_ASM_OPERANDS_6(arg1, arg2, arg3, arg4, arg5, arg6), _SDT_ARG(7, arg7)
+#define _SDT_ASM_OPERANDS_8(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8) \
+  _SDT_ASM_OPERANDS_7(arg1, arg2, arg3, arg4, arg5, arg6, arg7), \
+    _SDT_ARG(8, arg8)
+#define _SDT_ASM_OPERANDS_9(arg1,arg2,arg3,arg4,arg5,arg6,arg7,arg8,arg9) \
+  _SDT_ASM_OPERANDS_8(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8), \
+    _SDT_ARG(9, arg9)
+#define _SDT_ASM_OPERANDS_10(arg1,arg2,arg3,arg4,arg5,arg6,arg7,arg8,arg9,arg10) \
+  _SDT_ASM_OPERANDS_9(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9), \
+    _SDT_ARG(10, arg10)
+#define _SDT_ASM_OPERANDS_11(arg1,arg2,arg3,arg4,arg5,arg6,arg7,arg8,arg9,arg10,arg11) \
+  _SDT_ASM_OPERANDS_10(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10), \
+    _SDT_ARG(11, arg11)
+#define _SDT_ASM_OPERANDS_12(arg1,arg2,arg3,arg4,arg5,arg6,arg7,arg8,arg9,arg10,arg11,arg12) \
+  _SDT_ASM_OPERANDS_11(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11), \
+    _SDT_ARG(12, arg12)
+
+/* These macros can be used in C, C++, or assembly code.
+   In assembly code the arguments should use normal assembly operand syntax.  */
+
+#define STAP_PROBE(provider, name) \
+  _SDT_PROBE(provider, name, 0, ())
+#define STAP_PROBE1(provider, name, arg1) \
+  _SDT_PROBE(provider, name, 1, (arg1))
+#define STAP_PROBE2(provider, name, arg1, arg2) \
+  _SDT_PROBE(provider, name, 2, (arg1, arg2))
+#define STAP_PROBE3(provider, name, arg1, arg2, arg3) \
+  _SDT_PROBE(provider, name, 3, (arg1, arg2, arg3))
+#define STAP_PROBE4(provider, name, arg1, arg2, arg3, arg4) \
+  _SDT_PROBE(provider, name, 4, (arg1, arg2, arg3, arg4))
+#define STAP_PROBE5(provider, name, arg1, arg2, arg3, arg4, arg5) \
+  _SDT_PROBE(provider, name, 5, (arg1, arg2, arg3, arg4, arg5))
+#define STAP_PROBE6(provider, name, arg1, arg2, arg3, arg4, arg5, arg6)	\
+  _SDT_PROBE(provider, name, 6, (arg1, arg2, arg3, arg4, arg5, arg6))
+#define STAP_PROBE7(provider, name, arg1, arg2, arg3, arg4, arg5, arg6, arg7) \
+  _SDT_PROBE(provider, name, 7, (arg1, arg2, arg3, arg4, arg5, arg6, arg7))
+#define STAP_PROBE8(provider,name,arg1,arg2,arg3,arg4,arg5,arg6,arg7,arg8) \
+  _SDT_PROBE(provider, name, 8, (arg1,arg2,arg3,arg4,arg5,arg6,arg7,arg8))
+#define STAP_PROBE9(provider,name,arg1,arg2,arg3,arg4,arg5,arg6,arg7,arg8,arg9)\
+  _SDT_PROBE(provider, name, 9, (arg1,arg2,arg3,arg4,arg5,arg6,arg7,arg8,arg9))
+#define STAP_PROBE10(provider,name,arg1,arg2,arg3,arg4,arg5,arg6,arg7,arg8,arg9,arg10) \
+  _SDT_PROBE(provider, name, 10, \
+	     (arg1,arg2,arg3,arg4,arg5,arg6,arg7,arg8,arg9,arg10))
+#define STAP_PROBE11(provider,name,arg1,arg2,arg3,arg4,arg5,arg6,arg7,arg8,arg9,arg10,arg11) \
+  _SDT_PROBE(provider, name, 11, \
+	     (arg1,arg2,arg3,arg4,arg5,arg6,arg7,arg8,arg9,arg10,arg11))
+#define STAP_PROBE12(provider,name,arg1,arg2,arg3,arg4,arg5,arg6,arg7,arg8,arg9,arg10,arg11,arg12) \
+  _SDT_PROBE(provider, name, 12, \
+	     (arg1,arg2,arg3,arg4,arg5,arg6,arg7,arg8,arg9,arg10,arg11,arg12))
+
+/* This STAP_PROBEV macro can be used in variadic scenarios, where the
+   number of probe arguments is not known until compile time.  Since
+   variadic macro support may vary with compiler options, you must
+   pre-#define SDT_USE_VARIADIC to enable this type of probe.
+
+   The trick to count __VA_ARGS__ was inspired by this post by
+   Laurent Deniau <laurent.deniau@cern.ch>:
+       http://groups.google.com/group/comp.std.c/msg/346fc464319b1ee5
+
+   Note that our _SDT_NARG is called with an extra 0 arg that's not
+   counted, so we don't have to worry about the behavior of macros
+   called without any arguments.  */
+
+#define _SDT_NARG(...) __SDT_NARG(__VA_ARGS__, 12,11,10,9,8,7,6,5,4,3,2,1,0)
+#define __SDT_NARG(_0,_1,_2,_3,_4,_5,_6,_7,_8,_9,_10,_11,_12, N, ...) N
+#ifdef SDT_USE_VARIADIC
+#define _SDT_PROBE_N(provider, name, N, ...) \
+  _SDT_PROBE(provider, name, N, (__VA_ARGS__))
+#define STAP_PROBEV(provider, name, ...) \
+  _SDT_PROBE_N(provider, name, _SDT_NARG(0, ##__VA_ARGS__), ##__VA_ARGS__)
+#endif
+
+/* These macros are for use in asm statements.  You must compile
+   with -std=gnu99 or -std=c99 to use the STAP_PROBE_ASM macro.
+
+   The STAP_PROBE_ASM macro generates a quoted string to be used in the
+   template portion of the asm statement, concatenated with strings that
+   contain the actual assembly code around the probe site.
+
+   For example:
+
+	asm ("before\n"
+	     STAP_PROBE_ASM(provider, fooprobe, %eax 4(%esi))
+	     "after");
+
+   emits the assembly code for "before\nafter", with a probe in between.
+   The probe arguments are the %eax register, and the value of the memory
+   word located 4 bytes past the address in the %esi register.  Note that
+   because this is a simple asm, not a GNU C extended asm statement, these
+   % characters do not need to be doubled to generate literal %reg names.
+
+   In a GNU C extended asm statement, the probe arguments can be specified
+   using the macro STAP_PROBE_ASM_TEMPLATE(n) for n arguments.  The paired
+   macro STAP_PROBE_ASM_OPERANDS gives the C values of these probe arguments,
+   and appears in the input operand list of the asm statement.  For example:
+
+	asm ("someinsn %0,%1\n" // %0 is output operand, %1 is input operand
+	     STAP_PROBE_ASM(provider, fooprobe, STAP_PROBE_ASM_TEMPLATE(3))
+	     "otherinsn %[namedarg]"
+	     : "r" (outvar)
+	     : "g" (some_value), [namedarg] "i" (1234),
+	       STAP_PROBE_ASM_OPERANDS(3, some_value, some_ptr->field, 1234));
+
+    This is just like writing:
+
+	STAP_PROBE3(provider, fooprobe, some_value, some_ptr->field, 1234));
+
+    but the probe site is right between "someinsn" and "otherinsn".
+
+    The probe arguments in STAP_PROBE_ASM can be given as assembly
+    operands instead, even inside a GNU C extended asm statement.
+    Note that these can use operand templates like %0 or %[name],
+    and likewise they must write %%reg for a literal operand of %reg.  */
+
+#define _SDT_ASM_BODY_1(p,n,...) _SDT_ASM_BODY(p,n,_SDT_ASM_SUBSTR,(__VA_ARGS__))
+#define _SDT_ASM_BODY_2(p,n,...) _SDT_ASM_BODY(p,n,/*_SDT_ASM_STRING */,__VA_ARGS__)
+#define _SDT_ASM_BODY_N2(p,n,no,...) _SDT_ASM_BODY_ ## no(p,n,__VA_ARGS__)
+#define _SDT_ASM_BODY_N1(p,n,no,...) _SDT_ASM_BODY_N2(p,n,no,__VA_ARGS__)
+#define _SDT_ASM_BODY_N(p,n,...) _SDT_ASM_BODY_N1(p,n,_SDT_NARG(0, __VA_ARGS__),__VA_ARGS__)
+
+#if __STDC_VERSION__ >= 199901L
+# define STAP_PROBE_ASM(provider, name, ...)		\
+  _SDT_ASM_BODY_N(provider, name, __VA_ARGS__)					\
+  _SDT_ASM_BASE
+# define STAP_PROBE_ASM_OPERANDS(n, ...) _SDT_ASM_OPERANDS_##n(__VA_ARGS__)
+#else
+# define STAP_PROBE_ASM(provider, name, args)	\
+  _SDT_ASM_BODY(provider, name, /* _SDT_ASM_STRING */, (args))	\
+  _SDT_ASM_BASE
+#endif
+#define STAP_PROBE_ASM_TEMPLATE(n) _SDT_ASM_TEMPLATE_##n,"use _SDT_ASM_TEMPLATE_"
+
+
+/* DTrace compatible macro names.  */
+#define DTRACE_PROBE(provider,probe)		\
+  STAP_PROBE(provider,probe)
+#define DTRACE_PROBE1(provider,probe,parm1)	\
+  STAP_PROBE1(provider,probe,parm1)
+#define DTRACE_PROBE2(provider,probe,parm1,parm2)	\
+  STAP_PROBE2(provider,probe,parm1,parm2)
+#define DTRACE_PROBE3(provider,probe,parm1,parm2,parm3) \
+  STAP_PROBE3(provider,probe,parm1,parm2,parm3)
+#define DTRACE_PROBE4(provider,probe,parm1,parm2,parm3,parm4)	\
+  STAP_PROBE4(provider,probe,parm1,parm2,parm3,parm4)
+#define DTRACE_PROBE5(provider,probe,parm1,parm2,parm3,parm4,parm5)	\
+  STAP_PROBE5(provider,probe,parm1,parm2,parm3,parm4,parm5)
+#define DTRACE_PROBE6(provider,probe,parm1,parm2,parm3,parm4,parm5,parm6) \
+  STAP_PROBE6(provider,probe,parm1,parm2,parm3,parm4,parm5,parm6)
+#define DTRACE_PROBE7(provider,probe,parm1,parm2,parm3,parm4,parm5,parm6,parm7) \
+  STAP_PROBE7(provider,probe,parm1,parm2,parm3,parm4,parm5,parm6,parm7)
+#define DTRACE_PROBE8(provider,probe,parm1,parm2,parm3,parm4,parm5,parm6,parm7,parm8) \
+  STAP_PROBE8(provider,probe,parm1,parm2,parm3,parm4,parm5,parm6,parm7,parm8)
+#define DTRACE_PROBE9(provider,probe,parm1,parm2,parm3,parm4,parm5,parm6,parm7,parm8,parm9) \
+  STAP_PROBE9(provider,probe,parm1,parm2,parm3,parm4,parm5,parm6,parm7,parm8,parm9)
+#define DTRACE_PROBE10(provider,probe,parm1,parm2,parm3,parm4,parm5,parm6,parm7,parm8,parm9,parm10) \
+  STAP_PROBE10(provider,probe,parm1,parm2,parm3,parm4,parm5,parm6,parm7,parm8,parm9,parm10)
+#define DTRACE_PROBE11(provider,probe,parm1,parm2,parm3,parm4,parm5,parm6,parm7,parm8,parm9,parm10,parm11) \
+  STAP_PROBE11(provider,probe,parm1,parm2,parm3,parm4,parm5,parm6,parm7,parm8,parm9,parm10,parm11)
+#define DTRACE_PROBE12(provider,probe,parm1,parm2,parm3,parm4,parm5,parm6,parm7,parm8,parm9,parm10,parm11,parm12) \
+  STAP_PROBE12(provider,probe,parm1,parm2,parm3,parm4,parm5,parm6,parm7,parm8,parm9,parm10,parm11,parm12)
+
+
+#endif /* sys/sdt.h */
-- 
2.30.2

