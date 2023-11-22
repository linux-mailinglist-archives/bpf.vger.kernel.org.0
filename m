Return-Path: <bpf+bounces-15616-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AD4C7F3B1E
	for <lists+bpf@lfdr.de>; Wed, 22 Nov 2023 02:18:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDDDB1C21055
	for <lists+bpf@lfdr.de>; Wed, 22 Nov 2023 01:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7671017E1;
	Wed, 22 Nov 2023 01:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45799197
	for <bpf@vger.kernel.org>; Tue, 21 Nov 2023 17:17:49 -0800 (PST)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ALKK8Zo018592
	for <bpf@vger.kernel.org>; Tue, 21 Nov 2023 17:17:49 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3uh3g9hwub-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Tue, 21 Nov 2023 17:17:48 -0800
Received: from twshared29647.38.frc1.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 21 Nov 2023 17:17:24 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id B4E9A3BE8891E; Tue, 21 Nov 2023 17:17:11 -0800 (PST)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH bpf-next 06/10] bpf: enforce precise retval range on program exit
Date: Tue, 21 Nov 2023 17:16:52 -0800
Message-ID: <20231122011656.1105943-7-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231122011656.1105943-1-andrii@kernel.org>
References: <20231122011656.1105943-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: o676aIqBqki51xOQQMBu_R0GlseZxFaG
X-Proofpoint-GUID: o676aIqBqki51xOQQMBu_R0GlseZxFaG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-21_16,2023-11-21_01,2023-05-22_02

Similarly to subprog/callback logic, enforce return value of BPF program
using more precise umin/umax range, in addition to tnum-based check.

We need to adjust a bunch of tests due to a changed format of an error
message.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/verifier.c                         | 55 +++++++++++--------
 .../selftests/bpf/progs/exceptions_assert.c   |  2 +-
 .../selftests/bpf/progs/exceptions_fail.c     |  2 +-
 .../selftests/bpf/progs/test_global_func15.c  |  2 +-
 .../selftests/bpf/progs/timer_failure.c       |  2 +-
 .../selftests/bpf/progs/user_ringbuf_fail.c   |  2 +-
 .../bpf/progs/verifier_cgroup_inv_retcode.c   |  8 +--
 .../bpf/progs/verifier_netfilter_retcode.c    |  2 +-
 .../bpf/progs/verifier_subprog_precision.c    |  2 +-
 9 files changed, 43 insertions(+), 34 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index fc103fd03896..f2bf7593289b 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -352,20 +352,29 @@ __printf(2, 3) static void verbose(void *private_da=
ta, const char *fmt, ...)
=20
 static void verbose_invalid_scalar(struct bpf_verifier_env *env,
 				   struct bpf_reg_state *reg,
-				   struct tnum *range, const char *ctx,
+				   struct bpf_retval_range range, const char *ctx,
 				   const char *reg_name)
 {
 	char tn_buf[48];
+	bool unknown =3D true;
=20
-	verbose(env, "At %s the register %s ", ctx, reg_name);
+	verbose(env, "At %s the register %s has", ctx, reg_name);
+	if (reg->umin_value > 0) {
+		verbose(env, " umin=3D%llu", reg->umin_value);
+		unknown =3D false;
+	}
+	if (reg->umax_value < U64_MAX) {
+		verbose(env, " umax=3D%llu", reg->umax_value);
+		unknown =3D false;
+	}
 	if (!tnum_is_unknown(reg->var_off)) {
 		tnum_strn(tn_buf, sizeof(tn_buf), reg->var_off);
-		verbose(env, "has value %s", tn_buf);
-	} else {
-		verbose(env, "has unknown scalar value");
+		verbose(env, " var_off=3D%s", tn_buf);
+		unknown =3D false;
 	}
-	tnum_strn(tn_buf, sizeof(tn_buf), *range);
-	verbose(env, " should have been in %s\n", tn_buf);
+	if (unknown)
+		verbose(env, " unknown scalar value");
+	verbose(env, " should have been in [%u, %u]\n", range.minval, range.max=
val);
 }
=20
 static bool type_may_be_null(u32 type)
