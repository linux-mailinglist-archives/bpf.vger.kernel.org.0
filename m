Return-Path: <bpf+bounces-74751-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E4E5C6509D
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 17:06:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 29B9723F82
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 16:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D950C2C21C1;
	Mon, 17 Nov 2025 16:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WyU1m2fi"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6096C27467B
	for <bpf@vger.kernel.org>; Mon, 17 Nov 2025 16:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763395593; cv=none; b=DJmykfGGTVZDxp22JtTPSw00klCGOQlrRucC9B8lqW1WQyWgarJpv6xVLcNuAiflVEcOiDWTsnOVJUPtrP5p4fwYZt2bH3loZmttPH31wR77BZMyP5dR8PodpR5VvPyzE88E1SusKJDA+ynFQVEajdwp56jMC5JjleMyFhzNqKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763395593; c=relaxed/simple;
	bh=5AIPoeu6iV87Z6uvwX7FPcRNd+gPK7b70kPL6Allil4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ipBxYtWGnkAUf5ij61KHkHEDxY8q5Bb7afW81E5SjfFNM+rN8qZIwtFpVQWaiwecJzXXrDZPovvZ5xIT27M9Pr/YOpV4za1qIbKyunxFVXT1jh4XiVFBZS+LurMwfUcJM8HIVguDcQWwh4qoJhVq2cMo5d83wvOgNRIXplpInZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WyU1m2fi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1563C19421;
	Mon, 17 Nov 2025 16:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763395592;
	bh=5AIPoeu6iV87Z6uvwX7FPcRNd+gPK7b70kPL6Allil4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WyU1m2fiAOm0a8HccuMfFtEn/Q0RXVZ4AE4xX/p+k1zLZ2r/waWDXi7PswJd9MYNd
	 PxdMuMuFNFKgPZE5bTgc63vlBVetZ+Qb6xxFlx8mpKH/+kWkTRHrCQhYt8SLQDejJH
	 /LRJZXX94rYZd3XtLKlFCpOyp1bZeANg6nVHtFE+FCY59bWpwpS3WbhPa1CS93oMD4
	 UWLpUp3bjLO+ZjHJ6MSDVcvJsmEBGNTvsCnsGlMu00VuLDr1pBuDLbJWIiXFMNnxs+
	 fPUbzppqZEJNisx2yUezibFK02oYVKHiYutgverMF28vmOasmF68Ai067yWjrLIEvU
	 ihmj39LwCoZmg==
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
Subject: [PATCH bpf-next v3 3/4] bpf: arena: make arena kfuncs any context safe
Date: Mon, 17 Nov 2025 16:06:16 +0000
Message-ID: <20251117160617.4604-2-puranjay@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251117160617.4604-1-puranjay@kernel.org>
References: <20251117160150.62183-1-puranjay@kernel.org>
 <20251117160617.4604-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make arena related kfuncs any context safe by the following changes:

bpf_arena_alloc_pages() and bpf_arena_reserve_pages():
Replace the usage of the mutex with a rqspinlock for range tree and use
kmalloc_nolock() wherever needed. Use free_pages_nolock() to free pages
from any context.
apply_range_set/clear_cb() with apply_to_page_range() has already made
populating the vm_area in bpf_arena_alloc_pages() any context safe.

bpf_arena_free_pages(): defer the main logic to a workqueue if it is
called from a non-sleepable context.

specialize_kfunc() is used to replace the sleepable arena_free_pages()
with bpf_arena_free_pages_non_sleepable() when the verifier detects the
call is from a non-sleepable context.

In the non-sleepable case, arena_free_pages() queues the address and the
page count to be freed to a lock-less list of struct arena_free_spans
and raises an irq_work. The irq_work handler calls schedules_work() as
it is safe to be called from irq context.  arena_free_worker() (the work
queue handler) iterates these spans and clears ptes, flushes tlb, zaps
pages, and calls __free_page().

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 include/linux/bpf.h   |  15 +++
 kernel/bpf/arena.c    | 249 +++++++++++++++++++++++++++++++++++-------
 kernel/bpf/verifier.c |  10 ++
 3 files changed, 233 insertions(+), 41 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 09d5dc541d1c..8339b3bd8295 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -673,6 +673,21 @@ void bpf_map_free_internal_structs(struct bpf_map *map, void *obj);
 int bpf_dynptr_from_file_sleepable(struct file *file, u32 flags,
 				   struct bpf_dynptr *ptr__uninit);
 
