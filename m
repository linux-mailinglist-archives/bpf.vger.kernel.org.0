Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFD6C617515
	for <lists+bpf@lfdr.de>; Thu,  3 Nov 2022 04:35:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbiKCDfn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Nov 2022 23:35:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbiKCDfl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Nov 2022 23:35:41 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3320714D1C
        for <bpf@vger.kernel.org>; Wed,  2 Nov 2022 20:35:40 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id y14so1979166ejd.9
        for <bpf@vger.kernel.org>; Wed, 02 Nov 2022 20:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RMZ18tbEHMj2C0FeUygHNnYmY1Tbza57UM/QmoBH6nE=;
        b=f+GrVMVaN2BOz8f78Ain/Ck9NBrnNB+fUGxVlvpWA6YYL4cEgym0eQ9EJ4R0IQ762g
         fwdQXQQOYmGcTyfkcEFipfeSLpLBXc0/hl8esYmB8ju8GEeauGdV8a861w6pb4Ipf1o7
         d7lIC4eE3LO7Mj2rIWImSENBy4q7Oar9uEmggi/HPMPFv9cRBjkIg0twVOtGAkB9WQpd
         JtsXnK/wKmRlhl17ZXMp3uOC/lMLRjpj0uZyLfB2XKXGEEOMPgwiMNytMy0s8SGM1Pnb
         AB9+dxm0ua/f6vPoJhPx4PL5BJAFfK8Xx76HNKe9tC6Dn/o+YY3FggJ5RFgbOii4lNxU
         OnkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RMZ18tbEHMj2C0FeUygHNnYmY1Tbza57UM/QmoBH6nE=;
        b=A0NIgKEr721awtbMMZHNnPpbAirHe/77PJJ2zsP2k4r+ndwLgPhbA30mf619MMcxz8
         Lky+xLf0kI7dtaz8mpW6javIbc0zIhphTASQTQRs/MGWzLR8MvHulVqLSUqOORn6Aq0u
         RkYhoW7CQsnU17uR79fXkFRR+RwT1tBIDh6DoxoGqfr8RGqt+vLV193JJ8MrfZVUkpn0
         aPBxQtJefsmT43kqs13csZebMd/CODYPMUV6CdOBK9KhhjoWQltuKVcCPVpLx7265xs9
         uLEoUWZr507HoX+vpPKYB26T2lk764IZFGtD/Yg7eUXa98gtqZI+5OY9Sp2MMNMCtqVh
         1NQQ==
X-Gm-Message-State: ACrzQf1oEMur85NE4clY26g0lpQNTltUeoboopbPCqC0DTwmQPS4Iz0f
        5Rez0Z4vW7f5hfcJdwd3c/M/5iOpoLvFSa9q
X-Google-Smtp-Source: AMsMyM5VjN/QVkOdHYt68jBZJUEYUcTbKQUDW9sLSBArvkUQ2LyQBKmtBsVGx5vjdosbNZGQmYJ9/g==
X-Received: by 2002:a17:906:7212:b0:7ad:bd4b:c41f with SMTP id m18-20020a170906721200b007adbd4bc41fmr23383183ejk.659.1667446538519;
        Wed, 02 Nov 2022 20:35:38 -0700 (PDT)
Received: from pluto.. (boundsly.muster.volia.net. [93.72.16.93])
        by smtp.gmail.com with ESMTPSA id g2-20020a17090604c200b007815ca7ae57sm6106441eja.212.2022.11.02.20.35.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 20:35:38 -0700 (PDT)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, kernel-team@fb.com,
        yhs@fb.com, alan.maguire@oracle.com,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v2 3/4] libbpf: Resolve unambigous forward declarations
Date:   Thu,  3 Nov 2022 05:34:29 +0200
Message-Id: <20221103033430.2611623-4-eddyz87@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221103033430.2611623-1-eddyz87@gmail.com>
References: <20221103033430.2611623-1-eddyz87@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Resolve forward declarations that don't take part in type graphs
comparisons if declaration name is unambiguous. Example:

