Return-Path: <bpf+bounces-77590-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 93BC5CEC11B
	for <lists+bpf@lfdr.de>; Wed, 31 Dec 2025 15:14:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BBAEF30145AE
	for <lists+bpf@lfdr.de>; Wed, 31 Dec 2025 14:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AE04243968;
	Wed, 31 Dec 2025 14:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SAyNngaz"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0185A23EAB3
	for <bpf@vger.kernel.org>; Wed, 31 Dec 2025 14:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767190490; cv=none; b=je3JxWpgQ9HcXwMnV7hO2MFYVF6mM9DH3EHU0HS7+QP4Kqyt3Hw+aefmONcrXB5m4XV7FnYr8Ac6M/vQeu7axeR/8bI+WOODylhieGRnWf1iQEUWQlT7N0fb9UvRWQ7tUeN/xHgUvL7FyPCgkACvhpoz0noIzg5OxI2zs3jMwCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767190490; c=relaxed/simple;
	bh=bylMTAVfbsx4ubZBw9aH7zeUoB59IUTBb4aFgUKtIoI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FCx4uvkjiBGLxy5vNgcOuxkP3CCdpT479ULksrGMBZvIZ/V4iRer2Iw1LGTFXDCiTTp7k0a2uoipsc/jgMUFdZc1UudqeJ9wKrvp3ccqodIISzi/vLvEhE8w3iZ5EQzyBQfsACdzUZTUoGkjSyeQ5KCOlVo+lpmcG9yOuWDVFKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SAyNngaz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C7D5C113D0;
	Wed, 31 Dec 2025 14:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767190489;
	bh=bylMTAVfbsx4ubZBw9aH7zeUoB59IUTBb4aFgUKtIoI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SAyNngazX8rXIKvdaPrjNSjfPq3/QseUZWfOIWGt2dXWalVLoKBxjaznGuOEAKep9
	 7JaeibdP+IlG4/v1As6hYwCvFrjcFRgvGg12CCoe4Ro89GG3iPdz0w//nE8wL1p5gP
	 +fc5c1HvEZPvX+rYw048pcDaGnppIiqlQk9k5EA+Ig0ohsf1NisMe2uiHlfiow3fRu
	 0qzbiFNsLg5wjZPrsj6963Ff0d/nHUaVJgjkF7RkPRnQkWGgETgr4LuM92jbnaheRZ
	 ZqLnQHn0qB+apvukl2yGhqx8PJiFGadId+z3sMs7sxNozYj1rbtBn18tHHHafvULLM
	 1KCLSBVEOB2Tg==
From: Puranjay Mohan <puranjay@kernel.org>
To: bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay@kernel.org>,
	Puranjay Mohan <puranjay12@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 2/2] bpf: arena: Reintroduce memcg accounting
Date: Wed, 31 Dec 2025 06:14:33 -0800
Message-ID: <20251231141434.3416822-3-puranjay@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251231141434.3416822-1-puranjay@kernel.org>
References: <20251231141434.3416822-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When arena allocations were converted from bpf_map_alloc_pages() to
kmalloc_nolock() to support non-sleepable contexts, memcg accounting was
inadvertently lost. This commit restores proper memory accounting for
all arena-related allocations.

All arena related allocations are accounted into memcg of the process
that created bpf_arena.

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 kernel/bpf/arena.c      | 44 ++++++++++++++++++++++++++++++++++++-----
 kernel/bpf/range_tree.c |  5 +++--
 2 files changed, 42 insertions(+), 7 deletions(-)

diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
index 456ac989269d..45b55961683f 100644
--- a/kernel/bpf/arena.c
+++ b/kernel/bpf/arena.c
@@ -360,6 +360,7 @@ static vm_fault_t arena_vm_fault(struct vm_fault *vmf)
 {
 	struct bpf_map *map = vmf->vma->vm_file->private_data;
 	struct bpf_arena *arena = container_of(map, struct bpf_arena, map);
+	struct mem_cgroup *new_memcg, *old_memcg;
 	struct page *page;
 	long kbase, kaddr;
 	unsigned long flags;
@@ -377,6 +378,8 @@ static vm_fault_t arena_vm_fault(struct vm_fault *vmf)
 		/* already have a page vmap-ed */
 		goto out;
 
+	bpf_map_memcg_enter(map, &old_memcg, &new_memcg);
+
 	if (arena->map.map_flags & BPF_F_SEGV_ON_FAULT)
 		/* User space requested to segfault when page is not allocated by bpf prog */
 		goto out_unlock_sigsegv;
@@ -400,12 +403,14 @@ static vm_fault_t arena_vm_fault(struct vm_fault *vmf)
 		goto out_unlock_sigsegv;
 	}
 	flush_vmap_cache(kaddr, PAGE_SIZE);
