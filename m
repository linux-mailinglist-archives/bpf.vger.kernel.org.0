Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5792B6BA34E
	for <lists+bpf@lfdr.de>; Wed, 15 Mar 2023 00:04:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231172AbjCNXEj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Mar 2023 19:04:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230414AbjCNXEi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Mar 2023 19:04:38 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFD2324129;
        Tue, 14 Mar 2023 16:04:36 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id d36so22056423lfv.8;
        Tue, 14 Mar 2023 16:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678835075;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ubRg4GwuSCyuA5dYlB706nezzHSSXG6dO41jC6tYL7o=;
        b=iNw6xSifYopVxI8ZkAmbCUC0seQH5Ld29Ci53BMmfZuEZvVzcLib5vY3g27sS7IC6D
         oSjcB8pWU9o6JIktGHAFCPh3kWg1DLZ/UaTyt5AYzWg9rMFZdUkGRiJgTfNVCkgaYN8V
         WJ130BGkmPv3bBl/cb/JQ1pRoVM9uHcvfEBSWydt0x96oUNAwQpI1rVNnBi3fqYpy+pj
         SE+hczSxpIL1Fn9gCYlSEPKzkgFfMGjUfkvyo260eenabfzxWMPF3og8VeAJFtKXecUl
         rGBUKz0wWpyZXSTrJKxWdGBlTdT3Udwwbgx8jJimAJXEYtO+9OCDDybJ+YnnflWPcX7d
         7bBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678835075;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ubRg4GwuSCyuA5dYlB706nezzHSSXG6dO41jC6tYL7o=;
        b=SDU3IjN2pHuKqyCBEw/BvTWAAT5KGE1Z10ne4Kthyoi+/jLEdq3lRXO9zNaRN0Tkj5
         s8W29CSx65C0ZSfIVAHGAZfgTnb4iSzGQtxV9Oxx/jm9qZdGR/jL5pp+UK/HF+mOQO9y
         gCBWqDkWNQfABh16ZTpe0W6oa9kpnffTG3uNCbW3THwixxL6tZENy0VH3fp90WSlTfwo
         xcKb1pEz7UkfHI3+mrZFUNFqNRecvIExegzHs5EzPnmgqBdaLV/sJ5mlYaIeEmf0NQHD
         wy+og9GdqcOIAdX57nOP3hdiextIM0tOHOAbQqaNbdT8+UzNlq3OIDgSe9+9Yi2KVtXb
         i+7g==
X-Gm-Message-State: AO0yUKUPdUHsFT0Z8XvuAMHX97nOWsowmrIW5XQWSyplV9aLKYCg+Iuu
        4F1EFu13/e+rRNGUj18QvdYz52t9Vix+QsSP
X-Google-Smtp-Source: AK7set+3+QNe7Rma6sNYUPczMgQYfpJynMzsO1MxKGi1STP0qWvD/SpOPqzftNdojl0eESqL7FMbLA==
X-Received: by 2002:ac2:4a78:0:b0:4e8:49fa:ec1a with SMTP id q24-20020ac24a78000000b004e849faec1amr1161566lfp.51.1678835074855;
        Tue, 14 Mar 2023 16:04:34 -0700 (PDT)
Received: from bigfoot.. (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id b1-20020ac25e81000000b004cc7acfbd2bsm569638lfq.287.2023.03.14.16.04.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 16:04:34 -0700 (PDT)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     dwarves@vger.kernel.org, arnaldo.melo@gmail.com
Cc:     bpf@vger.kernel.org, kernel-team@fb.com, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, yhs@fb.com,
        jose.marchesi@oracle.com, david.faust@oracle.com,
        alan.maguire@oracle.com, Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH dwarves v2 4/5] dwarf_loader: Track unspecified types in a separate list
Date:   Wed, 15 Mar 2023 01:04:16 +0200
Message-Id: <20230314230417.1507266-5-eddyz87@gmail.com>
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
The agreed representation of void pointers uses unspecified types.
For example, consider the following C code:

    struct alpha {
      void __attribute__((btf_type_tag("__alpha_a"))) *a;
    } g;

And corresponding DWARF:

0x29:   DW_TAG_structure_type
          DW_AT_name      ("alpha")

0x2e:     DW_TAG_member
            DW_AT_name    ("a")
            DW_AT_type    (0x38 "void *")

0x38:   DW_TAG_pointer_type
          DW_AT_type      (0x41 "void")

0x41:   DW_TAG_unspecified_type
          DW_AT_name      ("void")

