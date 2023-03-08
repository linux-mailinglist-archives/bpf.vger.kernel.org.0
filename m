Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A06D16AFDAC
	for <lists+bpf@lfdr.de>; Wed,  8 Mar 2023 04:55:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbjCHDzD convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Tue, 7 Mar 2023 22:55:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbjCHDzC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 7 Mar 2023 22:55:02 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A835997FFC
        for <bpf@vger.kernel.org>; Tue,  7 Mar 2023 19:55:00 -0800 (PST)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3281EJ7s019149
        for <bpf@vger.kernel.org>; Tue, 7 Mar 2023 19:55:00 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3p6ffw14pr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 07 Mar 2023 19:54:59 -0800
Received: from twshared32017.39.prn1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Tue, 7 Mar 2023 19:54:43 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 7108C298A55DE; Tue,  7 Mar 2023 19:54:34 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@meta.com>,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH v4 bpf-next 8/8] selftests/bpf: implement and test custom testmod_seq iterator
Date:   Tue, 7 Mar 2023 19:54:16 -0800
Message-ID: <20230308035416.2591326-9-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230308035416.2591326-1-andrii@kernel.org>
References: <20230308035416.2591326-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: DTI3wqGF10h6BZOhz9ZwwAaQ1qf4rEY-
X-Proofpoint-ORIG-GUID: DTI3wqGF10h6BZOhz9ZwwAaQ1qf4rEY-
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

Implement a trivial iterator returning same specified integer value
N times as part of bpf_testmod kernel module. Add selftests to validate
everything works end to end.

We also reuse these tests as "verification-only" tests, to validate that
kernel prints the state of custom module-only iterator correctly:

  fp-16=iter_testmod_seq(ref_id=1,state=drained,depth=0)

"testmod_seq" part is iterator type, and is coming from module's BTF
information dynamically at runtime.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/testing/selftests/bpf/DENYLIST.s390x    |  1 +
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   | 42 +++++++++-
 .../selftests/bpf/bpf_testmod/bpf_testmod.h   |  6 ++
 .../testing/selftests/bpf/prog_tests/iters.c  | 42 ++++++++++
 .../selftests/bpf/progs/iters_testmod_seq.c   | 79 +++++++++++++++++++
 5 files changed, 169 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/progs/iters_testmod_seq.c

diff --git a/tools/testing/selftests/bpf/DENYLIST.s390x b/tools/testing/selftests/bpf/DENYLIST.s390x
index a02a085e7f32..34cb8b2de8ca 100644
--- a/tools/testing/selftests/bpf/DENYLIST.s390x
+++ b/tools/testing/selftests/bpf/DENYLIST.s390x
@@ -8,6 +8,7 @@ dynptr/test_dynptr_skb_data
 dynptr/test_skb_readonly
 fexit_sleep                              # fexit_skel_load fexit skeleton failed                                       (trampoline)
 get_stack_raw_tp                         # user_stack corrupted user stack                                             (no backchain userspace)
+iters/testmod_seq*                       # s390x doesn't support kfuncs in modules yet
 kprobe_multi_bench_attach                # bpf_program__attach_kprobe_multi_opts unexpected error: -95
 kprobe_multi_test                        # relies on fentry
 ksyms_module                             # test_ksyms_module__open_and_load unexpected error: -9                       (?)
diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
index 46500636d8cd..5e6e85c8d77d 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
@@ -65,6 +65,34 @@ bpf_testmod_test_mod_kfunc(int i)
 	*(int *)this_cpu_ptr(&bpf_testmod_ksym_percpu) = i;
 }
 
+__bpf_kfunc int bpf_iter_testmod_seq_new(struct bpf_iter_testmod_seq *it, s64 value, int cnt)
+{
+	if (cnt < 0) {
+		it->cnt = 0;
+		return -EINVAL;
+	}
+
+	it->value = value;
+	it->cnt = cnt;
+
+	return 0;
+}
+
+__bpf_kfunc s64 *bpf_iter_testmod_seq_next(struct bpf_iter_testmod_seq* it)
+{
+	if (it->cnt <= 0)
+		return NULL;
+
+	it->cnt--;
+
+	return &it->value;
+}
+
+__bpf_kfunc void bpf_iter_testmod_seq_destroy(struct bpf_iter_testmod_seq *it)
+{
+	it->cnt = 0;
+}
+
 struct bpf_testmod_btf_type_tag_1 {
 	int a;
 };
@@ -220,6 +248,17 @@ static struct bin_attribute bin_attr_bpf_testmod_file __ro_after_init = {
 	.write = bpf_testmod_test_write,
 };
 
+BTF_SET8_START(bpf_testmod_common_kfunc_ids)
+BTF_ID_FLAGS(func, bpf_iter_testmod_seq_new, KF_ITER_NEW)
+BTF_ID_FLAGS(func, bpf_iter_testmod_seq_next, KF_ITER_NEXT | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_iter_testmod_seq_destroy, KF_ITER_DESTROY)
+BTF_SET8_END(bpf_testmod_common_kfunc_ids)
+
+static const struct btf_kfunc_id_set bpf_testmod_common_kfunc_set = {
+	.owner = THIS_MODULE,
+	.set   = &bpf_testmod_common_kfunc_ids,
+};
+
 BTF_SET8_START(bpf_testmod_check_kfunc_ids)
 BTF_ID_FLAGS(func, bpf_testmod_test_mod_kfunc)
 BTF_SET8_END(bpf_testmod_check_kfunc_ids)
@@ -235,7 +274,8 @@ static int bpf_testmod_init(void)
 {
 	int ret;
 
-	ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_CLS, &bpf_testmod_kfunc_set);
+	ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_UNSPEC, &bpf_testmod_common_kfunc_set);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_CLS, &bpf_testmod_kfunc_set);
 	if (ret < 0)
 		return ret;
 	if (bpf_fentry_test1(0) < 0)
diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.h b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.h
index 0d71e2607832..f32793efe095 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.h
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.h
@@ -22,4 +22,10 @@ struct bpf_testmod_test_writable_ctx {
 	int val;
 };
 
+/* BPF iter that returns *value* *n* times in a row */
+struct bpf_iter_testmod_seq {
+	s64 value;
+	int cnt;
+};
+
 #endif /* _BPF_TESTMOD_H */
diff --git a/tools/testing/selftests/bpf/prog_tests/iters.c b/tools/testing/selftests/bpf/prog_tests/iters.c
index 2e7caff9523e..10804ae5ae97 100644
--- a/tools/testing/selftests/bpf/prog_tests/iters.c
+++ b/tools/testing/selftests/bpf/prog_tests/iters.c
@@ -7,6 +7,7 @@
 #include "iters_state_safety.skel.h"
 #include "iters_looping.skel.h"
 #include "iters_num.skel.h"
+#include "iters_testmod_seq.skel.h"
 
 static void subtest_num_iters(void)
 {
@@ -53,12 +54,53 @@ static void subtest_num_iters(void)
 	iters_num__destroy(skel);
 }
 
+static void subtest_testmod_seq_iters(void)
+{
+	struct iters_testmod_seq *skel;
+	int err;
+
+	if (!env.has_testmod) {
+		test__skip();
+		return;
+	}
+
+	skel = iters_testmod_seq__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_open_and_load"))
+		return;
+
+	err = iters_testmod_seq__attach(skel);
+	if (!ASSERT_OK(err, "skel_attach"))
+		goto cleanup;
+
+	usleep(1);
+	iters_testmod_seq__detach(skel);
+
+#define VALIDATE_CASE(case_name)					\
+	ASSERT_EQ(skel->bss->res_##case_name,				\
+		  skel->rodata->exp_##case_name,			\
+		  #case_name)
+
+	VALIDATE_CASE(empty);
+	VALIDATE_CASE(full);
+	VALIDATE_CASE(truncated);
+
+#undef VALIDATE_CASE
+
+cleanup:
+	iters_testmod_seq__destroy(skel);
+}
+
 void test_iters(void)
 {
 	RUN_TESTS(iters_state_safety);
 	RUN_TESTS(iters_looping);
 	RUN_TESTS(iters);
 
+	if (env.has_testmod)
+		RUN_TESTS(iters_testmod_seq);
+
 	if (test__start_subtest("num"))
 		subtest_num_iters();
+	if (test__start_subtest("testmod_seq"))
+		subtest_testmod_seq_iters();
 }
diff --git a/tools/testing/selftests/bpf/progs/iters_testmod_seq.c b/tools/testing/selftests/bpf/progs/iters_testmod_seq.c
new file mode 100644
index 000000000000..3873fb6c292a
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/iters_testmod_seq.c
@@ -0,0 +1,79 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2023 Meta Platforms, Inc. and affiliates. */
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+struct bpf_iter_testmod_seq {
+	u64 :64;
+	u64 :64;
+};
+
+extern int bpf_iter_testmod_seq_new(struct bpf_iter_testmod_seq *it, s64 value, int cnt) __ksym;
+extern s64 *bpf_iter_testmod_seq_next(struct bpf_iter_testmod_seq *it) __ksym;
+extern void bpf_iter_testmod_seq_destroy(struct bpf_iter_testmod_seq *it) __ksym;
+
+const volatile __s64 exp_empty = 0 + 1;
+__s64 res_empty;
+
+SEC("raw_tp/sys_enter")
+__success __log_level(2)
+__msg("fp-16_w=iter_testmod_seq(ref_id=1,state=active,depth=0)")
+__msg("fp-16=iter_testmod_seq(ref_id=1,state=drained,depth=0)")
+__msg("call bpf_iter_testmod_seq_destroy")
+int testmod_seq_empty(const void *ctx)
+{
+	__s64 sum = 0, *i;
+
+	bpf_for_each(testmod_seq, i, 1000, 0) sum += *i;
+	res_empty = 1 + sum;
+
+	return 0;
+}
+
+const volatile __s64 exp_full = 1000000;
+__s64 res_full;
+
+SEC("raw_tp/sys_enter")
+__success __log_level(2)
+__msg("fp-16_w=iter_testmod_seq(ref_id=1,state=active,depth=0)")
+__msg("fp-16=iter_testmod_seq(ref_id=1,state=drained,depth=0)")
+__msg("call bpf_iter_testmod_seq_destroy")
+int testmod_seq_full(const void *ctx)
+{
+	__s64 sum = 0, *i;
+
+	bpf_for_each(testmod_seq, i, 1000, 1000) sum += *i;
+	res_full = sum;
+
+	return 0;
+}
+
+const volatile __s64 exp_truncated = 10 * 1000000;
+__s64 res_truncated;
+
+static volatile int zero = 0;
+
+SEC("raw_tp/sys_enter")
+__success __log_level(2)
+__msg("fp-16_w=iter_testmod_seq(ref_id=1,state=active,depth=0)")
+__msg("fp-16=iter_testmod_seq(ref_id=1,state=drained,depth=0)")
+__msg("call bpf_iter_testmod_seq_destroy")
+int testmod_seq_truncated(const void *ctx)
+{
+	__s64 sum = 0, *i;
+	int cnt = zero;
+
+	bpf_for_each(testmod_seq, i, 10, 2000000) {
+		sum += *i;
+		cnt++;
+		if (cnt >= 1000000)
+			break;
+	}
+	res_truncated = sum;
+
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.34.1

