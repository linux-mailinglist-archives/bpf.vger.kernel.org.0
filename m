Return-Path: <bpf+bounces-13824-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 772F97DE6D7
	for <lists+bpf@lfdr.de>; Wed,  1 Nov 2023 21:45:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8880D1C20E61
	for <lists+bpf@lfdr.de>; Wed,  1 Nov 2023 20:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D9C214F6E;
	Wed,  1 Nov 2023 20:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lQhZCwSX"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1FFB12B82;
	Wed,  1 Nov 2023 20:45:33 +0000 (UTC)
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07CEC10C;
	Wed,  1 Nov 2023 13:45:29 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-5a8ada42c2aso2832517b3.3;
        Wed, 01 Nov 2023 13:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698871528; x=1699476328; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dIn+7D7kbyaABL35TWxnNP4kzVAJSKlk5U2plCsCDqY=;
        b=lQhZCwSXcbV1ryRxeZJH4buPRPDbJ7hcDjoo6WH++0R/II/p9E/G203F63JN7Gr1KZ
         uhhwLjEtgh4VU9HmlwSM8WVaIbZ6O4ZqcU2gsLzpikMZ7/ezVA0Zq87Y2rY8pxJQ4Oit
         jq/V6pxqzzPNlY+2GjUJ9j5pIhTMrHdkoXMrT5gmH2YFWFG1pVu2N1mROONdNqP0sW8a
         RzeGEgKQOw7VeZ0PVMNZZw3r7LkGzt4+t6V8O/Y9O9NFma91jxcQm3A5SWmuAagptjmH
         PUaALfe4Xu051E4r+gt+CQDnBMnaotxNTQEHF+mcfdn7qzmHkvlUJNU1u631wSBRrUvQ
         GlMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698871528; x=1699476328;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dIn+7D7kbyaABL35TWxnNP4kzVAJSKlk5U2plCsCDqY=;
        b=hdxC7ntxz5KkLqM/OoT5JTcDnuLeDk1vASVYnj0vGu7/1wRVrT9pad3DPstV/xbSqb
         AdVr3qnY59b4ZOpjPmPunkdvAzfYI9Ut9n14pcFPU+m4JwgLINyRaQK9T9IJS3+y0aEl
         v0ZOwUVXtbc3o0JZZhK/hHVjw9yy5VGNF3Y3jM5C/xxeDDL4vdmwHHBmnzQ7kR/x0Z4C
         /zthxmr6SlXwHhW0cBKh1Da6J64FjA5XDgoTbPqvRg1Ls2HdDaCSnOCzFoMxQ+5z7p7E
         r+gtXOUjuNXrO7e2SiuoBoDF8gdcMKppTr9c+VD+0SS3507sI8DaXtVE1dDMNPWRFZD1
         G+eA==
X-Gm-Message-State: AOJu0YxCOcM2/eJx/ksRADankBPiTQPO5AVO0+fApvjt+Jko9MUN98nK
	M6/up+fiFGLONiOVp1iFu7xXfcemu2Y=
X-Google-Smtp-Source: AGHT+IFuRKSkNV6p1wL3kji9WAeA32yFHMwAWUTKcWawdVrIu2JRuE1rbc32eUg38jRiHwRsZARS0g==
X-Received: by 2002:a25:7485:0:b0:d81:89e9:9f48 with SMTP id p127-20020a257485000000b00d8189e99f48mr15045258ybc.63.1698871527847;
        Wed, 01 Nov 2023 13:45:27 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:eea0:6f66:c57d:6b7c])
        by smtp.gmail.com with ESMTPSA id o83-20020a25d756000000b00da086d6921fsm342386ybg.50.2023.11.01.13.45.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Nov 2023 13:45:27 -0700 (PDT)
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
Subject: [PATCH bpf-next v9 03/12] bpf, net: introduce bpf_struct_ops_desc.
Date: Wed,  1 Nov 2023 13:45:10 -0700
Message-Id: <20231101204519.677870-4-thinker.li@gmail.com>
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

Move some of members of bpf_struct_ops to bpf_struct_ops_desc.  When we
introduce the APIs to register new bpf_struct_ops types from modules,
bpf_struct_ops may destroyed when the module is unloaded.  Moving these
members to bpf_struct_ops_desc make these data available even the module is
unloaded.

