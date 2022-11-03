Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C3A0618846
	for <lists+bpf@lfdr.de>; Thu,  3 Nov 2022 20:11:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231346AbiKCTLA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Nov 2022 15:11:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231339AbiKCTK4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Nov 2022 15:10:56 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD95A12AB2
        for <bpf@vger.kernel.org>; Thu,  3 Nov 2022 12:10:53 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id d20so1775435plr.10
        for <bpf@vger.kernel.org>; Thu, 03 Nov 2022 12:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tuYYvc6guubijDmnNFKIDNpP8deWTNRZguSXvClpPEs=;
        b=Bdq9UMhnBT4BuxzhNBQLJBojncJ9rDl3aHGWjx/bHruYpepuoEbVLuqqZFbC9sk0KK
         P6Ezip+N4Fz++Q4cRlnrPvf+AC1tEBdDQQcYGff4uOV9uXRnfIweNke5mWeD23J/DhPz
         D8FaeL9QE5j5k+dENQdjG9eKBDE4DGb6IE5dNqDIf2jUKrC7t1YnEmVuSz47LRbYzxQq
         nfVmglaw+O4hYCI8n++9d2/TCvHuMgJ59r7fMnada3NKv2hmOZmi75l8jzrF/9UOhRMu
         QDm6V2XzL2aWU7jVPKU+6i4FDs+HDUF0q2eUmctHTa32rELInm+f45Yld9ubXDnSyfna
         u93g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tuYYvc6guubijDmnNFKIDNpP8deWTNRZguSXvClpPEs=;
        b=0y7RWTIe39V2hIvZGCKQhjX9ZJhY+JZdaWtYWycVImosiI8/LlQGJX6NruZ4fWDPB0
         nztFvR66k6WqciVj249V0y4ni7z8EnMpnzLzJ1BLimTePQlt97Ojif0RGeZKcey7Jnlf
         g8u7W3/6lVnidO1sVkcHkBBPFqhVx7UD1iZ2MU0Hfpery/yepuZsVeX8Xtw1ewuIhEze
         kH7IIwMRVGKaSR6ERyaku7k372s2Sj0oEFJLurvzxn9WHEgBcL8p3+uzVvuDIgTgX9EU
         FlTtOL3MKt2kmcpxKPKuRFtsb9+KhkwPGM1lNiOrG25bsTPcIQ4vjDYh41TwdI+aVYNn
         r1fQ==
X-Gm-Message-State: ACrzQf1l8pD2V1r6KUi49p5acjLb01NkHklcCwGsNlEuW57pop98s7bq
        yavsx6CsFHI6zSQWHI1JPEZ3CFIYfVuU1w==
X-Google-Smtp-Source: AMsMyM7I6guawEZe+gE/p9AivFWNveC1s9Z6v7zAitPqPMwIU816lhUYJpmVWokDjVg0TZYinfJFyw==
X-Received: by 2002:a17:90b:1e0d:b0:213:ae0:fcf8 with SMTP id pg13-20020a17090b1e0d00b002130ae0fcf8mr32737054pjb.189.1667502652555;
        Thu, 03 Nov 2022 12:10:52 -0700 (PDT)
Received: from localhost ([103.4.222.252])
        by smtp.gmail.com with ESMTPSA id ij17-20020a170902ab5100b00178143a728esm944718plb.275.2022.11.03.12.10.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 12:10:52 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>,
        Delyan Kratunov <delyank@meta.com>
Subject: [PATCH bpf-next v4 06/24] bpf: Refactor kptr_off_tab into btf_record
Date:   Fri,  4 Nov 2022 00:39:55 +0530
Message-Id: <20221103191013.1236066-7-memxor@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221103191013.1236066-1-memxor@gmail.com>
References: <20221103191013.1236066-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=42929; i=memxor@gmail.com; h=from:subject; bh=MzKQ02qRWnHxDonXlK8KDTfOAceWpGCis5i5rwQXr7Q=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjZBIA4gANf0tQ0Qyd0h7lQlVGApWu7p3aN6xkO+Vq zGXIT1+JAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY2QSAAAKCRBM4MiGSL8RykVMD/ 9bYij0Lukgq/mxfRsZHmvhg8L67t/BQ3bit5jzOiqorD0+/pomwtWABQts6MjIUq5qVKQenxvBW95y jxLvYt7SKmw+ot5yIpE2Fhr6ofUQl1F4vx711XoLEi6QOPFFp2bhy9G/vk7x8TjbbQ72ajAFFTX7SK 47y4gNjvbUf2EIqfXKYmpqSAbBdwba/kU3y70JGwponugdnaZyc/jIxnfOlHqi/1JPy6G97KI7KY6G QqfO3kgZzfGB4f+7qRFQiDzNVYInLnE7FzQE3kn5c4E35Z2n0DFQlI6NTmnsx7LcqPVPPW9CKTmPun A9Z2V0riGXs3oWpINb6rI+Amlo+mw2HyUxtFgzar6mbeoJ/dPp61lEwDVHGbP89Yrx/qxbNs0vcvaP OwtBToj8k8tqLaajzK/oBbovH18C2EHo29GS6kL5RBEsMmnYLz7BpivMjtuL29IhzQ4wWfQBDf4P+/ lWJDgrlkMBj/zPfKfBXlEVAiwPq/vQJileLMwh0WnXAgD01lXlNGtzfXrOYaoDvGmEnORQKF57V1K5 H0gPSQTlUpnxMK8HCMH3QAFdpJRc7aqL5MN+gn3Go7OiqNQA1yFJlpaDrWWVVF3+y0dBvBNJXc66XV /QO4l57U5msOT4Ll5c7cxgLeHuSRNR6QWe30qr+J6JhJy76EpSgwqzKDgswg==
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

To prepare the BPF verifier to handle special fields in both map values
and program allocated types coming from program BTF, we need to refactor
the kptr_off_tab handling code into something more generic and reusable
across both cases to avoid code duplication.

Later patches also require passing this data to helpers at runtime, so
that they can work on user defined types, initialize them, destruct
them, etc.

The main observation is that both map values and such allocated types
point to a type in program BTF, hence they can be handled similarly. We
can prepare a field metadata table for both cases and store them in
struct bpf_map or struct btf depending on the use case.

Hence, refactor the code into generic btf_record and btf_field member
structs. The btf_record represents the fields of a specific btf_type in
user BTF. The cnt indicates the number of special fields we successfully
recognized, and field_mask is a bitmask of fields that were found, to
enable quick determination of availability of a certain field.

Subsequently, refactor the rest of the code to work with these generic
types, remove assumptions about kptr and kptr_off_tab, rename variables
to more meaningful names, etc.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf.h     | 125 ++++++++++++-------
 include/linux/btf.h     |   3 +-
 kernel/bpf/arraymap.c   |  13 +-
 kernel/bpf/btf.c        |  67 +++++-----
 kernel/bpf/hashtab.c    |  14 +--
 kernel/bpf/map_in_map.c |  14 ++-
 kernel/bpf/syscall.c    | 263 +++++++++++++++++++++++-----------------
 kernel/bpf/verifier.c   |  96 +++++++--------
 8 files changed, 332 insertions(+), 263 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 8d948bfcb984..1440e7c3c510 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -165,35 +165,41 @@ struct bpf_map_ops {
 };
 
 enum {
-	/* Support at most 8 pointers in a BPF map value */
-	BPF_MAP_VALUE_OFF_MAX = 8,
-	BPF_MAP_OFF_ARR_MAX   = BPF_MAP_VALUE_OFF_MAX +
+	/* Support at most 8 pointers in a BTF type */
+	BTF_FIELDS_MAX	      = 8,
+	BPF_MAP_OFF_ARR_MAX   = BTF_FIELDS_MAX +
 				1 + /* for bpf_spin_lock */
 				1,  /* for bpf_timer */
 };
 
