Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DF886BA34F
	for <lists+bpf@lfdr.de>; Wed, 15 Mar 2023 00:04:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbjCNXEm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Mar 2023 19:04:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230414AbjCNXEl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Mar 2023 19:04:41 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42CC82412B;
        Tue, 14 Mar 2023 16:04:37 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id x17so5941292lfu.5;
        Tue, 14 Mar 2023 16:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678835076;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4b5D46r0egTUZOP7UsIE7L+hvcUSuvgdra47+VJ8O/M=;
        b=CdFkAwWzsRwvMCd8WeY7vl+PvPWbIQc+CWNkn/kQ+5DUeuVCGAsld4YjenTuCRCYsq
         ilhRQjiMnsTGt8Q7ydEzxEpEuuJIh0GEgA0bZZs2V57zuEiVZ5GL24tcg2zvfFVNE36s
         weq7J25zOyWDEYs/Lj/xOddkPfoXxVAhnWYrsFCZSOZwjv5iGxgRgaPuAvvEcMQ1cR5q
         N0oFVVaa625iwNaeeuICOwKKTJpdt2uDLneESnodyX2Ac4VG2nXz7dAeMafbOCI0uggX
         QNbvJuKDRUu9ZYwcjiUu92u4Uia04QY7nVRTbA5zX7kZvhWKW5cbEc/T7mtytKHbfLLy
         9vxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678835076;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4b5D46r0egTUZOP7UsIE7L+hvcUSuvgdra47+VJ8O/M=;
        b=phew7ms0QVmFR5x8kZkSl0LQg+8FkPBTtTb9ycHhV9OZoxDskn/6BHgAFp3IJYXzmf
         OmxylZcajm9ERAfe9go1hiyfzhDm0XJ4zWir7r9ARoAZb8XzlH9ZwayghSggee+hy/VP
         TAhImRVHVdIhhWtrsTxzqg+D/r9F5nuoiKJnlPfxRjQ78rX+A1wR9a1GIIjdozGEkP+g
         EdGXHj5KZ8MTgkwh6oxOR3LyHg64YyIkuh+NWf1KGK3t6/kHqGuCPOWo9PM4Orq7Z8vt
         cuBFKgHfzOIlCnfXZNVO/bqByY9Oi2WY+sn9rZXgCPlR1ktUH9ybcoifHZnMDhtmkZJJ
         jLwA==
X-Gm-Message-State: AO0yUKUQrbbV9UakWU2Ml7XPO6d5TvITlx0DfhUI9sb76bDh9cOLNIB+
        dub03F/xtyPxGs9t9QpL+sxCvoLwjJxyApWk
X-Google-Smtp-Source: AK7set/9ViMyjOfhX2WZNuHYg3rZG3UEAhDQoDgO/IJCBJNzR82/xYts49JDy+DhxBMG+UqtpvfFHA==
X-Received: by 2002:ac2:5927:0:b0:4e8:41fc:b37 with SMTP id v7-20020ac25927000000b004e841fc0b37mr1202243lfi.10.1678835076035;
        Tue, 14 Mar 2023 16:04:36 -0700 (PDT)
Received: from bigfoot.. (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id b1-20020ac25e81000000b004cc7acfbd2bsm569638lfq.287.2023.03.14.16.04.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 16:04:35 -0700 (PDT)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     dwarves@vger.kernel.org, arnaldo.melo@gmail.com
Cc:     bpf@vger.kernel.org, kernel-team@fb.com, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, yhs@fb.com,
        jose.marchesi@oracle.com, david.faust@oracle.com,
        alan.maguire@oracle.com, Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH dwarves v2 5/5] dwarf_loader: Support for btf:type_tag
Date:   Wed, 15 Mar 2023 01:04:17 +0200
Message-Id: <20230314230417.1507266-6-eddyz87@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230314230417.1507266-1-eddyz87@gmail.com>
References: <20230314230417.1507266-1-eddyz87@gmail.com>
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

"btf:type_tag" is an DW_TAG_LLVM_annotation object that encodes
btf_type_tag attributes in DWARF. Contrary to existing "btf_type_tag"
it allows to associate such attributes with non-pointer types.
When "btf:type_tag" is attached to a type it applies to this type.

For example the following C code:

    struct echo {
      int __attribute__((btf_type_tag("__c"))) c;
    }

Produces the following DWARF:

0x29:   DW_TAG_structure_type
          DW_AT_name      ("echo")

0x40:     DW_TAG_member
            DW_AT_name    ("c")
            DW_AT_type    (0x8c "int")

0x8c:   DW_TAG_base_type
          DW_AT_name      ("int")
          DW_AT_encoding  (DW_ATE_signed)
          DW_AT_byte_size (0x04)

0x90:     DW_TAG_LLVM_annotation
            DW_AT_name    ("btf:type_tag")
            DW_AT_const_value     ("__c")

Meaning that type 0x8c is an `int` with type tag `__c`.
Corresponding BTF looks as follows:

