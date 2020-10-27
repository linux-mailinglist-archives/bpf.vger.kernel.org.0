Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB97629BF9D
	for <lists+bpf@lfdr.de>; Tue, 27 Oct 2020 18:07:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1815654AbgJ0RDu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 27 Oct 2020 13:03:50 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:40252 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1815582AbgJ0RD1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 27 Oct 2020 13:03:27 -0400
Received: by mail-ed1-f67.google.com with SMTP id p93so2201184edd.7
        for <bpf@vger.kernel.org>; Tue, 27 Oct 2020 10:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Zp59KCD8sk+WI1Qt3/6v9uMdfR897YQpYeg3YMt2W7Y=;
        b=PvFOq5nduCLB34mh3vazruxOqEwE+CSEewGQ6lV3pbI+m7DMb/7TC/2JZubzilIhWC
         VqINDUCausv2X8K1oto2qxPDFNRFy7j8rtr4AXg/iVBcvvso36+67E4ujmq8VFwWMWsz
         tK9AIN0VFUwuUUg2nEiFEYgW5BspGSkctRXSE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Zp59KCD8sk+WI1Qt3/6v9uMdfR897YQpYeg3YMt2W7Y=;
        b=s8FeGhneWNklO9K//oYNSx9BRDFYbZFcZvcb7kJlCmSa2lEGcURgenU+9xeWJt79Ao
         onDvqBG8tdSj9NDckp8BMBSaUG7cK/rAsbtJl1x7wvDeImLvkq3B/w/YNE0XqlekzXMR
         Lf9+cnrJBPygLnlOG52avlFwj1ad/wjO4lhdaouYVIsqQlb/PCxbLGrgVqZ8JZAtDGEk
         XUHFopmrrQtTcBW3LSZUmoRDx3iz4lD6QsNaGntRMzpzqEZ2qtwK+XgTUu5YzDorGbHa
         S6O336N6nZKHdJM18ALa6K3s5pLPeYgtp4Ua6L8Ew6d7Vh1exCi6ubeNk/I2TZ2idreG
         WnXQ==
X-Gm-Message-State: AOAM533THibseUVcrgwFg55WiOOPNCn2L8hIkIf3zY7wSNxassTm2795
        ZcqGuRYLfflyTyrDH2X4kBdopw==
X-Google-Smtp-Source: ABdhPJzeJByiJ1ZTNf5Q9w15Tc/6SjiPqKt5MmZpv45fR73oD26jfb1teMDpZ6P8sFJvWDEtsq47yg==
X-Received: by 2002:a05:6402:d0d:: with SMTP id eb13mr3292164edb.244.1603818202570;
        Tue, 27 Oct 2020 10:03:22 -0700 (PDT)
Received: from kpsingh.zrh.corp.google.com ([81.6.44.51])
        by smtp.gmail.com with ESMTPSA id ba6sm1315006edb.61.2020.10.27.10.03.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 10:03:21 -0700 (PDT)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Hao Luo <haoluo@google.com>
Subject: [PATCH bpf-next 1/5] bpf: Implement task local storage
Date:   Tue, 27 Oct 2020 18:03:13 +0100
Message-Id: <20201027170317.2011119-2-kpsingh@chromium.org>
X-Mailer: git-send-email 2.29.0.rc2.309.g374f81d7ae-goog
In-Reply-To: <20201027170317.2011119-1-kpsingh@chromium.org>
References: <20201027170317.2011119-1-kpsingh@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: KP Singh <kpsingh@google.com>

Similar to bpf_local_storage for sockets and inodes add local storage
for task_struct.

The life-cycle of storage is managed with the life-cycle of the
task_struct.  i.e. the storage is destroyed along with the owning task
with a callback to the bpf_task_storage_free from the task_free LSM
hook.

The BPF LSM allocates an __rcu pointer to the bpf_local_storage in
the security blob which are now stackable and can co-exist with other
LSMs.

