Return-Path: <bpf+bounces-14901-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F88F7E8DD3
	for <lists+bpf@lfdr.de>; Sun, 12 Nov 2023 02:07:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 258A6280D93
	for <lists+bpf@lfdr.de>; Sun, 12 Nov 2023 01:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7580415C1;
	Sun, 12 Nov 2023 01:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E0417E1
	for <bpf@vger.kernel.org>; Sun, 12 Nov 2023 01:06:57 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 468B230FA
	for <bpf@vger.kernel.org>; Sat, 11 Nov 2023 17:06:55 -0800 (PST)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ABN7Ahv025612
	for <bpf@vger.kernel.org>; Sat, 11 Nov 2023 17:06:55 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3ua86tajk3-20
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Sat, 11 Nov 2023 17:06:54 -0800
Received: from twshared40933.03.prn6.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a8:82::b) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Sat, 11 Nov 2023 17:06:50 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id A22303B5D52A1; Sat, 11 Nov 2023 17:06:45 -0800 (PST)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH v2 bpf-next 10/13] selftests/bpf: add randomized reg_bounds tests
Date: Sat, 11 Nov 2023 17:06:06 -0800
Message-ID: <20231112010609.848406-11-andrii@kernel.org>
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
X-Proofpoint-GUID: jWKmKdijK4JsB8YPIlF8k7iwGK3F-UKB
X-Proofpoint-ORIG-GUID: jWKmKdijK4JsB8YPIlF8k7iwGK3F-UKB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-11_21,2023-11-09_01,2023-05-22_02

Add random cases generation to reg_bounds.c and run them without
SLOW_TESTS=3D1 to increase a chance of BPF CI catching latent issues.

Suggested-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 .../selftests/bpf/prog_tests/reg_bounds.c     | 166 +++++++++++++++++-
 1 file changed, 159 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/reg_bounds.c b/tools/=
testing/selftests/bpf/prog_tests/reg_bounds.c
index 5320fe5d9433..f3f724062b35 100644
--- a/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
+++ b/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
@@ -83,6 +83,17 @@ static __always_inline u64 max_t(enum num_t t, u64 x, =
u64 y)
 	}
 }