@@ -9522,9 +9531,8 @@ static int prepare_func_exit(struct bpf_verifier_en=
v *env, int *insn_idx)
=20
 		/* enforce R0 return value range */
 		if (!retval_range_within(callee->callback_ret_range, r0)) {
-			struct tnum range =3D retval_range_as_tnum(callee->callback_ret_range=
);
-
-			verbose_invalid_scalar(env, r0, &range, "callback return", "R0");
+			verbose_invalid_scalar(env, r0, callee->callback_ret_range,
+					       "callback return", "R0");
 			return -EINVAL;
 		}
 	} else {
@@ -14853,7 +14861,8 @@ static int check_return_code(struct bpf_verifier_=
env *env, int regno, const char
 	struct tnum enforce_attach_type_range =3D tnum_unknown;
 	const struct bpf_prog *prog =3D env->prog;
 	struct bpf_reg_state *reg;
-	struct tnum range =3D tnum_range(0, 1), const_0 =3D tnum_const(0);
+	struct bpf_retval_range range =3D retval_range(0, 1);
+	struct bpf_retval_range const_0 =3D retval_range(0, 0);
 	enum bpf_prog_type prog_type =3D resolve_prog_type(env->prog);
 	int err;
 	struct bpf_func_state *frame =3D env->cur_state->frame[0];
@@ -14901,8 +14910,8 @@ static int check_return_code(struct bpf_verifier_=
env *env, int regno, const char
 			return -EINVAL;
 		}
=20
-		if (!tnum_in(const_0, reg->var_off)) {
-			verbose_invalid_scalar(env, reg, &const_0, "async callback", reg_name=
);
+		if (!retval_range_within(const_0, reg)) {
+			verbose_invalid_scalar(env, reg, const_0, "async callback", reg_name)=
;
 			return -EINVAL;
 		}
 		return 0;
@@ -14928,14 +14937,14 @@ static int check_return_code(struct bpf_verifie=
r_env *env, int regno, const char
 		    env->prog->expected_attach_type =3D=3D BPF_CGROUP_INET4_GETSOCKNAM=
E ||
 		    env->prog->expected_attach_type =3D=3D BPF_CGROUP_INET6_GETSOCKNAM=
E ||
 		    env->prog->expected_attach_type =3D=3D BPF_CGROUP_UNIX_GETSOCKNAME=
)
-			range =3D tnum_range(1, 1);
+			range =3D retval_range(1, 1);
 		if (env->prog->expected_attach_type =3D=3D BPF_CGROUP_INET4_BIND ||
 		    env->prog->expected_attach_type =3D=3D BPF_CGROUP_INET6_BIND)
-			range =3D tnum_range(0, 3);
+			range =3D retval_range(0, 3);
 		break;
 	case BPF_PROG_TYPE_CGROUP_SKB:
 		if (env->prog->expected_attach_type =3D=3D BPF_CGROUP_INET_EGRESS) {
-			range =3D tnum_range(0, 3);
+			range =3D retval_range(0, 3);
 			enforce_attach_type_range =3D tnum_range(2, 3);
 		}
 		break;
@@ -14948,13 +14957,13 @@ static int check_return_code(struct bpf_verifie=
r_env *env, int regno, const char
 	case BPF_PROG_TYPE_RAW_TRACEPOINT:
 		if (!env->prog->aux->attach_btf_id)
 			return 0;
-		range =3D tnum_const(0);
+		range =3D retval_range(0, 0);
 		break;
 	case BPF_PROG_TYPE_TRACING:
 		switch (env->prog->expected_attach_type) {
 		case BPF_TRACE_FENTRY:
 		case BPF_TRACE_FEXIT:
-			range =3D tnum_const(0);
+			range =3D retval_range(0, 0);
 			break;
 		case BPF_TRACE_RAW_TP:
 		case BPF_MODIFY_RETURN:
@@ -14966,7 +14975,7 @@ static int check_return_code(struct bpf_verifier_=
env *env, int regno, const char
 		}
 		break;
 	case BPF_PROG_TYPE_SK_LOOKUP:
-		range =3D tnum_range(SK_DROP, SK_PASS);
+		range =3D retval_range(SK_DROP, SK_PASS);
 		break;
=20
 	case BPF_PROG_TYPE_LSM:
@@ -14980,12 +14989,12 @@ static int check_return_code(struct bpf_verifie=
r_env *env, int regno, const char
 			/* Make sure programs that attach to void
 			 * hooks don't try to modify return value.
 			 */
-			range =3D tnum_range(1, 1);
+			range =3D retval_range(1, 1);
 		}
 		break;
=20
 	case BPF_PROG_TYPE_NETFILTER:
-		range =3D tnum_range(NF_DROP, NF_ACCEPT);
+		range =3D retval_range(NF_DROP, NF_ACCEPT);
 		break;
 	case BPF_PROG_TYPE_EXT:
 		/* freplace program can return anything as its return value
@@ -15001,8 +15010,8 @@ static int check_return_code(struct bpf_verifier_=
env *env, int regno, const char
 		return -EINVAL;
 	}
=20
-	if (!tnum_in(range, reg->var_off)) {
-		verbose_invalid_scalar(env, reg, &range, "program exit", reg_name);
+	if (!retval_range_within(range, reg)) {
+		verbose_invalid_scalar(env, reg, range, "program exit", reg_name);
 		if (prog->expected_attach_type =3D=3D BPF_LSM_CGROUP &&
 		    prog_type =3D=3D BPF_PROG_TYPE_LSM &&
 		    !prog->aux->attach_func_proto->type)
diff --git a/tools/testing/selftests/bpf/progs/exceptions_assert.c b/tool=
s/testing/selftests/bpf/progs/exceptions_assert.c
index 575e7dd719c4..49793c300951 100644
--- a/tools/testing/selftests/bpf/progs/exceptions_assert.c
+++ b/tools/testing/selftests/bpf/progs/exceptions_assert.c
@@ -125,7 +125,7 @@ int check_assert_generic(struct __sk_buff *ctx)
 }
=20
 SEC("?fentry/bpf_check")
-__failure __msg("At program exit the register R1 has value (0x40; 0x0)")
+__failure __msg("At program exit the register R1 has umin=3D64 umax=3D64=
 var_off=3D(0x40; 0x0)")
 int check_assert_with_return(void *ctx)
 {
 	bpf_assert_with(!ctx, 64);
diff --git a/tools/testing/selftests/bpf/progs/exceptions_fail.c b/tools/=
testing/selftests/bpf/progs/exceptions_fail.c
index 69a8fb53ea1d..8041d1309b70 100644
--- a/tools/testing/selftests/bpf/progs/exceptions_fail.c
+++ b/tools/testing/selftests/bpf/progs/exceptions_fail.c
@@ -306,7 +306,7 @@ int reject_set_exception_cb_bad_ret1(void *ctx)
 }
=20
 SEC("?fentry/bpf_check")
-__failure __msg("At program exit the register R1 has value (0x40; 0x0) s=
hould")
+__failure __msg("At program exit the register R1 has umin=3D64 umax=3D64=
 var_off=3D(0x40; 0x0) should")
 int reject_set_exception_cb_bad_ret2(void *ctx)
 {
 	bpf_throw(64);
diff --git a/tools/testing/selftests/bpf/progs/test_global_func15.c b/too=
ls/testing/selftests/bpf/progs/test_global_func15.c
index b512d6a6c75e..f80207480e8a 100644
--- a/tools/testing/selftests/bpf/progs/test_global_func15.c
+++ b/tools/testing/selftests/bpf/progs/test_global_func15.c
@@ -13,7 +13,7 @@ __noinline int foo(unsigned int *v)
 }
=20
 SEC("cgroup_skb/ingress")
-__failure __msg("At program exit the register R0 has value")
+__failure __msg("At program exit the register R0 has ")
 int global_func15(struct __sk_buff *skb)
 {
 	unsigned int v =3D 1;
diff --git a/tools/testing/selftests/bpf/progs/timer_failure.c b/tools/te=
sting/selftests/bpf/progs/timer_failure.c
index 226d33b5a05c..9000da1e2120 100644
--- a/tools/testing/selftests/bpf/progs/timer_failure.c
+++ b/tools/testing/selftests/bpf/progs/timer_failure.c
@@ -30,7 +30,7 @@ static int timer_cb_ret1(void *map, int *key, struct bp=
f_timer *timer)
 }
=20
 SEC("fentry/bpf_fentry_test1")
-__failure __msg("should have been in (0x0; 0x0)")
+__failure __msg("should have been in [0, 0]")
 int BPF_PROG2(test_ret_1, int, a)
 {
 	int key =3D 0;
diff --git a/tools/testing/selftests/bpf/progs/user_ringbuf_fail.c b/tool=
s/testing/selftests/bpf/progs/user_ringbuf_fail.c
index 03ee946c6bf7..11ab25c42c36 100644
--- a/tools/testing/selftests/bpf/progs/user_ringbuf_fail.c
+++ b/tools/testing/selftests/bpf/progs/user_ringbuf_fail.c
@@ -184,7 +184,7 @@ invalid_drain_callback_return(struct bpf_dynptr *dynp=
tr, void *context)
  * not be able to write to that pointer.
  */
 SEC("?raw_tp")
-__failure __msg("At callback return the register R0 has value")
+__failure __msg("At callback return the register R0 has ")
 int user_ringbuf_callback_invalid_return(void *ctx)
 {
 	bpf_user_ringbuf_drain(&user_ringbuf, invalid_drain_callback_return, NU=
LL, 0);
diff --git a/tools/testing/selftests/bpf/progs/verifier_cgroup_inv_retcod=
e.c b/tools/testing/selftests/bpf/progs/verifier_cgroup_inv_retcode.c
index d6c4a7f3f790..b1e61b16aaf3 100644
--- a/tools/testing/selftests/bpf/progs/verifier_cgroup_inv_retcode.c
+++ b/tools/testing/selftests/bpf/progs/verifier_cgroup_inv_retcode.c
@@ -7,7 +7,7 @@
=20
 SEC("cgroup/sock")
 __description("bpf_exit with invalid return code. test1")
-__failure __msg("R0 has value (0x0; 0xffffffff)")
+__failure __msg("var_off=3D(0x0; 0xffffffff) should have been in [0, 1]"=
)
 __naked void with_invalid_return_code_test1(void)
 {
 	asm volatile ("					\
@@ -30,7 +30,7 @@ __naked void with_invalid_return_code_test2(void)
=20
 SEC("cgroup/sock")
 __description("bpf_exit with invalid return code. test3")
-__failure __msg("R0 has value (0x0; 0x3)")
+__failure __msg("var_off=3D(0x0; 0x3) should have been in [0, 1]")
 __naked void with_invalid_return_code_test3(void)
 {
 	asm volatile ("					\
@@ -53,7 +53,7 @@ __naked void with_invalid_return_code_test4(void)
=20
 SEC("cgroup/sock")
 __description("bpf_exit with invalid return code. test5")
-__failure __msg("R0 has value (0x2; 0x0)")
+__failure __msg("var_off=3D(0x2; 0x0) should have been in [0, 1]")
 __naked void with_invalid_return_code_test5(void)
 {
 	asm volatile ("					\
@@ -75,7 +75,7 @@ __naked void with_invalid_return_code_test6(void)
=20
 SEC("cgroup/sock")
 __description("bpf_exit with invalid return code. test7")
-__failure __msg("R0 has unknown scalar value")
+__failure __msg("R0 has unknown scalar value should have been in [0, 1]"=
)
 __naked void with_invalid_return_code_test7(void)
 {
 	asm volatile ("					\
diff --git a/tools/testing/selftests/bpf/progs/verifier_netfilter_retcode=
.c b/tools/testing/selftests/bpf/progs/verifier_netfilter_retcode.c
index 353ae6da00e1..48fd29a081e1 100644
--- a/tools/testing/selftests/bpf/progs/verifier_netfilter_retcode.c
+++ b/tools/testing/selftests/bpf/progs/verifier_netfilter_retcode.c
@@ -39,7 +39,7 @@ __naked void with_valid_return_code_test3(void)
=20
 SEC("netfilter")
 __description("bpf_exit with invalid return code. test4")
-__failure __msg("R0 has value (0x2; 0x0)")
+__failure __msg("R0 has umin=3D2 umax=3D2 var_off=3D(0x2; 0x0) should ha=
ve been in [0, 1]")
 __naked void with_invalid_return_code_test4(void)
 {
 	asm volatile ("					\
diff --git a/tools/testing/selftests/bpf/progs/verifier_subprog_precision=
.c b/tools/testing/selftests/bpf/progs/verifier_subprog_precision.c
index 65c49e56797a..2c4c6f7c1517 100644
--- a/tools/testing/selftests/bpf/progs/verifier_subprog_precision.c
+++ b/tools/testing/selftests/bpf/progs/verifier_subprog_precision.c
@@ -143,7 +143,7 @@ SEC("?raw_tp")
 __failure __log_level(2)
 __flag(BPF_F_TEST_STATE_FREQ)
 __msg("from 10 to 12: frame1: R0=3Dscalar(umin=3D1001) R10=3Dfp0 cb")
-__msg("At callback return the register R0 has unknown scalar value shoul=
d have been in (0x0; 0x1)")
+__msg("At callback return the register R0 has umin=3D1001 should have be=
en in [0, 1]")
 __naked int callback_precise_return_fail(void)
 {
 	asm volatile (
--=20
2.34.1


