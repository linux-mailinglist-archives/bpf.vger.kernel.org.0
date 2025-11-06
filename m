Return-Path: <bpf+bounces-73879-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93060C3CC02
	for <lists+bpf@lfdr.de>; Thu, 06 Nov 2025 18:13:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 810216238EC
	for <lists+bpf@lfdr.de>; Thu,  6 Nov 2025 17:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 992FB34D916;
	Thu,  6 Nov 2025 17:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HLYt649C"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D63634D4E4
	for <bpf@vger.kernel.org>; Thu,  6 Nov 2025 17:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762448774; cv=none; b=c448FtFSlUORH+2sBUrQEJ4+n5PkY1XK2ujlau3ZPvdZZYKwTCQ7qDS/EwXVhCGBugbmlACuailuemWVMFxH3s4cB5tFj8oB3vuNVGuU5BpQybr33ailh/vqyGymh//Hc1/OSaCKrnJ+5JK537WsBxsLG//v8DvaECuxkA88uzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762448774; c=relaxed/simple;
	bh=zrVWFMOveOpOBH8T0jjvVnKwE6OumjgBH9Aqs8HtwJc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TRGwVit69VUm8kakB634rFWTnYEZzHxupkfWgdq7rqA9DBeQ8s0a8GwWhlP9MHfzAxEHWS8bXscnI2JeY9NVD7JzBG3QfW7jSjev1QAqLecYSnSl49jjjH9zrQvg6wQGP3FK/sO1dQVolcgSsx5ynyR6xcm+/RwX/G4ZzkpyIGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HLYt649C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A9A9C4CEF7;
	Thu,  6 Nov 2025 17:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762448773;
	bh=zrVWFMOveOpOBH8T0jjvVnKwE6OumjgBH9Aqs8HtwJc=;
	h=From:To:Cc:Subject:Date:From;
	b=HLYt649CV3g2e6tgNkUKHtSGThJ0+mhCYDeMIar5/VA8llB8cKigzaX92KLWraBoL
	 pzYJ6bjUb4GVdQ+HtpEaP7OhkoQ8Ga3GOcj7Q/7LW5dsSHX94TYTpzu8mLqI4jkctE
	 bZkjl4pHqUIhLLim+LhrkAEE4cnSMmqNFiGIcsus/0uQ4mZSU+t6EQVZZujBYeD11/
	 qg0wWC3z4q/CHT+r4oec3Ezce7qdPSFLSvh4sldELcRLJfDRpn4MqTTBrXU8n7AHZu
	 INIl5+NOSW1b5TCfXd7/oNffqz7kixAM/hZ/oumSa7wIhUQn2fdt7lRRmhPSvkX+go
	 RRF0g8RgunAGw==
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
Subject: [PATCH bpf-next v2] bpf: Use kmalloc_nolock() in range tree
Date: Thu,  6 Nov 2025 17:06:07 +0000
Message-ID: <20251106170608.4800-1-puranjay@kernel.org>
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

v1: https://lore.kernel.org/all/20251106162935.7146-1-puranjay@kernel.org/
Changes in v1->v2:
- Drop __GFP_ACCOUNT from kmalloc_nolock();

---
 kernel/bpf/range_tree.c | 21 ++++++---------------
 1 file changed, 6 insertions(+), 15 deletions(-)

diff --git a/kernel/bpf/range_tree.c b/kernel/bpf/range_tree.c
index 37b80a23ae1a..99c63d982c5d 100644
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
@@ -150,9 +149,7 @@ int range_tree_clear(struct range_tree *rt, u32 start, u32 len)
 			range_it_insert(rn, rt);
 
 			/* Add a range */
-			migrate_disable();
-			new_rn = bpf_mem_alloc(&bpf_global_ma, sizeof(struct range_node));
-			migrate_enable();
+			new_rn = kmalloc_nolock(sizeof(struct range_node), 0, NUMA_NO_NODE);
 			if (!new_rn)
 				return -ENOMEM;
 			new_rn->rn_start = last + 1;
@@ -172,9 +169,7 @@ int range_tree_clear(struct range_tree *rt, u32 start, u32 len)
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
@@ -227,9 +222,7 @@ int range_tree_set(struct range_tree *rt, u32 start, u32 len)
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
@@ -241,9 +234,7 @@ int range_tree_set(struct range_tree *rt, u32 start, u32 len)
 		right->rn_start = start;
 		range_it_insert(right, rt);
 	} else {
-		migrate_disable();
-		left = bpf_mem_alloc(&bpf_global_ma, sizeof(struct range_node));
-		migrate_enable();
+		left = kmalloc_nolock(sizeof(struct range_node), 0, NUMA_NO_NODE);
 		if (!left)
 			return -ENOMEM;
 		left->rn_start = start;
@@ -259,7 +250,7 @@ void range_tree_destroy(struct range_tree *rt)
 
 	while ((rn = range_it_iter_first(rt, 0, -1U))) {
 		range_it_remove(rn, rt);
-		bpf_mem_free(&bpf_global_ma, rn);
+		kfree_nolock(rn);
 	}
 }
 
-- 
2.47.3


