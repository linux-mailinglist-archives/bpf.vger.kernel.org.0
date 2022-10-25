Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59DCE60D713
	for <lists+bpf@lfdr.de>; Wed, 26 Oct 2022 00:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231602AbiJYW2p (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 Oct 2022 18:28:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230327AbiJYW2m (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 Oct 2022 18:28:42 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 017D36CD1C
        for <bpf@vger.kernel.org>; Tue, 25 Oct 2022 15:28:41 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id sc25so16461758ejc.12
        for <bpf@vger.kernel.org>; Tue, 25 Oct 2022 15:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d4uISy0p6MDMzgs1vbawW1AEByrQTOVsdIc9n7bmQ58=;
        b=Mc/WJoaSNQGhqSkm5lsv0Af0hBWppy26GXv2IfXVk99UwXM8mIA4nBmSiiNEsclaHo
         zBXtvqwbEY8yTdZIjLxF0/lpEx+Fb831uwg7JwpE5LCrBbyghurPWx7aS8+J1qCweQ4y
         HFmO5aZIg8z4434Y3DgesK911L/xdjC1bqVtKXNJVcrCxbRKXUbOCcfyVlnFThhQqxZh
         F210kNt1STmorJAA+k+IaPl0bCBZC0iuOKBzno98yPQ+mvWx7nXHN64e20RONtgUllTr
         /vsQkhcWJBqh3c8zEa+gXsMjFfgEM3lnmnQKszNFm4cOkxmAT2B4DGymMRhsJJXrbcdh
         23WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d4uISy0p6MDMzgs1vbawW1AEByrQTOVsdIc9n7bmQ58=;
        b=5Uw1UTinAWq7dBWZK4fJ0BCPJxX9bCkWJXcfi4QvEGaSfPg+7W4PV1eP0Ta374supV
         01K0iKqWmwFWp+Hqr8CWN1EWnh/seXFXY6mzfvW24s+TruZQw0TeWFt8h4yMCkAZPYgf
         aNDvfARWy639MOuTNTs2CrCBiP7Vh9AxUaAM0JTNYcPyfGclinjqouvfYyLeYQp+32Jl
         diF0aY/YDoACzZAZ33G+tQUwl7jMNgrjSviHH1SPa/Wh+BbHOYB39KMirAujnrgAJM/d
         3jM8/f1iVpEibv2xCZiwnwKbCh5zPxcsu5boLiWj8sbPUWD8ult9jyGJqJ/UwhACRlWQ
         zBkQ==
X-Gm-Message-State: ACrzQf15e/AWrtZPjpfE6h4KogNhrn62XTBTTp3GNm53TtxVzVZBwIoI
        eJMdpYa40lje4kEmDWrbndiIoUc6EGovgGHY
X-Google-Smtp-Source: AMsMyM5s4eZXorDwLtY9lXz7QLMKI+N61ylAfCfqWAUQ92laAey/s/48wc4K+sEGrGdSr5iG/PUe4Q==
X-Received: by 2002:a17:906:9c82:b0:781:5752:4f2b with SMTP id fj2-20020a1709069c8200b0078157524f2bmr33400243ejc.561.1666736919301;
        Tue, 25 Oct 2022 15:28:39 -0700 (PDT)
Received: from pluto.. (boundsly.muster.volia.net. [93.72.16.93])
        by smtp.gmail.com with ESMTPSA id ks23-20020a170906f85700b0078d175d6dc5sm1993119ejb.201.2022.10.25.15.28.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 15:28:38 -0700 (PDT)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, kernel-team@fb.com,
        yhs@fb.com, arnaldo.melo@gmail.com,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [RFC bpf-next 01/12] libbpf: Deduplicate unambigous standalone forward declarations
Date:   Wed, 26 Oct 2022 01:27:50 +0300
Message-Id: <20221025222802.2295103-2-eddyz87@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221025222802.2295103-1-eddyz87@gmail.com>
References: <20221025222802.2295103-1-eddyz87@gmail.com>
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

Deduplicate forward declarations that don't take part in type graphs
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

This commit adds a new pass `btf_dedup_standalone_fwds`, that maps
such forward declarations to structs or unions with identical name in
case if the name is not ambiguous.

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
---
 tools/lib/bpf/btf.c | 178 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 174 insertions(+), 4 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index d88647da2c7f..c34c68d8e8a0 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -2881,6 +2881,7 @@ static int btf_dedup_strings(struct btf_dedup *d);
 static int btf_dedup_prim_types(struct btf_dedup *d);
 static int btf_dedup_struct_types(struct btf_dedup *d);
 static int btf_dedup_ref_types(struct btf_dedup *d);
+static int btf_dedup_standalone_fwds(struct btf_dedup *d);
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
+ * 4. Standalone fwd declarations deduplication.
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
+	err = btf_dedup_standalone_fwds(d);
+	if (err < 0) {
+		pr_debug("btf_dedup_standalone_fwd failed:%d\n", err);
+		goto done;
+	}
 	err = btf_dedup_ref_types(d);
 	if (err < 0) {
 		pr_debug("btf_dedup_ref_types failed:%d\n", err);
@@ -4525,6 +4532,169 @@ static int btf_dedup_ref_types(struct btf_dedup *d)
 	return 0;
 }
 
+/*
+ * `name_off_map` maps name offsets to type ids (essentially __u32 -> __u32).
+ *
+ * The __u32 key/value representations are cast to `void *` before passing
+ * to `hashmap__*` functions. These pseudo-pointers are never dereferenced.
+ *
+ */
+static struct hashmap *name_off_map__new(void)
+{
+	return hashmap__new(btf_dedup_identity_hash_fn,
+			    btf_dedup_equal_fn,
+			    NULL);
+}
+
+static int name_off_map__find(struct hashmap *map, __u32 name_off, __u32 *type_id)
+{
+	/* This has to be sizeof(void *) in order to be passed to hashmap__find */
+	void *tmp;
+	int found = hashmap__find(map, (void *)(ptrdiff_t)name_off, &tmp);
+	/*
+	 * __u64 cast is necessary to avoid pointer to integer conversion size warning.
+	 * It is fine to get rid of this warning as `void *` is used as an integer value.
+	 */
+	if (found)
+		*type_id = (__u64)tmp;
+	return found;
+}
+
+static int name_off_map__set(struct hashmap *map, __u32 name_off, __u32 type_id)
+{
+	return hashmap__set(map, (void *)(size_t)name_off, (void *)(size_t)type_id,
+			    NULL, NULL);
+}
+
+/*
+ * Collect a `name_off_map` that maps type names to type ids for all
+ * canonical structs and unions. If the same name is shared by several
+ * canonical types use a special value 0 to indicate this fact.
+ */
+static int btf_dedup_fill_unique_names_map(struct btf_dedup *d, struct hashmap *names_map)
+{
+	int i, err = 0;
+	__u32 type_id, collision_id;
+	__u16 kind;
+	struct btf_type *t;
+
+	for (i = 0; i < d->btf->nr_types; i++) {
+		type_id = d->btf->start_id + i;
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
+		err = 0;
+		if (name_off_map__find(names_map, t->name_off, &collision_id)) {
+			/* Mark non-unique names with 0 */
+			if (collision_id != 0 && collision_id != type_id)
+				err = name_off_map__set(names_map, t->name_off, 0);
+		} else {
+			err = name_off_map__set(names_map, t->name_off, type_id);
+		}
+
+		if (err < 0)
+			return err;
+	}
+
+	return 0;
+}
+
+static int btf_dedup_standalone_fwd(struct btf_dedup *d,
+				    struct hashmap *names_map,
+				    __u32 type_id)
+{
+	struct btf_type *t = btf_type_by_id(d->btf, type_id);
+	__u16 kind = btf_kind(t);
+	enum btf_fwd_kind fwd_kind = BTF_INFO_KFLAG(t->info);
+
+	struct btf_type *cand_t;
+	__u16 cand_kind;
+	__u32 cand_id = 0;
+
+	if (kind != BTF_KIND_FWD)
+		return 0;
+
+	/* Skip if this FWD already has a mapping */
+	if (type_id != d->map[type_id])
+		return 0;
+
+	name_off_map__find(names_map, t->name_off, &cand_id);
+	if (!cand_id)
+		return 0;
+
+	cand_t = btf_type_by_id(d->btf, cand_id);
+	cand_kind = btf_kind(cand_t);
+	if (!(cand_kind == BTF_KIND_STRUCT && fwd_kind == BTF_FWD_STRUCT) &&
+	    !(cand_kind == BTF_KIND_UNION && fwd_kind == BTF_FWD_UNION))
+		return 0;
+
+	d->map[type_id] = cand_id;
+
+	return 0;
+}
+
+/*
+ * Standalone fwd declarations deduplication.
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
+static int btf_dedup_standalone_fwds(struct btf_dedup *d)
+{
+	int i, err;
+	struct hashmap *names_map = name_off_map__new();
+
+	if (!names_map)
+		return -ENOMEM;
+
+	err = btf_dedup_fill_unique_names_map(d, names_map);
+	if (err < 0)
+		goto exit;
+
+	for (i = 0; i < d->btf->nr_types; i++) {
+		err = btf_dedup_standalone_fwd(d, names_map, d->btf->start_id + i);
+		if (err < 0)
+			goto exit;
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

