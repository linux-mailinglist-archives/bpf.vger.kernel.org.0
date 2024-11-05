Return-Path: <bpf+bounces-44073-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DA069BD789
	for <lists+bpf@lfdr.de>; Tue,  5 Nov 2024 22:20:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C055D1C227A5
	for <lists+bpf@lfdr.de>; Tue,  5 Nov 2024 21:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6D3C215F52;
	Tue,  5 Nov 2024 21:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f8kzD6ns"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4B821219E
	for <bpf@vger.kernel.org>; Tue,  5 Nov 2024 21:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730841613; cv=none; b=myEEycRGIjLCWCmAzw0EhddG8Bkg9LSdR9CrjQY422olDIWHYAUHOBxBfBcdjD8cRCQyQc01keY2jCf34A24FfbiSN0qUOHfhQMeAkiLvZX3geJv3oD1I0/dGdNWG8jUKjZV86At98byNheSkA4brGutbzyh97N01BFJ53bX7Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730841613; c=relaxed/simple;
	bh=k2wJ71wvqksz/GUR7SNdKLpN45pADVmNc35+7PU1r8E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PzvbpPb0T2Q9a1L4+7kaKlVbK5G8MPGB5sL7CLigI/Yotqbnf5doba3DZ1wTRpj8+CHbsxlvNM36MWBk7eF4a/P+wRANgy75P7Pf05BWxhysUZLgTkA4FcmJVVU9YIfvVymDP6p7jvWqKwOFHhuKuct0ywf1ISeIKhnAS2NTTAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f8kzD6ns; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7ed9c16f687so4159117a12.0
        for <bpf@vger.kernel.org>; Tue, 05 Nov 2024 13:20:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730841610; x=1731446410; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K3Aol0LNSzRt9vmJXT7WPPCFO/XhVREnFgmy4iY/h2s=;
        b=f8kzD6nsaigJAHmhx3WgdrmkXFExSKA0gCXLkI3IY+RQ2vIA/MOHm3v6VJWqxOscbG
         gi7xp3BqwBOt/Ypr5MfCmOWJfiyqTxrha2IPzr+NQR7R0paHNl5rTGW9pxUgupQbEQPP
         FfFi0CNsaSa+FEpzg66s9ji0/fsCVEzQSMs1qwSz2j09FqASyvHovDEltcURvWaN1vDA
         6jFggk15C40pRK0LiaO5XeC2pTjrSJ7OulWIgKvLcHbTaV4lfhNawPMAgC7xna5MaSc+
         o2+E/i0A2JAWA3dGJ1woQ29BGTAQFod4W86NvFvG2R59dftF95d75NVqP5LGQIwi+z1c
         U08A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730841610; x=1731446410;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K3Aol0LNSzRt9vmJXT7WPPCFO/XhVREnFgmy4iY/h2s=;
        b=C8GhyyLJr1jGF7X9j9fa8ouqIxxTTUFzyE3IiAri5hZHFjD7kjzEcMzMvyZXc7TO4i
         0zt4ecrkmCrbny/pzxKJoUBiwcOCdqWD8G1GsnDW/GqCc3qZefyA+3icABP3q/25NpBU
         TDtrikfRCfc5RvI+QVssOBMxiuUnw9q7s0acOOYXCc7mYav9bpCjBPQUIwM636DsXYk7
         tw1qhzRKNSkp7uPiuIgd3gCLiggBYL2ughiwff/olrWV1yB7PlOsxdgG30prAHxYRCzl
         j2bqfEcNbHBq4D4/owqF63zKpxUTK42st9JYhSTwy9dl6U8E6A6/LCtQ040NibloFHUq
         dRJw==
X-Gm-Message-State: AOJu0YwTxUlEaWZiKDp2ETXxuUy1ncDcYignjcpKno8CyiDziMBmlHLj
	jp7dB9HiNroKIpxBpKNGVODqGd48FneXIEqzUvI8kINBTao/DPL/zCZ8Wg==
X-Google-Smtp-Source: AGHT+IHhY2fWlcUcjLM9gm0ZLtG3Puv7t8QW/cG7H6l2THgBV91AnWiaK/124E8gGCKjJzvFTpYroQ==
X-Received: by 2002:a17:90b:3849:b0:2e2:be64:488f with SMTP id 98e67ed59e1d1-2e93c12932amr26392341a91.6.1730841610310;
        Tue, 05 Nov 2024 13:20:10 -0800 (PST)
Received: from macbook-pro-49.lan ([2603:3023:16e:5000:1863:9460:a110:750b])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e93db183d8sm10203932a91.37.2024.11.05.13.20.09
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 05 Nov 2024 13:20:09 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	memxor@gmail.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	dri-devel@lists.freedesktop.org,
	kernel-team@fb.com
