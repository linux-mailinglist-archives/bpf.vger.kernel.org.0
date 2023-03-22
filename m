Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D72856C5903
	for <lists+bpf@lfdr.de>; Wed, 22 Mar 2023 22:53:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbjCVVxI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Mar 2023 17:53:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbjCVVxG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Mar 2023 17:53:06 -0400
Received: from out-41.mta0.migadu.com (out-41.mta0.migadu.com [91.218.175.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F301A1B9
        for <bpf@vger.kernel.org>; Wed, 22 Mar 2023 14:53:00 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1679521979;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PzlyeCM47ySU8duDu+NQmGF39gNhQcOYX2NQtxGEBig=;
        b=Lm2BuZZjLos/OYKIapjXtXMa25okSafbTajWlHvYkDklN+Jajqx1LPf/JLJkL88GzNw3ft
        oFAPCLSKvABDWXdyaev0PNlbONXCbYdcgYtOcAhDmBNWnLS7HVrXelpUNwEwMA6Htf9cxC
        zLNoubNHgAWIBHM5PTMZ5Xcc8+gGVuw=
From:   Martin KaFai Lau <martin.lau@linux.dev>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@meta.com,
        Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH v3 bpf-next 3/5] bpf: Use bpf_mem_cache_alloc/free for bpf_local_storage
Date:   Wed, 22 Mar 2023 14:52:44 -0700
Message-Id: <20230322215246.1675516-4-martin.lau@linux.dev>
In-Reply-To: <20230322215246.1675516-1-martin.lau@linux.dev>
References: <20230322215246.1675516-1-martin.lau@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Martin KaFai Lau <martin.lau@kernel.org>

This patch uses bpf_mem_cache_alloc/free for allocating and freeing
bpf_local_storage for task and cgroup storage.

The changes are similar to the previous patch. A few things that
worth to mention for bpf_local_storage:

The local_storage is freed when the last selem is deleted.
Before deleting a selem from local_storage, it needs to retrieve the
local_storage->smap because the bpf_selem_unlink_storage_nolock()
may have set it to NULL. Note that local_storage->smap may have
already been NULL when the selem created this local_storage has
been removed. In this case, call_rcu will be used to free the
local_storage.
Also, the bpf_ma (true or false) value is needed before calling
bpf_local_storage_free(). The bpf_ma can either be obtained from
the local_storage->smap (if available) or any of its selem's smap.
A new helper check_storage_bpf_ma() is added to obtain
bpf_ma for a deleting bpf_local_storage.

When bpf_local_storage_alloc getting a reused memory, all
fields are either in the correct values or will be initialized.
'cache[]' must already be all NULLs. 'list' must be empty.
Others will be initialized.

Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
---
 include/linux/bpf_local_storage.h |   1 +
 kernel/bpf/bpf_local_storage.c    | 130 ++++++++++++++++++++++++++----
 2 files changed, 116 insertions(+), 15 deletions(-)

diff --git a/include/linux/bpf_local_storage.h b/include/linux/bpf_local_storage.h
index 30efbcab2798..173ec7f43ed1 100644
--- a/include/linux/bpf_local_storage.h
+++ b/include/linux/bpf_local_storage.h
@@ -57,6 +57,7 @@ struct bpf_local_storage_map {
 	u16 elem_size;
 	u16 cache_idx;
 	struct bpf_mem_alloc selem_ma;
+	struct bpf_mem_alloc storage_ma;
 	bool bpf_ma;
 };
 
diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
index 309ea727a5cb..dab2ff4c99d9 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -111,33 +111,74 @@ bpf_selem_alloc(struct bpf_local_storage_map *smap, void *owner,
 	return NULL;
 }
 
+/* rcu tasks trace callback for bpf_ma == false */
+static void __bpf_local_storage_free_trace_rcu(struct rcu_head *rcu)
+{
+	struct bpf_local_storage *local_storage;
+
+	/* If RCU Tasks Trace grace period implies RCU grace period, do
+	 * kfree(), else do kfree_rcu().
+	 */
+	local_storage = container_of(rcu, struct bpf_local_storage, rcu);
+	if (rcu_trace_implies_rcu_gp())
+		kfree(local_storage);
+	else
+		kfree_rcu(local_storage, rcu);
+}
+
 static void bpf_local_storage_free_rcu(struct rcu_head *rcu)
 {
 	struct bpf_local_storage *local_storage;
 
 	local_storage = container_of(rcu, struct bpf_local_storage, rcu);
-	kfree(local_storage);
+	bpf_mem_cache_raw_free(local_storage);
 }
 
 static void bpf_local_storage_free_trace_rcu(struct rcu_head *rcu)
 {
-	/* If RCU Tasks Trace grace period implies RCU grace period, do
-	 * kfree(), else do kfree_rcu().
-	 */
 	if (rcu_trace_implies_rcu_gp())
 		bpf_local_storage_free_rcu(rcu);
 	else
 		call_rcu(rcu, bpf_local_storage_free_rcu);
 }
 
+/* Handle bpf_ma == false */
+static void __bpf_local_storage_free(struct bpf_local_storage *local_storage,
+				     bool vanilla_rcu)
+{
+	if (vanilla_rcu)
+		kfree_rcu(local_storage, rcu);
+	else
+		call_rcu_tasks_trace(&local_storage->rcu,
+				     __bpf_local_storage_free_trace_rcu);
+}
+
 static void bpf_local_storage_free(struct bpf_local_storage *local_storage,
-				   bool reuse_now)
+				   struct bpf_local_storage_map *smap,
+				   bool bpf_ma, bool reuse_now)
 {
-	if (!reuse_now)
+	if (!bpf_ma) {
+		__bpf_local_storage_free(local_storage, reuse_now);
+		return;
+	}
+
+	if (!reuse_now) {
 		call_rcu_tasks_trace(&local_storage->rcu,
 				     bpf_local_storage_free_trace_rcu);
-	else
+		return;
+	}
+
+	if (smap) {
+		migrate_disable();
+		bpf_mem_cache_free(&smap->storage_ma, local_storage);
+		migrate_enable();
+	} else {
+		/* smap could be NULL if the selem that triggered
+		 * this 'local_storage' creation had been long gone.
+		 * In this case, directly do call_rcu().
+		 */
 		call_rcu(&local_storage->rcu, bpf_local_storage_free_rcu);
+	}
 }
 
 /* rcu tasks trace callback for bpf_ma == false */
