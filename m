Return-Path: <bpf+bounces-1137-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4429470EA29
	for <lists+bpf@lfdr.de>; Wed, 24 May 2023 02:19:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F23391C20A57
	for <lists+bpf@lfdr.de>; Wed, 24 May 2023 00:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19C8F1389;
	Wed, 24 May 2023 00:19:11 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B441365
	for <bpf@vger.kernel.org>; Wed, 24 May 2023 00:19:10 +0000 (UTC)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE193B5;
	Tue, 23 May 2023 17:19:07 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4effb818c37so152557e87.3;
        Tue, 23 May 2023 17:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684887546; x=1687479546;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ShkZDOwjFhui9KktAQhk4FKg0jH1aQvj5B0BaG+eGdI=;
        b=McYnuMYcj+hWQWm0tHteJsPc5lUv0rRG2QoQVJnHiTtK7tgGQk9O1VO6AC6CZHxpSW
         F7ePd8n7WUE5AjLhJDHVeBbvdiczKhZ48pZto8s9cEbRhiNR/GDsYg9o+J7D0+gIYj8I
         If9QuWBfDqVazoQSBdaRdDp9YAmh5nj5wT8KV+CRl+ya/y5TasCbKzP/3xD/BsvuGE2u
         /t9ywm1w8LZ/3jKvfTYEUcKxvWkupaIa+XbG+tBd3QTCjgKUrnJYeglK1sqYMWoC8Djb
         bR8p+qPMqikjpJ+XlYzE2e2+QeCfTlzRGJy9oJ0wR5eBYxAfjqn76N+ckioObZGfze3c
         vsrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684887546; x=1687479546;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ShkZDOwjFhui9KktAQhk4FKg0jH1aQvj5B0BaG+eGdI=;
        b=Xfz4Ak1ZSB+9bSQQGTx4g6O1rlBy8k+q+INB2lTXopQ00xV4DYkXxQLFFAkt6MeOUq
         nKvDQCqGXay+EyPd/pp9Vd2uKU5YA+1X76u4bKgcsnZkFK/SNURIfHrQGvxj2b6dDn3u
         ExfEGHzOfaavg9bdNdbUoElWQ++vEdUuhizMMS7viVNnaGKSNCmfCKxcz1CP2WS4uu5A
         p+4+yxMSuOYIpbeCPzS2f3We7RMNSIXR3vzW53Ju6R03EQ4NoiNLA5yL/9VijOsGCQOJ
         c/PuM9SWQPO/BCjrtL8vh27oKR7frczPH/U6nyBr7xQh+XGTKHFXkRkjS6iEhYRPCCNk
         jGwQ==
X-Gm-Message-State: AC+VfDwT5IizxbimH37ZWW9v3BVKSaZDw1a30tsgIFLL02KqrcIgHRFD
	g5dOfpdToHvKXohxuJFXEJF2lMF413Hmkg==
X-Google-Smtp-Source: ACHHUZ4c6AH7ootxuvVClEbsiuQd0ww5t0EwED6ktTWlOMZacAZU4W5vrrGwaYXZdjhCVNxozU6vxA==
X-Received: by 2002:a05:6512:962:b0:4f1:43ad:7fac with SMTP id v2-20020a056512096200b004f143ad7facmr4564476lft.17.1684887545819;
        Tue, 23 May 2023 17:19:05 -0700 (PDT)
