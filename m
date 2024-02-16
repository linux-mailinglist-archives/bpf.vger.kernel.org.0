Return-Path: <bpf+bounces-22174-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03E11858531
	for <lists+bpf@lfdr.de>; Fri, 16 Feb 2024 19:30:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEF572833A2
	for <lists+bpf@lfdr.de>; Fri, 16 Feb 2024 18:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DC50135A45;
	Fri, 16 Feb 2024 18:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nsw/jAxD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A411350F5
	for <bpf@vger.kernel.org>; Fri, 16 Feb 2024 18:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708108116; cv=none; b=PVmYeTofNAO9+BH6WtVZeLfsrmc9kgRH6G6PdalzFk3M9YEaI1Pj5/AobBXHg5Keg/wgJ/tKQtQd9pI1TXvAF1qcx+MI/BoA3qgJBeCXfdzh0G9oPPH+spRKVRJlPKruKOzbLUZq9Ez3wX3o2lUghl6VrOh7AVRjkxDNtqGnIrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708108116; c=relaxed/simple;
	bh=2r6I/0aAWL3IZajnhrZHEKSwZddt/rM9DnItyhRhcso=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tPlE1yg+dDc3Z8bCIKf9NarzEg6i7nDNJbdN1E/+jydZbtx5CQjCb1Whz1mYtlytAGQr3rJCX15X1RahHVzPib/TLlIhrVGTdlzt3sYxe4I1nC4ny3+BC8+A035C6iY7EG39/F/wBmiNzTokZRgnIb35+2xyKzrOc/AV1cajKjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nsw/jAxD; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-60777552d72so22098707b3.1
        for <bpf@vger.kernel.org>; Fri, 16 Feb 2024 10:28:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708108113; x=1708712913; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fjj/EN9ZebhFnCqySszt1LTIPmJGEQ/5iZ0M2gfXu8E=;
        b=nsw/jAxDn/jpvh7K4nVhMHXZkTnZkPzLZSL1aBpcxsqXIj9yxRv0J6m381F8gyreSh
         k5j0Wq3IajTy3k/68IVKTjwfn/xfLfmxN2i/5W4sOkuI8gsKauYs5kETSmotFwjjxBHp
         PhpWEZQa5zZkv5d76Wg0jSNE0LSRcyxExZqI1etHOox3Qgz50RHxnBUx4s+/gZrM6tne
         YxxJJ0fUop+Np3XC4tFeBesgbfaplJT2rYTBWMuYIDUvAHQh2L9aF9lPW0ueF9TdCjbI
         NJ5Fy+subXAdSqruVBUIQIY7U+v501F5e/9rh0DB1hvvuSuWJEM3q/JxXzOHLFZu5MxN
         QE6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708108113; x=1708712913;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fjj/EN9ZebhFnCqySszt1LTIPmJGEQ/5iZ0M2gfXu8E=;
        b=na5gIkPK/S91EPwScGFkw66Mad5tuChE9f6slGqvXooyCaMVRj9Q+WsnlCJFu0mqgC
         xCOGQbk+NXNuXgS0Wi0TZ07XsSxn4xbOEnxwo0IcffMtppFJM3FQEasdJUk2InvpvWtE
         7uv36IHld1g9wOPVFV/tUgQOXDxY0OD5NDlXtEhdO9keZ6FFValTRxlwNw4b8O//Bp6G
         aVSx+LxkyOuxqQVMRP15GYho1BgAObrYmMO6EOmh58vRse+FoYfvT6Z9WT59loV4sEG7
         Bc/69+C5Em5SLpPL3NaKMq8vhHLoCaGSWHG3zl2z/sWVRyt8dwmbfkboKsO1HiXOrblv
         XgwQ==
X-Gm-Message-State: AOJu0YzRIcWxV0znX6zKC0g9Oi4rvGnrtPVPL7fZDsBlfu50Ew26ui4b
	N1XLNtSBA1oW7SaTJI8JfFYhnBSJoJBLyZzwmaqqdxsQhub4ousTz7Ikw9VS
