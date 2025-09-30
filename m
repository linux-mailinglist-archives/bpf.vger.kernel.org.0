Return-Path: <bpf+bounces-70048-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 25469BADEDC
	for <lists+bpf@lfdr.de>; Tue, 30 Sep 2025 17:40:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F12264E2238
	for <lists+bpf@lfdr.de>; Tue, 30 Sep 2025 15:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D7C6306B05;
	Tue, 30 Sep 2025 15:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jpHDty1y"
X-Original-To: bpf@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B35173
	for <bpf@vger.kernel.org>; Tue, 30 Sep 2025 15:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759246809; cv=none; b=qYiq6D9+EXjITs+lpuGUk+4RWEvIP2pg9hCrVziTrf8OZveyuejq+RYVw5j9mhJzLwmG1vQu1AKjh1LUR52b7ycjR+ISipEI2B18uitaDTAAWhg5xcK+TyK0PG88uVLj4KI3vJ0upl91tK2t/o1z7e3T5TDna7OUDoUQfwZ3PCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759246809; c=relaxed/simple;
	bh=LTTmFEr9wEQnfIAl+fV1oHylN5txDgRWiGVBblke9M8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z1qkyFeaXc+F9EhPh0xVfwpBq5DIyQFfpEgHT51mtwPtSrNXwSyPCTtvZ4JdRN7zsC2eY04MZ6b40dv8TGuEd623LHQuwtMA1S/CfB/nhvysPRRla0E2q7vyLendWeaGnTeWyCxomHFnJsoqGV6EQ2YlXd4GSq4EVMOlJGQSHus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jpHDty1y; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1759246802;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kzsxJN1Rb+pfkQw1oDaxY6vAV0SSt5P9ws7H6CzGm9k=;
	b=jpHDty1yqnWgRzhhy1JK5j+AiC2jUvoMLLj9GwIiN0E8aYWGHtA6FO0Ge1NYzRF16+SdOz
	ZVfdkUeJELVo0GV6ej4mgUFeW/hkoS5ADULFr5EBIUuUfBIYG2qK3ztF5EYpc4dF4yl+kF
	4rlPMDv7DQ1sJrAvrmLZjTpk2Q0uRMA=
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
Subject: [PATCH bpf-next v9 2/7] bpf: Introduce BPF_F_CPU and BPF_F_ALL_CPUS flags
Date: Tue, 30 Sep 2025 23:39:37 +0800
Message-ID: <20250930153942.41781-3-leon.hwang@linux.dev>
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

Introduce BPF_F_CPU and BPF_F_ALL_CPUS flags and check them for
following APIs:

* 'map_lookup_elem()'
* 'map_update_elem()'
* 'generic_map_lookup_batch()'
* 'generic_map_update_batch()'

And, get the correct value size for these APIs.

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 include/linux/bpf.h            | 23 ++++++++++++++++++++++-
 include/uapi/linux/bpf.h       |  2 ++
 kernel/bpf/syscall.c           | 31 +++++++++++++++++--------------
 tools/include/uapi/linux/bpf.h |  2 ++
 4 files changed, 43 insertions(+), 15 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index fb48db5bde472..731de0efdd00e 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -3768,14 +3768,35 @@ int bpf_prog_get_file_line(struct bpf_prog *prog, unsigned long ip, const char *
 			   const char **linep, int *nump);
 struct bpf_prog *bpf_prog_find_from_stack(void);
 
+static inline bool bpf_map_supports_cpu_flags(enum bpf_map_type map_type)
+{
+	return false;
+}
+
 static inline int bpf_map_check_op_flags(struct bpf_map *map, u64 flags, u64 allowed_flags)
 {
-	if (flags & ~allowed_flags)
+	u32 cpu;
+
+	if ((u32)flags & ~allowed_flags)
 		return -EINVAL;
 
 	if ((flags & BPF_F_LOCK) && !btf_record_has_field(map->record, BPF_SPIN_LOCK))
 		return -EINVAL;
 
+	if (!(flags & BPF_F_CPU) && flags >> 32)
+		return -EINVAL;
+
+	if (flags & (BPF_F_CPU | BPF_F_ALL_CPUS)) {
+		if (!bpf_map_supports_cpu_flags(map->map_type))
+			return -EINVAL;
+		if ((flags & BPF_F_CPU) && (flags & BPF_F_ALL_CPUS))
+			return -EINVAL;
+
+		cpu = flags >> 32;
+		if ((flags & BPF_F_CPU) && cpu >= num_possible_cpus())
+			return -ERANGE;
+	}
+
 	return 0;
 }
 
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index ae83d8649ef1c..f827353424ec5 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1372,6 +1372,8 @@ enum {
 	BPF_NOEXIST	= 1, /* create new element if it didn't exist */
 	BPF_EXIST	= 2, /* update existing element */
 	BPF_F_LOCK	= 4, /* spin_lock-ed map_lookup/map_update */
+	BPF_F_CPU	= 8, /* cpu flag for percpu maps, upper 32-bit of flags is a cpu number */
+	BPF_F_ALL_CPUS	= 16, /* update value across all CPUs for percpu maps */
 };
 
 /* flags for BPF_MAP_CREATE command */
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 6c252d3337928..8c206d46de3f5 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -133,12 +133,14 @@ bool bpf_map_write_active(const struct bpf_map *map)
 	return atomic64_read(&map->writecnt) != 0;
 }
 
