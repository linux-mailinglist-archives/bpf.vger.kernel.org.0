Return-Path: <bpf+bounces-52885-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EFBE0A4A0EC
	for <lists+bpf@lfdr.de>; Fri, 28 Feb 2025 18:53:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5A20189A7CC
	for <lists+bpf@lfdr.de>; Fri, 28 Feb 2025 17:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58771274253;
	Fri, 28 Feb 2025 17:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PYVyYr8d"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C371BD9F2
	for <bpf@vger.kernel.org>; Fri, 28 Feb 2025 17:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740765187; cv=none; b=EEGckdahLPwaeSUCAF9/+pfsAxJM5zf/QzPon4xN1+Lfh8/dY7QetFJ5Jhbgyhso3zwLJ/FTicwKPWsBTm8zhFsDgaeiUk2kCbTRJAIvw1Y0T3ZrIggl7dnOCbeDzncT9I4A/1yausElIM/UBJWqToMKhv051Qi8GH/0FOeifRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740765187; c=relaxed/simple;
	bh=YIZFVBGVknv9054PE8fxoSGPhyCTgMIrimt8+wjny9s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rw+N6xXonp+xkTdYfKzPLgN4l0gosIrZFavV3RJgcR/l8eHX5oYGc/iecTKe4ySFD3oPDoMMoJ0TY4Q5MQYO3PCV1TnnjEUZB4xLaPAKmTPE8Mea3E2D8SpSEZxtHJb84tt9MQci2WdXTICbtky+2LFlRNbYQBTFMSOvOWo/BTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PYVyYr8d; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-390ddf037ffso1172563f8f.2
        for <bpf@vger.kernel.org>; Fri, 28 Feb 2025 09:53:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740765184; x=1741369984; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OstbQSt2Vr7ZgCHf6elK4Ux1V9WOURBZ78O07X1u8pM=;
        b=PYVyYr8dk+2j0axxvYazPRALwlTX1/2irG/4mJlnT67GX4vMUH/xG4J8EpQmC5Uayz
         R9VBsKdUleM72cdgg2vhY2ir5Z9OgoNVkOUhpkiFz0lDH5WFzAPsQ3hfQvQPtmGtsKBi
         nfdT1DQdxNcvwV7mXCQdmibbwZxxWgs03Kt0NI1Z07+APlZsIhgYQaIM2EW7G0i6bVjN
         RWypwi6GHszUkvfUqzIPAC8561xwxfqbeEATyDnmmG+98sp3WZViVaL8fBZHweS+cBm0
         5+H7jWxDvVmfBXjdFSMyj50uf/0TRhJT9GEFZ+EtLYJ6LqAGEJjTJMEhRKQccUTTuhMP
         S+5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740765184; x=1741369984;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OstbQSt2Vr7ZgCHf6elK4Ux1V9WOURBZ78O07X1u8pM=;
        b=hjhjmBTf2fpNSSUEFKxzTSVuaIl/kUBs3ISk2js4+8Siu1peRFCedmC2S9/43Yybbb
         KOLktqbuzO8oZaSoIEt2CeWNkjLOKBkC2EMvP9FHySlWPukrRNAQopImuvCtb5ngDoB5
         HHPgZHsXelmpNh9fy9eb9Dsh/ZyEHSPUIxHfxzeuClkDQWc+FlZsoulu2xrkF1MNTxBL
         r4fo0CzDPGs3jZpz1cM1vcRmsq9qvOkAq+sm/tV73s93//G3kanbsJ8Pwwc4eARtmMzj
         esClUI6ELeMYSwHNoTrqaCBHmF8uZtTFCzsk+PQNj/u2+RohhCqU9xkQHn0pd7ZFDQZ8
         iJSw==
X-Gm-Message-State: AOJu0Yw6sgtWDQfXQlsEgHtRQxpu9UOGGGmY253Qz4StrGx1t8xCnWgT
	wQuL25Vbs6zEErvNeyrSO9f/8bEB95zlofStu3UKMp7Lo5WQ9LYcA2aG6A==
X-Gm-Gg: ASbGncuceQKbSmCiQd7D3006GlgQ4OcZVbbT0SVTmiX9tKK24Lmr22rBjut2lZN0TkR
	Ij3gloehYBHSAl0oRSepSBkPqFYiagDGj1F0py/YscjzDsLeoze6MqpnZaXxKjJ4/Hu2p25GAmZ
	DdAyDuag9mDlLOnTNweSaICpEwkbPfQ/gNoEHsCSqC+QmStnVlgTTuNvPQuxY/ehCZCfFbVRTHS
	dlId8DfWLJAUJ6qovelC3dWAK0ta4CXkQ/lmx/ZSZh6O4kwzKIQnA/WNsxN1MnEfpuqw3tEzn2V
	C5MwKuGoFzZHBux/GsstsbkCz+HfAb+BhL+CWFMTQ0nDPmMzZCBCuP4zDcziVvrdTcoxILUSPI0
	gkyG7ymAVfbiMS2KBkAeHbivdZj/zZ/8=
