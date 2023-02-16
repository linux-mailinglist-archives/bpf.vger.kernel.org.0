Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DFFD698B83
	for <lists+bpf@lfdr.de>; Thu, 16 Feb 2023 06:01:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbjBPFBC convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Thu, 16 Feb 2023 00:01:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjBPFBB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 16 Feb 2023 00:01:01 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFB5823640
        for <bpf@vger.kernel.org>; Wed, 15 Feb 2023 21:00:59 -0800 (PST)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31G4YOPo031339
        for <bpf@vger.kernel.org>; Wed, 15 Feb 2023 21:00:59 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3nrc19m4tg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 15 Feb 2023 21:00:41 -0800
Received: from twshared43869.37.frc1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Wed, 15 Feb 2023 21:00:10 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 88F8A27990BAB; Wed, 15 Feb 2023 20:59:59 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH v2 bpf-next 2/3] selftests/bpf: convert test_global_funcs test to test_loader framework
Date:   Wed, 15 Feb 2023 20:59:53 -0800
Message-ID: <20230216045954.3002473-3-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230216045954.3002473-1-andrii@kernel.org>
References: <20230216045954.3002473-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: nUg3TxuyxqTStDz-pgO9PDOcH4vo3iE_
X-Proofpoint-GUID: nUg3TxuyxqTStDz-pgO9PDOcH4vo3iE_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-16_02,2023-02-15_01,2023-02-09_01
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Convert 17 test_global_funcs subtests into test_loader framework for
easier maintenance and more declarative way to define expected
failures/successes.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 .../bpf/prog_tests/test_global_funcs.c        | 131 +++++-------------
 .../selftests/bpf/progs/test_global_func1.c   |   6 +-
 .../selftests/bpf/progs/test_global_func10.c  |   4 +-
 .../selftests/bpf/progs/test_global_func11.c  |   4 +-
 .../selftests/bpf/progs/test_global_func12.c  |   4 +-
 .../selftests/bpf/progs/test_global_func13.c  |   4 +-
 .../selftests/bpf/progs/test_global_func14.c  |   4 +-
 .../selftests/bpf/progs/test_global_func15.c  |   4 +-
 .../selftests/bpf/progs/test_global_func16.c  |   4 +-
 .../selftests/bpf/progs/test_global_func17.c  |   4 +-
 .../selftests/bpf/progs/test_global_func2.c   |  43 +++++-
 .../selftests/bpf/progs/test_global_func3.c   |  10 +-
 .../selftests/bpf/progs/test_global_func4.c   |  55 +++++++-
 .../selftests/bpf/progs/test_global_func5.c   |   4 +-
 .../selftests/bpf/progs/test_global_func6.c   |   4 +-
 .../selftests/bpf/progs/test_global_func7.c   |   4 +-
 .../selftests/bpf/progs/test_global_func8.c   |   4 +-
 .../selftests/bpf/progs/test_global_func9.c   |   4 +-
 18 files changed, 174 insertions(+), 123 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_global_funcs.c b/tools/testing/selftests/bpf/prog_tests/test_global_funcs.c
index 7295cc60f724..2ff4d5c7abfc 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_global_funcs.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_global_funcs.c
@@ -1,104 +1,41 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2020 Facebook */
 #include <test_progs.h>
