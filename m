Return-Path: <bpf+bounces-78360-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EDADDD0BF2B
	for <lists+bpf@lfdr.de>; Fri, 09 Jan 2026 19:53:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 395EC305BD75
	for <lists+bpf@lfdr.de>; Fri,  9 Jan 2026 18:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FF5835A95F;
	Fri,  9 Jan 2026 18:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cRifNxib"
X-Original-To: bpf@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E21A4359F90
	for <bpf@vger.kernel.org>; Fri,  9 Jan 2026 18:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767984599; cv=none; b=oYB/Ydz5YSjdsew7efGAwURJFxF8xmm9kyu6yFuVW8OvoSvdFSQKBNDtdQly51fmjK2tbJvoD8NPkYq7Q7pyfAqSGAQ7Rp9LI9Avyozcjjwy4G5opZft1tHpE5sO9+b2l6qGxvT8zEXgiz7MtVts26isoeLSTVAJ3r80rweckFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767984599; c=relaxed/simple;
	bh=fiJ9rd6WvKcP6+2cy8I7o6h4+CcN5GkWAjsDeIonhgQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tTqhitZu+TA5FGvCI0zWT6RJtlqiJuq+9xdE9XcT+VsffHaPuhNyYqhNlMm3Q81JAulpdQnhJnzqoCsG017KADlWQzCpJQIefTd7yqoZwLLydVpRuyDQ3Ur9zyex101B9Fte1HYPYKJFwBBvSca4fAelhbehLrlEisWQ3pGupvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cRifNxib; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767984596;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jn9G1JinSG/vVbDU2HnNOdG/7qIacDg3tfNKlgXJpk8=;
	b=cRifNxib19gNtyI7ZFo8YmnYP/A4+KKnTPX4SaXRZYuqDu/zNNA6rfW0q1BaWNH6k+f274
	HCzuIpuRzGV+w1MTw5lmVCA511lVg+Wr3r2mwn3/VacdNcFCik48cpaMdExkpLsWQQnFSh
	rZEPyu7L6CUFeS0Y415JAx5rEjpjytM=
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
Subject: [PATCH bpf-next v1 08/10] bpf: Add bpf_task_work_schedule_* kfuncs with KF_IMPLICIT_ARGS
Date: Fri,  9 Jan 2026 10:48:50 -0800
Message-ID: <20260109184852.1089786-9-ihor.solodrai@linux.dev>
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

Implement bpf_task_work_schedule_* with an implicit bpf_prog_aux
argument, and change corresponding _impl funcs to call the new kfunc.

Update special kfunc checks in the verifier to accept both new and old
variants of the functions.

Update the selftests to use the new API with implicit argument.

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 kernel/bpf/helpers.c                          | 28 +++++++++++++++----
 kernel/bpf/verifier.c                         |  8 +++++-
 .../testing/selftests/bpf/progs/file_reader.c |  4 ++-
 tools/testing/selftests/bpf/progs/task_work.c | 11 ++++++--
 .../selftests/bpf/progs/task_work_fail.c      | 16 ++++++++---
 .../selftests/bpf/progs/task_work_stress.c    |  5 ++--
 .../bpf/progs/verifier_async_cb_context.c     |  6 ++--
 7 files changed, 59 insertions(+), 19 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 23aa785c0f99..2e01973f2c18 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -4282,41 +4282,55 @@ static int bpf_task_work_schedule(struct task_struct *task, struct bpf_task_work
 }
 
 /**
- * bpf_task_work_schedule_signal_impl - Schedule BPF callback using task_work_add with TWA_SIGNAL
+ * bpf_task_work_schedule_signal - Schedule BPF callback using task_work_add with TWA_SIGNAL
  * mode
  * @task: Task struct for which callback should be scheduled
  * @tw: Pointer to struct bpf_task_work in BPF map value for internal bookkeeping
  * @map__map: bpf_map that embeds struct bpf_task_work in the values
  * @callback: pointer to BPF subprogram to call
- * @aux__prog: user should pass NULL
+ * @aux: pointer to bpf_prog_aux of the caller BPF program, implicitly set by the verifier
  *
  * Return: 0 if task work has been scheduled successfully, negative error code otherwise
  */
+__bpf_kfunc int bpf_task_work_schedule_signal(struct task_struct *task, struct bpf_task_work *tw,
+					      void *map__map, bpf_task_work_callback_t callback,
+					      struct bpf_prog_aux *aux)
+{
+	return bpf_task_work_schedule(task, tw, map__map, callback, aux, TWA_SIGNAL);
+}
+
 __bpf_kfunc int bpf_task_work_schedule_signal_impl(struct task_struct *task,
 						   struct bpf_task_work *tw, void *map__map,
 						   bpf_task_work_callback_t callback,
 						   void *aux__prog)
 {
-	return bpf_task_work_schedule(task, tw, map__map, callback, aux__prog, TWA_SIGNAL);
+	return bpf_task_work_schedule_signal(task, tw, map__map, callback, aux__prog);
 }
 
 /**
- * bpf_task_work_schedule_resume_impl - Schedule BPF callback using task_work_add with TWA_RESUME
+ * bpf_task_work_schedule_resume - Schedule BPF callback using task_work_add with TWA_RESUME
  * mode
  * @task: Task struct for which callback should be scheduled
  * @tw: Pointer to struct bpf_task_work in BPF map value for internal bookkeeping
  * @map__map: bpf_map that embeds struct bpf_task_work in the values
  * @callback: pointer to BPF subprogram to call
- * @aux__prog: user should pass NULL
+ * @aux: pointer to bpf_prog_aux of the caller BPF program, implicitly set by the verifier
  *
  * Return: 0 if task work has been scheduled successfully, negative error code otherwise
  */
