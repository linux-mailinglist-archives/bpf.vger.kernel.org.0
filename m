Return-Path: <bpf+bounces-49869-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48A62A1DA6E
	for <lists+bpf@lfdr.de>; Mon, 27 Jan 2025 17:22:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59C667A509C
	for <lists+bpf@lfdr.de>; Mon, 27 Jan 2025 16:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D98214E2E8;
	Mon, 27 Jan 2025 16:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IVOwsksS"
X-Original-To: bpf@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103C513633F
	for <bpf@vger.kernel.org>; Mon, 27 Jan 2025 16:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737994963; cv=none; b=tPCuzXFN/KSYNIqROjplDLqd1xtIKOppIKDq26BQLa79ODYsOhCaxfQ4lT/Jmd9LUQyFb6NYZiHfwMLCpp6KIWBZYRrlAOML++lJleqYZqyJHjQsVNuGm/HATjpdgqzT26s2g6+ogyOF9RJdKzUrFKyHFwUPmRvLaqptaCNmuLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737994963; c=relaxed/simple;
	bh=i8q4pp3vYJftdaixIrFKiNGEucKRjoM1RYEoTXF643Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qNQ4PuwvDDvUoH8aHyuMQ1CHVFzDbn4/YxajPMVd83mNi0foa80+2Xb9ExEdd2VvCCubpxbB0kw2QS7X2LNPVYbLmMDyxViUhczr38TdDt4PG2e5iNOJ6dqAFwqArj7NRks+U56OZnNftQEw8T+li9SgvTb3N9ixH4/BXpvk+94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IVOwsksS; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1737994959;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AYx9gYzzX0cf0KN5Ej/iK3YYsmPfm49EYmVrld1ACsU=;
	b=IVOwsksS4FtXSN06W9zynt0OhmDqIwNZh6EK1ytv1v9gsk9h5JO2ltr368ymTHvPAKhlvm
	DE8l4FYkizFyXOCzgTuA6YPTXmUSNRAF1XyC+BbA2VgXeST+4h3ByIVPzNP9y1YlrN41LA
	oTzIC0eemxOZWKZHLtpcMzIAFKLVguk=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	yonghong.song@linux.dev,
	song@kernel.org,
	eddyz87@gmail.com,
	qmo@kernel.org,
	dxu@dxuuu.xyz,
	leon.hwang@linux.dev,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf-next 2/4] bpf, libbpf: Support global percpu data
Date: Tue, 28 Jan 2025 00:21:56 +0800
Message-ID: <20250127162158.84906-3-leon.hwang@linux.dev>
In-Reply-To: <20250127162158.84906-1-leon.hwang@linux.dev>
References: <20250127162158.84906-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This patch introduces support for global percpu data in libbpf. A new
section named ".percpu" is added, similar to the existing ".data" section.
Internal maps are created for ".percpu" sections, which are then
initialized and populated accordingly.

The changes include:

* Introduction of the ".percpu" section in libbpf.
* Creation of internal maps for percpu data.
* Initialization and population of these maps.

This enhancement allows BPF programs to efficiently manage and access
percpu global data, improving performance for use cases that require
percpu buffer.

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 tools/lib/bpf/libbpf.c | 172 ++++++++++++++++++++++++++++++++---------
 1 file changed, 135 insertions(+), 37 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 194809da51725..6da6004c5c84d 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -516,6 +516,7 @@ struct bpf_struct_ops {
 };
 
 #define DATA_SEC ".data"
+#define PERCPU_DATA_SEC ".percpu"
 #define BSS_SEC ".bss"
 #define RODATA_SEC ".rodata"
 #define KCONFIG_SEC ".kconfig"
