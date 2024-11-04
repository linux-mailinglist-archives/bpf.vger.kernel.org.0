Return-Path: <bpf+bounces-43938-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E513E9BBE20
	for <lists+bpf@lfdr.de>; Mon,  4 Nov 2024 20:38:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B8522832E0
	for <lists+bpf@lfdr.de>; Mon,  4 Nov 2024 19:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FEBC1CDA3B;
	Mon,  4 Nov 2024 19:38:12 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 66-220-155-179.mail-mxout.facebook.com (66-220-155-179.mail-mxout.facebook.com [66.220.155.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52EC71C876D
	for <bpf@vger.kernel.org>; Mon,  4 Nov 2024 19:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730749092; cv=none; b=XbkUj1wxkfIm5kMnaE3iWaYR8Dgl13a0mhBKnmwHsVqV3XoAAblFFqFqb79APi69SI2Bc6jcHlZdHdDELsNRT79v11R4O9VX+Kzur8uOQ677nqdHDuuz19lw83DPE8VI/2TBwTcEfvJkba7zkcAQlIDHupF/b5AxaMv7sMEMKZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730749092; c=relaxed/simple;
	bh=XU5vyXffjfmnt/7cQBsfkswVnNdBvK+qlUgDDQ/NKso=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qFlqOJRdtFVMNc+kee7NojWH7qVhDYvel/vwofGMHStieDDUGVpKJzGWSYqo0mthA+jPfzryobvRKcNTW1sLzoQtaJ7jZVo1R4gWehGMJvDTcRbfYpbgxddmBFsktsH6nDnt3dXJNf6r9ECMmOeLp1cMOWlJ1tiNQPUhJqdJw6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 9C631ABEC78C; Mon,  4 Nov 2024 11:35:21 -0800 (PST)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH bpf-next v9 05/10] bpf: Allocate private stack for eligible main prog or subprogs
Date: Mon,  4 Nov 2024 11:35:21 -0800
Message-ID: <20241104193521.3243984-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241104193455.3241859-1-yonghong.song@linux.dev>
References: <20241104193455.3241859-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

For any main prog or subprogs, allocate private stack space if requested
by subprog info or main prog. The alignment for private stack is 16
since maximum stack alignment is 16 for bpf-enabled archs.

If jit failed, the allocated private stack will be freed in the same
function where the allocation happens. If jit succeeded, e.g., for
x86_64 arch, the allocated private stack is freed in arch specific
implementation of bpf_jit_free().

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 arch/x86/net/bpf_jit_comp.c |  1 +
 include/linux/bpf.h         |  1 +
 kernel/bpf/core.c           | 19 ++++++++++++++++---
 kernel/bpf/verifier.c       | 13 +++++++++++++
 4 files changed, 31 insertions(+), 3 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 06b080b61aa5..59d294b8dd67 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -3544,6 +3544,7 @@ void bpf_jit_free(struct bpf_prog *prog)
 		prog->bpf_func =3D (void *)prog->bpf_func - cfi_get_offset();
 		hdr =3D bpf_jit_binary_pack_hdr(prog);
 		bpf_jit_binary_pack_free(hdr, NULL);
+		free_percpu(prog->aux->priv_stack_ptr);
 		WARN_ON_ONCE(!bpf_prog_kallsyms_verify_off(prog));
 	}
=20
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 8db3c5d7404b..8a3ea7440a4a 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1507,6 +1507,7 @@ struct bpf_prog_aux {
 	u32 max_rdwr_access;
 	struct btf *attach_btf;
 	const struct bpf_ctx_arg_aux *ctx_arg_info;
+	void __percpu *priv_stack_ptr;
 	struct mutex dst_mutex; /* protects dst_* pointers below, *after* prog =
becomes visible */
 	struct bpf_prog *dst_prog;
 	struct bpf_trampoline *dst_trampoline;
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 14d9288441f2..f7a3e93c41e1 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -2396,6 +2396,7 @@ static void bpf_prog_select_func(struct bpf_prog *f=
p)
  */
 struct bpf_prog *bpf_prog_select_runtime(struct bpf_prog *fp, int *err)
 {
+	void __percpu *priv_stack_ptr =3D NULL;
 	/* In case of BPF to BPF calls, verifier did all the prep
 	 * work with regards to JITing, etc.
 	 */
@@ -2421,11 +2422,23 @@ struct bpf_prog *bpf_prog_select_runtime(struct b=
pf_prog *fp, int *err)
 		if (*err)
 			return fp;
=20
+		if (fp->aux->use_priv_stack && fp->aux->stack_depth) {
+			priv_stack_ptr =3D __alloc_percpu_gfp(fp->aux->stack_depth, 16, GFP_K=
ERNEL);
+			if (!priv_stack_ptr) {
+				*err =3D -ENOMEM;
+				return fp;
+			}
+			fp->aux->priv_stack_ptr =3D priv_stack_ptr;
+		}
+
 		fp =3D bpf_int_jit_compile(fp);
 		bpf_prog_jit_attempt_done(fp);
-		if (!fp->jited && jit_needed) {
-			*err =3D -ENOTSUPP;
-			return fp;
+		if (!fp->jited) {
+			free_percpu(priv_stack_ptr);
+			if (jit_needed) {
+				*err =3D -ENOTSUPP;
+				return fp;
+			}
 		}
 	} else {
 		*err =3D bpf_prog_offload_compile(fp);
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e01b3f0fd314..03ae76d57076 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -20073,6 +20073,7 @@ static int jit_subprogs(struct bpf_verifier_env *=
env)
 {
 	struct bpf_prog *prog =3D env->prog, **func, *tmp;
 	int i, j, subprog_start, subprog_end =3D 0, len, subprog;
+	void __percpu *priv_stack_ptr;
 	struct bpf_map *map_ptr;
 	struct bpf_insn *insn;
 	void *old_bpf_func;
@@ -20169,6 +20170,17 @@ static int jit_subprogs(struct bpf_verifier_env =
*env)
=20
 		func[i]->aux->name[0] =3D 'F';
 		func[i]->aux->stack_depth =3D env->subprog_info[i].stack_depth;
+
+		if (env->subprog_info[i].use_priv_stack && func[i]->aux->stack_depth) =
{
+			priv_stack_ptr =3D __alloc_percpu_gfp(func[i]->aux->stack_depth, 16,
+							    GFP_KERNEL);
+			if (!priv_stack_ptr) {
+				err =3D -ENOMEM;
+				goto out_free;
+			}
+			func[i]->aux->priv_stack_ptr =3D priv_stack_ptr;
+		}
+
 		func[i]->jit_requested =3D 1;
 		func[i]->blinding_requested =3D prog->blinding_requested;
 		func[i]->aux->kfunc_tab =3D prog->aux->kfunc_tab;
@@ -20201,6 +20213,7 @@ static int jit_subprogs(struct bpf_verifier_env *=
env)
 			func[i]->aux->exception_boundary =3D env->seen_exception;
 		func[i] =3D bpf_int_jit_compile(func[i]);
 		if (!func[i]->jited) {
+			free_percpu(func[i]->aux->priv_stack_ptr);
 			err =3D -ENOTSUPP;
 			goto out_free;
 		}
--=20
2.43.5


