Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4B1245B420
	for <lists+bpf@lfdr.de>; Wed, 24 Nov 2021 07:02:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233942AbhKXGFo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Nov 2021 01:05:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234090AbhKXGFo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Nov 2021 01:05:44 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32227C061574
        for <bpf@vger.kernel.org>; Tue, 23 Nov 2021 22:02:35 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id o14so975870plg.5
        for <bpf@vger.kernel.org>; Tue, 23 Nov 2021 22:02:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tYBDWGQ/fqt2Q19WUT9CZLGkwmXEkj0pgwR7Lsg5tU0=;
        b=gcLOd97ZSH0N3uQvzf6MISEKjO2k/eK/Q1aYKzfBR6PU10RrywzSXSu7s0IXhA9klp
         Ip3atluiiQRfpENZKYxqDA0RkIFFhQ6B1LJBdJ0c5GULXQrvMTXnz+qdNrbjX2INHAnx
         Yn+iVDmF2SZT8rlnk7V0rho3tHzq17lJx5C0GuDSjZBGCSGnFmasJ/UpnqDkDb1x9oJt
         VHQz3rw1+DdUlFLHiW5JueCklUScmEynozgjwEvFSRAQkKmMqhpWMUwcvKXNNJe9QqSz
         cv5ROad1gnNIEUTDTWOj2A6Oj8pHqc2H+XZ0MpIcEqyl22F1eH5JqIklV9nWhnh7MLj8
         KgXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tYBDWGQ/fqt2Q19WUT9CZLGkwmXEkj0pgwR7Lsg5tU0=;
        b=ENV3ZvijBdHVY7ilM+xJhHzpfKrKZ/CVdNglEmLAznOeQLIzHniiQKMKqeW6ugHyYs
         SLfnEpioAD8Z+YCCeC2XYgjmfXxA19Ibyo9hYWWyp6PiEmzZV3mlBBofb2xVyry4/sRX
         VvkYSqJg4HBSLvvBQUXeU83uweRMNWC/F2/+SJN+yYfH3lLdrlP6GXbdnQhiF6tV0Chc
         YBhJeHdnZJ0xCzgqInAHaraO4diE6IIK/bZfIQqEHADvOLuCj2g45ezVyiPTDRnD+lOl
         qNevT4hTgc8U1EM4zb/Z/XVmXnk2Sg+TnNHRsxAyenOnvGDjCp7vRFRwHZuVEfUrce4i
         /zGw==
X-Gm-Message-State: AOAM533ljVW5tIs836TAsluej5tSAMW4HeN2oLPsfjhEnP28HCN5b3hV
        O7z/VDKvgQv807ZbAHvbW1Y=
X-Google-Smtp-Source: ABdhPJwhwJiFXXYY9nqSWCffvjM2oXxKyMvu5XEo7uUF4vINOCS9olaj6t/9/ediYD5CrJ3TMP2ONg==
X-Received: by 2002:a17:90a:2843:: with SMTP id p3mr11962923pjf.176.1637733754649;
        Tue, 23 Nov 2021 22:02:34 -0800 (PST)
Received: from ast-mbp.thefacebook.com ([2620:10d:c090:400::5:8fd1])
        by smtp.gmail.com with ESMTPSA id s30sm15952886pfg.17.2021.11.23.22.02.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Nov 2021 22:02:34 -0800 (PST)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, bpf@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH v4 bpf-next 08/16] libbpf: Use CO-RE in the kernel in light skeleton.
Date:   Tue, 23 Nov 2021 22:02:01 -0800
Message-Id: <20211124060209.493-9-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211124060209.493-1-alexei.starovoitov@gmail.com>
References: <20211124060209.493-1-alexei.starovoitov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Alexei Starovoitov <ast@kernel.org>

Without lskel the CO-RE relocations are processed by libbpf before any other
work is done. Instead, when lskel is needed, remember relocation as RELO_CORE
kind. Then when loader prog is generated for a given bpf program pass CO-RE
relos of that program to gen loader via bpf_gen__record_relo_core(). The gen
loader will remember them as-is and pass it later as-is into the kernel.

