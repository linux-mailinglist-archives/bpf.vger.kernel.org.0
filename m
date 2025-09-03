Return-Path: <bpf+bounces-67319-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C295DB42789
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 19:04:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A8DD685BA2
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 17:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B36922D3EC7;
	Wed,  3 Sep 2025 17:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="t3Fu/niW"
X-Original-To: bpf@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E8E2BCF5D
	for <bpf@vger.kernel.org>; Wed,  3 Sep 2025 17:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756919076; cv=none; b=uTe4Ci1rTtrihhoqY+91Seb+cLQOwa6m8SFbnGqBtOJve5QQ+WS0Ggb66o0UjK13zHruIJCocd04PZMd4vWJlu3OWHxwm+YpCc4KViU4oMDpcSR+z3+N5F48yNkF+ugv8xZ7RXgYDLDWhjVaMj9nN39qqLMNb7IhUGMd9faD/GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756919076; c=relaxed/simple;
	bh=cKJsYtkP776B04dRA/ldB6Q7492z7ZQ7YtltgZnuQCk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UpkE3f+y3sZF7eYJY22YLnpmYcM3e5+/VpAJffvFfdCRURXSwmljYb8a/1XpsU9Zg7mVcqkyoZqw/Pa1bzasP4kLNxyTmasY/mR1Xj5O81nP9aJBJVw2p+MU8WWz41XT153cdMeGmlcqWAb3Bv1tAgUApqDlHc6kBGFj1HggQ5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=t3Fu/niW; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756919072;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=80u2bpOuJR39RxMiVzJKRsxTAOuRRjAlmkE6xPXkcfM=;
	b=t3Fu/niW36bE9KZ8BzxJ9SCozkwdta3NJvqvv9L2LdUPezoHNjtCfVqhBYnGhfgKIC5nta
	rhDAR2ZhVK1LjwWVJvWEXAQukK0g6JMoD0He+gyIiAx0NrPmnvgo1914AQLmhMpQ4N0FnS
	hrWKGtIobEnFaTrKRTVo6J1v+Uy2S7Q=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	leon.hwang@linux.dev,
	kernel-patches-bot@fb.com,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>
Subject: [PATCH bpf-next] bpf: Generalize data copying for percpu maps
Date: Thu,  4 Sep 2025 01:04:11 +0800
Message-ID: <20250903170411.69188-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

While adding support for the BPF_F_CPU and BPF_F_ALL_CPUS flags, the data
copying logic of the following percpu map types needs to be updated:

* percpu_array
* percpu_hash
* lru_percpu_hash
* percpu_cgroup_storage

Following Andrii’s suggestion[0], this patch refactors the data copying
logic by introducing two helpers:

* `bpf_percpu_copy_to_user()`
* `bpf_percpu_copy_from_user()`

This prepares the codebase for the upcoming CPU flag support.

[0] https://lore.kernel.org/bpf/20250827164509.7401-1-leon.hwang@linux.dev/

Suggested-by: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 include/linux/bpf.h        | 29 ++++++++++++++++++++++++++++-
 kernel/bpf/arraymap.c      | 14 ++------------
 kernel/bpf/hashtab.c       | 20 +++-----------------
 kernel/bpf/local_storage.c | 18 ++++++------------
 4 files changed, 39 insertions(+), 42 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 8f6e87f0f3a89..2dc0299a2da50 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -547,6 +547,34 @@ static inline void copy_map_value_long(struct bpf_map *map, void *dst, void *src
 	bpf_obj_memcpy(map->record, dst, src, map->value_size, true);
 }

+#ifdef CONFIG_BPF_SYSCALL
+static inline void bpf_percpu_copy_to_user(struct bpf_map *map, void __percpu *pptr, void *value,
+					   u32 size)
+{
+	int cpu, off = 0;
+
+	for_each_possible_cpu(cpu) {
+		copy_map_value_long(map, value + off, per_cpu_ptr(pptr, cpu));
+		check_and_init_map_value(map, value + off);
+		off += size;
+	}
+}
+
+void bpf_obj_free_fields(const struct btf_record *rec, void *obj);
+
+static inline void bpf_percpu_copy_from_user(struct bpf_map *map, void __percpu *pptr, void *value,
+					     u32 size)
+{
+	int cpu, off = 0;
+
+	for_each_possible_cpu(cpu) {
+		copy_map_value_long(map, per_cpu_ptr(pptr, cpu), value + off);
+		bpf_obj_free_fields(map->record, per_cpu_ptr(pptr, cpu));
+		off += size;
+	}
+}
+#endif
+
 static inline void bpf_obj_swap_uptrs(const struct btf_record *rec, void *dst, void *src)
 {
 	unsigned long *src_uptr, *dst_uptr;
@@ -2417,7 +2445,6 @@ struct btf_record *btf_record_dup(const struct btf_record *rec);
 bool btf_record_equal(const struct btf_record *rec_a, const struct btf_record *rec_b);
 void bpf_obj_free_timer(const struct btf_record *rec, void *obj);
 void bpf_obj_free_workqueue(const struct btf_record *rec, void *obj);
-void bpf_obj_free_fields(const struct btf_record *rec, void *obj);
 void __bpf_obj_drop_impl(void *p, const struct btf_record *rec, bool percpu);

 struct bpf_map *bpf_map_get(u32 ufd);
diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
index 3d080916faf97..6be9c54604503 100644
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
+	bpf_percpu_copy_to_user(map, pptr, value, size);
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
+	bpf_percpu_copy_from_user(map, pptr, value, size);
 	rcu_read_unlock();
 	return 0;
 }
diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 71f9931ac64cd..5f0f3c00dbb74 100644
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
+		bpf_percpu_copy_from_user(&htab->map, pptr, value, size);
 	}
 }

@@ -1802,15 +1798,10 @@ __htab_map_lookup_and_delete_batch(struct bpf_map *map,
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
+			bpf_percpu_copy_to_user(&htab->map, pptr, dst_val, size);
 		} else {
 			value = htab_elem_value(l, key_size);
 			if (is_fd_htab(htab)) {
@@ -2370,7 +2361,6 @@ int bpf_percpu_hash_copy(struct bpf_map *map, void *key, void *value)
 	struct htab_elem *l;
 	void __percpu *pptr;
 	int ret = -ENOENT;
-	int cpu, off = 0;
 	u32 size;

 	/* per_cpu areas are zero-filled and bpf programs can only
@@ -2386,11 +2376,7 @@ int bpf_percpu_hash_copy(struct bpf_map *map, void *key, void *value)
 	 * eviction heuristics when user space does a map walk.
 	 */
 	pptr = htab_elem_get_ptr(l, map->key_size);
-	for_each_possible_cpu(cpu) {
-		copy_map_value_long(map, value + off, per_cpu_ptr(pptr, cpu));
-		check_and_init_map_value(map, value + off);
-		off += size;
-	}
+	bpf_percpu_copy_to_user(map, pptr, value, size);
 	ret = 0;
 out:
 	rcu_read_unlock();
diff --git a/kernel/bpf/local_storage.c b/kernel/bpf/local_storage.c
index c93a756e035c0..02c184d20213c 100644
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
+	bpf_percpu_copy_to_user(_map, pptr, value, size);
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
+	bpf_percpu_copy_from_user(_map, pptr, value, size);
 	rcu_read_unlock();
 	return 0;
 }
--
2.50.1


