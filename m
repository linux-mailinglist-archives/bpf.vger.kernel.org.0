Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 686716A6056
	for <lists+bpf@lfdr.de>; Tue, 28 Feb 2023 21:24:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbjB1UYi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Feb 2023 15:24:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjB1UYh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Feb 2023 15:24:37 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B58002CC47;
        Tue, 28 Feb 2023 12:24:35 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id s26so45007779edw.11;
        Tue, 28 Feb 2023 12:24:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677615874;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/ICTYh72EXu0Mx7pKwfP022MYocxih8ckgplCVCuLPs=;
        b=YlxLg1jZDAEenpAsJ5iRwmpYSMhXyCYQIg1r07BREcgNLN1rR1K7PWOGcaBivHqnNr
         +NLvrxCXHJC6gFX/3jNe8JIQpQoiVmSzNBLRlwzhRfnT3N/baGbDfaus6lIECCzpDlvi
         JCBDyjKd10At+tcfXelem2bappa1zj9EpNrOk/VJ9m70+mwIkKdODJOibXfM2PfMOBEs
         9gPh4Jujz5hIwxkxUX77dq+xwLhMbuqzvYHt0/IqCzIOxCeMKN087AFgpTdYM63vi8LD
         NxiLZhuRJEt0HKbeF37olRGum33QR+JWKmRWXxgNJCrqf6By7ZjLVcRK0zNsajn+MQka
         LyRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677615874;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/ICTYh72EXu0Mx7pKwfP022MYocxih8ckgplCVCuLPs=;
        b=Dljr3hGFL+a963Bv31Eh6ye/eYxwdkiIdDmGkY5g2li33mMsSEvAv2Cx2jJ7D9JFMl
         SRoDycPcrsaBm7+D/ohq2zheub1BLNxcKMhvPSXLm1nwI3nqieoGBDz7Q09jwXZMVFOT
         xZnF/RC+c0gL8U+kLq1CzbfASjuEvvykMzmvrVNel6Ch4fCcJt12uL4Q6cpYiMpI3IWF
         mFal4pmhVz7GpKz+xfGxdlEFolfOKxRWBlp9e5J1scyA81QMX2k52l5sJiing8GVPKxW
         EtCluDfTRJfuwIKvGJO0qEYOB7QT4Vmk7bmYfsz/5gpzB5AtaYvvZ++7f2vfyyKZOwEW
         86Wg==
X-Gm-Message-State: AO0yUKVU4BaZAifle/txE5sQ0NZi4m6Ai1wNwlPkiBFJep8fdFOuLG62
        GcMqDWoMLhLjzxe/GJEW8NqjX7Gt7upvWw==
X-Google-Smtp-Source: AK7set8K/PMV3lbxYxs4Z7q6TOeR0uj27eh7XAfx5Aar4VXduRGBYmGR3Iy6LNyHMpPnPkELsEfeAA==
X-Received: by 2002:a17:907:628a:b0:8f3:f976:ac13 with SMTP id nd10-20020a170907628a00b008f3f976ac13mr4962758ejc.10.1677615873882;
        Tue, 28 Feb 2023 12:24:33 -0800 (PST)
Received: from bigfoot.. (boundsly.muster.volia.net. [93.72.16.93])
        by smtp.gmail.com with ESMTPSA id e21-20020a170906375500b008d398a4e687sm4848825ejc.158.2023.02.28.12.24.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 12:24:33 -0800 (PST)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     dwarves@vger.kernel.org, arnaldo.melo@gmail.com
Cc:     bpf@vger.kernel.org, kernel-team@fb.com, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, yhs@fb.com,
        Eduard Zingerman <eddyz87@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Matt Bobrowski <mattbobrowski@google.com>
Subject: [PATCH dwarves] dwarf_loader: Fix for BTF id drift caused by adding unspecified types
Date:   Tue, 28 Feb 2023 22:23:57 +0200
Message-Id: <20230228202357.2766051-1-eddyz87@gmail.com>
X-Mailer: git-send-email 2.39.1
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

Recent changes to handle unspecified types (see [1]) cause BTF ID drift.

Specifically, the intent of commits [2], [3] and [4] is to render
references to unspecified types as void type.
However, as a consequence:
- in `die__process_unit()` call to `cu__add_tag()` allocates `small_id`
  for unspecified type tags and adds these tags to `cu->types_table`;
- `btf_encoder__encode_tag()` skips generation of BTF entries for
  `DW_TAG_unspecified_type` tags.

Such logic causes ID drift if unspecified type is not the last type
processed for compilation unit. `small_id` of each type following
unspecified type in the `cu->types_table` would have its BTF id off by -1.
Thus, rendering references established on recode phase invalid.

This commit reverts `unspecified_type` id/tag tracking.
Instead, the following is done:
- `small_id` for unspecified type tags is set to 0, thus reference to
  unspecified type tag would render BTF id of a `void` on recode phase;
- unspecified type tags are not added to `cu->types_table`.

This change also happens to fix issue reported in [5], the gist of
that issue is that the field `encoder->unspecified_type` is set but
not reset by function `btf_encoder__encode_cu()`. Thus, the following
sequence of events might occur when BTF encoding is requested:
- CU with unspecified type is processed:
  - unspecified type id is 42
  - encoder->unspecified_type is set to 42
- CU without unspecified type is processed next using the same
  `encoder` object:
  - some `struct foo` has id 42 in this CU
  - the references to `struct foo` are set 0 by function
    `btf_encoder__tag_type()`.

