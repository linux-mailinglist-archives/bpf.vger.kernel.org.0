Return-Path: <bpf+bounces-20278-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CC7783B4DD
	for <lists+bpf@lfdr.de>; Wed, 24 Jan 2024 23:41:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 872721F24AAD
	for <lists+bpf@lfdr.de>; Wed, 24 Jan 2024 22:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83D24135A48;
	Wed, 24 Jan 2024 22:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ezvRWhMA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E10F413340F
	for <bpf@vger.kernel.org>; Wed, 24 Jan 2024 22:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706136098; cv=none; b=LHKGnJvYxGWqhJlgvikN4OMS0GlkZ8ch+qPXrTp3x75Va21rwZZornm991SkvJrn47sbiCyPCCzXkWw/jDYEE4iA5ru8VCgQT1/TwxVEetrYA9v2A+5YrsJJLRj06FNUTBVlDnnH9cV6RTLRrmDEjE+P+JhuKzQjU/hVTGywZVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706136098; c=relaxed/simple;
	bh=+S3HFqtYkcpB9gRkXZ9p5f3hOlass0khZlv3rZUmBEI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=J4Go6kFse3EcLxYGAHwQq20kJVRTNXBAf/feyypao6jKCBObDlMfh6gd1/y652vH3F+julyblYfWkqki1HgBKQ7C83GmlQLEpZiBl3tCCJEPt0Ko7ACPqGA8035ZybiEHTbqhgxPnBChK6uqujNnaMQz/bEcaZx9XHABfs9BmrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ezvRWhMA; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-5ff7ec8772dso53209067b3.0
        for <bpf@vger.kernel.org>; Wed, 24 Jan 2024 14:41:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706136094; x=1706740894; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ctOASyFTHYM35n8/iv6hXxzrOtEmKaBozaLJJIhwyz4=;
        b=ezvRWhMAjXos9HZL3be8+EI3U0TVOnTaSfH+zcK49MbFviDoDtoLqX/BXScMZ1Zxux
         HKGOyWtwEjdO458U/Sn5nsL5DyLZ2gNgti872CaPXP+3xRqJqfI77wa/+lt3o/dmamiK
         OcsNnXM/jWTj2xzsjwTQAbzvl4EjI8dG9d5eZLWZnlX5uauEu11zuLSf4X7dCe0skdYK
         kXD210uZT6L63QpTQjCKuEo+OA/uAAsCkfYb5YEh4uF7B7XSsmhPC12KV6RJNNZtifXg
         YHPv6u+/zoB7N+Q5v/4UlLfWRM88QT2BEZ2db2SgxZFUxJetqlGTcvuQ7Tl4xQhLpYiG
         lnXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706136094; x=1706740894;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ctOASyFTHYM35n8/iv6hXxzrOtEmKaBozaLJJIhwyz4=;
        b=TNKluSKeSTw8xfStQGWrg5X68+UnNU6nZja/E6JnM7WyYKXv70gYG0cJpHg487dnPk
         pB/8KWw2GVo585wfxCyj7dfUnuqy7r5i86+UU+Oh8llCDHh99R3ZKS6lrcyRGxe+QhGK
         BI3WxnAFn0HqMdgAT1IkZK2Rs8RLqOuvXQFZVvjJekhA9NIrUPYbygWK20q50FFrmZwb
         /IUIplV8zT647Hqn+T0u34CQVuf1Qq8y+Wvn8xh+ZKNmnt5DyZFG4jZeKtjQ3cs08FDP
         CvqIr3ltoQJQTlp9ntdI2xuptgFbLdM/J1p1kUkVyvmAL/VcI24Pop9rJD7ghqme6RW3
         k6qw==
X-Gm-Message-State: AOJu0Yzx88UEYUGUFeDhfH59U+GkQLgObIHEsEanQoEhLpyr/u2rNxmu
	ziT0zOKHkh9XZX3RuRg9gvmgzQ0mqmkdik6IfNrMHTU7Hs7djG6qfymr49Hj