X-Google-Smtp-Source: AGHT+IFMc+q5RJwP6LNuY8yT4WWLvP2FOiOcoPNdHqtYB2r/N1oOsd4ET7Z+O9gTrICjmHS9KzvOrQ==
X-Received: by 2002:a0d:f883:0:b0:607:fdb8:3cd2 with SMTP id i125-20020a0df883000000b00607fdb83cd2mr2409798ywf.20.1708108112850;
        Fri, 16 Feb 2024 10:28:32 -0800 (PST)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:6477:3a7d:9823:f253])
        by smtp.gmail.com with ESMTPSA id z20-20020a81c214000000b00604a3e9c407sm436190ywc.41.2024.02.16.10.28.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 10:28:32 -0800 (PST)
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
Subject: [PATCH bpf-next 1/2] bpf: struct_ops supports more than one page for trampolines.
Date: Fri, 16 Feb 2024 10:28:27 -0800
Message-Id: <20240216182828.201727-2-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240216182828.201727-1-thinker.li@gmail.com>
References: <20240216182828.201727-1-thinker.li@gmail.com>
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
type has been changed to an array of pointers to buffers of PAGE_SIZE. The
array is dynamically resized and additional pages are allocated when all
existing pages are exhausted.

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 kernel/bpf/bpf_struct_ops.c | 99 ++++++++++++++++++++++++++++++-------
 1 file changed, 80 insertions(+), 19 deletions(-)

diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index 0d7be97a2411..bb7ae665006a 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -30,12 +30,11 @@ struct bpf_struct_ops_map {
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
+	void **image_pages;
 	/* The owner moduler's btf. */
 	struct btf *btf;
 	/* uvalue->data stores the kernel struct
@@ -535,7 +534,8 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
 	void *udata, *kdata;
 	int prog_fd, err;
 	void *image, *image_end;
-	u32 i;
+	void **image_pages;
+	u32 i, next_page = 0;
 
 	if (flags)
 		return -EINVAL;
@@ -573,8 +573,8 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
 
 	udata = &uvalue->data;
 	kdata = &kvalue->data;
-	image = st_map->image;
-	image_end = st_map->image + PAGE_SIZE;
+	image = st_map->image_pages[next_page++];
+	image_end = image + PAGE_SIZE;
 
 	module_type = btf_type_by_id(btf_vmlinux, st_ops_ids[IDX_MODULE_ID]);
 	for_each_member(i, t, member) {
@@ -657,6 +657,43 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
 							&st_ops->func_models[i],
 							*(void **)(st_ops->cfi_stubs + moff),
 							image, image_end);
+		if (err == -E2BIG) {
+			/* Use an additional page to try again.
+			 *
+			 * It may reuse pages allocated for the previous
+			 * failed calls.
+			 */
+			if (next_page >= st_map->image_pages_cnt) {
+				/* Allocate an additional page */
+				image_pages = krealloc(st_map->image_pages,
+						       (st_map->image_pages_cnt + 1) * sizeof(void *),
+						       GFP_KERNEL);
+				if (!image_pages) {
+					err = -ENOMEM;
+					goto reset_unlock;
+				}
+				st_map->image_pages = image_pages;
+
+				err = bpf_jit_charge_modmem(PAGE_SIZE);
+				if (err)
+					goto reset_unlock;
+
+				image = arch_alloc_bpf_trampoline(PAGE_SIZE);
+				if (!image) {
+					bpf_jit_uncharge_modmem(PAGE_SIZE);
+					err = -ENOMEM;
+					goto reset_unlock;
+				}
+				st_map->image_pages[st_map->image_pages_cnt++] = image;
+			}
+			image = st_map->image_pages[next_page++];
+			image_end = image + PAGE_SIZE;
+
+			err = bpf_struct_ops_prepare_trampoline(tlinks, link,
+								&st_ops->func_models[i],
+								*(void **)(st_ops->cfi_stubs + moff),
+								image, image_end);
+		}
 		if (err < 0)
 			goto reset_unlock;
 
@@ -667,6 +704,18 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
 		*(unsigned long *)(udata + moff) = prog->aux->id;
 	}
 
