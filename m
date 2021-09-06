Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D113401EBF
	for <lists+bpf@lfdr.de>; Mon,  6 Sep 2021 18:55:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230491AbhIFQ4R (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 6 Sep 2021 12:56:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240965AbhIFQ4R (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 6 Sep 2021 12:56:17 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02146C0613C1
        for <bpf@vger.kernel.org>; Mon,  6 Sep 2021 09:55:12 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id x7so5114873pfa.8
        for <bpf@vger.kernel.org>; Mon, 06 Sep 2021 09:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CJT5PxswcReZ9BJw/EMCO9yiA2qfftOvKk2B3zyNA2o=;
        b=JUhjk/3cZiRRzvQ0FncujpW8atNuTd8UwdZdBgbGfkt311AC9ROCWHtiPtfrNaq7cM
         hl5rNz7xw25x5SnWeZZ+DszPgd3f11IyXORLF/7uwyPOHwrfmATKrA/W1S0HWcg1cBMk
         hDOIHJkqBnPpDFujgN5/tMFXsg4BDrrn9jL4EQieVC9ptb0m9NNf94tn5ubN225aA6/7
         s1+2eeforwlFo7oN7RUF02IWJzJH0XZ0dR93F1PrIGlwPa6Us6iId9WcU/RS/QNV0Hs4
         a/6CcB2CwmJ8wDKwVVQ/GSmJNX3x2WmgkUG9buJbcU+Shw4GROXRcLfXadN4gjEk1k7T
         iMWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CJT5PxswcReZ9BJw/EMCO9yiA2qfftOvKk2B3zyNA2o=;
        b=hJHEjKkWdYlssaoZecBzERuuxtoKufuVEAkFkzS6xTaOgv56uPnnYc6d4OHA+W4dQH
         KV0ZcAYAebqI1T9J4k6g+e8s42nu5RkPZf42sVY7Aor2oDrrbXsVhrbfcuM6a2EnvzLx
         9fcdytrbgze8oOzje7v8kQkVrh5hi0na9k5LPwOz7cGW9BptF2etbgkLGAq/7wCDuhUs
         WwhdlCKfTnp1gQwh+QlQrSpzXShK9s7i+E/YK5C2Xfg6seZhkCFK8b1mLjE8Vsqk3lnj
         LlCxm83t8ZsJ2M+LoEzmLZ+C5HLY2rMMO+b4zhiJUYbX5FVGJIdNqcL7Sh8ObbZtBALE
         iiSA==
X-Gm-Message-State: AOAM533lggOJGl1HGwmSJzRyE39F62pQUDTaNzLiVoYEezVrJPTRjiJ9
        y0vIF1Nu83xQ5F/qZkLgx4P9K6suFEBrkQ==
X-Google-Smtp-Source: ABdhPJyQKGtMzajUkYiT6VakOAXg0o7vRhU5fywf6ad6Y/MRh5LHOea9jJHc6AHKrDHFjNCcaxsyDg==
X-Received: by 2002:a65:47cd:: with SMTP id f13mr13011490pgs.439.1630947311399;
        Mon, 06 Sep 2021 09:55:11 -0700 (PDT)
Received: from localhost.localdomain ([119.28.83.143])
        by smtp.gmail.com with ESMTPSA id d8sm38189pjr.17.2021.09.06.09.55.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Sep 2021 09:55:11 -0700 (PDT)
From:   Hengqi Chen <hengqi.chen@gmail.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, hengqi.chen@gmail.com
Subject: [PATCH bpf-next 1/2] libbpf: Deprecate bpf_{map,program}__{prev,next} APIs
Date:   Tue,  7 Sep 2021 00:54:55 +0800
Message-Id: <20210906165456.325999-1-hengqi.chen@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Deprecate bpf_{map,program}__{prev,next} APIs. Replace them with
a new set of APIs named bpf_object__{prev,next}_{program,map} which
follow the libbpf API naming convention. No functionality changes.

Closes: https://github.com/libbpf/libbpf/issues/296
Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
---
 tools/lib/bpf/libbpf.c   | 24 ++++++++++++++++++------
 tools/lib/bpf/libbpf.h   | 30 ++++++++++++++++++++----------
 tools/lib/bpf/libbpf.map |  4 ++++
 3 files changed, 42 insertions(+), 16 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 88d8825fc6f6..8d82853fb4a0 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -7347,7 +7347,7 @@ int bpf_object__pin_maps(struct bpf_object *obj, const char *path)
 	return 0;

 err_unpin_maps:
-	while ((map = bpf_map__prev(map, obj))) {
+	while ((map = bpf_object__prev_map(map, obj))) {
 		if (!map->pin_path)
 			continue;

@@ -7427,7 +7427,7 @@ int bpf_object__pin_programs(struct bpf_object *obj, const char *path)
 	return 0;

 err_unpin_programs:
-	while ((prog = bpf_program__prev(prog, obj))) {
+	while ((prog = bpf_object__prev_program(prog, obj))) {
 		char buf[PATH_MAX];
 		int len;

@@ -7666,8 +7666,11 @@ __bpf_program__iter(const struct bpf_program *p, const struct bpf_object *obj,
 	return &obj->programs[idx];
 }

+__attribute__((alias("bpf_object__next_program")))
+struct bpf_program *bpf_program__next(struct bpf_program *prev, const struct bpf_object *obj);
+
 struct bpf_program *
-bpf_program__next(struct bpf_program *prev, const struct bpf_object *obj)
+bpf_object__next_program(struct bpf_program *prev, const struct bpf_object *obj)
 {
 	struct bpf_program *prog = prev;

@@ -7678,8 +7681,11 @@ bpf_program__next(struct bpf_program *prev, const struct bpf_object *obj)
 	return prog;
 }

+__attribute__((alias("bpf_object__prev_program")))
+struct bpf_program *bpf_program__prev(struct bpf_program *next, const struct bpf_object *obj);
+
 struct bpf_program *
-bpf_program__prev(struct bpf_program *next, const struct bpf_object *obj)
+bpf_object__prev_program(struct bpf_program *next, const struct bpf_object *obj)
 {
 	struct bpf_program *prog = next;

@@ -8698,8 +8704,11 @@ __bpf_map__iter(const struct bpf_map *m, const struct bpf_object *obj, int i)
 	return &obj->maps[idx];
 }

+__attribute__((alias("bpf_object__next_map")))
+struct bpf_map *bpf_map__next(const struct bpf_map *prev, const struct bpf_object *obj);
+
 struct bpf_map *
-bpf_map__next(const struct bpf_map *prev, const struct bpf_object *obj)
+bpf_object__next_map(const struct bpf_map *prev, const struct bpf_object *obj)
 {
 	if (prev == NULL)
 		return obj->maps;
@@ -8707,8 +8716,11 @@ bpf_map__next(const struct bpf_map *prev, const struct bpf_object *obj)
 	return __bpf_map__iter(prev, obj, 1);
 }

+__attribute__((alias("bpf_object__prev_map")))
+struct bpf_map *bpf_map__prev(const struct bpf_map *next, const struct bpf_object *obj);
+
 struct bpf_map *
-bpf_map__prev(const struct bpf_map *next, const struct bpf_object *obj)
+bpf_object__prev_map(const struct bpf_map *next, const struct bpf_object *obj)
 {
 	if (next == NULL) {
 		if (!obj->nr_maps)
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index f177d897c5f7..e6aab4cd263b 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -186,16 +186,22 @@ LIBBPF_API int libbpf_find_vmlinux_btf_id(const char *name,

 /* Accessors of bpf_program */
 struct bpf_program;
-LIBBPF_API struct bpf_program *bpf_program__next(struct bpf_program *prog,
+LIBBPF_API LIBBPF_DEPRECATED("bpf_program__next() is deprecated, use bpf_object__next_program() instead")
+struct bpf_program *bpf_program__next(struct bpf_program *prog,
 						 const struct bpf_object *obj);
+LIBBPF_API struct bpf_program *bpf_object__next_program(struct bpf_program *prog,
+							const struct bpf_object *obj);

-#define bpf_object__for_each_program(pos, obj)		\
-	for ((pos) = bpf_program__next(NULL, (obj));	\
-	     (pos) != NULL;				\
-	     (pos) = bpf_program__next((pos), (obj)))
+#define bpf_object__for_each_program(pos, obj)			\
+	for ((pos) = bpf_object__next_program(NULL, (obj));	\
+	     (pos) != NULL;					\
+	     (pos) = bpf_object__next_program((pos), (obj)))

-LIBBPF_API struct bpf_program *bpf_program__prev(struct bpf_program *prog,
+LIBBPF_API LIBBPF_DEPRECATED("bpf_program__prev() is deprecated, use bpf_object__prev_program() instead")
+struct bpf_program *bpf_program__prev(struct bpf_program *prog,
 						 const struct bpf_object *obj);
+LIBBPF_API struct bpf_program *bpf_object__prev_program(struct bpf_program *prog,
+							const struct bpf_object *obj);

 typedef void (*bpf_program_clear_priv_t)(struct bpf_program *, void *);

@@ -495,16 +501,20 @@ bpf_object__find_map_fd_by_name(const struct bpf_object *obj, const char *name);
 LIBBPF_API struct bpf_map *
 bpf_object__find_map_by_offset(struct bpf_object *obj, size_t offset);

+LIBBPF_API LIBBPF_DEPRECATED("bpf_map__next() is deprecated, use bpf_object__next_map() instead")
+struct bpf_map *bpf_map__next(const struct bpf_map *map, const struct bpf_object *obj);
 LIBBPF_API struct bpf_map *
-bpf_map__next(const struct bpf_map *map, const struct bpf_object *obj);
+bpf_object__next_map(const struct bpf_map *map, const struct bpf_object *obj);
 #define bpf_object__for_each_map(pos, obj)		\
-	for ((pos) = bpf_map__next(NULL, (obj));	\
+	for ((pos) = bpf_object__next_map(NULL, (obj));	\
 	     (pos) != NULL;				\
-	     (pos) = bpf_map__next((pos), (obj)))
+	     (pos) = bpf_object__next_map((pos), (obj)))
 #define bpf_map__for_each bpf_object__for_each_map

+LIBBPF_API LIBBPF_DEPRECATED("bpf_map__prev() is deprecated, use bpf_object__prev_map() instead")
+struct bpf_map *bpf_map__prev(const struct bpf_map *map, const struct bpf_object *obj);
 LIBBPF_API struct bpf_map *
-bpf_map__prev(const struct bpf_map *map, const struct bpf_object *obj);
+bpf_object__prev_map(const struct bpf_map *map, const struct bpf_object *obj);

 /* get/set map FD */
 LIBBPF_API int bpf_map__fd(const struct bpf_map *map);
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index bbc53bb25f68..0c6d510e7747 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -378,6 +378,10 @@ LIBBPF_0.5.0 {
 		bpf_program__attach_tracepoint_opts;
 		bpf_program__attach_uprobe_opts;
 		bpf_object__gen_loader;
+		bpf_object__next_map;
+		bpf_object__next_program;
+		bpf_object__prev_map;
+		bpf_object__prev_program;
 		btf__load_from_kernel_by_id;
 		btf__load_from_kernel_by_id_split;
 		btf__load_into_kernel;
--
2.30.2