@@ -530,6 +531,7 @@ enum libbpf_map_type {
 	LIBBPF_MAP_BSS,
 	LIBBPF_MAP_RODATA,
 	LIBBPF_MAP_KCONFIG,
+	LIBBPF_MAP_PERCPU_DATA,
 };
 
 struct bpf_map_def {
@@ -562,6 +564,7 @@ struct bpf_map {
 	__u32 btf_value_type_id;
 	__u32 btf_vmlinux_value_type_id;
 	enum libbpf_map_type libbpf_type;
+	void *data;
 	void *mmaped;
 	struct bpf_struct_ops *st_ops;
 	struct bpf_map *inner_map;
@@ -640,6 +643,7 @@ enum sec_type {
 	SEC_DATA,
 	SEC_RODATA,
 	SEC_ST_OPS,
+	SEC_PERCPU_DATA,
 };
 
 struct elf_sec_desc {
@@ -1923,13 +1927,24 @@ static bool map_is_mmapable(struct bpf_object *obj, struct bpf_map *map)
 	return false;
 }
 
+static void map_copy_data(struct bpf_map *map, const void *data)
+{
+	bool is_percpu_data = map->libbpf_type == LIBBPF_MAP_PERCPU_DATA;
+	size_t data_sz = map->def.value_size;
+
+	if (data)
+		memcpy(is_percpu_data ? map->data : map->mmaped, data, data_sz);
+}
+
 static int
 bpf_object__init_internal_map(struct bpf_object *obj, enum libbpf_map_type type,
 			      const char *real_name, int sec_idx, void *data, size_t data_sz)
 {
+	bool is_percpu_data = type == LIBBPF_MAP_PERCPU_DATA;
 	struct bpf_map_def *def;
 	struct bpf_map *map;
 	size_t mmap_sz;
+	size_t elem_sz;
 	int err;
 
 	map = bpf_object__add_map(obj);
@@ -1948,7 +1963,8 @@ bpf_object__init_internal_map(struct bpf_object *obj, enum libbpf_map_type type,
 	}
 
 	def = &map->def;
-	def->type = BPF_MAP_TYPE_ARRAY;
+	def->type = is_percpu_data ? BPF_MAP_TYPE_PERCPU_ARRAY
+				   : BPF_MAP_TYPE_ARRAY;
 	def->key_size = sizeof(int);
 	def->value_size = data_sz;
 	def->max_entries = 1;
@@ -1958,29 +1974,53 @@ bpf_object__init_internal_map(struct bpf_object *obj, enum libbpf_map_type type,
 	/* failures are fine because of maps like .rodata.str1.1 */
 	(void) map_fill_btf_type_info(obj, map);
 
-	if (map_is_mmapable(obj, map))
-		def->map_flags |= BPF_F_MMAPABLE;
+	pr_debug("map '%s' (global %sdata): at sec_idx %d, offset %zu, flags %x.\n",
+		 map->name, is_percpu_data ? "percpu " : "", map->sec_idx,
+		 map->sec_offset, def->map_flags);
 
-	pr_debug("map '%s' (global data): at sec_idx %d, offset %zu, flags %x.\n",
-		 map->name, map->sec_idx, map->sec_offset, def->map_flags);
+	if (is_percpu_data) {
+		elem_sz = roundup(data_sz, 8);
 
-	mmap_sz = bpf_map_mmap_sz(map);
-	map->mmaped = mmap(NULL, mmap_sz, PROT_READ | PROT_WRITE,
-			   MAP_SHARED | MAP_ANONYMOUS, -1, 0);
-	if (map->mmaped == MAP_FAILED) {
-		err = -errno;
-		map->mmaped = NULL;
-		pr_warn("failed to alloc map '%s' content buffer: %s\n", map->name, errstr(err));
-		zfree(&map->real_name);
-		zfree(&map->name);
-		return err;
-	}
+		map->data = malloc(elem_sz);
+		if (!map->data) {
+			err = -ENOMEM;
+			pr_warn("map '%s': failed to alloc content buffer: %s\n",
+				map->name, errstr(err));
+			goto free_name;
+		}
 
-	if (data)
-		memcpy(map->mmaped, data, data_sz);
+		if (data) {
+			memcpy(map->data, data, data_sz);
+			if (data_sz != elem_sz)
+				memset(map->data + data_sz, 0, elem_sz - data_sz);
+		} else {
+			memset(map->data, 0, elem_sz);
+		}
+	} else {
+		if (map_is_mmapable(obj, map))
+			def->map_flags |= BPF_F_MMAPABLE;
+
+		mmap_sz = bpf_map_mmap_sz(map);
+		map->mmaped = mmap(NULL, mmap_sz, PROT_READ | PROT_WRITE,
+				   MAP_SHARED | MAP_ANONYMOUS, -1, 0);
+		if (map->mmaped == MAP_FAILED) {
+			err = -errno;
+			map->mmaped = NULL;
+			pr_warn("map '%s': failed to alloc content buffer: %s\n",
+				map->name, errstr(err));
+			goto free_name;
+		}
+
+		map_copy_data(map, data);
+	}
 
 	pr_debug("map %td is \"%s\"\n", map - obj->maps, map->name);
 	return 0;
+
+free_name:
+	zfree(&map->real_name);
+	zfree(&map->name);
+	return err;
 }
 
 static int bpf_object__init_global_data_maps(struct bpf_object *obj)
@@ -2015,6 +2055,13 @@ static int bpf_object__init_global_data_maps(struct bpf_object *obj)
 							    sec_desc->data->d_buf,
 							    sec_desc->data->d_size);
 			break;
+		case SEC_PERCPU_DATA:
+			sec_name = elf_sec_name(obj, elf_sec_by_idx(obj, sec_idx));
+			err = bpf_object__init_internal_map(obj, LIBBPF_MAP_PERCPU_DATA,
+							    sec_name, sec_idx,
+							    sec_desc->data->d_buf,
+							    sec_desc->data->d_size);
+			break;
 		case SEC_BSS:
 			sec_name = elf_sec_name(obj, elf_sec_by_idx(obj, sec_idx));
 			err = bpf_object__init_internal_map(obj, LIBBPF_MAP_BSS,
@@ -3934,6 +3981,11 @@ static int bpf_object__elf_collect(struct bpf_object *obj)
 				sec_desc->sec_type = SEC_RODATA;
 				sec_desc->shdr = sh;
 				sec_desc->data = data;
+			} else if (strcmp(name, PERCPU_DATA_SEC) == 0 ||
+				   str_has_pfx(name, PERCPU_DATA_SEC)) {
+				sec_desc->sec_type = SEC_PERCPU_DATA;
+				sec_desc->shdr = sh;
+				sec_desc->data = data;
 			} else if (strcmp(name, STRUCT_OPS_SEC) == 0 ||
 				   strcmp(name, STRUCT_OPS_LINK_SEC) == 0 ||
 				   strcmp(name, "?" STRUCT_OPS_SEC) == 0 ||
@@ -4453,6 +4505,7 @@ static bool bpf_object__shndx_is_data(const struct bpf_object *obj,
 	case SEC_BSS:
 	case SEC_DATA:
 	case SEC_RODATA:
+	case SEC_PERCPU_DATA:
 		return true;
 	default:
 		return false;
@@ -4478,6 +4531,8 @@ bpf_object__section_to_libbpf_map_type(const struct bpf_object *obj, int shndx)
 		return LIBBPF_MAP_DATA;
 	case SEC_RODATA:
 		return LIBBPF_MAP_RODATA;
+	case SEC_PERCPU_DATA:
+		return LIBBPF_MAP_PERCPU_DATA;
 	default:
 		return LIBBPF_MAP_UNSPEC;
 	}
@@ -4795,7 +4850,7 @@ static int map_fill_btf_type_info(struct bpf_object *obj, struct bpf_map *map)
 
 	/*
 	 * LLVM annotates global data differently in BTF, that is,
-	 * only as '.data', '.bss' or '.rodata'.
+	 * only as '.data', '.bss', '.percpu' or '.rodata'.
 	 */
 	if (!bpf_map__is_internal(map))
 		return -ENOENT;
@@ -5125,23 +5180,54 @@ static int
 bpf_object__populate_internal_map(struct bpf_object *obj, struct bpf_map *map)
 {
 	enum libbpf_map_type map_type = map->libbpf_type;
-	int err, zero = 0;
+	bool is_percpu_data = map_type == LIBBPF_MAP_PERCPU_DATA;
+	int err = 0, zero = 0;
+	void *data = NULL;
+	int num_cpus, i;
+	size_t data_sz;
+	size_t elem_sz;
 	size_t mmap_sz;
 
+	data_sz = map->def.value_size;
+	if (is_percpu_data) {
+		num_cpus = libbpf_num_possible_cpus();
+		if (num_cpus < 0) {
+			err = libbpf_err_errno(num_cpus);
+			pr_warn("map '%s': failed to get num_cpus: %s\n",
+				bpf_map__name(map), errstr(err));
+			return err;
+		}
+
+		elem_sz = roundup(data_sz, 8);
+		data_sz = elem_sz * num_cpus;
+		data = malloc(data_sz);
+		if (!data) {
+			err = -ENOMEM;
+			pr_warn("map '%s': failed to malloc memory: %s\n",
+				bpf_map__name(map), errstr(err));
+			return err;
+		}
+
+		for (i = 0; i < num_cpus; i++)
+			memcpy(data + i * elem_sz, map->data, elem_sz);
+	} else {
+		data = map->mmaped;
+	}
+
 	if (obj->gen_loader) {
 		bpf_gen__map_update_elem(obj->gen_loader, map - obj->maps,
-					 map->mmaped, map->def.value_size);
+					 data, data_sz);
 		if (map_type == LIBBPF_MAP_RODATA || map_type == LIBBPF_MAP_KCONFIG)
 			bpf_gen__map_freeze(obj->gen_loader, map - obj->maps);
-		return 0;
+		goto free_data;
 	}
 
-	err = bpf_map_update_elem(map->fd, &zero, map->mmaped, 0);
+	err = bpf_map_update_elem(map->fd, &zero, data, 0);
 	if (err) {
 		err = -errno;
 		pr_warn("map '%s': failed to set initial contents: %s\n",
 			bpf_map__name(map), errstr(err));
-		return err;
+		goto free_data;
 	}
 
 	/* Freeze .rodata and .kconfig map as read-only from syscall side. */
@@ -5151,7 +5237,7 @@ bpf_object__populate_internal_map(struct bpf_object *obj, struct bpf_map *map)
 			err = -errno;
 			pr_warn("map '%s': failed to freeze as read-only: %s\n",
 				bpf_map__name(map), errstr(err));
-			return err;
+			goto free_data;
 		}
 	}
 
@@ -5178,7 +5264,7 @@ bpf_object__populate_internal_map(struct bpf_object *obj, struct bpf_map *map)
 			err = -errno;
 			pr_warn("map '%s': failed to re-mmap() contents: %s\n",
 				bpf_map__name(map), errstr(err));
-			return err;
+			goto free_data;
 		}
 		map->mmaped = mmaped;
 	} else if (map->mmaped) {
@@ -5186,7 +5272,10 @@ bpf_object__populate_internal_map(struct bpf_object *obj, struct bpf_map *map)
 		map->mmaped = NULL;
 	}
 
