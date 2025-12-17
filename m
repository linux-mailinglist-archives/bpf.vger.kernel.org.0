Return-Path: <bpf+bounces-76900-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 60AA0CC9524
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 19:45:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 78559309C7C5
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 18:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E5BC27B32C;
	Wed, 17 Dec 2025 18:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lBQKrwet"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A19149E17
	for <bpf@vger.kernel.org>; Wed, 17 Dec 2025 18:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765997102; cv=none; b=cLuUtktWWUNGgO/I+bbdzd1oTZaQ0HJG8RJucSW5vAW/3LIdF8NoI17kIu2/8tAFcXtnDvUN2GmhO189m7BkM+23t2+D8S5zhi0cJoliP8djhVzKRraoqKOS1bV7OIdR64yta6oGyPGOc40S0Gz7j7q8VQWi3/Vuy3xwvK9hKr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765997102; c=relaxed/simple;
	bh=1KVkw0pkCoOR9hwStc7EOid+IQ3Z9fplcVeAbvppwYY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eeaWRe2o41qP318+15Q80rbVGd0uX9MqxS8sDeWgMr+mRVfSDcWw1rsOK/l7narO11LXDXOAbGdwYTMBaXcdALmS5JfyPjDK2rbJzYcDZdMYQFTI96qBSqhTOAqjV5U5sSoMhmCHoWFDTPXlnv1zFmVfF4sjVRznTGA9HMBfyUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lBQKrwet; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 288DFC4CEF5;
	Wed, 17 Dec 2025 18:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765997100;
	bh=1KVkw0pkCoOR9hwStc7EOid+IQ3Z9fplcVeAbvppwYY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lBQKrwetmEtSAj2wedhYEN1n0EOkaf8tHGy7E/MWJiFrohkG7dNKPCdt26JN5nMdw
	 LhDfO7SBUCmT8hFZ2y7hM/qcR0ni1FXYPPLjmf7ew/rfIc9Xbg0oTo03+eka+/Ys5Q
	 Rt1NzSF7wzD7roLO4l/VlcUZIPWbcscHaYJY3d9iVDKzE+rI2VcNBqAK1LgGtpRKgw
	 VDLmTWicUH5hJ7zpUTPYIneLLPMWBNfqwfk4ysyd5E16QjtK94fs1zzjD8MTvteJKY
	 ACw2Zlyx1iKjRMjihWpSMlI9MR2f9nUwgp9mlxv3bwPb5AOUVgh4wfr8bnAeW/h9S9
	 RdxhoiBVv+iDQ==
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
Subject: [PATCH bpf-next v6 2/4] bpf: arena: use kmalloc_nolock() in place of kvcalloc()
Date: Wed, 17 Dec 2025 10:44:33 -0800
Message-ID: <20251217184438.3557859-3-puranjay@kernel.org>
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
index 039f25fc074b..9409ca7ccc4e 100644
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
-		mapped = data.i;
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
2.47.3


