Return-Path: <bpf+bounces-67714-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 54A7CB491D6
	for <lists+bpf@lfdr.de>; Mon,  8 Sep 2025 16:40:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92ED17B7CC6
	for <lists+bpf@lfdr.de>; Mon,  8 Sep 2025 14:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93AB030B511;
	Mon,  8 Sep 2025 14:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="D6myHhVi"
X-Original-To: bpf@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3BD3C38
	for <bpf@vger.kernel.org>; Mon,  8 Sep 2025 14:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757342238; cv=none; b=UeATUkJuaeog4dxh1kW38EAn5Jvjosjk3JcCZOveohaTUMIMlR3vSK72DI9WZWVlDrTZE2BIMcQ3FVyheTSCbMx2xQbS+7lPqWcK8+RgWWpZIGWSx12vA/NHKSHMYxjInxwrjWGwyeTJVkomoIxpcaSjl2S+poYqKgOWFgBZmN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757342238; c=relaxed/simple;
	bh=kw2AXwrhHYK2Lg8Rw84sH2u7LCGuyov29wxOWMW1TVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QHFLVlhOSh3bbDKXSS0+Jho/xn4XSAkiqxbG7t1gud7iGtcmjLAd7KgF2OEJ0Ud8m7Phy9xtVT0hTxK7OSoaQEO9B4tBDW0EYdmSQxt3v3hmfljXeN1ti1ygJZnFZQG43qjQU8RNdThzkT8M1Izx7K9RUvoVZy9Q6ozs2CbKnkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=D6myHhVi; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757342234;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lrHeHqWaJi6pEFtWkxRb0ItsmUvuORoyCHCY9LiO+rI=;
	b=D6myHhViz1jENkT8A8AEJW1a/fmZBDBPbPOUMcEHxvCkH4PLdNkRqodE112gfCM9Cx66YQ
	4CWl/p7mpLAwTaKLjXHDxPeefhtyJ+mE+ckUce+KymxN3xRkqEyei0iF0fIotetp3YWsZ6
	hKFPWYLF/6guAK8QeVfRW+DLmt87VBI=
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
Subject: [PATCH bpf-next v5 1/9] bpf: Generalize data copying for percpu maps
Date: Mon,  8 Sep 2025 22:36:36 +0800
Message-ID: <20250908143644.30993-2-leon.hwang@linux.dev>
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

Refactor the data copying logic of the following percpu map types:

* percpu_array
* percpu_hash
* lru_percpu_hash
* percpu_cgroup_storage

by introducing two helpers:

* 'bpf_percpu_copy_data()'
* 'bpf_percpu_update_data()'

It is to introduce BPF_F_CPU and BPF_F_ALL_CPUS flags for these percpu
maps with less code churn.

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 include/linux/bpf.h        | 28 +++++++++++++++++++++++++++-
 kernel/bpf/arraymap.c      | 14 ++------------
 kernel/bpf/hashtab.c       | 27 ++++-----------------------
 kernel/bpf/local_storage.c | 18 ++++++------------
 4 files changed, 39 insertions(+), 48 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 8f6e87f0f3a89..ce523a49dc20c 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -547,6 +547,33 @@ static inline void copy_map_value_long(struct bpf_map *map, void *dst, void *src
 	bpf_obj_memcpy(map->record, dst, src, map->value_size, true);
 }
 