CU #1:

struct foo;              // standalone forward declaration
struct foo *some_global;

CU #2:

struct foo { int x; };
struct foo *another_global;

The `struct foo` from CU #1 is not a part of any definition that is
compared against another definition while `btf_dedup_struct_types`
processes structural types. The the BTF after `btf_dedup_struct_types`
the BTF looks as follows:

[1] STRUCT 'foo' size=4 vlen=1 ...
[2] INT 'int' size=4 ...
[3] PTR '(anon)' type_id=1
[4] FWD 'foo' fwd_kind=struct
[5] PTR '(anon)' type_id=4

This commit adds a new pass `btf_dedup_resolve_fwds`, that maps such
forward declarations to structs or unions with identical name in case
if the name is not ambiguous.

The pass is positioned before `btf_dedup_ref_types` so that types
[3] and [5] could be merged as a same type after [1] and [4] are merged.
The final result for the example above looks as follows:

[1] STRUCT 'foo' size=4 vlen=1
	'x' type_id=2 bits_offset=0
[2] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
[3] PTR '(anon)' type_id=1

For defconfig kernel with BTF enabled this removes 63 forward
declarations. Examples of removed declarations: `pt_regs`, `in6_addr`.
The running time of `btf__dedup` function is increased by about 3%.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
---
 tools/lib/bpf/btf.c | 143 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 139 insertions(+), 4 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 04db202aac3d..a847d78efeab 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -2881,6 +2881,7 @@ static int btf_dedup_strings(struct btf_dedup *d);
 static int btf_dedup_prim_types(struct btf_dedup *d);
 static int btf_dedup_struct_types(struct btf_dedup *d);
 static int btf_dedup_ref_types(struct btf_dedup *d);
+static int btf_dedup_resolve_fwds(struct btf_dedup *d);
 static int btf_dedup_compact_types(struct btf_dedup *d);
 static int btf_dedup_remap_types(struct btf_dedup *d);
 
@@ -2988,15 +2989,16 @@ static int btf_dedup_remap_types(struct btf_dedup *d);
  * Algorithm summary
  * =================
  *
- * Algorithm completes its work in 6 separate passes:
+ * Algorithm completes its work in 7 separate passes:
  *
  * 1. Strings deduplication.
  * 2. Primitive types deduplication (int, enum, fwd).
  * 3. Struct/union types deduplication.
- * 4. Reference types deduplication (pointers, typedefs, arrays, funcs, func
+ * 4. Resolve unambiguous forward declarations.
+ * 5. Reference types deduplication (pointers, typedefs, arrays, funcs, func
  *    protos, and const/volatile/restrict modifiers).
- * 5. Types compaction.
- * 6. Types remapping.
+ * 6. Types compaction.
+ * 7. Types remapping.
  *
  * Algorithm determines canonical type descriptor, which is a single
  * representative type for each truly unique type. This canonical type is the
@@ -3060,6 +3062,11 @@ int btf__dedup(struct btf *btf, const struct btf_dedup_opts *opts)
 		pr_debug("btf_dedup_struct_types failed:%d\n", err);
 		goto done;
 	}
+	err = btf_dedup_resolve_fwds(d);
+	if (err < 0) {
+		pr_debug("btf_dedup_resolve_fwds failed:%d\n", err);
+		goto done;
+	}
 	err = btf_dedup_ref_types(d);
 	if (err < 0) {
 		pr_debug("btf_dedup_ref_types failed:%d\n", err);
@@ -4526,6 +4533,134 @@ static int btf_dedup_ref_types(struct btf_dedup *d)
 	return 0;
 }
 
