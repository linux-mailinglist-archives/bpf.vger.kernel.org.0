Return-Path: <bpf+bounces-22998-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F08F486C13C
	for <lists+bpf@lfdr.de>; Thu, 29 Feb 2024 07:47:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98E2F2843E6
	for <lists+bpf@lfdr.de>; Thu, 29 Feb 2024 06:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BA17482C2;
	Thu, 29 Feb 2024 06:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l4QJnVMa"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8847481BB
	for <bpf@vger.kernel.org>; Thu, 29 Feb 2024 06:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709189133; cv=none; b=drA1ngsNfv59os0fyzdJvC8KVqZLCH8gdwOjI/NwYWIavIlHBkAo+Co5pMzcJDk64/rT/yRmczroDBlqoPMwotqYeQLwXPSksfPa19R2LW+q+U7BTUKr/JWkqexGFC3TbW4AuPYqsNOrw7f5pbzI2Fb3C8EjcgOVz6i0ny6g3lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709189133; c=relaxed/simple;
	bh=FBubj1N8kexbqkDeiWnkIx30gLcAEf+zPc0vtxhR1Es=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=M0lNLiZRGOMja5AO20DlDX2N7JEW6ljIGczPbftLz7T/ZmXRZnVwDjG/LMQozXJ2fqABQ9AqZwAKcWQ+wj2G6KP02F1+UddjQ8EJI8W4MRMzZn95D9lZRaorxp8MuYT5tGsS2uSYYzl6XJC6+6f7IKqRD6y10pN3QYLprHfiKR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l4QJnVMa; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-608841dfcafso6020077b3.2
        for <bpf@vger.kernel.org>; Wed, 28 Feb 2024 22:45:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709189130; x=1709793930; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v7NhmdOncoZuyPyxBwwRW1uQd/+CtHn8Eb6IapsaTlA=;
        b=l4QJnVMal2oJYXtC+x2zG1WJXaeUYHoE5zxFLTQM467ztYPwDEgYkPGvglZcG7k6bt
         uS4AiIHBR+vr9bTCc7Inikq2TEE7JdBb2kndQNY/MkwPYRe1PBwnSGUH0exDwN3u4NcE
         fw6ZSuyQCdzwBYyffRUVT6bLix/iVg9qNIvqIn1LxJq46nE+hNO4nlKDQMgAE9cJSKZS
         gGiqiN6r3WY4sEYYoOK916OVawNP8QGGl3HT5JSmbg62eKxHnya/ipjudTTNGe2sIZ2/
         H3n8J+NGDhMa2ynd0M+s9HbdI6ehbUzeMpF63Youp8n4W8aUrx00QF6eyDoKNjFDNqZx
         T/IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709189130; x=1709793930;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v7NhmdOncoZuyPyxBwwRW1uQd/+CtHn8Eb6IapsaTlA=;
        b=sTQNocfNls7Y/RRm+ulexnNKQLj697T4jjleZ2zA4n2VRAlAocTlJ1ilEIYlyOcR1Q
         OpTWfSEQfYdIq/ydbcUgr+OabIZ07Do0xhKgB11M7dIgjn/JiyofgL9NmjeHXj65eJ37
         hmenMhMidS+xCnfuudwnugo/9ihNZZdTMkZCHiY5clsCCAwMGxnlJisWy6Q/cwEtcb32
         Ce98+8SZqNshaCJglnUczahEzfWvf6i0/lmXvgsXcKrxVMnAq07fMPfW0lIOtNamtP07
         QYFCzVYvFSYhKLkzOWgRDjPDSbtPFGZoGv1FtN9/41pPXb9RF/Mtz/2LOWv5wkXgCu1s
         aRPA==
X-Gm-Message-State: AOJu0YwxWk7B21mDiY4CZGwbM8NCTDkd4SDdGJ26OQy10NLV5I+TiAlN
	5aoqx0lVQGziLGlTN1nzH6txNLtJLw2C9D84mOEj8xb5Zm3DLnLtScDQdztq
