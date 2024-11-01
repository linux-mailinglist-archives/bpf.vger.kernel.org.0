Return-Path: <bpf+bounces-43797-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 093739B9B56
	for <lists+bpf@lfdr.de>; Sat,  2 Nov 2024 00:55:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC6D42819B9
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2024 23:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C7941DB344;
	Fri,  1 Nov 2024 23:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HC+faqic"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796DE1CEE88
	for <bpf@vger.kernel.org>; Fri,  1 Nov 2024 23:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730505310; cv=none; b=YwkFzNkRTElB8jwh134BdydgWefEvMOyLPph90I2c4m79dsHtImN55mqkPSmHJ0AWNDo2ICJOQlj2cE18yQzUbWoAI+e1LfNs80NnxUf3xIPCkKstyMhKh1wWDKKBkvf1sM8QRfLoNxnN/j6JgPfxtnLg/sPLRye+I1q50P6uYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730505310; c=relaxed/simple;
	bh=uHP27XzfPmJTB9Nge/wFlpmtZsKNjElrFaK4PjiHj4o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GA0Ug6qX6v/qM9ntCNG1c4RKYbpuM6ROZwUIE1znEeSz8hQv7Z+LQOw6uLrc92vTLWN0DynC2bDMIwDsKsmCb8+NT4eCqUKTaenn6vdaEYDZkvPEyItFq2UKXABRXTFOXsFIT2x6J1ouSA+9v8yclhgtnycVrzJqe3kL4LHksyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HC+faqic; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7205b6f51f3so2179807b3a.1
        for <bpf@vger.kernel.org>; Fri, 01 Nov 2024 16:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730505307; x=1731110107; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LJxFKebSx7zrRkfr76WJvp4GsO3+c9Ujl0eoJtBuqDQ=;
        b=HC+faqicUcXAijA7nRbY4vqnM94ERkjd2teJc4M4QCQy1W25Wcye2Ex1ordJJ7aLq1
         ZqFcFmM2zDlw3cGArX2ScgAy+6M/6UUUjwu6zdLyBgIn9+eNjbxnbpONEaAC1x5cb3vd
         KQ+9G9dnTNRe8JA1tdANvrTJP0fM8Ot07L4ZXWf9mpPpwtYBKgytWsHLZqVdko9NQm6F
         w0COjcOLajqrvMRSxz+u3nKyDMDn2d4cbUm9oyKB2mjfxVYVBDhGKbU4VNjOEXUBqND0
         gAfv1/7/2YAk5bXiDqxV9JqkNMd+vwANchmiJJUtRDRNx9ZXG4yQePdGURJs02XIq6ZM
         2AfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730505307; x=1731110107;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LJxFKebSx7zrRkfr76WJvp4GsO3+c9Ujl0eoJtBuqDQ=;
        b=msSROduTdFHfb1yXAlatE5kBhcZRxe/kdD9Tlf2PLQ9iF2sug/bgOJHdab553ISlkr
         WNAoMl5ukS5ZwzpPWo9Rr3jswcrhQCMmHEqFtkb5EqHd+3V0ipuwrKbudcBFyc2K5h7e
         54K6v6Q6rC071Bam4r/DHagRpsAsxDYBuYUHOVHSmmFCnsoskAnwWsXCJdh2jPc7p8eP
         5IPVUWn4f5imU0QLZqQEOQ0TYqyC0/Ka9o5q79ct2D3Wrfx1yYjkFJRJZZa924/wqAU4
         ZPRqDefHS+kRMJQKnzUuc5R6og/8xqwtkB2gFPFrluVDM7KV7ntx6Pw08vpAUIQV8pUO
         2Cwg==
X-Gm-Message-State: AOJu0YytWl5B4V4gmjvRkGA1hSPVFu87cp7WtU0f61wwhTDAWJqJ9qz0
	3s/2bJnu6rR7I3VlVLGBrcmt6WdJiD5d5pT+hC0oP96R0cXyhk3vL5/08Q==
X-Google-Smtp-Source: AGHT+IHY7edvJre2a9iTf1j4tY2ZYnpz6gk3Fg/Att00o0EeAfl3NVCM8rzK53IyKrNHX7pI89lwpg==
X-Received: by 2002:a05:6a21:3a83:b0:1d9:1907:aa2b with SMTP id adf61e73a8af0-1dba5219098mr7426138637.1.1730505306958;
        Fri, 01 Nov 2024 16:55:06 -0700 (PDT)
Received: from tungpham-mbp.DHCP.thefacebook.com ([2620:10d:c090:400::5:7de5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-720bc2eb64esm3238357b3a.168.2024.11.01.16.55.05
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 01 Nov 2024 16:55:06 -0700 (PDT)
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
Subject: [PATCH bpf-next 2/2] bpf: Switch bpf arena to use drm_mm instead of maple_tree
Date: Fri,  1 Nov 2024 16:54:53 -0700
Message-Id: <20241101235453.63380-3-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241101235453.63380-1-alexei.starovoitov@gmail.com>
References: <20241101235453.63380-1-alexei.starovoitov@gmail.com>
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
index 605aa25b71ab..d4787e6b0942 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -58,6 +58,7 @@ obj-$(CONFIG_TEST_HEXDUMP) += test_hexdump.o
 obj-y += kstrtox.o
 obj-$(CONFIG_FIND_BIT_BENCHMARK) += find_bit_benchmark.o
 obj-$(CONFIG_TEST_BPF) += test_bpf.o
+obj-$(CONFIG_BPF_SYSCALL) += drm_mm.o
 obj-$(CONFIG_DRM) += drm_mm.o
 test_dhry-objs := dhry_1.o dhry_2.o dhry_run.o
 obj-$(CONFIG_TEST_DHRY) += test_dhry.o
-- 
2.43.5