+/*
+ * Collect a map from type names to type ids for all canonical structs
+ * and unions. If the same name is shared by several canonical types
+ * use a special value 0 to indicate this fact.
+ */
+static int btf_dedup_fill_unique_names_map(struct btf_dedup *d, struct hashmap *names_map)
+{
+	__u32 nr_types = btf__type_cnt(d->btf);
+	struct btf_type *t;
+	__u32 type_id;
+	__u16 kind;
+	int err;
+
+	/*
+	 * Iterate over base and split module ids in order to get all
+	 * available structs in the map.
+	 */
+	for (type_id = 1; type_id < nr_types; ++type_id) {
+		t = btf_type_by_id(d->btf, type_id);
+		kind = btf_kind(t);
+
+		if (kind != BTF_KIND_STRUCT && kind != BTF_KIND_UNION)
+			continue;
+
+		/* Skip non-canonical types */
+		if (type_id != d->map[type_id])
+			continue;
+
+		err = hashmap__add(names_map, t->name_off, type_id);
+		if (err == -EEXIST)
+			err = hashmap__set(names_map, t->name_off, 0, NULL, NULL);
+
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
+static int btf_dedup_resolve_fwd(struct btf_dedup *d, struct hashmap *names_map, __u32 type_id)
+{
+	struct btf_type *t = btf_type_by_id(d->btf, type_id);
+	enum btf_fwd_kind fwd_kind = btf_kflag(t);
+	__u16 cand_kind, kind = btf_kind(t);
+	struct btf_type *cand_t;
+	uintptr_t cand_id;
+
+	if (kind != BTF_KIND_FWD)
+		return 0;
+
+	/* Skip if this FWD already has a mapping */
+	if (type_id != d->map[type_id])
+		return 0;
+
+	if (!hashmap__find(names_map, t->name_off, &cand_id))
+		return 0;
+
+	/* Zero is a special value indicating that name is not unique */
+	if (!cand_id)
+		return 0;
+
+	cand_t = btf_type_by_id(d->btf, cand_id);
+	cand_kind = btf_kind(cand_t);
+	if ((cand_kind == BTF_KIND_STRUCT && fwd_kind != BTF_FWD_STRUCT) ||
+	    (cand_kind == BTF_KIND_UNION && fwd_kind != BTF_FWD_UNION))
+		return 0;
+
+	d->map[type_id] = cand_id;
+
+	return 0;
+}
+
+/*
+ * Resolve unambiguous forward declarations.
+ *
+ * The lion's share of all FWD declarations is resolved during
+ * `btf_dedup_struct_types` phase when different type graphs are
+ * compared against each other. However, if in some compilation unit a
+ * FWD declaration is not a part of a type graph compared against
+ * another type graph that declaration's canonical type would not be
+ * changed. Example:
+ *
+ * CU #1:
+ *
+ * struct foo;
+ * struct foo *some_global;
+ *
+ * CU #2:
+ *
+ * struct foo { int u; };
+ * struct foo *another_global;
+ *
+ * After `btf_dedup_struct_types` the BTF looks as follows:
+ *
+ * [1] STRUCT 'foo' size=4 vlen=1 ...
+ * [2] INT 'int' size=4 ...
+ * [3] PTR '(anon)' type_id=1
+ * [4] FWD 'foo' fwd_kind=struct
+ * [5] PTR '(anon)' type_id=4
+ *
+ * This pass assumes that such FWD declarations should be mapped to
+ * structs or unions with identical name in case if the name is not
+ * ambiguous.
+ */
+static int btf_dedup_resolve_fwds(struct btf_dedup *d)
+{
+	int i, err;
+	struct hashmap *names_map =
+		hashmap__new(btf_dedup_identity_hash_fn, btf_dedup_equal_fn, NULL);
+
+	if (!names_map)
+		return -ENOMEM;
+
+	err = btf_dedup_fill_unique_names_map(d, names_map);
+	if (err < 0)
+		goto exit;
+
+	for (i = 0; i < d->btf->nr_types; i++) {
+		err = btf_dedup_resolve_fwd(d, names_map, d->btf->start_id + i);
+		if (err < 0)
+			break;
+	}
+
+exit:
+	hashmap__free(names_map);
+	return err;
+}
+
 /*
  * Compact types.
  *
-- 
2.34.1

