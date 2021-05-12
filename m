Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64DA337EF31
	for <lists+bpf@lfdr.de>; Thu, 13 May 2021 01:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236261AbhELW7y (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 May 2021 18:59:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344521AbhELVoA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 May 2021 17:44:00 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FCCCC08C5CE
        for <bpf@vger.kernel.org>; Wed, 12 May 2021 14:33:21 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id c17so19715863pfn.6
        for <bpf@vger.kernel.org>; Wed, 12 May 2021 14:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OsnBLDSMlVuHVifBOz4dW6U5UYCH6kuFs0zAOG7MXAk=;
        b=uSAAhBSwCW7mf524DDjSb/P6RptOf1gWAIaxJLdchGGukP1RDtV9f5lVOMFszOlP0E
         l3AxgY1RT6H+qI5Fg3agek76bw9yR1n9c6rtI4Zek6G8hqrVQ8fzoHZ6I6dRsiGdiDIP
         cHvnS7sWGn8moNWtx/LkBuNKbuKkdf0W/kHKJD5qcZIrDFZSjxf3yuY0RswkScg5yMN3
         MsrpqdE8L0WK6z6b1nigHSrmkZk954gn1TI61rGQk1ISmXVOW+Dyboc2ShdrAb3r1tri
         koEpQKEIGCWlV4V8HHUuSldB9I96n0NDqjogymRdAJnO7SytyAckjUFXsEQcbFsRzNtn
         FhZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OsnBLDSMlVuHVifBOz4dW6U5UYCH6kuFs0zAOG7MXAk=;
        b=F4pqu1LbVoZj7rGhJsHJyXIQ8RYId4szlMx3UE8qheNJKmIfWAH9ZhyXR6G8wEeZnC
         r41TVBfpkfL7VSu1dOU2+65T2i8LCifWcJpOnh2JQWD8pNLB7jb5uAl4cy2+hIK/zZp7
         aoHXVWP5fgpQqYGDKuv48hqW3M9+OA6RgmKKyEKPaEh5VrxR1qzpaj4fW0iM7wK4SMVN
         5re1eJA/A1oygXodG8wgwj01xTx9SSwD4CRAf9TiyasZeP8Dsbakww/fc1YVUk7/4Q7K
         1kbA9fvu6d5vBJ0GV+UetHpy/0BSnXYAyQIVQ6xvdnG6eAYBLcD0anWryqjYyIjIp/EE
         6r6w==
X-Gm-Message-State: AOAM531hM/+Bo4aQw6VLWKJuuoV1SD/W1SKDEDBaYYjLrtX229WP4YxW
        ZeLuDUDvEczz8uGeTgAUSHM=
X-Google-Smtp-Source: ABdhPJwxal1pClJRdT20HQwkrXnMY/aPLuaEjSzOee9kpyJ3wRELBVPBHkPCKBbT66XyuMCLj3p3Ag==
X-Received: by 2002:a63:184a:: with SMTP id 10mr37336741pgy.426.1620855200776;
        Wed, 12 May 2021 14:33:20 -0700 (PDT)
Received: from ast-mbp.thefacebook.com ([163.114.132.4])
        by smtp.gmail.com with ESMTPSA id c128sm609222pfa.189.2021.05.12.14.33.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 May 2021 14:33:20 -0700 (PDT)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, john.fastabend@gmail.com,
        bpf@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v5 bpf-next 11/21] libbpf: Change the order of data and text relocations.
Date:   Wed, 12 May 2021 14:32:46 -0700
Message-Id: <20210512213256.31203-12-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20210512213256.31203-1-alexei.starovoitov@gmail.com>
References: <20210512213256.31203-1-alexei.starovoitov@gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Alexei Starovoitov <ast@kernel.org>

In order to be able to generate loader program in the later
patches change the order of data and text relocations.
Also improve the test to include data relos.