[1] https://lore.kernel.org/all/Y0R7uu3s%2FimnvPzM@kernel.org/
[2] bcc648a10cbc ("btf_encoder: Encode DW_TAG_unspecified_type returning routines as void")
[3] cffe5e1f75e1 ("core: Record if a CU has a DW_TAG_unspecified_type")
[4] 75e0fe28bb02 ("core: Add DW_TAG_unspecified_type to tag__is_tag_type() set")
[5] https://lore.kernel.org/bpf/Y%2FP1yxAuV6Wj3A0K@google.com/

Fixes: bcc648a10cbc ("btf_encoder: Encode DW_TAG_unspecified_type returning routines as void")
Fixes: 52b25808e44a ("btf_encoder: Store type_id_off, unspecified type in encoder")
Tested-by: KP Singh <kpsingh@kernel.org>
Reported-by: Matt Bobrowski <mattbobrowski@google.com>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 btf_encoder.c  |  8 --------
 dwarf_loader.c | 25 +++++++++++++++++++------
 dwarves.h      |  8 --------
 3 files changed, 19 insertions(+), 22 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index da776f4..07a9dc5 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -69,7 +69,6 @@ struct btf_encoder {
 	const char	  *filename;
 	struct elf_symtab *symtab;
 	uint32_t	  type_id_off;
-	uint32_t	  unspecified_type;
 	int		  saved_func_cnt;
 	bool		  has_index_type,
 			  need_index_type,
@@ -635,11 +634,6 @@ static int32_t btf_encoder__tag_type(struct btf_encoder *encoder, uint32_t tag_t
 	if (tag_type == 0)
 		return 0;
 
-	if (encoder->unspecified_type && tag_type == encoder->unspecified_type) {
-		// No provision for encoding this, turn it into void.
-		return 0;
-	}
-
 	return encoder->type_id_off + tag_type;
 }
 
@@ -1746,8 +1740,6 @@ int btf_encoder__encode_cu(struct btf_encoder *encoder, struct cu *cu, struct co
 
 	encoder->cu = cu;
 	encoder->type_id_off = btf__type_cnt(encoder->btf) - 1;
-	if (encoder->cu->unspecified_type.tag)
-		encoder->unspecified_type = encoder->cu->unspecified_type.type;
 
 	if (!encoder->has_index_type) {
 		/* cu__find_base_type_by_name() takes "type_id_t *id" */
diff --git a/dwarf_loader.c b/dwarf_loader.c
index 014e130..c37bd7b 100644
--- a/dwarf_loader.c
+++ b/dwarf_loader.c
@@ -2155,8 +2155,7 @@ static struct tag *__die__process_tag(Dwarf_Die *die, struct cu *cu,
 	case DW_TAG_atomic_type:
 		tag = die__create_new_tag(die, cu);		break;
 	case DW_TAG_unspecified_type:
-		cu->unspecified_type.tag =
-			tag = die__create_new_tag(die, cu);     break;
+		tag = die__create_new_tag(die, cu);		break;
 	case DW_TAG_pointer_type:
 		tag = die__create_new_pointer_tag(die, cu, conf);	break;
 	case DW_TAG_ptr_to_member_type:
@@ -2219,13 +2218,27 @@ static int die__process_unit(Dwarf_Die *die, struct cu *cu, struct conf_load *co
 			continue;
 		}
 
-		uint32_t id;
-		cu__add_tag(cu, tag, &id);
+		uint32_t id = 0;
+		/* There is no BTF representation for unspecified types.
+		 * Currently we want such types to be represented as `void`
+		 * (and thus skip BTF encoding).
+		 *
+		 * As BTF encoding is skipped, such types must not be added to type table,
+		 * otherwise an ID for a type would be allocated and we would be forced
+		 * to put something in BTF at this ID.
+		 * Thus avoid `cu__add_tag()` call for such types.
+		 *
+		 * On the other hand, there might be references to this type from other
+		 * tags, so `dwarf_cu__find_tag_by_ref()` must return something.
+		 * Thus call `cu__hash()` for such types.
+		 *
+		 * Note, that small_id of zero would be assigned to unspecified type entry.
+		 */
+		if (tag->tag != DW_TAG_unspecified_type)
+			cu__add_tag(cu, tag, &id);
 		cu__hash(cu, tag);
 		struct dwarf_tag *dtag = tag->priv;
 		dtag->small_id = id;
-		if (tag->tag == DW_TAG_unspecified_type)
-			cu->unspecified_type.type = id;
 	} while (dwarf_siblingof(die, die) == 0);
 
 	return 0;
diff --git a/dwarves.h b/dwarves.h
index 5074cf8..e92b2fd 100644
--- a/dwarves.h
+++ b/dwarves.h
@@ -236,10 +236,6 @@ struct debug_fmt_ops {
 
 #define ARCH_MAX_REGISTER_PARAMS	8
 
-/*
- * unspecified_type: If this CU has a DW_TAG_unspecified_type, as BTF doesn't have a representation for this
- * 		     and thus we need to check functions returning this to convert it to void.
- */
 struct cu {
 	struct list_head node;
 	struct list_head tags;
@@ -248,10 +244,6 @@ struct cu {
 	struct ptr_table functions_table;
 	struct ptr_table tags_table;
 	struct rb_root	 functions;
-	struct {
-		struct tag	 *tag;
-		uint32_t	 type;
-	} unspecified_type;
 	char		 *name;
 	char		 *filename;
 	void 		 *priv;
-- 
2.39.1