=20
+static __always_inline u64 cast_t(enum num_t t, u64 x)
+{
+	switch (t) {
+	case U64: return (u64)x;
+	case U32: return (u32)x;
+	case S64: return (s64)x;
+	case S32: return (u32)(s32)x;
+	default: printf("cast_t!\n"); exit(1);
+	}
+}
+
 static const char *t_str(enum num_t t)
 {
 	switch (t) {
@@ -1312,8 +1323,10 @@ struct ctx {
 	struct range *usubranges, *ssubranges;
 	int max_failure_cnt, cur_failure_cnt;
 	int total_case_cnt, case_cnt;
+	int rand_case_cnt;
+	unsigned rand_seed;
 	__u64 start_ns;
-	char progress_ctx[32];
+	char progress_ctx[64];
 };
=20
 static void cleanup_ctx(struct ctx *ctx)
@@ -1644,11 +1657,6 @@ static int parse_env_vars(struct ctx *ctx)
 {
 	const char *s;
=20
-	if (!(s =3D getenv("SLOW_TESTS")) || strcmp(s, "1") !=3D 0) {
-		test__skip();
-		return -ENOTSUP;
-	}
-
 	if ((s =3D getenv("REG_BOUNDS_MAX_FAILURE_CNT"))) {
 		errno =3D 0;
 		ctx->max_failure_cnt =3D strtol(s, NULL, 10);
@@ -1658,13 +1666,37 @@ static int parse_env_vars(struct ctx *ctx)
 		}
 	}
=20
+	if ((s =3D getenv("REG_BOUNDS_RAND_CASE_CNT"))) {
+		errno =3D 0;
+		ctx->rand_case_cnt =3D strtol(s, NULL, 10);
+		if (errno || ctx->rand_case_cnt < 0) {
+			ASSERT_OK(-errno, "REG_BOUNDS_RAND_CASE_CNT");
+			return -EINVAL;
+		}
+	}
+
+	if ((s =3D getenv("REG_BOUNDS_RAND_SEED"))) {
+		errno =3D 0;
+		ctx->rand_seed =3D strtoul(s, NULL, 10);
+		if (errno) {
+			ASSERT_OK(-errno, "REG_BOUNDS_RAND_SEED");
+			return -EINVAL;
+		}
+	}
+
 	return 0;
 }
=20
 static int prepare_gen_tests(struct ctx *ctx)
 {
+	const char *s;
 	int err;
=20
+	if (!(s =3D getenv("SLOW_TESTS")) || strcmp(s, "1") !=3D 0) {
+		test__skip();
+		return -ENOTSUP;
+	}
+
 	err =3D parse_env_vars(ctx);
 	if (err)
 		return err;
@@ -1794,7 +1826,7 @@ static void validate_gen_range_vs_range(enum num_t =
init_t, enum num_t cond_t)
 		exit(1);
 	}
=20
-	ctx.total_case_cnt =3D (MAX_OP - MIN_OP + 1) * (2 * rcnt * (rcnt + 1) /=
 2);
+	ctx.total_case_cnt =3D (last_op - first_op + 1) * (2 * rcnt * (rcnt + 1=
) / 2);
 	ctx.start_ns =3D get_time_ns();
 	snprintf(ctx.progress_ctx, sizeof(ctx.progress_ctx),
 		 "RANGE x RANGE, %s -> %s",
@@ -1865,6 +1897,126 @@ void test_reg_bounds_gen_ranges_s32_s64(void) { v=
alidate_gen_range_vs_range(S32,
 void test_reg_bounds_gen_ranges_s32_u32(void) { validate_gen_range_vs_ra=
nge(S32, U32); }
 void test_reg_bounds_gen_ranges_s32_s32(void) { validate_gen_range_vs_ra=
nge(S32, S32); }
=20
+#define DEFAULT_RAND_CASE_CNT 25
+
+#define RAND_21BIT_MASK ((1 << 22) - 1)
+
+static u64 rand_u64()
+{
+	/* RAND_MAX is guaranteed to be at least 1<<15, but in practice it
+	 * seems to be 1<<31, so we need to call it thrice to get full u64;
+	 * we'll use rougly equal split: 22 + 21 + 21 bits
+	 */
+	return ((u64)random() << 42) |
+	       (((u64)random() & RAND_21BIT_MASK) << 21) |
+	       (random() & RAND_21BIT_MASK);
+}
+
+static u64 rand_const(enum num_t t)
+{
+	return cast_t(t, rand_u64());
+}
+
+static struct range rand_range(enum num_t t)
+{
+	u64 x =3D rand_const(t), y =3D rand_const(t);
+
+	return range(t, min_t(t, x, y), max_t(t, x, y));
+}
+
+static void validate_rand_ranges(enum num_t init_t, enum num_t cond_t, b=
ool const_range)
+{
+	struct ctx ctx;
+	struct range range1, range2;
+	int err, i;
+	u64 t;
+
+	memset(&ctx, 0, sizeof(ctx));
+
+	err =3D parse_env_vars(&ctx);
+	if (err) {
+		ASSERT_OK(err, "parse_env_vars");
+		return;
+	}
+
+	if (ctx.rand_case_cnt =3D=3D 0)
+		ctx.rand_case_cnt =3D DEFAULT_RAND_CASE_CNT;
+	if (ctx.rand_seed =3D=3D 0)
+		ctx.rand_seed =3D (unsigned)get_time_ns();
+
+	srandom(ctx.rand_seed);
+
+	ctx.total_case_cnt =3D (last_op - first_op + 1) * (2 * ctx.rand_case_cn=
t);
+	ctx.start_ns =3D get_time_ns();
+	snprintf(ctx.progress_ctx, sizeof(ctx.progress_ctx),
+		 "[RANDOM SEED %u] RANGE x %s, %s -> %s",
+		 ctx.rand_seed, const_range ? "CONST" : "RANGE",
+		 t_str(init_t), t_str(cond_t));
+	fprintf(env.stdout, "%s\n", ctx.progress_ctx);
+
+	for (i =3D 0; i < ctx.rand_case_cnt; i++) {
+		range1 =3D rand_range(init_t);
+		if (const_range) {
+			t =3D rand_const(init_t);
+			range2 =3D range(init_t, t, t);
+		} else {
+			range2 =3D rand_range(init_t);
+		}
+
+		/* <range1> x <range2> */
+		if (verify_case(&ctx, init_t, cond_t, range1, range2))
+			goto cleanup;
+		/* <range2> x <range1> */
+		if (verify_case(&ctx, init_t, cond_t, range2, range1))
+			goto cleanup;
+	}
+
+cleanup:
+	cleanup_ctx(&ctx);
+}
+
+/* [RANDOM] RANGE x CONST, U64 initial range */
+void test_reg_bounds_rand_consts_u64_u64(void) { validate_rand_ranges(U6=
4, U64, true /* const */); }
+void test_reg_bounds_rand_consts_u64_s64(void) { validate_rand_ranges(U6=
4, S64, true /* const */); }
+void test_reg_bounds_rand_consts_u64_u32(void) { validate_rand_ranges(U6=
4, U32, true /* const */); }
+void test_reg_bounds_rand_consts_u64_s32(void) { validate_rand_ranges(U6=
4, S32, true /* const */); }
+/* [RANDOM] RANGE x CONST, S64 initial range */
+void test_reg_bounds_rand_consts_s64_u64(void) { validate_rand_ranges(S6=
4, U64, true /* const */); }
+void test_reg_bounds_rand_consts_s64_s64(void) { validate_rand_ranges(S6=
4, S64, true /* const */); }
+void test_reg_bounds_rand_consts_s64_u32(void) { validate_rand_ranges(S6=
4, U32, true /* const */); }
+void test_reg_bounds_rand_consts_s64_s32(void) { validate_rand_ranges(S6=
4, S32, true /* const */); }
+/* [RANDOM] RANGE x CONST, U32 initial range */
+void test_reg_bounds_rand_consts_u32_u64(void) { validate_rand_ranges(U3=
2, U64, true /* const */); }
+void test_reg_bounds_rand_consts_u32_s64(void) { validate_rand_ranges(U3=
2, S64, true /* const */); }
+void test_reg_bounds_rand_consts_u32_u32(void) { validate_rand_ranges(U3=
2, U32, true /* const */); }
+void test_reg_bounds_rand_consts_u32_s32(void) { validate_rand_ranges(U3=
2, S32, true /* const */); }
+/* [RANDOM] RANGE x CONST, S32 initial range */
+void test_reg_bounds_rand_consts_s32_u64(void) { validate_rand_ranges(S3=
2, U64, true /* const */); }
+void test_reg_bounds_rand_consts_s32_s64(void) { validate_rand_ranges(S3=
2, S64, true /* const */); }
+void test_reg_bounds_rand_consts_s32_u32(void) { validate_rand_ranges(S3=
2, U32, true /* const */); }
+void test_reg_bounds_rand_consts_s32_s32(void) { validate_rand_ranges(S3=
2, S32, true /* const */); }
+
+/* [RANDOM] RANGE x RANGE, U64 initial range */
+void test_reg_bounds_rand_ranges_u64_u64(void) { validate_rand_ranges(U6=
4, U64, false /* range */); }
+void test_reg_bounds_rand_ranges_u64_s64(void) { validate_rand_ranges(U6=
4, S64, false /* range */); }
+void test_reg_bounds_rand_ranges_u64_u32(void) { validate_rand_ranges(U6=
4, U32, false /* range */); }
+void test_reg_bounds_rand_ranges_u64_s32(void) { validate_rand_ranges(U6=
4, S32, false /* range */); }
+/* [RANDOM] RANGE x RANGE, S64 initial range */
+void test_reg_bounds_rand_ranges_s64_u64(void) { validate_rand_ranges(S6=
4, U64, false /* range */); }
+void test_reg_bounds_rand_ranges_s64_s64(void) { validate_rand_ranges(S6=
4, S64, false /* range */); }
+void test_reg_bounds_rand_ranges_s64_u32(void) { validate_rand_ranges(S6=
4, U32, false /* range */); }
+void test_reg_bounds_rand_ranges_s64_s32(void) { validate_rand_ranges(S6=
4, S32, false /* range */); }
+/* [RANDOM] RANGE x RANGE, U32 initial range */
+void test_reg_bounds_rand_ranges_u32_u64(void) { validate_rand_ranges(U3=
2, U64, false /* range */); }
+void test_reg_bounds_rand_ranges_u32_s64(void) { validate_rand_ranges(U3=
2, S64, false /* range */); }
+void test_reg_bounds_rand_ranges_u32_u32(void) { validate_rand_ranges(U3=
2, U32, false /* range */); }
+void test_reg_bounds_rand_ranges_u32_s32(void) { validate_rand_ranges(U3=
2, S32, false /* range */); }
+/* [RANDOM] RANGE x RANGE, S32 initial range */
+void test_reg_bounds_rand_ranges_s32_u64(void) { validate_rand_ranges(S3=
2, U64, false /* range */); }
+void test_reg_bounds_rand_ranges_s32_s64(void) { validate_rand_ranges(S3=
2, S64, false /* range */); }
+void test_reg_bounds_rand_ranges_s32_u32(void) { validate_rand_ranges(S3=
2, U32, false /* range */); }
+void test_reg_bounds_rand_ranges_s32_s32(void) { validate_rand_ranges(S3=
2, S32, false /* range */); }
+
 /* A set of hard-coded "interesting" cases to validate as part of normal
  * test_progs test runs
  */
--=20
2.34.1


