Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCB524A03B6
	for <lists+bpf@lfdr.de>; Fri, 28 Jan 2022 23:33:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351705AbiA1Wda (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 28 Jan 2022 17:33:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350593AbiA1Wda (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 28 Jan 2022 17:33:30 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 126CBC06173B
        for <bpf@vger.kernel.org>; Fri, 28 Jan 2022 14:33:30 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id j24so4616491qkk.10
        for <bpf@vger.kernel.org>; Fri, 28 Jan 2022 14:33:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kinvolk.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3/1N2urHgMS93bGvxcISeS3ZlovyOY2O7muygheVZUU=;
        b=UjCKy439eba6XP9yUcoJxPIWOB2GlhRc3lbRYhK16inxB5Q+qNbT+fA1UqQf9WRN38
         Y3dxUZ3w2w2C6ROutSKEdIuzZtUeQzp6Yg4M6F6p0WqFggtM5TLMNFioW3ySTYrFf4ls
         awuHeZI5p4WnNRR6+tYeS0exp3S6ijUGrdYgo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3/1N2urHgMS93bGvxcISeS3ZlovyOY2O7muygheVZUU=;
        b=xWckgij7nqEL1AGmoEQ7VXki/A4mj/V3P0Z56dEFS7bPdZgMjV2yjB9uTJ+F5WTA+6
         X6eoy9ZTOaB8gdCRl7wTTbSqmMcQJyDHCr84F0CSa5hXvparDdcdbhBh1FBQZC7/xmHt
         C6rAtO2YW9Ey+N7GtDjQCihcnsOJtuK9Ydx3uFpNjFPU5aKwGBJ/s4fsRf0aJuvrK/An
         aAN2RiqfCL+Ka+kiXdr4O3B3H7keAmuw2y+6a8/3bIuhB9azhSVs9iLgnpENmJACr/uA
         2dDs5yBqWSElvKkpfjpds3rOY0ogcifXpEy6RBv0orwg0YEizBOavNddSF9HHfqGf7FL
         c1dw==
X-Gm-Message-State: AOAM533aLbQ/gw7uz8IiZUBov3WrmuIee1C+Ms9RknFBtgycVjsdFlAz
        gn7jIdeJLfP5E5dJ5ZeWKsLylA==
X-Google-Smtp-Source: ABdhPJxbPc5eKvlxM9KjGqQGDVmII+ZtgUgoygG+hP0/D9MY5XoAZR+QMCnrEqedPJ013r7Rj5S/RQ==
X-Received: by 2002:a05:620a:28c5:: with SMTP id l5mr1021378qkp.581.1643409209189;
        Fri, 28 Jan 2022 14:33:29 -0800 (PST)
Received: from localhost.localdomain ([181.136.110.101])
        by smtp.gmail.com with ESMTPSA id i18sm3723972qka.80.2022.01.28.14.33.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jan 2022 14:33:28 -0800 (PST)
From:   =?UTF-8?q?Mauricio=20V=C3=A1squez?= <mauricio@kinvolk.io>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Quentin Monnet <quentin@isovalent.com>,
        Rafael David Tinoco <rafaeldtinoco@gmail.com>,
        Lorenzo Fontana <lorenzo.fontana@elastic.co>,
        Leonardo Di Donato <leonardo.didonato@elastic.co>
Subject: [PATCH bpf-next v5 1/9] libbpf: Implement changes needed for BTFGen in bpftool
Date:   Fri, 28 Jan 2022 17:33:04 -0500
Message-Id: <20220128223312.1253169-2-mauricio@kinvolk.io>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220128223312.1253169-1-mauricio@kinvolk.io>
References: <20220128223312.1253169-1-mauricio@kinvolk.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This commit extends libbpf with the features that are needed to
implement BTFGen:

- Implement bpf_core_create_cand_cache() and bpf_core_free_cand_cache()
to handle candidates cache.
- Expose bpf_core_add_cands() and bpf_core_free_cands to handle
candidates list.
- Expose bpf_core_calc_relo_insn() to bpftool.

Signed-off-by: Mauricio Vásquez <mauricio@kinvolk.io>
Signed-off-by: Rafael David Tinoco <rafael.tinoco@aquasec.com>
Signed-off-by: Lorenzo Fontana <lorenzo.fontana@elastic.co>
Signed-off-by: Leonardo Di Donato <leonardo.didonato@elastic.co>
---
 tools/lib/bpf/libbpf.c          | 44 ++++++++++++++++++++++-----------
 tools/lib/bpf/libbpf_internal.h | 12 +++++++++
 2 files changed, 41 insertions(+), 15 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 12771f71a6e7..61384d219e28 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -5195,18 +5195,18 @@ size_t bpf_core_essential_name_len(const char *name)
 	return n;
 }
 
-static void bpf_core_free_cands(struct bpf_core_cand_list *cands)
+void bpf_core_free_cands(struct bpf_core_cand_list *cands)
 {
 	free(cands->cands);
 	free(cands);
 }
 
-static int bpf_core_add_cands(struct bpf_core_cand *local_cand,
-			      size_t local_essent_len,
-			      const struct btf *targ_btf,
-			      const char *targ_btf_name,
-			      int targ_start_id,
-			      struct bpf_core_cand_list *cands)
+int bpf_core_add_cands(struct bpf_core_cand *local_cand,
+		       size_t local_essent_len,
+		       const struct btf *targ_btf,
+		       const char *targ_btf_name,
+		       int targ_start_id,
+		       struct bpf_core_cand_list *cands)
 {
 	struct bpf_core_cand *new_cands, *cand;
 	const struct btf_type *t, *local_t;
@@ -5577,6 +5577,25 @@ static int bpf_core_resolve_relo(struct bpf_program *prog,
 				       targ_res);
 }
 
+struct hashmap *bpf_core_create_cand_cache(void)
+{
+	return hashmap__new(bpf_core_hash_fn, bpf_core_equal_fn, NULL);
+}
+
+void bpf_core_free_cand_cache(struct hashmap *cand_cache)
+{
+	struct hashmap_entry *entry;
+	int i;
+
+	if (IS_ERR_OR_NULL(cand_cache))
+		return;
+
+	hashmap__for_each_entry(cand_cache, entry, i) {
+		bpf_core_free_cands(entry->value);
+	}
+	hashmap__free(cand_cache);
+}
+
 static int
 bpf_object__relocate_core(struct bpf_object *obj, const char *targ_btf_path)
 {
@@ -5584,7 +5603,6 @@ bpf_object__relocate_core(struct bpf_object *obj, const char *targ_btf_path)
 	struct bpf_core_relo_res targ_res;
 	const struct bpf_core_relo *rec;
 	const struct btf_ext_info *seg;
-	struct hashmap_entry *entry;
 	struct hashmap *cand_cache = NULL;
 	struct bpf_program *prog;
 	struct bpf_insn *insn;
@@ -5603,7 +5621,7 @@ bpf_object__relocate_core(struct bpf_object *obj, const char *targ_btf_path)
 		}
 	}
 
