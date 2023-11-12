Return-Path: <bpf+bounces-14900-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B8DD7E8DD4
	for <lists+bpf@lfdr.de>; Sun, 12 Nov 2023 02:07:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2653B20AC5
	for <lists+bpf@lfdr.de>; Sun, 12 Nov 2023 01:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DEA317ED;
	Sun, 12 Nov 2023 01:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E30FE15B6
	for <bpf@vger.kernel.org>; Sun, 12 Nov 2023 01:06:55 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98CF430F9
	for <bpf@vger.kernel.org>; Sat, 11 Nov 2023 17:06:53 -0800 (PST)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AC0qDJX013669
	for <bpf@vger.kernel.org>; Sat, 11 Nov 2023 17:06:53 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3ua86tajm2-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Sat, 11 Nov 2023 17:06:53 -0800
Received: from twshared15991.38.frc1.facebook.com (2620:10d:c0a8:1c::1b) by
 mail.thefacebook.com (2620:10d:c0a8:82::b) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Sat, 11 Nov 2023 17:06:49 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 93B473B5D528E; Sat, 11 Nov 2023 17:06:43 -0800 (PST)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH v2 bpf-next 09/13] selftests/bpf: add range x range test to reg_bounds
Date: Sat, 11 Nov 2023 17:06:05 -0800
Message-ID: <20231112010609.848406-10-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231112010609.848406-1-andrii@kernel.org>
References: <20231112010609.848406-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: EFZBKv03Dm7GZWdiB4q-6rfn1iwdEpZM
X-Proofpoint-ORIG-GUID: EFZBKv03Dm7GZWdiB4q-6rfn1iwdEpZM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-11_21,2023-11-09_01,2023-05-22_02

Now that verifier supports range vs range bounds adjustments, validate
that by checking each generated range against every other generated
range, across all supported operators (everything by JSET).

We also add few cases that were problematic during development either
for verifier or for selftest's range tracking implementation.

Note that we utilize the same trick with splitting everything into
multiple independent parallelizable tests, but init_t and cond_t. This
brings down verification time in parallel mode from more than 8 hours
down to less that 1.5 hours. 106 million cases were successfully
validate for range vs range logic, in addition to about 7 million range
vs const cases, added in earlier patch.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 .../selftests/bpf/prog_tests/reg_bounds.c     | 86 +++++++++++++++++++
 1 file changed, 86 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/reg_bounds.c b/tools/=
testing/selftests/bpf/prog_tests/reg_bounds.c
index 10f3b6898274..5320fe5d9433 100644
--- a/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
+++ b/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
@@ -1760,6 +1760,60 @@ static void validate_gen_range_vs_const_32(enum nu=
m_t init_t, enum num_t cond_t)
 	cleanup_ctx(&ctx);
 }
