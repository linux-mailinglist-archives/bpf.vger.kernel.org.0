Return-Path: <bpf+bounces-9864-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E26A579DFCD
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 08:15:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B118281A59
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 06:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D25F516430;
	Wed, 13 Sep 2023 06:15:11 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97584A45
	for <bpf@vger.kernel.org>; Wed, 13 Sep 2023 06:15:11 +0000 (UTC)
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22F66172E
	for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 23:15:11 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-59bd2e19c95so1353177b3.0
        for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 23:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694585710; x=1695190510; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k0OmmzGx+KPfSVJZlMueUszoNAtvPfV8AFPSrOZZW7Q=;
        b=DHxaGd9QMtlnL9uZdeIdDOJsPi/k7XCnNOXll19itAaSRJi0U3eSDY8cUU33BrhSxJ
         9+MKH4ievFlP9v2fWkADj5N6/m9TVzYcA/NKDrjtxnaMkEpkV4Fnwo83pEcpNl5BxVvr
         R9PFo7E9Y7+QI2HPrgHzAnrQEc9nYO1iGsSFpcwuJocKzVoOtjCjxGn2oIaGu45LLmqD
         Hg2deS4odd/Oxdq6uYnVDBNeVw4hNxcUnoeye0j5p7zGas67rHmqEDcjwYkxvBY3Tqmc
         0yuzSMN87LQhzdb+mpl9yF1GsAbEI7smknfA48KpEFDp2xygBzb+Trvn3E8t9dfPs/W/
         WWgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694585710; x=1695190510;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k0OmmzGx+KPfSVJZlMueUszoNAtvPfV8AFPSrOZZW7Q=;
        b=IPclU2/YaePZkTvVjMK8fF8Hg466cqywCSsoIZMkI69R3WxWqGfXHTmIS9noiL9dyp
         TcIJdMsij8u8rdrxJk3yIED+EZM+FHq/rieVSj0gEsDsfkAU1vrX7fcYe/odEPufqIui
         rC2x2cPXvmYkvjyl3B9hHGWbQE70e0fx6lcEJx8sYAUgbtZHVQuaNwFJMgp1aWQgwAq/
         H9S/isvOObh+re9sRgDEE00wqZEsv1+XNhjooFTHAM7KlUe8MHVYcClCivMwjiAs5AI4
         N7Pri9+cdV/pcubdidoYkK/oiNFo12C/HbFYIDcre3xBEFYuGTkGUkPr2paUlK5k78qi
         fElA==
X-Gm-Message-State: AOJu0Yzz7Qxl7HBUCCBKvtNQwLLiMli7YZ1C5016f2ZYyelllK13kzWU
	yZABDqMrqhhWl5xuNHcXZz90U1abF4k=
X-Google-Smtp-Source: AGHT+IELvHEoEqJUMW5yHYoBqiJJEEsDa6Y3gnZc8HKvyDWDu86of2a+BEWTsiguhqGVV7dMaqDXLw==
X-Received: by 2002:a0d:d651:0:b0:592:2a17:9d64 with SMTP id y78-20020a0dd651000000b005922a179d64mr1468066ywd.20.1694585709977;
        Tue, 12 Sep 2023 23:15:09 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:34c0:240e:9597:d8ed])
        by smtp.gmail.com with ESMTPSA id b132-20020a0dd98a000000b0057a5302e2fesm2961454ywe.5.2023.09.12.23.15.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 23:15:09 -0700 (PDT)
From: thinker.li@gmail.com
To: bpf@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	kernel-team@meta.com,
	andrii@kernel.org
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: [RFC bpf-next v2 3/9] bpf: attach a module BTF to a bpf_struct_ops
Date: Tue, 12 Sep 2023 23:14:43 -0700
Message-Id: <20230913061449.1918219-4-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230913061449.1918219-1-thinker.li@gmail.com>
References: <20230913061449.1918219-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kui-Feng Lee <thinker.li@gmail.com>

