Return-Path: <bpf+bounces-10463-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A41877A8924
	for <lists+bpf@lfdr.de>; Wed, 20 Sep 2023 18:01:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FFEE2820C1
	for <lists+bpf@lfdr.de>; Wed, 20 Sep 2023 16:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E873C3D38E;
	Wed, 20 Sep 2023 16:00:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DE733C69D
	for <bpf@vger.kernel.org>; Wed, 20 Sep 2023 16:00:23 +0000 (UTC)
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 914EDB9
	for <bpf@vger.kernel.org>; Wed, 20 Sep 2023 09:00:21 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-59c0442a359so61922317b3.0
        for <bpf@vger.kernel.org>; Wed, 20 Sep 2023 09:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695225620; x=1695830420; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L0Dqt01gDTdQ61En/KGkoh7lbqEEEQX9e9do9aONkY4=;
        b=mD9H9kdH5xgGpQHozTSoGIRXZQgnKG2OQXTpV9UDpbhJHvfpNTOsdsApexVo8WYfy9
         YNCFATm2VxqETuMdUuKIqM1zZEyUDvehwqt0rF1LYSqnOfDP3pWv0gBztM4PfW0ir8Ju
         VK2DjpWojy+mmfloJgTeiuR4MN4sNaXZU8Sg5FzhLWmm2HY0puif+vqMOYhoGIbDxjEb
         C6AtPmjXzSXZ0MuT0umg0cOiQKqNKHAdm8TgnQWcI2UvJUAQbMmCarf06mpfedqpY1r8
         JLQphRHjUszVa3jwRjY4zOPyo969nnYBZF/36ATf/S6FrLCDOJLTQYArHia3V70izAHW
         5opQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695225620; x=1695830420;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L0Dqt01gDTdQ61En/KGkoh7lbqEEEQX9e9do9aONkY4=;
        b=T3En05B6Bda8DRwNW73vRYNEvwjvE8wwNRUm7r50bpwI7ttKSlpS17b2HGjwMxRljS
         RVEn01IKdAYULx0wD8v38APvENU7zamQd95EB/umPANjeJTfVS+fz5hWOc0qQSzSY403
         w05xIXft5cUcotXUmai53Lqtx1bMIAHbJVevw8Jy1aAuyNy9YcqjQiNmgnni12iOmgd+
         EKrouOUFElSCiDfVGtcYitV7j13IcG+qanEt2Q4+3TY0H+zNKHuLKgMc2Qxi4+4NnIBX
         eKaZZZTP3KQRsBGMFea7ee5Y6Fg/V00/7AZQYl/UxOIBWjkX774k9qktwEAozkqsX9EA
         l+/g==
X-Gm-Message-State: AOJu0YyFkbSf46p52HTxW2+OmTUUDB/jXAvRTX1uFlYQ4nWYvBjhxcno
	BxGdaThcN/FKwyEAsNR92qaZLhZyjYw=
X-Google-Smtp-Source: AGHT+IFrpHS1IRdfxVoMZnwNJpkiYqCs7bIXu/3P+KMbKiiI+XQTNOlEstDasNNNUn1PmguDY5VXNA==
X-Received: by 2002:a81:92c3:0:b0:589:db22:bfd6 with SMTP id j186-20020a8192c3000000b00589db22bfd6mr2956861ywg.40.1695225619981;
        Wed, 20 Sep 2023 09:00:19 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:dcd2:9730:2c7c:239f])
        by smtp.gmail.com with ESMTPSA id m131-20020a817189000000b00589dbcf16cbsm3860490ywc.35.2023.09.20.09.00.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 09:00:18 -0700 (PDT)
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
Subject: [RFC bpf-next v3 04/11] bpf: attach a module BTF to a bpf_struct_ops
Date: Wed, 20 Sep 2023 08:59:16 -0700
Message-Id: <20230920155923.151136-5-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230920155923.151136-1-thinker.li@gmail.com>
References: <20230920155923.151136-1-thinker.li@gmail.com>
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

Every struct_ops type should has an associated module BTF to provide type
information since we are going to allow modules to define and register new
struct_ops types. New types may exist only in module itself, and the kernel
BTF (vmlinux) doesn't know it at all. The attached module BTF here is going
to be used to get correct btf and resolve type IDs of a struct_ops map.

