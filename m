Return-Path: <bpf+bounces-16660-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51F7D8042A8
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 00:40:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CDCA2B20B4E
	for <lists+bpf@lfdr.de>; Mon,  4 Dec 2023 23:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46A10364C8;
	Mon,  4 Dec 2023 23:40:02 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6DA2101
	for <bpf@vger.kernel.org>; Mon,  4 Dec 2023 15:39:58 -0800 (PST)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B4KGrmJ007860
	for <bpf@vger.kernel.org>; Mon, 4 Dec 2023 15:39:58 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3us6mcg0kq-18
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Mon, 04 Dec 2023 15:39:58 -0800
Received: from twshared10507.42.prn1.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a8:83::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 4 Dec 2023 15:39:53 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id DA93E3C9725E9; Mon,  4 Dec 2023 15:39:40 -0800 (PST)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH bpf-next 03/13] bpf: tidy up exception callback management a bit
Date: Mon, 4 Dec 2023 15:39:21 -0800
Message-ID: <20231204233931.49758-4-andrii@kernel.org>
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
X-Proofpoint-GUID: 5CnAXC25cifvb9rdUosgcew-Q-gQV7zr
X-Proofpoint-ORIG-GUID: 5CnAXC25cifvb9rdUosgcew-Q-gQV7zr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-04_22,2023-12-04_01,2023-05-22_02

Use the fact that we are passing subprog index around and have
a corresponding struct bpf_subprog_info in bpf_verifier_env for each
subprogram. We don't need to separately pass around a flag whether
subprog is exception callback or not, each relevant verifier function
can determine this using provided subprog index if we maintain
bpf_subprog_info properly.

Also move out exception callback-specific logic from
btf_prepare_func_args(), keeping it generic. We can enforce all these
restriction right before exception callback verification pass. We add
out parameter, arg_cnt, for now, but this will be unnecessary with
subsequent refactoring and will be removed.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 include/linux/bpf.h   |  2 +-
 kernel/bpf/btf.c      | 11 ++--------
 kernel/bpf/verifier.c | 51 ++++++++++++++++++++++++++++++++-----------
 3 files changed, 41 insertions(+), 23 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index eb447b0a9423..379ac0a28405 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2431,7 +2431,7 @@ int btf_check_subprog_arg_match(struct bpf_verifier=
_env *env, int subprog,
 int btf_check_subprog_call(struct bpf_verifier_env *env, int subprog,
 			   struct bpf_reg_state *regs);
 int btf_prepare_func_args(struct bpf_verifier_env *env, int subprog,
-			  struct bpf_reg_state *reg, bool is_ex_cb);
+			  struct bpf_reg_state *reg, u32 *nargs);
 int btf_check_type_match(struct bpf_verifier_log *log, const struct bpf_=
prog *prog,
 			 struct btf *btf, const struct btf_type *t);
 const char *btf_find_decl_tag_value(const struct btf *btf, const struct =
btf_type *pt,
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 63cf4128fc05..d56433bf8aba 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6956,7 +6956,7 @@ int btf_check_subprog_call(struct bpf_verifier_env =
*env, int subprog,
  * (either PTR_TO_CTX or SCALAR_VALUE).
  */
 int btf_prepare_func_args(struct bpf_verifier_env *env, int subprog,
-			  struct bpf_reg_state *regs, bool is_ex_cb)
+			  struct bpf_reg_state *regs, u32 *arg_cnt)
 {
 	struct bpf_verifier_log *log =3D &env->log;
 	struct bpf_prog *prog =3D env->prog;
@@ -7013,6 +7013,7 @@ int btf_prepare_func_args(struct bpf_verifier_env *=
env, int subprog,
 			tname, nargs, MAX_BPF_FUNC_REG_ARGS);
 		return -EINVAL;
 	}
+	*arg_cnt =3D nargs;
 	/* check that function returns int, exception cb also requires this */
 	t =3D btf_type_by_id(btf, t->type);
 	while (btf_type_is_modifier(t))
@@ -7062,14 +7063,6 @@ int btf_prepare_func_args(struct bpf_verifier_env =
*env, int subprog,
 			i, btf_type_str(t), tname);
 		return -EINVAL;
 	}
-	/* We have already ensured that the callback returns an integer, just
-	 * like all global subprogs. We need to determine it only has a single
-	 * scalar argument.
-	 */
-	if (is_ex_cb && (nargs !=3D 1 || regs[BPF_REG_1].type !=3D SCALAR_VALUE=
)) {
-		bpf_log(log, "exception cb only supports single integer argument\n");
-		return -EINVAL;
-	}
 	return 0;
 }
=20
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index cdb4f5f0ba79..ee707736ce6b 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -442,6 +442,25 @@ static struct bpf_func_info_aux *subprog_aux(const s=
truct bpf_verifier_env *env,
 	return &env->prog->aux->func_info_aux[subprog];
 }
