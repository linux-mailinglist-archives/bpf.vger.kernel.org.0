Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D7664654DF
	for <lists+bpf@lfdr.de>; Wed,  1 Dec 2021 19:13:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352169AbhLASO5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Dec 2021 13:14:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352180AbhLASOb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Dec 2021 13:14:31 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 109C4C061748
        for <bpf@vger.kernel.org>; Wed,  1 Dec 2021 10:11:09 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id gt5so18615110pjb.1
        for <bpf@vger.kernel.org>; Wed, 01 Dec 2021 10:11:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KH8+ESV24YZTjD2HLUC8jof2YIXdIvjexwdmRwD2YuE=;
        b=oIumbOtE1yU2Y4vQP4JU2xxE8voi4jVnLeg9V9rkmzKaxnlb6r5lL+KESO+V6MUfMs
         YBRN4gm5j10hqfETt6AL18GwjnqMna6Q9/H4/TgpkC6+O6617MvW657J67yUlFPl8Kt0
         xQV3Cv5fy6JN71UNcEgIaddjU6dF9FxePVCHloerITPYD49J2F3GD/Jc4ZfMLXkTVRzo
         A0y2Se7dJjDi/FNTnoRrX/jLR3i9kMqhPcpBJ3QkB8wqLZCcTx+sWTqZ9kESpSpgYIVa
         epihKIUYgt+z+ADb3oEzji1H6/MQglnk5BasKYmoOi4GmH5q2bjGyk8njmzFniAEIyyQ
         Ph6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KH8+ESV24YZTjD2HLUC8jof2YIXdIvjexwdmRwD2YuE=;
        b=xoZt5nwmzJafAmiYzz6ZNyph8bqCMssHn6AYvDWXnNRwVaNObt8KCqrXXKuGgqnK98
         R+nfwD7vE7Q0ZmB2Y+nH9LPXCQ05QiDR4fS9Wz7PvoS9uIwy+Or07HMx4j+3dhiPNbx3
         B9qkPywvlblfyPmZ2v4G+ZjYvPaMgeuqrxXDR+iBXbcwc4g8aqjIb1qbfCcfKDZ9KTL0
         mB5oUnsFp7tgRdG4yxNpdk7WmUUas170GP1FtlJGni40mxDhw1WlCmSA48gAdSSyCt/e
         tlnjya2Du3w/53JZUKcJcOq/VUk4o7hEh4KMM4EPJvhkSBeMeqJVFnA1vm6EJj9zWfyG
         4qKQ==
X-Gm-Message-State: AOAM5310ZQ6mgjNR2IhfmxDDmxNQDnB6wMOPq08FYBZyHv+PjoKNCLSU
        dtxy4an5iBc4NqgU+FUeyBY=
X-Google-Smtp-Source: ABdhPJzmPnA3tI9m93C0Ui28Tg9HhboYYygkuGnHPl321BXOVwrd/lDLC+6oNpyM9tqv5AQXAaT92g==
X-Received: by 2002:a17:90a:690d:: with SMTP id r13mr9707568pjj.40.1638382268477;
        Wed, 01 Dec 2021 10:11:08 -0800 (PST)
Received: from ast-mbp.thefacebook.com ([2620:10d:c090:400::5:620c])
        by smtp.gmail.com with ESMTPSA id e6sm326253pgc.33.2021.12.01.10.11.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Dec 2021 10:11:08 -0800 (PST)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, bpf@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH v5 bpf-next 09/17] libbpf: Use CO-RE in the kernel in light skeleton.
Date:   Wed,  1 Dec 2021 10:10:32 -0800
Message-Id: <20211201181040.23337-10-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211201181040.23337-1-alexei.starovoitov@gmail.com>
References: <20211201181040.23337-1-alexei.starovoitov@gmail.com>
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

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 tools/lib/bpf/bpf_gen_internal.h |   3 +
 tools/lib/bpf/gen_loader.c       |  41 +++++++++++-
 tools/lib/bpf/libbpf.c           | 109 ++++++++++++++++++++++---------
 3 files changed, 120 insertions(+), 33 deletions(-)

