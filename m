Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 370D9244EBF
	for <lists+bpf@lfdr.de>; Fri, 14 Aug 2020 21:16:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728082AbgHNTQF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 14 Aug 2020 15:16:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726652AbgHNTQF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 14 Aug 2020 15:16:05 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E4ABC061385
        for <bpf@vger.kernel.org>; Fri, 14 Aug 2020 12:16:05 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id z3so9368597ilh.3
        for <bpf@vger.kernel.org>; Fri, 14 Aug 2020 12:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u6PVJvwPCQC+XR849wkWtonb95LC2TdeUz0P8ui6S6M=;
        b=rRkpYYleSkutg6uZU64d1utRbS8mSqr/gbePEIEkRGsZ20MPObKXu/i2KsYzRwsvWs
         g5YIe4BAXAhpEVUiOTE3F2F+65yrbvue4JMJDn08wvyQcT0oaS5prgG6B2xpZDHIEqzc
         GkFsDObGawTPvRneYGrnAxYnBSh8Hsl3dXUJfOsibq/EiGyNN//AC+3/zrPnZlQ6nFeh
         QC2cIkq4z3diz7pCPzH7E3CN0rAN9zZ2rgWCX8svdcHqjyOPecEg+O/UJl75Uc+GP9EA
         32woq9A8zcsmiO4K8cwDn7PFsDv8mPB3n6Vau+8WokX9RXPaU+1xDYvu5olHBzsD5m4+
         86RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u6PVJvwPCQC+XR849wkWtonb95LC2TdeUz0P8ui6S6M=;
        b=Nw1NjlwBCNnj1wglupY7tjisqAODgjADaaploR75+jh4cLciHCu0hMDpezxtRs5ys+
         1pKC6I1iLMXXYOvil0bdeAhWNK2IMkL7nMVmp6xQxXmBd7l1/YBLNXEITslmQKP9U87g
         obH5wBUfQXmQT4UhGdFfxNN5w3IaCcM7royqF4RXaVVoWIsKLCBnAc+zRsPQls4ma25b
         82D4ZBzinyRUvPxuxHUEwXBW45ToN0QbTLtx7kj8ey+qc/C5zuyZzZRoK7Iq30H3LK40
         ybPmKXu96w0ol7vIGg50tmbFDv+WJQiLMxlAq++dhjcaSVrvXrKCEQ584U6/O4r02ZR8
         /htA==
X-Gm-Message-State: AOAM533NDd5pXTmpQR9DE/DmvnUv7e2ZhxRefNmU9w90a4DfAuxNR45k
        SqPBhef/JxTslPUkgPHRHfqq7t5W2mopAw==
X-Google-Smtp-Source: ABdhPJzT7Xf5DhxQI4MwAnKnNHSwyz6CGNyT6hD4+b92sTNQtCgju9DeFwYs0zgBgXWpzChhsIom6A==
X-Received: by 2002:a92:d44b:: with SMTP id r11mr3640748ilm.157.1597432564417;
        Fri, 14 Aug 2020 12:16:04 -0700 (PDT)
Received: from localhost.localdomain (host-173-230-99-219.tnkngak.clients.pavlovmedia.com. [173.230.99.219])
        by smtp.gmail.com with ESMTPSA id f15sm4521028ilc.51.2020.08.14.12.16.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2020 12:16:03 -0700 (PDT)
From:   YiFei Zhu <zhuyifei1999@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Stanislav Fomichev <sdf@google.com>,
        Mahesh Bandewar <maheshb@google.com>,
        YiFei Zhu <zhuyifei@google.com>
Subject: [RFC PATCH bpf-next 3/5] libbpf: Add BPF_PROG_ADD_MAP syscall and use it on .metadata section
Date:   Fri, 14 Aug 2020 14:15:56 -0500
Message-Id: <fc38f8f3d028eb8efa5d5a8339c5ad1813584018.1597427271.git.zhuyifei@google.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1597427271.git.zhuyifei@google.com>
References: <cover.1597427271.git.zhuyifei@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: YiFei Zhu <zhuyifei@google.com>

The patch adds a simple wrapper bpf_prog_add_map around the syscall.
And when using libbpf to load a program, it will probe the kernel for
the support of this syscall, and scan for the .metadata ELF section
and load it as an internal map like a .data section.

In the case that kernel supports the BPF_PROG_ADD_MAP syscall and
a .metadata section exists, the map will be explicitly attached to
the program via the syscall immediately after program is loaded.
-EEXIST is ignored for this syscall.

Signed-off-by: YiFei Zhu <zhuyifei@google.com>
---
 tools/lib/bpf/bpf.c      | 11 +++++
 tools/lib/bpf/bpf.h      |  1 +
 tools/lib/bpf/libbpf.c   | 97 +++++++++++++++++++++++++++++++++++++++-
 tools/lib/bpf/libbpf.map |  1 +
 4 files changed, 109 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index eab14c97c15d..9b2173d4f92c 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -872,3 +872,14 @@ int bpf_enable_stats(enum bpf_stats_type type)
 
 	return sys_bpf(BPF_ENABLE_STATS, &attr, sizeof(attr));
 }
