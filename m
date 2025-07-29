Return-Path: <bpf+bounces-64662-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 618EEB152C4
	for <lists+bpf@lfdr.de>; Tue, 29 Jul 2025 20:27:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CEEA3B3D81
	for <lists+bpf@lfdr.de>; Tue, 29 Jul 2025 18:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 818A425333F;
	Tue, 29 Jul 2025 18:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D3bmlbJF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BDE424A04D;
	Tue, 29 Jul 2025 18:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753813559; cv=none; b=mbNUxM0/VFXQiPvkKcAW+yjcg9EADa/O2CegvAmr/qhcwJ//yq1QAE7STzKaVbt6ZGGN29I1ZCvRr/abKtZc0TL5EINbzvLiC7aJGCduHjTpVCMKCJSbXUabOPbrDlz58hCMp2VPNnWWOj+irWLRd0YDDsyydyXJU/M8IrAP1mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753813559; c=relaxed/simple;
	bh=tXXbF+OPohPSC0yFd3GPr/tiQzvv8v5GL8q918BL09w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UMiWFXax/rF1wkJ/x6J19+U7LsIEqMwvbWt9n878MrwBCTG+dKL8XRmYkTmx5QUj/dhCqBAEVBLieU2m4h0H5VH7esj6xFz6N0AehkHgBKrg5OzlX/idHe3lBFZq2+kDMcn+cttGyQaJaHXXDa+bufItrP/6zdTDL+RhYCvP20k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D3bmlbJF; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-879d2e419b9so4150748a12.2;
        Tue, 29 Jul 2025 11:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753813557; x=1754418357; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4nrbEPQVEbCduu2D4THQurGvPCEkXlbbgUko+Ho7hQg=;
        b=D3bmlbJFd0G7027MQy//cx5dN6WJs3YJhiIW8+3X1FNJxdq95u00rDXVLa9HqDy+CZ
         7Moc6O2eWTMMesahIA8WKtK1j0dkVXtE3hHszUK//z1yXX47Y4GaI0qKnseRrjWfq2WR
         WjJzAvEGoEpa7gFdmocoW4K0WXV+Cx9vCeJDSkVF6SZkG2hLoI4Bzz+AZOphIj4lXJ9q
         osav7F0akHbzSf/DqJZI9+vjB8f/xNwrE7uOIvfTLYj5ZwbC8FUHAN6hz3kMF8qO2ZAx
         iw/JLRj9iIBUuYTT0rwUsLJc9gItH3TQL5AYa3AZIu4FMayg0BAM4NOJAVV0Qha6hNJS
         FyXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753813557; x=1754418357;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4nrbEPQVEbCduu2D4THQurGvPCEkXlbbgUko+Ho7hQg=;
        b=nk+Y5Bzco3wbidusv0qba3h/aZyV5N/SZHF5b6+5Cdte8sQwdHnTc4KJX7wbma6yOL
         kU70M1jIQUC0pRLDjdfD6Oi4j/9Weo9dmGmDx9Nzgqtmy9RKKGxqeS76WEPMj27Lq4f8
         47YmZVzHVrhn5f9kyBPT3L+Xy6/UgM+2RIVpbsxM4K4cn8TvNjW2bUZoyguKHx+B0nW2
         Ld4l7I/2VlUk7/CoROr+tKenLJSE3SxxS+Hr5dDi2zs32cbVxLnu+wxiTb/5A6sn+NLk
         SGIcxiPuqIjDvU/gAn/s0Gq1bKrb6p8dfTrgxzmGVUalbz6f2+2h03veigTYArjuP7uS
         JXWw==
X-Gm-Message-State: AOJu0YzkecEeoLkhfZxxrbXmhxtqBdN72hzsRGkdYb18gNj6Wr4bYwKN
	121X5OHhfmCvfEexz+p6KCXWt6tt3M2kq/kxyid8chr7LNAdIZODDbtjPwQZZA==
