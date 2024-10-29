Return-Path: <bpf+bounces-43429-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CCFD9B55A4
	for <lists+bpf@lfdr.de>; Tue, 29 Oct 2024 23:17:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ADDDCB22AFE
	for <lists+bpf@lfdr.de>; Tue, 29 Oct 2024 22:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9E0620A5FF;
	Tue, 29 Oct 2024 22:17:04 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 69-171-232-180.mail-mxout.facebook.com (69-171-232-180.mail-mxout.facebook.com [69.171.232.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0BED20493A
	for <bpf@vger.kernel.org>; Tue, 29 Oct 2024 22:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730240224; cv=none; b=aC8AwvRZAQ+SdvhUuGtPArI0BhU59kuc6mhjv0S+ktfYuCKgnmzKLIJ3E/QhpTk4kch333zRlZqtlHpnLBYH1nrqkGbiGKAoUKA6E8urklm7ghumK6V1Nb6DuglsHUjY+LQjThglFCn5H6Y1/Fm4PywPReuVymbQ+E6y2lnKzPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730240224; c=relaxed/simple;
	bh=TVeqNzc974z+rs88oDwS2rFyVBccRR4+7JeVxdyeQC4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oKKwTmuY+QH+lNhsUHj6Yd2/sFrSaahlQPEfX0QEYivLyytX8Z0GqYxzzSyD4MrBM2mWgQFlsnvdSIlkbs80vZzN0gIdBb66kyhuoX2d3yQwPL9mjLi6NxoR0QKDbyak3Rj7bAjmzvQsooSvCqYfQu9x+mGET68znUQjfA4VLa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 77219A91CF42; Tue, 29 Oct 2024 15:16:47 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH bpf-next v7 2/9] bpf: Allow private stack to have each subprog having stack size of 512 bytes
Date: Tue, 29 Oct 2024 15:16:47 -0700
Message-ID: <20241029221647.264984-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241029221637.264348-1-yonghong.song@linux.dev>
References: <20241029221637.264348-1-yonghong.song@linux.dev>
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

If private stack is supported and certain stack size threshold is reached=
,
that subprog will have its own private stack allocated.

In this patch, some tracing programs are allowed to use private
stack since tracing prog may be triggered in the middle of some other
prog runs. The supported tracing programs already have recursion check
such that if the same prog is running on the same cpu again, the nested
prog run will be skipped. This ensures bpf prog private stack is not
over-written.

Note that if any tail_call is called in the prog (including all subprogs)=
,
then private stack is not used.

Function bpf_enable_priv_stack() return values include NO_PRIV_STACK,
PRIV_STACK_ADAPTIVE, PRIV_STACK_ALWAYS and negative errors. The
NO_PRIV_STACK represents priv stack not enable, PRIV_STACK_ADAPTIVE for
priv stack enabled with some conditions (e.g. stack size threshold), and
PRIV_STACK_ALWAYS for priv stack always enabled. The negative error
represents a verification failure. The PRIV_STACK_ALWAYS and negative err=
or
will be used by later struct_ops progs.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 include/linux/bpf.h          |  1 +
 include/linux/bpf_verifier.h |  1 +
 include/linux/filter.h       |  1 +
 kernel/bpf/core.c            |  5 +++
 kernel/bpf/verifier.c        | 75 ++++++++++++++++++++++++++++++++----
 5 files changed, 75 insertions(+), 8 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index c3ba4d475174..8db3c5d7404b 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1523,6 +1523,7 @@ struct bpf_prog_aux {
 	bool exception_cb;
 	bool exception_boundary;
 	bool is_extended; /* true if extended by freplace program */
+	bool use_priv_stack;
 	u64 prog_array_member_cnt; /* counts how many times as member of prog_a=
rray */
 	struct mutex ext_mutex; /* mutex for is_extended and prog_array_member_=
cnt */
 	struct bpf_arena *arena;
diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 4513372c5bc8..bc28ce7996ac 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -668,6 +668,7 @@ struct bpf_subprog_info {
 	bool args_cached: 1;
 	/* true if bpf_fastcall stack region is used by functions that can't be=
 inlined */
 	bool keep_fastcall_stack: 1;
+	bool use_priv_stack: 1;
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
index 89b0a980d0f9..d3f4cbab97bc 100644
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
@@ -6015,6 +6017,40 @@ static int check_ptr_alignment(struct bpf_verifier=
_env *env,
 					   strict);
 }
=20
+#define NO_PRIV_STACK		0
+#define PRIV_STACK_ADAPTIVE	1
+#define PRIV_STACK_ALWAYS	2
+
+static int bpf_enable_priv_stack(struct bpf_verifier_env *env)
+{
+	struct bpf_subprog_info *si;
+
+	if (!bpf_jit_supports_private_stack())
+		return NO_PRIV_STACK;
+
+	switch (env->prog->type) {
+	case BPF_PROG_TYPE_KPROBE:
+	case BPF_PROG_TYPE_TRACEPOINT:
+	case BPF_PROG_TYPE_PERF_EVENT:
+	case BPF_PROG_TYPE_RAW_TRACEPOINT:
+		break;
+	case BPF_PROG_TYPE_TRACING:
+		if (env->prog->expected_attach_type !=3D BPF_TRACE_ITER)
+			break;
+		fallthrough;
+	default:
+		return NO_PRIV_STACK;
+	}
+
+	si =3D env->subprog_info;
+	for (int i =3D 0; i < env->subprog_cnt; i++) {
+		if (si[i].has_tail_call)
+			return NO_PRIV_STACK;
+	}
+
+	return PRIV_STACK_ADAPTIVE;
+}
+
 static int round_up_stack_depth(struct bpf_verifier_env *env, int stack_=
depth)
 {
 	if (env->prog->jit_requested)
@@ -6033,11 +6069,12 @@ static int round_up_stack_depth(struct bpf_verifi=
er_env *env, int stack_depth)
  * only needs a local stack of MAX_CALL_FRAMES to remember callsites
  */
 static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, i=
nt idx,
-					 int *subtree_depth, int *depth_frame)
+					 int *subtree_depth, int *depth_frame,
+					 int priv_stack_supported)
 {
 	struct bpf_subprog_info *subprog =3D env->subprog_info;
 	struct bpf_insn *insn =3D env->prog->insnsi;
-	int depth =3D 0, frame =3D 0, i, subprog_end;
+	int depth =3D 0, frame =3D 0, i, subprog_end, subprog_depth;
 	bool tail_call_reachable =3D false;
 	int ret_insn[MAX_CALL_FRAMES];
 	int ret_prog[MAX_CALL_FRAMES];
@@ -6070,11 +6107,23 @@ static int check_max_stack_depth_subprog(struct b=
pf_verifier_env *env, int idx,
 			depth);
 		return -EACCES;
 	}
-	depth +=3D round_up_stack_depth(env, subprog[idx].stack_depth);
+	subprog_depth =3D round_up_stack_depth(env, subprog[idx].stack_depth);
+	depth +=3D subprog_depth;
 	if (depth > MAX_BPF_STACK && !*subtree_depth) {
 		*subtree_depth =3D depth;
 		*depth_frame =3D frame + 1;
 	}
+	if (priv_stack_supported !=3D NO_PRIV_STACK) {
+		if (!subprog[idx].use_priv_stack) {
+			if (subprog_depth > MAX_BPF_STACK) {
+				verbose(env, "stack size of subprog %d is %d. Too large\n",
+					idx, subprog_depth);
+				return -EACCES;
+			}
+			if (subprog_depth >=3D BPF_PRIV_STACK_MIN_SIZE)
+				subprog[idx].use_priv_stack =3D true;
+		}
+	}
 continue_func:
 	subprog_end =3D subprog[idx + 1].start;
 	for (; i < subprog_end; i++) {
@@ -6174,19 +6223,29 @@ static int check_max_stack_depth(struct bpf_verif=
ier_env *env)
 {
 	struct bpf_subprog_info *si =3D env->subprog_info;
 	int ret, subtree_depth =3D 0, depth_frame;
+	int priv_stack_supported;
+
+	priv_stack_supported =3D bpf_enable_priv_stack(env);
+	if (priv_stack_supported < 0)
+		return priv_stack_supported;
=20
 	for (int i =3D 0; i < env->subprog_cnt; i++) {
 		if (!i || si[i].is_async_cb) {
-			ret =3D check_max_stack_depth_subprog(env, i, &subtree_depth, &depth_=
frame);
+			ret =3D check_max_stack_depth_subprog(env, i, &subtree_depth, &depth_=
frame,
+							    priv_stack_supported);
 			if (ret < 0)
 				return ret;
 		}
 	}
-	if (subtree_depth > MAX_BPF_STACK) {
-		verbose(env, "combined stack size of %d calls is %d. Too large\n",
-			depth_frame, subtree_depth);
-		return -EACCES;
+	if (priv_stack_supported =3D=3D NO_PRIV_STACK) {
+		if (subtree_depth > MAX_BPF_STACK) {
+			verbose(env, "combined stack size of %d calls is %d. Too large\n",
+				depth_frame, subtree_depth);
+			return -EACCES;
+		}
 	}
+	if (si[0].use_priv_stack)
+		env->prog->aux->use_priv_stack =3D true;
 	return 0;
 }
=20
--=20
2.43.5


