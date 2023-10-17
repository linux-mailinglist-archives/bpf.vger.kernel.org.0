Return-Path: <bpf+bounces-12450-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 467AF7CC8B5
	for <lists+bpf@lfdr.de>; Tue, 17 Oct 2023 18:23:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B31FB21105
	for <lists+bpf@lfdr.de>; Tue, 17 Oct 2023 16:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 015669CA7A;
	Tue, 17 Oct 2023 16:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZkYcScy0"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ECB147351
	for <bpf@vger.kernel.org>; Tue, 17 Oct 2023 16:23:21 +0000 (UTC)
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D9C09E
	for <bpf@vger.kernel.org>; Tue, 17 Oct 2023 09:23:19 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id 3f1490d57ef6-d9abc069c8bso6108194276.3
        for <bpf@vger.kernel.org>; Tue, 17 Oct 2023 09:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697559798; x=1698164598; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w0Xqt4IZ7Ie3LDmSaBrZpsj4oO1zjRL24L+Ne3vuTJo=;
        b=ZkYcScy0FAhe4ILtH8IPlhlz3p6HpNDXCB5Ns3dii5+fW/eQOUW/nhTq8vjBS1mldi
         QCJXy1ynHdJgMyRbtCYrCvJmf3QUziBIQ5bLnVIvT9MmmZdn5EkTL4VmGW+TrMKm5JvH
         LlhB9Uj0Auq2tlXxfVbHnIyJGCXJC1GhCYZXIIxqTZO8drpBjPMFmA9iVvQQlPF9Rt6x
         IIRqTkIyjjPje8WRJWmFOdHEkQfsvLl7jicAA0VarlCBNbXQ6JPWeSeLYBaTT6RcDppB
         xsWoCECtI7z3C95YL6mTV+H6reTZ1+x0mFccLurqN8kbjWvNK+Yyza79r8D5VZBc/uLU
         76vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697559798; x=1698164598;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w0Xqt4IZ7Ie3LDmSaBrZpsj4oO1zjRL24L+Ne3vuTJo=;
        b=DUxfiuijeX1XoZyHIRgDZ1FRQSflXk2rz+9eANtsjQLbNzbEcO9RBXOZsNOXSDCHvP
         kkCuLtRqRhvNeJJXfmbrlrc5nazSo4yPpIj7zg1liXZr2GwQ0afjDZkVvEtRXB04tcS5
         hB0brPaEBK/VBNJfIy7qlrLdlV1Nx12oB4+nzGgjENcqSyRFRMrtCAGcVX66Q7u4JmTp
         FFKXbn27dvjmzmFuoGwdVSkY9YVvgiL1dNdlRPuRYRd43AdvLHc9lnZCNVs7YlZ3Feo3
         9E55STBx+MQBRnkjlh/Jm+fu7wRenejdYPNIJaES+EmywIiAgRpNuUdcrRmq0G+RLG1I
         iggw==
X-Gm-Message-State: AOJu0YynQcSJDMbQ6svWNyCPBwxoMK9oc5gmoRbvqz30T0zg+lvAjn3Z
	xiTzci6zSfkEsyS9mpD6IiaPjr597wg=
X-Google-Smtp-Source: AGHT+IHrjdceRZG7H6oWHtELKDZtgevliK2hwR8M6kZi4H80DQTzm5cs4zEMra2O0vOlHrwRAYaMMw==
X-Received: by 2002:a05:6902:603:b0:d9c:2b72:4fa5 with SMTP id d3-20020a056902060300b00d9c2b724fa5mr2458321ybt.48.1697559798224;
        Tue, 17 Oct 2023 09:23:18 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:ed01:b54a:4364:93cc])
        by smtp.gmail.com with ESMTPSA id r189-20020a2544c6000000b00d814d8dfd69sm623645yba.27.2023.10.17.09.23.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 09:23:17 -0700 (PDT)
From: thinker.li@gmail.com
To: bpf@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	kernel-team@meta.com,
	andrii@kernel.org,
	drosen@google.com
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: [PATCH bpf-next v5 7/9] libbpf: Find correct module BTFs for struct_ops maps and progs.
Date: Tue, 17 Oct 2023 09:23:04 -0700
Message-Id: <20231017162306.176586-8-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231017162306.176586-1-thinker.li@gmail.com>
References: <20231017162306.176586-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Kui-Feng Lee <thinker.li@gmail.com>

