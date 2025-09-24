Return-Path: <bpf+bounces-69627-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA2CAB9C42C
	for <lists+bpf@lfdr.de>; Wed, 24 Sep 2025 23:18:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A88EB1BC3696
	for <lists+bpf@lfdr.de>; Wed, 24 Sep 2025 21:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23296287505;
	Wed, 24 Sep 2025 21:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="f61xoIjz"
X-Original-To: bpf@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06AD2853EE
	for <bpf@vger.kernel.org>; Wed, 24 Sep 2025 21:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758748677; cv=none; b=jKnHWj+1WR296cqlbDsT0x0avKz5gtxN4PjarFMOSjAf3Oz7UFzHLLadMytg5oPfM+3eHwR4aUoFChQzJWN2D/fw7TxkZqIB+B4RMlMPgkQMvnZD076Ndgq3rjWFPtTCs4Zcu9w0CVCFL/i7bWOPu9wFfDERNzWs/KiTnU6KYgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758748677; c=relaxed/simple;
	bh=G8LdN2z7wbf1vloFox/XmjpFK9SM2+QRCs8UPp2AkQA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UtvrWqrz8dfFCXCVegiIytKU1mmbkyMWtou1YcP7t0nqh+ztWJuuw8TIWSBYN/A087gGw7vh9Tkn6NIQ93dgFCRxLeujo5o2GXYfvBE8uGJJKklHSR9xDToAZvFuxh9dm9OshDJY7tF9/gLIBC9YomSTQtIORCU7nc4E68FtPVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=f61xoIjz; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758748674;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Uct836lYuqfFRLfHtAOH7TZRq2jsbdOM1nGFgj8QNXA=;
	b=f61xoIjzr+Sv6SVfmAy8xMbTILiphPOiR8pWVQSp7lJr1NdnL8J7DOVoFhoQEdOC0lVswD
	jwuqtdLfa1GxU9b+MStwA2kc+0ZW/nmlUDvJqD+O7fn5xf75G/vrHBjCs73rHHSn3FyYmw
	c9iU0pogX67SZR8R9gL7LRivxhneLhU=
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
Subject: [PATCH bpf-next v1 6/6] bpf: mark bpf_task_work_* kfuncs with KF_IMPLICIT_PROG_AUX_ARG
Date: Wed, 24 Sep 2025 14:17:16 -0700
Message-ID: <20250924211716.1287715-7-ihor.solodrai@linux.dev>
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

Two kfuncs that use aux__prog argument were recently added [1]:
  * bpf_task_work_schedule_resume
  * bpf_task_work_schedule_signal

Update them to use the new kfunc flag and fix usages in the selftests.

[1] https://lore.kernel.org/bpf/20250923112404.668720-1-mykyta.yatsenko5@gmail.com/

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 kernel/bpf/helpers.c                             | 16 ++++++++--------
 tools/testing/selftests/bpf/progs/task_work.c    |  6 +++---
 .../testing/selftests/bpf/progs/task_work_fail.c |  8 ++++----
 .../selftests/bpf/progs/task_work_stress.c       |  2 +-
 4 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 875195a0ea72..ccdc204a66cf 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -4178,15 +4178,15 @@ static int bpf_task_work_schedule(struct task_struct *task, struct bpf_task_work
  * @tw: Pointer to struct bpf_task_work in BPF map value for internal bookkeeping
  * @map__map: bpf_map that embeds struct bpf_task_work in the values
  * @callback: pointer to BPF subprogram to call
- * @aux__prog: user should pass NULL
+ * @aux: pointer to bpf_prog_aux of the caller BPF program, implicitly set by the verifier
  *
  * Return: 0 if task work has been scheduled successfully, negative error code otherwise
  */
 __bpf_kfunc int bpf_task_work_schedule_signal(struct task_struct *task, struct bpf_task_work *tw,
 					      void *map__map, bpf_task_work_callback_t callback,
-					      void *aux__prog)
+					      struct bpf_prog_aux *aux)
 {
-	return bpf_task_work_schedule(task, tw, map__map, callback, aux__prog, TWA_SIGNAL);
+	return bpf_task_work_schedule(task, tw, map__map, callback, aux, TWA_SIGNAL);
 }
 
 /**
@@ -4195,15 +4195,15 @@ __bpf_kfunc int bpf_task_work_schedule_signal(struct task_struct *task, struct b
  * @tw: Pointer to struct bpf_task_work in BPF map value for internal bookkeeping
  * @map__map: bpf_map that embeds struct bpf_task_work in the values
  * @callback: pointer to BPF subprogram to call
- * @aux__prog: user should pass NULL
+ * @aux: pointer to bpf_prog_aux of the caller BPF program, implicitly set by the verifier
  *
  * Return: 0 if task work has been scheduled successfully, negative error code otherwise
  */
 __bpf_kfunc int bpf_task_work_schedule_resume(struct task_struct *task, struct bpf_task_work *tw,
 					      void *map__map, bpf_task_work_callback_t callback,
-					      void *aux__prog)
+					      struct bpf_prog_aux *aux)
 {
-	return bpf_task_work_schedule(task, tw, map__map, callback, aux__prog, TWA_RESUME);
+	return bpf_task_work_schedule(task, tw, map__map, callback, aux, TWA_RESUME);
 }
 
 __bpf_kfunc_end_defs();
@@ -4379,8 +4379,8 @@ BTF_ID_FLAGS(func, bpf_strnstr);
 BTF_ID_FLAGS(func, bpf_cgroup_read_xattr, KF_RCU)
 #endif
 BTF_ID_FLAGS(func, bpf_stream_vprintk, KF_TRUSTED_ARGS | KF_IMPLICIT_PROG_AUX_ARG)
-BTF_ID_FLAGS(func, bpf_task_work_schedule_signal, KF_TRUSTED_ARGS)
-BTF_ID_FLAGS(func, bpf_task_work_schedule_resume, KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_task_work_schedule_signal, KF_TRUSTED_ARGS | KF_IMPLICIT_PROG_AUX_ARG)
+BTF_ID_FLAGS(func, bpf_task_work_schedule_resume, KF_TRUSTED_ARGS | KF_IMPLICIT_PROG_AUX_ARG)
 BTF_ID_FLAGS(func, bpf_wq_set_callback, KF_IMPLICIT_PROG_AUX_ARG)
 BTF_KFUNCS_END(common_btf_ids)
 
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
-- 
2.51.0


