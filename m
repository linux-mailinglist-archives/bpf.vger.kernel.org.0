Return-Path: <bpf+bounces-41602-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21693998F22
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 20:00:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 530F3B242BC
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 17:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FE951CBEA7;
	Thu, 10 Oct 2024 17:56:34 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 66-220-155-178.mail-mxout.facebook.com (66-220-155-178.mail-mxout.facebook.com [66.220.155.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 479A619C540
	for <bpf@vger.kernel.org>; Thu, 10 Oct 2024 17:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728582994; cv=none; b=QChKZIfuUz0PXeHPXJU1sUAMPQKBYhkOl0ROFn794fod6MjXtagNKFSAmHsPgZqCkJBR/+Pjpwh45D4Yewnt+ga/ulur6JZdofHFyw1tiVJInZ1u3/FYKlLyX2wnazYUGTceIa1eWp3C4wV9//utBrYJQmA0owdaUHYNdCzhXJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728582994; c=relaxed/simple;
	bh=Yh4acin4Y9BX9gyYd6c5K1rXBzwvPRphABy4UlvlPoQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mc9mAoIGpKWVlNplnD5gcZrIMRXRm/wnaxjuRq12u6Y8IpQgIsS4PG/TV1Ig+4UtuuLZl9D5bQgtbWLSRP/96pB+V6j0xn7Hs4Q71jBBa/f6UVfRSaGAcemYaJKjZosl/WhTBU/6ONHD7xBbEGv66SBZyIvx2GqSy2tKtxdvrjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 5D8BB9F27C0F; Thu, 10 Oct 2024 10:56:28 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH bpf-next v4 07/10] bpf: Support calling non-tailcall bpf prog
Date: Thu, 10 Oct 2024 10:56:28 -0700
Message-ID: <20241010175628.1898648-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241010175552.1895980-1-yonghong.song@linux.dev>
References: <20241010175552.1895980-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

A kfunc bpf_prog_call() is introduced such that it can call another bpf
prog within a bpf prog. It has the same parameters as bpf_tail_call()
but acts like a normal function call.

But bpf_prog_call() could recurse to the caller prog itself. So if a bpf
prog calls bpf_prog_call(), that bpf prog will use private stacks with
maximum recursion level 4. The 4 level recursion should work for most
cases.

bpf_prog_call() cannot be used if tail_call exists in the same prog
since tail_call does not use private stack. If both prog_call and
tail_call in the same prog, verification will fail.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 include/linux/bpf.h   |  2 ++
 kernel/bpf/core.c     |  7 +++++--
 kernel/bpf/helpers.c  | 20 ++++++++++++++++++++
 kernel/bpf/verifier.c | 30 ++++++++++++++++++++++++++----
 4 files changed, 53 insertions(+), 6 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index f22ddb423fd0..952cb398eb30 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1493,6 +1493,7 @@ struct bpf_prog_aux {
 	bool exception_cb;
 	bool exception_boundary;
 	bool priv_stack_eligible;
+	bool has_prog_call;
 	struct bpf_arena *arena;
 	/* BTF_KIND_FUNC_PROTO for valid attach_btf_id */
 	const struct btf_type *attach_func_proto;
@@ -1929,6 +1930,7 @@ struct bpf_array {
=20
 #define BPF_COMPLEXITY_LIMIT_INSNS      1000000 /* yes. 1M insns */
 #define MAX_TAIL_CALL_CNT 33
+#define BPF_MAX_PRIV_STACK_NEST_LEVEL	4
=20
 /* Maximum number of loops for bpf_loop and bpf_iter_num.
  * It's enum to expose it (and thus make it discoverable) through BTF.
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index f79d951a061f..0d2c97f63ecf 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -2426,10 +2426,13 @@ struct bpf_prog *bpf_prog_select_runtime(struct b=
pf_prog *fp, int *err)
 				fp->aux->priv_stack_mode =3D NO_PRIV_STACK;
 			} else {
 				void __percpu *priv_stack_ptr;
+				int nest_level =3D 1;
=20
+				if (fp->aux->has_prog_call)
+					nest_level =3D BPF_MAX_PRIV_STACK_NEST_LEVEL;
 				fp->aux->priv_stack_mode =3D PRIV_STACK_ROOT_PROG;
-				priv_stack_ptr =3D
-					__alloc_percpu_gfp(fp->aux->stack_depth, 8, GFP_KERNEL);
+				priv_stack_ptr =3D __alloc_percpu_gfp(
+					fp->aux->stack_depth * nest_level, 8, GFP_KERNEL);
 				if (!priv_stack_ptr) {
 					*err =3D -ENOMEM;
 					return fp;
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 4053f279ed4c..9cc880dc213e 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2749,6 +2749,25 @@ __bpf_kfunc void bpf_rcu_read_unlock(void)
 	rcu_read_unlock();
 }
=20
+__bpf_kfunc int bpf_prog_call(void *ctx, struct bpf_map *p__map, u32 ind=
ex)
+{
+	struct bpf_array *array;
+	struct bpf_prog *prog;
+
+	if (p__map->map_type !=3D BPF_MAP_TYPE_PROG_ARRAY)
+		return -EINVAL;
+
+	array =3D container_of(p__map, struct bpf_array, map);
+	if (unlikely(index >=3D array->map.max_entries))
+		return -E2BIG;
+
+	prog =3D READ_ONCE(array->ptrs[index]);
+	if (!prog)
+		return -ENOENT;
+
+	return bpf_prog_run(prog, ctx);
+}
+
 struct bpf_throw_ctx {
 	struct bpf_prog_aux *aux;
 	u64 sp;
@@ -3035,6 +3054,7 @@ BTF_ID_FLAGS(func, bpf_task_get_cgroup1, KF_ACQUIRE=
 | KF_RCU | KF_RET_NULL)
 #endif
 BTF_ID_FLAGS(func, bpf_task_from_pid, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_throw)
+BTF_ID_FLAGS(func, bpf_prog_call)
 BTF_KFUNCS_END(generic_btf_ids)
=20
 static const struct btf_kfunc_id_set generic_kfunc_set =3D {
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 46b0c277c6a8..e3d9820618a1 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5986,6 +5986,9 @@ static int check_ptr_alignment(struct bpf_verifier_=
env *env,
=20
 static bool bpf_enable_private_stack(struct bpf_prog *prog)
 {
+	if (prog->aux->has_prog_call)
+		return true;
+
 	if (!bpf_jit_supports_private_stack())
 		return false;
=20
@@ -6092,7 +6095,9 @@ static int check_max_stack_depth_subprog(struct bpf=
_verifier_env *env, int idx,
 			return -EACCES;
 		}
=20
-		if (!priv_stack_eligible && depth >=3D BPF_PRIV_STACK_MIN_SUBTREE_SIZE=
) {
+		if (!priv_stack_eligible &&
+		    (depth >=3D BPF_PRIV_STACK_MIN_SUBTREE_SIZE ||
+		     env->prog->aux->has_prog_call)) {
 			subprog[orig_idx].priv_stack_eligible =3D true;
 			env->prog->aux->priv_stack_eligible =3D priv_stack_eligible =3D true;
 		}
@@ -6181,8 +6186,13 @@ static int check_max_stack_depth_subprog(struct bp=
f_verifier_env *env, int idx,
 			}
 			subprog[ret_prog[j]].tail_call_reachable =3D true;
 		}
-	if (!check_priv_stack && subprog[0].tail_call_reachable)
+	if (!check_priv_stack && subprog[0].tail_call_reachable) {
+		if (env->prog->aux->has_prog_call) {
+			verbose(env, "cannot do prog call and tail call in the same prog\n");
+			return -EINVAL;
+		}
 		env->prog->aux->tail_call_reachable =3D true;
+	}
=20
 	/* end of for() loop means the last insn of the 'subprog'
 	 * was reached. Doesn't matter whether it was JA or EXIT
@@ -11322,6 +11332,7 @@ enum special_kfunc_type {
 	KF_bpf_preempt_enable,
 	KF_bpf_iter_css_task_new,
 	KF_bpf_session_cookie,
+	KF_bpf_prog_call,
 };
=20
 BTF_SET_START(special_kfunc_set)
@@ -11387,6 +11398,7 @@ BTF_ID(func, bpf_session_cookie)
 #else
 BTF_ID_UNUSED
 #endif
+BTF_ID(func, bpf_prog_call)
=20
 static bool is_kfunc_ret_null(struct bpf_kfunc_call_arg_meta *meta)
 {
@@ -11433,6 +11445,11 @@ get_kfunc_ptr_arg_type(struct bpf_verifier_env *=
env,
 	if (meta->func_id =3D=3D special_kfunc_list[KF_bpf_cast_to_kern_ctx])
 		return KF_ARG_PTR_TO_CTX;
=20
+	if (meta->func_id =3D=3D special_kfunc_list[KF_bpf_prog_call] && argno =
=3D=3D 0) {
+		env->prog->aux->has_prog_call =3D true;
+		return KF_ARG_PTR_TO_CTX;
+	}
+
 	/* In this function, we verify the kfunc's BTF as per the argument type=
,
 	 * leaving the rest of the verification with respect to the register
 	 * type to our caller. When a set of conditions hold in the BTF type of
@@ -20009,6 +20026,7 @@ static int jit_subprogs(struct bpf_verifier_env *=
env)
 	struct bpf_insn *insn;
 	void *old_bpf_func;
 	int err, num_exentries;
+	int nest_level =3D 1;
=20
 	if (env->subprog_cnt <=3D 1)
 		return 0;
@@ -20099,9 +20117,13 @@ static int jit_subprogs(struct bpf_verifier_env =
*env)
 			} else if (!subtree_stack_depth) {
 				func[i]->aux->priv_stack_mode =3D PRIV_STACK_ROOT_PROG;
 			} else {
+				if (env->prog->aux->has_prog_call) {
+					func[i]->aux->has_prog_call =3D true;
+					nest_level =3D BPF_MAX_PRIV_STACK_NEST_LEVEL;
+				}
 				func[i]->aux->priv_stack_mode =3D PRIV_STACK_ROOT_PROG;
-				priv_stack_ptr =3D
-					__alloc_percpu_gfp(subtree_stack_depth, 8, GFP_KERNEL);
+				priv_stack_ptr =3D __alloc_percpu_gfp(
+					subtree_stack_depth * nest_level, 8, GFP_KERNEL);
 				if (!priv_stack_ptr) {
 					err =3D -ENOMEM;
 					goto out_free;
--=20
2.43.5


