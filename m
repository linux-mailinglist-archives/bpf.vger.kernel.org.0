Return-Path: <bpf+bounces-69732-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A456BA0664
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 17:40:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E474518882F2
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 15:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF69C2737E3;
	Thu, 25 Sep 2025 15:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ajPMh/RC"
X-Original-To: bpf@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940872ECEA8
	for <bpf@vger.kernel.org>; Thu, 25 Sep 2025 15:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758814718; cv=none; b=V9KIqU1qmzoM1ocMPLo5RPcUGPfRcCLoYX9Y49SxfI9YDFPpE676HiSR8WJEUu7m0lTXVfyfR357qcOKNqTcjx/STF3gQ9f8STjmqT9finxDgw+IgUG1VF9wKR9XzM8L8ejehmz95vt9powHoigGnO/DqWDc8HozsTr69LcUbjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758814718; c=relaxed/simple;
	bh=GgJhv9UYwkV3luW/LfxCiOFHNzKkgfJ3Zlb321FaAYg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HwRqMUIlWmmU+nxXiCsG34krXcKaWs5qMzDPo5OBCGA4WWOdtA263lbpl9D3dHf8ZKRsfTvfgtHKrML9XdzR7mdOB6pGa7c+gw9DSdwHF0FRFeocnyBpGD2p4dG3uPZCeboO2rXcRu8gaFhBB6GhDNGmw3NUSm5L7EFzv1+6zQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ajPMh/RC; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758814714;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HiXIF3Lvn1eBkGGQq9ztACpqGldprc9pyCaNw4j6hG0=;
	b=ajPMh/RCUdv59sKp4DtWxdKnyMZSbuBjBP6KGuGsSJ89E3kpVKqDK+X/iferkAChLqMX6f
	UbVfnGvRNuYnn4jvT3tNCkQyKVLPC/RoD7wKrrpHPsTU4ToIzGKksoV1uaTSV5LeryrqJ0
	QaNMpE40VLgwxDpCZvzhChNpfujLik0=
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
Subject: [PATCH bpf-next v8 3/7] bpf: Add BPF_F_CPU and BPF_F_ALL_CPUS flags support for percpu_array maps
Date: Thu, 25 Sep 2025 23:37:42 +0800
Message-ID: <20250925153746.96154-4-leon.hwang@linux.dev>
In-Reply-To: <20250925153746.96154-1-leon.hwang@linux.dev>
References: <20250925153746.96154-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Introduce support for the BPF_F_ALL_CPUS flag in percpu_array maps to
allow updating values for all CPUs with a single value for both
update_elem and update_batch APIs.

Introduce support for the BPF_F_CPU flag in percpu_array maps to allow:

* update value for specified CPU for both update_elem and update_batch
APIs.
* lookup value for specified CPU for both lookup_elem and lookup_batch
APIs.

The BPF_F_CPU flag is passed via:

* map_flags of lookup_elem and update_elem APIs along with embedded cpu
info.
* elem_flags of lookup_batch and update_batch APIs along with embedded
cpu info.

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 include/linux/bpf.h   |  9 +++++++--
 kernel/bpf/arraymap.c | 24 +++++++++++++++++++++---
 kernel/bpf/syscall.c  |  2 +-
 3 files changed, 29 insertions(+), 6 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 80719765d40e6..9c4101f537c86 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2718,7 +2718,7 @@ int map_set_for_each_callback_args(struct bpf_verifier_env *env,
 				   struct bpf_func_state *callee);
 
 int bpf_percpu_hash_copy(struct bpf_map *map, void *key, void *value);
