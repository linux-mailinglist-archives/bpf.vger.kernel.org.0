Return-Path: <bpf+bounces-31457-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D6CD18FD45C
	for <lists+bpf@lfdr.de>; Wed,  5 Jun 2024 19:51:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 465D71F21B34
	for <lists+bpf@lfdr.de>; Wed,  5 Jun 2024 17:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7DDC381C7;
	Wed,  5 Jun 2024 17:51:49 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E93E1BC3C
	for <bpf@vger.kernel.org>; Wed,  5 Jun 2024 17:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717609909; cv=none; b=DK9WDvnjjakxw866PCUelr0VWU+StXRRp9527hLLM6i7JdaxsryLSUrp1v4gT9Kvgz6ekCOWYglX/vJ3EIQWEfkM70iuVU5wd8CwEESaOVtKW1C/o+qu05bV+Yu32JTiFV1+fp2XiackdmdW1jG0Pd76YLd64WhZMExoZ2a3gUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717609909; c=relaxed/simple;
	bh=BLgGdA1zpowhE6wUq2azMyMjhyNgiCWoPGlwDBVjbBs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rVp+hfCwnl4K3oDn72v1jmGIa4SXWaqUfL7WJ5jUVAuHx+1Hn/6I/KBFZgXUbAwTDkR0E3AFXwTU+EVlR06YGf/nbGuaeAHM3lg14cK23X+s3+c2mWr+pJWDdh5/iWMdPepvftAxvar9fVDWqIs2uYZjDFkFWh88LPbnwCg+pEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-52b98fb5c32so190488e87.1
        for <bpf@vger.kernel.org>; Wed, 05 Jun 2024 10:51:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717609906; x=1718214706;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+qQix53jRTaSFLOYdXFtja/oDT+KYAVt+Zxj6WPLmNg=;
        b=Pb+0FgNmU+z0jQPc8pyM6R5H/0O60MFyDhQicsEgdBOrrFeUp4MzZvdsRqgwZhfIRt
         ZHYwbSmIQXmouwV/8yYoH6TsRbjoZpjQdkW4rhtEZmNdydX5rWecxLEcR/2aVi0bfeLW
         y/lwA/p/0/4rHFy79tbDdUU+YGKWMY8FHYdALubnUBz9d2AJT6YO+WLE3DBsMWqn1dha
         rh3gA3oaptRIU8n9gQ4RbAULJtr2QSe4iB6m0rcIU/iA7iEpYFs3X9DG+iNAS6LKhfy4
         TFpsHB2IG0LRLxV8KfVNLDyiI1IeiapXtQsI8uTfrSgNIq2uK5wHYNi1DZO1VqMlGTQ3
         k4kg==
X-Gm-Message-State: AOJu0YxBDxoCpZdZnWXRAE4dqKNNAohLCTOTCtKSX4UeizhLyFsoyHwq
	1nlrQ1wbBAfrJzk+nsbOkFHDf53wxpTgV+6Msmjjrazylh5TVq9DpLlEXA==
X-Google-Smtp-Source: AGHT+IGRrVq/kjz5YCR8l11nWC3yEk7P8kBlGYo+1rXwiS2nd1S3pvCzLfyCSEy9sS0bZsRn828N6g==
X-Received: by 2002:a19:ac03:0:b0:52b:a9cd:d2da with SMTP id 2adb3069b0e04-52bab4e554bmr2380894e87.32.1717609905370;
        Wed, 05 Jun 2024 10:51:45 -0700 (PDT)
Received: from yatsenko-fedora-K2202N0103767.thefacebook.com ([2620:10d:c092:500::5:be0])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6c71fd73fdsm51726566b.141.2024.06.05.10.51.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 10:51:44 -0700 (PDT)
From: Mykyta@web.codeaurora.org, Yatsenko@web.codeaurora.org,
	mykyta.yatsenko5@gmail.com
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next] libbpf: auto-attach skeletons struct_ops
Date: Wed,  5 Jun 2024 18:51:35 +0100
Message-ID: <20240605175135.117127-1-yatsenko@meta.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mykyta Yatsenko <yatsenko@meta.com>

Similarly to `bpf_program`, support `bpf_map` automatic attachment in
`bpf_object__attach_skeleton`. Currently only struct_ops maps could be
attached.

Bpftool
Code-generate links in skeleton struct for struct_ops maps.
Similarly to `bpf_program_skeleton`, set links in `bpf_map_skeleton`.

Libbpf
Extending `bpf_map` with new `autoattach` field to support enabling or
disabling autoattach functionality, introducing getter/setter for this
field.
Extending `bpf_object__(attach|detach)_skeleton` with
attaching/detaching struct_ops maps.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 tools/bpf/bpftool/gen.c  | 36 +++++++++++++++++++---
 tools/lib/bpf/libbpf.c   | 65 ++++++++++++++++++++++++++++++++++++++--
 tools/lib/bpf/libbpf.h   | 20 +++++++++++++
 tools/lib/bpf/libbpf.map |  2 ++
 4 files changed, 116 insertions(+), 7 deletions(-)

diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
index b3979ddc0189..a8d4db0d8044 100644
--- a/tools/bpf/bpftool/gen.c
+++ b/tools/bpf/bpftool/gen.c
@@ -848,7 +848,7 @@ static int gen_trace(struct bpf_object *obj, const char *obj_name, const char *h
 }
 
 static void
-codegen_maps_skeleton(struct bpf_object *obj, size_t map_cnt, bool mmaped)
+codegen_maps_skeleton(struct bpf_object *obj, size_t map_cnt, bool mmaped, bool populate_links)
 {
 	struct bpf_map *map;
 	char ident[256];
@@ -888,6 +888,14 @@ codegen_maps_skeleton(struct bpf_object *obj, size_t map_cnt, bool mmaped)
 			printf("\ts->maps[%zu].mmaped = (void **)&obj->%s;\n",
 				i, ident);
 		}
+
+		if (populate_links && bpf_map__type(map) == BPF_MAP_TYPE_STRUCT_OPS) {
+			codegen("\
+				\n\
+					s->maps[%zu].link = &obj->links.%s;\n\
+				",
+				i, ident);
+		}
 		i++;
 	}
 }
@@ -1141,7 +1149,7 @@ static void gen_st_ops_shadow_init(struct btf *btf, struct bpf_object *obj)
 static int do_skeleton(int argc, char **argv)
 {
 	char header_guard[MAX_OBJ_NAME_LEN + sizeof("__SKEL_H__")];
-	size_t map_cnt = 0, prog_cnt = 0, file_sz, mmap_sz;
+	size_t map_cnt = 0, prog_cnt = 0, attach_map_cnt = 0, file_sz, mmap_sz;
 	DECLARE_LIBBPF_OPTS(bpf_object_open_opts, opts);
 	char obj_name[MAX_OBJ_NAME_LEN] = "", *obj_data;
 	struct bpf_object *obj = NULL;
@@ -1225,6 +1233,10 @@ static int do_skeleton(int argc, char **argv)
 			      bpf_map__name(map));
 			continue;
 		}
+
+		if (bpf_map__type(map) == BPF_MAP_TYPE_STRUCT_OPS)
+			attach_map_cnt++;
+
 		map_cnt++;
 	}
 	bpf_object__for_each_program(prog, obj) {
@@ -1297,6 +1309,9 @@ static int do_skeleton(int argc, char **argv)
 				       bpf_program__name(prog));
 		}
 		printf("\t} progs;\n");
+	}
+
+	if (prog_cnt + attach_map_cnt) {
 		printf("\tstruct {\n");
 		bpf_object__for_each_program(prog, obj) {
 			if (use_loader)
@@ -1306,6 +1321,19 @@ static int do_skeleton(int argc, char **argv)
 				printf("\t\tstruct bpf_link *%s;\n",
 				       bpf_program__name(prog));
 		}
+
+		bpf_object__for_each_map(map, obj) {
+			if (!get_map_ident(map, ident, sizeof(ident)))
+				continue;
+			if (bpf_map__type(map) != BPF_MAP_TYPE_STRUCT_OPS)
+				continue;
+
+			if (use_loader)
+				printf("t\tint %s_fd;\n", ident);
+			else
+				printf("\t\tstruct bpf_link *%s;\n", ident);
+		}
+
 		printf("\t} links;\n");
 	}
 
@@ -1448,7 +1476,7 @@ static int do_skeleton(int argc, char **argv)
 		obj_name
 	);
 
-	codegen_maps_skeleton(obj, map_cnt, true /*mmaped*/);
+	codegen_maps_skeleton(obj, map_cnt, true /*mmaped*/, true /*links*/);
 	codegen_progs_skeleton(obj, prog_cnt, true /*populate_links*/);
 
 	codegen("\
@@ -1786,7 +1814,7 @@ static int do_subskeleton(int argc, char **argv)
 		}
 	}
 
