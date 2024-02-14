Return-Path: <bpf+bounces-21939-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AB00085415F
	for <lists+bpf@lfdr.de>; Wed, 14 Feb 2024 03:08:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24471B261B8
	for <lists+bpf@lfdr.de>; Wed, 14 Feb 2024 02:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E82968BFA;
	Wed, 14 Feb 2024 02:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LuURInx6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939D546AB
	for <bpf@vger.kernel.org>; Wed, 14 Feb 2024 02:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707876527; cv=none; b=WOyxXlaywFN/uDLkRb7RmX9fLNCo+bwJmAnuHS4Xnkz574s+qDoBXSQas0KZVAKexd70iLtPVj1W79zvWN07wEEK2UW4rj1o0gEG4gZfulpQVkVSOX3WHoxQ9JOZ0NhdJEFBAfsd1vv6rvY6bFBL08jISwSEDbL/tVsdQnL6m2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707876527; c=relaxed/simple;
	bh=x3a5FB5lHt8ZFI599gt9isIizhdFOb6pHHipjU8yaIw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jX/Ju7xDUU7AJM/SXUgNTqcs1Acfw4RfCnxiBOM7ATnnn09IoIFuyVp9WuQi0oOt0Z01kPc3tfnUmMiV2TCCHXXuxkt32UMUqJMzd1UQVa1+uA1KOqKhL3KG65KdP4fC7SpDcBQ8Hn+JvkzlkET7vpLv8SX0Qp7FKcqPiezhRx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LuURInx6; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-dcc6fc978ddso322647276.0
        for <bpf@vger.kernel.org>; Tue, 13 Feb 2024 18:08:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707876524; x=1708481324; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PU1Q9FQBIf28oHG2S/fp5/S8tr3I7bEZh/t4Vw3EHlM=;
        b=LuURInx6TZyyA3Fth2ooN7goglhkjfh7mMAMaZv312h99ryRrqZveglRqbYLuhnHFK
         gMT5tvoZsCOOoDDnGNcs+HXqAE127cEzuKmNl0U5U7dbsddu5W3qDSmtUDmJ3agMUcpA
         AEt6iK4gjiSB50dT0QtZba2ZgWrxDmJLdSGwYuzzLAojWiywWjqkXaI64cwGEZYsgQrI
         P++NmXW5JTdsbDkD0zhIy72zUOS6aA9MgrTMvtCmC23tPLGuaKNtOKbJIVJAEBa8LPOR
         hUo5VssiFZqyyuNySHX02RpxczEi8PZ8ieeD0kS+FteEHqtdEOjZSMQXHa0TWLJ8RABR
         R9/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707876524; x=1708481324;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PU1Q9FQBIf28oHG2S/fp5/S8tr3I7bEZh/t4Vw3EHlM=;
        b=UtnEDfhHkw39QY9hMy8sGzA2NhlOZqNt8gS62TfyqDsJ2qosLX5Mxgr9w+APelkgZc
         WRT7/HzyJO+s9QBPCYiRW/5Rt165MENYndtFN8QAc7ahH79gm8nbZD23sbJIGEh09lsF
         rwazMLqSsHS1ERAFuGmkAvFMDOlWgHOZXhiZgECXuZt7M7Pjk0Si+Q6Ot2Woi85XQ2o1
         rFQ31yCYTPkrZwa5xMUquoWvCKmUae1tCU9qORzk1VDU4dhusSk5+Mxmy4ExJzivXZFK
         djj1OLbSYlZuJrVo219fRp86va8nmxteH+G4RnMWmC8W0VKEnVgG7ZjuILiD+bZ09Pru
         jsLw==
X-Gm-Message-State: AOJu0Yx5DWM1Ka1Da9SSj9jkr3PpMb/3wzMjVDLwUSpAct+9iBf/1JON
	yj6mJRtzVdMxeXZVB12VhubQ5gc+Xax1ywdo9yaA6ieVtTuXfe5B3g4dKtLU
