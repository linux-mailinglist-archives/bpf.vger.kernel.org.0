Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E13F15AC670
	for <lists+bpf@lfdr.de>; Sun,  4 Sep 2022 22:42:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234994AbiIDUmR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 4 Sep 2022 16:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234585AbiIDUmN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 4 Sep 2022 16:42:13 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 422672D1D3
        for <bpf@vger.kernel.org>; Sun,  4 Sep 2022 13:42:05 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id s11so8995534edd.13
        for <bpf@vger.kernel.org>; Sun, 04 Sep 2022 13:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=kVJieqTKW9MooQVO4GkKbPpqQQblws1gw62NjLrj1AQ=;
        b=My7JOVnmVrf5pKx4GfNKZjaDvr7rmhW1hNx7BxjVqY2PUUSWfhJqtuUgniO88lyIzF
         FcqaagUzacruIr4IGUBvCEaGdsw0Om/hBji3rWO5frqe7Oe8O76W9GVVDtYPTnYlZEjn
         HJAiixGLt8z8TuDq3WaIm5Z0VajtmoaScc6VTXapEXfbFzHVoinlW+0m1NYKOeLnhkx+
         FEVcLGXVQC6Y5YkOC3p3ylIcTxCgDWn6x/KgXhf/15muVGRp1YP7vB4pUz9Ow2WBTeqD
         ++e3kd+WGJNs63u51QjKX61wPlfWoPRj5g8mwqc6HeTb3eqLIKoa+eQHW92KxUMoJ4Xg
         AqIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=kVJieqTKW9MooQVO4GkKbPpqQQblws1gw62NjLrj1AQ=;
        b=wp5QWfSfcjncXJFTp73ct04r25LiTNk1Koe/1foM+ZoTPOM7+JA0/dnm5jvHNjCFqf
         FKDUwE7dG73Riiv+PwAzBRDmera0fUcqrL9EMVrIFlShHZAVzZPK1Vzo2s7qHfiN5405
         Z9zZdEqA62RBumqBvMWtHQaRkB/DV3h5yT+mmSirplq3dw8zg8VTm89AM+H2ymzH0YXT
         E5e/mrL9Vh0zsTFXzwzb7U6rRYSv1kFi/bWr5tiQpLRu8/kOT+zx8/zC0l/Jq7QeX6HH
         bPxWI2vl19maExPb9BLPxJkByaDqIqJUxC2fGDs3+0grlccy9Ua21X6q8mfbN1ZLBTg4
         /T8g==
X-Gm-Message-State: ACgBeo1xlXdGutsomvfcYPntne0kcxx6F/Ysq5eZ/G7MH3ZqzCp+1cwM
        P5LfmFwpSYlRlC61fF7R+RqDaSsurJL2Vg==
X-Google-Smtp-Source: AA6agR4d2AsFZURFPuTEBDu19nJL7leZBpLbxa87JUgVMEpGACRdH+X7/q7plfk9zXnK/wWY4MJjpA==
X-Received: by 2002:a05:6402:34cd:b0:448:8286:23f0 with SMTP id w13-20020a05640234cd00b00448828623f0mr27045913edc.40.1662324123052;
        Sun, 04 Sep 2022 13:42:03 -0700 (PDT)
Received: from localhost (212.191.202.62.dynamic.cgnat.res.cust.swisscom.ch. [62.202.191.212])
        by smtp.gmail.com with ESMTPSA id le6-20020a170907170600b0073306218484sm4091450ejc.26.2022.09.04.13.42.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Sep 2022 13:42:02 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Delyan Kratunov <delyank@fb.com>
Subject: [PATCH RFC bpf-next v1 13/32] bpf: Introduce bpf_list_head support for BPF maps
Date:   Sun,  4 Sep 2022 22:41:26 +0200
Message-Id: <20220904204145.3089-14-memxor@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220904204145.3089-1-memxor@gmail.com>
References: <20220904204145.3089-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=27684; i=memxor@gmail.com; h=from:subject; bh=zGIJVlfJHFZ4tTD+ZFBMpFFIILEKghBvD4Kt90M1h94=; b=owEBbQKS/ZANAwAKAUzgyIZIvxHKAcsmYgBjFQ1wl/hLU91aL6MJf/ykrVyZ6rvC9siyInM4OGdn hxkpzbOJAjMEAAEKAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYxUNcAAKCRBM4MiGSL8Rynn9EA CRDWIMQD1oBcOP2PkwnurqpBFj+clIH7hJRxDgNJBwm2t935dzooWyAwP8Ul2jACni3sddMtoB2JAP yZN6JsvDXQyW2Fa4XCnWpRuTCzgTtcPCbNKt2eRp6FsZpxuRFdEVB1dbrKr9Lj78Yji867T6AD2NiZ +CuKhlaWsrKFHxk5g/boBNHeqwQn7sOtlg7q7+YRXBzHkvlMe0Me0+jAQhYFkC9oBuDUs8xXlePM9m pOY0TPbqIIL/NU+6ffxkncg6Ho+A/v2rjWuj81IQvJhg7eqOWofc1e4Miwbi5qHSlDZHDg7IEqtQZf 7wxkBOe9ZYMFJOsHyR7NVulxAlpdqIdR+d6tDEqne2PTp4myKZa8BT2+b8dGUsGs0kRUkCKkGDeljc GVPwLDtWFGLgx7kiPyllx+sY4dyAnIiVmipAqC7Fg/B+mmfEIdFiMdpI0NWRrpkPTZiIw501JPhW15 blKn8MlUtfP2xXw3aOlkPpnsKsGuz69Jj/XMW106e8KoWhFakP7jucfMioXEkaL/EILhfCCjFL+dzx W7gYcPWCnESl/KKTN7aTveAv6SIiV6boeYMPB9EzrSx1U72fRFs5fmpj7MObe8vRK/IYaA0ZdBY45A U5p0E1Ws0sHjUfsVhYnci8goW1reX1ZJI8PSdluk4IYAd3rRrBjOgurXIeFA==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add the basic support on the map side to parse, recognize, verify, and
build metadata table for a new special field of the type struct
bpf_list_head. To parameterize the bpf_list_head for a certain value
type and the list_node member it will accept in that value type, we use
BTF declaration tags.

