Return-Path: <bpf+bounces-17617-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BC2080FB54
	for <lists+bpf@lfdr.de>; Wed, 13 Dec 2023 00:26:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBF5828212C
	for <lists+bpf@lfdr.de>; Tue, 12 Dec 2023 23:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8882F77F2E;
	Tue, 12 Dec 2023 23:26:06 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61620D0
	for <bpf@vger.kernel.org>; Tue, 12 Dec 2023 15:26:01 -0800 (PST)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BCLfWhr030379
	for <bpf@vger.kernel.org>; Tue, 12 Dec 2023 15:26:01 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3uxx6818jv-18
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Tue, 12 Dec 2023 15:26:01 -0800
Received: from twshared34392.14.frc2.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:11d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 12 Dec 2023 15:25:57 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 7B2F43D0C8A01; Tue, 12 Dec 2023 15:25:43 -0800 (PST)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>,
        Eduard Zingerman
	<eddyz87@gmail.com>
Subject: [PATCH v2 bpf-next 03/10] bpf: prepare btf_prepare_func_args() for handling static subprogs
Date: Tue, 12 Dec 2023 15:25:28 -0800
Message-ID: <20231212232535.1875938-4-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231212232535.1875938-1-andrii@kernel.org>
References: <20231212232535.1875938-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: elojN-Vi_jRBV_K_4BBrJH4TpnfmL6DX
X-Proofpoint-ORIG-GUID: elojN-Vi_jRBV_K_4BBrJH4TpnfmL6DX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-12_12,2023-12-12_01,2023-05-22_02

Generalize btf_prepare_func_args() to support both global and static
subprogs. We are going to utilize this property in the next patch,
reusing btf_prepare_func_args() for subprog call logic instead of
reparsing BTF information in a completely separate implementation.

btf_prepare_func_args() now detects whether subprog is global or static
makes slight logic adjustments for static func cases, like not failing
fatally (-EFAULT) for conditions that are allowable for static subprogs.

Somewhat subtle (but major!) difference is the handling of pointer argume=
nts.
Both global and static functions need to handle special context
arguments (which are pointers to predefined type names), but static
subprogs give up on any other pointers, falling back to marking subprog
as "unreliable", disabling the use of BTF type information altogether.

For global functions, though, we are assuming that such pointers to
unrecognized types are just pointers to fixed-sized memory region (or
error out if size cannot be established, like for `void *` pointers).

This patch accommodates these small differences and sets up a stage for
refactoring in the next patch, eliminating a separate BTF-based parsing
logic in btf_check_func_arg_match().

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 include/linux/bpf_verifier.h |  5 +++++
 kernel/bpf/btf.c             | 18 +++++++++---------
 kernel/bpf/verifier.c        |  5 -----
 3 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 5742e9c0a7b8..d3ea9ef04767 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -738,6 +738,11 @@ struct bpf_verifier_env {
 	char tmp_str_buf[TMP_STR_BUF_LEN];
 };
=20
+static inline struct bpf_func_info_aux *subprog_aux(struct bpf_verifier_=
env *env, int subprog)
+{
+	return &env->prog->aux->func_info_aux[subprog];
+}
+
 static inline struct bpf_subprog_info *subprog_info(struct bpf_verifier_=
env *env, int subprog)
 {
 	return &env->subprog_info[subprog];
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 33d9a1c73f6e..d321340e16f1 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6914,6 +6914,7 @@ int btf_check_subprog_call(struct bpf_verifier_env =
*env, int subprog,
  */
 int btf_prepare_func_args(struct bpf_verifier_env *env, int subprog)
 {
+	bool is_global =3D subprog_aux(env, subprog)->linkage =3D=3D BTF_FUNC_G=
LOBAL;
 	struct bpf_subprog_info *sub =3D subprog_info(env, subprog);
 	struct bpf_verifier_log *log =3D &env->log;
 	struct bpf_prog *prog =3D env->prog;
@@ -6927,14 +6928,15 @@ int btf_prepare_func_args(struct bpf_verifier_env=
 *env, int subprog)
 	if (sub->args_cached)
 		return 0;
=20
-	if (!prog->aux->func_info ||
-	    prog->aux->func_info_aux[subprog].linkage !=3D BTF_FUNC_GLOBAL) {
+	if (!prog->aux->func_info) {
 		bpf_log(log, "Verifier bug\n");
 		return -EFAULT;
 	}
=20
 	btf_id =3D prog->aux->func_info[subprog].type_id;
 	if (!btf_id) {
+		if (!is_global) /* not fatal for static funcs */
+			return -EINVAL;
 		bpf_log(log, "Global functions need valid BTF\n");
 		return -EFAULT;
 	}
@@ -6990,16 +6992,14 @@ int btf_prepare_func_args(struct bpf_verifier_env=
 *env, int subprog)
 			sub->args[i].arg_type =3D ARG_ANYTHING;
 			continue;
 		}
-		if (btf_type_is_ptr(t)) {
+		if (btf_type_is_ptr(t) && btf_get_prog_ctx_type(log, btf, t, prog_type=
, i)) {
+			sub->args[i].arg_type =3D ARG_PTR_TO_CTX;
+			continue;
+		}
+		if (is_global && btf_type_is_ptr(t)) {
 			u32 mem_size;
=20
-			if (btf_get_prog_ctx_type(log, btf, t, prog_type, i)) {
-				sub->args[i].arg_type =3D ARG_PTR_TO_CTX;
-				continue;
-			}
-
 			t =3D btf_type_skip_modifiers(btf, t->type, NULL);
-
 			ref_t =3D btf_resolve_size(btf, t, &mem_size);
 			if (IS_ERR(ref_t)) {
 				bpf_log(log,
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index a038d24c6855..2d39f6bc5070 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -437,11 +437,6 @@ static const char *subprog_name(const struct bpf_ver=
ifier_env *env, int subprog)
 	return btf_type_name(env->prog->aux->btf, info->type_id);
 }
=20
-static struct bpf_func_info_aux *subprog_aux(const struct bpf_verifier_e=
nv *env, int subprog)
-{
-	return &env->prog->aux->func_info_aux[subprog];
-}
-
 static void mark_subprog_exc_cb(struct bpf_verifier_env *env, int subpro=
g)
 {
 	struct bpf_subprog_info *info =3D subprog_info(env, subprog);
--=20
2.34.1