X-Google-Smtp-Source: AGHT+IFApyQx2bV6BmJ/a3/GEPm52YiS0iFncL8D45AP9Eu1S7KQlyh0JGyoM2vBa1K3P3bNONdZfg==
X-Received: by 2002:a25:9f0f:0:b0:dcd:a6ec:7f57 with SMTP id n15-20020a259f0f000000b00dcda6ec7f57mr338303ybq.7.1707876523956;
        Tue, 13 Feb 2024 18:08:43 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWVnGtMZDQ4Tmz2kehbh+yJ4A7yDWKwEAH+CuCYTUrnpFvdlux9Ize5qJu+D4YXRxKuZGq47ynorczJWmZNvo/Eo66Bn+2Wt39wHKa7JHQnV2wqfqKbHoeLtJUgaJJcJEw2yWHubiGUtJ6Lm8e6xCw9gaPHde5g6o2FsWRW6S2GZnl6eSh8z7q7uv7g+KvChO/97qRnICZzSATjOqEAmDwBQLSUxdfk8I8U3vzTDozoilx1mK+gkA==
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:966f:7edc:e6e6:cd97])
        by smtp.gmail.com with ESMTPSA id s17-20020a258311000000b00dc2310abe8bsm1894752ybk.38.2024.02.13.18.08.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 18:08:43 -0800 (PST)
From: thinker.li@gmail.com
To: bpf@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	kernel-team@meta.com,
	andrii@kernel.org
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: [RFC bpf-next v2 1/3] libbpf: Create a shadow copy for each struct_ops map if necessary.
Date: Tue, 13 Feb 2024 18:08:34 -0800
Message-Id: <20240214020836.1845354-2-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240214020836.1845354-1-thinker.li@gmail.com>
References: <20240214020836.1845354-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kui-Feng Lee <thinker.li@gmail.com>

If the user has passed a shadow info for a struct_ops map along with struct
bpf_object_open_opts, a shadow copy will be created for the map and
returned from bpf_map__initial_value().

The user can read and write shadow variables through the shadow copy, which
is placed in the struct pointed by skel->struct_ops.FOO, where FOO is the
map name.

The value of a shadow variable will be used to update the value of the map
when loading the map to the kernel.

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 tools/lib/bpf/libbpf.c          | 195 ++++++++++++++++++++++++++++++--
 tools/lib/bpf/libbpf.h          |  34 +++++-
 tools/lib/bpf/libbpf.map        |   1 +
 tools/lib/bpf/libbpf_internal.h |   1 +
 4 files changed, 220 insertions(+), 11 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 01f407591a92..ce9c4cdb2dc5 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -487,6 +487,14 @@ struct bpf_struct_ops {
 	 * from "data".
 	 */
 	void *kern_vdata;
+	/* Description of the layout that a shadow copy should look like.
+	 */
+	const struct bpf_struct_ops_map_info *shadow_info;
+	/* A shadow copy of the struct_ops data created according to the
+	 * layout described by shadow_info.
+	 */
+	void *shadow_data;
+	__u32 shadow_data_size;
 	__u32 type_id;
 };
 
@@ -1027,7 +1035,7 @@ static int bpf_map__init_kern_struct_ops(struct bpf_map *map)
 	struct module_btf *mod_btf;
 	void *data, *kern_data;
 	const char *tname;
-	int err;
+	int err, j;
 
 	st_ops = map->st_ops;
 	type = st_ops->type;
@@ -1083,9 +1091,18 @@ static int bpf_map__init_kern_struct_ops(struct bpf_map *map)
 		}
 
 		moff = member->offset / 8;
-		kern_moff = kern_member->offset / 8;
-
 		mdata = data + moff;
+		if (st_ops->shadow_data) {
+			for (j = 0; j < st_ops->shadow_info->cnt; j++) {
+				if (strcmp(mname, st_ops->shadow_info->members[j].name))
+					continue;
+				moff = st_ops->shadow_info->members[j].offset;
+				mdata = st_ops->shadow_data + moff;
+				break;
+			}
+		}
+
+		kern_moff = kern_member->offset / 8;
 		kern_mdata = kern_data + kern_moff;
 
 		mtype = skip_mods_and_typedefs(btf, member->type, &mtype_id);
@@ -1102,6 +1119,9 @@ static int bpf_map__init_kern_struct_ops(struct bpf_map *map)
 		if (btf_is_ptr(mtype)) {
 			struct bpf_program *prog;
 
+			if (st_ops->shadow_data)
+				st_ops->progs[i] =
+					*(struct bpf_program **)mdata;
 			prog = st_ops->progs[i];
 			if (!prog)
 				continue;
@@ -1172,8 +1192,108 @@ static int bpf_object__init_kern_struct_ops_maps(struct bpf_object *obj)
 	return 0;
 }
 
