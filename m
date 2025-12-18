Return-Path: <bpf+bounces-77019-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B63E0CCD118
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 19:00:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0F54430651A7
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 17:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C736430F94A;
	Thu, 18 Dec 2025 17:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L6sFiUPx"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D856530DD08
	for <bpf@vger.kernel.org>; Thu, 18 Dec 2025 17:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766080607; cv=none; b=TmtKHY0whJSqk3BB6dI1hpl/6WDyTU1P/kGQf4EacI7itvdeLOka2LNcunke/NYw3oeO5kweJw6BPcYof848eDs0H4WsGFBjgLZN9aFIWQF5EFQ2Jan3oWK+9g1XlnP8W/sAEEzjR34JjdrSnrIHTq3EMPg0yEHVkbWPNm6coGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766080607; c=relaxed/simple;
	bh=5KlqNarYuRmch5k1HEnbqXMyPgjb0oYBo92c3A72vwk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DigzJ2TyCZDr4ETH6oVusNihVAQELgRsB5U1QNd2OolY8y8m/t9/VlFVOsmFYF3cZEE8ThUzsXq/XxWk6+S0MpMdNhxadAfYwnbKXJKkpVBw/+WExWGpL4ZmHq3WfmWiABqWAWgsaO4vYh4uu2wSCIdALbBhXVpSS4dGNzAnFhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L6sFiUPx; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2a1388cdac3so8529995ad.0
        for <bpf@vger.kernel.org>; Thu, 18 Dec 2025 09:56:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766080604; x=1766685404; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+jawn7rNTdfkzzKanDBhAJJtdIrS1+FfjiSCDjfVhoI=;
        b=L6sFiUPxFJwtQvGZKd2wrslXtUxRIOyCQbL3i/BrzfivPZEv85JX0wyEx5F5ryr/TO
         oHqfaaLSaAkGtcwvSrhpse/bM4+fW4dntMHtbj7xSBgjdhl+0qEPcbBHqmJDbrpkKzDN
         DvUZ4Mw+2tB5eEuqG9fq8ILXpzRTfH2egSCO8XqFKkpusdiuU/AKH7ji9d80/OQLPjBX
         gWivRwZ8ewk5PdhpngjROFaxnnlKivI7MtNrAYZakYMP426TJNYxZU+GvN23QFhzMkKx
         VzBIkGqNf/MlYJxBbg5TKJwcbddsMVc4I18jAcoY/HhgEy5WfUOF2SFDklqmWNmmhHM0
         MkEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766080604; x=1766685404;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+jawn7rNTdfkzzKanDBhAJJtdIrS1+FfjiSCDjfVhoI=;
        b=fwOpvliaabdU4fv4JLb1kuoFSwrIv7/gDdESoTn1k/RpIdqO2tTLcwZWuUj/T3xSHu
         0SqfRCt6ImM7efJU/CkazcThoF1D1GfIqYJJAp+VdW9SEO9JxbvDJnU+hngh3AKRHDyw
         wliapifvepH90LwLfiLiQacKbU6gG5uyp/Tu3gDN/hl+93rUcO2K0g8Fok9ZHNmU8HWT
         H/jhnJ0tw4CVtTRL6+0WyVQZdMJ5FUF6WTa2WUTPBgxu5cEDq+c+RQnFuXD9QniSBv0t
         H+fC+DqmF62ywr9lhUCiG+z1BLZVbo7sE4uRoNE5wxe2f1JXcroEQQgeTG3GZULgdIkU
         BxVQ==
X-Gm-Message-State: AOJu0YxcWNJ36Ni+lO4EyNnvmnUYTEZ45u/T6qwKeiNiQHSpJo+JY2jO
	oSN4dbP4pQNLYqz8XXbNyFSYxb/7QxiZUBw9kEFdaY2Bk1VO6u+hNC41L0u40Q==
X-Gm-Gg: AY/fxX6uA0TIri/0iVFxaOxVvbWVUpjqmQrIuoeSVNyeUPFCpk3gZCPy4k0PDIKTmDi
	iOzygBlQtz+58SEqBnmGEUgNJ0VcwHJ4AYedzu5H5DMru/jMTW45jq/ezJHQfH97Q+oiOQHrC+o
	/aEeb7r5DCD9zoad4zKLYx9hSE7vFFDLjPJiuymgdZY9/8L3bQktt3pJ4+u0s7Jphwu8Az60Y4O
	uWJG18zLWorLBrZzfqRWZ1gz7anqvPIe/OYLIECweOLt+BIQCn7k2rfWWC34yPIkY/ZBXZxjcTq
	cJSkP3Js0BiOZG4HJeS6x+2WRwjSyThHVqB4gSazAH8UgyF2+dDL/snftf0xHQae5iuHikqWoKf
	awFBgUp0l74B/aLg99aseiudjaXH8HCRBnSRQLODgZrtsZC8yjRCmjmhXaAMe+Un/Uq0zf72O3t
	hbO1l6CmAav5Gf
