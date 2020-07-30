Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F25232333DF
	for <lists+bpf@lfdr.de>; Thu, 30 Jul 2020 16:08:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729075AbgG3OHw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 30 Jul 2020 10:07:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729092AbgG3OH3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 30 Jul 2020 10:07:29 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 952A1C0617A3
        for <bpf@vger.kernel.org>; Thu, 30 Jul 2020 07:07:28 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id c80so5842592wme.0
        for <bpf@vger.kernel.org>; Thu, 30 Jul 2020 07:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0Y4CVUjK8HSMKqyDfZUl9yxUlmeruMQzJ98Y/riGxWk=;
        b=cmJTfsynuE+cu7Je5E8WLzRRajH/fcmW43bNZBOvqxHSDeCbim8qADyzs0bY7S90uH
         cFAE9ehd/Lue0tK1pPC1DU16OOwv4GgBSQG5rYWRTL36g9MTNWphgoA/LSZe4rFbFv+R
         ufZXHT5YUSsuDP4yia/R/qouCSkOp0aMNmduI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0Y4CVUjK8HSMKqyDfZUl9yxUlmeruMQzJ98Y/riGxWk=;
        b=KzFWdpB9XxdMMKv2RjNUNFQaKgtuIUvoZYEVeWbuEGfpd16PBwDcT4RoLPzLzRo7jH
         QcyOwkX6drfM521t9SScCq7xj1fqR7gpPoJ9nczTtgI62vf8ISkVMiOoZsOJ9/nB60Ig
         Sn4IxY8n1Ej+ulN7gg4EQycBuVIoPUF9wrgKPL2EP9A4BpCD0wnZ9ECbdWKWl4EMyqoz
         w8jqT7KxzlOA2iKif10aat1v0j59hQr/YO7jO+v9vc9SdXdBsEmeGCPHRTpimyfYX4u+
         0HyhVHcKJkOOZWTxuoLtCA+N5oWIns22hwFMnfRXRjAZSib2Bzh6hyAOJIlIWdkvB/CL
         xoxw==
X-Gm-Message-State: AOAM532QdRK4Tqed8p2s71OfjII091EoKDy6m5/t6SNXYOftFWWW8tSl
        QEMLVnT0xsSvcHXuZDFKVMxKRg==
X-Google-Smtp-Source: ABdhPJy+9QMzaZItI6Eqf6zlMewcoJ0YG1JV2I47+NDxaQrme3tnhbpgwP5q/P21UoEMadjsNS0S4w==
X-Received: by 2002:a1c:283:: with SMTP id 125mr14375441wmc.12.1596118046938;
        Thu, 30 Jul 2020 07:07:26 -0700 (PDT)
Received: from kpsingh.zrh.corp.google.com ([81.6.44.51])
        by smtp.gmail.com with ESMTPSA id a10sm19088599wmd.3.2020.07.30.07.07.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2020 07:07:26 -0700 (PDT)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>
Subject: [PATCH bpf-next v7 5/7] bpf: Implement bpf_local_storage for inodes
Date:   Thu, 30 Jul 2020 16:07:14 +0200
Message-Id: <20200730140716.404558-6-kpsingh@chromium.org>
X-Mailer: git-send-email 2.28.0.rc0.142.g3c755180ce-goog
In-Reply-To: <20200730140716.404558-1-kpsingh@chromium.org>
References: <20200730140716.404558-1-kpsingh@chromium.org>
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
 include/linux/bpf_local_storage.h             |  10 +
 include/linux/bpf_lsm.h                       |  21 ++
 include/linux/bpf_types.h                     |   3 +
 include/uapi/linux/bpf.h                      |  38 +++
 kernel/bpf/Makefile                           |   1 +
 kernel/bpf/bpf_inode_storage.c                | 254 ++++++++++++++++++
 kernel/bpf/syscall.c                          |   3 +-
 kernel/bpf/verifier.c                         |  10 +
 security/bpf/hooks.c                          |   7 +
 .../bpf/bpftool/Documentation/bpftool-map.rst |   2 +-
 tools/bpf/bpftool/bash-completion/bpftool     |   3 +-
 tools/bpf/bpftool/map.c                       |   3 +-
 tools/include/uapi/linux/bpf.h                |  38 +++
 tools/lib/bpf/libbpf_probes.c                 |   5 +-
 14 files changed, 392 insertions(+), 6 deletions(-)
 create mode 100644 kernel/bpf/bpf_inode_storage.c

diff --git a/include/linux/bpf_local_storage.h b/include/linux/bpf_local_storage.h
index 3685f681a7fc..75c76847fad5 100644
--- a/include/linux/bpf_local_storage.h
+++ b/include/linux/bpf_local_storage.h
@@ -160,4 +160,14 @@ struct bpf_local_storage_data *
 bpf_local_storage_update(void *owner, struct bpf_map *map, void *value,
 			 u64 map_flags);
 