The definition of bpf_list_head in a map value will be done as follows:

struct foo {
	int data;
	struct bpf_list_node list;
};

struct map_value {
	struct bpf_list_head list __contains(struct, foo, node);
};

Then, the bpf_list_head only allows adding to the list using the
bpf_list_node 'list' for the type struct foo.

The 'contains' annotation is a BTF declaration tag composed of four
parts, "contains:kind:name:node" where the kind and name is then used to
look up the type in the map BTF. The node defines name of the member in
this type that has the type struct bpf_list_node, which is actually used
for linking into the linked list.

This allows building intrusive linked lists in BPF, using container_of
to obtain pointer to entry, while being completely type safe from the
perspective of the verifier. The verifier knows exactly the type of the
nodes, and knows that list helpers return that type at some fixed offset
where the bpf_list_node member used for this list exists. The verifier
also uses this information to disallow adding types that are not
accepted by a certain list.

For now, no elements can be added to such lists. Support for that is
coming in future patches, hence draining and freeing items is left out
for now, and just freeing the list_head_off_tab is done, since it is
still built and populated when bpf_list_head is specified in the map
value.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf.h                           |  64 +++++--
 include/linux/btf.h                           |   2 +
 kernel/bpf/arraymap.c                         |   2 +
 kernel/bpf/bpf_local_storage.c                |   1 +
 kernel/bpf/btf.c                              | 173 +++++++++++++++++-
 kernel/bpf/hashtab.c                          |   1 +
 kernel/bpf/map_in_map.c                       |   5 +-
 kernel/bpf/syscall.c                          | 131 +++++++++++--
 kernel/bpf/verifier.c                         |  21 +++
 .../testing/selftests/bpf/bpf_experimental.h  |  21 +++
 10 files changed, 378 insertions(+), 43 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/bpf_experimental.h

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index d4e6bf789c02..35c2e9caeb98 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -28,6 +28,9 @@
 #include <linux/btf.h>
 #include <linux/rcupdate_trace.h>
 
+/* Experimental BPF APIs header for type definitions */
+#include "../../../tools/testing/selftests/bpf/bpf_experimental.h"
+
 struct bpf_verifier_env;
 struct bpf_verifier_log;
 struct perf_event;
