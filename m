Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F26986A9937
	for <lists+bpf@lfdr.de>; Fri,  3 Mar 2023 15:16:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231278AbjCCOP5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 3 Mar 2023 09:15:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230484AbjCCOPy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 3 Mar 2023 09:15:54 -0500
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3876B1ADFB
        for <bpf@vger.kernel.org>; Fri,  3 Mar 2023 06:15:46 -0800 (PST)
Received: by mail-ed1-x544.google.com with SMTP id cw28so10916774edb.5
        for <bpf@vger.kernel.org>; Fri, 03 Mar 2023 06:15:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677852944;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IGwbqAS+qW8ne/ST2xg9mY0FF8Kj3qdGmgur+En9BmE=;
        b=Eiqy6SFfFIBcMFuqpUR6Obu0uShO3tlFIDbdUhs+bUfAaikQaWxqLsTvEgVHKflsK7
         NwrQaWGehCPs7zIHb6GZTBWXqSy9ObZk3l7xxAzkRTc5/4rLVrUKRwSggVB+dzMJHAtc
         hB8eZuk7+PLx+D9S/wU8gZ0xe1RVeEyNt9dirvA/3Elqh/D9ecVMmVWLNIwM/wIPqycd
         LzMS4dj1Yr/v7JaZI86I6bf5xVgh4kTzQ9IcTihs8PApI02jnrFbWtct9O3MwyZds2Nz
         6iGsXIQ6UQ1agVK7TwjBVhh29uvlEtunKLz3R2LFsuahvDt6+t2xCB7TjHnWKEMCaXp7
         G3aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677852944;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IGwbqAS+qW8ne/ST2xg9mY0FF8Kj3qdGmgur+En9BmE=;
        b=xoJfV4oeGQGn/L6NfjsSLh7ARi2CgLKJEsmDEIM/IV8rJiob/7Plhw8DP3qxVCMdka
         ygH7J1R2dpw3sToTWvgLNDX7YR0ub5IvvexHmbSW4Glyyhyi1aQAxFlXzArwXUef0uO1
         htjhiZ6OrEHWgznKMran03HPQidUriQL5z+S7rmTanGgBQBsnq6/Th9akUiwq7CZYab3
         XZJZTCebE4G9UtxgsL5Ywvv4tsYSjyiMX8LWnbSJngDJAK5jliZ4I4euN1/+hefjHAeJ
         /6+Sqlf8thvcgdBHsgJLlcoJscBdvc1ehatlv5mrBoDmqqYEq0ZBdnDA4cRm0OIhKGXY
         ERwg==
X-Gm-Message-State: AO0yUKXeiMvVG2wKV6o31cnTgT7g+erqI9piIBAfp5Uv11uyDjmMgy4J
        54Rgx/6AoSFQRvlJ0HQDrlR/RKz8YN6Alw==
X-Google-Smtp-Source: AK7set9a7Oju0hAwURx+XmzwEH3G2j4RCBUR9v5hJpEhCLASkQmzw2ruKHY97FOr3ihoEw4Z6Mg5dA==
X-Received: by 2002:a17:906:539a:b0:88d:f759:15ae with SMTP id g26-20020a170906539a00b0088df75915aemr1744459ejo.42.1677852943773;
        Fri, 03 Mar 2023 06:15:43 -0800 (PST)
Received: from localhost ([2001:620:618:580:2:80b3:0:d0])
        by smtp.gmail.com with ESMTPSA id h25-20020a1709063b5900b008d0dbf15b8bsm983230ejf.212.2023.03.03.06.15.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Mar 2023 06:15:43 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        KP Singh <kpsingh@kernel.org>
Subject: [PATCH bpf-next] bpf: Use separate RCU callbacks for freeing selem
Date:   Fri,  3 Mar 2023 15:15:42 +0100
Message-Id: <20230303141542.300068-1-memxor@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Martin suggested that instead of using a byte in the hole (which he has
a use for in his future patch) in bpf_local_storage_elem, we can
dispatch a different call_rcu callback based on whether we need to free
special fields in bpf_local_storage_elem data. The free path, described
in commit 9db44fdd8105 ("bpf: Support kptrs in local storage maps"),
only waits for call_rcu callbacks when there are special (kptrs, etc.)
fields in the map value, hence it is necessary that we only access
smap in this case.