Received: from bigfoot.. (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id w7-20020a19c507000000b004f138ab93c7sm1487305lfe.264.2023.05.23.17.19.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 17:19:05 -0700 (PDT)
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
Subject: [PATCH v3 dwarves 3/6] dwarf_loader: handle btf_type_tag w/o special pointer type
Date: Wed, 24 May 2023 03:18:22 +0300
Message-Id: <20230524001825.2688661-4-eddyz87@gmail.com>
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

Currently BTF type tags could only be associated with "pointee" types.
(Types pointed to by some pointer). This is an artifact of type tags
encoding in DWARF. For example, for the following C code:

  int __attribute__((type_tag("tag"))) *p;

Clang produces the following DWARF:

  0x51:   DW_TAG_pointer_type
            DW_AT_type  (0x4d "int")

  0x56:     DW_TAG_LLVM_annotation
              DW_AT_name        ("btf_type_tag")
              DW_AT_const_value ("tag")

The assumption is that such DW_TAG_LLVM_annotation entries are only
attached to DW_TAG_pointer_type entries and apply to the pointee type
(0x4d "int" in this case).

This is handled by dwarf_loader using a special pointer sub-type:
`struct btf_type_tag_ptr_type`, which adds a list of type tags to
a regular pointer and has additional processing on the recode phase.

However, recent discussion [1] agreed to introduce a new kind of type
tags encoding in DWARF, allowing to associate such tags with any
types, not only pointee types.

As a preparation step to handle such encoding this commit removes
`struct btf_type_tag_ptr_type`, instead information about a set of
type tags associated with a pointer is stored in a new
`struct dwarf_cu` field:

  struct dwarf_cu {
        ...
        struct type_tags_table type_tags;
        ...
  }

Creation of `struct btf_type_tag_ptr_type` is delayed until all CU
members are scanned. To avoid second scan the `type_tags` field is
used to accumulate information necessary for type tag creation.
For each DIE with type tag children this information includes:
- struct tag corresponding to this DIE
- list of type tag values attached to DIE

Which means that each record varies in size. To accommodate this
treat `struct dwarf_cu::type_tags` as a stream of records with the
following format:

  ... parent-pointer tag-value* NULL ...
         ^               ^       ^
         |               |       '----- terminator
      struct tag*      char*

This information is used on the recode phase to establish correct
`struct tag::type` links.

Delayed creation of type tag objects would be exploited in the
follow-up patch.

[1] Mailing list discussion regarding `btf:type_tag`
    Various approaches are discussed, Solution #2 is accepted
    https://lore.kernel.org/bpf/87r0w9jjoq.fsf@oracle.com/

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 dwarf_loader.c | 350 ++++++++++++++++++++++++++++++++-----------------
 dwarves.h      |  19 ---
 2 files changed, 230 insertions(+), 139 deletions(-)

diff --git a/dwarf_loader.c b/dwarf_loader.c
index dfed334..3670493 100644
--- a/dwarf_loader.c
+++ b/dwarf_loader.c
@@ -120,6 +120,8 @@ static void dwarf_tag__set_spec(struct dwarf_tag *dtag, dwarf_off_ref spec)
 struct dwarf_cu {
 	struct hlist_head *hash_tags;
 	struct hlist_head *hash_types;
+	/* See comment at add_btf_type_tag() */
+	struct ptr_table type_tags;
 	struct dwarf_tag *last_type_lookup;
 	struct cu *cu;
 	struct dwarf_cu *type_unit;
@@ -150,6 +152,7 @@ static int dwarf_cu__init(struct dwarf_cu *dcu, struct cu *cu)
 	dcu->type_unit = NULL;
 	// To avoid a per-lookup check against NULL in dwarf_cu__find_type_by_ref()
 	dcu->last_type_lookup = &sentinel_dtag;
+	ptr_table__init(&dcu->type_tags);
 	return 0;
 }
 
@@ -175,6 +178,7 @@ static void dwarf_cu__delete(struct cu *cu)
 	struct dwarf_cu *dcu = cu->priv;
 	struct list_head *pos, *n;
 
+	ptr_table__exit(&dcu->type_tags);
 	// dcu->hash_tags & dcu->hash_types are on cu->obstack
 	list_for_each_safe(pos, n, &cu->unspecified_types)
 		unspecified_type__delete(cu, container_of(pos, struct unspecified_type, node));
@@ -526,6 +530,12 @@ static void tag__init(struct tag *tag, struct cu *cu, Dwarf_Die *die)
 	INIT_LIST_HEAD(&tag->node);
 }
 