The userspace map operations can be done by using a pid fd as a key
passed to the lookup, update and delete operations.

Signed-off-by: KP Singh <kpsingh@google.com>
---
 include/linux/bpf_lsm.h                       |  23 ++
 include/linux/bpf_types.h                     |   1 +
 include/uapi/linux/bpf.h                      |  39 +++
 kernel/bpf/Makefile                           |   1 +
 kernel/bpf/bpf_lsm.c                          |   4 +
 kernel/bpf/bpf_task_storage.c                 | 327 ++++++++++++++++++
 kernel/bpf/syscall.c                          |   3 +-
 kernel/bpf/verifier.c                         |  10 +
 security/bpf/hooks.c                          |   2 +
 .../bpf/bpftool/Documentation/bpftool-map.rst |   3 +-
 tools/bpf/bpftool/bash-completion/bpftool     |   2 +-
 tools/bpf/bpftool/map.c                       |   4 +-
 tools/include/uapi/linux/bpf.h                |  39 +++
 tools/lib/bpf/libbpf_probes.c                 |   2 +
 14 files changed, 456 insertions(+), 4 deletions(-)
 create mode 100644 kernel/bpf/bpf_task_storage.c

diff --git a/include/linux/bpf_lsm.h b/include/linux/bpf_lsm.h
index aaacb6aafc87..326cb68a3632 100644
--- a/include/linux/bpf_lsm.h
+++ b/include/linux/bpf_lsm.h
@@ -7,6 +7,7 @@
 #ifndef _LINUX_BPF_LSM_H
 #define _LINUX_BPF_LSM_H
 
+#include "linux/sched.h"
 #include <linux/bpf.h>
 #include <linux/lsm_hooks.h>
 
@@ -35,9 +36,21 @@ static inline struct bpf_storage_blob *bpf_inode(
 	return inode->i_security + bpf_lsm_blob_sizes.lbs_inode;
 }
 
+static inline struct bpf_storage_blob *bpf_task(
+	const struct task_struct *task)
+{
+	if (unlikely(!task->security))
+		return NULL;
+
+	return task->security + bpf_lsm_blob_sizes.lbs_task;
+}
+
 extern const struct bpf_func_proto bpf_inode_storage_get_proto;
 extern const struct bpf_func_proto bpf_inode_storage_delete_proto;
+extern const struct bpf_func_proto bpf_task_storage_get_proto;
+extern const struct bpf_func_proto bpf_task_storage_delete_proto;
 void bpf_inode_storage_free(struct inode *inode);
+void bpf_task_storage_free(struct task_struct *task);
 
 #else /* !CONFIG_BPF_LSM */
 
@@ -53,10 +66,20 @@ static inline struct bpf_storage_blob *bpf_inode(
 	return NULL;
 }
 
+static inline struct bpf_storage_blob *bpf_task(
+	const struct task_struct *task)
+{
+	return NULL;
+}
+
 static inline void bpf_inode_storage_free(struct inode *inode)
 {
 }
 
+static inline void bpf_task_storage_free(struct task_struct *task)
+{
+}
+
 #endif /* CONFIG_BPF_LSM */
 
 #endif /* _LINUX_BPF_LSM_H */
diff --git a/include/linux/bpf_types.h b/include/linux/bpf_types.h
index 2e6f568377f1..99f7fd657d87 100644
--- a/include/linux/bpf_types.h
+++ b/include/linux/bpf_types.h
@@ -109,6 +109,7 @@ BPF_MAP_TYPE(BPF_MAP_TYPE_SOCKHASH, sock_hash_ops)
 #endif
 #ifdef CONFIG_BPF_LSM
 BPF_MAP_TYPE(BPF_MAP_TYPE_INODE_STORAGE, inode_storage_map_ops)
