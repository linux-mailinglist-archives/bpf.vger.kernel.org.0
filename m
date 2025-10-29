Return-Path: <bpf+bounces-72861-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8E37C1CDD9
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 20:02:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25614560E42
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 19:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B23182F12CC;
	Wed, 29 Oct 2025 19:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="d85aZV3L"
X-Original-To: bpf@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BBFF325709
	for <bpf@vger.kernel.org>; Wed, 29 Oct 2025 19:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761764524; cv=none; b=R4lwbd7GoQFJmRE42ICX+pO+YQW8NoLQm8DHmLzbwYhNU2CnILzSf6pDcP7FQQg1vNVbi41gnoduRlbdJIwitPltyEi/IPgR/59wvN2vXDzPXMmrSgl5YISaa+78wZgA5LIaCj5B7yUpXrL4tFJ96sUvTcwuDf4PQZvpgOiKynU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761764524; c=relaxed/simple;
	bh=Hd676TlQdwehb/gTrdUSB9GQuLB4ej5jvXK5Jo/Sbso=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GUuRB4FkADBQny33kZFC+uhFC4kMU9HFM5jFkew00PITgmcHn1eBriihoYHCIa7tmWKqUqCM2EPR2dWT3cJ4FOrVl5Kg+tM2cUsuv+YeF+QxvgChHnkhOE1bzpTE1gxC7IALqm5ncSF5MzCTBZXWtzDNrnXUlpCqvV3TQi0L2BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=d85aZV3L; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761764520;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KFZUYzik9NsJav+PSl1oQake0/BT4mHwFqQ3V86Cgjs=;
	b=d85aZV3L8Sh7h8W569TBoIDe3jrugdQqmXAX4MEFYIM3VaLCfme3df7oQpIvjeQS5yjsj+
	EmjdN4VaTIQ0mF78cGZU72BH87+yoSulFeupcNS2nmy6Aj92YjaL06a8388qr294eFGwvy
	yAqhPyr9TDXz5NM0GcMPZjbDV96Lx/Q=
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
Subject: [PATCH bpf-next v1 7/8] bpf: Re-define bpf_task_work_schedule_* kfuncs as magic
Date: Wed, 29 Oct 2025 12:01:12 -0700
Message-ID: <20251029190113.3323406-8-ihor.solodrai@linux.dev>
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

