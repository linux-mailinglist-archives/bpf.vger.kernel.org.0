Return-Path: <bpf+bounces-78355-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EC5E0D0BEF8
	for <lists+bpf@lfdr.de>; Fri, 09 Jan 2026 19:50:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B509F3063D91
	for <lists+bpf@lfdr.de>; Fri,  9 Jan 2026 18:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50C402E1747;
	Fri,  9 Jan 2026 18:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xWngQGm4"
X-Original-To: bpf@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F276A2DCF6B
	for <bpf@vger.kernel.org>; Fri,  9 Jan 2026 18:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767984579; cv=none; b=b1jA1RXONIb7lEyEvzlWExE9hL73EmEBzzXsoSjMcJrSMhuhL6tsF7n9Ylgn6e0zsuRNelrjl/V+I2abFBWvTAC7kJtXqti2++YMmXQ9B5YBdxHwPojsLwHGYUKfLM0BPNUIgabMNsZ4SbmkpmlAjjUwHpEs7MXT7VVGszG9u3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767984579; c=relaxed/simple;
	bh=15NPuVR5DtlN3yq8b2IbqJp94TpD0TA5/2gjIsoju0I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sl1PySVHExXzbz+jqIwkBDOMIx9wHBPlGRZsYLvFOR0/j1KumF3aG/j1jBXf7/LynjeAVgvvy/l4rU7nGxUzQBGjFD2ao4Y/FdvobXImF8GHAxHHnZ6czy26oYKAB6PpEsa1mnlWCtxEeUBkT+tBMt8Fm14eAvxPgw2L3i6+KV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xWngQGm4; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767984576;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jlNrmptAUYBhTiSJ2YTfzkhzyxLU5Ig/IkkoeZb5N6I=;
	b=xWngQGm4KUEjiw1yUtjeW6pompkABMLMAo9zsGRGhIaFE43q7YArnbSR3ElpdQnFdwGnwG
	DFUIe2lYc+HcoxpzG7HbtEh1UEQMQrjThD/X4N6TEQCeAMgWIahRhqRdH5rwTsMh36KVh/
	FeZjcOjT37Q316wk4zMOovtmk2sexh0=
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
Subject: [PATCH bpf-next v1 03/10] bpf: Verifier support for KF_IMPLICIT_ARGS
Date: Fri,  9 Jan 2026 10:48:45 -0800
Message-ID: <20260109184852.1089786-4-ihor.solodrai@linux.dev>
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

A kernel function bpf_foo marked with KF_IMPLICIT_ARGS flag is
expected to have two associated types in BTF:
  * `bpf_foo` with a function prototype that omits implicit arguments
  * `bpf_foo_impl` with a function prototype that matches the kernel
     declaration of `bpf_foo`, but doesn't have a ksym associated with
     its name

In order to support kfuncs with implicit arguments, the verifier has
to know how to resolve a call of `bpf_foo` to the correct BTF function
prototype and address.

To implement this, in add_kfunc_call() kfunc flags are checked for
KF_IMPLICIT_ARGS. For such kfuncs a BTF func prototype is adjusted to
the one found for `bpf_foo_impl` (func_name + "_impl" suffix, by
convention) function in BTF.

This effectively changes the signature of the `bpf_foo` kfunc in the
context of verification: from one without implicit args to the one
with full argument list.

Whether a kfunc argument is implicit or not is determined by
is_kfunc_arg_implicit(). The values of implicit arguments by design
are provided by the verifier, and so they can only be of particular
types. In this patch the only allowed implicit arg type is a pointer
to struct bpf_prog_aux. The __prog args (usually void *) are also
considered implicit for backwards compatibility.

In order to enable the verifier to correctly set an implicit
bpf_prog_aux arg value at runtime, is_kfunc_arg_prog() is extended to
check for the arg type. At a point when prog arg is determined in
check_kfunc_args() the kfunc with implicit args already has a
prototype with full argument list, so the existing value patch
mechanism just works.

If a new kfunc with KF_IMPLICIT_ARG is declared for an existing kfunc
that uses a __prog argument (a legacy case), the prototype
substitution works in exactly the same way, assuming the kfunc follows
the _impl naming convention. The difference is only in how _impl
prototype is added to the BTF, which is not the verifier's
concern. See a subsequent resolve_btfids patch for details.

In check_kfunc_call() reset the subreg_def of registers holding
implicit arguments to correctly track zero extensions.

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 include/linux/btf.h   |  1 +
 kernel/bpf/verifier.c | 70 +++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 69 insertions(+), 2 deletions(-)

diff --git a/include/linux/btf.h b/include/linux/btf.h
index bd261015c4bc..f64cc40ab96f 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -78,6 +78,7 @@
 #define KF_ARENA_RET    (1 << 13) /* kfunc returns an arena pointer */
 #define KF_ARENA_ARG1   (1 << 14) /* kfunc takes an arena pointer as its first argument */
 #define KF_ARENA_ARG2   (1 << 15) /* kfunc takes an arena pointer as its second argument */
