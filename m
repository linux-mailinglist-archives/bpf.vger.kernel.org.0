Return-Path: <bpf+bounces-66236-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0283BB2FFB8
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 18:13:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83D68A00549
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 16:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 344AA29D272;
	Thu, 21 Aug 2025 16:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="o/N85/fk"
X-Original-To: bpf@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 713E62E1EF0
	for <bpf@vger.kernel.org>; Thu, 21 Aug 2025 16:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755792535; cv=none; b=EFVf+d7TV0IzAGlzuyen1RJwhEXso8IE9+b/Qh3k7gSdncgUbNK/cXCshYBA92rKd43RqOX1aa8HZZWCXw6eGRViXKFBWmD1UabaCZQrHgKOTIzTMr9EDT/OeBq7WRfC0AAuESUdoM0mI8LDmTucd0C4S8xOR3ukS4gl5eWUuBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755792535; c=relaxed/simple;
	bh=JyJ4nfNYuwhkqW1EE8o6XChixNyihEr73Wl8lv3+bxY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LN7GBtoJPX6FmDq2HLX53P870aBfqMzJifHJsf8/R0+8NoSBQDZg+CVWYpcOn3L4DZxZNO5OdDMYib8wK+01viTniQH0OT3CPGMJRmNr5DF6KJ1V3wI2y1krfCzNl9lu7ZrdTnvdxTOTjVeXSweCvDwiDB8tnkKb5hT3Q/aCG/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=o/N85/fk; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755792531;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8VJKU0IJeyorfIWZdbnyPaFS3wewMSbNYB6Vj6n7ii0=;
	b=o/N85/fk7baxznmKX6QyP14+7btDmrEZPdHXMHy4zN10/iuVEhc2vE0341/jvHaZ+WLjFl
	Ixxwh3tPuNePtRNXuR0+qH/gBztxvCmR8SCWD0AgwoDREfrLr3wamgJGC1UOmnQh1xcazo
	nvue0W7BVS9/3b4h6nQjV/wgY+HMalA=
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
Subject: [PATCH bpf-next v3 3/6] bpf: Introduce BPF_F_CPU flag for percpu_hash and lru_percpu_hash maps
Date: Fri, 22 Aug 2025 00:08:14 +0800
Message-ID: <20250821160817.70285-4-leon.hwang@linux.dev>
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

Introduce BPF_F_ALL_CPUS flag support for percpu_hash and lru_percpu_hash
maps to allow updating values for all CPUs with a single value.

Introduce BPF_F_CPU flag support for percpu_hash and lru_percpu_hash
maps to allow updating value for specified CPU.

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
 include/linux/bpf.h   |  54 +++++++++++++++++++-
 kernel/bpf/arraymap.c |  29 ++++-------
 kernel/bpf/hashtab.c  | 111 +++++++++++++++++++++++++++++-------------
 kernel/bpf/syscall.c  |  30 +++---------
 4 files changed, 147 insertions(+), 77 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index b2191b1e455a6..dc715eef9cbf4 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2696,7 +2696,7 @@ int map_set_for_each_callback_args(struct bpf_verifier_env *env,
 				   struct bpf_func_state *caller,
 				   struct bpf_func_state *callee);
 