* void *aux__prog => struct bpf_prog_aux *aux__magic
* Set KF_MAGIC_ARGS flag
* Add relevant symbols to magic_kfuncs list
* Update selftests to use the new signature

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 kernel/bpf/helpers.c                             | 16 ++++++++--------
 kernel/bpf/verifier.c                            | 12 +++++++++++-
 tools/testing/selftests/bpf/progs/file_reader.c  |  2 +-
 tools/testing/selftests/bpf/progs/task_work.c    |  6 +++---
 .../testing/selftests/bpf/progs/task_work_fail.c |  8 ++++----
 .../selftests/bpf/progs/task_work_stress.c       |  2 +-
 .../bpf/progs/verifier_async_cb_context.c        |  4 ++--
 7 files changed, 30 insertions(+), 20 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index ee56f74f70c1..6a095796433a 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -4278,15 +4278,15 @@ static int bpf_task_work_schedule(struct task_struct *task, struct bpf_task_work
  * @tw: Pointer to struct bpf_task_work in BPF map value for internal bookkeeping
  * @map__map: bpf_map that embeds struct bpf_task_work in the values
  * @callback: pointer to BPF subprogram to call
- * @aux__prog: user should pass NULL
+ * @aux__magic: pointer to bpf_prog_aux of the caller BPF program, set by the verifier
  *
  * Return: 0 if task work has been scheduled successfully, negative error code otherwise
  */
 __bpf_kfunc int bpf_task_work_schedule_signal(struct task_struct *task, struct bpf_task_work *tw,
 					      void *map__map, bpf_task_work_callback_t callback,
-					      void *aux__prog)
+					      struct bpf_prog_aux *aux__magic)
 {
-	return bpf_task_work_schedule(task, tw, map__map, callback, aux__prog, TWA_SIGNAL);
+	return bpf_task_work_schedule(task, tw, map__map, callback, aux__magic, TWA_SIGNAL);
 }
 
 /**
@@ -4295,15 +4295,15 @@ __bpf_kfunc int bpf_task_work_schedule_signal(struct task_struct *task, struct b
  * @tw: Pointer to struct bpf_task_work in BPF map value for internal bookkeeping
  * @map__map: bpf_map that embeds struct bpf_task_work in the values
  * @callback: pointer to BPF subprogram to call
- * @aux__prog: user should pass NULL
+ * @aux__magic: pointer to bpf_prog_aux of the caller BPF program, set by the verifier
  *
  * Return: 0 if task work has been scheduled successfully, negative error code otherwise
  */
 __bpf_kfunc int bpf_task_work_schedule_resume(struct task_struct *task, struct bpf_task_work *tw,
 					      void *map__map, bpf_task_work_callback_t callback,
-					      void *aux__prog)
+					      struct bpf_prog_aux *aux__magic)
 {
-	return bpf_task_work_schedule(task, tw, map__map, callback, aux__prog, TWA_RESUME);
+	return bpf_task_work_schedule(task, tw, map__map, callback, aux__magic, TWA_RESUME);
 }
 
 static int make_file_dynptr(struct file *file, u32 flags, bool may_sleep,
@@ -4529,8 +4529,8 @@ BTF_ID_FLAGS(func, bpf_strncasestr);
 BTF_ID_FLAGS(func, bpf_cgroup_read_xattr, KF_RCU)
 #endif
 BTF_ID_FLAGS(func, bpf_stream_vprintk, KF_TRUSTED_ARGS)
-BTF_ID_FLAGS(func, bpf_task_work_schedule_signal, KF_TRUSTED_ARGS)
-BTF_ID_FLAGS(func, bpf_task_work_schedule_resume, KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_task_work_schedule_signal, KF_MAGIC_ARGS | KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_task_work_schedule_resume, KF_MAGIC_ARGS | KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, bpf_dynptr_from_file, KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, bpf_dynptr_file_discard)
 BTF_KFUNCS_END(common_btf_ids)
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 3c9e963d879b..ad4af5ddb523 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3269,6 +3269,10 @@ static struct btf *find_kfunc_desc_btf(struct bpf_verifier_env *env, s16 offset)
 BTF_ID_LIST(magic_kfuncs)
 BTF_ID(func, bpf_wq_set_callback)
 BTF_ID(func, bpf_wq_set_callback_impl)
+BTF_ID(func, bpf_task_work_schedule_signal)
+BTF_ID(func, bpf_task_work_schedule_signal_impl)
+BTF_ID(func, bpf_task_work_schedule_resume)
+BTF_ID(func, bpf_task_work_schedule_resume_impl)
 BTF_ID_LIST_END(magic_kfuncs)
 
 static s32 magic_kfunc_by_impl(s32 impl_func_id)
@@ -12387,6 +12391,8 @@ enum special_kfunc_type {
 	KF_bpf_task_work_schedule_signal,
 	KF_bpf_task_work_schedule_resume,
 	KF_bpf_wq_set_callback,
+	KF_bpf_task_work_schedule_signal_impl,
+	KF_bpf_task_work_schedule_resume_impl,
 };
 
 BTF_ID_LIST(special_kfunc_list)
@@ -12462,11 +12468,15 @@ BTF_ID(func, __bpf_trap)
 BTF_ID(func, bpf_task_work_schedule_signal)
 BTF_ID(func, bpf_task_work_schedule_resume)
 BTF_ID(func, bpf_wq_set_callback)
+BTF_ID(func, bpf_task_work_schedule_signal_impl)
+BTF_ID(func, bpf_task_work_schedule_resume_impl)
 
 static bool is_task_work_add_kfunc(u32 func_id)
 {
 	return func_id == special_kfunc_list[KF_bpf_task_work_schedule_signal] ||
-	       func_id == special_kfunc_list[KF_bpf_task_work_schedule_resume];
+	       func_id == special_kfunc_list[KF_bpf_task_work_schedule_signal_impl] ||
+	       func_id == special_kfunc_list[KF_bpf_task_work_schedule_resume] ||
+	       func_id == special_kfunc_list[KF_bpf_task_work_schedule_resume_impl];
 }
 
 static bool is_kfunc_ret_null(struct bpf_kfunc_call_arg_meta *meta)
diff --git a/tools/testing/selftests/bpf/progs/file_reader.c b/tools/testing/selftests/bpf/progs/file_reader.c
index 2585f83b0ce5..eb8bdc51973d 100644
--- a/tools/testing/selftests/bpf/progs/file_reader.c
+++ b/tools/testing/selftests/bpf/progs/file_reader.c
@@ -77,7 +77,7 @@ int on_open_validate_file_read(void *c)
 		err = 1;
 		return 0;
 	}
-	bpf_task_work_schedule_signal(task, &work->tw, &arrmap, task_work_callback, NULL);
+	bpf_task_work_schedule_signal(task, &work->tw, &arrmap, task_work_callback);
 	return 0;
 }
 
diff --git a/tools/testing/selftests/bpf/progs/task_work.c b/tools/testing/selftests/bpf/progs/task_work.c
index 23217f06a3ec..eedd5c3dabb4 100644
--- a/tools/testing/selftests/bpf/progs/task_work.c
+++ b/tools/testing/selftests/bpf/progs/task_work.c
@@ -66,7 +66,7 @@ int oncpu_hash_map(struct pt_regs *args)
 	if (!work)
 		return 0;
 
