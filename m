Return-Path: <bpf+bounces-66687-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05B2FB387F0
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 18:45:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52942687368
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 16:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D938A227BA4;
	Wed, 27 Aug 2025 16:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vxwPkEx9"
X-Original-To: bpf@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7170B13C9C4
	for <bpf@vger.kernel.org>; Wed, 27 Aug 2025 16:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756313146; cv=none; b=We/6inQ5sA1+fTzl01uxizH6KqIQPyV+MSnp9Yo8dRlzGkQykEkq8bCVxiHvWUNLtn6lxFBKzGw73oucUtbKshsUqcwgD6nn36xGAmdBkbwj4lG4d79nPEGrxCjRf6KpsOXR1oI+Vz8G0jB52cxagqkZoa4frqtFW5q8XhPSelE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756313146; c=relaxed/simple;
	bh=nhlu+/fiiXttNPBr+WrZMtEGbzYDTAO05I0tx3NgHSs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IAkk1iTt++2DKrjkXztkDqntZtQTFouu5LNb3JJ4anGU8QV1bGQi1Km2e8ZrGZSRhq0PqweXFGa2No852R/PoEfMoFJYZcs/WX9fpJmVPvw2VdGOkiw7jFdkUK1xWvw4+H85avj2IEmbWGeHlws6m4r0UgH8W3Iw1hoMUpVmZKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vxwPkEx9; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756313142;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=meyB+p7p/BFzs+SCa6nFQf46ZDAzDXmSodviDakKOcI=;
	b=vxwPkEx9OW2pRJc4AaINigLJQCKc35/kBrtKlVgN509ZJmMAncdfuT8PNQHeZ+eqPnyNs2
	Z+W/Z56mm7RsKUuMzcUodf6l2WKN1tTwZw0umKgVuCl4yb2ayfDl18bHjUIHSXQXRJMwWW
	m0hgw07qt/LTG04TrUpWab84JAxnNdM=
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
Subject: [PATCH bpf-next v4 3/7] bpf: Introduce BPF_F_CPU and BPF_F_ALL_CPUS flags for percpu_array maps
Date: Thu, 28 Aug 2025 00:45:05 +0800
Message-ID: <20250827164509.7401-4-leon.hwang@linux.dev>
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
 include/linux/bpf.h   | 10 ++++++++--
 kernel/bpf/arraymap.c | 28 ++++++++++++----------------
 kernel/bpf/syscall.c  |  2 +-
 3 files changed, 21 insertions(+), 19 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index a83364949b64c..bc44b72129e59 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2746,7 +2746,8 @@ int map_set_for_each_callback_args(struct bpf_verifier_env *env,
 				   struct bpf_func_state *callee);
 
 int bpf_percpu_hash_copy(struct bpf_map *map, void *key, void *value);
-int bpf_percpu_array_copy(struct bpf_map *map, void *key, void *value);
+int bpf_percpu_array_copy(struct bpf_map *map, void *key, void *value,
+			  u64 flags);
 int bpf_percpu_hash_update(struct bpf_map *map, void *key, void *value,
 			   u64 flags);
 int bpf_percpu_array_update(struct bpf_map *map, void *key, void *value,
@@ -3760,7 +3761,12 @@ struct bpf_prog *bpf_prog_find_from_stack(void);
 
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
 
 static inline int bpf_map_check_op_flags(struct bpf_map *map, u64 flags, u64 extra_flags_mask)
diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
index 3d080916faf97..42a75fbc588a1 100644
--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -295,17 +295,21 @@ static void *percpu_array_map_lookup_percpu_elem(struct bpf_map *map, void *key,
 	return per_cpu_ptr(array->pptrs[index & array->index_mask], cpu);
 }
 
-int bpf_percpu_array_copy(struct bpf_map *map, void *key, void *value)
+int bpf_percpu_array_copy(struct bpf_map *map, void *key, void *value, u64 flags)
 {
 	struct bpf_array *array = container_of(map, struct bpf_array, map);
 	u32 index = *(u32 *)key;
 	void __percpu *pptr;
-	int cpu, off = 0;
 	u32 size;
+	int err;
 
 	if (unlikely(index >= array->map.max_entries))
 		return -ENOENT;
 
+	err = bpf_map_check_cpu_flags(flags, false);
+	if (unlikely(err))
+		return err;
+
 	/* per_cpu areas are zero-filled and bpf programs can only
 	 * access 'value_size' of them, so copying rounded areas
 	 * will not leak any kernel data
@@ -313,11 +317,7 @@ int bpf_percpu_array_copy(struct bpf_map *map, void *key, void *value)
 	size = array->elem_size;
 	rcu_read_lock();
 	pptr = array->pptrs[index & array->index_mask];
-	for_each_possible_cpu(cpu) {
-		copy_map_value_long(map, value + off, per_cpu_ptr(pptr, cpu));
-		check_and_init_map_value(map, value + off);
-		off += size;
-	}
+	bpf_percpu_copy_to_user(map, pptr, value, size, flags);
 	rcu_read_unlock();
 	return 0;
 }
@@ -387,12 +387,12 @@ int bpf_percpu_array_update(struct bpf_map *map, void *key, void *value,
 	struct bpf_array *array = container_of(map, struct bpf_array, map);
 	u32 index = *(u32 *)key;
 	void __percpu *pptr;
-	int cpu, off = 0;
 	u32 size;
+	int err;
 
-	if (unlikely(map_flags > BPF_EXIST))
-		/* unknown flags */
-		return -EINVAL;
+	err = bpf_map_check_cpu_flags(map_flags, true);
+	if (unlikely(err))
+		return err;
 
 	if (unlikely(index >= array->map.max_entries))
 		/* all elements were pre-allocated, cannot insert a new one */
@@ -411,11 +411,7 @@ int bpf_percpu_array_update(struct bpf_map *map, void *key, void *value,
 	size = array->elem_size;
 	rcu_read_lock();
 	pptr = array->pptrs[index & array->index_mask];
-	for_each_possible_cpu(cpu) {
-		copy_map_value_long(map, per_cpu_ptr(pptr, cpu), value + off);
-		bpf_obj_free_fields(array->map.record, per_cpu_ptr(pptr, cpu));
-		off += size;
-	}
+	bpf_percpu_copy_from_user(map, pptr, value, size, map_flags);
 	rcu_read_unlock();
 	return 0;
 }
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index dbd21484d7a4d..2ee2cf5a8cedf 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -316,7 +316,7 @@ static int bpf_map_copy_value(struct bpf_map *map, void *key, void *value,
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


