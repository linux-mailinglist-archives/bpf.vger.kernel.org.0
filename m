Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2A7724B334
	for <lists+bpf@lfdr.de>; Thu, 20 Aug 2020 11:43:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729233AbgHTJnN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 20 Aug 2020 05:43:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729149AbgHTJmS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 20 Aug 2020 05:42:18 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 920F2C061386
        for <bpf@vger.kernel.org>; Thu, 20 Aug 2020 02:42:18 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id t4so1115554iln.1
        for <bpf@vger.kernel.org>; Thu, 20 Aug 2020 02:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YeDsV6ML0VVk8480/NX5VmSSMK1mBoWtNTtZqIJn+Zs=;
        b=mFpMIvb7p5DOTQKEUOECdemzi5bIB2qv3fsyEzyqyG3Q2YdGtWEraHMplh/yTatxD7
         s8+azk0nBzvQw5xDe8XJMYOXxL2a2UXq32WFUFHpo8pyu4wZcnqoBXSDXV0lhu8f9G4b
         WkVlAXbLowZ4flM4FqehqfBupsuc0b/k8oLVoqyaPTzdYswkeHVAFhVssTIAmNsLFSi/
         ybEXZ9cJQLRwTWIPK4TbUVdAjIkQ+/QBllKRNvjV59KPGC4ErmCDwCpT8781OadJS4e9
         C87hlmWV/cw8k54W2bTgtvgNOumbe1ufZwy0EK99RX3jh23BYiZBbdbyxbwGleTw0L3G
         FbhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YeDsV6ML0VVk8480/NX5VmSSMK1mBoWtNTtZqIJn+Zs=;
        b=h/QhrXa09B2ioWI7rFLkp1VFe5Fb0+cxXt9eSwO2VScXtmwWfLcVIF1/L66lX53dqG
         kCZY2UA9Zc4hwVNsnDXqyHQOw2ecSv+Psohfr2TphJQRNd6BirjpJJBx6BGHRwTV2UZz
         5/c3+Iuh93nNs3YzJcAqZzT+8sT8q7U8XwCIqIlGRJFTSImKpsarkZHyMvckaprCUGIj
         6GAVfrsxM912qfVhnlvH8YUUi+Izus7+fMYY6qvEQV2hgQWyXZr3B7XxDqqAZRjRVvpL
         xOolPW34LS4udKLCkh2ZhaZA+HCd3g4ZWBdW+/7c6nTWxTAQI/ErDRZx0VCpGEtGzGmR
         pRRA==
X-Gm-Message-State: AOAM533wZmlmCRP4yfpMRmW2O7m52eXWARPEqhz7c8jCYMRrMUREXmWP
        OHSgkY/RVH5wy1TsbdzfjcbaZehLdCHWiMk/
X-Google-Smtp-Source: ABdhPJyaVrQ1Ev83jHJeNwmjoTMDiUQQ5Mf/Hi6MSGy4JydM9dhAr20nba/yqOFPBrZTrqp9gARcPw==
X-Received: by 2002:a92:295:: with SMTP id 143mr1983504ilc.240.1597916537501;
        Thu, 20 Aug 2020 02:42:17 -0700 (PDT)
Received: from localhost.localdomain (host-173-230-99-219.tnkngak.clients.pavlovmedia.com. [173.230.99.219])
        by smtp.gmail.com with ESMTPSA id r3sm1145597iov.22.2020.08.20.02.42.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 02:42:17 -0700 (PDT)
From:   YiFei Zhu <zhuyifei1999@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Stanislav Fomichev <sdf@google.com>,
        Mahesh Bandewar <maheshb@google.com>,
        YiFei Zhu <zhuyifei@google.com>
Subject: [PATCH bpf-next 3/5] libbpf: Add BPF_PROG_BIND_MAP syscall and use it on .metadata section
Date:   Thu, 20 Aug 2020 04:42:09 -0500
Message-Id: <b65c850c8e9f9ae8309c8a328a3d53ab76289c5b.1597915265.git.zhuyifei@google.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1597915265.git.zhuyifei@google.com>
References: <cover.1597915265.git.zhuyifei@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: YiFei Zhu <zhuyifei@google.com>

The patch adds a simple wrapper bpf_prog_bind_map around the syscall.
And when using libbpf to load a program, it will probe the kernel for
the support of this syscall, and scan for the .metadata ELF section
and load it as an internal map like a .data section.

In the case that kernel supports the BPF_PROG_BIND_MAP syscall and
a .metadata section exists, the map will be explicitly bound to
the program via the syscall immediately after program is loaded.
-EEXIST is ignored for this syscall.

