Return-Path: <bpf+bounces-62537-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECB77AFB838
	for <lists+bpf@lfdr.de>; Mon,  7 Jul 2025 18:04:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9DF6170549
	for <lists+bpf@lfdr.de>; Mon,  7 Jul 2025 16:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 432B922578C;
	Mon,  7 Jul 2025 16:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="B2me77JE"
X-Original-To: bpf@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B7513EFE3
	for <bpf@vger.kernel.org>; Mon,  7 Jul 2025 16:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751904264; cv=none; b=X5V5gglcCU4A8z6xprsAjv447jnZ2+nEBOfHUYrOoSzsYC5+McKM6N7gzse8KTyyT4BSWgS+ywo4vHjDo35P1s9ENfsy/OHl0GUGhBcuSAk0p7LHNo+KmwTBbU2+sU4YFIphiETjCTEw1NPiBcLbi0iFyMcJ6BehMSFrsVgUJnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751904264; c=relaxed/simple;
	bh=9aheOPF+5qtvBpwapFNb5yhr622EoBI6IbURJSYOifY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jYjKqRfH3k5kxygFbzW4DTewqdpIGiFw8JCOfuq0UR09moX0air6OadOzrOYjVa156DGsrxJ0uDXkr8cXfjojnTWlL3V3knPbYaOa4sWQ7RUS1yckGW6G0bdOF2SQuG4lfI6M72qWXfMr4Xrzz/zfizKu/b95Umd25vtvp1lgP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=B2me77JE; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1751904260;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/E2kgk1wsdMCB9qYvdkmqLn5PTWNvNCo/uvJdwtcDDU=;
	b=B2me77JE0PlS5rAFxRCFcvNjre+nxr1+kDULBwTEjVB9Q/iXS4EblUUQD/JA9F94uPCN46
	4M6LhR1EL8uOIceCG01kSpFpFtrePTPd7V3ZHkPjZNZ2S2CR7GC1EjRER4sXXdqh6sYe00
	OaYWYgiJXcg4yTMO6Uc7/uNiMg8SyHY=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	Leon Hwang <leon.hwang@linux.dev>
Subject: [RFC PATCH bpf-next v2 1/3] bpf: Introduce BPF_F_CPU flag for percpu_array map
Date: Tue,  8 Jul 2025 00:04:02 +0800
Message-ID: <20250707160404.64933-2-leon.hwang@linux.dev>
In-Reply-To: <20250707160404.64933-1-leon.hwang@linux.dev>
References: <20250707160404.64933-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This patch introduces support for the BPF_F_CPU flag in percpu_array maps
to allow updating or looking up values for specified CPUs or for all CPUs
with a single value.

This enhancement enables:

* Efficient update of all CPUs using a single value when cpu == (u32)~0.
* Targeted update or lookup for a specified CPU otherwise.

The flag is passed via:

* map_flags in bpf_percpu_array_update() along with embedded cpu field.
* elem_flags in generic_map_update_batch() along with separated cpu field.

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 include/linux/bpf.h            |  3 +-
 include/uapi/linux/bpf.h       |  7 +++++
 kernel/bpf/arraymap.c          | 56 ++++++++++++++++++++++++++--------
 kernel/bpf/syscall.c           | 52 +++++++++++++++++++------------
 tools/include/uapi/linux/bpf.h |  7 +++++
 5 files changed, 92 insertions(+), 33 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 34dd90ec7fad..6ea5fe7fa0d5 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2662,7 +2662,8 @@ int map_set_for_each_callback_args(struct bpf_verifier_env *env,
 				   struct bpf_func_state *callee);
 
 int bpf_percpu_hash_copy(struct bpf_map *map, void *key, void *value);
