Return-Path: <bpf+bounces-63663-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F17EB09512
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 21:38:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5722717A82D
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 19:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3ECB2FC3D0;
	Thu, 17 Jul 2025 19:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LOpnNdOb"
X-Original-To: bpf@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4FC72080C4
	for <bpf@vger.kernel.org>; Thu, 17 Jul 2025 19:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752781114; cv=none; b=ZjsXhzH5Ju+8Cik0DcUlu+Ed12TxPbq6KC1l7rH7tN6odxnXV6GqBu4vjHKFLMA9Ew+kIEPOYx7Bo9KJRBz7RXefkF0EdM2IwPP2pdIsaJjAPZMXJqattkw0XK9B1nMNlDlFwvFok4tczOZzhLUeqChf4oaOq5zp0//3A2WHMZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752781114; c=relaxed/simple;
	bh=9+ntgFbnjMrZYS43QiRIyaCBMJXMwk1nTGlbjO37xSo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uaXFDcB/0UbrDMntLqcADaRqdb3+fASp/UnoXkohtDdUeduYO5cYS7ztUhroFWxQp6OkS4urHOri5kZDslkFa4tFWfwk30/fdSVu5WUEhyiP8jxrzsaU7LYEHXjfkfgQKmXVzrWn6NUAE9efoTrVOsiE5zJMapJYff7XzuzzdCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LOpnNdOb; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752781110;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+hKu5B+A9IL9jJSouU/bizbztY2SwsJzp4YGIWTPaOw=;
	b=LOpnNdObA3Mz1kqoy6DL3N8ybbEjMx1pS9w9ke9SQctJqIC8qe0Z4U6IsN/FJQIspKdybD
	fkLkyZR3L0ingNKU5utnpgigf9ZQXafEyBfts9qzMpEKjrh5ZowSYAPY8a9pVVzw0ky2MJ
	L4cVTDEvsRWMP26vh3Kk1EN0VrkoHQE=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	yonghong.song@linux.dev,
	song@kernel.org,
	eddyz87@gmail.com,
	dxu@dxuuu.xyz,
	deso@posteo.net,
	leon.hwang@linux.dev,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf-next 2/3] bpf, libbpf: Support BPF_F_CPU for percpu_array map
Date: Fri, 18 Jul 2025 03:37:55 +0800
Message-ID: <20250717193756.37153-3-leon.hwang@linux.dev>
In-Reply-To: <20250717193756.37153-1-leon.hwang@linux.dev>
References: <20250717193756.37153-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This patch adds libbpf support for the BPF_F_CPU flag in percpu_array maps,
introducing the following APIs:

1. bpf_map_update_elem_opts(): update with struct bpf_map_update_elem_opts
2. bpf_map_lookup_elem_opts(): lookup with struct bpf_map_lookup_elem_opts
3. bpf_map__update_elem_opts(): high-level wrapper with input validation
4. bpf_map__lookup_elem_opts(): high-level wrapper with input validation

Behavior:

* If opts->cpu == (u32)~0, the update is applied to all CPUs.
* Otherwise, it applies only to the specified CPU.
* Lookup APIs retrieve values from the target CPU when BPF_F_CPU is used.

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 tools/lib/bpf/bpf.c           | 23 ++++++++++++++
 tools/lib/bpf/bpf.h           | 36 +++++++++++++++++++++-
 tools/lib/bpf/libbpf.c        | 56 +++++++++++++++++++++++++++++++----
 tools/lib/bpf/libbpf.h        | 53 ++++++++++++++++++++++++++++-----
 tools/lib/bpf/libbpf.map      |  5 ++++
 tools/lib/bpf/libbpf_common.h | 14 +++++++++
 6 files changed, 173 insertions(+), 14 deletions(-)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index ab40dbf9f020..8061093d84f9 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -402,6 +402,17 @@ int bpf_map_update_elem(int fd, const void *key, const void *value,
 	return libbpf_err_errno(ret);
 }
 
+int bpf_map_update_elem_opts(int fd, const void *key, const void *value,
+			     const struct bpf_map_update_elem_opts *opts)
+{
+	__u64 flags;
+	__u32 cpu;
+
+	cpu = OPTS_GET(opts, cpu, 0);
+	flags = ((__u64) cpu) << 32 | OPTS_GET(opts, flags, 0);
+	return bpf_map_update_elem(fd, key, value, flags);
+}
+
 int bpf_map_lookup_elem(int fd, const void *key, void *value)
 {
 	const size_t attr_sz = offsetofend(union bpf_attr, flags);
@@ -433,6 +444,17 @@ int bpf_map_lookup_elem_flags(int fd, const void *key, void *value, __u64 flags)
 	return libbpf_err_errno(ret);
 }
 
