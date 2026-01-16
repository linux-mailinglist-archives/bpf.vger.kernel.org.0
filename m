Return-Path: <bpf+bounces-79332-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3783ED3877E
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 21:27:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 902F5322C375
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 20:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76AA13A4F33;
	Fri, 16 Jan 2026 20:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JSqXVYcE"
X-Original-To: bpf@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF223A63E2
	for <bpf@vger.kernel.org>; Fri, 16 Jan 2026 20:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768594678; cv=none; b=si56mIbvk4PbVb5D0jDvjvrmlslAj41xaGWtQEg+V0Nk4azM5Ta64tT+IRkdEv4ax+pg6cNuHTUn8U+3aDyCnB/uP/gwRPgDCysY9I4slj0Cm7ngs86A3BHtBCr2wtCPpjuTKLhDS0MlzIqvUc7D68OVcB4ULBjaoAJvMNzkcuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768594678; c=relaxed/simple;
	bh=QOAybCUjGfHm8gtnY98ieBgrWUc72z7XYclPC5IiJkA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sfQgX+Guoxo5VmJZTteUX1tDBCNfFtDEdeX4WM6G77RTaa39/NJbopmYQ/2v1KZdd4Gut/FD3uRbkxMG/qH13+w8B84f+Z7gL+8Bg4Qaa5m18asgMeURNE0hx8rgGZ6i/NIk1fft3ABlOLjfIajnpPIbVsTFtqtLChrnvB35Uro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JSqXVYcE; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768594674;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ks2+dggAU69UsqUUEbaywnaFlk7/NQcZANkJRN2gCT8=;
	b=JSqXVYcEOIYvm95k3Fx6g694SWQ8tSk70mRNgfhKRG40OY9vCREiCL1k1iwb/YbRnXBAK3
	8rciBdCBNrbVo6bcKabhPnpxopqfRHO96Gfyi+5g3rPEZz47zrgnQoxFrvk3NYbri0D5in
	kjJRp8gIzKt92RtgrQXJpSL+XroX2ko=
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
Subject: [PATCH bpf-next v2 07/13] bpf: Migrate bpf_wq_set_callback_impl() to KF_IMPLICIT_ARGS
Date: Fri, 16 Jan 2026 12:16:54 -0800
Message-ID: <20260116201700.864797-8-ihor.solodrai@linux.dev>
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

Implement bpf_wq_set_callback() with an implicit bpf_prog_aux
argument, and remove bpf_wq_set_callback_impl().

Update special kfunc checks in the verifier accordingly.

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 kernel/bpf/helpers.c                             | 11 +++++------
 kernel/bpf/verifier.c                            | 16 ++++++++--------
 tools/testing/selftests/bpf/bpf_experimental.h   |  5 -----
 .../bpf/progs/verifier_async_cb_context.c        |  4 ++--
 tools/testing/selftests/bpf/progs/wq_failures.c  |  4 ++--
 5 files changed, 17 insertions(+), 23 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 9eaa4185e0a7..c76a9003b221 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -3120,12 +3120,11 @@ __bpf_kfunc int bpf_wq_start(struct bpf_wq *wq, unsigned int flags)
 	return 0;
 }
 