+#ifdef CONFIG_BPF_SYSCALL
+static inline void bpf_percpu_copy_data(struct bpf_map *map, void __percpu *pptr, void *value,
+					u32 size)
+{
+	int cpu, off = 0;
+
+	for_each_possible_cpu(cpu) {
+		copy_map_value_long(map, value + off, per_cpu_ptr(pptr, cpu));
+		off += size;
+	}
+}
+
+void bpf_obj_free_fields(const struct btf_record *rec, void *obj);
+
+static inline void bpf_percpu_update_data(struct bpf_map *map, void __percpu *pptr, void *value,
+					  u32 size)
+{
+	int cpu, off = 0;
+
+	for_each_possible_cpu(cpu) {
+		bpf_obj_free_fields(map->record, per_cpu_ptr(pptr, cpu));
+		bpf_long_memcpy(per_cpu_ptr(pptr, cpu), value + off, size);
+		off += size;
+	}
+}
+#endif
+
 static inline void bpf_obj_swap_uptrs(const struct btf_record *rec, void *dst, void *src)
 {
 	unsigned long *src_uptr, *dst_uptr;
@@ -2417,7 +2444,6 @@ struct btf_record *btf_record_dup(const struct btf_record *rec);
 bool btf_record_equal(const struct btf_record *rec_a, const struct btf_record *rec_b);
 void bpf_obj_free_timer(const struct btf_record *rec, void *obj);
 void bpf_obj_free_workqueue(const struct btf_record *rec, void *obj);
-void bpf_obj_free_fields(const struct btf_record *rec, void *obj);
 void __bpf_obj_drop_impl(void *p, const struct btf_record *rec, bool percpu);
 
 struct bpf_map *bpf_map_get(u32 ufd);
diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
index 3d080916faf97..ed9e47dc4137b 100644
--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -300,7 +300,6 @@ int bpf_percpu_array_copy(struct bpf_map *map, void *key, void *value)
 	struct bpf_array *array = container_of(map, struct bpf_array, map);
 	u32 index = *(u32 *)key;
 	void __percpu *pptr;
-	int cpu, off = 0;
 	u32 size;
 
 	if (unlikely(index >= array->map.max_entries))
@@ -313,11 +312,7 @@ int bpf_percpu_array_copy(struct bpf_map *map, void *key, void *value)
 	size = array->elem_size;
 	rcu_read_lock();
 	pptr = array->pptrs[index & array->index_mask];
-	for_each_possible_cpu(cpu) {
-		copy_map_value_long(map, value + off, per_cpu_ptr(pptr, cpu));
-		check_and_init_map_value(map, value + off);
-		off += size;
-	}
+	bpf_percpu_copy_data(map, pptr, value, size);
 	rcu_read_unlock();
 	return 0;
 }
@@ -387,7 +382,6 @@ int bpf_percpu_array_update(struct bpf_map *map, void *key, void *value,
 	struct bpf_array *array = container_of(map, struct bpf_array, map);
 	u32 index = *(u32 *)key;
 	void __percpu *pptr;
-	int cpu, off = 0;
 	u32 size;
 
 	if (unlikely(map_flags > BPF_EXIST))
@@ -411,11 +405,7 @@ int bpf_percpu_array_update(struct bpf_map *map, void *key, void *value,
 	size = array->elem_size;
 	rcu_read_lock();
 	pptr = array->pptrs[index & array->index_mask];
-	for_each_possible_cpu(cpu) {
-		copy_map_value_long(map, per_cpu_ptr(pptr, cpu), value + off);
-		bpf_obj_free_fields(array->map.record, per_cpu_ptr(pptr, cpu));
-		off += size;
-	}
+	bpf_percpu_update_data(map, pptr, value, size);
 	rcu_read_unlock();
 	return 0;
 }
diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 71f9931ac64cd..0a2c1042d5fdb 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -944,12 +944,8 @@ static void pcpu_copy_value(struct bpf_htab *htab, void __percpu *pptr,
 		copy_map_value(&htab->map, this_cpu_ptr(pptr), value);
 	} else {
 		u32 size = round_up(htab->map.value_size, 8);
-		int off = 0, cpu;
 
-		for_each_possible_cpu(cpu) {
-			copy_map_value_long(&htab->map, per_cpu_ptr(pptr, cpu), value + off);
-			off += size;
-		}
+		bpf_percpu_update_data(&htab->map, pptr, value, size);
 	}
 }
 
