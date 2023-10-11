Return-Path: <bpf+bounces-11967-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE7577C606A
	for <lists+bpf@lfdr.de>; Thu, 12 Oct 2023 00:37:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E08501C21056
	for <lists+bpf@lfdr.de>; Wed, 11 Oct 2023 22:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A2BE24A1E;
	Wed, 11 Oct 2023 22:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6ECE125CD
	for <bpf@vger.kernel.org>; Wed, 11 Oct 2023 22:37:51 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61FA6C9
	for <bpf@vger.kernel.org>; Wed, 11 Oct 2023 15:37:49 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39BLJZXW027991
	for <bpf@vger.kernel.org>; Wed, 11 Oct 2023 15:37:49 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3tp16221gj-6
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Wed, 11 Oct 2023 15:37:48 -0700
Received: from twshared34392.14.frc2.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:21d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 11 Oct 2023 15:37:40 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 8B3C7399512A7; Wed, 11 Oct 2023 15:37:38 -0700 (PDT)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH bpf-next 4/5] bpf: disambiguate SCALAR register state output in verifier logs
Date: Wed, 11 Oct 2023 15:37:27 -0700
Message-ID: <20231011223728.3188086-5-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231011223728.3188086-1-andrii@kernel.org>
References: <20231011223728.3188086-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: S3QeptM6oDbNniRq8DipIyN_lzQTmuCO
X-Proofpoint-GUID: S3QeptM6oDbNniRq8DipIyN_lzQTmuCO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-11_18,2023-10-11_01,2023-05-22_02
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Currently the way that verifier prints SCALAR_VALUE register state (and
PTR_TO_PACKET, which can have var_off and ranges info as well) is very
ambiguous.

In the name of brevity we are trying to eliminate "unnecessary" output
of umin/umax, smin/smax, u32_min/u32_max, and s32_min/s32_max values, if
possible. Current rules are that if any of those have their default
value (which for mins is the minimal value of its respective types: 0,
S32_MIN, or S64_MIN, while for maxs it's U32_MAX, S32_MAX, S64_MAX, or
U64_MAX) *OR* if there is another min/max value that as matching value.
E.g., if smin=3D100 and umin=3D100, we'll emit only umin=3D10, omitting s=
min
altogether. This approach has a few problems, being both ambiguous and
sort-of incorrect in some cases.

Ambiguity is due to missing value could be either default value or value
of umin/umax or smin/smax. This is especially confusing when we mix
signed and unsigned ranges. Quite often, umin=3D0 and smin=3D0, and so we=
'll
have only `umin=3D0` leaving anyone reading verifier log to guess whether
smin is actually 0 or it's actually -9223372036854775808 (S64_MIN). And
often times it's important to know, especially when debugging tricky
issues.

"Sort-of incorrectness" comes from mixing negative and positive values.
E.g., if umin is some large positive number, it can be equal to smin
which is, interpreted as signed value, is actually some negative value.
Currently, that smin will be omitted and only umin will be emitted with
a large positive value, giving an impression that smin is also positive.

Anyway, ambiguity is the biggest issue making it impossible to have an
exact understanding of register state, preventing any sort of automated
testing of verifier state based on verifier log. This patch is
attempting to rectify the situation by removing ambiguity, while
minimizing the verboseness of register state output.

The rules are straightforward:
  - if some of the values are missing, then it definitely has a default
  value. I.e., `umin=3D0` means that umin is zero, but smin is actually
  S64_MIN;
  - all the various boundaries that happen to have the same value are
  emitted in one equality separated sequence. E.g., if umin and smin are
  both 100, we'll emit `smin=3Dumin=3D100`, making this explicit;
  - we do not mix negative and positive values together, and even if
  they happen to have the same bit-level value, they will be emitted
  separately with proper sign. I.e., if both umax and smax happen to be
  0xffffffffffffffff, we'll emit them both separately as
  `smax=3D-1,umax=3D18446744073709551615`;
  - in the name of a bit more uniformity and consistency,
  {u32,s32}_{min,max} are renamed to {s,u}{min,max}32, which seems to
  improve readability.

