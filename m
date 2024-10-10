Return-Path: <bpf+bounces-41598-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BDE8998EFC
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 19:56:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8BDC1F25C1C
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 17:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 222E61A303E;
	Thu, 10 Oct 2024 17:56:19 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 69-171-232-181.mail-mxout.facebook.com (69-171-232-181.mail-mxout.facebook.com [69.171.232.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 056AC1CCB45
	for <bpf@vger.kernel.org>; Thu, 10 Oct 2024 17:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728582978; cv=none; b=MipmEXe6cBrgy9EFMmhDliLctKV7hLq+QsAgyp5LmiWoXsUYb4EoXM8iG1FTGxzaT+4Qu4EuTtcogMaYc6ybqB4AiUf2ferg77/x6zcaB7Ym7S3dyt3OkrZ8BWPi0bs1TNicOYsDFgtJ31gIvTFOuiyALKtUmqRU3w+foiEebnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728582978; c=relaxed/simple;
	bh=TieqV78bxwE/irMwTJf6s5guZLtsULA1hHQkc3B5wwQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zh4PGiERhtNgOg1VRn4k2q+O/YiMIKN92k0CZjOFM8Jj7MKxFQTWJ6Ks1Lj4kHEDOuzVKz1PEs8hH5K7/ZE9ItogP/32AGh+PW7D6k1rr0+HNRc/kz0I+CVjMs+4g1lYcmww13KyudCYmFvS/qa+M5s3iYM20wO6J8WPOypFYo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id CA2FC9F27B63; Thu, 10 Oct 2024 10:56:02 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH bpf-next v4 02/10] bpf: Mark each subprog with proper private stack modes
Date: Thu, 10 Oct 2024 10:56:02 -0700
Message-ID: <20241010175602.1896674-1-yonghong.song@linux.dev>
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

Three private stack modes are used to direct jit action:
  NO_PRIV_STACK:        do not use private stack
  PRIV_STACK_SUB_PROG:  adjust frame pointer address (similar to normal s=
tack)
  PRIV_STACK_ROOT_PROG: set the frame pointer

Note that for subtree root prog (main prog or callback fn), even if the
bpf_prog stack size is 0, PRIV_STACK_ROOT_PROG mode is still used.
This is for bpf exception handling. More details can be found in
subsequent jit support and selftest patches.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 include/linux/bpf.h   |  9 +++++++++
 kernel/bpf/core.c     | 19 +++++++++++++++++++
 kernel/bpf/verifier.c | 29 +++++++++++++++++++++++++++++
 3 files changed, 57 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 9ef9133e0470..f22ddb423fd0 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1450,6 +1450,12 @@ struct btf_mod_pair {
=20
 struct bpf_kfunc_desc_tab;
=20
+enum bpf_priv_stack_mode {
+	NO_PRIV_STACK,
+	PRIV_STACK_SUB_PROG,
+	PRIV_STACK_ROOT_PROG,
+};
+
 struct bpf_prog_aux {
 	atomic64_t refcnt;
 	u32 used_map_cnt;
@@ -1466,6 +1472,9 @@ struct bpf_prog_aux {
 	u32 ctx_arg_info_size;
 	u32 max_rdonly_access;
 	u32 max_rdwr_access;
+	enum bpf_priv_stack_mode priv_stack_mode;
+	u16 subtree_stack_depth; /* Subtree stack depth if PRIV_STACK_ROOT_PROG=
, 0 otherwise */
+	void __percpu *priv_stack_ptr;
 	struct btf *attach_btf;
 	const struct bpf_ctx_arg_aux *ctx_arg_info;
 	struct mutex dst_mutex; /* protects dst_* pointers below, *after* prog =
becomes visible */
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index ba088b58746f..f79d951a061f 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -1239,6 +1239,7 @@ void __weak bpf_jit_free(struct bpf_prog *fp)
 		struct bpf_binary_header *hdr =3D bpf_jit_binary_hdr(fp);
=20
 		bpf_jit_binary_free(hdr);
+		free_percpu(fp->aux->priv_stack_ptr);
 		WARN_ON_ONCE(!bpf_prog_kallsyms_verify_off(fp));
 	}
=20
@@ -2420,6 +2421,24 @@ struct bpf_prog *bpf_prog_select_runtime(struct bp=
f_prog *fp, int *err)
 		if (*err)
 			return fp;
=20
+		if (fp->aux->priv_stack_eligible) {
+			if (!fp->aux->stack_depth) {
+				fp->aux->priv_stack_mode =3D NO_PRIV_STACK;
+			} else {
+				void __percpu *priv_stack_ptr;
+
+				fp->aux->priv_stack_mode =3D PRIV_STACK_ROOT_PROG;
+				priv_stack_ptr =3D
+					__alloc_percpu_gfp(fp->aux->stack_depth, 8, GFP_KERNEL);
+				if (!priv_stack_ptr) {
+					*err =3D -ENOMEM;
+					return fp;
+				}
+				fp->aux->subtree_stack_depth =3D fp->aux->stack_depth;
+				fp->aux->priv_stack_ptr =3D priv_stack_ptr;
+			}
+		}
+
 		fp =3D bpf_int_jit_compile(fp);
 		bpf_prog_jit_attempt_done(fp);
 		if (!fp->jited && jit_needed) {
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 3972606f97d2..46b0c277c6a8 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -20003,6 +20003,8 @@ static int jit_subprogs(struct bpf_verifier_env *=
env)
 {
 	struct bpf_prog *prog =3D env->prog, **func, *tmp;
 	int i, j, subprog_start, subprog_end =3D 0, len, subprog;
+	int subtree_top_idx, subtree_stack_depth;
+	void __percpu *priv_stack_ptr;
 	struct bpf_map *map_ptr;
 	struct bpf_insn *insn;
 	void *old_bpf_func;
@@ -20081,6 +20083,33 @@ static int jit_subprogs(struct bpf_verifier_env =
*env)
 		func[i]->is_func =3D 1;
 		func[i]->sleepable =3D prog->sleepable;
 		func[i]->aux->func_idx =3D i;
+
+		subtree_top_idx =3D env->subprog_info[i].subtree_top_idx;
+		if (env->subprog_info[subtree_top_idx].priv_stack_eligible) {
+			if (subtree_top_idx =3D=3D i)
+				func[i]->aux->subtree_stack_depth =3D
+					env->subprog_info[i].subtree_stack_depth;
+
+			subtree_stack_depth =3D func[i]->aux->subtree_stack_depth;
+			if (subtree_top_idx !=3D i) {
+				if (env->subprog_info[subtree_top_idx].subtree_stack_depth)
+					func[i]->aux->priv_stack_mode =3D PRIV_STACK_SUB_PROG;
+				else
+					func[i]->aux->priv_stack_mode =3D NO_PRIV_STACK;
+			} else if (!subtree_stack_depth) {
+				func[i]->aux->priv_stack_mode =3D PRIV_STACK_ROOT_PROG;
+			} else {
+				func[i]->aux->priv_stack_mode =3D PRIV_STACK_ROOT_PROG;
+				priv_stack_ptr =3D
+					__alloc_percpu_gfp(subtree_stack_depth, 8, GFP_KERNEL);
+				if (!priv_stack_ptr) {
+					err =3D -ENOMEM;
+					goto out_free;
+				}
+				func[i]->aux->priv_stack_ptr =3D priv_stack_ptr;
+			}
+		}
+
 		/* Below members will be freed only at prog->aux */
 		func[i]->aux->btf =3D prog->aux->btf;
 		func[i]->aux->func_info =3D prog->aux->func_info;
--=20
2.43.5


