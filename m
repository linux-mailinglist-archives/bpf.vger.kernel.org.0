Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34822380135
	for <lists+bpf@lfdr.de>; Fri, 14 May 2021 02:36:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231742AbhENAiA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 13 May 2021 20:38:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231723AbhENAiA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 13 May 2021 20:38:00 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9348C061574
        for <bpf@vger.kernel.org>; Thu, 13 May 2021 17:36:49 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id 10so23321032pfl.1
        for <bpf@vger.kernel.org>; Thu, 13 May 2021 17:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5hZ0QLdp+5MhpVuZXl5z6P4YVUWfLbRxGh0q0l2qCrs=;
        b=vHRUnffi6wN2z2adQVlxOPAH+n1MKunu2aYh8HdTJqmpHDlYPrKOviOD/OwgQXn7hX
         JlPEV7UMtwTjAbathpgYYSjEa1aIt5x+pX8WeZciM+2M5iEZKfzbkoEm7+1N3dCqvMeL
         uTO37AzQF+PVo7pwH7UbjwMzTa+sKV2GkcAmFDxJob8QUcy6GO2bzGVTeXQj9q/UfIbz
         dkwU+epKn8g8mvhAg9ZkW2ybrIg2641MrVg5dZ/LMRx65rTyhAhjZpiSrlDvf+3mCrR5
         wYXMbEDlllXD01CK8fIC4AacmGKGemtb7x3cj/ebfHP7J8FSQvwK1yJo1lnIDNGJIAEA
         FL1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5hZ0QLdp+5MhpVuZXl5z6P4YVUWfLbRxGh0q0l2qCrs=;
        b=r0qfm3z/LeS4vIpQB1dfhSwETlFNn1DSoTqX+2Lf3AOET4Q6DNM9Mu7KArH3XoCH4Y
         N3SLUkSPyUpFtcqjXO/AdqWReUHrH2gFA50SiXsKnji7ooNFmqNJbOuLrfgK79fORxry
         vj4RtxD+hlzPVdvEFKj1ona3GvJf9JcIE/jB+kC3gN6vGVnAnKlpiOZdnqQAb4f0MC0G
         p/cdGvywZVm0jI5XyGhHQQ05tMi/dTXMuK/0+9VENi2Zv+e3qlL2EBvgGpdaqIvK+b5T
         WcmpoSfUQveQMwJewogViBfTXKMVtIyg19KE0oK2grjrolPsR+IVU6AbKM2DZyyUCKNn
         BaoQ==
X-Gm-Message-State: AOAM5303jgQQHVlayPKcOvRChowlhOmchMS+S4WQw5gOOFhOKmfoecGs
        kdkRnuu+Yu8WPc7Go7xMqorrRj2rUJU=
X-Google-Smtp-Source: ABdhPJwsmimjwgs42+3iECd6WVs+8Vv8WKPgxeBKJZNBrnV4MuRSwmKMe/9VA/dEv1yAjf0oo5sAvw==
X-Received: by 2002:a63:741e:: with SMTP id p30mr44097160pgc.68.1620952609233;
        Thu, 13 May 2021 17:36:49 -0700 (PDT)
Received: from ast-mbp.thefacebook.com ([163.114.132.4])
        by smtp.gmail.com with ESMTPSA id b9sm302336pfo.107.2021.05.13.17.36.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 May 2021 17:36:48 -0700 (PDT)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, john.fastabend@gmail.com,
        bpf@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v6 bpf-next 12/21] libbpf: Add bpf_object pointer to kernel_supports().
Date:   Thu, 13 May 2021 17:36:14 -0700
Message-Id: <20210514003623.28033-13-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20210514003623.28033-1-alexei.starovoitov@gmail.com>
References: <20210514003623.28033-1-alexei.starovoitov@gmail.com>
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
 tools/lib/bpf/libbpf.c | 44 +++++++++++++++++++++---------------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 98be32992b20..708b94ad9893 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -178,7 +178,7 @@ enum kern_feature_id {
 	__FEAT_CNT,
 };
 
