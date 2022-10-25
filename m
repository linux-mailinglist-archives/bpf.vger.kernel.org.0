Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DEF360D714
	for <lists+bpf@lfdr.de>; Wed, 26 Oct 2022 00:28:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbiJYW2p (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 Oct 2022 18:28:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiJYW2n (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 Oct 2022 18:28:43 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15789205FF
        for <bpf@vger.kernel.org>; Tue, 25 Oct 2022 15:28:42 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id t25so11005240ejb.8
        for <bpf@vger.kernel.org>; Tue, 25 Oct 2022 15:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pr9TrkVKhYPYCcTPL4D6/3GF5o1ebBiH+ZuikBgJUeE=;
        b=hxZSFIGX8eJsTlxcCo+zCfwGGxAa9qi+IyX8cNWN55VJRqSkU+MSYPi+5ec8Qd6+ts
         yMKLxGabskcXlxFHm9l3VrDpVuVvCK62o7mzz4znW8O8ulLwgw3oyGV2ucAvzFJC3Z7I
         dZ+BeMc6Y1r017zz3gIbUUpqwzo7kbRayIJi0ISagKJRRmUYH7hA3utJAyzEIuqndhJl
         8D0k4KKL2zoQz+hHkJEWno6HrwGsmgB2LA4wzcIAItyDDQP8elcL8dwKbF6AyjRMIpoR
         9oalE9aOGa+TCXfKHj/78fmHTiA1ontJVlW/1zMSGs7V87ERrQDTiN43swZi7melQL6O
         dp3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pr9TrkVKhYPYCcTPL4D6/3GF5o1ebBiH+ZuikBgJUeE=;
        b=x7R94ejXeG4/l8wEdoR/3bwMAC1jumrhBc4ID+eki72nwsxH5q0kXVS5YEpp3MZgfp
         TTOdcPH3cwdn/FTrBdpOzSABd/pGXZBtDqi4WaO1pj1SJSpUbLseoSliUuEl5ZJHip4v
         aZeO4fJH1ZXjJAFYan8Dd/VAcR1RYS7sC+2lTMtWS86RWsj9OQo0mNsxvhx6ELGk/UTk
         2HjTIm+LAz32u0xLcijvoxiehjkmqN6xJIo4XKMl2X6185TRW0M3/BsviBKGNuWIWDCJ
         jvWLJaMN2+G5YKneK9uErE1KA4CDqD65H+SvVSaFE2oTGxh4evN7jOCQ9ke+NlRiieX3
         E1Aw==
X-Gm-Message-State: ACrzQf0MbRg/Y3s6rvRx6TCKdR48ADkVKPjtqfS7W96kfuu+nYvkI3OX
        +UemgDa9PkhHc3iaPIMUoZO307S4BtDDvZRh
X-Google-Smtp-Source: AMsMyM7BwqkETyU1jEmAgT/SYfsUHJtbDc0uTfUJiZlkQw4hsNZeMoOPMrPzU4knF03HdeU9GdklCw==
X-Received: by 2002:a17:906:ee89:b0:73d:70c5:1a4e with SMTP id wt9-20020a170906ee8900b0073d70c51a4emr33131847ejb.683.1666736921434;
        Tue, 25 Oct 2022 15:28:41 -0700 (PDT)
Received: from pluto.. (boundsly.muster.volia.net. [93.72.16.93])
        by smtp.gmail.com with ESMTPSA id ks23-20020a170906f85700b0078d175d6dc5sm1993119ejb.201.2022.10.25.15.28.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 15:28:41 -0700 (PDT)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, kernel-team@fb.com,
        yhs@fb.com, arnaldo.melo@gmail.com,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [RFC bpf-next 03/12] libbpf: Support for BTF_DECL_TAG dump in C format
Date:   Wed, 26 Oct 2022 01:27:52 +0300
Message-Id: <20221025222802.2295103-4-eddyz87@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221025222802.2295103-1-eddyz87@gmail.com>
References: <20221025222802.2295103-1-eddyz87@gmail.com>
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

At C level BTF_DECL_TAGs are represented as __attribute__
declarations, e.g.:

struct foo {
	...;
} __attribute__((btf_decl_tag("bar")));

This commit covers only decl tags attached to structs and unions.

BTF doc says that BTF_DECL_TAGs should follow a target type but this
is not enforced and tests don't honor this restriction.
This commit uses hash table to map types to the list of decl tags.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/lib/bpf/btf_dump.c | 143 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 142 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
index bf0cc0e986dd..9bfe2a4ae277 100644
--- a/tools/lib/bpf/btf_dump.c
+++ b/tools/lib/bpf/btf_dump.c
@@ -75,6 +75,15 @@ struct btf_dump_data {
 	bool is_array_char;
 };
 
+/*
+ * An array of ids of BTF_DECL_TAG objects associated with a specific type.
+ */
+struct decl_tag_array {
+	__u16 cnt;
+	__u16 cap;
+	__u32 tag_ids[0];
+};
+
 struct btf_dump {
 	const struct btf *btf;
 	btf_dump_printf_fn_t printf_fn;
@@ -111,6 +120,11 @@ struct btf_dump {
 	 * name occurrences
 	 */
 	struct hashmap *ident_names;
+	/*
+	 * maps type id to decl_tag_array, assume that relatively small
+	 * fraction of types has btf_decl_tag's attached
+	 */
+	struct hashmap *decl_tags;
 	/*
 	 * data for typed display; allocated if needed.
 	 */
@@ -127,6 +141,26 @@ static bool str_equal_fn(const void *a, const void *b, void *ctx)
 	return strcmp(a, b) == 0;
 }
 
+static size_t int_hash_fn(const void *key, void *ctx)
+{
+	int i;
+	size_t h = 0;
+	char *bytes = (char *)key;
+
+	for (i = 0; i < 4; ++i)
+		h = h * 31 + bytes[i];
+
+	return h;
+}
+
+static bool int_equal_fn(const void *a, const void *b, void *ctx)
+{
+	int *ia = (int *)a;
+	int *ib = (int *)b;
+
+	return *ia == *ib;
+}
+
 static const char *btf_name_of(const struct btf_dump *d, __u32 name_off)
 {
 	return btf__name_by_offset(d->btf, name_off);
@@ -143,6 +177,7 @@ static void btf_dump_printf(const struct btf_dump *d, const char *fmt, ...)
 
 static int btf_dump_mark_referenced(struct btf_dump *d);
 static int btf_dump_resize(struct btf_dump *d);
+static int btf_dump_assign_decl_tags(struct btf_dump *d);
 
 struct btf_dump *btf_dump__new(const struct btf *btf,
 			       btf_dump_printf_fn_t printf_fn,
@@ -179,11 +214,24 @@ struct btf_dump *btf_dump__new(const struct btf *btf,
 		d->ident_names = NULL;
 		goto err;
 	}
+	d->decl_tags = hashmap__new(int_hash_fn, int_equal_fn, NULL);
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
+	if (err)
+		goto err;
+
 	return d;
 err:
 	btf_dump__free(d);
@@ -232,7 +280,8 @@ static void btf_dump_free_names(struct hashmap *map)
 
 void btf_dump__free(struct btf_dump *d)
 {
-	int i;
+	int i, bkt;
+	struct hashmap_entry *cur;
 
 	if (IS_ERR_OR_NULL(d))
 		return;
@@ -250,6 +299,9 @@ void btf_dump__free(struct btf_dump *d)
 	free(d->decl_stack);
 	btf_dump_free_names(d->type_names);
 	btf_dump_free_names(d->ident_names);
+	hashmap__for_each_entry(d->decl_tags, cur, bkt)
+		free(cur->value);
+	hashmap__free(d->decl_tags);
 
 	free(d);
 }
@@ -373,6 +425,77 @@ static int btf_dump_mark_referenced(struct btf_dump *d)
 	return 0;
 }
 
+static struct decl_tag_array *btf_dump_find_decl_tags(struct btf_dump *d, __u32 id)
+{
+	struct decl_tag_array *decl_tags = NULL;
+
+	hashmap__find(d->decl_tags, &id, (void **)&decl_tags);
+
+	return decl_tags;
+}
+
+static struct decl_tag_array *realloc_decl_tags(struct decl_tag_array *tags, __u16 new_cap)
+{
+	size_t new_size = sizeof(struct decl_tag_array) + new_cap * sizeof(__u32);
+	struct decl_tag_array *new_tags = (tags
+					   ? realloc(tags, new_size)
+					   : calloc(1, new_size));
+
+	if (!new_tags)
+		return NULL;
+
+	new_tags->cap = new_cap;
+
+	return new_tags;
+}
+
+/*
+ * Scans all BTF objects looking for BTF_KIND_DECL_TAG entries.
+ * The id's of the entries are stored in the `btf_dump.decl_tags` table,
+ * grouped by a target type.
+ */
+static int btf_dump_assign_decl_tags(struct btf_dump *d)
+{
+	int err;
+	__u32 id;
+	__u32 n = btf__type_cnt(d->btf);
+	__u32 new_capacity;
+	const struct btf_type *t;
+	struct decl_tag_array *decl_tags;
+
+	for (id = 0; id < n; id++) {
+		t = btf__type_by_id(d->btf, id);
+
+		if (btf_kind(t) != BTF_KIND_DECL_TAG)
+			continue;
+
+		decl_tags = btf_dump_find_decl_tags(d, t->type);
+		if (!decl_tags) {
+			decl_tags = realloc_decl_tags(NULL, 1);
+			if (!decl_tags)
+				return -ENOMEM;
+			err = hashmap__insert(d->decl_tags, &t->type, decl_tags,
+					      HASHMAP_SET, NULL, NULL);
+			if (err)
+				return err;
+		} else if (decl_tags->cnt == decl_tags->cap) {
+			new_capacity = decl_tags->cap * 2;
+			if (new_capacity > 0xffff)
+				return -ERANGE;
+			decl_tags = realloc_decl_tags(decl_tags, new_capacity);
+			if (!decl_tags)
+				return -ENOMEM;
+			decl_tags->cap = new_capacity;
+			err = hashmap__update(d->decl_tags, &t->type, decl_tags, NULL, NULL);
+			if (err)
+				return err;
+		}
+		decl_tags->tag_ids[decl_tags->cnt++] = id;
+	}
+
+	return 0;
+}
+
 static int btf_dump_add_emit_queue_id(struct btf_dump *d, __u32 id)
 {
 	__u32 *new_queue;
@@ -899,6 +1022,23 @@ static void btf_dump_emit_bit_padding(const struct btf_dump *d,
 	}
 }
 
+static void btf_dump_emit_decl_tags(struct btf_dump *d, __u32 id)
+{
+	struct decl_tag_array *decl_tags = btf_dump_find_decl_tags(d, id);
+	struct btf_type *decl_tag_t;
+	const char *decl_tag_text;
+	__u32 i;
+
+	if (!decl_tags)
+		return;
+
+	for (i = 0; i < decl_tags->cnt; ++i) {
+		decl_tag_t = btf_type_by_id(d->btf, decl_tags->tag_ids[i]);
+		decl_tag_text = btf__name_by_offset(d->btf, decl_tag_t->name_off);
+		btf_dump_printf(d, " __attribute__((btf_decl_tag(\"%s\")))", decl_tag_text);
+	}
+}
+
 static void btf_dump_emit_struct_fwd(struct btf_dump *d, __u32 id,
 				     const struct btf_type *t)
 {
@@ -964,6 +1104,7 @@ static void btf_dump_emit_struct_def(struct btf_dump *d,
 	btf_dump_printf(d, "%s}", pfx(lvl));
 	if (packed)
 		btf_dump_printf(d, " __attribute__((packed))");
+	btf_dump_emit_decl_tags(d, id);
 }
 
 static const char *missing_base_types[][2] = {
-- 
2.34.1

