Return-Path: <bpf+bounces-64663-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 84248B152C6
	for <lists+bpf@lfdr.de>; Tue, 29 Jul 2025 20:27:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 366485481A0
	for <lists+bpf@lfdr.de>; Tue, 29 Jul 2025 18:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A964254AE7;
	Tue, 29 Jul 2025 18:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XbHhZ8Cs"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2002500DE;
	Tue, 29 Jul 2025 18:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753813561; cv=none; b=QXbggooaQQpbPz6ooP7Emj6Ta43dV/C6yaCqgKkosmtJNpGsa/RD3TnbEpxTeVUteWRcTDRPEF8xg3KqTndNSrIbb1AjQ+k58qbX73ZKSBU0uqRB4kBi0dP5nQcFU0F6VNm4mVAXHIYmDEvNEa98KRMS3suDpJXrcJ+L3BW/B30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753813561; c=relaxed/simple;
	bh=731QhNys06mjDI2hhSOZeGf2YhjeT+TASlr9sWREpOs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eA/gY0SQlN2lFEKStCvJXDG+EFpYEpBjnGAc/nEYvGcN2KHHO7BPViNnrmn04FhsTTMEGpJny2PP/2crODNQLLZSEuVtE04EW52dc7l/fUntWnPwt1JnMDE/nsC6sN1tNuxIE8yxhmbIc3nRA5D0j4uXkb/5Y2Ie/+MNuewXHiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XbHhZ8Cs; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-748e378ba4fso7617480b3a.1;
        Tue, 29 Jul 2025 11:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753813558; x=1754418358; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0j1rAXcVwYk1mZmQl58q2XoqyzufVSPiBeVGqiF1iGI=;
        b=XbHhZ8CsK9g2LdV/JEJpGRnkETl635ekjb4y+Psd0MegaHl28y3rJYmd1PmOSDBM9n
         xnBESiN518ypOhMFXTcVDrFMViEFMnHukloVcHqNncTzC4Lae9tWaki9QmEK2KD4xlFD
         aDhW7cOHJ/4dfgYJSGheBANBV5xKDFDiqAQjb/aLnh5iqyeTi8OvEIWuuTrhuy+2oNgl
         EO9TJOeNnVrkgbNhlq+QB8QRyVhLVezuamTEOdzrFO9JBsQA77A2RReR55iyi6w9G4O3
         l4Sh7b4q01eHWQp3h+HeLPHq2YHqxmgUzfEKXu+uamMbvpZRGwhQdg0q3oqde9YbSJll
         ZsEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753813558; x=1754418358;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0j1rAXcVwYk1mZmQl58q2XoqyzufVSPiBeVGqiF1iGI=;
        b=u80P8J/NkSRcMKWB8N6AAht8tPNPtPf0rWMYh5CH6wVnWAc0BSq9LFzrH8cQq17G4z
         rLcGYW1hBXZD0qdKy3DwBmnHQW19fqWDouAdswLUsIDKK8X0novee6w0G7SaPh2Du/St
         9uKd2I+f82MtT9dP6kBtnS1e0C5vDGV+LKDoRTXejnCdC3EPjznT1NjS36Qrsy/F4klR
         tB3jdlg1xyLvBH+0Hj3YSYVwEyYUFunWH928heySngo0Cdfv5puk+GTUibML5R0df1mO
         9SuyOOhHUd9CfHNXIAuOGfRp+uuzQcmm73ml6BxR+Ib6JK9w7/BdF9NnqgbFpn7zjWlE
         If1g==
X-Gm-Message-State: AOJu0YwNaI/AdRgD1u6Rkt/v360gc4t3+eXMXFInVZLkzz4nQflV8Xmi
	LVZxFHGAuHsmJPfVb1230a+O4t9URBse3zY1r1ceeBT/MtOdV/mrXv9ePrweFA==
X-Gm-Gg: ASbGncuMy7LslXd90lkuBI0D7Ip2yKa1DIm04vNybT22dmbUMXtWt/jHR7in0OR/ntS
	TeheUkd0E80dD/PEWv5Gp6kTzKpc/yvOzSJ2bYccm48KFz4XKnaFSoeqMA9vQ1UEfFdicoKJRHU
	G3ld/knEs2FHEXtH1Tx/0AZ8L7dG0q20qME6ZzWMxWVuVO2VOSFPEU+mf9xfoUrInhF1z0JFOZk
	cYQ61ZCNn5mPHbvbFaHDC2i2Wgy++tQxO99nza9cSCQBwJA29yRvKjENYvH+6z4YqNFlvQ1VCEh
	aTpQijOdS+tkln5e5focweyU2rB0ZPlqe6GRc+usNyLvaMHI1sMlWuCzdAAzwCy1fti7EZ//h0E
	6vumY5uFyfMdcLA==