-int bpf_percpu_hash_copy(struct bpf_map *map, void *key, void *value);
+int bpf_percpu_hash_copy(struct bpf_map *map, void *key, void *value, u64 flags);
 int bpf_percpu_array_copy(struct bpf_map *map, void *key, void *value,
 			  u64 flags);
 int bpf_percpu_hash_update(struct bpf_map *map, void *key, void *value,
@@ -3710,4 +3710,56 @@ int bpf_prog_get_file_line(struct bpf_prog *prog, unsigned long ip, const char *
 			   const char **linep, int *nump);
 struct bpf_prog *bpf_prog_find_from_stack(void);
 
+static inline int bpf_map_check_cpu_flags(u64 flags, bool check_all_cpus)
+{
+	const u64 cpu_flags = BPF_F_CPU | BPF_F_ALL_CPUS;
+	u32 cpu;
+
+	if (check_all_cpus) {
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
+static inline bool bpf_map_support_cpu_flags(enum bpf_map_type map_type)
+{
+	switch (map_type) {
+	case BPF_MAP_TYPE_PERCPU_ARRAY:
+	case BPF_MAP_TYPE_PERCPU_HASH:
+	case BPF_MAP_TYPE_LRU_PERCPU_HASH:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static inline int bpf_map_check_flags(struct bpf_map *map, u64 flags, bool check_flag)
+{
+	if (check_flag && ((u32)flags & ~(BPF_F_LOCK | BPF_F_CPU | BPF_F_ALL_CPUS)))
+		return -EINVAL;
+
+	if ((flags & BPF_F_LOCK) && !btf_record_has_field(map->record, BPF_SPIN_LOCK))
+		return -EINVAL;
+
+	if (!(flags & BPF_F_CPU) && flags >> 32)
+		return -EINVAL;
+
+	if ((flags & (BPF_F_CPU | BPF_F_ALL_CPUS)) && !bpf_map_support_cpu_flags(map->map_type))
+		return -EINVAL;
+
+	return 0;
+}
+
 #endif /* _LINUX_BPF_H */
diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
index 1efa730105e24..f7646bcabb3c8 100644
--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -300,18 +300,15 @@ int bpf_percpu_array_copy(struct bpf_map *map, void *key, void *value, u64 flags
 	struct bpf_array *array = container_of(map, struct bpf_array, map);
 	u32 index = *(u32 *)key;
 	void __percpu *pptr;
+	int off = 0, err;
 	u32 size, cpu;
-	int off = 0;
 
 	if (unlikely(index >= array->map.max_entries))
 		return -ENOENT;
 
-	if (unlikely((u32)flags & ~BPF_F_CPU))
-		return -EINVAL;
-
-	cpu = flags >> 32;
-	if (unlikely((flags & BPF_F_CPU) && cpu >= num_possible_cpus()))
-		return -ERANGE;
+	err = bpf_map_check_cpu_flags(flags, false);
+	if (unlikely(err))
+		return err;
 
 	/* per_cpu areas are zero-filled and bpf programs can only
 	 * access 'value_size' of them, so copying rounded areas
@@ -321,6 +318,7 @@ int bpf_percpu_array_copy(struct bpf_map *map, void *key, void *value, u64 flags
 	rcu_read_lock();
 	pptr = array->pptrs[index & array->index_mask];
 	if (flags & BPF_F_CPU) {
+		cpu = flags >> 32;
 		copy_map_value_long(map, value, per_cpu_ptr(pptr, cpu));
 		check_and_init_map_value(map, value);
 	} else {
@@ -397,22 +395,14 @@ int bpf_percpu_array_update(struct bpf_map *map, void *key, void *value,
 			    u64 map_flags)
 {
 	struct bpf_array *array = container_of(map, struct bpf_array, map);
-	const u64 cpu_flags = BPF_F_CPU | BPF_F_ALL_CPUS;
 	u32 index = *(u32 *)key;
 	void __percpu *pptr;
+	int off = 0, err;
 	u32 size, cpu;
-	int off = 0;
-
-	if (unlikely((u32)map_flags > BPF_F_ALL_CPUS))
-		/* unknown flags */
-		return -EINVAL;
-	if (unlikely((map_flags & cpu_flags) == cpu_flags))
-		return -EINVAL;
 
-	cpu = map_flags >> 32;
-	if (unlikely((map_flags & BPF_F_CPU) && cpu >= num_possible_cpus()))
-		/* invalid cpu */
-		return -ERANGE;
+	err = bpf_map_check_cpu_flags(map_flags, true);
+	if (unlikely(err))
+		return err;
 
 	if (unlikely(index >= array->map.max_entries))
 		/* all elements were pre-allocated, cannot insert a new one */
@@ -432,6 +422,7 @@ int bpf_percpu_array_update(struct bpf_map *map, void *key, void *value,
 	rcu_read_lock();
 	pptr = array->pptrs[index & array->index_mask];
 	if (map_flags & BPF_F_CPU) {
+		cpu = map_flags >> 32;
 		copy_map_value_long(map, per_cpu_ptr(pptr, cpu), value);
 		bpf_obj_free_fields(array->map.record, per_cpu_ptr(pptr, cpu));
 	} else {
diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 71f9931ac64cd..34a35cdade425 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -937,24 +937,39 @@ static void free_htab_elem(struct bpf_htab *htab, struct htab_elem *l)
 }
 
 static void pcpu_copy_value(struct bpf_htab *htab, void __percpu *pptr,
-			    void *value, bool onallcpus)
+			    void *value, bool onallcpus, u64 map_flags)
 {
+	int cpu = map_flags & BPF_F_CPU ? map_flags >> 32 : 0;
+	int current_cpu = raw_smp_processor_id();
+
 	if (!onallcpus) {
 		/* copy true value_size bytes */
-		copy_map_value(&htab->map, this_cpu_ptr(pptr), value);
+		copy_map_value(&htab->map, (map_flags & BPF_F_CPU) && cpu != current_cpu ?
+			       per_cpu_ptr(pptr, cpu) : this_cpu_ptr(pptr), value);
 	} else {
 		u32 size = round_up(htab->map.value_size, 8);
-		int off = 0, cpu;
+		int off = 0;
+
+		if (map_flags & BPF_F_CPU) {
+			copy_map_value_long(&htab->map, cpu != current_cpu ?
+					    per_cpu_ptr(pptr, cpu) : this_cpu_ptr(pptr), value);
+			return;
+		}
 
 		for_each_possible_cpu(cpu) {
 			copy_map_value_long(&htab->map, per_cpu_ptr(pptr, cpu), value + off);
-			off += size;
+			/* same user-provided value is used if
+			 * BPF_F_ALL_CPUS is specified, otherwise value is
+			 * an array of per-cpu values.
+			 */
+			if (!(map_flags & BPF_F_ALL_CPUS))
+				off += size;
 		}
 	}
 }
 
 static void pcpu_init_value(struct bpf_htab *htab, void __percpu *pptr,
-			    void *value, bool onallcpus)
+			    void *value, bool onallcpus, u64 map_flags)
 {
 	/* When not setting the initial value on all cpus, zero-fill element
 	 * values for other cpus. Otherwise, bpf program has no way to ensure
@@ -972,7 +987,7 @@ static void pcpu_init_value(struct bpf_htab *htab, void __percpu *pptr,
 				zero_map_value(&htab->map, per_cpu_ptr(pptr, cpu));
 		}
 	} else {
-		pcpu_copy_value(htab, pptr, value, onallcpus);
+		pcpu_copy_value(htab, pptr, value, onallcpus, map_flags);
 	}
 }
 
@@ -984,7 +999,7 @@ static bool fd_htab_map_needs_adjust(const struct bpf_htab *htab)
 static struct htab_elem *alloc_htab_elem(struct bpf_htab *htab, void *key,
 					 void *value, u32 key_size, u32 hash,
 					 bool percpu, bool onallcpus,
-					 struct htab_elem *old_elem)
+					 struct htab_elem *old_elem, u64 map_flags)
 {
 	u32 size = htab->map.value_size;
 	bool prealloc = htab_is_prealloc(htab);
@@ -1042,7 +1057,7 @@ static struct htab_elem *alloc_htab_elem(struct bpf_htab *htab, void *key,
 			pptr = *(void __percpu **)ptr;
 		}
 
-		pcpu_init_value(htab, pptr, value, onallcpus);
+		pcpu_init_value(htab, pptr, value, onallcpus, map_flags);
 
 		if (!prealloc)
 			htab_elem_set_ptr(l_new, key_size, pptr);
@@ -1147,7 +1162,7 @@ static long htab_map_update_elem(struct bpf_map *map, void *key, void *value,
 	}
 
 	l_new = alloc_htab_elem(htab, key, value, key_size, hash, false, false,
-				l_old);
+				l_old, map_flags);
 	if (IS_ERR(l_new)) {
 		/* all pre-allocated elements are in use or memory exhausted */
 		ret = PTR_ERR(l_new);
@@ -1263,9 +1278,15 @@ static long htab_map_update_elem_in_place(struct bpf_map *map, void *key,
 	u32 key_size, hash;
 	int ret;
 
-	if (unlikely(map_flags > BPF_EXIST))
-		/* unknown flags */
-		return -EINVAL;
+	if (percpu) {
+		ret = bpf_map_check_cpu_flags(map_flags, true);
+		if (unlikely(ret))
+			return ret;
+	} else {
+		if (unlikely(map_flags > BPF_EXIST))
+			/* unknown flags */
+			return -EINVAL;
+	}
 
 	WARN_ON_ONCE(!rcu_read_lock_held() && !rcu_read_lock_trace_held() &&
 		     !rcu_read_lock_bh_held());
@@ -1291,7 +1312,7 @@ static long htab_map_update_elem_in_place(struct bpf_map *map, void *key,
 		/* Update value in-place */
 		if (percpu) {
 			pcpu_copy_value(htab, htab_elem_get_ptr(l_old, key_size),
-					value, onallcpus);
+					value, onallcpus, map_flags);
 		} else {
 			void **inner_map_pptr = htab_elem_value(l_old, key_size);
 
@@ -1300,7 +1321,7 @@ static long htab_map_update_elem_in_place(struct bpf_map *map, void *key,
 		}
 	} else {
 		l_new = alloc_htab_elem(htab, key, value, key_size,
-					hash, percpu, onallcpus, NULL);
+					hash, percpu, onallcpus, NULL, map_flags);
 		if (IS_ERR(l_new)) {
 			ret = PTR_ERR(l_new);
 			goto err;
@@ -1326,9 +1347,9 @@ static long __htab_lru_percpu_map_update_elem(struct bpf_map *map, void *key,
 	u32 key_size, hash;
 	int ret;
 
-	if (unlikely(map_flags > BPF_EXIST))
-		/* unknown flags */
-		return -EINVAL;
+	ret = bpf_map_check_cpu_flags(map_flags, true);
+	if (unlikely(ret))
+		return ret;
 
 	WARN_ON_ONCE(!rcu_read_lock_held() && !rcu_read_lock_trace_held() &&
 		     !rcu_read_lock_bh_held());
@@ -1366,10 +1387,10 @@ static long __htab_lru_percpu_map_update_elem(struct bpf_map *map, void *key,
 
 		/* per-cpu hash map can update value in-place */
 		pcpu_copy_value(htab, htab_elem_get_ptr(l_old, key_size),
-				value, onallcpus);
+				value, onallcpus, map_flags);
 	} else {
 		pcpu_init_value(htab, htab_elem_get_ptr(l_new, key_size),
-				value, onallcpus);
+				value, onallcpus, map_flags);
 		hlist_nulls_add_head_rcu(&l_new->hash_node, head);
 		l_new = NULL;
 	}
@@ -1698,9 +1719,16 @@ __htab_map_lookup_and_delete_batch(struct bpf_map *map,
 	int ret = 0;
 
 	elem_map_flags = attr->batch.elem_flags;
-	if ((elem_map_flags & ~BPF_F_LOCK) ||
-	    ((elem_map_flags & BPF_F_LOCK) && !btf_record_has_field(map->record, BPF_SPIN_LOCK)))
-		return -EINVAL;
+	if (!do_delete && is_percpu) {
+		ret = bpf_map_check_flags(map, elem_map_flags, false);
+		if (ret)
+			return ret;
+	} else {
+		if ((elem_map_flags & ~BPF_F_LOCK) ||
+		    ((elem_map_flags & BPF_F_LOCK) &&
+		     !btf_record_has_field(map->record, BPF_SPIN_LOCK)))
+			return -EINVAL;
+	}
 
 	map_flags = attr->batch.flags;
 	if (map_flags)
@@ -1806,10 +1834,17 @@ __htab_map_lookup_and_delete_batch(struct bpf_map *map,
 			void __percpu *pptr;
 
 			pptr = htab_elem_get_ptr(l, map->key_size);
-			for_each_possible_cpu(cpu) {
-				copy_map_value_long(&htab->map, dst_val + off, per_cpu_ptr(pptr, cpu));
-				check_and_init_map_value(&htab->map, dst_val + off);
-				off += size;
+			if (!do_delete && (elem_map_flags & BPF_F_CPU)) {
+				cpu = elem_map_flags >> 32;
+				copy_map_value_long(&htab->map, dst_val, per_cpu_ptr(pptr, cpu));
+				check_and_init_map_value(&htab->map, dst_val);
+			} else {
+				for_each_possible_cpu(cpu) {
+					copy_map_value_long(&htab->map, dst_val + off,
+							    per_cpu_ptr(pptr, cpu));
+					check_and_init_map_value(&htab->map, dst_val + off);
+					off += size;
+				}
 			}
 		} else {
 			value = htab_elem_value(l, key_size);
@@ -2365,14 +2400,18 @@ static void *htab_lru_percpu_map_lookup_percpu_elem(struct bpf_map *map, void *k
 	return NULL;
 }
 
-int bpf_percpu_hash_copy(struct bpf_map *map, void *key, void *value)
+int bpf_percpu_hash_copy(struct bpf_map *map, void *key, void *value, u64 map_flags)
 {
+	int ret, cpu, off = 0;
 	struct htab_elem *l;
 	void __percpu *pptr;
-	int ret = -ENOENT;
-	int cpu, off = 0;
 	u32 size;
 
+	ret = bpf_map_check_cpu_flags(map_flags, false);
+	if (unlikely(ret))
+		return ret;
+	ret = -ENOENT;
+
 	/* per_cpu areas are zero-filled and bpf programs can only
 	 * access 'value_size' of them, so copying rounded areas
 	 * will not leak any kernel data
@@ -2386,10 +2425,16 @@ int bpf_percpu_hash_copy(struct bpf_map *map, void *key, void *value)
 	 * eviction heuristics when user space does a map walk.
 	 */
 	pptr = htab_elem_get_ptr(l, map->key_size);
-	for_each_possible_cpu(cpu) {
-		copy_map_value_long(map, value + off, per_cpu_ptr(pptr, cpu));
-		check_and_init_map_value(map, value + off);
-		off += size;
+	if (map_flags & BPF_F_CPU) {
+		cpu = map_flags >> 32;
+		copy_map_value_long(map, value, per_cpu_ptr(pptr, cpu));
+		check_and_init_map_value(map, value);
+	} else {
+		for_each_possible_cpu(cpu) {
+			copy_map_value_long(map, value + off, per_cpu_ptr(pptr, cpu));
+			check_and_init_map_value(map, value + off);
+			off += size;
+		}
 	}
 	ret = 0;
 out:
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 6251ac9bc7e42..430f013f38f06 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -133,7 +133,7 @@ bool bpf_map_write_active(const struct bpf_map *map)
 
 static u32 bpf_map_value_size(const struct bpf_map *map, u64 flags)
 {
-	if (map->map_type == BPF_MAP_TYPE_PERCPU_ARRAY && (flags & (BPF_F_CPU | BPF_F_ALL_CPUS)))
+	if (bpf_map_support_cpu_flags(map->map_type) && (flags & (BPF_F_CPU | BPF_F_ALL_CPUS)))
 		return round_up(map->value_size, 8);
 	else if (map->map_type == BPF_MAP_TYPE_PERCPU_HASH ||
 	    map->map_type == BPF_MAP_TYPE_LRU_PERCPU_HASH ||
@@ -314,7 +314,7 @@ static int bpf_map_copy_value(struct bpf_map *map, void *key, void *value,
 	bpf_disable_instrumentation();
 	if (map->map_type == BPF_MAP_TYPE_PERCPU_HASH ||
 	    map->map_type == BPF_MAP_TYPE_LRU_PERCPU_HASH) {
-		err = bpf_percpu_hash_copy(map, key, value);
+		err = bpf_percpu_hash_copy(map, key, value, flags);
 	} else if (map->map_type == BPF_MAP_TYPE_PERCPU_ARRAY) {
 		err = bpf_percpu_array_copy(map, key, value, flags);
 	} else if (map->map_type == BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE) {
@@ -1656,24 +1656,6 @@ static void *___bpf_copy_key(bpfptr_t ukey, u64 key_size)
 	return NULL;
 }
 
-static int check_map_flags(struct bpf_map *map, u64 flags, bool check_flag)
-{
-	if (check_flag && ((u32)flags & ~(BPF_F_LOCK | BPF_F_CPU | BPF_F_ALL_CPUS)))
-		return -EINVAL;
-
-	if ((flags & BPF_F_LOCK) && !btf_record_has_field(map->record, BPF_SPIN_LOCK))
-		return -EINVAL;
-
-	if (!(flags & BPF_F_CPU) && flags >> 32)
-		return -EINVAL;
-
-	if ((flags & (BPF_F_CPU | BPF_F_ALL_CPUS)) &&
-		map->map_type != BPF_MAP_TYPE_PERCPU_ARRAY)
-		return -EINVAL;
-
-	return 0;
-}
-
 /* last field in 'union bpf_attr' used by this command */
 #define BPF_MAP_LOOKUP_ELEM_LAST_FIELD flags
 
@@ -1696,7 +1678,7 @@ static int map_lookup_elem(union bpf_attr *attr)
 	if (!(map_get_sys_perms(map, f) & FMODE_CAN_READ))
 		return -EPERM;
 
-	err = check_map_flags(map, attr->flags, true);
+	err = bpf_map_check_flags(map, attr->flags, true);
 	if (err)
 		return err;
 
@@ -1761,7 +1743,7 @@ static int map_update_elem(union bpf_attr *attr, bpfptr_t uattr)
 		goto err_put;
 	}
 
-	err = check_map_flags(map, attr->flags, false);
+	err = bpf_map_check_flags(map, attr->flags, false);
 	if (err)
 		goto err_put;
 
@@ -1967,7 +1949,7 @@ int generic_map_update_batch(struct bpf_map *map, struct file *map_file,
 	void *key, *value;
 	int err = 0;
 
-	err = check_map_flags(map, attr->batch.elem_flags, true);
+	err = bpf_map_check_flags(map, attr->batch.elem_flags, true);
 	if (err)
 		return err;
 
@@ -2026,7 +2008,7 @@ int generic_map_lookup_batch(struct bpf_map *map,
 	u32 value_size, cp, max_count;
 	int err;
 
-	err = check_map_flags(map, attr->batch.elem_flags, true);
+	err = bpf_map_check_flags(map, attr->batch.elem_flags, true);
 	if (err)
 		return err;
 
-- 
2.50.1