Locate the module BTFs for struct_ops maps and progs and pass them to the
kernel. This ensures that the kernel correctly resolves type IDs from the
appropriate module BTFs.

For the map of a struct_ops object, mod_btf is added to bpf_map to keep a
reference to the module BTF. The FD of the module BTF is passed to the
kernel as mod_btf_fd when the struct_ops object is loaded.

For a bpf_struct_ops prog, attach_btf_obj_fd of bpf_prog is the FD of a
module BTF in the kernel.

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 tools/lib/bpf/bpf.c    |  4 ++-
 tools/lib/bpf/bpf.h    |  5 +++-
 tools/lib/bpf/libbpf.c | 68 +++++++++++++++++++++++++++---------------
 3 files changed, 51 insertions(+), 26 deletions(-)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index b0f1913763a3..af46488e4ea9 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -169,7 +169,8 @@ int bpf_map_create(enum bpf_map_type map_type,
 		   __u32 max_entries,
 		   const struct bpf_map_create_opts *opts)
 {
-	const size_t attr_sz = offsetofend(union bpf_attr, map_extra);
+	const size_t attr_sz = offsetofend(union bpf_attr,
+					   value_type_btf_obj_fd);
 	union bpf_attr attr;
 	int fd;
 
@@ -191,6 +192,7 @@ int bpf_map_create(enum bpf_map_type map_type,
 	attr.btf_key_type_id = OPTS_GET(opts, btf_key_type_id, 0);
 	attr.btf_value_type_id = OPTS_GET(opts, btf_value_type_id, 0);
 	attr.btf_vmlinux_value_type_id = OPTS_GET(opts, btf_vmlinux_value_type_id, 0);
+	attr.value_type_btf_obj_fd = OPTS_GET(opts, value_type_btf_obj_fd, 0);
 
 	attr.inner_map_fd = OPTS_GET(opts, inner_map_fd, 0);
 	attr.map_flags = OPTS_GET(opts, map_flags, 0);
diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index 74c2887cfd24..1733cdc21241 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -51,8 +51,11 @@ struct bpf_map_create_opts {
 
 	__u32 numa_node;
 	__u32 map_ifindex;
+
+	__u32 value_type_btf_obj_fd;
+	size_t:0;
 };
-#define bpf_map_create_opts__last_field map_ifindex
+#define bpf_map_create_opts__last_field value_type_btf_obj_fd
 
 LIBBPF_API int bpf_map_create(enum bpf_map_type map_type,
 			      const char *map_name,
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 3a6108e3238b..d8a60fb52f5c 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -519,6 +519,7 @@ struct bpf_map {
 	struct bpf_map_def def;
 	__u32 numa_node;
 	__u32 btf_var_idx;
+	int mod_btf_fd;
 	__u32 btf_key_type_id;
 	__u32 btf_value_type_id;
 	__u32 btf_vmlinux_value_type_id;
@@ -893,6 +894,8 @@ bpf_object__add_programs(struct bpf_object *obj, Elf_Data *sec_data,
 	return 0;
 }
 
+static int load_module_btfs(struct bpf_object *obj);
+
 static const struct btf_member *
 find_member_by_offset(const struct btf_type *t, __u32 bit_offset)
 {
@@ -922,22 +925,29 @@ find_member_by_name(const struct btf *btf, const struct btf_type *t,
 	return NULL;
 }
 
+static int find_module_btf_id(struct bpf_object *obj, const char *kern_name,
+			      __u16 kind, struct btf **res_btf,
+			      struct module_btf **res_mod_btf);
+
 #define STRUCT_OPS_VALUE_PREFIX "bpf_struct_ops_"
 static int find_btf_by_prefix_kind(const struct btf *btf, const char *prefix,
 				   const char *name, __u32 kind);
 
 static int
-find_struct_ops_kern_types(const struct btf *btf, const char *tname,
+find_struct_ops_kern_types(struct bpf_object *obj, const char *tname,
+			   struct module_btf **mod_btf,
 			   const struct btf_type **type, __u32 *type_id,
 			   const struct btf_type **vtype, __u32 *vtype_id,
 			   const struct btf_member **data_member)
 {
 	const struct btf_type *kern_type, *kern_vtype;
 	const struct btf_member *kern_data_member;
+	struct btf *btf;
 	__s32 kern_vtype_id, kern_type_id;
 	__u32 i;
 
-	kern_type_id = btf__find_by_name_kind(btf, tname, BTF_KIND_STRUCT);
+	kern_type_id = find_module_btf_id(obj, tname, BTF_KIND_STRUCT,
+					  &btf, mod_btf);
 	if (kern_type_id < 0) {
 		pr_warn("struct_ops init_kern: struct %s is not found in kernel BTF\n",
 			tname);
@@ -991,14 +1001,16 @@ static bool bpf_map__is_struct_ops(const struct bpf_map *map)
 }
 
 /* Init the map's fields that depend on kern_btf */
-static int bpf_map__init_kern_struct_ops(struct bpf_map *map,
-					 const struct btf *btf,
-					 const struct btf *kern_btf)
+static int bpf_map__init_kern_struct_ops(struct bpf_map *map)
 {
 	const struct btf_member *member, *kern_member, *kern_data_member;
 	const struct btf_type *type, *kern_type, *kern_vtype;
 	__u32 i, kern_type_id, kern_vtype_id, kern_data_off;
+	struct bpf_object *obj = map->obj;
+	const struct btf *btf = obj->btf;
 	struct bpf_struct_ops *st_ops;
+	const struct btf *kern_btf;
+	struct module_btf *mod_btf;
 	void *data, *kern_data;
 	const char *tname;
 	int err;
@@ -1006,16 +1018,19 @@ static int bpf_map__init_kern_struct_ops(struct bpf_map *map,
 	st_ops = map->st_ops;
 	type = st_ops->type;
 	tname = st_ops->tname;
-	err = find_struct_ops_kern_types(kern_btf, tname,
+	err = find_struct_ops_kern_types(obj, tname, &mod_btf,
 					 &kern_type, &kern_type_id,
 					 &kern_vtype, &kern_vtype_id,
 					 &kern_data_member);
 	if (err)
 		return err;
 
+	kern_btf = mod_btf ? mod_btf->btf : obj->btf_vmlinux;
+
 	pr_debug("struct_ops init_kern %s: type_id:%u kern_type_id:%u kern_vtype_id:%u\n",
 		 map->name, st_ops->type_id, kern_type_id, kern_vtype_id);
 
+	map->mod_btf_fd = mod_btf ? mod_btf->fd : 0;
 	map->def.value_size = kern_vtype->size;
 	map->btf_vmlinux_value_type_id = kern_vtype_id;
 
@@ -1091,6 +1106,8 @@ static int bpf_map__init_kern_struct_ops(struct bpf_map *map,
 				return -ENOTSUP;
 			}
 
+			if (mod_btf)
+				prog->attach_btf_obj_fd = mod_btf->fd;
 			prog->attach_btf_id = kern_type_id;
 			prog->expected_attach_type = kern_member_idx;
 
@@ -1133,8 +1150,7 @@ static int bpf_object__init_kern_struct_ops_maps(struct bpf_object *obj)
 		if (!bpf_map__is_struct_ops(map))
 			continue;
 
-		err = bpf_map__init_kern_struct_ops(map, obj->btf,
-						    obj->btf_vmlinux);
+		err = bpf_map__init_kern_struct_ops(map);
 		if (err)
 			return err;
 	}
@@ -5193,8 +5209,10 @@ static int bpf_object__create_map(struct bpf_object *obj, struct bpf_map *map, b
 	create_attr.numa_node = map->numa_node;
 	create_attr.map_extra = map->map_extra;
 
-	if (bpf_map__is_struct_ops(map))
+	if (bpf_map__is_struct_ops(map)) {
 		create_attr.btf_vmlinux_value_type_id = map->btf_vmlinux_value_type_id;
+		create_attr.value_type_btf_obj_fd = map->mod_btf_fd;
+	}
 
 	if (obj->btf && btf__fd(obj->btf) >= 0) {
 		create_attr.btf_fd = btf__fd(obj->btf);
@@ -7700,9 +7718,9 @@ static int bpf_object__read_kallsyms_file(struct bpf_object *obj)
 	return libbpf_kallsyms_parse(kallsyms_cb, obj);
 }
 
-static int find_ksym_btf_id(struct bpf_object *obj, const char *ksym_name,
-			    __u16 kind, struct btf **res_btf,
-			    struct module_btf **res_mod_btf)
+static int find_module_btf_id(struct bpf_object *obj, const char *kern_name,
+			      __u16 kind, struct btf **res_btf,
+			      struct module_btf **res_mod_btf)
 {
 	struct module_btf *mod_btf;
 	struct btf *btf;
@@ -7710,7 +7728,7 @@ static int find_ksym_btf_id(struct bpf_object *obj, const char *ksym_name,
 
 	btf = obj->btf_vmlinux;
 	mod_btf = NULL;
-	id = btf__find_by_name_kind(btf, ksym_name, kind);
+	id = btf__find_by_name_kind(btf, kern_name, kind);
 
 	if (id == -ENOENT) {
 		err = load_module_btfs(obj);
@@ -7721,7 +7739,7 @@ static int find_ksym_btf_id(struct bpf_object *obj, const char *ksym_name,
 			/* we assume module_btf's BTF FD is always >0 */
 			mod_btf = &obj->btf_modules[i];
 			btf = mod_btf->btf;
-			id = btf__find_by_name_kind_own(btf, ksym_name, kind);
+			id = btf__find_by_name_kind_own(btf, kern_name, kind);
 			if (id != -ENOENT)
 				break;
 		}
@@ -7744,7 +7762,7 @@ static int bpf_object__resolve_ksym_var_btf_id(struct bpf_object *obj,
 	struct btf *btf = NULL;
 	int id, err;
 
-	id = find_ksym_btf_id(obj, ext->name, BTF_KIND_VAR, &btf, &mod_btf);
+	id = find_module_btf_id(obj, ext->name, BTF_KIND_VAR, &btf, &mod_btf);
 	if (id < 0) {
 		if (id == -ESRCH && ext->is_weak)
 			return 0;
@@ -7798,8 +7816,8 @@ static int bpf_object__resolve_ksym_func_btf_id(struct bpf_object *obj,
 
 	local_func_proto_id = ext->ksym.type_id;
 
-	kfunc_id = find_ksym_btf_id(obj, ext->essent_name ?: ext->name, BTF_KIND_FUNC, &kern_btf,
-				    &mod_btf);
+	kfunc_id = find_module_btf_id(obj, ext->essent_name ?: ext->name, BTF_KIND_FUNC, &kern_btf,
+				      &mod_btf);
 	if (kfunc_id < 0) {
 		if (kfunc_id == -ESRCH && ext->is_weak)
 			return 0;
@@ -9464,9 +9482,9 @@ static int libbpf_find_prog_btf_id(const char *name, __u32 attach_prog_fd)
 	return err;
 }
 
-static int find_kernel_btf_id(struct bpf_object *obj, const char *attach_name,
-			      enum bpf_attach_type attach_type,
-			      int *btf_obj_fd, int *btf_type_id)
+static int find_kernel_attach_btf_id(struct bpf_object *obj, const char *attach_name,
+				     enum bpf_attach_type attach_type,
+				     int *btf_obj_fd, int *btf_type_id)
 {
 	int ret, i;
 
@@ -9531,7 +9549,9 @@ static int libbpf_find_attach_btf_id(struct bpf_program *prog, const char *attac
 		*btf_obj_fd = 0;
 		*btf_type_id = 1;
 	} else {
-		err = find_kernel_btf_id(prog->obj, attach_name, attach_type, btf_obj_fd, btf_type_id);
+		err = find_kernel_attach_btf_id(prog->obj, attach_name,
+						attach_type, btf_obj_fd,
+						btf_type_id);
 	}
 	if (err) {
 		pr_warn("prog '%s': failed to find kernel BTF type ID of '%s': %d\n",
@@ -12945,9 +12965,9 @@ int bpf_program__set_attach_target(struct bpf_program *prog,
 		err = bpf_object__load_vmlinux_btf(prog->obj, true);
 		if (err)
 			return libbpf_err(err);
-		err = find_kernel_btf_id(prog->obj, attach_func_name,
-					 prog->expected_attach_type,
-					 &btf_obj_fd, &btf_id);
+		err = find_kernel_attach_btf_id(prog->obj, attach_func_name,
+						prog->expected_attach_type,
+						&btf_obj_fd, &btf_id);
 		if (err)
 			return libbpf_err(err);
 	}
-- 
2.34.1


