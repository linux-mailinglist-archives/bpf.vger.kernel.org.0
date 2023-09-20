Return-Path: <bpf+bounces-10468-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5C2F7A892A
	for <lists+bpf@lfdr.de>; Wed, 20 Sep 2023 18:02:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 929661C20A0F
	for <lists+bpf@lfdr.de>; Wed, 20 Sep 2023 16:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68CE33E469;
	Wed, 20 Sep 2023 16:01:02 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D5233C6AA
	for <bpf@vger.kernel.org>; Wed, 20 Sep 2023 16:01:00 +0000 (UTC)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F29B9B9
	for <bpf@vger.kernel.org>; Wed, 20 Sep 2023 09:00:57 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-59be8a2099bso71417417b3.0
        for <bpf@vger.kernel.org>; Wed, 20 Sep 2023 09:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695225656; x=1695830456; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j5QreV6pWpdf4lxBYZjAA0RLHuYyklhaH4h2os7LIwo=;
        b=a47XlQxiOOsGT4+N4Fy9FOrC7NfVOLoo/gjvuRpJcRFUoQUoie/Kf1jaxU9Bn/4NlQ
         wcZlZyCx1eDNxak2OHM7vQ/lTusEee9EgasNniaLr4u+ShGMq2zy1SO6x0SbZz1suXmI
         v+kPbuMxYT3NaeI3l3Wgtti0POlgZ5uwQH6+A5tB/hj5H66uiPpxcTfpYrHGllKr/7EP
         bacMf1uD4mJ4sKQYAhKU1DmceTvSebfYNJi9fqyaK7v3aj9/jSanFSgIu03mNRmz5b6O
         TSE7MTe+HKHzWrtGX3w2zIzb3XoWREq7MdD4mpKPNR9qHmafWzpYG5RYvZG2O5XElbmH
         jT3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695225656; x=1695830456;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j5QreV6pWpdf4lxBYZjAA0RLHuYyklhaH4h2os7LIwo=;
        b=oZnhH7N3Vx7fY9ve0RaXU7YFgwJ64ZMGECdds36ZxNToAj8/yfXwxsGn2fGDg1yhIK
         H9X4ptLsW/ASNp5+J/cZqh9zu7gwed30sdpTIba41W4nON4LnYFT/haY1RHiLAUv0E4s
         wWI+XD7+St07AxcDqm7RSWRq7ShA7jIwwCw52AXB0O7sY/mgNut5Ndtjp+bKy8rl0GnI
         DPyJRtQO4HDnaut8W4TIy1cQGqFE45NbqfVdq8UTow0L7gJk8g/hIvTJOKXr3BUShLnP
         LwD/1Ne/FLRDAhQeOsjwYP2YtDyPzLkmqanRz5fwgtKR/hhBJVrKdUYr1o0M3X0Wwwqe
         AsZw==
X-Gm-Message-State: AOJu0YzidcUTPbdSfJMZzB81iUD76kg3hD2OOXSMxbsz6FHidFQ95R4H
	C31wa8N7i6gKRYSgOKTJxY6I9CetJZ0=
X-Google-Smtp-Source: AGHT+IFKL/SbSBFHjSOCsTi3Z3cS/kjB2ffbQYf/ldPv5nH/DEVvuB+satZQ634n4hAACx+t1HIAuw==
X-Received: by 2002:a81:4895:0:b0:589:d560:adaa with SMTP id v143-20020a814895000000b00589d560adaamr2835133ywa.7.1695225656135;
        Wed, 20 Sep 2023 09:00:56 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:dcd2:9730:2c7c:239f])
        by smtp.gmail.com with ESMTPSA id m131-20020a817189000000b00589dbcf16cbsm3860490ywc.35.2023.09.20.09.00.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 09:00:54 -0700 (PDT)
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
Subject: [RFC bpf-next v3 09/11] libbpf: Find correct module BTFs for struct_ops maps and progs.
Date: Wed, 20 Sep 2023 08:59:22 -0700
Message-Id: <20230920155923.151136-10-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230920155923.151136-1-thinker.li@gmail.com>
References: <20230920155923.151136-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Kui-Feng Lee <thinker.li@gmail.com>

Find module BTFs for struct_ops maps and progs and pass them to the kernel.
It ensures the kernel resolve type IDs from correct module BTFs.

For the map of a struct_ops object, mod_btf is added to bpf_map to keep a
reference to the module BTF. It's FD is passed to the kernel as mod_btf_fd
when it is created.

