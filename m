Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72B09229E3C
	for <lists+bpf@lfdr.de>; Wed, 22 Jul 2020 19:17:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728534AbgGVROt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Jul 2020 13:14:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731668AbgGVROW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Jul 2020 13:14:22 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D55AEC0619E5
        for <bpf@vger.kernel.org>; Wed, 22 Jul 2020 10:14:19 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id 9so2581150wmj.5
        for <bpf@vger.kernel.org>; Wed, 22 Jul 2020 10:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3UQtWh3k3Y2CpUXihFlt8XRhsqrKhUPFLvPN2vB6gXE=;
        b=HE+O5/1E+KS5N0Dn97Rqh0+ILkCVH8F2Wr5hbotnHVaZqLTG4eaIYkKmwpRm0jqvfG
         bMXgIqCHdtPEU2TSSNwMzO/OUNk9uKigJsinAb8fUtcAwwI7HBkbdwC8hL7ACjpeb4NK
         yQS959NCgFIHmebY6Hulilif+WvCTIbpJbsHM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3UQtWh3k3Y2CpUXihFlt8XRhsqrKhUPFLvPN2vB6gXE=;
        b=pk9LRAXzTEjRyzFXoVoO9P8OuGSb/HJC6zthZTxLh30aGM3DRcRXNy8Mj3p219H8z6
         ElYkBTKplJZmRHvCYxcfrEBeOorrD85VXSJebyrxJotPCf/hHMLWb2lYE7FELp+Gitet
         YU3nCEBRjpERtKPouhqamx2oB4c5WLoSXEozKyv1sgD5h/jKu0ylWmAXVhUz9PhZ5x8l
         bMm7rdfFRhwEAMyjv7Dy4RYgBDjP5HGjjSjb/Z7sb2uzMI5X0ARcGPZRIgJKlU+HcTN/
         w35w0rOImebI/PoHGmPj5fq7gckmsGegfCLUHqYG4KTrFYz9r+I1AU7wkZVEQ4+IwuPv
         Vdpg==
X-Gm-Message-State: AOAM532Dh0EmDInwjztPTh7AX+v8zkR74esOXVQ8Hud8hJBj+LgsmXru
        UL+qsuFGQBEa1VRH7drwo4cuoA==
X-Google-Smtp-Source: ABdhPJySBOCir/8F/cr0zXPvo7Iqn9Io1GsHguBI7zoGr98N92RIRBuRM/MkhiAYfvFPlcELJhwcmg==
X-Received: by 2002:a1c:2485:: with SMTP id k127mr564406wmk.138.1595438058289;
        Wed, 22 Jul 2020 10:14:18 -0700 (PDT)
Received: from kpsingh.zrh.corp.google.com ([81.6.44.51])
        by smtp.gmail.com with ESMTPSA id 26sm349214wmj.25.2020.07.22.10.14.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2020 10:14:17 -0700 (PDT)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>
Subject: [PATCH bpf-next v5 3/7] bpf: Generalize bpf_sk_storage
Date:   Wed, 22 Jul 2020 19:14:05 +0200
Message-Id: <20200722171409.102949-4-kpsingh@chromium.org>
X-Mailer: git-send-email 2.28.0.rc0.105.gf9edc3c819-goog
In-Reply-To: <20200722171409.102949-1-kpsingh@chromium.org>
References: <20200722171409.102949-1-kpsingh@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: KP Singh <kpsingh@google.com>

Refactor the functionality in bpf_sk_storage.c so that concept of
storage linked to kernel objects can be extended to other objects like
inode, task_struct etc.

Each new local storage will still be a separate map and provide its own
set of helpers. This allows for future object specific extensions and
still share a lot of the underlying implementation.

Signed-off-by: KP Singh <kpsingh@google.com>
---
 include/linux/bpf.h            |  13 ++
 include/net/bpf_sk_storage.h   |  55 +++++
 include/uapi/linux/bpf.h       |   8 +-
 net/core/bpf_sk_storage.c      | 387 ++++++++++++++++++++-------------
 tools/include/uapi/linux/bpf.h |   8 +-
 5 files changed, 320 insertions(+), 151 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index bae557ff2da8..9b83665b56e4 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -33,6 +33,9 @@ struct btf;
 struct btf_type;
 struct exception_table_entry;
 struct seq_operations;
+struct bpf_local_storage;
+struct bpf_local_storage_map;
+struct bpf_local_storage_elem;
 
 extern struct idr btf_idr;
 extern spinlock_t btf_idr_lock;
