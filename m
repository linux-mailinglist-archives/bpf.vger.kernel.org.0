Return-Path: <bpf+bounces-53064-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 200F4A4C29E
	for <lists+bpf@lfdr.de>; Mon,  3 Mar 2025 14:58:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32A2216E780
	for <lists+bpf@lfdr.de>; Mon,  3 Mar 2025 13:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56041212FBF;
	Mon,  3 Mar 2025 13:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JSEhgN7I"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4A4211A28
	for <bpf@vger.kernel.org>; Mon,  3 Mar 2025 13:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741010284; cv=none; b=AeQEUyIuaIZTJGdoBfX4QD5MNA7K9URNRvE3TGbwH2wUeRUDDl94bcueekoaHR2oQFXVG6Y3SpS/SRGIOhPvwiC4iaBhTTHp8czns/9F9MG6UXZZeVcPl9x30BSH3OotxN+8LROTEakMMmTcXlZ2/+YXzv26rQaXnDOHcw6ZOEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741010284; c=relaxed/simple;
	bh=0jo7M4rSr5Ve3pPIg6I/1uIsUuMWzbOnN6CmFpnle8M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bkXK/Rc9heo4IH5zBOKW3jTvu0YOL0RZr3g0j4reO6UDEmDIJVFm2uF9rAtJeE8T6pj8+eeJdCLGljcowkKyfiqtGBNa+xSJELcYVdAL8F3IEwWhRBSBFYGyvQXRJszcVzX3aci/ifPEPet6Z7RF3KNfK+q0YKzAKBxcLZ+/Brs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JSEhgN7I; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ac0b6e8d96cso134513966b.0
        for <bpf@vger.kernel.org>; Mon, 03 Mar 2025 05:58:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741010281; x=1741615081; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rgIkqmM6sTy1iHkuowBFRpR0FbFG7wc/sN+n0hQbrAk=;
        b=JSEhgN7IooLrSy+PzrMn/6swjBaQzP8AMUQ0eQUr5+zh0LqdntBHstRwFOv9xyVMKT
         QScrymgX3uG2R47IpCqvUZBHljmCsAP/mFir2Vs0OLSgrhRdFsghhmGbxCgGkg5JfXlD
         ThucRLgNyB5xYSbpWBxmdFxSqSbkI78ovPIpqM2OgkKi4xjoqzOhncEQP//nAZ+98uXv
         YgT4XyvUUxAY3dY9njhFmu6xviFDauf1jZAEtiDVX/FcN+Ey2NA55EVRfksjc6pTlNvM
         2cpnyJmJAN7VF064fVxzKEA8nh813olzQQXEmBtnvmS5wBwnc/I7WdkMZaFKpI1rJ+Fn
         LTcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741010281; x=1741615081;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rgIkqmM6sTy1iHkuowBFRpR0FbFG7wc/sN+n0hQbrAk=;
        b=lzibptx2Ti4M16YAYbikMv6jBpS/mwJK1RPVSRIv+TKTZfgfZg1rozZW0yqixh91K9
         MPAeIKWBPer3r2TLEbZoytQlx32LSMdtwipHCm+gSAPl5z4aoZgB4JPFceg2nBf6QoM9
         Rp4BQitxN845ZuwQkaAEtIkeOVLTwWDDYlYBjazzn8kfA/Nzsfln+1ms18CYHB7Ez0rg
         HZEpjI6maFo/FWJ7zJShwgI5iazm/q/WDjMUruJUil8GzSuq4e1nh2ttvrXL0nmctf/q
         w5eQrKBqfWaXEvKpVwLhHjTUWU/LDzj2uQYeUPZBz3UQol7dhj7qS/lSmlF/7WgsOeFU
         uD8Q==
X-Gm-Message-State: AOJu0YxjIfbBT5pGYhM5XV017C09qumGvkn+8Rt7gGu9w6KfZ8Xd10NG
	0GBDFjsdJ+UwRcRekZ6pcJu9si5Gp5lgUY8Sr8SKQp67NYlaHA2ifasz2A==
X-Gm-Gg: ASbGncsdy1SYd9+2fBWQHdsetKFCtdfuRfGsfNKAk+W5l7fsYfIEXKr/mMx3J11cbXU
	xdHDuYrvLuAzi0DCNcBfVIk1tjOfRmGzp2XuAhK3aEwlqty1csJtVk1p0OCZx7KMQxe9vcr0Nvk
	H4QymFbe0a5yjkfVYf8/ah9fcc0xQT0/AVlw+MLX9YRre5Oa1NSzEM1UNF+G/q32jlQU9fOkxWo
	MJgx6kM5QmUpxyC51vwkneRc3bb3llc4YyNpfQ5IYjdO2HxnQGqYqzRXWgkL9O0gSPNHJATZ9dv
	T1vLQg+FqxHTV7gJQcV6a9Xa+bzGZvL8/KovISmrqSGtw2UVbelyjO06wU8=