Subject: [PATCH v2 bpf-next 2/2] bpf: Switch bpf arena to use drm_mm instead of maple_tree
Date: Tue,  5 Nov 2024 13:20:01 -0800
Message-Id: <20241105212001.38980-3-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241105212001.38980-1-alexei.starovoitov@gmail.com>
References: <20241105212001.38980-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

bpf arena is moving towards non-sleepable allocations in tracing
context while maple_tree does kmalloc/kfree deep inside. Hence switch
bpf arena to drm_mm algorithm that works with externally provided
drm_mm_node-s. This patch kmalloc/kfree-s drm_mm_node-s, but the next
patch will switch to bpf_mem_alloc and preallocated drm_mm_node-s.

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/arena.c | 67 +++++++++++++++++++++++++++++++++++-----------
 lib/Makefile       |  1 +
 2 files changed, 53 insertions(+), 15 deletions(-)

diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
index e52b3ad231b9..ef1de26020f2 100644
--- a/kernel/bpf/arena.c
+++ b/kernel/bpf/arena.c
@@ -6,6 +6,7 @@
 #include <linux/btf_ids.h>
 #include <linux/vmalloc.h>
 #include <linux/pagemap.h>
+#include <drm/drm_mm.h>
 
 /*
  * bpf_arena is a sparsely populated shared memory region between bpf program and
@@ -45,7 +46,7 @@ struct bpf_arena {
 	u64 user_vm_start;
 	u64 user_vm_end;
 	struct vm_struct *kern_vm;
-	struct maple_tree mt;
+	struct drm_mm mm;
 	struct list_head vma_list;
 	struct mutex lock;
 };
@@ -132,7 +133,7 @@ static struct bpf_map *arena_map_alloc(union bpf_attr *attr)
 
 	INIT_LIST_HEAD(&arena->vma_list);
 	bpf_map_init_from_attr(&arena->map, attr);
-	mt_init_flags(&arena->mt, MT_FLAGS_ALLOC_RANGE);
+	drm_mm_init(&arena->mm, 0, attr->max_entries);
 	mutex_init(&arena->lock);
 
 	return &arena->map;
@@ -164,6 +165,7 @@ static int existing_page_cb(pte_t *ptep, unsigned long addr, void *data)
 static void arena_map_free(struct bpf_map *map)
 {
 	struct bpf_arena *arena = container_of(map, struct bpf_arena, map);
+	struct drm_mm_node *node, *next;
 
 	/*
 	 * Check that user vma-s are not around when bpf map is freed.
@@ -183,7 +185,11 @@ static void arena_map_free(struct bpf_map *map)
 	apply_to_existing_page_range(&init_mm, bpf_arena_get_kern_vm_start(arena),
 				     KERN_VM_SZ - GUARD_SZ, existing_page_cb, NULL);
 	free_vm_area(arena->kern_vm);
-	mtree_destroy(&arena->mt);
+	drm_mm_for_each_node_safe(node, next, &arena->mm) {
+		drm_mm_remove_node(node);
+		kfree(node);
+	}
+	drm_mm_takedown(&arena->mm);
 	bpf_map_area_free(arena);
 }
 
@@ -257,6 +263,7 @@ static vm_fault_t arena_vm_fault(struct vm_fault *vmf)
 {
 	struct bpf_map *map = vmf->vma->vm_file->private_data;
 	struct bpf_arena *arena = container_of(map, struct bpf_arena, map);
+	struct drm_mm_node *node;
 	struct page *page;
 	long kbase, kaddr;
 	int ret;
@@ -274,20 +281,30 @@ static vm_fault_t arena_vm_fault(struct vm_fault *vmf)
 		/* User space requested to segfault when page is not allocated by bpf prog */
 		return VM_FAULT_SIGSEGV;
 
-	ret = mtree_insert(&arena->mt, vmf->pgoff, MT_ENTRY, GFP_KERNEL);
-	if (ret)
+	node = kzalloc(sizeof(*node), GFP_KERNEL);
+	if (!node)
+		return VM_FAULT_SIGSEGV;
+
+	node->start = vmf->pgoff;
+	node->size = 1;
+	ret = drm_mm_reserve_node(&arena->mm, node);
+	if (ret) {
+		kfree(node);
 		return VM_FAULT_SIGSEGV;
+	}
 
 	/* Account into memcg of the process that created bpf_arena */
 	ret = bpf_map_alloc_pages(map, GFP_KERNEL | __GFP_ZERO, NUMA_NO_NODE, 1, &page);
 	if (ret) {
-		mtree_erase(&arena->mt, vmf->pgoff);
+		drm_mm_remove_node(node);
+		kfree(node);
 		return VM_FAULT_SIGSEGV;
 	}
 
 	ret = vm_area_map_pages(arena->kern_vm, kaddr, kaddr + PAGE_SIZE, &page);
 	if (ret) {
-		mtree_erase(&arena->mt, vmf->pgoff);
+		drm_mm_remove_node(node);
+		kfree(node);
 		__free_page(page);
 		return VM_FAULT_SIGSEGV;
 	}
