Return-Path: <bpf+bounces-66235-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73F7FB2FFB3
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 18:12:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F4E61895D67
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 16:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D622285CB6;
	Thu, 21 Aug 2025 16:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sNhTEDap"
X-Original-To: bpf@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 751C32E1EF0
	for <bpf@vger.kernel.org>; Thu, 21 Aug 2025 16:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755792529; cv=none; b=HRf4YUpEI+lRAe2C2DQqJG12aTBilrLLxh7BrBJwhhbiB8n5kd1UJ0c+d6Th6AIOUJXfQvun4O0hEzGe+Z7QaTxvxBvF0d8JmmJzAKngNjOhrG9XbsPXBFkztClIQsMk9uqBtA3hrlv7NrsSEW0Qmhy7ty1TLNdf2mfkoCQ/Ogk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755792529; c=relaxed/simple;
	bh=GTCh2Tcmd8h7G/1qWgIzWi7E1rlbQS2GAWipzEJpl+0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ecq4p8I30PxVn/wraLuZ1c0p2vKqFiSDZ+m6Icht6wMyQL+znro9YKQbjwJlc0VOU5/rAD/iASTkt5ZnT4KR8/iTehDScgCjrRaFgOyEisIHBjNj8HfeKCLiNgW8hC5KZatalT1I7VWfgWYaMAU6FRElE6AbSad8cyosE07I/XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sNhTEDap; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755792525;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VYPB4ZThZqTM8IjvUzVtKJr8NE4HdLLe+Xv/u1xm27g=;
	b=sNhTEDap5fUugytc+HveaCuH3Fowl7bng6zCf4eYmDn14Ujwzazrawr5BdyYvPVKHICHV/
	o0qjqnDSISk5khWAGiMgWSjarsO780UoiM2BP7vLRcMxwm1Xngd4/VM+GPjNmT7QxVuh4u
	5XrayIa2Yc8x8Hx70sDnKq67dnm3EAo=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	olsajiri@gmail.com,
	yonghong.song@linux.dev,
	song@kernel.org,
	eddyz87@gmail.com,
	dxu@dxuuu.xyz,
	deso@posteo.net,
	leon.hwang@linux.dev,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf-next v3 2/6] bpf: Introduce BPF_F_CPU flag for percpu_array maps
Date: Fri, 22 Aug 2025 00:08:13 +0800
Message-ID: <20250821160817.70285-3-leon.hwang@linux.dev>
In-Reply-To: <20250821160817.70285-1-leon.hwang@linux.dev>
References: <20250821160817.70285-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Introduce support for the BPF_F_ALL_CPUS flag in percpu_array maps to
allow updating values for all CPUs with a single value.

Introduce support for the BPF_F_CPU flag in percpu_array maps to allow
updating value for specified CPU.

This enhancement enables:

* Efficient update values across all CPUs with a single value when
  BPF_F_ALL_CPUS is set for update_elem and update_batch APIs.
* Targeted update or lookup for a specified CPU when BPF_F_CPU is set.

The BPF_F_CPU flag is passed via:

* map_flags of lookup_elem and update_elem APIs along with embedded cpu
  field.
* elem_flags of lookup_batch and update_batch APIs along with embedded
  cpu field.

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 include/linux/bpf.h            |  3 +-
 include/uapi/linux/bpf.h       |  2 ++
 kernel/bpf/arraymap.c          | 56 ++++++++++++++++++++++++++--------
 kernel/bpf/syscall.c           | 27 ++++++++++------
 tools/include/uapi/linux/bpf.h |  2 ++
 5 files changed, 67 insertions(+), 23 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 8f6e87f0f3a89..b2191b1e455a6 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2697,7 +2697,8 @@ int map_set_for_each_callback_args(struct bpf_verifier_env *env,
 				   struct bpf_func_state *callee);
 
 int bpf_percpu_hash_copy(struct bpf_map *map, void *key, void *value);
