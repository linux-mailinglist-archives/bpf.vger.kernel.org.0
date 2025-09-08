Return-Path: <bpf+bounces-67717-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 29E40B491BC
	for <lists+bpf@lfdr.de>; Mon,  8 Sep 2025 16:38:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 109C34E1C45
	for <lists+bpf@lfdr.de>; Mon,  8 Sep 2025 14:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DCBF30C610;
	Mon,  8 Sep 2025 14:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nwGVLZcC"
X-Original-To: bpf@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B0C30B52B
	for <bpf@vger.kernel.org>; Mon,  8 Sep 2025 14:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757342249; cv=none; b=pgKlgfG4hyAhqZQjDhZH8NIZmN+MwX67R35EWdSO/A1KL2/k+Ccr2JbdWRCKwIdjkM3GDDN0PlepksFA6J7lt6rcgSG3OzRWpDN5EDJODdGCqelyO7wXEGJMNzOpqRKE04Iov5x3nks79xR7IOUGAOeTX0v0q9Z7IUH2n5iIHuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757342249; c=relaxed/simple;
	bh=CLfmXdeGD+c3vd7WqtUxCpe5I78F4xqMGesIU7obowA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tutg2NDpZwCTqXldals6pQbSW17ZPa1hFSnccFdpXHlflDUFjdO7l7VM4i2XGSbeqtGCJZzFCnJRitYXwABBTX88AzHUHhMtt/2bjsBQJEHoeJxwKDN+I3gxB+WqxsCSLG7/4uwQmbN/wMx3fC32/XGgKvDE8AG4T5Xe1KuJPKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nwGVLZcC; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757342245;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dVZMF4fQygH/XuiRVTOifjfA6I1AaOPc++J9FopmgUM=;
	b=nwGVLZcCvqufb/a8pdufQlXY2dYOfy72Wpns750tnXlCXYOowueI4e/f1SN9Jlrr356i4N
	5XbJEg2VSBUe1hBFYjGUtJ87p0WB0tg4aDxINSuwzF53Jrw6SCYGOjbEGSNaCQNdJNt5b7
	SDm67YC7an8R1dTBvCwDjaM+ZxVn80o=
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
Subject: [PATCH bpf-next v5 4/9] bpf: Add BPF_F_CPU and BPF_F_ALL_CPUS flags support for percpu maps data copying
Date: Mon,  8 Sep 2025 22:36:39 +0800
Message-ID: <20250908143644.30993-5-leon.hwang@linux.dev>
In-Reply-To: <20250908143644.30993-1-leon.hwang@linux.dev>
References: <20250908143644.30993-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add BPF_F_CPU and BPF_F_ALL_CPUS flags support in the following
functions:

* 'bpf_percpu_copy_data()'
* 'bpf_percpu_update_data()'

As a result, all percpu maps have to provide map flags for them.

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 include/linux/bpf-cgroup.h |  4 ++--
 include/linux/bpf.h        | 27 ++++++++++++++++++++++-----
 kernel/bpf/arraymap.c      |  6 +++---
 kernel/bpf/hashtab.c       | 30 +++++++++++++++---------------
 kernel/bpf/local_storage.c |  6 +++---
 kernel/bpf/syscall.c       |  6 +++---
 6 files changed, 48 insertions(+), 31 deletions(-)

diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
index aedf573bdb426..013f4db9903fd 100644
--- a/include/linux/bpf-cgroup.h
+++ b/include/linux/bpf-cgroup.h
@@ -172,7 +172,7 @@ void bpf_cgroup_storage_link(struct bpf_cgroup_storage *storage,
 void bpf_cgroup_storage_unlink(struct bpf_cgroup_storage *storage);
 int bpf_cgroup_storage_assign(struct bpf_prog_aux *aux, struct bpf_map *map);
 
-int bpf_percpu_cgroup_storage_copy(struct bpf_map *map, void *key, void *value);
+int bpf_percpu_cgroup_storage_copy(struct bpf_map *map, void *key, void *value, u64 flags);
 int bpf_percpu_cgroup_storage_update(struct bpf_map *map, void *key,
 				     void *value, u64 flags);
 
@@ -467,7 +467,7 @@ static inline struct bpf_cgroup_storage *bpf_cgroup_storage_alloc(
 static inline void bpf_cgroup_storage_free(
 	struct bpf_cgroup_storage *storage) {}
 static inline int bpf_percpu_cgroup_storage_copy(struct bpf_map *map, void *key,
-						 void *value) {
+						 void *value, u64 flags) {
 	return 0;
 }
 static inline int bpf_percpu_cgroup_storage_update(struct bpf_map *map,
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index a78e07b0cb6cb..ef7f7c6a864c2 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -549,10 +549,16 @@ static inline void copy_map_value_long(struct bpf_map *map, void *dst, void *src
 
 #ifdef CONFIG_BPF_SYSCALL
 static inline void bpf_percpu_copy_data(struct bpf_map *map, void __percpu *pptr, void *value,
-					u32 size)
+					u32 size, u64 flags)
 {
 	int cpu, off = 0;
 
+	if (flags & BPF_F_CPU) {
+		cpu = flags >> 32;
+		copy_map_value_long(map, value, per_cpu_ptr(pptr, cpu));
+		return;
+	}
+
 	for_each_possible_cpu(cpu) {
 		copy_map_value_long(map, value + off, per_cpu_ptr(pptr, cpu));
 		off += size;
@@ -562,14 +568,25 @@ static inline void bpf_percpu_copy_data(struct bpf_map *map, void __percpu *pptr
 void bpf_obj_free_fields(const struct btf_record *rec, void *obj);
 
 static inline void bpf_percpu_update_data(struct bpf_map *map, void __percpu *pptr, void *value,
-					  u32 size)
+					  u32 size, u64 flags)
 {
 	int cpu, off = 0;
 
+	if (flags & BPF_F_CPU) {
+		cpu = flags >> 32;
+		bpf_obj_free_fields(map->record, per_cpu_ptr(pptr, cpu));
+		bpf_long_memcpy(per_cpu_ptr(pptr, cpu), value, size);
+		return;
+	}
+
 	for_each_possible_cpu(cpu) {
 		bpf_obj_free_fields(map->record, per_cpu_ptr(pptr, cpu));
 		bpf_long_memcpy(per_cpu_ptr(pptr, cpu), value + off, size);
-		off += size;
+		/* same user-provided value is used if BPF_F_ALL_CPUS is
+		 * specified, otherwise value is an array of per-cpu values.
+		 */
+		if (!(flags & BPF_F_ALL_CPUS))
+			off += size;
 	}
 }
 #endif
@@ -2722,8 +2739,8 @@ int map_set_for_each_callback_args(struct bpf_verifier_env *env,
 				   struct bpf_func_state *caller,
 				   struct bpf_func_state *callee);
 
-int bpf_percpu_hash_copy(struct bpf_map *map, void *key, void *value);
-int bpf_percpu_array_copy(struct bpf_map *map, void *key, void *value);
+int bpf_percpu_hash_copy(struct bpf_map *map, void *key, void *value, u64 flags);
+int bpf_percpu_array_copy(struct bpf_map *map, void *key, void *value, u64 flags);
 int bpf_percpu_hash_update(struct bpf_map *map, void *key, void *value,
 			   u64 flags);
 int bpf_percpu_array_update(struct bpf_map *map, void *key, void *value,
diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
index ed9e47dc4137b..d02cce3202840 100644
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
@@ -312,7 +312,7 @@ int bpf_percpu_array_copy(struct bpf_map *map, void *key, void *value)
 	size = array->elem_size;
 	rcu_read_lock();
 	pptr = array->pptrs[index & array->index_mask];
-	bpf_percpu_copy_data(map, pptr, value, size);
+	bpf_percpu_copy_data(map, pptr, value, size, map_flags);
 	rcu_read_unlock();
 	return 0;
 }
@@ -405,7 +405,7 @@ int bpf_percpu_array_update(struct bpf_map *map, void *key, void *value,
 	size = array->elem_size;
 	rcu_read_lock();
 	pptr = array->pptrs[index & array->index_mask];
-	bpf_percpu_update_data(map, pptr, value, size);
+	bpf_percpu_update_data(map, pptr, value, size, map_flags);
 	rcu_read_unlock();
 	return 0;
 }
diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 0a2c1042d5fdb..8955ae8482065 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -937,7 +937,7 @@ static void free_htab_elem(struct bpf_htab *htab, struct htab_elem *l)
 }
 
 static void pcpu_copy_value(struct bpf_htab *htab, void __percpu *pptr,
-			    void *value, bool onallcpus)
+			    void *value, bool onallcpus, u64 map_flags)
 {
 	if (!onallcpus) {
 		/* copy true value_size bytes */
@@ -945,12 +945,12 @@ static void pcpu_copy_value(struct bpf_htab *htab, void __percpu *pptr,
 	} else {
 		u32 size = round_up(htab->map.value_size, 8);
 
-		bpf_percpu_update_data(&htab->map, pptr, value, size);
+		bpf_percpu_update_data(&htab->map, pptr, value, size, map_flags);
 	}
 }
 
 static void pcpu_init_value(struct bpf_htab *htab, void __percpu *pptr,
-			    void *value, bool onallcpus)
+			    void *value, bool onallcpus, u64 map_flags)
 {
 	/* When not setting the initial value on all cpus, zero-fill element
 	 * values for other cpus. Otherwise, bpf program has no way to ensure
@@ -968,7 +968,7 @@ static void pcpu_init_value(struct bpf_htab *htab, void __percpu *pptr,
 				zero_map_value(&htab->map, per_cpu_ptr(pptr, cpu));
 		}
 	} else {
-		pcpu_copy_value(htab, pptr, value, onallcpus);
+		pcpu_copy_value(htab, pptr, value, onallcpus, map_flags);
 	}
 }
 
@@ -980,7 +980,7 @@ static bool fd_htab_map_needs_adjust(const struct bpf_htab *htab)
 static struct htab_elem *alloc_htab_elem(struct bpf_htab *htab, void *key,
 					 void *value, u32 key_size, u32 hash,
 					 bool percpu, bool onallcpus,
-					 struct htab_elem *old_elem)
+					 struct htab_elem *old_elem, u64 map_flags)
 {
 	u32 size = htab->map.value_size;
 	bool prealloc = htab_is_prealloc(htab);
@@ -1038,7 +1038,7 @@ static struct htab_elem *alloc_htab_elem(struct bpf_htab *htab, void *key,
 			pptr = *(void __percpu **)ptr;
 		}
 
-		pcpu_init_value(htab, pptr, value, onallcpus);
+		pcpu_init_value(htab, pptr, value, onallcpus, map_flags);
 
 		if (!prealloc)
 			htab_elem_set_ptr(l_new, key_size, pptr);
@@ -1143,7 +1143,7 @@ static long htab_map_update_elem(struct bpf_map *map, void *key, void *value,
 	}
 
 	l_new = alloc_htab_elem(htab, key, value, key_size, hash, false, false,
-				l_old);
+				l_old, map_flags);
 	if (IS_ERR(l_new)) {
 		/* all pre-allocated elements are in use or memory exhausted */
 		ret = PTR_ERR(l_new);
@@ -1287,7 +1287,7 @@ static long htab_map_update_elem_in_place(struct bpf_map *map, void *key,
 		/* Update value in-place */
 		if (percpu) {
 			pcpu_copy_value(htab, htab_elem_get_ptr(l_old, key_size),
-					value, onallcpus);
+					value, onallcpus, map_flags);
 		} else {
 			void **inner_map_pptr = htab_elem_value(l_old, key_size);
 
@@ -1296,7 +1296,7 @@ static long htab_map_update_elem_in_place(struct bpf_map *map, void *key,
 		}
 	} else {
 		l_new = alloc_htab_elem(htab, key, value, key_size,
-					hash, percpu, onallcpus, NULL);
+					hash, percpu, onallcpus, NULL, map_flags);
 		if (IS_ERR(l_new)) {
 			ret = PTR_ERR(l_new);
 			goto err;
@@ -1362,10 +1362,10 @@ static long __htab_lru_percpu_map_update_elem(struct bpf_map *map, void *key,
 
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
@@ -1608,7 +1608,7 @@ static int __htab_map_lookup_and_delete_elem(struct bpf_map *map, void *key,
 		void __percpu *pptr;
 
 		pptr = htab_elem_get_ptr(l, key_size);
-		bpf_percpu_copy_data(&htab->map, pptr, value, roundup_value_size);
+		bpf_percpu_copy_data(&htab->map, pptr, value, roundup_value_size, 0 /* map_flags */);
 	} else {
 		void *src = htab_elem_value(l, map->key_size);
 
@@ -1796,7 +1796,7 @@ __htab_map_lookup_and_delete_batch(struct bpf_map *map,
 			void __percpu *pptr;
 
 			pptr = htab_elem_get_ptr(l, map->key_size);
-			bpf_percpu_copy_data(&htab->map, pptr, dst_val, size);
+			bpf_percpu_copy_data(&htab->map, pptr, dst_val, size, elem_map_flags);
 		} else {
 			value = htab_elem_value(l, key_size);
 			if (is_fd_htab(htab)) {
@@ -2351,7 +2351,7 @@ static void *htab_lru_percpu_map_lookup_percpu_elem(struct bpf_map *map, void *k
 	return NULL;
 }
 
-int bpf_percpu_hash_copy(struct bpf_map *map, void *key, void *value)
+int bpf_percpu_hash_copy(struct bpf_map *map, void *key, void *value, u64 map_flags)
 {
 	struct htab_elem *l;
 	void __percpu *pptr;
@@ -2371,7 +2371,7 @@ int bpf_percpu_hash_copy(struct bpf_map *map, void *key, void *value)
 	 * eviction heuristics when user space does a map walk.
 	 */
 	pptr = htab_elem_get_ptr(l, map->key_size);
-	bpf_percpu_copy_data(map, pptr, value, size);
+	bpf_percpu_copy_data(map, pptr, value, size, map_flags);
 	ret = 0;
 out:
 	rcu_read_unlock();
diff --git a/kernel/bpf/local_storage.c b/kernel/bpf/local_storage.c
index a1debbd26a415..f63639c79902a 100644
--- a/kernel/bpf/local_storage.c
+++ b/kernel/bpf/local_storage.c
@@ -180,7 +180,7 @@ static long cgroup_storage_update_elem(struct bpf_map *map, void *key,
 }
 
 int bpf_percpu_cgroup_storage_copy(struct bpf_map *_map, void *key,
-				   void *value)
+				   void *value, u64 map_flags)
 {
 	struct bpf_cgroup_storage_map *map = map_to_storage(_map);
 	struct bpf_cgroup_storage *storage;
@@ -200,7 +200,7 @@ int bpf_percpu_cgroup_storage_copy(struct bpf_map *_map, void *key,
 	 */
 	size = round_up(_map->value_size, 8);
 	pptr = storage->percpu_buf;
-	bpf_percpu_copy_data(_map, pptr, value, size);
+	bpf_percpu_copy_data(_map, pptr, value, size, map_flags);
 	rcu_read_unlock();
 	return 0;
 }
@@ -231,7 +231,7 @@ int bpf_percpu_cgroup_storage_update(struct bpf_map *_map, void *key,
 	 */
 	size = round_up(_map->value_size, 8);
 	pptr = storage->percpu_buf;
-	bpf_percpu_update_data(_map, pptr, value, size);
+	bpf_percpu_update_data(_map, pptr, value, size, map_flags);
 	rcu_read_unlock();
 	return 0;
 }
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 50ece48409f3b..726363a64f5af 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -314,11 +314,11 @@ static int bpf_map_copy_value(struct bpf_map *map, void *key, void *value,
 	bpf_disable_instrumentation();
 	if (map->map_type == BPF_MAP_TYPE_PERCPU_HASH ||
 	    map->map_type == BPF_MAP_TYPE_LRU_PERCPU_HASH) {
-		err = bpf_percpu_hash_copy(map, key, value);
+		err = bpf_percpu_hash_copy(map, key, value, flags);
 	} else if (map->map_type == BPF_MAP_TYPE_PERCPU_ARRAY) {
-		err = bpf_percpu_array_copy(map, key, value);
+		err = bpf_percpu_array_copy(map, key, value, flags);
 	} else if (map->map_type == BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE) {
-		err = bpf_percpu_cgroup_storage_copy(map, key, value);
+		err = bpf_percpu_cgroup_storage_copy(map, key, value, flags);
 	} else if (map->map_type == BPF_MAP_TYPE_STACK_TRACE) {
 		err = bpf_stackmap_copy(map, key, value);
 	} else if (IS_FD_ARRAY(map) || IS_FD_PROG_ARRAY(map)) {
-- 
2.50.1


