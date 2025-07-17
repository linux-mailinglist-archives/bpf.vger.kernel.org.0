Return-Path: <bpf+bounces-63662-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ADA29B09511
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 21:38:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81328A60AF5
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 19:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52DEA2FCFE8;
	Thu, 17 Jul 2025 19:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OHzot5dQ"
X-Original-To: bpf@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D989F2080C4
	for <bpf@vger.kernel.org>; Thu, 17 Jul 2025 19:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752781110; cv=none; b=tzYx7Xsg27QTgvmN/TyTFkCh4hpzQ1g/aEtZ/IzUwksY+zRLI4+vQkt51/F2mk/hlBGu+yauxr5kLk+Hy9BVzQrwbYC9LkQRrVQsDdfDT+IuyqSvX80zkLr3AkXdfoabbr8G782EVvfqM+JNKm9NOTETtx+nee531fbE8BdxRo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752781110; c=relaxed/simple;
	bh=l6vlPfgOcLp2PR1P2oclvH6wKP2Pw1RS54eN1mN8+VU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rdl8XkSKkPr9W4JEuWq1k1bgdkdcuI0uCw2TJlUYN7DfrsOIFC4ni+jLTJvCnZ0wPyxVONFOGIPqmx1/dGVsThQtHg0Pt25fR9AZRY8rlYRbLiQ4HpGzuQtww8isQkZJLMmCHJoVIDEhDJ0Yiu1T/2NPwh9hjmaynHdrk1/2IHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OHzot5dQ; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752781105;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rfdWDYDZC2Euk8s420tvjM76rz+U+hlwp6dzf4okguU=;
	b=OHzot5dQ3OU5r67rOhIck783FbmrnPmTAMLEEPB6Hn7zvTtnn5a9EF1MxsP73/6wamiuWP
	OeJihb29hf4cs557WIeKGrNw1KxEaNeazTK0SjumPeeNmkLJw4m0/hhUgbtCITrvjige8M
	75Trk5p+4orQTGqf1MikaCfEUMGKZLY=
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
Subject: [PATCH bpf-next 1/3] bpf: Introduce BPF_F_CPU flag for percpu_array map
Date: Fri, 18 Jul 2025 03:37:54 +0800
Message-ID: <20250717193756.37153-2-leon.hwang@linux.dev>
In-Reply-To: <20250717193756.37153-1-leon.hwang@linux.dev>
References: <20250717193756.37153-1-leon.hwang@linux.dev>
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
 kernel/bpf/arraymap.c          | 54 ++++++++++++++++++++++++++--------
 kernel/bpf/syscall.c           | 52 ++++++++++++++++++++------------
 tools/include/uapi/linux/bpf.h |  7 +++++
 5 files changed, 90 insertions(+), 33 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index f9cd2164ed23..faee5710e913 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2671,7 +2671,8 @@ int map_set_for_each_callback_args(struct bpf_verifier_env *env,
 				   struct bpf_func_state *callee);
 
 int bpf_percpu_hash_copy(struct bpf_map *map, void *key, void *value);
-int bpf_percpu_array_copy(struct bpf_map *map, void *key, void *value);
+int bpf_percpu_array_copy(struct bpf_map *map, void *key, void *value,
+			  u64 flags);
 int bpf_percpu_hash_update(struct bpf_map *map, void *key, void *value,
 			   u64 flags);
 int bpf_percpu_array_update(struct bpf_map *map, void *key, void *value,
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 233de8677382..4cad3de6899d 100644
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
@@ -1549,6 +1555,7 @@ union bpf_attr {
 		__u32		map_fd;
 		__u64		elem_flags;
 		__u64		flags;
+		__u32		cpu;
 	} batch;
 
 	struct { /* anonymous struct used by BPF_PROG_LOAD command */
diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
index 3d080916faf9..d333663cbe71 100644
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
@@ -387,13 +399,20 @@ int bpf_percpu_array_update(struct bpf_map *map, void *key, void *value,
 	struct bpf_array *array = container_of(map, struct bpf_array, map);
 	u32 index = *(u32 *)key;
 	void __percpu *pptr;
-	int cpu, off = 0;
-	u32 size;
+	u32 size, cpu;
+	int off = 0;
 
-	if (unlikely(map_flags > BPF_EXIST))
+	cpu = (u32)(map_flags >> 32);
+	map_flags &= (u32)~0;
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
index e63039817af3..0b49610d5939 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -129,8 +129,11 @@ bool bpf_map_write_active(const struct bpf_map *map)
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
@@ -312,7 +315,7 @@ static int bpf_map_copy_value(struct bpf_map *map, void *key, void *value,
 	    map->map_type == BPF_MAP_TYPE_LRU_PERCPU_HASH) {
 		err = bpf_percpu_hash_copy(map, key, value);
 	} else if (map->map_type == BPF_MAP_TYPE_PERCPU_ARRAY) {
-		err = bpf_percpu_array_copy(map, key, value);
+		err = bpf_percpu_array_copy(map, key, value, flags);
 	} else if (map->map_type == BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE) {
 		err = bpf_percpu_cgroup_storage_copy(map, key, value);
 	} else if (map->map_type == BPF_MAP_TYPE_STACK_TRACE) {
@@ -1662,7 +1665,8 @@ static int map_lookup_elem(union bpf_attr *attr)
 	if (CHECK_ATTR(BPF_MAP_LOOKUP_ELEM))
 		return -EINVAL;
 
-	if (attr->flags & ~BPF_F_LOCK)
+	if (((u32)attr->flags & ~(BPF_F_LOCK | BPF_F_CPU)) ||
+		(!((u32)attr->flags & BPF_F_CPU) && attr->flags >> 32))
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
+	elem_flags |= ((u64)cpu) << 32;
 
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
+	elem_flags |= ((u64)cpu) << 32;
 
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
@@ -5457,7 +5471,7 @@ static int bpf_task_fd_query(const union bpf_attr *attr,
 	return err;
 }
 
-#define BPF_MAP_BATCH_LAST_FIELD batch.flags
+#define BPF_MAP_BATCH_LAST_FIELD batch.cpu
 
 #define BPF_DO_BATCH(fn, ...)			\
 	do {					\
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 233de8677382..4cad3de6899d 100644
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
@@ -1549,6 +1555,7 @@ union bpf_attr {
 		__u32		map_fd;
 		__u64		elem_flags;
 		__u64		flags;
+		__u32		cpu;
 	} batch;
 
 	struct { /* anonymous struct used by BPF_PROG_LOAD command */
-- 
2.50.1