-
-const char *err_str;
-bool found;
-
-static int libbpf_debug_print(enum libbpf_print_level level,
-			      const char *format, va_list args)
-{
-	char *log_buf;
-
-	if (level != LIBBPF_WARN ||
-	    strcmp(format, "libbpf: \n%s\n")) {
-		vprintf(format, args);
-		return 0;
-	}
-
-	log_buf = va_arg(args, char *);
-	if (!log_buf)
-		goto out;
-	if (err_str && strstr(log_buf, err_str) == 0)
-		found = true;
-out:
-	printf(format, log_buf);
-	return 0;
-}
-
-extern int extra_prog_load_log_flags;
-
-static int check_load(const char *file)
-{
-	struct bpf_object *obj = NULL;
-	struct bpf_program *prog;
-	int err;
-
-	found = false;
-
-	obj = bpf_object__open_file(file, NULL);
-	err = libbpf_get_error(obj);
-	if (err)
-		return err;
-
-	prog = bpf_object__next_program(obj, NULL);
-	if (!prog) {
-		err = -ENOENT;
-		goto err_out;
-	}
-
-	bpf_program__set_flags(prog, BPF_F_TEST_RND_HI32);
-	bpf_program__set_log_level(prog, extra_prog_load_log_flags);
-
-	err = bpf_object__load(obj);
-
-err_out:
-	bpf_object__close(obj);
-	return err;
-}
-
-struct test_def {
-	const char *file;
-	const char *err_str;
-};
+#include "test_global_func1.skel.h"
+#include "test_global_func2.skel.h"
+#include "test_global_func3.skel.h"
+#include "test_global_func4.skel.h"
+#include "test_global_func5.skel.h"
+#include "test_global_func6.skel.h"
+#include "test_global_func7.skel.h"
+#include "test_global_func8.skel.h"
+#include "test_global_func9.skel.h"
+#include "test_global_func10.skel.h"
+#include "test_global_func11.skel.h"
+#include "test_global_func12.skel.h"
+#include "test_global_func13.skel.h"
+#include "test_global_func14.skel.h"
+#include "test_global_func15.skel.h"
+#include "test_global_func16.skel.h"
+#include "test_global_func17.skel.h"
 
 void test_test_global_funcs(void)
 {
-	struct test_def tests[] = {
-		{ "test_global_func1.bpf.o", "combined stack size of 4 calls is 544" },
-		{ "test_global_func2.bpf.o" },
-		{ "test_global_func3.bpf.o", "the call stack of 8 frames" },
-		{ "test_global_func4.bpf.o" },
-		{ "test_global_func5.bpf.o", "expected pointer to ctx, but got PTR" },
-		{ "test_global_func6.bpf.o", "modified ctx ptr R2" },
-		{ "test_global_func7.bpf.o", "foo() doesn't return scalar" },
-		{ "test_global_func8.bpf.o" },
-		{ "test_global_func9.bpf.o" },
-		{ "test_global_func10.bpf.o", "invalid indirect read from stack" },
-		{ "test_global_func11.bpf.o", "Caller passes invalid args into func#1" },
-		{ "test_global_func12.bpf.o", "invalid mem access 'mem_or_null'" },
-		{ "test_global_func13.bpf.o", "Caller passes invalid args into func#1" },
-		{ "test_global_func14.bpf.o", "reference type('FWD S') size cannot be determined" },
-		{ "test_global_func15.bpf.o", "At program exit the register R0 has value" },
-		{ "test_global_func16.bpf.o", "invalid indirect read from stack" },
-		{ "test_global_func17.bpf.o", "Caller passes invalid args into func#1" },
-	};
-	libbpf_print_fn_t old_print_fn = NULL;
-	int err, i, duration = 0;
-
-	old_print_fn = libbpf_set_print(libbpf_debug_print);
-
-	for (i = 0; i < ARRAY_SIZE(tests); i++) {
-		const struct test_def *test = &tests[i];
-
-		if (!test__start_subtest(test->file))
-			continue;
-
-		err_str = test->err_str;
-		err = check_load(test->file);
-		CHECK_FAIL(!!err ^ !!err_str);
-		if (err_str)
-			CHECK(found, "", "expected string '%s'", err_str);
-	}
-	libbpf_set_print(old_print_fn);
+	RUN_TESTS(test_global_func1);
+	RUN_TESTS(test_global_func2);
+	RUN_TESTS(test_global_func3);
+	RUN_TESTS(test_global_func4);
+	RUN_TESTS(test_global_func5);
+	RUN_TESTS(test_global_func6);
+	RUN_TESTS(test_global_func7);
+	RUN_TESTS(test_global_func8);
+	RUN_TESTS(test_global_func9);
+	RUN_TESTS(test_global_func10);
+	RUN_TESTS(test_global_func11);
+	RUN_TESTS(test_global_func12);
+	RUN_TESTS(test_global_func13);
+	RUN_TESTS(test_global_func14);
+	RUN_TESTS(test_global_func15);
+	RUN_TESTS(test_global_func16);
+	RUN_TESTS(test_global_func17);
 }