+	bpf_map_memcg_exit(old_memcg, new_memcg);
 out:
 	page_ref_add(page, 1);
 	raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
 	vmf->page = page;
 	return 0;
 out_unlock_sigsegv:
+	bpf_map_memcg_exit(old_memcg, new_memcg);
 	raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
 	return VM_FAULT_SIGSEGV;
 }
@@ -557,7 +562,7 @@ static long arena_alloc_pages(struct bpf_arena *arena, long uaddr, long page_cnt
 
 	/* Cap allocation size to KMALLOC_MAX_CACHE_SIZE so kmalloc_nolock() can succeed. */
 	alloc_pages = min(page_cnt, KMALLOC_MAX_CACHE_SIZE / sizeof(struct page *));
-	pages = kmalloc_nolock(alloc_pages * sizeof(struct page *), 0, NUMA_NO_NODE);
+	pages = kmalloc_nolock(alloc_pages * sizeof(struct page *), __GFP_ACCOUNT, NUMA_NO_NODE);
 	if (!pages)
 		return 0;
 	data.pages = pages;
@@ -713,7 +718,7 @@ static void arena_free_pages(struct bpf_arena *arena, long uaddr, long page_cnt,
 	return;
 
 defer:
-	s = kmalloc_nolock(sizeof(struct arena_free_span), 0, -1);
+	s = kmalloc_nolock(sizeof(struct arena_free_span), __GFP_ACCOUNT, -1);
 	if (!s)
 		/*
 		 * If allocation fails in non-sleepable context, pages are intentionally left
@@ -766,6 +771,7 @@ static int arena_reserve_pages(struct bpf_arena *arena, long uaddr, u32 page_cnt
 static void arena_free_worker(struct work_struct *work)
 {
 	struct bpf_arena *arena = container_of(work, struct bpf_arena, free_work);
+	struct mem_cgroup *new_memcg, *old_memcg;
 	struct llist_node *list, *pos, *t;
 	struct arena_free_span *s;
 	u64 arena_vm_start, user_vm_start;
@@ -780,6 +786,8 @@ static void arena_free_worker(struct work_struct *work)
 		return;
 	}
 
+	bpf_map_memcg_enter(&arena->map, &old_memcg, &new_memcg);
+
 	init_llist_head(&free_pages);
 	arena_vm_start = bpf_arena_get_kern_vm_start(arena);
 	user_vm_start = bpf_arena_get_user_vm_start(arena);
@@ -820,6 +828,8 @@ static void arena_free_worker(struct work_struct *work)
 		page = llist_entry(pos, struct page, pcp_llist);
 		__free_page(page);
 	}
+
+	bpf_map_memcg_exit(old_memcg, new_memcg);
 }
 
 static void arena_free_irq(struct irq_work *iw)
@@ -834,49 +844,69 @@ __bpf_kfunc_start_defs();
 __bpf_kfunc void *bpf_arena_alloc_pages(void *p__map, void *addr__ign, u32 page_cnt,
 					int node_id, u64 flags)
 {
+	void *ret;
 	struct bpf_map *map = p__map;
+	struct mem_cgroup *new_memcg, *old_memcg;
 	struct bpf_arena *arena = container_of(map, struct bpf_arena, map);
 
 	if (map->map_type != BPF_MAP_TYPE_ARENA || flags || !page_cnt)
 		return NULL;
 
-	return (void *)arena_alloc_pages(arena, (long)addr__ign, page_cnt, node_id, true);
+	bpf_map_memcg_enter(map, &old_memcg, &new_memcg);
+	ret = (void *)arena_alloc_pages(arena, (long)addr__ign, page_cnt, node_id, true);
+	bpf_map_memcg_exit(old_memcg, new_memcg);
+
+	return ret;
 }
 
 void *bpf_arena_alloc_pages_non_sleepable(void *p__map, void *addr__ign, u32 page_cnt,
 					  int node_id, u64 flags)
 {
+	void *ret;
 	struct bpf_map *map = p__map;
+	struct mem_cgroup *new_memcg, *old_memcg;
 	struct bpf_arena *arena = container_of(map, struct bpf_arena, map);
 
 	if (map->map_type != BPF_MAP_TYPE_ARENA || flags || !page_cnt)
 		return NULL;
 
-	return (void *)arena_alloc_pages(arena, (long)addr__ign, page_cnt, node_id, false);
+	bpf_map_memcg_enter(map, &old_memcg, &new_memcg);
+	ret = (void *)arena_alloc_pages(arena, (long)addr__ign, page_cnt, node_id, false);
+	bpf_map_memcg_exit(old_memcg, new_memcg);
+
+	return ret;
 }
 __bpf_kfunc void bpf_arena_free_pages(void *p__map, void *ptr__ign, u32 page_cnt)
 {
 	struct bpf_map *map = p__map;
+	struct mem_cgroup *new_memcg, *old_memcg;
 	struct bpf_arena *arena = container_of(map, struct bpf_arena, map);
 
 	if (map->map_type != BPF_MAP_TYPE_ARENA || !page_cnt || !ptr__ign)
 		return;
+	bpf_map_memcg_enter(map, &old_memcg, &new_memcg);
 	arena_free_pages(arena, (long)ptr__ign, page_cnt, true);
+	bpf_map_memcg_exit(old_memcg, new_memcg);
 }
 
 void bpf_arena_free_pages_non_sleepable(void *p__map, void *ptr__ign, u32 page_cnt)
 {
 	struct bpf_map *map = p__map;
+	struct mem_cgroup *new_memcg, *old_memcg;
 	struct bpf_arena *arena = container_of(map, struct bpf_arena, map);
 
 	if (map->map_type != BPF_MAP_TYPE_ARENA || !page_cnt || !ptr__ign)
 		return;
+	bpf_map_memcg_enter(map, &old_memcg, &new_memcg);
 	arena_free_pages(arena, (long)ptr__ign, page_cnt, false);
+	bpf_map_memcg_exit(old_memcg, new_memcg);
 }
 
 __bpf_kfunc int bpf_arena_reserve_pages(void *p__map, void *ptr__ign, u32 page_cnt)
 {
+	int ret;
 	struct bpf_map *map = p__map;
+	struct mem_cgroup *new_memcg, *old_memcg;
 	struct bpf_arena *arena = container_of(map, struct bpf_arena, map);
 
 	if (map->map_type != BPF_MAP_TYPE_ARENA)
@@ -885,7 +915,11 @@ __bpf_kfunc int bpf_arena_reserve_pages(void *p__map, void *ptr__ign, u32 page_c
 	if (!page_cnt)
 		return 0;
 
-	return arena_reserve_pages(arena, (long)ptr__ign, page_cnt);
+	bpf_map_memcg_enter(map, &old_memcg, &new_memcg);
+	ret = arena_reserve_pages(arena, (long)ptr__ign, page_cnt);
+	bpf_map_memcg_exit(old_memcg, new_memcg);
+
+	return ret;
 }
 __bpf_kfunc_end_defs();
 
diff --git a/kernel/bpf/range_tree.c b/kernel/bpf/range_tree.c
index 99c63d982c5d..2f28886f3ff7 100644
--- a/kernel/bpf/range_tree.c
+++ b/kernel/bpf/range_tree.c
@@ -149,7 +149,8 @@ int range_tree_clear(struct range_tree *rt, u32 start, u32 len)
 			range_it_insert(rn, rt);
 
 			/* Add a range */
-			new_rn = kmalloc_nolock(sizeof(struct range_node), 0, NUMA_NO_NODE);
+			new_rn = kmalloc_nolock(sizeof(struct range_node), __GFP_ACCOUNT,
+						NUMA_NO_NODE);
 			if (!new_rn)
 				return -ENOMEM;
 			new_rn->rn_start = last + 1;
@@ -234,7 +235,7 @@ int range_tree_set(struct range_tree *rt, u32 start, u32 len)
 		right->rn_start = start;
 		range_it_insert(right, rt);
 	} else {
-		left = kmalloc_nolock(sizeof(struct range_node), 0, NUMA_NO_NODE);
+		left = kmalloc_nolock(sizeof(struct range_node), __GFP_ACCOUNT, NUMA_NO_NODE);
 		if (!left)
 			return -ENOMEM;
 		left->rn_start = start;
-- 
2.47.3