The above means that in case of all 4 ranges being, say, [50, 100] range,
we'd previously see hugely ambiguous:

    R1=3Dscalar(umin=3D50,umax=3D100)

Now, we'll be more explicit:

    R1=3Dscalar(smin=3Dumin=3Dsmin32=3Dumin32=3D50,smax=3Dumax=3Dsmax32=3D=
umax32=3D100)

This is slightly more verbose, but distinct from the case when we don't
know anything about signed boundaries and 32-bit boundaries, which under
new rules will match the old case:

    R1=3Dscalar(umin=3D50,umax=3D100)

Also, in the name of simplicity of implementation and consistency, order
for {s,u}32_{min,max} are emitted *before* var_off. Previously they were
emitted afterwards, for unclear reasons.

This patch also includes a few fixes to selftests that expect exact
register state to accommodate slight changes to verifier format. You can
see that the changes are pretty minimal in common cases.

Note, the special case when SCALAR_VALUE register is a known constant
isn't changed, we'll emit constant value once, interpreted as signed
value.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/verifier.c                         | 67 +++++++++++++------
 .../selftests/bpf/progs/exceptions_assert.c   | 18 ++---
 .../selftests/bpf/progs/verifier_ldsx.c       |  2 +-
 3 files changed, 55 insertions(+), 32 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index eed7350e15f4..059f8e930499 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1342,6 +1342,50 @@ static void scrub_spilled_slot(u8 *stype)
 		*stype =3D STACK_MISC;
 }
=20
+static void print_scalar_ranges(struct bpf_verifier_env *env,
+				const struct bpf_reg_state *reg,
+				const char **sep)
+{
+	struct {
+		const char *name;
+		u64 val;
+		bool omit;
+	} minmaxs[] =3D {
+		{"smin",   reg->smin_value,         reg->smin_value =3D=3D S64_MIN},
+		{"smax",   reg->smax_value,         reg->smax_value =3D=3D S64_MAX},
+		{"umin",   reg->umin_value,         reg->umin_value =3D=3D 0},
+		{"umax",   reg->umax_value,         reg->umax_value =3D=3D U64_MAX},
+		{"smin32", (s64)reg->s32_min_value, reg->s32_min_value =3D=3D S32_MIN}=
,
+		{"smax32", (s64)reg->s32_max_value, reg->s32_max_value =3D=3D S32_MAX}=
,
+		{"umin32", reg->u32_min_value,      reg->u32_min_value =3D=3D 0},
+		{"umax32", reg->u32_max_value,      reg->u32_max_value =3D=3D U32_MAX}=
,
+	}, *m1, *m2, *mend =3D &minmaxs[ARRAY_SIZE(minmaxs)];
+	bool neg1, neg2;
+
+	for (m1 =3D &minmaxs[0]; m1 < mend; m1++) {
+		if (m1->omit)
+			continue;
+
+		neg1 =3D m1->name[0] =3D=3D 's' && (s64)m1->val < 0;
+
+		verbose(env, "%s%s=3D", *sep, m1->name);
+		*sep =3D ",";
+
+		for (m2 =3D m1 + 2; m2 < mend; m2 +=3D 2) {
+			if (m2->omit || m2->val !=3D m1->val)
+				continue;
+			/* don't mix negatives with positives */
+			neg2 =3D m2->name[0] =3D=3D 's' && (s64)m2->val < 0;
+			if (neg2 !=3D neg1)
+				continue;
+			m2->omit =3D true;
+			verbose(env, "%s=3D", m2->name);
+		}
+
+		verbose(env, m1->name[0] =3D=3D 's' ? "%lld" : "%llu", m1->val);
+	}
+}
+
 static void print_verifier_state(struct bpf_verifier_env *env,
 				 const struct bpf_func_state *state,
 				 bool print_all)