Cc: netdev@vger.kernel.org
Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 include/linux/bpf.h            | 13 ++++--
 kernel/bpf/bpf_struct_ops.c    | 80 +++++++++++++++++-----------------
 kernel/bpf/verifier.c          |  8 ++--
 net/bpf/bpf_dummy_struct_ops.c |  9 +++-
 net/ipv4/bpf_tcp_ca.c          |  8 +++-
 5 files changed, 70 insertions(+), 48 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index b4825d3cdb29..b55e27162df0 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1626,17 +1626,22 @@ struct bpf_struct_ops {
 	void (*unreg)(void *kdata);
 	int (*update)(void *kdata, void *old_kdata);
 	int (*validate)(void *kdata);
-	const struct btf_type *type;
-	const struct btf_type *value_type;
 	const char *name;
 	struct btf_func_model func_models[BPF_STRUCT_OPS_MAX_NR_MEMBERS];
+};
+
+struct bpf_struct_ops_desc {
+	struct bpf_struct_ops *st_ops;
+
+	const struct btf_type *type;
+	const struct btf_type *value_type;
 	u32 type_id;
 	u32 value_id;
 };
 
 #if defined(CONFIG_BPF_JIT) && defined(CONFIG_BPF_SYSCALL)
 #define BPF_MODULE_OWNER ((void *)((0xeB9FUL << 2) + POISON_POINTER_DELTA))
-const struct bpf_struct_ops *bpf_struct_ops_find(u32 type_id);
+const struct bpf_struct_ops_desc *bpf_struct_ops_find(u32 type_id);
 void bpf_struct_ops_init(struct btf *btf, struct bpf_verifier_log *log);
 bool bpf_struct_ops_get(const void *kdata);
 void bpf_struct_ops_put(const void *kdata);
@@ -1679,7 +1684,7 @@ int bpf_struct_ops_test_run(struct bpf_prog *prog, const union bpf_attr *kattr,
 			    union bpf_attr __user *uattr);
 #endif
 #else
-static inline const struct bpf_struct_ops *bpf_struct_ops_find(u32 type_id)
+static inline const struct bpf_struct_ops_desc *bpf_struct_ops_find(u32 type_id)
 {
 	return NULL;
 }
diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index 4ca4ca4998e0..d804801c7864 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -32,7 +32,7 @@ struct bpf_struct_ops_value {
 struct bpf_struct_ops_map {
 	struct bpf_map map;
 	struct rcu_head rcu;
-	const struct bpf_struct_ops *st_ops;
+	const struct bpf_struct_ops_desc *st_ops_desc;
 	/* protect map_update */
 	struct mutex lock;
 	/* link has all the bpf_links that is populated
@@ -92,9 +92,9 @@ enum {
 	__NR_BPF_STRUCT_OPS_TYPE,
 };
 
-static struct bpf_struct_ops * const bpf_struct_ops[] = {
+static struct bpf_struct_ops_desc bpf_struct_ops[] = {
 #define BPF_STRUCT_OPS_TYPE(_name)				\
-	[BPF_STRUCT_OPS_TYPE_##_name] = &bpf_##_name,
+	[BPF_STRUCT_OPS_TYPE_##_name] = { .st_ops = &bpf_##_name },
 #include "bpf_struct_ops_types.h"
 #undef BPF_STRUCT_OPS_TYPE
 };
@@ -115,10 +115,11 @@ enum {
 	IDX_MODULE_ID,
 };
 
-static void bpf_struct_ops_init_one(struct bpf_struct_ops *st_ops,
-				    struct btf *btf,
-				    struct bpf_verifier_log *log)
+static void bpf_struct_ops_desc_init(struct bpf_struct_ops_desc *st_ops_desc,
+				     struct btf *btf,
+				     struct bpf_verifier_log *log)
 {
+	struct bpf_struct_ops *st_ops = st_ops_desc->st_ops;
 	const struct btf_member *member;
 	const struct btf_type *t;
 	s32 type_id, value_id;
@@ -190,18 +191,18 @@ static void bpf_struct_ops_init_one(struct bpf_struct_ops *st_ops,
 			pr_warn("Error in init bpf_struct_ops %s\n",
 				st_ops->name);
 		} else {
-			st_ops->type_id = type_id;
-			st_ops->type = t;
-			st_ops->value_id = value_id;
-			st_ops->value_type = btf_type_by_id(btf,
-							    value_id);
+			st_ops_desc->type_id = type_id;
+			st_ops_desc->type = t;
+			st_ops_desc->value_id = value_id;
+			st_ops_desc->value_type = btf_type_by_id(btf,
+								 value_id);
 		}
 	}
 }
 
 void bpf_struct_ops_init(struct btf *btf, struct bpf_verifier_log *log)
 {
-	struct bpf_struct_ops *st_ops;
+	struct bpf_struct_ops_desc *st_ops_desc;
 	u32 i;
 
 	/* Ensure BTF type is emitted for "struct bpf_struct_ops_##_name" */
@@ -210,14 +211,14 @@ void bpf_struct_ops_init(struct btf *btf, struct bpf_verifier_log *log)
 #undef BPF_STRUCT_OPS_TYPE
 
 	for (i = 0; i < ARRAY_SIZE(bpf_struct_ops); i++) {
-		st_ops = bpf_struct_ops[i];
-		bpf_struct_ops_init_one(st_ops, btf, log);
+		st_ops_desc = &bpf_struct_ops[i];
+		bpf_struct_ops_desc_init(st_ops_desc, btf, log);
 	}
 }
 
 extern struct btf *btf_vmlinux;
 
-static const struct bpf_struct_ops *
+static const struct bpf_struct_ops_desc *
 bpf_struct_ops_find_value(u32 value_id)
 {
 	unsigned int i;
@@ -226,14 +227,14 @@ bpf_struct_ops_find_value(u32 value_id)
 		return NULL;
 
 	for (i = 0; i < ARRAY_SIZE(bpf_struct_ops); i++) {
-		if (bpf_struct_ops[i]->value_id == value_id)
-			return bpf_struct_ops[i];
+		if (bpf_struct_ops[i].value_id == value_id)
+			return &bpf_struct_ops[i];
 	}
 
 	return NULL;
 }
 
-const struct bpf_struct_ops *bpf_struct_ops_find(u32 type_id)
+const struct bpf_struct_ops_desc *bpf_struct_ops_find(u32 type_id)
 {
 	unsigned int i;
 
@@ -241,8 +242,8 @@ const struct bpf_struct_ops *bpf_struct_ops_find(u32 type_id)
 		return NULL;
 
 	for (i = 0; i < ARRAY_SIZE(bpf_struct_ops); i++) {
-		if (bpf_struct_ops[i]->type_id == type_id)
-			return bpf_struct_ops[i];
+		if (bpf_struct_ops[i].type_id == type_id)
+			return &bpf_struct_ops[i];
 	}
 
 	return NULL;
@@ -302,7 +303,7 @@ static void *bpf_struct_ops_map_lookup_elem(struct bpf_map *map, void *key)
 
 static void bpf_struct_ops_map_put_progs(struct bpf_struct_ops_map *st_map)
 {
-	const struct btf_type *t = st_map->st_ops->type;
+	const struct btf_type *t = st_map->st_ops_desc->type;
 	u32 i;
 
 	for (i = 0; i < btf_type_vlen(t); i++) {
@@ -376,11 +377,12 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
 					   void *value, u64 flags)
 {
 	struct bpf_struct_ops_map *st_map = (struct bpf_struct_ops_map *)map;
-	const struct bpf_struct_ops *st_ops = st_map->st_ops;
+	const struct bpf_struct_ops_desc *st_ops_desc = st_map->st_ops_desc;
+	const struct bpf_struct_ops *st_ops = st_ops_desc->st_ops;
 	struct bpf_struct_ops_value *uvalue, *kvalue;
 	const struct btf_type *module_type;
 	const struct btf_member *member;
-	const struct btf_type *t = st_ops->type;
+	const struct btf_type *t = st_ops_desc->type;
 	struct bpf_tramp_links *tlinks;
 	void *udata, *kdata;
 	int prog_fd, err;
@@ -393,7 +395,7 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
 	if (*(u32 *)key != 0)
 		return -E2BIG;
 
-	err = check_zero_holes(st_ops->value_type, value);
+	err = check_zero_holes(st_ops_desc->value_type, value);
 	if (err)
 		return err;
 
@@ -486,7 +488,7 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
 		}
 
 		if (prog->type != BPF_PROG_TYPE_STRUCT_OPS ||
-		    prog->aux->attach_btf_id != st_ops->type_id ||
+		    prog->aux->attach_btf_id != st_ops_desc->type_id ||
 		    prog->expected_attach_type != i) {
 			bpf_prog_put(prog);
 			err = -EINVAL;
@@ -582,7 +584,7 @@ static long bpf_struct_ops_map_delete_elem(struct bpf_map *map, void *key)
 			     BPF_STRUCT_OPS_STATE_TOBEFREE);
 	switch (prev_state) {
 	case BPF_STRUCT_OPS_STATE_INUSE:
-		st_map->st_ops->unreg(&st_map->kvalue.data);
+		st_map->st_ops_desc->st_ops->unreg(&st_map->kvalue.data);
 		bpf_map_put(map);
 		return 0;
 	case BPF_STRUCT_OPS_STATE_TOBEFREE:
@@ -663,22 +665,22 @@ static int bpf_struct_ops_map_alloc_check(union bpf_attr *attr)
 
 static struct bpf_map *bpf_struct_ops_map_alloc(union bpf_attr *attr)
 {
-	const struct bpf_struct_ops *st_ops;
+	const struct bpf_struct_ops_desc *st_ops_desc;
 	size_t st_map_size;
 	struct bpf_struct_ops_map *st_map;
 	const struct btf_type *t, *vt;
 	struct bpf_map *map;
 	int ret;
 
-	st_ops = bpf_struct_ops_find_value(attr->btf_vmlinux_value_type_id);
-	if (!st_ops)
+	st_ops_desc = bpf_struct_ops_find_value(attr->btf_vmlinux_value_type_id);
+	if (!st_ops_desc)
 		return ERR_PTR(-ENOTSUPP);
 
-	vt = st_ops->value_type;
+	vt = st_ops_desc->value_type;
 	if (attr->value_size != vt->size)
 		return ERR_PTR(-EINVAL);
 
-	t = st_ops->type;
+	t = st_ops_desc->type;
 
 	st_map_size = sizeof(*st_map) +
 		/* kvalue stores the
@@ -690,7 +692,7 @@ static struct bpf_map *bpf_struct_ops_map_alloc(union bpf_attr *attr)
 	if (!st_map)
 		return ERR_PTR(-ENOMEM);
 
-	st_map->st_ops = st_ops;
+	st_map->st_ops_desc = st_ops_desc;
 	map = &st_map->map;
 
 	ret = bpf_jit_charge_modmem(PAGE_SIZE);
@@ -728,8 +730,8 @@ static struct bpf_map *bpf_struct_ops_map_alloc(union bpf_attr *attr)
 static u64 bpf_struct_ops_map_mem_usage(const struct bpf_map *map)
 {
 	struct bpf_struct_ops_map *st_map = (struct bpf_struct_ops_map *)map;
-	const struct bpf_struct_ops *st_ops = st_map->st_ops;
-	const struct btf_type *vt = st_ops->value_type;
+	const struct bpf_struct_ops_desc *st_ops_desc = st_map->st_ops_desc;
+	const struct btf_type *vt = st_ops_desc->value_type;
 	u64 usage;
 
 	usage = sizeof(*st_map) +
@@ -803,7 +805,7 @@ static void bpf_struct_ops_map_link_dealloc(struct bpf_link *link)
 		/* st_link->map can be NULL if
 		 * bpf_struct_ops_link_create() fails to register.
 		 */
-		st_map->st_ops->unreg(&st_map->kvalue.data);
+		st_map->st_ops_desc->st_ops->unreg(&st_map->kvalue.data);
 		bpf_map_put(&st_map->map);
 	}
 	kfree(st_link);
@@ -850,7 +852,7 @@ static int bpf_struct_ops_map_link_update(struct bpf_link *link, struct bpf_map
 	if (!bpf_struct_ops_valid_to_reg(new_map))
 		return -EINVAL;
 
-	if (!st_map->st_ops->update)
+	if (!st_map->st_ops_desc->st_ops->update)
 		return -EOPNOTSUPP;
 
 	mutex_lock(&update_mutex);
@@ -863,12 +865,12 @@ static int bpf_struct_ops_map_link_update(struct bpf_link *link, struct bpf_map
 
 	old_st_map = container_of(old_map, struct bpf_struct_ops_map, map);
 	/* The new and old struct_ops must be the same type. */
-	if (st_map->st_ops != old_st_map->st_ops) {
+	if (st_map->st_ops_desc != old_st_map->st_ops_desc) {
 		err = -EINVAL;
 		goto err_out;
 	}
 
-	err = st_map->st_ops->update(st_map->kvalue.data, old_st_map->kvalue.data);
+	err = st_map->st_ops_desc->st_ops->update(st_map->kvalue.data, old_st_map->kvalue.data);
 	if (err)
 		goto err_out;
 
@@ -919,7 +921,7 @@ int bpf_struct_ops_link_create(union bpf_attr *attr)
 	if (err)
 		goto err_out;
 
-	err = st_map->st_ops->reg(st_map->kvalue.data);
+	err = st_map->st_ops_desc->st_ops->reg(st_map->kvalue.data);
 	if (err) {
 		bpf_link_cleanup(&link_primer);
 		link = NULL;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 857d76694517..290e3a7ee72f 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -20081,6 +20081,7 @@ static void print_verification_stats(struct bpf_verifier_env *env)
 static int check_struct_ops_btf_id(struct bpf_verifier_env *env)
 {
 	const struct btf_type *t, *func_proto;
+	const struct bpf_struct_ops_desc *st_ops_desc;
 	const struct bpf_struct_ops *st_ops;
 	const struct btf_member *member;
 	struct bpf_prog *prog = env->prog;
@@ -20093,14 +20094,15 @@ static int check_struct_ops_btf_id(struct bpf_verifier_env *env)
 	}
 
 	btf_id = prog->aux->attach_btf_id;
-	st_ops = bpf_struct_ops_find(btf_id);
-	if (!st_ops) {
+	st_ops_desc = bpf_struct_ops_find(btf_id);
+	if (!st_ops_desc) {
 		verbose(env, "attach_btf_id %u is not a supported struct\n",
 			btf_id);
 		return -ENOTSUPP;
 	}
+	st_ops = st_ops_desc->st_ops;
 
-	t = st_ops->type;
+	t = st_ops_desc->type;
 	member_idx = prog->expected_attach_type;
 	if (member_idx >= btf_type_vlen(t)) {
 		verbose(env, "attach to invalid member idx %u of struct %s\n",
diff --git a/net/bpf/bpf_dummy_struct_ops.c b/net/bpf/bpf_dummy_struct_ops.c
index 5918d1b32e19..ffa224053a6c 100644
--- a/net/bpf/bpf_dummy_struct_ops.c
+++ b/net/bpf/bpf_dummy_struct_ops.c
@@ -17,6 +17,8 @@ struct bpf_dummy_ops_test_args {
 	struct bpf_dummy_ops_state state;
 };
 
+static struct btf *bpf_dummy_ops_btf;
+
 static struct bpf_dummy_ops_test_args *
 dummy_ops_init_args(const union bpf_attr *kattr, unsigned int nr)
 {
@@ -85,9 +87,13 @@ int bpf_struct_ops_test_run(struct bpf_prog *prog, const union bpf_attr *kattr,
 	void *image = NULL;
 	unsigned int op_idx;
 	int prog_ret;
+	u32 type_id;
 	int err;
 
-	if (prog->aux->attach_btf_id != st_ops->type_id)
+	type_id = btf_find_by_name_kind(bpf_dummy_ops_btf,
+					bpf_bpf_dummy_ops.name,
+					BTF_KIND_STRUCT);
+	if (prog->aux->attach_btf_id != type_id)
 		return -EOPNOTSUPP;
 
 	func_proto = prog->aux->attach_func_proto;
@@ -143,6 +149,7 @@ int bpf_struct_ops_test_run(struct bpf_prog *prog, const union bpf_attr *kattr,
 
 static int bpf_dummy_init(struct btf *btf)
 {
+	bpf_dummy_ops_btf = btf;
 	return 0;
 }
 
diff --git a/net/ipv4/bpf_tcp_ca.c b/net/ipv4/bpf_tcp_ca.c
index 39dcccf0f174..3c8b76578a2a 100644
--- a/net/ipv4/bpf_tcp_ca.c
+++ b/net/ipv4/bpf_tcp_ca.c
@@ -20,6 +20,7 @@ static u32 unsupported_ops[] = {
 
 static const struct btf_type *tcp_sock_type;
 static u32 tcp_sock_id, sock_id;
+static const struct btf_type *tcp_congestion_ops_type;
 
 static int bpf_tcp_ca_init(struct btf *btf)
 {
@@ -36,6 +37,11 @@ static int bpf_tcp_ca_init(struct btf *btf)
 	tcp_sock_id = type_id;
 	tcp_sock_type = btf_type_by_id(btf, tcp_sock_id);
 
+	type_id = btf_find_by_name_kind(btf, "tcp_congestion_ops", BTF_KIND_STRUCT);
+	if (type_id < 0)
+		return -EINVAL;
+	tcp_congestion_ops_type = btf_type_by_id(btf, type_id);
+
 	return 0;
 }
 
@@ -149,7 +155,7 @@ static u32 prog_ops_moff(const struct bpf_prog *prog)
 	u32 midx;
 
 	midx = prog->expected_attach_type;
-	t = bpf_tcp_congestion_ops.type;
+	t = tcp_congestion_ops_type;
 	m = &btf_type_member(t)[midx];
 
 	return __btf_member_bit_offset(t, m) / 8;
-- 
2.34.1


