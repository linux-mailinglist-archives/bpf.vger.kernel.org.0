Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DBAD6B1132
	for <lists+bpf@lfdr.de>; Wed,  8 Mar 2023 19:41:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbjCHSlr convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Wed, 8 Mar 2023 13:41:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbjCHSlq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Mar 2023 13:41:46 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43006ADC11
        for <bpf@vger.kernel.org>; Wed,  8 Mar 2023 10:41:42 -0800 (PST)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 328I0FhL014157
        for <bpf@vger.kernel.org>; Wed, 8 Mar 2023 10:41:41 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3p6ffbdweq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 08 Mar 2023 10:41:41 -0800
Received: from twshared38955.16.prn3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Wed, 8 Mar 2023 10:41:40 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id B157C299B75ED; Wed,  8 Mar 2023 10:41:34 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@meta.com>,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH v5 bpf-next 6/8] selftests/bpf: add iterators tests
Date:   Wed, 8 Mar 2023 10:41:19 -0800
Message-ID: <20230308184121.1165081-7-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230308184121.1165081-1-andrii@kernel.org>
References: <20230308184121.1165081-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 8PSgJsrsXpjk8w3bUuRQyQCLt29taAVi
X-Proofpoint-ORIG-GUID: 8PSgJsrsXpjk8w3bUuRQyQCLt29taAVi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-08_12,2023-03-08_03,2023-02-09_01
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add various tests for open-coded iterators. Some of them excercise
various possible coding patterns in C, some go down to low-level
assembly for more control over various conditions, especially invalid
ones.

We also make use of bpf_for(), bpf_for_each(), bpf_repeat() macros in
some of these tests.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 .../testing/selftests/bpf/prog_tests/iters.c  |  15 +
 tools/testing/selftests/bpf/progs/bpf_misc.h  |   1 +
 tools/testing/selftests/bpf/progs/iters.c     | 720 ++++++++++++++++++
 .../selftests/bpf/progs/iters_looping.c       | 163 ++++
 .../selftests/bpf/progs/iters_state_safety.c  | 426 +++++++++++
 5 files changed, 1325 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/iters.c
 create mode 100644 tools/testing/selftests/bpf/progs/iters.c
 create mode 100644 tools/testing/selftests/bpf/progs/iters_looping.c
 create mode 100644 tools/testing/selftests/bpf/progs/iters_state_safety.c

diff --git a/tools/testing/selftests/bpf/prog_tests/iters.c b/tools/testing/selftests/bpf/prog_tests/iters.c
new file mode 100644
index 000000000000..414fb8d82145
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/iters.c
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2023 Meta Platforms, Inc. and affiliates. */
+
+#include <test_progs.h>
+
+#include "iters.skel.h"
+#include "iters_state_safety.skel.h"
+#include "iters_looping.skel.h"
+
+void test_iters(void)
+{
+	RUN_TESTS(iters_state_safety);
+	RUN_TESTS(iters_looping);
+	RUN_TESTS(iters);
+}
diff --git a/tools/testing/selftests/bpf/progs/bpf_misc.h b/tools/testing/selftests/bpf/progs/bpf_misc.h
index 597688a188ae..43b154a639e7 100644
--- a/tools/testing/selftests/bpf/progs/bpf_misc.h
+++ b/tools/testing/selftests/bpf/progs/bpf_misc.h
@@ -36,6 +36,7 @@
 #define __clobber_common "r0", "r1", "r2", "r3", "r4", "r5", "memory"
 #define __imm(name) [name]"i"(name)
 #define __imm_addr(name) [name]"i"(&name)
+#define __imm_ptr(name) [name]"p"(&name)
 
 #if defined(__TARGET_ARCH_x86)
 #define SYSCALL_WRAPPER 1
