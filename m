Return-Path: <bpf+bounces-15386-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E57337F1BEB
	for <lists+bpf@lfdr.de>; Mon, 20 Nov 2023 19:05:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F0E91C20FD9
	for <lists+bpf@lfdr.de>; Mon, 20 Nov 2023 18:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9658B2FE2D;
	Mon, 20 Nov 2023 18:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20AE092
	for <bpf@vger.kernel.org>; Mon, 20 Nov 2023 10:05:29 -0800 (PST)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 3AKHd8AV012593
	for <bpf@vger.kernel.org>; Mon, 20 Nov 2023 10:05:28 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
	by m0001303.ppops.net (PPS) with ESMTPS id 3ugbt18bdn-17
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Mon, 20 Nov 2023 10:05:28 -0800
Received: from twshared68648.02.prn6.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 20 Nov 2023 10:05:12 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id AAB463BD4ED54; Mon, 20 Nov 2023 10:04:58 -0800 (PST)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH bpf-next] selftests/bpf: reduce verboseness of reg_bounds selftest logs
Date: Mon, 20 Nov 2023 10:04:52 -0800
Message-ID: <20231120180452.145849-1-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 4Az4jU8FRvm-qwjMmsAwoIjmZ-lqE3U-
X-Proofpoint-ORIG-GUID: 4Az4jU8FRvm-qwjMmsAwoIjmZ-lqE3U-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-20_18,2023-11-20_01,2023-05-22_02

Reduce verboseness of test_progs' output in reg_bounds set of tests with
two changes.

First, instead of each different operator (<, <=3D, >, ...) being it's ow=
n
subtest, combine all different ops for the same (x, y, init_t, cond_t)
values into single subtest. Instead of getting 6 subtests, we get one
generic one, e.g.:

  #192/53  reg_bounds_crafted/(s64)[0xffffffffffffffff; 0] (s64)<op> 0xff=
ffffff00000000:OK

Second, for random generated test cases, treat all of them as a single
test to eliminate very verbose output with random values in them. So now
we'll just get one line per each combination of (init_t, cond_t),
instead of 6 x 25 =3D 150 subtests before this change:

  #225     reg_bounds_rand_consts_s32_s32:OK

Given we reduce verboseness so much, it makes sense to do a bit more
random testing, so we also bump default number of random tests to 100,
up from 25. This doesn't increase runtime significantly, especially in
parallelized mode.

With all the above changes we still make sure that we have all the
information necessary for reproducing test case if it happens to fail.
That includes reporting random seed and specific operator that is
failing. Those will only be printed to console if related test/subtest
fails, so it doesn't have any added verboseness implications.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 .../selftests/bpf/prog_tests/reg_bounds.c     | 32 ++++++++++++-------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/reg_bounds.c b/tools/=
testing/selftests/bpf/prog_tests/reg_bounds.c
index fd4ab23e6f54..0c9abd279e18 100644
--- a/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
+++ b/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
@@ -1361,11 +1361,11 @@ struct subtest_case {
 	enum op op;
 };
