Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F763438043
	for <lists+bpf@lfdr.de>; Sat, 23 Oct 2021 00:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234352AbhJVWfJ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Fri, 22 Oct 2021 18:35:09 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:21636 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233793AbhJVWfJ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 22 Oct 2021 18:35:09 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.1.2/8.16.1.2) with SMTP id 19MLBTA4023372
        for <bpf@vger.kernel.org>; Fri, 22 Oct 2021 15:32:50 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net with ESMTP id 3buu1ydhve-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 22 Oct 2021 15:32:50 -0700
Received: from intmgw002.48.prn1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Fri, 22 Oct 2021 15:32:49 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 7773570D5F99; Fri, 22 Oct 2021 15:32:43 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>,
        Yucong Sun <sunyucong@gmail.com>
Subject: [PATCH bpf-next 4/4] selftests/bpf: split out bpf_verif_scale selftests into multiple tests
Date:   Fri, 22 Oct 2021 15:32:28 -0700
Message-ID: <20211022223228.99920-5-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211022223228.99920-1-andrii@kernel.org>
References: <20211022223228.99920-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: 9xofQLITEDzt0E-bvMznYR72OmlAnUec
X-Proofpoint-ORIG-GUID: 9xofQLITEDzt0E-bvMznYR72OmlAnUec
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-22_05,2021-10-22_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=999
 spamscore=0 bulkscore=0 adultscore=0 malwarescore=0 mlxscore=0
 impostorscore=0 phishscore=0 priorityscore=1501 clxscore=1015
 suspectscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2109230001 definitions=main-2110220126
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Instead of using subtests in bpf_verif_scale selftest, turn each scale
sub-test into its own test. Each subtest is compltely independent and
just reuses a bit of common test running logic, so the conversion is
trivial. For convenience, keep all of BPF verifier scale tests in one
file.

This conversion shaves off a significant amount of time when running
test_progs in parallel mode. E.g., just running scale tests (-t verif_scale):

BEFORE
======
Summary: 24/0 PASSED, 0 SKIPPED, 0 FAILED

real    0m22.894s
user    0m0.012s
sys     0m22.797s

AFTER
=====
Summary: 24/0 PASSED, 0 SKIPPED, 0 FAILED

real    0m12.044s
user    0m0.024s
sys     0m27.869s

Ten second saving right there. test_progs -j is not yet ready to be
turned on by default, unfortunately, and some tests fail almost every
time, but this is a good improvement nevertheless. Ignoring few
failures, here is sequential vs parallel run times when running all
tests now:

SEQUENTIAL
==========
Summary: 206/953 PASSED, 4 SKIPPED, 0 FAILED

real    1m5.625s
user    0m4.211s
sys     0m31.650s

PARALLEL
========
Summary: 204/952 PASSED, 4 SKIPPED, 2 FAILED

real    0m35.550s
user    0m4.998s
sys     0m39.890s

Cc: Yucong Sun <sunyucong@gmail.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 .../bpf/prog_tests/bpf_verif_scale.c          | 220 ++++++++++++------
 1 file changed, 152 insertions(+), 68 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_verif_scale.c b/tools/testing/selftests/bpf/prog_tests/bpf_verif_scale.c
index 3d002c245d2b..867349e4ed9e 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_verif_scale.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_verif_scale.c
@@ -39,82 +39,166 @@ struct scale_test_def {
 	bool fails;
 };
 
