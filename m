Return-Path: <bpf+bounces-4808-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C904474FBD1
	for <lists+bpf@lfdr.de>; Wed, 12 Jul 2023 01:24:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 247CB1C20E3C
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 23:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD5B51ED48;
	Tue, 11 Jul 2023 23:24:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C2319BBE
	for <bpf@vger.kernel.org>; Tue, 11 Jul 2023 23:24:22 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27576E7E
	for <bpf@vger.kernel.org>; Tue, 11 Jul 2023 16:24:21 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36BMrDT4032767
	for <bpf@vger.kernel.org>; Tue, 11 Jul 2023 16:24:20 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3rsg8tga0b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Tue, 11 Jul 2023 16:24:20 -0700
Received: from twshared2123.40.prn1.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 11 Jul 2023 16:24:18 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 930A03461DE31; Tue, 11 Jul 2023 16:24:03 -0700 (PDT)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH bpf-next 2/2] selftests/bpf: extend existing map resize tests for per-cpu use case
Date: Tue, 11 Jul 2023 16:24:00 -0700
Message-ID: <20230711232400.1658562-2-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230711232400.1658562-1-andrii@kernel.org>
References: <20230711232400.1658562-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: Y2OBeJWqtBhK2Jo-PzOdnf9UfUdP-aSj
X-Proofpoint-GUID: Y2OBeJWqtBhK2Jo-PzOdnf9UfUdP-aSj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-11_12,2023-07-11_01,2023-05-22_02
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add a per-cpu array resizing use case and demonstrate how
bpf_get_smp_processor_id() can be used to directly access proper data
with no extra checks.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 .../selftests/bpf/prog_tests/global_map_resize.c   | 14 +++++++++++---
 .../selftests/bpf/progs/test_global_map_resize.c   |  8 ++++++--
 2 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/global_map_resize.c b=
/tools/testing/selftests/bpf/prog_tests/global_map_resize.c
index fd41425d2e5c..56b5baef35c8 100644
--- a/tools/testing/selftests/bpf/prog_tests/global_map_resize.c
+++ b/tools/testing/selftests/bpf/prog_tests/global_map_resize.c
@@ -22,7 +22,7 @@ static void global_map_resize_bss_subtest(void)
 	struct test_global_map_resize *skel;
 	struct bpf_map *map;
 	const __u32 desired_sz =3D sizeof(skel->bss->sum) + sysconf(_SC_PAGE_SI=
ZE) * 2;
-	size_t array_len, actual_sz;
+	size_t array_len, actual_sz, new_sz;
=20
 	skel =3D test_global_map_resize__open();
 	if (!ASSERT_OK_PTR(skel, "test_global_map_resize__open"))
@@ -42,6 +42,10 @@ static void global_map_resize_bss_subtest(void)
 	if (!ASSERT_EQ(bpf_map__value_size(map), desired_sz, "resize"))
 		goto teardown;
=20
+	new_sz =3D sizeof(skel->data_percpu_arr->percpu_arr[0]) * libbpf_num_po=
ssible_cpus();
+	err =3D bpf_map__set_value_size(skel->maps.data_percpu_arr, new_sz);
+	ASSERT_OK(err, "percpu_arr_resize");
+
 	/* set the expected number of elements based on the resized array */
 	array_len =3D (desired_sz - sizeof(skel->bss->sum)) / sizeof(skel->bss-=
>array[0]);
 	if (!ASSERT_GT(array_len, 1, "array_len"))
@@ -84,11 +88,11 @@ static void global_map_resize_bss_subtest(void)
=20
 static void global_map_resize_data_subtest(void)
 {
-	int err;
 	struct test_global_map_resize *skel;
 	struct bpf_map *map;
 	const __u32 desired_sz =3D sysconf(_SC_PAGE_SIZE) * 2;
-	size_t array_len, actual_sz;
+	size_t array_len, actual_sz, new_sz;
+	int err;
=20
 	skel =3D test_global_map_resize__open();
 	if (!ASSERT_OK_PTR(skel, "test_global_map_resize__open"))
@@ -108,6 +112,10 @@ static void global_map_resize_data_subtest(void)
 	if (!ASSERT_EQ(bpf_map__value_size(map), desired_sz, "resize"))
 		goto teardown;
=20
+	new_sz =3D sizeof(skel->data_percpu_arr->percpu_arr[0]) * libbpf_num_po=
ssible_cpus();
+	err =3D bpf_map__set_value_size(skel->maps.data_percpu_arr, new_sz);
+	ASSERT_OK(err, "percpu_arr_resize");
+
 	/* set the expected number of elements based on the resized array */
 	array_len =3D (desired_sz - sizeof(skel->bss->sum)) / sizeof(skel->data=
_custom->my_array[0]);
 	if (!ASSERT_GT(array_len, 1, "array_len"))
diff --git a/tools/testing/selftests/bpf/progs/test_global_map_resize.c b=
/tools/testing/selftests/bpf/progs/test_global_map_resize.c
index 2588f2384246..1fbb73d3e5d5 100644
--- a/tools/testing/selftests/bpf/progs/test_global_map_resize.c
+++ b/tools/testing/selftests/bpf/progs/test_global_map_resize.c
@@ -29,13 +29,16 @@ int my_int SEC(".data.non_array");
 int my_array_first[1] SEC(".data.array_not_last");
 int my_int_last SEC(".data.array_not_last");
=20
+int percpu_arr[1] SEC(".data.percpu_arr");
+
 SEC("tp/syscalls/sys_enter_getpid")
 int bss_array_sum(void *ctx)
 {
 	if (pid !=3D (bpf_get_current_pid_tgid() >> 32))
 		return 0;
=20
-	sum =3D 0;
+	/* this will be zero, we just rely on verifier not rejecting this */
+	sum =3D percpu_arr[bpf_get_smp_processor_id()];
=20
 	for (size_t i =3D 0; i < bss_array_len; ++i)
 		sum +=3D array[i];
@@ -49,7 +52,8 @@ int data_array_sum(void *ctx)
 	if (pid !=3D (bpf_get_current_pid_tgid() >> 32))
 		return 0;
=20
-	sum =3D 0;
+	/* this will be zero, we just rely on verifier not rejecting this */
+	sum =3D percpu_arr[bpf_get_smp_processor_id()];
=20
 	for (size_t i =3D 0; i < data_array_len; ++i)
 		sum +=3D my_array[i];
--=20
2.34.1


