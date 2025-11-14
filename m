Return-Path: <bpf+bounces-74506-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA214C5CCFE
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 12:19:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79DCF3A257F
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 11:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D75E9313527;
	Fri, 14 Nov 2025 11:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k86LWmVr"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A5C9313277
	for <bpf@vger.kernel.org>; Fri, 14 Nov 2025 11:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763119029; cv=none; b=sW9UfLHME8oSfq/HiMfOz1xIelAwIUicJYuW95PoI6D9l5kKd8TksG3OCCRjEWzd8zKgNPNVs2dKZ7a3qjSlxwmuZuI9g2BAIRfP2T6fJz6Lw0ySgYm8m0wOUI6xr5A4kBHMasHO6QYdHbY0ZtL2Z3383KTgocUj71XXEQNZZLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763119029; c=relaxed/simple;
	bh=O3CMooHkYGYYsyw4uIZ8TBuWgyYEoDKcnDRmLmDoEQw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dlpx/GMJudTWuw24PhnyVCAJcde0J3ve/UYnmivc5O7YJAwJ5Gb1YAH/qg2Em26iqRmEg6iOUD+n+dQPzxymlb2cRbMvGN65DeUsZcd37VyfJVAa7BXweY0J2WQbSblEmyHuWuBcmWhSongVdEu/v2WXzEntzZMgbo5ykBWd6cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k86LWmVr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C06FC4CEF5;
	Fri, 14 Nov 2025 11:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763119028;
	bh=O3CMooHkYGYYsyw4uIZ8TBuWgyYEoDKcnDRmLmDoEQw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k86LWmVrU9i591thconknR6gdefHW1R8Y2e59ILGQnVYO+GkP1RUFZ3s/FCd6LX2F
	 Gs7mfaJea4uKoBF2iRhMra2hnches6NUhN9Z21VZtxmfdapPdNtm28OAxw98sYnA+w
	 LvcUQMn2m4Vgi7pZcplkkAyYdSAFYykVyGuHiJ1IBxcsn/UyPmSKDSgc5GZ1PCMffF
	 h0K5c/SfaVl7eVCWaaxfbKPrw0eB7EMtW1D5VcX3BWrlg2j3WnbdVOqpuz3cSP0UIz
	 tOycGnJY1nXWertig89eRLB05Q6+d+yULMj2rM6OsdTks6usYtNGBvi1IbTOcd3+Kn
	 DnPaFjA9a5SLQ==
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
Subject: [PATCH bpf-next v2 1/4] bpf: arena: populate vm_area without allocating memory
Date: Fri, 14 Nov 2025 11:16:56 +0000
Message-ID: <20251114111700.43292-2-puranjay@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251114111700.43292-1-puranjay@kernel.org>
References: <20251114111700.43292-1-puranjay@kernel.org>
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
 kernel/bpf/arena.c | 76 ++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 70 insertions(+), 6 deletions(-)

diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
index 1074ac4459f2..48b8ffba3c88 100644
--- a/kernel/bpf/arena.c
+++ b/kernel/bpf/arena.c
@@ -7,6 +7,7 @@
 #include <linux/btf_ids.h>
 #include <linux/vmalloc.h>
 #include <linux/pagemap.h>
+#include <asm/tlbflush.h>
 #include "range_tree.h"
 
 /*
@@ -92,6 +93,62 @@ static long compute_pgoff(struct bpf_arena *arena, long uaddr)
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
+	page = d->pages[d->i++];
+	/* paranoia, similar to vmap_pages_pte_range() */
+	if (WARN_ON_ONCE(!pfn_valid(page_to_pfn(page))))
+		return -EINVAL;
+
+	set_pte_at(&init_mm, addr, pte, mk_pte(page, PAGE_KERNEL));
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
@@ -144,6 +201,11 @@ static struct bpf_map *arena_map_alloc(union bpf_attr *attr)
 		goto err;
 	}
 	mutex_init(&arena->lock);
+	err = populate_pgtable_except_pte(arena);
+	if (err) {
+		bpf_map_area_free(arena);
+		goto err;
+	}
 
 	return &arena->map;
 err:
@@ -286,6 +348,7 @@ static vm_fault_t arena_vm_fault(struct vm_fault *vmf)
 	if (ret)
 		return VM_FAULT_SIGSEGV;
 
+	struct apply_range_data data = { .pages = &page, .i = 0 };
 	/* Account into memcg of the process that created bpf_arena */
 	ret = bpf_map_alloc_pages(map, NUMA_NO_NODE, 1, &page);
 	if (ret) {
@@ -293,7 +356,7 @@ static vm_fault_t arena_vm_fault(struct vm_fault *vmf)
 		return VM_FAULT_SIGSEGV;
 	}
 
-	ret = vm_area_map_pages(arena->kern_vm, kaddr, kaddr + PAGE_SIZE, &page);
+	ret = apply_to_page_range(&init_mm, kaddr, PAGE_SIZE, apply_range_set_cb, &data);
 	if (ret) {
 		range_tree_set(&arena->rt, vmf->pgoff, 1);
 		__free_page(page);
@@ -428,7 +491,7 @@ static long arena_alloc_pages(struct bpf_arena *arena, long uaddr, long page_cnt
 	/* user_vm_end/start are fixed before bpf prog runs */
 	long page_cnt_max = (arena->user_vm_end - arena->user_vm_start) >> PAGE_SHIFT;
 	u64 kern_vm_start = bpf_arena_get_kern_vm_start(arena);
-	struct page **pages;
+	struct page **pages = NULL;
 	long pgoff = 0;
 	u32 uaddr32;
 	int ret, i;
@@ -465,6 +528,7 @@ static long arena_alloc_pages(struct bpf_arena *arena, long uaddr, long page_cnt
 	if (ret)
 		goto out_free_pages;
 
+	struct apply_range_data data = { .pages = pages, .i = 0 };
 	ret = bpf_map_alloc_pages(&arena->map, node_id, page_cnt, pages);
 	if (ret)
 		goto out;
@@ -477,8 +541,8 @@ static long arena_alloc_pages(struct bpf_arena *arena, long uaddr, long page_cnt
 	 * kern_vm_start + uaddr32 + page_cnt * PAGE_SIZE - 1 can overflow
 	 * lower 32-bit and it's ok.
 	 */
-	ret = vm_area_map_pages(arena->kern_vm, kern_vm_start + uaddr32,
-				kern_vm_start + uaddr32 + page_cnt * PAGE_SIZE, pages);
+	ret = apply_to_page_range(&init_mm, kern_vm_start + uaddr32,
+				  page_cnt << PAGE_SHIFT, apply_range_set_cb, &data);
 	if (ret) {
 		for (i = 0; i < page_cnt; i++)
 			__free_page(pages[i]);
@@ -545,8 +609,8 @@ static void arena_free_pages(struct bpf_arena *arena, long uaddr, long page_cnt)
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
2.47.1


