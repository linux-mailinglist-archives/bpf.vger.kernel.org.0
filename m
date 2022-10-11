Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB6625FA9F9
	for <lists+bpf@lfdr.de>; Tue, 11 Oct 2022 03:24:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbiJKBYA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 10 Oct 2022 21:24:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbiJKBXa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 10 Oct 2022 21:23:30 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3A4D84E4E
        for <bpf@vger.kernel.org>; Mon, 10 Oct 2022 18:23:03 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id h13so10736386pfr.7
        for <bpf@vger.kernel.org>; Mon, 10 Oct 2022 18:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eHyVwoJM0Rm9pgvsyhj+DGstkkTOrCAtqXw6lBgV940=;
        b=UpWvmzIildI/HbMJRVVt4w1NVzqAc87U2W/FICE+CjtFPWALwE0mX8FsYo8xPKebEQ
         U5MNj759e3F9EHom5onmkkeUqDQYPXkJ/YC/XSthMH/9HniQZGW7jN/ybcNrViqO0+kd
         dMjllNs0GmMcoq/pWjtUVEPBDI99cpQHM6Tk/t3MV3BsTPXf2R2smMyl1+TlbKPSDWH0
         g4EW3I4/AuVYY/JmWsrKaIZoW2vv22ys2hkdhmLtOVrwH2sNFzaduo+fjp7kg5TsznET
         /pxCptGU9GKfbEqI5+ZBwS0PjWXIN1u4RnEfXgqBYDGySWxBa+GBvkZrRMhmu9vU4f/q
         piPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eHyVwoJM0Rm9pgvsyhj+DGstkkTOrCAtqXw6lBgV940=;
        b=jvuiqirnNvB34v/sUwcYqdOsDp8VvxnN9V1+1Ezg6uHEfjBlqaAkhUKAMi6cRu0BWA
         pxnZ7zwZ6BDjjhb35NW2/lHMYxa4bdZ+HQ/DL6vmeGSKo024K8x2NPv8HhqncVC7UPW3
         o7wL1Vfu1sKwaR0S3hfKiTaXOiF1Ac5CJ0qkf0gFC+WN4GqcuNT7pp7LLTnTMOW+IprV
         gp7J6OBH8rNGOOvf3w2SLRC4DLP5Ti8IpV6NOceAf0fCx+yZqJikNbq4f9Bx+LIJaUJ+
         SuFehOY1aNfERMErY0MFtZR+QlgEuHYK2FCe20cbCIVuDvkmBSUZijhLn/jAsp8ZTIG8
         AFDw==
X-Gm-Message-State: ACrzQf093qIi6CEjHrxWaf66KYIu+Xuf9rXbBB0CmTmHkFD+0wcPPors
        SA5gqrM+iUITgcT00/P/ltPOQgpBX2LEhQ==
X-Google-Smtp-Source: AMsMyM6U34du6GNHKGfpGzmSGM7PGG6uHdD5kV9m5lVVIbX8WXu/6hIO3VTN0/HXA9rBsdKKo41R1A==
X-Received: by 2002:a05:6a00:4214:b0:562:67d0:77e7 with SMTP id cd20-20020a056a00421400b0056267d077e7mr23279350pfb.62.1665451381622;
        Mon, 10 Oct 2022 18:23:01 -0700 (PDT)
Received: from localhost ([103.4.221.252])
        by smtp.gmail.com with ESMTPSA id d1-20020aa797a1000000b00562362dbbc1sm7578835pfq.157.2022.10.10.18.23.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 18:23:01 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Delyan Kratunov <delyank@fb.com>
