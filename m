Return-Path: <bpf+bounces-1139-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35AD670EA2D
	for <lists+bpf@lfdr.de>; Wed, 24 May 2023 02:20:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F22161C20A66
	for <lists+bpf@lfdr.de>; Wed, 24 May 2023 00:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B45115AF;
	Wed, 24 May 2023 00:19:13 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F52D15AD
	for <bpf@vger.kernel.org>; Wed, 24 May 2023 00:19:13 +0000 (UTC)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED806E9;
	Tue, 23 May 2023 17:19:10 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4f4bd608cf4so172923e87.1;
        Tue, 23 May 2023 17:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684887549; x=1687479549;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5deSMmOnlGRd7TDeA6ZSWGwY4ag2376qxIRAf1s1MPg=;
        b=Gb++9QcykfvmxxGMA/UYGBgQ4M3ZhXU04Mj8jV0Gj6d8xu8jH/U8dnogQYQjWe1+Lr
         FOaw1MdU6xxOtWjKbeLgKmZQFofK0d7l2hUluU5+UG6xssRNjk+smCqe+D2jzY7zSsB6
         VA29UD+51eHDR9TbF8Ha910QUXv8ajZTVLuyD/5VzBDfHAuhBlqvPpAYcOd5UWhRvFk1
         lMaYK/wzLMASS+hsOmtEmeP0MvzIXMlWFfvatSfvkhMHTFErQXpUDQhg5JfW8qz8aVh0
         0Gjyam0tN86Xc7O9W/3z8lFnPWpU4Y+WKlD15q3UDG8lldwAOr+wg2wUmbd21G/pGfn9
         Y0sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684887549; x=1687479549;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5deSMmOnlGRd7TDeA6ZSWGwY4ag2376qxIRAf1s1MPg=;
        b=GCWICbfLKy3Zydgu71JEHAwdj7FYtHqSUATI1Tj6235PSnYOjiYkFs0KShe4guB7Ia
         beoyv356mCmufCTRkF5CKrwStNv2NT0QNr+HqVYKoiwvSyVvrUkpZy4kvO/89QG1Ninb
         xvJU5watwLiN4zjI+B2ZHKSVE+h+aAtI6lzgM4mPqJanqyc37u7eXyFhnK6zqjkTcVAU
         h3WDbfPcCQLbDUOWQ9TOX/sVhWpG1nOhp6Ry/pgwf9pdXFFWm9PVG4Bp2KQ+BaVFOI2f
         Rn5juiMl8tiwF9748fcb2bMJZsCpnOXG/F3lcbxr7sBKzthPnJ2vXkQQIvt2YGMfoFu3
         gIQA==
X-Gm-Message-State: AC+VfDzQf/UZxma3s/WIMG9apRAzx/sUYuNahJG1lmJIBfRFhdIfzfXl
	CpgVn9XCQKQRAszJSH47zls/7dnRq11jRQ==
X-Google-Smtp-Source: ACHHUZ78tjmdEV1Aa1f+OzdfeUASdNolzOYS/io2m4I+zxCy/I7CHKPI61DVWV+crLZgS9YBsOFeBw==
X-Received: by 2002:ac2:4c27:0:b0:4f3:a87f:a87b with SMTP id u7-20020ac24c27000000b004f3a87fa87bmr5557579lfq.39.1684887548691;
        Tue, 23 May 2023 17:19:08 -0700 (PDT)