-	return 0;
+free_data:
+	if (is_percpu_data)
+		free(data);
+	return err;
 }
 
 static void bpf_map__destroy(struct bpf_map *map);
@@ -8120,7 +8209,9 @@ static int bpf_object__sanitize_maps(struct bpf_object *obj)
 	struct bpf_map *m;
 
 	bpf_object__for_each_map(m, obj) {
-		if (!bpf_map__is_internal(m))
+		if (!bpf_map__is_internal(m) ||
+		    /* percpu data map is internal and not-mmapable. */
+		    m->libbpf_type == LIBBPF_MAP_PERCPU_DATA)
 			continue;
 		if (!kernel_supports(obj, FEAT_ARRAY_MMAP))
 			m->def.map_flags &= ~BPF_F_MMAPABLE;
@@ -9041,6 +9132,8 @@ static void bpf_map__destroy(struct bpf_map *map)
 	if (map->mmaped && map->mmaped != map->obj->arena_data)
 		munmap(map->mmaped, bpf_map_mmap_sz(map));
 	map->mmaped = NULL;
+	if (map->data)
+		zfree(&map->data);
 
 	if (map->st_ops) {
 		zfree(&map->st_ops->data);
@@ -10132,14 +10225,18 @@ int bpf_map__fd(const struct bpf_map *map)
 
 static bool map_uses_real_name(const struct bpf_map *map)
 {
-	/* Since libbpf started to support custom .data.* and .rodata.* maps,
-	 * their user-visible name differs from kernel-visible name. Users see
-	 * such map's corresponding ELF section name as a map name.
-	 * This check distinguishes .data/.rodata from .data.* and .rodata.*
-	 * maps to know which name has to be returned to the user.
+	/* Since libbpf started to support custom .data.*, .percpu.* and
+	 * .rodata.* maps, their user-visible name differs from kernel-visible
+	 * name. Users see such map's corresponding ELF section name as a map
+	 * name. This check distinguishes .data/.percpu/.rodata from .data.*,
+	 * .percpu.* and .rodata.* maps to know which name has to be returned to
+	 * the user.
 	 */
 	if (map->libbpf_type == LIBBPF_MAP_DATA && strcmp(map->real_name, DATA_SEC) != 0)
 		return true;
+	if (map->libbpf_type == LIBBPF_MAP_PERCPU_DATA &&
+	    strcmp(map->real_name, PERCPU_DATA_SEC) != 0)
+		return true;
 	if (map->libbpf_type == LIBBPF_MAP_RODATA && strcmp(map->real_name, RODATA_SEC) != 0)
 		return true;
 	return false;
@@ -10348,7 +10445,8 @@ int bpf_map__set_initial_value(struct bpf_map *map,
 	if (map->obj->loaded || map->reused)
 		return libbpf_err(-EBUSY);
 
-	if (!map->mmaped || map->libbpf_type == LIBBPF_MAP_KCONFIG)
+	if ((!map->mmaped && !map->data) ||
+	    map->libbpf_type == LIBBPF_MAP_KCONFIG)
 		return libbpf_err(-EINVAL);
 
 	if (map->def.type == BPF_MAP_TYPE_ARENA)
@@ -10358,7 +10456,7 @@ int bpf_map__set_initial_value(struct bpf_map *map,
 	if (size != actual_sz)
 		return libbpf_err(-EINVAL);
 
-	memcpy(map->mmaped, data, size);
+	map_copy_data(map, data);
 	return 0;
 }
 
@@ -10370,7 +10468,7 @@ void *bpf_map__initial_value(const struct bpf_map *map, size_t *psize)
 		return map->st_ops->data;
 	}
 
-	if (!map->mmaped)
+	if (!map->mmaped && !map->data)
 		return NULL;
 
 	if (map->def.type == BPF_MAP_TYPE_ARENA)
@@ -10378,7 +10476,7 @@ void *bpf_map__initial_value(const struct bpf_map *map, size_t *psize)
 	else
 		*psize = map->def.value_size;
 
-	return map->mmaped;
+	return map->libbpf_type == LIBBPF_MAP_PERCPU_DATA ? map->data : map->mmaped;
 }
 
 bool bpf_map__is_internal(const struct bpf_map *map)
-- 
2.47.1


