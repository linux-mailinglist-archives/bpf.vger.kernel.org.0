Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 191E44583EC
	for <lists+bpf@lfdr.de>; Sun, 21 Nov 2021 14:55:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238259AbhKUN6O (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 21 Nov 2021 08:58:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238260AbhKUN6O (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 21 Nov 2021 08:58:14 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 438E3C061574
        for <bpf@vger.kernel.org>; Sun, 21 Nov 2021 05:55:09 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id y14-20020a17090a2b4e00b001a5824f4918so14691739pjc.4
        for <bpf@vger.kernel.org>; Sun, 21 Nov 2021 05:55:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HhSozF3Am2vtDGV1yscMHOGPsku6GRC3FB3GHO2tmCc=;
        b=fqp/PoLXO/7kHDt0BlOsQ73F2qrr0FwA7p+vsx7jK2nT6b7xOSXUzjHY1veOVNO74V
         MtN35Qe8ILq06AC94RhKY7hnTVhejHLcqeHnmUvETFiD+2uxICTeJwA/Cd78tApetgmQ
         J8dXaNmdhcl8pYtIQR4LdxPztWAxYVyI0+aCGLZ9AexsZX8PeW5oOoXZxJ0/txwJtt5k
         waR3GzGi6rjVrIPwE0QnZ3bmI1hDAQGJl29vvoHpCl5YF8ttOJ0W7baRRAUU7TFyYbTn
         SsHDOoeAsJBoWGcdyrW0tJzuxj4qDrb4nXC2iXVgarxewFF2Ju+q1UyeKdWaNQvRcg3D
         l0Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HhSozF3Am2vtDGV1yscMHOGPsku6GRC3FB3GHO2tmCc=;
        b=BrMMCLWPyKuP1hDoI1LJwhd9HiZ0pVPS6V8wzdsVwYvirMbPNqq681zGLI9xM1F63X
         7QjfwfLbN0QA7uU89DZPT0BBr9QdmnI9mzNwpjeoVR1tirmvaI+Jp9SLGdWEosCT4kSK
         r76zSWIggkK65Mf0QkNqRkRjOPzEKqS9me57nKuD1VJZGVa+YYsJ4gVZbwXIyHxAIuwf
         TVcVQao2UzW2zs9qduny4bp0/BvwNnTv+fMHPamIOatNHQh0UDdo1kNFFmAOie4XsWHy
         hEHAe0nTeK/rxa47GJJg2bvjbI5vO7wxg6MSZdrSkaLN6YJ5l8bZkjvHYO1eoxVlAXwy
         KWjA==
X-Gm-Message-State: AOAM530mbJPMn/QPzwX0zN/wsgoNayiUxK+QhRC83rCuXgB3S6PlyP/H
        tKqpKTe2eaI5C1EuHW5mh1AeEs1Wils=
X-Google-Smtp-Source: ABdhPJxC5dCGxMtrHrZViP0SO6TOgQqLxmfV6jDrBzrg2AJT8V6MsvsOauipeIk0xXtqpVNzJw/FTA==
X-Received: by 2002:a17:902:d4c2:b0:142:2039:e8e5 with SMTP id o2-20020a170902d4c200b001422039e8e5mr98271156plg.18.1637502908494;
        Sun, 21 Nov 2021 05:55:08 -0800 (PST)
Received: from localhost.localdomain ([119.28.83.143])
        by smtp.gmail.com with ESMTPSA id u38sm6061073pfg.0.2021.11.21.05.55.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Nov 2021 05:55:08 -0800 (PST)
From:   Hengqi Chen <hengqi.chen@gmail.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        hengqi.chen@gmail.com
Subject: [PATCH bpf-next 1/2] libbpf: Support static initialization of BPF_MAP_TYPE_PROG_ARRAY
Date:   Sun, 21 Nov 2021 21:54:39 +0800
Message-Id: <20211121135440.3205482-2-hengqi.chen@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211121135440.3205482-1-hengqi.chen@gmail.com>
References: <20211121135440.3205482-1-hengqi.chen@gmail.com>
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
 tools/lib/bpf/libbpf.c | 146 ++++++++++++++++++++++++++++++++++-------
 1 file changed, 122 insertions(+), 24 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index af405c38aadc..6b4a175d717d 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -2277,6 +2277,8 @@ int parse_btf_map_def(const char *map_name, struct btf *btf,
 			map_def->parts |= MAP_DEF_VALUE_SIZE | MAP_DEF_VALUE_TYPE;
 		}
 		else if (strcmp(name, "values") == 0) {
+			bool is_map_in_map = bpf_map_type__is_map_in_map(map_def->map_type);
+			bool is_prog_array = map_def->map_type == BPF_MAP_TYPE_PROG_ARRAY;
 			char inner_map_name[128];
 			int err;

@@ -2290,8 +2292,8 @@ int parse_btf_map_def(const char *map_name, struct btf *btf,
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
@@ -2303,23 +2305,42 @@ int parse_btf_map_def(const char *map_name, struct btf *btf,
 			map_def->value_size = 4;
 			t = btf__type_by_id(btf, m->type);
 			if (!t) {
-				pr_warn("map '%s': map-in-map inner type [%d] not found.\n",
-					map_name, m->type);
+				if (is_map_in_map)
+					pr_warn("map '%s': map-in-map inner type [%d] not found.\n",
+						map_name, m->type);
+				else
+					pr_warn("map '%s': prog-array value type [%d] not found.\n",
+						map_name, m->type);
 				return -EINVAL;
 			}
 			if (!btf_is_array(t) || btf_array(t)->nelems) {
-				pr_warn("map '%s': map-in-map inner spec is not a zero-sized array.\n",
-					map_name);
+				if (is_map_in_map)
+					pr_warn("map '%s': map-in-map inner spec is not a zero-sized array.\n",
+						map_name);
+				else
+					pr_warn("map '%s': prog-array value spec is not a zero-sized array.\n",
+						map_name);
 				return -EINVAL;
 			}
 			t = skip_mods_and_typedefs(btf, btf_array(t)->type, NULL);
 			if (!btf_is_ptr(t)) {
-				pr_warn("map '%s': map-in-map inner def is of unexpected kind %s.\n",
-					map_name, btf_kind_str(t));
+				if (is_map_in_map)
+					pr_warn("map '%s': map-in-map inner def is of unexpected kind %s.\n",
+						map_name, btf_kind_str(t));
+				else
+					pr_warn("map '%s': prog-array value def is of unexpected kind %s.\n",
+						map_name, btf_kind_str(t));
 				return -EINVAL;
 			}
 			t = skip_mods_and_typedefs(btf, t->type, NULL);
-			if (!btf_is_struct(t)) {
+			if (is_prog_array) {
+				if (btf_is_func_proto(t))
+					return 0;
+				pr_warn("map '%s': prog-array value def is of unexpected kind %s.\n",
+						map_name, btf_kind_str(t));
+				return -EINVAL;
+			}
+			if (is_map_in_map && !btf_is_struct(t)) {
 				pr_warn("map '%s': map-in-map inner def is of unexpected kind %s.\n",
 					map_name, btf_kind_str(t));
 				return -EINVAL;
@@ -4964,12 +4985,16 @@ static int init_map_slots(struct bpf_object *obj, struct bpf_map *map)
 	unsigned int i;
 	int fd, err = 0;

+	if (map->def.type == BPF_MAP_TYPE_PROG_ARRAY)
+		return 0;
+
 	for (i = 0; i < map->init_slots_sz; i++) {
 		if (!map->init_slots[i])
 			continue;

 		targ_map = map->init_slots[i];
 		fd = bpf_map__fd(targ_map);
+
 		if (obj->gen_loader) {
 			pr_warn("// TODO map_update_elem: idx %td key %d value==map_idx %td\n",
 				map - obj->maps, i, targ_map - obj->maps);
@@ -4980,8 +5005,7 @@ static int init_map_slots(struct bpf_object *obj, struct bpf_map *map)
 		if (err) {
 			err = -errno;
 			pr_warn("map '%s': failed to initialize slot [%d] to map '%s' fd=%d: %d\n",
-				map->name, i, targ_map->name,
-				fd, err);
+				map->name, i, targ_map->name, fd, err);
 			return err;
 		}
 		pr_debug("map '%s': slot [%d] set to map '%s' fd=%d\n",
@@ -4994,6 +5018,60 @@ static int init_map_slots(struct bpf_object *obj, struct bpf_map *map)
 	return 0;
 }

+static int init_prog_array(struct bpf_object *obj, struct bpf_map *map)
+{
+	const struct bpf_program *targ_prog;
+	unsigned int i;
+	int fd, err = 0;
+
+	for (i = 0; i < map->init_slots_sz; i++) {
+		if (!map->init_slots[i])
+			continue;
+
+		targ_prog = map->init_slots[i];
+		fd = bpf_program__fd(targ_prog);
+
+		if (obj->gen_loader) {
+			return -ENOTSUP;
+		} else {
+			err = bpf_map_update_elem(map->fd, &i, &fd, 0);
+		}
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
+static int bpf_object_init_prog_array(struct bpf_object *obj)
+{
+	struct bpf_map *map;
+	int i, err;
+
+	for (i = 0; i < obj->nr_maps; i++) {
+		map = &obj->maps[i];
+
+		if (map->def.type == BPF_MAP_TYPE_PROG_ARRAY &&
+		    map->init_slots_sz) {
+			err = init_prog_array(obj, map);
+			if (err < 0) {
+				zclose(map->fd);
+				return err;
+			}
+		}
+	}
+	return 0;
+}
+
 static int
 bpf_object__create_maps(struct bpf_object *obj)
 {
@@ -6174,7 +6252,9 @@ static int bpf_object__collect_map_relos(struct bpf_object *obj,
 	int i, j, nrels, new_sz;
 	const struct btf_var_secinfo *vi = NULL;
 	const struct btf_type *sec, *var, *def;
-	struct bpf_map *map = NULL, *targ_map;
+	struct bpf_map *map = NULL, *targ_map = NULL;
+	struct bpf_program *targ_prog = NULL;
+	bool is_prog_array, is_map_in_map;
 	const struct btf_member *member;
 	const char *name, *mname;
 	unsigned int moff;
@@ -6203,11 +6283,6 @@ static int bpf_object__collect_map_relos(struct bpf_object *obj,
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
@@ -6229,8 +6304,20 @@ static int bpf_object__collect_map_relos(struct bpf_object *obj,
 			return -EINVAL;
 		}

-		if (!bpf_map_type__is_map_in_map(map->def.type))
+		is_map_in_map = bpf_map_type__is_map_in_map(map->def.type);
+		is_prog_array = map->def.type == BPF_MAP_TYPE_PROG_ARRAY;
+		if (!is_map_in_map && !is_prog_array)
 			return -EINVAL;
+		if (is_map_in_map && sym->st_shndx != obj->efile.btf_maps_shndx) {
+			pr_warn(".maps relo #%d: '%s' isn't a BTF-defined map\n",
+				i, name);
+			return -LIBBPF_ERRNO__RELOC;
+		}
+		if (is_prog_array && !bpf_object__find_program_by_name(obj, name)) {
+			pr_warn(".maps relo #%d: '%s' isn't a BPF program\n",
+				i, name);
+			return -LIBBPF_ERRNO__RELOC;
+		}
 		if (map->def.type == BPF_MAP_TYPE_HASH_OF_MAPS &&
 		    map->def.key_size != sizeof(int)) {
 			pr_warn(".maps relo #%d: hash-of-maps '%s' should have key size %zu.\n",
@@ -6238,9 +6325,15 @@ static int bpf_object__collect_map_relos(struct bpf_object *obj,
 			return -EINVAL;
 		}

-		targ_map = bpf_object__find_map_by_name(obj, name);
-		if (!targ_map)
-			return -ESRCH;
+		if (is_map_in_map) {
+			targ_map = bpf_object__find_map_by_name(obj, name);
+			if (!targ_map)
+				return -ESRCH;
+		} else {
+			targ_prog = bpf_object__find_program_by_name(obj, name);
+			if (!targ_prog)
+				return -ESRCH;
+		}

 		var = btf__type_by_id(obj->btf, vi->type);
 		def = skip_mods_and_typedefs(obj->btf, var->type, NULL);
@@ -6272,10 +6365,14 @@ static int bpf_object__collect_map_relos(struct bpf_object *obj,
 			       (new_sz - map->init_slots_sz) * host_ptr_sz);
 			map->init_slots_sz = new_sz;
 		}
-		map->init_slots[moff] = targ_map;
+		map->init_slots[moff] = is_map_in_map ? (void *)targ_map : (void *)targ_prog;

-		pr_debug(".maps relo #%d: map '%s' slot [%d] points to map '%s'\n",
-			 i, map->name, moff, name);
+		if (is_map_in_map)
+			pr_debug(".maps relo #%d: map '%s' slot [%d] points to map '%s'\n",
+				 i, map->name, moff, name);
+		else
+			pr_debug(".maps relo #%d: map '%s' slot [%d] points to prog '%s'\n",
+				 i, map->name, moff, name);
 	}

 	return 0;
@@ -7293,6 +7390,7 @@ int bpf_object__load_xattr(struct bpf_object_load_attr *attr)
 	err = err ? : bpf_object__create_maps(obj);
 	err = err ? : bpf_object__relocate(obj, obj->btf_custom_path ? : attr->target_btf_path);
 	err = err ? : bpf_object__load_progs(obj, attr->log_level);
+	err = err ? : bpf_object_init_prog_array(obj);

 	if (obj->gen_loader) {
 		/* reset FDs */
--
2.30.2
