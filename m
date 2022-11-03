Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 279F6617E4B
	for <lists+bpf@lfdr.de>; Thu,  3 Nov 2022 14:45:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbiKCNpz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Nov 2022 09:45:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230433AbiKCNpr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Nov 2022 09:45:47 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B97910DA
        for <bpf@vger.kernel.org>; Thu,  3 Nov 2022 06:45:45 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id bj12so5263970ejb.13
        for <bpf@vger.kernel.org>; Thu, 03 Nov 2022 06:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mSHbaQdbOFkxTwKGJSCJxiziSRB4K88SMwWoaXwMZso=;
        b=K1IsO+XOZ7ZwTEy6ZkkTPIgQy81gwZ9Y5GbZPCElX39XeNcooqlvUwFrtT7l2g0ZIX
         VjlmQ6JNpBK+sifmZdsI2qyDTEvY6lJBfmYOJUhdgNjv4Uj+T3eakL8sCzamvaZjCmyg
         WennVu1MltpORIwwodkwy8zxcMcnFI3Fzlp1hVCF2ojKDmUg9QvajyoRm1s0ZPbCEB0n
         iwoFNccKim9iApHGPOSwZWg2JgVanNsxqzSxxuNZVmf25VahHYhPmS23d6EtF6dxkFFH
         K9Howe7U3r/+8lusY2S/gWYC19iZk1Hu2JI3SWTyPDQp5MAgE4DSliPuWNqBmHib/M53
         7rPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mSHbaQdbOFkxTwKGJSCJxiziSRB4K88SMwWoaXwMZso=;
        b=k4gfDxokq8Rk2Ph+bs+sWLcA0cBJmT63Dsd0dgrDFrK9BQuEQ511fbC1oJlVhrDcM5
         FDSeq83at5pTaYSQ4toPWjwRgygxph9cKPho1oPVyj/Ed0ybgp8SL6oS3FrDK3Pvc3es
         9vQ7w6vJS6iFS6CV4W/GsPFxjhd9k1Vh0/j7W8VmTcQ6OtzvQ5yzPYOWFTuJXQZtm+h2
         RWuJGmsvlFOJJ4Ee5EW3p9hCjJ03JxRLRHXKnMQyzILXd8KRxJJUGt3aAUgYw4O/qKgo
         YygJrtBDqrLJ+MGHBckTMbpHhXERhX08Fm2d5SC01IjZ+yjV+I6SRi1BN6byTO8sqUtE
         8f3g==
X-Gm-Message-State: ACrzQf251oZoDM8+KE6RfDgb5kQbn0d3PL39omkX5fEmMpvDzJl9Tqui
        P/xLU50CeBSXyqkkanF5JMGj6Yp4/iJvjAo+
X-Google-Smtp-Source: AMsMyM6VGYIfoNPu8o0LtThFP8fKq6ekiuOVFQWZomM+r2V813rR6HU3T73m2GE7bu6GC4C/chrNBg==
X-Received: by 2002:a17:907:d91:b0:7ad:e178:9fe5 with SMTP id go17-20020a1709070d9100b007ade1789fe5mr18169583ejc.476.1667483143791;
        Thu, 03 Nov 2022 06:45:43 -0700 (PDT)
Received: from pluto.. (boundsly.muster.volia.net. [93.72.16.93])
        by smtp.gmail.com with ESMTPSA id n20-20020a05640206d400b00443d657d8a4sm532766edy.61.2022.11.03.06.45.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 06:45:43 -0700 (PDT)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, kernel-team@fb.com,
        yhs@fb.com, alan.maguire@oracle.com,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next 1/2] libbpf: __attribute__((btf_decl_tag("..."))) for btf dump in C format
Date:   Thu,  3 Nov 2022 15:45:21 +0200
Message-Id: <20221103134522.2764601-1-eddyz87@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Clang's `__attribute__((btf_decl_tag("...")))` is represented in BTF
as a record of kind BTF_KIND_DECL_TAG with `type` field pointing to
the type annotated with this attribute. This commit adds
reconstitution of such attributes for BTF dump in C format.

