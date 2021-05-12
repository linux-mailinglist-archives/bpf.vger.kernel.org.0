Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65C7137EF38
	for <lists+bpf@lfdr.de>; Thu, 13 May 2021 01:10:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236500AbhELXAB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 May 2021 19:00:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346815AbhELVor (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 May 2021 17:44:47 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 720CBC08C5D4
        for <bpf@vger.kernel.org>; Wed, 12 May 2021 14:33:23 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id l70so4578683pga.1
        for <bpf@vger.kernel.org>; Wed, 12 May 2021 14:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oPycUPkWoGk4Repea2pHOzVV89a3fKezX0X5HIeDFx0=;
        b=M9tY2GDEd5UaX2Qwmb3SYDmBzY2x1Syjplmrlx5oufzW+rSyceMlQNzBYQRk28EJWZ
         sRS4jBF+pEPrSngTKGZyqbHJ3u1Hch1e091dOmbBQkXcRWkvqEJs3218da2YAzpbHBGf
         INuWhGsStPQGaQ1XKwV+qbJcGw4yBNZdz0yN0aJsm8kKmJoFe6/8hjtl4MtvAqaYlJWX
         X7H4HuaDrn4qDI5+g9qHq1PnNZXvEiRvWJSesmAhRS50VhVvvNlIsYFdMpYIaupBHPZd
         a+qt94priL47vULCniiJZ8stOKbjD10xC4SNYqFgTqr6dtLVnBaoqu5jqkHPF9XgucAg
         +i1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oPycUPkWoGk4Repea2pHOzVV89a3fKezX0X5HIeDFx0=;
        b=IXjk3L1cvaiQOHzdziC9iUMyIxs4z5ftafNP/vEGG/V7p6lmrmSuhFTDCMlftvJpVu
         fMJ3SJld0RklCSR6OWBFWGeQM8jEan6zu/9bPUy4mtKuUkf4q1tRWCUMAxjaSJK0WeGB
         /XWrFs38fy1BWWSmHbKyHi5LHv0X2/N3RYeYfq3PxbAgiPg8hOBGPHvbhr/ofO3Bqp3/
         HVXXaDqraFIF6avT5CSLhXvAjgCVe2Bg3E/mKN8L2hHDYFUvZpPlpj2BX7WUV1Vx2DV3
         NKKyGWRzFBFsBiEqIq1n3VjhTS0LSbDRYIeKQe2C5QMJPhVOAVRkVdCnfUvS6J1YUjKz
         KJXg==
X-Gm-Message-State: AOAM531jLh90Op87i3dBH9VYFe+yaBcyXlQ1MhDH9XKyhr88xJSnEE50
        hP0PRM1aPXWP7OOYm1ilI4BTguWlPto=
X-Google-Smtp-Source: ABdhPJySF+SogDxHh9dCAZPqX2TPf8FG0uCo4xquqWwmKVe6Ah2I9kjGXrqSfHp80ppsomniyJ5dvw==
X-Received: by 2002:a63:7148:: with SMTP id b8mr37969746pgn.278.1620855202679;
        Wed, 12 May 2021 14:33:22 -0700 (PDT)
Received: from ast-mbp.thefacebook.com ([163.114.132.4])
        by smtp.gmail.com with ESMTPSA id c128sm609222pfa.189.2021.05.12.14.33.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 May 2021 14:33:21 -0700 (PDT)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, john.fastabend@gmail.com,
        bpf@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v5 bpf-next 12/21] libbpf: Add bpf_object pointer to kernel_supports().
Date:   Wed, 12 May 2021 14:32:47 -0700
Message-Id: <20210512213256.31203-13-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20210512213256.31203-1-alexei.starovoitov@gmail.com>
References: <20210512213256.31203-1-alexei.starovoitov@gmail.com>
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
index 0243cbe79bda..8ea6120c9849 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -178,7 +178,7 @@ enum kern_feature_id {
 	__FEAT_CNT,
 };
 
