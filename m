Return-Path: <bpf+bounces-66689-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ABF6FB387F3
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 18:46:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6621B687D21
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 16:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D35FA13C9C4;
	Wed, 27 Aug 2025 16:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qUOP5tMp"
X-Original-To: bpf@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983731C5D77
	for <bpf@vger.kernel.org>; Wed, 27 Aug 2025 16:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756313157; cv=none; b=BqdJGdRSnBYZmRcIKTM9NWLEJiJ18bPsYyE4pMsRP4h9K785MqSBTTXtb8jV83lF92kL7Oa+GNVnNYJcMjTwRUhWW/eQlLOEJneiVvR3Mq0yj0GLZqFwea4xW08/D1l5ni3/d48+YI85G1nOQyfcQZJrFc5/49JUvcBk2dP78J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756313157; c=relaxed/simple;
	bh=8ku6OEf3d2CGydMHBVekWKHxIT6MsuCxCv9N7vpHGMg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O+CfJjETECR2u0Huje8dMybIc9udBXaN7qkt5Tyo86ZGANk958OarkLTdwbZQGmpvj/Dbj9k0BwzBnYWiVrZaK46Pm8aPwIqRgHquq4usOoynRiUCdsFTB1eA+MxJnKeaspLHmxthUFerZDoNw7Qs9Ydd3b26FgoqxlonzHXNAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qUOP5tMp; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756313153;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/9AOIpzvJMdSXDof0KsRVALWfiePVkaZdf4ew2cKKio=;
	b=qUOP5tMpuDobmVHrDeWWhTS9NdG5c5NG53TplBaG+oZJzF81XsX/tzAGGneeUpw3c7Wrty
	+IN3QkgK5PZ58OmyhtpH96ky2Pd5hTiwqi4OTVhSNbrYnEBhBJ+0JcwaujouTBSpfj5gWn
	Z0cD9Aog34sHK/8MHPozKQ5drr7zLho=
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
Subject: [PATCH bpf-next v4 5/7] bpf: Introduce BPF_F_CPU and BPF_F_ALL_CPUS flags for percpu_cgroup_storage maps
Date: Thu, 28 Aug 2025 00:45:07 +0800
Message-ID: <20250827164509.7401-6-leon.hwang@linux.dev>
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
 include/linux/bpf-cgroup.h |  5 +++--
 include/linux/bpf.h        |  1 +
 kernel/bpf/local_storage.c | 42 ++++++++++++++++++++------------------
 kernel/bpf/syscall.c       |  2 +-
 4 files changed, 27 insertions(+), 23 deletions(-)

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
index c120b00448a13..2d67af3e7f870 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -3765,6 +3765,7 @@ static inline bool bpf_map_supports_cpu_flags(enum bpf_map_type map_type)
 	case BPF_MAP_TYPE_PERCPU_ARRAY:
 	case BPF_MAP_TYPE_PERCPU_HASH:
 	case BPF_MAP_TYPE_LRU_PERCPU_HASH:
+	case BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE:
 		return true;
 	default:
 		return false;
diff --git a/kernel/bpf/local_storage.c b/kernel/bpf/local_storage.c
index c93a756e035c0..31b146cf8f48e 100644
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
 	u32 size;
+	int err;
+
+	err = bpf_map_check_cpu_flags(map_flags, false);
+	if (err)
+		return err;
 
 	rcu_read_lock();
 	storage = cgroup_storage_lookup(map, key, false);
 	if (!storage) {
-		rcu_read_unlock();
-		return -ENOENT;
+		err = -ENOENT;
+		goto unlock;
 	}
 
 	/* per_cpu areas are zero-filled and bpf programs can only
@@ -199,13 +203,10 @@ int bpf_percpu_cgroup_storage_copy(struct bpf_map *_map, void *key,
 	 * will not leak any kernel data
 	 */
 	size = round_up(_map->value_size, 8);
-	for_each_possible_cpu(cpu) {
-		bpf_long_memcpy(value + off,
-				per_cpu_ptr(storage->percpu_buf, cpu), size);
-		off += size;
-	}
+	bpf_percpu_copy_to_user(_map, storage->percpu_buf, value, size, map_flags);
+unlock:
 	rcu_read_unlock();
-	return 0;
+	return err;
 }
 
 int bpf_percpu_cgroup_storage_update(struct bpf_map *_map, void *key,
@@ -213,17 +214,21 @@ int bpf_percpu_cgroup_storage_update(struct bpf_map *_map, void *key,
 {
 	struct bpf_cgroup_storage_map *map = map_to_storage(_map);
 	struct bpf_cgroup_storage *storage;
-	int cpu, off = 0;
 	u32 size;
+	int err;
 
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
@@ -233,13 +238,10 @@ int bpf_percpu_cgroup_storage_update(struct bpf_map *_map, void *key,
 	 * so no kernel data leaks possible
 	 */
 	size = round_up(_map->value_size, 8);
-	for_each_possible_cpu(cpu) {
-		bpf_long_memcpy(per_cpu_ptr(storage->percpu_buf, cpu),
-				value + off, size);
-		off += size;
-	}
+	bpf_percpu_copy_from_user(_map, storage->percpu_buf, value, size, map_flags);
+unlock:
 	rcu_read_unlock();
-	return 0;
+	return err;
 }
 
 static int cgroup_storage_get_next_key(struct bpf_map *_map, void *key,
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 91ab9bdd1da38..0c88d7f6f1491 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -318,7 +318,7 @@ static int bpf_map_copy_value(struct bpf_map *map, void *key, void *value,
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