-	codegen_maps_skeleton(obj, map_cnt, false /*mmaped*/);
+	codegen_maps_skeleton(obj, map_cnt, false /*mmaped*/, false /*links*/);
 	codegen_progs_skeleton(obj, prog_cnt, false /*links*/);
 
 	codegen("\
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index d1627a2ca30b..ba9cb939c654 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -573,6 +573,7 @@ struct bpf_map {
 	bool reused;
 	bool autocreate;
 	__u64 map_extra;
+	bool autoattach;
 };
 
 enum extern_type {
@@ -1400,6 +1401,7 @@ static int init_struct_ops_maps(struct bpf_object *obj, const char *sec_name,
 		map->def.value_size = type->size;
 		map->def.max_entries = 1;
 		map->def.map_flags = strcmp(sec_name, STRUCT_OPS_LINK_SEC) == 0 ? BPF_F_LINK : 0;
+		map->autoattach = true;
 
 		map->st_ops = calloc(1, sizeof(*map->st_ops));
 		if (!map->st_ops)
@@ -4819,6 +4821,20 @@ int bpf_map__set_autocreate(struct bpf_map *map, bool autocreate)
 	return 0;
 }
 
+int bpf_map__set_autoattach(struct bpf_map *map, bool autoattach)
+{
+	if (!bpf_map__is_struct_ops(map))
+		return libbpf_err(-EINVAL);
+
+	map->autoattach = autoattach;
+	return 0;
+}
+
+bool bpf_map__autoattach(const struct bpf_map *map)
+{
+	return map->autoattach;
+}
+
 int bpf_map__reuse_fd(struct bpf_map *map, int fd)
 {
 	struct bpf_map_info info;
@@ -12900,8 +12916,10 @@ struct bpf_link *bpf_map__attach_struct_ops(const struct bpf_map *map)
 	__u32 zero = 0;
 	int err, fd;
 
-	if (!bpf_map__is_struct_ops(map))
+	if (!bpf_map__is_struct_ops(map)) {
+		pr_warn("map '%s': can't attach non-struct_ops map\n", map->name);
 		return libbpf_err_ptr(-EINVAL);
+	}
 
 	if (map->fd < 0) {
 		pr_warn("map '%s': can't attach BPF map without FD (was it created?)\n", map->name);
@@ -13945,6 +13963,36 @@ int bpf_object__attach_skeleton(struct bpf_object_skeleton *s)
 		 */
 	}
 
+	/* Skeleton is created with earlier version of bpftool
+	 * which does not support auto-attachment
+	 */
+	if (s->map_skel_sz < sizeof(struct bpf_map_skeleton))
+		return 0;
+
+	for (i = 0; i < s->map_cnt; i++) {
+		struct bpf_map *map = *s->maps[i].map;
+		struct bpf_link **link = s->maps[i].link;
+
+		if (!map->autocreate || !map->autoattach)
+			continue;
+
+		if (*link)
+			continue;
+
+		/* only struct_ops maps can be attached */
+		if (!bpf_map__is_struct_ops(map))
+			continue;
+		*link = bpf_map__attach_struct_ops(map);
+
+		if (!*link) {
+			const int errcode = errno;
+
+			pr_warn("struct_ops %s: failed to auto-attach: %d\n", bpf_map__name(map),
+				errcode);
+			return libbpf_err(-errcode);
+		}
+	}
+
 	return 0;
 }
 
@@ -13958,6 +14006,18 @@ void bpf_object__detach_skeleton(struct bpf_object_skeleton *s)
 		bpf_link__destroy(*link);
 		*link = NULL;
 	}
+
+	if (s->map_skel_sz < sizeof(struct bpf_map_skeleton))
+		return;
+
+	for (i = 0; i < s->map_cnt; i++) {
+		struct bpf_link **link = s->maps[i].link;
+
+		if (link) {
+			bpf_link__destroy(*link);
+			*link = NULL;
+		}
+	}
 }
 
 void bpf_object__destroy_skeleton(struct bpf_object_skeleton *s)
@@ -13965,8 +14025,7 @@ void bpf_object__destroy_skeleton(struct bpf_object_skeleton *s)
 	if (!s)
 		return;
 
-	if (s->progs)
-		bpf_object__detach_skeleton(s);
+	bpf_object__detach_skeleton(s);
 	if (s->obj)
 		bpf_object__close(*s->obj);
 	free(s->maps);
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 26e4e35528c5..641d6ec876e2 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -978,6 +978,25 @@ bpf_object__prev_map(const struct bpf_object *obj, const struct bpf_map *map);
 LIBBPF_API int bpf_map__set_autocreate(struct bpf_map *map, bool autocreate);
 LIBBPF_API bool bpf_map__autocreate(const struct bpf_map *map);
 
+/**
+ * @brief **bpf_map__set_autoattach()** sets whether libbpf has to auto-attach
+ * map during BPF skeleton attach phase.
+ * @param map the BPF map instance
+ * @param autoattach whether to attach map during BPF skeleton attach phase
+ * @return 0 on success; negative error code, otherwise
+ *
+ */
+LIBBPF_API int bpf_map__set_autoattach(struct bpf_map *map, bool autoattach);
+
+/**
+ * @brief **bpf_map__autoattach()** returns whether BPF map is configured to
+ * auto-attach during BPF skeleton attach phase.
+ * @param map the BPF map instance
+ * @return true if map is set to auto-attach during skeleton attach phase; false otherwise
+ *
+ */
+LIBBPF_API bool bpf_map__autoattach(const struct bpf_map *map);
+
 /**
  * @brief **bpf_map__fd()** gets the file descriptor of the passed
  * BPF map
@@ -1672,6 +1691,7 @@ struct bpf_map_skeleton {
 	const char *name;
 	struct bpf_map **map;
 	void **mmaped;
+	struct bpf_link **link;
 };
 
 struct bpf_prog_skeleton {
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index c1ce8aa3520b..40595233dc7f 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -419,6 +419,8 @@ LIBBPF_1.4.0 {
 
 LIBBPF_1.5.0 {
 	global:
+		bpf_map__autoattach;
+		bpf_map__set_autoattach;
 		bpf_program__attach_sockmap;
 		ring__consume_n;
 		ring_buffer__consume_n;
-- 
2.45.0


