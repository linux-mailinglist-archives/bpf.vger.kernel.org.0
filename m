Return-Path: <bpf+bounces-19785-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E63D831116
	for <lists+bpf@lfdr.de>; Thu, 18 Jan 2024 02:51:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 101821C21D55
	for <lists+bpf@lfdr.de>; Thu, 18 Jan 2024 01:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 505DA9476;
	Thu, 18 Jan 2024 01:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G7bKqv8T"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F1098F67
	for <bpf@vger.kernel.org>; Thu, 18 Jan 2024 01:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705542606; cv=none; b=hCuYMjPFjgw/TjGoXVdI+cH0TAiODs6b2oXUTUBhrSIZzb1kiCCDNIOqlhuF2oCqYaJ5IoKjuNNvCK3fHvN85zfAsdqBHejUwPFhikIeyX/cflEHQwWJ+V3xy6ofGNfezjj/aUP4jkg/07Uew7CFznnpmEp/gCRoIYvHz+SlnQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705542606; c=relaxed/simple;
	bh=ujTTC1QvWPZdRdqKzNzrhwwiLxXuFR9mmb7ab1O/4UU=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:From:
	 To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding; b=TU1XFT1akascln/jj42VghXYhVblNWkZjC15LoU2JW6vxcq3+m1Pq7IT3/MJcEsv4KvIlp4s558ncriUDV4TAzNBqLGxvNHO+6vlprCSh+AwnuUrbIC53/JrrBrGOsX0fsryfhHv/dQCTgOEK/gdInYlmF6tMvG8EEx7aN56SCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G7bKqv8T; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-5ff828b93f0so4431707b3.3
        for <bpf@vger.kernel.org>; Wed, 17 Jan 2024 17:50:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705542604; x=1706147404; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XWorhE91exuesnp0l3cNzkw3ftaMNHgcCmrux9EtVTY=;
        b=G7bKqv8TL9n9EwSiMOhjMGtMXuhqnj+n9FPIWwobYGvotxJIA2W0/hWWqb0pb/BMyN
         j0E5smR8n/AniDfG4TzDih0DyGc+aUF2Yd0rgFsxoHhTBtaIM+M5eEy383nYkG2wIBEI
         DOtO3gsjkiaIjDDlpIn0IqtqavUTs0R6hsgyxcC2pNQf2aSHNtru6rdarAoKO5ukphAq
         uOqmr4kA5IxC/cXDPMXjSpDHfRAy34UlQMcKTYgImoXWHVPXxBzaJQwWz+mW4RXVoxoT
         qu624u7Pe75CUkOyJdk3pKal7SOoNMvoUd9PI9diUwn8DkPXpP3/2NP9FWSM9cRZrtrO
         PeiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705542604; x=1706147404;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XWorhE91exuesnp0l3cNzkw3ftaMNHgcCmrux9EtVTY=;
        b=Gl74ADr8pOgE2heFlKXThNzc0Y4eDHLuASHmO6H2jNbmRb2XZR49BzJLa4B4YJiBmX
         JNwzX72YzKz8pClTIyBsV9i43RKaaBigOXh6JwpXPtLc5b4OhrmdVEojcLk6WLids2uW
         YmUZbG2DVrEr4j/AkdU69IRKR+ix5J1hStOt6wkAoIVAvYeDxeRjAx7DLzXBW6lFldw1
         Nq1MFRe84AHWsQ0KrpTK1sniajEx/qESDGplJHQKcxp6264lrkGYZwMxKVISkcaXLeBU
         9cfeU4JiyzJo0KEerb/SafXQ1OCDo21SLAYrQN+TdxiTPPHJg2OnS3gSqQ4wlCN2oouR
         nA6Q==
X-Gm-Message-State: AOJu0YwTM7AjvblyOEOHn37lzG3G8hderAKlpw7SODHLnd/mzbKof0JD
	PLcw1seeDFnUIr7Z9H0TM4F/gOBZlMVFXh/1TJIDIR7yNI8z+u1AJ2d09nSH