The normal libbpf flow is to process CO-RE early before call relos happen. In
case of gen_loader the core relos have to be added to other relos to be copied
together when bpf static function is appended in different places to other main
bpf progs. During the copy the append_subprog_relos() will adjust insn_idx for
normal relos and for RELO_CORE kind too. When that is done each struct
reloc_desc has good relos for specific main prog.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 tools/lib/bpf/bpf_gen_internal.h |   3 +
 tools/lib/bpf/gen_loader.c       |  41 +++++++++++-
 tools/lib/bpf/libbpf.c           | 108 ++++++++++++++++++++++---------
 3 files changed, 119 insertions(+), 33 deletions(-)

diff --git a/tools/lib/bpf/bpf_gen_internal.h b/tools/lib/bpf/bpf_gen_internal.h
index 75ca9fb857b2..5cbc3e5d3e69 100644
--- a/tools/lib/bpf/bpf_gen_internal.h
+++ b/tools/lib/bpf/bpf_gen_internal.h
@@ -39,6 +39,8 @@ struct bpf_gen {
 	int error;
 	struct ksym_relo_desc *relos;
 	int relo_cnt;
+	struct bpf_core_relo *core_relos;
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
index 7b73f97b1fa1..4e32fe1f68db 100644
--- a/tools/lib/bpf/gen_loader.c
+++ b/tools/lib/bpf/gen_loader.c
@@ -839,6 +839,22 @@ static void emit_relo_ksym_btf(struct bpf_gen *gen, struct ksym_relo_desc *relo,
 	emit_ksym_relo_log(gen, relo, kdesc->ref);
 }
 
+void bpf_gen__record_relo_core(struct bpf_gen *gen,
+			       const struct bpf_core_relo *core_relo)
+{
+	struct bpf_core_relo *relos;
+
+	relos = libbpf_reallocarray(gen->core_relos, gen->core_relo_cnt + 1, sizeof(*relos));
+	if (!relos) {
+		gen->error = -ENOMEM;
+		return;
+	}
+	gen->core_relos = relos;
+	relos += gen->core_relo_cnt;
+	memcpy(relos, core_relo, sizeof(*relos));
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
+	free(gen->core_relos);
+	gen->core_relo_cnt = 0;
+	gen->core_relos = NULL;
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
+	int prog_load_attr, license_off, insns_off, func_info, line_info, core_relos;
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
+	core_relos = add_data(gen, gen->core_relos,
+			     attr.core_relo_cnt * attr.core_relo_rec_size);
+
 	memcpy(attr.prog_name, prog_name,
 	       min((unsigned)strlen(prog_name), BPF_OBJ_NAME_LEN - 1));
 	prog_load_attr = add_data(gen, &attr, attr_size);
@@ -950,6 +982,9 @@ void bpf_gen__prog_load(struct bpf_gen *gen,
 	/* populate union bpf_attr with a pointer to line_info */
 	emit_rel_store(gen, attr_field(prog_load_attr, line_info), line_info);
 
+	/* populate union bpf_attr with a pointer to core_relos */
+	emit_rel_store(gen, attr_field(prog_load_attr, core_relos), core_relos);
+
 	/* populate union bpf_attr fd_array with a pointer to data where map_fds are saved */
 	emit_rel_store(gen, attr_field(prog_load_attr, fd_array), gen->fd_array);
 
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index fc9a179ea412..dbb393768339 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -230,13 +230,19 @@ enum reloc_type {
 	RELO_EXTERN_VAR,
 	RELO_EXTERN_FUNC,
 	RELO_SUBPROG_ADDR,
+	RELO_CORE,
 };
 
 struct reloc_desc {
 	enum reloc_type type;
 	int insn_idx;
-	int map_idx;
-	int sym_off;
+	union {
+		const struct bpf_core_relo *core_relo; /* used when type == RELO_CORE */
+		struct {
+			int map_idx;
+			int sym_off;
+		};
+	};
 };
 
 struct bpf_sec_def;
@@ -5417,6 +5423,24 @@ static void *u32_as_hash_key(__u32 x)
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
+	relo->core_relo = core_relo;
+	prog->reloc_desc = relos;
+	prog->nr_reloc++;
+	return 0;
+}
+
 static int bpf_core_apply_relo(struct bpf_program *prog,
 			       const struct bpf_core_relo *relo,
 			       int relo_idx,
@@ -5453,10 +5477,12 @@ static int bpf_core_apply_relo(struct bpf_program *prog,
 		return -EINVAL;
 
 	if (prog->obj->gen_loader) {
-		pr_warn("// TODO core_relo: prog %td insn[%d] %s kind %d\n",
+		const char *spec_str = btf__name_by_offset(local_btf, relo->access_str_off);
+
+		pr_debug("record_relo_core: prog %td insn[%d] %s %s %s final insn_idx %d\n",
 			prog - prog->obj->programs, relo->insn_off / 8,
-			local_name, relo->kind);
-		return -ENOTSUP;
+			btf_kind_str(local_type), local_name, spec_str, insn_idx);
+		return record_relo_core(prog, relo, insn_idx);
 	}
 
 	if (relo->kind != BPF_CORE_TYPE_ID_LOCAL &&
@@ -5653,6 +5679,9 @@ bpf_object__relocate_data(struct bpf_object *obj, struct bpf_program *prog)
 		case RELO_CALL:
 			/* handled already */
 			break;
+		case RELO_CORE:
+			/* will be handled by bpf_program_record_relos() */
+			break;
 		default:
 			pr_warn("prog '%s': relo #%d: bad relo type %d\n",
 				prog->name, i, relo->type);
@@ -6090,6 +6119,35 @@ bpf_object__free_relocs(struct bpf_object *obj)
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
@@ -6104,6 +6162,8 @@ bpf_object__relocate(struct bpf_object *obj, const char *targ_btf_path)
 				err);
 			return err;
 		}
+		if (obj->gen_loader)
+			bpf_object__sort_relos(obj);
 	}
 
 	/* Before relocating calls pre-process relocations and mark
@@ -6281,21 +6341,6 @@ static int bpf_object__collect_map_relos(struct bpf_object *obj,
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
@@ -6328,14 +6373,7 @@ static int bpf_object__collect_relos(struct bpf_object *obj)
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
 
@@ -6578,7 +6616,7 @@ static int bpf_object_load_prog_instance(struct bpf_object *obj, struct bpf_prog
 	return ret;
 }
 
-static int bpf_program__record_externs(struct bpf_program *prog)
+static int bpf_program_record_relos(struct bpf_program *prog)
 {
 	struct bpf_object *obj = prog->obj;
 	int i;
@@ -6600,6 +6638,16 @@ static int bpf_program__record_externs(struct bpf_program *prog)
 					       ext->is_weak, false, BTF_KIND_FUNC,
 					       relo->insn_idx);
 			break;
+		case RELO_CORE: {
+			struct bpf_core_relo cr = {
+				.insn_off = relo->insn_idx * 8,
+				.type_id = relo->core_relo->type_id,
+				.access_str_off = relo->core_relo->access_str_off,
+				.kind = relo->core_relo->kind,
+			};
+			bpf_gen__record_relo_core(obj->gen_loader, &cr);
+			break;
+		}
 		default:
 			continue;
 		}
@@ -6639,7 +6687,7 @@ static int bpf_object_load_prog(struct bpf_object *obj, struct bpf_program *prog
 				prog->name, prog->instances.nr);
 		}
 		if (obj->gen_loader)
-			bpf_program__record_externs(prog);
+			bpf_program_record_relos(prog);
 		err = bpf_object_load_prog_instance(obj, prog,
 						    prog->insns, prog->insns_cnt,
 						    license, kern_ver, &fd);
-- 
2.30.2

