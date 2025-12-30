Return-Path: <bpf+bounces-77524-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BFF5CEA116
	for <lists+bpf@lfdr.de>; Tue, 30 Dec 2025 16:31:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 356C93029B92
	for <lists+bpf@lfdr.de>; Tue, 30 Dec 2025 15:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8246330B53F;
	Tue, 30 Dec 2025 15:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uz1kdMc6"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA495238C2F
	for <bpf@vger.kernel.org>; Tue, 30 Dec 2025 15:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767108640; cv=none; b=Ykq5tMeCIUz0Je/0UcrbqJI7tK7WGq/l+/GvfgxkK1DXdqlMleUK+8Io8NlYxBOSGX0KRE6uZzm8Qg+agqZ5P7I/CDJeaDv7eD0k1ZFxgQ7zoLBm6m3lPm7ivzp468TWl2uEUhZaVQuLTmEqHL+ftWh1PAGeKGJ0paaLHmqca5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767108640; c=relaxed/simple;
	bh=b/1vh+3ciIfSrHp4P9RP0bqKY6EOwx/tuYv2dT7BzCQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R2EM3Jsyu+Za0AzjBi2GbXmlycsQxzHzVqWs9XZNR+Xn9KVBfiVrZqbiY2zdEDZRw3eaQZomfaGaxlolgtJ0VwEnsnPweZXZ327N9x2SMTV75fqUdlLkj4aNsMxwL3K9Zv0wWtwC1OEyADrbgWoiKG/7mq6pXcLxCXOc5Jr1CaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uz1kdMc6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F282C4CEFB;
	Tue, 30 Dec 2025 15:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767108639;
	bh=b/1vh+3ciIfSrHp4P9RP0bqKY6EOwx/tuYv2dT7BzCQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uz1kdMc62/yk6G/KC2HgvqFugBDUufJ2ybOEBqN7+AdzxnIm51Q79ZoEXu3tVEN+I
	 mPjUSWiFdNXS5VudotPKuTI5ms9TRHzfn82HRXDj/pBSd7/Vq3yXGhZ9POc4h4SQLv
	 W+7pLzBLzZou7RSrmv9MhauSeLJethRZWOhVEvNuwIsE0i6cUfZw42rZcnVQZE4owN
	 4ws4qQ1QL6T4zmeBq4kA4DjXMD4xHFckx2tWMnQifXz7M1hpt3Q8q9UuzsdXc35xdY
	 ojqL1Ov8TCSZYqoyhv2oa3RVnIH58dTLxhhib7wEzujbEgKDSRyil1/6yKRHyisb9y
	 zR3G1ra/4TjxA==
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
Subject: [PATCH bpf-next 2/2] bpf: arena: Reintroduce memcg accounting
Date: Tue, 30 Dec 2025 07:30:04 -0800
Message-ID: <20251230153006.1347742-3-puranjay@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251230153006.1347742-1-puranjay@kernel.org>
References: <20251230153006.1347742-1-puranjay@kernel.org>
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
 kernel/bpf/arena.c      | 39 ++++++++++++++++++++++++++++++++++-----
 kernel/bpf/range_tree.c |  5 +++--
 2 files changed, 37 insertions(+), 7 deletions(-)

diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
index 456ac989269d..cb9451208b0e 100644
--- a/kernel/bpf/arena.c
+++ b/kernel/bpf/arena.c
@@ -360,6 +360,7 @@ static vm_fault_t arena_vm_fault(struct vm_fault *vmf)
 {
 	struct bpf_map *map = vmf->vma->vm_file->private_data;
 	struct bpf_arena *arena = container_of(map, struct bpf_arena, map);
+	struct mem_cgroup *memcg, *old_memcg;
 	struct page *page;
 	long kbase, kaddr;
 	unsigned long flags;
@@ -377,6 +378,8 @@ static vm_fault_t arena_vm_fault(struct vm_fault *vmf)
 		/* already have a page vmap-ed */
 		goto out;
 
+	old_memcg = bpf_map_memcg_enter(map, &memcg);
+
 	if (arena->map.map_flags & BPF_F_SEGV_ON_FAULT)
 		/* User space requested to segfault when page is not allocated by bpf prog */
 		goto out_unlock_sigsegv;
@@ -400,12 +403,14 @@ static vm_fault_t arena_vm_fault(struct vm_fault *vmf)
 		goto out_unlock_sigsegv;
 	}
 	flush_vmap_cache(kaddr, PAGE_SIZE);
