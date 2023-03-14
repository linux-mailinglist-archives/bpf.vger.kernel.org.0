Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 058F66BA34D
	for <lists+bpf@lfdr.de>; Wed, 15 Mar 2023 00:04:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbjCNXEj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Mar 2023 19:04:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230517AbjCNXEi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Mar 2023 19:04:38 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7170211E5;
        Tue, 14 Mar 2023 16:04:35 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id n2so22030180lfb.12;
        Tue, 14 Mar 2023 16:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678835074;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T+SscChHQ3Tpz4GDyUcYPHYCKNpT/taHvga7qJQiymo=;
        b=SZhCcSMVossutuNF/O5ZSOn22MYkb+r7Rm+3qgBMMNFZQ0+jyfvdwKtY33gEtib3VY
         vLNGu14Lo2oyCzUplkHqzNZqRSoX9YXUW8y7lAr5abSZgG2GlsxM07P2nhIE7oNpHXNj
         FSdLawPYcH83i4Klb0+M2fbIrrLVVSNHtYep5cJk5xE9cW+7IpWm99wRcuG3ZjpJtkLr
         I8mga7EC/5/5iN4XFSG9c4MXaOc4WW5Ryd+5tlQ/tjoG2/f9K5PDKHwzPZf7Cht4yonA
         yviyJnpZnDGHe/5ASWSkVNzURGwKIxO/MZba0IpEX18DRxA8ZdJKlTzwiYg9LTKBE4eZ
         6tIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678835074;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T+SscChHQ3Tpz4GDyUcYPHYCKNpT/taHvga7qJQiymo=;
        b=xqasPRvNYuS2rAi1n3iIlpggKKsK/k1+G4IXMnl2d91zSf08ibftJzB+kUkOpas0xo
         T/7aBfUAjdW2c5ekT6jZ7sFIMS5/x3GWaK4RGOSKg87WtXerVt0AZmA4BYn9LRwmJQot
         PnqrGZVreT0xuv9v9/dVJPDDidNZk2YCO4GVeGJ5Ap9FXcCSIuY90Km4THw/iL4WeQms
         QOUoORROkR6Id8MYoU9UeGhwa+GczEaXUeDoVDz8H8CKOI1Fjw2y1HrhtfTY8L/LPKe3
         5xlRhsVlnelCOdiwSItBOygNTTqrO6Mudr3tARVmNyf9/MRzS3EBPevoFefhJ90at+iy
         w+7Q==
X-Gm-Message-State: AO0yUKWiryFbJMBn9lFqsvNzxSshVs/3tdtMFrYWw1SabC5TzEHZItot
        Bs5MIPpsm/FpD63Xg/f4Tu8OmN3HWOFYxwdE
X-Google-Smtp-Source: AK7set/DaHVzr+ZLjnDuo+MQhMZoPiGAMu8q251UuF6M/V3uwMJFJKSHvHQFDnNlaIzV6xPHnXyWaw==
X-Received: by 2002:ac2:596c:0:b0:4de:6973:82aa with SMTP id h12-20020ac2596c000000b004de697382aamr1153078lfp.68.1678835073722;
        Tue, 14 Mar 2023 16:04:33 -0700 (PDT)
Received: from bigfoot.. (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id b1-20020ac25e81000000b004cc7acfbd2bsm569638lfq.287.2023.03.14.16.04.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 16:04:33 -0700 (PDT)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     dwarves@vger.kernel.org, arnaldo.melo@gmail.com
Cc:     bpf@vger.kernel.org, kernel-team@fb.com, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, yhs@fb.com,
        jose.marchesi@oracle.com, david.faust@oracle.com,
        alan.maguire@oracle.com, Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH dwarves v2 3/5] dwarf_loader: Consolidate llvm_annotation and btf_type_tag_type
Date:   Wed, 15 Mar 2023 01:04:15 +0200
Message-Id: <20230314230417.1507266-4-eddyz87@gmail.com>
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

