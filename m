Return-Path: <bpf+bounces-40369-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6BBD987BFC
	for <lists+bpf@lfdr.de>; Fri, 27 Sep 2024 01:45:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D78391C20A71
	for <lists+bpf@lfdr.de>; Thu, 26 Sep 2024 23:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 748B51B07A2;
	Thu, 26 Sep 2024 23:45:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 69-171-232-181.mail-mxout.facebook.com (69-171-232-181.mail-mxout.facebook.com [69.171.232.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72812171675
	for <bpf@vger.kernel.org>; Thu, 26 Sep 2024 23:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727394322; cv=none; b=GUfBKZLoiVXpcmyORmdwJG5+WeWG4xqpR5fzbL3D8CFaa0VuGCNQagdhqKQzwvnKtCFU7XG7zbeIDgrJYNF/hLvIK/qz0gKvuYh8CFKW44s18uHgFayX/PLkqiRRMtrg3Lt5s2K0sK7QG/aAQf9U/AhIsqbJr0dfb1BgwflGwEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727394322; c=relaxed/simple;
	bh=B4OA7Tt6sUJGmx3vHA67FELppapwDvFmsbojVWyCS28=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tTScAxNjKX+1Jh1n9JKw5h/2oXk+/bNxMySUNJJCNkBDklAwTeWIDICkn4ULoqzFKC9Et3TNu2ozvV5TaN5elF6E7J0T4BqWesMdPRmY7g2pJeYb/2JIr2Bfjz6Nb7mLkHbkxnRC02TlVXfQGokORIqECvMJH/vytZteGkWZYfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 25F49967C738; Thu, 26 Sep 2024 16:45:11 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v3 1/5] bpf: Allow each subprog having stack size of 512 bytes
Date: Thu, 26 Sep 2024 16:45:11 -0700
Message-ID: <20240926234511.1769453-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240926234506.1769256-1-yonghong.song@linux.dev>
References: <20240926234506.1769256-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

With private stack support, each subprog can have stack with up to 512
bytes. The limit of 512 bytes per subprog is kept to avoid increase
verifier complexity as greater than 512 bytes will cause big verifier
change and increase memory consumption and verification time.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 include/linux/bpf.h    |  1 +
 include/linux/filter.h |  1 +
 kernel/bpf/core.c      |  5 +++++
 kernel/bpf/verifier.c  | 49 +++++++++++++++++++++++++++++++++++++-----
 4 files changed, 51 insertions(+), 5 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 19d8ca8ac960..62909fbe9e48 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1483,6 +1483,7 @@ struct bpf_prog_aux {
 	bool xdp_has_frags;
 	bool exception_cb;
 	bool exception_boundary;
+	bool pstack_enabled;
 	struct bpf_arena *arena;
 	/* BTF_KIND_FUNC_PROTO for valid attach_btf_id */
 	const struct btf_type *attach_func_proto;
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
index 4e07cc057d6f..0727fff6de0e 100644
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
index 9a7ed527e47e..97700e32e085 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5999,7 +5999,8 @@ static int round_up_stack_depth(struct bpf_verifier=
_env *env, int stack_depth)
  * Since recursion is prevented by check_cfg() this algorithm
  * only needs a local stack of MAX_CALL_FRAMES to remember callsites
  */
-static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, i=
nt idx)
+static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, i=
nt idx,
+					 bool pstack_enabled)
 {
 	struct bpf_subprog_info *subprog =3D env->subprog_info;
 	struct bpf_insn *insn =3D env->prog->insnsi;
@@ -6007,8 +6008,9 @@ static int check_max_stack_depth_subprog(struct bpf=
_verifier_env *env, int idx)
 	bool tail_call_reachable =3D false;
 	int ret_insn[MAX_CALL_FRAMES];
 	int ret_prog[MAX_CALL_FRAMES];
-	int j;
+	int j, subprog_stack_depth, stack_limit;
=20
+	stack_limit =3D pstack_enabled ? U16_MAX : MAX_BPF_STACK;
 	i =3D subprog[idx].start;
 process_func:
 	/* protect against potential stack overflow that might happen when
@@ -6036,12 +6038,18 @@ static int check_max_stack_depth_subprog(struct b=
pf_verifier_env *env, int idx)
 			depth);
 		return -EACCES;
 	}
-	depth +=3D round_up_stack_depth(env, subprog[idx].stack_depth);
-	if (depth > MAX_BPF_STACK) {
+	subprog_stack_depth =3D round_up_stack_depth(env, subprog[idx].stack_de=
pth);
+	depth +=3D subprog_stack_depth;
+	if (depth > stack_limit) {
 		verbose(env, "combined stack size of %d calls is %d. Too large\n",
 			frame + 1, depth);
 		return -EACCES;
 	}
+	if (pstack_enabled && subprog_stack_depth > MAX_BPF_STACK) {
+		verbose(env, "stack size of subprog %d is %d. Too large\n",
+			idx, subprog_stack_depth);
+		return -EACCES;
+	}
 continue_func:
 	subprog_end =3D subprog[idx + 1].start;
 	for (; i < subprog_end; i++) {
@@ -6137,14 +6145,45 @@ static int check_max_stack_depth_subprog(struct b=
pf_verifier_env *env, int idx)
 	goto continue_func;
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
 static int check_max_stack_depth(struct bpf_verifier_env *env)
 {
+	bool has_tail_call =3D false, pstack_enabled =3D false;
 	struct bpf_subprog_info *si =3D env->subprog_info;
 	int ret;
=20
+	for (int i =3D 0; i < env->subprog_cnt; i++) {
+		if (si[i].has_tail_call) {
+			has_tail_call =3D true;
+			break;
+		}
+	}
+
+	if (!has_tail_call && bpf_enable_private_stack(env->prog))
+		env->prog->aux->pstack_enabled =3D pstack_enabled =3D true;
+
 	for (int i =3D 0; i < env->subprog_cnt; i++) {
 		if (!i || si[i].is_async_cb) {
-			ret =3D check_max_stack_depth_subprog(env, i);
+			ret =3D check_max_stack_depth_subprog(env, i, pstack_enabled);
 			if (ret < 0)
 				return ret;
 		}
--=20
2.43.5


