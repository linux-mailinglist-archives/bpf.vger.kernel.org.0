Return-Path: <bpf+bounces-76899-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 24312CC9521
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 19:45:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 36BBA3082FC7
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 18:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A388E267AF6;
	Wed, 17 Dec 2025 18:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TEzyhN9R"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E432E9ED8
	for <bpf@vger.kernel.org>; Wed, 17 Dec 2025 18:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765997097; cv=none; b=MYYH2f4Zq5Wm3F6g+AGTZM3fSTa+918lkVVLvBbv1gn6bGf3FFmrge2ewoW6ICpZ1mf/tnvkNjDPO2hDhwWQlx6E0t40gE82l/CzsfaCWXA2kllEwePDpAwCVvruS8W9TthdyaLkHptnJtGi/IjblHt+Jd0G+RgE5aZGvhryNf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765997097; c=relaxed/simple;
	bh=pv7NV/btqplc/1FkVEdEKXT5HZXaVzNk4YeuYvYabis=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nPrKMC4PWO22aKU4RmoPm+D4jazocRfuzFsibcmN3LFwfdk5p4JJq2jmWZS+zYarmjxm3FqKiQTwIgvRJDzigCgTn9UFhWCQP3+oNcmAEpS6qaB2YOMcjzWfFXvNesSsdZ9wYeZ/1s9PgLuR+QHDHWj73I+or95db8UwmYw95nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TEzyhN9R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A2EBC4CEFB;
	Wed, 17 Dec 2025 18:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765997096;
	bh=pv7NV/btqplc/1FkVEdEKXT5HZXaVzNk4YeuYvYabis=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TEzyhN9RBrQLhPwXhjzfuE6KtQ6i/ZDLle/WuwvlXCFJlYqtKyOtO3O02xZax1aTm
	 t1VaVM1rjtLxvT/aP/zw+r6GqEOAaayrXVY/DGrnflv6SmUhKlWQZ++qK++v/JZD+Z
	 T3m9zesUz6Eu7s1FtH+yuDfx48HtLBwnPU7CScmElwyYsyaFrJbnZ0dIQzXF3hlBe8
	 rmJkgG23xem4mr2e/lyLm4UbpD/bj4Eb0U21QZDremTozhfjdEuEG+OJXBLOaH6IY4
	 zWs5rPmM1rQwGhx3kTgGVbJhHVyZvFx4YE8+bAE2Y1JKTrq3zWolVsYTzjKnjKLhV+
	 cFunSTdRf1LJA==
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
Subject: [PATCH bpf-next v6 1/4] bpf: arena: populate vm_area without allocating memory
Date: Wed, 17 Dec 2025 10:44:32 -0800
Message-ID: <20251217184438.3557859-2-puranjay@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251217184438.3557859-1-puranjay@kernel.org>
References: <20251217184438.3557859-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vm_area_map_pages() may allocate memory while inserting pages into bpf
arena's vm_area. In order to make bpf_arena_alloc_pages() kfunc
non-sleepable change bpf arena to populate pages without
allocating memory:
- at arena creation time populate all page table levels except
  the last level
- when new pages need to be inserted call apply_to_page_range() again
  with apply_range_set_cb() which will only set_pte_at() those pages and
  will not allocate memory.
- when freeing pages call apply_to_existing_page_range with
  apply_range_clear_cb() to clear the pte for the page to be removed. This
  doesn't free intermediate page table levels.

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 kernel/bpf/arena.c | 86 +++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 78 insertions(+), 8 deletions(-)

diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
index 872dc0e41c65..039f25fc074b 100644
--- a/kernel/bpf/arena.c
+++ b/kernel/bpf/arena.c
@@ -7,6 +7,7 @@
 #include <linux/btf_ids.h>
 #include <linux/vmalloc.h>
 #include <linux/pagemap.h>
+#include <asm/tlbflush.h>
 #include "range_tree.h"
 
 /*
@@ -92,6 +93,63 @@ static long compute_pgoff(struct bpf_arena *arena, long uaddr)
 	return (u32)(uaddr - (u32)arena->user_vm_start) >> PAGE_SHIFT;
 }
 
+struct apply_range_data {
+	struct page **pages;
+	int i;
+};
+
+static int apply_range_set_cb(pte_t *pte, unsigned long addr, void *data)
+{
+	struct apply_range_data *d = data;
+	struct page *page;
+
+	if (!data)
+		return 0;
+	/* sanity check */
+	if (unlikely(!pte_none(ptep_get(pte))))
+		return -EBUSY;
+
+	page = d->pages[d->i];
+	/* paranoia, similar to vmap_pages_pte_range() */
+	if (WARN_ON_ONCE(!pfn_valid(page_to_pfn(page))))
+		return -EINVAL;
+
+	set_pte_at(&init_mm, addr, pte, mk_pte(page, PAGE_KERNEL));
+	d->i++;
+	return 0;
+}
+
+static int apply_range_clear_cb(pte_t *pte, unsigned long addr, void *data)
+{
+	pte_t old_pte;
+	struct page *page;
+
+	/* sanity check */
+	old_pte = ptep_get(pte);
+	if (pte_none(old_pte) || !pte_present(old_pte))
+		return 0; /* nothing to do */
+
+	/* get page and free it */
+	page = pte_page(old_pte);
+	if (WARN_ON_ONCE(!page))
+		return -EINVAL;
+
+	pte_clear(&init_mm, addr, pte);
+
+	/* ensure no stale TLB entries */
+	flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
+
+	__free_page(page);
+
+	return 0;
+}
+
+static int populate_pgtable_except_pte(struct bpf_arena *arena)
+{
+	return apply_to_page_range(&init_mm, bpf_arena_get_kern_vm_start(arena),
+				   KERN_VM_SZ - GUARD_SZ, apply_range_set_cb, NULL);
+}
+
 static struct bpf_map *arena_map_alloc(union bpf_attr *attr)
 {
 	struct vm_struct *kern_vm;
@@ -144,6 +202,12 @@ static struct bpf_map *arena_map_alloc(union bpf_attr *attr)
 		goto err;
 	}
 	mutex_init(&arena->lock);
