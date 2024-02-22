Return-Path: <bpf+bounces-22534-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98A258605AA
	for <lists+bpf@lfdr.de>; Thu, 22 Feb 2024 23:26:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E955284ADB
	for <lists+bpf@lfdr.de>; Thu, 22 Feb 2024 22:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3DCC137923;
	Thu, 22 Feb 2024 22:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a3cTGwsW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8476137902
	for <bpf@vger.kernel.org>; Thu, 22 Feb 2024 22:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708640795; cv=none; b=EN59aKioP+ZsGCAJlVap6GJtp7Gv381hJJTir+RI8GIcNNghQOLgTqVdod936TyV7SioJg7+GzMGsmfGeTB2WBz51TxyxNly8gW0x6WnqpLO7nQqEdQJQ+Y8RzHS/qDEALyV6DaIjYISgO8iJupwQSp9MRTxpW59mTMj+PiQJOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708640795; c=relaxed/simple;
	bh=myYhlR77GYPMEpdusIYm14ylXipQ4PZJZSgUNWPhjkA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XUCSrg57zrl/CAcAVtRUOTYwbwMnKfNMxQ/0DrnTx+JBXR/3oBwVWIgm1Qx1y4MJ4agFxr+CyqNp5Ua6z4xuaVAeSznepppovLblDlIdO6yyzTZNB9QokYr2byb9EowIGM6NMPWpsu3qcdhlRmat5AW8SHQZYdICVwxKsDs1Zl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a3cTGwsW; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-dcbf82cdf05so200570276.2
        for <bpf@vger.kernel.org>; Thu, 22 Feb 2024 14:26:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708640792; x=1709245592; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R371K0ydisrm+4ePeuSI88lTXvzLnBLcxh/U4PbC+3s=;
        b=a3cTGwsWeKMS8Jt8HT5bHPk/iHP9CwRPKbgh2OFacIeaky9YwdPHnPa43+epVhmgNE
         BOccrll0M0aoeMqnUcNLUtHxWMtk3i5vgbRBiJpG7u91K5DVilzHAjnRGgLfSP4YNOVr
         Ui1kkVaiifYBtnDfGEc+V1HD4VztUjh76/ZOp+4cnpRePdqrwgnBPEIJd4G9+PWhrpH9
         cIlfuYnC/UKbmBaXcz5I5iu4ZgCyqz1jrh6epVSiAic25iXSayFHDuisL7aCDE3n1GI7
         YKKVA+BobD39wHyy5VKu1VbIdLjSLpf4KxeEyxmX+8I8lyrDthLn1IpLOob5JnXXYNqr
         gPEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708640792; x=1709245592;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R371K0ydisrm+4ePeuSI88lTXvzLnBLcxh/U4PbC+3s=;
        b=rFxeftJi86a/yfBWl3WLheujWqygBW8CAad/kQOtSCs71OujtoWqyO/O8dpgt6Dhjw
         +hEXv2a9Q+XYpB2hrhNU/km4NeqDRzeQHBNV+i+FuvUcVVmm1vkW2R5pPzj2oXbCosfa
         /o1UFwLnoQx8t6R9oHXkL9GZ2fkaUBshp+DV/jP9POfJIwHFVvWiQNO953biZXWAbvi+
         zQ3Zdo6LCda6SlnKvh5yfQmbmEs0S3eSbU+FAhhZrFiW0MDu2AWKQTTlQDEdfJEjKJaw
         BsLLZs+Rb/xZUDnFKgAZPVRe9m8uzWcIpVlp+BExj9GM8CsTVvnHQW8CKVozWZUQ5zNP
         VG2Q==
X-Gm-Message-State: AOJu0Yy+44kaVayjX7kRoEIHuJLAtoLMhPeF9E0l5sbNvtPt96zkTYY8
	GyhBUF5CWSlGRsQNEQLUcXGJ+rlCijsphsG6IdZYPPd+aEu3JiNAw/xGnJtx
X-Google-Smtp-Source: AGHT+IHSPT6G6BgK76o7714PYcGCZJ4XIHnmp7DzJ5WxJ/Fj+cM1Vkw912Nfar3rfKerrY/FwwXibg==
X-Received: by 2002:a05:690c:fc2:b0:608:3cb0:4c97 with SMTP id dg2-20020a05690c0fc200b006083cb04c97mr642376ywb.21.1708640792149;
        Thu, 22 Feb 2024 14:26:32 -0800 (PST)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:34d2:7236:710a:117c])
        by smtp.gmail.com with ESMTPSA id e129-20020a0df587000000b00604a2e45cf2sm3280666ywf.140.2024.02.22.14.26.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 14:26:31 -0800 (PST)
