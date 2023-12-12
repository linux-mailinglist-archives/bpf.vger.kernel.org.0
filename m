Return-Path: <bpf+bounces-17613-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2065F80FB50
	for <lists+bpf@lfdr.de>; Wed, 13 Dec 2023 00:26:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F3701F2186F
	for <lists+bpf@lfdr.de>; Tue, 12 Dec 2023 23:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C40AA64CEB;
	Tue, 12 Dec 2023 23:26:03 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7F18BC
	for <bpf@vger.kernel.org>; Tue, 12 Dec 2023 15:25:59 -0800 (PST)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BCLfWhm030379
	for <bpf@vger.kernel.org>; Tue, 12 Dec 2023 15:25:59 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3uxx6818jv-13
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Tue, 12 Dec 2023 15:25:59 -0800
Received: from twshared51573.38.frc1.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 12 Dec 2023 15:25:56 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id AE71F3D0C8A30; Tue, 12 Dec 2023 15:25:47 -0800 (PST)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>,
        Eduard Zingerman
	<eddyz87@gmail.com>
Subject: [PATCH v2 bpf-next 05/10] bpf: reuse subprog argument parsing logic for subprog call checks
Date: Tue, 12 Dec 2023 15:25:30 -0800
Message-ID: <20231212232535.1875938-6-andrii@kernel.org>
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
X-Proofpoint-GUID: lqEgSdbmUAppEYJ3Oh4pjqchqCZzg3WP
X-Proofpoint-ORIG-GUID: lqEgSdbmUAppEYJ3Oh4pjqchqCZzg3WP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-12_12,2023-12-12_01,2023-05-22_02