Subject: [PATCH bpf-next v1 06/25] bpf: Refactor kptr_off_tab into fields_tab
Date:   Tue, 11 Oct 2022 06:52:21 +0530
Message-Id: <20221011012240.3149-7-memxor@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221011012240.3149-1-memxor@gmail.com>
References: <20221011012240.3149-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=38924; i=memxor@gmail.com; h=from:subject; bh=AV0iM3NrF7ikYJCG/pmHN8ciolW98Sd3biJrUXDbFNs=; b=owEBbQKS/ZANAwAKAUzgyIZIvxHKAcsmYgBjRMUauLHW0uGhIpaI61+eEE1v55EfTtYkAqB8d+3V e3RWeYWJAjMEAAEKAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY0TFGgAKCRBM4MiGSL8RyoUYD/ wOUBWnRjmjhFW1gl1/wVJJ0lPpZk1NSHG2ggzA4FS6Tn4IYVlTxw+3eTP5Dg+slxzRiLe7n3HVdKga J6Pe7n9kGo2Lp4YjA6ZJOIR8Cl0fbu+jz1XJbhRHd07ENRs+BodZ53sw7FBKh2Ge+Q0tvwznH62xyl 3nW8IwFQynJ9/67tsx77FqDj6RPHwxy8hXt9O9i710xmVXzGMameQYK9YY26J1mOiwmv5vV4BJxi5A G/omOZ6rrLUIVQ+xyGVienbgaGEgyMjesvszuaUefMG+vtyKOZph3WXlicevKDxE7smGuZ9SvrGppf 1yHeLAr7L1Ktuhm4YmqHMljHU1rz5S+pfYn1sKUTprjMDD+x8mMcJvBhPYfevdHmgzoYO/p2wlh4mW 0IbZGLUmxy7wxUVQY5dImAPudo5nzLt0mhQ09KU2NLlWhvpXRPzq/t4/AKxsL+qcyFdYB1hJcP5d+Y UKuhl/iIYGlBkUnMg2cD3dAC3F+fELyuGA4ik+eFZus22y5VKWvpFQzNRJ1upUKrzHZsaPQTPzh5B6 4cPZRer0qzQqeu+JyPmx631Atupz9LYk8hs+/XGXhKIuLYogyvtKBvjzJ3uFIIszZBwkgaO/icIO0Q n76w3VbrLlxtpolKXWCxsB7c0yahmZowBej9qJDZQ3INea/zB+q6+IvmUg+Q==
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

Hence, refactor the code into generic btf_type_fields and btf_field
member structs. The btf_type_fields represents the fields of a specific
btf_type in user BTF. The cnt indicates the number of special fields we
successfully recognized, and field_mask is a bitmask of fields that were
found, to enable quick determination of availability of a certain field.

