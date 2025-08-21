Return-Path: <bpf+bounces-66237-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9FF6B2FFA8
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 18:09:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56C6F7AB295
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 16:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C6BA29D272;
	Thu, 21 Aug 2025 16:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Y524+6pk"
X-Original-To: bpf@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C623285CB6
	for <bpf@vger.kernel.org>; Thu, 21 Aug 2025 16:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755792542; cv=none; b=bz56/CPsu84QkQz2hsirtfSoc+x1Rbkn5VBYb/ZpNPgqFPItd92hUa4CZiKQOuD2yntWdTuEBhZPczeViWglGomCVrGu92M/Jbb4LZSuRciUJBhINdcRoyWC4iTTYr4oYggTVAQjq7TN1ionIXoEFFmCNnd1RZmkMZ2j90Nk8q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755792542; c=relaxed/simple;
	bh=MmnD7Taku4VPsZ/IfRcsEuv4HBWI87ADHaeRlHngK8A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Md5pASbgoIVp8tBnIbxJXxJAF7F8Aom9IFbKkNGT6eaBTcGF1uRSxArMjtJpjf69wR1YeqdvftOTkIDAe5JIpicIBlJhk+b7IUPYjypUie3b2KArd4RYD/S4rpyOPvQsTcR3LAqFO4mrWUmDJ55rMwbm6oEluVTKMqAuTksslXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Y524+6pk; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755792538;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4zwKcIq63BJ6aI1zBG3wd3skoGAL1DCxreUVAOTJ1EA=;
	b=Y524+6pk+TSa2T3GLiJJJxwhPCar6BQ+sIfoiuGhpUVvAGFYKwUy+L4HyEWvDqgTEmTPws
	58dU3YnQnIgsZy1jLjJWWlTm36ggY/vI6C0etMK2xGb2xl3UNMK+jGeZ6lOpMi3awNeASq
	PHEiMmIn8rfU+DIaFnrNTU+KYqijM3M=
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
Subject: [PATCH bpf-next v3 4/6] bpf: Introduce BPF_F_CPU flag for percpu_cgroup_storage maps
Date: Fri, 22 Aug 2025 00:08:15 +0800
Message-ID: <20250821160817.70285-5-leon.hwang@linux.dev>
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

Introduce BPF_F_ALL_CPUS flag support for percpu_cgroup_storage maps to
allow updating values for all CPUs with a single value.

Introduce BPF_F_CPU flag support for percpu_cgroup_storage maps to allow
updating value for specified CPU.

This enhancement enables:

* Efficient update values across all CPUs with a single value when
  BPF_F_ALL_CPUS is set for update_elem API.
* Targeted update or lookup for a specified CPU when BPF_F_CPU is set.

The BPF_F_CPU flag is passed via map_flags of lookup_elem and update_elem
APIs along with embedded cpu field.

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 include/linux/bpf-cgroup.h |  5 ++--
 include/linux/bpf.h        |  5 ++--
 kernel/bpf/local_storage.c | 47 +++++++++++++++++++++++++++++---------
 kernel/bpf/syscall.c       | 12 ++++------
 4 files changed, 46 insertions(+), 23 deletions(-)

diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
index aedf573bdb426..1cb28660aa866 100644
--- a/include/linux/bpf-cgroup.h
+++ b/include/linux/bpf-cgroup.h
@@ -172,7 +172,8 @@ void bpf_cgroup_storage_link(struct bpf_cgroup_storage *storage,
 void bpf_cgroup_storage_unlink(struct bpf_cgroup_storage *storage);
 int bpf_cgroup_storage_assign(struct bpf_prog_aux *aux, struct bpf_map *map);
 
-int bpf_percpu_cgroup_storage_copy(struct bpf_map *map, void *key, void *value);
+int bpf_percpu_cgroup_storage_copy(struct bpf_map *map, void *key, void *value,
+				   u64 flags);
 int bpf_percpu_cgroup_storage_update(struct bpf_map *map, void *key,
 				     void *value, u64 flags);
 
@@ -467,7 +468,7 @@ static inline struct bpf_cgroup_storage *bpf_cgroup_storage_alloc(
 static inline void bpf_cgroup_storage_free(
 	struct bpf_cgroup_storage *storage) {}
 static inline int bpf_percpu_cgroup_storage_copy(struct bpf_map *map, void *key,
-						 void *value) {
+						 void *value, u64 flags) {
 	return 0;
 }
 static inline int bpf_percpu_cgroup_storage_update(struct bpf_map *map,
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index dc715eef9cbf4..2684ba32bba0a 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -3733,12 +3733,13 @@ static inline int bpf_map_check_cpu_flags(u64 flags, bool check_all_cpus)
 	return 0;
 }
 
-static inline bool bpf_map_support_cpu_flags(enum bpf_map_type map_type)
+static inline bool bpf_map_is_percpu(enum bpf_map_type map_type)
 {
 	switch (map_type) {
 	case BPF_MAP_TYPE_PERCPU_ARRAY:
 	case BPF_MAP_TYPE_PERCPU_HASH:
 	case BPF_MAP_TYPE_LRU_PERCPU_HASH:
+	case BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE:
 		return true;
 	default:
 		return false;
@@ -3756,7 +3757,7 @@ static inline int bpf_map_check_flags(struct bpf_map *map, u64 flags, bool check
 	if (!(flags & BPF_F_CPU) && flags >> 32)
 		return -EINVAL;
 
-	if ((flags & (BPF_F_CPU | BPF_F_ALL_CPUS)) && !bpf_map_support_cpu_flags(map->map_type))
+	if ((flags & (BPF_F_CPU | BPF_F_ALL_CPUS)) && !bpf_map_is_percpu(map->map_type))
 		return -EINVAL;
 
 	return 0;
diff --git a/kernel/bpf/local_storage.c b/kernel/bpf/local_storage.c
index c93a756e035c0..ee60b8cee4e90 100644
--- a/kernel/bpf/local_storage.c
+++ b/kernel/bpf/local_storage.c
@@ -180,18 +180,22 @@ static long cgroup_storage_update_elem(struct bpf_map *map, void *key,
 }
 
 int bpf_percpu_cgroup_storage_copy(struct bpf_map *_map, void *key,
-				   void *value)
+				   void *value, u64 map_flags)
 {
 	struct bpf_cgroup_storage_map *map = map_to_storage(_map);
 	struct bpf_cgroup_storage *storage;
-	int cpu, off = 0;
+	int cpu, off = 0, err;
 	u32 size;
 
+	err = bpf_map_check_cpu_flags(map_flags, false);
+	if (err)
+		return err;
+
 	rcu_read_lock();
 	storage = cgroup_storage_lookup(map, key, false);
 	if (!storage) {
-		rcu_read_unlock();
-		return -ENOENT;
+		err = -ENOENT;
+		goto unlock;
 	}
 
 	/* per_cpu areas are zero-filled and bpf programs can only
@@ -199,13 +203,19 @@ int bpf_percpu_cgroup_storage_copy(struct bpf_map *_map, void *key,
 	 * will not leak any kernel data
 	 */
 	size = round_up(_map->value_size, 8);
+	if (map_flags & BPF_F_CPU) {
+		cpu = map_flags >> 32;
+		bpf_long_memcpy(value, per_cpu_ptr(storage->percpu_buf, cpu), size);
+		goto unlock;
+	}
 	for_each_possible_cpu(cpu) {
 		bpf_long_memcpy(value + off,
 				per_cpu_ptr(storage->percpu_buf, cpu), size);
 		off += size;
 	}
+unlock:
 	rcu_read_unlock();
-	return 0;
+	return err;
 }
 
 int bpf_percpu_cgroup_storage_update(struct bpf_map *_map, void *key,
@@ -213,17 +223,21 @@ int bpf_percpu_cgroup_storage_update(struct bpf_map *_map, void *key,
 {
 	struct bpf_cgroup_storage_map *map = map_to_storage(_map);
 	struct bpf_cgroup_storage *storage;
-	int cpu, off = 0;
+	int cpu, off = 0, err;
 	u32 size;
 
-	if (map_flags != BPF_ANY && map_flags != BPF_EXIST)
+	if ((u32)map_flags & ~(BPF_ANY | BPF_EXIST | BPF_F_CPU | BPF_F_ALL_CPUS))
 		return -EINVAL;
 
+	err = bpf_map_check_cpu_flags(map_flags, true);
+	if (err)
+		return err;
+
 	rcu_read_lock();
 	storage = cgroup_storage_lookup(map, key, false);
 	if (!storage) {
-		rcu_read_unlock();
-		return -ENOENT;
+		err = -ENOENT;
+		goto unlock;
 	}
 
 	/* the user space will provide round_up(value_size, 8) bytes that
@@ -233,13 +247,24 @@ int bpf_percpu_cgroup_storage_update(struct bpf_map *_map, void *key,
 	 * so no kernel data leaks possible
 	 */
 	size = round_up(_map->value_size, 8);
+	if (map_flags & BPF_F_CPU) {
+		cpu = map_flags >> 32;
+		bpf_long_memcpy(per_cpu_ptr(storage->percpu_buf, cpu), value, size);
+		goto unlock;
+	}
 	for_each_possible_cpu(cpu) {
 		bpf_long_memcpy(per_cpu_ptr(storage->percpu_buf, cpu),
 				value + off, size);
-		off += size;
+		/* same user-provided value is used if
+		 * BPF_F_ALL_CPUS is specified, otherwise value is
+		 * an array of per-cpu values.
+		 */
+		if (!(map_flags & BPF_F_ALL_CPUS))
+			off += size;
 	}
+unlock:
 	rcu_read_unlock();
-	return 0;
+	return err;
 }
 
 static int cgroup_storage_get_next_key(struct bpf_map *_map, void *key,
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 430f013f38f06..3fc52cd0c12de 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -133,13 +133,9 @@ bool bpf_map_write_active(const struct bpf_map *map)
 
 static u32 bpf_map_value_size(const struct bpf_map *map, u64 flags)
 {
-	if (bpf_map_support_cpu_flags(map->map_type) && (flags & (BPF_F_CPU | BPF_F_ALL_CPUS)))
-		return round_up(map->value_size, 8);
-	else if (map->map_type == BPF_MAP_TYPE_PERCPU_HASH ||
-	    map->map_type == BPF_MAP_TYPE_LRU_PERCPU_HASH ||
-	    map->map_type == BPF_MAP_TYPE_PERCPU_ARRAY ||
-	    map->map_type == BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE)
-		return round_up(map->value_size, 8) * num_possible_cpus();
+	if (bpf_map_is_percpu(map->map_type))
+		return flags & (BPF_F_CPU | BPF_F_ALL_CPUS) ? round_up(map->value_size, 8) :
+			round_up(map->value_size, 8) * num_possible_cpus();
 	else if (IS_FD_MAP(map))
 		return sizeof(u32);
 	else
@@ -318,7 +314,7 @@ static int bpf_map_copy_value(struct bpf_map *map, void *key, void *value,
 	} else if (map->map_type == BPF_MAP_TYPE_PERCPU_ARRAY) {
 		err = bpf_percpu_array_copy(map, key, value, flags);
 	} else if (map->map_type == BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE) {
-		err = bpf_percpu_cgroup_storage_copy(map, key, value);
+		err = bpf_percpu_cgroup_storage_copy(map, key, value, flags);
 	} else if (map->map_type == BPF_MAP_TYPE_STACK_TRACE) {
 		err = bpf_stackmap_copy(map, key, value);
 	} else if (IS_FD_ARRAY(map) || IS_FD_PROG_ARRAY(map)) {
-- 
2.50.1


