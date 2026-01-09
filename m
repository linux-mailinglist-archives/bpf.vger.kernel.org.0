Return-Path: <bpf+bounces-78358-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A03FAD0BEF5
	for <lists+bpf@lfdr.de>; Fri, 09 Jan 2026 19:50:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C015830259D6
	for <lists+bpf@lfdr.de>; Fri,  9 Jan 2026 18:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90BA82E091C;
	Fri,  9 Jan 2026 18:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Tvi9JwTW"
X-Original-To: bpf@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57BAC2FB99E
	for <bpf@vger.kernel.org>; Fri,  9 Jan 2026 18:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767984591; cv=none; b=rBzhmAsbqu78CDlpAmKo46vT/97UUWMK7PmP6Ud4IiHvExKEMwugarLo8T8nMNNIFPNGmdSzLnoJ1VEJMtUxgcha8xgZ7ClB1kwOxGo1t/YZ929fykcRgBLpMbWPPvKXXam6bxDZKQeucsz7kUotfrgKBsNcy2Ml4AeP1l73JTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767984591; c=relaxed/simple;
	bh=0iB93HS4VP6XfWo+Nyt7X6ZOvjW5u3rvZvWQi8NNJmM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c5uymruDrXLELL4amfadDrR8qt6lBnuq+M6hO7yNPKpVQQiAcz5U+vNrjZ3WftpQCdD7WBx1t5Y8fgz6JN9IbUgmI9NPk8RCQVsHkbQWSSshKy/o2KDFDnoPy0OBFNGSh4D1o2dPWxtIzeB1It/Tgwv43pFSWrZKXEjweAiShpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Tvi9JwTW; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767984587;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dLX/ddR0Hfg48ztK+jKZyaPjLRTqJUw6BAu0tGaDN4k=;
	b=Tvi9JwTWtAc9Zox0p1Jf4/ujKakZCKfOg6L3Hq0HF+BN6zBmtitEPYdtLWCdIrE62kyXQ4
	ct6hobBYYIJk6rNDYgxi+DNhY8gvSqF6WuMJ09wdFANTP+goBk+pD9eBJvAjf3pvzAg0/+
	j/HZ89peQK/JwKPO1F4Deb14I6pkxdY=
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
Subject: [PATCH bpf-next v1 06/10] bpf: Add bpf_wq_set_callback kfunc with KF_IMPLICIT_ARGS
Date: Fri,  9 Jan 2026 10:48:48 -0800
Message-ID: <20260109184852.1089786-7-ihor.solodrai@linux.dev>
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

Implement bpf_wq_set_callback() with an implicit bpf_prog_aux
argument, and change bpf_wq_set_callback_impl() to call the new kfunc.

Update special kfunc checks in the verifier to accept both versions of
the function.

In the selftests, a bpf_wq_set_callback_impl() call is intentionally
introduced to confirm that both signatures are handled correctly.

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 kernel/bpf/helpers.c                           | 18 +++++++++++++-----
 kernel/bpf/verifier.c                          | 15 +++++++++------
 tools/testing/selftests/bpf/bpf_experimental.h |  5 -----
 tools/testing/selftests/bpf/progs/wq.c         |  2 +-
 .../testing/selftests/bpf/progs/wq_failures.c  |  4 ++--
 5 files changed, 25 insertions(+), 19 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 9eaa4185e0a7..23aa785c0f99 100644
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
@@ -3134,6 +3133,14 @@ __bpf_kfunc int bpf_wq_set_callback_impl(struct bpf_wq *wq,
 	return __bpf_async_set_callback(async, callback_fn, aux, flags, BPF_ASYNC_TYPE_WQ);
 }
 
+__bpf_kfunc int bpf_wq_set_callback_impl(struct bpf_wq *wq,
+					 int (callback_fn)(void *map, int *key, void *value),
+					 unsigned int flags,
+					 void *aux__prog)
+{
+	return bpf_wq_set_callback(wq, callback_fn, flags, aux__prog);
+}
+
 __bpf_kfunc void bpf_preempt_disable(void)
 {
 	preempt_disable();
@@ -4488,6 +4495,7 @@ BTF_ID_FLAGS(func, bpf_dynptr_memset)
 BTF_ID_FLAGS(func, bpf_modify_return_test_tp)
 #endif
 BTF_ID_FLAGS(func, bpf_wq_init)
+BTF_ID_FLAGS(func, bpf_wq_set_callback, KF_IMPLICIT_ARGS)
 BTF_ID_FLAGS(func, bpf_wq_set_callback_impl)
 BTF_ID_FLAGS(func, bpf_wq_start)
 BTF_ID_FLAGS(func, bpf_preempt_disable)
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 5541ab674e30..e5aeee554377 100644
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
@@ -12470,6 +12470,7 @@ enum special_kfunc_type {
 	KF_bpf_arena_alloc_pages,
 	KF_bpf_arena_free_pages,
 	KF_bpf_arena_reserve_pages,
+	KF_bpf_wq_set_callback,
 };
 
 BTF_ID_LIST(special_kfunc_list)
@@ -12547,6 +12548,7 @@ BTF_ID(func, bpf_task_work_schedule_resume_impl)
 BTF_ID(func, bpf_arena_alloc_pages)
 BTF_ID(func, bpf_arena_free_pages)
 BTF_ID(func, bpf_arena_reserve_pages)
+BTF_ID(func, bpf_wq_set_callback)
 
 static bool is_task_work_add_kfunc(u32 func_id)
 {
@@ -13002,7 +13004,7 @@ static bool is_sync_callback_calling_kfunc(u32 btf_id)
 
 static bool is_async_callback_calling_kfunc(u32 btf_id)
 {
-	return btf_id == special_kfunc_list[KF_bpf_wq_set_callback_impl] ||
+	return is_bpf_wq_set_callback_kfunc(btf_id) ||
 	       is_task_work_add_kfunc(btf_id);
 }
 
@@ -13012,9 +13014,10 @@ static bool is_bpf_throw_kfunc(struct bpf_insn *insn)
 	       insn->imm == special_kfunc_list[KF_bpf_throw];
 }
 
-static bool is_bpf_wq_set_callback_impl_kfunc(u32 btf_id)
+static bool is_bpf_wq_set_callback_kfunc(u32 btf_id)
 {
-	return btf_id == special_kfunc_list[KF_bpf_wq_set_callback_impl];
+	return btf_id == special_kfunc_list[KF_bpf_wq_set_callback_impl] ||
+	       btf_id == special_kfunc_list[KF_bpf_wq_set_callback];
 }
 
 static bool is_callback_calling_kfunc(u32 btf_id)
@@ -14093,7 +14096,7 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
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
diff --git a/tools/testing/selftests/bpf/progs/wq.c b/tools/testing/selftests/bpf/progs/wq.c
index 25be2cd9d42c..f265242b954d 100644
--- a/tools/testing/selftests/bpf/progs/wq.c
+++ b/tools/testing/selftests/bpf/progs/wq.c
@@ -107,7 +107,7 @@ static int test_hmap_elem_callback(void *map, int *key,
 	if (bpf_wq_init(wq, map, 0) != 0)
 		return -3;
 
-	if (bpf_wq_set_callback(wq, callback_fn, 0))
+	if (bpf_wq_set_callback_impl(wq, callback_fn, 0, NULL))
 		return -4;
 
 	if (bpf_wq_start(wq, 0))
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


