Return-Path: <bpf+bounces-66686-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14315B387EF
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 18:45:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 455271BA6424
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 16:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04CFC227B9F;
	Wed, 27 Aug 2025 16:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="O/jmVlxC"
X-Original-To: bpf@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873E02114
	for <bpf@vger.kernel.org>; Wed, 27 Aug 2025 16:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756313139; cv=none; b=XgAE0A0K7/v5K4rAB8xdb+xKQb2YYsI068F8Rq+8AEQ38YjrCMqpa/XiimcoCuc/4zU2jAhQyapg1QFh4PweWR592EFk6cP3CM1VOxY6LvaodFZoNzRBSj38Za0cWs41E9T5a9hsACI8fXq8gZ91wSJpsYw+++M5cqX9mCTzvTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756313139; c=relaxed/simple;
	bh=Ez/kHeTlnP/iNvoZjpTbGjI6gu0eZ58XfqpqGrF5FuQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XtDmZXPin8isML+c5bRe+EkOxLa83qKFkP+gmywqDWKwzoWvkETgLE8R3V+zIY3NEo7e5RdYRVpAG2vYEqlUgZ2bnaSKZ0UH5uXSpYnoErbaYY6S615q/WFZogtkvtYRtU+S6SJwk2NnVsFlgdL6T6v3tCAtcHHLVqcH5fuMzA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=O/jmVlxC; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756313134;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N/2jybO3TMOvyQ8djGBVjATqBG0d7eZfFKw1vtKR9Rw=;
	b=O/jmVlxCfqnhd6SKsx7pjYjl9eZO8LineLDR0XIJdPK6jqcgHlAlhFupHA4NIz3B3Ey6Mn
	+sKK6Kjv4RS8gm9O3zuIvqHbzecS7gpbGZ9qhAuGRD3RtC2qveouLScJOFSpA31ISG5J1p
	5vQw3Z15dwqBUZeq9KJjEMwzgN9UjUo=
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
Subject: [PATCH bpf-next v4 2/7] bpf: Introduce BPF_F_CPU and BPF_F_ALL_CPUS flags
Date: Thu, 28 Aug 2025 00:45:04 +0800
Message-ID: <20250827164509.7401-3-leon.hwang@linux.dev>
In-Reply-To: <20250827164509.7401-1-leon.hwang@linux.dev>
References: <20250827164509.7401-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Introduce BPF_F_CPU and BPF_F_ALL_CPUS flags and the following internal
helper functions for percpu maps:

* bpf_percpu_copy_to_user: For lookup_elem and lookup_batch user APIs,
  copy data to user-provided value pointer.
* bpf_percpu_copy_from_user: For update_elem and update_batch user APIs,
  copy data from user-provided value pointer.
* bpf_map_check_cpu_flags: Check BPF_F_CPU, BPF_F_ALL_CPUS and cpu info in
  flags.

And, get the correct value size for these user APIs.

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 include/linux/bpf.h            | 89 ++++++++++++++++++++++++++++++++--
 include/uapi/linux/bpf.h       |  2 +
 kernel/bpf/syscall.c           | 24 ++++-----
 tools/include/uapi/linux/bpf.h |  2 +
 4 files changed, 103 insertions(+), 14 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 512717d442c09..a83364949b64c 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -547,6 +547,56 @@ static inline void copy_map_value_long(struct bpf_map *map, void *dst, void *src
 	bpf_obj_memcpy(map->record, dst, src, map->value_size, true);
 }
 
