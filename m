Return-Path: <bpf+bounces-78353-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B1521D0BEDD
	for <lists+bpf@lfdr.de>; Fri, 09 Jan 2026 19:50:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1B0B6303369E
	for <lists+bpf@lfdr.de>; Fri,  9 Jan 2026 18:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 000192DF142;
	Fri,  9 Jan 2026 18:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HxhvkyY5"
X-Original-To: bpf@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53802DCF58
	for <bpf@vger.kernel.org>; Fri,  9 Jan 2026 18:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767984577; cv=none; b=djwdW/yM8m1eXUAKicFl0+KE7r551kVIRGoe5NrxI1GOEdnrXc4qWt9lpAlMFU1jvRZsxlePBiq8cg8+uB1WoWlUrcre6psjmGCivXQUGl3Ae9gDqOtZMoSwYCchJUNZ6k3gpBEzvvrVmE00BZou8fvDsaoilP+RVMkgZc44xIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767984577; c=relaxed/simple;
	bh=4cj0Zi679yt8AYyDjIixj/dAQYgQxGTNLDaceY8ZqoU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tsxEL1fmLAX9LeIuWGT+WpEBjGzbzp6Hig8sEr2DmUtYSVRJFpm2sMi8nKCAYGjGYHB4CPBwJPBkfrizP+rqdzcyQN2kFN0Ijmpi6XS3rMsJix2wC/AS7tArmhKm/MrwUlQLWyfMnjjEKbYJJ0qgZ4FT8KNDYIuci+recp+3JxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HxhvkyY5; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767984572;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UVFscS4HguYlDvmPQWflZYyS6T7UbqSvUiT2yJJJBDY=;
	b=HxhvkyY5AMNjIlyUjDEIv1u8oVTgb7tRtXcGl6kgeoLpWSCB5Ve1ZurC/DYL2l71/Ha4Gz
	hv2/TXCzUdpVffYLtaJth/cbRzv0T1n6d6dFKKT2SeMgvKxm+wZoZlgyv/ip4KB3pBapf+
	BXPmNHTy0xbvlNHP4ZlXfHVa2bv8gHA=
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>
Cc: Mykyta Yatsenko <yatsenko@meta.com>,
	Tejun Heo <tj@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Jiri Kosina <jikos@kernel.org>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org,
	sched-ext@lists.linux.dev
Subject: [PATCH bpf-next v1 02/10] bpf: Introduce struct bpf_kfunc_meta
Date: Fri,  9 Jan 2026 10:48:44 -0800
Message-ID: <20260109184852.1089786-3-ihor.solodrai@linux.dev>
In-Reply-To: <20260109184852.1089786-1-ihor.solodrai@linux.dev>
References: <20260109184852.1089786-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

There is code duplication between add_kfunc_call() and
fetch_kfunc_meta() collecting information about a kfunc from BTF.

Introduce struct bpf_kfunc_meta to hold common kfunc BTF data and
implement fetch_kfunc_meta() to fill it in, instead of struct
bpf_kfunc_call_arg_meta directly.

Then use these in add_kfunc_call() and (new) fetch_kfunc_arg_meta()
functions, and fixup previous usages of fetch_kfunc_meta() to
fetch_kfunc_arg_meta().

Besides the code dedup, this change enables add_kfunc_call() to access
kfunc->flags.

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 kernel/bpf/verifier.c | 156 ++++++++++++++++++++++++------------------
 1 file changed, 91 insertions(+), 65 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index bee49c9cde21..9618e4c37fce 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -294,6 +294,14 @@ struct bpf_call_arg_meta {
 	s64 const_map_key;
 };
 
+struct bpf_kfunc_meta {
+	struct btf *btf;
+	const struct btf_type *proto;
+	const char *name;
+	const u32 *flags;
+	s32 id;
+};
+
 struct bpf_kfunc_call_arg_meta {
 	/* In parameters */
 	struct btf *btf;
@@ -3263,16 +3271,68 @@ static struct btf *find_kfunc_desc_btf(struct bpf_verifier_env *env, s16 offset)
 	return btf_vmlinux ?: ERR_PTR(-ENOENT);
 }
 