X-Google-Smtp-Source: AGHT+IHoXEH25I/Zw+khVLrGx7H9Sgt3N1XwCYdCN/OTpMEPzT3SDDQ6fqXV9W9bDZHRI9DgAiQmuw==
X-Received: by 2002:a17:907:97c1:b0:ac1:ea6e:ad64 with SMTP id a640c23a62f3a-ac1ea6ff060mr76661566b.28.1741010280782;
        Mon, 03 Mar 2025 05:58:00 -0800 (PST)
Received: from msi-laptop.thefacebook.com ([2620:10d:c092:500::6:7e2d])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf0c75bfd7sm817975366b.148.2025.03.03.05.58.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 05:58:00 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next v2 3/4] libbpf: split bpf object load into prepare/load
Date: Mon,  3 Mar 2025 13:57:51 +0000
Message-ID: <20250303135752.158343-4-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250303135752.158343-1-mykyta.yatsenko5@gmail.com>
References: <20250303135752.158343-1-mykyta.yatsenko5@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mykyta Yatsenko <yatsenko@meta.com>

Introduce bpf_object__prepare API: additional intermediate preparation
step that performs ELF processing, relocations, prepares final state of
BPF program instructions (accessible with bpf_program__insns()), creates
and (potentially) pins maps, and stops short of loading BPF programs.

We anticipate few use cases for this API, such as:
* Use prepare to initialize bpf_token, without loading freplace
programs, unlocking possibility to lookup BTF of other programs.
* Execute prepare to obtain finalized BPF program instructions without
loading programs, enabling tools like veristat to process one program at
a time, without incurring cost of ELF parsing and processing.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 tools/lib/bpf/libbpf.c   | 144 +++++++++++++++++++++++++++------------
 tools/lib/bpf/libbpf.h   |  13 ++++
 tools/lib/bpf/libbpf.map |   1 +
 3 files changed, 115 insertions(+), 43 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 7210278ecdcf..80ed6d380584 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
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
@@ -8549,9 +8557,70 @@ static int bpf_object_prepare_struct_ops(struct bpf_object *obj)
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
+	obj->btf_module_cnt = 0;
+	zfree(&obj->btf_modules);
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
@@ -8571,17 +8640,12 @@ static int bpf_object_load(struct bpf_object *obj, int extra_log_level, const ch
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
 
@@ -8593,35 +8657,22 @@ static int bpf_object_load(struct bpf_object *obj, int extra_log_level, const ch
 			err = bpf_gen__finish(obj->gen_loader, obj->nr_programs, obj->nr_maps);
 	}
 
-	/* clean up fd_array */
-	zfree(&obj->fd_array);
+	bpf_object_post_load_cleanup(obj);
+	obj->state = OBJ_LOADED; /* doesn't matter if successfully or not */
 
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
-	obj->state = OBJ_LOADED; /* doesn't matter if successfully or not */
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
@@ -9069,6 +9120,13 @@ void bpf_object__close(struct bpf_object *obj)
 	if (IS_ERR_OR_NULL(obj))
 		return;
 
+	/*
+	 * if user called bpf_object__prepare() without ever getting to
+	 * bpf_object__load(), we need to clean up stuff that is normally
+	 * cleaned up at the end of loading step
+	 */
+	bpf_object_post_load_cleanup(obj);
+
 	usdt_manager_free(obj->usdt_man);
 	obj->usdt_man = NULL;
 
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 3020ee45303a..e0605403f977 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -241,6 +241,19 @@ LIBBPF_API struct bpf_object *
 bpf_object__open_mem(const void *obj_buf, size_t obj_buf_sz,
 		     const struct bpf_object_open_opts *opts);
 
+/**
+ * @brief **bpf_object__prepare()** prepares BPF object for loading:
+ * performs ELF processing, relocations, prepares final state of BPF program
+ * instructions (accessible with bpf_program__insns()), creates and
+ * (potentially) pins maps. Leaves BPF object in the state ready for program
+ * loading.
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
index b5a838de6f47..d8b71f22f197 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -436,6 +436,7 @@ LIBBPF_1.6.0 {
 		bpf_linker__add_buf;
 		bpf_linker__add_fd;
 		bpf_linker__new_fd;
+		bpf_object__prepare;
 		btf__add_decl_attr;
 		btf__add_type_attr;
 } LIBBPF_1.5.0;
-- 
2.48.1


