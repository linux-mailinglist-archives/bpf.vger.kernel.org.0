Return-Path: <bpf+bounces-77014-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 06655CCD127
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 19:02:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 85B5D30AB7E5
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 17:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D2463090FA;
	Thu, 18 Dec 2025 17:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FOxs3CaO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1BFA303C97
	for <bpf@vger.kernel.org>; Thu, 18 Dec 2025 17:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766080601; cv=none; b=cNNT6fVd7sNziijzpteStXkM+ggyHMrSS4nqq3Fzur7mg3Q/itj/0MO0dbfz+6zJJ/nScmH2DediL+Jdov+epV9bxRxm4zM8jfRPSCkbBWfslCnDiKZqu8WeqZUeOup5cIV6x1ogAMeNoWsMreEGcWi34wbGNgI7wU+wLPjxB+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766080601; c=relaxed/simple;
	bh=08RUhYnAjLBqIcM08mcUF3dkyUpCJME0iR282sVf67M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KA2EH47sTzIL87mbp9zwCsmVQ4SrQPjfsS164QtGRPuA8DzzrhYg+njIG2UZzjdHyBMrla6HwskxZgepfPuGT6B+BJjK2IAvveH1ZaOxkK92v/j2/7fkx100l5HunJKn1inHvG1ldMofv9Y2NZc7yGwYis4obE4nCXPFh5N4DZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FOxs3CaO; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-34aa62f9e74so1155883a91.1
        for <bpf@vger.kernel.org>; Thu, 18 Dec 2025 09:56:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766080598; x=1766685398; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=th1N9o4rygkfwtZW+phQ3aKaCx+hkJcyHDT4emJuu5U=;
        b=FOxs3CaOmQ4eFEpVDJEPTiEGVB7tAZof/0VgB5yTJa3GyhsExDno0C7knV0MbVIiwt
         U8gMkUiWATxZV8kvcI/C/LxIQL1O/E2+E8tIL8AGPupHLFf5jNVsPAkwb9wBwtlJcGge
         sq4yrgMp9i8rURLUSuiAP5FMmR1ylba6OLobpxfBOCz2KkAHZegSKrOg4A9zXyvGAZvo
         8PEznAVs1XW1rPu/9L7Pocd5OdYDE1KzbHBaL4pmjMeXKCxjsE6NPI3yVhkx1vNS52j8
         jKqOd4JRXEewkeBiVTz9SEF9sPRyEoT/wD618M6H/Uu2fdSTUR5jsc5oWlzNgJTAjcC9
         AQ4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766080598; x=1766685398;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=th1N9o4rygkfwtZW+phQ3aKaCx+hkJcyHDT4emJuu5U=;
        b=Uyjp1nvw7Xjbud3mIoRiwxVQZhUm0lv/cQrYxLSg/XOgqCpVf5IclbzUqZ3bfJbgoq
         geBJVGQ8EbTGRqDgGPfwLUeKpic4Nd+le2uEig5zVa26bV9XcizqCuX3fzP/d9Du6uYp
         0nqXNTXK7+hfBzdOB1BMUS/ZTvkhugsOL/02uwewUUzGODQ9WR3tvL7CF0my7YJR6d8L
         ezKt5k3z5zK6dhhfFU9iaanejmYQAfvXEslWWsVYW5fjcyxTmzc4+HD1bVS0Do/Zhliu
         4j1e0CSiJaUvLRl0T2a+bzY612ahN7UEu+mgdEzVbSMM5bBA4ZQTeuIujEHjTQDghyK8
         +KTQ==
X-Gm-Message-State: AOJu0Yw+pFpaSTIBLtf/OmvI8b49Ads4XotYp/AkKtRVdzyaZQO9uyQp
	CX/wYwWCRGEeIdWwQN9FMUpBMXE1663kHHIYr1IFJHwpk/H53Q6iqITJ6GcvYg==
X-Gm-Gg: AY/fxX6Ts2fMSxhRhyixi5WrUylVB2r0tiV721sah07qISbRwKOhGZoNihJkOGFahNY
	kKbqNkKXIevQeNRjxHWt1pZIS4D5Xui75Cfxpf6vKeayNKyNyg+8x58cnFU8SdvA/IFkTFowizg
	sOwvr2z5Ne39qd5ZX6/bNmXfphUiWTBGmWbgc4+IZ/G4vZ4LvPN8bkMX7VVcv06I687zlutDMGd
	gXHUBKxbAO8i64hJDDy8CKEljP7jH0Ddom8bCBqF04HLqlPnSIPLq2lypLUj0XVAg1LxeYgyfTO
	3rUookOG4m2BvxGVpvabiD6YqLI7CB7o00aTpSbaE14cHAKbozCfrNc9Wcrp/5Xuty/D7xm63CZ
	/GRvHoaNEru+n8bM2boQCdIMo/UMjUtT/+3Y0e7Imptn/U9LHSui9hBmgdWpzOM96D4wXFIGi11
	afPq6QOZKk0piEPsM=
