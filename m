Return-Path: <bpf+bounces-74558-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DE23DC5F33D
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 21:15:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CAD7A35F167
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 20:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D048F34A789;
	Fri, 14 Nov 2025 20:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QYLlTE4d"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E17934B400
	for <bpf@vger.kernel.org>; Fri, 14 Nov 2025 20:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763151217; cv=none; b=O+AAasDEZ4XYsFhSjUQDBFUGIFFW7DqrBwkqPGygV8vPuQZd1/oezt/6YWVN+IMSku8bAi1r37t0TQNRf3GcptAYiOUgTbeGclDKc7f0y6L5jFoFlP34TGV+07qVNTzWRWXNaelSaHnJHjH38hRzU0buimLECDg9MwLcOjtXcTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763151217; c=relaxed/simple;
	bh=kbhGoL2OUZ51anXjoKN/x2CncJfIrIJ1YGouPzCYEFI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S2ZjnVDCcpg+jkxALdXa8BXOuvxcqUcNEARAh/IjvFANzJammmRWsrIQ9PADFKUOHTwJUZJ9n9jmtpJ/l8AsQL/GfykEO24rQgGz3WOVEU/onFGioCd80mVG0bMyliSCrGub/5rqzxEYs/8hOp5L8wcIHMHxbfKPzgo3+WoKVB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QYLlTE4d; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-295548467c7so27531685ad.2
        for <bpf@vger.kernel.org>; Fri, 14 Nov 2025 12:13:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763151214; x=1763756014; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FWE91845IdpI31s4AZ87C0vk3YU0CQoyA1bah1R7u3Q=;
        b=QYLlTE4dtwTqQ/kBDAriEUInPY2ZLpezM9f8XcPq8rgXdNbIogiNWNSAxFw7A1d5dn
         PCouPby+U0cbTWkaZ0hm09ZLBIc9fXy71+sf6pikQjX+0S2hHEnqTa2Dti4Eujm41Su1
         cq9CzsNnCEzHOcDyqFBWqdNY6RsyKJD97ztxqmlgPqd3xleEtG2FxYuMYxGF5D1IhkFL
         vFWdgmCN7S3yUluLxgqlFm5858ghkb2YMENRsXoWP/8gPcPDUFIcRu36unwaaR+XLvWf
         PmWPFLyHGyM528uFvNicIi7s1kYr8Y8E6DfDuht005o8+7lY1gGQqvjmvfj5Wk/t4DR4
         9fSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763151214; x=1763756014;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FWE91845IdpI31s4AZ87C0vk3YU0CQoyA1bah1R7u3Q=;
        b=XbhBmUs0eGoJVQ2GvLFrsE8aoaC3aNHRVT9PlIvgOAou1i8oTsQG5tLzsgAp5fsjCq
         J3NT0BKyz8Otx4Ku4xATRxQMhuOdQ0vH24zS+gldeGsVDVVPboqvkSixloJRFJjXZGoh
         TGQoTcDr3epBeARbaSvLhzU0q/7lTGWKMKwQWH/wJkNwf42I0fKJa8B+/LsWDduFZ15e
         YvlU5rv5j70UQgX9AAP69r7gt6ZTAe3E16fop/TzjmuG7KEzPT6w3g91tICZMl6r6OhZ
         UvHdG+tEie8z0wIjdhAiTGgVMFAcmmvXwaux9sukh3XSO+CtHckxnhvf3FJDwHLG71hy
         g3yg==
X-Gm-Message-State: AOJu0Yx7p5UDG23WzSup/di8GifgRTKcZ4kJ2zzX9ta7eByCpzz97lUw
	vU1fPaxkAZvBVDVrA+zN1NYKNtpjSspGY4S7ez199wWdoMGf7Hce+dt+ogV7EA==
X-Gm-Gg: ASbGncvylvu6Ml+9GbMxJuk9XOkSc6/AXqcEA7SXk1GMCiJwcfu7Udxb63/aFk4j9SZ
	bHGkPMLv2HXTl7RuVV+oXgx2fS0Td2Xna7ARnjl9VcJF/xmuoRXhfFFD1sG2472ATJpVWY/RxqM
	t6EtGe3ji3bIkHri/alNTeukIEPxGJTTvE+JFOT5RJLV6IEWYyKI0jU2TOioIe+lY3HBEPgIwlj
	DoJffdRqPHNz7B7tfKYrNzi3fAOxbCxqq8NNtaRwyHizjwrRGZ8WBoLTJfn214SFhdFfhO76jwG
	u24oyvoy4M9MR2VhJ1OA0NFAKmub/RbcMODeXarBLsOEQWlUVzeRiZt15yroZi8MToNepEOEC7B
	hDZVB81kVwQIk3VJ70uk3RAJJUkxT/F4bZRlTJaOkwg5fZYxrZFjO996HHZ/Iyg/FhZUQE7MVUi
	rfPQ==
