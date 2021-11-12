Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB12A44E13F
	for <lists+bpf@lfdr.de>; Fri, 12 Nov 2021 06:02:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbhKLFFm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 12 Nov 2021 00:05:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbhKLFFl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 12 Nov 2021 00:05:41 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED83DC061766
        for <bpf@vger.kernel.org>; Thu, 11 Nov 2021 21:02:51 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id q126so7044610pgq.13
        for <bpf@vger.kernel.org>; Thu, 11 Nov 2021 21:02:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NjVomWzLqfpw6oPx/a3RL/oyhh0GknnAje3yr8x1sAQ=;
        b=lk9iw08aSSr9igseb6hkYU1xV1+dj+c46oNRZOtAqWLVK6pG1Dk55speJ6Bm6WEiWM
         FQGIYJp0FD9oSgF24HcYjztRcLIAwPPWLoy8PhnLEyGmifQx76+3TbTO0uG/5sMJagXL
         L2MJFZrh2E8y3VFByexE0S3KQ5dr00JZyB75cMQGPRvcKzZkHaUCpEmOqVNmjbSAnWWf
         v73nl+2csAN6JFpYs8eZ/YDUszIYxobAWQ74uza8WTDrgDqW3R9ReQoOmE6anxRXdKEv
         sy2iHLVe8Q8vNuhUbSxiMy7ALFT9wrjlznyoVgjjJ8ICr+7kxO/UjUDfUwB9AE7hWi8M
         9fUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NjVomWzLqfpw6oPx/a3RL/oyhh0GknnAje3yr8x1sAQ=;
        b=8J3JI2kk8cDhNKHiYRrqzecje0s0ElLi6fJWa2uvH0U0/bzVfTjLZB1OpUvjjDeDmj
         CAJmdVYF6ujK13YSaNSRe0+bvnWIR8YLeQYiXxE+lb7ScdSRjOL7rk2lrBHqFJ9d+89R
         0tBc8NBS16xGqtd/Az46kHv6ukTk6/tJO68ArG6ijRt0pyB24L18fCV579rV0mjUYpYm
         wuRWEPGzp6wWM5uEnpIRDP4yDcLwt2etvt36vvdZhocJKDgGeenPeJxcEgdiYEG2IfY2
         up5d6qPQhmDp4s3rlmPjSQEs53Ih1Qqc5F+rA/UqxvXwaaNtr4RmbQfbskqoaecpzSEW
         ktWQ==
X-Gm-Message-State: AOAM530i1+lsAvwaAeorl81TwOfDL98gH0EQCg070660aRTh05f0Gs0A
        EVohERrsqGAZytz+XbB9V7Z88K3n3rs=
X-Google-Smtp-Source: ABdhPJwoqm/JHfkQProyiHfmwIANN5vYGpipE0NwXuJniC4WJKkaWMF6eoIE/2/ProayZ4/y4kPRug==
X-Received: by 2002:aa7:870d:0:b0:49f:e41d:4f8d with SMTP id b13-20020aa7870d000000b0049fe41d4f8dmr11714617pfo.16.1636693371428;
        Thu, 11 Nov 2021 21:02:51 -0800 (PST)
Received: from ast-mbp.thefacebook.com ([2620:10d:c090:400::5:3dc4])
        by smtp.gmail.com with ESMTPSA id nn4sm3715914pjb.38.2021.11.11.21.02.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Nov 2021 21:02:51 -0800 (PST)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, bpf@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH v2 bpf-next 07/12] libbpf: Use CO-RE in the kernel in light skeleton.
Date:   Thu, 11 Nov 2021 21:02:25 -0800
Message-Id: <20211112050230.85640-8-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211112050230.85640-1-alexei.starovoitov@gmail.com>
References: <20211112050230.85640-1-alexei.starovoitov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Alexei Starovoitov <ast@kernel.org>

