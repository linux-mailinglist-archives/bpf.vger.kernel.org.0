Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 579896A8D52
	for <lists+bpf@lfdr.de>; Fri,  3 Mar 2023 00:51:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbjCBXvF convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Thu, 2 Mar 2023 18:51:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjCBXvD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Mar 2023 18:51:03 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D7CA3403D
        for <bpf@vger.kernel.org>; Thu,  2 Mar 2023 15:51:01 -0800 (PST)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 322N3vsb028581
        for <bpf@vger.kernel.org>; Thu, 2 Mar 2023 15:51:01 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3p2y1mkca3-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 02 Mar 2023 15:51:01 -0800
Received: from twshared16996.15.frc2.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Thu, 2 Mar 2023 15:51:00 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 79FDF291B7F8E; Thu,  2 Mar 2023 15:50:53 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH bpf-next 17/17] selftests/bpf: add number iterator tests
Date:   Thu, 2 Mar 2023 15:50:15 -0800
Message-ID: <20230302235015.2044271-18-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230302235015.2044271-1-andrii@kernel.org>
References: <20230302235015.2044271-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: hgQ3Vdgym_apyaNWegzFKnEpkiF9THEK
X-Proofpoint-ORIG-GUID: hgQ3Vdgym_apyaNWegzFKnEpkiF9THEK
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

Add number iterator (bpf_iter_num_{new,next,destroy}()) specific tests,
validating its correct handling of various corner cases *at runtime*.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 .../testing/selftests/bpf/prog_tests/iters.c  |  47 ++++
 tools/testing/selftests/bpf/progs/iters_num.c | 242 ++++++++++++++++++
 2 files changed, 289 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/iters_num.c

diff --git a/tools/testing/selftests/bpf/prog_tests/iters.c b/tools/testing/selftests/bpf/prog_tests/iters.c
index 414fb8d82145..d467f49dcf9b 100644
--- a/tools/testing/selftests/bpf/prog_tests/iters.c
+++ b/tools/testing/selftests/bpf/prog_tests/iters.c
@@ -6,10 +6,57 @@
 #include "iters.skel.h"
 #include "iters_state_safety.skel.h"
 #include "iters_looping.skel.h"
