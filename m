Return-Path: <bpf+bounces-43939-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 778539BBE21
	for <lists+bpf@lfdr.de>; Mon,  4 Nov 2024 20:38:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36A6B283348
	for <lists+bpf@lfdr.de>; Mon,  4 Nov 2024 19:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 817BD1CC8A0;
	Mon,  4 Nov 2024 19:38:12 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 66-220-155-178.mail-mxout.facebook.com (66-220-155-178.mail-mxout.facebook.com [66.220.155.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753051CC893
	for <bpf@vger.kernel.org>; Mon,  4 Nov 2024 19:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730749092; cv=none; b=dgkFNqc5uf3JxcytqVHubKunkpPR3GyPCSNEWTx1MVQGRkys4/g8hteaEPtDv6cRQpf1EFJvHSVnN7i2RFwjPcGc6xq6b9NBkNETHyufrcWOW5mFOVNB4YDWLe52/t0R1V1JlbsITL0H14uSu1vIMHegSVpns/hoysZKXXMtj0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730749092; c=relaxed/simple;
	bh=BM+axZwe3R8DERr13mo1YjpJwZZAPwn39kxN/nD3wyg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oJkhMCorB2rVvc/GsytC5fkK0Wj6KgchOcZ/0tl5mPCqrjJfqcMfmRijZk/hfXZFEs1qrZZs13LT8KeaCwIkxGawiMXOqSHiKOZP7qPD2GSJb12LJlYfQctxf2GqEV/bYDX2HqRchu1cvVnEzA2JdGIx2d+aPPySsp6ZqdjDExY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id C641FABEC7F7; Mon,  4 Nov 2024 11:35:42 -0800 (PST)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH bpf-next v9 09/10] bpf: Support private stack for struct_ops progs
Date: Mon,  4 Nov 2024 11:35:42 -0800
Message-ID: <20241104193542.3245367-1-yonghong.song@linux.dev>
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

For struct_ops progs, whether a particular prog will use private stack
or not (prog->aux->use_priv_stack) will be set before actual insn-level
verification for that prog. One particular implementation is to
piggyback on struct_ops->check_member(). The next patch will have an
example for this. The struct_ops->check_member() will set
prog->aux->use_priv_stack to be true which enables private stack
usage with ignoring BPF_PRIV_STACK_MIN_SIZE limit.

If use_priv_stack is true for a particular struct_ops prog, bpf
trampoline will need to do recursion checks (one level at this point)
to avoid stack overwrite. A field (recursion_detected()) is added to
bpf_prog_aux structure such that if bpf_prog->aux->recursion_detected
is set by the struct_ops subsystem, the function will be called
to report an error, collect related info, etc.

Acked-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 include/linux/bpf.h          |  1 +
 include/linux/bpf_verifier.h |  1 +
 kernel/bpf/trampoline.c      |  4 ++++
 kernel/bpf/verifier.c        | 20 +++++++++++++++++++-
 4 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 8a3ea7440a4a..d04f990dd6d9 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1528,6 +1528,7 @@ struct bpf_prog_aux {
 	u64 prog_array_member_cnt; /* counts how many times as member of prog_a=
rray */
 	struct mutex ext_mutex; /* mutex for is_extended and prog_array_member_=
cnt */
 	struct bpf_arena *arena;
+	void (*recursion_detected)(struct bpf_prog *prog); /* callback if recur=
sion is detected */
 	/* BTF_KIND_FUNC_PROTO for valid attach_btf_id */
 	const struct btf_type *attach_func_proto;
 	/* function name for valid attach_btf_id */
diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index e921589abc72..f65431c42f9e 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -891,6 +891,7 @@ static inline bool bpf_prog_check_recur(const struct =
bpf_prog *prog)
 	case BPF_PROG_TYPE_TRACING:
 		return prog->expected_attach_type !=3D BPF_TRACE_ITER;
 	case BPF_PROG_TYPE_STRUCT_OPS:
+		return prog->aux->use_priv_stack;
 	case BPF_PROG_TYPE_LSM:
 	default:
 		return false;
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index 9f36c049f4c2..a8d188b31da5 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -899,6 +899,8 @@ static u64 notrace __bpf_prog_enter_recur(struct bpf_=
prog *prog, struct bpf_tram
=20
 	if (unlikely(this_cpu_inc_return(*(prog->active)) !=3D 1)) {
 		bpf_prog_inc_misses_counter(prog);
+		if (prog->aux->recursion_detected)
+			prog->aux->recursion_detected(prog);
 		return 0;
 	}
 	return bpf_prog_start_time();
@@ -975,6 +977,8 @@ u64 notrace __bpf_prog_enter_sleepable_recur(struct b=
pf_prog *prog,
=20
 	if (unlikely(this_cpu_inc_return(*(prog->active)) !=3D 1)) {
 		bpf_prog_inc_misses_counter(prog);
+		if (prog->aux->recursion_detected)
+			prog->aux->recursion_detected(prog);
 		return 0;
 	}
 	return bpf_prog_start_time();
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 03ae76d57076..ee16c328dffc 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6045,6 +6045,8 @@ static enum priv_stack_mode bpf_enable_priv_stack(s=
truct bpf_prog *prog)
 	if (!bpf_prog_check_recur(prog))
 		return NO_PRIV_STACK;
=20
+	if (prog->type =3D=3D BPF_PROG_TYPE_STRUCT_OPS)
+		return PRIV_STACK_ALWAYS;
=20
 	return PRIV_STACK_ADAPTIVE;
 }
@@ -6118,7 +6120,8 @@ static int check_max_stack_depth_subprog(struct bpf=
_verifier_env *env, int idx,
 					idx, subprog_depth);
 				return -EACCES;
 			}
-			if (subprog_depth >=3D BPF_PRIV_STACK_MIN_SIZE) {
+			if (priv_stack_supported =3D=3D PRIV_STACK_ALWAYS ||
+			    subprog_depth >=3D BPF_PRIV_STACK_MIN_SIZE) {
 				subprog[idx].use_priv_stack =3D true;
 				subprog[idx].visited_with_priv_stack =3D true;
 			}
@@ -6235,6 +6238,11 @@ static int check_max_stack_depth(struct bpf_verifi=
er_env *env)
 		for (int i =3D 0; i < env->subprog_cnt; i++) {
 			if (!si[i].has_tail_call)
 				continue;
+			if (priv_stack_supported =3D=3D PRIV_STACK_ALWAYS) {
+				verbose(env,
+					"Private stack not supported due to tail call\n");
+				return -EACCES;
+			}
 			priv_stack_supported =3D NO_PRIV_STACK;
 			break;
 		}
@@ -6275,6 +6283,11 @@ static int check_max_stack_depth(struct bpf_verifi=
er_env *env)
 				depth_frame, subtree_depth);
 			return -EACCES;
 		}
+		if (orig_priv_stack_supported =3D=3D PRIV_STACK_ALWAYS) {
+			verbose(env,
+				"Private stack not supported due to possible nested subprog run\n");
+			return -EACCES;
+		}
 		if (orig_priv_stack_supported =3D=3D PRIV_STACK_ADAPTIVE) {
 			for (int i =3D 0; i < env->subprog_cnt; i++)
 				si[i].use_priv_stack =3D false;
@@ -21950,6 +21963,11 @@ static int check_struct_ops_btf_id(struct bpf_ve=
rifier_env *env)
 		}
 	}
=20
+	if (prog->aux->use_priv_stack && !bpf_jit_supports_private_stack()) {
+		verbose(env, "Private stack not supported by jit\n");
+		return -EACCES;
+	}
+
 	/* btf_ctx_access() used this to provide argument type info */
 	prog->aux->ctx_arg_info =3D
 		st_ops_desc->arg_info[member_idx].info;
--=20
2.43.5


