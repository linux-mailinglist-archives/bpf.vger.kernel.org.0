Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B8DF376F3E
	for <lists+bpf@lfdr.de>; Sat,  8 May 2021 05:49:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231164AbhEHDuH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 7 May 2021 23:50:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231153AbhEHDuG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 7 May 2021 23:50:06 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CF7AC061574
        for <bpf@vger.kernel.org>; Fri,  7 May 2021 20:49:05 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id v191so9245665pfc.8
        for <bpf@vger.kernel.org>; Fri, 07 May 2021 20:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=n4jxsbH9IlQHNNbf1NgCfus6Brf7sC4xj3Gte1cIIh4=;
        b=BXc6hK4evQsZJROvIylNgXOjTxuw6MC8q8g1VDRtvGqyRagvvzwiqKfzVIVKZDuMOe
         D3Be36rO3S2HEwpUzeO257CvCR5U4J2ySSC+ffWFtutZwPv3xdpH2uY3eIbw1YyOm2x5
         vRQBw1tmVZcb/R3YvJwCdu37nUnvfz3tEjQ1OjYi1YPGAfI280dGSxWpqJ8VkuXHhBfE
         A5ei4ZJwkziCsQyG+M8jaS/dtPZanjA+eLRjLyghAipADoQjSd2KpkewwLBISq2OG8Au
         ws3UXD1DU0KY0PuueypsI2z1MtaHEfIx1PiiSxmqtoul0w06bQF6rTbPBuQrqEuN9MS5
         O1Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=n4jxsbH9IlQHNNbf1NgCfus6Brf7sC4xj3Gte1cIIh4=;
        b=WSq5/mVqiFE+LW+eHEbGcleiK5GNxoAg0adWbagsyCDJdw7lT9RMEQiq0vpar7xF7k
         zAxl+Y5mRFzzlSUst/OssVrFh4kD503GJWyhg35uzCX48/dvn2NEuI5LSFCiC5RLlEKz
         yadPwSKXIB/KGtrr55cJztepUe5f0DFaSrseWZElGqmCgCnGXn8MrktzAp1MNqJnLL/a
         hpepaL0UwoqOZ5Yg+hpilXdQETSVU7gMVbZXtuyVeMg4Jz53ErqAEoLW0E9qMtg8lRUf
         ldaiu2Xgnw5f0v4hI0kgzol1fZEYYAVUicvZsavesCmwZGSjLy0Jl8wd6mSKVEjWhi1Z
         bkXw==
X-Gm-Message-State: AOAM532zmEItFMosw9Fg5AguKnQThZBcIrA27C3HX+kW1zmBjIMx12Di
        y56YJZQyRomTHU19Z8dYWzg=
X-Google-Smtp-Source: ABdhPJwd9IxdXl3E/uDKTBissaguNNxef5wps9vdikGXi9k4wrDnK+2wVqN/TbiBfO2XaUpUqcrViQ==
X-Received: by 2002:a65:584d:: with SMTP id s13mr13427714pgr.97.1620445745062;
        Fri, 07 May 2021 20:49:05 -0700 (PDT)
Received: from ast-mbp.thefacebook.com ([163.114.132.1])
        by smtp.gmail.com with ESMTPSA id u12sm5784606pfh.122.2021.05.07.20.49.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 May 2021 20:49:04 -0700 (PDT)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, john.fastabend@gmail.com,
        bpf@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v4 bpf-next 13/22] libbpf: Add bpf_object pointer to kernel_supports().
Date:   Fri,  7 May 2021 20:48:28 -0700
Message-Id: <20210508034837.64585-14-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20210508034837.64585-1-alexei.starovoitov@gmail.com>
References: <20210508034837.64585-1-alexei.starovoitov@gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Alexei Starovoitov <ast@kernel.org>

Add a pointer to 'struct bpf_object' to kernel_supports() helper.
It will be used in the next patch.
No functional changes.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/libbpf.c | 52 +++++++++++++++++++++---------------------
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index f04bac9f398c..75a0ca75db77 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -180,7 +180,7 @@ enum kern_feature_id {
 	__FEAT_CNT,
 };
 