@@ -1405,34 +1449,13 @@ static void print_verifier_state(struct bpf_verif=
ier_env *env,
 				 */
 				verbose_a("imm=3D%llx", reg->var_off.value);
 			} else {
-				if (reg->smin_value !=3D reg->umin_value &&
-				    reg->smin_value !=3D S64_MIN)
-					verbose_a("smin=3D%lld", (long long)reg->smin_value);
-				if (reg->smax_value !=3D reg->umax_value &&
-				    reg->smax_value !=3D S64_MAX)
-					verbose_a("smax=3D%lld", (long long)reg->smax_value);
-				if (reg->umin_value !=3D 0)
-					verbose_a("umin=3D%llu", (unsigned long long)reg->umin_value);
-				if (reg->umax_value !=3D U64_MAX)
-					verbose_a("umax=3D%llu", (unsigned long long)reg->umax_value);
+				print_scalar_ranges(env, reg, &sep);
 				if (!tnum_is_unknown(reg->var_off)) {
 					char tn_buf[48];
=20
 					tnum_strn(tn_buf, sizeof(tn_buf), reg->var_off);
 					verbose_a("var_off=3D%s", tn_buf);
 				}
-				if (reg->s32_min_value !=3D reg->smin_value &&
-				    reg->s32_min_value !=3D S32_MIN)
-					verbose_a("s32_min=3D%d", (int)(reg->s32_min_value));
-				if (reg->s32_max_value !=3D reg->smax_value &&
-				    reg->s32_max_value !=3D S32_MAX)
-					verbose_a("s32_max=3D%d", (int)(reg->s32_max_value));
-				if (reg->u32_min_value !=3D reg->umin_value &&
-				    reg->u32_min_value !=3D U32_MIN)
-					verbose_a("u32_min=3D%d", (int)(reg->u32_min_value));
-				if (reg->u32_max_value !=3D reg->umax_value &&
-				    reg->u32_max_value !=3D U32_MAX)
-					verbose_a("u32_max=3D%d", (int)(reg->u32_max_value));
 			}
 #undef verbose_a
=20
diff --git a/tools/testing/selftests/bpf/progs/exceptions_assert.c b/tool=
s/testing/selftests/bpf/progs/exceptions_assert.c
index fa35832e6748..e1e5c54a6a11 100644
--- a/tools/testing/selftests/bpf/progs/exceptions_assert.c
+++ b/tools/testing/selftests/bpf/progs/exceptions_assert.c
@@ -31,35 +31,35 @@ check_assert(s64, eq, llong_max, LLONG_MAX);
=20
 __msg(": R0_w=3Dscalar(smax=3D2147483646) R10=3Dfp0")
 check_assert(s64, lt, pos, INT_MAX);
-__msg(": R0_w=3Dscalar(umin=3D9223372036854775808,var_off=3D(0x800000000=
0000000; 0x7fffffffffffffff))")
+__msg(": R0_w=3Dscalar(smax=3D-1,umin=3D9223372036854775808,var_off=3D(0=
x8000000000000000; 0x7fffffffffffffff))")
 check_assert(s64, lt, zero, 0);
-__msg(": R0_w=3Dscalar(umin=3D9223372036854775808,umax=3D184467440715620=
67967,var_off=3D(0x8000000000000000; 0x7fffffffffffffff))")
+__msg(": R0_w=3Dscalar(smax=3D-2147483649,umin=3D9223372036854775808,uma=
x=3D18446744071562067967,var_off=3D(0x8000000000000000; 0x7ffffffffffffff=
f))")
 check_assert(s64, lt, neg, INT_MIN);
=20
 __msg(": R0_w=3Dscalar(smax=3D2147483647) R10=3Dfp0")
 check_assert(s64, le, pos, INT_MAX);
 __msg(": R0_w=3Dscalar(smax=3D0) R10=3Dfp0")
 check_assert(s64, le, zero, 0);
-__msg(": R0_w=3Dscalar(umin=3D9223372036854775808,umax=3D184467440715620=
67968,var_off=3D(0x8000000000000000; 0x7fffffffffffffff))")
+__msg(": R0_w=3Dscalar(smax=3D-2147483648,umin=3D9223372036854775808,uma=
x=3D18446744071562067968,var_off=3D(0x8000000000000000; 0x7ffffffffffffff=
f))")
 check_assert(s64, le, neg, INT_MIN);