-int bpf_percpu_array_copy(struct bpf_map *map, void *key, void *value);
+int bpf_percpu_array_copy(struct bpf_map *map, void *key, void *value,
+			  u64 flags);
 int bpf_percpu_hash_update(struct bpf_map *map, void *key, void *value,
 			   u64 flags);
 int bpf_percpu_array_update(struct bpf_map *map, void *key, void *value,
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 233de8677382e..be1fdc5042744 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1372,6 +1372,8 @@ enum {
 	BPF_NOEXIST	= 1, /* create new element if it didn't exist */
 	BPF_EXIST	= 2, /* update existing element */
 	BPF_F_LOCK	= 4, /* spin_lock-ed map_lookup/map_update */
+	BPF_F_CPU	= 8, /* cpu flag for percpu maps, upper 32-bit of flags is a cpu number */
+	BPF_F_ALL_CPUS	= 16, /* update value across all CPUs for percpu maps */
 };
 
 /* flags for BPF_MAP_CREATE command */
diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
index 3d080916faf97..1efa730105e24 100644
--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -295,17 +295,24 @@ static void *percpu_array_map_lookup_percpu_elem(struct bpf_map *map, void *key,
 	return per_cpu_ptr(array->pptrs[index & array->index_mask], cpu);
 }
 
-int bpf_percpu_array_copy(struct bpf_map *map, void *key, void *value)
+int bpf_percpu_array_copy(struct bpf_map *map, void *key, void *value, u64 flags)
 {
 	struct bpf_array *array = container_of(map, struct bpf_array, map);
 	u32 index = *(u32 *)key;
 	void __percpu *pptr;
-	int cpu, off = 0;
-	u32 size;
+	u32 size, cpu;
+	int off = 0;
 
 	if (unlikely(index >= array->map.max_entries))
 		return -ENOENT;
 
+	if (unlikely((u32)flags & ~BPF_F_CPU))
+		return -EINVAL;
+
+	cpu = flags >> 32;
+	if (unlikely((flags & BPF_F_CPU) && cpu >= num_possible_cpus()))
+		return -ERANGE;
+
 	/* per_cpu areas are zero-filled and bpf programs can only
 	 * access 'value_size' of them, so copying rounded areas
 	 * will not leak any kernel data
@@ -313,10 +320,15 @@ int bpf_percpu_array_copy(struct bpf_map *map, void *key, void *value)
 	size = array->elem_size;
 	rcu_read_lock();
 	pptr = array->pptrs[index & array->index_mask];
-	for_each_possible_cpu(cpu) {
-		copy_map_value_long(map, value + off, per_cpu_ptr(pptr, cpu));
-		check_and_init_map_value(map, value + off);
-		off += size;
+	if (flags & BPF_F_CPU) {
+		copy_map_value_long(map, value, per_cpu_ptr(pptr, cpu));
+		check_and_init_map_value(map, value);
+	} else {
+		for_each_possible_cpu(cpu) {
+			copy_map_value_long(map, value + off, per_cpu_ptr(pptr, cpu));
+			check_and_init_map_value(map, value + off);
+			off += size;
+		}
 	}
 	rcu_read_unlock();
 	return 0;
@@ -385,14 +397,22 @@ int bpf_percpu_array_update(struct bpf_map *map, void *key, void *value,
 			    u64 map_flags)
 {
 	struct bpf_array *array = container_of(map, struct bpf_array, map);
+	const u64 cpu_flags = BPF_F_CPU | BPF_F_ALL_CPUS;
 	u32 index = *(u32 *)key;
 	void __percpu *pptr;
-	int cpu, off = 0;
-	u32 size;
+	u32 size, cpu;
+	int off = 0;
 
-	if (unlikely(map_flags > BPF_EXIST))
+	if (unlikely((u32)map_flags > BPF_F_ALL_CPUS))
 		/* unknown flags */
 		return -EINVAL;
+	if (unlikely((map_flags & cpu_flags) == cpu_flags))
+		return -EINVAL;
+
+	cpu = map_flags >> 32;
+	if (unlikely((map_flags & BPF_F_CPU) && cpu >= num_possible_cpus()))
+		/* invalid cpu */
+		return -ERANGE;
 
 	if (unlikely(index >= array->map.max_entries))
 		/* all elements were pre-allocated, cannot insert a new one */
@@ -411,10 +431,20 @@ int bpf_percpu_array_update(struct bpf_map *map, void *key, void *value,
 	size = array->elem_size;
 	rcu_read_lock();
 	pptr = array->pptrs[index & array->index_mask];
-	for_each_possible_cpu(cpu) {
-		copy_map_value_long(map, per_cpu_ptr(pptr, cpu), value + off);
+	if (map_flags & BPF_F_CPU) {
+		copy_map_value_long(map, per_cpu_ptr(pptr, cpu), value);
 		bpf_obj_free_fields(array->map.record, per_cpu_ptr(pptr, cpu));
-		off += size;
+	} else {
+		for_each_possible_cpu(cpu) {
+			copy_map_value_long(map, per_cpu_ptr(pptr, cpu), value + off);
+			/* same user-provided value is used if
+			 * BPF_F_ALL_CPUS is specified, otherwise value is
+			 * an array of per-cpu values.
+			 */
+			if (!(map_flags & BPF_F_ALL_CPUS))
+				off += size;
+			bpf_obj_free_fields(array->map.record, per_cpu_ptr(pptr, cpu));
+		}
 	}
 	rcu_read_unlock();
 	return 0;
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 19f7f5de5e7dc..6251ac9bc7e42 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -131,9 +131,11 @@ bool bpf_map_write_active(const struct bpf_map *map)
 	return atomic64_read(&map->writecnt) != 0;
 }
 
-static u32 bpf_map_value_size(const struct bpf_map *map)
+static u32 bpf_map_value_size(const struct bpf_map *map, u64 flags)
 {
-	if (map->map_type == BPF_MAP_TYPE_PERCPU_HASH ||
+	if (map->map_type == BPF_MAP_TYPE_PERCPU_ARRAY && (flags & (BPF_F_CPU | BPF_F_ALL_CPUS)))
+		return round_up(map->value_size, 8);
+	else if (map->map_type == BPF_MAP_TYPE_PERCPU_HASH ||
 	    map->map_type == BPF_MAP_TYPE_LRU_PERCPU_HASH ||
 	    map->map_type == BPF_MAP_TYPE_PERCPU_ARRAY ||
 	    map->map_type == BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE)
@@ -314,7 +316,7 @@ static int bpf_map_copy_value(struct bpf_map *map, void *key, void *value,
 	    map->map_type == BPF_MAP_TYPE_LRU_PERCPU_HASH) {
 		err = bpf_percpu_hash_copy(map, key, value);
 	} else if (map->map_type == BPF_MAP_TYPE_PERCPU_ARRAY) {
-		err = bpf_percpu_array_copy(map, key, value);
+		err = bpf_percpu_array_copy(map, key, value, flags);
 	} else if (map->map_type == BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE) {
 		err = bpf_percpu_cgroup_storage_copy(map, key, value);
 	} else if (map->map_type == BPF_MAP_TYPE_STACK_TRACE) {
@@ -1656,12 +1658,19 @@ static void *___bpf_copy_key(bpfptr_t ukey, u64 key_size)
 
 static int check_map_flags(struct bpf_map *map, u64 flags, bool check_flag)
 {
-	if (check_flag && (flags & ~BPF_F_LOCK))
+	if (check_flag && ((u32)flags & ~(BPF_F_LOCK | BPF_F_CPU | BPF_F_ALL_CPUS)))
 		return -EINVAL;
 
 	if ((flags & BPF_F_LOCK) && !btf_record_has_field(map->record, BPF_SPIN_LOCK))
 		return -EINVAL;
 
+	if (!(flags & BPF_F_CPU) && flags >> 32)
+		return -EINVAL;
+
+	if ((flags & (BPF_F_CPU | BPF_F_ALL_CPUS)) &&
+		map->map_type != BPF_MAP_TYPE_PERCPU_ARRAY)
+		return -EINVAL;
+
 	return 0;
 }
 
@@ -1695,7 +1704,7 @@ static int map_lookup_elem(union bpf_attr *attr)
 	if (IS_ERR(key))
 		return PTR_ERR(key);
 
-	value_size = bpf_map_value_size(map);
+	value_size = bpf_map_value_size(map, attr->flags);
 
 	err = -ENOMEM;
 	value = kvmalloc(value_size, GFP_USER | __GFP_NOWARN);
@@ -1762,7 +1771,7 @@ static int map_update_elem(union bpf_attr *attr, bpfptr_t uattr)
 		goto err_put;
 	}
 
-	value_size = bpf_map_value_size(map);
+	value_size = bpf_map_value_size(map, attr->flags);
 	value = kvmemdup_bpfptr(uvalue, value_size);
 	if (IS_ERR(value)) {
 		err = PTR_ERR(value);
@@ -1962,7 +1971,7 @@ int generic_map_update_batch(struct bpf_map *map, struct file *map_file,
 	if (err)
 		return err;
 
-	value_size = bpf_map_value_size(map);
+	value_size = bpf_map_value_size(map, attr->batch.elem_flags);
 
 	max_count = attr->batch.count;
 	if (!max_count)
@@ -2021,7 +2030,7 @@ int generic_map_lookup_batch(struct bpf_map *map,
 	if (err)
 		return err;
 
-	value_size = bpf_map_value_size(map);
+	value_size = bpf_map_value_size(map, attr->batch.elem_flags);
 
 	max_count = attr->batch.count;
 	if (!max_count)
@@ -2143,7 +2152,7 @@ static int map_lookup_and_delete_elem(union bpf_attr *attr)
 		goto err_put;
 	}
 
-	value_size = bpf_map_value_size(map);
+	value_size = bpf_map_value_size(map, 0);
 
 	err = -ENOMEM;
 	value = kvmalloc(value_size, GFP_USER | __GFP_NOWARN);
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 233de8677382e..be1fdc5042744 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1372,6 +1372,8 @@ enum {
 	BPF_NOEXIST	= 1, /* create new element if it didn't exist */
 	BPF_EXIST	= 2, /* update existing element */
 	BPF_F_LOCK	= 4, /* spin_lock-ed map_lookup/map_update */
+	BPF_F_CPU	= 8, /* cpu flag for percpu maps, upper 32-bit of flags is a cpu number */
+	BPF_F_ALL_CPUS	= 16, /* update value across all CPUs for percpu maps */
 };
 
 /* flags for BPF_MAP_CREATE command */
-- 
2.50.1