BTF doc says that BTF_KIND_DECL_TAGs should follow a target type but
this is not enforced and tests don't honor this restriction.
This commit uses hashmap to map types to the list of decl tags.
The hashmap is filled by `btf_dump_assign_decl_tags` function called
from `btf_dump__new`.

It is assumed that total number of types annotated with decl tags is
relatively small, thus some space is saved by using hashmap instead of
adding a new field to `struct btf_dump_type_aux_state`.

It is assumed that list of decl tags associated with a single type is
small. Thus the list is represented by an array which grows linearly.

To accommodate older Clang versions decl tags are dumped using the
following macro:

 #if __has_attribute(btf_decl_tag)
 #  define __btf_decl_tag(x) __attribute__((btf_decl_tag(x)))
 #else
 #  define __btf_decl_tag(x)
 #endif

The macro definition is emitted upon first call to `btf_dump__dump_type`.

Clang allows to attach btf_decl_tag attributes to the following kinds
of items:
- struct/union         supported
- struct/union field   supported
- typedef              supported
- function             not applicable
- function parameter   not applicable
- variable             not applicable

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/lib/bpf/btf_dump.c | 163 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 160 insertions(+), 3 deletions(-)

diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
index bf0cc0e986dd..7bf14e2ed910 100644
--- a/tools/lib/bpf/btf_dump.c
+++ b/tools/lib/bpf/btf_dump.c
@@ -75,6 +75,20 @@ struct btf_dump_data {
 	bool is_array_char;
 };
 