X-Google-Smtp-Source: AGHT+IFs442uCzLll73pgB1Bkpbe58OoiwtZP0vV3iFDoKxSEqXDRGGV1plR9/miOY9ErJs3UjKXQQ==
X-Received: by 2002:a5d:47ae:0:b0:390:f642:e283 with SMTP id ffacd0b85a97d-390f642e3a2mr1132710f8f.10.1740765183748;
        Fri, 28 Feb 2025 09:53:03 -0800 (PST)
Received: from localhost.localdomain (cpc158789-hari22-2-0-cust468.20-2.cable.virginm.net. [86.26.115.213])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47a7b88sm5861664f8f.40.2025.02.28.09.53.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 09:53:03 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next 2/3] libbpf: split bpf object load into prepare/load
Date: Fri, 28 Feb 2025 17:52:54 +0000
Message-ID: <20250228175255.254009-3-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250228175255.254009-1-mykyta.yatsenko5@gmail.com>
References: <20250228175255.254009-1-mykyta.yatsenko5@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mykyta Yatsenko <yatsenko@meta.com>

Introduce bpf_object__prepare API: additional intermediate step,
executing all steps that bpf_object__load is running before the actual
loading of BPF programs.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 tools/lib/bpf/libbpf.c   | 161 +++++++++++++++++++++++++++------------
 tools/lib/bpf/libbpf.h   |   9 +++
 tools/lib/bpf/libbpf.map |   1 +
 3 files changed, 121 insertions(+), 50 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 9ced1ce2334c..dd2f64903c3b 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -4858,7 +4858,7 @@ bool bpf_map__autocreate(const struct bpf_map *map)
 
 int bpf_map__set_autocreate(struct bpf_map *map, bool autocreate)
 {
-	if (map->obj->state >= OBJ_LOADED)
+	if (map->obj->state >= OBJ_PREPARED)
 		return libbpf_err(-EBUSY);
 
 	map->autocreate = autocreate;
@@ -4952,7 +4952,7 @@ struct bpf_map *bpf_map__inner_map(struct bpf_map *map)
 
 int bpf_map__set_max_entries(struct bpf_map *map, __u32 max_entries)
 {
-	if (map->obj->state >= OBJ_LOADED)
+	if (map->obj->state >= OBJ_PREPARED)
 		return libbpf_err(-EBUSY);
 
 	map->def.max_entries = max_entries;
@@ -5199,7 +5199,7 @@ static void bpf_map__destroy(struct bpf_map *map);
 
 static bool map_is_created(const struct bpf_map *map)
 {
-	return map->obj->state >= OBJ_LOADED || map->reused;
+	return map->obj->state >= OBJ_PREPARED || map->reused;
 }
 
 static int bpf_object__create_map(struct bpf_object *obj, struct bpf_map *map, bool is_inner)
@@ -7901,13 +7901,6 @@ bpf_object__load_progs(struct bpf_object *obj, int log_level)
 	size_t i;
 	int err;
 
-	for (i = 0; i < obj->nr_programs; i++) {
-		prog = &obj->programs[i];
-		err = bpf_object__sanitize_prog(obj, prog);
-		if (err)
-			return err;
-	}
-
 	for (i = 0; i < obj->nr_programs; i++) {
 		prog = &obj->programs[i];
 		if (prog_is_subprog(obj, prog))
@@ -7933,6 +7926,21 @@ bpf_object__load_progs(struct bpf_object *obj, int log_level)
 	return 0;
 }
 
+static int bpf_object_prepare_progs(struct bpf_object *obj)
+{
+	struct bpf_program *prog;
+	size_t i;
+	int err;
+
+	for (i = 0; i < obj->nr_programs; i++) {
+		prog = &obj->programs[i];
+		err = bpf_object__sanitize_prog(obj, prog);
+		if (err)
+			return err;
+	}
+	return 0;
+}
+
 static const struct bpf_sec_def *find_sec_def(const char *sec_name);
 
 static int bpf_object_init_progs(struct bpf_object *obj, const struct bpf_object_open_opts *opts)
@@ -8549,9 +8557,72 @@ static int bpf_object_prepare_struct_ops(struct bpf_object *obj)
 	return 0;
 }
 
+static void bpf_object_unpin(struct bpf_object *obj)
+{
+	int i;
+
+	/* unpin any maps that were auto-pinned during load */
+	for (i = 0; i < obj->nr_maps; i++)
+		if (obj->maps[i].pinned && !obj->maps[i].reused)
+			bpf_map__unpin(&obj->maps[i], NULL);
+}
+
+static void bpf_object_post_load_cleanup(struct bpf_object *obj)
+{
+	int i;
+
+	/* clean up fd_array */
+	zfree(&obj->fd_array);
+
+	/* clean up module BTFs */
+	for (i = 0; i < obj->btf_module_cnt; i++) {
+		close(obj->btf_modules[i].fd);
+		btf__free(obj->btf_modules[i].btf);
+		free(obj->btf_modules[i].name);
+	}
+	free(obj->btf_modules);
+
+	/* clean up vmlinux BTF */
+	btf__free(obj->btf_vmlinux);
+	obj->btf_vmlinux = NULL;
+}
+
+static int bpf_object_prepare(struct bpf_object *obj, const char *target_btf_path)
+{
+	int err;
+
+	if (!obj)
+		return -EINVAL;
+
+	if (obj->state >= OBJ_PREPARED) {
+		pr_warn("object '%s': prepare loading can't be attempted twice\n", obj->name);
+		return -EINVAL;
+	}
+
+	err = bpf_object_prepare_token(obj);
+	err = err ? : bpf_object__probe_loading(obj);
+	err = err ? : bpf_object__load_vmlinux_btf(obj, false);
+	err = err ? : bpf_object__resolve_externs(obj, obj->kconfig);
+	err = err ? : bpf_object__sanitize_maps(obj);
+	err = err ? : bpf_object__init_kern_struct_ops_maps(obj);
+	err = err ? : bpf_object_adjust_struct_ops_autoload(obj);
+	err = err ? : bpf_object__relocate(obj, obj->btf_custom_path ? : target_btf_path);
+	err = err ? : bpf_object__sanitize_and_load_btf(obj);
+	err = err ? : bpf_object__create_maps(obj);
+	err = err ? : bpf_object_prepare_progs(obj);
+	obj->state = OBJ_PREPARED;
+
+	if (err) {
+		bpf_object_unpin(obj);
+		bpf_object_unload(obj);
+		return err;
+	}
+	return 0;
+}
+
 static int bpf_object_load(struct bpf_object *obj, int extra_log_level, const char *target_btf_path)
 {
-	int err, i;
+	int err;
 
 	if (!obj)
 		return libbpf_err(-EINVAL);
@@ -8571,17 +8642,12 @@ static int bpf_object_load(struct bpf_object *obj, int extra_log_level, const ch
 		return libbpf_err(-LIBBPF_ERRNO__ENDIAN);
 	}
 
-	err = bpf_object_prepare_token(obj);
-	err = err ? : bpf_object__probe_loading(obj);
-	err = err ? : bpf_object__load_vmlinux_btf(obj, false);
-	err = err ? : bpf_object__resolve_externs(obj, obj->kconfig);
-	err = err ? : bpf_object__sanitize_maps(obj);
-	err = err ? : bpf_object__init_kern_struct_ops_maps(obj);
-	err = err ? : bpf_object_adjust_struct_ops_autoload(obj);
-	err = err ? : bpf_object__relocate(obj, obj->btf_custom_path ? : target_btf_path);
-	err = err ? : bpf_object__sanitize_and_load_btf(obj);
-	err = err ? : bpf_object__create_maps(obj);
-	err = err ? : bpf_object__load_progs(obj, extra_log_level);
+	if (obj->state < OBJ_PREPARED) {
+		err = bpf_object_prepare(obj, target_btf_path);
+		if (err)
+			return libbpf_err(err);
+	}
+	err = bpf_object__load_progs(obj, extra_log_level);
 	err = err ? : bpf_object_init_prog_arrays(obj);
 	err = err ? : bpf_object_prepare_struct_ops(obj);
 
@@ -8593,35 +8659,22 @@ static int bpf_object_load(struct bpf_object *obj, int extra_log_level, const ch
 			err = bpf_gen__finish(obj->gen_loader, obj->nr_programs, obj->nr_maps);
 	}
 
-	/* clean up fd_array */
-	zfree(&obj->fd_array);
+	bpf_object_post_load_cleanup(obj);
+	obj->state = OBJ_LOADED;/* doesn't matter if successfully or not */
 
-	/* clean up module BTFs */
-	for (i = 0; i < obj->btf_module_cnt; i++) {
-		close(obj->btf_modules[i].fd);
-		btf__free(obj->btf_modules[i].btf);
-		free(obj->btf_modules[i].name);
+	if (err) {
+		bpf_object_unpin(obj);
+		bpf_object_unload(obj);
+		pr_warn("failed to load object '%s'\n", obj->path);
+		return libbpf_err(err);
 	}
-	free(obj->btf_modules);
-
-	/* clean up vmlinux BTF */
-	btf__free(obj->btf_vmlinux);
-	obj->btf_vmlinux = NULL;
-
-	obj->state = OBJ_LOADED;/* doesn't matter if successfully or not */
-	if (err)
-		goto out;
 
 	return 0;
-out:
-	/* unpin any maps that were auto-pinned during load */
-	for (i = 0; i < obj->nr_maps; i++)
-		if (obj->maps[i].pinned && !obj->maps[i].reused)
-			bpf_map__unpin(&obj->maps[i], NULL);
+}
 
-	bpf_object_unload(obj);
-	pr_warn("failed to load object '%s'\n", obj->path);
-	return libbpf_err(err);
+int bpf_object__prepare(struct bpf_object *obj)
+{
+	return libbpf_err(bpf_object_prepare(obj, NULL));
 }
 
 int bpf_object__load(struct bpf_object *obj)
@@ -8871,8 +8924,8 @@ int bpf_object__pin_maps(struct bpf_object *obj, const char *path)
 	if (!obj)
 		return libbpf_err(-ENOENT);
 
-	if (obj->state < OBJ_LOADED) {
-		pr_warn("object not yet loaded; load it first\n");
+	if (obj->state < OBJ_PREPARED) {
+		pr_warn("object not yet loaded/prepared; load/prepare it first\n");
 		return libbpf_err(-ENOENT);
 	}
 
@@ -9069,6 +9122,14 @@ void bpf_object__close(struct bpf_object *obj)
 	if (IS_ERR_OR_NULL(obj))
 		return;
 
+	/*
+	 * if user called bpf_object__prepare() without ever getting to
+	 * bpf_object__load(), we need to clean up stuff that is normally
+	 * cleaned up at the end of loading step
+	 */
+	if (obj->state == OBJ_PREPARED)
+		bpf_object_post_load_cleanup(obj);
+
 	usdt_manager_free(obj->usdt_man);
 	obj->usdt_man = NULL;
 
@@ -10304,7 +10365,7 @@ static int map_btf_datasec_resize(struct bpf_map *map, __u32 size)
 
 int bpf_map__set_value_size(struct bpf_map *map, __u32 size)
 {
-	if (map->obj->state >= OBJ_LOADED || map->reused)
+	if (map->obj->state >= OBJ_PREPARED || map->reused)
 		return libbpf_err(-EBUSY);
 
 	if (map->mmaped) {
@@ -10350,7 +10411,7 @@ int bpf_map__set_initial_value(struct bpf_map *map,
 {
 	size_t actual_sz;
 
-	if (map->obj->state >= OBJ_LOADED || map->reused)
+	if (map->obj->state >= OBJ_PREPARED || map->reused)
 		return libbpf_err(-EBUSY);
 
 	if (!map->mmaped || map->libbpf_type == LIBBPF_MAP_KCONFIG)
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 3020ee45303a..09e87998c64e 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -241,6 +241,15 @@ LIBBPF_API struct bpf_object *
 bpf_object__open_mem(const void *obj_buf, size_t obj_buf_sz,
 		     const struct bpf_object_open_opts *opts);
 
+/**
+ * @brief **bpf_object__prepare()** prepares BPF object for loading.
+ * @param obj Pointer to a valid BPF object instance returned by
+ * **bpf_object__open*()** API
+ * @return 0, on success; negative error code, otherwise, error code is
+ * stored in errno
+ */
+int bpf_object__prepare(struct bpf_object *obj);
+
 /**
  * @brief **bpf_object__load()** loads BPF object into kernel.
  * @param obj Pointer to a valid BPF object instance returned by
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index b5a838de6f47..22edde0bf85e 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -438,4 +438,5 @@ LIBBPF_1.6.0 {
 		bpf_linker__new_fd;
 		btf__add_decl_attr;
 		btf__add_type_attr;
+		bpf_object__prepare;
 } LIBBPF_1.5.0;
-- 
2.48.1


