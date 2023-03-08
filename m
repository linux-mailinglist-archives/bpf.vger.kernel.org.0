Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB25E6AFDA9
	for <lists+bpf@lfdr.de>; Wed,  8 Mar 2023 04:54:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbjCHDyk convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Tue, 7 Mar 2023 22:54:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbjCHDyj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 7 Mar 2023 22:54:39 -0500
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C150C984C0
        for <bpf@vger.kernel.org>; Tue,  7 Mar 2023 19:54:36 -0800 (PST)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 3281EKFR022301
        for <bpf@vger.kernel.org>; Tue, 7 Mar 2023 19:54:36 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net (PPS) with ESMTPS id 3p6fh0h3wb-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 07 Mar 2023 19:54:35 -0800
Received: from twshared16996.15.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Tue, 7 Mar 2023 19:54:34 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 13004298A558D; Tue,  7 Mar 2023 19:54:28 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@meta.com>,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH v4 bpf-next 5/8] selftests/bpf: add bpf_for_each(), bpf_for(), and bpf_repeat() macros
Date:   Tue, 7 Mar 2023 19:54:13 -0800
Message-ID: <20230308035416.2591326-6-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230308035416.2591326-1-andrii@kernel.org>
References: <20230308035416.2591326-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: Iu6e5ps48Oh4dCFAiz3A8kLVloeNW2Tz
X-Proofpoint-GUID: Iu6e5ps48Oh4dCFAiz3A8kLVloeNW2Tz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-07_18,2023-03-07_01,2023-02-09_01
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add bpf_for_each(), bpf_for() and bpf_repeat() macros that make writing
open-coded iterator-based loops much more convenient and natural. These
macro utilize cleanup attribute to ensure proper destruction of the
iterator and thanks to that manage to provide an ergonomics very close to
C language's for() construct. Typical integer loop would look like:

  int i;
  int arr[N];

  bpf_for(i, 0, N) {
      /* verifier will know that i >= 0 && i < N, so could be used to
       * directly access array elements with no extra checks
       */
       arr[i] = i;
  }

bpf_repeat() is very similar, but it doesn't expose iteration number and
is meant as a simple "repeat action N times" loop:

  bpf_repeat(N) { /* whatever, N times */ }

Note that `break` and `continue` statements inside the {} block work as
expected.

bpf_for_each() is a generalization over any kind of BPF open-coded
iterator allowing to use for-each-like approach instead of calling
low-level bpf_iter_<type>_{new,next,destroy}() APIs explicitly. E.g.:

  struct cgroup *cg;

  bpf_for_each(cgroup, cg, some, input, args) {
      /* do something with each cg */
  }

would call (right now hypothetical) bpf_iter_cgroup_{new,next,destroy}()
functions to form a loop over cgroups, where `some, input, args` are
passed verbatim into constructor as

  bpf_iter_cgroup_new(&it, some, input, args).

As a demonstration, add pyperf variant based on bpf_for() loop.

Also clean up a few tests that either included bpf_misc.h header
unnecessarily from user-space or included it before any common types are
defined.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 .../bpf/prog_tests/bpf_verif_scale.c          |  6 ++
 .../bpf/prog_tests/uprobe_autoattach.c        |  1 -
 tools/testing/selftests/bpf/progs/bpf_misc.h  | 99 +++++++++++++++++++
 tools/testing/selftests/bpf/progs/lsm.c       |  4 +-
 tools/testing/selftests/bpf/progs/pyperf.h    | 14 ++-
 .../selftests/bpf/progs/pyperf600_iter.c      |  7 ++
 .../selftests/bpf/progs/pyperf600_nounroll.c  |  3 -
 7 files changed, 124 insertions(+), 10 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/pyperf600_iter.c

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_verif_scale.c b/tools/testing/selftests/bpf/prog_tests/bpf_verif_scale.c
index 5ca252823294..731c343897d8 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_verif_scale.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_verif_scale.c
@@ -144,6 +144,12 @@ void test_verif_scale_pyperf600_nounroll()
 	scale_test("pyperf600_nounroll.bpf.o", BPF_PROG_TYPE_RAW_TRACEPOINT, false);
 }
 
