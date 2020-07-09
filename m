Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF372219D39
	for <lists+bpf@lfdr.de>; Thu,  9 Jul 2020 12:13:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726318AbgGIKNL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Jul 2020 06:13:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726758AbgGIKMr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Jul 2020 06:12:47 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 471DAC08C5DD
        for <bpf@vger.kernel.org>; Thu,  9 Jul 2020 03:12:46 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id q5so1725211wru.6
        for <bpf@vger.kernel.org>; Thu, 09 Jul 2020 03:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=n6htwB+szlCXWOkrB7yFcHsh0l6bO9G/ddiTH8uA+7s=;
        b=JyexxN6dYl95+LnJpQd+zNDke9P7uWQ0oMyz8w10AzQhZRDTkgKZG6EcOFrApeBZ2Q
         EAWkQ5GB4x1hAka0xKAS55OTLo9YLONzjTboqU1gl6X+T9+loLpsPxqBIoQRHd215r+t
         6XJRG3RpBN++Ms3i++veHoOr1kym5naJgsOE8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n6htwB+szlCXWOkrB7yFcHsh0l6bO9G/ddiTH8uA+7s=;
        b=rp7e7aQ6XCrepBDfY4UZi4+RfFuWpHGR6uKT8ylxkexZRBc8QemyYiujSBzMVvo+ac
         Es2ZwEZjiHBt9995qWHryrfRpWb0qK1t66TVStkdYAX4oy8Tn4ofFcEfjbIk9aLmrhUc
         vYWJmgO0xxovUjY6/xtY8ZafxpEhHf76SQ+TSsvaLqFk/bXjXNpGOiG+ONvE6SFYdXGD
         DKXHb2YC/IRDVpxbS6too+ExcXY61fwr0YR8ql5DA1O8kviCXaWBscJGWtgW0xeubBtD
         zIBgbymmGZc4uxICNy52b5HRWRGMmToObFsYTuHI08GfnCWh1C5zcmaSWx4tIJGRAfJl
         IaMA==
X-Gm-Message-State: AOAM5336z17a6mCEvPWbXp7GvWbGt8cA6BeJlKTMY/6dIVKV1f9Ji8EB
        pOBPPl7Djs2L4ObbmAF3rKC1bg==
X-Google-Smtp-Source: ABdhPJzH8f/CGLViD6K0EHthbYWx4PNFK5zbiWsK82S87OiQSKTJckGzvtXr8IJcukYVqna3oP6pEA==
X-Received: by 2002:a5d:6907:: with SMTP id t7mr62442015wru.329.1594289564615;
        Thu, 09 Jul 2020 03:12:44 -0700 (PDT)
Received: from kpsingh.zrh.corp.google.com ([81.6.44.51])
        by smtp.gmail.com with ESMTPSA id g3sm5538287wrb.59.2020.07.09.03.12.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 03:12:44 -0700 (PDT)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>
Subject: [PATCH bpf-next v4 2/4] bpf: Implement bpf_local_storage for inodes
Date:   Thu,  9 Jul 2020 12:12:37 +0200
Message-Id: <20200709101239.3829793-3-kpsingh@chromium.org>
X-Mailer: git-send-email 2.27.0.389.gc38d7665816-goog
In-Reply-To: <20200709101239.3829793-1-kpsingh@chromium.org>
References: <20200709101239.3829793-1-kpsingh@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: KP Singh <kpsingh@google.com>

Similar to bpf_local_storage for sockets, add local storage for inodes.
The life-cycle of storage is managed with the life-cycle of the inode.
i.e. the storage is destroyed along with the owning inode.

The BPF LSM allocates an __rcu pointer to the bpf_local_storage in the
security blob which are now stackable and can co-exist with other LSMs.

Signed-off-by: KP Singh <kpsingh@google.com>
---
 include/linux/bpf_local_storage.h             |  15 +
 include/linux/bpf_lsm.h                       |  21 ++
 include/linux/bpf_types.h                     |   3 +
 include/uapi/linux/bpf.h                      |  38 ++
 kernel/bpf/Makefile                           |   1 +
 kernel/bpf/bpf_inode_storage.c                | 333 ++++++++++++++++++
 kernel/bpf/syscall.c                          |   3 +-
 kernel/bpf/verifier.c                         |  10 +
 security/bpf/hooks.c                          |   7 +
 .../bpf/bpftool/Documentation/bpftool-map.rst |   2 +-
 tools/bpf/bpftool/bash-completion/bpftool     |   3 +-
 tools/bpf/bpftool/map.c                       |   3 +-
 tools/include/uapi/linux/bpf.h                |  38 ++
 tools/lib/bpf/libbpf_probes.c                 |   5 +-
 14 files changed, 476 insertions(+), 6 deletions(-)
 create mode 100644 kernel/bpf/bpf_inode_storage.c

