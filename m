Return-Path: <bpf+bounces-42972-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BAB349AD89D
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 01:48:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D46771C21699
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 23:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78AF61E0087;
	Wed, 23 Oct 2024 23:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CY8An2Pn"
X-Original-To: bpf@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF7B1FDFB6
	for <bpf@vger.kernel.org>; Wed, 23 Oct 2024 23:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729727319; cv=none; b=Fddv/18fCaKnp2ghbHxJ/8+nJTebivjescUUU3nQmpZDCWTtO+NsQG6ymNVCQeb/kxQCe7xXFWVEPy0811bjKXwXOCzF+8QmI8SorU192x70sSXw+25UC46FRoxyAd5H5pbgOXsqWsl3hIwoXfZOiMAV9AuEej9hy86lY3ts6js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729727319; c=relaxed/simple;
	bh=uvnsDwT3q4ClZooaE2lNmYRjYcNNU6gKDzqG4ASmDKo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gKxYXTKqNb5cOoG4AGrDgbw7MZvY5HhSuBwmr2m3+sQQ39gbd0wD9FVa9MYRUcb4/jOGlLnO/PuDqNDWnyQxXFcZmJTE8fKVx/P2rJku6pOvKwi2lSo1SzPv9OBJjWIdaLNYtr/4Y0DouAtvKEw7crTBr88i+Ws677k1ggmDKGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CY8An2Pn; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729727314;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WP4DDQubYzzZl7wnh1q7E8loRaUCjPHg66/vzn/GFH8=;
	b=CY8An2PnnyRD6jfKQL8Z/oGwV1k8TwjxenAIWjARCF8iVArOiVY0EUNU7SBpqb0G1CbYjW
	udlPjsUZ8t7EAwVn7uM+jt0mR2P8d8EDITT/5Qpl4DJ/9GVndg55GvazVQpQdckprmnwN8
	ofl1+AL3T7kdI4ckRGFW3KBHJJsveuI=
From: Martin KaFai Lau <martin.lau@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Kui-Feng Lee <thinker.li@gmail.com>,
	kernel-team@meta.com
Subject: [PATCH v6 bpf-next 04/12] bpf: Postpone bpf_selem_free() in bpf_selem_unlink_storage_nolock()
Date: Wed, 23 Oct 2024 16:47:51 -0700
Message-ID: <20241023234759.860539-5-martin.lau@linux.dev>
In-Reply-To: <20241023234759.860539-1-martin.lau@linux.dev>
References: <20241023234759.860539-1-martin.lau@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Martin KaFai Lau <martin.lau@kernel.org>

In a later patch, bpf_selem_free() will call unpin_user_page()
through bpf_obj_free_fields(). unpin_user_page() may take spin_lock.
However, some bpf_selem_free() call paths have held a raw_spin_lock.
Like this:

raw_spin_lock_irqsave()
  bpf_selem_unlink_storage_nolock()
    bpf_selem_free()
      unpin_user_page()
        spin_lock()

To avoid spinlock nested in raw_spinlock, bpf_selem_free() should be
done after releasing the raw_spinlock. The "bool reuse_now" arg is
replaced with "struct hlist_head *free_selem_list" in
bpf_selem_unlink_storage_nolock(). The bpf_selem_unlink_storage_nolock()
will append the to-be-free selem at the free_selem_list. The caller of
bpf_selem_unlink_storage_nolock() will need to call the new
bpf_selem_free_list(free_selem_list, reuse_now) to free the selem
after releasing the raw_spinlock.

Note that the selem->snode cannot be reused for linking to
the free_selem_list because the selem->snode is protected by the
raw_spinlock that we want to avoid holding. A new
"struct hlist_node free_node;" is union-ized with
the rcu_head. Only the first one successfully
hlist_del_init_rcu(&selem->snode) will be able
to use the free_node. After succeeding hlist_del_init_rcu(&selem->snode),
the free_node and rcu_head usage is serialized such that they
can share the 16 bytes in a union.

Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
---
 include/linux/bpf_local_storage.h |  8 ++++++-
 kernel/bpf/bpf_local_storage.c    | 35 ++++++++++++++++++++++++++-----
 2 files changed, 37 insertions(+), 6 deletions(-)