X-Google-Smtp-Source: AGHT+IEGwBhm9Bv0m2RAXhbdCxgrQ72YD19KJ0u3RxBwvubRzXme8R4XokFmSS1nEvyS6+npf2QEFw==
X-Received: by 2002:a81:a542:0:b0:609:4c74:5cc0 with SMTP id v2-20020a81a542000000b006094c745cc0mr1336194ywg.18.1709189130353;
        Wed, 28 Feb 2024 22:45:30 -0800 (PST)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:bc86:35de:12f4:eec9])
        by smtp.gmail.com with ESMTPSA id p14-20020a817e4e000000b006048e2331fcsm208581ywn.91.2024.02.28.22.45.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 22:45:30 -0800 (PST)
From: Kui-Feng Lee <thinker.li@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	kernel-team@meta.com,
	andrii@kernel.org,
	quentin@isovalent.com
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: [PATCH bpf-next v6 3/5] bpftool: generated shadow variables for struct_ops maps.
Date: Wed, 28 Feb 2024 22:45:21 -0800
Message-Id: <20240229064523.2091270-4-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240229064523.2091270-1-thinker.li@gmail.com>
References: <20240229064523.2091270-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Declares and defines a pointer of the shadow type for each struct_ops map.

The code generator will create an anonymous struct type as the shadow type
for each struct_ops map. The shadow type is translated from the original
struct type of the map. The user of the skeleton use pointers of them to
access the values of struct_ops maps.

However, shadow types only supports certain types of fields, including
scalar types and function pointers. Any fields of unsupported types are
translated into an array of characters to occupy the space of the original
field. Function pointers are translated into pointers of the struct
bpf_program. Additionally, padding fields are generated to occupy the space
between two consecutive fields.

The pointers of shadow types of struct_osp maps are initialized when
*__open_opts() in skeletons are called. For a map called FOO, the user can
access it through the pointer at skel->struct_ops.FOO.

Reviewed-by: Quentin Monnet <quentin@isovalent.com>
Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 tools/bpf/bpftool/gen.c | 237 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 236 insertions(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
index a9334c57e859..da8ae75eb6cb 100644
--- a/tools/bpf/bpftool/gen.c
+++ b/tools/bpf/bpftool/gen.c
@@ -55,6 +55,20 @@ static bool str_has_suffix(const char *str, const char *suffix)
 	return true;
 }
 
+static const struct btf_type *
+resolve_func_ptr(const struct btf *btf, __u32 id, __u32 *res_id)
+{
+	const struct btf_type *t;
+
+	t = skip_mods_and_typedefs(btf, id, NULL);
+	if (!btf_is_ptr(t))
+		return NULL;
+
+	t = skip_mods_and_typedefs(btf, t->type, res_id);
+
+	return btf_is_func_proto(t) ? t : NULL;
+}
+
 static void get_obj_name(char *name, const char *file)
 {
 	char file_copy[PATH_MAX];
@@ -909,6 +923,206 @@ codegen_progs_skeleton(struct bpf_object *obj, size_t prog_cnt, bool populate_li
 	}
 }
 
