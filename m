Return-Path: <bpf+bounces-94-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 798E56F7BF9
	for <lists+bpf@lfdr.de>; Fri,  5 May 2023 06:36:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4B841C2163B
	for <lists+bpf@lfdr.de>; Fri,  5 May 2023 04:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 334321876;
	Fri,  5 May 2023 04:36:18 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0CD7156C1
	for <bpf@vger.kernel.org>; Fri,  5 May 2023 04:36:17 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9DB314349
	for <bpf@vger.kernel.org>; Thu,  4 May 2023 21:36:16 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 344KBNWQ024246
	for <bpf@vger.kernel.org>; Thu, 4 May 2023 21:36:16 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3qckh42j1e-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Thu, 04 May 2023 21:36:16 -0700
Received: from twshared6687.46.prn1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 4 May 2023 21:36:13 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 2FC213006D8DA; Thu,  4 May 2023 21:33:40 -0700 (PDT)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH v3 bpf-next 10/10] selftests/bpf: revert iter test subprog precision workaround
Date: Thu, 4 May 2023 21:33:17 -0700
Message-ID: <20230505043317.3629845-11-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230505043317.3629845-1-andrii@kernel.org>
References: <20230505043317.3629845-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: j8aCYCSM1oogLxz38BltmLMan1u_8GO0
X-Proofpoint-GUID: j8aCYCSM1oogLxz38BltmLMan1u_8GO0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-04_15,2023-05-04_01,2023-02-09_01
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Now that precision propagation is supported fully in the presence of
subprogs, there is no need to work around iter test. Revert original
workaround.

This reverts be7dbd275dc6 ("selftests/bpf: avoid mark_all_scalars_precise=
() trigger in one of iter tests").

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/testing/selftests/bpf/progs/iters.c | 26 ++++++++++-------------
 1 file changed, 11 insertions(+), 15 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/iters.c b/tools/testing/se=
lftests/bpf/progs/iters.c
index be16143ae292..6b9b3c56f009 100644
--- a/tools/testing/selftests/bpf/progs/iters.c
+++ b/tools/testing/selftests/bpf/progs/iters.c
@@ -651,29 +651,25 @@ int iter_stack_array_loop(const void *ctx)
 	return sum;
 }
=20
-#define ARR_SZ 16
-
-static __noinline void fill(struct bpf_iter_num *it, int *arr, int mul)
+static __noinline void fill(struct bpf_iter_num *it, int *arr, __u32 n, =
int mul)
 {
-	int *t;
-	__u64 i;
+	int *t, i;
=20
 	while ((t =3D bpf_iter_num_next(it))) {
 		i =3D *t;
-		if (i >=3D ARR_SZ)
+		if (i >=3D n)
 			break;
 		arr[i] =3D  i * mul;
 	}
 }
=20
-static __noinline int sum(struct bpf_iter_num *it, int *arr)
+static __noinline int sum(struct bpf_iter_num *it, int *arr, __u32 n)
 {
-	int *t, sum =3D 0;;
-	__u64 i;
+	int *t, i, sum =3D 0;;
=20
 	while ((t =3D bpf_iter_num_next(it))) {
 		i =3D *t;
-		if (i >=3D ARR_SZ)
+		if (i >=3D n)
 			break;
 		sum +=3D arr[i];
 	}
@@ -685,7 +681,7 @@ SEC("raw_tp")
 __success
 int iter_pass_iter_ptr_to_subprog(const void *ctx)
 {
-	int arr1[ARR_SZ], arr2[ARR_SZ];
+	int arr1[16], arr2[32];
 	struct bpf_iter_num it;
 	int n, sum1, sum2;
=20
@@ -694,25 +690,25 @@ int iter_pass_iter_ptr_to_subprog(const void *ctx)
 	/* fill arr1 */
 	n =3D ARRAY_SIZE(arr1);
 	bpf_iter_num_new(&it, 0, n);
-	fill(&it, arr1, 2);
+	fill(&it, arr1, n, 2);
 	bpf_iter_num_destroy(&it);
=20
 	/* fill arr2 */
 	n =3D ARRAY_SIZE(arr2);
 	bpf_iter_num_new(&it, 0, n);
-	fill(&it, arr2, 10);
+	fill(&it, arr2, n, 10);
 	bpf_iter_num_destroy(&it);
=20
 	/* sum arr1 */
 	n =3D ARRAY_SIZE(arr1);
 	bpf_iter_num_new(&it, 0, n);
-	sum1 =3D sum(&it, arr1);
+	sum1 =3D sum(&it, arr1, n);
 	bpf_iter_num_destroy(&it);
=20
 	/* sum arr2 */
 	n =3D ARRAY_SIZE(arr2);
 	bpf_iter_num_new(&it, 0, n);
-	sum2 =3D sum(&it, arr2);
+	sum2 =3D sum(&it, arr2, n);
 	bpf_iter_num_destroy(&it);
=20
 	bpf_printk("sum1=3D%d, sum2=3D%d", sum1, sum2);
--=20
2.34.1