X-Google-Smtp-Source: AGHT+IFBl4V21VaSDlI+TntK89XKgXflzoMnnjsx4TELkLmnfAEHsz8OVMfg9+KiylQhPCztHwZMYQ==
X-Received: by 2002:a17:902:ebc6:b0:297:dd30:8f07 with SMTP id d9443c01a7336-2986a7438d0mr43129355ad.50.1763151214306;
        Fri, 14 Nov 2025 12:13:34 -0800 (PST)
Received: from localhost ([2a03:2880:ff:7::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2bed4fsm64402715ad.75.2025.11.14.12.13.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 12:13:33 -0800 (PST)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org,
	memxor@gmail.com,
	kpsingh@kernel.org,
	yonghong.song@linux.dev,
	song@kernel.org,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH v2 bpf-next 4/4] bpf: Replace bpf memory allocator with kmalloc_nolock() in local storage
Date: Fri, 14 Nov 2025 12:13:26 -0800
Message-ID: <20251114201329.3275875-5-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251114201329.3275875-1-ameryhung@gmail.com>
References: <20251114201329.3275875-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace bpf memory allocator with kmalloc_nolock() to reduce memory
wastage due to preallocation.

In bpf_selem_free(), an selem now needs to wait for a RCU grace period
before being freed when reuse_now == true. Therefore, rcu_barrier()
should be always be called in bpf_local_storage_map_free().

In bpf_local_storage_free(), since smap->storage_ma is no longer needed
to return the memory, the function is now independent from smap.

Remove the outdated comment in bpf_local_storage_alloc(). We already
free selem after an RCU grace period in bpf_local_storage_update() when
bpf_local_storage_alloc() failed the cmpxchg since commit c0d63f309186
("bpf: Add bpf_selem_free()").

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 include/linux/bpf_local_storage.h |   8 +-
 kernel/bpf/bpf_local_storage.c    | 152 +++++++++---------------------
 2 files changed, 48 insertions(+), 112 deletions(-)

diff --git a/include/linux/bpf_local_storage.h b/include/linux/bpf_local_storage.h
index 7fef0cec8340..66432248cd81 100644
--- a/include/linux/bpf_local_storage.h
+++ b/include/linux/bpf_local_storage.h
@@ -53,9 +53,7 @@ struct bpf_local_storage_map {
 	u32 bucket_log;
 	u16 elem_size;
 	u16 cache_idx;
-	struct bpf_mem_alloc selem_ma;
-	struct bpf_mem_alloc storage_ma;
-	bool bpf_ma;
+	bool use_kmalloc_nolock;
 };
 
 struct bpf_local_storage_data {
@@ -97,7 +95,7 @@ struct bpf_local_storage {
 				 */
 	struct rcu_head rcu;
 	raw_spinlock_t lock;	/* Protect adding/removing from the "list" */
-	bool bpf_ma;
+	bool use_kmalloc_nolock;
 };
 
 /* U16_MAX is much more than enough for sk local storage
@@ -131,7 +129,7 @@ int bpf_local_storage_map_alloc_check(union bpf_attr *attr);
 struct bpf_map *
 bpf_local_storage_map_alloc(union bpf_attr *attr,
 			    struct bpf_local_storage_cache *cache,
-			    bool bpf_ma);
+			    bool use_kmalloc_nolock);
 
 void __bpf_local_storage_insert_cache(struct bpf_local_storage *local_storage,
 				      struct bpf_local_storage_map *smap,
diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
index 3c04b9d85860..e2fe6c32822b 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -80,17 +80,9 @@ bpf_selem_alloc(struct bpf_local_storage_map *smap, void *owner,
 	if (mem_charge(smap, owner, smap->elem_size))
 		return NULL;
 
-	if (smap->bpf_ma) {
-		selem = bpf_mem_cache_alloc_flags(&smap->selem_ma, gfp_flags);
-		if (selem)
-			/* Keep the original bpf_map_kzalloc behavior
-			 * before started using the bpf_mem_cache_alloc.
-			 *
-			 * No need to use zero_map_value. The bpf_selem_free()
-			 * only does bpf_mem_cache_free when there is
-			 * no other bpf prog is using the selem.
-			 */
-			memset(SDATA(selem)->data, 0, smap->map.value_size);
+	if (smap->use_kmalloc_nolock) {
+		selem = bpf_map_kmalloc_nolock(&smap->map, smap->elem_size,
+					       __GFP_ZERO, NUMA_NO_NODE);
 	} else {
 		selem = bpf_map_kzalloc(&smap->map, smap->elem_size,
 					gfp_flags | __GFP_NOWARN);
@@ -113,7 +105,7 @@ bpf_selem_alloc(struct bpf_local_storage_map *smap, void *owner,
 	return NULL;
 }
 
-/* rcu tasks trace callback for bpf_ma == false */
+/* rcu tasks trace callback for use_kmalloc_nolock == false */
 static void __bpf_local_storage_free_trace_rcu(struct rcu_head *rcu)
 {
 	struct bpf_local_storage *local_storage;
@@ -128,12 +120,23 @@ static void __bpf_local_storage_free_trace_rcu(struct rcu_head *rcu)
 		kfree_rcu(local_storage, rcu);
 }
 
+/* Handle use_kmalloc_nolock == false */
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
 static void bpf_local_storage_free_rcu(struct rcu_head *rcu)
 {
 	struct bpf_local_storage *local_storage;
 
 	local_storage = container_of(rcu, struct bpf_local_storage, rcu);
-	bpf_mem_cache_raw_free(local_storage);
+	kfree_nolock(local_storage);
 }
 
 static void bpf_local_storage_free_trace_rcu(struct rcu_head *rcu)
@@ -144,46 +147,27 @@ static void bpf_local_storage_free_trace_rcu(struct rcu_head *rcu)
 		call_rcu(rcu, bpf_local_storage_free_rcu);
 }
 
-/* Handle bpf_ma == false */
-static void __bpf_local_storage_free(struct bpf_local_storage *local_storage,
-				     bool vanilla_rcu)
-{
-	if (vanilla_rcu)
-		kfree_rcu(local_storage, rcu);
-	else
-		call_rcu_tasks_trace(&local_storage->rcu,
-				     __bpf_local_storage_free_trace_rcu);
-}
-
 static void bpf_local_storage_free(struct bpf_local_storage *local_storage,
-				   struct bpf_local_storage_map *smap,
 				   bool reuse_now)
 {
 	if (!local_storage)
 		return;
 
-	if (!local_storage->bpf_ma) {
+	if (!local_storage->use_kmalloc_nolock) {
 		__bpf_local_storage_free(local_storage, reuse_now);
 		return;
 	}
 
-	if (!reuse_now) {
-		call_rcu_tasks_trace(&local_storage->rcu,
-				     bpf_local_storage_free_trace_rcu);
+	if (reuse_now) {
+		call_rcu(&local_storage->rcu, bpf_local_storage_free_rcu);
 		return;
 	}
 
-	if (smap)
-		bpf_mem_cache_free(&smap->storage_ma, local_storage);
-	else
-		/* smap could be NULL if the selem that triggered
-		 * this 'local_storage' creation had been long gone.
-		 * In this case, directly do call_rcu().
-		 */
-		call_rcu(&local_storage->rcu, bpf_local_storage_free_rcu);
+	call_rcu_tasks_trace(&local_storage->rcu,
+			     bpf_local_storage_free_trace_rcu);
 }
 
-/* rcu tasks trace callback for bpf_ma == false */
+/* rcu tasks trace callback for use_kmalloc_nolock == false */
 static void __bpf_selem_free_trace_rcu(struct rcu_head *rcu)
 {
 	struct bpf_local_storage_elem *selem;
@@ -195,7 +179,7 @@ static void __bpf_selem_free_trace_rcu(struct rcu_head *rcu)
 		kfree_rcu(selem, rcu);
 }
 
-/* Handle bpf_ma == false */
+/* Handle use_kmalloc_nolock == false */
 static void __bpf_selem_free(struct bpf_local_storage_elem *selem,
 			     bool vanilla_rcu)
 {
@@ -217,7 +201,7 @@ static void bpf_selem_free_rcu(struct rcu_head *rcu)
 	migrate_disable();
 	bpf_obj_free_fields(smap->map.record, SDATA(selem)->data);
 	migrate_enable();
-	bpf_mem_cache_raw_free(selem);
+	kfree_nolock(selem);
 }
 
 static void bpf_selem_free_trace_rcu(struct rcu_head *rcu)
@@ -235,11 +219,11 @@ void bpf_selem_free(struct bpf_local_storage_elem *selem,
 
 	smap = rcu_dereference_check(SDATA(selem)->smap, bpf_rcu_lock_held());
 
-	if (!smap->bpf_ma) {
-		/* Only task storage has uptrs and task storage
-		 * has moved to bpf_mem_alloc. Meaning smap->bpf_ma == true
-		 * for task storage, so this bpf_obj_free_fields() won't unpin
-		 * any uptr.
+	if (!smap->use_kmalloc_nolock) {
+		/*
+		 * No uptr will be unpin even when reuse_now == false since uptr
+		 * is only supported in task local storage, where
+		 * smap->use_kmalloc_nolock == true.
 		 */
 		bpf_obj_free_fields(smap->map.record, SDATA(selem)->data);
 		__bpf_selem_free(selem, reuse_now);
@@ -247,18 +231,11 @@ void bpf_selem_free(struct bpf_local_storage_elem *selem,
 	}
 
 	if (reuse_now) {
-		/* reuse_now == true only happens when the storage owner
-		 * (e.g. task_struct) is being destructed or the map itself
-		 * is being destructed (ie map_free). In both cases,
-		 * no bpf prog can have a hold on the selem. It is
-		 * safe to unpin the uptrs and free the selem now.
-		 */
-		bpf_obj_free_fields(smap->map.record, SDATA(selem)->data);
-		/* Instead of using the vanilla call_rcu(),
-		 * bpf_mem_cache_free will be able to reuse selem
-		 * immediately.
+		/*
+		 * While it is okay to call bpf_obj_free_fields() that unpins uptr when
+		 * reuse_now == true, keep it in bpf_selem_free_rcu() for simplicity.
 		 */
-		bpf_mem_cache_free(&smap->selem_ma, selem);
+		call_rcu(&selem->rcu, bpf_selem_free_rcu);
 		return;
 	}
 
@@ -339,7 +316,6 @@ static bool bpf_selem_unlink_storage_nolock(struct bpf_local_storage *local_stor
 static void bpf_selem_unlink_storage(struct bpf_local_storage_elem *selem,
 				     bool reuse_now)
 {
-	struct bpf_local_storage_map *storage_smap;
 	struct bpf_local_storage *local_storage;
 	bool free_local_storage = false;
 	HLIST_HEAD(selem_free_list);
@@ -351,8 +327,6 @@ static void bpf_selem_unlink_storage(struct bpf_local_storage_elem *selem,
 
 	local_storage = rcu_dereference_check(selem->local_storage,
 					      bpf_rcu_lock_held());
-	storage_smap = rcu_dereference_check(local_storage->smap,
-					     bpf_rcu_lock_held());
 
 	raw_spin_lock_irqsave(&local_storage->lock, flags);
 	if (likely(selem_linked_to_storage(selem)))
@@ -363,7 +337,7 @@ static void bpf_selem_unlink_storage(struct bpf_local_storage_elem *selem,
 	bpf_selem_free_list(&selem_free_list, reuse_now);
 
 	if (free_local_storage)
-		bpf_local_storage_free(local_storage, storage_smap, reuse_now);
+		bpf_local_storage_free(local_storage, reuse_now);
 }
 
 void bpf_selem_link_storage_nolock(struct bpf_local_storage *local_storage,
@@ -456,8 +430,9 @@ int bpf_local_storage_alloc(void *owner,
 	if (err)
 		return err;
 
-	if (smap->bpf_ma)
-		storage = bpf_mem_cache_alloc_flags(&smap->storage_ma, gfp_flags);
+	if (smap->use_kmalloc_nolock)
+		storage = bpf_map_kmalloc_nolock(&smap->map, sizeof(*storage),
+						 __GFP_ZERO, NUMA_NO_NODE);
 	else
 		storage = bpf_map_kzalloc(&smap->map, sizeof(*storage),
 					  gfp_flags | __GFP_NOWARN);
@@ -470,7 +445,7 @@ int bpf_local_storage_alloc(void *owner,
 	INIT_HLIST_HEAD(&storage->list);
 	raw_spin_lock_init(&storage->lock);
 	storage->owner = owner;
-	storage->bpf_ma = smap->bpf_ma;
+	storage->use_kmalloc_nolock = smap->use_kmalloc_nolock;
 
 	bpf_selem_link_storage_nolock(storage, first_selem);
 	bpf_selem_link_map(smap, first_selem);
@@ -492,22 +467,12 @@ int bpf_local_storage_alloc(void *owner,
 		bpf_selem_unlink_map(first_selem);
 		err = -EAGAIN;
 		goto uncharge;
-
-		/* Note that even first_selem was linked to smap's
-		 * bucket->list, first_selem can be freed immediately
-		 * (instead of kfree_rcu) because
-		 * bpf_local_storage_map_free() does a
-		 * synchronize_rcu_mult (waiting for both sleepable and
-		 * normal programs) before walking the bucket->list.
-		 * Hence, no one is accessing selem from the
-		 * bucket->list under rcu_read_lock().
-		 */
 	}
 
 	return 0;
 
 uncharge:
-	bpf_local_storage_free(storage, smap, true);
+	bpf_local_storage_free(storage, true);
 	mem_uncharge(smap, owner, sizeof(*storage));
 	return err;
 }
@@ -694,15 +659,12 @@ int bpf_local_storage_map_check_btf(const struct bpf_map *map,
 
 void bpf_local_storage_destroy(struct bpf_local_storage *local_storage)
 {
-	struct bpf_local_storage_map *storage_smap;
 	struct bpf_local_storage_elem *selem;
 	bool free_storage = false;
 	HLIST_HEAD(free_selem_list);
 	struct hlist_node *n;
 	unsigned long flags;
 
-	storage_smap = rcu_dereference_check(local_storage->smap, bpf_rcu_lock_held());
-
 	/* Neither the bpf_prog nor the bpf_map's syscall
 	 * could be modifying the local_storage->list now.
 	 * Thus, no elem can be added to or deleted from the
@@ -732,7 +694,7 @@ void bpf_local_storage_destroy(struct bpf_local_storage *local_storage)
 	bpf_selem_free_list(&free_selem_list, true);
 
 	if (free_storage)
-		bpf_local_storage_free(local_storage, storage_smap, true);
+		bpf_local_storage_free(local_storage, true);
 }
 
 u64 bpf_local_storage_map_mem_usage(const struct bpf_map *map)
@@ -745,20 +707,10 @@ u64 bpf_local_storage_map_mem_usage(const struct bpf_map *map)
 	return usage;
 }
 
-/* When bpf_ma == true, the bpf_mem_alloc is used to allocate and free memory.
- * A deadlock free allocator is useful for storage that the bpf prog can easily
- * get a hold of the owner PTR_TO_BTF_ID in any context. eg. bpf_get_current_task_btf.
- * The task and cgroup storage fall into this case. The bpf_mem_alloc reuses
- * memory immediately. To be reuse-immediate safe, the owner destruction
- * code path needs to go through a rcu grace period before calling
- * bpf_local_storage_destroy().
- *
- * When bpf_ma == false, the kmalloc and kfree are used.
- */
 struct bpf_map *
 bpf_local_storage_map_alloc(union bpf_attr *attr,
 			    struct bpf_local_storage_cache *cache,
-			    bool bpf_ma)
+			    bool use_kmalloc_nolock)
 {
 	struct bpf_local_storage_map *smap;
 	unsigned int i;
@@ -792,20 +744,9 @@ bpf_local_storage_map_alloc(union bpf_attr *attr,
 
 	/* In PREEMPT_RT, kmalloc(GFP_ATOMIC) is still not safe in non
 	 * preemptible context. Thus, enforce all storages to use
-	 * bpf_mem_alloc when CONFIG_PREEMPT_RT is enabled.
+	 * kmalloc_nolock() when CONFIG_PREEMPT_RT is enabled.
 	 */
-	smap->bpf_ma = IS_ENABLED(CONFIG_PREEMPT_RT) ? true : bpf_ma;
-	if (smap->bpf_ma) {
-		err = bpf_mem_alloc_init(&smap->selem_ma, smap->elem_size, false);
-		if (err)
-			goto free_smap;
-
-		err = bpf_mem_alloc_init(&smap->storage_ma, sizeof(struct bpf_local_storage), false);
-		if (err) {
-			bpf_mem_alloc_destroy(&smap->selem_ma);
-			goto free_smap;
-		}
-	}
+	smap->use_kmalloc_nolock = IS_ENABLED(CONFIG_PREEMPT_RT) ? true : use_kmalloc_nolock;
 
 	smap->cache_idx = bpf_local_storage_cache_idx_get(cache);
 	return &smap->map;
@@ -875,12 +816,9 @@ void bpf_local_storage_map_free(struct bpf_map *map,
 	 */
 	synchronize_rcu();
 
-	if (smap->bpf_ma) {
+	if (smap->use_kmalloc_nolock) {
 		rcu_barrier_tasks_trace();
-		if (!rcu_trace_implies_rcu_gp())
-			rcu_barrier();
-		bpf_mem_alloc_destroy(&smap->selem_ma);
-		bpf_mem_alloc_destroy(&smap->storage_ma);
+		rcu_barrier();
 	}
 	kvfree(smap->buckets);
 	bpf_map_area_free(smap);
-- 
2.47.3