Therefore, dispatch different RCU callbacks based on the BPF map has a
valid btf_record, which dereference and use smap's btf_record only when
it is valid.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf_local_storage.h |  6 ---
 kernel/bpf/bpf_local_storage.c    | 76 +++++++++++++++++++------------
 2 files changed, 46 insertions(+), 36 deletions(-)

diff --git a/include/linux/bpf_local_storage.h b/include/linux/bpf_local_storage.h
index 0fe92986412b..6d37a40cd90e 100644
--- a/include/linux/bpf_local_storage.h
+++ b/include/linux/bpf_local_storage.h
@@ -74,12 +74,6 @@ struct bpf_local_storage_elem {
 	struct hlist_node snode;	/* Linked to bpf_local_storage */
 	struct bpf_local_storage __rcu *local_storage;
 	struct rcu_head rcu;
-	bool can_use_smap; /* Is it safe to access smap in bpf_selem_free_* RCU
-			    * callbacks? bpf_local_storage_map_free only
-			    * executes rcu_barrier when there are special
-			    * fields, this field remembers that to ensure we
-			    * don't access already freed smap in sdata.
-			    */
 	/* 8 bytes hole */
 	/* The data is stored in another cacheline to minimize
 	 * the number of cachelines access during a cache hit.
diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
index 2bdd722fe293..3b4caf1d86d1 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -109,30 +109,33 @@ void bpf_local_storage_free_rcu(struct rcu_head *rcu)
 		kfree_rcu(local_storage, rcu);
 }

-static void bpf_selem_free_rcu(struct rcu_head *rcu)
+static void bpf_selem_free_fields_rcu(struct rcu_head *rcu)
 {
 	struct bpf_local_storage_elem *selem;

 	selem = container_of(rcu, struct bpf_local_storage_elem, rcu);
-	/* The can_use_smap bool is set whenever we need to free additional
-	 * fields in selem data before freeing selem. bpf_local_storage_map_free
-	 * only executes rcu_barrier to wait for RCU callbacks when it has
-	 * special fields, hence we can only conditionally dereference smap, as
-	 * by this time the map might have already been freed without waiting
-	 * for our call_rcu callback if it did not have any special fields.
-	 */
-	if (selem->can_use_smap)
-		bpf_obj_free_fields(SDATA(selem)->smap->map.record, SDATA(selem)->data);
+	bpf_obj_free_fields(SDATA(selem)->smap->map.record, SDATA(selem)->data);
 	kfree(selem);
 }