+__bpf_kfunc int bpf_task_work_schedule_resume(struct task_struct *task, struct bpf_task_work *tw,
+					      void *map__map, bpf_task_work_callback_t callback,
+					      struct bpf_prog_aux *aux)
+{
+	return bpf_task_work_schedule(task, tw, map__map, callback, aux, TWA_RESUME);
+}
+
 __bpf_kfunc int bpf_task_work_schedule_resume_impl(struct task_struct *task,
 						   struct bpf_task_work *tw, void *map__map,
 						   bpf_task_work_callback_t callback,
 						   void *aux__prog)
 {
-	return bpf_task_work_schedule(task, tw, map__map, callback, aux__prog, TWA_RESUME);
+	return bpf_task_work_schedule_resume(task, tw, map__map, callback, aux__prog);
 }
 
 static int make_file_dynptr(struct file *file, u32 flags, bool may_sleep,
@@ -4545,7 +4559,9 @@ BTF_ID_FLAGS(func, bpf_strncasestr);
 BTF_ID_FLAGS(func, bpf_cgroup_read_xattr, KF_RCU)
 #endif
 BTF_ID_FLAGS(func, bpf_stream_vprintk_impl)
+BTF_ID_FLAGS(func, bpf_task_work_schedule_signal, KF_IMPLICIT_ARGS)
 BTF_ID_FLAGS(func, bpf_task_work_schedule_signal_impl)
+BTF_ID_FLAGS(func, bpf_task_work_schedule_resume, KF_IMPLICIT_ARGS)
 BTF_ID_FLAGS(func, bpf_task_work_schedule_resume_impl)
 BTF_ID_FLAGS(func, bpf_dynptr_from_file)
 BTF_ID_FLAGS(func, bpf_dynptr_file_discard)
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e5aeee554377..fdd17d19d5be 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12471,6 +12471,8 @@ enum special_kfunc_type {
 	KF_bpf_arena_free_pages,
 	KF_bpf_arena_reserve_pages,
 	KF_bpf_wq_set_callback,
+	KF_bpf_task_work_schedule_signal,
+	KF_bpf_task_work_schedule_resume,
 };
 
 BTF_ID_LIST(special_kfunc_list)
@@ -12549,10 +12551,14 @@ BTF_ID(func, bpf_arena_alloc_pages)
 BTF_ID(func, bpf_arena_free_pages)
 BTF_ID(func, bpf_arena_reserve_pages)
 BTF_ID(func, bpf_wq_set_callback)
+BTF_ID(func, bpf_task_work_schedule_signal)
+BTF_ID(func, bpf_task_work_schedule_resume)
 
 static bool is_task_work_add_kfunc(u32 func_id)
 {
-	return func_id == special_kfunc_list[KF_bpf_task_work_schedule_signal_impl] ||
+	return func_id == special_kfunc_list[KF_bpf_task_work_schedule_signal] ||
+	       func_id == special_kfunc_list[KF_bpf_task_work_schedule_signal_impl] ||
+	       func_id == special_kfunc_list[KF_bpf_task_work_schedule_resume] ||
 	       func_id == special_kfunc_list[KF_bpf_task_work_schedule_resume_impl];
 }
 
diff --git a/tools/testing/selftests/bpf/progs/file_reader.c b/tools/testing/selftests/bpf/progs/file_reader.c
index 4d756b623557..ff3270a0cb9b 100644
--- a/tools/testing/selftests/bpf/progs/file_reader.c
+++ b/tools/testing/selftests/bpf/progs/file_reader.c
@@ -77,7 +77,9 @@ int on_open_validate_file_read(void *c)
 		err = 1;
 		return 0;
 	}
-	bpf_task_work_schedule_signal_impl(task, &work->tw, &arrmap, task_work_callback, NULL);
+
+	bpf_task_work_schedule_signal(task, &work->tw, &arrmap, task_work_callback);
+
 	return 0;
 }
 
diff --git a/tools/testing/selftests/bpf/progs/task_work.c b/tools/testing/selftests/bpf/progs/task_work.c
index 663a80990f8f..eec422af20b8 100644
--- a/tools/testing/selftests/bpf/progs/task_work.c
+++ b/tools/testing/selftests/bpf/progs/task_work.c
@@ -66,7 +66,8 @@ int oncpu_hash_map(struct pt_regs *args)
 	if (!work)
 		return 0;
 