+static int walk_st_ops_shadow_vars(struct btf *btf, const char *ident,
+				   const struct btf_type *map_type, __u32 map_type_id)
+{
+	LIBBPF_OPTS(btf_dump_emit_type_decl_opts, opts, .indent_level = 3);
+	const struct btf_type *member_type;
+	__u32 offset, next_offset = 0;
+	const struct btf_member *m;
+	struct btf_dump *d = NULL;
+	const char *member_name;
+	__u32 member_type_id;
+	int i, err = 0, n;
+	int size;
+
+	d = btf_dump__new(btf, codegen_btf_dump_printf, NULL, NULL);
+	if (!d)
+		return -errno;
+
+	n = btf_vlen(map_type);
+	for (i = 0, m = btf_members(map_type); i < n; i++, m++) {
+		member_type = skip_mods_and_typedefs(btf, m->type, &member_type_id);
+		member_name = btf__name_by_offset(btf, m->name_off);
+
+		offset = m->offset / 8;
+		if (next_offset < offset)
+			printf("\t\t\tchar __padding_%d[%d];\n", i, offset - next_offset);
+
+		switch (btf_kind(member_type)) {
+		case BTF_KIND_INT:
+		case BTF_KIND_FLOAT:
+		case BTF_KIND_ENUM:
+		case BTF_KIND_ENUM64:
+			/* scalar type */
+			printf("\t\t\t");
+			opts.field_name = member_name;
+			err = btf_dump__emit_type_decl(d, member_type_id, &opts);
+			if (err) {
+				p_err("Failed to emit type declaration for %s: %d", member_name, err);
+				goto out;
+			}
+			printf(";\n");
+
+			size = btf__resolve_size(btf, member_type_id);
+			if (size < 0) {
+				p_err("Failed to resolve size of %s: %d\n", member_name, size);
+				err = size;
+				goto out;
+			}
+
+			next_offset = offset + size;
+			break;
+
+		case BTF_KIND_PTR:
+			if (resolve_func_ptr(btf, m->type, NULL)) {
+				/* Function pointer */
+				printf("\t\t\tstruct bpf_program *%s;\n", member_name);
+
+				next_offset = offset + sizeof(void *);
+				break;
+			}
+			/* All pointer types are unsupported except for
+			 * function pointers.
+			 */
+			fallthrough;
+
+		default:
+			/* Unsupported types
+			 *
+			 * Types other than scalar types and function
+			 * pointers are currently not supported in order to
+			 * prevent conflicts in the generated code caused
+			 * by multiple definitions. For instance, if the
+			 * struct type FOO is used in a struct_ops map,
+			 * bpftool has to generate definitions for FOO,
+			 * which may result in conflicts if FOO is defined
+			 * in different skeleton files.
+			 */
+			size = btf__resolve_size(btf, member_type_id);
+			if (size < 0) {
+				p_err("Failed to resolve size of %s: %d\n", member_name, size);
+				err = size;
+				goto out;
+			}
+			printf("\t\t\tchar __unsupported_%d[%d];\n", i, size);
+
+			next_offset = offset + size;
+			break;
+		}
+	}
+
+	/* Can not fail since it must be a struct type */
+	size = btf__resolve_size(btf, map_type_id);
+	if (next_offset < (__u32)size)
+		printf("\t\t\tchar __padding_end[%d];\n", size - next_offset);
+
+out:
+	btf_dump__free(d);
+
+	return err;
+}
+
+/* Generate the pointer of the shadow type for a struct_ops map.
+ *
+ * This function adds a pointer of the shadow type for a struct_ops map.
+ * The members of a struct_ops map can be exported through a pointer to a
+ * shadow type. The user can access these members through the pointer.
+ *
+ * A shadow type includes not all members, only members of some types.
+ * They are scalar types and function pointers. The function pointers are
+ * translated to the pointer of the struct bpf_program. The scalar types
+ * are translated to the original type without any modifiers.
+ *
+ * Unsupported types will be translated to a char array to occupy the same
+ * space as the original field, being renamed as __unsupported_*.  The user
+ * should treat these fields as opaque data.
+ */
+static int gen_st_ops_shadow_type(const char *obj_name, struct btf *btf, const char *ident,
+				  const struct bpf_map *map)
+{
+	const struct btf_type *map_type;
+	const char *type_name;
+	__u32 map_type_id;
+	int err;
+
+	map_type_id = bpf_map__btf_value_type_id(map);
+	if (map_type_id == 0)
+		return -EINVAL;
+	map_type = btf__type_by_id(btf, map_type_id);
+	if (!map_type)
+		return -EINVAL;
+
+	type_name = btf__name_by_offset(btf, map_type->name_off);
+
+	printf("\t\tstruct %s_%s_%s {\n", obj_name, ident, type_name);
+
+	err = walk_st_ops_shadow_vars(btf, ident, map_type, map_type_id);
+	if (err)
+		return err;
+
+	printf("\t\t} *%s;\n", ident);
+
+	return 0;
+}
+
+static int gen_st_ops_shadow(const char *obj_name, struct btf *btf, struct bpf_object *obj)
+{
+	int err, st_ops_cnt = 0;
+	struct bpf_map *map;
+	char ident[256];
+
+	if (!btf)
+		return 0;
+
+	/* Generate the pointers to shadow types of
+	 * struct_ops maps.
+	 */
+	bpf_object__for_each_map(map, obj) {
+		if (bpf_map__type(map) != BPF_MAP_TYPE_STRUCT_OPS)
+			continue;
+		if (!get_map_ident(map, ident, sizeof(ident)))
+			continue;
+
+		if (!st_ops_cnt++)
+			printf("\tstruct {\n");
+
+		err = gen_st_ops_shadow_type(obj_name, btf, ident, map);
+		if (err)
+			return err;
+	}
+
+	if (st_ops_cnt)
+		printf("\t} struct_ops;\n");
+
+	return 0;
+}
+
+/* Generate the code to initialize the pointers of shadow types. */
+static void gen_st_ops_shadow_init(struct btf *btf, struct bpf_object *obj)
+{
+	struct bpf_map *map;
+	char ident[256];
+
+	if (!btf)
+		return;
+
+	/* Initialize the pointers to_ops shadow types of
+	 * struct_ops maps.
+	 */
+	bpf_object__for_each_map(map, obj) {
+		if (bpf_map__type(map) != BPF_MAP_TYPE_STRUCT_OPS)
+			continue;
+		if (!get_map_ident(map, ident, sizeof(ident)))
+			continue;
+		codegen("\
+			\n\
+				obj->struct_ops.%1$s = bpf_map__initial_value(obj->maps.%1$s, NULL);\n\
+			\n\
+			", ident);
+	}
+}
+
 static int do_skeleton(int argc, char **argv)
 {
 	char header_guard[MAX_OBJ_NAME_LEN + sizeof("__SKEL_H__")];
@@ -1039,6 +1253,8 @@ static int do_skeleton(int argc, char **argv)
 		);
 	}
 