Every struct_ops type should has an associated module BTF to provide type
information since we are going to allow modules to define and register new
struct_ops types. New types may exist only in module itself, and the kernel
BTF (vmlinux) doesn't know it at all. The attached module BTF here will be
used to resolve type IDs of a struct_ops map.
---
 include/linux/bpf.h         |  5 +++--
 kernel/bpf/bpf_struct_ops.c | 34 +++++++++++++++++++++++-----------
 kernel/bpf/verifier.c       |  2 +-
 3 files changed, 27 insertions(+), 14 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 10f98f0ddc77..a9369f982cd5 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1614,6 +1614,7 @@ struct bpf_struct_ops {
 	void (*unreg)(void *kdata);
 	int (*update)(void *kdata, void *old_kdata);
 	int (*validate)(void *kdata);
+	const struct btf *btf;
 	const struct btf_type *type;
 	const struct btf_type *value_type;
 	const char *name;
@@ -1629,7 +1630,7 @@ struct bpf_struct_ops_mod {
 
 #if defined(CONFIG_BPF_JIT) && defined(CONFIG_BPF_SYSCALL)
 #define BPF_MODULE_OWNER ((void *)((0xeB9FUL << 2) + POISON_POINTER_DELTA))
-const struct bpf_struct_ops *bpf_struct_ops_find(u32 type_id);
+const struct bpf_struct_ops *bpf_struct_ops_find(u32 type_id, struct btf *btf);
 void bpf_struct_ops_init(struct btf *btf, struct bpf_verifier_log *log);
 bool bpf_struct_ops_get(const void *kdata);
 void bpf_struct_ops_put(const void *kdata);
@@ -1672,7 +1673,7 @@ int bpf_struct_ops_test_run(struct bpf_prog *prog, const union bpf_attr *kattr,
 			    union bpf_attr __user *uattr);
 #endif
 #else
-static inline const struct bpf_struct_ops *bpf_struct_ops_find(u32 type_id)
+static inline const struct bpf_struct_ops *bpf_struct_ops_find(u32 type_id, struct btf *btf)
 {
 	return NULL;
 }
diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index 9be6e07ccba5..82cc3f0638fa 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -188,6 +188,10 @@ static void bpf_struct_ops_init_one(struct bpf_struct_ops *st_ops,
 			pr_warn("Error in init bpf_struct_ops %s\n",
 				st_ops->name);
 		} else {
+			/* XXX: We need a owner (module) here to company
+			 * with type_id and value_id.
+			 */
+			st_ops->btf = btf;
 			st_ops->type_id = type_id;
 			st_ops->type = t;
 			st_ops->value_id = value_id;
@@ -328,7 +332,7 @@ EXPORT_SYMBOL(unregister_bpf_struct_ops);
 extern struct btf *btf_vmlinux;
 
 static const struct bpf_struct_ops *
-bpf_struct_ops_find_value(u32 value_id)
+bpf_struct_ops_find_value(u32 value_id, struct btf *btf)
 {
 	unsigned int i;
 
@@ -336,14 +340,15 @@ bpf_struct_ops_find_value(u32 value_id)
 		return NULL;
 
 	for (i = 0; i < bpf_struct_ops_num; i++) {
-		if (bpf_struct_ops[i]->value_id == value_id)
+		if (bpf_struct_ops[i]->value_id == value_id &&
+		    bpf_struct_ops[i]->btf == btf)
 			return bpf_struct_ops[i];
 	}
 
 	return NULL;
 }
 
-const struct bpf_struct_ops *bpf_struct_ops_find(u32 type_id)
+const struct bpf_struct_ops *bpf_struct_ops_find(u32 type_id, struct btf *btf)
 {
 	unsigned int i;
 
@@ -351,7 +356,8 @@ const struct bpf_struct_ops *bpf_struct_ops_find(u32 type_id)
 		return NULL;
 
 	for (i = 0; i < bpf_struct_ops_num; i++) {
-		if (bpf_struct_ops[i]->type_id == type_id)
+		if (bpf_struct_ops[i]->type_id == type_id &&
+		    bpf_struct_ops[i]->btf == btf)
 			return bpf_struct_ops[i];
 	}
 
@@ -423,7 +429,7 @@ static void bpf_struct_ops_map_put_progs(struct bpf_struct_ops_map *st_map)
 	}
 }
 
-static int check_zero_holes(const struct btf_type *t, void *data)
+static int check_zero_holes(const struct btf *btf, const struct btf_type *t, void *data)
 {
 	const struct btf_member *member;
 	u32 i, moff, msize, prev_mend = 0;
@@ -435,8 +441,8 @@ static int check_zero_holes(const struct btf_type *t, void *data)
 		    memchr_inv(data + prev_mend, 0, moff - prev_mend))
 			return -EINVAL;
 
-		mtype = btf_type_by_id(btf_vmlinux, member->type);
-		mtype = btf_resolve_size(btf_vmlinux, mtype, &msize);
+		mtype = btf_type_by_id(btf, member->type);
+		mtype = btf_resolve_size(btf, mtype, &msize);
 		if (IS_ERR(mtype))
 			return PTR_ERR(mtype);
 		prev_mend = moff + msize;
@@ -489,7 +495,7 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
 	const struct bpf_struct_ops *st_ops = st_map->st_ops;
 	struct bpf_struct_ops_value *uvalue, *kvalue;
 	const struct btf_member *member;
-	const struct btf_type *t = st_ops->type;
+	const struct btf_type *t;
 	struct bpf_tramp_links *tlinks;
 	void *udata, *kdata;
 	int prog_fd, err;
@@ -499,15 +505,20 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
 	if (flags)
 		return -EINVAL;
 
+	if (!st_ops)
+		return -EINVAL;
+
+	t = st_ops->type;
+
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
 
@@ -773,8 +784,9 @@ static struct bpf_map *bpf_struct_ops_map_alloc(union bpf_attr *attr)
 	struct bpf_struct_ops_map *st_map;
 	const struct btf_type *t, *vt;
 	struct bpf_map *map;
+	struct btf *btf;
 
-	st_ops = bpf_struct_ops_find_value(attr->btf_vmlinux_value_type_id);
+	st_ops = bpf_struct_ops_find_value(attr->btf_vmlinux_value_type_id, btf_vmlinux);
 	if (!st_ops)
 		return ERR_PTR(-ENOTSUPP);
 
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index bb78212fa5b2..c0cab601b2a6 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -19191,7 +19191,7 @@ static int check_struct_ops_btf_id(struct bpf_verifier_env *env)
 	}
 
 	btf_id = prog->aux->attach_btf_id;
-	st_ops = bpf_struct_ops_find(btf_id);
+	st_ops = bpf_struct_ops_find(btf_id, btf_vmlinux);
 	if (!st_ops) {
 		verbose(env, "attach_btf_id %u is not a supported struct\n",
 			btf_id);
-- 
2.34.1


