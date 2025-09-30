Return-Path: <bpf+bounces-70050-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 58527BADEE2
	for <lists+bpf@lfdr.de>; Tue, 30 Sep 2025 17:40:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B133C194305B
	for <lists+bpf@lfdr.de>; Tue, 30 Sep 2025 15:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF3993081AD;
	Tue, 30 Sep 2025 15:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IPwvmTbZ"
X-Original-To: bpf@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3ED173
	for <bpf@vger.kernel.org>; Tue, 30 Sep 2025 15:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759246815; cv=none; b=Whzuj/jKFNAQgb0/4C1g02Lm0Pt/5GouTx8S/OEjq75aBF4p15pcr9JJ42KVj7PV7CFgOjXYiIlIKmgTPu8FCdOHJOXAU97wB5Ow9zEyxYUQ5GY+8qE1P3iJ04uwW4/DGZ+2wLGj8Jnaf7AxjeYZP/0/3NThFDRsLu46pJsXg9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759246815; c=relaxed/simple;
	bh=fWlXDUPbxIqqyQWbrtE/8OVHZwSlzD7P6/zoSVAj01U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LWC91vDIzer0EF5iFKUYi7h9oB3gfqXehqF0rc8QTotB2U0M2AxOs0in/CEJxyIMw4+uVWJzB5RZdm83pJGNpWtiS7FoX/KaGA8KddEDg7dmdp+EoDi99GyOndL8ElX2uJ8bFHlrwpflo0bFOFpu5RxySLSmkCij7eGfCV1omsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IPwvmTbZ; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1759246811;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gvzZ+GHYlAnUnt80of4S3jx9gpdr4RlTgMw+p0TdxmQ=;
	b=IPwvmTbZgUseLHcPi4T+KVvQCQDVVgtq0VyB4vYO6rRtL9UH3Wrk+cKPM50PoJPwTkcA9X
	U5MMK/kK8bzVGiiC7l8eU9iDExkb6NAqKxPkaG0X2aC2VnhunboMGhOUFqZDT0LFEufqZ+
	GHClMYkxfsFbdK5UOCYBT8aMi3NbdFg=
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
Subject: [PATCH bpf-next v9 4/7] bpf: Add BPF_F_CPU and BPF_F_ALL_CPUS flags support for percpu_hash and lru_percpu_hash maps
Date: Tue, 30 Sep 2025 23:39:39 +0800
Message-ID: <20250930153942.41781-5-leon.hwang@linux.dev>
In-Reply-To: <20250930153942.41781-1-leon.hwang@linux.dev>
References: <20250930153942.41781-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Introduce BPF_F_ALL_CPUS flag support for percpu_hash and lru_percpu_hash
maps to allow updating values for all CPUs with a single value for both
update_elem and update_batch APIs.

Introduce BPF_F_CPU flag support for percpu_hash and lru_percpu_hash
maps to allow:

* update value for specified CPU for both update_elem and update_batch
APIs.
* lookup value for specified CPU for both lookup_elem and lookup_batch
APIs.

The BPF_F_CPU flag is passed via:

* map_flags along with embedded cpu info.
* elem_flags along with embedded cpu info.

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 include/linux/bpf.h  |  4 ++-
 kernel/bpf/hashtab.c | 82 +++++++++++++++++++++++++++++---------------
 kernel/bpf/syscall.c |  2 +-
 3 files changed, 59 insertions(+), 29 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 31498b445b447..b3d9a584f34e2 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2717,7 +2717,7 @@ int map_set_for_each_callback_args(struct bpf_verifier_env *env,
 				   struct bpf_func_state *caller,
 				   struct bpf_func_state *callee);
 
-int bpf_percpu_hash_copy(struct bpf_map *map, void *key, void *value);
+int bpf_percpu_hash_copy(struct bpf_map *map, void *key, void *value, u64 flags);
 int bpf_percpu_array_copy(struct bpf_map *map, void *key, void *value, u64 flags);
 int bpf_percpu_hash_update(struct bpf_map *map, void *key, void *value,
 			   u64 flags);
