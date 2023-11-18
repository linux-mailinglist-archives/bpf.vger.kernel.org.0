Return-Path: <bpf+bounces-15304-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A0087EFD95
	for <lists+bpf@lfdr.de>; Sat, 18 Nov 2023 04:47:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 963E41C2099F
	for <lists+bpf@lfdr.de>; Sat, 18 Nov 2023 03:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60C90524B;
	Sat, 18 Nov 2023 03:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41C9A126
	for <bpf@vger.kernel.org>; Fri, 17 Nov 2023 19:47:05 -0800 (PST)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AI2rE6h003777
	for <bpf@vger.kernel.org>; Fri, 17 Nov 2023 19:47:05 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3uemvd856w-13
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Fri, 17 Nov 2023 19:47:04 -0800
Received: from twshared32169.15.frc2.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:21d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 17 Nov 2023 19:47:01 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 509FB3BB2FFF2; Fri, 17 Nov 2023 19:46:49 -0800 (PST)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>,
        Eduard Zingerman
	<eddyz87@gmail.com>,
        Stanislav Fomichev <sdf@google.com>
Subject: [PATCH v3 bpf-next 7/8] bpf: smarter verifier log number printing logic
Date: Fri, 17 Nov 2023 19:46:22 -0800
Message-ID: <20231118034623.3320920-8-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231118034623.3320920-1-andrii@kernel.org>
References: <20231118034623.3320920-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: kp6uYGcMkdj1yHA2b3bBxQFALoRm4wQl
X-Proofpoint-ORIG-GUID: kp6uYGcMkdj1yHA2b3bBxQFALoRm4wQl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-18_01,2023-11-17_01,2023-05-22_02

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

Adjust reg_bounds register state parsing logic to take into account this
change.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Acked-by: Stanislav Fomichev <sdf@google.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/log.c                              | 79 ++++++++++++++++---
 .../selftests/bpf/prog_tests/reg_bounds.c     | 53 ++++++++-----
 .../selftests/bpf/progs/exceptions_assert.c   | 32 ++++----
 3 files changed, 118 insertions(+), 46 deletions(-)

diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
index 20b4f81087da..87105aa482ed 100644
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
+		verbose_unum(env, reg->range);
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
diff --git a/tools/testing/selftests/bpf/prog_tests/reg_bounds.c b/tools/=
testing/selftests/bpf/prog_tests/reg_bounds.c
index 7a8b0bf0a7f8..fd4ab23e6f54 100644
--- a/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
+++ b/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
@@ -13,10 +13,13 @@
  */
 #define U64_MAX ((u64)UINT64_MAX)
 #define U32_MAX ((u32)UINT_MAX)
+#define U16_MAX ((u32)UINT_MAX)
 #define S64_MIN ((s64)INT64_MIN)
 #define S64_MAX ((s64)INT64_MAX)
 #define S32_MIN ((s32)INT_MIN)
 #define S32_MAX ((s32)INT_MAX)
+#define S16_MIN ((s16)0x80000000)
+#define S16_MAX ((s16)0x7fffffff)
=20
 typedef unsigned long long ___u64;
 typedef unsigned int ___u32;
@@ -138,13 +141,17 @@ static enum num_t t_unsigned(enum num_t t)
 	}
 }
=20
+#define UNUM_MAX_DECIMAL U16_MAX
+#define SNUM_MAX_DECIMAL S16_MAX
+#define SNUM_MIN_DECIMAL S16_MIN
+
 static bool num_is_small(enum num_t t, u64 x)
 {
 	switch (t) {
-	case U64: return (u64)x <=3D 256;
-	case U32: return (u32)x <=3D 256;
-	case S64: return (s64)x >=3D -256 && (s64)x <=3D 256;
-	case S32: return (s32)x >=3D -256 && (s32)x <=3D 256;
+	case U64: return (u64)x <=3D UNUM_MAX_DECIMAL;
+	case U32: return (u32)x <=3D UNUM_MAX_DECIMAL;
+	case S64: return (s64)x >=3D SNUM_MIN_DECIMAL && (s64)x <=3D SNUM_MAX_D=
ECIMAL;
+	case S32: return (s32)x >=3D SNUM_MIN_DECIMAL && (s32)x <=3D SNUM_MAX_D=
ECIMAL;
 	default: printf("num_is_small!\n"); exit(1);
 	}
 }
@@ -1023,20 +1030,19 @@ static int parse_reg_state(const char *s, struct =
reg_state *reg)
 	 */
 	struct {
 		const char *pfx;
-		const char *fmt;
 		u64 *dst, def;
 		bool is_32, is_set;
 	} *f, fields[8] =3D {
-		{"smin=3D", "%lld", &reg->r[S64].a, S64_MIN},
-		{"smax=3D", "%lld", &reg->r[S64].b, S64_MAX},
-		{"umin=3D", "%llu", &reg->r[U64].a, 0},
-		{"umax=3D", "%llu", &reg->r[U64].b, U64_MAX},
-		{"smin32=3D", "%lld", &reg->r[S32].a, (u32)S32_MIN, true},
-		{"smax32=3D", "%lld", &reg->r[S32].b, (u32)S32_MAX, true},
-		{"umin32=3D", "%llu", &reg->r[U32].a, 0,            true},
-		{"umax32=3D", "%llu", &reg->r[U32].b, U32_MAX,      true},
+		{"smin=3D", &reg->r[S64].a, S64_MIN},
+		{"smax=3D", &reg->r[S64].b, S64_MAX},
+		{"umin=3D", &reg->r[U64].a, 0},
+		{"umax=3D", &reg->r[U64].b, U64_MAX},
+		{"smin32=3D", &reg->r[S32].a, (u32)S32_MIN, true},
+		{"smax32=3D", &reg->r[S32].b, (u32)S32_MAX, true},
+		{"umin32=3D", &reg->r[U32].a, 0,            true},
+		{"umax32=3D", &reg->r[U32].b, U32_MAX,      true},
 	};
-	const char *p, *fmt;
+	const char *p;
 	int i;
=20
 	p =3D strchr(s, '=3D');
@@ -1050,8 +1056,13 @@ static int parse_reg_state(const char *s, struct r=
eg_state *reg)
 		long long sval;
 		enum num_t t;
=20
-		if (sscanf(p, "%lld", &sval) !=3D 1)
-			return -EINVAL;
+		if (p[0] =3D=3D '0' && p[1] =3D=3D 'x') {
+			if (sscanf(p, "%llx", &sval) !=3D 1)
+				return -EINVAL;
+		} else {
+			if (sscanf(p, "%lld", &sval) !=3D 1)
+				return -EINVAL;
+		}
=20
 		reg->valid =3D true;
 		for (t =3D first_t; t <=3D last_t; t++) {
@@ -1075,9 +1086,13 @@ static int parse_reg_state(const char *s, struct r=
eg_state *reg)
=20
 		if (mcnt) {
 			/* populate all matched fields */
-			fmt =3D fields[midxs[0]].fmt;
-			if (sscanf(p, fmt, &val) !=3D 1)
-				return -EINVAL;
+			if (p[0] =3D=3D '0' && p[1] =3D=3D 'x') {
+				if (sscanf(p, "%llx", &val) !=3D 1)
+					return -EINVAL;
+			} else {
+				if (sscanf(p, "%lld", &val) !=3D 1)
+					return -EINVAL;
+			}
=20
 			for (i =3D 0; i < mcnt; i++) {
 				f =3D &fields[midxs[i]];
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