+#ifdef CONFIG_BPF_SYSCALL
+static inline void bpf_percpu_copy_to_user(struct bpf_map *map, void __percpu *pptr, void *value,
+					   u32 size, u64 flags)
+{
+	int current_cpu = raw_smp_processor_id();
+	int cpu, off = 0;
+
+	if (flags & BPF_F_CPU) {
+		cpu = flags >> 32;
+		copy_map_value_long(map, value, cpu != current_cpu ? per_cpu_ptr(pptr, cpu) :
+				    this_cpu_ptr(pptr));
+		check_and_init_map_value(map, value);
+	} else {
+		for_each_possible_cpu(cpu) {
+			copy_map_value_long(map, value + off, per_cpu_ptr(pptr, cpu));
+			check_and_init_map_value(map, value + off);
+			off += size;
+		}
+	}
+}
+
+void bpf_obj_free_fields(const struct btf_record *rec, void *obj);
+
+static inline void bpf_percpu_copy_from_user(struct bpf_map *map, void __percpu *pptr, void *value,
+					     u32 size, u64 flags)
+{
+	int current_cpu = raw_smp_processor_id();
+	int cpu, off = 0;
+	void *ptr;
+
+	if (flags & BPF_F_CPU) {
+		cpu = flags >> 32;
+		ptr = cpu == current_cpu ? this_cpu_ptr(pptr) : per_cpu_ptr(pptr, cpu);
+		copy_map_value_long(map, ptr, value);
+		bpf_obj_free_fields(map->record, ptr);
+	} else {
+		for_each_possible_cpu(cpu) {
+			copy_map_value_long(map, per_cpu_ptr(pptr, cpu), value + off);
+			/* same user-provided value is used if
+			 * BPF_F_ALL_CPUS is specified, otherwise value is
+			 * an array of per-cpu values.
+			 */
+			if (!(flags & BPF_F_ALL_CPUS))
+				off += size;
+			bpf_obj_free_fields(map->record, per_cpu_ptr(pptr, cpu));
+		}
+	}
+}
+#endif
+
 static inline void bpf_obj_swap_uptrs(const struct btf_record *rec, void *dst, void *src)
 {
 	unsigned long *src_uptr, *dst_uptr;
@@ -2417,7 +2467,6 @@ struct btf_record *btf_record_dup(const struct btf_record *rec);
 bool btf_record_equal(const struct btf_record *rec_a, const struct btf_record *rec_b);
 void bpf_obj_free_timer(const struct btf_record *rec, void *obj);
 void bpf_obj_free_workqueue(const struct btf_record *rec, void *obj);
-void bpf_obj_free_fields(const struct btf_record *rec, void *obj);
 void __bpf_obj_drop_impl(void *p, const struct btf_record *rec, bool percpu);
 
 struct bpf_map *bpf_map_get(u32 ufd);
@@ -3709,14 +3758,25 @@ int bpf_prog_get_file_line(struct bpf_prog *prog, unsigned long ip, const char *
 			   const char **linep, int *nump);
 struct bpf_prog *bpf_prog_find_from_stack(void);
 
+static inline bool bpf_map_supports_cpu_flags(enum bpf_map_type map_type)
+{
+	return false;
+}
+
 static inline int bpf_map_check_op_flags(struct bpf_map *map, u64 flags, u64 extra_flags_mask)
 {
-	if (extra_flags_mask && (flags & extra_flags_mask))
+	if (extra_flags_mask && ((u32)flags & extra_flags_mask))
 		return -EINVAL;
 
 	if ((flags & BPF_F_LOCK) && !btf_record_has_field(map->record, BPF_SPIN_LOCK))
 		return -EINVAL;
 
+	if (!(flags & BPF_F_CPU) && flags >> 32)
+		return -EINVAL;
+
+	if ((flags & (BPF_F_CPU | BPF_F_ALL_CPUS)) && !bpf_map_supports_cpu_flags(map->map_type))
+		return -EINVAL;
+
 	return 0;
 }
 
@@ -3725,7 +3785,7 @@ static inline int bpf_map_check_update_flags(struct bpf_map *map, u64 flags)
 	return bpf_map_check_op_flags(map, flags, 0);
 }
 
-#define BPF_MAP_LOOKUP_ELEM_EXTRA_FLAGS_MASK (~BPF_F_LOCK)
+#define BPF_MAP_LOOKUP_ELEM_EXTRA_FLAGS_MASK (~(BPF_F_LOCK | BPF_F_CPU | BPF_F_ALL_CPUS))
 
 static inline int bpf_map_check_lookup_flags(struct bpf_map *map, u64 flags)
 {
@@ -3737,4 +3797,27 @@ static inline int bpf_map_check_batch_flags(struct bpf_map *map, u64 flags)
 	return bpf_map_check_op_flags(map, flags, BPF_MAP_LOOKUP_ELEM_EXTRA_FLAGS_MASK);
 }
 