@@ -1610,14 +1606,9 @@ static int __htab_map_lookup_and_delete_elem(struct bpf_map *map, void *key,
 	if (is_percpu) {
 		u32 roundup_value_size = round_up(map->value_size, 8);
 		void __percpu *pptr;
-		int off = 0, cpu;
 
 		pptr = htab_elem_get_ptr(l, key_size);
-		for_each_possible_cpu(cpu) {
-			copy_map_value_long(&htab->map, value + off, per_cpu_ptr(pptr, cpu));
-			check_and_init_map_value(&htab->map, value + off);
-			off += roundup_value_size;
-		}
+		bpf_percpu_copy_data(&htab->map, pptr, value, roundup_value_size);
 	} else {
 		void *src = htab_elem_value(l, map->key_size);
 
@@ -1802,15 +1793,10 @@ __htab_map_lookup_and_delete_batch(struct bpf_map *map,
 		memcpy(dst_key, l->key, key_size);
 
 		if (is_percpu) {
-			int off = 0, cpu;
 			void __percpu *pptr;
 
 			pptr = htab_elem_get_ptr(l, map->key_size);
-			for_each_possible_cpu(cpu) {
-				copy_map_value_long(&htab->map, dst_val + off, per_cpu_ptr(pptr, cpu));
-				check_and_init_map_value(&htab->map, dst_val + off);
-				off += size;
-			}
+			bpf_percpu_copy_data(&htab->map, pptr, dst_val, size);
 		} else {
 			value = htab_elem_value(l, key_size);
 			if (is_fd_htab(htab)) {
@@ -2370,7 +2356,6 @@ int bpf_percpu_hash_copy(struct bpf_map *map, void *key, void *value)
 	struct htab_elem *l;
 	void __percpu *pptr;
 	int ret = -ENOENT;
-	int cpu, off = 0;
 	u32 size;
 
 	/* per_cpu areas are zero-filled and bpf programs can only
@@ -2386,11 +2371,7 @@ int bpf_percpu_hash_copy(struct bpf_map *map, void *key, void *value)
 	 * eviction heuristics when user space does a map walk.
 	 */
 	pptr = htab_elem_get_ptr(l, map->key_size);
-	for_each_possible_cpu(cpu) {
-		copy_map_value_long(map, value + off, per_cpu_ptr(pptr, cpu));
-		check_and_init_map_value(map, value + off);
-		off += size;
-	}
+	bpf_percpu_copy_data(map, pptr, value, size);
 	ret = 0;
 out:
 	rcu_read_unlock();
diff --git a/kernel/bpf/local_storage.c b/kernel/bpf/local_storage.c
index c93a756e035c0..a1debbd26a415 100644
--- a/kernel/bpf/local_storage.c
+++ b/kernel/bpf/local_storage.c
@@ -184,7 +184,7 @@ int bpf_percpu_cgroup_storage_copy(struct bpf_map *_map, void *key,
 {
 	struct bpf_cgroup_storage_map *map = map_to_storage(_map);
 	struct bpf_cgroup_storage *storage;
-	int cpu, off = 0;
+	void __percpu *pptr;
 	u32 size;
 
 	rcu_read_lock();
@@ -199,11 +199,8 @@ int bpf_percpu_cgroup_storage_copy(struct bpf_map *_map, void *key,
 	 * will not leak any kernel data
 	 */
 	size = round_up(_map->value_size, 8);
-	for_each_possible_cpu(cpu) {
-		bpf_long_memcpy(value + off,
-				per_cpu_ptr(storage->percpu_buf, cpu), size);
-		off += size;
-	}
+	pptr = storage->percpu_buf;
+	bpf_percpu_copy_data(_map, pptr, value, size);
 	rcu_read_unlock();
 	return 0;
 }
@@ -213,7 +210,7 @@ int bpf_percpu_cgroup_storage_update(struct bpf_map *_map, void *key,
 {
 	struct bpf_cgroup_storage_map *map = map_to_storage(_map);
 	struct bpf_cgroup_storage *storage;
-	int cpu, off = 0;
+	void __percpu *pptr;
 	u32 size;
 
 	if (map_flags != BPF_ANY && map_flags != BPF_EXIST)
@@ -233,11 +230,8 @@ int bpf_percpu_cgroup_storage_update(struct bpf_map *_map, void *key,
 	 * so no kernel data leaks possible
 	 */
 	size = round_up(_map->value_size, 8);
-	for_each_possible_cpu(cpu) {
-		bpf_long_memcpy(per_cpu_ptr(storage->percpu_buf, cpu),
-				value + off, size);
-		off += size;
-	}
+	pptr = storage->percpu_buf;
+	bpf_percpu_update_data(_map, pptr, value, size);
 	rcu_read_unlock();
 	return 0;
 }
-- 
2.50.1