=20
+static void validate_gen_range_vs_range(enum num_t init_t, enum num_t co=
nd_t)
+{
+	struct ctx ctx;
+	const struct range *ranges;
+	int i, j, rcnt;
+
+	memset(&ctx, 0, sizeof(ctx));
+
+	if (prepare_gen_tests(&ctx))
+		goto cleanup;
+
+	switch (init_t)
+	{
+	case U64:
+		ranges =3D ctx.uranges;
+		rcnt =3D ctx.range_cnt;
+		break;
+	case U32:
+		ranges =3D ctx.usubranges;
+		rcnt =3D ctx.subrange_cnt;
+		break;
+	case S64:
+		ranges =3D ctx.sranges;
+		rcnt =3D ctx.range_cnt;
+		break;
+	case S32:
+		ranges =3D ctx.ssubranges;
+		rcnt =3D ctx.subrange_cnt;
+		break;
+	default:
+		printf("validate_gen_range_vs_range!\n");
+		exit(1);
+	}
+
+	ctx.total_case_cnt =3D (MAX_OP - MIN_OP + 1) * (2 * rcnt * (rcnt + 1) /=
 2);
+	ctx.start_ns =3D get_time_ns();
+	snprintf(ctx.progress_ctx, sizeof(ctx.progress_ctx),
+		 "RANGE x RANGE, %s -> %s",
+		 t_str(init_t), t_str(cond_t));
+
+	for (i =3D 0; i < rcnt; i++) {
+		for (j =3D i; j < rcnt; j++) {
+			/* (<range> x <range>) */
+			if (verify_case(&ctx, init_t, cond_t, ranges[i], ranges[j]))
+				goto cleanup;
+			if (verify_case(&ctx, init_t, cond_t, ranges[j], ranges[i]))
+				goto cleanup;
+		}
+	}
+
+cleanup:
+	cleanup_ctx(&ctx);
+}
+
 /* Go over thousands of test cases generated from initial seed values.
  * Given this take a long time, guard this begind SLOW_TESTS=3D1 envvar.=
 If
  * envvar is not set, this test is skipped during test_progs testing.
@@ -1790,6 +1844,27 @@ void test_reg_bounds_gen_consts_s32_s64(void) { va=
lidate_gen_range_vs_const_32(S
 void test_reg_bounds_gen_consts_s32_u32(void) { validate_gen_range_vs_co=
nst_32(S32, U32); }
 void test_reg_bounds_gen_consts_s32_s32(void) { validate_gen_range_vs_co=
nst_32(S32, S32); }
=20
+/* RANGE x RANGE, U64 initial range */
+void test_reg_bounds_gen_ranges_u64_u64(void) { validate_gen_range_vs_ra=
nge(U64, U64); }
+void test_reg_bounds_gen_ranges_u64_s64(void) { validate_gen_range_vs_ra=
nge(U64, S64); }
+void test_reg_bounds_gen_ranges_u64_u32(void) { validate_gen_range_vs_ra=
nge(U64, U32); }
+void test_reg_bounds_gen_ranges_u64_s32(void) { validate_gen_range_vs_ra=
nge(U64, S32); }
+/* RANGE x RANGE, S64 initial range */
+void test_reg_bounds_gen_ranges_s64_u64(void) { validate_gen_range_vs_ra=
nge(S64, U64); }
+void test_reg_bounds_gen_ranges_s64_s64(void) { validate_gen_range_vs_ra=
nge(S64, S64); }
+void test_reg_bounds_gen_ranges_s64_u32(void) { validate_gen_range_vs_ra=
nge(S64, U32); }
+void test_reg_bounds_gen_ranges_s64_s32(void) { validate_gen_range_vs_ra=
nge(S64, S32); }
+/* RANGE x RANGE, U32 initial range */
+void test_reg_bounds_gen_ranges_u32_u64(void) { validate_gen_range_vs_ra=
nge(U32, U64); }
+void test_reg_bounds_gen_ranges_u32_s64(void) { validate_gen_range_vs_ra=
nge(U32, S64); }
+void test_reg_bounds_gen_ranges_u32_u32(void) { validate_gen_range_vs_ra=
nge(U32, U32); }
+void test_reg_bounds_gen_ranges_u32_s32(void) { validate_gen_range_vs_ra=
nge(U32, S32); }
+/* RANGE x RANGE, S32 initial range */
+void test_reg_bounds_gen_ranges_s32_u64(void) { validate_gen_range_vs_ra=
nge(S32, U64); }
+void test_reg_bounds_gen_ranges_s32_s64(void) { validate_gen_range_vs_ra=
nge(S32, S64); }
+void test_reg_bounds_gen_ranges_s32_u32(void) { validate_gen_range_vs_ra=
nge(S32, U32); }
+void test_reg_bounds_gen_ranges_s32_s32(void) { validate_gen_range_vs_ra=
nge(S32, S32); }
+
 /* A set of hard-coded "interesting" cases to validate as part of normal
  * test_progs test runs
  */
@@ -1803,6 +1878,12 @@ static struct subtest_case crafted_cases[] =3D {
 	{U64, U64, {0x100000000ULL, 0x1fffffffeULL}, {0, 0}},
 	{U64, U64, {0x100000001ULL, 0x1000000ffULL}, {0, 0}},
=20
+	/* single point overlap, interesting BPF_EQ and BPF_NE interactions */
+	{U64, U64, {0, 1}, {1, 0x80000000}},
+	{U64, S64, {0, 1}, {1, 0x80000000}},
+	{U64, U32, {0, 1}, {1, 0x80000000}},
+	{U64, S32, {0, 1}, {1, 0x80000000}},
+
 	{U64, S64, {0, 0xffffffff00000000ULL}, {0, 0}},
 	{U64, S64, {0x7fffffffffffffffULL, 0xffffffff00000000ULL}, {0, 0}},
 	{U64, S64, {0x7fffffff00000001ULL, 0xffffffff00000000ULL}, {0, 0}},
@@ -1837,6 +1918,11 @@ static struct subtest_case crafted_cases[] =3D {
 	{U32, U32, {1, U32_MAX}, {0, 0}},
=20
 	{U32, S32, {0, U32_MAX}, {U32_MAX, U32_MAX}},
+
+	{S32, U64, {(u32)(s32)S32_MIN, (u32)(s32)S32_MIN}, {(u32)(s32)-255, 0}}=
,
+	{S32, S64, {(u32)(s32)S32_MIN, (u32)(s32)-255}, {(u32)(s32)-2, 0}},
+	{S32, S64, {0, 1}, {(u32)(s32)S32_MIN, (u32)(s32)S32_MIN}},
+	{S32, U32, {(u32)(s32)S32_MIN, (u32)(s32)S32_MIN}, {(u32)(s32)S32_MIN, =
(u32)(s32)S32_MIN}},
 };
=20
 /* Go over crafted hard-coded cases. This is fast, so we do it as part o=
f
--=20
2.34.1


