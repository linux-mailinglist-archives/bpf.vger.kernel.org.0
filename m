Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CE326AFF3A
	for <lists+bpf@lfdr.de>; Wed,  8 Mar 2023 08:00:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbjCHHAM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Mar 2023 02:00:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbjCHHAL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Mar 2023 02:00:11 -0500
Received: from out-49.mta1.migadu.com (out-49.mta1.migadu.com [95.215.58.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1BD3A1FDA
        for <bpf@vger.kernel.org>; Tue,  7 Mar 2023 23:00:09 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1678258808;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T6x8KVE5J80orHa0c0g7eNFInwt6Eq6u3RVJqLA0IEk=;
        b=KciiO5rS5PgXtkNhZ100ZBSc0vqEUN1DPybIA8vSAUI/EiFQUuYWURlJtsHqJ2T3Pm2p0s
        ef6BSNQquNlMN8VEBtvmxV4+54mpb+0UIMQ9/UsKoM+ayuecvS+9JUWHODPYQS4xefozqn
        0Lmg0Me7KHx8HnyFtmhp06IH/OPmFX4=
From:   Martin KaFai Lau <martin.lau@linux.dev>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@meta.com
Subject: [PATCH v2 bpf-next 06/17] bpf: Repurpose use_trace_rcu to reuse_now in bpf_local_storage
Date:   Tue,  7 Mar 2023 22:59:25 -0800
Message-Id: <20230308065936.1550103-7-martin.lau@linux.dev>
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

This patch re-purpose the use_trace_rcu to mean
if the freed memory can be reused immediately or not.
The use_trace_rcu is renamed to reuse_now. Other than
the boolean test is reversed, it should be a no-op.

The following explains the reason for the rename and how it will
be used in a later patch.

In a later patch, bpf_mem_cache_alloc/free will be used
in the bpf_local_storage. The bpf mem allocator will reuse
the freed memory immediately. Some of the free paths in
bpf_local_storage does not support memory to be reused immediately.
These paths are the "delete" elem cases from the bpf_*_storage_delete()
helper and the map_delete_elem() syscall. Note that "delete" elem
before the owner's (sk/task/cgrp/inode) lifetime ended is not
the common usage for the local storage.

The common free path, bpf_local_storage_destroy(), can reuse the
memory immediately. This common path means the storage stays with
its owner until the owner is destroyed.

The above mentioned "delete" elem paths that cannot
reuse immediately always has the 'use_trace_rcu ==  true'.
The cases that is safe for immediate reuse always have
'use_trace_rcu == false'. Instead of adding another arg
in a later patch, this patch re-purpose this arg
to reuse_now and have the test logic reversed.

In a later patch, 'reuse_now == true' will free to the
bpf_mem_cache_free() where the memory can be reused
immediately. 'reuse_now == false' will go through the
call_rcu_tasks_trace().

Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
---
 include/linux/bpf_local_storage.h |  2 +-
 kernel/bpf/bpf_cgrp_storage.c     |  2 +-
 kernel/bpf/bpf_inode_storage.c    |  2 +-
 kernel/bpf/bpf_local_storage.c    | 24 ++++++++++++------------
 kernel/bpf/bpf_task_storage.c     |  2 +-
 net/core/bpf_sk_storage.c         |  2 +-
 6 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/include/linux/bpf_local_storage.h b/include/linux/bpf_local_storage.h
index 613b1805ed9f..18a31add2255 100644
--- a/include/linux/bpf_local_storage.h
+++ b/include/linux/bpf_local_storage.h
@@ -143,7 +143,7 @@ int bpf_local_storage_map_check_btf(const struct bpf_map *map,
 void bpf_selem_link_storage_nolock(struct bpf_local_storage *local_storage,
 				   struct bpf_local_storage_elem *selem);
 
-void bpf_selem_unlink(struct bpf_local_storage_elem *selem, bool use_trace_rcu);
+void bpf_selem_unlink(struct bpf_local_storage_elem *selem, bool reuse_now);
 
 void bpf_selem_link_map(struct bpf_local_storage_map *smap,
 			struct bpf_local_storage_elem *selem);
diff --git a/kernel/bpf/bpf_cgrp_storage.c b/kernel/bpf/bpf_cgrp_storage.c
index 492594d69a86..c975cacdd16b 100644
--- a/kernel/bpf/bpf_cgrp_storage.c
+++ b/kernel/bpf/bpf_cgrp_storage.c
@@ -121,7 +121,7 @@ static int cgroup_storage_delete(struct cgroup *cgroup, struct bpf_map *map)
 	if (!sdata)
 		return -ENOENT;
 
-	bpf_selem_unlink(SELEM(sdata), true);
+	bpf_selem_unlink(SELEM(sdata), false);
 	return 0;
 }
 
diff --git a/kernel/bpf/bpf_inode_storage.c b/kernel/bpf/bpf_inode_storage.c
index 2d25bcfa371b..ad2ab0187e45 100644
--- a/kernel/bpf/bpf_inode_storage.c
+++ b/kernel/bpf/bpf_inode_storage.c
@@ -122,7 +122,7 @@ static int inode_storage_delete(struct inode *inode, struct bpf_map *map)
 	if (!sdata)
 		return -ENOENT;
 
-	bpf_selem_unlink(SELEM(sdata), true);
+	bpf_selem_unlink(SELEM(sdata), false);
 
 	return 0;
 }
diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
index 5585dbfd9c66..70c34a948c3c 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -147,7 +147,7 @@ static void bpf_selem_free_trace_rcu(struct rcu_head *rcu)
  */
 static bool bpf_selem_unlink_storage_nolock(struct bpf_local_storage *local_storage,
 					    struct bpf_local_storage_elem *selem,
-					    bool uncharge_mem, bool use_trace_rcu)
+					    bool uncharge_mem, bool reuse_now)
 {
 	struct bpf_local_storage_map *smap;
 	bool free_local_storage;
@@ -201,7 +201,7 @@ static bool bpf_selem_unlink_storage_nolock(struct bpf_local_storage *local_stor
 	 * any special fields.
 	 */
 	rec = smap->map.record;
-	if (use_trace_rcu) {
+	if (!reuse_now) {
 		if (!IS_ERR_OR_NULL(rec))
 			call_rcu_tasks_trace(&selem->rcu, bpf_selem_free_fields_trace_rcu);
 		else
@@ -220,7 +220,7 @@ static bool bpf_selem_unlink_storage_nolock(struct bpf_local_storage *local_stor
 }
 
 static void bpf_selem_unlink_storage(struct bpf_local_storage_elem *selem,
-				     bool use_trace_rcu)
+				     bool reuse_now)
 {
 	struct bpf_local_storage *local_storage;
 	bool free_local_storage = false;
@@ -235,11 +235,11 @@ static void bpf_selem_unlink_storage(struct bpf_local_storage_elem *selem,
 	raw_spin_lock_irqsave(&local_storage->lock, flags);
 	if (likely(selem_linked_to_storage(selem)))
 		free_local_storage = bpf_selem_unlink_storage_nolock(
-			local_storage, selem, true, use_trace_rcu);
+			local_storage, selem, true, reuse_now);
 	raw_spin_unlock_irqrestore(&local_storage->lock, flags);
 
 	if (free_local_storage) {
-		if (use_trace_rcu)
+		if (!reuse_now)
 			call_rcu_tasks_trace(&local_storage->rcu,
 				     bpf_local_storage_free_rcu);
 		else
@@ -284,14 +284,14 @@ void bpf_selem_link_map(struct bpf_local_storage_map *smap,
 	raw_spin_unlock_irqrestore(&b->lock, flags);
 }
 
-void bpf_selem_unlink(struct bpf_local_storage_elem *selem, bool use_trace_rcu)
+void bpf_selem_unlink(struct bpf_local_storage_elem *selem, bool reuse_now)
 {
 	/* Always unlink from map before unlinking from local_storage
 	 * because selem will be freed after successfully unlinked from
 	 * the local_storage.
 	 */
 	bpf_selem_unlink_map(selem);
-	bpf_selem_unlink_storage(selem, use_trace_rcu);
+	bpf_selem_unlink_storage(selem, reuse_now);
 }
 
 /* If cacheit_lockit is false, this lookup function is lockless */
@@ -538,7 +538,7 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
 	if (old_sdata) {
 		bpf_selem_unlink_map(SELEM(old_sdata));
 		bpf_selem_unlink_storage_nolock(local_storage, SELEM(old_sdata),
-						false, true);
+						false, false);
 	}
 
 unlock:
@@ -651,7 +651,7 @@ void bpf_local_storage_destroy(struct bpf_local_storage *local_storage)
 		 * of the loop will set the free_cgroup_storage to true.
 		 */
 		free_storage = bpf_selem_unlink_storage_nolock(
-			local_storage, selem, false, false);
+			local_storage, selem, false, true);
 	}
 	raw_spin_unlock_irqrestore(&local_storage->lock, flags);
 
@@ -745,7 +745,7 @@ void bpf_local_storage_map_free(struct bpf_map *map,
 				migrate_disable();
 				this_cpu_inc(*busy_counter);
 			}
-			bpf_selem_unlink(selem, false);
+			bpf_selem_unlink(selem, true);
 			if (busy_counter) {
 				this_cpu_dec(*busy_counter);
 				migrate_enable();
@@ -783,8 +783,8 @@ void bpf_local_storage_map_free(struct bpf_map *map,
 		/* We cannot skip rcu_barrier() when rcu_trace_implies_rcu_gp()
 		 * is true, because while call_rcu invocation is skipped in that
 		 * case in bpf_selem_free_fields_trace_rcu (and all local
-		 * storage maps pass use_trace_rcu = true), there can be
-		 * call_rcu callbacks based on use_trace_rcu = false in the
+		 * storage maps pass reuse_now = false), there can be
+		 * call_rcu callbacks based on reuse_now = true in the
 		 * while ((selem = ...)) loop above or when owner's free path
 		 * calls bpf_local_storage_unlink_nolock.
 		 */
diff --git a/kernel/bpf/bpf_task_storage.c b/kernel/bpf/bpf_task_storage.c
index 4dcef28744d1..c88cc04c17c1 100644
--- a/kernel/bpf/bpf_task_storage.c
+++ b/kernel/bpf/bpf_task_storage.c
@@ -168,7 +168,7 @@ static int task_storage_delete(struct task_struct *task, struct bpf_map *map,
 	if (!nobusy)
 		return -EBUSY;
 
-	bpf_selem_unlink(SELEM(sdata), true);
+	bpf_selem_unlink(SELEM(sdata), false);
 
 	return 0;
 }
diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
index 8f56438c104b..a5f185b8e50a 100644
--- a/net/core/bpf_sk_storage.c
+++ b/net/core/bpf_sk_storage.c
@@ -40,7 +40,7 @@ static int bpf_sk_storage_del(struct sock *sk, struct bpf_map *map)
 	if (!sdata)
 		return -ENOENT;
 
-	bpf_selem_unlink(SELEM(sdata), true);
+	bpf_selem_unlink(SELEM(sdata), false);
 
 	return 0;
 }
-- 
2.34.1