+BPF_MAP_TYPE(BPF_MAP_TYPE_TASK_STORAGE, task_storage_map_ops)
 #endif
 BPF_MAP_TYPE(BPF_MAP_TYPE_CPUMAP, cpu_map_ops)
 #if defined(CONFIG_XDP_SOCKETS)
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index e6ceac3f7d62..bb443c4f3637 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -157,6 +157,7 @@ enum bpf_map_type {
 	BPF_MAP_TYPE_STRUCT_OPS,
 	BPF_MAP_TYPE_RINGBUF,
 	BPF_MAP_TYPE_INODE_STORAGE,
+	BPF_MAP_TYPE_TASK_STORAGE,
 };
 
 /* Note that tracing related programs such as
@@ -3742,6 +3743,42 @@ union bpf_attr {
  * 	Return
  * 		The helper returns **TC_ACT_REDIRECT** on success or
  * 		**TC_ACT_SHOT** on error.
+ *
+ * void *bpf_task_storage_get(struct bpf_map *map, void *task, void *value, u64 flags)
+ *	Description
+ *		Get a bpf_local_storage from the *task*.
+ *
+ *		Logically, it could be thought of as getting the value from
+ *		a *map* with *task* as the **key**.  From this
+ *		perspective,  the usage is not much different from
+ *		**bpf_map_lookup_elem**\ (*map*, **&**\ *task*) except this
+ *		helper enforces the key must be an task_struct and the map must also
+ *		be a **BPF_MAP_TYPE_TASK_STORAGE**.
+ *
+ *		Underneath, the value is stored locally at *task* instead of
+ *		the *map*.  The *map* is used as the bpf-local-storage
+ *		"type". The bpf-local-storage "type" (i.e. the *map*) is
+ *		searched against all bpf_local_storage residing at *task*.
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
+ * int bpf_task_storage_delete(struct bpf_map *map, void *task)
+ *	Description
+ *		Delete a bpf_local_storage from a *task*.
+ *	Return
+ *		0 on success.
+ *
+ *		**-ENOENT** if the bpf_local_storage cannot be found.
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -3900,6 +3937,8 @@ union bpf_attr {
 	FN(bpf_per_cpu_ptr),            \
 	FN(bpf_this_cpu_ptr),		\
 	FN(redirect_peer),		\
+	FN(task_storage_get),		\
+	FN(task_storage_delete),	\
 	/* */
 
 /* integer value in 'imm' field of BPF_CALL instruction selects which helper
diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
index bdc8cd1b6767..f0b93ced5a7f 100644
--- a/kernel/bpf/Makefile
+++ b/kernel/bpf/Makefile
@@ -6,6 +6,7 @@ obj-$(CONFIG_BPF_SYSCALL) += syscall.o verifier.o inode.o helpers.o tnum.o bpf_i
 obj-$(CONFIG_BPF_SYSCALL) += hashtab.o arraymap.o percpu_freelist.o bpf_lru_list.o lpm_trie.o map_in_map.o
 obj-$(CONFIG_BPF_SYSCALL) += local_storage.o queue_stack_maps.o ringbuf.o
 obj-${CONFIG_BPF_LSM}	  += bpf_inode_storage.o
+obj-${CONFIG_BPF_LSM}	  += bpf_task_storage.o
 obj-$(CONFIG_BPF_SYSCALL) += disasm.o
 obj-$(CONFIG_BPF_JIT) += trampoline.o
 obj-$(CONFIG_BPF_SYSCALL) += btf.o
diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
index 78ea8a7bd27f..61f8cc52fd5b 100644
--- a/kernel/bpf/bpf_lsm.c
+++ b/kernel/bpf/bpf_lsm.c
@@ -59,6 +59,10 @@ bpf_lsm_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_sk_storage_get_proto;
 	case BPF_FUNC_sk_storage_delete:
 		return &bpf_sk_storage_delete_proto;
+	case BPF_FUNC_task_storage_get:
+		return &bpf_task_storage_get_proto;
+	case BPF_FUNC_task_storage_delete:
+		return &bpf_task_storage_delete_proto;
 	default:
 		return tracing_prog_func_proto(func_id, prog);
 	}
diff --git a/kernel/bpf/bpf_task_storage.c b/kernel/bpf/bpf_task_storage.c
new file mode 100644
index 000000000000..774140c458cc
--- /dev/null
+++ b/kernel/bpf/bpf_task_storage.c
@@ -0,0 +1,327 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2019 Facebook
+ * Copyright 2020 Google LLC.
+ */
+
+#include "linux/pid.h"
+#include "linux/sched.h"
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
+DEFINE_BPF_STORAGE_CACHE(task_cache);
+
+static struct bpf_local_storage __rcu **task_storage_ptr(void *owner)
+{
+	struct task_struct *task = owner;
+	struct bpf_storage_blob *bsb;
+
+	bsb = bpf_task(task);
+	if (!bsb)
+		return NULL;
+	return &bsb->storage;
+}
+
+static struct bpf_local_storage_data *
+task_storage_lookup(struct task_struct *task, struct bpf_map *map,
+		    bool cacheit_lockit)
+{
+	struct bpf_local_storage *task_storage;
+	struct bpf_local_storage_map *smap;
+	struct bpf_storage_blob *bsb;
+
+	bsb = bpf_task(task);
+	if (!bsb)
+		return NULL;
+
+	task_storage = rcu_dereference(bsb->storage);
+	if (!task_storage)
+		return NULL;
+
+	smap = (struct bpf_local_storage_map *)map;
+	return bpf_local_storage_lookup(task_storage, smap, cacheit_lockit);
+}
+
+void bpf_task_storage_free(struct task_struct *task)
+{
+	struct bpf_local_storage_elem *selem;
+	struct bpf_local_storage *local_storage;
+	bool free_task_storage = false;
+	struct bpf_storage_blob *bsb;
+	struct hlist_node *n;
+
+	bsb = bpf_task(task);
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
+		free_task_storage = bpf_selem_unlink_storage_nolock(
+			local_storage, selem, false);
+	}
+	raw_spin_unlock_bh(&local_storage->lock);
+	rcu_read_unlock();
+
+	/* free_task_storage should always be true as long as
+	 * local_storage->list was non-empty.
+	 */
+	if (free_task_storage)
+		kfree_rcu(local_storage, rcu);
+}
+
+static void *bpf_pid_task_storage_lookup_elem(struct bpf_map *map, void *key)
+{
+	struct bpf_local_storage_data *sdata;
+	struct task_struct *task;
+	struct pid *pid;
+	struct file *f;
+	int fd, err;
+
+	fd = *(int *)key;
+	f = fget_raw(fd);
+	if (!f)
+		return ERR_PTR(-EBADF);
+
+	if (f->f_op != &pidfd_fops) {
+		err = -EBADF;
+		goto out_fput;
+	}
+
+	pid = get_pid(f->private_data);
+	task = get_pid_task(pid, PIDTYPE_PID);
+	if (!task || !task_storage_ptr(task)) {
+		err = -ENOENT;
+		goto out;
+	}
+
+	sdata = task_storage_lookup(task, map, true);
+	put_pid(pid);
+	return sdata ? sdata->data : NULL;
+out:
+	put_pid(pid);
+out_fput:
+	fput(f);
+	return ERR_PTR(err);
+}
+
+static int bpf_pid_task_storage_update_elem(struct bpf_map *map, void *key,
+					    void *value, u64 map_flags)
+{
+	struct bpf_local_storage_data *sdata;
+	struct task_struct *task;
+	struct pid *pid;
+	struct file *f;
+	int fd, err;
+
+	fd = *(int *)key;
+	f = fget_raw(fd);
+	if (!f)
+		return -EBADF;
+
+	if (f->f_op != &pidfd_fops) {
+		err = -EBADF;
+		goto out_fput;
+	}
+
+	pid = get_pid(f->private_data);
+	task = get_pid_task(pid, PIDTYPE_PID);
+	if (!task || !task_storage_ptr(task)) {
+		err = -ENOENT;
+		goto out;
+	}
+
+	sdata = bpf_local_storage_update(
+		task, (struct bpf_local_storage_map *)map, value, map_flags);
+
+	err = PTR_ERR_OR_ZERO(sdata);
+out:
+	put_pid(pid);
+out_fput:
+	fput(f);
+	return err;
+}
+
+static int task_storage_delete(struct task_struct *task, struct bpf_map *map)
+{
+	struct bpf_local_storage_data *sdata;
+
+	sdata = task_storage_lookup(task, map, false);
+	if (!sdata)
+		return -ENOENT;
+
+	bpf_selem_unlink(SELEM(sdata));
+
+	return 0;
+}
+
+static int bpf_pid_task_storage_delete_elem(struct bpf_map *map, void *key)
+{
+	struct task_struct *task;
+	struct pid *pid;
+	struct file *f;
+	int fd, err;
+
+	fd = *(int *)key;
+	f = fget_raw(fd);
+	if (!f)
+		return -EBADF;
+
+	if (f->f_op != &pidfd_fops) {
+		err = -EBADF;
+		goto out_fput;
+	}
+
+	pid = get_pid(f->private_data);
+	task = get_pid_task(pid, PIDTYPE_PID);
+	if (!task || !task_storage_ptr(task)) {
+		err = -ENOENT;
+		goto out;
+	}
+
+	err = task_storage_delete(task, map);
+
+out:
+	put_pid(pid);
+out_fput:
+	fput(f);
+	return err;
+}
+
+BPF_CALL_4(bpf_task_storage_get, struct bpf_map *, map, struct task_struct *,
+	   task, void *, value, u64, flags)
+{
+	struct bpf_local_storage_data *sdata;
+
+	if (flags & ~(BPF_LOCAL_STORAGE_GET_F_CREATE))
+		return (unsigned long)NULL;
+
+	/* explicitly check that the task_storage_ptr is not
+	 * NULL as task_storage_lookup returns NULL in this case and
+	 * bpf_local_storage_update expects the owner to have a
+	 * valid storage pointer.
+	 */
+	if (!task_storage_ptr(task))
+		return (unsigned long)NULL;
+
+	sdata = task_storage_lookup(task, map, true);
+	if (sdata)
+		return (unsigned long)sdata->data;
+
+	/* This helper must only called from where the task is guaranteed
+	 * to have a refcount and cannot be freed.
+	 */
+	if (flags & BPF_LOCAL_STORAGE_GET_F_CREATE) {
+		sdata = bpf_local_storage_update(
+			task, (struct bpf_local_storage_map *)map, value,
+			BPF_NOEXIST);
+		return IS_ERR(sdata) ? (unsigned long)NULL :
+					     (unsigned long)sdata->data;
+	}
+
+	return (unsigned long)NULL;
+}
+
+BPF_CALL_2(bpf_task_storage_delete, struct bpf_map *, map, struct task_struct *,
+	   task)
+{
+	/* This helper must only called from where the task is guaranteed
+	 * to have a refcount and cannot be freed.
+	 */
+	return task_storage_delete(task, map);
+}
+
+static int notsupp_get_next_key(struct bpf_map *map, void *key, void *next_key)
+{
+	return -ENOTSUPP;
+}
+
+static struct bpf_map *task_storage_map_alloc(union bpf_attr *attr)
+{
+	struct bpf_local_storage_map *smap;
+
+	smap = bpf_local_storage_map_alloc(attr);
+	if (IS_ERR(smap))
+		return ERR_CAST(smap);
+
+	smap->cache_idx = bpf_local_storage_cache_idx_get(&task_cache);
+	return &smap->map;
+}
+
+static void task_storage_map_free(struct bpf_map *map)
+{
+	struct bpf_local_storage_map *smap;
+
+	smap = (struct bpf_local_storage_map *)map;
+	bpf_local_storage_cache_idx_free(&task_cache, smap->cache_idx);
+	bpf_local_storage_map_free(smap);
+}
+
+static int task_storage_map_btf_id;
+const struct bpf_map_ops task_storage_map_ops = {
+	.map_meta_equal = bpf_map_meta_equal,
+	.map_alloc_check = bpf_local_storage_map_alloc_check,
+	.map_alloc = task_storage_map_alloc,
+	.map_free = task_storage_map_free,
+	.map_get_next_key = notsupp_get_next_key,
+	.map_lookup_elem = bpf_pid_task_storage_lookup_elem,
+	.map_update_elem = bpf_pid_task_storage_update_elem,
+	.map_delete_elem = bpf_pid_task_storage_delete_elem,
+	.map_check_btf = bpf_local_storage_map_check_btf,
+	.map_btf_name = "bpf_local_storage_map",
+	.map_btf_id = &task_storage_map_btf_id,
+	.map_owner_storage_ptr = task_storage_ptr,
+};
+
+BTF_ID_LIST_SINGLE(bpf_task_storage_btf_ids, struct, task_struct)
+
+const struct bpf_func_proto bpf_task_storage_get_proto = {
+	.func = bpf_task_storage_get,
+	.gpl_only = false,
+	.ret_type = RET_PTR_TO_MAP_VALUE_OR_NULL,
+	.arg1_type = ARG_CONST_MAP_PTR,
+	.arg2_type = ARG_PTR_TO_BTF_ID,
+	.arg2_btf_id = &bpf_task_storage_btf_ids[0],
+	.arg3_type = ARG_PTR_TO_MAP_VALUE_OR_NULL,
+	.arg4_type = ARG_ANYTHING,
+};
+
+const struct bpf_func_proto bpf_task_storage_delete_proto = {
+	.func = bpf_task_storage_delete,
+	.gpl_only = false,
+	.ret_type = RET_INTEGER,
+	.arg1_type = ARG_CONST_MAP_PTR,
+	.arg2_type = ARG_PTR_TO_BTF_ID,
+	.arg2_btf_id = &bpf_task_storage_btf_ids[0],
+};
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 8f50c9c19f1b..f3fe9f53f93c 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -773,7 +773,8 @@ static int map_check_btf(struct bpf_map *map, const struct btf *btf,
 		    map->map_type != BPF_MAP_TYPE_ARRAY &&
 		    map->map_type != BPF_MAP_TYPE_CGROUP_STORAGE &&
 		    map->map_type != BPF_MAP_TYPE_SK_STORAGE &&
-		    map->map_type != BPF_MAP_TYPE_INODE_STORAGE)
+		    map->map_type != BPF_MAP_TYPE_INODE_STORAGE &&
+		    map->map_type != BPF_MAP_TYPE_TASK_STORAGE)
 			return -ENOTSUPP;
 		if (map->spin_lock_off + sizeof(struct bpf_spin_lock) >
 		    map->value_size) {
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 6200519582a6..b0790876694f 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -4469,6 +4469,11 @@ static int check_map_func_compatibility(struct bpf_verifier_env *env,
 		    func_id != BPF_FUNC_inode_storage_delete)
 			goto error;
 		break;
+	case BPF_MAP_TYPE_TASK_STORAGE:
+		if (func_id != BPF_FUNC_task_storage_get &&
+		    func_id != BPF_FUNC_task_storage_delete)
+			goto error;
+		break;
 	default:
 		break;
 	}