+static int init_struct_ops_shadow(struct bpf_map *map,
+				  const struct btf_type *t)
+{
+	struct btf *btf = map->obj->btf;
+	struct bpf_struct_ops *st_ops = map->st_ops;
+	const struct btf_member *m;
+	const struct btf_type *mt;
+	const struct bpf_struct_ops_member_info *info;
+	const char *name;
+	char *data;
+	int i, j, err;
+
+	data = calloc(1, st_ops->shadow_info->data_size);
+	if (!data)
+		return -ENOMEM;
+
+	for (i = 0, m = btf_members(t); i < btf_vlen(t); i++, m++) {
+		name = btf__name_by_offset(btf, m->name_off);
+		if (!name) {
+			pr_warn("struct_ops init_shadow %s: member %d has no name\n",
+				map->name, i);
+			err = -EINVAL;
+			goto err_out;
+		}
+		for (j = 0, info = st_ops->shadow_info->members;
+		     j < st_ops->shadow_info->cnt;
+		     j++, info++) {
+			if (strcmp(name, info->name) == 0)
+				break;
+		}
+		if (j == st_ops->shadow_info->cnt)
+			info = NULL;
+		mt = skip_mods_and_typedefs(btf, m->type, NULL);
+
+		switch (btf_kind(mt)) {
+		case BTF_KIND_INT:
+		case BTF_KIND_FLOAT:
+		case BTF_KIND_ENUM:
+		case BTF_KIND_ENUM64:
+			if (!info) {
+				pr_warn("struct_ops init_shadow %s: member %s not found in map info\n",
+					map->name, name);
+				err = -EINVAL;
+				goto err_out;
+			}
+			if (info->size != mt->size) {
+				pr_warn("struct_ops init_shadow %s: member %s size mismatch: %u != %u\n",
+					map->name, name, info->size, mt->size);
+				err = -EINVAL;
+				goto err_out;
+			}
+			memcpy(data + info->offset, st_ops->data + m->offset / 8, mt->size);
+			break;
+
+		case BTF_KIND_PTR:
+			if (!resolve_func_ptr(btf, m->type, NULL)) {
+				if (!info)
+					break;
+				pr_warn("struct_ops init_shadow %s: member %s is not a func ptr\n",
+					map->name, name);
+				err = -ENOTSUP;
+				goto err_out;
+			}
+			if (!info) {
+				pr_warn("struct_ops init_shadow %s: member %s not found in map info\n",
+					map->name, name);
+				err = -EINVAL;
+				goto err_out;
+			}
+			if (info->size != sizeof(void *)) {
+				pr_warn("struct_ops init_shadow %s: member %s size mismatch: %u != %lu\n",
+					map->name, name, info->size, sizeof(void *));
+				err = -EINVAL;
+				goto err_out;
+			}
+			*((struct bpf_program **)(data + info->offset)) =
+				st_ops->progs[i];
+			break;
+
+		default:
+			if (info) {
+				pr_warn("struct_ops init_shadow %s: member %s not supported type\n",
+					map->name, name);
+				err = -ENOTSUP;
+				goto err_out;
+			}
+			break;
+		}
+	}
+
+	st_ops->shadow_data = data;
+
+	return 0;
+
+err_out:
+	free(data);
+	return err;
+}
+
 static int init_struct_ops_maps(struct bpf_object *obj, const char *sec_name,
-				int shndx, Elf_Data *data, __u32 map_flags)
+				int shndx, Elf_Data *data, __u32 map_flags,
+				const struct bpf_struct_ops_shadow_info *shadow)
 {
 	const struct btf_type *type, *datasec;
 	const struct btf_var_secinfo *vsi;
@@ -1182,7 +1302,7 @@ static int init_struct_ops_maps(struct bpf_object *obj, const char *sec_name,
 	__s32 type_id, datasec_id;
 	const struct btf *btf;
 	struct bpf_map *map;
-	__u32 i;
+	__u32 i, j;
 
 	if (shndx == -1)
 		return 0;
@@ -1260,6 +1380,16 @@ static int init_struct_ops_maps(struct bpf_object *obj, const char *sec_name,
 		st_ops->type = type;
 		st_ops->type_id = type_id;
 
+		if (shadow) {
+			for (j = 0; j < shadow->cnt; j++) {
+				if (strcmp(shadow->maps[j].name, var_name))
+					continue;
+				st_ops->shadow_info = &shadow->maps[j];
+				break;
+			}
+
+		}
+
 		pr_debug("struct_ops init: struct %s(type_id=%u) %s found at offset %u\n",
 			 tname, type_id, var_name, vsi->offset);
 	}
@@ -1267,16 +1397,19 @@ static int init_struct_ops_maps(struct bpf_object *obj, const char *sec_name,
 	return 0;
 }
 
-static int bpf_object_init_struct_ops(struct bpf_object *obj)
+static int bpf_object_init_struct_ops(struct bpf_object *obj,
+				      const struct bpf_struct_ops_shadow_info *shadow)
 {
 	int err;
 
 	err = init_struct_ops_maps(obj, STRUCT_OPS_SEC, obj->efile.st_ops_shndx,
-				   obj->efile.st_ops_data, 0);
+				   obj->efile.st_ops_data, 0, shadow);
 	err = err ?: init_struct_ops_maps(obj, STRUCT_OPS_LINK_SEC,
 					  obj->efile.st_ops_link_shndx,
 					  obj->efile.st_ops_link_data,
-					  BPF_F_LINK);
+					  BPF_F_LINK,
+					  shadow);
+
 	return err;
 }
 
