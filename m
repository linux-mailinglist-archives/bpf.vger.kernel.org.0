Return-Path: <bpf+bounces-72859-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7099C1CDD6
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 20:02:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21664560B6C
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 19:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9F8F3559DF;
	Wed, 29 Oct 2025 19:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IMrUfMgC"
X-Original-To: bpf@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9782F83DF
	for <bpf@vger.kernel.org>; Wed, 29 Oct 2025 19:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761764518; cv=none; b=lRnDzn7O/3wXdxIS9QO5a8PyK+zMyNBO5lRVqrSTQbkEamdS+ayV3N9+WxzinWtxKXvYdF95tsvDfZbvAy4EaOsBpCeA/agL00ZBJrV1kyNgLcFAr0dGy4VKNzovpljSaSs2n3buZqqYMUFSt3EsOR9Odaixbgun5D30HAPsIFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761764518; c=relaxed/simple;
	bh=p71Bu5VXvgOvgYfxTZyI1C3WiT+Kx6GC/8LN6pW2smA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AcPgjIhptBm8dGjMUV4rHdZLECZQwXGUT3QlB5oxdf9QgnCpkL95kukZ6HqoxxeeqalaKk5dlIlZZnBVSWIMrNXVAF9wu/mdyGCj/hEuN332m7swfWQsalGytIiBkXhGk/OKS/rWq3hjmoNwl6ccPPdauGPwGGxGf6Q5NT+iEww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IMrUfMgC; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761764514;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0zftAEHHTMgGLCmAeloGqGIkEO0ZPPDJ/WTLn3whVJQ=;
	b=IMrUfMgCc3ZjS1i7tGK9qLr9PsBh1CU0VcspVwQpIsuuJd+21Hx+9Ukkwx3TJnX/DdbGym
	valSVDVK1Pg9EoqSQ0ynY5o8G/EzzYLBNGesMZNPfJqUIQlyqhPAQ+zjUHcuDOJLNqfb1c
	BJkjSc+X4YhN+GisPfJoNS1NVS7Oh3U=
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: bpf@vger.kernel.org,
	andrii@kernel.org,
	ast@kernel.org
Cc: dwarves@vger.kernel.org,
	alan.maguire@oracle.com,
	acme@kernel.org,
	eddyz87@gmail.com,
	tj@kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 5/8] bpf: Re-define bpf_wq_set_callback as magic kfunc
Date: Wed, 29 Oct 2025 12:01:10 -0700
Message-ID: <20251029190113.3323406-6-ihor.solodrai@linux.dev>
In-Reply-To: <20251029190113.3323406-1-ihor.solodrai@linux.dev>
References: <20251029190113.3323406-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

* Rename bpf_wq_set_callback_impl to bpf_wq_set_callback
* void *aux__prog => struct bpf_prog_aux *aux__magic
* Set KF_MAGIC_ARGS kfunc flag
* Add bpf_wq_set_callback and _impl to magic_kfuncs BTF_ID_LIST
* Update special kfunc checks in the verifier to accept both _impl and
  non-_impl BTF ids

In the selftests, a bpf_wq_set_callback_impl() call is intentionally
introduced to verify that both signatures are handled correctly.

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 kernel/bpf/helpers.c                           | 13 ++++++-------
 kernel/bpf/verifier.c                          | 18 +++++++++++-------
 tools/testing/selftests/bpf/bpf_experimental.h |  5 -----
 tools/testing/selftests/bpf/progs/wq.c         |  2 +-
 .../testing/selftests/bpf/progs/wq_failures.c  |  4 ++--
 5 files changed, 20 insertions(+), 22 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 930e132f440f..ee56f74f70c1 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -3119,18 +3119,17 @@ __bpf_kfunc int bpf_wq_start(struct bpf_wq *wq, unsigned int flags)
 	return 0;
 }
 
-__bpf_kfunc int bpf_wq_set_callback_impl(struct bpf_wq *wq,
-					 int (callback_fn)(void *map, int *key, void *value),
-					 unsigned int flags,
-					 void *aux__prog)
+__bpf_kfunc int bpf_wq_set_callback(struct bpf_wq *wq,
+				    int (callback_fn)(void *map, int *key, void *value),
+				    unsigned int flags,
+				    struct bpf_prog_aux *aux__magic)
 {
-	struct bpf_prog_aux *aux = (struct bpf_prog_aux *)aux__prog;
 	struct bpf_async_kern *async = (struct bpf_async_kern *)wq;
 
 	if (flags)
 		return -EINVAL;
 
-	return __bpf_async_set_callback(async, callback_fn, aux, flags, BPF_ASYNC_TYPE_WQ);
+	return __bpf_async_set_callback(async, callback_fn, aux__magic, flags, BPF_ASYNC_TYPE_WQ);
 }
 
 __bpf_kfunc void bpf_preempt_disable(void)
