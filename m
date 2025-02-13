Return-Path: <bpf+bounces-51437-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B52C9A349F6
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2025 17:35:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32BC718974EC
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2025 16:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECBC8269836;
	Thu, 13 Feb 2025 16:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gH5aGYew"
X-Original-To: bpf@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D37207A11
	for <bpf@vger.kernel.org>; Thu, 13 Feb 2025 16:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739463598; cv=none; b=Al67zpJ3rR52zY4PPAO4ryr5lGKs8MYe6pp93Y/439BwgghbTRrnPdG0e4Yncxp3S/AlwYdwTXPgwabnQBMOr+307eEKUUZ+r18LyOXj4h4HDLpGM459RIYi0XEuFbtwWL11e3iDv/2HM5q95P8BNRby7hKfw6tl95rRQ+dow9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739463598; c=relaxed/simple;
	bh=i9z9RMv8Q9buSbnf49Uqc5uhLfdSXowW0XNpU7i9oNE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WL2/st/B4K6Ns6Xv81oBBmgk+G7MeQz4tf9mPcTIdJfu9MNnQVap+fmL4Cz68MRHYbk3siBfKIj9mMCm/k2R8hgT11NwZlv6P9iCjHWSZPNy3sCX5gLkuRVx3jLpgIExqjOAjNzo2Wtn/D2/BgQ3z66YdgnPn3dKi0rAnPzWI7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gH5aGYew; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1739463594;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wc3MAELuMEmKY240wMm4HQiFlWQZ6nhI0WjTYPYKk7A=;
	b=gH5aGYew6TeuvO4NUsgBl522K9WaNo8K6/k6xrW8q8NV/7tl8SkcjodssrHTw/9zk5qctw
	BItOsJ1Q36VknN/Zsp/LwW+t7Vo59KoDEQDH8QeAvrCTLSXfX/k7Lk6bNMVr2RCj7f6LUt
	XmNnZ9wefAWrHIZy/K6Ezre0F7N4a2A=
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
Subject: [RESEND PATCH bpf-next v2 2/4] bpf, libbpf: Support global percpu data
Date: Fri, 14 Feb 2025 00:19:29 +0800
Message-ID: <20250213161931.46399-3-leon.hwang@linux.dev>
In-Reply-To: <20250213161931.46399-1-leon.hwang@linux.dev>
References: <20250213161931.46399-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This patch introduces support for global percpu data in libbpf by adding a
new ".percpu" section, similar to ".data". It enables efficient handling of
percpu global variables in bpf programs.

Key changes:

* Introduces the ".percpu" section in libbpf.
* Correct value size to __aligned(8) of ".percpu" map definition and btf.
* Creates internal maps for percpu data.
* Initializes and populates these maps accordingly.

This enhancement improves performance for workloads that benefit from
percpu storage.

Meanwhile, add bpf_map__is_internal_percpu() API to check whether the map
is an internal map used for global percpu variables.

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 tools/lib/bpf/libbpf.c   | 101 +++++++++++++++++++++++++++++++--------
 tools/lib/bpf/libbpf.h   |   9 ++++
 tools/lib/bpf/libbpf.map |   1 +
 3 files changed, 90 insertions(+), 21 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 194809da51725..736a902a667e9 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -516,6 +516,7 @@ struct bpf_struct_ops {
 };
 
 #define DATA_SEC ".data"
+#define PERCPU_SEC ".percpu"
 #define BSS_SEC ".bss"
 #define RODATA_SEC ".rodata"
 #define KCONFIG_SEC ".kconfig"