X-Google-Smtp-Source: AGHT+IHkce2+P69wgMbeuH7r9JLLU25qus4ZzDNcEY0xRQD2VYnSHTw82DWuAFs07pIo4VmQJXLlyw==
X-Received: by 2002:a0d:c905:0:b0:5ff:638f:441e with SMTP id l5-20020a0dc905000000b005ff638f441emr122540ywd.103.1705542603880;
        Wed, 17 Jan 2024 17:50:03 -0800 (PST)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:8b90:cd6a:b588:8d99])
        by smtp.gmail.com with ESMTPSA id cb9-20020a05690c090900b005e5fff5c537sm6248606ywb.85.2024.01.17.17.50.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jan 2024 17:50:03 -0800 (PST)
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
Subject: [PATCH bpf-next v16 12/14] libbpf: Find correct module BTFs for struct_ops maps and progs.
Date: Wed, 17 Jan 2024 17:49:28 -0800
Message-Id: <20240118014930.1992551-13-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240118014930.1992551-1-thinker.li@gmail.com>
References: <20240118014930.1992551-1-thinker.li@gmail.com>
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
 tools/lib/bpf/bpf.c           |  4 +++-
 tools/lib/bpf/bpf.h           |  4 +++-
 tools/lib/bpf/libbpf.c        | 41 ++++++++++++++++++++++++++---------
 tools/lib/bpf/libbpf_probes.c |  1 +
 4 files changed, 38 insertions(+), 12 deletions(-)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index 9dc9625651dc..3a35472a17c5 100644
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
+	attr.value_type_btf_obj_fd = OPTS_GET(opts, value_type_btf_obj_fd, -1);
 
 	attr.inner_map_fd = OPTS_GET(opts, inner_map_fd, 0);
 	attr.map_flags = OPTS_GET(opts, map_flags, 0);
diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index d0f53772bdc0..53b0bee053ad 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -51,8 +51,10 @@ struct bpf_map_create_opts {
 
 	__u32 numa_node;
 	__u32 map_ifindex;
+	__s32 value_type_btf_obj_fd;
+	size_t:0;
 };
-#define bpf_map_create_opts__last_field map_ifindex
+#define bpf_map_create_opts__last_field value_type_btf_obj_fd
 
 LIBBPF_API int bpf_map_create(enum bpf_map_type map_type,
 			      const char *map_name,
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index c5a42ac309fd..4ee5e9412ddc 100644
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
 
+	map->mod_btf_fd = mod_btf ? mod_btf->fd : -1;
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
@@ -5161,8 +5175,13 @@ static int bpf_object__create_map(struct bpf_object *obj, struct bpf_map *map, b
 	create_attr.numa_node = map->numa_node;
 	create_attr.map_extra = map->map_extra;
 
-	if (bpf_map__is_struct_ops(map))
+	if (bpf_map__is_struct_ops(map)) {
 		create_attr.btf_vmlinux_value_type_id = map->btf_vmlinux_value_type_id;
+		if (map->mod_btf_fd >= 0) {
+			create_attr.value_type_btf_obj_fd = map->mod_btf_fd;
+			create_attr.map_flags |= BPF_F_VTYPE_BTF_OBJ_FD;
+		}
+	}
 
 	if (obj->btf && btf__fd(obj->btf) >= 0) {
 		create_attr.btf_fd = btf__fd(obj->btf);
@@ -9842,7 +9861,9 @@ static int libbpf_find_attach_btf_id(struct bpf_program *prog, const char *attac
 		*btf_obj_fd = 0;
 		*btf_type_id = 1;
 	} else {
-		err = find_kernel_btf_id(prog->obj, attach_name, attach_type, btf_obj_fd, btf_type_id);
+		err = find_kernel_btf_id(prog->obj, attach_name,
+					 attach_type, btf_obj_fd,
+					 btf_type_id);
 	}
 	if (err) {
 		pr_warn("prog '%s': failed to find kernel BTF type ID of '%s': %d\n",
diff --git a/tools/lib/bpf/libbpf_probes.c b/tools/lib/bpf/libbpf_probes.c
index 9c4db90b92b6..98373d126d9d 100644
--- a/tools/lib/bpf/libbpf_probes.c
+++ b/tools/lib/bpf/libbpf_probes.c
@@ -326,6 +326,7 @@ static int probe_map_create(enum bpf_map_type map_type)
 	case BPF_MAP_TYPE_STRUCT_OPS:
 		/* we'll get -ENOTSUPP for invalid BTF type ID for struct_ops */
 		opts.btf_vmlinux_value_type_id = 1;
+		opts.value_type_btf_obj_fd = -1;
 		exp_err = -524; /* -ENOTSUPP */
 		break;
 	case BPF_MAP_TYPE_BLOOM_FILTER:
-- 
2.34.1


