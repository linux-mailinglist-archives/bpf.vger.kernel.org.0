Return-Path: <bpf+bounces-43696-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBF899B89B6
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2024 04:11:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D47A1F2377D
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2024 03:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75599144304;
	Fri,  1 Nov 2024 03:10:41 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 66-220-155-179.mail-mxout.facebook.com (66-220-155-179.mail-mxout.facebook.com [66.220.155.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDAED1459FD
	for <bpf@vger.kernel.org>; Fri,  1 Nov 2024 03:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730430641; cv=none; b=uFuWP4xqzx/u1dZ7Zh6hxm9oFzPo40ADMotA6zE7ZryMTMCYTTqLaGDSK+w6sOocAF3IAxg/MSp9uit3sz8rhJ1+Ci/LjYkKtUVKzkky9u9AiqV37+NXROUpxeVTsHV4Z3cGfTebCiBhNLLbpgfebjWI6DTaRJsfD9ljilpiErM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730430641; c=relaxed/simple;
	bh=X3bwmEP7lwafZw578BaTdV5O2ytuQcc+RskqOVi+A2c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qLMHef/YTiEVFs25p97/6Q7cQwt20NvlnmZcWBhkzSA3MCrlGk/izCN6hEqQhR823OR6Pt454JHbkBKm3XhfGMepGgZg/EXKwm2vA3U0nBaC68bdyubslQbX2t5EZU9m10jxBw/qTUWksbYIlfHke6kwm3HRYI57Aedhv1l1qWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 1474CAA2EE0B; Thu, 31 Oct 2024 20:10:32 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH bpf-next v8 8/9] bpf: Support private stack for struct_ops progs
Date: Thu, 31 Oct 2024 20:10:32 -0700
Message-ID: <20241101031032.2680930-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241101030950.2677215-1-yonghong.song@linux.dev>
References: <20241101030950.2677215-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

For struct_ops progs, whether a particular prog will use private stack
or not (prog->aux->use_priv_stack) will be set before actual insn-level
verification for that prog. One particular implementation is to
piggyback on struct_ops->check_member(). The next patch will have an
example for this. The struct_ops->check_member() will set
prog->aux->use_priv_stack to be true which enables private stack
usage with ignoring BPF_PRIV_STACK_MIN_SIZE limit.

If use_priv_stack is true for a particular struct_ops prog, bpf
trampoline will need to do recursion checks (one level at this point)
to avoid stack overwrite. A field (recursion_skipped()) is added to
bpf_prog_aux structure such that if bpf_prog->aux->recursion_skipped
is set by the struct_ops subsystem, the function will be called
to terminate the prog run, collect related info, etc.

Acked-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 include/linux/bpf.h          |  1 +
 include/linux/bpf_verifier.h |  1 +
 kernel/bpf/trampoline.c      |  4 ++++
 kernel/bpf/verifier.c        | 36 ++++++++++++++++++++++++++++++++----
 4 files changed, 38 insertions(+), 4 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 8a3ea7440a4a..7a34108c6974 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1528,6 +1528,7 @@ struct bpf_prog_aux {
 	u64 prog_array_member_cnt; /* counts how many times as member of prog_a=
rray */
 	struct mutex ext_mutex; /* mutex for is_extended and prog_array_member_=
cnt */
 	struct bpf_arena *arena;
+	void (*recursion_skipped)(struct bpf_prog *prog); /* callback if recurs=
ion is skipped */
 	/* BTF_KIND_FUNC_PROTO for valid attach_btf_id */
 	const struct btf_type *attach_func_proto;
 	/* function name for valid attach_btf_id */
diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index bc28ce7996ac..ff0fba935f89 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -889,6 +889,7 @@ static inline bool bpf_prog_check_recur(const struct =
bpf_prog *prog)
 	case BPF_PROG_TYPE_TRACING:
 		return prog->expected_attach_type !=3D BPF_TRACE_ITER;
 	case BPF_PROG_TYPE_STRUCT_OPS:
+		return prog->aux->use_priv_stack;
 	case BPF_PROG_TYPE_LSM:
 		return false;
 	default:
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index 9f36c049f4c2..a84e60efbf89 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -899,6 +899,8 @@ static u64 notrace __bpf_prog_enter_recur(struct bpf_=
prog *prog, struct bpf_tram
=20
 	if (unlikely(this_cpu_inc_return(*(prog->active)) !=3D 1)) {
 		bpf_prog_inc_misses_counter(prog);
+		if (prog->aux->recursion_skipped)
+			prog->aux->recursion_skipped(prog);
 		return 0;
 	}
 	return bpf_prog_start_time();
@@ -975,6 +977,8 @@ u64 notrace __bpf_prog_enter_sleepable_recur(struct b=
pf_prog *prog,
=20
 	if (unlikely(this_cpu_inc_return(*(prog->active)) !=3D 1)) {
 		bpf_prog_inc_misses_counter(prog);
+		if (prog->aux->recursion_skipped)
+			prog->aux->recursion_skipped(prog);
 		return 0;
 	}
 	return bpf_prog_start_time();
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 30e74db6a85f..865191c5d21b 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6023,17 +6023,31 @@ static int check_ptr_alignment(struct bpf_verifie=
r_env *env,
=20
 static int bpf_enable_priv_stack(struct bpf_verifier_env *env)
 {
+	bool force_priv_stack =3D env->prog->aux->use_priv_stack;
 	struct bpf_subprog_info *si;
+	int ret;
+
+	if (!bpf_jit_supports_private_stack()) {
+		if (force_priv_stack) {
+			verbose(env, "Private stack not supported by jit\n");
+			return -EACCES;
+		}
=20
-	if (!bpf_jit_supports_private_stack())
 		return NO_PRIV_STACK;
+	}
=20
+	ret =3D PRIV_STACK_ADAPTIVE;
 	switch (env->prog->type) {
 	case BPF_PROG_TYPE_KPROBE:
 	case BPF_PROG_TYPE_TRACEPOINT:
 	case BPF_PROG_TYPE_PERF_EVENT:
 	case BPF_PROG_TYPE_RAW_TRACEPOINT:
 		break;
+	case BPF_PROG_TYPE_STRUCT_OPS:
+		if (!force_priv_stack)
+			return NO_PRIV_STACK;
+		ret =3D PRIV_STACK_ALWAYS;
+		break;
 	case BPF_PROG_TYPE_TRACING:
 		if (env->prog->expected_attach_type !=3D BPF_TRACE_ITER)
 			break;
@@ -6044,11 +6058,18 @@ static int bpf_enable_priv_stack(struct bpf_verif=
ier_env *env)
=20
 	si =3D env->subprog_info;
 	for (int i =3D 0; i < env->subprog_cnt; i++) {
-		if (si[i].has_tail_call)
+		if (si[i].has_tail_call) {
+			if (ret =3D=3D PRIV_STACK_ALWAYS) {
+				verbose(env,
+					"Private stack not supported due to tail call presence\n");
+				return -EACCES;
+			}
+
 			return NO_PRIV_STACK;
+		}
 	}
=20
-	return PRIV_STACK_ADAPTIVE;
+	return ret;
 }
=20
 static int round_up_stack_depth(struct bpf_verifier_env *env, int stack_=
depth)
@@ -6121,7 +6142,8 @@ static int check_max_stack_depth_subprog(struct bpf=
_verifier_env *env, int idx,
 					idx, subprog_depth);
 				return -EACCES;
 			}
-			if (subprog_depth >=3D BPF_PRIV_STACK_MIN_SIZE) {
+			if (priv_stack_supported =3D=3D PRIV_STACK_ALWAYS ||
+			    subprog_depth >=3D BPF_PRIV_STACK_MIN_SIZE) {
 				subprog[idx].use_priv_stack =3D true;
 				subprog_visited[idx] =3D 1;
 			}
@@ -6271,6 +6293,12 @@ static int check_max_stack_depth(struct bpf_verifi=
er_env *env)
 				depth_frame, subtree_depth);
 			return -EACCES;
 		}
+		if (orig_priv_stack_supported =3D=3D PRIV_STACK_ALWAYS) {
+			verbose(env,
+				"Private stack not supported due to possible nested subprog run\n");
+			ret =3D -EACCES;
+			goto out;
+		}
 		if (orig_priv_stack_supported =3D=3D PRIV_STACK_ADAPTIVE) {
 			for (int i =3D 0; i < env->subprog_cnt; i++)
 				si[i].use_priv_stack =3D false;
--=20
2.43.5


