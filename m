Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDDAD616EAA
	for <lists+bpf@lfdr.de>; Wed,  2 Nov 2022 21:27:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231278AbiKBU1t (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Nov 2022 16:27:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231202AbiKBU1n (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Nov 2022 16:27:43 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00DE9642E
        for <bpf@vger.kernel.org>; Wed,  2 Nov 2022 13:27:31 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id gw22so4385351pjb.3
        for <bpf@vger.kernel.org>; Wed, 02 Nov 2022 13:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vU3eM+Dd7xds20yt+R+knpMrnDU3NuOrsHv1ojjnW6E=;
        b=PpgCBg2eMwCyqldexKXeidr3NcR7SYjjd1BN0IgADuLlF6JJUC1gTzjCl+GL387dF8
         eti1Ccmc6G2UITeFGpajul4uKb5s72ypN2RDqyR6B3AuYYH67Em1QAKprQj8GpvH6yzZ
         +XaGl6DtZBRP4gzUu4FyV7EawQev63Txe+1qHuNldzxG7K7Gyf9Pb6kIiRMK/HkUGwPx
         hFtV+H7I6H5l0DzjZgkMN0myxj9hSXtn5wkgJFKV6ewFtzj6oXkSZ4ZyJMn0r3//OPn/
         k8SPvagsg6spZ8/vm634ZS/nMN5nu4/3BQTkQXs23NXcYicHwhJf0zaXIU04Nhp0U+XM
         nohg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vU3eM+Dd7xds20yt+R+knpMrnDU3NuOrsHv1ojjnW6E=;
        b=Z+TaDEPXTEBifIavoOAZwJ/d0+UwXjghTeQh1K9tRXyZ2tOlynL5ZqRfYVk6Hj3BDz
         gwIUdVQv7cadOhLhVwx6REGyOfX67IDW10dsg9CDwqlNwdbOq6LKQzO56iE7SCM/cUQ4
         t5Fy3OB6NEyqqgd9tqg9VK4TiHeNflA8lykz1VxwUJEwiBFKLBTVlIvYlMCZ+T3hNczd
         0RX3oTKwN6U/BIOVV5IFoevSD50TjnXgp2RdM6Pgic0weKesX1Pz0DvC8QU8jthRTXWv
         fhH2ZgAY47kIu/Ewg2VNFiHtQDri8dDhAiDFdxbesuuIoZ73tsRhBZ2YXTEjd0IWW73D
         TwgA==
X-Gm-Message-State: ACrzQf0y6gaK6Evy1O01qaBWtwdto4dDvthBAMnJ8IqGmJ1mGEwGaIgk
        voVuMcWDjyC+Q0R0+5wlljcxi6VWQvMAUQ==
X-Google-Smtp-Source: AMsMyM4TVDUO0kReGuQs/hj7OBkSbcgZxPykLZe91qBMKka+D0ps8hyxbaetrgeJKz0To0zhUYZudQ==
X-Received: by 2002:a17:902:ebc7:b0:17e:7378:1da8 with SMTP id p7-20020a170902ebc700b0017e73781da8mr26720669plg.152.1667420850649;
        Wed, 02 Nov 2022 13:27:30 -0700 (PDT)
Received: from localhost ([59.152.80.69])
        by smtp.gmail.com with ESMTPSA id u9-20020a17090341c900b00186c3af9644sm8729946ple.273.2022.11.02.13.27.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 13:27:30 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>,
        Delyan Kratunov <delyank@meta.com>
Subject: [PATCH bpf-next v3 07/24] bpf: Consolidate spin_lock, timer management into btf_record
Date:   Thu,  3 Nov 2022 01:56:41 +0530
Message-Id: <20221102202658.963008-8-memxor@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221102202658.963008-1-memxor@gmail.com>
References: <20221102202658.963008-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=43637; i=memxor@gmail.com; h=from:subject; bh=X0Iiz7UxePqMacsWP6MDO5DnewfUxFW85x+SkpkgAaY=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjYtIDeO5D0EwxIhhxABoDlgauiZPTAM+UqYwl9UN3 39GnZ8WJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY2LSAwAKCRBM4MiGSL8Ryp73EA CONKXw56XPbW63dURbulE4sfj70Bs4jJjYCq8qdgF175zk77h6YPpOBGXCXnHBq5HaRzjDb+lIQJHc pwJsnxiYJBHbGAtCYxQJNXERuAtWhFzaf36vpp46ln9wT+d3UrkuFgmbGbr1W7fVcXjD2MTVxfGPjY 2F1qOXCGr+v69RnhWyvqsA+0TU9qNatTOuONbWPdfCmd+YjR/xwhD4iS8naqqTEKVHpWlxtW5Chi0Q +lUKBIlndGFY/+L/stYL6ajuAl7ObNvm1KU/B6YFt3BmDxU8JFquOtUtngJ2lacg4C8eRBI+D0nmkq Fm73RcwHuBbAPNI6zz927xyQo3LqphannO3UoreMs2QmTX8vke9B1xvKiqs3cySPmvrIy+gRp+AW3b zJAbRZKtIm3AFUpeZAcDW/vLZhHwElUMmb5nTri/H69NbfR4LI13LLoM+BYcMoiCKBvNGD35ElzmiJ KfY7PCZGCAX4pO2dsPLj7WMERabDUGMr/EQ6oeKwvZCiHeXd1vZDihr94OXN81e03Gy57TWhmm67g9 lMMRazfT7ofeJt6LsXdPY3RWA0RCjiJ9wf9g7u8dxf+tPaJC4jiozCbmuMmD3uv8vCq8kgnGB5CYOG DnCysY9/dlC8D7R3YWRDdvFn2hfVJcl4tLW4K9h9Vy2yFxANor/44E3HTDUQ==
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

Now that kptr_off_tab has been refactored into btf_record, and can hold
more than one specific field type, accomodate bpf_spin_lock and
bpf_timer as well.

While they don't require any more metadata than offset, having all
special fields in one place allows us to share the same code for
allocated user defined types and handle both map values and these
allocated objects in a similar fashion.

As an optimization, we still keep spin_lock_off and timer_off offsets in
the btf_record structure, just to avoid having to find the btf_field
struct each time their offset is needed. This is mostly needed to
manipulate such objects in a map value at runtime. It's ok to hardcode
just one offset as more than one field is disallowed.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf.h            |  53 +++---
 include/linux/btf.h            |   3 +-
 kernel/bpf/arraymap.c          |  19 +-
 kernel/bpf/bpf_local_storage.c |   2 +-
 kernel/bpf/btf.c               | 325 ++++++++++++++++++---------------
 kernel/bpf/hashtab.c           |  24 +--
 kernel/bpf/helpers.c           |   6 +-
 kernel/bpf/local_storage.c     |   2 +-
 kernel/bpf/map_in_map.c        |   5 +-
 kernel/bpf/syscall.c           | 133 ++++++--------
 kernel/bpf/verifier.c          |  82 +++------
 net/core/bpf_sk_storage.c      |   4 +-
 12 files changed, 314 insertions(+), 344 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index e6fe78485e33..762e9a20c358 100644
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
 struct btf_record {
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
-	struct btf_record *record;
-	int timer_off; /* >=0 valid offset, <0 error */
 	u32 id;
+	struct btf_record *record;
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
@@ -287,22 +311,8 @@ static inline bool btf_record_has_field(const struct btf_record *rec, enum btf_f
 	return rec->field_mask & type;
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
 	if (!IS_ERR_OR_NULL(map->record)) {
 		struct btf_field *fields = map->record->fields;
 		u32 cnt = map->record->cnt;
@@ -1726,6 +1736,7 @@ void btf_record_free(struct btf_record *rec);
 void bpf_map_free_record(struct bpf_map *map);
 struct btf_record *btf_record_dup(const struct btf_record *rec);
 bool btf_record_equal(const struct btf_record *rec_a, const struct btf_record *rec_b);
+void bpf_obj_free_timer(const struct btf_record *rec, void *obj);
 void bpf_obj_free_fields(const struct btf_record *rec, void *obj);
 
 struct bpf_map *bpf_map_get(u32 ufd);
diff --git a/include/linux/btf.h b/include/linux/btf.h
index 9e62717cdc7a..282006abd062 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -163,7 +163,8 @@ bool btf_member_is_reg_int(const struct btf *btf, const struct btf_type *s,
 			   u32 expected_offset, u32 expected_size);
 int btf_find_spin_lock(const struct btf *btf, const struct btf_type *t);
 int btf_find_timer(const struct btf *btf, const struct btf_type *t);
-struct btf_record *btf_parse_fields(const struct btf *btf, const struct btf_type *t);
+struct btf_record *btf_parse_fields(const struct btf *btf, const struct btf_type *t,
+				    u32 field_mask, u32 value_size);
 bool btf_type_is_void(const struct btf_type *t);
 s32 btf_find_by_name_kind(const struct btf *btf, const char *name, u8 kind);
 const struct btf_type *btf_type_skip_modifiers(const struct btf *btf,
diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
index 417f84342e98..672eb17ac421 100644
--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -306,13 +306,6 @@ static int array_map_get_next_key(struct bpf_map *map, void *key, void *next_key
 	return 0;
 }
 
-static void check_and_free_fields(struct bpf_array *arr, void *val)
-{
-	if (map_value_has_timer(&arr->map))
-		bpf_timer_cancel_and_free(val + arr->map.timer_off);
-	bpf_obj_free_fields(arr->map.record, val);
-}
-
 /* Called from syscall or from eBPF program */
 static int array_map_update_elem(struct bpf_map *map, void *key, void *value,
 				 u64 map_flags)
@@ -334,13 +327,13 @@ static int array_map_update_elem(struct bpf_map *map, void *key, void *value,
 		return -EEXIST;
 
 	if (unlikely((map_flags & BPF_F_LOCK) &&
-		     !map_value_has_spin_lock(map)))
+		     !btf_record_has_field(map->record, BPF_SPIN_LOCK)))
 		return -EINVAL;
 
 	if (array->map.map_type == BPF_MAP_TYPE_PERCPU_ARRAY) {
 		val = this_cpu_ptr(array->pptrs[index & array->index_mask]);
 		copy_map_value(map, val, value);
-		check_and_free_fields(array, val);
+		bpf_obj_free_fields(array->map.record, val);
 	} else {
 		val = array->value +
 			(u64)array->elem_size * (index & array->index_mask);
@@ -348,7 +341,7 @@ static int array_map_update_elem(struct bpf_map *map, void *key, void *value,
 			copy_map_value_locked(map, val, value, false);
 		else
 			copy_map_value(map, val, value);
-		check_and_free_fields(array, val);
+		bpf_obj_free_fields(array->map.record, val);
 	}
 	return 0;
 }
@@ -385,7 +378,7 @@ int bpf_percpu_array_update(struct bpf_map *map, void *key, void *value,
 	pptr = array->pptrs[index & array->index_mask];
 	for_each_possible_cpu(cpu) {
 		copy_map_value_long(map, per_cpu_ptr(pptr, cpu), value + off);
-		check_and_free_fields(array, per_cpu_ptr(pptr, cpu));
+		bpf_obj_free_fields(array->map.record, per_cpu_ptr(pptr, cpu));
 		off += size;
 	}
 	rcu_read_unlock();
@@ -409,11 +402,11 @@ static void array_map_free_timers(struct bpf_map *map)
 	int i;
 
 	/* We don't reset or free fields other than timer on uref dropping to zero. */
-	if (!map_value_has_timer(map))
+	if (!btf_record_has_field(map->record, BPF_TIMER))
 		return;
 
 	for (i = 0; i < array->map.max_entries; i++)
-		bpf_timer_cancel_and_free(array_map_elem_ptr(array, i) + map->timer_off);
+		bpf_obj_free_timer(map->record, array_map_elem_ptr(array, i));
 }
 
 /* Called when map->refcnt goes to zero, either from workqueue or from syscall */
diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
index 93d9b1b17bc8..37020078d1c1 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -382,7 +382,7 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
 	if (unlikely((map_flags & ~BPF_F_LOCK) > BPF_EXIST) ||
 	    /* BPF_F_LOCK can only be used in a value with spin_lock */
 	    unlikely((map_flags & BPF_F_LOCK) &&
-		     !map_value_has_spin_lock(&smap->map)))
+		     !btf_record_has_field(smap->map.record, BPF_SPIN_LOCK)))
 		return ERR_PTR(-EINVAL);
 
 	if (gfp_flags == GFP_KERNEL && (map_flags & ~BPF_F_LOCK) != BPF_NOEXIST)
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 199a2ab70632..33eb6828bd01 100644
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
@@ -3360,78 +3407,98 @@ static int btf_find_datasec_var(const struct btf *btf, const struct btf_type *t,
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
 
-struct btf_record *btf_parse_fields(const struct btf *btf, const struct btf_type *t)
+struct btf_record *btf_parse_fields(const struct btf *btf, const struct btf_type *t,
+				    u32 field_mask, u32 value_size)
 {
 	struct btf_field_info info_arr[BTF_FIELDS_MAX];
-	struct btf *kernel_btf = NULL;
-	struct module *mod = NULL;
 	struct btf_record *rec;
 	int ret, i, cnt;
 
-	ret = btf_find_field(btf, t, BTF_FIELD_KPTR, info_arr, ARRAY_SIZE(info_arr));
+	ret = btf_find_field(btf, t, field_mask, info_arr, ARRAY_SIZE(info_arr));
 	if (ret < 0)
 		return ERR_PTR(ret);
 	if (!ret)
@@ -3441,80 +3508,44 @@ struct btf_record *btf_parse_fields(const struct btf *btf, const struct btf_type
 	rec = kzalloc(offsetof(struct btf_record, fields[cnt]), GFP_KERNEL | __GFP_NOWARN);
 	if (!rec)
 		return ERR_PTR(-ENOMEM);
-	rec->cnt = 0;
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
+	rec->spin_lock_off = -EINVAL;
+	rec->timer_off = -EINVAL;
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
-
-			/* We already verified dtor_func to be btf_type_is_func
-			 * in register_btf_id_dtor_kfuncs.
-			 */
-			dtor_func_name = __btf_name_by_offset(kernel_btf, dtor_func->name_off);
-			addr = kallsyms_lookup_name(dtor_func_name);
-			if (!addr) {
-				ret = -EINVAL;
-				goto end_mod;
-			}
-			rec->fields[i].kptr.dtor = (void *)addr;
-		}
-
+		rec->field_mask |= info_arr[i].type;
 		rec->fields[i].offset = info_arr[i].off;
 		rec->fields[i].type = info_arr[i].type;
-		rec->fields[i].kptr.btf_id = id;
-		rec->fields[i].kptr.btf = kernel_btf;
-		rec->fields[i].kptr.module = mod;
+
+		switch (info_arr[i].type) {
+		case BPF_SPIN_LOCK:
+			WARN_ON_ONCE(rec->spin_lock_off >= 0);
+			/* Cache offset for faster lookup at runtime */
+			rec->spin_lock_off = rec->fields[i].offset;
+			break;
+		case BPF_TIMER:
+			WARN_ON_ONCE(rec->timer_off >= 0);
+			/* Cache offset for faster lookup at runtime */
+			rec->timer_off = rec->fields[i].offset;
+			break;
+		case BPF_KPTR_UNREF:
+		case BPF_KPTR_REF:
+			ret = btf_parse_kptr(btf, &rec->fields[i], &info_arr[i]);
+			if (ret < 0)
+				goto end;
+			break;
+		default:
+			ret = -EFAULT;
+			goto end;
+		}
 		rec->cnt++;
 	}
-	rec->cnt = cnt;
 	return rec;
-end_mod:
-	module_put(mod);
-end_btf:
-	btf_put(kernel_btf);
 end:
 	btf_record_free(rec);
 	return ERR_PTR(ret);
diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 6e4120e98a2c..15e2945f131b 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -222,7 +222,7 @@ static void htab_free_prealloced_timers(struct bpf_htab *htab)
 	u32 num_entries = htab->map.max_entries;
 	int i;
 
-	if (!map_value_has_timer(&htab->map))
+	if (!btf_record_has_field(htab->map.record, BPF_TIMER))
 		return;
 	if (htab_has_extra_elems(htab))
 		num_entries += num_possible_cpus();
@@ -231,9 +231,7 @@ static void htab_free_prealloced_timers(struct bpf_htab *htab)
 		struct htab_elem *elem;
 
 		elem = get_htab_elem(htab, i);
-		bpf_timer_cancel_and_free(elem->key +
-					  round_up(htab->map.key_size, 8) +
-					  htab->map.timer_off);
+		bpf_obj_free_timer(htab->map.record, elem->key + round_up(htab->map.key_size, 8));
 		cond_resched();
 	}
 }
@@ -763,8 +761,6 @@ static void check_and_free_fields(struct bpf_htab *htab,
 {
 	void *map_value = elem->key + round_up(htab->map.key_size, 8);
 
-	if (map_value_has_timer(&htab->map))
-		bpf_timer_cancel_and_free(map_value + htab->map.timer_off);
 	bpf_obj_free_fields(htab->map.record, map_value);
 }
 
@@ -1089,7 +1085,7 @@ static int htab_map_update_elem(struct bpf_map *map, void *key, void *value,
 	head = &b->head;
 
 	if (unlikely(map_flags & BPF_F_LOCK)) {
-		if (unlikely(!map_value_has_spin_lock(map)))
+		if (unlikely(!btf_record_has_field(map->record, BPF_SPIN_LOCK)))
 			return -EINVAL;
 		/* find an element without taking the bucket lock */
 		l_old = lookup_nulls_elem_raw(head, hash, key, key_size,
@@ -1472,12 +1468,8 @@ static void htab_free_malloced_timers(struct bpf_htab *htab)
 		struct htab_elem *l;
 
 		hlist_nulls_for_each_entry(l, n, head, hash_node) {
-			/* We don't reset or free kptr on uref dropping to zero,
-			 * hence just free timer.
-			 */
-			bpf_timer_cancel_and_free(l->key +
-						  round_up(htab->map.key_size, 8) +
-						  htab->map.timer_off);
+			/* We only free timer on uref dropping to zero */
+			bpf_obj_free_timer(htab->map.record, l->key + round_up(htab->map.key_size, 8));
 		}
 		cond_resched_rcu();
 	}
@@ -1488,8 +1480,8 @@ static void htab_map_free_timers(struct bpf_map *map)
 {
 	struct bpf_htab *htab = container_of(map, struct bpf_htab, map);
 
-	/* We don't reset or free kptr on uref dropping to zero. */
-	if (!map_value_has_timer(&htab->map))
+	/* We only free timer on uref dropping to zero */
+	if (!btf_record_has_field(htab->map.record, BPF_TIMER))
 		return;
 	if (!htab_is_prealloc(htab))
 		htab_free_malloced_timers(htab);
@@ -1673,7 +1665,7 @@ __htab_map_lookup_and_delete_batch(struct bpf_map *map,
 
 	elem_map_flags = attr->batch.elem_flags;
 	if ((elem_map_flags & ~BPF_F_LOCK) ||
-	    ((elem_map_flags & BPF_F_LOCK) && !map_value_has_spin_lock(map)))
+	    ((elem_map_flags & BPF_F_LOCK) && !btf_record_has_field(map->record, BPF_SPIN_LOCK)))
 		return -EINVAL;
 
 	map_flags = attr->batch.flags;
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 124fd199ce5c..283f55bbeb70 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -366,9 +366,9 @@ void copy_map_value_locked(struct bpf_map *map, void *dst, void *src,
 	struct bpf_spin_lock *lock;
 
 	if (lock_src)
-		lock = src + map->spin_lock_off;
+		lock = src + map->record->spin_lock_off;
 	else
-		lock = dst + map->spin_lock_off;
+		lock = dst + map->record->spin_lock_off;
 	preempt_disable();
 	__bpf_spin_lock_irqsave(lock);
 	copy_map_value(map, dst, src);
@@ -1169,7 +1169,7 @@ BPF_CALL_3(bpf_timer_init, struct bpf_timer_kern *, timer, struct bpf_map *, map
 		ret = -ENOMEM;
 		goto out;
 	}
-	t->value = (void *)timer - map->timer_off;
+	t->value = (void *)timer - map->record->timer_off;
 	t->map = map;
 	t->prog = NULL;
 	rcu_assign_pointer(t->callback_fn, NULL);
diff --git a/kernel/bpf/local_storage.c b/kernel/bpf/local_storage.c
index 098cf336fae6..e90d9f63edc5 100644
--- a/kernel/bpf/local_storage.c
+++ b/kernel/bpf/local_storage.c
@@ -151,7 +151,7 @@ static int cgroup_storage_update_elem(struct bpf_map *map, void *key,
 		return -EINVAL;
 
 	if (unlikely((flags & BPF_F_LOCK) &&
-		     !map_value_has_spin_lock(map)))
+		     !btf_record_has_field(map->record, BPF_SPIN_LOCK)))
 		return -EINVAL;
 
 	storage = cgroup_storage_lookup((struct bpf_cgroup_storage_map *)map,
diff --git a/kernel/bpf/map_in_map.c b/kernel/bpf/map_in_map.c
index d6c662183f88..8ca0cca39d49 100644
--- a/kernel/bpf/map_in_map.c
+++ b/kernel/bpf/map_in_map.c
@@ -29,7 +29,7 @@ struct bpf_map *bpf_map_meta_alloc(int inner_map_ufd)
 		return ERR_PTR(-ENOTSUPP);
 	}
 
-	if (map_value_has_spin_lock(inner_map)) {
+	if (btf_record_has_field(inner_map->record, BPF_SPIN_LOCK)) {
 		fdput(f);
 		return ERR_PTR(-ENOTSUPP);
 	}
@@ -50,8 +50,6 @@ struct bpf_map *bpf_map_meta_alloc(int inner_map_ufd)
 	inner_map_meta->value_size = inner_map->value_size;
 	inner_map_meta->map_flags = inner_map->map_flags;
 	inner_map_meta->max_entries = inner_map->max_entries;
-	inner_map_meta->spin_lock_off = inner_map->spin_lock_off;
-	inner_map_meta->timer_off = inner_map->timer_off;
 	inner_map_meta->record = btf_record_dup(inner_map->record);
 	if (IS_ERR(inner_map_meta->record)) {
 		/* btf_record_dup returns NULL or valid pointer in case of
@@ -92,7 +90,6 @@ bool bpf_map_meta_equal(const struct bpf_map *meta0,
 	return meta0->map_type == meta1->map_type &&
 		meta0->key_size == meta1->key_size &&
 		meta0->value_size == meta1->value_size &&
-		meta0->timer_off == meta1->timer_off &&
 		meta0->map_flags == meta1->map_flags &&
 		btf_record_equal(meta0->record, meta1->record);
 }
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 2d4bba45fd3c..73822d36aa56 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -527,6 +527,9 @@ void btf_record_free(struct btf_record *rec)
 		return;
 	for (i = 0; i < rec->cnt; i++) {
 		switch (rec->fields[i].type) {
+		case BPF_SPIN_LOCK:
+		case BPF_TIMER:
+			break;
 		case BPF_KPTR_UNREF:
 		case BPF_KPTR_REF:
 			if (rec->fields[i].kptr.module)
@@ -564,6 +567,9 @@ struct btf_record *btf_record_dup(const struct btf_record *rec)
 	new_rec->cnt = 0;
 	for (i = 0; i < rec->cnt; i++) {
 		switch (fields[i].type) {
+		case BPF_SPIN_LOCK:
+		case BPF_TIMER:
+			break;
 		case BPF_KPTR_UNREF:
 		case BPF_KPTR_REF:
 			btf_get(fields[i].kptr.btf);
@@ -600,6 +606,13 @@ bool btf_record_equal(const struct btf_record *rec_a, const struct btf_record *r
 	return !memcmp(rec_a, rec_b, size);
 }
 
+void bpf_obj_free_timer(const struct btf_record *rec, void *obj)
+{
+	if (WARN_ON_ONCE(!btf_record_has_field(rec, BPF_TIMER)))
+		return;
+	bpf_timer_cancel_and_free(obj + rec->timer_off);
+}
+
 void bpf_obj_free_fields(const struct btf_record *rec, void *obj)
 {
 	const struct btf_field *fields;
@@ -613,6 +626,11 @@ void bpf_obj_free_fields(const struct btf_record *rec, void *obj)
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
-	    map_value_has_timer(map) || !IS_ERR_OR_NULL(map->record))
+	if (!map->ops->map_mmap || !IS_ERR_OR_NULL(map->record))
 		return -ENOTSUPP;
 
 	if (!(vma->vm_flags & VM_SHARED))
@@ -954,13 +971,13 @@ static void map_field_offs_swap(void *_a, void *_b, int size, const void *priv)
 
 static int bpf_map_alloc_off_arr(struct bpf_map *map)
 {
-	bool has_spin_lock = map_value_has_spin_lock(map);
-	bool has_timer = map_value_has_timer(map);
 	bool has_fields = !IS_ERR_OR_NULL(map);
 	struct btf_field_offs *fo;
-	u32 i;
+	struct btf_record *rec;
+	u32 i, *off;
+	u8 *sz;
 
-	if (!has_spin_lock && !has_timer && !has_fields) {
+	if (!has_fields) {
 		map->field_offs = NULL;
 		return 0;
 	}
@@ -970,32 +987,14 @@ static int bpf_map_alloc_off_arr(struct bpf_map *map)
 		return -ENOMEM;
 	map->field_offs = fo;
 
-	fo->cnt = 0;
-	if (has_spin_lock) {
-		i = fo->cnt;
-
-		fo->field_off[i] = map->spin_lock_off;
-		fo->field_sz[i] = sizeof(struct bpf_spin_lock);
-		fo->cnt++;
-	}
-	if (has_timer) {
-		i = fo->cnt;
-
-		fo->field_off[i] = map->timer_off;
-		fo->field_sz[i] = sizeof(struct bpf_timer);
-		fo->cnt++;
-	}
-	if (has_fields) {
-		struct btf_record *rec = map->record;
-		u32 *off = &fo->field_off[fo->cnt];
-		u8 *sz = &fo->field_sz[fo->cnt];
-
-		for (i = 0; i < rec->cnt; i++) {
-			*off++ = rec->fields[i].offset;
-			*sz++ = btf_field_type_size(rec->fields[i].type);
-		}
-		fo->cnt += rec->cnt;
+	rec = map->record;
+	off = &fo->field_off[fo->cnt];
+	sz = &fo->field_sz[fo->cnt];
+	for (i = 0; i < rec->cnt; i++) {
+		*off++ = rec->fields[i].offset;
+		*sz++ = btf_field_type_size(rec->fields[i].type);
 	}
+	fo->cnt = rec->cnt;
 
 	if (fo->cnt == 1)
 		return 0;
@@ -1026,39 +1025,8 @@ static int map_check_btf(struct bpf_map *map, const struct btf *btf,
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
-		    map->map_type != BPF_MAP_TYPE_TASK_STORAGE &&
-		    map->map_type != BPF_MAP_TYPE_CGRP_STORAGE)
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
-	map->record = btf_parse_fields(btf, value_type);
+	map->record = btf_parse_fields(btf, value_type, BPF_SPIN_LOCK | BPF_TIMER | BPF_KPTR,
+				       map->value_size);
 	if (!IS_ERR_OR_NULL(map->record)) {
 		int i;
 
@@ -1074,6 +1042,26 @@ static int map_check_btf(struct bpf_map *map, const struct btf *btf,
 			switch (map->record->field_mask & (1 << i)) {
 			case 0:
 				continue;
+			case BPF_SPIN_LOCK:
+				if (map->map_type != BPF_MAP_TYPE_HASH &&
+				    map->map_type != BPF_MAP_TYPE_ARRAY &&
+				    map->map_type != BPF_MAP_TYPE_CGROUP_STORAGE &&
+				    map->map_type != BPF_MAP_TYPE_SK_STORAGE &&
+				    map->map_type != BPF_MAP_TYPE_INODE_STORAGE &&
+				    map->map_type != BPF_MAP_TYPE_TASK_STORAGE &&
+				    map->map_type != BPF_MAP_TYPE_CGRP_STORAGE) {
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
@@ -1153,8 +1141,6 @@ static int map_create(union bpf_attr *attr)
 	mutex_init(&map->freeze_mutex);
 	spin_lock_init(&map->owner.lock);
 
-	map->spin_lock_off = -EINVAL;
-	map->timer_off = -EINVAL;
 	if (attr->btf_key_type_id || attr->btf_value_type_id ||
 	    /* Even the map's value is a kernel's struct,
 	     * the bpf_prog.o must have BTF to begin with
@@ -1368,7 +1354,7 @@ static int map_lookup_elem(union bpf_attr *attr)
 	}
 
 	if ((attr->flags & BPF_F_LOCK) &&
-	    !map_value_has_spin_lock(map)) {
+	    !btf_record_has_field(map->record, BPF_SPIN_LOCK)) {
 		err = -EINVAL;
 		goto err_put;
 	}
@@ -1441,7 +1427,7 @@ static int map_update_elem(union bpf_attr *attr, bpfptr_t uattr)
 	}
 
 	if ((attr->flags & BPF_F_LOCK) &&
-	    !map_value_has_spin_lock(map)) {
+	    !btf_record_has_field(map->record, BPF_SPIN_LOCK)) {
 		err = -EINVAL;
 		goto err_put;
 	}
@@ -1604,7 +1590,7 @@ int generic_map_delete_batch(struct bpf_map *map,
 		return -EINVAL;
 
 	if ((attr->batch.elem_flags & BPF_F_LOCK) &&
-	    !map_value_has_spin_lock(map)) {
+	    !btf_record_has_field(map->record, BPF_SPIN_LOCK)) {
 		return -EINVAL;
 	}
 
@@ -1661,7 +1647,7 @@ int generic_map_update_batch(struct bpf_map *map,
 		return -EINVAL;
 
 	if ((attr->batch.elem_flags & BPF_F_LOCK) &&
-	    !map_value_has_spin_lock(map)) {
+	    !btf_record_has_field(map->record, BPF_SPIN_LOCK)) {
 		return -EINVAL;
 	}
 
@@ -1724,7 +1710,7 @@ int generic_map_lookup_batch(struct bpf_map *map,
 		return -EINVAL;
 
 	if ((attr->batch.elem_flags & BPF_F_LOCK) &&
-	    !map_value_has_spin_lock(map))
+	    !btf_record_has_field(map->record, BPF_SPIN_LOCK))
 		return -EINVAL;
 
 	value_size = bpf_map_value_size(map);
@@ -1846,7 +1832,7 @@ static int map_lookup_and_delete_elem(union bpf_attr *attr)
 	}
 
 	if ((attr->flags & BPF_F_LOCK) &&
-	    !map_value_has_spin_lock(map)) {
+	    !btf_record_has_field(map->record, BPF_SPIN_LOCK)) {
 		err = -EINVAL;
 		goto err_put;
 	}
@@ -1917,8 +1903,7 @@ static int map_freeze(const union bpf_attr *attr)
 	if (IS_ERR(map))
 		return PTR_ERR(map);
 
-	if (map->map_type == BPF_MAP_TYPE_STRUCT_OPS ||
-	    map_value_has_timer(map) || !IS_ERR_OR_NULL(map->record)) {
+	if (map->map_type == BPF_MAP_TYPE_STRUCT_OPS || !IS_ERR_OR_NULL(map->record)) {
 		fdput(f);
 		return -ENOTSUPP;
 	}
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index f233cbfce28c..2962b842b4c7 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -454,7 +454,7 @@ static bool reg_type_not_null(enum bpf_reg_type type)
 static bool reg_may_point_to_spin_lock(const struct bpf_reg_state *reg)
 {
 	return reg->type == PTR_TO_MAP_VALUE &&
-		map_value_has_spin_lock(reg->map_ptr);
+	       btf_record_has_field(reg->map_ptr->record, BPF_SPIN_LOCK);
 }
 
 static bool type_is_rdonly_mem(u32 type)
@@ -1388,7 +1388,7 @@ static void mark_ptr_not_null_reg(struct bpf_reg_state *reg)
 			/* transfer reg's id which is unique for every map_lookup_elem
 			 * as UID of the inner map.
 			 */
-			if (map_value_has_timer(map->inner_map_meta))
+			if (btf_record_has_field(map->inner_map_meta->record, BPF_TIMER))
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
 	if (IS_ERR_OR_NULL(map->record))
 		return 0;
 	rec = map->record;
@@ -3847,6 +3824,10 @@ static int check_map_access(struct bpf_verifier_env *env, u32 regno,
 		struct btf_field *field = &rec->fields[i];
 		u32 p = field->offset;
 
+		/* If any part of a field  can be touched by load/store, reject
+		 * this program. To check that [x1, x2) overlaps with [y1, y2),
+		 * it is sufficient to check x1 < y2 && y1 < x2.
+		 */
 		if (reg->smin_value + off < p + btf_field_type_size(field->type) &&
 		    p < reg->umax_value + off + size) {
 			switch (field->type) {
@@ -3871,7 +3852,8 @@ static int check_map_access(struct bpf_verifier_env *env, u32 regno,
 				}
 				break;
 			default:
-				verbose(env, "field cannot be accessed directly by load/store\n");
+				verbose(env, "%s cannot be accessed directly by load/store\n",
+					btf_field_type_name(field->type));
 				return -EACCES;
 			}
 		}
@@ -5440,24 +5422,13 @@ static int process_spin_lock(struct bpf_verifier_env *env, int regno,
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
+	if (!btf_record_has_field(map->record, BPF_SPIN_LOCK)) {
+		verbose(env, "map '%s' has no valid bpf_spin_lock\n", map->name);
 		return -EINVAL;
 	}
-	if (map->spin_lock_off != val + reg->off) {
-		verbose(env, "off %lld doesn't point to 'struct bpf_spin_lock'\n",
-			val + reg->off);
+	if (map->record->spin_lock_off != val + reg->off) {
+		verbose(env, "off %lld doesn't point to 'struct bpf_spin_lock' that is at %d\n",
+			val + reg->off, map->record->spin_lock_off);
 		return -EINVAL;
 	}
 	if (is_lock) {
@@ -5500,24 +5471,13 @@ static int process_timer_func(struct bpf_verifier_env *env, int regno,
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
+	if (!btf_record_has_field(map->record, BPF_TIMER)) {
+		verbose(env, "map '%s' has no valid bpf_timer\n", map->name);
 		return -EINVAL;
 	}
-	if (map->timer_off != val + reg->off) {
+	if (map->record->timer_off != val + reg->off) {
 		verbose(env, "off %lld doesn't point to 'struct bpf_timer' that is at %d\n",
-			val + reg->off, map->timer_off);
+			val + reg->off, map->record->timer_off);
 		return -EINVAL;
 	}
 	if (meta->map_ptr) {
@@ -7469,7 +7429,7 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 		regs[BPF_REG_0].map_uid = meta.map_uid;
 		regs[BPF_REG_0].type = PTR_TO_MAP_VALUE | ret_flag;
 		if (!type_may_be_null(ret_type) &&
-		    map_value_has_spin_lock(meta.map_ptr)) {
+		    btf_record_has_field(meta.map_ptr->record, BPF_SPIN_LOCK)) {
 			regs[BPF_REG_0].id = ++env->id_gen;
 		}
 		break;
@@ -10380,7 +10340,7 @@ static int check_ld_imm(struct bpf_verifier_env *env, struct bpf_insn *insn)
 	    insn->src_reg == BPF_PSEUDO_MAP_IDX_VALUE) {
 		dst_reg->type = PTR_TO_MAP_VALUE;
 		dst_reg->off = aux->map_off;
-		if (map_value_has_spin_lock(map))
+		if (btf_record_has_field(map->record, BPF_SPIN_LOCK))
 			dst_reg->id = ++env->id_gen;
 	} else if (insn->src_reg == BPF_PSEUDO_MAP_FD ||
 		   insn->src_reg == BPF_PSEUDO_MAP_IDX) {
@@ -12658,7 +12618,7 @@ static int check_map_prog_compatibility(struct bpf_verifier_env *env,
 {
 	enum bpf_prog_type prog_type = resolve_prog_type(prog);
 
-	if (map_value_has_spin_lock(map)) {
+	if (btf_record_has_field(map->record, BPF_SPIN_LOCK)) {
 		if (prog_type == BPF_PROG_TYPE_SOCKET_FILTER) {
 			verbose(env, "socket filter progs cannot use bpf_spin_lock yet\n");
 			return -EINVAL;
@@ -12675,7 +12635,7 @@ static int check_map_prog_compatibility(struct bpf_verifier_env *env,
 		}
 	}
 
-	if (map_value_has_timer(map)) {
+	if (btf_record_has_field(map->record, BPF_TIMER)) {
 		if (is_tracing_prog_type(prog_type)) {
 			verbose(env, "tracing progs cannot use bpf_timer yet\n");
 			return -EINVAL;
diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
index 49884e7de080..9d2288c0736e 100644
--- a/net/core/bpf_sk_storage.c
+++ b/net/core/bpf_sk_storage.c
@@ -147,7 +147,7 @@ bpf_sk_storage_clone_elem(struct sock *newsk,
 	if (!copy_selem)
 		return NULL;
 
-	if (map_value_has_spin_lock(&smap->map))
+	if (btf_record_has_field(smap->map.record, BPF_SPIN_LOCK))
 		copy_map_value_locked(&smap->map, SDATA(copy_selem)->data,
 				      SDATA(selem)->data, true);
 	else
@@ -566,7 +566,7 @@ static int diag_get(struct bpf_local_storage_data *sdata, struct sk_buff *skb)
 	if (!nla_value)
 		goto errout;
 
-	if (map_value_has_spin_lock(&smap->map))
+	if (btf_record_has_field(smap->map.record, BPF_SPIN_LOCK))
 		copy_map_value_locked(&smap->map, nla_data(nla_value),
 				      sdata->data, true);
 	else
-- 
2.38.1

