Return-Path: <bpf+bounces-77713-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 61888CEF418
	for <lists+bpf@lfdr.de>; Fri, 02 Jan 2026 21:02:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F2DA6300F735
	for <lists+bpf@lfdr.de>; Fri,  2 Jan 2026 20:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42D6727F015;
	Fri,  2 Jan 2026 20:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HeOnNhGz"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D3025783C
	for <bpf@vger.kernel.org>; Fri,  2 Jan 2026 20:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767384172; cv=none; b=aCg056cxn9+3Y88+VeZt+7GVLm37hvv4HWNufwfJV/N/s25TBUEmNt6vpmEMOxlwh7ACDa+1wUWnwbWM8tHZOiI4f7iEIkETR2SnfGYCy6DCT2vCrMG8eRJwM+QUUVsz4AdLqYDCvja6zyanl/7iDmhz1YeMkGlWnulnsTyguHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767384172; c=relaxed/simple;
	bh=1sGK0ohpbuXpYn4YqG4nBYP280GHO8e37ievCZOj67g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KKGFD7U/msLlctKt0wbeGz8XzbEuHxKJ6EG0IliRENdXj+VPiVzMJmTgNeXmemynBoftXhAE+XkBUWEKCLEEb9crJWumkGXRRKUWKLKoSK8vxgbexPee1eBuDvp3NUKX178T+9agrvqhIA+uI0Iyyw9TbckshXf+BUyzJ8auQA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HeOnNhGz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EB4CC116B1;
	Fri,  2 Jan 2026 20:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767384172;
	bh=1sGK0ohpbuXpYn4YqG4nBYP280GHO8e37ievCZOj67g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HeOnNhGzAaItd3hdPY158hylO3lSfxGYhW+XiwpHEO0ApiFDJGxEHT564qMSHeXe1
	 f/Shv4mvMkzNTDVI1WBi+yz3P9DCRbkp93tKtpj6XKRAAK8kJSFiXf7TEGQg9PyB83
	 2uG0a6yLT1bT3mmL3MM2jUhSjyMNPQpMbGngtCKhr3hKhG72KTWSG3oqS5weBJMvcG
	 eK25yYDdjdm8yMDD781Ez9lIqkIctuiFISVrXmZojQxcaj73rR6KM/FU2U/Uju8Zcn
	 RyfSMQKgWDuzK2vtF2+zY53StC7EECTuq35AfqR93lgj2Vx6m9XWevnsVy9qd7hVMw
	 zs7LRyee0/6Tg==
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
Subject: [PATCH bpf-next v5 2/2] bpf: arena: Reintroduce memcg accounting
Date: Fri,  2 Jan 2026 12:02:28 -0800
Message-ID: <20260102200230.25168-3-puranjay@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260102200230.25168-1-puranjay@kernel.org>
References: <20260102200230.25168-1-puranjay@kernel.org>
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
 kernel/bpf/arena.c      | 29 ++++++++++++++++++++++++++---
 kernel/bpf/range_tree.c |  5 +++--
 kernel/bpf/syscall.c    |  3 ---
 3 files changed, 29 insertions(+), 8 deletions(-)

diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
index 456ac989269d..b437a2c98218 100644
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
 
