Return-Path: <bpf+bounces-42984-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61D3E9AD909
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 02:55:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81AEE1C2188A
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 00:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1BAEBE6C;
	Thu, 24 Oct 2024 00:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wjpy0s5d"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7F91BC41;
	Thu, 24 Oct 2024 00:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729731323; cv=none; b=jeputCvpMnVycokiXUAmF9yoMyECBmbByY2k+PEfD4BUe9gqVNDkmI/qoCmUUTKlXQRWV2tHsTDvB3MS4X5+lPSGZVy+sHWCZZPcnM/moi08yS/7s3aYGxvnXHJzrs/lRMxUx2YutCZZhsLmvatdoeWUibDLpw7RsVUaxEwLZrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729731323; c=relaxed/simple;
	bh=dp4KhNIsrbR2yd624ggpLA6yLLFMoNRs2mmFq+4bfns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t29TlO2EITYv7ZI8e98fWYPGGyxD8KylK5csSn0Sq8Ql0xLinv3Qw16HtKYD3t8a4s3ZmWzwkAvwlXm+KWvMhORjzCfSunpK3Z4kU6nAByaTWczeUROLbFTt03fwd+qRFZzFii35KlBaDv98vDVb0ipFNd09FSuy/jyfhGcDSZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wjpy0s5d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B173CC4CEC6;
	Thu, 24 Oct 2024 00:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729731322;
	bh=dp4KhNIsrbR2yd624ggpLA6yLLFMoNRs2mmFq+4bfns=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Wjpy0s5dLhicS8UBMHhtDrzm12rSxZEVMWn//6Pk3/K397pBHLXdrhUeODcs/VGiv
	 gb9ed/Z4IIzygmiMP05VI7xrtn2R9xUqIxWz/4UwVtYE1BTs3QuDDqdxnCGrpJ6s26
	 /PCie1Ow3tfSs6I8J2hGrJrjfdIsvtSsWEyB63LO70NRW9qqoVBGHLCwjGlSDetGPt
	 2JCgWHyQSOzRAi2RIIPDj7Yp18VZUEHh4FzLubNKdb9n1VvRTQxdyeQ5smpq4HazIO
	 tPUEx+2eUtJSH8ShaNRmDOP5U/H/C7Djt0w4+KvqrFMcZf/xzRvMrHqNKUHBgJ7IiJ
	 fGeMmXRUCa/nA==
Date: Wed, 23 Oct 2024 14:55:21 -1000
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>
Cc: bpf@vger.kernel.org, Martin KaFai Lau <martin.lau@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>, kernel-team@meta.com,
	sched-ext@meta.com, linux-kernel@vger.kernel.org
Subject: [PATCH sched_ext/for-6.13 2/2] sched_ext: Replace
 set_arg_maybe_null() with __nullable CFI stub tags
Message-ID: <Zxma-ZFPKYZDqCGu@slm.duckdns.org>
References: <Zxma0Vt6kwWFe1hx@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zxma0Vt6kwWFe1hx@slm.duckdns.org>

ops.dispatch() and ops.yield() may be fed a NULL task_struct pointer.
set_arg_maybe_null() is used to tell the verifier that they should be NULL
checked before being dereferenced. BPF now has an a lot prettier way to
express this - tagging arguments in CFI stubs with __nullable. Replace
set_arg_maybe_null() with __nullable CFI stub tags.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Martin KaFai Lau <martin.lau@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
---
 kernel/sched/ext.c |   66 +----------------------------------------------------
 1 file changed, 2 insertions(+), 64 deletions(-)

--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -5407,67 +5407,8 @@ err_disable:
 #include <linux/bpf.h>
 #include <linux/btf.h>
 
-extern struct btf *btf_vmlinux;
 static const struct btf_type *task_struct_type;
 
