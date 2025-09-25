Return-Path: <bpf+bounces-69734-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C28EDBA0682
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 17:43:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71FA83AE10D
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 15:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD46D2F2907;
	Thu, 25 Sep 2025 15:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VOx+n54U"
X-Original-To: bpf@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A7582F2611
	for <bpf@vger.kernel.org>; Thu, 25 Sep 2025 15:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758814730; cv=none; b=GMrwo0TE5PDZd8HGQxalDAilQ73VgvRymD8UmgGYPNaTWwK5TPJaFPk7Lyz/nSwXZPWOmg0JUi/GM5kpkTi042elRjwU26N6ZRdW6hapYw/eOGSi4Bmq7U6gy9GlhThQF/wz6L9nSWypnHKqKlbs3zKmO9Z8Rc1FqasogVMkVuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758814730; c=relaxed/simple;
	bh=FLyjlSj94Uf1+G3tYW/MFpSh5DT0Zn+JXDaPT+TQrbs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rSLho70lmzvESOQJ/P48ZDaYfAn848dOuhTi1It9ZsI+rqAQOfhshC8DJOxVoknB3GRb65XbaIoTka7QCESZTAmv4j3PjrcHDI3By1LHD+vuaB1+EVzRWx7BJuBoerBKbPsTCSHCMqXKoVRsieqt9zJPadn59ktY07t7cvtpbh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VOx+n54U; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758814726;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=krqdncVXuf13EGnovWtN9nACOKg5qakfqOWWYfkfLcM=;
	b=VOx+n54Ul5E89MksfwycoHv/QOMlSXl/yy9/tIiuqby60uqfbViw0k0mjaJjraAFGUKhGC
	ZwwiDolYklUeLNV7VUEhdae5JtITYvEQKsH8xvcJLmiTBZbghWNtPerfLA11igH36VnVNp
	ja7uD9W7utq2sQD3S/RPyYWMHKgfDyI=
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
Subject: [PATCH bpf-next v8 5/7] bpf: Add BPF_F_CPU and BPF_F_ALL_CPUS flags support for percpu_cgroup_storage maps
Date: Thu, 25 Sep 2025 23:37:44 +0800
Message-ID: <20250925153746.96154-6-leon.hwang@linux.dev>
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
 kernel/bpf/local_storage.c | 22 +++++++++++++++++++---
 kernel/bpf/syscall.c       |  2 +-
 4 files changed, 23 insertions(+), 6 deletions(-)

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
index 04041dd35d42f..c19237cd122ac 100644
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
index c93a756e035c0..6887a78b4823a 100644
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
@@ -199,11 +199,17 @@ int bpf_percpu_cgroup_storage_copy(struct bpf_map *_map, void *key,
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
 	return 0;
 }
@@ -216,7 +222,7 @@ int bpf_percpu_cgroup_storage_update(struct bpf_map *_map, void *key,
 	int cpu, off = 0;
 	u32 size;
 
-	if (map_flags != BPF_ANY && map_flags != BPF_EXIST)
+	if ((u32)map_flags & ~(BPF_ANY | BPF_EXIST | BPF_F_CPU | BPF_F_ALL_CPUS))
 		return -EINVAL;
 
 	rcu_read_lock();
@@ -233,11 +239,21 @@ int bpf_percpu_cgroup_storage_update(struct bpf_map *_map, void *key,
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
 	return 0;
 }
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index f336ca1f48d9b..c227994c065ff 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -320,7 +320,7 @@ static int bpf_map_copy_value(struct bpf_map *map, void *key, void *value,
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


