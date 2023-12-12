Return-Path: <bpf+bounces-17610-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F24E080FB4D
	for <lists+bpf@lfdr.de>; Wed, 13 Dec 2023 00:25:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9569D1F218B2
	for <lists+bpf@lfdr.de>; Tue, 12 Dec 2023 23:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF97E64CDB;
	Tue, 12 Dec 2023 23:25:51 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38254AA
	for <bpf@vger.kernel.org>; Tue, 12 Dec 2023 15:25:47 -0800 (PST)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BCLfQjm018930
	for <bpf@vger.kernel.org>; Tue, 12 Dec 2023 15:25:47 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3uxx6q97xe-15
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Tue, 12 Dec 2023 15:25:46 -0800
Received: from twshared51573.38.frc1.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 12 Dec 2023 15:25:44 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 64A9C3D0C89F1; Tue, 12 Dec 2023 15:25:41 -0800 (PST)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH v2 bpf-next 02/10] bpf: reuse btf_prepare_func_args() check for main program BTF validation
Date: Tue, 12 Dec 2023 15:25:27 -0800
Message-ID: <20231212232535.1875938-3-andrii@kernel.org>
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
X-Proofpoint-ORIG-GUID: MG7tCCKCRPhqgRox-lH2-Pmk65Gm6fYX
X-Proofpoint-GUID: MG7tCCKCRPhqgRox-lH2-Pmk65Gm6fYX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-12_12,2023-12-12_01,2023-05-22_02

Instead of btf_check_subprog_arg_match(), use btf_prepare_func_args()
logic to validate "trustworthiness" of main BPF program's BTF information=
,
if it is present.

We ignored results of original BTF check anyway, often times producing
confusing and ominously-sounding "reg type unsupported for arg#0
function" message, which has no apparent effect on program correctness
and verification process.

All the -EFAULT returning sanity checks are already performed in
check_btf_info_early(), so there is zero reason to have this duplication
of logic between btf_check_subprog_call() and btf_check_subprog_arg_match=
().
Dropping btf_check_subprog_arg_match() simplifies
btf_check_func_arg_match() further removing `bool processing_call` flag.

One subtle bit that was done by btf_check_subprog_arg_match() was
potentially marking main program's BTF as unreliable. We do this
explicitly now with a dedicated simple check, preserving the original
behavior, but now based on well factored btf_prepare_func_args() logic.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 include/linux/bpf.h                           |  2 -
 kernel/bpf/btf.c                              | 50 ++-----------------
 kernel/bpf/verifier.c                         | 25 +++++-----
 .../selftests/bpf/prog_tests/log_fixup.c      |  4 +-
 .../selftests/bpf/progs/cgrp_kfunc_failure.c  |  2 +-
 .../selftests/bpf/progs/task_kfunc_failure.c  |  2 +-
 6 files changed, 19 insertions(+), 66 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 6dc82ab156f8..dce11075f83d 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2489,8 +2489,6 @@ int btf_distill_func_proto(struct bpf_verifier_log =
*log,
 			   struct btf_func_model *m);
=20
 struct bpf_reg_state;
-int btf_check_subprog_arg_match(struct bpf_verifier_env *env, int subpro=
g,
-				struct bpf_reg_state *regs);
 int btf_check_subprog_call(struct bpf_verifier_env *env, int subprog,
 			   struct bpf_reg_state *regs);
 int btf_prepare_func_args(struct bpf_verifier_env *env, int subprog);
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index be2104e5f2f5..33d9a1c73f6e 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6768,8 +6768,7 @@ int btf_check_type_match(struct bpf_verifier_log *l=
og, const struct bpf_prog *pr
 static int btf_check_func_arg_match(struct bpf_verifier_env *env,
 				    const struct btf *btf, u32 func_id,
 				    struct bpf_reg_state *regs,
-				    bool ptr_to_mem_ok,
-				    bool processing_call)
+				    bool ptr_to_mem_ok)
 {
 	enum bpf_prog_type prog_type =3D resolve_prog_type(env->prog);
 	struct bpf_verifier_log *log =3D &env->log;
@@ -6842,7 +6841,7 @@ static int btf_check_func_arg_match(struct bpf_veri=
fier_env *env,
 					i, btf_type_str(t));
 				return -EINVAL;
 			}
