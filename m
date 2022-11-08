Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED9FD62184E
	for <lists+bpf@lfdr.de>; Tue,  8 Nov 2022 16:32:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233627AbiKHPcE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Nov 2022 10:32:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231740AbiKHPcE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Nov 2022 10:32:04 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4657BDF4E
        for <bpf@vger.kernel.org>; Tue,  8 Nov 2022 07:32:02 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id k8so21595473wrh.1
        for <bpf@vger.kernel.org>; Tue, 08 Nov 2022 07:32:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jT/LgpzUWfslmQLEkAk6w3HDvORHoZAt5YV1DAHShCQ=;
        b=Nxy+9/KxDe6gFxRauQYLlZ8GTbO2L1fkjJ6CniRQ8jejztgHQdr5VDxLm2KNh7uvik
         pT2n2N5jUQmbiNuP3/Ed6l0SZFMlUnF4cPokbNtknmg2bUZKNmCY2RJTcQLOJkpAgKzA
         yKhiVn2uf9GqLTS8sC8VbH5kyFJXIv6OzKE2s5zsMLl9MkBZGW4gKnjWtNvSYFtSDD1Z
         xz1tVbWX4AQSVPtYMHhw1/LxDrW5hpHg1N9u95KVWxbW8QQ9iN7WddqoIe6Ji3NVE+zf
         rqhSCExBtGU+zFL7LEN9f6wcYhn71Xu/CZATfw5eK7DCiA1Z9lQMD8EPfSjIos7pOm7o
         aLSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jT/LgpzUWfslmQLEkAk6w3HDvORHoZAt5YV1DAHShCQ=;
        b=OvYg+BLtGRTFGmIfzm/N2ECWcMur0+igiYHyeaiz5eMyWYpIzfexpsCwPPRGb9vjbl
         jg+S2q5+WDbKYb+e1ln8XECFIndWD7CfltEb7P4CntWsLv7BKN3GR6EL9KY73uHscjiv
         uPccRywX1MA8PCyBSae5SZgzVMgeehiOKnILZnFHgdBHGoM2Zgcp0gwXhFbvkYv5OlR2
         Wsa0LQ6xWAt4PPZhmqL1RjexlSwXl0/ewWIECdcv21WxZBFlYnW0RSMtYpoHmgOgKRWG
         5im/t6u9pJbN/LUlqqg2u9TigId3dlRfME1Pf6P+lBfsDAqNdMzBxuVoXcaNROQU/tmA
         1kYQ==
X-Gm-Message-State: ACrzQf2Vu15WYAHAgKjgwrvvAZ5M7vhFiD37Zq67wH5wxXWMXvI6WPOw
        UMXYO8e0FIKMFrS2lm3UtgKx1fGL1I0WwWbe
X-Google-Smtp-Source: AMsMyM77LajTjsFksQ2gHXhjkqqLWVa/4dKAyVnzxbK9KCQ7yxBVf2Fs65gOYEVvMeLCiCaQ16YxEw==
X-Received: by 2002:adf:ffc2:0:b0:236:61e8:de52 with SMTP id x2-20020adfffc2000000b0023661e8de52mr36097683wrs.59.1667921520341;
        Tue, 08 Nov 2022 07:32:00 -0800 (PST)
Received: from pluto.. (boundsly.muster.volia.net. [93.72.16.93])
        by smtp.gmail.com with ESMTPSA id e5-20020adfef05000000b00225307f43fbsm10666822wro.44.2022.11.08.07.31.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 07:31:59 -0800 (PST)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, kernel-team@fb.com,
        yhs@fb.com, Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v2 1/3] libbpf: __attribute__((btf_decl_tag("..."))) for btf dump in C format
Date:   Tue,  8 Nov 2022 17:31:33 +0200
Message-Id: <20221108153135.491383-2-eddyz87@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221108153135.491383-1-eddyz87@gmail.com>
References: <20221108153135.491383-1-eddyz87@gmail.com>
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

It is assumed that the list of decl tags associated with a single type
is small. Thus the list is represented by an array which grows
linearly.

To accommodate older Clang versions decl tags are dumped using the
following macro:

 #if __has_attribute(btf_decl_tag)
 #define __btf_decl_tag(x) __attribute__((btf_decl_tag(x)))
 #else
 #define __btf_decl_tag(x)
 #endif

The macro definition is emitted upon first call to `btf_dump__dump_type`.

