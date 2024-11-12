Return-Path: <bpf+bounces-44649-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 055359C5D81
	for <lists+bpf@lfdr.de>; Tue, 12 Nov 2024 17:39:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9411282576
	for <lists+bpf@lfdr.de>; Tue, 12 Nov 2024 16:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 566C5206E63;
	Tue, 12 Nov 2024 16:39:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 66-220-155-178.mail-mxout.facebook.com (66-220-155-178.mail-mxout.facebook.com [66.220.155.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E59205ABA
	for <bpf@vger.kernel.org>; Tue, 12 Nov 2024 16:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731429563; cv=none; b=lDpC/8iHvBudUlh6ovLU6gDSjQOFOxrWVjLs+TT/ZyzvgPUXht+Tfzr40X4CGrL3BNqU+kPt0oWzJ8Ov3KcoHRUVL9YBStxXdhbIwaojOqvrUkbziUUKV75oKK5WwOYRKDbCQX1Aa8UYKkQrHREuZuo1zQS8RC+fdupTIy/9yEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731429563; c=relaxed/simple;
	bh=s2ZmsOS+Psa5Ms6fZ8kT+7V910D1c4lzcdLwmawX09M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qlS7CY2SU/r2xmt4pRk4NuChG5oiyKfT1x8S/9k80vxUPFPvAiNwB+IEoAtEvsYDvQllg9C4B+inXA97M1VAC8ZYqxYhcNpKuMvByO3xzZ4F12Jn6aYS98lcJQDKnGT191JG4V8cA+vaJS2ReiC67Yju9lhkv0NzoIzoD1lWkAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 3E67FAFAF876; Tue, 12 Nov 2024 08:39:07 -0800 (PST)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH bpf-next v12 1/7] bpf: Find eligible subprogs for private stack support
Date: Tue, 12 Nov 2024 08:39:07 -0800
Message-ID: <20241112163907.2223839-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241112163902.2223011-1-yonghong.song@linux.dev>
References: <20241112163902.2223011-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Private stack will be allocated with percpu allocator in jit time.
To avoid complexity at runtime, only one copy of private stack is
available per cpu per prog. So runtime recursion check is necessary
to avoid stack corruption.

Current private stack only supports kprobe/perf_event/tp/raw_tp
which has recursion check in the kernel, and prog types that use
bpf trampoline recursion check. For trampoline related prog types,
currently only tracing progs have recursion checking.

To avoid complexity, all async_cb subprogs use normal kernel stack
including those subprogs used by both main prog subtree and async_cb
subtree. Any prog having tail call also uses kernel stack.

To avoid jit penalty with private stack support, a subprog stack
size threshold is set such that only if the stack size is no less
than the threshold, private stack is supported. The current threshold
is 64 bytes. This avoids jit penality if the stack usage is small.

A useless 'continue' is also removed from a loop in func
check_max_stack_depth().

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 include/linux/bpf_verifier.h |  7 +++
 include/linux/filter.h       |  1 +
 kernel/bpf/core.c            |  5 ++
 kernel/bpf/verifier.c        | 96 ++++++++++++++++++++++++++++++++----
 4 files changed, 99 insertions(+), 10 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 3a74033d49c4..d62bb2ca1828 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -633,6 +633,12 @@ struct bpf_subprog_arg_info {
 	};
 };
