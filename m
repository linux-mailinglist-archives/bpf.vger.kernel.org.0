Return-Path: <bpf+bounces-61408-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 52501AE6D01
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 18:55:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B1FA7A7B2C
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 16:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44A5E2E610E;
	Tue, 24 Jun 2025 16:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lNbiv4q+"
X-Original-To: bpf@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8E02E3B14
	for <bpf@vger.kernel.org>; Tue, 24 Jun 2025 16:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750784097; cv=none; b=Bh2zzFUMmhBw+uPROXuvVcyYDcMTY8A/QFiLo5ga0TXhGZ19iKhDqhn9QN23nIsvgKIzLnC3HHTkoStXDt8kl4Q+HJHXPxQ8C7kQrqelR5YNx9yzWQsCxFzlW6bOFJ7v6p6p/ehVWYNrgm8UL44Lz9h36zomuxaAau6gsqSpXNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750784097; c=relaxed/simple;
	bh=1ROhpI8IM4wZREjBo4k+o7VWcjx0BfHx7qpcxoLtUhc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pMf7agsKeTbfv/EhpuL1oNOqmLmL+pV3Yn/dQDqBGa/OOfPcKo5g2GcpZb0Z0olF71/JLjoDePxJT2znmBRediD/WbABu5hrJqN936qO7usDgHTe7ECjI/P3S4laQxM4bCTRsTc9myO2VidIA5EVrqML7TVgZ5mtpeaDEWtEQno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lNbiv4q+; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1750784093;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MsIDLk9VWgwbz9Xc/n/bXPBq4eBRefBSeWpSHW/ITzI=;
	b=lNbiv4q+0V3e0pfdFPwlGR+943TOsu9pdGEZS0PoVSobv0Dh9yW2BaVkaebMIW7P3BHD1n
	Z8kortTi83xharTfH7SLlrYVxqcVVTHussJfTjI80o0XlrtJ5e444kUE54m5ynajFEZwSM
	gf438HrDZ4aHq0Bv/gZ5aAtbPuv8Mc4=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	Leon Hwang <leon.hwang@linux.dev>
Subject: [RFC PATCH bpf-next 1/3] bpf: Introduce BPF_F_CPU flag for percpu_array map
Date: Wed, 25 Jun 2025 00:53:52 +0800
Message-ID: <20250624165354.27184-2-leon.hwang@linux.dev>
In-Reply-To: <20250624165354.27184-1-leon.hwang@linux.dev>
References: <20250624165354.27184-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This patch introduces support for the BPF_F_CPU flag in percpu_array maps
to allow updating or looking up values for specific CPUs or for all CPUs
with a single value.

This enhancement enables:

* Efficient update of all CPUs using a single value when cpu == 0xFFFFFFFF.
* Targeted update or lookup for a specific CPU otherwise.

The flag is passed via:

* map_flags in bpf_percpu_array_update() along with the cpu field.
* elem_flags in generic_map_update_batch() along with the cpu field.

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 include/linux/bpf.h            |  5 +--
 include/uapi/linux/bpf.h       |  6 ++++
 kernel/bpf/arraymap.c          | 46 ++++++++++++++++++++++++----
 kernel/bpf/syscall.c           | 56 ++++++++++++++++++++++------------
 tools/include/uapi/linux/bpf.h |  6 ++++
 5 files changed, 92 insertions(+), 27 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 5dd556e89cce..4f4cac6c6b84 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2628,11 +2628,12 @@ int map_set_for_each_callback_args(struct bpf_verifier_env *env,
 				   struct bpf_func_state *callee);
 
 int bpf_percpu_hash_copy(struct bpf_map *map, void *key, void *value);
-int bpf_percpu_array_copy(struct bpf_map *map, void *key, void *value);
+int bpf_percpu_array_copy(struct bpf_map *map, void *key, void *value,
+			  u64 flags, u32 cpu);
 int bpf_percpu_hash_update(struct bpf_map *map, void *key, void *value,
 			   u64 flags);
 int bpf_percpu_array_update(struct bpf_map *map, void *key, void *value,
-			    u64 flags);
+			    u64 flags, u32 cpu);
 
 int bpf_stackmap_copy(struct bpf_map *map, void *key, void *value);
 
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 39e7818cca80..a602c45149eb 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1359,8 +1359,12 @@ enum {
 	BPF_NOEXIST	= 1, /* create new element if it didn't exist */
 	BPF_EXIST	= 2, /* update existing element */
 	BPF_F_LOCK	= 4, /* spin_lock-ed map_lookup/map_update */
+	BPF_F_CPU	= 8, /* map_update for percpu_array */
 };
 