In recent discussion in BPF mailing list ([1]) participants agreed to
add a new DWARF representation for "btf_type_tag" annotations.

Existing representation is DW_TAG_LLVM_annotation object attached as a
child to a DW_TAG_pointer_type. It means that "btf_type_tag"
annotation is attached to a pointee type.

New representation is DW_TAG_LLVM_annotation object attached as a
child to *any* type. It means that "btf_type_tag" annotation is
attached to the parent type.

For example, consider the following C code:

    struct alpha {
      int __attribute__((btf_type_tag("__alpha_a"))) *a;
    } g;

And corresponding DWARF:

0x29:   DW_TAG_structure_type
          DW_AT_name      ("alpha")

0x2e:     DW_TAG_member
            DW_AT_name    ("a")
            DW_AT_type    (0x38 "int *")

0x38:   DW_TAG_pointer_type
          DW_AT_type      (0x41 "int")

0x3d:     DW_TAG_LLVM_annotation
            DW_AT_name    ("btf_type_tag")
            DW_AT_const_value     ("__alpha_a")
          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
          Old style representation

0x41:   DW_TAG_base_type
          DW_AT_name      ("int")
          DW_AT_encoding  (DW_ATE_signed)
          DW_AT_byte_size (0x04)

0x45:     DW_TAG_LLVM_annotation
            DW_AT_name    ("btf:type_tag")
            DW_AT_const_value     ("__alpha_a")
          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
          New style representation

This means that new style type tags could be attached to any type from
the list below:
- base types;
- arrays;
- pointers;
- structs
- unions;
- enums;
- typedefs.

This commit is a preparatory step for `btf:type_tag` support:
- structs, unions and typedefs could be annotated with two kinds of
  `DW_TAG_LLVM_annotation` when new type tag representation is used:
  - BTF_DECL_TAG
  - BTF_TYPE_TAG
  In order to keep these objects in a single annotations list
  `struct llvm_annotation` and `struct btf_type_tag_type` are
  consolidated as a single type with a special discriminator
  field to distinguish one from the other;
- Because many types could be annotated with `btf:type_tag` the `annots`
  field is moved to `struct tag`, consequently:
  - type `struct btf_type_tag_type_ptr` is removed;
  - field `struct namespace::annots` is removed.

