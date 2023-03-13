Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 885446B6D67
	for <lists+bpf@lfdr.de>; Mon, 13 Mar 2023 03:18:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbjCMCSH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 12 Mar 2023 22:18:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbjCMCSG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 12 Mar 2023 22:18:06 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08B3759FA;
        Sun, 12 Mar 2023 19:18:01 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id d36so13822718lfv.8;
        Sun, 12 Mar 2023 19:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678673879;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UUussUWvIGLEkRZN2w2Zklat/FbWbiwhmfh9VFqQh8A=;
        b=jrzghEAqcOjlfX6U2UUE8uQUVFPFrFRQyOYqTuzXUfL718jOc7gJphtPvMk6PfPk0M
         BSJSyFkFUjr6MVvQ2LZYlDDM2VltdlCs1eLepPaVkIiYyNjTJTwY3D4V3h27ZFhZhnaK
         azPVpVx6M4Ajk40hCw41YEDcvSHtOT4EMZ7bUUyed6plccZStyzL3QLjAxfFx+uUKOru
         wHFMgdlAQ1MPDuRf41keOT+Azmlq9SJu9W97KUg9Jysr/WdINjmI99p8rEdEctLZ0FIg
         X1Hnj28V/6cOH5fGuC30XpK9JMH0RsfdbzZbySOrmSRnPM6faQdUh26SsN/pG8+HhyY8
         7VvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678673879;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UUussUWvIGLEkRZN2w2Zklat/FbWbiwhmfh9VFqQh8A=;
        b=2etDSp2h7pY8QYVGrdwkB1oGFWaPJCYHb/LBFBwoAQ7otsZpu/fz9MBr637b6gT3Ca
         q/KiKH1zGotzSA2l62ilBj7Y+4BGw9lVF57MNkoeMfWQY97UC+uI9Eu0/s2Ya/5uWgig
         FR11Grobe7F2yc+X07XaXMVsjGklMp1u4c7GH7Z0artYdVEBxChMsXfRk+eYqC3E4lDe
         3qZMxe/dC4gM96iVWOJOUtb+99wkKev62EezULtmXHDv67lgBOG8nNIkOgIsMxC7krQR
         qfjh7JBZWpxjQ8HQjFEkwFPEDSgdDFgQk1TVhkp3GwCgnz/iV4ruo6t2W9UpBNUKxnRN
         CczA==
X-Gm-Message-State: AO0yUKXjRuX3vEsIIJvj1US3qYV1Pckr5Ru+ayfg7YNIP0JYe3QhviQa
        XJE073WCXJ7a79tSBZnksoOsHeXOoQSNuZiR
X-Google-Smtp-Source: AK7set9WlTuxXuEO1ztsdonH0RMt4wBiX917oMUvI9VhoKe+HECNBSg1FjTVVKD1ixOCHi6I7RB8ng==
X-Received: by 2002:ac2:5498:0:b0:4da:fb89:fcc6 with SMTP id t24-20020ac25498000000b004dafb89fcc6mr9188868lfk.57.1678673878514;
        Sun, 12 Mar 2023 19:17:58 -0700 (PDT)
Received: from bigfoot.. (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id h17-20020ac25971000000b004dc4c5149cfsm802103lfp.134.2023.03.12.19.17.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 19:17:57 -0700 (PDT)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     dwarves@vger.kernel.org, arnaldo.melo@gmail.com
Cc:     bpf@vger.kernel.org, kernel-team@fb.com, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, yhs@fb.com,
        jose.marchesi@oracle.com, david.faust@oracle.com,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH dwarves 1/1] dwarf_loader: Support for btf:type_tag
Date:   Mon, 13 Mar 2023 04:17:44 +0200
Message-Id: <20230313021744.406197-2-eddyz87@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230313021744.406197-1-eddyz87@gmail.com>
References: <20230313021744.406197-1-eddyz87@gmail.com>
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

Void pointers with type tag annotations are represented as objects
of unspecified type with name "void", here is an example:

  struct st {
    void __attribute__((btf_type_tag("__d"))) *d;
  }

And corresponding DWARF:

  0x29:   DW_TAG_structure_type
            DW_AT_name      ("st")

  0x49:     DW_TAG_member
              DW_AT_name    ("d")
              DW_AT_type    (0xa6 "void *")

  0xa6:   DW_TAG_pointer_type
            DW_AT_type      (0xaf "void")

  0xaf:   DW_TAG_unspecified_type
            DW_AT_name      ("void")

  0xb1:     DW_TAG_LLVM_annotation
              DW_AT_name    ("btf:type_tag")
              DW_AT_const_value     ("__d")

This commit adds support for DW_TAG_LLVM_annotation "btf:type_tag"
attached to the following entities:
- base types;
- arrays;
- pointers;
- structs
- unions;
- enums;
- typedefs.

This is achieved via the following modifications:
- Types `struct btf_type_tag_type` and `struct llvm_annotation` are
  consolidated as a single type `struct llvm_annotation`, in order to
  reside in a single `annots` list associated with struct/union/enum
  or typedef.
- `struct unspecified_type` is added to handle `void *` types annotated
  with `btf:type_tag`.
