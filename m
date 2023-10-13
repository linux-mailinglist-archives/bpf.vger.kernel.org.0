Return-Path: <bpf+bounces-12202-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2230F7C9064
	for <lists+bpf@lfdr.de>; Sat, 14 Oct 2023 00:43:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD81B282F65
	for <lists+bpf@lfdr.de>; Fri, 13 Oct 2023 22:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94EC32C85E;
	Fri, 13 Oct 2023 22:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QppqNun4"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1CA273E6;
	Fri, 13 Oct 2023 22:43:18 +0000 (UTC)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D205EC9;
	Fri, 13 Oct 2023 15:43:16 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-5a7fb84f6ceso30235227b3.1;
        Fri, 13 Oct 2023 15:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697236996; x=1697841796; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NnWq+uYNn+SsjJw/E+I7Mb11OXcmP1oROjW1ThmoOQs=;
        b=QppqNun4ripxtWtpCXovXywlAVtSlDTJ2RvGTfNO/oaucaD4nj0jAZMIhGMOuIZt0n
         nV8uev64453FpXAFlwrPne8S6/GsJWH1lE7AWxLXG5IgXZ0Oau18Qh4TbWLYhzSSMUmz
         xcUneLPvreRjmGMwT0Z5MNa70Qpz2ofas6tsd91EwMoEmFwx+VQ2CKJxGWMohNRd2wE7
         hXKEYPik5hOA1qc33iKbD7Yc2cSEGQ41oKyOzMbwsRUUGLeCDZSUihcyv1mr4Ay+gaCt
         w7ocLINql9eygiMT60rO1Pm7Mr3msefm7oBDI8PMnxA9PjXGXFDMFU90rjggVV0qdYDL
         yjqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697236996; x=1697841796;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NnWq+uYNn+SsjJw/E+I7Mb11OXcmP1oROjW1ThmoOQs=;
        b=MN3kljX//NnrpKsAc9kX60wXKenk+J3TcGDTMo8Bav3BmnhtAS37lFTEjlGvr2GCqy
         w5h+4JDA9X6VidOwSdTl7MqlCtR/mtOTE3tMP5iaTd1T1alk7o9ZXKuuI9hEgDxbk5vo
         tg2GXqqUfzFWEMJgeCmm/GdLOMyX56X+4g+jSGSiWZ0mSi4GlxAn5MbPlAAAv98Kss/2
         jTvzG40zdmNB+2EYuNC0D20xLeLTFSRuO258iv2YNLY9/zjRfza4yTgGMUfuyriSweH3
         4PovWMt1pnnws95bbM6cJ0UoR2ylWQak1PZyLYcptopMH3+IrEnZ8+04aJZBw1zYmCi8
         vNhg==
X-Gm-Message-State: AOJu0YxjKJL+wHT3YqYHDJEQ735N9C7U+bB0LtuCy10fB626IfjCXLG+
	OXHRfr+TPOMqyMPpvp4XtIGJiQGmoOU=
X-Google-Smtp-Source: AGHT+IGIXlVp1bZngQZCwIQ0UgKwq/AElC/bn8zIzWhvRM/lqahf4IFdBwLr91UPLcCZYsdedla/Nw==
X-Received: by 2002:a0d:d614:0:b0:5a7:dbf4:6a1e with SMTP id y20-20020a0dd614000000b005a7dbf46a1emr10290609ywd.33.1697236995750;
        Fri, 13 Oct 2023 15:43:15 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:df89:3514:fdf4:ee2])
        by smtp.gmail.com with ESMTPSA id g141-20020a0ddd93000000b00592548b2c47sm101989ywe.80.2023.10.13.15.43.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 15:43:15 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 6/9] bpf, net: switch to dynamic registration
Date: Fri, 13 Oct 2023 15:43:01 -0700
Message-Id: <20231013224304.187218-7-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231013224304.187218-1-thinker.li@gmail.com>
References: <20231013224304.187218-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Kui-Feng Lee <thinker.li@gmail.com>

Replace the static list of struct_ops types with pre-btf struct_ops_tab to
enable dynamic registration.

Both bpf_dummy_ops and bpf_tcp_ca now utilize the registration function
instead of being listed in bpf_struct_ops_types.h.

