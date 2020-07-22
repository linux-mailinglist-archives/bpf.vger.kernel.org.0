Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87D87229E3E
	for <lists+bpf@lfdr.de>; Wed, 22 Jul 2020 19:17:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726888AbgGVROt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Jul 2020 13:14:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731760AbgGVROW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Jul 2020 13:14:22 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35323C0619E7
        for <bpf@vger.kernel.org>; Wed, 22 Jul 2020 10:14:21 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id f2so2628835wrp.7
        for <bpf@vger.kernel.org>; Wed, 22 Jul 2020 10:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LG7z+rbSF57A8WqCfCBfy4mOq5qS+HLSv6q3UZUljh0=;
        b=GDeFjX7iF9wDLoWkes3eYadTZJUOqVB/fZYitFCXAUa8ySPhFNJh0KoKt9FQNPJwBw
         5p/2xo+4lMxe+vVyCqkXW3fkAuirsrljmN2aIJp2vM1YCwsM7G+3QXIRZoRQ16d7hMe0
         C9YRB/YB2xw/Agq4LdIJtQMnlJvGRLOPJ86Qs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LG7z+rbSF57A8WqCfCBfy4mOq5qS+HLSv6q3UZUljh0=;
        b=hSZFOdJsSM69ToVu8ggfS5GJktpIqQiIOXrAkdF7aUNuAFMtF54jVfJI3KIrynOX4o
         A/wCbRUqJCiJ3BDn93XNTx/viBE25/34U5kMGC8lvHYrORlLtn6iB3b3j3Pcm5HawiiJ
         uPqedunDpXOkzVXcV15huvntwqb61PztSxlOercdhYIGX6rT5mBvCTAc9rGq6BMu6j51
         fU186s4fzIoDlVKQN7g0zqGLWf1anxvEGs8OpW+EVwaxEi76e1KOkRFrfoXSVf1hZn7H
         kYq62oZHxBOOPkD+DsRECREpphSatRmP83MVCoCxtH/e8hBHN4ACORmVidzmt1mE7Lbr
         ctVw==
X-Gm-Message-State: AOAM532h/Z8UqnFUV7lYw2GdRpswelqDrVfhMkl5twwxfqr6KB2d+KGP
        R4vnBn+aZXSEv8sVJN3d9X0EpQ==
X-Google-Smtp-Source: ABdhPJwTMkTdz7PPpjTSzVqAfCSzk8I+P99HGiMt6WfA+KAwE7axvtF9OtmBsaFMVugPgWRSCNqYxQ==
X-Received: by 2002:adf:82a5:: with SMTP id 34mr521368wrc.266.1595438059133;
        Wed, 22 Jul 2020 10:14:19 -0700 (PDT)
Received: from kpsingh.zrh.corp.google.com ([81.6.44.51])
        by smtp.gmail.com with ESMTPSA id 26sm349214wmj.25.2020.07.22.10.14.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2020 10:14:18 -0700 (PDT)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>
Subject: [PATCH bpf-next v5 4/7] bpf: Split bpf_local_storage to bpf_sk_storage
Date:   Wed, 22 Jul 2020 19:14:06 +0200
Message-Id: <20200722171409.102949-5-kpsingh@chromium.org>
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

A purely mechanical change:

	bpf_sk_storage.c = bpf_sk_storage.c + bpf_local_storage.c
	bpf_sk_storage.h = bpf_sk_storage.h + bpf_local_storage.h

Signed-off-by: KP Singh <kpsingh@google.com>
---
 include/linux/bpf_local_storage.h | 165 +++++++++
 include/net/bpf_sk_storage.h      |  64 ----
 kernel/bpf/Makefile               |   1 +
 kernel/bpf/bpf_local_storage.c    | 519 ++++++++++++++++++++++++++
 net/core/bpf_sk_storage.c         | 587 +-----------------------------
 5 files changed, 686 insertions(+), 650 deletions(-)
 create mode 100644 include/linux/bpf_local_storage.h
 create mode 100644 kernel/bpf/bpf_local_storage.c

diff --git a/include/linux/bpf_local_storage.h b/include/linux/bpf_local_storage.h
new file mode 100644
index 000000000000..d80573b11d4c
--- /dev/null
+++ b/include/linux/bpf_local_storage.h
@@ -0,0 +1,165 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2019 Facebook
+ * Copyright 2020 Google LLC.
+ */
+
+#ifndef _BPF_LOCAL_STORAGE_H
+#define _BPF_LOCAL_STORAGE_H
+
+#include <linux/bpf.h>
+#include <linux/rculist.h>
+#include <linux/list.h>
+#include <linux/hash.h>
+#include <linux/types.h>
+#include <uapi/linux/btf.h>
+
+#define BPF_LOCAL_STORAGE_CACHE_SIZE	16
+
+struct bpf_local_storage_map_bucket {
+	struct hlist_head list;
+	raw_spinlock_t lock;
+};
+
+/* Thp map is not the primary owner of a bpf_local_storage_elem.
+ * Instead, the container object (eg. sk->sk_bpf_storage) is.
+ *
+ * The map (bpf_local_storage_map) is for two purposes
+ * 1. Define the size of the "local storage".  It is
+ *    the map's value_size.
+ *
+ * 2. Maintain a list to keep track of all elems such
+ *    that they can be cleaned up during the map destruction.
+ *
+ * When a bpf local storage is being looked up for a
+ * particular object,  the "bpf_map" pointer is actually used
+ * as the "key" to search in the list of elem in
+ * the respective bpf_local_storage owned by the object.
+ *
+ * e.g. sk->sk_bpf_storage is the mini-map with the "bpf_map" pointer
+ * as the searching key.
+ */
+struct bpf_local_storage_map {
+	struct bpf_map map;
+	/* Lookup elem does not require accessing the map.
+	 *
+	 * Updating/Deleting requires a bucket lock to
+	 * link/unlink the elem from the map.  Having
+	 * multiple buckets to improve contention.
+	 */
+	struct bpf_local_storage_map_bucket *buckets;
+	u32 bucket_log;
+	u16 elem_size;
+	u16 cache_idx;
+};
+
+struct bpf_local_storage_data {
+	/* smap is used as the searching key when looking up
+	 * from the object's bpf_local_storage.
+	 *
+	 * Put it in the same cacheline as the data to minimize
+	 * the number of cachelines access during the cache hit case.
+	 */
+	struct bpf_local_storage_map __rcu *smap;
+	u8 data[] __aligned(8);
+};
+
+/* Linked to bpf_local_storage and bpf_local_storage_map */
+struct bpf_local_storage_elem {
+	struct hlist_node map_node;	/* Linked to bpf_local_storage_map */
+	struct hlist_node snode;	/* Linked to bpf_local_storage */
+	struct bpf_local_storage __rcu *local_storage;
+	struct rcu_head rcu;
+	/* 8 bytes hole */
+	/* The data is stored in aother cacheline to minimize
+	 * the number of cachelines access during a cache hit.
+	 */
+	struct bpf_local_storage_data sdata ____cacheline_aligned;
+};
+
+struct bpf_local_storage {
+	struct bpf_local_storage_data __rcu *cache[BPF_LOCAL_STORAGE_CACHE_SIZE];
+	struct hlist_head list; /* List of bpf_local_storage_elem */
+	void *owner;		/* The object that owns the the above "list" of
+				 * bpf_local_storage_elem.
+				 */
+	struct rcu_head rcu;
+	raw_spinlock_t lock;	/* Protect adding/removing from the "list" */
+};
+
+struct bpf_local_storage_cache {
+	spinlock_t idx_lock;
+	u64 idx_usage_counts[BPF_LOCAL_STORAGE_CACHE_SIZE];
+};
+
+#define DEFINE_BPF_STORAGE_CACHE(name)				\
+static struct bpf_local_storage_cache name = {			\
+	.idx_lock = __SPIN_LOCK_UNLOCKED(name.idx_lock),	\
+}
+
+u16 bpf_local_storage_cache_idx_get(struct bpf_local_storage_cache *cache);
+void bpf_local_storage_cache_idx_free(struct bpf_local_storage_cache *cache,
+				      u16 idx);
+
+/* U16_MAX is much more than enough for sk local storage
+ * considering a tcp_sock is ~2k.
+ */
+#define BPF_LOCAL_STORAGE_MAX_VALUE_SIZE				       \
+	min_t(u32,                                                             \
+	      (KMALLOC_MAX_SIZE - MAX_BPF_STACK -                              \
+	       sizeof(struct bpf_local_storage_elem)),                         \
+	      (U16_MAX - sizeof(struct bpf_local_storage_elem)))
+
+#define SELEM(_SDATA)                                                          \
+	container_of((_SDATA), struct bpf_local_storage_elem, sdata)
+#define SDATA(_SELEM) (&(_SELEM)->sdata)
+
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
+#endif /* _BPF_LOCAL_STORAGE_H */
diff --git a/include/net/bpf_sk_storage.h b/include/net/bpf_sk_storage.h
index e3185cfb91da..4cdf37ac278c 100644
--- a/include/net/bpf_sk_storage.h
+++ b/include/net/bpf_sk_storage.h
@@ -25,70 +25,6 @@ struct sk_buff;
 struct nlattr;
 struct sock;
 