X-Gm-Gg: ASbGncuOPDDJ1WXqFLxieFlH5XJyLCGtZHDMXsVl5aEf+u7/Ml/KaHGRB7qRJe3BSxV
	YVoOmvERV18P117wOKh1lwWbBA0OYKZ0hnH46Ckyd3llqTbaf4e0ybVUKG2lrBn+Pr0MioxoaY8
	iTkwCFVX/8LZX/ow2Yt8uD9cx8y3u3SUc40PciL1/mxEurMTTux2CmpzX5RoGETzr9zZYnRKEhU
	zOKal+cL9RYYsrzJembG7GUgshDpAmHU3Q0pZ6wiOQq2hbGENBvuZCkXyJZI6QoP5LCrKIJtkKp
	Eu4dzxztfY6LAHbq773kzgQdNh6429Tr60E41Pd+9Rq3AgCnRlltug7RAZ/HUC1fbu8cZiSbtQ4
	oNzNj4g0SDg7h3bjeNIZK7vQ=
X-Google-Smtp-Source: AGHT+IE3w8oSlFCL02U/ogPdLSd3dxhNEiUcmqL10HgbhBUpJe75Rllrih5UUV1jFQwsDwo9KLEt2A==
X-Received: by 2002:a05:6a20:1591:b0:23d:7b87:2c88 with SMTP id adf61e73a8af0-23dc0cf588cmr646475637.9.1753813557180;
        Tue, 29 Jul 2025 11:25:57 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:8::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3f7f58d831sm7562321a12.23.2025.07.29.11.25.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 11:25:56 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	memxor@gmail.com,
	kpsingh@kernel.org,
	martin.lau@kernel.org,
	yonghong.song@linux.dev,
	song@kernel.org,
	haoluo@google.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [RFC PATCH bpf-next v1 05/11] bpf: Change local_storage->lock and b->lock to rqspinlock
Date: Tue, 29 Jul 2025 11:25:43 -0700
Message-ID: <20250729182550.185356-6-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250729182550.185356-1-ameryhung@gmail.com>
References: <20250729182550.185356-1-ameryhung@gmail.com>
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
return or bpf helper return values.

For, __bpf_local_storage_map_cache(), instead of handling the error, skip
updating the cache.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 include/linux/bpf_local_storage.h |  5 +-
 kernel/bpf/bpf_local_storage.c    | 86 +++++++++++++++++++++----------
 2 files changed, 62 insertions(+), 29 deletions(-)

diff --git a/include/linux/bpf_local_storage.h b/include/linux/bpf_local_storage.h
index 26b7f53dad33..2a0aae5168fa 100644
--- a/include/linux/bpf_local_storage.h
+++ b/include/linux/bpf_local_storage.h
@@ -15,6 +15,7 @@
 #include <linux/types.h>
 #include <linux/bpf_mem_alloc.h>
 #include <uapi/linux/btf.h>
+#include <asm/rqspinlock.h>
 
 #define BPF_LOCAL_STORAGE_CACHE_SIZE	16
 
@@ -23,7 +24,7 @@
 	 rcu_read_lock_bh_held())
 struct bpf_local_storage_map_bucket {
 	struct hlist_head list;
-	raw_spinlock_t lock;
+	rqspinlock_t lock;
 };
 
 /* Thp map is not the primary owner of a bpf_local_storage_elem.
@@ -99,7 +100,7 @@ struct bpf_local_storage {
 				 * bpf_local_storage_elem.
 				 */
 	struct rcu_head rcu;
-	raw_spinlock_t lock;	/* Protect adding/removing from the "list" */
+	rqspinlock_t lock;	/* Protect adding/removing from the "list" */
 };
 
 /* U16_MAX is much more than enough for sk local storage
diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
index dda106f76491..5faa1df4fc50 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -383,6 +383,7 @@ static int bpf_selem_unlink_map(struct bpf_local_storage_elem *selem)
 	struct bpf_local_storage_map *smap;
 	struct bpf_local_storage_map_bucket *b;
 	unsigned long flags;
+	int ret;
 
 	if (unlikely(!selem_linked_to_map_lockless(selem)))
 		/* selem has already be unlinked from smap */
@@ -390,10 +391,13 @@ static int bpf_selem_unlink_map(struct bpf_local_storage_elem *selem)
 
 	smap = rcu_dereference_check(SDATA(selem)->smap, bpf_rcu_lock_held());
 	b = select_bucket(smap, selem);
-	raw_spin_lock_irqsave(&b->lock, flags);
+	ret = raw_res_spin_lock_irqsave(&b->lock, flags);
+	if (ret)
+		return ret;
+
 	if (likely(selem_linked_to_map(selem)))
 		hlist_del_init_rcu(&selem->map_node);
