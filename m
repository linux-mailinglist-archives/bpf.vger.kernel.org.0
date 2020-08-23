Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9247F24EEEF
	for <lists+bpf@lfdr.de>; Sun, 23 Aug 2020 18:57:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727849AbgHWQ5u (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 23 Aug 2020 12:57:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727836AbgHWQ4V (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 23 Aug 2020 12:56:21 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CE14C0613ED
        for <bpf@vger.kernel.org>; Sun, 23 Aug 2020 09:56:20 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id s20so1165000wmj.1
        for <bpf@vger.kernel.org>; Sun, 23 Aug 2020 09:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y9LyXb20slEI8Y2fUXGX1+GKsYUy3ll/VjJxp8ah7vM=;
        b=XZ3umSPF4s5Ehzgw+0mFEPM9ivCteuWxltDtTJ5BMnGDVRnLaKVtWJjmsxajqfkbyV
         iXL2DW55M4n9e7zBrtb/tRz1OBlXF+X2xWZbJneeHi9vmcXaGmWXCAUVj2HpseDFaNgV
         B3v9DU83lRqSCq1Nk8dKYik2uodOOl2xASRy4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y9LyXb20slEI8Y2fUXGX1+GKsYUy3ll/VjJxp8ah7vM=;
        b=eBTo0XLuuIvXFEp5tgptqIDOZfPWM6X8/Xxnngl0vPon7mjxiDnoiFNU1tXJZdWlSI
         i3G3PjbUmoeShkhWH2Duh6KDsBAMJpiXcQDblY2SVn6ZdczIYfXrKaK4mpn9fxBS8hL4
         pbnm2wR/09A+8LUbE+xwxmUPRhavrWfb1zJyiIN7OR6vaZMC7YJo4u5k+SyiBxRow4oS
         jizXnMLXCxSAZ8JR1nk6zES+EcTWvWwUnElggoA1KLfWWBSlnP6kyh2tYxi6DjnkipvC
         Km1Qp2Du2jALzZWTKxwzhy4j0WzLzvW+Zh5d9w9JcZC1GhEdPBEfctycpbbvUTYMNuQt
         /RYw==
X-Gm-Message-State: AOAM5310/I0I7OqNIoGhYYMkqRXLadlwz1h7XY5HJ2/AKql9LyhANGso
        nnPNl6RG1YAOJ9JA8TV/2Nyr/g==
X-Google-Smtp-Source: ABdhPJzO3jfftft428LHwMyG2iOWlfV+4GyDr69npzwItNhZOp6CkB0IJx5tQ34BXdO/I1F4bgGu9A==
X-Received: by 2002:a7b:c1d0:: with SMTP id a16mr2140074wmj.111.1598201778135;
        Sun, 23 Aug 2020 09:56:18 -0700 (PDT)
Received: from kpsingh.zrh.corp.google.com ([81.6.44.51])
        by smtp.gmail.com with ESMTPSA id d10sm5425974wrg.3.2020.08.23.09.56.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2020 09:56:17 -0700 (PDT)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc:     Martin KaFai Lau <kafai@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>
Subject: [PATCH bpf-next v9 1/7] bpf: Renames in preparation for bpf_local_storage
Date:   Sun, 23 Aug 2020 18:56:06 +0200
Message-Id: <20200823165612.404892-2-kpsingh@chromium.org>
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d-goog
In-Reply-To: <20200823165612.404892-1-kpsingh@chromium.org>
References: <20200823165612.404892-1-kpsingh@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: KP Singh <kpsingh@google.com>

A purely mechanical change to split the renaming from the actual
generalization.

Flags/consts:

  SK_STORAGE_CREATE_FLAG_MASK	BPF_LOCAL_STORAGE_CREATE_FLAG_MASK
  BPF_SK_STORAGE_CACHE_SIZE	BPF_LOCAL_STORAGE_CACHE_SIZE
  MAX_VALUE_SIZE		BPF_LOCAL_STORAGE_MAX_VALUE_SIZE

Structs:

  bucket			bpf_local_storage_map_bucket
  bpf_sk_storage_map		bpf_local_storage_map
  bpf_sk_storage_data		bpf_local_storage_data
  bpf_sk_storage_elem		bpf_local_storage_elem
  bpf_sk_storage		bpf_local_storage

The "sk" member in bpf_local_storage is also updated to "owner"
in preparation for changing the type to void * in a subsequent patch.

Functions:

  selem_linked_to_sk			selem_linked_to_storage
  selem_alloc				bpf_selem_alloc
  __selem_unlink_sk			bpf_selem_unlink_storage_nolock
  __selem_link_sk			bpf_selem_link_storage_nolock
  selem_unlink_sk			__bpf_selem_unlink_storage
  sk_storage_update			bpf_local_storage_update
  __sk_storage_lookup			bpf_local_storage_lookup
  bpf_sk_storage_map_free		bpf_local_storage_map_free
  bpf_sk_storage_map_alloc		bpf_local_storage_map_alloc
  bpf_sk_storage_map_alloc_check	bpf_local_storage_map_alloc_check
  bpf_sk_storage_map_check_btf		bpf_local_storage_map_check_btf

Acked-by: Martin KaFai Lau <kafai@fb.com>
Signed-off-by: KP Singh <kpsingh@google.com>
---
 include/net/sock.h        |   4 +-
 net/core/bpf_sk_storage.c | 488 +++++++++++++++++++-------------------
 2 files changed, 252 insertions(+), 240 deletions(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index 064637d1ddf6..18423cc9cde8 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -246,7 +246,7 @@ struct sock_common {
 	/* public: */
 };
 
-struct bpf_sk_storage;
+struct bpf_local_storage;
 
 /**
   *	struct sock - network layer representation of sockets
@@ -517,7 +517,7 @@ struct sock {
 	void                    (*sk_destruct)(struct sock *sk);
 	struct sock_reuseport __rcu	*sk_reuseport_cb;
 #ifdef CONFIG_BPF_SYSCALL
-	struct bpf_sk_storage __rcu	*sk_bpf_storage;
+	struct bpf_local_storage __rcu	*sk_bpf_storage;
 #endif
 	struct rcu_head		sk_rcu;
 };
diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
index 281200dc0a01..f975e2d01207 100644
--- a/net/core/bpf_sk_storage.c
+++ b/net/core/bpf_sk_storage.c
@@ -12,33 +12,32 @@
 #include <uapi/linux/sock_diag.h>
 #include <uapi/linux/btf.h>
 
-#define SK_STORAGE_CREATE_FLAG_MASK					\
-	(BPF_F_NO_PREALLOC | BPF_F_CLONE)
+#define BPF_LOCAL_STORAGE_CREATE_FLAG_MASK (BPF_F_NO_PREALLOC | BPF_F_CLONE)
 
-struct bucket {
+struct bpf_local_storage_map_bucket {
 	struct hlist_head list;
 	raw_spinlock_t lock;
 };
 
-/* Thp map is not the primary owner of a bpf_sk_storage_elem.
- * Instead, the sk->sk_bpf_storage is.
+/* Thp map is not the primary owner of a bpf_local_storage_elem.
+ * Instead, the container object (eg. sk->sk_bpf_storage) is.
  *
- * The map (bpf_sk_storage_map) is for two purposes
- * 1. Define the size of the "sk local storage".  It is
+ * The map (bpf_local_storage_map) is for two purposes
+ * 1. Define the size of the "local storage".  It is
  *    the map's value_size.
  *
  * 2. Maintain a list to keep track of all elems such
  *    that they can be cleaned up during the map destruction.
  *
  * When a bpf local storage is being looked up for a
- * particular sk,  the "bpf_map" pointer is actually used
+ * particular object,  the "bpf_map" pointer is actually used
  * as the "key" to search in the list of elem in
- * sk->sk_bpf_storage.
+ * the respective bpf_local_storage owned by the object.
  *
- * Hence, consider sk->sk_bpf_storage is the mini-map
- * with the "bpf_map" pointer as the searching key.
+ * e.g. sk->sk_bpf_storage is the mini-map with the "bpf_map" pointer
+ * as the searching key.
  */
-struct bpf_sk_storage_map {
+struct bpf_local_storage_map {
 	struct bpf_map map;
 	/* Lookup elem does not require accessing the map.
 	 *
@@ -46,55 +45,57 @@ struct bpf_sk_storage_map {
 	 * link/unlink the elem from the map.  Having
 	 * multiple buckets to improve contention.
 	 */
-	struct bucket *buckets;
+	struct bpf_local_storage_map_bucket *buckets;
 	u32 bucket_log;
 	u16 elem_size;
 	u16 cache_idx;
 };
 
-struct bpf_sk_storage_data {
+struct bpf_local_storage_data {
 	/* smap is used as the searching key when looking up
-	 * from sk->sk_bpf_storage.
+	 * from the object's bpf_local_storage.
 	 *
 	 * Put it in the same cacheline as the data to minimize
 	 * the number of cachelines access during the cache hit case.
 	 */
-	struct bpf_sk_storage_map __rcu *smap;
+	struct bpf_local_storage_map __rcu *smap;
 	u8 data[] __aligned(8);
 };
 
-/* Linked to bpf_sk_storage and bpf_sk_storage_map */
-struct bpf_sk_storage_elem {
-	struct hlist_node map_node;	/* Linked to bpf_sk_storage_map */
-	struct hlist_node snode;	/* Linked to bpf_sk_storage */
-	struct bpf_sk_storage __rcu *sk_storage;
+/* Linked to bpf_local_storage and bpf_local_storage_map */
+struct bpf_local_storage_elem {
+	struct hlist_node map_node;	/* Linked to bpf_local_storage_map */
+	struct hlist_node snode;	/* Linked to bpf_local_storage */
+	struct bpf_local_storage __rcu *local_storage;
 	struct rcu_head rcu;
 	/* 8 bytes hole */
 	/* The data is stored in aother cacheline to minimize
 	 * the number of cachelines access during a cache hit.
 	 */
-	struct bpf_sk_storage_data sdata ____cacheline_aligned;
+	struct bpf_local_storage_data sdata ____cacheline_aligned;
 };
 
-#define SELEM(_SDATA) container_of((_SDATA), struct bpf_sk_storage_elem, sdata)
+#define SELEM(_SDATA)							\
+	container_of((_SDATA), struct bpf_local_storage_elem, sdata)
 #define SDATA(_SELEM) (&(_SELEM)->sdata)
-#define BPF_SK_STORAGE_CACHE_SIZE	16
+#define BPF_LOCAL_STORAGE_CACHE_SIZE	16
 
 static DEFINE_SPINLOCK(cache_idx_lock);
-static u64 cache_idx_usage_counts[BPF_SK_STORAGE_CACHE_SIZE];
+static u64 cache_idx_usage_counts[BPF_LOCAL_STORAGE_CACHE_SIZE];
 
-struct bpf_sk_storage {
-	struct bpf_sk_storage_data __rcu *cache[BPF_SK_STORAGE_CACHE_SIZE];
-	struct hlist_head list;	/* List of bpf_sk_storage_elem */
-	struct sock *sk;	/* The sk that owns the the above "list" of
-				 * bpf_sk_storage_elem.
+struct bpf_local_storage {
+	struct bpf_local_storage_data __rcu *cache[BPF_LOCAL_STORAGE_CACHE_SIZE];
+	struct hlist_head list; /* List of bpf_local_storage_elem */
+	struct sock *owner;	/* The object that owns the above "list" of
+				 * bpf_local_storage_elem.
 				 */
 	struct rcu_head rcu;
 	raw_spinlock_t lock;	/* Protect adding/removing from the "list" */
 };
 
-static struct bucket *select_bucket(struct bpf_sk_storage_map *smap,
-				    struct bpf_sk_storage_elem *selem)
+static struct bpf_local_storage_map_bucket *
+select_bucket(struct bpf_local_storage_map *smap,
+	      struct bpf_local_storage_elem *selem)
 {
 	return &smap->buckets[hash_ptr(selem, smap->bucket_log)];
 }
@@ -111,21 +112,21 @@ static int omem_charge(struct sock *sk, unsigned int size)
 	return -ENOMEM;
 }
 
-static bool selem_linked_to_sk(const struct bpf_sk_storage_elem *selem)
+static bool selem_linked_to_storage(const struct bpf_local_storage_elem *selem)
 {
 	return !hlist_unhashed(&selem->snode);
 }
 
-static bool selem_linked_to_map(const struct bpf_sk_storage_elem *selem)
+static bool selem_linked_to_map(const struct bpf_local_storage_elem *selem)
 {
 	return !hlist_unhashed(&selem->map_node);
 }
 
-static struct bpf_sk_storage_elem *selem_alloc(struct bpf_sk_storage_map *smap,
-					       struct sock *sk, void *value,
-					       bool charge_omem)
+static struct bpf_local_storage_elem *
+bpf_selem_alloc(struct bpf_local_storage_map *smap, struct sock *sk,
+		void *value, bool charge_omem)
 {
-	struct bpf_sk_storage_elem *selem;
+	struct bpf_local_storage_elem *selem;
 
 	if (charge_omem && omem_charge(sk, smap->elem_size))
 		return NULL;
@@ -143,89 +144,93 @@ static struct bpf_sk_storage_elem *selem_alloc(struct bpf_sk_storage_map *smap,
 	return NULL;
 }
 
-/* sk_storage->lock must be held and selem->sk_storage == sk_storage.
+/* local_storage->lock must be held and selem->local_storage == local_storage.
  * The caller must ensure selem->smap is still valid to be
  * dereferenced for its smap->elem_size and smap->cache_idx.
  */
-static bool __selem_unlink_sk(struct bpf_sk_storage *sk_storage,
-			      struct bpf_sk_storage_elem *selem,
-			      bool uncharge_omem)
+static bool
+bpf_selem_unlink_storage_nolock(struct bpf_local_storage *local_storage,
+				struct bpf_local_storage_elem *selem,
+				bool uncharge_omem)
 {
-	struct bpf_sk_storage_map *smap;
-	bool free_sk_storage;
+	struct bpf_local_storage_map *smap;
+	bool free_local_storage;
 	struct sock *sk;
 
 	smap = rcu_dereference(SDATA(selem)->smap);
-	sk = sk_storage->sk;
+	sk = local_storage->owner;
 
-	/* All uncharging on sk->sk_omem_alloc must be done first.
-	 * sk may be freed once the last selem is unlinked from sk_storage.
+	/* All uncharging on the owner must be done first.
+	 * The owner may be freed once the last selem is unlinked
+	 * from local_storage.
 	 */
 	if (uncharge_omem)
 		atomic_sub(smap->elem_size, &sk->sk_omem_alloc);
 
-	free_sk_storage = hlist_is_singular_node(&selem->snode,
-						 &sk_storage->list);
-	if (free_sk_storage) {
-		atomic_sub(sizeof(struct bpf_sk_storage), &sk->sk_omem_alloc);
-		sk_storage->sk = NULL;
+	free_local_storage = hlist_is_singular_node(&selem->snode,
+						    &local_storage->list);
+	if (free_local_storage) {
+		atomic_sub(sizeof(struct bpf_local_storage), &sk->sk_omem_alloc);
+		local_storage->owner = NULL;
 		/* After this RCU_INIT, sk may be freed and cannot be used */
 		RCU_INIT_POINTER(sk->sk_bpf_storage, NULL);
 
-		/* sk_storage is not freed now.  sk_storage->lock is
-		 * still held and raw_spin_unlock_bh(&sk_storage->lock)
+		/* local_storage is not freed now.  local_storage->lock is
+		 * still held and raw_spin_unlock_bh(&local_storage->lock)
 		 * will be done by the caller.
 		 *
 		 * Although the unlock will be done under
 		 * rcu_read_lock(),  it is more intutivie to
-		 * read if kfree_rcu(sk_storage, rcu) is done
-		 * after the raw_spin_unlock_bh(&sk_storage->lock).
+		 * read if kfree_rcu(local_storage, rcu) is done
+		 * after the raw_spin_unlock_bh(&local_storage->lock).
 		 *
-		 * Hence, a "bool free_sk_storage" is returned
+		 * Hence, a "bool free_local_storage" is returned
 		 * to the caller which then calls the kfree_rcu()
 		 * after unlock.
 		 */
 	}
 	hlist_del_init_rcu(&selem->snode);
-	if (rcu_access_pointer(sk_storage->cache[smap->cache_idx]) ==
+	if (rcu_access_pointer(local_storage->cache[smap->cache_idx]) ==
 	    SDATA(selem))
-		RCU_INIT_POINTER(sk_storage->cache[smap->cache_idx], NULL);
+		RCU_INIT_POINTER(local_storage->cache[smap->cache_idx], NULL);
 
 	kfree_rcu(selem, rcu);
 
-	return free_sk_storage;
+	return free_local_storage;
 }
 
-static void selem_unlink_sk(struct bpf_sk_storage_elem *selem)
+static void __bpf_selem_unlink_storage(struct bpf_local_storage_elem *selem)
 {
-	struct bpf_sk_storage *sk_storage;
-	bool free_sk_storage = false;
+	struct bpf_local_storage *local_storage;
+	bool free_local_storage = false;
 
-	if (unlikely(!selem_linked_to_sk(selem)))
+	if (unlikely(!selem_linked_to_storage(selem)))
 		/* selem has already been unlinked from sk */
 		return;
 
-	sk_storage = rcu_dereference(selem->sk_storage);
-	raw_spin_lock_bh(&sk_storage->lock);
-	if (likely(selem_linked_to_sk(selem)))
-		free_sk_storage = __selem_unlink_sk(sk_storage, selem, true);
-	raw_spin_unlock_bh(&sk_storage->lock);
+	local_storage = rcu_dereference(selem->local_storage);
+	raw_spin_lock_bh(&local_storage->lock);
+	if (likely(selem_linked_to_storage(selem)))
+		free_local_storage =
+			bpf_selem_unlink_storage_nolock(local_storage, selem, true);
+	raw_spin_unlock_bh(&local_storage->lock);
 
-	if (free_sk_storage)
-		kfree_rcu(sk_storage, rcu);
+	if (free_local_storage)
+		kfree_rcu(local_storage, rcu);
 }
 
-static void __selem_link_sk(struct bpf_sk_storage *sk_storage,
-			    struct bpf_sk_storage_elem *selem)
+static void
+bpf_selem_link_storage_nolock(struct bpf_local_storage *local_storage,
+			      struct bpf_local_storage_elem *selem)
 {
-	RCU_INIT_POINTER(selem->sk_storage, sk_storage);
-	hlist_add_head(&selem->snode, &sk_storage->list);
+	RCU_INIT_POINTER(selem->local_storage, local_storage);
+	hlist_add_head(&selem->snode, &local_storage->list);
 }
 
-static void selem_unlink_map(struct bpf_sk_storage_elem *selem)
+static void bpf_selem_unlink_map(struct bpf_local_storage_elem *selem)
 {
-	struct bpf_sk_storage_map *smap;
-	struct bucket *b;
+	struct bpf_local_storage_map *smap;
+	struct bpf_local_storage_map_bucket *b;
 
 	if (unlikely(!selem_linked_to_map(selem)))
 		/* selem has already be unlinked from smap */
@@ -239,10 +244,10 @@ static void selem_unlink_map(struct bpf_sk_storage_elem *selem)
 	raw_spin_unlock_bh(&b->lock);
 }
 
-static void selem_link_map(struct bpf_sk_storage_map *smap,
-			   struct bpf_sk_storage_elem *selem)
+static void bpf_selem_link_map(struct bpf_local_storage_map *smap,
+			       struct bpf_local_storage_elem *selem)
 {
-	struct bucket *b = select_bucket(smap, selem);
+	struct bpf_local_storage_map_bucket *b = select_bucket(smap, selem);
 
 	raw_spin_lock_bh(&b->lock);
 	RCU_INIT_POINTER(SDATA(selem)->smap, smap);
@@ -250,31 +255,31 @@ static void selem_link_map(struct bpf_sk_storage_map *smap,
 	raw_spin_unlock_bh(&b->lock);
 }
 
-static void selem_unlink(struct bpf_sk_storage_elem *selem)
+static void bpf_selem_unlink(struct bpf_local_storage_elem *selem)
 {
-	/* Always unlink from map before unlinking from sk_storage
+	/* Always unlink from map before unlinking from local_storage
 	 * because selem will be freed after successfully unlinked from
-	 * the sk_storage.
+	 * the local_storage.
 	 */
-	selem_unlink_map(selem);
-	selem_unlink_sk(selem);
+	bpf_selem_unlink_map(selem);
+	__bpf_selem_unlink_storage(selem);
 }
 
-static struct bpf_sk_storage_data *
-__sk_storage_lookup(struct bpf_sk_storage *sk_storage,
-		    struct bpf_sk_storage_map *smap,
-		    bool cacheit_lockit)
+static struct bpf_local_storage_data *
+bpf_local_storage_lookup(struct bpf_local_storage *local_storage,
+			 struct bpf_local_storage_map *smap,
+			 bool cacheit_lockit)
 {
-	struct bpf_sk_storage_data *sdata;
-	struct bpf_sk_storage_elem *selem;
+	struct bpf_local_storage_data *sdata;
+	struct bpf_local_storage_elem *selem;
 
 	/* Fast path (cache hit) */
-	sdata = rcu_dereference(sk_storage->cache[smap->cache_idx]);
+	sdata = rcu_dereference(local_storage->cache[smap->cache_idx]);
 	if (sdata && rcu_access_pointer(sdata->smap) == smap)
 		return sdata;
 
 	/* Slow path (cache miss) */
-	hlist_for_each_entry_rcu(selem, &sk_storage->list, snode)
+	hlist_for_each_entry_rcu(selem, &local_storage->list, snode)
 		if (rcu_access_pointer(SDATA(selem)->smap) == smap)
 			break;
 
@@ -286,33 +291,33 @@ __sk_storage_lookup(struct bpf_sk_storage *sk_storage,
 		/* spinlock is needed to avoid racing with the
 		 * parallel delete.  Otherwise, publishing an already
 		 * deleted sdata to the cache will become a use-after-free
-		 * problem in the next __sk_storage_lookup().
+		 * problem in the next bpf_local_storage_lookup().
 		 */
-		raw_spin_lock_bh(&sk_storage->lock);
-		if (selem_linked_to_sk(selem))
-			rcu_assign_pointer(sk_storage->cache[smap->cache_idx],
+		raw_spin_lock_bh(&local_storage->lock);
+		if (selem_linked_to_storage(selem))
+			rcu_assign_pointer(local_storage->cache[smap->cache_idx],
 					   sdata);
-		raw_spin_unlock_bh(&sk_storage->lock);
+		raw_spin_unlock_bh(&local_storage->lock);
 	}
 
 	return sdata;
 }
 
-static struct bpf_sk_storage_data *
+static struct bpf_local_storage_data *
 sk_storage_lookup(struct sock *sk, struct bpf_map *map, bool cacheit_lockit)
 {
-	struct bpf_sk_storage *sk_storage;
-	struct bpf_sk_storage_map *smap;
+	struct bpf_local_storage *sk_storage;
+	struct bpf_local_storage_map *smap;
 
 	sk_storage = rcu_dereference(sk->sk_bpf_storage);
 	if (!sk_storage)
 		return NULL;
 
-	smap = (struct bpf_sk_storage_map *)map;
-	return __sk_storage_lookup(sk_storage, smap, cacheit_lockit);
+	smap = (struct bpf_local_storage_map *)map;
+	return bpf_local_storage_lookup(sk_storage, smap, cacheit_lockit);
 }
 
-static int check_flags(const struct bpf_sk_storage_data *old_sdata,
+static int check_flags(const struct bpf_local_storage_data *old_sdata,
 		       u64 map_flags)
 {
 	if (old_sdata && (map_flags & ~BPF_F_LOCK) == BPF_NOEXIST)
@@ -327,10 +332,10 @@ static int check_flags(const struct bpf_sk_storage_data *old_sdata,
 }
 
 static int sk_storage_alloc(struct sock *sk,
-			    struct bpf_sk_storage_map *smap,
-			    struct bpf_sk_storage_elem *first_selem)
+			    struct bpf_local_storage_map *smap,
+			    struct bpf_local_storage_elem *first_selem)
 {
-	struct bpf_sk_storage *prev_sk_storage, *sk_storage;
+	struct bpf_local_storage *prev_sk_storage, *sk_storage;
 	int err;
 
 	err = omem_charge(sk, sizeof(*sk_storage));
@@ -344,10 +349,10 @@ static int sk_storage_alloc(struct sock *sk,
 	}
 	INIT_HLIST_HEAD(&sk_storage->list);
 	raw_spin_lock_init(&sk_storage->lock);
-	sk_storage->sk = sk;
+	sk_storage->owner = sk;
 
-	__selem_link_sk(sk_storage, first_selem);
-	selem_link_map(smap, first_selem);
+	bpf_selem_link_storage_nolock(sk_storage, first_selem);
+	bpf_selem_link_map(smap, first_selem);
 	/* Publish sk_storage to sk.  sk->sk_lock cannot be acquired.
 	 * Hence, atomic ops is used to set sk->sk_bpf_storage
 	 * from NULL to the newly allocated sk_storage ptr.
@@ -357,17 +362,17 @@ static int sk_storage_alloc(struct sock *sk,
 	 * the sk->sk_bpf_storage, the sk_storage->lock must
 	 * be held before setting sk->sk_bpf_storage to NULL.
 	 */
-	prev_sk_storage = cmpxchg((struct bpf_sk_storage **)&sk->sk_bpf_storage,
+	prev_sk_storage = cmpxchg((struct bpf_local_storage **)&sk->sk_bpf_storage,
 				  NULL, sk_storage);
 	if (unlikely(prev_sk_storage)) {
-		selem_unlink_map(first_selem);
+		bpf_selem_unlink_map(first_selem);
 		err = -EAGAIN;
 		goto uncharge;
 
 		/* Note that even first_selem was linked to smap's
 		 * bucket->list, first_selem can be freed immediately
 		 * (instead of kfree_rcu) because
-		 * bpf_sk_storage_map_free() does a
+		 * bpf_local_storage_map_free() does a
 		 * synchronize_rcu() before walking the bucket->list.
 		 * Hence, no one is accessing selem from the
 		 * bucket->list under rcu_read_lock().
@@ -387,15 +392,14 @@ static int sk_storage_alloc(struct sock *sk,
  * Otherwise, it will become a leak (and other memory issues
  * during map destruction).
  */
-static struct bpf_sk_storage_data *sk_storage_update(struct sock *sk,
-						     struct bpf_map *map,
-						     void *value,
-						     u64 map_flags)
+static struct bpf_local_storage_data *
+bpf_local_storage_update(struct sock *sk, struct bpf_map *map, void *value,
+			 u64 map_flags)
 {
-	struct bpf_sk_storage_data *old_sdata = NULL;
-	struct bpf_sk_storage_elem *selem;
-	struct bpf_sk_storage *sk_storage;
-	struct bpf_sk_storage_map *smap;
+	struct bpf_local_storage_data *old_sdata = NULL;
+	struct bpf_local_storage_elem *selem;
+	struct bpf_local_storage *local_storage;
+	struct bpf_local_storage_map *smap;
 	int err;
 
 	/* BPF_EXIST and BPF_NOEXIST cannot be both set */
@@ -404,15 +408,15 @@ static struct bpf_sk_storage_data *sk_storage_update(struct sock *sk,
 	    unlikely((map_flags & BPF_F_LOCK) && !map_value_has_spin_lock(map)))
 		return ERR_PTR(-EINVAL);
 
-	smap = (struct bpf_sk_storage_map *)map;
-	sk_storage = rcu_dereference(sk->sk_bpf_storage);
-	if (!sk_storage || hlist_empty(&sk_storage->list)) {
-		/* Very first elem for this sk */
+	smap = (struct bpf_local_storage_map *)map;
+	local_storage = rcu_dereference(sk->sk_bpf_storage);
+	if (!local_storage || hlist_empty(&local_storage->list)) {
+		/* Very first elem for the owner */
 		err = check_flags(NULL, map_flags);
 		if (err)
 			return ERR_PTR(err);
 
-		selem = selem_alloc(smap, sk, value, true);
+		selem = bpf_selem_alloc(smap, sk, value, true);
 		if (!selem)
 			return ERR_PTR(-ENOMEM);
 
@@ -428,25 +432,26 @@ static struct bpf_sk_storage_data *sk_storage_update(struct sock *sk,
 
 	if ((map_flags & BPF_F_LOCK) && !(map_flags & BPF_NOEXIST)) {
 		/* Hoping to find an old_sdata to do inline update
-		 * such that it can avoid taking the sk_storage->lock
+		 * such that it can avoid taking the local_storage->lock
 		 * and changing the lists.
 		 */
-		old_sdata = __sk_storage_lookup(sk_storage, smap, false);
+		old_sdata =
+			bpf_local_storage_lookup(local_storage, smap, false);
 		err = check_flags(old_sdata, map_flags);
 		if (err)
 			return ERR_PTR(err);
-		if (old_sdata && selem_linked_to_sk(SELEM(old_sdata))) {
+		if (old_sdata && selem_linked_to_storage(SELEM(old_sdata))) {
 			copy_map_value_locked(map, old_sdata->data,
 					      value, false);
 			return old_sdata;
 		}
 	}
 
-	raw_spin_lock_bh(&sk_storage->lock);
+	raw_spin_lock_bh(&local_storage->lock);
 
-	/* Recheck sk_storage->list under sk_storage->lock */
-	if (unlikely(hlist_empty(&sk_storage->list))) {
-		/* A parallel del is happening and sk_storage is going
+	/* Recheck local_storage->list under local_storage->lock */
+	if (unlikely(hlist_empty(&local_storage->list))) {
+		/* A parallel del is happening and local_storage is going
 		 * away.  It has just been checked before, so very
 		 * unlikely.  Return instead of retry to keep things
 		 * simple.
@@ -455,7 +460,7 @@ static struct bpf_sk_storage_data *sk_storage_update(struct sock *sk,
 		goto unlock_err;
 	}
 
-	old_sdata = __sk_storage_lookup(sk_storage, smap, false);
+	old_sdata = bpf_local_storage_lookup(local_storage, smap, false);
 	err = check_flags(old_sdata, map_flags);
 	if (err)
 		goto unlock_err;
@@ -466,50 +471,52 @@ static struct bpf_sk_storage_data *sk_storage_update(struct sock *sk,
 		goto unlock;
 	}
 
-	/* sk_storage->lock is held.  Hence, we are sure
+	/* local_storage->lock is held.  Hence, we are sure
 	 * we can unlink and uncharge the old_sdata successfully
 	 * later.  Hence, instead of charging the new selem now
 	 * and then uncharge the old selem later (which may cause
 	 * a potential but unnecessary charge failure),  avoid taking
 	 * a charge at all here (the "!old_sdata" check) and the
-	 * old_sdata will not be uncharged later during __selem_unlink_sk().
+	 * old_sdata will not be uncharged later during
+	 * bpf_selem_unlink_storage_nolock().
 	 */
-	selem = selem_alloc(smap, sk, value, !old_sdata);
+	selem = bpf_selem_alloc(smap, sk, value, !old_sdata);
 	if (!selem) {
 		err = -ENOMEM;
 		goto unlock_err;
 	}
 
 	/* First, link the new selem to the map */
-	selem_link_map(smap, selem);
+	bpf_selem_link_map(smap, selem);
 
-	/* Second, link (and publish) the new selem to sk_storage */
-	__selem_link_sk(sk_storage, selem);
+	/* Second, link (and publish) the new selem to local_storage */
+	bpf_selem_link_storage_nolock(local_storage, selem);
 
 	/* Third, remove old selem, SELEM(old_sdata) */
 	if (old_sdata) {
-		selem_unlink_map(SELEM(old_sdata));
-		__selem_unlink_sk(sk_storage, SELEM(old_sdata), false);
+		bpf_selem_unlink_map(SELEM(old_sdata));
+		bpf_selem_unlink_storage_nolock(local_storage, SELEM(old_sdata),
+						false);
 	}
 
 unlock:
-	raw_spin_unlock_bh(&sk_storage->lock);
+	raw_spin_unlock_bh(&local_storage->lock);
 	return SDATA(selem);
 
 unlock_err:
-	raw_spin_unlock_bh(&sk_storage->lock);
+	raw_spin_unlock_bh(&local_storage->lock);
 	return ERR_PTR(err);
 }
 
 static int sk_storage_delete(struct sock *sk, struct bpf_map *map)
 {
-	struct bpf_sk_storage_data *sdata;
+	struct bpf_local_storage_data *sdata;
 
 	sdata = sk_storage_lookup(sk, map, false);
 	if (!sdata)
 		return -ENOENT;
 
-	selem_unlink(SELEM(sdata));
+	bpf_selem_unlink(SELEM(sdata));
 
 	return 0;
 }
@@ -521,7 +528,7 @@ static u16 cache_idx_get(void)
 
 	spin_lock(&cache_idx_lock);
 
-	for (i = 0; i < BPF_SK_STORAGE_CACHE_SIZE; i++) {
+	for (i = 0; i < BPF_LOCAL_STORAGE_CACHE_SIZE; i++) {
 		if (cache_idx_usage_counts[i] < min_usage) {
 			min_usage = cache_idx_usage_counts[i];
 			res = i;
@@ -548,8 +555,8 @@ static void cache_idx_free(u16 idx)
 /* Called by __sk_destruct() & bpf_sk_storage_clone() */
 void bpf_sk_storage_free(struct sock *sk)
 {
-	struct bpf_sk_storage_elem *selem;
-	struct bpf_sk_storage *sk_storage;
+	struct bpf_local_storage_elem *selem;
+	struct bpf_local_storage *sk_storage;
 	bool free_sk_storage = false;
 	struct hlist_node *n;
 
@@ -565,7 +572,7 @@ void bpf_sk_storage_free(struct sock *sk)
 	 * Thus, no elem can be added-to or deleted-from the
 	 * sk_storage->list by the bpf_prog or by the bpf-map's syscall.
 	 *
-	 * It is racing with bpf_sk_storage_map_free() alone
+	 * It is racing with bpf_local_storage_map_free() alone
 	 * when unlinking elem from the sk_storage->list and
 	 * the map's bucket->list.
 	 */
@@ -574,8 +581,9 @@ void bpf_sk_storage_free(struct sock *sk)
 		/* Always unlink from map before unlinking from
 		 * sk_storage.
 		 */
-		selem_unlink_map(selem);
-		free_sk_storage = __selem_unlink_sk(sk_storage, selem, true);
+		bpf_selem_unlink_map(selem);
+		free_sk_storage = bpf_selem_unlink_storage_nolock(sk_storage,
+								  selem, true);
 	}
 	raw_spin_unlock_bh(&sk_storage->lock);
 	rcu_read_unlock();
@@ -584,14 +592,14 @@ void bpf_sk_storage_free(struct sock *sk)
 		kfree_rcu(sk_storage, rcu);
 }
 
-static void bpf_sk_storage_map_free(struct bpf_map *map)
+static void bpf_local_storage_map_free(struct bpf_map *map)
 {
-	struct bpf_sk_storage_elem *selem;
-	struct bpf_sk_storage_map *smap;
-	struct bucket *b;
+	struct bpf_local_storage_elem *selem;
+	struct bpf_local_storage_map *smap;
+	struct bpf_local_storage_map_bucket *b;
 	unsigned int i;
 
-	smap = (struct bpf_sk_storage_map *)map;
+	smap = (struct bpf_local_storage_map *)map;
 
 	cache_idx_free(smap->cache_idx);
 
@@ -604,10 +612,10 @@ static void bpf_sk_storage_map_free(struct bpf_map *map)
 
 	/* bpf prog and the userspace can no longer access this map
 	 * now.  No new selem (of this map) can be added
-	 * to the sk->sk_bpf_storage or to the map bucket's list.
+	 * to the owner->storage or to the map bucket's list.
 	 *
 	 * The elem of this map can be cleaned up here
-	 * or
+	 * or when the storage is freed e.g.
 	 * by bpf_sk_storage_free() during __sk_destruct().
 	 */
 	for (i = 0; i < (1U << smap->bucket_log); i++) {
@@ -615,26 +623,26 @@ static void bpf_sk_storage_map_free(struct bpf_map *map)
 
 		rcu_read_lock();
 		/* No one is adding to b->list now */
-		while ((selem = hlist_entry_safe(rcu_dereference_raw(hlist_first_rcu(&b->list)),
-						 struct bpf_sk_storage_elem,
-						 map_node))) {
-			selem_unlink(selem);
+		while ((selem = hlist_entry_safe(
+				rcu_dereference_raw(hlist_first_rcu(&b->list)),
+				struct bpf_local_storage_elem, map_node))) {
+			bpf_selem_unlink(selem);
 			cond_resched_rcu();
 		}
 		rcu_read_unlock();
 	}
 
-	/* bpf_sk_storage_free() may still need to access the map.
-	 * e.g. bpf_sk_storage_free() has unlinked selem from the map
+	/* While freeing the storage we may still need to access the map.
+	 *
+	 * e.g. when bpf_sk_storage_free() has unlinked selem from the map
 	 * which then made the above while((selem = ...)) loop
-	 * exited immediately.
+	 * exit immediately.
 	 *
-	 * However, the bpf_sk_storage_free() still needs to access
-	 * the smap->elem_size to do the uncharging in
-	 * __selem_unlink_sk().
+	 * However, while freeing the storage one still needs to access the
+	 * smap->elem_size to do the uncharging in
+	 * bpf_selem_unlink_storage_nolock().
 	 *
-	 * Hence, wait another rcu grace period for the
-	 * bpf_sk_storage_free() to finish.
+	 * Hence, wait another rcu grace period for the storage to be freed.
 	 */
 	synchronize_rcu();
 
@@ -645,14 +653,15 @@ static void bpf_sk_storage_map_free(struct bpf_map *map)
 /* U16_MAX is much more than enough for sk local storage
  * considering a tcp_sock is ~2k.
  */
-#define MAX_VALUE_SIZE							\
+#define BPF_LOCAL_STORAGE_MAX_VALUE_SIZE				\
 	min_t(u32,							\
-	      (KMALLOC_MAX_SIZE - MAX_BPF_STACK - sizeof(struct bpf_sk_storage_elem)), \
-	      (U16_MAX - sizeof(struct bpf_sk_storage_elem)))
+	      (KMALLOC_MAX_SIZE - MAX_BPF_STACK -			\
+	       sizeof(struct bpf_local_storage_elem)),			\
+	      (U16_MAX - sizeof(struct bpf_local_storage_elem)))
 
-static int bpf_sk_storage_map_alloc_check(union bpf_attr *attr)
+static int bpf_local_storage_map_alloc_check(union bpf_attr *attr)
 {
-	if (attr->map_flags & ~SK_STORAGE_CREATE_FLAG_MASK ||
+	if (attr->map_flags & ~BPF_LOCAL_STORAGE_CREATE_FLAG_MASK ||
 	    !(attr->map_flags & BPF_F_NO_PREALLOC) ||
 	    attr->max_entries ||
 	    attr->key_size != sizeof(int) || !attr->value_size ||
@@ -663,15 +672,15 @@ static int bpf_sk_storage_map_alloc_check(union bpf_attr *attr)
 	if (!bpf_capable())
 		return -EPERM;
 
-	if (attr->value_size > MAX_VALUE_SIZE)
+	if (attr->value_size > BPF_LOCAL_STORAGE_MAX_VALUE_SIZE)
 		return -E2BIG;
 
 	return 0;
 }
 
-static struct bpf_map *bpf_sk_storage_map_alloc(union bpf_attr *attr)
+static struct bpf_map *bpf_local_storage_map_alloc(union bpf_attr *attr)
 {
-	struct bpf_sk_storage_map *smap;
+	struct bpf_local_storage_map *smap;
 	unsigned int i;
 	u32 nbuckets;
 	u64 cost;
@@ -707,7 +716,8 @@ static struct bpf_map *bpf_sk_storage_map_alloc(union bpf_attr *attr)
 		raw_spin_lock_init(&smap->buckets[i].lock);
 	}
 
-	smap->elem_size = sizeof(struct bpf_sk_storage_elem) + attr->value_size;
+	smap->elem_size =
+		sizeof(struct bpf_local_storage_elem) + attr->value_size;
 	smap->cache_idx = cache_idx_get();
 
 	return &smap->map;
@@ -719,10 +729,10 @@ static int notsupp_get_next_key(struct bpf_map *map, void *key,
 	return -ENOTSUPP;
 }
 
-static int bpf_sk_storage_map_check_btf(const struct bpf_map *map,
-					const struct btf *btf,
-					const struct btf_type *key_type,
-					const struct btf_type *value_type)
+static int bpf_local_storage_map_check_btf(const struct bpf_map *map,
+					   const struct btf *btf,
+					   const struct btf_type *key_type,
+					   const struct btf_type *value_type)
 {
 	u32 int_data;
 
@@ -738,7 +748,7 @@ static int bpf_sk_storage_map_check_btf(const struct bpf_map *map,
 
 static void *bpf_fd_sk_storage_lookup_elem(struct bpf_map *map, void *key)
 {
-	struct bpf_sk_storage_data *sdata;
+	struct bpf_local_storage_data *sdata;
 	struct socket *sock;
 	int fd, err;
 
@@ -756,14 +766,15 @@ static void *bpf_fd_sk_storage_lookup_elem(struct bpf_map *map, void *key)
 static int bpf_fd_sk_storage_update_elem(struct bpf_map *map, void *key,
 					 void *value, u64 map_flags)
 {
-	struct bpf_sk_storage_data *sdata;
+	struct bpf_local_storage_data *sdata;
 	struct socket *sock;
 	int fd, err;
 
 	fd = *(int *)key;
 	sock = sockfd_lookup(fd, &err);
 	if (sock) {
-		sdata = sk_storage_update(sock->sk, map, value, map_flags);
+		sdata = bpf_local_storage_update(sock->sk, map, value,
+						 map_flags);
 		sockfd_put(sock);
 		return PTR_ERR_OR_ZERO(sdata);
 	}
@@ -787,14 +798,14 @@ static int bpf_fd_sk_storage_delete_elem(struct bpf_map *map, void *key)
 	return err;
 }
 
-static struct bpf_sk_storage_elem *
+static struct bpf_local_storage_elem *
 bpf_sk_storage_clone_elem(struct sock *newsk,
-			  struct bpf_sk_storage_map *smap,
-			  struct bpf_sk_storage_elem *selem)
+			  struct bpf_local_storage_map *smap,
+			  struct bpf_local_storage_elem *selem)
 {
-	struct bpf_sk_storage_elem *copy_selem;
+	struct bpf_local_storage_elem *copy_selem;
 
-	copy_selem = selem_alloc(smap, newsk, NULL, true);
+	copy_selem = bpf_selem_alloc(smap, newsk, NULL, true);
 	if (!copy_selem)
 		return NULL;
 
@@ -810,9 +821,9 @@ bpf_sk_storage_clone_elem(struct sock *newsk,
 
 int bpf_sk_storage_clone(const struct sock *sk, struct sock *newsk)
 {
-	struct bpf_sk_storage *new_sk_storage = NULL;
-	struct bpf_sk_storage *sk_storage;
-	struct bpf_sk_storage_elem *selem;
+	struct bpf_local_storage *new_sk_storage = NULL;
+	struct bpf_local_storage *sk_storage;
+	struct bpf_local_storage_elem *selem;
 	int ret = 0;
 
 	RCU_INIT_POINTER(newsk->sk_bpf_storage, NULL);
@@ -824,8 +835,8 @@ int bpf_sk_storage_clone(const struct sock *sk, struct sock *newsk)
 		goto out;
 
 	hlist_for_each_entry_rcu(selem, &sk_storage->list, snode) {
-		struct bpf_sk_storage_elem *copy_selem;
-		struct bpf_sk_storage_map *smap;
+		struct bpf_local_storage_elem *copy_selem;
+		struct bpf_local_storage_map *smap;
 		struct bpf_map *map;
 
 		smap = rcu_dereference(SDATA(selem)->smap);
@@ -833,7 +844,7 @@ int bpf_sk_storage_clone(const struct sock *sk, struct sock *newsk)
 			continue;
 
 		/* Note that for lockless listeners adding new element
-		 * here can race with cleanup in bpf_sk_storage_map_free.
+		 * here can race with cleanup in bpf_local_storage_map_free.
 		 * Try to grab map refcnt to make sure that it's still
 		 * alive and prevent concurrent removal.
 		 */
@@ -849,8 +860,8 @@ int bpf_sk_storage_clone(const struct sock *sk, struct sock *newsk)
 		}
 
 		if (new_sk_storage) {
-			selem_link_map(smap, copy_selem);
-			__selem_link_sk(new_sk_storage, copy_selem);
+			bpf_selem_link_map(smap, copy_selem);
+			bpf_selem_link_storage_nolock(new_sk_storage, copy_selem);
 		} else {
 			ret = sk_storage_alloc(newsk, smap, copy_selem);
 			if (ret) {
@@ -861,7 +872,8 @@ int bpf_sk_storage_clone(const struct sock *sk, struct sock *newsk)
 				goto out;
 			}
 
-			new_sk_storage = rcu_dereference(copy_selem->sk_storage);
+			new_sk_storage =
+				rcu_dereference(copy_selem->local_storage);
 		}
 		bpf_map_put(map);
 	}
@@ -879,7 +891,7 @@ int bpf_sk_storage_clone(const struct sock *sk, struct sock *newsk)
 BPF_CALL_4(bpf_sk_storage_get, struct bpf_map *, map, struct sock *, sk,
 	   void *, value, u64, flags)
 {
-	struct bpf_sk_storage_data *sdata;
+	struct bpf_local_storage_data *sdata;
 
 	if (flags > BPF_SK_STORAGE_GET_F_CREATE)
 		return (unsigned long)NULL;
@@ -895,7 +907,7 @@ BPF_CALL_4(bpf_sk_storage_get, struct bpf_map *, map, struct sock *, sk,
 	     *  destruction).
 	     */
 	    refcount_inc_not_zero(&sk->sk_refcnt)) {
-		sdata = sk_storage_update(sk, map, value, BPF_NOEXIST);
+		sdata = bpf_local_storage_update(sk, map, value, BPF_NOEXIST);
 		/* sk must be a fullsock (guaranteed by verifier),
 		 * so sock_gen_put() is unnecessary.
 		 */
@@ -922,15 +934,15 @@ BPF_CALL_2(bpf_sk_storage_delete, struct bpf_map *, map, struct sock *, sk)
 
 static int sk_storage_map_btf_id;
 const struct bpf_map_ops sk_storage_map_ops = {
-	.map_alloc_check = bpf_sk_storage_map_alloc_check,
-	.map_alloc = bpf_sk_storage_map_alloc,
-	.map_free = bpf_sk_storage_map_free,
+	.map_alloc_check = bpf_local_storage_map_alloc_check,
+	.map_alloc = bpf_local_storage_map_alloc,
+	.map_free = bpf_local_storage_map_free,
 	.map_get_next_key = notsupp_get_next_key,
 	.map_lookup_elem = bpf_fd_sk_storage_lookup_elem,
 	.map_update_elem = bpf_fd_sk_storage_update_elem,
 	.map_delete_elem = bpf_fd_sk_storage_delete_elem,
-	.map_check_btf = bpf_sk_storage_map_check_btf,
-	.map_btf_name = "bpf_sk_storage_map",
+	.map_check_btf = bpf_local_storage_map_check_btf,
+	.map_btf_name = "bpf_local_storage_map",
 	.map_btf_id = &sk_storage_map_btf_id,
 };
 
@@ -1022,7 +1034,7 @@ bpf_sk_storage_diag_alloc(const struct nlattr *nla_stgs)
 	u32 nr_maps = 0;
 	int rem, err;
 
-	/* bpf_sk_storage_map is currently limited to CAP_SYS_ADMIN as
+	/* bpf_local_storage_map is currently limited to CAP_SYS_ADMIN as
 	 * the map_alloc_check() side also does.
 	 */
 	if (!bpf_capable())
@@ -1072,13 +1084,13 @@ bpf_sk_storage_diag_alloc(const struct nlattr *nla_stgs)
 }
 EXPORT_SYMBOL_GPL(bpf_sk_storage_diag_alloc);
 
-static int diag_get(struct bpf_sk_storage_data *sdata, struct sk_buff *skb)
+static int diag_get(struct bpf_local_storage_data *sdata, struct sk_buff *skb)
 {
 	struct nlattr *nla_stg, *nla_value;
-	struct bpf_sk_storage_map *smap;
+	struct bpf_local_storage_map *smap;
 
 	/* It cannot exceed max nlattr's payload */
-	BUILD_BUG_ON(U16_MAX - NLA_HDRLEN < MAX_VALUE_SIZE);
+	BUILD_BUG_ON(U16_MAX - NLA_HDRLEN < BPF_LOCAL_STORAGE_MAX_VALUE_SIZE);
 
 	nla_stg = nla_nest_start(skb, SK_DIAG_BPF_STORAGE);
 	if (!nla_stg)
@@ -1114,9 +1126,9 @@ static int bpf_sk_storage_diag_put_all(struct sock *sk, struct sk_buff *skb,
 {
 	/* stg_array_type (e.g. INET_DIAG_BPF_SK_STORAGES) */
 	unsigned int diag_size = nla_total_size(0);
-	struct bpf_sk_storage *sk_storage;
-	struct bpf_sk_storage_elem *selem;
-	struct bpf_sk_storage_map *smap;
+	struct bpf_local_storage *sk_storage;
+	struct bpf_local_storage_elem *selem;
+	struct bpf_local_storage_map *smap;
 	struct nlattr *nla_stgs;
 	unsigned int saved_len;
 	int err = 0;
@@ -1169,8 +1181,8 @@ int bpf_sk_storage_diag_put(struct bpf_sk_storage_diag *diag,
 {
 	/* stg_array_type (e.g. INET_DIAG_BPF_SK_STORAGES) */
 	unsigned int diag_size = nla_total_size(0);
-	struct bpf_sk_storage *sk_storage;
-	struct bpf_sk_storage_data *sdata;
+	struct bpf_local_storage *sk_storage;
+	struct bpf_local_storage_data *sdata;
 	struct nlattr *nla_stgs;
 	unsigned int saved_len;
 	int err = 0;
@@ -1197,8 +1209,8 @@ int bpf_sk_storage_diag_put(struct bpf_sk_storage_diag *diag,
 
 	saved_len = skb->len;
 	for (i = 0; i < diag->nr_maps; i++) {
-		sdata = __sk_storage_lookup(sk_storage,
-				(struct bpf_sk_storage_map *)diag->maps[i],
+		sdata = bpf_local_storage_lookup(sk_storage,
+				(struct bpf_local_storage_map *)diag->maps[i],
 				false);
 
 		if (!sdata)
@@ -1235,19 +1247,19 @@ struct bpf_iter_seq_sk_storage_map_info {
 	unsigned skip_elems;
 };
 
-static struct bpf_sk_storage_elem *
+static struct bpf_local_storage_elem *
 bpf_sk_storage_map_seq_find_next(struct bpf_iter_seq_sk_storage_map_info *info,
-				 struct bpf_sk_storage_elem *prev_selem)
+				 struct bpf_local_storage_elem *prev_selem)
 {
-	struct bpf_sk_storage *sk_storage;
-	struct bpf_sk_storage_elem *selem;
+	struct bpf_local_storage *sk_storage;
+	struct bpf_local_storage_elem *selem;
 	u32 skip_elems = info->skip_elems;
-	struct bpf_sk_storage_map *smap;
+	struct bpf_local_storage_map *smap;
 	u32 bucket_id = info->bucket_id;
 	u32 i, count, n_buckets;
-	struct bucket *b;
+	struct bpf_local_storage_map_bucket *b;
 
-	smap = (struct bpf_sk_storage_map *)info->map;
+	smap = (struct bpf_local_storage_map *)info->map;
 	n_buckets = 1U << smap->bucket_log;
 	if (bucket_id >= n_buckets)
 		return NULL;
@@ -1257,7 +1269,7 @@ bpf_sk_storage_map_seq_find_next(struct bpf_iter_seq_sk_storage_map_info *info,
 	count = 0;
 	while (selem) {
 		selem = hlist_entry_safe(selem->map_node.next,
-					 struct bpf_sk_storage_elem, map_node);
+					 struct bpf_local_storage_elem, map_node);
 		if (!selem) {
 			/* not found, unlock and go to the next bucket */
 			b = &smap->buckets[bucket_id++];
@@ -1265,7 +1277,7 @@ bpf_sk_storage_map_seq_find_next(struct bpf_iter_seq_sk_storage_map_info *info,
 			skip_elems = 0;
 			break;
 		}
-		sk_storage = rcu_dereference_raw(selem->sk_storage);
+		sk_storage = rcu_dereference_raw(selem->local_storage);
 		if (sk_storage) {
 			info->skip_elems = skip_elems + count;
 			return selem;
@@ -1278,7 +1290,7 @@ bpf_sk_storage_map_seq_find_next(struct bpf_iter_seq_sk_storage_map_info *info,
 		raw_spin_lock_bh(&b->lock);
 		count = 0;
 		hlist_for_each_entry(selem, &b->list, map_node) {
-			sk_storage = rcu_dereference_raw(selem->sk_storage);
+			sk_storage = rcu_dereference_raw(selem->local_storage);
 			if (sk_storage && count >= skip_elems) {
 				info->bucket_id = i;
 				info->skip_elems = count;
@@ -1297,7 +1309,7 @@ bpf_sk_storage_map_seq_find_next(struct bpf_iter_seq_sk_storage_map_info *info,
 
 static void *bpf_sk_storage_map_seq_start(struct seq_file *seq, loff_t *pos)
 {
-	struct bpf_sk_storage_elem *selem;
+	struct bpf_local_storage_elem *selem;
 
 	selem = bpf_sk_storage_map_seq_find_next(seq->private, NULL);
 	if (!selem)
@@ -1330,11 +1342,11 @@ DEFINE_BPF_ITER_FUNC(bpf_sk_storage_map, struct bpf_iter_meta *meta,
 		     void *value)
 
 static int __bpf_sk_storage_map_seq_show(struct seq_file *seq,
-					 struct bpf_sk_storage_elem *selem)
+					 struct bpf_local_storage_elem *selem)
 {
 	struct bpf_iter_seq_sk_storage_map_info *info = seq->private;
 	struct bpf_iter__bpf_sk_storage_map ctx = {};
-	struct bpf_sk_storage *sk_storage;
+	struct bpf_local_storage *sk_storage;
 	struct bpf_iter_meta meta;
 	struct bpf_prog *prog;
 	int ret = 0;
@@ -1345,8 +1357,8 @@ static int __bpf_sk_storage_map_seq_show(struct seq_file *seq,
 		ctx.meta = &meta;
 		ctx.map = info->map;
 		if (selem) {
-			sk_storage = rcu_dereference_raw(selem->sk_storage);
-			ctx.sk = sk_storage->sk;
+			sk_storage = rcu_dereference_raw(selem->local_storage);
+			ctx.sk = sk_storage->owner;
 			ctx.value = SDATA(selem)->data;
 		}
 		ret = bpf_iter_run_prog(prog, &ctx);
@@ -1363,13 +1375,13 @@ static int bpf_sk_storage_map_seq_show(struct seq_file *seq, void *v)
 static void bpf_sk_storage_map_seq_stop(struct seq_file *seq, void *v)
 {
 	struct bpf_iter_seq_sk_storage_map_info *info = seq->private;
-	struct bpf_sk_storage_map *smap;
-	struct bucket *b;
+	struct bpf_local_storage_map *smap;
+	struct bpf_local_storage_map_bucket *b;
 
 	if (!v) {
 		(void)__bpf_sk_storage_map_seq_show(seq, v);
 	} else {
-		smap = (struct bpf_sk_storage_map *)info->map;
+		smap = (struct bpf_local_storage_map *)info->map;
 		b = &smap->buckets[info->bucket_id];
 		raw_spin_unlock_bh(&b->lock);
 	}
-- 
2.28.0.297.g1956fa8f8d-goog

