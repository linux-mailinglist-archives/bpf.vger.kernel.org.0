Return-Path: <bpf+bounces-18116-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C011815E04
	for <lists+bpf@lfdr.de>; Sun, 17 Dec 2023 09:12:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51BEC1C21AF4
	for <lists+bpf@lfdr.de>; Sun, 17 Dec 2023 08:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EC7C20E3;
	Sun, 17 Dec 2023 08:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ern22uPA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C061FB4;
	Sun, 17 Dec 2023 08:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-77f8e4702a6so193056985a.1;
        Sun, 17 Dec 2023 00:11:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702800705; x=1703405505; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3BbvIxRBB10Pf51IIxv6h8AefewnxOFNC4H0ueS8VlE=;
        b=ern22uPAp4PUjDrPQfWr+/m1EC5vogoKq5KAth5Q38D8yznWeUDuSBhP9lxJ13WQwe
         8oZwEC5/FG3RYYlhzi5HNjOpXRUMuGGXVvafR3NhubiaGxqvoidEH/hs5mO0sbJjBPc/
         p1BsH2HR5NxXuBcJzGzGH9TEhWTqSk7mKh8x/nI0U+rScq55Ghtma8Ad+hNsQ/unfIL/
         IEYVDFUY5Gl6kh8K9eHlsiyJJvabx8XRFQeTph8s7ccTjbRifDkS452CT5DDmQgNrcgD
         L042qPSisjahMkavzev69uN1sdKvRpQjNZ9eBZx6z7MFE6MY6eqy0kxgvYAp7HQzp2+E
         2Avg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702800705; x=1703405505;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3BbvIxRBB10Pf51IIxv6h8AefewnxOFNC4H0ueS8VlE=;
        b=AGcvJupGROhdmMmgW6Of1LMMrm/fZJh9IdjEWZXaFd+1k18Afw4KyGn1N/Kaxo12B3
         XDfJ8BORjeqWH4W7hfetEJiP6MPnbsgXijxTlv2fdOlTPEvI8lclb42DcCrPuoSPsozP
         JTg7Fg/BNbD3JdKv1sRSYWMxYxoM/y9Xncd9RXfLEKXA3D+4gvavkJKKfdCKDPWEx5AM
         /FeKzbV8pqfMw6/6LnsxalntBjsL3NIFtmmuIpf1ERlpr79M17QAYKdSqPPfnWhQj+js
         hBogr6SCtnX59aUw3u7LEslVIYlWajgnBvz2oLMQHgbhjGpcLdVskAiK7DCxpZ4BPU8Y
         Hgmg==
X-Gm-Message-State: AOJu0YyQcxCho/7G0XE7bKrLShc9YTYv3CYw+++8Pn63O1mwod1TPdFr
	6nwdRcAz3DHEkOeY7vdYjB+dKi9t7N8=
X-Google-Smtp-Source: AGHT+IFhm754wuKtTFAz9h0a4WCA5GfcGog6khi/mQS9bZU+Wgk6leZOxq1KqGxk7H/DnlMpKHBk6g==
X-Received: by 2002:a05:620a:4712:b0:76d:2725:f36f with SMTP id bs18-20020a05620a471200b0076d2725f36fmr19127243qkb.71.1702800705063;
        Sun, 17 Dec 2023 00:11:45 -0800 (PST)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:bb8c:c0f2:4408:50cf])
        by smtp.gmail.com with ESMTPSA id c85-20020a814e58000000b005e303826838sm3399415ywb.56.2023.12.17.00.11.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Dec 2023 00:11:44 -0800 (PST)
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
Subject: [PATCH bpf-next v14 03/14] bpf, net: introduce bpf_struct_ops_desc.
Date: Sun, 17 Dec 2023 00:11:20 -0800
Message-Id: <20231217081132.1025020-4-thinker.li@gmail.com>
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

Move some of members of bpf_struct_ops to bpf_struct_ops_desc.  When we
introduce the new API to register new bpf_struct_ops types from modules,
bpf_struct_ops may destroyed when the module is unloaded.  Moving these
members to bpf_struct_ops_desc make these data available even when the
module is unloaded.

type_id is unavailabe in bpf_struct_ops anymore. Modules should get it from
the btf received by kmod's init function.

