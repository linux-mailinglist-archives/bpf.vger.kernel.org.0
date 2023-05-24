Return-Path: <bpf+bounces-1138-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2173070EA2C
	for <lists+bpf@lfdr.de>; Wed, 24 May 2023 02:20:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBA1F281115
	for <lists+bpf@lfdr.de>; Wed, 24 May 2023 00:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFA5A15AA;
	Wed, 24 May 2023 00:19:12 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F69B1365
	for <bpf@vger.kernel.org>; Wed, 24 May 2023 00:19:12 +0000 (UTC)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A71EE5;
	Tue, 23 May 2023 17:19:09 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4f4b256a0c9so154871e87.2;
        Tue, 23 May 2023 17:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684887547; x=1687479547;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hhKIbkyfkXITYQWDaG29A7FDZ5cO/1XSJhAiWV46YSQ=;
        b=ZNLlC+po6/JgeZGK8ibdePZAxrBRFqkomzypV77dixq/NCQTMzi5mP/GBUv9l65/SL
         wuvvnv05Gni6js7H/i8/lFPhDjq13pg4u7Erktr0AwOfukefvuLUMTrR38EY9fMpXcOn
         aZsRlQZP8WroqXd1gtECg2nHXQtVe+oPTmgmJ5of88jskb9Ezk40YkKBYMAeLfxryny9
         DZ3jC/DRR6JjvurmolGZxg3qWcvZBNckTP4TXMiZGj+RgPCgJpob4xEbf6d/rWp6iUk6
         QVcnnDMDvV7sASU021APgN04EgShVzcSWlaSLrQSbvJjau6lvKpf4OfallFmCYQNgHTp
         7bPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684887547; x=1687479547;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hhKIbkyfkXITYQWDaG29A7FDZ5cO/1XSJhAiWV46YSQ=;
        b=NST0hXuPr5otA5LZoB5vVUW2lp4/PXjnnZYMTVuHb1N2clMlDx5SytOUeTvBGbBngW
         vn/BT1FBOCzNJobwxM0xBNpE290ZQlHUMpvxzt/pm1nMS0GwO9lbZ+quzGcp2Poy+BrW
         e1fRwBhpernJ5PqsVPJXw0XWjZCQVnzSaq966ynMNgDzuYZ3DbJjx5jHEJ98xDFr0Ajx
         Y3xGerguTUobK6aYUJZpQdyeOZcQ0u527dh+956LlvQ0nmlIvES5RBpBL9HP7utbHhQO
         MOudwBnZ8SmaVyNU5sWkeN3MSBRvwQGUvWC7+92JjEWOil29snSwF8hUiREdyOLyNwbo
         mlsQ==
X-Gm-Message-State: AC+VfDzwM3bqTvY9SCy6jP4oXz4IWsSNu0mqjmQ2Dz6H9SbpYA+3Fgqq
	Fdx29qSfZ0c1qD6OWJ9mYrKfOXig3Y0c0g==
X-Google-Smtp-Source: ACHHUZ53u5QpAtB3JgLAjxazOlYH3ZhpPVEurDb1jWxLsAx4vWMb5DF70qT5b0baIgUBh3WmOdAshw==
X-Received: by 2002:ac2:5dfc:0:b0:4ef:f583:ee16 with SMTP id z28-20020ac25dfc000000b004eff583ee16mr5056699lfq.57.1684887547190;
        Tue, 23 May 2023 17:19:07 -0700 (PDT)
Received: from bigfoot.. (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id w7-20020a19c507000000b004f138ab93c7sm1487305lfe.264.2023.05.23.17.19.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 17:19:06 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: dwarves@vger.kernel.org,
	arnaldo.melo@gmail.com
Cc: bpf@vger.kernel.org,
	kernel-team@fb.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	yhs@fb.com,
	jemarch@gnu.org,
	david.faust@oracle.com,
	mykolal@fb.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH v3 dwarves 4/6] dwarf_loader: support btf:type_tag DW_TAG_LLVM_annotation
Date: Wed, 24 May 2023 03:18:23 +0300
Message-Id: <20230524001825.2688661-5-eddyz87@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230524001825.2688661-1-eddyz87@gmail.com>
References: <20230524001825.2688661-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

"btf:type_tag" is an DW_TAG_LLVM_annotation object that encodes
btf_type_tag attributes in DWARF. Contrary to existing "btf_type_tag"
it allows to associate such attributes with non-pointer types.
When "btf:type_tag" is attached to a type it applies to this type.

For example, the following C code:

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