+	while (next_page < st_map->image_pages_cnt) {
+		/* Free unused pages
+		 *
+		 * The value can not be updated anymore if the value is not
+		 * rejected by st_ops->validate() or st_ops->reg().  So,
+		 * there is no reason to keep the unused pages.
+		 */
+		bpf_jit_uncharge_modmem(PAGE_SIZE);
+		image = st_map->image_pages[--st_map->image_pages_cnt];
+		arch_free_bpf_trampoline(image, PAGE_SIZE);
+	}
+
 	if (st_map->map.map_flags & BPF_F_LINK) {
 		err = 0;
 		if (st_ops->validate) {
@@ -674,7 +723,9 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
 			if (err)
 				goto reset_unlock;
 		}
-		arch_protect_bpf_trampoline(st_map->image, PAGE_SIZE);
+		for (i = 0; i < next_page; i++)
+			arch_protect_bpf_trampoline(st_map->image_pages[i],
+						    PAGE_SIZE);
 		/* Let bpf_link handle registration & unregistration.
 		 *
 		 * Pair with smp_load_acquire() during lookup_elem().
@@ -683,7 +734,8 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
 		goto unlock;
 	}
 
-	arch_protect_bpf_trampoline(st_map->image, PAGE_SIZE);
+	for (i = 0; i < next_page; i++)
+		arch_protect_bpf_trampoline(st_map->image_pages[i], PAGE_SIZE);
 	err = st_ops->reg(kdata);
 	if (likely(!err)) {
 		/* This refcnt increment on the map here after
@@ -706,7 +758,8 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
 	 * there was a race in registering the struct_ops (under the same name) to
 	 * a sub-system through different struct_ops's maps.
 	 */
-	arch_unprotect_bpf_trampoline(st_map->image, PAGE_SIZE);
+	for (i = 0; i < next_page; i++)
+		arch_unprotect_bpf_trampoline(st_map->image_pages[i], PAGE_SIZE);
 
 reset_unlock:
 	bpf_struct_ops_map_put_progs(st_map);
@@ -771,14 +824,15 @@ static void bpf_struct_ops_map_seq_show_elem(struct bpf_map *map, void *key,
 static void __bpf_struct_ops_map_free(struct bpf_map *map)
 {
 	struct bpf_struct_ops_map *st_map = (struct bpf_struct_ops_map *)map;
+	int i;
 
 	if (st_map->links)
 		bpf_struct_ops_map_put_progs(st_map);
 	bpf_map_area_free(st_map->links);
-	if (st_map->image) {
-		arch_free_bpf_trampoline(st_map->image, PAGE_SIZE);
-		bpf_jit_uncharge_modmem(PAGE_SIZE);
-	}
+	for (i = 0; i < st_map->image_pages_cnt; i++)
+		arch_free_bpf_trampoline(st_map->image_pages[i], PAGE_SIZE);
+	bpf_jit_uncharge_modmem(PAGE_SIZE * st_map->image_pages_cnt);
+	kfree(st_map->image_pages);
 	bpf_map_area_free(st_map->uvalue);
 	bpf_map_area_free(st_map);
 }
@@ -888,20 +942,27 @@ static struct bpf_map *bpf_struct_ops_map_alloc(union bpf_attr *attr)
 	st_map->st_ops_desc = st_ops_desc;
 	map = &st_map->map;
 
+	st_map->image_pages = kcalloc(1, sizeof(void *), GFP_KERNEL);
+	if (!st_map->image_pages) {
+		ret = -ENOMEM;
+		goto errout_free;
+	}
+
 	ret = bpf_jit_charge_modmem(PAGE_SIZE);
 	if (ret)
 		goto errout_free;
 
-	st_map->image = arch_alloc_bpf_trampoline(PAGE_SIZE);
-	if (!st_map->image) {
-		/* __bpf_struct_ops_map_free() uses st_map->image as flag
-		 * for "charged or not". In this case, we need to unchange
-		 * here.
+	st_map->image_pages[0] = arch_alloc_bpf_trampoline(PAGE_SIZE);
+	if (!st_map->image_pages[0]) {
+		/* __bpf_struct_ops_map_free() uses st_map->image_pages_cnt
+		 * to for uncharging a number of pages.  In this case, we
+		 * need to uncharge here.
 		 */
 		bpf_jit_uncharge_modmem(PAGE_SIZE);
 		ret = -ENOMEM;
 		goto errout_free;
 	}
+	st_map->image_pages_cnt = 1;
 	st_map->uvalue = bpf_map_area_alloc(vt->size, NUMA_NO_NODE);
 	st_map->links_cnt = btf_type_vlen(t);
 	st_map->links =
-- 
2.34.1


