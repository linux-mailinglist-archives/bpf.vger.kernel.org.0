Return-Path: <bpf+bounces-18452-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F02481A92F
	for <lists+bpf@lfdr.de>; Wed, 20 Dec 2023 23:28:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6457D1C2294A
	for <lists+bpf@lfdr.de>; Wed, 20 Dec 2023 22:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A2D14BAAA;
	Wed, 20 Dec 2023 22:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UJS/veLA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EDDF4A99B;
	Wed, 20 Dec 2023 22:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-5e89ba9810aso1949377b3.2;
        Wed, 20 Dec 2023 14:27:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703111231; x=1703716031; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JeIRg1BXOu9msonBeeuuhzQbFEtDSHChjz+pTQFF/DM=;
        b=UJS/veLAfoH6Zs8KcCngRtuNSVNlolOhMXbtOcE3MzLuS4AgrE0BjR2dmBoN4HxhVt
         lGJFFV4IWuEAqKIGpYqw5hHCRlcoDA2VBMsEBeM7JqElqgscehR2rC3Gh3lRj8HZqE/x
         uVmt6aEJlorBcAT9NXWwlR7KHXbG9SJCMX1avY2SNrB0SI6OqlRxJFmS+8rOviI4O4aF
         JM/7vAWzNVQaT0rS1IhZYN+JSIDgJ11r3SsN2TyOxwJ0hI1OJ6SmJBuD+3RyZ+BhdB/4
         QLP768iGjttX6EWmduuUkpZHHiMDjBcRIbZLdAWaat/4KmuZSvTt3pWbqbhaveSw2MNn
         Z8Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703111231; x=1703716031;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JeIRg1BXOu9msonBeeuuhzQbFEtDSHChjz+pTQFF/DM=;
        b=gw/47Q+6x/o1C4Ba3W0ek2zOoMw45hEv8+bJFZUDNp8M6iW8RD1RsoyvauHYP3K+yy
         jAkIzK+uuDlI2esneAZcHySp4X7m9JomQ9S4ew1lEITnck2MggwjdG/FallN3ppGg0ST
         FvXmsiIyDRdo9AgUkKrjkXAF9wvnnfqltlv0/Eo4F6+ebhebNbObr0/pzteqBDq8mq1H
         n5w4ADE5bTctbDutDu/82SPKUDujgE2nBJJ0YPgKOe7N7HYSvI/lQOUsOXfQbPyOZlfR
         zC7QDpFIpWcPiX/R6tR1IOVdvHYf1KIWO1x8/1mFo9sUkRVhRSDY3XKJMMcO9nC1grwA
         JcmQ==
X-Gm-Message-State: AOJu0YykHJqCTJe+9M0GtN4OReGZLTk2vWyIkrjVhWnDehuI0AMvHDpb
	+uthiT/lyFiBJETwXwOklp+Xm3YiONA=
X-Google-Smtp-Source: AGHT+IFiN+S4ZAn59Ww75QoYyiyiGXrEwvLm1XlXF6IGFYfQaEtPSpSRCxyxPLPskdSowBW+yp4PSw==
X-Received: by 2002:a81:920d:0:b0:5e7:6f9c:b194 with SMTP id j13-20020a81920d000000b005e76f9cb194mr447207ywg.15.1703111230734;
        Wed, 20 Dec 2023 14:27:10 -0800 (PST)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:8cc1:afcb:3651:3dad])
        by smtp.gmail.com with ESMTPSA id m125-20020a0dfc83000000b005ca4e49bb54sm284304ywf.142.2023.12.20.14.27.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 14:27:10 -0800 (PST)
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
	Kui-Feng Lee <thinker.li@gmail.com>,
	netdev@vger.kernel.org
Subject: [PATCH bpf-next v15 11/14] bpf, net: switch to dynamic registration
Date: Wed, 20 Dec 2023 14:26:51 -0800
Message-Id: <20231220222654.1435895-12-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231220222654.1435895-1-thinker.li@gmail.com>
References: <20231220222654.1435895-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kui-Feng Lee <thinker.li@gmail.com>

Replace the static list of struct_ops types with per-btf struct_ops_tab to
enable dynamic registration.

Both bpf_dummy_ops and bpf_tcp_ca now utilize the registration function
instead of being listed in bpf_struct_ops_types.h.

