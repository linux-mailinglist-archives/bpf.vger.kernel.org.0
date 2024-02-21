Return-Path: <bpf+bounces-22360-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 07CEA85CD69
	for <lists+bpf@lfdr.de>; Wed, 21 Feb 2024 02:24:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 853C91F24388
	for <lists+bpf@lfdr.de>; Wed, 21 Feb 2024 01:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FBF44C86;
	Wed, 21 Feb 2024 01:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QWrZ+T8q"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6259C5CA1
	for <bpf@vger.kernel.org>; Wed, 21 Feb 2024 01:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708478631; cv=none; b=UwpJl9SbpfHIUs3ayOL4w3lwaxLzTmJXm9NdcRttfPSseb8jxwbWPh8XLZX5ALs5OjPCrU92bjMmgmAwm8iQxb/I4pmqrA+3sBGq0886BKp1HZ5mLPqg1eF8Mfzk8ZTK44mCMXHeISa5rcWJ2yyamue/Up9LE/+HZhkf3Ej+jmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708478631; c=relaxed/simple;
	bh=Xv4CVaqRkAFvqZOASOMHn4WOwSMEzcm5NfGseX4zwXg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JLBdcyK4LXXZYBhqXpMeW5Ia42vKm+Y75rguq7wuAgfda/lf5q3Z7ls9QAVFczmmB8qa1ifyz6LVUqW59r9lNtws0qGwkgYUq+MONpLv75JSaGzp31biPrrnusJEaJF9SA7951TyteV59vtVzleuEw76rnnO/cSj6U2xD8i1xgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QWrZ+T8q; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6084165494eso24193207b3.1
        for <bpf@vger.kernel.org>; Tue, 20 Feb 2024 17:23:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708478628; x=1709083428; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wQ4yvjmbfK9gTsHxM3zdQuAaDyQDXt43A+y9/rdVBDE=;
        b=QWrZ+T8qDcauJ/OZ/ou1mM/6hliPcfYnnrky4uuh2IzaLZmZhJyOO1zd1ZYebDrFfH
         c56mocaJGhgY+8tjPpNJcYiXf5fINm/Y5WUbVeGP60WZEZFBRGNN6wIxy5LfKymwSyap
         M5BeE0q10ox7TintEIgvMZXjxaTShvYGPrtESb7xxiGLq/d0+SySeHStViADoDfXu2fs
         2Jdwl1GMogftwSRKzmy9liWlsQARnqGnyQdxO2cuVhTm1LS6/2bTEcnyHwI+Km9+P0LN
         3InuwGku0EQ/HlvU6Zo6GWSurm9VQbUga+ZMkEqWgaGrbH0HGBnti7PjtPPkBw0Rgw7L
         nBFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708478628; x=1709083428;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wQ4yvjmbfK9gTsHxM3zdQuAaDyQDXt43A+y9/rdVBDE=;
        b=GdE/B7eR5a6IfKpw1fLOTz6uYkHBpdYdH86Ej8trnlgFrKoa4SHkV/eh9MIjN3XH0r
         tiX2Ao9IBS1ApqAVnBe/sAUmsBAspsGOfsCapVZBMOrc2MxUMxSfyTGFk84hsw43yr7w
         MyBCEhWZOxuEgZgIaV/1EI973JUAjthpaQiEWI3tYYMP4htISA/74jfBehL+tnPItQgH
         kv/mY5INCfWPoamMhZjDVLpB6cRoEaYKFATxRPHs7lfxSaZ77m8I66s2qdVjjXJ3dmBx
         O8NdijSHlIYo3Ntd+utlequ7iucwDHJGCFPm7ufxZchkVw79z+s9Susc9/aiFQAoaTYh
         vuYQ==
X-Gm-Message-State: AOJu0Yx9hLTSMtnw45L2yuoQJCljsalm77xe27EpEPVp0H0pJHzYYT6U
	dOrLYNyR2KPfyGgPTt6lvHJ3R8lf1+LaQgZvIUVKI2jscbk30X4XQnsp2j0d
