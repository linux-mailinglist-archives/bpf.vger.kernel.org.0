Return-Path: <bpf+bounces-77013-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F87BCCD124
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 19:01:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3107B30A321C
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 17:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC63A3081D7;
	Thu, 18 Dec 2025 17:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fkFOZNJF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2AB30103A
	for <bpf@vger.kernel.org>; Thu, 18 Dec 2025 17:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766080600; cv=none; b=JfwfpL1ihvTutGDmqVVn6XhJ8E4sgLMnHbsTeUWlrozex8pluIppXRQiUXAHii/GQEXpwaN4c9yL9qLfkz7AK488zGoqLKo7qtaVOHkgi1tXmmElznqmN9RDKV4GH7GxmPdK7KVlw1ZCetzLOzdj6mkxIS4lzreJMEW70VDjqdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766080600; c=relaxed/simple;
	bh=HcTKnP5hWjj4jfShdEOmvYnslLs1N5GW3FFvZiIsayc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JUB5zaZcr7a4wUrEA5rAMR83HT9PgV4O5M1Cd1v8Zqp7naWBtZ5NqAZUh5OdC2f/f+7qQ26rXRmnpGgrBlADD5oaDFsOGgyHNdTxe4obGwB0UolHDPUxsRoDbU1qBpdZVNDE4+7XEgnyRaW+0JnusvdEGd8Cw+TNgnCALmUIW0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fkFOZNJF; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2a110548cdeso12201865ad.0
        for <bpf@vger.kernel.org>; Thu, 18 Dec 2025 09:56:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766080596; x=1766685396; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=14WW0NFODytesHo+RsYhguguzc5sYzCn9e4nD8A3Nvw=;
        b=fkFOZNJFqn1IrFuW0sHwv/Vqrx3HzzUFlPooJWeFLU3eNdPY5k7Y1NbjTyQ2fIniFh
         ylEa/cB+Jz7A/39FRTDVERu/5U/0blPj6Tn5Wsgeo88knnK+ii27TjP0Sw409BCck+58
         1Q1EuJS1JScIokkqCd0otR54LWQ7S6EnUJzZroZLK+glVdwfAJTskGlAIJrxyM8SsOr0
         lDTj5/Au5dwGS4PtWSVDH6pTQxEy+pikZwBb0g4ttuAFZgNcrzJCS+ECiCeTmMFSdcvO
         EjOHng1oLD4N8fkKei61yLeLskXcNyIhFzYV7io/n0SBXgbIYhV6/RiokMmpT0BLpkwP
         LLqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766080596; x=1766685396;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=14WW0NFODytesHo+RsYhguguzc5sYzCn9e4nD8A3Nvw=;
        b=KsBrMa/k1zPENcn5hqPqxuAF2HBI07wxgRJ/eAwF4Fuybs6Mi6Z3hGXFjBkTvtt2Hz
         YFfnGQTdj0TV9l0V3W/CHa36QOEG7rztbYNmWHhS2oTzPRNxElRbYuEaljMl2QX56Xt1
         d7xdOe3QMZjOSBwEyC0ZIprQak0RzXzRjuZvehMtXxrRXmICPsQWFCuHAPDdNBv9Z17i
         Xm508D+1vsyeWmN9R3AOafyxT8qWQwAFoKuUZRk3iEtSFJayj8rZdBzhyWTEcz0EBAO4
         ut9Kz/tKefuyeBRFetM6+rjm3dcWcy4rj13s7iqgUchhDECumAXAJHTGpOZI/h7GGRNa
         5PEg==
X-Gm-Message-State: AOJu0Yx+P67Fq+x9xGt51aOXd6ZdhphdBDndz0FjXblDi7qpAQcsb2qB
	kv5UXajzIlIQbBqd6SvtfiyCXNArMOGAzI2vMX13iIPXeFBo0E4LUEU6zP3dcw==