+#if defined(CONFIG_MMU) && defined(CONFIG_64BIT)
+void *bpf_arena_alloc_pages_non_sleepable(void *p__map, void *addr__ign, u32 page_cnt, int node_id,
+					  u64 flags);
+void bpf_arena_free_pages_non_sleepable(void *p__map, void *ptr__ign, u32 page_cnt);
+#else
+static inline void *bpf_arena_alloc_pages_non_sleepable(void *p__map, void *addr__ign, u32 page_cnt,
+							int node_id, u64 flags)
+{
+}
+
+static inline void bpf_arena_free_pages_non_sleepable(void *p__map, void *ptr__ign, u32 page_cnt)
+{
+}
+#endif
+
 extern const struct bpf_map_ops bpf_map_offload_ops;
 
 /* bpf_type_flag contains a set of flags that are applicable to the values of
diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
index 1d0b49a39ad0..8134d907b8e2 100644
--- a/kernel/bpf/arena.c
+++ b/kernel/bpf/arena.c
@@ -3,7 +3,9 @@
 #include <linux/bpf.h>
 #include <linux/btf.h>
 #include <linux/err.h>
+#include <linux/irq_work.h>
 #include "linux/filter.h"
+#include <linux/llist.h>
 #include <linux/btf_ids.h>
 #include <linux/vmalloc.h>
 #include <linux/pagemap.h>
@@ -43,7 +45,7 @@
 #define GUARD_SZ round_up(1ull << sizeof_field(struct bpf_insn, off) * 8, PAGE_SIZE << 1)
 #define KERN_VM_SZ (SZ_4G + GUARD_SZ)
 
-static void arena_free_pages(struct bpf_arena *arena, long uaddr, long page_cnt);
+static void arena_free_pages(struct bpf_arena *arena, long uaddr, long page_cnt, bool sleepable);
 
 struct bpf_arena {
 	struct bpf_map map;
@@ -51,8 +53,23 @@ struct bpf_arena {
 	u64 user_vm_end;
 	struct vm_struct *kern_vm;
 	struct range_tree rt;
+	/* protects rt */
+	rqspinlock_t spinlock;
 	struct list_head vma_list;
+	/* protects vma_list */
 	struct mutex lock;
+	struct irq_work     free_irq;
+	struct work_struct  free_work;
+	struct llist_head   free_spans;
+};
+
+static void arena_free_worker(struct work_struct *work);
+static void arena_free_irq(struct irq_work *iw);
+
+struct arena_free_span {
+	struct llist_node node;
+	unsigned long uaddr;
+	u32 page_cnt;
 };
 
 u64 bpf_arena_get_kern_vm_start(struct bpf_arena *arena)
@@ -120,7 +137,7 @@ static int apply_range_set_cb(pte_t *pte, unsigned long addr, void *data)
 	return 0;
 }
 
-static int apply_range_clear_cb(pte_t *pte, unsigned long addr, void *data)
+static int apply_range_clear_cb(pte_t *pte, unsigned long addr, void *free_pages)
 {
 	pte_t old_pte;
 	struct page *page;
@@ -130,17 +147,16 @@ static int apply_range_clear_cb(pte_t *pte, unsigned long addr, void *data)
 	if (pte_none(old_pte) || !pte_present(old_pte))
 		return 0; /* nothing to do */
 
-	/* get page and free it */
+	/* get page and clear pte */
 	page = pte_page(old_pte);
 	if (WARN_ON_ONCE(!page))
 		return -EINVAL;
 
 	pte_clear(&init_mm, addr, pte);
 
-	/* ensure no stale TLB entries */
-	flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
-
-	__free_page(page);
+	/* Add page to the list so it is freed later */
+	if (free_pages)
+		__llist_add(&page->pcp_llist, free_pages);
 
 	return 0;
 }
