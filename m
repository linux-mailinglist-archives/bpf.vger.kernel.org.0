Return-Path: <bpf+bounces-12198-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A45067C905F
	for <lists+bpf@lfdr.de>; Sat, 14 Oct 2023 00:43:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19907B20BCF
	for <lists+bpf@lfdr.de>; Fri, 13 Oct 2023 22:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E1682C848;
	Fri, 13 Oct 2023 22:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FuetVUV5"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D438C24207
	for <bpf@vger.kernel.org>; Fri, 13 Oct 2023 22:43:13 +0000 (UTC)
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 434A8C0
	for <bpf@vger.kernel.org>; Fri, 13 Oct 2023 15:43:12 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-5a7ac4c3666so31679107b3.3
        for <bpf@vger.kernel.org>; Fri, 13 Oct 2023 15:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697236991; x=1697841791; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2IFN/2HC9JygClV/G6CWtisNQ7HtXVVuY/UWh7b7UCo=;
        b=FuetVUV5bLoczL2oxCJI2BgfMRNwLMmNJiTCC/2S9BMdH/AHNTvbDh1KY3puJQZw/z
         D3lf9VAx+E7o78jvsiZcJDG2D9LvSt1RwqugdilI+4I5FOMmsNkLLiyJXAv4vETnSIMO
         5eCtCv2F1Gr355IUMnKlIULRJCLWoKy8FE47nqpNhSv57v0KD9XAhyURTU3Pi35SVDlm
         ePVilkFok/cvi4/o+vRz71IWEsp5Daoe76WjepLW6jGlJ4gIqQXTxCs+I2kjI5ixuk/g
         Ex7SqMvMbFNLEUBIPPZuymrbd5Be6aoXq3PxiE/9vn3s/kBoq31rFRgn75+hKbANwBQU
         zGog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697236991; x=1697841791;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2IFN/2HC9JygClV/G6CWtisNQ7HtXVVuY/UWh7b7UCo=;
        b=uhJ7K3cOqod9SQBd8bXnlUxal1fKBoZIY7k01PcEfYKaI/aKjUgQK2r5dvNIjtskeC
         aVx7w1buwNU7GwcbccfW2IwQM55pCA6TDGl7dyJIzMQwmSOZWP8ENV2eHP1Btue1QPwm
         ll8N9aK7IsazWfqsyxN88/MNdHlJ1BgpxQZ0lCcz28wv5d15nOWNCMwbsD9YBcX0w26X
         XGVgIpaaNzLAe9asiR0AP4PScn+pYk0Ohik3+ca2pd2rhX+2pTvan2P5fRWtFTtpUMhj
         RolxusNMxBV5pLdNJg1JAL74E/OEfNWRIIGEx1UoqO1C7hITUaJsTH8nJp0+osgqlwdr
         1YPg==
X-Gm-Message-State: AOJu0YxuOh7Hxd7JSJmHZPcPLNirBdC3aY/Y3dbuqZdoGgjJFjTUjqYh
	Y41b66n5MzrDsdjR0sYlM4UvfUNv8L0=
X-Google-Smtp-Source: AGHT+IHcT2w/C6JfH05o0r3SYkq2oMBVMPrSG2S4yLfuM6sMANuQjLFYAJAjedwRFfEAz/DRCsD9cQ==
X-Received: by 2002:a0d:ce02:0:b0:59b:ec11:7734 with SMTP id q2-20020a0dce02000000b0059bec117734mr30236464ywd.39.1697236990866;
        Fri, 13 Oct 2023 15:43:10 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:df89:3514:fdf4:ee2])
        by smtp.gmail.com with ESMTPSA id g141-20020a0ddd93000000b00592548b2c47sm101989ywe.80.2023.10.13.15.43.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 15:43:10 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 2/9] bpf: add struct_ops_tab to btf.