Cc: netdev@vger.kernel.org
Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 include/linux/bpf.h            | 13 ++++--
 kernel/bpf/bpf_struct_ops.c    | 80 +++++++++++++++++-----------------
 kernel/bpf/verifier.c          |  8 ++--
 net/bpf/bpf_dummy_struct_ops.c | 11 ++++-
 net/ipv4/bpf_tcp_ca.c          |  8 +++-
 5 files changed, 72 insertions(+), 48 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index c87c608a3689..432f37c979ff 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1683,17 +1683,22 @@ struct bpf_struct_ops {
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
@@ -1736,7 +1741,7 @@ int bpf_struct_ops_test_run(struct bpf_prog *prog, const union bpf_attr *kattr,
 			    union bpf_attr __user *uattr);
 #endif
 #else
-static inline const struct bpf_struct_ops *bpf_struct_ops_find(u32 type_id)
+static inline const struct bpf_struct_ops_desc *bpf_struct_ops_find(u32 type_id)
 {
 	return NULL;
 }
diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index 9f95e9fc00f3..5fbf88e6f4e5 100644
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
@@ -383,11 +384,12 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
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
@@ -400,7 +402,7 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
 	if (*(u32 *)key != 0)
 		return -E2BIG;
 
-	err = check_zero_holes(st_ops->value_type, value);
+	err = check_zero_holes(st_ops_desc->value_type, value);
 	if (err)
 		return err;
 
@@ -493,7 +495,7 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
 		}
 
 		if (prog->type != BPF_PROG_TYPE_STRUCT_OPS ||
-		    prog->aux->attach_btf_id != st_ops->type_id ||
+		    prog->aux->attach_btf_id != st_ops_desc->type_id ||
 		    prog->expected_attach_type != i) {
 			bpf_prog_put(prog);
 			err = -EINVAL;
@@ -588,7 +590,7 @@ static long bpf_struct_ops_map_delete_elem(struct bpf_map *map, void *key)
 			     BPF_STRUCT_OPS_STATE_TOBEFREE);
 	switch (prev_state) {
 	case BPF_STRUCT_OPS_STATE_INUSE:
-		st_map->st_ops->unreg(&st_map->kvalue.data);
+		st_map->st_ops_desc->st_ops->unreg(&st_map->kvalue.data);
 		bpf_map_put(map);
 		return 0;
 	case BPF_STRUCT_OPS_STATE_TOBEFREE:
@@ -669,22 +671,22 @@ static int bpf_struct_ops_map_alloc_check(union bpf_attr *attr)
 
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
@@ -696,7 +698,7 @@ static struct bpf_map *bpf_struct_ops_map_alloc(union bpf_attr *attr)
 	if (!st_map)
 		return ERR_PTR(-ENOMEM);
 
-	st_map->st_ops = st_ops;
+	st_map->st_ops_desc = st_ops_desc;
 	map = &st_map->map;
 
 	ret = bpf_jit_charge_modmem(PAGE_SIZE);
@@ -733,8 +735,8 @@ static struct bpf_map *bpf_struct_ops_map_alloc(union bpf_attr *attr)
 static u64 bpf_struct_ops_map_mem_usage(const struct bpf_map *map)
 {
 	struct bpf_struct_ops_map *st_map = (struct bpf_struct_ops_map *)map;
-	const struct bpf_struct_ops *st_ops = st_map->st_ops;
-	const struct btf_type *vt = st_ops->value_type;
+	const struct bpf_struct_ops_desc *st_ops_desc = st_map->st_ops_desc;
+	const struct btf_type *vt = st_ops_desc->value_type;
 	u64 usage;
 
 	usage = sizeof(*st_map) +
@@ -808,7 +810,7 @@ static void bpf_struct_ops_map_link_dealloc(struct bpf_link *link)
 		/* st_link->map can be NULL if
 		 * bpf_struct_ops_link_create() fails to register.
 		 */
-		st_map->st_ops->unreg(&st_map->kvalue.data);
+		st_map->st_ops_desc->st_ops->unreg(&st_map->kvalue.data);
 		bpf_map_put(&st_map->map);
 	}
 	kfree(st_link);
@@ -855,7 +857,7 @@ static int bpf_struct_ops_map_link_update(struct bpf_link *link, struct bpf_map
 	if (!bpf_struct_ops_valid_to_reg(new_map))
 		return -EINVAL;
 
-	if (!st_map->st_ops->update)
+	if (!st_map->st_ops_desc->st_ops->update)
 		return -EOPNOTSUPP;
 
 	mutex_lock(&update_mutex);
@@ -868,12 +870,12 @@ static int bpf_struct_ops_map_link_update(struct bpf_link *link, struct bpf_map
 
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
 
@@ -924,7 +926,7 @@ int bpf_struct_ops_link_create(union bpf_attr *attr)
 	if (err)
 		goto err_out;
 
-	err = st_map->st_ops->reg(st_map->kvalue.data);
+	err = st_map->st_ops_desc->st_ops->reg(st_map->kvalue.data);
 	if (err) {
 		bpf_link_cleanup(&link_primer);
 		link = NULL;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 1863826a4ac3..bd52d7b318a5 100644
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
index 2748f9d77b18..594a138a9d3e 100644
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
@@ -85,9 +87,15 @@ int bpf_struct_ops_test_run(struct bpf_prog *prog, const union bpf_attr *kattr,
 	void *image = NULL;
 	unsigned int op_idx;
 	int prog_ret;
+	s32 type_id;
 	int err;
 
-	if (prog->aux->attach_btf_id != st_ops->type_id)
+	type_id = btf_find_by_name_kind(bpf_dummy_ops_btf,
+					bpf_bpf_dummy_ops.name,
+					BTF_KIND_STRUCT);
+	if (type_id < 0)
+		return -EINVAL;
+	if (prog->aux->attach_btf_id != type_id)
 		return -EOPNOTSUPP;
 
 	func_proto = prog->aux->attach_func_proto;
@@ -142,6 +150,7 @@ int bpf_struct_ops_test_run(struct bpf_prog *prog, const union bpf_attr *kattr,
 
 static int bpf_dummy_init(struct btf *btf)
 {
+	bpf_dummy_ops_btf = btf;
 	return 0;
 }
 
diff --git a/net/ipv4/bpf_tcp_ca.c b/net/ipv4/bpf_tcp_ca.c
index c7bbd8f3c708..5bb56c9ad4e5 100644
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