- `struct tag` is extended with `annots` list.
- DWARF load phase is modified to fill `annots` fields for the above
  mentioned types.
- Recode phase is split in two sub-phases:
  - The existing `tag__recode_dwarf_type()` is executed first;
  - Newly added `update_btf_type_tag_refs()` is executed to update
    `->type` field of each tag if that type refers to an object with
    `btf:type_tag` annotation. The id of the type is replaced by id
    of the type tag.
- When `btf:type_tag` annotations are present in compilation unit,
  all `btf_type_tag` annotations are ignored during BTF dump.

See also:
[1] Mailing list discussion regarding `btf:type_tag`
    https://lore.kernel.org/bpf/87r0w9jjoq.fsf@oracle.com/

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 btf_encoder.c     |  13 +-
 btf_loader.c      |  15 +-
 dwarf_loader.c    | 763 +++++++++++++++++++++++++++++++++++++---------
 dwarves.c         |   1 +
 dwarves.h         |  68 +++--
 dwarves_fprintf.c |  13 +
 6 files changed, 693 insertions(+), 180 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index 07a9dc5..b74911b 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -899,6 +899,9 @@ static int32_t btf_encoder__add_func(struct btf_encoder *encoder, struct functio
 		return -1;
 	}
 	list_for_each_entry(annot, &fn->annots, node) {
+		if (annot->kind != BTF_DECL_TAG)
+			continue;
+
 		tag_type_id = btf_encoder__add_decl_tag(encoder, annot->value, btf_fn_id,
 							annot->component_idx);
 		if (tag_type_id < 0) {
@@ -1180,7 +1183,7 @@ static int btf_encoder__encode_tag(struct btf_encoder *encoder, struct tag *tag,
 		name = namespace__name(tag__namespace(tag));
 		return btf_encoder__add_ref_type(encoder, BTF_KIND_TYPEDEF, ref_type_id, name, false);
 	case DW_TAG_LLVM_annotation:
-		name = tag__btf_type_tag(tag)->value;
+		name = tag__llvm_annotation(tag)->value;
 		return btf_encoder__add_ref_type(encoder, BTF_KIND_TYPE_TAG, ref_type_id, name, false);
 	case DW_TAG_structure_type:
 	case DW_TAG_union_type:
@@ -1605,6 +1608,9 @@ static int btf_encoder__encode_cu_variables(struct btf_encoder *encoder)
 		}
 
 		list_for_each_entry(annot, &var->annots, node) {
+			if (annot->kind != BTF_DECL_TAG)
+				continue;
+
 			int tag_type_id = btf_encoder__add_decl_tag(encoder, annot->value, id, annot->component_idx);
 			if (tag_type_id < 0) {
 				fprintf(stderr, "error: failed to encode tag '%s' to variable '%s' with component_idx %d\n",
@@ -1798,7 +1804,10 @@ int btf_encoder__encode_cu(struct btf_encoder *encoder, struct cu *cu, struct co
 
 		btf_type_id = encoder->type_id_off + core_id;
 		ns = tag__namespace(pos);
-		list_for_each_entry(annot, &ns->annots, node) {
+		list_for_each_entry(annot, &ns->tag.annots, node) {
+			if (annot->kind != BTF_DECL_TAG)
+				continue;
+
 			tag_type_id = btf_encoder__add_decl_tag(encoder, annot->value, btf_type_id, annot->component_idx);
 			if (tag_type_id < 0) {
 				fprintf(stderr, "error: failed to encode tag '%s' to %s '%s' with component_idx %d\n",
diff --git a/btf_loader.c b/btf_loader.c
index e579323..3fe07d0 100644
--- a/btf_loader.c
+++ b/btf_loader.c
@@ -429,10 +429,11 @@ static int create_new_tag(struct cu *cu, int type, const struct btf_type *tp, ui
 		return -ENOMEM;
 
 	switch (type) {
-	case BTF_KIND_CONST:	tag->tag = DW_TAG_const_type;	 break;
-	case BTF_KIND_PTR:	tag->tag = DW_TAG_pointer_type;  break;
-	case BTF_KIND_RESTRICT:	tag->tag = DW_TAG_restrict_type; break;
-	case BTF_KIND_VOLATILE:	tag->tag = DW_TAG_volatile_type; break;
+	case BTF_KIND_CONST:	tag->tag = DW_TAG_const_type;	   break;
+	case BTF_KIND_PTR:	tag->tag = DW_TAG_pointer_type;    break;
+	case BTF_KIND_RESTRICT:	tag->tag = DW_TAG_restrict_type;   break;
+	case BTF_KIND_VOLATILE:	tag->tag = DW_TAG_volatile_type;   break;
+	case BTF_KIND_TYPE_TAG:	tag->tag = DW_TAG_LLVM_annotation; break;
 	default:
 		free(tag);
 		printf("%s: Unknown type %d\n\n", __func__, type);
@@ -489,6 +490,12 @@ static int btf__load_types(struct btf *btf, struct cu *cu)
 		case BTF_KIND_PTR:
 		case BTF_KIND_CONST:
 		case BTF_KIND_RESTRICT:
+		/* For type tag it's a bit of a lie.
+		 * In DWARF it is encoded as a child tag of whatever type it
+		 * applies to. Here we load it as a standalone tag with a pointer
+		 * to a next type only to have a valid ID in the types table.
+		 */
+		case BTF_KIND_TYPE_TAG:
 			err = create_new_tag(cu, type, type_ptr, type_index);
 			break;
 		case BTF_KIND_UNKN:
diff --git a/dwarf_loader.c b/dwarf_loader.c
index 4efa4e1..7846b94 100644
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
@@ -112,6 +142,17 @@ static dwarf_off_ref dwarf_tag__spec(struct dwarf_tag *dtag)
 	return *(dwarf_off_ref *)(dtag + 1);
 }
 
+#define cu__tag_not_handled(die) __cu__tag_not_handled(die, __FUNCTION__)
+
+static void __cu__tag_not_handled(Dwarf_Die *die, const char *fn)
+{
+	uint32_t tag = dwarf_tag(die);
+
+	fprintf(stderr, "%s: DW_TAG_%s (%#x) @ <%#llx> not handled!\n",
+		fn, dwarf_tag_name(tag), tag,
+		(unsigned long long)dwarf_dieoffset(die));
+}
+
 static void dwarf_tag__set_spec(struct dwarf_tag *dtag, dwarf_off_ref spec)
 {
 	*(dwarf_off_ref *)(dtag + 1) = spec;
@@ -165,14 +206,21 @@ static struct dwarf_cu *dwarf_cu__new(struct cu *cu)
 	return dwarf_cu;
 }
 
+static void unspecified_type__delete(struct cu *cu, struct unspecified_type *utype);
+
 static void dwarf_cu__delete(struct cu *cu)
 {
 	if (cu == NULL || cu->priv == NULL)
 		return;
 
 	struct dwarf_cu *dcu = cu->priv;
+	struct list_head *pos, *n;
 
 	// dcu->hash_tags & dcu->hash_types are on cu->obstack
+	cu__free(cu, dcu->hash_tags);
+	cu__free(cu, dcu->hash_types);
+	list_for_each_safe(pos, n, &cu->unspecified_types)
+		unspecified_type__delete(cu, container_of(pos, struct unspecified_type, node));
 	cu__free(cu, dcu);
 	cu->priv = NULL;
 }
@@ -519,6 +567,7 @@ static void tag__init(struct tag *tag, struct cu *cu, Dwarf_Die *die)
 	}
 
 	INIT_LIST_HEAD(&tag->node);
+	INIT_LIST_HEAD(&tag->annots);
 }
 
 static struct tag *tag__new(Dwarf_Die *die, struct cu *cu)
@@ -608,7 +657,6 @@ static void namespace__init(struct namespace *namespace, Dwarf_Die *die,
 {
 	tag__init(&namespace->tag, cu, die);
 	INIT_LIST_HEAD(&namespace->tags);
-	INIT_LIST_HEAD(&namespace->annots);
 	namespace->name  = attr_string(die, DW_AT_name, conf);
 	namespace->nr_tags = 0;
 	namespace->shared_tags = 0;
@@ -876,8 +924,40 @@ static int tag__recode_dwarf_bitfield(struct tag *tag, struct cu *cu, uint16_t b
 	return -ENOMEM;
 }
 
-static int add_llvm_annotation(Dwarf_Die *die, int component_idx, struct conf_load *conf,
-			       struct list_head *head)
+static struct llvm_annotation *die__create_new_llvm_annotation(Dwarf_Die *die,
+							       struct cu *cu,
+							       struct conf_load *conf)
+{
+	struct llvm_annotation *tag;
+
+	tag = tag__alloc_with_spec(cu, sizeof(struct llvm_annotation));
+	if (tag == NULL)
+		return NULL;
+
+	tag__init(&tag->tag, cu, die);
+	return tag;
+}
+
+/** Allocate small_id for specified @tag */
+static int cu__assign_tag_id(struct cu *cu, struct tag *tag)
+{
+	struct dwarf_tag *dtag = tag->priv;
+	uint32_t id;
+
+	if (cu__table_add_tag(cu, tag, &id) < 0)
+		return -ENOMEM;
+
+	dtag->small_id = id;
+	cu__hash(cu, tag);
+
+	return 0;
+}
+
+static int add_btf_decl_tag(Dwarf_Die *die,
+			    struct cu *cu,
+			    int component_idx,
+			    struct conf_load *conf,
+			    struct list_head *head)
 {
 	struct llvm_annotation *annot;
 	const char *name;
@@ -890,17 +970,60 @@ static int add_llvm_annotation(Dwarf_Die *die, int component_idx, struct conf_lo
 	if (strcmp(name, "btf_decl_tag") != 0)
 		return 0;
 
-	annot = zalloc(sizeof(*annot));
+	annot = die__create_new_llvm_annotation(die, cu, conf);
 	if (!annot)
 		return -ENOMEM;
 
+	/* Don't assign id for btf_decl_tag */
+
+	annot->kind = BTF_DECL_TAG;
 	annot->value = attr_string(die, DW_AT_const_value, conf);
 	annot->component_idx = component_idx;
 	list_add_tail(&annot->node, head);
 	return 0;
 }
 
-static int add_child_llvm_annotations(Dwarf_Die *die, int component_idx,
+static int add_btf_type_tag(Dwarf_Die *die,
+			    struct cu *cu,
+			    struct conf_load *conf,
+			    struct list_head *head)
+{
+	struct llvm_annotation *annot;
+	const char *name;
+	bool v1, v2;
+
+	if (conf->skip_encoding_btf_type_tag)
+		return 0;
+
+	name = attr_string(die, DW_AT_name, conf);
+	v1 = strcmp(name, "btf_type_tag") == 0;
+	v2 = strcmp(name, "btf:type_tag") == 0;
+
+	if (!v1 && !v2)
+		return 0;
+
+	/* Create a btf_type_tag type for this annotation. */
+	annot = die__create_new_llvm_annotation(die, cu, conf);
+	if (annot == NULL)
+		return -ENOMEM;
+
+	annot->kind = v2 ? BTF_TYPE_TAG : BTF_TYPE_TAG_POINTEE;
+	annot->value = attr_string(die, DW_AT_const_value, conf);
+	annot->component_idx = -1;
+	if (v2)
+		cu->ignore_btf_type_tag_pointee = 1;
+
+	/* For a list of DW_TAG_LLVM_annotation like tag1 -> tag2 -> tag3,
+	 * the tag->tags contains tag3 -> tag2 -> tag1.
+	 */
+	list_add(&annot->node, head);
+
+	return 0;
+}
+
+static int add_child_llvm_annotations(Dwarf_Die *die,
+				      struct cu *cu,
+				      int component_idx,
 				      struct conf_load *conf, struct list_head *head)
 {
 	Dwarf_Die child;
@@ -912,9 +1035,14 @@ static int add_child_llvm_annotations(Dwarf_Die *die, int component_idx,
 	die = &child;
 	do {
 		if (dwarf_tag(die) == DW_TAG_LLVM_annotation) {
-			ret = add_llvm_annotation(die, component_idx, conf, head);
+			ret = add_btf_decl_tag(die, cu, component_idx, conf, head);
+			if (ret)
+				return ret;
+			ret = add_btf_type_tag(die, cu, conf, head);
 			if (ret)
 				return ret;
+		} else {
+			cu__tag_not_handled(die);
 		}
 	} while (dwarf_siblingof(die, die) == 0);
 
@@ -1340,19 +1468,8 @@ static uint64_t attr_upper_bound(Dwarf_Die *die)
 	return 0;
 }
 
-static void __cu__tag_not_handled(Dwarf_Die *die, const char *fn)
-{
-	uint32_t tag = dwarf_tag(die);
-
-	fprintf(stderr, "%s: DW_TAG_%s (%#x) @ <%#llx> not handled!\n",
-		fn, dwarf_tag_name(tag), tag,
-		(unsigned long long)dwarf_dieoffset(die));
-}
-
 static struct tag unsupported_tag;
 
-#define cu__tag_not_handled(die) __cu__tag_not_handled(die, __FUNCTION__)
-
 static struct tag *__die__process_tag(Dwarf_Die *die, struct cu *cu,
 				      int toplevel, const char *fn, struct conf_load *conf);
 
@@ -1372,87 +1489,44 @@ static struct tag *die__create_new_tag(Dwarf_Die *die, struct cu *cu)
 	return tag;
 }
 
-static struct btf_type_tag_ptr_type *die__create_new_btf_type_tag_ptr_type(Dwarf_Die *die, struct cu *cu)
+static struct tag *die__create_new_unspecified_type(Dwarf_Die *die, struct cu *cu,
+						    struct conf_load *conf)
 {
-	struct btf_type_tag_ptr_type *tag;
+	struct unspecified_type *tag;
 
-	tag  = tag__alloc_with_spec(cu, sizeof(struct btf_type_tag_ptr_type));
+	tag  = tag__alloc_with_spec(cu, sizeof(struct unspecified_type));
 	if (tag == NULL)
 		return NULL;
 
 	tag__init(&tag->tag, cu, die);
-	tag->tag.has_btf_type_tag = true;
-	INIT_LIST_HEAD(&tag->tags);
-	return tag;
-}
-
-static struct btf_type_tag_type *die__create_new_btf_type_tag_type(Dwarf_Die *die, struct cu *cu,
-								   struct conf_load *conf)
-{
-	struct btf_type_tag_type *tag;
+	INIT_LIST_HEAD(&tag->node);
 
-	tag  = tag__alloc_with_spec(cu, sizeof(struct btf_type_tag_type));
-	if (tag == NULL)
+	tag->name = attr_string(die, DW_AT_name, conf);
+	if (add_child_llvm_annotations(die, cu, -1, conf, &tag->tag.annots))
 		return NULL;
 
-	tag__init(&tag->tag, cu, die);
-	tag->value = attr_string(die, DW_AT_const_value, conf);
-	return tag;
+	list_add(&tag->node, &cu->unspecified_types);
+
+	return &tag->tag;
 }
 
-static struct tag *die__create_new_pointer_tag(Dwarf_Die *die, struct cu *cu,
-					       struct conf_load *conf)
+static void unspecified_type__delete(struct cu *cu, struct unspecified_type *utype)
 {
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
+	struct dwarf_tag *dtag = utype->tag.priv;
 
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
+	cu__free(cu, dtag);
+	cu__free(cu, utype);
+}
 
-		struct dwarf_tag *dtag = annot->tag.priv;
-		dtag->small_id = id;
-		cu__hash(cu, &annot->tag);
+static struct tag *die__create_new_annotated_tag(Dwarf_Die *die, struct cu *cu,
+						 struct conf_load *conf)
+{
+	struct tag *tag = tag__new(die, cu);
 
-		/* For a list of DW_TAG_LLVM_annotation like tag1 -> tag2 -> tag3,
-		 * the tag->tags contains tag3 -> tag2 -> tag1.
-		 */
-		list_add(&annot->node, &tag->tags);
-	} while (dwarf_siblingof(cdie, cdie) == 0);
+	if (add_child_llvm_annotations(die, cu, -1, conf, &tag->annots))
+		return NULL;
 
-	return tag ? &tag->tag : tag__new(die, cu);
+	return tag;
 }
 
 static struct tag *die__create_new_ptr_to_member_type(Dwarf_Die *die,
@@ -1527,9 +1601,8 @@ static struct tag *die__create_new_base_type(Dwarf_Die *die, struct cu *cu, stru
 	if (base == NULL)
 		return NULL;
 
-	if (dwarf_haschildren(die))
-		fprintf(stderr, "%s: DW_TAG_base_type WITH children!\n",
-			__func__);
+	if (add_child_llvm_annotations(die, cu, -1, conf, &base->tag.annots))
+		return NULL;
 
 	return &base->tag;
 }
@@ -1541,13 +1614,13 @@ static struct tag *die__create_new_typedef(Dwarf_Die *die, struct cu *cu, struct
 	if (tdef == NULL)
 		return NULL;
 
-	if (add_child_llvm_annotations(die, -1, conf, &tdef->namespace.annots))
+	if (add_child_llvm_annotations(die, cu, -1, conf, &tdef->namespace.tag.annots))
 		return NULL;
 
 	return &tdef->namespace.tag;
 }
 
-static struct tag *die__create_new_array(Dwarf_Die *die, struct cu *cu)
+static struct tag *die__create_new_array(Dwarf_Die *die, struct cu *cu, struct conf_load *conf)
 {
 	Dwarf_Die child;
 	/* "64 dimensions will be enough for everybody." acme, 2006 */
@@ -1563,17 +1636,25 @@ static struct tag *die__create_new_array(Dwarf_Die *die, struct cu *cu)
 
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
@@ -1610,7 +1691,8 @@ static struct tag *die__create_new_parameter(Dwarf_Die *die,
 	if (ftype != NULL) {
 		ftype__add_parameter(ftype, parm);
 		if (param_idx >= 0) {
-			if (add_child_llvm_annotations(die, param_idx, conf, &(tag__function(&ftype->tag)->annots)))
+			if (add_child_llvm_annotations(die, cu, param_idx, conf,
+						       &ftype->tag.annots))
 				return NULL;
 		}
 	} else {
@@ -1651,7 +1733,7 @@ static struct tag *die__create_new_variable(Dwarf_Die *die, struct cu *cu, struc
 {
 	struct variable *var = variable__new(die, cu, conf);
 
-	if (var == NULL || add_child_llvm_annotations(die, -1, conf, &var->annots))
+	if (var == NULL || add_child_llvm_annotations(die, cu, -1, conf, &var->annots))
 		return NULL;
 
 	return &var->ip.tag;
@@ -1684,6 +1766,10 @@ static struct tag *die__create_new_subroutine_type(Dwarf_Die *die,
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
@@ -1740,17 +1826,25 @@ static struct tag *die__create_new_enumeration(Dwarf_Die *die, struct cu *cu, st
 
 	die = &child;
 	do {
-		struct enumerator *enumerator;
+		switch (dwarf_tag(die)) {
+		case DW_TAG_enumerator: {
+			struct enumerator *enumerator;
 
-		if (dwarf_tag(die) != DW_TAG_enumerator) {
+			enumerator = enumerator__new(die, cu, conf);
+			if (enumerator == NULL)
+				goto out_delete;
+
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
@@ -1806,13 +1900,16 @@ static int die__process_class(Dwarf_Die *die, struct type *class,
 
 			type__add_member(class, member);
 			cu__hash(cu, &member->tag);
-			if (add_child_llvm_annotations(die, member_idx, conf, &class->namespace.annots))
+			if (add_child_llvm_annotations(die, cu, member_idx, conf,
+						       &class->namespace.tag.annots))
 				return -ENOMEM;
 			member_idx++;
 		}
 			continue;
 		case DW_TAG_LLVM_annotation:
-			if (add_llvm_annotation(die, -1, conf, &class->namespace.annots))
+			if (add_btf_decl_tag(die, cu, -1, conf, &class->namespace.tag.annots))
+				return -ENOMEM;
+			if (add_btf_type_tag(die, cu, conf, &class->namespace.tag.annots))
 				return -ENOMEM;
 			continue;
 		default: {
@@ -2089,7 +2186,8 @@ static int die__process_function(Dwarf_Die *die, struct ftype *ftype,
 				goto out_enomem;
 			continue;
 		case DW_TAG_LLVM_annotation:
-			if (add_llvm_annotation(die, -1, conf, &(tag__function(&ftype->tag)->annots)))
+			if (add_btf_decl_tag(die, cu, -1, conf,
+					     &(tag__function(&ftype->tag)->annots)))
 				goto out_enomem;
 			continue;
 		default:
@@ -2149,23 +2247,23 @@ static struct tag *__die__process_tag(Dwarf_Die *die, struct cu *cu,
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
-	case DW_TAG_unspecified_type:
-		tag = die__create_new_tag(die, cu);		break;
+	case DW_TAG_const_type:
+	case DW_TAG_restrict_type:
+	case DW_TAG_volatile_type:
 	case DW_TAG_pointer_type:
-		tag = die__create_new_pointer_tag(die, cu, conf);	break;
+		tag = die__create_new_annotated_tag(die, cu, conf); break;
+	case DW_TAG_unspecified_type:
+		tag = die__create_new_unspecified_type(die, cu, conf); break;
 	case DW_TAG_ptr_to_member_type:
 		tag = die__create_new_ptr_to_member_type(die, cu); break;
 	case DW_TAG_enumeration_type:
@@ -2252,20 +2350,100 @@ static int die__process_unit(Dwarf_Die *die, struct cu *cu, struct conf_load *co
 	return 0;
 }
 
-static void ftype__recode_dwarf_types(struct tag *tag, struct cu *cu);
+/** Add @tuple to @ctx->mappings array, extend it if necessary. */
+static int push_btf_type_tag_mapping(struct btf_type_tag_mapping *tuple,
+				     struct recode_context *ctx)
+{
+	if (ctx->nr_allocated == ctx->nr_entries) {
+		uint32_t new_nr = ctx->nr_allocated * 2;
+		void *new_array = reallocarray(ctx->mappings, new_nr,
+					       sizeof(ctx->mappings[0]));
+		if (!new_array)
+			return -ENOMEM;
+		ctx->mappings = new_array;
+		ctx->nr_allocated = new_nr;
+	}
+
+	ctx->mappings[ctx->nr_entries++] = *tuple;
+
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
 
-static int namespace__recode_dwarf_types(struct tag *tag, struct cu *cu)
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
@@ -2286,7 +2464,7 @@ static int namespace__recode_dwarf_types(struct tag *tag, struct cu *cu)
 			break;
 		case DW_TAG_subroutine_type:
 		case DW_TAG_subprogram:
-			ftype__recode_dwarf_types(pos, cu);
+			ftype__recode_dwarf_types(pos, cu, ctx);
 			break;
 		case DW_TAG_imported_module:
 			dtype = dwarf_cu__find_tag_by_ref(dcu, &dpos->type);
@@ -2351,7 +2529,8 @@ static void __tag__print_abstract_origin_not_found(struct tag *tag,
 #define tag__print_abstract_origin_not_found(tag ) \
 	__tag__print_abstract_origin_not_found(tag, __func__)
 
-static void ftype__recode_dwarf_types(struct tag *tag, struct cu *cu)
+static void ftype__recode_dwarf_types(struct tag *tag, struct cu *cu,
+				      struct recode_context *ctx)
 {
 	struct parameter *pos;
 	struct dwarf_cu *dcu = cu->priv;
@@ -2399,9 +2578,13 @@ static void ftype__recode_dwarf_types(struct tag *tag, struct cu *cu)
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
@@ -2412,7 +2595,7 @@ static void lexblock__recode_dwarf_types(struct lexblock *tag, struct cu *cu)
 
 		switch (pos->tag) {
 		case DW_TAG_lexical_block:
-			lexblock__recode_dwarf_types(tag__lexblock(pos), cu);
+			lexblock__recode_dwarf_types(tag__lexblock(pos), cu, ctx);
 			continue;
 		case DW_TAG_inlined_subroutine:
 			if (dpos->type.off != 0)
@@ -2426,7 +2609,7 @@ static void lexblock__recode_dwarf_types(struct lexblock *tag, struct cu *cu)
 					tag__print_abstract_origin_not_found(pos);
 				continue;
 			}
-			ftype__recode_dwarf_types(dtype->tag, cu);
+			ftype__recode_dwarf_types(dtype->tag, cu, ctx);
 			continue;
 
 		case DW_TAG_formal_parameter:
@@ -2493,10 +2676,146 @@ static void lexblock__recode_dwarf_types(struct lexblock *tag, struct cu *cu)
 	}
 }
 
-static void dwarf_cu__recode_btf_type_tag_ptr(struct btf_type_tag_ptr_type *tag,
-					      uint32_t pointee_type)
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
+static void dwarf_cu__recode_btf_type_tag_ptr(struct tag *tag,
+					      uint32_t pointee_type,
+					      struct cu *cu)
 {
-	struct btf_type_tag_type *annot;
+	struct llvm_annotation *annot;
 	struct dwarf_tag *annot_dtag;
 	struct tag *prev_tag;
 
@@ -2523,16 +2842,20 @@ static void dwarf_cu__recode_btf_type_tag_ptr(struct btf_type_tag_ptr_type *tag,
 	 *   int tag1 tag2 tag3 *p;
 	 * and this matches the user/kernel code.
 	 */
-	prev_tag = &tag->tag;
-	list_for_each_entry(annot, &tag->tags, node) {
-		annot_dtag = annot->tag.priv;
-		prev_tag->type = annot_dtag->small_id;
-		prev_tag = &annot->tag;
+	prev_tag = tag;
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
@@ -2545,7 +2868,7 @@ static int tag__recode_dwarf_type(struct tag *tag, struct cu *cu)
 		type__recode_dwarf_specification(tag, cu);
 
 	if (tag__has_namespace(tag))
-		return namespace__recode_dwarf_types(tag, cu);
+		return namespace__recode_dwarf_types(tag, cu, ctx);
 
 	switch (tag->tag) {
 	case DW_TAG_subprogram: {
@@ -2577,17 +2900,17 @@ static int tag__recode_dwarf_type(struct tag *tag, struct cu *cu)
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
@@ -2608,7 +2931,7 @@ static int tag__recode_dwarf_type(struct tag *tag, struct cu *cu)
 		break;
 
 	case DW_TAG_namespace:
-		return namespace__recode_dwarf_types(tag, cu);
+		return namespace__recode_dwarf_types(tag, cu, ctx);
 	/* Damn, DW_TAG_inlined_subroutine is an special case
            as dwarf_tag->id is in fact an abtract origin, i.e. must be
 	   looked up in the tags_table, not in the types_table.
@@ -2636,15 +2959,19 @@ static int tag__recode_dwarf_type(struct tag *tag, struct cu *cu)
 					var->spec = tag__variable(dtype->tag);
 			}
 		}
+		break;
 	}
-
+	case DW_TAG_LLVM_annotation:
+		return 0;
 	}
 
+	recode_btf_type_tags(&tag->annots, dtag->small_id, ctx);
+
 	if (dtag->type.off == 0) {
-		if (tag->tag != DW_TAG_pointer_type || !tag->has_btf_type_tag)
+		if (tag->tag != DW_TAG_pointer_type)
 			tag->type = 0; /* void */
 		else
-			dwarf_cu__recode_btf_type_tag_ptr(tag__btf_type_tag_ptr(tag), 0);
+			dwarf_cu__recode_btf_type_tag_ptr(tag, 0, cu);
 		return 0;
 	}
 
@@ -2656,10 +2983,10 @@ check_type:
 		return 0;
 	}
 out:
-	if (tag->tag != DW_TAG_pointer_type || !tag->has_btf_type_tag)
+	if (tag->tag != DW_TAG_pointer_type)
 		tag->type = dtype->small_id;
 	else
-		dwarf_cu__recode_btf_type_tag_ptr(tag__btf_type_tag_ptr(tag), dtype->small_id);
+		dwarf_cu__recode_btf_type_tag_ptr(tag, dtype->small_id, cu);
 
 	return 0;
 }
@@ -2744,28 +3071,168 @@ static int cu__resolve_func_ret_types_optimized(struct cu *cu)
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
diff --git a/dwarves.c b/dwarves.c
index b43031c..7e66a98 100644
--- a/dwarves.c
+++ b/dwarves.c
@@ -681,6 +681,7 @@ struct cu *cu__new(const char *name, uint8_t addr_size,
 		cu->dfops	= NULL;
 		INIT_LIST_HEAD(&cu->tags);
 		INIT_LIST_HEAD(&cu->tool_list);
+		INIT_LIST_HEAD(&cu->unspecified_types);
 
 		cu->addr_size = addr_size;
 		cu->extra_dbg_info = 0;
diff --git a/dwarves.h b/dwarves.h
index e92b2fd..8547fea 100644
--- a/dwarves.h
+++ b/dwarves.h
@@ -240,6 +240,7 @@ struct cu {
 	struct list_head node;
 	struct list_head tags;
 	struct list_head tool_list;	/* To be used by tools such as ctracer */
+	struct list_head unspecified_types;
 	struct ptr_table types_table;
 	struct ptr_table functions_table;
 	struct ptr_table tags_table;
@@ -258,6 +259,10 @@ struct cu {
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
@@ -417,8 +422,8 @@ int cu__for_all_tags(struct cu *cu,
 		     void *cookie);
 
 /** struct tag - basic representation of a debug info element
- * @priv - extra data, for instance, DWARF offset, id, decl_{file,line}
- * @top_level -
+ * @priv   - extra data, for instance, DWARF offset, id, decl_{file,line}
+ * @annots - list of btf_type_tag and btf_decl_tag annotations.
  */
 struct tag {
 	struct list_head node;
@@ -426,8 +431,8 @@ struct tag {
 	uint16_t	 tag;
 	bool		 visited;
 	bool		 top_level;
-	bool		 has_btf_type_tag;
 	uint16_t	 recursivity_level;
+	struct list_head annots;
 	void		 *priv;
 };
 
@@ -623,43 +628,51 @@ static inline struct ptr_to_member_type *
 	return (struct ptr_to_member_type *)tag;
 }
 
-struct llvm_annotation {
-	const char		*value;
-	int16_t			component_idx;
-	struct list_head	node;
+enum annotation_kind {
+	BTF_DECL_TAG,
+	/* "btf_type_tag" in DWARF, attached to a pointer, applies to pointee type.
+	 * Old-style encoding kept for backwards compatibility.
+	 */
+	BTF_TYPE_TAG_POINTEE,
+	/* "btf:type_tag" in DWARF, attached to any type, applies to parent type */
+	BTF_TYPE_TAG,
 };
 
-/** struct btf_type_tag_type - representing a btf_type_tag annotation
+/** struct llvm_annotation - representing objects with DW_TAG_LLVM_annotation tag
  *
- * @tag   - DW_TAG_LLVM_annotation tag
- * @value - btf_type_tag value string
- * @node  - list_head node
+ * @tag           - DW_TAG_LLVM_annotation tag
+ * @kind          - annotation kind
+ * @value         - value string, valid for both "btf_decl_tag" and "btf_type_tag"
+ * @component_idx - component index, valid only for "btf_decl_tag"
+ * @node          - list_head node
  */
-struct btf_type_tag_type {
+struct llvm_annotation {
 	struct tag		tag;
+	enum annotation_kind	kind;
 	const char		*value;
+	int16_t			component_idx;
 	struct list_head	node;
 };
 
-/** The struct btf_type_tag_ptr_type - type containing both pointer type and
- *  its btf_type_tag annotations
+static inline struct llvm_annotation *tag__llvm_annotation(struct tag *tag)
+{
+	return (struct llvm_annotation *)tag;
+}
+
+/** struct unspecified_type - representation of DW_TAG_unspecified_type.
  *
- * @tag  - pointer type tag
- * @tags - btf_type_tag annotations for the pointer type
+ *  @name   - DW_AT_name associated with this tag
+ *  @node   - a node for cu::unspecified_types list
  */
-struct btf_type_tag_ptr_type {
+struct unspecified_type {
 	struct tag		tag;
-	struct list_head 	tags;
+	const char		*name;
+	struct list_head	node;
 };
 
-static inline struct btf_type_tag_ptr_type *tag__btf_type_tag_ptr(struct tag *tag)
-{
-	return (struct btf_type_tag_ptr_type *)tag;
-}
-
-static inline struct btf_type_tag_type *tag__btf_type_tag(struct tag *tag)
+static inline struct unspecified_type *tag__unspecified_type(struct tag *tag)
 {
-	return (struct btf_type_tag_type *)tag;
+	return (struct unspecified_type *)tag;
 }
 
 /** struct namespace - base class for enums, structs, unions, typedefs, etc
@@ -673,7 +686,6 @@ struct namespace {
 	uint16_t	 nr_tags;
 	uint8_t		 shared_tags;
 	struct list_head tags;
-	struct list_head annots;
 };
 
 static inline struct namespace *tag__namespace(const struct tag *tag)
@@ -1339,6 +1351,10 @@ enum base_type_float_type {
 	BT_FP_IMGRY_LDBL
 };
 
+/** struct base_type - represents types with DW_TAG_base_type
+ *
+ * @tags  - an optional list of btf_type_tag annotations
+ */
 struct base_type {
 	struct tag	tag;
 	const char	*name;
diff --git a/dwarves_fprintf.c b/dwarves_fprintf.c
index 30355b4..baa5924 100644
--- a/dwarves_fprintf.c
+++ b/dwarves_fprintf.c
@@ -571,6 +571,7 @@ static const char *__tag__name(const struct tag *tag, const struct cu *cu,
 	case DW_TAG_restrict_type:
 	case DW_TAG_atomic_type:
 	case DW_TAG_unspecified_type:
+	case DW_TAG_LLVM_annotation:
 		type = cu__type(cu, tag->type);
 		if (type == NULL && tag->type != 0)
 			tag__id_not_found_snprintf(bf, len, tag->type);
@@ -782,6 +783,10 @@ next_type:
 			n = tag__has_type_loop(type, ptype, NULL, 0, fp);
 			if (n)
 				return printed + n;
+			if (ptype->tag == DW_TAG_LLVM_annotation) {
+				type = ptype;
+				goto next_type;
+			}
 			if (ptype->tag == DW_TAG_subroutine_type) {
 				printed += ftype__fprintf(tag__ftype(ptype),
 							  cu, name, 0, 1,
@@ -874,6 +879,14 @@ print_modifier: {
 		else
 			printed += enumeration__fprintf(type, &tconf, fp);
 		break;
+	case DW_TAG_LLVM_annotation: {
+		struct tag *ttype = cu__type(cu, type->type);
+		if (ttype) {
+			type = ttype;
+			goto next_type;
+		}
+		goto out_type_not_found;
+	}
 	}
 out:
 	if (type_expanded)
-- 
2.39.1