[1] STRUCT 'echo'
        ...
        'c' type_id=8 bits_offset=128
[4] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
[8] TYPE_TAG '__c' type_id=4

This commit adds support for DW_TAG_LLVM_annotation "btf:type_tag"
attached to the following entities:
- base types;
- arrays;
- pointers;
- structs
- unions;
- enums;
- typedefs.

To allow backwards compatibility and void additional invocation
options, implementation acts in a following way:
- both `btf_type_tag` and `btf:type_tag` could be present in the
  debug info;
- if `btf:type_tag` are present in the debug info, `btf_type_tag`
  annotations are ignored.

Modifications done by this commit:
- DWARF load phase is updated:
  - `annots` fields are filled for the above mentioned types;
  - `cu` instance is updated to reflect which version of type tags is
    used in the debug info;
- Recode phase is split in several sub-phases:
  - `cu__allocate_btf_type_tags()`
    `llvm_annotation` instances corresponding to preferred version of
    type tags are added to types table;
  - `tag__recode_dwarf_type()` (the original phase logic);
  - `update_btf_type_tag_refs()`
    Updates `->type` field of each tag if that type refers to a type
    with `btf:type_tag` annotation. The id of the type is replaced by
    id of the type tag.

See also:
[1] Mailing list discussion regarding `btf:type_tag`
    Various approaches are discussed, Solution #2 is accepted
    https://lore.kernel.org/bpf/87r0w9jjoq.fsf@oracle.com/

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 dwarf_loader.c | 530 ++++++++++++++++++++++++++++++++++++++++++++-----
 dwarves.h      |  10 +-
 2 files changed, 484 insertions(+), 56 deletions(-)

diff --git a/dwarf_loader.c b/dwarf_loader.c
index 218806b..fe38c29 100644
--- a/dwarf_loader.c
+++ b/dwarf_loader.c
@@ -57,6 +57,36 @@
 #define EM_RISCV	243
 #endif
 
+/** struct btf_type_tag_mapping - information about btf type tags attached
+ *  to a particular host type. Each field is a small_id of the dwarf tag.
+ *  This information is used to replace references to host type with
+ *  references to first btf type tag during the recode phase.
+ *
+ *  @host_type_id - type annotated with btf_type_tag annotations
+ *  @first_tag_id - first btf type tag attached to host_type_id
+ *  @last_tag_id  - last btf type tag attached to host_type_id
+ *
+ */
+struct btf_type_tag_mapping {
+	uint32_t host_type_id;
+	uint32_t first_tag_id;
+	uint32_t last_tag_id;
+};
+
+/** struct recode_context - information local to recode phase,
+ *  currently only btf type tag mappings.
+ *
+ *  @mappings     - an array of host id to btf type tag mappings,
+ *                  dynamically enlarged when new mappings are added;
+ *  @nr_allocated - number of elements allocated for @mappings array;
+ *  @nr_entries   - index of the next free entry in the @mappings array.
+ */
+struct recode_context {
+	struct btf_type_tag_mapping *mappings;
+	uint32_t nr_allocated;
+	uint32_t nr_entries;
+};
+
 static pthread_mutex_t libdw__lock = PTHREAD_MUTEX_INITIALIZER;
 
 static uint32_t hashtags__bits = 12;
