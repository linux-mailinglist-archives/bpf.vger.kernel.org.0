Return-Path: <bpf+bounces-16512-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12045801E06
	for <lists+bpf@lfdr.de>; Sat,  2 Dec 2023 18:58:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB6471F21188
	for <lists+bpf@lfdr.de>; Sat,  2 Dec 2023 17:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED9C621111;
	Sat,  2 Dec 2023 17:57:41 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FEBC125
	for <bpf@vger.kernel.org>; Sat,  2 Dec 2023 09:57:39 -0800 (PST)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B2Ao5T9007428
	for <bpf@vger.kernel.org>; Sat, 2 Dec 2023 09:57:39 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3ur35whca6-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Sat, 02 Dec 2023 09:57:38 -0800
Received: from twshared15232.14.prn3.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a8:83::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Sat, 2 Dec 2023 09:57:35 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id D748C3C7A81BE; Sat,  2 Dec 2023 09:57:22 -0800 (PST)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>,
        Eduard Zingerman
	<eddyz87@gmail.com>,
        Shung-Hsi Yu <shung-hsi.yu@suse.com>
Subject: [PATCH v5 bpf-next 07/11] bpf: unify async callback and program retval checks
Date: Sat, 2 Dec 2023 09:57:01 -0800
Message-ID: <20231202175705.885270-8-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231202175705.885270-1-andrii@kernel.org>
References: <20231202175705.885270-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: dQmYodScOWQcP-Itl6zy6_d5Q_q2dEV2
X-Proofpoint-GUID: dQmYodScOWQcP-Itl6zy6_d5Q_q2dEV2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-02_16,2023-11-30_01,2023-05-22_02

Use common logic to verify program return values and async callback
return values. This allows to avoid duplication of any extra steps
necessary, like precision marking, which will be added in the next
patch.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Acked-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/verifier.c | 30 ++++++++++++------------------
 1 file changed, 12 insertions(+), 18 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 9411c1046268..c54944af1bcc 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -367,7 +367,7 @@ static void verbose_invalid_scalar(struct bpf_verifie=
r_env *env,
 {
 	bool unknown =3D true;
=20
-	verbose(env, "At %s the register %s has", ctx, reg_name);
+	verbose(env, "%s the register %s has", ctx, reg_name);
 	if (reg->smin_value > S64_MIN) {
 		verbose(env, " smin=3D%lld", reg->smin_value);
 		unknown =3D false;
@@ -9610,7 +9610,7 @@ static int prepare_func_exit(struct bpf_verifier_en=
v *env, int *insn_idx)
 		/* enforce R0 return value range */
 		if (!retval_range_within(callee->callback_ret_range, r0)) {
 			verbose_invalid_scalar(env, r0, callee->callback_ret_range,
-					       "callback return", "R0");
+					       "At callback return", "R0");
 			return -EINVAL;
 		}
 		if (!calls_callback(env, callee->callsite)) {
@@ -14993,11 +14993,11 @@ static int check_ld_abs(struct bpf_verifier_env=
 *env, struct bpf_insn *insn)
=20
 static int check_return_code(struct bpf_verifier_env *env, int regno, co=
nst char *reg_name)
 {
+	const char *exit_ctx =3D "At program exit";
 	struct tnum enforce_attach_type_range =3D tnum_unknown;
 	const struct bpf_prog *prog =3D env->prog;
 	struct bpf_reg_state *reg;
 	struct bpf_retval_range range =3D retval_range(0, 1);
-	struct bpf_retval_range const_0 =3D retval_range(0, 0);
 	enum bpf_prog_type prog_type =3D resolve_prog_type(env->prog);
 	int err;
 	struct bpf_func_state *frame =3D env->cur_state->frame[0];
@@ -15039,17 +15039,9 @@ static int check_return_code(struct bpf_verifier=
_env *env, int regno, const char
=20
 	if (frame->in_async_callback_fn) {
 		/* enforce return zero from async callbacks like timer */
-		if (reg->type !=3D SCALAR_VALUE) {
-			verbose(env, "In async callback the register R%d is not a known value=
 (%s)\n",
-				regno, reg_type_str(env, reg->type));
-			return -EINVAL;
-		}
-
-		if (!retval_range_within(const_0, reg)) {
-			verbose_invalid_scalar(env, reg, const_0, "async callback", reg_name)=
;
-			return -EINVAL;
-		}
-		return 0;
+		exit_ctx =3D "At async callback return";
+		range =3D retval_range(0, 0);
+		goto enforce_retval;
 	}
=20
 	if (is_subprog && !frame->in_exception_callback_fn) {
@@ -15139,15 +15131,17 @@ static int check_return_code(struct bpf_verifie=
r_env *env, int regno, const char
 		return 0;
 	}
=20
+enforce_retval:
 	if (reg->type !=3D SCALAR_VALUE) {
-		verbose(env, "At program exit the register R%d is not a known value (%=
s)\n",
-			regno, reg_type_str(env, reg->type));
+		verbose(env, "%s the register R%d is not a known value (%s)\n",
+			exit_ctx, regno, reg_type_str(env, reg->type));
 		return -EINVAL;
 	}
=20
 	if (!retval_range_within(range, reg)) {
-		verbose_invalid_scalar(env, reg, range, "program exit", reg_name);
-		if (prog->expected_attach_type =3D=3D BPF_LSM_CGROUP &&
+		verbose_invalid_scalar(env, reg, range, exit_ctx, reg_name);
+		if (!is_subprog &&
+		    prog->expected_attach_type =3D=3D BPF_LSM_CGROUP &&
 		    prog_type =3D=3D BPF_PROG_TYPE_LSM &&
 		    !prog->aux->attach_func_proto->type)
 			verbose(env, "Note, BPF_LSM_CGROUP that attach to void LSM hooks can'=
t modify return value!\n");
--=20
2.34.1


