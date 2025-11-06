Return-Path: <bpf+bounces-73869-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D265EC3C7BB
	for <lists+bpf@lfdr.de>; Thu, 06 Nov 2025 17:37:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5DFA1881251
	for <lists+bpf@lfdr.de>; Thu,  6 Nov 2025 16:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA3FE32BF47;
	Thu,  6 Nov 2025 16:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QsuX6rUu"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600D02D6E53
	for <bpf@vger.kernel.org>; Thu,  6 Nov 2025 16:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762446588; cv=none; b=kF0hXdhCzpqnLL2W6swIIgT7y5/UWstM0En94NHm8zw81inb/+uAaOqAita6WEL90NIGr/yI6Jyhon/SatRLEkiLi1C/NhMT6Nm/sjI2FgiPik0wm6Xz7H+v8Dbqvrl2XChPHWHmVLGce3Ii3Me0CWAo6vA7t5/zU3rYaERw+q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762446588; c=relaxed/simple;
	bh=/dUPlG3RpKDPtW/7BLcXYyzTvXNi5mEHR+V3SKgTaWg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nfwlydGwwJKOIyqxpbSUFmlRN2W+TBqKhUVjHzXQRciP0OYGeLluV6OisNrPYLDUPdm1PURZKzfde9ErrPwh79PUmRymNYOSPEHiOxLJmjkmlaw69tfTFIwgr0c8aB694dnR51K0ixKsiUezvc0gMQXO9xiy6jNhUrkN6eWEp34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QsuX6rUu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D75AC116B1;
	Thu,  6 Nov 2025 16:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762446587;
	bh=/dUPlG3RpKDPtW/7BLcXYyzTvXNi5mEHR+V3SKgTaWg=;
	h=From:To:Cc:Subject:Date:From;
	b=QsuX6rUuH/MieIGnZcZ8a8cfZ09IA7EsB64uCZ36DCMcLaf+MGmV5rVm0HKukgLuk
	 DA6+DkPdJ3MU8/4Gjk8kNCa1OVNOrxa3+0xXUsQfQSGbxko9JBKBNIaQYtxtzQ/M48
	 beZdb5NqV6ctZx3BMt/TiwtuwXrwao8cAilKuWqwN5WiyLlQB2w056995X37EqE5CX
	 87zSKr4gHAwhEbWmxL9RFzgYFCLdhoGP/1kFXn0g5TDhCBQkJ8fDH2/wq3g0uxNMzh
	 9ujYmPqjMER9EILo900cc46OKwuGhyLjgHq7UTScBT2fwxj1WhN+qz6jSWO8j3hxwM
	 CPzTfsTThQa2A==
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
Subject: [PATCH bpf-next] bpf: Use kmalloc_nolock() in range tree
Date: Thu,  6 Nov 2025 16:29:33 +0000
Message-ID: <20251106162935.7146-1-puranjay@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The range tree uses bpf_mem_alloc() that is safe to be called from all
contexts and uses a pre-allocated pool of memory to serve these
allocations.

Replace bpf_mem_alloc() with kmalloc_nolock() as it can be called safely
from all contexts and is more scalable than bpf_mem_alloc().

Remove the migrate_disable/enable pairs as they were only needed for
bpf_mem_alloc() as it does per-cpu operations, kmalloc_nolock() doesn't
need this.

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 kernel/bpf/range_tree.c | 22 +++++++---------------
 1 file changed, 7 insertions(+), 15 deletions(-)

diff --git a/kernel/bpf/range_tree.c b/kernel/bpf/range_tree.c
index 37b80a23ae1a..2f28886f3ff7 100644
--- a/kernel/bpf/range_tree.c
+++ b/kernel/bpf/range_tree.c
@@ -2,7 +2,6 @@
 /* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
 #include <linux/interval_tree_generic.h>
 #include <linux/slab.h>
-#include <linux/bpf_mem_alloc.h>
 #include <linux/bpf.h>
 #include "range_tree.h"
 
@@ -21,7 +20,7 @@
  * in commit 6772fcc8890a ("xfs: convert xbitmap to interval tree").
  *
  * The implementation relies on external lock to protect rbtree-s.
- * The alloc/free of range_node-s is done via bpf_mem_alloc.
+ * The alloc/free of range_node-s is done via kmalloc_nolock().
  *
  * bpf arena is using range_tree to represent unallocated slots.
  * At init time:
@@ -150,9 +149,8 @@ int range_tree_clear(struct range_tree *rt, u32 start, u32 len)
 			range_it_insert(rn, rt);
 
 			/* Add a range */
-			migrate_disable();
-			new_rn = bpf_mem_alloc(&bpf_global_ma, sizeof(struct range_node));
-			migrate_enable();
+			new_rn = kmalloc_nolock(sizeof(struct range_node), __GFP_ACCOUNT,
+						NUMA_NO_NODE);
 			if (!new_rn)
 				return -ENOMEM;
 			new_rn->rn_start = last + 1;
@@ -172,9 +170,7 @@ int range_tree_clear(struct range_tree *rt, u32 start, u32 len)
 		} else {
 			/* in the middle of the clearing range */
 			range_it_remove(rn, rt);
-			migrate_disable();
-			bpf_mem_free(&bpf_global_ma, rn);
-			migrate_enable();
+			kfree_nolock(rn);
 		}
 	}
 	return 0;
@@ -227,9 +223,7 @@ int range_tree_set(struct range_tree *rt, u32 start, u32 len)
 		range_it_remove(right, rt);
 		left->rn_last = right->rn_last;
 		range_it_insert(left, rt);
-		migrate_disable();
-		bpf_mem_free(&bpf_global_ma, right);
-		migrate_enable();
+		kfree_nolock(right);
 	} else if (left) {
 		/* Combine with the left range */
 		range_it_remove(left, rt);
@@ -241,9 +235,7 @@ int range_tree_set(struct range_tree *rt, u32 start, u32 len)
 		right->rn_start = start;
 		range_it_insert(right, rt);
 	} else {
-		migrate_disable();
-		left = bpf_mem_alloc(&bpf_global_ma, sizeof(struct range_node));
-		migrate_enable();
+		left = kmalloc_nolock(sizeof(struct range_node), __GFP_ACCOUNT, NUMA_NO_NODE);
 		if (!left)
 			return -ENOMEM;
 		left->rn_start = start;
@@ -259,7 +251,7 @@ void range_tree_destroy(struct range_tree *rt)
 
 	while ((rn = range_it_iter_first(rt, 0, -1U))) {
 		range_it_remove(rn, rt);
-		bpf_mem_free(&bpf_global_ma, rn);
+		kfree_nolock(rn);
 	}
 }
 
-- 
2.47.3


