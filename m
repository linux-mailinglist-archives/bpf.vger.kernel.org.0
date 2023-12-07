Return-Path: <bpf+bounces-16971-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D5C4807E09
	for <lists+bpf@lfdr.de>; Thu,  7 Dec 2023 02:41:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B2CA280E64
	for <lists+bpf@lfdr.de>; Thu,  7 Dec 2023 01:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12AF3524D;
	Thu,  7 Dec 2023 01:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i1Z1vMZ6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32018D5E;
	Wed,  6 Dec 2023 17:40:18 -0800 (PST)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-5d400779f16so1404817b3.0;
        Wed, 06 Dec 2023 17:40:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701913217; x=1702518017; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L3/VdCHn7GZRTrQJgUYbGudL9xZfyRC/xONJaJsSwmo=;
        b=i1Z1vMZ6aSvvS41eCNhyrqqDWaGFrwdaYFg50gXdFhBB5h8RoQrOFdh1qLveSriWHX
         NrU/8AAoLl/TYQCZScsE+FojgnKjO9Hxe5m1fxvN/0QGMa16k1BZryCmdpExt5wyfddl
         ywSuWF6Pcc6tmgeeOxvkNplzDLInsaCVbbQlJGoY5cqdM4UPa05AMUG8appPBxl1ZAto
         2qawKh4tmTOOGuQ9bQSvw0n6VFxR4x9FE8NJ7XFgoYqn1Qj3sfqfJrT7eP+yIJYGL8Fp
         BYGcYK4gO03kwktMWOj9umzoUSgLvdhq3r+Gskws7FNnvGj0qe74QKFMwzNFNQXGMxr/
         xCGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701913217; x=1702518017;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L3/VdCHn7GZRTrQJgUYbGudL9xZfyRC/xONJaJsSwmo=;
        b=XMR4dhNUgDLYD7b2o1SnxBxzZ6ojyKw7IS8mEkdfM7GB78nMBC4BtHrUuDSvuUXCQw
         0EWYdV/oAKPRtYzTWlH5bXJ6GdWoVixsCUrAy+PWvSj7mm6ZsWuRxWcrA5JQs5YmJlsa
         7lpWYq1nLOBga8Sq/ygACZlM27EITpgOldENd0M7TPTu0buRSh4UOKRIip8F9l5Nm5QV
         PSsFVi+xa+6Piv10TN/VV0Tc89ATuVPg89TRuSuIA0bi/+P58cGm/9wqTWkSsUV93wLE
         n4Cxbo8W6gJD95JwCXDH812vJFs6qaIcYjHISmEPrdoxqMwMq4yFG8Y3S6CgL8JJPK1T
         QSRg==
X-Gm-Message-State: AOJu0YwKd/ue8bk818GTqJ7l6xTyzqnSt3iL2rjUG/pSLYX7C5mU4S1+
	uXDnPzo16IyaBg/yH+dPRokMVllRQfg=
