Return-Path: <bpf+bounces-16663-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96B118042AB
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 00:40:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7EB51C20C40
	for <lists+bpf@lfdr.de>; Mon,  4 Dec 2023 23:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4992435F06;
	Mon,  4 Dec 2023 23:40:09 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF238C3
	for <bpf@vger.kernel.org>; Mon,  4 Dec 2023 15:40:04 -0800 (PST)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 3B4MQC8N020118
	for <bpf@vger.kernel.org>; Mon, 4 Dec 2023 15:40:04 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
	by m0089730.ppops.net (PPS) with ESMTPS id 3us9fbxxbs-9
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Mon, 04 Dec 2023 15:40:03 -0800
Received: from twshared17205.35.frc1.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a8:82::b) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 4 Dec 2023 15:39:51 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 094713C972603; Mon,  4 Dec 2023 15:39:44 -0800 (PST)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH bpf-next 05/13] bpf: abstract away global subprog arg preparation logic from reg state setup
Date: Mon, 4 Dec 2023 15:39:23 -0800
Message-ID: <20231204233931.49758-6-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231204233931.49758-1-andrii@kernel.org>
References: <20231204233931.49758-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: XhtvBHvgwUxo27hmy5SBry3vp82WY5tP
X-Proofpoint-GUID: XhtvBHvgwUxo27hmy5SBry3vp82WY5tP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-04_22,2023-12-04_01,2023-05-22_02

btf_prepare_func_args() is used to understand expectations and
restrictions on global subprog arguments. But current implementation is
hard to extend, as it intermixes BTF-based func prototype parsing and
interpretation logic with setting up register state at subprog entry.

Worse still, those registers are not completely set up inside
btf_prepare_func_args(), requiring some more logic later in
do_check_common(). Like calling mark_reg_unknown() and similar
initialization operations.

This intermixing of BTF interpretation and register state setup is
problematic. First, it causes duplication of BTF parsing logic for global
subprog verification (to set up initial state of global subprog) and
global subprog call sites analysis (when we need to check that whatever
is being passed into global subprog matches expectations), performed in
btf_check_subprog_call().

Given we want to extend global func argument with tags later, this
duplication is problematic. So refactor btf_prepare_func_args() to do
only BTF-based func proto and args parsing, returning high-level
argument "expectations" only, with no regard to specifics of register
state. I.e., if it's a context argument, instead of setting register
state to PTR_TO_CTX, we return ARG_PTR_TO_CTX enum for that argument as
"an argument specification" for further processing inside
do_check_common(). Similarly for SCALAR arguments, PTR_TO_MEM, etc.

This allows to reuse btf_prepare_func_args() in following patches at
global subprog call site analysis time. It also keeps register setup
code consistently in one place, do_check_common().