@@ -260,11 +301,47 @@ static bool bpf_selem_unlink_storage_nolock(struct bpf_local_storage *local_stor
 	return free_local_storage;
 }
 
+static bool check_storage_bpf_ma(struct bpf_local_storage *local_storage,
+				 struct bpf_local_storage_map *storage_smap,
+				 struct bpf_local_storage_elem *selem)
+{
+
+	struct bpf_local_storage_map *selem_smap;
+
+	/* local_storage->smap may be NULL. If it is, get the bpf_ma
+	 * from any selem in the local_storage->list. The bpf_ma of all
+	 * local_storage and selem should have the same value
+	 * for the same map type.
+	 *
+	 * If the local_storage->list is already empty, the caller will not
+	 * care about the bpf_ma value also because the caller is not
+	 * responsibile to free the local_storage.
+	 */
+
+	if (storage_smap)
+		return storage_smap->bpf_ma;
+
+	if (!selem) {
+		struct hlist_node *n;
+
+		n = rcu_dereference_check(hlist_first_rcu(&local_storage->list),
+					  bpf_rcu_lock_held());
+		if (!n)
+			return false;
+
+		selem = hlist_entry(n, struct bpf_local_storage_elem, snode);
+	}
+	selem_smap = rcu_dereference_check(SDATA(selem)->smap, bpf_rcu_lock_held());
+
+	return selem_smap->bpf_ma;
+}
+
 static void bpf_selem_unlink_storage(struct bpf_local_storage_elem *selem,
 				     bool reuse_now)
 {
+	struct bpf_local_storage_map *storage_smap;
 	struct bpf_local_storage *local_storage;
-	bool free_local_storage = false;
+	bool bpf_ma, free_local_storage = false;
 	unsigned long flags;
 
 	if (unlikely(!selem_linked_to_storage_lockless(selem)))
@@ -273,6 +350,10 @@ static void bpf_selem_unlink_storage(struct bpf_local_storage_elem *selem,
 
 	local_storage = rcu_dereference_check(selem->local_storage,
 					      bpf_rcu_lock_held());
+	storage_smap = rcu_dereference_check(local_storage->smap,
+					     bpf_rcu_lock_held());
+	bpf_ma = check_storage_bpf_ma(local_storage, storage_smap, selem);
+
 	raw_spin_lock_irqsave(&local_storage->lock, flags);
 	if (likely(selem_linked_to_storage(selem)))
 		free_local_storage = bpf_selem_unlink_storage_nolock(
@@ -280,7 +361,7 @@ static void bpf_selem_unlink_storage(struct bpf_local_storage_elem *selem,
 	raw_spin_unlock_irqrestore(&local_storage->lock, flags);
 
 	if (free_local_storage)
-		bpf_local_storage_free(local_storage, reuse_now);
+		bpf_local_storage_free(local_storage, storage_smap, bpf_ma, reuse_now);
 }
 
 void bpf_selem_link_storage_nolock(struct bpf_local_storage *local_storage,
@@ -400,8 +481,15 @@ int bpf_local_storage_alloc(void *owner,
 	if (err)
 		return err;
 
-	storage = bpf_map_kzalloc(&smap->map, sizeof(*storage),
-				  gfp_flags | __GFP_NOWARN);
+	if (smap->bpf_ma) {
+		migrate_disable();
+		storage = bpf_mem_cache_alloc_flags(&smap->storage_ma, gfp_flags);
+		migrate_enable();
+	} else {
+		storage = bpf_map_kzalloc(&smap->map, sizeof(*storage),
+					  gfp_flags | __GFP_NOWARN);
+	}
+
 	if (!storage) {
 		err = -ENOMEM;
 		goto uncharge;
@@ -447,7 +535,7 @@ int bpf_local_storage_alloc(void *owner,
 	return 0;
 
 uncharge:
-	bpf_local_storage_free(storage, true);
+	bpf_local_storage_free(storage, smap, smap->bpf_ma, true);
 	mem_uncharge(smap, owner, sizeof(*storage));
 	return err;
 }
@@ -660,11 +748,15 @@ int bpf_local_storage_map_check_btf(const struct bpf_map *map,
 
 void bpf_local_storage_destroy(struct bpf_local_storage *local_storage)
 {
+	struct bpf_local_storage_map *storage_smap;
 	struct bpf_local_storage_elem *selem;
-	bool free_storage = false;
+	bool bpf_ma, free_storage = false;
 	struct hlist_node *n;
 	unsigned long flags;
 
+	storage_smap = rcu_dereference_check(local_storage->smap, bpf_rcu_lock_held());
+	bpf_ma = check_storage_bpf_ma(local_storage, storage_smap, NULL);
+
 	/* Neither the bpf_prog nor the bpf_map's syscall
 	 * could be modifying the local_storage->list now.
 	 * Thus, no elem can be added to or deleted from the
@@ -692,7 +784,7 @@ void bpf_local_storage_destroy(struct bpf_local_storage *local_storage)
 	raw_spin_unlock_irqrestore(&local_storage->lock, flags);
 
 	if (free_storage)
-		bpf_local_storage_free(local_storage, true);
+		bpf_local_storage_free(local_storage, storage_smap, bpf_ma, true);
 }
 
 u64 bpf_local_storage_map_mem_usage(const struct bpf_map *map)
@@ -755,6 +847,12 @@ bpf_local_storage_map_alloc(union bpf_attr *attr,
 		err = bpf_mem_alloc_init(&smap->selem_ma, smap->elem_size, false);
 		if (err)
 			goto free_smap;
+
+		err = bpf_mem_alloc_init(&smap->storage_ma, sizeof(struct bpf_local_storage), false);
+		if (err) {
+			bpf_mem_alloc_destroy(&smap->selem_ma);
+			goto free_smap;
+		}
 	}
 
 	smap->cache_idx = bpf_local_storage_cache_idx_get(cache);
@@ -829,8 +927,10 @@ void bpf_local_storage_map_free(struct bpf_map *map,
 	 */
 	synchronize_rcu();
 
-	if (smap->bpf_ma)
+	if (smap->bpf_ma) {
 		bpf_mem_alloc_destroy(&smap->selem_ma);
+		bpf_mem_alloc_destroy(&smap->storage_ma);
+	}
 	kvfree(smap->buckets);
 	bpf_map_area_free(smap);
 }
-- 
2.34.1