diff --git a/tools/testing/selftests/bpf/progs/iters.c b/tools/testing/selftests/bpf/progs/iters.c
new file mode 100644
index 000000000000..84e5dc10243c
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/iters.c
@@ -0,0 +1,720 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2023 Meta Platforms, Inc. and affiliates. */
+
+#include <stdbool.h>
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
+
+static volatile int zero = 0;
+
+int my_pid;
+int arr[256];
+int small_arr[16] SEC(".data.small_arr");
+
+#ifdef REAL_TEST
+#define MY_PID_GUARD() if (my_pid != (bpf_get_current_pid_tgid() >> 32)) return 0
+#else
+#define MY_PID_GUARD() ({ })
+#endif
+
+SEC("?raw_tp")
+__failure __msg("math between map_value pointer and register with unbounded min value is not allowed")
+int iter_err_unsafe_c_loop(const void *ctx)
+{
+	struct bpf_iter_num it;
+	int *v, i = zero; /* obscure initial value of i */
+
+	MY_PID_GUARD();
+
+	bpf_iter_num_new(&it, 0, 1000);
+	while ((v = bpf_iter_num_next(&it))) {
+		i++;
+	}
+	bpf_iter_num_destroy(&it);
+
+	small_arr[i] = 123; /* invalid */
+
+	return 0;
+}
+
+SEC("?raw_tp")
+__failure __msg("unbounded memory access")
+int iter_err_unsafe_asm_loop(const void *ctx)
+{
+	struct bpf_iter_num it;
+	int *v, i = 0;
+
+	MY_PID_GUARD();
+
+	asm volatile (
+		"r6 = %[zero];" /* iteration counter */
+		"r1 = %[it];" /* iterator state */
+		"r2 = 0;"
+		"r3 = 1000;"
+		"r4 = 1;"
+		"call %[bpf_iter_num_new];"
+	"loop:"
+		"r1 = %[it];"
+		"call %[bpf_iter_num_next];"
+		"if r0 == 0 goto out;"
+		"r6 += 1;"
+		"goto loop;"
+	"out:"
+		"r1 = %[it];"
+		"call %[bpf_iter_num_destroy];"
+		"r1 = %[small_arr];"
+		"r2 = r6;"
+		"r2 <<= 2;"
+		"r1 += r2;"
+		"*(u32 *)(r1 + 0) = r6;" /* invalid */
+		:
+		: [it]"r"(&it),
+		  [small_arr]"p"(small_arr),
+		  [zero]"p"(zero),
+		  __imm(bpf_iter_num_new),
+		  __imm(bpf_iter_num_next),
+		  __imm(bpf_iter_num_destroy)
+		: __clobber_common, "r6"
+	);
+
+	return 0;
+}
+
+SEC("raw_tp")
+__success
+int iter_while_loop(const void *ctx)
+{
+	struct bpf_iter_num it;
+	int *v, i;
+
+	MY_PID_GUARD();
+
+	bpf_iter_num_new(&it, 0, 3);
+	while ((v = bpf_iter_num_next(&it))) {
+		bpf_printk("ITER_BASIC: E1 VAL: v=%d", *v);
+	}
+	bpf_iter_num_destroy(&it);
+
+	return 0;
+}
+
+SEC("raw_tp")
+__success
+int iter_while_loop_auto_cleanup(const void *ctx)
+{
+	__attribute__((cleanup(bpf_iter_num_destroy))) struct bpf_iter_num it;
+	int *v, i;
+
+	MY_PID_GUARD();
+
+	bpf_iter_num_new(&it, 0, 3);
+	while ((v = bpf_iter_num_next(&it))) {
+		bpf_printk("ITER_BASIC: E1 VAL: v=%d", *v);
+	}
+	/* (!) no explicit bpf_iter_num_destroy() */
+
+	return 0;
+}
+
+SEC("raw_tp")
+__success
+int iter_for_loop(const void *ctx)
+{
+	struct bpf_iter_num it;
+	int *v, i;
+
+	MY_PID_GUARD();
+
+	bpf_iter_num_new(&it, 5, 10);
+	for (v = bpf_iter_num_next(&it); v; v = bpf_iter_num_next(&it)) {
+		bpf_printk("ITER_BASIC: E2 VAL: v=%d", *v);
+	}
+	bpf_iter_num_destroy(&it);
+
+	return 0;
+}
+
+SEC("raw_tp")
+__success
+int iter_bpf_for_each_macro(const void *ctx)
+{
+	int *v;
+
+	MY_PID_GUARD();
+
+	bpf_for_each(num, v, 5, 10) {
+		bpf_printk("ITER_BASIC: E2 VAL: v=%d", *v);
+	}
+
+	return 0;
+}
+
+SEC("raw_tp")
+__success
+int iter_bpf_for_macro(const void *ctx)
+{
+	int i;
+
+	MY_PID_GUARD();
+
+	bpf_for(i, 5, 10) {
+		bpf_printk("ITER_BASIC: E2 VAL: v=%d", i);
+	}
+
+	return 0;
+}
+
+SEC("raw_tp")
+__success
+int iter_pragma_unroll_loop(const void *ctx)
+{
+	struct bpf_iter_num it;
+	int *v, i;
+
+	MY_PID_GUARD();
+
+	bpf_iter_num_new(&it, 0, 2);
+#pragma nounroll
+	for (i = 0; i < 3; i++) {
+		v = bpf_iter_num_next(&it);
+		bpf_printk("ITER_BASIC: E3 VAL: i=%d v=%d", i, v ? *v : -1);
+	}
+	bpf_iter_num_destroy(&it);
+
+	return 0;
+}
+
+SEC("raw_tp")
+__success
+int iter_manual_unroll_loop(const void *ctx)
+{
+	struct bpf_iter_num it;
+	int *v, i;
+
+	MY_PID_GUARD();
+
+	bpf_iter_num_new(&it, 100, 200);
+	v = bpf_iter_num_next(&it);
+	bpf_printk("ITER_BASIC: E4 VAL: v=%d", v ? *v : -1);
+	v = bpf_iter_num_next(&it);
+	bpf_printk("ITER_BASIC: E4 VAL: v=%d", v ? *v : -1);
+	v = bpf_iter_num_next(&it);
+	bpf_printk("ITER_BASIC: E4 VAL: v=%d", v ? *v : -1);
+	v = bpf_iter_num_next(&it);
+	bpf_printk("ITER_BASIC: E4 VAL: v=%d\n", v ? *v : -1);
+	bpf_iter_num_destroy(&it);
+
+	return 0;
+}
+
+SEC("raw_tp")
+__success
+int iter_multiple_sequential_loops(const void *ctx)
+{
+	struct bpf_iter_num it;
+	int *v, i;
+
+	MY_PID_GUARD();
+
+	bpf_iter_num_new(&it, 0, 3);
+	while ((v = bpf_iter_num_next(&it))) {
+		bpf_printk("ITER_BASIC: E1 VAL: v=%d", *v);
+	}
+	bpf_iter_num_destroy(&it);
+
+	bpf_iter_num_new(&it, 5, 10);
+	for (v = bpf_iter_num_next(&it); v; v = bpf_iter_num_next(&it)) {
+		bpf_printk("ITER_BASIC: E2 VAL: v=%d", *v);
+	}
+	bpf_iter_num_destroy(&it);
+
+	bpf_iter_num_new(&it, 0, 2);
+#pragma nounroll
+	for (i = 0; i < 3; i++) {
+		v = bpf_iter_num_next(&it);
+		bpf_printk("ITER_BASIC: E3 VAL: i=%d v=%d", i, v ? *v : -1);
+	}
+	bpf_iter_num_destroy(&it);
+
+	bpf_iter_num_new(&it, 100, 200);
+	v = bpf_iter_num_next(&it);
+	bpf_printk("ITER_BASIC: E4 VAL: v=%d", v ? *v : -1);
+	v = bpf_iter_num_next(&it);
+	bpf_printk("ITER_BASIC: E4 VAL: v=%d", v ? *v : -1);
+	v = bpf_iter_num_next(&it);
+	bpf_printk("ITER_BASIC: E4 VAL: v=%d", v ? *v : -1);
+	v = bpf_iter_num_next(&it);
+	bpf_printk("ITER_BASIC: E4 VAL: v=%d\n", v ? *v : -1);
+	bpf_iter_num_destroy(&it);
+
+	return 0;
+}
+
+SEC("raw_tp")
+__success
+int iter_limit_cond_break_loop(const void *ctx)
+{
+	struct bpf_iter_num it;
+	int *v, i = 0, sum = 0;
+
+	MY_PID_GUARD();
+
+	bpf_iter_num_new(&it, 0, 10);
+	while ((v = bpf_iter_num_next(&it))) {
+		bpf_printk("ITER_SIMPLE: i=%d v=%d", i, *v);
+		sum += *v;
+
+		i++;
+		if (i > 3)
+			break;
+	}
+	bpf_iter_num_destroy(&it);
+
+	bpf_printk("ITER_SIMPLE: sum=%d\n", sum);
+
+	return 0;
+}
+
+SEC("raw_tp")
+__success
+int iter_obfuscate_counter(const void *ctx)
+{
+	struct bpf_iter_num it;
+	int *v, sum = 0;
+	/* Make i's initial value unknowable for verifier to prevent it from
+	 * pruning if/else branch inside the loop body and marking i as precise.
+	 */
+	int i = zero;
+
+	MY_PID_GUARD();
+
+	bpf_iter_num_new(&it, 0, 10);
+	while ((v = bpf_iter_num_next(&it))) {
+		int x;
+
+		i += 1;
+
+		/* If we initialized i as `int i = 0;` above, verifier would
+		 * track that i becomes 1 on first iteration after increment
+		 * above, and here verifier would eagerly prune else branch
+		 * and mark i as precise, ruining open-coded iterator logic
+		 * completely, as each next iteration would have a different
+		 * *precise* value of i, and thus there would be no
+		 * convergence of state. This would result in reaching maximum
+		 * instruction limit, no matter what the limit is.
+		 */
+		if (i == 1)
+			x = 123;
+		else
+			x = i * 3 + 1;
+
+		bpf_printk("ITER_OBFUSCATE_COUNTER: i=%d v=%d x=%d", i, *v, x);
+
+		sum += x;
+	}
+	bpf_iter_num_destroy(&it);
+
+	bpf_printk("ITER_OBFUSCATE_COUNTER: sum=%d\n", sum);
+
+	return 0;
+}
+
+SEC("raw_tp")
+__success
+int iter_search_loop(const void *ctx)
+{
+	struct bpf_iter_num it;
+	int *v, *elem = NULL;
+	bool found = false;
+
+	MY_PID_GUARD();
+
+	bpf_iter_num_new(&it, 0, 10);
+
+	while ((v = bpf_iter_num_next(&it))) {
+		bpf_printk("ITER_SEARCH_LOOP: v=%d", *v);
+
+		if (*v == 2) {
+			found = true;
+			elem = v;
+			barrier_var(elem);
+		}
+	}
+
+	/* should fail to verify if bpf_iter_num_destroy() is here */
+
+	if (found)
+		/* here found element will be wrong, we should have copied
+		 * value to a variable, but here we want to make sure we can
+		 * access memory after the loop anyways
+		 */
+		bpf_printk("ITER_SEARCH_LOOP: FOUND IT = %d!\n", *elem);
+	else
+		bpf_printk("ITER_SEARCH_LOOP: NOT FOUND IT!\n");
+
+	bpf_iter_num_destroy(&it);
+
+	return 0;
+}
+
+SEC("raw_tp")
+__success
+int iter_array_fill(const void *ctx)
+{
+	int sum, i;
+
+	MY_PID_GUARD();
+
+	bpf_for(i, 0, ARRAY_SIZE(arr)) {
+		arr[i] = i * 2;
+	}
+
+	sum = 0;
+	bpf_for(i, 0, ARRAY_SIZE(arr)) {
+		sum += arr[i];
+	}
+
+	bpf_printk("ITER_ARRAY_FILL: sum=%d (should be %d)\n", sum, 255 * 256);
+
+	return 0;
+}
+
+static int arr2d[4][5];
+static int arr2d_row_sums[4];
+static int arr2d_col_sums[5];
+
+SEC("raw_tp")
+__success
+int iter_nested_iters(const void *ctx)
+{
+	int sum, row, col;
+
+	MY_PID_GUARD();
+
+	bpf_for(row, 0, ARRAY_SIZE(arr2d)) {
+		bpf_for( col, 0, ARRAY_SIZE(arr2d[0])) {
+			arr2d[row][col] = row * col;
+		}
+	}
+
+	/* zero-initialize sums */
+	sum = 0;
+	bpf_for(row, 0, ARRAY_SIZE(arr2d)) {
+		arr2d_row_sums[row] = 0;
+	}
+	bpf_for(col, 0, ARRAY_SIZE(arr2d[0])) {
+		arr2d_col_sums[col] = 0;
+	}
+
+	/* calculate sums */
+	bpf_for(row, 0, ARRAY_SIZE(arr2d)) {
+		bpf_for(col, 0, ARRAY_SIZE(arr2d[0])) {
+			sum += arr2d[row][col];
+			arr2d_row_sums[row] += arr2d[row][col];
+			arr2d_col_sums[col] += arr2d[row][col];
+		}
+	}
+
+	bpf_printk("ITER_NESTED_ITERS: total sum=%d", sum);
+	bpf_for(row, 0, ARRAY_SIZE(arr2d)) {
+		bpf_printk("ITER_NESTED_ITERS: row #%d sum=%d", row, arr2d_row_sums[row]);
+	}
+	bpf_for(col, 0, ARRAY_SIZE(arr2d[0])) {
+		bpf_printk("ITER_NESTED_ITERS: col #%d sum=%d%s",
+			   col, arr2d_col_sums[col],
+			   col == ARRAY_SIZE(arr2d[0]) - 1 ? "\n" : "");
+	}
+
+	return 0;
+}
+
+SEC("raw_tp")
+__success
+int iter_nested_deeply_iters(const void *ctx)
+{
+	int sum = 0;
+
+	MY_PID_GUARD();
+
+	bpf_repeat(10) {
+		bpf_repeat(10) {
+			bpf_repeat(10) {
+				bpf_repeat(10) {
+					bpf_repeat(10) {
+						sum += 1;
+					}
+				}
+			}
+		}
+		/* validate that we can break from inside bpf_repeat() */
+		break;
+	}
+
+	return sum;
+}
+
+static __noinline void fill_inner_dimension(int row)
+{
+	int col;
+
+	bpf_for(col, 0, ARRAY_SIZE(arr2d[0])) {
+		arr2d[row][col] = row * col;
+	}
+}
+
+static __noinline int sum_inner_dimension(int row)
+{
+	int sum = 0, col;
+
+	bpf_for(col, 0, ARRAY_SIZE(arr2d[0])) {
+		sum += arr2d[row][col];
+		arr2d_row_sums[row] += arr2d[row][col];
+		arr2d_col_sums[col] += arr2d[row][col];
+	}
+
+	return sum;
+}
+
+SEC("raw_tp")
+__success
+int iter_subprog_iters(const void *ctx)
+{
+	int sum, row, col;
+
+	MY_PID_GUARD();
+
+	bpf_for(row, 0, ARRAY_SIZE(arr2d)) {
+		fill_inner_dimension(row);
+	}
+
+	/* zero-initialize sums */
+	sum = 0;
+	bpf_for(row, 0, ARRAY_SIZE(arr2d)) {
+		arr2d_row_sums[row] = 0;
+	}
+	bpf_for(col, 0, ARRAY_SIZE(arr2d[0])) {
+		arr2d_col_sums[col] = 0;
+	}
+
+	/* calculate sums */
+	bpf_for(row, 0, ARRAY_SIZE(arr2d)) {
+		sum += sum_inner_dimension(row);
+	}
+
+	bpf_printk("ITER_SUBPROG_ITERS: total sum=%d", sum);
+	bpf_for(row, 0, ARRAY_SIZE(arr2d)) {
+		bpf_printk("ITER_SUBPROG_ITERS: row #%d sum=%d",
+			   row, arr2d_row_sums[row]);
+	}
+	bpf_for(col, 0, ARRAY_SIZE(arr2d[0])) {
+		bpf_printk("ITER_SUBPROG_ITERS: col #%d sum=%d%s",
+			   col, arr2d_col_sums[col],
+			   col == ARRAY_SIZE(arr2d[0]) - 1 ? "\n" : "");
+	}
+
+	return 0;
+}
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__type(key, int);
+	__type(value, int);
+	__uint(max_entries, 1000);
+} arr_map SEC(".maps");
+
+SEC("?raw_tp")
+__failure __msg("invalid mem access 'scalar'")
+int iter_err_too_permissive1(const void *ctx)
+{
+	int *map_val = NULL;
+	int key = 0;
+
+	MY_PID_GUARD();
+
+	map_val = bpf_map_lookup_elem(&arr_map, &key);
+	if (!map_val)
+		return 0;
+
+	bpf_repeat(1000000) {
+		map_val = NULL;
+	}
+
+	*map_val = 123;
+
+	return 0;
+}
+
+SEC("?raw_tp")
+__failure __msg("invalid mem access 'map_value_or_null'")
+int iter_err_too_permissive2(const void *ctx)
+{
+	int *map_val = NULL;
+	int key = 0;
+
+	MY_PID_GUARD();
+
+	map_val = bpf_map_lookup_elem(&arr_map, &key);
+	if (!map_val)
+		return 0;
+
+	bpf_repeat(1000000) {
+		map_val = bpf_map_lookup_elem(&arr_map, &key);
+	}
+
+	*map_val = 123;
+
+	return 0;
+}
+
+SEC("?raw_tp")
+__failure __msg("invalid mem access 'map_value_or_null'")
+int iter_err_too_permissive3(const void *ctx)
+{
+	int *map_val = NULL;
+	int key = 0;
+	bool found = false;
+
+	MY_PID_GUARD();
+
+	bpf_repeat(1000000) {
+		map_val = bpf_map_lookup_elem(&arr_map, &key);
+		found = true;
+	}
+
+	if (found)
+		*map_val = 123;
+
+	return 0;
+}
+
+SEC("raw_tp")
+__success
+int iter_tricky_but_fine(const void *ctx)
+{
+	int *map_val = NULL;
+	int key = 0;
+	bool found = false;
+
+	MY_PID_GUARD();
+
+	bpf_repeat(1000000) {
+		map_val = bpf_map_lookup_elem(&arr_map, &key);
+		if (map_val) {
+			found = true;
+			break;
+		}
+	}
+
+	if (found)
+		*map_val = 123;
+
+	return 0;
+}
+
+#define __bpf_memzero(p, sz) bpf_probe_read_kernel((p), (sz), 0)
+
+SEC("raw_tp")
+__success
+int iter_stack_array_loop(const void *ctx)
+{
+	long arr1[16], arr2[16], sum = 0;
+	int *v, i;
+
+	MY_PID_GUARD();
+
+	/* zero-init arr1 and arr2 in such a way that verifier doesn't know
+	 * it's all zeros; if we don't do that, we'll make BPF verifier track
+	 * all combination of zero/non-zero stack slots for arr1/arr2, which
+	 * will lead to O(2^(ARRAY_SIZE(arr1)+ARRAY_SIZE(arr2))) different
+	 * states
+	 */
+	__bpf_memzero(arr1, sizeof(arr1));
+	__bpf_memzero(arr2, sizeof(arr1));
+
+	/* validate that we can break and continue when using bpf_for() */
+	bpf_for(i, 0, ARRAY_SIZE(arr1)) {
+		if (i & 1) {
+			arr1[i] = i;
+			continue;
+		} else {
+			arr2[i] = i;
+			break;
+		}
+	}
+
+	bpf_for(i, 0, ARRAY_SIZE(arr1)) {
+		sum += arr1[i] + arr2[i];
+	}
+
+	return sum;
+}
+
+static __noinline void fill(struct bpf_iter_num *it, int *arr, __u32 n, int mul)
+{
+	int *t, i;
+
+	while ((t = bpf_iter_num_next(it))) {
+		i = *t;
+		if (i >= n)
+			break;
+		arr[i] =  i * mul;
+	}
+}
+
+static __noinline int sum(struct bpf_iter_num *it, int *arr, __u32 n)
+{
+	int *t, i, sum = 0;;
+
+	while ((t = bpf_iter_num_next(it))) {
+		i = *t;
+		if (i >= n)
+			break;
+		sum += arr[i];
+	}
+
+	return sum;
+}
+
+SEC("raw_tp")
+__success
+int iter_pass_iter_ptr_to_subprog(const void *ctx)
+{
+	int arr1[16], arr2[32];
+	struct bpf_iter_num it;
+	int n, sum1, sum2;
+
+	MY_PID_GUARD();
+
+	/* fill arr1 */
+	n = ARRAY_SIZE(arr1);
+	bpf_iter_num_new(&it, 0, n);
+	fill(&it, arr1, n, 2);
+	bpf_iter_num_destroy(&it);
+
+	/* fill arr2 */
+	n = ARRAY_SIZE(arr2);
+	bpf_iter_num_new(&it, 0, n);
+	fill(&it, arr2, n, 10);
+	bpf_iter_num_destroy(&it);
+
+	/* sum arr1 */
+	n = ARRAY_SIZE(arr1);
+	bpf_iter_num_new(&it, 0, n);
+	sum1 = sum(&it, arr1, n);
+	bpf_iter_num_destroy(&it);
+
+	/* sum arr2 */
+	n = ARRAY_SIZE(arr2);
+	bpf_iter_num_new(&it, 0, n);
+	sum2 = sum(&it, arr2, n);
+	bpf_iter_num_destroy(&it);
+
+	bpf_printk("sum1=%d, sum2=%d", sum1, sum2);
+
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/iters_looping.c b/tools/testing/selftests/bpf/progs/iters_looping.c
new file mode 100644
index 000000000000..05fa5ce7fc59
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/iters_looping.c
@@ -0,0 +1,163 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2023 Meta Platforms, Inc. and affiliates. */
+
+#include <errno.h>
+#include <string.h>
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+char _license[] SEC("license") = "GPL";
+
+#define ITER_HELPERS						\
+	  __imm(bpf_iter_num_new),				\
+	  __imm(bpf_iter_num_next),				\
+	  __imm(bpf_iter_num_destroy)
+
+SEC("?raw_tp")
+__success
+int force_clang_to_emit_btf_for_externs(void *ctx)
+{
+	/* we need this as a workaround to enforce compiler emitting BTF
+	 * information for bpf_iter_num_{new,next,destroy}() kfuncs,
+	 * as, apparently, it doesn't emit it for symbols only referenced from
+	 * assembly (or cleanup attribute, for that matter, as well)
+	 */
+	bpf_repeat(0);
+
+	return 0;
+}
+
+SEC("?raw_tp")
+__success
+int consume_first_item_only(void *ctx)
+{
+	struct bpf_iter_num iter;
+
+	asm volatile (
+		/* create iterator */
+		"r1 = %[iter];"
+		"r2 = 0;"
+		"r3 = 1000;"
+		"call %[bpf_iter_num_new];"
+
+		/* consume first item */
+		"r1 = %[iter];"
+		"call %[bpf_iter_num_next];"
+
+		"if r0 == 0 goto +1;"
+		"r0 = *(u32 *)(r0 + 0);"
+
+		/* destroy iterator */
+		"r1 = %[iter];"
+		"call %[bpf_iter_num_destroy];"
+		:
+		: __imm_ptr(iter), ITER_HELPERS
+		: __clobber_common
+	);
+
+	return 0;
+}
+
+SEC("?raw_tp")
+__failure __msg("R0 invalid mem access 'scalar'")
+int missing_null_check_fail(void *ctx)
+{
+	struct bpf_iter_num iter;
+
+	asm volatile (
+		/* create iterator */
+		"r1 = %[iter];"
+		"r2 = 0;"
+		"r3 = 1000;"
+		"call %[bpf_iter_num_new];"
+
+		/* consume first element */
+		"r1 = %[iter];"
+		"call %[bpf_iter_num_next];"
+
+		/* FAIL: deref with no NULL check */
+		"r1 = *(u32 *)(r0 + 0);"
+
+		/* destroy iterator */
+		"r1 = %[iter];"
+		"call %[bpf_iter_num_destroy];"
+		:
+		: __imm_ptr(iter), ITER_HELPERS
+		: __clobber_common
+	);
+
+	return 0;
+}
+
+SEC("?raw_tp")
+__failure
+__msg("invalid access to memory, mem_size=4 off=0 size=8")
+__msg("R0 min value is outside of the allowed memory range")
+int wrong_sized_read_fail(void *ctx)
+{
+	struct bpf_iter_num iter;
+
+	asm volatile (
+		/* create iterator */
+		"r1 = %[iter];"
+		"r2 = 0;"
+		"r3 = 1000;"
+		"call %[bpf_iter_num_new];"
+
+		/* consume first element */
+		"r1 = %[iter];"
+		"call %[bpf_iter_num_next];"
+
+		"if r0 == 0 goto +1;"
+		/* FAIL: deref more than available 4 bytes */
+		"r0 = *(u64 *)(r0 + 0);"
+
+		/* destroy iterator */
+		"r1 = %[iter];"
+		"call %[bpf_iter_num_destroy];"
+		:
+		: __imm_ptr(iter), ITER_HELPERS
+		: __clobber_common
+	);
+
+	return 0;
+}
+
+SEC("?raw_tp")
+__success __log_level(2)
+__flag(BPF_F_TEST_STATE_FREQ)
+int simplest_loop(void *ctx)
+{
+	struct bpf_iter_num iter;
+
+	asm volatile (
+		"r6 = 0;" /* init sum */
+
+		/* create iterator */
+		"r1 = %[iter];"
+		"r2 = 0;"
+		"r3 = 10;"
+		"call %[bpf_iter_num_new];"
+
+	"1:"
+		/* consume next item */
+		"r1 = %[iter];"
+		"call %[bpf_iter_num_next];"
+
+		"if r0 == 0 goto 2f;"
+		"r0 = *(u32 *)(r0 + 0);"
+		"r6 += r0;" /* accumulate sum */
+		"goto 1b;"
+
+	"2:"
+		/* destroy iterator */
+		"r1 = %[iter];"
+		"call %[bpf_iter_num_destroy];"
+		:
+		: __imm_ptr(iter), ITER_HELPERS
+		: __clobber_common, "r6"
+	);
+
+	return 0;
+}
diff --git a/tools/testing/selftests/bpf/progs/iters_state_safety.c b/tools/testing/selftests/bpf/progs/iters_state_safety.c
new file mode 100644
index 000000000000..d47e59aba6de
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/iters_state_safety.c
@@ -0,0 +1,426 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2022 Facebook */
+
+#include <errno.h>
+#include <string.h>
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+char _license[] SEC("license") = "GPL";
+
+#define ITER_HELPERS						\
+	  __imm(bpf_iter_num_new),				\
+	  __imm(bpf_iter_num_next),				\
+	  __imm(bpf_iter_num_destroy)
+
+SEC("?raw_tp")
+__success
+int force_clang_to_emit_btf_for_externs(void *ctx)
+{
+	/* we need this as a workaround to enforce compiler emitting BTF
+	 * information for bpf_iter_num_{new,next,destroy}() kfuncs,
+	 * as, apparently, it doesn't emit it for symbols only referenced from
+	 * assembly (or cleanup attribute, for that matter, as well)
+	 */
+	bpf_repeat(0);
+
+	return 0;
+}
+
+SEC("?raw_tp")
+__success __log_level(2)
+__msg("fp-8_w=iter_num(ref_id=1,state=active,depth=0)")
+int create_and_destroy(void *ctx)
+{
+	struct bpf_iter_num iter;
+
+	asm volatile (
+		/* create iterator */
+		"r1 = %[iter];"
+		"r2 = 0;"
+		"r3 = 1000;"
+		"call %[bpf_iter_num_new];"
+		/* destroy iterator */
+		"r1 = %[iter];"
+		"call %[bpf_iter_num_destroy];"
+		:
+		: __imm_ptr(iter), ITER_HELPERS
+		: __clobber_common
+	);
+
+	return 0;
+}
+
+SEC("?raw_tp")
+__failure __msg("Unreleased reference id=1")
+int create_and_forget_to_destroy_fail(void *ctx)
+{
+	struct bpf_iter_num iter;
+
+	asm volatile (
+		/* create iterator */
+		"r1 = %[iter];"
+		"r2 = 0;"
+		"r3 = 1000;"
+		"call %[bpf_iter_num_new];"
+		:
+		: __imm_ptr(iter), ITER_HELPERS
+		: __clobber_common
+	);
+
+	return 0;
+}
+
+SEC("?raw_tp")
+__failure __msg("expected an initialized iter_num as arg #1")
+int destroy_without_creating_fail(void *ctx)
+{
+	/* init with zeros to stop verifier complaining about uninit stack */
+	struct bpf_iter_num iter;
+
+	asm volatile (
+		"r1 = %[iter];"
+		"call %[bpf_iter_num_destroy];"
+		:
+		: __imm_ptr(iter), ITER_HELPERS
+		: __clobber_common
+	);
+
+	return 0;
+}
+
+SEC("?raw_tp")
+__failure __msg("expected an initialized iter_num as arg #1")
+int compromise_iter_w_direct_write_fail(void *ctx)
+{
+	struct bpf_iter_num iter;
+
+	asm volatile (
+		/* create iterator */
+		"r1 = %[iter];"
+		"r2 = 0;"
+		"r3 = 1000;"
+		"call %[bpf_iter_num_new];"
+
+		/* directly write over first half of iter state */
+		"*(u64 *)(%[iter] + 0) = r0;"
+
+		/* (attempt to) destroy iterator */
+		"r1 = %[iter];"
+		"call %[bpf_iter_num_destroy];"
+		:
+		: __imm_ptr(iter), ITER_HELPERS
+		: __clobber_common
+	);
+
+	return 0;
+}
+
+SEC("?raw_tp")
+__failure __msg("Unreleased reference id=1")
+int compromise_iter_w_direct_write_and_skip_destroy_fail(void *ctx)
+{
+	struct bpf_iter_num iter;
+
+	asm volatile (
+		/* create iterator */
+		"r1 = %[iter];"
+		"r2 = 0;"
+		"r3 = 1000;"
+		"call %[bpf_iter_num_new];"
+
+		/* directly write over first half of iter state */
+		"*(u64 *)(%[iter] + 0) = r0;"
+
+		/* don't destroy iter, leaking ref, which should fail */
+		:
+		: __imm_ptr(iter), ITER_HELPERS
+		: __clobber_common
+	);
+
+	return 0;
+}
+
+SEC("?raw_tp")
+__failure __msg("expected an initialized iter_num as arg #1")
+int compromise_iter_w_helper_write_fail(void *ctx)
+{
+	struct bpf_iter_num iter;
+
+	asm volatile (
+		/* create iterator */
+		"r1 = %[iter];"
+		"r2 = 0;"
+		"r3 = 1000;"
+		"call %[bpf_iter_num_new];"
+
+		/* overwrite 8th byte with bpf_probe_read_kernel() */
+		"r1 = %[iter];"
+		"r1 += 7;"
+		"r2 = 1;"
+		"r3 = 0;" /* NULL */
+		"call %[bpf_probe_read_kernel];"
+
+		/* (attempt to) destroy iterator */
+		"r1 = %[iter];"
+		"call %[bpf_iter_num_destroy];"
+		:
+		: __imm_ptr(iter), ITER_HELPERS, __imm(bpf_probe_read_kernel)
+		: __clobber_common
+	);
+
+	return 0;
+}
+
+static __noinline void subprog_with_iter(void)
+{
+	struct bpf_iter_num iter;
+
+	bpf_iter_num_new(&iter, 0, 1);
+
+	return;
+}
+
+SEC("?raw_tp")
+__failure
+/* ensure there was a call to subprog, which might happen without __noinline */
+__msg("returning from callee:")
+__msg("Unreleased reference id=1")
+int leak_iter_from_subprog_fail(void *ctx)
+{
+	subprog_with_iter();
+
+	return 0;
+}
+
+SEC("?raw_tp")
+__success __log_level(2)
+__msg("fp-8_w=iter_num(ref_id=1,state=active,depth=0)")
+int valid_stack_reuse(void *ctx)
+{
+	struct bpf_iter_num iter;
+
+	asm volatile (
+		/* create iterator */
+		"r1 = %[iter];"
+		"r2 = 0;"
+		"r3 = 1000;"
+		"call %[bpf_iter_num_new];"
+		/* destroy iterator */
+		"r1 = %[iter];"
+		"call %[bpf_iter_num_destroy];"
+
+		/* now reuse same stack slots */
+
+		/* create iterator */
+		"r1 = %[iter];"
+		"r2 = 0;"
+		"r3 = 1000;"
+		"call %[bpf_iter_num_new];"
+		/* destroy iterator */
+		"r1 = %[iter];"
+		"call %[bpf_iter_num_destroy];"
+		:
+		: __imm_ptr(iter), ITER_HELPERS
+		: __clobber_common
+	);
+
+	return 0;
+}
+
+SEC("?raw_tp")
+__failure __msg("expected uninitialized iter_num as arg #1")
+int double_create_fail(void *ctx)
+{
+	struct bpf_iter_num iter;
+
+	asm volatile (
+		/* create iterator */
+		"r1 = %[iter];"
+		"r2 = 0;"
+		"r3 = 1000;"
+		"call %[bpf_iter_num_new];"
+		/* (attempt to) create iterator again */
+		"r1 = %[iter];"
+		"r2 = 0;"
+		"r3 = 1000;"
+		"call %[bpf_iter_num_new];"
+		/* destroy iterator */
+		"r1 = %[iter];"
+		"call %[bpf_iter_num_destroy];"
+		:
+		: __imm_ptr(iter), ITER_HELPERS
+		: __clobber_common
+	);
+
+	return 0;
+}
+
+SEC("?raw_tp")
+__failure __msg("expected an initialized iter_num as arg #1")
+int double_destroy_fail(void *ctx)
+{
+	struct bpf_iter_num iter;
+
+	asm volatile (
+		/* create iterator */
+		"r1 = %[iter];"
+		"r2 = 0;"
+		"r3 = 1000;"
+		"call %[bpf_iter_num_new];"
+		/* destroy iterator */
+		"r1 = %[iter];"
+		"call %[bpf_iter_num_destroy];"
+		/* (attempt to) destroy iterator again */
+		"r1 = %[iter];"
+		"call %[bpf_iter_num_destroy];"
+		:
+		: __imm_ptr(iter), ITER_HELPERS
+		: __clobber_common
+	);
+
+	return 0;
+}
+
+SEC("?raw_tp")
+__failure __msg("expected an initialized iter_num as arg #1")
+int next_without_new_fail(void *ctx)
+{
+	struct bpf_iter_num iter;
+
+	asm volatile (
+		/* don't create iterator and try to iterate*/
+		"r1 = %[iter];"
+		"call %[bpf_iter_num_next];"
+		/* destroy iterator */
+		"r1 = %[iter];"
+		"call %[bpf_iter_num_destroy];"
+		:
+		: __imm_ptr(iter), ITER_HELPERS
+		: __clobber_common
+	);
+
+	return 0;
+}
+
+SEC("?raw_tp")
+__failure __msg("expected an initialized iter_num as arg #1")
+int next_after_destroy_fail(void *ctx)
+{
+	struct bpf_iter_num iter;
+
+	asm volatile (
+		/* create iterator */
+		"r1 = %[iter];"
+		"r2 = 0;"
+		"r3 = 1000;"
+		"call %[bpf_iter_num_new];"
+		/* destroy iterator */
+		"r1 = %[iter];"
+		"call %[bpf_iter_num_destroy];"
+		/* don't create iterator and try to iterate*/
+		"r1 = %[iter];"
+		"call %[bpf_iter_num_next];"
+		:
+		: __imm_ptr(iter), ITER_HELPERS
+		: __clobber_common
+	);
+
+	return 0;
+}
+
+SEC("?raw_tp")
+__failure __msg("invalid read from stack")
+int __naked read_from_iter_slot_fail(void)
+{
+	asm volatile (
+		/* r6 points to struct bpf_iter_num on the stack */
+		"r6 = r10;"
+		"r6 += -24;"
+
+		/* create iterator */
+		"r1 = r6;"
+		"r2 = 0;"
+		"r3 = 1000;"
+		"call %[bpf_iter_num_new];"
+
+		/* attemp to leak bpf_iter_num state */
+		"r7 = *(u64 *)(r6 + 0);"
+		"r8 = *(u64 *)(r6 + 8);"
+
+		/* destroy iterator */
+		"r1 = r6;"
+		"call %[bpf_iter_num_destroy];"
+
+		/* leak bpf_iter_num state */
+		"r0 = r7;"
+		"if r7 > r8 goto +1;"
+		"r0 = r8;"
+		"exit;"
+		:
+		: ITER_HELPERS
+		: __clobber_common, "r6", "r7", "r8"
+	);
+}
+
+int zero;
+
+SEC("?raw_tp")
+__failure
+__flag(BPF_F_TEST_STATE_FREQ)
+__msg("Unreleased reference")
+int stacksafe_should_not_conflate_stack_spill_and_iter(void *ctx)
+{
+	struct bpf_iter_num iter;
+
+	asm volatile (
+		/* Create a fork in logic, with general setup as follows:
+		 *   - fallthrough (first) path is valid;
+		 *   - branch (second) path is invalid.
+		 * Then depending on what we do in fallthrough vs branch path,
+		 * we try to detect bugs in func_states_equal(), regsafe(),
+		 * refsafe(), stack_safe(), and similar by tricking verifier
+		 * into believing that branch state is a valid subset of
+		 * a fallthrough state. Verifier should reject overall
+		 * validation, unless there is a bug somewhere in verifier
+		 * logic.
+		 */
+		"call %[bpf_get_prandom_u32];"
+		"r6 = r0;"
+		"call %[bpf_get_prandom_u32];"
+		"r7 = r0;"
+
+		"if r6 > r7 goto bad;" /* fork */
+
+		/* spill r6 into stack slot of bpf_iter_num var */
+		"*(u64 *)(%[iter] + 0) = r6;"
+
+		"goto skip_bad;"
+
+	"bad:"
+		/* create iterator in the same stack slot */
+		"r1 = %[iter];"
+		"r2 = 0;"
+		"r3 = 1000;"
+		"call %[bpf_iter_num_new];"
+
+		/* but then forget about it and overwrite it back to r6 spill */
+		"*(u64 *)(%[iter] + 0) = r6;"
+
+	"skip_bad:"
+		"goto +0;" /* force checkpoint */
+
+		/* corrupt stack slots, if they are really dynptr */
+		"*(u64 *)(%[iter] + 0) = r6;"
+		:
+		: __imm_ptr(iter),
+		  __imm_addr(zero),
+		  __imm(bpf_get_prandom_u32),
+		  __imm(bpf_dynptr_from_mem),
+		  ITER_HELPERS
+		: __clobber_common, "r6", "r7"
+	);
+
+	return 0;
+}
-- 
2.34.1

