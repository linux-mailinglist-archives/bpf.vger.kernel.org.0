Return-Path: <bpf+bounces-35541-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E4C193B5A3
	for <lists+bpf@lfdr.de>; Wed, 24 Jul 2024 19:15:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C989A2849AF
	for <lists+bpf@lfdr.de>; Wed, 24 Jul 2024 17:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2431E16078E;
	Wed, 24 Jul 2024 17:15:10 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE9BB15FA75;
	Wed, 24 Jul 2024 17:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721841309; cv=none; b=oOiLbwOtSq6RdY3yecwI0766MnW1i8ciNJI72wIByjH42OKesEHkNXGzCVrW0tvDaU0/HC5CuoIreO6kvVnQUunUmRJrZSUaiep7oJW7Y61mGmAg8wG79cRVeKYmnYfpSU0+r1JATSipxrSblGDzSC6gvxzsbzNpIBz7dFSCf+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721841309; c=relaxed/simple;
	bh=4Y680e5aFGG+XL2Ues7O7Kcgc/asuH8oob0hp9mjLFo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RB3mkQFwMuGM2UcJvZw5vx+8f2lGJIsRjTJkaUxB9pgQhM3n1ZQMsNTkmWpNI1ZJaawxDgirYEO8Xy0UnG/1OIa68ydwUhZBPngYIavjd8UE12bszJiWP7svSFL3G1SJFOqZlsjl0KpcfigYI/wncFMqkJEnsKnMWadWB0kBbm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5c691c6788eso45318eaf.2;
        Wed, 24 Jul 2024 10:15:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721841307; x=1722446107;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SANNCjmlHWFw4UMMmTMFqu6vy/gGRDN3h4twfSNMm0w=;
        b=vPuVBwXiyDmLO/AbFbGlgkS1lkwfGc3PaGoU1lhWCHN3n0wj8ZjChWGl0jrlpImC3L
         b+ROwsxnkxvZIZI5HoO81hXoJAhRKYNnyKZKyHGy9yvG8uZTvJBiqKAGHDMZsIhJJEYY
         hrp5z955hkkaT71FXcZBkQqgytya/yYWQDcrHuDSE2+rRClJeBQ5Ecv5eGCPOwdM97Qq
         ApBOwEKDIkRvRiFzr/Z1nYLp4n4bLFN2W8buIJd3OVDzXVnEHILIxX39PKNpwMPa8Q1W
         fUIsKdrFqdbIVmEf6+mbCjtL7H8nod/FVEebxDhkc1+QRsfjEc5K3mKGrYmHGv18hJX0
         xJyA==
X-Forwarded-Encrypted: i=1; AJvYcCVqbd9jp/kPYxbf7hX2Ro6qosWEBLmYoUZuEd1dD5ArVeYJzSML/En5AQIU+Z4vQ8q3o9GVhcOEfMdx6VxSwIGZSNqKT5pUyIWZSJdp
X-Gm-Message-State: AOJu0YxUMGo6HpyLe2upFRo52uNVvUhTsRLeN9jXn57IutxIbhWVV8/t
	ipGnviMYiKTea/dDVMXahmS/Hrw05PgcBg7gLT3ps3n4kLLTa8q97qLbSRvU
X-Google-Smtp-Source: AGHT+IGkH1yvj+YalApyjPBW8ivSd8WosXSoBQyIc+qMhvcMQQFW+LWldt69bJEtwTg73xBJsTr1RQ==
X-Received: by 2002:a05:6358:3413:b0:197:df0e:f23c with SMTP id e5c5f4694b2df-1acf8a1cd19mr63633955d.11.1721841306439;
        Wed, 24 Jul 2024 10:15:06 -0700 (PDT)
Received: from localhost (c-76-141-129-107.hsd1.il.comcast.net. [76.141.129.107])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b96f7f79d3sm37517716d6.91.2024.07.24.10.15.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 10:15:05 -0700 (PDT)
From: David Vernet <void@manifault.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	tj@kernel.org
Subject: [PATCH bpf-next 1/2] libbpf: Don't take direct pointers into BTF data from st_ops
Date: Wed, 24 Jul 2024 12:14:58 -0500
Message-ID: <20240724171459.281234-1-void@manifault.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In struct bpf_struct_ops, we have take a pointer to a BTF type name, and
a struct btf_type. This was presumably done for convenience, but can
actually result in subtle and confusing bugs given that BTF data can be
invalidated before a program is loaded. For example, in sched_ext, we
may sometimes resize a data section after a skeleton has been opened,
but before the struct_ops scheduler map has been loaded. This may cause
the BTF data to be realloc'd, which can then cause a UAF when loading
the program because the struct_ops map has pointers directly into the
BTF data.