[1] Mailing list discussion regarding `btf:type_tag`
    Various approaches are discussed, Solution #2 is accepted
    https://lore.kernel.org/bpf/87r0w9jjoq.fsf@oracle.com/

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 btf_encoder.c  |  13 ++-
 dwarf_loader.c | 230 ++++++++++++++++++++++++++-----------------------
 dwarves.h      |  49 ++++-------
 3 files changed, 150 insertions(+), 142 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index 65f6e71..1aa4ffc 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -893,6 +893,9 @@ static int32_t btf_encoder__add_func(struct btf_encoder *encoder, struct functio
 		return -1;
 	}
 	list_for_each_entry(annot, &fn->annots, node) {
+		if (annot->kind != BTF_DECL_TAG)
+			continue;
+
 		tag_type_id = btf_encoder__add_decl_tag(encoder, annot->value, btf_fn_id,
 							annot->component_idx);
 		if (tag_type_id < 0) {
@@ -1175,7 +1178,7 @@ static int btf_encoder__encode_tag(struct btf_encoder *encoder, struct tag *tag,
 		name = namespace__name(tag__namespace(tag));
 		return btf_encoder__add_ref_type(encoder, BTF_KIND_TYPEDEF, ref_type_id, name, false);
 	case DW_TAG_LLVM_annotation:
-		name = tag__btf_type_tag(tag)->value;
+		name = tag__llvm_annotation(tag)->value;
 		return btf_encoder__add_ref_type(encoder, BTF_KIND_TYPE_TAG, ref_type_id, name, false);
 	case DW_TAG_structure_type:
 	case DW_TAG_union_type:
@@ -1600,6 +1603,9 @@ static int btf_encoder__encode_cu_variables(struct btf_encoder *encoder)
 		}
 
 		list_for_each_entry(annot, &var->annots, node) {
+			if (annot->kind != BTF_DECL_TAG)
+				continue;
+
 			int tag_type_id = btf_encoder__add_decl_tag(encoder, annot->value, id, annot->component_idx);
 			if (tag_type_id < 0) {
 				fprintf(stderr, "error: failed to encode tag '%s' to variable '%s' with component_idx %d\n",
@@ -1793,7 +1799,10 @@ int btf_encoder__encode_cu(struct btf_encoder *encoder, struct cu *cu, struct co
 
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
diff --git a/dwarf_loader.c b/dwarf_loader.c
index 4efa4e1..17a2773 100644
--- a/dwarf_loader.c
+++ b/dwarf_loader.c
@@ -112,6 +112,17 @@ static dwarf_off_ref dwarf_tag__spec(struct dwarf_tag *dtag)
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
@@ -519,6 +530,7 @@ static void tag__init(struct tag *tag, struct cu *cu, Dwarf_Die *die)
 	}
 
 	INIT_LIST_HEAD(&tag->node);
+	INIT_LIST_HEAD(&tag->annots);
 }
 
 static struct tag *tag__new(Dwarf_Die *die, struct cu *cu)
@@ -608,7 +620,6 @@ static void namespace__init(struct namespace *namespace, Dwarf_Die *die,
 {
 	tag__init(&namespace->tag, cu, die);
 	INIT_LIST_HEAD(&namespace->tags);
-	INIT_LIST_HEAD(&namespace->annots);
 	namespace->name  = attr_string(die, DW_AT_name, conf);
 	namespace->nr_tags = 0;
 	namespace->shared_tags = 0;
@@ -876,8 +887,40 @@ static int tag__recode_dwarf_bitfield(struct tag *tag, struct cu *cu, uint16_t b
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
@@ -890,17 +933,57 @@ static int add_llvm_annotation(Dwarf_Die *die, int component_idx, struct conf_lo
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
+
+	if (conf->skip_encoding_btf_type_tag)
+		return 0;
+
+	name = attr_string(die, DW_AT_name, conf);
+
+	if (strcmp(name, "btf_type_tag") != 0)
+		return 0;
+
+	/* Create a btf_type_tag type for this annotation. */
+	annot = die__create_new_llvm_annotation(die, cu, conf);
+	if (annot == NULL)
+		return -ENOMEM;
+
+	cu__assign_tag_id(cu, &annot->tag);
+
+	annot->kind = BTF_TYPE_TAG_POINTEE;
+	annot->value = attr_string(die, DW_AT_const_value, conf);
+	annot->component_idx = -1;
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
@@ -912,9 +995,14 @@ static int add_child_llvm_annotations(Dwarf_Die *die, int component_idx,
 	die = &child;
 	do {
 		if (dwarf_tag(die) == DW_TAG_LLVM_annotation) {
-			ret = add_llvm_annotation(die, component_idx, conf, head);
+			ret = add_btf_decl_tag(die, cu, component_idx, conf, head);
 			if (ret)
 				return ret;
+			ret = add_btf_type_tag(die, cu, conf, head);
+			if (ret)
+				return ret;
+		} else {
+			cu__tag_not_handled(die);
 		}
 	} while (dwarf_siblingof(die, die) == 0);
 
@@ -1340,19 +1428,8 @@ static uint64_t attr_upper_bound(Dwarf_Die *die)
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
 
@@ -1372,89 +1449,17 @@ static struct tag *die__create_new_tag(Dwarf_Die *die, struct cu *cu)
 	return tag;
 }
 
-static struct btf_type_tag_ptr_type *die__create_new_btf_type_tag_ptr_type(Dwarf_Die *die, struct cu *cu)
+static struct tag *die__create_new_annotated_tag(Dwarf_Die *die, struct cu *cu,
+						 struct conf_load *conf)
 {
-	struct btf_type_tag_ptr_type *tag;
-
-	tag  = tag__alloc_with_spec(cu, sizeof(struct btf_type_tag_ptr_type));
-	if (tag == NULL)
-		return NULL;
-
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
+	struct tag *tag = tag__new(die, cu);
 
-	tag  = tag__alloc_with_spec(cu, sizeof(struct btf_type_tag_type));
-	if (tag == NULL)
+	if (add_child_llvm_annotations(die, cu, -1, conf, &tag->annots))
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
@@ -1541,7 +1546,7 @@ static struct tag *die__create_new_typedef(Dwarf_Die *die, struct cu *cu, struct
 	if (tdef == NULL)
 		return NULL;
 
-	if (add_child_llvm_annotations(die, -1, conf, &tdef->namespace.annots))
+	if (add_child_llvm_annotations(die, cu, -1, conf, &tdef->namespace.tag.annots))
 		return NULL;
 
 	return &tdef->namespace.tag;
@@ -1610,7 +1615,8 @@ static struct tag *die__create_new_parameter(Dwarf_Die *die,
 	if (ftype != NULL) {
 		ftype__add_parameter(ftype, parm);
 		if (param_idx >= 0) {
-			if (add_child_llvm_annotations(die, param_idx, conf, &(tag__function(&ftype->tag)->annots)))
+			if (add_child_llvm_annotations(die, cu, param_idx, conf,
+						       &ftype->tag.annots))
 				return NULL;
 		}
 	} else {
@@ -1651,7 +1657,7 @@ static struct tag *die__create_new_variable(Dwarf_Die *die, struct cu *cu, struc
 {
 	struct variable *var = variable__new(die, cu, conf);
 
-	if (var == NULL || add_child_llvm_annotations(die, -1, conf, &var->annots))
+	if (var == NULL || add_child_llvm_annotations(die, cu, -1, conf, &var->annots))
 		return NULL;
 
 	return &var->ip.tag;
@@ -1806,13 +1812,16 @@ static int die__process_class(Dwarf_Die *die, struct type *class,
 
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
@@ -2089,7 +2098,8 @@ static int die__process_function(Dwarf_Die *die, struct ftype *ftype,
 				goto out_enomem;
 			continue;
 		case DW_TAG_LLVM_annotation:
-			if (add_llvm_annotation(die, -1, conf, &(tag__function(&ftype->tag)->annots)))
+			if (add_btf_decl_tag(die, cu, -1, conf,
+					     &(tag__function(&ftype->tag)->annots)))
 				goto out_enomem;
 			continue;
 		default:
@@ -2165,7 +2175,7 @@ static struct tag *__die__process_tag(Dwarf_Die *die, struct cu *cu,
 	case DW_TAG_unspecified_type:
 		tag = die__create_new_tag(die, cu);		break;
 	case DW_TAG_pointer_type:
-		tag = die__create_new_pointer_tag(die, cu, conf);	break;
+		tag = die__create_new_annotated_tag(die, cu, conf); break;
 	case DW_TAG_ptr_to_member_type:
 		tag = die__create_new_ptr_to_member_type(die, cu); break;
 	case DW_TAG_enumeration_type:
@@ -2493,10 +2503,10 @@ static void lexblock__recode_dwarf_types(struct lexblock *tag, struct cu *cu)
 	}
 }
 
-static void dwarf_cu__recode_btf_type_tag_ptr(struct btf_type_tag_ptr_type *tag,
+static void dwarf_cu__recode_btf_type_tag_ptr(struct tag *tag,
 					      uint32_t pointee_type)
 {
-	struct btf_type_tag_type *annot;
+	struct llvm_annotation *annot;
 	struct dwarf_tag *annot_dtag;
 	struct tag *prev_tag;
 
@@ -2523,8 +2533,8 @@ static void dwarf_cu__recode_btf_type_tag_ptr(struct btf_type_tag_ptr_type *tag,
 	 *   int tag1 tag2 tag3 *p;
 	 * and this matches the user/kernel code.
 	 */
-	prev_tag = &tag->tag;
-	list_for_each_entry(annot, &tag->tags, node) {
+	prev_tag = tag;
+	list_for_each_entry(annot, &tag->annots, node) {
 		annot_dtag = annot->tag.priv;
 		prev_tag->type = annot_dtag->small_id;
 		prev_tag = &annot->tag;
@@ -2636,15 +2646,17 @@ static int tag__recode_dwarf_type(struct tag *tag, struct cu *cu)
 					var->spec = tag__variable(dtype->tag);
 			}
 		}
+		break;
 	}
-
+	case DW_TAG_LLVM_annotation:
+		return 0;
 	}
 
 	if (dtag->type.off == 0) {
-		if (tag->tag != DW_TAG_pointer_type || !tag->has_btf_type_tag)
+		if (tag->tag != DW_TAG_pointer_type)
 			tag->type = 0; /* void */
 		else
-			dwarf_cu__recode_btf_type_tag_ptr(tag__btf_type_tag_ptr(tag), 0);
+			dwarf_cu__recode_btf_type_tag_ptr(tag, 0);
 		return 0;
 	}
 
@@ -2656,10 +2668,10 @@ check_type:
 		return 0;
 	}
 out:
-	if (tag->tag != DW_TAG_pointer_type || !tag->has_btf_type_tag)
+	if (tag->tag != DW_TAG_pointer_type)
 		tag->type = dtype->small_id;
 	else
-		dwarf_cu__recode_btf_type_tag_ptr(tag__btf_type_tag_ptr(tag), dtype->small_id);
+		dwarf_cu__recode_btf_type_tag_ptr(tag, dtype->small_id);
 
 	return 0;
 }
diff --git a/dwarves.h b/dwarves.h
index 7a319d1..0b0b0cc 100644
--- a/dwarves.h
+++ b/dwarves.h
@@ -419,8 +419,8 @@ int cu__for_all_tags(struct cu *cu,
 		     void *cookie);
 
 /** struct tag - basic representation of a debug info element
- * @priv - extra data, for instance, DWARF offset, id, decl_{file,line}
- * @top_level -
+ * @priv   - extra data, for instance, DWARF offset, id, decl_{file,line}
+ * @annots - list of btf_type_tag and btf_decl_tag annotations.
  */
 struct tag {
 	struct list_head node;
@@ -428,8 +428,8 @@ struct tag {
 	uint16_t	 tag;
 	bool		 visited;
 	bool		 top_level;
-	bool		 has_btf_type_tag;
 	uint16_t	 recursivity_level;
+	struct list_head annots;
 	void		 *priv;
 };
 
@@ -625,43 +625,31 @@ static inline struct ptr_to_member_type *
 	return (struct ptr_to_member_type *)tag;
 }
 
-struct llvm_annotation {
-	const char		*value;
-	int16_t			component_idx;
-	struct list_head	node;
+enum annotation_kind {
+	BTF_DECL_TAG,
+	/* "btf_type_tag" in DWARF, attached to a pointer, applies to pointee type */
+	BTF_TYPE_TAG_POINTEE,
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
+static inline struct llvm_annotation *tag__llvm_annotation(struct tag *tag)
 {
-	return (struct btf_type_tag_ptr_type *)tag;
-}
-
-static inline struct btf_type_tag_type *tag__btf_type_tag(struct tag *tag)
-{
-	return (struct btf_type_tag_type *)tag;
+	return (struct llvm_annotation *)tag;
 }
 
 /** struct namespace - base class for enums, structs, unions, typedefs, etc
@@ -675,7 +663,6 @@ struct namespace {
 	uint16_t	 nr_tags;
 	uint8_t		 shared_tags;
 	struct list_head tags;
-	struct list_head annots;
 };
 
 static inline struct namespace *tag__namespace(const struct tag *tag)
-- 
2.39.1