X-Google-Smtp-Source: AGHT+IGkmTUwV9iC0Z7ooiTR1sww1bYuHPjBR67hQB8L3vMw+RZqcsZHpE8gMQg/6GgKA2Xh2wSy1Q==
X-Received: by 2002:a17:90b:4c46:b0:347:5ddd:b2d1 with SMTP id 98e67ed59e1d1-34e921ccb5cmr160483a91.27.1766080597818;
        Thu, 18 Dec 2025 09:56:37 -0800 (PST)
Received: from localhost ([2a03:2880:ff:5f::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34e921b06besm80535a91.5.2025.12.18.09.56.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 09:56:37 -0800 (PST)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	memxor@gmail.com,
	martin.lau@kernel.org,
	kpsingh@kernel.org,
	yonghong.song@linux.dev,
	song@kernel.org,
	haoluo@google.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 06/16] bpf: Remove task local storage percpu counter
Date: Thu, 18 Dec 2025 09:56:16 -0800
Message-ID: <20251218175628.1460321-7-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251218175628.1460321-1-ameryhung@gmail.com>
References: <20251218175628.1460321-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The percpu counter in task local storage is no longer needed as the
underlying bpf_local_storage can now handle deadlock with the help of
rqspinlock. Remove the percpu counter and related migrate_{disable,
enable}.

Since the percpu counter is removed, merge back bpf_task_storage_get()
and bpf_task_storage_get_recur(). This will allow the bpf syscalls and
helpers to run concurrently on the same CPU, removing the spurious
-EBUSY error. bpf_task_storage_get(..., F_CREATE) will now always
succeed with enough free memory unless being called recursively.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/bpf_task_storage.c | 150 ++++------------------------------
 kernel/bpf/helpers.c          |   4 -
 2 files changed, 18 insertions(+), 136 deletions(-)

diff --git a/kernel/bpf/bpf_task_storage.c b/kernel/bpf/bpf_task_storage.c
index ab902364ac23..dd858226ada2 100644
--- a/kernel/bpf/bpf_task_storage.c
+++ b/kernel/bpf/bpf_task_storage.c
@@ -20,29 +20,6 @@
 
 DEFINE_BPF_STORAGE_CACHE(task_cache);
 
-static DEFINE_PER_CPU(int, bpf_task_storage_busy);
-
-static void bpf_task_storage_lock(void)
-{
-	cant_migrate();
-	this_cpu_inc(bpf_task_storage_busy);
-}
-
-static void bpf_task_storage_unlock(void)
-{
-	this_cpu_dec(bpf_task_storage_busy);
-}
-
-static bool bpf_task_storage_trylock(void)
-{
-	cant_migrate();
-	if (unlikely(this_cpu_inc_return(bpf_task_storage_busy) != 1)) {
-		this_cpu_dec(bpf_task_storage_busy);
-		return false;
-	}
-	return true;
-}
-
 static struct bpf_local_storage __rcu **task_storage_ptr(void *owner)
 {
 	struct task_struct *task = owner;
@@ -70,17 +47,15 @@ void bpf_task_storage_free(struct task_struct *task)
 {
 	struct bpf_local_storage *local_storage;
 
-	rcu_read_lock_dont_migrate();
+	rcu_read_lock();
 
 	local_storage = rcu_dereference(task->bpf_storage);
 	if (!local_storage)
 		goto out;
 
-	bpf_task_storage_lock();
 	bpf_local_storage_destroy(local_storage);
-	bpf_task_storage_unlock();
 out:
-	rcu_read_unlock_migrate();
+	rcu_read_unlock();
 }
 
 static void *bpf_pid_task_storage_lookup_elem(struct bpf_map *map, void *key)
@@ -106,9 +81,7 @@ static void *bpf_pid_task_storage_lookup_elem(struct bpf_map *map, void *key)
 		goto out;
 	}
 
-	bpf_task_storage_lock();
 	sdata = task_storage_lookup(task, map, true);
-	bpf_task_storage_unlock();
 	put_pid(pid);
 	return sdata ? sdata->data : NULL;
 out:
@@ -143,11 +116,9 @@ static long bpf_pid_task_storage_update_elem(struct bpf_map *map, void *key,
 		goto out;
 	}
 
-	bpf_task_storage_lock();
 	sdata = bpf_local_storage_update(
 		task, (struct bpf_local_storage_map *)map, value, map_flags,
 		true, GFP_ATOMIC);
-	bpf_task_storage_unlock();
 
 	err = PTR_ERR_OR_ZERO(sdata);
 out:
@@ -155,8 +126,7 @@ static long bpf_pid_task_storage_update_elem(struct bpf_map *map, void *key,
 	return err;
 }
 
-static int task_storage_delete(struct task_struct *task, struct bpf_map *map,
-			       bool nobusy)
+static int task_storage_delete(struct task_struct *task, struct bpf_map *map)
 {
 	struct bpf_local_storage_data *sdata;
 
@@ -164,9 +134,6 @@ static int task_storage_delete(struct task_struct *task, struct bpf_map *map,
 	if (!sdata)
 		return -ENOENT;
 
-	if (!nobusy)
-		return -EBUSY;
-
 	return bpf_selem_unlink(SELEM(sdata), false);
 }
 
@@ -192,111 +159,50 @@ static long bpf_pid_task_storage_delete_elem(struct bpf_map *map, void *key)
 		goto out;
 	}
 
-	bpf_task_storage_lock();
-	err = task_storage_delete(task, map, true);
-	bpf_task_storage_unlock();
+	err = task_storage_delete(task, map);
 out:
 	put_pid(pid);
 	return err;
 }
 
