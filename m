Return-Path: <bpf+bounces-44318-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FACA9C1457
	for <lists+bpf@lfdr.de>; Fri,  8 Nov 2024 03:56:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B28501F2252A
	for <lists+bpf@lfdr.de>; Fri,  8 Nov 2024 02:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAAD261FFE;
	Fri,  8 Nov 2024 02:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hEJwDqGW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2391BD9D1
	for <bpf@vger.kernel.org>; Fri,  8 Nov 2024 02:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731034585; cv=none; b=bg16MVD7XxMG9HHSbRUofYqwwNjnmhun/eWkhTCS+qW+qDErP5vPqZf2iJPCuFv84E8BvPsayZqVw38jCUtdCjHqfq9Wn9zxr8k4JntTNLX3mW1of81mPVIgFlpINT4W+LwPU3Xo+yfyEVxA88aNtXLkrbRKhCpfIhibRuKdexw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731034585; c=relaxed/simple;
	bh=TRlATWuWLgRdSnpxAwpat98rXEfpflRnmOKRQSsC1B4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=j7Kiaap0p09XtMWjbVDKSBUU6QZI6Jix8Dr1zzsgKzgidSQoRFyJHtMNjZiN790X5EKsWsH6QQpX7Ox4TqL1cp/1maDy+7FOpkGZzj/ZTR2xwZ00TMs6687mzpAeeB3UM8/ce0OtOeI+nv2jtzc8Pc8AIQQ/NhlAfL70WEigkuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hEJwDqGW; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-71ec997ad06so1336279b3a.3
        for <bpf@vger.kernel.org>; Thu, 07 Nov 2024 18:56:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731034582; x=1731639382; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yNbZ+YUGG/wRrI+cZkBggW2BYhjtWxWrv2xYyshGJP4=;
        b=hEJwDqGW7dMI9qUzX1MJGiGezx+LoRhJx3v5LIMxFjiCkhD002G+cY9SL5yAgJ12XD
         tZw8bEJIjyDz2j3GUskEMYP20s7bdK1pTBQF6xyh5eWFGwhr31zM9qvF2M8LwarxPU/z
         QyqTw+iW7s+R/Gd9vYqh9bs6oeQ6O2yRmeHxmIurbO4Fezjmvveirqfu61c7MHyGBGX6
         iZCda/iIGuIeZReOi84gZbmOUavP7HsP7gkiPdS7KQAi6k7GhHQ7+5nHvMxHnfn8fx/S
         SAoTUVlTgHaTbDaXJMHiw/G/hTdeGlbgScO1dKhb1ucugz6Ey+Yje5Kto19iV/Ko1dvM
         xycQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731034582; x=1731639382;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yNbZ+YUGG/wRrI+cZkBggW2BYhjtWxWrv2xYyshGJP4=;
        b=pSxNkgjWgAeyPuBo9Kcthm6AVcmgdo0BKamwEmWPlhi9mqQWIWpC5CBH6dD61FT/Fj
         Rr4buYRqB4+Sxju+vQs+0q6a5i0Gs/+Wnwg2QhyNHSNFg6j49xB8S01dLlMsOiZaStlG
         AwTvRmzsk/WycP7U7aOxJIF5kKLfjieC7gAwdKQ7SDHJWGlTp9KwQ/4InvAvyr089tjP
         73bp1vsJDovMAqnnq0ZKqbaBC1TNf4t2uIyukOqATyZ8cgUbwsuKlI5XFQt7+tozKXTc
         fOW0JGzSPjkySYsnwLyw0csP/HDQtBrPufWa2aFx5wrlcsVDMXROqOCu+Y7mR+NRDKT1
         Yfvw==
X-Gm-Message-State: AOJu0Yw3NzFzhYzGobAtF5JlxJjRqlUNiDigODSmM9eH7/nyKqdqYLac
	BZHnBotn4KY4gxtCwabfFXcBb8nXsArDe92djBahcgDxvkgIptfOYLFGCA==
X-Google-Smtp-Source: AGHT+IHn5U8eCIc/Hm6c/6Elsr2N7iUbVUHgKF5iW7agseCYrtOFV8kcnnZCGLdbb+tYGigS9USlaQ==
X-Received: by 2002:a05:6a00:3d55:b0:71e:658f:c43b with SMTP id d2e1a72fcca58-72413278edamr2059279b3a.2.1731034581981;
        Thu, 07 Nov 2024 18:56:21 -0800 (PST)