X-Google-Smtp-Source: AGHT+IEkOPNwB5E1DB8I3QMwoB9xy/frFPnhqopjmZlhueaXg9xmq/PNsjrxOCmTicNzx+M+4vqcIg==
X-Received: by 2002:a0d:df41:0:b0:5ff:4586:16f6 with SMTP id i62-20020a0ddf41000000b005ff458616f6mr1597178ywe.77.1706136094199;
        Wed, 24 Jan 2024 14:41:34 -0800 (PST)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:d544:ccbf:d406:5907])
        by smtp.gmail.com with ESMTPSA id cn32-20020a05690c0d2000b005ff7cda85c5sm234310ywb.69.2024.01.24.14.41.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 14:41:33 -0800 (PST)
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
Subject: [RFC bpf-next] bpf: Create shadow variables for struct_ops in skeletons.
Date: Wed, 24 Jan 2024 14:41:30 -0800
Message-Id: <20240124224130.859921-1-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kui-Feng Lee <thinker.li@gmail.com>

Create shadow variables for the fields of struct_ops maps in a skeleton
with the same name as the respective fields. For instance, if struct
bpf_testmod_ops has a "data" field as following, you can access or modify
its value through a shadow variable also named "data" in the skeleton.

  SEC(".struct_ops.link")
  struct bpf_testmod_ops testmod_1 = {
      .data = 0x1,
  };

Then, you can change the value in the following manner as shown in the code
below.

  skel->st_ops_vars.testmod_1.data = 13;

It is helpful to configure a struct_ops map during the execution of a
program. For instance, you can include a flag in a struct_ops type to
modify the way the kernel handles an instance. By implementing this
feature, a user space program can alter the flag's value prior to loading
an instance into the kernel.

The code generator for skeletons will produce code that copies values to
shadow variables from the internal data buffer when a skeleton is
opened. It will also copy values from shadow variables back to the internal
data buffer before a skeleton is loaded into the kernel.

The code generator will calculate the offset of a field and generate code
that copies the value of the field from or to the shadow variable to or
from the struct_ops internal data, with an offset relative to the beginning
of the internal data. For instance, if the "data" field in struct
bpf_testmod_ops is situated 16 bytes from the beginning of the struct, the
address for the "data" field of struct bpf_testmod_ops will be the starting
address plus 16.

The offset is calculated during code generation, so it is always in line
with the internal data in the skeleton. Even if the user space programs and
the BPF program were not compiled together, any differences in versions
would not impact correctness. This means that even if the BPF program and
the user space program reference different versions of the "struct
bpf_testmod_ops" and have different offsets for "data", these offsets
computed by the code generator would still function correctly.

The user space programs can only modify values by using these shadow
variables when the skeleton is open, but before being loaded. Once the
skeleton is loaded, the value is copied to the kernel, and any future
changes only affect the shadow variables in the user space memory and do
not update the kernel space. The shadow variables are not initialized
before opening a skeleton, so you cannot update values through them before
opening.

For function pointers (operators), you can change/replace their values with
other BPF programs. For example, the test case in test_struct_ops_module.c
points .test_2 to test_3() while it was pointed to test_2() by assigning a
new value to the shadow variable.

  skel->st_ops_vars.testmod_1.test_2 = skel->progs.test_3;

However, you need to turn off autoload for test_2() since it is not
assigned to any struct_ops map anymore. Or, it will fails to load test_2().

 bpf_program__set_autoload(skel->progs.test_2, false);

You can define more struct_ops programs than necessary. However, you need
to turn autoload off for unused ones.

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 tools/bpf/bpftool/gen.c                       | 348 +++++++++++++++++-
 tools/lib/bpf/libbpf.c                        |  18 +-
 tools/lib/bpf/libbpf.h                        |   4 +
 tools/lib/bpf/libbpf.map                      |   4 +
 tools/lib/bpf/libbpf_internal.h               |   1 +
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   |   6 +-
 .../selftests/bpf/bpf_testmod/bpf_testmod.h   |   1 +
 .../bpf/prog_tests/test_struct_ops_module.c   |  14 +-
 .../selftests/bpf/progs/struct_ops_module.c   |   8 +
 9 files changed, 393 insertions(+), 11 deletions(-)

diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
index ee3ce2b8000d..0207a5790087 100644
--- a/tools/bpf/bpftool/gen.c
+++ b/tools/bpf/bpftool/gen.c
@@ -906,6 +906,280 @@ codegen_progs_skeleton(struct bpf_object *obj, size_t prog_cnt, bool populate_li
 	}
 }
 