@@ -4483,7 +4482,7 @@ BTF_ID_FLAGS(func, bpf_dynptr_memset)
 BTF_ID_FLAGS(func, bpf_modify_return_test_tp)
 #endif
 BTF_ID_FLAGS(func, bpf_wq_init)
-BTF_ID_FLAGS(func, bpf_wq_set_callback_impl)
+BTF_ID_FLAGS(func, bpf_wq_set_callback, KF_MAGIC_ARGS)
 BTF_ID_FLAGS(func, bpf_wq_start)
 BTF_ID_FLAGS(func, bpf_preempt_disable)
 BTF_ID_FLAGS(func, bpf_preempt_enable)
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 67914464d503..3c9e963d879b 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -512,7 +512,7 @@ static bool is_async_callback_calling_kfunc(u32 btf_id);
 static bool is_callback_calling_kfunc(u32 btf_id);
 static bool is_bpf_throw_kfunc(struct bpf_insn *insn);
 
-static bool is_bpf_wq_set_callback_impl_kfunc(u32 btf_id);
+static bool is_bpf_wq_set_callback_kfunc(u32 btf_id);
 static bool is_task_work_add_kfunc(u32 func_id);
 
 static bool is_sync_callback_calling_function(enum bpf_func_id func_id)
@@ -554,7 +554,7 @@ static bool is_async_cb_sleepable(struct bpf_verifier_env *env, struct bpf_insn
 
 	/* bpf_wq and bpf_task_work callbacks are always sleepable. */
 	if (bpf_pseudo_kfunc_call(insn) && insn->off == 0 &&
-	    (is_bpf_wq_set_callback_impl_kfunc(insn->imm) || is_task_work_add_kfunc(insn->imm)))
+	    (is_bpf_wq_set_callback_kfunc(insn->imm) || is_task_work_add_kfunc(insn->imm)))
 		return true;
 
 	verifier_bug(env, "unhandled async callback in is_async_cb_sleepable");
@@ -3267,7 +3267,8 @@ static struct btf *find_kfunc_desc_btf(struct bpf_verifier_env *env, s16 offset)
  * magic_kfuncs is used as a list of (foo, foo_impl) pairs
  */
 BTF_ID_LIST(magic_kfuncs)
-BTF_ID_UNUSED
+BTF_ID(func, bpf_wq_set_callback)
+BTF_ID(func, bpf_wq_set_callback_impl)
 BTF_ID_LIST_END(magic_kfuncs)
 
 static s32 magic_kfunc_by_impl(s32 impl_func_id)
@@ -12385,6 +12386,7 @@ enum special_kfunc_type {
 	KF___bpf_trap,
 	KF_bpf_task_work_schedule_signal,
 	KF_bpf_task_work_schedule_resume,
+	KF_bpf_wq_set_callback,
 };
 
 BTF_ID_LIST(special_kfunc_list)
@@ -12459,6 +12461,7 @@ BTF_ID(func, bpf_dynptr_file_discard)
 BTF_ID(func, __bpf_trap)
 BTF_ID(func, bpf_task_work_schedule_signal)
 BTF_ID(func, bpf_task_work_schedule_resume)
+BTF_ID(func, bpf_wq_set_callback)
 
 static bool is_task_work_add_kfunc(u32 func_id)
 {
@@ -12906,7 +12909,7 @@ static bool is_sync_callback_calling_kfunc(u32 btf_id)
 
 static bool is_async_callback_calling_kfunc(u32 btf_id)
 {
-	return btf_id == special_kfunc_list[KF_bpf_wq_set_callback_impl] ||
+	return is_bpf_wq_set_callback_kfunc(btf_id) ||
 	       is_task_work_add_kfunc(btf_id);
 }
 
@@ -12916,9 +12919,10 @@ static bool is_bpf_throw_kfunc(struct bpf_insn *insn)
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
@@ -14035,7 +14039,7 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
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
2.51.1


