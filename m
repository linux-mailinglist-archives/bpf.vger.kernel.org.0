Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFB6A6A8D4D
	for <lists+bpf@lfdr.de>; Fri,  3 Mar 2023 00:50:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbjCBXu4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Thu, 2 Mar 2023 18:50:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjCBXuz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Mar 2023 18:50:55 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F80138B5E
        for <bpf@vger.kernel.org>; Thu,  2 Mar 2023 15:50:54 -0800 (PST)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 322KUadG013548
        for <bpf@vger.kernel.org>; Thu, 2 Mar 2023 15:50:53 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3p2tfhd0kd-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 02 Mar 2023 15:50:53 -0800
Received: from twshared37576.17.prn3.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Thu, 2 Mar 2023 15:50:51 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 4AE34291B7F84; Thu,  2 Mar 2023 15:50:49 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH bpf-next 15/17] selftests/bpf: add bpf_for_each(), bpf_for(), and bpf_repeat() macros
Date:   Thu, 2 Mar 2023 15:50:13 -0800
Message-ID: <20230302235015.2044271-16-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230302235015.2044271-1-andrii@kernel.org>
References: <20230302235015.2044271-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: YtDhXR47I5Eq9R6IdhLiXwjhTJffgzuS
X-Proofpoint-ORIG-GUID: YtDhXR47I5Eq9R6IdhLiXwjhTJffgzuS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-02_15,2023-03-02_02,2023-02-09_01
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
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
iterator and thanks to that manage to provide an ergonomic very close to
C language for construct. Typical integer loop would look like:

  int i;
  int arr[N];

  bpf_for(i, 0, N) {
  /* verifier will know that i >= 0 && i < N, so could be used to
   * directly access array elements with no extra checks
   */
   arr[i] = i;
  }

bpf_repeat() is very similar, but it doesn't expose iteration number and
is mean as a simple "repeat action N times":

  bpf_repeat(N) { /* whatever */ }

Note that break and continue inside the {} block work as expected.

bpf_for_each() is a generalization over any kind of BPF open-coded
iterator allowing to use for-each-like approach instead of calling
low-level bpf_iter_<type>_{new,next,destroy}() APIs explicitly. E.g.:

  struct cgroup *cg;

  bpf_for_each(cgroup, cg, some, input, args) {
      /* do something with each cg */
  }

Would call (right now hypothetical) bpf_iter_cgroup_{new,next,destroy}()
functions to form a loop over cgroups, where `some, input, args` are
passed verbatim into constructor as
bpf_iter_cgroup_new(&it, some, input, args).

As a demonstration, add pyperf variant based on bpf_for() loop.

Also clean up few tests that either included bpf_misc.h header
unnecessarily from user-space or included it before any common types are
defined.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 .../bpf/prog_tests/bpf_verif_scale.c          |  6 ++
 .../bpf/prog_tests/uprobe_autoattach.c        |  1 -
 tools/testing/selftests/bpf/progs/bpf_misc.h  | 76 +++++++++++++++++++
 tools/testing/selftests/bpf/progs/lsm.c       |  4 +-
 tools/testing/selftests/bpf/progs/pyperf.h    | 14 +++-
 .../selftests/bpf/progs/pyperf600_iter.c      |  7 ++
 .../selftests/bpf/progs/pyperf600_nounroll.c  |  3 -
 7 files changed, 101 insertions(+), 10 deletions(-)
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
index f704885aa534..08a791f307a6 100644
--- a/tools/testing/selftests/bpf/progs/bpf_misc.h
+++ b/tools/testing/selftests/bpf/progs/bpf_misc.h
@@ -75,5 +75,81 @@
 #define FUNC_REG_ARG_CNT 5
 #endif
 
+struct bpf_iter;
+
+extern int bpf_iter_num_new(struct bpf_iter *it__uninit, int start, int end) __ksym;
+extern int *bpf_iter_num_next(struct bpf_iter *it) __ksym;
+extern void bpf_iter_num_destroy(struct bpf_iter *it) __ksym;
+
+#ifndef bpf_for_each
+/* bpf_for_each(iter_kind, elem, args...) provides generic construct for using BPF
+ * open-coded iterators without having to write mundane explicit low-level
+ * loop. Instead, it provides for()-like generic construct that can be used
+ * pretty naturally. E.g., for some hypothetical cgroup iterator, you'd write:
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
+ */
+#define bpf_for_each(type, cur, args...) for (						  \
+	/* initialize and define destructor */						  \
+	struct bpf_iter ___it __attribute__((cleanup(bpf_iter_##type##_destroy))),	  \
+	/* ___p pointer is just to call bpf_iter_##type##_new() *once* to init ___it */	  \
+			*___p = (bpf_iter_##type##_new(&___it, ##args),		  \
+	/* this is a workaround for Clang bug: it currently doesn't emit BTF */		  \
+	/* for bpf_iter_##type##_destroy when used from cleanup() attribute */		  \
+				(void)bpf_iter_##type##_destroy, (void *)0);		  \
+	/* iteration and termination check */						  \
+	((cur = bpf_iter_##type##_next(&___it)));					  \
+	/* nothing here  */								  \
+)
+#endif /* bpf_for_each */
+
+#ifndef bpf_for
+/* bpf_for(i, start, end) proves to verifier that i is in [start, end) */
+#define bpf_for(i, start, end) for (							  \
+	/* initialize and define destructor */						  \
+	struct bpf_iter ___it __attribute__((cleanup(bpf_iter_num_destroy))),		  \
+	/* ___p pointer is necessary to call bpf_iter_num_new() *once* to init ___it */	  \
+			*___p = (bpf_iter_num_new(&___it, (start), (end)),		  \
+	/* this is a workaround for Clang bug: it currently doesn't emit BTF */		  \
+	/* for bpf_iter_num_destroy when used from cleanup() attribute */		  \
+				(void)bpf_iter_num_destroy, (void *)0);			  \
+	({										  \
+		/* iteration step */							  \
+		int *___t = bpf_iter_num_next(&___it);					  \
+		/* termination and bounds check */					  \
+		(___t && ((i) = *___t, i >= (start) && i < (end)));			  \
+	});										  \
+	/* nothing here  */								  \
+)
+#endif /* bpf_for */
+
+#ifndef bpf_repeat
+/* bpf_repeat(N) performs N iterations without exposing iteration number */
+#define bpf_repeat(N) for (								  \
+	/* initialize and define destructor */						  \
+	struct bpf_iter ___it __attribute__((cleanup(bpf_iter_num_destroy))),		  \
+	/* ___p pointer is necessary to call bpf_iter_num_new() *once* to init ___it */	  \
+			*___p = (bpf_iter_num_new(&___it, 0, (N)),			  \
+	/* this is a workaround for Clang bug: it currently doesn't emit BTF */		  \
+	/* for bpf_iter_num_destory when used from cleanup() attribute */		  \
+				(void)bpf_iter_num_destroy, (void *)0);			  \
+	bpf_iter_num_next(&___it);							  \
+	/* nothing here  */								  \
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
2.30.2