+#ifdef CONFIG_BPF_LSM
+extern const struct bpf_func_proto bpf_inode_storage_get_proto;
+extern const struct bpf_func_proto bpf_inode_storage_delete_proto;
+void bpf_inode_storage_free(struct inode *inode);
+#else
+static inline void bpf_inode_storage_free(struct inode *inode)
+{
+}
+#endif /* CONFIG_BPF_LSM */
+
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
index a52a5688418e..2e6f568377f1 100644
--- a/include/linux/bpf_types.h
+++ b/include/linux/bpf_types.h
@@ -107,6 +107,9 @@ BPF_MAP_TYPE(BPF_MAP_TYPE_SK_STORAGE, sk_storage_map_ops)
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
index cd5a47a74533..d3617f1ce3fc 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -148,6 +148,7 @@ enum bpf_map_type {
 	BPF_MAP_TYPE_DEVMAP_HASH,
 	BPF_MAP_TYPE_STRUCT_OPS,
 	BPF_MAP_TYPE_RINGBUF,
+	BPF_MAP_TYPE_INODE_STORAGE,
 };
 
 /* Note that tracing related programs such as
@@ -3389,6 +3390,41 @@ union bpf_attr {
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
@@ -3533,6 +3569,8 @@ union bpf_attr {
 	FN(skc_to_tcp_request_sock),	\
 	FN(skc_to_udp6_sock),		\
 	FN(get_task_stack),		\
+	FN(inode_storage_get),		\
+	FN(inode_storage_delete),	\
 	/* */
 
 /* integer value in 'imm' field of BPF_CALL instruction selects which helper
diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
index a9a147e18600..25f40588dfbf 100644
--- a/kernel/bpf/Makefile
+++ b/kernel/bpf/Makefile
@@ -5,6 +5,7 @@ CFLAGS_core.o += $(call cc-disable-warning, override-init)
 obj-$(CONFIG_BPF_SYSCALL) += syscall.o verifier.o inode.o helpers.o tnum.o bpf_iter.o map_iter.o task_iter.o prog_iter.o
 obj-$(CONFIG_BPF_SYSCALL) += hashtab.o arraymap.o percpu_freelist.o bpf_lru_list.o lpm_trie.o map_in_map.o
 obj-$(CONFIG_BPF_SYSCALL) += local_storage.o queue_stack_maps.o ringbuf.o
+obj-${CONFIG_BPF_LSM}	  += bpf_inode_storage.o
 obj-$(CONFIG_BPF_SYSCALL) += disasm.o
 obj-$(CONFIG_BPF_JIT) += trampoline.o
 obj-$(CONFIG_BPF_SYSCALL) += btf.o
diff --git a/kernel/bpf/bpf_inode_storage.c b/kernel/bpf/bpf_inode_storage.c
new file mode 100644
index 000000000000..16c133f36d7e
--- /dev/null
+++ b/kernel/bpf/bpf_inode_storage.c
@@ -0,0 +1,254 @@
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
+#include <linux/btf_ids.h>
+#include <linux/fdtable.h>
+
+DEFINE_BPF_STORAGE_CACHE(inode_cache);
+
+static struct bpf_local_storage __rcu **
+inode_storage_ptr(void *owner)
+{
+	struct inode *inode = owner;
+	struct bpf_storage_blob *bsb;
+	bsb = bpf_inode(inode);
+	if (!bsb)
+		return NULL;
+	return &bsb->storage;
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
+			bpf_selem_unlink_storage(local_storage, selem, false);
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
+static void *bpf_fd_inode_storage_lookup_elem(struct bpf_map *map, void *key)
+{
+	struct bpf_local_storage_data *sdata;
+	struct file *f;
+	int fd;
+
+	fd = *(int *)key;
+	f = fcheck(fd);
+	if (!f)
+		return ERR_PTR(-EINVAL);
+
+	sdata = inode_storage_lookup(f->f_inode, map, true);
+	return sdata ? sdata->data : NULL;
+}
+
+static int bpf_fd_inode_storage_update_elem(struct bpf_map *map, void *key,
+					 void *value, u64 map_flags)
+{
+	struct bpf_local_storage_data *sdata;
+	struct file *f;
+	int fd;
+
+	fd = *(int *)key;
+	f = fcheck(fd);
+	if (!f)
+		return -EINVAL;
+
+	sdata = bpf_local_storage_update(f->f_inode, map, value, map_flags);
+	return PTR_ERR_OR_ZERO(sdata);
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
+	bpf_selem_unlink(SELEM(sdata));
+
+	return 0;
+}
+
+static int bpf_fd_inode_storage_delete_elem(struct bpf_map *map, void *key)
+{
+	struct file *f;
+	int fd;
+
+	fd = *(int *)key;
+	f = fcheck(fd);
+	if (!f)
+		return -EINVAL;
+
+	return inode_storage_delete(f->f_inode, map);
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
+		sdata = bpf_local_storage_update(inode, map, value,
+						 BPF_NOEXIST);
+		return IS_ERR(sdata) ? (unsigned long)NULL :
+					     (unsigned long)sdata->data;
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
+static struct bpf_map *inode_storage_map_alloc(union bpf_attr *attr)
+{
+	struct bpf_local_storage_map *smap;
+
+	smap = bpf_local_storage_map_alloc(attr);
+	if (IS_ERR(smap))
+		return ERR_CAST(smap);
+
+	smap->cache_idx = bpf_local_storage_cache_idx_get(&inode_cache);
+	return &smap->map;
+}
+
+static void inode_storage_map_free(struct bpf_map *map)
+{
+	struct bpf_local_storage_map *smap;
+
+	smap = (struct bpf_local_storage_map *)map;
+	bpf_local_storage_cache_idx_free(&inode_cache, smap->cache_idx);
+	bpf_local_storage_map_free(smap);
+}
+
+static int sk_storage_map_btf_id;
+const struct bpf_map_ops inode_storage_map_ops = {
+	.map_alloc_check = bpf_local_storage_map_alloc_check,
+	.map_alloc = inode_storage_map_alloc,
+	.map_free = inode_storage_map_free,
+	.map_get_next_key = notsupp_get_next_key,
+	.map_lookup_elem = bpf_fd_inode_storage_lookup_elem,
+	.map_update_elem = bpf_fd_inode_storage_update_elem,
+	.map_delete_elem = bpf_fd_inode_storage_delete_elem,
+	.map_check_btf = bpf_local_storage_map_check_btf,
+	.map_btf_name = "bpf_local_storage_map",
+	.map_btf_id = &sk_storage_map_btf_id,
+	.map_owner_storage_ptr = inode_storage_ptr,
+};
+
+BTF_ID_LIST(bpf_inode_storage_get_btf_ids)
+BTF_ID(struct, inode)
+
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
+BTF_ID_LIST(bpf_inode_storage_delete_btf_ids)
+BTF_ID(struct, inode)
+
+const struct bpf_func_proto bpf_inode_storage_delete_proto = {
+	.func		= bpf_inode_storage_delete,
+	.gpl_only	= false,
+	.ret_type	= RET_INTEGER,
+	.arg1_type	= ARG_CONST_MAP_PTR,
+	.arg2_type	= ARG_PTR_TO_BTF_ID,
+	.btf_id		= bpf_inode_storage_delete_btf_ids,
+};
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index cd3d599e9e90..78795cd50b45 100644
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
index b6ccfce3bf4c..c48378afbd95 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -4242,6 +4242,11 @@ static int check_map_func_compatibility(struct bpf_verifier_env *env,
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
@@ -4315,6 +4320,11 @@ static int check_map_func_compatibility(struct bpf_verifier_env *env,
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
index 257fa310ea2b..45a93ed5ed89 100644
--- a/tools/bpf/bpftool/bash-completion/bpftool
+++ b/tools/bpf/bpftool/bash-completion/bpftool
@@ -704,7 +704,8 @@ _bpftool()
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
index cd5a47a74533..d3617f1ce3fc 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -148,6 +148,7 @@ enum bpf_map_type {
 	BPF_MAP_TYPE_DEVMAP_HASH,
 	BPF_MAP_TYPE_STRUCT_OPS,
 	BPF_MAP_TYPE_RINGBUF,
+	BPF_MAP_TYPE_INODE_STORAGE,
 };
 
 /* Note that tracing related programs such as
@@ -3389,6 +3390,41 @@ union bpf_attr {
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
@@ -3533,6 +3569,8 @@ union bpf_attr {
 	FN(skc_to_tcp_request_sock),	\
 	FN(skc_to_udp6_sock),		\
 	FN(get_task_stack),		\
+	FN(inode_storage_get),		\
+	FN(inode_storage_delete),	\
 	/* */
 
 /* integer value in 'imm' field of BPF_CALL instruction selects which helper
diff --git a/tools/lib/bpf/libbpf_probes.c b/tools/lib/bpf/libbpf_probes.c
index 5a3d3f078408..daaad635d0ed 100644
--- a/tools/lib/bpf/libbpf_probes.c
+++ b/tools/lib/bpf/libbpf_probes.c
@@ -173,7 +173,7 @@ int libbpf__load_raw_btf(const char *raw_types, size_t types_len,
 	return btf_fd;
 }
 
-static int load_sk_storage_btf(void)
+static int load_local_storage_btf(void)
 {
 	const char strs[] = "\0bpf_spin_lock\0val\0cnt\0l";
 	/* struct bpf_spin_lock {
@@ -232,12 +232,13 @@ bool bpf_probe_map_type(enum bpf_map_type map_type, __u32 ifindex)
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
2.28.0.rc0.142.g3c755180ce-goog