+static void tag__init_dummy(struct tag *tag, struct cu *cu, int tag_code)
+{
+	tag->tag = tag_code;
+	INIT_LIST_HEAD(&tag->node);
+}
+
 static struct tag *tag__new(Dwarf_Die *die, struct cu *cu)
 {
 	struct tag *tag = tag__alloc(cu, sizeof(*tag));
@@ -894,6 +904,11 @@ static int tag__recode_dwarf_bitfield(struct tag *tag, struct cu *cu, uint16_t b
 	return -ENOMEM;
 }
 
+static uint32_t tag__small_id(struct tag *tag)
+{
+	return ((struct dwarf_tag *)tag->priv)->small_id;
+}
+
 static int add_llvm_annotation(Dwarf_Die *die, int component_idx, struct conf_load *conf,
 			       struct list_head *head)
 {
@@ -939,6 +954,97 @@ static int add_child_llvm_annotations(Dwarf_Die *die, int component_idx,
 	return 0;
 }
 
+struct type_tags_writer {
+	struct dwarf_cu *dcu;
+	struct tag *parent;
+	bool started;
+};
+
+static void type_tags_writer__init(struct type_tags_writer *writer,
+				   struct dwarf_cu *dcu,
+				   struct tag *parent)
+{
+	writer->dcu = dcu;
+	writer->parent = parent;
+	writer->started = false;
+}
+
+/* It is necessary to delay type tag objects creation until all other
+ * CU members are scanned. To avoid a second scan the `type_tags`
+ * field is used to accumulate information necessary for type tag creation.
+ * For each DIE with type tag children this information includes:
+ * - struct tag corresponding to this DIE
+ * - list of type tag values attached to DIE
+ *
+ * Which means that each record varies in size. To accommodate this
+ * treat `writer->dcu->type_tags` as a stream of records with the
+ * following format:
+ *
+ *   ... parent-pointer tag-value* NULL ...
+ *          ^               ^       ^
+ *          |               |       '----- terminator
+ *       struct tag*      char*
+ */
+static int add_btf_type_tag(struct type_tags_writer *writer, Dwarf_Die *die,
+			    struct conf_load *conf)
+{
+	struct ptr_table *type_tags = &writer->dcu->type_tags;
+	const char *name, *value;
+	uint32_t ignored;
+	int ret = 0;
+
+	if (conf->skip_encoding_btf_type_tag)
+		return 0;
+
+	name = attr_string(die, DW_AT_name, conf);
+	if (strcmp(name, "btf_type_tag") != 0)
+		return 0;
+
+	value = attr_string(die, DW_AT_const_value, conf);
+
+	if (!writer->started) {
+		writer->started = true;
+		/* Terminate previous record */
+		if (type_tags->nr_entries != 0) {
+			ret = ptr_table__add(type_tags, NULL, &ignored);
+			if (ret)
+				return ret;
+		}
+		/* Start new record by saving parent pointer */
+		ret = ptr_table__add(type_tags, writer->parent, &ignored);
+		if (ret)
+			return ret;
+	}
+
+	return ptr_table__add(type_tags, (void *)value, &ignored);
+}
+
+/* Collect all type tag values attached to `parent` and save those in
+ * dwarf_cu::type_tags stream.
+ * See add_btf_type_tag() for stream encoding details.
+ * See dwarf_cu__recode_type_tags() for type tag processing details.
+ */
+static int add_child_btf_type_tags(Dwarf_Die *die, struct cu *cu,
+				   struct tag *parent, struct conf_load *conf)
+{
+	struct type_tags_writer ttw;
+	Dwarf_Die *cdie, child;
+	int ret;
+
+	if (!dwarf_haschildren(die) || dwarf_child(die, &child) != 0)
+		return 0;
+
+	type_tags_writer__init(&ttw, cu->priv, parent);
+	cdie = &child;
+	do {
+		ret = add_btf_type_tag(&ttw, cdie, conf);
+		if (ret)
+			return ret;
+	} while (dwarf_siblingof(cdie, cdie) == 0);
+
+	return 0;
+}
+
 int class_member__dwarf_recode_bitfield(struct class_member *member,
 					struct cu *cu)
 {
@@ -1418,89 +1524,21 @@ static void unspecified_type__delete(struct cu *cu, struct unspecified_type *uty
 	cu__free(cu, utype);
 }
 
-static struct btf_type_tag_ptr_type *die__create_new_btf_type_tag_ptr_type(Dwarf_Die *die, struct cu *cu)
+static struct tag *die__create_new_pointer_tag(Dwarf_Die *die, struct cu *cu,
+					       struct conf_load *conf)
 {
-	struct btf_type_tag_ptr_type *tag;
+	struct tag *tag;
 
-	tag  = tag__alloc_with_spec(cu, sizeof(struct btf_type_tag_ptr_type));
+	tag = tag__new(die, cu);
 	if (tag == NULL)
 		return NULL;
 
-	tag__init(&tag->tag, cu, die);
-	tag->tag.has_btf_type_tag = true;
-	INIT_LIST_HEAD(&tag->tags);
-	return tag;
-}
-
-static struct btf_type_tag_type *die__create_new_btf_type_tag_type(Dwarf_Die *die, struct cu *cu,
-								   struct conf_load *conf)
-{
-	struct btf_type_tag_type *tag;
-
-	tag  = tag__alloc_with_spec(cu, sizeof(struct btf_type_tag_type));
-	if (tag == NULL)
+	if (add_child_btf_type_tags(die, cu, tag, conf))
 		return NULL;
 
-	tag__init(&tag->tag, cu, die);
-	tag->value = attr_string(die, DW_AT_const_value, conf);
 	return tag;
 }
 
-static struct tag *die__create_new_pointer_tag(Dwarf_Die *die, struct cu *cu,
-					       struct conf_load *conf)
-{
-	struct btf_type_tag_ptr_type *tag = NULL;
-	struct btf_type_tag_type *annot;
-	Dwarf_Die *cdie, child;
-	const char *name;
-	uint32_t id;
-
-	/* If no child tags or skipping btf_type_tag encoding, just create a new tag
-	 * and return
-	 */
-	if (!dwarf_haschildren(die) || dwarf_child(die, &child) != 0 ||
-	    conf->skip_encoding_btf_type_tag)
-		return tag__new(die, cu);
-
-	/* Otherwise, check DW_TAG_LLVM_annotation child tags */
-	cdie = &child;
-	do {
-		if (dwarf_tag(cdie) != DW_TAG_LLVM_annotation)
-			continue;
-
-		/* Only check btf_type_tag annotations */
-		name = attr_string(cdie, DW_AT_name, conf);
-		if (strcmp(name, "btf_type_tag") != 0)
-			continue;
-
-		if (tag == NULL) {
-			/* Create a btf_type_tag_ptr type. */
-			tag = die__create_new_btf_type_tag_ptr_type(die, cu);
-			if (!tag)
-				return NULL;
-		}
-
-		/* Create a btf_type_tag type for this annotation. */
-		annot = die__create_new_btf_type_tag_type(cdie, cu, conf);
-		if (annot == NULL)
-			return NULL;
-
-		if (cu__table_add_tag(cu, &annot->tag, &id) < 0)
-			return NULL;
-
-		struct dwarf_tag *dtag = annot->tag.priv;
-		dtag->small_id = id;
-		cu__hash(cu, &annot->tag);
-
-		/* For a list of DW_TAG_LLVM_annotation like tag1 -> tag2 -> tag3,
-		 * the tag->tags contains tag3 -> tag2 -> tag1.
-		 */
-		list_add(&annot->node, &tag->tags);
-	} while (dwarf_siblingof(cdie, cdie) == 0);
-
-	return tag ? &tag->tag : tag__new(die, cu);
-}
-
 static struct tag *die__create_new_ptr_to_member_type(Dwarf_Die *die,
 						      struct cu *cu)
 {
@@ -2551,45 +2589,6 @@ static void lexblock__recode_dwarf_types(struct lexblock *tag, struct cu *cu)
 	}
 }
 
-static void dwarf_cu__recode_btf_type_tag_ptr(struct btf_type_tag_ptr_type *tag,
-					      uint32_t pointee_type)
-{
-	struct btf_type_tag_type *annot;
-	struct dwarf_tag *annot_dtag;
-	struct tag *prev_tag;
-
-	/* Given source like
-	 *   int tag1 tag2 tag3 *p;
-	 * the tag->tags contains tag3 -> tag2 -> tag1, the final type chain looks like:
-	 *   pointer -> tag3 -> tag2 -> tag1 -> pointee
-	 *
-	 * Basically it means
-	 *   - '*' applies to "int tag1 tag2 tag3"
-	 *   - tag3 applies to "int tag1 tag2"
-	 *   - tag2 applies to "int tag1"
-	 *   - tag1 applies to "int"
-	 *
-	 * This also makes final source code (format c) easier as we can do
-	 *   emit for "tag3 -> tag2 -> tag1 -> int"
-	 *   emit '*'
-	 *
-	 * For 'tag3 -> tag2 -> tag1 -> int":
-	 *   emit for "tag2 -> tag1 -> int"
-	 *   emit tag3
-	 *
-	 * Eventually we can get the source code like
-	 *   int tag1 tag2 tag3 *p;
-	 * and this matches the user/kernel code.
-	 */
-	prev_tag = &tag->tag;
-	list_for_each_entry(annot, &tag->tags, node) {
-		annot_dtag = annot->tag.priv;
-		prev_tag->type = annot_dtag->small_id;
-		prev_tag = &annot->tag;
-	}
-	prev_tag->type = pointee_type;
-}
-
 static int tag__recode_dwarf_type(struct tag *tag, struct cu *cu)
 {
 	struct dwarf_tag *dtag = tag->priv;
@@ -2681,6 +2680,10 @@ static int tag__recode_dwarf_type(struct tag *tag, struct cu *cu)
 		if (dtype != NULL)
 			goto out;
 		goto find_type;
+
+	case DW_TAG_LLVM_annotation:
+		return 0;
+
 	case DW_TAG_variable: {
 		struct variable *var = tag__variable(tag);
 
@@ -2699,10 +2702,7 @@ static int tag__recode_dwarf_type(struct tag *tag, struct cu *cu)
 	}
 
 	if (dtag->type.off == 0) {
-		if (tag->tag != DW_TAG_pointer_type || !tag->has_btf_type_tag)
-			tag->type = 0; /* void */
-		else
-			dwarf_cu__recode_btf_type_tag_ptr(tag__btf_type_tag_ptr(tag), 0);
+		tag->type = 0; /* void */
 		return 0;
 	}
 
@@ -2714,10 +2714,7 @@ check_type:
 		return 0;
 	}
 out:
-	if (tag->tag != DW_TAG_pointer_type || !tag->has_btf_type_tag)
-		tag->type = dtype->small_id;
-	else
-		dwarf_cu__recode_btf_type_tag_ptr(tag__btf_type_tag_ptr(tag), dtype->small_id);
+	tag->type = dtype->small_id;
 
 	return 0;
 }
@@ -2817,12 +2814,125 @@ static int cu__recode_dwarf_types_table(struct cu *cu,
 	return 0;
 }
 
+static struct btf_type_tag_type *new_btf_type_tag_type(struct cu *cu,
+						       const char *value)
+{
+	struct btf_type_tag_type *tag;
+
+	tag  = tag__alloc_with_spec(cu, sizeof(struct btf_type_tag_type));
+	if (tag == NULL)
+		return NULL;
+
+	tag__init_dummy(&tag->tag, cu, DW_TAG_LLVM_annotation);
+	tag->value = value;
+	return tag;
+}
+
+/* Consider the following C code:
+ *
+ *   int __tag1 __tag2 __tag3 *p;
+ *
+ * According to C types "parsing" rules such definitions are
+ * read from right to left:
+ *  - '*' applies to "int tag1 tag2 tag3"
+ *  - tag3 applies to "int tag1 tag2"
+ *  - tag2 applies to "int tag1"
+ *  - tag1 applies to "int"
+ *
+ * Consequently, in BTF it should be represented as follows:
+ *
+ *   '*' -> tag3 -> tag2 -> tag1 -> int
+ *
+ * We want to reflect the same structure using dwarves structures.
+ * Clang generates the following DWARF:
+ *
+ *   DW_TAG_pointer_type
+ *     DW_AT_type:            "int"
+ *
+ *     DW_TAG_LLVM_annotation
+ *       DW_AT_name:          "btf_type_tag"
+ *       DW_AT_const_value    "tag1"
+ *
+ *     DW_TAG_LLVM_annotation
+ *       DW_AT_name           "btf_type_tag"
+ *       DW_AT_const_value    "tag2"
+ *
+ *     DW_TAG_LLVM_annotation
+ *       DW_AT_name           "btf_type_tag"
+ *       DW_AT_const_value    "tag3"
+ *
+ * Here we create one instance of `struct btf_type_tag_type` for each
+ * tag and link those in reverse order:
+ *
+ *   tag3 -> tag2 -> tag1
+ *
+ * And complete the chain as follows for each type tag group:
+ *
+ *   '*' -> tag3 -> tag2 -> tag1 -> int
+ */
+static int dwarf_cu__recode_type_tags(struct cu *cu)
+{
+	struct dwarf_cu *dcu = cu->priv;
+	void **entries = dcu->type_tags.entries;
+	unsigned int N = dcu->type_tags.nr_entries;
+	unsigned int i = 0;
+
+	/* See add_btf_type_tag() for record format description */
+	while (i < N) {
+		struct tag *parent = entries[i++];
+		struct btf_type_tag_type *first = NULL;
+		struct btf_type_tag_type *last = NULL;
+		struct btf_type_tag_type *prev = NULL;
+
+		while (i < N) {
+			const char *value = entries[i++];
+			uint32_t id;
+
+			if (value == NULL)
+				break;
+
+			last = new_btf_type_tag_type(cu, value);
+			if (last == NULL)
+				return -ENOMEM;
+
+			if (first == NULL)
+				first = last;
+
+			if (cu__table_add_tag(cu, &last->tag, &id) < 0)
+				return -ENOMEM;
+
+			struct dwarf_tag *dtag = last->tag.priv;
+			dtag->small_id = id;
+			/* Link `prev` and `last` in reverse order */
+			if (prev)
+				last->tag.type = tag__small_id(&prev->tag);
+			prev = last;
+		}
+
+		if (first == NULL)
+			continue;
+
+		/* Type tags are recoded *after* main recode phase,
+		 * so parent->type is valid.
+		 *
+		 * parent   last           first  parent->type
+		 *    |      |               |       |
+		 *   '*' -> tag3 -> tag2 -> tag1 -> int
+		 */
+		first->tag.type = parent->type;
+		parent->type = tag__small_id(&last->tag);
+	}
+
+	return 0;
+}
+
 static int cu__recode_dwarf_types(struct cu *cu)
 {
 	if (cu__recode_dwarf_types_table(cu, &cu->types_table, 1) ||
 	    cu__recode_dwarf_types_table(cu, &cu->tags_table, 0) ||
 	    cu__recode_dwarf_types_table(cu, &cu->functions_table, 0))
 		return -1;
+	dwarf_cu__recode_type_tags(cu);
 	return 0;
 }
 
diff --git a/dwarves.h b/dwarves.h
index 509ffbc..22b0a40 100644
--- a/dwarves.h
+++ b/dwarves.h
@@ -446,7 +446,6 @@ struct tag {
 	uint16_t	 tag;
 	bool		 visited;
 	bool		 top_level;
-	bool		 has_btf_type_tag;
 	uint16_t	 recursivity_level;
 	void		 *priv;
 };
@@ -658,30 +657,12 @@ struct llvm_annotation {
  *
  * @tag   - DW_TAG_LLVM_annotation tag
  * @value - btf_type_tag value string
- * @node  - list_head node
  */
 struct btf_type_tag_type {
 	struct tag		tag;
 	const char		*value;
-	struct list_head	node;
 };
 
-/** The struct btf_type_tag_ptr_type - type containing both pointer type and
- *  its btf_type_tag annotations
- *
- * @tag  - pointer type tag
- * @tags - btf_type_tag annotations for the pointer type
- */
-struct btf_type_tag_ptr_type {
-	struct tag		tag;
-	struct list_head 	tags;
-};
-
-static inline struct btf_type_tag_ptr_type *tag__btf_type_tag_ptr(struct tag *tag)
-{
-	return (struct btf_type_tag_ptr_type *)tag;
-}
-
 static inline struct btf_type_tag_type *tag__btf_type_tag(struct tag *tag)
 {
 	return (struct btf_type_tag_type *)tag;
-- 
2.40.1


