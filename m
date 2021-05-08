Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F3E1376F3D
	for <lists+bpf@lfdr.de>; Sat,  8 May 2021 05:49:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231163AbhEHDuF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 7 May 2021 23:50:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230249AbhEHDuF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 7 May 2021 23:50:05 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9494CC061761
        for <bpf@vger.kernel.org>; Fri,  7 May 2021 20:49:03 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id m12so8764530pgr.9
        for <bpf@vger.kernel.org>; Fri, 07 May 2021 20:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=apTCvuF1PDMqXFjbxcj20yhNLZaDmIF6JzD+/Z/MuZ4=;
        b=SolNCXKT/LnoaoeP7WXA+VTtkpcrtVYHo7sIROSnTykkpTWv1NYz84FOj7ATcxX8mg
         XEIFUYx15x5QhRj9vFvwl9NO0mKFw7MU/M0UBmH1P3fllTzQOQxdDxgD6KNF9W3CMjri
         US/V+FcyV4mTsFo58JBAmjPOWmU5Wsztg2a+Jg0cnz9FPdlBtGAr0Ov/BGYosBzhS3A1
         QXRjWMppOSBmy2tN0hLlC3heBpir9Ly7xMogmeY7HsSGDWHxfd6ejubJbpUuEN9VHvYj
         DN1qrDh/rjRLkRxHmMslNbQUBY3z9kiJ/2TonXHZDHV07c/TKOyG9/UUzt5v4YzYOxmK
         xTSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=apTCvuF1PDMqXFjbxcj20yhNLZaDmIF6JzD+/Z/MuZ4=;
        b=Rlh6dNccxJKowjFuAdRD4M5iC44KRbxT6WJpyv4f5rf+o4cflBY8LI6P45+FmeD1BU
         cj+U2b4VK48ihaRV7989rte5eZ14ZydCp2XMyTdOQqda4R/kFKVYjwo7zPU3QmCRgT+L
         fVGGs5e2CMfkAZBNO7cNiApwDQNZRHneE1MnHj3ZkrxVc/e8LRJXzMddi09jslsrBTda
         j/27+nimjGHg+/9TQyMeUORyXkfNK7Ud+MLNM9j4FJrTuJ2yNnYbKyFOww4TKEP6uWZ9
         jbWX6xe9l9O1kRIKMHDMaUTUUXdk3sA/DEBI2+9Qbfwz74Cqlb6NcaW5UI2Rkdkca3ff
         eD1Q==
X-Gm-Message-State: AOAM532B9YJew5g6Xax90JARFVVX414qeGueX0mGftIvJ3bhNtmxgEGU
        QINHvg+zOjRmjFjzPsXGkwg=
X-Google-Smtp-Source: ABdhPJwNMVZxSfnfMdDB1c/ooUNiWRjOIQzB82UA4wNmc/Pd3kaMdUvAATJTy+qHO7oVJAbM1Mmq6Q==
X-Received: by 2002:a63:e911:: with SMTP id i17mr13749614pgh.148.1620445743172;
        Fri, 07 May 2021 20:49:03 -0700 (PDT)
Received: from ast-mbp.thefacebook.com ([163.114.132.1])
        by smtp.gmail.com with ESMTPSA id u12sm5784606pfh.122.2021.05.07.20.49.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 May 2021 20:49:02 -0700 (PDT)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, john.fastabend@gmail.com,
        bpf@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v4 bpf-next 12/22] libbpf: Change the order of data and text relocations.
Date:   Fri,  7 May 2021 20:48:27 -0700
Message-Id: <20210508034837.64585-13-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20210508034837.64585-1-alexei.starovoitov@gmail.com>
References: <20210508034837.64585-1-alexei.starovoitov@gmail.com>
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
---
 tools/lib/bpf/libbpf.c                        | 86 ++++++++++++++++---
 .../selftests/bpf/progs/test_subprogs.c       | 13 +++
 2 files changed, 85 insertions(+), 14 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 0b9270403a77..f04bac9f398c 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -6443,11 +6443,15 @@ bpf_object__relocate_data(struct bpf_object *obj, struct bpf_program *prog)
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
@@ -6616,6 +6620,30 @@ static struct reloc_desc *find_prog_insn_relo(const struct bpf_program *prog, si
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
@@ -6636,6 +6664,11 @@ bpf_object__reloc_code(struct bpf_object *obj, struct bpf_program *main_prog,
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
@@ -6710,6 +6743,10 @@ bpf_object__reloc_code(struct bpf_object *obj, struct bpf_program *main_prog,
 			pr_debug("prog '%s': added %zu insns from sub-prog '%s'\n",
 				 main_prog->name, subprog->insns_cnt, subprog->name);
 
+			/* The subprog insns are now appended. Append its relos too. */
+			err = append_subprog_relos(main_prog, subprog);
+			if (err)
+				return err;
 			err = bpf_object__reloc_code(obj, main_prog, subprog);
 			if (err)
 				return err;
@@ -6843,7 +6880,7 @@ static int
 bpf_object__relocate(struct bpf_object *obj, const char *targ_btf_path)
 {
 	struct bpf_program *prog;
-	size_t i;
+	size_t i, j;
 	int err;
 
 	if (obj->btf_ext) {
@@ -6854,23 +6891,32 @@ bpf_object__relocate(struct bpf_object *obj, const char *targ_btf_path)
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
@@ -6887,6 +6933,18 @@ bpf_object__relocate(struct bpf_object *obj, const char *targ_btf_path)
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

