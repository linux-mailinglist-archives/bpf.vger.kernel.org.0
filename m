Return-Path: <bpf+bounces-79328-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F600D3875F
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 21:24:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C8453325556E
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 20:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AE523A63F7;
	Fri, 16 Jan 2026 20:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BWGlXj3x"
X-Original-To: bpf@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF373A4F57
	for <bpf@vger.kernel.org>; Fri, 16 Jan 2026 20:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768594656; cv=none; b=qP8q7iAQUJdVwKwxRt1SM0EMZTjAeaAkkk7k8GfNFxdZzZUkW2dMmC4HfX/yUfhBEoJ0zdHuHN4En/5WtAmVxfMiRyS8MESDWZChF1bHQzRLRKLupyDOwpPwI742wCbC/BJrS3bFbPtw6kgiZyLdoSuH6Tn7iu3L1UV28oJxC9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768594656; c=relaxed/simple;
	bh=Oeb92ed0VN20pr8KMtJaDOcGNSBdIe7SALJv1HIYYd8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fcB63Hzlt3oCg80l2Ooea7y9ZG2U+SfBqHHTiQ0SoVhXz5e6GBLzhXGFpwP8l6lPrHPAn8SPTqdpgWHj0XJd/GpO91OMictMpo3kuu3+/SC1NglgGHLg1v5VDcpi/4/IwiSpNA3GoAq3WJ5OEZGYPwdxW3dJ7s+GnIUUl/Z8FZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BWGlXj3x; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768594653;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cYoKBgbCqcbwQ64lT7GKhozN1+qeU82EECZtGqV6/QA=;
	b=BWGlXj3xTUqnqeZBqaYANFTB2WHqtQlBV7G1GJvJss6sT29YzbZxSmqKnMrC2mQtyFXuib
	rwlSomqleo2QLEypHH2DZ3yp22vuL9vCRUapXDdeuSivn8Den9jkLNmNk5s4KdbIMdIWSK
	D5R1GG12Gfdu2oqB0dzHGUVSCcLAXuU=
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>
Cc: Mykyta Yatsenko <yatsenko@meta.com>,
	Tejun Heo <tj@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Jiri Kosina <jikos@kernel.org>,
	Amery Hung <ameryhung@gmail.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org,
	sched-ext@lists.linux.dev
Subject: [PATCH bpf-next v2 03/13] bpf: Verifier support for KF_IMPLICIT_ARGS
Date: Fri, 16 Jan 2026 12:16:50 -0800
Message-ID: <20260116201700.864797-4-ihor.solodrai@linux.dev>
In-Reply-To: <20260116201700.864797-1-ihor.solodrai@linux.dev>
References: <20260116201700.864797-1-ihor.solodrai@linux.dev>
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

The values of implicit arguments by design are provided by the
verifier, and so they can only be of particular types. In this patch
the only allowed implicit arg type is a pointer to struct
bpf_prog_aux.

In order for the verifier to correctly set an implicit bpf_prog_aux
arg value at runtime, is_kfunc_arg_prog() is extended to check for the
arg type. At a point when prog arg is determined in check_kfunc_args()
the kfunc with implicit args already has a prototype with full
argument list, so the existing value patch mechanism just works.

If a new kfunc with KF_IMPLICIT_ARG is declared for an existing kfunc
that uses a __prog argument (a legacy case), the prototype
substitution works in exactly the same way, assuming the kfunc follows
the _impl naming convention. The difference is only in how _impl
prototype is added to the BTF, which is not the verifier's
concern. See a subsequent resolve_btfids patch for details.

__prog suffix is still supported at this point, but will be removed in
a subsequent patch, after current users are moved to KF_IMPLICIT_ARGS.

Introduction of KF_IMPLICIT_ARGS revealed an issue with zero-extension
tracking, because an explicit rX = 0 in place of the verifier-supplied
argument is now absent if the arg is implicit (the BPF prog doesn't
pass a dummy NULL anymore). To mitigate this, reset the subreg_def of
all caller saved registers in check_kfunc_call() [1].

[1] https://lore.kernel.org/bpf/b4a760ef828d40dac7ea6074d39452bb0dc82caa.camel@gmail.com/

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 include/linux/btf.h   |  1 +
 kernel/bpf/verifier.c | 58 ++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 55 insertions(+), 4 deletions(-)