+	btf = bpf_object__btf(obj);
+
 	if (map_cnt) {
 		printf("\tstruct {\n");
 		bpf_object__for_each_map(map, obj) {
@@ -1052,6 +1268,10 @@ static int do_skeleton(int argc, char **argv)
 		printf("\t} maps;\n");
 	}
 
+	err = gen_st_ops_shadow(obj_name, btf, obj);
+	if (err)
+		goto out;
+
 	if (prog_cnt) {
 		printf("\tstruct {\n");
 		bpf_object__for_each_program(prog, obj) {
@@ -1075,7 +1295,6 @@ static int do_skeleton(int argc, char **argv)
 		printf("\t} links;\n");
 	}
 
-	btf = bpf_object__btf(obj);
 	if (btf) {
 		err = codegen_datasecs(obj, obj_name);
 		if (err)
@@ -1133,6 +1352,12 @@ static int do_skeleton(int argc, char **argv)
 			if (err)					    \n\
 				goto err_out;				    \n\
 									    \n\
+		", obj_name);
+
+	gen_st_ops_shadow_init(btf, obj);
+
+	codegen("\
+		\n\
 			return obj;					    \n\
 		err_out:						    \n\
 			%1$s__destroy(obj);				    \n\
@@ -1442,6 +1667,10 @@ static int do_subskeleton(int argc, char **argv)
 		printf("\t} maps;\n");
 	}
 
+	err = gen_st_ops_shadow(obj_name, btf, obj);
+	if (err)
+		goto out;
+
 	if (prog_cnt) {
 		printf("\tstruct {\n");
 		bpf_object__for_each_program(prog, obj) {
@@ -1553,6 +1782,12 @@ static int do_subskeleton(int argc, char **argv)
 			if (err)					    \n\
 				goto err;				    \n\
 									    \n\
+		");
+
+	gen_st_ops_shadow_init(btf, obj);
+
+	codegen("\
+		\n\
 			return obj;					    \n\
 		err:							    \n\
 			%1$s__destroy(obj);				    \n\
-- 
2.34.1


