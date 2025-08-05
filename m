Return-Path: <bpf+bounces-65076-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77E94B1B887
	for <lists+bpf@lfdr.de>; Tue,  5 Aug 2025 18:30:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3285B62060E
	for <lists+bpf@lfdr.de>; Tue,  5 Aug 2025 16:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EF481F9EC0;
	Tue,  5 Aug 2025 16:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="l3nwknZE"
X-Original-To: bpf@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2A4191F92
	for <bpf@vger.kernel.org>; Tue,  5 Aug 2025 16:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754411435; cv=none; b=jn9/+LV1USvJP02Fapm6oxNwKvt4qzh9kqdLCaq5CkfZ8ng6gLo1UOO1fzXFo1veHqcmppAhl8c3+GlOFBc2lwUlgc0gVF3qwq6IQrrllPtNm1aks1KjgrkdTMArxEBWGzcPdzmxWKf0tmCH7vGSs7Zl7j7/GX7nSF7jaYcCfhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754411435; c=relaxed/simple;
	bh=wlr3cjKrNPtchET8JpL1e/O4qXhy+kJA32N+2Am6NIg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HOBf1YVQgZJnGUPT5B7hgZEghlRXxNmlBF4LKTcmdnolb6nS62N7Au4HGz+kMxo6jvy5h5+fWL1G1sM7+kYOKrXGmxYxAZsrrAiWzIq7ECKNQYyFuQlLzl0OIMoqwTjUmdDeYttzXyEwecFY2AQaknQBJxx1QAjwgwT7Uk7K8Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=l3nwknZE; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754411431;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6j95fE/14wJW5DRhjwnMrUoRPEkY9g7X6y1JJ7dquf0=;
	b=l3nwknZExkHgbx1QDbpfSNgnVE1PfZHUGiR/QdXG383EhTQFzPIo3KACsXR8tAiZN0bbKW
	N2bz3L8CTe1FTRJVQ6OuNO2W0ElS4y+p1y14+orLe6mpGceynkXnPU49hvGVdjlNoRB3sn
	ilcy+uwyEzWR0wGvVAjW+tTXtYcKJlk=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	yonghong.song@linux.dev,
	song@kernel.org,
	eddyz87@gmail.com,
	dxu@dxuuu.xyz,
	deso@posteo.net,
	leon.hwang@linux.dev,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf-next v2 1/3] bpf: Introduce BPF_F_CPU flag for percpu_array maps
Date: Wed,  6 Aug 2025 00:30:15 +0800
Message-ID: <20250805163017.17015-2-leon.hwang@linux.dev>
In-Reply-To: <20250805163017.17015-1-leon.hwang@linux.dev>
References: <20250805163017.17015-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Introduce support for the BPF_F_CPU flag in percpu_array maps to allow
updating values for specified CPU or for all CPUs with a single value.

This enhancement enables:

* Efficient update of all CPUs using a single value when cpu == (u32)~0.
* Targeted update or lookup for a specified CPU otherwise.

The flag is passed via:

* map_flags in bpf_percpu_array_update() along with embedded cpu field.
* elem_flags in generic_map_update_batch() along with embedded cpu field.

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 include/linux/bpf.h            |  3 +-
 include/uapi/linux/bpf.h       |  6 +++
 kernel/bpf/arraymap.c          | 54 ++++++++++++++++++------
 kernel/bpf/syscall.c           | 77 +++++++++++++++++++++-------------
 tools/include/uapi/linux/bpf.h |  6 +++
 5 files changed, 103 insertions(+), 43 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index cc700925b802f..c17c45f797ed9 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2691,7 +2691,8 @@ int map_set_for_each_callback_args(struct bpf_verifier_env *env,
 				   struct bpf_func_state *callee);
 
 int bpf_percpu_hash_copy(struct bpf_map *map, void *key, void *value);