From: thinker.li@gmail.com
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
Subject: [PATCH bpf-next v4 4/6] bpftool: generated shadow variables for struct_ops maps.
Date: Thu, 22 Feb 2024 14:26:22 -0800
Message-Id: <20240222222624.1163754-5-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240222222624.1163754-1-thinker.li@gmail.com>
References: <20240222222624.1163754-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kui-Feng Lee <thinker.li@gmail.com>

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
 tools/bpf/bpftool/gen.c | 235 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 234 insertions(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
index a9334c57e859..a21c92d95401 100644
--- a/tools/bpf/bpftool/gen.c
+++ b/tools/bpf/bpftool/gen.c
@@ -909,6 +909,207 @@ codegen_progs_skeleton(struct bpf_object *obj, size_t prog_cnt, bool populate_li
 	}
 }
 
+static int walk_st_ops_shadow_vars(struct btf *btf,
+				   const char *ident,
+				   const struct bpf_map *map)
+{
+	DECLARE_LIBBPF_OPTS(btf_dump_emit_type_decl_opts, opts,
+			    .indent_level = 3,
+			    );
+	const struct btf_type *map_type, *member_type;
+	__u32 map_type_id, member_type_id;
+	__u32 offset, next_offset = 0;
+	const struct btf_member *m;
+	const char *member_name;
+	struct btf_dump *d = NULL;
+	int i, err = 0;
+	int size, map_size;
+
+	map_type_id = bpf_map__btf_value_type_id(map);
+	if (map_type_id == 0)
+		return -EINVAL;
+	map_type = btf__type_by_id(btf, map_type_id);
+	if (!map_type)
+		return -EINVAL;
+
+	d = btf_dump__new(btf, codegen_btf_dump_printf, NULL, NULL);
+	if (!d)
+		return -errno;
+
+	for (i = 0, m = btf_members(map_type);
+	     i < btf_vlen(map_type);
+	     i++, m++) {
+		member_type = skip_mods_and_typedefs(btf, m->type,
+						     &member_type_id);
+		if (!member_type) {
+			err = -EINVAL;
+			goto out;
+		}
+
+		member_name = btf__name_by_offset(btf, m->name_off);
+		if (!member_name) {
+			err = -EINVAL;
+			goto out;
+		}
+
+		offset = m->offset / 8;
+		if (next_offset != offset) {
+			printf("\t\t\tchar __padding_%d[%d];\n",
+			       i - 1, offset - next_offset);
+		}
+
+		switch (btf_kind(member_type)) {
+		case BTF_KIND_INT:
+		case BTF_KIND_FLOAT:
+		case BTF_KIND_ENUM:
+		case BTF_KIND_ENUM64:
+			/* scalar type */
+			printf("\t\t\t");
+			opts.field_name = member_name;
+			err = btf_dump__emit_type_decl(d, member_type_id,
+						       &opts);
+			if (err)
+				goto out;
+			printf(";\n");
+
+			size = btf__resolve_size(btf, member_type_id);
+			if (size < 0) {
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
+				printf("\t\t\tconst struct bpf_program *%s;\n",
+				       member_name);
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
+			if (i == btf_vlen(map_type) - 1) {
+				map_size = btf__resolve_size(btf, map_type_id);
+				if (map_size < 0)
+					return -EINVAL;
+				size = map_size - offset;
+			} else {
+				size = (m[1].offset - m->offset) / 8;
+			}
+
+			printf("\t\t\tchar __padding_%d[%d];\n", i, size);
+
+			next_offset = offset + size;
+			break;
+		}
+	}
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
+ * space as the original field. However, the user should not access them
+ * directly. These unsupported fields are also renamed as __padding_*
+ * . They may be reordered or shifted due to changes in the original struct
+ * type. Accessing them through the generated names may unintentionally
+ * corrupt data.
+ */
+static int gen_st_ops_shadow_type(struct btf *btf, const char *ident,
+				  const struct bpf_map *map)
+{
+	int err;
+
+	printf("\t\tstruct {\n");
+
+	err = walk_st_ops_shadow_vars(btf, ident, map);
+	if (err)
+		return err;
+
+	printf("\t\t} *%s;\n", ident);
+
+	return 0;
+}
+
+static int gen_st_ops_shadow(struct btf *btf, struct bpf_object *obj)
+{
+	struct bpf_map *map;
+	char ident[256];
+	int err;
+
+	/* Generate the pointers to shadow types of
+	 * struct_ops maps.
+	 */
+	printf("\tstruct {\n");
+	bpf_object__for_each_map(map, obj) {
+		if (bpf_map__type(map) != BPF_MAP_TYPE_STRUCT_OPS)
+			continue;
+		if (!get_map_ident(map, ident, sizeof(ident)))
+			continue;
+		err = gen_st_ops_shadow_type(btf, ident, map);
+		if (err)
+			return err;
+	}
+	printf("\t} struct_ops;\n");
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
+				obj->struct_ops.%1$s =			    \n\
+					bpf_map__initial_value(obj->maps.%1$s, NULL);\n\
+			\n\
+			", ident);
+	}
+}
+
 static int do_skeleton(int argc, char **argv)
 {
 	char header_guard[MAX_OBJ_NAME_LEN + sizeof("__SKEL_H__")];
@@ -923,6 +1124,7 @@ static int do_skeleton(int argc, char **argv)
 	struct bpf_map *map;
 	struct btf *btf;
 	struct stat st;
+	int st_ops_cnt = 0;
 
 	if (!REQ_ARGS(1)) {
 		usage();
@@ -1039,6 +1241,8 @@ static int do_skeleton(int argc, char **argv)
 		);
 	}
 
+	btf = bpf_object__btf(obj);
+
 	if (map_cnt) {
 		printf("\tstruct {\n");
 		bpf_object__for_each_map(map, obj) {
@@ -1048,8 +1252,15 @@ static int do_skeleton(int argc, char **argv)
 				printf("\t\tstruct bpf_map_desc %s;\n", ident);
 			else
 				printf("\t\tstruct bpf_map *%s;\n", ident);
+			if (bpf_map__type(map) == BPF_MAP_TYPE_STRUCT_OPS)
+				st_ops_cnt++;
 		}
 		printf("\t} maps;\n");
+		if (st_ops_cnt && btf) {
+			err = gen_st_ops_shadow(btf, obj);
+			if (err)
+				goto out;
+		}
 	}
 
 	if (prog_cnt) {
@@ -1075,7 +1286,6 @@ static int do_skeleton(int argc, char **argv)
 		printf("\t} links;\n");
 	}
 
-	btf = bpf_object__btf(obj);
 	if (btf) {
 		err = codegen_datasecs(obj, obj_name);
 		if (err)
@@ -1133,6 +1343,13 @@ static int do_skeleton(int argc, char **argv)
 			if (err)					    \n\
 				goto err_out;				    \n\
 									    \n\
+		", obj_name);
+
+	if (st_ops_cnt && btf)
+		gen_st_ops_shadow_init(btf, obj);
+
+	codegen("\
+		\n\
 			return obj;					    \n\
 		err_out:						    \n\
 			%1$s__destroy(obj);				    \n\
@@ -1296,6 +1513,7 @@ static int do_subskeleton(int argc, char **argv)
 	struct btf *btf;
 	const struct btf_type *map_type, *var_type;
 	const struct btf_var_secinfo *var;
+	int st_ops_cnt = 0;
 	struct stat st;
 
 	if (!REQ_ARGS(1)) {
@@ -1438,10 +1656,18 @@ static int do_subskeleton(int argc, char **argv)
 			if (!get_map_ident(map, ident, sizeof(ident)))
 				continue;
 			printf("\t\tstruct bpf_map *%s;\n", ident);
+			if (bpf_map__type(map) == BPF_MAP_TYPE_STRUCT_OPS)
+				st_ops_cnt++;
 		}
 		printf("\t} maps;\n");
 	}
 
+	if (st_ops_cnt && btf) {
+		err = gen_st_ops_shadow(btf, obj);
+		if (err)
+			goto out;
+	}
+
 	if (prog_cnt) {
 		printf("\tstruct {\n");
 		bpf_object__for_each_program(prog, obj) {
@@ -1553,6 +1779,13 @@ static int do_subskeleton(int argc, char **argv)
 			if (err)					    \n\
 				goto err;				    \n\
 									    \n\
+		");
+
+	if (st_ops_cnt && btf)
+		gen_st_ops_shadow_init(btf, obj);
+
+	codegen("\
+		\n\
 			return obj;					    \n\
 		err:							    \n\
 			%1$s__destroy(obj);				    \n\
-- 
2.34.1


