Return-Path: <bpf+bounces-74237-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E3A4DC4F108
	for <lists+bpf@lfdr.de>; Tue, 11 Nov 2025 17:39:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 140984F801B
	for <lists+bpf@lfdr.de>; Tue, 11 Nov 2025 16:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 830F436CE10;
	Tue, 11 Nov 2025 16:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ST5MMb8h"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B03328276
	for <bpf@vger.kernel.org>; Tue, 11 Nov 2025 16:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762878892; cv=none; b=NkFjinPJ+S1FjlzdgWP9pLmD2Y3s9YaH1DK72b256i+SUeIxjvFTI0N2PjpJRuT457tx/WMcFPcLBeoErJ8W40szuU6gTYT4Azz/85TZ+q6SZ+VJM/JRSpfQ6DyrkmIThLbvaV6CB4w8nEaS7oXGKzRyf5H+zm2YAltenG6Yirw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762878892; c=relaxed/simple;
	bh=tlG1qTRS7EqXudk4K1IhW2DUjymd/CM3GqnECS4kmsw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l4oKudYkr06Xw/9llg8D6cBC/enFZItsEFUp0TNxbEjhzYxNzN47L/JcWUg+/1dmtEtX/otKFg6AWOBU5RliCu1jR9XIeYSZ7m/ZRGrn3vOWlr9JgH1of0tT7Sl0PyNbYXVfn7weAiQ3kTOrSMpV91UIYYf5CvQNQRdVdlfVoQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ST5MMb8h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33549C4CEF7;
	Tue, 11 Nov 2025 16:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762878891;
	bh=tlG1qTRS7EqXudk4K1IhW2DUjymd/CM3GqnECS4kmsw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ST5MMb8hlrlvGHqRIpJ1m8dKQBrj8/SPhEUFUwbCJjlF+In04rMumwbOkMXBWQA8Z
	 V/qOo77FGWJPK7TqdPH9Yp1DiQNMlTlfCzWqJGliTrilLanfN1THrDSQ7iwByAqnlF
	 CkNd1R9Gb1imweoYdYf0vF3PZ/ITuZmDrtipjxxzRayuJG6xlyo5ysUIrXQUHwJtvL
	 4ZAjIaOXrP+Y689wcjlnaMYoyxrNZfm+VJJZw7wBD77RuS+i2r/ie0G3aaEVXVzoF6
	 kyzu+tjXyh7bpNsnnV5GRWmLsyv6MTWpYWOEu4ccicSAXfyMG5qK8oiXgGgM/H1fLV
	 Kq+9A1LSXgFGA==
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
Subject: [PATCH bpf-next 1/4] bpf: arena: populate vm_area without allocating memory
Date: Tue, 11 Nov 2025 16:34:19 +0000
Message-ID: <20251111163424.16471-2-puranjay@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251111163424.16471-1-puranjay@kernel.org>
References: <20251111163424.16471-1-puranjay@kernel.org>
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
 kernel/bpf/arena.c | 74 ++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 68 insertions(+), 6 deletions(-)

diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
index 1074ac4459f2..dd5100a2f93c 100644
--- a/kernel/bpf/arena.c
+++ b/kernel/bpf/arena.c
@@ -92,6 +92,63 @@ static long compute_pgoff(struct bpf_arena *arena, long uaddr)
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
+	struct mm_struct *mm = &init_mm;
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
+	pte_clear(mm, addr, pte);
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
@@ -144,6 +201,9 @@ static struct bpf_map *arena_map_alloc(union bpf_attr *attr)
 		goto err;
 	}
 	mutex_init(&arena->lock);
+	err = populate_pgtable_except_pte(arena);
+	if (err)
+		goto err;
 
 	return &arena->map;
 err:
@@ -286,6 +346,7 @@ static vm_fault_t arena_vm_fault(struct vm_fault *vmf)
 	if (ret)
 		return VM_FAULT_SIGSEGV;
 
+	struct apply_range_data data = { .pages = &page, .i = 0 };
 	/* Account into memcg of the process that created bpf_arena */
 	ret = bpf_map_alloc_pages(map, NUMA_NO_NODE, 1, &page);
 	if (ret) {
@@ -293,7 +354,7 @@ static vm_fault_t arena_vm_fault(struct vm_fault *vmf)
 		return VM_FAULT_SIGSEGV;
 	}
 
-	ret = vm_area_map_pages(arena->kern_vm, kaddr, kaddr + PAGE_SIZE, &page);
+	ret = apply_to_page_range(&init_mm, kaddr, PAGE_SIZE, apply_range_set_cb, &data);
 	if (ret) {
 		range_tree_set(&arena->rt, vmf->pgoff, 1);
 		__free_page(page);
@@ -428,7 +489,7 @@ static long arena_alloc_pages(struct bpf_arena *arena, long uaddr, long page_cnt
 	/* user_vm_end/start are fixed before bpf prog runs */
 	long page_cnt_max = (arena->user_vm_end - arena->user_vm_start) >> PAGE_SHIFT;
 	u64 kern_vm_start = bpf_arena_get_kern_vm_start(arena);
-	struct page **pages;
+	struct page **pages = NULL;
 	long pgoff = 0;
 	u32 uaddr32;
 	int ret, i;
@@ -465,6 +526,7 @@ static long arena_alloc_pages(struct bpf_arena *arena, long uaddr, long page_cnt
 	if (ret)
 		goto out_free_pages;
 
+	struct apply_range_data data = { .pages = pages, .i = 0 };
 	ret = bpf_map_alloc_pages(&arena->map, node_id, page_cnt, pages);
 	if (ret)
 		goto out;
@@ -477,8 +539,8 @@ static long arena_alloc_pages(struct bpf_arena *arena, long uaddr, long page_cnt
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
@@ -545,8 +607,8 @@ static void arena_free_pages(struct bpf_arena *arena, long uaddr, long page_cnt)
 			 * page_cnt is big it's faster to do the batched zap.
 			 */
 			zap_pages(arena, full_uaddr, 1);
-		vm_area_unmap_pages(arena->kern_vm, kaddr, kaddr + PAGE_SIZE);
-		__free_page(page);
+		apply_to_existing_page_range(&init_mm, kaddr, page_cnt << PAGE_SHIFT,
+					     apply_range_clear_cb, NULL);
 	}
 }
 
-- 
2.47.3