-/* Called by bpf_task_storage_get*() helpers */
-static void *__bpf_task_storage_get(struct bpf_map *map,
-				    struct task_struct *task, void *value,
-				    u64 flags, gfp_t gfp_flags, bool nobusy)
+/* *gfp_flags* is a hidden argument provided by the verifier */
+BPF_CALL_5(bpf_task_storage_get, struct bpf_map *, map, struct task_struct *,
+	   task, void *, value, u64, flags, gfp_t, gfp_flags)
 {
 	struct bpf_local_storage_data *sdata;
 
-	sdata = task_storage_lookup(task, map, nobusy);
+	WARN_ON_ONCE(!bpf_rcu_lock_held());
+	if (flags & ~BPF_LOCAL_STORAGE_GET_F_CREATE || !task)
+		return (unsigned long)NULL;
+
+	sdata = task_storage_lookup(task, map, true);
 	if (sdata)
-		return sdata->data;
+		return (unsigned long)sdata->data;
 
 	/* only allocate new storage, when the task is refcounted */
 	if (refcount_read(&task->usage) &&
-	    (flags & BPF_LOCAL_STORAGE_GET_F_CREATE) && nobusy) {
+	    (flags & BPF_LOCAL_STORAGE_GET_F_CREATE)) {
 		sdata = bpf_local_storage_update(
 			task, (struct bpf_local_storage_map *)map, value,
 			BPF_NOEXIST, false, gfp_flags);
-		return IS_ERR(sdata) ? NULL : sdata->data;
+		return IS_ERR(sdata) ? (unsigned long)NULL : (unsigned long)sdata->data;
 	}
 
-	return NULL;
-}
-
-/* *gfp_flags* is a hidden argument provided by the verifier */
-BPF_CALL_5(bpf_task_storage_get_recur, struct bpf_map *, map, struct task_struct *,
-	   task, void *, value, u64, flags, gfp_t, gfp_flags)
-{
-	bool nobusy;
-	void *data;
-
-	WARN_ON_ONCE(!bpf_rcu_lock_held());
-	if (flags & ~BPF_LOCAL_STORAGE_GET_F_CREATE || !task)
-		return (unsigned long)NULL;
-
-	nobusy = bpf_task_storage_trylock();
-	data = __bpf_task_storage_get(map, task, value, flags,
-				      gfp_flags, nobusy);
-	if (nobusy)
-		bpf_task_storage_unlock();
-	return (unsigned long)data;
-}
-
-/* *gfp_flags* is a hidden argument provided by the verifier */
-BPF_CALL_5(bpf_task_storage_get, struct bpf_map *, map, struct task_struct *,
-	   task, void *, value, u64, flags, gfp_t, gfp_flags)
-{
-	void *data;
-
-	WARN_ON_ONCE(!bpf_rcu_lock_held());
-	if (flags & ~BPF_LOCAL_STORAGE_GET_F_CREATE || !task)
-		return (unsigned long)NULL;
-
-	bpf_task_storage_lock();
-	data = __bpf_task_storage_get(map, task, value, flags,
-				      gfp_flags, true);
-	bpf_task_storage_unlock();
-	return (unsigned long)data;
-}
-
-BPF_CALL_2(bpf_task_storage_delete_recur, struct bpf_map *, map, struct task_struct *,
-	   task)
-{
-	bool nobusy;
-	int ret;
-
-	WARN_ON_ONCE(!bpf_rcu_lock_held());
-	if (!task)
-		return -EINVAL;
-
-	nobusy = bpf_task_storage_trylock();
-	/* This helper must only be called from places where the lifetime of the task
-	 * is guaranteed. Either by being refcounted or by being protected
-	 * by an RCU read-side critical section.
-	 */
-	ret = task_storage_delete(task, map, nobusy);
-	if (nobusy)
-		bpf_task_storage_unlock();
-	return ret;
+	return (unsigned long)NULL;
 }
 
 BPF_CALL_2(bpf_task_storage_delete, struct bpf_map *, map, struct task_struct *,
 	   task)
 {
-	int ret;
-
 	WARN_ON_ONCE(!bpf_rcu_lock_held());
 	if (!task)
 		return -EINVAL;
 
-	bpf_task_storage_lock();
 	/* This helper must only be called from places where the lifetime of the task
 	 * is guaranteed. Either by being refcounted or by being protected
 	 * by an RCU read-side critical section.
 	 */
-	ret = task_storage_delete(task, map, true);
-	bpf_task_storage_unlock();
-	return ret;
+	return task_storage_delete(task, map);
 }
 
 static int notsupp_get_next_key(struct bpf_map *map, void *key, void *next_key)
