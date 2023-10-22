Return-Path: <bpf+bounces-12931-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC7237D2115
	for <lists+bpf@lfdr.de>; Sun, 22 Oct 2023 07:04:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6A0D1C20A40
	for <lists+bpf@lfdr.de>; Sun, 22 Oct 2023 05:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 275371FDA;
	Sun, 22 Oct 2023 05:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HSBwc7OQ"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A1C110C;
	Sun, 22 Oct 2023 05:03:58 +0000 (UTC)
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E9DBDA;
	Sat, 21 Oct 2023 22:03:56 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-1e19cb7829bso1717589fac.1;
        Sat, 21 Oct 2023 22:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697951035; x=1698555835; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lln47024wBFCzUmM7hDMJPyJpoeyc5OjBtb6TFnVVAU=;
        b=HSBwc7OQNuBc718dw9bgtuV6/KM7dI0jYlBilMwFPaCQQ04f2Z5Ekw6WM6KIGvcuDM
         JPCq3/bo4VTttWtdoGk6O6i32Mhfq+0VSbY9f7COWBvrvPOJHvdwih9y3RD6bAvYYVdI
         0bpoBLJ4Lkahd581lLFecJX8PFpATxbvz9BPHwIYY/LJGXx/QEbapWQmDSPXczreqkGd
         0sSyQR5RqTA1WgAx+8ILR4e898oXWZcT0Im5H4qHZWrQTSrN7Kw6Xpzx/eweW3Z/tPpX
         yXM47DhvpZK3KIWv2PsCEOniL+e2R7pLZ2jDbPPnzzQ5dZc9/CD/KY1klI9MfQymVSSB
         iM+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697951035; x=1698555835;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lln47024wBFCzUmM7hDMJPyJpoeyc5OjBtb6TFnVVAU=;
        b=E8qR8dDIjBiUyy80/awBwhsGwIzgS24Z3tFWBCFnLBt2a6FUW+GJpJ+R8bDXD/eXne
         JiYcZUASEdxVI2tDG9OmHub7WYkXDdxkom3x40g+uKuWfA1nxqK0hS7CHnSeWMYF7e4L
         kYCH4IflEuSNoEYgHeDQM2UdpBRLYsyquPKTSbUSekyE35qbd/Go2wPrUOMiE/TEUjKb
         7XvMdikximz2xIxzFk9Y9T9SF9Ft50j/LbLMG5GsldL1nMnKhiFClFSh3f00M6ZYfrLR
         dryHWWaj/OT2NYFMuZz8hz99z44bNgU+QdC8kKHZZuhXRx4LqkXCQ9NQBkYa1qG4BpsP
         7NZA==
X-Gm-Message-State: AOJu0Yzyd4HRmxU/YU5H4UptfLKlF7WUjmntTOGof1WrmQOyBQrfp0LF
	OyUXU1kZCi+nVfZyCohjw+Kvi2td+mc=
