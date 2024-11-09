Return-Path: <bpf+bounces-44416-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D43059C2996
	for <lists+bpf@lfdr.de>; Sat,  9 Nov 2024 03:54:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9325A28484B
	for <lists+bpf@lfdr.de>; Sat,  9 Nov 2024 02:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EE1C127E37;
	Sat,  9 Nov 2024 02:53:58 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 69-171-232-181.mail-mxout.facebook.com (69-171-232-181.mail-mxout.facebook.com [69.171.232.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4BA4779F
	for <bpf@vger.kernel.org>; Sat,  9 Nov 2024 02:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731120838; cv=none; b=braoQ5E1xI3tk2MMzFJ12hfSsJF8dQ1L2S3xw2sIBvGrfkWNSg1iMSK5WPMht8BKc1XsgLaPGGR8WVa0IQdjWekTo3np2JYnvBVeQGYxiSHkEZFGc3rlAtNseh2WQVaDjQeGVFBtnqgGdKwh38VLNMqJRXpoznBppQdGa581hUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731120838; c=relaxed/simple;
	bh=yMHCl93862CCsYHWXKHAYZuP7cRJvl/x/HahHSERy90=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cZSqkYDz5Hqz/DMdAARr6KYA/bhu8gqhocb44UAmN5TLfNCHclNXHi6tThRLaRCcOV4TtwRV+1zuebKh6T74DH6SyX/ChZbiEiQDaqbKTtK6gj2UTSsmX3BgHrq0hqDV8i0wUFOytY226DzqgrJatNOyAukqsAak2NWtujr75O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id E8B41AE075C8; Fri,  8 Nov 2024 18:53:42 -0800 (PST)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH bpf-next v11 6/7] bpf: Support private stack for struct_ops progs
Date: Fri,  8 Nov 2024 18:53:42 -0800
Message-ID: <20241109025342.150552-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241109025312.148539-1-yonghong.song@linux.dev>
References: <20241109025312.148539-1-yonghong.song@linux.dev>
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

Similar to tracing progs, nested same cpu same prog run will be skipped.
A field (recursion_detected()) is added to bpf_prog_aux structure.
If bpf_prog->aux->recursion_detected is implemented by the struct_ops
subsystem and nested same cpu/prog happens, the function will be
triggered to report an error, collect related info, etc.

Acked-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 include/linux/bpf.h          | 2 ++
 include/linux/bpf_verifier.h | 1 +
 kernel/bpf/trampoline.c      | 4 ++++
 kernel/bpf/verifier.c        | 7 ++++++-
 4 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 9cfb8f55d691..ae50826f9ace 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1525,9 +1525,11 @@ struct bpf_prog_aux {
 	bool exception_boundary;
 	bool is_extended; /* true if extended by freplace program */
 	bool jits_use_priv_stack;
+	bool priv_stack_requested;
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
index 456fd2265345..f013988d2e7f 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -895,6 +895,7 @@ static inline bool bpf_prog_check_recur(const struct =
bpf_prog *prog)
 	case BPF_PROG_TYPE_TRACING:
 		return prog->expected_attach_type !=3D BPF_TRACE_ITER;
 	case BPF_PROG_TYPE_STRUCT_OPS:
+		return prog->aux->jits_use_priv_stack;
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
index 8a7576233814..cf69caf67d61 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6054,7 +6054,7 @@ static enum priv_stack_mode bpf_enable_priv_stack(s=
truct bpf_prog *prog)
 	case BPF_PROG_TYPE_TRACING:
 	case BPF_PROG_TYPE_LSM:
 	case BPF_PROG_TYPE_STRUCT_OPS:
-		if (bpf_prog_check_recur(prog))
+		if (prog->aux->priv_stack_requested || bpf_prog_check_recur(prog))
 			return PRIV_STACK_ADAPTIVE;
 		fallthrough;
 	default:
@@ -22000,6 +22000,11 @@ static int check_struct_ops_btf_id(struct bpf_ve=
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