Date: Fri, 13 Oct 2023 15:42:57 -0700
Message-Id: <20231013224304.187218-3-thinker.li@gmail.com>
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
 include/linux/btf.h         |  6 ++++
 kernel/bpf/bpf_struct_ops.c | 17 ++++-----
 kernel/bpf/btf.c            | 70 +++++++++++++++++++++++++++++++++++++
 kernel/bpf/verifier.c       |  2 +-
 5 files changed, 89 insertions(+), 11 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 30063a760b5a..e6a648af2daa 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1626,6 +1626,7 @@ struct bpf_struct_ops {
 	void (*unreg)(void *kdata);
 	int (*update)(void *kdata, void *old_kdata);
 	int (*validate)(void *kdata);
+	struct btf *btf;
 	const struct btf_type *type;
 	const struct btf_type *value_type;
 	const char *name;
@@ -1636,7 +1637,7 @@ struct bpf_struct_ops {
 
 #if defined(CONFIG_BPF_JIT) && defined(CONFIG_BPF_SYSCALL)
 #define BPF_MODULE_OWNER ((void *)((0xeB9FUL << 2) + POISON_POINTER_DELTA))
-const struct bpf_struct_ops *bpf_struct_ops_find(u32 type_id);
+const struct bpf_struct_ops *bpf_struct_ops_find(struct btf *btf, u32 type_id);
 void bpf_struct_ops_init(struct btf *btf, struct bpf_verifier_log *log);
 bool bpf_struct_ops_get(const void *kdata);
 void bpf_struct_ops_put(const void *kdata);
@@ -1679,7 +1680,7 @@ int bpf_struct_ops_test_run(struct bpf_prog *prog, const union bpf_attr *kattr,
 			    union bpf_attr __user *uattr);
 #endif
 #else
-static inline const struct bpf_struct_ops *bpf_struct_ops_find(u32 type_id)
+static inline const struct bpf_struct_ops *bpf_struct_ops_find(struct btf *btf, u32 type_id)
 {
 	return NULL;
 }
diff --git a/include/linux/btf.h b/include/linux/btf.h
index 928113a80a95..aa2ba77648be 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -571,4 +571,10 @@ static inline bool btf_type_is_struct_ptr(struct btf *btf, const struct btf_type
 	return btf_type_is_struct(t);
 }
 
+struct bpf_struct_ops;
+
+int btf_add_struct_ops(struct bpf_struct_ops *st_ops);
+const struct bpf_struct_ops **
+btf_get_struct_ops(struct btf *btf, u32 *ret_cnt);
+
 #endif
diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index 627cf1ea840a..7758f66ad734 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -185,6 +185,7 @@ static void bpf_struct_ops_init_one(struct bpf_struct_ops *st_ops,
 			pr_warn("Error in init bpf_struct_ops %s\n",
 				st_ops->name);
 		} else {
+			st_ops->btf = btf;
 			st_ops->type_id = type_id;
 			st_ops->type = t;
 			st_ops->value_id = value_id;
@@ -221,7 +222,7 @@ void bpf_struct_ops_init(struct btf *btf, struct bpf_verifier_log *log)
 extern struct btf *btf_vmlinux;
 
 static const struct bpf_struct_ops *
-bpf_struct_ops_find_value(u32 value_id)
+bpf_struct_ops_find_value(struct btf *btf, u32 value_id)
 {
 	unsigned int i;
 
@@ -236,7 +237,7 @@ bpf_struct_ops_find_value(u32 value_id)
 	return NULL;
 }
 
-const struct bpf_struct_ops *bpf_struct_ops_find(u32 type_id)
+const struct bpf_struct_ops *bpf_struct_ops_find(struct btf *btf, u32 type_id)
 {
 	unsigned int i;
 
@@ -316,7 +317,7 @@ static void bpf_struct_ops_map_put_progs(struct bpf_struct_ops_map *st_map)
 	}
 }
 
-static int check_zero_holes(const struct btf_type *t, void *data)
+static int check_zero_holes(const struct btf *btf, const struct btf_type *t, void *data)
 {
 	const struct btf_member *member;
 	u32 i, moff, msize, prev_mend = 0;
@@ -328,8 +329,8 @@ static int check_zero_holes(const struct btf_type *t, void *data)
 		    memchr_inv(data + prev_mend, 0, moff - prev_mend))
 			return -EINVAL;
 
-		mtype = btf_type_by_id(btf_vmlinux, member->type);
-		mtype = btf_resolve_size(btf_vmlinux, mtype, &msize);
+		mtype = btf_type_by_id(btf, member->type);
+		mtype = btf_resolve_size(btf, mtype, &msize);
 		if (IS_ERR(mtype))
 			return PTR_ERR(mtype);
 		prev_mend = moff + msize;
@@ -395,12 +396,12 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
 	if (*(u32 *)key != 0)
 		return -E2BIG;
 
-	err = check_zero_holes(st_ops->value_type, value);
+	err = check_zero_holes(st_ops->btf, st_ops->value_type, value);
 	if (err)
 		return err;
 
 	uvalue = value;
-	err = check_zero_holes(t, uvalue->data);
+	err = check_zero_holes(st_ops->btf, t, uvalue->data);
 	if (err)
 		return err;
 
@@ -671,7 +672,7 @@ static struct bpf_map *bpf_struct_ops_map_alloc(union bpf_attr *attr)
 	struct bpf_map *map;
 	int ret;
 
-	st_ops = bpf_struct_ops_find_value(attr->btf_vmlinux_value_type_id);
+	st_ops = bpf_struct_ops_find_value(attr->btf_vmlinux_value_type_id, btf_vmlinux);
 	if (!st_ops)
 		return ERR_PTR(-ENOTSUPP);
 
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index f93e835d90af..be5144dbb53d 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -241,6 +241,12 @@ struct btf_id_dtor_kfunc_tab {
 	struct btf_id_dtor_kfunc dtors[];
 };
 
+struct btf_struct_ops_tab {
+	u32 cnt;
+	u32 capacity;
+	struct bpf_struct_ops *ops[];
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
@@ -8601,3 +8617,57 @@ bool btf_type_ids_nocast_alias(struct bpf_verifier_log *log,
 
 	return !strncmp(reg_name, arg_name, cmp_len);
 }
+
+int btf_add_struct_ops(struct bpf_struct_ops *st_ops)
+{
+	struct btf_struct_ops_tab *tab, *new_tab;
+	struct btf *btf = st_ops->btf;
+	int i;
+
+	if (!btf)
+		return -ENOENT;
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
+			return -ENOMEM;
+		tab->capacity = 4;
+		btf->struct_ops_tab = tab;
+	}
+
+	for (i = 0; i < tab->cnt; i++)
+		if (tab->ops[i] == st_ops)
+			return -EEXIST;
+
+	if (tab->cnt == tab->capacity) {
+		new_tab = krealloc(tab, sizeof(*tab) +
+				   sizeof(struct bpf_struct_ops *) *
+				   tab->capacity * 2, GFP_KERNEL);
+		if (!new_tab)
+			return -ENOMEM;
+		tab = new_tab;
+		tab->capacity *= 2;
+		btf->struct_ops_tab = tab;
+	}
+
+	btf->struct_ops_tab->ops[btf->struct_ops_tab->cnt++] = st_ops;
+
+	return 0;
+}
+
+const struct bpf_struct_ops **btf_get_struct_ops(struct btf *btf, u32 *ret_cnt)
+{
+	if (!btf)
+		return NULL;
+	if (!btf->struct_ops_tab)
+		return NULL;
+
+	*ret_cnt = btf->struct_ops_tab->cnt;
+	return (const struct bpf_struct_ops **)btf->struct_ops_tab->ops;
+}
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index a7178ecf676d..6564a03c425d 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -19631,7 +19631,7 @@ static int check_struct_ops_btf_id(struct bpf_verifier_env *env)
 	}
 
 	btf_id = prog->aux->attach_btf_id;
-	st_ops = bpf_struct_ops_find(btf_id);
+	st_ops = bpf_struct_ops_find(btf_vmlinux, btf_id);
 	if (!st_ops) {
 		verbose(env, "attach_btf_id %u is not a supported struct\n",
 			btf_id);
-- 
2.34.1