diff --git a/tools/lib/bpf/bpf_gen_internal.h b/tools/lib/bpf/bpf_gen_internal.h
index ae7704deba30..9d57fa84664b 100644
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
@@ -64,5 +66,6 @@ void bpf_gen__map_freeze(struct bpf_gen *gen, int map_idx);
 void bpf_gen__record_attach_target(struct bpf_gen *gen, const char *name, enum bpf_attach_type type);
 void bpf_gen__record_extern(struct bpf_gen *gen, const char *name, bool is_weak,
 			    bool is_typeless, int kind, int insn_idx);
+void bpf_gen__record_relo_core(struct bpf_gen *gen, const struct bpf_core_relo *core_relo);
 
 #endif
diff --git a/tools/lib/bpf/gen_loader.c b/tools/lib/bpf/gen_loader.c
index 6f3790369463..87d385e892ab 100644
--- a/tools/lib/bpf/gen_loader.c
+++ b/tools/lib/bpf/gen_loader.c
@@ -829,6 +829,22 @@ static void emit_relo_ksym_btf(struct bpf_gen *gen, struct ksym_relo_desc *relo,
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
@@ -861,6 +877,15 @@ static void emit_relos(struct bpf_gen *gen, int insns)
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
@@ -888,6 +913,7 @@ static void cleanup_relos(struct bpf_gen *gen, int insns)
 		gen->relo_cnt = 0;
 		gen->relos = NULL;
 	}
+	cleanup_core_relo(gen);
 }
 
 void bpf_gen__prog_load(struct bpf_gen *gen,
@@ -895,12 +921,13 @@ void bpf_gen__prog_load(struct bpf_gen *gen,
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
@@ -924,6 +951,11 @@ void bpf_gen__prog_load(struct bpf_gen *gen,
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
@@ -940,6 +972,9 @@ void bpf_gen__prog_load(struct bpf_gen *gen,
 	/* populate union bpf_attr with a pointer to line_info */
 	emit_rel_store(gen, attr_field(prog_load_attr, line_info), line_info);
 
+	/* populate union bpf_attr with a pointer to core_relos */
+	emit_rel_store(gen, attr_field(prog_load_attr, core_relos), core_relos);
+
 	/* populate union bpf_attr fd_array with a pointer to data where map_fds are saved */
 	emit_rel_store(gen, attr_field(prog_load_attr, fd_array), gen->fd_array);
 
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 96792d6e6fc1..831c12e00813 100644
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
@@ -5485,6 +5491,24 @@ static void *u32_as_hash_key(__u32 x)
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
@@ -5521,10 +5545,12 @@ static int bpf_core_apply_relo(struct bpf_program *prog,
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
@@ -5729,6 +5755,9 @@ bpf_object__relocate_data(struct bpf_object *obj, struct bpf_program *prog)
 		case RELO_CALL:
 			/* handled already */
 			break;
+		case RELO_CORE:
+			/* will be handled by bpf_program_record_relos() */
+			break;
 		default:
 			pr_warn("prog '%s': relo #%d: bad relo type %d\n",
 				prog->name, i, relo->type);
@@ -6169,6 +6198,35 @@ bpf_object__free_relocs(struct bpf_object *obj)
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
@@ -6183,6 +6241,8 @@ bpf_object__relocate(struct bpf_object *obj, const char *targ_btf_path)
 				err);
 			return err;
 		}
+		if (obj->gen_loader)
+			bpf_object__sort_relos(obj);
 	}
 
 	/* Before relocating calls pre-process relocations and mark
@@ -6387,21 +6447,6 @@ static int bpf_object__collect_map_relos(struct bpf_object *obj,
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
@@ -6434,14 +6479,7 @@ static int bpf_object__collect_relos(struct bpf_object *obj)
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
 
@@ -6683,7 +6721,7 @@ static int bpf_object_load_prog_instance(struct bpf_object *obj, struct bpf_prog
 	return ret;
 }
 
-static int bpf_program__record_externs(struct bpf_program *prog)
+static int bpf_program_record_relos(struct bpf_program *prog)
 {
 	struct bpf_object *obj = prog->obj;
 	int i;
@@ -6705,6 +6743,17 @@ static int bpf_program__record_externs(struct bpf_program *prog)
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
+
+			bpf_gen__record_relo_core(obj->gen_loader, &cr);
+			break;
+		}
 		default:
 			continue;
 		}
@@ -6744,7 +6793,7 @@ static int bpf_object_load_prog(struct bpf_object *obj, struct bpf_program *prog
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