=20
+enum priv_stack_mode {
+	PRIV_STACK_UNKNOWN,
+	NO_PRIV_STACK,
+	PRIV_STACK_ADAPTIVE,
+};
+
 struct bpf_subprog_info {
 	/* 'start' has to be the first field otherwise find_subprog() won't wor=
k */
 	u32 start; /* insn idx of function entry point */
@@ -653,6 +659,7 @@ struct bpf_subprog_info {
 	/* true if bpf_fastcall stack region is used by functions that can't be=
 inlined */
 	bool keep_fastcall_stack: 1;
=20
+	enum priv_stack_mode priv_stack_mode;
 	u8 arg_cnt;
 	struct bpf_subprog_arg_info args[MAX_BPF_FUNC_REG_ARGS];
 };
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
index 233ea78f8f1b..14d9288441f2 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -3045,6 +3045,11 @@ bool __weak bpf_jit_supports_exceptions(void)
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
index 9f5de8d4fbd0..fb23793ac53d 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -194,6 +194,8 @@ struct bpf_verifier_stack_elem {
=20
 #define BPF_GLOBAL_PERCPU_MA_MAX_SIZE  512
=20
+#define BPF_PRIV_STACK_MIN_SIZE		64
+
 static int acquire_reference_state(struct bpf_verifier_env *env, int ins=
n_idx);
 static int release_reference(struct bpf_verifier_env *env, int ref_obj_i=
d);
 static void invalidate_non_owning_refs(struct bpf_verifier_env *env);
@@ -6090,6 +6092,34 @@ static int check_ptr_alignment(struct bpf_verifier=
_env *env,
 					   strict);
 }
=20
+static enum priv_stack_mode bpf_enable_priv_stack(struct bpf_prog *prog)
+{
+	if (!bpf_jit_supports_private_stack())
+		return NO_PRIV_STACK;
+
+	/* bpf_prog_check_recur() checks all prog types that use bpf trampoline
+	 * while kprobe/tp/perf_event/raw_tp don't use trampoline hence checked
+	 * explicitly.
+	 */
+	switch (prog->type) {
+	case BPF_PROG_TYPE_KPROBE:
+	case BPF_PROG_TYPE_TRACEPOINT:
+	case BPF_PROG_TYPE_PERF_EVENT:
+	case BPF_PROG_TYPE_RAW_TRACEPOINT:
+		return PRIV_STACK_ADAPTIVE;
+	case BPF_PROG_TYPE_TRACING:
+	case BPF_PROG_TYPE_LSM:
+	case BPF_PROG_TYPE_STRUCT_OPS:
+		if (bpf_prog_check_recur(prog))
+			return PRIV_STACK_ADAPTIVE;
+		fallthrough;
+	default:
+		break;
+	}
+
+	return NO_PRIV_STACK;
+}
+
 static int round_up_stack_depth(struct bpf_verifier_env *env, int stack_=
depth)
 {
 	if (env->prog->jit_requested)
@@ -6107,17 +6137,20 @@ static int round_up_stack_depth(struct bpf_verifi=
er_env *env, int stack_depth)
  * Since recursion is prevented by check_cfg() this algorithm
  * only needs a local stack of MAX_CALL_FRAMES to remember callsites
  */
-static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, i=
nt idx)
+static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, i=
nt idx,
+					 bool priv_stack_supported)
 {
 	struct bpf_subprog_info *subprog =3D env->subprog_info;
 	struct bpf_insn *insn =3D env->prog->insnsi;
-	int depth =3D 0, frame =3D 0, i, subprog_end;
+	int depth =3D 0, frame =3D 0, i, subprog_end, subprog_depth;
 	bool tail_call_reachable =3D false;
 	int ret_insn[MAX_CALL_FRAMES];
 	int ret_prog[MAX_CALL_FRAMES];
 	int j;
=20
 	i =3D subprog[idx].start;
+	if (!priv_stack_supported)
+		subprog[idx].priv_stack_mode =3D NO_PRIV_STACK;
 process_func:
 	/* protect against potential stack overflow that might happen when
 	 * bpf2bpf calls get combined with tailcalls. Limit the caller's stack
@@ -6144,11 +6177,31 @@ static int check_max_stack_depth_subprog(struct b=
pf_verifier_env *env, int idx)
 			depth);
 		return -EACCES;
 	}
-	depth +=3D round_up_stack_depth(env, subprog[idx].stack_depth);
-	if (depth > MAX_BPF_STACK) {
-		verbose(env, "combined stack size of %d calls is %d. Too large\n",
-			frame + 1, depth);
-		return -EACCES;
+
+	subprog_depth =3D round_up_stack_depth(env, subprog[idx].stack_depth);
+	if (priv_stack_supported) {
+		/* Request private stack support only if the subprog stack
+		 * depth is no less than BPF_PRIV_STACK_MIN_SIZE. This is to
+		 * avoid jit penalty if the stack usage is small.
+		 */
+		if (subprog[idx].priv_stack_mode =3D=3D PRIV_STACK_UNKNOWN &&
+		    subprog_depth >=3D BPF_PRIV_STACK_MIN_SIZE)
+			subprog[idx].priv_stack_mode =3D PRIV_STACK_ADAPTIVE;
+	}
+
+	if (subprog[idx].priv_stack_mode =3D=3D PRIV_STACK_ADAPTIVE) {
+		if (subprog_depth > MAX_BPF_STACK) {
+			verbose(env, "stack size of subprog %d is %d. Too large\n",
+				idx, subprog_depth);
+			return -EACCES;
+		}
+	} else {
+		depth +=3D subprog_depth;
+		if (depth > MAX_BPF_STACK) {
+			verbose(env, "combined stack size of %d calls is %d. Too large\n",
+				frame + 1, depth);
+			return -EACCES;
+		}
 	}
 continue_func:
 	subprog_end =3D subprog[idx + 1].start;
