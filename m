Return-Path: <bpf+bounces-40371-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 83747987BFE
	for <lists+bpf@lfdr.de>; Fri, 27 Sep 2024 01:45:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3880D1F233A9
	for <lists+bpf@lfdr.de>; Thu, 26 Sep 2024 23:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9678C1B07C6;
	Thu, 26 Sep 2024 23:45:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 69-171-232-181.mail-mxout.facebook.com (69-171-232-181.mail-mxout.facebook.com [69.171.232.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6BA1B0135
	for <bpf@vger.kernel.org>; Thu, 26 Sep 2024 23:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727394324; cv=none; b=S1hIUKkSojEo1rtM5qT7/zGHT/gUXJFLPWRlGBo2FiwIua3wG1KfF8/HFK8JhMgVHc6xy9yWFMEK/cS3Qep7V8Cegxy3jprvcMFUlgAY1LfWNzYic51/T+Ri3+s1oEyDjd9WiOvUv1lviM9eeFQJKEQNcv+lGxGNd4k9szV2WMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727394324; c=relaxed/simple;
	bh=Q2O3OnZiDsXUABk0J6cYFqz3n613nwFrevN9DE0Zin8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AlBy2GEeoHJ8Iy8pzX9z2x0DXBkX3Tw2noHhfaJK1pMZLxQ7xmxQEtEQ1twSfNK2pe4cwJjq54Kcu4LK3nOufd6gLhiwZ/B+GqHerKsBTud8N9UIKygZkYKk8CWaXnFzpr2EglGYwmCWIv6R3TutgxgWoVSpfpHkG3fgEQfP1wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 5BF40967C786; Thu, 26 Sep 2024 16:45:21 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v3 3/5] bpf: Mark each subprog with proper pstack states
Date: Thu, 26 Sep 2024 16:45:21 -0700
Message-ID: <20240926234521.1770481-1-yonghong.song@linux.dev>
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

Three private stack states are used to direct jit action:
  PSTACK_TREE_NO:       do not use private stack
  PSTACK_TREE_INTERNAL: adjust frame pointer address (similar to normal s=
tack)
  PSTACK_TREE_ROOT:     set the frame pointer

Note that for subtree root, even if the root bpf_prog stack size is 0,
PSTACK_TREE_INTERNAL is still used. This is for bpf exception handling.
More details can be found in subsequent jit support and selftest patches.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 include/linux/bpf.h   |  9 +++++++++
 kernel/bpf/core.c     | 19 +++++++++++++++++++
 kernel/bpf/verifier.c | 30 ++++++++++++++++++++++++++++++
 3 files changed, 58 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 156b9516d9f6..8f02d11bd408 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1550,6 +1550,12 @@ struct bpf_prog_aux {
 	};
 };
