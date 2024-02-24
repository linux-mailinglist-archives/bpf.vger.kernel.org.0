Return-Path: <bpf+bounces-22644-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C48A8627F7
	for <lists+bpf@lfdr.de>; Sat, 24 Feb 2024 23:34:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D136D282307
	for <lists+bpf@lfdr.de>; Sat, 24 Feb 2024 22:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 472DA4E1CF;
	Sat, 24 Feb 2024 22:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IeA36LX4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E753F9E0
	for <bpf@vger.kernel.org>; Sat, 24 Feb 2024 22:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708814066; cv=none; b=aTHoekZr/mUJXBwCJx5TWcW8WIMzCniQuXFUt8U0A0Lyl7NuJEG1ANpm3MWxwr5nJFmmW9Mp3EPNVTHlpxm5gxlVzA6LkLV+a3927ts9pipBqzpiKcpwstK2bpWFBE01pTE2xeljoCNcfqHjgnkKiPfyE1unaOL4rb+D3kOfxW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708814066; c=relaxed/simple;
	bh=AFRoZuklD1IGWxi+1A5pG/I+X2I1Aix6766QMVtZwMk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=f1y/xCO5aIJf/dKxHEi0fSGAtgCVVPUTBRq5YeV/VxETZLhQ+DYPeUinCKHBjrBtGs7I/AVs0CSl9esZUsovO4HH+O2upeag08WuSlmU1C70KixobE7UiR4RimLVGh2NzQFHPeNL/PXRWsZE27lC9CpPi4X25X1Sg8HT33FWdLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IeA36LX4; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-dcd9e34430cso2075200276.1
        for <bpf@vger.kernel.org>; Sat, 24 Feb 2024 14:34:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708814063; x=1709418863; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J/FVzjCe/H+DfHKGhgRWXvGEQ6dF3gPB3Fe/7v2klh8=;
        b=IeA36LX4khK5YBh/MJwuLSNjVTMJlnBxIkI8HcNLZ54ACnmyFfa96zIhPpHhw2LsaX
         +kwLrHST4vHgzr8odO73T4ATaAgveoob3oqf/4b120dIECY9aCk0CrT4a8y+BBwm6N8F
         CD9EBGFZQr4IY/JVbTnqj2nb8xng1P8b+SY7Y/szxeO3tgSAzhLKUM+3Vc3VNxGR2o5N
         IDCNhw/F4Jva+yanlD6ieqapsjs9lOzoBXnSwKKOsm+QiIoRoP/4KMNPbWI+T9i1ASa4
         y6/CKCpDkHaAuNpDCUS8YOURT1AJoSqlBMdJ3Y4ZAmnLXhAUb7TgWy0cErj3P5ahI1wz
         3oGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708814063; x=1709418863;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J/FVzjCe/H+DfHKGhgRWXvGEQ6dF3gPB3Fe/7v2klh8=;
        b=edCa3ma6jXN8XtI/5tpLADdFMXFXH4dHXhfOcmj9utBbxg7S/OpZhHkGmK14OWUrrd
         8rTZc5hlTEC4PwA0QSZ79P02TdnKzv5yhsRFQaDKiP4vFoSSawEp0FEe1NTylP4ZdiZH
         mBvuOz2Cf1vuKGJRzL8p5iAuZAmfFz3Ynfsj6mcCJyfnH64pvECkCNy+o8R/sf4NiRhy
         AF1+MZxk5XrghtfH58b+eDR8VESkEnkdmCmx4GrbkE/tXwx0qwY7w03+M3V6OIA1Qbfm
         pjbt4cTf+dS2FX1+Czj/kSCQxa0KrlHdoEsXhr9HaZvZZuVVX5pdoFyV57mVZ//+h93D
         68PA==
X-Gm-Message-State: AOJu0YybQnsQnguSUK6F3WLArkKmIsIwQGdY9ZxE3nRNoAWcAxkbwoiO
	nqbtSZ8haVK4Zyrq3O0U4ApPkQEQcVNNGD2dDwoHzlXAQ074NoDjpV6tfTw8
X-Google-Smtp-Source: AGHT+IG+/JtkFhQWzS5Ko9HcMEXeo2jN8MgtENa/b+uVzbauoD5uBLkQEopBRGVxXjK3+1M2cyrC7w==
X-Received: by 2002:a0d:e683:0:b0:608:be11:edd3 with SMTP id p125-20020a0de683000000b00608be11edd3mr3323943ywe.0.1708814063460;
        Sat, 24 Feb 2024 14:34:23 -0800 (PST)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:9221:84d5:342c:9ac4])
        by smtp.gmail.com with ESMTPSA id i184-20020a0dc6c1000000b00607e72b478csm474010ywd.133.2024.02.24.14.34.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Feb 2024 14:34:23 -0800 (PST)