-		} else if (ptr_to_mem_ok && processing_call) {
+		} else if (ptr_to_mem_ok) {
 			const struct btf_type *resolve_ret;
 			u32 type_size;
=20
@@ -6867,55 +6866,12 @@ static int btf_check_func_arg_match(struct bpf_ve=
rifier_env *env,
 	return 0;
 }
=20
-/* Compare BTF of a function declaration with given bpf_reg_state.
- * Returns:
- * EFAULT - there is a verifier bug. Abort verification.
- * EINVAL - there is a type mismatch or BTF is not available.
- * 0 - BTF matches with what bpf_reg_state expects.
- * Only PTR_TO_CTX and SCALAR_VALUE states are recognized.
- */
-int btf_check_subprog_arg_match(struct bpf_verifier_env *env, int subpro=
g,
-				struct bpf_reg_state *regs)
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
-	err =3D btf_check_func_arg_match(env, btf, btf_id, regs, is_global, fal=
se);
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
 /* Compare BTF of a function call with given bpf_reg_state.
  * Returns:
  * EFAULT - there is a verifier bug. Abort verification.
  * EINVAL - there is a type mismatch or BTF is not available.
  * 0 - BTF matches with what bpf_reg_state expects.
  * Only PTR_TO_CTX and SCALAR_VALUE states are recognized.
- *
- * NOTE: the code is duplicated from btf_check_subprog_arg_match()
- * because btf_check_func_arg_match() is still doing both. Once that
- * function is split in 2, we can call from here btf_check_subprog_arg_m=
atch()
- * first, and then treat the calling part in a new code path.
  */
 int btf_check_subprog_call(struct bpf_verifier_env *env, int subprog,
 			   struct bpf_reg_state *regs)
@@ -6937,7 +6893,7 @@ int btf_check_subprog_call(struct bpf_verifier_env =
*env, int subprog,
 		return -EINVAL;
=20
 	is_global =3D prog->aux->func_info_aux[subprog].linkage =3D=3D BTF_FUNC=
_GLOBAL;
-	err =3D btf_check_func_arg_match(env, btf, btf_id, regs, is_global, tru=
e);
+	err =3D btf_check_func_arg_match(env, btf, btf_id, regs, is_global);
=20
 	/* Compiler optimizations can remove arguments from static functions
 	 * or mismatched type can be passed into a global function.
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index d2436b4749f7..a038d24c6855 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -19869,6 +19869,7 @@ static void free_states(struct bpf_verifier_env *=
env)
 static int do_check_common(struct bpf_verifier_env *env, int subprog)
 {
 	bool pop_log =3D !(env->log.level & BPF_LOG_LEVEL2);
+	struct bpf_subprog_info *sub =3D subprog_info(env, subprog);
 	struct bpf_verifier_state *state;
 	struct bpf_reg_state *regs;
 	int ret, i;
@@ -19895,9 +19896,9 @@ static int do_check_common(struct bpf_verifier_en=
v *env, int subprog)
 	state->first_insn_idx =3D env->subprog_info[subprog].start;
 	state->last_insn_idx =3D -1;
=20
+
 	regs =3D state->frame[state->curframe]->regs;
 	if (subprog || env->prog->type =3D=3D BPF_PROG_TYPE_EXT) {
-		struct bpf_subprog_info *sub =3D subprog_info(env, subprog);
 		const char *sub_name =3D subprog_name(env, subprog);
 		struct bpf_subprog_arg_info *arg;
 		struct bpf_reg_state *reg;
@@ -19944,21 +19945,19 @@ static int do_check_common(struct bpf_verifier_=
env *env, int subprog)
 			}
 		}
 	} else {
+		/* if main BPF program has associated BTF info, validate that
+		 * it's matching expected signature, and otherwise mark BTF
+		 * info for main program as unreliable
+		 */
+		if (env->prog->aux->func_info_aux) {
+			ret =3D btf_prepare_func_args(env, 0);
+			if (ret || sub->arg_cnt !=3D 1 || sub->args[0].arg_type !=3D ARG_PTR_=
TO_CTX)
+				env->prog->aux->func_info_aux[0].unreliable =3D true;
+		}
+
 		/* 1st arg to a function */
 		regs[BPF_REG_1].type =3D PTR_TO_CTX;
 		mark_reg_known_zero(env, regs, BPF_REG_1);
-		ret =3D btf_check_subprog_arg_match(env, subprog, regs);
-		if (ret =3D=3D -EFAULT)
-			/* unlikely verifier bug. abort.
-			 * ret =3D=3D 0 and ret < 0 are sadly acceptable for
-			 * main() function due to backward compatibility.
-			 * Like socket filter program may be written as:
-			 * int bpf_prog(struct pt_regs *ctx)
-			 * and never dereference that ctx in the program.
-			 * 'struct pt_regs' is a type mismatch for socket
-			 * filter that should be using 'struct __sk_buff'.
-			 */
-			goto out;
 	}
=20
 	ret =3D do_check(env);
diff --git a/tools/testing/selftests/bpf/prog_tests/log_fixup.c b/tools/t=
esting/selftests/bpf/prog_tests/log_fixup.c
index effd78b2a657..7a3fa2ff567b 100644
--- a/tools/testing/selftests/bpf/prog_tests/log_fixup.c
+++ b/tools/testing/selftests/bpf/prog_tests/log_fixup.c
@@ -169,9 +169,9 @@ void test_log_fixup(void)
 	if (test__start_subtest("bad_core_relo_trunc_none"))
 		bad_core_relo(0, TRUNC_NONE /* full buf */);
 	if (test__start_subtest("bad_core_relo_trunc_partial"))
-		bad_core_relo(300, TRUNC_PARTIAL /* truncate original log a bit */);
+		bad_core_relo(280, TRUNC_PARTIAL /* truncate original log a bit */);
 	if (test__start_subtest("bad_core_relo_trunc_full"))
-		bad_core_relo(210, TRUNC_FULL  /* truncate also libbpf's message patch=
 */);
+		bad_core_relo(220, TRUNC_FULL  /* truncate also libbpf's message patch=
 */);
 	if (test__start_subtest("bad_core_relo_subprog"))
 		bad_core_relo_subprog();
 	if (test__start_subtest("missing_map"))
diff --git a/tools/testing/selftests/bpf/progs/cgrp_kfunc_failure.c b/too=
ls/testing/selftests/bpf/progs/cgrp_kfunc_failure.c
index 0fa564a5cc5b..9fe9c4a4e8f6 100644
--- a/tools/testing/selftests/bpf/progs/cgrp_kfunc_failure.c
+++ b/tools/testing/selftests/bpf/progs/cgrp_kfunc_failure.c
@@ -78,7 +78,7 @@ int BPF_PROG(cgrp_kfunc_acquire_fp, struct cgroup *cgrp=
, const char *path)
 }
=20
 SEC("kretprobe/cgroup_destroy_locked")
-__failure __msg("reg type unsupported for arg#0 function")
+__failure __msg("calling kernel function bpf_cgroup_acquire is not allow=
ed")
 int BPF_PROG(cgrp_kfunc_acquire_unsafe_kretprobe, struct cgroup *cgrp)
 {
 	struct cgroup *acquired;
diff --git a/tools/testing/selftests/bpf/progs/task_kfunc_failure.c b/too=
ls/testing/selftests/bpf/progs/task_kfunc_failure.c
index dcdea3127086..ad88a3796ddf 100644
--- a/tools/testing/selftests/bpf/progs/task_kfunc_failure.c
+++ b/tools/testing/selftests/bpf/progs/task_kfunc_failure.c
@@ -248,7 +248,7 @@ int BPF_PROG(task_kfunc_from_pid_no_null_check, struc=
t task_struct *task, u64 cl
 }
=20
 SEC("lsm/task_free")
-__failure __msg("reg type unsupported for arg#0 function")
+__failure __msg("R1 must be a rcu pointer")
 int BPF_PROG(task_kfunc_from_lsm_task_free, struct task_struct *task)
 {
 	struct task_struct *acquired;
--=20
2.34.1