-__bpf_kfunc int bpf_wq_set_callback_impl(struct bpf_wq *wq,
-					 int (callback_fn)(void *map, int *key, void *value),
-					 unsigned int flags,
-					 void *aux__prog)
+__bpf_kfunc int bpf_wq_set_callback(struct bpf_wq *wq,
+				    int (callback_fn)(void *map, int *key, void *value),
+				    unsigned int flags,
+				    struct bpf_prog_aux *aux)
 {
-	struct bpf_prog_aux *aux = (struct bpf_prog_aux *)aux__prog;
 	struct bpf_async_kern *async = (struct bpf_async_kern *)wq;
 
 	if (flags)
@@ -4488,7 +4487,7 @@ BTF_ID_FLAGS(func, bpf_dynptr_memset)
 BTF_ID_FLAGS(func, bpf_modify_return_test_tp)
 #endif
 BTF_ID_FLAGS(func, bpf_wq_init)
-BTF_ID_FLAGS(func, bpf_wq_set_callback_impl)
+BTF_ID_FLAGS(func, bpf_wq_set_callback, KF_IMPLICIT_ARGS)
 BTF_ID_FLAGS(func, bpf_wq_start)
 BTF_ID_FLAGS(func, bpf_preempt_disable)
 BTF_ID_FLAGS(func, bpf_preempt_enable)
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index c6bb8a098fc5..360f2199b5d3 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -520,7 +520,7 @@ static bool is_async_callback_calling_kfunc(u32 btf_id);
 static bool is_callback_calling_kfunc(u32 btf_id);
 static bool is_bpf_throw_kfunc(struct bpf_insn *insn);
 
-static bool is_bpf_wq_set_callback_impl_kfunc(u32 btf_id);
+static bool is_bpf_wq_set_callback_kfunc(u32 btf_id);
 static bool is_task_work_add_kfunc(u32 func_id);
 
 static bool is_sync_callback_calling_function(enum bpf_func_id func_id)
@@ -562,7 +562,7 @@ static bool is_async_cb_sleepable(struct bpf_verifier_env *env, struct bpf_insn
 
 	/* bpf_wq and bpf_task_work callbacks are always sleepable. */
 	if (bpf_pseudo_kfunc_call(insn) && insn->off == 0 &&
-	    (is_bpf_wq_set_callback_impl_kfunc(insn->imm) || is_task_work_add_kfunc(insn->imm)))
+	    (is_bpf_wq_set_callback_kfunc(insn->imm) || is_task_work_add_kfunc(insn->imm)))
 		return true;
 
 	verifier_bug(env, "unhandled async callback in is_async_cb_sleepable");
@@ -12437,7 +12437,7 @@ enum special_kfunc_type {
 	KF_bpf_percpu_obj_new_impl,
 	KF_bpf_percpu_obj_drop_impl,
 	KF_bpf_throw,
-	KF_bpf_wq_set_callback_impl,
+	KF_bpf_wq_set_callback,
 	KF_bpf_preempt_disable,
 	KF_bpf_preempt_enable,
 	KF_bpf_iter_css_task_new,
@@ -12501,7 +12501,7 @@ BTF_ID(func, bpf_dynptr_clone)
 BTF_ID(func, bpf_percpu_obj_new_impl)
 BTF_ID(func, bpf_percpu_obj_drop_impl)
 BTF_ID(func, bpf_throw)
-BTF_ID(func, bpf_wq_set_callback_impl)
+BTF_ID(func, bpf_wq_set_callback)
 BTF_ID(func, bpf_preempt_disable)
 BTF_ID(func, bpf_preempt_enable)
 #ifdef CONFIG_CGROUPS
@@ -12994,7 +12994,7 @@ static bool is_sync_callback_calling_kfunc(u32 btf_id)
 
 static bool is_async_callback_calling_kfunc(u32 btf_id)
 {
-	return btf_id == special_kfunc_list[KF_bpf_wq_set_callback_impl] ||
+	return is_bpf_wq_set_callback_kfunc(btf_id) ||
 	       is_task_work_add_kfunc(btf_id);
 }
 
@@ -13004,9 +13004,9 @@ static bool is_bpf_throw_kfunc(struct bpf_insn *insn)
 	       insn->imm == special_kfunc_list[KF_bpf_throw];
 }
 
-static bool is_bpf_wq_set_callback_impl_kfunc(u32 btf_id)
+static bool is_bpf_wq_set_callback_kfunc(u32 btf_id)
 {
-	return btf_id == special_kfunc_list[KF_bpf_wq_set_callback_impl];
+	return btf_id == special_kfunc_list[KF_bpf_wq_set_callback];
 }
 
 static bool is_callback_calling_kfunc(u32 btf_id)
@@ -14085,7 +14085,7 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		meta.r0_rdonly = false;
 	}
 
