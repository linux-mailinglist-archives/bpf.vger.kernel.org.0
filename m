Return-Path: <bpf+bounces-12927-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1FD27D2110
	for <lists+bpf@lfdr.de>; Sun, 22 Oct 2023 07:04:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4EB11C20A65
	for <lists+bpf@lfdr.de>; Sun, 22 Oct 2023 05:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F4D915CF;
	Sun, 22 Oct 2023 05:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EIb8MQfG"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3BA11109
	for <bpf@vger.kernel.org>; Sun, 22 Oct 2023 05:03:53 +0000 (UTC)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC7A5E7
	for <bpf@vger.kernel.org>; Sat, 21 Oct 2023 22:03:51 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-5a7ad24b3aaso23427057b3.2
        for <bpf@vger.kernel.org>; Sat, 21 Oct 2023 22:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697951030; x=1698555830; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=alXqnz2QDXix9D3xrXQ2TFuZ278dcQhqoOd2sCMr0oA=;
        b=EIb8MQfG4RbTTC3w67b31I4DxdKVuDvlU2yo53+k/4JjIvGvHtK3TvnWwAzsJPMa+v
         48zUOxQAhH5ezxULwm45Yq4Hd9siVJ6nXwyIEqs1/YRDvcedRRrkGgpYO3rhS6xukJ7F
         b1UhcjeNxlf7Vtg3fBWmk/CQHaK8bVzQlanSAkUp2kP12TYvcHR31BQP3FWg3gNdNefg
         8dEJZIuN48VaVMM6iwPQWZRakwRBHrQvomy3898dqaHVCnzA9wkyIz3dWd4TACJqUuK1
         FAGLaJGnLf8SvItZ6Vm5CiKC8BFLNtuGpna80Ur5YpRIqpY7xz9J6rvnwEryODmoN4dN
         H71Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697951030; x=1698555830;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=alXqnz2QDXix9D3xrXQ2TFuZ278dcQhqoOd2sCMr0oA=;
        b=GrFuP0Ce3zEGz9viajpdNuCidZ52c7/Y7zSbanGrt1J6M6oXay9xwfGiPqIQ/vkstL
         MS1ui1StXBh1GDYBHMV+X3ojHXKIcNzzvyDNZ2r3uo6acGrhv6EeKMWb4iG4kRJl6kk/
         1MdEiIuKm7OUAqnbudFvHFBo5qKSlSkpI7/dyfvpfyn8K5ndRZv9N38I5k1SIgfvAhAs
         ZqzS+fVRJoJ/u93y7LAR2SbMlk/LeM5AN49V0IDygysG/7R0jyFXtEIFNhq8VNl+3Jvj
         M7T/duQr9APO+kYH36sStUDNfUC7AV1EZ7MEVK80eqdqbHJn8f9ducL6ddS524J/vTcF
         6QDQ==
X-Gm-Message-State: AOJu0YzOjDacpR7TZIqdVCpkq2/sz2G+9aDu0ImBTz7XqrUitbfN/AOX
	XBZn/mdkwJsPbssdmZTwP2KKqdHRZz8=
X-Google-Smtp-Source: AGHT+IEKPIQpDNnbqL/3N1calGErdnhLdag6ToDQ1ZpIy/NRo3iCe55ymr4a4/sRJUQIdUTjRIaNIQ==
X-Received: by 2002:a0d:ca58:0:b0:5a8:6286:bee with SMTP id m85-20020a0dca58000000b005a862860beemr6369442ywd.4.1697951030524;
        Sat, 21 Oct 2023 22:03:50 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:9904:3214:88c1:e733])
        by smtp.gmail.com with ESMTPSA id j1-20020a0de001000000b005a8c392f498sm2035169ywe.82.2023.10.21.22.03.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Oct 2023 22:03:50 -0700 (PDT)
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
Subject: [PATCH bpf-next v6 03/10] bpf: add struct_ops_tab to btf.
Date: Sat, 21 Oct 2023 22:03:28 -0700
Message-Id: <20231022050335.2579051-4-thinker.li@gmail.com>
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

Maintain a registry of registered struct_ops types in the per-btf (module)
struct_ops_tab. This registry allows for easy lookup of struct_ops types
that are registered by a specific module.