0x43:     DW_TAG_LLVM_annotation
            DW_AT_name    ("btf:type_tag")
            DW_AT_const_value     ("__alpha_a")

This is a preparatory patch for new type tags representation support,
specifically it adds `struct unspecified_type` and a new `cu` field
`struct cu::unspecified_types`. These would be used in a subsequent
patch to recode type tags attached to DW_TAG_unspecified_type
as in the example above.

[1] Mailing list discussion regarding `btf:type_tag`
    Various approaches are discussed, Solution #2 is accepted
    https://lore.kernel.org/bpf/87r0w9jjoq.fsf@oracle.com/

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 dwarf_loader.c | 36 ++++++++++++++++++++++++++++++++++--
 dwarves.c      |  1 +
 dwarves.h      | 17 +++++++++++++++++
 3 files changed, 52 insertions(+), 2 deletions(-)

diff --git a/dwarf_loader.c b/dwarf_loader.c
index 17a2773..218806b 100644
--- a/dwarf_loader.c
+++ b/dwarf_loader.c
@@ -176,14 +176,19 @@ static struct dwarf_cu *dwarf_cu__new(struct cu *cu)
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
+	list_for_each_safe(pos, n, &cu->unspecified_types)
+		unspecified_type__delete(cu, container_of(pos, struct unspecified_type, node));
 	cu__free(cu, dcu);
 	cu->priv = NULL;
 }
@@ -1449,6 +1454,33 @@ static struct tag *die__create_new_tag(Dwarf_Die *die, struct cu *cu)
 	return tag;
 }
 
+static struct tag *die__create_new_unspecified_type(Dwarf_Die *die, struct cu *cu,
+						    struct conf_load *conf)
+{
+	struct unspecified_type *tag;
+
+	tag = tag__alloc_with_spec(cu, sizeof(struct unspecified_type));
+	if (tag == NULL)
+		return NULL;
+
+	tag__init(&tag->tag, cu, die);
+	INIT_LIST_HEAD(&tag->node);
+
+	tag->name = attr_string(die, DW_AT_name, conf);
+
+	list_add(&tag->node, &cu->unspecified_types);
+
+	return &tag->tag;
+}
+
+static void unspecified_type__delete(struct cu *cu, struct unspecified_type *utype)
+{
+	struct dwarf_tag *dtag = utype->tag.priv;
+
+	cu__free(cu, dtag);
+	cu__free(cu, utype);
+}
+
 static struct tag *die__create_new_annotated_tag(Dwarf_Die *die, struct cu *cu,
 						 struct conf_load *conf)
 {
@@ -2172,10 +2204,10 @@ static struct tag *__die__process_tag(Dwarf_Die *die, struct cu *cu,
 	case DW_TAG_volatile_type:
 	case DW_TAG_atomic_type:
 		tag = die__create_new_tag(die, cu);		break;
-	case DW_TAG_unspecified_type:
-		tag = die__create_new_tag(die, cu);		break;
 	case DW_TAG_pointer_type:
 		tag = die__create_new_annotated_tag(die, cu, conf); break;
+	case DW_TAG_unspecified_type:
+		tag = die__create_new_unspecified_type(die, cu, conf); break;
 	case DW_TAG_ptr_to_member_type:
 		tag = die__create_new_ptr_to_member_type(die, cu); break;
 	case DW_TAG_enumeration_type:
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
index 0b0b0cc..cbd2913 100644
--- a/dwarves.h
+++ b/dwarves.h
@@ -242,6 +242,7 @@ struct cu {
 	struct list_head node;
 	struct list_head tags;
 	struct list_head tool_list;	/* To be used by tools such as ctracer */
+	struct list_head unspecified_types;
 	struct ptr_table types_table;
 	struct ptr_table functions_table;
 	struct ptr_table tags_table;
@@ -652,6 +653,22 @@ static inline struct llvm_annotation *tag__llvm_annotation(struct tag *tag)
 	return (struct llvm_annotation *)tag;
 }
 
+/** struct unspecified_type - representation of DW_TAG_unspecified_type.
+ *
+ *  @name   - DW_AT_name associated with this tag
+ *  @node   - a node for cu::unspecified_types list
+ */
+struct unspecified_type {
+	struct tag		tag;
+	const char		*name;
+	struct list_head	node;
+};
+
+static inline struct unspecified_type *tag__unspecified_type(struct tag *tag)
+{
+	return (struct unspecified_type *)tag;
+}
+
 /** struct namespace - base class for enums, structs, unions, typedefs, etc
  *
  * @tags - class_member, enumerators, etc
-- 
2.39.1

