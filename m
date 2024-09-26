Return-Path: <bpf+bounces-40372-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6C2F987BFF
	for <lists+bpf@lfdr.de>; Fri, 27 Sep 2024 01:45:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9946928265A
	for <lists+bpf@lfdr.de>; Thu, 26 Sep 2024 23:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A08581B0135;
	Thu, 26 Sep 2024 23:45:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 66-220-155-178.mail-mxout.facebook.com (66-220-155-178.mail-mxout.facebook.com [66.220.155.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B11188CB7
	for <bpf@vger.kernel.org>; Thu, 26 Sep 2024 23:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727394330; cv=none; b=SBpr7GQO7IaTade/n7Ulx4zWzNk9eAT0DeKfT0r1/q1MxX8gjJn5ZbCn80B3GTzURMEKgRAehb6xC8pAvkyD+TzKoUFnx1MXZWpGvuoZKndfvWy7mlfqhwNK7DzFaweV3c/hlDtY96McXOWZUGMgdlLwH8qEBNimIyDTVa+o7ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727394330; c=relaxed/simple;
	bh=+AgiCmwseQJNQiVXVJD/fpibq+iyNAvfGv9ebRpy/Fk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ik4le82lFhivBRyrNFmsdXAfI3wfJnnNkH1vavZ3x5GjEK222tRdFu2p6KGiQJFIVkyy1aaeQVR4KDIxIIKTWS5FxITEiLCIYj+8MJ2BATkV3Gi8+Nl5GB/keDUKh48x3aenHuaRTqoFDuhC7Wp9RT5AYzUok18pji8cPfN4l08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 40BE1967C768; Thu, 26 Sep 2024 16:45:16 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v3 2/5] bpf: Collect stack depth information
Date: Thu, 26 Sep 2024 16:45:16 -0700
Message-ID: <20240926234516.1770154-1-yonghong.song@linux.dev>
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

Private stack memory allocation is based on call subtrees. For example,

  main_prog     // stack size 50
    subprog1    // stack size 50
      subprog2  // stack size 50
    subprog3    // stack size 50

Overall allocation size should be 150 bytes (stacks from main_prog,
subprog1 and subprog2).

To simplify jit, the root of subtrees is either the main prog
or any callback func. For example,

  main_prog
    subprog1    // callback subprog10
      ...
        subprog10
          subprog11

In this case, two subtrees exist. One root is main_prog and the other
root is subprog10.

The private stack is used only if
 - the subtree stack size is greater than 128 bytes and
   smaller than or equal to U16_MAX, and
 - the prog type is kprobe, tracepoint, perf_event, raw_tracepoint
   and tracing, and
 - jit supports private stack, and
 - no tail call in the main prog and all subprogs

The restriction of no tail call is due to the following two reasons:
 - to avoid potential large memory consumption. Currently maximum tail
   call count is MAX_TAIL_CALL_CNT=3D33. Considering private stack memory
   allocation is per-cpu based. It will be a very large memory consumptio=
n
   to support current MAX_TAIL_CALL_CNT.
 - if the tailcall in the callback function, it is not easy to pass
   the tail call cnt to the callback function and the tail call cnt
   is needed to find proper offset for private stack.
So to avoid complexity, private stack does not support tail call
for now.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 include/linux/bpf.h          |  3 +-
 include/linux/bpf_verifier.h |  3 ++
 kernel/bpf/verifier.c        | 81 ++++++++++++++++++++++++++++++++++++
 3 files changed, 86 insertions(+), 1 deletion(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 62909fbe9e48..156b9516d9f6 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1566,7 +1566,8 @@ struct bpf_prog {
 				call_get_stack:1, /* Do we call bpf_get_stack() or bpf_get_stackid()=
 */
 				call_get_func_ip:1, /* Do we call get_func_ip() */
 				tstamp_type_access:1, /* Accessed __sk_buff->tstamp_type */
-				sleepable:1;	/* BPF program is sleepable */
+				sleepable:1,	/* BPF program is sleepable */
+				pstack_eligible:1; /* Candidate for private stacks */
 	enum bpf_prog_type	type;		/* Type of BPF program */
 	enum bpf_attach_type	expected_attach_type; /* For some prog types */
 	u32			len;		/* Number of filter blocks */
diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 4513372c5bc8..63df10f4129e 100644
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
+	bool pstack_eligible:1;
=20
 	u8 arg_cnt;
 	struct bpf_subprog_arg_info args[MAX_BPF_FUNC_REG_ARGS];
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 97700e32e085..69e17cb22037 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -194,6 +194,8 @@ struct bpf_verifier_stack_elem {
=20
 #define BPF_GLOBAL_PERCPU_MA_MAX_SIZE  512
=20
+#define BPF_PSTACK_MIN_SUBTREE_SIZE	128
+
 static int acquire_reference_state(struct bpf_verifier_env *env, int ins=
n_idx);
 static int release_reference(struct bpf_verifier_env *env, int ref_obj_i=
d);
 static void invalidate_non_owning_refs(struct bpf_verifier_env *env);
@@ -6192,6 +6194,82 @@ static int check_max_stack_depth(struct bpf_verifi=
er_env *env)
 	return 0;
 }
=20
+static int calc_private_stack_alloc_subprog(struct bpf_verifier_env *env=
, int idx)
+{
+	struct bpf_subprog_info *subprog =3D env->subprog_info;
+	struct bpf_insn *insn =3D env->prog->insnsi;
+	int depth =3D 0, frame =3D 0, i, subprog_end;
+	int ret_insn[MAX_CALL_FRAMES];
+	int ret_prog[MAX_CALL_FRAMES];
+	int ps_eligible =3D 0;
+	int orig_idx =3D idx;
+
+	subprog[idx].subtree_top_idx =3D idx;
+	i =3D subprog[idx].start;
+
+process_func:
+	depth +=3D round_up_stack_depth(env, subprog[idx].stack_depth);
+	if (depth > U16_MAX)
+		return -EACCES;
+
+	if (!ps_eligible && depth >=3D BPF_PSTACK_MIN_SUBTREE_SIZE) {
+		subprog[orig_idx].pstack_eligible =3D true;
+		ps_eligible =3D true;
+	}
+	subprog[orig_idx].subtree_stack_depth =3D
+		max_t(u16, subprog[orig_idx].subtree_stack_depth, depth);
+
+continue_func:
+	subprog_end =3D subprog[idx + 1].start;
+	for (; i < subprog_end; i++) {
+		int next_insn, sidx;
+
+		if (!bpf_pseudo_call(insn + i) && !bpf_pseudo_func(insn + i))
+			continue;
+		/* remember insn and function to return to */
+		ret_insn[frame] =3D i + 1;
+		ret_prog[frame] =3D idx;
+
+		/* find the callee */
+		next_insn =3D i + insn[i].imm + 1;
+		sidx =3D find_subprog(env, next_insn);
+		if (subprog[sidx].is_cb) {
+			if (!bpf_pseudo_call(insn + i))
+				continue;
+		}
+		i =3D next_insn;
+		idx =3D sidx;
+		subprog[idx].subtree_top_idx =3D orig_idx;
+
+		frame++;
+		goto process_func;
+	}
+	if (frame =3D=3D 0)
+		return ps_eligible;
+	depth -=3D round_up_stack_depth(env, subprog[idx].stack_depth);
+	frame--;
+	i =3D ret_insn[frame];
+	idx =3D ret_prog[frame];
+	goto continue_func;
+}
+
+static int calc_private_stack_alloc_size(struct bpf_verifier_env *env)
+{
+	struct bpf_subprog_info *si =3D env->subprog_info;
+	int ret;
+
+	for (int i =3D 0; i < env->subprog_cnt; i++) {
+		if (!i || si[i].is_cb) {
+			ret =3D calc_private_stack_alloc_subprog(env, i);
+			if (ret < 0)
+				return ret;
+			if (ret)
+				env->prog->pstack_eligible =3D true;
+		}
+	}
+	return 0;
+}
+
 #ifndef CONFIG_BPF_JIT_ALWAYS_ON
 static int get_callee_stack_depth(struct bpf_verifier_env *env,
 				  const struct bpf_insn *insn, int idx)
@@ -22502,6 +22580,9 @@ int bpf_check(struct bpf_prog **prog, union bpf_a=
ttr *attr, bpfptr_t uattr, __u3
 								     : false;
 	}
=20
+	if (ret =3D=3D 0 && env->prog->aux->pstack_enabled)
+		ret =3D calc_private_stack_alloc_size(env);
+
 	if (ret =3D=3D 0)
 		ret =3D fixup_call_args(env);
=20
--=20
2.43.5


