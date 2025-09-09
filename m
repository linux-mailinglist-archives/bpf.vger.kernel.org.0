Return-Path: <bpf+bounces-67874-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 02681B4FF0D
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 16:15:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DAB7188289D
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 14:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E16BD3019CD;
	Tue,  9 Sep 2025 14:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EIs2s/fo"
X-Original-To: bpf@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C60E32C316
	for <bpf@vger.kernel.org>; Tue,  9 Sep 2025 14:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757427299; cv=none; b=Ak94GmVFF9+kjPWPcc/MtT3s713hncApG/+1QsVN/IxaL4u6cyPyV/a1Hub9GADkHiWn73vzsnFacwXJ4HE5xigIhAgDMWjuguPeGVIlGBjmq7b8bRAoBtF5xulmyjDwyjJZMxTLupjcVha3cx+ERvtcIEjMdT40IOsTDObj35o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757427299; c=relaxed/simple;
	bh=17c4JTYS0Z1zCS4VAts41/gCTYftQl1cRPm8pijDQCM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qo4AfpL7rdgTZHnAWp1eHiTKjgJbgyCKrwXjyRGjnOnZJulFOUCXSMRIf8S6TYENbxWNBxH4YqmdvDyElJeXmk0Mefeu/zLp+0AGON+xkUWiX4z4kGWqoGRSLY+p5mdVP844IBvRQ0qoyZbrUDUmylhCC4Ojw451YF2NuDUfROk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EIs2s/fo; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757427294;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2l1AywV6/X30rEp75i9oDtFxHNPbhnZPrfjDX9LMTeI=;
	b=EIs2s/foGxCmmoeO/d09MPxuL9Q+X3KZPQL80NRP8F/V5bfTS373t6mZjZnXmR4MPbB6Ck
	H3Hx4OCXSxSuDRemxDqLqUOlUJVoLr+b/qA83Rcuo0tQU4m125YqBqMYe5wZAFIOvAKi47
	jx5o+1XhDrAnz9jN39lldwaqCAgYn3A=
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
Subject: [PATCH bpf-next v6 4/7] bpf: Add BPF_F_CPU and BPF_F_ALL_CPUS flags support for percpu_hash and lru_percpu_hash maps
Date: Tue,  9 Sep 2025 22:14:18 +0800
Message-ID: <20250909141422.45450-5-leon.hwang@linux.dev>
In-Reply-To: <20250909141422.45450-1-leon.hwang@linux.dev>
References: <20250909141422.45450-1-leon.hwang@linux.dev>
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
 include/linux/bpf.h  |   2 +-
 kernel/bpf/hashtab.c | 105 +++++++++++++++++++++++++++++++------------
 kernel/bpf/syscall.c |   4 +-
 3 files changed, 80 insertions(+), 31 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index b5143420ea947..7f49bb3fdaf1e 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2696,7 +2696,7 @@ int map_set_for_each_callback_args(struct bpf_verifier_env *env,
 				   struct bpf_func_state *caller,
 				   struct bpf_func_state *callee);
 
-int bpf_percpu_hash_copy(struct bpf_map *map, void *key, void *value);
+int bpf_percpu_hash_copy(struct bpf_map *map, void *key, void *value, u64 flags);
 int bpf_percpu_array_copy(struct bpf_map *map, void *key, void *value, u64 flags);
 int bpf_percpu_hash_update(struct bpf_map *map, void *key, void *value,
 			   u64 flags);
diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 71f9931ac64cd..07f4daf384776 100644
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
@@ -946,15 +946,26 @@ static void pcpu_copy_value(struct bpf_htab *htab, void __percpu *pptr,
 		u32 size = round_up(htab->map.value_size, 8);
 		int off = 0, cpu;
 
+		if (map_flags & BPF_F_CPU) {
+			cpu = map_flags >> 32;
+			copy_map_value_long(&htab->map, per_cpu_ptr(pptr, cpu), value);
+			return;
+		}
+
 		for_each_possible_cpu(cpu) {
 			copy_map_value_long(&htab->map, per_cpu_ptr(pptr, cpu), value + off);
-			off += size;
+			/* same user-provided value is used if BPF_F_ALL_CPUS
+			 * is specified, otherwise value is an array of per-CPU
+			 * values.
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
@@ -972,7 +983,7 @@ static void pcpu_init_value(struct bpf_htab *htab, void __percpu *pptr,
 				zero_map_value(&htab->map, per_cpu_ptr(pptr, cpu));
 		}
 	} else {
-		pcpu_copy_value(htab, pptr, value, onallcpus);
+		pcpu_copy_value(htab, pptr, value, onallcpus, map_flags);
 	}
 }
 
@@ -984,7 +995,7 @@ static bool fd_htab_map_needs_adjust(const struct bpf_htab *htab)
 static struct htab_elem *alloc_htab_elem(struct bpf_htab *htab, void *key,
 					 void *value, u32 key_size, u32 hash,
 					 bool percpu, bool onallcpus,
-					 struct htab_elem *old_elem)
+					 struct htab_elem *old_elem, u64 map_flags)
 {
 	u32 size = htab->map.value_size;
 	bool prealloc = htab_is_prealloc(htab);
@@ -1042,7 +1053,7 @@ static struct htab_elem *alloc_htab_elem(struct bpf_htab *htab, void *key,
 			pptr = *(void __percpu **)ptr;
 		}
 
-		pcpu_init_value(htab, pptr, value, onallcpus);
+		pcpu_init_value(htab, pptr, value, onallcpus, map_flags);
 
 		if (!prealloc)
 			htab_elem_set_ptr(l_new, key_size, pptr);
@@ -1147,7 +1158,7 @@ static long htab_map_update_elem(struct bpf_map *map, void *key, void *value,
 	}
 
 	l_new = alloc_htab_elem(htab, key, value, key_size, hash, false, false,
-				l_old);
+				l_old, map_flags);
 	if (IS_ERR(l_new)) {
 		/* all pre-allocated elements are in use or memory exhausted */
 		ret = PTR_ERR(l_new);
@@ -1263,9 +1274,15 @@ static long htab_map_update_elem_in_place(struct bpf_map *map, void *key,
 	u32 key_size, hash;
 	int ret;
 
-	if (unlikely(map_flags > BPF_EXIST))
-		/* unknown flags */
-		return -EINVAL;
+	if (onallcpus) {
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
@@ -1291,7 +1308,7 @@ static long htab_map_update_elem_in_place(struct bpf_map *map, void *key,
 		/* Update value in-place */
 		if (percpu) {
 			pcpu_copy_value(htab, htab_elem_get_ptr(l_old, key_size),
-					value, onallcpus);
+					value, onallcpus, map_flags);
 		} else {
 			void **inner_map_pptr = htab_elem_value(l_old, key_size);
 
@@ -1300,7 +1317,7 @@ static long htab_map_update_elem_in_place(struct bpf_map *map, void *key,
 		}
 	} else {
 		l_new = alloc_htab_elem(htab, key, value, key_size,
-					hash, percpu, onallcpus, NULL);
+					hash, percpu, onallcpus, NULL, map_flags);
 		if (IS_ERR(l_new)) {
 			ret = PTR_ERR(l_new);
 			goto err;
@@ -1326,9 +1343,15 @@ static long __htab_lru_percpu_map_update_elem(struct bpf_map *map, void *key,
 	u32 key_size, hash;
 	int ret;
 
-	if (unlikely(map_flags > BPF_EXIST))
-		/* unknown flags */
-		return -EINVAL;
+	if (onallcpus) {
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
@@ -1366,10 +1389,10 @@ static long __htab_lru_percpu_map_update_elem(struct bpf_map *map, void *key,
 
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
@@ -1698,9 +1721,16 @@ __htab_map_lookup_and_delete_batch(struct bpf_map *map,
 	int ret = 0;
 
 	elem_map_flags = attr->batch.elem_flags;
-	if ((elem_map_flags & ~BPF_F_LOCK) ||
-	    ((elem_map_flags & BPF_F_LOCK) && !btf_record_has_field(map->record, BPF_SPIN_LOCK)))
-		return -EINVAL;
+	if (!do_delete && is_percpu) {
+		ret = bpf_map_check_cpu_flags(elem_map_flags, false);
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
@@ -1806,10 +1836,17 @@ __htab_map_lookup_and_delete_batch(struct bpf_map *map,
 			void __percpu *pptr;
 
 			pptr = htab_elem_get_ptr(l, map->key_size);
-			for_each_possible_cpu(cpu) {
-				copy_map_value_long(&htab->map, dst_val + off, per_cpu_ptr(pptr, cpu));
-				check_and_init_map_value(&htab->map, dst_val + off);
-				off += size;
+			if (elem_map_flags & BPF_F_CPU) {
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
@@ -2365,14 +2402,17 @@ static void *htab_lru_percpu_map_lookup_percpu_elem(struct bpf_map *map, void *k
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
+
 	/* per_cpu areas are zero-filled and bpf programs can only
 	 * access 'value_size' of them, so copying rounded areas
 	 * will not leak any kernel data
@@ -2380,18 +2420,25 @@ int bpf_percpu_hash_copy(struct bpf_map *map, void *key, void *value)
 	size = round_up(map->value_size, 8);
 	rcu_read_lock();
 	l = __htab_map_lookup_elem(map, key);
-	if (!l)
+	if (!l) {
+		ret = -ENOENT;
 		goto out;
+	}
 	/* We do not mark LRU map element here in order to not mess up
 	 * eviction heuristics when user space does a map walk.
 	 */
 	pptr = htab_elem_get_ptr(l, map->key_size);
+	if (map_flags & BPF_F_CPU) {
+		cpu = map_flags >> 32;
+		copy_map_value_long(map, value, per_cpu_ptr(pptr, cpu));
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
index 6d0a08d63f175..d01424e0560ce 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -135,6 +135,8 @@ static bool bpf_map_supports_cpu_flags(enum bpf_map_type map_type)
 {
 	switch (map_type) {
 	case BPF_MAP_TYPE_PERCPU_ARRAY:
+	case BPF_MAP_TYPE_PERCPU_HASH:
+	case BPF_MAP_TYPE_LRU_PERCPU_HASH:
 		return true;
 	default:
 		return false;
@@ -341,7 +343,7 @@ static int bpf_map_copy_value(struct bpf_map *map, void *key, void *value,
 	bpf_disable_instrumentation();
 	if (map->map_type == BPF_MAP_TYPE_PERCPU_HASH ||
 	    map->map_type == BPF_MAP_TYPE_LRU_PERCPU_HASH) {
-		err = bpf_percpu_hash_copy(map, key, value);
+		err = bpf_percpu_hash_copy(map, key, value, flags);
 	} else if (map->map_type == BPF_MAP_TYPE_PERCPU_ARRAY) {
 		err = bpf_percpu_array_copy(map, key, value, flags);
 	} else if (map->map_type == BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE) {
-- 
2.50.1


