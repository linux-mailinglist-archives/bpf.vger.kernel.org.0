Return-Path: <bpf+bounces-13832-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 531DF7DE6E4
	for <lists+bpf@lfdr.de>; Wed,  1 Nov 2023 21:46:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA0962819F5
	for <lists+bpf@lfdr.de>; Wed,  1 Nov 2023 20:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F1A51B293;
	Wed,  1 Nov 2023 20:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eTKxnsro"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C50A13AD1;
	Wed,  1 Nov 2023 20:45:42 +0000 (UTC)
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7571010E;
	Wed,  1 Nov 2023 13:45:37 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id 3f1490d57ef6-da3b4b7c6bdso192860276.2;
        Wed, 01 Nov 2023 13:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698871536; x=1699476336; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zTzg2VwC3TZhqkaaiosv1Z5tcrx/IRmW7+ggY0T7pIQ=;
        b=eTKxnsrojIMqAw1nAnCM4N3nqJB32qcgXNZ19hMggmzYgxpb5bDSv9pZjW/gzIBSaX
         zU+znqMBKKxBJNGBy98gaQXmv4Mjv69PtDwOkEFF/ILEAQPZrnQKMMtK38KNW3/X91Op
         u7YnUgO4LTrhSnm5XqxUhSd79CI9PKoN4ELBagQA1nt9hsrB0pz1hJvzt083ht40JIdV
         IzULYGswRmjO0/ICgzPvvhj5pL2QDyfPIb64YB2YZifaxG0ZZsAVYp+G8AibNw/EkXng
         u8zSslHjSyPYCkDCG2sFnPLiFLyvZz5/jh+UnhmoF2mkVbEodNX8HTecA/NZQxl6r+Rh
         WBmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698871536; x=1699476336;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zTzg2VwC3TZhqkaaiosv1Z5tcrx/IRmW7+ggY0T7pIQ=;
        b=UeoOvxyPBK6VoWXyi5ySN781DCUjO1kHxbqp8RX59wS1GbR5/S0lPleLA9j0ILrFcz
         41VGKhtZe50YcEe3kwFpYzGPedNpd/WHuOTYTzWJ7SARHokbC7q4D8+Li8vQi7g3pNQY
         YRtv0qGE6dhMhhLvPCnSQeV1tu4iSx9LTAO1kDcRVmTlmgKqsr7z43+G07MgIdyQDOUz
         6xbmeGI+7BGiO72bS6m5HQTea72/AwLh4HBtrwsazhSglCWOd146k70QavfScdV9hBSe
         FjNQAEJrErP9YZig/Mjm2sKw1KJQgQAZzaON/71V5xw113LXiPN/JVTtgV0Rcy5Q1052
         yd6w==
X-Gm-Message-State: AOJu0YyvBhh5yxQPrV2t/FwzpzujRBOt2xwnSc0mf30V2IcVPAjOTuIz
	jb8EN9/KlwcOT5A3mAnXdWBB3RS3/aA=