@@ -164,27 +167,40 @@ struct bpf_map_ops {
 };
 
 enum {
-	/* Support at most 8 pointers in a BPF map value */
-	BPF_MAP_VALUE_OFF_MAX = 8,
-	BPF_MAP_OFF_ARR_MAX   = BPF_MAP_VALUE_OFF_MAX +
-				1 + /* for bpf_spin_lock */
-				1,  /* for bpf_timer */
-};
-
-enum bpf_kptr_type {
+	/* Support at most 8 offsets in a table */
+	BPF_MAP_VALUE_OFF_MAX		= 8,
+	/* Support at most 8 pointer in a BPF map value */
+	BPF_MAP_VALUE_KPTR_MAX		= BPF_MAP_VALUE_OFF_MAX,
+	/* Support at most 8 list_head in a BPF map value */
+	BPF_MAP_VALUE_LIST_HEAD_MAX	= BPF_MAP_VALUE_OFF_MAX,
+	BPF_MAP_OFF_ARR_MAX		= BPF_MAP_VALUE_KPTR_MAX +
+					  BPF_MAP_VALUE_LIST_HEAD_MAX +
+					  1 + /* for bpf_spin_lock */
+					  1,  /* for bpf_timer */
+};
+
+enum bpf_off_type {
 	BPF_KPTR_UNREF,
 	BPF_KPTR_REF,
+	BPF_LIST_HEAD,
 };
 
 struct bpf_map_value_off_desc {
 	u32 offset;
-	enum bpf_kptr_type type;
-	struct {
-		struct btf *btf;
-		struct module *module;
-		btf_dtor_kfunc_t dtor;
-		u32 btf_id;
-	} kptr;
+	enum bpf_off_type type;
+	union {
+		struct {
+			struct btf *btf;
+			struct module *module;
+			btf_dtor_kfunc_t dtor;
+			u32 btf_id;
+		} kptr; /* for BPF_KPTR_{UNREF,REF} */
+		struct {
+			struct btf *btf;
+			u32 value_type_id;
+			u32 list_node_off;
+		} list_head; /* for BPF_LIST_HEAD */
+	};
 };
 
 struct bpf_map_value_off {
@@ -215,6 +231,7 @@ struct bpf_map {
 	u32 map_flags;
 	int spin_lock_off; /* >=0 valid offset, <0 error */
 	struct bpf_map_value_off *kptr_off_tab;
+	struct bpf_map_value_off *list_head_off_tab;
 	int timer_off; /* >=0 valid offset, <0 error */
 	u32 id;
 	int numa_node;
@@ -265,6 +282,11 @@ static inline bool map_value_has_kptrs(const struct bpf_map *map)
 	return !IS_ERR_OR_NULL(map->kptr_off_tab);
 }
 
+static inline bool map_value_has_list_heads(const struct bpf_map *map)
+{
+	return !IS_ERR_OR_NULL(map->list_head_off_tab);
+}
+
 static inline void check_and_init_map_value(struct bpf_map *map, void *dst)
 {
 	if (unlikely(map_value_has_spin_lock(map)))
@@ -278,6 +300,13 @@ static inline void check_and_init_map_value(struct bpf_map *map, void *dst)
 		for (i = 0; i < tab->nr_off; i++)
 			*(u64 *)(dst + tab->off[i].offset) = 0;
 	}
+	if (unlikely(map_value_has_list_heads(map))) {
+		struct bpf_map_value_off *tab = map->list_head_off_tab;
+		int i;
+
+		for (i = 0; i < tab->nr_off; i++)
+			memset(dst + tab->off[i].offset, 0, sizeof(struct list_head));
+	}
 }
 
 /* memcpy that is used with 8-byte aligned pointers, power-of-8 size and
@@ -1676,6 +1705,11 @@ struct bpf_map_value_off *bpf_map_copy_kptr_off_tab(const struct bpf_map *map);
 bool bpf_map_equal_kptr_off_tab(const struct bpf_map *map_a, const struct bpf_map *map_b);
 void bpf_map_free_kptrs(struct bpf_map *map, void *map_value);
 
+struct bpf_map_value_off_desc *bpf_map_list_head_off_contains(struct bpf_map *map, u32 offset);
+void bpf_map_free_list_head_off_tab(struct bpf_map *map);
+struct bpf_map_value_off *bpf_map_copy_list_head_off_tab(const struct bpf_map *map);
+bool bpf_map_equal_list_head_off_tab(const struct bpf_map *map_a, const struct bpf_map *map_b);
+
 struct bpf_map *bpf_map_get(u32 ufd);
 struct bpf_map *bpf_map_get_with_uref(u32 ufd);
 struct bpf_map *__bpf_map_get(struct fd f);
diff --git a/include/linux/btf.h b/include/linux/btf.h
index 8062f9da7c40..9b62b8b2117e 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -156,6 +156,8 @@ int btf_find_spin_lock(const struct btf *btf, const struct btf_type *t);
 int btf_find_timer(const struct btf *btf, const struct btf_type *t);
 struct bpf_map_value_off *btf_parse_kptrs(const struct btf *btf,
 					  const struct btf_type *t);
+struct bpf_map_value_off *btf_parse_list_heads(struct btf *btf,
+					       const struct btf_type *t);
 bool btf_type_is_void(const struct btf_type *t);
 s32 btf_find_by_name_kind(const struct btf *btf, const char *name, u8 kind);
 const struct btf_type *btf_type_skip_modifiers(const struct btf *btf,
diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
index 832b2659e96e..c7263ee3a35f 100644
--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -423,6 +423,8 @@ static void array_map_free(struct bpf_map *map)
 	struct bpf_array *array = container_of(map, struct bpf_array, map);
 	int i;
 
+	bpf_map_free_list_head_off_tab(map);
+
 	if (map_value_has_kptrs(map)) {
 		if (array->map.map_type == BPF_MAP_TYPE_PERCPU_ARRAY) {
 			for (i = 0; i < array->map.max_entries; i++) {
diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
index 58cb0c179097..b5ccd76026b6 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -616,6 +616,7 @@ void bpf_local_storage_map_free(struct bpf_local_storage_map *smap,
 		rcu_barrier();
 		bpf_map_free_kptr_off_tab(&smap->map);
 	}
+	bpf_map_free_list_head_off_tab(&smap->map);
 	kvfree(smap->buckets);
 	bpf_map_area_free(smap);
 }
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 6740c3ade8f1..0fb045be3837 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -3185,6 +3185,7 @@ enum btf_field_type {
 	BTF_FIELD_SPIN_LOCK,
 	BTF_FIELD_TIMER,
 	BTF_FIELD_KPTR,
+	BTF_FIELD_LIST_HEAD,
 };
 
 enum {
@@ -3193,9 +3194,17 @@ enum {
 };
 
 struct btf_field_info {
-	u32 type_id;
 	u32 off;
-	enum bpf_kptr_type type;
+	union {
+		struct {
+			u32 type_id;
+			enum bpf_off_type type;
+		} kptr;
+		struct {
+			u32 value_type_id;
+			const char *node_name;
+		} list_head;
+	};
 };
 
 static int btf_find_struct(const struct btf *btf, const struct btf_type *t,
@@ -3212,7 +3221,7 @@ static int btf_find_struct(const struct btf *btf, const struct btf_type *t,
 static int btf_find_kptr(const struct btf *btf, const struct btf_type *t,
 			 u32 off, int sz, struct btf_field_info *info)
 {
-	enum bpf_kptr_type type;
+	enum bpf_off_type type;
 	u32 res_id;
 
 	/* Permit modifiers on the pointer itself */
