Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 469854606C6
	for <lists+bpf@lfdr.de>; Sun, 28 Nov 2021 15:19:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357824AbhK1OWO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 28 Nov 2021 09:22:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352645AbhK1OUO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 28 Nov 2021 09:20:14 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74C87C061748
        for <bpf@vger.kernel.org>; Sun, 28 Nov 2021 06:16:58 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id v23so10493260pjr.5
        for <bpf@vger.kernel.org>; Sun, 28 Nov 2021 06:16:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=s9pJRJM6ANm+pKHOTB0oBlx4XbDxB9lhCY+/5FwbfuQ=;
        b=ang06S80ucnQF4mE8FoSo3gRACmM3kDDgDkxH7W1ZG8Cy9jC+Qe0ZipGIANOPtzm8j
         zHaIm464XPve6BTRRubY4XxbQilJVUYKU4QGC9TsIa3dV/LIYsgMbeAdK9I6YcIfE6EW
         Vb38RGN+77NvxsDPkGKLAaVUgePIZFyblv/WIlMNORyf7cQprKr8M318MobGJ1dsUQ2n
         os5CMx4Iy3iXYNV52GV1oKPBfJ5OlRXPd1Ci/urwVpMZHiu5iRUxIHRl1Ky16/fIlysy
         YgakLzHW/ZDUJPurKo1YdPf07zr6oUKw06rsSc5xXxiEXul/joRGtnN7JCuxXfq7mycg
         rXtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s9pJRJM6ANm+pKHOTB0oBlx4XbDxB9lhCY+/5FwbfuQ=;
        b=PCXJQeSh6fTm9CTVgNaJy4eeOAL78qMmA9/FlpbN9vjatWvq72hCeQNhUI/hkV0UXJ
         OM/wSMC61G9wuc4SJP9jLFDxGBpr2+vSx7lRK4pP2R3w3ub3ivzkX5tbZ4tROhpkkKP8
         WN4krBa2fT6rYaQPcucfhJ7NPxmU20ycmy6A2b0Fby0U9niV4Hp1ZmrKztkTNhjTm7ub
         GfynmvmcMYvaZqfToAupQkGBsfh16sTpAlBPe/+/cyC8Ssm3jvkjU3xZhH8+ZpMLeCh7
         NoCHkH1f1q/M+R0SKox37XjcKnccHzXJz0/2RcjXw1EZTPY0Uezl3AKeNysNk0w9Er0U
         c80w==
X-Gm-Message-State: AOAM5338G4WLWS+ChoCrvc+INQYf9nWIz7l9QGu7mYaPOSm+OtoRPk2h
        lq7JkACSK3X2Kb+/0r2LB0O6tynzc28=
X-Google-Smtp-Source: ABdhPJxyDPL0oNkkBcShr7lRdxSBs7LR6T4XI/DPS9lhVF7P/5iNYghFZG6A5eQSJ5xcHDMRfeP7JA==
X-Received: by 2002:a17:90b:2309:: with SMTP id mt9mr31136959pjb.213.1638109017646;
        Sun, 28 Nov 2021 06:16:57 -0800 (PST)
Received: from localhost.localdomain ([119.28.83.143])
        by smtp.gmail.com with ESMTPSA id b6sm14513583pfm.170.2021.11.28.06.16.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Nov 2021 06:16:57 -0800 (PST)
From:   Hengqi Chen <hengqi.chen@gmail.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        hengqi.chen@gmail.com
Subject: [PATCH bpf-next v2 1/2] libbpf: Support static initialization of BPF_MAP_TYPE_PROG_ARRAY
Date:   Sun, 28 Nov 2021 22:16:32 +0800
Message-Id: <20211128141633.502339-2-hengqi.chen@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211128141633.502339-1-hengqi.chen@gmail.com>
References: <20211128141633.502339-1-hengqi.chen@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Support static initialization of BPF_MAP_TYPE_PROG_ARRAY with a
syntax similar to map-in-map initialization ([0]):

    SEC("socket")
    int tailcall_1(void *ctx)
    {
        return 0;
    }

    struct {
        __uint(type, BPF_MAP_TYPE_PROG_ARRAY);
        __uint(max_entries, 2);
        __uint(key_size, sizeof(__u32));
        __array(values, int (void *));
    } prog_array_init SEC(".maps") = {
        .values = {
            [1] = (void *)&tailcall_1,
        },
    };