+/* indicate updating value on all CPUs for percpu maps. */
+#define BPF_ALL_CPU	0xFFFFFFFF
+
 /* flags for BPF_MAP_CREATE command */
 enum {
 	BPF_F_NO_PREALLOC	= (1U << 0),
@@ -1514,6 +1518,7 @@ union bpf_attr {
 			__aligned_u64 next_key;
 		};
 		__u64		flags;
+		__u32		cpu;
 	};
 
 	struct { /* struct used by BPF_MAP_*_BATCH commands */
@@ -1531,6 +1536,7 @@ union bpf_attr {
 		__u32		map_fd;
 		__u64		elem_flags;
 		__u64		flags;
+		__u32		cpu;
 	} batch;
 
 	struct { /* anonymous struct used by BPF_PROG_LOAD command */
diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
index eb28c0f219ee..290462a2b1b9 100644
--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -295,22 +295,40 @@ static void *percpu_array_map_lookup_percpu_elem(struct bpf_map *map, void *key,
 	return per_cpu_ptr(array->pptrs[index & array->index_mask], cpu);
 }
 
-int bpf_percpu_array_copy(struct bpf_map *map, void *key, void *value)
+int bpf_percpu_array_copy(struct bpf_map *map, void *key, void *value,
+			  u64 flags, u32 cpu)
 {
 	struct bpf_array *array = container_of(map, struct bpf_array, map);
 	u32 index = *(u32 *)key;
 	void __percpu *pptr;
-	int cpu, off = 0;
+	int off = 0;
 	u32 size;
 
 	if (unlikely(index >= array->map.max_entries))
 		return -ENOENT;
 
+	if (unlikely(flags > BPF_F_CPU))
+		/* unknown flags */
+		return -EINVAL;
+
 	/* per_cpu areas are zero-filled and bpf programs can only
 	 * access 'value_size' of them, so copying rounded areas
 	 * will not leak any kernel data
 	 */
 	size = array->elem_size;
+
+	if (flags & BPF_F_CPU) {
+		if (cpu >= num_possible_cpus())
+			return -E2BIG;
+
+		rcu_read_lock();
+		pptr = array->pptrs[index & array->index_mask];
+		copy_map_value_long(map, value, per_cpu_ptr(pptr, cpu));
+		check_and_init_map_value(map, value);
+		rcu_read_unlock();
+		return 0;
+	}
+
 	rcu_read_lock();
 	pptr = array->pptrs[index & array->index_mask];
 	for_each_possible_cpu(cpu) {
@@ -382,15 +400,16 @@ static long array_map_update_elem(struct bpf_map *map, void *key, void *value,
 }
 
 int bpf_percpu_array_update(struct bpf_map *map, void *key, void *value,
-			    u64 map_flags)
+			    u64 map_flags, u32 cpu)
 {
 	struct bpf_array *array = container_of(map, struct bpf_array, map);
 	u32 index = *(u32 *)key;
 	void __percpu *pptr;
-	int cpu, off = 0;
+	bool reuse_value;
+	int off = 0;
 	u32 size;
 
-	if (unlikely(map_flags > BPF_EXIST))
+	if (unlikely(map_flags > BPF_F_CPU))
 		/* unknown flags */
 		return -EINVAL;
 
@@ -409,10 +428,25 @@ int bpf_percpu_array_update(struct bpf_map *map, void *key, void *value,
 	 * so no kernel data leaks possible
 	 */
 	size = array->elem_size;
+
+	if ((map_flags & BPF_F_CPU) && cpu != BPF_ALL_CPU) {
+		if (cpu >= num_possible_cpus())
+			return -E2BIG;
+
+		rcu_read_lock();
+		pptr = array->pptrs[index & array->index_mask];
+		copy_map_value_long(map, per_cpu_ptr(pptr, cpu), value);
+		bpf_obj_free_fields(array->map.record, per_cpu_ptr(pptr, cpu));
+		rcu_read_unlock();
+		return 0;
+	}
+
+	reuse_value = (map_flags & BPF_F_CPU) && cpu == BPF_ALL_CPU;
 	rcu_read_lock();
 	pptr = array->pptrs[index & array->index_mask];
 	for_each_possible_cpu(cpu) {
-		copy_map_value_long(map, per_cpu_ptr(pptr, cpu), value + off);
+		copy_map_value_long(map, per_cpu_ptr(pptr, cpu),
+				    reuse_value ? value : value + off);
 		bpf_obj_free_fields(array->map.record, per_cpu_ptr(pptr, cpu));
 		off += size;
 	}
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 56500381c28a..cdff7830baee 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -241,7 +241,7 @@ static int bpf_obj_pin_uptrs(struct btf_record *rec, void *obj)
 }
 
 static int bpf_map_update_value(struct bpf_map *map, struct file *map_file,
-				void *key, void *value, __u64 flags)
+				void *key, void *value, __u64 flags, __u32 cpu)
 {
 	int err;
 
@@ -265,7 +265,7 @@ static int bpf_map_update_value(struct bpf_map *map, struct file *map_file,
 	    map->map_type == BPF_MAP_TYPE_LRU_PERCPU_HASH) {
 		err = bpf_percpu_hash_update(map, key, value, flags);
 	} else if (map->map_type == BPF_MAP_TYPE_PERCPU_ARRAY) {
-		err = bpf_percpu_array_update(map, key, value, flags);
+		err = bpf_percpu_array_update(map, key, value, flags, cpu);
 	} else if (map->map_type == BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE) {
 		err = bpf_percpu_cgroup_storage_update(map, key, value,
 						       flags);
@@ -299,7 +299,7 @@ static int bpf_map_update_value(struct bpf_map *map, struct file *map_file,
 }
 
 static int bpf_map_copy_value(struct bpf_map *map, void *key, void *value,
-			      __u64 flags)
+			      __u64 flags, __u32 cpu)
 {
 	void *ptr;
 	int err;
@@ -312,7 +312,7 @@ static int bpf_map_copy_value(struct bpf_map *map, void *key, void *value,
 	    map->map_type == BPF_MAP_TYPE_LRU_PERCPU_HASH) {
 		err = bpf_percpu_hash_copy(map, key, value);
 	} else if (map->map_type == BPF_MAP_TYPE_PERCPU_ARRAY) {
-		err = bpf_percpu_array_copy(map, key, value);
+		err = bpf_percpu_array_copy(map, key, value, flags, cpu);
 	} else if (map->map_type == BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE) {
 		err = bpf_percpu_cgroup_storage_copy(map, key, value);
 	} else if (map->map_type == BPF_MAP_TYPE_STACK_TRACE) {
@@ -1648,7 +1648,7 @@ static void *___bpf_copy_key(bpfptr_t ukey, u64 key_size)
 }
 
 /* last field in 'union bpf_attr' used by this command */
-#define BPF_MAP_LOOKUP_ELEM_LAST_FIELD flags
+#define BPF_MAP_LOOKUP_ELEM_LAST_FIELD cpu
 
 static int map_lookup_elem(union bpf_attr *attr)
 {
@@ -1662,7 +1662,7 @@ static int map_lookup_elem(union bpf_attr *attr)
 	if (CHECK_ATTR(BPF_MAP_LOOKUP_ELEM))
 		return -EINVAL;
 
-	if (attr->flags & ~BPF_F_LOCK)
+	if (attr->flags & ~(BPF_F_LOCK | BPF_F_CPU))
 		return -EINVAL;
 
 	CLASS(fd, f)(attr->map_fd);
@@ -1691,11 +1691,11 @@ static int map_lookup_elem(union bpf_attr *attr)
 		if (copy_from_user(value, uvalue, value_size))
 			err = -EFAULT;
 		else
-			err = bpf_map_copy_value(map, key, value, attr->flags);
+			err = bpf_map_copy_value(map, key, value, attr->flags, attr->cpu);
 		goto free_value;
 	}
 
-	err = bpf_map_copy_value(map, key, value, attr->flags);
+	err = bpf_map_copy_value(map, key, value, attr->flags, attr->cpu);
 	if (err)
 		goto free_value;
 
@@ -1713,7 +1713,7 @@ static int map_lookup_elem(union bpf_attr *attr)
 }
 
 
-#define BPF_MAP_UPDATE_ELEM_LAST_FIELD flags
+#define BPF_MAP_UPDATE_ELEM_LAST_FIELD cpu
 
 static int map_update_elem(union bpf_attr *attr, bpfptr_t uattr)
 {
@@ -1756,7 +1756,7 @@ static int map_update_elem(union bpf_attr *attr, bpfptr_t uattr)
 		goto free_key;
 	}
 
-	err = bpf_map_update_value(map, fd_file(f), key, value, attr->flags);
+	err = bpf_map_update_value(map, fd_file(f), key, value, attr->flags, attr->cpu);
 	if (!err)
 		maybe_wait_bpf_programs(map);
 
@@ -1941,19 +1941,27 @@ int generic_map_update_batch(struct bpf_map *map, struct file *map_file,
 {
 	void __user *values = u64_to_user_ptr(attr->batch.values);
 	void __user *keys = u64_to_user_ptr(attr->batch.keys);
+	u64 elem_flags = attr->batch.elem_flags;
 	u32 value_size, cp, max_count;
 	void *key, *value;
 	int err = 0;
 
-	if (attr->batch.elem_flags & ~BPF_F_LOCK)
+	if (elem_flags & ~(BPF_F_LOCK | BPF_F_CPU))
 		return -EINVAL;
 
-	if ((attr->batch.elem_flags & BPF_F_LOCK) &&
+	if ((elem_flags & BPF_F_LOCK) &&
 	    !btf_record_has_field(map->record, BPF_SPIN_LOCK)) {
 		return -EINVAL;
 	}
 
-	value_size = bpf_map_value_size(map);
+	if (elem_flags & BPF_F_CPU) {
+		if (map->map_type != BPF_MAP_TYPE_PERCPU_ARRAY)
+			return -EINVAL;
+
+		value_size = round_up(map->value_size, 8);
+	} else {
+		value_size = bpf_map_value_size(map);
+	}
 
 	max_count = attr->batch.count;
 	if (!max_count)
@@ -1980,7 +1988,8 @@ int generic_map_update_batch(struct bpf_map *map, struct file *map_file,
 			break;
 
 		err = bpf_map_update_value(map, map_file, key, value,
-					   attr->batch.elem_flags);
+					   attr->batch.elem_flags,
+					   attr->batch.cpu);
 
 		if (err)
 			break;
@@ -2005,17 +2014,25 @@ int generic_map_lookup_batch(struct bpf_map *map,
 	void __user *values = u64_to_user_ptr(attr->batch.values);
 	void __user *keys = u64_to_user_ptr(attr->batch.keys);
 	void *buf, *buf_prevkey, *prev_key, *key, *value;
+	u64 elem_flags = attr->batch.elem_flags;
 	u32 value_size, cp, max_count;
 	int err;
 
-	if (attr->batch.elem_flags & ~BPF_F_LOCK)
+	if (elem_flags & ~(BPF_F_LOCK | BPF_F_CPU))
 		return -EINVAL;
 
-	if ((attr->batch.elem_flags & BPF_F_LOCK) &&
+	if ((elem_flags & BPF_F_LOCK) &&
 	    !btf_record_has_field(map->record, BPF_SPIN_LOCK))
 		return -EINVAL;
 
-	value_size = bpf_map_value_size(map);
+	if (elem_flags & BPF_F_CPU) {
+		if (map->map_type != BPF_MAP_TYPE_PERCPU_ARRAY)
+			return -EINVAL;
+
+		value_size = round_up(map->value_size, 8);
+	} else {
+		value_size = bpf_map_value_size(map);
+	}
 
 	max_count = attr->batch.count;
 	if (!max_count)
@@ -2050,7 +2067,8 @@ int generic_map_lookup_batch(struct bpf_map *map,
 		if (err)
 			break;
 		err = bpf_map_copy_value(map, key, value,
-					 attr->batch.elem_flags);
+					 attr->batch.elem_flags,
+					 attr->batch.cpu);
 
 		if (err == -ENOENT)
 			goto next_key;
@@ -5438,7 +5456,7 @@ static int bpf_task_fd_query(const union bpf_attr *attr,
 	return err;
 }
 
-#define BPF_MAP_BATCH_LAST_FIELD batch.flags
+#define BPF_MAP_BATCH_LAST_FIELD batch.cpu
 
 #define BPF_DO_BATCH(fn, ...)			\
 	do {					\
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 39e7818cca80..a602c45149eb 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1359,8 +1359,12 @@ enum {
 	BPF_NOEXIST	= 1, /* create new element if it didn't exist */
 	BPF_EXIST	= 2, /* update existing element */
 	BPF_F_LOCK	= 4, /* spin_lock-ed map_lookup/map_update */
+	BPF_F_CPU	= 8, /* map_update for percpu_array */
 };
 
+/* indicate updating value on all CPUs for percpu maps. */
+#define BPF_ALL_CPU	0xFFFFFFFF
+
 /* flags for BPF_MAP_CREATE command */
 enum {
 	BPF_F_NO_PREALLOC	= (1U << 0),
@@ -1514,6 +1518,7 @@ union bpf_attr {
 			__aligned_u64 next_key;
 		};
 		__u64		flags;
+		__u32		cpu;
 	};
 
 	struct { /* struct used by BPF_MAP_*_BATCH commands */
@@ -1531,6 +1536,7 @@ union bpf_attr {
 		__u32		map_fd;
 		__u64		elem_flags;
 		__u64		flags;
+		__u32		cpu;
 	} batch;
 
 	struct { /* anonymous struct used by BPF_PROG_LOAD command */
-- 
2.49.0