diff --git a/include/linux/btf.h b/include/linux/btf.h
index a2f4f383f5b6..48108471c5b1 100644
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
index 5c76fd97bf7c..c6bb8a098fc5 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3271,6 +3271,34 @@ static struct btf *find_kfunc_desc_btf(struct bpf_verifier_env *env, s16 offset)
 	return btf_vmlinux ?: ERR_PTR(-ENOENT);
 }
 
+#define KF_IMPL_SUFFIX "_impl"
+
+static const struct btf_type *find_kfunc_impl_proto(struct bpf_verifier_env *env,
+						    struct btf *btf,
+						    const char *func_name)
+{
+	char *buf = env->tmp_str_buf;
+	const struct btf_type *func;
+	s32 impl_id;
+	int len;
+
+	len = snprintf(buf, TMP_STR_BUF_LEN, "%s%s", func_name, KF_IMPL_SUFFIX);
+	if (len < 0 || len >= TMP_STR_BUF_LEN) {
+		verbose(env, "function name %s%s is too long\n", func_name, KF_IMPL_SUFFIX);
+		return NULL;
+	}
+
+	impl_id = btf_find_by_name_kind(btf, buf, BTF_KIND_FUNC);
+	if (impl_id <= 0) {
+		verbose(env, "cannot find function %s in BTF\n", buf);
+		return NULL;
+	}
+
+	func = btf_type_by_id(btf, impl_id);
+
+	return btf_type_by_id(btf, func->type);
+}
+
 static int fetch_kfunc_meta(struct bpf_verifier_env *env,
 			    s32 func_id,
 			    s16 offset,
@@ -3308,7 +3336,16 @@ static int fetch_kfunc_meta(struct bpf_verifier_env *env,
 	}
 
 	func_name = btf_name_by_offset(btf, func->name_off);
-	func_proto = btf_type_by_id(btf, func->type);
+
+	/*
+	 * An actual prototype of a kfunc with KF_IMPLICIT_ARGS flag
+	 * can be found through the counterpart _impl kfunc.
+	 */
+	if (kfunc_flags && (*kfunc_flags & KF_IMPLICIT_ARGS))
+		func_proto = find_kfunc_impl_proto(env, btf, func_name);
+	else
+		func_proto = btf_type_by_id(btf, func->type);
+
 	if (!func_proto || !btf_type_is_func_proto(func_proto)) {
 		verbose(env, "kernel function btf_id %d does not have a valid func_proto\n",
 			func_id);
@@ -12174,9 +12211,11 @@ static bool is_kfunc_arg_irq_flag(const struct btf *btf, const struct btf_param
 	return btf_param_match_suffix(btf, arg, "__irq_flag");
 }
 
+static bool is_kfunc_arg_prog_aux(const struct btf *btf, const struct btf_param *arg);
+
 static bool is_kfunc_arg_prog(const struct btf *btf, const struct btf_param *arg)
 {
-	return btf_param_match_suffix(btf, arg, "__prog");
+	return btf_param_match_suffix(btf, arg, "__prog") || is_kfunc_arg_prog_aux(btf, arg);
 }
 
 static bool is_kfunc_arg_scalar_with_name(const struct btf *btf,
@@ -12207,6 +12246,7 @@ enum {
 	KF_ARG_WORKQUEUE_ID,
 	KF_ARG_RES_SPIN_LOCK_ID,
 	KF_ARG_TASK_WORK_ID,
+	KF_ARG_PROG_AUX_ID
 };
 
 BTF_ID_LIST(kf_arg_btf_ids)
@@ -12218,6 +12258,7 @@ BTF_ID(struct, bpf_rb_node)
 BTF_ID(struct, bpf_wq)
 BTF_ID(struct, bpf_res_spin_lock)
 BTF_ID(struct, bpf_task_work)
+BTF_ID(struct, bpf_prog_aux)
 
 static bool __is_kfunc_ptr_arg_type(const struct btf *btf,
 				    const struct btf_param *arg, int type)
@@ -12298,6 +12339,11 @@ static bool is_kfunc_arg_callback(struct bpf_verifier_env *env, const struct btf
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
@@ -14177,8 +14223,12 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		}
 	}
 
-	for (i = 0; i < CALLER_SAVED_REGS; i++)
-		mark_reg_not_init(env, regs, caller_saved[i]);
+	for (i = 0; i < CALLER_SAVED_REGS; i++) {
+		u32 regno = caller_saved[i];
+
+		mark_reg_not_init(env, regs, regno);
+		regs[regno].subreg_def = DEF_NOT_SUBREG;
+	}
 
 	/* Check return type */
 	t = btf_type_skip_modifiers(desc_btf, meta.func_proto->type, NULL);
-- 
2.52.0


