Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F211124EEE3
	for <lists+bpf@lfdr.de>; Sun, 23 Aug 2020 18:57:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727917AbgHWQ46 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 23 Aug 2020 12:56:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727882AbgHWQ4X (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 23 Aug 2020 12:56:23 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7779CC061797
        for <bpf@vger.kernel.org>; Sun, 23 Aug 2020 09:56:21 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id t14so6107240wmi.3
        for <bpf@vger.kernel.org>; Sun, 23 Aug 2020 09:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=euqN+KYJAMOG6hT3qLtYViNcLyk3nklZ1hmT4okBw6E=;
        b=dkcUq98yCf6Oyu8x6T0dTG99bQAVwawdgIJKAwQbeMtG2GqPHw3hR06UYgSkh37HJX
         Abgzj4hs2APorQzTbGKEYqxYAVOrDt9bWQkBsXCickIeDPGy34XoJ2j/D6PjLZrlTXgD
         3FDUC2XVHugvsN87pJeiJlnI+q3WTtBSsUUac=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=euqN+KYJAMOG6hT3qLtYViNcLyk3nklZ1hmT4okBw6E=;
        b=UgHUWsVvkS8TZCiKP/ROXmu2o4iVGlOwz7lb/oIyZa1K1GbA4yIJqrGJwSllhG2II4
         /2ViMQKCoaD/o/4q/3JJRjUVIXBIyX6MH9KCKVhhwplZMULnEYyeTPvypexiTiLusntj
         TBjBbPx9WoT3LPkrFfuYBIkpioDhKlii5Y+ubhVH2MdWLwuB25tMUvRlnG0hryhq2FHE
         IelBPb69C0jXyUVd+dSTW5N+roJl3Z6mJU1DUmE52GPA85dgbYrOQpzxKtYpaegT1lS2
         TZV5Q1DeTN4c4A/19JJYKc2FAux4Q/lTPLg915CQee3XJDEFIRcrIkJ36RM7iL76rSMW
         pdVg==
X-Gm-Message-State: AOAM531avf5nD55FfmxffKGZwnFbpFrkc/ccmgAT0RoGiA39yMYR5hMT
        sKTRELaXx3rbs57y8zLrWzmK/Q==
X-Google-Smtp-Source: ABdhPJwyEXrJ4CAeRLIt3fN0cPphsZR5uNmLX9R/cTehKilvru4AvtRw2S3UY19iWL6IVdUV5I/8rQ==
X-Received: by 2002:a05:600c:4150:: with SMTP id h16mr2107098wmm.127.1598201779864;
        Sun, 23 Aug 2020 09:56:19 -0700 (PDT)
Received: from kpsingh.zrh.corp.google.com ([81.6.44.51])
        by smtp.gmail.com with ESMTPSA id d10sm5425974wrg.3.2020.08.23.09.56.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2020 09:56:19 -0700 (PDT)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc:     Martin KaFai Lau <kafai@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>
Subject: [PATCH bpf-next v9 3/7] bpf: Generalize bpf_sk_storage
Date:   Sun, 23 Aug 2020 18:56:08 +0200
Message-Id: <20200823165612.404892-4-kpsingh@chromium.org>
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

Refactor the functionality in bpf_sk_storage.c so that concept of
storage linked to kernel objects can be extended to other objects like
inode, task_struct etc.

Each new local storage will still be a separate map and provide its own
set of helpers. This allows for future object specific extensions and
still share a lot of the underlying implementation.

This includes the changes suggested by Martin in:

  https://lore.kernel.org/bpf/20200725013047.4006241-1-kafai@fb.com/

adding new map operations to support bpf_local_storage maps:

* storages for different kernel objects to optionally have different
  memory charging strategy (map_local_storage_charge,
  map_local_storage_uncharge)
* Functionality to extract the storage pointer from a pointer to the
  owning object (map_owner_storage_ptr)

Co-developed-by: Martin KaFai Lau <kafai@fb.com>
Signed-off-by: KP Singh <kpsingh@google.com>
---
 include/linux/bpf.h            |   8 ++
 include/net/bpf_sk_storage.h   |  52 +++++++
 include/uapi/linux/bpf.h       |   8 +-
 net/core/bpf_sk_storage.c      | 238 +++++++++++++++++++++------------
 tools/include/uapi/linux/bpf.h |   8 +-
 5 files changed, 228 insertions(+), 86 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 81f38e2fda78..8c443b93ac11 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -34,6 +34,8 @@ struct btf_type;
 struct exception_table_entry;
 struct seq_operations;
 struct bpf_iter_aux_info;
+struct bpf_local_storage;
+struct bpf_local_storage_map;
 
 extern struct idr btf_idr;
 extern spinlock_t btf_idr_lock;
@@ -104,6 +106,12 @@ struct bpf_map_ops {
 	__poll_t (*map_poll)(struct bpf_map *map, struct file *filp,
 			     struct poll_table_struct *pts);
 
+	/* Functions called by bpf_local_storage maps */
+	int (*map_local_storage_charge)(struct bpf_local_storage_map *smap,
+					void *owner, u32 size);
+	void (*map_local_storage_uncharge)(struct bpf_local_storage_map *smap,
+					   void *owner, u32 size);
+	struct bpf_local_storage __rcu ** (*map_owner_storage_ptr)(void *owner);
 	/* BTF name and id of struct allocated by map_alloc */
 	const char * const map_btf_name;
 	int *map_btf_id;
diff --git a/include/net/bpf_sk_storage.h b/include/net/bpf_sk_storage.h
index 950c5aaba15e..9e631b5466e3 100644
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
 
@@ -13,6 +20,7 @@ void bpf_sk_storage_free(struct sock *sk);
 extern const struct bpf_func_proto bpf_sk_storage_get_proto;
 extern const struct bpf_func_proto bpf_sk_storage_delete_proto;
 
+struct bpf_local_storage_elem;
 struct bpf_sk_storage_diag;
 struct sk_buff;
 struct nlattr;
@@ -34,6 +42,50 @@ u16 bpf_local_storage_cache_idx_get(struct bpf_local_storage_cache *cache);
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
+void bpf_selem_link_storage_nolock(struct bpf_local_storage *local_storage,
+				   struct bpf_local_storage_elem *selem);
+
+bool bpf_selem_unlink_storage_nolock(struct bpf_local_storage *local_storage,
+				     struct bpf_local_storage_elem *selem,
+				     bool uncharge_omem);
+
+void bpf_selem_unlink(struct bpf_local_storage_elem *selem);
+
+void bpf_selem_link_map(struct bpf_local_storage_map *smap,
+			struct bpf_local_storage_elem *selem);
+
+void bpf_selem_unlink_map(struct bpf_local_storage_elem *selem);
+
+struct bpf_local_storage_elem *
+bpf_selem_alloc(struct bpf_local_storage_map *smap, void *owner, void *value,
+		bool charge_mem);
+
+int
+bpf_local_storage_alloc(void *owner,
+			struct bpf_local_storage_map *smap,
+			struct bpf_local_storage_elem *first_selem);
+
+struct bpf_local_storage_data *
+bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
+			 void *value, u64 map_flags);
+
 #ifdef CONFIG_BPF_SYSCALL
 int bpf_sk_storage_clone(const struct sock *sk, struct sock *newsk);
 struct bpf_sk_storage_diag *
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index a1bbaff7a0af..f1a4a476586b 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -3648,9 +3648,13 @@ enum {
 	BPF_F_SYSCTL_BASE_NAME		= (1ULL << 0),
 };
 
-/* BPF_FUNC_sk_storage_get flags */
+/* BPF_FUNC_<kernel_obj>_storage_get flags */
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
index ec61ee7c7ee4..cd8b7017913b 100644
--- a/net/core/bpf_sk_storage.c
+++ b/net/core/bpf_sk_storage.c
@@ -84,7 +84,7 @@ struct bpf_local_storage_elem {
 struct bpf_local_storage {
 	struct bpf_local_storage_data __rcu *cache[BPF_LOCAL_STORAGE_CACHE_SIZE];
 	struct hlist_head list; /* List of bpf_local_storage_elem */
-	struct sock *owner;	/* The object that owns the above "list" of
+	void *owner;		/* The object that owns the above "list" of
 				 * bpf_local_storage_elem.
 				 */
 	struct rcu_head rcu;
@@ -110,6 +110,33 @@ static int omem_charge(struct sock *sk, unsigned int size)
 	return -ENOMEM;
 }
 
+static int mem_charge(struct bpf_local_storage_map *smap, void *owner, u32 size)
+{
+	struct bpf_map *map = &smap->map;
+
+	if (!map->ops->map_local_storage_charge)
+		return 0;
+
+	return map->ops->map_local_storage_charge(smap, owner, size);
+}
+
+static void mem_uncharge(struct bpf_local_storage_map *smap, void *owner,
+			 u32 size)
+{
+	struct bpf_map *map = &smap->map;
+
+	if (map->ops->map_local_storage_uncharge)
+		map->ops->map_local_storage_uncharge(smap, owner, size);
+}
+
+static struct bpf_local_storage __rcu **
+owner_storage(struct bpf_local_storage_map *smap, void *owner)
+{
+	struct bpf_map *map = &smap->map;
+
+	return map->ops->map_owner_storage_ptr(owner);
+}
+
 static bool selem_linked_to_storage(const struct bpf_local_storage_elem *selem)
 {
 	return !hlist_unhashed(&selem->snode);
@@ -120,13 +147,13 @@ static bool selem_linked_to_map(const struct bpf_local_storage_elem *selem)
 	return !hlist_unhashed(&selem->map_node);
 }
 
-static struct bpf_local_storage_elem *
-bpf_selem_alloc(struct bpf_local_storage_map *smap, struct sock *sk,
-		void *value, bool charge_omem)
+struct bpf_local_storage_elem *
+bpf_selem_alloc(struct bpf_local_storage_map *smap, void *owner,
+		void *value, bool charge_mem)
 {
 	struct bpf_local_storage_elem *selem;
 
-	if (charge_omem && omem_charge(sk, smap->elem_size))
+	if (charge_mem && mem_charge(smap, owner, smap->elem_size))
 		return NULL;
 
 	selem = kzalloc(smap->elem_size, GFP_ATOMIC | __GFP_NOWARN);
@@ -136,8 +163,8 @@ bpf_selem_alloc(struct bpf_local_storage_map *smap, struct sock *sk,
 		return selem;
 	}
 
-	if (charge_omem)
-		atomic_sub(smap->elem_size, &sk->sk_omem_alloc);
+	if (charge_mem)
+		mem_uncharge(smap, owner, smap->elem_size);
 
 	return NULL;
 }
@@ -146,32 +173,32 @@ bpf_selem_alloc(struct bpf_local_storage_map *smap, struct sock *sk,
  * The caller must ensure selem->smap is still valid to be
  * dereferenced for its smap->elem_size and smap->cache_idx.
  */
-static bool
-bpf_selem_unlink_storage_nolock(struct bpf_local_storage *local_storage,
-				struct bpf_local_storage_elem *selem,
-				bool uncharge_omem)
+bool bpf_selem_unlink_storage_nolock(struct bpf_local_storage *local_storage,
+				     struct bpf_local_storage_elem *selem,
+				     bool uncharge_mem)
 {
 	struct bpf_local_storage_map *smap;
 	bool free_local_storage;
-	struct sock *sk;
+	void *owner;
 
 	smap = rcu_dereference(SDATA(selem)->smap);
-	sk = local_storage->owner;
+	owner = local_storage->owner;
 
 	/* All uncharging on the owner must be done first.
 	 * The owner may be freed once the last selem is unlinked
 	 * from local_storage.
 	 */
-	if (uncharge_omem)
-		atomic_sub(smap->elem_size, &sk->sk_omem_alloc);
+	if (uncharge_mem)
+		mem_uncharge(smap, owner, smap->elem_size);
 
 	free_local_storage = hlist_is_singular_node(&selem->snode,
 						    &local_storage->list);
 	if (free_local_storage) {
-		atomic_sub(sizeof(struct bpf_local_storage), &sk->sk_omem_alloc);
+		mem_uncharge(smap, owner, sizeof(struct bpf_local_storage));
 		local_storage->owner = NULL;
-		/* After this RCU_INIT, sk may be freed and cannot be used */
-		RCU_INIT_POINTER(sk->sk_bpf_storage, NULL);
+
+		/* After this RCU_INIT, owner may be freed and cannot be used */
+		RCU_INIT_POINTER(*owner_storage(smap, owner), NULL);
 
 		/* local_storage is not freed now.  local_storage->lock is
 		 * still held and raw_spin_unlock_bh(&local_storage->lock)
@@ -209,23 +236,22 @@ static void __bpf_selem_unlink_storage(struct bpf_local_storage_elem *selem)
 	local_storage = rcu_dereference(selem->local_storage);
 	raw_spin_lock_bh(&local_storage->lock);
 	if (likely(selem_linked_to_storage(selem)))
-		free_local_storage =
-			bpf_selem_unlink_storage_nolock(local_storage, selem, true);
+		free_local_storage = bpf_selem_unlink_storage_nolock(
+			local_storage, selem, true);
 	raw_spin_unlock_bh(&local_storage->lock);
 
 	if (free_local_storage)
 		kfree_rcu(local_storage, rcu);
 }
 
-static void
-bpf_selem_link_storage_nolock(struct bpf_local_storage *local_storage,
-			      struct bpf_local_storage_elem *selem)
+void bpf_selem_link_storage_nolock(struct bpf_local_storage *local_storage,
+				   struct bpf_local_storage_elem *selem)
 {
 	RCU_INIT_POINTER(selem->local_storage, local_storage);
 	hlist_add_head(&selem->snode, &local_storage->list);
 }
 
-static void bpf_selem_unlink_map(struct bpf_local_storage_elem *selem)
+void bpf_selem_unlink_map(struct bpf_local_storage_elem *selem)
 {
 	struct bpf_local_storage_map *smap;
 	struct bpf_local_storage_map_bucket *b;
@@ -242,8 +268,8 @@ static void bpf_selem_unlink_map(struct bpf_local_storage_elem *selem)
 	raw_spin_unlock_bh(&b->lock);
 }
 
-static void bpf_selem_link_map(struct bpf_local_storage_map *smap,
-			       struct bpf_local_storage_elem *selem)
+void bpf_selem_link_map(struct bpf_local_storage_map *smap,
+			struct bpf_local_storage_elem *selem)
 {
 	struct bpf_local_storage_map_bucket *b = select_bucket(smap, selem);
 
@@ -253,7 +279,7 @@ static void bpf_selem_link_map(struct bpf_local_storage_map *smap,
 	raw_spin_unlock_bh(&b->lock);
 }
 
-static void bpf_selem_unlink(struct bpf_local_storage_elem *selem)
+void bpf_selem_unlink(struct bpf_local_storage_elem *selem)
 {
 	/* Always unlink from map before unlinking from local_storage
 	 * because selem will be freed after successfully unlinked from
@@ -263,7 +289,7 @@ static void bpf_selem_unlink(struct bpf_local_storage_elem *selem)
 	__bpf_selem_unlink_storage(selem);
 }
 
-static struct bpf_local_storage_data *
+struct bpf_local_storage_data *
 bpf_local_storage_lookup(struct bpf_local_storage *local_storage,
 			 struct bpf_local_storage_map *smap,
 			 bool cacheit_lockit)
@@ -329,40 +355,45 @@ static int check_flags(const struct bpf_local_storage_data *old_sdata,
 	return 0;
 }
 
-static int sk_storage_alloc(struct sock *sk,
+int bpf_local_storage_alloc(void *owner,
 			    struct bpf_local_storage_map *smap,
 			    struct bpf_local_storage_elem *first_selem)
 {
-	struct bpf_local_storage *prev_sk_storage, *sk_storage;
+	struct bpf_local_storage *prev_storage, *storage;
+	struct bpf_local_storage **owner_storage_ptr;
 	int err;
 
-	err = omem_charge(sk, sizeof(*sk_storage));
+	err = mem_charge(smap, owner, sizeof(*storage));
 	if (err)
 		return err;
 
-	sk_storage = kzalloc(sizeof(*sk_storage), GFP_ATOMIC | __GFP_NOWARN);
-	if (!sk_storage) {
+	storage = kzalloc(sizeof(*storage), GFP_ATOMIC | __GFP_NOWARN);
+	if (!storage) {
 		err = -ENOMEM;
 		goto uncharge;
 	}
-	INIT_HLIST_HEAD(&sk_storage->list);
-	raw_spin_lock_init(&sk_storage->lock);
-	sk_storage->owner = sk;
 
-	bpf_selem_link_storage_nolock(sk_storage, first_selem);
+	INIT_HLIST_HEAD(&storage->list);
+	raw_spin_lock_init(&storage->lock);
+	storage->owner = owner;
+
+	bpf_selem_link_storage_nolock(storage, first_selem);
 	bpf_selem_link_map(smap, first_selem);
-	/* Publish sk_storage to sk.  sk->sk_lock cannot be acquired.
-	 * Hence, atomic ops is used to set sk->sk_bpf_storage
-	 * from NULL to the newly allocated sk_storage ptr.
+
+	owner_storage_ptr =
+		(struct bpf_local_storage **)owner_storage(smap, owner);
+	/* Publish storage to the owner.
+	 * Instead of using any lock of the kernel object (i.e. owner),
+	 * cmpxchg will work with any kernel object regardless what
+	 * the running context is, bh, irq...etc.
 	 *
-	 * From now on, the sk->sk_bpf_storage pointer is protected
-	 * by the sk_storage->lock.  Hence,  when freeing
-	 * the sk->sk_bpf_storage, the sk_storage->lock must
-	 * be held before setting sk->sk_bpf_storage to NULL.
+	 * From now on, the owner->storage pointer (e.g. sk->sk_bpf_storage)
+	 * is protected by the storage->lock.  Hence, when freeing
+	 * the owner->storage, the storage->lock must be held before
+	 * setting owner->storage ptr to NULL.
 	 */
-	prev_sk_storage = cmpxchg((struct bpf_local_storage **)&sk->sk_bpf_storage,
-				  NULL, sk_storage);
-	if (unlikely(prev_sk_storage)) {
+	prev_storage = cmpxchg(owner_storage_ptr, NULL, storage);
+	if (unlikely(prev_storage)) {
 		bpf_selem_unlink_map(first_selem);
 		err = -EAGAIN;
 		goto uncharge;
@@ -380,8 +411,8 @@ static int sk_storage_alloc(struct sock *sk,
 	return 0;
 
 uncharge:
-	kfree(sk_storage);
-	atomic_sub(sizeof(*sk_storage), &sk->sk_omem_alloc);
+	kfree(storage);
+	mem_uncharge(smap, owner, sizeof(*storage));
 	return err;
 }
 
@@ -390,38 +421,37 @@ static int sk_storage_alloc(struct sock *sk,
  * Otherwise, it will become a leak (and other memory issues
  * during map destruction).
  */
-static struct bpf_local_storage_data *
-bpf_local_storage_update(struct sock *sk, struct bpf_map *map, void *value,
-			 u64 map_flags)
+struct bpf_local_storage_data *
+bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
+			 void *value, u64 map_flags)
 {
 	struct bpf_local_storage_data *old_sdata = NULL;
 	struct bpf_local_storage_elem *selem;
 	struct bpf_local_storage *local_storage;
-	struct bpf_local_storage_map *smap;
 	int err;
 
 	/* BPF_EXIST and BPF_NOEXIST cannot be both set */
 	if (unlikely((map_flags & ~BPF_F_LOCK) > BPF_EXIST) ||
 	    /* BPF_F_LOCK can only be used in a value with spin_lock */
-	    unlikely((map_flags & BPF_F_LOCK) && !map_value_has_spin_lock(map)))
+	    unlikely((map_flags & BPF_F_LOCK) &&
+		     !map_value_has_spin_lock(&smap->map)))
 		return ERR_PTR(-EINVAL);
 
-	smap = (struct bpf_local_storage_map *)map;
-	local_storage = rcu_dereference(sk->sk_bpf_storage);
+	local_storage = rcu_dereference(*owner_storage(smap, owner));
 	if (!local_storage || hlist_empty(&local_storage->list)) {
 		/* Very first elem for the owner */
 		err = check_flags(NULL, map_flags);
 		if (err)
 			return ERR_PTR(err);
 
-		selem = bpf_selem_alloc(smap, sk, value, true);
+		selem = bpf_selem_alloc(smap, owner, value, true);
 		if (!selem)
 			return ERR_PTR(-ENOMEM);
 
-		err = sk_storage_alloc(sk, smap, selem);
+		err = bpf_local_storage_alloc(owner, smap, selem);
 		if (err) {
 			kfree(selem);
-			atomic_sub(smap->elem_size, &sk->sk_omem_alloc);
+			mem_uncharge(smap, owner, smap->elem_size);
 			return ERR_PTR(err);
 		}
 
@@ -439,7 +469,7 @@ bpf_local_storage_update(struct sock *sk, struct bpf_map *map, void *value,
 		if (err)
 			return ERR_PTR(err);
 		if (old_sdata && selem_linked_to_storage(SELEM(old_sdata))) {
-			copy_map_value_locked(map, old_sdata->data,
+			copy_map_value_locked(&smap->map, old_sdata->data,
 					      value, false);
 			return old_sdata;
 		}
@@ -464,7 +494,8 @@ bpf_local_storage_update(struct sock *sk, struct bpf_map *map, void *value,
 		goto unlock_err;
 
 	if (old_sdata && (map_flags & BPF_F_LOCK)) {
-		copy_map_value_locked(map, old_sdata->data, value, false);
+		copy_map_value_locked(&smap->map, old_sdata->data, value,
+				      false);
 		selem = SELEM(old_sdata);
 		goto unlock;
 	}
@@ -478,7 +509,7 @@ bpf_local_storage_update(struct sock *sk, struct bpf_map *map, void *value,
 	 * old_sdata will not be uncharged later during
 	 * bpf_selem_unlink_storage_nolock().
 	 */
-	selem = bpf_selem_alloc(smap, sk, value, !old_sdata);
+	selem = bpf_selem_alloc(smap, owner, value, !old_sdata);
 	if (!selem) {
 		err = -ENOMEM;
 		goto unlock_err;
@@ -591,17 +622,12 @@ void bpf_sk_storage_free(struct sock *sk)
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
@@ -646,7 +672,16 @@ static void bpf_local_storage_map_free(struct bpf_map *map)
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
@@ -658,7 +693,7 @@ static void bpf_local_storage_map_free(struct bpf_map *map)
 	       sizeof(struct bpf_local_storage_elem)),			\
 	      (U16_MAX - sizeof(struct bpf_local_storage_elem)))
 
-static int bpf_local_storage_map_alloc_check(union bpf_attr *attr)
+int bpf_local_storage_map_alloc_check(union bpf_attr *attr)
 {
 	if (attr->map_flags & ~BPF_LOCAL_STORAGE_CREATE_FLAG_MASK ||
 	    !(attr->map_flags & BPF_F_NO_PREALLOC) ||
@@ -677,7 +712,7 @@ static int bpf_local_storage_map_alloc_check(union bpf_attr *attr)
 	return 0;
 }
 
-static struct bpf_map *bpf_local_storage_map_alloc(union bpf_attr *attr)
+struct bpf_local_storage_map *bpf_local_storage_map_alloc(union bpf_attr *attr)
 {
 	struct bpf_local_storage_map *smap;
 	unsigned int i;
@@ -717,8 +752,19 @@ static struct bpf_map *bpf_local_storage_map_alloc(union bpf_attr *attr)
 
 	smap->elem_size =
 		sizeof(struct bpf_local_storage_elem) + attr->value_size;
-	smap->cache_idx = bpf_local_storage_cache_idx_get(&sk_cache);
 
+	return smap;
+}
+
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
 
@@ -728,10 +774,10 @@ static int notsupp_get_next_key(struct bpf_map *map, void *key,
 	return -ENOTSUPP;
 }
 
-static int bpf_local_storage_map_check_btf(const struct bpf_map *map,
-					   const struct btf *btf,
-					   const struct btf_type *key_type,
-					   const struct btf_type *value_type)
+int bpf_local_storage_map_check_btf(const struct bpf_map *map,
+				    const struct btf *btf,
+				    const struct btf_type *key_type,
+				    const struct btf_type *value_type)
 {
 	u32 int_data;
 
@@ -772,8 +818,9 @@ static int bpf_fd_sk_storage_update_elem(struct bpf_map *map, void *key,
 	fd = *(int *)key;
 	sock = sockfd_lookup(fd, &err);
 	if (sock) {
-		sdata = bpf_local_storage_update(sock->sk, map, value,
-						 map_flags);
+		sdata = bpf_local_storage_update(
+			sock->sk, (struct bpf_local_storage_map *)map, value,
+			map_flags);
 		sockfd_put(sock);
 		return PTR_ERR_OR_ZERO(sdata);
 	}
@@ -862,7 +909,7 @@ int bpf_sk_storage_clone(const struct sock *sk, struct sock *newsk)
 			bpf_selem_link_map(smap, copy_selem);
 			bpf_selem_link_storage_nolock(new_sk_storage, copy_selem);
 		} else {
-			ret = sk_storage_alloc(newsk, smap, copy_selem);
+			ret = bpf_local_storage_alloc(newsk, smap, copy_selem);
 			if (ret) {
 				kfree(copy_selem);
 				atomic_sub(smap->elem_size,
@@ -906,7 +953,9 @@ BPF_CALL_4(bpf_sk_storage_get, struct bpf_map *, map, struct sock *, sk,
 	     *  destruction).
 	     */
 	    refcount_inc_not_zero(&sk->sk_refcnt)) {
-		sdata = bpf_local_storage_update(sk, map, value, BPF_NOEXIST);
+		sdata = bpf_local_storage_update(
+			sk, (struct bpf_local_storage_map *)map, value,
+			BPF_NOEXIST);
 		/* sk must be a fullsock (guaranteed by verifier),
 		 * so sock_gen_put() is unnecessary.
 		 */
@@ -931,11 +980,33 @@ BPF_CALL_2(bpf_sk_storage_delete, struct bpf_map *, map, struct sock *, sk)
 	return -ENOENT;
 }
 
+static int sk_storage_charge(struct bpf_local_storage_map *smap,
+			     void *owner, u32 size)
+{
+	return omem_charge(owner, size);
+}
+
+static void sk_storage_uncharge(struct bpf_local_storage_map *smap,
+				void *owner, u32 size)
+{
+	struct sock *sk = owner;
+
+	atomic_sub(size, &sk->sk_omem_alloc);
+}
+
+static struct bpf_local_storage __rcu **
+sk_storage_ptr(void *owner)
+{
+	struct sock *sk = owner;
+
+	return &sk->sk_bpf_storage;
+}
+
 static int sk_storage_map_btf_id;
 const struct bpf_map_ops sk_storage_map_ops = {
 	.map_alloc_check = bpf_local_storage_map_alloc_check,
-	.map_alloc = bpf_local_storage_map_alloc,
-	.map_free = bpf_local_storage_map_free,
+	.map_alloc = sk_storage_map_alloc,
+	.map_free = sk_storage_map_free,
 	.map_get_next_key = notsupp_get_next_key,
 	.map_lookup_elem = bpf_fd_sk_storage_lookup_elem,
 	.map_update_elem = bpf_fd_sk_storage_update_elem,
@@ -943,6 +1014,9 @@ const struct bpf_map_ops sk_storage_map_ops = {
 	.map_check_btf = bpf_local_storage_map_check_btf,
 	.map_btf_name = "bpf_local_storage_map",
 	.map_btf_id = &sk_storage_map_btf_id,
+	.map_local_storage_charge = sk_storage_charge,
+	.map_local_storage_uncharge = sk_storage_uncharge,
+	.map_owner_storage_ptr = sk_storage_ptr,
 };
 
 const struct bpf_func_proto bpf_sk_storage_get_proto = {
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index a1bbaff7a0af..f1a4a476586b 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -3648,9 +3648,13 @@ enum {
 	BPF_F_SYSCTL_BASE_NAME		= (1ULL << 0),
 };
 
-/* BPF_FUNC_sk_storage_get flags */
+/* BPF_FUNC_<kernel_obj>_storage_get flags */
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
2.28.0.297.g1956fa8f8d-goog