Received: from macbook-pro-49.lan ([2603:3023:16e:5000:1863:9460:a110:750b])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72407a19df2sm2520725b3a.153.2024.11.07.18.56.21
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 07 Nov 2024 18:56:21 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	memxor@gmail.com,
	eddyz87@gmail.com,
	djwong@kernel.org,
	kernel-team@fb.com
Subject: [PATCH bpf-next 1/2] bpf: Introduce range_tree data structure and use it in bpf arena
Date: Thu,  7 Nov 2024 18:56:15 -0800
Message-Id: <20241108025616.17625-2-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241108025616.17625-1-alexei.starovoitov@gmail.com>
References: <20241108025616.17625-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

Introduce range_tree data structure and use it in bpf arena to track
ranges of allocated pages. range_tree is a large bitmap that is
implemented as interval tree plus rbtree. The contiguous sequence of
bits represents unallocated pages.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/Makefile     |   2 +-
 kernel/bpf/arena.c      |  34 +++---
 kernel/bpf/range_tree.c | 262 ++++++++++++++++++++++++++++++++++++++++
 kernel/bpf/range_tree.h |  21 ++++
 4 files changed, 304 insertions(+), 15 deletions(-)
 create mode 100644 kernel/bpf/range_tree.c
 create mode 100644 kernel/bpf/range_tree.h

diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
index 105328f0b9c0..9762bdddf1de 100644
--- a/kernel/bpf/Makefile
+++ b/kernel/bpf/Makefile
@@ -16,7 +16,7 @@ obj-$(CONFIG_BPF_SYSCALL) += disasm.o mprog.o
 obj-$(CONFIG_BPF_JIT) += trampoline.o
 obj-$(CONFIG_BPF_SYSCALL) += btf.o memalloc.o
 ifeq ($(CONFIG_MMU)$(CONFIG_64BIT),yy)
-obj-$(CONFIG_BPF_SYSCALL) += arena.o
+obj-$(CONFIG_BPF_SYSCALL) += arena.o range_tree.o
 endif
 obj-$(CONFIG_BPF_JIT) += dispatcher.o
 ifeq ($(CONFIG_NET),y)
diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
index e52b3ad231b9..3e1dfe349ced 100644
--- a/kernel/bpf/arena.c
+++ b/kernel/bpf/arena.c
@@ -6,6 +6,7 @@
 #include <linux/btf_ids.h>
 #include <linux/vmalloc.h>
 #include <linux/pagemap.h>
+#include "range_tree.h"
 
 /*
  * bpf_arena is a sparsely populated shared memory region between bpf program and
@@ -45,7 +46,7 @@ struct bpf_arena {
 	u64 user_vm_start;
 	u64 user_vm_end;
 	struct vm_struct *kern_vm;
-	struct maple_tree mt;
+	struct range_tree rt;
 	struct list_head vma_list;
 	struct mutex lock;
 };
@@ -132,7 +133,8 @@ static struct bpf_map *arena_map_alloc(union bpf_attr *attr)
 
 	INIT_LIST_HEAD(&arena->vma_list);
 	bpf_map_init_from_attr(&arena->map, attr);
-	mt_init_flags(&arena->mt, MT_FLAGS_ALLOC_RANGE);
+	range_tree_init(&arena->rt);
+	range_tree_set(&arena->rt, 0, attr->max_entries);
 	mutex_init(&arena->lock);
 
 	return &arena->map;
@@ -183,7 +185,7 @@ static void arena_map_free(struct bpf_map *map)
 	apply_to_existing_page_range(&init_mm, bpf_arena_get_kern_vm_start(arena),
 				     KERN_VM_SZ - GUARD_SZ, existing_page_cb, NULL);
 	free_vm_area(arena->kern_vm);
-	mtree_destroy(&arena->mt);
+	range_tree_destroy(&arena->rt);
 	bpf_map_area_free(arena);
 }
 
@@ -274,20 +276,20 @@ static vm_fault_t arena_vm_fault(struct vm_fault *vmf)
 		/* User space requested to segfault when page is not allocated by bpf prog */
 		return VM_FAULT_SIGSEGV;
 