Every struct_ops type should have an associated module BTF to provide type
information since we are going to allow modules to define and register new
struct_ops types. Once this change is made, the bpf_struct_ops subsystem
knows where to look up type info with just a bpf_struct_ops.

The subsystem looks up struct_ops types from a given module BTF although it
is always btf_vmlinux now. Once start using struct_ops_tab, btfs other than
btf_vmlinux can be used as well.

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 include/linux/bpf.h         |  5 +--
 include/linux/btf.h         |  8 +++++
 kernel/bpf/bpf_struct_ops.c | 28 ++++++++-------
 kernel/bpf/btf.c            | 71 +++++++++++++++++++++++++++++++++++++
 kernel/bpf/verifier.c       |  2 +-
 5 files changed, 99 insertions(+), 15 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 705e1accfb98..4f3b67932ded 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1633,6 +1633,7 @@ struct bpf_struct_ops {
 struct bpf_struct_ops_desc {
 	struct bpf_struct_ops *st_ops;
 
+	struct btf *btf;
 	const struct btf_type *type;
 	const struct btf_type *value_type;
 	u32 type_id;
@@ -1641,7 +1642,7 @@ struct bpf_struct_ops_desc {
 
 #if defined(CONFIG_BPF_JIT) && defined(CONFIG_BPF_SYSCALL)
 #define BPF_MODULE_OWNER ((void *)((0xeB9FUL << 2) + POISON_POINTER_DELTA))
-const struct bpf_struct_ops_desc *bpf_struct_ops_find(u32 type_id);
+const struct bpf_struct_ops_desc *bpf_struct_ops_find(struct btf *btf, u32 type_id);
 void bpf_struct_ops_init(struct btf *btf, struct bpf_verifier_log *log);
 bool bpf_struct_ops_get(const void *kdata);
 void bpf_struct_ops_put(const void *kdata);
@@ -1684,7 +1685,7 @@ int bpf_struct_ops_test_run(struct bpf_prog *prog, const union bpf_attr *kattr,
 			    union bpf_attr __user *uattr);
 #endif
 #else
-static inline const struct bpf_struct_ops_desc *bpf_struct_ops_find(u32 type_id)
+static inline const struct bpf_struct_ops_desc *bpf_struct_ops_find(struct btf *btf, u32 type_id)
 {
 	return NULL;
 }
diff --git a/include/linux/btf.h b/include/linux/btf.h
index 928113a80a95..8e37f7eb02c7 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -571,4 +571,12 @@ static inline bool btf_type_is_struct_ptr(struct btf *btf, const struct btf_type
 	return btf_type_is_struct(t);
 }
 
+struct bpf_struct_ops;
+struct bpf_struct_ops_desc;
+
+struct bpf_struct_ops_desc *
+btf_add_struct_ops(struct bpf_struct_ops *st_ops);
+const struct bpf_struct_ops_desc *
+btf_get_struct_ops(struct btf *btf, u32 *ret_cnt);
+
 #endif
diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index e35d6321a2f8..0bc21a39257d 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -186,6 +186,7 @@ static void bpf_struct_ops_init_one(struct bpf_struct_ops_desc *st_ops_desc,
 			pr_warn("Error in init bpf_struct_ops %s\n",
 				st_ops->name);
 		} else {
+			st_ops_desc->btf = btf;
 			st_ops_desc->type_id = type_id;
 			st_ops_desc->type = t;
 			st_ops_desc->value_id = value_id;
@@ -222,7 +223,7 @@ void bpf_struct_ops_init(struct btf *btf, struct bpf_verifier_log *log)
 extern struct btf *btf_vmlinux;
 
 static const struct bpf_struct_ops_desc *
-bpf_struct_ops_find_value(u32 value_id)
+bpf_struct_ops_find_value(struct btf *btf, u32 value_id)
 {
 	unsigned int i;
 
@@ -237,7 +238,8 @@ bpf_struct_ops_find_value(u32 value_id)
 	return NULL;
 }
 
-const struct bpf_struct_ops_desc *bpf_struct_ops_find(u32 type_id)
+const struct bpf_struct_ops_desc *
+bpf_struct_ops_find(struct btf *btf, u32 type_id)
 {
 	unsigned int i;
 
@@ -317,7 +319,7 @@ static void bpf_struct_ops_map_put_progs(struct bpf_struct_ops_map *st_map)
 	}
 }
 
-static int check_zero_holes(const struct btf_type *t, void *data)
+static int check_zero_holes(const struct btf *btf, const struct btf_type *t, void *data)
 {
 	const struct btf_member *member;
 	u32 i, moff, msize, prev_mend = 0;
@@ -329,8 +331,8 @@ static int check_zero_holes(const struct btf_type *t, void *data)
 		    memchr_inv(data + prev_mend, 0, moff - prev_mend))
 			return -EINVAL;
 
-		mtype = btf_type_by_id(btf_vmlinux, member->type);
-		mtype = btf_resolve_size(btf_vmlinux, mtype, &msize);
+		mtype = btf_type_by_id(btf, member->type);
+		mtype = btf_resolve_size(btf, mtype, &msize);
 		if (IS_ERR(mtype))
 			return PTR_ERR(mtype);
 		prev_mend = moff + msize;
@@ -397,12 +399,12 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
 	if (*(u32 *)key != 0)
 		return -E2BIG;
 
-	err = check_zero_holes(st_ops_desc->value_type, value);
+	err = check_zero_holes(st_ops_desc->btf, st_ops_desc->value_type, value);
 	if (err)
 		return err;
 
 	uvalue = value;
-	err = check_zero_holes(t, uvalue->data);
+	err = check_zero_holes(st_ops_desc->btf, t, uvalue->data);
 	if (err)
 		return err;
 
@@ -437,7 +439,7 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
 		u32 moff;
 
 		moff = __btf_member_bit_offset(t, member) / 8;
-		ptype = btf_type_resolve_ptr(btf_vmlinux, member->type, NULL);
+		ptype = btf_type_resolve_ptr(st_ops_desc->btf, member->type, NULL);
 		if (ptype == module_type) {
 			if (*(void **)(udata + moff))
 				goto reset_unlock;
@@ -462,8 +464,8 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
 		if (!ptype || !btf_type_is_func_proto(ptype)) {
 			u32 msize;
 
-			mtype = btf_type_by_id(btf_vmlinux, member->type);
-			mtype = btf_resolve_size(btf_vmlinux, mtype, &msize);
+			mtype = btf_type_by_id(st_ops_desc->btf, member->type);
+			mtype = btf_resolve_size(st_ops_desc->btf, mtype, &msize);
 			if (IS_ERR(mtype)) {
 				err = PTR_ERR(mtype);
 				goto reset_unlock;
@@ -602,6 +604,7 @@ static long bpf_struct_ops_map_delete_elem(struct bpf_map *map, void *key)
 static void bpf_struct_ops_map_seq_show_elem(struct bpf_map *map, void *key,
 					     struct seq_file *m)
 {
+	struct bpf_struct_ops_map *st_map = (struct bpf_struct_ops_map *)map;
 	void *value;
 	int err;
 
@@ -611,7 +614,8 @@ static void bpf_struct_ops_map_seq_show_elem(struct bpf_map *map, void *key,
 
 	err = bpf_struct_ops_map_sys_lookup_elem(map, key, value);
 	if (!err) {
-		btf_type_seq_show(btf_vmlinux, map->btf_vmlinux_value_type_id,
+		btf_type_seq_show(st_map->st_ops_desc->btf,
+				  map->btf_vmlinux_value_type_id,
 				  value, m);
 		seq_puts(m, "\n");
 	}
@@ -673,7 +677,7 @@ static struct bpf_map *bpf_struct_ops_map_alloc(union bpf_attr *attr)
 	struct bpf_map *map;
 	int ret;
 
-	st_ops_desc = bpf_struct_ops_find_value(attr->btf_vmlinux_value_type_id);
+	st_ops_desc = bpf_struct_ops_find_value(btf_vmlinux, attr->btf_vmlinux_value_type_id);
 	if (!st_ops_desc)
 		return ERR_PTR(-ENOTSUPP);
 
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index f93e835d90af..c1e2ed6c972e 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -241,6 +241,12 @@ struct btf_id_dtor_kfunc_tab {
 	struct btf_id_dtor_kfunc dtors[];
 };
 
+struct btf_struct_ops_tab {
+	u32 cnt;
+	u32 capacity;
+	struct bpf_struct_ops_desc ops[];
+};
+
 struct btf {
 	void *data;
 	struct btf_type **types;
@@ -258,6 +264,7 @@ struct btf {
 	struct btf_kfunc_set_tab *kfunc_set_tab;
 	struct btf_id_dtor_kfunc_tab *dtor_kfunc_tab;
 	struct btf_struct_metas *struct_meta_tab;
+	struct btf_struct_ops_tab *struct_ops_tab;
 
 	/* split BTF support */
 	struct btf *base_btf;
@@ -1688,11 +1695,20 @@ static void btf_free_struct_meta_tab(struct btf *btf)
 	btf->struct_meta_tab = NULL;
 }
 
+static void btf_free_struct_ops_tab(struct btf *btf)
+{
+	struct btf_struct_ops_tab *tab = btf->struct_ops_tab;
+
+	kfree(tab);
+	btf->struct_ops_tab = NULL;
+}
+
 static void btf_free(struct btf *btf)
 {
 	btf_free_struct_meta_tab(btf);
 	btf_free_dtor_kfunc_tab(btf);
 	btf_free_kfunc_set_tab(btf);
+	btf_free_struct_ops_tab(btf);
 	kvfree(btf->types);
 	kvfree(btf->resolved_sizes);
 	kvfree(btf->resolved_ids);
@@ -8601,3 +8617,58 @@ bool btf_type_ids_nocast_alias(struct bpf_verifier_log *log,
 
 	return !strncmp(reg_name, arg_name, cmp_len);
 }
+
+static struct bpf_struct_ops_desc *
+btf_add_struct_ops(struct btf *btf, struct bpf_struct_ops *st_ops)
+{
+	struct btf_struct_ops_tab *tab, *new_tab;
+	int i;
+
+	if (!btf)
+		return ERR_PTR(-ENOENT);
+
+	/* Assume this function is called for a module when the module is
+	 * loading.
+	 */
+
+	tab = btf->struct_ops_tab;
+	if (!tab) {
+		tab = kzalloc(offsetof(struct btf_struct_ops_tab, ops[4]),
+			      GFP_KERNEL);
+		if (!tab)
+			return ERR_PTR(-ENOMEM);
+		tab->capacity = 4;
+		btf->struct_ops_tab = tab;
+	}
+
+	for (i = 0; i < tab->cnt; i++)
+		if (tab->ops[i].st_ops == st_ops)
+			return ERR_PTR(-EEXIST);
+
+	if (tab->cnt == tab->capacity) {
+		new_tab = krealloc(tab, sizeof(*tab) +
+				   sizeof(struct bpf_struct_ops *) *
+				   tab->capacity * 2, GFP_KERNEL);
+		if (!new_tab)
+			return ERR_PTR(-ENOMEM);
+		tab = new_tab;
+		tab->capacity *= 2;
+		btf->struct_ops_tab = tab;
+	}
+
+	btf->struct_ops_tab->ops[btf->struct_ops_tab->cnt].st_ops = st_ops;
+
+	return &btf->struct_ops_tab->ops[btf->struct_ops_tab->cnt++];
+}
+
+const struct bpf_struct_ops_desc *btf_get_struct_ops(struct btf *btf, u32 *ret_cnt)
+{
+	if (!btf)
+		return NULL;
+	if (!btf->struct_ops_tab)
+		return NULL;
+
+	*ret_cnt = btf->struct_ops_tab->cnt;
+	return (const struct bpf_struct_ops_desc *)btf->struct_ops_tab->ops;
+}
+
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 5c8029606dcc..7d0cf7289092 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -19632,7 +19632,7 @@ static int check_struct_ops_btf_id(struct bpf_verifier_env *env)
 	}
 
 	btf_id = prog->aux->attach_btf_id;
-	st_ops_desc = bpf_struct_ops_find(btf_id);
+	st_ops_desc = bpf_struct_ops_find(btf_vmlinux, btf_id);
 	if (!st_ops_desc) {
 		verbose(env, "attach_btf_id %u is not a supported struct\n",
 			btf_id);
-- 
2.34.1