=20
-static void subtest_case_str(struct strbuf *sb, struct subtest_case *t)
+static void subtest_case_str(struct strbuf *sb, struct subtest_case *t, =
bool use_op)
 {
 	snappendf(sb, "(%s)", t_str(t->init_t));
 	snprintf_range(t->init_t, sb, t->x);
-	snappendf(sb, " (%s)%s ", t_str(t->cond_t), op_str(t->op));
+	snappendf(sb, " (%s)%s ", t_str(t->cond_t), use_op ? op_str(t->op) : "<=
op>");
 	snprintf_range(t->init_t, sb, t->y);
 }
=20
@@ -1440,8 +1440,8 @@ static int verify_case_op(enum num_t init_t, enum n=
um_t cond_t,
 /* Given setup ranges and number types, go over all supported operations=
,
  * generating individual subtest for each allowed combination
  */
-static int verify_case(struct ctx *ctx, enum num_t init_t, enum num_t co=
nd_t,
-		       struct range x, struct range y)
+static int verify_case_opt(struct ctx *ctx, enum num_t init_t, enum num_=
t cond_t,
+			   struct range x, struct range y, bool is_subtest)
 {
 	DEFINE_STRBUF(sb, 256);
 	int err;
@@ -1452,11 +1452,14 @@ static int verify_case(struct ctx *ctx, enum num_=
t init_t, enum num_t cond_t,
 		.y =3D y,
 	};
=20
+	sb->pos =3D 0; /* reset position in strbuf */
+	subtest_case_str(sb, &sub, false /* ignore op */);
+	if (is_subtest && !test__start_subtest(sb->buf))
+		return 0;
+
 	for (sub.op =3D first_op; sub.op <=3D last_op; sub.op++) {
 		sb->pos =3D 0; /* reset position in strbuf */
-		subtest_case_str(sb, &sub);
-		if (!test__start_subtest(sb->buf))
-			continue;
+		subtest_case_str(sb, &sub, true /* print op */);
=20
 		if (env.verbosity >=3D VERBOSE_NORMAL) /* this speeds up debugging */
 			printf("TEST CASE: %s\n", sb->buf);
@@ -1491,6 +1494,12 @@ static int verify_case(struct ctx *ctx, enum num_t=
 init_t, enum num_t cond_t,
 	return 0;
 }
=20
+static int verify_case(struct ctx *ctx, enum num_t init_t, enum num_t co=
nd_t,
+		       struct range x, struct range y)
+{
+	return verify_case_opt(ctx, init_t, cond_t, x, y, true /* is_subtest */=
);
+}
+
 /* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
  * GENERATED CASES FROM SEED VALUES
  * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
@@ -1913,7 +1922,7 @@ void test_reg_bounds_gen_ranges_s32_s64(void) { val=
idate_gen_range_vs_range(S32,
 void test_reg_bounds_gen_ranges_s32_u32(void) { validate_gen_range_vs_ra=
nge(S32, U32); }
 void test_reg_bounds_gen_ranges_s32_s32(void) { validate_gen_range_vs_ra=
nge(S32, S32); }
=20
-#define DEFAULT_RAND_CASE_CNT 25
+#define DEFAULT_RAND_CASE_CNT 100
=20
 #define RAND_21BIT_MASK ((1 << 22) - 1)
=20
@@ -1968,7 +1977,6 @@ static void validate_rand_ranges(enum num_t init_t,=
 enum num_t cond_t, bool cons
 		 "[RANDOM SEED %u] RANGE x %s, %s -> %s",
 		 ctx.rand_seed, const_range ? "CONST" : "RANGE",
 		 t_str(init_t), t_str(cond_t));
-	fprintf(env.stdout, "%s\n", ctx.progress_ctx);
=20
 	for (i =3D 0; i < ctx.rand_case_cnt; i++) {
 		range1 =3D rand_range(init_t);
@@ -1980,14 +1988,16 @@ static void validate_rand_ranges(enum num_t init_=
t, enum num_t cond_t, bool cons
 		}
=20
 		/* <range1> x <range2> */
-		if (verify_case(&ctx, init_t, cond_t, range1, range2))
+		if (verify_case_opt(&ctx, init_t, cond_t, range1, range2, false /* !is=
_subtest */))
 			goto cleanup;
 		/* <range2> x <range1> */
-		if (verify_case(&ctx, init_t, cond_t, range2, range1))
+		if (verify_case_opt(&ctx, init_t, cond_t, range2, range1, false /* !is=
_subtest */))
 			goto cleanup;
 	}
=20
 cleanup:
+	/* make sure we report random seed for reproducing */
+	ASSERT_TRUE(true, ctx.progress_ctx);
 	cleanup_ctx(&ctx);
 }
=20
--=20
2.34.1