Cc: netdev@vger.kernel.org
Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 include/linux/bpf.h               |   2 +
 include/linux/btf.h               |  29 +++++++
 kernel/bpf/bpf_struct_ops.c       | 124 +++++++++++++++---------------
 kernel/bpf/bpf_struct_ops_types.h |  12 ---
 kernel/bpf/btf.c                  |   2 +-
 net/bpf/bpf_dummy_struct_ops.c    |  14 +++-
 net/ipv4/bpf_tcp_ca.c             |  16 +++-
 7 files changed, 119 insertions(+), 80 deletions(-)
 delete mode 100644 kernel/bpf/bpf_struct_ops_types.h

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 1e1647c8b0ce..b0f33147aa93 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -3207,4 +3207,6 @@ static inline bool bpf_is_subprog(const struct bpf_prog *prog)
 	return prog->aux->func_idx != 0;
 }
 
+int register_bpf_struct_ops(struct bpf_struct_ops *st_ops);
+
 #endif /* _LINUX_BPF_H */
diff --git a/include/linux/btf.h b/include/linux/btf.h
index aa2ba77648be..fdc83aa10462 100644
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
@@ -577,4 +580,30 @@ int btf_add_struct_ops(struct bpf_struct_ops *st_ops);
 const struct bpf_struct_ops **
 btf_get_struct_ops(struct btf *btf, u32 *ret_cnt);
 
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
+#define BPF_STRUCT_OPS_COMMON_VALUE struct bpf_struct_ops_common_value common
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
+	BPF_STRUCT_OPS_COMMON_VALUE;				\
+	struct _name data ____cacheline_aligned_in_smp;		\
+}
+
 #endif
diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index 60445ff32275..175068b083cb 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -13,19 +13,6 @@
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
 	BPF_STRUCT_OPS_COMMON_VALUE;
 	char data[] ____cacheline_aligned_in_smp;
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
-static struct bpf_struct_ops * const bpf_struct_ops[] = {
-#define BPF_STRUCT_OPS_TYPE(_name)				\
-	[BPF_STRUCT_OPS_TYPE_##_name] = &bpf_##_name,
-#include "bpf_struct_ops_types.h"
-#undef BPF_STRUCT_OPS_TYPE
-};
-
 const struct bpf_verifier_ops bpf_struct_ops_verifier_ops = {
 };
 
@@ -234,16 +192,51 @@ static void bpf_struct_ops_init_one(struct bpf_struct_ops *st_ops,
 
 }
 
+static int register_bpf_struct_ops_btf(struct bpf_struct_ops *st_ops,
+				       struct btf *btf)
+{
+	struct bpf_verifier_log *log;
+	int err;
+
+	if (st_ops == NULL)
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
+	bpf_struct_ops_init_one(st_ops, btf, st_ops->owner, log);
+
+	err = btf_add_struct_ops(st_ops);
+
+errout:
+	kfree(log);
+
+	return err;
+}
+
+int register_bpf_struct_ops(struct bpf_struct_ops *st_ops)
+{
+	struct btf *btf;
+	int err;
+
+	btf = btf_get_module_btf(st_ops->owner);
+	if (!btf)
+		return -EINVAL;
+	err = register_bpf_struct_ops_btf(st_ops, btf);
+	btf_put(btf);
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(register_bpf_struct_ops);
+
 void bpf_struct_ops_init(struct btf *btf, struct bpf_verifier_log *log)
 {
-	struct bpf_struct_ops *st_ops;
 	s32 module_id, common_value_id;
-	u32 i;
-
-	/* Ensure BTF type is emitted for "struct bpf_struct_ops_##_name" */
-#define BPF_STRUCT_OPS_TYPE(_name) BTF_TYPE_EMIT(struct bpf_struct_ops_##_name);
-#include "bpf_struct_ops_types.h"
-#undef BPF_STRUCT_OPS_TYPE
 
 	module_id = btf_find_by_name_kind(btf, "module", BTF_KIND_STRUCT);
 	if (module_id < 0) {
@@ -259,11 +252,6 @@ void bpf_struct_ops_init(struct btf *btf, struct bpf_verifier_log *log)
 		return;
 	}
 	common_value_type = btf_type_by_id(btf, common_value_id);
-
-	for (i = 0; i < ARRAY_SIZE(bpf_struct_ops); i++) {
-		st_ops = bpf_struct_ops[i];
-		bpf_struct_ops_init_one(st_ops, btf, NULL, log);
-	}
 }
 
 extern struct btf *btf_vmlinux;
@@ -271,32 +259,44 @@ extern struct btf *btf_vmlinux;
 static const struct bpf_struct_ops *
 bpf_struct_ops_find_value(struct btf *btf, u32 value_id)
 {
+	const struct bpf_struct_ops *st_ops = NULL;
+	const struct bpf_struct_ops **st_ops_list;
 	unsigned int i;
+	u32 cnt = 0;
 
 	if (!value_id || !btf_vmlinux)
 		return NULL;
 
-	for (i = 0; i < ARRAY_SIZE(bpf_struct_ops); i++) {
-		if (bpf_struct_ops[i]->value_id == value_id)
-			return bpf_struct_ops[i];
+	st_ops_list = btf_get_struct_ops(btf, &cnt);
+	for (i = 0; i < cnt; i++) {
+		if (st_ops_list[i]->value_id == value_id) {
+			st_ops = st_ops_list[i];
+			break;
+		}
 	}
 
-	return NULL;
+	return st_ops;
 }
 
 const struct bpf_struct_ops *bpf_struct_ops_find(struct btf *btf, u32 type_id)
 {
+	const struct bpf_struct_ops *st_ops = NULL;
+	const struct bpf_struct_ops **st_ops_list;
 	unsigned int i;
+	u32 cnt;
 
 	if (!type_id || !btf_vmlinux)
 		return NULL;
 
-	for (i = 0; i < ARRAY_SIZE(bpf_struct_ops); i++) {
-		if (bpf_struct_ops[i]->type_id == type_id)
-			return bpf_struct_ops[i];
+	st_ops_list = btf_get_struct_ops(btf, &cnt);
+	for (i = 0; i < cnt; i++) {
+		if (st_ops_list[i]->type_id == type_id) {
+			st_ops = st_ops_list[i];
+			break;
+		}
 	}
 
-	return NULL;
+	return st_ops;
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
index be5144dbb53d..990973d6057d 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -7532,7 +7532,7 @@ struct module *btf_try_get_module(const struct btf *btf)
 /* Returns struct btf corresponding to the struct module.
  * This function can return NULL or ERR_PTR.
  */
-static struct btf *btf_get_module_btf(const struct module *module)
+struct btf *btf_get_module_btf(const struct module *module)
 {
 #ifdef CONFIG_DEBUG_INFO_BTF_MODULES
 	struct btf_module *btf_mod, *tmp;
diff --git a/net/bpf/bpf_dummy_struct_ops.c b/net/bpf/bpf_dummy_struct_ops.c
index 5918d1b32e19..724bb7224079 100644
--- a/net/bpf/bpf_dummy_struct_ops.c
+++ b/net/bpf/bpf_dummy_struct_ops.c
@@ -7,7 +7,7 @@
 #include <linux/bpf.h>
 #include <linux/btf.h>
 
-extern struct bpf_struct_ops bpf_bpf_dummy_ops;
+static struct bpf_struct_ops bpf_bpf_dummy_ops;
 
 /* A common type for test_N with return value in bpf_dummy_ops */
 typedef int (*dummy_ops_test_ret_fn)(struct bpf_dummy_ops_state *state, ...);
@@ -216,11 +216,13 @@ static int bpf_dummy_reg(void *kdata)
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
@@ -228,4 +230,12 @@ struct bpf_struct_ops bpf_bpf_dummy_ops = {
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
index 39dcccf0f174..20c401c73dfb 100644
--- a/net/ipv4/bpf_tcp_ca.c
+++ b/net/ipv4/bpf_tcp_ca.c
@@ -12,7 +12,7 @@
 #include <net/bpf_sk_storage.h>
 
 /* "extern" is to avoid sparse warning.  It is only used in bpf_struct_ops.c. */
-extern struct bpf_struct_ops bpf_tcp_congestion_ops;
+static struct bpf_struct_ops bpf_tcp_congestion_ops;
 
 static u32 unsupported_ops[] = {
 	offsetof(struct tcp_congestion_ops, get_info),
@@ -271,7 +271,9 @@ static int bpf_tcp_ca_validate(void *kdata)
 	return tcp_validate_congestion_control(kdata);
 }
 
-struct bpf_struct_ops bpf_tcp_congestion_ops = {
+DEFINE_STRUCT_OPS_VALUE_TYPE(tcp_congestion_ops);
+
+static struct bpf_struct_ops bpf_tcp_congestion_ops = {
 	.verifier_ops = &bpf_tcp_ca_verifier_ops,
 	.reg = bpf_tcp_ca_reg,
 	.unreg = bpf_tcp_ca_unreg,
@@ -281,10 +283,18 @@ struct bpf_struct_ops bpf_tcp_congestion_ops = {
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