Signed-off-by: YiFei Zhu <zhuyifei@google.com>
---
 tools/lib/bpf/bpf.c      |  11 +++++
 tools/lib/bpf/bpf.h      |   1 +
 tools/lib/bpf/libbpf.c   | 100 ++++++++++++++++++++++++++++++++++++++-
 tools/lib/bpf/libbpf.map |   1 +
 4 files changed, 112 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index 82b983ff6569..383b29ecb1fd 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -872,3 +872,14 @@ int bpf_enable_stats(enum bpf_stats_type type)
 
 	return sys_bpf(BPF_ENABLE_STATS, &attr, sizeof(attr));
 }
+
+int bpf_prog_bind_map(int prog_fd, int map_fd, int flags)
+{
+	union bpf_attr attr = {};
+
+	attr.prog_bind_map.prog_fd = prog_fd;
+	attr.prog_bind_map.map_fd = map_fd;
+	attr.prog_bind_map.flags = flags;
+
+	return sys_bpf(BPF_PROG_BIND_MAP, &attr, sizeof(attr));
+}
diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index 015d13f25fcc..32994a4e0bf6 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -243,6 +243,7 @@ LIBBPF_API int bpf_task_fd_query(int pid, int fd, __u32 flags, char *buf,
 enum bpf_stats_type; /* defined in up-to-date linux/bpf.h */
 LIBBPF_API int bpf_enable_stats(enum bpf_stats_type type);
 
+LIBBPF_API int bpf_prog_bind_map(int prog_fd, int map_fd, int flags);
 #ifdef __cplusplus
 } /* extern "C" */
 #endif
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 77d420c02094..4725859099c5 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -174,6 +174,8 @@ enum kern_feature_id {
 	FEAT_EXP_ATTACH_TYPE,
 	/* bpf_probe_read_{kernel,user}[_str] helpers */
 	FEAT_PROBE_READ_KERN,
+	/* bpf_prog_bind_map helper */
+	FEAT_PROG_BIND_MAP,
 	__FEAT_CNT,
 };
 
