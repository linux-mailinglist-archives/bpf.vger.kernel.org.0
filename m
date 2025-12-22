Return-Path: <bpf+bounces-77301-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CBBECD6EEF
	for <lists+bpf@lfdr.de>; Mon, 22 Dec 2025 20:08:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 883B13016DC4
	for <lists+bpf@lfdr.de>; Mon, 22 Dec 2025 19:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A989C33A9D8;
	Mon, 22 Dec 2025 19:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aDVLoXSN"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E21B9299A81
	for <bpf@vger.kernel.org>; Mon, 22 Dec 2025 19:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766430528; cv=none; b=R8oisTmx/ulZyzoXPE4j7tMT7qVfjDfo5XhSNeqjsqF2piuUhZPpYg1Jzwsm/tu877gud+Eg6y8T8IaWKN3wq4OZP7IKG2lI1hjeJbyNs6z1JTqMsdU+nEjtQwKqnxKgL2+Xrx9D5ftgut2g8SV/j8bIODoZXCQIMhP1UivKT3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766430528; c=relaxed/simple;
	bh=NPT+B7Ea7q1CyCD/e0uvBE0ylzS/0c50zT79Kd2n+gI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q3g5hhY5n7P+bqUNcY+SUWymf0QLPCi7XK7svii2bkPZvtngbtMjVCx6m5NQf0VPWbXkcTHRzts31F0RbYl28KK7o4AkDe/cjna/pHJcmgIDjbSUrwtf8/xasq21Q9yFQdMcXQc+NEduSGKWrO9uF2FZa6htG0mQdMyHIWThTFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aDVLoXSN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3D99C4CEF1;
	Mon, 22 Dec 2025 19:08:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766430527;
	bh=NPT+B7Ea7q1CyCD/e0uvBE0ylzS/0c50zT79Kd2n+gI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aDVLoXSNVuMElD0YSy9cRo2sPpO1m514Vbq4osa95HGHDvm5eQBjV2BA22hkwZMb4
	 zWZgqhO4axDzmR0M/szrjOhHkyat1EKePhBzdpzbn32j9g2taehD3nugmAFo8wRup7
	 WdPsezzng8a1SuTw4x56Zm4QWEMM4koLDDZTQvZ3+6XiIFUZACmROdj0jsX+6lASbZ
	 gTO+hChgW84CZzQhCZz3U1dxsjvMujjEEDI7pLeK1HLhlQzVVerYqK005vzrfbX++w
	 wuGbfN93cVjSX/aEl4XmK+f+/sEtMK2jSkjypU0mBzI7fElShAKDvBW2t06TRLrrZ4
	 pTzN3bEZR+1tQ==
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
Subject: [PATCH bpf-next v7 1/4] bpf: arena: populate vm_area without allocating memory
Date: Mon, 22 Dec 2025 11:08:08 -0800
Message-ID: <20251222190815.4112944-2-puranjay@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251222190815.4112944-1-puranjay@kernel.org>
References: <20251222190815.4112944-1-puranjay@kernel.org>
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
 kernel/bpf/arena.c | 100 ++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 90 insertions(+), 10 deletions(-)

diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
index 872dc0e41c65..55b198b9f1a3 100644
--- a/kernel/bpf/arena.c
+++ b/kernel/bpf/arena.c
@@ -2,11 +2,13 @@
 /* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
 #include <linux/bpf.h>
 #include <linux/btf.h>
+#include <linux/cacheflush.h>
 #include <linux/err.h>
 #include "linux/filter.h"
 #include <linux/btf_ids.h>
 #include <linux/vmalloc.h>
 #include <linux/pagemap.h>
+#include <asm/tlbflush.h>
 #include "range_tree.h"
 
 /*
@@ -92,6 +94,68 @@ static long compute_pgoff(struct bpf_arena *arena, long uaddr)
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
+static void flush_vmap_cache(unsigned long start, unsigned long size)
+{
+	flush_cache_vmap(start, start + size);
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
@@ -144,6 +208,12 @@ static struct bpf_map *arena_map_alloc(union bpf_attr *attr)
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
@@ -286,6 +356,7 @@ static vm_fault_t arena_vm_fault(struct vm_fault *vmf)
 	if (ret)
 		return VM_FAULT_SIGSEGV;
 
+	struct apply_range_data data = { .pages = &page, .i = 0 };
 	/* Account into memcg of the process that created bpf_arena */
 	ret = bpf_map_alloc_pages(map, NUMA_NO_NODE, 1, &page);
 	if (ret) {
@@ -293,12 +364,13 @@ static vm_fault_t arena_vm_fault(struct vm_fault *vmf)
 		return VM_FAULT_SIGSEGV;
 	}
 
