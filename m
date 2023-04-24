Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94B546ED8FB
	for <lists+bpf@lfdr.de>; Tue, 25 Apr 2023 01:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbjDXXv7 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Mon, 24 Apr 2023 19:51:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbjDXXv5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 24 Apr 2023 19:51:57 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A807B3AAB
        for <bpf@vger.kernel.org>; Mon, 24 Apr 2023 16:51:56 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33OJjJRk017420
        for <bpf@vger.kernel.org>; Mon, 24 Apr 2023 16:51:56 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3q5x08abtd-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 24 Apr 2023 16:51:55 -0700
Received: from twshared32017.39.prn1.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 24 Apr 2023 16:51:54 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id BED482F139E15; Mon, 24 Apr 2023 16:51:38 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC:     <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH bpf-next] selftests/bpf: avoid mark_all_scalars_precise() trigger in one of iter tests
Date:   Mon, 24 Apr 2023 16:51:28 -0700
Message-ID: <20230424235128.1941726-1-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 5ubWXJGkgZCjdNh0nnF_TUBNXX9_de-Y
X-Proofpoint-GUID: 5ubWXJGkgZCjdNh0nnF_TUBNXX9_de-Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-24_11,2023-04-21_01,2023-02-09_01
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

iter_pass_iter_ptr_to_subprog subtest is relying on actual array size
being passed as subprog parameter. This combined with recent fixes to
precision tracking in conditional jumps ([0]) is now causing verifier to
backtrack all the way to the point where sum() and fill() subprogs are
called, at which point precision backtrack bails out and forces all the
states to have precise SCALAR registers. This in turn causes each
possible value of i within fill() and sum() subprogs to cause
a different non-equivalent state, preventing iterator code to converge.

For now, change the test to assume fixed size of passed in array. Once
BPF verifier supports precision tracking across subprogram calls, these
changes will be reverted as unnecessary.

  [0] 71b547f56124 ("bpf: Fix incorrect verifier pruning due to missing register precision taints")

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/testing/selftests/bpf/progs/iters.c | 26 +++++++++++++----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/iters.c b/tools/testing/selftests/bpf/progs/iters.c
index 6b9b3c56f009..be16143ae292 100644
--- a/tools/testing/selftests/bpf/progs/iters.c
+++ b/tools/testing/selftests/bpf/progs/iters.c
@@ -651,25 +651,29 @@ int iter_stack_array_loop(const void *ctx)
 	return sum;
 }
 
-static __noinline void fill(struct bpf_iter_num *it, int *arr, __u32 n, int mul)
+#define ARR_SZ 16
+
+static __noinline void fill(struct bpf_iter_num *it, int *arr, int mul)
 {
-	int *t, i;
+	int *t;
+	__u64 i;
 
 	while ((t = bpf_iter_num_next(it))) {
 		i = *t;
-		if (i >= n)
+		if (i >= ARR_SZ)
 			break;
 		arr[i] =  i * mul;
 	}
 }
 
-static __noinline int sum(struct bpf_iter_num *it, int *arr, __u32 n)
+static __noinline int sum(struct bpf_iter_num *it, int *arr)
 {
-	int *t, i, sum = 0;;
+	int *t, sum = 0;;
+	__u64 i;
 
 	while ((t = bpf_iter_num_next(it))) {
 		i = *t;
-		if (i >= n)
+		if (i >= ARR_SZ)
 			break;
 		sum += arr[i];
 	}
@@ -681,7 +685,7 @@ SEC("raw_tp")
 __success
 int iter_pass_iter_ptr_to_subprog(const void *ctx)
 {
-	int arr1[16], arr2[32];
+	int arr1[ARR_SZ], arr2[ARR_SZ];
 	struct bpf_iter_num it;
 	int n, sum1, sum2;
 
@@ -690,25 +694,25 @@ int iter_pass_iter_ptr_to_subprog(const void *ctx)
 	/* fill arr1 */
 	n = ARRAY_SIZE(arr1);
 	bpf_iter_num_new(&it, 0, n);
-	fill(&it, arr1, n, 2);
+	fill(&it, arr1, 2);
 	bpf_iter_num_destroy(&it);
 
 	/* fill arr2 */
 	n = ARRAY_SIZE(arr2);
 	bpf_iter_num_new(&it, 0, n);
-	fill(&it, arr2, n, 10);
+	fill(&it, arr2, 10);
 	bpf_iter_num_destroy(&it);
 
 	/* sum arr1 */
 	n = ARRAY_SIZE(arr1);
 	bpf_iter_num_new(&it, 0, n);
-	sum1 = sum(&it, arr1, n);
+	sum1 = sum(&it, arr1);
 	bpf_iter_num_destroy(&it);
 
 	/* sum arr2 */
 	n = ARRAY_SIZE(arr2);
 	bpf_iter_num_new(&it, 0, n);
-	sum2 = sum(&it, arr2, n);
+	sum2 = sum(&it, arr2);
 	bpf_iter_num_destroy(&it);
 
 	bpf_printk("sum1=%d, sum2=%d", sum1, sum2);
-- 
2.34.1