-static bool kernel_supports(enum kern_feature_id feat_id);
+static bool kernel_supports(const struct bpf_object *obj, enum kern_feature_id feat_id);
 
 enum reloc_type {
 	RELO_LD64,
@@ -2444,20 +2444,20 @@ static bool section_have_execinstr(struct bpf_object *obj, int idx)
 
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
 
@@ -2663,7 +2663,7 @@ static int bpf_object__sanitize_and_load_btf(struct bpf_object *obj)
 	if (!obj->btf)
 		return 0;
 
-	if (!kernel_supports(FEAT_BTF)) {
+	if (!kernel_supports(obj, FEAT_BTF)) {
 		if (kernel_needs_btf(obj)) {
 			err = -EOPNOTSUPP;
 			goto report;
@@ -4291,7 +4291,7 @@ static struct kern_feature_desc {
 	},
 };
 
-static bool kernel_supports(enum kern_feature_id feat_id)
+static bool kernel_supports(const struct bpf_object *obj, enum kern_feature_id feat_id)
 {
 	struct kern_feature_desc *feat = &feature_probes[feat_id];
 	int ret;
@@ -4410,7 +4410,7 @@ static int bpf_object__create_map(struct bpf_object *obj, struct bpf_map *map)
 
 	memset(&create_attr, 0, sizeof(create_attr));
 
-	if (kernel_supports(FEAT_PROG_NAME))
+	if (kernel_supports(obj, FEAT_PROG_NAME))
 		create_attr.name = map->name;
 	create_attr.map_ifindex = map->map_ifindex;
 	create_attr.map_type = def->type;
@@ -4975,7 +4975,7 @@ static int load_module_btfs(struct bpf_object *obj)
 	obj->btf_modules_loaded = true;
 
 	/* kernel too old to support module BTFs */
-	if (!kernel_supports(FEAT_MODULE_BTF))
+	if (!kernel_supports(obj, FEAT_MODULE_BTF))
 		return 0;
 
 	while (true) {
@@ -6499,7 +6499,7 @@ reloc_prog_func_and_line_info(const struct bpf_object *obj,
 	/* no .BTF.ext relocation if .BTF.ext is missing or kernel doesn't
 	 * supprot func/line info
 	 */
-	if (!obj->btf_ext || !kernel_supports(FEAT_BTF_FUNC))
+	if (!obj->btf_ext || !kernel_supports(obj, FEAT_BTF_FUNC))
 		return 0;
 
 	/* only attempt func info relocation if main program's func_info
@@ -7107,12 +7107,12 @@ static int bpf_object__sanitize_prog(struct bpf_object *obj, struct bpf_program
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
@@ -7147,12 +7147,12 @@ load_program(struct bpf_program *prog, struct bpf_insn *insns, int insns_cnt,
 
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
@@ -7168,7 +7168,7 @@ load_program(struct bpf_program *prog, struct bpf_insn *insns, int insns_cnt,
 
 	/* specify func_info/line_info only if kernel supports them */
 	btf_fd = bpf_object__btf_fd(prog->obj);
-	if (btf_fd >= 0 && kernel_supports(FEAT_BTF_FUNC)) {
+	if (btf_fd >= 0 && kernel_supports(prog->obj, FEAT_BTF_FUNC)) {
 		load_attr.prog_btf_fd = btf_fd;
 		load_attr.func_info = prog->func_info;
 		load_attr.func_info_rec_size = prog->func_info_rec_size;
@@ -7198,7 +7198,7 @@ load_program(struct bpf_program *prog, struct bpf_insn *insns, int insns_cnt,
 			pr_debug("verifier log:\n%s", log_buf);
 
 		if (prog->obj->rodata_map_idx >= 0 &&
-		    kernel_supports(FEAT_PROG_BIND_MAP)) {
+		    kernel_supports(prog->obj, FEAT_PROG_BIND_MAP)) {
 			struct bpf_map *rodata_map =
 				&prog->obj->maps[prog->obj->rodata_map_idx];
 
@@ -7556,11 +7556,11 @@ static int bpf_object__sanitize_maps(struct bpf_object *obj)
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

