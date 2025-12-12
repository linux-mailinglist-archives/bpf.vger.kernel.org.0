Return-Path: <bpf+bounces-76510-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 39505CB7E25
	for <lists+bpf@lfdr.de>; Fri, 12 Dec 2025 05:45:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A6421300A249
	for <lists+bpf@lfdr.de>; Fri, 12 Dec 2025 04:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 806F6248893;
	Fri, 12 Dec 2025 04:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i72GuM2l"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D995C2E7F21
	for <bpf@vger.kernel.org>; Fri, 12 Dec 2025 04:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765514740; cv=none; b=YLS/BOVVKmjAurC5puLc6FBRro1uhnkGtgtbpPJngBOKTU6N+OeXrioDTJBbX6CWccGVCa2u9fmvz7xPHCtM2G0FgPpTvSt3BxH1ia7vaEezt8hWEdAyI7PPzK8NOGQbULfpTeCcs3gtu5kZTDrQ03ogVOZHHRmWQNCIqRnb4s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765514740; c=relaxed/simple;
	bh=aWtPiAeSpEpIga2c7GafYczfwjIrymeK2znpWwSld8g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DISOT2CjA/GpAEiFtJLNAS/c2IIlSD8HJEFTpuToCtkn8duwy6w2cCtgf3TB2lQkslPjAgAlyfXvJ1bkhxRXyjOlsz56NmGFCBtPGbgHog2bLl+jKrlG1UXnxQMOBAZ4ioY89eWWzhqk3JISL2yjcP26P/z9d9iFU3Rw1ocyGzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i72GuM2l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C810C4CEF1;
	Fri, 12 Dec 2025 04:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765514740;
	bh=aWtPiAeSpEpIga2c7GafYczfwjIrymeK2znpWwSld8g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i72GuM2llnpaAHKFbrZ1Xb6jEHYryJkXY0eBg5uPPU/nrINMJD1oeCgOiBoYE5e2I
	 YWRAu5AOx2GuOBoI52eat3Ek5ASKZVJ7rzc70bqUCfLxyMDpwuKiIfTAdhIMF0GgC0
	 GFwGpLAGcqS+BMbr7qwdUOQlmxukQFSsNOCIhQ4O4zN0/kvd1e2iFWI6Yj1riUtsgK
	 TvEnDceOSPqXs4utP5p5WK4PnPmrQaCd+/Uv04XcyPLzkJYpLkVrt0ySH4VVg++66Y
	 B0+NJ/HC1NMz6sMz0U3EGPSIbd9TJL0tRcdDw2Z1elbZH4A6ff7pGGbqu4u9VTS1WW
	 IGlRWGz3CHn6Q==
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
Subject: [PATCH bpf-next v5 2/4] bpf: arena: use kmalloc_nolock() in place of kvcalloc()
Date: Fri, 12 Dec 2025 13:45:12 +0900
Message-ID: <20251212044516.37513-3-puranjay@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251212044516.37513-1-puranjay@kernel.org>
References: <20251212044516.37513-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To make arena_alloc_pages() safe to be called from any context, replace
kvcalloc() with kmalloc_nolock() so as it doesn't sleep or take any
locks. kmalloc_nolock() returns NULL for allocations larger than
KMALLOC_MAX_CACHE_SIZE, which is (PAGE_SIZE * 2) = 8KB on systems with
4KB pages. So, round down the allocation done by kmalloc_nolock to 1024
* 8 and reuse the array in a loop.

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 kernel/bpf/arena.c | 80 ++++++++++++++++++++++++++++++----------------
 1 file changed, 53 insertions(+), 27 deletions(-)

diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
index dd07268b67d4..17ea0525978e 100644
--- a/kernel/bpf/arena.c
+++ b/kernel/bpf/arena.c
@@ -43,6 +43,8 @@
 #define GUARD_SZ round_up(1ull << sizeof_field(struct bpf_insn, off) * 8, PAGE_SIZE << 1)
 #define KERN_VM_SZ (SZ_4G + GUARD_SZ)
 
