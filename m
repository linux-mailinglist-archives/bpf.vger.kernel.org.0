Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30EC76AFF5E
	for <lists+bpf@lfdr.de>; Wed,  8 Mar 2023 08:00:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbjCHHAd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Mar 2023 02:00:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbjCHHA1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Mar 2023 02:00:27 -0500
Received: from out-16.mta1.migadu.com (out-16.mta1.migadu.com [IPv6:2001:41d0:203:375::10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D639A17F4
        for <bpf@vger.kernel.org>; Tue,  7 Mar 2023 23:00:25 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1678258823;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eG/bY4GV3q1nPJWm0G4raxbIoSvMcSJYNB8DuhGS66I=;
        b=Z2jJ/O9uLOxE6iuNSMeY5nXeAk9u4PrRD0iR7cboaVm5dSz9raRBeDZ/GYpg4nEjTZ5O+Y
        7UpeefgfGdtk1DC+QFagLnelGOYYpxh3VvdZ8ZgFs2/+9cdsiGwcf2/kQbuRT07aHi8vUu
        1fWkcP5xJuCagbejaxxPhlJlH0ZUHo8=
From:   Martin KaFai Lau <martin.lau@linux.dev>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@meta.com,
        Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH v2 bpf-next 14/17] bpf: Use bpf_mem_cache_alloc/free for bpf_local_storage
Date:   Tue,  7 Mar 2023 22:59:33 -0800
Message-Id: <20230308065936.1550103-15-martin.lau@linux.dev>
In-Reply-To: <20230308065936.1550103-1-martin.lau@linux.dev>
References: <20230308065936.1550103-1-martin.lau@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Martin KaFai Lau <martin.lau@kernel.org>

This patch uses bpf_mem_cache_alloc/free for allocating and freeing
bpf_local_storage.

The changes are similar to the previous patch when switching
bpf_local_storage_elem to bpf_mem_cache_alloc/free.

A few things that worth to mention for bpf_local_storage:

The local_storage is deleted when the last selem is deleted.
Before deleting a selem from local_storage, it needs to retrieve the
local_storage->smap because the bpf_selem_unlink_storage_nolock()
may have set it to NULL. Note that local_storage->smap may have
already been NULL when the selem created this local_storage has
been removed. In this case, call_rcu will be used to free the
local_storage.

When bpf_local_storage_alloc getting a reused memory, all
fields are either in the correct values or will be initialized.
'cache[]' must already be all NULLs. 'list' must be empty.
Others will be initialized.

Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
---
 include/linux/bpf_local_storage.h |  1 +
 kernel/bpf/bpf_local_storage.c    | 50 ++++++++++++++++++++++++++-----
 2 files changed, 43 insertions(+), 8 deletions(-)

diff --git a/include/linux/bpf_local_storage.h b/include/linux/bpf_local_storage.h
index 550da364c8f9..ed35ce238b3d 100644
--- a/include/linux/bpf_local_storage.h
+++ b/include/linux/bpf_local_storage.h
@@ -57,6 +57,7 @@ struct bpf_local_storage_map {
 	u16 elem_size;
 	u16 cache_idx;
 	struct bpf_mem_alloc selem_ma;
+	struct bpf_mem_alloc storage_ma;
 };
 
 struct bpf_local_storage_data {
diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
index 228abb6b6e64..7f3ad118735e 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -111,7 +111,7 @@ static void bpf_local_storage_free_rcu(struct rcu_head *rcu)
 	struct bpf_local_storage *local_storage;
 
 	local_storage = container_of(rcu, struct bpf_local_storage, rcu);
-	kfree(local_storage);
+	bpf_mem_cache_raw_free(local_storage);
 }
 
 static void bpf_local_storage_free_trace_rcu(struct rcu_head *rcu)
@@ -126,13 +126,30 @@ static void bpf_local_storage_free_trace_rcu(struct rcu_head *rcu)
 }
 
 static void bpf_local_storage_free(struct bpf_local_storage *local_storage,
+				   struct bpf_local_storage_map *smap,
 				   bool reuse_now)
 {
-	if (!reuse_now)
+	if (!reuse_now) {
 		call_rcu_tasks_trace(&local_storage->rcu,
 				     bpf_local_storage_free_trace_rcu);
-	else
+		return;
+	}
+
+	if (smap) {
+		/* Instead of using the vanilla call_rcu(),
+		 * bpf_mem_cache_free should be able to reuse local_storage
+		 * immediately.
+		 */
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
 
 static void bpf_selem_free_rcu(struct rcu_head *rcu)
@@ -230,6 +247,7 @@ static bool bpf_selem_unlink_storage_nolock(struct bpf_local_storage *local_stor
 static void bpf_selem_unlink_storage(struct bpf_local_storage_elem *selem,
 				     bool reuse_now)
 {
+	struct bpf_local_storage_map *storage_smap;
 	struct bpf_local_storage *local_storage;
 	bool free_local_storage = false;
 	unsigned long flags;
@@ -240,6 +258,8 @@ static void bpf_selem_unlink_storage(struct bpf_local_storage_elem *selem,
 
 	local_storage = rcu_dereference_check(selem->local_storage,
 					      bpf_rcu_lock_held());
+	storage_smap = rcu_dereference_check(local_storage->smap,
+					     bpf_rcu_lock_held());
 	raw_spin_lock_irqsave(&local_storage->lock, flags);
 	if (likely(selem_linked_to_storage(selem)))
 		free_local_storage = bpf_selem_unlink_storage_nolock(
@@ -247,7 +267,8 @@ static void bpf_selem_unlink_storage(struct bpf_local_storage_elem *selem,
 	raw_spin_unlock_irqrestore(&local_storage->lock, flags);
 
 	if (free_local_storage)
-		bpf_local_storage_free(local_storage, reuse_now);
+		bpf_local_storage_free(local_storage, storage_smap,
+				       reuse_now);
 }
 
 void bpf_selem_link_storage_nolock(struct bpf_local_storage *local_storage,
@@ -367,8 +388,10 @@ int bpf_local_storage_alloc(void *owner,
 	if (err)
 		return err;
 
-	storage = bpf_map_kzalloc(&smap->map, sizeof(*storage),
-				  gfp_flags | __GFP_NOWARN);
+	migrate_disable();
+	storage = bpf_mem_cache_alloc_flags(&smap->storage_ma, gfp_flags);
+	migrate_enable();
+
 	if (!storage) {
 		err = -ENOMEM;
 		goto uncharge;
@@ -414,7 +437,7 @@ int bpf_local_storage_alloc(void *owner,
 	return 0;
 
 uncharge:
-	bpf_local_storage_free(storage, true);
+	bpf_local_storage_free(storage, smap, true);
 	mem_uncharge(smap, owner, sizeof(*storage));
 	return err;
 }
@@ -627,11 +650,15 @@ int bpf_local_storage_map_check_btf(const struct bpf_map *map,
 
 void bpf_local_storage_destroy(struct bpf_local_storage *local_storage)
 {
+	struct bpf_local_storage_map *storage_smap;
 	struct bpf_local_storage_elem *selem;
 	bool free_storage = false;
 	struct hlist_node *n;
 	unsigned long flags;
 
+	storage_smap = rcu_dereference_check(local_storage->smap,
+					     bpf_rcu_lock_held());
+
 	/* Neither the bpf_prog nor the bpf_map's syscall
 	 * could be modifying the local_storage->list now.
 	 * Thus, no elem can be added to or deleted from the
@@ -659,7 +686,7 @@ void bpf_local_storage_destroy(struct bpf_local_storage *local_storage)
 	raw_spin_unlock_irqrestore(&local_storage->lock, flags);
 
 	if (free_storage)
-		bpf_local_storage_free(local_storage, true);
+		bpf_local_storage_free(local_storage, storage_smap, true);
 }
 
 u64 bpf_local_storage_map_mem_usage(const struct bpf_map *map)
@@ -710,6 +737,12 @@ bpf_local_storage_map_alloc(union bpf_attr *attr,
 	if (err)
 		goto free_smap;
 
+	err = bpf_mem_alloc_init(&smap->storage_ma, sizeof(struct bpf_local_storage), false);
+	if (err) {
+		bpf_mem_alloc_destroy(&smap->selem_ma);
+		goto free_smap;
+	}
+
 	smap->cache_idx = bpf_local_storage_cache_idx_get(cache);
 	return &smap->map;
 
@@ -783,6 +816,7 @@ void bpf_local_storage_map_free(struct bpf_map *map,
 	synchronize_rcu();
 
 	bpf_mem_alloc_destroy(&smap->selem_ma);
+	bpf_mem_alloc_destroy(&smap->storage_ma);
 	kvfree(smap->buckets);
 	bpf_map_area_free(smap);
 }
-- 
2.34.1

