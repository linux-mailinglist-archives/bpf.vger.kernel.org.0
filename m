Return-Path: <bpf+bounces-18123-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64638815E0C
	for <lists+bpf@lfdr.de>; Sun, 17 Dec 2023 09:12:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7D681F225BE
	for <lists+bpf@lfdr.de>; Sun, 17 Dec 2023 08:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B96B1FBB;
	Sun, 17 Dec 2023 08:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JMUtM7Tu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D8F13C15
	for <bpf@vger.kernel.org>; Sun, 17 Dec 2023 08:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-67f2dc0f985so8954566d6.1
        for <bpf@vger.kernel.org>; Sun, 17 Dec 2023 00:11:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702800714; x=1703405514; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y7J1rghRg8ucGY8B9L3+TAn5NDHl7oXmlUcxYxM+VwU=;
        b=JMUtM7TuQ39blbtMv/z/tjooM3l2Ii09sbDCJ+dwmiMpnB9nUaDxEsUZoyz+GcR1lN
         YqMOWcgAbBZaIqa+GwHs6oXPegsVqurzD9VzYz3ru0Sf9Jn6GvDQTCTEB+ZjhmnaRndB
         TMvpCW7F02apENh8iTf02s354BELCwxm19o1KO3C4CYbxBMhATXBKS9BbiYSynOREGhb
         xvgPLXyL9SjiTLOOHgoJPY980n0io4hdW60BVy5/PNRhQxy39p/uHN/g16t/dfPuYC2/
         rS+YA3d2ohC+3CAqohLlwKv2HUShs645Btyhvr/uAcmVAYFJEtjoI94O+k5oYnX5pCGJ
         YG8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702800714; x=1703405514;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y7J1rghRg8ucGY8B9L3+TAn5NDHl7oXmlUcxYxM+VwU=;
        b=Ef+wTZkiEFWeOM4q1Y9qs8IJGjgfX1T+3JUtPyMdOPIdYJPNkfvOJftVW0Tdz/EFUK
         p9ULLpDa64uOlpgXH9W4UtkjCy8IZG6E37azz6qr+g8YLsQbYXND5BwNBX6FcDQes+7c
         4ywFyKgUXrd/t5r17nAtUzPc2erZdg+kp3G7uPD0KMHv9r+GZm9bgejKqsEejCkBB2FG
         2MpQipTcIMfN6/yfx4Sm0c2KBUmaEGNaQJOkGqOPYRZtzdFqbg2KYYRra8hzeRv5QtY3
         KofS5mZJ9mV94S7iTDRdmx+2lxP0DIqWBogZPpVk6wYMgy4XAXWRd51Sc+qHWVWfToew
         0+JQ==
X-Gm-Message-State: AOJu0YzXt3Fe19zyxaUkcL0mIV2hHVEqeTMXHh2EZAenaMjl9ZkwH+YF
	BH2z+zczbfTatDlX5EVND7SQvR7fhJg=
X-Google-Smtp-Source: AGHT+IHRPmOKzteoXUPhPAUsW7aZrqyFDa6kWmWA/q90WnNUt1WPKPfLysaydkvkLCBRg9ggQlGV/Q==
X-Received: by 2002:a05:620a:19a2:b0:77f:8f32:ffaf with SMTP id bm34-20020a05620a19a200b0077f8f32ffafmr11699426qkb.155.1702800714235;
        Sun, 17 Dec 2023 00:11:54 -0800 (PST)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:bb8c:c0f2:4408:50cf])
        by smtp.gmail.com with ESMTPSA id c85-20020a814e58000000b005e303826838sm3399415ywb.56.2023.12.17.00.11.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Dec 2023 00:11:53 -0800 (PST)
From: thinker.li@gmail.com
To: bpf@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	kernel-team@meta.com,
	andrii@kernel.org,
	drosen@google.com
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: [PATCH bpf-next v14 10/14] bpf: validate value_type
Date: Sun, 17 Dec 2023 00:11:27 -0800
Message-Id: <20231217081132.1025020-11-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231217081132.1025020-1-thinker.li@gmail.com>
References: <20231217081132.1025020-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kui-Feng Lee <thinker.li@gmail.com>

A value_type should consist of three components: refcnt, state, and data.
refcnt and state has been move to struct bpf_struct_ops_common_value to
make it easier to check the value type.

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 include/linux/bpf.h         | 12 +++++
 kernel/bpf/bpf_struct_ops.c | 93 ++++++++++++++++++++++++-------------
 2 files changed, 72 insertions(+), 33 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index b60f09449c7f..5d86d3252119 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1697,6 +1697,18 @@ struct bpf_struct_ops_desc {
 	u32 value_id;
 };
 