@@ -6205,6 +6258,8 @@ static int check_max_stack_depth_subprog(struct bpf=
_verifier_env *env, int idx)
 		}
 		i =3D next_insn;
 		idx =3D sidx;
+		if (!priv_stack_supported)
+			subprog[idx].priv_stack_mode =3D NO_PRIV_STACK;
=20
 		if (subprog[idx].has_tail_call)
 			tail_call_reachable =3D true;
@@ -6238,7 +6293,8 @@ static int check_max_stack_depth_subprog(struct bpf=
_verifier_env *env, int idx)
 	 */
 	if (frame =3D=3D 0)
 		return 0;
-	depth -=3D round_up_stack_depth(env, subprog[idx].stack_depth);
+	if (subprog[idx].priv_stack_mode !=3D PRIV_STACK_ADAPTIVE)
+		depth -=3D round_up_stack_depth(env, subprog[idx].stack_depth);
 	frame--;
 	i =3D ret_insn[frame];
 	idx =3D ret_prog[frame];
@@ -6247,16 +6303,36 @@ static int check_max_stack_depth_subprog(struct b=
pf_verifier_env *env, int idx)
=20
 static int check_max_stack_depth(struct bpf_verifier_env *env)
 {
+	enum priv_stack_mode priv_stack_mode =3D PRIV_STACK_UNKNOWN;
 	struct bpf_subprog_info *si =3D env->subprog_info;
+	bool priv_stack_supported;
 	int ret;
=20
 	for (int i =3D 0; i < env->subprog_cnt; i++) {
+		if (si[i].has_tail_call) {
+			priv_stack_mode =3D NO_PRIV_STACK;
+			break;
+		}
+	}
+
+	if (priv_stack_mode =3D=3D PRIV_STACK_UNKNOWN)
+		priv_stack_mode =3D bpf_enable_priv_stack(env->prog);
+
+	/* All async_cb subprogs use normal kernel stack. If a particular
+	 * subprog appears in both main prog and async_cb subtree, that
+	 * subprog will use normal kernel stack to avoid potential nesting.
+	 * The reverse subprog traversal ensures when main prog subtree is
+	 * checked, the subprogs appearing in async_cb subtrees are already
+	 * marked as using normal kernel stack, so stack size checking can
+	 * be done properly.
+	 */
+	for (int i =3D env->subprog_cnt - 1; i >=3D 0; i--) {
 		if (!i || si[i].is_async_cb) {
-			ret =3D check_max_stack_depth_subprog(env, i);
+			priv_stack_supported =3D !i && priv_stack_mode =3D=3D PRIV_STACK_ADAP=
TIVE;
+			ret =3D check_max_stack_depth_subprog(env, i, priv_stack_supported);
 			if (ret < 0)
 				return ret;
 		}
-		continue;
 	}
 	return 0;
 }
--=20
2.43.5


