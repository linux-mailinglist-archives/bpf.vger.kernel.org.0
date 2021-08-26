Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B4393F8923
	for <lists+bpf@lfdr.de>; Thu, 26 Aug 2021 15:39:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242744AbhHZNkM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 26 Aug 2021 09:40:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242493AbhHZNkJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 26 Aug 2021 09:40:09 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07EE0C061757;
        Thu, 26 Aug 2021 06:39:22 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id n13-20020a17090a4e0d00b0017946980d8dso6595180pjh.5;
        Thu, 26 Aug 2021 06:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=n+CSO3Tk5RJvAuQKM7dCZIYomNFSoJBC2AhA0046028=;
        b=CPp9Q6ESc2IiXi6+kdQCYoJj/fEJVhz0WCKhdxqz84GoKop3UdjZcpjxWU6tYAPpKm
         2i3GWOc+lHZ5Zm27aAq7e89+CmY6DkRlDNhYD8xHNyzS0hCy++0xXFs0TB+mWJd5ODbg
         k/WxuDAKi+GUcwII8sBWClyPOPkldGjHbY//h2QRevS8ULbVd1QVqH3G6ZloLChbt3sD
         PNGKAV3WoioI2MMeuD7tltU+0PpmpHMQp3QxO1jshc+1UG7R2i17woK42eI5IkNmDvkV
         ak0QVKDMWYEud83gcPb5lW3E+9VoE1wEFgc7Jdv3UkarQyq+opsOyh2LFteC8Mzz5slU
         d3Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n+CSO3Tk5RJvAuQKM7dCZIYomNFSoJBC2AhA0046028=;
        b=PMmJhzchDgMeEhPH1h20EJOmz9DA1zpD2xsN3dHpLzhoY2Bi0KKUyJT79fCMTQwG6x
         Ml6tQvqzDq9hhTJ2gf3DzrAw5f/nXD+54YIezq6ktY6Ji982ocOk3jfTIBRzrC81bX/2
         C1JK5Sz6ruPyUZRANzIlBi9aELVr1WEfIuGiF3+gAn5GnRoiVaRKOa7Kh6semzhSTGpr
         UgEyIiNp6a7zqJvsK80TcFO19jfR1DvHD7vEmk4H5zq7K2MXpMIcNAkorbDSozbtWBmh
         5EArrBHIWsZ38xglZdWrMOEc+z8I0aqjWXOBxGS/vZQ6f4TCmB9Ha3moTCSRSx/KE2Wj
         WFUA==
X-Gm-Message-State: AOAM533/blJhx0tcveWSVM/TniASWg7D2PFEEzR9x0z+4F5gSKP/qvmq
        UF1VuSZMTCNd9VgertURYjV5kQumnzw=
X-Google-Smtp-Source: ABdhPJzuMFEdAhI+saEuELosBGgsVWQcefNgHOJhiv7743D8/LHSUqKXK7KGyoxVjSwolTQaKRUHCg==
X-Received: by 2002:a17:902:7611:b029:12c:b602:5820 with SMTP id k17-20020a1709027611b029012cb6025820mr3849299pll.6.1629985161309;
        Thu, 26 Aug 2021 06:39:21 -0700 (PDT)
Received: from localhost ([2405:201:6014:d820:9cc6:d37f:c2fd:dc6])
        by smtp.gmail.com with ESMTPSA id b21sm3072294pfl.83.2021.08.26.06.39.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Aug 2021 06:39:21 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Spencer Baugh <sbaugh@catern.com>,
        Pavel Emelyanov <ovzxemul@gmail.com>,
        Alexander Mihalicyn <alexander@mihalicyn.com>,
        Andrei Vagin <avagin@gmail.com>,
        linux-security-module@vger.kernel.org
Subject: [PATCH bpf-next v2 1/5] bpf: Implement file local storage
Date:   Thu, 26 Aug 2021 19:09:09 +0530
Message-Id: <20210826133913.627361-2-memxor@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210826133913.627361-1-memxor@gmail.com>
References: <20210826133913.627361-1-memxor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This map is useful in general to tie data associated with a open file
(not fd) from eBPF programs, such that data is released when the file
goes away (e.g. checkpoint/restore usecase).

Another usecase is implementing Capsicum [0] style capability sandbox in
userspace using eBPF LSM, enforcing rights at the file level using this
mechanism.

