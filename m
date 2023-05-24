Return-Path: <bpf+bounces-1136-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 340EE70EA28
	for <lists+bpf@lfdr.de>; Wed, 24 May 2023 02:19:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98BD41C20A97
	for <lists+bpf@lfdr.de>; Wed, 24 May 2023 00:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4F511360;
	Wed, 24 May 2023 00:19:08 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8FF11105
	for <bpf@vger.kernel.org>; Wed, 24 May 2023 00:19:08 +0000 (UTC)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A7B8E5;
	Tue, 23 May 2023 17:19:06 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4f4b0a0b557so169652e87.1;
        Tue, 23 May 2023 17:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684887545; x=1687479545;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3PVls7WLZ+o5X609MxSrgrx/lhV1Dg8H/O/RxemEgeU=;
        b=I+5LQIxZOz4vKSihxNvsKjJKTZIA8nQOnzpBhbF+SsdkFD94BHXGBky7YcqcJF2D5d
         Pv4ip419cWgPeUN+5cwUgFSFE4i1jrltMoaUrgfClHngGlYhKiY5cCsf5eVf7/m2bEhn
         pFybadc4n6y4VGrT/o2wCsNnUaAU1VH0ZxBRdkMhl1jUagSx/5g1HbiSQ+stysZq3e2H
         8twBkGo05+CEMEv4j1/W52eZYfGWqTHtZbqmFkj1QGHRndNPFH2u6rQw7CDncE3CQHAA
         ipqXJ5oyLdMRpn5ae0t82vnJb79OQJycxcUTF653nY5/v6ZRXqZlZodc3sBapYqBudkS
         ptEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684887545; x=1687479545;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3PVls7WLZ+o5X609MxSrgrx/lhV1Dg8H/O/RxemEgeU=;
        b=auMWMU01rpqsqtRxeqGlUsUh5lM0qCBUl9XPQ/uNQBk2dqFGo45rF+kpzb9xDq5Nly
         2ixSjYMrhVDsvWbn7HcPqnm/SYFNkYOzjo9G/N1LsF1lSo9e11MPMdrGks1qAMuvsYzw
         ZI6u7XeyfyJTdRxftvhnpwqAYbn6DDDuWba8MysgVJEcTIPKufgpeYCzSR5lMXK52ubQ
         EBpma+r4S0qpRvmoQPogU472HBnUilmirJmNc+42t4MR9WnRLuJlH5Aa6rvTvpBEpco0
         /DNvbDBFZxrG9jLbus1E9PuNvDRUmGoIiqQIWe3SHmSaiTHA/pOcpfIDXMpm3PBnnca4
         PXcg==
X-Gm-Message-State: AC+VfDz5ibMqKZKS9EBn9lTER62NVbDQ8H9+6jHCPAeemgvs3sNMF1g+
	fe7eCdhZooS6PoGRr9kuVw/hF5SA0z7LeQ==
X-Google-Smtp-Source: ACHHUZ4iuE8vaarUiACTbL3k5aFVWDvnx+eeq5qra+TXJl2LIXuMeu4WLado65u+kJevCoexT/kutw==
X-Received: by 2002:ac2:4354:0:b0:4f3:91a2:279 with SMTP id o20-20020ac24354000000b004f391a20279mr4002291lfl.61.1684887544536;
        Tue, 23 May 2023 17:19:04 -0700 (PDT)
Received: from bigfoot.. (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id w7-20020a19c507000000b004f138ab93c7sm1487305lfe.264.2023.05.23.17.19.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 17:19:04 -0700 (PDT)
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
Subject: [PATCH v3 dwarves 2/6] dwarf_loader: Track unspecified types in a separate list
Date: Wed, 24 May 2023 03:18:21 +0300
Message-Id: <20230524001825.2688661-3-eddyz87@gmail.com>
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
index ccf3194..dfed334 100644
--- a/dwarf_loader.c
+++ b/dwarf_loader.c
@@ -165,14 +165,19 @@ static struct dwarf_cu *dwarf_cu__new(struct cu *cu)
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
@@ -1386,6 +1391,33 @@ static struct tag *die__create_new_tag(Dwarf_Die *die, struct cu *cu)
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
 static struct btf_type_tag_ptr_type *die__create_new_btf_type_tag_ptr_type(Dwarf_Die *die, struct cu *cu)
 {
 	struct btf_type_tag_ptr_type *tag;
@@ -2186,10 +2218,10 @@ static struct tag *__die__process_tag(Dwarf_Die *die, struct cu *cu,
 	case DW_TAG_volatile_type:
 	case DW_TAG_atomic_type:
 		tag = die__create_new_tag(die, cu);		break;
-	case DW_TAG_unspecified_type:
-		tag = die__create_new_tag(die, cu);		break;
 	case DW_TAG_pointer_type:
 		tag = die__create_new_pointer_tag(die, cu, conf);	break;
+	case DW_TAG_unspecified_type:
+		tag = die__create_new_unspecified_type(die, cu, conf); break;
 	case DW_TAG_ptr_to_member_type:
 		tag = die__create_new_ptr_to_member_type(die, cu); break;
 	case DW_TAG_enumeration_type:
diff --git a/dwarves.c b/dwarves.c
index ed5c348..f989250 100644
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
index 54771d1..509ffbc 100644
--- a/dwarves.h
+++ b/dwarves.h
@@ -246,6 +246,7 @@ struct cu {
 	struct list_head node;
 	struct list_head tags;
 	struct list_head tool_list;	/* To be used by tools such as ctracer */
+	struct list_head unspecified_types;
 	struct ptr_table types_table;
 	struct ptr_table functions_table;
 	struct ptr_table tags_table;
@@ -686,6 +687,22 @@ static inline struct btf_type_tag_type *tag__btf_type_tag(struct tag *tag)
 	return (struct btf_type_tag_type *)tag;
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
2.40.1