@@ -311,7 +217,7 @@ static struct bpf_map *task_storage_map_alloc(union bpf_attr *attr)
 
 static void task_storage_map_free(struct bpf_map *map)
 {
-	bpf_local_storage_map_free(map, &task_cache, &bpf_task_storage_busy);
+	bpf_local_storage_map_free(map, &task_cache, NULL);
 }
 
 BTF_ID_LIST_GLOBAL_SINGLE(bpf_local_storage_map_btf_id, struct, bpf_local_storage_map)
@@ -330,17 +236,6 @@ const struct bpf_map_ops task_storage_map_ops = {
 	.map_owner_storage_ptr = task_storage_ptr,
 };
 
-const struct bpf_func_proto bpf_task_storage_get_recur_proto = {
-	.func = bpf_task_storage_get_recur,
-	.gpl_only = false,
-	.ret_type = RET_PTR_TO_MAP_VALUE_OR_NULL,
-	.arg1_type = ARG_CONST_MAP_PTR,
-	.arg2_type = ARG_PTR_TO_BTF_ID_OR_NULL,
-	.arg2_btf_id = &btf_tracing_ids[BTF_TRACING_TYPE_TASK],
-	.arg3_type = ARG_PTR_TO_MAP_VALUE_OR_NULL,
-	.arg4_type = ARG_ANYTHING,
-};
-
 const struct bpf_func_proto bpf_task_storage_get_proto = {
 	.func = bpf_task_storage_get,
 	.gpl_only = false,
@@ -352,15 +247,6 @@ const struct bpf_func_proto bpf_task_storage_get_proto = {
 	.arg4_type = ARG_ANYTHING,
 };
 
-const struct bpf_func_proto bpf_task_storage_delete_recur_proto = {
-	.func = bpf_task_storage_delete_recur,
-	.gpl_only = false,
-	.ret_type = RET_INTEGER,
-	.arg1_type = ARG_CONST_MAP_PTR,
-	.arg2_type = ARG_PTR_TO_BTF_ID_OR_NULL,
-	.arg2_btf_id = &btf_tracing_ids[BTF_TRACING_TYPE_TASK],
-};
-
 const struct bpf_func_proto bpf_task_storage_delete_proto = {
 	.func = bpf_task_storage_delete,
 	.gpl_only = false,
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index db72b96f9c8c..33b470b9324d 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2092,12 +2092,8 @@ bpf_base_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_get_cgroup_classid_curr_proto;
 #endif
 	case BPF_FUNC_task_storage_get:
-		if (bpf_prog_check_recur(prog))
-			return &bpf_task_storage_get_recur_proto;
 		return &bpf_task_storage_get_proto;
 	case BPF_FUNC_task_storage_delete:
-		if (bpf_prog_check_recur(prog))
-			return &bpf_task_storage_delete_recur_proto;
 		return &bpf_task_storage_delete_proto;
 	default:
 		break;
-- 
2.47.3


