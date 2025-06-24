Return-Path: <bpf+bounces-61409-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C10FBAE6D02
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 18:55:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B5F71BC5D1D
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 16:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E65182E339C;
	Tue, 24 Jun 2025 16:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vpeFvT2+"
X-Original-To: bpf@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D152E6115
	for <bpf@vger.kernel.org>; Tue, 24 Jun 2025 16:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750784100; cv=none; b=QhGpm3/PXK4k44wgHe5wJ1gS5sxJP9o303jHRUZfIr3dv6e6A9gLAPyAuj1smCAGsD0QWlsF74unCuCAw+rFK/ZQN0sfxWoilJGFhr+JsEQVuSICReh7cQ/H62RxSL+SkG7/UiP2ZnoBDuoMWV/H0oyXOd/SGwV9eQznMkEY0XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750784100; c=relaxed/simple;
	bh=67+JKhuWMQoa4LPOfg+OP3ZR+hx9CmccnRW77P4Ifw4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V5EQ/QVxVr/akD5GsQeTebe66jZcQhrlIastiHKl/fEzmxnLGI6m/NtuEvMJN4FOjGYmj5mp0w8f+KyP+M5gPmUR5SJO5X9SCUMFvK434ZSNoonaxc7xP6Dsnw1Ez2+jRO4a2AAFASCMM7Bk3IU70In4MQlFgR0V5bd3E/pbjbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vpeFvT2+; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1750784096;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=64Q17lpvEQAJr7tlVcbJIoOaiioAqRJYZzKRqXD9LzQ=;
	b=vpeFvT2+c/7RkOpq4O/z78SISsBxWZ3fdjOJZEdaQFOIG2mZVN2qXai00pAFX7a38KAuzT
	/Pi+TPgSMUZ+kwZjQTHRaxyfcef2otrJLIagCVt2vjjLlzNLUQygvoWRo9Qo8fs0RpJ4BD
	y4KNb8gsf8UTAuJnA1jxiBdpJsArPkA=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	Leon Hwang <leon.hwang@linux.dev>
Subject: [RFC PATCH bpf-next 2/3] bpf, libbpf: Support BPF_F_CPU for percpu_array map
Date: Wed, 25 Jun 2025 00:53:53 +0800
Message-ID: <20250624165354.27184-3-leon.hwang@linux.dev>
In-Reply-To: <20250624165354.27184-1-leon.hwang@linux.dev>
References: <20250624165354.27184-1-leon.hwang@linux.dev>
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

* If opts->cpu == 0xFFFFFFFF, the update is applied to all CPUs.
* Otherwise, it applies only to the specified CPU.
* Lookup APIs retrieve values from the target CPU when BPF_F_CPU is used.

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 tools/lib/bpf/bpf.c           | 37 +++++++++++++++++++++++
 tools/lib/bpf/bpf.h           | 35 +++++++++++++++++++++-
 tools/lib/bpf/libbpf.c        | 56 +++++++++++++++++++++++++++++++++++
 tools/lib/bpf/libbpf.h        | 45 ++++++++++++++++++++++++++++
 tools/lib/bpf/libbpf.map      |  4 +++
 tools/lib/bpf/libbpf_common.h | 12 ++++++++
 6 files changed, 188 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index 6eb421ccf91b..80f7ea041187 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -402,6 +402,24 @@ int bpf_map_update_elem(int fd, const void *key, const void *value,
 	return libbpf_err_errno(ret);
 }
 
+int bpf_map_update_elem_opts(int fd, const void *key, const void *value,
+			     const struct bpf_map_update_elem_opts *opts)
+{
+	const size_t attr_sz = offsetofend(union bpf_attr, cpu);
+	union bpf_attr attr;
+	int ret;
+
+	memset(&attr, 0, attr_sz);
+	attr.map_fd = fd;
+	attr.key = ptr_to_u64(key);
+	attr.value = ptr_to_u64(value);
+	attr.flags = OPTS_GET(opts, flags, 0);
+	attr.cpu = OPTS_GET(opts, cpu, BPF_ALL_CPU);
+
+	ret = sys_bpf(BPF_MAP_UPDATE_ELEM, &attr, attr_sz);
+	return libbpf_err_errno(ret);
+}
+
 int bpf_map_lookup_elem(int fd, const void *key, void *value)
 {
 	const size_t attr_sz = offsetofend(union bpf_attr, flags);
@@ -433,6 +451,24 @@ int bpf_map_lookup_elem_flags(int fd, const void *key, void *value, __u64 flags)
 	return libbpf_err_errno(ret);
 }
 
