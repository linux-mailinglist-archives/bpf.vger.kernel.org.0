Return-Path: <bpf+bounces-15610-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D9747F3B1A
	for <lists+bpf@lfdr.de>; Wed, 22 Nov 2023 02:17:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 235CBB21951
	for <lists+bpf@lfdr.de>; Wed, 22 Nov 2023 01:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CC0F17D5;
	Wed, 22 Nov 2023 01:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF709197
	for <bpf@vger.kernel.org>; Tue, 21 Nov 2023 17:17:10 -0800 (PST)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ALNMW0m030143
	for <bpf@vger.kernel.org>; Tue, 21 Nov 2023 17:17:10 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3uh65qrpnr-9
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Tue, 21 Nov 2023 17:17:10 -0800
Received: from twshared40933.03.prn6.facebook.com (2620:10d:c0a8:1c::1b) by
 mail.thefacebook.com (2620:10d:c0a8:82::b) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 21 Nov 2023 17:17:05 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 60EA53BE885DA; Tue, 21 Nov 2023 17:17:03 -0800 (PST)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH bpf-next 02/10] bpf: provide correct register name for exception callback retval check
Date: Tue, 21 Nov 2023 17:16:48 -0800
Message-ID: <20231122011656.1105943-3-andrii@kernel.org>
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
X-Proofpoint-ORIG-GUID: KC31f5z8kUjmRd5ggDkq0c1wzaV7wH_i
X-Proofpoint-GUID: KC31f5z8kUjmRd5ggDkq0c1wzaV7wH_i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-21_16,2023-11-21_01,2023-05-22_02

bpf_throw() is checking R1, so let's report R1 in the log.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/verifier.c                                | 12 ++++++------
 .../testing/selftests/bpf/progs/exceptions_assert.c  |  2 +-
 tools/testing/selftests/bpf/progs/exceptions_fail.c  |  2 +-
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 8c2d31aa3d31..a921dba4f603 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -11663,7 +11663,7 @@ static int fetch_kfunc_meta(struct bpf_verifier_e=
nv *env,
 	return 0;
 }
=20
-static int check_return_code(struct bpf_verifier_env *env, int regno);
+static int check_return_code(struct bpf_verifier_env *env, int regno, co=
nst char *reg_name);
=20
 static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_ins=
n *insn,
 			    int *insn_idx_p)
@@ -11799,7 +11799,7 @@ static int check_kfunc_call(struct bpf_verifier_e=
nv *env, struct bpf_insn *insn,
 		 * to bpf_throw becomes the return value of the program.
 		 */
 		if (!env->exception_callback_subprog) {
-			err =3D check_return_code(env, BPF_REG_1);
+			err =3D check_return_code(env, BPF_REG_1, "R1");
 			if (err < 0)
 				return err;
 		}
@@ -14818,7 +14818,7 @@ static int check_ld_abs(struct bpf_verifier_env *=
env, struct bpf_insn *insn)
 	return 0;
 }
=20
-static int check_return_code(struct bpf_verifier_env *env, int regno)
+static int check_return_code(struct bpf_verifier_env *env, int regno, co=
nst char *reg_name)
 {
 	struct tnum enforce_attach_type_range =3D tnum_unknown;
 	const struct bpf_prog *prog =3D env->prog;
@@ -14872,7 +14872,7 @@ static int check_return_code(struct bpf_verifier_=
env *env, int regno)
 		}
=20
 		if (!tnum_in(const_0, reg->var_off)) {
-			verbose_invalid_scalar(env, reg, &const_0, "async callback", "R0");
+			verbose_invalid_scalar(env, reg, &const_0, "async callback", reg_name=
);
 			return -EINVAL;
 		}
 		return 0;
@@ -14972,7 +14972,7 @@ static int check_return_code(struct bpf_verifier_=
env *env, int regno)
 	}
=20
 	if (!tnum_in(range, reg->var_off)) {
-		verbose_invalid_scalar(env, reg, &range, "program exit", "R0");
+		verbose_invalid_scalar(env, reg, &range, "program exit", reg_name);
 		if (prog->expected_attach_type =3D=3D BPF_LSM_CGROUP &&
 		    prog_type =3D=3D BPF_PROG_TYPE_LSM &&
 		    !prog->aux->attach_func_proto->type)
@@ -17220,7 +17220,7 @@ static int do_check(struct bpf_verifier_env *env)
 					continue;
 				}
=20
-				err =3D check_return_code(env, BPF_REG_0);
+				err =3D check_return_code(env, BPF_REG_0, "R0");
 				if (err)
 					return err;
 process_bpf_exit:
diff --git a/tools/testing/selftests/bpf/progs/exceptions_assert.c b/tool=
s/testing/selftests/bpf/progs/exceptions_assert.c
index 49efaed143fc..575e7dd719c4 100644
--- a/tools/testing/selftests/bpf/progs/exceptions_assert.c
+++ b/tools/testing/selftests/bpf/progs/exceptions_assert.c
@@ -125,7 +125,7 @@ int check_assert_generic(struct __sk_buff *ctx)
 }
=20
 SEC("?fentry/bpf_check")
-__failure __msg("At program exit the register R0 has value (0x40; 0x0)")
+__failure __msg("At program exit the register R1 has value (0x40; 0x0)")
 int check_assert_with_return(void *ctx)
 {
 	bpf_assert_with(!ctx, 64);
diff --git a/tools/testing/selftests/bpf/progs/exceptions_fail.c b/tools/=
testing/selftests/bpf/progs/exceptions_fail.c
index 4c39e920dac2..69a8fb53ea1d 100644
--- a/tools/testing/selftests/bpf/progs/exceptions_fail.c
+++ b/tools/testing/selftests/bpf/progs/exceptions_fail.c
@@ -306,7 +306,7 @@ int reject_set_exception_cb_bad_ret1(void *ctx)
 }
=20
 SEC("?fentry/bpf_check")
-__failure __msg("At program exit the register R0 has value (0x40; 0x0) s=
hould")
+__failure __msg("At program exit the register R1 has value (0x40; 0x0) s=
hould")
 int reject_set_exception_cb_bad_ret2(void *ctx)
 {
 	bpf_throw(64);
--=20
2.34.1


