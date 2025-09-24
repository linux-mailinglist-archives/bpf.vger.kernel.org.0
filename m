Return-Path: <bpf+bounces-69625-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDBADB9C426
	for <lists+bpf@lfdr.de>; Wed, 24 Sep 2025 23:17:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26ACC1BC37E5
	for <lists+bpf@lfdr.de>; Wed, 24 Sep 2025 21:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 242BD286D49;
	Wed, 24 Sep 2025 21:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EBoM3Cqn"
X-Original-To: bpf@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA882417E6
	for <bpf@vger.kernel.org>; Wed, 24 Sep 2025 21:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758748670; cv=none; b=UFtH8qf120ZCfc7qsXz6V1dYgYA73vgpLBChIBCmf/h4P2lphZdtNCYLMT3wCmjkC3EaaJA4rQkKHHbEsKx8clRAhQx7B4Ni0C5ijk9pWlFxvXchIEgWXHmFxYB5OG0LWHpUNZRyp88b+1gDxCdtXvdCY6Jv+VNfo+9raK4W+RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758748670; c=relaxed/simple;
	bh=v/unoztFliK3XIqv7/qmZUAF+QJVKtXwLqCVegIajhs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NxjeoHj20wjUU6QOFl5n7bfKol/Hj43L7WNDvlMAo/Q4DjyWkI6Gm2fOzFz4ZPIyBR8V+OhYsAjVBlUACbHJW4vcEOYaVvyyjyxLBbc3uyTTdDGDZ4znRM+Wkyc5U4loRHCxb/OcUHJCR3MzFct2JYksZYjJLCF9gnAZ4STjLg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EBoM3Cqn; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758748667;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KPDiFddLAFlqf8gz/qY5uryZrcLPzr9OMl2hmOYRXAc=;
	b=EBoM3CqnZ7fiXrpnfDpbo39wN4+pHzlwumL7ybZ3viWbFLxYii6nnUPyjRxd/neRDyAgrV
	WQhsiaXFAgjbOW4sFY/fCQeDEdRRAQ8ASsBaftkkCTCGNp3KPDa+ZRE0jh3Oypq0BFT+4a
	azw1uMcJ3DI6ybE8a20FZw5rDdkMOHA=
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
Subject: [PATCH bpf-next v1 4/6] bpf: implement bpf_wq_set_callback kfunc with implicit prog_aux
Date: Wed, 24 Sep 2025 14:17:14 -0700
Message-ID: <20250924211716.1287715-5-ihor.solodrai@linux.dev>
In-Reply-To: <20250924211716.1287715-1-ihor.solodrai@linux.dev>
References: <20250924211716.1287715-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add bpf_wq_set_callback BPF kfunc with KF_IMPLICIT_PROG_AUX_ARG,
corresponding to bpf_wq_set_callback_impl kfunc. Teach the verifier
about it.

To be handled correctly, BTF for this kfunc must be generated with
pahole version that supports KF_IMPLICIT_PROG_AUX_ARG.

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 kernel/bpf/helpers.c                           | 18 +++++++++++++-----
 kernel/bpf/verifier.c                          | 15 +++++++++------
 .../testing/selftests/bpf/progs/wq_failures.c  |  4 ++--
 3 files changed, 24 insertions(+), 13 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index c9fab9a356df..6b46acfec790 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -3065,12 +3065,11 @@ __bpf_kfunc int bpf_wq_start(struct bpf_wq *wq, unsigned int flags)
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
@@ -3079,6 +3078,14 @@ __bpf_kfunc int bpf_wq_set_callback_impl(struct bpf_wq *wq,
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
@@ -4374,6 +4381,7 @@ BTF_ID_FLAGS(func, bpf_cgroup_read_xattr, KF_RCU)
 BTF_ID_FLAGS(func, bpf_stream_vprintk, KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, bpf_task_work_schedule_signal, KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, bpf_task_work_schedule_resume, KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_wq_set_callback, KF_IMPLICIT_PROG_AUX_ARG)
 BTF_KFUNCS_END(common_btf_ids)
 
 static const struct btf_kfunc_id_set common_kfunc_set = {
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index f1f9ea21f99b..a29d3b85aed2 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -514,7 +514,7 @@ static bool is_async_callback_calling_kfunc(u32 btf_id);
 static bool is_callback_calling_kfunc(u32 btf_id);
 static bool is_bpf_throw_kfunc(struct bpf_insn *insn);
 
-static bool is_bpf_wq_set_callback_impl_kfunc(u32 btf_id);
+static bool is_bpf_wq_set_callback_kfunc(u32 btf_id);
 
 static bool is_sync_callback_calling_function(enum bpf_func_id func_id)
 {
@@ -10586,7 +10586,7 @@ static int push_callback_call(struct bpf_verifier_env *env, struct bpf_insn *ins
 		env->subprog_info[subprog].is_async_cb = true;
 		async_cb = push_async_cb(env, env->subprog_info[subprog].start,
 					 insn_idx, subprog,
-					 is_bpf_wq_set_callback_impl_kfunc(insn->imm) ||
+					 is_bpf_wq_set_callback_kfunc(insn->imm) ||
 					 is_task_work_add_kfunc(insn->imm));
 		if (!async_cb)
 			return -EFAULT;
@@ -12278,6 +12278,7 @@ enum special_kfunc_type {
 	KF___bpf_trap,
 	KF_bpf_task_work_schedule_signal,
 	KF_bpf_task_work_schedule_resume,
+	KF_bpf_wq_set_callback,
 };
 
 BTF_ID_LIST(special_kfunc_list)
@@ -12350,6 +12351,7 @@ BTF_ID(func, bpf_res_spin_unlock_irqrestore)
 BTF_ID(func, __bpf_trap)
 BTF_ID(func, bpf_task_work_schedule_signal)
 BTF_ID(func, bpf_task_work_schedule_resume)
+BTF_ID(func, bpf_wq_set_callback)
 
 static bool is_task_work_add_kfunc(u32 func_id)
 {
@@ -12797,7 +12799,7 @@ static bool is_sync_callback_calling_kfunc(u32 btf_id)
 
 static bool is_async_callback_calling_kfunc(u32 btf_id)
 {
-	return btf_id == special_kfunc_list[KF_bpf_wq_set_callback_impl] ||
+	return is_bpf_wq_set_callback_kfunc(btf_id) ||
 	       is_task_work_add_kfunc(btf_id);
 }
 
@@ -12807,9 +12809,10 @@ static bool is_bpf_throw_kfunc(struct bpf_insn *insn)
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
@@ -13910,7 +13913,7 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		meta.r0_rdonly = false;
 	}
 
-	if (is_bpf_wq_set_callback_impl_kfunc(meta.func_id)) {
+	if (is_bpf_wq_set_callback_kfunc(meta.func_id)) {
 		err = push_callback_call(env, insn, insn_idx, meta.subprogno,
 					 set_timer_callback_state);
 		if (err) {
diff --git a/tools/testing/selftests/bpf/progs/wq_failures.c b/tools/testing/selftests/bpf/progs/wq_failures.c
index 4240211a1900..9295b45ef27c 100644
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
2.51.0