Cc: netdev@vger.kernel.org
Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 include/linux/bpf.h               |  33 ++++++----
 include/linux/btf.h               |  12 ++++
 kernel/bpf/bpf_struct_ops.c       | 100 ++++--------------------------
 kernel/bpf/bpf_struct_ops_types.h |  12 ----
 kernel/bpf/btf.c                  |  84 +++++++++++++++++++++++--
 net/bpf/bpf_dummy_struct_ops.c    |  11 +++-
 net/ipv4/bpf_tcp_ca.c             |  12 +++-
 7 files changed, 145 insertions(+), 119 deletions(-)
 delete mode 100644 kernel/bpf/bpf_struct_ops_types.h

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index f2eccc1c1972..1d626f5a984f 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1699,10 +1699,22 @@ struct bpf_struct_ops_common_value {
 	enum bpf_struct_ops_state state;
 };
 
+/* This macro helps developer to register a struct_ops type and generate
+ * type information correctly. Developers should use this macro to register
+ * a struct_ops type instead of calling register_bpf_struct_ops() directly.
+ */
+#define REGISTER_BPF_STRUCT_OPS(st_ops, type)				\
+	({								\
+		struct bpf_struct_ops_##type {				\
+			struct bpf_struct_ops_common_value common;	\
+			struct type data ____cacheline_aligned_in_smp;	\
+		};							\
+		BTF_TYPE_EMIT(struct bpf_struct_ops_##type);		\
+		register_bpf_struct_ops(st_ops);			\
+	})
+
 #if defined(CONFIG_BPF_JIT) && defined(CONFIG_BPF_SYSCALL)
 #define BPF_MODULE_OWNER ((void *)((0xeB9FUL << 2) + POISON_POINTER_DELTA))