X-Google-Smtp-Source: AGHT+IEn3n9A+4+SyThXQtqrhHqoPw7cZb2A5whl8Ko2ZiKFIK24f/tk81zLJMqvCa2zgnrQT4D2jQ==
X-Received: by 2002:a05:690c:82e:b0:607:9e7e:7d02 with SMTP id by14-20020a05690c082e00b006079e7e7d02mr16117667ywb.35.1708478627751;
        Tue, 20 Feb 2024 17:23:47 -0800 (PST)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:26eb:2942:8151:a089])
        by smtp.gmail.com with ESMTPSA id j64-20020a0de043000000b00607ef065781sm2396801ywe.138.2024.02.20.17.23.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 17:23:47 -0800 (PST)
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
Subject: [PATCH bpf-next v3 4/5] bpftool: generated shadow variables for struct_ops maps.
Date: Tue, 20 Feb 2024 17:23:28 -0800
Message-Id: <20240221012329.1387275-5-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240221012329.1387275-1-thinker.li@gmail.com>
References: <20240221012329.1387275-1-thinker.li@gmail.com>
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

However, shadow types only supports certain types of fields, such as scalar
types and function pointers. Any fields of unsupported types are translated
into an array of characters to occupy the space of the original
field. Function pointers are translated into pointers of the struct
bpf_program. Additionally, padding fields are generated to occupy the space
between two consecutive fields.

The pointers of shadow types of struct_osp maps are initialized when
*__open_opts() in skeletons are called. For a map called FOO, the user can
access it through the pointer at skel->struct_ops.FOO.

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 tools/bpf/bpftool/gen.c | 229 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 228 insertions(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
index a9334c57e859..20c5d5912df7 100644
--- a/tools/bpf/bpftool/gen.c
+++ b/tools/bpf/bpftool/gen.c
@@ -909,6 +909,201 @@ codegen_progs_skeleton(struct bpf_object *obj, size_t prog_cnt, bool populate_li
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
+			fallthrough;
+
+		default:
+			/* Unsupported types
+			 *
+			 * For unsupported types, we have to generate
+			 * definitions for them in order to support
+			 * them. For example, we need to generate a
+			 * definition for a struct type or a union type. It
+			 * may cause type conflicts without renaming since
+			 * the same type may be defined for several
+			 * skeletons, and the user may include these
+			 * skeletons in the same compile unit.
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
+ * Unsupported types will be translated to a char array to take the same
+ * space of the original field. However, due to handling padding and
+ * alignments, the user should not access them directly.
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
@@ -923,6 +1118,7 @@ static int do_skeleton(int argc, char **argv)
 	struct bpf_map *map;
 	struct btf *btf;
 	struct stat st;
+	int st_ops_cnt = 0;
 
 	if (!REQ_ARGS(1)) {
 		usage();
@@ -1039,6 +1235,8 @@ static int do_skeleton(int argc, char **argv)
 		);
 	}
 
+	btf = bpf_object__btf(obj);
+
 	if (map_cnt) {
 		printf("\tstruct {\n");
 		bpf_object__for_each_map(map, obj) {
@@ -1048,8 +1246,15 @@ static int do_skeleton(int argc, char **argv)
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
@@ -1075,7 +1280,6 @@ static int do_skeleton(int argc, char **argv)
 		printf("\t} links;\n");
 	}
 
-	btf = bpf_object__btf(obj);
 	if (btf) {
 		err = codegen_datasecs(obj, obj_name);
 		if (err)
@@ -1133,6 +1337,13 @@ static int do_skeleton(int argc, char **argv)
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
@@ -1296,6 +1507,7 @@ static int do_subskeleton(int argc, char **argv)
 	struct btf *btf;
 	const struct btf_type *map_type, *var_type;
 	const struct btf_var_secinfo *var;
+	int st_ops_cnt = 0;
 	struct stat st;
 
 	if (!REQ_ARGS(1)) {
@@ -1438,10 +1650,18 @@ static int do_subskeleton(int argc, char **argv)
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
@@ -1553,6 +1773,13 @@ static int do_subskeleton(int argc, char **argv)
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


