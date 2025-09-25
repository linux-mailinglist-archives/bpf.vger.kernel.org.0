Return-Path: <bpf+bounces-69731-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 85B64BA061A
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 17:38:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 934A77A5964
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 15:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F7E62F2617;
	Thu, 25 Sep 2025 15:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nPmNE7GX"
X-Original-To: bpf@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A52A2EC097
	for <bpf@vger.kernel.org>; Thu, 25 Sep 2025 15:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758814713; cv=none; b=l6YOngc3jaA5VqygEN/6rPGY2hRko3DReRR7Hi3pHrJ1cBuxfStM9oma8notZmAoUmcDH9a2pNjZxYEsaWASkYEwcSQ6RfcWMlEu4dTEWZ4hojdMiZkG9WD6Jh0bt2UrZ4cDaRv3EWnzB5i7PbNle8xt/eDXhGbASOsPGu29cag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758814713; c=relaxed/simple;
	bh=KdAakbByF74Qj2OkzitxWQbNN0gnl9HBMSlg+329nW8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pHvIK4eq7A9p8BVOP6NIGGxt4/w2ujVkE9MILPXXaS8AZqUH/BUTDT0G9XiM5hDYrMF61krQH65jsxdnvyxydrVHuGmqJnq8xRhkcLUg8+CEJK1C4ziee68UzddLN/gZsLr7awSI0iYxb9ZME062NzOccf1qg+MR2e63ovmuvhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nPmNE7GX; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758814708;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K2Rbo2702JxrBea6n3voPdjlWf3dd+rVGQZ5CKJ7V3w=;
	b=nPmNE7GXdi9MpmX54bbw7PEOe6jLiUDoygffCBPfDZbMMjG3VlhFPpx+hJwtmIfqcCLUlu
	ntC4VX4NnMTtHjl300XMzPJR6bBfeJ9aqQuwMqaaYsMIcVi1zVipS94ed7uAFGLOYjow49
	fiHoxDESnRJn8K2brQZcTvJyA72OqZE=
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
Subject: [PATCH bpf-next v8 2/7] bpf: Introduce BPF_F_CPU and BPF_F_ALL_CPUS flags
Date: Thu, 25 Sep 2025 23:37:41 +0800
Message-ID: <20250925153746.96154-3-leon.hwang@linux.dev>
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
index 536a640246fec..80719765d40e6 100644
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
index 84261a0211c51..d1bbc309b62ff 100644
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
+		return round_up(map->value_size, 8);
+	else if (map->map_type == BPF_MAP_TYPE_PERCPU_HASH ||
+		 map->map_type == BPF_MAP_TYPE_LRU_PERCPU_HASH ||
+		 map->map_type == BPF_MAP_TYPE_PERCPU_ARRAY ||
+		 map->map_type == BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE)
 		return round_up(map->value_size, 8) * num_possible_cpus();
 	else if (IS_FD_MAP(map))
 		return sizeof(u32);
@@ -1715,7 +1717,7 @@ static int map_lookup_elem(union bpf_attr *attr)
 	if (!(map_get_sys_perms(map, f) & FMODE_CAN_READ))
 		return -EPERM;
 
-	err = bpf_map_check_op_flags(map, attr->flags, BPF_F_LOCK);
+	err = bpf_map_check_op_flags(map, attr->flags, BPF_F_LOCK | BPF_F_CPU);
 	if (err)
 		return err;
 
@@ -1723,7 +1725,7 @@ static int map_lookup_elem(union bpf_attr *attr)
 	if (IS_ERR(key))
 		return PTR_ERR(key);
 
-	value_size = bpf_map_value_size(map);
+	value_size = bpf_map_value_size(map, attr->flags);
 
 	err = -ENOMEM;
 	value = kvmalloc(value_size, GFP_USER | __GFP_NOWARN);
@@ -1790,7 +1792,7 @@ static int map_update_elem(union bpf_attr *attr, bpfptr_t uattr)
 		goto err_put;
 	}
 
-	value_size = bpf_map_value_size(map);
+	value_size = bpf_map_value_size(map, attr->flags);
 	value = kvmemdup_bpfptr(uvalue, value_size);
 	if (IS_ERR(value)) {
 		err = PTR_ERR(value);
@@ -1986,11 +1988,12 @@ int generic_map_update_batch(struct bpf_map *map, struct file *map_file,
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
@@ -2045,11 +2048,11 @@ int generic_map_lookup_batch(struct bpf_map *map,
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
@@ -2171,7 +2174,7 @@ static int map_lookup_and_delete_elem(union bpf_attr *attr)
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
2.50.1


