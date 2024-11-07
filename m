Return-Path: <bpf+bounces-44196-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDBFF9BFCA5
	for <lists+bpf@lfdr.de>; Thu,  7 Nov 2024 03:42:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A52EB21EE0
	for <lists+bpf@lfdr.de>; Thu,  7 Nov 2024 02:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C04953EA76;
	Thu,  7 Nov 2024 02:42:18 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 69-171-232-181.mail-mxout.facebook.com (69-171-232-181.mail-mxout.facebook.com [69.171.232.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C0944C6C
	for <bpf@vger.kernel.org>; Thu,  7 Nov 2024 02:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730947338; cv=none; b=sE2KItHqVFxA9P2BD1AhYgwK3gc65KEVdzI7jIu3mHpGrw26MgcbOyRRXmnGah1DcMkBogp3kAFP2++Svt7DUUNminBOCoGgT4TmEG8lhFFjDg2Gj/ppC3iA8tV0h+0mF0OSVzqKgR1czovI+6FPWg4iAUBQ7L0nljInSK3TCPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730947338; c=relaxed/simple;
	bh=KqtsTZwcHTK/W1p/zMMtwpERxtAgOk0hju8bAemVcjw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BcTe95lh1voF6+uI8RoI71P/zjorQaUrOMSk+HVG3gra5yOabahH60mlCuvz6Toud5Zq6gwbNJmdLdxTQB3CRQYDEl3rr7k+vQRqqfqEKR6p6qsKLvb/txG0adgOJy6ybgp9gL3kLVIslKc+zwLM7k2OAocwOsCHF8cTmS3jowI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 8DF2DAD19F90; Wed,  6 Nov 2024 18:42:09 -0800 (PST)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH bpf-next v10 6/7] bpf: Support private stack for struct_ops progs
Date: Wed,  6 Nov 2024 18:42:09 -0800
Message-ID: <20241107024209.3357227-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241107024138.3355687-1-yonghong.song@linux.dev>
References: <20241107024138.3355687-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

For struct_ops progs, whether a particular prog uses private stack
depends on prog->aux->priv_stack_requested setting before actual
insn-level verification for that prog. One particular implementation
is to piggyback on struct_ops->check_member(). The next patch has
an example for this. The struct_ops->check_member() sets
prog->aux->priv_stack_requested to be true which enables private stack
usage.

The struct_ops prog follows the same rule as kprobe/tracing progs after
function bpf_enable_priv_stack(). For example, even a struct_ops prog
requests private stack, it could still use normal kernel stack if
the stack size is small (< 64 bytes).

The prog->aux->priv_stack_requested is also used for recursion checking
for struct_ops progs. Similar to tracing progs, nested same cpu same
prog run will be skipped. A field (recursion_detected()) is added to
bpf_prog_aux structure. If bpf_prog->aux->recursion_detected
is implemented by the struct_ops subsystem and nested same cpu/prog
happens, the function will be triggered to report an error, collect
related info, etc.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 include/linux/bpf.h          | 1 +
 include/linux/bpf_verifier.h | 1 +
 kernel/bpf/trampoline.c      | 4 ++++
 kernel/bpf/verifier.c        | 6 ++++++
 4 files changed, 12 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 644ad35b88ec..938e9c4fa9b1 100644
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
index 456fd2265345..6c1a173c30e6 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -895,6 +895,7 @@ static inline bool bpf_prog_check_recur(const struct =
bpf_prog *prog)
 	case BPF_PROG_TYPE_TRACING:
 		return prog->expected_attach_type !=3D BPF_TRACE_ITER;
 	case BPF_PROG_TYPE_STRUCT_OPS:
+		return prog->aux->priv_stack_requested;
 	case BPF_PROG_TYPE_LSM:
 		return false;
 	default:
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
index 09bb9dc939d6..d0e5038a844a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6279,6 +6279,7 @@ static int check_max_stack_depth(struct bpf_verifie=
r_env *env)
 		}
 	}
=20
+	env->prog->aux->priv_stack_requested =3D false;
 	if (si[0].priv_stack_mode =3D=3D PRIV_STACK_ADAPTIVE)
 		env->prog->aux->priv_stack_requested =3D true;
=20
@@ -21986,6 +21987,11 @@ static int check_struct_ops_btf_id(struct bpf_ve=
rifier_env *env)
 		}
 	}
=20
+	if (prog->aux->priv_stack_requested && !bpf_jit_supports_private_stack(=
)) {
+		verbose(env, "Private stack not supported by jit\n");
+		return -EACCES;
+	}
+
 	/* btf_ctx_access() used this to provide argument type info */
 	prog->aux->ctx_arg_info =3D
 		st_ops_desc->arg_info[member_idx].info;
--=20
2.43.5