-enum bpf_kptr_type {
-	BPF_KPTR_UNREF,
-	BPF_KPTR_REF,
+enum btf_field_type {
+	BPF_KPTR_UNREF = (1 << 2),
+	BPF_KPTR_REF   = (1 << 3),
+	BPF_KPTR       = BPF_KPTR_UNREF | BPF_KPTR_REF,
 };
 
-struct bpf_map_value_off_desc {
+struct btf_field_kptr {
+	struct btf *btf;
+	struct module *module;
+	btf_dtor_kfunc_t dtor;
+	u32 btf_id;
+};
+
+struct btf_field {
 	u32 offset;
-	enum bpf_kptr_type type;
-	struct {
-		struct btf *btf;
-		struct module *module;
-		btf_dtor_kfunc_t dtor;
-		u32 btf_id;
-	} kptr;
+	enum btf_field_type type;
+	union {
+		struct btf_field_kptr kptr;
+	};
 };
 
-struct bpf_map_value_off {
-	u32 nr_off;
-	struct bpf_map_value_off_desc off[];
+struct btf_record {
+	u32 cnt;
+	u32 field_mask;
+	struct btf_field fields[];
 };
 
-struct bpf_map_off_arr {
+struct btf_field_offs {
 	u32 cnt;
 	u32 field_off[BPF_MAP_OFF_ARR_MAX];
 	u8 field_sz[BPF_MAP_OFF_ARR_MAX];
@@ -215,7 +221,7 @@ struct bpf_map {
 	u64 map_extra; /* any per-map-type extra fields */
 	u32 map_flags;
 	int spin_lock_off; /* >=0 valid offset, <0 error */
-	struct bpf_map_value_off *kptr_off_tab;
+	struct btf_record *record;
 	int timer_off; /* >=0 valid offset, <0 error */
 	u32 id;
 	int numa_node;
@@ -227,7 +233,7 @@ struct bpf_map {
 	struct obj_cgroup *objcg;
 #endif
 	char name[BPF_OBJ_NAME_LEN];
-	struct bpf_map_off_arr *off_arr;
+	struct btf_field_offs *field_offs;
 	/* The 3rd and 4th cacheline with misc members to avoid false sharing
 	 * particularly with refcounting.
 	 */
@@ -251,6 +257,37 @@ struct bpf_map {
 	bool frozen; /* write-once; write-protected by freeze_mutex */
 };
 
+static inline u32 btf_field_type_size(enum btf_field_type type)
+{
+	switch (type) {
+	case BPF_KPTR_UNREF:
+	case BPF_KPTR_REF:
+		return sizeof(u64);
+	default:
+		WARN_ON_ONCE(1);
+		return 0;
+	}
+}
+
+static inline u32 btf_field_type_align(enum btf_field_type type)
+{
+	switch (type) {
+	case BPF_KPTR_UNREF:
+	case BPF_KPTR_REF:
+		return __alignof__(u64);
+	default:
+		WARN_ON_ONCE(1);
+		return 0;
+	}
+}
+
+static inline bool btf_record_has_field(const struct btf_record *rec, enum btf_field_type type)
+{
+	if (IS_ERR_OR_NULL(rec))
+		return false;
+	return rec->field_mask & type;
+}
+
 static inline bool map_value_has_spin_lock(const struct bpf_map *map)
 {
 	return map->spin_lock_off >= 0;
@@ -261,23 +298,19 @@ static inline bool map_value_has_timer(const struct bpf_map *map)
 	return map->timer_off >= 0;
 }
 
-static inline bool map_value_has_kptrs(const struct bpf_map *map)
-{
-	return !IS_ERR_OR_NULL(map->kptr_off_tab);
-}
-
 static inline void check_and_init_map_value(struct bpf_map *map, void *dst)
 {
 	if (unlikely(map_value_has_spin_lock(map)))
 		memset(dst + map->spin_lock_off, 0, sizeof(struct bpf_spin_lock));
 	if (unlikely(map_value_has_timer(map)))
 		memset(dst + map->timer_off, 0, sizeof(struct bpf_timer));
-	if (unlikely(map_value_has_kptrs(map))) {
-		struct bpf_map_value_off *tab = map->kptr_off_tab;
+	if (!IS_ERR_OR_NULL(map->record)) {
+		struct btf_field *fields = map->record->fields;
+		u32 cnt = map->record->cnt;
 		int i;
 
-		for (i = 0; i < tab->nr_off; i++)
-			*(u64 *)(dst + tab->off[i].offset) = 0;
+		for (i = 0; i < cnt; i++)
+			memset(dst + fields[i].offset, 0, btf_field_type_size(fields[i].type));
 	}
 }
 
@@ -303,7 +336,7 @@ static inline void __copy_map_value(struct bpf_map *map, void *dst, void *src, b
 	u32 curr_off = 0;
 	int i;
 
-	if (likely(!map->off_arr)) {
+	if (likely(!map->field_offs)) {
 		if (long_memcpy)
 			bpf_long_memcpy(dst, src, round_up(map->value_size, 8));
 		else
@@ -311,11 +344,12 @@ static inline void __copy_map_value(struct bpf_map *map, void *dst, void *src, b
 		return;
 	}
 
-	for (i = 0; i < map->off_arr->cnt; i++) {
-		u32 next_off = map->off_arr->field_off[i];
+	for (i = 0; i < map->field_offs->cnt; i++) {
+		u32 next_off = map->field_offs->field_off[i];
+		u32 sz = next_off - curr_off;
 
-		memcpy(dst + curr_off, src + curr_off, next_off - curr_off);
-		curr_off += map->off_arr->field_sz[i];
+		memcpy(dst + curr_off, src + curr_off, sz);
+		curr_off += map->field_offs->field_sz[i] + sz;
 	}
 	memcpy(dst + curr_off, src + curr_off, map->value_size - curr_off);
 }
@@ -335,16 +369,17 @@ static inline void zero_map_value(struct bpf_map *map, void *dst)
 	u32 curr_off = 0;
 	int i;
 
-	if (likely(!map->off_arr)) {
+	if (likely(!map->field_offs)) {
 		memset(dst, 0, map->value_size);
 		return;
 	}
 
-	for (i = 0; i < map->off_arr->cnt; i++) {
-		u32 next_off = map->off_arr->field_off[i];
+	for (i = 0; i < map->field_offs->cnt; i++) {
+		u32 next_off = map->field_offs->field_off[i];
+		u32 sz = next_off - curr_off;
 
-		memset(dst + curr_off, 0, next_off - curr_off);
-		curr_off += map->off_arr->field_sz[i];
+		memset(dst + curr_off, 0, sz);
+		curr_off += map->field_offs->field_sz[i] + sz;
 	}
 	memset(dst + curr_off, 0, map->value_size - curr_off);
 }
@@ -1699,11 +1734,13 @@ void bpf_prog_put(struct bpf_prog *prog);
 void bpf_prog_free_id(struct bpf_prog *prog, bool do_idr_lock);
 void bpf_map_free_id(struct bpf_map *map, bool do_idr_lock);
 
-struct bpf_map_value_off_desc *bpf_map_kptr_off_contains(struct bpf_map *map, u32 offset);
-void bpf_map_free_kptr_off_tab(struct bpf_map *map);
-struct bpf_map_value_off *bpf_map_copy_kptr_off_tab(const struct bpf_map *map);
-bool bpf_map_equal_kptr_off_tab(const struct bpf_map *map_a, const struct bpf_map *map_b);
-void bpf_map_free_kptrs(struct bpf_map *map, void *map_value);
+struct btf_field *btf_record_find(const struct btf_record *rec,
+				  u32 offset, enum btf_field_type type);
+void btf_record_free(struct btf_record *rec);
+void bpf_map_free_record(struct bpf_map *map);
+struct btf_record *btf_record_dup(const struct btf_record *rec);
+bool btf_record_equal(const struct btf_record *rec_a, const struct btf_record *rec_b);
+void bpf_obj_free_fields(const struct btf_record *rec, void *obj);
 
 struct bpf_map *bpf_map_get(u32 ufd);
 struct bpf_map *bpf_map_get_with_uref(u32 ufd);
diff --git a/include/linux/btf.h b/include/linux/btf.h
index 86aad9b2ce02..9e62717cdc7a 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -163,8 +163,7 @@ bool btf_member_is_reg_int(const struct btf *btf, const struct btf_type *s,
 			   u32 expected_offset, u32 expected_size);
 int btf_find_spin_lock(const struct btf *btf, const struct btf_type *t);
 int btf_find_timer(const struct btf *btf, const struct btf_type *t);
-struct bpf_map_value_off *btf_parse_kptrs(const struct btf *btf,
-					  const struct btf_type *t);
+struct btf_record *btf_parse_fields(const struct btf *btf, const struct btf_type *t);
 bool btf_type_is_void(const struct btf_type *t);
 s32 btf_find_by_name_kind(const struct btf *btf, const char *name, u8 kind);
 const struct btf_type *btf_type_skip_modifiers(const struct btf *btf,
diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
index 832b2659e96e..417f84342e98 100644
--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -310,8 +310,7 @@ static void check_and_free_fields(struct bpf_array *arr, void *val)
 {
 	if (map_value_has_timer(&arr->map))
 		bpf_timer_cancel_and_free(val + arr->map.timer_off);
-	if (map_value_has_kptrs(&arr->map))
-		bpf_map_free_kptrs(&arr->map, val);
+	bpf_obj_free_fields(arr->map.record, val);
 }
 
 /* Called from syscall or from eBPF program */
@@ -409,7 +408,7 @@ static void array_map_free_timers(struct bpf_map *map)
 	struct bpf_array *array = container_of(map, struct bpf_array, map);
 	int i;
 
-	/* We don't reset or free kptr on uref dropping to zero. */
+	/* We don't reset or free fields other than timer on uref dropping to zero. */
 	if (!map_value_has_timer(map))
 		return;
 
@@ -423,22 +422,22 @@ static void array_map_free(struct bpf_map *map)
 	struct bpf_array *array = container_of(map, struct bpf_array, map);
 	int i;
 
-	if (map_value_has_kptrs(map)) {
+	if (!IS_ERR_OR_NULL(map->record)) {
 		if (array->map.map_type == BPF_MAP_TYPE_PERCPU_ARRAY) {
 			for (i = 0; i < array->map.max_entries; i++) {
 				void __percpu *pptr = array->pptrs[i & array->index_mask];
 				int cpu;
 
 				for_each_possible_cpu(cpu) {
-					bpf_map_free_kptrs(map, per_cpu_ptr(pptr, cpu));
+					bpf_obj_free_fields(map->record, per_cpu_ptr(pptr, cpu));
 					cond_resched();
 				}
 			}
 		} else {
 			for (i = 0; i < array->map.max_entries; i++)
-				bpf_map_free_kptrs(map, array_map_elem_ptr(array, i));
+				bpf_obj_free_fields(map->record, array_map_elem_ptr(array, i));
 		}
-		bpf_map_free_kptr_off_tab(map);
+		bpf_map_free_record(map);
 	}
 
 	if (array->map.map_type == BPF_MAP_TYPE_PERCPU_ARRAY)
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index f4d21eef6ebd..ffd687c7420d 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -3191,7 +3191,7 @@ static void btf_struct_log(struct btf_verifier_env *env,
 	btf_verifier_log(env, "size=%u vlen=%u", t->size, btf_type_vlen(t));
 }
 
-enum btf_field_type {
+enum btf_field_info_type {
 	BTF_FIELD_SPIN_LOCK,
 	BTF_FIELD_TIMER,
 	BTF_FIELD_KPTR,
@@ -3203,9 +3203,9 @@ enum {
 };
 
 struct btf_field_info {
-	u32 type_id;
+	enum btf_field_type type;
 	u32 off;
-	enum bpf_kptr_type type;
+	u32 type_id;
 };
 
 static int btf_find_struct(const struct btf *btf, const struct btf_type *t,
@@ -3222,7 +3222,7 @@ static int btf_find_struct(const struct btf *btf, const struct btf_type *t,
 static int btf_find_kptr(const struct btf *btf, const struct btf_type *t,
 			 u32 off, int sz, struct btf_field_info *info)
 {
-	enum bpf_kptr_type type;
+	enum btf_field_type type;
 	u32 res_id;
 
 	/* Permit modifiers on the pointer itself */
@@ -3259,7 +3259,7 @@ static int btf_find_kptr(const struct btf *btf, const struct btf_type *t,
 
 static int btf_find_struct_field(const struct btf *btf, const struct btf_type *t,
 				 const char *name, int sz, int align,
-				 enum btf_field_type field_type,
+				 enum btf_field_info_type field_type,
 				 struct btf_field_info *info, int info_cnt)
 {
 	const struct btf_member *member;
@@ -3311,7 +3311,7 @@ static int btf_find_struct_field(const struct btf *btf, const struct btf_type *t
 
 static int btf_find_datasec_var(const struct btf *btf, const struct btf_type *t,
 				const char *name, int sz, int align,
-				enum btf_field_type field_type,
+				enum btf_field_info_type field_type,
 				struct btf_field_info *info, int info_cnt)
 {
 	const struct btf_var_secinfo *vsi;
@@ -3360,7 +3360,7 @@ static int btf_find_datasec_var(const struct btf *btf, const struct btf_type *t,
 }
 
 static int btf_find_field(const struct btf *btf, const struct btf_type *t,
-			  enum btf_field_type field_type,
+			  enum btf_field_info_type field_type,
 			  struct btf_field_info *info, int info_cnt)
 {
 	const char *name;
@@ -3423,14 +3423,13 @@ int btf_find_timer(const struct btf *btf, const struct btf_type *t)
 	return info.off;
 }
 
-struct bpf_map_value_off *btf_parse_kptrs(const struct btf *btf,
-					  const struct btf_type *t)
+struct btf_record *btf_parse_fields(const struct btf *btf, const struct btf_type *t)
 {
-	struct btf_field_info info_arr[BPF_MAP_VALUE_OFF_MAX];
-	struct bpf_map_value_off *tab;
+	struct btf_field_info info_arr[BTF_FIELDS_MAX];
 	struct btf *kernel_btf = NULL;
 	struct module *mod = NULL;
-	int ret, i, nr_off;
+	struct btf_record *rec;
+	int ret, i, cnt;
 
 	ret = btf_find_field(btf, t, BTF_FIELD_KPTR, info_arr, ARRAY_SIZE(info_arr));
 	if (ret < 0)
@@ -3438,12 +3437,12 @@ struct bpf_map_value_off *btf_parse_kptrs(const struct btf *btf,
 	if (!ret)
 		return NULL;
 
-	nr_off = ret;
-	tab = kzalloc(offsetof(struct bpf_map_value_off, off[nr_off]), GFP_KERNEL | __GFP_NOWARN);
-	if (!tab)
+	cnt = ret;
+	rec = kzalloc(offsetof(struct btf_record, fields[cnt]), GFP_KERNEL | __GFP_NOWARN);
+	if (!rec)
 		return ERR_PTR(-ENOMEM);
-
-	for (i = 0; i < nr_off; i++) {
+	rec->cnt = 0;
+	for (i = 0; i < cnt; i++) {
 		const struct btf_type *t;
 		s32 id;
 
@@ -3500,28 +3499,24 @@ struct bpf_map_value_off *btf_parse_kptrs(const struct btf *btf,
 				ret = -EINVAL;
 				goto end_mod;
 			}
-			tab->off[i].kptr.dtor = (void *)addr;
+			rec->fields[i].kptr.dtor = (void *)addr;
 		}
 
-		tab->off[i].offset = info_arr[i].off;
-		tab->off[i].type = info_arr[i].type;
-		tab->off[i].kptr.btf_id = id;
-		tab->off[i].kptr.btf = kernel_btf;
-		tab->off[i].kptr.module = mod;
+		rec->fields[i].offset = info_arr[i].off;
+		rec->fields[i].type = info_arr[i].type;
+		rec->fields[i].kptr.btf_id = id;
+		rec->fields[i].kptr.btf = kernel_btf;
+		rec->fields[i].kptr.module = mod;
+		rec->cnt++;
 	}
-	tab->nr_off = nr_off;
-	return tab;
+	rec->cnt = cnt;
+	return rec;
 end_mod:
 	module_put(mod);
 end_btf:
 	btf_put(kernel_btf);
 end:
-	while (i--) {
-		btf_put(tab->off[i].kptr.btf);
-		if (tab->off[i].kptr.module)
-			module_put(tab->off[i].kptr.module);
-	}
-	kfree(tab);
+	btf_record_free(rec);
 	return ERR_PTR(ret);
 }
 
@@ -6370,7 +6365,7 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
 
 		/* kptr_get is only true for kfunc */
 		if (i == 0 && kptr_get) {
-			struct bpf_map_value_off_desc *off_desc;
+			struct btf_field *kptr_field;
 
 			if (reg->type != PTR_TO_MAP_VALUE) {
 				bpf_log(log, "arg#0 expected pointer to map value\n");
@@ -6386,8 +6381,8 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
 				return -EINVAL;
 			}
 
-			off_desc = bpf_map_kptr_off_contains(reg->map_ptr, reg->off + reg->var_off.value);
-			if (!off_desc || off_desc->type != BPF_KPTR_REF) {
+			kptr_field = btf_record_find(reg->map_ptr->record, reg->off + reg->var_off.value, BPF_KPTR);
+			if (!kptr_field || kptr_field->type != BPF_KPTR_REF) {
 				bpf_log(log, "arg#0 no referenced kptr at map value offset=%llu\n",
 					reg->off + reg->var_off.value);
 				return -EINVAL;
@@ -6406,8 +6401,8 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
 					func_name, i, btf_type_str(ref_t), ref_tname);
 				return -EINVAL;
 			}
-			if (!btf_struct_ids_match(log, btf, ref_id, 0, off_desc->kptr.btf,
-						  off_desc->kptr.btf_id, true)) {
+			if (!btf_struct_ids_match(log, btf, ref_id, 0, kptr_field->kptr.btf,
+						  kptr_field->kptr.btf_id, true)) {
 				bpf_log(log, "kernel function %s args#%d expected pointer to %s %s\n",
 					func_name, i, btf_type_str(ref_t), ref_tname);
 				return -EINVAL;
diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index f39ee3e05589..c5ea8f9bb7a9 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -238,21 +238,20 @@ static void htab_free_prealloced_timers(struct bpf_htab *htab)
 	}
 }
 
-static void htab_free_prealloced_kptrs(struct bpf_htab *htab)
+static void htab_free_prealloced_fields(struct bpf_htab *htab)
 {
 	u32 num_entries = htab->map.max_entries;
 	int i;
 
-	if (!map_value_has_kptrs(&htab->map))
+	if (IS_ERR_OR_NULL(htab->map.record))
 		return;
 	if (htab_has_extra_elems(htab))
 		num_entries += num_possible_cpus();
-
 	for (i = 0; i < num_entries; i++) {
 		struct htab_elem *elem;
 
 		elem = get_htab_elem(htab, i);
-		bpf_map_free_kptrs(&htab->map, elem->key + round_up(htab->map.key_size, 8));
+		bpf_obj_free_fields(htab->map.record, elem->key + round_up(htab->map.key_size, 8));
 		cond_resched();
 	}
 }
@@ -766,8 +765,7 @@ static void check_and_free_fields(struct bpf_htab *htab,
 
 	if (map_value_has_timer(&htab->map))
 		bpf_timer_cancel_and_free(map_value + htab->map.timer_off);
-	if (map_value_has_kptrs(&htab->map))
-		bpf_map_free_kptrs(&htab->map, map_value);
+	bpf_obj_free_fields(htab->map.record, map_value);
 }
 
 /* It is called from the bpf_lru_list when the LRU needs to delete
@@ -1517,11 +1515,11 @@ static void htab_map_free(struct bpf_map *map)
 	if (!htab_is_prealloc(htab)) {
 		delete_all_elements(htab);
 	} else {
-		htab_free_prealloced_kptrs(htab);
+		htab_free_prealloced_fields(htab);
 		prealloc_destroy(htab);
 	}
 
-	bpf_map_free_kptr_off_tab(map);
+	bpf_map_free_record(map);
 	free_percpu(htab->extra_elems);
 	bpf_map_area_free(htab->buckets);
 	bpf_mem_alloc_destroy(&htab->pcpu_ma);
diff --git a/kernel/bpf/map_in_map.c b/kernel/bpf/map_in_map.c
index 135205d0d560..d6c662183f88 100644
--- a/kernel/bpf/map_in_map.c
+++ b/kernel/bpf/map_in_map.c
@@ -52,7 +52,15 @@ struct bpf_map *bpf_map_meta_alloc(int inner_map_ufd)
 	inner_map_meta->max_entries = inner_map->max_entries;
 	inner_map_meta->spin_lock_off = inner_map->spin_lock_off;
 	inner_map_meta->timer_off = inner_map->timer_off;
-	inner_map_meta->kptr_off_tab = bpf_map_copy_kptr_off_tab(inner_map);
+	inner_map_meta->record = btf_record_dup(inner_map->record);
+	if (IS_ERR(inner_map_meta->record)) {
+		/* btf_record_dup returns NULL or valid pointer in case of
+		 * invalid/empty/valid, but ERR_PTR in case of errors. During
+		 * equality NULL or IS_ERR is equivalent.
+		 */
+		fdput(f);
+		return ERR_CAST(inner_map_meta->record);
+	}
 	if (inner_map->btf) {
 		btf_get(inner_map->btf);
 		inner_map_meta->btf = inner_map->btf;
@@ -72,7 +80,7 @@ struct bpf_map *bpf_map_meta_alloc(int inner_map_ufd)
 
 void bpf_map_meta_free(struct bpf_map *map_meta)
 {
-	bpf_map_free_kptr_off_tab(map_meta);
+	bpf_map_free_record(map_meta);
 	btf_put(map_meta->btf);
 	kfree(map_meta);
 }
@@ -86,7 +94,7 @@ bool bpf_map_meta_equal(const struct bpf_map *meta0,
 		meta0->value_size == meta1->value_size &&
 		meta0->timer_off == meta1->timer_off &&
 		meta0->map_flags == meta1->map_flags &&
-		bpf_map_equal_kptr_off_tab(meta0, meta1);
+		btf_record_equal(meta0->record, meta1->record);
 }
 
 void *bpf_map_fd_get_ptr(struct bpf_map *map,
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 5887592eeb93..2d4bba45fd3c 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -495,114 +495,134 @@ static void bpf_map_release_memcg(struct bpf_map *map)
 }
 #endif
 
-static int bpf_map_kptr_off_cmp(const void *a, const void *b)
+static int btf_field_cmp(const void *a, const void *b)
 {
-	const struct bpf_map_value_off_desc *off_desc1 = a, *off_desc2 = b;
+	const struct btf_field *f1 = a, *f2 = b;
 
-	if (off_desc1->offset < off_desc2->offset)
+	if (f1->offset < f2->offset)
 		return -1;
-	else if (off_desc1->offset > off_desc2->offset)
+	else if (f1->offset > f2->offset)
 		return 1;
 	return 0;
 }
 
-struct bpf_map_value_off_desc *bpf_map_kptr_off_contains(struct bpf_map *map, u32 offset)
+struct btf_field *btf_record_find(const struct btf_record *rec, u32 offset,
+				  enum btf_field_type type)
 {
-	/* Since members are iterated in btf_find_field in increasing order,
-	 * offsets appended to kptr_off_tab are in increasing order, so we can
-	 * do bsearch to find exact match.
-	 */
-	struct bpf_map_value_off *tab;
+	struct btf_field *field;
 
-	if (!map_value_has_kptrs(map))
+	if (IS_ERR_OR_NULL(rec) || !(rec->field_mask & type))
+		return NULL;
+	field = bsearch(&offset, rec->fields, rec->cnt, sizeof(rec->fields[0]), btf_field_cmp);
+	if (!field || !(field->type & type))
 		return NULL;
-	tab = map->kptr_off_tab;
-	return bsearch(&offset, tab->off, tab->nr_off, sizeof(tab->off[0]), bpf_map_kptr_off_cmp);
+	return field;
 }
 
-void bpf_map_free_kptr_off_tab(struct bpf_map *map)
+void btf_record_free(struct btf_record *rec)
 {
-	struct bpf_map_value_off *tab = map->kptr_off_tab;
 	int i;
 
-	if (!map_value_has_kptrs(map))
+	if (IS_ERR_OR_NULL(rec))
 		return;
-	for (i = 0; i < tab->nr_off; i++) {
-		if (tab->off[i].kptr.module)
-			module_put(tab->off[i].kptr.module);
-		btf_put(tab->off[i].kptr.btf);
+	for (i = 0; i < rec->cnt; i++) {
+		switch (rec->fields[i].type) {
+		case BPF_KPTR_UNREF:
+		case BPF_KPTR_REF:
+			if (rec->fields[i].kptr.module)
+				module_put(rec->fields[i].kptr.module);
+			btf_put(rec->fields[i].kptr.btf);
+			break;
+		default:
+			WARN_ON_ONCE(1);
+			continue;
+		}
 	}
-	kfree(tab);
-	map->kptr_off_tab = NULL;
+	kfree(rec);
+}
+
+void bpf_map_free_record(struct bpf_map *map)
+{
+	btf_record_free(map->record);
+	map->record = NULL;
 }
 
-struct bpf_map_value_off *bpf_map_copy_kptr_off_tab(const struct bpf_map *map)
+struct btf_record *btf_record_dup(const struct btf_record *rec)
 {
-	struct bpf_map_value_off *tab = map->kptr_off_tab, *new_tab;
-	int size, i;
+	const struct btf_field *fields;
+	struct btf_record *new_rec;
+	int ret, size, i;
 
-	if (!map_value_has_kptrs(map))
-		return ERR_PTR(-ENOENT);
-	size = offsetof(struct bpf_map_value_off, off[tab->nr_off]);
-	new_tab = kmemdup(tab, size, GFP_KERNEL | __GFP_NOWARN);
-	if (!new_tab)
+	if (IS_ERR_OR_NULL(rec))
+		return NULL;
+	size = offsetof(struct btf_record, fields[rec->cnt]);
+	new_rec = kmemdup(rec, size, GFP_KERNEL | __GFP_NOWARN);
+	if (!new_rec)
 		return ERR_PTR(-ENOMEM);
-	/* Do a deep copy of the kptr_off_tab */
-	for (i = 0; i < tab->nr_off; i++) {
-		btf_get(tab->off[i].kptr.btf);
-		if (tab->off[i].kptr.module && !try_module_get(tab->off[i].kptr.module)) {
-			while (i--) {
-				if (tab->off[i].kptr.module)
-					module_put(tab->off[i].kptr.module);
-				btf_put(tab->off[i].kptr.btf);
+	/* Do a deep copy of the btf_record */
+	fields = rec->fields;
+	new_rec->cnt = 0;
+	for (i = 0; i < rec->cnt; i++) {
+		switch (fields[i].type) {
+		case BPF_KPTR_UNREF:
+		case BPF_KPTR_REF:
+			btf_get(fields[i].kptr.btf);
+			if (fields[i].kptr.module && !try_module_get(fields[i].kptr.module)) {
+				ret = -ENXIO;
+				goto free;
 			}
-			kfree(new_tab);
-			return ERR_PTR(-ENXIO);
+			break;
+		default:
+			ret = -EFAULT;
+			WARN_ON_ONCE(1);
+			goto free;
 		}
+		new_rec->cnt++;
 	}
-	return new_tab;
+	return new_rec;
+free:
+	btf_record_free(new_rec);
+	return ERR_PTR(ret);
 }
 
-bool bpf_map_equal_kptr_off_tab(const struct bpf_map *map_a, const struct bpf_map *map_b)
+bool btf_record_equal(const struct btf_record *rec_a, const struct btf_record *rec_b)
 {
-	struct bpf_map_value_off *tab_a = map_a->kptr_off_tab, *tab_b = map_b->kptr_off_tab;
-	bool a_has_kptr = map_value_has_kptrs(map_a), b_has_kptr = map_value_has_kptrs(map_b);
+	bool a_has_fields = !IS_ERR_OR_NULL(rec_a), b_has_fields = !IS_ERR_OR_NULL(rec_b);
 	int size;
 
-	if (!a_has_kptr && !b_has_kptr)
+	if (!a_has_fields && !b_has_fields)
 		return true;
-	if (a_has_kptr != b_has_kptr)
+	if (a_has_fields != b_has_fields)
 		return false;
-	if (tab_a->nr_off != tab_b->nr_off)
+	if (rec_a->cnt != rec_b->cnt)
 		return false;
-	size = offsetof(struct bpf_map_value_off, off[tab_a->nr_off]);
-	return !memcmp(tab_a, tab_b, size);
+	size = offsetof(struct btf_record, fields[rec_a->cnt]);
+	return !memcmp(rec_a, rec_b, size);
 }
 
-/* Caller must ensure map_value_has_kptrs is true. Note that this function can
- * be called on a map value while the map_value is visible to BPF programs, as
- * it ensures the correct synchronization, and we already enforce the same using
- * the bpf_kptr_xchg helper on the BPF program side for referenced kptrs.
- */
-void bpf_map_free_kptrs(struct bpf_map *map, void *map_value)
+void bpf_obj_free_fields(const struct btf_record *rec, void *obj)
 {
-	struct bpf_map_value_off *tab = map->kptr_off_tab;
-	unsigned long *btf_id_ptr;
+	const struct btf_field *fields;
 	int i;
 
-	for (i = 0; i < tab->nr_off; i++) {
-		struct bpf_map_value_off_desc *off_desc = &tab->off[i];
-		unsigned long old_ptr;
-
-		btf_id_ptr = map_value + off_desc->offset;
-		if (off_desc->type == BPF_KPTR_UNREF) {
-			u64 *p = (u64 *)btf_id_ptr;
-
-			WRITE_ONCE(*p, 0);
+	if (IS_ERR_OR_NULL(rec))
+		return;
+	fields = rec->fields;
+	for (i = 0; i < rec->cnt; i++) {
+		const struct btf_field *field = &fields[i];
+		void *field_ptr = obj + field->offset;
+
+		switch (fields[i].type) {
+		case BPF_KPTR_UNREF:
+			WRITE_ONCE(*(u64 *)field_ptr, 0);
+			break;
+		case BPF_KPTR_REF:
+			field->kptr.dtor((void *)xchg((unsigned long *)field_ptr, 0));
+			break;
+		default:
+			WARN_ON_ONCE(1);
 			continue;
 		}
-		old_ptr = xchg(btf_id_ptr, 0);
-		off_desc->kptr.dtor((void *)old_ptr);
 	}
 }
 
@@ -612,10 +632,10 @@ static void bpf_map_free_deferred(struct work_struct *work)
 	struct bpf_map *map = container_of(work, struct bpf_map, work);
 
 	security_bpf_map_free(map);
-	kfree(map->off_arr);
+	kfree(map->field_offs);
 	bpf_map_release_memcg(map);
 	/* implementation dependent freeing, map_free callback also does
-	 * bpf_map_free_kptr_off_tab, if needed.
+	 * bpf_map_free_record, if needed.
 	 */
 	map->ops->map_free(map);
 }
@@ -779,7 +799,7 @@ static int bpf_map_mmap(struct file *filp, struct vm_area_struct *vma)
 	int err;
 
 	if (!map->ops->map_mmap || map_value_has_spin_lock(map) ||
-	    map_value_has_timer(map) || map_value_has_kptrs(map))
+	    map_value_has_timer(map) || !IS_ERR_OR_NULL(map->record))
 		return -ENOTSUPP;
 
 	if (!(vma->vm_flags & VM_SHARED))
@@ -906,7 +926,7 @@ int map_check_no_btf(const struct bpf_map *map,
 	return -ENOTSUPP;
 }
 
-static int map_off_arr_cmp(const void *_a, const void *_b, const void *priv)
+static int map_field_offs_cmp(const void *_a, const void *_b, const void *priv)
 {
 	const u32 a = *(const u32 *)_a;
 	const u32 b = *(const u32 *)_b;
@@ -918,15 +938,15 @@ static int map_off_arr_cmp(const void *_a, const void *_b, const void *priv)
 	return 0;
 }
 
-static void map_off_arr_swap(void *_a, void *_b, int size, const void *priv)
+static void map_field_offs_swap(void *_a, void *_b, int size, const void *priv)
 {
 	struct bpf_map *map = (struct bpf_map *)priv;
-	u32 *off_base = map->off_arr->field_off;
+	u32 *off_base = map->field_offs->field_off;
 	u32 *a = _a, *b = _b;
 	u8 *sz_a, *sz_b;
 
-	sz_a = map->off_arr->field_sz + (a - off_base);
-	sz_b = map->off_arr->field_sz + (b - off_base);
+	sz_a = map->field_offs->field_sz + (a - off_base);
+	sz_b = map->field_offs->field_sz + (b - off_base);
 
 	swap(*a, *b);
 	swap(*sz_a, *sz_b);
@@ -936,51 +956,51 @@ static int bpf_map_alloc_off_arr(struct bpf_map *map)
 {
 	bool has_spin_lock = map_value_has_spin_lock(map);
 	bool has_timer = map_value_has_timer(map);
-	bool has_kptrs = map_value_has_kptrs(map);
-	struct bpf_map_off_arr *off_arr;
+	bool has_fields = !IS_ERR_OR_NULL(map);
+	struct btf_field_offs *fo;
 	u32 i;
 
-	if (!has_spin_lock && !has_timer && !has_kptrs) {
-		map->off_arr = NULL;
+	if (!has_spin_lock && !has_timer && !has_fields) {
+		map->field_offs = NULL;
 		return 0;
 	}
 
-	off_arr = kmalloc(sizeof(*map->off_arr), GFP_KERNEL | __GFP_NOWARN);
-	if (!off_arr)
+	fo = kmalloc(sizeof(*map->field_offs), GFP_KERNEL | __GFP_NOWARN);
+	if (!fo)
 		return -ENOMEM;
-	map->off_arr = off_arr;
+	map->field_offs = fo;
 
-	off_arr->cnt = 0;
+	fo->cnt = 0;
 	if (has_spin_lock) {
-		i = off_arr->cnt;
+		i = fo->cnt;
 
-		off_arr->field_off[i] = map->spin_lock_off;
-		off_arr->field_sz[i] = sizeof(struct bpf_spin_lock);
-		off_arr->cnt++;
+		fo->field_off[i] = map->spin_lock_off;
+		fo->field_sz[i] = sizeof(struct bpf_spin_lock);
+		fo->cnt++;
 	}
 	if (has_timer) {
-		i = off_arr->cnt;
+		i = fo->cnt;
 
-		off_arr->field_off[i] = map->timer_off;
-		off_arr->field_sz[i] = sizeof(struct bpf_timer);
-		off_arr->cnt++;
+		fo->field_off[i] = map->timer_off;
+		fo->field_sz[i] = sizeof(struct bpf_timer);
+		fo->cnt++;
 	}
-	if (has_kptrs) {
-		struct bpf_map_value_off *tab = map->kptr_off_tab;
-		u32 *off = &off_arr->field_off[off_arr->cnt];
-		u8 *sz = &off_arr->field_sz[off_arr->cnt];
+	if (has_fields) {
+		struct btf_record *rec = map->record;
+		u32 *off = &fo->field_off[fo->cnt];
+		u8 *sz = &fo->field_sz[fo->cnt];
 
-		for (i = 0; i < tab->nr_off; i++) {
-			*off++ = tab->off[i].offset;
-			*sz++ = sizeof(u64);
+		for (i = 0; i < rec->cnt; i++) {
+			*off++ = rec->fields[i].offset;
+			*sz++ = btf_field_type_size(rec->fields[i].type);
 		}
-		off_arr->cnt += tab->nr_off;
+		fo->cnt += rec->cnt;
 	}
 
-	if (off_arr->cnt == 1)
+	if (fo->cnt == 1)
 		return 0;
-	sort_r(off_arr->field_off, off_arr->cnt, sizeof(off_arr->field_off[0]),
-	       map_off_arr_cmp, map_off_arr_swap, map);
+	sort_r(fo->field_off, fo->cnt, sizeof(fo->field_off[0]),
+	       map_field_offs_cmp, map_field_offs_swap, map);
 	return 0;
 }
 
@@ -1038,8 +1058,10 @@ static int map_check_btf(struct bpf_map *map, const struct btf *btf,
 			return -EOPNOTSUPP;
 	}
 
-	map->kptr_off_tab = btf_parse_kptrs(btf, value_type);
-	if (map_value_has_kptrs(map)) {
+	map->record = btf_parse_fields(btf, value_type);
+	if (!IS_ERR_OR_NULL(map->record)) {
+		int i;
+
 		if (!bpf_capable()) {
 			ret = -EPERM;
 			goto free_map_tab;
@@ -1048,12 +1070,25 @@ static int map_check_btf(struct bpf_map *map, const struct btf *btf,
 			ret = -EACCES;
 			goto free_map_tab;
 		}
-		if (map->map_type != BPF_MAP_TYPE_HASH &&
-		    map->map_type != BPF_MAP_TYPE_LRU_HASH &&
-		    map->map_type != BPF_MAP_TYPE_ARRAY &&
-		    map->map_type != BPF_MAP_TYPE_PERCPU_ARRAY) {
-			ret = -EOPNOTSUPP;
-			goto free_map_tab;
+		for (i = 0; i < sizeof(map->record->field_mask) * 8; i++) {
+			switch (map->record->field_mask & (1 << i)) {
+			case 0:
+				continue;
+			case BPF_KPTR_UNREF:
+			case BPF_KPTR_REF:
+				if (map->map_type != BPF_MAP_TYPE_HASH &&
+				    map->map_type != BPF_MAP_TYPE_LRU_HASH &&
+				    map->map_type != BPF_MAP_TYPE_ARRAY &&
+				    map->map_type != BPF_MAP_TYPE_PERCPU_ARRAY) {
+					ret = -EOPNOTSUPP;
+					goto free_map_tab;
+				}
+				break;
+			default:
+				/* Fail if map_type checks are missing for a field type */
+				ret = -EOPNOTSUPP;
+				goto free_map_tab;
+			}
 		}
 	}
 
@@ -1065,7 +1100,7 @@ static int map_check_btf(struct bpf_map *map, const struct btf *btf,
 
 	return ret;
 free_map_tab:
-	bpf_map_free_kptr_off_tab(map);
+	bpf_map_free_record(map);
 	return ret;
 }
 
@@ -1186,7 +1221,7 @@ static int map_create(union bpf_attr *attr)
 free_map_sec:
 	security_bpf_map_free(map);
 free_map_off_arr:
-	kfree(map->off_arr);
+	kfree(map->field_offs);
 free_map:
 	btf_put(map->btf);
 	map->ops->map_free(map);
@@ -1883,7 +1918,7 @@ static int map_freeze(const union bpf_attr *attr)
 		return PTR_ERR(map);
 
 	if (map->map_type == BPF_MAP_TYPE_STRUCT_OPS ||
-	    map_value_has_timer(map) || map_value_has_kptrs(map)) {
+	    map_value_has_timer(map) || !IS_ERR_OR_NULL(map->record)) {
 		fdput(f);
 		return -ENOTSUPP;
 	}
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 14d350a25d5d..5ce5364ce898 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -262,7 +262,7 @@ struct bpf_call_arg_meta {
 	struct btf *ret_btf;
 	u32 ret_btf_id;
 	u32 subprogno;
-	struct bpf_map_value_off_desc *kptr_off_desc;
+	struct btf_field *kptr_field;
 	u8 uninit_dynptr_regno;
 };
 
@@ -3674,15 +3674,15 @@ int check_ptr_off_reg(struct bpf_verifier_env *env,
 }
 
 static int map_kptr_match_type(struct bpf_verifier_env *env,
-			       struct bpf_map_value_off_desc *off_desc,
+			       struct btf_field *kptr_field,
 			       struct bpf_reg_state *reg, u32 regno)
 {
-	const char *targ_name = kernel_type_name(off_desc->kptr.btf, off_desc->kptr.btf_id);
+	const char *targ_name = kernel_type_name(kptr_field->kptr.btf, kptr_field->kptr.btf_id);
 	int perm_flags = PTR_MAYBE_NULL;
 	const char *reg_name = "";
 
 	/* Only unreferenced case accepts untrusted pointers */
-	if (off_desc->type == BPF_KPTR_UNREF)
+	if (kptr_field->type == BPF_KPTR_UNREF)
 		perm_flags |= PTR_UNTRUSTED;
 
 	if (base_type(reg->type) != PTR_TO_BTF_ID || (type_flag(reg->type) & ~perm_flags))
@@ -3729,15 +3729,15 @@ static int map_kptr_match_type(struct bpf_verifier_env *env,
 	 * strict mode to true for type match.
 	 */
 	if (!btf_struct_ids_match(&env->log, reg->btf, reg->btf_id, reg->off,
-				  off_desc->kptr.btf, off_desc->kptr.btf_id,
-				  off_desc->type == BPF_KPTR_REF))
+				  kptr_field->kptr.btf, kptr_field->kptr.btf_id,
+				  kptr_field->type == BPF_KPTR_REF))
 		goto bad_type;
 	return 0;
 bad_type:
 	verbose(env, "invalid kptr access, R%d type=%s%s ", regno,
 		reg_type_str(env, reg->type), reg_name);
 	verbose(env, "expected=%s%s", reg_type_str(env, PTR_TO_BTF_ID), targ_name);
-	if (off_desc->type == BPF_KPTR_UNREF)
+	if (kptr_field->type == BPF_KPTR_UNREF)
 		verbose(env, " or %s%s\n", reg_type_str(env, PTR_TO_BTF_ID | PTR_UNTRUSTED),
 			targ_name);
 	else
@@ -3747,7 +3747,7 @@ static int map_kptr_match_type(struct bpf_verifier_env *env,
 
 static int check_map_kptr_access(struct bpf_verifier_env *env, u32 regno,
 				 int value_regno, int insn_idx,
-				 struct bpf_map_value_off_desc *off_desc)
+				 struct btf_field *kptr_field)
 {
 	struct bpf_insn *insn = &env->prog->insnsi[insn_idx];
 	int class = BPF_CLASS(insn->code);
@@ -3757,7 +3757,7 @@ static int check_map_kptr_access(struct bpf_verifier_env *env, u32 regno,
 	 *  - Reject cases where variable offset may touch kptr
 	 *  - size of access (must be BPF_DW)
 	 *  - tnum_is_const(reg->var_off)
-	 *  - off_desc->offset == off + reg->var_off.value
+	 *  - kptr_field->offset == off + reg->var_off.value
 	 */
 	/* Only BPF_[LDX,STX,ST] | BPF_MEM | BPF_DW is supported */
 	if (BPF_MODE(insn->code) != BPF_MEM) {
@@ -3768,7 +3768,7 @@ static int check_map_kptr_access(struct bpf_verifier_env *env, u32 regno,
 	/* We only allow loading referenced kptr, since it will be marked as
 	 * untrusted, similar to unreferenced kptr.
 	 */
-	if (class != BPF_LDX && off_desc->type == BPF_KPTR_REF) {
+	if (class != BPF_LDX && kptr_field->type == BPF_KPTR_REF) {
 		verbose(env, "store to referenced kptr disallowed\n");
 		return -EACCES;
 	}
@@ -3778,19 +3778,19 @@ static int check_map_kptr_access(struct bpf_verifier_env *env, u32 regno,
 		/* We can simply mark the value_regno receiving the pointer
 		 * value from map as PTR_TO_BTF_ID, with the correct type.
 		 */
-		mark_btf_ld_reg(env, cur_regs(env), value_regno, PTR_TO_BTF_ID, off_desc->kptr.btf,
-				off_desc->kptr.btf_id, PTR_MAYBE_NULL | PTR_UNTRUSTED);
+		mark_btf_ld_reg(env, cur_regs(env), value_regno, PTR_TO_BTF_ID, kptr_field->kptr.btf,
+				kptr_field->kptr.btf_id, PTR_MAYBE_NULL | PTR_UNTRUSTED);
 		/* For mark_ptr_or_null_reg */
 		val_reg->id = ++env->id_gen;
 	} else if (class == BPF_STX) {
 		val_reg = reg_state(env, value_regno);
 		if (!register_is_null(val_reg) &&
-		    map_kptr_match_type(env, off_desc, val_reg, value_regno))
+		    map_kptr_match_type(env, kptr_field, val_reg, value_regno))
 			return -EACCES;
 	} else if (class == BPF_ST) {
 		if (insn->imm) {
 			verbose(env, "BPF_ST imm must be 0 when storing to kptr at off=%u\n",
-				off_desc->offset);
+				kptr_field->offset);
 			return -EACCES;
 		}
 	} else {
@@ -3809,7 +3809,8 @@ static int check_map_access(struct bpf_verifier_env *env, u32 regno,
 	struct bpf_func_state *state = vstate->frame[vstate->curframe];
 	struct bpf_reg_state *reg = &state->regs[regno];
 	struct bpf_map *map = reg->map_ptr;
-	int err;
+	struct btf_record *rec;
+	int err, i;
 
 	err = check_mem_region_access(env, regno, off, size, map->value_size,
 				      zero_size_allowed);
@@ -3839,15 +3840,18 @@ static int check_map_access(struct bpf_verifier_env *env, u32 regno,
 			return -EACCES;
 		}
 	}
-	if (map_value_has_kptrs(map)) {
-		struct bpf_map_value_off *tab = map->kptr_off_tab;
-		int i;
-
-		for (i = 0; i < tab->nr_off; i++) {
-			u32 p = tab->off[i].offset;
-
-			if (reg->smin_value + off < p + sizeof(u64) &&
-			    p < reg->umax_value + off + size) {
+	if (IS_ERR_OR_NULL(map->record))
+		return 0;
+	rec = map->record;
+	for (i = 0; i < rec->cnt; i++) {
+		struct btf_field *field = &rec->fields[i];
+		u32 p = field->offset;
+
+		if (reg->smin_value + off < p + btf_field_type_size(field->type) &&
+		    p < reg->umax_value + off + size) {
+			switch (field->type) {
+			case BPF_KPTR_UNREF:
+			case BPF_KPTR_REF:
 				if (src != ACCESS_DIRECT) {
 					verbose(env, "kptr cannot be accessed indirectly by helper\n");
 					return -EACCES;
@@ -3866,10 +3870,13 @@ static int check_map_access(struct bpf_verifier_env *env, u32 regno,
 					return -EACCES;
 				}
 				break;
+			default:
+				verbose(env, "field cannot be accessed directly by load/store\n");
+				return -EACCES;
 			}
 		}
 	}
-	return err;
+	return 0;
 }
 
 #define MAX_PACKET_OFF 0xffff
@@ -4742,7 +4749,7 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
 		if (value_regno >= 0)
 			mark_reg_unknown(env, regs, value_regno);
 	} else if (reg->type == PTR_TO_MAP_VALUE) {
-		struct bpf_map_value_off_desc *kptr_off_desc = NULL;
+		struct btf_field *kptr_field = NULL;
 
 		if (t == BPF_WRITE && value_regno >= 0 &&
 		    is_pointer_value(env, value_regno)) {
@@ -4756,11 +4763,10 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
 		if (err)
 			return err;
 		if (tnum_is_const(reg->var_off))
-			kptr_off_desc = bpf_map_kptr_off_contains(reg->map_ptr,
-								  off + reg->var_off.value);
-		if (kptr_off_desc) {
-			err = check_map_kptr_access(env, regno, value_regno, insn_idx,
-						    kptr_off_desc);
+			kptr_field = btf_record_find(reg->map_ptr->record,
+						     off + reg->var_off.value, BPF_KPTR);
+		if (kptr_field) {
+			err = check_map_kptr_access(env, regno, value_regno, insn_idx, kptr_field);
 		} else if (t == BPF_READ && value_regno >= 0) {
 			struct bpf_map *map = reg->map_ptr;
 
@@ -5527,10 +5533,9 @@ static int process_kptr_func(struct bpf_verifier_env *env, int regno,
 			     struct bpf_call_arg_meta *meta)
 {
 	struct bpf_reg_state *regs = cur_regs(env), *reg = &regs[regno];
-	struct bpf_map_value_off_desc *off_desc;
 	struct bpf_map *map_ptr = reg->map_ptr;
+	struct btf_field *kptr_field;
 	u32 kptr_off;
-	int ret;
 
 	if (!tnum_is_const(reg->var_off)) {
 		verbose(env,
@@ -5543,30 +5548,23 @@ static int process_kptr_func(struct bpf_verifier_env *env, int regno,
 			map_ptr->name);
 		return -EINVAL;
 	}
-	if (!map_value_has_kptrs(map_ptr)) {
-		ret = PTR_ERR_OR_ZERO(map_ptr->kptr_off_tab);
-		if (ret == -E2BIG)
-			verbose(env, "map '%s' has more than %d kptr\n", map_ptr->name,
-				BPF_MAP_VALUE_OFF_MAX);
-		else if (ret == -EEXIST)
-			verbose(env, "map '%s' has repeating kptr BTF tags\n", map_ptr->name);
-		else
-			verbose(env, "map '%s' has no valid kptr\n", map_ptr->name);
+	if (!btf_record_has_field(map_ptr->record, BPF_KPTR)) {
+		verbose(env, "map '%s' has no valid kptr\n", map_ptr->name);
 		return -EINVAL;
 	}
 
 	meta->map_ptr = map_ptr;
 	kptr_off = reg->off + reg->var_off.value;
-	off_desc = bpf_map_kptr_off_contains(map_ptr, kptr_off);
-	if (!off_desc) {
+	kptr_field = btf_record_find(map_ptr->record, kptr_off, BPF_KPTR);
+	if (!kptr_field) {
 		verbose(env, "off=%d doesn't point to kptr\n", kptr_off);
 		return -EACCES;
 	}
-	if (off_desc->type != BPF_KPTR_REF) {
+	if (kptr_field->type != BPF_KPTR_REF) {
 		verbose(env, "off=%d kptr isn't referenced kptr\n", kptr_off);
 		return -EACCES;
 	}
-	meta->kptr_off_desc = off_desc;
+	meta->kptr_field = kptr_field;
 	return 0;
 }
 
@@ -5788,7 +5786,7 @@ static int check_reg_type(struct bpf_verifier_env *env, u32 regno,
 		}
 
 		if (meta->func_id == BPF_FUNC_kptr_xchg) {
-			if (map_kptr_match_type(env, meta->kptr_off_desc, reg, regno))
+			if (map_kptr_match_type(env, meta->kptr_field, reg, regno))
 				return -EACCES;
 		} else {
 			if (arg_btf_id == BPF_PTR_POISON) {
@@ -7536,8 +7534,8 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 		mark_reg_known_zero(env, regs, BPF_REG_0);
 		regs[BPF_REG_0].type = PTR_TO_BTF_ID | ret_flag;
 		if (func_id == BPF_FUNC_kptr_xchg) {
-			ret_btf = meta.kptr_off_desc->kptr.btf;
-			ret_btf_id = meta.kptr_off_desc->kptr.btf_id;
+			ret_btf = meta.kptr_field->kptr.btf;
+			ret_btf_id = meta.kptr_field->kptr.btf_id;
 		} else {
 			if (fn->ret_btf_id == BPF_PTR_POISON) {
 				verbose(env, "verifier internal error:");
-- 
2.38.1

