Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14479467D49
	for <lists+bpf@lfdr.de>; Fri,  3 Dec 2021 19:28:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232253AbhLCScD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 3 Dec 2021 13:32:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231857AbhLCScD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 3 Dec 2021 13:32:03 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6422C061751
        for <bpf@vger.kernel.org>; Fri,  3 Dec 2021 10:28:38 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id l190so3875931pge.7
        for <bpf@vger.kernel.org>; Fri, 03 Dec 2021 10:28:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N6Ov7P0ml1cbN3eEyiGlmYdJHLUr3ZVIW11KNWfuOAM=;
        b=q3z8/2QFUz7XKjldEmMwF9pNu2Ppl4C3x8UN0RzVdAbXycdUlYdmWxNdq4s4Y1Z2uR
         4CX1v5AjVFumoFYP2V+m5f2Ie/4DdnV4DX9RfFsCeu2AQg7ZKE/zyDdne9CF6RFiiEKj
         UASplUX+pZ3xe+SBE3HLv6tZlJRRMRcMW2j9XBPYB6ehdk033Lz5k88fCX9txpIxuljJ
         l6hdYVhJnHHJjSo+dR37aCUunKilklQ87Rrpuu2bqhBEJfoUdRy+TDx/iqisUbyWxB6h
         /eyI7j8Wsu65UIdbXsR9zPnPkZNQG4bMkypSeYp3Wvsr+enYjR7cFZsY7BYC8nkSS4P5
         TV/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N6Ov7P0ml1cbN3eEyiGlmYdJHLUr3ZVIW11KNWfuOAM=;
        b=53Wf9f4v04pDdC7ebW3l8mDH49HbL7hbgfK6vpvPk+nveC/JBYreeFcu/vbP1eD0v+
         zG9QaQGyYAp83sR4Tr0J5nPh07MPwBItEoVRxqJfUFEN+9y5hxlWQt8p994ocpgPdsHU
         taDm+SuVTNyqe8o8CzkkmmTyu60x074YcSQzLASpLvB8k+viP2Chou4i04S8FDRZKrFc
         BpCd1yCLe4mKpBhpZdsue4wzc8wdQWN8y4i2s3UJmNnRN1/IpxVye6laKF/X7c7wCc2n
         JSD5J2wxiJM6tTYEJhNKi+Q5LqBGbN3N5elixxOnwzVOOF7scx3AouRn1c+06pFtY7ZE
         RU1w==
X-Gm-Message-State: AOAM530nW+Qqv43ag696UtUxelkJboOS2bny1jOwAlkdTH3paDLQxcQX
        1sudfCDeePgUEbBXfrZstok=
X-Google-Smtp-Source: ABdhPJwkcl/+CVJjoZggoDaFOzSlqnLkefa67TBkrtaoPOuevm4XMn0GuGFVjfXXBWTdjFG0ScvLjQ==
X-Received: by 2002:a63:7907:: with SMTP id u7mr2473977pgc.465.1638556118310;
        Fri, 03 Dec 2021 10:28:38 -0800 (PST)
Received: from ast-mbp.thefacebook.com ([2620:10d:c090:400::5:cf00])
        by smtp.gmail.com with ESMTPSA id lb4sm6592481pjb.18.2021.12.03.10.28.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Dec 2021 10:28:38 -0800 (PST)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, bpf@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH bpf-next] libbpf: Reduce bpf_core_apply_relo_insn() stack usage.
Date:   Fri,  3 Dec 2021 10:28:36 -0800
Message-Id: <20211203182836.16646-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Alexei Starovoitov <ast@kernel.org>

Reduce bpf_core_apply_relo_insn() stack usage and bump
BPF_CORE_SPEC_MAX_LEN limit back to 64.