From: Kui-Feng Lee <thinker.li@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	kernel-team@meta.com,
	andrii@kernel.org
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: [PATCH bpf-next v4 2/3] bpf: struct_ops supports more than one page for trampolines.
Date: Sat, 24 Feb 2024 14:34:17 -0800
Message-Id: <20240224223418.526631-3-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240224223418.526631-1-thinker.li@gmail.com>
References: <20240224223418.526631-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The BPF struct_ops previously only allowed for one page to be used for the
trampolines of all links in a map. However, we have recently run out of
space due to the large number of BPF program links. By allocating
additional pages when we exhaust an existing page, we can accommodate more
links in a single map.

The variable st_map->image has been changed to st_map->image_pages, and its
type has been changed to an array of pointers to buffers of
PAGE_SIZE. Every struct_ops map can have MAX_IMAGE_PAGES (8) pages for
trampolines at most.

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 include/linux/bpf.h            |   4 +-
 kernel/bpf/bpf_struct_ops.c    | 128 +++++++++++++++++++++++----------
 net/bpf/bpf_dummy_struct_ops.c |  12 ++--
 3 files changed, 97 insertions(+), 47 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 814dc913a968..f8d9ff56057c 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1763,7 +1763,9 @@ int bpf_struct_ops_prepare_trampoline(struct bpf_tramp_links *tlinks,
 				      struct bpf_tramp_link *link,
 				      const struct btf_func_model *model,
 				      void *stub_func,
-				      void *image, void *image_end);
+				      void **image, u32 *image_off,
+				      bool allow_alloc);
+void bpf_struct_ops_tramp_buf_free(void *image);
 static inline bool bpf_try_module_get(const void *data, struct module *owner)
 {
 	if (owner == BPF_MODULE_OWNER)
diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index 07e554c191d1..7aabc78e9b5b 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -18,6 +18,8 @@ struct bpf_struct_ops_value {
 	char data[] ____cacheline_aligned_in_smp;
 };
 
+#define MAX_TRAMP_IMAGE_PAGES 8
+
 struct bpf_struct_ops_map {
 	struct bpf_map map;
 	struct rcu_head rcu;
@@ -30,12 +32,11 @@ struct bpf_struct_ops_map {
 	 */
 	struct bpf_link **links;
 	u32 links_cnt;
-	/* image is a page that has all the trampolines
+	u32 image_pages_cnt;
+	/* image_pages is an array of pages that has all the trampolines
 	 * that stores the func args before calling the bpf_prog.
-	 * A PAGE_SIZE "image" is enough to store all trampoline for
-	 * "links[]".
 	 */
-	void *image;
+	void *image_pages[MAX_TRAMP_IMAGE_PAGES];
 	/* The owner moduler's btf. */
 	struct btf *btf;
 	/* uvalue->data stores the kernel struct
@@ -116,6 +117,30 @@ static bool is_valid_value_type(struct btf *btf, s32 value_id,
 	return true;
 }
 
+static void *bpf_struct_ops_tramp_buf_alloc(void)
+{
+	void *image;
+	int err;
+
+	err = bpf_jit_charge_modmem(PAGE_SIZE);
+	if (err)
+		return ERR_PTR(err);
+	image = arch_alloc_bpf_trampoline(PAGE_SIZE);
+	if (!image) {
+		bpf_jit_uncharge_modmem(PAGE_SIZE);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	return image;
+}
+
+void bpf_struct_ops_tramp_buf_free(void *image)
+{
+	arch_free_bpf_trampoline(image, PAGE_SIZE);
+	if (image)
+		bpf_jit_uncharge_modmem(PAGE_SIZE);
+}
+
 #define MAYBE_NULL_SUFFIX "__nullable"
 #define MAX_STUB_NAME 128
 
@@ -461,6 +486,15 @@ static void bpf_struct_ops_map_put_progs(struct bpf_struct_ops_map *st_map)
 	}
 }
 
+static void bpf_struct_ops_map_free_image(struct bpf_struct_ops_map *st_map)
+{
+	int i;
+
+	for (i = 0; i < st_map->image_pages_cnt; i++)
+		bpf_struct_ops_tramp_buf_free(st_map->image_pages[i]);
+	st_map->image_pages_cnt = 0;
+}
+
 static int check_zero_holes(const struct btf *btf, const struct btf_type *t, void *data)
 {
 	const struct btf_member *member;
@@ -503,12 +537,21 @@ const struct bpf_link_ops bpf_struct_ops_link_lops = {
 	.dealloc = bpf_struct_ops_link_dealloc,
 };
 
+/* *image should be NULL and allow_alloc should be true if a caller wants
+ * this function to allocate a image buffer for it. Otherwise, this
+ * function allocate a new image buffer only if allow_alloc is true and the
+ * size of the trampoline is larger than the space left in the current
+ * image buffer.
+ */
 int bpf_struct_ops_prepare_trampoline(struct bpf_tramp_links *tlinks,
 				      struct bpf_tramp_link *link,
 				      const struct btf_func_model *model,
-				      void *stub_func, void *image, void *image_end)
+				      void *stub_func,
+				      void **_image, u32 *image_off,
+				      bool allow_alloc)
 {
 	u32 flags = BPF_TRAMP_F_INDIRECT;
+	void *image = *_image;
 	int size;
 
 	tlinks[BPF_TRAMP_FENTRY].links[0] = link;
@@ -518,14 +561,30 @@ int bpf_struct_ops_prepare_trampoline(struct bpf_tramp_links *tlinks,
 		flags |= BPF_TRAMP_F_RET_FENTRY_RET;
 
 	size = arch_bpf_trampoline_size(model, flags, tlinks, NULL);
-	if (size < 0)
+	if (size <= 0)
 		return size;
-	if (size > (unsigned long)image_end - (unsigned long)image)
-		return -E2BIG;
-	return arch_prepare_bpf_trampoline(NULL, image, image_end,
+
+	/* Allocate image buffer if necessary */
+	if (!image || size > PAGE_SIZE - *image_off) {
+		if (!allow_alloc)
+			return -E2BIG;
+
+		image = bpf_struct_ops_tramp_buf_alloc();
+		if (IS_ERR(image))
+			return PTR_ERR(image);
+		*_image = image;
+		*image_off = 0;
+	}
+
+	size = arch_prepare_bpf_trampoline(NULL, image + *image_off,
+					   image + PAGE_SIZE,
 					   model, flags, tlinks, stub_func);
-}
+	if (size > 0)
+		*image_off += size;
+	/* The caller should free the allocated memory even if size < 0 */
 
+	return size;
+}
 static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
 					   void *value, u64 flags)
 {
@@ -539,8 +598,8 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
 	struct bpf_tramp_links *tlinks;
 	void *udata, *kdata;
 	int prog_fd, err;
-	void *image, *image_end;
-	u32 i;
+	u32 i, image_off = 0;
+	void *image = NULL;
 
 	if (flags)
 		return -EINVAL;
@@ -578,14 +637,15 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
 
 	udata = &uvalue->data;
 	kdata = &kvalue->data;
-	image = st_map->image;
-	image_end = st_map->image + PAGE_SIZE;
 
 	module_type = btf_type_by_id(btf_vmlinux, st_ops_ids[IDX_MODULE_ID]);
 	for_each_member(i, t, member) {
 		const struct btf_type *mtype, *ptype;
 		struct bpf_prog *prog;
 		struct bpf_tramp_link *link;
+		void *saved_image = image;
+		u32 init_off = image_off;
+		bool allow_alloc;
 		u32 moff;
 
 		moff = __btf_member_bit_offset(t, member) / 8;
@@ -658,15 +718,24 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
 			      &bpf_struct_ops_link_lops, prog);
 		st_map->links[i] = &link->link;
 
+		allow_alloc = st_map->image_pages_cnt < MAX_TRAMP_IMAGE_PAGES;
 		err = bpf_struct_ops_prepare_trampoline(tlinks, link,
 							&st_ops->func_models[i],
 							*(void **)(st_ops->cfi_stubs + moff),
-							image, image_end);
+							&image, &image_off,
+							allow_alloc);
+		if (saved_image != image) {
+			/* Add to image_pages[] to ensure the page has been
+			 * free later even the above call fails
+			 */
+			st_map->image_pages[st_map->image_pages_cnt++] = image;
+			init_off = 0;
+		}
 		if (err < 0)
 			goto reset_unlock;
 
-		*(void **)(kdata + moff) = image + cfi_get_offset();
-		image += err;
+		*(void **)(kdata + moff) =
+			image + init_off + cfi_get_offset();
 
 		/* put prog_id to udata */
 		*(unsigned long *)(udata + moff) = prog->aux->id;
@@ -677,10 +746,11 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
 		if (err)
 			goto reset_unlock;
 	}
+	for (i = 0; i < st_map->image_pages_cnt; i++)
+		arch_protect_bpf_trampoline(st_map->image_pages[i], PAGE_SIZE);
 
 	if (st_map->map.map_flags & BPF_F_LINK) {
 		err = 0;
-		arch_protect_bpf_trampoline(st_map->image, PAGE_SIZE);
 		/* Let bpf_link handle registration & unregistration.
 		 *
 		 * Pair with smp_load_acquire() during lookup_elem().
@@ -689,7 +759,6 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
 		goto unlock;
 	}
 
-	arch_protect_bpf_trampoline(st_map->image, PAGE_SIZE);
 	err = st_ops->reg(kdata);
 	if (likely(!err)) {
 		/* This refcnt increment on the map here after
@@ -712,9 +781,9 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
 	 * there was a race in registering the struct_ops (under the same name) to
 	 * a sub-system through different struct_ops's maps.
 	 */
-	arch_unprotect_bpf_trampoline(st_map->image, PAGE_SIZE);
 
 reset_unlock:
+	bpf_struct_ops_map_free_image(st_map);
 	bpf_struct_ops_map_put_progs(st_map);
 	memset(uvalue, 0, map->value_size);
 	memset(kvalue, 0, map->value_size);
@@ -781,10 +850,7 @@ static void __bpf_struct_ops_map_free(struct bpf_map *map)
 	if (st_map->links)
 		bpf_struct_ops_map_put_progs(st_map);
 	bpf_map_area_free(st_map->links);
-	if (st_map->image) {
-		arch_free_bpf_trampoline(st_map->image, PAGE_SIZE);
-		bpf_jit_uncharge_modmem(PAGE_SIZE);
-	}
+	bpf_struct_ops_map_free_image(st_map);
 	bpf_map_area_free(st_map->uvalue);
 	bpf_map_area_free(st_map);
 }
@@ -894,20 +960,6 @@ static struct bpf_map *bpf_struct_ops_map_alloc(union bpf_attr *attr)
 	st_map->st_ops_desc = st_ops_desc;
 	map = &st_map->map;
 
-	ret = bpf_jit_charge_modmem(PAGE_SIZE);
-	if (ret)
-		goto errout_free;
-
-	st_map->image = arch_alloc_bpf_trampoline(PAGE_SIZE);
-	if (!st_map->image) {
-		/* __bpf_struct_ops_map_free() uses st_map->image as flag
-		 * for "charged or not". In this case, we need to unchange
-		 * here.
-		 */
-		bpf_jit_uncharge_modmem(PAGE_SIZE);
-		ret = -ENOMEM;
-		goto errout_free;
-	}
 	st_map->uvalue = bpf_map_area_alloc(vt->size, NUMA_NO_NODE);
 	st_map->links_cnt = btf_type_vlen(t);
 	st_map->links =
diff --git a/net/bpf/bpf_dummy_struct_ops.c b/net/bpf/bpf_dummy_struct_ops.c
index 02de71719aed..da73905eff4a 100644
--- a/net/bpf/bpf_dummy_struct_ops.c
+++ b/net/bpf/bpf_dummy_struct_ops.c
@@ -91,6 +91,7 @@ int bpf_struct_ops_test_run(struct bpf_prog *prog, const union bpf_attr *kattr,
 	struct bpf_tramp_link *link = NULL;
 	void *image = NULL;
 	unsigned int op_idx;
+	u32 image_off = 0;
 	int prog_ret;
 	s32 type_id;
 	int err;
@@ -114,12 +115,6 @@ int bpf_struct_ops_test_run(struct bpf_prog *prog, const union bpf_attr *kattr,
 		goto out;
 	}
 
-	image = arch_alloc_bpf_trampoline(PAGE_SIZE);
-	if (!image) {
-		err = -ENOMEM;
-		goto out;
-	}
-
 	link = kzalloc(sizeof(*link), GFP_USER);
 	if (!link) {
 		err = -ENOMEM;
@@ -133,7 +128,8 @@ int bpf_struct_ops_test_run(struct bpf_prog *prog, const union bpf_attr *kattr,
 	err = bpf_struct_ops_prepare_trampoline(tlinks, link,
 						&st_ops->func_models[op_idx],
 						&dummy_ops_test_ret_function,
-						image, image + PAGE_SIZE);
+						&image, &image_off,
+						true);
 	if (err < 0)
 		goto out;
 
@@ -147,7 +143,7 @@ int bpf_struct_ops_test_run(struct bpf_prog *prog, const union bpf_attr *kattr,
 		err = -EFAULT;
 out:
 	kfree(args);
-	arch_free_bpf_trampoline(image, PAGE_SIZE);
+	bpf_struct_ops_tramp_buf_free(image);
 	if (link)
 		bpf_link_put(&link->link);
 	kfree(tlinks);
-- 
2.34.1


