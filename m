Return-Path: <bpf+bounces-13507-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE82E7DA247
	for <lists+bpf@lfdr.de>; Fri, 27 Oct 2023 23:17:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A8BB28258C
	for <lists+bpf@lfdr.de>; Fri, 27 Oct 2023 21:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 599AB3FE4A;
	Fri, 27 Oct 2023 21:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bh3wNGS5"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96913FE30
	for <bpf@vger.kernel.org>; Fri, 27 Oct 2023 21:17:22 +0000 (UTC)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD20F129
	for <bpf@vger.kernel.org>; Fri, 27 Oct 2023 14:17:20 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-5a82f176860so19013687b3.1
        for <bpf@vger.kernel.org>; Fri, 27 Oct 2023 14:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698441440; x=1699046240; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LIaFNR2jWts5aTPUB8q6Tuj+4zsQdN5CxwLohBhhDRQ=;
        b=Bh3wNGS5+V7orqsl87usyzN6DsT8wwye776mcboM+dSuK4kehjZ6X1qMkApFvfRTN+
         d/rzxlHw2Y9XPHImT4UjYWyvwfSoXExcvNgQtBkZeNJzUVv3g0nZT7VX7XoBJUPVmuE+
         KRQAqR3E2HCUK/tetAusxBeWOcuz+qNTu3zH4v+ial3iT6+7wbNIy0JamQQac9ybnvjp
         q6RB1k4v05DGJ98Ix5T3QQdht7Mf9MS1IaOQqWXo5l/InIInRIUOLLKNBaaByzVGHoLf
         fsDdttKxIGjbuTEwn44lMFEw4toyNC0n9OxPGVwCNWfB3Xw7dFZ/t8Dv3TOLiLjLfTY/
         90Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698441440; x=1699046240;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LIaFNR2jWts5aTPUB8q6Tuj+4zsQdN5CxwLohBhhDRQ=;
        b=YJq0UiPhvYw/61sN8L2V+TSW0P3Nb77RKldTc366WZP4RL5sc5ralsON1ru/boRqJE
         oOoPpvS8RNt9NuMdgvsyR3Jg8Q8AcIx4HM5hxegKmUOYjjAtST1lqHYULUvwd2b1RWR8
         vpmGyg+jqRB1tx2ELygsL1wVD4mUrga9iMoZwHfxC6z5bLVH5vWfI9FSKwJVpgHGVgiw
         EyB/Xo7M2NMCyQZEjBWpjXGntybhVYwShXxHsRA2e9LFvmFSJ9rJDx/dd5KYHtiJZrTl
         iS5nRUtLQGaXn4TStwhENykBLXmu7l5crTwb88BG8YpPiUG9/5tMGBdmcOF4nq9yNOLY
         D9Cw==
X-Gm-Message-State: AOJu0YzIRB8x+FSJzFmYh1TU6QkwSKvE2D5Nl4h/XoEzGx+/FCwRFnJ+
	EePwf1PJBah+YyDAUB6JgIQD+5fhqSQ=
X-Google-Smtp-Source: AGHT+IH77v4puiYwOOzU9jGiuGKxf8Dp5n5NItCoZ1CtSjdfU3g/ovLhagG5KYj9Xxgso/+gOHha0Q==
X-Received: by 2002:a81:aa06:0:b0:5a7:bb6e:796d with SMTP id i6-20020a81aa06000000b005a7bb6e796dmr4472100ywh.19.1698441439808;
        Fri, 27 Oct 2023 14:17:19 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:41cd:a94b:292d:cd8])
        by smtp.gmail.com with ESMTPSA id e133-20020a81698b000000b0059a34cfa2a5sm1080174ywc.67.2023.10.27.14.17.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 14:17:19 -0700 (PDT)
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
Subject: [PATCH bpf-next v7 08/10] libbpf: Find correct module BTFs for struct_ops maps and progs.
Date: Fri, 27 Oct 2023 14:17:00 -0700
Message-Id: <20231027211702.1374597-9-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231027211702.1374597-1-thinker.li@gmail.com>
References: <20231027211702.1374597-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kui-Feng Lee <thinker.li@gmail.com>

