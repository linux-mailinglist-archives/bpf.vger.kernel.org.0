Return-Path: <bpf+bounces-70252-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B913BB591A
	for <lists+bpf@lfdr.de>; Fri, 03 Oct 2025 00:55:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 559BF19C7797
	for <lists+bpf@lfdr.de>; Thu,  2 Oct 2025 22:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDDA32C0264;
	Thu,  2 Oct 2025 22:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="icHPjTla"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA1D2BDC0C
	for <bpf@vger.kernel.org>; Thu,  2 Oct 2025 22:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759445645; cv=none; b=KNiluzl2ILGGM44JurqBjqSyTGxlcCTsn4/8NEQ6IdatbJ9VfUbWfcinyG5Jt2wYnFw0vUNQFCZbA1lEW9+trV6mwZdEX39u68eyc0Fr1e/ms1RaTNuppd6aQHPH3WWjFNRzqqDOJN3fz0IinpPPi1kAzaZznKA1PR57yfY5/94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759445645; c=relaxed/simple;
	bh=8LKbJ1gEQQ8PzCGApMOy815Kz7Th11Ybpw4AEb04GKQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H7j4EL9W6jbYtyugPPj8X0aACEgPsD6Fmvpa7wSIX2sW1mmwSfiWTQ8GyYBpSfJyF2FbgHsGh6FKrCoNxLcRP0EGNaYnZ735PM4VCHx9jn3U07oriyYs+fLNArw1cI8slNoHXZy7zXLxWV4sJQZQhbFieJppLhsWs1lA3dK7UoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=icHPjTla; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-789fb76b466so1587153b3a.0
        for <bpf@vger.kernel.org>; Thu, 02 Oct 2025 15:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759445643; x=1760050443; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vijZeMraZQ9KlMKPQKvBr1kVqarSpSLBIE3FYS5jvs4=;
        b=icHPjTlaoyQ7tuFJl/PTWDlxH2gbq/c128oPqaaJX//ANi7rburZ0jkBWzBkPdrqCt
         A08CfJDYNCQ+AxqEAfc2AtS4fEAJuOGHTAZu4+u8mZ+LZd0C46GOF5YOhyOu5Eg4vsFi
         BLZ2v+fAGHnOQN83w9GgWbX4qY7/CfE1iCjzNsnm+1LOZRZq/EbKC0O8J33uZYE4xzHr
         iZr95ezcCEeTXEJLj65IJOfTg2T4Uy8k5MbzyaZ8FAMBsZbaHTVV16SOi9ZK4C6Pd8LN
         7xTSE273P1D8t2oNXOPDw/0AKn9nwO/EqRpOvYmrq06T4sXosD8X6eDVuuENeWBaMEd6
         HRMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759445643; x=1760050443;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vijZeMraZQ9KlMKPQKvBr1kVqarSpSLBIE3FYS5jvs4=;
        b=P9gASzbMbd7nO++zlPqHIaOnvrDTNN0t/6yKKB1f8AVSVkfVlb/91qk9WbAIqujMeA
         9XZLXMmIsmVQptitBXjRyv0MvcrTcpHokYbz8VtYaY31hRfBaCRAwMj9XN5FUePHtWZG
         BZoH8Ma7xNz9dVR/TwRpnIeUlj3KFCqQWCxDCLIeY4RMGQOS8URShLBELfY0MTslv4ey
         TXBiC4P6XPimFN5nVtitGI4cV70jHacrDDrup0xEHk9RtN9xTVEFL5BqdBCYNk8YVRkl
         vQCjPTQ8rO3zpV8uS4VhU7270rneUQ56L6e6b+E4iYls1ltsMBSsKWGNlvXkjpBC9yBT
         I/mQ==
X-Gm-Message-State: AOJu0YxACvpKPoHUvxrQt0Sk2km/dBKZo/3bxjFcG6HDwHVPUq9ffHsq
	WCg477m87sKXAu7MjaMgeXs4+z03LpFf281OzJHx9/TftepzBKlGsZspKEB1qw==
X-Gm-Gg: ASbGncvGZ4zIzcq3X2pVFiFJ282iiJoqktmRqe8PA4rK1pvurYUKhCo+sC/Pvl7TWV5
	UZ4qHG6G8TsWI3L4MeXIIx/VWR9c4BjNLzuaPJwmLDhVFhLlNKsVXyob8fFCu7Z3lYaTGzLg/dJ
	OqlDJUpecz2D1LRI0nO4LOdVGwGg2eoinIk2cNSVl93Vl1QS6u5PtnLtBlTIFEaTHCCu00YXkix
	MdXmg9QTXaSzJdLmeNBN6Y88c7zAJfFwx/SMTnm50jFQmThrcbnq5cLiNDpl62zZW8fw0b7AU9X
	0qal81mI8fYuECB3KTN+VxNknur+llL6hfkhj4mlyVGicdI/wKCzCZSqsoMko38srQa0oeJdM6t
	JM6R3Bmfw5wMO/MqA3uXoUpwQ+nCDh7Qkk1aL5K2CfWWBmxm7