To allow backwards compatibility and avoid additional invocation
options, implementation acts in a following way:
- both `btf_type_tag` and `btf:type_tag` could be present in the
  debug info;
- if `btf:type_tag` annotations are present in the debug info,
  `btf_type_tag` annotations are ignored.

Code changes could be summarized as follows:
- add `enum type_tag_kind` with the following values:
  - TYPE_TAG_SELF for `btf:type_tag`
  - TYPE_TAG_POINTEE for `btf_type_tag`;
- add field `struct dwarf_cu::effective_type_tag_kind` to decide which
  type tag kind should be used for CU;
- change `dwarf_cu::type_tags` records format to convey tag kind;
- add calls to add_btf_type_tag() / add_child_btf_type_tags() for
  die__create_new_*** functions corresponding to types listed above;
- change dwarf_cu__recode_type_tags() to recode TYPE_TAG_SELF type
  tags *before* main recode phase, so `struct dwarf_cu::hash_types`
  changes would be visible during main phase.

See also:
[1] Mailing list discussion regarding `btf:type_tag`
    Various approaches are discussed, Solution #2 is accepted
    https://lore.kernel.org/bpf/87r0w9jjoq.fsf@oracle.com/

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 dwarf_loader.c | 195 ++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 160 insertions(+), 35 deletions(-)

diff --git a/dwarf_loader.c b/dwarf_loader.c
index 3670493..2b50322 100644
--- a/dwarf_loader.c
+++ b/dwarf_loader.c
@@ -117,6 +117,29 @@ static void dwarf_tag__set_spec(struct dwarf_tag *dtag, dwarf_off_ref spec)
 	*(dwarf_off_ref *)(dtag + 1) = spec;
 }
 
+enum type_tag_kind {
+	/* Corresponds to type tags of form:
+	 *
+	 *     DW_TAG_LLVM_annotation
+	 *       DW_AT_name	("btf:type_tag")
+	 *       DW_AT_const_value	("...")
+	 *
+	 * Such entries could be subordinate to any DWARF type.
+	 * The tag applies to the parent type.
+	 */
+	TYPE_TAG_SELF = 1u,
+	/* Corresponds to type tags of form:
+	 *
+	 *     DW_TAG_LLVM_annotation
+	 *       DW_AT_name	("btf_type_tag")
+	 *       DW_AT_const_value	("...")
+	 *
+	 * Such entries are subordinate to DW_TAG_pointer_type type only.
+	 * The tag applies to DW_AT_type of the pointer.
+	 */
+	TYPE_TAG_POINTEE = 2u
+};
+
 struct dwarf_cu {
 	struct hlist_head *hash_tags;
 	struct hlist_head *hash_types;
@@ -125,6 +148,7 @@ struct dwarf_cu {
 	struct dwarf_tag *last_type_lookup;
 	struct cu *cu;
 	struct dwarf_cu *type_unit;
+	enum type_tag_kind effective_type_tag_kind;
 };
 
 static int dwarf_cu__init(struct dwarf_cu *dcu, struct cu *cu)
@@ -153,6 +177,7 @@ static int dwarf_cu__init(struct dwarf_cu *dcu, struct cu *cu)
 	// To avoid a per-lookup check against NULL in dwarf_cu__find_type_by_ref()
 	dcu->last_type_lookup = &sentinel_dtag;
 	ptr_table__init(&dcu->type_tags);
+	dcu->effective_type_tag_kind = TYPE_TAG_POINTEE;
 	return 0;
 }
 
@@ -232,6 +257,20 @@ static void cu__hash(struct cu *cu, struct tag *tag)
 	hashtags__hash(hashtable, tag->priv);
 }
 