Subsequently, refactor the rest of the code to work with these generic
types, remove assumptions about kptr and kptr_off_tab, rename variables
to more meaningful names, etc.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf.h     | 103 +++++++++++++-------
 include/linux/btf.h     |   4 +-
 kernel/bpf/arraymap.c   |  13 ++-
 kernel/bpf/btf.c        |  64 ++++++-------
 kernel/bpf/hashtab.c    |  14 ++-
 kernel/bpf/map_in_map.c |  13 ++-
 kernel/bpf/syscall.c    | 203 +++++++++++++++++++++++-----------------
 kernel/bpf/verifier.c   |  96 ++++++++++---------
 8 files changed, 289 insertions(+), 221 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 9e7d46d16032..25e77a172d7c 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -164,35 +164,41 @@ struct bpf_map_ops {
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
+struct btf_type_fields {
+	u32 cnt;
+	u32 field_mask;
+	struct btf_field fields[];
 };
 
-struct bpf_map_off_arr {
+struct btf_type_fields_off {
 	u32 cnt;
 	u32 field_off[BPF_MAP_OFF_ARR_MAX];
 	u8 field_sz[BPF_MAP_OFF_ARR_MAX];
@@ -214,7 +220,7 @@ struct bpf_map {
 	u64 map_extra; /* any per-map-type extra fields */
 	u32 map_flags;
 	int spin_lock_off; /* >=0 valid offset, <0 error */
-	struct bpf_map_value_off *kptr_off_tab;
+	struct btf_type_fields *fields_tab;
 	int timer_off; /* >=0 valid offset, <0 error */
 	u32 id;
 	int numa_node;
@@ -226,7 +232,7 @@ struct bpf_map {
 	struct obj_cgroup *objcg;
 #endif
 	char name[BPF_OBJ_NAME_LEN];
-	struct bpf_map_off_arr *off_arr;
+	struct btf_type_fields_off *off_arr;
 	/* The 3rd and 4th cacheline with misc members to avoid false sharing
 	 * particularly with refcounting.
 	 */
@@ -250,6 +256,37 @@ struct bpf_map {
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
+static inline bool btf_type_fields_has_field(const struct btf_type_fields *tab, enum btf_field_type type)
+{
+	if (IS_ERR_OR_NULL(tab))
+		return false;
+	return tab->field_mask & type;
+}
+
 static inline bool map_value_has_spin_lock(const struct bpf_map *map)
 {
 	return map->spin_lock_off >= 0;
@@ -260,23 +297,19 @@ static inline bool map_value_has_timer(const struct bpf_map *map)
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
+	if (!IS_ERR_OR_NULL(map->fields_tab)) {
+		struct btf_field *fields = map->fields_tab->fields;
+		u32 cnt = map->fields_tab->cnt;
 		int i;
 
-		for (i = 0; i < tab->nr_off; i++)
-			*(u64 *)(dst + tab->off[i].offset) = 0;
+		for (i = 0; i < cnt; i++)
+			memset(dst + fields[i].offset, 0, btf_field_type_size(fields[i].type));
 	}
 }
 
@@ -1691,11 +1724,13 @@ void bpf_prog_put(struct bpf_prog *prog);
 void bpf_prog_free_id(struct bpf_prog *prog, bool do_idr_lock);
 void bpf_map_free_id(struct bpf_map *map, bool do_idr_lock);
 
-struct bpf_map_value_off_desc *bpf_map_kptr_off_contains(struct bpf_map *map, u32 offset);
-void bpf_map_free_kptr_off_tab(struct bpf_map *map);
-struct bpf_map_value_off *bpf_map_copy_kptr_off_tab(const struct bpf_map *map);
-bool bpf_map_equal_kptr_off_tab(const struct bpf_map *map_a, const struct bpf_map *map_b);
-void bpf_map_free_kptrs(struct bpf_map *map, void *map_value);
+struct btf_field *btf_type_fields_find(const struct btf_type_fields *tab,
+				       u32 offset, enum btf_field_type type);
+void btf_type_fields_free(struct btf_type_fields *tab);
+void bpf_map_free_fields_tab(struct bpf_map *map);
+struct btf_type_fields *btf_type_fields_dup(const struct btf_type_fields *tab);
+bool btf_type_fields_equal(const struct btf_type_fields *tab_a, const struct btf_type_fields *tab_b);
+void bpf_obj_free_fields(const struct btf_type_fields *tab, void *obj);
 
 struct bpf_map *bpf_map_get(u32 ufd);
 struct bpf_map *bpf_map_get_with_uref(u32 ufd);
diff --git a/include/linux/btf.h b/include/linux/btf.h
index 86aad9b2ce02..0d47cbb11a59 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -163,8 +163,8 @@ bool btf_member_is_reg_int(const struct btf *btf, const struct btf_type *s,
 			   u32 expected_offset, u32 expected_size);
 int btf_find_spin_lock(const struct btf *btf, const struct btf_type *t);
 int btf_find_timer(const struct btf *btf, const struct btf_type *t);
-struct bpf_map_value_off *btf_parse_kptrs(const struct btf *btf,
-					  const struct btf_type *t);
+struct btf_type_fields *btf_parse_fields(const struct btf *btf,
+					 const struct btf_type *t);
 bool btf_type_is_void(const struct btf_type *t);
 s32 btf_find_by_name_kind(const struct btf *btf, const char *name, u8 kind);
 const struct btf_type *btf_type_skip_modifiers(const struct btf *btf,
diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
index 832b2659e96e..defe5c00049a 100644
--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -310,8 +310,7 @@ static void check_and_free_fields(struct bpf_array *arr, void *val)
 {
 	if (map_value_has_timer(&arr->map))
 		bpf_timer_cancel_and_free(val + arr->map.timer_off);
-	if (map_value_has_kptrs(&arr->map))
-		bpf_map_free_kptrs(&arr->map, val);
+	bpf_obj_free_fields(arr->map.fields_tab, val);
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
+	if (!IS_ERR_OR_NULL(map->fields_tab)) {
 		if (array->map.map_type == BPF_MAP_TYPE_PERCPU_ARRAY) {
 			for (i = 0; i < array->map.max_entries; i++) {
 				void __percpu *pptr = array->pptrs[i & array->index_mask];
 				int cpu;
 
 				for_each_possible_cpu(cpu) {
-					bpf_map_free_kptrs(map, per_cpu_ptr(pptr, cpu));
+					bpf_obj_free_fields(map->fields_tab, per_cpu_ptr(pptr, cpu));
 					cond_resched();
 				}
 			}
 		} else {
 			for (i = 0; i < array->map.max_entries; i++)
-				bpf_map_free_kptrs(map, array_map_elem_ptr(array, i));
+				bpf_obj_free_fields(map->fields_tab, array_map_elem_ptr(array, i));
 		}
-		bpf_map_free_kptr_off_tab(map);
+		bpf_map_free_fields_tab(map);
 	}
 
 	if (array->map.map_type == BPF_MAP_TYPE_PERCPU_ARRAY)
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index ad301e78f7ee..c8d267098b87 100644
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
@@ -3423,14 +3423,14 @@ int btf_find_timer(const struct btf *btf, const struct btf_type *t)
 	return info.off;
 }
 
-struct bpf_map_value_off *btf_parse_kptrs(const struct btf *btf,
-					  const struct btf_type *t)
+struct btf_type_fields *btf_parse_fields(const struct btf *btf,
+					 const struct btf_type *t)
 {
-	struct btf_field_info info_arr[BPF_MAP_VALUE_OFF_MAX];
-	struct bpf_map_value_off *tab;
+	struct btf_field_info info_arr[BTF_FIELDS_MAX];
 	struct btf *kernel_btf = NULL;
+	struct btf_type_fields *tab;
 	struct module *mod = NULL;
-	int ret, i, nr_off;
+	int ret, i, cnt;
 
 	ret = btf_find_field(btf, t, BTF_FIELD_KPTR, info_arr, ARRAY_SIZE(info_arr));
 	if (ret < 0)
@@ -3438,12 +3438,12 @@ struct bpf_map_value_off *btf_parse_kptrs(const struct btf *btf,
 	if (!ret)
 		return NULL;
 
-	nr_off = ret;
-	tab = kzalloc(offsetof(struct bpf_map_value_off, off[nr_off]), GFP_KERNEL | __GFP_NOWARN);
+	cnt = ret;
+	tab = kzalloc(offsetof(struct btf_type_fields, fields[cnt]), GFP_KERNEL | __GFP_NOWARN);
 	if (!tab)
 		return ERR_PTR(-ENOMEM);
-
-	for (i = 0; i < nr_off; i++) {
+	tab->cnt = 0;
+	for (i = 0; i < cnt; i++) {
 		const struct btf_type *t;
 		s32 id;
 
@@ -3500,28 +3500,24 @@ struct bpf_map_value_off *btf_parse_kptrs(const struct btf *btf,
 				ret = -EINVAL;
 				goto end_mod;
 			}
-			tab->off[i].kptr.dtor = (void *)addr;
+			tab->fields[i].kptr.dtor = (void *)addr;
 		}
 
-		tab->off[i].offset = info_arr[i].off;
-		tab->off[i].type = info_arr[i].type;
-		tab->off[i].kptr.btf_id = id;
-		tab->off[i].kptr.btf = kernel_btf;
-		tab->off[i].kptr.module = mod;
+		tab->fields[i].offset = info_arr[i].off;
+		tab->fields[i].type = info_arr[i].type;
+		tab->fields[i].kptr.btf_id = id;
+		tab->fields[i].kptr.btf = kernel_btf;
+		tab->fields[i].kptr.module = mod;
+		tab->cnt++;
 	}
-	tab->nr_off = nr_off;
+	tab->cnt = cnt;
 	return tab;
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
+	btf_type_fields_free(tab);
 	return ERR_PTR(ret);
 }
 
@@ -6365,7 +6361,7 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
 
 		/* kptr_get is only true for kfunc */
 		if (i == 0 && kptr_get) {
-			struct bpf_map_value_off_desc *off_desc;
+			struct btf_field *kptr_field;
 
 			if (reg->type != PTR_TO_MAP_VALUE) {
 				bpf_log(log, "arg#0 expected pointer to map value\n");
@@ -6381,8 +6377,8 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
 				return -EINVAL;
 			}
 
-			off_desc = bpf_map_kptr_off_contains(reg->map_ptr, reg->off + reg->var_off.value);
-			if (!off_desc || off_desc->type != BPF_KPTR_REF) {
+			kptr_field = btf_type_fields_find(reg->map_ptr->fields_tab, reg->off + reg->var_off.value, BPF_KPTR);
+			if (!kptr_field || kptr_field->type != BPF_KPTR_REF) {
 				bpf_log(log, "arg#0 no referenced kptr at map value offset=%llu\n",
 					reg->off + reg->var_off.value);
 				return -EINVAL;
@@ -6401,8 +6397,8 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
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
index ed3f8a53603b..59cdbea587c5 100644
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
+	if (IS_ERR_OR_NULL(htab->map.fields_tab))
 		return;
 	if (htab_has_extra_elems(htab))
 		num_entries += num_possible_cpus();
-
 	for (i = 0; i < num_entries; i++) {
 		struct htab_elem *elem;
 
 		elem = get_htab_elem(htab, i);
-		bpf_map_free_kptrs(&htab->map, elem->key + round_up(htab->map.key_size, 8));
+		bpf_obj_free_fields(htab->map.fields_tab, elem->key + round_up(htab->map.key_size, 8));
 		cond_resched();
 	}
 }
@@ -766,8 +765,7 @@ static void check_and_free_fields(struct bpf_htab *htab,
 
 	if (map_value_has_timer(&htab->map))
 		bpf_timer_cancel_and_free(map_value + htab->map.timer_off);
-	if (map_value_has_kptrs(&htab->map))
-		bpf_map_free_kptrs(&htab->map, map_value);
+	bpf_obj_free_fields(htab->map.fields_tab, map_value);
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
+	bpf_map_free_fields_tab(map);
 	free_percpu(htab->extra_elems);
 	bpf_map_area_free(htab->buckets);
 	bpf_mem_alloc_destroy(&htab->pcpu_ma);
diff --git a/kernel/bpf/map_in_map.c b/kernel/bpf/map_in_map.c
index 135205d0d560..2bff5f3a5efc 100644
--- a/kernel/bpf/map_in_map.c
+++ b/kernel/bpf/map_in_map.c
@@ -52,7 +52,14 @@ struct bpf_map *bpf_map_meta_alloc(int inner_map_ufd)
 	inner_map_meta->max_entries = inner_map->max_entries;
 	inner_map_meta->spin_lock_off = inner_map->spin_lock_off;
 	inner_map_meta->timer_off = inner_map->timer_off;
-	inner_map_meta->kptr_off_tab = bpf_map_copy_kptr_off_tab(inner_map);
+	inner_map_meta->fields_tab = btf_type_fields_dup(inner_map->fields_tab);
+	if (IS_ERR(inner_map_meta->fields_tab)) {
+		/* btf_type_fields returns NULL or valid pointer in case of
+		 * invalid/empty/valid, but ERR_PTR in case of errors.
+		 */
+		fdput(f);
+		return ERR_CAST(inner_map_meta->fields_tab);
+	}
 	if (inner_map->btf) {
 		btf_get(inner_map->btf);
 		inner_map_meta->btf = inner_map->btf;
@@ -72,7 +79,7 @@ struct bpf_map *bpf_map_meta_alloc(int inner_map_ufd)
 
 void bpf_map_meta_free(struct bpf_map *map_meta)
 {
-	bpf_map_free_kptr_off_tab(map_meta);
+	bpf_map_free_fields_tab(map_meta);
 	btf_put(map_meta->btf);
 	kfree(map_meta);
 }
@@ -86,7 +93,7 @@ bool bpf_map_meta_equal(const struct bpf_map *meta0,
 		meta0->value_size == meta1->value_size &&
 		meta0->timer_off == meta1->timer_off &&
 		meta0->map_flags == meta1->map_flags &&
-		bpf_map_equal_kptr_off_tab(meta0, meta1);
+		btf_type_fields_equal(meta0->fields_tab, meta1->fields_tab);
 }
 
 void *bpf_map_fd_get_ptr(struct bpf_map *map,
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 7b373a5e861f..83e7a290ad06 100644
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
+struct btf_field *btf_type_fields_find(const struct btf_type_fields *tab, u32 offset,
+				       enum btf_field_type type)
 {
-	/* Since members are iterated in btf_find_field in increasing order,
-	 * offsets appended to kptr_off_tab are in increasing order, so we can
-	 * do bsearch to find exact match.
-	 */
-	struct bpf_map_value_off *tab;
+	struct btf_field *field;
 
-	if (!map_value_has_kptrs(map))
+	if (IS_ERR_OR_NULL(tab) || !(tab->field_mask & type))
+		return NULL;
+	field = bsearch(&offset, tab->fields, tab->cnt, sizeof(tab->fields[0]), btf_field_cmp);
+	if (!field || !(field->type & type))
 		return NULL;
-	tab = map->kptr_off_tab;
-	return bsearch(&offset, tab->off, tab->nr_off, sizeof(tab->off[0]), bpf_map_kptr_off_cmp);
+	return field;
 }
 
-void bpf_map_free_kptr_off_tab(struct bpf_map *map)
+void btf_type_fields_free(struct btf_type_fields *tab)
 {
-	struct bpf_map_value_off *tab = map->kptr_off_tab;
 	int i;
 
-	if (!map_value_has_kptrs(map))
+	if (IS_ERR_OR_NULL(tab))
 		return;
-	for (i = 0; i < tab->nr_off; i++) {
-		if (tab->off[i].kptr.module)
-			module_put(tab->off[i].kptr.module);
-		btf_put(tab->off[i].kptr.btf);
+	for (i = 0; i < tab->cnt; i++) {
+		switch (tab->fields[i].type) {
+		case BPF_KPTR_UNREF:
+		case BPF_KPTR_REF:
+			if (tab->fields[i].kptr.module)
+				module_put(tab->fields[i].kptr.module);
+			btf_put(tab->fields[i].kptr.btf);
+			break;
+		default:
+			WARN_ON_ONCE(1);
+			continue;
+		}
 	}
 	kfree(tab);
-	map->kptr_off_tab = NULL;
 }
 
-struct bpf_map_value_off *bpf_map_copy_kptr_off_tab(const struct bpf_map *map)
+void bpf_map_free_fields_tab(struct bpf_map *map)
+{
+	btf_type_fields_free(map->fields_tab);
+	map->fields_tab = NULL;
+}
+
+struct btf_type_fields *btf_type_fields_dup(const struct btf_type_fields *tab)
 {
-	struct bpf_map_value_off *tab = map->kptr_off_tab, *new_tab;
-	int size, i;
+	struct btf_type_fields *new_tab;
+	const struct btf_field *fields;
+	int ret, size, i;
 
-	if (!map_value_has_kptrs(map))
-		return ERR_PTR(-ENOENT);
-	size = offsetof(struct bpf_map_value_off, off[tab->nr_off]);
+	if (IS_ERR_OR_NULL(tab))
+		return NULL;
+	size = offsetof(struct btf_type_fields, fields[tab->cnt]);
 	new_tab = kmemdup(tab, size, GFP_KERNEL | __GFP_NOWARN);
 	if (!new_tab)
 		return ERR_PTR(-ENOMEM);
-	/* Do a deep copy of the kptr_off_tab */
-	for (i = 0; i < tab->nr_off; i++) {
-		btf_get(tab->off[i].kptr.btf);
-		if (tab->off[i].kptr.module && !try_module_get(tab->off[i].kptr.module)) {
-			while (i--) {
-				if (tab->off[i].kptr.module)
-					module_put(tab->off[i].kptr.module);
-				btf_put(tab->off[i].kptr.btf);
+	/* Do a deep copy of the fields_tab */
+	fields = tab->fields;
+	new_tab->cnt = 0;
+	for (i = 0; i < tab->cnt; i++) {
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
+		new_tab->cnt++;
 	}
 	return new_tab;
+free:
+	btf_type_fields_free(new_tab);
+	return ERR_PTR(ret);
 }
 
-bool bpf_map_equal_kptr_off_tab(const struct bpf_map *map_a, const struct bpf_map *map_b)
+bool btf_type_fields_equal(const struct btf_type_fields *tab_a, const struct btf_type_fields *tab_b)
 {
-	struct bpf_map_value_off *tab_a = map_a->kptr_off_tab, *tab_b = map_b->kptr_off_tab;
-	bool a_has_kptr = map_value_has_kptrs(map_a), b_has_kptr = map_value_has_kptrs(map_b);
+	bool a_has_fields = !IS_ERR_OR_NULL(tab_a), b_has_fields = !IS_ERR_OR_NULL(tab_b);
 	int size;
 
-	if (!a_has_kptr && !b_has_kptr)
+	if (!a_has_fields && !b_has_fields)
 		return true;
-	if (a_has_kptr != b_has_kptr)
+	if (a_has_fields != b_has_fields)
 		return false;
-	if (tab_a->nr_off != tab_b->nr_off)
+	if (tab_a->cnt != tab_b->cnt)
 		return false;
-	size = offsetof(struct bpf_map_value_off, off[tab_a->nr_off]);
+	size = offsetof(struct btf_type_fields, fields[tab_a->cnt]);
 	return !memcmp(tab_a, tab_b, size);
 }
 
-/* Caller must ensure map_value_has_kptrs is true. Note that this function can
- * be called on a map value while the map_value is visible to BPF programs, as
- * it ensures the correct synchronization, and we already enforce the same using
- * the bpf_kptr_xchg helper on the BPF program side for referenced kptrs.
- */
-void bpf_map_free_kptrs(struct bpf_map *map, void *map_value)
+void bpf_obj_free_fields(const struct btf_type_fields *tab, void *obj)
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
+	if (IS_ERR_OR_NULL(tab))
+		return;
+	fields = tab->fields;
+	for (i = 0; i < tab->cnt; i++) {
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
 
@@ -615,7 +635,7 @@ static void bpf_map_free_deferred(struct work_struct *work)
 	kfree(map->off_arr);
 	bpf_map_release_memcg(map);
 	/* implementation dependent freeing, map_free callback also does
-	 * bpf_map_free_kptr_off_tab, if needed.
+	 * bpf_map_free_fields_tab, if needed.
 	 */
 	map->ops->map_free(map);
 }
@@ -779,7 +799,7 @@ static int bpf_map_mmap(struct file *filp, struct vm_area_struct *vma)
 	int err;
 
 	if (!map->ops->map_mmap || map_value_has_spin_lock(map) ||
-	    map_value_has_timer(map) || map_value_has_kptrs(map))
+	    map_value_has_timer(map) || !IS_ERR_OR_NULL(map->fields_tab))
 		return -ENOTSUPP;
 
 	if (!(vma->vm_flags & VM_SHARED))
@@ -936,11 +956,11 @@ static int bpf_map_alloc_off_arr(struct bpf_map *map)
 {
 	bool has_spin_lock = map_value_has_spin_lock(map);
 	bool has_timer = map_value_has_timer(map);
-	bool has_kptrs = map_value_has_kptrs(map);
-	struct bpf_map_off_arr *off_arr;
+	bool has_fields = !IS_ERR_OR_NULL(map);
+	struct btf_type_fields_off *off_arr;
 	u32 i;
 
-	if (!has_spin_lock && !has_timer && !has_kptrs) {
+	if (!has_spin_lock && !has_timer && !has_fields) {
 		map->off_arr = NULL;
 		return 0;
 	}
@@ -965,16 +985,16 @@ static int bpf_map_alloc_off_arr(struct bpf_map *map)
 		off_arr->field_sz[i] = sizeof(struct bpf_timer);
 		off_arr->cnt++;
 	}
-	if (has_kptrs) {
-		struct bpf_map_value_off *tab = map->kptr_off_tab;
+	if (has_fields) {
+		struct btf_type_fields *tab = map->fields_tab;
 		u32 *off = &off_arr->field_off[off_arr->cnt];
 		u8 *sz = &off_arr->field_sz[off_arr->cnt];
 
-		for (i = 0; i < tab->nr_off; i++) {
-			*off++ = tab->off[i].offset;
-			*sz++ = sizeof(u64);
+		for (i = 0; i < tab->cnt; i++) {
+			*off++ = tab->fields[i].offset;
+			*sz++ = btf_field_type_size(tab->fields[i].type);
 		}
-		off_arr->cnt += tab->nr_off;
+		off_arr->cnt += tab->cnt;
 	}
 
 	if (off_arr->cnt == 1)
@@ -1037,8 +1057,10 @@ static int map_check_btf(struct bpf_map *map, const struct btf *btf,
 			return -EOPNOTSUPP;
 	}
 
-	map->kptr_off_tab = btf_parse_kptrs(btf, value_type);
-	if (map_value_has_kptrs(map)) {
+	map->fields_tab = btf_parse_fields(btf, value_type);
+	if (!IS_ERR_OR_NULL(map->fields_tab)) {
+		int i;
+
 		if (!bpf_capable()) {
 			ret = -EPERM;
 			goto free_map_tab;
@@ -1047,12 +1069,25 @@ static int map_check_btf(struct bpf_map *map, const struct btf *btf,
 			ret = -EACCES;
 			goto free_map_tab;
 		}
-		if (map->map_type != BPF_MAP_TYPE_HASH &&
-		    map->map_type != BPF_MAP_TYPE_LRU_HASH &&
-		    map->map_type != BPF_MAP_TYPE_ARRAY &&
-		    map->map_type != BPF_MAP_TYPE_PERCPU_ARRAY) {
-			ret = -EOPNOTSUPP;
-			goto free_map_tab;
+		for (i = 0; i < sizeof(map->fields_tab->field_mask) * 8; i++) {
+			switch (map->fields_tab->field_mask & (1 << i)) {
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
 
@@ -1064,7 +1099,7 @@ static int map_check_btf(struct bpf_map *map, const struct btf *btf,
 
 	return ret;
 free_map_tab:
-	bpf_map_free_kptr_off_tab(map);
+	bpf_map_free_fields_tab(map);
 	return ret;
 }
 
@@ -1882,7 +1917,7 @@ static int map_freeze(const union bpf_attr *attr)
 		return PTR_ERR(map);
 
 	if (map->map_type == BPF_MAP_TYPE_STRUCT_OPS ||
-	    map_value_has_timer(map) || map_value_has_kptrs(map)) {
+	    map_value_has_timer(map) || !IS_ERR_OR_NULL(map->fields_tab)) {
 		fdput(f);
 		return -ENOTSUPP;
 	}
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index c96419cf7033..9c375949804d 100644
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
+	struct btf_type_fields *tab;
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
+	if (IS_ERR_OR_NULL(map->fields_tab))
+		return 0;
+	tab = map->fields_tab;
+	for (i = 0; i < tab->cnt; i++) {
+		struct btf_field *field = &tab->fields[i];
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
+			kptr_field = btf_type_fields_find(reg->map_ptr->fields_tab,
+							  off + reg->var_off.value, BPF_KPTR);
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
+	if (!btf_type_fields_has_field(map_ptr->fields_tab, BPF_KPTR)) {
+		verbose(env, "map '%s' has no valid kptr\n", map_ptr->name);
 		return -EINVAL;
 	}
 
 	meta->map_ptr = map_ptr;
 	kptr_off = reg->off + reg->var_off.value;
-	off_desc = bpf_map_kptr_off_contains(map_ptr, kptr_off);
-	if (!off_desc) {
+	kptr_field = btf_type_fields_find(map_ptr->fields_tab, kptr_off, BPF_KPTR);
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
 
@@ -5798,7 +5796,7 @@ static int check_reg_type(struct bpf_verifier_env *env, u32 regno,
 		}
 
 		if (meta->func_id == BPF_FUNC_kptr_xchg) {
-			if (map_kptr_match_type(env, meta->kptr_off_desc, reg, regno))
+			if (map_kptr_match_type(env, meta->kptr_field, reg, regno))
 				return -EACCES;
 		} else {
 			if (arg_btf_id == BPF_PTR_POISON) {
@@ -7535,8 +7533,8 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
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
2.34.1

