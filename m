Return-Path: <bpf+bounces-68035-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9788BB51DA0
	for <lists+bpf@lfdr.de>; Wed, 10 Sep 2025 18:28:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5ABC1C80FDC
	for <lists+bpf@lfdr.de>; Wed, 10 Sep 2025 16:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FE2F334383;
	Wed, 10 Sep 2025 16:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HYOuxS0/"
X-Original-To: bpf@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6C431DDB7
	for <bpf@vger.kernel.org>; Wed, 10 Sep 2025 16:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757521699; cv=none; b=jtup4cfgNJu2zAUesx+FnMi/+7Qf0ZRj8esMtGi3wnpLvwVGCWFyOiucdPJN3YTdEuaGr1jfQY/ard+F76MjcfBlWQgfHLfYfU1TbZfHHZe7p9RMugnJWBddqRCb6TsKnjYG3Gc2AsCfjtslBKP/Xc8yTP7pHwLPuSEidlPQxMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757521699; c=relaxed/simple;
	bh=Nt9oRT89KfzZFB6HQj+oMcjgzDS3k4PGd+N22VuCf0w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lL6BMoZztyx/+MLQwd8GdsigUjjpCEtCLeCM2WYMLDrLbuZQYBU7Tx0TpIbMBCLS0ThiKcWcbPFtZXyI7pONjn4fiTK/or3b8Xts0jbDoBh3MfPqircd28BVFuBsCpIL+me2lfeK90m0AuhXcsXaF/CCghmN2TGPyRbG7Z7ZbG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HYOuxS0/; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757521696;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xu0SGM8IfzA73J/9T37WoY1ElULA7WkzXGfQ21o0BVw=;
	b=HYOuxS0/mWbBqZ+QMTE4zJmIRwFMsP/poVCAyhTwZIbjJw7z6GmRdatR2txc9TrfJN2C9v
	HnN/0HsoaMy1A9jwgSpkrXbQcP4pfe7GKq0hiIj1mJAhgctnqi+28qx/55FErdit5QQu8y
	dh+uzmWRAFeHGlUekE2GGIee5wKDg8A=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	jolsa@kernel.org,
	yonghong.song@linux.dev,
	song@kernel.org,
	eddyz87@gmail.com,
	dxu@dxuuu.xyz,
	deso@posteo.net,
	leon.hwang@linux.dev,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf-next v7 3/7] bpf: Add BPF_F_CPU and BPF_F_ALL_CPUS flags support for percpu_array maps
Date: Thu, 11 Sep 2025 00:27:29 +0800
Message-ID: <20250910162733.82534-4-leon.hwang@linux.dev>
In-Reply-To: <20250910162733.82534-1-leon.hwang@linux.dev>
References: <20250910162733.82534-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Introduce support for the BPF_F_ALL_CPUS flag in percpu_array maps to
allow updating values for all CPUs with a single value for both
update_elem and update_batch APIs.

Introduce support for the BPF_F_CPU flag in percpu_array maps to allow:

* update value for specified CPU for both update_elem and update_batch
APIs.
* lookup value for specified CPU for both lookup_elem and lookup_batch
APIs.

The BPF_F_CPU flag is passed via:

* map_flags of lookup_elem and update_elem APIs along with embedded cpu
info.
* elem_flags of lookup_batch and update_batch APIs along with embedded
cpu info.

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 include/linux/bpf.h   |  9 +++++++--
 kernel/bpf/arraymap.c | 24 +++++++++++++++++++++---
 kernel/bpf/syscall.c  |  2 +-
 3 files changed, 29 insertions(+), 6 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index cfb95e3a93dcc..0426b29cf6591 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2697,7 +2697,7 @@ int map_set_for_each_callback_args(struct bpf_verifier_env *env,
 				   struct bpf_func_state *callee);
 
 int bpf_percpu_hash_copy(struct bpf_map *map, void *key, void *value);
