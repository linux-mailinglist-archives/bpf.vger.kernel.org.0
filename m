Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20A6B5FA9FB
	for <lists+bpf@lfdr.de>; Tue, 11 Oct 2022 03:24:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230422AbiJKBYC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 10 Oct 2022 21:24:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230342AbiJKBXf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 10 Oct 2022 21:23:35 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD9B682D0B
        for <bpf@vger.kernel.org>; Mon, 10 Oct 2022 18:23:06 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id i6so6775680pli.12
        for <bpf@vger.kernel.org>; Mon, 10 Oct 2022 18:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YlzNnK3xgysZHRBN8VflLgeXzgtW6M8IkesVy/0SUZw=;
        b=p/bk/d/ZO/i92TBZ9i/xENty8FUGa9eN7rnvtr3SJoa13l35b8koww2Tn/eBBFtP2c
         8YtZSzMBD0wtmyXkrRqaM9TKIdN6jOuRInuhv7G8PNSq6s1DaFsPNP0FyqFiTNS8bDih
         bM289eZElgSUvEnVjsIGq8GxYwk2XMIwaH9hbHej5oCsaCGu7OOwjRJsILLQd9iA0/ew
         +iUXtBu0QPbW8u+G+Nw4ub+c/u8Agk8+qFRQkCO9Go4QOVxXyDGcLi1blJnv8Cb13yEn
         PFTZJAznECMUaFGfGTg1giH/aDnSbU1aP12g9Quq+LIRpSnBetpqg6eTWJFAQF5+ztM9
         m2vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YlzNnK3xgysZHRBN8VflLgeXzgtW6M8IkesVy/0SUZw=;
        b=46dnNf1EqHr+ElWnoK7RydbKEFBGSkHfrxG8fIZU4S9EOGiJE9ISTjzCQdoJwYpdQv
         /EY5oCU1qYXHckhU2GrYilm2+MdVl4iPCX2zelXWY66Ijh4j1kaHRfntXWsnvEQMR5LA
         YkR4D2kaFTN3nDf+kgnXVoVTDgD152K/9dnS49Dpw2zgCcyuv1lwhLQho3/+pBt7PAzp
         rRFW0md/tqigXGfXuplUoXzN1KzasHBckgIgCVnNQoh1alAo0LrJpAOUtXxLVKs2as6o
         FJ2lvIK9xsdFd8zII0QYaeHfIUOpmUOWQW3RlNn8W0+793otp3LZPjj7KbiC8I+XlFTY
         Y/wQ==
X-Gm-Message-State: ACrzQf1ST3+zQ+d3r4BzkI5mcHgN/22a0qjL7R127rdcSfQU5Fjp7lNK
        9ghKQslOroOJzM8UV2BGR4TzzcN2Un9EOw==
X-Google-Smtp-Source: AMsMyM5Cx0v9KWTf1GNU+OXL6nCUflE+FL66Tw86IjkR3WhFUIQTsUVL8rFNE8zIDUoMi/BOx647ZA==
X-Received: by 2002:a17:902:d4d2:b0:17d:d70:8045 with SMTP id o18-20020a170902d4d200b0017d0d708045mr21988557plg.73.1665451384541;
        Mon, 10 Oct 2022 18:23:04 -0700 (PDT)
Received: from localhost ([103.4.221.252])
        by smtp.gmail.com with ESMTPSA id 198-20020a6216cf000000b0054087e1aeb4sm7549311pfw.111.2022.10.10.18.23.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 18:23:04 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Delyan Kratunov <delyank@fb.com>
Subject: [PATCH bpf-next v1 07/25] bpf: Consolidate spin_lock, timer management into fields_tab
Date:   Tue, 11 Oct 2022 06:52:22 +0530
Message-Id: <20221011012240.3149-8-memxor@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221011012240.3149-1-memxor@gmail.com>
References: <20221011012240.3149-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=43688; i=memxor@gmail.com; h=from:subject; bh=6BgaO8cmy+oJnGNn5EUzOjq+oJdEEo1pukqbQmmdb3E=; b=owEBbQKS/ZANAwAKAUzgyIZIvxHKAcsmYgBjRMUahzBbzVb1ZztzxUNV+dahFdUECEeiItGJpTAK r/OmZNKJAjMEAAEKAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY0TFGgAKCRBM4MiGSL8Ryg5ZEA C4RpuLgxVSScblAUXZzu3fsT06dwDkP22/+s3awZbcOSV/wmTcFK9qxqrv55GS4DmzLukX2XBwpLdg uyMWhlB/LOEpdX44YHk39vALyDAxRw0GKtJULFpTCOIxRBkjjA74J3VXBoEvatUwHe4ToP6HJGDKGI ckSCneNnfedolJkrMrdUwu+65T++ASTcPDzLOAwp9JSGM5G7qEar7/ZcPYNnc2uJxbA6h6FAwQj1lA KbRCgSBD6KjUeEZw5M1lus7dEEk0zqTJu5PGZJiwwErRANNr7DpXuT79+70L+XHgSc90gMLNGzM5oG xGMkp5445jxfS+FBlPAmh6bwRfLlu5dfp+F4R2mCtgcyx/xblo7MpUiIoUhJfiy12cO4c1VzwzAryF PpjOFEmgbf9FLz1ZNIDpZl19nF1VVQaPP5yBuuI8D3i6aefpjUaWJWrqr1rsIpJjxZbvhcb9/ADCxv FxdvW7NWbNtQNq5XOykQPOPCZ9EUwmWJQ1WdU9goeFZdYO6z04hV7zAu8m/mO/nGQr3cCGYyjQBoyQ QkoogiWV/FfEXf0EoMvL59R7vnCgM/FHTFPFw3Jx/EYfo36hgfeDGYaPO/XGRmu7pRuu4raS4gccIo EpMOxvrq5t60YKJch8Pf8sxFnIqoCz+FNyIWmYN5DXSuUSRMorZXDRr93DjQ==
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

Now that kptr_off_tab has been refactored into fields_tab, and can hold
more than one specific field type, accomodate bpf_spin_lock and
bpf_timer as well.

While they don't require any more metadata than offset, having all
special fields in one place allows us to share the same code for
allocated user defined types and handle both map values and these
allocated objects in a similar fashion.