Received: from bigfoot.. (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id w7-20020a19c507000000b004f138ab93c7sm1487305lfe.264.2023.05.23.17.19.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 17:19:08 -0700 (PDT)
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
Subject: [PATCH v3 dwarves 5/6] dwarf_loader: move type tags before CVR qualifiers when necessary
Date: Wed, 24 May 2023 03:18:24 +0300
Message-Id: <20230524001825.2688661-6-eddyz87@gmail.com>
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
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

After discussion in [1] it was agreed to attach type tag annotations
of TYPE_TAG_SELF kind only to "base" types, specifically to:
- base types;
- arrays;
- pointers;
- structs
- unions;
- enums;
- typedefs.

And to not attach such tags to const/volatile/restrict derived types.
However, current Linux Kernel BTF validation code expects that all
type tags precede CVR qualifiers.

In other words, CLANG and GCC would generate tag chains like this:

  const -> volatile -> tag1 -> int

But kernel wants tag chain to be:

  tag1 -> const -> volatile -> int

This commit moves type tags before CVR qualifiers using a simplistic
algorithm and relies on libbpf's BTF deduplication algorithm for
cleanup.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 dwarf_loader.c | 210 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 210 insertions(+)

diff --git a/dwarf_loader.c b/dwarf_loader.c
index 2b50322..e764510 100644
--- a/dwarf_loader.c
+++ b/dwarf_loader.c
@@ -3134,12 +3134,222 @@ static int die__process(Dwarf_Die *die, struct cu *cu, struct conf_load *conf)
 	return 0;
 }
 
