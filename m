Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D19B6C5901
	for <lists+bpf@lfdr.de>; Wed, 22 Mar 2023 22:53:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbjCVVxD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Mar 2023 17:53:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbjCVVxC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Mar 2023 17:53:02 -0400
Received: from out-27.mta0.migadu.com (out-27.mta0.migadu.com [91.218.175.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB18C2694
        for <bpf@vger.kernel.org>; Wed, 22 Mar 2023 14:52:58 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1679521977;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2BUKrGsLiz6gT9EdXRsPhQCUSMdRv7gWPrOx0fZI4rA=;
        b=OPb5JW5Wr7eadz3nqPt+hhY8VJsb5euK3XKuXjSSqZDk9i9ZDI2qhLkcvKS+RmPpf8bnTr
        +u4wgRyvVbD58wD78fBlKjPfMTfxTNDoTDDXhNhcBGRW/7bairi8yTJx/nQJV1KArZY+Pu
        33gDSXn2tP+f7JSF/tGrHthcw2XCVy0=
From:   Martin KaFai Lau <martin.lau@linux.dev>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@meta.com,
        Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH v3 bpf-next 2/5] bpf: Use bpf_mem_cache_alloc/free in bpf_local_storage_elem
Date:   Wed, 22 Mar 2023 14:52:43 -0700
Message-Id: <20230322215246.1675516-3-martin.lau@linux.dev>
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

This patch uses bpf_mem_alloc for the task and cgroup local storage that
the bpf prog can easily get a hold of the storage owner's PTR_TO_BTF_ID.
eg. bpf_get_current_task_btf() can be used in some of the kmalloc code
path which will cause deadlock/recursion. bpf_mem_cache_alloc is
deadlock free and will solve a legit use case in [1].

For sk storage, its batch creation benchmark shows a few percent
regression when the sk create/destroy batch size is larger than 32.
The sk creation/destruction happens much more often and
depends on external traffic. Considering it is hypothetical
to be able to cause deadlock with sk storage, it can cross
the bridge to use bpf_mem_alloc till a legit (ie. useful)
use case comes up.

For inode storage, bpf_local_storage_destroy() is called before
waiting for a rcu gp and its memory cannot be reused immediately.
inode stays with kmalloc/kfree after the rcu [or tasks_trace] gp.

A 'bool bpf_ma' argument is added to bpf_local_storage_map_alloc().
Only task and cgroup storage have 'bpf_ma == true' which
means to use bpf_mem_cache_alloc/free(). This patch only changes
selem to use bpf_mem_alloc for task and cgroup. The next patch
will change the local_storage to use bpf_mem_alloc also for
task and cgroup.

Here is some more details on the changes:

* memory allocation:
After bpf_mem_cache_alloc(), the SDATA(selem)->data is zero-ed because
bpf_mem_cache_alloc() could return a reused selem. It is to keep
the existing bpf_map_kzalloc() behavior. Only SDATA(selem)->data
is zero-ed. SDATA(selem)->data is the visible part to the bpf prog.
No need to use zero_map_value() to do the zeroing because
bpf_selem_free(..., reuse_now = true) ensures no bpf prog is using
the selem before returning the selem through bpf_mem_cache_free().
For the internal fields of selem, they will be initialized when
linking to the new smap and the new local_storage.

When 'bpf_ma == false', nothing changes in this patch. It will
stay with the bpf_map_kzalloc().

* memory free:
The bpf_selem_free() and bpf_selem_free_rcu() are modified to handle
the bpf_ma == true case.

For the common selem free path where its owner is also being destroyed,
the mem is freed in bpf_local_storage_destroy(), the owner (task
and cgroup) has gone through a rcu gp. The memory can be reused
immediately, so bpf_local_storage_destroy() will call
bpf_selem_free(..., reuse_now = true) which will do
bpf_mem_cache_free() for immediate reuse consideration.

An exception is the delete elem code path. The delete elem code path
is called from the helper bpf_*_storage_delete() and the syscall
bpf_map_delete_elem(). This path is an unusual case for local
storage because the common use case is to have the local storage
staying with its owner life time so that the bpf prog and the user
space does not have to monitor the owner's destruction. For the delete
elem path, the selem cannot be reused immediately because there could
be bpf prog using it. It will call bpf_selem_free(..., reuse_now = false)
and it will wait for a rcu tasks trace gp before freeing the elem. The
rcu callback is changed to do bpf_mem_cache_raw_free() instead of kfree().

When 'bpf_ma == false', it should be the same as before.
__bpf_selem_free() is added to do the kfree_rcu and call_tasks_trace_rcu().
A few words on the 'reuse_now == true'. When 'reuse_now == true',
it is still racing with bpf_local_storage_map_free which is under rcu
protection, so it still needs to wait for a rcu gp instead of kfree().
Otherwise, the selem may be reused by slab for a totally different struct
while the bpf_local_storage_map_free() is still using it (as a
rcu reader). For the inode case, there may be other rcu readers also.
In short, when bpf_ma == false and reuse_now == true => vanilla rcu.

[1]: https://lore.kernel.org/bpf/20221118190109.1512674-1-namhyung@kernel.org/

Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
---
 include/linux/bpf_local_storage.h |  6 +-
 kernel/bpf/bpf_cgrp_storage.c     |  2 +-
 kernel/bpf/bpf_inode_storage.c    |  2 +-
 kernel/bpf/bpf_local_storage.c    | 95 ++++++++++++++++++++++++++++---
 kernel/bpf/bpf_task_storage.c     |  2 +-
 net/core/bpf_sk_storage.c         |  2 +-
 6 files changed, 95 insertions(+), 14 deletions(-)

diff --git a/include/linux/bpf_local_storage.h b/include/linux/bpf_local_storage.h
index a34f61467a2f..30efbcab2798 100644
--- a/include/linux/bpf_local_storage.h
+++ b/include/linux/bpf_local_storage.h
@@ -13,6 +13,7 @@
 #include <linux/list.h>
 #include <linux/hash.h>
 #include <linux/types.h>
+#include <linux/bpf_mem_alloc.h>
 #include <uapi/linux/btf.h>
 
 #define BPF_LOCAL_STORAGE_CACHE_SIZE	16
@@ -55,6 +56,8 @@ struct bpf_local_storage_map {
 	u32 bucket_log;
 	u16 elem_size;
 	u16 cache_idx;
+	struct bpf_mem_alloc selem_ma;
+	bool bpf_ma;
 };
 
 struct bpf_local_storage_data {
@@ -122,7 +125,8 @@ int bpf_local_storage_map_alloc_check(union bpf_attr *attr);
 
 struct bpf_map *
 bpf_local_storage_map_alloc(union bpf_attr *attr,
-			    struct bpf_local_storage_cache *cache);
+			    struct bpf_local_storage_cache *cache,
+			    bool bpf_ma);
 
 struct bpf_local_storage_data *
 bpf_local_storage_lookup(struct bpf_local_storage *local_storage,
diff --git a/kernel/bpf/bpf_cgrp_storage.c b/kernel/bpf/bpf_cgrp_storage.c
index c975cacdd16b..8edba157aedb 100644
--- a/kernel/bpf/bpf_cgrp_storage.c
+++ b/kernel/bpf/bpf_cgrp_storage.c
@@ -149,7 +149,7 @@ static int notsupp_get_next_key(struct bpf_map *map, void *key, void *next_key)
 
 static struct bpf_map *cgroup_storage_map_alloc(union bpf_attr *attr)
 {
-	return bpf_local_storage_map_alloc(attr, &cgroup_cache);
+	return bpf_local_storage_map_alloc(attr, &cgroup_cache, true);
 }
 
 static void cgroup_storage_map_free(struct bpf_map *map)
diff --git a/kernel/bpf/bpf_inode_storage.c b/kernel/bpf/bpf_inode_storage.c
index ad2ab0187e45..ec3bcdb92b74 100644
--- a/kernel/bpf/bpf_inode_storage.c
+++ b/kernel/bpf/bpf_inode_storage.c
@@ -199,7 +199,7 @@ static int notsupp_get_next_key(struct bpf_map *map, void *key,
 
 static struct bpf_map *inode_storage_map_alloc(union bpf_attr *attr)
 {
-	return bpf_local_storage_map_alloc(attr, &inode_cache);
+	return bpf_local_storage_map_alloc(attr, &inode_cache, false);
 }
 
 static void inode_storage_map_free(struct bpf_map *map)
diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
index 351d991694cb..309ea727a5cb 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -80,8 +80,24 @@ bpf_selem_alloc(struct bpf_local_storage_map *smap, void *owner,
 	if (charge_mem && mem_charge(smap, owner, smap->elem_size))
 		return NULL;
 
-	selem = bpf_map_kzalloc(&smap->map, smap->elem_size,
-				gfp_flags | __GFP_NOWARN);
+	if (smap->bpf_ma) {
+		migrate_disable();
+		selem = bpf_mem_cache_alloc_flags(&smap->selem_ma, gfp_flags);
+		migrate_enable();
+		if (selem)
+			/* Keep the original bpf_map_kzalloc behavior
+			 * before started using the bpf_mem_cache_alloc.
+			 *
+			 * No need to use zero_map_value. The bpf_selem_free()
+			 * only does bpf_mem_cache_free when there is
+			 * no other bpf prog is using the selem.
+			 */
+			memset(SDATA(selem)->data, 0, smap->map.value_size);
+	} else {
+		selem = bpf_map_kzalloc(&smap->map, smap->elem_size,
+					gfp_flags | __GFP_NOWARN);
+	}
+
 	if (selem) {
 		if (value)
 			copy_map_value(&smap->map, SDATA(selem)->data, value);
@@ -124,12 +140,34 @@ static void bpf_local_storage_free(struct bpf_local_storage *local_storage,
 		call_rcu(&local_storage->rcu, bpf_local_storage_free_rcu);
 }
 
+/* rcu tasks trace callback for bpf_ma == false */
+static void __bpf_selem_free_trace_rcu(struct rcu_head *rcu)
+{
+	struct bpf_local_storage_elem *selem;
+
+	selem = container_of(rcu, struct bpf_local_storage_elem, rcu);
+	if (rcu_trace_implies_rcu_gp())
+		kfree(selem);
+	else
+		kfree_rcu(selem, rcu);
+}
+
+/* Handle bpf_ma == false */
+static void __bpf_selem_free(struct bpf_local_storage_elem *selem,
+			     bool vanilla_rcu)
+{
+	if (vanilla_rcu)
+		kfree_rcu(selem, rcu);
+	else
+		call_rcu_tasks_trace(&selem->rcu, __bpf_selem_free_trace_rcu);
+}
+
 static void bpf_selem_free_rcu(struct rcu_head *rcu)
 {
 	struct bpf_local_storage_elem *selem;
 
 	selem = container_of(rcu, struct bpf_local_storage_elem, rcu);
-	kfree(selem);
+	bpf_mem_cache_raw_free(selem);
 }
 
 static void bpf_selem_free_trace_rcu(struct rcu_head *rcu)
@@ -145,10 +183,23 @@ void bpf_selem_free(struct bpf_local_storage_elem *selem,
 		    bool reuse_now)
 {
 	bpf_obj_free_fields(smap->map.record, SDATA(selem)->data);
-	if (!reuse_now)
+
+	if (!smap->bpf_ma) {
+		__bpf_selem_free(selem, reuse_now);
+		return;
+	}
+
+	if (!reuse_now) {
 		call_rcu_tasks_trace(&selem->rcu, bpf_selem_free_trace_rcu);
-	else
-		call_rcu(&selem->rcu, bpf_selem_free_rcu);
+	} else {
+		/* Instead of using the vanilla call_rcu(),
+		 * bpf_mem_cache_free will be able to reuse selem
+		 * immediately.
+		 */
+		migrate_disable();
+		bpf_mem_cache_free(&smap->selem_ma, selem);
+		migrate_enable();
+	}
 }
 
 /* local_storage->lock must be held and selem->local_storage == local_storage.
@@ -654,13 +705,25 @@ u64 bpf_local_storage_map_mem_usage(const struct bpf_map *map)
 	return usage;
 }
 
+/* When bpf_ma == true, the bpf_mem_alloc is used to allocate and free memory.
+ * A deadlock free allocator is useful for storage that the bpf prog can easily
+ * get a hold of the owner PTR_TO_BTF_ID in any context. eg. bpf_get_current_task_btf.
+ * The task and cgroup storage fall into this case. The bpf_mem_alloc reuses
+ * memory immediately. To be reuse-immediate safe, the owner destruction
+ * code path needs to go through a rcu grace period before calling
+ * bpf_local_storage_destroy().
+ *
+ * When bpf_ma == false, the kmalloc and kfree are used.
+ */
 struct bpf_map *
 bpf_local_storage_map_alloc(union bpf_attr *attr,
-			    struct bpf_local_storage_cache *cache)
+			    struct bpf_local_storage_cache *cache,
+			    bool bpf_ma)
 {
 	struct bpf_local_storage_map *smap;
 	unsigned int i;
 	u32 nbuckets;
+	int err;
 
 	smap = bpf_map_area_alloc(sizeof(*smap), NUMA_NO_NODE);
 	if (!smap)
@@ -675,8 +738,8 @@ bpf_local_storage_map_alloc(union bpf_attr *attr,
 	smap->buckets = bpf_map_kvcalloc(&smap->map, sizeof(*smap->buckets),
 					 nbuckets, GFP_USER | __GFP_NOWARN);
 	if (!smap->buckets) {
-		bpf_map_area_free(smap);
-		return ERR_PTR(-ENOMEM);
+		err = -ENOMEM;
+		goto free_smap;
 	}
 
 	for (i = 0; i < nbuckets; i++) {
@@ -687,8 +750,20 @@ bpf_local_storage_map_alloc(union bpf_attr *attr,
 	smap->elem_size = offsetof(struct bpf_local_storage_elem,
 				   sdata.data[attr->value_size]);
 
+	smap->bpf_ma = bpf_ma;
+	if (bpf_ma) {
+		err = bpf_mem_alloc_init(&smap->selem_ma, smap->elem_size, false);
+		if (err)
+			goto free_smap;
+	}
+
 	smap->cache_idx = bpf_local_storage_cache_idx_get(cache);
 	return &smap->map;
+
+free_smap:
+	kvfree(smap->buckets);
+	bpf_map_area_free(smap);
+	return ERR_PTR(err);
 }
 
 void bpf_local_storage_map_free(struct bpf_map *map,
@@ -754,6 +829,8 @@ void bpf_local_storage_map_free(struct bpf_map *map,
 	 */
 	synchronize_rcu();
 
+	if (smap->bpf_ma)
+		bpf_mem_alloc_destroy(&smap->selem_ma);
 	kvfree(smap->buckets);
 	bpf_map_area_free(smap);
 }
diff --git a/kernel/bpf/bpf_task_storage.c b/kernel/bpf/bpf_task_storage.c
index c88cc04c17c1..d031288cfa3c 100644
--- a/kernel/bpf/bpf_task_storage.c
+++ b/kernel/bpf/bpf_task_storage.c
@@ -309,7 +309,7 @@ static int notsupp_get_next_key(struct bpf_map *map, void *key, void *next_key)
 
 static struct bpf_map *task_storage_map_alloc(union bpf_attr *attr)
 {
-	return bpf_local_storage_map_alloc(attr, &task_cache);
+	return bpf_local_storage_map_alloc(attr, &task_cache, true);
 }
 
 static void task_storage_map_free(struct bpf_map *map)
diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
index 24c3dc0d62e5..8b87b143ba26 100644
--- a/net/core/bpf_sk_storage.c
+++ b/net/core/bpf_sk_storage.c
@@ -68,7 +68,7 @@ static void bpf_sk_storage_map_free(struct bpf_map *map)
 
 static struct bpf_map *bpf_sk_storage_map_alloc(union bpf_attr *attr)
 {
-	return bpf_local_storage_map_alloc(attr, &sk_cache);
+	return bpf_local_storage_map_alloc(attr, &sk_cache, false);
 }
 
 static int notsupp_get_next_key(struct bpf_map *map, void *key,
-- 
2.34.1