+void test_verif_scale_pyperf600_iter()
+{
+	/* open-coded BPF iterator version */
+	scale_test("pyperf600_iter.bpf.o", BPF_PROG_TYPE_RAW_TRACEPOINT, false);
+}
+
 void test_verif_scale_loop1()
 {
 	scale_test("loop1.bpf.o", BPF_PROG_TYPE_RAW_TRACEPOINT, false);
diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_autoattach.c b/tools/testing/selftests/bpf/prog_tests/uprobe_autoattach.c
index 6558c857e620..d5b3377aa33c 100644
--- a/tools/testing/selftests/bpf/prog_tests/uprobe_autoattach.c
+++ b/tools/testing/selftests/bpf/prog_tests/uprobe_autoattach.c
@@ -3,7 +3,6 @@
 
 #include <test_progs.h>
 #include "test_uprobe_autoattach.skel.h"
-#include "progs/bpf_misc.h"
 
 /* uprobe attach point */
 static noinline int autoattach_trigger_func(int arg1, int arg2, int arg3,
diff --git a/tools/testing/selftests/bpf/progs/bpf_misc.h b/tools/testing/selftests/bpf/progs/bpf_misc.h
index f704885aa534..597688a188ae 100644
--- a/tools/testing/selftests/bpf/progs/bpf_misc.h
+++ b/tools/testing/selftests/bpf/progs/bpf_misc.h
@@ -75,5 +75,104 @@
 #define FUNC_REG_ARG_CNT 5
 #endif
 
+struct bpf_iter_num;
+
+extern int bpf_iter_num_new(struct bpf_iter_num *it, int start, int end) __ksym;
+extern int *bpf_iter_num_next(struct bpf_iter_num *it) __ksym;
+extern void bpf_iter_num_destroy(struct bpf_iter_num *it) __ksym;
+
+#ifndef bpf_for_each
+/* bpf_for_each(iter_type, cur_elem, args...) provides generic construct for
+ * using BPF open-coded iterators without having to write mundane explicit
+ * low-level loop logic. Instead, it provides for()-like generic construct
+ * that can be used pretty naturally. E.g., for some hypothetical cgroup
+ * iterator, you'd write:
+ *
+ * struct cgroup *cg, *parent_cg = <...>;
+ *
+ * bpf_for_each(cgroup, cg, parent_cg, CG_ITER_CHILDREN) {
+ *     bpf_printk("Child cgroup id = %d", cg->cgroup_id);
+ *     if (cg->cgroup_id == 123)
+ *         break;
+ * }
+ *
+ * I.e., it looks almost like high-level for each loop in other languages,
+ * supports continue/break, and is verifiable by BPF verifier.
+ *
+ * For iterating integers, the difference betwen bpf_for_each(num, i, N, M)
+ * and bpf_for(i, N, M) is in that bpf_for() provides additional proof to
+ * verifier that i is in [N, M) range, and in bpf_for_each() case i is `int
+ * *`, not just `int`. So for integers bpf_for() is more convenient.
+ *
+ * Note: this macro relies on C99 feature of allowing to declare variables
+ * inside for() loop, bound to for() loop lifetime. It also utilizes GCC
+ * extension: __attribute__((cleanup(<func>))), supported by both GCC and
+ * Clang.
+ */
+#define bpf_for_each(type, cur, args...) for (							\
+	/* initialize and define destructor */							\
+	struct bpf_iter_##type ___it __attribute__((aligned(8), /* enforce, just in case */,	\
+						    cleanup(bpf_iter_##type##_destroy))),	\
+	/* ___p pointer is just to call bpf_iter_##type##_new() *once* to init ___it */		\
+			       *___p = (bpf_iter_##type##_new(&___it, ##args),			\
+	/* this is a workaround for Clang bug: it currently doesn't emit BTF */			\
+	/* for bpf_iter_##type##_destroy() when used from cleanup() attribute */		\
+					(void)bpf_iter_##type##_destroy, (void *)0);		\
+	/* iteration and termination check */							\
+	(((cur) = bpf_iter_##type##_next(&___it)));						\
+)
+#endif /* bpf_for_each */
+
+#ifndef bpf_for
+/* bpf_for(i, start, end) implements a for()-like looping construct that sets
+ * provided integer variable *i* to values starting from *start* through,
+ * but not including, *end*. It also proves to BPF verifier that *i* belongs
+ * to range [start, end), so this can be used for accessing arrays without
+ * extra checks.
+ *
+ * Note: *start* and *end* are assumed to be expressions with no side effects
+ * and whose values do not change throughout bpf_for() loop execution. They do
+ * not have to be statically known or constant, though.
+ *
+ * Note: similarly to bpf_for_each(), it relies on C99 feature of declaring for()
+ * loop bound variables and cleanup attribute, supported by GCC and Clang.
+ */
+#define bpf_for(i, start, end) for (								\
+	/* initialize and define destructor */							\
+	struct bpf_iter_num ___it __attribute__((aligned(8), /* enforce, just in case */	\
+						 cleanup(bpf_iter_num_destroy))),		\
+	/* ___p pointer is necessary to call bpf_iter_num_new() *once* to init ___it */		\
+			    *___p = (bpf_iter_num_new(&___it, (start), (end)),			\
+	/* this is a workaround for Clang bug: it currently doesn't emit BTF */			\
+	/* for bpf_iter_num_destroy() when used from cleanup() attribute */			\
+				(void)bpf_iter_num_destroy, (void *)0);				\
+	({											\
+		/* iteration step */								\
+		int *___t = bpf_iter_num_next(&___it);						\
+		/* termination and bounds check */						\
+		(___t && ((i) = *___t, (i) >= (start) && (i) < (end)));				\
+	});											\
+)
+#endif /* bpf_for */
+
+#ifndef bpf_repeat
+/* bpf_repeat(N) performs N iterations without exposing iteration number
+ *
+ * Note: similarly to bpf_for_each(), it relies on C99 feature of declaring for()
+ * loop bound variables and cleanup attribute, supported by GCC and Clang.
+ */
+#define bpf_repeat(N) for (									\
+	/* initialize and define destructor */							\
+	struct bpf_iter_num ___it __attribute__((aligned(8), /* enforce, just in case */	\
+						 cleanup(bpf_iter_num_destroy))),		\
+	/* ___p pointer is necessary to call bpf_iter_num_new() *once* to init ___it */		\
+			    *___p = (bpf_iter_num_new(&___it, 0, (N)),				\
+	/* this is a workaround for Clang bug: it currently doesn't emit BTF */			\
+	/* for bpf_iter_num_destroy() when used from cleanup() attribute */			\
+				(void)bpf_iter_num_destroy, (void *)0);				\
+	bpf_iter_num_next(&___it);								\
+	/* nothing here  */									\
+)
+#endif /* bpf_repeat */
 
 #endif
diff --git a/tools/testing/selftests/bpf/progs/lsm.c b/tools/testing/selftests/bpf/progs/lsm.c
index dc93887ed34c..fadfdd98707c 100644
--- a/tools/testing/selftests/bpf/progs/lsm.c
+++ b/tools/testing/selftests/bpf/progs/lsm.c
@@ -4,12 +4,12 @@
  * Copyright 2020 Google LLC.
  */
 
-#include "bpf_misc.h"
 #include "vmlinux.h"
+#include <errno.h>
 #include <bpf/bpf_core_read.h>
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
-#include <errno.h>
+#include "bpf_misc.h"
 
 struct {
 	__uint(type, BPF_MAP_TYPE_ARRAY);
diff --git a/tools/testing/selftests/bpf/progs/pyperf.h b/tools/testing/selftests/bpf/progs/pyperf.h
index 6c7b1fb268d6..f2e7a31c8d75 100644
--- a/tools/testing/selftests/bpf/progs/pyperf.h
+++ b/tools/testing/selftests/bpf/progs/pyperf.h
@@ -7,6 +7,7 @@
 #include <stdbool.h>
 #include <linux/bpf.h>
 #include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
 
 #define FUNCTION_NAME_LEN 64
 #define FILE_NAME_LEN 128
@@ -294,17 +295,22 @@ int __on_event(struct bpf_raw_tracepoint_args *ctx)
 	if (ctx.done)
 		return 0;
 #else
-#ifdef NO_UNROLL
+#if defined(USE_ITER)
+/* no for loop, no unrolling */
+#elif defined(NO_UNROLL)
 #pragma clang loop unroll(disable)
-#else
-#ifdef UNROLL_COUNT
+#elif defined(UNROLL_COUNT)
 #pragma clang loop unroll_count(UNROLL_COUNT)
 #else
 #pragma clang loop unroll(full)
-#endif
 #endif /* NO_UNROLL */
 		/* Unwind python stack */
+#ifdef USE_ITER
+		int i;
+		bpf_for(i, 0, STACK_MAX_LEN) {
+#else /* !USE_ITER */
 		for (int i = 0; i < STACK_MAX_LEN; ++i) {
+#endif
 			if (frame_ptr && get_frame_data(frame_ptr, pidData, &frame, &sym)) {
 				int32_t new_symbol_id = *symbol_counter * 64 + cur_cpu;
 				int32_t *symbol_id = bpf_map_lookup_elem(&symbolmap, &sym);
diff --git a/tools/testing/selftests/bpf/progs/pyperf600_iter.c b/tools/testing/selftests/bpf/progs/pyperf600_iter.c
new file mode 100644
index 000000000000..d62e1b200c30
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/pyperf600_iter.c
@@ -0,0 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2023 Meta Platforms, Inc. and affiliates.
+#define STACK_MAX_LEN 600
+#define SUBPROGS
+#define NO_UNROLL
+#define USE_ITER
+#include "pyperf.h"
diff --git a/tools/testing/selftests/bpf/progs/pyperf600_nounroll.c b/tools/testing/selftests/bpf/progs/pyperf600_nounroll.c
index 6beff7502f4d..520b58c4f8db 100644
--- a/tools/testing/selftests/bpf/progs/pyperf600_nounroll.c
+++ b/tools/testing/selftests/bpf/progs/pyperf600_nounroll.c
@@ -2,7 +2,4 @@
 // Copyright (c) 2019 Facebook
 #define STACK_MAX_LEN 600
 #define NO_UNROLL
-/* clang will not unroll at all.
- * Total program size is around 2k insns
- */
 #include "pyperf.h"
-- 
2.34.1

