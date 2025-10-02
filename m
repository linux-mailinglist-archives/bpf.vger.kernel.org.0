Return-Path: <bpf+bounces-70253-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 30425BB5928
	for <lists+bpf@lfdr.de>; Fri, 03 Oct 2025 00:55:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B0BC19C80DC
	for <lists+bpf@lfdr.de>; Thu,  2 Oct 2025 22:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AF522C0F72;
	Thu,  2 Oct 2025 22:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BxQlQHkB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63A729D270
	for <bpf@vger.kernel.org>; Thu,  2 Oct 2025 22:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759445647; cv=none; b=PAurfVdzjjQ+S6a4SzpYMmul0+bK4Xnwx3QHGooy7gpt86/jpq/RU1bt3pZT336hLLYGSghwSpra/acrH3MifrxbDDfcpCh0+hmWVOciwjOKdTZbBlrOGr8uxtKlvX1TFuglPhQxN6XyadMQ3E+iWSXu4qb+7mT53XBiHLzE3Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759445647; c=relaxed/simple;
	bh=pLrfMiel/PhVN/dHv7/eoW7k7UUe8P0ttl/K1LJbfQo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oadHPTzPhQdtd5YrkUGlaIypfpMXWV0cPKaCHB1SJxWcU8JwimeQwtf0dzR+0Wt8z7yF3wa+/VEUJLqP71XxxIisTjvUvj6bTlMUrYxubIThaLHLNjLpZ5HCm24wbKZdf+pY0vZhDfk0MbBGUyyRjs3qQPkTwcXprwj7Zsvvq5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BxQlQHkB; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-781db5068b8so1419353b3a.0
        for <bpf@vger.kernel.org>; Thu, 02 Oct 2025 15:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759445644; x=1760050444; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xw2zcqzYzgPbtxgPVOwcUHl0DW+HEXkaLeobcAu8rUY=;
        b=BxQlQHkBifgxB5jRovGz01Ew3wqRB4bOYEKEUDZ5Svi8ky2tC4jxS6S++itapFCKTr
         rbJFLis5IC3AfO6j3WZRkJNFr25ZwA3wG/I1swUgsvaiePKsYf92bsWbL/87cujSP44z
         ueWiKR35nRRpddmKGlyxOdJgOSAZgCPRcbO19A0nIZWuYnGHKGpNSrWUuSCxieW8yyeN
         cZs1C43MIefQVbMNWdWJNQeyElgz9A3BtcfMUkxqTDLkBLGW52qCF5ccVXh1IsV0vucD
         Su9AUPcpZf6QFrlWeIfTfTYOZMqQSuppTymAkCqcVG2wLsZlP1s8FoWVlQ1VAA/WcZbv
         WM2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759445644; x=1760050444;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xw2zcqzYzgPbtxgPVOwcUHl0DW+HEXkaLeobcAu8rUY=;
        b=IJ2q2TFockh7wb9Q2KOlVEYWzZtmoj07+I73iahhnVTzpnsLbu8CE7hu6EHccgEjsf
         MuRTF4t8/ql5DqC2cKKoaSgf7G+amMEg+oqhVobAw9ZUa5asK7tx96zmY+xpI2vnRjQG
         0Ry3/BSLZ+D6c0g9CtjZUHugiipq+Y+IyVB1XZ56vCS6zJ7/UG01iA8pKw8+mVBLhjPu
         ogZJNJuSdCky9LmnhH38mTWADVOXrv8SuYCLjyx69BYB296bmGN0lLwFYrjyX8mBRPik
         1tbLOHG3MGme+9DiezE5DJXY6s8xUfuXgANX9eyIy/4OqGN5jorNNG/YOCG9Rp+9UbYZ
         bvRQ==
X-Gm-Message-State: AOJu0Yy4SL9nbvoh1eUPUtjfqT/4WhBpIh56j/E9BZv/q++ejzDHOIzv
	4JBA1Q/j1waJT7HcdCTOlk65uHJXwyygFrGtzG8KpZ2/UPa6d03nDetpzO34kA==
X-Gm-Gg: ASbGnctX6e20nTFjyALtLv2FwN6yvaghuoXDUiHyycEeJVIHPgqh7zS3hrXJTahL9sZ
	/FrzMcGx5BpfhOZ1Z47xiRPncAm8/Vssn3nMfaDnXp2Qk0lRpGoH1SPfWSn29LjCDXWZbzA7dVZ
	qaqn5scHGGyOyGIzt6L0voliB50itbwnET/I2BgIINxObeMh7OQIH2o+839G0GBFhW75F8hFnZl
	E/tF4OSLj5vO+Iy/lQDL6yk6/jLCUwTu1RHV5srCOHGef8OEizPtqaxec5mtRRgGtWR5PWPgT4b
	celBuBGhH8D6s0IthQkWAXkNyEfMEXM1UZUcSJvNR9M51IwIGSQKr+4UXxmuVAun3MdU1V6iihd
	/tO02VLq+yM4iDxDhpYONuzvnlMj3xdvGLJgTinpTC4fKeKfD
X-Google-Smtp-Source: AGHT+IGE6H90hATwcwhEHWF66vakZM7TstkTfiXkNMSeZj0ze+O1JghlUpP0IxXtm75WzWKqsVd79A==
X-Received: by 2002:a17:90b:1a87:b0:334:3286:8fe2 with SMTP id 98e67ed59e1d1-339c277fabamr1150302a91.10.1759445643787;
        Thu, 02 Oct 2025 15:54:03 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:1d::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-339c4924c47sm142001a91.0.2025.10.02.15.54.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 15:54:03 -0700 (PDT)
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
Subject: [RFC PATCH bpf-next v2 07/12] bpf: Remove task local storage percpu counter
Date: Thu,  2 Oct 2025 15:53:46 -0700
Message-ID: <20251002225356.1505480-8-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251002225356.1505480-1-ameryhung@gmail.com>
References: <20251002225356.1505480-1-ameryhung@gmail.com>
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
index c9fab9a356df..1d83f29a8986 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2040,12 +2040,8 @@ bpf_base_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
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


