Return-Path: <bpf+bounces-44545-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 021189C480F
	for <lists+bpf@lfdr.de>; Mon, 11 Nov 2024 22:30:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B115A282BC0
	for <lists+bpf@lfdr.de>; Mon, 11 Nov 2024 21:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 420E71BC06C;
	Mon, 11 Nov 2024 21:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eG8fCqLV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC2B1B9B50
	for <bpf@vger.kernel.org>; Mon, 11 Nov 2024 21:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731360576; cv=none; b=PNGLksNk68DWNtFOTYIjmSPv8V2kfAaTB8GyybsVNXKj+Dx1JgwWGfHhsmZbHeU7xvYUeqNBwhEIS41Fqf/SwuM1Lm7C29NnC/MmXOOAp3x5ceaLnjpmLuiaJL6dzvdj0CDary+YKxp5xOrt/z6AeosC9K51TnPh3xjI6DvxHc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731360576; c=relaxed/simple;
	bh=4bgKIQkmhf0VDfij1JeGp2YgdOArN4rB8ZxyOtgwY7g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b5Q6YOzeHkm22Ynp62QO8eTpgp3fZGRcMXn/RyCOfKWM4yJpPUaAaLnC90JoYoAW1tR25Q8RBQlRoJLaJulkxl1H7FSpbRj+ghivsMUyq8lrgFcpdla6pBVIiZ/ho9KnQsBAcbGTq8TVa4VGe1GrRHj6TyA8dml2TkHbPu7HuF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eG8fCqLV; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a9a6b4ca29bso723413966b.3
        for <bpf@vger.kernel.org>; Mon, 11 Nov 2024 13:29:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731360571; x=1731965371; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nnd76iIVNLxRN5pK1+Pv4AStgM1nTc+28rU7caYAJ1E=;
        b=eG8fCqLVXERJ7m0GaDezJ9CDnSM7sdd30VcimJn0tAGXZGFglsPfSPW/RRSLZKl9iu
         SZ/XksA9UhMuVTXlFqWJtaAYl0uz90b9mCJh3TDqAmVgp7gJ4J8nNeoSlD/P/04sBgoA
         phXFGvdzZqVhdxSCfpLB6Cc1+pBVsrbGovx3+K8zpThfCux9mDJQH/kFdApVAmbiXR2f
         IRV/yOOBjASpiqzm0WjZgToVYNRKnHC5wD0TC/kYrErrOi7w+YWVtE69VeFR7CksBnim
         +BKd0rfnSKZHxII2mfJV60tDIUVG0L0C5ncCkc3zBM1DvNBiid8fA5gHFRERYWs2Qa6u
         HckQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731360571; x=1731965371;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nnd76iIVNLxRN5pK1+Pv4AStgM1nTc+28rU7caYAJ1E=;
        b=ND2l5CQCEvvciZQQb0ls8HRViCzk/4jB+B+cKaOYgIomVQoJ2UaOXXHtxUtJ0itSyW
         KhdAHi5MSnxI7FRrmsZpRrW5R6vHAffg2SN4eIpZojHEl4vE7IBiS8vfLXFh1kcSWKaC
         uh5+z8UB0csetyG6PiRz7aRKd6aiEHbdTjhyWCnyOxpu0J/Uy8mZ/KF8NNtECVGiQYVL
         0XUn4JtZMQPsMyffyR9/y1k6hsxOKdzlAXfqGF3bfz5F02VVBEsgFV6JpdSckVU9B5xQ
         Y0M4QjyoBPBSuuXQ+PdeoGB5gADPLq9IJ7RZUQkZ7/DxaTi5CrrFGvYdQiHCN8n3ycQL
         ruqA==
X-Gm-Message-State: AOJu0YwvAu3nLjGHrn4GfWvCbFcGKHfS0crhYLoKluN/K2nqhojs6VOg
	GVjNxbtB7sErHeNNnZkYmHicZpgtjkr0/wOmIpb9koMO9h/Lk6AkeXtfTQ==
X-Google-Smtp-Source: AGHT+IHBhAxb0sL09Wt5YfD3h++jE0e1SO/S88XOGL5uyLNrJD4uHQTYMt3pgTeXVNw2g2MBWBM8Fg==
X-Received: by 2002:a17:907:1c13:b0:a9a:522a:eddd with SMTP id a640c23a62f3a-a9eefebd10dmr1435913366b.11.1731360570876;
        Mon, 11 Nov 2024 13:29:30 -0800 (PST)
Received: from msi-laptop.thefacebook.com ([2620:10d:c092:500::5:3961])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0defc3csm629570266b.166.2024.11.11.13.29.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 13:29:29 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next v3 2/4] libbpf: stringify errno in log messages in libbpf.c
Date: Mon, 11 Nov 2024 21:29:17 +0000
Message-ID: <20241111212919.368971-3-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241111212919.368971-1-mykyta.yatsenko5@gmail.com>
References: <20241111212919.368971-1-mykyta.yatsenko5@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mykyta Yatsenko <yatsenko@meta.com>