+static inline int bpf_map_check_cpu_flags(u64 flags, bool check_all_cpus_flag)
+{
+	const u64 cpu_flags = BPF_F_CPU | BPF_F_ALL_CPUS;
+	u32 cpu;
+
+	if (check_all_cpus_flag) {
+		if (unlikely((u32)flags > BPF_F_ALL_CPUS))
+			/* unknown flags */
+			return -EINVAL;
+		if (unlikely((flags & cpu_flags) == cpu_flags))
+			return -EINVAL;
+	} else {
+		if (unlikely((u32)flags & ~BPF_F_CPU))
+			return -EINVAL;
+	}
+
+	cpu = flags >> 32;
+	if (unlikely((flags & BPF_F_CPU) && cpu >= num_possible_cpus()))
+		return -ERANGE;
+
+	return 0;
+}
+
 #endif /* _LINUX_BPF_H */
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
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 4e04b35944a2b..dbd21484d7a4d 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -131,12 +131,14 @@ bool bpf_map_write_active(const struct bpf_map *map)
 	return atomic64_read(&map->writecnt) != 0;
 }
 
-static u32 bpf_map_value_size(const struct bpf_map *map)
-{
-	if (map->map_type == BPF_MAP_TYPE_PERCPU_HASH ||
-	    map->map_type == BPF_MAP_TYPE_LRU_PERCPU_HASH ||
-	    map->map_type == BPF_MAP_TYPE_PERCPU_ARRAY ||
-	    map->map_type == BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE)
+static u32 bpf_map_value_size(const struct bpf_map *map, u64 flags)
+{
+	if (flags & (BPF_F_CPU | BPF_F_ALL_CPUS))
+		return round_up(map->value_size, 8);
+	else if (map->map_type == BPF_MAP_TYPE_PERCPU_HASH ||
+		 map->map_type == BPF_MAP_TYPE_LRU_PERCPU_HASH ||
+		 map->map_type == BPF_MAP_TYPE_PERCPU_ARRAY ||
+		 map->map_type == BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE)
 		return round_up(map->value_size, 8) * num_possible_cpus();
 	else if (IS_FD_MAP(map))
 		return sizeof(u32);
@@ -1684,7 +1686,7 @@ static int map_lookup_elem(union bpf_attr *attr)
 	if (IS_ERR(key))
 		return PTR_ERR(key);
 
-	value_size = bpf_map_value_size(map);
+	value_size = bpf_map_value_size(map, attr->flags);
 
 	err = -ENOMEM;
 	value = kvmalloc(value_size, GFP_USER | __GFP_NOWARN);
@@ -1751,7 +1753,7 @@ static int map_update_elem(union bpf_attr *attr, bpfptr_t uattr)
 		goto err_put;
 	}
 
-	value_size = bpf_map_value_size(map);
+	value_size = bpf_map_value_size(map, attr->flags);
 	value = kvmemdup_bpfptr(uvalue, value_size);
 	if (IS_ERR(value)) {
 		err = PTR_ERR(value);
@@ -1951,7 +1953,7 @@ int generic_map_update_batch(struct bpf_map *map, struct file *map_file,
 	if (err)
 		return err;
 
-	value_size = bpf_map_value_size(map);
+	value_size = bpf_map_value_size(map, attr->batch.elem_flags);
 
 	max_count = attr->batch.count;
 	if (!max_count)
@@ -2010,7 +2012,7 @@ int generic_map_lookup_batch(struct bpf_map *map,
 	if (err)
 		return err;
 
-	value_size = bpf_map_value_size(map);
+	value_size = bpf_map_value_size(map, attr->batch.elem_flags);
 
 	max_count = attr->batch.count;
 	if (!max_count)
@@ -2132,7 +2134,7 @@ static int map_lookup_and_delete_elem(union bpf_attr *attr)
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