-static int add_kfunc_call(struct bpf_verifier_env *env, u32 func_id, s16 offset)
+static int fetch_kfunc_meta(struct bpf_verifier_env *env,
+			    s32 func_id,
+			    s16 offset,
+			    struct bpf_kfunc_meta *kfunc)
 {
 	const struct btf_type *func, *func_proto;
+	const char *func_name;
+	u32 *kfunc_flags;
+	struct btf *btf;
+
+	if (func_id <= 0) {
+		verbose(env, "invalid kernel function btf_id %d\n", func_id);
+		return -EINVAL;
+	}
+
+	btf = find_kfunc_desc_btf(env, offset);
+	if (IS_ERR(btf)) {
+		verbose(env, "failed to find BTF for kernel function\n");
+		return PTR_ERR(btf);
+	}
+
+	/*
+	 * Note that kfunc_flags may be NULL at this point, which
+	 * means that we couldn't find func_id in any relevant
+	 * kfunc_id_set. This most likely indicates an invalid kfunc
+	 * call.  However we don't fail with an error here,
+	 * and let the caller decide what to do with NULL kfunc->flags.
+	 */
+	kfunc_flags = btf_kfunc_flags(btf, func_id, env->prog);
+
+	func = btf_type_by_id(btf, func_id);
+	if (!func || !btf_type_is_func(func)) {
+		verbose(env, "kernel btf_id %d is not a function\n", func_id);
+		return -EINVAL;
+	}
+
+	func_name = btf_name_by_offset(btf, func->name_off);
+	func_proto = btf_type_by_id(btf, func->type);
+	if (!func_proto || !btf_type_is_func_proto(func_proto)) {
+		verbose(env, "kernel function btf_id %d does not have a valid func_proto\n",
+			func_id);
+		return -EINVAL;
+	}
+
+	memset(kfunc, 0, sizeof(*kfunc));
+	kfunc->btf = btf;
+	kfunc->id = func_id;
+	kfunc->name = func_name;
+	kfunc->proto = func_proto;
+	kfunc->flags = kfunc_flags;
+
+	return 0;
+}
+
+static int add_kfunc_call(struct bpf_verifier_env *env, u32 func_id, s16 offset)
+{
 	struct bpf_kfunc_btf_tab *btf_tab;
 	struct btf_func_model func_model;
 	struct bpf_kfunc_desc_tab *tab;
 	struct bpf_prog_aux *prog_aux;
+	struct bpf_kfunc_meta kfunc;
 	struct bpf_kfunc_desc *desc;
-	const char *func_name;
-	struct btf *desc_btf;
 	unsigned long addr;
 	int err;
 
@@ -3322,12 +3382,6 @@ static int add_kfunc_call(struct bpf_verifier_env *env, u32 func_id, s16 offset)
 		prog_aux->kfunc_btf_tab = btf_tab;
 	}
 
-	desc_btf = find_kfunc_desc_btf(env, offset);
-	if (IS_ERR(desc_btf)) {
-		verbose(env, "failed to find BTF for kernel function\n");
-		return PTR_ERR(desc_btf);
-	}
-
 	if (find_kfunc_desc(env->prog, func_id, offset))
 		return 0;
 
@@ -3336,24 +3390,13 @@ static int add_kfunc_call(struct bpf_verifier_env *env, u32 func_id, s16 offset)
 		return -E2BIG;
 	}
 
-	func = btf_type_by_id(desc_btf, func_id);
-	if (!func || !btf_type_is_func(func)) {
-		verbose(env, "kernel btf_id %u is not a function\n",
-			func_id);
-		return -EINVAL;
-	}
-	func_proto = btf_type_by_id(desc_btf, func->type);
-	if (!func_proto || !btf_type_is_func_proto(func_proto)) {
-		verbose(env, "kernel function btf_id %u does not have a valid func_proto\n",
-			func_id);
-		return -EINVAL;
-	}
+	err = fetch_kfunc_meta(env, func_id, offset, &kfunc);
+	if (err)
+		return err;
 
-	func_name = btf_name_by_offset(desc_btf, func->name_off);
-	addr = kallsyms_lookup_name(func_name);
+	addr = kallsyms_lookup_name(kfunc.name);
 	if (!addr) {
-		verbose(env, "cannot find address for kernel function %s\n",
-			func_name);
+		verbose(env, "cannot find address for kernel function %s\n", kfunc.name);
 		return -EINVAL;
 	}
 
@@ -3363,9 +3406,7 @@ static int add_kfunc_call(struct bpf_verifier_env *env, u32 func_id, s16 offset)
 			return err;
 	}
 