diff --git a/include/linux/bpf_local_storage.h b/include/linux/bpf_local_storage.h
index 605b81f2f806..63cc7b93ae80 100644
--- a/include/linux/bpf_local_storage.h
+++ b/include/linux/bpf_local_storage.h
@@ -113,6 +113,8 @@ static void cache_idx_free_##type(u16 idx)				\
 	       sizeof(struct bpf_local_storage_elem)),			\
 	      (U16_MAX - sizeof(struct bpf_local_storage_elem)))
 
+struct inode;
+
 struct bpf_local_storage {
 	struct bpf_local_storage_data __rcu *cache[BPF_STORAGE_CACHE_SIZE];
 	struct hlist_head list;		/* List of bpf_local_storage_elem */
@@ -121,6 +123,9 @@ struct bpf_local_storage {
 	 */
 	union {
 		struct sock *sk;
+#ifdef CONFIG_BPF_LSM
+		struct inode *inode;
+#endif
 	};
 	struct rcu_head rcu;
 	raw_spinlock_t lock;	/* Protect adding/removing from the "list" */
@@ -172,4 +177,14 @@ struct bpf_local_storage_data *
 bpf_local_storage_update(void *owner, struct bpf_map *map,
 			 struct bpf_local_storage *local_storage, void *value,
 			 u64 map_flags);
+
+#ifdef CONFIG_BPF_LSM
+extern const struct bpf_func_proto bpf_inode_storage_get_proto;
+extern const struct bpf_func_proto bpf_inode_storage_delete_proto;
+void bpf_inode_storage_free(struct inode *inode);
+#else
+static inline void bpf_inode_storage_free(struct inode *inode)
+{
+}
+#endif
 #endif /* _BPF_LOCAL_STORAGE_H */
diff --git a/include/linux/bpf_lsm.h b/include/linux/bpf_lsm.h
index af74712af585..d0683ada1e49 100644
--- a/include/linux/bpf_lsm.h
+++ b/include/linux/bpf_lsm.h
@@ -17,9 +17,24 @@
 #include <linux/lsm_hook_defs.h>
 #undef LSM_HOOK
 
+struct bpf_storage_blob {
+	struct bpf_local_storage __rcu *storage;
+};
+
+extern struct lsm_blob_sizes bpf_lsm_blob_sizes;
+
 int bpf_lsm_verify_prog(struct bpf_verifier_log *vlog,
 			const struct bpf_prog *prog);
 
+static inline struct bpf_storage_blob *bpf_inode(
+	const struct inode *inode)
+{
+	if (unlikely(!inode->i_security))
+		return NULL;
+
+	return inode->i_security + bpf_lsm_blob_sizes.lbs_inode;
+}
+
 #else /* !CONFIG_BPF_LSM */
 
 static inline int bpf_lsm_verify_prog(struct bpf_verifier_log *vlog,
@@ -28,6 +43,12 @@ static inline int bpf_lsm_verify_prog(struct bpf_verifier_log *vlog,
 	return -EOPNOTSUPP;
 }
 
+static inline struct bpf_storage_blob *bpf_inode(
+	const struct inode *inode)
+{
+	return NULL;
+}
+
 #endif /* CONFIG_BPF_LSM */
 
 #endif /* _LINUX_BPF_LSM_H */
diff --git a/include/linux/bpf_types.h b/include/linux/bpf_types.h
index a18ae82a298a..2950576de4ae 100644
--- a/include/linux/bpf_types.h
+++ b/include/linux/bpf_types.h
@@ -105,6 +105,9 @@ BPF_MAP_TYPE(BPF_MAP_TYPE_SK_STORAGE, sk_storage_map_ops)
 BPF_MAP_TYPE(BPF_MAP_TYPE_SOCKMAP, sock_map_ops)
 BPF_MAP_TYPE(BPF_MAP_TYPE_SOCKHASH, sock_hash_ops)
 #endif
+#ifdef CONFIG_BPF_LSM
+BPF_MAP_TYPE(BPF_MAP_TYPE_INODE_STORAGE, inode_storage_map_ops)
+#endif
 BPF_MAP_TYPE(BPF_MAP_TYPE_CPUMAP, cpu_map_ops)
 #if defined(CONFIG_XDP_SOCKETS)
 BPF_MAP_TYPE(BPF_MAP_TYPE_XSKMAP, xsk_map_ops)
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 1f3e831c4813..42fc442f4586 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -148,6 +148,7 @@ enum bpf_map_type {
 	BPF_MAP_TYPE_DEVMAP_HASH,
 	BPF_MAP_TYPE_STRUCT_OPS,
 	BPF_MAP_TYPE_RINGBUF,
+	BPF_MAP_TYPE_INODE_STORAGE,
 };
 
 /* Note that tracing related programs such as
@@ -3319,6 +3320,41 @@ union bpf_attr {
  *		A non-negative value equal to or less than *size* on success,
  *		or a negative error in case of failure.
  *
+ * void *bpf_inode_storage_get(struct bpf_map *map, void *inode, void *value, u64 flags)
+ *	Description
+ *		Get a bpf_local_storage from an *inode*.
+ *
+ *		Logically, it could be thought of as getting the value from
+ *		a *map* with *inode* as the **key**.  From this
+ *		perspective,  the usage is not much different from
+ *		**bpf_map_lookup_elem**\ (*map*, **&**\ *inode*) except this
+ *		helper enforces the key must be an inode and the map must also
+ *		be a **BPF_MAP_TYPE_INODE_STORAGE**.
+ *
+ *		Underneath, the value is stored locally at *inode* instead of
+ *		the *map*.  The *map* is used as the bpf-local-storage
+ *		"type". The bpf-local-storage "type" (i.e. the *map*) is
+ *		searched against all bpf_local_storage residing at *inode*.
+ *
+ *		An optional *flags* (**BPF_LOCAL_STORAGE_GET_F_CREATE**) can be
+ *		used such that a new bpf_local_storage will be
+ *		created if one does not exist.  *value* can be used
+ *		together with **BPF_LOCAL_STORAGE_GET_F_CREATE** to specify
+ *		the initial value of a bpf_local_storage.  If *value* is
+ *		**NULL**, the new bpf_local_storage will be zero initialized.
+ *	Return
+ *		A bpf_local_storage pointer is returned on success.
+ *
+ *		**NULL** if not found or there was an error in adding
+ *		a new bpf_local_storage.
+ *
+ * int bpf_inode_storage_delete(struct bpf_map *map, void *inode)
+ *	Description
+ *		Delete a bpf_local_storage from an *inode*.
+ *	Return
+ *		0 on success.
+ *
+ *		**-ENOENT** if the bpf_local_storage cannot be found.
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -3463,6 +3499,8 @@ union bpf_attr {
 	FN(skc_to_tcp_request_sock),	\
 	FN(skc_to_udp6_sock),		\
 	FN(get_task_stack),		\
+	FN(inode_storage_get),		\
+	FN(inode_storage_delete),	\
 	/* */
 
 /* integer value in 'imm' field of BPF_CALL instruction selects which helper
diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
index 0acb8f8a6042..0ea9fd15977c 100644
--- a/kernel/bpf/Makefile
+++ b/kernel/bpf/Makefile
@@ -5,6 +5,7 @@ CFLAGS_core.o += $(call cc-disable-warning, override-init)
 obj-$(CONFIG_BPF_SYSCALL) += syscall.o verifier.o inode.o helpers.o tnum.o bpf_iter.o map_iter.o task_iter.o
 obj-$(CONFIG_BPF_SYSCALL) += hashtab.o arraymap.o percpu_freelist.o bpf_lru_list.o lpm_trie.o map_in_map.o
 obj-$(CONFIG_BPF_SYSCALL) += local_storage.o queue_stack_maps.o ringbuf.o
+obj-${CONFIG_BPF_LSM}	  += bpf_inode_storage.o
 obj-$(CONFIG_BPF_SYSCALL) += disasm.o
 obj-$(CONFIG_BPF_JIT) += trampoline.o
 obj-$(CONFIG_BPF_SYSCALL) += btf.o
diff --git a/kernel/bpf/bpf_inode_storage.c b/kernel/bpf/bpf_inode_storage.c
new file mode 100644
index 000000000000..d63db7a24168
--- /dev/null
+++ b/kernel/bpf/bpf_inode_storage.c
@@ -0,0 +1,333 @@
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
+#include <linux/bpf_lsm.h>
+
+static struct bpf_local_storage_elem *
+inode_selem_alloc(struct bpf_local_storage_map *smap, void *owner,
+		  void *value, bool charge_omem)
+{
+	return bpf_selem_alloc(smap, value);
+}
+
+static void unlink_inode_storage(struct bpf_local_storage *local_storage,
+				 bool uncharge_omem)
+{
+	struct bpf_storage_blob *bsb;
+	struct inode *inode;
+
+	inode = local_storage->inode;
+	bsb = bpf_inode(inode);
+	if (!bsb)
+		return;
+	RCU_INIT_POINTER(bsb->storage, NULL);
+	local_storage->inode = NULL;
+}
+
+static struct bpf_local_storage_data *inode_storage_lookup(struct inode *inode,
+							   struct bpf_map *map,
+							   bool cacheit_lockit)
+{
+	struct bpf_local_storage *inode_storage;
+	struct bpf_local_storage_map *smap;
+	struct bpf_storage_blob *bsb;
+
+	bsb = bpf_inode(inode);
+	if (!bsb)
+		return ERR_PTR(-ENOENT);
+
+	inode_storage = rcu_dereference(bsb->storage);
+	if (!inode_storage)
+		return NULL;
+
+	smap = (struct bpf_local_storage_map *)map;
+	return bpf_local_storage_lookup(inode_storage, smap, cacheit_lockit);
+}
+
+static int inode_storage_alloc(void *owner, struct bpf_local_storage_map *smap,
+			       struct bpf_local_storage_elem *first_selem)
+{
+	struct bpf_local_storage *curr;
+	struct bpf_storage_blob *bsb;
+	struct inode *inode = owner;
+	int err;
+
+	bsb = bpf_inode(inode);
+	if (!bsb)
+		return -EINVAL;
+
+	curr = bpf_local_storage_alloc(smap);
+	if (!curr)
+		return -ENOMEM;
+
+	curr->inode = inode;
+
+	bpf_selem_link(curr, first_selem);
+	bpf_selem_link_map(smap, first_selem);
+
+	err = bpf_local_storage_publish(first_selem,
+		(struct bpf_local_storage **)&bsb->storage, curr);
+	if (err) {
+		kfree(curr);
+		return err;
+	}
+
+	return 0;
+}
+
+static struct bpf_local_storage_data *inode_storage_update(void *owner,
+							   struct bpf_map *map,
+							   void *value,
+							   u64 map_flags)
+{
+	struct bpf_local_storage_data *old_sdata = NULL;
+	struct bpf_local_storage_elem *selem;
+	struct bpf_local_storage *local_storage;
+	struct bpf_local_storage_map *smap;
+	struct bpf_storage_blob *bsb;
+	struct inode *inode;
+	int err;
+
+	err = bpf_local_storage_check_update_flags(map, map_flags);
+	if (err)
+		return ERR_PTR(err);
+
+	inode = owner;
+	bsb = bpf_inode(inode);
+	local_storage = rcu_dereference(bsb->storage);
+	smap = (struct bpf_local_storage_map *)map;
+
+	if (!local_storage || hlist_empty(&local_storage->list)) {
+		/* Very first elem */
+		selem = map->ops->map_selem_alloc(smap, owner, value, !old_sdata);
+		if (!selem)
+			return ERR_PTR(-ENOMEM);
+
+		err = map->ops->map_local_storage_alloc(owner, smap, selem);
+		if (err) {
+			kfree(selem);
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
+
+void bpf_inode_storage_free(struct inode *inode)
+{
+	struct bpf_local_storage_elem *selem;
+	struct bpf_local_storage *local_storage;
+	bool free_inode_storage = false;
+	struct bpf_storage_blob *bsb;
+	struct hlist_node *n;
+
+	bsb = bpf_inode(inode);
+	if (!bsb)
+		return;
+
+	rcu_read_lock();
+
+	local_storage = rcu_dereference(bsb->storage);
+	if (!local_storage) {
+		rcu_read_unlock();
+		return;
+	}
+
+	/* Netiher the bpf_prog nor the bpf-map's syscall
+	 * could be modifying the local_storage->list now.
+	 * Thus, no elem can be added-to or deleted-from the
+	 * local_storage->list by the bpf_prog or by the bpf-map's syscall.
+	 *
+	 * It is racing with bpf_local_storage_map_free() alone
+	 * when unlinking elem from the local_storage->list and
+	 * the map's bucket->list.
+	 */
+	raw_spin_lock_bh(&local_storage->lock);
+	hlist_for_each_entry_safe(selem, n, &local_storage->list, snode) {
+		/* Always unlink from map before unlinking from
+		 * local_storage.
+		 */
+		bpf_selem_unlink_map(selem);
+		free_inode_storage =
+			bpf_selem_unlink(local_storage, selem, false);
+	}
+	raw_spin_unlock_bh(&local_storage->lock);
+	rcu_read_unlock();
+
+	/* free_inoode_storage should always be true as long as
+	 * local_storage->list was non-empty.
+	 */
+	if (free_inode_storage)
+		kfree_rcu(local_storage, rcu);
+}
+
+
+static void *bpf_inode_storage_lookup_elem(struct bpf_map *map, void *key)
+{
+	struct bpf_local_storage_data *sdata;
+	struct inode *inode;
+	int err = -EINVAL;
+
+	if (key) {
+		inode = *(struct inode **)(key);
+		sdata = inode_storage_lookup(inode, map, true);
+		return sdata ? sdata->data : NULL;
+	}
+
+	return ERR_PTR(err);
+}
+
+static int bpf_inode_storage_update_elem(struct bpf_map *map, void *key,
+					 void *value, u64 map_flags)
+{
+	struct bpf_local_storage_data *sdata;
+	struct inode *inode;
+	int err = -EINVAL;
+
+	if (key) {
+		inode = *(struct inode **)(key);
+		sdata = map->ops->map_local_storage_update(inode, map, value,
+							   map_flags);
+		return PTR_ERR_OR_ZERO(sdata);
+	}
+	return err;
+}
+
+static int inode_storage_delete(struct inode *inode, struct bpf_map *map)
+{
+	struct bpf_local_storage_data *sdata;
+
+	sdata = inode_storage_lookup(inode, map, false);
+	if (!sdata)
+		return -ENOENT;
+
+	bpf_selem_unlink_map_elem(SELEM(sdata));
+
+	return 0;
+}
+
+static int bpf_inode_storage_delete_elem(struct bpf_map *map, void *key)
+{
+	struct inode *inode;
+	int err = -EINVAL;
+
+	if (key) {
+		inode = *(struct inode **)(key);
+		err = inode_storage_delete(inode, map);
+	}
+
+	return err;
+}
+
+BPF_CALL_4(bpf_inode_storage_get, struct bpf_map *, map, struct inode *, inode,
+	   void *, value, u64, flags)
+{
+	struct bpf_local_storage_data *sdata;
+
+	if (flags & ~(BPF_LOCAL_STORAGE_GET_F_CREATE))
+		return (unsigned long)NULL;
+
+	sdata = inode_storage_lookup(inode, map, true);
+	if (sdata)
+		return (unsigned long)sdata->data;
+
+	if (flags & BPF_LOCAL_STORAGE_GET_F_CREATE) {
+		sdata = inode_storage_update(inode, map, value, BPF_NOEXIST);
+		return IS_ERR(sdata) ?
+			(unsigned long)NULL : (unsigned long)sdata->data;
+	}
+
+	return (unsigned long)NULL;
+}
+
+BPF_CALL_2(bpf_inode_storage_delete,
+	   struct bpf_map *, map, struct inode *, inode)
+{
+	return inode_storage_delete(inode, map);
+}
+
+static int notsupp_get_next_key(struct bpf_map *map, void *key,
+				void *next_key)
+{
+	return -ENOTSUPP;
+}
+
+DEFINE_BPF_STORAGE_CACHE(inode);
+
+static struct bpf_map *inode_storage_map_alloc(union bpf_attr *attr)
+{
+	struct bpf_local_storage_map *smap;
+
+	smap = bpf_local_storage_map_alloc(attr);
+	if (IS_ERR(smap))
+		return ERR_CAST(smap);
+
+	smap->cache_idx = cache_idx_get_inode();
+	return &smap->map;
+}
+
+static void inode_storage_map_free(struct bpf_map *map)
+{
+	struct bpf_local_storage_map *smap;
+
+	smap = (struct bpf_local_storage_map *)map;
+	cache_idx_free_inode(smap->cache_idx);
+	bpf_local_storage_map_free(smap);
+}
+
+static int inode_storage_map_btf_id;
+const struct bpf_map_ops inode_storage_map_ops = {
+	.map_alloc_check = bpf_local_storage_map_alloc_check,
+	.map_alloc = inode_storage_map_alloc,
+	.map_free = inode_storage_map_free,
+	.map_get_next_key = notsupp_get_next_key,
+	.map_lookup_elem = bpf_inode_storage_lookup_elem,
+	.map_update_elem = bpf_inode_storage_update_elem,
+	.map_delete_elem = bpf_inode_storage_delete_elem,
+	.map_check_btf = bpf_local_storage_map_check_btf,
+	.map_btf_name = "bpf_local_storage_map",
+	.map_btf_id = &inode_storage_map_btf_id,
+	.map_local_storage_alloc = inode_storage_alloc,
+	.map_selem_alloc = inode_selem_alloc,
+	.map_local_storage_update = inode_storage_update,
+	.map_local_storage_unlink = unlink_inode_storage,
+};
+
+static int bpf_inode_storage_get_btf_ids[4];
+const struct bpf_func_proto bpf_inode_storage_get_proto = {
+	.func		= bpf_inode_storage_get,
+	.gpl_only	= false,
+	.ret_type	= RET_PTR_TO_MAP_VALUE_OR_NULL,
+	.arg1_type	= ARG_CONST_MAP_PTR,
+	.arg2_type	= ARG_PTR_TO_BTF_ID,
+	.arg3_type	= ARG_PTR_TO_MAP_VALUE_OR_NULL,
+	.arg4_type	= ARG_ANYTHING,
+	.btf_id		= bpf_inode_storage_get_btf_ids,
+};
+
+static int bpf_inode_storage_delete_btf_ids[2];
+const struct bpf_func_proto bpf_inode_storage_delete_proto = {
+	.func		= bpf_inode_storage_delete,
+	.gpl_only	= false,
+	.ret_type	= RET_INTEGER,
+	.arg1_type	= ARG_CONST_MAP_PTR,
+	.arg2_type	= ARG_PTR_TO_BTF_ID,
+	.btf_id		= bpf_inode_storage_delete_btf_ids,
+};
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 156f51ffada2..3fc7586408f7 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -768,7 +768,8 @@ static int map_check_btf(struct bpf_map *map, const struct btf *btf,
 		if (map->map_type != BPF_MAP_TYPE_HASH &&
 		    map->map_type != BPF_MAP_TYPE_ARRAY &&
 		    map->map_type != BPF_MAP_TYPE_CGROUP_STORAGE &&
-		    map->map_type != BPF_MAP_TYPE_SK_STORAGE)
+		    map->map_type != BPF_MAP_TYPE_SK_STORAGE &&
+		    map->map_type != BPF_MAP_TYPE_INODE_STORAGE)
 			return -ENOTSUPP;
 		if (map->spin_lock_off + sizeof(struct bpf_spin_lock) >
 		    map->value_size) {
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index b608185e1ffd..9080a62b583a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -4164,6 +4164,11 @@ static int check_map_func_compatibility(struct bpf_verifier_env *env,
 		    func_id != BPF_FUNC_sk_storage_delete)
 			goto error;
 		break;
+	case BPF_MAP_TYPE_INODE_STORAGE:
+		if (func_id != BPF_FUNC_inode_storage_get &&
+		    func_id != BPF_FUNC_inode_storage_delete)
+			goto error;
+		break;
 	default:
 		break;
 	}
@@ -4237,6 +4242,11 @@ static int check_map_func_compatibility(struct bpf_verifier_env *env,
 		if (map->map_type != BPF_MAP_TYPE_SK_STORAGE)
 			goto error;
 		break;
+	case BPF_FUNC_inode_storage_get:
+	case BPF_FUNC_inode_storage_delete:
+		if (map->map_type != BPF_MAP_TYPE_INODE_STORAGE)
+			goto error;
+		break;
 	default:
 		break;
 	}
diff --git a/security/bpf/hooks.c b/security/bpf/hooks.c
index 32d32d485451..35f9b19259e5 100644
--- a/security/bpf/hooks.c
+++ b/security/bpf/hooks.c
@@ -3,6 +3,7 @@
 /*
  * Copyright (C) 2020 Google LLC.
  */
+#include <linux/bpf_local_storage.h>
 #include <linux/lsm_hooks.h>
 #include <linux/bpf_lsm.h>
 
@@ -11,6 +12,7 @@ static struct security_hook_list bpf_lsm_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(NAME, bpf_lsm_##NAME),
 	#include <linux/lsm_hook_defs.h>
 	#undef LSM_HOOK
+	LSM_HOOK_INIT(inode_free_security, bpf_inode_storage_free),
 };
 
 static int __init bpf_lsm_init(void)
@@ -20,7 +22,12 @@ static int __init bpf_lsm_init(void)
 	return 0;
 }
 
+struct lsm_blob_sizes bpf_lsm_blob_sizes __lsm_ro_after_init = {
+	.lbs_inode = sizeof(struct bpf_storage_blob),
+};
+
 DEFINE_LSM(bpf) = {
 	.name = "bpf",
 	.init = bpf_lsm_init,
+	.blobs = &bpf_lsm_blob_sizes
 };
diff --git a/tools/bpf/bpftool/Documentation/bpftool-map.rst b/tools/bpf/bpftool/Documentation/bpftool-map.rst
index 41e2a74252d0..083db6c2fc67 100644
--- a/tools/bpf/bpftool/Documentation/bpftool-map.rst
+++ b/tools/bpf/bpftool/Documentation/bpftool-map.rst
@@ -49,7 +49,7 @@ MAP COMMANDS
 |		| **lru_percpu_hash** | **lpm_trie** | **array_of_maps** | **hash_of_maps**
 |		| **devmap** | **devmap_hash** | **sockmap** | **cpumap** | **xskmap** | **sockhash**
 |		| **cgroup_storage** | **reuseport_sockarray** | **percpu_cgroup_storage**
-|		| **queue** | **stack** | **sk_storage** | **struct_ops** | **ringbuf** }
+|		| **queue** | **stack** | **sk_storage** | **struct_ops** | **ringbuf** | **inode_storage** }
 
 DESCRIPTION
 ===========
diff --git a/tools/bpf/bpftool/bash-completion/bpftool b/tools/bpf/bpftool/bash-completion/bpftool
index 25b25aca1112..34cadc081a78 100644
--- a/tools/bpf/bpftool/bash-completion/bpftool
+++ b/tools/bpf/bpftool/bash-completion/bpftool
@@ -688,7 +688,8 @@ _bpftool()
                                 lru_percpu_hash lpm_trie array_of_maps \
                                 hash_of_maps devmap devmap_hash sockmap cpumap \
                                 xskmap sockhash cgroup_storage reuseport_sockarray \
-                                percpu_cgroup_storage queue stack' -- \
+                                percpu_cgroup_storage queue stack sk_storage \
+                                struct_ops inode_storage' -- \
                                                    "$cur" ) )
                             return 0
                             ;;
diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
index 3a27d31a1856..bc0071228f88 100644
--- a/tools/bpf/bpftool/map.c
+++ b/tools/bpf/bpftool/map.c
@@ -50,6 +50,7 @@ const char * const map_type_name[] = {
 	[BPF_MAP_TYPE_SK_STORAGE]		= "sk_storage",
 	[BPF_MAP_TYPE_STRUCT_OPS]		= "struct_ops",
 	[BPF_MAP_TYPE_RINGBUF]			= "ringbuf",
+	[BPF_MAP_TYPE_INODE_STORAGE]		= "inode_storage",
 };
 
 const size_t map_type_name_size = ARRAY_SIZE(map_type_name);
@@ -1442,7 +1443,7 @@ static int do_help(int argc, char **argv)
 		"                 lru_percpu_hash | lpm_trie | array_of_maps | hash_of_maps |\n"
 		"                 devmap | devmap_hash | sockmap | cpumap | xskmap | sockhash |\n"
 		"                 cgroup_storage | reuseport_sockarray | percpu_cgroup_storage |\n"
-		"                 queue | stack | sk_storage | struct_ops | ringbuf }\n"
+		"                 queue | stack | sk_storage | struct_ops | ringbuf | inode_storage }\n"
 		"       " HELP_SPEC_OPTIONS "\n"
 		"",
 		bin_name, argv[-2]);
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 1f3e831c4813..42fc442f4586 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -148,6 +148,7 @@ enum bpf_map_type {
 	BPF_MAP_TYPE_DEVMAP_HASH,
 	BPF_MAP_TYPE_STRUCT_OPS,
 	BPF_MAP_TYPE_RINGBUF,
+	BPF_MAP_TYPE_INODE_STORAGE,
 };
 
 /* Note that tracing related programs such as
@@ -3319,6 +3320,41 @@ union bpf_attr {
  *		A non-negative value equal to or less than *size* on success,
  *		or a negative error in case of failure.
  *
+ * void *bpf_inode_storage_get(struct bpf_map *map, void *inode, void *value, u64 flags)
+ *	Description
+ *		Get a bpf_local_storage from an *inode*.
+ *
+ *		Logically, it could be thought of as getting the value from
+ *		a *map* with *inode* as the **key**.  From this
+ *		perspective,  the usage is not much different from
+ *		**bpf_map_lookup_elem**\ (*map*, **&**\ *inode*) except this
+ *		helper enforces the key must be an inode and the map must also
+ *		be a **BPF_MAP_TYPE_INODE_STORAGE**.
+ *
+ *		Underneath, the value is stored locally at *inode* instead of
+ *		the *map*.  The *map* is used as the bpf-local-storage
+ *		"type". The bpf-local-storage "type" (i.e. the *map*) is
+ *		searched against all bpf_local_storage residing at *inode*.
+ *
+ *		An optional *flags* (**BPF_LOCAL_STORAGE_GET_F_CREATE**) can be
+ *		used such that a new bpf_local_storage will be
+ *		created if one does not exist.  *value* can be used
+ *		together with **BPF_LOCAL_STORAGE_GET_F_CREATE** to specify
+ *		the initial value of a bpf_local_storage.  If *value* is
+ *		**NULL**, the new bpf_local_storage will be zero initialized.
+ *	Return
+ *		A bpf_local_storage pointer is returned on success.
+ *
+ *		**NULL** if not found or there was an error in adding
+ *		a new bpf_local_storage.
+ *
+ * int bpf_inode_storage_delete(struct bpf_map *map, void *inode)
+ *	Description
+ *		Delete a bpf_local_storage from an *inode*.
+ *	Return
+ *		0 on success.
+ *
+ *		**-ENOENT** if the bpf_local_storage cannot be found.
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -3463,6 +3499,8 @@ union bpf_attr {
 	FN(skc_to_tcp_request_sock),	\
 	FN(skc_to_udp6_sock),		\
 	FN(get_task_stack),		\
+	FN(inode_storage_get),		\
+	FN(inode_storage_delete),	\
 	/* */
 
 /* integer value in 'imm' field of BPF_CALL instruction selects which helper
diff --git a/tools/lib/bpf/libbpf_probes.c b/tools/lib/bpf/libbpf_probes.c
index 10cd8d1891f5..b859558ce290 100644
--- a/tools/lib/bpf/libbpf_probes.c
+++ b/tools/lib/bpf/libbpf_probes.c
@@ -170,7 +170,7 @@ int libbpf__load_raw_btf(const char *raw_types, size_t types_len,
 	return btf_fd;
 }
 
-static int load_sk_storage_btf(void)
+static int load_local_storage_btf(void)
 {
 	const char strs[] = "\0bpf_spin_lock\0val\0cnt\0l";
 	/* struct bpf_spin_lock {
@@ -229,12 +229,13 @@ bool bpf_probe_map_type(enum bpf_map_type map_type, __u32 ifindex)
 		key_size	= 0;
 		break;
 	case BPF_MAP_TYPE_SK_STORAGE:
+	case BPF_MAP_TYPE_INODE_STORAGE:
 		btf_key_type_id = 1;
 		btf_value_type_id = 3;
 		value_size = 8;
 		max_entries = 0;
 		map_flags = BPF_F_NO_PREALLOC;
-		btf_fd = load_sk_storage_btf();
+		btf_fd = load_local_storage_btf();
 		if (btf_fd < 0)
 			return false;
 		break;
-- 
2.27.0.389.gc38d7665816-goog