-	bpf_task_work_schedule_resume_impl(task, &work->tw, &hmap, process_work, NULL);
+	bpf_task_work_schedule_resume(task, &work->tw, &hmap, process_work);
+
 	return 0;
 }
 
@@ -80,7 +81,9 @@ int oncpu_array_map(struct pt_regs *args)
 	work = bpf_map_lookup_elem(&arrmap, &key);
 	if (!work)
 		return 0;
-	bpf_task_work_schedule_signal_impl(task, &work->tw, &arrmap, process_work, NULL);
+
+	bpf_task_work_schedule_signal(task, &work->tw, &arrmap, process_work);
+
 	return 0;
 }
 
@@ -102,6 +105,8 @@ int oncpu_lru_map(struct pt_regs *args)
 	work = bpf_map_lookup_elem(&lrumap, &key);
 	if (!work || work->data[0])
 		return 0;
-	bpf_task_work_schedule_resume_impl(task, &work->tw, &lrumap, process_work, NULL);
+
+	bpf_task_work_schedule_resume(task, &work->tw, &lrumap, process_work);
+
 	return 0;
 }
diff --git a/tools/testing/selftests/bpf/progs/task_work_fail.c b/tools/testing/selftests/bpf/progs/task_work_fail.c
index 1270953fd092..557bdf9eb0fc 100644
--- a/tools/testing/selftests/bpf/progs/task_work_fail.c
+++ b/tools/testing/selftests/bpf/progs/task_work_fail.c
@@ -53,7 +53,9 @@ int mismatch_map(struct pt_regs *args)
 	work = bpf_map_lookup_elem(&arrmap, &key);
 	if (!work)
 		return 0;
-	bpf_task_work_schedule_resume_impl(task, &work->tw, &hmap, process_work, NULL);
+
+	bpf_task_work_schedule_resume(task, &work->tw, &hmap, process_work);
+
 	return 0;
 }
 
@@ -65,7 +67,9 @@ int no_map_task_work(struct pt_regs *args)
 	struct bpf_task_work tw;
 
 	task = bpf_get_current_task_btf();
-	bpf_task_work_schedule_resume_impl(task, &tw, &hmap, process_work, NULL);
+
+	bpf_task_work_schedule_resume(task, &tw, &hmap, process_work);
+
 	return 0;
 }
 
@@ -76,7 +80,9 @@ int task_work_null(struct pt_regs *args)
 	struct task_struct *task;
 
 	task = bpf_get_current_task_btf();
-	bpf_task_work_schedule_resume_impl(task, NULL, &hmap, process_work, NULL);
+
+	bpf_task_work_schedule_resume(task, NULL, &hmap, process_work);
+
 	return 0;
 }
 
@@ -91,6 +97,8 @@ int map_null(struct pt_regs *args)
 	work = bpf_map_lookup_elem(&arrmap, &key);
 	if (!work)
 		return 0;
-	bpf_task_work_schedule_resume_impl(task, &work->tw, NULL, process_work, NULL);
+
+	bpf_task_work_schedule_resume(task, &work->tw, NULL, process_work);
+
 	return 0;
 }
diff --git a/tools/testing/selftests/bpf/progs/task_work_stress.c b/tools/testing/selftests/bpf/progs/task_work_stress.c
index 55e555f7f41b..0cba36569714 100644
--- a/tools/testing/selftests/bpf/progs/task_work_stress.c
+++ b/tools/testing/selftests/bpf/progs/task_work_stress.c
@@ -51,8 +51,9 @@ int schedule_task_work(void *ctx)
 		if (!work)
 			return 0;
 	}
-	err = bpf_task_work_schedule_signal_impl(bpf_get_current_task_btf(), &work->tw, &hmap,
-						 process_work, NULL);
+	err = bpf_task_work_schedule_signal(bpf_get_current_task_btf(), &work->tw, &hmap,
+					    process_work);
+
 	if (err)
 		__sync_fetch_and_add(&schedule_error, 1);
 	else
diff --git a/tools/testing/selftests/bpf/progs/verifier_async_cb_context.c b/tools/testing/selftests/bpf/progs/verifier_async_cb_context.c
index 7efa9521105e..6c50aff03baa 100644
--- a/tools/testing/selftests/bpf/progs/verifier_async_cb_context.c
+++ b/tools/testing/selftests/bpf/progs/verifier_async_cb_context.c
@@ -156,7 +156,8 @@ int task_work_non_sleepable_prog(void *ctx)
 	if (!task)
 		return 0;
 
-	bpf_task_work_schedule_resume_impl(task, &val->tw, &task_work_map, task_work_cb, NULL);
+	bpf_task_work_schedule_resume(task, &val->tw, &task_work_map, task_work_cb);
+
 	return 0;
 }
 
@@ -176,6 +177,7 @@ int task_work_sleepable_prog(void *ctx)
 	if (!task)
 		return 0;
 
-	bpf_task_work_schedule_resume_impl(task, &val->tw, &task_work_map, task_work_cb, NULL);
+	bpf_task_work_schedule_resume(task, &val->tw, &task_work_map, task_work_cb);
+
 	return 0;
 }
-- 
2.52.0