-int bpf_percpu_array_copy(struct bpf_map *map, void *key, void *value);
+int bpf_percpu_array_copy(struct bpf_map *map, void *key, void *value,
+			  u64 flags);
 int bpf_percpu_hash_update(struct bpf_map *map, void *key, void *value,
 			   u64 flags);
 int bpf_percpu_array_update(struct bpf_map *map, void *key, void *value,
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 0670e15a6100..0d3469cb7a06 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1371,6 +1371,12 @@ enum {
 	BPF_NOEXIST	= 1, /* create new element if it didn't exist */
 	BPF_EXIST	= 2, /* update existing element */
 	BPF_F_LOCK	= 4, /* spin_lock-ed map_lookup/map_update */
+	BPF_F_CPU	= 8, /* map_update for percpu_array */
+};
+
+enum {
+	/* indicate updating value across all CPUs for percpu maps. */
+	BPF_ALL_CPUS	= (__u32)~0,
 };
 
 /* flags for BPF_MAP_CREATE command */
@@ -1548,6 +1554,7 @@ union bpf_attr {
 		__u32		map_fd;
 		__u64		elem_flags;
 		__u64		flags;
+		__u32		cpu;
 	} batch;
 
 	struct { /* anonymous struct used by BPF_PROG_LOAD command */
diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
index 3d080916faf9..5c5376b89930 100644
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
 
+	cpu = (u32)(flags >> 32);
+	flags &= (u32)~0;
+	if (unlikely(flags > BPF_F_CPU))
+		return -EINVAL;
+	if (unlikely((flags & BPF_F_CPU) && cpu >= num_possible_cpus()))
+		return -E2BIG;
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
@@ -387,13 +399,21 @@ int bpf_percpu_array_update(struct bpf_map *map, void *key, void *value,
 	struct bpf_array *array = container_of(map, struct bpf_array, map);
 	u32 index = *(u32 *)key;
 	void __percpu *pptr;
-	int cpu, off = 0;
-	u32 size;
+	bool reuse_value;
+	u32 size, cpu;
+	int off = 0;
 
-	if (unlikely(map_flags > BPF_EXIST))
+	cpu = (u32)(map_flags >> 32);
+	map_flags = map_flags & (u32)~0;
+	if (unlikely(map_flags > BPF_F_CPU))
 		/* unknown flags */
 		return -EINVAL;
 
+	if (unlikely((map_flags & BPF_F_CPU) && cpu != BPF_ALL_CPUS &&
+		     cpu >= num_possible_cpus()))
+		/* invalid cpu */
+		return -E2BIG;
+
 	if (unlikely(index >= array->map.max_entries))
 		/* all elements were pre-allocated, cannot insert a new one */
 		return -E2BIG;
@@ -409,12 +429,22 @@ int bpf_percpu_array_update(struct bpf_map *map, void *key, void *value,
 	 * so no kernel data leaks possible
 	 */
 	size = array->elem_size;
+	reuse_value = (map_flags & BPF_F_CPU) && cpu == BPF_ALL_CPUS;
 	rcu_read_lock();
 	pptr = array->pptrs[index & array->index_mask];
-	for_each_possible_cpu(cpu) {
-		copy_map_value_long(map, per_cpu_ptr(pptr, cpu), value + off);
+	if ((map_flags & BPF_F_CPU) && cpu != BPF_ALL_CPUS) {
+		copy_map_value_long(map, per_cpu_ptr(pptr, cpu), value);
 		bpf_obj_free_fields(array->map.record, per_cpu_ptr(pptr, cpu));
-		off += size;
+	} else {
+		for_each_possible_cpu(cpu) {
+			if (!reuse_value) {
+				copy_map_value_long(map, per_cpu_ptr(pptr, cpu), value + off);
+				off += size;
+			} else {
+				copy_map_value_long(map, per_cpu_ptr(pptr, cpu), value);
+			}
+			bpf_obj_free_fields(array->map.record, per_cpu_ptr(pptr, cpu));
+		}
 	}
 	rcu_read_unlock();
 	return 0;
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 7db7182a3057..a3ce0cdecb3c 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -129,8 +129,12 @@ bool bpf_map_write_active(const struct bpf_map *map)
 	return atomic64_read(&map->writecnt) != 0;
 }
 
-static u32 bpf_map_value_size(const struct bpf_map *map)
+static u32 bpf_map_value_size(const struct bpf_map *map, u64 flags)
 {
+	if ((flags & BPF_F_CPU) &&
+		map->map_type == BPF_MAP_TYPE_PERCPU_ARRAY)
+		return round_up(map->value_size, 8);
+
 	if (map->map_type == BPF_MAP_TYPE_PERCPU_HASH ||
 	    map->map_type == BPF_MAP_TYPE_LRU_PERCPU_HASH ||
 	    map->map_type == BPF_MAP_TYPE_PERCPU_ARRAY ||
@@ -312,7 +316,7 @@ static int bpf_map_copy_value(struct bpf_map *map, void *key, void *value,
 	    map->map_type == BPF_MAP_TYPE_LRU_PERCPU_HASH) {
 		err = bpf_percpu_hash_copy(map, key, value);
 	} else if (map->map_type == BPF_MAP_TYPE_PERCPU_ARRAY) {
-		err = bpf_percpu_array_copy(map, key, value);
+		err = bpf_percpu_array_copy(map, key, value, flags);
 	} else if (map->map_type == BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE) {
 		err = bpf_percpu_cgroup_storage_copy(map, key, value);
 	} else if (map->map_type == BPF_MAP_TYPE_STACK_TRACE) {
@@ -1662,7 +1666,7 @@ static int map_lookup_elem(union bpf_attr *attr)
 	if (CHECK_ATTR(BPF_MAP_LOOKUP_ELEM))
 		return -EINVAL;
 
-	if (attr->flags & ~BPF_F_LOCK)
+	if ((attr->flags & (u32)~0) & ~(BPF_F_LOCK | BPF_F_CPU))
 		return -EINVAL;
 
 	CLASS(fd, f)(attr->map_fd);
@@ -1680,7 +1684,7 @@ static int map_lookup_elem(union bpf_attr *attr)
 	if (IS_ERR(key))
 		return PTR_ERR(key);
 
-	value_size = bpf_map_value_size(map);
+	value_size = bpf_map_value_size(map, attr->flags);
 
 	err = -ENOMEM;
 	value = kvmalloc(value_size, GFP_USER | __GFP_NOWARN);
@@ -1749,7 +1753,7 @@ static int map_update_elem(union bpf_attr *attr, bpfptr_t uattr)
 		goto err_put;
 	}
 
-	value_size = bpf_map_value_size(map);
+	value_size = bpf_map_value_size(map, attr->flags);
 	value = kvmemdup_bpfptr(uvalue, value_size);
 	if (IS_ERR(value)) {
 		err = PTR_ERR(value);
@@ -1941,19 +1945,25 @@ int generic_map_update_batch(struct bpf_map *map, struct file *map_file,
 {
 	void __user *values = u64_to_user_ptr(attr->batch.values);
 	void __user *keys = u64_to_user_ptr(attr->batch.keys);
-	u32 value_size, cp, max_count;
+	u32 value_size, cp, max_count, cpu = attr->batch.cpu;
+	u64 elem_flags = attr->batch.elem_flags;
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
+	if ((elem_flags & BPF_F_CPU) &&
+		map->map_type != BPF_MAP_TYPE_PERCPU_ARRAY)
+		return -EINVAL;
+
+	value_size = bpf_map_value_size(map, elem_flags);
+	elem_flags = (((u64)cpu) << 32) | elem_flags;
 
 	max_count = attr->batch.count;
 	if (!max_count)
@@ -1979,8 +1989,7 @@ int generic_map_update_batch(struct bpf_map *map, struct file *map_file,
 		    copy_from_user(value, values + cp * value_size, value_size))
 			break;
 
-		err = bpf_map_update_value(map, map_file, key, value,
-					   attr->batch.elem_flags);
+		err = bpf_map_update_value(map, map_file, key, value, elem_flags);
 
 		if (err)
 			break;
@@ -2004,18 +2013,24 @@ int generic_map_lookup_batch(struct bpf_map *map,
 	void __user *ubatch = u64_to_user_ptr(attr->batch.in_batch);
 	void __user *values = u64_to_user_ptr(attr->batch.values);
 	void __user *keys = u64_to_user_ptr(attr->batch.keys);
+	u32 value_size, cp, max_count, cpu = attr->batch.cpu;
 	void *buf, *buf_prevkey, *prev_key, *key, *value;
-	u32 value_size, cp, max_count;
+	u64 elem_flags = attr->batch.elem_flags;
 	int err;
 
-	if (attr->batch.elem_flags & ~BPF_F_LOCK)
+	if (elem_flags & ~(BPF_F_LOCK | BPF_F_CPU))
 		return -EINVAL;
 
-	if ((attr->batch.elem_flags & BPF_F_LOCK) &&
+	if ((elem_flags & BPF_F_LOCK) &&
 	    !btf_record_has_field(map->record, BPF_SPIN_LOCK))
 		return -EINVAL;
 
-	value_size = bpf_map_value_size(map);
+	if ((elem_flags & BPF_F_CPU) &&
+		map->map_type != BPF_MAP_TYPE_PERCPU_ARRAY)
+		return -EINVAL;
+
+	value_size = bpf_map_value_size(map, elem_flags);
+	elem_flags = (((u64)cpu) << 32) | elem_flags;
 
 	max_count = attr->batch.count;
 	if (!max_count)
@@ -2049,8 +2064,7 @@ int generic_map_lookup_batch(struct bpf_map *map,
 		rcu_read_unlock();
 		if (err)
 			break;
-		err = bpf_map_copy_value(map, key, value,
-					 attr->batch.elem_flags);
+		err = bpf_map_copy_value(map, key, value, elem_flags);
 
 		if (err == -ENOENT)
 			goto next_key;
@@ -2137,7 +2151,7 @@ static int map_lookup_and_delete_elem(union bpf_attr *attr)
 		goto err_put;
 	}
 
-	value_size = bpf_map_value_size(map);
+	value_size = bpf_map_value_size(map, attr->flags);
 
 	err = -ENOMEM;
 	value = kvmalloc(value_size, GFP_USER | __GFP_NOWARN);
@@ -5445,7 +5459,7 @@ static int bpf_task_fd_query(const union bpf_attr *attr,
 	return err;
 }
 
-#define BPF_MAP_BATCH_LAST_FIELD batch.flags
+#define BPF_MAP_BATCH_LAST_FIELD batch.cpu
 
 #define BPF_DO_BATCH(fn, ...)			\
 	do {					\
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 0670e15a6100..0d3469cb7a06 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1371,6 +1371,12 @@ enum {
 	BPF_NOEXIST	= 1, /* create new element if it didn't exist */
 	BPF_EXIST	= 2, /* update existing element */
 	BPF_F_LOCK	= 4, /* spin_lock-ed map_lookup/map_update */
+	BPF_F_CPU	= 8, /* map_update for percpu_array */
+};
+
+enum {
+	/* indicate updating value across all CPUs for percpu maps. */
+	BPF_ALL_CPUS	= (__u32)~0,
 };
 
 /* flags for BPF_MAP_CREATE command */
@@ -1548,6 +1554,7 @@ union bpf_attr {
 		__u32		map_fd;
 		__u64		elem_flags;
 		__u64		flags;
+		__u32		cpu;
 	} batch;
 
 	struct { /* anonymous struct used by BPF_PROG_LOAD command */
-- 
2.50.0