+int bpf_map_lookup_elem_opts(int fd, const void *key, void *value,
+			     const struct bpf_map_lookup_elem_opts *opts)
+{
+	const size_t attr_sz = offsetofend(union bpf_attr, cpu);
+	union bpf_attr attr;
+	int ret;
+
+	memset(&attr, 0, attr_sz);
+	attr.map_fd = fd;
+	attr.key = ptr_to_u64(key);
+	attr.value = ptr_to_u64(value);
+	attr.flags = OPTS_GET(opts, flags, 0);
+	attr.cpu = OPTS_GET(opts, cpu, BPF_ALL_CPU);
+
+	ret = sys_bpf(BPF_MAP_LOOKUP_ELEM, &attr, attr_sz);
+	return libbpf_err_errno(ret);
+}
+
 int bpf_map_lookup_and_delete_elem(int fd, const void *key, void *value)
 {
 	const size_t attr_sz = offsetofend(union bpf_attr, flags);
@@ -542,6 +578,7 @@ static int bpf_map_batch_common(int cmd, int fd, void  *in_batch,
 	attr.batch.count = *count;
 	attr.batch.elem_flags  = OPTS_GET(opts, elem_flags, 0);
 	attr.batch.flags = OPTS_GET(opts, flags, 0);
+	attr.batch.cpu = OPTS_GET(opts, cpu, BPF_ALL_CPU);
 
 	ret = sys_bpf(cmd, &attr, attr_sz);
 	*count = attr.batch.count;
diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index 1342564214c8..7c6a0a3693c9 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -163,12 +163,41 @@ LIBBPF_API int bpf_map_delete_elem_flags(int fd, const void *key, __u64 flags);
 LIBBPF_API int bpf_map_get_next_key(int fd, const void *key, void *next_key);
 LIBBPF_API int bpf_map_freeze(int fd);
 
+/**
+ * @brief **bpf_map_update_elem_opts** allows for updating percpu map with value
+ * on specified CPU or on all CPUs.
+ *
+ * @param fd BPF map file descriptor
+ * @param key pointer to key
+ * @param value pointer to value
+ * @param opts options for configuring the way to update percpu map
+ * @return 0, on success; negative error code, otherwise (errno is also set to
+ * the error code)
+ */
+LIBBPF_API int bpf_map_update_elem_opts(int fd, const void *key, const void *value,
+					const struct bpf_map_update_elem_opts *opts);
+
+/**
+ * @brief **bpf_map_lookup_elem_opts** allows for looking up the value from
+ * percpu map on specified CPU.
+ *
+ * @param fd BPF map file descriptor
+ * @param key pointer to key
+ * @param value pointer to value
+ * @param opts options for configuring the way to lookup percpu map
+ * @return 0, on success; negative error code, otherwise (errno is also set to
+ * the error code)
+ */
+LIBBPF_API int bpf_map_lookup_elem_opts(int fd, const void *key, void *value,
+					const struct bpf_map_lookup_elem_opts *opts);
+
 struct bpf_map_batch_opts {
 	size_t sz; /* size of this struct for forward/backward compatibility */
 	__u64 elem_flags;
 	__u64 flags;
+	__u32 cpu;
 };
-#define bpf_map_batch_opts__last_field flags
+#define bpf_map_batch_opts__last_field cpu
 
 
 /**
@@ -286,6 +315,10 @@ LIBBPF_API int bpf_map_lookup_and_delete_batch(int fd, void *in_batch,
  *    Update spin_lock-ed map elements. This must be
  *    specified if the map value contains a spinlock.
  *
+ * **BPF_F_CPU**
+ *    As for percpu map, update value on all CPUs if **opts->cpu** is
+ *    0xFFFFFFFF, or on specified CPU otherwise.
+ *
  * @param fd BPF map file descriptor
  * @param keys pointer to an array of *count* keys
  * @param values pointer to an array of *count* values
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 6445165a24f2..30400bdc20d9 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -10636,6 +10636,34 @@ int bpf_map__lookup_elem(const struct bpf_map *map,
 	return bpf_map_lookup_elem_flags(map->fd, key, value, flags);
 }
 
+int bpf_map__lookup_elem_opts(const struct bpf_map *map, const void *key,
+			      size_t key_sz, void *value, size_t value_sz,
+			      const struct bpf_map_lookup_elem_opts *opts)
+{
+	int nr_cpus = libbpf_num_possible_cpus();
+	__u32 cpu = OPTS_GET(opts, cpu, nr_cpus);
+	__u64 flags = OPTS_GET(opts, flags, 0);
+	int err;
+
+	if (flags & BPF_F_CPU) {
+		if (map->def.type != BPF_MAP_TYPE_PERCPU_ARRAY)
+			return -EINVAL;
+		if (cpu >= nr_cpus)
+			return -E2BIG;
+		if (map->def.value_size != value_sz) {
+			pr_warn("map '%s': unexpected value size %zu provided, expected %u\n",
+				map->name, value_sz, map->def.value_size);
+			return -EINVAL;
+		}
+	} else {
+		err = validate_map_op(map, key_sz, value_sz, true);
+		if (err)
+			return libbpf_err(err);
+	}
+
+	return bpf_map_lookup_elem_opts(map->fd, key, value, opts);
+}
+
 int bpf_map__update_elem(const struct bpf_map *map,
 			 const void *key, size_t key_sz,
 			 const void *value, size_t value_sz, __u64 flags)
@@ -10649,6 +10677,34 @@ int bpf_map__update_elem(const struct bpf_map *map,
 	return bpf_map_update_elem(map->fd, key, value, flags);
 }
 
+int bpf_map__update_elem_opts(const struct bpf_map *map, const void *key,
+			      size_t key_sz, const void *value, size_t value_sz,
+			      const struct bpf_map_update_elem_opts *opts)
+{
+	int nr_cpus = libbpf_num_possible_cpus();
+	__u32 cpu = OPTS_GET(opts, cpu, nr_cpus);
+	__u64 flags = OPTS_GET(opts, flags, 0);
+	int err;
+
+	if (flags & BPF_F_CPU) {
+		if (map->def.type != BPF_MAP_TYPE_PERCPU_ARRAY)
+			return -EINVAL;
+		if (cpu != BPF_ALL_CPU && cpu >= nr_cpus)
+			return -E2BIG;
+		if (map->def.value_size != value_sz) {
+			pr_warn("map '%s': unexpected value size %zu provided, expected %u\n",
+				map->name, value_sz, map->def.value_size);
+			return -EINVAL;
+		}
+	} else {
+		err = validate_map_op(map, key_sz, value_sz, true);
+		if (err)
+			return libbpf_err(err);
+	}
+
+	return bpf_map_update_elem_opts(map->fd, key, value, opts);
+}
+
 int bpf_map__delete_elem(const struct bpf_map *map,
 			 const void *key, size_t key_sz, __u64 flags)
 {
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index d1cf813a057b..ba0d15028c72 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -1185,6 +1185,28 @@ LIBBPF_API int bpf_map__lookup_elem(const struct bpf_map *map,
 				    const void *key, size_t key_sz,
 				    void *value, size_t value_sz, __u64 flags);
 
+/**
+ * @brief **bpf_map__lookup_elem_opts()** allows to lookup BPF map value
+ * corresponding to provided key with options to lookup percpu map.
+ * @param map BPF map to lookup element in
+ * @param key pointer to memory containing bytes of the key used for lookup
+ * @param key_sz size in bytes of key data, needs to match BPF map definition's **key_size**
+ * @param value pointer to memory in which looked up value will be stored
+ * @param value_sz size in byte of value data memory; it has to match BPF map
+ * definition's **value_size**. For per-CPU BPF maps value size can be
+ * definition's **value_size** if **BPF_F_CPU** is specified in **opts->flags**,
+ * or the size described in **bpf_map__lookup_elem()**.
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
@@ -1209,6 +1231,29 @@ LIBBPF_API int bpf_map__update_elem(const struct bpf_map *map,
 				    const void *key, size_t key_sz,
 				    const void *value, size_t value_sz, __u64 flags);
 
+/**
+ * @brief **bpf_map__update_elem_opts()** allows to insert or update value in BPF
+ * map that corresponds to provided key with options for percpu maps.
+ * @param map BPF map to insert to or update element in
+ * @param key pointer to memory containing bytes of the key
+ * @param key_sz size in bytes of key data, needs to match BPF map definition's **key_size**
+ * @param value pointer to memory containing bytes of the value
+ * @param value_sz size in byte of value data memory; it has to match BPF map
+ * definition's **value_size**. For per-CPU BPF maps value size can be
+ * definition's **value_size** if **BPF_F_CPU** is specified in **opts->flags**,
+ * or the size described in **bpf_map__update_elem()**.
+ * @opts extra options passed to kernel for this operation
+ * @flags extra flags passed to kernel for this operation
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
index c7fc0bde5648..c39814adeae9 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -436,6 +436,10 @@ LIBBPF_1.6.0 {
 		bpf_linker__add_buf;
 		bpf_linker__add_fd;
 		bpf_linker__new_fd;
+		bpf_map__lookup_elem_opts;
+		bpf_map__update_elem_opts;
+		bpf_map_lookup_elem_opts;
+		bpf_map_update_elem_opts;
 		bpf_object__prepare;
 		bpf_program__attach_cgroup_opts;
 		bpf_program__func_info;
diff --git a/tools/lib/bpf/libbpf_common.h b/tools/lib/bpf/libbpf_common.h
index 8fe248e14eb6..ef29caf91f9c 100644
--- a/tools/lib/bpf/libbpf_common.h
+++ b/tools/lib/bpf/libbpf_common.h
@@ -89,4 +89,16 @@
 		memcpy(&NAME, &___##NAME, sizeof(NAME));		    \
 	} while (0)
 
+struct bpf_map_update_elem_opts {
+	size_t sz; /* size of this struct for forward/backward compatibility */
+	__u64 flags;
+	__u32 cpu;
+};
+
+struct bpf_map_lookup_elem_opts {
+	size_t sz; /* size of this struct for forward/backward compatibility */
+	__u64 flags;
+	__u32 cpu;
+};
+
 #endif /* __LIBBPF_LIBBPF_COMMON_H */
-- 
2.49.0


