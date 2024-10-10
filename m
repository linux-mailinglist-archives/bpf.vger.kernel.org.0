Return-Path: <bpf+bounces-41597-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C71B998EFB
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 19:56:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8A9B2868C7
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 17:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 533B61CC16D;
	Thu, 10 Oct 2024 17:56:12 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 66-220-155-179.mail-mxout.facebook.com (66-220-155-179.mail-mxout.facebook.com [66.220.155.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4160019D88F
	for <bpf@vger.kernel.org>; Thu, 10 Oct 2024 17:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728582972; cv=none; b=jf18n3NjudR8Jwzr4/ykUNXNCysFCrhOlHSpZzOXVwk88tWWG6pgkjJTl0+8FKLQtqTbtVveZm1opvqWiVvShsd1him1bmdq2S0/2CMW4EnK7GSH5YYVzL1btcTpcxWFyGvBAWzbgzX/KW0nLhZKQHZzgGcwW3D0FAjCMH12bKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728582972; c=relaxed/simple;
	bh=dH77XZDdDja86mX4woV126qUrkN2KNSE1ve/Xg7khok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IzSe9k/2pN86cn8izy2cIYx1wK2Zm4kmZgQGs+5r7bmXNh9/Bg6H42Nw0vAqd/f7RAXBiqKPXIQhcPK41LDM/eWnpt98K17cvpe2Ek8HVSjIjTOXcQUDAYe43XJN5nsH0l8mGEnxHH+a5/7F9gXz2uVCTxnlxyD6ms39Vb1TJzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 98A129F27B35; Thu, 10 Oct 2024 10:55:57 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH bpf-next v4 01/10] bpf: Allow each subprog having stack size of 512 bytes
Date: Thu, 10 Oct 2024 10:55:57 -0700
Message-ID: <20241010175557.1896301-1-yonghong.song@linux.dev>
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

With private stack support, each subprog can have stack with up to 512
bytes. The limit of 512 bytes per subprog is kept to avoid increasing
verifier complexity since greater than 512 bytes will cause big verifier
change and increase memory consumption and verification time.

If private stack is supported, for a bpf prog, esp. when it has
subprogs, private stack will be allocated for the main prog
and for each callback subprog. For example,
  main_prog
    subprog1
      calling helper
        subprog10 (callback func)
          subprog11
    subprog2
      calling helper
        subprog10 (callback func)
          subprog11

Separate private allocations for main_prog and callback_fn subprog10
will make things easier since the helper function uses the kernel stack.

Additional subprog info is also collected for later to
allocate private stack for main prog and each callback functions.

Note that if any tail_call is called in the prog (including all subprogs)=
,
then private stack is not used.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 include/linux/bpf.h          |  1 +
 include/linux/bpf_verifier.h |  3 ++
 include/linux/filter.h       |  1 +
 kernel/bpf/core.c            |  5 ++
 kernel/bpf/verifier.c        | 94 +++++++++++++++++++++++++++++++-----
 5 files changed, 91 insertions(+), 13 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 19d8ca8ac960..9ef9133e0470 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1483,6 +1483,7 @@ struct bpf_prog_aux {
 	bool xdp_has_frags;
 	bool exception_cb;
 	bool exception_boundary;
+	bool priv_stack_eligible;
 	struct bpf_arena *arena;
 	/* BTF_KIND_FUNC_PROTO for valid attach_btf_id */
 	const struct btf_type *attach_func_proto;
diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 4513372c5bc8..bcfe868e3801 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -659,6 +659,8 @@ struct bpf_subprog_info {
 	 * are used for bpf_fastcall spills and fills.
 	 */
 	s16 fastcall_stack_off;
+	u16 subtree_stack_depth;
+	u16 subtree_top_idx;
 	bool has_tail_call: 1;
 	bool tail_call_reachable: 1;
 	bool has_ld_abs: 1;
@@ -668,6 +670,7 @@ struct bpf_subprog_info {
 	bool args_cached: 1;
 	/* true if bpf_fastcall stack region is used by functions that can't be=
 inlined */
 	bool keep_fastcall_stack: 1;
+	bool priv_stack_eligible: 1;
=20
 	u8 arg_cnt;
 	struct bpf_subprog_arg_info args[MAX_BPF_FUNC_REG_ARGS];
diff --git a/include/linux/filter.h b/include/linux/filter.h
index 7d7578a8eac1..3a21947f2fd4 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -1119,6 +1119,7 @@ bool bpf_jit_supports_exceptions(void);
 bool bpf_jit_supports_ptr_xchg(void);
 bool bpf_jit_supports_arena(void);
 bool bpf_jit_supports_insn(struct bpf_insn *insn, bool in_arena);
+bool bpf_jit_supports_private_stack(void);
 u64 bpf_arch_uaddress_limit(void);
 void arch_bpf_stack_walk(bool (*consume_fn)(void *cookie, u64 ip, u64 sp=
, u64 bp), void *cookie);
 bool bpf_helper_changes_pkt_data(void *func);
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 5e77c58e0601..ba088b58746f 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -3044,6 +3044,11 @@ bool __weak bpf_jit_supports_exceptions(void)
 	return false;
 }
=20
+bool __weak bpf_jit_supports_private_stack(void)
+{
+	return false;
+}
+
 void __weak arch_bpf_stack_walk(bool (*consume_fn)(void *cookie, u64 ip,=
 u64 sp, u64 bp), void *cookie)
 {
 }
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 7d9b38ffd220..3972606f97d2 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -194,6 +194,8 @@ struct bpf_verifier_stack_elem {
=20
 #define BPF_GLOBAL_PERCPU_MA_MAX_SIZE  512
=20
+#define BPF_PRIV_STACK_MIN_SUBTREE_SIZE	128
+
 static int acquire_reference_state(struct bpf_verifier_env *env, int ins=
n_idx);
 static int release_reference(struct bpf_verifier_env *env, int ref_obj_i=
d);
 static void invalidate_non_owning_refs(struct bpf_verifier_env *env);
@@ -5982,6 +5984,41 @@ static int check_ptr_alignment(struct bpf_verifier=
_env *env,
 					   strict);
 }
=20
+static bool bpf_enable_private_stack(struct bpf_prog *prog)
+{
+	if (!bpf_jit_supports_private_stack())
+		return false;
+
+	switch (prog->aux->prog->type) {
+	case BPF_PROG_TYPE_KPROBE:
+	case BPF_PROG_TYPE_TRACEPOINT:
+	case BPF_PROG_TYPE_PERF_EVENT:
+	case BPF_PROG_TYPE_RAW_TRACEPOINT:
+		return true;
+	case BPF_PROG_TYPE_TRACING:
+		if (prog->expected_attach_type !=3D BPF_TRACE_ITER)
+			return true;
+		fallthrough;
+	default:
+		return false;
+	}
+}
+
+static bool is_priv_stack_supported(struct bpf_verifier_env *env)
+{
+	struct bpf_subprog_info *si =3D env->subprog_info;
+	bool has_tail_call =3D false;
+
+	for (int i =3D 0; i < env->subprog_cnt; i++) {
+		if (si[i].has_tail_call) {
+			has_tail_call =3D true;
+			break;
+		}
+	}
+
+	return !has_tail_call && bpf_enable_private_stack(env->prog);
+}
+
 static int round_up_stack_depth(struct bpf_verifier_env *env, int stack_=
depth)
 {
 	if (env->prog->jit_requested)
@@ -5999,16 +6036,21 @@ static int round_up_stack_depth(struct bpf_verifi=
er_env *env, int stack_depth)
  * Since recursion is prevented by check_cfg() this algorithm
  * only needs a local stack of MAX_CALL_FRAMES to remember callsites
  */
-static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, i=
nt idx)
+static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, i=
nt idx,
+					 bool check_priv_stack, bool priv_stack_supported)
 {
 	struct bpf_subprog_info *subprog =3D env->subprog_info;
 	struct bpf_insn *insn =3D env->prog->insnsi;
 	int depth =3D 0, frame =3D 0, i, subprog_end;
 	bool tail_call_reachable =3D false;
+	bool priv_stack_eligible =3D false;
 	int ret_insn[MAX_CALL_FRAMES];
 	int ret_prog[MAX_CALL_FRAMES];
-	int j;
+	int j, subprog_stack_depth;
+	int orig_idx =3D idx;
=20
+	if (check_priv_stack)
+		subprog[idx].subtree_top_idx =3D idx;
 	i =3D subprog[idx].start;
 process_func:
 	/* protect against potential stack overflow that might happen when
@@ -6030,18 +6072,33 @@ static int check_max_stack_depth_subprog(struct b=
pf_verifier_env *env, int idx)
 	 * tailcall will unwind the current stack frame but it will not get rid
 	 * of caller's stack as shown on the example above.
 	 */
-	if (idx && subprog[idx].has_tail_call && depth >=3D 256) {
+	if (!check_priv_stack && idx && subprog[idx].has_tail_call && depth >=3D=
 256) {
 		verbose(env,
 			"tail_calls are not allowed when call stack of previous frames is %d =
bytes. Too large\n",
 			depth);
 		return -EACCES;
 	}
-	depth +=3D round_up_stack_depth(env, subprog[idx].stack_depth);
-	if (depth > MAX_BPF_STACK) {
+	subprog_stack_depth =3D round_up_stack_depth(env, subprog[idx].stack_de=
pth);
+	depth +=3D subprog_stack_depth;
+	if (!check_priv_stack && !priv_stack_supported && depth > MAX_BPF_STACK=
) {
 		verbose(env, "combined stack size of %d calls is %d. Too large\n",
 			frame + 1, depth);
 		return -EACCES;
 	}
+	if (check_priv_stack) {
+		if (subprog_stack_depth > MAX_BPF_STACK) {
+			verbose(env, "stack size of subprog %d is %d. Too large\n",
+				idx, subprog_stack_depth);
+			return -EACCES;
+		}
+
+		if (!priv_stack_eligible && depth >=3D BPF_PRIV_STACK_MIN_SUBTREE_SIZE=
) {
+			subprog[orig_idx].priv_stack_eligible =3D true;
+			env->prog->aux->priv_stack_eligible =3D priv_stack_eligible =3D true;
+		}
+		subprog[orig_idx].subtree_stack_depth =3D
+			max_t(u16, subprog[orig_idx].subtree_stack_depth, depth);
+	}
 continue_func:
 	subprog_end =3D subprog[idx + 1].start;
 	for (; i < subprog_end; i++) {
@@ -6097,8 +6154,10 @@ static int check_max_stack_depth_subprog(struct bp=
f_verifier_env *env, int idx)
 		}
 		i =3D next_insn;
 		idx =3D sidx;
+		if (check_priv_stack)
+			subprog[idx].subtree_top_idx =3D orig_idx;
=20
-		if (subprog[idx].has_tail_call)
+		if (!check_priv_stack && subprog[idx].has_tail_call)
 			tail_call_reachable =3D true;
=20
 		frame++;
@@ -6122,7 +6181,7 @@ static int check_max_stack_depth_subprog(struct bpf=
_verifier_env *env, int idx)
 			}
 			subprog[ret_prog[j]].tail_call_reachable =3D true;
 		}
-	if (subprog[0].tail_call_reachable)
+	if (!check_priv_stack && subprog[0].tail_call_reachable)
 		env->prog->aux->tail_call_reachable =3D true;
=20
 	/* end of for() loop means the last insn of the 'subprog'
@@ -6137,14 +6196,18 @@ static int check_max_stack_depth_subprog(struct b=
pf_verifier_env *env, int idx)
 	goto continue_func;
 }
=20
-static int check_max_stack_depth(struct bpf_verifier_env *env)
+static int check_max_stack_depth(struct bpf_verifier_env *env, bool chec=
k_priv_stack,
+				 bool priv_stack_supported)
 {
 	struct bpf_subprog_info *si =3D env->subprog_info;
+	bool check_subprog;
 	int ret;
=20
 	for (int i =3D 0; i < env->subprog_cnt; i++) {
-		if (!i || si[i].is_async_cb) {
-			ret =3D check_max_stack_depth_subprog(env, i);
+		check_subprog =3D !i || (check_priv_stack ? si[i].is_cb : si[i].is_asy=
nc_cb);
+		if (check_subprog) {
+			ret =3D check_max_stack_depth_subprog(env, i, check_priv_stack,
+							    priv_stack_supported);
 			if (ret < 0)
 				return ret;
 		}
@@ -22298,7 +22361,7 @@ int bpf_check(struct bpf_prog **prog, union bpf_a=
ttr *attr, bpfptr_t uattr, __u3
 	struct bpf_verifier_env *env;
 	int i, len, ret =3D -EINVAL, err;
 	u32 log_true_size;
-	bool is_priv;
+	bool is_priv, priv_stack_supported =3D false;
=20
 	/* no program is valid */
 	if (ARRAY_SIZE(bpf_verifier_ops) =3D=3D 0)
@@ -22425,8 +22488,10 @@ int bpf_check(struct bpf_prog **prog, union bpf_=
attr *attr, bpfptr_t uattr, __u3
 	if (ret =3D=3D 0)
 		ret =3D remove_fastcall_spills_fills(env);
=20
-	if (ret =3D=3D 0)
-		ret =3D check_max_stack_depth(env);
+	if (ret =3D=3D 0) {
+		priv_stack_supported =3D is_priv_stack_supported(env);
+		ret =3D check_max_stack_depth(env, false, priv_stack_supported);
+	}
=20
 	/* instruction rewrites happen after this point */
 	if (ret =3D=3D 0)
@@ -22460,6 +22525,9 @@ int bpf_check(struct bpf_prog **prog, union bpf_a=
ttr *attr, bpfptr_t uattr, __u3
 								     : false;
 	}
=20
+	if (ret =3D=3D 0 && priv_stack_supported)
+		ret =3D check_max_stack_depth(env, true, true);
+
 	if (ret =3D=3D 0)
 		ret =3D fixup_call_args(env);
=20
--=20
2.43.5


