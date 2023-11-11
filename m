Return-Path: <bpf+bounces-14885-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DDA427E8C83
	for <lists+bpf@lfdr.de>; Sat, 11 Nov 2023 21:17:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BDAB1B20B23
	for <lists+bpf@lfdr.de>; Sat, 11 Nov 2023 20:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDF191D69F;
	Sat, 11 Nov 2023 20:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA771B26D
	for <bpf@vger.kernel.org>; Sat, 11 Nov 2023 20:16:54 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D356ED72
	for <bpf@vger.kernel.org>; Sat, 11 Nov 2023 12:16:52 -0800 (PST)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 3ABHv4q5025341
	for <bpf@vger.kernel.org>; Sat, 11 Nov 2023 12:16:52 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
	by m0089730.ppops.net (PPS) with ESMTPS id 3ua60dt845-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Sat, 11 Nov 2023 12:16:51 -0800
Received: from twshared32169.15.frc2.facebook.com (2620:10d:c0a8:1c::1b) by
 mail.thefacebook.com (2620:10d:c0a8:83::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Sat, 11 Nov 2023 12:16:50 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 713703B5A8FEA; Sat, 11 Nov 2023 12:16:49 -0800 (PST)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>,
        Eduard Zingerman
	<eddyz87@gmail.com>,
        Stanislav Fomichev <sdf@google.com>
Subject: [PATCH v2 bpf-next 7/8] bpf: smarter verifier log number printing logic
Date: Sat, 11 Nov 2023 12:16:32 -0800
Message-ID: <20231111201633.3434794-8-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231111201633.3434794-1-andrii@kernel.org>
References: <20231111201633.3434794-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: SPj7PYCBb7q1edMhBZJBz4PzYKswiPF9
X-Proofpoint-ORIG-GUID: SPj7PYCBb7q1edMhBZJBz4PzYKswiPF9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-11_16,2023-11-09_01,2023-05-22_02

Instead of always printing numbers as either decimals (and in some
cases, like for "imm=3D%llx", in hexadecimals), decide the form based on
actual values. For numbers in a reasonably small range (currently,
[0, U16_MAX] for unsigned values, and [S16_MIN, S16_MAX] for signed ones)=
,
emit them as decimals. In all other cases, even for signed values,
emit them in hexadecimals.

For large values hex form is often times way more useful: it's easier to
see an exact difference between 0xffffffff80000000 and 0xffffffff7fffffff=
,
than between 18446744071562067966 and 18446744071562067967, as one
particular example.

Small values representing small pointer offsets or application
constants, on the other hand, are way more useful to be represented in
decimal notation.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Acked-by: Stanislav Fomichev <sdf@google.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/log.c                              | 79 ++++++++++++++++---
 .../selftests/bpf/progs/exceptions_assert.c   | 32 ++++----
 2 files changed, 84 insertions(+), 27 deletions(-)

diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
index 20b4f81087da..47aaec5f20f6 100644
--- a/kernel/bpf/log.c
+++ b/kernel/bpf/log.c
@@ -509,10 +509,52 @@ static void print_liveness(struct bpf_verifier_env =
*env,
 		verbose(env, "D");
 }
=20
+#define UNUM_MAX_DECIMAL U16_MAX
+#define SNUM_MAX_DECIMAL S16_MAX
+#define SNUM_MIN_DECIMAL S16_MIN
+
+static bool is_unum_decimal(u64 num)
+{
+	return num <=3D UNUM_MAX_DECIMAL;
+}
+
+static bool is_snum_decimal(s64 num)
+{
+	return num >=3D SNUM_MIN_DECIMAL && num <=3D SNUM_MAX_DECIMAL;
+}
+
+static void verbose_unum(struct bpf_verifier_env *env, u64 num)
+{
+	if (is_unum_decimal(num))
+		verbose(env, "%llu", num);
+	else
+		verbose(env, "%#llx", num);
+}
+
+static void verbose_snum(struct bpf_verifier_env *env, s64 num)
+{
+	if (is_snum_decimal(num))
+		verbose(env, "%lld", num);
+	else
+		verbose(env, "%#llx", num);
+}
+
 static void print_scalar_ranges(struct bpf_verifier_env *env,
 				const struct bpf_reg_state *reg,
 				const char **sep)
 {
+	/* For signed ranges, we want to unify 64-bit and 32-bit values in the
+	 * output as much as possible, but there is a bit of a complication.
+	 * If we choose to print values as decimals, this is natural to do,
+	 * because negative 64-bit and 32-bit values >=3D -S32_MIN have the sam=
e
+	 * representation due to sign extension. But if we choose to print
+	 * them in hex format (see is_snum_decimal()), then sign extension is
+	 * misleading.
+	 * E.g., smin=3D-2 and smin32=3D-2 are exactly the same in decimal, but=
 in
+	 * hex they will be smin=3D0xfffffffffffffffe and smin32=3D0xfffffffe, =
two
+	 * very different numbers.
+	 * So we avoid sign extension if we choose to print values in hex.
+	 */
 	struct {
 		const char *name;
 		u64 val;
@@ -522,8 +564,14 @@ static void print_scalar_ranges(struct bpf_verifier_=
env *env,
 		{"smax",   reg->smax_value,         reg->smax_value =3D=3D S64_MAX},
 		{"umin",   reg->umin_value,         reg->umin_value =3D=3D 0},
 		{"umax",   reg->umax_value,         reg->umax_value =3D=3D U64_MAX},
-		{"smin32", (s64)reg->s32_min_value, reg->s32_min_value =3D=3D S32_MIN}=
,
-		{"smax32", (s64)reg->s32_max_value, reg->s32_max_value =3D=3D S32_MAX}=
,
+		{"smin32",
+		 is_snum_decimal((s64)reg->s32_min_value)
+			 ? (s64)reg->s32_min_value
+			 : (u32)reg->s32_min_value, reg->s32_min_value =3D=3D S32_MIN},
+		{"smax32",
+		 is_snum_decimal((s64)reg->s32_max_value)
+			 ? (s64)reg->s32_max_value
+			 : (u32)reg->s32_max_value, reg->s32_max_value =3D=3D S32_MAX},
 		{"umin32", reg->u32_min_value,      reg->u32_min_value =3D=3D 0},
 		{"umax32", reg->u32_max_value,      reg->u32_max_value =3D=3D U32_MAX}=
,
 	}, *m1, *m2, *mend =3D &minmaxs[ARRAY_SIZE(minmaxs)];
@@ -549,7 +597,10 @@ static void print_scalar_ranges(struct bpf_verifier_=
env *env,
 			verbose(env, "%s=3D", m2->name);
 		}
=20
-		verbose(env, m1->name[0] =3D=3D 's' ? "%lld" : "%llu", m1->val);
+		if (m1->name[0] =3D=3D 's')
+			verbose_snum(env, m1->val);
+		else
+			verbose_unum(env, m1->val);
 	}
 }
=20
@@ -576,14 +627,14 @@ static void print_reg_state(struct bpf_verifier_env=
 *env, const struct bpf_reg_s
 	    tnum_is_const(reg->var_off)) {
 		/* reg->off should be 0 for SCALAR_VALUE */
 		verbose(env, "%s", t =3D=3D SCALAR_VALUE ? "" : reg_type_str(env, t));
-		verbose(env, "%lld", reg->var_off.value + reg->off);
+		verbose_snum(env, reg->var_off.value + reg->off);
 		return;
 	}
 /*
  * _a stands for append, was shortened to avoid multiline statements bel=
ow.
  * This macro is used to output a comma separated list of attributes.
  */
-#define verbose_a(fmt, ...) ({ verbose(env, "%s" fmt, sep, __VA_ARGS__);=
 sep =3D ","; })
