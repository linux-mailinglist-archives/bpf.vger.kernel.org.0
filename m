Return-Path: <bpf+bounces-43433-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 218C29B55A8
	for <lists+bpf@lfdr.de>; Tue, 29 Oct 2024 23:17:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 516DF1C20D08
	for <lists+bpf@lfdr.de>; Tue, 29 Oct 2024 22:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B459A20ADD6;
	Tue, 29 Oct 2024 22:17:32 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 69-171-232-181.mail-mxout.facebook.com (69-171-232-181.mail-mxout.facebook.com [69.171.232.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52CBB20ADD1
	for <bpf@vger.kernel.org>; Tue, 29 Oct 2024 22:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730240252; cv=none; b=NXDAvDLUahZyrZjafNKEje9zlfY4B2HtpSeaQR/KUNImDuQd7YMwIIPIVIUD0nQryEYHGXEsa99nS3wsZNm8ABo+qdMEIXq8y9zVFJFb09Uf1yYT/9ONTKeyghRgRCRpini1gvV6hxg3MLIGuPMiR8ZdM1j4D+D9q6AvZtvSXd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730240252; c=relaxed/simple;
	bh=T7VjmW9eWKcPSF67RXcxVsF3qkSgBgKekZa4EfYgCQY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YRNyNZLJCltyNizfPoGU3zCJXBtbzH3/tOuoKMMKup97Fx1YjH2Y5dRleujf2P8Rpe5Ptz6jmwxPRpyyVLgR5HbfrGObl+Eglsmc8H1Jd/jbZWr+7CTsOLFcy/JA5sGSC68sv4kAj+08B5AwwhvuK9JsiBUKQ7mcas68OzE3bVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 8A6DCA91CFFE; Tue, 29 Oct 2024 15:17:18 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH bpf-next v7 8/9] bpf: Support private stack for struct_ops progs
Date: Tue, 29 Oct 2024 15:17:18 -0700
Message-ID: <20241029221718.268017-1-yonghong.song@linux.dev>
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

For struct_ops progs, whether a particular prog will use private stack
or not (prog->aux->use_priv_stack) will be set before actual insn-level
verification for that prog. One particular implementation is to
piggyback on struct_ops->check_member(). The next patch will have an
example for this. The struct_ops->check_member() will set
prog->aux->use_priv_stack to be true which enables private stack
usage with ignoring BPF_PRIV_STACK_MIN_SIZE limit.

If use_priv_stack is true for a particular struct_ops prog, bpf
trampoline will need to do recursion checks (one level at this point)
to avoid stack overwrite.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 include/linux/bpf_verifier.h |  1 +
 kernel/bpf/verifier.c        | 36 ++++++++++++++++++++++++++++++++----
 2 files changed, 33 insertions(+), 4 deletions(-)

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