+	err = populate_pgtable_except_pte(arena);
+	if (err) {
+		range_tree_destroy(&arena->rt);
+		bpf_map_area_free(arena);
+		goto err;
+	}
 
 	return &arena->map;
 err:
@@ -286,6 +350,7 @@ static vm_fault_t arena_vm_fault(struct vm_fault *vmf)
 	if (ret)
 		return VM_FAULT_SIGSEGV;
 
+	struct apply_range_data data = { .pages = &page, .i = 0 };
 	/* Account into memcg of the process that created bpf_arena */
 	ret = bpf_map_alloc_pages(map, NUMA_NO_NODE, 1, &page);
 	if (ret) {
@@ -293,7 +358,7 @@ static vm_fault_t arena_vm_fault(struct vm_fault *vmf)
 		return VM_FAULT_SIGSEGV;
 	}
 
-	ret = vm_area_map_pages(arena->kern_vm, kaddr, kaddr + PAGE_SIZE, &page);
+	ret = apply_to_page_range(&init_mm, kaddr, PAGE_SIZE, apply_range_set_cb, &data);
 	if (ret) {
 		range_tree_set(&arena->rt, vmf->pgoff, 1);
 		__free_page(page);
@@ -428,7 +493,8 @@ static long arena_alloc_pages(struct bpf_arena *arena, long uaddr, long page_cnt
 	/* user_vm_end/start are fixed before bpf prog runs */
 	long page_cnt_max = (arena->user_vm_end - arena->user_vm_start) >> PAGE_SHIFT;
 	u64 kern_vm_start = bpf_arena_get_kern_vm_start(arena);
-	struct page **pages;
+	struct page **pages = NULL;
+	long mapped = 0;
 	long pgoff = 0;
 	u32 uaddr32;
 	int ret, i;
@@ -465,6 +531,7 @@ static long arena_alloc_pages(struct bpf_arena *arena, long uaddr, long page_cnt
 	if (ret)
 		goto out_free_pages;
 
+	struct apply_range_data data = { .pages = pages, .i = 0 };
 	ret = bpf_map_alloc_pages(&arena->map, node_id, page_cnt, pages);
 	if (ret)
 		goto out;
@@ -477,17 +544,20 @@ static long arena_alloc_pages(struct bpf_arena *arena, long uaddr, long page_cnt
 	 * kern_vm_start + uaddr32 + page_cnt * PAGE_SIZE - 1 can overflow
 	 * lower 32-bit and it's ok.
 	 */
-	ret = vm_area_map_pages(arena->kern_vm, kern_vm_start + uaddr32,
-				kern_vm_start + uaddr32 + page_cnt * PAGE_SIZE, pages);
+	ret = apply_to_page_range(&init_mm, kern_vm_start + uaddr32,
+				  page_cnt << PAGE_SHIFT, apply_range_set_cb, &data);
 	if (ret) {
-		for (i = 0; i < page_cnt; i++)
+		mapped = data.i;
+		for (i = mapped; i < page_cnt; i++)
 			__free_page(pages[i]);
 		goto out;
 	}
 	kvfree(pages);
 	return clear_lo32(arena->user_vm_start) + uaddr32;
 out:
-	range_tree_set(&arena->rt, pgoff, page_cnt);
+	range_tree_set(&arena->rt, pgoff + mapped, page_cnt - mapped);
+	if (mapped)
+		arena_free_pages(arena, uaddr32, mapped);
 out_free_pages:
 	kvfree(pages);
 	return 0;
@@ -545,8 +615,8 @@ static void arena_free_pages(struct bpf_arena *arena, long uaddr, long page_cnt)
 			 * page_cnt is big it's faster to do the batched zap.
 			 */
 			zap_pages(arena, full_uaddr, 1);
-		vm_area_unmap_pages(arena->kern_vm, kaddr, kaddr + PAGE_SIZE);
-		__free_page(page);
+		apply_to_existing_page_range(&init_mm, kaddr, PAGE_SIZE, apply_range_clear_cb,
+					     NULL);
 	}
 }
 
-- 
2.47.3