diff --git a/tools/testing/selftests/bpf/progs/test_global_func1.c b/tools/testing/selftests/bpf/progs/test_global_func1.c
index 7b42dad187b8..23970a20b324 100644
--- a/tools/testing/selftests/bpf/progs/test_global_func1.c
+++ b/tools/testing/selftests/bpf/progs/test_global_func1.c
@@ -3,10 +3,9 @@
 #include <stddef.h>
 #include <linux/bpf.h>
 #include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
 
-#ifndef MAX_STACK
 #define MAX_STACK (512 - 3 * 32 + 8)
-#endif
 
 static __attribute__ ((noinline))
 int f0(int var, struct __sk_buff *skb)
@@ -39,7 +38,8 @@ int f3(int val, struct __sk_buff *skb, int var)
 }
 
 SEC("tc")
-int test_cls(struct __sk_buff *skb)
+__failure __msg("combined stack size of 4 calls is 544")
+int global_func1(struct __sk_buff *skb)
 {
 	return f0(1, skb) + f1(skb) + f2(2, skb) + f3(3, skb, 4);
 }
diff --git a/tools/testing/selftests/bpf/progs/test_global_func10.c b/tools/testing/selftests/bpf/progs/test_global_func10.c
index 97b7031d0e22..98327bdbbfd2 100644
--- a/tools/testing/selftests/bpf/progs/test_global_func10.c
+++ b/tools/testing/selftests/bpf/progs/test_global_func10.c
@@ -2,6 +2,7 @@
 #include <stddef.h>
 #include <linux/bpf.h>
 #include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
 
 struct Small {
 	int x;
@@ -21,7 +22,8 @@ __noinline int foo(const struct Big *big)
 }
 
 SEC("cgroup_skb/ingress")