+/* LISP-style single-linked immutable list */
+struct string_list {
+	const char *string;
+	const struct string_list *next;
+};
+
+enum {
+	CONST = 1u << 1,
+	VOLATILE = 1u << 2,
+	RESTRICT = 1u << 3,
+};
+
+/* Create a type corresponding to @target_id wrapped in CVR qualifiers
+ * specified in @cvr.
+ *
+ * @target_id -  in: ID of a type to wrap with qualifiers
+ *              out: ID of the resulting qualified type.
+ */
+static int wrap_qualifiers(struct cu *cu, uint32_t cvr, uint32_t *target_id)
+{
+	struct {
+		uint16_t code;
+		bool present;
+	} qualifiers[3] = {
+		{ DW_TAG_restrict_type, cvr & RESTRICT },
+		{ DW_TAG_volatile_type, cvr & VOLATILE },
+		{ DW_TAG_const_type   , cvr & CONST },
+	};
+
+	for (uint32_t i = 0; i < 3; ++i) {
+		struct tag *tag;
+
+		if (!qualifiers[i].present)
+			continue;
+
+		tag = tag__alloc(cu, sizeof(*tag));
+		if (tag == NULL)
+			return -ENOMEM;
+
+		tag__init_dummy(tag, cu, qualifiers[i].code);
+		tag->type = *target_id;
+		if (cu__add_tag(cu, tag, target_id))
+			return -ENOMEM;
+	}
+
+	return 0;
+}
+
+/* Wrap @target_id with type tags specified by @tags, assign the
+ * @top_id as ID of the resulting type.
+ */
+static int wrap_type_tags(struct cu *cu, uint32_t top_id, uint32_t target_id,
+			  const struct string_list *tags)
+{
+	struct btf_type_tag_type *type_tag;
+	uint32_t running_id = target_id;
+	int ret = 0;
+
+	for (; tags != NULL; tags = tags->next) {
+		type_tag = new_btf_type_tag_type(cu, tags->string);
+		if (type_tag == NULL)
+			return -ENOMEM;
+
+		type_tag->tag.type = running_id;
+		if (tags->next != NULL) {
+			ret = cu__add_tag(cu, &type_tag->tag, &running_id);
+		} else {
+			struct tag *top_tag = cu__type(cu, top_id);
+
+			list_del_init(&top_tag->node);
+			cu__table_nullify_type_entry(cu, top_id);
+			cu__free(cu, top_tag);
+			ret = cu__add_tag_with_id(cu, &type_tag->tag, top_id);
+			break;
+		}
+	}
+
+	return ret;
+}
+
+/* Traverse CVR/type tag chain starting from @top_id and replace it
+ * with a chain starting from type tags.
+ *
+ * @top_id - first ID in the CVR/type tag chain, type entry
+ *           corresponding to this ID would be replaced.
+ * @id     - current ID in the CVR/type tag chain, used for recursive descend.
+ * @cvr    - CVR bits accumulated so far.
+ * @tags   - list of type tags accumulated so far.
+ */
+static int rebuild_type_tag_chain(struct cu *cu, uint32_t top_id, uint32_t id, uint32_t cvr,
+				  struct string_list *tags)
+{
+	struct string_list tag_node = {};
+	uint32_t qualified_id;
+	uint16_t dw_tag = 0;
+	struct tag *tag;
+	int ret;
+
+	tag = cu__type(cu, id);
+	if (tag != NULL)
+		dw_tag = tag->tag;
+
+	switch (dw_tag) {
+	case DW_TAG_const_type:
+		cvr |= CONST;
+		break;
+	case DW_TAG_volatile_type:
+		cvr |= VOLATILE;
+		break;
+	case DW_TAG_restrict_type:
+		cvr |= RESTRICT;
+		break;
+	case DW_TAG_LLVM_annotation:
+		tag_node.string = tag__btf_type_tag(tag)->value;
+		tag_node.next = tags;
+		tags = &tag_node;
+		break;
+	default:
+		if (cvr == 0 || tags == NULL)
+			return 0;
+
+		qualified_id = id;
+		ret = wrap_qualifiers(cu, cvr, &qualified_id);
+		if (ret)
+			return ret;
+		return wrap_type_tags(cu, top_id, qualified_id, tags);
+	}
+
+	return rebuild_type_tag_chain(cu, top_id, tag->type, cvr, tags);
+}
+
+/* After some discussion in [1] it was agreed to attach type tag
+ * annotations of TYPE_TAG_SELF kind only to "base" types,
+ * specifically to:
+ * - base types;
+ * - arrays;
+ * - pointers;
+ * - structs
+ * - unions;
+ * - enums;
+ * - typedefs.
+ *
+ * And to not attach such tags to const/volatile/restrict derived types.
+ * However, current Linux Kernel BTF validation code expects that all
+ * type tags precede CVR qualifiers.
+ *
+ * In other words, CLANG and GCC would generate tag chains like this:
+ *
+ *   const -> volatile -> tag1 -> int
+ *
+ * But kernel wants tag chain to be:
+ *
+ *   tag1 -> const -> volatile -> int
+ *
+ * The code below moves type tags before CVR qualifiers in following steps
+ * for each CVR-type:
+ * - recursively traverse CVR / TYPE_TAG chain, accumulating CVR bits
+ *   and type tags
+ * - rebuild the chain with type tags put at front
+ * - for the first entry in a chain replace original CVR type entry
+ *   with type tag entry, so that all links to this type remain valid
+ *
+ * For example, the following chain:
+ *
+ *   const -> volatile -> tag1 -> int
+ *   id: 1    id: 2       id: 3   id: 4
+ *
+ * Would be rewritten as:
+ *
+ *   tag1 -> const -> volatile -> int
+ *   id: 1   id: 5    id: 6       id: 4
+ *                                 ^
+ *   tag1 -> volatile -------------|
+ *   id: 2   id: 7                 |
+ *                                 |
+ *   tag1 -------------------------'
+ *   id: 3
+ *
+ * The unnecessary duplicate chains 6->4 and 7->4 would be removed by
+ * libbpf's BTF deduplication algorithm.
+ *
+ * [1] https://reviews.llvm.org/D143967
+ */
+static int move_type_tags_before_cvr_qualifiers(struct cu *cu)
+{
+	uint32_t N = cu->types_table.nr_entries;
+	struct tag *tag;
+	int ret = 0;
+
+	for (uint32_t id = 1; id < N; ++id) {
+		tag = cu__type(cu, id);
+		if (tag == NULL)
+			continue;
+
+		if (tag->tag != DW_TAG_const_type &&
+		    tag->tag != DW_TAG_volatile_type &&
+		    tag->tag != DW_TAG_restrict_type)
+			continue;
+
+		ret = rebuild_type_tag_chain(cu, id, id, 0, NULL);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 static int die__process_and_recode(Dwarf_Die *die, struct cu *cu, struct conf_load *conf)
 {
 	int ret = die__process(die, cu, conf);
 	if (ret != 0)
 		return ret;
 	ret = cu__recode_dwarf_types(cu);
+	if (ret != 0)
+		return ret;
+	ret = move_type_tags_before_cvr_qualifiers(cu);
 	if (ret != 0)
 		return ret;
 
-- 
2.40.1