+#define verbose_a(fmt, ...) ({ verbose(env, "%s" fmt, sep, ##__VA_ARGS__=
); sep =3D ","; })
=20
 	verbose(env, "%s", reg_type_str(env, t));
 	if (base_type(t) =3D=3D PTR_TO_BTF_ID)
@@ -602,14 +653,20 @@ static void print_reg_state(struct bpf_verifier_env=
 *env, const struct bpf_reg_s
 			  reg->map_ptr->key_size,
 			  reg->map_ptr->value_size);
 	}
-	if (t !=3D SCALAR_VALUE && reg->off)
-		verbose_a("off=3D%d", reg->off);
-	if (type_is_pkt_pointer(t))
-		verbose_a("r=3D%d", reg->range);
+	if (t !=3D SCALAR_VALUE && reg->off) {
+		verbose_a("off=3D");
+		verbose_snum(env, reg->off);
+	}
+	if (type_is_pkt_pointer(t)) {
+		verbose_a("r=3D");
+		verbose_snum(env, reg->range);
+	}
 	if (tnum_is_const(reg->var_off)) {
 		/* a pointer register with fixed offset */
-		if (reg->var_off.value)
-			verbose_a("imm=3D%llx", reg->var_off.value);
+		if (reg->var_off.value) {
+			verbose_a("imm=3D");
+			verbose_snum(env, reg->var_off.value);
+		}
 	} else {
 		print_scalar_ranges(env, reg, &sep);
 		if (!tnum_is_unknown(reg->var_off)) {
diff --git a/tools/testing/selftests/bpf/progs/exceptions_assert.c b/tool=
s/testing/selftests/bpf/progs/exceptions_assert.c
index 26f7d67432cc..49efaed143fc 100644
--- a/tools/testing/selftests/bpf/progs/exceptions_assert.c
+++ b/tools/testing/selftests/bpf/progs/exceptions_assert.c
@@ -18,48 +18,48 @@
 		return *(u64 *)num;					\
 	}
=20
-__msg(": R0_w=3D-2147483648 R10=3Dfp0")
+__msg(": R0_w=3D0xffffffff80000000 R10=3Dfp0")
 check_assert(s64, eq, int_min, INT_MIN);
-__msg(": R0_w=3D2147483647 R10=3Dfp0")
+__msg(": R0_w=3D0x7fffffff R10=3Dfp0")
 check_assert(s64, eq, int_max, INT_MAX);
 __msg(": R0_w=3D0 R10=3Dfp0")
 check_assert(s64, eq, zero, 0);
-__msg(": R0_w=3D-9223372036854775808 R1_w=3D-9223372036854775808 R10=3Df=
p0")
+__msg(": R0_w=3D0x8000000000000000 R1_w=3D0x8000000000000000 R10=3Dfp0")
 check_assert(s64, eq, llong_min, LLONG_MIN);
-__msg(": R0_w=3D9223372036854775807 R1_w=3D9223372036854775807 R10=3Dfp0=
")
+__msg(": R0_w=3D0x7fffffffffffffff R1_w=3D0x7fffffffffffffff R10=3Dfp0")
 check_assert(s64, eq, llong_max, LLONG_MAX);
=20
-__msg(": R0_w=3Dscalar(smax=3D2147483646) R10=3Dfp0")
+__msg(": R0_w=3Dscalar(smax=3D0x7ffffffe) R10=3Dfp0")
 check_assert(s64, lt, pos, INT_MAX);
-__msg(": R0_w=3Dscalar(smax=3D-1,umin=3D9223372036854775808,var_off=3D(0=
x8000000000000000; 0x7fffffffffffffff))")
+__msg(": R0_w=3Dscalar(smax=3D-1,umin=3D0x8000000000000000,var_off=3D(0x=
8000000000000000; 0x7fffffffffffffff))")
 check_assert(s64, lt, zero, 0);
-__msg(": R0_w=3Dscalar(smax=3D-2147483649,umin=3D9223372036854775808,uma=
x=3D18446744071562067967,var_off=3D(0x8000000000000000; 0x7ffffffffffffff=
f))")
+__msg(": R0_w=3Dscalar(smax=3D0xffffffff7fffffff,umin=3D0x80000000000000=
00,umax=3D0xffffffff7fffffff,var_off=3D(0x8000000000000000; 0x7ffffffffff=
fffff))")
 check_assert(s64, lt, neg, INT_MIN);
=20
-__msg(": R0_w=3Dscalar(smax=3D2147483647) R10=3Dfp0")
+__msg(": R0_w=3Dscalar(smax=3D0x7fffffff) R10=3Dfp0")
 check_assert(s64, le, pos, INT_MAX);
 __msg(": R0_w=3Dscalar(smax=3D0) R10=3Dfp0")
 check_assert(s64, le, zero, 0);
-__msg(": R0_w=3Dscalar(smax=3D-2147483648,umin=3D9223372036854775808,uma=
x=3D18446744071562067968,var_off=3D(0x8000000000000000; 0x7ffffffffffffff=
f))")
+__msg(": R0_w=3Dscalar(smax=3D0xffffffff80000000,umin=3D0x80000000000000=
00,umax=3D0xffffffff80000000,var_off=3D(0x8000000000000000; 0x7ffffffffff=
fffff))")
 check_assert(s64, le, neg, INT_MIN);
=20
-__msg(": R0_w=3Dscalar(smin=3Dumin=3D2147483648,umax=3D92233720368547758=
07,var_off=3D(0x0; 0x7fffffffffffffff))")
+__msg(": R0_w=3Dscalar(smin=3Dumin=3D0x80000000,umax=3D0x7ffffffffffffff=
f,var_off=3D(0x0; 0x7fffffffffffffff))")
 check_assert(s64, gt, pos, INT_MAX);
-__msg(": R0_w=3Dscalar(smin=3Dumin=3D1,umax=3D9223372036854775807,var_of=
f=3D(0x0; 0x7fffffffffffffff))")
+__msg(": R0_w=3Dscalar(smin=3Dumin=3D1,umax=3D0x7fffffffffffffff,var_off=
=3D(0x0; 0x7fffffffffffffff))")
 check_assert(s64, gt, zero, 0);
-__msg(": R0_w=3Dscalar(smin=3D-2147483647) R10=3Dfp0")
+__msg(": R0_w=3Dscalar(smin=3D0xffffffff80000001) R10=3Dfp0")
 check_assert(s64, gt, neg, INT_MIN);
=20
-__msg(": R0_w=3Dscalar(smin=3Dumin=3D2147483647,umax=3D92233720368547758=
07,var_off=3D(0x0; 0x7fffffffffffffff))")
+__msg(": R0_w=3Dscalar(smin=3Dumin=3D0x7fffffff,umax=3D0x7ffffffffffffff=
f,var_off=3D(0x0; 0x7fffffffffffffff))")
 check_assert(s64, ge, pos, INT_MAX);
-__msg(": R0_w=3Dscalar(smin=3D0,umax=3D9223372036854775807,var_off=3D(0x=
0; 0x7fffffffffffffff)) R10=3Dfp0")
+__msg(": R0_w=3Dscalar(smin=3D0,umax=3D0x7fffffffffffffff,var_off=3D(0x0=
; 0x7fffffffffffffff)) R10=3Dfp0")
 check_assert(s64, ge, zero, 0);
-__msg(": R0_w=3Dscalar(smin=3D-2147483648) R10=3Dfp0")
+__msg(": R0_w=3Dscalar(smin=3D0xffffffff80000000) R10=3Dfp0")
 check_assert(s64, ge, neg, INT_MIN);
=20
 SEC("?tc")
 __log_level(2) __failure
-__msg(": R0=3D0 R1=3Dctx() R2=3Dscalar(smin=3Dsmin32=3D-2147483646,smax=3D=
smax32=3D2147483645) R10=3Dfp0")
+__msg(": R0=3D0 R1=3Dctx() R2=3Dscalar(smin=3D0xffffffff80000002,smax=3D=
smax32=3D0x7ffffffd,smin32=3D0x80000002) R10=3Dfp0")
 int check_assert_range_s64(struct __sk_buff *ctx)
 {
 	struct bpf_sock *sk =3D ctx->sk;
--=20
2.34.1