Here's the relevant part of libbpf debug log showing what's
going on with prog-array initialization:

libbpf: sec '.relsocket': collecting relocation for section(3) 'socket'
libbpf: sec '.relsocket': relo #0: insn #2 against 'prog_array_init'
libbpf: prog 'entry': found map 0 (prog_array_init, sec 4, off 0) for insn #0
libbpf: .maps relo #0: for 3 value 0 rel->r_offset 32 name 53 ('tailcall_1')
libbpf: .maps relo #0: map 'prog_array_init' slot [1] points to prog 'tailcall_1'
libbpf: map 'prog_array_init': created successfully, fd=5
libbpf: map 'prog_array_init': slot [1] set to prog 'tailcall_1' fd=6

  [0] Closes: https://github.com/libbpf/libbpf/issues/354

Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
---
 tools/lib/bpf/libbpf.c | 139 ++++++++++++++++++++++++++++++++---------
 1 file changed, 111 insertions(+), 28 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 672671879b21..c7ccc04eabed 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -2277,6 +2277,9 @@ int parse_btf_map_def(const char *map_name, struct btf *btf,
 			map_def->parts |= MAP_DEF_VALUE_SIZE | MAP_DEF_VALUE_TYPE;
 		}
 		else if (strcmp(name, "values") == 0) {
+			bool is_map_in_map = bpf_map_type__is_map_in_map(map_def->map_type);
+			bool is_prog_array = map_def->map_type == BPF_MAP_TYPE_PROG_ARRAY;
+			const char *desc = is_map_in_map ? "map-in-map inner" : "prog-array value";
 			char inner_map_name[128];
 			int err;

@@ -2290,8 +2293,8 @@ int parse_btf_map_def(const char *map_name, struct btf *btf,
 					map_name, name);
 				return -EINVAL;
 			}