-static void bpf_selem_free_tasks_trace_rcu(struct rcu_head *rcu)
+static void bpf_selem_free_fields_trace_rcu(struct rcu_head *rcu)
 {
 	/* Free directly if Tasks Trace RCU GP also implies RCU GP */
 	if (rcu_trace_implies_rcu_gp())
-		bpf_selem_free_rcu(rcu);
+		bpf_selem_free_fields_rcu(rcu);
 	else
-		call_rcu(rcu, bpf_selem_free_rcu);
+		call_rcu(rcu, bpf_selem_free_fields_rcu);
+}
+
+static void bpf_selem_free_trace_rcu(struct rcu_head *rcu)
+{
+	struct bpf_local_storage_elem *selem;
+
+	selem = container_of(rcu, struct bpf_local_storage_elem, rcu);
+	if (rcu_trace_implies_rcu_gp())
+		kfree(selem);
+	else
+		kfree_rcu(selem, rcu);
 }

 /* local_storage->lock must be held and selem->local_storage == local_storage.
@@ -145,6 +148,7 @@ static bool bpf_selem_unlink_storage_nolock(struct bpf_local_storage *local_stor
 {
 	struct bpf_local_storage_map *smap;
 	bool free_local_storage;
+	struct btf_record *rec;
 	void *owner;

 	smap = rcu_dereference_check(SDATA(selem)->smap, bpf_rcu_lock_held());
@@ -185,10 +189,26 @@ static bool bpf_selem_unlink_storage_nolock(struct bpf_local_storage *local_stor
 	    SDATA(selem))
 		RCU_INIT_POINTER(local_storage->cache[smap->cache_idx], NULL);

-	if (use_trace_rcu)
-		call_rcu_tasks_trace(&selem->rcu, bpf_selem_free_tasks_trace_rcu);
-	else
-		call_rcu(&selem->rcu, bpf_selem_free_rcu);
+	/* A different RCU callback is chosen whenever we need to free
+	 * additional fields in selem data before freeing selem.
+	 * bpf_local_storage_map_free only executes rcu_barrier to wait for RCU
+	 * callbacks when it has special fields, hence we can only conditionally
+	 * dereference smap, as by this time the map might have already been
+	 * freed without waiting for our call_rcu callback if it did not have
+	 * any special fields.
+	 */
+	rec = SDATA(selem)->smap->map.record;
+	if (use_trace_rcu) {
+		if (!IS_ERR_OR_NULL(rec))
+			call_rcu_tasks_trace(&selem->rcu, bpf_selem_free_fields_trace_rcu);
+		else
+			call_rcu_tasks_trace(&selem->rcu, bpf_selem_free_trace_rcu);
+	} else {
+		if (!IS_ERR_OR_NULL(rec))
+			call_rcu(&selem->rcu, bpf_selem_free_fields_rcu);
+		else
+			kfree_rcu(selem, rcu);
+	}

 	return free_local_storage;
 }
@@ -256,11 +276,6 @@ void bpf_selem_link_map(struct bpf_local_storage_map *smap,
 	RCU_INIT_POINTER(SDATA(selem)->smap, smap);
 	hlist_add_head_rcu(&selem->map_node, &b->list);
 	raw_spin_unlock_irqrestore(&b->lock, flags);
-
-	/* If our data will have special fields, smap will wait for us to use
-	 * its record in bpf_selem_free_* RCU callbacks before freeing itself.
-	 */
-	selem->can_use_smap = !IS_ERR_OR_NULL(smap->map.record);
 }

 void bpf_selem_unlink(struct bpf_local_storage_elem *selem, bool use_trace_rcu)
@@ -748,19 +763,20 @@ void bpf_local_storage_map_free(struct bpf_map *map,
 	kvfree(smap->buckets);

 	/* When local storage has special fields, callbacks for
-	 * bpf_selem_free_rcu and bpf_selem_free_tasks_trace_rcu will keep using
-	 * the map BTF record, we need to execute an RCU barrier to wait for
-	 * them as the record will be freed right after our map_free callback.
+	 * bpf_selem_free_fields_rcu and bpf_selem_free_fields_trace_rcu will
+	 * keep using the map BTF record, we need to execute an RCU barrier to
+	 * wait for them as the record will be freed right after our map_free
+	 * callback.
 	 */
 	if (!IS_ERR_OR_NULL(smap->map.record)) {
 		rcu_barrier_tasks_trace();
 		/* We cannot skip rcu_barrier() when rcu_trace_implies_rcu_gp()
 		 * is true, because while call_rcu invocation is skipped in that
-		 * case in bpf_selem_free_tasks_trace_rcu (and all local storage
-		 * maps pass use_trace_rcu = true), there can be call_rcu
-		 * callbacks based on use_trace_rcu = false in the earlier while
-		 * ((selem = ...)) loop or from bpf_local_storage_unlink_nolock
-		 * called from owner's free path.
+		 * case in bpf_selem_free_fields_trace_rcu (and all local
+		 * storage maps pass use_trace_rcu = true), there can be
+		 * call_rcu callbacks based on use_trace_rcu = false in the
+		 * while ((selem = ...)) loop above or when owner's free path
+		 * calls bpf_local_storage_unlink_nolock.
 		 */
 		rcu_barrier();
 	}
--
2.39.2