-void test_bpf_verif_scale(void)
-{
-	struct scale_test_def tests[] = {
-		{ "loop3.o", BPF_PROG_TYPE_RAW_TRACEPOINT, true /* fails */ },
-
-		{ "test_verif_scale1.o", BPF_PROG_TYPE_SCHED_CLS },
-		{ "test_verif_scale2.o", BPF_PROG_TYPE_SCHED_CLS },
-		{ "test_verif_scale3.o", BPF_PROG_TYPE_SCHED_CLS },
-
-		{ "pyperf_global.o", BPF_PROG_TYPE_RAW_TRACEPOINT },
-		{ "pyperf_subprogs.o", BPF_PROG_TYPE_RAW_TRACEPOINT },
-
-		/* full unroll by llvm */
-		{ "pyperf50.o", BPF_PROG_TYPE_RAW_TRACEPOINT },
-		{ "pyperf100.o", BPF_PROG_TYPE_RAW_TRACEPOINT },
-		{ "pyperf180.o", BPF_PROG_TYPE_RAW_TRACEPOINT },
-
-		/* partial unroll. llvm will unroll loop ~150 times.
-		 * C loop count -> 600.
-		 * Asm loop count -> 4.
-		 * 16k insns in loop body.
-		 * Total of 5 such loops. Total program size ~82k insns.
-		 */
-		{ "pyperf600.o", BPF_PROG_TYPE_RAW_TRACEPOINT },
-
-		/* no unroll at all.
-		 * C loop count -> 600.
-		 * ASM loop count -> 600.
-		 * ~110 insns in loop body.
-		 * Total of 5 such loops. Total program size ~1500 insns.
-		 */
-		{ "pyperf600_nounroll.o", BPF_PROG_TYPE_RAW_TRACEPOINT },
-
-		{ "loop1.o", BPF_PROG_TYPE_RAW_TRACEPOINT },
-		{ "loop2.o", BPF_PROG_TYPE_RAW_TRACEPOINT },
-		{ "loop4.o", BPF_PROG_TYPE_SCHED_CLS },
-		{ "loop5.o", BPF_PROG_TYPE_SCHED_CLS },
-		{ "loop6.o", BPF_PROG_TYPE_KPROBE },
-
-		/* partial unroll. 19k insn in a loop.
-		 * Total program size 20.8k insn.
-		 * ~350k processed_insns
-		 */
-		{ "strobemeta.o", BPF_PROG_TYPE_RAW_TRACEPOINT },
-
-		/* no unroll, tiny loops */
-		{ "strobemeta_nounroll1.o", BPF_PROG_TYPE_RAW_TRACEPOINT },
-		{ "strobemeta_nounroll2.o", BPF_PROG_TYPE_RAW_TRACEPOINT },
-
-		/* non-inlined subprogs */
-		{ "strobemeta_subprogs.o", BPF_PROG_TYPE_RAW_TRACEPOINT },
-
-		{ "test_sysctl_loop1.o", BPF_PROG_TYPE_CGROUP_SYSCTL },
-		{ "test_sysctl_loop2.o", BPF_PROG_TYPE_CGROUP_SYSCTL },
-
-		{ "test_xdp_loop.o", BPF_PROG_TYPE_XDP },
-		{ "test_seg6_loop.o", BPF_PROG_TYPE_LWT_SEG6LOCAL },
-	};
+static void scale_test(const char *file,
+		       enum bpf_prog_type attach_type,
+		       bool should_fail)
+{
 	libbpf_print_fn_t old_print_fn = NULL;
-	int err, i;
+	int err;
 
 	if (env.verifier_stats) {
 		test__force_log();
 		old_print_fn = libbpf_set_print(libbpf_debug_print);
 	}
 
-	for (i = 0; i < ARRAY_SIZE(tests); i++) {
-		const struct scale_test_def *test = &tests[i];
-
-		if (!test__start_subtest(test->file))
-			continue;
-
-		err = check_load(test->file, test->attach_type);
-		CHECK_FAIL(err && !test->fails);
-	}
+	err = check_load(file, attach_type);
+	if (should_fail)
+		ASSERT_ERR(err, "expect_error");
+	else
+		ASSERT_OK(err, "expect_success");
 
 	if (env.verifier_stats)
 		libbpf_set_print(old_print_fn);
 }
+
+void test_verif_scale1()
+{
+	scale_test("test_verif_scale1.o", BPF_PROG_TYPE_SCHED_CLS, false);
+}
+
+void test_verif_scale2()
+{
+	scale_test("test_verif_scale2.o", BPF_PROG_TYPE_SCHED_CLS, false);
+}
+
+void test_verif_scale3()
+{
+	scale_test("test_verif_scale3.o", BPF_PROG_TYPE_SCHED_CLS, false);
+}
+
+void test_verif_scale_pyperf_global()
+{
+	scale_test("pyperf_global.o", BPF_PROG_TYPE_RAW_TRACEPOINT, false);
+}
+
+void test_verif_scale_pyperf_subprogs()
+{
+	scale_test("pyperf_subprogs.o", BPF_PROG_TYPE_RAW_TRACEPOINT, false);
+}
+
+void test_verif_scale_pyperf50()
+{
+	/* full unroll by llvm */
+	scale_test("pyperf50.o", BPF_PROG_TYPE_RAW_TRACEPOINT, false);
+}
+
+void test_verif_scale_pyperf100()
+{
+	/* full unroll by llvm */
+	scale_test("pyperf100.o", BPF_PROG_TYPE_RAW_TRACEPOINT, false);
+}
+
+void test_verif_scale_pyperf180()
+{
+	/* full unroll by llvm */
+	scale_test("pyperf180.o", BPF_PROG_TYPE_RAW_TRACEPOINT, false);
+}
+
+void test_verif_scale_pyperf600()
+{
+	/* partial unroll. llvm will unroll loop ~150 times.
+	 * C loop count -> 600.
+	 * Asm loop count -> 4.
+	 * 16k insns in loop body.
+	 * Total of 5 such loops. Total program size ~82k insns.
+	 */
+	scale_test("pyperf600.o", BPF_PROG_TYPE_RAW_TRACEPOINT, false);
+}
+
+void test_verif_scale_pyperf600_nounroll()
+{
+	/* no unroll at all.
+	 * C loop count -> 600.
+	 * ASM loop count -> 600.
+	 * ~110 insns in loop body.
+	 * Total of 5 such loops. Total program size ~1500 insns.
+	 */
+	scale_test("pyperf600_nounroll.o", BPF_PROG_TYPE_RAW_TRACEPOINT, false);
+}
+
+void test_verif_scale_loop1()
+{
+	scale_test("loop1.o", BPF_PROG_TYPE_RAW_TRACEPOINT, false);
+}
+
+void test_verif_scale_loop2()
+{
+	scale_test("loop2.o", BPF_PROG_TYPE_RAW_TRACEPOINT, false);
+}
+
+void test_verif_scale_loop3_fail()
+{
+	scale_test("loop3.o", BPF_PROG_TYPE_RAW_TRACEPOINT, true /* fails */);
+}
+
+void test_verif_scale_loop4()
+{
+	scale_test("loop4.o", BPF_PROG_TYPE_SCHED_CLS, false);
+}
+
+void test_verif_scale_loop5()
+{
+	scale_test("loop5.o", BPF_PROG_TYPE_SCHED_CLS, false);
+}
+
+void test_verif_scale_loop6()
+{
+	scale_test("loop6.o", BPF_PROG_TYPE_KPROBE, false);
+}
+
+void test_verif_scale_strobemeta()
+{
+	/* partial unroll. 19k insn in a loop.
+	 * Total program size 20.8k insn.
+	 * ~350k processed_insns
+	 */
+	scale_test("strobemeta.o", BPF_PROG_TYPE_RAW_TRACEPOINT, false);
+}
+
+void test_verif_scale_strobemeta_nounroll1()
+{
+	/* no unroll, tiny loops */
+	scale_test("strobemeta_nounroll1.o", BPF_PROG_TYPE_RAW_TRACEPOINT, false);
+}
+
+void test_verif_scale_strobemeta_nounroll2()
+{
+	/* no unroll, tiny loops */
+	scale_test("strobemeta_nounroll2.o", BPF_PROG_TYPE_RAW_TRACEPOINT, false);
+}
+
+void test_verif_scale_strobemeta_subprogs()
+{
+	/* non-inlined subprogs */
+	scale_test("strobemeta_subprogs.o", BPF_PROG_TYPE_RAW_TRACEPOINT, false);
+}
+
+void test_verif_scale_sysctl_loop1()
+{
+	scale_test("test_sysctl_loop1.o", BPF_PROG_TYPE_CGROUP_SYSCTL, false);
+}
+
+void test_verif_scale_sysctl_loop2()
+{
+	scale_test("test_sysctl_loop2.o", BPF_PROG_TYPE_CGROUP_SYSCTL, false);
+}
+
+void test_verif_scale_xdp_loop()
+{
+	scale_test("test_xdp_loop.o", BPF_PROG_TYPE_XDP, false);
+}
+
+void test_verif_scale_seg6_loop()
+{
+	scale_test("test_seg6_loop.o", BPF_PROG_TYPE_LWT_SEG6LOCAL, false);
+}
-- 
2.30.2

