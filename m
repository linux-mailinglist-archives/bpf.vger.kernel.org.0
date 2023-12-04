Return-Path: <bpf+bounces-16658-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DA548042A4
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 00:40:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE23F2812E7
	for <lists+bpf@lfdr.de>; Mon,  4 Dec 2023 23:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B34E35EE9;
	Mon,  4 Dec 2023 23:39:59 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 936CFFF
	for <bpf@vger.kernel.org>; Mon,  4 Dec 2023 15:39:55 -0800 (PST)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B4KGrmA007860
	for <bpf@vger.kernel.org>; Mon, 4 Dec 2023 15:39:55 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3us6mcg0kq-13
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Mon, 04 Dec 2023 15:39:55 -0800
Received: from twshared17205.35.frc1.facebook.com (2620:10d:c0a8:1c::11) by
 mail.thefacebook.com (2620:10d:c0a8:83::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 4 Dec 2023 15:39:51 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 56C803C97261F; Mon,  4 Dec 2023 15:39:47 -0800 (PST)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH bpf-next 06/13] bpf: remove unnecessary and (mostly) ignored BTF check for main program
Date: Mon, 4 Dec 2023 15:39:24 -0800
Message-ID: <20231204233931.49758-7-andrii@kernel.org>
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
X-Proofpoint-GUID: TPnqUVdn85dR2jajklenSHlziDQrM_tR
X-Proofpoint-ORIG-GUID: TPnqUVdn85dR2jajklenSHlziDQrM_tR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-04_22,2023-12-04_01,2023-05-22_02

We ignore results of BTF check anyway, often times producing confusing
and ominously-sounding "reg type unsupported for arg#0 function"
message, which has no apparent effect on program correctness and
verification process.

All the -EFAULT returning sanity checks are already performed in
check_btf_info_early(), so there is zero reason to have this duplication
of logic between btf_check_subprog_call() and btf_check_subprog_arg_match=
().
Dropping btf_check_subprog_arg_match() simplifies
btf_check_func_arg_match() further removing `bool processing_call` flag.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 include/linux/bpf.h                           |  2 -
 kernel/bpf/btf.c                              | 50 ++-----------------
 kernel/bpf/verifier.c                         | 12 -----
 .../selftests/bpf/prog_tests/log_fixup.c      |  4 +-
 .../selftests/bpf/progs/cgrp_kfunc_failure.c  |  2 +-
 .../selftests/bpf/progs/task_kfunc_failure.c  |  2 +-
 6 files changed, 7 insertions(+), 65 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index c3a5d0fe3cdf..f3811f49e616 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2427,8 +2427,6 @@ int btf_distill_func_proto(struct bpf_verifier_log =
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
index 33a62df9c5a8..bd430a8b842e 100644
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
index 16d5550eda4d..642260d277ce 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -19899,18 +19899,6 @@ static int do_check_common(struct bpf_verifier_e=
nv *env, int subprog)
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
index effd78b2a657..a98a3ad1ddf7 100644
--- a/tools/testing/selftests/bpf/prog_tests/log_fixup.c
+++ b/tools/testing/selftests/bpf/prog_tests/log_fixup.c
@@ -169,9 +169,9 @@ void test_log_fixup(void)
 	if (test__start_subtest("bad_core_relo_trunc_none"))
 		bad_core_relo(0, TRUNC_NONE /* full buf */);
 	if (test__start_subtest("bad_core_relo_trunc_partial"))
-		bad_core_relo(300, TRUNC_PARTIAL /* truncate original log a bit */);
+		bad_core_relo(250, TRUNC_PARTIAL /* truncate original log a bit */);
 	if (test__start_subtest("bad_core_relo_trunc_full"))
-		bad_core_relo(210, TRUNC_FULL  /* truncate also libbpf's message patch=
 */);
+		bad_core_relo(170, TRUNC_FULL  /* truncate also libbpf's message patch=
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