-	if (is_bpf_wq_set_callback_impl_kfunc(meta.func_id)) {
+	if (is_bpf_wq_set_callback_kfunc(meta.func_id)) {
 		err = push_callback_call(env, insn, insn_idx, meta.subprogno,
 					 set_timer_callback_state);
 		if (err) {
diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
index 2cd9165c7348..68a49b1f77ae 100644
--- a/tools/testing/selftests/bpf/bpf_experimental.h
+++ b/tools/testing/selftests/bpf/bpf_experimental.h
@@ -580,11 +580,6 @@ extern void bpf_iter_css_destroy(struct bpf_iter_css *it) __weak __ksym;
 
 extern int bpf_wq_init(struct bpf_wq *wq, void *p__map, unsigned int flags) __weak __ksym;
 extern int bpf_wq_start(struct bpf_wq *wq, unsigned int flags) __weak __ksym;
-extern int bpf_wq_set_callback_impl(struct bpf_wq *wq,
-		int (callback_fn)(void *map, int *key, void *value),
-		unsigned int flags__k, void *aux__ign) __ksym;
-#define bpf_wq_set_callback(timer, cb, flags) \
-	bpf_wq_set_callback_impl(timer, cb, flags, NULL)
 
 struct bpf_iter_kmem_cache;
 extern int bpf_iter_kmem_cache_new(struct bpf_iter_kmem_cache *it) __weak __ksym;
diff --git a/tools/testing/selftests/bpf/progs/verifier_async_cb_context.c b/tools/testing/selftests/bpf/progs/verifier_async_cb_context.c
index 7efa9521105e..5d5e1cd4d51d 100644
--- a/tools/testing/selftests/bpf/progs/verifier_async_cb_context.c
+++ b/tools/testing/selftests/bpf/progs/verifier_async_cb_context.c
@@ -96,7 +96,7 @@ int wq_non_sleepable_prog(void *ctx)
 
 	if (bpf_wq_init(&val->w, &wq_map, 0) != 0)
 		return 0;
-	if (bpf_wq_set_callback_impl(&val->w, wq_cb, 0, NULL) != 0)
+	if (bpf_wq_set_callback(&val->w, wq_cb, 0) != 0)
 		return 0;
 	return 0;
 }
@@ -114,7 +114,7 @@ int wq_sleepable_prog(void *ctx)
 
 	if (bpf_wq_init(&val->w, &wq_map, 0) != 0)
 		return 0;
-	if (bpf_wq_set_callback_impl(&val->w, wq_cb, 0, NULL) != 0)
+	if (bpf_wq_set_callback(&val->w, wq_cb, 0) != 0)
 		return 0;
 	return 0;
 }
diff --git a/tools/testing/selftests/bpf/progs/wq_failures.c b/tools/testing/selftests/bpf/progs/wq_failures.c
index d06f6d40594a..3767f5595bbc 100644
--- a/tools/testing/selftests/bpf/progs/wq_failures.c
+++ b/tools/testing/selftests/bpf/progs/wq_failures.c
@@ -97,7 +97,7 @@ __failure
 /* check that the first argument of bpf_wq_set_callback()
  * is a correct bpf_wq pointer.
  */
-__msg(": (85) call bpf_wq_set_callback_impl#") /* anchor message */
+__msg(": (85) call bpf_wq_set_callback#") /* anchor message */
 __msg("arg#0 doesn't point to a map value")
 long test_wrong_wq_pointer(void *ctx)
 {
@@ -123,7 +123,7 @@ __failure
 /* check that the first argument of bpf_wq_set_callback()
  * is a correct bpf_wq pointer.
  */
-__msg(": (85) call bpf_wq_set_callback_impl#") /* anchor message */
+__msg(": (85) call bpf_wq_set_callback#") /* anchor message */
 __msg("off 1 doesn't point to 'struct bpf_wq' that is at 0")
 long test_wrong_wq_pointer_offset(void *ctx)
 {
-- 
2.52.0


