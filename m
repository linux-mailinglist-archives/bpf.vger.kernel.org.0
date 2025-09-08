Return-Path: <bpf+bounces-67716-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A865B491BB
	for <lists+bpf@lfdr.de>; Mon,  8 Sep 2025 16:38:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC6A81BC11FA
	for <lists+bpf@lfdr.de>; Mon,  8 Sep 2025 14:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1488730BF4B;
	Mon,  8 Sep 2025 14:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Dc1l9M63"
X-Original-To: bpf@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C78EA2FDC2F
	for <bpf@vger.kernel.org>; Mon,  8 Sep 2025 14:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757342245; cv=none; b=iVBMINugio4x7QVkWpUzuaxJl3tmDr9jwz2RkeOKj6zpnKSbgrDqc00UkjUJxqIJ6dtgNmxeyVIjuBua6knsvFHGGnk6SD/9p5vvC4hfd6F/AbLF9ScyN6jCKyQ4VkV4sfYI57kSimpQ6B8NKCaEnT8poUKwuq1bvjJJIUxgVXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757342245; c=relaxed/simple;
	bh=UWAxBWbe802LMfu34MN2kCwHwV2wa6CtSqhd1/l1RSw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ccvKv3M1gYpVyZN9zcu6srZlu5S3rzKeC3KWvQcM7D9tLLI3gq5g0DxZAn/NnEfzzT5KMF1xVKqgCFvA1Jl8e+Bt4wEq0ymRKb9YdfZExK9xzJUiiGUQ5RbZBO2J8aJThowxnJt93GB74PJJ6XlHL2elolICJZARNFN92+k2YQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Dc1l9M63; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757342242;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1YtGUhBLQSBhfGTjYReLxAVsnN/pHzQ52hbuGUlmJew=;
	b=Dc1l9M63Whc8/Ni6j/1wQZZTCpxWcSvxE91Laq5dHJV5XZ8aMTMROiB8lt5WQY2bbzDv0V
	JOW2ad7v984dTjO96ciPHGMJFuvi90w1G0i6VIIWM1c7jS6+/SH26+ccyCYWDFcQDDNh9s
	3/KbOtnzHvmD5J76iEzr49YAnkgX+wc=
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
Subject: [PATCH bpf-next v5 3/9] bpf: Introduce BPF_F_CPU and BPF_F_ALL_CPUS flags
Date: Mon,  8 Sep 2025 22:36:38 +0800
Message-ID: <20250908143644.30993-4-leon.hwang@linux.dev>
In-Reply-To: <20250908143644.30993-1-leon.hwang@linux.dev>
References: <20250908143644.30993-1-leon.hwang@linux.dev>
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

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 include/linux/bpf.h            | 39 +++++++++++++++++++++++++++++++---
 include/uapi/linux/bpf.h       |  2 ++
 kernel/bpf/syscall.c           | 24 +++++++++++----------
 tools/include/uapi/linux/bpf.h |  2 ++
 4 files changed, 53 insertions(+), 14 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 55c98c7d52510..a78e07b0cb6cb 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -3735,20 +3735,31 @@ int bpf_prog_get_file_line(struct bpf_prog *prog, unsigned long ip, const char *
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
+	if ((u32)flags & ~allowed_flags)
 		return -EINVAL;
 
 	if ((flags & BPF_F_LOCK) && !btf_record_has_field(map->record, BPF_SPIN_LOCK))
 		return -EINVAL;
 
+	if (!(flags & BPF_F_CPU) && flags >> 32)
+		return -EINVAL;
+
+	if ((flags & (BPF_F_CPU | BPF_F_ALL_CPUS)) && !bpf_map_supports_cpu_flags(map->map_type))
+		return -EINVAL;
+
 	return 0;
 }
 
 static inline int bpf_map_check_lookup_flags(struct bpf_map *map, u64 flags)
 {
-	return bpf_map_check_op_flags(map, flags, BPF_F_LOCK);
+	return bpf_map_check_op_flags(map, flags, BPF_F_LOCK | BPF_F_CPU);
 }
 
 static inline int bpf_map_check_update_flags(struct bpf_map *map, u64 flags)
@@ -3763,7 +3774,29 @@ static inline int bpf_map_check_lookup_batch_flags(struct bpf_map *map, u64 flag
 
 static inline int bpf_map_check_update_batch_flags(struct bpf_map *map, u64 flags)
 {
-	return bpf_map_check_op_flags(map, flags, BPF_F_LOCK);
+	return bpf_map_check_op_flags(map, flags, BPF_F_LOCK | BPF_F_CPU | BPF_F_ALL_CPUS);
+}
+
+static inline int bpf_map_check_cpu_flags(u64 flags, bool check_all_cpus_flag)
+{
+	const u64 cpu_flags = BPF_F_CPU | BPF_F_ALL_CPUS;
+	u32 cpu;
+
+	if (check_all_cpus_flag) {
+		if (unlikely((u32)flags > BPF_F_ALL_CPUS))
+			return -EINVAL;
+		if (unlikely((flags & cpu_flags) == cpu_flags))
+			return -EINVAL;
+	} else {
+		if (unlikely((u32)flags & ~BPF_F_CPU))
+			return -EINVAL;
+	}
+
+	cpu = flags >> 32;
+	if (unlikely((flags & BPF_F_CPU) && cpu >= num_possible_cpus()))
+		return -ERANGE;
+
+	return 0;
 }
 
 #endif /* _LINUX_BPF_H */
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 233de8677382e..be1fdc5042744 100644
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
index 3a51836f18915..50ece48409f3b 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -131,12 +131,14 @@ bool bpf_map_write_active(const struct bpf_map *map)
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
@@ -1684,7 +1686,7 @@ static int map_lookup_elem(union bpf_attr *attr)
 	if (IS_ERR(key))
 		return PTR_ERR(key);
 
-	value_size = bpf_map_value_size(map);
+	value_size = bpf_map_value_size(map, attr->flags);
 
 	err = -ENOMEM;
 	value = kvmalloc(value_size, GFP_USER | __GFP_NOWARN);
@@ -1751,7 +1753,7 @@ static int map_update_elem(union bpf_attr *attr, bpfptr_t uattr)
 		goto err_put;
 	}
 
-	value_size = bpf_map_value_size(map);
+	value_size = bpf_map_value_size(map, attr->flags);
 	value = kvmemdup_bpfptr(uvalue, value_size);
 	if (IS_ERR(value)) {
 		err = PTR_ERR(value);
@@ -1951,7 +1953,7 @@ int generic_map_update_batch(struct bpf_map *map, struct file *map_file,
 	if (err)
 		return err;
 
-	value_size = bpf_map_value_size(map);
+	value_size = bpf_map_value_size(map, attr->batch.elem_flags);
 
 	max_count = attr->batch.count;
 	if (!max_count)
@@ -2010,7 +2012,7 @@ int generic_map_lookup_batch(struct bpf_map *map,
 	if (err)
 		return err;
 
-	value_size = bpf_map_value_size(map);
+	value_size = bpf_map_value_size(map, attr->batch.elem_flags);
 
 	max_count = attr->batch.count;
 	if (!max_count)
@@ -2132,7 +2134,7 @@ static int map_lookup_and_delete_elem(union bpf_attr *attr)
 		goto err_put;
 	}
 
-	value_size = bpf_map_value_size(map);
+	value_size = bpf_map_value_size(map, 0);
 
 	err = -ENOMEM;
 	value = kvmalloc(value_size, GFP_USER | __GFP_NOWARN);
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 233de8677382e..be1fdc5042744 100644
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


