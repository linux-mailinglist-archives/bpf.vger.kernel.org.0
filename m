Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 675021FD615
	for <lists+bpf@lfdr.de>; Wed, 17 Jun 2020 22:29:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbgFQU3y (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 17 Jun 2020 16:29:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726991AbgFQU3w (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 17 Jun 2020 16:29:52 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F120C0613ED
        for <bpf@vger.kernel.org>; Wed, 17 Jun 2020 13:29:51 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id e1so3772456wrt.5
        for <bpf@vger.kernel.org>; Wed, 17 Jun 2020 13:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0z/0Y7NaVSsActfo57ajSne8aiBTsVf5XmlJzTNvsI0=;
        b=VQy3YISy010lQSXuGqTQmQExeRJhpvOW2f9Kd/8Sk6D0iI7fS2KHipsyANPzFiRQ/6
         Is1gHIscX6g/yuKEmDUfsp5Xv1oYDVC8glh0BVO2i0QMzRPAB5w1W5QusKMoyHs5XMdm
         CJtVUyE0QwCJ0ZZJpf8EYdrv0nfHaQzmS1nqw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0z/0Y7NaVSsActfo57ajSne8aiBTsVf5XmlJzTNvsI0=;
        b=nxEpXriDX0NzuafSS0bCz9vdnnxfgR1cMdip8YiGzrZojtszMKoVdAN+qRR2Wi4NfW
         zfzlrDLeGKG+VWnYF4rbCKrYz9pSsXqqmg5msVNLEdJ/tA2CpTTA+yiy8Llt7ymVQky8
         9CRq5r/ZCCmS2La0C83VzUg0pxABsl/8aT/Tldi6bWtAW+9hzKcoVJfTopxPlXWXAa8g
         GPiluOJ1RhFqbRCOucOspzjtc98m9VDLiNYGwzYHFhigKPMGe1kei6EUpj0DCUkl00rT
         Zj5wmedjI8Y1z/CvPmhJ84f9TulO3yriWPkqWQxo6Bl67GVDBrYzu0OTr8ygD4kzCKPj
         jqNg==
X-Gm-Message-State: AOAM533DmSngq/ejB3lMqrbsi2Jf0Azb0iThQYXqjGHbz/hIYuQ8lHAC
        t01QpJXE38AWPSqi1gXmiTrUReUrSr4=
X-Google-Smtp-Source: ABdhPJxeaxDcdm1O7JyBmaWnnwLbAwzWEVVebVMewbCfHkhKi7AplZ87mtFEaVvxVQUbKuXm7loE8g==
X-Received: by 2002:adf:fec9:: with SMTP id q9mr1097571wrs.172.1592425789219;
        Wed, 17 Jun 2020 13:29:49 -0700 (PDT)
Received: from kpsingh.zrh.corp.google.com ([81.6.44.51])
        by smtp.gmail.com with ESMTPSA id o10sm812845wrq.40.2020.06.17.13.29.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 13:29:48 -0700 (PDT)
From:   KP Singh <kpsingh@chromium.org>
To:     bpf@vger.kernel.org, linux-security-module@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>
Subject: [PATCH bpf-next v2 2/4] bpf: Implement bpf_local_storage for inodes
Date:   Wed, 17 Jun 2020 22:29:39 +0200
Message-Id: <20200617202941.3034-3-kpsingh@chromium.org>
X-Mailer: git-send-email 2.27.0.111.gc72c7da667-goog
In-Reply-To: <20200617202941.3034-1-kpsingh@chromium.org>
References: <20200617202941.3034-1-kpsingh@chromium.org>
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
 include/linux/bpf_local_storage.h |   7 +
 include/linux/bpf_lsm.h           |  21 +++
 include/linux/bpf_types.h         |   1 +
 include/uapi/linux/bpf.h          |  40 ++++-
 kernel/bpf/bpf_local_storage.c    | 261 +++++++++++++++++++++++++++++-
 kernel/bpf/syscall.c              |   3 +-
 kernel/bpf/verifier.c             |  10 ++
 security/bpf/hooks.c              |   7 +
 tools/bpf/bpftool/map.c           |   1 +
 tools/include/uapi/linux/bpf.h    |  40 ++++-
 tools/lib/bpf/libbpf_probes.c     |   5 +-
 11 files changed, 390 insertions(+), 6 deletions(-)

diff --git a/include/linux/bpf_local_storage.h b/include/linux/bpf_local_storage.h
index 85524f18cd91..7488487b1099 100644
--- a/include/linux/bpf_local_storage.h
+++ b/include/linux/bpf_local_storage.h
@@ -4,11 +4,14 @@
 #define _BPF_LOCAL_STORAGE_H
 
 struct sock;
+struct inode;
 
 void bpf_sk_storage_free(struct sock *sk);
 
 extern const struct bpf_func_proto bpf_sk_storage_get_proto;
 extern const struct bpf_func_proto bpf_sk_storage_delete_proto;
+extern const struct bpf_func_proto bpf_inode_storage_get_proto;
+extern const struct bpf_func_proto bpf_inode_storage_delete_proto;
 
 struct bpf_sk_storage_diag;
 struct sk_buff;
@@ -16,6 +19,7 @@ struct nlattr;
 struct sock;
 
 #ifdef CONFIG_BPF_SYSCALL
+void bpf_inode_storage_free(struct inode *inode);
 int bpf_sk_storage_clone(const struct sock *sk, struct sock *newsk);
 struct bpf_sk_storage_diag *
 bpf_sk_storage_diag_alloc(const struct nlattr *nla_stgs);
@@ -35,6 +39,9 @@ bpf_sk_storage_diag_alloc(const struct nlattr *nla)
 {
 	return NULL;
 }
+static inline void void bpf_inode_storage_free(struct inode *inode)
+{
+}
 static inline void bpf_sk_storage_diag_free(struct bpf_sk_storage_diag *diag)
 {
 }
diff --git a/include/linux/bpf_lsm.h b/include/linux/bpf_lsm.h
index af74712af585..8efd7562e3de 100644
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
 
+static inline struct bpf_storage_blob *bpf_inode_storage(
+	const struct inode *inode)
+{
+	return NULL;
+}
+
 #endif /* CONFIG_BPF_LSM */
 
 #endif /* _LINUX_BPF_LSM_H */
diff --git a/include/linux/bpf_types.h b/include/linux/bpf_types.h
index a18ae82a298a..881e7954c956 100644
--- a/include/linux/bpf_types.h
+++ b/include/linux/bpf_types.h
@@ -101,6 +101,7 @@ BPF_MAP_TYPE(BPF_MAP_TYPE_HASH_OF_MAPS, htab_of_maps_map_ops)
 BPF_MAP_TYPE(BPF_MAP_TYPE_DEVMAP, dev_map_ops)
 BPF_MAP_TYPE(BPF_MAP_TYPE_DEVMAP_HASH, dev_map_hash_ops)
 BPF_MAP_TYPE(BPF_MAP_TYPE_SK_STORAGE, sk_storage_map_ops)
+BPF_MAP_TYPE(BPF_MAP_TYPE_INODE_STORAGE, inode_storage_map_ops)
 #if defined(CONFIG_BPF_STREAM_PARSER)
 BPF_MAP_TYPE(BPF_MAP_TYPE_SOCKMAP, sock_map_ops)
 BPF_MAP_TYPE(BPF_MAP_TYPE_SOCKHASH, sock_hash_ops)
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 6218677daaa2..679a50562e72 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -148,6 +148,7 @@ enum bpf_map_type {
 	BPF_MAP_TYPE_DEVMAP_HASH,
 	BPF_MAP_TYPE_STRUCT_OPS,
 	BPF_MAP_TYPE_RINGBUF,
+	BPF_MAP_TYPE_INODE_STORAGE,
 };
 
 /* Note that tracing related programs such as
@@ -3252,6 +3253,41 @@ union bpf_attr {
  * 		case of **BPF_CSUM_LEVEL_QUERY**, the current skb->csum_level
  * 		is returned or the error code -EACCES in case the skb is not
  * 		subject to CHECKSUM_UNNECESSARY.
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
@@ -3389,7 +3425,9 @@ union bpf_attr {
 	FN(ringbuf_submit),		\
 	FN(ringbuf_discard),		\
 	FN(ringbuf_query),		\
-	FN(csum_level),
+	FN(csum_level),			\
+	FN(inode_storage_get),		\
+	FN(inode_storage_delete),
 
 /* integer value in 'imm' field of BPF_CALL instruction selects which helper
  * function eBPF program intends to call
diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
index 314a923569d5..572ed711c3fd 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -3,6 +3,7 @@
 #include "linux/bpf.h"
 #include "asm-generic/bug.h"
 #include "linux/err.h"
+#include "linux/fs.h"
 #include <linux/rculist.h>
 #include <linux/list.h>
 #include <linux/hash.h>
@@ -13,6 +14,7 @@
 #include <net/sock.h>
 #include <uapi/linux/sock_diag.h>
 #include <uapi/linux/btf.h>
+#include <linux/bpf_lsm.h>
 
 static atomic_t cache_idx;
 
@@ -26,6 +28,7 @@ struct bucket {
 
 enum bpf_local_storage_type {
 	BPF_LOCAL_STORAGE_SK,
+	BPF_LOCAL_STORAGE_INODE,
 };
 
 /* Thp map is not the primary owner of a bpf_local_storage_elem.
@@ -97,6 +100,7 @@ struct bpf_local_storage {
 	 */
 	union {
 		struct sock *sk;
+		struct inode *inode;
 	};
 	struct rcu_head rcu;
 	raw_spinlock_t lock;	/* Protect adding/removing from the "list" */
@@ -168,6 +172,8 @@ static struct bpf_local_storage_elem *sk_selem_alloc(
 static void __unlink_local_storage(struct bpf_local_storage *local_storage,
 				   bool uncharge_omem)
 {
+	struct bpf_storage_blob *bsb;
+	struct inode *inode;
 	struct sock *sk;
 
 	switch (local_storage->stype) {
@@ -181,6 +187,15 @@ static void __unlink_local_storage(struct bpf_local_storage *local_storage,
 		RCU_INIT_POINTER(sk->sk_bpf_storage, NULL);
 		local_storage->sk = NULL;
 		break;
+	case BPF_LOCAL_STORAGE_INODE:
+		inode = local_storage->inode;
+		bsb = bpf_inode(inode);
+		if (!bsb)
+			return;
+
+		RCU_INIT_POINTER(bsb->storage, NULL);
+		local_storage->inode = NULL;
+		break;
 	}
 }
 
@@ -341,6 +356,25 @@ sk_storage_lookup(struct sock *sk, struct bpf_map *map, bool cacheit_lockit)
 	return __local_storage_lookup(sk_storage, smap, cacheit_lockit);
 }
 
+static struct bpf_local_storage_data *inode_storage_lookup(
+	struct inode *inode, struct bpf_map *map, bool cacheit_lockit)
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
+	return __local_storage_lookup(inode_storage, smap, cacheit_lockit);
+}
+
 static int check_flags(const struct bpf_local_storage_data *old_sdata,
 		       u64 map_flags)
 {
@@ -437,6 +471,38 @@ static int sk_storage_alloc(struct sock *sk,
 	return err;
 }
 
+static int inode_storage_alloc(struct inode *inode,
+			       struct bpf_local_storage_map *smap,
+			       struct bpf_local_storage_elem *first_selem)
+{
+	struct bpf_storage_blob *bsb;
+	struct bpf_local_storage *curr;
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
+	curr->stype = BPF_LOCAL_STORAGE_INODE;
+
+	__selem_link(curr, first_selem);
+	selem_link_map(smap, first_selem);
+
+	err = publish_local_storage(first_selem,
+		(struct bpf_local_storage **)&bsb->storage, curr);
+	if (err) {
+		kfree(curr);
+		return err;
+	}
+
+	return 0;
+}
+
 static int check_update_flags(struct bpf_map *map, u64 map_flags)
 {
 	/* BPF_EXIST and BPF_NOEXIST cannot be both set */
@@ -453,6 +519,8 @@ static int map_to_storage_type(struct bpf_map *map)
 	switch (map->map_type) {
 	case BPF_MAP_TYPE_SK_STORAGE:
 		return BPF_LOCAL_STORAGE_SK;
+	case BPF_MAP_TYPE_INODE_STORAGE:
+		return BPF_LOCAL_STORAGE_INODE;
 	default:
 		return -EINVAL;
 	}
@@ -471,6 +539,8 @@ static struct bpf_local_storage_data *local_storage_update(
 	struct bpf_local_storage *local_storage;
 	struct bpf_local_storage_map *smap;
 	enum bpf_local_storage_type stype;
+	struct bpf_storage_blob *bsb;
+	struct inode *inode;
 	struct sock *sk;
 	int err;
 
@@ -489,6 +559,11 @@ static struct bpf_local_storage_data *local_storage_update(
 		sk = owner;
 		local_storage = rcu_dereference(sk->sk_bpf_storage);
 		break;
+	case BPF_LOCAL_STORAGE_INODE:
+		inode = owner;
+		bsb = bpf_inode(inode);
+		local_storage = rcu_dereference(bsb->storage);
+		break;
 	default:
 		WARN_ON_ONCE(1);
 		return ERR_PTR(-EINVAL);
@@ -513,6 +588,18 @@ static struct bpf_local_storage_data *local_storage_update(
 				return ERR_PTR(err);
 			}
 
+			return SDATA(selem);
+		case BPF_LOCAL_STORAGE_INODE:
+			selem = selem_alloc(smap, value);
+			if (!selem)
+				return ERR_PTR(-ENOMEM);
+
+			err = inode_storage_alloc(inode, smap, selem);
+			if (err) {
+				kfree(selem);
+				return ERR_PTR(err);
+			}
+
 			return SDATA(selem);
 		}
 	}
@@ -574,6 +661,13 @@ static struct bpf_local_storage_data *local_storage_update(
 			goto unlock_err;
 		}
 		break;
+	case BPF_LOCAL_STORAGE_INODE:
+		selem = selem_alloc(smap, value);
+		if (!selem) {
+			err = -ENOMEM;
+			goto unlock_err;
+		}
+		break;
 	}
 
 	/* First, link the new selem to the map */
@@ -610,6 +704,19 @@ static int sk_storage_delete(struct sock *sk, struct bpf_map *map)
 	return 0;
 }
 
+static int inode_storage_delete(struct inode *inode, struct bpf_map *map)
+{
+	struct bpf_local_storage_data *sdata;
+
+	sdata = inode_storage_lookup(inode, map, false);
+	if (!sdata)
+		return -ENOENT;
+
+	selem_unlink(SELEM(sdata));
+
+	return 0;
+}
+
 /* Called by __sk_destruct() & bpf_sk_storage_clone() */
 void bpf_sk_storage_free(struct sock *sk)
 {
@@ -649,6 +756,55 @@ void bpf_sk_storage_free(struct sock *sk)
 		kfree_rcu(sk_storage, rcu);
 }
 
+/* Called by __destroy_inode() */
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
+		selem_unlink_map(selem);
+		free_inode_storage =
+			__selem_unlink(local_storage, selem, false);
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
 static void bpf_local_storage_map_free(struct bpf_map *map)
 {
 	struct bpf_local_storage_elem *selem;
@@ -671,7 +827,7 @@ static void bpf_local_storage_map_free(struct bpf_map *map)
 	 *
 	 * The elem of this map can be cleaned up here
 	 * or by bpf_local_storage_free() during the destruction of the
-	 * owner object. eg. __sk_destruct.
+	 * owner object. eg. __sk_destruct or __destroy_inode.
 	 */
 	for (i = 0; i < (1U << smap->bucket_log); i++) {
 		b = &smap->buckets[i];
@@ -821,6 +977,21 @@ static void *bpf_sk_storage_lookup_elem(struct bpf_map *map, void *key)
 	return ERR_PTR(err);
 }
 
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
 static int bpf_sk_storage_update_elem(struct bpf_map *map, void *key,
 					 void *value, u64 map_flags)
 {
@@ -839,6 +1010,21 @@ static int bpf_sk_storage_update_elem(struct bpf_map *map, void *key,
 	return err;
 }
 
+static int bpf_inode_storage_update_elem(struct bpf_map *map, void *key,
+					 void *value, u64 map_flags)
+{
+	struct bpf_local_storage_data *sdata;
+	struct inode *inode;
+	int err = -EINVAL;
+
+	if (key) {
+		inode = *(struct inode **)(key);
+		sdata = local_storage_update(inode, map, value, map_flags);
+		return PTR_ERR_OR_ZERO(sdata);
+	}
+	return err;
+}
+
 static int bpf_sk_storage_delete_elem(struct bpf_map *map, void *key)
 {
 	struct socket *sock;
@@ -854,6 +1040,19 @@ static int bpf_sk_storage_delete_elem(struct bpf_map *map, void *key)
 	return err;
 }
 
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
 static struct bpf_local_storage_elem *
 bpf_sk_storage_clone_elem(struct sock *newsk,
 			  struct bpf_local_storage_map *smap,
@@ -975,6 +1174,27 @@ BPF_CALL_4(bpf_sk_storage_get, struct bpf_map *, map, struct sock *, sk,
 	return (unsigned long)NULL;
 }
 
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
+		sdata = local_storage_update(inode, map, value, BPF_NOEXIST);
+		return IS_ERR(sdata) ?
+			(unsigned long)NULL : (unsigned long)sdata->data;
+	}
+
+	return (unsigned long)NULL;
+}
+
 BPF_CALL_2(bpf_sk_storage_delete, struct bpf_map *, map, struct sock *, sk)
 {
 	if (refcount_inc_not_zero(&sk->sk_refcnt)) {
@@ -988,6 +1208,12 @@ BPF_CALL_2(bpf_sk_storage_delete, struct bpf_map *, map, struct sock *, sk)
 	return -ENOENT;
 }
 
+BPF_CALL_2(bpf_inode_storage_delete,
+	   struct bpf_map *, map, struct inode *, inode)
+{
+	return inode_storage_delete(inode, map);
+}
+
 const struct bpf_map_ops sk_storage_map_ops = {
 	.map_alloc_check = bpf_local_storage_map_alloc_check,
 	.map_alloc = bpf_local_storage_map_alloc,
@@ -999,6 +1225,17 @@ const struct bpf_map_ops sk_storage_map_ops = {
 	.map_check_btf = bpf_local_storage_map_check_btf,
 };
 
+const struct bpf_map_ops inode_storage_map_ops = {
+	.map_alloc_check = bpf_local_storage_map_alloc_check,
+	.map_alloc = bpf_local_storage_map_alloc,
+	.map_free = bpf_local_storage_map_free,
+	.map_get_next_key = notsupp_get_next_key,
+	.map_lookup_elem = bpf_inode_storage_lookup_elem,
+	.map_update_elem = bpf_inode_storage_update_elem,
+	.map_delete_elem = bpf_inode_storage_delete_elem,
+	.map_check_btf = bpf_local_storage_map_check_btf,
+};
+
 const struct bpf_func_proto bpf_sk_storage_get_proto = {
 	.func		= bpf_sk_storage_get,
 	.gpl_only	= false,
@@ -1017,6 +1254,28 @@ const struct bpf_func_proto bpf_sk_storage_delete_proto = {
 	.arg2_type	= ARG_PTR_TO_SOCKET,
 };
 
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
+	.func		= bpf_sk_storage_delete,
+	.gpl_only	= false,
+	.ret_type	= RET_INTEGER,
+	.arg1_type	= ARG_CONST_MAP_PTR,
+	.arg2_type	= ARG_PTR_TO_BTF_ID,
+	.btf_id		= bpf_inode_storage_delete_btf_ids,
+};
+
 struct bpf_sk_storage_diag {
 	u32 nr_maps;
 	struct bpf_map *maps[];
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 8da159936bab..a685ec4c7b99 100644
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
index 34cde841ab68..52936d24271d 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -4090,6 +4090,11 @@ static int check_map_func_compatibility(struct bpf_verifier_env *env,
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
@@ -4163,6 +4168,11 @@ static int check_map_func_compatibility(struct bpf_verifier_env *env,
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
diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
index c5fac8068ba1..e8fbafb3e87b 100644
--- a/tools/bpf/bpftool/map.c
+++ b/tools/bpf/bpftool/map.c
@@ -49,6 +49,7 @@ const char * const map_type_name[] = {
 	[BPF_MAP_TYPE_STACK]			= "stack",
 	[BPF_MAP_TYPE_SK_STORAGE]		= "sk_storage",
 	[BPF_MAP_TYPE_STRUCT_OPS]		= "struct_ops",
+	[BPF_MAP_TYPE_INODE_STORAGE]		= "inode_storage",
 };
 
 const size_t map_type_name_size = ARRAY_SIZE(map_type_name);
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 6218677daaa2..679a50562e72 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -148,6 +148,7 @@ enum bpf_map_type {
 	BPF_MAP_TYPE_DEVMAP_HASH,
 	BPF_MAP_TYPE_STRUCT_OPS,
 	BPF_MAP_TYPE_RINGBUF,
+	BPF_MAP_TYPE_INODE_STORAGE,
 };
 
 /* Note that tracing related programs such as
@@ -3252,6 +3253,41 @@ union bpf_attr {
  * 		case of **BPF_CSUM_LEVEL_QUERY**, the current skb->csum_level
  * 		is returned or the error code -EACCES in case the skb is not
  * 		subject to CHECKSUM_UNNECESSARY.
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
@@ -3389,7 +3425,9 @@ union bpf_attr {
 	FN(ringbuf_submit),		\
 	FN(ringbuf_discard),		\
 	FN(ringbuf_query),		\
-	FN(csum_level),
+	FN(csum_level),			\
+	FN(inode_storage_get),		\
+	FN(inode_storage_delete),
 
 /* integer value in 'imm' field of BPF_CALL instruction selects which helper
  * function eBPF program intends to call
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
2.27.0.111.gc72c7da667-goog