@@ -283,6 +285,7 @@ struct bpf_struct_ops {
 #define KCONFIG_SEC ".kconfig"
 #define KSYMS_SEC ".ksyms"
 #define STRUCT_OPS_SEC ".struct_ops"
+#define METADATA_SEC ".metadata"
 
 enum libbpf_map_type {
 	LIBBPF_MAP_UNSPEC,
@@ -290,6 +293,7 @@ enum libbpf_map_type {
 	LIBBPF_MAP_BSS,
 	LIBBPF_MAP_RODATA,
 	LIBBPF_MAP_KCONFIG,
+	LIBBPF_MAP_METADATA,
 };
 
 static const char * const libbpf_type_to_btf_name[] = {
@@ -297,6 +301,7 @@ static const char * const libbpf_type_to_btf_name[] = {
 	[LIBBPF_MAP_BSS]	= BSS_SEC,
 	[LIBBPF_MAP_RODATA]	= RODATA_SEC,
 	[LIBBPF_MAP_KCONFIG]	= KCONFIG_SEC,
+	[LIBBPF_MAP_METADATA]	= METADATA_SEC,
 };
 
 struct bpf_map {
@@ -375,6 +380,8 @@ struct bpf_object {
 	size_t nr_maps;
 	size_t maps_cap;
 
+	struct bpf_map *metadata_map;
+
 	char *kconfig;
 	struct extern_desc *externs;
 	int nr_extern;
@@ -398,6 +405,7 @@ struct bpf_object {
 		Elf_Data *rodata;
 		Elf_Data *bss;
 		Elf_Data *st_ops_data;
+		Elf_Data *metadata;
 		size_t strtabidx;
 		struct {
 			GElf_Shdr shdr;
@@ -413,6 +421,7 @@ struct bpf_object {
 		int rodata_shndx;
 		int bss_shndx;
 		int st_ops_shndx;
+		int metadata_shndx;
 	} efile;
 	/*
 	 * All loaded bpf_object is linked in a list, which is
@@ -1022,6 +1031,7 @@ static struct bpf_object *bpf_object__new(const char *path,
 	obj->efile.obj_buf_sz = obj_buf_sz;
 	obj->efile.maps_shndx = -1;
 	obj->efile.btf_maps_shndx = -1;
+	obj->efile.metadata_shndx = -1;
 	obj->efile.data_shndx = -1;
 	obj->efile.rodata_shndx = -1;
 	obj->efile.bss_shndx = -1;
@@ -1387,6 +1397,9 @@ bpf_object__init_internal_map(struct bpf_object *obj, enum libbpf_map_type type,
 	if (data)
 		memcpy(map->mmaped, data, data_sz);
 
+	if (type == LIBBPF_MAP_METADATA)
+		obj->metadata_map = map;
+
 	pr_debug("map %td is \"%s\"\n", map - obj->maps, map->name);
 	return 0;
 }
@@ -1422,6 +1435,14 @@ static int bpf_object__init_global_data_maps(struct bpf_object *obj)
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
 
@@ -2698,6 +2719,9 @@ static int bpf_object__elf_collect(struct bpf_object *obj)
 			} else if (strcmp(name, STRUCT_OPS_SEC) == 0) {
 				obj->efile.st_ops_data = data;
 				obj->efile.st_ops_shndx = idx;
+			} else if (strcmp(name, METADATA_SEC) == 0) {
+				obj->efile.metadata = data;
+				obj->efile.metadata_shndx = idx;
 			} else {
 				pr_debug("skip section(%d) %s\n", idx, name);
 			}
@@ -3111,7 +3135,8 @@ static bool bpf_object__shndx_is_data(const struct bpf_object *obj,
 {
 	return shndx == obj->efile.data_shndx ||
 	       shndx == obj->efile.bss_shndx ||
-	       shndx == obj->efile.rodata_shndx;
+	       shndx == obj->efile.rodata_shndx ||
+	       shndx == obj->efile.metadata_shndx;
 }
 
 static bool bpf_object__shndx_is_maps(const struct bpf_object *obj,
@@ -3132,6 +3157,8 @@ bpf_object__section_to_libbpf_map_type(const struct bpf_object *obj, int shndx)
 		return LIBBPF_MAP_RODATA;
 	else if (shndx == obj->efile.symbols_shndx)
 		return LIBBPF_MAP_KCONFIG;
+	else if (shndx == obj->efile.metadata_shndx)
+		return LIBBPF_MAP_METADATA;
 	else
 		return LIBBPF_MAP_UNSPEC;
 }
@@ -3655,6 +3682,60 @@ static int probe_kern_probe_read_kernel(void)
 	return probe_fd(bpf_load_program_xattr(&attr, NULL, 0));
 }
 
+static int probe_prog_bind_map(void)
+{
+	struct bpf_load_program_attr prog_attr;
+	struct bpf_create_map_attr map_attr;
+	char *cp, errmsg[STRERR_BUFSIZE];
+	struct bpf_insn insns[] = {
+		BPF_MOV64_IMM(BPF_REG_0, 0),
+		BPF_EXIT_INSN(),
+	};
+	int ret = 0, prog, map;
+
+	if (!kernel_supports(FEAT_GLOBAL_DATA))
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
+		ret = -errno;
+		cp = libbpf_strerror_r(ret, errmsg, sizeof(errmsg));
+		pr_warn("Error in %s():%s(%d). Couldn't create simple array map.\n",
+			__func__, cp, -ret);
+		return ret;
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
+		ret = -errno;
+		cp = libbpf_strerror_r(ret, errmsg, sizeof(errmsg));
+		pr_warn("Error in %s():%s(%d). Couldn't create simple program.\n",
+			__func__, cp, -ret);
+
+		close(map);
+		return ret;
+	}
+
+	if (!bpf_prog_bind_map(prog, map, 0))
+		ret = 1;
+
+	close(map);
+	close(prog);
+	return ret;
+}
+
 enum kern_feature_result {
 	FEAT_UNKNOWN = 0,
 	FEAT_SUPPORTED = 1,
@@ -3695,6 +3776,9 @@ static struct kern_feature_desc {
 	},
 	[FEAT_PROBE_READ_KERN] = {
 		"bpf_probe_read_kernel() helper", probe_kern_probe_read_kernel,
+	},
+	[FEAT_PROG_BIND_MAP] = {
+		"bpf_prog_bind_map() helper", probe_prog_bind_map,
 	}
 };
 
@@ -5954,6 +6038,20 @@ load_program(struct bpf_program *prog, struct bpf_insn *insns, int insns_cnt,
 	if (ret >= 0) {
 		if (log_buf && load_attr.log_level)
 			pr_debug("verifier log:\n%s", log_buf);
+
+		if (prog->obj->metadata_map && kernel_supports(FEAT_PROG_BIND_MAP)) {
+			if (bpf_prog_bind_map(ret, bpf_map__fd(prog->obj->metadata_map), 0) &&
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
index e35bd6cdbdbf..4baf18a6df69 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -288,6 +288,7 @@ LIBBPF_0.1.0 {
 		bpf_map__set_value_size;
 		bpf_map__type;
 		bpf_map__value_size;
+		bpf_prog_bind_map;
 		bpf_program__attach_xdp;
 		bpf_program__autoload;
 		bpf_program__is_sk_lookup;
-- 
2.28.0