Clang allows to attach btf_decl_tag attributes to the following kinds
of items:
- struct/union                   supported
- struct/union field             supported
- typedef                        supported
- global variables               supported
- function prototype parameters  supported
- function                       not applicable
- function parameter             not applicable
- local variables                not applicable

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/lib/bpf/btf_dump.c | 186 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 178 insertions(+), 8 deletions(-)

diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
index bf0cc0e986dd..a87132b5fc33 100644
--- a/tools/lib/bpf/btf_dump.c
+++ b/tools/lib/bpf/btf_dump.c
@@ -75,6 +75,14 @@ struct btf_dump_data {
 	bool is_array_char;
 };
 
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
@@ -111,6 +119,18 @@ struct btf_dump {
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
+	/*
+	 * next id to be scanned for decl tags presence, needed to update
+	 * decl_tags map when dump_type calls are interleaved with BTF updates.
+	 */
+	__u32 next_decl_tag_scan_id;
 	/*
 	 * data for typed display; allocated if needed.
 	 */
@@ -127,6 +147,16 @@ static bool str_equal_fn(const void *a, const void *b, void *ctx)
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
@@ -143,6 +173,7 @@ static void btf_dump_printf(const struct btf_dump *d, const char *fmt, ...)
 
 static int btf_dump_mark_referenced(struct btf_dump *d);
 static int btf_dump_resize(struct btf_dump *d);
+static int btf_dump_assign_decl_tags(struct btf_dump *d);
 
 struct btf_dump *btf_dump__new(const struct btf *btf,
 			       btf_dump_printf_fn_t printf_fn,
@@ -170,20 +201,28 @@ struct btf_dump *btf_dump__new(const struct btf *btf,
 	d->type_names = hashmap__new(str_hash_fn, str_equal_fn, NULL);
 	if (IS_ERR(d->type_names)) {
 		err = PTR_ERR(d->type_names);
-		d->type_names = NULL;
 		goto err;
 	}
 	d->ident_names = hashmap__new(str_hash_fn, str_equal_fn, NULL);
 	if (IS_ERR(d->ident_names)) {
 		err = PTR_ERR(d->ident_names);
-		d->ident_names = NULL;
 		goto err;
 	}
+	d->decl_tags = hashmap__new(identity_hash_fn, identity_equal_fn, NULL);
+	if (IS_ERR(d->decl_tags)) {
+		err = PTR_ERR(d->decl_tags);
+		goto err;
+	}
+	d->next_decl_tag_scan_id = 1;
 
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
@@ -219,13 +258,20 @@ static int btf_dump_resize(struct btf_dump *d)
 	return 0;
 }
 
-static void btf_dump_free_names(struct hashmap *map)
+static void btf_dump_free_strs_map(struct hashmap *map, bool free_keys, bool free_values)
 {
 	size_t bkt;
 	struct hashmap_entry *cur;
 
-	hashmap__for_each_entry(map, cur, bkt)
-		free((void *)cur->key);
+	if (IS_ERR_OR_NULL(map))
+		return;
+
+	hashmap__for_each_entry(map, cur, bkt) {
+		if (free_keys)
+			free((void *)cur->key);
+		if (free_values)
+			free((void *)cur->value);
+	}
 
 	hashmap__free(map);
 }
@@ -248,14 +294,16 @@ void btf_dump__free(struct btf_dump *d)
 	free(d->cached_names);
 	free(d->emit_queue);
 	free(d->decl_stack);
-	btf_dump_free_names(d->type_names);
-	btf_dump_free_names(d->ident_names);
+	btf_dump_free_strs_map(d->type_names, true, false);
+	btf_dump_free_strs_map(d->ident_names, true, false);
+	btf_dump_free_strs_map(d->decl_tags, false, true);
 
 	free(d);
 }
 
 static int btf_dump_order_type(struct btf_dump *d, __u32 id, bool through_ptr);
 static void btf_dump_emit_type(struct btf_dump *d, __u32 id, __u32 cont_id);
+static void btf_dump_ensure_btf_decl_tag_macro(struct btf_dump *d);
 
 /*
  * Dump BTF type in a compilable C syntax, including all the necessary
@@ -284,6 +332,9 @@ int btf_dump__dump_type(struct btf_dump *d, __u32 id)
 	if (err)
 		return libbpf_err(err);
 
+	btf_dump_ensure_btf_decl_tag_macro(d);
+	btf_dump_assign_decl_tags(d);
+
 	d->emit_queue_cnt = 0;
 	err = btf_dump_order_type(d, id, false);
 	if (err < 0)
@@ -373,6 +424,63 @@ static int btf_dump_mark_referenced(struct btf_dump *d)
 	return 0;
 }
 
+/*
+ * Scans all BTF objects looking for BTF_KIND_DECL_TAG entries.
+ * The id's of the entries are stored in the `btf_dump.decl_tags` table,
+ * grouped by a target type.
+ */
+static int btf_dump_assign_decl_tags(struct btf_dump *d)
+{
+	__u32 id, new_cnt, type_cnt = btf__type_cnt(d->btf);
+	struct decl_tag_array *old_tags, *new_tags;
+	const struct btf_type *t;
+	size_t new_sz;
+	int err;
+
+	for (id = d->next_decl_tag_scan_id; id < type_cnt; id++) {
+		t = btf__type_by_id(d->btf, id);
+		if (!btf_is_decl_tag(t))
+			continue;
+
+		old_tags = NULL;
+		hashmap__find(d->decl_tags, (void *)(uintptr_t)t->type, (void **)&old_tags);
+		/* Assume small number of decl tags per id, increase array size by 1 */
+		new_cnt = old_tags ? old_tags->cnt + 1 : 1;
+		if (new_cnt == UINT_MAX)
+			return -ERANGE;
+		new_sz = sizeof(struct decl_tag_array) + new_cnt * sizeof(old_tags->tag_ids[0]);
+		new_tags = realloc(old_tags, new_sz);
+		if (!new_tags)
+			return -ENOMEM;
+
+		new_tags->tag_ids[new_cnt - 1] = id;
+		new_tags->cnt = new_cnt;
+
+		/* No need to update the map if realloc have not changed the pointer */
+		if (old_tags == new_tags)
+			continue;
+
+		err = hashmap__set(d->decl_tags, (void *)(uintptr_t)t->type, new_tags,
+				   NULL, NULL);
+		if (!err)
+			continue;
+		/*
+		 * If old_tags != NULL there is a record that holds it in the map, thus
+		 * the hashmap__set() call should not fail as it does not have to
+		 * allocate. If it does fail for some bizarre reason it's a bug and double
+		 * free is imminent because of the previous realloc call.
+		 */
+		if (old_tags)
+			pr_warn("hashmap__set() failed to update value for existing entry\n");
+		free(new_tags);
+		return err;
+	}
+
+	d->next_decl_tag_scan_id = type_cnt;
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
+static void btf_dump_ensure_btf_decl_tag_macro(struct btf_dump *d)
+{
+	if (d->btf_decl_tag_is_defined || !hashmap__size(d->decl_tags))
+		return;
+
+	d->btf_decl_tag_is_defined = true;
+	btf_dump_printf(d, "#if __has_attribute(btf_decl_tag)\n");
+	btf_dump_printf(d, "#define __btf_decl_tag(x) __attribute__((btf_decl_tag(x)))\n");
+	btf_dump_printf(d, "#else\n");
+	btf_dump_printf(d, "#define __btf_decl_tag(x)\n");
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
+	struct btf_type *t;
+	const char *text;
+	struct btf_decl_tag *tag;
+	__u32 i;
+
+	if (!decl_tags)
+		return;
+
+	for (i = 0; i < decl_tags->cnt; ++i) {
+		t = btf_type_by_id(d->btf, decl_tags->tag_ids[i]);
+		tag = btf_decl_tag(t);
+		if (tag->component_idx != component_idx)
+			continue;
+		text = btf__name_by_offset(d->btf, t->name_off);
+		btf_dump_printf(d, " __btf_decl_tag(\"%s\")", text);
+	}
+}
+
 static void btf_dump_emit_struct_fwd(struct btf_dump *d, __u32 id,
 				     const struct btf_type *t)
 {
@@ -914,11 +1067,13 @@ static void btf_dump_emit_struct_def(struct btf_dump *d,
 				     int lvl)
 {
 	const struct btf_member *m = btf_members(t);
+	struct decl_tag_array *decl_tags = NULL;
 	bool is_struct = btf_is_struct(t);
 	int align, i, packed, off = 0;
 	__u16 vlen = btf_vlen(t);
 
 	packed = is_struct ? btf_is_struct_packed(d->btf, id, t) : 0;
+	hashmap__find(d->decl_tags, (void *)(uintptr_t)id, (void **)&decl_tags);
 
 	btf_dump_printf(d, "%s%s%s {",
 			is_struct ? "struct" : "union",
@@ -945,6 +1100,7 @@ static void btf_dump_emit_struct_def(struct btf_dump *d,
 			m_sz = max((__s64)0, btf__resolve_size(d->btf, m->type));
 			off = m_off + m_sz * 8;
 		}
+		btf_dump_emit_decl_tags(d, decl_tags, i);
 		btf_dump_printf(d, ";");
 	}
 
@@ -964,6 +1120,7 @@ static void btf_dump_emit_struct_def(struct btf_dump *d,
 	btf_dump_printf(d, "%s}", pfx(lvl));
 	if (packed)
 		btf_dump_printf(d, " __attribute__((packed))");
+	btf_dump_emit_decl_tags(d, decl_tags, -1);
 }
 
 static const char *missing_base_types[][2] = {
@@ -1090,6 +1247,7 @@ static void btf_dump_emit_typedef_def(struct btf_dump *d, __u32 id,
 				     const struct btf_type *t, int lvl)
 {
 	const char *name = btf_dump_ident_name(d, id);
+	struct decl_tag_array *decl_tags = NULL;
 
 	/*
 	 * Old GCC versions are emitting invalid typedef for __gnuc_va_list
@@ -1104,6 +1262,8 @@ static void btf_dump_emit_typedef_def(struct btf_dump *d, __u32 id,
 
 	btf_dump_printf(d, "typedef ");
 	btf_dump_emit_type_decl(d, t->type, name, lvl);
+	hashmap__find(d->decl_tags, (void *)(uintptr_t)id, (void **)&decl_tags);
+	btf_dump_emit_decl_tags(d, decl_tags, -1);
 }
 
 static int btf_dump_push_decl_stack_id(struct btf_dump *d, __u32 id)
@@ -1438,9 +1598,12 @@ static void btf_dump_emit_type_chain(struct btf_dump *d,
 		}
 		case BTF_KIND_FUNC_PROTO: {
 			const struct btf_param *p = btf_params(t);
+			struct decl_tag_array *decl_tags = NULL;
 			__u16 vlen = btf_vlen(t);
 			int i;
 
+			hashmap__find(d->decl_tags, (void *)(uintptr_t)id, (void **)&decl_tags);
+
 			/*
 			 * GCC emits extra volatile qualifier for
 			 * __attribute__((noreturn)) function pointers. Clang
@@ -1481,6 +1644,7 @@ static void btf_dump_emit_type_chain(struct btf_dump *d,
 
 				name = btf_name_of(d, p->name_off);
 				btf_dump_emit_type_decl(d, p->type, name, lvl);
+				btf_dump_emit_decl_tags(d, decl_tags, i);
 			}
 
 			btf_dump_printf(d, ")");
@@ -1897,6 +2061,7 @@ static int btf_dump_var_data(struct btf_dump *d,
 			     const void *data)
 {
 	enum btf_func_linkage linkage = btf_var(v)->linkage;
+	struct decl_tag_array *decl_tags = NULL;
 	const struct btf_type *t;
 	const char *l;
 	__u32 type_id;
@@ -1921,7 +2086,10 @@ static int btf_dump_var_data(struct btf_dump *d,
 	type_id = v->type;
 	t = btf__type_by_id(d->btf, type_id);
 	btf_dump_emit_type_cast(d, type_id, false);
-	btf_dump_printf(d, " %s = ", btf_name_of(d, v->name_off));
+	btf_dump_printf(d, " %s", btf_name_of(d, v->name_off));
+	hashmap__find(d->decl_tags, (void *)(uintptr_t)id, (void **)&decl_tags);
+	btf_dump_emit_decl_tags(d, decl_tags, -1);
+	btf_dump_printf(d, " = ");
 	return btf_dump_dump_type_data(d, NULL, t, type_id, data, 0, 0);
 }
 
@@ -2422,6 +2590,8 @@ int btf_dump__dump_type_data(struct btf_dump *d, __u32 id,
 	d->typed_dump->skip_names = OPTS_GET(opts, skip_names, false);
 	d->typed_dump->emit_zeroes = OPTS_GET(opts, emit_zeroes, false);
 
+	btf_dump_assign_decl_tags(d);
+
 	ret = btf_dump_dump_type_data(d, NULL, t, id, data, 0, 0);
 
 	d->typed_dump = NULL;
-- 
2.34.1