If the kernel supports "FD array" the map_fd relocations can be processed
before text relos since generated loader program won't need to manually
patch ld_imm64 insns with map_fd.
But ksym and kfunc relocations can only be processed after all calls
are relocated, since loader program will consist of a sequence
of calls to bpf_btf_find_by_name_kind() followed by patching of btf_id
and btf_obj_fd into corresponding ld_imm64 insns. The locations of those
ld_imm64 insns are specified in relocations.
Hence process all data relocations (maps, ksym, kfunc) together after call relos.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/libbpf.c                        | 86 ++++++++++++++++---
 .../selftests/bpf/progs/test_subprogs.c       | 13 +++
 2 files changed, 85 insertions(+), 14 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index f4cf7cb87986..0243cbe79bda 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -6400,11 +6400,15 @@ bpf_object__relocate_data(struct bpf_object *obj, struct bpf_program *prog)
 			insn[0].imm = ext->ksym.kernel_btf_id;
 			break;
 		case RELO_SUBPROG_ADDR:
-			insn[0].src_reg = BPF_PSEUDO_FUNC;
-			/* will be handled as a follow up pass */
+			if (insn[0].src_reg != BPF_PSEUDO_FUNC) {
+				pr_warn("prog '%s': relo #%d: bad insn\n",
+					prog->name, i);
+				return -EINVAL;
+			}
+			/* handled already */
 			break;
 		case RELO_CALL:
-			/* will be handled as a follow up pass */
+			/* handled already */
 			break;
 		default:
 			pr_warn("prog '%s': relo #%d: bad relo type %d\n",
@@ -6573,6 +6577,30 @@ static struct reloc_desc *find_prog_insn_relo(const struct bpf_program *prog, si
 		       sizeof(*prog->reloc_desc), cmp_relo_by_insn_idx);
 }
 
+static int append_subprog_relos(struct bpf_program *main_prog, struct bpf_program *subprog)
+{
+	int new_cnt = main_prog->nr_reloc + subprog->nr_reloc;
+	struct reloc_desc *relos;
+	int i;
+
+	if (main_prog == subprog)
+		return 0;
+	relos = libbpf_reallocarray(main_prog->reloc_desc, new_cnt, sizeof(*relos));
+	if (!relos)
+		return -ENOMEM;
+	memcpy(relos + main_prog->nr_reloc, subprog->reloc_desc,
+	       sizeof(*relos) * subprog->nr_reloc);
+
+	for (i = main_prog->nr_reloc; i < new_cnt; i++)
+		relos[i].insn_idx += subprog->sub_insn_off;
+	/* After insn_idx adjustment the 'relos' array is still sorted
+	 * by insn_idx and doesn't break bsearch.
+	 */
+	main_prog->reloc_desc = relos;
+	main_prog->nr_reloc = new_cnt;
+	return 0;
+}
+
 static int
 bpf_object__reloc_code(struct bpf_object *obj, struct bpf_program *main_prog,
 		       struct bpf_program *prog)
