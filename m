Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 784556AB89E
	for <lists+bpf@lfdr.de>; Mon,  6 Mar 2023 09:43:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbjCFInA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 6 Mar 2023 03:43:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbjCFImw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 6 Mar 2023 03:42:52 -0500
Received: from out-43.mta1.migadu.com (out-43.mta1.migadu.com [IPv6:2001:41d0:203:375::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35D6B21299
        for <bpf@vger.kernel.org>; Mon,  6 Mar 2023 00:42:49 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1678092167;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YzC9X7UObwxzsDWt9u4tl8YDgLVbGfjVgq78KmLQ4eI=;
        b=kTl3gYMPAWiNMDsCkE1CDMfIOe/iTHKiUcubgescKVaaW/fYWDR+PnHA7pjP5RXkCOMwi/
        Fl2tPFjK+oIrlQi16DUsjmKJrB8zYNhfgVT6LVvaPXNSU87pAkpOqpOg9PlWsFNEI56Yd1
        It0BJtF5rd7OHzB68FihBCYgjlNREuA=
From:   Martin KaFai Lau <martin.lau@linux.dev>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@meta.com,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>
Subject: [PATCH bpf-next 07/16] bpf: Remove bpf_selem_free_fields*_rcu
Date:   Mon,  6 Mar 2023 00:42:07 -0800
Message-Id: <20230306084216.3186830-8-martin.lau@linux.dev>
In-Reply-To: <20230306084216.3186830-1-martin.lau@linux.dev>
References: <20230306084216.3186830-1-martin.lau@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Martin KaFai Lau <martin.lau@kernel.org>

This patch removes the bpf_selem_free_fields*_rcu. The
bpf_obj_free_fields() can be done before the call_rcu_trasks_trace()
and kfree_rcu(). It is needed when a later patch uses
bpf_mem_cache_alloc/free. In bpf hashtab, bpf_obj_free_fields()
is also called before calling bpf_mem_cache_free. The discussion
can be found in
https://lore.kernel.org/bpf/f67021ee-21d9-bfae-6134-4ca542fab843@linux.dev/

Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
---
 kernel/bpf/bpf_local_storage.c | 67 +++-------------------------------
 1 file changed, 5 insertions(+), 62 deletions(-)

diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
index 8c1401a24c7d..9a1febcc9565 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -109,27 +109,6 @@ static void bpf_local_storage_free_rcu(struct rcu_head *rcu)
 		kfree_rcu(local_storage, rcu);
 }
 
-static void bpf_selem_free_fields_rcu(struct rcu_head *rcu)
-{
-	struct bpf_local_storage_elem *selem;
-	struct bpf_local_storage_map *smap;
-
-	selem = container_of(rcu, struct bpf_local_storage_elem, rcu);
-	/* protected by the rcu_barrier*() */
-	smap = rcu_dereference_protected(SDATA(selem)->smap, true);
-	bpf_obj_free_fields(smap->map.record, SDATA(selem)->data);
-	kfree(selem);
-}
-
-static void bpf_selem_free_fields_trace_rcu(struct rcu_head *rcu)
-{
-	/* Free directly if Tasks Trace RCU GP also implies RCU GP */
-	if (rcu_trace_implies_rcu_gp())
-		bpf_selem_free_fields_rcu(rcu);
-	else
-		call_rcu(rcu, bpf_selem_free_fields_rcu);
-}
-
 static void bpf_selem_free_trace_rcu(struct rcu_head *rcu)
 {
 	struct bpf_local_storage_elem *selem;
@@ -151,7 +130,6 @@ static bool bpf_selem_unlink_storage_nolock(struct bpf_local_storage *local_stor
 {
 	struct bpf_local_storage_map *smap;
 	bool free_local_storage;
-	struct btf_record *rec;
 	void *owner;
 
 	smap = rcu_dereference_check(SDATA(selem)->smap, bpf_rcu_lock_held());
@@ -192,26 +170,11 @@ static bool bpf_selem_unlink_storage_nolock(struct bpf_local_storage *local_stor
 	    SDATA(selem))
 		RCU_INIT_POINTER(local_storage->cache[smap->cache_idx], NULL);
 
-	/* A different RCU callback is chosen whenever we need to free
-	 * additional fields in selem data before freeing selem.
-	 * bpf_local_storage_map_free only executes rcu_barrier to wait for RCU
-	 * callbacks when it has special fields, hence we can only conditionally
-	 * dereference smap, as by this time the map might have already been
-	 * freed without waiting for our call_rcu callback if it did not have
-	 * any special fields.
-	 */
-	rec = smap->map.record;
-	if (!reuse_now) {
-		if (!IS_ERR_OR_NULL(rec))
-			call_rcu_tasks_trace(&selem->rcu, bpf_selem_free_fields_trace_rcu);
-		else
-			call_rcu_tasks_trace(&selem->rcu, bpf_selem_free_trace_rcu);
-	} else {
-		if (!IS_ERR_OR_NULL(rec))
-			call_rcu(&selem->rcu, bpf_selem_free_fields_rcu);
-		else
-			kfree_rcu(selem, rcu);
-	}
+	bpf_obj_free_fields(smap->map.record, SDATA(selem)->data);
+	if (!reuse_now)
+		call_rcu_tasks_trace(&selem->rcu, bpf_selem_free_trace_rcu);
+	else
+		kfree_rcu(selem, rcu);
 
 	if (rcu_access_pointer(local_storage->smap) == smap)
 		RCU_INIT_POINTER(local_storage->smap, NULL);
@@ -759,26 +722,6 @@ void bpf_local_storage_map_free(struct bpf_map *map,
 	 */
 	synchronize_rcu();
 
-	/* Only delay freeing of smap, buckets are not needed anymore */
 	kvfree(smap->buckets);
-
-	/* When local storage has special fields, callbacks for
-	 * bpf_selem_free_fields_rcu and bpf_selem_free_fields_trace_rcu will
-	 * keep using the map BTF record, we need to execute an RCU barrier to
-	 * wait for them as the record will be freed right after our map_free
-	 * callback.
-	 */
-	if (!IS_ERR_OR_NULL(smap->map.record)) {
-		rcu_barrier_tasks_trace();
-		/* We cannot skip rcu_barrier() when rcu_trace_implies_rcu_gp()
-		 * is true, because while call_rcu invocation is skipped in that
-		 * case in bpf_selem_free_fields_trace_rcu (and all local
-		 * storage maps pass reuse_now = false), there can be
-		 * call_rcu callbacks based on reuse_now = true in the
-		 * while ((selem = ...)) loop above or when owner's free path
-		 * calls bpf_local_storage_unlink_nolock.
-		 */
-		rcu_barrier();
-	}
 	bpf_map_area_free(smap);
 }
-- 
2.30.2

