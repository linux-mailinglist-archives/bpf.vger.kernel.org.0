Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43EB821956E
	for <lists+bpf@lfdr.de>; Thu,  9 Jul 2020 02:57:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726323AbgGIA5T (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Jul 2020 20:57:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbgGIA5B (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Jul 2020 20:57:01 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BF0EC061A0B
        for <bpf@vger.kernel.org>; Wed,  8 Jul 2020 17:57:01 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id g75so155664wme.5
        for <bpf@vger.kernel.org>; Wed, 08 Jul 2020 17:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u6m8e30EuuqaGC96fhEBQgdiUeSD+Q6cBdexSZmuLkE=;
        b=mxLr5p+awW6F1X9EiQqZwXH12RuxBcxpC9OQEZ2+VljI58lIV+MzMXmuzdJnpHOquR
         HAjnAbh/8TJZnyn6QXw5oQL9E9/0U66LPohl4clkk6pt2TAtPgTOd5ACwP+B9FKMs97z
         JSCu9rz2POp7vuECXGRRvQfM8qNGYJVB/VG8E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u6m8e30EuuqaGC96fhEBQgdiUeSD+Q6cBdexSZmuLkE=;
        b=ozUQzqppeB8Ucqgm3g0wZF3hjlc921y7/6MzfHnirmrbNICdoRPfEq05crFPICXIQ3
         3y/5N8mnhmWc3MyZqUjcQ+t9s+qtX+0KHeW9Mqfvbi5IeAyIHFKyqjfvEj+W1Mtb2n7w
         1NvOb0Zh309mnKG3wyuhjmpNtcGWqvtqTJYxspDMgVhSgCBhN8jPBPU16d4w7nlX6tkW
         XVDy42etQstIGIJlInjpN+Huw5pCY6JPCiOhjd3AQMJktPCfl3LOaxMuT8it5Z+02mCk
         urZzc+7bvxy3F35j5MZX9ryTxCBBasrYcAFFsD8zCgCqQHGg2hVfq9Okt1b7vrFRtjC0
         JT3A==
X-Gm-Message-State: AOAM530czu0hPyzsATWVOpUrWEnVR0X5JjZqS/6nU5w368rzEdyUb8mg
        iOi1rFY4McJIN+K+GkQp4yBhfg==
X-Google-Smtp-Source: ABdhPJxhK6sk/snSlk83hfY01lw70BVKMMPl6VX11MrHInOZnEmDko/jD7V7EiryoXK8vwgaJUYh1g==
X-Received: by 2002:a1c:7f82:: with SMTP id a124mr10913758wmd.132.1594256218751;
        Wed, 08 Jul 2020 17:56:58 -0700 (PDT)
Received: from kpsingh.zrh.corp.google.com ([81.6.44.51])
        by smtp.gmail.com with ESMTPSA id f15sm2465498wrx.91.2020.07.08.17.56.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 17:56:58 -0700 (PDT)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>
Subject: [PATCH bpf-next v3 1/4] bpf: Generalize bpf_sk_storage
Date:   Thu,  9 Jul 2020 02:56:51 +0200
Message-Id: <20200709005654.3324272-2-kpsingh@chromium.org>
X-Mailer: git-send-email 2.27.0.389.gc38d7665816-goog
In-Reply-To: <20200709005654.3324272-1-kpsingh@chromium.org>
References: <20200709005654.3324272-1-kpsingh@chromium.org>
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

bpf_sk_storage is updated to be bpf_local_storage with a union that
contains a pointer to the owner object. The type of the
bpf_local_storage can be determined using the newly added
bpf_local_storage_type enum.

Each new local storage will still be a separate map and provide its own
set of helpers. This allows for future object specific extensions and
still share a lot of the underlying implementation.

Signed-off-by: KP Singh <kpsingh@google.com>
---
 include/linux/bpf.h               |  14 +
 include/linux/bpf_local_storage.h | 175 +++++++
 include/net/sock.h                |   4 +-
 include/uapi/linux/bpf.h          |  12 +-
 kernel/bpf/Makefile               |   1 +
 kernel/bpf/bpf_local_storage.c    | 517 +++++++++++++++++++
 net/core/bpf_sk_storage.c         | 804 ++++++------------------------
 tools/include/uapi/linux/bpf.h    |  12 +-
 8 files changed, 879 insertions(+), 660 deletions(-)
 create mode 100644 include/linux/bpf_local_storage.h
 create mode 100644 kernel/bpf/bpf_local_storage.c

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 0cd7f6884c5c..95ab7031cd8e 100644
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
@@ -93,6 +96,17 @@ struct bpf_map_ops {
 	__poll_t (*map_poll)(struct bpf_map *map, struct file *filp,
 			     struct poll_table_struct *pts);
 
+	/* Functions called by bpf_local_storage maps */
+	void (*map_local_storage_unlink)(struct bpf_local_storage *local_storage,
+					 bool uncharge_omem);
+	struct bpf_local_storage_elem *(*map_selem_alloc)(
+		struct bpf_local_storage_map *smap, void *owner, void *value,
+		bool charge_omem);
+	struct bpf_local_storage_data *(*map_local_storage_update)(
+		void  *owner, struct bpf_map *map, void *value, u64 flags);
+	int (*map_local_storage_alloc)(void *owner,
+				       struct bpf_local_storage_map *smap,
+				       struct bpf_local_storage_elem *elem);
 	/* BTF name and id of struct allocated by map_alloc */
 	const char * const map_btf_name;
 	int *map_btf_id;
diff --git a/include/linux/bpf_local_storage.h b/include/linux/bpf_local_storage.h
new file mode 100644
index 000000000000..605b81f2f806
--- /dev/null
+++ b/include/linux/bpf_local_storage.h
@@ -0,0 +1,175 @@
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
+#define LOCAL_STORAGE_CREATE_FLAG_MASK					\
+	(BPF_F_NO_PREALLOC | BPF_F_CLONE)
+
+struct bucket {
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
+	struct bucket *buckets;
+	u32 bucket_log;
+	u16 elem_size;
+	u16 cache_idx;
+};
+
+struct bpf_local_storage_data {
+	/* smap is used as the searching key when looking up
+	 * from the obejct's bpf_local_storage.
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
+#define SELEM(_SDATA) \
+	container_of((_SDATA), struct bpf_local_storage_elem, sdata)
+#define SDATA(_SELEM) (&(_SELEM)->sdata)
+#define BPF_STORAGE_CACHE_SIZE	16
+
+u16 bpf_ls_cache_idx_get(spinlock_t *cache_idx_lock,
+			   u64 *cache_idx_usage_count);
+
+void bpf_ls_cache_idx_free(spinlock_t *cache_idx_lock,
+			   u64 *cache_idx_usage_counts, u16 idx);
+
+#define DEFINE_BPF_STORAGE_CACHE(type)					\
+static DEFINE_SPINLOCK(cache_idx_lock_##type);				\
+static u64 cache_idx_usage_counts_##type[BPF_STORAGE_CACHE_SIZE];	\
+static u16 cache_idx_get_##type(void)					\
+{									\
+	return bpf_ls_cache_idx_get(&cache_idx_lock_##type,		\
+				    cache_idx_usage_counts_##type);	\
+}									\
+static void cache_idx_free_##type(u16 idx)				\
+{									\
+	return bpf_ls_cache_idx_free(&cache_idx_lock_##type,		\
+				     cache_idx_usage_counts_##type,	\
+				     idx);				\
+}
+
+/* U16_MAX is much more than enough for sk local storage
+ * considering a tcp_sock is ~2k.
+ */
+#define BPF_LOCAL_STORAGE_MAX_VALUE_SIZE				\
+	min_t(u32,							\
+	      (KMALLOC_MAX_SIZE - MAX_BPF_STACK -			\
+	       sizeof(struct bpf_local_storage_elem)),			\
+	      (U16_MAX - sizeof(struct bpf_local_storage_elem)))
+
+struct bpf_local_storage {
+	struct bpf_local_storage_data __rcu *cache[BPF_STORAGE_CACHE_SIZE];
+	struct hlist_head list;		/* List of bpf_local_storage_elem */
+	/* The object that owns the the above "list" of
+	 * bpf_local_storage_elem
+	 */
+	union {
+		struct sock *sk;
+	};
+	struct rcu_head rcu;
+	raw_spinlock_t lock;	/* Protect adding/removing from the "list" */
+};
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
+void bpf_selem_link(struct bpf_local_storage *local_storage,
+		    struct bpf_local_storage_elem *selem);
+
+bool bpf_selem_unlink(struct bpf_local_storage *local_storage,
+		      struct bpf_local_storage_elem *selem, bool uncharge_omem);
+
+void bpf_selem_unlink_map_elem(struct bpf_local_storage_elem *selem);
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
+#endif /* _BPF_LOCAL_STORAGE_H */
diff --git a/include/net/sock.h b/include/net/sock.h
index 84c813dd0152..5eada8a5eb21 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -245,7 +245,7 @@ struct sock_common {
 	/* public: */
 };
 
-struct bpf_sk_storage;
+struct bpf_local_storage;
 
 /**
   *	struct sock - network layer representation of sockets
@@ -516,7 +516,7 @@ struct sock {
 	void                    (*sk_destruct)(struct sock *sk);
 	struct sock_reuseport __rcu	*sk_reuseport_cb;
 #ifdef CONFIG_BPF_SYSCALL
-	struct bpf_sk_storage __rcu	*sk_bpf_storage;
+	struct bpf_local_storage __rcu	*sk_bpf_storage;
 #endif
 	struct rcu_head		sk_rcu;
 };
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 548a749aebb3..1f3e831c4813 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -2802,10 +2802,10 @@ union bpf_attr {
  *		"type". The bpf-local-storage "type" (i.e. the *map*) is
  *		searched against all bpf-local-storages residing at *sk*.
  *
- *		An optional *flags* (**BPF_SK_STORAGE_GET_F_CREATE**) can be
+ *		An optional *flags* (**BPF_LOCAL_STORAGE_GET_F_CREATE**) can be
  *		used such that a new bpf-local-storage will be
  *		created if one does not exist.  *value* can be used
- *		together with **BPF_SK_STORAGE_GET_F_CREATE** to specify
+ *		together with **BPF_LOCAL_STORAGE_GET_F_CREATE** to specify
  *		the initial value of a bpf-local-storage.  If *value* is
  *		**NULL**, the new bpf-local-storage will be zero initialized.
  *	Return
@@ -3572,9 +3572,13 @@ enum {
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
index 000000000000..c818eb6f8261
--- /dev/null
+++ b/kernel/bpf/bpf_local_storage.c
@@ -0,0 +1,517 @@
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
+#define SELEM(_SDATA)                                                          \
+	container_of((_SDATA), struct bpf_local_storage_elem, sdata)
+#define SDATA(_SELEM) (&(_SELEM)->sdata)
+
+static struct bucket *select_bucket(struct bpf_local_storage_map *smap,
+				    struct bpf_local_storage_elem *selem)
+{
+	return &smap->buckets[hash_ptr(selem, smap->bucket_log)];
+}
+
+static bool selem_linked_to_node(const struct bpf_local_storage_elem *selem)
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
+ *
+ * uncharge_omem is only relevant for BPF_MAP_TYPE_SK_STORAGE.
+ */
+bool bpf_selem_unlink(struct bpf_local_storage *local_storage,
+		      struct bpf_local_storage_elem *selem, bool uncharge_omem)
+{
+	struct bpf_local_storage_map *smap;
+	bool free_local_storage;
+
+	smap = rcu_dereference(SDATA(selem)->smap);
+	free_local_storage = hlist_is_singular_node(&selem->snode,
+						    &local_storage->list);
+
+	/* local_storage is not freed now.  local_storage->lock is
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
+	if (free_local_storage)
+		smap->map.ops->map_local_storage_unlink(local_storage,
+							uncharge_omem);
+
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
+void bpf_selem_link(struct bpf_local_storage *local_storage,
+		    struct bpf_local_storage_elem *selem)
+{
+	RCU_INIT_POINTER(selem->local_storage, local_storage);
+	hlist_add_head(&selem->snode, &local_storage->list);
+}
+
+void bpf_selem_unlink_map(struct bpf_local_storage_elem *selem)
+{
+	struct bpf_local_storage_map *smap;
+	struct bucket *b;
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
+	struct bucket *b = select_bucket(smap, selem);
+
+	raw_spin_lock_bh(&b->lock);
+	RCU_INIT_POINTER(SDATA(selem)->smap, smap);
+	hlist_add_head_rcu(&selem->map_node, &b->list);
+	raw_spin_unlock_bh(&b->lock);
+}
+
+void bpf_selem_unlink_map_elem(struct bpf_local_storage_elem *selem)
+{
+	struct bpf_local_storage *local_storage;
+	bool free_local_storage = false;
+
+	/* Always unlink from map before unlinking from local_storage
+	 * because selem will be freed after successfully unlinked from
+	 * the local_storage.
+	 */
+	bpf_selem_unlink_map(selem);
+
+	if (unlikely(!selem_linked_to_node(selem)))
+		/* selem has already been unlinked from its owner */
+		return;
+
+	local_storage = rcu_dereference(selem->local_storage);
+	raw_spin_lock_bh(&local_storage->lock);
+	if (likely(selem_linked_to_node(selem)))
+		free_local_storage =
+			bpf_selem_unlink(local_storage, selem, true);
+	raw_spin_unlock_bh(&local_storage->lock);
+
+	if (free_local_storage)
+		kfree_rcu(local_storage, rcu);
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
+		if (selem_linked_to_node(selem))
+			rcu_assign_pointer(
+				local_storage->cache[smap->cache_idx], sdata);
+		raw_spin_unlock_bh(&local_storage->lock);
+	}
+
+	return sdata;
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
+		if (old_sdata && selem_linked_to_node(SELEM(old_sdata))) {
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
+	bpf_selem_link(local_storage, selem);
+
+	/* Third, remove old selem, SELEM(old_sdata) */
+	if (old_sdata) {
+		bpf_selem_unlink_map(SELEM(old_sdata));
+		bpf_selem_unlink(local_storage, SELEM(old_sdata), false);
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
+u16 bpf_ls_cache_idx_get(spinlock_t *cache_idx_lock,
+			 u64 *cache_idx_usage_counts)
+{
+	u64 min_usage = U64_MAX;
+	u16 i, res = 0;
+
+	spin_lock(cache_idx_lock);
+
+	for (i = 0; i < BPF_STORAGE_CACHE_SIZE; i++) {
+		if (cache_idx_usage_counts[i] < min_usage) {
+			min_usage = cache_idx_usage_counts[i];
+			res = i;
+
+			/* Found a free cache_idx */
+			if (!min_usage)
+				break;
+		}
+	}
+	cache_idx_usage_counts[res]++;
+
+	spin_unlock(cache_idx_lock);
+
+	return res;
+}
+
+void bpf_ls_cache_idx_free(spinlock_t *cache_idx_lock,
+			   u64 *cache_idx_usage_counts, u16 idx)
+{
+	spin_lock(cache_idx_lock);
+	cache_idx_usage_counts[idx]--;
+	spin_unlock(cache_idx_lock);
+}
+
+void bpf_local_storage_map_free(struct bpf_local_storage_map *smap)
+{
+	struct bpf_local_storage_elem *selem;
+	struct bucket *b;
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
+			bpf_selem_unlink_map_elem(selem);
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
+	if (attr->map_flags & ~LOCAL_STORAGE_CREATE_FLAG_MASK ||
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
index 6f921c4ddc2c..62b6526acf7e 100644
--- a/net/core/bpf_sk_storage.c
+++ b/net/core/bpf_sk_storage.c
@@ -1,103 +1,19 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2019 Facebook  */
+#include "linux/bpf.h"
+#include "asm-generic/bug.h"
+#include "linux/err.h"
 #include <linux/rculist.h>
 #include <linux/list.h>
 #include <linux/hash.h>
 #include <linux/types.h>
 #include <linux/spinlock.h>
 #include <linux/bpf.h>
-#include <net/bpf_sk_storage.h>
+#include <linux/bpf_local_storage.h>
 #include <net/sock.h>
 #include <uapi/linux/sock_diag.h>
 #include <uapi/linux/btf.h>
 
-#define SK_STORAGE_CREATE_FLAG_MASK					\
-	(BPF_F_NO_PREALLOC | BPF_F_CLONE)
-
-struct bucket {
-	struct hlist_head list;
-	raw_spinlock_t lock;
-};
-
-/* Thp map is not the primary owner of a bpf_sk_storage_elem.
- * Instead, the sk->sk_bpf_storage is.
- *
- * The map (bpf_sk_storage_map) is for two purposes
- * 1. Define the size of the "sk local storage".  It is
- *    the map's value_size.
- *
- * 2. Maintain a list to keep track of all elems such
- *    that they can be cleaned up during the map destruction.
- *
- * When a bpf local storage is being looked up for a
- * particular sk,  the "bpf_map" pointer is actually used
- * as the "key" to search in the list of elem in
- * sk->sk_bpf_storage.
- *
- * Hence, consider sk->sk_bpf_storage is the mini-map
- * with the "bpf_map" pointer as the searching key.
- */
-struct bpf_sk_storage_map {
-	struct bpf_map map;
-	/* Lookup elem does not require accessing the map.
-	 *
-	 * Updating/Deleting requires a bucket lock to
-	 * link/unlink the elem from the map.  Having
-	 * multiple buckets to improve contention.
-	 */
-	struct bucket *buckets;
-	u32 bucket_log;
-	u16 elem_size;
-	u16 cache_idx;
-};
-
-struct bpf_sk_storage_data {
-	/* smap is used as the searching key when looking up
-	 * from sk->sk_bpf_storage.
-	 *
-	 * Put it in the same cacheline as the data to minimize
-	 * the number of cachelines access during the cache hit case.
-	 */
-	struct bpf_sk_storage_map __rcu *smap;
-	u8 data[] __aligned(8);
-};
-
-/* Linked to bpf_sk_storage and bpf_sk_storage_map */
-struct bpf_sk_storage_elem {
-	struct hlist_node map_node;	/* Linked to bpf_sk_storage_map */
-	struct hlist_node snode;	/* Linked to bpf_sk_storage */
-	struct bpf_sk_storage __rcu *sk_storage;
-	struct rcu_head rcu;
-	/* 8 bytes hole */
-	/* The data is stored in aother cacheline to minimize
-	 * the number of cachelines access during a cache hit.
-	 */
-	struct bpf_sk_storage_data sdata ____cacheline_aligned;
-};
-
-#define SELEM(_SDATA) container_of((_SDATA), struct bpf_sk_storage_elem, sdata)
-#define SDATA(_SELEM) (&(_SELEM)->sdata)
-#define BPF_SK_STORAGE_CACHE_SIZE	16
-
-static DEFINE_SPINLOCK(cache_idx_lock);
-static u64 cache_idx_usage_counts[BPF_SK_STORAGE_CACHE_SIZE];
-
-struct bpf_sk_storage {
-	struct bpf_sk_storage_data __rcu *cache[BPF_SK_STORAGE_CACHE_SIZE];
-	struct hlist_head list;	/* List of bpf_sk_storage_elem */
-	struct sock *sk;	/* The sk that owns the the above "list" of
-				 * bpf_sk_storage_elem.
-				 */
-	struct rcu_head rcu;
-	raw_spinlock_t lock;	/* Protect adding/removing from the "list" */
-};
-
-static struct bucket *select_bucket(struct bpf_sk_storage_map *smap,
-				    struct bpf_sk_storage_elem *selem)
-{
-	return &smap->buckets[hash_ptr(selem, smap->bucket_log)];
-}
-
 static int omem_charge(struct sock *sk, unsigned int size)
 {
 	/* same check as in sock_kmalloc() */
@@ -110,31 +26,19 @@ static int omem_charge(struct sock *sk, unsigned int size)
 	return -ENOMEM;
 }
 
-static bool selem_linked_to_sk(const struct bpf_sk_storage_elem *selem)
-{
-	return !hlist_unhashed(&selem->snode);
-}
-
-static bool selem_linked_to_map(const struct bpf_sk_storage_elem *selem)
+static struct bpf_local_storage_elem *
+sk_selem_alloc(struct bpf_local_storage_map *smap, void *owner, void *value,
+	       bool charge_omem)
 {
-	return !hlist_unhashed(&selem->map_node);
-}
-
-static struct bpf_sk_storage_elem *selem_alloc(struct bpf_sk_storage_map *smap,
-					       struct sock *sk, void *value,
-					       bool charge_omem)
-{
-	struct bpf_sk_storage_elem *selem;
+	struct bpf_local_storage_elem *selem;
+	struct sock *sk = owner;
 
 	if (charge_omem && omem_charge(sk, smap->elem_size))
 		return NULL;
 
-	selem = kzalloc(smap->elem_size, GFP_ATOMIC | __GFP_NOWARN);
-	if (selem) {
-		if (value)
-			memcpy(SDATA(selem)->data, value, smap->map.value_size);
+	selem = bpf_selem_alloc(smap, value);
+	if (selem)
 		return selem;
-	}
 
 	if (charge_omem)
 		atomic_sub(smap->elem_size, &sk->sk_omem_alloc);
@@ -142,242 +46,53 @@ static struct bpf_sk_storage_elem *selem_alloc(struct bpf_sk_storage_map *smap,
 	return NULL;
 }
 
-/* sk_storage->lock must be held and selem->sk_storage == sk_storage.
- * The caller must ensure selem->smap is still valid to be
- * dereferenced for its smap->elem_size and smap->cache_idx.
- */
-static bool __selem_unlink_sk(struct bpf_sk_storage *sk_storage,
-			      struct bpf_sk_storage_elem *selem,
+static void unlink_sk_storage(struct bpf_local_storage *local_storage,
 			      bool uncharge_omem)
 {
-	struct bpf_sk_storage_map *smap;
-	bool free_sk_storage;
-	struct sock *sk;
-
-	smap = rcu_dereference(SDATA(selem)->smap);
-	sk = sk_storage->sk;
+	struct sock *sk = local_storage->sk;
 
-	/* All uncharging on sk->sk_omem_alloc must be done first.
-	 * sk may be freed once the last selem is unlinked from sk_storage.
-	 */
 	if (uncharge_omem)
-		atomic_sub(smap->elem_size, &sk->sk_omem_alloc);
-
-	free_sk_storage = hlist_is_singular_node(&selem->snode,
-						 &sk_storage->list);
-	if (free_sk_storage) {
-		atomic_sub(sizeof(struct bpf_sk_storage), &sk->sk_omem_alloc);
-		sk_storage->sk = NULL;
-		/* After this RCU_INIT, sk may be freed and cannot be used */
-		RCU_INIT_POINTER(sk->sk_bpf_storage, NULL);
-
-		/* sk_storage is not freed now.  sk_storage->lock is
-		 * still held and raw_spin_unlock_bh(&sk_storage->lock)
-		 * will be done by the caller.
-		 *
-		 * Although the unlock will be done under
-		 * rcu_read_lock(),  it is more intutivie to
-		 * read if kfree_rcu(sk_storage, rcu) is done
-		 * after the raw_spin_unlock_bh(&sk_storage->lock).
-		 *
-		 * Hence, a "bool free_sk_storage" is returned
-		 * to the caller which then calls the kfree_rcu()
-		 * after unlock.
-		 */
-	}
-	hlist_del_init_rcu(&selem->snode);
-	if (rcu_access_pointer(sk_storage->cache[smap->cache_idx]) ==
-	    SDATA(selem))
-		RCU_INIT_POINTER(sk_storage->cache[smap->cache_idx], NULL);
-
-	kfree_rcu(selem, rcu);
-
-	return free_sk_storage;
-}
-
-static void selem_unlink_sk(struct bpf_sk_storage_elem *selem)
-{
-	struct bpf_sk_storage *sk_storage;
-	bool free_sk_storage = false;
-
-	if (unlikely(!selem_linked_to_sk(selem)))
-		/* selem has already been unlinked from sk */
-		return;
-
-	sk_storage = rcu_dereference(selem->sk_storage);
-	raw_spin_lock_bh(&sk_storage->lock);
-	if (likely(selem_linked_to_sk(selem)))
-		free_sk_storage = __selem_unlink_sk(sk_storage, selem, true);
-	raw_spin_unlock_bh(&sk_storage->lock);
-
-	if (free_sk_storage)
-		kfree_rcu(sk_storage, rcu);
-}
+		atomic_sub(sizeof(struct bpf_local_storage),
+			   &sk->sk_omem_alloc);
 
-static void __selem_link_sk(struct bpf_sk_storage *sk_storage,
-			    struct bpf_sk_storage_elem *selem)
-{
-	RCU_INIT_POINTER(selem->sk_storage, sk_storage);
-	hlist_add_head(&selem->snode, &sk_storage->list);
+	/* After this RCU_INIT, sk may be freed and cannot be used */
+	RCU_INIT_POINTER(sk->sk_bpf_storage, NULL);
+	local_storage->sk = NULL;
 }
 
-static void selem_unlink_map(struct bpf_sk_storage_elem *selem)
+static int sk_storage_alloc(void *owner,
+			    struct bpf_local_storage_map *smap,
+			    struct bpf_local_storage_elem *first_selem)
 {
-	struct bpf_sk_storage_map *smap;
-	struct bucket *b;
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
-static void selem_link_map(struct bpf_sk_storage_map *smap,
-			   struct bpf_sk_storage_elem *selem)
-{
-	struct bucket *b = select_bucket(smap, selem);
-
-	raw_spin_lock_bh(&b->lock);
-	RCU_INIT_POINTER(SDATA(selem)->smap, smap);
-	hlist_add_head_rcu(&selem->map_node, &b->list);
-	raw_spin_unlock_bh(&b->lock);
-}
-
-static void selem_unlink(struct bpf_sk_storage_elem *selem)
-{
-	/* Always unlink from map before unlinking from sk_storage
-	 * because selem will be freed after successfully unlinked from
-	 * the sk_storage.
-	 */
-	selem_unlink_map(selem);
-	selem_unlink_sk(selem);
-}
-
-static struct bpf_sk_storage_data *
-__sk_storage_lookup(struct bpf_sk_storage *sk_storage,
-		    struct bpf_sk_storage_map *smap,
-		    bool cacheit_lockit)
-{
-	struct bpf_sk_storage_data *sdata;
-	struct bpf_sk_storage_elem *selem;
-
-	/* Fast path (cache hit) */
-	sdata = rcu_dereference(sk_storage->cache[smap->cache_idx]);
-	if (sdata && rcu_access_pointer(sdata->smap) == smap)
-		return sdata;
-
-	/* Slow path (cache miss) */
-	hlist_for_each_entry_rcu(selem, &sk_storage->list, snode)
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
-		 * problem in the next __sk_storage_lookup().
-		 */
-		raw_spin_lock_bh(&sk_storage->lock);
-		if (selem_linked_to_sk(selem))
-			rcu_assign_pointer(sk_storage->cache[smap->cache_idx],
-					   sdata);
-		raw_spin_unlock_bh(&sk_storage->lock);
-	}
-
-	return sdata;
-}
-
-static struct bpf_sk_storage_data *
-sk_storage_lookup(struct sock *sk, struct bpf_map *map, bool cacheit_lockit)
-{
-	struct bpf_sk_storage *sk_storage;
-	struct bpf_sk_storage_map *smap;
-
-	sk_storage = rcu_dereference(sk->sk_bpf_storage);
-	if (!sk_storage)
-		return NULL;
-
-	smap = (struct bpf_sk_storage_map *)map;
-	return __sk_storage_lookup(sk_storage, smap, cacheit_lockit);
-}
-
-static int check_flags(const struct bpf_sk_storage_data *old_sdata,
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
-static int sk_storage_alloc(struct sock *sk,
-			    struct bpf_sk_storage_map *smap,
-			    struct bpf_sk_storage_elem *first_selem)
-{
-	struct bpf_sk_storage *prev_sk_storage, *sk_storage;
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
-	sk_storage->sk = sk;
-
-	__selem_link_sk(sk_storage, first_selem);
-	selem_link_map(smap, first_selem);
-	/* Publish sk_storage to sk.  sk->sk_lock cannot be acquired.
-	 * Hence, atomic ops is used to set sk->sk_bpf_storage
-	 * from NULL to the newly allocated sk_storage ptr.
-	 *
-	 * From now on, the sk->sk_bpf_storage pointer is protected
-	 * by the sk_storage->lock.  Hence,  when freeing
-	 * the sk->sk_bpf_storage, the sk_storage->lock must
-	 * be held before setting sk->sk_bpf_storage to NULL.
-	 */
-	prev_sk_storage = cmpxchg((struct bpf_sk_storage **)&sk->sk_bpf_storage,
-				  NULL, sk_storage);
-	if (unlikely(prev_sk_storage)) {
-		selem_unlink_map(first_selem);
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
+	curr->sk = sk;
+
+	bpf_selem_link(curr, first_selem);
+	bpf_selem_link_map(smap, first_selem);
+
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
 
@@ -386,36 +101,31 @@ static int sk_storage_alloc(struct sock *sk,
  * Otherwise, it will become a leak (and other memory issues
  * during map destruction).
  */
-static struct bpf_sk_storage_data *sk_storage_update(struct sock *sk,
-						     struct bpf_map *map,
-						     void *value,
-						     u64 map_flags)
+static struct bpf_local_storage_data *
+sk_storage_update(void *owner, struct bpf_map *map, void *value, u64 map_flags)
 {
-	struct bpf_sk_storage_data *old_sdata = NULL;
-	struct bpf_sk_storage_elem *selem;
-	struct bpf_sk_storage *sk_storage;
-	struct bpf_sk_storage_map *smap;
+	struct bpf_local_storage_data *old_sdata = NULL;
+	struct bpf_local_storage_elem *selem;
+	struct bpf_local_storage *local_storage;
+	struct bpf_local_storage_map *smap;
+	struct sock *sk;
 	int err;
 
-	/* BPF_EXIST and BPF_NOEXIST cannot be both set */
-	if (unlikely((map_flags & ~BPF_F_LOCK) > BPF_EXIST) ||
-	    /* BPF_F_LOCK can only be used in a value with spin_lock */
-	    unlikely((map_flags & BPF_F_LOCK) && !map_value_has_spin_lock(map)))
-		return ERR_PTR(-EINVAL);
+	err = bpf_local_storage_check_update_flags(map, map_flags);
+	if (err)
+		return ERR_PTR(err);
 
-	smap = (struct bpf_sk_storage_map *)map;
-	sk_storage = rcu_dereference(sk->sk_bpf_storage);
-	if (!sk_storage || hlist_empty(&sk_storage->list)) {
-		/* Very first elem for this sk */
-		err = check_flags(NULL, map_flags);
-		if (err)
-			return ERR_PTR(err);
+	sk = owner;
+	local_storage = rcu_dereference(sk->sk_bpf_storage);
+	smap = (struct bpf_local_storage_map *)map;
 
-		selem = selem_alloc(smap, sk, value, true);
+	if (!local_storage || hlist_empty(&local_storage->list)) {
+		/* Very first elem */
+		selem = map->ops->map_selem_alloc(smap, owner, value, !old_sdata);
 		if (!selem)
 			return ERR_PTR(-ENOMEM);
 
-		err = sk_storage_alloc(sk, smap, selem);
+		err = map->ops->map_local_storage_alloc(owner, smap, selem);
 		if (err) {
 			kfree(selem);
 			atomic_sub(smap->elem_size, &sk->sk_omem_alloc);
@@ -425,130 +135,42 @@ static struct bpf_sk_storage_data *sk_storage_update(struct sock *sk,
 		return SDATA(selem);
 	}
 
-	if ((map_flags & BPF_F_LOCK) && !(map_flags & BPF_NOEXIST)) {
-		/* Hoping to find an old_sdata to do inline update
-		 * such that it can avoid taking the sk_storage->lock
-		 * and changing the lists.
-		 */
-		old_sdata = __sk_storage_lookup(sk_storage, smap, false);
-		err = check_flags(old_sdata, map_flags);
-		if (err)
-			return ERR_PTR(err);
-		if (old_sdata && selem_linked_to_sk(SELEM(old_sdata))) {
-			copy_map_value_locked(map, old_sdata->data,
-					      value, false);
-			return old_sdata;
-		}
-	}
-
-	raw_spin_lock_bh(&sk_storage->lock);
-
-	/* Recheck sk_storage->list under sk_storage->lock */
-	if (unlikely(hlist_empty(&sk_storage->list))) {
-		/* A parallel del is happening and sk_storage is going
-		 * away.  It has just been checked before, so very
-		 * unlikely.  Return instead of retry to keep things
-		 * simple.
-		 */
-		err = -EAGAIN;
-		goto unlock_err;
-	}
-
-	old_sdata = __sk_storage_lookup(sk_storage, smap, false);
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
-	/* sk_storage->lock is held.  Hence, we are sure
-	 * we can unlink and uncharge the old_sdata successfully
-	 * later.  Hence, instead of charging the new selem now
-	 * and then uncharge the old selem later (which may cause
-	 * a potential but unnecessary charge failure),  avoid taking
-	 * a charge at all here (the "!old_sdata" check) and the
-	 * old_sdata will not be uncharged later during __selem_unlink_sk().
-	 */
-	selem = selem_alloc(smap, sk, value, !old_sdata);
-	if (!selem) {
-		err = -ENOMEM;
-		goto unlock_err;
-	}
-
-	/* First, link the new selem to the map */
-	selem_link_map(smap, selem);
-
-	/* Second, link (and publish) the new selem to sk_storage */
-	__selem_link_sk(sk_storage, selem);
+	return bpf_local_storage_update(owner, map, local_storage, value,
+					map_flags);
+}
 
-	/* Third, remove old selem, SELEM(old_sdata) */
-	if (old_sdata) {
-		selem_unlink_map(SELEM(old_sdata));
-		__selem_unlink_sk(sk_storage, SELEM(old_sdata), false);
-	}
+static struct bpf_local_storage_data *
+sk_storage_lookup(struct sock *sk, struct bpf_map *map, bool cacheit_lockit)
+{
+	struct bpf_local_storage *sk_storage;
+	struct bpf_local_storage_map *smap;
 
-unlock:
-	raw_spin_unlock_bh(&sk_storage->lock);
-	return SDATA(selem);
+	sk_storage = rcu_dereference(sk->sk_bpf_storage);
+	if (!sk_storage)
+		return NULL;
 
-unlock_err:
-	raw_spin_unlock_bh(&sk_storage->lock);
-	return ERR_PTR(err);
+	smap = (struct bpf_local_storage_map *)map;
+	return bpf_local_storage_lookup(sk_storage, smap, cacheit_lockit);
 }
 
 static int sk_storage_delete(struct sock *sk, struct bpf_map *map)
 {
-	struct bpf_sk_storage_data *sdata;
+	struct bpf_local_storage_data *sdata;
 
 	sdata = sk_storage_lookup(sk, map, false);
 	if (!sdata)
 		return -ENOENT;
 
-	selem_unlink(SELEM(sdata));
+	bpf_selem_unlink_map_elem(SELEM(sdata));
 
 	return 0;
 }
 
-static u16 cache_idx_get(void)
-{
-	u64 min_usage = U64_MAX;
-	u16 i, res = 0;
-
-	spin_lock(&cache_idx_lock);
-
-	for (i = 0; i < BPF_SK_STORAGE_CACHE_SIZE; i++) {
-		if (cache_idx_usage_counts[i] < min_usage) {
-			min_usage = cache_idx_usage_counts[i];
-			res = i;
-
-			/* Found a free cache_idx */
-			if (!min_usage)
-				break;
-		}
-	}
-	cache_idx_usage_counts[res]++;
-
-	spin_unlock(&cache_idx_lock);
-
-	return res;
-}
-
-static void cache_idx_free(u16 idx)
-{
-	spin_lock(&cache_idx_lock);
-	cache_idx_usage_counts[idx]--;
-	spin_unlock(&cache_idx_lock);
-}
-
 /* Called by __sk_destruct() & bpf_sk_storage_clone() */
 void bpf_sk_storage_free(struct sock *sk)
 {
-	struct bpf_sk_storage_elem *selem;
-	struct bpf_sk_storage *sk_storage;
+	struct bpf_local_storage_elem *selem;
+	struct bpf_local_storage *sk_storage;
 	bool free_sk_storage = false;
 	struct hlist_node *n;
 
@@ -562,9 +184,9 @@ void bpf_sk_storage_free(struct sock *sk)
 	/* Netiher the bpf_prog nor the bpf-map's syscall
 	 * could be modifying the sk_storage->list now.
 	 * Thus, no elem can be added-to or deleted-from the
-	 * sk_storage->list by the bpf_prog or by the bpf-map's syscall.
+	 * local_storage->list by the bpf_prog or by the bpf-map's syscall.
 	 *
-	 * It is racing with bpf_sk_storage_map_free() alone
+	 * It is racing with bpf_local_storage_map_free() alone
 	 * when unlinking elem from the sk_storage->list and
 	 * the map's bucket->list.
 	 */
@@ -573,8 +195,8 @@ void bpf_sk_storage_free(struct sock *sk)
 		/* Always unlink from map before unlinking from
 		 * sk_storage.
 		 */
-		selem_unlink_map(selem);
-		free_sk_storage = __selem_unlink_sk(sk_storage, selem, true);
+		bpf_selem_unlink_map(selem);
+		free_sk_storage = bpf_selem_unlink(sk_storage, selem, true);
 	}
 	raw_spin_unlock_bh(&sk_storage->lock);
 	rcu_read_unlock();
@@ -583,163 +205,11 @@ void bpf_sk_storage_free(struct sock *sk)
 		kfree_rcu(sk_storage, rcu);
 }
 
-static void bpf_sk_storage_map_free(struct bpf_map *map)
+static void *bpf_sk_storage_lookup_elem(struct bpf_map *map, void *key)
 {
-	struct bpf_sk_storage_elem *selem;
-	struct bpf_sk_storage_map *smap;
-	struct bucket *b;
-	unsigned int i;
-
-	smap = (struct bpf_sk_storage_map *)map;
-
-	cache_idx_free(smap->cache_idx);
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
-	 * to the sk->sk_bpf_storage or to the map bucket's list.
-	 *
-	 * The elem of this map can be cleaned up here
-	 * or
-	 * by bpf_sk_storage_free() during __sk_destruct().
-	 */
-	for (i = 0; i < (1U << smap->bucket_log); i++) {
-		b = &smap->buckets[i];
-
-		rcu_read_lock();
-		/* No one is adding to b->list now */
-		while ((selem = hlist_entry_safe(rcu_dereference_raw(hlist_first_rcu(&b->list)),
-						 struct bpf_sk_storage_elem,
-						 map_node))) {
-			selem_unlink(selem);
-			cond_resched_rcu();
-		}
-		rcu_read_unlock();
-	}
-
-	/* bpf_sk_storage_free() may still need to access the map.
-	 * e.g. bpf_sk_storage_free() has unlinked selem from the map
-	 * which then made the above while((selem = ...)) loop
-	 * exited immediately.
-	 *
-	 * However, the bpf_sk_storage_free() still needs to access
-	 * the smap->elem_size to do the uncharging in
-	 * __selem_unlink_sk().
-	 *
-	 * Hence, wait another rcu grace period for the
-	 * bpf_sk_storage_free() to finish.
-	 */
-	synchronize_rcu();
-
-	kvfree(smap->buckets);
-	kfree(map);
-}
-
-/* U16_MAX is much more than enough for sk local storage
- * considering a tcp_sock is ~2k.
- */
-#define MAX_VALUE_SIZE							\
-	min_t(u32,							\
-	      (KMALLOC_MAX_SIZE - MAX_BPF_STACK - sizeof(struct bpf_sk_storage_elem)), \
-	      (U16_MAX - sizeof(struct bpf_sk_storage_elem)))
-
-static int bpf_sk_storage_map_alloc_check(union bpf_attr *attr)
-{
-	if (attr->map_flags & ~SK_STORAGE_CREATE_FLAG_MASK ||
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
-	if (attr->value_size > MAX_VALUE_SIZE)
-		return -E2BIG;
-
-	return 0;
-}
-
-static struct bpf_map *bpf_sk_storage_map_alloc(union bpf_attr *attr)
-{
-	struct bpf_sk_storage_map *smap;
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
-	smap->elem_size = sizeof(struct bpf_sk_storage_elem) + attr->value_size;
-	smap->cache_idx = cache_idx_get();
-
-	return &smap->map;
-}
-
-static int notsupp_get_next_key(struct bpf_map *map, void *key,
-				void *next_key)
-{
-	return -ENOTSUPP;
-}
-
-static int bpf_sk_storage_map_check_btf(const struct bpf_map *map,
-					const struct btf *btf,
-					const struct btf_type *key_type,
-					const struct btf_type *value_type)
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
-static void *bpf_fd_sk_storage_lookup_elem(struct bpf_map *map, void *key)
-{
-	struct bpf_sk_storage_data *sdata;
+	struct bpf_local_storage_data *sdata;
 	struct socket *sock;
-	int fd, err;
+	int fd, err = -EINVAL;
 
 	fd = *(int *)key;
 	sock = sockfd_lookup(fd, &err);
@@ -752,17 +222,18 @@ static void *bpf_fd_sk_storage_lookup_elem(struct bpf_map *map, void *key)
 	return ERR_PTR(err);
 }
 
-static int bpf_fd_sk_storage_update_elem(struct bpf_map *map, void *key,
-					 void *value, u64 map_flags)
+static int bpf_sk_storage_update_elem(struct bpf_map *map, void *key,
+				      void *value, u64 map_flags)
 {
-	struct bpf_sk_storage_data *sdata;
+	struct bpf_local_storage_data *sdata;
 	struct socket *sock;
 	int fd, err;
 
 	fd = *(int *)key;
 	sock = sockfd_lookup(fd, &err);
 	if (sock) {
-		sdata = sk_storage_update(sock->sk, map, value, map_flags);
+		sdata = map->ops->map_local_storage_update(sock->sk, map, value,
+							   map_flags);
 		sockfd_put(sock);
 		return PTR_ERR_OR_ZERO(sdata);
 	}
@@ -770,7 +241,7 @@ static int bpf_fd_sk_storage_update_elem(struct bpf_map *map, void *key,
 	return err;
 }
 
-static int bpf_fd_sk_storage_delete_elem(struct bpf_map *map, void *key)
+static int bpf_sk_storage_delete_elem(struct bpf_map *map, void *key)
 {
 	struct socket *sock;
 	int fd, err;
@@ -780,20 +251,19 @@ static int bpf_fd_sk_storage_delete_elem(struct bpf_map *map, void *key)
 	if (sock) {
 		err = sk_storage_delete(sock->sk, map);
 		sockfd_put(sock);
-		return err;
 	}
 
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
+	copy_selem = sk_selem_alloc(smap, newsk, NULL, true);
 	if (!copy_selem)
 		return NULL;
 
@@ -809,9 +279,9 @@ bpf_sk_storage_clone_elem(struct sock *newsk,
 
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
@@ -823,8 +293,8 @@ int bpf_sk_storage_clone(const struct sock *sk, struct sock *newsk)
 		goto out;
 
 	hlist_for_each_entry_rcu(selem, &sk_storage->list, snode) {
-		struct bpf_sk_storage_elem *copy_selem;
-		struct bpf_sk_storage_map *smap;
+		struct bpf_local_storage_elem *copy_selem;
+		struct bpf_local_storage_map *smap;
 		struct bpf_map *map;
 
 		smap = rcu_dereference(SDATA(selem)->smap);
@@ -832,7 +302,7 @@ int bpf_sk_storage_clone(const struct sock *sk, struct sock *newsk)
 			continue;
 
 		/* Note that for lockless listeners adding new element
-		 * here can race with cleanup in bpf_sk_storage_map_free.
+		 * here can race with cleanup in bpf_local_storage_map_free.
 		 * Try to grab map refcnt to make sure that it's still
 		 * alive and prevent concurrent removal.
 		 */
@@ -848,8 +318,8 @@ int bpf_sk_storage_clone(const struct sock *sk, struct sock *newsk)
 		}
 
 		if (new_sk_storage) {
-			selem_link_map(smap, copy_selem);
-			__selem_link_sk(new_sk_storage, copy_selem);
+			bpf_selem_link_map(smap, copy_selem);
+			bpf_selem_link(new_sk_storage, copy_selem);
 		} else {
 			ret = sk_storage_alloc(newsk, smap, copy_selem);
 			if (ret) {
@@ -860,7 +330,8 @@ int bpf_sk_storage_clone(const struct sock *sk, struct sock *newsk)
 				goto out;
 			}
 
-			new_sk_storage = rcu_dereference(copy_selem->sk_storage);
+			new_sk_storage =
+				rcu_dereference(copy_selem->local_storage);
 		}
 		bpf_map_put(map);
 	}
@@ -869,7 +340,7 @@ int bpf_sk_storage_clone(const struct sock *sk, struct sock *newsk)
 	rcu_read_unlock();
 
 	/* In case of an error, don't free anything explicitly here, the
-	 * caller is responsible to call bpf_sk_storage_free.
+	 * caller is responsible to call bpf_local_storage_free.
 	 */
 
 	return ret;
@@ -878,7 +349,7 @@ int bpf_sk_storage_clone(const struct sock *sk, struct sock *newsk)
 BPF_CALL_4(bpf_sk_storage_get, struct bpf_map *, map, struct sock *, sk,
 	   void *, value, u64, flags)
 {
-	struct bpf_sk_storage_data *sdata;
+	struct bpf_local_storage_data *sdata;
 
 	if (flags > BPF_SK_STORAGE_GET_F_CREATE)
 		return (unsigned long)NULL;
@@ -887,7 +358,7 @@ BPF_CALL_4(bpf_sk_storage_get, struct bpf_map *, map, struct sock *, sk,
 	if (sdata)
 		return (unsigned long)sdata->data;
 
-	if (flags == BPF_SK_STORAGE_GET_F_CREATE &&
+	if (flags == BPF_LOCAL_STORAGE_GET_F_CREATE &&
 	    /* Cannot add new elem to a going away sk.
 	     * Otherwise, the new elem may become a leak
 	     * (and also other memory issues during map
@@ -919,18 +390,51 @@ BPF_CALL_2(bpf_sk_storage_delete, struct bpf_map *, map, struct sock *, sk)
 	return -ENOENT;
 }
 
+static int notsupp_get_next_key(struct bpf_map *map, void *key,
+				void *next_key)
+{
+	return -ENOTSUPP;
+}
+
+DEFINE_BPF_STORAGE_CACHE(sk);
+
+struct bpf_map *sk_storage_map_alloc(union bpf_attr *attr)
+{
+	struct bpf_local_storage_map *smap;
+
+	smap = bpf_local_storage_map_alloc(attr);
+	if (IS_ERR(smap))
+		return ERR_CAST(smap);
+
+	smap->cache_idx = cache_idx_get_sk();
+	return &smap->map;
+}
+
+void sk_storage_map_free(struct bpf_map *map)
+{
+	struct bpf_local_storage_map *smap;
+
+	smap = (struct bpf_local_storage_map *)map;
+	cache_idx_free_sk(smap->cache_idx);
+	bpf_local_storage_map_free(smap);
+}
+
 static int sk_storage_map_btf_id;
 const struct bpf_map_ops sk_storage_map_ops = {
-	.map_alloc_check = bpf_sk_storage_map_alloc_check,
-	.map_alloc = bpf_sk_storage_map_alloc,
-	.map_free = bpf_sk_storage_map_free,
+	.map_alloc_check = bpf_local_storage_map_alloc_check,
+	.map_alloc = sk_storage_map_alloc,
+	.map_free = sk_storage_map_free,
 	.map_get_next_key = notsupp_get_next_key,
-	.map_lookup_elem = bpf_fd_sk_storage_lookup_elem,
-	.map_update_elem = bpf_fd_sk_storage_update_elem,
-	.map_delete_elem = bpf_fd_sk_storage_delete_elem,
-	.map_check_btf = bpf_sk_storage_map_check_btf,
-	.map_btf_name = "bpf_sk_storage_map",
+	.map_lookup_elem = bpf_sk_storage_lookup_elem,
+	.map_update_elem = bpf_sk_storage_update_elem,
+	.map_delete_elem = bpf_sk_storage_delete_elem,
+	.map_check_btf = bpf_local_storage_map_check_btf,
+	.map_btf_name = "bpf_local_storage_map",
 	.map_btf_id = &sk_storage_map_btf_id,
+	.map_local_storage_alloc = sk_storage_alloc,
+	.map_selem_alloc = sk_selem_alloc,
+	.map_local_storage_update = sk_storage_update,
+	.map_local_storage_unlink = unlink_sk_storage,
 };
 
 const struct bpf_func_proto bpf_sk_storage_get_proto = {
@@ -1011,7 +515,7 @@ bpf_sk_storage_diag_alloc(const struct nlattr *nla_stgs)
 	u32 nr_maps = 0;
 	int rem, err;
 
-	/* bpf_sk_storage_map is currently limited to CAP_SYS_ADMIN as
+	/* bpf_local_storage_map is currently limited to CAP_SYS_ADMIN as
 	 * the map_alloc_check() side also does.
 	 */
 	if (!bpf_capable())
@@ -1061,13 +565,13 @@ bpf_sk_storage_diag_alloc(const struct nlattr *nla_stgs)
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
@@ -1103,9 +607,9 @@ static int bpf_sk_storage_diag_put_all(struct sock *sk, struct sk_buff *skb,
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
@@ -1158,8 +662,8 @@ int bpf_sk_storage_diag_put(struct bpf_sk_storage_diag *diag,
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
@@ -1186,8 +690,8 @@ int bpf_sk_storage_diag_put(struct bpf_sk_storage_diag *diag,
 
 	saved_len = skb->len;
 	for (i = 0; i < diag->nr_maps; i++) {
-		sdata = __sk_storage_lookup(sk_storage,
-				(struct bpf_sk_storage_map *)diag->maps[i],
+		sdata = bpf_local_storage_lookup(sk_storage,
+				(struct bpf_local_storage_map *)diag->maps[i],
 				false);
 
 		if (!sdata)
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 548a749aebb3..1f3e831c4813 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -2802,10 +2802,10 @@ union bpf_attr {
  *		"type". The bpf-local-storage "type" (i.e. the *map*) is
  *		searched against all bpf-local-storages residing at *sk*.
  *
- *		An optional *flags* (**BPF_SK_STORAGE_GET_F_CREATE**) can be
+ *		An optional *flags* (**BPF_LOCAL_STORAGE_GET_F_CREATE**) can be
  *		used such that a new bpf-local-storage will be
  *		created if one does not exist.  *value* can be used
- *		together with **BPF_SK_STORAGE_GET_F_CREATE** to specify
+ *		together with **BPF_LOCAL_STORAGE_GET_F_CREATE** to specify
  *		the initial value of a bpf-local-storage.  If *value* is
  *		**NULL**, the new bpf-local-storage will be zero initialized.
  *	Return
@@ -3572,9 +3572,13 @@ enum {
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
2.27.0.389.gc38d7665816-goog