Locate the module BTFs for struct_ops maps and progs and pass them to the
kernel. This ensures that the kernel correctly resolves type IDs from the
appropriate module BTFs.

For the map of a struct_ops object, the FD of the module BTF is set to
bpf_map to keep a reference to the module BTF. The FD is passed to the
kernel as value_type_btf_obj_fd when the struct_ops object is loaded.

For a bpf_struct_ops prog, attach_btf_obj_fd of bpf_prog is the FD of a
module BTF in the kernel.

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/bpf.c    |  4 +++-
 tools/lib/bpf/bpf.h    |  5 ++++-
 tools/lib/bpf/libbpf.c | 50 ++++++++++++++++++++++++++++--------------
 3 files changed, 41 insertions(+), 18 deletions(-)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index 9dc9625651dc..b133acfe08fb 100644
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
index d0f53772bdc0..ffdd81c0196a 100644
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
index e067be95da3c..0b0ad8461970 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -527,6 +527,7 @@ struct bpf_map {
 	struct bpf_map_def def;
 	__u32 numa_node;
 	__u32 btf_var_idx;
+	int mod_btf_fd;
 	__u32 btf_key_type_id;
 	__u32 btf_value_type_id;
 	__u32 btf_vmlinux_value_type_id;
@@ -930,22 +931,29 @@ find_member_by_name(const struct btf *btf, const struct btf_type *t,
 	return NULL;
 }
 
+static int find_ksym_btf_id(struct bpf_object *obj, const char *ksym_name,
+			    __u16 kind, struct btf **res_btf,
+			    struct module_btf **res_mod_btf);
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
+	kern_type_id = find_ksym_btf_id(obj, tname, BTF_KIND_STRUCT,
+					&btf, mod_btf);
 	if (kern_type_id < 0) {
 		pr_warn("struct_ops init_kern: struct %s is not found in kernel BTF\n",
 			tname);
@@ -999,14 +1007,16 @@ static bool bpf_map__is_struct_ops(const struct bpf_map *map)
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
@@ -1014,16 +1024,19 @@ static int bpf_map__init_kern_struct_ops(struct bpf_map *map,
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
 
@@ -1099,6 +1112,8 @@ static int bpf_map__init_kern_struct_ops(struct bpf_map *map,
 				return -ENOTSUP;
 			}
 
+			if (mod_btf)
+				prog->attach_btf_obj_fd = mod_btf->fd;
 			prog->attach_btf_id = kern_type_id;
 			prog->expected_attach_type = kern_member_idx;
 
@@ -1141,8 +1156,7 @@ static int bpf_object__init_kern_struct_ops_maps(struct bpf_object *obj)
 		if (!bpf_map__is_struct_ops(map))
 			continue;
 
-		err = bpf_map__init_kern_struct_ops(map, obj->btf,
-						    obj->btf_vmlinux);
+		err = bpf_map__init_kern_struct_ops(map);
 		if (err)
 			return err;
 	}
@@ -5201,8 +5215,10 @@ static int bpf_object__create_map(struct bpf_object *obj, struct bpf_map *map, b
 	create_attr.numa_node = map->numa_node;
 	create_attr.map_extra = map->map_extra;
 
-	if (bpf_map__is_struct_ops(map))
+	if (bpf_map__is_struct_ops(map)) {
 		create_attr.btf_vmlinux_value_type_id = map->btf_vmlinux_value_type_id;
+		create_attr.value_type_btf_obj_fd = map->mod_btf_fd;
+	}
 
 	if (obj->btf && btf__fd(obj->btf) >= 0) {
 		create_attr.btf_fd = btf__fd(obj->btf);
@@ -9479,9 +9495,9 @@ static int libbpf_find_prog_btf_id(const char *name, __u32 attach_prog_fd)
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
 
@@ -9546,7 +9562,9 @@ static int libbpf_find_attach_btf_id(struct bpf_program *prog, const char *attac
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
@@ -13004,9 +13022,9 @@ int bpf_program__set_attach_target(struct bpf_program *prog,
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