+#include "iters_num.skel.h"
+
+static void subtest_num_iters(void)
+{
+	struct iters_num *skel;
+	int err;
+
+	skel = iters_num__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_open_and_load"))
+		return;
+
+	err = iters_num__attach(skel);
+	if (!ASSERT_OK(err, "skel_attach"))
+		goto cleanup;
+
+	usleep(1);
+	iters_num__detach(skel);
+
+#define VALIDATE_CASE(case_name)					\
+	ASSERT_EQ(skel->bss->res_##case_name,				\
+		  skel->rodata->exp_##case_name,			\
+		  #case_name)
+
+	VALIDATE_CASE(empty_zero);
+	VALIDATE_CASE(empty_int_min);
+	VALIDATE_CASE(empty_int_max);
+	VALIDATE_CASE(empty_minus_one);
+
+	VALIDATE_CASE(simple_sum);
+	VALIDATE_CASE(neg_sum);
+	VALIDATE_CASE(very_neg_sum);
+	VALIDATE_CASE(neg_pos_sum);
+
+	VALIDATE_CASE(invalid_range);
+	VALIDATE_CASE(max_range);
+	VALIDATE_CASE(e2big_range);
+
+	VALIDATE_CASE(succ_elem_cnt);
+	VALIDATE_CASE(overfetched_elem_cnt);
+	VALIDATE_CASE(fail_elem_cnt);
+
+cleanup:
+	iters_num__destroy(skel);
+}
 
 void test_iters(void)
 {
 	RUN_TESTS(iters_state_safety);
 	RUN_TESTS(iters_looping);
 	RUN_TESTS(iters);
+
+	if (test__start_subtest("num"))
+		subtest_num_iters();
 }
diff --git a/tools/testing/selftests/bpf/progs/iters_num.c b/tools/testing/selftests/bpf/progs/iters_num.c
new file mode 100644
index 000000000000..09df877d31bc
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/iters_num.c
@@ -0,0 +1,242 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2023 Meta Platforms, Inc. and affiliates. */
+
+#include <limits.h>
+#include <linux/errno.h>
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+const volatile __s64 exp_empty_zero = 0 + 1;
+__s64 res_empty_zero;
+
+SEC("raw_tp/sys_enter")
+int empty_zero(const void *ctx)
+{
+	__s64 sum = 0, i;
+
+	bpf_for(i, 0, 0) sum += i;
+	res_empty_zero = 1 + sum;
+
+	return 0;
+}
+
+const volatile __s64 exp_empty_int_min = 0 + 2;
+__s64 res_empty_int_min;
+
+SEC("raw_tp/sys_enter")
+int empty_int_min(const void *ctx)
+{
+	__s64 sum = 0, i;
+
+	bpf_for(i, INT_MIN, INT_MIN) sum += i;
+	res_empty_int_min = 2 + sum;
+
+	return 0;
+}
+
+const volatile __s64 exp_empty_int_max = 0 + 3;
+__s64 res_empty_int_max;
+
+SEC("raw_tp/sys_enter")
+int empty_int_max(const void *ctx)
+{
+	__s64 sum = 0, i;
+
+	bpf_for(i, INT_MAX, INT_MAX) sum += i;
+	res_empty_int_max = 3 + sum;
+
+	return 0;
+}
+
+const volatile __s64 exp_empty_minus_one = 0 + 4;
+__s64 res_empty_minus_one;
+
+SEC("raw_tp/sys_enter")
+int empty_minus_one(const void *ctx)
+{
+	__s64 sum = 0, i;
+
+	bpf_for(i, -1, -1) sum += i;
+	res_empty_minus_one = 4 + sum;
+
+	return 0;
+}
+
+const volatile __s64 exp_simple_sum = 9 * 10 / 2;
+__s64 res_simple_sum;
+
+SEC("raw_tp/sys_enter")
+int simple_sum(const void *ctx)
+{
+	__s64 sum = 0, i;
+
+	bpf_for(i, 0, 10) sum += i;
+	res_simple_sum = sum;
+
+	return 0;
+}
+
+const volatile __s64 exp_neg_sum = -11 * 10 / 2;
+__s64 res_neg_sum;
+
+SEC("raw_tp/sys_enter")
+int neg_sum(const void *ctx)
+{
+	__s64 sum = 0, i;
+
+	bpf_for(i, -10, 0) sum += i;
+	res_neg_sum = sum;
+
+	return 0;
+}
+
+const volatile __s64 exp_very_neg_sum = INT_MIN + (__s64)(INT_MIN + 1);
+__s64 res_very_neg_sum;
+
+SEC("raw_tp/sys_enter")
+int very_neg_sum(const void *ctx)
+{
+	__s64 sum = 0, i;
+
+	bpf_for(i, INT_MIN, INT_MIN + 2) sum += i;
+	res_very_neg_sum = sum;
+
+	return 0;
+}
+
+const volatile __s64 exp_very_big_sum = (__s64)(INT_MAX - 1) + (__s64)(INT_MAX - 2);
+__s64 res_very_big_sum;
+
+SEC("raw_tp/sys_enter")
+int very_big_sum(const void *ctx)
+{
+	__s64 sum = 0, i;
+
+	bpf_for(i, INT_MAX - 2, INT_MAX) sum += i;
+	res_very_big_sum = sum;
+
+	return 0;
+}
+
+const volatile __s64 exp_neg_pos_sum = -3;
+__s64 res_neg_pos_sum;
+
+SEC("raw_tp/sys_enter")
+int neg_pos_sum(const void *ctx)
+{
+	__s64 sum = 0, i;
+
+	bpf_for(i, -3, 3) sum += i;
+	res_neg_pos_sum = sum;
+
+	return 0;
+}
+
+const volatile __s64 exp_invalid_range = -EINVAL;
+__s64 res_invalid_range;
+
+SEC("raw_tp/sys_enter")
+int invalid_range(const void *ctx)
+{
+	struct bpf_iter it;
+
+	res_invalid_range = bpf_iter_num_new(&it, 1, 0);
+	bpf_iter_num_destroy(&it);
+
+	return 0;
+}
+
+const volatile __s64 exp_max_range = 0 + 10;
+__s64 res_max_range;
+
+SEC("raw_tp/sys_enter")
+int max_range(const void *ctx)
+{
+	struct bpf_iter it;
+
+	res_max_range = 10 + bpf_iter_num_new(&it, 0, BPF_MAX_LOOPS);
+	bpf_iter_num_destroy(&it);
+
+	return 0;
+}
+
+const volatile __s64 exp_e2big_range = -E2BIG;
+__s64 res_e2big_range;
+
+SEC("raw_tp/sys_enter")
+int e2big_range(const void *ctx)
+{
+	struct bpf_iter it;
+
+	res_e2big_range = bpf_iter_num_new(&it, -1, BPF_MAX_LOOPS);
+	bpf_iter_num_destroy(&it);
+
+	return 0;
+}
+
+const volatile __s64 exp_succ_elem_cnt = 10;
+__s64 res_succ_elem_cnt;
+
+SEC("raw_tp/sys_enter")
+int succ_elem_cnt(const void *ctx)
+{
+	struct bpf_iter it;
+	int cnt = 0, *v;
+
+	bpf_iter_num_new(&it, 0, 10);
+	while ((v = bpf_iter_num_next(&it))) {
+		cnt++;
+	}
+	bpf_iter_num_destroy(&it);
+
+	res_succ_elem_cnt = cnt;
+
+	return 0;
+}
+
+const volatile __s64 exp_overfetched_elem_cnt = 5;
+__s64 res_overfetched_elem_cnt;
+
+SEC("raw_tp/sys_enter")
+int overfetched_elem_cnt(const void *ctx)
+{
+	struct bpf_iter it;
+	int cnt = 0, *v, i;
+
+	bpf_iter_num_new(&it, 0, 5);
+	for (i = 0; i < 10; i++) {
+		v = bpf_iter_num_next(&it);
+		if (v)
+			cnt++;
+	}
+	bpf_iter_num_destroy(&it);
+
+	res_overfetched_elem_cnt = cnt;
+
+	return 0;
+}
+
+const volatile __s64 exp_fail_elem_cnt = 20 + 0;
+__s64 res_fail_elem_cnt;
+
+SEC("raw_tp/sys_enter")
+int fail_elem_cnt(const void *ctx)
+{
+	struct bpf_iter it;
+	int cnt = 0, *v, i;
+
+	bpf_iter_num_new(&it, 100, 10);
+	for (i = 0; i < 10; i++) {
+		v = bpf_iter_num_next(&it);
+		if (v)
+			cnt++;
+	}
+	bpf_iter_num_destroy(&it);
+
+	res_fail_elem_cnt = 20 + cnt;
+
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.30.2