-	bpf_task_work_schedule_resume(task, &work->tw, &hmap, process_work, NULL);
+	bpf_task_work_schedule_resume(task, &work->tw, &hmap, process_work);
 	return 0;
 }
 
@@ -80,7 +80,7 @@ int oncpu_array_map(struct pt_regs *args)
 	work = bpf_map_lookup_elem(&arrmap, &key);
 	if (!work)
 		return 0;
-	bpf_task_work_schedule_signal(task, &work->tw, &arrmap, process_work, NULL);
+	bpf_task_work_schedule_signal(task, &work->tw, &arrmap, process_work);
 	return 0;
 }
 
@@ -102,6 +102,6 @@ int oncpu_lru_map(struct pt_regs *args)
 	work = bpf_map_lookup_elem(&lrumap, &key);
 	if (!work || work->data[0])
 		return 0;
-	bpf_task_work_schedule_resume(task, &work->tw, &lrumap, process_work, NULL);
+	bpf_task_work_schedule_resume(task, &work->tw, &lrumap, process_work);
 	return 0;
 }
diff --git a/tools/testing/selftests/bpf/progs/task_work_fail.c b/tools/testing/selftests/bpf/progs/task_work_fail.c
index 77fe8f28facd..82e4b8913333 100644
--- a/tools/testing/selftests/bpf/progs/task_work_fail.c
+++ b/tools/testing/selftests/bpf/progs/task_work_fail.c
@@ -53,7 +53,7 @@ int mismatch_map(struct pt_regs *args)
 	work = bpf_map_lookup_elem(&arrmap, &key);
 	if (!work)
 		return 0;
-	bpf_task_work_schedule_resume(task, &work->tw, &hmap, process_work, NULL);
+	bpf_task_work_schedule_resume(task, &work->tw, &hmap, process_work);
 	return 0;
 }
 
@@ -65,7 +65,7 @@ int no_map_task_work(struct pt_regs *args)
 	struct bpf_task_work tw;
 
 	task = bpf_get_current_task_btf();
-	bpf_task_work_schedule_resume(task, &tw, &hmap, process_work, NULL);
+	bpf_task_work_schedule_resume(task, &tw, &hmap, process_work);
 	return 0;
 }
 
@@ -76,7 +76,7 @@ int task_work_null(struct pt_regs *args)
 	struct task_struct *task;
 
 	task = bpf_get_current_task_btf();
-	bpf_task_work_schedule_resume(task, NULL, &hmap, process_work, NULL);
+	bpf_task_work_schedule_resume(task, NULL, &hmap, process_work);
 	return 0;
 }
 
@@ -91,6 +91,6 @@ int map_null(struct pt_regs *args)
 	work = bpf_map_lookup_elem(&arrmap, &key);
 	if (!work)
 		return 0;
-	bpf_task_work_schedule_resume(task, &work->tw, NULL, process_work, NULL);
+	bpf_task_work_schedule_resume(task, &work->tw, NULL, process_work);
 	return 0;
 }
diff --git a/tools/testing/selftests/bpf/progs/task_work_stress.c b/tools/testing/selftests/bpf/progs/task_work_stress.c
index 90fca06fff56..1d4378f351ef 100644
--- a/tools/testing/selftests/bpf/progs/task_work_stress.c
+++ b/tools/testing/selftests/bpf/progs/task_work_stress.c
@@ -52,7 +52,7 @@ int schedule_task_work(void *ctx)
 			return 0;
 	}
 	err = bpf_task_work_schedule_signal(bpf_get_current_task_btf(), &work->tw, &hmap,
-					    process_work, NULL);
+					    process_work);
 	if (err)
 		__sync_fetch_and_add(&schedule_error, 1);
 	else
diff --git a/tools/testing/selftests/bpf/progs/verifier_async_cb_context.c b/tools/testing/selftests/bpf/progs/verifier_async_cb_context.c
index 96ff6749168b..a8696eb1febb 100644
--- a/tools/testing/selftests/bpf/progs/verifier_async_cb_context.c
+++ b/tools/testing/selftests/bpf/progs/verifier_async_cb_context.c
@@ -156,7 +156,7 @@ int task_work_non_sleepable_prog(void *ctx)
 	if (!task)
 		return 0;
 
-	bpf_task_work_schedule_resume(task, &val->tw, &task_work_map, task_work_cb, NULL);
+	bpf_task_work_schedule_resume(task, &val->tw, &task_work_map, task_work_cb);
 	return 0;
 }
 
@@ -176,6 +176,6 @@ int task_work_sleepable_prog(void *ctx)
 	if (!task)
 		return 0;
 
-	bpf_task_work_schedule_resume(task, &val->tw, &task_work_map, task_work_cb, NULL);
+	bpf_task_work_schedule_resume(task, &val->tw, &task_work_map, task_work_cb);
 	return 0;
 }
-- 
2.51.1


