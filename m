Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69EE96AFF36
	for <lists+bpf@lfdr.de>; Wed,  8 Mar 2023 08:00:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbjCHHAF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Mar 2023 02:00:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjCHHAF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Mar 2023 02:00:05 -0500
Received: from out-52.mta1.migadu.com (out-52.mta1.migadu.com [95.215.58.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B4C7A18AC
        for <bpf@vger.kernel.org>; Tue,  7 Mar 2023 23:00:02 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1678258800;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WaQv0aBueydGT1B4DVJiEk+GtrT77utylnpMTngerWg=;
        b=Y7u3mJucV/6AYpheXBcxZjJVp8oPjULMAR4m872KVUqOEF6E+Bg84uXiY67NjSi1vVG4Q1
        4n+SKUIK9vRtH2kwqQ1vbaJ1dJ0BTKjzFpdN6dqQyUSEiBPGXnAwWI+mOTZyCJsqz10+80
        1neXAjT6KB7QPtVhvGP3YVkl9mKe2ds=
From:   Martin KaFai Lau <martin.lau@linux.dev>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@meta.com
Subject: [PATCH v2 bpf-next 02/17] bpf: Refactor codes into bpf_local_storage_destroy
Date:   Tue,  7 Mar 2023 22:59:21 -0800
Message-Id: <20230308065936.1550103-3-martin.lau@linux.dev>
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

This patch first renames bpf_local_storage_unlink_nolock to
bpf_local_storage_destroy(). It better reflects that it is only
used when the storage's owner (sk/task/cgrp/inode) is being kfree().

All bpf_local_storage_destroy's caller is taking the spin lock and
then free the storage. This patch also moves these two steps into
the bpf_local_storage_destroy.

This is a preparation work for a later patch that uses
bpf_mem_cache_alloc/free in the bpf_local_storage.

Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
---
 include/linux/bpf_local_storage.h | 2 +-
 kernel/bpf/bpf_cgrp_storage.c     | 9 +--------
 kernel/bpf/bpf_inode_storage.c    | 8 +-------
 kernel/bpf/bpf_local_storage.c    | 8 ++++++--
 kernel/bpf/bpf_task_storage.c     | 9 +--------
 net/core/bpf_sk_storage.c         | 8 +-------
 6 files changed, 11 insertions(+), 33 deletions(-)

diff --git a/include/linux/bpf_local_storage.h b/include/linux/bpf_local_storage.h
index 502ad7093f13..5908a954ddc2 100644
--- a/include/linux/bpf_local_storage.h
+++ b/include/linux/bpf_local_storage.h
@@ -128,7 +128,7 @@ bpf_local_storage_lookup(struct bpf_local_storage *local_storage,
 			 struct bpf_local_storage_map *smap,
 			 bool cacheit_lockit);
 
-bool bpf_local_storage_unlink_nolock(struct bpf_local_storage *local_storage);
+void bpf_local_storage_destroy(struct bpf_local_storage *local_storage);
 
 void bpf_local_storage_map_free(struct bpf_map *map,
 				struct bpf_local_storage_cache *cache,
diff --git a/kernel/bpf/bpf_cgrp_storage.c b/kernel/bpf/bpf_cgrp_storage.c
index 9ae07aedaf23..492594d69a86 100644
--- a/kernel/bpf/bpf_cgrp_storage.c
+++ b/kernel/bpf/bpf_cgrp_storage.c
@@ -46,8 +46,6 @@ static struct bpf_local_storage __rcu **cgroup_storage_ptr(void *owner)
 void bpf_cgrp_storage_free(struct cgroup *cgroup)
 {
 	struct bpf_local_storage *local_storage;
-	bool free_cgroup_storage = false;
-	unsigned long flags;
 
 	rcu_read_lock();
 	local_storage = rcu_dereference(cgroup->bpf_cgrp_storage);
@@ -57,14 +55,9 @@ void bpf_cgrp_storage_free(struct cgroup *cgroup)
 	}
 
 	bpf_cgrp_storage_lock();
-	raw_spin_lock_irqsave(&local_storage->lock, flags);
-	free_cgroup_storage = bpf_local_storage_unlink_nolock(local_storage);
-	raw_spin_unlock_irqrestore(&local_storage->lock, flags);
+	bpf_local_storage_destroy(local_storage);
 	bpf_cgrp_storage_unlock();
 	rcu_read_unlock();
-
-	if (free_cgroup_storage)
-		kfree_rcu(local_storage, rcu);
 }
 
 static struct bpf_local_storage_data *
diff --git a/kernel/bpf/bpf_inode_storage.c b/kernel/bpf/bpf_inode_storage.c
index 43e2619c8167..2d25bcfa371b 100644
--- a/kernel/bpf/bpf_inode_storage.c
+++ b/kernel/bpf/bpf_inode_storage.c
@@ -57,7 +57,6 @@ static struct bpf_local_storage_data *inode_storage_lookup(struct inode *inode,
 void bpf_inode_storage_free(struct inode *inode)
 {
 	struct bpf_local_storage *local_storage;
-	bool free_inode_storage = false;
 	struct bpf_storage_blob *bsb;
 
 	bsb = bpf_inode(inode);
@@ -72,13 +71,8 @@ void bpf_inode_storage_free(struct inode *inode)
 		return;
 	}
 
-	raw_spin_lock_bh(&local_storage->lock);
-	free_inode_storage = bpf_local_storage_unlink_nolock(local_storage);
-	raw_spin_unlock_bh(&local_storage->lock);
+	bpf_local_storage_destroy(local_storage);
 	rcu_read_unlock();
-
-	if (free_inode_storage)
-		kfree_rcu(local_storage, rcu);
 }
 
 static void *bpf_fd_inode_storage_lookup_elem(struct bpf_map *map, void *key)
diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
index 1904a4245ebe..e19f9f50a60d 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -652,11 +652,12 @@ int bpf_local_storage_map_check_btf(const struct bpf_map *map,
 	return 0;
 }
 
-bool bpf_local_storage_unlink_nolock(struct bpf_local_storage *local_storage)
+void bpf_local_storage_destroy(struct bpf_local_storage *local_storage)
 {
 	struct bpf_local_storage_elem *selem;
 	bool free_storage = false;
 	struct hlist_node *n;
+	unsigned long flags;
 
 	/* Neither the bpf_prog nor the bpf_map's syscall
 	 * could be modifying the local_storage->list now.
@@ -667,6 +668,7 @@ bool bpf_local_storage_unlink_nolock(struct bpf_local_storage *local_storage)
 	 * when unlinking elem from the local_storage->list and
 	 * the map's bucket->list.
 	 */
+	raw_spin_lock_irqsave(&local_storage->lock, flags);
 	hlist_for_each_entry_safe(selem, n, &local_storage->list, snode) {
 		/* Always unlink from map before unlinking from
 		 * local_storage.
@@ -681,8 +683,10 @@ bool bpf_local_storage_unlink_nolock(struct bpf_local_storage *local_storage)
 		free_storage = bpf_selem_unlink_storage_nolock(
 			local_storage, selem, false, false);
 	}
+	raw_spin_unlock_irqrestore(&local_storage->lock, flags);
 
-	return free_storage;
+	if (free_storage)
+		kfree_rcu(local_storage, rcu);
 }
 
 u64 bpf_local_storage_map_mem_usage(const struct bpf_map *map)
diff --git a/kernel/bpf/bpf_task_storage.c b/kernel/bpf/bpf_task_storage.c
index 20f942229f3c..4dcef28744d1 100644
--- a/kernel/bpf/bpf_task_storage.c
+++ b/kernel/bpf/bpf_task_storage.c
@@ -72,8 +72,6 @@ task_storage_lookup(struct task_struct *task, struct bpf_map *map,
 void bpf_task_storage_free(struct task_struct *task)
 {
 	struct bpf_local_storage *local_storage;
-	bool free_task_storage = false;
-	unsigned long flags;
 
 	rcu_read_lock();
 
@@ -84,14 +82,9 @@ void bpf_task_storage_free(struct task_struct *task)
 	}
 
 	bpf_task_storage_lock();
-	raw_spin_lock_irqsave(&local_storage->lock, flags);
-	free_task_storage = bpf_local_storage_unlink_nolock(local_storage);
-	raw_spin_unlock_irqrestore(&local_storage->lock, flags);
+	bpf_local_storage_destroy(local_storage);
 	bpf_task_storage_unlock();
 	rcu_read_unlock();
-
-	if (free_task_storage)
-		kfree_rcu(local_storage, rcu);
 }
 
 static void *bpf_pid_task_storage_lookup_elem(struct bpf_map *map, void *key)
diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
index 7a36353dbc22..8f56438c104b 100644
--- a/net/core/bpf_sk_storage.c
+++ b/net/core/bpf_sk_storage.c
@@ -49,7 +49,6 @@ static int bpf_sk_storage_del(struct sock *sk, struct bpf_map *map)
 void bpf_sk_storage_free(struct sock *sk)
 {
 	struct bpf_local_storage *sk_storage;
-	bool free_sk_storage = false;
 
 	rcu_read_lock();
 	sk_storage = rcu_dereference(sk->sk_bpf_storage);
@@ -58,13 +57,8 @@ void bpf_sk_storage_free(struct sock *sk)
 		return;
 	}
 
-	raw_spin_lock_bh(&sk_storage->lock);
-	free_sk_storage = bpf_local_storage_unlink_nolock(sk_storage);
-	raw_spin_unlock_bh(&sk_storage->lock);
+	bpf_local_storage_destroy(sk_storage);
 	rcu_read_unlock();
-
-	if (free_sk_storage)
-		kfree_rcu(sk_storage, rcu);
 }
 
 static void bpf_sk_storage_map_free(struct bpf_map *map)
-- 
2.34.1