X-Gm-Gg: AY/fxX4ceGysABmuosb5BXxZWMhDUmX3VzTu/v/6slqkTuLB5ANF5TR3QOfMd4s1/WW
	BMTRrwvCT6qTYp/YbroCK4kv+xYTaC0uujfdDuSldpS+leifLfOSC166S46ugyqnlHsIcqqnXri
	tvr3A8iFsAPRN2f2LN5SshOT6Ng1uRQCXVNK7kob30iS8Q3B6kjrB5mRUzx17Yy/j7xI1jaxZD7
	A5WwABi7Wzu4bI9wdSpV7j9dvCtYzsxEsNhQMWaHtuhSw89wvArAoqQYYW8jLhwEgFdmicbjM07
	+yGUs1pZ7Y2Jediynu5Iy2o8aUjVdFsPkHSK9sRtbDcMYuUnclxlgrQ2LaCp3xmFgvV0YnziW/t
	JfPmeXVikRE+ZKCSu+r/uqeUF+Rktf+9iSAQPSvCUmyBjbtx/u5xeoebipquCAKmMbMj3Qc85zw
	RGD3fhx7LPC1YeSg==
X-Google-Smtp-Source: AGHT+IFkQX+0t2XM2ihVsa7tkLG4X3GKoa4wWnodKBwPYoBK2PJQWFkbwfbxdnXSEFXVt+ztOght3w==
X-Received: by 2002:a17:90a:d60c:b0:34c:4c6d:ad0f with SMTP id 98e67ed59e1d1-34e921f0e35mr156896a91.37.1766080596437;
        Thu, 18 Dec 2025 09:56:36 -0800 (PST)
Received: from localhost ([2a03:2880:ff:4a::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34e769c347asm1173942a91.0.2025.12.18.09.56.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 09:56:35 -0800 (PST)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	memxor@gmail.com,
	martin.lau@kernel.org,
	kpsingh@kernel.org,
	yonghong.song@linux.dev,
	song@kernel.org,
	haoluo@google.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 05/16] bpf: Change local_storage->lock and b->lock to rqspinlock
Date: Thu, 18 Dec 2025 09:56:15 -0800
Message-ID: <20251218175628.1460321-6-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251218175628.1460321-1-ameryhung@gmail.com>
References: <20251218175628.1460321-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change bpf_local_storage::lock and bpf_local_storage_map_bucket::lock to
from raw_spin_lock to rqspinlock.

Finally, propagate errors from raw_res_spin_lock_irqsave() to syscall
return or BPF helper return.

In bpf_local_storage_destroy(), WARN_ON for now. A later patch will
handle this properly.

For, __bpf_local_storage_map_cache(), instead of handling the error,
skip updating the cache.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 include/linux/bpf_local_storage.h |  5 ++-
 kernel/bpf/bpf_local_storage.c    | 72 ++++++++++++++++++++-----------
 2 files changed, 51 insertions(+), 26 deletions(-)

diff --git a/include/linux/bpf_local_storage.h b/include/linux/bpf_local_storage.h
index a94e12ddd83d..903559e2ca91 100644
--- a/include/linux/bpf_local_storage.h
+++ b/include/linux/bpf_local_storage.h
@@ -15,12 +15,13 @@
 #include <linux/types.h>
 #include <linux/bpf_mem_alloc.h>
 #include <uapi/linux/btf.h>
+#include <asm/rqspinlock.h>
 
 #define BPF_LOCAL_STORAGE_CACHE_SIZE	16
 
 struct bpf_local_storage_map_bucket {
 	struct hlist_head list;
-	raw_spinlock_t lock;
+	rqspinlock_t lock;
 };
 
 /* Thp map is not the primary owner of a bpf_local_storage_elem.
@@ -94,7 +95,7 @@ struct bpf_local_storage {
 				 * bpf_local_storage_elem.
 				 */
 	struct rcu_head rcu;
-	raw_spinlock_t lock;	/* Protect adding/removing from the "list" */
+	rqspinlock_t lock;	/* Protect adding/removing from the "list" */
 	bool use_kmalloc_nolock;
 };
 
diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
index fa629a180e9e..1d21ec11c80e 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -325,6 +325,7 @@ static int bpf_selem_unlink_map(struct bpf_local_storage_elem *selem)
 	struct bpf_local_storage_map *smap;
 	struct bpf_local_storage_map_bucket *b;
 	unsigned long flags;
+	int err;
 
 	if (unlikely(!selem_linked_to_map_lockless(selem)))
 		/* selem has already be unlinked from smap */