@@ -4547,6 +4552,11 @@ static int check_map_func_compatibility(struct bpf_verifier_env *env,
 		if (map->map_type != BPF_MAP_TYPE_INODE_STORAGE)
 			goto error;
 		break;
+	case BPF_FUNC_task_storage_get:
+	case BPF_FUNC_task_storage_delete:
+		if (map->map_type != BPF_MAP_TYPE_TASK_STORAGE)
+			goto error;
+		break;
 	default:
 		break;
 	}
diff --git a/security/bpf/hooks.c b/security/bpf/hooks.c
index 788667d582ae..e5971fa74fd7 100644
--- a/security/bpf/hooks.c
+++ b/security/bpf/hooks.c
@@ -12,6 +12,7 @@ static struct security_hook_list bpf_lsm_hooks[] __lsm_ro_after_init = {
 	#include <linux/lsm_hook_defs.h>
 	#undef LSM_HOOK
 	LSM_HOOK_INIT(inode_free_security, bpf_inode_storage_free),
+	LSM_HOOK_INIT(task_free, bpf_task_storage_free),
 };
 
 static int __init bpf_lsm_init(void)
@@ -23,6 +24,7 @@ static int __init bpf_lsm_init(void)
 
 struct lsm_blob_sizes bpf_lsm_blob_sizes __lsm_ro_after_init = {
 	.lbs_inode = sizeof(struct bpf_storage_blob),
+	.lbs_task = sizeof(struct bpf_storage_blob),
 };
 
 DEFINE_LSM(bpf) = {
diff --git a/tools/bpf/bpftool/Documentation/bpftool-map.rst b/tools/bpf/bpftool/Documentation/bpftool-map.rst
index dade10cdf295..3d52256ba75f 100644
--- a/tools/bpf/bpftool/Documentation/bpftool-map.rst
+++ b/tools/bpf/bpftool/Documentation/bpftool-map.rst
@@ -50,7 +50,8 @@ MAP COMMANDS
 |		| **lru_percpu_hash** | **lpm_trie** | **array_of_maps** | **hash_of_maps**
 |		| **devmap** | **devmap_hash** | **sockmap** | **cpumap** | **xskmap** | **sockhash**
 |		| **cgroup_storage** | **reuseport_sockarray** | **percpu_cgroup_storage**
-|		| **queue** | **stack** | **sk_storage** | **struct_ops** | **ringbuf** | **inode_storage** }
+|		| **queue** | **stack** | **sk_storage** | **struct_ops** | **ringbuf** | **inode_storage**
+		| **task_storage** }
 
 DESCRIPTION
 ===========