+/* Add shadow variables to the skeleton for a struct_ops map.
+ *
+ * Shadow variables are a mirror of member fields in a struct_ops map
+ * defined in the BPF program. They serve as a way to access and change the
+ * values in the map. For example, in struct bpf_testmod_ops, it defines
+ * three fields: test_1, test_2, and data. And, it defines an instance as
+ * testmod_1 in the program. Then, the skeleton will have three shadow
+ * variables: test_1, test_2, and data in skel->st_ops.testmod_1.
+ *
+ * Now, it doesn't support pointer type fields except function pointers.
+ * For non-function pointer fields, the shadow variables will be in the
+ * same type as the original fields, but all modifiers (const,
+ * volatile,...) are removed.
+ *
+ * For function pointer fields, the shadow variables will be in the (struct
+ * bpf_program *) type.
+ */
+static int gen_st_ops_shadow_vars(struct btf *btf, const char* ident,
+				  const struct bpf_map *map)
+{
+	DECLARE_LIBBPF_OPTS(btf_dump_emit_type_decl_opts, opts,
+			    .indent_level = 3,
+			    .strip_mods = false,
+			    );
+	const struct btf_type *map_type, *member_type;
+	const struct btf_member *members, *m;
+	struct btf_dump *d;
+	__u32 map_type_id, member_type_id;
+	int n_members;
+	int i;
+	int err = 0;;
+
+	d = btf_dump__new(btf, codegen_btf_dump_printf, NULL, NULL);
+	if (!d)
+		return -errno;
+
+	map_type_id = bpf_map__struct_ops_type(map);
+	map_type = btf__type_by_id(btf, map_type_id);
+	printf("\t\tstruct {\n");
+	n_members = btf_vlen(map_type);
+	members = btf_members(map_type);
+
+	for (i = 0; i < n_members; i++) {
+		m = &members[i];
+		member_type = skip_mods_and_typedefs(btf, m->type, &member_type_id);
+		if (!member_type) {
+			err = -EINVAL;
+			goto out;
+		}
+
+		switch (btf_kind(member_type)) {
+		case BTF_KIND_INT:
+		case BTF_KIND_FLOAT:
+		case BTF_KIND_ENUM:
+		case BTF_KIND_ENUM64:
+			printf("\t\t\t");
+			opts.field_name = btf__name_by_offset(btf, m->name_off);
+			err = btf_dump__emit_type_decl(d, member_type_id, &opts);
+			if (err)
+				goto out;
+			printf(";\n");
+			break;
+
+		case BTF_KIND_PTR:
+			if (resolve_func_ptr(btf, m->type, NULL))
+				printf("\t\t\tconst struct bpf_program *%s;\n",
+				       btf__name_by_offset(btf, m->name_off));
+			break;
+
+		default:
+			break;
+		}
+	}
+
+	printf("\t\t} %s;\n", ident);
+
+out:
+	btf_dump__free(d);
+
+	return 0;
+}
+
+/* Generate the code to synchronize shadow variables and the internal data.
+ *
+ * When "init" is true, it generates the code to copy the internal data to
+ * shadow variables. Otherwise, it generates the code to copy the shadow
+ * variables to the internal data.
+ *
+ * When "func_ptr" is ture, it generate the code to handle function
+ * pointers. Otherwise, it generates the code to handle non-function
+ * pointer fields.
+ */
+static int gen_st_ops_func_one(struct btf *btf, const struct bpf_map *map,
+			       const char *ident, int *decl_vars,
+			       bool init, bool func_ptr)
+{
+	DECLARE_LIBBPF_OPTS(btf_dump_emit_type_decl_opts, opts,
+			    .field_name = "",
+			    .indent_level = 3,
+			    .strip_mods = false,
+			    );
+	const struct btf_type *map_type, *member_type;
+	const struct btf_member *members, *m;
+	__u32 map_type_id, member_type_id;
+	struct btf_dump *d;
+	int n_members, i;
+	int cnt = 0, err = 0, prog_cnt = 0;
+
+	d = btf_dump__new(btf, codegen_btf_dump_printf, NULL, NULL);
+	if (!d)
+		return -errno;
+
+	map_type_id = bpf_map__struct_ops_type(map);
+	map_type = btf__type_by_id(btf, map_type_id);
+	n_members = btf_vlen(map_type);
+	members = btf_members(map_type);
+
+	for (i = 0; i < n_members; i++) {
+		m = &members[i];
+		member_type = skip_mods_and_typedefs(btf, m->type, &member_type_id);
+		if (!member_type) {
+			err = -EINVAL;
+			goto out;
+		}
+
+		switch (btf_kind(member_type)) {
+		case BTF_KIND_INT:
+		case BTF_KIND_FLOAT:
+		case BTF_KIND_ENUM:
+		case BTF_KIND_ENUM64:
+			if (func_ptr)
+				break;
+
+			if (!*decl_vars) {
+				printf("\tvoid *map_data;\n\n");
+				*decl_vars = 1;
+			}
+			if (cnt++ == 0)
+				printf("\tmap_data = bpf_map__struct_ops_data(obj->maps.%s);\n\tif (!map_data)\n\t\treturn -EINVAL;\n\n",
+				       ident);
+			if (init) {
+				printf("\tobj->st_ops_vars.%s.%s = *(", ident, btf__name_by_offset(btf, m->name_off));
+				err = btf_dump__emit_type_decl(d, member_type_id, &opts);
+				printf(" *)((char *)map_data + %d);\n", m->offset / 8);
+			} else {
+				printf("\t*(");
+				err = btf_dump__emit_type_decl(d, member_type_id, &opts);
+				printf(" *)((char *)map_data + %d) = obj->st_ops_vars.%s.%s;\n", m->offset / 8, ident, btf__name_by_offset(btf, m->name_off));
+			}
+			break;
+
+		case BTF_KIND_PTR:
+			if (!func_ptr)
+				break;
+
+			if (!resolve_func_ptr(btf, m->type, NULL))
+				break;
+			if (!*decl_vars) {
+				printf("\tconst struct bpf_program **map_progs;\n\n");
+				*decl_vars = 1;
+			}
+			if (prog_cnt++ == 0)
+				printf("\tmap_progs = bpf_map__struct_ops_progs(obj->maps.%s);\n\tif (!map_progs)\n\t\treturn -EINVAL;\n\n",
+				       ident);
+			if (init) {
+				printf("\tobj->st_ops_vars.%s.%s = map_progs[%d];\n", ident, btf__name_by_offset(btf, m->name_off), i);
+			} else {
+				printf("\tmap_progs[%d] = obj->st_ops_vars.%s.%s;\n", i, ident, btf__name_by_offset(btf, m->name_off));
+			}
+			break;
+
+		default:
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
+static int _gen_st_ops_func(struct btf *btf, const struct bpf_object *obj,
+			    const char *obj_name, bool init, bool func_ptr)
+{
+	const struct bpf_map *map;
+	char ident[256];
+	int decl_vars = 0;
+	int err;
+
+	bpf_object__for_each_map(map, obj) {
+		if (!get_map_ident(map, ident, sizeof(ident)))
+			continue;
+		if (bpf_map__type(map) != BPF_MAP_TYPE_STRUCT_OPS)
+			continue;
+
+		err = gen_st_ops_func_one(btf, map, ident, &decl_vars,
+					  init, func_ptr);
+		if (err)
+			return err;
+	}
+
+	if (decl_vars)
+		codegen("\n\n");
+
+	return 0;
+}
+
+/* Generate code to synchronize shadow variables for struct_ops maps
+ *
+ * It generates four functions.
+ *  - XXX__init_st_ops_shadow()
+ *  - XXX__update_st_ops_shadow()
+ *  - XXX__init_st_ops_shadow_fptr()
+ *  - XXX__update_st_ops_shadow_fptr()
+ *
+ * The XXX__init_*() ones are called to copy the shadow variables from the
+ * struct_ops maps.  They are called at the end of XXX_open(). The
+ * XXX__update_*() ones are called to copy the shadow variables to the
+ * struct_ops maps. They are called at the beginning of XXX_load().
+ *
+ * The *_fptr() ones are handling function pointers.
+ */
+static int gen_st_ops_func(struct btf *btf, const struct bpf_object *obj,
+			   const char *obj_name)
+{
+	int err;
+
+	codegen("\
+	\n\
+	static inline int %1$s__init_st_ops_shadow(struct %1$s *obj)	\n\
+	{								\n\
+	 ", obj_name);
+
+	err = _gen_st_ops_func(btf, obj, obj_name, true, false);
+	if (err)
+		return err;
+	codegen("\n\treturn 0;\n}\n\n");
+
+	codegen("\
+	\n\
+	static inline int %1$s__update_st_ops_shadow(struct %1$s *obj)	\n\
+	{								\n\
+	 ", obj_name);
+
+	err = _gen_st_ops_func(btf, obj, obj_name, false, false);
+	if (err)
+		return err;
+	codegen("\n\treturn 0;\n}\n\n");
+	codegen("\
+	\n\
+	static inline int %1$s__init_st_ops_shadow_fptr(struct %1$s *obj)\n\
+	{								\n\
+	 ", obj_name);
+
+	err = _gen_st_ops_func(btf, obj, obj_name, true, true);
+	if (err)
+		return err;
+	codegen("\n\treturn 0;\n}\n\n");
+
+	codegen("\
+	\n\
+	static inline int %1$s__update_st_ops_shadow_fptr(struct %1$s *obj)\n\
+	{								\n\
+	 ", obj_name);
+
+	err = _gen_st_ops_func(btf, obj, obj_name, false, true);
+	if (err)
+		return err;
+	codegen("\n\treturn 0;\n}\n\n");
+
+	return 0;
+}
+
 static int do_skeleton(int argc, char **argv)
 {
 	char header_guard[MAX_OBJ_NAME_LEN + sizeof("__SKEL_H__")];
@@ -920,6 +1194,7 @@ static int do_skeleton(int argc, char **argv)
 	struct bpf_map *map;
 	struct btf *btf;
 	struct stat st;
+	int st_ops_cnt = 0;
 
 	if (!REQ_ARGS(1)) {
 		usage();
@@ -999,6 +1274,13 @@ static int do_skeleton(int argc, char **argv)
 		prog_cnt++;
 	}
 
+	btf = bpf_object__btf(obj);
+	if (!btf) {
+		err = -1;
+		p_err("need btf type information for %s", obj_name);
+		goto out;
+	}
+
 	get_header_guard(header_guard, obj_name, "SKEL_H");
 	if (use_loader) {
 		codegen("\
@@ -1045,8 +1327,23 @@ static int do_skeleton(int argc, char **argv)
 				printf("\t\tstruct bpf_map_desc %s;\n", ident);
 			else
 				printf("\t\tstruct bpf_map *%s;\n", ident);
+			if (bpf_map__type(map) == BPF_MAP_TYPE_STRUCT_OPS)
+				st_ops_cnt++;
 		}
 		printf("\t} maps;\n");
+		if (st_ops_cnt) {
+			printf("\tstruct {\n");
+			bpf_object__for_each_map(map, obj) {
+				if (!get_map_ident(map, ident, sizeof(ident)))
+					continue;
+				if (bpf_map__type(map) != BPF_MAP_TYPE_STRUCT_OPS)
+					continue;
+				err = gen_st_ops_shadow_vars(btf, ident, map);
+				if (err)
+					goto out;
+			}
+			printf("\t} st_ops_vars;\n");
+		}
 	}
 
 	if (prog_cnt) {
@@ -1072,12 +1369,9 @@ static int do_skeleton(int argc, char **argv)
 		printf("\t} links;\n");
 	}
 
-	btf = bpf_object__btf(obj);
-	if (btf) {
-		err = codegen_datasecs(obj, obj_name);
-		if (err)
-			goto out;
-	}
+	err = codegen_datasecs(obj, obj_name);
+	if (err)
+		goto out;
 	if (use_loader) {
 		err = gen_trace(obj, obj_name, header_guard);
 		goto out;
@@ -1109,7 +1403,17 @@ static int do_skeleton(int argc, char **argv)
 									    \n\
 		static inline int					    \n\
 		%1$s__create_skeleton(struct %1$s *obj);		    \n\
-									    \n\
+		\n\
+		",
+		obj_name
+	);
+
+	err = gen_st_ops_func(btf, obj, obj_name);
+	if (err)
+		goto out;
+
+	codegen("\
+		\n\
 		static inline struct %1$s *				    \n\
 		%1$s__open_opts(const struct bpf_object_open_opts *opts)    \n\
 		{							    \n\
@@ -1127,6 +1431,13 @@ static int do_skeleton(int argc, char **argv)
 				goto err_out;				    \n\
 									    \n\
 			err = bpf_object__open_skeleton(obj->skeleton, opts);\n\
+			if (err)					    \n\
+				goto err_out;				    \n\
+									    \n\
+			err = %1$s__init_st_ops_shadow(obj);		    \n\
+			if (err)					    \n\
+				goto err_out;				    \n\
+			err = %1$s__init_st_ops_shadow_fptr(obj);	    \n\
 			if (err)					    \n\
 				goto err_out;				    \n\
 									    \n\
@@ -1146,6 +1457,13 @@ static int do_skeleton(int argc, char **argv)
 		static inline int					    \n\
 		%1$s__load(struct %1$s *obj)				    \n\
 		{							    \n\
+			int err = %1$s__update_st_ops_shadow(obj);	    \n\
+			if (err)					    \n\
+				return err;				    \n\
+			err = %1$s__update_st_ops_shadow_fptr(obj);	    \n\
+			if (err)					    \n\
+				return err;				    \n\
+									    \n\
 			return bpf_object__load_skeleton(obj->skeleton);    \n\
 		}							    \n\
 									    \n\
@@ -1294,6 +1612,7 @@ static int do_subskeleton(int argc, char **argv)
 	const struct btf_type *map_type, *var_type;
 	const struct btf_var_secinfo *var;
 	struct stat st;
+	int st_ops_cnt = 0;
 
 	if (!REQ_ARGS(1)) {
 		usage();
@@ -1435,8 +1754,23 @@ static int do_subskeleton(int argc, char **argv)
 			if (!get_map_ident(map, ident, sizeof(ident)))
 				continue;
 			printf("\t\tstruct bpf_map *%s;\n", ident);
+			if (bpf_map__type(map) == BPF_MAP_TYPE_STRUCT_OPS)
+				st_ops_cnt++;
 		}
 		printf("\t} maps;\n");
+		if (st_ops_cnt) {
+			printf("\tstruct {\n");
+			bpf_object__for_each_map(map, obj) {
+				if (!get_map_ident(map, ident, sizeof(ident)))
+					continue;
+				if (bpf_map__type(map) != BPF_MAP_TYPE_STRUCT_OPS)
+					continue;
+				err = gen_st_ops_shadow_vars(btf, ident, map);
+				if (err)
+					goto out;
+			}
+			printf("\t} st_ops_vars;\n");
+		}
 	}
 
 	if (prog_cnt) {
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 0569b4973a4f..10bf9358bea3 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -2129,7 +2129,7 @@ skip_mods_and_typedefs(const struct btf *btf, __u32 id, __u32 *res_id)
 	return t;
 }
 
-static const struct btf_type *
+const struct btf_type *
 resolve_func_ptr(const struct btf *btf, __u32 id, __u32 *res_id)
 {
 	const struct btf_type *t;
@@ -13848,3 +13848,19 @@ void bpf_object__destroy_skeleton(struct bpf_object_skeleton *s)
 	free(s->progs);
 	free(s);
 }
+
+void *bpf_map__struct_ops_data(const struct bpf_map *map)
+{
+	return map->st_ops->data;
+}
+
+__u32 bpf_map__struct_ops_type(const struct bpf_map *map)
+{
+	return map->st_ops->type_id;
+}
+
+const struct bpf_program **bpf_map__struct_ops_progs(const struct bpf_map *map)
+{
+	return (const struct bpf_program **)map->st_ops->progs;
+}
+
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 6cd9c501624f..a0ed5614bc61 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -820,6 +820,10 @@ struct bpf_map;
 LIBBPF_API struct bpf_link *bpf_map__attach_struct_ops(const struct bpf_map *map);
 LIBBPF_API int bpf_link__update_map(struct bpf_link *link, const struct bpf_map *map);
 
+LIBBPF_API void *bpf_map__struct_ops_data(const struct bpf_map *map);
+LIBBPF_API __u32 bpf_map__struct_ops_type(const struct bpf_map *map);
+LIBBPF_API const struct bpf_program **bpf_map__struct_ops_progs(const struct bpf_map *map);
+
 struct bpf_iter_attach_opts {
 	size_t sz; /* size of this struct for forward/backward compatibility */
 	union bpf_iter_link_info *link_info;
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 91c5aef7dae7..dfd6a0f28567 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -411,4 +411,8 @@ LIBBPF_1.3.0 {
 } LIBBPF_1.2.0;
 
 LIBBPF_1.4.0 {
+	global:
+		bpf_map__struct_ops_data;
+		bpf_map__struct_ops_progs;
+		bpf_map__struct_ops_type;
 } LIBBPF_1.3.0;
diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
index 58c547d473e0..4b80409eaca9 100644
--- a/tools/lib/bpf/libbpf_internal.h
+++ b/tools/lib/bpf/libbpf_internal.h
@@ -220,6 +220,7 @@ struct btf_type;
 struct btf_type *btf_type_by_id(const struct btf *btf, __u32 type_id);
 const char *btf_kind_str(const struct btf_type *t);
 const struct btf_type *skip_mods_and_typedefs(const struct btf *btf, __u32 id, __u32 *res_id);
+const struct btf_type *resolve_func_ptr(const struct btf *btf, __u32 id, __u32 *res_id);
 
 static inline enum btf_func_linkage btf_func_linkage(const struct btf_type *t)
 {
diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
index 8befaf17d454..9de779e6ac47 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
@@ -539,6 +539,10 @@ static int bpf_testmod_ops_init_member(const struct btf_type *t,
 				       const struct btf_member *member,
 				       void *kdata, const void *udata)
 {
+	if (member->offset == offsetof(struct bpf_testmod_ops, data) * 8) {
+		((struct bpf_testmod_ops *)kdata)->data = ((struct bpf_testmod_ops *)udata)->data;
+		return 1;
+	}
 	return 0;
 }
 
@@ -556,7 +560,7 @@ static int bpf_dummy_reg(void *kdata)
 	struct bpf_testmod_ops *ops = kdata;
 	int r;
 
-	r = ops->test_2(4, 3);
+	r = ops->test_2(4, ops->data);
 
 	return 0;
 }
diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.h b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.h
index ca5435751c79..dc355672c34d 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.h
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.h
@@ -31,6 +31,7 @@ struct bpf_iter_testmod_seq {
 struct bpf_testmod_ops {
 	int (*test_1)(void);
 	int (*test_2)(int a, int b);
+	int data;
 };
 
 #endif /* _BPF_TESTMOD_H */
diff --git a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
index 8d833f0c7580..8f0e24443411 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
@@ -4,6 +4,7 @@
 #include <time.h>
 
 #include "struct_ops_module.skel.h"
+#include "../bpf_testmod/bpf_testmod.h"
 
 static void check_map_info(struct bpf_map_info *info)
 {
@@ -43,6 +44,10 @@ static void test_struct_ops_load(void)
 	if (!ASSERT_OK_PTR(skel, "struct_ops_module_open"))
 		return;
 
+	skel->st_ops_vars.testmod_1.data = 13;
+	skel->st_ops_vars.testmod_1.test_2 = skel->progs.test_3;
+	bpf_program__set_autoload(skel->progs.test_2, false);
+
 	err = struct_ops_module__load(skel);
 	if (!ASSERT_OK(err, "struct_ops_module_load"))
 		goto cleanup;
@@ -56,8 +61,13 @@ static void test_struct_ops_load(void)
 	link = bpf_map__attach_struct_ops(skel->maps.testmod_1);
 	ASSERT_OK_PTR(link, "attach_test_mod_1");
 
-	/* test_2() will be called from bpf_dummy_reg() in bpf_testmod.c */
-	ASSERT_EQ(skel->bss->test_2_result, 7, "test_2_result");
+	/* test_3() will be called from bpf_dummy_reg() in bpf_testmod.c
+	 *
+	 * In bpf_testmod.c it will pass 4 and 13 (the value of data) to
+	 * .test_2.  So, the value of test_2_result should be 20 (4 + 13 +
+	 * 3).
+	 */
+	ASSERT_EQ(skel->bss->test_2_result, 20, "test_2_result");
 
 	bpf_link__destroy(link);
 
diff --git a/tools/testing/selftests/bpf/progs/struct_ops_module.c b/tools/testing/selftests/bpf/progs/struct_ops_module.c
index e44ac55195ca..40efb52650ac 100644
--- a/tools/testing/selftests/bpf/progs/struct_ops_module.c
+++ b/tools/testing/selftests/bpf/progs/struct_ops_module.c
@@ -22,9 +22,17 @@ int BPF_PROG(test_2, int a, int b)
 	return a + b;
 }
 
+SEC("struct_ops/test_3")
+int BPF_PROG(test_3, int a, int b)
+{
+	test_2_result = a + b + 3;
+	return a + b + 3;
+}
+
 SEC(".struct_ops.link")
 struct bpf_testmod_ops testmod_1 = {
 	.test_1 = (void *)test_1,
 	.test_2 = (void *)test_2,
+	.data = 0x1,
 };
 
-- 
2.34.1


