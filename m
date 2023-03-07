Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC7916AFA5C
	for <lists+bpf@lfdr.de>; Wed,  8 Mar 2023 00:30:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbjCGX37 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Tue, 7 Mar 2023 18:29:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjCGX3p (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 7 Mar 2023 18:29:45 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D206A8E94
        for <bpf@vger.kernel.org>; Tue,  7 Mar 2023 15:29:41 -0800 (PST)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 327Kq2m2007371
        for <bpf@vger.kernel.org>; Tue, 7 Mar 2023 15:29:41 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3p6cp38wuy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 07 Mar 2023 15:29:41 -0800
Received: from twshared30317.05.prn5.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Tue, 7 Mar 2023 15:29:39 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id A52C1298530BE; Tue,  7 Mar 2023 15:29:28 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@meta.com>,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH v3 bpf-next 7/8] selftests/bpf: add number iterator tests
Date:   Tue, 7 Mar 2023 15:29:12 -0800
Message-ID: <20230307232913.576893-8-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230307232913.576893-1-andrii@kernel.org>
References: <20230307232913.576893-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: arSKWE-fapZbAy_ZrAOLyKIDRtTNcvsB
X-Proofpoint-GUID: arSKWE-fapZbAy_ZrAOLyKIDRtTNcvsB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-07_16,2023-03-07_01,2023-02-09_01
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add number iterator (bpf_iter_num_{new,next,destroy}()) tests,
validating its correct handling of various corner cases *at runtime*.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 .../testing/selftests/bpf/prog_tests/iters.c  |  49 ++++
 tools/testing/selftests/bpf/progs/iters_num.c | 242 ++++++++++++++++++
 2 files changed, 291 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/iters_num.c

diff --git a/tools/testing/selftests/bpf/prog_tests/iters.c b/tools/testing/selftests/bpf/prog_tests/iters.c
index 414fb8d82145..2e7caff9523e 100644
--- a/tools/testing/selftests/bpf/prog_tests/iters.c
+++ b/tools/testing/selftests/bpf/prog_tests/iters.c
@@ -6,10 +6,59 @@
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
+#undef VALIDATE_CASE
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
index 000000000000..7a77a8daee0d
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
+int num_empty_zero(const void *ctx)
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
+int num_empty_int_min(const void *ctx)
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
+int num_empty_int_max(const void *ctx)
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
+int num_empty_minus_one(const void *ctx)
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
+int num_simple_sum(const void *ctx)
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
+int num_neg_sum(const void *ctx)
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
+int num_very_neg_sum(const void *ctx)
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
+int num_very_big_sum(const void *ctx)
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
+int num_neg_pos_sum(const void *ctx)
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
+int num_invalid_range(const void *ctx)
+{
+	struct bpf_iter_num it;
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
+int num_max_range(const void *ctx)
+{
+	struct bpf_iter_num it;
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
+int num_e2big_range(const void *ctx)
+{
+	struct bpf_iter_num it;
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
+int num_succ_elem_cnt(const void *ctx)
+{
+	struct bpf_iter_num it;
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
+int num_overfetched_elem_cnt(const void *ctx)
+{
+	struct bpf_iter_num it;
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
+int num_fail_elem_cnt(const void *ctx)
+{
+	struct bpf_iter_num it;
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
2.34.1