Besides all this, we cache this argument specs information inside
env->subprog_info, eliminating the need to redo these potentially
expensive BTF traversals, especially if BPF program's BTF is big and/or
there are lots of global subprog calls.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 include/linux/bpf.h          |  4 ++--
 include/linux/bpf_verifier.h | 16 ++++++++++++++++
 kernel/bpf/btf.c             | 31 ++++++++++++++++---------------
 kernel/bpf/verifier.c        | 36 +++++++++++++++++++++---------------
 4 files changed, 55 insertions(+), 32 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 379ac0a28405..c3a5d0fe3cdf 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -704,6 +704,7 @@ enum bpf_arg_type {
=20
 	ARG_PTR_TO_CTX,		/* pointer to context */
 	ARG_ANYTHING,		/* any (initialized) argument is ok */
+	ARG_SCALAR =3D ARG_ANYTHING, /* scalar value */
 	ARG_PTR_TO_SPIN_LOCK,	/* pointer to bpf_spin_lock */
 	ARG_PTR_TO_SOCK_COMMON,	/* pointer to sock_common */
 	ARG_PTR_TO_INT,		/* pointer to int */
@@ -2430,8 +2431,7 @@ int btf_check_subprog_arg_match(struct bpf_verifier=
_env *env, int subprog,
 				struct bpf_reg_state *regs);
 int btf_check_subprog_call(struct bpf_verifier_env *env, int subprog,
 			   struct bpf_reg_state *regs);
-int btf_prepare_func_args(struct bpf_verifier_env *env, int subprog,
-			  struct bpf_reg_state *reg, u32 *nargs);
+int btf_prepare_func_args(struct bpf_verifier_env *env, int subprog);
 int btf_check_type_match(struct bpf_verifier_log *log, const struct bpf_=
prog *prog,
 			 struct btf *btf, const struct btf_type *t);
 const char *btf_find_decl_tag_value(const struct btf *btf, const struct =
btf_type *pt,
diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 78d3f93b3802..23d054c9d1c8 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -574,6 +574,13 @@ static inline bool bpf_verifier_log_needed(const str=
uct bpf_verifier_log *log)
=20
 #define BPF_MAX_SUBPROGS 256
=20
+struct bpf_subprog_arg_info {
+	enum bpf_arg_type arg_type;
+	union {
+		u32 mem_size;
+	};
+};
+
 struct bpf_subprog_info {
 	/* 'start' has to be the first field otherwise find_subprog() won't wor=
k */
 	u32 start; /* insn idx of function entry point */
@@ -585,6 +592,10 @@ struct bpf_subprog_info {
 	bool is_cb: 1;
 	bool is_async_cb: 1;
 	bool is_exception_cb: 1;
+	bool args_cached: 1;
+
+	u8 arg_cnt;
+	struct bpf_subprog_arg_info args[MAX_BPF_FUNC_REG_ARGS];
 };
=20
 struct bpf_verifier_env;
@@ -690,6 +701,11 @@ struct bpf_verifier_env {
 	char tmp_str_buf[TMP_STR_BUF_LEN];
 };
=20
+static inline struct bpf_subprog_info *subprog_info(struct bpf_verifier_=
env *env, int subprog)
+{
+	return &env->subprog_info[subprog];
+}
+
 __printf(2, 0) void bpf_verifier_vlog(struct bpf_verifier_log *log,
 				      const char *fmt, va_list args);
 __printf(2, 3) void bpf_verifier_log_write(struct bpf_verifier_env *env,
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index d56433bf8aba..33a62df9c5a8 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6955,9 +6955,9 @@ int btf_check_subprog_call(struct bpf_verifier_env =
*env, int subprog,
  * 0 - Successfully converted BTF into bpf_reg_state
  * (either PTR_TO_CTX or SCALAR_VALUE).
  */
-int btf_prepare_func_args(struct bpf_verifier_env *env, int subprog,
-			  struct bpf_reg_state *regs, u32 *arg_cnt)
+int btf_prepare_func_args(struct bpf_verifier_env *env, int subprog)
 {
+	struct bpf_subprog_info *sub =3D subprog_info(env, subprog);
 	struct bpf_verifier_log *log =3D &env->log;
 	struct bpf_prog *prog =3D env->prog;
 	enum bpf_prog_type prog_type =3D prog->type;
@@ -6967,6 +6967,9 @@ int btf_prepare_func_args(struct bpf_verifier_env *=
env, int subprog,
 	u32 i, nargs, btf_id;
 	const char *tname;
=20
+	if (sub->args_cached)
+		return 0;
+
 	if (!prog->aux->func_info ||
 	    prog->aux->func_info_aux[subprog].linkage !=3D BTF_FUNC_GLOBAL) {
 		bpf_log(log, "Verifier bug\n");
@@ -6990,10 +6993,6 @@ int btf_prepare_func_args(struct bpf_verifier_env =
*env, int subprog,
 	}
 	tname =3D btf_name_by_offset(btf, t->name_off);
=20
-	if (log->level & BPF_LOG_LEVEL)
-		bpf_log(log, "Validating %s() func#%d...\n",
-			tname, subprog);
-
 	if (prog->aux->func_info_aux[subprog].unreliable) {
 		bpf_log(log, "Verifier bug in function %s()\n", tname);
 		return -EFAULT;
@@ -7013,7 +7012,6 @@ int btf_prepare_func_args(struct bpf_verifier_env *=
env, int subprog,
 			tname, nargs, MAX_BPF_FUNC_REG_ARGS);
 		return -EINVAL;
 	}
-	*arg_cnt =3D nargs;
 	/* check that function returns int, exception cb also requires this */
 	t =3D btf_type_by_id(btf, t->type);
 	while (btf_type_is_modifier(t))
@@ -7028,24 +7026,24 @@ int btf_prepare_func_args(struct bpf_verifier_env=
 *env, int subprog,
 	 * Only PTR_TO_CTX and SCALAR are supported atm.
 	 */
 	for (i =3D 0; i < nargs; i++) {
-		struct bpf_reg_state *reg =3D &regs[i + 1];
-
 		t =3D btf_type_by_id(btf, args[i].type);
 		while (btf_type_is_modifier(t))
 			t =3D btf_type_by_id(btf, t->type);
 		if (btf_type_is_int(t) || btf_is_any_enum(t)) {
-			reg->type =3D SCALAR_VALUE;
+			sub->args[i].arg_type =3D ARG_SCALAR;
 			continue;
 		}
 		if (btf_type_is_ptr(t)) {
+			u32 mem_size;
+
 			if (btf_get_prog_ctx_type(log, btf, t, prog_type, i)) {
-				reg->type =3D PTR_TO_CTX;
+				sub->args[i].arg_type =3D ARG_PTR_TO_CTX;
 				continue;
 			}
=20
 			t =3D btf_type_skip_modifiers(btf, t->type, NULL);
=20
-			ref_t =3D btf_resolve_size(btf, t, &reg->mem_size);
+			ref_t =3D btf_resolve_size(btf, t, &mem_size);
 			if (IS_ERR(ref_t)) {
 				bpf_log(log,
 				    "arg#%d reference type('%s %s') size cannot be determined: %ld\n=
",
@@ -7054,15 +7052,18 @@ int btf_prepare_func_args(struct bpf_verifier_env=
 *env, int subprog,
 				return -EINVAL;
 			}
=20
-			reg->type =3D PTR_TO_MEM | PTR_MAYBE_NULL;
-			reg->id =3D ++env->id_gen;
-
+			sub->args[i].arg_type =3D ARG_PTR_TO_MEM_OR_NULL;
+			sub->args[i].mem_size =3D mem_size;
 			continue;
 		}
 		bpf_log(log, "Arg#%d type %s in %s() is not supported yet.\n",
 			i, btf_type_str(t), tname);
 		return -EINVAL;
 	}
+
+	sub->arg_cnt =3D nargs;
+	sub->args_cached =3D true;
+
 	return 0;
 }
=20
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index ee707736ce6b..16d5550eda4d 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -442,11 +442,6 @@ static struct bpf_func_info_aux *subprog_aux(const s=
truct bpf_verifier_env *env,
 	return &env->prog->aux->func_info_aux[subprog];
 }
=20
-static struct bpf_subprog_info *subprog_info(struct bpf_verifier_env *en=
v, int subprog)
-{
-	return &env->subprog_info[subprog];
-}
-
 static void mark_subprog_exc_cb(struct bpf_verifier_env *env, int subpro=
g)
 {
 	struct bpf_subprog_info *info =3D subprog_info(env, subprog);
@@ -19860,33 +19855,44 @@ static int do_check_common(struct bpf_verifier_=
env *env, int subprog)
=20
 	regs =3D state->frame[state->curframe]->regs;
 	if (subprog || env->prog->type =3D=3D BPF_PROG_TYPE_EXT) {
-		u32 nargs;
+		struct bpf_subprog_info *sub =3D subprog_info(env, subprog);
+		const char *sub_name =3D subprog_name(env, subprog);
+		struct bpf_subprog_arg_info *arg;
+		struct bpf_reg_state *reg;
=20
-		ret =3D btf_prepare_func_args(env, subprog, regs, &nargs);
+		verbose(env, "Validating %s() func#%d...\n", sub_name, subprog);
+		ret =3D btf_prepare_func_args(env, subprog);
 		if (ret)
 			goto out;
+
 		if (subprog_is_exc_cb(env, subprog)) {
 			state->frame[0]->in_exception_callback_fn =3D true;
 			/* We have already ensured that the callback returns an integer, just
 			 * like all global subprogs. We need to determine it only has a singl=
e
 			 * scalar argument.
 			 */
-			if (nargs !=3D 1 || regs[BPF_REG_1].type !=3D SCALAR_VALUE) {
+			if (sub->arg_cnt !=3D 1 || sub->args[0].arg_type !=3D ARG_SCALAR) {
 				verbose(env, "exception cb only supports single integer argument\n")=
;
 				return -EINVAL;
 			}
 		}
 		for (i =3D BPF_REG_1; i <=3D BPF_REG_5; i++) {
-			if (regs[i].type =3D=3D PTR_TO_CTX)
+			arg =3D &sub->args[i - BPF_REG_1];
+			reg =3D &regs[i];
+
+			if (arg->arg_type =3D=3D ARG_PTR_TO_CTX) {
+				reg->type =3D PTR_TO_CTX;
 				mark_reg_known_zero(env, regs, i);
-			else if (regs[i].type =3D=3D SCALAR_VALUE)
+			} else if (arg->arg_type =3D=3D ARG_SCALAR) {
+				reg->type =3D SCALAR_VALUE;
 				mark_reg_unknown(env, regs, i);
-			else if (base_type(regs[i].type) =3D=3D PTR_TO_MEM) {
-				const u32 mem_size =3D regs[i].mem_size;
-
+			} else if (base_type(arg->arg_type) =3D=3D ARG_PTR_TO_MEM) {
+				reg->type =3D PTR_TO_MEM;
+				if (arg->arg_type & PTR_MAYBE_NULL)
+					reg->type |=3D PTR_MAYBE_NULL;
 				mark_reg_known_zero(env, regs, i);
-				regs[i].mem_size =3D mem_size;
-				regs[i].id =3D ++env->id_gen;
+				reg->mem_size =3D arg->mem_size;
+				reg->id =3D ++env->id_gen;
 			}
 		}
 	} else {
--=20
2.34.1