X-Google-Smtp-Source: AGHT+IGZwavWrqkNbEfZ/scnfR08OW6i1wDpd1XPRIQqsDdTFD003nby9qLPDzqG6+7AuV4cdM1H3A==
X-Received: by 2002:a17:902:f607:b0:2a1:4c31:335 with SMTP id d9443c01a7336-2a2f2717b88mr1179665ad.26.1766080603635;
        Thu, 18 Dec 2025 09:56:43 -0800 (PST)
Received: from localhost ([2a03:2880:ff:4::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2d193cf13sm31835615ad.98.2025.12.18.09.56.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 09:56:42 -0800 (PST)
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
Subject: [PATCH bpf-next v3 11/16] bpf: Switch to bpf_selem_unlink_lockless in bpf_local_storage_{map_free, destroy}
Date: Thu, 18 Dec 2025 09:56:21 -0800
Message-ID: <20251218175628.1460321-12-ameryhung@gmail.com>
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

Take care of rqspinlock error in bpf_local_storage_{map_free, destroy}()
properly by switching to bpf_selem_unlink_lockless().

Pass reuse_now == false when calling bpf_selem_free_list() since both
callers iterate lists of selem without lock. An selem can only be freed
after an RCU grace period.

Similarly, SDATA(selem)->smap and selem->local_storage need to be
protected by RCU as well since a caller can update these fields
which may also be seen by the other at the same time. Pass reuse_now
== false when calling bpf_local_storage_free(). The local storage map is
already protected as bpf_local_storage_map_free() waits for an RCU grace
period after iterating b->list and before freeing itself.

Co-developed-by: Martin KaFai Lau <martin.lau@kernel.org>
Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 include/linux/bpf_local_storage.h |  2 +-
 kernel/bpf/bpf_cgrp_storage.c     |  1 +
 kernel/bpf/bpf_inode_storage.c    |  1 +
 kernel/bpf/bpf_local_storage.c    | 52 ++++++++++++++++++-------------
 kernel/bpf/bpf_task_storage.c     |  1 +
 net/core/bpf_sk_storage.c         |  7 ++++-
 6 files changed, 41 insertions(+), 23 deletions(-)

diff --git a/include/linux/bpf_local_storage.h b/include/linux/bpf_local_storage.h
index 1fd908c44fb6..14f8e5edf0a2 100644
--- a/include/linux/bpf_local_storage.h
+++ b/include/linux/bpf_local_storage.h
@@ -165,7 +165,7 @@ bpf_local_storage_lookup(struct bpf_local_storage *local_storage,
 	return SDATA(selem);
 }
 
-void bpf_local_storage_destroy(struct bpf_local_storage *local_storage);
+u32 bpf_local_storage_destroy(struct bpf_local_storage *local_storage);
 
 void bpf_local_storage_map_free(struct bpf_map *map,
 				struct bpf_local_storage_cache *cache);
diff --git a/kernel/bpf/bpf_cgrp_storage.c b/kernel/bpf/bpf_cgrp_storage.c
index 853183eead2c..9289b0c3fae9 100644
--- a/kernel/bpf/bpf_cgrp_storage.c
+++ b/kernel/bpf/bpf_cgrp_storage.c
@@ -28,6 +28,7 @@ void bpf_cgrp_storage_free(struct cgroup *cgroup)
 		goto out;
 
 	bpf_local_storage_destroy(local_storage);
+	RCU_INIT_POINTER(cgroup->bpf_cgrp_storage, NULL);
 out:
 	rcu_read_unlock();
 }
diff --git a/kernel/bpf/bpf_inode_storage.c b/kernel/bpf/bpf_inode_storage.c
index 470f4b02c79e..120354ef0bf8 100644
--- a/kernel/bpf/bpf_inode_storage.c
+++ b/kernel/bpf/bpf_inode_storage.c
@@ -69,6 +69,7 @@ void bpf_inode_storage_free(struct inode *inode)
 		goto out;
 
 	bpf_local_storage_destroy(local_storage);
+	RCU_INIT_POINTER(bsb->storage, NULL);
 out:
 	rcu_read_unlock_migrate();
 }
diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
index 4c682d5aef7f..f63b3c2241f0 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -797,13 +797,22 @@ int bpf_local_storage_map_check_btf(const struct bpf_map *map,
 	return 0;
 }
 