@@ -420,6 +437,7 @@ static long arena_alloc_pages(struct bpf_arena *arena, long uaddr, long page_cnt
 	/* user_vm_end/start are fixed before bpf prog runs */
 	long page_cnt_max = (arena->user_vm_end - arena->user_vm_start) >> PAGE_SHIFT;
 	u64 kern_vm_start = bpf_arena_get_kern_vm_start(arena);
+	struct drm_mm_node *node;
 	struct page **pages;
 	long pgoff = 0;
 	u32 uaddr32;
@@ -442,14 +460,21 @@ static long arena_alloc_pages(struct bpf_arena *arena, long uaddr, long page_cnt
 	if (!pages)
 		return 0;
 
+	node = kzalloc(sizeof(*node), GFP_KERNEL);
+	if (!node) {
+		kvfree(pages);
+		return 0;
+	}
 	guard(mutex)(&arena->lock);
 
-	if (uaddr)
-		ret = mtree_insert_range(&arena->mt, pgoff, pgoff + page_cnt - 1,
-					 MT_ENTRY, GFP_KERNEL);
-	else
-		ret = mtree_alloc_range(&arena->mt, &pgoff, MT_ENTRY,
-					page_cnt, 0, page_cnt_max - 1, GFP_KERNEL);
+	if (uaddr) {
+		node->start = pgoff;
+		node->size = page_cnt;
+		ret = drm_mm_reserve_node(&arena->mm, node);
+	} else {
+		ret = drm_mm_insert_node(&arena->mm, node, page_cnt);
+		pgoff = node->start;
+	}
 	if (ret)
 		goto out_free_pages;
 
@@ -476,7 +501,8 @@ static long arena_alloc_pages(struct bpf_arena *arena, long uaddr, long page_cnt
 	kvfree(pages);
 	return clear_lo32(arena->user_vm_start) + uaddr32;
 out:
-	mtree_erase(&arena->mt, pgoff);
+	drm_mm_remove_node(node);
+	kfree(node);
 out_free_pages:
 	kvfree(pages);
 	return 0;
@@ -499,6 +525,7 @@ static void zap_pages(struct bpf_arena *arena, long uaddr, long page_cnt)
 static void arena_free_pages(struct bpf_arena *arena, long uaddr, long page_cnt)
 {
 	u64 full_uaddr, uaddr_end;
+	struct drm_mm_node *node, *to_remove;
 	long kaddr, pgoff, i;
 	struct page *page;
 
@@ -516,7 +543,17 @@ static void arena_free_pages(struct bpf_arena *arena, long uaddr, long page_cnt)
 
 	pgoff = compute_pgoff(arena, uaddr);
 	/* clear range */
-	mtree_store_range(&arena->mt, pgoff, pgoff + page_cnt - 1, NULL, GFP_KERNEL);
+	for (;;) {
+		to_remove = NULL;
+		drm_mm_for_each_node_in_range(node, &arena->mm, pgoff, pgoff + page_cnt) {
+			to_remove = node;
+			break;
+		}
+		if (!to_remove)
+			break;
+		drm_mm_remove_node(to_remove);
+		kfree(to_remove);
+	}
 
 	if (page_cnt > 1)
 		/* bulk zap if multiple pages being freed */
diff --git a/lib/Makefile b/lib/Makefile
index 320ae0ac227c..4d3e1ae97b75 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -59,6 +59,7 @@ obj-y += kstrtox.o
 obj-$(CONFIG_FIND_BIT_BENCHMARK) += find_bit_benchmark.o
 obj-$(CONFIG_TEST_BPF) += test_bpf.o
 lib-$(CONFIG_DRM) += drm_mm.o
+lib-$(CONFIG_BPF_SYSCALL) += drm_mm.o
 test_dhry-objs := dhry_1.o dhry_2.o dhry_run.o
 obj-$(CONFIG_TEST_DHRY) += test_dhry.o
 obj-$(CONFIG_TEST_FIRMWARE) += test_firmware.o
-- 
2.43.5