@@ -958,13 +988,16 @@ static int add_btf_type_tag(Dwarf_Die *die,
 {
 	struct llvm_annotation *annot;
 	const char *name;
+	bool v1, v2;
 
 	if (conf->skip_encoding_btf_type_tag)
 		return 0;
 
 	name = attr_string(die, DW_AT_name, conf);
+	v1 = strcmp(name, "btf_type_tag") == 0;
+	v2 = strcmp(name, "btf:type_tag") == 0;
 
-	if (strcmp(name, "btf_type_tag") != 0)
+	if (!v1 && !v2)
 		return 0;
 
 	/* Create a btf_type_tag type for this annotation. */
@@ -972,11 +1005,11 @@ static int add_btf_type_tag(Dwarf_Die *die,
 	if (annot == NULL)
 		return -ENOMEM;
 
-	cu__assign_tag_id(cu, &annot->tag);
-
-	annot->kind = BTF_TYPE_TAG_POINTEE;
+	annot->kind = v2 ? BTF_TYPE_TAG : BTF_TYPE_TAG_POINTEE;
 	annot->value = attr_string(die, DW_AT_const_value, conf);
 	annot->component_idx = -1;
+	if (v2)
+		cu->ignore_btf_type_tag_pointee = 1;
 
 	/* For a list of DW_TAG_LLVM_annotation like tag1 -> tag2 -> tag3,
 	 * the tag->tags contains tag3 -> tag2 -> tag1.
@@ -1467,6 +1500,8 @@ static struct tag *die__create_new_unspecified_type(Dwarf_Die *die, struct cu *c
 	INIT_LIST_HEAD(&tag->node);
 
 	tag->name = attr_string(die, DW_AT_name, conf);
+	if (add_child_llvm_annotations(die, cu, -1, conf, &tag->tag.annots))
+		return NULL;
 
 	list_add(&tag->node, &cu->unspecified_types);
 
@@ -1564,9 +1599,8 @@ static struct tag *die__create_new_base_type(Dwarf_Die *die, struct cu *cu, stru
 	if (base == NULL)
 		return NULL;
 
-	if (dwarf_haschildren(die))
-		fprintf(stderr, "%s: DW_TAG_base_type WITH children!\n",
-			__func__);
+	if (add_child_llvm_annotations(die, cu, -1, conf, &base->tag.annots))
+		return NULL;
 
 	return &base->tag;
 }
@@ -1584,7 +1618,7 @@ static struct tag *die__create_new_typedef(Dwarf_Die *die, struct cu *cu, struct
 	return &tdef->namespace.tag;
 }
 
-static struct tag *die__create_new_array(Dwarf_Die *die, struct cu *cu)
+static struct tag *die__create_new_array(Dwarf_Die *die, struct cu *cu, struct conf_load *conf)
 {
 	Dwarf_Die child;
 	/* "64 dimensions will be enough for everybody." acme, 2006 */
@@ -1600,17 +1634,25 @@ static struct tag *die__create_new_array(Dwarf_Die *die, struct cu *cu)
 
 	die = &child;
 	do {
-		if (dwarf_tag(die) == DW_TAG_subrange_type) {
+		switch (dwarf_tag(die)) {
+		case DW_TAG_subrange_type:
 			nr_entries[array->dimensions++] = attr_upper_bound(die);
 			if (array->dimensions == max_dimensions) {
 				fprintf(stderr, "%s: only %u dimensions are "
 						"supported!\n",
 					__FUNCTION__, max_dimensions);
-				break;
+				goto _break;
 			}
-		} else
+			break;
+		case DW_TAG_LLVM_annotation:
+			if (add_btf_type_tag(die, cu, conf, &array->tag.annots))
+				goto out_free;
+			break;
+		default:
 			cu__tag_not_handled(die);
+		}
 	} while (dwarf_siblingof(die, die) == 0);
+_break:
 
 	array->nr_entries = memdup(nr_entries,
 				   array->dimensions * sizeof(uint32_t), cu);
@@ -1722,6 +1764,10 @@ static struct tag *die__create_new_subroutine_type(Dwarf_Die *die,
 		case DW_TAG_unspecified_parameters:
 			ftype->unspec_parms = 1;
 			continue;
+		case DW_TAG_LLVM_annotation:
+			if (add_btf_type_tag(die, cu, conf, &ftype->tag.annots))
+				goto out_delete;
+			continue;
 		default:
 			tag = die__process_tag(die, cu, 0, conf);
 			if (tag == NULL)
@@ -1778,17 +1824,25 @@ static struct tag *die__create_new_enumeration(Dwarf_Die *die, struct cu *cu, st
 
 	die = &child;
 	do {
-		struct enumerator *enumerator;
+		switch (dwarf_tag(die)) {
+		case DW_TAG_enumerator: {
+			struct enumerator *enumerator;
+
+			enumerator = enumerator__new(die, cu, conf);
+			if (enumerator == NULL)
+				goto out_delete;
 
-		if (dwarf_tag(die) != DW_TAG_enumerator) {
+			enumeration__add(enumeration, enumerator);
+			break;
+		}
+		case DW_TAG_LLVM_annotation:
+			if (add_btf_type_tag(die, cu, conf,
+					     &enumeration->namespace.tag.annots))
+				goto out_delete;
+			break;
+		default:
 			cu__tag_not_handled(die);
-			continue;
 		}
-		enumerator = enumerator__new(die, cu, conf);
-		if (enumerator == NULL)
-			goto out_delete;
-
-		enumeration__add(enumeration, enumerator);
 	} while (dwarf_siblingof(die, die) == 0);
 out:
 	return &enumeration->namespace.tag;
@@ -2191,19 +2245,19 @@ static struct tag *__die__process_tag(Dwarf_Die *die, struct cu *cu,
 	case DW_TAG_imported_unit:
 		return NULL; // We don't support imported units yet, so to avoid segfaults
 	case DW_TAG_array_type:
-		tag = die__create_new_array(die, cu);		break;
+		tag = die__create_new_array(die, cu, conf);	break;
 	case DW_TAG_string_type: // FORTRAN stuff, looks like an array
 		tag = die__create_new_string_type(die, cu);	break;
 	case DW_TAG_base_type:
 		tag = die__create_new_base_type(die, cu, conf);	break;
-	case DW_TAG_const_type:
 	case DW_TAG_imported_declaration:
 	case DW_TAG_imported_module:
 	case DW_TAG_reference_type:
-	case DW_TAG_restrict_type:
-	case DW_TAG_volatile_type:
 	case DW_TAG_atomic_type:
 		tag = die__create_new_tag(die, cu);		break;
+	case DW_TAG_const_type:
+	case DW_TAG_restrict_type:
+	case DW_TAG_volatile_type:
 	case DW_TAG_pointer_type:
 		tag = die__create_new_annotated_tag(die, cu, conf); break;
 	case DW_TAG_unspecified_type:
@@ -2294,20 +2348,99 @@ static int die__process_unit(Dwarf_Die *die, struct cu *cu, struct conf_load *co
 	return 0;
 }
 
-static void ftype__recode_dwarf_types(struct tag *tag, struct cu *cu);
+/** Add @tuple to @ctx->mappings array, extend it if necessary. */
+static int push_btf_type_tag_mapping(struct btf_type_tag_mapping *tuple,
+				     struct recode_context *ctx)
+{
+	if (ctx->nr_allocated == ctx->nr_entries) {
+		uint32_t new_nr = ctx->nr_allocated * 2;
+		void *new_array = realloc(ctx->mappings, new_nr * sizeof(ctx->mappings[0]));
+		if (!new_array)
+			return -ENOMEM;
+		ctx->mappings = new_array;
+		ctx->nr_allocated = new_nr;
+	}
+
+	ctx->mappings[ctx->nr_entries++] = *tuple;
 
-static int namespace__recode_dwarf_types(struct tag *tag, struct cu *cu)
+	return 0;
+}
+
+/** Connect `type` fields of btf:type_tag annotations attached to a
+ *  host type. Collect information about first and last tag.
+ *  `type` field are connected as below:
+ *
+ *    tag1.type -> tag2.type -> host_type
+ *
+ *  @tags      - list of llvm_annotation objects;
+ *  @host_type - small_id of the type with attached annotations.
+ */
+static void __recode_btf_type_tags(struct list_head *tags,
+				   uint32_t host_type,
+				   struct btf_type_tag_mapping *mapping)
+{
+	struct llvm_annotation *annot;
+	struct dwarf_tag *annot_dtag;
+	struct tag *prev_tag = NULL;
+	uint32_t first_tag_id = 0;
+
+	list_for_each_entry(annot, tags, node) {
+		if (annot->kind != BTF_TYPE_TAG)
+			continue;
+		annot_dtag = annot->tag.priv;
+		if (prev_tag)
+			prev_tag->type = annot_dtag->small_id;
+		if (!first_tag_id)
+			first_tag_id = annot_dtag->small_id;
+		prev_tag = &annot->tag;
+	}
+
+	mapping->host_type_id = host_type;
+	if (prev_tag) {
+		prev_tag->type = host_type;
+		mapping->first_tag_id = first_tag_id;
+		mapping->last_tag_id = annot_dtag->small_id;
+	} else {
+		mapping->first_tag_id = 0;
+		mapping->last_tag_id = 0;
+	}
+}
+
+static int recode_btf_type_tags(struct list_head *tags,
+				uint32_t host_type,
+				struct recode_context *ctx)
+{
+	struct btf_type_tag_mapping mapping;
+
+	if (list_empty(tags))
+		return 0;
+
+	__recode_btf_type_tags(tags, host_type, &mapping);
+	if (!mapping.first_tag_id)
+		return 0;
+
+	return push_btf_type_tag_mapping(&mapping, ctx);
+}
+
+static void ftype__recode_dwarf_types(struct tag *tag, struct cu *cu,
+				      struct recode_context *ctx);
+
+static int namespace__recode_dwarf_types(struct tag *tag, struct cu *cu,
+					 struct recode_context *ctx)
 {
 	struct tag *pos;
 	struct dwarf_cu *dcu = cu->priv;
+	struct dwarf_tag *dtag = tag->priv;
 	struct namespace *ns = tag__namespace(tag);
 
+	recode_btf_type_tags(&tag->annots, dtag->small_id, ctx);
+
 	namespace__for_each_tag(ns, pos) {
 		struct dwarf_tag *dtype;
 		struct dwarf_tag *dpos = pos->priv;
 
 		if (tag__has_namespace(pos)) {
-			if (namespace__recode_dwarf_types(pos, cu))
+			if (namespace__recode_dwarf_types(pos, cu, ctx))
 				return -1;
 			continue;
 		}
@@ -2328,7 +2461,7 @@ static int namespace__recode_dwarf_types(struct tag *tag, struct cu *cu)
 			break;
 		case DW_TAG_subroutine_type:
 		case DW_TAG_subprogram:
-			ftype__recode_dwarf_types(pos, cu);
+			ftype__recode_dwarf_types(pos, cu, ctx);
 			break;
 		case DW_TAG_imported_module:
 			dtype = dwarf_cu__find_tag_by_ref(dcu, &dpos->type);
@@ -2393,7 +2526,8 @@ static void __tag__print_abstract_origin_not_found(struct tag *tag,
 #define tag__print_abstract_origin_not_found(tag ) \
 	__tag__print_abstract_origin_not_found(tag, __func__)
 
-static void ftype__recode_dwarf_types(struct tag *tag, struct cu *cu)
+static void ftype__recode_dwarf_types(struct tag *tag, struct cu *cu,
+				      struct recode_context *ctx)
 {
 	struct parameter *pos;
 	struct dwarf_cu *dcu = cu->priv;
@@ -2441,9 +2575,13 @@ static void ftype__recode_dwarf_types(struct tag *tag, struct cu *cu)
 		}
 		pos->tag.type = dtype->small_id;
 	}
+
+	struct dwarf_tag *dtag = tag->priv;
+	recode_btf_type_tags(&tag->annots, dtag->small_id, ctx);
 }
 
-static void lexblock__recode_dwarf_types(struct lexblock *tag, struct cu *cu)
+static void lexblock__recode_dwarf_types(struct lexblock *tag, struct cu *cu,
+					 struct recode_context *ctx)
 {
 	struct tag *pos;
 	struct dwarf_cu *dcu = cu->priv;
@@ -2454,7 +2592,7 @@ static void lexblock__recode_dwarf_types(struct lexblock *tag, struct cu *cu)
 
 		switch (pos->tag) {
 		case DW_TAG_lexical_block:
-			lexblock__recode_dwarf_types(tag__lexblock(pos), cu);
+			lexblock__recode_dwarf_types(tag__lexblock(pos), cu, ctx);
 			continue;
 		case DW_TAG_inlined_subroutine:
 			if (dpos->type.off != 0)
@@ -2468,7 +2606,7 @@ static void lexblock__recode_dwarf_types(struct lexblock *tag, struct cu *cu)
 					tag__print_abstract_origin_not_found(pos);
 				continue;
 			}
-			ftype__recode_dwarf_types(dtype->tag, cu);
+			ftype__recode_dwarf_types(dtype->tag, cu, ctx);
 			continue;
 
 		case DW_TAG_formal_parameter:
@@ -2535,8 +2673,144 @@ static void lexblock__recode_dwarf_types(struct lexblock *tag, struct cu *cu)
 	}
 }
 
+static int recode_context_init(struct recode_context *ctx)
+{
+	const int initial_nr = 16;
+
+	ctx->mappings = reallocarray(NULL, initial_nr, sizeof(ctx->mappings[0]));
+	if (!ctx->mappings)
+		return -ENOMEM;
+
+	ctx->nr_allocated = initial_nr;
+	ctx->nr_entries = 0;
+
+	return 0;
+}
+
+static void recode_context_free(struct recode_context *ctx)
+{
+	free(ctx->mappings);
+	ctx->nr_allocated = 0;
+	ctx->nr_entries = 0;
+}
+
+/** Compare two `btf_type_tag_mapping` objects using host_type_id as key. */
+static int compare_btf_type_tag_recode_mappings(const void *_a, const void *_b)
+{
+	const struct btf_type_tag_mapping *a = _a;
+	const struct btf_type_tag_mapping *b = _b;
+	long diff = (long)a->host_type_id - (long)b->host_type_id;
+
+	if (diff < 0)
+		return -1;
+	if (diff > 0)
+		return 1;
+	return 0;
+}
+
+/** Sort @ctx->mappings array by btf_type_tag_mapping::host_type_id,
+ *  function `lookup_btf_type_tag_by_host()` uses binary search to find
+ *  elements of this array.
+ */
+static void sort_btf_type_tags(struct recode_context *ctx)
+{
+	qsort(ctx->mappings, ctx->nr_entries, sizeof(ctx->mappings[0]),
+	      compare_btf_type_tag_recode_mappings);
+}
+
+static struct btf_type_tag_mapping *lookup_btf_type_tag_by_host(uint32_t host_type_id,
+								struct recode_context *ctx)
+{
+	struct btf_type_tag_mapping key = { .host_type_id = host_type_id };
+
+	return bsearch(&key, ctx->mappings, ctx->nr_entries, sizeof(key),
+		       compare_btf_type_tag_recode_mappings);
+}
+
+/** Update @tag->type fields by replacing types by ids of associated
+ *  btf:type_tag objects. @ctx->mappings should be sorted when this
+ *  function is called.
+ *
+ *  When "btf:type_tag" is attached to a type it applies to this type.
+ *  For example, the following dwarf:
+ *
+ *  0x00000040:     DW_TAG_member
+ *                    DW_AT_name    ("c")
+ *                    DW_AT_type    (0x0000008c "int")
+ *                    DW_AT_decl_file       ("/home/eddy/work/tmp/test.c")
+ *                    DW_AT_decl_line       (13)
+ *                    DW_AT_data_member_location    (0x10)
+ *
+ *  0x0000008c:   DW_TAG_base_type
+ *                  DW_AT_name      ("int")
+ *                  DW_AT_encoding  (DW_ATE_signed)
+ *                  DW_AT_byte_size (0x04)
+ *
+ *  0x00000090:     DW_TAG_LLVM_annotation
+ *                    DW_AT_name    ("btf:type_tag")
+ *                    DW_AT_const_value     ("__c")
+ *
+ *  Means that type 0x0000008c is an `int` with type tag `__c`.
+ *  Corresponding BTF looks as follows:
+ *
+ *  [1] STRUCT 'echo'
+ *          ...
+ *          'c' type_id=8 bits_offset=128
+ *  [4] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
+ *  [8] TYPE_TAG '__c' type_id=4
+ *
+ *  Before the call to `update_btf_type_tag_refs` for member 0x00000040
+ *  its `type` field points to 0x0000008c. `update_btf_type_tag_refs`
+ *  updates this link to point to `0x00000090` instead, thus obtaining the
+ *  desired BTF shape.
+ */
+static int update_btf_type_tag_refs(struct tag *tag,
+				    struct cu *cu,
+				    struct recode_context *ctx)
+{
+	struct btf_type_tag_mapping *tuple;
+	struct dwarf_tag *dtag = tag->priv;
+
+	/* Kernel does not support VAR entries with types of form
+	 * 'VAR -> TYPE_TAG -> something':
+	 * - in verifier.c:check_pseudo_btf_id() instruction auxiliary
+	 *   data is set to point to variable type w/o stripping modifiers;
+	 * - btf.c:btf_struct_access() -> btf.c:btf_struct_walk()
+	 *   does not skip modifiers prior to btf_type_is_struct() check.
+	 *
+	 * So, skip type tag recoding for variables.
+	 */
+	if (tag->tag == DW_TAG_variable)
+		return 0;
+
+	tuple = lookup_btf_type_tag_by_host(tag->type, ctx);
+	/* Avoid creation of circular references, last btf:type_tag
+	 * object points to the host type.
+	 */
+	if (tuple && tuple->last_tag_id != dtag->small_id)
+		tag->type = tuple->first_tag_id;
+
+	if (tag__is_type(tag)) {
+		struct type *type = tag__type(tag);
+		struct class_member *pos;
+
+		type__for_each_data_member(type, pos)
+			update_btf_type_tag_refs(&pos->tag, cu, ctx);
+	} else if (tag->tag == DW_TAG_subprogram ||
+		   tag->tag == DW_TAG_subroutine_type) {
+		struct ftype *ftype = tag__ftype(tag);
+		struct parameter *pos;
+
+		ftype__for_each_parameter(ftype, pos)
+			update_btf_type_tag_refs(&pos->tag, cu, ctx);
+	}
+
+	return 0;
+}
+
 static void dwarf_cu__recode_btf_type_tag_ptr(struct tag *tag,
-					      uint32_t pointee_type)
+					      uint32_t pointee_type,
+					      struct cu *cu)
 {
 	struct llvm_annotation *annot;
 	struct dwarf_tag *annot_dtag;
@@ -2566,15 +2840,19 @@ static void dwarf_cu__recode_btf_type_tag_ptr(struct tag *tag,
 	 * and this matches the user/kernel code.
 	 */
 	prev_tag = tag;
-	list_for_each_entry(annot, &tag->annots, node) {
-		annot_dtag = annot->tag.priv;
-		prev_tag->type = annot_dtag->small_id;
-		prev_tag = &annot->tag;
+	if (!cu->ignore_btf_type_tag_pointee) {
+		list_for_each_entry(annot, &tag->annots, node) {
+			if (annot->kind != BTF_TYPE_TAG_POINTEE)
+				continue;
+			annot_dtag = annot->tag.priv;
+			prev_tag->type = annot_dtag->small_id;
+			prev_tag = &annot->tag;
+		}
 	}
 	prev_tag->type = pointee_type;
 }
 
-static int tag__recode_dwarf_type(struct tag *tag, struct cu *cu)
+static int tag__recode_dwarf_type(struct tag *tag, struct cu *cu, struct recode_context *ctx)
 {
 	struct dwarf_tag *dtag = tag->priv;
 	struct dwarf_tag *dtype;
@@ -2587,7 +2865,7 @@ static int tag__recode_dwarf_type(struct tag *tag, struct cu *cu)
 		type__recode_dwarf_specification(tag, cu);
 
 	if (tag__has_namespace(tag))
-		return namespace__recode_dwarf_types(tag, cu);
+		return namespace__recode_dwarf_types(tag, cu, ctx);
 
 	switch (tag->tag) {
 	case DW_TAG_subprogram: {
@@ -2619,17 +2897,17 @@ static int tag__recode_dwarf_type(struct tag *tag, struct cu *cu)
 					(unsigned long long)specification.off);
 			}
 		}
-		lexblock__recode_dwarf_types(&fn->lexblock, cu);
+		lexblock__recode_dwarf_types(&fn->lexblock, cu, ctx);
 	}
 		/* Fall thru */
 
 	case DW_TAG_subroutine_type:
-		ftype__recode_dwarf_types(tag, cu);
+		ftype__recode_dwarf_types(tag, cu, ctx);
 		/* Fall thru, for the function return type */
 		break;
 
 	case DW_TAG_lexical_block:
-		lexblock__recode_dwarf_types(tag__lexblock(tag), cu);
+		lexblock__recode_dwarf_types(tag__lexblock(tag), cu, ctx);
 		return 0;
 
 	case DW_TAG_ptr_to_member_type: {
@@ -2650,7 +2928,7 @@ static int tag__recode_dwarf_type(struct tag *tag, struct cu *cu)
 		break;
 
 	case DW_TAG_namespace:
-		return namespace__recode_dwarf_types(tag, cu);
+		return namespace__recode_dwarf_types(tag, cu, ctx);
 	/* Damn, DW_TAG_inlined_subroutine is an special case
            as dwarf_tag->id is in fact an abtract origin, i.e. must be
 	   looked up in the tags_table, not in the types_table.
@@ -2684,11 +2962,13 @@ static int tag__recode_dwarf_type(struct tag *tag, struct cu *cu)
 		return 0;
 	}
 
+	recode_btf_type_tags(&tag->annots, dtag->small_id, ctx);
+
 	if (dtag->type.off == 0) {
 		if (tag->tag != DW_TAG_pointer_type)
 			tag->type = 0; /* void */
 		else
-			dwarf_cu__recode_btf_type_tag_ptr(tag, 0);
+			dwarf_cu__recode_btf_type_tag_ptr(tag, 0, cu);
 		return 0;
 	}
 
@@ -2703,7 +2983,7 @@ out:
 	if (tag->tag != DW_TAG_pointer_type)
 		tag->type = dtype->small_id;
 	else
-		dwarf_cu__recode_btf_type_tag_ptr(tag, dtype->small_id);
+		dwarf_cu__recode_btf_type_tag_ptr(tag, dtype->small_id, cu);
 
 	return 0;
 }
@@ -2788,28 +3068,168 @@ static int cu__resolve_func_ret_types_optimized(struct cu *cu)
 	return 0;
 }
 
-static int cu__recode_dwarf_types_table(struct cu *cu,
-					struct ptr_table *pt,
-					uint32_t i)
+typedef int (*recode_tag_visitor)(struct tag *, struct cu*, struct recode_context *);
+
+static int cu__visit_all_tags(struct cu *cu, recode_tag_visitor fn, struct recode_context *ctx)
 {
-	for (; i < pt->nr_entries; ++i) {
-		struct tag *tag = pt->entries[i];
+	const int nr_tables = 3;
+	struct {
+		struct ptr_table *table;
+		uint32_t start_idx;
+	} tables[] = {
+		{ &cu->types_table,	1 },
+		{ &cu->tags_table,	0 },
+		{ &cu->functions_table,	0 }
+	};
+	struct ptr_table *pt;
+	struct tag *tag;
+	uint32_t i, t;
 
-		if (tag != NULL) /* void, see cu__new */
-			if (tag__recode_dwarf_type(tag, cu))
+	for (t = 0; t < nr_tables; ++t) {
+		pt = tables[t].table;
+		for (i = tables[t].start_idx; i < pt->nr_entries; ++i) {
+			tag = pt->entries[i];
+			if (!tag) /* void, see cu__new */
+				continue;
+			if (fn(tag, cu, ctx))
 				return -1;
+		}
+	}
+
+	return 0;
+}
+
+/* See comment for cu__allocate_btf_type_tags() below. */
+static int tag__allocate_btf_type_tags(struct tag *tag, struct cu *cu)
+{
+	enum annotation_kind target = cu->ignore_btf_type_tag_pointee
+				      ? BTF_TYPE_TAG
+				      : BTF_TYPE_TAG_POINTEE;
+	struct list_head *annots = &tag->annots;
+	struct llvm_annotation *annot;
+
+	list_for_each_entry(annot, annots, node) {
+		if (annot->kind != target)
+			continue;
+
+		int err = cu__assign_tag_id(cu, &annot->tag);
+		if (err)
+			return err;
 	}
 
 	return 0;
 }
 
+/* The flag `cu->ignore_btf_type_tag_pointee` is set at DWARF load phase.
+ * Before it is set it is not known what kind of type tags is used in
+ * the program, BTF_TYPE_TAG or BTF_TYPE_TAG_POINTEE.
+ * It is necessary to allocate only a single kind of tags to avoid
+ * spurious entries in the type table (and resultant BTF).
+ * Thus, the allocation of type tags is done as a separate step.
+ */
+static int cu__allocate_btf_type_tags(struct cu *cu)
+{
+	struct unspecified_type *utype;
+	struct tag *pos;
+	uint32_t id;
+	int err = 0;
+
+	cu__for_each_type(cu, id, pos) {
+		err = tag__allocate_btf_type_tags(pos, cu);
+		if (err)
+			return err;
+	}
+
+	list_for_each_entry(utype, &cu->unspecified_types, node) {
+		err = tag__allocate_btf_type_tags(&utype->tag, cu);
+		if (err)
+			return err;
+	}
+
+	return err;
+}
+
+/* `btf:type_tag` tags have special representation, when attached to void type.
+ * For example, DWARF for the following C code:
+ *
+ *   struct st {
+ *     void __attribute__(btf_type_tag("__d")) *d;
+ *   }
+ *
+ * Looks as follows:
+ *
+ *   0x29:   DW_TAG_structure_type
+ *             DW_AT_name      ("st")
+ *
+ *   0x49:     DW_TAG_member
+ *               DW_AT_name    ("d")
+ *               DW_AT_type    (0xa6 "void *")
+ *
+ *   0xa6:   DW_TAG_pointer_type
+ *             DW_AT_type      (0xaf "void")
+ *
+ *   0xaf:   DW_TAG_unspecified_type
+ *             DW_AT_name      ("void")
+ *
+ *   0xb1:     DW_TAG_LLVM_annotation
+ *               DW_AT_name    ("btf:type_tag")
+ *               DW_AT_const_value     ("__d")
+ *
+ * Here `void` type is encoded as `DW_TAG_unspecified_type` with
+ * `DW_TAG_LLVM_annotation` children.
+ *
+ * This function replaces `small_id` of the unspecified type (0xaf) with
+ * `small_id` of the first `btf:type_tag` annotation (0xb1).
+ * Thus further recode passes will use id of the type tag in place of the
+ * unspecified type id, when references to unspecified type are resolved.
+ */
+static void cu__recode_unspecified_types(struct cu *cu)
+{
+	struct btf_type_tag_mapping mapping;
+	struct unspecified_type *utype;
+	struct dwarf_tag *dtag;
+
+	list_for_each_entry(utype, &cu->unspecified_types, node) {
+		__recode_btf_type_tags(&utype->tag.annots, 0, &mapping);
+		dtag = utype->tag.priv;
+		dtag->small_id = mapping.first_tag_id;
+	}
+}
+
 static int cu__recode_dwarf_types(struct cu *cu)
 {
-	if (cu__recode_dwarf_types_table(cu, &cu->types_table, 1) ||
-	    cu__recode_dwarf_types_table(cu, &cu->tags_table, 0) ||
-	    cu__recode_dwarf_types_table(cu, &cu->functions_table, 0))
+	struct recode_context ctx = {};
+	int err = 0;
+
+	if (recode_context_init(&ctx))
 		return -1;
-	return 0;
+
+	if (cu__allocate_btf_type_tags(cu)) {
+		err = -1;
+		goto cleanup;
+	}
+
+	cu__recode_unspecified_types(cu);
+
+	if (cu__visit_all_tags(cu, tag__recode_dwarf_type, &ctx)) {
+		err = -1;
+		goto cleanup;
+	}
+
+	/* No need for second pass if there are no btf type tags */
+	if (ctx.nr_entries == 0)
+		goto cleanup;
+
+	sort_btf_type_tags(&ctx);
+
+	if (cu__visit_all_tags(cu, update_btf_type_tag_refs, &ctx)) {
+		err = -1;
+		goto cleanup;
+	}
+
+cleanup:
+	recode_context_free(&ctx);
+	return err;
 }
 
 static const char *dwarf_tag__decl_file(const struct tag *tag,
diff --git a/dwarves.h b/dwarves.h
index cbd2913..fa95267 100644
--- a/dwarves.h
+++ b/dwarves.h
@@ -261,6 +261,10 @@ struct cu {
 	uint8_t		 has_addr_info:1;
 	uint8_t		 uses_global_strings:1;
 	uint8_t		 little_endian:1;
+	/* When set means that "btf:type_tags" annotations are present
+	 * and "btf_type_tags" annotations should be ignored during export.
+	 */
+	uint8_t		 ignore_btf_type_tag_pointee:1;
 	uint8_t		 nr_register_params;
 	int		 register_params[ARCH_MAX_REGISTER_PARAMS];
 	uint16_t	 language;
@@ -628,8 +632,12 @@ static inline struct ptr_to_member_type *
 
 enum annotation_kind {
 	BTF_DECL_TAG,
-	/* "btf_type_tag" in DWARF, attached to a pointer, applies to pointee type */
+	/* "btf_type_tag" in DWARF, attached to a pointer, applies to pointee type.
+	 * Old-style encoding kept for backwards compatibility.
+	 */
 	BTF_TYPE_TAG_POINTEE,
+	/* "btf:type_tag" in DWARF, attached to any type, applies to parent type */
+	BTF_TYPE_TAG,
 };
 
 /** struct llvm_annotation - representing objects with DW_TAG_LLVM_annotation tag
-- 
2.39.1