@@ -195,6 +211,9 @@ static struct bpf_map *arena_map_alloc(union bpf_attr *attr)
 		arena->user_vm_end = arena->user_vm_start + vm_range;
 
 	INIT_LIST_HEAD(&arena->vma_list);
+	init_llist_head(&arena->free_spans);
+	init_irq_work(&arena->free_irq, arena_free_irq);
+	INIT_WORK(&arena->free_work, arena_free_worker);
 	bpf_map_init_from_attr(&arena->map, attr);
 	range_tree_init(&arena->rt);
 	err = range_tree_set(&arena->rt, 0, attr->max_entries);
@@ -203,6 +222,7 @@ static struct bpf_map *arena_map_alloc(union bpf_attr *attr)
 		goto err;
 	}
 	mutex_init(&arena->lock);
+	raw_res_spin_lock_init(&arena->spinlock);
 	err = populate_pgtable_except_pte(arena);
 	if (err) {
 		range_tree_destroy(&arena->rt);
@@ -249,6 +269,10 @@ static void arena_map_free(struct bpf_map *map)
 	if (WARN_ON_ONCE(!list_empty(&arena->vma_list)))
 		return;
 
+	/* Ensure no pending deferred frees */
+	irq_work_sync(&arena->free_irq);
+	flush_work(&arena->free_work);
+
 	/*
 	 * free_vm_area() calls remove_vm_area() that calls free_unmap_vmap_area().
 	 * It unmaps everything from vmalloc area and clears pgtables.
@@ -332,12 +356,19 @@ static vm_fault_t arena_vm_fault(struct vm_fault *vmf)
 	struct bpf_arena *arena = container_of(map, struct bpf_arena, map);
 	struct page *page;
 	long kbase, kaddr;
+	unsigned long flags;
 	int ret;
 
 	kbase = bpf_arena_get_kern_vm_start(arena);
 	kaddr = kbase + (u32)(vmf->address);
 
-	guard(mutex)(&arena->lock);
+	if (raw_res_spin_lock_irqsave(&arena->spinlock, flags))
+		/*
+		 * This is an impossible case and would only trigger if res_spin_lock is buggy or
+		 * due to another kernel bug.
+		 */
+		return VM_FAULT_RETRY;
+
 	page = vmalloc_to_page((void *)kaddr);
 	if (page)
 		/* already have a page vmap-ed */
@@ -345,30 +376,34 @@ static vm_fault_t arena_vm_fault(struct vm_fault *vmf)
 
 	if (arena->map.map_flags & BPF_F_SEGV_ON_FAULT)
 		/* User space requested to segfault when page is not allocated by bpf prog */
-		return VM_FAULT_SIGSEGV;
+		goto out_unlock_sigsegv;
 
 	ret = range_tree_clear(&arena->rt, vmf->pgoff, 1);
 	if (ret)
-		return VM_FAULT_SIGSEGV;
+		goto out_unlock_sigsegv;
 
 	struct apply_range_data data = { .pages = &page, .i = 0 };
 	/* Account into memcg of the process that created bpf_arena */
 	ret = bpf_map_alloc_pages(map, NUMA_NO_NODE, 1, &page);
 	if (ret) {
 		range_tree_set(&arena->rt, vmf->pgoff, 1);
-		return VM_FAULT_SIGSEGV;
+		goto out_unlock_sigsegv;
 	}
 
 	ret = apply_to_page_range(&init_mm, kaddr, PAGE_SIZE, apply_range_set_cb, &data);
 	if (ret) {
 		range_tree_set(&arena->rt, vmf->pgoff, 1);
-		__free_page(page);
-		return VM_FAULT_SIGSEGV;
+		free_pages_nolock(page, 0);
+		goto out_unlock_sigsegv;
 	}
 out:
 	page_ref_add(page, 1);
+	raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
 	vmf->page = page;
 	return 0;
+out_unlock_sigsegv:
+	raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
+	return VM_FAULT_SIGSEGV;
 }
 
 static const struct vm_operations_struct arena_vm_ops = {
@@ -489,7 +524,8 @@ static u64 clear_lo32(u64 val)
  * Allocate pages and vmap them into kernel vmalloc area.
  * Later the pages will be mmaped into user space vma.
  */
-static long arena_alloc_pages(struct bpf_arena *arena, long uaddr, long page_cnt, int node_id)
+static long arena_alloc_pages(struct bpf_arena *arena, long uaddr, long page_cnt, int node_id,
+			      bool sleepable)
 {
 	/* user_vm_end/start are fixed before bpf prog runs */
 	long page_cnt_max = (arena->user_vm_end - arena->user_vm_start) >> PAGE_SHIFT;
@@ -498,6 +534,7 @@ static long arena_alloc_pages(struct bpf_arena *arena, long uaddr, long page_cnt
 	struct page **pages = NULL;
 	long remaining, mapped = 0;
 	long alloc_pages;
+	unsigned long flags;
 	long pgoff = 0;
 	u32 uaddr32;
 	int ret, i;
@@ -523,7 +560,8 @@ static long arena_alloc_pages(struct bpf_arena *arena, long uaddr, long page_cnt
 		return 0;
 	data.pages = pages;
 
-	mutex_lock(&arena->lock);
+	if (raw_res_spin_lock_irqsave(&arena->spinlock, flags))
+		goto out_free_pages;
 
 	if (uaddr) {
 		ret = is_range_tree_set(&arena->rt, pgoff, page_cnt);
@@ -566,24 +604,25 @@ static long arena_alloc_pages(struct bpf_arena *arena, long uaddr, long page_cnt
 			/* data.i pages were mapped, account them and free the remaining */
 			mapped += data.i;
 			for (i = data.i; i < this_batch; i++)
-				__free_page(pages[i]);
+				free_pages_nolock(pages[i], 0);
 			goto out;
 		}
 
 		mapped += this_batch;
 		remaining -= this_batch;
 	}
-	mutex_unlock(&arena->lock);
+	raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
 	kfree_nolock(pages);
 	return clear_lo32(arena->user_vm_start) + uaddr32;
 out:
 	range_tree_set(&arena->rt, pgoff + mapped, page_cnt - mapped);
-	mutex_unlock(&arena->lock);
+	raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
 	if (mapped)
-		arena_free_pages(arena, clear_lo32(arena->user_vm_start) + uaddr32, mapped);
+		arena_free_pages(arena, clear_lo32(arena->user_vm_start) + uaddr32, mapped,
+				 sleepable);
 	goto out_free_pages;
 out_unlock_free_pages:
-	mutex_unlock(&arena->lock);
+	raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
 out_free_pages:
 	kfree_nolock(pages);
 	return 0;
@@ -598,42 +637,65 @@ static void zap_pages(struct bpf_arena *arena, long uaddr, long page_cnt)
 {
 	struct vma_list *vml;
 
+	guard(mutex)(&arena->lock);
+	/* iterate link list under lock */
 	list_for_each_entry(vml, &arena->vma_list, head)
 		zap_page_range_single(vml->vma, uaddr,
 				      PAGE_SIZE * page_cnt, NULL);
 }
 
-static void arena_free_pages(struct bpf_arena *arena, long uaddr, long page_cnt)
+static void arena_free_pages(struct bpf_arena *arena, long uaddr, long page_cnt, bool sleepable)
 {
 	u64 full_uaddr, uaddr_end;
-	long kaddr, pgoff, i;
+	long kaddr, pgoff;
 	struct page *page;
+	struct llist_head free_pages;
+	struct llist_node *pos, *t;
+	struct arena_free_span *s;
+	unsigned long flags;
+	int ret = 0;
 
 	/* only aligned lower 32-bit are relevant */
 	uaddr = (u32)uaddr;
 	uaddr &= PAGE_MASK;
+	kaddr = bpf_arena_get_kern_vm_start(arena) + uaddr;
 	full_uaddr = clear_lo32(arena->user_vm_start) + uaddr;
 	uaddr_end = min(arena->user_vm_end, full_uaddr + (page_cnt << PAGE_SHIFT));
 	if (full_uaddr >= uaddr_end)
 		return;
 
 	page_cnt = (uaddr_end - full_uaddr) >> PAGE_SHIFT;
+	pgoff = compute_pgoff(arena, uaddr);
 
-	guard(mutex)(&arena->lock);
+	if (!sleepable)
+		goto defer;
+
+	ret = raw_res_spin_lock_irqsave(&arena->spinlock, flags);
+	/*
+	 * Can't proceed without holding the spinlock so defer the free
+	 */
+	if (ret)
+		goto defer;
 
-	pgoff = compute_pgoff(arena, uaddr);
-	/* clear range */
 	range_tree_set(&arena->rt, pgoff, page_cnt);
 
+	init_llist_head(&free_pages);
+	/* clear ptes and collect struct pages */
+	apply_to_existing_page_range(&init_mm, kaddr, page_cnt << PAGE_SHIFT,
+				     apply_range_clear_cb, &free_pages);
+
+	/* drop the lock to do the tlb flush and zap pages */
+	raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
+
+	/* ensure no stale TLB entries */
+	flush_tlb_kernel_range(kaddr, kaddr + (page_cnt * PAGE_SIZE));
+
 	if (page_cnt > 1)
 		/* bulk zap if multiple pages being freed */
 		zap_pages(arena, full_uaddr, page_cnt);
 
-	kaddr = bpf_arena_get_kern_vm_start(arena) + uaddr;
-	for (i = 0; i < page_cnt; i++, kaddr += PAGE_SIZE, full_uaddr += PAGE_SIZE) {
-		page = vmalloc_to_page((void *)kaddr);
-		if (!page)
-			continue;
+	llist_for_each_safe(pos, t, __llist_del_all(&free_pages)) {
+		page = llist_entry(pos, struct page, pcp_llist);
 		if (page_cnt == 1 && page_mapped(page)) /* mapped by some user process */
 			/* Optimization for the common case of page_cnt==1:
 			 * If page wasn't mapped into some user vma there
@@ -641,9 +703,20 @@ static void arena_free_pages(struct bpf_arena *arena, long uaddr, long page_cnt)
 			 * page_cnt is big it's faster to do the batched zap.
 			 */
 			zap_pages(arena, full_uaddr, 1);
-		apply_to_existing_page_range(&init_mm, kaddr, PAGE_SIZE, apply_range_clear_cb,
-					     NULL);
+		__free_page(page);
 	}
+
+	return;
+
+defer:
+	s = kmalloc_nolock(sizeof(struct arena_free_span), 0, -1);
+	if (!s)
+		return;
+
+	s->page_cnt = page_cnt;
+	s->uaddr = uaddr;
+	llist_add(&s->node, &arena->free_spans);
+	irq_work_queue(&arena->free_irq);
 }
 
 /*
@@ -653,6 +726,7 @@ static void arena_free_pages(struct bpf_arena *arena, long uaddr, long page_cnt)
 static int arena_reserve_pages(struct bpf_arena *arena, long uaddr, u32 page_cnt)
 {
 	long page_cnt_max = (arena->user_vm_end - arena->user_vm_start) >> PAGE_SHIFT;
+	unsigned long flags;
 	long pgoff;
 	int ret;
 
@@ -663,15 +737,87 @@ static int arena_reserve_pages(struct bpf_arena *arena, long uaddr, u32 page_cnt
 	if (pgoff + page_cnt > page_cnt_max)
 		return -EINVAL;
 
-	guard(mutex)(&arena->lock);
+	if (raw_res_spin_lock_irqsave(&arena->spinlock, flags))
+		return -EBUSY;
 
 	/* Cannot guard already allocated pages. */
 	ret = is_range_tree_set(&arena->rt, pgoff, page_cnt);
-	if (ret)
-		return -EBUSY;
+	if (ret) {
+		ret = -EBUSY;
+		goto out;
+	}
 
 	/* "Allocate" the region to prevent it from being allocated. */
-	return range_tree_clear(&arena->rt, pgoff, page_cnt);
+	ret = range_tree_clear(&arena->rt, pgoff, page_cnt);
+out:
+	raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
+	return ret;
+}
+
+static void arena_free_worker(struct work_struct *work)
+{
+	struct bpf_arena *arena = container_of(work, struct bpf_arena, free_work);
+	struct llist_node *list, *pos, *t;
+	struct arena_free_span *s;
+	u64 arena_vm_start, user_vm_start;
+	struct llist_head free_pages;
+	struct page *page;
+	unsigned long full_uaddr;
+	long kaddr, page_cnt, pgoff;
+	unsigned long flags;
+
+	if (raw_res_spin_lock_irqsave(&arena->spinlock, flags)) {
+		schedule_work(work);
+		return;
+	}
+
+	init_llist_head(&free_pages);
+	arena_vm_start = bpf_arena_get_kern_vm_start(arena);
+	user_vm_start = bpf_arena_get_user_vm_start(arena);
+
+	list = llist_del_all(&arena->free_spans);
+	llist_for_each(pos, list) {
+		s = llist_entry(pos, struct arena_free_span, node);
+		page_cnt = s->page_cnt;
+		kaddr = arena_vm_start + s->uaddr;
+		pgoff = compute_pgoff(arena, s->uaddr);
+
+		/* clear ptes and collect pages in free_pages llist */
+		apply_to_existing_page_range(&init_mm, kaddr, page_cnt << PAGE_SHIFT,
+					     apply_range_clear_cb, &free_pages);
+
+		range_tree_set(&arena->rt, pgoff, page_cnt);
+	}
+	raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
+
+	/* Iterate the list again without holding spinlock to do the tlb flush and zap_pages */
+	llist_for_each_safe(pos, t, list) {
+		s = llist_entry(pos, struct arena_free_span, node);
+		page_cnt = s->page_cnt;
+		full_uaddr = user_vm_start + s->uaddr;
+		kaddr = arena_vm_start + s->uaddr;
+
+		/* ensure no stale TLB entries */
+		flush_tlb_kernel_range(kaddr, kaddr + (page_cnt * PAGE_SIZE));
+
+		/* remove pages from user vmas */
+		zap_pages(arena, full_uaddr, page_cnt);
+
+		kfree_nolock(s);
+	}
+
+	/* free all pages collected by apply_to_existing_page_range() in the first loop */
+	llist_for_each_safe(pos, t, __llist_del_all(&free_pages)) {
+		page = llist_entry(pos, struct page, pcp_llist);
+		__free_page(page);
+	}
+}
+
+static void arena_free_irq(struct irq_work *iw)
+{
+	struct bpf_arena *arena = container_of(iw, struct bpf_arena, free_irq);
+
+	schedule_work(&arena->free_work);
 }
 
 __bpf_kfunc_start_defs();
@@ -685,9 +831,20 @@ __bpf_kfunc void *bpf_arena_alloc_pages(void *p__map, void *addr__ign, u32 page_
 	if (map->map_type != BPF_MAP_TYPE_ARENA || flags || !page_cnt)
 		return NULL;
 
-	return (void *)arena_alloc_pages(arena, (long)addr__ign, page_cnt, node_id);
+	return (void *)arena_alloc_pages(arena, (long)addr__ign, page_cnt, node_id, true);
 }
 
+void *bpf_arena_alloc_pages_non_sleepable(void *p__map, void *addr__ign, u32 page_cnt,
+					  int node_id, u64 flags)
+{
+	struct bpf_map *map = p__map;
+	struct bpf_arena *arena = container_of(map, struct bpf_arena, map);
+
+	if (map->map_type != BPF_MAP_TYPE_ARENA || flags || !page_cnt)
+		return NULL;
+
+	return (void *)arena_alloc_pages(arena, (long)addr__ign, page_cnt, node_id, false);
+}
 __bpf_kfunc void bpf_arena_free_pages(void *p__map, void *ptr__ign, u32 page_cnt)
 {
 	struct bpf_map *map = p__map;
@@ -695,7 +852,17 @@ __bpf_kfunc void bpf_arena_free_pages(void *p__map, void *ptr__ign, u32 page_cnt
 
 	if (map->map_type != BPF_MAP_TYPE_ARENA || !page_cnt || !ptr__ign)
 		return;
-	arena_free_pages(arena, (long)ptr__ign, page_cnt);
+	arena_free_pages(arena, (long)ptr__ign, page_cnt, true);
+}
+
+void bpf_arena_free_pages_non_sleepable(void *p__map, void *ptr__ign, u32 page_cnt)
+{
+	struct bpf_map *map = p__map;
+	struct bpf_arena *arena = container_of(map, struct bpf_arena, map);
+
+	if (map->map_type != BPF_MAP_TYPE_ARENA || !page_cnt || !ptr__ign)
+		return;
+	arena_free_pages(arena, (long)ptr__ign, page_cnt, false);
 }
 
 __bpf_kfunc int bpf_arena_reserve_pages(void *p__map, void *ptr__ign, u32 page_cnt)
@@ -714,9 +881,9 @@ __bpf_kfunc int bpf_arena_reserve_pages(void *p__map, void *ptr__ign, u32 page_c
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(arena_kfuncs)
-BTF_ID_FLAGS(func, bpf_arena_alloc_pages, KF_TRUSTED_ARGS | KF_SLEEPABLE | KF_ARENA_RET | KF_ARENA_ARG2)
-BTF_ID_FLAGS(func, bpf_arena_free_pages, KF_TRUSTED_ARGS | KF_SLEEPABLE | KF_ARENA_ARG2)
-BTF_ID_FLAGS(func, bpf_arena_reserve_pages, KF_TRUSTED_ARGS | KF_SLEEPABLE | KF_ARENA_ARG2)
+BTF_ID_FLAGS(func, bpf_arena_alloc_pages, KF_TRUSTED_ARGS | KF_ARENA_RET | KF_ARENA_ARG2)
+BTF_ID_FLAGS(func, bpf_arena_free_pages, KF_TRUSTED_ARGS | KF_ARENA_ARG2)
+BTF_ID_FLAGS(func, bpf_arena_reserve_pages, KF_TRUSTED_ARGS | KF_ARENA_ARG2)
 BTF_KFUNCS_END(arena_kfuncs)
 
 static const struct btf_kfunc_id_set common_kfunc_set = {
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 098dd7f21c89..14839f178a7c 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12349,6 +12349,8 @@ enum special_kfunc_type {
 	KF___bpf_trap,
 	KF_bpf_task_work_schedule_signal_impl,
 	KF_bpf_task_work_schedule_resume_impl,
+	KF_bpf_arena_alloc_pages,
+	KF_bpf_arena_free_pages,
 };
 
 BTF_ID_LIST(special_kfunc_list)
@@ -12423,6 +12425,8 @@ BTF_ID(func, bpf_dynptr_file_discard)
 BTF_ID(func, __bpf_trap)
 BTF_ID(func, bpf_task_work_schedule_signal_impl)
 BTF_ID(func, bpf_task_work_schedule_resume_impl)
+BTF_ID(func, bpf_arena_alloc_pages)
+BTF_ID(func, bpf_arena_free_pages)
 
 static bool is_task_work_add_kfunc(u32 func_id)
 {
@@ -22380,6 +22384,12 @@ static int specialize_kfunc(struct bpf_verifier_env *env, struct bpf_kfunc_desc
 	} else if (func_id == special_kfunc_list[KF_bpf_dynptr_from_file]) {
 		if (!env->insn_aux_data[insn_idx].non_sleepable)
 			addr = (unsigned long)bpf_dynptr_from_file_sleepable;
+	} else if (func_id == special_kfunc_list[KF_bpf_arena_alloc_pages]) {
+		if (env->insn_aux_data[insn_idx].non_sleepable)
+			addr = (unsigned long)bpf_arena_alloc_pages_non_sleepable;
+	} else if (func_id == special_kfunc_list[KF_bpf_arena_free_pages]) {
+		if (env->insn_aux_data[insn_idx].non_sleepable)
+			addr = (unsigned long)bpf_arena_free_pages_non_sleepable;
 	}
 	desc->addr = addr;
 	return 0;
-- 
2.47.1