X-Google-Smtp-Source: AGHT+IGMMtx1otzKvlr+yBcsv2SSAfFbp2J44gC0vtoZKdqXHVFaDnxg1ZaNJGYGP+hEOB6JsJhsgw==
X-Received: by 2002:a05:6a20:729e:b0:232:22a4:bd2b with SMTP id adf61e73a8af0-23dc0ee349dmr542412637.33.1753813558124;
        Tue, 29 Jul 2025 11:25:58 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:73::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7640adfe5absm8061839b3a.69.2025.07.29.11.25.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 11:25:57 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	memxor@gmail.com,
	kpsingh@kernel.org,
	martin.lau@kernel.org,
	yonghong.song@linux.dev,
	song@kernel.org,
	haoluo@google.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [RFC PATCH bpf-next v1 06/11] bpf: Remove task local storage percpu counter
Date: Tue, 29 Jul 2025 11:25:44 -0700
Message-ID: <20250729182550.185356-7-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250729182550.185356-1-ameryhung@gmail.com>
References: <20250729182550.185356-1-ameryhung@gmail.com>
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
helpers to run concurrently on the same CPU, removing the -EBUSY error.
bpf_task_storage_get(..., F_CREATE) will now always succeed with enough
free memory unless being called recursively.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/bpf_task_storage.c | 149 ++++------------------------------
 kernel/bpf/helpers.c          |   4 -
 2 files changed, 17 insertions(+), 136 deletions(-)

diff --git a/kernel/bpf/bpf_task_storage.c b/kernel/bpf/bpf_task_storage.c
index c0199baba9a7..ff1e2e4cc5b5 100644
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
@@ -70,19 +47,15 @@ void bpf_task_storage_free(struct task_struct *task)
 {
 	struct bpf_local_storage *local_storage;
 
-	migrate_disable();
 	rcu_read_lock();
 
 	local_storage = rcu_dereference(task->bpf_storage);
 	if (!local_storage)
 		goto out;
 
-	bpf_task_storage_lock();
 	bpf_local_storage_destroy(local_storage);
-	bpf_task_storage_unlock();
 out:
 	rcu_read_unlock();
-	migrate_enable();
 }
 
 static void *bpf_pid_task_storage_lookup_elem(struct bpf_map *map, void *key)
@@ -108,9 +81,7 @@ static void *bpf_pid_task_storage_lookup_elem(struct bpf_map *map, void *key)
 		goto out;
 	}
 
-	bpf_task_storage_lock();
 	sdata = task_storage_lookup(task, map, true);
-	bpf_task_storage_unlock();
 	put_pid(pid);
 	return sdata ? sdata->data : NULL;
 out:
@@ -145,11 +116,9 @@ static long bpf_pid_task_storage_update_elem(struct bpf_map *map, void *key,
 		goto out;
 	}
 
-	bpf_task_storage_lock();
 	sdata = bpf_local_storage_update(
 		task, (struct bpf_local_storage_map *)map, value, map_flags,
 		true, GFP_ATOMIC);
-	bpf_task_storage_unlock();
 
 	err = PTR_ERR_OR_ZERO(sdata);
 out:
@@ -157,8 +126,7 @@ static long bpf_pid_task_storage_update_elem(struct bpf_map *map, void *key,
 	return err;
 }
 
-static int task_storage_delete(struct task_struct *task, struct bpf_map *map,
-			       bool nobusy)
+static int task_storage_delete(struct task_struct *task, struct bpf_map *map)
 {
 	struct bpf_local_storage_data *sdata;
 
@@ -166,9 +134,6 @@ static int task_storage_delete(struct task_struct *task, struct bpf_map *map,
 	if (!sdata)
 		return -ENOENT;
 
-	if (!nobusy)
-		return -EBUSY;
-
 	return bpf_selem_unlink(SELEM(sdata), false);
 }
 
@@ -194,111 +159,51 @@ static long bpf_pid_task_storage_delete_elem(struct bpf_map *map, void *key)
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
+		WARN_ON(IS_ERR(sdata));
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
@@ -313,7 +218,7 @@ static struct bpf_map *task_storage_map_alloc(union bpf_attr *attr)
 
 static void task_storage_map_free(struct bpf_map *map)
 {
-	bpf_local_storage_map_free(map, &task_cache, &bpf_task_storage_busy);
+	bpf_local_storage_map_free(map, &task_cache, NULL);
 }
 
 BTF_ID_LIST_GLOBAL_SINGLE(bpf_local_storage_map_btf_id, struct, bpf_local_storage_map)
@@ -332,17 +237,6 @@ const struct bpf_map_ops task_storage_map_ops = {
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
@@ -354,15 +248,6 @@ const struct bpf_func_proto bpf_task_storage_get_proto = {
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
index 6b4877e85a68..d142fbb25665 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2032,12 +2032,8 @@ bpf_base_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
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


