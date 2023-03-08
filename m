Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8BD16AFF5D
	for <lists+bpf@lfdr.de>; Wed,  8 Mar 2023 08:00:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbjCHHAb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Mar 2023 02:00:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbjCHHA0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Mar 2023 02:00:26 -0500
Received: from out-12.mta1.migadu.com (out-12.mta1.migadu.com [95.215.58.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAA2BA1FE6
        for <bpf@vger.kernel.org>; Tue,  7 Mar 2023 23:00:23 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1678258821;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cMUCVmSq0W7vfjBm8N9Gd4GB55UlTLVR2QnNEGeNGyA=;
        b=h/M8ydF6SgUKwOD6AIh/FzvvrZ2FUgUmh75UxbYNnkfZA3y5hNUqIPbpEBY2Z3+5iwTQGF
        6eAjQMbQaCRt4RAKpMoOA8BVFz12b59Lr1igoFtzzqUFKP+XP17KknMvmxAQjazUqeBo28
        g2fcrv5SS2py6F2razrIkYVgnNH8C1Y=
From:   Martin KaFai Lau <martin.lau@linux.dev>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@meta.com,
        Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH v2 bpf-next 13/17] bpf: Use bpf_mem_cache_alloc/free in bpf_selem_alloc/free
Date:   Tue,  7 Mar 2023 22:59:32 -0800
Message-Id: <20230308065936.1550103-14-martin.lau@linux.dev>
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

This patch uses bpf_mem_cache_alloc/free in bpf_selem_alloc/free.

The ____cacheline_aligned attribute is no longer needed
in 'struct bpf_local_storage_elem'. bpf_mem_cache_alloc will
have 'struct llist_node' in front of the 'struct bpf_local_storage_elem'.
It will use the 8bytes hole in the bpf_local_storage_elem.

After bpf_mem_cache_alloc(), the SDATA(selem)->data is zero-ed because
bpf_mem_cache_alloc() could return a reused selem. It is to keep
the existing bpf_map_kzalloc() behavior. Only SDATA(selem)->data
is zero-ed. SDATA(selem)->data is the visible part to the bpf prog.
No need to use zero_map_value() to do the zeroing because
bpf_selem_free() ensures no bpf prog is using the selem before
returning the selem through bpf_mem_cache_free(). For the internal
fields of selem, they will be initialized when linking to the
new smap and the new local_storage.

For the common selem free path where the selem is freed when its owner
is also being freed, reuse_now == true and selem can be reused
immediately. bpf_selem_free() uses bpf_mem_cache_free() where
selem will be considered for immediate reuse.

For the uncommon path that the bpf prog explicitly deletes the selem (by
using the helper bpf_*_storage_delete), the selem cannot be reused
immediately. reuse_now == false and bpf_selem_free() will stay with
the current call_rcu_tasks_trace.

Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
---
 include/linux/bpf_local_storage.h |  8 ++----
 kernel/bpf/bpf_local_storage.c    | 47 +++++++++++++++++++++++++------
 2 files changed, 41 insertions(+), 14 deletions(-)

diff --git a/include/linux/bpf_local_storage.h b/include/linux/bpf_local_storage.h
index a34f61467a2f..550da364c8f9 100644
--- a/include/linux/bpf_local_storage.h
+++ b/include/linux/bpf_local_storage.h
@@ -13,6 +13,7 @@
 #include <linux/list.h>
 #include <linux/hash.h>
 #include <linux/types.h>
+#include <linux/bpf_mem_alloc.h>
 #include <uapi/linux/btf.h>
 
 #define BPF_LOCAL_STORAGE_CACHE_SIZE	16
@@ -55,6 +56,7 @@ struct bpf_local_storage_map {
 	u32 bucket_log;
 	u16 elem_size;
 	u16 cache_idx;
+	struct bpf_mem_alloc selem_ma;
 };
 
 struct bpf_local_storage_data {
@@ -74,11 +76,7 @@ struct bpf_local_storage_elem {
 	struct hlist_node snode;	/* Linked to bpf_local_storage */
 	struct bpf_local_storage __rcu *local_storage;
 	struct rcu_head rcu;
-	/* 8 bytes hole */
-	/* The data is stored in another cacheline to minimize
-	 * the number of cachelines access during a cache hit.
-	 */
-	struct bpf_local_storage_data sdata ____cacheline_aligned;
+	struct bpf_local_storage_data sdata;
 };
 
 struct bpf_local_storage {
diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
index 351d991694cb..228abb6b6e64 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -80,12 +80,23 @@ bpf_selem_alloc(struct bpf_local_storage_map *smap, void *owner,
 	if (charge_mem && mem_charge(smap, owner, smap->elem_size))
 		return NULL;
 
-	selem = bpf_map_kzalloc(&smap->map, smap->elem_size,
-				gfp_flags | __GFP_NOWARN);
+	migrate_disable();
+	selem = bpf_mem_cache_alloc_flags(&smap->selem_ma, gfp_flags);
+	migrate_enable();
+
 	if (selem) {
 		if (value)
 			copy_map_value(&smap->map, SDATA(selem)->data, value);
-		/* No need to call check_and_init_map_value as memory is zero init */
+		else
+			/* Keep the original bpf_map_kzalloc behavior
+			 * before started using the bpf_mem_cache_alloc.
+			 *
+			 * No need to use zero_map_value. The bpf_selem_free()
+			 * only does bpf_mem_cache_free when there is
+			 * no other bpf prog is using the selem.
+			 */
+			memset(SDATA(selem)->data, 0, smap->map.value_size);
+
 		return selem;
 	}
 
@@ -129,7 +140,7 @@ static void bpf_selem_free_rcu(struct rcu_head *rcu)
 	struct bpf_local_storage_elem *selem;
 
 	selem = container_of(rcu, struct bpf_local_storage_elem, rcu);
-	kfree(selem);
+	bpf_mem_cache_raw_free(selem);
 }
 
 static void bpf_selem_free_trace_rcu(struct rcu_head *rcu)
@@ -145,10 +156,17 @@ void bpf_selem_free(struct bpf_local_storage_elem *selem,
 		    bool reuse_now)
 {
 	bpf_obj_free_fields(smap->map.record, SDATA(selem)->data);
-	if (!reuse_now)
+	if (!reuse_now) {
 		call_rcu_tasks_trace(&selem->rcu, bpf_selem_free_trace_rcu);
-	else
-		call_rcu(&selem->rcu, bpf_selem_free_rcu);
+	} else {
+		/* Instead of using the vanilla call_rcu(),
+		 * bpf_mem_cache_free should be able to reuse selem
+		 * immediately.
+		 */
+		migrate_disable();
+		bpf_mem_cache_free(&smap->selem_ma, selem);
+		migrate_enable();
+	}
 }
 
 /* local_storage->lock must be held and selem->local_storage == local_storage.
@@ -661,6 +679,7 @@ bpf_local_storage_map_alloc(union bpf_attr *attr,
 	struct bpf_local_storage_map *smap;
 	unsigned int i;
 	u32 nbuckets;
+	int err;
 
 	smap = bpf_map_area_alloc(sizeof(*smap), NUMA_NO_NODE);
 	if (!smap)
@@ -675,8 +694,8 @@ bpf_local_storage_map_alloc(union bpf_attr *attr,
 	smap->buckets = bpf_map_kvcalloc(&smap->map, sizeof(*smap->buckets),
 					 nbuckets, GFP_USER | __GFP_NOWARN);
 	if (!smap->buckets) {
-		bpf_map_area_free(smap);
-		return ERR_PTR(-ENOMEM);
+		err = -ENOMEM;
+		goto free_smap;
 	}
 
 	for (i = 0; i < nbuckets; i++) {
@@ -687,8 +706,17 @@ bpf_local_storage_map_alloc(union bpf_attr *attr,
 	smap->elem_size = offsetof(struct bpf_local_storage_elem,
 				   sdata.data[attr->value_size]);
 
+	err = bpf_mem_alloc_init(&smap->selem_ma, smap->elem_size, false);
+	if (err)
+		goto free_smap;
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
@@ -754,6 +782,7 @@ void bpf_local_storage_map_free(struct bpf_map *map,
 	 */
 	synchronize_rcu();
 
+	bpf_mem_alloc_destroy(&smap->selem_ma);
 	kvfree(smap->buckets);
 	bpf_map_area_free(smap);
 }
-- 
2.34.1