-static bool set_arg_maybe_null(const char *op, int arg_n, int off, int size,
-			       enum bpf_access_type type,
-			       const struct bpf_prog *prog,
-			       struct bpf_insn_access_aux *info)
-{
-	struct btf *btf = bpf_get_btf_vmlinux();
-	const struct bpf_struct_ops_desc *st_ops_desc;
-	const struct btf_member *member;
-	const struct btf_type *t;
-	u32 btf_id, member_idx;
-	const char *mname;
-
-	/* struct_ops op args are all sequential, 64-bit numbers */
-	if (off != arg_n * sizeof(__u64))
-		return false;
-
-	/* btf_id should be the type id of struct sched_ext_ops */
-	btf_id = prog->aux->attach_btf_id;
-	st_ops_desc = bpf_struct_ops_find(btf, btf_id);
-	if (!st_ops_desc)
-		return false;
-
-	/* BTF type of struct sched_ext_ops */
-	t = st_ops_desc->type;
-
-	member_idx = prog->expected_attach_type;
-	if (member_idx >= btf_type_vlen(t))
-		return false;
-
-	/*
-	 * Get the member name of this struct_ops program, which corresponds to
-	 * a field in struct sched_ext_ops. For example, the member name of the
-	 * dispatch struct_ops program (callback) is "dispatch".
-	 */
-	member = &btf_type_member(t)[member_idx];
-	mname = btf_name_by_offset(btf_vmlinux, member->name_off);
-
-	if (!strcmp(mname, op)) {
-		/*
-		 * The value is a pointer to a type (struct task_struct) given
-		 * by a BTF ID (PTR_TO_BTF_ID). It is trusted (PTR_TRUSTED),
-		 * however, can be a NULL (PTR_MAYBE_NULL). The BPF program
-		 * should check the pointer to make sure it is not NULL before
-		 * using it, or the verifier will reject the program.
-		 *
-		 * Longer term, this is something that should be addressed by
-		 * BTF, and be fully contained within the verifier.
-		 */
-		info->reg_type = PTR_MAYBE_NULL | PTR_TO_BTF_ID | PTR_TRUSTED;
-		info->btf = btf_vmlinux;
-		info->btf_id = btf_tracing_ids[BTF_TRACING_TYPE_TASK];
-
-		return true;
-	}
-
-	return false;
-}
-
 static bool bpf_scx_is_valid_access(int off, int size,
 				    enum bpf_access_type type,
 				    const struct bpf_prog *prog,
@@ -5475,9 +5416,6 @@ static bool bpf_scx_is_valid_access(int
 {
 	if (type != BPF_READ)
 		return false;
-	if (set_arg_maybe_null("dispatch", 1, off, size, type, prog, info) ||
-	    set_arg_maybe_null("yield", 1, off, size, type, prog, info))
-		return true;
 	if (off < 0 || off >= sizeof(__u64) * MAX_BPF_FUNC_ARGS)
 		return false;
 	if (off % size != 0)
@@ -5637,13 +5575,13 @@ static int bpf_scx_validate(void *kdata)
 static s32 sched_ext_ops__select_cpu(struct task_struct *p, s32 prev_cpu, u64 wake_flags) { return -EINVAL; }
 static void sched_ext_ops__enqueue(struct task_struct *p, u64 enq_flags) {}
 static void sched_ext_ops__dequeue(struct task_struct *p, u64 enq_flags) {}
-static void sched_ext_ops__dispatch(s32 prev_cpu, struct task_struct *p) {}
+static void sched_ext_ops__dispatch(s32 prev_cpu, struct task_struct *prev__nullable) {}
 static void sched_ext_ops__tick(struct task_struct *p) {}
 static void sched_ext_ops__runnable(struct task_struct *p, u64 enq_flags) {}
 static void sched_ext_ops__running(struct task_struct *p) {}
 static void sched_ext_ops__stopping(struct task_struct *p, bool runnable) {}
 static void sched_ext_ops__quiescent(struct task_struct *p, u64 deq_flags) {}
-static bool sched_ext_ops__yield(struct task_struct *from, struct task_struct *to) { return false; }
+static bool sched_ext_ops__yield(struct task_struct *from, struct task_struct *to__nullable) { return false; }
 static bool sched_ext_ops__core_sched_before(struct task_struct *a, struct task_struct *b) { return false; }
 static void sched_ext_ops__set_weight(struct task_struct *p, u32 weight) {}
 static void sched_ext_ops__set_cpumask(struct task_struct *p, const struct cpumask *mask) {}