diff --git a/tools/bpf/bpftool/bash-completion/bpftool b/tools/bpf/bpftool/bash-completion/bpftool
index 3f1da30c4da6..fdffbc64c65c 100644
--- a/tools/bpf/bpftool/bash-completion/bpftool
+++ b/tools/bpf/bpftool/bash-completion/bpftool
@@ -705,7 +705,7 @@ _bpftool()
                                 hash_of_maps devmap devmap_hash sockmap cpumap \
                                 xskmap sockhash cgroup_storage reuseport_sockarray \
                                 percpu_cgroup_storage queue stack sk_storage \
-                                struct_ops inode_storage' -- \
+                                struct_ops inode_storage task_storage' -- \
                                                    "$cur" ) )
                             return 0
                             ;;
diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
index a7efbd84fbcc..b400364ee054 100644
--- a/tools/bpf/bpftool/map.c
+++ b/tools/bpf/bpftool/map.c
@@ -51,6 +51,7 @@ const char * const map_type_name[] = {
 	[BPF_MAP_TYPE_STRUCT_OPS]		= "struct_ops",
 	[BPF_MAP_TYPE_RINGBUF]			= "ringbuf",
 	[BPF_MAP_TYPE_INODE_STORAGE]		= "inode_storage",
+	[BPF_MAP_TYPE_TASK_STORAGE]		= "task_storage",
 };
 
 const size_t map_type_name_size = ARRAY_SIZE(map_type_name);