@@ -3772,6 +3772,8 @@ static inline bool bpf_map_supports_cpu_flags(enum bpf_map_type map_type)
 {
 	switch (map_type) {
 	case BPF_MAP_TYPE_PERCPU_ARRAY:
+	case BPF_MAP_TYPE_PERCPU_HASH:
+	case BPF_MAP_TYPE_LRU_PERCPU_HASH:
 		return true;
 	default:
 		return false;
diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index c2fcd0cd51e51..6fb28ba2406c4 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -945,24 +945,32 @@ static void free_htab_elem(struct bpf_htab *htab, struct htab_elem *l)
 }
 
 static void pcpu_copy_value(struct bpf_htab *htab, void __percpu *pptr,
-			    void *value, bool onallcpus)
+			    void *value, bool onallcpus, u64 map_flags)
 {
 	if (!onallcpus) {
 		/* copy true value_size bytes */
 		copy_map_value(&htab->map, this_cpu_ptr(pptr), value);
 	} else {
-		u32 size = round_up(htab->map.value_size, 8);
-		int off = 0, cpu;
+		u32 size = (map_flags & (BPF_F_CPU | BPF_F_ALL_CPUS)) ?
+			htab->map.value_size : round_up(htab->map.value_size, 8);
+		void *ptr;
+		int cpu;
+
+		if (map_flags & BPF_F_CPU) {
+			cpu = map_flags >> 32;
+			memcpy(per_cpu_ptr(pptr, cpu), value, size);
+			return;
+		}
 
 		for_each_possible_cpu(cpu) {
-			copy_map_value_long(&htab->map, per_cpu_ptr(pptr, cpu), value + off);
-			off += size;
+			ptr = (map_flags & BPF_F_ALL_CPUS) ? value : value + size * cpu;
+			memcpy(per_cpu_ptr(pptr, cpu), ptr, size);
 		}
 	}
 }
 
 static void pcpu_init_value(struct bpf_htab *htab, void __percpu *pptr,
-			    void *value, bool onallcpus)
+			    void *value, bool onallcpus, u64 map_flags)
 {
 	/* When not setting the initial value on all cpus, zero-fill element
 	 * values for other cpus. Otherwise, bpf program has no way to ensure
@@ -980,7 +988,7 @@ static void pcpu_init_value(struct bpf_htab *htab, void __percpu *pptr,
 				zero_map_value(&htab->map, per_cpu_ptr(pptr, cpu));
 		}
 	} else {
-		pcpu_copy_value(htab, pptr, value, onallcpus);
+		pcpu_copy_value(htab, pptr, value, onallcpus, map_flags);
 	}
 }
 
@@ -992,7 +1000,7 @@ static bool fd_htab_map_needs_adjust(const struct bpf_htab *htab)
 static struct htab_elem *alloc_htab_elem(struct bpf_htab *htab, void *key,
 					 void *value, u32 key_size, u32 hash,
 					 bool percpu, bool onallcpus,
-					 struct htab_elem *old_elem)
+					 struct htab_elem *old_elem, u64 map_flags)
 {
 	u32 size = htab->map.value_size;
 	bool prealloc = htab_is_prealloc(htab);
@@ -1050,7 +1058,7 @@ static struct htab_elem *alloc_htab_elem(struct bpf_htab *htab, void *key,
 			pptr = *(void __percpu **)ptr;
 		}
 
-		pcpu_init_value(htab, pptr, value, onallcpus);
+		pcpu_init_value(htab, pptr, value, onallcpus, map_flags);
 
 		if (!prealloc)
 			htab_elem_set_ptr(l_new, key_size, pptr);
@@ -1155,7 +1163,7 @@ static long htab_map_update_elem(struct bpf_map *map, void *key, void *value,
 	}
 
 	l_new = alloc_htab_elem(htab, key, value, key_size, hash, false, false,
-				l_old);
+				l_old, map_flags);
 	if (IS_ERR(l_new)) {
 		/* all pre-allocated elements are in use or memory exhausted */
 		ret = PTR_ERR(l_new);
@@ -1271,9 +1279,11 @@ static long htab_map_update_elem_in_place(struct bpf_map *map, void *key,
 	u32 key_size, hash;
 	int ret;
 
-	if (unlikely(map_flags > BPF_EXIST))
+	if (unlikely(!onallcpus && map_flags > BPF_EXIST))
 		/* unknown flags */
 		return -EINVAL;
+	if (unlikely(onallcpus && ((map_flags & BPF_F_LOCK) || (u32)map_flags > BPF_F_ALL_CPUS)))
+		return -EINVAL;
 
 	WARN_ON_ONCE(!rcu_read_lock_held() && !rcu_read_lock_trace_held() &&
 		     !rcu_read_lock_bh_held());
@@ -1299,7 +1309,7 @@ static long htab_map_update_elem_in_place(struct bpf_map *map, void *key,
 		/* Update value in-place */
 		if (percpu) {
 			pcpu_copy_value(htab, htab_elem_get_ptr(l_old, key_size),
-					value, onallcpus);
+					value, onallcpus, map_flags);
 		} else {
 			void **inner_map_pptr = htab_elem_value(l_old, key_size);
 
@@ -1308,7 +1318,7 @@ static long htab_map_update_elem_in_place(struct bpf_map *map, void *key,
 		}
 	} else {
 		l_new = alloc_htab_elem(htab, key, value, key_size,
-					hash, percpu, onallcpus, NULL);
+					hash, percpu, onallcpus, NULL, map_flags);
 		if (IS_ERR(l_new)) {
 			ret = PTR_ERR(l_new);
 			goto err;
@@ -1334,9 +1344,11 @@ static long __htab_lru_percpu_map_update_elem(struct bpf_map *map, void *key,
 	u32 key_size, hash;
 	int ret;
 
-	if (unlikely(map_flags > BPF_EXIST))
+	if (unlikely(!onallcpus && map_flags > BPF_EXIST))
 		/* unknown flags */
 		return -EINVAL;
+	if (unlikely(onallcpus && ((map_flags & BPF_F_LOCK) || (u32)map_flags > BPF_F_ALL_CPUS)))
+		return -EINVAL;
 
 	WARN_ON_ONCE(!rcu_read_lock_held() && !rcu_read_lock_trace_held() &&
 		     !rcu_read_lock_bh_held());
@@ -1374,10 +1386,10 @@ static long __htab_lru_percpu_map_update_elem(struct bpf_map *map, void *key,
 
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
@@ -1689,9 +1701,9 @@ __htab_map_lookup_and_delete_batch(struct bpf_map *map,
 	void __user *ukeys = u64_to_user_ptr(attr->batch.keys);
 	void __user *ubatch = u64_to_user_ptr(attr->batch.in_batch);
 	u32 batch, max_count, size, bucket_size, map_id;
+	u64 elem_map_flags, map_flags, allowed_flags;
 	u32 bucket_cnt, total, key_size, value_size;
 	struct htab_elem *node_to_free = NULL;
-	u64 elem_map_flags, map_flags;
 	struct hlist_nulls_head *head;
 	struct hlist_nulls_node *n;
 	unsigned long flags = 0;
@@ -1701,9 +1713,12 @@ __htab_map_lookup_and_delete_batch(struct bpf_map *map,
 	int ret = 0;
 
 	elem_map_flags = attr->batch.elem_flags;
-	if ((elem_map_flags & ~BPF_F_LOCK) ||
-	    ((elem_map_flags & BPF_F_LOCK) && !btf_record_has_field(map->record, BPF_SPIN_LOCK)))
-		return -EINVAL;
+	allowed_flags = BPF_F_LOCK;
+	if (!do_delete && is_percpu)
+		allowed_flags |= BPF_F_CPU;
+	ret = bpf_map_check_op_flags(map, elem_map_flags, allowed_flags);
+	if (ret)
+		return ret;
 
 	map_flags = attr->batch.flags;
 	if (map_flags)
@@ -1726,7 +1741,7 @@ __htab_map_lookup_and_delete_batch(struct bpf_map *map,
 	key_size = htab->map.key_size;
 	value_size = htab->map.value_size;
 	size = round_up(value_size, 8);
-	if (is_percpu)
+	if (is_percpu && !(elem_map_flags & BPF_F_CPU))
 		value_size = size * num_possible_cpus();
 	total = 0;
 	/* while experimenting with hash tables with sizes ranging from 10 to
@@ -1809,10 +1824,17 @@ __htab_map_lookup_and_delete_batch(struct bpf_map *map,
 			void __percpu *pptr;
 
 			pptr = htab_elem_get_ptr(l, map->key_size);
-			for_each_possible_cpu(cpu) {
-				copy_map_value_long(&htab->map, dst_val + off, per_cpu_ptr(pptr, cpu));
-				check_and_init_map_value(&htab->map, dst_val + off);
-				off += size;
+			if (elem_map_flags & BPF_F_CPU) {
+				cpu = elem_map_flags >> 32;
+				copy_map_value(&htab->map, dst_val, per_cpu_ptr(pptr, cpu));
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
@@ -2368,7 +2390,7 @@ static void *htab_lru_percpu_map_lookup_percpu_elem(struct bpf_map *map, void *k
 	return NULL;
 }
 
-int bpf_percpu_hash_copy(struct bpf_map *map, void *key, void *value)
+int bpf_percpu_hash_copy(struct bpf_map *map, void *key, void *value, u64 map_flags)
 {
 	struct htab_elem *l;
 	void __percpu *pptr;
@@ -2385,16 +2407,22 @@ int bpf_percpu_hash_copy(struct bpf_map *map, void *key, void *value)
 	l = __htab_map_lookup_elem(map, key);
 	if (!l)
 		goto out;
+	ret = 0;
 	/* We do not mark LRU map element here in order to not mess up
 	 * eviction heuristics when user space does a map walk.
 	 */
 	pptr = htab_elem_get_ptr(l, map->key_size);
+	if (map_flags & BPF_F_CPU) {
+		cpu = map_flags >> 32;
+		copy_map_value(map, value, per_cpu_ptr(pptr, cpu));
+		check_and_init_map_value(map, value);
+		goto out;
+	}
 	for_each_possible_cpu(cpu) {
 		copy_map_value_long(map, value + off, per_cpu_ptr(pptr, cpu));
 		check_and_init_map_value(map, value + off);
 		off += size;
 	}
-	ret = 0;
 out:
 	rcu_read_unlock();
 	return ret;
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index f8de1433fdffb..ce525a474656a 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -316,7 +316,7 @@ static int bpf_map_copy_value(struct bpf_map *map, void *key, void *value,
 	bpf_disable_instrumentation();
 	if (map->map_type == BPF_MAP_TYPE_PERCPU_HASH ||
 	    map->map_type == BPF_MAP_TYPE_LRU_PERCPU_HASH) {
-		err = bpf_percpu_hash_copy(map, key, value);
+		err = bpf_percpu_hash_copy(map, key, value, flags);
 	} else if (map->map_type == BPF_MAP_TYPE_PERCPU_ARRAY) {
 		err = bpf_percpu_array_copy(map, key, value, flags);
 	} else if (map->map_type == BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE) {
-- 
2.51.0


