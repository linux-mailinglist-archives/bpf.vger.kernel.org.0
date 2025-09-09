Return-Path: <bpf+bounces-67875-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7842B4FF2C
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 16:19:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76F4A7B63CD
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 14:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CF5333EAE1;
	Tue,  9 Sep 2025 14:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KU9k52fk"
X-Original-To: bpf@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DAE2326D64
	for <bpf@vger.kernel.org>; Tue,  9 Sep 2025 14:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757427308; cv=none; b=JwhbQSdAqCi85d2s2guaSOHb5HmgiG3LAQ6en2ENnN+RhlI1eRw7uOb33wrgSyqftHSL1AIXYlkwd1QsqYQBK0i8jltmIJHrv56SWDCe/pPBd8MTHKy2Hhh0opo1IOY8Wcrd0bsVln8dmVYA4zI0gLuYdIyqWT+k+rFgssQN4uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757427308; c=relaxed/simple;
	bh=vMx89B6BTshk8z8DKxfAGR1tMqxaPY02AJCzg0cmXpg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cHK5WgfOUAwQ0j1rADPo5hK2gfC9sN4Am1uXFr+4bJHN4N2iTAlqmPoGBjd+DDV1lLAmFa4cJrefMQwuSrEBy3wyDiwpTwK5KQyRq6HXzLvfxCZFq+MvZJo/I9BuiU+PqSuzzWiuQhcZ0xF/pFSO8d+1MpX+f2lwz07Q9MMib/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KU9k52fk; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757427301;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0+ENcCBYT33p7C9Dyc3WybXFWLU8J/ZVx0W74hj3/4E=;
	b=KU9k52fk2QUUGlvRMXcBwy/NDrpIGQmy7IgRnC8JCpfnlTYF3aBLbRv+XWrIDZpRzoUTAh
	AFKJL4Ho3MWOYaldlv5zuk8W72ctOL3252JrUc7ODqZDDUfgc8UuiOj++23P1nbc+WiStt
	XN1XUZGbXhotbNZ3cUjln/RJLnYHhko=
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
Subject: [PATCH bpf-next v6 5/7] bpf: Add BPF_F_CPU and BPF_F_ALL_CPUS flags support for percpu_cgroup_storage maps
Date: Tue,  9 Sep 2025 22:14:19 +0800
Message-ID: <20250909141422.45450-6-leon.hwang@linux.dev>
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
 kernel/bpf/local_storage.c | 46 +++++++++++++++++++++++++++++---------
 kernel/bpf/syscall.c       |  3 ++-
 3 files changed, 39 insertions(+), 14 deletions(-)

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
diff --git a/kernel/bpf/local_storage.c b/kernel/bpf/local_storage.c
index c93a756e035c0..1abfbb27449ee 100644
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
+	int err, cpu, off = 0;
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
+	int err, cpu, off = 0;
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
@@ -233,13 +247,23 @@ int bpf_percpu_cgroup_storage_update(struct bpf_map *_map, void *key,
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
+		/* same user-provided value is used if BPF_F_ALL_CPUS is
+		 * specified, otherwise value is an array of per-CPU values.
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
index d01424e0560ce..dbb715719f40c 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -137,6 +137,7 @@ static bool bpf_map_supports_cpu_flags(enum bpf_map_type map_type)
 	case BPF_MAP_TYPE_PERCPU_ARRAY:
 	case BPF_MAP_TYPE_PERCPU_HASH:
 	case BPF_MAP_TYPE_LRU_PERCPU_HASH:
+	case BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE:
 		return true;
 	default:
 		return false;
@@ -347,7 +348,7 @@ static int bpf_map_copy_value(struct bpf_map *map, void *key, void *value,
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