Fixes: 29db4bea1d10 ("bpf: Prepare relo_core.c for kernel duty.")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/btf.c          | 11 ++++++-
 tools/lib/bpf/libbpf.c    |  4 ++-
 tools/lib/bpf/relo_core.c | 60 +++++++++++----------------------------
 tools/lib/bpf/relo_core.h | 30 +++++++++++++++++++-
 4 files changed, 59 insertions(+), 46 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index ed4258cb0832..2a902a946f70 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6742,8 +6742,16 @@ int bpf_core_apply(struct bpf_core_ctx *ctx, const struct bpf_core_relo *relo,
 {
 	bool need_cands = relo->kind != BPF_CORE_TYPE_ID_LOCAL;
 	struct bpf_core_cand_list cands = {};
+	struct bpf_core_spec *specs;
 	int err;
 
+	/* ~4k of temp memory necessary to convert LLVM spec like "0:1:0:5"
+	 * into arrays of btf_ids of struct fields and array indices.
+	 */
+	specs = kcalloc(3, sizeof(*specs), GFP_KERNEL);
+	if (!specs)
+		return -ENOMEM;
+
 	if (need_cands) {
 		struct bpf_cand_cache *cc;
 		int i;
@@ -6779,8 +6787,9 @@ int bpf_core_apply(struct bpf_core_ctx *ctx, const struct bpf_core_relo *relo,
 	}
 
 	err = bpf_core_apply_relo_insn((void *)ctx->log, insn, relo->insn_off / 8,
-				       relo, relo_idx, ctx->btf, &cands);
+				       relo, relo_idx, ctx->btf, &cands, specs);
 out:
+	kfree(specs);
 	if (need_cands) {
 		kfree(cands.cands);
 		mutex_unlock(&cand_cache_mutex);
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index de260c94e418..1ad070b19bb4 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -5515,6 +5515,7 @@ static int bpf_core_apply_relo(struct bpf_program *prog,
 			       const struct btf *local_btf,
 			       struct hashmap *cand_cache)
 {
+	struct bpf_core_spec specs[3] = {};
 	const void *type_key = u32_as_hash_key(relo->type_id);
 	struct bpf_core_cand_list *cands = NULL;
 	const char *prog_name = prog->name;
@@ -5569,7 +5570,8 @@ static int bpf_core_apply_relo(struct bpf_program *prog,
 		}
 	}
 
-	return bpf_core_apply_relo_insn(prog_name, insn, insn_idx, relo, relo_idx, local_btf, cands);
+	return bpf_core_apply_relo_insn(prog_name, insn, insn_idx, relo,
+					relo_idx, local_btf, cands, specs);
 }
 
 static int
diff --git a/tools/lib/bpf/relo_core.c b/tools/lib/bpf/relo_core.c
index d194fb9306ed..d4734a7d9bdf 100644
--- a/tools/lib/bpf/relo_core.c
+++ b/tools/lib/bpf/relo_core.c
@@ -68,33 +68,6 @@ enum libbpf_print_level {
 #include "libbpf_internal.h"
 #endif
 
-#define BPF_CORE_SPEC_MAX_LEN 32
-
-/* represents BPF CO-RE field or array element accessor */
-struct bpf_core_accessor {
-	__u32 type_id;		/* struct/union type or array element type */
-	__u32 idx;		/* field index or array index */
-	const char *name;	/* field name or NULL for array accessor */
-};
-
-struct bpf_core_spec {
-	const struct btf *btf;
-	/* high-level spec: named fields and array indices only */
-	struct bpf_core_accessor spec[BPF_CORE_SPEC_MAX_LEN];
-	/* original unresolved (no skip_mods_or_typedefs) root type ID */
-	__u32 root_type_id;
-	/* CO-RE relocation kind */
-	enum bpf_core_relo_kind relo_kind;
-	/* high-level spec length */
-	int len;
-	/* raw, low-level spec: 1-to-1 with accessor spec string */
-	int raw_spec[BPF_CORE_SPEC_MAX_LEN];
-	/* raw spec length */
-	int raw_len;
-	/* field bit offset represented by spec */
-	__u32 bit_offset;
-};
-
 static bool is_flex_arr(const struct btf *btf,
 			const struct bpf_core_accessor *acc,
 			const struct btf_array *arr)
@@ -1200,9 +1173,10 @@ int bpf_core_apply_relo_insn(const char *prog_name, struct bpf_insn *insn,
 			     const struct bpf_core_relo *relo,
 			     int relo_idx,
 			     const struct btf *local_btf,
-			     struct bpf_core_cand_list *cands)
+			     struct bpf_core_cand_list *cands,
+			     struct bpf_core_spec *specs)
 {
-	struct bpf_core_spec local_spec, cand_spec, targ_spec = {};
+	struct bpf_core_spec *local_spec = &specs[0], *cand_spec = &specs[1], *targ_spec = &specs[2];
 	struct bpf_core_relo_res cand_res, targ_res;
 	const struct btf_type *local_type;
 	const char *local_name;
@@ -1221,7 +1195,7 @@ int bpf_core_apply_relo_insn(const char *prog_name, struct bpf_insn *insn,
 		return -EINVAL;
 
 	err = bpf_core_parse_spec(prog_name, local_btf, local_id, spec_str,
-				  relo->kind, &local_spec);
+				  relo->kind, local_spec);
 	if (err) {
 		pr_warn("prog '%s': relo #%d: parsing [%d] %s %s + %s failed: %d\n",
 			prog_name, relo_idx, local_id, btf_kind_str(local_type),
@@ -1232,15 +1206,15 @@ int bpf_core_apply_relo_insn(const char *prog_name, struct bpf_insn *insn,
 
 	pr_debug("prog '%s': relo #%d: kind <%s> (%d), spec is ", prog_name,
 		 relo_idx, core_relo_kind_str(relo->kind), relo->kind);
-	bpf_core_dump_spec(prog_name, LIBBPF_DEBUG, &local_spec);
+	bpf_core_dump_spec(prog_name, LIBBPF_DEBUG, local_spec);
 	libbpf_print(LIBBPF_DEBUG, "\n");
 
 	/* TYPE_ID_LOCAL relo is special and doesn't need candidate search */
 	if (relo->kind == BPF_CORE_TYPE_ID_LOCAL) {
 		targ_res.validate = true;
 		targ_res.poison = false;
-		targ_res.orig_val = local_spec.root_type_id;
-		targ_res.new_val = local_spec.root_type_id;
+		targ_res.orig_val = local_spec->root_type_id;
+		targ_res.new_val = local_spec->root_type_id;
 		goto patch_insn;
 	}
 
@@ -1253,38 +1227,38 @@ int bpf_core_apply_relo_insn(const char *prog_name, struct bpf_insn *insn,
 
 
 	for (i = 0, j = 0; i < cands->len; i++) {
-		err = bpf_core_spec_match(&local_spec, cands->cands[i].btf,
-					  cands->cands[i].id, &cand_spec);
+		err = bpf_core_spec_match(local_spec, cands->cands[i].btf,
+					  cands->cands[i].id, cand_spec);
 		if (err < 0) {
 			pr_warn("prog '%s': relo #%d: error matching candidate #%d ",
 				prog_name, relo_idx, i);
-			bpf_core_dump_spec(prog_name, LIBBPF_WARN, &cand_spec);
+			bpf_core_dump_spec(prog_name, LIBBPF_WARN, cand_spec);
 			libbpf_print(LIBBPF_WARN, ": %d\n", err);
 			return err;
 		}
 
 		pr_debug("prog '%s': relo #%d: %s candidate #%d ", prog_name,
 			 relo_idx, err == 0 ? "non-matching" : "matching", i);
-		bpf_core_dump_spec(prog_name, LIBBPF_DEBUG, &cand_spec);
+		bpf_core_dump_spec(prog_name, LIBBPF_DEBUG, cand_spec);
 		libbpf_print(LIBBPF_DEBUG, "\n");
 
 		if (err == 0)
 			continue;
 
-		err = bpf_core_calc_relo(prog_name, relo, relo_idx, &local_spec, &cand_spec, &cand_res);
+		err = bpf_core_calc_relo(prog_name, relo, relo_idx, local_spec, cand_spec, &cand_res);
 		if (err)
 			return err;
 
 		if (j == 0) {
 			targ_res = cand_res;
-			targ_spec = cand_spec;
-		} else if (cand_spec.bit_offset != targ_spec.bit_offset) {
+			*targ_spec = *cand_spec;
+		} else if (cand_spec->bit_offset != targ_spec->bit_offset) {
 			/* if there are many field relo candidates, they
 			 * should all resolve to the same bit offset
 			 */
 			pr_warn("prog '%s': relo #%d: field offset ambiguity: %u != %u\n",
-				prog_name, relo_idx, cand_spec.bit_offset,
-				targ_spec.bit_offset);
+				prog_name, relo_idx, cand_spec->bit_offset,
+				targ_spec->bit_offset);
 			return -EINVAL;
 		} else if (cand_res.poison != targ_res.poison || cand_res.new_val != targ_res.new_val) {
 			/* all candidates should result in the same relocation
@@ -1328,7 +1302,7 @@ int bpf_core_apply_relo_insn(const char *prog_name, struct bpf_insn *insn,
 			 prog_name, relo_idx);
 
 		/* calculate single target relo result explicitly */
-		err = bpf_core_calc_relo(prog_name, relo, relo_idx, &local_spec, NULL, &targ_res);
+		err = bpf_core_calc_relo(prog_name, relo, relo_idx, local_spec, NULL, &targ_res);
 		if (err)
 			return err;
 	}
diff --git a/tools/lib/bpf/relo_core.h b/tools/lib/bpf/relo_core.h
index 4f864b8e33b7..d7b28b322935 100644
--- a/tools/lib/bpf/relo_core.h
+++ b/tools/lib/bpf/relo_core.h
@@ -17,11 +17,39 @@ struct bpf_core_cand_list {
 	int len;
 };
 
+#define BPF_CORE_SPEC_MAX_LEN 64
+
+/* represents BPF CO-RE field or array element accessor */
+struct bpf_core_accessor {
+	__u32 type_id;		/* struct/union type or array element type */
+	__u32 idx;		/* field index or array index */
+	const char *name;	/* field name or NULL for array accessor */
+};
+
+struct bpf_core_spec {
+	const struct btf *btf;
+	/* high-level spec: named fields and array indices only */
+	struct bpf_core_accessor spec[BPF_CORE_SPEC_MAX_LEN];
+	/* original unresolved (no skip_mods_or_typedefs) root type ID */
+	__u32 root_type_id;
+	/* CO-RE relocation kind */
+	enum bpf_core_relo_kind relo_kind;
+	/* high-level spec length */
+	int len;
+	/* raw, low-level spec: 1-to-1 with accessor spec string */
+	int raw_spec[BPF_CORE_SPEC_MAX_LEN];
+	/* raw spec length */
+	int raw_len;
+	/* field bit offset represented by spec */
+	__u32 bit_offset;
+};
+
 int bpf_core_apply_relo_insn(const char *prog_name,
 			     struct bpf_insn *insn, int insn_idx,
 			     const struct bpf_core_relo *relo, int relo_idx,
 			     const struct btf *local_btf,
-			     struct bpf_core_cand_list *cands);
+			     struct bpf_core_cand_list *cands,
+			     struct bpf_core_spec *specs);
 int bpf_core_types_are_compat(const struct btf *local_btf, __u32 local_id,
 			      const struct btf *targ_btf, __u32 targ_id);
 
-- 
2.30.2