@@ -3241,9 +3250,71 @@ static int btf_find_kptr(const struct btf *btf, const struct btf_type *t,
 	if (!__btf_type_is_struct(t))
 		return -EINVAL;
 
-	info->type_id = res_id;
 	info->off = off;
-	info->type = type;
+	info->kptr.type_id = res_id;
+	info->kptr.type = type;
+	return BTF_FIELD_FOUND;
+}
+
+static const char *btf_find_decl_tag_value(const struct btf *btf,
+					   const struct btf_type *pt,
+					   int comp_idx, const char *tag_key)
+{
+	int i;
+
+	for (i = 1; i < btf_nr_types(btf); i++) {
+		const struct btf_type *t = btf_type_by_id(btf, i);
+		int len = strlen(tag_key);
+
+		if (!btf_type_is_decl_tag(t))
+			continue;
+		/* TODO: Instead of btf_type pt, it would be much better if we had BTF
+		 * ID of the map value type. This would avoid btf_type_by_id call here.
+		 */
+		if (pt != btf_type_by_id(btf, t->type) ||
+		    btf_type_decl_tag(t)->component_idx != comp_idx)
+			continue;
+		if (strncmp(__btf_name_by_offset(btf, t->name_off), tag_key, len))
+			continue;
+		return __btf_name_by_offset(btf, t->name_off) + len;
+	}
+	return NULL;
+}
+
+static int btf_find_list_head(const struct btf *btf, const struct btf_type *pt,
+			      int comp_idx, const struct btf_type *t,
+			      u32 off, int sz, struct btf_field_info *info)
+{
+	const char *value_type;
+	const char *list_node;
+	s32 id;
+
+	if (!__btf_type_is_struct(t))
+		return BTF_FIELD_IGNORE;
+	if (t->size != sz)
+		return BTF_FIELD_IGNORE;
+	value_type = btf_find_decl_tag_value(btf, pt, comp_idx, "contains:");
+	if (!value_type)
+		return -EINVAL;
+	if (strncmp(value_type, "struct:", sizeof("struct:") - 1))
+		return -EINVAL;
+	value_type += sizeof("struct:") - 1;
+	list_node = strstr(value_type, ":");
+	if (!list_node)
+		return -EINVAL;
+	value_type = kstrndup(value_type, list_node - value_type, GFP_ATOMIC);
+	if (!value_type)
+		return -ENOMEM;
+	id = btf_find_by_name_kind(btf, value_type, BTF_KIND_STRUCT);
+	kfree(value_type);
+	if (id < 0)
+		return id;
+	list_node++;
+	if (str_is_empty(list_node))
+		return -EINVAL;
+	info->off = off;
+	info->list_head.value_type_id = id;
+	info->list_head.node_name = list_node;
 	return BTF_FIELD_FOUND;
 }
 
@@ -3286,6 +3357,12 @@ static int btf_find_struct_field(const struct btf *btf, const struct btf_type *t
 			if (ret < 0)
 				return ret;
 			break;
+		case BTF_FIELD_LIST_HEAD:
+			ret = btf_find_list_head(btf, t, i, member_type, off, sz,
+						 idx < info_cnt ? &info[idx] : &tmp);
+			if (ret < 0)
+				return ret;
+			break;
 		default:
 			return -EFAULT;
 		}
@@ -3336,6 +3413,12 @@ static int btf_find_datasec_var(const struct btf *btf, const struct btf_type *t,
 			if (ret < 0)
 				return ret;
 			break;
+		case BTF_FIELD_LIST_HEAD:
+			ret = btf_find_list_head(btf, var, -1, var_type, off, sz,
+						 idx < info_cnt ? &info[idx] : &tmp);
+			if (ret < 0)
+				return ret;
+			break;
 		default:
 			return -EFAULT;
 		}