[0]: https://www.usenix.org/legacy/event/sec10/tech/full_papers/Watson.pdf

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf_lsm.h       |  21 +++
 include/linux/bpf_types.h     |   1 +
 include/uapi/linux/bpf.h      |  39 ++++++
 kernel/bpf/Makefile           |   2 +-
 kernel/bpf/bpf_file_storage.c | 244 ++++++++++++++++++++++++++++++++++
 kernel/bpf/bpf_lsm.c          |   4 +
 kernel/bpf/syscall.c          |   3 +-
 kernel/bpf/verifier.c         |  10 ++
 security/bpf/hooks.c          |   2 +
 9 files changed, 324 insertions(+), 2 deletions(-)
 create mode 100644 kernel/bpf/bpf_file_storage.c

diff --git a/include/linux/bpf_lsm.h b/include/linux/bpf_lsm.h
index 479c101546ad..5901a39cd5ac 100644
--- a/include/linux/bpf_lsm.h
+++ b/include/linux/bpf_lsm.h
@@ -42,6 +42,18 @@ extern const struct bpf_func_proto bpf_inode_storage_get_proto;
 extern const struct bpf_func_proto bpf_inode_storage_delete_proto;
 void bpf_inode_storage_free(struct inode *inode);
 
+static inline struct bpf_storage_blob *bpf_file(const struct file *file)
+{
+	if (unlikely(!file->f_security))
+		return NULL;
+
+	return file->f_security + bpf_lsm_blob_sizes.lbs_file;
+}
+
+extern const struct bpf_func_proto bpf_file_storage_get_proto;
+extern const struct bpf_func_proto bpf_file_storage_delete_proto;
+void bpf_file_storage_free(struct file *file);
+
 #else /* !CONFIG_BPF_LSM */
 
 static inline bool bpf_lsm_is_sleepable_hook(u32 btf_id)
@@ -65,6 +77,15 @@ static inline void bpf_inode_storage_free(struct inode *inode)
 {
 }
 
+static inline struct bpf_storage_blob *bpf_file(const struct file *file)
+{
+	return NULL;
+}
+
+static inline void bpf_file_storage_free(struct file *file)
+{
+}
+
 #endif /* CONFIG_BPF_LSM */
 
 #endif /* _LINUX_BPF_LSM_H */
diff --git a/include/linux/bpf_types.h b/include/linux/bpf_types.h
index 9c81724e4b98..c68cc6d9e7da 100644
--- a/include/linux/bpf_types.h
+++ b/include/linux/bpf_types.h
@@ -107,6 +107,7 @@ BPF_MAP_TYPE(BPF_MAP_TYPE_DEVMAP_HASH, dev_map_hash_ops)
 BPF_MAP_TYPE(BPF_MAP_TYPE_SK_STORAGE, sk_storage_map_ops)
 #ifdef CONFIG_BPF_LSM
 BPF_MAP_TYPE(BPF_MAP_TYPE_INODE_STORAGE, inode_storage_map_ops)
