Return-Path: <bpf+bounces-74317-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 675DCC53DA8
	for <lists+bpf@lfdr.de>; Wed, 12 Nov 2025 19:07:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5956E4F6E69
	for <lists+bpf@lfdr.de>; Wed, 12 Nov 2025 18:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F04934AAFB;
	Wed, 12 Nov 2025 17:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q1B1zsBv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DADB0348862
	for <bpf@vger.kernel.org>; Wed, 12 Nov 2025 17:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762970386; cv=none; b=ARNaUYpGtI6mjc14W0zC43BAoj92Pf/Jcx5hpleCoFuc7X3iRGfTJo9nVfbtCiSf7O0CJmNbHS2nqa/Z6f296V7Y+hJOEGQMGyMXvj5mp1DIKM8iQRabmGDyLtKXQM7+7BUAiGNlrOEvFhRq2ZX986RvTWfK50tmmz5KZ2dzaBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762970386; c=relaxed/simple;
	bh=vWtoONmZ0VwNnaTswqjwnWUh3qFcpVePNilMMxFd7K4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rj3S/0fswCjptkQpU1deKgue6OZRGJfcVDslckRs0yGhn7u41SHA1yGr1z8hzPUEagboJtR7ndJK19dpgoLO28r5tanKlquyp2HrntdyQQsBWeDGfyEpRU26SB4sWkb2x0IKxtlHLjcNfFethz+lzzpaE5BLKwelSghTKV5rN7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q1B1zsBv; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b6ceb3b68eeso726734a12.2
        for <bpf@vger.kernel.org>; Wed, 12 Nov 2025 09:59:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762970383; x=1763575183; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p2KNkDUYof//Po5k7JK7xfFxYMV/PYhc2dbTDebqhi4=;
        b=Q1B1zsBvlUjxZk/yG3RAaftmkQh89VT2/tt42MLX51AV5wwe6uiJrA547hcJG5Ic1s
         YHqVOjj4jSDzjoGypnMBfPYJlMDnItI4pAewe9kmWnlCOUvusidBUesglOHAA7P1SIvn
         GG8kRNKltaRskdg259aF+emTNtmgI3HAjyBvGBTXEEibEXsqaOez6Ww7zUj7barO50Qh
         iIJ/ZBkv+JaYiiq6+Y9xgtRqRsNW5PkM3/biupSVYX8gPrvyDHQDbI0NNvR/XLpeVwUT
         u6uDd/0DAG8ICwyiA16WL0En4u+/RbKzhv+IsKkrv8SxcekUS708QkpEYFcfqnSsyFtZ
         9KCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762970383; x=1763575183;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=p2KNkDUYof//Po5k7JK7xfFxYMV/PYhc2dbTDebqhi4=;
        b=PWymDZc27pX5t3lqnXosDQPGpON5J83ODtYP+/ErK5Y2P+x1FdwboCEvZ3IwYxTD5/
         uxvi3wgrtOSFi5rM1qaFs99cPbdPHEcVb9Td9Pt02i1zZaT1o/MbV0hVMlvmxILCfeBe
         qFSSI4jarmC1AhxXACf5ACafSNxFcA7ORAqZ0SfzLMKwt//PLXmuXzssw33Dl/4fvJQm
         gXDFxDReuyFJlwip6xi+y7Xro3WegyriewPv04BuJ8n0Tp3K+0c57s/Qy3CeB7AP+bMe
         vUtpVcVAsFTpMnnDOfL27r6uNzKdKRaIwsKHBMmegbLM6MPn01pg172kK251MoXoPodx
         4KIg==
X-Gm-Message-State: AOJu0YxuIPtJzeHG2oKjjsdK8voKRWZhmIKiSRHailYIefVqc5XH1RdV
	Hid4Djag6Nshg0mGA6jV4/7hjtohsZP9mDI+/mm5EMt+70Fybm33/4GyDn3c3Q==