@@ -2145,7 +2278,7 @@ skip_mods_and_typedefs(const struct btf *btf, __u32 id, __u32 *res_id)
 	return t;
 }
 
-static const struct btf_type *
+const struct btf_type *
 resolve_func_ptr(const struct btf *btf, __u32 id, __u32 *res_id)
 {
 	const struct btf_type *t;
@@ -2736,17 +2869,19 @@ static int bpf_object__init_user_btf_maps(struct bpf_object *obj, bool strict,
 static int bpf_object__init_maps(struct bpf_object *obj,
 				 const struct bpf_object_open_opts *opts)
 {
+	const struct bpf_struct_ops_shadow_info *shadow_info;
 	const char *pin_root_path;
 	bool strict;
 	int err = 0;
 
 	strict = !OPTS_GET(opts, relaxed_maps, false);
 	pin_root_path = OPTS_GET(opts, pin_root_path, NULL);
+	shadow_info = OPTS_GET(opts, struct_ops_shadow, NULL);
 
 	err = bpf_object__init_user_btf_maps(obj, strict, pin_root_path);
 	err = err ?: bpf_object__init_global_data_maps(obj);
 	err = err ?: bpf_object__init_kconfig_map(obj);
-	err = err ?: bpf_object_init_struct_ops(obj);
+	err = err ?: bpf_object_init_struct_ops(obj, shadow_info);
 
 	return err;
 }
@@ -7528,6 +7663,33 @@ static int bpf_object_init_progs(struct bpf_object *obj, const struct bpf_object
 	return 0;
 }
 
+/* Create a shadow copy for each struct_ops map if it has shadow info.
+ *
+ * The shadow copy should be created after bpf_object__collect_relos()
+ * since st_ops->progs is initialized in that function.
+ */
+static int bpf_object__init_shadow(struct bpf_object *obj)
+{
+	struct bpf_map *map;
+	int err;
+
+	bpf_object__for_each_map(map, obj) {
+		if (!bpf_map__is_struct_ops(map))
+			continue;
+
+		if (!map->st_ops->shadow_info)
+			continue;
+		err = init_struct_ops_shadow(map, map->st_ops->type);
+		if (err) {
+			pr_warn("map '%s': failed to init shadow: %d\n",
+				map->name, err);
+			return err;
+		}
+	}
+
+	return 0;
+}
+
 static struct bpf_object *bpf_object_open(const char *path, const void *obj_buf, size_t obj_buf_sz,
 					  const struct bpf_object_open_opts *opts)
 {
@@ -7624,6 +7786,7 @@ static struct bpf_object *bpf_object_open(const char *path, const void *obj_buf,
 	err = err ? : bpf_object__init_maps(obj, opts);
 	err = err ? : bpf_object_init_progs(obj, opts);
 	err = err ? : bpf_object__collect_relos(obj);
+	err = err ? : bpf_object__init_shadow(obj);
 	if (err)
 		goto out;
 
@@ -8588,6 +8751,7 @@ static void bpf_map__destroy(struct bpf_map *map)
 	}
 
 	if (map->st_ops) {
+		zfree(&map->st_ops->shadow_data);
 		zfree(&map->st_ops->data);
 		zfree(&map->st_ops->progs);
 		zfree(&map->st_ops->kern_func_off);
@@ -9877,6 +10041,12 @@ int bpf_map__set_initial_value(struct bpf_map *map,
 
 void *bpf_map__initial_value(struct bpf_map *map, size_t *psize)
 {
+	if (bpf_map__is_struct_ops(map)) {
+		if (psize)
+			*psize = map->st_ops->shadow_data_size;
+		return map->st_ops->shadow_data;
+	}
+
 	if (!map->mmaped)
 		return NULL;
 	*psize = map->def.value_size;
@@ -13462,3 +13632,8 @@ void bpf_object__destroy_skeleton(struct bpf_object_skeleton *s)
 	free(s->progs);
 	free(s);
 }
+
+__u32 bpf_map__struct_ops_type(const struct bpf_map *map)
+{
+	return map->st_ops->type_id;
+}
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 5723cbbfcc41..b435cafefe7a 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -109,6 +109,27 @@ LIBBPF_API libbpf_print_fn_t libbpf_set_print(libbpf_print_fn_t fn);
 /* Hide internal to user */
 struct bpf_object;
 
+/* Description of a member in the struct_ops type for a map. */
+struct bpf_struct_ops_member_info {
+	const char *name;
+	__u32 offset;
+	__u32 size;
+};
+
+/* Description of the layout of a shadow copy for a struct_ops map. */
+struct bpf_struct_ops_map_info {
+	/* The name of the struct_ops map */
+	const char *name;
+	const struct bpf_struct_ops_member_info *members;
+	__u32 cnt;
+	__u32 data_size;
+};
+
+struct bpf_struct_ops_shadow_info {
+	const struct bpf_struct_ops_map_info *maps;
+	__u32 cnt;
+};
+
 struct bpf_object_open_opts {
 	/* size of this struct, for forward/backward compatibility */
 	size_t sz;
@@ -197,9 +218,18 @@ struct bpf_object_open_opts {
 	 */
 	const char *bpf_token_path;
 
+	/* A list of shadow info for every struct_ops map.  A shadow info
+	 * provides the information used by libbpf to map the offsets of
+	 * struct members of a struct_ops type from BTF to the offsets of
+	 * the corresponding members in the shadow copy in the user
+	 * space. It ensures that the shadow copy provided by the libbpf
+	 * can be accessed by the user space program correctly.
+	 */
+	const struct bpf_struct_ops_shadow_info *struct_ops_shadow;
+
 	size_t :0;
 };
-#define bpf_object_open_opts__last_field bpf_token_path
+#define bpf_object_open_opts__last_field struct_ops_shadow
 
 /**
  * @brief **bpf_object__open()** creates a bpf_object by opening
@@ -839,6 +869,8 @@ struct bpf_map;
 LIBBPF_API struct bpf_link *bpf_map__attach_struct_ops(const struct bpf_map *map);
 LIBBPF_API int bpf_link__update_map(struct bpf_link *link, const struct bpf_map *map);
 
+LIBBPF_API __u32 bpf_map__struct_ops_type(const struct bpf_map *map);
+
 struct bpf_iter_attach_opts {
 	size_t sz; /* size of this struct for forward/backward compatibility */
 	union bpf_iter_link_info *link_info;
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 86804fd90dd1..e0efc85114df 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -413,4 +413,5 @@ LIBBPF_1.4.0 {
 		bpf_token_create;
 		btf__new_split;
 		btf_ext__raw_data;
+		bpf_map__struct_ops_type;
 } LIBBPF_1.3.0;
diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
index ad936ac5e639..aec6d57fe5d1 100644
--- a/tools/lib/bpf/libbpf_internal.h
+++ b/tools/lib/bpf/libbpf_internal.h
@@ -234,6 +234,7 @@ struct btf_type;
 struct btf_type *btf_type_by_id(const struct btf *btf, __u32 type_id);
 const char *btf_kind_str(const struct btf_type *t);
 const struct btf_type *skip_mods_and_typedefs(const struct btf *btf, __u32 id, __u32 *res_id);
+const struct btf_type *resolve_func_ptr(const struct btf *btf, __u32 id, __u32 *res_id);
 
 static inline enum btf_func_linkage btf_func_linkage(const struct btf_type *t)
 {
-- 
2.34.1