However, it doesn't use the attached module BTF until we are ready to
switch to registration function in subsequent patches.

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 include/linux/bpf.h         |  5 +++--
 kernel/bpf/bpf_struct_ops.c | 27 ++++++++++++++++++---------
 kernel/bpf/verifier.c       |  2 +-
 3 files changed, 22 insertions(+), 12 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 67554f2f81b7..0776cb584b3f 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1626,6 +1626,7 @@ struct bpf_struct_ops {
 	void (*unreg)(void *kdata);
 	int (*update)(void *kdata, void *old_kdata);
 	int (*validate)(void *kdata);
+	const struct btf *btf;
 	const struct btf_type *type;
 	const struct btf_type *value_type;
 	const char *name;
@@ -1641,7 +1642,7 @@ struct bpf_struct_ops_mod {
 
 #if defined(CONFIG_BPF_JIT) && defined(CONFIG_BPF_SYSCALL)
 #define BPF_MODULE_OWNER ((void *)((0xeB9FUL << 2) + POISON_POINTER_DELTA))
-const struct bpf_struct_ops *bpf_struct_ops_find(u32 type_id);
+const struct bpf_struct_ops *bpf_struct_ops_find(u32 type_id, struct btf *btf);
 void bpf_struct_ops_init(struct btf *btf, struct bpf_verifier_log *log);
 bool bpf_struct_ops_get(const void *kdata);
 void bpf_struct_ops_put(const void *kdata);
@@ -1684,7 +1685,7 @@ int bpf_struct_ops_test_run(struct bpf_prog *prog, const union bpf_attr *kattr,
 			    union bpf_attr __user *uattr);
 #endif
 #else
-static inline const struct bpf_struct_ops *bpf_struct_ops_find(u32 type_id)
+static inline const struct bpf_struct_ops *bpf_struct_ops_find(u32 type_id, struct btf *btf)
 {
 	return NULL;
 }
diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index cd688e9033b5..7c2ef53687ef 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -174,6 +174,10 @@ static void bpf_struct_ops_init_one(struct bpf_struct_ops *st_ops,
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
@@ -210,7 +214,7 @@ void bpf_struct_ops_init(struct btf *btf, struct bpf_verifier_log *log)
 extern struct btf *btf_vmlinux;
 
 static const struct bpf_struct_ops *
-bpf_struct_ops_find_value(u32 value_id)
+bpf_struct_ops_find_value(u32 value_id, struct btf *btf)
 {
 	unsigned int i;
 
@@ -225,7 +229,7 @@ bpf_struct_ops_find_value(u32 value_id)
 	return NULL;
 }
 
-const struct bpf_struct_ops *bpf_struct_ops_find(u32 type_id)
+const struct bpf_struct_ops *bpf_struct_ops_find(u32 type_id, struct btf *btf)
 {
 	unsigned int i;
 
@@ -305,7 +309,7 @@ static void bpf_struct_ops_map_put_progs(struct bpf_struct_ops_map *st_map)
 	}
 }
 
-static int check_zero_holes(const struct btf_type *t, void *data)
+static int check_zero_holes(const struct btf *btf, const struct btf_type *t, void *data)
 {
 	const struct btf_member *member;
 	u32 i, moff, msize, prev_mend = 0;
@@ -317,8 +321,8 @@ static int check_zero_holes(const struct btf_type *t, void *data)
 		    memchr_inv(data + prev_mend, 0, moff - prev_mend))
 			return -EINVAL;
 
-		mtype = btf_type_by_id(btf_vmlinux, member->type);
-		mtype = btf_resolve_size(btf_vmlinux, mtype, &msize);
+		mtype = btf_type_by_id(btf, member->type);
+		mtype = btf_resolve_size(btf, mtype, &msize);
 		if (IS_ERR(mtype))
 			return PTR_ERR(mtype);
 		prev_mend = moff + msize;
@@ -371,7 +375,7 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
 	const struct bpf_struct_ops *st_ops = st_map->st_ops;
 	struct bpf_struct_ops_value *uvalue, *kvalue;
 	const struct btf_member *member;
-	const struct btf_type *t = st_ops->type;
+	const struct btf_type *t;
 	struct bpf_tramp_links *tlinks;
 	void *udata, *kdata;
 	int prog_fd, err;
@@ -381,15 +385,20 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
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
 
@@ -660,7 +669,7 @@ static struct bpf_map *bpf_struct_ops_map_alloc(union bpf_attr *attr)
 	struct bpf_map *map;
 	int ret;
 
-	st_ops = bpf_struct_ops_find_value(attr->btf_vmlinux_value_type_id);
+	st_ops = bpf_struct_ops_find_value(attr->btf_vmlinux_value_type_id, btf_vmlinux);
 	if (!st_ops)
 		return ERR_PTR(-ENOTSUPP);
 
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index a7178ecf676d..99b45501951c 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -19631,7 +19631,7 @@ static int check_struct_ops_btf_id(struct bpf_verifier_env *env)
 	}
 
 	btf_id = prog->aux->attach_btf_id;
-	st_ops = bpf_struct_ops_find(btf_id);
+	st_ops = bpf_struct_ops_find(btf_id, btf_vmlinux);
 	if (!st_ops) {
 		verbose(env, "attach_btf_id %u is not a supported struct\n",
 			btf_id);
-- 
2.34.1