+#define KF_IMPLICIT_ARGS (1 << 16) /* kfunc has implicit arguments supplied by the verifier */
 
 /*
  * Tag marking a kernel function as a kfunc. This is meant to minimize the
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 9618e4c37fce..5541ab674e30 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3271,6 +3271,38 @@ static struct btf *find_kfunc_desc_btf(struct bpf_verifier_env *env, s16 offset)
 	return btf_vmlinux ?: ERR_PTR(-ENOENT);
 }
 
+#define KF_IMPL_SUFFIX "_impl"
+
+static const struct btf_type *find_kfunc_impl_proto(struct bpf_verifier_env *env,
+						    struct btf *btf,
+						    const char *func_name)
+{
+	char impl_name[KSYM_SYMBOL_LEN];
+	const struct btf_type *func;
+	s32 impl_id;
+	int len;
+
+	len = snprintf(impl_name, sizeof(impl_name), "%s%s", func_name, KF_IMPL_SUFFIX);
+	if (len < 0 || len >= sizeof(impl_name)) {
+		verbose(env, "function name %s%s is too long\n", func_name, KF_IMPL_SUFFIX);
+		return NULL;
+	}
+
+	impl_id = btf_find_by_name_kind(btf, impl_name, BTF_KIND_FUNC);
+	if (impl_id <= 0) {
+		verbose(env, "cannot find function %s in BTF\n", impl_name);
+		return NULL;
+	}
+
+	func = btf_type_by_id(btf, impl_id);
+	if (!func || !btf_type_is_func(func)) {
+		verbose(env, "%s (btf_id %d) is not a function\n", impl_name, impl_id);
+		return NULL;
+	}
+
+	return btf_type_by_id(btf, func->type);
+}
+
 static int fetch_kfunc_meta(struct bpf_verifier_env *env,
 			    s32 func_id,
 			    s16 offset,
@@ -3308,7 +3340,16 @@ static int fetch_kfunc_meta(struct bpf_verifier_env *env,
 	}
 
 	func_name = btf_name_by_offset(btf, func->name_off);
-	func_proto = btf_type_by_id(btf, func->type);
+
+	/*
+	 * An actual prototype of a kfunc with KF_IMPLICIT_ARGS flag
+	 * can be found through the counterpart _impl kfunc.
+	 */
+	if (unlikely(kfunc_flags && KF_IMPLICIT_ARGS & *kfunc_flags))
+		func_proto = find_kfunc_impl_proto(env, btf, func_name);
+	else
+		func_proto = btf_type_by_id(btf, func->type);
+
 	if (!func_proto || !btf_type_is_func_proto(func_proto)) {
 		verbose(env, "kernel function btf_id %d does not have a valid func_proto\n",
 			func_id);
@@ -12173,9 +12214,16 @@ static bool is_kfunc_arg_irq_flag(const struct btf *btf, const struct btf_param
 	return btf_param_match_suffix(btf, arg, "__irq_flag");
 }
 
+static bool is_kfunc_arg_prog_aux(const struct btf *btf, const struct btf_param *arg);
+
 static bool is_kfunc_arg_prog(const struct btf *btf, const struct btf_param *arg)
 {
-	return btf_param_match_suffix(btf, arg, "__prog");
+	return btf_param_match_suffix(btf, arg, "__prog") || is_kfunc_arg_prog_aux(btf, arg);
+}
+
+static bool is_kfunc_arg_implicit(const struct btf *btf, const struct btf_param *arg)
+{
+	return is_kfunc_arg_prog(btf, arg);
 }
 
 static bool is_kfunc_arg_scalar_with_name(const struct btf *btf,
@@ -12206,6 +12254,7 @@ enum {
 	KF_ARG_WORKQUEUE_ID,
 	KF_ARG_RES_SPIN_LOCK_ID,
 	KF_ARG_TASK_WORK_ID,
+	KF_ARG_PROG_AUX_ID
 };
 
 BTF_ID_LIST(kf_arg_btf_ids)
@@ -12217,6 +12266,7 @@ BTF_ID(struct, bpf_rb_node)
 BTF_ID(struct, bpf_wq)
 BTF_ID(struct, bpf_res_spin_lock)
 BTF_ID(struct, bpf_task_work)
+BTF_ID(struct, bpf_prog_aux)
 
 static bool __is_kfunc_ptr_arg_type(const struct btf *btf,
 				    const struct btf_param *arg, int type)
@@ -12297,6 +12347,11 @@ static bool is_kfunc_arg_callback(struct bpf_verifier_env *env, const struct btf
 	return true;
 }
 
+static bool is_kfunc_arg_prog_aux(const struct btf *btf, const struct btf_param *arg)
+{
+	return __is_kfunc_ptr_arg_type(btf, arg, KF_ARG_PROG_AUX_ID);
+}
+
 /* Returns true if struct is composed of scalars, 4 levels of nesting allowed */
 static bool __btf_type_is_scalar_struct(struct bpf_verifier_env *env,
 					const struct btf *btf,
@@ -14303,6 +14358,17 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	for (i = 0; i < nargs; i++) {
 		u32 regno = i + 1;
 
+		/*
+		 * Implicit kfunc arguments are set after main verification pass.
+		 * For correct tracking of zero-extensions we have to reset subreg_def for such
+		 * args. Otherwise mark_btf_func_reg_size() will be inspecting subreg_def of regs
+		 * from an earlier (irrelevant) point in the program, which may lead to an error
+		 * in opt_subreg_zext_lo32_rnd_hi32().
+		 */
+		if (unlikely(KF_IMPLICIT_ARGS & meta.kfunc_flags
+				&& is_kfunc_arg_implicit(desc_btf, &args[i])))
+			regs[regno].subreg_def = DEF_NOT_SUBREG;
+
 		t = btf_type_skip_modifiers(desc_btf, args[i].type, NULL);
 		if (btf_type_is_ptr(t))
 			mark_btf_func_reg_size(env, regno, sizeof(void *));
-- 
2.52.0


