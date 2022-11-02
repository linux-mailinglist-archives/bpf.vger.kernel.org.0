Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC9A9616EAB
	for <lists+bpf@lfdr.de>; Wed,  2 Nov 2022 21:27:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231251AbiKBU1u (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Nov 2022 16:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231238AbiKBU1o (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Nov 2022 16:27:44 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D4576333
        for <bpf@vger.kernel.org>; Wed,  2 Nov 2022 13:27:34 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id u8-20020a17090a5e4800b002106dcdd4a0so3213394pji.1
        for <bpf@vger.kernel.org>; Wed, 02 Nov 2022 13:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HQzshffhvAMlg3DQ5tJuIZ2d1lhZw5DeEI/+zAEmovw=;
        b=Ybkz4k57HwMgre2qsMRjWbQHhcO4TsF4Qd20+/qynv2e9fk45XINoCR/zRjIMwNl/x
         1i92PW9plw2JDtJRX4hZWQWqJ7SK8m6jERHkqajkD7P7rYoBwLytSZR9fFi1vaL+/ms7
         zDhoLemQD7Gb98c+MZRFalglj/vuZA3fxKp4THO0xqsJPdp0bsFapAbdr7JIB781Mhtw
         EcLVHa0SCDsYkbYftmgAvjts9GfvBaBm4Zt08WZZdCo6MF4xib0vGxOcIE4JbYxSU5ST
         LkcsRugLBKveWG5YkThkQ7mCcNlXtdqCR1etRtzcwlEspp+uIy0+rGsmNW3aFhIvjoUK
         YGBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HQzshffhvAMlg3DQ5tJuIZ2d1lhZw5DeEI/+zAEmovw=;
        b=rzKAZ58KXObWkjBHzQgZ0Bd2j5M+2rdT8kST/37A3Zo+hoeqto74pfJfrfqm/aLaev
         PkcCV0F+6gCvbjfp4jOotFxJ/plcXdqY3LhXAvfrLP1rAU7zAIgbGqqAVz8EBv3F8STN
         tEpMZM90fLF3JT5ZcKWXuPCe6w7KJfc8KlaGYLM5K6US1LrnjP1Vms5w6Gi9n9JrNEwu
         s7bztKbEl4F+boA5REonqcs1CTbwRk68GrrmtoFFJAgtafol5EQ7X4L4TmcR5kSRfitu
         EA7kEY94QnY07QirtA6CFCCoAEjdCh179mMWksiQwqHuGUVrX+nR7xCVTW8k+sJ/KI4Z
         zgBw==
X-Gm-Message-State: ACrzQf0f27NzTZVn75nD6R029Qx4E0oiMvgusj8JbMsII3SC0I9Ff2FK
        A5KWAZMPKqAq/uepZ6Z8SZqziq4RpaDdMQ==
X-Google-Smtp-Source: AMsMyM5wHVORuRILoU4URvEOXK4S9SSuasl4YDjOckH4II9OXSk3cBvfVi5zGNP1Llii3LFLZ6whXg==
X-Received: by 2002:a17:902:7849:b0:186:68b9:e1ae with SMTP id e9-20020a170902784900b0018668b9e1aemr26635432pln.139.1667420853711;
        Wed, 02 Nov 2022 13:27:33 -0700 (PDT)
Received: from localhost ([59.152.80.69])
        by smtp.gmail.com with ESMTPSA id k197-20020a6284ce000000b0056bb6dc882fsm8870430pfd.130.2022.11.02.13.27.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 13:27:33 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>,
        Delyan Kratunov <delyank@meta.com>
Subject: [PATCH bpf-next v3 08/24] bpf: Refactor map->off_arr handling
Date:   Thu,  3 Nov 2022 01:56:42 +0530
Message-Id: <20221102202658.963008-9-memxor@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221102202658.963008-1-memxor@gmail.com>
References: <20221102202658.963008-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9082; i=memxor@gmail.com; h=from:subject; bh=xFzXbub6fUDGuBoJB8oeKvkti1iixBh9CefdjqV6hgI=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjYtID3uBcYvCHf0cnZqoFyS4gb3w2gm9pOb9Uhalt OmczkVGJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY2LSAwAKCRBM4MiGSL8Rysw9EA CcEvh6z/Izre+UnO3GtwUoR10YyYT5CLWpJRwgp+/HQOyAOaPKLYgT+8F+uIQFgAkLmxmGVQ0ai/Fo 7nckIE9mFJsj4iSH1kD4whXylDx7+JbNDtZB9ZGgmCB/B4q+WOiRNGJ2+UK4ZffMYq1P+E/DUG1WSP 57zprv8/tGkrKcSu8XTRNLyDzdGDMxFnriq2x6pAHeYRGCJp4I9afPJxjgS9eUZr68MSLwf0Bsbi21 crKImWC1FQ39F6K7QSRcl244YZT3z2qgObeQXrYJODEmoL6OTtSIsueHJbwKSjK8dN76y6XuYiWBvL EG7LPJ7FcoOzAYcegYXUnpas1NyCJtKG2FsjrZPsZ4aNKJC5hvEeQxQHTOSy1PiT3KzlSfyBNglwlR I1O94N5I+UzYp3froB5J7UeZf6i5bOOnX4WBBW016nAULpPchhjd5KCoxc7oIz9HJGkFe7NoT6+bFL FOR4EHk4JMRQ4el9GlIKwKuJs4IonKmW2QoI7GAWJchPyd7VpCUKR7DPxXkMhquwVtEHZr82J2Ob1z YXSSxWekJnwmbBVVlC8+mT9RT1nv3s3KHlZn7TOydQSeTnUol5XjiA26nP0dplR+CL8Zh1sRini2Dc GQoH8d3cS7S+H1Nkvz7JMO2zyfLBqU4mKkxSWxxb0g3b86PMXO6V8JgASTOQ==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Refactor map->off_arr handling into generic functions that can work on
their own without hardcoding map specific code. The btf_fields_offs
structure is now returned from btf_parse_field_offs, which can be reused
later for types in program BTF.

All functions like copy_map_value, zero_map_value call generic
underlying functions so that they can also be reused later for copying
to values allocated in programs which encode specific fields.

Later, some helper functions will also require access to this
btf_field_offs structure to be able to skip over special fields at
runtime.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf.h  | 41 ++++++++++++++-----------
 include/linux/btf.h  |  1 +
 kernel/bpf/btf.c     | 55 +++++++++++++++++++++++++++++++++
 kernel/bpf/syscall.c | 73 ++++++--------------------------------------
 4 files changed, 89 insertions(+), 81 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 762e9a20c358..02967fbdf712 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -340,55 +340,62 @@ static inline void bpf_long_memcpy(void *dst, const void *src, u32 size)
 }
 
 /* copy everything but bpf_spin_lock, bpf_timer, and kptrs. There could be one of each. */
-static inline void __copy_map_value(struct bpf_map *map, void *dst, void *src, bool long_memcpy)
+static inline void bpf_obj_memcpy(struct btf_field_offs *foffs,
+				  void *dst, void *src, u32 size,
+				  bool long_memcpy)
 {
 	u32 curr_off = 0;
 	int i;
 
-	if (likely(!map->field_offs)) {
+	if (likely(!foffs)) {
 		if (long_memcpy)
-			bpf_long_memcpy(dst, src, round_up(map->value_size, 8));
+			bpf_long_memcpy(dst, src, round_up(size, 8));
 		else
-			memcpy(dst, src, map->value_size);
+			memcpy(dst, src, size);
 		return;
 	}
 
-	for (i = 0; i < map->field_offs->cnt; i++) {
-		u32 next_off = map->field_offs->field_off[i];
+	for (i = 0; i < foffs->cnt; i++) {
+		u32 next_off = foffs->field_off[i];
 
 		memcpy(dst + curr_off, src + curr_off, next_off - curr_off);
-		curr_off += map->field_offs->field_sz[i];
+		curr_off += foffs->field_sz[i];
 	}
-	memcpy(dst + curr_off, src + curr_off, map->value_size - curr_off);
+	memcpy(dst + curr_off, src + curr_off, size - curr_off);
 }
 
 static inline void copy_map_value(struct bpf_map *map, void *dst, void *src)
 {
-	__copy_map_value(map, dst, src, false);
+	bpf_obj_memcpy(map->field_offs, dst, src, map->value_size, false);
 }
 
 static inline void copy_map_value_long(struct bpf_map *map, void *dst, void *src)
 {
-	__copy_map_value(map, dst, src, true);
+	bpf_obj_memcpy(map->field_offs, dst, src, map->value_size, true);
 }
 
-static inline void zero_map_value(struct bpf_map *map, void *dst)
+static inline void bpf_obj_memzero(struct btf_field_offs *foffs, void *dst, u32 size)
 {
 	u32 curr_off = 0;
 	int i;
 
-	if (likely(!map->field_offs)) {
-		memset(dst, 0, map->value_size);
+	if (likely(!foffs)) {
+		memset(dst, 0, size);
 		return;
 	}
 
-	for (i = 0; i < map->field_offs->cnt; i++) {
-		u32 next_off = map->field_offs->field_off[i];
+	for (i = 0; i < foffs->cnt; i++) {
+		u32 next_off = foffs->field_off[i];
 
 		memset(dst + curr_off, 0, next_off - curr_off);
-		curr_off += map->field_offs->field_sz[i];
+		curr_off += foffs->field_sz[i];
 	}
-	memset(dst + curr_off, 0, map->value_size - curr_off);
+	memset(dst + curr_off, 0, size - curr_off);
+}
+
+static inline void zero_map_value(struct bpf_map *map, void *dst)
+{
+	bpf_obj_memzero(map->field_offs, dst, map->value_size);
 }
 
 void copy_map_value_locked(struct bpf_map *map, void *dst, void *src,
diff --git a/include/linux/btf.h b/include/linux/btf.h
index 282006abd062..d80345fa566b 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -165,6 +165,7 @@ int btf_find_spin_lock(const struct btf *btf, const struct btf_type *t);
 int btf_find_timer(const struct btf *btf, const struct btf_type *t);
 struct btf_record *btf_parse_fields(const struct btf *btf, const struct btf_type *t,
 				    u32 field_mask, u32 value_size);
+struct btf_field_offs *btf_parse_field_offs(struct btf_record *rec);
 bool btf_type_is_void(const struct btf_type *t);
 s32 btf_find_by_name_kind(const struct btf *btf, const char *name, u8 kind);
 const struct btf_type *btf_type_skip_modifiers(const struct btf *btf,
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 33eb6828bd01..de8a93e70f5e 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -3551,6 +3551,61 @@ struct btf_record *btf_parse_fields(const struct btf *btf, const struct btf_type
 	return ERR_PTR(ret);
 }
 
+static int btf_field_offs_cmp(const void *_a, const void *_b, const void *priv)
+{
+	const u32 a = *(const u32 *)_a;
+	const u32 b = *(const u32 *)_b;
+
+	if (a < b)
+		return -1;
+	else if (a > b)
+		return 1;
+	return 0;
+}
+
+static void btf_field_offs_swap(void *_a, void *_b, int size, const void *priv)
+{
+	struct btf_field_offs *foffs = (void *)priv;
+	u32 *off_base = foffs->field_off;
+	u32 *a = _a, *b = _b;
+	u8 *sz_a, *sz_b;
+
+	sz_a = foffs->field_sz + (a - off_base);
+	sz_b = foffs->field_sz + (b - off_base);
+
+	swap(*a, *b);
+	swap(*sz_a, *sz_b);
+}
+
+struct btf_field_offs *btf_parse_field_offs(struct btf_record *rec)
+{
+	struct btf_field_offs *foffs;
+	u32 i, *off;
+	u8 *sz;
+
+	BUILD_BUG_ON(ARRAY_SIZE(foffs->field_off) != ARRAY_SIZE(foffs->field_sz));
+	if (IS_ERR_OR_NULL(rec) || WARN_ON_ONCE(rec->cnt > sizeof(foffs->field_off)))
+		return NULL;
+
+	foffs = kzalloc(sizeof(*foffs), GFP_KERNEL | __GFP_NOWARN);
+	if (!foffs)
+		return ERR_PTR(-ENOMEM);
+
+	off = &foffs->field_off[0];
+	sz = &foffs->field_sz[0];
+	for (i = 0; i < rec->cnt; i++) {
+		off[i] = rec->fields[i].offset;
+		sz[i] = btf_field_type_size(rec->fields[i].type);
+	}
+	foffs->cnt = rec->cnt;
+
+	if (foffs->cnt == 1)
+		return foffs;
+	sort_r(foffs->field_off, foffs->cnt, sizeof(foffs->field_off[0]),
+	       btf_field_offs_cmp, btf_field_offs_swap, foffs);
+	return foffs;
+}
+
 static void __btf_struct_show(const struct btf *btf, const struct btf_type *t,
 			      u32 type_id, void *data, u8 bits_offset,
 			      struct btf_show *show)
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 73822d36aa56..85532d301124 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -943,66 +943,6 @@ int map_check_no_btf(const struct bpf_map *map,
 	return -ENOTSUPP;
 }
 
-static int map_field_offs_cmp(const void *_a, const void *_b, const void *priv)
-{
-	const u32 a = *(const u32 *)_a;
-	const u32 b = *(const u32 *)_b;
-
-	if (a < b)
-		return -1;
-	else if (a > b)
-		return 1;
-	return 0;
-}
-
-static void map_field_offs_swap(void *_a, void *_b, int size, const void *priv)
-{
-	struct bpf_map *map = (struct bpf_map *)priv;
-	u32 *off_base = map->field_offs->field_off;
-	u32 *a = _a, *b = _b;
-	u8 *sz_a, *sz_b;
-
-	sz_a = map->field_offs->field_sz + (a - off_base);
-	sz_b = map->field_offs->field_sz + (b - off_base);
-
-	swap(*a, *b);
-	swap(*sz_a, *sz_b);
-}
-
-static int bpf_map_alloc_off_arr(struct bpf_map *map)
-{
-	bool has_fields = !IS_ERR_OR_NULL(map);
-	struct btf_field_offs *fo;
-	struct btf_record *rec;
-	u32 i, *off;
-	u8 *sz;
-
-	if (!has_fields) {
-		map->field_offs = NULL;
-		return 0;
-	}
-
-	fo = kmalloc(sizeof(*map->field_offs), GFP_KERNEL | __GFP_NOWARN);
-	if (!fo)
-		return -ENOMEM;
-	map->field_offs = fo;
-
-	rec = map->record;
-	off = &fo->field_off[fo->cnt];
-	sz = &fo->field_sz[fo->cnt];
-	for (i = 0; i < rec->cnt; i++) {
-		*off++ = rec->fields[i].offset;
-		*sz++ = btf_field_type_size(rec->fields[i].type);
-	}
-	fo->cnt = rec->cnt;
-
-	if (fo->cnt == 1)
-		return 0;
-	sort_r(fo->field_off, fo->cnt, sizeof(fo->field_off[0]),
-	       map_field_offs_cmp, map_field_offs_swap, map);
-	return 0;
-}
-
 static int map_check_btf(struct bpf_map *map, const struct btf *btf,
 			 u32 btf_key_id, u32 btf_value_id)
 {
@@ -1097,6 +1037,7 @@ static int map_check_btf(struct bpf_map *map, const struct btf *btf,
 static int map_create(union bpf_attr *attr)
 {
 	int numa_node = bpf_map_attr_numa_node(attr);
+	struct btf_field_offs *foffs;
 	struct bpf_map *map;
 	int f_flags;
 	int err;
@@ -1176,13 +1117,17 @@ static int map_create(union bpf_attr *attr)
 			attr->btf_vmlinux_value_type_id;
 	}
 
-	err = bpf_map_alloc_off_arr(map);
-	if (err)
+
+	foffs = btf_parse_field_offs(map->record);
+	if (IS_ERR(foffs)) {
+		err = PTR_ERR(foffs);
 		goto free_map;
+	}
+	map->field_offs = foffs;
 
 	err = security_bpf_map_alloc(map);
 	if (err)
-		goto free_map_off_arr;
+		goto free_map_field_offs;
 
 	err = bpf_map_alloc_id(map);
 	if (err)
@@ -1206,7 +1151,7 @@ static int map_create(union bpf_attr *attr)
 
 free_map_sec:
 	security_bpf_map_free(map);
-free_map_off_arr:
+free_map_field_offs:
 	kfree(map->field_offs);
 free_map:
 	btf_put(map->btf);
-- 
2.38.1