-	raw_spin_unlock_irqrestore(&b->lock, flags);
+	raw_res_spin_unlock_irqrestore(&b->lock, flags);
 
 	return 0;
 }
@@ -409,11 +413,15 @@ int bpf_selem_link_map(struct bpf_local_storage_map *smap,
 {
 	struct bpf_local_storage_map_bucket *b = select_bucket(smap, selem);
 	unsigned long flags;
+	int ret;
+
+	ret = raw_res_spin_lock_irqsave(&b->lock, flags);
+	if (ret)
+		return ret;
 
-	raw_spin_lock_irqsave(&b->lock, flags);
 	RCU_INIT_POINTER(SDATA(selem)->smap, smap);
 	hlist_add_head_rcu(&selem->map_node, &b->list);
-	raw_spin_unlock_irqrestore(&b->lock, flags);
+	raw_res_spin_unlock_irqrestore(&b->lock, flags);
 
 	return 0;
 }
@@ -435,6 +443,7 @@ int bpf_selem_unlink(struct bpf_local_storage_elem *selem, bool reuse_now)
 	struct bpf_local_storage_map_bucket *b;
 	struct bpf_local_storage_map *smap = NULL;
 	unsigned long flags, b_flags;
+	int ret = 0;
 
 	if (likely(selem_linked_to_map_lockless(selem))) {
 		smap = rcu_dereference_check(SDATA(selem)->smap, bpf_rcu_lock_held());
@@ -449,10 +458,16 @@ int bpf_selem_unlink(struct bpf_local_storage_elem *selem, bool reuse_now)
 		bpf_ma = check_storage_bpf_ma(local_storage, storage_smap, selem);
 	}
 
-	if (local_storage)
-		raw_spin_lock_irqsave(&local_storage->lock, flags);
-	if (smap)
-		raw_spin_lock_irqsave(&b->lock, b_flags);
+	if (local_storage) {
+		ret = raw_res_spin_lock_irqsave(&local_storage->lock, flags);
+		if (ret)
+			return ret;
+	}
+	if (smap) {
+		ret = raw_res_spin_lock_irqsave(&b->lock, b_flags);
+		if (ret)
+			goto unlock_storage;
+	}
 
 	/* Always unlink from map before unlinking from local_storage
 	 * because selem will be freed after successfully unlinked from
@@ -465,16 +480,17 @@ int bpf_selem_unlink(struct bpf_local_storage_elem *selem, bool reuse_now)
 			local_storage, selem, true, &selem_free_list);
 
 	if (smap)
-		raw_spin_unlock_irqrestore(&b->lock, b_flags);
+		raw_res_spin_unlock_irqrestore(&b->lock, b_flags);
+unlock_storage:
 	if (local_storage)
-		raw_spin_unlock_irqrestore(&local_storage->lock, flags);
+		raw_res_spin_unlock_irqrestore(&local_storage->lock, flags);
 
 	bpf_selem_free_list(&selem_free_list, reuse_now);
 
 	if (free_local_storage)
 		bpf_local_storage_free(local_storage, storage_smap, bpf_ma, reuse_now);
 
-	return 0;
+	return ret;
 }
 
 void __bpf_local_storage_insert_cache(struct bpf_local_storage *local_storage,
@@ -482,16 +498,20 @@ void __bpf_local_storage_insert_cache(struct bpf_local_storage *local_storage,
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
@@ -535,13 +555,16 @@ int bpf_local_storage_alloc(void *owner,
 
 	RCU_INIT_POINTER(storage->smap, smap);
 	INIT_HLIST_HEAD(&storage->list);
-	raw_spin_lock_init(&storage->lock);
+	raw_res_spin_lock_init(&storage->lock);
 	storage->owner = owner;
 
 	bpf_selem_link_storage_nolock(storage, first_selem);
 
 	b = select_bucket(smap, first_selem);
-	raw_spin_lock_irqsave(&b->lock, flags);
+	err = raw_res_spin_lock_irqsave(&b->lock, flags);
+	if (err)
+		goto uncharge;
+
 	bpf_selem_link_map_nolock(smap, first_selem, b);
 
 	owner_storage_ptr =
@@ -559,7 +582,7 @@ int bpf_local_storage_alloc(void *owner,
 	prev_storage = cmpxchg(owner_storage_ptr, NULL, storage);
 	if (unlikely(prev_storage)) {
 		bpf_selem_unlink_map_nolock(first_selem);
-		raw_spin_unlock_irqrestore(&b->lock, flags);
+		raw_res_spin_unlock_irqrestore(&b->lock, flags);
 		err = -EAGAIN;
 		goto uncharge;
 
@@ -573,7 +596,7 @@ int bpf_local_storage_alloc(void *owner,
 		 * bucket->list under rcu_read_lock().
 		 */
 	}