-static bool kernel_supports(enum kern_feature_id feat_id);
+static bool kernel_supports(const struct bpf_object *obj, enum kern_feature_id feat_id);
 
 enum reloc_type {
 	RELO_LD64,
@@ -2458,20 +2458,20 @@ static bool section_have_execinstr(struct bpf_object *obj, int idx)
 
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
 
@@ -2677,7 +2677,7 @@ static int bpf_object__sanitize_and_load_btf(struct bpf_object *obj)
 	if (!obj->btf)
 		return 0;
 
-	if (!kernel_supports(FEAT_BTF)) {
+	if (!kernel_supports(obj, FEAT_BTF)) {
 		if (kernel_needs_btf(obj)) {
 			err = -EOPNOTSUPP;
 			goto report;
@@ -4305,7 +4305,7 @@ static struct kern_feature_desc {
 	},
 };
 
-static bool kernel_supports(enum kern_feature_id feat_id)
+static bool kernel_supports(const struct bpf_object *obj, enum kern_feature_id feat_id)
 {
 	struct kern_feature_desc *feat = &feature_probes[feat_id];
 	int ret;
@@ -4424,7 +4424,7 @@ static int bpf_object__create_map(struct bpf_object *obj, struct bpf_map *map)
 
 	memset(&create_attr, 0, sizeof(create_attr));
 
-	if (kernel_supports(FEAT_PROG_NAME))
+	if (kernel_supports(obj, FEAT_PROG_NAME))
 		create_attr.name = map->name;
 	create_attr.map_ifindex = map->map_ifindex;
 	create_attr.map_type = def->type;
@@ -4989,7 +4989,7 @@ static int load_module_btfs(struct bpf_object *obj)
 	obj->btf_modules_loaded = true;
 
 	/* kernel too old to support module BTFs */
-	if (!kernel_supports(FEAT_MODULE_BTF))
+	if (!kernel_supports(obj, FEAT_MODULE_BTF))
 		return 0;
 
 	while (true) {
@@ -6513,7 +6513,7 @@ reloc_prog_func_and_line_info(const struct bpf_object *obj,
 	/* no .BTF.ext relocation if .BTF.ext is missing or kernel doesn't
 	 * supprot func/line info
 	 */
-	if (!obj->btf_ext || !kernel_supports(FEAT_BTF_FUNC))
+	if (!obj->btf_ext || !kernel_supports(obj, FEAT_BTF_FUNC))
 		return 0;
 
 	/* only attempt func info relocation if main program's func_info
@@ -7121,12 +7121,12 @@ static int bpf_object__sanitize_prog(struct bpf_object *obj, struct bpf_program
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
@@ -7161,12 +7161,12 @@ load_program(struct bpf_program *prog, struct bpf_insn *insns, int insns_cnt,
 
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
@@ -7182,7 +7182,7 @@ load_program(struct bpf_program *prog, struct bpf_insn *insns, int insns_cnt,
 
 	/* specify func_info/line_info only if kernel supports them */
 	btf_fd = bpf_object__btf_fd(prog->obj);
-	if (btf_fd >= 0 && kernel_supports(FEAT_BTF_FUNC)) {
+	if (btf_fd >= 0 && kernel_supports(prog->obj, FEAT_BTF_FUNC)) {
 		load_attr.prog_btf_fd = btf_fd;
 		load_attr.func_info = prog->func_info;
 		load_attr.func_info_rec_size = prog->func_info_rec_size;
@@ -7212,7 +7212,7 @@ load_program(struct bpf_program *prog, struct bpf_insn *insns, int insns_cnt,
 			pr_debug("verifier log:\n%s", log_buf);
 
 		if (prog->obj->rodata_map_idx >= 0 &&
-		    kernel_supports(FEAT_PROG_BIND_MAP)) {
+		    kernel_supports(prog->obj, FEAT_PROG_BIND_MAP)) {
 			struct bpf_map *rodata_map =
 				&prog->obj->maps[prog->obj->rodata_map_idx];
 
@@ -7570,11 +7570,11 @@ static int bpf_object__sanitize_maps(struct bpf_object *obj)
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