X-Gm-Gg: ASbGncv1iVj8zvMFLFXUvhDZgxf5rmLsr8StTKv0QSaWWLMd1vh1CLceiMpXeF1msaC
	BvywksawVpOwA7CxH3ddeTMWMcz5jEjR1Wh7xIPFBFnRUFy+WfQthR3UQKr3IlzOD7Jin0nb5+Z
	yXxtG+8q+nyL2h7nkH3fH5SYK4ubm9fb4OLG0rEN1s6DSxAajIuhCwIAtee4HJiPPXppySdK+f0
	nNJogTXP7U9YQbm/IVcH9h7O3DRZ9lAzlfeGIHhYEbjK08Tf0YXeNnWIUjyaj8WEUtyHk0cDAYG
	++5c/LwyAe+t8a8Hag4uwfipYfpROZd9ZUSqlmHQoyPkSuNv4FBbqxaYyvW2bX3mTbaufdbEVkV
	ZT0vcymU3G1DYsD+N3OcJk/vPep63opYVxb+aUn1N2v9yATSVW68YkozHCYuYOu7eeX0=
X-Google-Smtp-Source: AGHT+IE56+DFtiFyrHKDmwXqenetsq3RDmK09qx+VvFi/9C2zX2mxZequod8bOHOZpD2uxCWjFb0fg==
X-Received: by 2002:a17:902:ce04:b0:297:f09a:51cd with SMTP id d9443c01a7336-2984ed3e87dmr46142885ad.14.1762970382879;
        Wed, 12 Nov 2025 09:59:42 -0800 (PST)