@@ -3372,6 +3455,11 @@ static int btf_find_field(const struct btf *btf, const struct btf_type *t,
 		sz = sizeof(u64);
 		align = 8;
 		break;
+	case BTF_FIELD_LIST_HEAD:
+		name = "bpf_list_head";
+		sz = sizeof(struct bpf_list_head);
+		align = __alignof__(struct bpf_list_head);
+		break;
 	default:
 		return -EFAULT;
 	}
@@ -3440,7 +3528,7 @@ struct bpf_map_value_off *btf_parse_kptrs(const struct btf *btf,
 		/* Find type in map BTF, and use it to look up the matching type
 		 * in vmlinux or module BTFs, by name and kind.
 		 */
-		t = btf_type_by_id(btf, info_arr[i].type_id);
+		t = btf_type_by_id(btf, info_arr[i].kptr.type_id);
 		id = bpf_find_btf_id(__btf_name_by_offset(btf, t->name_off), BTF_INFO_KIND(t->info),
 				     &kernel_btf);
 		if (id < 0) {
@@ -3451,7 +3539,7 @@ struct bpf_map_value_off *btf_parse_kptrs(const struct btf *btf,
 		/* Find and stash the function pointer for the destruction function that
 		 * needs to be eventually invoked from the map free path.
 		 */
-		if (info_arr[i].type == BPF_KPTR_REF) {
+		if (info_arr[i].kptr.type == BPF_KPTR_REF) {
 			const struct btf_type *dtor_func;
 			const char *dtor_func_name;
 			unsigned long addr;
@@ -3494,7 +3582,7 @@ struct bpf_map_value_off *btf_parse_kptrs(const struct btf *btf,
 		}
 
 		tab->off[i].offset = info_arr[i].off;
-		tab->off[i].type = info_arr[i].type;
+		tab->off[i].type = info_arr[i].kptr.type;
 		tab->off[i].kptr.btf_id = id;
 		tab->off[i].kptr.btf = kernel_btf;
 		tab->off[i].kptr.module = mod;
@@ -3515,6 +3603,75 @@ struct bpf_map_value_off *btf_parse_kptrs(const struct btf *btf,
 	return ERR_PTR(ret);
 }
 
+struct bpf_map_value_off *btf_parse_list_heads(struct btf *btf, const struct btf_type *t)
+{
+	struct btf_field_info info_arr[BPF_MAP_VALUE_OFF_MAX];
+	struct bpf_map_value_off *tab;
+	int ret, i, nr_off;
+
+	ret = btf_find_field(btf, t, BTF_FIELD_LIST_HEAD, info_arr, ARRAY_SIZE(info_arr));
+	if (ret < 0)
+		return ERR_PTR(ret);
+	if (!ret)
+		return NULL;
+
+	nr_off = ret;
+	tab = kzalloc(offsetof(struct bpf_map_value_off, off[nr_off]), GFP_KERNEL | __GFP_NOWARN);
+	if (!tab)
+		return ERR_PTR(-ENOMEM);
+
+	for (i = 0; i < nr_off; i++) {
+		const struct btf_type *t, *n = NULL;
+		const struct btf_member *member;
+		u32 offset;
+		int j;
+
+		t = btf_type_by_id(btf, info_arr[i].list_head.value_type_id);
+		/* We've already checked that value_type_id is a struct type. We
+		 * just need to figure out the offset of the list_node, and
+		 * verify its type.
+		 */
+		ret = -EINVAL;
+		for_each_member(j, t, member) {
+			if (strcmp(info_arr[i].list_head.node_name, __btf_name_by_offset(btf, member->name_off)))
+				continue;
+			/* Invalid BTF, two members with same name */
+			if (n) {
+				/* We also need to btf_put for the current iteration! */
+				i++;
+				goto end;
+			}
+			n = btf_type_by_id(btf, member->type);
+			if (!__btf_type_is_struct(n))
+				goto end;
+			if (strcmp("bpf_list_node", __btf_name_by_offset(btf, n->name_off)))
+				goto end;
+			offset = __btf_member_bit_offset(n, member);
+			if (offset % 8)
+				goto end;
+			offset /= 8;
+			if (offset % __alignof__(struct bpf_list_node))
+				goto end;
+
+			tab->off[i].offset = info_arr[i].off;
+			tab->off[i].type = BPF_LIST_HEAD;
+			btf_get(btf);
+			tab->off[i].list_head.btf = btf;
+			tab->off[i].list_head.value_type_id = info_arr[i].list_head.value_type_id;
+			tab->off[i].list_head.list_node_off = offset;
+		}
+		if (!n)
+			goto end;
+	}
+	tab->nr_off = nr_off;
+	return tab;
+end:
+	while (i--)
+		btf_put(tab->off[i].list_head.btf);
+	kfree(tab);
+	return ERR_PTR(ret);
+}
+
 static void __btf_struct_show(const struct btf *btf, const struct btf_type *t,
 			      u32 type_id, void *data, u8 bits_offset,
 			      struct btf_show *show)
diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index bb3f8a63c221..270e0ecf4ba3 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -1518,6 +1518,7 @@ static void htab_map_free(struct bpf_map *map)
 		prealloc_destroy(htab);
 	}
 
+	bpf_map_free_list_head_off_tab(map);
 	bpf_map_free_kptr_off_tab(map);
 	free_percpu(htab->extra_elems);
 	bpf_map_area_free(htab->buckets);
diff --git a/kernel/bpf/map_in_map.c b/kernel/bpf/map_in_map.c
index 135205d0d560..ced2559129ab 100644
--- a/kernel/bpf/map_in_map.c
+++ b/kernel/bpf/map_in_map.c
@@ -53,6 +53,7 @@ struct bpf_map *bpf_map_meta_alloc(int inner_map_ufd)
 	inner_map_meta->spin_lock_off = inner_map->spin_lock_off;
 	inner_map_meta->timer_off = inner_map->timer_off;
 	inner_map_meta->kptr_off_tab = bpf_map_copy_kptr_off_tab(inner_map);
+	inner_map_meta->list_head_off_tab = bpf_map_copy_list_head_off_tab(inner_map);
 	if (inner_map->btf) {
 		btf_get(inner_map->btf);
 		inner_map_meta->btf = inner_map->btf;
@@ -72,6 +73,7 @@ struct bpf_map *bpf_map_meta_alloc(int inner_map_ufd)
 
 void bpf_map_meta_free(struct bpf_map *map_meta)
 {
+	bpf_map_free_list_head_off_tab(map_meta);
 	bpf_map_free_kptr_off_tab(map_meta);
 	btf_put(map_meta->btf);
 	kfree(map_meta);
@@ -86,7 +88,8 @@ bool bpf_map_meta_equal(const struct bpf_map *meta0,
 		meta0->value_size == meta1->value_size &&
 		meta0->timer_off == meta1->timer_off &&
 		meta0->map_flags == meta1->map_flags &&
-		bpf_map_equal_kptr_off_tab(meta0, meta1);
+		bpf_map_equal_kptr_off_tab(meta0, meta1) &&
+		bpf_map_equal_list_head_off_tab(meta0, meta1);
 }
 
 void *bpf_map_fd_get_ptr(struct bpf_map *map,
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 0311acca19f6..e1749e0d2143 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -495,7 +495,7 @@ static void bpf_map_release_memcg(struct bpf_map *map)
 }
 #endif
 
-static int bpf_map_kptr_off_cmp(const void *a, const void *b)
+static int bpf_map_off_cmp(const void *a, const void *b)
 {
 	const struct bpf_map_value_off_desc *off_desc1 = a, *off_desc2 = b;
 
@@ -506,18 +506,22 @@ static int bpf_map_kptr_off_cmp(const void *a, const void *b)
 	return 0;
 }
 
-struct bpf_map_value_off_desc *bpf_map_kptr_off_contains(struct bpf_map *map, u32 offset)
+static struct bpf_map_value_off_desc *
+__bpf_map_off_contains(struct bpf_map_value_off *off_tab, u32 offset)
 {
 	/* Since members are iterated in btf_find_field in increasing order,
-	 * offsets appended to kptr_off_tab are in increasing order, so we can
+	 * offsets appended to an off_tab are in increasing order, so we can
 	 * do bsearch to find exact match.
 	 */
-	struct bpf_map_value_off *tab;
+	return bsearch(&offset, off_tab->off, off_tab->nr_off, sizeof(off_tab->off[0]),
+		       bpf_map_off_cmp);
+}
 
+struct bpf_map_value_off_desc *bpf_map_kptr_off_contains(struct bpf_map *map, u32 offset)
+{
 	if (!map_value_has_kptrs(map))
 		return NULL;
-	tab = map->kptr_off_tab;
-	return bsearch(&offset, tab->off, tab->nr_off, sizeof(tab->off[0]), bpf_map_kptr_off_cmp);
+	return __bpf_map_off_contains(map->kptr_off_tab, offset);
 }
 
 void bpf_map_free_kptr_off_tab(struct bpf_map *map)
@@ -563,15 +567,15 @@ struct bpf_map_value_off *bpf_map_copy_kptr_off_tab(const struct bpf_map *map)
 	return new_tab;
 }
 
-bool bpf_map_equal_kptr_off_tab(const struct bpf_map *map_a, const struct bpf_map *map_b)
+static bool __bpf_map_equal_off_tab(const struct bpf_map_value_off *tab_a,
+				    const struct bpf_map_value_off *tab_b,
+				    bool has_a, bool has_b)
 {
-	struct bpf_map_value_off *tab_a = map_a->kptr_off_tab, *tab_b = map_b->kptr_off_tab;
-	bool a_has_kptr = map_value_has_kptrs(map_a), b_has_kptr = map_value_has_kptrs(map_b);
 	int size;
 
-	if (!a_has_kptr && !b_has_kptr)
+	if (!has_a && !has_b)
 		return true;
-	if (a_has_kptr != b_has_kptr)
+	if (has_a != has_b)
 		return false;
 	if (tab_a->nr_off != tab_b->nr_off)
 		return false;
@@ -579,6 +583,13 @@ bool bpf_map_equal_kptr_off_tab(const struct bpf_map *map_a, const struct bpf_ma
 	return !memcmp(tab_a, tab_b, size);
 }
 
+bool bpf_map_equal_kptr_off_tab(const struct bpf_map *map_a, const struct bpf_map *map_b)
+{
+	return __bpf_map_equal_off_tab(map_a->kptr_off_tab, map_b->kptr_off_tab,
+				       map_value_has_kptrs(map_a),
+				       map_value_has_kptrs(map_b));
+}
+
 /* Caller must ensure map_value_has_kptrs is true. Note that this function can
  * be called on a map value while the map_value is visible to BPF programs, as
  * it ensures the correct synchronization, and we already enforce the same using
@@ -606,6 +617,50 @@ void bpf_map_free_kptrs(struct bpf_map *map, void *map_value)
 	}
 }
 
+struct bpf_map_value_off_desc *bpf_map_list_head_off_contains(struct bpf_map *map, u32 offset)
+{
+	if (!map_value_has_list_heads(map))
+		return NULL;
+	return __bpf_map_off_contains(map->list_head_off_tab, offset);
+}
+
+void bpf_map_free_list_head_off_tab(struct bpf_map *map)
+{
+	struct bpf_map_value_off *tab = map->list_head_off_tab;
+	int i;
+
+	if (!map_value_has_list_heads(map))
+		return;
+	for (i = 0; i < tab->nr_off; i++)
+		btf_put(tab->off[i].list_head.btf);
+	kfree(tab);
+	map->list_head_off_tab = NULL;
+}
+
+struct bpf_map_value_off *bpf_map_copy_list_head_off_tab(const struct bpf_map *map)
+{
+	struct bpf_map_value_off *tab = map->list_head_off_tab, *new_tab;
+	int size, i;
+
+	if (!map_value_has_list_heads(map))
+		return ERR_PTR(-ENOENT);
+	size = offsetof(struct bpf_map_value_off, off[tab->nr_off]);
+	new_tab = kmemdup(tab, size, GFP_KERNEL | __GFP_NOWARN);
+	if (!new_tab)
+		return ERR_PTR(-ENOMEM);
+	/* Do a deep copy of the list_head_off_tab */
+	for (i = 0; i < tab->nr_off; i++)
+		btf_get(tab->off[i].list_head.btf);
+	return new_tab;
+}
+
+bool bpf_map_equal_list_head_off_tab(const struct bpf_map *map_a, const struct bpf_map *map_b)
+{
+	return __bpf_map_equal_off_tab(map_a->list_head_off_tab, map_b->list_head_off_tab,
+				       map_value_has_list_heads(map_a),
+				       map_value_has_list_heads(map_b));
+}
+
 /* called from workqueue */
 static void bpf_map_free_deferred(struct work_struct *work)
 {
@@ -776,7 +831,8 @@ static int bpf_map_mmap(struct file *filp, struct vm_area_struct *vma)
 	int err;
 
 	if (!map->ops->map_mmap || map_value_has_spin_lock(map) ||
-	    map_value_has_timer(map) || map_value_has_kptrs(map))
+	    map_value_has_timer(map) || map_value_has_kptrs(map) ||
+	    map_value_has_list_heads(map))
 		return -ENOTSUPP;
 
 	if (!(vma->vm_flags & VM_SHARED))
@@ -931,13 +987,14 @@ static void map_off_arr_swap(void *_a, void *_b, int size, const void *priv)
 
 static int bpf_map_alloc_off_arr(struct bpf_map *map)
 {
+	bool has_list_heads = map_value_has_list_heads(map);
 	bool has_spin_lock = map_value_has_spin_lock(map);
 	bool has_timer = map_value_has_timer(map);
 	bool has_kptrs = map_value_has_kptrs(map);
 	struct bpf_map_off_arr *off_arr;
 	u32 i;
 
-	if (!has_spin_lock && !has_timer && !has_kptrs) {
+	if (!has_spin_lock && !has_timer && !has_kptrs && !has_list_heads) {
 		map->off_arr = NULL;
 		return 0;
 	}
@@ -973,6 +1030,17 @@ static int bpf_map_alloc_off_arr(struct bpf_map *map)
 		}
 		off_arr->cnt += tab->nr_off;
 	}
+	if (has_list_heads) {
+		struct bpf_map_value_off *tab = map->list_head_off_tab;
+		u32 *off = &off_arr->field_off[off_arr->cnt];
+		u8 *sz = &off_arr->field_sz[off_arr->cnt];
+
+		for (i = 0; i < tab->nr_off; i++) {
+			*off++ = tab->off[i].offset;
+			*sz++ = sizeof(struct bpf_list_head);
+		}
+		off_arr->cnt += tab->nr_off;
+	}
 
 	if (off_arr->cnt == 1)
 		return 0;
@@ -1038,11 +1106,11 @@ static int map_check_btf(struct bpf_map *map, const struct btf *btf,
 	if (map_value_has_kptrs(map)) {
 		if (!bpf_capable()) {
 			ret = -EPERM;
-			goto free_map_tab;
+			goto free_map_kptr_tab;
 		}
 		if (map->map_flags & (BPF_F_RDONLY_PROG | BPF_F_WRONLY_PROG)) {
 			ret = -EACCES;
-			goto free_map_tab;
+			goto free_map_kptr_tab;
 		}
 		if (map->map_type != BPF_MAP_TYPE_HASH &&
 		    map->map_type != BPF_MAP_TYPE_PERCPU_HASH &&
@@ -1054,18 +1122,42 @@ static int map_check_btf(struct bpf_map *map, const struct btf *btf,
 		    map->map_type != BPF_MAP_TYPE_INODE_STORAGE &&
 		    map->map_type != BPF_MAP_TYPE_TASK_STORAGE) {
 			ret = -EOPNOTSUPP;
-			goto free_map_tab;
+			goto free_map_kptr_tab;
+		}
+	}
+
+	/* We need to take ref on the BTF, so pass it as non-const */
+	map->list_head_off_tab = btf_parse_list_heads((struct btf *)btf, value_type);
+	if (map_value_has_list_heads(map)) {
+		if (!bpf_capable()) {
+			ret = -EACCES;
+			goto free_map_list_head_tab;
+		}
+		if (map->map_flags & (BPF_F_RDONLY_PROG | BPF_F_WRONLY_PROG)) {
+			ret = -EACCES;
+			goto free_map_list_head_tab;
+		}
+		if (map->map_type != BPF_MAP_TYPE_HASH &&
+		    map->map_type != BPF_MAP_TYPE_LRU_HASH &&
+		    map->map_type != BPF_MAP_TYPE_ARRAY &&
+		    map->map_type != BPF_MAP_TYPE_SK_STORAGE &&
+		    map->map_type != BPF_MAP_TYPE_INODE_STORAGE &&
+		    map->map_type != BPF_MAP_TYPE_TASK_STORAGE) {
+			ret = -EOPNOTSUPP;
+			goto free_map_list_head_tab;
 		}
 	}
 
 	if (map->ops->map_check_btf) {
 		ret = map->ops->map_check_btf(map, btf, key_type, value_type);
 		if (ret < 0)
-			goto free_map_tab;
+			goto free_map_list_head_tab;
 	}
 
 	return ret;
-free_map_tab:
+free_map_list_head_tab:
+	bpf_map_free_list_head_off_tab(map);
+free_map_kptr_tab:
 	bpf_map_free_kptr_off_tab(map);
 	return ret;
 }
@@ -1889,7 +1981,8 @@ static int map_freeze(const union bpf_attr *attr)
 		return PTR_ERR(map);
 
 	if (map->map_type == BPF_MAP_TYPE_STRUCT_OPS ||
-	    map_value_has_timer(map) || map_value_has_kptrs(map)) {
+	    map_value_has_timer(map) || map_value_has_kptrs(map) ||
+	    map_value_has_list_heads(map)) {
 		fdput(f);
 		return -ENOTSUPP;
 	}
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 571790ac58d4..ab91e5ca7e41 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3879,6 +3879,20 @@ static int check_map_access(struct bpf_verifier_env *env, u32 regno,
 			}
 		}
 	}
+	if (map_value_has_list_heads(map)) {
+		struct bpf_map_value_off *tab = map->list_head_off_tab;
+		int i;
+
+		for (i = 0; i < tab->nr_off; i++) {
+			u32 p = tab->off[i].offset;
+
+			if (reg->smin_value + off < p + sizeof(struct bpf_list_head) &&
+			    p < reg->umax_value + off + size) {
+				verbose(env, "bpf_list_head cannot be accessed directly by load/store\n");
+				return -EACCES;
+			}
+		}
+	}
 	return err;
 }
 
@@ -13165,6 +13179,13 @@ static int check_map_prog_compatibility(struct bpf_verifier_env *env,
 		}
 	}
 
+	if (map_value_has_list_heads(map)) {
+		if (is_tracing_prog_type(prog_type)) {
+			verbose(env, "tracing progs cannot use bpf_list_head yet\n");
+			return -EINVAL;
+		}
+	}
+
 	if ((bpf_prog_is_dev_bound(prog->aux) || bpf_map_is_dev_bound(map)) &&
 	    !bpf_offload_prog_map_match(prog, map)) {
 		verbose(env, "offload device mismatch between prog and map\n");
diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
new file mode 100644
index 000000000000..ea1b3b1839d1
--- /dev/null
+++ b/tools/testing/selftests/bpf/bpf_experimental.h
@@ -0,0 +1,21 @@
+#ifndef __KERNEL__
+
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_helpers.h>
+
+#else
+
+struct bpf_list_head {
+	__u64 __a;
+	__u64 __b;
+} __attribute__((aligned(8)));
+
+struct bpf_list_node {
+	__u64 __a;
+	__u64 __b;
+} __attribute__((aligned(8)));
+
+#endif
+
+#ifndef __KERNEL__
+#endif
-- 
2.34.1