X-Google-Smtp-Source: AGHT+IH6JT4PbaltgfVKZlbRE7+GNud0yN+acLASVaDVdxRsBg6NTXXi9dd9Dua+u/gPbAL/kj6aKg==
X-Received: by 2002:a05:6a00:2295:b0:781:17ba:ad76 with SMTP id d2e1a72fcca58-78c98de3e72mr1459837b3a.24.1759445642845;
        Thu, 02 Oct 2025 15:54:02 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:4e::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78b020938b1sm3053224b3a.83.2025.10.02.15.54.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 15:54:02 -0700 (PDT)
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
Subject: [RFC PATCH bpf-next v2 06/12] bpf: Change local_storage->lock and b->lock to rqspinlock
Date: Thu,  2 Oct 2025 15:53:45 -0700
Message-ID: <20251002225356.1505480-7-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251002225356.1505480-1-ameryhung@gmail.com>
References: <20251002225356.1505480-1-ameryhung@gmail.com>
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

In bpf_local_storage_destroy(), since it cannot deadlock with itself or
bpf_local_storage_map_free() who the function might be racing with,
retry if bpf_selem_unlink_map() fails due to rqspinlock returning
errors

For, __bpf_local_storage_map_cache(), instead of handling the error, skip
updating the cache.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 include/linux/bpf_local_storage.h |  5 ++-
 kernel/bpf/bpf_local_storage.c    | 65 ++++++++++++++++++++-----------
 2 files changed, 46 insertions(+), 24 deletions(-)

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
index e0e405060e3c..572956e2a72d 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -384,6 +384,7 @@ static int bpf_selem_unlink_map(struct bpf_local_storage_elem *selem)
 	struct bpf_local_storage_map *smap;
 	struct bpf_local_storage_map_bucket *b;
 	unsigned long flags;
+	int err;
 
 	if (unlikely(!selem_linked_to_map_lockless(selem)))
 		/* selem has already be unlinked from smap */
@@ -393,10 +394,13 @@ static int bpf_selem_unlink_map(struct bpf_local_storage_elem *selem)
 					      bpf_rcu_lock_held());
 	smap = rcu_dereference_check(SDATA(selem)->smap, bpf_rcu_lock_held());
 	b = select_bucket(smap, local_storage);
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
@@ -413,14 +417,18 @@ int bpf_selem_link_map(struct bpf_local_storage_map *smap,
 	struct bpf_local_storage *local_storage;
 	struct bpf_local_storage_map_bucket *b;
 	unsigned long flags;
+	int err;
 
 	local_storage = rcu_dereference_check(selem->local_storage,
 					      bpf_rcu_lock_held());
 	b = select_bucket(smap, local_storage);
-	raw_spin_lock_irqsave(&b->lock, flags);
+	err = raw_res_spin_lock_irqsave(&b->lock, flags);
+	if (err)
+		return err;
+
 	RCU_INIT_POINTER(SDATA(selem)->smap, smap);
 	hlist_add_head_rcu(&selem->map_node, &b->list);
-	raw_spin_unlock_irqrestore(&b->lock, flags);
+	raw_res_spin_unlock_irqrestore(&b->lock, flags);
 
 	return 0;
 }
@@ -444,7 +452,7 @@ int bpf_selem_unlink(struct bpf_local_storage_elem *selem, bool reuse_now)
 
 	if (unlikely(!selem_linked_to_storage_lockless(selem)))
 		/* selem has already been unlinked from sk */
-		return;
+		return 0;
 
 	local_storage = rcu_dereference_check(selem->local_storage,
 					      bpf_rcu_lock_held());
@@ -452,7 +460,10 @@ int bpf_selem_unlink(struct bpf_local_storage_elem *selem, bool reuse_now)
 					     bpf_rcu_lock_held());
 	bpf_ma = check_storage_bpf_ma(local_storage, storage_smap, selem);
 