Received: from localhost ([2a03:2880:ff:41::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bbf165f99e6sm3477147a12.19.2025.11.12.09.59.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 09:59:42 -0800 (PST)
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
Subject: [PATCH RFC bpf-next 2/2] bpf: Use kmalloc_nolock() in local storage unconditionally
Date: Wed, 12 Nov 2025 09:59:36 -0800
Message-ID: <20251112175939.2365295-3-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251112175939.2365295-1-ameryhung@gmail.com>
References: <20251112175939.2365295-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Simplify local storage and selem memory alloc/free paths by switching to
kmalloc_nolock unconditionally.

While it is okay to call bpf_obj_free_fields() immediately in
bpf_selem_free() when reuse_now == true, it is kept only in
bpf_selem_free_rcu() to simplify the code. This requires rcu_barrier()
to be called unconditionally in bpf_local_storage_map_free() since
bpf_obj_free_fields() may also be called from rcu callbacks.

In addition, remove the argument, smap, from bpf_selem_free() and rely
on SDATA(selem)->smap for bpf_obj_free_fields(). This requires
initializing SDATA(selem)->smap earlier during bpf_selem_alloc() as
bpf_local_storage_update() can allocate an selem and free it without
ever linking it to a map.

Finally, clean up and update comments. Note that, we already free selem
after an RCU grace period in bpf_local_storage_update() when
bpf_local_storage_alloc() failed the cmpxchg since commit c0d63f309186
("bpf: Add bpf_selem_free()").

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 include/linux/bpf_local_storage.h |  10 +-
 kernel/bpf/bpf_cgrp_storage.c     |   2 +-
 kernel/bpf/bpf_inode_storage.c    |   2 +-
 kernel/bpf/bpf_local_storage.c    | 261 ++++--------------------------
 kernel/bpf/bpf_task_storage.c     |   2 +-
 net/core/bpf_sk_storage.c         |   4 +-
 6 files changed, 41 insertions(+), 240 deletions(-)

diff --git a/include/linux/bpf_local_storage.h b/include/linux/bpf_local_storage.h
index 3663eabcc3ff..3c35f0b9b86c 100644
--- a/include/linux/bpf_local_storage.h
+++ b/include/linux/bpf_local_storage.h
@@ -53,9 +53,6 @@ struct bpf_local_storage_map {
 	u32 bucket_log;
 	u16 elem_size;
 	u16 cache_idx;
-	struct bpf_mem_alloc selem_ma;
-	struct bpf_mem_alloc storage_ma;
-	bool bpf_ma;
 };
 
 struct bpf_local_storage_data {
@@ -129,8 +126,7 @@ int bpf_local_storage_map_alloc_check(union bpf_attr *attr);
 
 struct bpf_map *
 bpf_local_storage_map_alloc(union bpf_attr *attr,
-			    struct bpf_local_storage_cache *cache,
-			    bool bpf_ma);
+			    struct bpf_local_storage_cache *cache);
 
 void __bpf_local_storage_insert_cache(struct bpf_local_storage *local_storage,
 				      struct bpf_local_storage_map *smap,
@@ -186,9 +182,7 @@ struct bpf_local_storage_elem *
 bpf_selem_alloc(struct bpf_local_storage_map *smap, void *owner, void *value,
 		bool swap_uptrs, gfp_t gfp_flags);
 
-void bpf_selem_free(struct bpf_local_storage_elem *selem,
-		    struct bpf_local_storage_map *smap,
-		    bool reuse_now);
+void bpf_selem_free(struct bpf_local_storage_elem *selem, bool reuse_now);
 
 int
 bpf_local_storage_alloc(void *owner,
diff --git a/kernel/bpf/bpf_cgrp_storage.c b/kernel/bpf/bpf_cgrp_storage.c
index 0687a760974a..87d50b6b3673 100644
--- a/kernel/bpf/bpf_cgrp_storage.c
+++ b/kernel/bpf/bpf_cgrp_storage.c
@@ -146,7 +146,7 @@ static int notsupp_get_next_key(struct bpf_map *map, void *key, void *next_key)
 
 static struct bpf_map *cgroup_storage_map_alloc(union bpf_attr *attr)
 {
-	return bpf_local_storage_map_alloc(attr, &cgroup_cache, true);
+	return bpf_local_storage_map_alloc(attr, &cgroup_cache);
 }
 
 static void cgroup_storage_map_free(struct bpf_map *map)
diff --git a/kernel/bpf/bpf_inode_storage.c b/kernel/bpf/bpf_inode_storage.c
index e54cce2b9175..30934f6a66a4 100644
--- a/kernel/bpf/bpf_inode_storage.c
+++ b/kernel/bpf/bpf_inode_storage.c
@@ -181,7 +181,7 @@ static int notsupp_get_next_key(struct bpf_map *map, void *key,
 
 static struct bpf_map *inode_storage_map_alloc(union bpf_attr *attr)
 {
-	return bpf_local_storage_map_alloc(attr, &inode_cache, false);
+	return bpf_local_storage_map_alloc(attr, &inode_cache);
 }
 
 static void inode_storage_map_free(struct bpf_map *map)
diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
index 400bdf8a3eb2..678bbf45eb57 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -80,23 +80,12 @@ bpf_selem_alloc(struct bpf_local_storage_map *smap, void *owner,
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
-	} else {
-		selem = bpf_map_kzalloc(&smap->map, smap->elem_size,
-					gfp_flags | __GFP_NOWARN);
-	}
+	selem = bpf_map_kmalloc_nolock(&smap->map, smap->elem_size, gfp_flags, NUMA_NO_NODE);
 
 	if (selem) {
+		memset(selem, 0, smap->elem_size);
+		RCU_INIT_POINTER(SDATA(selem)->smap, smap);
+
 		if (value) {
 			/* No need to call check_and_init_map_value as memory is zero init */
 			copy_map_value(&smap->map, SDATA(selem)->data, value);
@@ -111,96 +100,35 @@ bpf_selem_alloc(struct bpf_local_storage_map *smap, void *owner,
 	return NULL;
 }
 
-/* rcu tasks trace callback for bpf_ma == false */
-static void __bpf_local_storage_free_trace_rcu(struct rcu_head *rcu)
+static void bpf_local_storage_free_rcu(struct rcu_head *rcu)
 {
 	struct bpf_local_storage *local_storage;
 
-	/* If RCU Tasks Trace grace period implies RCU grace period, do
-	 * kfree(), else do kfree_rcu().
-	 */
 	local_storage = container_of(rcu, struct bpf_local_storage, rcu);
-	if (rcu_trace_implies_rcu_gp())
-		kfree(local_storage);
-	else
-		kfree_rcu(local_storage, rcu);
+	kfree_nolock(local_storage);
 }
 
-static void bpf_local_storage_free_rcu(struct rcu_head *rcu)
+static void bpf_local_storage_free_trace_rcu(struct rcu_head *rcu)
 {
 	struct bpf_local_storage *local_storage;
 
 	local_storage = container_of(rcu, struct bpf_local_storage, rcu);
-	bpf_mem_cache_raw_free(local_storage);
-}
-
-static void bpf_local_storage_free_trace_rcu(struct rcu_head *rcu)
-{
 	if (rcu_trace_implies_rcu_gp())
 		bpf_local_storage_free_rcu(rcu);
 	else
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
-				   bool bpf_ma, bool reuse_now)
+				   bool reuse_now)
 {
 	if (!local_storage)
 		return;
 
-	if (!bpf_ma) {
-		__bpf_local_storage_free(local_storage, reuse_now);
-		return;
-	}
-
-	if (!reuse_now) {
-		call_rcu_tasks_trace(&local_storage->rcu,
-				     bpf_local_storage_free_trace_rcu);
-		return;
-	}
-
-	if (smap)
-		bpf_mem_cache_free(&smap->storage_ma, local_storage);
-	else
-		/* smap could be NULL if the selem that triggered
-		 * this 'local_storage' creation had been long gone.
-		 * In this case, directly do call_rcu().
-		 */
+	if (reuse_now)
 		call_rcu(&local_storage->rcu, bpf_local_storage_free_rcu);
-}
-
-/* rcu tasks trace callback for bpf_ma == false */
-static void __bpf_selem_free_trace_rcu(struct rcu_head *rcu)
-{
-	struct bpf_local_storage_elem *selem;
-
-	selem = container_of(rcu, struct bpf_local_storage_elem, rcu);
-	if (rcu_trace_implies_rcu_gp())
-		kfree(selem);
-	else
-		kfree_rcu(selem, rcu);
-}
-
-/* Handle bpf_ma == false */
-static void __bpf_selem_free(struct bpf_local_storage_elem *selem,
-			     bool vanilla_rcu)
-{
-	if (vanilla_rcu)
-		kfree_rcu(selem, rcu);
 	else
-		call_rcu_tasks_trace(&selem->rcu, __bpf_selem_free_trace_rcu);
+		call_rcu_tasks_trace(&local_storage->rcu, bpf_local_storage_free_trace_rcu);
 }
 
 static void bpf_selem_free_rcu(struct rcu_head *rcu)
@@ -215,7 +143,7 @@ static void bpf_selem_free_rcu(struct rcu_head *rcu)
 	migrate_disable();
 	bpf_obj_free_fields(smap->map.record, SDATA(selem)->data);
 	migrate_enable();
-	bpf_mem_cache_raw_free(selem);
+	kfree_nolock(selem);
 }
 
 static void bpf_selem_free_trace_rcu(struct rcu_head *rcu)
@@ -227,43 +155,17 @@ static void bpf_selem_free_trace_rcu(struct rcu_head *rcu)
 }
 
 void bpf_selem_free(struct bpf_local_storage_elem *selem,
-		    struct bpf_local_storage_map *smap,
 		    bool reuse_now)
 {
-	if (!smap->bpf_ma) {
-		/* Only task storage has uptrs and task storage
-		 * has moved to bpf_mem_alloc. Meaning smap->bpf_ma == true
-		 * for task storage, so this bpf_obj_free_fields() won't unpin
-		 * any uptr.
-		 */
-		bpf_obj_free_fields(smap->map.record, SDATA(selem)->data);
-		__bpf_selem_free(selem, reuse_now);
-		return;
-	}
-
-	if (reuse_now) {
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
-		 */
-		bpf_mem_cache_free(&smap->selem_ma, selem);
-		return;
-	}
-
-	call_rcu_tasks_trace(&selem->rcu, bpf_selem_free_trace_rcu);
+	if (reuse_now)
+		call_rcu(&selem->rcu, bpf_selem_free_rcu);
+	else
+		call_rcu_tasks_trace(&selem->rcu, bpf_selem_free_trace_rcu);
 }
 
 static void bpf_selem_free_list(struct hlist_head *list, bool reuse_now)
 {
 	struct bpf_local_storage_elem *selem;
-	struct bpf_local_storage_map *smap;
 	struct hlist_node *n;
 
 	/* The "_safe" iteration is needed.
@@ -271,10 +173,8 @@ static void bpf_selem_free_list(struct hlist_head *list, bool reuse_now)
 	 * but bpf_selem_free will use the selem->rcu_head
 	 * which is union-ized with the selem->free_node.
 	 */
-	hlist_for_each_entry_safe(selem, n, list, free_node) {
-		smap = rcu_dereference_check(SDATA(selem)->smap, bpf_rcu_lock_held());
-		bpf_selem_free(selem, smap, reuse_now);
-	}
+	hlist_for_each_entry_safe(selem, n, list, free_node)
+		bpf_selem_free(selem, reuse_now);
 }
 
 /* local_storage->lock must be held and selem->local_storage == local_storage.
@@ -334,47 +234,11 @@ static bool bpf_selem_unlink_storage_nolock(struct bpf_local_storage *local_stor
 	return free_local_storage;
 }
 
-static bool check_storage_bpf_ma(struct bpf_local_storage *local_storage,
-				 struct bpf_local_storage_map *storage_smap,
-				 struct bpf_local_storage_elem *selem)
-{
-
-	struct bpf_local_storage_map *selem_smap;
-
-	/* local_storage->smap may be NULL. If it is, get the bpf_ma
-	 * from any selem in the local_storage->list. The bpf_ma of all
-	 * local_storage and selem should have the same value
-	 * for the same map type.
-	 *
-	 * If the local_storage->list is already empty, the caller will not
-	 * care about the bpf_ma value also because the caller is not
-	 * responsible to free the local_storage.
-	 */
-
-	if (storage_smap)
-		return storage_smap->bpf_ma;
-
-	if (!selem) {
-		struct hlist_node *n;
-
-		n = rcu_dereference_check(hlist_first_rcu(&local_storage->list),
-					  bpf_rcu_lock_held());
-		if (!n)
-			return false;
-
-		selem = hlist_entry(n, struct bpf_local_storage_elem, snode);
-	}
-	selem_smap = rcu_dereference_check(SDATA(selem)->smap, bpf_rcu_lock_held());
-
-	return selem_smap->bpf_ma;
-}
-
 static void bpf_selem_unlink_storage(struct bpf_local_storage_elem *selem,
 				     bool reuse_now)
 {
-	struct bpf_local_storage_map *storage_smap;
 	struct bpf_local_storage *local_storage;
-	bool bpf_ma, free_local_storage = false;
+	bool free_local_storage = false;
 	HLIST_HEAD(selem_free_list);
 	unsigned long flags;
 
@@ -384,9 +248,6 @@ static void bpf_selem_unlink_storage(struct bpf_local_storage_elem *selem,
 
 	local_storage = rcu_dereference_check(selem->local_storage,
 					      bpf_rcu_lock_held());
-	storage_smap = rcu_dereference_check(local_storage->smap,
-					     bpf_rcu_lock_held());
-	bpf_ma = check_storage_bpf_ma(local_storage, storage_smap, selem);
 
 	raw_spin_lock_irqsave(&local_storage->lock, flags);
 	if (likely(selem_linked_to_storage(selem)))
@@ -397,7 +258,7 @@ static void bpf_selem_unlink_storage(struct bpf_local_storage_elem *selem,
 	bpf_selem_free_list(&selem_free_list, reuse_now);
 
 	if (free_local_storage)
-		bpf_local_storage_free(local_storage, storage_smap, bpf_ma, reuse_now);
+		bpf_local_storage_free(local_storage, reuse_now);
 }
 
 void bpf_selem_link_storage_nolock(struct bpf_local_storage *local_storage,
@@ -432,7 +293,6 @@ void bpf_selem_link_map(struct bpf_local_storage_map *smap,
 	unsigned long flags;
 
 	raw_spin_lock_irqsave(&b->lock, flags);
-	RCU_INIT_POINTER(SDATA(selem)->smap, smap);
 	hlist_add_head_rcu(&selem->map_node, &b->list);
 	raw_spin_unlock_irqrestore(&b->lock, flags);
 }
@@ -491,16 +351,14 @@ int bpf_local_storage_alloc(void *owner,
 	if (err)
 		return err;
 
-	if (smap->bpf_ma)
-		storage = bpf_mem_cache_alloc_flags(&smap->storage_ma, gfp_flags);
-	else
-		storage = bpf_map_kzalloc(&smap->map, sizeof(*storage),
-					  gfp_flags | __GFP_NOWARN);
+	storage = bpf_map_kmalloc_nolock(&smap->map, sizeof(*storage),
+					 gfp_flags, NUMA_NO_NODE);
 	if (!storage) {
 		err = -ENOMEM;
 		goto uncharge;
 	}
 
+	memset(storage->cache, 0, BPF_LOCAL_STORAGE_CACHE_SIZE * sizeof(storage->cache[0]));
 	RCU_INIT_POINTER(storage->smap, smap);
 	INIT_HLIST_HEAD(&storage->list);
 	raw_spin_lock_init(&storage->lock);
@@ -526,22 +384,12 @@ int bpf_local_storage_alloc(void *owner,
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
-	bpf_local_storage_free(storage, smap, smap->bpf_ma, true);
+	bpf_local_storage_free(storage, true);
 	mem_uncharge(smap, owner, sizeof(*storage));
 	return err;
 }
@@ -586,7 +434,7 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
 
 		err = bpf_local_storage_alloc(owner, smap, selem, gfp_flags);
 		if (err) {
-			bpf_selem_free(selem, smap, true);
+			bpf_selem_free(selem, true);
 			mem_uncharge(smap, owner, smap->elem_size);
 			return ERR_PTR(err);
 		}
@@ -662,7 +510,7 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
 	bpf_selem_free_list(&old_selem_free_list, false);
 	if (alloc_selem) {
 		mem_uncharge(smap, owner, smap->elem_size);
-		bpf_selem_free(alloc_selem, smap, true);
+		bpf_selem_free(alloc_selem, true);
 	}
 	return err ? ERR_PTR(err) : SDATA(selem);
 }
@@ -728,16 +576,12 @@ int bpf_local_storage_map_check_btf(const struct bpf_map *map,
 
 void bpf_local_storage_destroy(struct bpf_local_storage *local_storage)
 {
-	struct bpf_local_storage_map *storage_smap;
 	struct bpf_local_storage_elem *selem;
-	bool bpf_ma, free_storage = false;
+	bool free_storage = false;
 	HLIST_HEAD(free_selem_list);
 	struct hlist_node *n;
 	unsigned long flags;
 
-	storage_smap = rcu_dereference_check(local_storage->smap, bpf_rcu_lock_held());
-	bpf_ma = check_storage_bpf_ma(local_storage, storage_smap, NULL);
-
 	/* Neither the bpf_prog nor the bpf_map's syscall
 	 * could be modifying the local_storage->list now.
 	 * Thus, no elem can be added to or deleted from the
@@ -767,7 +611,7 @@ void bpf_local_storage_destroy(struct bpf_local_storage *local_storage)
 	bpf_selem_free_list(&free_selem_list, true);
 
 	if (free_storage)
-		bpf_local_storage_free(local_storage, storage_smap, bpf_ma, true);
+		bpf_local_storage_free(local_storage, true);
 }
 
 u64 bpf_local_storage_map_mem_usage(const struct bpf_map *map)
@@ -780,25 +624,13 @@ u64 bpf_local_storage_map_mem_usage(const struct bpf_map *map)
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
-			    struct bpf_local_storage_cache *cache,
-			    bool bpf_ma)
+			    struct bpf_local_storage_cache *cache)
 {
 	struct bpf_local_storage_map *smap;
 	unsigned int i;
 	u32 nbuckets;
-	int err;
 
 	smap = bpf_map_area_alloc(sizeof(*smap), NUMA_NO_NODE);
 	if (!smap)
@@ -813,8 +645,8 @@ bpf_local_storage_map_alloc(union bpf_attr *attr,
 	smap->buckets = bpf_map_kvcalloc(&smap->map, nbuckets,
 					 sizeof(*smap->buckets), GFP_USER | __GFP_NOWARN);
 	if (!smap->buckets) {
-		err = -ENOMEM;
-		goto free_smap;
+		bpf_map_area_free(smap);
+		return ERR_PTR(-ENOMEM);
 	}
 
 	for (i = 0; i < nbuckets; i++) {
@@ -825,30 +657,8 @@ bpf_local_storage_map_alloc(union bpf_attr *attr,
 	smap->elem_size = offsetof(struct bpf_local_storage_elem,
 				   sdata.data[attr->value_size]);
 
-	/* In PREEMPT_RT, kmalloc(GFP_ATOMIC) is still not safe in non
-	 * preemptible context. Thus, enforce all storages to use
-	 * bpf_mem_alloc when CONFIG_PREEMPT_RT is enabled.
-	 */
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
-
 	smap->cache_idx = bpf_local_storage_cache_idx_get(cache);
 	return &smap->map;
-
-free_smap:
-	kvfree(smap->buckets);
-	bpf_map_area_free(smap);
-	return ERR_PTR(err);
 }
 
 void bpf_local_storage_map_free(struct bpf_map *map,
@@ -910,13 +720,10 @@ void bpf_local_storage_map_free(struct bpf_map *map,
 	 */
 	synchronize_rcu();
 
-	if (smap->bpf_ma) {
-		rcu_barrier_tasks_trace();
-		if (!rcu_trace_implies_rcu_gp())
-			rcu_barrier();
-		bpf_mem_alloc_destroy(&smap->selem_ma);
-		bpf_mem_alloc_destroy(&smap->storage_ma);
-	}
+	/* Wait for in-flight bpf_obj_free_fields() */
+	rcu_barrier_tasks_trace();
+	rcu_barrier();
+
 	kvfree(smap->buckets);
 	bpf_map_area_free(smap);
 }
diff --git a/kernel/bpf/bpf_task_storage.c b/kernel/bpf/bpf_task_storage.c
index a1dc1bf0848a..baf5de6104e2 100644
--- a/kernel/bpf/bpf_task_storage.c
+++ b/kernel/bpf/bpf_task_storage.c
@@ -308,7 +308,7 @@ static int notsupp_get_next_key(struct bpf_map *map, void *key, void *next_key)
 
 static struct bpf_map *task_storage_map_alloc(union bpf_attr *attr)
 {
-	return bpf_local_storage_map_alloc(attr, &task_cache, true);
+	return bpf_local_storage_map_alloc(attr, &task_cache);
 }
 
 static void task_storage_map_free(struct bpf_map *map)
diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
index bd3c686edc0b..92b548246f04 100644
--- a/net/core/bpf_sk_storage.c
+++ b/net/core/bpf_sk_storage.c
@@ -67,7 +67,7 @@ static void bpf_sk_storage_map_free(struct bpf_map *map)
 
 static struct bpf_map *bpf_sk_storage_map_alloc(union bpf_attr *attr)
 {
-	return bpf_local_storage_map_alloc(attr, &sk_cache, false);
+	return bpf_local_storage_map_alloc(attr, &sk_cache);
 }
 
 static int notsupp_get_next_key(struct bpf_map *map, void *key,
@@ -196,7 +196,7 @@ int bpf_sk_storage_clone(const struct sock *sk, struct sock *newsk)
 		} else {
 			ret = bpf_local_storage_alloc(newsk, smap, copy_selem, GFP_ATOMIC);
 			if (ret) {
-				bpf_selem_free(copy_selem, smap, true);
+				bpf_selem_free(copy_selem, true);
 				atomic_sub(smap->elem_size,
 					   &newsk->sk_omem_alloc);
 				bpf_map_put(map);
-- 
2.47.3