+enum bpf_struct_ops_state {
+	BPF_STRUCT_OPS_STATE_INIT,
+	BPF_STRUCT_OPS_STATE_INUSE,
+	BPF_STRUCT_OPS_STATE_TOBEFREE,
+	BPF_STRUCT_OPS_STATE_READY,
+};
+
+struct bpf_struct_ops_common_value {
+	refcount_t refcnt;
+	enum bpf_struct_ops_state state;
+};
+
 #if defined(CONFIG_BPF_JIT) && defined(CONFIG_BPF_SYSCALL)
 #define BPF_MODULE_OWNER ((void *)((0xeB9FUL << 2) + POISON_POINTER_DELTA))
 const struct bpf_struct_ops_desc *bpf_struct_ops_find(struct btf *btf, u32 type_id);
diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index ac7fbcc66da9..95099cbaee29 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -13,19 +13,8 @@
 #include <linux/btf_ids.h>
 #include <linux/rcupdate_wait.h>
 
-enum bpf_struct_ops_state {
-	BPF_STRUCT_OPS_STATE_INIT,
-	BPF_STRUCT_OPS_STATE_INUSE,
-	BPF_STRUCT_OPS_STATE_TOBEFREE,
-	BPF_STRUCT_OPS_STATE_READY,
-};
-
-#define BPF_STRUCT_OPS_COMMON_VALUE			\
-	refcount_t refcnt;				\
-	enum bpf_struct_ops_state state
-
 struct bpf_struct_ops_value {
-	BPF_STRUCT_OPS_COMMON_VALUE;
+	struct bpf_struct_ops_common_value common;
 	char data[] ____cacheline_aligned_in_smp;
 };
 
@@ -80,8 +69,8 @@ static DEFINE_MUTEX(update_mutex);
 #define BPF_STRUCT_OPS_TYPE(_name)				\
 extern struct bpf_struct_ops bpf_##_name;			\
 								\
-struct bpf_struct_ops_##_name {						\
-	BPF_STRUCT_OPS_COMMON_VALUE;				\
+struct bpf_struct_ops_##_name {					\
+	struct bpf_struct_ops_common_value common;		\
 	struct _name data ____cacheline_aligned_in_smp;		\
 };
 #include "bpf_struct_ops_types.h"
