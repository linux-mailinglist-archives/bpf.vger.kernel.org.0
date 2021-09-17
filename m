Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B691E4100FD
	for <lists+bpf@lfdr.de>; Fri, 17 Sep 2021 23:57:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242904AbhIQV7E (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Sep 2021 17:59:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244153AbhIQV7C (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Sep 2021 17:59:02 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0C77C061574
        for <bpf@vger.kernel.org>; Fri, 17 Sep 2021 14:57:39 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id g14so10492751pfm.1
        for <bpf@vger.kernel.org>; Fri, 17 Sep 2021 14:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Kg30gb5V5wpAEUkwgND/4+3h9tf63DGzM6UZzAJ1/Yc=;
        b=DSFAO2/j7B9zHZK67NS5d7c+pOxy+m1uqR8vBMB0gdnE9bPjJXw46+/TINO4HG0XiM
         dv6qXNoC9ZibPzBkAIg3j9/N2vugYGN8AZnXH1ThTXufdycTeWcj2Ad0hkzxuNSbWSTs
         pc4BHy/MtHVjyLlLNap99FY7f05KVd/trhW6fwW11aKdw7c1Pn+DltfyuaQaMXeAEQGR
         AUIAtY7MAdEt34gHzmNVnPR9Bt9pAMfsbA47Hya8Odk5Ikt8m4lDDUQr/1VIoUhl8Bpj
         p+FIkiFeQF6dsuMraYUQ5yUyhmipM3xgc6rTXkS7QCSzvaqD6JKK2OfQWZhpCJl7GVC1
         GEeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Kg30gb5V5wpAEUkwgND/4+3h9tf63DGzM6UZzAJ1/Yc=;
        b=v+KlLTdcWREQJU4QeI3Fpz98El574+4WoSx55fsuavY+xAnUgBTh52JTwG+S1s3rup
         ucYF/AOYQIsSL/8NiW+W1zFbtwc9mwNRIi0+DkyI3ICVWhdsVq8gGiNY4sM5bX0OuzTT
         g6mRB5txu+xZU0mFNb/o4nN5ZO8HtC/H4AjZjQhin6Wm6PZw3LquONs/XvCtuNMCJPRj
         jzOWnq+iPHKj1qXm3LMmoZgdaLHMhVnhOI+f8vXpfS9T0uNFQ+/ky4vHS3ThVGDrMy9J
         r5UZ4vAXJoJgCdDT8WmM4x4jSiWkR0fVDY6d78RgHCxQ7z6fOZufzHET0qfPPDYboYhy
         c+EA==
X-Gm-Message-State: AOAM532cBlxD+kZtTVvic/EsdzN/b8nYpsD5yf6d9Hkk+zKuJ/TPY4YA
        H0IiRHKCiE1EmezWzgQTEfU=
X-Google-Smtp-Source: ABdhPJzuMDD+v7uIUvqdg6W/ZuDi/4DaJh2f91MImE5scBQ6zPqIhORdIFAg8iuQ6eAGrAxo368XNw==
X-Received: by 2002:a62:645:0:b0:3f2:23bd:5fc0 with SMTP id 66-20020a620645000000b003f223bd5fc0mr12803860pfg.35.1631915859120;
        Fri, 17 Sep 2021 14:57:39 -0700 (PDT)
Received: from ast-mbp.thefacebook.com ([2620:10d:c090:500::6:db29])
        by smtp.gmail.com with ESMTPSA id cl16sm6494773pjb.23.2021.09.17.14.57.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Sep 2021 14:57:38 -0700 (PDT)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, john.fastabend@gmail.com,
        lmb@cloudflare.com, mcroce@microsoft.com, bpf@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH RFC bpf-next 05/10] libbpf: Use CO-RE in the kernel in light skeleton.
Date:   Fri, 17 Sep 2021 14:57:16 -0700
Message-Id: <20210917215721.43491-6-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210917215721.43491-1-alexei.starovoitov@gmail.com>
References: <20210917215721.43491-1-alexei.starovoitov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Alexei Starovoitov <ast@kernel.org>

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 tools/lib/bpf/bpf_gen_internal.h | 12 ++++++++
 tools/lib/bpf/gen_loader.c       | 47 ++++++++++++++++++++++++++++++++
 tools/lib/bpf/libbpf.c           | 27 +++++++++++++++---
 3 files changed, 82 insertions(+), 4 deletions(-)

diff --git a/tools/lib/bpf/bpf_gen_internal.h b/tools/lib/bpf/bpf_gen_internal.h
index 615400391e57..1b27faf71080 100644
--- a/tools/lib/bpf/bpf_gen_internal.h
+++ b/tools/lib/bpf/bpf_gen_internal.h
@@ -9,6 +9,13 @@ struct ksym_relo_desc {
 	int insn_idx;
 };
 
+struct core_relo_desc {
+	__u32   insn_idx;
+	__u32   type_id;
+	__u32   access_str_off;
+	__u32	kind;
+};
+
 struct bpf_gen {
 	struct gen_loader_opts *opts;
 	void *data_start;
@@ -22,6 +29,8 @@ struct bpf_gen {
 	int error;
 	struct ksym_relo_desc *relos;
 	int relo_cnt;
+	struct core_relo_desc *core_relos;
+	int core_relo_cnt;
 	char attach_target[128];
 	int attach_kind;
 };
@@ -37,5 +46,8 @@ void bpf_gen__map_update_elem(struct bpf_gen *gen, int map_idx, void *value, __u
 void bpf_gen__map_freeze(struct bpf_gen *gen, int map_idx);
 void bpf_gen__record_attach_target(struct bpf_gen *gen, const char *name, enum bpf_attach_type type);
 void bpf_gen__record_extern(struct bpf_gen *gen, const char *name, int kind, int insn_idx);
+struct bpf_core_relo;
+void bpf_gen__record_relo_core(struct bpf_gen *gen, const struct bpf_core_relo *core_relo,
+			       int insn_idx);
 
 #endif
diff --git a/tools/lib/bpf/gen_loader.c b/tools/lib/bpf/gen_loader.c
index 8df718a6b142..fe2415ab53f6 100644
--- a/tools/lib/bpf/gen_loader.c
+++ b/tools/lib/bpf/gen_loader.c
@@ -524,6 +524,23 @@ void bpf_gen__record_extern(struct bpf_gen *gen, const char *name, int kind,
 	gen->relo_cnt++;
 }
 
+void bpf_gen__record_relo_core(struct bpf_gen *gen, const struct bpf_core_relo *core_relo,
+			       int insn_idx)
+{
+	struct core_relo_desc *relo;
+
+	relo = libbpf_reallocarray(gen->core_relos, gen->core_relo_cnt + 1, sizeof(*relo));
+	if (!relo) {
+		gen->error = -ENOMEM;
+		return;
+	}
+	gen->core_relos = relo;
+	relo += gen->core_relo_cnt;
+	memcpy(relo, core_relo, sizeof(*relo));
+	relo->insn_idx = insn_idx;
+	gen->core_relo_cnt++;
+}
+
 static void emit_relo(struct bpf_gen *gen, struct ksym_relo_desc *relo, int insns)
 {
 	int name, insn, len = strlen(relo->name) + 1;
@@ -554,12 +571,37 @@ static void emit_relo(struct bpf_gen *gen, struct ksym_relo_desc *relo, int insn
 	}
 }
 
+static void emit_core_relo(struct bpf_gen *gen, struct core_relo_desc *relo, int insns)
+{
+	int relo_off, insn, len = sizeof(*relo) - 4;
+
+	pr_debug("gen: relo_core: local_btf_id %d kind %d at %d\n",
+		 relo->type_id, relo->kind, relo->insn_idx);
+	relo_off = add_data(gen, &relo->type_id, len);
+
+	emit(gen, BPF_LDX_MEM(BPF_W, BPF_REG_1, BPF_REG_10, stack_off(btf_fd)));
+	emit2(gen, BPF_LD_IMM64_RAW_FULL(BPF_REG_2, BPF_PSEUDO_MAP_IDX_VALUE,
+					 0, 0, 0, relo_off));
+	emit(gen, BPF_MOV64_IMM(BPF_REG_3, len));
+	insn = insns + sizeof(struct bpf_insn) * relo->insn_idx;
+	emit2(gen, BPF_LD_IMM64_RAW_FULL(BPF_REG_4, BPF_PSEUDO_MAP_IDX_VALUE,
+					 0, 0, 0, insn));
+	emit(gen, BPF_MOV64_IMM(BPF_REG_5, 0));
+	emit(gen, BPF_EMIT_CALL(BPF_FUNC_core_apply_relo));
+	emit(gen, BPF_MOV64_REG(BPF_REG_7, BPF_REG_0));
+	debug_ret(gen, "core_apply_relo(btf_id=%d,kind=%d,insn=%d)",
+		  relo->type_id, relo->kind, relo->insn_idx);
+	emit_check_err(gen);
+}
+
 static void emit_relos(struct bpf_gen *gen, int insns)
 {
 	int i;
 
 	for (i = 0; i < gen->relo_cnt; i++)
 		emit_relo(gen, gen->relos + i, insns);
+	for (i = 0; i < gen->core_relo_cnt; i++)
+		emit_core_relo(gen, gen->core_relos + i, insns);
 }
 
 static void cleanup_relos(struct bpf_gen *gen, int insns)
@@ -580,6 +622,11 @@ static void cleanup_relos(struct bpf_gen *gen, int insns)
 		gen->relo_cnt = 0;
 		gen->relos = NULL;
 	}
+	if (gen->core_relo_cnt) {
+		free(gen->core_relos);
+		gen->core_relo_cnt = 0;
+		gen->core_relos = NULL;
+	}
 }
 
 void bpf_gen__prog_load(struct bpf_gen *gen,
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index bc023b6a6d87..ed2c4f6661fe 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -5175,10 +5175,17 @@ static int bpf_core_apply_relo(struct bpf_program *prog,
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
+		bpf_gen__record_relo_core(prog->obj->gen_loader, relo, insn_idx);
+		return 0;
 	}
 
 	if (relo->kind != BPF_CORE_TYPE_ID_LOCAL &&
@@ -5813,7 +5820,7 @@ bpf_object__relocate(struct bpf_object *obj, const char *targ_btf_path)
 	size_t i, j;
 	int err;
 
-	if (obj->btf_ext) {
+	if (obj->btf_ext && !obj->gen_loader) {
 		err = bpf_object__relocate_core(obj, targ_btf_path);
 		if (err) {
 			pr_warn("failed to perform CO-RE relocations: %d\n",
@@ -5863,6 +5870,18 @@ bpf_object__relocate(struct bpf_object *obj, const char *targ_btf_path)
 			return err;
 		}
 	}
+
+	/* Let gen_loader record CO-RE relocations after subprogs were appended
+	 * to make sure that insn_idx is calculated as the offset in main progs.
+	 */
+	if (obj->btf_ext && obj->gen_loader) {
+		err = bpf_object__relocate_core(obj, targ_btf_path);
+		if (err) {
+			pr_warn("failed to perform CO-RE relocations: %d\n",
+				err);
+			return err;
+		}
+	}
 	/* Process data relos for main programs */
 	for (i = 0; i < obj->nr_programs; i++) {
 		prog = &obj->programs[i];
-- 
2.30.2