-const struct bpf_struct_ops_desc *bpf_struct_ops_find(struct btf *btf, u32 type_id);
-void bpf_struct_ops_init(struct btf *btf, struct bpf_verifier_log *log);
 bool bpf_struct_ops_get(const void *kdata);
 void bpf_struct_ops_put(const void *kdata);
 int bpf_struct_ops_map_sys_lookup_elem(struct bpf_map *map, void *key,
@@ -1744,16 +1756,11 @@ struct bpf_dummy_ops {
 int bpf_struct_ops_test_run(struct bpf_prog *prog, const union bpf_attr *kattr,
 			    union bpf_attr __user *uattr);
 #endif
+int bpf_struct_ops_desc_init(struct bpf_struct_ops_desc *st_ops_desc,
+			     struct btf *btf,
+			     struct bpf_verifier_log *log);
 void bpf_map_struct_ops_info_fill(struct bpf_map_info *info, struct bpf_map *map);
 #else
-static inline const struct bpf_struct_ops_desc *bpf_struct_ops_find(struct btf *btf, u32 type_id)
-{
-	return NULL;
-}
-static inline void bpf_struct_ops_init(struct btf *btf,
-				       struct bpf_verifier_log *log)
-{
-}
 static inline bool bpf_try_module_get(const void *data, struct module *owner)
 {
 	return try_module_get(owner);
@@ -1772,7 +1779,11 @@ static inline int bpf_struct_ops_link_create(union bpf_attr *attr)
 {
 	return -EOPNOTSUPP;
 }
-
+static inline int bpf_struct_ops_desc_init(struct bpf_struct_ops_desc *st_ops_desc,
+					   struct btf *btf,
+					   struct bpf_verifier_log *log) {
+	return -EOPNOTSUPP;
+}
 #endif
 
 #if defined(CONFIG_CGROUP_BPF) && defined(CONFIG_BPF_LSM)
diff --git a/include/linux/btf.h b/include/linux/btf.h
index a68604904f4e..bc3576b067f6 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -496,6 +496,7 @@ static inline void *btf_id_set8_contains(const struct btf_id_set8 *set, u32 id)
 }
 
 struct bpf_verifier_log;
+struct bpf_struct_ops;
 
 #ifdef CONFIG_BPF_SYSCALL
 const struct btf_type *btf_type_by_id(const struct btf *btf, u32 type_id);
@@ -520,6 +521,9 @@ btf_get_prog_ctx_type(struct bpf_verifier_log *log, const struct btf *btf,
 int get_kern_ctx_btf_id(struct bpf_verifier_log *log, enum bpf_prog_type prog_type);
 bool btf_types_are_same(const struct btf *btf1, u32 id1,
 			const struct btf *btf2, u32 id2);
+int register_bpf_struct_ops(struct bpf_struct_ops *st_ops);
+const struct bpf_struct_ops_desc *bpf_struct_ops_find_value(struct btf *btf, u32 value_id);
+const struct bpf_struct_ops_desc *bpf_struct_ops_find(struct btf *btf, u32 type_id);
 #else
 static inline const struct btf_type *btf_type_by_id(const struct btf *btf,
 						    u32 type_id)
@@ -572,6 +576,14 @@ static inline bool btf_types_are_same(const struct btf *btf1, u32 id1,
 {
 	return false;
 }
+static inline int register_bpf_struct_ops(struct bpf_struct_ops *st_ops)
+{
+	return -ENOTSUPP;
+}
+static inline const struct bpf_struct_ops_desc *bpf_struct_ops_find(struct btf *btf, u32 type_id)
+{
+	return NULL;
+}
 #endif
 
 static inline bool btf_type_is_struct_ptr(struct btf *btf, const struct btf_type *t)
diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index 5b80060067ee..b3ac6fb6f2be 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -61,35 +61,6 @@ static DEFINE_MUTEX(update_mutex);
 #define VALUE_PREFIX "bpf_struct_ops_"
 #define VALUE_PREFIX_LEN (sizeof(VALUE_PREFIX) - 1)
 
-/* bpf_struct_ops_##_name (e.g. bpf_struct_ops_tcp_congestion_ops) is
- * the map's value exposed to the userspace and its btf-type-id is
- * stored at the map->btf_vmlinux_value_type_id.
- *
- */
-#define BPF_STRUCT_OPS_TYPE(_name)				\
-extern struct bpf_struct_ops bpf_##_name;			\
-								\
-struct bpf_struct_ops_##_name {					\
-	struct bpf_struct_ops_common_value common;		\
-	struct _name data ____cacheline_aligned_in_smp;		\
-};
-#include "bpf_struct_ops_types.h"
-#undef BPF_STRUCT_OPS_TYPE
-
-enum {
-#define BPF_STRUCT_OPS_TYPE(_name) BPF_STRUCT_OPS_TYPE_##_name,
-#include "bpf_struct_ops_types.h"
-#undef BPF_STRUCT_OPS_TYPE
-	__NR_BPF_STRUCT_OPS_TYPE,
-};
-
-static struct bpf_struct_ops_desc bpf_struct_ops[] = {
-#define BPF_STRUCT_OPS_TYPE(_name)				\
-	[BPF_STRUCT_OPS_TYPE_##_name] = { .st_ops = &bpf_##_name },
-#include "bpf_struct_ops_types.h"
-#undef BPF_STRUCT_OPS_TYPE
-};
-
 const struct bpf_verifier_ops bpf_struct_ops_verifier_ops = {
 };
 
@@ -144,9 +115,9 @@ static bool is_valid_value_type(struct btf *btf, s32 value_id,
 	return true;
 }
 
-static void bpf_struct_ops_desc_init(struct bpf_struct_ops_desc *st_ops_desc,
-				     struct btf *btf,
-				     struct bpf_verifier_log *log)
+int bpf_struct_ops_desc_init(struct bpf_struct_ops_desc *st_ops_desc,
+			     struct btf *btf,
+			     struct bpf_verifier_log *log)
 {
 	struct bpf_struct_ops *st_ops = st_ops_desc->st_ops;
 	const struct btf_member *member;
@@ -160,7 +131,7 @@ static void bpf_struct_ops_desc_init(struct bpf_struct_ops_desc *st_ops_desc,
 	    sizeof(value_name)) {
 		pr_warn("struct_ops name %s is too long\n",
 			st_ops->name);
-		return;
+		return -EINVAL;
 	}
 	sprintf(value_name, "%s%s", VALUE_PREFIX, st_ops->name);
 
@@ -169,13 +140,13 @@ static void bpf_struct_ops_desc_init(struct bpf_struct_ops_desc *st_ops_desc,
 	if (type_id < 0) {
 		pr_warn("Cannot find struct %s in %s\n",
 			st_ops->name, btf_get_name(btf));
-		return;
+		return -EINVAL;
 	}
 	t = btf_type_by_id(btf, type_id);
 	if (btf_type_vlen(t) > BPF_STRUCT_OPS_MAX_NR_MEMBERS) {
 		pr_warn("Cannot support #%u members in struct %s\n",
 			btf_type_vlen(t), st_ops->name);
-		return;
+		return -EINVAL;
 	}
 
 	value_id = btf_find_by_name_kind(btf, value_name,
@@ -183,10 +154,10 @@ static void bpf_struct_ops_desc_init(struct bpf_struct_ops_desc *st_ops_desc,
 	if (value_id < 0) {
 		pr_warn("Cannot find struct %s in %s\n",
 			value_name, btf_get_name(btf));
-		return;
+		return -EINVAL;
 	}
 	if (!is_valid_value_type(btf, value_id, t, value_name))
-		return;
+		return -EINVAL;
 
 	for_each_member(i, t, member) {
 		const struct btf_type *func_proto;
@@ -195,13 +166,13 @@ static void bpf_struct_ops_desc_init(struct bpf_struct_ops_desc *st_ops_desc,
 		if (!*mname) {
 			pr_warn("anon member in struct %s is not supported\n",
 				st_ops->name);
-			break;
+			return -EOPNOTSUPP;
 		}
 
 		if (__btf_member_bitfield_size(t, member)) {
 			pr_warn("bit field member %s in struct %s is not supported\n",
 				mname, st_ops->name);
-			break;
+			return -EOPNOTSUPP;
 		}
 
 		func_proto = btf_type_resolve_func_ptr(btf,
@@ -213,7 +184,7 @@ static void bpf_struct_ops_desc_init(struct bpf_struct_ops_desc *st_ops_desc,
 					   &st_ops->func_models[i])) {
 			pr_warn("Error in parsing func ptr %s in struct %s\n",
 				mname, st_ops->name);
-			break;
+			return -EINVAL;
 		}
 	}
 
@@ -221,6 +192,7 @@ static void bpf_struct_ops_desc_init(struct bpf_struct_ops_desc *st_ops_desc,
 		if (st_ops->init(btf)) {
 			pr_warn("Error in init bpf_struct_ops %s\n",
 				st_ops->name);
+			return -EINVAL;
 		} else {
 			st_ops_desc->type_id = type_id;
 			st_ops_desc->type = t;
@@ -229,54 +201,8 @@ static void bpf_struct_ops_desc_init(struct bpf_struct_ops_desc *st_ops_desc,
 								 value_id);
 		}
 	}
-}
 
-void bpf_struct_ops_init(struct btf *btf, struct bpf_verifier_log *log)
-{
-	struct bpf_struct_ops_desc *st_ops_desc;
-	u32 i;
-
-	/* Ensure BTF type is emitted for "struct bpf_struct_ops_##_name" */
-#define BPF_STRUCT_OPS_TYPE(_name) BTF_TYPE_EMIT(struct bpf_struct_ops_##_name);
-#include "bpf_struct_ops_types.h"
-#undef BPF_STRUCT_OPS_TYPE
-
-	for (i = 0; i < ARRAY_SIZE(bpf_struct_ops); i++) {
-		st_ops_desc = &bpf_struct_ops[i];
-		bpf_struct_ops_desc_init(st_ops_desc, btf, log);
-	}
-}
-
-static const struct bpf_struct_ops_desc *
-bpf_struct_ops_find_value(struct btf *btf, u32 value_id)
-{
-	unsigned int i;
-
-	if (!value_id || !btf)
-		return NULL;
-
-	for (i = 0; i < ARRAY_SIZE(bpf_struct_ops); i++) {
-		if (bpf_struct_ops[i].value_id == value_id)
-			return &bpf_struct_ops[i];
-	}
-
-	return NULL;
-}
-
-const struct bpf_struct_ops_desc *
-bpf_struct_ops_find(struct btf *btf, u32 type_id)
-{
-	unsigned int i;
-
-	if (!type_id || !btf)
-		return NULL;
-
-	for (i = 0; i < ARRAY_SIZE(bpf_struct_ops); i++) {
-		if (bpf_struct_ops[i].type_id == type_id)
-			return &bpf_struct_ops[i];
-	}
-
-	return NULL;
+	return 0;
 }
 
 static int bpf_struct_ops_map_get_next_key(struct bpf_map *map, void *key,
diff --git a/kernel/bpf/bpf_struct_ops_types.h b/kernel/bpf/bpf_struct_ops_types.h
deleted file mode 100644
index 5678a9ddf817..000000000000
--- a/kernel/bpf/bpf_struct_ops_types.h
+++ /dev/null
@@ -1,12 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/* internal file - do not include directly */
-
-#ifdef CONFIG_BPF_JIT
-#ifdef CONFIG_NET
-BPF_STRUCT_OPS_TYPE(bpf_dummy_ops)
-#endif
-#ifdef CONFIG_INET
-#include <net/tcp.h>
-BPF_STRUCT_OPS_TYPE(tcp_congestion_ops)
-#endif
-#endif
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 3fa84c44b882..860b2946de3c 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -19,6 +19,7 @@
 #include <linux/bpf_verifier.h>
 #include <linux/btf.h>
 #include <linux/btf_ids.h>
+#include <linux/bpf.h>
 #include <linux/bpf_lsm.h>
 #include <linux/skmsg.h>
 #include <linux/perf_event.h>
@@ -5792,8 +5793,6 @@ struct btf *btf_parse_vmlinux(void)
 	/* btf_parse_vmlinux() runs under bpf_verifier_lock */
 	bpf_ctx_convert.t = btf_type_by_id(btf, bpf_ctx_convert_btf_id[0]);
 
-	bpf_struct_ops_init(btf, log);
-
 	refcount_set(&btf->refcnt, 1);
 
 	err = btf_alloc_id(btf);
@@ -8489,10 +8488,11 @@ bool btf_type_ids_nocast_alias(struct bpf_verifier_log *log,
 }
 
 static int
-btf_add_struct_ops(struct btf *btf, struct bpf_struct_ops *st_ops)
+btf_add_struct_ops(struct btf *btf, struct bpf_struct_ops *st_ops,
+		   struct bpf_verifier_log *log)
 {
 	struct btf_struct_ops_tab *tab, *new_tab;
-	int i;
+	int i, err;
 
 	if (!btf)
 		return -ENOENT;
@@ -8529,7 +8529,83 @@ btf_add_struct_ops(struct btf *btf, struct bpf_struct_ops *st_ops)
 
 	tab->ops[btf->struct_ops_tab->cnt].st_ops = st_ops;
 
+	err = bpf_struct_ops_desc_init(&tab->ops[btf->struct_ops_tab->cnt], btf, log);
+	if (err)
+		return err;
+
 	btf->struct_ops_tab->cnt++;
 
 	return 0;
 }
+
+const struct bpf_struct_ops_desc *
+bpf_struct_ops_find_value(struct btf *btf, u32 value_id)
+{
+	const struct bpf_struct_ops_desc *st_ops_list;
+	unsigned int i;
+	u32 cnt;
+
+	if (!value_id)
+		return NULL;
+	if (!btf->struct_ops_tab)
+		return NULL;
+
+	cnt = btf->struct_ops_tab->cnt;
+	st_ops_list = btf->struct_ops_tab->ops;
+	for (i = 0; i < cnt; i++) {
+		if (st_ops_list[i].value_id == value_id)
+			return &st_ops_list[i];
+	}
+
+	return NULL;
+}
+
+const struct bpf_struct_ops_desc *
+bpf_struct_ops_find(struct btf *btf, u32 type_id)
+{
+	const struct bpf_struct_ops_desc *st_ops_list;
+	unsigned int i;
+	u32 cnt;
+
+	if (!type_id)
+		return NULL;
+	if (!btf->struct_ops_tab)
+		return NULL;
+
+	cnt = btf->struct_ops_tab->cnt;
+	st_ops_list = btf->struct_ops_tab->ops;
+	for (i = 0; i < cnt; i++) {
+		if (st_ops_list[i].type_id == type_id)
+			return &st_ops_list[i];
+	}
+
+	return NULL;
+}
+
+int register_bpf_struct_ops(struct bpf_struct_ops *st_ops)
+{
+	struct bpf_verifier_log *log;
+	struct btf *btf;
+	int err = 0;
+
+	btf = btf_get_module_btf(st_ops->owner);
+	if (!btf)
+		return -EINVAL;
+
+	log = kzalloc(sizeof(*log), GFP_KERNEL | __GFP_NOWARN);
+	if (!log) {
+		err = -ENOMEM;
+		goto errout;
+	}
+
+	log->level = BPF_LOG_KERNEL;
+
+	err = btf_add_struct_ops(btf, st_ops, log);
+
+errout:
+	kfree(log);
+	btf_put(btf);
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(register_bpf_struct_ops);
diff --git a/net/bpf/bpf_dummy_struct_ops.c b/net/bpf/bpf_dummy_struct_ops.c
index ba2c58dba2da..42034c54a70f 100644
--- a/net/bpf/bpf_dummy_struct_ops.c
+++ b/net/bpf/bpf_dummy_struct_ops.c
@@ -7,7 +7,7 @@
 #include <linux/bpf.h>
 #include <linux/btf.h>
 
-extern struct bpf_struct_ops bpf_bpf_dummy_ops;
+static struct bpf_struct_ops bpf_bpf_dummy_ops;
 
 /* A common type for test_N with return value in bpf_dummy_ops */
 typedef int (*dummy_ops_test_ret_fn)(struct bpf_dummy_ops_state *state, ...);
@@ -256,7 +256,7 @@ static struct bpf_dummy_ops __bpf_bpf_dummy_ops = {
 	.test_sleepable = bpf_dummy_test_sleepable,
 };
 
-struct bpf_struct_ops bpf_bpf_dummy_ops = {
+static struct bpf_struct_ops bpf_bpf_dummy_ops = {
 	.verifier_ops = &bpf_dummy_verifier_ops,
 	.init = bpf_dummy_init,
 	.check_member = bpf_dummy_ops_check_member,
@@ -265,4 +265,11 @@ struct bpf_struct_ops bpf_bpf_dummy_ops = {
 	.unreg = bpf_dummy_unreg,
 	.name = "bpf_dummy_ops",
 	.cfi_stubs = &__bpf_bpf_dummy_ops,
+	.owner = THIS_MODULE,
 };
+
+static int __init bpf_dummy_struct_ops_init(void)
+{
+	return REGISTER_BPF_STRUCT_OPS(&bpf_bpf_dummy_ops, bpf_dummy_ops);
+}
+late_initcall(bpf_dummy_struct_ops_init);
diff --git a/net/ipv4/bpf_tcp_ca.c b/net/ipv4/bpf_tcp_ca.c
index dffd8828079b..7e053b9faca3 100644
--- a/net/ipv4/bpf_tcp_ca.c
+++ b/net/ipv4/bpf_tcp_ca.c
@@ -12,7 +12,7 @@
 #include <net/bpf_sk_storage.h>
 
 /* "extern" is to avoid sparse warning.  It is only used in bpf_struct_ops.c. */
-extern struct bpf_struct_ops bpf_tcp_congestion_ops;
+static struct bpf_struct_ops bpf_tcp_congestion_ops;
 
 static u32 unsupported_ops[] = {
 	offsetof(struct tcp_congestion_ops, get_info),
@@ -345,7 +345,7 @@ static struct tcp_congestion_ops __bpf_ops_tcp_congestion_ops = {
 	.release = __bpf_tcp_ca_release,
 };
 
-struct bpf_struct_ops bpf_tcp_congestion_ops = {
+static struct bpf_struct_ops bpf_tcp_congestion_ops = {
 	.verifier_ops = &bpf_tcp_ca_verifier_ops,
 	.reg = bpf_tcp_ca_reg,
 	.unreg = bpf_tcp_ca_unreg,
@@ -356,10 +356,16 @@ struct bpf_struct_ops bpf_tcp_congestion_ops = {
 	.validate = bpf_tcp_ca_validate,
 	.name = "tcp_congestion_ops",
 	.cfi_stubs = &__bpf_ops_tcp_congestion_ops,
+	.owner = THIS_MODULE,
 };
 
 static int __init bpf_tcp_ca_kfunc_init(void)
 {
-	return register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS, &bpf_tcp_ca_kfunc_set);
+	int ret;
+
+	ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS, &bpf_tcp_ca_kfunc_set);
+	ret = ret ?: REGISTER_BPF_STRUCT_OPS(&bpf_tcp_congestion_ops, tcp_congestion_ops);
+
+	return ret;
 }
 late_initcall(bpf_tcp_ca_kfunc_init);
-- 
2.34.1