@@ -332,10 +333,13 @@ static int bpf_selem_unlink_map(struct bpf_local_storage_elem *selem)
 
 	smap = rcu_dereference_check(SDATA(selem)->smap, bpf_rcu_lock_held());
 	b = select_bucket(smap, selem);
-	raw_spin_lock_irqsave(&b->lock, flags);
+	err = raw_res_spin_lock_irqsave(&b->lock, flags);
+	if (err)
+		return err;
+
 	if (likely(selem_linked_to_map(selem)))
 		hlist_del_init_rcu(&selem->map_node);
-	raw_spin_unlock_irqrestore(&b->lock, flags);
+	raw_res_spin_unlock_irqrestore(&b->lock, flags);
 
 	return 0;
 }
@@ -351,10 +355,14 @@ int bpf_selem_link_map(struct bpf_local_storage_map *smap,
 {
 	struct bpf_local_storage_map_bucket *b = select_bucket(smap, selem);
 	unsigned long flags;
+	int err;
+
+	err = raw_res_spin_lock_irqsave(&b->lock, flags);
+	if (err)
+		return err;
 
-	raw_spin_lock_irqsave(&b->lock, flags);
 	hlist_add_head_rcu(&selem->map_node, &b->list);
-	raw_spin_unlock_irqrestore(&b->lock, flags);
+	raw_res_spin_unlock_irqrestore(&b->lock, flags);
 
 	return 0;
 }
@@ -382,7 +390,10 @@ int bpf_selem_unlink(struct bpf_local_storage_elem *selem, bool reuse_now)
 	local_storage = rcu_dereference_check(selem->local_storage,
 					      bpf_rcu_lock_held());
 
-	raw_spin_lock_irqsave(&local_storage->lock, flags);
+	err = raw_res_spin_lock_irqsave(&local_storage->lock, flags);
+	if (err)
+		return err;
+
 	if (likely(selem_linked_to_storage(selem))) {
 		/* Always unlink from map before unlinking from local_storage
 		 * because selem will be freed after successfully unlinked from
@@ -396,7 +407,7 @@ int bpf_selem_unlink(struct bpf_local_storage_elem *selem, bool reuse_now)
 			local_storage, selem, &selem_free_list);
 	}
 out:
-	raw_spin_unlock_irqrestore(&local_storage->lock, flags);
+	raw_res_spin_unlock_irqrestore(&local_storage->lock, flags);
 
 	bpf_selem_free_list(&selem_free_list, reuse_now);
 
@@ -411,16 +422,20 @@ void __bpf_local_storage_insert_cache(struct bpf_local_storage *local_storage,
 				      struct bpf_local_storage_elem *selem)
 {
 	unsigned long flags;
+	int err;
 
 	/* spinlock is needed to avoid racing with the
 	 * parallel delete.  Otherwise, publishing an already
 	 * deleted sdata to the cache will become a use-after-free
 	 * problem in the next bpf_local_storage_lookup().
 	 */
-	raw_spin_lock_irqsave(&local_storage->lock, flags);
+	err = raw_res_spin_lock_irqsave(&local_storage->lock, flags);
+	if (err)
+		return;
+
 	if (selem_linked_to_storage(selem))
 		rcu_assign_pointer(local_storage->cache[smap->cache_idx], SDATA(selem));
-	raw_spin_unlock_irqrestore(&local_storage->lock, flags);
+	raw_res_spin_unlock_irqrestore(&local_storage->lock, flags);
 }
 
 static int check_flags(const struct bpf_local_storage_data *old_sdata,
@@ -465,14 +480,17 @@ int bpf_local_storage_alloc(void *owner,
 
 	RCU_INIT_POINTER(storage->smap, smap);
 	INIT_HLIST_HEAD(&storage->list);
-	raw_spin_lock_init(&storage->lock);
+	raw_res_spin_lock_init(&storage->lock);
 	storage->owner = owner;
 	storage->use_kmalloc_nolock = smap->use_kmalloc_nolock;
 
 	bpf_selem_link_storage_nolock(storage, first_selem);
 
 	b = select_bucket(smap, first_selem);
-	raw_spin_lock_irqsave(&b->lock, flags);
+	err = raw_res_spin_lock_irqsave(&b->lock, flags);
+	if (err)
+		goto uncharge;
+
 	bpf_selem_link_map_nolock(smap, first_selem, b);
 
 	owner_storage_ptr =
@@ -490,11 +508,11 @@ int bpf_local_storage_alloc(void *owner,
 	prev_storage = cmpxchg(owner_storage_ptr, NULL, storage);
 	if (unlikely(prev_storage)) {
 		bpf_selem_unlink_map_nolock(first_selem);
-		raw_spin_unlock_irqrestore(&b->lock, flags);
+		raw_res_spin_unlock_irqrestore(&b->lock, flags);
 		err = -EAGAIN;
 		goto uncharge;
 	}
-	raw_spin_unlock_irqrestore(&b->lock, flags);
+	raw_res_spin_unlock_irqrestore(&b->lock, flags);
 
 	return 0;
 
@@ -577,7 +595,9 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
 	if (!alloc_selem)
 		return ERR_PTR(-ENOMEM);
 
-	raw_spin_lock_irqsave(&local_storage->lock, flags);
+	err = raw_res_spin_lock_irqsave(&local_storage->lock, flags);
+	if (err)
+		return ERR_PTR(err);
 
 	/* Recheck local_storage->list under local_storage->lock */
 	if (unlikely(hlist_empty(&local_storage->list))) {
@@ -609,10 +629,15 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
 		old_b = old_b == b ? NULL : old_b;
 	}
 
-	raw_spin_lock_irqsave(&b->lock, b_flags);
+	err = raw_res_spin_lock_irqsave(&b->lock, b_flags);
+	if (err)
+		goto unlock;
 
-	if (old_b)
-		raw_spin_lock_irqsave(&old_b->lock, old_b_flags);
+	if (old_b) {
+		err = raw_res_spin_lock_irqsave(&old_b->lock, old_b_flags);
+		if (err)
+			goto unlock_b;
+	}
 
 	alloc_selem = NULL;
 	/* First, link the new selem to the map */
@@ -629,12 +654,11 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
 	}
 
 	if (old_b)
-		raw_spin_unlock_irqrestore(&old_b->lock, old_b_flags);
-
-	raw_spin_unlock_irqrestore(&b->lock, b_flags);
-
+		raw_res_spin_unlock_irqrestore(&old_b->lock, old_b_flags);
+unlock_b:
+	raw_res_spin_unlock_irqrestore(&b->lock, b_flags);
 unlock:
-	raw_spin_unlock_irqrestore(&local_storage->lock, flags);
+	raw_res_spin_unlock_irqrestore(&local_storage->lock, flags);
 	bpf_selem_free_list(&old_selem_free_list, false);
 	if (alloc_selem) {
 		mem_uncharge(smap, owner, smap->elem_size);
@@ -719,7 +743,7 @@ void bpf_local_storage_destroy(struct bpf_local_storage *local_storage)
 	 * when unlinking elem from the local_storage->list and
 	 * the map's bucket->list.
 	 */
-	raw_spin_lock_irqsave(&local_storage->lock, flags);
+	WARN_ON(raw_res_spin_lock_irqsave(&local_storage->lock, flags));
 	hlist_for_each_entry_safe(selem, n, &local_storage->list, snode) {
 		/* Always unlink from map before unlinking from
 		 * local_storage.
@@ -734,7 +758,7 @@ void bpf_local_storage_destroy(struct bpf_local_storage *local_storage)
 		free_storage = bpf_selem_unlink_storage_nolock(
 			local_storage, selem, &free_selem_list);
 	}
-	raw_spin_unlock_irqrestore(&local_storage->lock, flags);
+	raw_res_spin_unlock_irqrestore(&local_storage->lock, flags);
 
 	bpf_selem_free_list(&free_selem_list, true);
 
@@ -781,7 +805,7 @@ bpf_local_storage_map_alloc(union bpf_attr *attr,
 
 	for (i = 0; i < nbuckets; i++) {
 		INIT_HLIST_HEAD(&smap->buckets[i].list);
-		raw_spin_lock_init(&smap->buckets[i].lock);
+		raw_res_spin_lock_init(&smap->buckets[i].lock);
 	}
 
 	smap->elem_size = offsetof(struct bpf_local_storage_elem,
-- 
2.47.3