-#define BPF_LOCAL_STORAGE_CACHE_SIZE	16
-
-struct bpf_local_storage_cache {
-	spinlock_t idx_lock;
-	u64 idx_usage_counts[BPF_LOCAL_STORAGE_CACHE_SIZE];
-};
-
-#define DEFINE_BPF_STORAGE_CACHE(name)				\
-static struct bpf_local_storage_cache name = {			\
-	.idx_lock = __SPIN_LOCK_UNLOCKED(name.idx_lock),	\
-}
-
-u16 bpf_local_storage_cache_idx_get(struct bpf_local_storage_cache *cache);
-void bpf_local_storage_cache_idx_free(struct bpf_local_storage_cache *cache,
-				      u16 idx);
-
-/* Helper functions for bpf_local_storage */
-int bpf_local_storage_map_alloc_check(union bpf_attr *attr);
-
-struct bpf_local_storage_map *bpf_local_storage_map_alloc(union bpf_attr *attr);
-
-struct bpf_local_storage_data *
-bpf_local_storage_lookup(struct bpf_local_storage *local_storage,
-			 struct bpf_local_storage_map *smap,
-			 bool cacheit_lockit);
-
-void bpf_local_storage_map_free(struct bpf_local_storage_map *smap);
-
-int bpf_local_storage_map_check_btf(const struct bpf_map *map,
-				    const struct btf *btf,
-				    const struct btf_type *key_type,
-				    const struct btf_type *value_type);
-
-void bpf_selem_link_storage(struct bpf_local_storage *local_storage,
-			    struct bpf_local_storage_elem *selem);
-
-bool bpf_selem_unlink_storage(struct bpf_local_storage *local_storage,
-			      struct bpf_local_storage_elem *selem,
-			      bool uncharge_omem);
-
-void bpf_selem_unlink(struct bpf_local_storage_elem *selem);
-
-void bpf_selem_link_map(struct bpf_local_storage_map *smap,
-			struct bpf_local_storage_elem *selem);
-
-void bpf_selem_unlink_map(struct bpf_local_storage_elem *selem);
-
-struct bpf_local_storage_elem *
-bpf_selem_alloc(struct bpf_local_storage_map *smap, void *value);
-
-struct bpf_local_storage *
-bpf_local_storage_alloc(struct bpf_local_storage_map *smap);
-
-int bpf_local_storage_publish(struct bpf_local_storage_elem *first_selem,
-			      struct bpf_local_storage **addr,
-			      struct bpf_local_storage *curr);
-
-int bpf_local_storage_check_update_flags(struct bpf_map *map, u64 map_flags);
-
-struct bpf_local_storage_data *
-bpf_local_storage_update(void *owner, struct bpf_map *map,
-			 struct bpf_local_storage *local_storage, void *value,
-			 u64 map_flags);
-
 #ifdef CONFIG_BPF_SYSCALL
 int bpf_sk_storage_clone(const struct sock *sk, struct sock *newsk);
 struct bpf_sk_storage_diag *
diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
index 1131a921e1a6..0acb8f8a6042 100644
--- a/kernel/bpf/Makefile
+++ b/kernel/bpf/Makefile
@@ -12,6 +12,7 @@ obj-$(CONFIG_BPF_JIT) += dispatcher.o
 ifeq ($(CONFIG_NET),y)
 obj-$(CONFIG_BPF_SYSCALL) += devmap.o
 obj-$(CONFIG_BPF_SYSCALL) += cpumap.o
+obj-$(CONFIG_BPF_SYSCALL) += bpf_local_storage.o
 obj-$(CONFIG_BPF_SYSCALL) += offload.o
 obj-$(CONFIG_BPF_SYSCALL) += net_namespace.o
 endif
diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
new file mode 100644
index 000000000000..cefda1f6dd24
--- /dev/null
+++ b/kernel/bpf/bpf_local_storage.c
@@ -0,0 +1,519 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2019 Facebook
+ * Copyright 2020 Google LLC.
+ */
+
+#include <linux/rculist.h>
+#include <linux/list.h>
+#include <linux/hash.h>
+#include <linux/types.h>
+#include <linux/spinlock.h>
+#include <linux/bpf.h>
+#include <linux/bpf_local_storage.h>
+#include <net/sock.h>
+#include <uapi/linux/sock_diag.h>
+#include <uapi/linux/btf.h>
+
+#define BPF_LOCAL_STORAGE_CREATE_FLAG_MASK (BPF_F_NO_PREALLOC | BPF_F_CLONE)
+
+static struct bpf_local_storage_map_bucket *
+select_bucket(struct bpf_local_storage_map *smap,
+	      struct bpf_local_storage_elem *selem)
+{
+	return &smap->buckets[hash_ptr(selem, smap->bucket_log)];
+}
+
+static bool selem_linked_to_storage(const struct bpf_local_storage_elem *selem)
+{
+	return !hlist_unhashed(&selem->snode);
+}
+
+static bool selem_linked_to_map(const struct bpf_local_storage_elem *selem)
+{
+	return !hlist_unhashed(&selem->map_node);
+}
+
+struct bpf_local_storage_elem *
+bpf_selem_alloc(struct bpf_local_storage_map *smap, void *value)
+{
+	struct bpf_local_storage_elem *selem;
+
+	selem = kzalloc(smap->elem_size, GFP_ATOMIC | __GFP_NOWARN);
+	if (selem) {
+		if (value)
+			memcpy(SDATA(selem)->data, value, smap->map.value_size);
+		return selem;
+	}
+
+	return NULL;
+}
+
+/* local_storage->lock must be held and selem->local_storage == local_storage.
+ * The caller must ensure selem->smap is still valid to be
+ * dereferenced for its smap->elem_size and smap->cache_idx.
+ */
+bool bpf_selem_unlink_storage(struct bpf_local_storage *local_storage,
+			      struct bpf_local_storage_elem *selem,
+			      bool uncharge_omem)
+{
+	struct bpf_local_storage_map *smap;
+	bool free_local_storage;
+
+	smap = rcu_dereference(SDATA(selem)->smap);
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
+
+
+static void __bpf_selem_unlink_storage(struct bpf_local_storage_elem *selem)
+{
+	struct bpf_local_storage *local_storage;
+	bool free_local_storage = false;
+
+	if (unlikely(!selem_linked_to_storage(selem)))
+		/* selem has already been unlinked from sk */
+		return;
+
+	local_storage = rcu_dereference(selem->local_storage);
+	raw_spin_lock_bh(&local_storage->lock);
+	if (likely(selem_linked_to_storage(selem)))
+		free_local_storage =
+			bpf_selem_unlink_storage(local_storage, selem, true);
+	raw_spin_unlock_bh(&local_storage->lock);
+
+	if (free_local_storage)
+		kfree_rcu(local_storage, rcu);
+}
+
+void bpf_selem_link_storage(struct bpf_local_storage *local_storage,
+			    struct bpf_local_storage_elem *selem)
+{
+	RCU_INIT_POINTER(selem->local_storage, local_storage);
+	hlist_add_head(&selem->snode, &local_storage->list);
+}
+
+void bpf_selem_unlink_map(struct bpf_local_storage_elem *selem)
+{
+	struct bpf_local_storage_map *smap;
+	struct bpf_local_storage_map_bucket *b;
+
+	if (unlikely(!selem_linked_to_map(selem)))
+		/* selem has already be unlinked from smap */
+		return;
+
+	smap = rcu_dereference(SDATA(selem)->smap);
+	b = select_bucket(smap, selem);
+	raw_spin_lock_bh(&b->lock);
+	if (likely(selem_linked_to_map(selem)))
+		hlist_del_init_rcu(&selem->map_node);
+	raw_spin_unlock_bh(&b->lock);
+}
+
+void bpf_selem_link_map(struct bpf_local_storage_map *smap,
+			struct bpf_local_storage_elem *selem)
+{
+	struct bpf_local_storage_map_bucket *b = select_bucket(smap, selem);
+
+	raw_spin_lock_bh(&b->lock);
+	RCU_INIT_POINTER(SDATA(selem)->smap, smap);
+	hlist_add_head_rcu(&selem->map_node, &b->list);
+	raw_spin_unlock_bh(&b->lock);
+}
+
+void bpf_selem_unlink(struct bpf_local_storage_elem *selem)
+{
+	/* Always unlink from map before unlinking from local_storage
+	 * because selem will be freed after successfully unlinked from
+	 * the local_storage.
+	 */
+	bpf_selem_unlink_map(selem);
+	__bpf_selem_unlink_storage(selem);
+}
+
+struct bpf_local_storage_data *
+bpf_local_storage_lookup(struct bpf_local_storage *local_storage,
+			 struct bpf_local_storage_map *smap,
+			 bool cacheit_lockit)
+{
+	struct bpf_local_storage_data *sdata;
+	struct bpf_local_storage_elem *selem;
+
+	/* Fast path (cache hit) */
+	sdata = rcu_dereference(local_storage->cache[smap->cache_idx]);
+	if (sdata && rcu_access_pointer(sdata->smap) == smap)
+		return sdata;
+
+	/* Slow path (cache miss) */
+	hlist_for_each_entry_rcu(selem, &local_storage->list, snode)
+		if (rcu_access_pointer(SDATA(selem)->smap) == smap)
+			break;
+
+	if (!selem)
+		return NULL;
+
+	sdata = SDATA(selem);
+	if (cacheit_lockit) {
+		/* spinlock is needed to avoid racing with the
+		 * parallel delete.  Otherwise, publishing an already
+		 * deleted sdata to the cache will become a use-after-free
+		 * problem in the next bpf_local_storage_lookup().
+		 */
+		raw_spin_lock_bh(&local_storage->lock);
+		if (selem_linked_to_storage(selem))
+			rcu_assign_pointer(local_storage->cache[smap->cache_idx],
+					   sdata);
+		raw_spin_unlock_bh(&local_storage->lock);
+	}
+
+	return sdata;
+}
+
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
+static int check_flags(const struct bpf_local_storage_data *old_sdata,
+		       u64 map_flags)
+{
+	if (old_sdata && (map_flags & ~BPF_F_LOCK) == BPF_NOEXIST)
+		/* elem already exists */
+		return -EEXIST;
+
+	if (!old_sdata && (map_flags & ~BPF_F_LOCK) == BPF_EXIST)
+		/* elem doesn't exist, cannot update it */
+		return -ENOENT;
+
+	return 0;
+}
+
+/* sk cannot be going away because it is linking new elem
+ * to sk->sk_bpf_storage. (i.e. sk->sk_refcnt cannot be 0).
+ * Otherwise, it will become a leak (and other memory issues
+ * during map destruction).
+ */
+struct bpf_local_storage_data *
+bpf_local_storage_update(void *owner, struct bpf_map *map,
+			 struct bpf_local_storage *local_storage, void *value,
+			 u64 map_flags)
+{
+	struct bpf_local_storage_data *old_sdata = NULL;
+	struct bpf_local_storage_elem *selem;
+	struct bpf_local_storage_map *smap;
+	int err;
+
+	smap = (struct bpf_local_storage_map *)map;
+
+	if ((map_flags & BPF_F_LOCK) && !(map_flags & BPF_NOEXIST)) {
+		/* Hoping to find an old_sdata to do inline update
+		 * such that it can avoid taking the local_storage->lock
+		 * and changing the lists.
+		 */
+		old_sdata = bpf_local_storage_lookup(local_storage, smap, false);
+		err = check_flags(old_sdata, map_flags);
+		if (err)
+			return ERR_PTR(err);
+
+		if (old_sdata && selem_linked_to_storage(SELEM(old_sdata))) {
+			copy_map_value_locked(map, old_sdata->data,
+					      value, false);
+			return old_sdata;
+		}
+	}
+
+	raw_spin_lock_bh(&local_storage->lock);
+
+	/* Recheck local_storage->list under local_storage->lock */
+	if (unlikely(hlist_empty(&local_storage->list))) {
+		/* A parallel del is happening and local_storage is going
+		 * away.  It has just been checked before, so very
+		 * unlikely.  Return instead of retry to keep things
+		 * simple.
+		 */
+		err = -EAGAIN;
+		goto unlock_err;
+	}
+
+	old_sdata = bpf_local_storage_lookup(local_storage, smap, false);
+	err = check_flags(old_sdata, map_flags);
+	if (err)
+		goto unlock_err;
+
+	if (old_sdata && (map_flags & BPF_F_LOCK)) {
+		copy_map_value_locked(map, old_sdata->data, value, false);
+		selem = SELEM(old_sdata);
+		goto unlock;
+	}
+
+	/* local_storage->lock is held.  Hence, we are sure
+	 * we can unlink and uncharge the old_sdata successfully
+	 * later.  Hence, instead of charging the new selem now
+	 * and then uncharge the old selem later (which may cause
+	 * a potential but unnecessary charge failure),  avoid taking
+	 * a charge at all here (the "!old_sdata" check) and the
+	 * old_sdata will not be uncharged later during bpf_selem_unlink().
+	 */
+	selem = map->ops->map_selem_alloc(smap, owner, value, !old_sdata);
+	if (!selem) {
+		err = -ENOMEM;
+		goto unlock_err;
+	}
+
+	/* First, link the new selem to the map */
+	bpf_selem_link_map(smap, selem);
+
+	/* Second, link (and publish) the new selem to local_storage */
+	bpf_selem_link_storage(local_storage, selem);
+
+	/* Third, remove old selem, SELEM(old_sdata) */
+	if (old_sdata) {
+		bpf_selem_unlink_map(SELEM(old_sdata));
+		bpf_selem_unlink_storage(local_storage, SELEM(old_sdata), false);
+	}
+
+unlock:
+	raw_spin_unlock_bh(&local_storage->lock);
+	return SDATA(selem);
+
+unlock_err:
+	raw_spin_unlock_bh(&local_storage->lock);
+	return ERR_PTR(err);
+}
+
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
+u16 bpf_local_storage_cache_idx_get(struct bpf_local_storage_cache *cache)
+{
+	u64 min_usage = U64_MAX;
+	u16 i, res = 0;
+
+	spin_lock(&cache->idx_lock);
+	for (i = 0; i < BPF_LOCAL_STORAGE_CACHE_SIZE; i++) {
+		if (cache->idx_usage_counts[i] < min_usage) {
+			min_usage = cache->idx_usage_counts[i];
+			res = i;
+
+			/* Found a free cache_idx */
+			if (!min_usage)
+				break;
+		}
+	}
+
+	cache->idx_usage_counts[res]++;
+
+	spin_unlock(&cache->idx_lock);
+
+	return res;
+}
+
+void bpf_local_storage_cache_idx_free(struct bpf_local_storage_cache *cache,
+				      u16 idx)
+{
+	spin_lock(&cache->idx_lock);
+	cache->idx_usage_counts[idx]--;
+	spin_unlock(&cache->idx_lock);
+}
+
+void bpf_local_storage_map_free(struct bpf_local_storage_map *smap)
+{
+	struct bpf_local_storage_elem *selem;
+	struct bpf_local_storage_map_bucket *b;
+	unsigned int i;
+
+	/* Note that this map might be concurrently cloned from
+	 * bpf_sk_storage_clone. Wait for any existing bpf_sk_storage_clone
+	 * RCU read section to finish before proceeding. New RCU
+	 * read sections should be prevented via bpf_map_inc_not_zero.
+	 */
+	synchronize_rcu();
+
+	/* bpf prog and the userspace can no longer access this map
+	 * now.  No new selem (of this map) can be added
+	 * to the bpf_local_storage or to the map bucket's list.
+	 *
+	 * The elem of this map can be cleaned up here
+	 * or by bpf_local_storage_free() during the destruction of the
+	 * owner object. eg. __sk_destruct.
+	 */
+	for (i = 0; i < (1U << smap->bucket_log); i++) {
+		b = &smap->buckets[i];
+
+		rcu_read_lock();
+		/* No one is adding to b->list now */
+		while ((selem = hlist_entry_safe(rcu_dereference_raw(hlist_first_rcu(&b->list)),
+						 struct bpf_local_storage_elem,
+						 map_node))) {
+			bpf_selem_unlink(selem);
+			cond_resched_rcu();
+		}
+		rcu_read_unlock();
+	}
+
+	/* bpf_local_storage_free() may still need to access the map.
+	 * e.g. bpf_local_storage_free() has unlinked selem from the map
+	 * which then made the above while((selem = ...)) loop
+	 * exited immediately.
+	 *
+	 * However, the bpf_local_storage_free() still needs to access
+	 * the smap->elem_size to do the uncharging in
+	 * bpf_selem_unlink().
+	 *
+	 * Hence, wait another rcu grace period for the
+	 * bpf_local_storage_free() to finish.
+	 */
+	synchronize_rcu();
+
+	kvfree(smap->buckets);
+	kfree(smap);
+}
+
+int bpf_local_storage_map_alloc_check(union bpf_attr *attr)
+{
+	if (attr->map_flags & ~BPF_LOCAL_STORAGE_CREATE_FLAG_MASK ||
+	    !(attr->map_flags & BPF_F_NO_PREALLOC) ||
+	    attr->max_entries ||
+	    attr->key_size != sizeof(int) || !attr->value_size ||
+	    /* Enforce BTF for userspace sk dumping */
+	    !attr->btf_key_type_id || !attr->btf_value_type_id)
+		return -EINVAL;
+
+	if (!bpf_capable())
+		return -EPERM;
+
+	if (attr->value_size > BPF_LOCAL_STORAGE_MAX_VALUE_SIZE)
+		return -E2BIG;
+
+	return 0;
+}
+
+struct bpf_local_storage_map *bpf_local_storage_map_alloc(union bpf_attr *attr)
+{
+	struct bpf_local_storage_map *smap;
+	unsigned int i;
+	u32 nbuckets;
+	u64 cost;
+	int ret;
+
+	smap = kzalloc(sizeof(*smap), GFP_USER | __GFP_NOWARN);
+	if (!smap)
+		return ERR_PTR(-ENOMEM);
+	bpf_map_init_from_attr(&smap->map, attr);
+
+	nbuckets = roundup_pow_of_two(num_possible_cpus());
+	/* Use at least 2 buckets, select_bucket() is undefined behavior with 1 bucket */
+	nbuckets = max_t(u32, 2, nbuckets);
+	smap->bucket_log = ilog2(nbuckets);
+	cost = sizeof(*smap->buckets) * nbuckets + sizeof(*smap);
+
+	ret = bpf_map_charge_init(&smap->map.memory, cost);
+	if (ret < 0) {
+		kfree(smap);
+		return ERR_PTR(ret);
+	}
+
+	smap->buckets = kvcalloc(sizeof(*smap->buckets), nbuckets,
+				 GFP_USER | __GFP_NOWARN);
+	if (!smap->buckets) {
+		bpf_map_charge_finish(&smap->map.memory);
+		kfree(smap);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	for (i = 0; i < nbuckets; i++) {
+		INIT_HLIST_HEAD(&smap->buckets[i].list);
+		raw_spin_lock_init(&smap->buckets[i].lock);
+	}
+
+	smap->elem_size =
+		sizeof(struct bpf_local_storage_elem) + attr->value_size;
+
+	return smap;
+}
+
+int bpf_local_storage_map_check_btf(const struct bpf_map *map,
+				    const struct btf *btf,
+				    const struct btf_type *key_type,
+				    const struct btf_type *value_type)
+{
+	u32 int_data;
+
+	if (BTF_INFO_KIND(key_type->info) != BTF_KIND_INT)
+		return -EINVAL;
+
+	int_data = *(u32 *)(key_type + 1);
+	if (BTF_INT_BITS(int_data) != 32 || BTF_INT_OFFSET(int_data))
+		return -EINVAL;
+
+	return 0;
+}
diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
index f6bb02f076ad..be0ed44d0887 100644
--- a/net/core/bpf_sk_storage.c
+++ b/net/core/bpf_sk_storage.c
@@ -7,96 +7,13 @@
 #include <linux/spinlock.h>
 #include <linux/bpf.h>
 #include <net/bpf_sk_storage.h>
+#include <linux/bpf_local_storage.h>
 #include <net/sock.h>
 #include <uapi/linux/sock_diag.h>
 #include <uapi/linux/btf.h>
 
-#define BPF_LOCAL_STORAGE_CREATE_FLAG_MASK (BPF_F_NO_PREALLOC | BPF_F_CLONE)
-
 DEFINE_BPF_STORAGE_CACHE(sk_cache);
 
-struct bpf_local_storage_map_bucket {
-	struct hlist_head list;
-	raw_spinlock_t lock;
-};
-
-/* Thp map is not the primary owner of a bpf_local_storage_elem.
- * Instead, the container object (eg. sk->sk_bpf_storage) is.
- *
- * The map (bpf_local_storage_map) is for two purposes
- * 1. Define the size of the "local storage".  It is
- *    the map's value_size.
- *
- * 2. Maintain a list to keep track of all elems such
- *    that they can be cleaned up during the map destruction.
- *
- * When a bpf local storage is being looked up for a
- * particular object,  the "bpf_map" pointer is actually used
- * as the "key" to search in the list of elem in
- * the respective bpf_local_storage owned by the object.
- *
- * e.g. sk->sk_bpf_storage is the mini-map with the "bpf_map" pointer
- * as the searching key.
- */
-struct bpf_local_storage_map {
-	struct bpf_map map;
-	/* Lookup elem does not require accessing the map.
-	 *
-	 * Updating/Deleting requires a bucket lock to
-	 * link/unlink the elem from the map.  Having
-	 * multiple buckets to improve contention.
-	 */
-	struct bpf_local_storage_map_bucket *buckets;
-	u32 bucket_log;
-	u16 elem_size;
-	u16 cache_idx;
-};
-
-struct bpf_local_storage_data {
-	/* smap is used as the searching key when looking up
-	 * from the object's bpf_local_storage.
-	 *
-	 * Put it in the same cacheline as the data to minimize
-	 * the number of cachelines access during the cache hit case.
-	 */
-	struct bpf_local_storage_map __rcu *smap;
-	u8 data[] __aligned(8);
-};
-
-/* Linked to bpf_local_storage and bpf_local_storage_map */
-struct bpf_local_storage_elem {
-	struct hlist_node map_node;	/* Linked to bpf_local_storage_map */
-	struct hlist_node snode;	/* Linked to bpf_local_storage */
-	struct bpf_local_storage __rcu *local_storage;
-	struct rcu_head rcu;
-	/* 8 bytes hole */
-	/* The data is stored in aother cacheline to minimize
-	 * the number of cachelines access during a cache hit.
-	 */
-	struct bpf_local_storage_data sdata ____cacheline_aligned;
-};
-
-#define SELEM(_SDATA)							\
-	container_of((_SDATA), struct bpf_local_storage_elem, sdata)
-#define SDATA(_SELEM) (&(_SELEM)->sdata)
-
-struct bpf_local_storage {
-	struct bpf_local_storage_data __rcu *cache[BPF_LOCAL_STORAGE_CACHE_SIZE];
-	struct hlist_head list; /* List of bpf_local_storage_elem */
-	void *owner;		/* The object that owns the the above "list" of
-				 * bpf_local_storage_elem.
-				 */
-	struct rcu_head rcu;
-	raw_spinlock_t lock;	/* Protect adding/removing from the "list" */
-};
-
-static struct bpf_local_storage_map_bucket *
-select_bucket(struct bpf_local_storage_map *smap,
-	      struct bpf_local_storage_elem *selem)
-{
-	return &smap->buckets[hash_ptr(selem, smap->bucket_log)];
-}
-
 static int omem_charge(struct sock *sk, unsigned int size)
 {
 	/* same check as in sock_kmalloc() */
@@ -109,31 +26,6 @@ static int omem_charge(struct sock *sk, unsigned int size)
 	return -ENOMEM;
 }
 
-static bool selem_linked_to_storage(const struct bpf_local_storage_elem *selem)
-{
-	return !hlist_unhashed(&selem->snode);
-}
-
-static bool selem_linked_to_map(const struct bpf_local_storage_elem *selem)
-{
-	return !hlist_unhashed(&selem->map_node);
-}
-
-struct bpf_local_storage_elem *
-bpf_selem_alloc(struct bpf_local_storage_map *smap, void *value)
-{
-	struct bpf_local_storage_elem *selem;
-
-	selem = kzalloc(smap->elem_size, GFP_ATOMIC | __GFP_NOWARN);
-	if (selem) {
-		if (value)
-			memcpy(SDATA(selem)->data, value, smap->map.value_size);
-		return selem;
-	}
-
-	return NULL;
-}
-
 static struct bpf_local_storage_elem *
 sk_selem_alloc(struct bpf_local_storage_map *smap, void *owner, void *value,
 	       bool charge_omem)
@@ -154,42 +46,6 @@ sk_selem_alloc(struct bpf_local_storage_map *smap, void *owner, void *value,
 	return NULL;
 }
 
-/* sk_storage->lock must be held and selem->sk_storage == sk_storage.
- * The caller must ensure selem->smap is still valid to be
- * dereferenced for its smap->elem_size and smap->cache_idx.
- */
-bool bpf_selem_unlink_storage(struct bpf_local_storage *local_storage,
-			      struct bpf_local_storage_elem *selem,
-			      bool uncharge_omem)
-{
-	struct bpf_local_storage_map *smap;
-	bool free_local_storage;
-
-	smap = rcu_dereference(SDATA(selem)->smap);
-	/* local_storage is not freed now. local_storage->lock is
-	 * still held and raw_spin_unlock_bh(&local_storage->lock)
-	 * will be done by the caller.
-	 * Although the unlock will be done under
-	 * rcu_read_lock(),  it is more intutivie to
-	 * read if kfree_rcu(local_storage, rcu) is done
-	 * after the raw_spin_unlock_bh(&local_storage->lock).
-	 *
-	 * Hence, a "bool free_local_storage" is returned
-	 * to the caller which then calls the kfree_rcu()
-	 * after unlock.
-	 */
-	free_local_storage = smap->map.ops->map_local_storage_unlink(
-		local_storage, selem, uncharge_omem);
-	hlist_del_init_rcu(&selem->snode);
-	if (rcu_access_pointer(local_storage->cache[smap->cache_idx]) ==
-	    SDATA(selem))
-		RCU_INIT_POINTER(local_storage->cache[smap->cache_idx], NULL);
-
-	kfree_rcu(selem, rcu);
-
-	return free_local_storage;
-}
-
 static bool unlink_sk_storage(struct bpf_local_storage *local_storage,
 			      struct bpf_local_storage_elem *selem,
 			      bool uncharge_omem)
@@ -221,109 +77,6 @@ static bool unlink_sk_storage(struct bpf_local_storage *local_storage,
 	return free_local_storage;
 }
 
-static void __bpf_selem_unlink_storage(struct bpf_local_storage_elem *selem)
-{
-	struct bpf_local_storage *local_storage;
-	bool free_local_storage = false;
-
-	if (unlikely(!selem_linked_to_storage(selem)))
-		/* selem has already been unlinked from sk */
-		return;
-
-	local_storage = rcu_dereference(selem->local_storage);
-	raw_spin_lock_bh(&local_storage->lock);
-	if (likely(selem_linked_to_storage(selem)))
-		free_local_storage =
-			bpf_selem_unlink_storage(local_storage, selem, true);
-	raw_spin_unlock_bh(&local_storage->lock);
-
-	if (free_local_storage)
-		kfree_rcu(local_storage, rcu);
-}
-
-void bpf_selem_link_storage(struct bpf_local_storage *local_storage,
-			    struct bpf_local_storage_elem *selem)
-{
-	RCU_INIT_POINTER(selem->local_storage, local_storage);
-	hlist_add_head(&selem->snode, &local_storage->list);
-}
-
-void bpf_selem_unlink_map(struct bpf_local_storage_elem *selem)
-{
-	struct bpf_local_storage_map *smap;
-	struct bpf_local_storage_map_bucket *b;
-
-	if (unlikely(!selem_linked_to_map(selem)))
-		/* selem has already be unlinked from smap */
-		return;
-
-	smap = rcu_dereference(SDATA(selem)->smap);
-	b = select_bucket(smap, selem);
-	raw_spin_lock_bh(&b->lock);
-	if (likely(selem_linked_to_map(selem)))
-		hlist_del_init_rcu(&selem->map_node);
-	raw_spin_unlock_bh(&b->lock);
-}
-
-void bpf_selem_link_map(struct bpf_local_storage_map *smap,
-			struct bpf_local_storage_elem *selem)
-{
-	struct bpf_local_storage_map_bucket *b = select_bucket(smap, selem);
-
-	raw_spin_lock_bh(&b->lock);
-	RCU_INIT_POINTER(SDATA(selem)->smap, smap);
-	hlist_add_head_rcu(&selem->map_node, &b->list);
-	raw_spin_unlock_bh(&b->lock);
-}
-
-void bpf_selem_unlink(struct bpf_local_storage_elem *selem)
-{
-	/* Always unlink from map before unlinking from local_storage
-	 * because selem will be freed after successfully unlinked from
-	 * the local_storage.
-	 */
-	bpf_selem_unlink_map(selem);
-	__bpf_selem_unlink_storage(selem);
-}
-
-struct bpf_local_storage_data *
-bpf_local_storage_lookup(struct bpf_local_storage *local_storage,
-			 struct bpf_local_storage_map *smap,
-			 bool cacheit_lockit)
-{
-	struct bpf_local_storage_data *sdata;
-	struct bpf_local_storage_elem *selem;
-
-	/* Fast path (cache hit) */
-	sdata = rcu_dereference(local_storage->cache[smap->cache_idx]);
-	if (sdata && rcu_access_pointer(sdata->smap) == smap)
-		return sdata;
-
-	/* Slow path (cache miss) */
-	hlist_for_each_entry_rcu(selem, &local_storage->list, snode)
-		if (rcu_access_pointer(SDATA(selem)->smap) == smap)
-			break;
-
-	if (!selem)
-		return NULL;
-
-	sdata = SDATA(selem);
-	if (cacheit_lockit) {
-		/* spinlock is needed to avoid racing with the
-		 * parallel delete.  Otherwise, publishing an already
-		 * deleted sdata to the cache will become a use-after-free
-		 * problem in the next bpf_local_storage_lookup().
-		 */
-		raw_spin_lock_bh(&local_storage->lock);
-		if (selem_linked_to_storage(selem))
-			rcu_assign_pointer(local_storage->cache[smap->cache_idx],
-					   sdata);
-		raw_spin_unlock_bh(&local_storage->lock);
-	}
-
-	return sdata;
-}
-
 static struct bpf_local_storage_data *
 sk_storage_lookup(struct sock *sk, struct bpf_map *map, bool cacheit_lockit)
 {
@@ -338,34 +91,6 @@ sk_storage_lookup(struct sock *sk, struct bpf_map *map, bool cacheit_lockit)
 	return bpf_local_storage_lookup(sk_storage, smap, cacheit_lockit);
 }
 
-static int check_flags(const struct bpf_local_storage_data *old_sdata,
-		       u64 map_flags)
-{
-	if (old_sdata && (map_flags & ~BPF_F_LOCK) == BPF_NOEXIST)
-		/* elem already exists */
-		return -EEXIST;
-
-	if (!old_sdata && (map_flags & ~BPF_F_LOCK) == BPF_EXIST)
-		/* elem doesn't exist, cannot update it */
-		return -ENOENT;
-
-	return 0;
-}
-
-struct bpf_local_storage *
-bpf_local_storage_alloc(struct bpf_local_storage_map *smap)
-{
-	struct bpf_local_storage *storage;
-
-	storage = kzalloc(sizeof(*storage), GFP_ATOMIC | __GFP_NOWARN);
-	if (!storage)
-		return NULL;
-
-	INIT_HLIST_HEAD(&storage->list);
-	raw_spin_lock_init(&storage->lock);
-	return storage;
-}
-
 static int sk_storage_alloc(void *owner,
 			    struct bpf_local_storage_map *smap,
 			    struct bpf_local_storage_elem *first_selem)
@@ -402,142 +127,6 @@ static int sk_storage_alloc(void *owner,
 	return err;
 }
 
-/* sk cannot be going away because it is linking new elem
- * to sk->sk_bpf_storage. (i.e. sk->sk_refcnt cannot be 0).
- * Otherwise, it will become a leak (and other memory issues
- * during map destruction).
- */
-struct bpf_local_storage_data *
-bpf_local_storage_update(void *owner, struct bpf_map *map,
-			 struct bpf_local_storage *local_storage, void *value,
-			 u64 map_flags)
-{
-	struct bpf_local_storage_data *old_sdata = NULL;
-	struct bpf_local_storage_elem *selem;
-	struct bpf_local_storage_map *smap;
-	int err;
-
-	smap = (struct bpf_local_storage_map *)map;
-
-	if ((map_flags & BPF_F_LOCK) && !(map_flags & BPF_NOEXIST)) {
-		/* Hoping to find an old_sdata to do inline update
-		 * such that it can avoid taking the local_storage->lock
-		 * and changing the lists.
-		 */
-		old_sdata = bpf_local_storage_lookup(local_storage, smap, false);
-		err = check_flags(old_sdata, map_flags);
-		if (err)
-			return ERR_PTR(err);
-
-		if (old_sdata && selem_linked_to_storage(SELEM(old_sdata))) {
-			copy_map_value_locked(map, old_sdata->data,
-					      value, false);
-			return old_sdata;
-		}
-	}
-
-	raw_spin_lock_bh(&local_storage->lock);
-
-	/* Recheck local_storage->list under local_storage->lock */
-	if (unlikely(hlist_empty(&local_storage->list))) {
-		/* A parallel del is happening and local_storage is going
-		 * away.  It has just been checked before, so very
-		 * unlikely.  Return instead of retry to keep things
-		 * simple.
-		 */
-		err = -EAGAIN;
-		goto unlock_err;
-	}
-
-	old_sdata = bpf_local_storage_lookup(local_storage, smap, false);
-	err = check_flags(old_sdata, map_flags);
-	if (err)
-		goto unlock_err;
-
-	if (old_sdata && (map_flags & BPF_F_LOCK)) {
-		copy_map_value_locked(map, old_sdata->data, value, false);
-		selem = SELEM(old_sdata);
-		goto unlock;
-	}
-
-	/* local_storage->lock is held.  Hence, we are sure
-	 * we can unlink and uncharge the old_sdata successfully
-	 * later.  Hence, instead of charging the new selem now
-	 * and then uncharge the old selem later (which may cause
-	 * a potential but unnecessary charge failure),  avoid taking
-	 * a charge at all here (the "!old_sdata" check) and the
-	 * old_sdata will not be uncharged later during bpf_selem_unlink().
-	 */
-	selem = map->ops->map_selem_alloc(smap, owner, value, !old_sdata);
-	if (!selem) {
-		err = -ENOMEM;
-		goto unlock_err;
-	}
-
-	/* First, link the new selem to the map */
-	bpf_selem_link_map(smap, selem);
-
-	/* Second, link (and publish) the new selem to local_storage */
-	bpf_selem_link_storage(local_storage, selem);
-
-	/* Third, remove old selem, SELEM(old_sdata) */
-	if (old_sdata) {
-		bpf_selem_unlink_map(SELEM(old_sdata));
-		bpf_selem_unlink_storage(local_storage, SELEM(old_sdata), false);
-	}
-
-unlock:
-	raw_spin_unlock_bh(&local_storage->lock);
-	return SDATA(selem);
-
-unlock_err:
-	raw_spin_unlock_bh(&local_storage->lock);
-	return ERR_PTR(err);
-}
-
-int bpf_local_storage_check_update_flags(struct bpf_map *map, u64 map_flags)
-{
-	/* BPF_EXIST and BPF_NOEXIST cannot be both set */
-	if (unlikely((map_flags & ~BPF_F_LOCK) > BPF_EXIST) ||
-	    /* BPF_F_LOCK can only be used in a value with spin_lock */
-	    unlikely((map_flags & BPF_F_LOCK) && !map_value_has_spin_lock(map)))
-		return -EINVAL;
-
-	return 0;
-}
-
-/* Publish local_storage to the address.  This is used because we are already
- * in a region where we cannot grab a lock on the object owning the storage (
- * (e.g sk->sk_lock). Hence, atomic ops is used.
- *
- * From now on, the addr pointer is protected
- * by the local_storage->lock.  Hence, upon freeing,
- * the local_storage->lock must be held before unlinking the storage from the
- * owner.
- */
-int bpf_local_storage_publish(struct bpf_local_storage_elem *first_selem,
-			      struct bpf_local_storage **addr,
-			      struct bpf_local_storage *curr)
-{
-	struct bpf_local_storage *prev;
-
-	prev = cmpxchg(addr, NULL, curr);
-	if (unlikely(prev)) {
-		/* Note that even first_selem was linked to smap's
-		 * bucket->list, first_selem can be freed immediately
-		 * (instead of kfree_rcu) because
-		 * bpf_local_storage_map_free() does a
-		 * synchronize_rcu() before walking the bucket->list.
-		 * Hence, no one is accessing selem from the
-		 * bucket->list under rcu_read_lock().
-		 */
-		bpf_selem_unlink_map(first_selem);
-		return -EAGAIN;
-	}
-
-	return 0;
-}
-
 static struct bpf_local_storage_data *
 sk_storage_update(void *owner, struct bpf_map *map, void *value, u64 map_flags)
 {
@@ -589,38 +178,6 @@ static int sk_storage_delete(struct sock *sk, struct bpf_map *map)
 	return 0;
 }
 
-u16 bpf_local_storage_cache_idx_get(struct bpf_local_storage_cache *cache)
-{
-	u64 min_usage = U64_MAX;
-	u16 i, res = 0;
-
-	spin_lock(&cache->idx_lock);
-
-	for (i = 0; i < BPF_LOCAL_STORAGE_CACHE_SIZE; i++) {
-		if (cache->idx_usage_counts[i] < min_usage) {
-			min_usage = cache->idx_usage_counts[i];
-			res = i;
-
-			/* Found a free cache_idx */
-			if (!min_usage)
-				break;
-		}
-	}
-	cache->idx_usage_counts[res]++;
-
-	spin_unlock(&cache->idx_lock);
-
-	return res;
-}
-
-void bpf_local_storage_cache_idx_free(struct bpf_local_storage_cache *cache,
-				      u16 idx)
-{
-	spin_lock(&cache->idx_lock);
-	cache->idx_usage_counts[idx]--;
-	spin_unlock(&cache->idx_lock);
-}
-
 /* Called by __sk_destruct() & bpf_sk_storage_clone() */
 void bpf_sk_storage_free(struct sock *sk)
 {
@@ -661,59 +218,6 @@ void bpf_sk_storage_free(struct sock *sk)
 		kfree_rcu(sk_storage, rcu);
 }
 
-void bpf_local_storage_map_free(struct bpf_local_storage_map *smap)
-{
-	struct bpf_local_storage_elem *selem;
-	struct bpf_local_storage_map_bucket *b;
-	unsigned int i;
-
-	/* Note that this map might be concurrently cloned from
-	 * bpf_sk_storage_clone. Wait for any existing bpf_sk_storage_clone
-	 * RCU read section to finish before proceeding. New RCU
-	 * read sections should be prevented via bpf_map_inc_not_zero.
-	 */
-	synchronize_rcu();
-
-	/* bpf prog and the userspace can no longer access this map
-	 * now.  No new selem (of this map) can be added
-	 * to the bpf_local_storage or to the map bucket's list.
-	 *
-	 * The elem of this map can be cleaned up here
-	 * or by bpf_local_storage_free() during the destruction of the
-	 * owner object. eg. __sk_destruct.
-	 */
-	for (i = 0; i < (1U << smap->bucket_log); i++) {
-		b = &smap->buckets[i];
-
-		rcu_read_lock();
-		/* No one is adding to b->list now */
-		while ((selem = hlist_entry_safe(rcu_dereference_raw(hlist_first_rcu(&b->list)),
-						 struct bpf_local_storage_elem,
-						 map_node))) {
-			bpf_selem_unlink(selem);
-			cond_resched_rcu();
-		}
-		rcu_read_unlock();
-	}
-
-	/* bpf_local_storage_free() may still need to access the map.
-	 * e.g. bpf_local_storage_free() has unlinked selem from the map
-	 * which then made the above while((selem = ...)) loop
-	 * exited immediately.
-	 *
-	 * However, the bpf_local_storage_free() still needs to access
-	 * the smap->elem_size to do the uncharging in
-	 * bpf_selem_unlink().
-	 *
-	 * Hence, wait another rcu grace period for the
-	 * bpf_local_storage_free() to finish.
-	 */
-	synchronize_rcu();
-
-	kvfree(smap->buckets);
-	kfree(smap);
-}
-
 static void sk_storage_map_free(struct bpf_map *map)
 {
 	struct bpf_local_storage_map *smap;
@@ -723,78 +227,6 @@ static void sk_storage_map_free(struct bpf_map *map)
 	bpf_local_storage_map_free(smap);
 }
 
-/* U16_MAX is much more than enough for sk local storage
- * considering a tcp_sock is ~2k.
- */
-#define BPF_LOCAL_STORAGE_MAX_VALUE_SIZE				\
-	min_t(u32,							\
-	      (KMALLOC_MAX_SIZE - MAX_BPF_STACK -			\
-	       sizeof(struct bpf_local_storage_elem)),			\
-	      (U16_MAX - sizeof(struct bpf_local_storage_elem)))
-
-int bpf_local_storage_map_alloc_check(union bpf_attr *attr)
-{
-	if (attr->map_flags & ~BPF_LOCAL_STORAGE_CREATE_FLAG_MASK ||
-	    !(attr->map_flags & BPF_F_NO_PREALLOC) ||
-	    attr->max_entries ||
-	    attr->key_size != sizeof(int) || !attr->value_size ||
-	    /* Enforce BTF for userspace sk dumping */
-	    !attr->btf_key_type_id || !attr->btf_value_type_id)
-		return -EINVAL;
-
-	if (!bpf_capable())
-		return -EPERM;
-
-	if (attr->value_size > BPF_LOCAL_STORAGE_MAX_VALUE_SIZE)
-		return -E2BIG;
-
-	return 0;
-}
-
-struct bpf_local_storage_map *bpf_local_storage_map_alloc(union bpf_attr *attr)
-{
-	struct bpf_local_storage_map *smap;
-	unsigned int i;
-	u32 nbuckets;
-	u64 cost;
-	int ret;
-
-	smap = kzalloc(sizeof(*smap), GFP_USER | __GFP_NOWARN);
-	if (!smap)
-		return ERR_PTR(-ENOMEM);
-	bpf_map_init_from_attr(&smap->map, attr);
-
-	nbuckets = roundup_pow_of_two(num_possible_cpus());
-	/* Use at least 2 buckets, select_bucket() is undefined behavior with 1 bucket */
-	nbuckets = max_t(u32, 2, nbuckets);
-	smap->bucket_log = ilog2(nbuckets);
-	cost = sizeof(*smap->buckets) * nbuckets + sizeof(*smap);
-
-	ret = bpf_map_charge_init(&smap->map.memory, cost);
-	if (ret < 0) {
-		kfree(smap);
-		return ERR_PTR(ret);
-	}
-
-	smap->buckets = kvcalloc(sizeof(*smap->buckets), nbuckets,
-				 GFP_USER | __GFP_NOWARN);
-	if (!smap->buckets) {
-		bpf_map_charge_finish(&smap->map.memory);
-		kfree(smap);
-		return ERR_PTR(-ENOMEM);
-	}
-
-	for (i = 0; i < nbuckets; i++) {
-		INIT_HLIST_HEAD(&smap->buckets[i].list);
-		raw_spin_lock_init(&smap->buckets[i].lock);
-	}
-
-	smap->elem_size =
-		sizeof(struct bpf_local_storage_elem) + attr->value_size;
-
-	return smap;
-}
-
 static struct bpf_map *sk_storage_map_alloc(union bpf_attr *attr)
 {
 	struct bpf_local_storage_map *smap;
@@ -813,23 +245,6 @@ static int notsupp_get_next_key(struct bpf_map *map, void *key,
 	return -ENOTSUPP;
 }
 
-int bpf_local_storage_map_check_btf(const struct bpf_map *map,
-				    const struct btf *btf,
-				    const struct btf_type *key_type,
-				    const struct btf_type *value_type)
-{
-	u32 int_data;
-
-	if (BTF_INFO_KIND(key_type->info) != BTF_KIND_INT)
-		return -EINVAL;
-
-	int_data = *(u32 *)(key_type + 1);
-	if (BTF_INT_BITS(int_data) != 32 || BTF_INT_OFFSET(int_data))
-		return -EINVAL;
-
-	return 0;
-}
-
 static void *bpf_fd_sk_storage_lookup_elem(struct bpf_map *map, void *key)
 {
 	struct bpf_local_storage_data *sdata;
-- 
2.28.0.rc0.105.gf9edc3c819-goog