-int bpf_percpu_array_copy(struct bpf_map *map, void *key, void *value);
+int bpf_percpu_array_copy(struct bpf_map *map, void *key, void *value, u64 flags);
 int bpf_percpu_hash_update(struct bpf_map *map, void *key, void *value,
 			   u64 flags);
 int bpf_percpu_array_update(struct bpf_map *map, void *key, void *value,
@@ -3711,7 +3711,12 @@ struct bpf_prog *bpf_prog_find_from_stack(void);
 
 static inline bool bpf_map_supports_cpu_flags(enum bpf_map_type map_type)
 {
-	return false;
+	switch (map_type) {
+	case BPF_MAP_TYPE_PERCPU_ARRAY:
+		return true;
+	default:
+		return false;
+	}
 }
 
 static inline int bpf_map_check_op_flags(struct bpf_map *map, u64 flags, u64 allowed_flags)
diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
index 3d080916faf97..dbe2548b35513 100644
--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -295,7 +295,7 @@ static void *percpu_array_map_lookup_percpu_elem(struct bpf_map *map, void *key,
 	return per_cpu_ptr(array->pptrs[index & array->index_mask], cpu);
 }
 
-int bpf_percpu_array_copy(struct bpf_map *map, void *key, void *value)
+int bpf_percpu_array_copy(struct bpf_map *map, void *key, void *value, u64 map_flags)
 {
 	struct bpf_array *array = container_of(map, struct bpf_array, map);
 	u32 index = *(u32 *)key;
@@ -313,11 +313,18 @@ int bpf_percpu_array_copy(struct bpf_map *map, void *key, void *value)
 	size = array->elem_size;
 	rcu_read_lock();
 	pptr = array->pptrs[index & array->index_mask];
+	if (map_flags & BPF_F_CPU) {
+		cpu = map_flags >> 32;
+		copy_map_value_long(map, value, per_cpu_ptr(pptr, cpu));
+		check_and_init_map_value(map, value);
+		goto unlock;
+	}
 	for_each_possible_cpu(cpu) {
 		copy_map_value_long(map, value + off, per_cpu_ptr(pptr, cpu));
 		check_and_init_map_value(map, value + off);
 		off += size;
 	}
+unlock:
 	rcu_read_unlock();
 	return 0;
 }
@@ -390,7 +397,7 @@ int bpf_percpu_array_update(struct bpf_map *map, void *key, void *value,
 	int cpu, off = 0;
 	u32 size;
 
-	if (unlikely(map_flags > BPF_EXIST))
+	if (unlikely((u32)map_flags > BPF_F_ALL_CPUS))
 		/* unknown flags */
 		return -EINVAL;
 
@@ -411,11 +418,22 @@ int bpf_percpu_array_update(struct bpf_map *map, void *key, void *value,
 	size = array->elem_size;
 	rcu_read_lock();
 	pptr = array->pptrs[index & array->index_mask];
+	if (map_flags & BPF_F_CPU) {
+		cpu = map_flags >> 32;
+		copy_map_value_long(map, per_cpu_ptr(pptr, cpu), value);
+		bpf_obj_free_fields(array->map.record, per_cpu_ptr(pptr, cpu));
+		goto unlock;
+	}
 	for_each_possible_cpu(cpu) {
 		copy_map_value_long(map, per_cpu_ptr(pptr, cpu), value + off);
 		bpf_obj_free_fields(array->map.record, per_cpu_ptr(pptr, cpu));
-		off += size;
+		/* same user-provided value is used if BPF_F_ALL_CPUS is
+		 * specified, otherwise value is an array of per-CPU values.
+		 */
+		if (!(map_flags & BPF_F_ALL_CPUS))
+			off += size;
 	}
+unlock:
 	rcu_read_unlock();
 	return 0;
 }
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 0ce373e31490b..2054a943f69cb 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -316,7 +316,7 @@ static int bpf_map_copy_value(struct bpf_map *map, void *key, void *value,
 	    map->map_type == BPF_MAP_TYPE_LRU_PERCPU_HASH) {
 		err = bpf_percpu_hash_copy(map, key, value);
 	} else if (map->map_type == BPF_MAP_TYPE_PERCPU_ARRAY) {
-		err = bpf_percpu_array_copy(map, key, value);
+		err = bpf_percpu_array_copy(map, key, value, flags);
 	} else if (map->map_type == BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE) {
 		err = bpf_percpu_cgroup_storage_copy(map, key, value);
 	} else if (map->map_type == BPF_MAP_TYPE_STACK_TRACE) {
-- 
2.50.1