-	raw_spin_lock_irqsave(&local_storage->lock, flags);
+	err = raw_res_spin_lock_irqsave(&local_storage->lock, flags);
+	if (err)
+		return err;
+
 	if (likely(selem_linked_to_storage(selem))) {
 		/* Always unlink from map before unlinking from local_storage
 		 * because selem will be freed after successfully unlinked from
@@ -466,14 +477,14 @@ int bpf_selem_unlink(struct bpf_local_storage_elem *selem, bool reuse_now)
 			local_storage, selem, true, &selem_free_list);
 	}
 out:
-	raw_spin_unlock_irqrestore(&local_storage->lock, flags);
+	raw_res_spin_unlock_irqrestore(&local_storage->lock, flags);
 
 	bpf_selem_free_list(&selem_free_list, reuse_now);
 
 	if (free_local_storage)
 		bpf_local_storage_free(local_storage, storage_smap, bpf_ma, reuse_now);
 
-	return 0;
+	return err;
 }
 
 void __bpf_local_storage_insert_cache(struct bpf_local_storage *local_storage,
@@ -481,16 +492,20 @@ void __bpf_local_storage_insert_cache(struct bpf_local_storage *local_storage,
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
@@ -534,13 +549,16 @@ int bpf_local_storage_alloc(void *owner,
 
 	RCU_INIT_POINTER(storage->smap, smap);
 	INIT_HLIST_HEAD(&storage->list);
-	raw_spin_lock_init(&storage->lock);
+	raw_res_spin_lock_init(&storage->lock);
 	storage->owner = owner;
 
 	bpf_selem_link_storage_nolock(storage, first_selem);
 
 	b = select_bucket(smap, storage);
-	raw_spin_lock_irqsave(&b->lock, flags);
+	err = raw_res_spin_lock_irqsave(&b->lock, flags);
+	if (err)
+		goto uncharge;
+
 	bpf_selem_link_map_nolock(smap, first_selem, b);
 
 	owner_storage_ptr =
@@ -558,7 +576,7 @@ int bpf_local_storage_alloc(void *owner,
 	prev_storage = cmpxchg(owner_storage_ptr, NULL, storage);
 	if (unlikely(prev_storage)) {
 		bpf_selem_unlink_map_nolock(first_selem);
-		raw_spin_unlock_irqrestore(&b->lock, flags);
+		raw_res_spin_unlock_irqrestore(&b->lock, flags);
 		err = -EAGAIN;
 		goto uncharge;
 
@@ -572,7 +590,7 @@ int bpf_local_storage_alloc(void *owner,
 		 * bucket->list under rcu_read_lock().
 		 */
 	}
-	raw_spin_unlock_irqrestore(&b->lock, flags);
+	raw_res_spin_unlock_irqrestore(&b->lock, flags);
 
 	return 0;
 
@@ -655,7 +673,9 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
 	if (!alloc_selem)
 		return ERR_PTR(-ENOMEM);
 
-	raw_spin_lock_irqsave(&local_storage->lock, flags);
+	err = raw_res_spin_lock_irqsave(&local_storage->lock, flags);
+	if (err)
+		return ERR_PTR(err);
 
 	/* Recheck local_storage->list under local_storage->lock */
 	if (unlikely(hlist_empty(&local_storage->list))) {
@@ -682,7 +702,9 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
 
 	b = select_bucket(smap, local_storage);
 
-	raw_spin_lock_irqsave(&b->lock, b_flags);
+	err = raw_res_spin_lock_irqsave(&b->lock, b_flags);
+	if (err)
+		goto unlock;
 
 	alloc_selem = NULL;
 	/* First, link the new selem to the map */
@@ -698,10 +720,9 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
 						true, &old_selem_free_list);
 	}
 
-	raw_spin_unlock_irqrestore(&b->lock, b_flags);
-
+	raw_res_spin_unlock_irqrestore(&b->lock, b_flags);
 unlock:
-	raw_spin_unlock_irqrestore(&local_storage->lock, flags);
+	raw_res_spin_unlock_irqrestore(&local_storage->lock, flags);
 	bpf_selem_free_list(&old_selem_free_list, false);
 	if (alloc_selem) {
 		mem_uncharge(smap, owner, smap->elem_size);
@@ -791,7 +812,7 @@ void bpf_local_storage_destroy(struct bpf_local_storage *local_storage)
 	 * when unlinking elem from the local_storage->list and
 	 * the map's bucket->list.
 	 */
-	raw_spin_lock_irqsave(&local_storage->lock, flags);
+	while (raw_res_spin_lock_irqsave(&local_storage->lock, flags));
 	hlist_for_each_entry_safe(selem, n, &local_storage->list, snode) {
 		/* Always unlink from map before unlinking from
 		 * local_storage.
@@ -806,7 +827,7 @@ void bpf_local_storage_destroy(struct bpf_local_storage *local_storage)
 		free_storage = bpf_selem_unlink_storage_nolock(
 			local_storage, selem, true, &free_selem_list);
 	}
-	raw_spin_unlock_irqrestore(&local_storage->lock, flags);
+	raw_res_spin_unlock_irqrestore(&local_storage->lock, flags);
 
 	bpf_selem_free_list(&free_selem_list, true);
 
@@ -863,7 +884,7 @@ bpf_local_storage_map_alloc(union bpf_attr *attr,
 
 	for (i = 0; i < nbuckets; i++) {
 		INIT_HLIST_HEAD(&smap->buckets[i].list);
-		raw_spin_lock_init(&smap->buckets[i].lock);
+		raw_res_spin_lock_init(&smap->buckets[i].lock);
 	}
 
 	smap->elem_size = offsetof(struct bpf_local_storage_elem,
-- 
2.47.3


