Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D29A6EEB1C
	for <lists+bpf@lfdr.de>; Wed, 26 Apr 2023 01:49:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237052AbjDYXtv convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Tue, 25 Apr 2023 19:49:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237060AbjDYXtt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 Apr 2023 19:49:49 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC58A13FAF
        for <bpf@vger.kernel.org>; Tue, 25 Apr 2023 16:49:48 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33PLEljM004044
        for <bpf@vger.kernel.org>; Tue, 25 Apr 2023 16:49:48 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3q6f8ucgyk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 25 Apr 2023 16:49:47 -0700
Received: from twshared35445.38.frc1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 25 Apr 2023 16:49:47 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 4623C2F2D84D9; Tue, 25 Apr 2023 16:49:35 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC:     <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH bpf-next 10/10] selftests/bpf: revert iter test subprog precision workaround
Date:   Tue, 25 Apr 2023 16:49:11 -0700
Message-ID: <20230425234911.2113352-11-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230425234911.2113352-1-andrii@kernel.org>
References: <20230425234911.2113352-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: Yw9VWz8DLnfqSFPYYOSICi6GOh7ndpe3
X-Proofpoint-ORIG-GUID: Yw9VWz8DLnfqSFPYYOSICi6GOh7ndpe3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-25_10,2023-04-25_01,2023-02-09_01
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Now that precision propagation is supported fully in the presence of
subprogs, there is no need to work around iter test. Revert original
workaround.

This reverts be7dbd275dc6 ("selftests/bpf: avoid mark_all_scalars_precise() trigger in one of iter tests").

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/testing/selftests/bpf/progs/iters.c | 26 ++++++++++-------------
 1 file changed, 11 insertions(+), 15 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/iters.c b/tools/testing/selftests/bpf/progs/iters.c
index be16143ae292..6b9b3c56f009 100644
--- a/tools/testing/selftests/bpf/progs/iters.c
+++ b/tools/testing/selftests/bpf/progs/iters.c
@@ -651,29 +651,25 @@ int iter_stack_array_loop(const void *ctx)
 	return sum;
 }
 
-#define ARR_SZ 16
-
-static __noinline void fill(struct bpf_iter_num *it, int *arr, int mul)
+static __noinline void fill(struct bpf_iter_num *it, int *arr, __u32 n, int mul)
 {
-	int *t;
-	__u64 i;
+	int *t, i;
 
 	while ((t = bpf_iter_num_next(it))) {
 		i = *t;
-		if (i >= ARR_SZ)
+		if (i >= n)
 			break;
 		arr[i] =  i * mul;
 	}
 }
 
-static __noinline int sum(struct bpf_iter_num *it, int *arr)
+static __noinline int sum(struct bpf_iter_num *it, int *arr, __u32 n)
 {
-	int *t, sum = 0;;
-	__u64 i;
+	int *t, i, sum = 0;;
 
 	while ((t = bpf_iter_num_next(it))) {
 		i = *t;
-		if (i >= ARR_SZ)
+		if (i >= n)
 			break;
 		sum += arr[i];
 	}
@@ -685,7 +681,7 @@ SEC("raw_tp")
 __success
 int iter_pass_iter_ptr_to_subprog(const void *ctx)
 {
-	int arr1[ARR_SZ], arr2[ARR_SZ];
+	int arr1[16], arr2[32];
 	struct bpf_iter_num it;
 	int n, sum1, sum2;
 
@@ -694,25 +690,25 @@ int iter_pass_iter_ptr_to_subprog(const void *ctx)
 	/* fill arr1 */
 	n = ARRAY_SIZE(arr1);
 	bpf_iter_num_new(&it, 0, n);
-	fill(&it, arr1, 2);
+	fill(&it, arr1, n, 2);
 	bpf_iter_num_destroy(&it);
 
 	/* fill arr2 */
 	n = ARRAY_SIZE(arr2);
 	bpf_iter_num_new(&it, 0, n);
-	fill(&it, arr2, 10);
+	fill(&it, arr2, n, 10);
 	bpf_iter_num_destroy(&it);
 
 	/* sum arr1 */
 	n = ARRAY_SIZE(arr1);
 	bpf_iter_num_new(&it, 0, n);
-	sum1 = sum(&it, arr1);
+	sum1 = sum(&it, arr1, n);
 	bpf_iter_num_destroy(&it);
 
 	/* sum arr2 */
 	n = ARRAY_SIZE(arr2);
 	bpf_iter_num_new(&it, 0, n);
-	sum2 = sum(&it, arr2);
+	sum2 = sum(&it, arr2, n);
 	bpf_iter_num_destroy(&it);
 
 	bpf_printk("sum1=%d, sum2=%d", sum1, sum2);
-- 
2.34.1