@@ -530,6 +531,7 @@ enum libbpf_map_type {
 	LIBBPF_MAP_BSS,
 	LIBBPF_MAP_RODATA,
 	LIBBPF_MAP_KCONFIG,
+	LIBBPF_MAP_PERCPU,
 };
 
 struct bpf_map_def {
@@ -640,6 +642,7 @@ enum sec_type {
 	SEC_DATA,
 	SEC_RODATA,
 	SEC_ST_OPS,
+	SEC_PERCPU,
 };
 
 struct elf_sec_desc {
@@ -1903,7 +1906,7 @@ static bool map_is_mmapable(struct bpf_object *obj, struct bpf_map *map)
 	struct btf_var_secinfo *vsi;
 	int i, n;
 
-	if (!map->btf_value_type_id)
+	if (!map->btf_value_type_id || map->libbpf_type == LIBBPF_MAP_PERCPU)
 		return false;
 
 	t = btf__type_by_id(obj->btf, map->btf_value_type_id);
@@ -1927,6 +1930,7 @@ static int
 bpf_object__init_internal_map(struct bpf_object *obj, enum libbpf_map_type type,
 			      const char *real_name, int sec_idx, void *data, size_t data_sz)
 {
+	bool is_percpu = type == LIBBPF_MAP_PERCPU;
 	struct bpf_map_def *def;
 	struct bpf_map *map;
 	size_t mmap_sz;
@@ -1948,9 +1952,9 @@ bpf_object__init_internal_map(struct bpf_object *obj, enum libbpf_map_type type,
 	}
 
 	def = &map->def;
-	def->type = BPF_MAP_TYPE_ARRAY;
+	def->type = is_percpu ? BPF_MAP_TYPE_PERCPU_ARRAY : BPF_MAP_TYPE_ARRAY;
 	def->key_size = sizeof(int);
-	def->value_size = data_sz;
+	def->value_size = is_percpu ? roundup(data_sz, 8) : data_sz;
 	def->max_entries = 1;
 	def->map_flags = type == LIBBPF_MAP_RODATA || type == LIBBPF_MAP_KCONFIG
 		? BPF_F_RDONLY_PROG : 0;
@@ -1961,10 +1965,11 @@ bpf_object__init_internal_map(struct bpf_object *obj, enum libbpf_map_type type,
 	if (map_is_mmapable(obj, map))
 		def->map_flags |= BPF_F_MMAPABLE;
 
-	pr_debug("map '%s' (global data): at sec_idx %d, offset %zu, flags %x.\n",
-		 map->name, map->sec_idx, map->sec_offset, def->map_flags);
+	pr_debug("map '%s' (global %sdata): at sec_idx %d, offset %zu, flags %x.\n",
+		 map->name, is_percpu ? "percpu " : "", map->sec_idx,
+		 map->sec_offset, def->map_flags);
 
-	mmap_sz = bpf_map_mmap_sz(map);
+	mmap_sz = is_percpu ? def->value_size : bpf_map_mmap_sz(map);
 	map->mmaped = mmap(NULL, mmap_sz, PROT_READ | PROT_WRITE,
 			   MAP_SHARED | MAP_ANONYMOUS, -1, 0);
 	if (map->mmaped == MAP_FAILED) {
@@ -2015,6 +2020,13 @@ static int bpf_object__init_global_data_maps(struct bpf_object *obj)
 							    sec_desc->data->d_buf,
 							    sec_desc->data->d_size);
 			break;
+		case SEC_PERCPU:
+			sec_name = elf_sec_name(obj, elf_sec_by_idx(obj, sec_idx));
+			err = bpf_object__init_internal_map(obj, LIBBPF_MAP_PERCPU,
+							    sec_name, sec_idx,
+							    sec_desc->data->d_buf,
+							    sec_desc->data->d_size);
+			break;
 		case SEC_BSS:
 			sec_name = elf_sec_name(obj, elf_sec_by_idx(obj, sec_idx));
 			err = bpf_object__init_internal_map(obj, LIBBPF_MAP_BSS,
@@ -3364,6 +3376,10 @@ static int btf_fixup_datasec(struct bpf_object *obj, struct btf *btf,
 		fixup_offsets = true;
 	}
 
+	/* .percpu DATASEC must has __aligned(8) size. */
+	if (strcmp(sec_name, PERCPU_SEC) == 0 || str_has_pfx(sec_name, PERCPU_SEC))
+		t->size = roundup(t->size, 8);
+
 	for (i = 0, vsi = btf_var_secinfos(t); i < vars; i++, vsi++) {
 		const struct btf_type *t_var;
 		struct btf_var *var;
@@ -3934,6 +3950,11 @@ static int bpf_object__elf_collect(struct bpf_object *obj)
 				sec_desc->sec_type = SEC_RODATA;
 				sec_desc->shdr = sh;
 				sec_desc->data = data;
+			} else if (strcmp(name, PERCPU_SEC) == 0 ||
+				   str_has_pfx(name, PERCPU_SEC)) {
+				sec_desc->sec_type = SEC_PERCPU;
+				sec_desc->shdr = sh;
+				sec_desc->data = data;
 			} else if (strcmp(name, STRUCT_OPS_SEC) == 0 ||
 				   strcmp(name, STRUCT_OPS_LINK_SEC) == 0 ||
 				   strcmp(name, "?" STRUCT_OPS_SEC) == 0 ||
@@ -4453,6 +4474,7 @@ static bool bpf_object__shndx_is_data(const struct bpf_object *obj,
 	case SEC_BSS:
 	case SEC_DATA:
 	case SEC_RODATA:
+	case SEC_PERCPU:
 		return true;
 	default:
 		return false;
@@ -4478,6 +4500,8 @@ bpf_object__section_to_libbpf_map_type(const struct bpf_object *obj, int shndx)
 		return LIBBPF_MAP_DATA;
 	case SEC_RODATA:
 		return LIBBPF_MAP_RODATA;
+	case SEC_PERCPU:
+		return LIBBPF_MAP_PERCPU;
 	default:
 		return LIBBPF_MAP_UNSPEC;
 	}
@@ -4795,7 +4819,7 @@ static int map_fill_btf_type_info(struct bpf_object *obj, struct bpf_map *map)
 
 	/*
 	 * LLVM annotates global data differently in BTF, that is,
-	 * only as '.data', '.bss' or '.rodata'.
+	 * only as '.data', '.bss', '.percpu' or '.rodata'.
 	 */
 	if (!bpf_map__is_internal(map))
 		return -ENOENT;
@@ -5125,23 +5149,47 @@ static int
 bpf_object__populate_internal_map(struct bpf_object *obj, struct bpf_map *map)
 {
 	enum libbpf_map_type map_type = map->libbpf_type;
-	int err, zero = 0;
-	size_t mmap_sz;
+	bool is_percpu = map_type == LIBBPF_MAP_PERCPU;
+	int err = 0, zero = 0, num_cpus, i;
+	size_t data_sz, elem_sz, mmap_sz;
+	void *data = NULL;
+
+	data_sz = map->def.value_size;
+	if (is_percpu) {
+		num_cpus = libbpf_num_possible_cpus();
+		if (num_cpus < 0) {
+			err = num_cpus;
+			return err;
+		}
+
+		data_sz = data_sz * num_cpus;
+		data = malloc(data_sz);
+		if (!data) {
+			err = -ENOMEM;
+			return err;
+		}
+
+		elem_sz = map->def.value_size;
+		for (i = 0; i < num_cpus; i++)
+			memcpy(data + i * elem_sz, map->mmaped, elem_sz);
+	} else {
+		data = map->mmaped;
+	}
 
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
@@ -5151,7 +5199,7 @@ bpf_object__populate_internal_map(struct bpf_object *obj, struct bpf_map *map)
 			err = -errno;
 			pr_warn("map '%s': failed to freeze as read-only: %s\n",
 				bpf_map__name(map), errstr(err));
-			return err;
+			goto free_data;
 		}
 	}
 
@@ -5178,7 +5226,7 @@ bpf_object__populate_internal_map(struct bpf_object *obj, struct bpf_map *map)
 			err = -errno;
 			pr_warn("map '%s': failed to re-mmap() contents: %s\n",
 				bpf_map__name(map), errstr(err));
-			return err;
+			goto free_data;
 		}
 		map->mmaped = mmaped;
 	} else if (map->mmaped) {
@@ -5186,7 +5234,10 @@ bpf_object__populate_internal_map(struct bpf_object *obj, struct bpf_map *map)
 		map->mmaped = NULL;
 	}
 
-	return 0;
+free_data:
+	if (is_percpu)
+		free(data);
+	return err;
 }
 
 static void bpf_map__destroy(struct bpf_map *map);
@@ -10132,14 +10183,17 @@ int bpf_map__fd(const struct bpf_map *map)
 
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
+	if (map->libbpf_type == LIBBPF_MAP_PERCPU && strcmp(map->real_name, PERCPU_SEC) != 0)
+		return true;
 	if (map->libbpf_type == LIBBPF_MAP_RODATA && strcmp(map->real_name, RODATA_SEC) != 0)
 		return true;
 	return false;
@@ -10386,6 +10440,11 @@ bool bpf_map__is_internal(const struct bpf_map *map)
 	return map->libbpf_type != LIBBPF_MAP_UNSPEC;
 }
 
+bool bpf_map__is_internal_percpu(const struct bpf_map *map)
+{
+	return map->libbpf_type == LIBBPF_MAP_PERCPU;
+}
+
 __u32 bpf_map__ifindex(const struct bpf_map *map)
 {
 	return map->map_ifindex;
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 3020ee45303a0..1d8ca33d370d1 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -1072,6 +1072,15 @@ LIBBPF_API void *bpf_map__initial_value(const struct bpf_map *map, size_t *psize
  */
 LIBBPF_API bool bpf_map__is_internal(const struct bpf_map *map);
 
+/**
+ * @brief **bpf_map__is_internal_percpu()** tells the caller whether or not
+ * the passed map is an internal map used for global percpu variables.
+ * @param map the bpf_map
+ * @return true, if the map is an internal map used for global percpu
+ * variables; false, otherwise
+ */
+LIBBPF_API bool bpf_map__is_internal_percpu(const struct bpf_map *map);
+
 /**
  * @brief **bpf_map__set_pin_path()** sets the path attribute that tells where the
  * BPF map should be pinned. This does not actually create the 'pin'.
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index b5a838de6f47c..09cdbd6e32218 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -438,4 +438,5 @@ LIBBPF_1.6.0 {
 		bpf_linker__new_fd;
 		btf__add_decl_attr;
 		btf__add_type_attr;
+		bpf_map__is_internal_percpu;
 } LIBBPF_1.5.0;
-- 
2.47.1