As an optimization, we still keep spin_lock_off and timer_off offsets in
the btf_type_fields structure, just to avoid having to find the
btf_field struct each time their offset is needed. This is mostly needed
to manipulate such objects in a map value at runtime. It's ok to
hardcode just one offset as more than one field is disallowed.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf.h            |  53 +++---
 include/linux/btf.h            |   3 +-
 kernel/bpf/arraymap.c          |  19 +-
 kernel/bpf/bpf_local_storage.c |   2 +-
 kernel/bpf/btf.c               | 323 ++++++++++++++++++---------------
 kernel/bpf/hashtab.c           |  26 +--
 kernel/bpf/helpers.c           |   6 +-
 kernel/bpf/local_storage.c     |   2 +-
 kernel/bpf/map_in_map.c        |   5 +-
 kernel/bpf/syscall.c           | 111 +++++------
 kernel/bpf/verifier.c          |  83 +++------
 net/core/bpf_sk_storage.c      |   4 +-
 12 files changed, 308 insertions(+), 329 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 25e77a172d7c..ba59147dfa61 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -165,13 +165,13 @@ struct bpf_map_ops {
 
 enum {
 	/* Support at most 8 pointers in a BTF type */
-	BTF_FIELDS_MAX	      = 8,
-	BPF_MAP_OFF_ARR_MAX   = BTF_FIELDS_MAX +
-				1 + /* for bpf_spin_lock */
-				1,  /* for bpf_timer */
+	BTF_FIELDS_MAX	      = 10,
+	BPF_MAP_OFF_ARR_MAX   = BTF_FIELDS_MAX,
 };
 
 enum btf_field_type {
+	BPF_SPIN_LOCK  = (1 << 0),
+	BPF_TIMER      = (1 << 1),
 	BPF_KPTR_UNREF = (1 << 2),
 	BPF_KPTR_REF   = (1 << 3),
 	BPF_KPTR       = BPF_KPTR_UNREF | BPF_KPTR_REF,
@@ -195,6 +195,8 @@ struct btf_field {
 struct btf_type_fields {
 	u32 cnt;
 	u32 field_mask;
+	int spin_lock_off;
+	int timer_off;
 	struct btf_field fields[];
 };
 
@@ -219,10 +221,8 @@ struct bpf_map {
 	u32 max_entries;
 	u64 map_extra; /* any per-map-type extra fields */
 	u32 map_flags;
-	int spin_lock_off; /* >=0 valid offset, <0 error */
-	struct btf_type_fields *fields_tab;
-	int timer_off; /* >=0 valid offset, <0 error */
 	u32 id;
+	struct btf_type_fields *fields_tab;
 	int numa_node;
 	u32 btf_key_type_id;
 	u32 btf_value_type_id;
@@ -256,9 +256,29 @@ struct bpf_map {
 	bool frozen; /* write-once; write-protected by freeze_mutex */
 };
 
+static inline const char *btf_field_type_name(enum btf_field_type type)
+{
+	switch (type) {
+	case BPF_SPIN_LOCK:
+		return "bpf_spin_lock";
+	case BPF_TIMER:
+		return "bpf_timer";
+	case BPF_KPTR_UNREF:
+	case BPF_KPTR_REF:
+		return "kptr";
+	default:
+		WARN_ON_ONCE(1);
+		return "unknown";
+	}
+}
+
 static inline u32 btf_field_type_size(enum btf_field_type type)
 {
 	switch (type) {
+	case BPF_SPIN_LOCK:
+		return sizeof(struct bpf_spin_lock);
+	case BPF_TIMER:
+		return sizeof(struct bpf_timer);
 	case BPF_KPTR_UNREF:
 	case BPF_KPTR_REF:
 		return sizeof(u64);
@@ -271,6 +291,10 @@ static inline u32 btf_field_type_size(enum btf_field_type type)
 static inline u32 btf_field_type_align(enum btf_field_type type)
 {
 	switch (type) {
+	case BPF_SPIN_LOCK:
+		return __alignof__(struct bpf_spin_lock);
+	case BPF_TIMER:
+		return __alignof__(struct bpf_timer);
 	case BPF_KPTR_UNREF:
 	case BPF_KPTR_REF:
 		return __alignof__(u64);
@@ -287,22 +311,8 @@ static inline bool btf_type_fields_has_field(const struct btf_type_fields *tab,
 	return tab->field_mask & type;
 }
 
-static inline bool map_value_has_spin_lock(const struct bpf_map *map)
-{
-	return map->spin_lock_off >= 0;
-}
-
-static inline bool map_value_has_timer(const struct bpf_map *map)
-{
-	return map->timer_off >= 0;
-}
-
 static inline void check_and_init_map_value(struct bpf_map *map, void *dst)
 {
-	if (unlikely(map_value_has_spin_lock(map)))
-		memset(dst + map->spin_lock_off, 0, sizeof(struct bpf_spin_lock));
-	if (unlikely(map_value_has_timer(map)))
-		memset(dst + map->timer_off, 0, sizeof(struct bpf_timer));
 	if (!IS_ERR_OR_NULL(map->fields_tab)) {
 		struct btf_field *fields = map->fields_tab->fields;
 		u32 cnt = map->fields_tab->cnt;
@@ -1730,6 +1740,7 @@ void btf_type_fields_free(struct btf_type_fields *tab);
 void bpf_map_free_fields_tab(struct bpf_map *map);
 struct btf_type_fields *btf_type_fields_dup(const struct btf_type_fields *tab);
 bool btf_type_fields_equal(const struct btf_type_fields *tab_a, const struct btf_type_fields *tab_b);
+void bpf_obj_free_timer(const struct btf_type_fields *tab, void *obj);
 void bpf_obj_free_fields(const struct btf_type_fields *tab, void *obj);
 
 struct bpf_map *bpf_map_get(u32 ufd);
diff --git a/include/linux/btf.h b/include/linux/btf.h
index 0d47cbb11a59..72136c9ae4cd 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -164,7 +164,8 @@ bool btf_member_is_reg_int(const struct btf *btf, const struct btf_type *s,
 int btf_find_spin_lock(const struct btf *btf, const struct btf_type *t);
 int btf_find_timer(const struct btf *btf, const struct btf_type *t);
 struct btf_type_fields *btf_parse_fields(const struct btf *btf,
-					 const struct btf_type *t);
+					 const struct btf_type *t,
+					 u32 field_mask, u32 value_size);
 bool btf_type_is_void(const struct btf_type *t);
 s32 btf_find_by_name_kind(const struct btf *btf, const char *name, u8 kind);
 const struct btf_type *btf_type_skip_modifiers(const struct btf *btf,
diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
index defe5c00049a..c993e164fb65 100644
--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -306,13 +306,6 @@ static int array_map_get_next_key(struct bpf_map *map, void *key, void *next_key
 	return 0;
 }
 
-static void check_and_free_fields(struct bpf_array *arr, void *val)
-{
-	if (map_value_has_timer(&arr->map))
-		bpf_timer_cancel_and_free(val + arr->map.timer_off);
-	bpf_obj_free_fields(arr->map.fields_tab, val);
-}
-
 /* Called from syscall or from eBPF program */
 static int array_map_update_elem(struct bpf_map *map, void *key, void *value,
 				 u64 map_flags)
@@ -334,13 +327,13 @@ static int array_map_update_elem(struct bpf_map *map, void *key, void *value,
 		return -EEXIST;
 
 	if (unlikely((map_flags & BPF_F_LOCK) &&
-		     !map_value_has_spin_lock(map)))
+		     !btf_type_fields_has_field(map->fields_tab, BPF_SPIN_LOCK)))
 		return -EINVAL;
 
 	if (array->map.map_type == BPF_MAP_TYPE_PERCPU_ARRAY) {
 		val = this_cpu_ptr(array->pptrs[index & array->index_mask]);
 		copy_map_value(map, val, value);
-		check_and_free_fields(array, val);
+		bpf_obj_free_fields(array->map.fields_tab, val);
 	} else {
 		val = array->value +
 			(u64)array->elem_size * (index & array->index_mask);
@@ -348,7 +341,7 @@ static int array_map_update_elem(struct bpf_map *map, void *key, void *value,
 			copy_map_value_locked(map, val, value, false);
 		else
 			copy_map_value(map, val, value);
-		check_and_free_fields(array, val);
+		bpf_obj_free_fields(array->map.fields_tab, val);
 	}
 	return 0;
 }
@@ -385,7 +378,7 @@ int bpf_percpu_array_update(struct bpf_map *map, void *key, void *value,
 	pptr = array->pptrs[index & array->index_mask];
 	for_each_possible_cpu(cpu) {
 		copy_map_value_long(map, per_cpu_ptr(pptr, cpu), value + off);
-		check_and_free_fields(array, per_cpu_ptr(pptr, cpu));
+		bpf_obj_free_fields(array->map.fields_tab, per_cpu_ptr(pptr, cpu));
 		off += size;
 	}
 	rcu_read_unlock();
@@ -409,11 +402,11 @@ static void array_map_free_timers(struct bpf_map *map)
 	int i;
 
 	/* We don't reset or free fields other than timer on uref dropping to zero. */
-	if (!map_value_has_timer(map))
+	if (!btf_type_fields_has_field(map->fields_tab, BPF_TIMER))
 		return;
 
 	for (i = 0; i < array->map.max_entries; i++)
-		bpf_timer_cancel_and_free(array_map_elem_ptr(array, i) + map->timer_off);
+		bpf_obj_free_timer(map->fields_tab, array_map_elem_ptr(array, i));
 }
 
 /* Called when map->refcnt goes to zero, either from workqueue or from syscall */
diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
index 802fc15b0d73..a3abebb7f38f 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -372,7 +372,7 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
 	if (unlikely((map_flags & ~BPF_F_LOCK) > BPF_EXIST) ||
 	    /* BPF_F_LOCK can only be used in a value with spin_lock */
 	    unlikely((map_flags & BPF_F_LOCK) &&
-		     !map_value_has_spin_lock(&smap->map)))
+		     !btf_type_fields_has_field(smap->map.fields_tab, BPF_SPIN_LOCK)))
 		return ERR_PTR(-EINVAL);
 
 	if (gfp_flags == GFP_KERNEL && (map_flags & ~BPF_F_LOCK) != BPF_NOEXIST)
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index c8d267098b87..fe00d9c95c96 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -3205,16 +3205,20 @@ enum {
 struct btf_field_info {
 	enum btf_field_type type;
 	u32 off;
-	u32 type_id;
+	struct {
+		u32 type_id;
+	} kptr;
 };
 
 static int btf_find_struct(const struct btf *btf, const struct btf_type *t,
-			   u32 off, int sz, struct btf_field_info *info)
+			   u32 off, int sz, enum btf_field_type field_type,
+			   struct btf_field_info *info)
 {
 	if (!__btf_type_is_struct(t))
 		return BTF_FIELD_IGNORE;
 	if (t->size != sz)
 		return BTF_FIELD_IGNORE;
+	info->type = field_type;
 	info->off = off;
 	return BTF_FIELD_FOUND;
 }
@@ -3251,28 +3255,66 @@ static int btf_find_kptr(const struct btf *btf, const struct btf_type *t,
 	if (!__btf_type_is_struct(t))
 		return -EINVAL;
 
-	info->type_id = res_id;
-	info->off = off;
 	info->type = type;
+	info->off = off;
+	info->kptr.type_id = res_id;
 	return BTF_FIELD_FOUND;
 }
 
-static int btf_find_struct_field(const struct btf *btf, const struct btf_type *t,
-				 const char *name, int sz, int align,
-				 enum btf_field_info_type field_type,
+static int btf_get_field_type(const char *name, u32 field_mask, u32 *seen_mask,
+			      int *align, int *sz)
+{
+	int type = 0;
+
+	if (field_mask & BPF_SPIN_LOCK) {
+		if (!strcmp(name, "bpf_spin_lock")) {
+			if (*seen_mask & BPF_SPIN_LOCK)
+				return -E2BIG;
+			*seen_mask |= BPF_SPIN_LOCK;
+			type = BPF_SPIN_LOCK;
+			goto end;
+		}
+	}
+	if (field_mask & BPF_TIMER) {
+		if (!strcmp(name, "bpf_timer")) {
+			if (*seen_mask & BPF_TIMER)
+				return -E2BIG;
+			*seen_mask |= BPF_TIMER;
+			type = BPF_TIMER;
+			goto end;
+		}
+	}
+	/* Only return BPF_KPTR when all other types with matchable names fail */
+	if (field_mask & BPF_KPTR) {
+		type = BPF_KPTR_REF;
+		goto end;
+	}
+	return 0;
+end:
+	*sz = btf_field_type_size(type);
+	*align = btf_field_type_align(type);
+	return type;
+}
+
+static int btf_find_struct_field(const struct btf *btf,
+				 const struct btf_type *t, u32 field_mask,
 				 struct btf_field_info *info, int info_cnt)
 {
+	int ret, idx = 0, align, sz, field_type;
 	const struct btf_member *member;
 	struct btf_field_info tmp;
-	int ret, idx = 0;
-	u32 i, off;
+	u32 i, off, seen_mask = 0;
 
 	for_each_member(i, t, member) {
 		const struct btf_type *member_type = btf_type_by_id(btf,
 								    member->type);
 
-		if (name && strcmp(__btf_name_by_offset(btf, member_type->name_off), name))
+		field_type = btf_get_field_type(__btf_name_by_offset(btf, member_type->name_off),
+						field_mask, &seen_mask, &align, &sz);
+		if (field_type == 0)
 			continue;
+		if (field_type < 0)
+			return field_type;
 
 		off = __btf_member_bit_offset(t, member);
 		if (off % 8)
@@ -3280,17 +3322,18 @@ static int btf_find_struct_field(const struct btf *btf, const struct btf_type *t
 			return -EINVAL;
 		off /= 8;
 		if (off % align)
-			return -EINVAL;
+			continue;
 
 		switch (field_type) {
-		case BTF_FIELD_SPIN_LOCK:
-		case BTF_FIELD_TIMER:
-			ret = btf_find_struct(btf, member_type, off, sz,
+		case BPF_SPIN_LOCK:
+		case BPF_TIMER:
+			ret = btf_find_struct(btf, member_type, off, sz, field_type,
 					      idx < info_cnt ? &info[idx] : &tmp);
 			if (ret < 0)
 				return ret;
 			break;
-		case BTF_FIELD_KPTR:
+		case BPF_KPTR_UNREF:
+		case BPF_KPTR_REF:
 			ret = btf_find_kptr(btf, member_type, off, sz,
 					    idx < info_cnt ? &info[idx] : &tmp);
 			if (ret < 0)
@@ -3310,37 +3353,41 @@ static int btf_find_struct_field(const struct btf *btf, const struct btf_type *t
 }
 
 static int btf_find_datasec_var(const struct btf *btf, const struct btf_type *t,
-				const char *name, int sz, int align,
-				enum btf_field_info_type field_type,
-				struct btf_field_info *info, int info_cnt)
+				u32 field_mask, struct btf_field_info *info,
+				int info_cnt)
 {
+	int ret, idx = 0, align, sz, field_type;
 	const struct btf_var_secinfo *vsi;
 	struct btf_field_info tmp;
-	int ret, idx = 0;
-	u32 i, off;
+	u32 i, off, seen_mask = 0;
 
 	for_each_vsi(i, t, vsi) {
 		const struct btf_type *var = btf_type_by_id(btf, vsi->type);
 		const struct btf_type *var_type = btf_type_by_id(btf, var->type);
 
-		off = vsi->offset;
-
-		if (name && strcmp(__btf_name_by_offset(btf, var_type->name_off), name))
+		field_type = btf_get_field_type(__btf_name_by_offset(btf, var_type->name_off),
+						field_mask, &seen_mask, &align, &sz);
+		if (field_type == 0)
 			continue;
+		if (field_type < 0)
+			return field_type;
+
+		off = vsi->offset;
 		if (vsi->size != sz)
 			continue;
 		if (off % align)
-			return -EINVAL;
+			continue;
 
 		switch (field_type) {
-		case BTF_FIELD_SPIN_LOCK:
-		case BTF_FIELD_TIMER:
-			ret = btf_find_struct(btf, var_type, off, sz,
+		case BPF_SPIN_LOCK:
+		case BPF_TIMER:
+			ret = btf_find_struct(btf, var_type, off, sz, field_type,
 					      idx < info_cnt ? &info[idx] : &tmp);
 			if (ret < 0)
 				return ret;
 			break;
-		case BTF_FIELD_KPTR:
+		case BPF_KPTR_UNREF:
+		case BPF_KPTR_REF:
 			ret = btf_find_kptr(btf, var_type, off, sz,
 					    idx < info_cnt ? &info[idx] : &tmp);
 			if (ret < 0)
@@ -3360,79 +3407,100 @@ static int btf_find_datasec_var(const struct btf *btf, const struct btf_type *t,
 }
 
 static int btf_find_field(const struct btf *btf, const struct btf_type *t,
-			  enum btf_field_info_type field_type,
-			  struct btf_field_info *info, int info_cnt)
+			  u32 field_mask, struct btf_field_info *info,
+			  int info_cnt)
 {
-	const char *name;
-	int sz, align;
-
-	switch (field_type) {
-	case BTF_FIELD_SPIN_LOCK:
-		name = "bpf_spin_lock";
-		sz = sizeof(struct bpf_spin_lock);
-		align = __alignof__(struct bpf_spin_lock);
-		break;
-	case BTF_FIELD_TIMER:
-		name = "bpf_timer";
-		sz = sizeof(struct bpf_timer);
-		align = __alignof__(struct bpf_timer);
-		break;
-	case BTF_FIELD_KPTR:
-		name = NULL;
-		sz = sizeof(u64);
-		align = 8;
-		break;
-	default:
-		return -EFAULT;
-	}
-
 	if (__btf_type_is_struct(t))
-		return btf_find_struct_field(btf, t, name, sz, align, field_type, info, info_cnt);
+		return btf_find_struct_field(btf, t, field_mask, info, info_cnt);
 	else if (btf_type_is_datasec(t))
-		return btf_find_datasec_var(btf, t, name, sz, align, field_type, info, info_cnt);
+		return btf_find_datasec_var(btf, t, field_mask, info, info_cnt);
 	return -EINVAL;
 }
 
-/* find 'struct bpf_spin_lock' in map value.
- * return >= 0 offset if found
- * and < 0 in case of error
- */
-int btf_find_spin_lock(const struct btf *btf, const struct btf_type *t)
+static int btf_parse_kptr(const struct btf *btf, struct btf_field *field,
+			  struct btf_field_info *info)
 {
-	struct btf_field_info info;
+	struct module *mod = NULL;
+	const struct btf_type *t;
+	struct btf *kernel_btf;
 	int ret;
+	s32 id;
 
-	ret = btf_find_field(btf, t, BTF_FIELD_SPIN_LOCK, &info, 1);
-	if (ret < 0)
-		return ret;
-	if (!ret)
-		return -ENOENT;
-	return info.off;
-}
+	/* Find type in map BTF, and use it to look up the matching type
+	 * in vmlinux or module BTFs, by name and kind.
+	 */
+	t = btf_type_by_id(btf, info->kptr.type_id);
+	id = bpf_find_btf_id(__btf_name_by_offset(btf, t->name_off), BTF_INFO_KIND(t->info),
+			     &kernel_btf);
+	if (id < 0)
+		return id;
+
+	/* Find and stash the function pointer for the destruction function that
+	 * needs to be eventually invoked from the map free path.
+	 */
+	if (info->type == BPF_KPTR_REF) {
+		const struct btf_type *dtor_func;
+		const char *dtor_func_name;
+		unsigned long addr;
+		s32 dtor_btf_id;
+
+		/* This call also serves as a whitelist of allowed objects that
+		 * can be used as a referenced pointer and be stored in a map at
+		 * the same time.
+		 */
+		dtor_btf_id = btf_find_dtor_kfunc(kernel_btf, id);
+		if (dtor_btf_id < 0) {
+			ret = dtor_btf_id;
+			goto end_btf;
+		}
 
-int btf_find_timer(const struct btf *btf, const struct btf_type *t)
-{
-	struct btf_field_info info;
-	int ret;
+		dtor_func = btf_type_by_id(kernel_btf, dtor_btf_id);
+		if (!dtor_func) {
+			ret = -ENOENT;
+			goto end_btf;
+		}
 
-	ret = btf_find_field(btf, t, BTF_FIELD_TIMER, &info, 1);
-	if (ret < 0)
-		return ret;
-	if (!ret)
-		return -ENOENT;
-	return info.off;
+		if (btf_is_module(kernel_btf)) {
+			mod = btf_try_get_module(kernel_btf);
+			if (!mod) {
+				ret = -ENXIO;
+				goto end_btf;
+			}
+		}
+
+		/* We already verified dtor_func to be btf_type_is_func
+		 * in register_btf_id_dtor_kfuncs.
+		 */
+		dtor_func_name = __btf_name_by_offset(kernel_btf, dtor_func->name_off);
+		addr = kallsyms_lookup_name(dtor_func_name);
+		if (!addr) {
+			ret = -EINVAL;
+			goto end_mod;
+		}
+		field->kptr.dtor = (void *)addr;
+	}
+
+	field->kptr.btf_id = id;
+	field->kptr.btf = kernel_btf;
+	field->kptr.module = mod;
+	return 0;
+end_mod:
+	module_put(mod);
+end_btf:
+	btf_put(kernel_btf);
+	return ret;
 }
 
 struct btf_type_fields *btf_parse_fields(const struct btf *btf,
-					 const struct btf_type *t)
+					 const struct btf_type *t,
+					 u32 field_mask,
+					 u32 value_size)
 {
 	struct btf_field_info info_arr[BTF_FIELDS_MAX];
-	struct btf *kernel_btf = NULL;
 	struct btf_type_fields *tab;
-	struct module *mod = NULL;
 	int ret, i, cnt;
 
-	ret = btf_find_field(btf, t, BTF_FIELD_KPTR, info_arr, ARRAY_SIZE(info_arr));
+	ret = btf_find_field(btf, t, field_mask, info_arr, ARRAY_SIZE(info_arr));
 	if (ret < 0)
 		return ERR_PTR(ret);
 	if (!ret)
@@ -3443,79 +3511,46 @@ struct btf_type_fields *btf_parse_fields(const struct btf *btf,
 	if (!tab)
 		return ERR_PTR(-ENOMEM);
 	tab->cnt = 0;
-	for (i = 0; i < cnt; i++) {
-		const struct btf_type *t;
-		s32 id;
 
-		/* Find type in map BTF, and use it to look up the matching type
-		 * in vmlinux or module BTFs, by name and kind.
-		 */
-		t = btf_type_by_id(btf, info_arr[i].type_id);
-		id = bpf_find_btf_id(__btf_name_by_offset(btf, t->name_off), BTF_INFO_KIND(t->info),
-				     &kernel_btf);
-		if (id < 0) {
-			ret = id;
+	tab->spin_lock_off = -EINVAL;
+	tab->timer_off = -EINVAL;
+	for (i = 0; i < cnt; i++) {
+		if (info_arr[i].off + btf_field_type_size(info_arr[i].type) > value_size) {
+			WARN_ONCE(1, "verifier bug off %d size %d", info_arr[i].off, value_size);
+			ret = -EFAULT;
 			goto end;
 		}
 
-		/* Find and stash the function pointer for the destruction function that
-		 * needs to be eventually invoked from the map free path.
-		 */
-		if (info_arr[i].type == BPF_KPTR_REF) {
-			const struct btf_type *dtor_func;
-			const char *dtor_func_name;
-			unsigned long addr;
-			s32 dtor_btf_id;
-
-			/* This call also serves as a whitelist of allowed objects that
-			 * can be used as a referenced pointer and be stored in a map at
-			 * the same time.
-			 */
-			dtor_btf_id = btf_find_dtor_kfunc(kernel_btf, id);
-			if (dtor_btf_id < 0) {
-				ret = dtor_btf_id;
-				goto end_btf;
-			}
-
-			dtor_func = btf_type_by_id(kernel_btf, dtor_btf_id);
-			if (!dtor_func) {
-				ret = -ENOENT;
-				goto end_btf;
-			}
-
-			if (btf_is_module(kernel_btf)) {
-				mod = btf_try_get_module(kernel_btf);
-				if (!mod) {
-					ret = -ENXIO;
-					goto end_btf;
-				}
-			}
+		tab->field_mask |= info_arr[i].type;
+		tab->fields[i].offset = info_arr[i].off;
+		tab->fields[i].type = info_arr[i].type;
 
-			/* We already verified dtor_func to be btf_type_is_func
-			 * in register_btf_id_dtor_kfuncs.
-			 */
-			dtor_func_name = __btf_name_by_offset(kernel_btf, dtor_func->name_off);
-			addr = kallsyms_lookup_name(dtor_func_name);
-			if (!addr) {
-				ret = -EINVAL;
-				goto end_mod;
-			}
-			tab->fields[i].kptr.dtor = (void *)addr;
+		switch (info_arr[i].type) {
+		case BPF_SPIN_LOCK:
+			WARN_ON_ONCE(tab->spin_lock_off >= 0);
+			/* Cache offset for faster lookup at runtime */
+			tab->spin_lock_off = tab->fields[i].offset;
+			break;
+		case BPF_TIMER:
+			WARN_ON_ONCE(tab->timer_off >= 0);
+			/* Cache offset for faster lookup at runtime */
+			tab->timer_off = tab->fields[i].offset;
+			break;
+		case BPF_KPTR_UNREF:
+		case BPF_KPTR_REF:
+			ret = btf_parse_kptr(btf, &tab->fields[i], &info_arr[i]);
+			if (ret < 0)
+				goto end;
+			break;
+		default:
+			ret = -EFAULT;
+			goto end;
 		}
 
-		tab->fields[i].offset = info_arr[i].off;
-		tab->fields[i].type = info_arr[i].type;
-		tab->fields[i].kptr.btf_id = id;
-		tab->fields[i].kptr.btf = kernel_btf;
-		tab->fields[i].kptr.module = mod;
 		tab->cnt++;
 	}
 	tab->cnt = cnt;
 	return tab;
-end_mod:
-	module_put(mod);
-end_btf:
-	btf_put(kernel_btf);
 end:
 	btf_type_fields_free(tab);
 	return ERR_PTR(ret);
diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 59cdbea587c5..b19c4efd8a80 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -222,7 +222,7 @@ static void htab_free_prealloced_timers(struct bpf_htab *htab)
 	u32 num_entries = htab->map.max_entries;
 	int i;
 
-	if (!map_value_has_timer(&htab->map))
+	if (!btf_type_fields_has_field(htab->map.fields_tab, BPF_TIMER))
 		return;
 	if (htab_has_extra_elems(htab))
 		num_entries += num_possible_cpus();
@@ -231,9 +231,8 @@ static void htab_free_prealloced_timers(struct bpf_htab *htab)
 		struct htab_elem *elem;
 
 		elem = get_htab_elem(htab, i);
-		bpf_timer_cancel_and_free(elem->key +
-					  round_up(htab->map.key_size, 8) +
-					  htab->map.timer_off);
+		bpf_obj_free_timer(htab->map.fields_tab, elem->key +
+				   round_up(htab->map.key_size, 8));
 		cond_resched();
 	}
 }
@@ -763,8 +762,6 @@ static void check_and_free_fields(struct bpf_htab *htab,
 {
 	void *map_value = elem->key + round_up(htab->map.key_size, 8);
 
-	if (map_value_has_timer(&htab->map))
-		bpf_timer_cancel_and_free(map_value + htab->map.timer_off);
 	bpf_obj_free_fields(htab->map.fields_tab, map_value);
 }
 
@@ -1089,7 +1086,7 @@ static int htab_map_update_elem(struct bpf_map *map, void *key, void *value,
 	head = &b->head;
 
 	if (unlikely(map_flags & BPF_F_LOCK)) {
-		if (unlikely(!map_value_has_spin_lock(map)))
+		if (unlikely(!btf_type_fields_has_field(map->fields_tab, BPF_SPIN_LOCK)))
 			return -EINVAL;
 		/* find an element without taking the bucket lock */
 		l_old = lookup_nulls_elem_raw(head, hash, key, key_size,
@@ -1472,12 +1469,9 @@ static void htab_free_malloced_timers(struct bpf_htab *htab)
 		struct htab_elem *l;
 
 		hlist_nulls_for_each_entry(l, n, head, hash_node) {
-			/* We don't reset or free kptr on uref dropping to zero,
-			 * hence just free timer.
-			 */
-			bpf_timer_cancel_and_free(l->key +
-						  round_up(htab->map.key_size, 8) +
-						  htab->map.timer_off);
+			/* We only free timer on uref dropping to zero */
+			bpf_obj_free_timer(htab->map.fields_tab, l->key +
+					   round_up(htab->map.key_size, 8));
 		}
 		cond_resched_rcu();
 	}
@@ -1488,8 +1482,8 @@ static void htab_map_free_timers(struct bpf_map *map)
 {
 	struct bpf_htab *htab = container_of(map, struct bpf_htab, map);
 
-	/* We don't reset or free kptr on uref dropping to zero. */
-	if (!map_value_has_timer(&htab->map))
+	/* We only free timer on uref dropping to zero */
+	if (!btf_type_fields_has_field(htab->map.fields_tab, BPF_TIMER))
 		return;
 	if (!htab_is_prealloc(htab))
 		htab_free_malloced_timers(htab);
@@ -1673,7 +1667,7 @@ __htab_map_lookup_and_delete_batch(struct bpf_map *map,
 
 	elem_map_flags = attr->batch.elem_flags;
 	if ((elem_map_flags & ~BPF_F_LOCK) ||
-	    ((elem_map_flags & BPF_F_LOCK) && !map_value_has_spin_lock(map)))
+	    ((elem_map_flags & BPF_F_LOCK) && !btf_type_fields_has_field(map->fields_tab, BPF_SPIN_LOCK)))
 		return -EINVAL;
 
 	map_flags = attr->batch.flags;
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index a6b04faed282..8f425596b9c6 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -366,9 +366,9 @@ void copy_map_value_locked(struct bpf_map *map, void *dst, void *src,
 	struct bpf_spin_lock *lock;
 
 	if (lock_src)
-		lock = src + map->spin_lock_off;
+		lock = src + map->fields_tab->spin_lock_off;
 	else
-		lock = dst + map->spin_lock_off;
+		lock = dst + map->fields_tab->spin_lock_off;
 	preempt_disable();
 	__bpf_spin_lock_irqsave(lock);
 	copy_map_value(map, dst, src);
@@ -1169,7 +1169,7 @@ BPF_CALL_3(bpf_timer_init, struct bpf_timer_kern *, timer, struct bpf_map *, map
 		ret = -ENOMEM;
 		goto out;
 	}
-	t->value = (void *)timer - map->timer_off;
+	t->value = (void *)timer - map->fields_tab->timer_off;
 	t->map = map;
 	t->prog = NULL;
 	rcu_assign_pointer(t->callback_fn, NULL);
diff --git a/kernel/bpf/local_storage.c b/kernel/bpf/local_storage.c
index 098cf336fae6..42af40c74c40 100644
--- a/kernel/bpf/local_storage.c
+++ b/kernel/bpf/local_storage.c
@@ -151,7 +151,7 @@ static int cgroup_storage_update_elem(struct bpf_map *map, void *key,
 		return -EINVAL;
 
 	if (unlikely((flags & BPF_F_LOCK) &&
-		     !map_value_has_spin_lock(map)))
+		     !btf_type_fields_has_field(map->fields_tab, BPF_SPIN_LOCK)))
 		return -EINVAL;
 
 	storage = cgroup_storage_lookup((struct bpf_cgroup_storage_map *)map,
diff --git a/kernel/bpf/map_in_map.c b/kernel/bpf/map_in_map.c
index 2bff5f3a5efc..b3f82fec8e2e 100644
--- a/kernel/bpf/map_in_map.c
+++ b/kernel/bpf/map_in_map.c
@@ -29,7 +29,7 @@ struct bpf_map *bpf_map_meta_alloc(int inner_map_ufd)
 		return ERR_PTR(-ENOTSUPP);
 	}
 
-	if (map_value_has_spin_lock(inner_map)) {
+	if (btf_type_fields_has_field(inner_map->fields_tab, BPF_SPIN_LOCK)) {
 		fdput(f);
 		return ERR_PTR(-ENOTSUPP);
 	}
@@ -50,8 +50,6 @@ struct bpf_map *bpf_map_meta_alloc(int inner_map_ufd)
 	inner_map_meta->value_size = inner_map->value_size;
 	inner_map_meta->map_flags = inner_map->map_flags;
 	inner_map_meta->max_entries = inner_map->max_entries;
-	inner_map_meta->spin_lock_off = inner_map->spin_lock_off;
-	inner_map_meta->timer_off = inner_map->timer_off;
 	inner_map_meta->fields_tab = btf_type_fields_dup(inner_map->fields_tab);
 	if (IS_ERR(inner_map_meta->fields_tab)) {
 		/* btf_type_fields returns NULL or valid pointer in case of
@@ -91,7 +89,6 @@ bool bpf_map_meta_equal(const struct bpf_map *meta0,
 	return meta0->map_type == meta1->map_type &&
 		meta0->key_size == meta1->key_size &&
 		meta0->value_size == meta1->value_size &&
-		meta0->timer_off == meta1->timer_off &&
 		meta0->map_flags == meta1->map_flags &&
 		btf_type_fields_equal(meta0->fields_tab, meta1->fields_tab);
 }
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 83e7a290ad06..afa736132cc5 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -527,6 +527,9 @@ void btf_type_fields_free(struct btf_type_fields *tab)
 		return;
 	for (i = 0; i < tab->cnt; i++) {
 		switch (tab->fields[i].type) {
+		case BPF_SPIN_LOCK:
+		case BPF_TIMER:
+			break;
 		case BPF_KPTR_UNREF:
 		case BPF_KPTR_REF:
 			if (tab->fields[i].kptr.module)
@@ -564,6 +567,9 @@ struct btf_type_fields *btf_type_fields_dup(const struct btf_type_fields *tab)
 	new_tab->cnt = 0;
 	for (i = 0; i < tab->cnt; i++) {
 		switch (fields[i].type) {
+		case BPF_SPIN_LOCK:
+		case BPF_TIMER:
+			break;
 		case BPF_KPTR_UNREF:
 		case BPF_KPTR_REF:
 			btf_get(fields[i].kptr.btf);
@@ -600,6 +606,13 @@ bool btf_type_fields_equal(const struct btf_type_fields *tab_a, const struct btf
 	return !memcmp(tab_a, tab_b, size);
 }
 
+void bpf_obj_free_timer(const struct btf_type_fields *tab, void *obj)
+{
+	if (WARN_ON_ONCE(!btf_type_fields_has_field(tab, BPF_TIMER)))
+		return;
+	bpf_timer_cancel_and_free(obj + tab->timer_off);
+}
+
 void bpf_obj_free_fields(const struct btf_type_fields *tab, void *obj)
 {
 	const struct btf_field *fields;
@@ -613,6 +626,11 @@ void bpf_obj_free_fields(const struct btf_type_fields *tab, void *obj)
 		void *field_ptr = obj + field->offset;
 
 		switch (fields[i].type) {
+		case BPF_SPIN_LOCK:
+			break;
+		case BPF_TIMER:
+			bpf_timer_cancel_and_free(field_ptr);
+			break;
 		case BPF_KPTR_UNREF:
 			WRITE_ONCE(*(u64 *)field_ptr, 0);
 			break;
@@ -798,8 +816,7 @@ static int bpf_map_mmap(struct file *filp, struct vm_area_struct *vma)
 	struct bpf_map *map = filp->private_data;
 	int err;
 
-	if (!map->ops->map_mmap || map_value_has_spin_lock(map) ||
-	    map_value_has_timer(map) || !IS_ERR_OR_NULL(map->fields_tab))
+	if (!map->ops->map_mmap || !IS_ERR_OR_NULL(map->fields_tab))
 		return -ENOTSUPP;
 
 	if (!(vma->vm_flags & VM_SHARED))
@@ -954,13 +971,11 @@ static void map_off_arr_swap(void *_a, void *_b, int size, const void *priv)
 
 static int bpf_map_alloc_off_arr(struct bpf_map *map)
 {
-	bool has_spin_lock = map_value_has_spin_lock(map);
-	bool has_timer = map_value_has_timer(map);
 	bool has_fields = !IS_ERR_OR_NULL(map);
 	struct btf_type_fields_off *off_arr;
 	u32 i;
 
-	if (!has_spin_lock && !has_timer && !has_fields) {
+	if (!has_fields) {
 		map->off_arr = NULL;
 		return 0;
 	}
@@ -971,20 +986,6 @@ static int bpf_map_alloc_off_arr(struct bpf_map *map)
 	map->off_arr = off_arr;
 
 	off_arr->cnt = 0;
-	if (has_spin_lock) {
-		i = off_arr->cnt;
-
-		off_arr->field_off[i] = map->spin_lock_off;
-		off_arr->field_sz[i] = sizeof(struct bpf_spin_lock);
-		off_arr->cnt++;
-	}
-	if (has_timer) {
-		i = off_arr->cnt;
-
-		off_arr->field_off[i] = map->timer_off;
-		off_arr->field_sz[i] = sizeof(struct bpf_timer);
-		off_arr->cnt++;
-	}
 	if (has_fields) {
 		struct btf_type_fields *tab = map->fields_tab;
 		u32 *off = &off_arr->field_off[off_arr->cnt];
@@ -994,7 +995,7 @@ static int bpf_map_alloc_off_arr(struct bpf_map *map)
 			*off++ = tab->fields[i].offset;
 			*sz++ = btf_field_type_size(tab->fields[i].type);
 		}
-		off_arr->cnt += tab->cnt;
+		off_arr->cnt = tab->cnt;
 	}
 
 	if (off_arr->cnt == 1)
@@ -1026,38 +1027,8 @@ static int map_check_btf(struct bpf_map *map, const struct btf *btf,
 	if (!value_type || value_size != map->value_size)
 		return -EINVAL;
 
-	map->spin_lock_off = btf_find_spin_lock(btf, value_type);
-
-	if (map_value_has_spin_lock(map)) {
-		if (map->map_flags & BPF_F_RDONLY_PROG)
-			return -EACCES;
-		if (map->map_type != BPF_MAP_TYPE_HASH &&
-		    map->map_type != BPF_MAP_TYPE_ARRAY &&
-		    map->map_type != BPF_MAP_TYPE_CGROUP_STORAGE &&
-		    map->map_type != BPF_MAP_TYPE_SK_STORAGE &&
-		    map->map_type != BPF_MAP_TYPE_INODE_STORAGE &&
-		    map->map_type != BPF_MAP_TYPE_TASK_STORAGE)
-			return -ENOTSUPP;
-		if (map->spin_lock_off + sizeof(struct bpf_spin_lock) >
-		    map->value_size) {
-			WARN_ONCE(1,
-				  "verifier bug spin_lock_off %d value_size %d\n",
-				  map->spin_lock_off, map->value_size);
-			return -EFAULT;
-		}
-	}
-
-	map->timer_off = btf_find_timer(btf, value_type);
-	if (map_value_has_timer(map)) {
-		if (map->map_flags & BPF_F_RDONLY_PROG)
-			return -EACCES;
-		if (map->map_type != BPF_MAP_TYPE_HASH &&
-		    map->map_type != BPF_MAP_TYPE_LRU_HASH &&
-		    map->map_type != BPF_MAP_TYPE_ARRAY)
-			return -EOPNOTSUPP;
-	}
-
-	map->fields_tab = btf_parse_fields(btf, value_type);
+	map->fields_tab = btf_parse_fields(btf, value_type, BPF_SPIN_LOCK | BPF_TIMER | BPF_KPTR,
+					   map->value_size);
 	if (!IS_ERR_OR_NULL(map->fields_tab)) {
 		int i;
 
@@ -1073,6 +1044,25 @@ static int map_check_btf(struct bpf_map *map, const struct btf *btf,
 			switch (map->fields_tab->field_mask & (1 << i)) {
 			case 0:
 				continue;
+			case BPF_SPIN_LOCK:
+				if (map->map_type != BPF_MAP_TYPE_HASH &&
+				    map->map_type != BPF_MAP_TYPE_ARRAY &&
+				    map->map_type != BPF_MAP_TYPE_CGROUP_STORAGE &&
+				    map->map_type != BPF_MAP_TYPE_SK_STORAGE &&
+				    map->map_type != BPF_MAP_TYPE_INODE_STORAGE &&
+				    map->map_type != BPF_MAP_TYPE_TASK_STORAGE) {
+					ret = -EOPNOTSUPP;
+					goto free_map_tab;
+				}
+				break;
+			case BPF_TIMER:
+				if (map->map_type != BPF_MAP_TYPE_HASH &&
+				    map->map_type != BPF_MAP_TYPE_LRU_HASH &&
+				    map->map_type != BPF_MAP_TYPE_ARRAY) {
+					return -EOPNOTSUPP;
+					goto free_map_tab;
+				}
+				break;
 			case BPF_KPTR_UNREF:
 			case BPF_KPTR_REF:
 				if (map->map_type != BPF_MAP_TYPE_HASH &&
@@ -1152,8 +1142,6 @@ static int map_create(union bpf_attr *attr)
 	mutex_init(&map->freeze_mutex);
 	spin_lock_init(&map->owner.lock);
 
-	map->spin_lock_off = -EINVAL;
-	map->timer_off = -EINVAL;
 	if (attr->btf_key_type_id || attr->btf_value_type_id ||
 	    /* Even the map's value is a kernel's struct,
 	     * the bpf_prog.o must have BTF to begin with
@@ -1367,7 +1355,7 @@ static int map_lookup_elem(union bpf_attr *attr)
 	}
 
 	if ((attr->flags & BPF_F_LOCK) &&
-	    !map_value_has_spin_lock(map)) {
+	    !btf_type_fields_has_field(map->fields_tab, BPF_SPIN_LOCK)) {
 		err = -EINVAL;
 		goto err_put;
 	}
@@ -1440,7 +1428,7 @@ static int map_update_elem(union bpf_attr *attr, bpfptr_t uattr)
 	}
 
 	if ((attr->flags & BPF_F_LOCK) &&
-	    !map_value_has_spin_lock(map)) {
+	    !btf_type_fields_has_field(map->fields_tab, BPF_SPIN_LOCK)) {
 		err = -EINVAL;
 		goto err_put;
 	}
@@ -1603,7 +1591,7 @@ int generic_map_delete_batch(struct bpf_map *map,
 		return -EINVAL;
 
 	if ((attr->batch.elem_flags & BPF_F_LOCK) &&
-	    !map_value_has_spin_lock(map)) {
+	    !btf_type_fields_has_field(map->fields_tab, BPF_SPIN_LOCK)) {
 		return -EINVAL;
 	}
 
@@ -1660,7 +1648,7 @@ int generic_map_update_batch(struct bpf_map *map,
 		return -EINVAL;
 
 	if ((attr->batch.elem_flags & BPF_F_LOCK) &&
-	    !map_value_has_spin_lock(map)) {
+	    !btf_type_fields_has_field(map->fields_tab, BPF_SPIN_LOCK)) {
 		return -EINVAL;
 	}
 
@@ -1723,7 +1711,7 @@ int generic_map_lookup_batch(struct bpf_map *map,
 		return -EINVAL;
 
 	if ((attr->batch.elem_flags & BPF_F_LOCK) &&
-	    !map_value_has_spin_lock(map))
+	    !btf_type_fields_has_field(map->fields_tab, BPF_SPIN_LOCK))
 		return -EINVAL;
 
 	value_size = bpf_map_value_size(map);
@@ -1845,7 +1833,7 @@ static int map_lookup_and_delete_elem(union bpf_attr *attr)
 	}
 
 	if ((attr->flags & BPF_F_LOCK) &&
-	    !map_value_has_spin_lock(map)) {
+	    !btf_type_fields_has_field(map->fields_tab, BPF_SPIN_LOCK)) {
 		err = -EINVAL;
 		goto err_put;
 	}
@@ -1916,8 +1904,7 @@ static int map_freeze(const union bpf_attr *attr)
 	if (IS_ERR(map))
 		return PTR_ERR(map);
 
-	if (map->map_type == BPF_MAP_TYPE_STRUCT_OPS ||
-	    map_value_has_timer(map) || !IS_ERR_OR_NULL(map->fields_tab)) {
+	if (map->map_type == BPF_MAP_TYPE_STRUCT_OPS || !IS_ERR_OR_NULL(map->fields_tab)) {
 		fdput(f);
 		return -ENOTSUPP;
 	}
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 9c375949804d..8660d08589c8 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -454,7 +454,7 @@ static bool reg_type_not_null(enum bpf_reg_type type)
 static bool reg_may_point_to_spin_lock(const struct bpf_reg_state *reg)
 {
 	return reg->type == PTR_TO_MAP_VALUE &&
-		map_value_has_spin_lock(reg->map_ptr);
+		btf_type_fields_has_field(reg->map_ptr->fields_tab, BPF_SPIN_LOCK);
 }
 
 static bool type_is_rdonly_mem(u32 type)
@@ -1388,7 +1388,7 @@ static void mark_ptr_not_null_reg(struct bpf_reg_state *reg)
 			/* transfer reg's id which is unique for every map_lookup_elem
 			 * as UID of the inner map.
 			 */
-			if (map_value_has_timer(map->inner_map_meta))
+			if (btf_type_fields_has_field(map->inner_map_meta->fields_tab, BPF_TIMER))
 				reg->map_uid = reg->id;
 		} else if (map->map_type == BPF_MAP_TYPE_XSKMAP) {
 			reg->type = PTR_TO_XDP_SOCK;
@@ -3817,29 +3817,6 @@ static int check_map_access(struct bpf_verifier_env *env, u32 regno,
 	if (err)
 		return err;
 
-	if (map_value_has_spin_lock(map)) {
-		u32 lock = map->spin_lock_off;
-
-		/* if any part of struct bpf_spin_lock can be touched by
-		 * load/store reject this program.
-		 * To check that [x1, x2) overlaps with [y1, y2)
-		 * it is sufficient to check x1 < y2 && y1 < x2.
-		 */
-		if (reg->smin_value + off < lock + sizeof(struct bpf_spin_lock) &&
-		     lock < reg->umax_value + off + size) {
-			verbose(env, "bpf_spin_lock cannot be accessed directly by load/store\n");
-			return -EACCES;
-		}
-	}
-	if (map_value_has_timer(map)) {
-		u32 t = map->timer_off;
-
-		if (reg->smin_value + off < t + sizeof(struct bpf_timer) &&
-		     t < reg->umax_value + off + size) {
-			verbose(env, "bpf_timer cannot be accessed directly by load/store\n");
-			return -EACCES;
-		}
-	}
 	if (IS_ERR_OR_NULL(map->fields_tab))
 		return 0;
 	tab = map->fields_tab;
@@ -3847,6 +3824,11 @@ static int check_map_access(struct bpf_verifier_env *env, u32 regno,
 		struct btf_field *field = &tab->fields[i];
 		u32 p = field->offset;
 
+		/* if any part of struct bpf_spin_lock can be touched by
+		 * load/store reject this program.
+		 * To check that [x1, x2) overlaps with [y1, y2)
+		 * it is sufficient to check x1 < y2 && y1 < x2.
+		 */
 		if (reg->smin_value + off < p + btf_field_type_size(field->type) &&
 		    p < reg->umax_value + off + size) {
 			switch (field->type) {
@@ -3871,7 +3853,8 @@ static int check_map_access(struct bpf_verifier_env *env, u32 regno,
 				}
 				break;
 			default:
-				verbose(env, "field cannot be accessed directly by load/store\n");
+				verbose(env, "%s cannot be accessed directly by load/store\n",
+					btf_field_type_name(field->type));
 				return -EACCES;
 			}
 		}
@@ -5440,24 +5423,13 @@ static int process_spin_lock(struct bpf_verifier_env *env, int regno,
 			map->name);
 		return -EINVAL;
 	}
-	if (!map_value_has_spin_lock(map)) {
-		if (map->spin_lock_off == -E2BIG)
-			verbose(env,
-				"map '%s' has more than one 'struct bpf_spin_lock'\n",
-				map->name);
-		else if (map->spin_lock_off == -ENOENT)
-			verbose(env,
-				"map '%s' doesn't have 'struct bpf_spin_lock'\n",
-				map->name);
-		else
-			verbose(env,
-				"map '%s' is not a struct type or bpf_spin_lock is mangled\n",
-				map->name);
+	if (!btf_type_fields_has_field(map->fields_tab, BPF_SPIN_LOCK)) {
+		verbose(env, "map '%s' has no valid bpf_spin_lock\n", map->name);
 		return -EINVAL;
 	}
-	if (map->spin_lock_off != val + reg->off) {
-		verbose(env, "off %lld doesn't point to 'struct bpf_spin_lock'\n",
-			val + reg->off);
+	if (map->fields_tab->spin_lock_off != val + reg->off) {
+		verbose(env, "off %lld doesn't point to 'struct bpf_spin_lock' that is at %d\n",
+			val + reg->off, map->fields_tab->spin_lock_off);
 		return -EINVAL;
 	}
 	if (is_lock) {
@@ -5500,24 +5472,13 @@ static int process_timer_func(struct bpf_verifier_env *env, int regno,
 			map->name);
 		return -EINVAL;
 	}
-	if (!map_value_has_timer(map)) {
-		if (map->timer_off == -E2BIG)
-			verbose(env,
-				"map '%s' has more than one 'struct bpf_timer'\n",
-				map->name);
-		else if (map->timer_off == -ENOENT)
-			verbose(env,
-				"map '%s' doesn't have 'struct bpf_timer'\n",
-				map->name);
-		else
-			verbose(env,
-				"map '%s' is not a struct type or bpf_timer is mangled\n",
-				map->name);
+	if (!btf_type_fields_has_field(map->fields_tab, BPF_TIMER)) {
+		verbose(env, "map '%s' has no valid bpf_timer\n", map->name);
 		return -EINVAL;
 	}
-	if (map->timer_off != val + reg->off) {
+	if (map->fields_tab->timer_off != val + reg->off) {
 		verbose(env, "off %lld doesn't point to 'struct bpf_timer' that is at %d\n",
-			val + reg->off, map->timer_off);
+			val + reg->off, map->fields_tab->timer_off);
 		return -EINVAL;
 	}
 	if (meta->map_ptr) {
@@ -7469,7 +7430,7 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 		regs[BPF_REG_0].map_uid = meta.map_uid;
 		regs[BPF_REG_0].type = PTR_TO_MAP_VALUE | ret_flag;
 		if (!type_may_be_null(ret_type) &&
-		    map_value_has_spin_lock(meta.map_ptr)) {
+		    btf_type_fields_has_field(meta.map_ptr->fields_tab, BPF_SPIN_LOCK)) {
 			regs[BPF_REG_0].id = ++env->id_gen;
 		}
 		break;
@@ -10380,7 +10341,7 @@ static int check_ld_imm(struct bpf_verifier_env *env, struct bpf_insn *insn)
 	    insn->src_reg == BPF_PSEUDO_MAP_IDX_VALUE) {
 		dst_reg->type = PTR_TO_MAP_VALUE;
 		dst_reg->off = aux->map_off;
-		if (map_value_has_spin_lock(map))
+		if (btf_type_fields_has_field(map->fields_tab, BPF_SPIN_LOCK))
 			dst_reg->id = ++env->id_gen;
 	} else if (insn->src_reg == BPF_PSEUDO_MAP_FD ||
 		   insn->src_reg == BPF_PSEUDO_MAP_IDX) {
@@ -12658,7 +12619,7 @@ static int check_map_prog_compatibility(struct bpf_verifier_env *env,
 {
 	enum bpf_prog_type prog_type = resolve_prog_type(prog);
 
-	if (map_value_has_spin_lock(map)) {
+	if (btf_type_fields_has_field(map->fields_tab, BPF_SPIN_LOCK)) {
 		if (prog_type == BPF_PROG_TYPE_SOCKET_FILTER) {
 			verbose(env, "socket filter progs cannot use bpf_spin_lock yet\n");
 			return -EINVAL;
@@ -12675,7 +12636,7 @@ static int check_map_prog_compatibility(struct bpf_verifier_env *env,
 		}
 	}
 
-	if (map_value_has_timer(map)) {
+	if (btf_type_fields_has_field(map->fields_tab, BPF_TIMER)) {
 		if (is_tracing_prog_type(prog_type)) {
 			verbose(env, "tracing progs cannot use bpf_timer yet\n");
 			return -EINVAL;
diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
index 94374d529ea4..f6bbe83329d7 100644
--- a/net/core/bpf_sk_storage.c
+++ b/net/core/bpf_sk_storage.c
@@ -176,7 +176,7 @@ bpf_sk_storage_clone_elem(struct sock *newsk,
 	if (!copy_selem)
 		return NULL;
 
-	if (map_value_has_spin_lock(&smap->map))
+	if (btf_type_fields_has_field(smap->map.fields_tab, BPF_SPIN_LOCK))
 		copy_map_value_locked(&smap->map, SDATA(copy_selem)->data,
 				      SDATA(selem)->data, true);
 	else
@@ -595,7 +595,7 @@ static int diag_get(struct bpf_local_storage_data *sdata, struct sk_buff *skb)
 	if (!nla_value)
 		goto errout;
 
-	if (map_value_has_spin_lock(&smap->map))
+	if (btf_type_fields_has_field(smap->map.fields_tab, BPF_SPIN_LOCK))
 		copy_map_value_locked(&smap->map, nla_data(nla_value),
 				      sdata->data, true);
 	else
-- 
2.34.1