-	ret = vm_area_map_pages(arena->kern_vm, kaddr, kaddr + PAGE_SIZE, &page);
+	ret = apply_to_page_range(&init_mm, kaddr, PAGE_SIZE, apply_range_set_cb, &data);
 	if (ret) {
 		range_tree_set(&arena->rt, vmf->pgoff, 1);
 		__free_page(page);
 		return VM_FAULT_SIGSEGV;
 	}
+	flush_vmap_cache(kaddr, PAGE_SIZE);
 out:
 	page_ref_add(page, 1);
 	vmf->page = page;
@@ -428,7 +500,8 @@ static long arena_alloc_pages(struct bpf_arena *arena, long uaddr, long page_cnt
 	/* user_vm_end/start are fixed before bpf prog runs */
 	long page_cnt_max = (arena->user_vm_end - arena->user_vm_start) >> PAGE_SHIFT;
 	u64 kern_vm_start = bpf_arena_get_kern_vm_start(arena);
-	struct page **pages;
+	struct page **pages = NULL;
+	long mapped = 0;
 	long pgoff = 0;
 	u32 uaddr32;
 	int ret, i;
@@ -450,7 +523,7 @@ static long arena_alloc_pages(struct bpf_arena *arena, long uaddr, long page_cnt
 	if (!pages)
 		return 0;
 
-	guard(mutex)(&arena->lock);
+	mutex_lock(&arena->lock);
 
 	if (uaddr) {
 		ret = is_range_tree_set(&arena->rt, pgoff, page_cnt);
@@ -465,6 +538,7 @@ static long arena_alloc_pages(struct bpf_arena *arena, long uaddr, long page_cnt
 	if (ret)
 		goto out_free_pages;
 
+	struct apply_range_data data = { .pages = pages, .i = 0 };
 	ret = bpf_map_alloc_pages(&arena->map, node_id, page_cnt, pages);
 	if (ret)
 		goto out;
@@ -477,18 +551,24 @@ static long arena_alloc_pages(struct bpf_arena *arena, long uaddr, long page_cnt
 	 * kern_vm_start + uaddr32 + page_cnt * PAGE_SIZE - 1 can overflow
 	 * lower 32-bit and it's ok.
 	 */
-	ret = vm_area_map_pages(arena->kern_vm, kern_vm_start + uaddr32,
-				kern_vm_start + uaddr32 + page_cnt * PAGE_SIZE, pages);
-	if (ret) {
-		for (i = 0; i < page_cnt; i++)
+	apply_to_page_range(&init_mm, kern_vm_start + uaddr32,
+			    page_cnt << PAGE_SHIFT, apply_range_set_cb, &data);
+	mapped = data.i;
+	flush_vmap_cache(kern_vm_start + uaddr32, mapped << PAGE_SHIFT);
+	if (mapped < page_cnt) {
+		for (i = mapped; i < page_cnt; i++)
 			__free_page(pages[i]);
 		goto out;
 	}
+	mutex_unlock(&arena->lock);
 	kvfree(pages);
 	return clear_lo32(arena->user_vm_start) + uaddr32;
 out:
-	range_tree_set(&arena->rt, pgoff, page_cnt);
+	range_tree_set(&arena->rt, pgoff + mapped, page_cnt - mapped);
 out_free_pages:
+	mutex_unlock(&arena->lock);
+	if (mapped)
+		arena_free_pages(arena, uaddr32, mapped);
 	kvfree(pages);
 	return 0;
 }
@@ -545,8 +625,8 @@ static void arena_free_pages(struct bpf_arena *arena, long uaddr, long page_cnt)
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


