Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98E2D141306
	for <lists+bpf@lfdr.de>; Fri, 17 Jan 2020 22:28:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728640AbgAQV2S (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Jan 2020 16:28:18 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38611 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726957AbgAQV2S (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Jan 2020 16:28:18 -0500
Received: by mail-pf1-f195.google.com with SMTP id x185so12514296pfc.5
        for <bpf@vger.kernel.org>; Fri, 17 Jan 2020 13:28:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MuhPeV1hIsw7xvvqpuGhGOFPVF++AuFoKcoUh4B+GV8=;
        b=MdMIovu4cHdhhci9Kkqk9ZHHV062WaaztYnI13E5jwuN4xVD2JQ7p9Mafrd2nopc/U
         IrWQOScCbPp8nnChspia50IDhmlY/WilljdarWlj/3uX+0IQgxzyNMD7I9GquV4u7w1z
         e3nxjgfbXq7b1c+mLkGtKb4Wco+4ZQp7bN4yU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MuhPeV1hIsw7xvvqpuGhGOFPVF++AuFoKcoUh4B+GV8=;
        b=kFoA0j5cIKcI8sQDhl0sYCRmDY7jcFm6vrXfEUzJeIhj4+sXzvYwolAhlnr0aFfg+B
         ur82y5V6VxseldvUtDuaYA+fdMmfTfMvKPCDQluTpGLiBK0LTM/2vAhgIW/fP2tSlRT1
         wp+UwQmk+y70mdUbDFDtnKHDyefgLv24fM1VjOYMGAfg9J3haVhsP77ocXFbr6hVwcTl
         DUD6aBWJaxhrN6OYPIP1S9R6TGAEx1J0cDxRKsYt1GLlOE0Fgo8A34l7vnDSbAccYd8B
         YPolzcW/AK26tUnXqIDmq43SEqKB/H1JjM3lzR5IwWx6iAFzsmoPygjhWRBhanDPgtAT
         AQ5Q==
X-Gm-Message-State: APjAAAVqQGt82DuoKE4DZ/go9V2mVKYiRFphkk5QDQliitf84Hkj75wI
        KCK3tbPCbAIlcorExlfVNOfPkw==
X-Google-Smtp-Source: APXvYqz2eZeITffUJ+JQTIzxsyGDEQ9VmFrSwgKOU9oRUPUlywup+TivzqLTiBe1+4iHn+0Kz/99PQ==
X-Received: by 2002:a63:7311:: with SMTP id o17mr45099625pgc.29.1579296497211;
        Fri, 17 Jan 2020 13:28:17 -0800 (PST)
Received: from kpsingh-kernel.localdomain ([165.231.253.166])
        by smtp.gmail.com with ESMTPSA id o16sm29263377pgl.58.2020.01.17.13.28.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 13:28:16 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Brendan Jackman <jackmanb@chromium.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Anton Protopopov <a.s.protopopov@gmail.com>,
        Florent Revest <revest@chromium.org>
Subject: [PATCH bpf-next v2] libbpf: Load btf_vmlinux only once per object.
Date:   Fri, 17 Jan 2020 22:28:25 +0100
Message-Id: <20200117212825.11755-1-kpsingh@chromium.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: KP Singh <kpsingh@google.com>

As more programs (TRACING, STRUCT_OPS, and upcoming LSM) use vmlinux
BTF information, loading the BTF vmlinux information for every program
in an object is sub-optimal. The fix was originally proposed in:

   https://lore.kernel.org/bpf/CAEf4BzZodr3LKJuM7QwD38BiEH02Cc1UbtnGpVkCJ00Mf+V_Qg@mail.gmail.com/

The btf_vmlinux is populated in the object if any of the programs in
the object requires it just before the programs are loaded and freed
after the programs finish loading.

Reported-by: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Reviewed-by: Brendan Jackman <jackmanb@chromium.org>
Signed-off-by: KP Singh <kpsingh@google.com>
---
 tools/lib/bpf/libbpf.c | 153 +++++++++++++++++++++++++++--------------
 1 file changed, 101 insertions(+), 52 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 3afaca9bce1d..37d4abfc26d1 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -385,6 +385,10 @@ struct bpf_object {
 	struct list_head list;
 
 	struct btf *btf;
+	/* Parse and load BTF vmlinux if any of the programs in the object need
+	 * it at load time.
+	 */
+	struct btf *btf_vmlinux;
 	struct btf_ext *btf_ext;
 
 	void *priv;
@@ -633,7 +637,8 @@ find_member_by_name(const struct btf *btf, const struct btf_type *t,
 }
 
 #define STRUCT_OPS_VALUE_PREFIX "bpf_struct_ops_"
-#define STRUCT_OPS_VALUE_PREFIX_LEN (sizeof(STRUCT_OPS_VALUE_PREFIX) - 1)
+static int find_btf_by_prefix_kind(const struct btf *btf, const char *prefix,
+				   const char *name, __u32 kind);
 
 static int
 find_struct_ops_kern_types(const struct btf *btf, const char *tname,
@@ -644,7 +649,6 @@ find_struct_ops_kern_types(const struct btf *btf, const char *tname,
 	const struct btf_type *kern_type, *kern_vtype;
 	const struct btf_member *kern_data_member;
 	__s32 kern_vtype_id, kern_type_id;
-	char vtname[128] = STRUCT_OPS_VALUE_PREFIX;
 	__u32 i;
 
 	kern_type_id = btf__find_by_name_kind(btf, tname, BTF_KIND_STRUCT);
@@ -660,13 +664,11 @@ find_struct_ops_kern_types(const struct btf *btf, const char *tname,
 	 * find "struct bpf_struct_ops_tcp_congestion_ops" from the
 	 * btf_vmlinux.
 	 */
-	strncat(vtname + STRUCT_OPS_VALUE_PREFIX_LEN, tname,
-		sizeof(vtname) - STRUCT_OPS_VALUE_PREFIX_LEN - 1);
-	kern_vtype_id = btf__find_by_name_kind(btf, vtname,
-					       BTF_KIND_STRUCT);
+	kern_vtype_id = find_btf_by_prefix_kind(btf, STRUCT_OPS_VALUE_PREFIX,
+						tname, BTF_KIND_STRUCT);
 	if (kern_vtype_id < 0) {
-		pr_warn("struct_ops init_kern: struct %s is not found in kernel BTF\n",
-			vtname);
+		pr_warn("struct_ops init_kern: struct %s%s is not found in kernel BTF\n",
+			STRUCT_OPS_VALUE_PREFIX, tname);
 		return kern_vtype_id;
 	}
 	kern_vtype = btf__type_by_id(btf, kern_vtype_id);
@@ -683,8 +685,8 @@ find_struct_ops_kern_types(const struct btf *btf, const char *tname,
 			break;
 	}
 	if (i == btf_vlen(kern_vtype)) {
-		pr_warn("struct_ops init_kern: struct %s data is not found in struct %s\n",
-			tname, vtname);
+		pr_warn("struct_ops init_kern: struct %s data is not found in struct %s%s\n",
+			tname, STRUCT_OPS_VALUE_PREFIX, tname);
 		return -EINVAL;
 	}
 
@@ -835,7 +837,6 @@ static int bpf_map__init_kern_struct_ops(struct bpf_map *map,
 
 static int bpf_object__init_kern_struct_ops_maps(struct bpf_object *obj)
 {
-	struct btf *kern_btf = NULL;
 	struct bpf_map *map;
 	size_t i;
 	int err;
@@ -846,20 +847,12 @@ static int bpf_object__init_kern_struct_ops_maps(struct bpf_object *obj)
 		if (!bpf_map__is_struct_ops(map))
 			continue;
 
-		if (!kern_btf) {
-			kern_btf = libbpf_find_kernel_btf();
-			if (IS_ERR(kern_btf))
-				return PTR_ERR(kern_btf);
-		}
-
-		err = bpf_map__init_kern_struct_ops(map, obj->btf, kern_btf);
-		if (err) {
-			btf__free(kern_btf);
+		err = bpf_map__init_kern_struct_ops(map, obj->btf,
+						    obj->btf_vmlinux);
+		if (err)
 			return err;
-		}
 	}
 
-	btf__free(kern_btf);
 	return 0;
 }
 
@@ -2364,6 +2357,41 @@ static int bpf_object__finalize_btf(struct bpf_object *obj)
 	return 0;
 }
 
+static inline bool libbpf_prog_needs_vmlinux_btf(struct bpf_program *prog)
+{
+	if (prog->type == BPF_PROG_TYPE_STRUCT_OPS)
+		return true;
+
+	/* BPF_PROG_TYPE_TRACING programs which do not attach to other programs
+	 * also need vmlinux BTF
+	 */
+	if (prog->type == BPF_PROG_TYPE_TRACING && !prog->attach_prog_fd)
+		return true;
+
+	return false;
+}
+
+static int bpf_object__load_vmlinux_btf(struct bpf_object *obj)
+{
+	struct bpf_program *prog;
+	int err;
+
+	bpf_object__for_each_program(prog, obj) {
+		if (libbpf_prog_needs_vmlinux_btf(prog)) {
+			obj->btf_vmlinux = libbpf_find_kernel_btf();
+			if (IS_ERR(obj->btf_vmlinux)) {
+				err = PTR_ERR(obj->btf_vmlinux);
+				pr_warn("Error loading vmlinux BTF: %d\n", err);
+				obj->btf_vmlinux = NULL;
+				return err;
+			}
+			return 0;
+		}
+	}
+
+	return 0;
+}
+
 static int bpf_object__sanitize_and_load_btf(struct bpf_object *obj)
 {
 	int err = 0;
@@ -4891,18 +4919,14 @@ load_program(struct bpf_program *prog, struct bpf_insn *insns, int insns_cnt,
 	return ret;
 }
 
-static int libbpf_find_attach_btf_id(const char *name,
-				     enum bpf_attach_type attach_type,
-				     __u32 attach_prog_fd);
+static int libbpf_find_attach_btf_id(struct bpf_program *prog);
 
 int bpf_program__load(struct bpf_program *prog, char *license, __u32 kern_ver)
 {
 	int err = 0, fd, i, btf_id;
 
 	if (prog->type == BPF_PROG_TYPE_TRACING) {
-		btf_id = libbpf_find_attach_btf_id(prog->section_name,
-						   prog->expected_attach_type,
-						   prog->attach_prog_fd);
+		btf_id = libbpf_find_attach_btf_id(prog);
 		if (btf_id <= 0)
 			return btf_id;
 		prog->attach_btf_id = btf_id;
@@ -5280,10 +5304,15 @@ int bpf_object__load_xattr(struct bpf_object_load_attr *attr)
 	err = err ? : bpf_object__resolve_externs(obj, obj->kconfig);
 	err = err ? : bpf_object__sanitize_and_load_btf(obj);
 	err = err ? : bpf_object__sanitize_maps(obj);
+	err = err ? : bpf_object__load_vmlinux_btf(obj);
 	err = err ? : bpf_object__init_kern_struct_ops_maps(obj);
 	err = err ? : bpf_object__create_maps(obj);
 	err = err ? : bpf_object__relocate(obj, attr->target_btf_path);
 	err = err ? : bpf_object__load_progs(obj, attr->log_level);
+
+	btf__free(obj->btf_vmlinux);
+	obj->btf_vmlinux = NULL;
+
 	if (err)
 		goto out;
 
@@ -6504,34 +6533,52 @@ static int bpf_object__collect_struct_ops_map_reloc(struct bpf_object *obj,
 	return -EINVAL;
 }
 
-#define BTF_PREFIX "btf_trace_"
+#define BTF_TRACE_PREFIX "btf_trace_"
+#define BTF_MAX_NAME_SIZE 128
+
+static int find_btf_by_prefix_kind(const struct btf *btf, const char *prefix,
+				   const char *name, __u32 kind)
+{
+	char btf_type_name[BTF_MAX_NAME_SIZE];
+	int ret;
+
+	ret = snprintf(btf_type_name, sizeof(btf_type_name),
+		       "%s%s", prefix, name);
+	/* snprintf returns the number of characters written excluding the
+	 * the terminating null. So, if >= BTF_MAX_NAME_SIZE are written, it
+	 * indicates truncation.
+	 */
+	if (ret < 0 || ret >= sizeof(btf_type_name))
+		return -ENAMETOOLONG;
+	return btf__find_by_name_kind(btf, btf_type_name, kind);
+}
+
+static inline int __find_vmlinux_btf_id(struct btf *btf, const char *name,
+					enum bpf_attach_type attach_type)
+{
+	int err;
+
+	if (attach_type == BPF_TRACE_RAW_TP)
+		err = find_btf_by_prefix_kind(btf, BTF_TRACE_PREFIX, name,
+					      BTF_KIND_TYPEDEF);
+	else
+		err = btf__find_by_name_kind(btf, name, BTF_KIND_FUNC);
+
+	return err;
+}
+
 int libbpf_find_vmlinux_btf_id(const char *name,
 			       enum bpf_attach_type attach_type)
 {
-	struct btf *btf = libbpf_find_kernel_btf();
-	char raw_tp_btf[128] = BTF_PREFIX;
-	char *dst = raw_tp_btf + sizeof(BTF_PREFIX) - 1;
-	const char *btf_name;
-	int err = -EINVAL;
-	__u32 kind;
+	struct btf *btf;
 
+	btf = libbpf_find_kernel_btf();
 	if (IS_ERR(btf)) {
 		pr_warn("vmlinux BTF is not found\n");
 		return -EINVAL;
 	}
 
-	if (attach_type == BPF_TRACE_RAW_TP) {
-		/* prepend "btf_trace_" prefix per kernel convention */
-		strncat(dst, name, sizeof(raw_tp_btf) - sizeof(BTF_PREFIX));
-		btf_name = raw_tp_btf;
-		kind = BTF_KIND_TYPEDEF;
-	} else {
-		btf_name = name;
-		kind = BTF_KIND_FUNC;
-	}
-	err = btf__find_by_name_kind(btf, btf_name, kind);
-	btf__free(btf);
-	return err;
+	return __find_vmlinux_btf_id(btf, name, attach_type);
 }
 
 static int libbpf_find_prog_btf_id(const char *name, __u32 attach_prog_fd)
@@ -6567,10 +6614,11 @@ static int libbpf_find_prog_btf_id(const char *name, __u32 attach_prog_fd)
 	return err;
 }
 
-static int libbpf_find_attach_btf_id(const char *name,
-				     enum bpf_attach_type attach_type,
-				     __u32 attach_prog_fd)
+static int libbpf_find_attach_btf_id(struct bpf_program *prog)
 {
+	enum bpf_attach_type attach_type = prog->expected_attach_type;
+	__u32 attach_prog_fd = prog->attach_prog_fd;
+	const char *name = prog->section_name;
 	int i, err;
 
 	if (!name)
@@ -6585,8 +6633,9 @@ static int libbpf_find_attach_btf_id(const char *name,
 			err = libbpf_find_prog_btf_id(name + section_defs[i].len,
 						      attach_prog_fd);
 		else
-			err = libbpf_find_vmlinux_btf_id(name + section_defs[i].len,
-							 attach_type);
+			err = __find_vmlinux_btf_id(prog->obj->btf_vmlinux,
+						    name + section_defs[i].len,
+						    attach_type);
 		if (err <= 0)
 			pr_warn("%s is not found in vmlinux BTF\n", name);
 		return err;
-- 
2.20.1