Convert numeric error codes into the string representations in log
messages in libbpf.c.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 tools/lib/bpf/libbpf.c | 356 ++++++++++++++++++-----------------------
 1 file changed, 156 insertions(+), 200 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index a2bc5bea7ea3..07d5de81dd38 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -1551,11 +1551,8 @@ static int bpf_object__elf_init(struct bpf_object *obj)
 	} else {
 		obj->efile.fd = open(obj->path, O_RDONLY | O_CLOEXEC);
 		if (obj->efile.fd < 0) {
-			char errmsg[STRERR_BUFSIZE], *cp;
-
 			err = -errno;
-			cp = libbpf_strerror_r(err, errmsg, sizeof(errmsg));
-			pr_warn("elf: failed to open %s: %s\n", obj->path, cp);
+			pr_warn("elf: failed to open %s: %s\n", obj->path, errstr(err));
 			return err;
 		}
 
@@ -1961,8 +1958,7 @@ bpf_object__init_internal_map(struct bpf_object *obj, enum libbpf_map_type type,
 	if (map->mmaped == MAP_FAILED) {
 		err = -errno;
 		map->mmaped = NULL;
-		pr_warn("failed to alloc map '%s' content buffer: %d\n",
-			map->name, err);
+		pr_warn("failed to alloc map '%s' content buffer: %s\n", map->name, errstr(err));
 		zfree(&map->real_name);
 		zfree(&map->name);
 		return err;
@@ -2126,7 +2122,7 @@ static int parse_u64(const char *value, __u64 *res)
 	*res = strtoull(value, &value_end, 0);
 	if (errno) {
 		err = -errno;
-		pr_warn("failed to parse '%s' as integer: %d\n", value, err);
+		pr_warn("failed to parse '%s': %s\n", value, errstr(err));
 		return err;
 	}
 	if (*value_end) {
@@ -2292,8 +2288,8 @@ static int bpf_object__read_kconfig_file(struct bpf_object *obj, void *data)
 	while (gzgets(file, buf, sizeof(buf))) {
 		err = bpf_object__process_kconfig_line(obj, buf, data);
 		if (err) {
-			pr_warn("error parsing system Kconfig line '%s': %d\n",
-				buf, err);
+			pr_warn("error parsing system Kconfig line '%s': %s\n",
+				buf, errstr(err));
 			goto out;
 		}
 	}
@@ -2313,15 +2309,15 @@ static int bpf_object__read_kconfig_mem(struct bpf_object *obj,
 	file = fmemopen((void *)config, strlen(config), "r");
 	if (!file) {
 		err = -errno;
-		pr_warn("failed to open in-memory Kconfig: %d\n", err);
+		pr_warn("failed to open in-memory Kconfig: %s\n", errstr(err));
 		return err;
 	}
 
 	while (fgets(buf, sizeof(buf), file)) {
 		err = bpf_object__process_kconfig_line(obj, buf, data);
 		if (err) {
-			pr_warn("error parsing in-memory Kconfig line '%s': %d\n",
-				buf, err);
+			pr_warn("error parsing in-memory Kconfig line '%s': %s\n",
+				buf, errstr(err));
 			break;
 		}
 	}
@@ -3236,7 +3232,7 @@ static int bpf_object__init_btf(struct bpf_object *obj,
 		err = libbpf_get_error(obj->btf);
 		if (err) {
 			obj->btf = NULL;
-			pr_warn("Error loading ELF section %s: %d.\n", BTF_ELF_SEC, err);
+			pr_warn("Error loading ELF section %s: %s.\n", BTF_ELF_SEC, errstr(err));
 			goto out;
 		}
 		/* enforce 8-byte pointers for BPF-targeted BTFs */
@@ -3254,8 +3250,8 @@ static int bpf_object__init_btf(struct bpf_object *obj,
 		obj->btf_ext = btf_ext__new(btf_ext_data->d_buf, btf_ext_data->d_size);
 		err = libbpf_get_error(obj->btf_ext);
 		if (err) {
-			pr_warn("Error loading ELF section %s: %d. Ignored and continue.\n",
-				BTF_EXT_ELF_SEC, err);
+			pr_warn("Error loading ELF section %s: %s. Ignored and continue.\n",
+				BTF_EXT_ELF_SEC, errstr(err));
 			obj->btf_ext = NULL;
 			goto out;
 		}
@@ -3347,8 +3343,8 @@ static int btf_fixup_datasec(struct bpf_object *obj, struct btf *btf,
 	if (t->size == 0) {
 		err = find_elf_sec_sz(obj, sec_name, &size);
 		if (err || !size) {
-			pr_debug("sec '%s': failed to determine size from ELF: size %u, err %d\n",
-				 sec_name, size, err);
+			pr_debug("sec '%s': failed to determine size from ELF: size %u, err %s\n",
+				 sec_name, size, errstr(err));
 			return -ENOENT;
 		}
 
@@ -3502,7 +3498,7 @@ static int bpf_object__load_vmlinux_btf(struct bpf_object *obj, bool force)
 	obj->btf_vmlinux = btf__load_vmlinux_btf();
 	err = libbpf_get_error(obj->btf_vmlinux);
 	if (err) {
-		pr_warn("Error loading vmlinux BTF: %d\n", err);
+		pr_warn("Error loading vmlinux BTF: %s\n", errstr(err));
 		obj->btf_vmlinux = NULL;
 		return err;
 	}
@@ -3606,9 +3602,11 @@ static int bpf_object__sanitize_and_load_btf(struct bpf_object *obj)
 	if (err) {
 		btf_mandatory = kernel_needs_btf(obj);
 		if (btf_mandatory) {
-			pr_warn("Error loading .BTF into kernel: %d. BTF is mandatory, can't proceed.\n", err);
+			pr_warn("Error loading .BTF into kernel: %s. BTF is mandatory, can't proceed.\n",
+				errstr(err));
 		} else {
-			pr_info("Error loading .BTF into kernel: %d. BTF is optional, ignoring.\n", err);
+			pr_info("Error loading .BTF into kernel: %s. BTF is optional, ignoring.\n",
+				errstr(err));
 			err = 0;
 		}
 	}
@@ -4812,8 +4810,8 @@ static int bpf_get_map_info_from_fdinfo(int fd, struct bpf_map_info *info)
 	fp = fopen(file, "re");
 	if (!fp) {
 		err = -errno;
-		pr_warn("failed to open %s: %d. No procfs support?\n", file,
-			err);
+		pr_warn("failed to open %s: %s. No procfs support?\n", file,
+			errstr(err));
 		return err;
 	}
 
@@ -4968,8 +4966,8 @@ static int bpf_object_prepare_token(struct bpf_object *obj)
 	bpffs_fd = open(bpffs_path, O_DIRECTORY, O_RDWR);
 	if (bpffs_fd < 0) {
 		err = -errno;
-		__pr(level, "object '%s': failed (%d) to open BPF FS mount at '%s'%s\n",
-		     obj->name, err, bpffs_path,
+		__pr(level, "object '%s': failed (%s) to open BPF FS mount at '%s'%s\n",
+		     obj->name, errstr(err), bpffs_path,
 		     mandatory ? "" : ", skipping optional step...");
 		return mandatory ? err : 0;
 	}
@@ -5003,7 +5001,6 @@ static int bpf_object_prepare_token(struct bpf_object *obj)
 static int
 bpf_object__probe_loading(struct bpf_object *obj)
 {
-	char *cp, errmsg[STRERR_BUFSIZE];
 	struct bpf_insn insns[] = {
 		BPF_MOV64_IMM(BPF_REG_0, 0),
 		BPF_EXIT_INSN(),
@@ -5019,7 +5016,8 @@ bpf_object__probe_loading(struct bpf_object *obj)
 
 	ret = bump_rlimit_memlock();
 	if (ret)
-		pr_warn("Failed to bump RLIMIT_MEMLOCK (err = %d), you might need to do it explicitly!\n", ret);
+		pr_warn("Failed to bump RLIMIT_MEMLOCK (err = %s), you might need to do it explicitly!\n",
+			errstr(ret));
 
 	/* make sure basic loading works */
 	ret = bpf_prog_load(BPF_PROG_TYPE_SOCKET_FILTER, NULL, "GPL", insns, insn_cnt, &opts);
@@ -5027,11 +5025,8 @@ bpf_object__probe_loading(struct bpf_object *obj)
 		ret = bpf_prog_load(BPF_PROG_TYPE_TRACEPOINT, NULL, "GPL", insns, insn_cnt, &opts);
 	if (ret < 0) {
 		ret = errno;
-		cp = libbpf_strerror_r(ret, errmsg, sizeof(errmsg));
-		pr_warn("Error in %s():%s(%d). Couldn't load trivial BPF "
-			"program. Make sure your kernel supports BPF "
-			"(CONFIG_BPF_SYSCALL=y) and/or that RLIMIT_MEMLOCK is "
-			"set to big enough value.\n", __func__, cp, ret);
+		pr_warn("Error in %s(): %s. Couldn't load trivial BPF program. Make sure your kernel supports BPF (CONFIG_BPF_SYSCALL=y) and/or that RLIMIT_MEMLOCK is set to big enough value.\n",
+			__func__, errstr(ret));
 		return -ret;
 	}
 	close(ret);
@@ -5056,7 +5051,6 @@ bool kernel_supports(const struct bpf_object *obj, enum kern_feature_id feat_id)
 static bool map_is_reuse_compat(const struct bpf_map *map, int map_fd)
 {
 	struct bpf_map_info map_info;
-	char msg[STRERR_BUFSIZE];
 	__u32 map_info_len = sizeof(map_info);
 	int err;
 
@@ -5066,7 +5060,7 @@ static bool map_is_reuse_compat(const struct bpf_map *map, int map_fd)
 		err = bpf_get_map_info_from_fdinfo(map_fd, &map_info);
 	if (err) {
 		pr_warn("failed to get map info for map FD %d: %s\n", map_fd,
-			libbpf_strerror_r(errno, msg, sizeof(msg)));
+			errstr(err));
 		return false;
 	}
 
@@ -5081,7 +5075,6 @@ static bool map_is_reuse_compat(const struct bpf_map *map, int map_fd)
 static int
 bpf_object__reuse_map(struct bpf_map *map)
 {
-	char *cp, errmsg[STRERR_BUFSIZE];
 	int err, pin_fd;
 
 	pin_fd = bpf_obj_get(map->pin_path);
@@ -5093,9 +5086,8 @@ bpf_object__reuse_map(struct bpf_map *map)
 			return 0;
 		}
 
-		cp = libbpf_strerror_r(-err, errmsg, sizeof(errmsg));
 		pr_warn("couldn't retrieve pinned map '%s': %s\n",
-			map->pin_path, cp);
+			map->pin_path, errstr(err));
 		return err;
 	}
 
@@ -5121,7 +5113,6 @@ static int
 bpf_object__populate_internal_map(struct bpf_object *obj, struct bpf_map *map)
 {
 	enum libbpf_map_type map_type = map->libbpf_type;
-	char *cp, errmsg[STRERR_BUFSIZE];
 	int err, zero = 0;
 	size_t mmap_sz;
 
@@ -5136,9 +5127,8 @@ bpf_object__populate_internal_map(struct bpf_object *obj, struct bpf_map *map)
 	err = bpf_map_update_elem(map->fd, &zero, map->mmaped, 0);
 	if (err) {
 		err = -errno;
-		cp = libbpf_strerror_r(err, errmsg, sizeof(errmsg));
 		pr_warn("map '%s': failed to set initial contents: %s\n",
-			bpf_map__name(map), cp);
+			bpf_map__name(map), errstr(err));
 		return err;
 	}
 
@@ -5147,9 +5137,8 @@ bpf_object__populate_internal_map(struct bpf_object *obj, struct bpf_map *map)
 		err = bpf_map_freeze(map->fd);
 		if (err) {
 			err = -errno;
-			cp = libbpf_strerror_r(err, errmsg, sizeof(errmsg));
 			pr_warn("map '%s': failed to freeze as read-only: %s\n",
-				bpf_map__name(map), cp);
+				bpf_map__name(map), errstr(err));
 			return err;
 		}
 	}
@@ -5175,8 +5164,8 @@ bpf_object__populate_internal_map(struct bpf_object *obj, struct bpf_map *map)
 		mmaped = mmap(map->mmaped, mmap_sz, prot, MAP_SHARED | MAP_FIXED, map->fd, 0);
 		if (mmaped == MAP_FAILED) {
 			err = -errno;
-			pr_warn("map '%s': failed to re-mmap() contents: %d\n",
-				bpf_map__name(map), err);
+			pr_warn("map '%s': failed to re-mmap() contents: %s\n",
+				bpf_map__name(map), errstr(err));
 			return err;
 		}
 		map->mmaped = mmaped;
@@ -5233,8 +5222,8 @@ static int bpf_object__create_map(struct bpf_object *obj, struct bpf_map *map, b
 				return err;
 			err = bpf_object__create_map(obj, map->inner_map, true);
 			if (err) {
-				pr_warn("map '%s': failed to create inner map: %d\n",
-					map->name, err);
+				pr_warn("map '%s': failed to create inner map: %s\n",
+					map->name, errstr(err));
 				return err;
 			}
 			map->inner_map_fd = map->inner_map->fd;
@@ -5288,12 +5277,9 @@ static int bpf_object__create_map(struct bpf_object *obj, struct bpf_map *map, b
 					def->max_entries, &create_attr);
 	}
 	if (map_fd < 0 && (create_attr.btf_key_type_id || create_attr.btf_value_type_id)) {
-		char *cp, errmsg[STRERR_BUFSIZE];
-
 		err = -errno;
-		cp = libbpf_strerror_r(err, errmsg, sizeof(errmsg));
-		pr_warn("Error in bpf_create_map_xattr(%s):%s(%d). Retrying without BTF.\n",
-			map->name, cp, err);
+		pr_warn("Error in bpf_create_map_xattr(%s): %s. Retrying without BTF.\n",
+			map->name, errstr(err));
 		create_attr.btf_fd = 0;
 		create_attr.btf_key_type_id = 0;
 		create_attr.btf_value_type_id = 0;
@@ -5348,8 +5334,8 @@ static int init_map_in_map_slots(struct bpf_object *obj, struct bpf_map *map)
 		}
 		if (err) {
 			err = -errno;
-			pr_warn("map '%s': failed to initialize slot [%d] to map '%s' fd=%d: %d\n",
-				map->name, i, targ_map->name, fd, err);
+			pr_warn("map '%s': failed to initialize slot [%d] to map '%s' fd=%d: %s\n",
+				map->name, i, targ_map->name, fd, errstr(err));
 			return err;
 		}
 		pr_debug("map '%s': slot [%d] set to map '%s' fd=%d\n",
@@ -5381,8 +5367,8 @@ static int init_prog_array_slots(struct bpf_object *obj, struct bpf_map *map)
 		err = bpf_map_update_elem(map->fd, &i, &fd, 0);
 		if (err) {
 			err = -errno;
-			pr_warn("map '%s': failed to initialize slot [%d] to prog '%s' fd=%d: %d\n",
-				map->name, i, targ_prog->name, fd, err);
+			pr_warn("map '%s': failed to initialize slot [%d] to prog '%s' fd=%d: %s\n",
+				map->name, i, targ_prog->name, fd, errstr(err));
 			return err;
 		}
 		pr_debug("map '%s': slot [%d] set to prog '%s' fd=%d\n",
@@ -5435,7 +5421,6 @@ static int
 bpf_object__create_maps(struct bpf_object *obj)
 {
 	struct bpf_map *map;
-	char *cp, errmsg[STRERR_BUFSIZE];
 	unsigned int i, j;
 	int err;
 	bool retried;
@@ -5509,8 +5494,8 @@ bpf_object__create_maps(struct bpf_object *obj)
 				if (map->mmaped == MAP_FAILED) {
 					err = -errno;
 					map->mmaped = NULL;
-					pr_warn("map '%s': failed to mmap arena: %d\n",
-						map->name, err);
+					pr_warn("map '%s': failed to mmap arena: %s\n",
+						map->name, errstr(err));
 					return err;
 				}
 				if (obj->arena_data) {
@@ -5532,8 +5517,8 @@ bpf_object__create_maps(struct bpf_object *obj)
 					retried = true;
 					goto retry;
 				}
-				pr_warn("map '%s': failed to auto-pin at '%s': %d\n",
-					map->name, map->pin_path, err);
+				pr_warn("map '%s': failed to auto-pin at '%s': %s\n",
+					map->name, map->pin_path, errstr(err));
 				goto err_out;
 			}
 		}
@@ -5542,8 +5527,7 @@ bpf_object__create_maps(struct bpf_object *obj)
 	return 0;
 
 err_out:
-	cp = libbpf_strerror_r(err, errmsg, sizeof(errmsg));
-	pr_warn("map '%s': failed to create: %s(%d)\n", map->name, cp, err);
+	pr_warn("map '%s': failed to create: %s\n", map->name, errstr(err));
 	pr_perm_msg(err);
 	for (j = 0; j < i; j++)
 		zclose(obj->maps[j].fd);
@@ -5667,7 +5651,7 @@ static int load_module_btfs(struct bpf_object *obj)
 		}
 		if (err) {
 			err = -errno;
-			pr_warn("failed to iterate BTF objects: %d\n", err);
+			pr_warn("failed to iterate BTF objects: %s\n", errstr(err));
 			return err;
 		}
 
@@ -5676,7 +5660,7 @@ static int load_module_btfs(struct bpf_object *obj)
 			if (errno == ENOENT)
 				continue; /* expected race: BTF was unloaded */
 			err = -errno;
-			pr_warn("failed to get BTF object #%d FD: %d\n", id, err);
+			pr_warn("failed to get BTF object #%d FD: %s\n", id, errstr(err));
 			return err;
 		}
 
@@ -5688,7 +5672,7 @@ static int load_module_btfs(struct bpf_object *obj)
 		err = bpf_btf_get_info_by_fd(fd, &info, &len);
 		if (err) {
 			err = -errno;
-			pr_warn("failed to get BTF object #%d info: %d\n", id, err);
+			pr_warn("failed to get BTF object #%d info: %s\n", id, errstr(err));
 			goto err_out;
 		}
 
@@ -5701,8 +5685,8 @@ static int load_module_btfs(struct bpf_object *obj)
 		btf = btf_get_from_fd(fd, obj->btf_vmlinux);
 		err = libbpf_get_error(btf);
 		if (err) {
-			pr_warn("failed to load module [%s]'s BTF object #%d: %d\n",
-				name, id, err);
+			pr_warn("failed to load module [%s]'s BTF object #%d: %s\n",
+				name, id, errstr(err));
 			goto err_out;
 		}
 
@@ -5931,7 +5915,7 @@ bpf_object__relocate_core(struct bpf_object *obj, const char *targ_btf_path)
 		obj->btf_vmlinux_override = btf__parse(targ_btf_path, NULL);
 		err = libbpf_get_error(obj->btf_vmlinux_override);
 		if (err) {
-			pr_warn("failed to parse target BTF: %d\n", err);
+			pr_warn("failed to parse target BTF: %s\n", errstr(err));
 			return err;
 		}
 	}
@@ -5991,8 +5975,8 @@ bpf_object__relocate_core(struct bpf_object *obj, const char *targ_btf_path)
 
 			err = record_relo_core(prog, rec, insn_idx);
 			if (err) {
-				pr_warn("prog '%s': relo #%d: failed to record relocation: %d\n",
-					prog->name, i, err);
+				pr_warn("prog '%s': relo #%d: failed to record relocation: %s\n",
+					prog->name, i, errstr(err));
 				goto out;
 			}
 
@@ -6001,15 +5985,15 @@ bpf_object__relocate_core(struct bpf_object *obj, const char *targ_btf_path)
 
 			err = bpf_core_resolve_relo(prog, rec, i, obj->btf, cand_cache, &targ_res);
 			if (err) {
-				pr_warn("prog '%s': relo #%d: failed to relocate: %d\n",
-					prog->name, i, err);
+				pr_warn("prog '%s': relo #%d: failed to relocate: %s\n",
+					prog->name, i, errstr(err));
 				goto out;
 			}
 
 			err = bpf_core_patch_insn(prog->name, insn, insn_idx, rec, i, &targ_res);
 			if (err) {
-				pr_warn("prog '%s': relo #%d: failed to patch insn #%u: %d\n",
-					prog->name, i, insn_idx, err);
+				pr_warn("prog '%s': relo #%d: failed to patch insn #%u: %s\n",
+					prog->name, i, insn_idx, errstr(err));
 				goto out;
 			}
 		}
@@ -6277,8 +6261,8 @@ reloc_prog_func_and_line_info(const struct bpf_object *obj,
 				       &main_prog->func_info_rec_size);
 	if (err) {
 		if (err != -ENOENT) {
-			pr_warn("prog '%s': error relocating .BTF.ext function info: %d\n",
-				prog->name, err);
+			pr_warn("prog '%s': error relocating .BTF.ext function info: %s\n",
+				prog->name, errstr(err));
 			return err;
 		}
 		if (main_prog->func_info) {
@@ -6305,8 +6289,8 @@ reloc_prog_func_and_line_info(const struct bpf_object *obj,
 				       &main_prog->line_info_rec_size);
 	if (err) {
 		if (err != -ENOENT) {
-			pr_warn("prog '%s': error relocating .BTF.ext line info: %d\n",
-				prog->name, err);
+			pr_warn("prog '%s': error relocating .BTF.ext line info: %s\n",
+				prog->name, errstr(err));
 			return err;
 		}
 		if (main_prog->line_info) {
@@ -7070,8 +7054,8 @@ static int bpf_object__relocate(struct bpf_object *obj, const char *targ_btf_pat
 	if (obj->btf_ext) {
 		err = bpf_object__relocate_core(obj, targ_btf_path);
 		if (err) {
-			pr_warn("failed to perform CO-RE relocations: %d\n",
-				err);
+			pr_warn("failed to perform CO-RE relocations: %s\n",
+				errstr(err));
 			return err;
 		}
 		bpf_object__sort_relos(obj);
@@ -7115,8 +7099,8 @@ static int bpf_object__relocate(struct bpf_object *obj, const char *targ_btf_pat
 
 		err = bpf_object__relocate_calls(obj, prog);
 		if (err) {
-			pr_warn("prog '%s': failed to relocate calls: %d\n",
-				prog->name, err);
+			pr_warn("prog '%s': failed to relocate calls: %s\n",
+				prog->name, errstr(err));
 			return err;
 		}
 
@@ -7152,16 +7136,16 @@ static int bpf_object__relocate(struct bpf_object *obj, const char *targ_btf_pat
 		/* Process data relos for main programs */
 		err = bpf_object__relocate_data(obj, prog);
 		if (err) {
-			pr_warn("prog '%s': failed to relocate data references: %d\n",
-				prog->name, err);
+			pr_warn("prog '%s': failed to relocate data references: %s\n",
+				prog->name, errstr(err));
 			return err;
 		}
 
 		/* Fix up .BTF.ext information, if necessary */
 		err = bpf_program_fixup_func_info(obj, prog);
 		if (err) {
-			pr_warn("prog '%s': failed to perform .BTF.ext fix ups: %d\n",
-				prog->name, err);
+			pr_warn("prog '%s': failed to perform .BTF.ext fix ups: %s\n",
+				prog->name, errstr(err));
 			return err;
 		}
 	}
@@ -7470,7 +7454,6 @@ static int bpf_object_load_prog(struct bpf_object *obj, struct bpf_program *prog
 {
 	LIBBPF_OPTS(bpf_prog_load_opts, load_attr);
 	const char *prog_name = NULL;
-	char *cp, errmsg[STRERR_BUFSIZE];
 	size_t log_buf_size = 0;
 	char *log_buf = NULL, *tmp;
 	bool own_log_buf = true;
@@ -7534,8 +7517,8 @@ static int bpf_object_load_prog(struct bpf_object *obj, struct bpf_program *prog
 	if (prog->sec_def && prog->sec_def->prog_prepare_load_fn) {
 		err = prog->sec_def->prog_prepare_load_fn(prog, &load_attr, prog->sec_def->cookie);
 		if (err < 0) {
-			pr_warn("prog '%s': failed to prepare load attributes: %d\n",
-				prog->name, err);
+			pr_warn("prog '%s': failed to prepare load attributes: %s\n",
+				prog->name, errstr(err));
 			return err;
 		}
 		insns = prog->insns;
@@ -7599,9 +7582,8 @@ static int bpf_object_load_prog(struct bpf_object *obj, struct bpf_program *prog
 					continue;
 
 				if (bpf_prog_bind_map(ret, map->fd, NULL)) {
-					cp = libbpf_strerror_r(errno, errmsg, sizeof(errmsg));
 					pr_warn("prog '%s': failed to bind map '%s': %s\n",
-						prog->name, map->real_name, cp);
+						prog->name, map->real_name, errstr(errno));
 					/* Don't fail hard if can't bind rodata. */
 				}
 			}
@@ -7631,8 +7613,7 @@ static int bpf_object_load_prog(struct bpf_object *obj, struct bpf_program *prog
 	/* post-process verifier log to improve error descriptions */
 	fixup_verifier_log(prog, log_buf, log_buf_size);
 
-	cp = libbpf_strerror_r(errno, errmsg, sizeof(errmsg));
-	pr_warn("prog '%s': BPF program load failed: %s\n", prog->name, cp);
+	pr_warn("prog '%s': BPF program load failed: %s\n", prog->name, errstr(errno));
 	pr_perm_msg(ret);
 
 	if (own_log_buf && log_buf && log_buf[0] != '\0') {
@@ -7925,7 +7906,7 @@ bpf_object__load_progs(struct bpf_object *obj, int log_level)
 		err = bpf_object_load_prog(obj, prog, prog->insns, prog->insns_cnt,
 					   obj->license, obj->kern_version, &prog->fd);
 		if (err) {
-			pr_warn("prog '%s': failed to load: %d\n", prog->name, err);
+			pr_warn("prog '%s': failed to load: %s\n", prog->name, errstr(err));
 			return err;
 		}
 	}
@@ -7959,8 +7940,8 @@ static int bpf_object_init_progs(struct bpf_object *obj, const struct bpf_object
 		if (prog->sec_def->prog_setup_fn) {
 			err = prog->sec_def->prog_setup_fn(prog, prog->sec_def->cookie);
 			if (err < 0) {
-				pr_warn("prog '%s': failed to initialize: %d\n",
-					prog->name, err);
+				pr_warn("prog '%s': failed to initialize: %s\n",
+					prog->name, errstr(err));
 				return err;
 			}
 		}
@@ -8149,7 +8130,7 @@ static int libbpf_kallsyms_parse(kallsyms_cb_t cb, void *ctx)
 	f = fopen("/proc/kallsyms", "re");
 	if (!f) {
 		err = -errno;
-		pr_warn("failed to open /proc/kallsyms: %d\n", err);
+		pr_warn("failed to open /proc/kallsyms: %s\n", errstr(err));
 		return err;
 	}
 
@@ -8633,7 +8614,6 @@ int bpf_object__load(struct bpf_object *obj)
 
 static int make_parent_dir(const char *path)
 {
-	char *cp, errmsg[STRERR_BUFSIZE];
 	char *dname, *dir;
 	int err = 0;
 
@@ -8647,15 +8627,13 @@ static int make_parent_dir(const char *path)
 
 	free(dname);
 	if (err) {
-		cp = libbpf_strerror_r(-err, errmsg, sizeof(errmsg));
-		pr_warn("failed to mkdir %s: %s\n", path, cp);
+		pr_warn("failed to mkdir %s: %s\n", path, errstr(err));
 	}
 	return err;
 }
 
 static int check_path(const char *path)
 {
-	char *cp, errmsg[STRERR_BUFSIZE];
 	struct statfs st_fs;
 	char *dname, *dir;
 	int err = 0;
@@ -8669,8 +8647,7 @@ static int check_path(const char *path)
 
 	dir = dirname(dname);
 	if (statfs(dir, &st_fs)) {
-		cp = libbpf_strerror_r(errno, errmsg, sizeof(errmsg));
-		pr_warn("failed to statfs %s: %s\n", dir, cp);
+		pr_warn("failed to statfs %s: %s\n", dir, errstr(errno));
 		err = -errno;
 	}
 	free(dname);
@@ -8685,7 +8662,6 @@ static int check_path(const char *path)
 
 int bpf_program__pin(struct bpf_program *prog, const char *path)
 {
-	char *cp, errmsg[STRERR_BUFSIZE];
 	int err;
 
 	if (prog->fd < 0) {
@@ -8703,8 +8679,7 @@ int bpf_program__pin(struct bpf_program *prog, const char *path)
 
 	if (bpf_obj_pin(prog->fd, path)) {
 		err = -errno;
-		cp = libbpf_strerror_r(err, errmsg, sizeof(errmsg));
-		pr_warn("prog '%s': failed to pin at '%s': %s\n", prog->name, path, cp);
+		pr_warn("prog '%s': failed to pin at '%s': %s\n", prog->name, path, errstr(err));
 		return libbpf_err(err);
 	}
 
@@ -8735,7 +8710,6 @@ int bpf_program__unpin(struct bpf_program *prog, const char *path)
 
 int bpf_map__pin(struct bpf_map *map, const char *path)
 {
-	char *cp, errmsg[STRERR_BUFSIZE];
 	int err;
 
 	if (map == NULL) {
@@ -8794,8 +8768,7 @@ int bpf_map__pin(struct bpf_map *map, const char *path)
 	return 0;
 
 out_err:
-	cp = libbpf_strerror_r(-err, errmsg, sizeof(errmsg));
-	pr_warn("failed to pin map: %s\n", cp);
+	pr_warn("failed to pin map: %s\n", errstr(err));
 	return libbpf_err(err);
 }
 
@@ -9984,8 +9957,8 @@ static int libbpf_find_prog_btf_id(const char *name, __u32 attach_prog_fd)
 	memset(&info, 0, info_len);
 	err = bpf_prog_get_info_by_fd(attach_prog_fd, &info, &info_len);
 	if (err) {
-		pr_warn("failed bpf_prog_get_info_by_fd for FD %d: %d\n",
-			attach_prog_fd, err);
+		pr_warn("failed bpf_prog_get_info_by_fd for FD %d: %s\n",
+			attach_prog_fd, errstr(err));
 		return err;
 	}
 
@@ -9997,7 +9970,7 @@ static int libbpf_find_prog_btf_id(const char *name, __u32 attach_prog_fd)
 	btf = btf__load_from_kernel_by_id(info.btf_id);
 	err = libbpf_get_error(btf);
 	if (err) {
-		pr_warn("Failed to get BTF %d of the program: %d\n", info.btf_id, err);
+		pr_warn("Failed to get BTF %d of the program: %s\n", info.btf_id, errstr(err));
 		goto out;
 	}
 	err = btf__find_by_name_kind(btf, name, BTF_KIND_FUNC);
@@ -10079,8 +10052,8 @@ static int libbpf_find_attach_btf_id(struct bpf_program *prog, const char *attac
 		}
 		err = libbpf_find_prog_btf_id(attach_name, attach_prog_fd);
 		if (err < 0) {
-			pr_warn("prog '%s': failed to find BPF program (FD %d) BTF ID for '%s': %d\n",
-				 prog->name, attach_prog_fd, attach_name, err);
+			pr_warn("prog '%s': failed to find BPF program (FD %d) BTF ID for '%s': %s\n",
+				prog->name, attach_prog_fd, attach_name, errstr(err));
 			return err;
 		}
 		*btf_obj_fd = 0;
@@ -10099,8 +10072,8 @@ static int libbpf_find_attach_btf_id(struct bpf_program *prog, const char *attac
 					 btf_type_id);
 	}
 	if (err) {
-		pr_warn("prog '%s': failed to find kernel BTF type ID of '%s': %d\n",
-			prog->name, attach_name, err);
+		pr_warn("prog '%s': failed to find kernel BTF type ID of '%s': %s\n",
+			prog->name, attach_name, errstr(err));
 		return err;
 	}
 	return 0;
@@ -10328,14 +10301,14 @@ int bpf_map__set_value_size(struct bpf_map *map, __u32 size)
 		mmap_new_sz = array_map_mmap_sz(size, map->def.max_entries);
 		err = bpf_map_mmap_resize(map, mmap_old_sz, mmap_new_sz);
 		if (err) {
-			pr_warn("map '%s': failed to resize memory-mapped region: %d\n",
-				bpf_map__name(map), err);
+			pr_warn("map '%s': failed to resize memory-mapped region: %s\n",
+				bpf_map__name(map), errstr(err));
 			return err;
 		}
 		err = map_btf_datasec_resize(map, size);
 		if (err && err != -ENOENT) {
-			pr_warn("map '%s': failed to adjust resized BTF, clearing BTF key/value info: %d\n",
-				bpf_map__name(map), err);
+			pr_warn("map '%s': failed to adjust resized BTF, clearing BTF key/value info: %s\n",
+				bpf_map__name(map), errstr(err));
 			map->btf_value_type_id = 0;
 			map->btf_key_type_id = 0;
 		}
@@ -10826,7 +10799,6 @@ static void bpf_link_perf_dealloc(struct bpf_link *link)
 struct bpf_link *bpf_program__attach_perf_event_opts(const struct bpf_program *prog, int pfd,
 						     const struct bpf_perf_event_opts *opts)
 {
-	char errmsg[STRERR_BUFSIZE];
 	struct bpf_link_perf *link;
 	int prog_fd, link_fd = -1, err;
 	bool force_ioctl_attach;
@@ -10861,9 +10833,8 @@ struct bpf_link *bpf_program__attach_perf_event_opts(const struct bpf_program *p
 		link_fd = bpf_link_create(prog_fd, pfd, BPF_PERF_EVENT, &link_opts);
 		if (link_fd < 0) {
 			err = -errno;
-			pr_warn("prog '%s': failed to create BPF link for perf_event FD %d: %d (%s)\n",
-				prog->name, pfd,
-				err, libbpf_strerror_r(err, errmsg, sizeof(errmsg)));
+			pr_warn("prog '%s': failed to create BPF link for perf_event FD %d: %s\n",
+				prog->name, pfd, errstr(err));
 			goto err_out;
 		}
 		link->link.fd = link_fd;
@@ -10877,7 +10848,7 @@ struct bpf_link *bpf_program__attach_perf_event_opts(const struct bpf_program *p
 		if (ioctl(pfd, PERF_EVENT_IOC_SET_BPF, prog_fd) < 0) {
 			err = -errno;
 			pr_warn("prog '%s': failed to attach to perf_event FD %d: %s\n",
-				prog->name, pfd, libbpf_strerror_r(err, errmsg, sizeof(errmsg)));
+				prog->name, pfd, errstr(err));
 			if (err == -EPROTO)
 				pr_warn("prog '%s': try add PERF_SAMPLE_CALLCHAIN to or remove exclude_callchain_[kernel|user] from pfd %d\n",
 					prog->name, pfd);
@@ -10888,7 +10859,7 @@ struct bpf_link *bpf_program__attach_perf_event_opts(const struct bpf_program *p
 	if (ioctl(pfd, PERF_EVENT_IOC_ENABLE, 0) < 0) {
 		err = -errno;
 		pr_warn("prog '%s': failed to enable perf_event FD %d: %s\n",
-			prog->name, pfd, libbpf_strerror_r(err, errmsg, sizeof(errmsg)));
+			prog->name, pfd, errstr(err));
 		goto err_out;
 	}
 
@@ -10912,22 +10883,19 @@ struct bpf_link *bpf_program__attach_perf_event(const struct bpf_program *prog,
  */
 static int parse_uint_from_file(const char *file, const char *fmt)
 {
-	char buf[STRERR_BUFSIZE];
 	int err, ret;
 	FILE *f;
 
 	f = fopen(file, "re");
 	if (!f) {
 		err = -errno;
-		pr_debug("failed to open '%s': %s\n", file,
-			 libbpf_strerror_r(err, buf, sizeof(buf)));
+		pr_debug("failed to open '%s': %s\n", file, errstr(err));
 		return err;
 	}
 	err = fscanf(f, fmt, &ret);
 	if (err != 1) {
 		err = err == EOF ? -EIO : -errno;
-		pr_debug("failed to parse '%s': %s\n", file,
-			libbpf_strerror_r(err, buf, sizeof(buf)));
+		pr_debug("failed to parse '%s': %s\n", file, errstr(err));
 		fclose(f);
 		return err;
 	}
@@ -10971,7 +10939,6 @@ static int perf_event_open_probe(bool uprobe, bool retprobe, const char *name,
 {
 	const size_t attr_sz = sizeof(struct perf_event_attr);
 	struct perf_event_attr attr;
-	char errmsg[STRERR_BUFSIZE];
 	int type, pfd;
 
 	if ((__u64)ref_ctr_off >= (1ULL << PERF_UPROBE_REF_CTR_OFFSET_BITS))
@@ -10984,7 +10951,7 @@ static int perf_event_open_probe(bool uprobe, bool retprobe, const char *name,
 	if (type < 0) {
 		pr_warn("failed to determine %s perf type: %s\n",
 			uprobe ? "uprobe" : "kprobe",
-			libbpf_strerror_r(type, errmsg, sizeof(errmsg)));
+			errstr(type));
 		return type;
 	}
 	if (retprobe) {
@@ -10994,7 +10961,7 @@ static int perf_event_open_probe(bool uprobe, bool retprobe, const char *name,
 		if (bit < 0) {
 			pr_warn("failed to determine %s retprobe bit: %s\n",
 				uprobe ? "uprobe" : "kprobe",
-				libbpf_strerror_r(bit, errmsg, sizeof(errmsg)));
+				errstr(bit));
 			return bit;
 		}
 		attr.config |= 1 << bit;
@@ -11123,14 +11090,13 @@ static int perf_event_kprobe_open_legacy(const char *probe_name, bool retprobe,
 {
 	const size_t attr_sz = sizeof(struct perf_event_attr);
 	struct perf_event_attr attr;
-	char errmsg[STRERR_BUFSIZE];
 	int type, pfd, err;
 
 	err = add_kprobe_event_legacy(probe_name, retprobe, kfunc_name, offset);
 	if (err < 0) {
 		pr_warn("failed to add legacy kprobe event for '%s+0x%zx': %s\n",
 			kfunc_name, offset,
-			libbpf_strerror_r(err, errmsg, sizeof(errmsg)));
+			errstr(err));
 		return err;
 	}
 	type = determine_kprobe_perf_type_legacy(probe_name, retprobe);
@@ -11138,7 +11104,7 @@ static int perf_event_kprobe_open_legacy(const char *probe_name, bool retprobe,
 		err = type;
 		pr_warn("failed to determine legacy kprobe event id for '%s+0x%zx': %s\n",
 			kfunc_name, offset,
-			libbpf_strerror_r(err, errmsg, sizeof(errmsg)));
+			errstr(err));
 		goto err_clean_legacy;
 	}
 
@@ -11154,7 +11120,7 @@ static int perf_event_kprobe_open_legacy(const char *probe_name, bool retprobe,
 	if (pfd < 0) {
 		err = -errno;
 		pr_warn("legacy kprobe perf_event_open() failed: %s\n",
-			libbpf_strerror_r(err, errmsg, sizeof(errmsg)));
+			errstr(err));
 		goto err_clean_legacy;
 	}
 	return pfd;
@@ -11230,7 +11196,6 @@ bpf_program__attach_kprobe_opts(const struct bpf_program *prog,
 {
 	DECLARE_LIBBPF_OPTS(bpf_perf_event_opts, pe_opts);
 	enum probe_attach_mode attach_mode;
-	char errmsg[STRERR_BUFSIZE];
 	char *legacy_probe = NULL;
 	struct bpf_link *link;
 	size_t offset;
@@ -11288,7 +11253,7 @@ bpf_program__attach_kprobe_opts(const struct bpf_program *prog,
 		pr_warn("prog '%s': failed to create %s '%s+0x%zx' perf event: %s\n",
 			prog->name, retprobe ? "kretprobe" : "kprobe",
 			func_name, offset,
-			libbpf_strerror_r(err, errmsg, sizeof(errmsg)));
+			errstr(err));
 		goto err_out;
 	}
 	link = bpf_program__attach_perf_event_opts(prog, pfd, &pe_opts);
@@ -11298,7 +11263,7 @@ bpf_program__attach_kprobe_opts(const struct bpf_program *prog,
 		pr_warn("prog '%s': failed to attach to %s '%s+0x%zx': %s\n",
 			prog->name, retprobe ? "kretprobe" : "kprobe",
 			func_name, offset,
-			libbpf_strerror_r(err, errmsg, sizeof(errmsg)));
+			errstr(err));
 		goto err_clean_legacy;
 	}
 	if (legacy) {
@@ -11434,7 +11399,7 @@ static int libbpf_available_kallsyms_parse(struct kprobe_multi_resolve *res)
 	f = fopen(available_functions_file, "re");
 	if (!f) {
 		err = -errno;
-		pr_warn("failed to open %s: %d\n", available_functions_file, err);
+		pr_warn("failed to open %s: %s\n", available_functions_file, errstr(err));
 		return err;
 	}
 
@@ -11509,7 +11474,7 @@ static int libbpf_available_kprobes_parse(struct kprobe_multi_resolve *res)
 	f = fopen(available_path, "re");
 	if (!f) {
 		err = -errno;
-		pr_warn("failed to open %s: %d\n", available_path, err);
+		pr_warn("failed to open %s: %s\n", available_path, errstr(err));
 		return err;
 	}
 
@@ -11555,7 +11520,6 @@ bpf_program__attach_kprobe_multi_opts(const struct bpf_program *prog,
 	};
 	enum bpf_attach_type attach_type;
 	struct bpf_link *link = NULL;
-	char errmsg[STRERR_BUFSIZE];
 	const unsigned long *addrs;
 	int err, link_fd, prog_fd;
 	bool retprobe, session;
@@ -11623,7 +11587,7 @@ bpf_program__attach_kprobe_multi_opts(const struct bpf_program *prog,
 	if (link_fd < 0) {
 		err = -errno;
 		pr_warn("prog '%s': failed to attach: %s\n",
-			prog->name, libbpf_strerror_r(err, errmsg, sizeof(errmsg)));
+			prog->name, errstr(err));
 		goto error;
 	}
 	link->fd = link_fd;
@@ -11832,15 +11796,15 @@ static int perf_event_uprobe_open_legacy(const char *probe_name, bool retprobe,
 
 	err = add_uprobe_event_legacy(probe_name, retprobe, binary_path, offset);
 	if (err < 0) {
-		pr_warn("failed to add legacy uprobe event for %s:0x%zx: %d\n",
-			binary_path, (size_t)offset, err);
+		pr_warn("failed to add legacy uprobe event for %s:0x%zx: %s\n",
+			binary_path, (size_t)offset, errstr(err));
 		return err;
 	}
 	type = determine_uprobe_perf_type_legacy(probe_name, retprobe);
 	if (type < 0) {
 		err = type;
-		pr_warn("failed to determine legacy uprobe event id for %s:0x%zx: %d\n",
-			binary_path, offset, err);
+		pr_warn("failed to determine legacy uprobe event id for %s:0x%zx: %s\n",
+			binary_path, offset, errstr(err));
 		goto err_clean_legacy;
 	}
 
@@ -11855,7 +11819,7 @@ static int perf_event_uprobe_open_legacy(const char *probe_name, bool retprobe,
 		      -1 /* group_fd */,  PERF_FLAG_FD_CLOEXEC);
 	if (pfd < 0) {
 		err = -errno;
-		pr_warn("legacy uprobe perf_event_open() failed: %d\n", err);
+		pr_warn("legacy uprobe perf_event_open() failed: %s\n", errstr(err));
 		goto err_clean_legacy;
 	}
 	return pfd;
@@ -12021,7 +11985,6 @@ bpf_program__attach_uprobe_multi(const struct bpf_program *prog,
 	enum bpf_attach_type attach_type;
 	int err = 0, link_fd, prog_fd;
 	struct bpf_link *link = NULL;
-	char errmsg[STRERR_BUFSIZE];
 	char full_path[PATH_MAX];
 	bool retprobe, session;
 	const __u64 *cookies;
@@ -12075,8 +12038,8 @@ bpf_program__attach_uprobe_multi(const struct bpf_program *prog,
 		if (!strchr(path, '/')) {
 			err = resolve_full_path(path, full_path, sizeof(full_path));
 			if (err) {
-				pr_warn("prog '%s': failed to resolve full path for '%s': %d\n",
-					prog->name, path, err);
+				pr_warn("prog '%s': failed to resolve full path for '%s': %s\n",
+					prog->name, path, errstr(err));
 				return libbpf_err_ptr(err);
 			}
 			path = full_path;
@@ -12125,7 +12088,7 @@ bpf_program__attach_uprobe_multi(const struct bpf_program *prog,
 	if (link_fd < 0) {
 		err = -errno;
 		pr_warn("prog '%s': failed to attach multi-uprobe: %s\n",
-			prog->name, libbpf_strerror_r(err, errmsg, sizeof(errmsg)));
+			prog->name, errstr(err));
 		goto error;
 	}
 	link->fd = link_fd;
@@ -12144,7 +12107,7 @@ bpf_program__attach_uprobe_opts(const struct bpf_program *prog, pid_t pid,
 				const struct bpf_uprobe_opts *opts)
 {
 	const char *archive_path = NULL, *archive_sep = NULL;
-	char errmsg[STRERR_BUFSIZE], *legacy_probe = NULL;
+	char *legacy_probe = NULL;
 	DECLARE_LIBBPF_OPTS(bpf_perf_event_opts, pe_opts);
 	enum probe_attach_mode attach_mode;
 	char full_path[PATH_MAX];
@@ -12176,8 +12139,8 @@ bpf_program__attach_uprobe_opts(const struct bpf_program *prog, pid_t pid,
 	} else if (!strchr(binary_path, '/')) {
 		err = resolve_full_path(binary_path, full_path, sizeof(full_path));
 		if (err) {
-			pr_warn("prog '%s': failed to resolve full path for '%s': %d\n",
-				prog->name, binary_path, err);
+			pr_warn("prog '%s': failed to resolve full path for '%s': %s\n",
+				prog->name, binary_path, errstr(err));
 			return libbpf_err_ptr(err);
 		}
 		binary_path = full_path;
@@ -12243,7 +12206,7 @@ bpf_program__attach_uprobe_opts(const struct bpf_program *prog, pid_t pid,
 		pr_warn("prog '%s': failed to create %s '%s:0x%zx' perf event: %s\n",
 			prog->name, retprobe ? "uretprobe" : "uprobe",
 			binary_path, func_offset,
-			libbpf_strerror_r(err, errmsg, sizeof(errmsg)));
+			errstr(err));
 		goto err_out;
 	}
 
@@ -12254,7 +12217,7 @@ bpf_program__attach_uprobe_opts(const struct bpf_program *prog, pid_t pid,
 		pr_warn("prog '%s': failed to attach to %s '%s:0x%zx': %s\n",
 			prog->name, retprobe ? "uretprobe" : "uprobe",
 			binary_path, func_offset,
-			libbpf_strerror_r(err, errmsg, sizeof(errmsg)));
+			errstr(err));
 		goto err_clean_legacy;
 	}
 	if (legacy) {
@@ -12375,8 +12338,8 @@ struct bpf_link *bpf_program__attach_usdt(const struct bpf_program *prog,
 	if (!strchr(binary_path, '/')) {
 		err = resolve_full_path(binary_path, resolved_path, sizeof(resolved_path));
 		if (err) {
-			pr_warn("prog '%s': failed to resolve full path for '%s': %d\n",
-				prog->name, binary_path, err);
+			pr_warn("prog '%s': failed to resolve full path for '%s': %s\n",
+				prog->name, binary_path, errstr(err));
 			return libbpf_err_ptr(err);
 		}
 		binary_path = resolved_path;
@@ -12454,14 +12417,13 @@ static int perf_event_open_tracepoint(const char *tp_category,
 {
 	const size_t attr_sz = sizeof(struct perf_event_attr);
 	struct perf_event_attr attr;
-	char errmsg[STRERR_BUFSIZE];
 	int tp_id, pfd, err;
 
 	tp_id = determine_tracepoint_id(tp_category, tp_name);
 	if (tp_id < 0) {
 		pr_warn("failed to determine tracepoint '%s/%s' perf event ID: %s\n",
 			tp_category, tp_name,
-			libbpf_strerror_r(tp_id, errmsg, sizeof(errmsg)));
+			errstr(tp_id));
 		return tp_id;
 	}
 
@@ -12476,7 +12438,7 @@ static int perf_event_open_tracepoint(const char *tp_category,
 		err = -errno;
 		pr_warn("tracepoint '%s/%s' perf_event_open() failed: %s\n",
 			tp_category, tp_name,
-			libbpf_strerror_r(err, errmsg, sizeof(errmsg)));
+			errstr(err));
 		return err;
 	}
 	return pfd;
@@ -12488,7 +12450,6 @@ struct bpf_link *bpf_program__attach_tracepoint_opts(const struct bpf_program *p
 						     const struct bpf_tracepoint_opts *opts)
 {
 	DECLARE_LIBBPF_OPTS(bpf_perf_event_opts, pe_opts);
-	char errmsg[STRERR_BUFSIZE];
 	struct bpf_link *link;
 	int pfd, err;
 
@@ -12501,7 +12462,7 @@ struct bpf_link *bpf_program__attach_tracepoint_opts(const struct bpf_program *p
 	if (pfd < 0) {
 		pr_warn("prog '%s': failed to create tracepoint '%s/%s' perf event: %s\n",
 			prog->name, tp_category, tp_name,
-			libbpf_strerror_r(pfd, errmsg, sizeof(errmsg)));
+			errstr(pfd));
 		return libbpf_err_ptr(pfd);
 	}
 	link = bpf_program__attach_perf_event_opts(prog, pfd, &pe_opts);
@@ -12510,7 +12471,7 @@ struct bpf_link *bpf_program__attach_tracepoint_opts(const struct bpf_program *p
 		close(pfd);
 		pr_warn("prog '%s': failed to attach to tracepoint '%s/%s': %s\n",
 			prog->name, tp_category, tp_name,
-			libbpf_strerror_r(err, errmsg, sizeof(errmsg)));
+			errstr(err));
 		return libbpf_err_ptr(err);
 	}
 	return link;
@@ -12561,7 +12522,6 @@ bpf_program__attach_raw_tracepoint_opts(const struct bpf_program *prog,
 					struct bpf_raw_tracepoint_opts *opts)
 {
 	LIBBPF_OPTS(bpf_raw_tp_opts, raw_opts);
-	char errmsg[STRERR_BUFSIZE];
 	struct bpf_link *link;
 	int prog_fd, pfd;
 
@@ -12586,7 +12546,7 @@ bpf_program__attach_raw_tracepoint_opts(const struct bpf_program *prog,
 		pfd = -errno;
 		free(link);
 		pr_warn("prog '%s': failed to attach to raw tracepoint '%s': %s\n",
-			prog->name, tp_name, libbpf_strerror_r(pfd, errmsg, sizeof(errmsg)));
+			prog->name, tp_name, errstr(pfd));
 		return libbpf_err_ptr(pfd);
 	}
 	link->fd = pfd;
@@ -12645,7 +12605,6 @@ static struct bpf_link *bpf_program__attach_btf_id(const struct bpf_program *pro
 						   const struct bpf_trace_opts *opts)
 {
 	LIBBPF_OPTS(bpf_link_create_opts, link_opts);
-	char errmsg[STRERR_BUFSIZE];
 	struct bpf_link *link;
 	int prog_fd, pfd;
 
@@ -12670,7 +12629,7 @@ static struct bpf_link *bpf_program__attach_btf_id(const struct bpf_program *pro
 		pfd = -errno;
 		free(link);
 		pr_warn("prog '%s': failed to attach: %s\n",
-			prog->name, libbpf_strerror_r(pfd, errmsg, sizeof(errmsg)));
+			prog->name, errstr(pfd));
 		return libbpf_err_ptr(pfd);
 	}
 	link->fd = pfd;
@@ -12711,7 +12670,6 @@ bpf_program_attach_fd(const struct bpf_program *prog,
 		      const struct bpf_link_create_opts *opts)
 {
 	enum bpf_attach_type attach_type;
-	char errmsg[STRERR_BUFSIZE];
 	struct bpf_link *link;
 	int prog_fd, link_fd;
 
@@ -12733,7 +12691,7 @@ bpf_program_attach_fd(const struct bpf_program *prog,
 		free(link);
 		pr_warn("prog '%s': failed to attach to %s: %s\n",
 			prog->name, target_name,
-			libbpf_strerror_r(link_fd, errmsg, sizeof(errmsg)));
+			errstr(link_fd));
 		return libbpf_err_ptr(link_fd);
 	}
 	link->fd = link_fd;
@@ -12875,7 +12833,6 @@ bpf_program__attach_iter(const struct bpf_program *prog,
 			 const struct bpf_iter_attach_opts *opts)
 {
 	DECLARE_LIBBPF_OPTS(bpf_link_create_opts, link_create_opts);
-	char errmsg[STRERR_BUFSIZE];
 	struct bpf_link *link;
 	int prog_fd, link_fd;
 	__u32 target_fd = 0;
@@ -12903,7 +12860,7 @@ bpf_program__attach_iter(const struct bpf_program *prog,
 		link_fd = -errno;
 		free(link);
 		pr_warn("prog '%s': failed to attach to iterator: %s\n",
-			prog->name, libbpf_strerror_r(link_fd, errmsg, sizeof(errmsg)));
+			prog->name, errstr(link_fd));
 		return libbpf_err_ptr(link_fd);
 	}
 	link->fd = link_fd;
@@ -12945,12 +12902,10 @@ struct bpf_link *bpf_program__attach_netfilter(const struct bpf_program *prog,
 
 	link_fd = bpf_link_create(prog_fd, 0, BPF_NETFILTER, &lopts);
 	if (link_fd < 0) {
-		char errmsg[STRERR_BUFSIZE];
-
 		link_fd = -errno;
 		free(link);
 		pr_warn("prog '%s': failed to attach to netfilter: %s\n",
-			prog->name, libbpf_strerror_r(link_fd, errmsg, sizeof(errmsg)));
+			prog->name, errstr(link_fd));
 		return libbpf_err_ptr(link_fd);
 	}
 	link->fd = link_fd;
@@ -13235,7 +13190,6 @@ perf_buffer__open_cpu_buf(struct perf_buffer *pb, struct perf_event_attr *attr,
 			  int cpu, int map_key)
 {
 	struct perf_cpu_buf *cpu_buf;
-	char msg[STRERR_BUFSIZE];
 	int err;
 
 	cpu_buf = calloc(1, sizeof(*cpu_buf));
@@ -13251,7 +13205,7 @@ perf_buffer__open_cpu_buf(struct perf_buffer *pb, struct perf_event_attr *attr,
 	if (cpu_buf->fd < 0) {
 		err = -errno;
 		pr_warn("failed to open perf buffer event on cpu #%d: %s\n",
-			cpu, libbpf_strerror_r(err, msg, sizeof(msg)));
+			cpu, errstr(err));
 		goto error;
 	}
 
@@ -13262,14 +13216,14 @@ perf_buffer__open_cpu_buf(struct perf_buffer *pb, struct perf_event_attr *attr,
 		cpu_buf->base = NULL;
 		err = -errno;
 		pr_warn("failed to mmap perf buffer on cpu #%d: %s\n",
-			cpu, libbpf_strerror_r(err, msg, sizeof(msg)));
+			cpu, errstr(err));
 		goto error;
 	}
 
 	if (ioctl(cpu_buf->fd, PERF_EVENT_IOC_ENABLE, 0) < 0) {
 		err = -errno;
 		pr_warn("failed to enable perf buffer event on cpu #%d: %s\n",
-			cpu, libbpf_strerror_r(err, msg, sizeof(msg)));
+			cpu, errstr(err));
 		goto error;
 	}
 
@@ -13345,7 +13299,6 @@ static struct perf_buffer *__perf_buffer__new(int map_fd, size_t page_cnt,
 {
 	const char *online_cpus_file = "/sys/devices/system/cpu/online";
 	struct bpf_map_info map;
-	char msg[STRERR_BUFSIZE];
 	struct perf_buffer *pb;
 	bool *online = NULL;
 	__u32 map_info_len;
@@ -13368,7 +13321,7 @@ static struct perf_buffer *__perf_buffer__new(int map_fd, size_t page_cnt,
 		 */
 		if (err != -EINVAL) {
 			pr_warn("failed to get map info for map FD %d: %s\n",
-				map_fd, libbpf_strerror_r(err, msg, sizeof(msg)));
+				map_fd, errstr(err));
 			return ERR_PTR(err);
 		}
 		pr_debug("failed to get map info for FD %d; API not supported? Ignoring...\n",
@@ -13398,7 +13351,7 @@ static struct perf_buffer *__perf_buffer__new(int map_fd, size_t page_cnt,
 	if (pb->epoll_fd < 0) {
 		err = -errno;
 		pr_warn("failed to create epoll instance: %s\n",
-			libbpf_strerror_r(err, msg, sizeof(msg)));
+			errstr(err));
 		goto error;
 	}
 
@@ -13429,7 +13382,7 @@ static struct perf_buffer *__perf_buffer__new(int map_fd, size_t page_cnt,
 
 	err = parse_cpu_mask_file(online_cpus_file, &online, &n);
 	if (err) {
-		pr_warn("failed to get online CPU mask: %d\n", err);
+		pr_warn("failed to get online CPU mask: %s\n", errstr(err));
 		goto error;
 	}
 
@@ -13460,7 +13413,7 @@ static struct perf_buffer *__perf_buffer__new(int map_fd, size_t page_cnt,
 			err = -errno;
 			pr_warn("failed to set cpu #%d, key %d -> perf FD %d: %s\n",
 				cpu, map_key, cpu_buf->fd,
-				libbpf_strerror_r(err, msg, sizeof(msg)));
+				errstr(err));
 			goto error;
 		}
 
@@ -13471,7 +13424,7 @@ static struct perf_buffer *__perf_buffer__new(int map_fd, size_t page_cnt,
 			err = -errno;
 			pr_warn("failed to epoll_ctl cpu #%d perf FD %d: %s\n",
 				cpu, cpu_buf->fd,
-				libbpf_strerror_r(err, msg, sizeof(msg)));
+				errstr(err));
 			goto error;
 		}
 		j++;
@@ -13566,7 +13519,7 @@ int perf_buffer__poll(struct perf_buffer *pb, int timeout_ms)
 
 		err = perf_buffer__process_records(pb, cpu_buf);
 		if (err) {
-			pr_warn("error while processing records: %d\n", err);
+			pr_warn("error while processing records: %s\n", errstr(err));
 			return libbpf_err(err);
 		}
 	}
@@ -13650,7 +13603,8 @@ int perf_buffer__consume(struct perf_buffer *pb)
 
 		err = perf_buffer__process_records(pb, cpu_buf);
 		if (err) {
-			pr_warn("perf_buffer: failed to process records in buffer #%d: %d\n", i, err);
+			pr_warn("perf_buffer: failed to process records in buffer #%d: %s\n",
+				i, errstr(err));
 			return libbpf_err(err);
 		}
 	}
@@ -13761,14 +13715,14 @@ int parse_cpu_mask_file(const char *fcpu, bool **mask, int *mask_sz)
 	fd = open(fcpu, O_RDONLY | O_CLOEXEC);
 	if (fd < 0) {
 		err = -errno;
-		pr_warn("Failed to open cpu mask file %s: %d\n", fcpu, err);
+		pr_warn("Failed to open cpu mask file %s: %s\n", fcpu, errstr(err));
 		return err;
 	}
 	len = read(fd, buf, sizeof(buf));
 	close(fd);
 	if (len <= 0) {
 		err = len ? -errno : -EINVAL;
-		pr_warn("Failed to read cpu mask from %s: %d\n", fcpu, err);
+		pr_warn("Failed to read cpu mask from %s: %s\n", fcpu, errstr(err));
 		return err;
 	}
 	if (len >= sizeof(buf)) {
@@ -13860,20 +13814,21 @@ int bpf_object__open_skeleton(struct bpf_object_skeleton *s,
 	obj = bpf_object_open(NULL, s->data, s->data_sz, s->name, opts);
 	if (IS_ERR(obj)) {
 		err = PTR_ERR(obj);
-		pr_warn("failed to initialize skeleton BPF object '%s': %d\n", s->name, err);
+		pr_warn("failed to initialize skeleton BPF object '%s': %s\n",
+			s->name, errstr(err));
 		return libbpf_err(err);
 	}
 
 	*s->obj = obj;
 	err = populate_skeleton_maps(obj, s->maps, s->map_cnt, s->map_skel_sz);
 	if (err) {
-		pr_warn("failed to populate skeleton maps for '%s': %d\n", s->name, err);
+		pr_warn("failed to populate skeleton maps for '%s': %s\n", s->name, errstr(err));
 		return libbpf_err(err);
 	}
 
 	err = populate_skeleton_progs(obj, s->progs, s->prog_cnt, s->prog_skel_sz);
 	if (err) {
-		pr_warn("failed to populate skeleton progs for '%s': %d\n", s->name, err);
+		pr_warn("failed to populate skeleton progs for '%s': %s\n", s->name, errstr(err));
 		return libbpf_err(err);
 	}
 
@@ -13903,13 +13858,13 @@ int bpf_object__open_subskeleton(struct bpf_object_subskeleton *s)
 
 	err = populate_skeleton_maps(s->obj, s->maps, s->map_cnt, s->map_skel_sz);
 	if (err) {
-		pr_warn("failed to populate subskeleton maps: %d\n", err);
+		pr_warn("failed to populate subskeleton maps: %s\n", errstr(err));
 		return libbpf_err(err);
 	}
 
 	err = populate_skeleton_progs(s->obj, s->progs, s->prog_cnt, s->prog_skel_sz);
 	if (err) {
-		pr_warn("failed to populate subskeleton maps: %d\n", err);
+		pr_warn("failed to populate subskeleton maps: %s\n", errstr(err));
 		return libbpf_err(err);
 	}
 
@@ -13956,7 +13911,7 @@ int bpf_object__load_skeleton(struct bpf_object_skeleton *s)
 
 	err = bpf_object__load(*s->obj);
 	if (err) {
-		pr_warn("failed to load BPF skeleton '%s': %d\n", s->name, err);
+		pr_warn("failed to load BPF skeleton '%s': %s\n", s->name, errstr(err));
 		return libbpf_err(err);
 	}
 
@@ -13995,8 +13950,8 @@ int bpf_object__attach_skeleton(struct bpf_object_skeleton *s)
 
 		err = prog->sec_def->prog_attach_fn(prog, prog->sec_def->cookie, link);
 		if (err) {
-			pr_warn("prog '%s': failed to auto-attach: %d\n",
-				bpf_program__name(prog), err);
+			pr_warn("prog '%s': failed to auto-attach: %s\n",
+				bpf_program__name(prog), errstr(err));
 			return libbpf_err(err);
 		}
 
@@ -14039,7 +13994,8 @@ int bpf_object__attach_skeleton(struct bpf_object_skeleton *s)
 		*link = bpf_map__attach_struct_ops(map);
 		if (!*link) {
 			err = -errno;
-			pr_warn("map '%s': failed to auto-attach: %d\n", bpf_map__name(map), err);
+			pr_warn("map '%s': failed to auto-attach: %s\n",
+				bpf_map__name(map), errstr(err));
 			return libbpf_err(err);
 		}
 	}
-- 
2.47.0