-static u32 bpf_map_value_size(const struct bpf_map *map)
-{
-	if (map->map_type == BPF_MAP_TYPE_PERCPU_HASH ||
-	    map->map_type == BPF_MAP_TYPE_LRU_PERCPU_HASH ||
-	    map->map_type == BPF_MAP_TYPE_PERCPU_ARRAY ||
-	    map->map_type == BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE)
+static u32 bpf_map_value_size(const struct bpf_map *map, u64 flags)
+{
+	if (flags & (BPF_F_CPU | BPF_F_ALL_CPUS))
+		return map->value_size;
+	else if (map->map_type == BPF_MAP_TYPE_PERCPU_HASH ||
+		 map->map_type == BPF_MAP_TYPE_LRU_PERCPU_HASH ||
+		 map->map_type == BPF_MAP_TYPE_PERCPU_ARRAY ||
+		 map->map_type == BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE)
 		return round_up(map->value_size, 8) * num_possible_cpus();
 	else if (IS_FD_MAP(map))
 		return sizeof(u32);
@@ -1716,7 +1718,7 @@ static int map_lookup_elem(union bpf_attr *attr)
 	if (!(map_get_sys_perms(map, f) & FMODE_CAN_READ))
 		return -EPERM;
 
-	err = bpf_map_check_op_flags(map, attr->flags, BPF_F_LOCK);
+	err = bpf_map_check_op_flags(map, attr->flags, BPF_F_LOCK | BPF_F_CPU);
 	if (err)
 		return err;
 
@@ -1724,7 +1726,7 @@ static int map_lookup_elem(union bpf_attr *attr)
 	if (IS_ERR(key))
 		return PTR_ERR(key);
 
-	value_size = bpf_map_value_size(map);
+	value_size = bpf_map_value_size(map, attr->flags);
 
 	err = -ENOMEM;
 	value = kvmalloc(value_size, GFP_USER | __GFP_NOWARN);
@@ -1791,7 +1793,7 @@ static int map_update_elem(union bpf_attr *attr, bpfptr_t uattr)
 		goto err_put;
 	}
 
-	value_size = bpf_map_value_size(map);
+	value_size = bpf_map_value_size(map, attr->flags);
 	value = kvmemdup_bpfptr(uvalue, value_size);
 	if (IS_ERR(value)) {
 		err = PTR_ERR(value);
@@ -1987,11 +1989,12 @@ int generic_map_update_batch(struct bpf_map *map, struct file *map_file,
 	void *key, *value;
 	int err = 0;
 
-	err = bpf_map_check_op_flags(map, attr->batch.elem_flags, BPF_F_LOCK);
+	err = bpf_map_check_op_flags(map, attr->batch.elem_flags,
+				     BPF_F_LOCK | BPF_F_CPU | BPF_F_ALL_CPUS);
 	if (err)
 		return err;
 
-	value_size = bpf_map_value_size(map);
+	value_size = bpf_map_value_size(map, attr->batch.elem_flags);
 
 	max_count = attr->batch.count;
 	if (!max_count)
@@ -2046,11 +2049,11 @@ int generic_map_lookup_batch(struct bpf_map *map,
 	u32 value_size, cp, max_count;
 	int err;
 
-	err = bpf_map_check_op_flags(map, attr->batch.elem_flags, BPF_F_LOCK);
+	err = bpf_map_check_op_flags(map, attr->batch.elem_flags, BPF_F_LOCK | BPF_F_CPU);
 	if (err)
 		return err;
 
-	value_size = bpf_map_value_size(map);
+	value_size = bpf_map_value_size(map, attr->batch.elem_flags);
 
 	max_count = attr->batch.count;
 	if (!max_count)
@@ -2172,7 +2175,7 @@ static int map_lookup_and_delete_elem(union bpf_attr *attr)
 		goto err_put;
 	}
 
-	value_size = bpf_map_value_size(map);
+	value_size = bpf_map_value_size(map, 0);
 
 	err = -ENOMEM;
 	value = kvmalloc(value_size, GFP_USER | __GFP_NOWARN);
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index ae83d8649ef1c..f827353424ec5 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1372,6 +1372,8 @@ enum {
 	BPF_NOEXIST	= 1, /* create new element if it didn't exist */
 	BPF_EXIST	= 2, /* update existing element */
 	BPF_F_LOCK	= 4, /* spin_lock-ed map_lookup/map_update */
+	BPF_F_CPU	= 8, /* cpu flag for percpu maps, upper 32-bit of flags is a cpu number */
+	BPF_F_ALL_CPUS	= 16, /* update value across all CPUs for percpu maps */
 };
 
 /* flags for BPF_MAP_CREATE command */
-- 
2.51.0