@@ -1464,7 +1465,8 @@ static int do_help(int argc, char **argv)
 		"                 lru_percpu_hash | lpm_trie | array_of_maps | hash_of_maps |\n"
 		"                 devmap | devmap_hash | sockmap | cpumap | xskmap | sockhash |\n"
 		"                 cgroup_storage | reuseport_sockarray | percpu_cgroup_storage |\n"
-		"                 queue | stack | sk_storage | struct_ops | ringbuf | inode_storage }\n"
+		"                 queue | stack | sk_storage | struct_ops | ringbuf | inode_storage |\n"
+		"		  task_storage }\n"
 		"       " HELP_SPEC_OPTIONS "\n"
 		"",
 		bin_name, argv[-2]);
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index e6ceac3f7d62..bb443c4f3637 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -157,6 +157,7 @@ enum bpf_map_type {
 	BPF_MAP_TYPE_STRUCT_OPS,
 	BPF_MAP_TYPE_RINGBUF,
 	BPF_MAP_TYPE_INODE_STORAGE,
+	BPF_MAP_TYPE_TASK_STORAGE,
 };
 
 /* Note that tracing related programs such as
@@ -3742,6 +3743,42 @@ union bpf_attr {
  * 	Return
  * 		The helper returns **TC_ACT_REDIRECT** on success or
  * 		**TC_ACT_SHOT** on error.
+ *
+ * void *bpf_task_storage_get(struct bpf_map *map, void *task, void *value, u64 flags)
+ *	Description
+ *		Get a bpf_local_storage from the *task*.
+ *
+ *		Logically, it could be thought of as getting the value from
+ *		a *map* with *task* as the **key**.  From this
+ *		perspective,  the usage is not much different from
+ *		**bpf_map_lookup_elem**\ (*map*, **&**\ *task*) except this
+ *		helper enforces the key must be an task_struct and the map must also
+ *		be a **BPF_MAP_TYPE_TASK_STORAGE**.
+ *
+ *		Underneath, the value is stored locally at *task* instead of
+ *		the *map*.  The *map* is used as the bpf-local-storage
+ *		"type". The bpf-local-storage "type" (i.e. the *map*) is
+ *		searched against all bpf_local_storage residing at *task*.
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
+ * int bpf_task_storage_delete(struct bpf_map *map, void *task)
+ *	Description
+ *		Delete a bpf_local_storage from a *task*.
+ *	Return
+ *		0 on success.
+ *
+ *		**-ENOENT** if the bpf_local_storage cannot be found.
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -3900,6 +3937,8 @@ union bpf_attr {
 	FN(bpf_per_cpu_ptr),            \
 	FN(bpf_this_cpu_ptr),		\
 	FN(redirect_peer),		\
+	FN(task_storage_get),		\
+	FN(task_storage_delete),	\
 	/* */
 
 /* integer value in 'imm' field of BPF_CALL instruction selects which helper
diff --git a/tools/lib/bpf/libbpf_probes.c b/tools/lib/bpf/libbpf_probes.c
index 5482a9b7ae2d..bed00ca194f0 100644
--- a/tools/lib/bpf/libbpf_probes.c
+++ b/tools/lib/bpf/libbpf_probes.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
 /* Copyright (c) 2019 Netronome Systems, Inc. */
 
+#include "linux/bpf.h"
 #include <errno.h>
 #include <fcntl.h>
 #include <string.h>
@@ -230,6 +231,7 @@ bool bpf_probe_map_type(enum bpf_map_type map_type, __u32 ifindex)
 		break;
 	case BPF_MAP_TYPE_SK_STORAGE:
 	case BPF_MAP_TYPE_INODE_STORAGE:
+	case BPF_MAP_TYPE_TASK_STORAGE:
 		btf_key_type_id = 1;
 		btf_value_type_id = 3;
 		value_size = 8;
-- 
2.29.0.rc2.309.g374f81d7ae-goog