+BPF_MAP_TYPE(BPF_MAP_TYPE_FILE_STORAGE, file_storage_map_ops)
 #endif
 BPF_MAP_TYPE(BPF_MAP_TYPE_TASK_STORAGE, task_storage_map_ops)
 BPF_MAP_TYPE(BPF_MAP_TYPE_CPUMAP, cpu_map_ops)
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 791f31dd0abe..62aa1ff2dcfb 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -906,6 +906,7 @@ enum bpf_map_type {
 	BPF_MAP_TYPE_RINGBUF,
 	BPF_MAP_TYPE_INODE_STORAGE,
 	BPF_MAP_TYPE_TASK_STORAGE,
+	BPF_MAP_TYPE_FILE_STORAGE,
 };
 
 /* Note that tracing related programs such as
@@ -4877,6 +4878,42 @@ union bpf_attr {
  *		Get the struct pt_regs associated with **task**.
  *	Return
  *		A pointer to struct pt_regs.
+ *
+ * void *bpf_file_storage_get(struct bpf_map *map, void *file, void *value, u64 flags)
+ *	Description
+ *		Get a bpf_local_storage from a *file*.
+ *
+ *		Logically, it could be thought of as getting the value from
+ *		a *map* with *file* as the **key**.  From this
+ *		perspective,  the usage is not much different from
+ *		**bpf_map_lookup_elem**\ (*map*, **&**\ *file*) except this
+ *		helper enforces the key must be an file and the map must also
+ *		be a **BPF_MAP_TYPE_FILE_STORAGE**.
+ *
+ *		Underneath, the value is stored locally at *file* instead of
+ *		the *map*.  The *map* is used as the bpf-local-storage
+ *		"type". The bpf-local-storage "type" (i.e. the *map*) is
+ *		searched against all bpf_local_storage residing at *file*.
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
+ * int bpf_file_storage_delete(struct bpf_map *map, void *file)
+ *	Description
+ *		Delete a bpf_local_storage from a *file*.
+ *	Return
+ *		0 on success.
+ *
+ *		**-ENOENT** if the bpf_local_storage cannot be found.
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -5055,6 +5092,8 @@ union bpf_attr {
 	FN(get_func_ip),		\
 	FN(get_attach_cookie),		\
 	FN(task_pt_regs),		\
+	FN(file_storage_get),		\
+	FN(file_storage_delete),	\
 	/* */
 
 /* integer value in 'imm' field of BPF_CALL instruction selects which helper
diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
index 7f33098ca63f..98a18e402a0a 100644
--- a/kernel/bpf/Makefile
+++ b/kernel/bpf/Makefile
@@ -10,7 +10,7 @@ obj-$(CONFIG_BPF_SYSCALL) += syscall.o verifier.o inode.o helpers.o tnum.o bpf_i
 obj-$(CONFIG_BPF_SYSCALL) += hashtab.o arraymap.o percpu_freelist.o bpf_lru_list.o lpm_trie.o map_in_map.o
 obj-$(CONFIG_BPF_SYSCALL) += local_storage.o queue_stack_maps.o ringbuf.o
 obj-$(CONFIG_BPF_SYSCALL) += bpf_local_storage.o bpf_task_storage.o
-obj-${CONFIG_BPF_LSM}	  += bpf_inode_storage.o
+obj-${CONFIG_BPF_LSM}	  += bpf_inode_storage.o bpf_file_storage.o
 obj-$(CONFIG_BPF_SYSCALL) += disasm.o
 obj-$(CONFIG_BPF_JIT) += trampoline.o
 obj-$(CONFIG_BPF_SYSCALL) += btf.o
diff --git a/kernel/bpf/bpf_file_storage.c b/kernel/bpf/bpf_file_storage.c
new file mode 100644
index 000000000000..c826bc0405c4
--- /dev/null
+++ b/kernel/bpf/bpf_file_storage.c
@@ -0,0 +1,244 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/rculist.h>
+#include <linux/list.h>
+#include <linux/hash.h>
+#include <linux/types.h>
+#include <linux/filter.h>
+#include <linux/spinlock.h>
+#include <linux/bpf.h>
+#include <linux/bpf_local_storage.h>
+#include <uapi/linux/btf.h>
+#include <linux/bpf_lsm.h>
+#include <linux/btf_ids.h>
+
+DEFINE_BPF_STORAGE_CACHE(file_cache);
+
+static struct bpf_local_storage __rcu **file_storage_ptr(void *owner)
+{
+	struct bpf_storage_blob *bsb;
+	struct file *file = owner;
+
+	bsb = bpf_file(file);
+	if (!bsb)
+		return NULL;
+	return &bsb->storage;
+}
+
+static struct bpf_local_storage_data *
+file_storage_lookup(struct file *file, struct bpf_map *map, bool cacheit_lockit)
+{
+	struct bpf_local_storage *file_storage;
+	struct bpf_local_storage_map *smap;
+	struct bpf_storage_blob *bsb;
+
+	bsb = bpf_file(file);
+	if (!bsb)
+		return NULL;
+
+	file_storage = rcu_dereference(bsb->storage);
+	if (!file_storage)
+		return NULL;
+
+	smap = (struct bpf_local_storage_map *)map;
+	return bpf_local_storage_lookup(file_storage, smap, cacheit_lockit);
+}
+
+void bpf_file_storage_free(struct file *file)
+{
+	struct bpf_local_storage *local_storage;
+	struct bpf_local_storage_elem *selem;
+	bool free_file_storage = false;
+	struct bpf_storage_blob *bsb;
+	struct hlist_node *n;
+
+	bsb = bpf_file(file);
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
+	raw_spin_lock_bh(&local_storage->lock);
+	hlist_for_each_entry_safe(selem, n, &local_storage->list, snode) {
+		bpf_selem_unlink_map(selem);
+		free_file_storage = bpf_selem_unlink_storage_nolock(local_storage,
+								    selem, false);
+	}
+	raw_spin_unlock_bh(&local_storage->lock);
+	rcu_read_unlock();
+
+	if (free_file_storage)
+		kfree_rcu(local_storage, rcu);
+}
+
+static void *bpf_fd_file_storage_lookup_elem(struct bpf_map *map, void *key)
+{
+	struct bpf_local_storage_data *sdata;
+	struct file *file;
+	int fd;
+
+	fd = *(int *)key;
+	file = fget_raw(fd);
+	if (!file)
+		return ERR_PTR(-EBADF);
+
+	sdata = file_storage_lookup(file, map, true);
+	fput(file);
+	return sdata ? sdata->data : NULL;
+}
+
+static int bpf_fd_file_storage_update_elem(struct bpf_map *map, void *key,
+					   void *value, u64 map_flags)
+{
+	struct bpf_local_storage_data *sdata;
+	struct file *file;
+	int fd;
+
+	fd = *(int *)key;
+	file = fget_raw(fd);
+	if (!file)
+		return -EBADF;
+	if (!file_storage_ptr(file)) {
+		fput(file);
+		return -EBADF;
+	}
+
+	sdata = bpf_local_storage_update(file,
+					 (struct bpf_local_storage_map *)map,
+					 value, map_flags);
+	fput(file);
+	return PTR_ERR_OR_ZERO(sdata);
+}
+
+static int file_storage_delete(struct file *file, struct bpf_map *map)
+{
+	struct bpf_local_storage_data *sdata;
+
+	sdata = file_storage_lookup(file, map, false);
+	if (!sdata)
+		return -ENOENT;
+
+	bpf_selem_unlink(SELEM(sdata));
+
+	return 0;
+}
+
+static int bpf_fd_file_storage_delete_elem(struct bpf_map *map, void *key)
+{
+	struct file *file;
+	int fd, err;
+
+	fd = *(int *)key;
+	file = fget_raw(fd);
+	if (!file)
+		return -EBADF;
+
+	err = file_storage_delete(file, map);
+	fput(file);
+	return err;
+}
+
+BPF_CALL_4(bpf_file_storage_get, struct bpf_map *, map, struct file *, file,
+	   void *, value, u64, flags)
+{
+	struct bpf_local_storage_data *sdata;
+
+	if (flags & ~(BPF_LOCAL_STORAGE_GET_F_CREATE))
+		return (unsigned long)NULL;
+
+	if (!file || !file_storage_ptr(file))
+		return (unsigned long)NULL;
+
+	sdata = file_storage_lookup(file, map, true);
+	if (sdata)
+		return (unsigned long)sdata->data;
+
+	if (flags & BPF_LOCAL_STORAGE_GET_F_CREATE) {
+		sdata = bpf_local_storage_update(
+			file, (struct bpf_local_storage_map *)map, value,
+			BPF_NOEXIST);
+		return IS_ERR(sdata) ? (unsigned long)NULL :
+					     (unsigned long)sdata->data;
+	}
+
+	return (unsigned long)NULL;
+}
+
+BPF_CALL_2(bpf_file_storage_delete, struct bpf_map *, map, struct file *, file)
+{
+	if (!file)
+		return -EINVAL;
+
+	return file_storage_delete(file, map);
+}
+
+static int notsupp_get_next_key(struct bpf_map *map, void *key, void *next_key)
+{
+	return -ENOTSUPP;
+}
+
+static struct bpf_map *file_storage_map_alloc(union bpf_attr *attr)
+{
+	struct bpf_local_storage_map *smap;
+
+	smap = bpf_local_storage_map_alloc(attr);
+	if (IS_ERR(smap))
+		return ERR_CAST(smap);
+
+	smap->cache_idx = bpf_local_storage_cache_idx_get(&file_cache);
+	return &smap->map;
+}
+
+static void file_storage_map_free(struct bpf_map *map)
+{
+	struct bpf_local_storage_map *smap;
+
+	smap = (struct bpf_local_storage_map *)map;
+	bpf_local_storage_cache_idx_free(&file_cache, smap->cache_idx);
+	bpf_local_storage_map_free(smap, NULL);
+}
+
+static int file_storage_map_btf_id;
+
+const struct bpf_map_ops file_storage_map_ops = {
+	.map_meta_equal        = bpf_map_meta_equal,
+	.map_alloc_check       = bpf_local_storage_map_alloc_check,
+	.map_alloc             = file_storage_map_alloc,
+	.map_free              = file_storage_map_free,
+	.map_get_next_key      = notsupp_get_next_key,
+	.map_lookup_elem       = bpf_fd_file_storage_lookup_elem,
+	.map_update_elem       = bpf_fd_file_storage_update_elem,
+	.map_delete_elem       = bpf_fd_file_storage_delete_elem,
+	.map_check_btf         = bpf_local_storage_map_check_btf,
+	.map_btf_name          = "bpf_local_storage_map",
+	.map_btf_id            = &file_storage_map_btf_id,
+	.map_owner_storage_ptr = file_storage_ptr,
+};
+
+BTF_ID_LIST_SINGLE(bpf_file_storage_btf_ids, struct, file)
+
+const struct bpf_func_proto bpf_file_storage_get_proto = {
+	.func        = bpf_file_storage_get,
+	.gpl_only    = false,
+	.ret_type    = RET_PTR_TO_MAP_VALUE_OR_NULL,
+	.arg1_type   = ARG_CONST_MAP_PTR,
+	.arg2_type   = ARG_PTR_TO_BTF_ID,
+	.arg2_btf_id = &bpf_file_storage_btf_ids[0],
+	.arg3_type   = ARG_PTR_TO_MAP_VALUE_OR_NULL,
+	.arg4_type   = ARG_ANYTHING,
+};
+
+const struct bpf_func_proto bpf_file_storage_delete_proto = {
+	.func        = bpf_file_storage_delete,
+	.gpl_only    = false,
+	.ret_type    = RET_INTEGER,
+	.arg1_type   = ARG_CONST_MAP_PTR,
+	.arg2_type   = ARG_PTR_TO_BTF_ID,
+	.arg2_btf_id = &bpf_file_storage_btf_ids[0],
+};
diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
index 06062370c3b8..48c2022fd958 100644
--- a/kernel/bpf/bpf_lsm.c
+++ b/kernel/bpf/bpf_lsm.c
@@ -121,6 +121,10 @@ bpf_lsm_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_bprm_opts_set_proto;
 	case BPF_FUNC_ima_inode_hash:
 		return prog->aux->sleepable ? &bpf_ima_inode_hash_proto : NULL;
+	case BPF_FUNC_file_storage_get:
+		return &bpf_file_storage_get_proto;
+	case BPF_FUNC_file_storage_delete:
+		return &bpf_file_storage_delete_proto;
 	default:
 		return tracing_prog_func_proto(func_id, prog);
 	}
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 4e50c0bfdb7d..946a85945776 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -783,7 +783,8 @@ static int map_check_btf(struct bpf_map *map, const struct btf *btf,
 		    map->map_type != BPF_MAP_TYPE_CGROUP_STORAGE &&
 		    map->map_type != BPF_MAP_TYPE_SK_STORAGE &&
 		    map->map_type != BPF_MAP_TYPE_INODE_STORAGE &&
-		    map->map_type != BPF_MAP_TYPE_TASK_STORAGE)
+		    map->map_type != BPF_MAP_TYPE_TASK_STORAGE &&
+		    map->map_type != BPF_MAP_TYPE_FILE_STORAGE)
 			return -ENOTSUPP;
 		if (map->spin_lock_off + sizeof(struct bpf_spin_lock) >
 		    map->value_size) {
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 206c221453cf..c703d58681a8 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5390,6 +5390,11 @@ static int check_map_func_compatibility(struct bpf_verifier_env *env,
 		    func_id != BPF_FUNC_task_storage_delete)
 			goto error;
 		break;
+	case BPF_MAP_TYPE_FILE_STORAGE:
+		if (func_id != BPF_FUNC_file_storage_get &&
+		    func_id != BPF_FUNC_file_storage_delete)
+			goto error;
+		break;
 	default:
 		break;
 	}
@@ -5473,6 +5478,11 @@ static int check_map_func_compatibility(struct bpf_verifier_env *env,
 		if (map->map_type != BPF_MAP_TYPE_TASK_STORAGE)
 			goto error;
 		break;
+	case BPF_FUNC_file_storage_get:
+	case BPF_FUNC_file_storage_delete:
+		if (map->map_type != BPF_MAP_TYPE_FILE_STORAGE)
+			goto error;
+		break;
 	default:
 		break;
 	}
diff --git a/security/bpf/hooks.c b/security/bpf/hooks.c
index e5971fa74fd7..faa70467db4d 100644
--- a/security/bpf/hooks.c
+++ b/security/bpf/hooks.c
@@ -13,6 +13,7 @@ static struct security_hook_list bpf_lsm_hooks[] __lsm_ro_after_init = {
 	#undef LSM_HOOK
 	LSM_HOOK_INIT(inode_free_security, bpf_inode_storage_free),
 	LSM_HOOK_INIT(task_free, bpf_task_storage_free),
+	LSM_HOOK_INIT(file_free_security, bpf_file_storage_free),
 };
 
 static int __init bpf_lsm_init(void)
@@ -25,6 +26,7 @@ static int __init bpf_lsm_init(void)
 struct lsm_blob_sizes bpf_lsm_blob_sizes __lsm_ro_after_init = {
 	.lbs_inode = sizeof(struct bpf_storage_blob),
 	.lbs_task = sizeof(struct bpf_storage_blob),
+	.lbs_file = sizeof(struct bpf_storage_blob),
 };
 
 DEFINE_LSM(bpf) = {
-- 
2.33.0

