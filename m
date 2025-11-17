Return-Path: <bpf+bounces-74750-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B73DC6509A
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 17:06:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id C9FB628FE4
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 16:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B3BF29B781;
	Mon, 17 Nov 2025 16:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qSQ1MhI4"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5BE225524C
	for <bpf@vger.kernel.org>; Mon, 17 Nov 2025 16:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763395586; cv=none; b=sNBegQdc2DOmOc23VcDdcLqOuc4L9LHqExhVioq3fEjJ0mKaLkgDFJYOrI7Ke+Tzfp7UQOmR8zkwh63ude9TrA8P54i31Jh+4JqSfnFO7ghSYaMrpSM1yNr/poQfYoQQk1Zbw7Fp+k7LhH7+0R1ly8p7lDBg+QIzf99ALGXOHjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763395586; c=relaxed/simple;
	bh=TlPByTT6VZPJ/oefWYh018/H/YtYmUmYg3N8KwxVhI8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hJAtKzUV0SwrpeX0D35T6uynyFKGmh7avlzi8hTiM5w33hRtktq/a06wliXD9wqfbpRv01UfspvmVf4ddb8lu/CySuEmrEPIR7Qn9S0dN4WARVqrubqiXuigRWcEAu6zBhzgbCYB3+Xcta0x8L7ssv+n5hGvUub8F5+UwosSvQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qSQ1MhI4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF435C19421;
	Mon, 17 Nov 2025 16:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763395586;
	bh=TlPByTT6VZPJ/oefWYh018/H/YtYmUmYg3N8KwxVhI8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qSQ1MhI4KMfEWNnmUcHf37NTl+p3lQXS3iLFn5/9AZcSRQ7sfrzJCLuqV1IOF7Uwo
	 FV+2Nt4oGo60bq4gGx41LiQquxkOP9/IjxpmdKw/TjElFpa9AQRZJTgo0DIp8KbAWQ
	 usTDbmyCPEe6Z6rqAiYUdITWaeFOIHXtcb97+dP8Odr4X3P9U3sogVmre9m2laO05l
	 FPP7Sl//Rs9pY+/yfeciFB1Y3Ezj04pAn70xSvHbYTQ+Z5ZnHLbTZDtLGl0/R9UxDr
	 /PR5u1GeG5xS9eWXNoLD+A8GNUf2a7zjalWGXik2R/sIPuRgDeUowzeG510K7GVIgf
	 a+JNz21eQs1Aw==
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
Subject: [PATCH bpf-next v3 2/4] bpf: arena: use kmalloc_nolock() in place of kvcalloc()
Date: Mon, 17 Nov 2025 16:06:15 +0000
Message-ID: <20251117160617.4604-1-puranjay@kernel.org>
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

To make arena_alloc_pages() safe to be called from any context, replace
kvcalloc() with kmalloc_nolock() so as it doesn't sleep or take any
locks. kmalloc_nolock() returns NULL for allocations larger than
KMALLOC_MAX_CACHE_SIZE, which is (PAGE_SIZE * 2) = 8KB on systems with
4KB pages. So, round down the allocation done by kmalloc_nolock to 1024
* 8 and reuse the array in a loop.

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 kernel/bpf/arena.c | 83 +++++++++++++++++++++++++++++++---------------
 1 file changed, 57 insertions(+), 26 deletions(-)

diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
index 214a4da54162..1d0b49a39ad0 100644
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
@@ -492,7 +494,10 @@ static long arena_alloc_pages(struct bpf_arena *arena, long uaddr, long page_cnt
 	/* user_vm_end/start are fixed before bpf prog runs */
 	long page_cnt_max = (arena->user_vm_end - arena->user_vm_start) >> PAGE_SHIFT;
 	u64 kern_vm_start = bpf_arena_get_kern_vm_start(arena);
+	struct apply_range_data data;
 	struct page **pages = NULL;
+	long remaining, mapped = 0;
+	long alloc_pages;
 	long pgoff = 0;
 	u32 uaddr32;
 	int ret, i;
@@ -509,17 +514,21 @@ static long arena_alloc_pages(struct bpf_arena *arena, long uaddr, long page_cnt
 			return 0;
 	}
 
-	/* zeroing is needed, since alloc_pages_bulk() only fills in non-zero entries */
-	pages = kvcalloc(page_cnt, sizeof(struct page *), GFP_KERNEL);
+	/*
+	 * Cap allocation size to KMALLOC_MAX_CACHE_SIZE so kmalloc_nolock() can succeed.
+	 */
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
@@ -527,34 +536,56 @@ static long arena_alloc_pages(struct bpf_arena *arena, long uaddr, long page_cnt
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
-		for (i = 0; i < page_cnt; i++)
-			__free_page(pages[i]);
-		goto out;
+
+	while (remaining) {
+		long this_batch = min(remaining, alloc_pages);
+
+		/* zeroing is needed, since alloc_pages_bulk() only fills in non-zero entries */
+		memset(pages, 0, this_batch * sizeof(struct page *));
+		data.i = 0;
+
+		ret = bpf_map_alloc_pages(&arena->map, node_id, this_batch, pages);
+		if (ret)
+			goto out;
+
+		/* Earlier checks made sure that uaddr32 + page_cnt * PAGE_SIZE - 1
+		 * will not overflow 32-bit. Lower 32-bit need to represent
+		 * contiguous user address range.
+		 * Map these pages at kern_vm_start base.
+		 * kern_vm_start + uaddr32 + page_cnt * PAGE_SIZE - 1 can overflow
+		 * lower 32-bit and it's ok.
+		 */
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
-	range_tree_set(&arena->rt, pgoff, page_cnt);
+	range_tree_set(&arena->rt, pgoff + mapped, page_cnt - mapped);
+	mutex_unlock(&arena->lock);
+	if (mapped)
+		arena_free_pages(arena, clear_lo32(arena->user_vm_start) + uaddr32, mapped);
+	goto out_free_pages;
+out_unlock_free_pages:
+	mutex_unlock(&arena->lock);
 out_free_pages:
-	kvfree(pages);
+	kfree_nolock(pages);
 	return 0;
 }
 
-- 
2.47.1