-void bpf_local_storage_destroy(struct bpf_local_storage *local_storage)
+/*
+ * Destroy local storage when the owner is going away. Caller must clear owner->storage
+ * and uncharge memory if memory charging is used.
+ *
+ * Since smaps associated with selems may already be gone, mem_uncharge() or
+ * owner_storage() cannot be called in this function. Let the owner (i.e., the caller)
+ * do it instead. It is safe for the caller to clear owner_storage without taking
+ * local_storage->lock as bpf_local_storage_map_free() does not free local_storage and
+ * no BPF program should be running and freeing the local storage.
+ */
+u32 bpf_local_storage_destroy(struct bpf_local_storage *local_storage)
 {
 	struct bpf_local_storage_elem *selem;
-	bool free_storage = false;
 	HLIST_HEAD(free_selem_list);
 	struct hlist_node *n;
-	unsigned long flags;
+	u32 uncharge = 0;
 
 	/* Neither the bpf_prog nor the bpf_map's syscall
 	 * could be modifying the local_storage->list now.
@@ -814,27 +823,22 @@ void bpf_local_storage_destroy(struct bpf_local_storage *local_storage)
 	 * when unlinking elem from the local_storage->list and
 	 * the map's bucket->list.
 	 */
-	WARN_ON(raw_res_spin_lock_irqsave(&local_storage->lock, flags));
 	hlist_for_each_entry_safe(selem, n, &local_storage->list, snode) {
-		/* Always unlink from map before unlinking from
-		 * local_storage.
-		 */
-		WARN_ON(bpf_selem_unlink_map(selem));
-		/* If local_storage list has only one element, the
-		 * bpf_selem_unlink_storage_nolock() will return true.
-		 * Otherwise, it will return false. The current loop iteration
-		 * intends to remove all local storage. So the last iteration
-		 * of the loop will set the free_cgroup_storage to true.
-		 */
-		free_storage = bpf_selem_unlink_storage_nolock(
-			local_storage, selem, &free_selem_list);
+		uncharge += selem->size;
+		bpf_selem_unlink_lockless(selem, &free_selem_list, BPF_LOCAL_STORAGE_DESTROY);
 	}
-	raw_res_spin_unlock_irqrestore(&local_storage->lock, flags);
+	uncharge += sizeof(*local_storage);
+	local_storage->owner = NULL;
 
-	bpf_selem_free_list(&free_selem_list, true);
+	/*
+	 * Need to wait an RCU gp before freeing selem and local_storage
+	 * since bpf_local_storage_map_free() may still be referencing them.
+	 */
+	bpf_selem_free_list(&free_selem_list, false);
+
+	bpf_local_storage_free(local_storage, false);
 
-	if (free_storage)
-		bpf_local_storage_free(local_storage, true);
+	return uncharge;
 }
 
 u64 bpf_local_storage_map_mem_usage(const struct bpf_map *map)
@@ -903,6 +907,7 @@ void bpf_local_storage_map_free(struct bpf_map *map,
 	struct bpf_local_storage_map_bucket *b;
 	struct bpf_local_storage_elem *selem;
 	struct bpf_local_storage_map *smap;
+	HLIST_HEAD(free_selem_list);
 	unsigned int i;
 
 	smap = (struct bpf_local_storage_map *)map;
@@ -931,7 +936,12 @@ void bpf_local_storage_map_free(struct bpf_map *map,
 		while ((selem = hlist_entry_safe(
 				rcu_dereference_raw(hlist_first_rcu(&b->list)),
 				struct bpf_local_storage_elem, map_node))) {
-			WARN_ON(bpf_selem_unlink(selem, true));
+
+			bpf_selem_unlink_lockless(selem, &free_selem_list,
+						  BPF_LOCAL_STORAGE_MAP_FREE);
+
+			bpf_selem_free_list(&free_selem_list, false);
+
 			cond_resched_rcu();
 		}
 		rcu_read_unlock();
diff --git a/kernel/bpf/bpf_task_storage.c b/kernel/bpf/bpf_task_storage.c
index 4d53aebe6784..7b2c8d428caa 100644
--- a/kernel/bpf/bpf_task_storage.c
+++ b/kernel/bpf/bpf_task_storage.c
@@ -54,6 +54,7 @@ void bpf_task_storage_free(struct task_struct *task)
 		goto out;
 
 	bpf_local_storage_destroy(local_storage);
+	RCU_INIT_POINTER(task->bpf_storage, NULL);
 out:
 	rcu_read_unlock();
 }
diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
index 38acbecb8ef7..64a52e57953c 100644
--- a/net/core/bpf_sk_storage.c
+++ b/net/core/bpf_sk_storage.c
@@ -47,13 +47,18 @@ static int bpf_sk_storage_del(struct sock *sk, struct bpf_map *map)
 void bpf_sk_storage_free(struct sock *sk)
 {
 	struct bpf_local_storage *sk_storage;
+	u32 uncharge;
 
 	rcu_read_lock_dont_migrate();
 	sk_storage = rcu_dereference(sk->sk_bpf_storage);
 	if (!sk_storage)
 		goto out;
 
-	bpf_local_storage_destroy(sk_storage);
+	uncharge = bpf_local_storage_destroy(sk_storage);
+	if (uncharge)
+		atomic_sub(uncharge, &sk->sk_omem_alloc);
+
+	RCU_INIT_POINTER(sk->sk_bpf_storage, NULL);
 out:
 	rcu_read_unlock_migrate();
 }
-- 
2.47.3