+static void arena_free_pages(struct bpf_arena *arena, long uaddr, long page_cnt);
+
 struct bpf_arena {
 	struct bpf_map map;
 	u64 user_vm_start;
@@ -493,8 +495,10 @@ static long arena_alloc_pages(struct bpf_arena *arena, long uaddr, long page_cnt
 	/* user_vm_end/start are fixed before bpf prog runs */
 	long page_cnt_max = (arena->user_vm_end - arena->user_vm_start) >> PAGE_SHIFT;
 	u64 kern_vm_start = bpf_arena_get_kern_vm_start(arena);
+	struct apply_range_data data;
 	struct page **pages = NULL;
-	long mapped = 0;
+	long remaining, mapped = 0;
+	long alloc_pages;
 	long pgoff = 0;
 	u32 uaddr32;
 	int ret, i;
@@ -511,17 +515,19 @@ static long arena_alloc_pages(struct bpf_arena *arena, long uaddr, long page_cnt
 			return 0;
 	}
 
-	/* zeroing is needed, since alloc_pages_bulk() only fills in non-zero entries */
-	pages = kvcalloc(page_cnt, sizeof(struct page *), GFP_KERNEL);
+	/* Cap allocation size to KMALLOC_MAX_CACHE_SIZE so kmalloc_nolock() can succeed. */
+	alloc_pages = min(page_cnt, KMALLOC_MAX_CACHE_SIZE / sizeof(struct page *));
+	pages = kmalloc_nolock(alloc_pages * sizeof(struct page *), 0, NUMA_NO_NODE);
 	if (!pages)
 		return 0;
+	data.pages = pages;
 
-	guard(mutex)(&arena->lock);
+	mutex_lock(&arena->lock);
 
 	if (uaddr) {
 		ret = is_range_tree_set(&arena->rt, pgoff, page_cnt);
 		if (ret)
-			goto out_free_pages;
+			goto out_unlock_free_pages;
 		ret = range_tree_clear(&arena->rt, pgoff, page_cnt);
 	} else {
 		ret = pgoff = range_tree_find(&arena->rt, page_cnt);
@@ -529,37 +535,57 @@ static long arena_alloc_pages(struct bpf_arena *arena, long uaddr, long page_cnt
 			ret = range_tree_clear(&arena->rt, pgoff, page_cnt);
 	}
 	if (ret)
-		goto out_free_pages;
-
-	struct apply_range_data data = { .pages = pages, .i = 0 };
-	ret = bpf_map_alloc_pages(&arena->map, node_id, page_cnt, pages);
-	if (ret)
-		goto out;
+		goto out_unlock_free_pages;
 
+	remaining = page_cnt;
 	uaddr32 = (u32)(arena->user_vm_start + pgoff * PAGE_SIZE);
-	/* Earlier checks made sure that uaddr32 + page_cnt * PAGE_SIZE - 1
-	 * will not overflow 32-bit. Lower 32-bit need to represent
-	 * contiguous user address range.
-	 * Map these pages at kern_vm_start base.
-	 * kern_vm_start + uaddr32 + page_cnt * PAGE_SIZE - 1 can overflow
-	 * lower 32-bit and it's ok.
-	 */
-	ret = apply_to_page_range(&init_mm, kern_vm_start + uaddr32,
-				  page_cnt << PAGE_SHIFT, apply_range_set_cb, &data);
-	if (ret) {
-		mapped = data.i
-		for (i = mapped; i < page_cnt; i++)
-			__free_page(pages[i]);
-		goto out;
+
+	while (remaining) {
+		long this_batch = min(remaining, alloc_pages);
+
+		/* zeroing is needed, since alloc_pages_bulk() only fills in non-zero entries */
+		memset(pages, 0, this_batch * sizeof(struct page *));
+
+		ret = bpf_map_alloc_pages(&arena->map, node_id, this_batch, pages);
+		if (ret)
+			goto out;
+
+		/*
+		 * Earlier checks made sure that uaddr32 + page_cnt * PAGE_SIZE - 1
+		 * will not overflow 32-bit. Lower 32-bit need to represent
+		 * contiguous user address range.
+		 * Map these pages at kern_vm_start base.
+		 * kern_vm_start + uaddr32 + page_cnt * PAGE_SIZE - 1 can overflow
+		 * lower 32-bit and it's ok.
+		 */
+		data.i = 0;
+		ret = apply_to_page_range(&init_mm,
+					  kern_vm_start + uaddr32 + (mapped << PAGE_SHIFT),
+					  this_batch << PAGE_SHIFT, apply_range_set_cb, &data);
+		if (ret) {
+			/* data.i pages were mapped, account them and free the remaining */
+			mapped += data.i;
+			for (i = data.i; i < this_batch; i++)
+				__free_page(pages[i]);
+			goto out;
+		}
+
+		mapped += this_batch;
+		remaining -= this_batch;
 	}
-	kvfree(pages);
+	mutex_unlock(&arena->lock);
+	kfree_nolock(pages);
 	return clear_lo32(arena->user_vm_start) + uaddr32;
 out:
 	range_tree_set(&arena->rt, pgoff + mapped, page_cnt - mapped);
+	mutex_unlock(&arena->lock);
 	if (mapped)
 		arena_free_pages(arena, uaddr32, mapped);
+	goto out_free_pages;
+out_unlock_free_pages:
+	mutex_unlock(&arena->lock);
 out_free_pages:
-	kvfree(pages);
+	kfree_nolock(pages);
 	return 0;
 }
 
-- 
2.50.1


