Return-Path: <bpf+bounces-70051-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A65B3BADEEF
	for <lists+bpf@lfdr.de>; Tue, 30 Sep 2025 17:40:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5022A3A5E63
	for <lists+bpf@lfdr.de>; Tue, 30 Sep 2025 15:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1353307AE9;
	Tue, 30 Sep 2025 15:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nKhqbO+t"
X-Original-To: bpf@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F14306B3B
	for <bpf@vger.kernel.org>; Tue, 30 Sep 2025 15:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759246819; cv=none; b=mGKomElEukViLLR481yh8FBZ+bOhagKfKdYLm1YZAZBkpzEY5rG+UcNW7wgcWyBuQcTYlgULP4M6zgw3cchc5e/a1SCh8LERx35hzS7ylpk9D5ZLBZWaYwVOZcrNEwl0o2L7NfP8h/KPIqx8KOUHe86k90Cb3RJdcZfzgPPtsH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759246819; c=relaxed/simple;
	bh=NevP10RL9EhUFMoc1X7NPbRwNacYCOkaGavS3mu4akA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QXNqKWbTuMfVAydaLcos4Lu0B3eJMfE8skvlAYzyy/pcF8lGmfsZ9UZ9Bv1KGVuZVZ/Y+o5+RWrIoDrl/N0YMdWP/D6nbfhl5ipgSwNGdhNEas99vKa+fkxYdi/EcdlsuZR8nEVcxivlMLdA1OYI+Nvlxoj+rhVBm/lBiFyWnFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nKhqbO+t; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1759246815;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n9tB6u2G7TrVO6kuQAAGDfTivYavs4u0K3ZWgwk8p2Q=;
	b=nKhqbO+tPoJMoJAfhZCV6ZnzsVxpA9BukOjP+ECuIPvfn64bZqn4y8EbObVjEN+KlVEpWO
	9M749/n+TElA8rxUwGb+B5G8mBa9GM4Ufeyz6CsG+4stnEmVcdMyoHxsZ3aFdTF+uIYM0h
	zbgf6cn7QYrxhKQu+ZAEE928E4evQxU=
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
Subject: [PATCH bpf-next v9 5/7] bpf: Add BPF_F_CPU and BPF_F_ALL_CPUS flags support for percpu_cgroup_storage maps
Date: Tue, 30 Sep 2025 23:39:40 +0800
Message-ID: <20250930153942.41781-6-leon.hwang@linux.dev>
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

Introduce BPF_F_ALL_CPUS flag support for percpu_cgroup_storage maps to
allow updating values for all CPUs with a single value for update_elem
API.

Introduce BPF_F_CPU flag support for percpu_cgroup_storage maps to
allow:

* update value for specified CPU for update_elem API.
* lookup value for specified CPU for lookup_elem API.

The BPF_F_CPU flag is passed via map_flags along with embedded cpu info.

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 include/linux/bpf-cgroup.h |  4 ++--
 include/linux/bpf.h        |  1 +
 kernel/bpf/local_storage.c | 27 ++++++++++++++++++++-------
 kernel/bpf/syscall.c       |  2 +-
 4 files changed, 24 insertions(+), 10 deletions(-)

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
index b3d9a584f34e2..6250804394b53 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -3774,6 +3774,7 @@ static inline bool bpf_map_supports_cpu_flags(enum bpf_map_type map_type)
 	case BPF_MAP_TYPE_PERCPU_ARRAY:
 	case BPF_MAP_TYPE_PERCPU_HASH:
 	case BPF_MAP_TYPE_LRU_PERCPU_HASH:
+	case BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE:
 		return true;
 	default:
 		return false;
diff --git a/kernel/bpf/local_storage.c b/kernel/bpf/local_storage.c
index c93a756e035c0..f5188e0afa478 100644
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
@@ -198,12 +198,18 @@ int bpf_percpu_cgroup_storage_copy(struct bpf_map *_map, void *key,
 	 * access 'value_size' of them, so copying rounded areas
 	 * will not leak any kernel data
 	 */
+	if (map_flags & BPF_F_CPU) {
+		cpu = map_flags >> 32;
+		memcpy(value, per_cpu_ptr(storage->percpu_buf, cpu), _map->value_size);
+		goto unlock;
+	}
 	size = round_up(_map->value_size, 8);
 	for_each_possible_cpu(cpu) {
 		bpf_long_memcpy(value + off,
 				per_cpu_ptr(storage->percpu_buf, cpu), size);
 		off += size;
 	}
+unlock:
 	rcu_read_unlock();
 	return 0;
 }
@@ -213,10 +219,11 @@ int bpf_percpu_cgroup_storage_update(struct bpf_map *_map, void *key,
 {
 	struct bpf_cgroup_storage_map *map = map_to_storage(_map);
 	struct bpf_cgroup_storage *storage;
-	int cpu, off = 0;
+	void *ptr;
 	u32 size;
+	int cpu;
 
-	if (map_flags != BPF_ANY && map_flags != BPF_EXIST)
+	if ((u32)map_flags & ~(BPF_ANY | BPF_EXIST | BPF_F_CPU | BPF_F_ALL_CPUS))
 		return -EINVAL;
 
 	rcu_read_lock();
@@ -232,12 +239,18 @@ int bpf_percpu_cgroup_storage_update(struct bpf_map *_map, void *key,
 	 * returned or zeros which were zero-filled by percpu_alloc,
 	 * so no kernel data leaks possible
 	 */
-	size = round_up(_map->value_size, 8);
+	size = (map_flags & (BPF_F_CPU | BPF_F_ALL_CPUS)) ? _map->value_size :
+		round_up(_map->value_size, 8);
+	if (map_flags & BPF_F_CPU) {
+		cpu = map_flags >> 32;
+		memcpy(per_cpu_ptr(storage->percpu_buf, cpu), value, size);
+		goto unlock;
+	}
 	for_each_possible_cpu(cpu) {
-		bpf_long_memcpy(per_cpu_ptr(storage->percpu_buf, cpu),
-				value + off, size);
-		off += size;
+		ptr = (map_flags & BPF_F_ALL_CPUS) ? value : value + size * cpu;
+		memcpy(per_cpu_ptr(storage->percpu_buf, cpu), ptr, size);
 	}
+unlock:
 	rcu_read_unlock();
 	return 0;
 }
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index ce525a474656a..b654115c99e01 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -320,7 +320,7 @@ static int bpf_map_copy_value(struct bpf_map *map, void *key, void *value,
 	} else if (map->map_type == BPF_MAP_TYPE_PERCPU_ARRAY) {
 		err = bpf_percpu_array_copy(map, key, value, flags);
 	} else if (map->map_type == BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE) {
-		err = bpf_percpu_cgroup_storage_copy(map, key, value);
+		err = bpf_percpu_cgroup_storage_copy(map, key, value, flags);
 	} else if (map->map_type == BPF_MAP_TYPE_STACK_TRACE) {
 		err = bpf_stackmap_extract(map, key, value, false);
 	} else if (IS_FD_ARRAY(map) || IS_FD_PROG_ARRAY(map)) {
-- 
2.51.0