Remove duplicated BTF parsing logic when it comes to subprog call check.
Instead, use (potentially cached) results of btf_prepare_func_args() to
abstract away expectations of each subprog argument in generic terms
(e.g., "this is pointer to context", or "this is a pointer to memory of
size X"), and then use those simple high-level argument type
expectations to validate actual register states to check if they match
expectations.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/verifier.c                         | 110 +++++-------------
 .../selftests/bpf/progs/test_global_func5.c   |   2 +-
 2 files changed, 31 insertions(+), 81 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 1abb32415e9e..2dbbe9ef1617 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -9250,101 +9250,54 @@ static int setup_func_entry(struct bpf_verifier_=
env *env, int subprog, int calls
 	return err;
 }
=20
-static int btf_check_func_arg_match(struct bpf_verifier_env *env,
-				    const struct btf *btf, u32 func_id,
-				    struct bpf_reg_state *regs,
-				    bool ptr_to_mem_ok)
+static int btf_check_func_arg_match(struct bpf_verifier_env *env, int su=
bprog,
+				    const struct btf *btf,
+				    struct bpf_reg_state *regs)
 {
-	enum bpf_prog_type prog_type =3D resolve_prog_type(env->prog);
+	struct bpf_subprog_info *sub =3D subprog_info(env, subprog);
 	struct bpf_verifier_log *log =3D &env->log;
-	const char *func_name, *ref_tname;
-	const struct btf_type *t, *ref_t;
-	const struct btf_param *args;
-	u32 i, nargs, ref_id;
+	u32 i;
 	int ret;
=20
-	t =3D btf_type_by_id(btf, func_id);
-	if (!t || !btf_type_is_func(t)) {
-		/* These checks were already done by the verifier while loading
-		 * struct bpf_func_info or in add_kfunc_call().
-		 */
-		bpf_log(log, "BTF of func_id %u doesn't point to KIND_FUNC\n",
-			func_id);
-		return -EFAULT;
-	}
-	func_name =3D btf_name_by_offset(btf, t->name_off);
-
-	t =3D btf_type_by_id(btf, t->type);
-	if (!t || !btf_type_is_func_proto(t)) {
-		bpf_log(log, "Invalid BTF of func %s\n", func_name);
-		return -EFAULT;
-	}
-	args =3D (const struct btf_param *)(t + 1);
-	nargs =3D btf_type_vlen(t);
-	if (nargs > MAX_BPF_FUNC_REG_ARGS) {
-		bpf_log(log, "Function %s has %d > %d args\n", func_name, nargs,
-			MAX_BPF_FUNC_REG_ARGS);
-		return -EINVAL;
-	}
+	ret =3D btf_prepare_func_args(env, subprog);
+	if (ret)
+		return ret;
=20
 	/* check that BTF function arguments match actual types that the
 	 * verifier sees.
 	 */
-	for (i =3D 0; i < nargs; i++) {
-		enum bpf_arg_type arg_type =3D ARG_DONTCARE;
+	for (i =3D 0; i < sub->arg_cnt; i++) {
 		u32 regno =3D i + 1;
 		struct bpf_reg_state *reg =3D &regs[regno];
+		struct bpf_subprog_arg_info *arg =3D &sub->args[i];
=20
-		t =3D btf_type_skip_modifiers(btf, args[i].type, NULL);
-		if (btf_type_is_scalar(t)) {
-			if (reg->type =3D=3D SCALAR_VALUE)
-				continue;
-			bpf_log(log, "R%d is not a scalar\n", regno);
-			return -EINVAL;
-		}
-
-		if (!btf_type_is_ptr(t)) {
-			bpf_log(log, "Unrecognized arg#%d type %s\n",
-				i, btf_type_str(t));
-			return -EINVAL;
-		}
-
-		ref_t =3D btf_type_skip_modifiers(btf, t->type, &ref_id);
-		ref_tname =3D btf_name_by_offset(btf, ref_t->name_off);
-
-		ret =3D check_func_arg_reg_off(env, reg, regno, arg_type);
-		if (ret < 0)
-			return ret;
-
-		if (btf_get_prog_ctx_type(log, btf, t, prog_type, i)) {
+		if (arg->arg_type =3D=3D ARG_ANYTHING) {
+			if (reg->type !=3D SCALAR_VALUE) {
+				bpf_log(log, "R%d is not a scalar\n", regno);
+				return -EINVAL;
+			}
+		} else if (arg->arg_type =3D=3D ARG_PTR_TO_CTX) {
+			ret =3D check_func_arg_reg_off(env, reg, regno, ARG_DONTCARE);
+			if (ret < 0)
+				return ret;
 			/* If function expects ctx type in BTF check that caller
 			 * is passing PTR_TO_CTX.
 			 */
 			if (reg->type !=3D PTR_TO_CTX) {
-				bpf_log(log,
-					"arg#%d expected pointer to ctx, but got %s\n",
-					i, btf_type_str(t));
-				return -EINVAL;
-			}
-		} else if (ptr_to_mem_ok) {
-			const struct btf_type *resolve_ret;
-			u32 type_size;
-
-			resolve_ret =3D btf_resolve_size(btf, ref_t, &type_size);
-			if (IS_ERR(resolve_ret)) {
-				bpf_log(log,
-					"arg#%d reference type('%s %s') size cannot be determined: %ld\n",
-					i, btf_type_str(ref_t), ref_tname,
-					PTR_ERR(resolve_ret));
+				bpf_log(log, "arg#%d expects pointer to ctx\n", i);
 				return -EINVAL;
 			}
+		} else if (base_type(arg->arg_type) =3D=3D ARG_PTR_TO_MEM) {
+			ret =3D check_func_arg_reg_off(env, reg, regno, ARG_DONTCARE);
+			if (ret < 0)
+				return ret;
=20
-			if (check_mem_reg(env, reg, regno, type_size))
+			if (check_mem_reg(env, reg, regno, arg->mem_size))
 				return -EINVAL;
 		} else {
-			bpf_log(log, "reg type unsupported for arg#%d function %s#%d\n", i,
-				func_name, func_id);
-			return -EINVAL;
+			bpf_log(log, "verifier bug: unrecognized arg#%d type %d\n",
+				i, arg->arg_type);
+			return -EFAULT;
 		}
 	}
=20
@@ -9359,11 +9312,10 @@ static int btf_check_func_arg_match(struct bpf_ve=
rifier_env *env,
  * Only PTR_TO_CTX and SCALAR_VALUE states are recognized.
  */
 static int btf_check_subprog_call(struct bpf_verifier_env *env, int subp=
rog,
-			          struct bpf_reg_state *regs)
+				  struct bpf_reg_state *regs)
 {
 	struct bpf_prog *prog =3D env->prog;
 	struct btf *btf =3D prog->aux->btf;
-	bool is_global;
 	u32 btf_id;
 	int err;
=20
@@ -9377,9 +9329,7 @@ static int btf_check_subprog_call(struct bpf_verifi=
er_env *env, int subprog,
 	if (prog->aux->func_info_aux[subprog].unreliable)
 		return -EINVAL;
=20
-	is_global =3D prog->aux->func_info_aux[subprog].linkage =3D=3D BTF_FUNC=
_GLOBAL;
-	err =3D btf_check_func_arg_match(env, btf, btf_id, regs, is_global);
-
+	err =3D btf_check_func_arg_match(env, subprog, btf, regs);
 	/* Compiler optimizations can remove arguments from static functions
 	 * or mismatched type can be passed into a global function.
 	 * In such cases mark the function as unreliable from BTF point of view=
.
diff --git a/tools/testing/selftests/bpf/progs/test_global_func5.c b/tool=
s/testing/selftests/bpf/progs/test_global_func5.c
index cc55aedaf82d..257c0569ff98 100644
--- a/tools/testing/selftests/bpf/progs/test_global_func5.c
+++ b/tools/testing/selftests/bpf/progs/test_global_func5.c
@@ -26,7 +26,7 @@ int f3(int val, struct __sk_buff *skb)
 }
=20
 SEC("tc")
-__failure __msg("expected pointer to ctx, but got PTR")
+__failure __msg("expects pointer to ctx")
 int global_func5(struct __sk_buff *skb)
 {
 	return f1(skb) + f2(2, skb) + f3(3, skb);
--=20
2.34.1