=20
+enum bpf_pstack_state {
+	PSTACK_TREE_NO,
+	PSTACK_TREE_INTERNAL,
+	PSTACK_TREE_ROOT,
+};
+
 struct bpf_prog {
 	u16			pages;		/* Number of allocated pages */
 	u16			jited:1,	/* Is our filter JIT'ed? */
@@ -1570,15 +1576,18 @@ struct bpf_prog {
 				pstack_eligible:1; /* Candidate for private stacks */
 	enum bpf_prog_type	type;		/* Type of BPF program */
 	enum bpf_attach_type	expected_attach_type; /* For some prog types */
+	enum bpf_pstack_state	pstack:2;	/* Private stack state */
 	u32			len;		/* Number of filter blocks */
 	u32			jited_len;	/* Size of jited insns in bytes */
 	u8			tag[BPF_TAG_SIZE];
+	u16			subtree_stack_depth; /* Subtree stack depth if PSTACK_TREE_ROOT p=
rog, 0 otherwise */
 	struct bpf_prog_stats __percpu *stats;
 	int __percpu		*active;
 	unsigned int		(*bpf_func)(const void *ctx,
 					    const struct bpf_insn *insn);
 	struct bpf_prog_aux	*aux;		/* Auxiliary fields */
 	struct sock_fprog_kern	*orig_prog;	/* Original BPF program */
+	void __percpu		*private_stack_ptr;
 	/* Instructions for interpreter */
 	union {
 		DECLARE_FLEX_ARRAY(struct sock_filter, insns);
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 0727fff6de0e..d6eb052f6631 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -1239,6 +1239,7 @@ void __weak bpf_jit_free(struct bpf_prog *fp)
 		struct bpf_binary_header *hdr =3D bpf_jit_binary_hdr(fp);
=20
 		bpf_jit_binary_free(hdr);
+		free_percpu(fp->private_stack_ptr);
 		WARN_ON_ONCE(!bpf_prog_kallsyms_verify_off(fp));
 	}
=20
@@ -2420,6 +2421,24 @@ struct bpf_prog *bpf_prog_select_runtime(struct bp=
f_prog *fp, int *err)
 		if (*err)
 			return fp;
=20
+		if (fp->pstack_eligible) {
+			if (!fp->aux->stack_depth) {
+				fp->pstack =3D PSTACK_TREE_NO;
+			} else {
+				void __percpu *private_stack_ptr;
+
+				fp->pstack =3D PSTACK_TREE_ROOT;
+				private_stack_ptr =3D
+					__alloc_percpu_gfp(fp->aux->stack_depth, 8, GFP_KERNEL);
+				if (!private_stack_ptr) {
+					*err =3D -ENOMEM;
+					return fp;
+				}
+				fp->subtree_stack_depth =3D fp->aux->stack_depth;
+				fp->private_stack_ptr =3D private_stack_ptr;
+			}
+		}
+
 		fp =3D bpf_int_jit_compile(fp);
 		bpf_prog_jit_attempt_done(fp);
 		if (!fp->jited && jit_needed) {
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 69e17cb22037..9d093e2013ca 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -20060,6 +20060,7 @@ static int jit_subprogs(struct bpf_verifier_env *=
env)
 {
 	struct bpf_prog *prog =3D env->prog, **func, *tmp;
 	int i, j, subprog_start, subprog_end =3D 0, len, subprog;
+	int subtree_top_idx, subtree_stack_depth;
 	struct bpf_map *map_ptr;
 	struct bpf_insn *insn;
 	void *old_bpf_func;
@@ -20138,6 +20139,35 @@ static int jit_subprogs(struct bpf_verifier_env =
*env)
 		func[i]->is_func =3D 1;
 		func[i]->sleepable =3D prog->sleepable;
 		func[i]->aux->func_idx =3D i;
+
+		subtree_top_idx =3D env->subprog_info[i].subtree_top_idx;
+		if (env->subprog_info[subtree_top_idx].pstack_eligible) {
+			if (subtree_top_idx =3D=3D i)
+				func[i]->subtree_stack_depth =3D
+					env->subprog_info[i].subtree_stack_depth;
+
+			subtree_stack_depth =3D func[i]->subtree_stack_depth;
+			if (subtree_top_idx !=3D i) {
+				if (env->subprog_info[subtree_top_idx].subtree_stack_depth)
+					func[i]->pstack =3D PSTACK_TREE_INTERNAL;
+				else
+					func[i]->pstack =3D PSTACK_TREE_NO;
+			} else if (!subtree_stack_depth) {
+				func[i]->pstack =3D PSTACK_TREE_INTERNAL;
+			} else {
+				void __percpu *private_stack_ptr;
+
+				func[i]->pstack =3D PSTACK_TREE_ROOT;
+				private_stack_ptr =3D
+					__alloc_percpu_gfp(subtree_stack_depth, 8, GFP_KERNEL);
+				if (!private_stack_ptr) {
+					err =3D -ENOMEM;
+					goto out_free;
+				}
+				func[i]->private_stack_ptr =3D private_stack_ptr;
+			}
+		}
+
 		/* Below members will be freed only at prog->aux */
 		func[i]->aux->btf =3D prog->aux->btf;
 		func[i]->aux->func_info =3D prog->aux->func_info;
--=20
2.43.5


