Return-Path: <bpf+bounces-77302-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A2B60CD6EF2
	for <lists+bpf@lfdr.de>; Mon, 22 Dec 2025 20:08:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 78B4E3009F55
	for <lists+bpf@lfdr.de>; Mon, 22 Dec 2025 19:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E4BB33B6E1;
	Mon, 22 Dec 2025 19:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ww0+FmWK"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C29433A9D7
	for <bpf@vger.kernel.org>; Mon, 22 Dec 2025 19:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766430531; cv=none; b=UO3iUXfestFSCrEuazuMlFVzWbXcDMmfy+wMomh4JLkT1entLweIhUCD5oP98mrcquMAFfMKCJI+55M+OIGZ1osMcvLQdaVU0I5Diyn1Db22llUxHLIUsoflN0yfzxzSZXQ1a3ZFR/aL5zgshfGz9P/5hUC07KXecrzIRDlkm+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766430531; c=relaxed/simple;
	bh=XawsIHeKa3hT/S108nqIXWjGKCSB9raEe34lEPfzM7w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A2AX8eAjP/lDF7+y/fTZ6i5uBsPyOzBcFjlBzp4q36IYXaWTl2GzzRF041NqryNN2rZ2jErTNflE61yivV8LNrHslvkXnszaTNChzsTY8grvJnQqQq0zTCl9poKAzmwSRxCz/Sv/Gg7wNzcwjrzQ8StpmtFXP5BcampB0MRb8Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ww0+FmWK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BECAC4CEF1;
	Mon, 22 Dec 2025 19:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766430530;
	bh=XawsIHeKa3hT/S108nqIXWjGKCSB9raEe34lEPfzM7w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ww0+FmWKrqDqo37Q2L1QL7jQYF3INv4gCDp6dQOs0idSXeCaLlFjZkTU+6I+XgmnX
	 va+VqNjD/SGnM1/FxAHH+sgdiC3UwNh0TtabOb9w7NPTdtqSMlfb0m2ydyBee7K/KW
	 1GXuEPeXn1D0DFmYQpBTgRAXjB2XvWRQlNOHIMaw+UUk9r4HHaa7DhqfoFGKfMjaq5
	 c0UZmT78RQJBMiwYfObAm2xQAzMVr8qXo5vmvaVDaegEWWwKUBDqYIY8YOEJWHC6ok
	 ARuGpvTAFbUe0X6x5Pb9L1a3Vq/GffG86K7hvcTcs22aKkKDPUp1XPXufUuTcV62hA
	 s1Rm0kOj9+K1w==
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
Subject: [PATCH bpf-next v7 2/4] bpf: arena: use kmalloc_nolock() in place of kvcalloc()
Date: Mon, 22 Dec 2025 11:08:09 -0800
Message-ID: <20251222190815.4112944-3-puranjay@kernel.org>
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

To make arena_alloc_pages() safe to be called from any context, replace
kvcalloc() with kmalloc_nolock() so as it doesn't sleep or take any
locks. kmalloc_nolock() returns NULL for allocations larger than
KMALLOC_MAX_CACHE_SIZE, which is (PAGE_SIZE * 2) = 8KB on systems with
4KB pages. So, round down the allocation done by kmalloc_nolock to 1024
* 8 and reuse the array in a loop.

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 kernel/bpf/arena.c | 84 ++++++++++++++++++++++++++++++----------------
 1 file changed, 55 insertions(+), 29 deletions(-)

diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
index 55b198b9f1a3..128efb68d47b 100644
--- a/kernel/bpf/arena.c
+++ b/kernel/bpf/arena.c
@@ -44,6 +44,8 @@
 #define GUARD_SZ round_up(1ull << sizeof_field(struct bpf_insn, off) * 8, PAGE_SIZE << 1)
 #define KERN_VM_SZ (SZ_4G + GUARD_SZ)
 
+static void arena_free_pages(struct bpf_arena *arena, long uaddr, long page_cnt);
+
 struct bpf_arena {
 	struct bpf_map map;
 	u64 user_vm_start;
@@ -500,8 +502,10 @@ static long arena_alloc_pages(struct bpf_arena *arena, long uaddr, long page_cnt
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
@@ -518,17 +522,19 @@ static long arena_alloc_pages(struct bpf_arena *arena, long uaddr, long page_cnt
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
 
 	mutex_lock(&arena->lock);
 
 	if (uaddr) {
 		ret = is_range_tree_set(&arena->rt, pgoff, page_cnt);
 		if (ret)
-			goto out_free_pages;
+			goto out_unlock_free_pages;
 		ret = range_tree_clear(&arena->rt, pgoff, page_cnt);
 	} else {
 		ret = pgoff = range_tree_find(&arena->rt, page_cnt);
@@ -536,40 +542,60 @@ static long arena_alloc_pages(struct bpf_arena *arena, long uaddr, long page_cnt
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
-	apply_to_page_range(&init_mm, kern_vm_start + uaddr32,
-			    page_cnt << PAGE_SHIFT, apply_range_set_cb, &data);
-	mapped = data.i;
-	flush_vmap_cache(kern_vm_start + uaddr32, mapped << PAGE_SHIFT);
-	if (mapped < page_cnt) {
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
+	flush_vmap_cache(kern_vm_start + uaddr32, mapped << PAGE_SHIFT);
 	mutex_unlock(&arena->lock);
-	kvfree(pages);
+	kfree_nolock(pages);
 	return clear_lo32(arena->user_vm_start) + uaddr32;
 out:
 	range_tree_set(&arena->rt, pgoff + mapped, page_cnt - mapped);
-out_free_pages:
 	mutex_unlock(&arena->lock);
-	if (mapped)
+	if (mapped) {
+		flush_vmap_cache(kern_vm_start + uaddr32, mapped << PAGE_SHIFT);
 		arena_free_pages(arena, uaddr32, mapped);
-	kvfree(pages);
+	}
+	goto out_free_pages;
+out_unlock_free_pages:
+	mutex_unlock(&arena->lock);
+out_free_pages:
+	kfree_nolock(pages);
 	return 0;
 }
 
-- 
2.47.3