-static bool kernel_supports(enum kern_feature_id feat_id);
+static bool kernel_supports(const struct bpf_object *obj, enum kern_feature_id feat_id);
 
 enum reloc_type {
 	RELO_LD64,
@@ -2446,20 +2446,20 @@ static bool section_have_execinstr(struct bpf_object *obj, int idx)
 
 static bool btf_needs_sanitization(struct bpf_object *obj)
 {
-	bool has_func_global = kernel_supports(FEAT_BTF_GLOBAL_FUNC);
-	bool has_datasec = kernel_supports(FEAT_BTF_DATASEC);
-	bool has_float = kernel_supports(FEAT_BTF_FLOAT);
-	bool has_func = kernel_supports(FEAT_BTF_FUNC);
+	bool has_func_global = kernel_supports(obj, FEAT_BTF_GLOBAL_FUNC);
+	bool has_datasec = kernel_supports(obj, FEAT_BTF_DATASEC);
+	bool has_float = kernel_supports(obj, FEAT_BTF_FLOAT);
+	bool has_func = kernel_supports(obj, FEAT_BTF_FUNC);
 
 	return !has_func || !has_datasec || !has_func_global || !has_float;
 }
 
 static void bpf_object__sanitize_btf(struct bpf_object *obj, struct btf *btf)
 {
-	bool has_func_global = kernel_supports(FEAT_BTF_GLOBAL_FUNC);
-	bool has_datasec = kernel_supports(FEAT_BTF_DATASEC);
-	bool has_float = kernel_supports(FEAT_BTF_FLOAT);
-	bool has_func = kernel_supports(FEAT_BTF_FUNC);
+	bool has_func_global = kernel_supports(obj, FEAT_BTF_GLOBAL_FUNC);
+	bool has_datasec = kernel_supports(obj, FEAT_BTF_DATASEC);
+	bool has_float = kernel_supports(obj, FEAT_BTF_FLOAT);
+	bool has_func = kernel_supports(obj, FEAT_BTF_FUNC);
 	struct btf_type *t;
 	int i, j, vlen;
 
@@ -2665,7 +2665,7 @@ static int bpf_object__sanitize_and_load_btf(struct bpf_object *obj)
 	if (!obj->btf)
 		return 0;
 
-	if (!kernel_supports(FEAT_BTF)) {
+	if (!kernel_supports(obj, FEAT_BTF)) {
 		if (kernel_needs_btf(obj)) {
 			err = -EOPNOTSUPP;
 			goto report;
@@ -4319,7 +4319,7 @@ static struct kern_feature_desc {
 	},
 };
 
-static bool kernel_supports(enum kern_feature_id feat_id)
+static bool kernel_supports(const struct bpf_object *obj, enum kern_feature_id feat_id)
 {
 	struct kern_feature_desc *feat = &feature_probes[feat_id];
 	int ret;
@@ -4438,7 +4438,7 @@ static int bpf_object__create_map(struct bpf_object *obj, struct bpf_map *map)
 
 	memset(&create_attr, 0, sizeof(create_attr));
 
-	if (kernel_supports(FEAT_PROG_NAME))
+	if (kernel_supports(obj, FEAT_PROG_NAME))
 		create_attr.name = map->name;
 	create_attr.map_ifindex = map->map_ifindex;
 	create_attr.map_type = def->type;
@@ -5003,7 +5003,7 @@ static int load_module_btfs(struct bpf_object *obj)
 	obj->btf_modules_loaded = true;
 
 	/* kernel too old to support module BTFs */
-	if (!kernel_supports(FEAT_MODULE_BTF))
+	if (!kernel_supports(obj, FEAT_MODULE_BTF))
 		return 0;
 
 	while (true) {
@@ -6397,7 +6397,7 @@ bpf_object__relocate_data(struct bpf_object *obj, struct bpf_program *prog)
 
 		switch (relo->type) {
 		case RELO_LD64:
-			if (kernel_supports(FEAT_FD_IDX)) {
+			if (kernel_supports(obj, FEAT_FD_IDX)) {
 				insn[0].src_reg = BPF_PSEUDO_MAP_IDX;
 				insn[0].imm = relo->map_idx;
 			} else {
@@ -6407,7 +6407,7 @@ bpf_object__relocate_data(struct bpf_object *obj, struct bpf_program *prog)
 			break;
 		case RELO_DATA:
 			insn[1].imm = insn[0].imm + relo->sym_off;
-			if (kernel_supports(FEAT_FD_IDX)) {
+			if (kernel_supports(obj, FEAT_FD_IDX)) {
 				insn[0].src_reg = BPF_PSEUDO_MAP_IDX_VALUE;
 				insn[0].imm = relo->map_idx;
 			} else {
@@ -6418,7 +6418,7 @@ bpf_object__relocate_data(struct bpf_object *obj, struct bpf_program *prog)
 		case RELO_EXTERN_VAR:
 			ext = &obj->externs[relo->sym_off];
 			if (ext->type == EXT_KCFG) {
-				if (kernel_supports(FEAT_FD_IDX)) {
+				if (kernel_supports(obj, FEAT_FD_IDX)) {
 					insn[0].src_reg = BPF_PSEUDO_MAP_IDX_VALUE;
 					insn[0].imm = obj->kconfig_map_idx;
 				} else {
@@ -6542,7 +6542,7 @@ reloc_prog_func_and_line_info(const struct bpf_object *obj,
 	/* no .BTF.ext relocation if .BTF.ext is missing or kernel doesn't
 	 * supprot func/line info
 	 */
-	if (!obj->btf_ext || !kernel_supports(FEAT_BTF_FUNC))
+	if (!obj->btf_ext || !kernel_supports(obj, FEAT_BTF_FUNC))
 		return 0;
 
 	/* only attempt func info relocation if main program's func_info
@@ -7150,12 +7150,12 @@ static int bpf_object__sanitize_prog(struct bpf_object *obj, struct bpf_program
 		switch (func_id) {
 		case BPF_FUNC_probe_read_kernel:
 		case BPF_FUNC_probe_read_user:
-			if (!kernel_supports(FEAT_PROBE_READ_KERN))
+			if (!kernel_supports(obj, FEAT_PROBE_READ_KERN))
 				insn->imm = BPF_FUNC_probe_read;
 			break;
 		case BPF_FUNC_probe_read_kernel_str:
 		case BPF_FUNC_probe_read_user_str:
-			if (!kernel_supports(FEAT_PROBE_READ_KERN))
+			if (!kernel_supports(obj, FEAT_PROBE_READ_KERN))
 				insn->imm = BPF_FUNC_probe_read_str;
 			break;
 		default:
@@ -7190,12 +7190,12 @@ load_program(struct bpf_program *prog, struct bpf_insn *insns, int insns_cnt,
 
 	load_attr.prog_type = prog->type;
 	/* old kernels might not support specifying expected_attach_type */
-	if (!kernel_supports(FEAT_EXP_ATTACH_TYPE) && prog->sec_def &&
+	if (!kernel_supports(prog->obj, FEAT_EXP_ATTACH_TYPE) && prog->sec_def &&
 	    prog->sec_def->is_exp_attach_type_optional)
 		load_attr.expected_attach_type = 0;
 	else
 		load_attr.expected_attach_type = prog->expected_attach_type;
-	if (kernel_supports(FEAT_PROG_NAME))
+	if (kernel_supports(prog->obj, FEAT_PROG_NAME))
 		load_attr.name = prog->name;
 	load_attr.insns = insns;
 	load_attr.insn_cnt = insns_cnt;
@@ -7212,7 +7212,7 @@ load_program(struct bpf_program *prog, struct bpf_insn *insns, int insns_cnt,
 
 	/* specify func_info/line_info only if kernel supports them */
 	btf_fd = bpf_object__btf_fd(prog->obj);
-	if (btf_fd >= 0 && kernel_supports(FEAT_BTF_FUNC)) {
+	if (btf_fd >= 0 && kernel_supports(prog->obj, FEAT_BTF_FUNC)) {
 		load_attr.prog_btf_fd = btf_fd;
 		load_attr.func_info = prog->func_info;
 		load_attr.func_info_rec_size = prog->func_info_rec_size;
@@ -7242,7 +7242,7 @@ load_program(struct bpf_program *prog, struct bpf_insn *insns, int insns_cnt,
 			pr_debug("verifier log:\n%s", log_buf);
 
 		if (prog->obj->rodata_map_idx >= 0 &&
-		    kernel_supports(FEAT_PROG_BIND_MAP)) {
+		    kernel_supports(prog->obj, FEAT_PROG_BIND_MAP)) {
 			struct bpf_map *rodata_map =
 				&prog->obj->maps[prog->obj->rodata_map_idx];
 
@@ -7410,7 +7410,7 @@ bpf_object__load_progs(struct bpf_object *obj, int log_level)
 			return err;
 	}
 
-	if (kernel_supports(FEAT_FD_IDX) && obj->nr_maps) {
+	if (kernel_supports(obj, FEAT_FD_IDX) && obj->nr_maps) {
 		fd_array = malloc(sizeof(int) * obj->nr_maps);
 		if (!fd_array)
 			return -ENOMEM;
@@ -7614,11 +7614,11 @@ static int bpf_object__sanitize_maps(struct bpf_object *obj)
 	bpf_object__for_each_map(m, obj) {
 		if (!bpf_map__is_internal(m))
 			continue;
-		if (!kernel_supports(FEAT_GLOBAL_DATA)) {
+		if (!kernel_supports(obj, FEAT_GLOBAL_DATA)) {
 			pr_warn("kernel doesn't support global data\n");
 			return -ENOTSUP;
 		}
-		if (!kernel_supports(FEAT_ARRAY_MMAP))
+		if (!kernel_supports(obj, FEAT_ARRAY_MMAP))
 			m->def.map_flags ^= BPF_F_MMAPABLE;
 	}
 
-- 
2.30.2