-			if (!bpf_map_type__is_map_in_map(map_def->map_type)) {
-				pr_warn("map '%s': should be map-in-map.\n",
+			if (!is_map_in_map && !is_prog_array) {
+				pr_warn("map '%s': should be map-in-map or prog-array.\n",
 					map_name);
 				return -ENOTSUP;
 			}
@@ -2303,22 +2306,30 @@ int parse_btf_map_def(const char *map_name, struct btf *btf,
 			map_def->value_size = 4;
 			t = btf__type_by_id(btf, m->type);
 			if (!t) {
-				pr_warn("map '%s': map-in-map inner type [%d] not found.\n",
-					map_name, m->type);
+				pr_warn("map '%s': %s type [%d] not found.\n",
+					map_name, desc, m->type);
 				return -EINVAL;
 			}
 			if (!btf_is_array(t) || btf_array(t)->nelems) {
-				pr_warn("map '%s': map-in-map inner spec is not a zero-sized array.\n",
-					map_name);
+				pr_warn("map '%s': %s spec is not a zero-sized array.\n",
+					map_name, desc);
 				return -EINVAL;
 			}
 			t = skip_mods_and_typedefs(btf, btf_array(t)->type, NULL);
 			if (!btf_is_ptr(t)) {
-				pr_warn("map '%s': map-in-map inner def is of unexpected kind %s.\n",
-					map_name, btf_kind_str(t));
+				pr_warn("map '%s': %s def is of unexpected kind %s.\n",
+					map_name, desc, btf_kind_str(t));
 				return -EINVAL;
 			}
 			t = skip_mods_and_typedefs(btf, t->type, NULL);
+			if (is_prog_array) {
+				if (!btf_is_func_proto(t)) {
+					pr_warn("map '%s': prog-array value def is of unexpected kind %s.\n",
+						map_name, btf_kind_str(t));
+					return -EINVAL;
+				}
+				continue;
+			}
 			if (!btf_is_struct(t)) {
 				pr_warn("map '%s': map-in-map inner def is of unexpected kind %s.\n",
 					map_name, btf_kind_str(t));
@@ -4940,7 +4951,7 @@ static int bpf_object__create_map(struct bpf_object *obj, struct bpf_map *map, b
 	return err;
 }

-static int init_map_slots(struct bpf_object *obj, struct bpf_map *map)
+static int init_map_in_map_slots(struct bpf_object *obj, struct bpf_map *map)
 {
 	const struct bpf_map *targ_map;
 	unsigned int i;
@@ -4952,6 +4963,7 @@ static int init_map_slots(struct bpf_object *obj, struct bpf_map *map)

 		targ_map = map->init_slots[i];
 		fd = bpf_map__fd(targ_map);
+
 		if (obj->gen_loader) {
 			pr_warn("// TODO map_update_elem: idx %td key %d value==map_idx %td\n",
 				map - obj->maps, i, targ_map - obj->maps);
@@ -4962,8 +4974,7 @@ static int init_map_slots(struct bpf_object *obj, struct bpf_map *map)
 		if (err) {
 			err = -errno;
 			pr_warn("map '%s': failed to initialize slot [%d] to map '%s' fd=%d: %d\n",
-				map->name, i, targ_map->name,
-				fd, err);
+				map->name, i, targ_map->name, fd, err);
 			return err;
 		}
 		pr_debug("map '%s': slot [%d] set to map '%s' fd=%d\n",
@@ -4976,6 +4987,59 @@ static int init_map_slots(struct bpf_object *obj, struct bpf_map *map)
 	return 0;
 }

+static int init_prog_array_slots(struct bpf_object *obj, struct bpf_map *map)
+{
+	const struct bpf_program *targ_prog;
+	unsigned int i;
+	int fd, err;
+
+	if (obj->gen_loader)
+		return -ENOTSUP;
+
+	for (i = 0; i < map->init_slots_sz; i++) {
+		if (!map->init_slots[i])
+			continue;
+
+		targ_prog = map->init_slots[i];
+		fd = bpf_program__fd(targ_prog);
+
+		err = bpf_map_update_elem(map->fd, &i, &fd, 0);
+		if (err) {
+			err = -errno;
+			pr_warn("map '%s': failed to initialize slot [%d] to prog '%s' fd=%d: %d\n",
+				map->name, i, targ_prog->name, fd, err);
+			return err;
+		}
+		pr_debug("map '%s': slot [%d] set to prog '%s' fd=%d\n",
+			 map->name, i, targ_prog->name, fd);
+	}
+
+	zfree(&map->init_slots);
+	map->init_slots_sz = 0;
+
+	return 0;
+}
+
+static int bpf_object_init_prog_arrays(struct bpf_object *obj)
+{
+	struct bpf_map *map;
+	int i, err;
+
+	for (i = 0; i < obj->nr_maps; i++) {
+		map = &obj->maps[i];
+
+		if (!map->init_slots_sz || map->def.type != BPF_MAP_TYPE_PROG_ARRAY)
+			continue;
+
+		err = init_prog_array_slots(obj, map);
+		if (err < 0) {
+			zclose(map->fd);
+			return err;
+		}
+	}
+	return 0;
+}
+
 static int
 bpf_object__create_maps(struct bpf_object *obj)
 {
@@ -5042,8 +5106,8 @@ bpf_object__create_maps(struct bpf_object *obj)
 				}
 			}

-			if (map->init_slots_sz) {
-				err = init_map_slots(obj, map);
+			if (map->init_slots_sz && map->def.type != BPF_MAP_TYPE_PROG_ARRAY) {
+				err = init_map_in_map_slots(obj, map);
 				if (err < 0) {
 					zclose(map->fd);
 					goto err_out;
@@ -6189,9 +6253,11 @@ static int bpf_object__collect_map_relos(struct bpf_object *obj,
 	int i, j, nrels, new_sz;
 	const struct btf_var_secinfo *vi = NULL;
 	const struct btf_type *sec, *var, *def;
-	struct bpf_map *map = NULL, *targ_map;
+	struct bpf_map *map = NULL, *targ_map = NULL;
+	struct bpf_program *targ_prog = NULL;
+	bool is_prog_array, is_map_in_map;
 	const struct btf_member *member;
-	const char *name, *mname;
+	const char *name, *mname, *type;
 	unsigned int moff;
 	Elf64_Sym *sym;
 	Elf64_Rel *rel;
@@ -6218,11 +6284,6 @@ static int bpf_object__collect_map_relos(struct bpf_object *obj,
 			return -LIBBPF_ERRNO__FORMAT;
 		}
 		name = elf_sym_str(obj, sym->st_name) ?: "<?>";
-		if (sym->st_shndx != obj->efile.btf_maps_shndx) {
-			pr_warn(".maps relo #%d: '%s' isn't a BTF-defined map\n",
-				i, name);
-			return -LIBBPF_ERRNO__RELOC;
-		}

 		pr_debug(".maps relo #%d: for %zd value %zd rel->r_offset %zu name %d ('%s')\n",
 			 i, (ssize_t)(rel->r_info >> 32), (size_t)sym->st_value,
@@ -6244,18 +6305,39 @@ static int bpf_object__collect_map_relos(struct bpf_object *obj,
 			return -EINVAL;
 		}

-		if (!bpf_map_type__is_map_in_map(map->def.type))
+		is_map_in_map = bpf_map_type__is_map_in_map(map->def.type);
+		is_prog_array = map->def.type == BPF_MAP_TYPE_PROG_ARRAY;
+		type = is_map_in_map ? "map" : "prog";
+		if (!is_map_in_map && !is_prog_array)
 			return -EINVAL;
+		if (is_map_in_map && sym->st_shndx != obj->efile.btf_maps_shndx) {
+			pr_warn(".maps relo #%d: '%s' isn't a BTF-defined map\n",
+				i, name);
+			return -LIBBPF_ERRNO__RELOC;
+		}
 		if (map->def.type == BPF_MAP_TYPE_HASH_OF_MAPS &&
 		    map->def.key_size != sizeof(int)) {
 			pr_warn(".maps relo #%d: hash-of-maps '%s' should have key size %zu.\n",
 				i, map->name, sizeof(int));
 			return -EINVAL;
 		}
-
-		targ_map = bpf_object__find_map_by_name(obj, name);
-		if (!targ_map)
-			return -ESRCH;
+		if (is_map_in_map) {
+			targ_map = bpf_object__find_map_by_name(obj, name);
+			if (!targ_map)
+				return -ESRCH;
+		}
+		if (is_prog_array) {
+			targ_prog = bpf_object__find_program_by_name(obj, name);
+			if (!targ_prog)
+				return -ESRCH;
+			if (targ_prog->sec_idx != sym->st_shndx ||
+			    targ_prog->sec_insn_off * 8 != sym->st_value ||
+			    prog_is_subprog(obj, targ_prog)) {
+				pr_warn(".maps relo #%d: '%s' isn't an entry-point BPF program\n",
+					i, name);
+				return -LIBBPF_ERRNO__RELOC;
+			}
+		}

 		var = btf__type_by_id(obj->btf, vi->type);
 		def = skip_mods_and_typedefs(obj->btf, var->type, NULL);
@@ -6287,10 +6369,10 @@ static int bpf_object__collect_map_relos(struct bpf_object *obj,
 			       (new_sz - map->init_slots_sz) * host_ptr_sz);
 			map->init_slots_sz = new_sz;
 		}
-		map->init_slots[moff] = targ_map;
+		map->init_slots[moff] = is_map_in_map ? (void *)targ_map : (void *)targ_prog;

-		pr_debug(".maps relo #%d: map '%s' slot [%d] points to map '%s'\n",
-			 i, map->name, moff, name);
+		pr_debug(".maps relo #%d: map '%s' slot [%d] points to %s '%s'\n",
+			 i, map->name, moff, type, name);
 	}

 	return 0;
@@ -7304,6 +7386,7 @@ int bpf_object__load_xattr(struct bpf_object_load_attr *attr)
 	err = err ? : bpf_object__create_maps(obj);
 	err = err ? : bpf_object__relocate(obj, obj->btf_custom_path ? : attr->target_btf_path);
 	err = err ? : bpf_object__load_progs(obj, attr->log_level);
+	err = err ? : bpf_object_init_prog_arrays(obj);

 	if (obj->gen_loader) {
 		/* reset FDs */
--
2.30.2