-int bpf_percpu_array_copy(struct bpf_map *map, void *key, void *value);
+int bpf_percpu_array_copy(struct bpf_map *map, void *key, void *value, u64 flags);
 int bpf_percpu_hash_update(struct bpf_map *map, void *key, void *value,
 			   u64 flags);
 int bpf_percpu_array_update(struct bpf_map *map, void *key, void *value,
@@ -3770,7 +3770,12 @@ struct bpf_prog *bpf_prog_find_from_stack(void);
 
 static inline bool bpf_map_supports_cpu_flags(enum bpf_map_type map_type)
 {
-	return false;
+	switch (map_type) {
+	case BPF_MAP_TYPE_PERCPU_ARRAY:
+		return true;
+	default:
+		return false;
+	}
 }
 
 static inline int bpf_map_check_op_flags(struct bpf_map *map, u64 flags, u64 allowed_flags)
diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
index 80b1765a31596..a8bf1f99ad548 100644
--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -307,7 +307,7 @@ static void *percpu_array_map_lookup_percpu_elem(struct bpf_map *map, void *key,
 	return per_cpu_ptr(array->pptrs[index & array->index_mask], cpu);
 }
 
-int bpf_percpu_array_copy(struct bpf_map *map, void *key, void *value)
+int bpf_percpu_array_copy(struct bpf_map *map, void *key, void *value, u64 map_flags)
 {
 	struct bpf_array *array = container_of(map, struct bpf_array, map);
 	u32 index = *(u32 *)key;
@@ -325,11 +325,18 @@ int bpf_percpu_array_copy(struct bpf_map *map, void *key, void *value)
 	size = array->elem_size;
 	rcu_read_lock();
 	pptr = array->pptrs[index & array->index_mask];
+	if (map_flags & BPF_F_CPU) {
+		cpu = map_flags >> 32;
+		copy_map_value_long(map, value, per_cpu_ptr(pptr, cpu));
+		check_and_init_map_value(map, value);
+		goto unlock;
+	}
 	for_each_possible_cpu(cpu) {
 		copy_map_value_long(map, value + off, per_cpu_ptr(pptr, cpu));
 		check_and_init_map_value(map, value + off);
 		off += size;
 	}
+unlock:
 	rcu_read_unlock();
 	return 0;
 }
@@ -402,7 +409,7 @@ int bpf_percpu_array_update(struct bpf_map *map, void *key, void *value,
 	int cpu, off = 0;
 	u32 size;
 
-	if (unlikely(map_flags > BPF_EXIST))
+	if (unlikely((map_flags & BPF_F_LOCK) || (u32)map_flags > BPF_F_ALL_CPUS))
 		/* unknown flags */
 		return -EINVAL;
 
@@ -423,11 +430,22 @@ int bpf_percpu_array_update(struct bpf_map *map, void *key, void *value,
 	size = array->elem_size;
 	rcu_read_lock();
 	pptr = array->pptrs[index & array->index_mask];
+	if (map_flags & BPF_F_CPU) {
+		cpu = map_flags >> 32;
+		copy_map_value_long(map, per_cpu_ptr(pptr, cpu), value);
+		bpf_obj_free_fields(array->map.record, per_cpu_ptr(pptr, cpu));
+		goto unlock;
+	}
 	for_each_possible_cpu(cpu) {
 		copy_map_value_long(map, per_cpu_ptr(pptr, cpu), value + off);
 		bpf_obj_free_fields(array->map.record, per_cpu_ptr(pptr, cpu));
-		off += size;
+		/* same user-provided value is used if BPF_F_ALL_CPUS is
+		 * specified, otherwise value is an array of per-CPU values.
+		 */
+		if (!(map_flags & BPF_F_ALL_CPUS))
+			off += size;
 	}
+unlock:
 	rcu_read_unlock();
 	return 0;
 }
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index d1bbc309b62ff..91868fded80e2 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -318,7 +318,7 @@ static int bpf_map_copy_value(struct bpf_map *map, void *key, void *value,
 	    map->map_type == BPF_MAP_TYPE_LRU_PERCPU_HASH) {
 		err = bpf_percpu_hash_copy(map, key, value);
 	} else if (map->map_type == BPF_MAP_TYPE_PERCPU_ARRAY) {
-		err = bpf_percpu_array_copy(map, key, value);
+		err = bpf_percpu_array_copy(map, key, value, flags);
 	} else if (map->map_type == BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE) {
 		err = bpf_percpu_cgroup_storage_copy(map, key, value);
 	} else if (map->map_type == BPF_MAP_TYPE_STACK_TRACE) {
-- 
2.50.1