For a prog attaching to a struct_ops object, attach_btf_obj_fd of bpf_prog
is the FD pointing to a module BTF in the kernel.

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 tools/lib/bpf/bpf.c    |   3 +-
 tools/lib/bpf/bpf.h    |   4 +-
 tools/lib/bpf/libbpf.c | 121 ++++++++++++++++++++++++-----------------
 3 files changed, 75 insertions(+), 53 deletions(-)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index b0f1913763a3..df4b7570ad92 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -169,7 +169,7 @@ int bpf_map_create(enum bpf_map_type map_type,
 		   __u32 max_entries,
 		   const struct bpf_map_create_opts *opts)
 {
-	const size_t attr_sz = offsetofend(union bpf_attr, map_extra);
+	const size_t attr_sz = offsetofend(union bpf_attr, mod_btf_fd);
 	union bpf_attr attr;
 	int fd;
 
@@ -191,6 +191,7 @@ int bpf_map_create(enum bpf_map_type map_type,
 	attr.btf_key_type_id = OPTS_GET(opts, btf_key_type_id, 0);
 	attr.btf_value_type_id = OPTS_GET(opts, btf_value_type_id, 0);
 	attr.btf_vmlinux_value_type_id = OPTS_GET(opts, btf_vmlinux_value_type_id, 0);
+	attr.mod_btf_fd = OPTS_GET(opts, mod_btf_fd, 0);
 
 	attr.inner_map_fd = OPTS_GET(opts, inner_map_fd, 0);
 	attr.map_flags = OPTS_GET(opts, map_flags, 0);
diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index 74c2887cfd24..d18f75b0ccc9 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -51,8 +51,10 @@ struct bpf_map_create_opts {
 
 	__u32 numa_node;
 	__u32 map_ifindex;
+
+	__u32 mod_btf_fd;
 };
-#define bpf_map_create_opts__last_field map_ifindex
+#define bpf_map_create_opts__last_field mod_btf_fd
 
 LIBBPF_API int bpf_map_create(enum bpf_map_type map_type,
 			      const char *map_name,
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 3a6108e3238b..df6ba5494adb 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -519,6 +519,7 @@ struct bpf_map {
 	struct bpf_map_def def;
 	__u32 numa_node;
 	__u32 btf_var_idx;
+	struct module_btf *mod_btf;
 	__u32 btf_key_type_id;
 	__u32 btf_value_type_id;
 	__u32 btf_vmlinux_value_type_id;
@@ -893,6 +894,42 @@ bpf_object__add_programs(struct bpf_object *obj, Elf_Data *sec_data,
 	return 0;
 }
 
+static int load_module_btfs(struct bpf_object *obj);
+
+static int find_kern_btf_id(struct bpf_object *obj, const char *kern_name,
+			    __u16 kind, struct btf **res_btf,
+			    struct module_btf **res_mod_btf)
+{
+	struct module_btf *mod_btf;
+	struct btf *btf;
+	int i, id, err;
+
+	btf = obj->btf_vmlinux;
+	mod_btf = NULL;
+	id = btf__find_by_name_kind(btf, kern_name, kind);
+
+	if (id == -ENOENT) {
+		err = load_module_btfs(obj);
+		if (err)
+			return err;
+
+		for (i = 0; i < obj->btf_module_cnt; i++) {
+			/* we assume module_btf's BTF FD is always >0 */
+			mod_btf = &obj->btf_modules[i];
+			btf = mod_btf->btf;
+			id = btf__find_by_name_kind_own(btf, kern_name, kind);
+			if (id != -ENOENT)
+				break;
+		}
+	}
+	if (id <= 0)
+		return -ESRCH;
+
+	*res_btf = btf;
+	*res_mod_btf = mod_btf;
+	return id;
+}
+
 static const struct btf_member *
 find_member_by_offset(const struct btf_type *t, __u32 bit_offset)
 {
@@ -927,17 +964,23 @@ static int find_btf_by_prefix_kind(const struct btf *btf, const char *prefix,
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
+	/* XXX: should search module BTFs as well. We need module name here
+	 * to locate a correct BTF type.
+	 */
+	kern_type_id = find_kern_btf_id(obj, tname, BTF_KIND_STRUCT,
+					&btf, mod_btf);
 	if (kern_type_id < 0) {
 		pr_warn("struct_ops init_kern: struct %s is not found in kernel BTF\n",
 			tname);
@@ -992,13 +1035,15 @@ static bool bpf_map__is_struct_ops(const struct bpf_map *map)
 
 /* Init the map's fields that depend on kern_btf */
 static int bpf_map__init_kern_struct_ops(struct bpf_map *map,
-					 const struct btf *btf,
-					 const struct btf *kern_btf)
+					 struct bpf_object *obj)
 {
 	const struct btf_member *member, *kern_member, *kern_data_member;
 	const struct btf_type *type, *kern_type, *kern_vtype;
 	__u32 i, kern_type_id, kern_vtype_id, kern_data_off;
 	struct bpf_struct_ops *st_ops;
+	const struct btf *kern_btf;
+	struct module_btf *mod_btf;
+	const struct btf *btf = obj->btf;
 	void *data, *kern_data;
 	const char *tname;
 	int err;
@@ -1006,16 +1051,19 @@ static int bpf_map__init_kern_struct_ops(struct bpf_map *map,
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
 
+	map->mod_btf = mod_btf;
 	map->def.value_size = kern_vtype->size;
 	map->btf_vmlinux_value_type_id = kern_vtype_id;
 
@@ -1091,6 +1139,9 @@ static int bpf_map__init_kern_struct_ops(struct bpf_map *map,
 				return -ENOTSUP;
 			}
 
+			/* XXX: attach_btf_obj_fd is needed as well */
+			if (mod_btf)
+				prog->attach_btf_obj_fd = mod_btf->fd;
 			prog->attach_btf_id = kern_type_id;
 			prog->expected_attach_type = kern_member_idx;
 
@@ -1133,8 +1184,8 @@ static int bpf_object__init_kern_struct_ops_maps(struct bpf_object *obj)
 		if (!bpf_map__is_struct_ops(map))
 			continue;
 
-		err = bpf_map__init_kern_struct_ops(map, obj->btf,
-						    obj->btf_vmlinux);
+		/* XXX: should be a module btf if not vmlinux */
+		err = bpf_map__init_kern_struct_ops(map, obj);
 		if (err)
 			return err;
 	}
@@ -5193,8 +5244,10 @@ static int bpf_object__create_map(struct bpf_object *obj, struct bpf_map *map, b
 	create_attr.numa_node = map->numa_node;
 	create_attr.map_extra = map->map_extra;
 
-	if (bpf_map__is_struct_ops(map))
+	if (bpf_map__is_struct_ops(map)) {
 		create_attr.btf_vmlinux_value_type_id = map->btf_vmlinux_value_type_id;
+		create_attr.mod_btf_fd = map->mod_btf ? map->mod_btf->fd : 0;
+	}
 
 	if (obj->btf && btf__fd(obj->btf) >= 0) {
 		create_attr.btf_fd = btf__fd(obj->btf);
@@ -7700,40 +7753,6 @@ static int bpf_object__read_kallsyms_file(struct bpf_object *obj)
 	return libbpf_kallsyms_parse(kallsyms_cb, obj);
 }
 
-static int find_ksym_btf_id(struct bpf_object *obj, const char *ksym_name,
-			    __u16 kind, struct btf **res_btf,
-			    struct module_btf **res_mod_btf)
-{
-	struct module_btf *mod_btf;
-	struct btf *btf;
-	int i, id, err;
-
-	btf = obj->btf_vmlinux;
-	mod_btf = NULL;
-	id = btf__find_by_name_kind(btf, ksym_name, kind);
-
-	if (id == -ENOENT) {
-		err = load_module_btfs(obj);
-		if (err)
-			return err;
-
-		for (i = 0; i < obj->btf_module_cnt; i++) {
-			/* we assume module_btf's BTF FD is always >0 */
-			mod_btf = &obj->btf_modules[i];
-			btf = mod_btf->btf;
-			id = btf__find_by_name_kind_own(btf, ksym_name, kind);
-			if (id != -ENOENT)
-				break;
-		}
-	}
-	if (id <= 0)
-		return -ESRCH;
-
-	*res_btf = btf;
-	*res_mod_btf = mod_btf;
-	return id;
-}
-
 static int bpf_object__resolve_ksym_var_btf_id(struct bpf_object *obj,
 					       struct extern_desc *ext)
 {
@@ -7744,7 +7763,7 @@ static int bpf_object__resolve_ksym_var_btf_id(struct bpf_object *obj,
 	struct btf *btf = NULL;
 	int id, err;
 
-	id = find_ksym_btf_id(obj, ext->name, BTF_KIND_VAR, &btf, &mod_btf);
+	id = find_kern_btf_id(obj, ext->name, BTF_KIND_VAR, &btf, &mod_btf);
 	if (id < 0) {
 		if (id == -ESRCH && ext->is_weak)
 			return 0;
@@ -7798,7 +7817,7 @@ static int bpf_object__resolve_ksym_func_btf_id(struct bpf_object *obj,
 
 	local_func_proto_id = ext->ksym.type_id;
 
-	kfunc_id = find_ksym_btf_id(obj, ext->essent_name ?: ext->name, BTF_KIND_FUNC, &kern_btf,
+	kfunc_id = find_kern_btf_id(obj, ext->essent_name ?: ext->name, BTF_KIND_FUNC, &kern_btf,
 				    &mod_btf);
 	if (kfunc_id < 0) {
 		if (kfunc_id == -ESRCH && ext->is_weak)
@@ -9464,9 +9483,9 @@ static int libbpf_find_prog_btf_id(const char *name, __u32 attach_prog_fd)
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
 
@@ -9531,7 +9550,7 @@ static int libbpf_find_attach_btf_id(struct bpf_program *prog, const char *attac
 		*btf_obj_fd = 0;
 		*btf_type_id = 1;
 	} else {
-		err = find_kernel_btf_id(prog->obj, attach_name, attach_type, btf_obj_fd, btf_type_id);
+		err = find_kernel_attach_btf_id(prog->obj, attach_name, attach_type, btf_obj_fd, btf_type_id);
 	}
 	if (err) {
 		pr_warn("prog '%s': failed to find kernel BTF type ID of '%s': %d\n",
@@ -12945,9 +12964,9 @@ int bpf_program__set_attach_target(struct bpf_program *prog,
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