X-Google-Smtp-Source: AGHT+IGay7KtKB9Du6Sb1w2hV5Hx7XBvArnZIoddPTOS9L9oXbMxJ2wyBVIXb/kKVi1IkBdTXtVLIg==
X-Received: by 2002:a0d:eb44:0:b0:5d7:1a33:5ae5 with SMTP id u65-20020a0deb44000000b005d71a335ae5mr2638202ywe.50.1701913216863;
        Wed, 06 Dec 2023 17:40:16 -0800 (PST)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:c8f2:3a3b:3003:f559])
        by smtp.gmail.com with ESMTPSA id v134-20020a81488c000000b005d997db3b2fsm60768ywa.23.2023.12.06.17.40.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 17:40:16 -0800 (PST)
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
Subject: [PATCH bpf-next v12 10/14] bpf, net: switch to dynamic registration
Date: Wed,  6 Dec 2023 17:39:46 -0800
Message-Id: <20231207013950.1689269-11-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231207013950.1689269-1-thinker.li@gmail.com>
References: <20231207013950.1689269-1-thinker.li@gmail.com>
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
 include/linux/bpf.h               | 28 ++++++++--
 include/linux/btf.h               |  2 +
 kernel/bpf/bpf_struct_ops.c       | 90 ++++++++++---------------------
 kernel/bpf/bpf_struct_ops_types.h | 12 -----
 kernel/bpf/btf.c                  | 49 +++++++++++++++--
 net/bpf/bpf_dummy_struct_ops.c    | 13 ++++-
 net/ipv4/bpf_tcp_ca.c             | 14 +++--
 7 files changed, 119 insertions(+), 89 deletions(-)
 delete mode 100644 kernel/bpf/bpf_struct_ops_types.h

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index bc4279cd61e9..fdfceae25e08 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1651,7 +1651,6 @@ struct bpf_struct_ops_desc {
 #if defined(CONFIG_BPF_JIT) && defined(CONFIG_BPF_SYSCALL)
 #define BPF_MODULE_OWNER ((void *)((0xeB9FUL << 2) + POISON_POINTER_DELTA))
 const struct bpf_struct_ops_desc *bpf_struct_ops_find(struct btf *btf, u32 type_id);
-void bpf_struct_ops_init(struct btf *btf, struct bpf_verifier_log *log);
 bool bpf_struct_ops_get(const void *kdata);
 void bpf_struct_ops_put(const void *kdata);
 int bpf_struct_ops_map_sys_lookup_elem(struct bpf_map *map, void *key,
@@ -1697,10 +1696,6 @@ static inline const struct bpf_struct_ops_desc *bpf_struct_ops_find(struct btf *
 {
 	return NULL;
 }
-static inline void bpf_struct_ops_init(struct btf *btf,
-				       struct bpf_verifier_log *log)
-{
-}
 static inline bool bpf_try_module_get(const void *data, struct module *owner)
 {
 	return try_module_get(owner);
@@ -3239,6 +3234,14 @@ static inline bool bpf_is_subprog(const struct bpf_prog *prog)
 	return prog->aux->func_idx != 0;
 }
 
+int register_bpf_struct_ops(struct bpf_struct_ops *st_ops);
+
+#define REGISTER_BPF_STRUCT_OPS(st_ops, type) \
+({					      \
+	BTF_STRUCT_OPS_TYPE_EMIT(type);	      \
+	register_bpf_struct_ops(st_ops);      \
+})
+
 enum bpf_struct_ops_state {
 	BPF_STRUCT_OPS_STATE_INIT,
 	BPF_STRUCT_OPS_STATE_INUSE,
@@ -3251,4 +3254,19 @@ struct bpf_struct_ops_common_value {
 	enum bpf_struct_ops_state state;
 };
 
+/* bpf_struct_ops_##_name (e.g. bpf_struct_ops_tcp_congestion_ops) is
+ * the map's value exposed to the userspace and its btf-type-id is
+ * stored at the map->btf_vmlinux_value_type_id.
+ *
+ */
+#define DEFINE_STRUCT_OPS_VALUE_TYPE(_name)			\
+struct bpf_struct_ops_##_name {					\
+	struct bpf_struct_ops_common_value common;		\
+	struct _name data ____cacheline_aligned_in_smp;		\
+}
+
+int bpf_struct_ops_desc_init(struct bpf_struct_ops_desc *st_ops_desc,
+			     struct btf *btf,
+			     struct bpf_verifier_log *log);
+
 #endif /* _LINUX_BPF_H */
diff --git a/include/linux/btf.h b/include/linux/btf.h
index e2f4b85cf82a..cabab3db5216 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -12,6 +12,8 @@
 #include <uapi/linux/bpf.h>
 
 #define BTF_TYPE_EMIT(type) ((void)(type *)0)
+#define BTF_STRUCT_OPS_TYPE_EMIT(type) \
+	((void)(struct bpf_struct_ops_##type *)0)
 #define BTF_TYPE_EMIT_ENUM(enum_val) ((void)enum_val)
 
 /* These need to be macros, as the expressions are used in assembler input */
diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index e8415b6b6d2b..9ca166c79d19 100644
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
@@ -229,35 +201,24 @@ static void bpf_struct_ops_desc_init(struct bpf_struct_ops_desc *st_ops_desc,
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
+	return 0;
 }
 
 static const struct bpf_struct_ops_desc *
 bpf_struct_ops_find_value(struct btf *btf, u32 value_id)
 {
+	const struct bpf_struct_ops_desc *st_ops_list;
 	unsigned int i;
+	u32 cnt = 0;
 
-	if (!value_id || !btf)
+	if (!value_id)
 		return NULL;
 
-	for (i = 0; i < ARRAY_SIZE(bpf_struct_ops); i++) {
-		if (bpf_struct_ops[i].value_id == value_id)
-			return &bpf_struct_ops[i];
+	st_ops_list = btf_get_struct_ops(btf, &cnt);
+	for (i = 0; i < cnt; i++) {
+		if (st_ops_list[i].value_id == value_id)
+			return &st_ops_list[i];
 	}
 
 	return NULL;
@@ -266,14 +227,17 @@ bpf_struct_ops_find_value(struct btf *btf, u32 value_id)
 const struct bpf_struct_ops_desc *
 bpf_struct_ops_find(struct btf *btf, u32 type_id)
 {
+	const struct bpf_struct_ops_desc *st_ops_list;
 	unsigned int i;
+	u32 cnt;
 
-	if (!type_id || !btf)
+	if (!type_id)
 		return NULL;
 
-	for (i = 0; i < ARRAY_SIZE(bpf_struct_ops); i++) {
-		if (bpf_struct_ops[i].type_id == type_id)
-			return &bpf_struct_ops[i];
+	st_ops_list = btf_get_struct_ops(btf, &cnt);
+	for (i = 0; i < cnt; i++) {
+		if (st_ops_list[i].type_id == type_id)
+			return &st_ops_list[i];
 	}
 
 	return NULL;
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
index edbe3cbf2dcc..5545dee3ff54 100644
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
@@ -8621,11 +8620,21 @@ bool btf_type_ids_nocast_alias(struct bpf_verifier_log *log,
 	return !strncmp(reg_name, arg_name, cmp_len);
 }
 
+#ifndef CONFIG_BPF_JIT
+int bpf_struct_ops_desc_init(struct bpf_struct_ops_desc *st_ops_desc,
+			     struct btf *btf,
+			     struct bpf_verifier_log *log)
+{
+	return -ENOTSUPP;
+}
+#endif /* CONFIG_BPF_JIT */
+
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
@@ -8662,6 +8671,10 @@ btf_add_struct_ops(struct btf *btf, struct bpf_struct_ops *st_ops)
 
 	tab->ops[btf->struct_ops_tab->cnt].st_ops = st_ops;
 
+	err = bpf_struct_ops_desc_init(&tab->ops[btf->struct_ops_tab->cnt], btf, log);
+	if (err)
+		return err;
+
 	btf->struct_ops_tab->cnt++;
 
 	return 0;
@@ -8677,3 +8690,31 @@ const struct bpf_struct_ops_desc *btf_get_struct_ops(struct btf *btf, u32 *ret_c
 	*ret_cnt = btf->struct_ops_tab->cnt;
 	return (const struct bpf_struct_ops_desc *)btf->struct_ops_tab->ops;
 }
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
index ffa224053a6c..65a89580d5d2 100644
--- a/net/bpf/bpf_dummy_struct_ops.c
+++ b/net/bpf/bpf_dummy_struct_ops.c
@@ -7,7 +7,7 @@
 #include <linux/bpf.h>
 #include <linux/btf.h>
 
-extern struct bpf_struct_ops bpf_bpf_dummy_ops;
+static struct bpf_struct_ops bpf_bpf_dummy_ops;
 
 /* A common type for test_N with return value in bpf_dummy_ops */
 typedef int (*dummy_ops_test_ret_fn)(struct bpf_dummy_ops_state *state, ...);
@@ -223,11 +223,13 @@ static int bpf_dummy_reg(void *kdata)
 	return -EOPNOTSUPP;
 }
 
+DEFINE_STRUCT_OPS_VALUE_TYPE(bpf_dummy_ops);
+
 static void bpf_dummy_unreg(void *kdata)
 {
 }
 
-struct bpf_struct_ops bpf_bpf_dummy_ops = {
+static struct bpf_struct_ops bpf_bpf_dummy_ops = {
 	.verifier_ops = &bpf_dummy_verifier_ops,
 	.init = bpf_dummy_init,
 	.check_member = bpf_dummy_ops_check_member,
@@ -235,4 +237,11 @@ struct bpf_struct_ops bpf_bpf_dummy_ops = {
 	.reg = bpf_dummy_reg,
 	.unreg = bpf_dummy_unreg,
 	.name = "bpf_dummy_ops",
+	.owner = THIS_MODULE,
 };
+
+static int __init bpf_dummy_struct_ops_init(void)
+{
+	return REGISTER_BPF_STRUCT_OPS(&bpf_bpf_dummy_ops, bpf_dummy_ops);
+}
+late_initcall(bpf_dummy_struct_ops_init);
diff --git a/net/ipv4/bpf_tcp_ca.c b/net/ipv4/bpf_tcp_ca.c
index 3c8b76578a2a..69f0e8961628 100644
--- a/net/ipv4/bpf_tcp_ca.c
+++ b/net/ipv4/bpf_tcp_ca.c
@@ -12,7 +12,7 @@
 #include <net/bpf_sk_storage.h>
 
 /* "extern" is to avoid sparse warning.  It is only used in bpf_struct_ops.c. */
-extern struct bpf_struct_ops bpf_tcp_congestion_ops;
+static struct bpf_struct_ops bpf_tcp_congestion_ops;
 
 static u32 unsupported_ops[] = {
 	offsetof(struct tcp_congestion_ops, get_info),
@@ -277,7 +277,9 @@ static int bpf_tcp_ca_validate(void *kdata)
 	return tcp_validate_congestion_control(kdata);
 }
 
-struct bpf_struct_ops bpf_tcp_congestion_ops = {
+DEFINE_STRUCT_OPS_VALUE_TYPE(tcp_congestion_ops);
+
+static struct bpf_struct_ops bpf_tcp_congestion_ops = {
 	.verifier_ops = &bpf_tcp_ca_verifier_ops,
 	.reg = bpf_tcp_ca_reg,
 	.unreg = bpf_tcp_ca_unreg,
@@ -287,10 +289,16 @@ struct bpf_struct_ops bpf_tcp_congestion_ops = {
 	.init = bpf_tcp_ca_init,
 	.validate = bpf_tcp_ca_validate,
 	.name = "tcp_congestion_ops",
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


