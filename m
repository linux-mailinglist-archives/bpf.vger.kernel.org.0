Return-Path: <bpf+bounces-22469-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 384F185EC1D
	for <lists+bpf@lfdr.de>; Wed, 21 Feb 2024 23:59:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C2891C239F4
	for <lists+bpf@lfdr.de>; Wed, 21 Feb 2024 22:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30ED2128386;
	Wed, 21 Feb 2024 22:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FXyO2h2c"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C7D5232
	for <bpf@vger.kernel.org>; Wed, 21 Feb 2024 22:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708556359; cv=none; b=bM6WuyG8PHzNOPh+KJqM3H5Ls4W3eMHWeFiIi2U5A1wJixHcz9ULqz3cku7jZUxDVr+ffcRjdTWJNzMM8MdR0kRvlsge11PRcBMTft1oOhdTuCuEMx3hALaG9ZZM3gOUtwS/LF3zma3C6wIIEC0/ob9aubGX7ZZ2wz0eFNAEFHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708556359; c=relaxed/simple;
	bh=AQuGZabXM0QUiKy2406UmkHLUrpu8r0Sm5l/hiHl4aI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JeLc3Uxh4AVXNpGSnQW/Y8gEYHf778HoQ/wY+PFbFhfQZnOBD4tL2kakM35LXsliX6JRRLZ10UjjCfJ0/7nbTUh4UkFcZRaBnFIT83WO6M8D3jK2gjTlXDzCoctc3+aAfthNtSDE1ycVX+Mx/M4wjqml5JP4KfPoDj+AzN82ocQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FXyO2h2c; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6083dc087b3so38079667b3.0
        for <bpf@vger.kernel.org>; Wed, 21 Feb 2024 14:59:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708556356; x=1709161156; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l3Tgcz2FmHfN5mrra5ju37RF75F3ETRnI/0SVQD+JbQ=;
        b=FXyO2h2ckXhCo3eby6bGLTsWxMgIfrW/7Hgz+EuDrwQN3B3dZs7rUTHWNZiuA2bAeX
         y1cfulXZP41Z161XyK0dHmZ4UMWbVDi+zoVCcSk72x0/1HhyXDT8Pmj74QSP9EmB0IuT
         aEfhlKGRKtVFOSPrR+9wIyh03mQAn4BxYokQmrp7x3Rpv7IwGf78P3/MSnzxg94dsVqd
         7aoouIpHRoEsQ1uGDHzYdqlv7w77YG7bopp9+hU9sqWUkurgEoNS0+hSbmZq7RbRqgD9
         +LkZyy0P+kQJio+JkViCFXZMUA4J0RxzwNq6X1a+KAzS1w27nP+TOCvO5Kpe7hh9cbt0
         xEuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708556356; x=1709161156;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l3Tgcz2FmHfN5mrra5ju37RF75F3ETRnI/0SVQD+JbQ=;
        b=A3PSP8EbNVZaylNK2bNJiJf06clCXMmtvrsuIV89v0YjPAKcUoNGkCagDPEZKSptS3
         tGvDa2NCMqz1NWdny4YVodZvAYRxfbE3h57auooCqgZUSlWBUT1x9sMOWxokUP2Mf1xE
         G7VNEe8MS8mk8TI0F6t5JpfQMqS33CSdy4IEZLz1FTJfxXPEYm4ycFJ5vgSa+8u+rlLL
         gCvCptHEHSW5phDhUnGwdUajwEMuY7busO2ZsanlBfQFuADbv1hnY1PxFP1Mk9ocAaHu
         R9SEl8Aq5X7ZY0sIa9EQtL97itE+Z0McgnVVBu6/CVgYumwp0qd/Av1X+4+V6/E6xfmS
         V8Nw==
X-Gm-Message-State: AOJu0YykbWOH9ntPQvIcGO6MZOgCNqdi0TqzWd6H67wU/aBZ0FJR7Mqx
	Gg9iO/jClFB3SvFBicHYn30kzbpphZuSaAZ4rEFfgT2UMt+V0CRr85Nvh9uh
X-Google-Smtp-Source: AGHT+IEJ4nxmlpmFBEK05u8rouAQklDf/2g9F83LhQnSRZoyrXdAEnWEKs7CQBYQe39dML2Q5zkzYw==
X-Received: by 2002:a81:bc45:0:b0:608:7686:21b5 with SMTP id b5-20020a81bc45000000b00608768621b5mr4628170ywl.35.1708556356556;
        Wed, 21 Feb 2024 14:59:16 -0800 (PST)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:bc3b:b762:a625:955f])
        by smtp.gmail.com with ESMTPSA id s67-20020a0de946000000b006078c48a265sm2820090ywe.6.2024.02.21.14.59.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 14:59:16 -0800 (PST)
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
Subject: [PATCH bpf-next v2 2/3] bpf: struct_ops supports more than one page for trampolines.
Date: Wed, 21 Feb 2024 14:59:10 -0800
Message-Id: <20240221225911.757861-3-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240221225911.757861-1-thinker.li@gmail.com>
References: <20240221225911.757861-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kui-Feng Lee <thinker.li@gmail.com>

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
 kernel/bpf/bpf_struct_ops.c | 112 +++++++++++++++++++++++++-----------
 1 file changed, 79 insertions(+), 33 deletions(-)

diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index c244ed5114fd..15bf8058161b 100644
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
@@ -456,6 +457,41 @@ static void bpf_struct_ops_map_put_progs(struct bpf_struct_ops_map *st_map)
 	}
 }
 