=20
+static struct bpf_subprog_info *subprog_info(struct bpf_verifier_env *en=
v, int subprog)
+{
+	return &env->subprog_info[subprog];
+}
+
+static void mark_subprog_exc_cb(struct bpf_verifier_env *env, int subpro=
g)
+{
+	struct bpf_subprog_info *info =3D subprog_info(env, subprog);
+
+	info->is_cb =3D true;
+	info->is_async_cb =3D true;
+	info->is_exception_cb =3D true;
+}
+
+static bool subprog_is_exc_cb(struct bpf_verifier_env *env, int subprog)
+{
+	return subprog_info(env, subprog)->is_exception_cb;
+}
+
 static bool reg_may_point_to_spin_lock(const struct bpf_reg_state *reg)
 {
 	return btf_record_has_field(reg_btf_record(reg), BPF_SPIN_LOCK);
@@ -2865,6 +2884,7 @@ static int add_subprog_and_kfunc(struct bpf_verifie=
r_env *env)
 			if (env->subprog_info[i].start !=3D ex_cb_insn)
 				continue;
 			env->exception_callback_subprog =3D i;
+			mark_subprog_exc_cb(env, i);
 			break;
 		}
 	}
@@ -19109,9 +19129,7 @@ static int do_misc_fixups(struct bpf_verifier_env=
 *env)
=20
 		env->exception_callback_subprog =3D env->subprog_cnt - 1;
 		/* Don't update insn_cnt, as add_hidden_subprog always appends insns *=
/
-		env->subprog_info[env->exception_callback_subprog].is_cb =3D true;
-		env->subprog_info[env->exception_callback_subprog].is_async_cb =3D tru=
e;
-		env->subprog_info[env->exception_callback_subprog].is_exception_cb =3D=
 true;
+		mark_subprog_exc_cb(env, env->exception_callback_subprog);
 	}
=20
 	for (i =3D 0; i < insn_cnt; i++, insn++) {
@@ -19811,7 +19829,7 @@ static void free_states(struct bpf_verifier_env *=
env)
 	}
 }
=20
-static int do_check_common(struct bpf_verifier_env *env, int subprog, bo=
ol is_ex_cb)
+static int do_check_common(struct bpf_verifier_env *env, int subprog)
 {
 	bool pop_log =3D !(env->log.level & BPF_LOG_LEVEL2);
 	struct bpf_verifier_state *state;
@@ -19842,9 +19860,22 @@ static int do_check_common(struct bpf_verifier_e=
nv *env, int subprog, bool is_ex
=20
 	regs =3D state->frame[state->curframe]->regs;
 	if (subprog || env->prog->type =3D=3D BPF_PROG_TYPE_EXT) {
-		ret =3D btf_prepare_func_args(env, subprog, regs, is_ex_cb);
+		u32 nargs;
+
+		ret =3D btf_prepare_func_args(env, subprog, regs, &nargs);
 		if (ret)
 			goto out;
+		if (subprog_is_exc_cb(env, subprog)) {
+			state->frame[0]->in_exception_callback_fn =3D true;
+			/* We have already ensured that the callback returns an integer, just
+			 * like all global subprogs. We need to determine it only has a singl=
e
+			 * scalar argument.
+			 */
+			if (nargs !=3D 1 || regs[BPF_REG_1].type !=3D SCALAR_VALUE) {
+				verbose(env, "exception cb only supports single integer argument\n")=
;
+				return -EINVAL;
+			}
+		}
 		for (i =3D BPF_REG_1; i <=3D BPF_REG_5; i++) {
 			if (regs[i].type =3D=3D PTR_TO_CTX)
 				mark_reg_known_zero(env, regs, i);
@@ -19858,12 +19889,6 @@ static int do_check_common(struct bpf_verifier_e=
nv *env, int subprog, bool is_ex
 				regs[i].id =3D ++env->id_gen;
 			}
 		}
-		if (is_ex_cb) {
-			state->frame[0]->in_exception_callback_fn =3D true;
-			env->subprog_info[subprog].is_cb =3D true;
-			env->subprog_info[subprog].is_async_cb =3D true;
-			env->subprog_info[subprog].is_exception_cb =3D true;
-		}
 	} else {
 		/* 1st arg to a function */
 		regs[BPF_REG_1].type =3D PTR_TO_CTX;
@@ -19943,7 +19968,7 @@ static int do_check_subprogs(struct bpf_verifier_=
env *env)
=20
 		env->insn_idx =3D env->subprog_info[i].start;
 		WARN_ON_ONCE(env->insn_idx =3D=3D 0);
-		ret =3D do_check_common(env, i, env->exception_callback_subprog =3D=3D=
 i);
+		ret =3D do_check_common(env, i);
 		if (ret) {
 			return ret;
 		} else if (env->log.level & BPF_LOG_LEVEL) {
@@ -19973,7 +19998,7 @@ static int do_check_main(struct bpf_verifier_env =
*env)
 	int ret;
=20
 	env->insn_idx =3D 0;
-	ret =3D do_check_common(env, 0, false);
+	ret =3D do_check_common(env, 0);
 	if (!ret)
 		env->prog->aux->stack_depth =3D env->subprog_info[0].stack_depth;
 	return ret;
--=20
2.34.1