+	bpf_map_memcg_enter(&arena->map, &old_memcg, &new_memcg);
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
@@ -534,6 +539,7 @@ static long arena_alloc_pages(struct bpf_arena *arena, long uaddr, long page_cnt
 	/* user_vm_end/start are fixed before bpf prog runs */
 	long page_cnt_max = (arena->user_vm_end - arena->user_vm_start) >> PAGE_SHIFT;
 	u64 kern_vm_start = bpf_arena_get_kern_vm_start(arena);
+	struct mem_cgroup *new_memcg, *old_memcg;
 	struct apply_range_data data;
 	struct page **pages = NULL;
 	long remaining, mapped = 0;
@@ -555,11 +561,14 @@ static long arena_alloc_pages(struct bpf_arena *arena, long uaddr, long page_cnt
 			return 0;
 	}
 
+	bpf_map_memcg_enter(&arena->map, &old_memcg, &new_memcg);
 	/* Cap allocation size to KMALLOC_MAX_CACHE_SIZE so kmalloc_nolock() can succeed. */
 	alloc_pages = min(page_cnt, KMALLOC_MAX_CACHE_SIZE / sizeof(struct page *));
-	pages = kmalloc_nolock(alloc_pages * sizeof(struct page *), 0, NUMA_NO_NODE);
-	if (!pages)
+	pages = kmalloc_nolock(alloc_pages * sizeof(struct page *), __GFP_ACCOUNT, NUMA_NO_NODE);
+	if (!pages) {
+		bpf_map_memcg_exit(old_memcg, new_memcg);
 		return 0;
+	}
 	data.pages = pages;
 
 	if (raw_res_spin_lock_irqsave(&arena->spinlock, flags))
@@ -617,6 +626,7 @@ static long arena_alloc_pages(struct bpf_arena *arena, long uaddr, long page_cnt
 	flush_vmap_cache(kern_vm_start + uaddr32, mapped << PAGE_SHIFT);
 	raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
 	kfree_nolock(pages);
+	bpf_map_memcg_exit(old_memcg, new_memcg);
 	return clear_lo32(arena->user_vm_start) + uaddr32;
 out:
 	range_tree_set(&arena->rt, pgoff + mapped, page_cnt - mapped);
@@ -630,6 +640,7 @@ static long arena_alloc_pages(struct bpf_arena *arena, long uaddr, long page_cnt
 	raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
 out_free_pages:
 	kfree_nolock(pages);
+	bpf_map_memcg_exit(old_memcg, new_memcg);
 	return 0;
 }
 
@@ -651,6 +662,7 @@ static void zap_pages(struct bpf_arena *arena, long uaddr, long page_cnt)
 
 static void arena_free_pages(struct bpf_arena *arena, long uaddr, long page_cnt, bool sleepable)
 {
+	struct mem_cgroup *new_memcg, *old_memcg;
 	u64 full_uaddr, uaddr_end;
 	long kaddr, pgoff;
 	struct page *page;
@@ -671,6 +683,7 @@ static void arena_free_pages(struct bpf_arena *arena, long uaddr, long page_cnt,
 
 	page_cnt = (uaddr_end - full_uaddr) >> PAGE_SHIFT;
 	pgoff = compute_pgoff(arena, uaddr);
+	bpf_map_memcg_enter(&arena->map, &old_memcg, &new_memcg);
 
 	if (!sleepable)
 		goto defer;
@@ -709,11 +722,13 @@ static void arena_free_pages(struct bpf_arena *arena, long uaddr, long page_cnt,
 			zap_pages(arena, full_uaddr, 1);
 		__free_page(page);
 	}
+	bpf_map_memcg_exit(old_memcg, new_memcg);
 
 	return;
 
 defer:
-	s = kmalloc_nolock(sizeof(struct arena_free_span), 0, -1);
+	s = kmalloc_nolock(sizeof(struct arena_free_span), __GFP_ACCOUNT, -1);
+	bpf_map_memcg_exit(old_memcg, new_memcg);
 	if (!s)
 		/*
 		 * If allocation fails in non-sleepable context, pages are intentionally left
@@ -735,6 +750,7 @@ static void arena_free_pages(struct bpf_arena *arena, long uaddr, long page_cnt,
 static int arena_reserve_pages(struct bpf_arena *arena, long uaddr, u32 page_cnt)
 {
 	long page_cnt_max = (arena->user_vm_end - arena->user_vm_start) >> PAGE_SHIFT;
+	struct mem_cgroup *new_memcg, *old_memcg;
 	unsigned long flags;
 	long pgoff;
 	int ret;
@@ -757,7 +773,9 @@ static int arena_reserve_pages(struct bpf_arena *arena, long uaddr, u32 page_cnt
 	}
 
 	/* "Allocate" the region to prevent it from being allocated. */
+	bpf_map_memcg_enter(&arena->map, &old_memcg, &new_memcg);
 	ret = range_tree_clear(&arena->rt, pgoff, page_cnt);
+	bpf_map_memcg_exit(old_memcg, new_memcg);
 out:
 	raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
 	return ret;
@@ -766,6 +784,7 @@ static int arena_reserve_pages(struct bpf_arena *arena, long uaddr, u32 page_cnt
 static void arena_free_worker(struct work_struct *work)
 {
 	struct bpf_arena *arena = container_of(work, struct bpf_arena, free_work);
+	struct mem_cgroup *new_memcg, *old_memcg;
 	struct llist_node *list, *pos, *t;
 	struct arena_free_span *s;
 	u64 arena_vm_start, user_vm_start;
@@ -780,6 +799,8 @@ static void arena_free_worker(struct work_struct *work)
 		return;
 	}
 
+	bpf_map_memcg_enter(&arena->map, &old_memcg, &new_memcg);
+
 	init_llist_head(&free_pages);
 	arena_vm_start = bpf_arena_get_kern_vm_start(arena);
 	user_vm_start = bpf_arena_get_user_vm_start(arena);
@@ -820,6 +841,8 @@ static void arena_free_worker(struct work_struct *work)
 		page = llist_entry(pos, struct page, pcp_llist);
 		__free_page(page);
 	}
+
+	bpf_map_memcg_exit(old_memcg, new_memcg);
 }
 
 static void arena_free_irq(struct irq_work *iw)
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
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index c77ab2e32659..6dd2ad2f9e81 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -616,9 +616,7 @@ int bpf_map_alloc_pages(const struct bpf_map *map, int nid,
 	unsigned long i, j;
 	struct page *pg;
 	int ret = 0;
-	struct mem_cgroup *memcg, *old_memcg;
 
-	bpf_map_memcg_enter(map, &old_memcg, &memcg);
 	for (i = 0; i < nr_pages; i++) {
 		pg = __bpf_alloc_page(nid);
 
@@ -632,7 +630,6 @@ int bpf_map_alloc_pages(const struct bpf_map *map, int nid,
 		break;
 	}
 
-	bpf_map_memcg_exit(old_memcg, memcg);
 	return ret;
 }
 
-- 
2.47.3