+/* Change impostor->priv->id to match tag->priv->id and replace `tag`
+ * by `impostor` in the `cu` types/tags table.
+ */
+static void cu__hash_impersonate(struct cu *cu, struct tag *tag, struct tag *impostor)
+{
+	struct dwarf_tag *dimpostor = impostor->priv;
+	struct dwarf_tag *dtag = tag->priv;
+
+	hlist_del_init(&dimpostor->hash_node);
+	hlist_del_init(&dtag->hash_node);
+	dimpostor->id = dtag->id;
+	cu__hash(cu, impostor);
+}
+
 static struct dwarf_tag *dwarf_cu__find_tag_by_ref(const struct dwarf_cu *cu,
 						   const struct dwarf_off_ref *ref)
 {
@@ -980,16 +1019,17 @@ static void type_tags_writer__init(struct type_tags_writer *writer,
  * treat `writer->dcu->type_tags` as a stream of records with the
  * following format:
  *
- *   ... parent-pointer tag-value* NULL ...
- *          ^               ^       ^
- *          |               |       '----- terminator
- *       struct tag*      char*
+ *   ... parent-pointer (tag-value tag-kind)* NULL ...
+ *          ^               ^         ^        ^
+ *          |               |         |        '----- terminator
+ *       struct tag*      char*  enum type_tag_kind
  */
 static int add_btf_type_tag(struct type_tags_writer *writer, Dwarf_Die *die,
 			    struct conf_load *conf)
 {
 	struct ptr_table *type_tags = &writer->dcu->type_tags;
 	const char *name, *value;
+	uintptr_t kind = 0;
 	uint32_t ignored;
 	int ret = 0;
 
@@ -997,11 +1037,16 @@ static int add_btf_type_tag(struct type_tags_writer *writer, Dwarf_Die *die,
 		return 0;
 
 	name = attr_string(die, DW_AT_name, conf);
-	if (strcmp(name, "btf_type_tag") != 0)
+	kind = strcmp(name, "btf_type_tag") == 0 ? TYPE_TAG_POINTEE : kind;
+	kind = strcmp(name, "btf:type_tag") == 0 ? TYPE_TAG_SELF : kind;
+	if (!kind)
 		return 0;
 
 	value = attr_string(die, DW_AT_const_value, conf);
 
+	if (kind == TYPE_TAG_SELF)
+		writer->dcu->effective_type_tag_kind = TYPE_TAG_SELF;
+
 	if (!writer->started) {
 		writer->started = true;
 		/* Terminate previous record */
@@ -1016,7 +1061,11 @@ static int add_btf_type_tag(struct type_tags_writer *writer, Dwarf_Die *die,
 			return ret;
 	}
 
-	return ptr_table__add(type_tags, (void *)value, &ignored);
+	ret = ptr_table__add(type_tags, (void *)value, &ignored);
+	if (ret)
+		return ret;
+
+	return ptr_table__add(type_tags, (void *)kind, &ignored);
 }
 
 /* Collect all type tag values attached to `parent` and save those in
@@ -1510,6 +1559,7 @@ static struct tag *die__create_new_unspecified_type(Dwarf_Die *die, struct cu *c
 	INIT_LIST_HEAD(&tag->node);
 
 	tag->name = attr_string(die, DW_AT_name, conf);
+	add_child_btf_type_tags(die, cu, &tag->tag, conf);
 
 	list_add(&tag->node, &cu->unspecified_types);
 
@@ -1611,9 +1661,7 @@ static struct tag *die__create_new_base_type(Dwarf_Die *die, struct cu *cu, stru
 	if (base == NULL)
 		return NULL;
 
-	if (dwarf_haschildren(die))
-		fprintf(stderr, "%s: DW_TAG_base_type WITH children!\n",
-			__func__);
+	add_child_btf_type_tags(die, cu, &base->tag, conf);
 
 	return &base->tag;
 }
@@ -1628,11 +1676,15 @@ static struct tag *die__create_new_typedef(Dwarf_Die *die, struct cu *cu, struct
 	if (add_child_llvm_annotations(die, -1, conf, &tdef->namespace.annots))
 		return NULL;
 
+	if (add_child_btf_type_tags(die, cu, &tdef->namespace.tag, conf))
+		return NULL;
+
 	return &tdef->namespace.tag;
 }
 
-static struct tag *die__create_new_array(Dwarf_Die *die, struct cu *cu)
+static struct tag *die__create_new_array(Dwarf_Die *die, struct cu *cu, struct conf_load *conf)
 {
+	struct type_tags_writer ttw;
 	Dwarf_Die child;
 	/* "64 dimensions will be enough for everybody." acme, 2006 */
 	const uint8_t max_dimensions = 64;
@@ -1645,19 +1697,29 @@ static struct tag *die__create_new_array(Dwarf_Die *die, struct cu *cu)
 	if (!dwarf_haschildren(die) || dwarf_child(die, &child) != 0)
 		return &array->tag;
 
+	type_tags_writer__init(&ttw, cu->priv, &array->tag);
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
+				goto _break_loop;
 			}
-		} else
+			break;
+		case DW_TAG_LLVM_annotation:
+			if (add_btf_type_tag(&ttw, die, conf))
+				goto out_free;
+			break;
+		default:
 			cu__tag_not_handled(die);
+			break;
+		}
 	} while (dwarf_siblingof(die, die) == 0);