-	ret = mtree_insert(&arena->mt, vmf->pgoff, MT_ENTRY, GFP_KERNEL);
+	ret = range_tree_clear(&arena->rt, vmf->pgoff, 1);
 	if (ret)
 		return VM_FAULT_SIGSEGV;
 
 	/* Account into memcg of the process that created bpf_arena */
 	ret = bpf_map_alloc_pages(map, GFP_KERNEL | __GFP_ZERO, NUMA_NO_NODE, 1, &page);
 	if (ret) {
-		mtree_erase(&arena->mt, vmf->pgoff);
+		range_tree_set(&arena->rt, vmf->pgoff, 1);
 		return VM_FAULT_SIGSEGV;
 	}
 
 	ret = vm_area_map_pages(arena->kern_vm, kaddr, kaddr + PAGE_SIZE, &page);
 	if (ret) {
-		mtree_erase(&arena->mt, vmf->pgoff);
+		range_tree_set(&arena->rt, vmf->pgoff, 1);
 		__free_page(page);
 		return VM_FAULT_SIGSEGV;
 	}
@@ -444,12 +446,16 @@ static long arena_alloc_pages(struct bpf_arena *arena, long uaddr, long page_cnt
 
 	guard(mutex)(&arena->lock);
 
-	if (uaddr)
-		ret = mtree_insert_range(&arena->mt, pgoff, pgoff + page_cnt - 1,
-					 MT_ENTRY, GFP_KERNEL);
-	else
-		ret = mtree_alloc_range(&arena->mt, &pgoff, MT_ENTRY,
-					page_cnt, 0, page_cnt_max - 1, GFP_KERNEL);
+	if (uaddr) {
+		ret = is_range_tree_set(&arena->rt, pgoff, page_cnt);
+		if (ret)
+			goto out_free_pages;
+		ret = range_tree_clear(&arena->rt, pgoff, page_cnt);
+	} else {
+		ret = pgoff = range_tree_find(&arena->rt, page_cnt);
+		if (pgoff >= 0)
+			ret = range_tree_clear(&arena->rt, pgoff, page_cnt);
+	}
 	if (ret)
 		goto out_free_pages;
 
@@ -476,7 +482,7 @@ static long arena_alloc_pages(struct bpf_arena *arena, long uaddr, long page_cnt
 	kvfree(pages);
 	return clear_lo32(arena->user_vm_start) + uaddr32;
 out:
-	mtree_erase(&arena->mt, pgoff);
+	range_tree_set(&arena->rt, pgoff, page_cnt);
 out_free_pages:
 	kvfree(pages);
 	return 0;
@@ -516,7 +522,7 @@ static void arena_free_pages(struct bpf_arena *arena, long uaddr, long page_cnt)
 
 	pgoff = compute_pgoff(arena, uaddr);
 	/* clear range */
-	mtree_store_range(&arena->mt, pgoff, pgoff + page_cnt - 1, NULL, GFP_KERNEL);
+	range_tree_set(&arena->rt, pgoff, page_cnt);
 
 	if (page_cnt > 1)
 		/* bulk zap if multiple pages being freed */
diff --git a/kernel/bpf/range_tree.c b/kernel/bpf/range_tree.c
new file mode 100644
index 000000000000..ca92e1e4441b
--- /dev/null
+++ b/kernel/bpf/range_tree.c
@@ -0,0 +1,262 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
+#include <linux/interval_tree_generic.h>
+#include <linux/slab.h>
+#include <linux/bpf_mem_alloc.h>
+#include <linux/bpf.h>
+#include "range_tree.h"
+
+/*
+ * struct range_tree is a data structure used to allocate contiguous memory
+ * ranges in bpf arena. It's a large bitmap. The contiguous sequence of bits is
+ * represented by struct range_node or 'rn' for short.
+ * rn->rn_rbnode links it into an interval tree while
+ * rn->rb_range_size links it into a second rbtree sorted by size of the range.
+ * __find_range() performs binary search and best fit algorithm to find the
+ * range less or equal requested size.
+ * range_tree_clear/set() clears or sets a range of bits in this bitmap. The
+ * adjacent ranges are merged or split at the same time.
+ *
+ * The split/merge logic is based/borrowed from XFS's xbitmap32 added
+ * in commit 6772fcc8890a ("xfs: convert xbitmap to interval tree").
+ *
+ * The implementation relies on external lock to protect rbtree-s.
+ * The alloc/free of range_node-s is done via bpf_mem_alloc.
+ *
+ * bpf arena is using range_tree to representat unallocated slots.
+ * At init time:
+ *   range_tree_set(rt, 0, max);
+ * Then:
+ *   start = range_tree_find(rt, len);
+ *   if (start >= 0)
+ *     range_tree_clear(rt, start, len);
+ * to find free range and mark slots as allocated and later:
+ *   range_tree_set(rt, start, len);
+ * to mark as unallocated after use.
+ */
+struct range_node {
+	struct rb_node rn_rbnode;
+	struct rb_node rb_range_size;
+	u32 rn_start;
+	u32 rn_last; /* inclusive */
+	u32 __rn_subtree_last;
+};
+
+static struct range_node *rb_to_range_node(struct rb_node *rb)
+{
+	return rb_entry(rb, struct range_node, rb_range_size);
+}
+
+static u32 rn_size(struct range_node *rn)
+{
+	return rn->rn_last - rn->rn_start + 1;
+}
+
+/* Find range that fits best to requested size */
+static inline struct range_node *__find_range(struct range_tree *rt, u32 len)
+{
+	struct rb_node *rb = rt->range_size_root.rb_root.rb_node;
+	struct range_node *best = NULL;
+
+	while (rb) {
+		struct range_node *rn = rb_to_range_node(rb);
+
+		if (len <= rn_size(rn)) {
+			best = rn;
+			rb = rb->rb_right;
+		} else {
+			rb = rb->rb_left;
+		}
+	}
+
+	return best;
+}
+
+s64 range_tree_find(struct range_tree *rt, u32 len)
+{
+	struct range_node *rn;
+
+	rn = __find_range(rt, len);
+	if (!rn)
+		return -ENOENT;
+	return rn->rn_start;
+}
+
+/* Insert the range into rbtree sorted by the range size */
+static inline void __range_size_insert(struct range_node *rn,
+				       struct rb_root_cached *root)
+{
+	struct rb_node **link = &root->rb_root.rb_node, *rb = NULL;
+	u64 size = rn_size(rn);
+	bool leftmost = true;
+
+	while (*link) {
+		rb = *link;
+		if (size > rn_size(rb_to_range_node(rb))) {
+			link = &rb->rb_left;
+		} else {
+			link = &rb->rb_right;
+			leftmost = false;
+		}
+	}
+
+	rb_link_node(&rn->rb_range_size, rb, link);
+	rb_insert_color_cached(&rn->rb_range_size, root, leftmost);
+}
+
+#define START(node) ((node)->rn_start)
+#define LAST(node)  ((node)->rn_last)
+
+INTERVAL_TREE_DEFINE(struct range_node, rn_rbnode, u32,
+		     __rn_subtree_last, START, LAST,
+		     static inline __maybe_unused,
+		     __range_it)
+
+static inline __maybe_unused void
+range_it_insert(struct range_node *rn, struct range_tree *rt)
+{
+	__range_size_insert(rn, &rt->range_size_root);
+	__range_it_insert(rn, &rt->it_root);
+}
+
+static inline __maybe_unused void
+range_it_remove(struct range_node *rn, struct range_tree *rt)
+{
+	rb_erase_cached(&rn->rb_range_size, &rt->range_size_root);
+	RB_CLEAR_NODE(&rn->rb_range_size);
+	__range_it_remove(rn, &rt->it_root);
+}
+
+static inline __maybe_unused struct range_node *
+range_it_iter_first(struct range_tree *rt, u32 start, u32 last)
+{
+	return __range_it_iter_first(&rt->it_root, start, last);
+}
+
+/* Clear the range in this range tree */
+int range_tree_clear(struct range_tree *rt, u32 start, u32 len)
+{
+	u32 last = start + len - 1;
+	struct range_node *new_rn;
+	struct range_node *rn;
+
+	while ((rn = range_it_iter_first(rt, start, last))) {
+		if (rn->rn_start < start && rn->rn_last > last) {
+			u32 old_last = rn->rn_last;
+
+			/* Overlaps with the entire clearing range */
+			range_it_remove(rn, rt);
+			rn->rn_last = start - 1;
+			range_it_insert(rn, rt);
+
+			/* Add a range */
+			new_rn = bpf_mem_alloc(&bpf_global_ma, sizeof(struct range_node));
+			if (!new_rn)
+				return -ENOMEM;
+			new_rn->rn_start = last + 1;
+			new_rn->rn_last = old_last;
+			range_it_insert(new_rn, rt);
+		} else if (rn->rn_start < start) {
+			/* Overlaps with the left side of the clearing range */
+			range_it_remove(rn, rt);
+			rn->rn_last = start - 1;
+			range_it_insert(rn, rt);
+		} else if (rn->rn_last > last) {
+			/* Overlaps with the right side of the clearing range */
+			range_it_remove(rn, rt);
+			rn->rn_start = last + 1;
+			range_it_insert(rn, rt);
+			break;
+		} else {
+			/* in the middle of the clearing range */
+			range_it_remove(rn, rt);
+			bpf_mem_free(&bpf_global_ma, rn);
+		}
+	}
+	return 0;
+}
+
+/* Is the whole range set ? */
+int is_range_tree_set(struct range_tree *rt, u32 start, u32 len)
+{
+	u32 last = start + len - 1;
+	struct range_node *left;
+
+	/* Is this whole range set ? */
+	left = range_it_iter_first(rt, start, last);
+	if (left && left->rn_start <= start && left->rn_last >= last)
+		return 0;
+	return -ESRCH;
+}
+
+/* Set the range in this range tree */
+int range_tree_set(struct range_tree *rt, u32 start, u32 len)
+{
+	u32 last = start + len - 1;
+	struct range_node *right;
+	struct range_node *left;
+	int err;
+
+	/* Is this whole range already set ? */
+	left = range_it_iter_first(rt, start, last);
+	if (left && left->rn_start <= start && left->rn_last >= last)
+		return 0;
+
+	/* Clear out everything in the range we want to set. */
+	err = range_tree_clear(rt, start, len);
+	if (err)
+		return err;
+
+	/* Do we have a left-adjacent range ? */
+	left = range_it_iter_first(rt, start - 1, start - 1);
+	if (left && left->rn_last + 1 != start)
+		return -EFAULT;
+
+	/* Do we have a right-adjacent range ? */
+	right = range_it_iter_first(rt, last + 1, last + 1);
+	if (right && right->rn_start != last + 1)
+		return -EFAULT;
+
+	if (left && right) {
+		/* Combine left and right adjacent ranges */
+		range_it_remove(left, rt);
+		range_it_remove(right, rt);
+		left->rn_last = right->rn_last;
+		range_it_insert(left, rt);
+		bpf_mem_free(&bpf_global_ma, right);
+	} else if (left) {
+		/* Combine with the left range */
+		range_it_remove(left, rt);
+		left->rn_last = last;
+		range_it_insert(left, rt);
+	} else if (right) {
+		/* Combine with the right range */
+		range_it_remove(right, rt);
+		right->rn_start = start;
+		range_it_insert(right, rt);
+	} else {
+		left = bpf_mem_alloc(&bpf_global_ma, sizeof(struct range_node));
+		if (!left)
+			return -ENOMEM;
+		left->rn_start = start;
+		left->rn_last = last;
+		range_it_insert(left, rt);
+	}
+	return 0;
+}
+
+void range_tree_destroy(struct range_tree *rt)
+{
+	struct range_node *rn;
+
+	while ((rn = range_it_iter_first(rt, 0, -1U))) {
+		range_it_remove(rn, rt);
+		bpf_mem_free(&bpf_global_ma, rn);
+	}
+}
+
+void range_tree_init(struct range_tree *rt)
+{
+	rt->it_root = RB_ROOT_CACHED;
+	rt->range_size_root = RB_ROOT_CACHED;
+}
diff --git a/kernel/bpf/range_tree.h b/kernel/bpf/range_tree.h
new file mode 100644
index 000000000000..ff0b9110eb71
--- /dev/null
+++ b/kernel/bpf/range_tree.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
+#ifndef _RANGE_TREE_H
+#define _RANGE_TREE_H 1
+
+struct range_tree {
+	/* root of interval tree */
+	struct rb_root_cached it_root;
+	/* root of rbtree of interval sizes */
+	struct rb_root_cached range_size_root;
+};
+
+void range_tree_init(struct range_tree *rt);
+void range_tree_destroy(struct range_tree *rt);
+
+int range_tree_clear(struct range_tree *rt, u32 start, u32 len);
+int range_tree_set(struct range_tree *rt, u32 start, u32 len);
+int is_range_tree_set(struct range_tree *rt, u32 start, u32 len);
+s64 range_tree_find(struct range_tree *rt, u32 len);
+
+#endif
-- 
2.43.5