@@ -93,6 +96,16 @@ struct bpf_map_ops {
 	__poll_t (*map_poll)(struct bpf_map *map, struct file *filp,
 			     struct poll_table_struct *pts);
 
+	/* Functions called by bpf_local_storage maps */
+	bool (*map_local_storage_unlink)(struct bpf_local_storage *local_storage,
+					 struct bpf_local_storage_elem *selem,
+					 bool uncharge_omem);
+	struct bpf_local_storage_elem *(*map_selem_alloc)(
+		struct bpf_local_storage_map *smap, void *owner, void *value,
+		bool charge_omem);
+	struct bpf_local_storage_data *(*map_local_storage_update)(
+		void  *owner, struct bpf_map *map, void *value, u64 flags);
+
 	/* BTF name and id of struct allocated by map_alloc */
 	const char * const map_btf_name;
 	int *map_btf_id;
diff --git a/include/net/bpf_sk_storage.h b/include/net/bpf_sk_storage.h
index 950c5aaba15e..e3185cfb91da 100644
--- a/include/net/bpf_sk_storage.h
+++ b/include/net/bpf_sk_storage.h
@@ -3,8 +3,15 @@
 #ifndef _BPF_SK_STORAGE_H
 #define _BPF_SK_STORAGE_H
 
+#include <linux/rculist.h>
+#include <linux/list.h>
+#include <linux/hash.h>
 #include <linux/types.h>
 #include <linux/spinlock.h>
+#include <linux/bpf.h>
+#include <net/sock.h>
+#include <uapi/linux/sock_diag.h>
+#include <uapi/linux/btf.h>
 
 struct sock;
 
@@ -34,6 +41,54 @@ u16 bpf_local_storage_cache_idx_get(struct bpf_local_storage_cache *cache);
 void bpf_local_storage_cache_idx_free(struct bpf_local_storage_cache *cache,
 				      u16 idx);
 
+/* Helper functions for bpf_local_storage */
+int bpf_local_storage_map_alloc_check(union bpf_attr *attr);
+
+struct bpf_local_storage_map *bpf_local_storage_map_alloc(union bpf_attr *attr);
+
+struct bpf_local_storage_data *
+bpf_local_storage_lookup(struct bpf_local_storage *local_storage,
+			 struct bpf_local_storage_map *smap,
+			 bool cacheit_lockit);
+
+void bpf_local_storage_map_free(struct bpf_local_storage_map *smap);
+
+int bpf_local_storage_map_check_btf(const struct bpf_map *map,
+				    const struct btf *btf,
+				    const struct btf_type *key_type,
+				    const struct btf_type *value_type);
+
+void bpf_selem_link_storage(struct bpf_local_storage *local_storage,
+			    struct bpf_local_storage_elem *selem);
+
+bool bpf_selem_unlink_storage(struct bpf_local_storage *local_storage,
+			      struct bpf_local_storage_elem *selem,
+			      bool uncharge_omem);
+
+void bpf_selem_unlink(struct bpf_local_storage_elem *selem);
+
+void bpf_selem_link_map(struct bpf_local_storage_map *smap,
+			struct bpf_local_storage_elem *selem);
+
+void bpf_selem_unlink_map(struct bpf_local_storage_elem *selem);
+
+struct bpf_local_storage_elem *
+bpf_selem_alloc(struct bpf_local_storage_map *smap, void *value);
+
+struct bpf_local_storage *
+bpf_local_storage_alloc(struct bpf_local_storage_map *smap);
+
+int bpf_local_storage_publish(struct bpf_local_storage_elem *first_selem,
+			      struct bpf_local_storage **addr,
+			      struct bpf_local_storage *curr);
+
+int bpf_local_storage_check_update_flags(struct bpf_map *map, u64 map_flags);
+
+struct bpf_local_storage_data *
+bpf_local_storage_update(void *owner, struct bpf_map *map,
+			 struct bpf_local_storage *local_storage, void *value,
+			 u64 map_flags);
+
 #ifdef CONFIG_BPF_SYSCALL
 int bpf_sk_storage_clone(const struct sock *sk, struct sock *newsk);
 struct bpf_sk_storage_diag *
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 54d0c886e3ba..b9d2e4792d08 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -3630,9 +3630,13 @@ enum {
 	BPF_F_SYSCTL_BASE_NAME		= (1ULL << 0),
 };
 
-/* BPF_FUNC_sk_storage_get flags */
+/* BPF_FUNC_<local>_storage_get flags */
 enum {
-	BPF_SK_STORAGE_GET_F_CREATE	= (1ULL << 0),
+	BPF_LOCAL_STORAGE_GET_F_CREATE	= (1ULL << 0),
+	/* BPF_SK_STORAGE_GET_F_CREATE is only kept for backward compatibility
+	 * and BPF_LOCAL_STORAGE_GET_F_CREATE must be used instead.
+	 */
+	BPF_SK_STORAGE_GET_F_CREATE  = BPF_LOCAL_STORAGE_GET_F_CREATE,
 };
 
 /* BPF_FUNC_read_branch_records flags. */
diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
index aa3e3a47acb5..f6bb02f076ad 100644
--- a/net/core/bpf_sk_storage.c
+++ b/net/core/bpf_sk_storage.c
@@ -83,7 +83,7 @@ struct bpf_local_storage_elem {
 struct bpf_local_storage {
 	struct bpf_local_storage_data __rcu *cache[BPF_LOCAL_STORAGE_CACHE_SIZE];
 	struct hlist_head list; /* List of bpf_local_storage_elem */
-	struct sock *owner;	/* The object that owns the the above "list" of
+	void *owner;		/* The object that owns the the above "list" of
 				 * bpf_local_storage_elem.
 				 */
 	struct rcu_head rcu;
@@ -119,15 +119,11 @@ static bool selem_linked_to_map(const struct bpf_local_storage_elem *selem)
 	return !hlist_unhashed(&selem->map_node);
 }
 
-static struct bpf_local_storage_elem *
-bpf_selem_alloc(struct bpf_local_storage_map *smap, struct sock *sk,
-		void *value, bool charge_omem)
+struct bpf_local_storage_elem *
+bpf_selem_alloc(struct bpf_local_storage_map *smap, void *value)
 {
 	struct bpf_local_storage_elem *selem;
 
-	if (charge_omem && omem_charge(sk, smap->elem_size))
-		return NULL;
-
 	selem = kzalloc(smap->elem_size, GFP_ATOMIC | __GFP_NOWARN);
 	if (selem) {
 		if (value)
@@ -135,6 +131,23 @@ bpf_selem_alloc(struct bpf_local_storage_map *smap, struct sock *sk,
 		return selem;
 	}
 
+	return NULL;
+}
+
+static struct bpf_local_storage_elem *
+sk_selem_alloc(struct bpf_local_storage_map *smap, void *owner, void *value,
+	       bool charge_omem)
+{
+	struct bpf_local_storage_elem *selem;
+	struct sock *sk = owner;
+
+	if (charge_omem && omem_charge(sk, smap->elem_size))
+		return NULL;
+
+	selem = bpf_selem_alloc(smap, value);
+	if (selem)
+		return selem;
+
 	if (charge_omem)
 		atomic_sub(smap->elem_size, &sk->sk_omem_alloc);
 
@@ -145,51 +158,65 @@ bpf_selem_alloc(struct bpf_local_storage_map *smap, struct sock *sk,
  * The caller must ensure selem->smap is still valid to be
  * dereferenced for its smap->elem_size and smap->cache_idx.
  */
-static bool bpf_selem_unlink_storage(struct bpf_local_storage *local_storage,
-				     struct bpf_local_storage_elem *selem,
-				     bool uncharge_omem)
+bool bpf_selem_unlink_storage(struct bpf_local_storage *local_storage,
+			      struct bpf_local_storage_elem *selem,
+			      bool uncharge_omem)
 {
 	struct bpf_local_storage_map *smap;
 	bool free_local_storage;
-	struct sock *sk;
 
 	smap = rcu_dereference(SDATA(selem)->smap);
-	sk = local_storage->owner;
+	/* local_storage is not freed now. local_storage->lock is
+	 * still held and raw_spin_unlock_bh(&local_storage->lock)
+	 * will be done by the caller.
+	 * Although the unlock will be done under
+	 * rcu_read_lock(),  it is more intutivie to
+	 * read if kfree_rcu(local_storage, rcu) is done
+	 * after the raw_spin_unlock_bh(&local_storage->lock).
+	 *
+	 * Hence, a "bool free_local_storage" is returned
+	 * to the caller which then calls the kfree_rcu()
+	 * after unlock.
+	 */
+	free_local_storage = smap->map.ops->map_local_storage_unlink(
+		local_storage, selem, uncharge_omem);
+	hlist_del_init_rcu(&selem->snode);
+	if (rcu_access_pointer(local_storage->cache[smap->cache_idx]) ==
+	    SDATA(selem))
+		RCU_INIT_POINTER(local_storage->cache[smap->cache_idx], NULL);
+
+	kfree_rcu(selem, rcu);
+
+	return free_local_storage;
+}
 
+static bool unlink_sk_storage(struct bpf_local_storage *local_storage,
+			      struct bpf_local_storage_elem *selem,
+			      bool uncharge_omem)
+{
+	struct bpf_local_storage_map *smap;
+	struct sock *sk = local_storage->owner;
+	bool free_local_storage;
+
+	smap = rcu_dereference(SDATA(selem)->smap);
 	/* All uncharging on sk->sk_omem_alloc must be done first.
 	 * sk may be freed once the last selem is unlinked from local_storage.
 	 */
-	if (uncharge_omem)
-		atomic_sub(smap->elem_size, &sk->sk_omem_alloc);
 
 	free_local_storage = hlist_is_singular_node(&selem->snode,
 						    &local_storage->list);
+
+	if (uncharge_omem)
+		atomic_sub(smap->elem_size, &sk->sk_omem_alloc);
+
 	if (free_local_storage) {
-		atomic_sub(sizeof(struct bpf_local_storage), &sk->sk_omem_alloc);
-		local_storage->owner = NULL;
+		atomic_sub(sizeof(struct bpf_local_storage),
+			   &sk->sk_omem_alloc);
+
 		/* After this RCU_INIT, sk may be freed and cannot be used */
 		RCU_INIT_POINTER(sk->sk_bpf_storage, NULL);
-
-		/* local_storage is not freed now.  local_storage->lock is
-		 * still held and raw_spin_unlock_bh(&local_storage->lock)
-		 * will be done by the caller.
-		 *
-		 * Although the unlock will be done under
-		 * rcu_read_lock(),  it is more intutivie to
-		 * read if kfree_rcu(local_storage, rcu) is done
-		 * after the raw_spin_unlock_bh(&local_storage->lock).
-		 *
-		 * Hence, a "bool free_local_storage" is returned
-		 * to the caller which then calls the kfree_rcu()
-		 * after unlock.
-		 */
+		local_storage->owner = NULL;
 	}
-	hlist_del_init_rcu(&selem->snode);
-	if (rcu_access_pointer(local_storage->cache[smap->cache_idx]) ==
-	    SDATA(selem))
-		RCU_INIT_POINTER(local_storage->cache[smap->cache_idx], NULL);
-
-	kfree_rcu(selem, rcu);
 
 	return free_local_storage;
 }
@@ -214,14 +241,14 @@ static void __bpf_selem_unlink_storage(struct bpf_local_storage_elem *selem)
 		kfree_rcu(local_storage, rcu);
 }
 
-static void bpf_selem_link_storage(struct bpf_local_storage *local_storage,
-				   struct bpf_local_storage_elem *selem)
+void bpf_selem_link_storage(struct bpf_local_storage *local_storage,
+			    struct bpf_local_storage_elem *selem)
 {
 	RCU_INIT_POINTER(selem->local_storage, local_storage);
 	hlist_add_head(&selem->snode, &local_storage->list);
 }
 
-static void bpf_selem_unlink_map(struct bpf_local_storage_elem *selem)
+void bpf_selem_unlink_map(struct bpf_local_storage_elem *selem)
 {
 	struct bpf_local_storage_map *smap;
 	struct bpf_local_storage_map_bucket *b;
@@ -238,8 +265,8 @@ static void bpf_selem_unlink_map(struct bpf_local_storage_elem *selem)
 	raw_spin_unlock_bh(&b->lock);
 }
 
-static void bpf_selem_link_map(struct bpf_local_storage_map *smap,
-			       struct bpf_local_storage_elem *selem)
+void bpf_selem_link_map(struct bpf_local_storage_map *smap,
+			struct bpf_local_storage_elem *selem)
 {
 	struct bpf_local_storage_map_bucket *b = select_bucket(smap, selem);
 
@@ -249,7 +276,7 @@ static void bpf_selem_link_map(struct bpf_local_storage_map *smap,
 	raw_spin_unlock_bh(&b->lock);
 }
 
-static void bpf_selem_unlink(struct bpf_local_storage_elem *selem)
+void bpf_selem_unlink(struct bpf_local_storage_elem *selem)
 {
 	/* Always unlink from map before unlinking from local_storage
 	 * because selem will be freed after successfully unlinked from
@@ -259,7 +286,7 @@ static void bpf_selem_unlink(struct bpf_local_storage_elem *selem)
 	__bpf_selem_unlink_storage(selem);
 }
 
-static struct bpf_local_storage_data *
+struct bpf_local_storage_data *
 bpf_local_storage_lookup(struct bpf_local_storage *local_storage,
 			 struct bpf_local_storage_map *smap,
 			 bool cacheit_lockit)
@@ -325,59 +352,53 @@ static int check_flags(const struct bpf_local_storage_data *old_sdata,
 	return 0;
 }
 
-static int sk_storage_alloc(struct sock *sk,
+struct bpf_local_storage *
+bpf_local_storage_alloc(struct bpf_local_storage_map *smap)
+{
+	struct bpf_local_storage *storage;
+
+	storage = kzalloc(sizeof(*storage), GFP_ATOMIC | __GFP_NOWARN);
+	if (!storage)
+		return NULL;
+
+	INIT_HLIST_HEAD(&storage->list);
+	raw_spin_lock_init(&storage->lock);
+	return storage;
+}
+
+static int sk_storage_alloc(void *owner,
 			    struct bpf_local_storage_map *smap,
 			    struct bpf_local_storage_elem *first_selem)
 {
-	struct bpf_local_storage *prev_sk_storage, *sk_storage;
+	struct bpf_local_storage *curr;
+	struct sock *sk = owner;
 	int err;
 
-	err = omem_charge(sk, sizeof(*sk_storage));
+	err = omem_charge(sk, sizeof(*curr));
 	if (err)
 		return err;
 
-	sk_storage = kzalloc(sizeof(*sk_storage), GFP_ATOMIC | __GFP_NOWARN);
-	if (!sk_storage) {
+	curr = bpf_local_storage_alloc(smap);
+	if (!curr) {
 		err = -ENOMEM;
 		goto uncharge;
 	}
-	INIT_HLIST_HEAD(&sk_storage->list);
-	raw_spin_lock_init(&sk_storage->lock);
-	sk_storage->owner = sk;
 
-	bpf_selem_link_storage(sk_storage, first_selem);
+	curr->owner = sk;
+
+	bpf_selem_link_storage(curr, first_selem);
 	bpf_selem_link_map(smap, first_selem);
-	/* Publish sk_storage to sk.  sk->sk_lock cannot be acquired.
-	 * Hence, atomic ops is used to set sk->sk_bpf_storage
-	 * from NULL to the newly allocated sk_storage ptr.
-	 *
-	 * From now on, the sk->sk_bpf_storage pointer is protected
-	 * by the sk_storage->lock.  Hence,  when freeing
-	 * the sk->sk_bpf_storage, the sk_storage->lock must
-	 * be held before setting sk->sk_bpf_storage to NULL.
-	 */
-	prev_sk_storage = cmpxchg((struct bpf_local_storage **)&sk->sk_bpf_storage,
-				  NULL, sk_storage);
-	if (unlikely(prev_sk_storage)) {
-		bpf_selem_unlink_map(first_selem);
-		err = -EAGAIN;
-		goto uncharge;
 
-		/* Note that even first_selem was linked to smap's
-		 * bucket->list, first_selem can be freed immediately
-		 * (instead of kfree_rcu) because
-		 * bpf_sk_storage_map_free() does a
-		 * synchronize_rcu() before walking the bucket->list.
-		 * Hence, no one is accessing selem from the
-		 * bucket->list under rcu_read_lock().
-		 */
-	}
+	err = bpf_local_storage_publish(first_selem,
+		(struct bpf_local_storage **)&sk->sk_bpf_storage, curr);
+	if (err)
+		goto uncharge;
 
 	return 0;
 
 uncharge:
-	kfree(sk_storage);
-	atomic_sub(sizeof(*sk_storage), &sk->sk_omem_alloc);
+	kfree(curr);
+	atomic_sub(sizeof(*curr), &sk->sk_omem_alloc);
 	return err;
 }
 
@@ -386,54 +407,28 @@ static int sk_storage_alloc(struct sock *sk,
  * Otherwise, it will become a leak (and other memory issues
  * during map destruction).
  */
-static struct bpf_local_storage_data *
-bpf_local_storage_update(struct sock *sk, struct bpf_map *map, void *value,
+struct bpf_local_storage_data *
+bpf_local_storage_update(void *owner, struct bpf_map *map,
+			 struct bpf_local_storage *local_storage, void *value,
 			 u64 map_flags)
 {
 	struct bpf_local_storage_data *old_sdata = NULL;
 	struct bpf_local_storage_elem *selem;
-	struct bpf_local_storage *local_storage;
 	struct bpf_local_storage_map *smap;
 	int err;
 
-	/* BPF_EXIST and BPF_NOEXIST cannot be both set */
-	if (unlikely((map_flags & ~BPF_F_LOCK) > BPF_EXIST) ||
-	    /* BPF_F_LOCK can only be used in a value with spin_lock */
-	    unlikely((map_flags & BPF_F_LOCK) && !map_value_has_spin_lock(map)))
-		return ERR_PTR(-EINVAL);
-
 	smap = (struct bpf_local_storage_map *)map;
-	local_storage = rcu_dereference(sk->sk_bpf_storage);
-	if (!local_storage || hlist_empty(&local_storage->list)) {
-		/* Very first elem for this object */
-		err = check_flags(NULL, map_flags);
-		if (err)
-			return ERR_PTR(err);
-
-		selem = bpf_selem_alloc(smap, sk, value, true);
-		if (!selem)
-			return ERR_PTR(-ENOMEM);
-
-		err = sk_storage_alloc(sk, smap, selem);
-		if (err) {
-			kfree(selem);
-			atomic_sub(smap->elem_size, &sk->sk_omem_alloc);
-			return ERR_PTR(err);
-		}
-
-		return SDATA(selem);
-	}
 
 	if ((map_flags & BPF_F_LOCK) && !(map_flags & BPF_NOEXIST)) {
 		/* Hoping to find an old_sdata to do inline update
 		 * such that it can avoid taking the local_storage->lock
 		 * and changing the lists.
 		 */
-		old_sdata =
-			bpf_local_storage_lookup(local_storage, smap, false);
+		old_sdata = bpf_local_storage_lookup(local_storage, smap, false);
 		err = check_flags(old_sdata, map_flags);
 		if (err)
 			return ERR_PTR(err);
+
 		if (old_sdata && selem_linked_to_storage(SELEM(old_sdata))) {
 			copy_map_value_locked(map, old_sdata->data,
 					      value, false);
@@ -471,10 +466,9 @@ bpf_local_storage_update(struct sock *sk, struct bpf_map *map, void *value,
 	 * and then uncharge the old selem later (which may cause
 	 * a potential but unnecessary charge failure),  avoid taking
 	 * a charge at all here (the "!old_sdata" check) and the
-	 * old_sdata will not be uncharged later during
-	 * bpf_selem_unlink_storage().
+	 * old_sdata will not be uncharged later during bpf_selem_unlink().
 	 */
-	selem = bpf_selem_alloc(smap, sk, value, !old_sdata);
+	selem = map->ops->map_selem_alloc(smap, owner, value, !old_sdata);
 	if (!selem) {
 		err = -ENOMEM;
 		goto unlock_err;
@@ -501,6 +495,87 @@ bpf_local_storage_update(struct sock *sk, struct bpf_map *map, void *value,
 	return ERR_PTR(err);
 }
 
+int bpf_local_storage_check_update_flags(struct bpf_map *map, u64 map_flags)
+{
+	/* BPF_EXIST and BPF_NOEXIST cannot be both set */
+	if (unlikely((map_flags & ~BPF_F_LOCK) > BPF_EXIST) ||
+	    /* BPF_F_LOCK can only be used in a value with spin_lock */
+	    unlikely((map_flags & BPF_F_LOCK) && !map_value_has_spin_lock(map)))
+		return -EINVAL;
+
+	return 0;
+}
+
+/* Publish local_storage to the address.  This is used because we are already
+ * in a region where we cannot grab a lock on the object owning the storage (
+ * (e.g sk->sk_lock). Hence, atomic ops is used.
+ *
+ * From now on, the addr pointer is protected
+ * by the local_storage->lock.  Hence, upon freeing,
+ * the local_storage->lock must be held before unlinking the storage from the
+ * owner.
+ */
+int bpf_local_storage_publish(struct bpf_local_storage_elem *first_selem,
+			      struct bpf_local_storage **addr,
+			      struct bpf_local_storage *curr)
+{
+	struct bpf_local_storage *prev;
+
+	prev = cmpxchg(addr, NULL, curr);
+	if (unlikely(prev)) {
+		/* Note that even first_selem was linked to smap's
+		 * bucket->list, first_selem can be freed immediately
+		 * (instead of kfree_rcu) because
+		 * bpf_local_storage_map_free() does a
+		 * synchronize_rcu() before walking the bucket->list.
+		 * Hence, no one is accessing selem from the
+		 * bucket->list under rcu_read_lock().
+		 */
+		bpf_selem_unlink_map(first_selem);
+		return -EAGAIN;
+	}
+
+	return 0;
+}
+
+static struct bpf_local_storage_data *
+sk_storage_update(void *owner, struct bpf_map *map, void *value, u64 map_flags)
+{
+	struct bpf_local_storage_data *old_sdata = NULL;
+	struct bpf_local_storage_elem *selem;
+	struct bpf_local_storage *local_storage;
+	struct bpf_local_storage_map *smap;
+	struct sock *sk;
+	int err;
+
+	err = bpf_local_storage_check_update_flags(map, map_flags);
+	if (err)
+		return ERR_PTR(err);
+
+	sk = owner;
+	local_storage = rcu_dereference(sk->sk_bpf_storage);
+	smap = (struct bpf_local_storage_map *)map;
+
+	if (!local_storage || hlist_empty(&local_storage->list)) {
+		/* Very first elem */
+		selem = map->ops->map_selem_alloc(smap, owner, value, !old_sdata);
+		if (!selem)
+			return ERR_PTR(-ENOMEM);
+
+		err = sk_storage_alloc(owner, smap, selem);
+		if (err) {
+			kfree(selem);
+			atomic_sub(smap->elem_size, &sk->sk_omem_alloc);
+			return ERR_PTR(err);
+		}
+
+		return SDATA(selem);
+	}
+
+	return bpf_local_storage_update(owner, map, local_storage, value,
+					map_flags);
+}
+
 static int sk_storage_delete(struct sock *sk, struct bpf_map *map)
 {
 	struct bpf_local_storage_data *sdata;
@@ -566,7 +641,7 @@ void bpf_sk_storage_free(struct sock *sk)
 	 * Thus, no elem can be added-to or deleted-from the
 	 * sk_storage->list by the bpf_prog or by the bpf-map's syscall.
 	 *
-	 * It is racing with bpf_sk_storage_map_free() alone
+	 * It is racing with bpf_local_storage_map_free() alone
 	 * when unlinking elem from the sk_storage->list and
 	 * the map's bucket->list.
 	 */
@@ -586,17 +661,12 @@ void bpf_sk_storage_free(struct sock *sk)
 		kfree_rcu(sk_storage, rcu);
 }
 
-static void bpf_local_storage_map_free(struct bpf_map *map)
+void bpf_local_storage_map_free(struct bpf_local_storage_map *smap)
 {
 	struct bpf_local_storage_elem *selem;
-	struct bpf_local_storage_map *smap;
 	struct bpf_local_storage_map_bucket *b;
 	unsigned int i;
 
-	smap = (struct bpf_local_storage_map *)map;
-
-	bpf_local_storage_cache_idx_free(&sk_cache, smap->cache_idx);
-
 	/* Note that this map might be concurrently cloned from
 	 * bpf_sk_storage_clone. Wait for any existing bpf_sk_storage_clone
 	 * RCU read section to finish before proceeding. New RCU
@@ -606,42 +676,51 @@ static void bpf_local_storage_map_free(struct bpf_map *map)
 
 	/* bpf prog and the userspace can no longer access this map
 	 * now.  No new selem (of this map) can be added
-	 * to the sk->sk_bpf_storage or to the map bucket's list.
+	 * to the bpf_local_storage or to the map bucket's list.
 	 *
 	 * The elem of this map can be cleaned up here
-	 * or
-	 * by bpf_sk_storage_free() during __sk_destruct().
+	 * or by bpf_local_storage_free() during the destruction of the
+	 * owner object. eg. __sk_destruct.
 	 */
 	for (i = 0; i < (1U << smap->bucket_log); i++) {
 		b = &smap->buckets[i];
 
 		rcu_read_lock();
 		/* No one is adding to b->list now */
-		while ((selem = hlist_entry_safe(
-				rcu_dereference_raw(hlist_first_rcu(&b->list)),
-				struct bpf_local_storage_elem, map_node))) {
+		while ((selem = hlist_entry_safe(rcu_dereference_raw(hlist_first_rcu(&b->list)),
+						 struct bpf_local_storage_elem,
+						 map_node))) {
 			bpf_selem_unlink(selem);
 			cond_resched_rcu();
 		}
 		rcu_read_unlock();
 	}
 
-	/* bpf_sk_storage_free() may still need to access the map.
-	 * e.g. bpf_sk_storage_free() has unlinked selem from the map
+	/* bpf_local_storage_free() may still need to access the map.
+	 * e.g. bpf_local_storage_free() has unlinked selem from the map
 	 * which then made the above while((selem = ...)) loop
 	 * exited immediately.
 	 *
-	 * However, the bpf_sk_storage_free() still needs to access
+	 * However, the bpf_local_storage_free() still needs to access
 	 * the smap->elem_size to do the uncharging in
-	 * bpf_selem_unlink_storage().
+	 * bpf_selem_unlink().
 	 *
 	 * Hence, wait another rcu grace period for the
-	 * bpf_sk_storage_free() to finish.
+	 * bpf_local_storage_free() to finish.
 	 */
 	synchronize_rcu();
 
 	kvfree(smap->buckets);
-	kfree(map);
+	kfree(smap);
+}
+
+static void sk_storage_map_free(struct bpf_map *map)
+{
+	struct bpf_local_storage_map *smap;
+
+	smap = (struct bpf_local_storage_map *)map;
+	bpf_local_storage_cache_idx_free(&sk_cache, smap->cache_idx);
+	bpf_local_storage_map_free(smap);
 }
 
 /* U16_MAX is much more than enough for sk local storage
@@ -653,7 +732,7 @@ static void bpf_local_storage_map_free(struct bpf_map *map)
 	       sizeof(struct bpf_local_storage_elem)),			\
 	      (U16_MAX - sizeof(struct bpf_local_storage_elem)))
 
-static int bpf_sk_storage_map_alloc_check(union bpf_attr *attr)
+int bpf_local_storage_map_alloc_check(union bpf_attr *attr)
 {
 	if (attr->map_flags & ~BPF_LOCAL_STORAGE_CREATE_FLAG_MASK ||
 	    !(attr->map_flags & BPF_F_NO_PREALLOC) ||
@@ -672,7 +751,7 @@ static int bpf_sk_storage_map_alloc_check(union bpf_attr *attr)
 	return 0;
 }
 
-static struct bpf_map *bpf_local_storage_map_alloc(union bpf_attr *attr)
+struct bpf_local_storage_map *bpf_local_storage_map_alloc(union bpf_attr *attr)
 {
 	struct bpf_local_storage_map *smap;
 	unsigned int i;
@@ -710,9 +789,21 @@ static struct bpf_map *bpf_local_storage_map_alloc(union bpf_attr *attr)
 		raw_spin_lock_init(&smap->buckets[i].lock);
 	}
 
-	smap->elem_size = sizeof(struct bpf_local_storage_elem) + attr->value_size;
-	smap->cache_idx = bpf_local_storage_cache_idx_get(&sk_cache);
+	smap->elem_size =
+		sizeof(struct bpf_local_storage_elem) + attr->value_size;
+
+	return smap;
+}
 
+static struct bpf_map *sk_storage_map_alloc(union bpf_attr *attr)
+{
+	struct bpf_local_storage_map *smap;
+
+	smap = bpf_local_storage_map_alloc(attr);
+	if (IS_ERR(smap))
+		return ERR_CAST(smap);
+
+	smap->cache_idx = bpf_local_storage_cache_idx_get(&sk_cache);
 	return &smap->map;
 }
 
@@ -722,10 +813,10 @@ static int notsupp_get_next_key(struct bpf_map *map, void *key,
 	return -ENOTSUPP;
 }
 
-static int bpf_sk_storage_map_check_btf(const struct bpf_map *map,
-					const struct btf *btf,
-					const struct btf_type *key_type,
-					const struct btf_type *value_type)
+int bpf_local_storage_map_check_btf(const struct bpf_map *map,
+				    const struct btf *btf,
+				    const struct btf_type *key_type,
+				    const struct btf_type *value_type)
 {
 	u32 int_data;
 
@@ -766,8 +857,7 @@ static int bpf_fd_sk_storage_update_elem(struct bpf_map *map, void *key,
 	fd = *(int *)key;
 	sock = sockfd_lookup(fd, &err);
 	if (sock) {
-		sdata = bpf_local_storage_update(sock->sk, map, value,
-						 map_flags);
+		sdata = sk_storage_update(sock->sk, map, value, map_flags);
 		sockfd_put(sock);
 		return PTR_ERR_OR_ZERO(sdata);
 	}
@@ -798,7 +888,7 @@ bpf_sk_storage_clone_elem(struct sock *newsk,
 {
 	struct bpf_local_storage_elem *copy_selem;
 
-	copy_selem = bpf_selem_alloc(smap, newsk, NULL, true);
+	copy_selem = sk_selem_alloc(smap, newsk, NULL, true);
 	if (!copy_selem)
 		return NULL;
 
@@ -900,7 +990,7 @@ BPF_CALL_4(bpf_sk_storage_get, struct bpf_map *, map, struct sock *, sk,
 	     *  destruction).
 	     */
 	    refcount_inc_not_zero(&sk->sk_refcnt)) {
-		sdata = bpf_local_storage_update(sk, map, value, BPF_NOEXIST);
+		sdata = sk_storage_update(sk, map, value, BPF_NOEXIST);
 		/* sk must be a fullsock (guaranteed by verifier),
 		 * so sock_gen_put() is unnecessary.
 		 */
@@ -927,16 +1017,19 @@ BPF_CALL_2(bpf_sk_storage_delete, struct bpf_map *, map, struct sock *, sk)
 
 static int sk_storage_map_btf_id;
 const struct bpf_map_ops sk_storage_map_ops = {
-	.map_alloc_check = bpf_sk_storage_map_alloc_check,
-	.map_alloc = bpf_local_storage_map_alloc,
-	.map_free = bpf_local_storage_map_free,
+	.map_alloc_check = bpf_local_storage_map_alloc_check,
+	.map_alloc = sk_storage_map_alloc,
+	.map_free = sk_storage_map_free,
 	.map_get_next_key = notsupp_get_next_key,
 	.map_lookup_elem = bpf_fd_sk_storage_lookup_elem,
 	.map_update_elem = bpf_fd_sk_storage_update_elem,
 	.map_delete_elem = bpf_fd_sk_storage_delete_elem,
-	.map_check_btf = bpf_sk_storage_map_check_btf,
+	.map_check_btf = bpf_local_storage_map_check_btf,
 	.map_btf_name = "bpf_local_storage_map",
 	.map_btf_id = &sk_storage_map_btf_id,
+	.map_selem_alloc = sk_selem_alloc,
+	.map_local_storage_update = sk_storage_update,
+	.map_local_storage_unlink = unlink_sk_storage,
 };
 
 const struct bpf_func_proto bpf_sk_storage_get_proto = {
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 54d0c886e3ba..b9d2e4792d08 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -3630,9 +3630,13 @@ enum {
 	BPF_F_SYSCTL_BASE_NAME		= (1ULL << 0),
 };
 
-/* BPF_FUNC_sk_storage_get flags */
+/* BPF_FUNC_<local>_storage_get flags */
 enum {
-	BPF_SK_STORAGE_GET_F_CREATE	= (1ULL << 0),
+	BPF_LOCAL_STORAGE_GET_F_CREATE	= (1ULL << 0),
+	/* BPF_SK_STORAGE_GET_F_CREATE is only kept for backward compatibility
+	 * and BPF_LOCAL_STORAGE_GET_F_CREATE must be used instead.
+	 */
+	BPF_SK_STORAGE_GET_F_CREATE  = BPF_LOCAL_STORAGE_GET_F_CREATE,
 };
 
 /* BPF_FUNC_read_branch_records flags. */
-- 
2.28.0.rc0.105.gf9edc3c819-goog