X-Google-Smtp-Source: AGHT+IF8H3Oid96AHJUlbWUwDfRphJkoR31iSEKG6HJssA49NaL/2xTHsQHLxuj5nTZhS0UYMHX1YA==
X-Received: by 2002:a05:6870:7e0e:b0:1ea:2506:3e90 with SMTP id wx14-20020a0568707e0e00b001ea25063e90mr8283895oab.35.1697951035547;
        Sat, 21 Oct 2023 22:03:55 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:9904:3214:88c1:e733])
        by smtp.gmail.com with ESMTPSA id j1-20020a0de001000000b005a8c392f498sm2035169ywe.82.2023.10.21.22.03.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Oct 2023 22:03:55 -0700 (PDT)
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
Subject: [PATCH bpf-next v6 07/10] bpf, net: switch to dynamic registration
Date: Sat, 21 Oct 2023 22:03:32 -0700
Message-Id: <20231022050335.2579051-8-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231022050335.2579051-1-thinker.li@gmail.com>
References: <20231022050335.2579051-1-thinker.li@gmail.com>
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
 include/linux/bpf.h               |  36 +++++++--
 include/linux/btf.h               |   5 +-
 kernel/bpf/bpf_struct_ops.c       | 123 ++++++++----------------------
 kernel/bpf/bpf_struct_ops_types.h |  12 ---
 kernel/bpf/btf.c                  |  41 +++++++++-
 net/bpf/bpf_dummy_struct_ops.c    |  14 +++-
 net/ipv4/bpf_tcp_ca.c             |  16 +++-
 7 files changed, 130 insertions(+), 117 deletions(-)
 delete mode 100644 kernel/bpf/bpf_struct_ops_types.h

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 26feb8a2da4f..a53b2181c845 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1644,7 +1644,6 @@ struct bpf_struct_ops_desc {
 #if defined(CONFIG_BPF_JIT) && defined(CONFIG_BPF_SYSCALL)
 #define BPF_MODULE_OWNER ((void *)((0xeB9FUL << 2) + POISON_POINTER_DELTA))
 const struct bpf_struct_ops_desc *bpf_struct_ops_find(struct btf *btf, u32 type_id);
-void bpf_struct_ops_init(struct btf *btf, struct bpf_verifier_log *log);
 bool bpf_struct_ops_get(const void *kdata);
 void bpf_struct_ops_put(const void *kdata);
 int bpf_struct_ops_map_sys_lookup_elem(struct bpf_map *map, void *key,
@@ -1690,10 +1689,6 @@ static inline const struct bpf_struct_ops_desc *bpf_struct_ops_find(struct btf *
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
@@ -3212,4 +3207,35 @@ static inline bool bpf_is_subprog(const struct bpf_prog *prog)
 	return prog->aux->func_idx != 0;
 }
 
+int register_bpf_struct_ops(struct bpf_struct_ops *st_ops);
+
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
+extern void bpf_struct_ops_init(struct bpf_struct_ops_desc *st_ops_desc,
+				struct btf *btf,
+				struct bpf_verifier_log *log);
+
 #endif /* _LINUX_BPF_H */
diff --git a/include/linux/btf.h b/include/linux/btf.h
index 6a64b372b7a0..533db3f406b3 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -12,6 +12,8 @@
 #include <uapi/linux/bpf.h>
 
 #define BTF_TYPE_EMIT(type) ((void)(type *)0)
+#define BTF_STRUCT_OPS_TYPE_EMIT(type) {((void)(struct type *)0);	\
+		((void)(struct bpf_struct_ops_##type *)0); }
 #define BTF_TYPE_EMIT_ENUM(enum_val) ((void)enum_val)
 
 /* These need to be macros, as the expressions are used in assembler input */
@@ -200,6 +202,7 @@ u32 btf_obj_id(const struct btf *btf);
 bool btf_is_kernel(const struct btf *btf);
 bool btf_is_module(const struct btf *btf);
 struct module *btf_try_get_module(const struct btf *btf);
+struct btf *btf_get_module_btf(const struct module *module);
 u32 btf_nr_types(const struct btf *btf);
 bool btf_member_is_reg_int(const struct btf *btf, const struct btf_type *s,
 			   const struct btf_member *m,
@@ -574,8 +577,6 @@ static inline bool btf_type_is_struct_ptr(struct btf *btf, const struct btf_type
 struct bpf_struct_ops;
 struct bpf_struct_ops_desc;
 
-struct bpf_struct_ops_desc *
-btf_add_struct_ops(struct btf *btf, struct bpf_struct_ops *st_ops);
 const struct bpf_struct_ops_desc *
 btf_get_struct_ops(struct btf *btf, u32 *ret_cnt);
 
diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index 99ab61cc6cad..44412f95bc32 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -13,21 +13,8 @@
 #include <linux/btf_ids.h>
 #include <linux/rcupdate_wait.h>
 
-enum bpf_struct_ops_state {
-	BPF_STRUCT_OPS_STATE_INIT,
-	BPF_STRUCT_OPS_STATE_INUSE,
-	BPF_STRUCT_OPS_STATE_TOBEFREE,
-	BPF_STRUCT_OPS_STATE_READY,
-};
-
-struct bpf_struct_ops_common_value {
-	refcount_t refcnt;
-	enum bpf_struct_ops_state state;
-};
-#define BPF_STRUCT_OPS_COMMON_VALUE struct bpf_struct_ops_common_value common
-
 struct bpf_struct_ops_value {
-	BPF_STRUCT_OPS_COMMON_VALUE;
+	struct bpf_struct_ops_common_value common;
 	char data[] ____cacheline_aligned_in_smp;
 };
 
@@ -72,35 +59,6 @@ static DEFINE_MUTEX(update_mutex);
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
-struct bpf_struct_ops_##_name {						\
-	BPF_STRUCT_OPS_COMMON_VALUE;				\
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
 
@@ -110,13 +68,22 @@ const struct bpf_prog_ops bpf_struct_ops_prog_ops = {
 #endif
 };
 
-static const struct btf_type *module_type;
-static const struct btf_type *common_value_type;
+BTF_ID_LIST(st_ops_ids)
+BTF_ID(struct, module)
+BTF_ID(struct, bpf_struct_ops_common_value)
+
+enum {
+	idx_module_id,
+	idx_st_ops_common_value_id,
+};
+
+extern struct btf *btf_vmlinux;
 
 static bool is_valid_value_type(struct btf *btf, s32 value_id,
 				const struct btf_type *type,
 				const char *value_name)
 {
+	const struct btf_type *common_value_type;
 	const struct btf_member *member;
 	const struct btf_type *vt, *mt;
 
@@ -128,6 +95,8 @@ static bool is_valid_value_type(struct btf *btf, s32 value_id,
 	}
 	member = btf_type_member(vt);
 	mt = btf_type_by_id(btf, member->type);
+	common_value_type = btf_type_by_id(btf_vmlinux,
+					   st_ops_ids[idx_st_ops_common_value_id]);
 	if (mt != common_value_type) {
 		pr_warn("The first member of %s should be bpf_struct_ops_common_value\n",
 			value_name);
@@ -144,9 +113,9 @@ static bool is_valid_value_type(struct btf *btf, s32 value_id,
 	return true;
 }
 
-static void bpf_struct_ops_init_one(struct bpf_struct_ops_desc *st_ops_desc,
-				    struct btf *btf,
-				    struct bpf_verifier_log *log)
+void bpf_struct_ops_init(struct bpf_struct_ops_desc *st_ops_desc,
+			 struct btf *btf,
+			 struct bpf_verifier_log *log)
 {
 	struct bpf_struct_ops *st_ops = st_ops_desc->st_ops;
 	const struct btf_member *member;
@@ -232,51 +201,20 @@ static void bpf_struct_ops_init_one(struct bpf_struct_ops_desc *st_ops_desc,
 	}
 }
 
-void bpf_struct_ops_init(struct btf *btf, struct bpf_verifier_log *log)
-{
-	struct bpf_struct_ops_desc *st_ops_desc;
-	s32 module_id, common_value_id;
-	u32 i;
-
-	/* Ensure BTF type is emitted for "struct bpf_struct_ops_##_name" */
-#define BPF_STRUCT_OPS_TYPE(_name) BTF_TYPE_EMIT(struct bpf_struct_ops_##_name);
-#include "bpf_struct_ops_types.h"
-#undef BPF_STRUCT_OPS_TYPE
-
-	module_id = btf_find_by_name_kind(btf, "module", BTF_KIND_STRUCT);
-	if (module_id < 0) {
-		pr_warn("Cannot find struct module in btf_vmlinux\n");
-		return;
-	}
-	module_type = btf_type_by_id(btf, module_id);
-	common_value_id = btf_find_by_name_kind(btf,
-						"bpf_struct_ops_common_value",
-						BTF_KIND_STRUCT);
-	if (common_value_id < 0) {
-		pr_warn("Cannot find struct common_value in btf_vmlinux\n");
-		return;
-	}
-	common_value_type = btf_type_by_id(btf, common_value_id);
-
-	for (i = 0; i < ARRAY_SIZE(bpf_struct_ops); i++) {
-		st_ops_desc = &bpf_struct_ops[i];
-		bpf_struct_ops_init_one(st_ops_desc, btf, log);
-	}
-}
-
-extern struct btf *btf_vmlinux;
-
 static const struct bpf_struct_ops_desc *
 bpf_struct_ops_find_value(struct btf *btf, u32 value_id)
 {
+	const struct bpf_struct_ops_desc *st_ops_list;
 	unsigned int i;
+	u32 cnt = 0;
 
-	if (!value_id || !btf_vmlinux)
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
@@ -285,14 +223,17 @@ bpf_struct_ops_find_value(struct btf *btf, u32 value_id)
 const struct bpf_struct_ops_desc *
 bpf_struct_ops_find(struct btf *btf, u32 type_id)
 {
+	const struct bpf_struct_ops_desc *st_ops_list;
 	unsigned int i;
+	u32 cnt;
 
-	if (!type_id || !btf_vmlinux)
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
@@ -429,6 +370,7 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
 	const struct bpf_struct_ops_desc *st_ops_desc = st_map->st_ops_desc;
 	const struct bpf_struct_ops *st_ops = st_ops_desc->st_ops;
 	struct bpf_struct_ops_value *uvalue, *kvalue;
+	const struct btf_type *module_type;
 	const struct btf_member *member;
 	const struct btf_type *t = st_ops_desc->type;
 	struct bpf_tramp_links *tlinks;
@@ -485,6 +427,7 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
 	image = st_map->image;
 	image_end = st_map->image + PAGE_SIZE;
 
+	module_type = btf_type_by_id(btf_vmlinux, st_ops_ids[idx_module_id]);
 	for_each_member(i, t, member) {
 		const struct btf_type *mtype, *ptype;
 		struct bpf_prog *prog;
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
index c1e2ed6c972e..c53888e8dddb 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -5790,8 +5790,6 @@ struct btf *btf_parse_vmlinux(void)
 	/* btf_parse_vmlinux() runs under bpf_verifier_lock */
 	bpf_ctx_convert.t = btf_type_by_id(btf, bpf_ctx_convert_btf_id[0]);
 
-	bpf_struct_ops_init(btf, log);
-
 	refcount_set(&btf->refcnt, 1);
 
 	err = btf_alloc_id(btf);
@@ -7532,7 +7530,7 @@ struct module *btf_try_get_module(const struct btf *btf)
 /* Returns struct btf corresponding to the struct module.
  * This function can return NULL or ERR_PTR.
  */
-static struct btf *btf_get_module_btf(const struct module *module)
+struct btf *btf_get_module_btf(const struct module *module)
 {
 #ifdef CONFIG_DEBUG_INFO_BTF_MODULES
 	struct btf_module *btf_mod, *tmp;
@@ -8672,3 +8670,40 @@ const struct bpf_struct_ops_desc *btf_get_struct_ops(struct btf *btf, u32 *ret_c
 	return (const struct bpf_struct_ops_desc *)btf->struct_ops_tab->ops;
 }
 
+int register_bpf_struct_ops(struct bpf_struct_ops *st_ops)
+{
+	struct bpf_struct_ops_desc *desc;
+	struct bpf_verifier_log *log;
+	struct btf *btf;
+	int err = 0;
+
+	if (st_ops == NULL)
+		return -EINVAL;
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
+	desc = btf_add_struct_ops(btf, st_ops);
+	if (IS_ERR(desc)) {
+		err = PTR_ERR(desc);
+		goto errout;
+	}
+
+	bpf_struct_ops_init(desc, btf, log);
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