+_break_loop:
 
 	array->nr_entries = memdup(nr_entries,
 				   array->dimensions * sizeof(uint32_t), cu);
@@ -1754,6 +1816,7 @@ static struct tag *die__create_new_constant(Dwarf_Die *die, struct cu *cu, struc
 static struct tag *die__create_new_subroutine_type(Dwarf_Die *die,
 						   struct cu *cu, struct conf_load *conf)
 {
+	struct type_tags_writer ttw;
 	Dwarf_Die child;
 	struct ftype *ftype = ftype__new(die, cu);
 	struct tag *tag;
@@ -1764,6 +1827,7 @@ static struct tag *die__create_new_subroutine_type(Dwarf_Die *die,
 	if (!dwarf_haschildren(die) || dwarf_child(die, &child) != 0)
 		goto out;
 
+	type_tags_writer__init(&ttw, cu->priv, &ftype->tag);
 	die = &child;
 	do {
 		uint32_t id;
@@ -1778,6 +1842,10 @@ static struct tag *die__create_new_subroutine_type(Dwarf_Die *die,
 		case DW_TAG_unspecified_parameters:
 			ftype->unspec_parms = 1;
 			continue;
+		case DW_TAG_LLVM_annotation:
+			if (add_btf_type_tag(&ttw, die, conf))
+				goto out_delete;
+			continue;
 		default:
 			tag = die__process_tag(die, cu, 0, conf);
 			if (tag == NULL)
@@ -1817,6 +1885,7 @@ static struct tag *die__create_new_enumeration(Dwarf_Die *die, struct cu *cu, st
 {
 	Dwarf_Die child;
 	struct type *enumeration = type__new(die, cu, conf);
+	struct type_tags_writer ttw;
 
 	if (enumeration == NULL)
 		return NULL;
@@ -1832,19 +1901,27 @@ static struct tag *die__create_new_enumeration(Dwarf_Die *die, struct cu *cu, st
 		goto out;
 	}
 
+	type_tags_writer__init(&ttw, cu->priv, &enumeration->namespace.tag);
 	die = &child;
 	do {
 		struct enumerator *enumerator;
 
-		if (dwarf_tag(die) != DW_TAG_enumerator) {
+		switch (dwarf_tag(die)) {
+		case DW_TAG_enumerator:
+			enumerator = enumerator__new(die, cu, conf);
+			if (enumerator == NULL)
+				goto out_delete;
+
+			enumeration__add(enumeration, enumerator);
+			break;
+		case DW_TAG_LLVM_annotation:
+			if (add_btf_type_tag(&ttw, die, conf))
+				goto out_delete;
+			break;
+		default:
 			cu__tag_not_handled(die);
-			continue;
+			break;
 		}
-		enumerator = enumerator__new(die, cu, conf);
-		if (enumerator == NULL)
-			goto out_delete;
-
-		enumeration__add(enumeration, enumerator);
 	} while (dwarf_siblingof(die, die) == 0);
 out:
 	return &enumeration->namespace.tag;
@@ -1857,8 +1934,10 @@ static int die__process_class(Dwarf_Die *die, struct type *class,
 			      struct cu *cu, struct conf_load *conf)
 {
 	const bool is_union = tag__is_union(&class->namespace.tag);
+	struct type_tags_writer ttw;
 	int member_idx = 0;
 
+	type_tags_writer__init(&ttw, cu->priv, &class->namespace.tag);
 	do {
 		switch (dwarf_tag(die)) {
 		case DW_TAG_subrange_type: // XXX: ADA stuff, its a type tho, will have other entries referencing it...
@@ -1906,6 +1985,8 @@ static int die__process_class(Dwarf_Die *die, struct type *class,
 		}
 			continue;
 		case DW_TAG_LLVM_annotation:
+			if (add_btf_type_tag(&ttw, die, conf))
+				return -ENOMEM;
 			if (add_llvm_annotation(die, -1, conf, &class->namespace.annots))
 				return -ENOMEM;
 			continue;
@@ -2243,7 +2324,7 @@ static struct tag *__die__process_tag(Dwarf_Die *die, struct cu *cu,
 	case DW_TAG_imported_unit:
 		return NULL; // We don't support imported units yet, so to avoid segfaults
 	case DW_TAG_array_type:
-		tag = die__create_new_array(die, cu);		break;
+		tag = die__create_new_array(die, cu, conf);	break;
 	case DW_TAG_string_type: // FORTRAN stuff, looks like an array
 		tag = die__create_new_string_type(die, cu);	break;
 	case DW_TAG_base_type:
@@ -2866,11 +2947,20 @@ static struct btf_type_tag_type *new_btf_type_tag_type(struct cu *cu,
  *
  *   tag3 -> tag2 -> tag1
  *
- * And complete the chain as follows for each type tag group:
+ * And for kind == TYPE_TAG_POINTEE complete the chain as follows for
+ * each type tag group:
  *
  *   '*' -> tag3 -> tag2 -> tag1 -> int
+ *
+ * For kind == TYPE_TAG_SELF the tag1..3 would be applied to `int`
+ * entry itself, thus complete the chain as below:
+ *
+ *   tag3 -> tag2 -> tag1 -> int
+ *
+ * And do cu__hash_impersonate(cu, int, tag3), so that each lookup of
+ * `int` by Dwarf_Off would return `tag3`.
  */
-static int dwarf_cu__recode_type_tags(struct cu *cu)
+static int dwarf_cu__recode_type_tags(struct cu *cu, enum type_tag_kind target_kind)
 {
 	struct dwarf_cu *dcu = cu->priv;
 	void **entries = dcu->type_tags.entries;
@@ -2885,12 +2975,18 @@ static int dwarf_cu__recode_type_tags(struct cu *cu)
 		struct btf_type_tag_type *prev = NULL;
 
 		while (i < N) {
-			const char *value = entries[i++];
+			const char *value;
+			uintptr_t kind;
 			uint32_t id;
 
-			if (value == NULL)
+			value = entries[i++];
+			if (value == NULL || i >= N)
 				break;
 
+			kind = (uintptr_t)entries[i++];
+			if (kind != target_kind)
+				continue;
+
 			last = new_btf_type_tag_type(cu, value);
 			if (last == NULL)
 				return -ENOMEM;
@@ -2912,15 +3008,34 @@ static int dwarf_cu__recode_type_tags(struct cu *cu)
 		if (first == NULL)
 			continue;
 
-		/* Type tags are recoded *after* main recode phase,
-		 * so parent->type is valid.
-		 *
-		 * parent   last           first  parent->type
-		 *    |      |               |       |
-		 *   '*' -> tag3 -> tag2 -> tag1 -> int
-		 */
-		first->tag.type = parent->type;
-		parent->type = tag__small_id(&last->tag);
+		switch (target_kind) {
+		case TYPE_TAG_POINTEE:
+			/* For POINTEE type tags are recoded *after*
+			 * main recode phase, so parent->type is valid.
+			 *
+			 * parent   last           first  parent->type
+			 *    |      |               |       |
+			 *   '*' -> tag3 -> tag2 -> tag1 -> int
+			 */
+			first->tag.type = parent->type;
+			parent->type = tag__small_id(&last->tag);
+			break;
+		case TYPE_TAG_SELF:
+			/* For SELF type tags are recoded *before*
+			 * main recode phase, so dcu->hash_types
+			 * changes would be visible during that phase.
+			 *
+			 * last            first   parent
+			 *   |               |       |
+			 *  tag3 -> tag2 -> tag1 -> int
+			 *   ^                       |
+			 *   '-----------------------'
+			 *   copy parent->tag.priv->id
+			 */
+			first->tag.type = tag__small_id(parent);
+			cu__hash_impersonate(cu, parent, &last->tag);
+			break;
+		}
 	}
 
 	return 0;
@@ -2928,11 +3043,21 @@ static int dwarf_cu__recode_type_tags(struct cu *cu)
 
 static int cu__recode_dwarf_types(struct cu *cu)
 {
+	struct dwarf_cu *dcu = cu->priv;
+
+	if (dcu->effective_type_tag_kind == TYPE_TAG_SELF &&
+	    dwarf_cu__recode_type_tags(cu, TYPE_TAG_SELF) != 0)
+		return -1;
+
 	if (cu__recode_dwarf_types_table(cu, &cu->types_table, 1) ||
 	    cu__recode_dwarf_types_table(cu, &cu->tags_table, 0) ||
 	    cu__recode_dwarf_types_table(cu, &cu->functions_table, 0))
 		return -1;
-	dwarf_cu__recode_type_tags(cu);
+
+	if (dcu->effective_type_tag_kind == TYPE_TAG_POINTEE &&
+	    dwarf_cu__recode_type_tags(cu, TYPE_TAG_POINTEE) != 0)
+		return -1;
+
 	return 0;
 }
 
-- 
2.40.1