@@ -112,11 +101,49 @@ const struct bpf_prog_ops bpf_struct_ops_prog_ops = {
 
 BTF_ID_LIST(st_ops_ids)
 BTF_ID(struct, module)
+BTF_ID(struct, bpf_struct_ops_common_value)
 
 enum {
 	IDX_MODULE_ID,
+	IDX_ST_OPS_COMMON_VALUE_ID,
 };
 
+extern struct btf *btf_vmlinux;
+
+static bool is_valid_value_type(struct btf *btf, s32 value_id,
+				const struct btf_type *type,
+				const char *value_name)
+{
+	const struct btf_type *common_value_type;
+	const struct btf_member *member;
+	const struct btf_type *vt, *mt;
+
+	vt = btf_type_by_id(btf, value_id);
+	if (btf_vlen(vt) != 2) {
+		pr_warn("The number of %s's members should be 2, but we get %d\n",
+			value_name, btf_vlen(vt));
+		return false;
+	}
+	member = btf_type_member(vt);
+	mt = btf_type_by_id(btf, member->type);
+	common_value_type = btf_type_by_id(btf_vmlinux,
+					   st_ops_ids[IDX_ST_OPS_COMMON_VALUE_ID]);
+	if (mt != common_value_type) {
+		pr_warn("The first member of %s should be bpf_struct_ops_common_value\n",
+			value_name);
+		return false;
+	}
+	member++;
+	mt = btf_type_by_id(btf, member->type);
+	if (mt != type) {
+		pr_warn("The second member of %s should be %s\n",
+			value_name, btf_name_by_offset(btf, type->name_off));
+		return false;
+	}
+
+	return true;
+}
+
 static void bpf_struct_ops_desc_init(struct bpf_struct_ops_desc *st_ops_desc,
 				     struct btf *btf,
 				     struct bpf_verifier_log *log)
@@ -137,14 +164,6 @@ static void bpf_struct_ops_desc_init(struct bpf_struct_ops_desc *st_ops_desc,
 	}
 	sprintf(value_name, "%s%s", VALUE_PREFIX, st_ops->name);
 
-	value_id = btf_find_by_name_kind(btf, value_name,
-					 BTF_KIND_STRUCT);
-	if (value_id < 0) {
-		pr_warn("Cannot find struct %s in %s\n",
-			value_name, btf_get_name(btf));
-		return;
-	}
-
 	type_id = btf_find_by_name_kind(btf, st_ops->name,
 					BTF_KIND_STRUCT);
 	if (type_id < 0) {
@@ -159,6 +178,16 @@ static void bpf_struct_ops_desc_init(struct bpf_struct_ops_desc *st_ops_desc,
 		return;
 	}
 
+	value_id = btf_find_by_name_kind(btf, value_name,
+					 BTF_KIND_STRUCT);
+	if (value_id < 0) {
+		pr_warn("Cannot find struct %s in %s\n",
+			value_name, btf_get_name(btf));
+		return;
+	}
+	if (!is_valid_value_type(btf, value_id, t, value_name))
+		return;
+
 	for_each_member(i, t, member) {
 		const struct btf_type *func_proto;
 
@@ -218,8 +247,6 @@ void bpf_struct_ops_init(struct btf *btf, struct bpf_verifier_log *log)
 	}
 }
 
-extern struct btf *btf_vmlinux;
-
 static const struct bpf_struct_ops_desc *
 bpf_struct_ops_find_value(struct btf *btf, u32 value_id)
 {
@@ -275,7 +302,7 @@ int bpf_struct_ops_map_sys_lookup_elem(struct bpf_map *map, void *key,
 
 	kvalue = &st_map->kvalue;
 	/* Pair with smp_store_release() during map_update */
-	state = smp_load_acquire(&kvalue->state);
+	state = smp_load_acquire(&kvalue->common.state);
 	if (state == BPF_STRUCT_OPS_STATE_INIT) {
 		memset(value, 0, map->value_size);
 		return 0;
@@ -286,7 +313,7 @@ int bpf_struct_ops_map_sys_lookup_elem(struct bpf_map *map, void *key,
 	 */
 	uvalue = value;
 	memcpy(uvalue, st_map->uvalue, map->value_size);
-	uvalue->state = state;
+	uvalue->common.state = state;
 
 	/* This value offers the user space a general estimate of how
 	 * many sockets are still utilizing this struct_ops for TCP
@@ -294,7 +321,7 @@ int bpf_struct_ops_map_sys_lookup_elem(struct bpf_map *map, void *key,
 	 * should sufficiently meet our present goals.
 	 */
 	refcnt = atomic64_read(&map->refcnt) - atomic64_read(&map->usercnt);
-	refcount_set(&uvalue->refcnt, max_t(s64, refcnt, 0));
+	refcount_set(&uvalue->common.refcnt, max_t(s64, refcnt, 0));
 
 	return 0;
 }
@@ -414,7 +441,7 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
 	if (err)
 		return err;
 
-	if (uvalue->state || refcount_read(&uvalue->refcnt))
+	if (uvalue->common.state || refcount_read(&uvalue->common.refcnt))
 		return -EINVAL;
 
 	tlinks = kcalloc(BPF_TRAMP_MAX, sizeof(*tlinks), GFP_KERNEL);
@@ -426,7 +453,7 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
 
 	mutex_lock(&st_map->lock);
 
-	if (kvalue->state != BPF_STRUCT_OPS_STATE_INIT) {
+	if (kvalue->common.state != BPF_STRUCT_OPS_STATE_INIT) {
 		err = -EBUSY;
 		goto unlock;
 	}
@@ -540,7 +567,7 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
 		 *
 		 * Pair with smp_load_acquire() during lookup_elem().
 		 */
-		smp_store_release(&kvalue->state, BPF_STRUCT_OPS_STATE_READY);
+		smp_store_release(&kvalue->common.state, BPF_STRUCT_OPS_STATE_READY);
 		goto unlock;
 	}
 
@@ -558,7 +585,7 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
 		 * It ensures the above udata updates (e.g. prog->aux->id)
 		 * can be seen once BPF_STRUCT_OPS_STATE_INUSE is set.
 		 */
-		smp_store_release(&kvalue->state, BPF_STRUCT_OPS_STATE_INUSE);
+		smp_store_release(&kvalue->common.state, BPF_STRUCT_OPS_STATE_INUSE);
 		goto unlock;
 	}
 
@@ -588,7 +615,7 @@ static long bpf_struct_ops_map_delete_elem(struct bpf_map *map, void *key)
 	if (st_map->map.map_flags & BPF_F_LINK)
 		return -EOPNOTSUPP;
 
-	prev_state = cmpxchg(&st_map->kvalue.state,
+	prev_state = cmpxchg(&st_map->kvalue.common.state,
 			     BPF_STRUCT_OPS_STATE_INUSE,
 			     BPF_STRUCT_OPS_STATE_TOBEFREE);
 	switch (prev_state) {
@@ -848,7 +875,7 @@ static bool bpf_struct_ops_valid_to_reg(struct bpf_map *map)
 	return map->map_type == BPF_MAP_TYPE_STRUCT_OPS &&
 		map->map_flags & BPF_F_LINK &&
 		/* Pair with smp_store_release() during map_update */
-		smp_load_acquire(&st_map->kvalue.state) == BPF_STRUCT_OPS_STATE_READY;
+		smp_load_acquire(&st_map->kvalue.common.state) == BPF_STRUCT_OPS_STATE_READY;
 }
 
 static void bpf_struct_ops_map_link_dealloc(struct bpf_link *link)
-- 
2.34.1