-int bpf_percpu_array_copy(struct bpf_map *map, void *key, void *value);
+int bpf_percpu_array_copy(struct bpf_map *map, void *key, void *value,
+			  u64 flags);
 int bpf_percpu_hash_update(struct bpf_map *map, void *key, void *value,
 			   u64 flags);
 int bpf_percpu_array_update(struct bpf_map *map, void *key, void *value,
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 233de8677382e..67bc35e4d6a8d 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1372,6 +1372,12 @@ enum {
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
diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
index 3d080916faf97..98759f0b22397 100644
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
 
+	cpu = flags >> 32;
+	flags &= (u32)~0;
+	if (unlikely(flags > BPF_F_CPU))
+		return -EINVAL;
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
@@ -387,13 +399,20 @@ int bpf_percpu_array_update(struct bpf_map *map, void *key, void *value,
 	struct bpf_array *array = container_of(map, struct bpf_array, map);
 	u32 index = *(u32 *)key;
 	void __percpu *pptr;
-	int cpu, off = 0;
-	u32 size;
+	u32 size, cpu;
+	int off = 0;
 
-	if (unlikely(map_flags > BPF_EXIST))
+	cpu = map_flags >> 32;
+	map_flags &= (u32)~0;
+	if (unlikely(map_flags > BPF_F_CPU))
 		/* unknown flags */
 		return -EINVAL;
 
+	if (unlikely((map_flags & BPF_F_CPU) && cpu != BPF_ALL_CPUS &&
+		     cpu >= num_possible_cpus()))
+		/* invalid cpu */
+		return -ERANGE;
+
 	if (unlikely(index >= array->map.max_entries))
 		/* all elements were pre-allocated, cannot insert a new one */
 		return -E2BIG;
@@ -411,10 +430,19 @@ int bpf_percpu_array_update(struct bpf_map *map, void *key, void *value,
 	size = array->elem_size;
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
+			copy_map_value_long(map, per_cpu_ptr(pptr, cpu), value + off);
+			/* same user-provided value is used if BPF_F_CPU is specified,
+			 * otherwise value is an array of per-cpu values.
+			 */
+			if (!(map_flags & BPF_F_CPU))
+				off += size;
+			bpf_obj_free_fields(array->map.record, per_cpu_ptr(pptr, cpu));
+		}
 	}
 	rcu_read_unlock();
 	return 0;
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 0fbfa8532c392..43f19d02bc5ce 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -131,8 +131,11 @@ bool bpf_map_write_active(const struct bpf_map *map)
 	return atomic64_read(&map->writecnt) != 0;
 }
 
-static u32 bpf_map_value_size(const struct bpf_map *map)
+static u32 bpf_map_value_size(const struct bpf_map *map, u64 flags)
 {
+	if ((flags & BPF_F_CPU) && map->map_type == BPF_MAP_TYPE_PERCPU_ARRAY)
+		return round_up(map->value_size, 8);
+
 	if (map->map_type == BPF_MAP_TYPE_PERCPU_HASH ||
 	    map->map_type == BPF_MAP_TYPE_LRU_PERCPU_HASH ||
 	    map->map_type == BPF_MAP_TYPE_PERCPU_ARRAY ||
@@ -314,7 +317,7 @@ static int bpf_map_copy_value(struct bpf_map *map, void *key, void *value,
 	    map->map_type == BPF_MAP_TYPE_LRU_PERCPU_HASH) {
 		err = bpf_percpu_hash_copy(map, key, value);
 	} else if (map->map_type == BPF_MAP_TYPE_PERCPU_ARRAY) {
-		err = bpf_percpu_array_copy(map, key, value);
+		err = bpf_percpu_array_copy(map, key, value, flags);
 	} else if (map->map_type == BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE) {
 		err = bpf_percpu_cgroup_storage_copy(map, key, value);
 	} else if (map->map_type == BPF_MAP_TYPE_STACK_TRACE) {
@@ -1669,7 +1672,10 @@ static int map_lookup_elem(union bpf_attr *attr)
 	if (CHECK_ATTR(BPF_MAP_LOOKUP_ELEM))
 		return -EINVAL;
 
-	if (attr->flags & ~BPF_F_LOCK)
+	if ((u32)attr->flags & ~(BPF_F_LOCK | BPF_F_CPU))
+		return -EINVAL;
+
+	if (!((u32)attr->flags & BPF_F_CPU) && attr->flags >> 32)
 		return -EINVAL;
 
 	CLASS(fd, f)(attr->map_fd);
@@ -1679,7 +1685,7 @@ static int map_lookup_elem(union bpf_attr *attr)
 	if (!(map_get_sys_perms(map, f) & FMODE_CAN_READ))
 		return -EPERM;
 
-	if ((attr->flags & BPF_F_LOCK) &&
+	if (((u32)attr->flags & BPF_F_LOCK) &&
 	    !btf_record_has_field(map->record, BPF_SPIN_LOCK))
 		return -EINVAL;
 
@@ -1687,7 +1693,7 @@ static int map_lookup_elem(union bpf_attr *attr)
 	if (IS_ERR(key))
 		return PTR_ERR(key);
 
-	value_size = bpf_map_value_size(map);
+	value_size = bpf_map_value_size(map, attr->flags);
 
 	err = -ENOMEM;
 	value = kvmalloc(value_size, GFP_USER | __GFP_NOWARN);
@@ -1744,19 +1750,24 @@ static int map_update_elem(union bpf_attr *attr, bpfptr_t uattr)
 		goto err_put;
 	}
 
-	if ((attr->flags & BPF_F_LOCK) &&
+	if (((u32)attr->flags & BPF_F_LOCK) &&
 	    !btf_record_has_field(map->record, BPF_SPIN_LOCK)) {
 		err = -EINVAL;
 		goto err_put;
 	}
 
+	if (!((u32)attr->flags & BPF_F_CPU) && attr->flags >> 32) {
+		err = -EINVAL;
+		goto err_put;
+	}
+
 	key = ___bpf_copy_key(ukey, map->key_size);
 	if (IS_ERR(key)) {
 		err = PTR_ERR(key);
 		goto err_put;
 	}
 
-	value_size = bpf_map_value_size(map);
+	value_size = bpf_map_value_size(map, attr->flags);
 	value = kvmemdup_bpfptr(uvalue, value_size);
 	if (IS_ERR(value)) {
 		err = PTR_ERR(value);
@@ -1942,6 +1953,25 @@ int generic_map_delete_batch(struct bpf_map *map,
 	return err;
 }
 
+static int check_map_batch_elem_flags(struct bpf_map *map, u64 elem_flags)
+{
+	u32 flags = elem_flags;
+
+	if (flags & ~(BPF_F_LOCK | BPF_F_CPU))
+		return -EINVAL;
+
+	if ((flags & BPF_F_LOCK) && !btf_record_has_field(map->record, BPF_SPIN_LOCK))
+		return -EINVAL;
+
+	if (!(flags & BPF_F_CPU) && elem_flags >> 32)
+		return -EINVAL;
+
+	if ((flags & BPF_F_CPU) && map->map_type != BPF_MAP_TYPE_PERCPU_ARRAY)
+		return -EINVAL;
+
+	return 0;
+}
+
 int generic_map_update_batch(struct bpf_map *map, struct file *map_file,
 			     const union bpf_attr *attr,
 			     union bpf_attr __user *uattr)
@@ -1952,15 +1982,11 @@ int generic_map_update_batch(struct bpf_map *map, struct file *map_file,
 	void *key, *value;
 	int err = 0;
 
-	if (attr->batch.elem_flags & ~BPF_F_LOCK)
-		return -EINVAL;
-
-	if ((attr->batch.elem_flags & BPF_F_LOCK) &&
-	    !btf_record_has_field(map->record, BPF_SPIN_LOCK)) {
-		return -EINVAL;
-	}
+	err = check_map_batch_elem_flags(map, attr->batch.elem_flags);
+	if (err)
+		return err;
 
-	value_size = bpf_map_value_size(map);
+	value_size = bpf_map_value_size(map, attr->batch.elem_flags);
 
 	max_count = attr->batch.count;
 	if (!max_count)
@@ -1986,9 +2012,7 @@ int generic_map_update_batch(struct bpf_map *map, struct file *map_file,
 		    copy_from_user(value, values + cp * value_size, value_size))
 			break;
 
-		err = bpf_map_update_value(map, map_file, key, value,
-					   attr->batch.elem_flags);
-
+		err = bpf_map_update_value(map, map_file, key, value, attr->batch.elem_flags);
 		if (err)
 			break;
 		cond_resched();
@@ -2015,14 +2039,11 @@ int generic_map_lookup_batch(struct bpf_map *map,
 	u32 value_size, cp, max_count;
 	int err;
 
-	if (attr->batch.elem_flags & ~BPF_F_LOCK)
-		return -EINVAL;
-
-	if ((attr->batch.elem_flags & BPF_F_LOCK) &&
-	    !btf_record_has_field(map->record, BPF_SPIN_LOCK))
-		return -EINVAL;
+	err = check_map_batch_elem_flags(map, attr->batch.elem_flags);
+	if (err)
+		return err;
 
-	value_size = bpf_map_value_size(map);
+	value_size = bpf_map_value_size(map, attr->batch.elem_flags);
 
 	max_count = attr->batch.count;
 	if (!max_count)
@@ -2056,9 +2077,7 @@ int generic_map_lookup_batch(struct bpf_map *map,
 		rcu_read_unlock();
 		if (err)
 			break;
-		err = bpf_map_copy_value(map, key, value,
-					 attr->batch.elem_flags);
-
+		err = bpf_map_copy_value(map, key, value, attr->batch.elem_flags);
 		if (err == -ENOENT)
 			goto next_key;
 
@@ -2144,7 +2163,7 @@ static int map_lookup_and_delete_elem(union bpf_attr *attr)
 		goto err_put;
 	}
 
-	value_size = bpf_map_value_size(map);
+	value_size = bpf_map_value_size(map, 0);
 
 	err = -ENOMEM;
 	value = kvmalloc(value_size, GFP_USER | __GFP_NOWARN);
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 233de8677382e..67bc35e4d6a8d 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1372,6 +1372,12 @@ enum {
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
-- 
2.50.1