+static void bpf_struct_ops_map_free_image(struct bpf_struct_ops_map *st_map)
+{
+	int i;
+	void *image;
+
+	bpf_jit_uncharge_modmem(PAGE_SIZE * st_map->image_pages_cnt);
+	for (i = 0; i < st_map->image_pages_cnt; i++) {
+		image = st_map->image_pages[i];
+		arch_free_bpf_trampoline(image, PAGE_SIZE);
+	}
+	st_map->image_pages_cnt = 0;
+}
+
+static void *bpf_struct_ops_map_inc_image(struct bpf_struct_ops_map *st_map)
+{
+	void *image;
+	int err;
+
+	if (st_map->image_pages_cnt >= MAX_TRAMP_IMAGE_PAGES)
+		return ERR_PTR(-E2BIG);
+
+	err = bpf_jit_charge_modmem(PAGE_SIZE);
+	if (err)
+		return ERR_PTR(err);
+
+	image = arch_alloc_bpf_trampoline(PAGE_SIZE);
+	if (!image) {
+		bpf_jit_uncharge_modmem(PAGE_SIZE);
+		return ERR_PTR(-ENOMEM);
+	}
+	st_map->image_pages[st_map->image_pages_cnt++] = image;
+
+	return image;
+}
+
 static int check_zero_holes(const struct btf *btf, const struct btf_type *t, void *data)
 {
 	const struct btf_member *member;
@@ -531,10 +567,10 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
 	const struct btf_type *module_type;
 	const struct btf_member *member;
 	const struct btf_type *t = st_ops_desc->type;
+	void *image = NULL, *image_end = NULL;
 	struct bpf_tramp_links *tlinks;
 	void *udata, *kdata;
 	int prog_fd, err;
-	void *image, *image_end;
 	u32 i;
 
 	if (flags)
@@ -573,15 +609,14 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
 
 	udata = &uvalue->data;
 	kdata = &kvalue->data;
-	image = st_map->image;
-	image_end = st_map->image + PAGE_SIZE;
 
 	module_type = btf_type_by_id(btf_vmlinux, st_ops_ids[IDX_MODULE_ID]);
 	for_each_member(i, t, member) {
 		const struct btf_type *mtype, *ptype;
 		struct bpf_prog *prog;
 		struct bpf_tramp_link *link;
-		u32 moff;
+		u32 moff, tflags;
+		int tsize;
 
 		moff = __btf_member_bit_offset(t, member) / 8;
 		ptype = btf_type_resolve_ptr(st_map->btf, member->type, NULL);
@@ -653,10 +688,38 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
 			      &bpf_struct_ops_link_lops, prog);
 		st_map->links[i] = &link->link;
 
-		err = bpf_struct_ops_prepare_trampoline(tlinks, link,
-							&st_ops->func_models[i],
-							*(void **)(st_ops->cfi_stubs + moff),
-							image, image_end);
+		tflags = BPF_TRAMP_F_INDIRECT;
+		if (st_ops->func_models[i].ret_size > 0)
+			tflags |= BPF_TRAMP_F_RET_FENTRY_RET;
+
+		/* Compute the size of the trampoline */
+		tlinks[BPF_TRAMP_FENTRY].links[0] = link;
+		tlinks[BPF_TRAMP_FENTRY].nr_links = 1;
+		tsize = arch_bpf_trampoline_size(&st_ops->func_models[i],
+						 tflags, tlinks, NULL);
+		if (tsize < 0) {
+			err = tsize;
+			goto reset_unlock;
+		}
+
+		/* Allocate pages */
+		if (tsize > (unsigned long)image_end - (unsigned long)image) {
+			if (tsize > PAGE_SIZE) {
+				err = -E2BIG;
+				goto reset_unlock;
+			}
+			image = bpf_struct_ops_map_inc_image(st_map);
+			if (IS_ERR(image)) {
+				err = PTR_ERR(image);
+				goto reset_unlock;
+			}
+			image_end = image + PAGE_SIZE;
+		}
+
+		err = arch_prepare_bpf_trampoline(NULL, image, image_end,
+						  &st_ops->func_models[i],
+						  tflags, tlinks,
+						  *(void **)(st_ops->cfi_stubs + moff));
 		if (err < 0)
 			goto reset_unlock;
 
@@ -672,10 +735,11 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
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
@@ -684,7 +748,6 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
 		goto unlock;
 	}
 
-	arch_protect_bpf_trampoline(st_map->image, PAGE_SIZE);
 	err = st_ops->reg(kdata);
 	if (likely(!err)) {
 		/* This refcnt increment on the map here after
@@ -707,9 +770,9 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
 	 * there was a race in registering the struct_ops (under the same name) to
 	 * a sub-system through different struct_ops's maps.
 	 */
-	arch_unprotect_bpf_trampoline(st_map->image, PAGE_SIZE);
 
 reset_unlock:
+	bpf_struct_ops_map_free_image(st_map);
 	bpf_struct_ops_map_put_progs(st_map);
 	memset(uvalue, 0, map->value_size);
 	memset(kvalue, 0, map->value_size);
@@ -776,10 +839,7 @@ static void __bpf_struct_ops_map_free(struct bpf_map *map)
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
@@ -889,20 +949,6 @@ static struct bpf_map *bpf_struct_ops_map_alloc(union bpf_attr *attr)
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
-- 
2.34.1


