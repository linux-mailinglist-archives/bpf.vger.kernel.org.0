Return-Path: <bpf+bounces-74744-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A56FC6506D
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 17:04:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 60BEF4EC014
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 16:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34DED2BEC3A;
	Mon, 17 Nov 2025 16:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X3mfGJue"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3332BEC30
	for <bpf@vger.kernel.org>; Mon, 17 Nov 2025 16:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763395329; cv=none; b=u6ByQripUAnch1pad/eyk2W06k+diL9UqfA40AAkGkNvDXZUhK82Gkmx0+jupF4/TVYOK45rRiCFGazZCtrMw84TwhbjA4Wcx1hrv6Zd5W7JpClXdiSYRYRmnpmsqDci+h/eKfb3Nhp60cmVzfk9bYLm3dx8FFRiajDVZTpypcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763395329; c=relaxed/simple;
	bh=cA6KXjbduSW8unO9kpKjqonYaqI13ItZoyrubgYhFec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IK2EINgo7vuZrMDnjki/6gHcp3SLjdwdXv1lCrjWGAMF5gEujFcJ26etZemtFzJIxLJW5SilpnOsA53Vl6Jy/P9SHgyZPgwmryReOCjE7lQxasWDnusmNt+XJfnxJa4Z+v0Wx4Fa7fyXdA/Hmm4E3gudcB/v5K+DRrckGXKRIXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X3mfGJue; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51655C4AF09;
	Mon, 17 Nov 2025 16:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763395329;
	bh=cA6KXjbduSW8unO9kpKjqonYaqI13ItZoyrubgYhFec=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X3mfGJuefFamBzK/2j1B3QEvwYnU4viW/NkVNgmAxNPdzDBPiD9M5+fbOKEgxPNrJ
	 kan9VAykxiSB90XMVZf9+qeIAXngF1xCiqQ7N91bibbEQKp4L3WIC/iar55nt6NNS+
	 vva5oIhyEbF3ncsYR5JgQM5OXnpLBgi2GVX+f6w/MQzHyGlSifb63MyrLei4YB1iat
	 yN/dfeBNJ54QOx5cph5ClYAc6b2pAhOPhJU+9jNTyw2Qf/AnZQH4XEfKPEKUkxT4rB
	 baSZjwxerPVWOue4cK68Wnmr3AXaI/EtK3RcdZiRxruTvFyAcV2WHPkfa7HlH9gnAo
	 4GAEq8gzNt1PQ==
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
Subject: [PATCH bpf-next v3 1/4] bpf: arena: populate vm_area without allocating memory
Date: Mon, 17 Nov 2025 16:01:45 +0000
Message-ID: <20251117160150.62183-2-puranjay@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251117160150.62183-1-puranjay@kernel.org>
References: <20251117160150.62183-1-puranjay@kernel.org>
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
 kernel/bpf/arena.c | 77 ++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 71 insertions(+), 6 deletions(-)

diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
index 1074ac4459f2..214a4da54162 100644
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
@@ -144,6 +201,12 @@ static struct bpf_map *arena_map_alloc(union bpf_attr *attr)
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
@@ -286,6 +349,7 @@ static vm_fault_t arena_vm_fault(struct vm_fault *vmf)
 	if (ret)
 		return VM_FAULT_SIGSEGV;
 
+	struct apply_range_data data = { .pages = &page, .i = 0 };
 	/* Account into memcg of the process that created bpf_arena */
 	ret = bpf_map_alloc_pages(map, NUMA_NO_NODE, 1, &page);
 	if (ret) {
@@ -293,7 +357,7 @@ static vm_fault_t arena_vm_fault(struct vm_fault *vmf)
 		return VM_FAULT_SIGSEGV;
 	}
 
-	ret = vm_area_map_pages(arena->kern_vm, kaddr, kaddr + PAGE_SIZE, &page);
+	ret = apply_to_page_range(&init_mm, kaddr, PAGE_SIZE, apply_range_set_cb, &data);
 	if (ret) {
 		range_tree_set(&arena->rt, vmf->pgoff, 1);
 		__free_page(page);
@@ -428,7 +492,7 @@ static long arena_alloc_pages(struct bpf_arena *arena, long uaddr, long page_cnt
 	/* user_vm_end/start are fixed before bpf prog runs */
 	long page_cnt_max = (arena->user_vm_end - arena->user_vm_start) >> PAGE_SHIFT;
 	u64 kern_vm_start = bpf_arena_get_kern_vm_start(arena);
-	struct page **pages;
+	struct page **pages = NULL;
 	long pgoff = 0;
 	u32 uaddr32;
 	int ret, i;
@@ -465,6 +529,7 @@ static long arena_alloc_pages(struct bpf_arena *arena, long uaddr, long page_cnt
 	if (ret)
 		goto out_free_pages;
 
+	struct apply_range_data data = { .pages = pages, .i = 0 };
 	ret = bpf_map_alloc_pages(&arena->map, node_id, page_cnt, pages);
 	if (ret)
 		goto out;
@@ -477,8 +542,8 @@ static long arena_alloc_pages(struct bpf_arena *arena, long uaddr, long page_cnt
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
@@ -545,8 +610,8 @@ static void arena_free_pages(struct bpf_arena *arena, long uaddr, long page_cnt)
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