We're already storing the BTF type_id in struct bpf_struct_ops. Because
type_id is stable, we can therefore just update the places where we were
looking at those pointers to instead do the lookups we need from the
type_id.

Fixes: 590a00888250 ("bpf: libbpf: Add STRUCT_OPS support")
Signed-off-by: David Vernet <void@manifault.com>
---
 tools/lib/bpf/libbpf.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index a3be6f8fac09..e55353887439 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -496,8 +496,6 @@ struct bpf_program {
 };
 
 struct bpf_struct_ops {
-	const char *tname;
-	const struct btf_type *type;
 	struct bpf_program **progs;
 	__u32 *kern_func_off;
 	/* e.g. struct tcp_congestion_ops in bpf_prog's btf format */
@@ -1083,11 +1081,14 @@ static int bpf_object_adjust_struct_ops_autoload(struct bpf_object *obj)
 			continue;
 
 		for (j = 0; j < obj->nr_maps; ++j) {
+			const struct btf_type *type;
+
 			map = &obj->maps[j];
 			if (!bpf_map__is_struct_ops(map))
 				continue;
 
-			vlen = btf_vlen(map->st_ops->type);
+			type = btf__type_by_id(obj->btf, map->st_ops->type_id);
+			vlen = btf_vlen(type);
 			for (k = 0; k < vlen; ++k) {
 				slot_prog = map->st_ops->progs[k];
 				if (prog != slot_prog)
@@ -1121,8 +1122,8 @@ static int bpf_map__init_kern_struct_ops(struct bpf_map *map)
 	int err;
 
 	st_ops = map->st_ops;
-	type = st_ops->type;
-	tname = st_ops->tname;
+	type = btf__type_by_id(btf, st_ops->type_id);
+	tname = btf__name_by_offset(btf, type->name_off);
 	err = find_struct_ops_kern_types(obj, tname, &mod_btf,
 					 &kern_type, &kern_type_id,
 					 &kern_vtype, &kern_vtype_id,
@@ -1423,8 +1424,6 @@ static int init_struct_ops_maps(struct bpf_object *obj, const char *sec_name,
 		memcpy(st_ops->data,
 		       data->d_buf + vsi->offset,
 		       type->size);
-		st_ops->tname = tname;
-		st_ops->type = type;
 		st_ops->type_id = type_id;
 
 		pr_debug("struct_ops init: struct %s(type_id=%u) %s found at offset %u\n",
@@ -8445,11 +8444,13 @@ static int bpf_object__resolve_externs(struct bpf_object *obj,
 
 static void bpf_map_prepare_vdata(const struct bpf_map *map)
 {
+	const struct btf_type *type;
 	struct bpf_struct_ops *st_ops;
 	__u32 i;
 
 	st_ops = map->st_ops;
-	for (i = 0; i < btf_vlen(st_ops->type); i++) {
+	type = btf__type_by_id(map->obj->btf, st_ops->type_id);
+	for (i = 0; i < btf_vlen(type); i++) {
 		struct bpf_program *prog = st_ops->progs[i];
 		void *kern_data;
 		int prog_fd;
@@ -9712,6 +9713,7 @@ static struct bpf_map *find_struct_ops_map_by_offset(struct bpf_object *obj,
 static int bpf_object__collect_st_ops_relos(struct bpf_object *obj,
 					    Elf64_Shdr *shdr, Elf_Data *data)
 {
+	const struct btf_type *type;
 	const struct btf_member *member;
 	struct bpf_struct_ops *st_ops;
 	struct bpf_program *prog;
@@ -9771,13 +9773,14 @@ static int bpf_object__collect_st_ops_relos(struct bpf_object *obj,
 		}
 		insn_idx = sym->st_value / BPF_INSN_SZ;
 
-		member = find_member_by_offset(st_ops->type, moff * 8);
+		type = btf__type_by_id(btf, st_ops->type_id);
+		member = find_member_by_offset(type, moff * 8);
 		if (!member) {
 			pr_warn("struct_ops reloc %s: cannot find member at moff %u\n",
 				map->name, moff);
 			return -EINVAL;
 		}
-		member_idx = member - btf_members(st_ops->type);
+		member_idx = member - btf_members(type);
 		name = btf__name_by_offset(btf, member->name_off);
 
 		if (!resolve_func_ptr(btf, member->type, NULL)) {
-- 
2.45.2


