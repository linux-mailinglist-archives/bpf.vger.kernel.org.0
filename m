Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 971502A49E6
	for <lists+bpf@lfdr.de>; Tue,  3 Nov 2020 16:32:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728499AbgKCPcI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 3 Nov 2020 10:32:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728878AbgKCPbm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 3 Nov 2020 10:31:42 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 400B7C0613D1
        for <bpf@vger.kernel.org>; Tue,  3 Nov 2020 07:31:40 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id c9so11643476wml.5
        for <bpf@vger.kernel.org>; Tue, 03 Nov 2020 07:31:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vLOO3traXYyd6kJvlmgBCGtZvU6A/Cmq/is6KWpr6wA=;
        b=K7y/J3Vv0R3fh1X0h/tBqyESgk8DqsrNEn5p8Dp3hrVxIDs9srKBL3vz21dx64iO4/
         oRC0Mxf7/ad08yknb6BP1N+Pxbwmxogl8uH/0GsWDl97vu/vZF+TrbVISwZPAnuyHECc
         KgI0ci1dcAFJcoEl9xFGOP8FpT4pPdWSHUGZo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vLOO3traXYyd6kJvlmgBCGtZvU6A/Cmq/is6KWpr6wA=;
        b=MfCcw2Ol0NMjMXg5SpVejT5/InqHBS+VN3QwejInGb7qusw5WghGxtlxrR7P72UK9a
         /4CthP0PVK5brphyGFjLmgFv7gMRJYxpuFaoCb/QVQrmKS4yP+gTyqApg01ya2JV+Vwt
         sVOtz5X+PWbgrGsV/gckRT+7DnGvZsoVMPesnLg1DM/dfcIB1qN/pTzTPnXCxfNpJ8tL
         Mx/wV9UaJ3oBK76WGnLVEVeGAsPJP7RTHMCnw0qZcwNqOkJh/ldzWr2X5LAzg1/S8NAV
         PiON2XhW3sn2N0H36OQHhpmpMRUxulwRW0n8ygzXDxw7SKY8i6lN4lZ3lZ83/matKqFj
         sSqA==
X-Gm-Message-State: AOAM533vM5vr5kKtL+W8qdwmn4Q6B4i5IkIJ73w34zNZuhwoh0orHl+t
        hIVyE2/jzOg9qyxtdrhZNHoqzA==
X-Google-Smtp-Source: ABdhPJzkskgoS6nzIj+0KPmI64t8QIYZPwjNTOk0If+Z2FNQMUSQHF2i2bhiAmOy1awQk9KBHlLcLg==
X-Received: by 2002:a1c:b70b:: with SMTP id h11mr291980wmf.185.1604417498760;
        Tue, 03 Nov 2020 07:31:38 -0800 (PST)
Received: from kpsingh.zrh.corp.google.com ([81.6.44.51])
        by smtp.gmail.com with ESMTPSA id m126sm2451966wmm.0.2020.11.03.07.31.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2020 07:31:38 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Paul Turner <pjt@google.com>,
        Jann Horn <jannh@google.com>, Hao Luo <haoluo@google.com>
Subject: [PATCH bpf-next v2 1/8] bpf: Implement task local storage
Date:   Tue,  3 Nov 2020 16:31:25 +0100
Message-Id: <20201103153132.2717326-2-kpsingh@chromium.org>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
In-Reply-To: <20201103153132.2717326-1-kpsingh@chromium.org>
References: <20201103153132.2717326-1-kpsingh@chromium.org>
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
 include/linux/bpf_lsm.h        |  23 +++
 include/linux/bpf_types.h      |   1 +
 include/uapi/linux/bpf.h       |  39 ++++
 kernel/bpf/Makefile            |   1 +
 kernel/bpf/bpf_lsm.c           |   4 +
 kernel/bpf/bpf_task_storage.c  | 313 +++++++++++++++++++++++++++++++++
 kernel/bpf/syscall.c           |   3 +-
 kernel/bpf/verifier.c          |  10 ++
 security/bpf/hooks.c           |   2 +
 tools/include/uapi/linux/bpf.h |  39 ++++
 10 files changed, 434 insertions(+), 1 deletion(-)
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
index e6ceac3f7d62..f4037b2161a6 100644
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
+ * void *bpf_task_storage_get(struct bpf_map *map, struct task_struct *task, void *value, u64 flags)
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
+ * long bpf_task_storage_delete(struct bpf_map *map, struct task_struct *task)
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
index 000000000000..f5ed5eedc532
--- /dev/null
+++ b/kernel/bpf/bpf_task_storage.c
@@ -0,0 +1,313 @@
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
+#include <linux/filter.h>
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
+	/* Neither the bpf_prog nor the bpf-map's syscall
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
+	unsigned int f_flags;
+	struct pid *pid;
+	int fd, err;
+
+	fd = *(int *)key;
+	pid = pidfd_get_pid(fd, &f_flags);
+	if (IS_ERR(pid))
+		return ERR_CAST(pid);
+
+	/* We should be in an RCU read side critical section, it should be safe
+	 * to call pid_task.
+	 */
+	WARN_ON_ONCE(!rcu_read_lock_held());
+	task = pid_task(pid, PIDTYPE_PID);
+	if (!task) {
+		err = -ENOENT;
+		goto out;
+	}
+
+	sdata = task_storage_lookup(task, map, true);
+	put_pid(pid);
+	return sdata ? sdata->data : NULL;
+out:
+	put_pid(pid);
+	return ERR_PTR(err);
+}
+
+static int bpf_pid_task_storage_update_elem(struct bpf_map *map, void *key,
+					    void *value, u64 map_flags)
+{
+	struct bpf_local_storage_data *sdata;
+	struct task_struct *task;
+	unsigned int f_flags;
+	struct pid *pid;
+	int fd, err;
+
+	fd = *(int *)key;
+	pid = pidfd_get_pid(fd, &f_flags);
+	if (IS_ERR(pid))
+		return PTR_ERR(pid);
+
+	/* We should be in an RCU read side critical section, it should be safe
+	 * to call pid_task.
+	 */
+	WARN_ON_ONCE(!rcu_read_lock_held());
+	task = pid_task(pid, PIDTYPE_PID);
+	if (!task) {
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
+	unsigned int f_flags;
+	struct pid *pid;
+	int fd, err;
+
+	fd = *(int *)key;
+	pid = pidfd_get_pid(fd, &f_flags);
+	if (IS_ERR(pid))
+		return PTR_ERR(pid);
+
+	/* We should be in an RCU read side critical section, it should be safe
+	 * to call pid_task.
+	 */
+	WARN_ON_ONCE(!rcu_read_lock_held());
+	task = pid_task(pid, PIDTYPE_PID);
+	if (!task) {
+		err = -ENOENT;
+		goto out;
+	}
+
+	err = task_storage_delete(task, map);
+out:
+	put_pid(pid);
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
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index e6ceac3f7d62..f4037b2161a6 100644
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
+ * void *bpf_task_storage_get(struct bpf_map *map, struct task_struct *task, void *value, u64 flags)
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
+ * long bpf_task_storage_delete(struct bpf_map *map, struct task_struct *task)
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
-- 
2.29.1.341.ge80a0c044ae-goog