Without lskel the CO-RE relocations are processed by libbpf before any other
work is done. Instead, when lksel is needed, remember relocation as RELO_CORE
kind. Then when loader prog is generated for a given bpf program pass CO-RE
relos of that program to gen loader via bpf_gen__record_relo_core(). The gen
loader will remember them as-is and pass it later as-is into the kernel.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 tools/lib/bpf/bpf_gen_internal.h |   3 +
 tools/lib/bpf/gen_loader.c       |  41 +++++++++++-
 tools/lib/bpf/libbpf.c           | 104 +++++++++++++++++++++++--------
 3 files changed, 119 insertions(+), 29 deletions(-)

diff --git a/tools/lib/bpf/bpf_gen_internal.h b/tools/lib/bpf/bpf_gen_internal.h
index 75ca9fb857b2..ed162fdeecf6 100644
--- a/tools/lib/bpf/bpf_gen_internal.h
+++ b/tools/lib/bpf/bpf_gen_internal.h
@@ -39,6 +39,8 @@ struct bpf_gen {
 	int error;
 	struct ksym_relo_desc *relos;
 	int relo_cnt;
+	struct bpf_core_relo *core_relo;
+	int core_relo_cnt;
 	char attach_target[128];
 	int attach_kind;
 	struct ksym_desc *ksyms;
@@ -61,5 +63,6 @@ void bpf_gen__map_freeze(struct bpf_gen *gen, int map_idx);
 void bpf_gen__record_attach_target(struct bpf_gen *gen, const char *name, enum bpf_attach_type type);
 void bpf_gen__record_extern(struct bpf_gen *gen, const char *name, bool is_weak,
 			    bool is_typeless, int kind, int insn_idx);
+void bpf_gen__record_relo_core(struct bpf_gen *gen, const struct bpf_core_relo *core_relo);
 
 #endif
diff --git a/tools/lib/bpf/gen_loader.c b/tools/lib/bpf/gen_loader.c
index 7b73f97b1fa1..442c4477e38e 100644
--- a/tools/lib/bpf/gen_loader.c
+++ b/tools/lib/bpf/gen_loader.c
@@ -839,6 +839,22 @@ static void emit_relo_ksym_btf(struct bpf_gen *gen, struct ksym_relo_desc *relo,
 	emit_ksym_relo_log(gen, relo, kdesc->ref);
 }
 
+void bpf_gen__record_relo_core(struct bpf_gen *gen,
+			       const struct bpf_core_relo *core_relo)
+{
+	struct bpf_core_relo *relo;
+
+	relo = libbpf_reallocarray(gen->core_relo, gen->core_relo_cnt + 1, sizeof(*relo));
+	if (!relo) {
+		gen->error = -ENOMEM;
+		return;
+	}
+	gen->core_relo = relo;
+	relo += gen->core_relo_cnt;
+	memcpy(relo, core_relo, sizeof(*relo));
+	gen->core_relo_cnt++;
+}
+
 static void emit_relo(struct bpf_gen *gen, struct ksym_relo_desc *relo, int insns)
 {
 	int insn;
@@ -871,6 +887,15 @@ static void emit_relos(struct bpf_gen *gen, int insns)
 		emit_relo(gen, gen->relos + i, insns);
 }
 
+static void cleanup_core_relo(struct bpf_gen *gen)
+{
+	if (!gen->core_relo_cnt)
+		return;
+	free(gen->core_relo);
+	gen->core_relo_cnt = 0;
+	gen->core_relo = NULL;
+}
+
 static void cleanup_relos(struct bpf_gen *gen, int insns)
 {
 	int i, insn;
@@ -898,6 +923,7 @@ static void cleanup_relos(struct bpf_gen *gen, int insns)
 		gen->relo_cnt = 0;
 		gen->relos = NULL;
 	}
+	cleanup_core_relo(gen);
 }
 
 void bpf_gen__prog_load(struct bpf_gen *gen,
@@ -905,12 +931,13 @@ void bpf_gen__prog_load(struct bpf_gen *gen,
 			const char *license, struct bpf_insn *insns, size_t insn_cnt,
 			struct bpf_prog_load_opts *load_attr, int prog_idx)
 {
-	int attr_size = offsetofend(union bpf_attr, fd_array);
-	int prog_load_attr, license_off, insns_off, func_info, line_info;
+	int prog_load_attr, license_off, insns_off, func_info, line_info, core_relo;
+	int attr_size = offsetofend(union bpf_attr, core_relo_rec_size);
 	union bpf_attr attr;
 
 	memset(&attr, 0, attr_size);
-	pr_debug("gen: prog_load: type %d insns_cnt %zd\n", prog_type, insn_cnt);
+	pr_debug("gen: prog_load: type %d insns_cnt %zd progi_idx %d\n",
+		 prog_type, insn_cnt, prog_idx);
 	/* add license string to blob of bytes */
 	license_off = add_data(gen, license, strlen(license) + 1);
 	/* add insns to blob of bytes */
@@ -934,6 +961,11 @@ void bpf_gen__prog_load(struct bpf_gen *gen,
 	line_info = add_data(gen, load_attr->line_info,
 			     attr.line_info_cnt * attr.line_info_rec_size);
 
+	attr.core_relo_rec_size = sizeof(struct bpf_core_relo);
+	attr.core_relo_cnt = gen->core_relo_cnt;
+	core_relo = add_data(gen, gen->core_relo,
+			     attr.core_relo_cnt * attr.core_relo_rec_size);
+
 	memcpy(attr.prog_name, prog_name,
 	       min((unsigned)strlen(prog_name), BPF_OBJ_NAME_LEN - 1));
 	prog_load_attr = add_data(gen, &attr, attr_size);
@@ -950,6 +982,9 @@ void bpf_gen__prog_load(struct bpf_gen *gen,
 	/* populate union bpf_attr with a pointer to line_info */
 	emit_rel_store(gen, attr_field(prog_load_attr, line_info), line_info);
 
+	/* populate union bpf_attr with a pointer to core_relo */
+	emit_rel_store(gen, attr_field(prog_load_attr, core_relo), core_relo);
+
 	/* populate union bpf_attr fd_array with a pointer to data where map_fds are saved */
 	emit_rel_store(gen, attr_field(prog_load_attr, fd_array), gen->fd_array);
 
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index e41867550ef2..2311f484511a 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -211,6 +211,7 @@ enum reloc_type {
 	RELO_EXTERN_VAR,
 	RELO_EXTERN_FUNC,
 	RELO_SUBPROG_ADDR,
+	RELO_CORE,
 };
 
 struct reloc_desc {
@@ -218,6 +219,9 @@ struct reloc_desc {
 	int insn_idx;
 	int map_idx;
 	int sym_off;
+	int access_str_off;
+	int type_id;
+	enum bpf_core_relo_kind kind;
 };
 
 struct bpf_sec_def;
@@ -5398,6 +5402,26 @@ static void *u32_as_hash_key(__u32 x)
 	return (void *)(uintptr_t)x;
 }
 
+static int record_relo_core(struct bpf_program *prog,
+			    const struct bpf_core_relo *core_relo, int insn_idx)
+{
+	struct reloc_desc *relos, *relo;
+
+	relos = libbpf_reallocarray(prog->reloc_desc,
+				    prog->nr_reloc + 1, sizeof(*relos));
+	if (!relos)
+		return -ENOMEM;
+	relo = &relos[prog->nr_reloc];
+	relo->type = RELO_CORE;
+	relo->insn_idx = insn_idx;
+	relo->access_str_off = core_relo->access_str_off;
+	relo->type_id = core_relo->type_id;
+	relo->kind = core_relo->kind;
+	prog->reloc_desc = relos;
+	prog->nr_reloc++;
+	return 0;
+}
+
 static int bpf_core_apply_relo(struct bpf_program *prog,
 			       const struct bpf_core_relo *relo,
 			       int relo_idx,
@@ -5434,10 +5458,16 @@ static int bpf_core_apply_relo(struct bpf_program *prog,
 		return -EINVAL;
 
 	if (prog->obj->gen_loader) {
-		pr_warn("// TODO core_relo: prog %td insn[%d] %s kind %d\n",
+		const char *spec_str = btf__name_by_offset(local_btf, relo->access_str_off);
+
+		/* Adjust relo_core's insn_idx since final subprog offset in
+		 * the main prog is known.
+		 */
+		insn_idx += prog->sub_insn_off;
+		pr_debug("record_relo_core: prog %td insn[%d] %s %s %s final insn_idx %d\n",
 			prog - prog->obj->programs, relo->insn_off / 8,
-			local_name, relo->kind);
-		return -ENOTSUP;
+			btf_kind_str(local_type), local_name, spec_str, insn_idx);
+		return record_relo_core(prog, relo, insn_idx);
 	}
 
 	if (relo->kind != BPF_CORE_TYPE_ID_LOCAL &&
@@ -5634,6 +5664,9 @@ bpf_object__relocate_data(struct bpf_object *obj, struct bpf_program *prog)
 		case RELO_CALL:
 			/* handled already */
 			break;
+		case RELO_CORE:
+			/* handled already */
+			break;
 		default:
 			pr_warn("prog '%s': relo #%d: bad relo type %d\n",
 				prog->name, i, relo->type);
@@ -6071,6 +6104,35 @@ bpf_object__free_relocs(struct bpf_object *obj)
 	}
 }
 
+static int cmp_relocs(const void *_a, const void *_b)
+{
+	const struct reloc_desc *a = _a;
+	const struct reloc_desc *b = _b;
+
+	if (a->insn_idx != b->insn_idx)
+		return a->insn_idx < b->insn_idx ? -1 : 1;
+
+	/* no two relocations should have the same insn_idx, but ... */
+	if (a->type != b->type)
+		return a->type < b->type ? -1 : 1;
+
+	return 0;
+}
+
+static void bpf_object__sort_relos(struct bpf_object *obj)
+{
+	int i;
+
+	for (i = 0; i < obj->nr_programs; i++) {
+		struct bpf_program *p = &obj->programs[i];
+
+		if (!p->nr_reloc)
+			continue;
+
+		qsort(p->reloc_desc, p->nr_reloc, sizeof(*p->reloc_desc), cmp_relocs);
+	}
+}
+
 static int
 bpf_object__relocate(struct bpf_object *obj, const char *targ_btf_path)
 {
@@ -6085,6 +6147,8 @@ bpf_object__relocate(struct bpf_object *obj, const char *targ_btf_path)
 				err);
 			return err;
 		}
+		if (obj->gen_loader)
+			bpf_object__sort_relos(obj);
 	}
 
 	/* Before relocating calls pre-process relocations and mark
@@ -6262,21 +6326,6 @@ static int bpf_object__collect_map_relos(struct bpf_object *obj,
 	return 0;
 }
 
-static int cmp_relocs(const void *_a, const void *_b)
-{
-	const struct reloc_desc *a = _a;
-	const struct reloc_desc *b = _b;
-
-	if (a->insn_idx != b->insn_idx)
-		return a->insn_idx < b->insn_idx ? -1 : 1;
-
-	/* no two relocations should have the same insn_idx, but ... */
-	if (a->type != b->type)
-		return a->type < b->type ? -1 : 1;
-
-	return 0;
-}
-
 static int bpf_object__collect_relos(struct bpf_object *obj)
 {
 	int i, err;
@@ -6309,14 +6358,7 @@ static int bpf_object__collect_relos(struct bpf_object *obj)
 			return err;
 	}
 
-	for (i = 0; i < obj->nr_programs; i++) {
-		struct bpf_program *p = &obj->programs[i];
-
-		if (!p->nr_reloc)
-			continue;
-
-		qsort(p->reloc_desc, p->nr_reloc, sizeof(*p->reloc_desc), cmp_relocs);
-	}
+	bpf_object__sort_relos(obj);
 	return 0;
 }
 
@@ -6581,6 +6623,16 @@ static int bpf_program__record_externs(struct bpf_program *prog)
 					       ext->is_weak, false, BTF_KIND_FUNC,
 					       relo->insn_idx);
 			break;
+		case RELO_CORE: {
+			struct bpf_core_relo cr = {
+				.insn_off = relo->insn_idx * 8,
+				.type_id = relo->type_id,
+				.access_str_off = relo->access_str_off,
+				.kind = relo->kind,
+			};
+			bpf_gen__record_relo_core(obj->gen_loader, &cr);
+			break;
+		}
 		default:
 			continue;
 		}
-- 
2.30.2