diff --git a/include/linux/bpf_local_storage.h b/include/linux/bpf_local_storage.h
index 0c7216c065d5..ab7244d8108f 100644
--- a/include/linux/bpf_local_storage.h
+++ b/include/linux/bpf_local_storage.h
@@ -77,7 +77,13 @@ struct bpf_local_storage_elem {
 	struct hlist_node map_node;	/* Linked to bpf_local_storage_map */
 	struct hlist_node snode;	/* Linked to bpf_local_storage */
 	struct bpf_local_storage __rcu *local_storage;
-	struct rcu_head rcu;
+	union {
+		struct rcu_head rcu;
+		struct hlist_node free_node;	/* used to postpone
+						 * bpf_selem_free
+						 * after raw_spin_unlock
+						 */
+	};
 	/* 8 bytes hole */
 	/* The data is stored in another cacheline to minimize
 	 * the number of cachelines access during a cache hit.
diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
index 1cf772cb26eb..09a67dff2336 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -246,13 +246,30 @@ void bpf_selem_free(struct bpf_local_storage_elem *selem,
 	}
 }
 
+static void bpf_selem_free_list(struct hlist_head *list, bool reuse_now)
+{
+	struct bpf_local_storage_elem *selem;
+	struct bpf_local_storage_map *smap;
+	struct hlist_node *n;
+
+	/* The "_safe" iteration is needed.
+	 * The loop is not removing the selem from the list
+	 * but bpf_selem_free will use the selem->rcu_head
+	 * which is union-ized with the selem->free_node.
+	 */
+	hlist_for_each_entry_safe(selem, n, list, free_node) {
+		smap = rcu_dereference_check(SDATA(selem)->smap, bpf_rcu_lock_held());
+		bpf_selem_free(selem, smap, reuse_now);
+	}
+}
+
 /* local_storage->lock must be held and selem->local_storage == local_storage.
  * The caller must ensure selem->smap is still valid to be
  * dereferenced for its smap->elem_size and smap->cache_idx.
  */
 static bool bpf_selem_unlink_storage_nolock(struct bpf_local_storage *local_storage,
 					    struct bpf_local_storage_elem *selem,
-					    bool uncharge_mem, bool reuse_now)
+					    bool uncharge_mem, struct hlist_head *free_selem_list)
 {
 	struct bpf_local_storage_map *smap;
 	bool free_local_storage;
@@ -296,7 +313,7 @@ static bool bpf_selem_unlink_storage_nolock(struct bpf_local_storage *local_stor
 	    SDATA(selem))
 		RCU_INIT_POINTER(local_storage->cache[smap->cache_idx], NULL);
 
-	bpf_selem_free(selem, smap, reuse_now);
+	hlist_add_head(&selem->free_node, free_selem_list);
 
 	if (rcu_access_pointer(local_storage->smap) == smap)
 		RCU_INIT_POINTER(local_storage->smap, NULL);
@@ -345,6 +362,7 @@ static void bpf_selem_unlink_storage(struct bpf_local_storage_elem *selem,
 	struct bpf_local_storage_map *storage_smap;
 	struct bpf_local_storage *local_storage;
 	bool bpf_ma, free_local_storage = false;
+	HLIST_HEAD(selem_free_list);
 	unsigned long flags;
 
 	if (unlikely(!selem_linked_to_storage_lockless(selem)))
@@ -360,9 +378,11 @@ static void bpf_selem_unlink_storage(struct bpf_local_storage_elem *selem,
 	raw_spin_lock_irqsave(&local_storage->lock, flags);
 	if (likely(selem_linked_to_storage(selem)))
 		free_local_storage = bpf_selem_unlink_storage_nolock(
-			local_storage, selem, true, reuse_now);
+			local_storage, selem, true, &selem_free_list);
 	raw_spin_unlock_irqrestore(&local_storage->lock, flags);
 
+	bpf_selem_free_list(&selem_free_list, reuse_now);
+
 	if (free_local_storage)
 		bpf_local_storage_free(local_storage, storage_smap, bpf_ma, reuse_now);
 }
@@ -529,6 +549,7 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
 	struct bpf_local_storage_data *old_sdata = NULL;
 	struct bpf_local_storage_elem *alloc_selem, *selem = NULL;
 	struct bpf_local_storage *local_storage;
+	HLIST_HEAD(old_selem_free_list);
 	unsigned long flags;
 	int err;
 
@@ -624,11 +645,12 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
 	if (old_sdata) {
 		bpf_selem_unlink_map(SELEM(old_sdata));
 		bpf_selem_unlink_storage_nolock(local_storage, SELEM(old_sdata),
-						true, false);
+						true, &old_selem_free_list);
 	}
 
 unlock:
 	raw_spin_unlock_irqrestore(&local_storage->lock, flags);
+	bpf_selem_free_list(&old_selem_free_list, false);
 	if (alloc_selem) {
 		mem_uncharge(smap, owner, smap->elem_size);
 		bpf_selem_free(alloc_selem, smap, true);
@@ -706,6 +728,7 @@ void bpf_local_storage_destroy(struct bpf_local_storage *local_storage)
 	struct bpf_local_storage_map *storage_smap;
 	struct bpf_local_storage_elem *selem;
 	bool bpf_ma, free_storage = false;
+	HLIST_HEAD(free_selem_list);
 	struct hlist_node *n;
 	unsigned long flags;
 
@@ -734,10 +757,12 @@ void bpf_local_storage_destroy(struct bpf_local_storage *local_storage)
 		 * of the loop will set the free_cgroup_storage to true.
 		 */
 		free_storage = bpf_selem_unlink_storage_nolock(
-			local_storage, selem, true, true);
+			local_storage, selem, true, &free_selem_list);
 	}
 	raw_spin_unlock_irqrestore(&local_storage->lock, flags);
 
+	bpf_selem_free_list(&free_selem_list, true);
+
 	if (free_storage)
 		bpf_local_storage_free(local_storage, storage_smap, bpf_ma, true);
 }
-- 
2.43.5