-	cand_cache = hashmap__new(bpf_core_hash_fn, bpf_core_equal_fn, NULL);
+	cand_cache = bpf_core_create_cand_cache();
 	if (IS_ERR(cand_cache)) {
 		err = PTR_ERR(cand_cache);
 		goto out;
@@ -5694,12 +5712,8 @@ bpf_object__relocate_core(struct bpf_object *obj, const char *targ_btf_path)
 	btf__free(obj->btf_vmlinux_override);
 	obj->btf_vmlinux_override = NULL;
 
-	if (!IS_ERR_OR_NULL(cand_cache)) {
-		hashmap__for_each_entry(cand_cache, entry, i) {
-			bpf_core_free_cands(entry->value);
-		}
-		hashmap__free(cand_cache);
-	}
+	bpf_core_free_cand_cache(cand_cache);
+
 	return err;
 }
 
diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
index bc86b82e90d1..686a5654262b 100644
--- a/tools/lib/bpf/libbpf_internal.h
+++ b/tools/lib/bpf/libbpf_internal.h
@@ -529,4 +529,16 @@ static inline int ensure_good_fd(int fd)
 	return fd;
 }
 
+struct hashmap;
+
+struct hashmap *bpf_core_create_cand_cache(void);
+void bpf_core_free_cand_cache(struct hashmap *cand_cache);
+int bpf_core_add_cands(struct bpf_core_cand *local_cand,
+		       size_t local_essent_len,
+		       const struct btf *targ_btf,
+		       const char *targ_btf_name,
+		       int targ_start_id,
+		       struct bpf_core_cand_list *cands);
+void bpf_core_free_cands(struct bpf_core_cand_list *cands);
+
 #endif /* __LIBBPF_LIBBPF_INTERNAL_H */
-- 
2.25.1