X-Google-Smtp-Source: AGHT+IFfwdbVbTWez273gbJU4zzf7auRMJXLmtxQatu+V8JDVKdfmCiaFWMiqwHU4zclaxA8aDqYig==
X-Received: by 2002:a25:8287:0:b0:d9a:4b0f:402b with SMTP id r7-20020a258287000000b00d9a4b0f402bmr16334127ybk.38.1698871536168;
        Wed, 01 Nov 2023 13:45:36 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:eea0:6f66:c57d:6b7c])
        by smtp.gmail.com with ESMTPSA id o83-20020a25d756000000b00da086d6921fsm342386ybg.50.2023.11.01.13.45.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Nov 2023 13:45:35 -0700 (PDT)
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
Subject: [PATCH bpf-next v9 09/12] bpf, net: switch to dynamic registration
Date: Wed,  1 Nov 2023 13:45:16 -0700
Message-Id: <20231101204519.677870-10-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231101204519.677870-1-thinker.li@gmail.com>
References: <20231101204519.677870-1-thinker.li@gmail.com>
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
 include/linux/bpf.h               | 24 +++++++--
 include/linux/btf.h               |  2 +
 kernel/bpf/bpf_struct_ops.c       | 90 ++++++++++---------------------
 kernel/bpf/bpf_struct_ops_types.h | 12 -----
 kernel/bpf/btf.c                  | 38 +++++++++++--
 net/bpf/bpf_dummy_struct_ops.c    | 14 ++++-
 net/ipv4/bpf_tcp_ca.c             | 16 ++++--
 7 files changed, 107 insertions(+), 89 deletions(-)
 delete mode 100644 kernel/bpf/bpf_struct_ops_types.h

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 2a9bc482d85e..785d53b5b8c7 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1643,7 +1643,6 @@ struct bpf_struct_ops_desc {
 #if defined(CONFIG_BPF_JIT) && defined(CONFIG_BPF_SYSCALL)
 #define BPF_MODULE_OWNER ((void *)((0xeB9FUL << 2) + POISON_POINTER_DELTA))
 const struct bpf_struct_ops_desc *bpf_struct_ops_find(struct btf *btf, u32 type_id);
-void bpf_struct_ops_init(struct btf *btf, struct bpf_verifier_log *log);
 bool bpf_struct_ops_get(const void *kdata);
 void bpf_struct_ops_put(const void *kdata);
 int bpf_struct_ops_map_sys_lookup_elem(struct bpf_map *map, void *key,
@@ -1689,10 +1688,6 @@ static inline const struct bpf_struct_ops_desc *bpf_struct_ops_find(struct btf *
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
@@ -3231,6 +3226,8 @@ static inline bool bpf_is_subprog(const struct bpf_prog *prog)
 	return prog->aux->func_idx != 0;
 }
 
+int register_bpf_struct_ops(struct bpf_struct_ops *st_ops);
+
 enum bpf_struct_ops_state {
 	BPF_STRUCT_OPS_STATE_INIT,
 	BPF_STRUCT_OPS_STATE_INUSE,
@@ -3243,4 +3240,21 @@ struct bpf_struct_ops_common_value {
 	enum bpf_struct_ops_state state;
 };
 
+/* bpf_struct_ops_##_name (e.g. bpf_struct_ops_tcp_congestion_ops) is
+ * the map's value exposed to the userspace and its btf-type-id is
+ * stored at the map->btf_vmlinux_value_type_id.
+ *
+ */
+#define DEFINE_STRUCT_OPS_VALUE_TYPE(_name)			\
+extern struct bpf_struct_ops bpf_##_name;			\
+								\
+struct bpf_struct_ops_##_name {					\
+	struct bpf_struct_ops_common_value common;		\
+	struct _name data ____cacheline_aligned_in_smp;		\
+}
+
+extern int bpf_struct_ops_desc_init(struct bpf_struct_ops_desc *st_ops_desc,
+				    struct btf *btf,
+				    struct bpf_verifier_log *log);
+
 #endif /* _LINUX_BPF_H */
diff --git a/include/linux/btf.h b/include/linux/btf.h
index e613b6b45dc4..91472d41ded7 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -12,6 +12,8 @@
 #include <uapi/linux/bpf.h>
 
 #define BTF_TYPE_EMIT(type) ((void)(type *)0)
+#define BTF_STRUCT_OPS_TYPE_EMIT(type) {((void)(struct type *)0);	\
+		((void)(struct bpf_struct_ops_##type *)0); }
 #define BTF_TYPE_EMIT_ENUM(enum_val) ((void)enum_val)
 
 /* These need to be macros, as the expressions are used in assembler input */
diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index 2d853431bf09..caacc251655a 100644
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
 		pr_warn("Cannot find struct %s in btf_vmlinux\n",
 			st_ops->name);
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
 		pr_warn("Cannot find struct %s in btf_vmlinux\n",
 			value_name);
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
index 2fd6fa0ea1f4..c8a1bdbe7d9a 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -5790,8 +5790,6 @@ struct btf *btf_parse_vmlinux(void)
 	/* btf_parse_vmlinux() runs under bpf_verifier_lock */
 	bpf_ctx_convert.t = btf_type_by_id(btf, bpf_ctx_convert_btf_id[0]);
 
-	bpf_struct_ops_init(btf, log);
-
 	refcount_set(&btf->refcnt, 1);
 
 	err = btf_alloc_id(btf);
@@ -8620,10 +8618,11 @@ bool btf_type_ids_nocast_alias(struct bpf_verifier_log *log,
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
@@ -8660,6 +8659,10 @@ btf_add_struct_ops(struct btf *btf, struct bpf_struct_ops *st_ops)
 
 	tab->ops[btf->struct_ops_tab->cnt].st_ops = st_ops;
 
+	err = bpf_struct_ops_desc_init(&tab->ops[btf->struct_ops_tab->cnt], btf, log);
+	if (err)
+		return err;
+
 	btf->struct_ops_tab->cnt++;
 
 	return 0;
@@ -8676,3 +8679,30 @@ const struct bpf_struct_ops_desc *btf_get_struct_ops(struct btf *btf, u32 *ret_c
 	return (const struct bpf_struct_ops_desc *)btf->struct_ops_tab->ops;
 }
 
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
index ffa224053a6c..148a5851c4fa 100644
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
@@ -235,4 +237,12 @@ struct bpf_struct_ops bpf_bpf_dummy_ops = {
 	.reg = bpf_dummy_reg,
 	.unreg = bpf_dummy_unreg,
 	.name = "bpf_dummy_ops",
+	.owner = THIS_MODULE,
 };
+
+static int __init bpf_dummy_struct_ops_init(void)
+{
+	BTF_STRUCT_OPS_TYPE_EMIT(bpf_dummy_ops);
+	return register_bpf_struct_ops(&bpf_bpf_dummy_ops);
+}
+late_initcall(bpf_dummy_struct_ops_init);
diff --git a/net/ipv4/bpf_tcp_ca.c b/net/ipv4/bpf_tcp_ca.c
index 3c8b76578a2a..b36a19274e5b 100644
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
@@ -287,10 +289,18 @@ struct bpf_struct_ops bpf_tcp_congestion_ops = {
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
+	BTF_STRUCT_OPS_TYPE_EMIT(tcp_congestion_ops);
+
+	ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS, &bpf_tcp_ca_kfunc_set);
+	ret = ret ?: register_bpf_struct_ops(&bpf_tcp_congestion_ops);
+
+	return ret;
 }
 late_initcall(bpf_tcp_ca_kfunc_init);
-- 
2.34.1


