Return-Path: <bpf+bounces-17923-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84D6D813F13
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 02:16:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26EBD2838DA
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 01:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96694624;
	Fri, 15 Dec 2023 01:16:42 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9608F363
	for <bpf@vger.kernel.org>; Fri, 15 Dec 2023 01:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BEJRHVc020617
	for <bpf@vger.kernel.org>; Thu, 14 Dec 2023 17:16:39 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3uynmqspgn-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Thu, 14 Dec 2023 17:16:38 -0800
Received: from twshared51573.38.frc1.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:11d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 14 Dec 2023 17:16:35 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 8A2323D2CCEE8; Thu, 14 Dec 2023 17:13:43 -0800 (PST)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>,
        Eduard Zingerman
	<eddyz87@gmail.com>
Subject: [PATCH v3 bpf-next 04/10] bpf: move subprog call logic back to verifier.c
Date: Thu, 14 Dec 2023 17:13:28 -0800
Message-ID: <20231215011334.2307144-5-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231215011334.2307144-1-andrii@kernel.org>
References: <20231215011334.2307144-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: JvL9MfozMfbpW7ChgMGFA0ff4fylEvKh
X-Proofpoint-GUID: JvL9MfozMfbpW7ChgMGFA0ff4fylEvKh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-14_17,2023-12-14_01,2023-05-22_02

Subprog call logic in btf_check_subprog_call() currently has both a lot
of BTF parsing logic (which is, presumably, what justified putting it
into btf.c), but also a bunch of register state checks, some of each
utilize deep verifier logic helpers, necessarily exported from
verifier.c: check_ptr_off_reg(), check_func_arg_reg_off(),
and check_mem_reg().

Going forward, btf_check_subprog_call() will have a minimum of
BTF-related logic, but will get more internal verifier logic related to
register state manipulation. So move it into verifier.c to minimize
amount of verifier-specific logic exposed to btf.c.

We do this move before refactoring btf_check_func_arg_match() to
preserve as much history post-refactoring as possible.

No functional changes.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 include/linux/bpf.h          |   2 -
 include/linux/bpf_verifier.h |   8 --
 kernel/bpf/btf.c             | 139 -------------------------------
 kernel/bpf/verifier.c        | 153 +++++++++++++++++++++++++++++++++--
 4 files changed, 146 insertions(+), 156 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index cf80cfe9f0be..1dce146a5615 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2491,8 +2491,6 @@ int btf_distill_func_proto(struct bpf_verifier_log =
*log,
 			   struct btf_func_model *m);
=20
 struct bpf_reg_state;
-int btf_check_subprog_call(struct bpf_verifier_env *env, int subprog,
-			   struct bpf_reg_state *regs);
 int btf_prepare_func_args(struct bpf_verifier_env *env, int subprog);
 int btf_check_type_match(struct bpf_verifier_log *log, const struct bpf_=
prog *prog,
 			 struct btf *btf, const struct btf_type *t);
diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index d3ea9ef04767..d07d857ca67f 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -785,14 +785,6 @@ bpf_prog_offload_replace_insn(struct bpf_verifier_en=
v *env, u32 off,
 void
 bpf_prog_offload_remove_insns(struct bpf_verifier_env *env, u32 off, u32=
 cnt);
=20
-int check_ptr_off_reg(struct bpf_verifier_env *env,
-		      const struct bpf_reg_state *reg, int regno);
-int check_func_arg_reg_off(struct bpf_verifier_env *env,
-			   const struct bpf_reg_state *reg, int regno,
-			   enum bpf_arg_type arg_type);
-int check_mem_reg(struct bpf_verifier_env *env, struct bpf_reg_state *re=
g,
-		   u32 regno, u32 mem_size);
-
 /* this lives here instead of in bpf.h because it needs to dereference t=
gt_prog */
 static inline u64 bpf_trampoline_compute_key(const struct bpf_prog *tgt_=
prog,
 					     struct btf *btf, u32 btf_id)
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index d321340e16f1..341811bcca53 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6765,145 +6765,6 @@ int btf_check_type_match(struct bpf_verifier_log =
*log, const struct bpf_prog *pr
 	return btf_check_func_type_match(log, btf1, t1, btf2, t2);
 }
=20
-static int btf_check_func_arg_match(struct bpf_verifier_env *env,
-				    const struct btf *btf, u32 func_id,
-				    struct bpf_reg_state *regs,
-				    bool ptr_to_mem_ok)
-{
-	enum bpf_prog_type prog_type =3D resolve_prog_type(env->prog);
-	struct bpf_verifier_log *log =3D &env->log;
-	const char *func_name, *ref_tname;
-	const struct btf_type *t, *ref_t;
-	const struct btf_param *args;
-	u32 i, nargs, ref_id;
-	int ret;
-
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
-
-	/* check that BTF function arguments match actual types that the
-	 * verifier sees.
-	 */
-	for (i =3D 0; i < nargs; i++) {
-		enum bpf_arg_type arg_type =3D ARG_DONTCARE;
-		u32 regno =3D i + 1;
-		struct bpf_reg_state *reg =3D &regs[regno];
-
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
-			/* If function expects ctx type in BTF check that caller
-			 * is passing PTR_TO_CTX.
-			 */
-			if (reg->type !=3D PTR_TO_CTX) {
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
-				return -EINVAL;
-			}
-
-			if (check_mem_reg(env, reg, regno, type_size))
-				return -EINVAL;
-		} else {
-			bpf_log(log, "reg type unsupported for arg#%d function %s#%d\n", i,
-				func_name, func_id);
-			return -EINVAL;
-		}
-	}
-
-	return 0;
-}
-
-/* Compare BTF of a function call with given bpf_reg_state.
- * Returns:
- * EFAULT - there is a verifier bug. Abort verification.
- * EINVAL - there is a type mismatch or BTF is not available.
- * 0 - BTF matches with what bpf_reg_state expects.
- * Only PTR_TO_CTX and SCALAR_VALUE states are recognized.
- */
-int btf_check_subprog_call(struct bpf_verifier_env *env, int subprog,
-			   struct bpf_reg_state *regs)
-{
-	struct bpf_prog *prog =3D env->prog;
-	struct btf *btf =3D prog->aux->btf;
-	bool is_global;
-	u32 btf_id;
-	int err;
-
-	if (!prog->aux->func_info)
-		return -EINVAL;
-
-	btf_id =3D prog->aux->func_info[subprog].type_id;
-	if (!btf_id)
-		return -EFAULT;
-
-	if (prog->aux->func_info_aux[subprog].unreliable)
-		return -EINVAL;
-
-	is_global =3D prog->aux->func_info_aux[subprog].linkage =3D=3D BTF_FUNC=
_GLOBAL;
-	err =3D btf_check_func_arg_match(env, btf, btf_id, regs, is_global);
-
-	/* Compiler optimizations can remove arguments from static functions
-	 * or mismatched type can be passed into a global function.
-	 * In such cases mark the function as unreliable from BTF point of view=
.
-	 */
-	if (err)
-		prog->aux->func_info_aux[subprog].unreliable =3D true;
-	return err;
-}
-
 /* Process BTF of a function to produce high-level expectation of functi=
on
  * arguments (like ARG_PTR_TO_CTX, or ARG_PTR_TO_MEM, etc). This informa=
tion
  * is cached in subprog info for reuse.
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 667cbf39087f..b5237ddb00bf 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5134,8 +5134,8 @@ static int __check_ptr_off_reg(struct bpf_verifier_=
env *env,
 	return 0;
 }
=20
-int check_ptr_off_reg(struct bpf_verifier_env *env,
-		      const struct bpf_reg_state *reg, int regno)
+static int check_ptr_off_reg(struct bpf_verifier_env *env,
+		             const struct bpf_reg_state *reg, int regno)
 {
 	return __check_ptr_off_reg(env, reg, regno, false);
 }
@@ -7307,8 +7307,8 @@ static int check_mem_size_reg(struct bpf_verifier_e=
nv *env,
 	return err;
 }
=20
-int check_mem_reg(struct bpf_verifier_env *env, struct bpf_reg_state *re=
g,
-		   u32 regno, u32 mem_size)
+static int check_mem_reg(struct bpf_verifier_env *env, struct bpf_reg_st=
ate *reg,
+			 u32 regno, u32 mem_size)
 {
 	bool may_be_null =3D type_may_be_null(reg->type);
 	struct bpf_reg_state saved_reg;
@@ -8293,9 +8293,9 @@ reg_find_field_offset(const struct bpf_reg_state *r=
eg, s32 off, u32 fields)
 	return field;
 }
=20
-int check_func_arg_reg_off(struct bpf_verifier_env *env,
-			   const struct bpf_reg_state *reg, int regno,
-			   enum bpf_arg_type arg_type)
+static int check_func_arg_reg_off(struct bpf_verifier_env *env,
+				  const struct bpf_reg_state *reg, int regno,
+				  enum bpf_arg_type arg_type)
 {
 	u32 type =3D reg->type;
=20
@@ -9256,6 +9256,145 @@ static int setup_func_entry(struct bpf_verifier_e=
nv *env, int subprog, int calls
 	return err;
 }
=20
+static int btf_check_func_arg_match(struct bpf_verifier_env *env,
+				    const struct btf *btf, u32 func_id,
+				    struct bpf_reg_state *regs,
+				    bool ptr_to_mem_ok)
+{
+	enum bpf_prog_type prog_type =3D resolve_prog_type(env->prog);
+	struct bpf_verifier_log *log =3D &env->log;
+	const char *func_name, *ref_tname;
+	const struct btf_type *t, *ref_t;
+	const struct btf_param *args;
+	u32 i, nargs, ref_id;
+	int ret;
+
+	t =3D btf_type_by_id(btf, func_id);
+	if (!t || !btf_type_is_func(t)) {
+		/* These checks were already done by the verifier while loading
+		 * struct bpf_func_info or in add_kfunc_call().
+		 */
+		bpf_log(log, "BTF of func_id %u doesn't point to KIND_FUNC\n",
+			func_id);
+		return -EFAULT;
+	}
+	func_name =3D btf_name_by_offset(btf, t->name_off);
+
+	t =3D btf_type_by_id(btf, t->type);
+	if (!t || !btf_type_is_func_proto(t)) {
+		bpf_log(log, "Invalid BTF of func %s\n", func_name);
+		return -EFAULT;
+	}
+	args =3D (const struct btf_param *)(t + 1);
+	nargs =3D btf_type_vlen(t);
+	if (nargs > MAX_BPF_FUNC_REG_ARGS) {
+		bpf_log(log, "Function %s has %d > %d args\n", func_name, nargs,
+			MAX_BPF_FUNC_REG_ARGS);
+		return -EINVAL;
+	}
+
+	/* check that BTF function arguments match actual types that the
+	 * verifier sees.
+	 */
+	for (i =3D 0; i < nargs; i++) {
+		enum bpf_arg_type arg_type =3D ARG_DONTCARE;
+		u32 regno =3D i + 1;
+		struct bpf_reg_state *reg =3D &regs[regno];
+
+		t =3D btf_type_skip_modifiers(btf, args[i].type, NULL);
+		if (btf_type_is_scalar(t)) {
+			if (reg->type =3D=3D SCALAR_VALUE)
+				continue;
+			bpf_log(log, "R%d is not a scalar\n", regno);
+			return -EINVAL;
+		}
+
+		if (!btf_type_is_ptr(t)) {
+			bpf_log(log, "Unrecognized arg#%d type %s\n",
+				i, btf_type_str(t));
+			return -EINVAL;
+		}
+
+		ref_t =3D btf_type_skip_modifiers(btf, t->type, &ref_id);
+		ref_tname =3D btf_name_by_offset(btf, ref_t->name_off);
+
+		ret =3D check_func_arg_reg_off(env, reg, regno, arg_type);
+		if (ret < 0)
+			return ret;
+
+		if (btf_get_prog_ctx_type(log, btf, t, prog_type, i)) {
+			/* If function expects ctx type in BTF check that caller
+			 * is passing PTR_TO_CTX.
+			 */
+			if (reg->type !=3D PTR_TO_CTX) {
+				bpf_log(log,
+					"arg#%d expected pointer to ctx, but got %s\n",
+					i, btf_type_str(t));
+				return -EINVAL;
+			}
+		} else if (ptr_to_mem_ok) {
+			const struct btf_type *resolve_ret;
+			u32 type_size;
+
+			resolve_ret =3D btf_resolve_size(btf, ref_t, &type_size);
+			if (IS_ERR(resolve_ret)) {
+				bpf_log(log,
+					"arg#%d reference type('%s %s') size cannot be determined: %ld\n",
+					i, btf_type_str(ref_t), ref_tname,
+					PTR_ERR(resolve_ret));
+				return -EINVAL;
+			}
+
+			if (check_mem_reg(env, reg, regno, type_size))
+				return -EINVAL;
+		} else {
+			bpf_log(log, "reg type unsupported for arg#%d function %s#%d\n", i,
+				func_name, func_id);
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
+/* Compare BTF of a function call with given bpf_reg_state.
+ * Returns:
+ * EFAULT - there is a verifier bug. Abort verification.
+ * EINVAL - there is a type mismatch or BTF is not available.
+ * 0 - BTF matches with what bpf_reg_state expects.
+ * Only PTR_TO_CTX and SCALAR_VALUE states are recognized.
+ */
+static int btf_check_subprog_call(struct bpf_verifier_env *env, int subp=
rog,
+			          struct bpf_reg_state *regs)
+{
+	struct bpf_prog *prog =3D env->prog;
+	struct btf *btf =3D prog->aux->btf;
+	bool is_global;
+	u32 btf_id;
+	int err;
+
+	if (!prog->aux->func_info)
+		return -EINVAL;
+
+	btf_id =3D prog->aux->func_info[subprog].type_id;
+	if (!btf_id)
+		return -EFAULT;
+
+	if (prog->aux->func_info_aux[subprog].unreliable)
+		return -EINVAL;
+
+	is_global =3D prog->aux->func_info_aux[subprog].linkage =3D=3D BTF_FUNC=
_GLOBAL;
+	err =3D btf_check_func_arg_match(env, btf, btf_id, regs, is_global);
+
+	/* Compiler optimizations can remove arguments from static functions
+	 * or mismatched type can be passed into a global function.
+	 * In such cases mark the function as unreliable from BTF point of view=
.
+	 */
+	if (err)
+		prog->aux->func_info_aux[subprog].unreliable =3D true;
+	return err;
+}
+
 static int push_callback_call(struct bpf_verifier_env *env, struct bpf_i=
nsn *insn,
 			      int insn_idx, int subprog,
 			      set_callee_state_fn set_callee_state_cb)
--=20
2.34.1