-	raw_spin_unlock_irqrestore(&b->lock, flags);
+	raw_res_spin_unlock_irqrestore(&b->lock, flags);
 
 	return 0;
 
@@ -656,7 +679,9 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
 	if (!alloc_selem)
 		return ERR_PTR(-ENOMEM);
 
-	raw_spin_lock_irqsave(&local_storage->lock, flags);
+	err = raw_res_spin_lock_irqsave(&local_storage->lock, flags);
+	if (err)
+		return ERR_PTR(err);
 
 	/* Recheck local_storage->list under local_storage->lock */
 	if (unlikely(hlist_empty(&local_storage->list))) {
@@ -684,9 +709,15 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
 	b = select_bucket(smap, selem);
 	old_b = old_sdata ? select_bucket(smap, SELEM(old_sdata)) : b;
 
-	raw_spin_lock_irqsave(&b->lock, b_flags);
-	if (b != old_b)
-		raw_spin_lock_irqsave(&old_b->lock, old_b_flags);
+	err = raw_res_spin_lock_irqsave(&b->lock, b_flags);
+	if (err)
+		goto unlock;
+
+	if (b != old_b) {
+		err = raw_res_spin_lock_irqsave(&old_b->lock, old_b_flags);
+		if (err)
+			goto unlock_bucket;
+	}
 
 	alloc_selem = NULL;
 	/* First, link the new selem to the map */
@@ -703,11 +734,12 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
 	}
 
 	if (b != old_b)
-		raw_spin_unlock_irqrestore(&old_b->lock, old_b_flags);
-	raw_spin_unlock_irqrestore(&b->lock, b_flags);
+		raw_res_spin_unlock_irqrestore(&old_b->lock, old_b_flags);
+unlock_bucket:
+	raw_res_spin_unlock_irqrestore(&b->lock, b_flags);
 
 unlock:
-	raw_spin_unlock_irqrestore(&local_storage->lock, flags);
+	raw_res_spin_unlock_irqrestore(&local_storage->lock, flags);
 	bpf_selem_free_list(&old_selem_free_list, false);
 	if (alloc_selem) {
 		mem_uncharge(smap, owner, smap->elem_size);
@@ -797,7 +829,7 @@ void bpf_local_storage_destroy(struct bpf_local_storage *local_storage)
 	 * when unlinking elem from the local_storage->list and
 	 * the map's bucket->list.
 	 */
-	raw_spin_lock_irqsave(&local_storage->lock, flags);
+	WARN_ON(raw_res_spin_lock_irqsave(&local_storage->lock, flags));
 	hlist_for_each_entry_safe(selem, n, &local_storage->list, snode) {
 		/* Always unlink from map before unlinking from
 		 * local_storage.
@@ -813,7 +845,7 @@ void bpf_local_storage_destroy(struct bpf_local_storage *local_storage)
 		free_storage = bpf_selem_unlink_storage_nolock(
 			local_storage, selem, true, &free_selem_list);
 	}
-	raw_spin_unlock_irqrestore(&local_storage->lock, flags);
+	raw_res_spin_unlock_irqrestore(&local_storage->lock, flags);
 
 	bpf_selem_free_list(&free_selem_list, true);
 
@@ -870,7 +902,7 @@ bpf_local_storage_map_alloc(union bpf_attr *attr,
 
 	for (i = 0; i < nbuckets; i++) {
 		INIT_HLIST_HEAD(&smap->buckets[i].list);
-		raw_spin_lock_init(&smap->buckets[i].lock);
+		raw_res_spin_lock_init(&smap->buckets[i].lock);
 	}
 
 	smap->elem_size = offsetof(struct bpf_local_storage_elem,
-- 
2.47.3


