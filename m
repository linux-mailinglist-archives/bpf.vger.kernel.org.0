Return-Path: <bpf+bounces-74507-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id BCFA1C5CD43
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 12:22:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 61A6134181C
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 11:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59061313260;
	Fri, 14 Nov 2025 11:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KdVAhrFy"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5122BE49
	for <bpf@vger.kernel.org>; Fri, 14 Nov 2025 11:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763119040; cv=none; b=nRXf4RJcCc04NXcX7sBxyJOUcDBqA0B01kNnmN5FzLSCHTAcG+5Zd12EExC2cllN1pPRL0DeyzOqPN6Ff7cX6EEace1x2us+qNl/J5p9TMHC56xqtIroiyyI98yNAIrhTpAhq8SKKYfcsLeRdbpRx31b8bux/Os8PhqKvAyH3b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763119040; c=relaxed/simple;
	bh=xkINaQL7eF96dscoLugPyzbmfWscrdmgdO7KVx5Chkg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mZCS3jI8F/PZwoVSFecTNte4hzcSvAb2nwI71G7iwOLmy+/5gRLNkuNrJCOtGaqUWmS+l8+kEYmnxowBYG9PqitZzXhYKvgoha/dalUPDrf16sDI3mBAzOjXQbIh8lrDz7+CCkM9McpUHNd3LKJ/StbJOqzxnklE2mKDIsK5xtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KdVAhrFy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26091C16AAE;
	Fri, 14 Nov 2025 11:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763119040;
	bh=xkINaQL7eF96dscoLugPyzbmfWscrdmgdO7KVx5Chkg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KdVAhrFyz5JCZrIdBr6mtuswzBmZi0KHfTyrt6N7+M8UWg0oVp6NaGC66355pqwf/
	 hqQffIn0Psz+/ByWJAn3OxVfkjHBdHX6rfxo1y8v4PVJzNB+R/YvEO6Hjd/WhBQR/k
	 51JnHJ6+ZYW0Nw6JpLf7kT/1yphE7PldD9CwW367QFPhpg51hAWCMBYqYFafMPvIIn
	 eK9Cd7YVHAgK1q5aEeaVEHrUqyUaQ/UYAh1D4WAnolOZ5VDD/atJZWWOKzHxTohnaj
	 +qEAwXEu5Lp8N3FnqCcvf03N44E9Qf57wo2/Gd1nBMsetX2Pafcw433sCbuQWIQsG1
	 Tmyj93dvat1JA==
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
Subject: [PATCH bpf-next v2 2/4] bpf: arena: use kmalloc_nolock() in place of kvcalloc()
Date: Fri, 14 Nov 2025 11:16:57 +0000
Message-ID: <20251114111700.43292-3-puranjay@kernel.org>
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

To make arena_alloc_pages() safe to be called from any context, replace
kvcalloc() with kmalloc_nolock() so as it doesn't sleep or take any
locks. kmalloc_nolock() returns NULL for allocations larger than
KMALLOC_MAX_CACHE_SIZE, which is (PAGE_SIZE * 2) = 8KB on systems with
4KB pages. So, round down the allocation done by kmalloc_nolock to 1024
* 8 and reuse the array in a loop.

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 kernel/bpf/arena.c | 76 +++++++++++++++++++++++++++++++---------------
 1 file changed, 52 insertions(+), 24 deletions(-)

diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
index 48b8ffba3c88..7fa6e40ab3fc 100644
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
@@ -491,7 +493,10 @@ static long arena_alloc_pages(struct bpf_arena *arena, long uaddr, long page_cnt
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
@@ -508,12 +513,16 @@ static long arena_alloc_pages(struct bpf_arena *arena, long uaddr, long page_cnt
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
@@ -528,32 +537,51 @@ static long arena_alloc_pages(struct bpf_arena *arena, long uaddr, long page_cnt
 	if (ret)
 		goto out_free_pages;
 
-	struct apply_range_data data = { .pages = pages, .i = 0 };
-	ret = bpf_map_alloc_pages(&arena->map, node_id, page_cnt, pages);
-	if (ret)
-		goto out;
-
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
+	while(remaining) {
+		long this_batch = min(remaining, alloc_pages);
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
 out_free_pages:
-	kvfree(pages);
+	mutex_unlock(&arena->lock);
+	kfree_nolock(pages);
 	return 0;
 }
 
-- 
2.47.1