-	err = btf_distill_func_proto(&env->log, desc_btf,
-				     func_proto, func_name,
-				     &func_model);
+	err = btf_distill_func_proto(&env->log, kfunc.btf, kfunc.proto, kfunc.name, &func_model);
 	if (err)
 		return err;
 
@@ -13695,44 +13736,28 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 	return 0;
 }
 
-static int fetch_kfunc_meta(struct bpf_verifier_env *env,
-			    struct bpf_insn *insn,
-			    struct bpf_kfunc_call_arg_meta *meta,
-			    const char **kfunc_name)
+static int fetch_kfunc_arg_meta(struct bpf_verifier_env *env,
+				s32 func_id,
+				s16 offset,
+				struct bpf_kfunc_call_arg_meta *meta)
 {
-	const struct btf_type *func, *func_proto;
-	u32 func_id, *kfunc_flags;
-	const char *func_name;
-	struct btf *desc_btf;
-
-	if (kfunc_name)
-		*kfunc_name = NULL;
-
-	if (!insn->imm)
-		return -EINVAL;
+	struct bpf_kfunc_meta kfunc;
+	int err;
 
-	desc_btf = find_kfunc_desc_btf(env, insn->off);
-	if (IS_ERR(desc_btf))
-		return PTR_ERR(desc_btf);
+	err = fetch_kfunc_meta(env, func_id, offset, &kfunc);
+	if (err)
+		return err;
 
-	func_id = insn->imm;
-	func = btf_type_by_id(desc_btf, func_id);
-	func_name = btf_name_by_offset(desc_btf, func->name_off);
-	if (kfunc_name)
-		*kfunc_name = func_name;
-	func_proto = btf_type_by_id(desc_btf, func->type);
+	memset(meta, 0, sizeof(*meta));
+	meta->btf = kfunc.btf;
+	meta->func_id = kfunc.id;
+	meta->func_proto = kfunc.proto;
+	meta->func_name = kfunc.name;
 
-	if (!btf_kfunc_is_allowed(desc_btf, func_id, env->prog))
+	if (!kfunc.flags || !btf_kfunc_is_allowed(kfunc.btf, kfunc.id, env->prog))
 		return -EACCES;
 
-	kfunc_flags = btf_kfunc_flags(desc_btf, func_id, env->prog);
-
-	memset(meta, 0, sizeof(*meta));
-	meta->btf = desc_btf;
-	meta->func_id = func_id;
-	meta->kfunc_flags = *kfunc_flags;
-	meta->func_proto = func_proto;
-	meta->func_name = func_name;
+	meta->kfunc_flags = *kfunc.flags;
 
 	return 0;
 }
@@ -13937,12 +13962,13 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	if (!insn->imm)
 		return 0;
 
-	err = fetch_kfunc_meta(env, insn, &meta, &func_name);
-	if (err == -EACCES && func_name)
-		verbose(env, "calling kernel function %s is not allowed\n", func_name);
+	err = fetch_kfunc_arg_meta(env, insn->imm, insn->off, &meta);
+	if (err == -EACCES && meta.func_name)
+		verbose(env, "calling kernel function %s is not allowed\n", meta.func_name);
 	if (err)
 		return err;
 	desc_btf = meta.btf;
+	func_name = meta.func_name;
 	insn_aux = &env->insn_aux_data[insn_idx];
 
 	insn_aux->is_iter_next = is_iter_next_kfunc(&meta);
@@ -17729,7 +17755,7 @@ static bool get_call_summary(struct bpf_verifier_env *env, struct bpf_insn *call
 	if (bpf_pseudo_kfunc_call(call)) {
 		int err;
 
-		err = fetch_kfunc_meta(env, call, &meta, NULL);
+		err = fetch_kfunc_arg_meta(env, call->imm, call->off, &meta);
 		if (err < 0)
 			/* error would be reported later */
 			return false;
@@ -18237,7 +18263,7 @@ static int visit_insn(int t, struct bpf_verifier_env *env)
 		} else if (insn->src_reg == BPF_PSEUDO_KFUNC_CALL) {
 			struct bpf_kfunc_call_arg_meta meta;
 
-			ret = fetch_kfunc_meta(env, insn, &meta, NULL);
+			ret = fetch_kfunc_arg_meta(env, insn->imm, insn->off, &meta);
 			if (ret == 0 && is_iter_next_kfunc(&meta)) {
 				mark_prune_point(env, t);
 				/* Checking and saving state checkpoints at iter_next() call
-- 
2.52.0