-int test_cls(struct __sk_buff *skb)
+__failure __msg("invalid indirect read from stack")
+int global_func10(struct __sk_buff *skb)
 {
 	const struct Small small = {.x = skb->len };
 
diff --git a/tools/testing/selftests/bpf/progs/test_global_func11.c b/tools/testing/selftests/bpf/progs/test_global_func11.c
index ef5277d982d9..283e036dc401 100644
--- a/tools/testing/selftests/bpf/progs/test_global_func11.c
+++ b/tools/testing/selftests/bpf/progs/test_global_func11.c
@@ -2,6 +2,7 @@
 #include <stddef.h>
 #include <linux/bpf.h>
 #include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
 
 struct S {
 	int x;
@@ -13,7 +14,8 @@ __noinline int foo(const struct S *s)
 }
 
 SEC("cgroup_skb/ingress")
-int test_cls(struct __sk_buff *skb)
+__failure __msg("Caller passes invalid args into func#1")
+int global_func11(struct __sk_buff *skb)
 {
 	return foo((const void *)skb);
 }
diff --git a/tools/testing/selftests/bpf/progs/test_global_func12.c b/tools/testing/selftests/bpf/progs/test_global_func12.c
index 62343527cc59..7f159d83c6f6 100644
--- a/tools/testing/selftests/bpf/progs/test_global_func12.c
+++ b/tools/testing/selftests/bpf/progs/test_global_func12.c
@@ -2,6 +2,7 @@
 #include <stddef.h>
 #include <linux/bpf.h>
 #include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
 
 struct S {
 	int x;
@@ -13,7 +14,8 @@ __noinline int foo(const struct S *s)
 }
 
 SEC("cgroup_skb/ingress")
-int test_cls(struct __sk_buff *skb)
+__failure __msg("invalid mem access 'mem_or_null'")
+int global_func12(struct __sk_buff *skb)
 {
 	const struct S s = {.x = skb->len };
 
diff --git a/tools/testing/selftests/bpf/progs/test_global_func13.c b/tools/testing/selftests/bpf/progs/test_global_func13.c
index ff8897c1ac22..02ea80da75b5 100644
--- a/tools/testing/selftests/bpf/progs/test_global_func13.c
+++ b/tools/testing/selftests/bpf/progs/test_global_func13.c
@@ -2,6 +2,7 @@
 #include <stddef.h>
 #include <linux/bpf.h>
 #include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
 
 struct S {
 	int x;
@@ -16,7 +17,8 @@ __noinline int foo(const struct S *s)
 }
 
 SEC("cgroup_skb/ingress")
-int test_cls(struct __sk_buff *skb)
+__failure __msg("Caller passes invalid args into func#1")
+int global_func13(struct __sk_buff *skb)
 {
 	const struct S *s = (const struct S *)(0xbedabeda);
 
diff --git a/tools/testing/selftests/bpf/progs/test_global_func14.c b/tools/testing/selftests/bpf/progs/test_global_func14.c
index 698c77199ebf..33b7d5efd7b2 100644
--- a/tools/testing/selftests/bpf/progs/test_global_func14.c
+++ b/tools/testing/selftests/bpf/progs/test_global_func14.c
@@ -2,6 +2,7 @@
 #include <stddef.h>
 #include <linux/bpf.h>
 #include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
 
 struct S;
 
@@ -14,7 +15,8 @@ __noinline int foo(const struct S *s)
 }
 
 SEC("cgroup_skb/ingress")
-int test_cls(struct __sk_buff *skb)
+__failure __msg("reference type('FWD S') size cannot be determined")
+int global_func14(struct __sk_buff *skb)
 {
 
 	return foo(NULL);
diff --git a/tools/testing/selftests/bpf/progs/test_global_func15.c b/tools/testing/selftests/bpf/progs/test_global_func15.c
index c19c435988d5..b512d6a6c75e 100644
--- a/tools/testing/selftests/bpf/progs/test_global_func15.c
+++ b/tools/testing/selftests/bpf/progs/test_global_func15.c
@@ -2,6 +2,7 @@
 #include <stddef.h>
 #include <linux/bpf.h>
 #include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
 
 __noinline int foo(unsigned int *v)
 {
@@ -12,7 +13,8 @@ __noinline int foo(unsigned int *v)
 }
 
 SEC("cgroup_skb/ingress")
-int test_cls(struct __sk_buff *skb)
+__failure __msg("At program exit the register R0 has value")
+int global_func15(struct __sk_buff *skb)
 {
 	unsigned int v = 1;
 
diff --git a/tools/testing/selftests/bpf/progs/test_global_func16.c b/tools/testing/selftests/bpf/progs/test_global_func16.c
index 0312d1e8d8c0..e7206304632e 100644
--- a/tools/testing/selftests/bpf/progs/test_global_func16.c
+++ b/tools/testing/selftests/bpf/progs/test_global_func16.c
@@ -2,6 +2,7 @@
 #include <stddef.h>
 #include <linux/bpf.h>
 #include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
 
 __noinline int foo(int (*arr)[10])
 {
@@ -12,7 +13,8 @@ __noinline int foo(int (*arr)[10])
 }
 
 SEC("cgroup_skb/ingress")
-int test_cls(struct __sk_buff *skb)
+__failure __msg("invalid indirect read from stack")
+int global_func16(struct __sk_buff *skb)
 {
 	int array[10];
 
diff --git a/tools/testing/selftests/bpf/progs/test_global_func17.c b/tools/testing/selftests/bpf/progs/test_global_func17.c
index 2b8b9b8ba018..a32e11c7d933 100644
--- a/tools/testing/selftests/bpf/progs/test_global_func17.c
+++ b/tools/testing/selftests/bpf/progs/test_global_func17.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 #include <vmlinux.h>
 #include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
 
 __noinline int foo(int *p)
 {
@@ -10,7 +11,8 @@ __noinline int foo(int *p)
 const volatile int i;
 
 SEC("tc")
-int test_cls(struct __sk_buff *skb)
+__failure __msg("Caller passes invalid args into func#1")
+int global_func17(struct __sk_buff *skb)
 {
 	return foo((int *)&i);
 }
diff --git a/tools/testing/selftests/bpf/progs/test_global_func2.c b/tools/testing/selftests/bpf/progs/test_global_func2.c
index 2c18d82923a2..3dce97fb52a4 100644
--- a/tools/testing/selftests/bpf/progs/test_global_func2.c
+++ b/tools/testing/selftests/bpf/progs/test_global_func2.c
@@ -1,4 +1,45 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* Copyright (c) 2020 Facebook */
+#include <stddef.h>
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
 #define MAX_STACK (512 - 3 * 32)
-#include "test_global_func1.c"
+
+static __attribute__ ((noinline))
+int f0(int var, struct __sk_buff *skb)
+{
+	return skb->len;
+}
+
+__attribute__ ((noinline))
+int f1(struct __sk_buff *skb)
+{
+	volatile char buf[MAX_STACK] = {};
+
+	return f0(0, skb) + skb->len;
+}
+
+int f3(int, struct __sk_buff *skb, int);
+
+__attribute__ ((noinline))
+int f2(int val, struct __sk_buff *skb)
+{
+	return f1(skb) + f3(val, skb, 1);
+}
+
+__attribute__ ((noinline))
+int f3(int val, struct __sk_buff *skb, int var)
+{
+	volatile char buf[MAX_STACK] = {};
+
+	return skb->ifindex * val * var;
+}
+
+SEC("tc")
+__success
+int global_func2(struct __sk_buff *skb)
+{
+	return f0(1, skb) + f1(skb) + f2(2, skb) + f3(3, skb, 4);
+}
diff --git a/tools/testing/selftests/bpf/progs/test_global_func3.c b/tools/testing/selftests/bpf/progs/test_global_func3.c
index 01bf8275dfd6..142b682d3c2f 100644
--- a/tools/testing/selftests/bpf/progs/test_global_func3.c
+++ b/tools/testing/selftests/bpf/progs/test_global_func3.c
@@ -3,6 +3,7 @@
 #include <stddef.h>
 #include <linux/bpf.h>
 #include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
 
 __attribute__ ((noinline))
 int f1(struct __sk_buff *skb)
@@ -46,20 +47,15 @@ int f7(struct __sk_buff *skb)
 	return f6(skb);
 }
 
-#ifndef NO_FN8
 __attribute__ ((noinline))
 int f8(struct __sk_buff *skb)
 {
 	return f7(skb);
 }
-#endif
 
 SEC("tc")
-int test_cls(struct __sk_buff *skb)
+__failure __msg("the call stack of 8 frames")
+int global_func3(struct __sk_buff *skb)
 {
-#ifndef NO_FN8
 	return f8(skb);
-#else
-	return f7(skb);
-#endif
 }
diff --git a/tools/testing/selftests/bpf/progs/test_global_func4.c b/tools/testing/selftests/bpf/progs/test_global_func4.c
index 610f75edf276..1733d87ad3f3 100644
--- a/tools/testing/selftests/bpf/progs/test_global_func4.c
+++ b/tools/testing/selftests/bpf/progs/test_global_func4.c
@@ -1,4 +1,55 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* Copyright (c) 2020 Facebook */
-#define NO_FN8
-#include "test_global_func3.c"
+#include <stddef.h>
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+__attribute__ ((noinline))
+int f1(struct __sk_buff *skb)
+{
+	return skb->len;
+}
+
+__attribute__ ((noinline))
+int f2(int val, struct __sk_buff *skb)
+{
+	return f1(skb) + val;
+}
+
+__attribute__ ((noinline))
+int f3(int val, struct __sk_buff *skb, int var)
+{
+	return f2(var, skb) + val;
+}
+
+__attribute__ ((noinline))
+int f4(struct __sk_buff *skb)
+{
+	return f3(1, skb, 2);
+}
+
+__attribute__ ((noinline))
+int f5(struct __sk_buff *skb)
+{
+	return f4(skb);
+}
+
+__attribute__ ((noinline))
+int f6(struct __sk_buff *skb)
+{
+	return f5(skb);
+}
+
+__attribute__ ((noinline))
+int f7(struct __sk_buff *skb)
+{
+	return f6(skb);
+}
+
+SEC("tc")
+__success
+int global_func4(struct __sk_buff *skb)
+{
+	return f7(skb);
+}
diff --git a/tools/testing/selftests/bpf/progs/test_global_func5.c b/tools/testing/selftests/bpf/progs/test_global_func5.c
index 9248d03e0d06..cc55aedaf82d 100644
--- a/tools/testing/selftests/bpf/progs/test_global_func5.c
+++ b/tools/testing/selftests/bpf/progs/test_global_func5.c
@@ -3,6 +3,7 @@
 #include <stddef.h>
 #include <linux/bpf.h>
 #include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
 
 __attribute__ ((noinline))
 int f1(struct __sk_buff *skb)
@@ -25,7 +26,8 @@ int f3(int val, struct __sk_buff *skb)
 }
 
 SEC("tc")
-int test_cls(struct __sk_buff *skb)
+__failure __msg("expected pointer to ctx, but got PTR")
+int global_func5(struct __sk_buff *skb)
 {
 	return f1(skb) + f2(2, skb) + f3(3, skb);
 }
diff --git a/tools/testing/selftests/bpf/progs/test_global_func6.c b/tools/testing/selftests/bpf/progs/test_global_func6.c
index af8c78bdfb25..46c38c8f2cf0 100644
--- a/tools/testing/selftests/bpf/progs/test_global_func6.c
+++ b/tools/testing/selftests/bpf/progs/test_global_func6.c
@@ -3,6 +3,7 @@
 #include <stddef.h>
 #include <linux/bpf.h>
 #include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
 
 __attribute__ ((noinline))
 int f1(struct __sk_buff *skb)
@@ -25,7 +26,8 @@ int f3(int val, struct __sk_buff *skb)
 }
 
 SEC("tc")
-int test_cls(struct __sk_buff *skb)
+__failure __msg("modified ctx ptr R2")
+int global_func6(struct __sk_buff *skb)
 {
 	return f1(skb) + f2(2, skb) + f3(3, skb);
 }
diff --git a/tools/testing/selftests/bpf/progs/test_global_func7.c b/tools/testing/selftests/bpf/progs/test_global_func7.c
index 6cb8e2f5254c..f182febfde3c 100644
--- a/tools/testing/selftests/bpf/progs/test_global_func7.c
+++ b/tools/testing/selftests/bpf/progs/test_global_func7.c
@@ -3,6 +3,7 @@
 #include <stddef.h>
 #include <linux/bpf.h>
 #include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
 
 __attribute__ ((noinline))
 void foo(struct __sk_buff *skb)
@@ -11,7 +12,8 @@ void foo(struct __sk_buff *skb)
 }
 
 SEC("tc")
-int test_cls(struct __sk_buff *skb)
+__failure __msg("foo() doesn't return scalar")
+int global_func7(struct __sk_buff *skb)
 {
 	foo(skb);
 	return 0;
diff --git a/tools/testing/selftests/bpf/progs/test_global_func8.c b/tools/testing/selftests/bpf/progs/test_global_func8.c
index d55a6544b1ab..9b9c57fa2dd3 100644
--- a/tools/testing/selftests/bpf/progs/test_global_func8.c
+++ b/tools/testing/selftests/bpf/progs/test_global_func8.c
@@ -3,6 +3,7 @@
 #include <stddef.h>
 #include <linux/bpf.h>
 #include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
 
 __noinline int foo(struct __sk_buff *skb)
 {
@@ -10,7 +11,8 @@ __noinline int foo(struct __sk_buff *skb)
 }
 
 SEC("cgroup_skb/ingress")
-int test_cls(struct __sk_buff *skb)
+__success
+int global_func8(struct __sk_buff *skb)
 {
 	if (!foo(skb))
 		return 0;
diff --git a/tools/testing/selftests/bpf/progs/test_global_func9.c b/tools/testing/selftests/bpf/progs/test_global_func9.c
index bd233ddede98..1f2cb0159b8d 100644
--- a/tools/testing/selftests/bpf/progs/test_global_func9.c
+++ b/tools/testing/selftests/bpf/progs/test_global_func9.c
@@ -2,6 +2,7 @@
 #include <stddef.h>
 #include <linux/bpf.h>
 #include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
 
 struct S {
 	int x;
@@ -74,7 +75,8 @@ __noinline int quuz(int **p)
 }
 
 SEC("cgroup_skb/ingress")
-int test_cls(struct __sk_buff *skb)
+__success
+int global_func9(struct __sk_buff *skb)
 {
 	int result = 0;
 
-- 
2.30.2