=20
-__msg(": R0_w=3Dscalar(umin=3D2147483648,umax=3D9223372036854775807,var_=
off=3D(0x0; 0x7fffffffffffffff))")
+__msg(": R0_w=3Dscalar(smin=3Dumin=3D2147483648,umax=3D92233720368547758=
07,var_off=3D(0x0; 0x7fffffffffffffff))")
 check_assert(s64, gt, pos, INT_MAX);
-__msg(": R0_w=3Dscalar(umin=3D1,umax=3D9223372036854775807,var_off=3D(0x=
0; 0x7fffffffffffffff))")
+__msg(": R0_w=3Dscalar(smin=3Dumin=3D1,umax=3D9223372036854775807,var_of=
f=3D(0x0; 0x7fffffffffffffff))")
 check_assert(s64, gt, zero, 0);
 __msg(": R0_w=3Dscalar(smin=3D-2147483647) R10=3Dfp0")
 check_assert(s64, gt, neg, INT_MIN);
=20
-__msg(": R0_w=3Dscalar(umin=3D2147483647,umax=3D9223372036854775807,var_=
off=3D(0x0; 0x7fffffffffffffff))")
+__msg(": R0_w=3Dscalar(smin=3Dumin=3D2147483647,umax=3D92233720368547758=
07,var_off=3D(0x0; 0x7fffffffffffffff))")
 check_assert(s64, ge, pos, INT_MAX);
-__msg(": R0_w=3Dscalar(umax=3D9223372036854775807,var_off=3D(0x0; 0x7fff=
ffffffffffff)) R10=3Dfp0")
+__msg(": R0_w=3Dscalar(smin=3D0,umax=3D9223372036854775807,var_off=3D(0x=
0; 0x7fffffffffffffff)) R10=3Dfp0")
 check_assert(s64, ge, zero, 0);
 __msg(": R0_w=3Dscalar(smin=3D-2147483648) R10=3Dfp0")
 check_assert(s64, ge, neg, INT_MIN);
=20
 SEC("?tc")
 __log_level(2) __failure
-__msg(": R0=3D0 R1=3Dctx(off=3D0,imm=3D0) R2=3Dscalar(smin=3D-2147483646=
,smax=3D2147483645) R10=3Dfp0")
+__msg(": R0=3D0 R1=3Dctx(off=3D0,imm=3D0) R2=3Dscalar(smin=3Dsmin32=3D-2=
147483646,smax=3Dsmax32=3D2147483645) R10=3Dfp0")
 int check_assert_range_s64(struct __sk_buff *ctx)
 {
 	struct bpf_sock *sk =3D ctx->sk;
@@ -75,7 +75,7 @@ int check_assert_range_s64(struct __sk_buff *ctx)
=20
 SEC("?tc")
 __log_level(2) __failure
-__msg(": R1=3Dctx(off=3D0,imm=3D0) R2=3Dscalar(umin=3D4096,umax=3D8192,v=
ar_off=3D(0x0; 0x3fff))")
+__msg(": R1=3Dctx(off=3D0,imm=3D0) R2=3Dscalar(smin=3Dumin=3Dsmin32=3Dum=
in32=3D4096,smax=3Dumax=3Dsmax32=3Dumax32=3D8192,var_off=3D(0x0; 0x3fff))=
")
 int check_assert_range_u64(struct __sk_buff *ctx)
 {
 	u64 num =3D ctx->len;
diff --git a/tools/testing/selftests/bpf/progs/verifier_ldsx.c b/tools/te=
sting/selftests/bpf/progs/verifier_ldsx.c
index f90016a57eec..375525329637 100644
--- a/tools/testing/selftests/bpf/progs/verifier_ldsx.c
+++ b/tools/testing/selftests/bpf/progs/verifier_ldsx.c
@@ -64,7 +64,7 @@ __naked void ldsx_s32(void)
 SEC("socket")
 __description("LDSX, S8 range checking, privileged")
 __log_level(2) __success __retval(1)
-__msg("R1_w=3Dscalar(smin=3D-128,smax=3D127)")
+__msg("R1_w=3Dscalar(smin=3Dsmin32=3D-128,smax=3Dsmax32=3D127)")
 __naked void ldsx_s8_range_priv(void)
 {
 	asm volatile (
--=20
2.34.1