@@ -6593,6 +6621,11 @@ bpf_object__reloc_code(struct bpf_object *obj, struct bpf_program *main_prog,
 			continue;
 
 		relo = find_prog_insn_relo(prog, insn_idx);
+		if (relo && relo->type == RELO_EXTERN_FUNC)
+			/* kfunc relocations will be handled later
+			 * in bpf_object__relocate_data()
+			 */
+			continue;
 		if (relo && relo->type != RELO_CALL && relo->type != RELO_SUBPROG_ADDR) {
 			pr_warn("prog '%s': unexpected relo for insn #%zu, type %d\n",
 				prog->name, insn_idx, relo->type);
@@ -6667,6 +6700,10 @@ bpf_object__reloc_code(struct bpf_object *obj, struct bpf_program *main_prog,
 			pr_debug("prog '%s': added %zu insns from sub-prog '%s'\n",
 				 main_prog->name, subprog->insns_cnt, subprog->name);
 
+			/* The subprog insns are now appended. Append its relos too. */
+			err = append_subprog_relos(main_prog, subprog);
+			if (err)
+				return err;
 			err = bpf_object__reloc_code(obj, main_prog, subprog);
 			if (err)
 				return err;
@@ -6800,7 +6837,7 @@ static int
 bpf_object__relocate(struct bpf_object *obj, const char *targ_btf_path)
 {
 	struct bpf_program *prog;
-	size_t i;
+	size_t i, j;
 	int err;
 
 	if (obj->btf_ext) {
@@ -6811,23 +6848,32 @@ bpf_object__relocate(struct bpf_object *obj, const char *targ_btf_path)
 			return err;
 		}
 	}
-	/* relocate data references first for all programs and sub-programs,
-	 * as they don't change relative to code locations, so subsequent
-	 * subprogram processing won't need to re-calculate any of them
+
+	/* Before relocating calls pre-process relocations and mark
+	 * few ld_imm64 instructions that points to subprogs.
+	 * Otherwise bpf_object__reloc_code() later would have to consider
+	 * all ld_imm64 insns as relocation candidates. That would
+	 * reduce relocation speed, since amount of find_prog_insn_relo()
+	 * would increase and most of them will fail to find a relo.
 	 */
 	for (i = 0; i < obj->nr_programs; i++) {
 		prog = &obj->programs[i];
-		err = bpf_object__relocate_data(obj, prog);
-		if (err) {
-			pr_warn("prog '%s': failed to relocate data references: %d\n",
-				prog->name, err);
-			return err;
+		for (j = 0; j < prog->nr_reloc; j++) {
+			struct reloc_desc *relo = &prog->reloc_desc[j];
+			struct bpf_insn *insn = &prog->insns[relo->insn_idx];
+
+			/* mark the insn, so it's recognized by insn_is_pseudo_func() */
+			if (relo->type == RELO_SUBPROG_ADDR)
+				insn[0].src_reg = BPF_PSEUDO_FUNC;
 		}
 	}
-	/* now relocate subprogram calls and append used subprograms to main
+
+	/* relocate subprogram calls and append used subprograms to main
 	 * programs; each copy of subprogram code needs to be relocated
 	 * differently for each main program, because its code location might
-	 * have changed
+	 * have changed.
+	 * Append subprog relos to main programs to allow data relos to be
+	 * processed after text is completely relocated.
 	 */
 	for (i = 0; i < obj->nr_programs; i++) {
 		prog = &obj->programs[i];
@@ -6844,6 +6890,18 @@ bpf_object__relocate(struct bpf_object *obj, const char *targ_btf_path)
 			return err;
 		}
 	}
+	/* Process data relos for main programs */
+	for (i = 0; i < obj->nr_programs; i++) {
+		prog = &obj->programs[i];
+		if (prog_is_subprog(obj, prog))
+			continue;
+		err = bpf_object__relocate_data(obj, prog);
+		if (err) {
+			pr_warn("prog '%s': failed to relocate data references: %d\n",
+				prog->name, err);
+			return err;
+		}
+	}
 	/* free up relocation descriptors */
 	for (i = 0; i < obj->nr_programs; i++) {
 		prog = &obj->programs[i];
diff --git a/tools/testing/selftests/bpf/progs/test_subprogs.c b/tools/testing/selftests/bpf/progs/test_subprogs.c
index d3c5673c0218..b7c37ca09544 100644
--- a/tools/testing/selftests/bpf/progs/test_subprogs.c
+++ b/tools/testing/selftests/bpf/progs/test_subprogs.c
@@ -4,8 +4,18 @@
 
 const char LICENSE[] SEC("license") = "GPL";
 
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, __u32);
+	__type(value, __u64);
+} array SEC(".maps");
+
 __noinline int sub1(int x)
 {
+	int key = 0;
+
+	bpf_map_lookup_elem(&array, &key);
 	return x + 1;
 }
 
@@ -23,6 +33,9 @@ static __noinline int sub3(int z)
 
 static __noinline int sub4(int w)
 {
+	int key = 0;
+
+	bpf_map_lookup_elem(&array, &key);
 	return w + sub3(5) + sub1(6);
 }
 
-- 
2.30.2