+int bpf_map_lookup_elem_opts(int fd, const void *key, void *value,
+			     const struct bpf_map_lookup_elem_opts *opts)
+{
+	__u64 flags;
+	__u32 cpu;
+
+	cpu = OPTS_GET(opts, cpu, 0);
+	flags = ((__u64) cpu) << 32 | OPTS_GET(opts, flags, 0);
+	return bpf_map_lookup_elem_flags(fd, key, value, flags);
+}
+
 int bpf_map_lookup_and_delete_elem(int fd, const void *key, void *value)
 {
 	const size_t attr_sz = offsetofend(union bpf_attr, flags);
@@ -542,6 +564,7 @@ static int bpf_map_batch_common(int cmd, int fd, void  *in_batch,
 	attr.batch.count = *count;
 	attr.batch.elem_flags  = OPTS_GET(opts, elem_flags, 0);
 	attr.batch.flags = OPTS_GET(opts, flags, 0);
+	attr.batch.cpu = OPTS_GET(opts, cpu, 0);
 
 	ret = sys_bpf(cmd, &attr, attr_sz);
 	*count = attr.batch.count;
diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index 7252150e7ad3..d0ab18b50294 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -163,12 +163,42 @@ LIBBPF_API int bpf_map_delete_elem_flags(int fd, const void *key, __u64 flags);
 LIBBPF_API int bpf_map_get_next_key(int fd, const void *key, void *next_key);
 LIBBPF_API int bpf_map_freeze(int fd);
 
+/**
+ * @brief **bpf_map_update_elem_opts** allows for updating map with options.
+ *
+ * @param fd BPF map file descriptor
+ * @param key pointer to key
+ * @param value pointer to value
+ * @param opts options for configuring the way to update map
+ * @return 0, on success; negative error code, otherwise (errno is also set to
+ * the error code)
+ */
+LIBBPF_API int bpf_map_update_elem_opts(int fd, const void *key, const void *value,
+					const struct bpf_map_update_elem_opts *opts);
+
+/**
+ * @brief **bpf_map_lookup_elem_opts** allows for looking up the value with
+ * options.
+ *
+ * @param fd BPF map file descriptor
+ * @param key pointer to key
+ * @param value pointer to value
+ * @param opts options for configuring the way to lookup map
+ * @return 0, on success; negative error code, otherwise (errno is also set to
+ * the error code)
+ */
+LIBBPF_API int bpf_map_lookup_elem_opts(int fd, const void *key, void *value,
+					const struct bpf_map_lookup_elem_opts *opts);
+
+
 struct bpf_map_batch_opts {
 	size_t sz; /* size of this struct for forward/backward compatibility */
 	__u64 elem_flags;
 	__u64 flags;
+	__u32 cpu;
+	size_t:0;
 };
-#define bpf_map_batch_opts__last_field flags
+#define bpf_map_batch_opts__last_field cpu
 
 
 /**
@@ -286,6 +316,10 @@ LIBBPF_API int bpf_map_lookup_and_delete_batch(int fd, void *in_batch,
  *    Update spin_lock-ed map elements. This must be
  *    specified if the map value contains a spinlock.
  *
+ * **BPF_F_CPU**
+ *    As for percpu map, update value across all CPUs if **opts->cpu** is
+ *    (__u32)~0, or on specified CPU otherwise.
+ *
  * @param fd BPF map file descriptor
  * @param keys pointer to an array of *count* keys
  * @param values pointer to an array of *count* values
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index aee36402f0a3..35faedef6ab4 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -10582,7 +10582,8 @@ bpf_object__find_map_fd_by_name(const struct bpf_object *obj, const char *name)
 }
 
 static int validate_map_op(const struct bpf_map *map, size_t key_sz,
-			   size_t value_sz, bool check_value_sz)
+			   size_t value_sz, bool check_value_sz, __u64 flags,
+			   __u32 cpu)
 {
 	if (!map_is_created(map)) /* map is not yet created */
 		return -ENOENT;
@@ -10601,6 +10602,19 @@ static int validate_map_op(const struct bpf_map *map, size_t key_sz,
 	if (!check_value_sz)
 		return 0;
 
+	if (flags & BPF_F_CPU) {
+		if (map->def.type != BPF_MAP_TYPE_PERCPU_ARRAY)
+			return -EINVAL;
+		if (cpu != BPF_ALL_CPUS && cpu >= libbpf_num_possible_cpus())
+			return -E2BIG;
+		if (map->def.value_size != value_sz) {
+			pr_warn("map '%s': unexpected value size %zu provided, expected %u\n",
+				map->name, value_sz, map->def.value_size);
+			return -EINVAL;
+		}
+		return 0;
+	}
+
 	switch (map->def.type) {
 	case BPF_MAP_TYPE_PERCPU_ARRAY:
 	case BPF_MAP_TYPE_PERCPU_HASH:
@@ -10633,32 +10647,62 @@ int bpf_map__lookup_elem(const struct bpf_map *map,
 {
 	int err;
 
-	err = validate_map_op(map, key_sz, value_sz, true);
+	err = validate_map_op(map, key_sz, value_sz, true, 0, 0);
 	if (err)
 		return libbpf_err(err);
 
 	return bpf_map_lookup_elem_flags(map->fd, key, value, flags);
 }
 
+int bpf_map__lookup_elem_opts(const struct bpf_map *map, const void *key,
+			      size_t key_sz, void *value, size_t value_sz,
+			      const struct bpf_map_lookup_elem_opts *opts)
+{
+	__u64 flags = OPTS_GET(opts, flags, 0);
+	__u32 cpu = OPTS_GET(opts, cpu, 0);
+	int err;
+
+	err = validate_map_op(map, key_sz, value_sz, true, flags, cpu);
+	if (err)
+		return libbpf_err(err);
+
+	return bpf_map_lookup_elem_opts(map->fd, key, value, opts);
+}
+
 int bpf_map__update_elem(const struct bpf_map *map,
 			 const void *key, size_t key_sz,
 			 const void *value, size_t value_sz, __u64 flags)
 {
 	int err;
 
-	err = validate_map_op(map, key_sz, value_sz, true);
+	err = validate_map_op(map, key_sz, value_sz, true, 0, 0);
 	if (err)
 		return libbpf_err(err);
 
 	return bpf_map_update_elem(map->fd, key, value, flags);
 }
 
+int bpf_map__update_elem_opts(const struct bpf_map *map, const void *key,
+			      size_t key_sz, const void *value, size_t value_sz,
+			      const struct bpf_map_update_elem_opts *opts)
+{
+	__u64 flags = OPTS_GET(opts, flags, 0);
+	__u32 cpu = OPTS_GET(opts, cpu, 0);
+	int err;
+
+	err = validate_map_op(map, key_sz, value_sz, true, flags, cpu);
+	if (err)
+		return libbpf_err(err);
+
+	return bpf_map_update_elem_opts(map->fd, key, value, opts);
+}
+
 int bpf_map__delete_elem(const struct bpf_map *map,
 			 const void *key, size_t key_sz, __u64 flags)
 {
 	int err;
 
-	err = validate_map_op(map, key_sz, 0, false /* check_value_sz */);
+	err = validate_map_op(map, key_sz, 0, false /* check_value_sz */, 0, 0);
 	if (err)
 		return libbpf_err(err);
 
@@ -10671,7 +10715,7 @@ int bpf_map__lookup_and_delete_elem(const struct bpf_map *map,
 {
 	int err;
 
-	err = validate_map_op(map, key_sz, value_sz, true);
+	err = validate_map_op(map, key_sz, value_sz, true, 0, 0);
 	if (err)
 		return libbpf_err(err);
 
@@ -10683,7 +10727,7 @@ int bpf_map__get_next_key(const struct bpf_map *map,
 {
 	int err;
 
-	err = validate_map_op(map, key_sz, 0, false /* check_value_sz */);
+	err = validate_map_op(map, key_sz, 0, false /* check_value_sz */, 0, 0);
 	if (err)
 		return libbpf_err(err);
 
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index d1cf813a057b..fd4940759bc9 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -1168,13 +1168,7 @@ LIBBPF_API struct bpf_map *bpf_map__inner_map(struct bpf_map *map);
  * @param key pointer to memory containing bytes of the key used for lookup
  * @param key_sz size in bytes of key data, needs to match BPF map definition's **key_size**
  * @param value pointer to memory in which looked up value will be stored
- * @param value_sz size in byte of value data memory; it has to match BPF map
- * definition's **value_size**. For per-CPU BPF maps value size has to be
- * a product of BPF map value size and number of possible CPUs in the system
- * (could be fetched with **libbpf_num_possible_cpus()**). Note also that for
- * per-CPU values value size has to be aligned up to closest 8 bytes for
- * alignment reasons, so expected size is: `round_up(value_size, 8)
- * * libbpf_num_possible_cpus()`.
+ * @param value_sz refer to **bpf_map__lookup_elem_opts()**'s description.
  * @flags extra flags passed to kernel for this operation
  * @return 0, on success; negative error, otherwise
  *
@@ -1185,6 +1179,32 @@ LIBBPF_API int bpf_map__lookup_elem(const struct bpf_map *map,
 				    const void *key, size_t key_sz,
 				    void *value, size_t value_sz, __u64 flags);
 
+/**
+ * @brief **bpf_map__lookup_elem_opts()** allows to lookup BPF map value
+ * corresponding to provided key with options.
+ * @param map BPF map to lookup element in
+ * @param key pointer to memory containing bytes of the key used for lookup
+ * @param key_sz size in bytes of key data, needs to match BPF map definition's **key_size**
+ * @param value pointer to memory in which looked up value will be stored
+ * @param value_sz size in byte of value data memory; it has to match BPF map
+ * definition's **value_size**. For per-CPU BPF maps value size can be
+ * definition's **value_size** if **BPF_F_CPU** is specified in **opts->flags**,
+ * otherwise a product of BPF map value size and number of possible CPUs in the
+ * system (could be fetched with **libbpf_num_possible_cpus()**). Note else that
+ * for per-CPU values value size has to be aligned up to closest 8 bytes for
+ * alignment reasons, so expected size is: `round_up(value_size, 8)
+ * * libbpf_num_possible_cpus()`.
+ * @opts extra options passed to kernel for this operation
+ * @return 0, on success; negative error, otherwise
+ *
+ * **bpf_map__lookup_elem_opts()** is high-level equivalent of
+ * **bpf_map_lookup_elem_opts()** API with added check for key and value size.
+ */
+LIBBPF_API int bpf_map__lookup_elem_opts(const struct bpf_map *map,
+					 const void *key, size_t key_sz,
+					 void *value, size_t value_sz,
+					 const struct bpf_map_lookup_elem_opts *opts);
+
 /**
  * @brief **bpf_map__update_elem()** allows to insert or update value in BPF
  * map that corresponds to provided key.
@@ -1209,6 +1229,25 @@ LIBBPF_API int bpf_map__update_elem(const struct bpf_map *map,
 				    const void *key, size_t key_sz,
 				    const void *value, size_t value_sz, __u64 flags);
 
+/**
+ * @brief **bpf_map__update_elem_opts()** allows to insert or update value in BPF
+ * map that corresponds to provided key with options.
+ * @param map BPF map to insert to or update element in
+ * @param key pointer to memory containing bytes of the key
+ * @param key_sz size in bytes of key data, needs to match BPF map definition's **key_size**
+ * @param value pointer to memory containing bytes of the value
+ * @param value_sz refer to **bpf_map__lookup_elem_opts()**'s description.
+ * @opts extra options passed to kernel for this operation
+ * @return 0, on success; negative error, otherwise
+ *
+ * **bpf_map__update_elem_opts()** is high-level equivalent of
+ * **bpf_map_update_elem_opts()** API with added check for key and value size.
+ */
+LIBBPF_API int bpf_map__update_elem_opts(const struct bpf_map *map,
+					 const void *key, size_t key_sz,
+					 const void *value, size_t value_sz,
+					 const struct bpf_map_update_elem_opts *opts);
+
 /**
  * @brief **bpf_map__delete_elem()** allows to delete element in BPF map that
  * corresponds to provided key.
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index d7bd463e7017..fa415d9f26ce 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -448,4 +448,9 @@ LIBBPF_1.6.0 {
 } LIBBPF_1.5.0;
 
 LIBBPF_1.7.0 {
+	global:
+		bpf_map__lookup_elem_opts;
+		bpf_map__update_elem_opts;
+		bpf_map_lookup_elem_opts;
+		bpf_map_update_elem_opts;
 } LIBBPF_1.6.0;
diff --git a/tools/lib/bpf/libbpf_common.h b/tools/lib/bpf/libbpf_common.h
index 8fe248e14eb6..84ca89ace1be 100644
--- a/tools/lib/bpf/libbpf_common.h
+++ b/tools/lib/bpf/libbpf_common.h
@@ -89,4 +89,18 @@
 		memcpy(&NAME, &___##NAME, sizeof(NAME));		    \
 	} while (0)
 
+struct bpf_map_update_elem_opts {
+	size_t sz; /* size of this struct for forward/backward compatibility */
+	__u64 flags;
+	__u32 cpu;
+	size_t:0;
+};
+
+struct bpf_map_lookup_elem_opts {
+	size_t sz; /* size of this struct for forward/backward compatibility */
+	__u64 flags;
+	__u32 cpu;
+	size_t:0;
+};
+
 #endif /* __LIBBPF_LIBBPF_COMMON_H */
-- 
2.50.1