+/*
+ * An arbitrary limit for a number of decl tags that could be attached
+ * to a type and it's fields combined.
+ */
+#define MAX_DECL_TAGS_PER_ID			256
+
+/*
+ * An array of ids of BTF_DECL_TAG objects associated with a specific type.
+ */
+struct decl_tag_array {
+	__u32 cnt;
+	__u32 tag_ids[0];
+};
+
 struct btf_dump {
 	const struct btf *btf;
 	btf_dump_printf_fn_t printf_fn;
@@ -111,6 +125,13 @@ struct btf_dump {
 	 * name occurrences
 	 */
 	struct hashmap *ident_names;
+	/*
+	 * maps type id to decl_tag_array, assume that relatively small
+	 * fraction of types has btf_decl_tag's attached
+	 */
+	struct hashmap *decl_tags;
+	/* indicates whether '#define __btf_decl_tag ...' was printed */
+	bool btf_decl_tag_is_defined;
 	/*
 	 * data for typed display; allocated if needed.
 	 */
@@ -127,6 +148,16 @@ static bool str_equal_fn(const void *a, const void *b, void *ctx)
 	return strcmp(a, b) == 0;
 }
 
+static size_t identity_hash_fn(const void *key, void *ctx)
+{
+	return (size_t)key;
+}
+
+static bool identity_equal_fn(const void *k1, const void *k2, void *ctx)
+{
+	return k1 == k2;
+}
+
 static const char *btf_name_of(const struct btf_dump *d, __u32 name_off)
 {
 	return btf__name_by_offset(d->btf, name_off);
@@ -143,6 +174,7 @@ static void btf_dump_printf(const struct btf_dump *d, const char *fmt, ...)
 
 static int btf_dump_mark_referenced(struct btf_dump *d);
 static int btf_dump_resize(struct btf_dump *d);
+static int btf_dump_assign_decl_tags(struct btf_dump *d);
 
 struct btf_dump *btf_dump__new(const struct btf *btf,
 			       btf_dump_printf_fn_t printf_fn,
@@ -179,11 +211,21 @@ struct btf_dump *btf_dump__new(const struct btf *btf,
 		d->ident_names = NULL;
 		goto err;
 	}
+	d->decl_tags = hashmap__new(identity_hash_fn, identity_equal_fn, NULL);
+	if (IS_ERR(d->decl_tags)) {
+		err = PTR_ERR(d->decl_tags);
+		d->decl_tags = NULL;
+		goto err;
+	}
 
 	err = btf_dump_resize(d);
 	if (err)
 		goto err;
 
+	err = btf_dump_assign_decl_tags(d);
+	if (err)
+		goto err;
+
 	return d;
 err:
 	btf_dump__free(d);
@@ -232,7 +274,8 @@ static void btf_dump_free_names(struct hashmap *map)
 
 void btf_dump__free(struct btf_dump *d)
 {
-	int i;
+	int i, bkt;
+	struct hashmap_entry *cur;
 
 	if (IS_ERR_OR_NULL(d))
 		return;
@@ -248,14 +291,22 @@ void btf_dump__free(struct btf_dump *d)
 	free(d->cached_names);
 	free(d->emit_queue);
 	free(d->decl_stack);
-	btf_dump_free_names(d->type_names);
-	btf_dump_free_names(d->ident_names);
+	if (d->type_names)
+		btf_dump_free_names(d->type_names);
+	if (d->ident_names)
+		btf_dump_free_names(d->ident_names);
+	if (d->decl_tags) {
+		hashmap__for_each_entry(d->decl_tags, cur, bkt)
+			free(cur->value);
+		hashmap__free(d->decl_tags);
+	}
 
 	free(d);
 }
 
 static int btf_dump_order_type(struct btf_dump *d, __u32 id, bool through_ptr);
 static void btf_dump_emit_type(struct btf_dump *d, __u32 id, __u32 cont_id);
+static void btf_dump_maybe_define_btf_decl_tag(struct btf_dump *d);
 
 /*
  * Dump BTF type in a compilable C syntax, including all the necessary
@@ -284,6 +335,8 @@ int btf_dump__dump_type(struct btf_dump *d, __u32 id)
 	if (err)
 		return libbpf_err(err);
 
+	btf_dump_maybe_define_btf_decl_tag(d);
+
 	d->emit_queue_cnt = 0;
 	err = btf_dump_order_type(d, id, false);
 	if (err < 0)
@@ -373,6 +426,61 @@ static int btf_dump_mark_referenced(struct btf_dump *d)
 	return 0;
 }
 
+/*
+ * This hashmap lookup is used in several places, so extract it as a
+ * function to hide all the ceremony with casts and NULL assignment.
+ */
+static struct decl_tag_array *btf_dump_find_decl_tags(struct btf_dump *d, __u32 id)
+{
+	struct decl_tag_array *decl_tags = NULL;
+
+	hashmap__find(d->decl_tags, (void *)(uintptr_t)id, (void **)&decl_tags);
+
+	return decl_tags;
+}
+
+/*
+ * Scans all BTF objects looking for BTF_KIND_DECL_TAG entries.
+ * The id's of the entries are stored in the `btf_dump.decl_tags` table,
+ * grouped by a target type.
+ */
+static int btf_dump_assign_decl_tags(struct btf_dump *d)
+{
+	__u32 id, new_cnt, type_cnt = btf__type_cnt(d->btf);
+	struct decl_tag_array *decl_tags;
+	const struct btf_type *t;
+	int err;
+
+	for (id = 1; id < type_cnt; id++) {
+		t = btf__type_by_id(d->btf, id);
+		if (!btf_is_decl_tag(t))
+			continue;
+
+		decl_tags = btf_dump_find_decl_tags(d, t->type);
+		/* Assume small number of decl tags per id, increase array size by 1 */
+		new_cnt = decl_tags ? decl_tags->cnt + 1 : 1;
+		if (new_cnt > MAX_DECL_TAGS_PER_ID)
+			return -ERANGE;
+
+		/* Allocate new_cnt + 1 to account for decl_tag_array header */
+		decl_tags = libbpf_reallocarray(decl_tags, new_cnt + 1, sizeof(__u32));
+		if (!decl_tags)
+			return -ENOMEM;
+
+		err = hashmap__insert(d->decl_tags, (void *)(uintptr_t)t->type, decl_tags,
+				      HASHMAP_SET, NULL, NULL);
+		if (err) {
+			free(decl_tags);
+			return err;
+		}
+
+		decl_tags->tag_ids[new_cnt - 1] = id;
+		decl_tags->cnt = new_cnt;
+	}
+
+	return 0;
+}
+
 static int btf_dump_add_emit_queue_id(struct btf_dump *d, __u32 id)
 {
 	__u32 *new_queue;
@@ -899,6 +1007,51 @@ static void btf_dump_emit_bit_padding(const struct btf_dump *d,
 	}
 }
 
+/*
+ * Define __btf_decl_tag to be either __attribute__ or noop.
+ */
+static void btf_dump_maybe_define_btf_decl_tag(struct btf_dump *d)
+{
+	if (d->btf_decl_tag_is_defined || !hashmap__size(d->decl_tags))
+		return;
+
+	d->btf_decl_tag_is_defined = true;
+	btf_dump_printf(d, "#if __has_attribute(btf_decl_tag)\n");
+	btf_dump_printf(d, "#  define __btf_decl_tag(x) __attribute__((btf_decl_tag(x)))\n");
+	btf_dump_printf(d, "#else\n");
+	btf_dump_printf(d, "#  define __btf_decl_tag(x)\n");
+	btf_dump_printf(d, "#endif\n\n");
+}
+
+/*
+ * Emits a list of __btf_decl_tag(...) attributes attached to some type.
+ * Decl tags attached to a type and to it's fields reside in a same
+ * list, thus use component_idx to filter out relevant tags:
+ * - component_idx == -1 designates the type itself;
+ * - component_idx >=  0 designates specific field.
+ */
+static void btf_dump_emit_decl_tags(struct btf_dump *d,
+				    struct decl_tag_array *decl_tags,
+				    int component_idx)
+{
+	struct btf_type *decl_tag_t;
+	const char *decl_tag_text;
+	struct btf_decl_tag *tag;
+	__u32 i;
+
+	if (!decl_tags)
+		return;
+
+	for (i = 0; i < decl_tags->cnt; ++i) {
+		decl_tag_t = btf_type_by_id(d->btf, decl_tags->tag_ids[i]);
+		tag = btf_decl_tag(decl_tag_t);
+		if (tag->component_idx != component_idx)
+			continue;
+		decl_tag_text = btf__name_by_offset(d->btf, decl_tag_t->name_off);
+		btf_dump_printf(d, " __btf_decl_tag(\"%s\")", decl_tag_text);
+	}
+}
+
 static void btf_dump_emit_struct_fwd(struct btf_dump *d, __u32 id,
 				     const struct btf_type *t)
 {
@@ -913,6 +1066,7 @@ static void btf_dump_emit_struct_def(struct btf_dump *d,
 				     const struct btf_type *t,
 				     int lvl)
 {
+	struct decl_tag_array *decl_tags = btf_dump_find_decl_tags(d, id);
 	const struct btf_member *m = btf_members(t);
 	bool is_struct = btf_is_struct(t);
 	int align, i, packed, off = 0;
@@ -945,6 +1099,7 @@ static void btf_dump_emit_struct_def(struct btf_dump *d,
 			m_sz = max((__s64)0, btf__resolve_size(d->btf, m->type));
 			off = m_off + m_sz * 8;
 		}
+		btf_dump_emit_decl_tags(d, decl_tags, i);
 		btf_dump_printf(d, ";");
 	}
 
@@ -964,6 +1119,7 @@ static void btf_dump_emit_struct_def(struct btf_dump *d,
 	btf_dump_printf(d, "%s}", pfx(lvl));
 	if (packed)
 		btf_dump_printf(d, " __attribute__((packed))");
+	btf_dump_emit_decl_tags(d, decl_tags, -1);
 }
 
 static const char *missing_base_types[][2] = {
@@ -1104,6 +1260,7 @@ static void btf_dump_emit_typedef_def(struct btf_dump *d, __u32 id,
 
 	btf_dump_printf(d, "typedef ");
 	btf_dump_emit_type_decl(d, t->type, name, lvl);
+	btf_dump_emit_decl_tags(d, btf_dump_find_decl_tags(d, id), -1);
 }
 
 static int btf_dump_push_decl_stack_id(struct btf_dump *d, __u32 id)
-- 
2.34.1