+	bpf_map_memcg_exit(old_memcg, memcg);
 out:
 	page_ref_add(page, 1);
 	raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
 	vmf->page = page;
 	return 0;
 out_unlock_sigsegv:
+	bpf_map_memcg_exit(old_memcg, memcg);
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
@@ -834,49 +839,69 @@ __bpf_kfunc_start_defs();
 __bpf_kfunc void *bpf_arena_alloc_pages(void *p__map, void *addr__ign, u32 page_cnt,
 					int node_id, u64 flags)
 {
+	void *ret;
 	struct bpf_map *map = p__map;
+	struct mem_cgroup *memcg, *old_memcg;
 	struct bpf_arena *arena = container_of(map, struct bpf_arena, map);
 
 	if (map->map_type != BPF_MAP_TYPE_ARENA || flags || !page_cnt)
 		return NULL;
 
-	return (void *)arena_alloc_pages(arena, (long)addr__ign, page_cnt, node_id, true);
+	old_memcg = bpf_map_memcg_enter(map, &memcg);
+	ret = (void *)arena_alloc_pages(arena, (long)addr__ign, page_cnt, node_id, true);
+	bpf_map_memcg_exit(old_memcg, memcg);
+
+	return ret;
 }
 
 void *bpf_arena_alloc_pages_non_sleepable(void *p__map, void *addr__ign, u32 page_cnt,
 					  int node_id, u64 flags)
 {
+	void *ret;
 	struct bpf_map *map = p__map;
+	struct mem_cgroup *memcg, *old_memcg;
 	struct bpf_arena *arena = container_of(map, struct bpf_arena, map);
 
 	if (map->map_type != BPF_MAP_TYPE_ARENA || flags || !page_cnt)
 		return NULL;
 
-	return (void *)arena_alloc_pages(arena, (long)addr__ign, page_cnt, node_id, false);
+	old_memcg = bpf_map_memcg_enter(map, &memcg);
+	ret = (void *)arena_alloc_pages(arena, (long)addr__ign, page_cnt, node_id, false);
+	bpf_map_memcg_exit(old_memcg, memcg);
+
+	return ret;
 }
 __bpf_kfunc void bpf_arena_free_pages(void *p__map, void *ptr__ign, u32 page_cnt)
 {
 	struct bpf_map *map = p__map;
+	struct mem_cgroup *memcg, *old_memcg;
 	struct bpf_arena *arena = container_of(map, struct bpf_arena, map);
 
 	if (map->map_type != BPF_MAP_TYPE_ARENA || !page_cnt || !ptr__ign)
 		return;
+	old_memcg = bpf_map_memcg_enter(map, &memcg);
 	arena_free_pages(arena, (long)ptr__ign, page_cnt, true);
+	bpf_map_memcg_exit(old_memcg, memcg);
 }
 
 void bpf_arena_free_pages_non_sleepable(void *p__map, void *ptr__ign, u32 page_cnt)
 {
 	struct bpf_map *map = p__map;
+	struct mem_cgroup *memcg, *old_memcg;
 	struct bpf_arena *arena = container_of(map, struct bpf_arena, map);
 
 	if (map->map_type != BPF_MAP_TYPE_ARENA || !page_cnt || !ptr__ign)
 		return;
+	old_memcg = bpf_map_memcg_enter(map, &memcg);
 	arena_free_pages(arena, (long)ptr__ign, page_cnt, false);
+	bpf_map_memcg_exit(old_memcg, memcg);
 }
 
 __bpf_kfunc int bpf_arena_reserve_pages(void *p__map, void *ptr__ign, u32 page_cnt)
 {
+	int ret;
 	struct bpf_map *map = p__map;
+	struct mem_cgroup *memcg, *old_memcg;
 	struct bpf_arena *arena = container_of(map, struct bpf_arena, map);
 
 	if (map->map_type != BPF_MAP_TYPE_ARENA)
@@ -885,7 +910,11 @@ __bpf_kfunc int bpf_arena_reserve_pages(void *p__map, void *ptr__ign, u32 page_c
 	if (!page_cnt)
 		return 0;
 
-	return arena_reserve_pages(arena, (long)ptr__ign, page_cnt);
+	old_memcg = bpf_map_memcg_enter(map, &memcg);
+	ret = arena_reserve_pages(arena, (long)ptr__ign, page_cnt);
+	bpf_map_memcg_exit(old_memcg, memcg);
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


