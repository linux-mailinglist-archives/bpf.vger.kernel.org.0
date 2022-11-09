Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92A48622DCE
	for <lists+bpf@lfdr.de>; Wed,  9 Nov 2022 15:27:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231183AbiKIO1R (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Nov 2022 09:27:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231586AbiKIO05 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Nov 2022 09:26:57 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF95A13CEE
        for <bpf@vger.kernel.org>; Wed,  9 Nov 2022 06:26:37 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id l11so27495279edb.4
        for <bpf@vger.kernel.org>; Wed, 09 Nov 2022 06:26:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UZYb1ywv/V4N6EpGagcMJPAzk+hiPGMsBg+zbvxIb/Y=;
        b=cJuTaNkoyo8+ch+uFQ0urAJmwxjICdhtuKOHAngnjya6xovX0CtcI87TTxuJpzvBcs
         p/O5yoPe8PdP0yvzj+9/3+xunuAOc/EsFW5snH3xZZpuN/WGExurPIMDwLzcsgyahq/y
         OT1OsSNuTZhwpOxc+5i28wpvHWm+IOcLRuHUsLEZ95su+7PlblqKukhqFaYg/iLywKs/
         yTk2b+J/CVA+ToX429gk+Qm1ha7yLiHTR0ew77ONNctvTtRmRuiwGSK+zyZ2kZLRMvPX
         r2UTvcgMm6l3MThvS4pYyb4Be06tqMsitwePTARvnh303yDNUuHC3+Lne2zgV+iC6/v5
         Fgow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UZYb1ywv/V4N6EpGagcMJPAzk+hiPGMsBg+zbvxIb/Y=;
        b=qnC3Dl6z9mvdg5Bsc4CqjWa0O9zUhYrADvUdB5uc9jHOZ7DksDH3tFhNoo2ONEJUmq
         1QdTrE5KcMjU8SHVKtpI0QEAVT+jnmEXcqt2dKibLOn6X3W2bn8rM48XiO7BR4a+8Jzg
         FRfp7bR0xgiTU/mbjbSweQQUjlS1Z270uZPaUTFUkOH4Krq44l4zPVLxev3s3YrStRxa
         j8ERuYlMuDKV/vi0V9tkRMhJnJmSRyJlYWVetAtrUtOf0DJsCUuQ38CzPSo58oduBGCP
         aQKXjJm5jEcCPUgR/e1fnPg3Ud3P0TtiBYfrfhiwhaKY1b5sFvj6pE+jqOOVGhD/zxgD
         5Vqg==
X-Gm-Message-State: ACrzQf1LQDGaakcITjGvP5qwkQer9Hr/Fxmz02M67bWqZQ9hm8YzcA/T
        1Z6L7lP2REqnkkV9xR47/yKs4gba3jFCYqto
X-Google-Smtp-Source: AMsMyM5hlA3IF3VMLPfo/HOHa6l8vSLZU5Xt/Fj1WwAPvVjC6LJyfiweZoaOgIkWjGT/0VxQjUFLTA==
X-Received: by 2002:a05:6402:3213:b0:461:dec8:336d with SMTP id g19-20020a056402321300b00461dec8336dmr62488885eda.221.1668003996196;
        Wed, 09 Nov 2022 06:26:36 -0800 (PST)
Received: from pluto.. (boundsly.muster.volia.net. [93.72.16.93])
        by smtp.gmail.com with ESMTPSA id w21-20020a170906131500b007addcbd402esm5921013ejb.215.2022.11.09.06.26.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 06:26:34 -0800 (PST)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, kernel-team@fb.com,
        yhs@fb.com, alan.maguire@oracle.com, acme@kernel.org,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v4 2/3] libbpf: Resolve unambigous forward declarations
Date:   Wed,  9 Nov 2022 16:26:10 +0200
Message-Id: <20221109142611.879983-3-eddyz87@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221109142611.879983-1-eddyz87@gmail.com>
References: <20221109142611.879983-1-eddyz87@gmail.com>
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
Acked-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/btf.c | 143 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 139 insertions(+), 4 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 442d4d0f98b8..3bd812bf88ff 100644
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
@@ -4501,6 +4508,134 @@ static int btf_dedup_ref_types(struct btf_dedup *d)
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
+	struct hashmap *names_map;
+
+	names_map = hashmap__new(btf_dedup_identity_hash_fn, btf_dedup_equal_fn, NULL);
+	if (IS_ERR(names_map))
+		return PTR_ERR(names_map);
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