+
+int bpf_prog_add_map(int prog_fd, int map_fd, int flags)
+{
+	union bpf_attr attr = {};
+
+	attr.prog_add_map.prog_fd = prog_fd;
+	attr.prog_add_map.map_fd = map_fd;
+	attr.prog_add_map.flags = flags;
+
+	return sys_bpf(BPF_PROG_ADD_MAP, &attr, sizeof(attr));
+}
diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index 28855fd5b5f4..d76fee8f84e0 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -240,6 +240,7 @@ LIBBPF_API int bpf_task_fd_query(int pid, int fd, __u32 flags, char *buf,
 enum bpf_stats_type; /* defined in up-to-date linux/bpf.h */
 LIBBPF_API int bpf_enable_stats(enum bpf_stats_type type);
 
+LIBBPF_API int bpf_prog_add_map(int prog_fd, int map_fd, int flags);
 #ifdef __cplusplus
 } /* extern "C" */
 #endif
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 7be04e45d29c..3ab1cb1f2af3 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -180,6 +180,8 @@ struct bpf_capabilities {
 	__u32 btf_func_global:1;
 	/* kernel support for expected_attach_type in BPF_PROG_LOAD */
 	__u32 exp_attach_type:1;
+	/* kernel support for BPF_PROG_ADD_MAP */
+	__u32 prog_add_map:1;
 };
 
 enum reloc_type {
@@ -288,6 +290,7 @@ struct bpf_struct_ops {
 #define KCONFIG_SEC ".kconfig"
 #define KSYMS_SEC ".ksyms"
 #define STRUCT_OPS_SEC ".struct_ops"
+#define METADATA_SEC ".metadata"
 
 enum libbpf_map_type {
 	LIBBPF_MAP_UNSPEC,
@@ -295,6 +298,7 @@ enum libbpf_map_type {
 	LIBBPF_MAP_BSS,
 	LIBBPF_MAP_RODATA,
 	LIBBPF_MAP_KCONFIG,
+	LIBBPF_MAP_METADATA,
 };
 
 static const char * const libbpf_type_to_btf_name[] = {
@@ -302,6 +306,7 @@ static const char * const libbpf_type_to_btf_name[] = {
 	[LIBBPF_MAP_BSS]	= BSS_SEC,
 	[LIBBPF_MAP_RODATA]	= RODATA_SEC,
 	[LIBBPF_MAP_KCONFIG]	= KCONFIG_SEC,
+	[LIBBPF_MAP_METADATA]	= METADATA_SEC,
 };
 
 struct bpf_map {
@@ -380,6 +385,8 @@ struct bpf_object {
 	size_t nr_maps;
 	size_t maps_cap;
 
+	struct bpf_map *metadata_map;
+
 	char *kconfig;
 	struct extern_desc *externs;
 	int nr_extern;
@@ -403,6 +410,7 @@ struct bpf_object {
 		Elf_Data *rodata;
 		Elf_Data *bss;
 		Elf_Data *st_ops_data;
+		Elf_Data *metadata;
 		size_t strtabidx;
 		struct {
 			GElf_Shdr shdr;
@@ -418,6 +426,7 @@ struct bpf_object {
 		int rodata_shndx;
 		int bss_shndx;
 		int st_ops_shndx;
+		int metadata_shndx;
 	} efile;
 	/*
 	 * All loaded bpf_object is linked in a list, which is
@@ -1030,6 +1039,7 @@ static struct bpf_object *bpf_object__new(const char *path,
 	obj->efile.obj_buf_sz = obj_buf_sz;
 	obj->efile.maps_shndx = -1;
 	obj->efile.btf_maps_shndx = -1;
+	obj->efile.metadata_shndx = -1;
 	obj->efile.data_shndx = -1;
 	obj->efile.rodata_shndx = -1;
 	obj->efile.bss_shndx = -1;
@@ -1391,6 +1401,9 @@ bpf_object__init_internal_map(struct bpf_object *obj, enum libbpf_map_type type,
 	if (data)
 		memcpy(map->mmaped, data, data_sz);
 
+	if (type == LIBBPF_MAP_METADATA)
+		obj->metadata_map = map;
+
 	pr_debug("map %td is \"%s\"\n", map - obj->maps, map->name);
 	return 0;
 }
@@ -1426,6 +1439,14 @@ static int bpf_object__init_global_data_maps(struct bpf_object *obj)
 		if (err)
 			return err;
 	}
+	if (obj->efile.metadata_shndx >= 0) {
+		err = bpf_object__init_internal_map(obj, LIBBPF_MAP_METADATA,
+						    obj->efile.metadata_shndx,
+						    obj->efile.metadata->d_buf,
+						    obj->efile.metadata->d_size);
+		if (err)
+			return err;
+	}
 	return 0;
 }
 
@@ -2665,6 +2686,9 @@ static int bpf_object__elf_collect(struct bpf_object *obj)
 			} else if (strcmp(name, STRUCT_OPS_SEC) == 0) {
 				obj->efile.st_ops_data = data;
 				obj->efile.st_ops_shndx = idx;
+			} else if (strcmp(name, METADATA_SEC) == 0) {
+				obj->efile.metadata = data;
+				obj->efile.metadata_shndx = idx;
 			} else {
 				pr_debug("skip section(%d) %s\n", idx, name);
 			}
@@ -3078,7 +3102,8 @@ static bool bpf_object__shndx_is_data(const struct bpf_object *obj,
 {
 	return shndx == obj->efile.data_shndx ||
 	       shndx == obj->efile.bss_shndx ||
-	       shndx == obj->efile.rodata_shndx;
+	       shndx == obj->efile.rodata_shndx ||
+	       shndx == obj->efile.metadata_shndx;
 }
 
 static bool bpf_object__shndx_is_maps(const struct bpf_object *obj,
@@ -3099,6 +3124,8 @@ bpf_object__section_to_libbpf_map_type(const struct bpf_object *obj, int shndx)
 		return LIBBPF_MAP_RODATA;
 	else if (shndx == obj->efile.symbols_shndx)
 		return LIBBPF_MAP_KCONFIG;
+	else if (shndx == obj->efile.metadata_shndx)
+		return LIBBPF_MAP_METADATA;
 	else
 		return LIBBPF_MAP_UNSPEC;
 }
@@ -3633,6 +3660,59 @@ bpf_object__probe_exp_attach_type(struct bpf_object *obj)
 	return 0;
 }
 
+static int
+bpf_object__probe_prog_add_map(struct bpf_object *obj)
+{
+	struct bpf_load_program_attr prog_attr;
+	struct bpf_create_map_attr map_attr;
+	char *cp, errmsg[STRERR_BUFSIZE];
+	struct bpf_insn insns[] = {
+		BPF_MOV64_IMM(BPF_REG_0, 0),
+		BPF_EXIT_INSN(),
+	};
+	int prog, map;
+
+	if (!obj->caps.global_data)
+		return 0;
+
+	memset(&map_attr, 0, sizeof(map_attr));
+	map_attr.map_type = BPF_MAP_TYPE_ARRAY;
+	map_attr.key_size = sizeof(int);
+	map_attr.value_size = 32;
+	map_attr.max_entries = 1;
+
+	map = bpf_create_map_xattr(&map_attr);
+	if (map < 0) {
+		cp = libbpf_strerror_r(errno, errmsg, sizeof(errmsg));
+		pr_warn("Error in %s():%s(%d). Couldn't create simple array map.\n",
+			__func__, cp, errno);
+		return -errno;
+	}
+
+	memset(&prog_attr, 0, sizeof(prog_attr));
+	prog_attr.prog_type = BPF_PROG_TYPE_SOCKET_FILTER;
+	prog_attr.insns = insns;
+	prog_attr.insns_cnt = ARRAY_SIZE(insns);
+	prog_attr.license = "GPL";
+
+	prog = bpf_load_program_xattr(&prog_attr, NULL, 0);
+	if (prog < 0) {
+		cp = libbpf_strerror_r(errno, errmsg, sizeof(errmsg));
+		pr_warn("Error in %s():%s(%d). Couldn't create simple program.\n",
+			__func__, cp, errno);
+
+		close(map);
+		return -errno;
+	}
+
+	if (!bpf_prog_add_map(prog, map, 0))
+		obj->caps.prog_add_map = 1;
+
+	close(map);
+	close(prog);
+	return 0;
+}
+
 static int
 bpf_object__probe_caps(struct bpf_object *obj)
 {
@@ -3644,6 +3724,7 @@ bpf_object__probe_caps(struct bpf_object *obj)
 		bpf_object__probe_btf_datasec,
 		bpf_object__probe_array_mmap,
 		bpf_object__probe_exp_attach_type,
+		bpf_object__probe_prog_add_map,
 	};
 	int i, ret;
 
@@ -5404,6 +5485,20 @@ load_program(struct bpf_program *prog, struct bpf_insn *insns, int insns_cnt,
 	if (ret >= 0) {
 		if (log_buf && load_attr.log_level)
 			pr_debug("verifier log:\n%s", log_buf);
+
+		if (prog->obj->metadata_map && prog->obj->caps.prog_add_map) {
+			if (bpf_prog_add_map(ret, bpf_map__fd(prog->obj->metadata_map), 0) &&
+			    errno != EEXIST) {
+				int fd = ret;
+
+				ret = -errno;
+				cp = libbpf_strerror_r(errno, errmsg, sizeof(errmsg));
+				pr_warn("add metadata map failed: %s\n", cp);
+				close(fd);
+				goto out;
+			}
+		}
+
 		*pfd = ret;
 		ret = 0;
 		goto out;
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 0c4722bfdd0a..86494a464c34 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -288,6 +288,7 @@ LIBBPF_0.1.0 {
 		bpf_map__set_value_size;
 		bpf_map__type;
 		bpf_map__value_size;
+		bpf_prog_add_map;
 		bpf_program__attach_xdp;
 		bpf_program__autoload;
 		bpf_program__is_sk_lookup;
-- 
2.28.0

